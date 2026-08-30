Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13B4C61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ZtX-0003Be-5N; Sun, 30 Aug 2026 03:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZtV-0003BT-Mv
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:23:57 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZtU-0005CD-9X
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074636; x=1819610636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aQ3/GtP+7FT0jHBto6tRWGX4KNJFHv61L74w2OzzTPo=;
 b=cDoCZwSXKvttXT7FFHF/twVCbRx8d51lyvstuHLDTLHhFZvtKRGJTrUl
 R1zk/8R5MzeDlxSoaiIKseKkM33OosQoeg34AL9fDjzR/oGiMHNjvynaL
 lR4c8+f/rTCRiIAsIX7fSVmkOu4LYrgpuTW6L76/HtQfARIEP1BmC9d4q
 JcrCBUsLfif/wiLNQeOpXCRW2dXd0D2CcX4YdU+sFxHlwTBD4okx9fP8o
 Nn1kocN2YJxYbzsbftXZHDnF/DziNHmRcQuokP+XUF4KkAnqN46+UbpVH
 tnioQjXWdUKSF6aOhbkKJvpgVwwt7OOy3qIct98qrqed6cwa+EtsEfB0A A==;
X-CSE-ConnectionGUID: cbtfEVgEQWKXomRnEshEbQ==
X-CSE-MsgGUID: TaE7+J9tQCOxeB0zuE2F2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="99177855"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="99177855"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:23:54 -0700
X-CSE-ConnectionGUID: MX+8LuwiTAyCs4k/h1qcNg==
X-CSE-MsgGUID: HKeYRdhESpmqIchBYOqe/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="270452285"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:23:51 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 10/10] cxl: Add documentation for CXL UIO support.
Date: Sun, 30 Aug 2026 15:23:30 +0800
Message-ID: <20260830072330.399591-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <124323713.61787732282965.JavaMail.epsvc@epcpadp2new>
References: <124323713.61787732282965.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:10 +0530, Shrihari E S wrote:
> +3. **Device 3 Extended Capability**: Enabled via ``x-uio`` on CXL type3

x-uio on its own doesn't get you Dev3: ct3_realize() adds it only when
x-svc and x-256b-flit are set as well.  It does set the HDM UIO bit
with neither of them, which is the asymmetry I raised on 9/10.

> +An example of 3 type3 devices with volatile memory below a switch. All the devices
> +and ports support Unordered IO (UIO) feature which requires Streamlined Virtual Channel

The topology below this doesn't advertise UIO through the switch.  I
ran it -- joined onto single lines, the indented continuations don't
survive a paste -- and the upstream port reads 0x00000382 in its HDM
Decoder Capability register, UIO clear, against 0x00042312 on cxl-rp.
That's the gate in 7/10; worth re-running the example once it's
settled.

Many thanks,
Junjie

