Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34A4CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHOJI-0000m4-Op; Thu, 15 Oct 2026 12:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHOJH-0000lv-MF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:28:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHOJF-0000rm-Ho
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:28:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFmrDp2114176
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DyXw4oeGv0wTogzCnv3XzCij
 IYnhB+JrY1KfHRlW020=; b=gtRDVbYCgENGRqreFnCCVSLokfCRVmtG0n+a1926
 CeRE0URpipDb3Ra0I1ILIrI+h98cm4k/iC/EL5POncHqVUV5bIziTyxR+N1m8+ea
 KxelJl62C941eBjEQ+xSEjU88nIi4gJy+pevNHnq2qT2cCt6tXmn0LrCLz0o5aaF
 XknALFjEviHEOTOvY3WWBn1bC7LVe68LKV4Aq/TtcN20K1+UUy06GY/tx9EppMmd
 sfP/0HRTSjoIPu723LxF/zp+/ATLty6NuDJDySk2ZUyl2pxv/h4ih43Aqfm0Wwy6
 dV+dO0BU9utWnsIF/hVJg3+CiKaheh8RKBAtdhOAsSt9MQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyc1nf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:27:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934956beec8so333357285a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792081678; x=1792686478; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DyXw4oeGv0wTogzCnv3XzCijIYnhB+JrY1KfHRlW020=;
 b=HUdZo1qOyIMgtXykVJCS9O1BYwKdV7R/0d+ACBGXER6zywmMATcemX8Nn0LvSLfj+Q
 sfASKMqZQCGdPcaQMlfkKkjWGiuAoPvknM/HKfvYk1Xyhf7X8U0G8VgSJjJuRTgp2WuM
 wZLPvXBzOC6a6fS/LpAI8KdH4usI34/AwNN3cbzSygF7FF7ASMk8DSEY8duBdyAAqUnD
 5jr3EFSxEfxMEF4eWvfNvaKkruAW60v5IhlfoqU758ZZFyM7ZoKjLVwP55P8K2iPPU/Z
 31eQKjRU3dDUgR9yU+rc4FPN8WwNVnxdenlF3lXm0JZoO22wv6CKlKhSg2SQ7GLclPpo
 +GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081678; x=1792686478;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DyXw4oeGv0wTogzCnv3XzCijIYnhB+JrY1KfHRlW020=;
 b=jxZD0eukedFgebPkf0IIvtTG7NwjkIWyYkuNDuLI7xMrRff9BzCGjovxP4VpOQIU3E
 sZH2g+TO8va7zpYT8AHkAtHWHOSN53bcqZ2tyomAtEWD3MVXOT5XOztnUAdJ6I6HPTGh
 peth8eNRsQKIyn8SuxeFuIsZ7ybz0YxN/Hcj5RwwmLSKr23ijpovHOJuZva4gUJG5Glw
 xxqrnr98HvuZsKr0LY5x1ZJm1G4eFBtCsHgAWnJ7hlFcz7O6LIHyZinQhURm/a/Q8+CD
 JJQhHK+GkYLLIze/CM2yBoFApDnHurSkS+/9SfSdjbkUW17mQ59c5jw5X80WaCA1yxP+
 bFfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy772HDzElYviZYbFaasMOXfulouVnTpxqdhp9Qe0DdWywwrnHYd/U5HWv6EWNMNmgoyblQvTFA8zu3@nongnu.org
X-Gm-Message-State: AFq9FYK//7GvYoo+pcoOtcbhf9ewAoZlVVNy/oCV8Zcdciz5zriLPET3
 Y+hzY7C5e/y8B08Xaa1MRFGgjQn3FBEG1Q9nYNuicqMz6wHpDq8m6uDKmNjxvK1ajvmXvzggbQ8
 XN+S5GQMtCX2EQB26opVmuxKd1hsJIoAlLbShSoa2neWJTgLnk7OekCtkQQ==
X-Gm-Gg: AYBFou1dOT5JQLS0tb8PbyjRjfZ2H4WP/JJcYjx2OSZOKkJjOP8uKliTnzqfvXLW2Gp
 p7svkNvUxha5SVwFYpPa4cQRaBxD/j8O4I2YLgOgVAL9QrAQBIj6sqrX0nyeq+ymNbsHxQlZfEz
 nsr7GrSNbihNkxyk2fbFCKj2fVY9hNb3bj2A+aGK8xfWs0zu4/88m780aq0HgNPRg5CSexdQr2x
 ujEYxKiwZ6FfmTBH1JvErvB1PEZiRza0pmqVahZWvdjMOdU2NzBHqUAjose0x3DvyPBchFeIQYg
 SF1GpxuSG3pYabUxqA/SfRbcwFfSC5YM2NbmpGs0UUK3yuOIWsfpPZtUx6OaIxwrU7oNsOwEIvQ
 o3+i3h4slj9NiLlH9ljtzBv0LnFAH/zC+miiGUcf5ZflRfEHDsYJVt2YYsP9ouE9W
