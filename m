Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F0CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHEk-0004oj-Vl; Wed, 27 Aug 2025 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHEh-0004nM-PY; Wed, 27 Aug 2025 10:34:51 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHEg-0008Qe-4q; Wed, 27 Aug 2025 10:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756305290; x=1787841290;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=77lB+ZRggCdw9AxStVM7q/TKbJ2KCbrCEUXpDS5UA18=;
 b=fHzIel4t9wgCjDRnILmQ0f7jvTD+lpaLwDxkjuvF5885hXGAbPpm+gAx
 skqrE8wErJTfnZ1FuLhvM/JvZlSskrEQVSKLqgEx1qDLT/jq6KXyeUpgY
 KxXWsn1fh5FonXUOYmRv4VwK7bRrr7GyOheZwuFIvhS0gB602nZz0fw4e
 afQ6gW7qkuKU4oMZ+pa4JHfgkt1UBlJXrbkbcgRBqw+HWqOk0m8w5z/zC
 fKYpzQDWy4QnKc0HJM6wCKrvw95zrhycfvPDs9DIRhkEmqRmL08Slm3fB
 hkS+Mtr2QBbrf3hEVY3StAz1L6aeEooS09fgcdHJgC6/U6y7l9/E/Eqs/ w==;
X-CSE-ConnectionGUID: piqszEshTTemivkj/yV8xg==
X-CSE-MsgGUID: Pec2GYcaR425Jk6AtWQRMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58654232"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58654232"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:34:47 -0700
X-CSE-ConnectionGUID: ZL+A0ZIuR+SmflffphuJuQ==
X-CSE-MsgGUID: T4mGOCHiQQGHl5R3k6Sang==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="170680317"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 27 Aug 2025 07:34:45 -0700
Date: Wed, 27 Aug 2025 22:56:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 03/22] rust: add workspace authors
Message-ID: <aK8coHw/ugJ6Rs7c@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-4-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:25PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:25 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 03/22] rust: add workspace authors
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/Cargo.toml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


