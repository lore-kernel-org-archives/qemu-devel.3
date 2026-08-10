Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C843C5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVlM-0002eW-Nf; Mon, 10 Aug 2026 15:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtVlM-0002eN-3Q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:34:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wtVlK-0000ke-CX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:34:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AIwBHl2152339
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 19:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 30+ycHOVLmN9xSpC91TcFuiy3hCmucyxw16/nbQpEJg=; b=B/t5Da+qfS9lJOVn
 L+nh5H/lBTosg8LVXb8jnZNZq+b3Ac33aCR609cVcAXlRkXGUqpg6bp7dde52GuU
 RZPuKekZnjzi1cZQqVsXGMwXSBn+2hQWWEZHmBZxRFgvL4jvvbrkOqQ4z/kAcLWY
 cCpXaYWMIE7dgMSFGnMYVOoEMgEzwE1Zo0jYehxsRqQ1j/JpnYsf4HeYX7VndU+J
 zBLMkrmgFUCbdaJ0YGI9LdaAi5HG1tVOFenYNmqDPHRUwagChtmsLjXRJ49uHpE4
 PmhyiVeFfr+lvRybb2zdcTchw2WpAQa6++/6CKq4RfSIycs4K9rwkjUH6bsbr3Zb
 1PPimw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyccqthma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 19:34:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5276aa86d00so23309721cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786390455; x=1786995255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=30+ycHOVLmN9xSpC91TcFuiy3hCmucyxw16/nbQpEJg=;
 b=UfausvYUkyZyV2qhdWYeyeJS1upaxU79ZRHOKO/uI5xXL3miRN9TN4QJ7/R4adpZZ+
 78jE9jyXz2TJtOTsHYs1eCSouj7X4O3XWK8bUmnE552fNem4/9JO9a81L78F77TFMR6A
 xbH3gcsO9WeLBRYd3r4tRUbmmd5RJ3Lo44DHU4h0AYi4V6bStaw8oNXa1Z3zRd8Uiv+D
 BmDAE0RxdQI6UAviSfnj1ynI16MGn70NIbvAuPGY0cKcq2OWWsE4kUdp3S/VdcKBeYzU
 sqUAfq2iydMiYe24Tzzqdz76sx/3fQ1eCMfl9Qg4tQoJCqKEDjS9YieIPWY1Ul0YQr8u
 60nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786390455; x=1786995255;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=30+ycHOVLmN9xSpC91TcFuiy3hCmucyxw16/nbQpEJg=;
 b=hGgd6ZMBfPoJtOlgGpkfkrc+ydT3P6BbfSICMzzzGhm2T1XnGrkKCvGpqXc7n6GhFa
 fpnQEv3YgS/33haeuUFi0I+Gra0jGHSerNhcJr9p3YY7ve1/5Hm9CXlu7RDEF6SAATcd
 ag7PWc+EpUXc3ssQHV4xKAtTITzu8F9zmcXwnQlpXIwnvXCaybdzw/QvaNVbGEyrW0Cd
 8jqwZXxVeGJhSwLWssNraGFnz1E2IejXZYwHY3Rp/uEyUljLL0hIvuBLBjw70Fq1LF3H
 PX4xmUS46z1KtC/F+uItIPVaTGtJCQ0SojhFClqziSDl1MgZDibtaBRGvQzy4Kf86rzP
 B97A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/XieUjy2+yQebZmKmgaV8rFehh2DA+rT5XS1GZmOKkTWG7maQLd+mBRlhcDiu0BocfQmlzlDJMiPz@nongnu.org
X-Gm-Message-State: AOJu0YwHj8tCRsWwxLY4EYTyPxQrWIn3Laz+hRLCDUuAPhRZdrH6xRMj
 PXrnqgxgXxNB2MOph3FyqWEIg6d3Kw7ADSOHZuY4zE8CuJ70MECF8t5C50+mYC35OitRwUm5n+8
 iU3cpwgcdBfte7EJ4zzlixc4X5IEcW6hCbkh+HCV0m2lQJWsBJDd2anGIbg==
X-Gm-Gg: AR+sD12Xl0xERT4D63dt8BIkUknrRznxiYvmwekp8fQgPKAKDkp91PUCYxy+y2+Btbe
 yK2w3Xc0eYN+p5SMvBUnq6VkQG2ZkZAFoyB79cMA1J+wvASleaol0VOewPURSZSZwvMiRIJcggz
 ZZ074qNdihiOZIQCRti2Dnyfes18OZUxSgZxtKif0ZSdFMkXrGngIaHSPXuosb85T4sX+af4vOO
 tv9mOa9ZaScah9Zg07FbUG/v/w+9vwBcMsU4PZNTjm8trAyCA+eRTybVDTA6s5j0R3Yptop4m4q
 mKff5jyn1N0vf4t8wyoXXc0uAWSVcGe6FzGvjB44UPOdASILpYR52tU2KbUpcyiRv0ES0PdyBL8
 2JKl8RjShCMlF0/MxeyVuEWm74PsiuvizGk7aW1I7zC6TxJZoKR9QxRDkK68N+H/N
X-Received: by 2002:a05:622a:a588:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52d2095c5f6mr247350781cf.17.1786390454835; 
 Mon, 10 Aug 2026 12:34:14 -0700 (PDT)
X-Received: by 2002:a05:622a:a588:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52d2095c5f6mr247350091cf.17.1786390454316; 
 Mon, 10 Aug 2026 12:34:14 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a91e2cdfsm78881446d6.22.2026.08.10.12.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 12:34:13 -0700 (PDT)
