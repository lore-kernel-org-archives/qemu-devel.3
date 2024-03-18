Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4142C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8Zy-0002L5-WA; Mon, 18 Mar 2024 04:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rm8Zx-0002Kf-80
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:42:45 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rm8Zv-0007fd-Aw
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710751363; x=1742287363;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Nmdbc1gXLsPqSxFtNqhGL+IVDpZToOY6yDjjxrwsA1E=;
 b=K0UR82R6a1ju2Lz/UmJHuU7gbBJZhtoK3uT3At735D4ISqoqnvoDZKmh
 IxGYrxw6KSZ5H5+kNsj52CdkpS5HKaW/AlltIrgXGLKLa5IsZJQClB+kG
 ymEXIcwAQ5MZ13POW9nCIzCS1i3mJ3QYUDQNNZ2fDI92XHI5LdxKnNVnP
 pgxzBuST3iqlWWjqd+Fr21LJI42DIVoXeNs3IFzgOWRkEE1ElSkHSIEQy
 9l74LxxR1SCdRqAET+ROKDMCP8EZ3xgtefyxIvlUJDt5u0b8nDsuXu393
 NI/Pc1yqlu3j/vIXBebdRnxWV0vDsJV6fyMLwcr2fpXUGRNzZfjJTXTtl w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17000789"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="17000789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 01:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="36531558"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 18 Mar 2024 01:42:35 -0700
Date: Mon, 18 Mar 2024 16:56:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, chao.p.peng@intel.com
Subject: Re: [PATCH v2 2/3] qom/object_interfaces: Make
 object_set_properties_from_qdict return bool
Message-ID: <ZfgBup+eEc1ZeCXD@intel.com>
References: <20240318033211.459006-1-zhenzhong.duan@intel.com>
 <20240318033211.459006-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318033211.459006-3-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 18, 2024 at 11:32:09AM +0800, Zhenzhong Duan wrote:
> Date: Mon, 18 Mar 2024 11:32:09 +0800
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [PATCH v2 2/3] qom/object_interfaces: Make
>  object_set_properties_from_qdict return bool
> X-Mailer: git-send-email 2.34.1
> 
> Make object_set_properties_from_qdict() return bool, so that
> user_creatable_add_type() could check its return value instead
> of local_err pointer.
> 
> Opportunistically, do the same change to check return value of
> object_property_try_add_child() instead of local_err pointer.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  qom/object_interfaces.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


