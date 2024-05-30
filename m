Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D12C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgGL-00009L-A7; Thu, 30 May 2024 09:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCgGJ-000090-LG
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:56:11 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCgGE-0007Gy-MI
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717077367; x=1748613367;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NpJoutl0dJN/hW/l+qK2qeqTRKUGSfv5ksmtIGNTEqs=;
 b=e8o8hXNn4PVM58YlmyNcmcpRwaRsimZKWMh2OX62bHTE7G2EdUMvOggY
 IMFAOuTTm3gE8kQ/Zo+OYPxcOvKS12VHPUDPBQTU8qNTHBDqPhEHm38Y9
 B3t8Bw9P1tei+Qy3s0dEUWjERlJU/xi7JRZ9T+YH7hmXBWZ/XEi2yg4+X
 rpfHPVqTSFO1PZLiQRbwvVHj/fXWtWidTE9xCpUTvLFm3qsT9x6srOGH8
 jSxn3IF2C0XnhXHx7+kcWGtQPcrTqDfOtZp70TDkpYer0pcQ2abrq/W5Z
 0omHUsccNBfiZyNDlShiwPiNSGEMR6rXmwRXipyTmS6rU+Ak+GS6c4Yzu Q==;
X-CSE-ConnectionGUID: xn6Rjmz2RQOp9lG5HV/EqA==
X-CSE-MsgGUID: X3cVfc/GSOic3llaMD5PQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13438693"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="13438693"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 06:56:03 -0700
X-CSE-ConnectionGUID: LbEfqoURSSWhDbNMaK6t9w==
X-CSE-MsgGUID: Z9wgVp/4RJiuDy29vcSMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="58993357"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 30 May 2024 06:56:02 -0700
Date: Thu, 30 May 2024 22:11:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qapi/qapi-schema: Clarify the dependency relationship
Message-ID: <ZliJDp4TwCAWO+jH@intel.com>
References: <20240517062748.782366-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517062748.782366-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Eric and Markus,

Just a gentle poke. What do you think of this ordering?

Thanks,
Zhao

On Fri, May 17, 2024 at 02:27:46PM +0800, Zhao Liu wrote:
> Date: Fri, 17 May 2024 14:27:46 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH 0/2] qapi/qapi-schema: Clarify the dependency relationship
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> At present, the correctness of the dependencies of JSON files is ensured
> by the order in which they are listed, but in general, the mixing of
> multiple files and the lack of clear guidelines for ordering them is not
> friendly to extending and maintaining.
> 
> Therefore, I have a proposal to manually categorize and sort JSON files
> generation order by dependencies/dependency hierarchy, to improve the
> readability and maintainability of qapi-schema.json.
> 
> Welcome your feedback!
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (2):
>   qapi: Reorder and categorize json files in qapi-schema.json
>   qapi: List block-core.json in qapi-schema.json
> 
>  qapi/qapi-schema.json | 100 +++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> 

