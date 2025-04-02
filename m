Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C05C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 23:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u07FH-0004Vg-Or; Wed, 02 Apr 2025 19:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u07FG-0004VM-9k
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 19:11:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u07FE-0005pV-Ln
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 19:11:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so1710325e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743635498; x=1744240298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCuuyED5vv978zd8stIQgFW8xErmGOTaeFOafHOtSeQ=;
 b=td67V2hv2H16Ukgd95GCWIlDN0/usFtQQ2HU+pPqTLlli9qFNmLWnMMDLE7tvyKTaD
 /jZdf3U7kBV9pYvbIm+zQhNaIu2t7npzuZMrYRhkKFq3mLlVUe91oPSjSyzIYCJ1++cp
 X+VsWgpIM0/vXK/6h51aOX9ykvUoXTxVOF/ijKmeg9ls+9kHPaqODxskK2QtR6CDF0S3
 vwfyquNaI1d3P++eOVx1SHHE5SnrGdidKqbwt6DJcXqt4WsTzDji/+Gu9gd9cOO/XUJr
 a7S8F/1SQV8AxxRDRpV8lQcx5Ai5STfKGuOMukEQzpn69h1NI30LMx3Vq/WMT7DWGaa4
 xwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743635498; x=1744240298;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SCuuyED5vv978zd8stIQgFW8xErmGOTaeFOafHOtSeQ=;
 b=UuCoj8RkUdso3Bso1WhPHnJGPj5YwJPaYpUjphfwyDb7+mfdXDEYTSVR5ujldK3acg
 f4K3eZfj05tlKy3K8Obs1ElWU0e1h5qIhLD0i1Ssjs1dAcHPYO+nTnnaT+OBxm8u5eww
 kQ0Df5Bw/Kp2t/WGWwomwSXWEgg1K3C247CgfptwnhkY0iazVhJltIFmyrq0HB3pgzsj
 eS3CLh95PjI679ZB9snLcPpOr48+EznCnnhyKCInwN7EcnXIUceUXY4oDnp4HHHIvrX4
 y/EoyMb2Vc8xZGE4AvfNQ+hGYwB9nssVsC3wCTdClpHqMJyXlE5TkzB5oL6B3chPlG8N
 svXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN3+E2a4aMWn35gHXw2qjMo40KHNf7oJnlwjJcvJUi9RTXJGhsgkJEej7eHfpI652ZFP/96JjR/mlo@nongnu.org
X-Gm-Message-State: AOJu0YzVj8nTAaP8Kf2QVu6BFYD/or+6dEn35FWVhGojz09wACx8+mRc
 UNNDD7jRSnfKylwD1E8u3VPguCwLhtv5Ao8tb3R5Q5JjUEAEycQh4/7Ff+a4TP0=
X-Gm-Gg: ASbGncvxBnN8ftS1aLhmPLd7gZqghYWHLXari/NPW36mtZSwBU87Ns047h9qQoZFwn4
 9c2shZhAOvyz96etU1zAeESFpw8VWMtKTPpLoC9S1Z40bymlOFvnhz8n7V8KHlgJv/RwgmxtpAC
 SwNcDepWtfcJ96fA/YRbuPFhNJ6dwIi9phyDZHbP2Phq6DeL2Iu3SCSO/gtLcG8iH/emyuJr6Om
 SElgJmeuy6sdTOtUk3Us9Uv4T4X2bG+troKyp2ZVjicF69KzBcw1m68X9K4nTOtbGaFJzbYLW1s
 9eUTN2xOr+aQGunTFOsJorHf99olYtFTz3awVIzEJtl95Z2uHAXXGckVeYzmfZfLL3ztsOmGHR7
 nR8ZPyAnZaM9K
X-Google-Smtp-Source: AGHT+IG0STEvBx8a3foQvVzQCkaIUE+7I6MC2jXyuJzOrlewzlqDB0h+N52QttC38PzIQxq6kgaGOw==
X-Received: by 2002:a05:600c:1c90:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-43e9d4edc28mr107000025e9.1.1743635498595; 
 Wed, 02 Apr 2025 16:11:38 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm4805245e9.1.2025.04.02.16.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 16:11:38 -0700 (PDT)
Message-ID: <4e17734f-2f63-41e6-9bed-d7613d9723e2@linaro.org>
Date: Thu, 3 Apr 2025 01:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 21/43] target/s390x: Restrict SoftMMU mmu_index()
 to TCG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250402210328.52897-1-philmd@linaro.org>
 <20250402210328.52897-22-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250402210328.52897-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/25 23:03, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 1f75629ddc2..320ace67198 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -348,6 +348,7 @@ static const TCGCPUOps s390_tcg_ops = {
>       .initialize = s390x_translate_init,
>       .translate_code = s390x_translate_code,
>       .restore_state_to_opc = s390x_restore_state_to_opc,
> +    .mmu_index = s390x_cpu_mmu_index,
>   
>   #ifdef CONFIG_USER_ONLY
>       .record_sigsegv = s390_cpu_record_sigsegv,
> @@ -378,7 +379,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>                                          &scc->parent_phases);
>   
>       cc->class_by_name = s390_cpu_class_by_name;
> -    cc->mmu_index = s390x_cpu_mmu_index;
>       cc->dump_state = s390_cpu_dump_state;
>       cc->query_cpu_fast = s390_query_cpu_fast;
>       cc->set_pc = s390_cpu_set_pc;

Missing:

-- >8 --
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 9efa4ef735..43fc3194bc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -128,7 +128,2 @@ static vaddr s390_cpu_get_pc(CPUState *cs)

-static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return s390x_env_mmu_index(cpu_env(cs), ifetch);
-}
-
  static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
@@ -310,2 +305,7 @@ static const Property s390x_cpu_properties[] = {

+static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return s390x_env_mmu_index(cpu_env(cs), ifetch);
+}
+
  void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,

---

With following description:

---
Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index(),
restricting s390x_cpu_mmu_index() to TCG #ifdef.
---


