Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B71C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCRw-00010I-BU; Wed, 13 Aug 2025 10:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCRs-0000zw-Sz; Wed, 13 Aug 2025 10:27:30 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCRj-0005tB-Kt; Wed, 13 Aug 2025 10:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755095239; x=1786631239;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/o/POd3fvStNwUBnC1qlmTIsPcHqRuS3zZQCn6bklK0=;
 b=etP6rkf4FwI72B4IyP/iGtR+v1vSvCaHJt7O0zOgrTSFWBG4uZLMskxE
 vXLY+cbJoPP+Dd5WLP5ZEeyBAHwfTRHZuweUt0pn1ZbPlJk84RkoGxqde
 UBTEGVOrBTKjLy+RZFsH3UV2U0EmjEYSQEzrlXsk3o8NYF6eFuVmwrjnl
 53xaTqI0nAAOehLhR91/JhQPpK5elvi/2ZZgEde+5A4QMPGRTUqhp38yB
 tsFzOUq6AVPDIqGvF4vbF7qLTg7J9sjqQJIbUkgYgF4mP/zuXYPxDk76S
 SP95wYZA8yBWx2GoyEylhVrg7/WlJC1xdwsYFwQFI3YXQ3gUGiafL5ABU g==;
X-CSE-ConnectionGUID: 9gq/koZVSX6gsiDFT+/vyw==
X-CSE-MsgGUID: e4QexpiUR1W05dJ15E8hrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68769200"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="68769200"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 07:27:15 -0700
X-CSE-ConnectionGUID: BVn5wY3IS4GfzoKKLdF9Ug==
X-CSE-MsgGUID: lTvAkkDORJSWzy/7qUu1cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="171812707"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 13 Aug 2025 07:27:12 -0700
Date: Wed, 13 Aug 2025 22:48:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 25/26] rust/memory: Add binding to check target endian
Message-ID: <aJyl1kYbEkTQRqVd@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-26-zhao1.liu@intel.com>
 <CAAjaMXa3SK2Zh06jiMsONh73zpKLCGTaG7oK=4uoqHYkja=X7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXa3SK2Zh06jiMsONh73zpKLCGTaG7oK=4uoqHYkja=X7g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 07, 2025 at 03:44:57PM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 7 Aug 2025 15:44:57 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: Re: [RFC 25/26] rust/memory: Add binding to check target endian
> 
> On Thu, Aug 7, 2025 at 3:10 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Add a binding (target_is_big_endian()) to check whether target is big
> > endian or not. This could help user to adjust endian before calling
> 
> s/adjust endian/adjust endianness/
> 
> > AddresssSpace::store() or after calling AddressSpace::load().
> 
> No strong preference, but maybe we can keep the same name as C,
> target_big_endian()? Just for consistency.
> 
> Either way:
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks! If the next version still supports target-endian, I'll keep
the same name.

Regards,
Zhao


