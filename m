Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C25E105A56D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0diA-0001nn-M6; Thu, 12 Mar 2026 06:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0di7-0001lE-T6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:56:11 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0di6-0005Vg-0N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:56:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773312954; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OBFCzRH6VXaeHf0vqI1MZv3Asq94ZWiQEZX6PfDIYrn7yCUWxDT8TqLvycPcITpLu5TumM6G++K7JEBRj4m2aGehxzg6ugmWJqyFV8CC6PI17xvu2+KfcQqoayk4ZcbpgfJ736YZRUhqlPRLdLUL7RMLz8LC5/wGFCLIS5aCaqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773312954;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AY12SgSnnB36VmzsKVRXRkHve/Iu64mn6o6WmKva7YY=; 
 b=BfndROUOg8WUi379t+PvIwKVjYSCjYkcHGVvJWcPGL+yfGowlWA5V1Y3tzfFc8+Y/BKFywsEi0EciMh+9Lk0KsgQNL5xi8xJ5Lk4ydu7OHUlw3hXvPM3Q6KWLOKcYD6dVrv58S1Zjff3AJeBlTYwcB2EAf0C2WVgRuuWRS7H+H8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773312954; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=AY12SgSnnB36VmzsKVRXRkHve/Iu64mn6o6WmKva7YY=;
 b=vjkGlKm7b4TJXfjwYCg/sKr1OO+YQhcpRrT4Rw1MCxvGtVyvWWd3pIAyj0vBfc9s
 Zm+7OdGjXtq38JnI+pmgqygFz527BWHRKwTV5pY/4jZ8gKvtplbYDQwgJ4yIZ7TyJfA
 bPinAyqpxCbDe1MRid/iZQGMg8RanChujFUEjbrY=
Received: by mx.zohomail.com with SMTPS id 1773312952471693.6778821991469;
 Thu, 12 Mar 2026 03:55:52 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:55:48 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 9/9] accel/mshv: disable la57 (5lvl paging)
Message-ID: <20260312-tested-garnet-hippo-cb71ee@anirudhrb>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-10-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311113505.1177878-10-magnuskulke@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20260312105548.dBCrbL0lnTCNSgDHXoQjlg6Y0_5rNt42mrHHsNOjTz8@z>

On Wed, Mar 11, 2026 at 12:35:05PM +0100, Magnus Kulke wrote:
> This change disable la57 paging on the mshv hypervisor on both the
> mshv processor feature bitmap and mask the cpuid feature leaf to the
> guest.
> 
> Since the removal of hypervisor-assisted gva=>gpa translation in
> 1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
> will have to investigate and test this further.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 7 +++++++
>  target/i386/mshv/mshv-cpu.c | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index eab967ff07..ea3aacf6e0 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -142,6 +142,8 @@ static int create_partition(int mshv_fd, int *vm_fd)
>      int ret;
>      uint64_t pt_flags, host_proc_features;
>      union hv_partition_processor_xsave_features disabled_xsave_features;
> +    union hv_partition_processor_features disabled_proc_features = {0};
> +
>      struct mshv_create_partition_v2 args = {0};
>      uint32_t feature_banks[] = {
>          HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
> @@ -181,6 +183,11 @@ static int create_partition(int mshv_fd, int *vm_fd)
>      }
>      args.pt_cpu_fbanks[1] = ~host_proc_features;
>  
> +    /* features we disable regardless of host support */
> +    disabled_proc_features.la57_support = 1;

This should be behind an #ifdef for x86. Or maybe introduce something
like mshv_arch_amend_proc_features()?

Thanks,
Anirudh.

> +    args.pt_cpu_fbanks[0] |= disabled_proc_features.as_uint64[0];
> +    args.pt_cpu_fbanks[1] |= disabled_proc_features.as_uint64[1];
> +
>      /* populate args structure */
>      args.pt_flags = pt_flags;
>      args.pt_isolation = MSHV_PT_ISOLATION_NONE;
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2c66a52709..31fb788657 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1677,6 +1677,12 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
>       */
>      if (func == 0x07 && idx == 0 && reg == R_ECX) {
>          ret &= ~CPUID_7_0_ECX_CET_SHSTK;
> +        /*
> +         * LA57 (5-level paging) causes incorrect GVA=>GPA translations
> +         * in the instruction decoder/emulator. Disable until page table
> +         * walk in x86_mmu.c works w/ 5-level paging.
> +         */
> +        ret &= ~CPUID_7_0_ECX_LA57;
>      }
>      if (func == 0x07 && idx == 0 && reg == R_EDX) {
>          ret &= ~CPUID_7_0_EDX_CET_IBT;
> -- 
> 2.34.1
> 
> 

