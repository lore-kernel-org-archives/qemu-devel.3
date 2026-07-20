Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2DAC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrqb-0001YC-MV; Mon, 20 Jul 2026 13:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wlrqZ-0001WJ-Vg
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:32:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wlrqX-0001Qq-29
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:32:07 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6aHa3338636
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mt3LKU8Wm0ow7dJvqiSdA3wL
 LDdEHtXC8G3HYUw9Sy8=; b=HqdMVC2Ygw0rCwK+Fm2JzIwr++wS28b12JxOujvU
 QKmjJZ8yosXckb4g1NzxzwZMRgklJsUGGaRLJL8mjm8rPzY14b7NOmP7owL+FgZD
 U+aTzfFF5fVmuY0hG1lVlfkj7rhLsX+m8wWNOvR6abVkeTEfTTAbH5FrCPjZQkCK
 aKjjJKS6HHq8wj0kVcZ0vwxg+8GkUICc44++MTf3Tb6y+SIQ3rZ9cDUE0RIBG9md
 u+6nNcbcEPgAX0lFFfSWoVIPV4Lew8MGEyT2m4JbAjZeBQwxTlXbfpLxBVcRkjwi
 fI/X7W8nnAI/L5Ns6Z1b/L7u/KtJaykJgxfJYkSdlyQb3g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqff07x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:32:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e8004d60eso1579256085a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784568722; x=1785173522; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mt3LKU8Wm0ow7dJvqiSdA3wLLDdEHtXC8G3HYUw9Sy8=;
 b=gRvqfi+4oJPLLJVaPhSRwfdb/Qtk4YeP/txjVg2Pc/qk00BT6+NtPodCRfhtzN/ka0
 sDLjR6sFW92ZLXZn2zBlOCZ0EqxBhFGZjrPa9m32V/VhLOrkqn/ijE3EsWBnoIFObEXy
 hlURruIcgInVyeVIsTMNZU6ExIFnc3tn/lGNclFzZa98CEMbM4yRklO2UpyHkZS1xIbX
 QjMtYFhoIHcmkkn+CN7wuClLI6HXWENgGSsjq5U/Y0bbJ5brcmxAIVVS7pkqn/Jazqsb
 ZK4koYSGiVpHaiyQlx2l/eH/TCA5AaafUw4H/HuqV61tTw5p5GH2sCKbQhjsEfyweYP/
 xRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784568722; x=1785173522;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mt3LKU8Wm0ow7dJvqiSdA3wLLDdEHtXC8G3HYUw9Sy8=;
 b=OfN+dpM1vQWjA0uY/9l9evTV9WiIxkTWQZHtRMXp3Bn4OHkg8uJH97C+70oznWJQ/N
 wb+5ClvKGXF1JeLIQu7Q/7YcapR5vZ4T52Rj+oqv52UFAlumTNRFvJ444lZ1wBnsf1XO
 FnUeOULcaYA/fFaLkaQT0cUjY7wGm/08kM0YLE9Hg8ElW9iQF5fvbfDyPuJyqOV8HsAB
 7jxx/QCz9iYu3pzW/GvB0Au81Gjz9kQWLWmNb4mYN/xG96PcwFqFqAW8QFAbEbw+E1YX
 41kgDNvopjpnZLAsBKa4h+xLlEW3GKFSa0RdFVPWLXgCmmctfHDsphOQzudE4jFBUhHI
 KVQQ==
X-Gm-Message-State: AOJu0YzfFx3Mii185P4xg3dWUTAF30/cvxzV2kutG9gO+o4MNQYx2F1I
 xllLQB2QQRPeEeWlne+ccXgzGX5rf6hjv84+2XKi0FMsGc4jCsSmEay1z/S+S22JTkaAmuw0DHB
 GbT49H4rRdVZoI2+1uifeGS9q12fCWPGtY8wXwdAJi+DSBnT9ViyVJVnM5g==
