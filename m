Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1825D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jKc-0008GE-CN; Fri, 18 Oct 2024 05:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jKS-0008Ff-Q2
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:31:34 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jKM-0000a8-5i
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729243882; x=1760779882;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=i/rKi01Zgq5e+F4+erbT7+whlLd+AmWP43j7tgcjD9g=;
 b=bKBiNo72GAmCXapDyOSa/Ay+q9r+GnFu/sMRUJwmdXxHAgqUr3NJKvC0
 hLeBoxsZJO1ZTE0Lr1RNckkEUopcHSCbp3kjwcLPIdXFWYlU/vmjIaV/K
 oSqQH2s3FnJCh7Bfx22hqwSmOmJlGDjVGoB969poaQBEcnUOJsFsH2s2x
 Y5dmNcCO2P0Thy8itFQPuTN8yupH34l+UJ2OpcT74qbi40QS73bRHXLcw
 BIneN8ITYMxVBwcs/XU3csGDdDedVEHiVguHwf9IpZWIfWK7WZvNfYskc
 Oro+SywmYNgqfI5LQfjgJIlHrYRB9qLdvQbEt41Hg4dgaQuU6KoBDzcGu A==;
X-CSE-ConnectionGUID: CTkIdtMCSNWdF5So2XVGQQ==
X-CSE-MsgGUID: LdnD4tcqTe+8BKeaW/CYHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28860633"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="28860633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:31:12 -0700
X-CSE-ConnectionGUID: r4RNDZYFQ5evepiPLKi9eA==
X-CSE-MsgGUID: 6FSjl/EESEOEWfcGdWv59A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="109633580"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 18 Oct 2024 02:31:11 -0700
Date: Fri, 18 Oct 2024 17:47:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 01/31] include: move include/qapi/qmp/ to
 include/qobject/
Message-ID: <ZxIurhh/bo8P5RFd@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-2-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 17, 2024 at 12:33:13PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:13 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 01/31] include: move include/qapi/qmp/ to
>  include/qobject/
> 
> The general expectation is that header files should follow the same
> file/path naming scheme as the corresponding source file. There are
> various historical exceptions to this practice in QEMU, with one of
> the most notable being the include/qapi/qmp/ directory. Most of the
> headers there correspond to source files in qobject/.
> 
> This patch corrects that inconsistency by creating include/qobject/.
> The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> to include/qapi/qmp-registry.h.
> 
> To allow the code to continue to build, symlinks are temporarily
> added in $QEMU/qapi/qmp/ to point to the new location. They will
> be removed in a later commit.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  MAINTAINERS                                     | 5 +----
>  include/qapi/{qmp/dispatch.h => qmp-registry.h} | 0
>  include/{qapi/qmp => qobject}/json-parser.h     | 0
>  include/{qapi/qmp => qobject}/json-writer.h     | 0
>  include/{qapi/qmp => qobject}/qbool.h           | 0
>  include/{qapi/qmp => qobject}/qdict.h           | 0
>  include/{qapi/qmp => qobject}/qjson.h           | 0
>  include/{qapi/qmp => qobject}/qlist.h           | 0
>  include/{qapi/qmp => qobject}/qlit.h            | 0
>  include/{qapi/qmp => qobject}/qnull.h           | 0
>  include/{qapi/qmp => qobject}/qnum.h            | 0
>  include/{qapi/qmp => qobject}/qobject.h         | 0
>  include/{qapi/qmp => qobject}/qstring.h         | 0
>  qapi/qmp/dispatch.h                             | 1 +
>  qapi/qmp/json-parser.h                          | 1 +
>  qapi/qmp/json-writer.h                          | 1 +
>  qapi/qmp/qbool.h                                | 1 +
>  qapi/qmp/qdict.h                                | 1 +
>  qapi/qmp/qjson.h                                | 1 +
>  qapi/qmp/qlist.h                                | 1 +
>  qapi/qmp/qlit.h                                 | 1 +
>  qapi/qmp/qnull.h                                | 1 +
>  qapi/qmp/qnum.h                                 | 1 +
>  qapi/qmp/qobject.h                              | 1 +
>  qapi/qmp/qstring.h                              | 1 +
>  25 files changed, 13 insertions(+), 4 deletions(-)
>  rename include/qapi/{qmp/dispatch.h => qmp-registry.h} (100%)
>  rename include/{qapi/qmp => qobject}/json-parser.h (100%)
>  rename include/{qapi/qmp => qobject}/json-writer.h (100%)
>  rename include/{qapi/qmp => qobject}/qbool.h (100%)
>  rename include/{qapi/qmp => qobject}/qdict.h (100%)
>  rename include/{qapi/qmp => qobject}/qjson.h (100%)
>  rename include/{qapi/qmp => qobject}/qlist.h (100%)
>  rename include/{qapi/qmp => qobject}/qlit.h (100%)
>  rename include/{qapi/qmp => qobject}/qnull.h (100%)
>  rename include/{qapi/qmp => qobject}/qnum.h (100%)
>  rename include/{qapi/qmp => qobject}/qobject.h (100%)
>  rename include/{qapi/qmp => qobject}/qstring.h (100%)
>  create mode 120000 qapi/qmp/dispatch.h
>  create mode 120000 qapi/qmp/json-parser.h
>  create mode 120000 qapi/qmp/json-writer.h
>  create mode 120000 qapi/qmp/qbool.h
>  create mode 120000 qapi/qmp/qdict.h
>  create mode 120000 qapi/qmp/qjson.h
>  create mode 120000 qapi/qmp/qlist.h
>  create mode 120000 qapi/qmp/qlit.h
>  create mode 120000 qapi/qmp/qnull.h
>  create mode 120000 qapi/qmp/qnum.h
>  create mode 120000 qapi/qmp/qobject.h
>  create mode 120000 qapi/qmp/qstring.h
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


