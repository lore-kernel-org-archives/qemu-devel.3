Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E7D2FFE3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jkG-0004AR-Eq; Fri, 18 Oct 2024 05:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jkC-0004A4-1w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:58:06 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jkA-0003GB-Jg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245482; x=1760781482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jAkq0ztM7dYi6TnQpQKiP5IiHXy1PvoeDqvEj3le+Vk=;
 b=JF1p9FmS5Fl4kiPi8iIdWn9cVvIzwIpAd7WC7C6FJR+rDhDCsDWgbaPf
 MWqzP7xXrwgHRUOW6hdDimnWITpzXh5HcOHXlopsZ2pjGj0zh04FGnS9c
 yRglh9T57i4iaM7sfvJxTXBZja/Nr8CY8IC3s+Fd/5tlWiVoAW0G6nvO6
 Ob5OEPeXWvrVSZZG9hm+MBJnCu9vGPLWd+tEFFjhgm85mdfhqKTMs5/3K
 seKsp5zs1XcrwvM974cJBc6mBJrpszHC5hx8f6C6WrwmobelmGzHBr5QX
 kTydesFHJxtc0nKclVBk85FXur5nA6JP+Vd8VbrYU0mW+5Pu8I7Jxk9QY g==;
X-CSE-ConnectionGUID: Xk9xMOHXQx6EpDXAE1vZMA==
X-CSE-MsgGUID: T0sfiM4zQW+sHxrq0HLDTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54182973"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="54182973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:58:01 -0700
X-CSE-ConnectionGUID: /ZPT3qd3Q/ydIvPNuiU7jw==
X-CSE-MsgGUID: QrgG/QDOTE+4UPeNSmkmdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="82793548"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 18 Oct 2024 02:58:00 -0700
Date: Fri, 18 Oct 2024 18:14:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 30/31] qga: remove unused qerror.h header
Message-ID: <ZxI099UT2dk4s1c2@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-31-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-31-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

On Thu, Oct 17, 2024 at 12:33:42PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:42 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 30/31] qga: remove unused qerror.h header
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qga/commands-bsd.c   | 1 -
>  qga/commands-linux.c | 1 -
>  qga/commands-posix.c | 1 -
>  3 files changed, 3 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


