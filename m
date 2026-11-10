Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBA606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BSyqiHTP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZQRojPgC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHJ-0008Dd-17; Tue, 10 Nov 2026 02:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQgHG-0008DG-Ns
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 02:28:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQgHF-0005Uc-6p
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 02:28:22 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4AZij2920169
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xi4fyda60x1Y9RRFJFTu+6HRG3ccVGh8euVYWITic3k=; b=BSyqiHTPGyHFgDAd
 u2n/Vdi5ciM0Ud3F1riLNgbqpj8Wq4HWR/xAS7KQ3DMFhEMskO2eRS8Ui0OpyUfT
 fc1ugagAQbxAkI6GSBsuBAqAqWzYaC+lbUDh4D+3KMyoq4aExe6KiH5pSlwnUwuy
 vaNED7YH3sJEJXuWxOCp3gtWcM923DEyKkkIdfKCaOC2ZYiMgwkRBt9ucwZqm4sg
 TtxaGYfUxf/dOG5X19H1jErtov6xnKjAuhFEF+GNroKiV9Lzfb+K9pDorU6CiVeL
 67DRGR3/XXf0hwkRr4qgvQyUmVmHVW4Oy2Ir0hmMU4A07XCLIywycXhI/6qdKc/J
 qz4GUA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg2ake-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:28:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-945c60b470dso263909685a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794295698; x=1794900498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xi4fyda60x1Y9RRFJFTu+6HRG3ccVGh8euVYWITic3k=;
 b=ZQRojPgCPdjGVVpyeCOc9/AZLkxbZh/qPtMWqNdzZ0z74mWusamFDvIPjUCi884JaJ
 ytZqMs0u625s7GHLXgD0MSlVUrHUH9cNN6WcRAKEZbRJPQhRN8snTweOrtvp/U6saAOL
 7fWeCiYe0Azc0quS51n1fXDCdNEQPsg4XPJLYMF2M4x4DsX8twRBijjhSOnUwDYqUjbo
 zFIfPvwdfqub0XzIEweRzqMoSjOe+r0p/x23gONcHobkx8tyTUAOL2+4RhnNj5XKaf76
 x93HbMCmMKlnuQuU/7/oolEz4665Bx1GR2tM0mjmepPFdVPksTKEbN0dEs2MYMtCLmD2
 7XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794295698; x=1794900498;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xi4fyda60x1Y9RRFJFTu+6HRG3ccVGh8euVYWITic3k=;
 b=FTFIoheOUhL/Ku4dM3jG5/XLLuVsqb35I0Wk4hGVA6RE2csQeUtIH6Owu+uEvBwgX+
 nf83XcPpZGyUBOlcVzKwiB3fsvvlZPwe7OzpIneSYjnyv7TNCXATQyXchY3OLBqcI6+/
 L0yi0Iux3i1GixbFyNrSE/ssN1nVdEMOp/AvikFDCMLbdN+Ck880W+f6i559BcGksf18
 dUuUpAOVYYmitaffgScHLPvTeLSXb7rH1XvDnkdgEMwEHoT5wsVxWgpq3Y0DO4dKcutc
 ojJStXsrRdbXUwDhJ7IrEtDDeUzHvBZh6/3r+Ueb/M0ppsJMuBU43L4SMxHLRAyDFGWO
 zSeg==
X-Gm-Message-State: APuU4Z8ln9z2brbax0QSr85B7qZApKbI39+x6xvw67ScOVxRDdtNRhaR
 HTWDiBELPwjjXzxfdi902BwuZTB6G8wgx5JBAVSK05IkjL5zdwSP1UQ0DaTx5U5BKUFQwlttQCG
 CZpsLWTdRiZ54n2HY8HWaNoPoGrZq9r1+kzv3GawDz6crJRGwB0ET38NxG5xUAyPbOA==
X-Gm-Gg: AYBFou10Mji8u0pv71SfQl9bLCcONPWQVTXFFxFN4vw5cguXRZd/nwIGqCfw0/VeFaw
 H8BjLSyOtn7pKG0FDbA7kaO6K+VjbLkh+enMsOHBbdzfXmnh5IY7skmqwxGvNS3YFygWW87ljyV
 lQILtUYgvL5JRA1r1xKM2PHJrhrJpm0OflkNHWI7HDun6jJ5Kb7dDTVS0tRU5t1X8ZYjSkM9gCx
 GFVlFh9zKr2AGJ5wJ7PZn0vZp1sFeew7v6lQoNIkTMj9o4J0TCYAs6hJXdwUIKq7XtNluS7syI1
 75+H6/5RLZ1Pn03wBL3bO+Ls9LM+vFQM2JskMqSXGItokGLsscy6orSO/MpXUSxpVmbcc9AZJn8
 AP5zx5nqhG77LatYV31MtkMreF3m5BTtkjL0k+EwpTPSMeaQsK7YGhNom4i+mZ8T6gdYQ9vTcdQ
 fe0AYcoDc=
