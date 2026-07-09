Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511CCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whq36-0002Rv-2K; Thu, 09 Jul 2026 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whq34-0002RW-TW
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:48:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whq32-0004Qf-RD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:48:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Dw1IP1883875
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 14:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bZVq9cWuLvNiJKw17a9QT46rjDSH8VKY9euYuZPyTaw=; b=EEXCrvjNi6Ts6GZc
 qPH9LW7L976cZM6Pyo0Fo5N/l+q+XYR6jAl5x+48bw9CI/RAB9F03eG5uHp/ds1e
 URbf3wZHSzABXN0KFYBbCYz7isP1dYuJKZbe/yUcexRN2tiWHGxZce9pxMfy9+P8
 A1A5A5lG9TgUoEHeNGHrMF+In+xakMD5Zt4OMyziyI6zh3F6kY3uAqYcYb1f2xC8
 qflhWFRHlAdSejbR+CpbPJDNqZqH1MBRdwWyrIUdtlwL2XyAw4GpKAJAgbySwpnY
 gJXcRkaMM0NFJJmuj/2MdnxJntD0/3JCvJAOhlgou+UnC24x7Ek0h57ZBlskMi4j
 47iD8g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydua7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:48:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso1867581a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783608497; x=1784213297; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bZVq9cWuLvNiJKw17a9QT46rjDSH8VKY9euYuZPyTaw=;
 b=iFr7P7Pv/y3d/IYT2BwuZHO14HjQce4G04vOAssBRRd4YyctggFyIEwpmbdII4et0N
 66CVSx684znN5Gp2g3dsjY7g1B0XVIEF5EvnlqkMOAG5oLrrfTXvyNgvvGgGw12Eo2Ib
 61/vWARVnXY8A5RUFYQdepZ8gQa0UPICNDRXDwwOfAPMOLiR/sTZUxeB5RXLZdESnUnF
 6LsHo3YUIg6x9SoDTEdQ+TcR1RmjI7bhljn+CL/8Vfqvv/OWge6GKYolai5z30SVBXcD
 5T2Z/BjgZr0j5o0Y3UOda04qxGgqGZ23Jg9IzyhwsZRiMUPlNm0c53N/SzCT99K6Y/ZH
 at6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608497; x=1784213297;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZVq9cWuLvNiJKw17a9QT46rjDSH8VKY9euYuZPyTaw=;
 b=PrfX6o9/7+fCtCMA9Ev6dc0+G5yPbztrAXoocSi8N1CKy1DNRqXcYJtVQcTxJ2pp5V
 K/quFAkzMltjxc9kK5uJmJ4hYAEr7BiozBSrbtiGeszPszJxd1KZ60QKVTsd9bBfWJmY
 4Rpi9tHOdUnUsQsgQ157gA0RncC6GzhGlRsXIWqHnOxv+3TN6Px18Pu28tYc3YxK6SbN
 YTw9zmkKJj7LHiblQzbNpJrSbWhRTy69/1nK3seqnippnzHVt2Q7DrlJdflxy6v+B5iN
 rNfJRphbueX9siM/7ZNe1qvfS7cvQQWHf1ShjCElW4sB1Vq6pcXW6boMTR5s2cJp7HZV
 GQIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8hW7QB0Nae6mhptr6U3awlnE+sAzU4WsRKpBHgZ5VNZ3aGPcz9iUFWTqjbtbO27KbHysjJ3tENPkg@nongnu.org
X-Gm-Message-State: AOJu0YzEhcKmUhUp381Pk/D3v/t6Yq2aXs+igNHGYhWREgY9sb5b5PoE
 NNoi/DA/D1nvuGi9bsptr9ccZmRxJxTOUfmGePFT9lQtkfYpa4tjNZltUQ4RJMeJFmq10MV0I0I
 kF1bEU56syEL+Kt8sogAO4vH9giOEggW1cYrULWnVuAZpCaW+k3i3jE2C8g==
X-Gm-Gg: AfdE7clDdH/Ik9JJQFnvNMPaun/eK7gMAT1Q7GngQBPwCxOxAKHMmiEhEd1geMRGd1S
 WreARkaNumFweS/TXrlOyQyrXoX9xcvD0OkCPSdYssIta/Y5/OnGtbcXlGMdbVdzxoqF7HEM6Oo
 0YCy+f4Zvyvgcy1pWKWwChb6BqZtUnjWl0mg3Iw3tjEOspydV4c4d1CNrzo9io+JaNTs5bF6SJZ
 DC4aUPLhNGNqydgiZDPaVJ+OHXnlS6Rn+Ic4tsbFE0vUb4/taPq6Xd2497oebwAUt19xtVGEkdi
 V11pnGza65wCQee2ivQGq2zZ0pW3pbzwnjnV9/+vP7txFjGKJJ9TXiz4Xb17oUsfDr55RGqemtb
 Ip9U8b52oCMK3NzTGkacKgoAbk1OnzfdFMk37FmWBe/cpG45l3tjqXXm91eICmvcxi0Us1liVGF
 mN6ws=