X-Received: by 2002:a05:620a:7007:b0:93f:cbd:8e20 with SMTP id
 af79cd13be357-93f0cbd8fc8mr548701785a.73.1792081677948; 
 Thu, 15 Oct 2026 09:27:57 -0700 (PDT)
X-Received: by 2002:a05:620a:7007:b0:93f:cbd:8e20 with SMTP id
 af79cd13be357-93f0cbd8fc8mr548691785a.73.1792081676650; 
 Thu, 15 Oct 2026 09:27:56 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef504f6d6sm808463085a.27.2026.10.15.09.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:27:55 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------tdF8idqp0OI0bhosCpgySj0X"
Message-ID: <7f64d5e0-73d4-422b-a8ae-58fe42b4976f@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:27:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
X-Proofpoint-GUID: ikLVvc996hwsjYkC-wimPc6f-NCKaUIb
X-Proofpoint-ORIG-GUID: ikLVvc996hwsjYkC-wimPc6f-NCKaUIb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX6tCVeQoO9hVz
 plpSYa+JjtjaTS5l2YX+NbQ0EO7UKuMvQFvu78z0WfeWdzXE/23zVnHmwWM+SpWjpKOcB4O4Tff
 nmz//Zfpsq0XgTB77UDfz67o4XGYu98=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0ff0f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=X7FINd2aeJSs8-1LBM8A:9 a=QEXdDO2ut3YA:10
 a=1_sf4qHvRHQ7HlRkUqsA:9 a=_ByBskfzb6DOv6nj:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfXwZ/s3KbmJO9R
 hFYLDqNXBtBrFbdPysDo5U2yhyNitiivx32RmzBnvyguLjlvxUMGYDJZDfb6SPFClf8NxTq+/hY
 wpNThdT5DyKOUP3BSeRkhnDbDswRDaojwdCHgueTYfE4lWc7J5tpHRWgw0IQ2E0Tx3a81FD9Au6
 e6uzjEjkRUE7vms1QXzQZqllwtU2rQKjARgucUleMMJT8SbODU/oOMPmZUwtnc1kME3WkeDihN/
 Dia4kvjFdxm8ehBtMgAw2eafrd6sUMtQZaAzaC8quPNb4OTRHKrcZBzQLA1qFuT3yohw845MmTS
 A07S33INQbtiTNOudd1ZEB1HydiX6qfGLlyK+C1m5ouZwcMdGMD5xFdhITnaE6B4vZTThyW67Nm
 AsjREy4c7Eh83fbd+L7Yx3xb5Z6twXsV//wm123HaWfBClwcA7qfy0FMNyK9+lUjSvcwFj2QhIb
 /8vPOIgsZ1G60CGAPVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
--------------tdF8idqp0OI0bhosCpgySj0X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/14/2026 4:05 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c8ffe94cd8..00650a66dcb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>   #else
> -static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
> +static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
>   {
>       return env->misa_mxl;
>   }
--------------tdF8idqp0OI0bhosCpgySj0X
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/14/2026 4:05 PM, Pierrick Bouvier
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">Signed-off-by: Pierrick Bouvier <a class="moz-txt-link-rfc2396E" href="mailto:pierrick.bouvier@oss.qualcomm.com">&lt;pierrick.bouvier@oss.qualcomm.com&gt;</a>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre"><span
    style="padding: 0px; tab-size: 8;"
    class="hljs diff colorediffs language-diff">Reviewed-by: Brian Cain </span><a
    class="moz-txt-link-rfc2396E"
    href="mailto:brian.cain@oss.qualcomm.com">&lt;brian.cain@oss.qualcomm.com&gt;</a><span
    style="padding: 0px; tab-size: 8;"
    class="hljs diff colorediffs language-diff"></span></pre>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd8..00650a66dcb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
 {
     return env-&gt;misa_mxl;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------tdF8idqp0OI0bhosCpgySj0X--

