Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B05C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfe8g-0006Th-NN; Fri, 03 Jul 2026 09:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfe8e-0006TL-LV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:41:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfe8c-00035J-LY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:41:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663BXGEe3053231
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 13:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GhSkT0qETZlktSSSoOw1Hz95L63CmjbQR0XhmCz039g=; b=Bp5s5svcReYN+vFE
 ZfUWhMDkjyYDb773sgpkMbrKe3GKarJco8OHV8hUsoQg2xv4sHURn8wO/XrWEWS6
 BuqNR9RVZU9/TaAXQkD87prZZnX+FVADxZc2ExFlft0HOlskoOEoelwtEBHLQiMd
 fNayRSS6ujrbyAFEhsz90WUKkPN884B7akIREgrpxk/RQsnk0nfFu3cHw/sD87KB
 0V2ZcDYmVdH6+bZ7mKuPy9XyrlesMZ76IAUUUlT9kZVGc0RQV1xRym+SMBOFi6zc
 cd1XC2TVO2olKYyfe4CRAAiXSn/xSJcou4K0h2/3gDOo87f6i9eNO9JELYDlCEDz
 X32zZQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j01p2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 13:40:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so43644985a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783086059; x=1783690859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhSkT0qETZlktSSSoOw1Hz95L63CmjbQR0XhmCz039g=;
 b=RKtV4nCGzFUAJ3zw2fTsC7LtPgFGlRjPM1TdqqRFP1RSo2LwKzLKQ8nEzXVnXOg118
 ZuJ8g6OwX3IYJA7Ht6eXb/+vaFzO0MfuZPUmOjfims5CtKeCp/Maog5l7hT/uryZKCBF
 /x+IyCxEBgqWdEBOPyqyy9kzrtoXK+jvyGxBu+spsns6zPGcPdEYFOHispMLRl7dGA32
 54d2+eJOO+AxL39UwanacJKgaBTaX82ZFjeNHQZ6nCcdBwppEO/66S11wX31MXOS+vEq
 aS72pqo8FS/28/VC8nviSdmJXGlt5o1GK2EK4pwLos7ujUccnkGaudIN2feG9Tmgg/wB
 iu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783086059; x=1783690859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhSkT0qETZlktSSSoOw1Hz95L63CmjbQR0XhmCz039g=;
 b=dKVXkkkmimlgrwDf1O3PjE/DK4wKh1g3hqslz8672H8vrqvRrO3Q+KUXqnA5+x5SAv
 rXWbTop02iPBNg2Pfo5VTWXWNQXCqhliCxSop4xvRVla1wqg3QjpXL828t5IwVgsp0wm
 owc1OSRh8dTuAv/JgHtzWQOXRn2FBrEsF1iHGEVIBUkURM6pP3QARyNDyLk2Ljoq9Aqq
 EmpLFhBp/Wgr+ZyTQcON9UxvS05YHLthoymQwo4sEJUh+a/Fm6J+W2IkvrQGIbg2YNih
 Y3S9Yadou4m3YSTcvUP6VgOoejFhuBRk8EPMzo5TeI0/qqifJ1Y3NxPuu+EZr3d3bJL6
 vBZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PcOonIzUeQeipjRfc8xW4fLK+ovH0YC+Y0GiY6yKGKcdcdd8xIeSTt1FRebeROuFqpF1+VBdjZ7D0@nongnu.org
X-Gm-Message-State: AOJu0YxZ5JnHVfYORWQfx7EKwUxMe2CMS2HAwaKe9jU9jx3r2kuhdNDv
 n8evpu/Reywl6m2C3UajE2S8TI39zSb8yLX75274pDi+vt2960fMq3He2Fy4Mjhb3kjwglYgBi8
 9/btVnYUvS7DlJAzmfqysxbWIqDy8/uh/izPfIdJGhRGco7daeOItM2NxkQ==
X-Gm-Gg: AfdE7cmx3rHWU5TSYI/hk600ZY55sIrr9Y80tjVqTZa7CoX2NW1qupfGowULP8FESMr
 88nVHSjhJiNJNGVCS+0JMwz+sJu4hRMakSWtbeOfoH27Z//PAfeY6PvUeRAGz5DM3Zc4ZYlWBDY
 kMLtTbhzWdedyadW5P332Ubkdw1Uhl7WlAZrrTWWPU0zT8cLKHQcIiO2zdHJ6D0VMHm0Hmh+V2O
 2D8KNeyxgcfaVl7ya6qGxZJFZQjupZrLCVxBk1RrqFQHscFHIQr4j5aQQzfEE5O3Q2K/s37C0FC
 jOlN6t3LTZ9yX2O7o+AjQ2mmXtWdjh+x5jgRoma5Yw2CvVCAmdK3+PSHVYDMcFJHC9LO7h1CvsC
 RIVtg9py9hqPH7gQ69oa5SwAv4sUKCDTYxantzcnldMRvPhfe6kWgHQDo4inv1w==
X-Received: by 2002:a05:620a:4724:b0:915:688b:aba with SMTP id
 af79cd13be357-92e784d0f07mr1427289485a.35.1783086058407; 
 Fri, 03 Jul 2026 06:40:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4724:b0:915:688b:aba with SMTP id
 af79cd13be357-92e784d0f07mr1427283485a.35.1783086057881; 
 Fri, 03 Jul 2026 06:40:57 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccb4cafesm50441405e9.0.2026.07.03.06.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 06:40:57 -0700 (PDT)
Message-ID: <8586b452-d22d-403c-a292-2c980919ae1c@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/28] whpx: i386: re-enable guest debug support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
 <20260223233950.96076-7-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260223233950.96076-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8xzOitwmmEG9Jca1BYwx2Dpwg7_jsoIm
