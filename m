Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA77D44C40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMpu-000218-7w; Thu, 15 Jan 2026 07:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vgMpl-0001qu-Sh; Thu, 15 Jan 2026 07:52:23 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vgMpj-0004fd-H7; Thu, 15 Jan 2026 07:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768481536; x=1800017536;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Mqh43l0lnq7jxGt9Reg0ySWbIjaEB7z4CkIZwWPR+yA=;
 b=KrE2IySztxNl5e12+HIQlZsw5NwKt16tZSjPmjWgI3N9dgNXpG3Dnk8j
 r23RLJ+2+bmD49i2RAZljilhV3LK6PNZ4EEGhbjWFD5FIh+SFY3++DqC+
 sI2sc5Y4WwWasO/8D5Z0APbg16Av7ENhF1/v+s6mUoeHwuRAPgKf4lkEI
 yfaJy6yQcPCv2DqUf7CwfeDI4GzJfr9+2BJ6cV/9ZwFzh3J+Iov8TeVzc
 2LiMk4vTd74fjkdXV1gYkpZsDJQJVJAOwPiY37dO/Uyl14T3Bdw6qJsDB
 H20/9BpLLGBFRE7hvsL7HOsUv+QhRD8O/ltRGJp2u9IEvNFdNfwVijSMK Q==;
X-CSE-ConnectionGUID: 8x/atpO7RmWRW8Nyfauwtw==
X-CSE-MsgGUID: I5vwIejfTEqamFDPY8BPlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80896686"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="80896686"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 04:52:10 -0800
X-CSE-ConnectionGUID: /67MyfSXR8ySRsUO/scEVA==
X-CSE-MsgGUID: 90rxABbqRoOv0QhL6DntwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="228026805"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 15 Jan 2026 04:52:08 -0800
Date: Thu, 15 Jan 2026 21:17:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 07/16] rust/qobject: add from/to JSON bindings for
 QObject
Message-ID: <aWjo8tfQnIoVhbKr@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108131043.490084-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 08, 2026 at 02:10:34PM +0100, Paolo Bonzini wrote:
> Date: Thu,  8 Jan 2026 14:10:34 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 07/16] rust/qobject: add from/to JSON bindings for
>  QObject
> X-Mailer: git-send-email 2.52.0
> 
> These are used by tests.  However it could even be an idea to use
> serde_json + transcoding and get rid of the C version...
> 
> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/wrapper.h          |  1 +
>  rust/util/src/qobject/mod.rs | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


