Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7771AD0E6D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2oMR-0000t7-7u; Mon, 21 Oct 2024 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2oMO-0000rY-9C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:05:56 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2oML-0008PI-QU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729501554; x=1761037554;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fhHLo0nmv4N859MO1xJdC24xJMzxpiiegzXrG4EWaJ8=;
 b=J1LmEllYeGIN/+/45fFbarY7Y0B37nxTMeD1SVliWV7dVp24QrHtb011
 9AGCXVxh3TwGRHltZa8RznyH9PY+ylSBevszLVpFZe6K284wAToi37chf
 8C7ym5ShaNSS4YpAm2/sFvdK7N5doMYLxDsYduIEje2a39oExzPJ7JUjj
 bJ9qOVwviW1RloKlWSGVoTTzCCG+IxHLACpomTbS56dzKzDLtXrToyk6f
 mynUleJgOrh2PTIyA4ClskzUaT9iWmUJxkwsRxDp6A0iEnRsjEDWoVSrY
 6PjOzvaNsT9eSyzEMq6cn6qtLuFCllhBa3BcfluzVZO4cUzpnpzRjg5tm g==;
X-CSE-ConnectionGUID: ciuOXMPvRGyKPlzONyjLbw==
X-CSE-MsgGUID: t8UXn0ADSCulBPgL3Ywnug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40100279"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40100279"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 02:05:51 -0700
X-CSE-ConnectionGUID: G7957S90QQyfdICR+jkbIw==
X-CSE-MsgGUID: sQLfL1fWRuKBUgF+z+oNww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="84286290"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 02:05:50 -0700
Date: Mon, 21 Oct 2024 17:22:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the =?gb2312?Q?defi?=
 =?gb2312?B?bml0aW9uIG9mIKGwcHJpdmF0ZaGx?= fields in QOM?
Message-ID: <ZxYdPZCc+3wi3f6z@intel.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <ZxYSSp1wkifLy3tV@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxYSSp1wkifLy3tV@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.527, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Mon, Oct 21, 2024 at 09:35:22AM +0100, Daniel P. Berrang¨¦ wrote:
> Date: Mon, 21 Oct 2024 09:35:22 +0100
> From: "Daniel P. Berrang¨¦" <berrange@redhat.com>
> Subject: Re: [Question] What is the definition of ¡°private¡± fields in
>  QOM?
> 
> On Sun, Oct 20, 2024 at 12:10:14AM +0800, Zhao Liu wrote:
> > Hi maintainers and list,
> > 
> > In the QOM structure, the class and object structs have two members:
> > parent_class and parent_obj, which are often marked as "< private >" in
> > the comment.
> > 
> > I couldn¡¯t find information on why to define ¡®private¡¯ and ¡®public¡¯,
> > even in the earliest QOM commits and the patch emails I could find.
> > 
> > Does ¡®private¡¯ refer to the internal implementation code of QOM, or does
> > it refer to the specific code that defines and implements this object
> > and its class?
> > 
> > I understand the original idea of private field indicates it cannot be
> > accessed directly out of the "private" scope.
> 
> I see two scenarios
> 
>  * Devices where the structs are in the include/..../<blah>.h
> 
>    The private/public comments are a message to other code in QEMU about
>    which fields are OK to access directly, and which should not be accessed.

Does "other code" refer to the fact that no arbitrary code should
directly access parent_obj/parent_class, but rather should use an
explicit cast to convert to the parent class/object?

For example, are the following direct accesses to parent_obj all
considered illegal?

hw/usb/hcd-ohci-pci.c:58:    pci_set_word(dev->parent_obj.config + PCI_STATUS,
hw/arm/smmuv3.c:1094:        trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
hw/arm/smmuv3.c:1101:        trace_smmuv3_translate_disable(mr->parent_obj.name, sid, addr,
hw/arm/smmuv3.c:1107:        trace_smmuv3_translate_bypass(mr->parent_obj.name, sid, addr,
hw/arm/smmuv3.c:1112:        trace_smmuv3_translate_abort(mr->parent_obj.name, sid, addr,
hw/arm/smmuv3.c:1119:                      mr->parent_obj.name, addr, smmu_event_string(event.type));
hw/arm/smmuv3.c:1212:        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
hw/arm/smmuv3.c:2033:        trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
hw/arm/smmuv3.c:2036:        trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
hw/arm/smmu-common.c:888:    trace_smmu_inv_notifiers_mr(mr->parent_obj.name);
block/throttle-groups.c:777:    if (!tg->name && tg->parent_obj.parent) {
iothread.c:173:                               iothread->parent_obj.aio_max_batch);
iothread.c:359:    info->aio_max_batch = iothread->parent_obj.aio_max_batch;
target/i386/sev.c:1240:    if (sev_snp->parent_obj.kernel_hashes) {
target/ppc/kvm.c:2354:    const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
target/openrisc/sys_helper.c:289:        return cpu->parent_obj.cpu_index;
accel/kvm/kvm-all.c:4285:                        cpu->parent_obj.canonical_path,
accel/kvm/kvm-all.c:4377:            if (!apply_str_list_filter(cpu->parent_obj.canonical_path, targets)) {
accel/tcg/translator.c:26:                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
accel/tcg/translator.c:50:                       offsetof(ArchCPU, parent_obj.neg.icount_decr.u32)
accel/tcg/translator.c:80:                         offsetof(ArchCPU, parent_obj.neg.icount_decr.u16.low)
include/hw/pci-host/dino.h:113:     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
...

>  * Devices where the structs are in the ../<blah>.c
> 
>    The private/public comments look entirely pointless, as everything
>    is private to the .c file.

Yes!

> 99% of the time it seems the "parent" / "parent_obj" fields are the only
> one marked private. There are a handful of classes where other fields are
> under the private comment, but not many. 

Yes. "parent" / "parent_obj" are the most common cases.

Thanks,
Zhao


