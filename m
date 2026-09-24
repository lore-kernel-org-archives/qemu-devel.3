Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37150C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9gCn-0004Of-CD; Thu, 24 Sep 2026 05:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9gCl-0004Ns-Fj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9gCh-0005WG-Hx
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790243842;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPDUYn2sNH+tuYff9vyFITqIs0ucy3tacjD7MAHGCvo=;
 b=Nf/8oCnHeACcdpJoVKdN3mGN1ZKXNuwIPQsBzeoqIcEq3CQN1B6e392GLDYf/ROz2su6Fh
 QRWdIsHOT9aZG5fnCXQ3TDxbwFJWZ3F0R6VzBU//JI+8aVC3+/oM3qRf1e1E8CUc9ahJU3
 L/jsp8GETl9Xj1kaAnBq9VSx+gDsVmU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-6-TGx29fNqWFaBt2VM9UJg-1; Thu, 24 Sep 2026 05:57:20 -0400
X-MC-Unique: 6-TGx29fNqWFaBt2VM9UJg-1
X-Mimecast-MFC-AGG-ID: 6-TGx29fNqWFaBt2VM9UJg_1790243839
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486e8fb7d75so769936f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 02:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790243839; x=1790848639;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XPDUYn2sNH+tuYff9vyFITqIs0ucy3tacjD7MAHGCvo=;
 b=2nbePefUmky4x9p49yOdMzbbcEeOMXcY/ndBeTN4FsUICuxgyQLLZFsVBSnPiMMTWz
 tzHhLlDPq5rI3Aqx81FvPQ2y7iAyFKYijtx0Uk8srsh2vh3u2HTNBXdC9fDz0E0PP9C6
 HvQZetbkkmErFQ9x+320uZG1n4XR8FUtYOCI7o7lhmSNX4grjEBJDI7hfJKMbTegdoR2
 18TgWc4jiQ8rMK0TESyDLKBbsFTYRKTws0VfIxCUBgxVpqrKUa8iuONX2xO3K6bA82Lg
 uuK070RnSKzb15/PqqhufCJmjhhVkUBIT0NlPHjDHe9zO2PI0TuNG1CcamNV2TBVmk/5
 9TIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzclCMnZC3/oG/KQTNEEGB4FSTn0o1YdogPXgiK05GOG+RJNeje/wFBgHIpyoB+3BYuc0XO8nwqrpDM@nongnu.org
X-Gm-Message-State: AFuF++mZCtTO/mcRA3iVldt4hmxIt+9w8/Dj2ns4342qP17Rl6uAbLTJ
 RRt8C0BlgydpHo9V5zdeEdDumdpm3+FYZG6R3vYfe4b+2UA9kvOS6j2d3+ioTrTtxU6iN1Ap7v4
 neFp8yG29iByT/9OLEXcaDgX3OBMLrLK2DkCHQNA1e5A8hkfhyC5pcMKQ
X-Gm-Gg: AYBFou0DfsVqEsO7SBvujB3zLu05oM6Y9jRZW53OF/X7lumhokjKiAkQhcxjcZoEOjq
 rK//N4kzfODMvWWf3RD3YUcCghvMipUQvi7PgAKh99/g8TTRm0MJlr0I0EJWhk/xGecNX+VOrG3
 zWbT4cYpZgrcn29cPKywvpCzLn0+d+i7NTkbULT754W6wou1MnpLF+keiyJ+J5X9gkeWhME3ju5
 2cIF2EgqMivaMfREJNAPPpI1zn2y2UKl5qu7+JrhelT1HvbnBNdOJyOT9x2LthTps9YZAWHqBYl
 XCoCP//YMiWmz+8Bt9ZvHCGcmkUxU0ZIqW2h82FPvutD8WDNElXEPtMCu4MsDF0+/sMlMzjS+39
 MDrsqg5wPxzDL0CWKCj5LGCeXXDflgjgdNWnAuA+Se+MbTZyC
X-Received: by 2002:a05:6000:2913:b0:488:6078:8aef with SMTP id
 ffacd0b85a97d-48871725c5fmr3067143f8f.20.1790243839459; 
 Thu, 24 Sep 2026 02:57:19 -0700 (PDT)
X-Received: by 2002:a05:6000:2913:b0:488:6078:8aef with SMTP id
 ffacd0b85a97d-48871725c5fmr3067097f8f.20.1790243838957; 
 Thu, 24 Sep 2026 02:57:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889337sm13769957f8f.34.2026.09.24.02.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 02:57:18 -0700 (PDT)
Message-ID: <aabcb61b-8341-423f-b113-e7ab2b34c2ac@redhat.com>
Date: Thu, 24 Sep 2026 11:57:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/25] target/arm/kvm: handle writeback for special
 ID register fields
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
 <20260921123249.1708067-9-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-9-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Some fields should not be written back to KVM for various reasons:
