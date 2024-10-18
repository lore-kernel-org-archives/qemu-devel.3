Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982EBD30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pq9-0003ak-0M; Fri, 18 Oct 2024 12:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1pq7-0003aU-5c; Fri, 18 Oct 2024 12:28:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1pq4-0006Fc-5k; Fri, 18 Oct 2024 12:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729268912; x=1760804912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EUXwwW8tLBr1h5LfQmSQIIWhNw1AUvF8pEr+fEox3ek=;
 b=RRCUSQ+Fs+hD6PCyJ6I4hPLaUkcyQnTVtLT9M90yHJ1DLO5eyB6PIgCh
 qH1y6Xr0+30o2ceTn5EMFA6fDe+3z3XR+SbVFxQ+k2GeEziadsYDS0+J/
 4wjKG8yvtl4TRqg8Lsd9IIdq8DKqUCL8ZjNngitzIcEOA6KXcT84oTw5p
 JWKAawpo322T9Tg8h+smtnfTfakXfRDac0kLIBeUc1FyiJbpM6nW+/N6Z
 vZKeHwpELlpyXtI/0oUsJSkk77y4Npmmj+rVRr9h7yQp+vh7Ql3mlUlbq
 ZspGCXapBjpEVod0N3dDd4YgO2GQVpR6jiJ3LUqJ2afNLGwOTS7js5xD1 w==;
X-CSE-ConnectionGUID: SvoWUQ55QvuE61dpGEfPtQ==
X-CSE-MsgGUID: m0eeHaYKS12PRNOkUWL+rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40166627"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="40166627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 09:28:29 -0700
X-CSE-ConnectionGUID: R/HkNAJTQoqekORoBq/tzA==
X-CSE-MsgGUID: fNAkpWCRS0qScjqQho9iPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="102223483"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 18 Oct 2024 09:28:27 -0700
Date: Sat, 19 Oct 2024 00:44:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] stubs: remove stubs/qdev.c
Message-ID: <ZxKQe1LesrnYbCSa@intel.com>
References: <20241018143334.949045-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018143334.949045-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Fri, Oct 18, 2024 at 04:33:33PM +0200, Paolo Bonzini wrote:
> Date: Fri, 18 Oct 2024 16:33:33 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] stubs: remove stubs/qdev.c
> X-Mailer: git-send-email 2.46.2
> 
> qapi_event_send_device_deleted is always included (together
> with the rest of QAPI) in libqemuutil.a, so it is unnecessary
> to include a stub for it.
> 
> This avoids a duplicate symbol in libqemuutil.a, which in
> principle could result in missing events on the monitor.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  stubs/qdev.c      | 22 ----------------------
>  stubs/meson.build |  1 -
>  2 files changed, 23 deletions(-)
>  delete mode 100644 stubs/qdev.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