X-Received: by 2002:a05:6a20:bea6:b0:3bf:b885:2fae with SMTP id
 adf61e73a8af0-3c0bcc0aec6mr8263920637.56.1783608496661; 
 Thu, 09 Jul 2026 07:48:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:bea6:b0:3bf:b885:2fae with SMTP id
 adf61e73a8af0-3c0bcc0aec6mr8263873637.56.1783608496025; 
 Thu, 09 Jul 2026 07:48:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm22923046eec.20.2026.07.09.07.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:48:15 -0700 (PDT)
Message-ID: <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 07:48:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260210163556.713841-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX+jgdl/oN5Agu
 Gg6nt4cNwJ7l0T1Yr81JRp0ME+JPWGRCkoTwx3BHWF2nHwWF+jU2zNR0DDZvVCorY/rRBqfIkiy
 eZ38tFjX54hb5XMV1tCjH7ko7EEBRN8=
X-Proofpoint-ORIG-GUID: Wx4-nqHW4qW132sNSsPrgvQjseVQQhwu
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4fb4b1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8hG23R3pAAAA:20 a=20KFwNOVAAAA:8 a=6508XR_vrpcv8PFJ1OEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Wx4-nqHW4qW132sNSsPrgvQjseVQQhwu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX73p8NFjUGSxx
 TkjWpFCSUk2H4BPHjEy/jIgaKJjggDlJLogCX38gDNovCk7/D60bG6xnSwrWmTOXE6JXNKfTRiN
 fa+cJE9kuMX6Vq5FHgG5/3zsn9OpJ9GU28fzsvrtDk1j/q+1qQiuslld9a5yaLLeCt6ZjrIfded
 1B0Qmc/Ki1+XexDln/mGe3Ch+4YAiCqFk8JPrEpCRrbVf+VitcAEgQGitXevZlewxiatRcIRzHp
 JJX6CCNwTbKXibGCururifpBl9SHuii+RUIAs6PFvnSRHCP0Jgl1jjvZuYIBDptmBcTeXhdagfP
 juIX1BKqRF+Y3iSY4sK83hVQzqSGSpT7roQJ0NXMrXHqoT58us2Oef9HrlpA4Ftaz+jG9yqXNDG
 7mfQgbg6bkN7S3LvBHze/Le20f05KBeVqlD67bpHDscdPffNGQOb+Sc++v3FX3jtniyr3pv/wyn
 rUrdxqYL2/OJHyNNAlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
> When a developer's environment is already within a podman container it
> is not possible to use 'podman' again to create containers. It will
> usually result in wierd errors such as:
> 
>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
> 
> Podman offers the ability to talk to a daemon outside the container,
> however, which could be leveraged by QEMU.
> 
> This can be used by invoking "podman --remote", or equivalently the
> separate "podman-remote" binary:
> 
>   https://github.com/containers/podman/blob/main/docs/tutorials/remote_client.md
> 
> The current 'podman version' check is insufficient to detect the
> inability to launch containers, so it is replaced with the stronger
> 'podman info' check.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/docker/docker.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ff68c7bf6f..9e18b984f4 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -76,14 +76,16 @@ def _guess_engine_command():
>      commands = []
>  
>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
> -        commands += [["podman"]]
> +        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
>      if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
>          commands += [["docker"], ["sudo", "-n", "docker"]]
>      for cmd in commands:
>          try:
> -            # docker version will return the client details in stdout
> -            # but still report a status of 1 if it can't contact the daemon
> -            if subprocess.call(cmd + ["version"],
> +            # 'version' is not sufficient to prove a working binary
> +            # for podman. 'info' is a stronger check that is more
> +            # likely to correlate with ability to create containers,
> +            # and required to detect the need for podman remote
> +            if subprocess.call(cmd + ["info"],
>                                 stdout=DEVNULL, stderr=DEVNULL) == 0:
>                  return cmd
>          except OSError:

Taking a look at why tcg tests are slow to compile, I reached this
commit. It seems like that calling 'podman info' is 5 to 10 times slower
than calling 'podman version'.
Thus, a container run now takes +1s when it was 0.2 before.

On my setup, podman (remote) version fails correctly if it can't
establish a connection.

The commit description briefly says
```
The current 'podman version' check is insufficient to detect the
inability to launch containers, so it is replaced with the stronger
'podman info' check.
```
but it's not what I observed.

Do you have more information about what is the exact reason we can't use
'podman version' for podman-remote?

Regards,
Pierrick

