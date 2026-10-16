Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E25CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoRj-0004cy-Ei; Fri, 16 Oct 2026 16:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoRh-0004cb-8Y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:22:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoRf-00006H-NX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:22:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJeroG3725853
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KvXYv7GcmWIwYWAsDb4/AEiWkn9y5BzYG82yxLb+XV8=; b=QIvnoBqKYWHvbdOY
 PL/4XkUdeStnw3l0nDl7Kjjrzjw5aZHrwQXYMP9CmFQG98MzTdHriLpl91ycfeJn
 RjqsRNyX1u7/2rahOuIahDAUfG7m/2keYUALV/fVC2yL3rrYyQ+NJCXMomvdKHI3
 UVeKqluOvdbru5QlbtWZiXNEpOCxDYMxEThT4DFNgBGC59MGqL7bTjq0AabSa5zD
 1cw50oDaX9XR1BDx8UMZMimEQaRMgacJ2n6YfbEKQdc7FXIFMRMIN+OFzfPF3uQV
 2bu6QGxtxUr3FhkzdyCT6h+sebZaPHZHWgEE4Nuqh1aCHSMcIBU3S7LW1vBhcbqz
 cSG1QA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450wa5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:22:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a556c43so6659726d6.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182146; x=1792786946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KvXYv7GcmWIwYWAsDb4/AEiWkn9y5BzYG82yxLb+XV8=;
 b=ZBvGx3L7T2U3VVQ8DyFwWHcW5xBr5ZdqqCdaoh4p7QduHhqcBUs+RbQUY7iFK8TERq
 /qGwKLpAnCp1klQnzMfbF3I5CCzJROqoK8dhbqbtx6VaAR99EIbXgrgakvYPQhgCOG3Z
 UI8lQ3tpegr/TVnEmJCgIBC6/dyXz95NvwMS2/4ODjLDlvM7H1OZJ+3dzCstpxesVE14
 0PLRy2EetMCFzF4Wtc4qcAiRjAs5WlPRjaDpSXYS5HL9Nmy363zordoa58wact9RjXC9
 GXy2m7MLqmNmHiN0WN2ys/6+BANH4hG0tplFhqyr2uVyqIXO5YcgiwgW2FTmKG/clWU/
 dRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182146; x=1792786946;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KvXYv7GcmWIwYWAsDb4/AEiWkn9y5BzYG82yxLb+XV8=;
 b=PU0UzgbN9aEF8vuZxZ4z9o1VaZgQ1DuBJAgGWtrZfWGAY+CphtppWXUNYdypyurRan
 Jmocd80tgDJ/oS3ZJX9NlX4iJ+8CUJvVQpVNXlsJJePLPqoag5ue4fCMLX8Fthf+sQw9
 vq+zp9HIyb76xSW4qF0mPgL2IBoO/3oNs3tuOTFG09hHLZwkWCtTJoX4zm/sx3c5IfU6
 0br5RWq//T6W3PD1Ix0kTRa1hcDXxF8X3Excs1t1fbLe758TCTJXLRUdarblErSMMJo9
 7RyhpGdiJE/QG+YMWwNdgAGnw7sme+8x9dK8h808sDqxBIdeRAmCasiV00ECWlgLryZH
 R4Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxibDyaMZKhRX1yCOOI8fZ60LQt7HMMrLuHcWTt2bWdt+V1XWiSY5a6ri+QWmy6aZJp7IA6Ds/9Ge9W@nongnu.org
X-Gm-Message-State: AFq9FYKCyfdfnqKtw5dHdEPeTTIn3iWqhzsYG9Lr+T9vlu/Ttl5oxxzg
 TicScy1p39kz8EJsHm487YT9ceGjeKtgj60FMn6CsG+7h+NwZJ8fMRIQUJW/kwpJfOjB9AuuApK
 W4NfEDxn58nLpbSgVqAPoq6gp9wIfeuVzPBkpsWWuHLABziSDnLBr+tXi/Q==
