Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB35ECCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhjQ-0007nU-5W; Fri, 16 Oct 2026 09:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhjG-0007kA-LY
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhjE-0006uL-Tn
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792156327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqAlwmurey0eGwhQI19UUFnkpSWK92NIkqItN6DRKHs=;
 b=AYiHtoDIKBBMzSfAcrmQ4vcfZ05Zyz/+gAsBxLN+mO/vci1NjxO5/HimCkMgrixBIlU2tk
 qt7BaB80DpiHrFRXqNArguXdxvxmm6P9PmwKnFqX+qaH3h0jFblMNm/Dlo4DqksR78J7Ld
 PnA3cT/fViDhAJHByBA1liVsksl40wU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-nWUqr0VkPnqdmU5V8xDp_w-1; Fri, 16 Oct 2026 13:12:06 +0000
X-MC-Unique: nWUqr0VkPnqdmU5V8xDp_w-1
X-Mimecast-MFC-AGG-ID: nWUqr0VkPnqdmU5V8xDp_w_1792156325
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a16db51147so41549855e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792156325; x=1792761125;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NqAlwmurey0eGwhQI19UUFnkpSWK92NIkqItN6DRKHs=;
 b=e7utCxmbGxdUkB/zhHw8eTnwqmBXTmLDYoV9iJLOXNSew78NGCAeUiMDVd9MA8+qvV
 b8nOYIGskgfGQHqfa3nijgvNvfY+bg5kgoIC62fx4tMEitxXIGko3H7KJauvS9S5DoH1
 F9GPpkzXetMr3wOeHWt5HJLpNdLVY79Ax/57zB1oX5+Wb3BJ7q94vhfNa4qvZtfd6tK5
 854yemNGSwLLLhhFaY8pN+DAsdUBmHrWgALg1HNgbT++q8X6w5l7/67KrVr7bpQ2SeTZ
 hQn2yoszs1/F7jwiZssrdW68P1lyrTN9wk1ec60XiITPgmK4AWaLfdauG2MdL27yfLBM
 JwsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByedqgUfxYQqHDR+m1TjTtsdBeATd6sXaiXM+gh/O5xu3vJRHR+0+a9CxDTgrGcurFE50qbEWFyVhcK@nongnu.org
X-Gm-Message-State: AFq9FYLu3q4MsZCA7QKdwt54vxe4yfwMBc7fYAKwRtqXoGEjJyMh+WG9
 7idnIL8U3rbs7U5L2YOuNWrcYOuQLdhzQ+i+V8aCL/Vx+7+VN6CnleENr1rXQ5AWOjwU8rx52bN
 5cPCrYVupptnRxzVeXH0GLbSMK9nYNzFpBJOtv6VbZfjWmQjUMSoob3xO
X-Gm-Gg: AYBFou1NjSL8BwMHEGoIu8crj6Jvm0I1wvCmhAPm4d9x26lttxsxqfriSKlnQHpp8i1
 yjxKPSP15aqOjBCRVm4o1jZUBdJ0g9T8ushyndbomrbFDWdJjw/xUvK6SYcImMldP1qA1oMa72R
 ykHvqeg8/SI70aG/OKalCQ6tfPx+g/XjOwleFneqvdLia0RSA+PrlpozsHPXYj1zQ6FkjTzcgEF
 FiMm0li1c1Heu8Q2q2pkD6QPtmeR59f10tjuXf1c6u0QnN4QH0IkXUIjIoIWKpNhiWDtUYQ0aYW
 AeRLqgxunSjPsyM3FfL3uNtLB3BHEwNu3MgRXGa8T1shdqSBVkbuc16HECL7ga+frW9007X5Wwb
 TJvkiZ3zJGbZw3aQ+csXxINYN5b5O3vDY/Q==
X-Received: by 2002:a05:600c:3e07:b0:4a1:a009:9724 with SMTP id
 5b1f17b1804b1-4a1a00997f1mr285782605e9.7.1792156324954; 
 Fri, 16 Oct 2026 06:12:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3e07:b0:4a1:a009:9724 with SMTP id
 5b1f17b1804b1-4a1a00997f1mr285782155e9.7.1792156324572; 
 Fri, 16 Oct 2026 06:12:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5957sm4960343f8f.9.2026.10.16.06.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:12:04 -0700 (PDT)
Message-ID: <0a1a763d-c95d-413c-ac11-384d5db599c2@redhat.com>
Date: Fri, 16 Oct 2026 15:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 21/25] target/arm: report 0 as supported for ID
 fields gated by vCPU init flags
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
 <20260921123249.1708067-22-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-22-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/21/26 2:32 PM, Khushit Shah wrote:
> When QEMU queries the host ISAR via KVM, it uses a scratch vCPU
> initialized with all host-supported features (like SVE and PAuth).

So I expect this patch is not needed anymore after rebase on v9/v10

Eric
>
> KVM exposes the corresponding ID register fields (e.g.,
> ID_AA64ISAR1_EL1.APA) as read-only. The supported-values list only
> shows the enabled host value (e.g., 5). This falsely flags a model as
> blocked, even though the features can be masked by omitting those flags
> during vCPU initialization. For these fields, even if KVM reports them as
> non-writable, we explicitly append "0" to the list of supported values
> if the host value is non-zero.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/kvm.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 77b1bcdf55..0b5fb49dff 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1346,6 +1346,24 @@ static void ranges_add(GArray *ranges, uint64_t min, uint64_t max)
>      g_array_append_val(ranges, r);
>  }
>  
> +/*
> + * Some fields are reported as non-writable by KVM but can still be
> + * disabled by not requesting the corresponding vCPU init feature flag
> + * (SVE, pauth). The supported values are derived from a scratch vCPU
> + * whose init flags may differ from the real vCPU, so for these fields
> + * "off" (0) is a supported value in addition to the host value.
> + */
> +static bool kvm_arm_field_off_via_vcpu_flags(const ARM64SysRegField *field)
> +{
> +    return field_matches(field, ID_AA64PFR0_EL1_IDX, "SVE")   ||
> +           field_matches(field, ID_AA64ISAR1_EL1_IDX, "APA")  ||
> +           field_matches(field, ID_AA64ISAR1_EL1_IDX, "API")  ||
> +           field_matches(field, ID_AA64ISAR1_EL1_IDX, "GPA")  ||
> +           field_matches(field, ID_AA64ISAR1_EL1_IDX, "GPI")  ||
> +           field_matches(field, ID_AA64ISAR2_EL1_IDX, "APA3") ||
> +           field_matches(field, ID_AA64ISAR2_EL1_IDX, "GPA3");
> +}
> +
>  void kvm_arm_field_get_supported_values(const ARM64SysRegField *field,
>                                          const ARMISARegisters *host_isar,
>                                          ArmFieldValueSet **value_set)
> @@ -1358,6 +1376,13 @@ void kvm_arm_field_get_supported_values(const ARM64SysRegField *field,
>      /* A non-writable field can only ever hold the host value. */
>      if (!arm_field_is_writable(field)) {
>          ranges_add(ranges, host, host);
> +        /*
> +         * ...unless it is one of the fields that can still be turned off
> +         * via vCPU init flags, in which case "off" (0) is also supported.
> +         */
> +        if (host != 0 && kvm_arm_field_off_via_vcpu_flags(field)) {
> +            ranges_add(ranges, 0, 0);
> +        }
>          goto done;
>      }
>  