>  - ID_AA64PFR0_EL1.GIC / ID_PFR1_EL1.GIC are fabricated by KVM based on
>    the gic-version property.
>  - KVM does not allow writing 0 to ID_DFR0_EL1.CopDbg, which breaks
>    booting an AArch64-only guest on a host that also supports AArch32.
>  - ID_DFR0_EL1.PerfMon is populated by KVM even for AArch64-only guests
>    but is not writable there.
>  - MPIDR_EL1 is managed by KVM based on vCPU index.
>  - Hold off writing back CLIDR_EL1 until we properly support exposing
>    cache topology to a KVM guest.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu-idregs.c |  6 ++++++
>  target/arm/cpu-idregs.h |  2 ++
>  target/arm/kvm.c        | 40 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu-idregs.c b/target/arm/cpu-idregs.c
> index d58b8ed063..1f7ebfe9bb 100644
> --- a/target/arm/cpu-idregs.c
> +++ b/target/arm/cpu-idregs.c
> @@ -107,3 +107,9 @@ bool arm_field_is_writable(const ARM64SysRegField *field)
>      return (arm64_id_regs[field->index].writable_mask & field_mask)
>             == field_mask;
>  }
> +
> +bool field_matches(const ARM64SysRegField *field, ARMIDRegisterIdx index,
> +                   const char *name)
> +{
> +    return field->index == index && !strcmp(field->name, name);
> +}
> diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
> index aab1a79db1..8ef3f9350e 100644
> --- a/target/arm/cpu-idregs.h
> +++ b/target/arm/cpu-idregs.h
> @@ -35,4 +35,6 @@ extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>  
>  uint64_t arm_get_field_mask(const ARM64SysRegField *field);
>  bool arm_field_is_writable(const ARM64SysRegField *field);
> +bool field_matches(const ARM64SysRegField *field, ARMIDRegisterIdx index,
> +                   const char *name);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 2d94b3a884..70d9a07580 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1317,10 +1317,40 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>      return true;
>  }
>  
> +static bool arm_field_skip_writeback_always(const ARM64SysRegField *field)
> +{
> +    /*
> +     * GIC is controlled by the gic-version property and fabricated by KVM
> +     * when the vGIC device is created, so a named CPU model must not touch
> +     * it. KVM also rejects writing 0 to ID_DFR0_EL1.CopDbg, which breaks
> +     * booting a model that lacks AArch32 support on a host that supports
> +     * it. MPIDR_EL1 is managed by KVM based on vCPU index, skip writing it
> +     * back. Similarly, skip writing back CLIDR_EL1 till we properly
> +     * support exposing cache for KVM guest.
> +     */
> +    return field_matches(field, ID_AA64PFR0_EL1_IDX, "GIC")
> +        || field_matches(field, ID_PFR1_EL1_IDX, "GIC")
> +        || field_matches(field, ID_DFR0_EL1_IDX, "CopDbg")
> +        || field->index == MPIDR_EL1_IDX
> +        || field->index == CLIDR_EL1_IDX;

what does happen for SMIDR_EL1 and GMID_EL1 whose value could not be
initialized from host. The setter for any of their field shall fail.
> +}
> +
> +static bool
> +arm_field_skip_writeback_if_not_writable(const ARM64SysRegField *field)
> +{
> +    /*
> +     * KVM populates ID_DFR0_EL1.PerfMon even for AArch64-only guests but
> +     * does not expose it as writable there, so skip it when it is not
> +     * writable.
> +     */
> +    return field_matches(field, ID_DFR0_EL1_IDX, "PerfMon");
> +}
> +
>  /*
>   * Copy writable ID reg fields from isar.idregs[] into the KVM cpreg list,
>   * so the subsequent write_list_to_kvmstate() pushes them to KVM.
> - * Only writable fields are copied.
> + * Only writable fields are copied; fields that must not be written back
> + * (see arm_field_skip_writeback_*) are skipped.
>   * Returns -1 if any vCPU's ID reg value differs from the host value and the
>   * field is not writable.
>   */
> @@ -1357,6 +1387,14 @@ static int kvm_arm_write_idregs_to_cpreg_list(ARMCPU *cpu)
>                  continue;
>              }
>  
> +            if (arm_field_skip_writeback_always(field) ||
> +                (!arm_field_is_writable(field) &&
> +                 arm_field_skip_writeback_if_not_writable(field))) {
> +                /* Never write this field back; keep KVM's value. */
> +                writable_mask &= ~field_mask;
> +                continue;
> +            }
> +
>              if (!arm_field_is_writable(field)) {
>                  error_report("%s.%s is not writable: host=0x%" PRIx64
>                               ", requested=0x%" PRIx64,
v9 has changed the way new field values are stored. writable field props
and non writable field props could have different setters. A non
writable field setter just needs to check the new value is the same as
the current host value. No need to record the new value in the hashtable
for further commitment.

Eric