X-Gm-Gg: AfdE7cl0oDWpb3hkLED+CRuQE3sc9MpjPB+OpbPKwGeTJEUgpU7+d0U3dnfJQm+oL8c
 /I2yPDIV4LUE6/6Zfs2s3someQRGMGZ0fEZkYrgU1UIikyVAmQr++4+0v6JmWAhqfUszXeGcxZH
 +UQPIYswTM9XwZMADGKpoS3jH46sIfo4uVdAN07edxbwdU+NIYgeIN9Zgt7VlSMKEDPm3jrbi4C
 hBQDKFznZECxuHuiEbpEP7Gw/vqvS+HLFIoMvne8OAneaLmmov6AilbqnuqfLLzHN3GglC3gIck
 XLPKGGb7q83PUvSPkuz2ewwEoKCltEZb2hjQDavTdZJfWRVrJKyPv1lC1FEIyeX2vUOky5UtBmk
 X81YRyqdZqXEexj4aYtIRt1a6ff6B7JeIqVgjH0ugCSGfN+PJ3x5PeP23dtwcYG//
X-Received: by 2002:a05:620a:40d1:b0:92e:daed:8198 with SMTP id
 af79cd13be357-930b41fac01mr1462220985a.77.1784568722402; 
 Mon, 20 Jul 2026 10:32:02 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:92e:daed:8198 with SMTP id
 af79cd13be357-930b41fac01mr1462217985a.77.1784568721992; 
 Mon, 20 Jul 2026 10:32:01 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52fb1fdsm933445785a.13.2026.07.20.10.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 10:32:01 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------cpvgHAP0C9mvDDZal7FAkxQS"
Message-ID: <bff082da-d3c4-4753-9f84-2a9632fb9fe9@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:31:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target/hexagon: fix PC not advancing for non-COF
 TB-ending packets
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-3-brian.cain@oss.qualcomm.com>
 <CAATN3NrrFdrU7Be=q+nSH6s-r0Bixh3qetEOL-+ov+F8o7HiWg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAATN3NrrFdrU7Be=q+nSH6s-r0Bixh3qetEOL-+ov+F8o7HiWg@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfXyCo08JIBY57b
 V23ILxJ0sLIQMixz7yoT9kBO3iLmfPoyMsYFdvm0O/geLJCRoFS3r+/WXE1iXhw8K6NRQSQynZN
 UE/A/n1xbxQzixpTeJgkgOT3WrGf9jU=
X-Proofpoint-GUID: x_ASQbWgKkCMx4kJL3yv3BSwQWScUl98
X-Authority-Analysis: v=2.4 cv=FJErAeos c=1 sm=1 tr=0 ts=6a5e5b93 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2ir0iUzkT0P_RRevgN0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8 a=O3CUUbHeB49wmNQa41IA:9
 a=DPuulOpbijoFcKyy:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX3HpI3bP0i9bh
 6ocEgJGqum83TmnJhxuDgqnPVI08DcTYlUGrKbhnkMnTa3jRbnfBCN7juhmcFh/wAQXTRXKqgBZ
 E1TFggf8KiRfFK7JzI139Gebhrd4H8g8eOBci0xJV81USVANelAVGFj8ENbZON2Pqj+qrg/Imvu
 Zk+sxPL3oaPhUiCsdEa3tnffeyBDPoVm2MeDJ7qJJUFyIcalNxKWY8p6egmauyaU1sS1OtiXbTn
 qm+SNXonlvpmqf3Z9pSpqZ5rXzp+IMwzkuXD7Ut+RnLhjkvsFyT6GoT/rVyiptaIckj7iWxVjot
 ix77ER9oNHJRHtvLQefHT6SeIVvlXe0zykHKRv8sRasOgbhOfC2NZsrxqrFOgZguVs9s9vz+6uU
 x0/OogF0kZ7/aa4T3ZI7R7weRcnPKpvBQyX6Qpy/pVcQvT9WbHuV2z4hWcDZ/dkGXJS/lxNSYJv
 53S5TrsUHTFfYUsqvfQ==
