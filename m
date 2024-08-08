Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9D9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0Z0-0005qR-4D; Thu, 08 Aug 2024 06:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0Ys-0005pW-Vf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:40:04 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0Yq-00068f-Iw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723113600; x=1754649600;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3PPHy8JJuNDWQw2zyAlqpA93JR1+C1KXlOJfYzfv5dU=;
 b=bVRxyKbzaqBzxQVJecye4qNVXybH91k9M/DUndmjn9Xx2nyg51a28Yz1
 j0+UguZNtS4GFi4hIwsmQgBMt3DGwGDsZ27+v3xwjez0KvEsmuSsy1ohi
 Lq1VDDhFrOrCiJj5Qu0P/cebBUxcOyJKXhIR3nD40Dv7keKngO8oF7Ico
 7C+t2I5H3G7tStlWmWAJNRLt2LcZMt8dHy2lC1UorNqpCi+zsZ6tubXZe
 /zyFD8pnmwmN9CFpCLCGSxpeTRB41fPRiPq1WB1ROFXxCtcm8+ovmuUyd
 bhn7AV2byCgvnqIQHZdZj8oAqU/N4gtskrNbYHiMov62YuuXiYWgL39u/ A==;
X-CSE-ConnectionGUID: gRVQgRYuQIybyjWba8Fq4w==
X-CSE-MsgGUID: jfzyCTiaRHKkJIIdaCO2vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38737370"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="38737370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 03:39:57 -0700
X-CSE-ConnectionGUID: JFK0NTqQSPWiMddNZvJCeQ==
X-CSE-MsgGUID: GjbtXSzHSR+V9tpqF1PijQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="87826785"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 08 Aug 2024 03:39:55 -0700
Date: Thu, 8 Aug 2024 18:55:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Yongfeng CPU model
Message-ID: <ZrSkMcStkUVfuzYF@intel.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-4-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112511.184257-4-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, Jul 04, 2024 at 07:25:10AM -0400, EwanHai wrote:
> Date: Thu, 4 Jul 2024 07:25:10 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v2 3/4] target/i386: Introduce Zhaoxin Yongfeng CPU model
> X-Mailer: git-send-email 2.34.1
> 
> Introduce support for the Zhaoxin Yongfeng CPU model.
> The Zhaoxin Yongfeng CPU is Zhaoxin's latest server CPU.
> 
> This new cpu model ensure that QEMU can correctly emulate the Zhaoxin
> Yongfeng CPU, providing accurate functionality and performance characteristics.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
 
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