X-Gm-Gg: AYBFou0YTb9gm4FYUU4qsX+a+V3GlwWH6KQ+6nAuosQk05JBQ+Tywlrd4wT25lXkF2c
 dxpTI0GAvDIm8YDTQ/PbrXI4PhTUhE/shq0wM3qlv81/J5X5rlJssEkOtMh0CFae6iG09f5PpIQ
 Gy2VscFXl8evzXVSYCda62DQyX5uP/yz86DjJiPp7cwrGbLDFtvzLaoAQLT/zeqOdwKYi/HcZoS
 orOLmhWhC4Cyi7zd+oAVgErqZGzfmP4VXZBaOVP5g8S2US3A/1X9XNBZdx3L/h8qehZCrm1cGIN
 OeiDRVzsKkp4Hdq1bVfnmE1A/2OcGpIRkUmyYtrGZLZnJtIitsvJ0EzhMQhD6tMJI/lmU2Eoghy
 DanGhWHYORkTatvig2Vv2nu+66B4n+mnmxC0=
X-Received: by 2002:a05:620a:4609:b0:93f:258e:502d with SMTP id
 af79cd13be357-93f29da1202mr169608485a.63.1792182146051; 
 Fri, 16 Oct 2026 13:22:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4609:b0:93f:258e:502d with SMTP id
 af79cd13be357-93f29da1202mr169604385a.63.1792182145580; 
 Fri, 16 Oct 2026 13:22:25 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bd276eec4sm22389686d6.2.2026.10.16.13.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:22:24 -0700 (PDT)
Message-ID: <52ec25c7-b992-4371-83f4-f30a133819f3@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:22:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016182751.264704-3-pierrick.bouvier@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VZgTDPIZ9AOi-mCph-VJuB4dskDnV2jO
X-Proofpoint-GUID: VZgTDPIZ9AOi-mCph-VJuB4dskDnV2jO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfXxPr8va1kUgR9
 LRhk5POQloMeOeX9zfLGlym/wvxl5yAc1kdaJWUokTFzMRje8TRdK5ZWqduo81XDpHiPq8sqOg0
 W/R7qigdmATJ9IBnu2k2k/anESIRkVNBznllv55bm/Oj0wdDorDg/dGCbAxjbMJCsvJUiFlh/kp
 UkJYruQ93Gq1/Jlodz8JoOQyR+3OVWwTt5N/2EP9En1WH1Gd6b0VpFeXZgap8n9uVpj1vIyQwiH
 /tUYwhHYaF4mBaaZn88K2A2DfOY1S/wWURTNpoZc0pLPXXWysVYmTPqb0UDkny/x4HzFJQVAOUT
 4sYpXIqtyPVd0DmYv07cm+90qyqgBhIWY4Fo0KxDs5q/Oc6Tw0QT01SWGm2+3tqpe6xyCiD6Uv9
 36iDqqeSsOTR4hfXjD2aT4tA7VX68dqZUWXXjooZXBpq04CIZmggDmInpp1PyTmczUQnXcKDy+a
 kweGN6cI8FqxWYSZGVQ==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad28782 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KfKdc_6-5s6LhNpCYkMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfXzg4ocBz/wmUE
 RRiDBtjDJf615DVlufcL0TSN/q0Scf+unGcWP2pYvcsrQusmrc6obhOG4FW/jiOimiACagwKONu
 Tse4sJJP3Pdlfc3CtrDtuhUdMnUdc2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/16/2026 3:27 PM, Pierrick Bouvier wrote:
> This removes conflict with same function from target/arm.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/virt-acpi-build.c | 2 +-
>   hw/riscv/virt.c            | 2 +-
>   include/hw/riscv/virt.h    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0475dcb5c60..4565359e908 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
>       },
>   };
>   
> -void virt_acpi_setup(RISCVVirtState *s)
> +void riscv_virt_acpi_setup(RISCVVirtState *s)
>   {
>       AcpiBuildTables tables;
>       AcpiBuildState *build_state;
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index b53ae07f9b9..220f125d56b 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -711,7 +711,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
>       virt_build_smbios(s);
>   
>       if (virt_is_acpi_enabled(s)) {
> -        virt_acpi_setup(s);
> +        riscv_virt_acpi_setup(s);
>       }
>   }
>   
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 16d86edfcfc..6e4fbf4b647 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -122,7 +122,7 @@ enum {
>       (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
>   
>   bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
> -void virt_acpi_setup(RISCVVirtState *vms);
> +void riscv_virt_acpi_setup(RISCVVirtState *vms);
>   
>   /*
>    * The virt machine physical address space used by some of the devices