X-Proofpoint-ORIG-GUID: x_ASQbWgKkCMx4kJL3yv3BSwQWScUl98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------cpvgHAP0C9mvDDZal7FAkxQS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/19/2026 4:31 PM, Taylor Simpson wrote:
>
>
> On Wed, Jul 15, 2026 at 12:57 PM Brian Cain 
> <brian.cain@oss.qualcomm.com> wrote:
>
>     Add hex_next_PC, a global mirroring CPUHexagonState::next_PC,
>     and ctx->need_next_pc, so that gen_write_new_pc_addr() can write the
>     branch target through hex_next_PC instead of hex_gpr[HEX_REG_PC]
>     when a later unconditional write of PC is expected. gen_end_tb()
>     then commits hex_next_PC into hex_gpr[HEX_REG_PC] at the end of the
>     packet.
>
>     Previously, non-COF instructions that still end a TB did not
>     advance the
>     PC, since next_PC's value was never written back into the PC register.
>
>     Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>     Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>     ---
>      target/hexagon/translate.h |  3 +++
>      target/hexagon/genptr.c    | 14 ++++++++---
>      target/hexagon/translate.c | 51
>     ++++++++++++++++++++++++++------------
>      3 files changed, 49 insertions(+), 19 deletions(-)
>
>
>     @@ -1327,6 +1344,8 @@ void hexagon_translate_init(void)
>          }
>          hex_new_value_usr = tcg_global_mem_new(tcg_env,
>              offsetof(CPUHexagonState, new_value_usr), "new_value_usr");
>     +    hex_next_PC = tcg_global_mem_new(tcg_env,
>     +        offsetof(CPUHexagonState, next_PC), "next_PC");
>
>
> This only lives within the context of a single packet, so it shouldn't 
> be global.
>
> Put it into DisasContext and make it a tmp similar to new_value.


Taylor - this patch was included for the sake of testing the l2vic 
series, but landed recently - 
https://lore.kernel.org/qemu-devel/20260720100107.GA816167@fedora/

So I'll send a new independent series with updates suggested for 
"target/hexagon: fix PC not advancing for non-COF TB-ending packets" and 
"target/hexagon: initialize deferred sreg-write temps to current value".

-Brian

--------------cpvgHAP0C9mvDDZal7FAkxQS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/19/2026 4:31 PM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAATN3NrrFdrU7Be=q+nSH6s-r0Bixh3qetEOL-+ov+F8o7HiWg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Wed, Jul 15, 2026 at
            12:57 PM Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add
            hex_next_PC, a global mirroring CPUHexagonState::next_PC,<br>
            and ctx-&gt;need_next_pc, so that gen_write_new_pc_addr()
            can write the<br>
            branch target through hex_next_PC instead of
            hex_gpr[HEX_REG_PC]<br>
            when a later unconditional write of PC is expected.
            gen_end_tb()<br>
            then commits hex_next_PC into hex_gpr[HEX_REG_PC] at the end
            of the<br>
            packet.<br>
            <br>
            Previously, non-COF instructions that still end a TB did not
            advance the<br>
            PC, since next_PC's value was never written back into the PC
            register.<br>
            <br>
            Reviewed-by: Pierrick Bouvier &lt;<a
              href="mailto:pierrick.bouvier@oss.qualcomm.com"
              target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>
            Signed-off-by: Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;<br>
            ---<br>
             target/hexagon/translate.h |  3 +++<br>
             target/hexagon/genptr.c    | 14 ++++++++---<br>
             target/hexagon/translate.c | 51
            ++++++++++++++++++++++++++------------<br>
             3 files changed, 49 insertions(+), 19 deletions(-)<br>
            <br>
            <br>
            @@ -1327,6 +1344,8 @@ void hexagon_translate_init(void)<br>
                 }<br>
                 hex_new_value_usr = tcg_global_mem_new(tcg_env,<br>
                     offsetof(CPUHexagonState, new_value_usr),
            "new_value_usr");<br>
            +    hex_next_PC = tcg_global_mem_new(tcg_env,<br>
            +        offsetof(CPUHexagonState, next_PC), "next_PC");<br>
          </blockquote>
          <div><br>
          </div>
          <div>This only lives within the context of a single packet, so
            it shouldn't be global.</div>
          <div><br>
          </div>
          <div>Put it into DisasContext and make it a tmp similar to
            new_value.</div>
          <div> </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Taylor - this patch was included for the sake of testing the
      l2vic series, but landed recently -
      <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20260720100107.GA816167@fedora/">https://lore.kernel.org/qemu-devel/20260720100107.GA816167@fedora/</a></p>
    <p>So I'll send a new independent series with updates suggested for
      "target/hexagon: fix PC not advancing for non-COF TB-ending
      packets" and "target/hexagon: initialize deferred sreg-write temps
      to current value".</p>
    <p>-Brian</p>
  </body>
</html>

--------------cpvgHAP0C9mvDDZal7FAkxQS--

