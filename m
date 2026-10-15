Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8918CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLGR-0002Cq-CC; Thu, 15 Oct 2026 09:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHLGP-0002AH-OE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHLGN-00042P-G1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792069970;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjkC2h+ZCfM2mKlA1Wlh748PEKb06peYkGGWGp6hhR4=;
 b=MyAy1bgh7611tZw3ssOQNaAt2XTYm50n61SNtIUCkjiksuvrq2KG6FaYqYPhYDi04egp6R
 blQOwLofDcP4vQQb057G6VRIbTjGielZIQ1gDz5DMN8Gk1iJiycS1QnzQvrJJrFGo9wVRz
 LXk8BXdOsfjK5iEtmG5arX8E1ehofTA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-BKjP6XevOJCo5cqAs_CQbg-1; Thu, 15 Oct 2026 13:12:46 +0000
X-MC-Unique: BKjP6XevOJCo5cqAs_CQbg-1
X-Mimecast-MFC-AGG-ID: BKjP6XevOJCo5cqAs_CQbg_1792069966
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso3011166f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069966; x=1792674766;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SjkC2h+ZCfM2mKlA1Wlh748PEKb06peYkGGWGp6hhR4=;
 b=rYYY0VoUR1tNTU3GN1qDVM0NCXSuvxRHGyO9cO1/qHNLpvWWLt3Vbbl4TUT2qSB6xc
 HZ/lG59og0gmnONQQ8ipnYupJ+Oe4oUfUt+XJ02K11Oat9rW0dXlew7Jnw6oW97JRiLQ
 RLu7ktAGEqgOdOkjM7+9CD3Qj23YbYJKM5sJIPABBc+bCS2Lq1t6ckKNel6bJkQ0U9O+
 COcSOQeaLzaQRdli2yQ741KxAQxNOG8+21RD30szH2L0e/Lb+chejZ5D/tnU0fczP8bZ
 U/iO7TX2P1HjqNpVfDYennzzuzynLqPDOuV+vmAZF51JNMBbVgb7SDVRBGOcV3aaMpoF
 SOzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKIvw5h0W7KfbjWayGwmbQtqeq2xzyEKFmM3AcNc9OM9Uxtqe2ghdc3gqG5aq41R9EHZcefa1Q2ojK@nongnu.org
X-Gm-Message-State: AFq9FYIN5VBLmIbCRNHTX3+A1sVykvD7Hm8ht5ghzWbOK3bc5IT6nrAH
 jgws0/o5zlZdo/JsqnspXVmx/inavIo6JY89iQy3d6shFq0ZwW8OZdtwUrWGZMbu8Cvf6WtMolZ
 MbvjCxZ84OmQ+SfN2sIH47chB9WSXjgKLhfK47IO4oPGcEVdgqe/Vc170
X-Gm-Gg: AYBFou0HbwuGmM5G83/WuUgsTB9eYyOvD/FCYW6iOHz0lIHg6QMPTRpqnE9D9pxwFDl
 KHlOeMYoOsCsO9ePy5NEOQK0hz24ni9e9lyMDh4QMA+gHeIjhR3GCk+xjHE3HQrPJx5941Iremk
 neZdtIn3e/801Q/zMsqukT3zplnnvsCWRO/1FliT/yi/cMCuNCcwOpSCbHPqzIWkYX+IX5ZB+3W
 J+G7TmbtEBM/HmRYzgRaA+a6+skzWEZ7Boq/b1hZ+d0xN/SOH36hnFCde76kttqQuBo4WxKTp3o
 q24DJnbhn+3AHLu6sfQYg5LqmoMgKF/+Jk1aut21ICiGyCcHuHirI5yTUMbxczkoPuMcoB/899o
 Wk6YD5YqJ97yIkvZ/9S6BQ/2Jy+igyx1xcSFdeV3VY47jNydp
X-Received: by 2002:a05:600c:548c:b0:4a1:a7f8:c11f with SMTP id
 5b1f17b1804b1-4a1a7f8c1cfmr185453275e9.9.1792069965738; 
 Thu, 15 Oct 2026 06:12:45 -0700 (PDT)
X-Received: by 2002:a05:600c:548c:b0:4a1:a7f8:c11f with SMTP id
 5b1f17b1804b1-4a1a7f8c1cfmr185452645e9.9.1792069965247; 
 Thu, 15 Oct 2026 06:12:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa34sm18547051f8f.20.2026.10.15.06.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 06:12:44 -0700 (PDT)
Message-ID: <6e0b9a10-84c3-4948-8eef-3d2ea5c44a56@redhat.com>
Date: Thu, 15 Oct 2026 15:12:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 11/25] target/arm: disable PMU support for named
 CPU models
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-12-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-12-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> Under KVM, the guest PMU is backed by the host PMU (event set, PMCR.N,
> and PMCEID), which may not be portable across heterogeneous hosts.
>
> Disable PMU support for named CPU models by clearing ARM_FEATURE_PMU in
> the named-model init path so arm_cpu_post_init() does not create the
> "pmu" property.

To me it shall be possible to turn PMU on even on named model. I
understand it may create migration issues due to the HW adherence but yet.
I think on x86 you can use -cpu Haswell-IBRS,pmu=on.

Eric


>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu-models.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu-models.c b/target/arm/cpu-models.c
> index fed3197186..153ee10ae6 100644
> --- a/target/arm/cpu-models.c
> +++ b/target/arm/cpu-models.c
> @@ -159,6 +159,10 @@ static void arm_named_cpu_initfn(Object *obj)
>      /* 1.b Properly set RES1 fields. */
>      reset_res1_fields(cpu);
>  
> +    /* Disable PMU for named CPU models. */
> +    unset_feature(&cpu->env, ARM_FEATURE_PMU);
> +    cpu->has_pmu = false;
> +
>      /* 2. Add sveNNNN and SYSREG_ properties */
>      aarch64_add_sve_properties(obj);
>      aarch64_add_idregs_properties(obj);


