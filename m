Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D01125863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OUT-0007nI-T8; Wed, 11 Mar 2026 14:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w0OUS-0007n8-6P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:41:04 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w0OUP-0002Hs-MO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:41:03 -0400
Received: from example.com (unknown [167.220.208.53])
 by linux.microsoft.com (Postfix) with ESMTPSA id B03EF20B710C;
 Wed, 11 Mar 2026 11:40:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B03EF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1773254460;
 bh=Yea9CnSrVBxTpJJdJ1t+9tiil4FxoJfgMDXXvt6uYUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M66V7IKx5AsNn/9ENBHcFTXzeYDUOQ3o67ERJbgTowPOJbbaoQrEI2pgB+CSS4x6C
 2diof0mUICYxlDvMZdZQfT/wqV3PV8z+sv2xa+l5pFOqJfVnk8bcLrFrFIOPX+/dNO
 AJ7Zx1DV2fTS3uLtTs+zmhddJIOHyZ8RwpUz8vds=
Date: Wed, 11 Mar 2026 19:40:55 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 9/9] accel/mshv: disable la57 (5lvl paging)
Message-ID: <abG3Ny8OhedOBtST@example.com>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-10-magnuskulke@linux.microsoft.com>
 <2D1F935F-865A-4B24-B616-BEE57B22FB2B@unpredictable.fr>
 <abGHbalv5UKNj8F8@example.com>
 <5FCD2D66-8079-4F65-A85D-473F78FBC1D4@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FCD2D66-8079-4F65-A85D-473F78FBC1D4@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 04:31:41PM +0100, Mohamed Mediouni wrote:
> Thank you, I’ll test this further. Boot-tested it on an Alpine Linux VM but looks like
> that wasn’t enough...
> 
> FYI I added a new callback interface in x86_emul_ops (mmu_gva_to_gpa) to support
> adding the Hyper-V page table walker, but if it’s anything like the WHP one it’s going to
> be very slow… which is why I moved to the new interface in the first place.

hmm, I quickly tried that and implemented a hook like this:

static MMUTranslateResult gva_to_gpa(CPUState *cpu, target_ulong gva,
                                     uint64_t *gpa, MMUTranslateFlags flags)
{
    uint64_t hv_flags = 0;

    if (!x86_is_paging_mode(cpu)) {
        *gpa = gva;

        return MMU_TRANSLATE_SUCCESS;
    }

    if (flags & MMU_TRANSLATE_VALIDATE_WRITE) {
        hv_flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
    } else if (flags & MMU_TRANSLATE_VALIDATE_EXECUTE) {
        hv_flags = HV_TRANSLATE_GVA_VALIDATE_EXECUTE;
    } else {
        hv_flags = HV_TRANSLATE_GVA_VALIDATE_READ;
    }

    if (translate_gva(cpu, gva, gpa, hv_flags) < 0) {
        return MMU_TRANSLATE_PAGE_NOT_MAPPED;
    }

    return MMU_TRANSLATE_SUCCESS;
}

static const struct x86_emul_ops mshv_x86_emul_ops = {
    .read_segment_descriptor = read_segment_descriptor,
    .mmu_gva_to_gpa = gva_to_gpa,
};

but without explicitly disabling la57, I still see the same MMIO errors
during guest boot (ubuntu jammy). probably needs more investigation. I
think for now disabling la57 seems ok.