X-Received: by 2002:a05:620a:4804:b0:93a:f9:614a with SMTP id
 af79cd13be357-9479f2e1f7dmr312572685a.34.1794295698101; 
 Mon, 09 Nov 2026 23:28:18 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:93a:f9:614a with SMTP id
 af79cd13be357-9479f2e1f7dmr312569985a.34.1794295697531; 
 Mon, 09 Nov 2026 23:28:17 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm42005925e9.8.2026.11.09.23.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 23:28:16 -0800 (PST)
Message-ID: <f24b1be2-d114-4760-a7a5-e292951661e7@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 08:28:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Kick the other vCPUs on SEV under TCG
 round-robin
Content-Language: en-US
To: qemu-devel@nongnu.org, Lorand Marton <lorandmarton.dev@gmail.com>
Cc: Ashish Anand <ashish.a6@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20261109142319.73878-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109142319.73878-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyOSBTYWx0ZWRfXxUb04h5MrjHk
 L416djyc6tu5+jhDb2q7/UrBZTJd/MXLMz0wSYEqcUowdC0bx0EmaznT7kn2nn47QI65kMqgSiL
 W79qBlc+7Vh12tCzDycYjlVUegk8L4z58hh8fgqajKIs67++OCIu4wytqrkotekjqq2GM107MjD
 HL/4VX515LBkAvJpkYg6dyNa5UsLRSObq09AFMXtNoM17abHRoJMY92F0eQZ5n1ipr+29EU5q26
 Y0e9b6B6NoJvWH/lPgZp//+kNT/dDZhmidGLAUlo3/mbHmyozrTwvxKh8KSRlp9IfY6/eHgfm9R
 Oic3ROJLASgcse/GKrc517LxXF39skSlxmnhwwuKvnGBEvcd3uWdUPJLdRyIMBHivtu90xok64p
 /YyE6pxWXrwiSEXS+b3RE/3KUsUI8Bt44Ptu4NI7nJTk+VgQKyqFpS/llMKd+0eFfu4mQbDDn/O
 vOKdt34IqDO66yP4xHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyOSBTYWx0ZWRfXwMTyKlttFngV
 erRAT2Yl14Qd/J463WGxFnZOyj960QL5BmMsAIc1ZeOptQjadqW1YuajbeS0IYIKlaXHXzV/ZpG
 Y5ojDrMssIATpyHc7k+lB9Yti8HB3Iw=
X-Proofpoint-GUID: qrMGPCV5QMcShhVO7eQ7LC3V-UnKnEUa
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2c792 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZByejFp4XGb5C-h6rk8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: qrMGPCV5QMcShhVO7eQ7LC3V-UnKnEUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 15:23, Philippe Mathieu-DaudÃ© wrote:
> In round-robin (single-thread) TCG, all vCPUs share one
> host thread, so qemu_cpu_is_self() is true for every vCPU.
> 
> The SEV helper used it to skip the kick of the issuing vCPU,
> and so skipped it for every other vCPU too: a vCPU sleeping
> in WFE is only woken when the RR kick timer fires.
> 
> Compare against the issuing vCPU instead.
> 
> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/arm/tcg/op_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 6a673e5ae6e8..173dd0e5151a 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -470,11 +470,11 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>   
>   void HELPER(sev)(CPUARMState *env)
>   {
> -    CPUState *cs = env_cpu(env);
> +    CPUState *self = env_cpu(env), *cs;

While rebasing I noticed I did that 1 week before latest ARM PR
and this conflicts with c5ec1bfad103 ("target/arm: don't pass env
to the sev helper"), then I noticed the previous 8def1f30d5d4
("target/arm: hold bql when SEV sets the event_register") which is
a distinct fix. This patch is still needed but need this to be
squashed now:

    -    CPUState *self = env_cpu(env), *cs;
    +    CPUState *self = current_cpu, *cs;

Or even simpler, check @current_cpu in place (no @self local var).

>       CPU_FOREACH(cs) {
>           ARMCPU *target_cpu = ARM_CPU(cs);
>           target_cpu->env.event_register = true;
> -        if (!qemu_cpu_is_self(cs)) {
> +        if (cs != self) {
>               qemu_cpu_kick(cs);
>           }
>       }