X-Proofpoint-ORIG-GUID: 8xzOitwmmEG9Jca1BYwx2Dpwg7_jsoIm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNCBTYWx0ZWRfX3OZa5Ma8KQah
 0lftTswWwUvN3fkzGFe3SsGAR2OmcxidrKJv9mkXB6BonpNtWX/BN3VatC5gzZjPlsQRG70bNM1
 PVC4f9BYomUR02LGWj+QU2l7kYm7uPk=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47bbeb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=16nSAxT0Nq8VCJdvRCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNCBTYWx0ZWRfX5MDNAD3Cmj2g
 nMSUlbXRtj/8mXaoYYEfNao6/YQg9EjqsbBWiQIepzzS6Vzc6zsdQ7jqxlcPHbLS5uOcp68dSmS
 5r/NqeQtc1HsLUcmym6Q5voTeoksIjYfmpjZRvx55ihsITF/fET1fZeup6KBAjp2yNprEB6tSV5
 Zc7hHVDctgfMVxSpGSEyohPTyAdx18/ILpCGvEIn57sStfystaK/OeRAThFenm65jnFEWx+cOBl
 52KistPtO8pc1bwO9ZxGCa5esyYCNYeECQALEEQS8cUrI1+CVxCmSmR2CsfqjqRlMDAP9t3IMlX
 em8zNnGfGcVzIJ/F3grdmgcxWBty9kjgx8GermnDMRRDst7gaQwnrHSj5MabhOVmly5DsRxYCM2
 IB5MJM3/fRLTfVPVCVkb3g+hN+ueOMO7hg/yB6cLgzM0pdaQGaG/fkRNl3537WMczKUJ1ifYcY/
 HncHDQsLva0Z6Jnnasw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030134
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Mohamed,

On 24/2/26 00:39, Mohamed Mediouni wrote:
> Fix what got broken several years ago by adding ops->supports_guest_debug
> support as an architecture-specific function.
> 
> arm64 WHP doesn't currently provide support needed for this.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/whpx/whpx-accel-ops.c | 8 ++++++++
>   include/system/whpx-all.h   | 4 ++++
>   target/arm/whpx/whpx-all.c  | 5 +++++
>   target/i386/whpx/whpx-all.c | 5 +++++
>   4 files changed, 22 insertions(+)
> 
> diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
> index 50fadea0fd..b8f41544cb 100644
> --- a/accel/whpx/whpx-accel-ops.c
> +++ b/accel/whpx/whpx-accel-ops.c
> @@ -17,6 +17,7 @@
>   
>   #include "system/whpx.h"
>   #include "system/whpx-internal.h"
> +#include "system/whpx-all.h"
>   #include "system/whpx-accel-ops.h"
>   
>   static void *whpx_cpu_thread_fn(void *arg)
> @@ -81,6 +82,12 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
>       return !whpx_irqchip_in_kernel();
>   }
>   
> +static bool whpx_supports_guest_debug(void)
> +{
> +    return whpx_arch_supports_guest_debug();
> +}
> +
> +
>   static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
> @@ -89,6 +96,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
>       ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
>       ops->handle_interrupt = generic_handle_interrupt;
> +    ops->supports_guest_debug = whpx_supports_guest_debug;
>   
>       ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
>       ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
> diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
> index f13cdf7f66..3db074c38c 100644
> --- a/include/system/whpx-all.h
> +++ b/include/system/whpx-all.h
> @@ -17,4 +17,8 @@ void whpx_translate_cpu_breakpoints(
>       struct whpx_breakpoints *breakpoints,
>       CPUState *cpu,
>       int cpu_breakpoint_count);
> +
> +/* called by whpx-accel-ops */
> +bool whpx_arch_supports_guest_debug(void);
> +
>   #endif
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 36c5e30a03..8d0ca794af 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -304,6 +304,11 @@ void whpx_translate_cpu_breakpoints(
>       /* Breakpoints aren’t supported on this platform */
>   }
>   
> +bool whpx_arch_supports_guest_debug(void)
> +{
> +    return false;
> +}
> +
>   static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
>   {
>       struct whpx_state *whpx = &whpx_global;
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 8210250dc3..e1f0fa5e77 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -1272,6 +1272,11 @@ void whpx_apply_breakpoints(
>       }
>   }
>   
> +bool whpx_arch_supports_guest_debug(void)
> +{
> +    return true;
> +}
> +
>   /* Returns the address of the next instruction that is about to be executed. */
>   static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
>   {

It seems we also need this to get gdbstub fully working:

-- >8 --diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 4022571ffff..0e2d333e919 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -25,2 +25,3 @@ void whpx_arch_accel_class_init(ObjectClass *oc);
  /* called by whpx-accel-ops */
+int whpx_arch_gdbstub_sstep_flags(AccelState *as);
  bool whpx_arch_supports_guest_debug(void);
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..e3f93efc61f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -529,2 +529,3 @@ static void whpx_accel_class_init(ObjectClass *oc, 
const void *data)
      ac->allowed = &whpx_allowed;
+    ac->gdbstub_supported_sstep_flags = whpx_arch_gdbstub_sstep_flags;

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..5208d7e1dfe 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -297,2 +297,7 @@ void whpx_translate_cpu_breakpoints(

+int whpx_arch_gdbstub_sstep_flags(AccelState *as)
+{
+    return 0;
+}
+
  bool whpx_arch_supports_guest_debug(void)
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..f6e1636a4e0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1855,2 +1855,7 @@ void whpx_apply_breakpoints(

+int whpx_arch_gdbstub_sstep_flags(AccelState *as)
+{
+    return SSTEP_ENABLE;
+}
+
  bool whpx_arch_supports_guest_debug(void)
---

I'll post a patch in case you want to test.

Regards,

Phil.

