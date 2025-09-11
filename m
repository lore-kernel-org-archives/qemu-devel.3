Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B3ACAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe5o-0005Pl-4g; Thu, 11 Sep 2025 05:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe5j-0005JW-2D
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:59:47 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe5f-00062W-WA
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757584784; x=1789120784;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=6gAKbZonkXVqcoFhW9pt36f5q4/EmIBw4MwVFnmfhbY=;
 b=nyYxyUxkI+xYVm0Ts4Kpu7K7mo9urzJfAm0a9WKgReCtmUj7RgedniQp
 QbXbHT7makaBelUngWyaGkxNkc6m6rw1wuKd9cykLw/UHChmWTbI1S5CO
 JYVcyLgu+amE5rLpGjS1AEIPjCzcSBiSypjEK6OyIaJLqeLAwiBvwDFTj
 N2RXmqqUHF3hDAnz/aWKL/d6ReUUD71pJASO6c5bww8rBqsDxXJPSomAk
 u4KvoznSlR2y13kz0Hswcg5AqRanN/556ojq1FeAKp8tzWQ36XnRAccUw
 gsJ+q13eBws/+fjmVcE0Zg8Y0+vszYkC/iu0NuiIA3m8QZ50q5ilrm3mk Q==;
X-CSE-ConnectionGUID: /JNptIYNStea1SRG3/z4bw==
X-CSE-MsgGUID: 1v3X/ZNnTEOIfqDFJPiEiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70166316"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="70166316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 02:59:41 -0700
X-CSE-ConnectionGUID: 3wvpmgpZTOa+vPRfLxMraw==
X-CSE-MsgGUID: c/PWT6mdQeabW0S8sUI82g==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 11 Sep 2025 02:59:39 -0700
Date: Thu, 11 Sep 2025 18:21:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 10/33] docs/rust: update msrv
Message-ID: <aMKirLBvqRfyW3W6@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:42PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:42 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/33] docs/rust: update msrv
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-2-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 2 +-
>  rust/Cargo.toml     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


