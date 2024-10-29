Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ED8D5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fZn-0001ne-Tc; Tue, 29 Oct 2024 02:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5fZm-0001jd-0p
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:19:34 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5fZk-00086w-8s
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730182772; x=1761718772;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=za1muQm4U7f4LIt8RWK3PHQpDP1rimCjsfRVMU7u0P4=;
 b=LbxY0coQuR29nsl3BJATe9nVURNOjyW1k48hsNq//nuKkDSqAgS9bytR
 5rBYaAWtiE9yiwpewto+o8jqKA/lJe2UbMbSLfaMm2yawbgj+F5gaqySv
 n2uxRqck8F5BOfiXbwMuJvKs7f5CCBBj3rwMzAQeKe1WP5ijeoPlRqBj+
 ZDRaXN/N5KrLTkRJ2Ex//8hwlySzd6q/5soehx/7cqqgAwOVk0Q5pZ1un
 OYlrp+8U7iXfE4PDuZ61kA8bDN9RMZjkMurMQgfBEg6Z7dTm7UU68R7yR
 4RT0rrt2bSzBru1KJ+Da4lK76tg/BSe4MV9qcZfEcIXYHGUlDxmamDEP1 Q==;
X-CSE-ConnectionGUID: i+66eHJeTBm4jiID1odv3g==
X-CSE-MsgGUID: JCBC4G/3T1ix2T1O90It7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32662541"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="32662541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 23:19:30 -0700
X-CSE-ConnectionGUID: 2+hduodWREOWNFRi2hV8vw==
X-CSE-MsgGUID: s+ynI1FnQkauZP3ICXnoHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="112660275"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 23:19:28 -0700
Date: Tue, 29 Oct 2024 14:14:23 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xuelian.guo@intel.com
Subject: Re: [PATCH 2/6] target/i386: add avx10-version property
Message-ID: <ZyB9P83M1TrQ24Ou@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-3-tao1.su@linux.intel.com>
 <65cd917f-b0d2-40f3-9818-a52b340b32e6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cd917f-b0d2-40f3-9818-a52b340b32e6@intel.com>
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 28, 2024 at 11:10:45PM +0800, Xiaoyao Li wrote:
> On 10/28/2024 10:45 AM, Tao Su wrote:
> > Introduce avx10-version property so that avx10 version can be controlled
> > by user and cpu model. Per spec, avx10 version can never be 0, the default
> > value of avx10-version is set to 0 to determine whether it is specified by
> > user.
> 
> I think it's better to merge this patch into next one. It's intact to show
> how avx10_version is supposed to work.
> 

Will do in v2, thanks for this suggestion!


