Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8886CC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 05:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpJhB-0008Id-H5; Thu, 30 Jul 2026 01:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1wpJ46-0007qx-U9; Thu, 30 Jul 2026 01:12:19 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1wpJ44-00074g-Ff; Thu, 30 Jul 2026 01:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1785388336; x=1816924336;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uLkTZ9LRMqNcz43KTjDdnCYMF+FfxoFiF+mcqAsvx7g=;
 b=JdBfPbWzj+zCaZo8SlNuD8LnW/ZaS9GKqMdFsM43tJ8zC1pNhuGuno0X
 p//zUA67+nibci+rkiX/w44imH5Q3+Ie0lAxcYW4ZvxsVqXNUplXrDLRu
 Ji6mxz3aLtLQUIZIcWh7aJCBmvqjZxBdWc8WbE4ghbyMrbU2l0NKWgqJR
 09ejbAQ2TqAJP/awUHC7ZMm42wWAl5YNplPGCnrZ8MLbIYj7tJPMkyc4K
 1sOgWhj+TCoj+sYbdzpZJsf4dLs0BFqPICwKsPtL9xuRGMPICZHUZCmET
 Ws+JsmAA8OlXxPvyXEHfRXaV5aYU73rdZy6WOCrIccRbIfeG/kfi2QLwx A==;
X-CSE-ConnectionGUID: vu3cwrI9TrG5cebLlksEOQ==
X-CSE-MsgGUID: Q3H8lJuFR4S6FZPvDnKxww==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="249082269"
X-IronPort-AV: E=Sophos;i="6.25,193,1779116400"; d="scan'208";a="249082269"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:12:11 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 393E4C0182B;
 Thu, 30 Jul 2026 05:12:11 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id E5BE318000F6;
 Thu, 30 Jul 2026 05:12:10 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.194.125])
 by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id 9D0121400088;
 Thu, 30 Jul 2026 05:12:05 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:11:57 +0900
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, 
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
Received-SPF: pass client-ip=207.54.90.47; envelope-from=enju.kohei@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Jul 2026 01:52:28 -0400
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
Reply-to:  Kohei Enju <enju.kohei@fujitsu.com>
From:  Kohei Enju via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/28 13:26, Mathieu Poirier wrote:
> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME capable host using the following command line:
> 
> qemu-system-aarch64 \
>  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
>  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> CCA support to KVM.
> 
> * We are currently working on rebasing the work to v15.
> 
> It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> machine (compatible with Steven's v14 patchset).
> 
> Instructions to compile and run the entire stack can be found here [6].
> 
> Device Assignment is not included.
> 
> Thanks,
> Mathieu

Hi Mathieu, thank you for your work on upstreaming CCA support. I've
tested this series in QEMU-TCG(x-rme=on) environments and confirmed
that the basic functionality works well.

I have a question about a QMP command for querying CCA capabilities.

Jean's tree contains the following commit adding such a QMP command. Was
this functionality intentionally omitted from this series?
https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12

We are interested in adding this functionality because we are also
planning to upstream CCA support for libvirt, which will need a QMP
interface to query the CCA capabilities exposed by QEMU.

Since the Linux kernel dropped some configuration parameters such as the
hash algorithm, I need to rework the implementation of that QMP command
a bit. If it's okay with you, I'd be happy to send out the reworked
patch based on this series.

Thanks,
Kohei

> 
> [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v2?ref_type=heads
> [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads 
> [6]. https://gitlab.com/Linaro/cca-public/build-instructions
> 
> RFC v1:
> https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> 
> Changes for V2:
> - Fixed linux headers to include correct bit shift for Realm VM (Gavin).
> - Removed obsolete rme-guest options (Markus).
> - Set ConfidentialGuestSupportClass::kvm_init() to kvm_arm_rme_init() (Gavin).
> - Got rid of kvm_arm_rme_vm_type() (Gavin).
> - Used kvm_vm_check_extension() instead of kvm_check_extension() to avoid
>   error message when starting a Realm (Gavin).
> - Removed obsolete kvm_arm_rme_init_guest_ram() (Gavin).
> - Collected A-B and R-B.

