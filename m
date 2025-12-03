Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897F2D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQiVl-00032I-JE; Wed, 03 Dec 2025 03:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQiVk-000322-Kg; Wed, 03 Dec 2025 03:46:56 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQiVi-00036I-74; Wed, 03 Dec 2025 03:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764751614; x=1796287614;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=m2dlnwPR4i+6BZNXc5bdZ4r+87vq12g+g/Q5R+qqEug=;
 b=QU2avJdeTFMMD9TUHq8DEHzQrvtRyf733JZh6t9wB5oxm8QeozbckO0q
 pBSWHliJ6olXIrgkJc2p2W1thJjfsidAyL9fb9t/Se33AYf2s2F63XBKq
 SEkSlbd+lT6bi+McVhgKP/ab7BbFZOBxBtqa5u/phaFfmwrKDCWviVUod
 aNnIX0mGlevNMrsb28JsfvHzID/VCiu8kUAihUyPB23LPDZz5UZZhB5Xm
 WQrvE611z5PNHlHQw/XqMorDwZo0YwA/5teYvRdm0BI+O6Fl73Em3ndC0
 ZsqFjYpZjMpwGGcKlGFaAU/zlNGd19wFZTXwBqHSozoukgmelXrwsqhZO A==;
X-CSE-ConnectionGUID: LzR6hWcPQ0OVPmsSpKGGEw==
X-CSE-MsgGUID: T86WQFk9QWua+dmXGlUjpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66902927"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="66902927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 00:46:50 -0800
X-CSE-ConnectionGUID: F3VNznsuQC6Sp/TFP84qmQ==
X-CSE-MsgGUID: 4dmMU+tJTq6Xmiq7+4wZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="193897647"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 03 Dec 2025 00:46:49 -0800
Date: Wed, 3 Dec 2025 17:11:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/9] rust: remove leftover bindings/
Message-ID: <aS/+xOkDOLD2+ywr@intel.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127132036.84384-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Nov 27, 2025 at 02:20:28PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Nov 2025 14:20:28 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/9] rust: remove leftover bindings/
> X-Mailer: git-send-email 2.51.1
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/bindings/src/lib.rs | 64 ----------------------------------------
>  1 file changed, 64 deletions(-)
>  delete mode 100644 rust/bindings/src/lib.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