Message-ID: <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 14:34:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qgKCVsIu5f-5UeoyLWLPUgIGYIWA460J
X-Proofpoint-ORIG-GUID: qgKCVsIu5f-5UeoyLWLPUgIGYIWA460J
X-Authority-Analysis: v=2.4 cv=WNVPmHsR c=1 sm=1 tr=0 ts=6a7a27b7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=d3VFUEEDnz3kqReynRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX/eqeyI0dEvCB
 50SS6njdO/w0qum78l56L4Hdc+5L6V865owTvGFM5vc29tepuEUIz6BM9fJGsu13UvdlxgFNxx8
 QedU3yD+NMQr2ebpaxWbf4vqgbDOInkwz5WwOqJsrHbbxQ837fZsWYbj0fjiN9svYBDlKNIEEQ1
 BCOWPxxXWyt6eQtPeyAa95LlYxE03+YKN8O2nLPLHN1L61vk1iHBIWj8S3DYkxluvlSm7FA4tFt
 GMAsBo5e9fuVwVI9FYvQ06uo5BpgtCI4rmiSq1heSktYc02LtykU8yYkHRjnuGyEyCSwErvLy7p
 rH0jSnD2YQT72OSZeE85ynxVTMFPxhznjIMFX/hJemAmrxeC38R4Y31S/P16s6Pzps9p2FEaJ9B
 uDpJWcPbGZ3vpFdJuOmedgN9l1R/xqBsGOoiR0ofWRg8p4HeGn2uAHRjg0ZFZUfqMBAt1GVhkUV
 a+I0V6XjrAVDMjyagwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX+wM6wWYmBv2l
 OAtBZmAGyJw8q914dOsg936bvGFR7QR3Yyz8wxEWmbj3yCPV+LMGoQznbpVX7BOf9paGgm7JW1K
 0yp0yrDmJ6YdJFznqmr1CN3bzAdA31c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 8/10/2026 1:28 PM, Taylor Simpson wrote:
> Change disassembly of control regs from C{num}/{name} to {name}
> Change disassembly of system regs from S{num}/r{num} to {name}
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
>   target/hexagon/gen_printinsn.py | 14 ++++++++------
>   2 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
> index a7e46f4bcd..b55d3b0b35 100644
> --- a/target/hexagon/printinsn.c
> +++ b/target/hexagon/printinsn.c
> @@ -23,18 +23,32 @@
>   #include "internal.h"
>   #include "decode.h"
>   
> +static char regstr[10];
> +
>   static const char *sreg2str(unsigned int reg)
>   {
> -    if (reg < TOTAL_PER_THREAD_REGS) {
> -        return hexagon_regnames[reg];
> +#ifndef CONFIG_USER_ONLY
> +    if (reg < NUM_SREGS) {
> +        return hexagon_sregnames[reg];
>       } else {
> -        return "???";
> +        snprintf(regstr, sizeof(regstr), "S%d", reg);
> +        return regstr;
>       }
> +#else
> +    snprintf(regstr, sizeof(regstr), "S%d", reg);
> +    return regstr;
> +#endif
>   }
>   
>   static const char *creg2str(unsigned int reg)
>   {
> -    return sreg2str(reg + HEX_REG_SA0);
> +    unsigned int gpr = reg + HEX_REG_SA0;
> +    if (gpr < TOTAL_PER_THREAD_REGS) {
> +        return hexagon_regnames[gpr];
> +    } else {
> +        snprintf(regstr, sizeof(regstr), "C%d", reg);
> +        return regstr;
> +    }
>   }
>   


Seems like this change also depends on some kind of mutex around 
regstr[] so that we know it's not being used concurrently by multiple 
threads.  Translation is single-threaded but if we gained another caller 
we wouldn't remember to come back and remediate this.

I suppose we could take an input buffer/length.  Or maybe we just add 
another static _regnames[] array to solve the lifetime/race problems?



>   static void snprintinsn(GString *buf, Insn *insn)
> diff --git a/target/hexagon/gen_printinsn.py b/target/hexagon/gen_printinsn.py
> index d5f969960a..cf1a12adbc 100755
> --- a/target/hexagon/gen_printinsn.py
> +++ b/target/hexagon/gen_printinsn.py
> @@ -28,13 +28,14 @@
>   ##     Generate data for printing each instruction (format string + operands)
>   ##
>   def regprinter(m):
> -    str = m.group(1)
> -    str += ":".join(["%d"] * len(m.group(2)))
> -    str += m.group(3)
>       if ("S" in m.group(1)) and (len(m.group(2)) == 1):
> -        str += "/%s"
> +        str = "%s"
>       elif ("C" in m.group(1)) and (len(m.group(2)) == 1):
> -        str += "/%s"
> +        str = "%s"
> +    else:
> +        str = m.group(1)
> +        str += ":".join(["%d"] * len(m.group(2)))
> +        str += m.group(3)
>       return str
>   
>   
> @@ -142,11 +143,12 @@ def main():
>                       else:
>                           regno = ri
>                       if len(b) == 1:
> -                        f.write(f", insn->regno[{regno}]")
>                           if "S" in a:
>                               f.write(f", sreg2str(insn->regno[{regno}])")
>                           elif "C" in a:
>                               f.write(f", creg2str(insn->regno[{regno}])")
> +                        else:
> +                            f.write(f", insn->regno[{regno}]")
>                       elif len(b) == 2:
>                           f.write(f", insn->regno[{regno}] + 1" f", insn->regno[{regno}]")
>                       else:

