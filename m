Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34930E68956
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 06:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6OQ4-0000dg-UG; Thu, 31 Oct 2024 02:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6OQ2-0000d3-1Q
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 02:12:30 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6OPz-0001zj-Mr
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 02:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730355148; x=1761891148;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eShlkFumDMZph9vrXkxUzbelduX63gWellm4TjG0Suc=;
 b=VHDkn+3/OwmNDDbLpYooarPojNlssSIXJyGUkRhn++YPbl3/0g0IcGKm
 d8dl4Teh5n2Ch9s2Ag3ABaW2/5G/kx0Y/5BDRZT2bnLUeGAxFV9J/5Kja
 YfHA5/nO54rtPUxdX7H7M8+T5uF7z4TpmEWgloNJ3JTIGg0V4w6x1Bg4/
 H0qlWSgaLebcYEaQKG18GqXOCfrG9Vgh0almnjCDhYl9YxI+2E4xO6CPR
 zoouwY+wd+2pLtghW45AJpQK/MXPye5S4y4bYHjwV0B367RTH8OroMDd3
 Lh/ipiXUmdwS+4F+e8r9E9QQIMB/CYmvVdMVd2zxd75I+RiFIbsOMHaID w==;
X-CSE-ConnectionGUID: hfNQ3mA6Rd6x13ZCsr4MNw==
X-CSE-MsgGUID: hP+tJEiGQwi6g2CjvMeFbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40693333"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="40693333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 23:12:25 -0700
X-CSE-ConnectionGUID: K5ZCvhcRQ6aOA4ejXcrygg==
X-CSE-MsgGUID: RPjgPz2lQhqf8O7JTNtqqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82645503"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 23:12:23 -0700
Date: Thu, 31 Oct 2024 14:07:16 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyMeiXbey7FlEhad@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyHyBnPvOHsSdh8D@intel.com> <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
 <ZyIy4OGSGPhAZutK@intel.com> <ZyI9P1ftFOTUhDzb@linux.bj.intel.com>
 <ZyJW9nGgpEXqiyli@intel.com> <ZyMKAwq4lsk+ozu3@linux.bj.intel.com>
 <92635403-e483-45a8-afcd-0e8fa5080f23@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92635403-e483-45a8-afcd-0e8fa5080f23@intel.com>
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 31, 2024 at 01:52:24PM +0800, Xiaoyao Li wrote:

[ ... ]

> > I mainly want to let avx10_version be assigned only when -cpu host or max,
> > so that it can be distinguished from the cpu model. This should also be
> > Paolo's original intention in v2.
> 
> avx10_version needs to be assigned with a default valid value, when user
> enables avx10 explicitly without specifying avx10_version. It also applies
> to (existing) named cpu models other than GraniteRapids-v2 (which is added
> by this series). E.g.,
> 
> 	-cpu GraniteRapids-v1,+avx10
> 
> So if you are going to make default value as -1, then you need to add
> something in x86_cpu_load_model()
> 
>     if (!def->avx10_version) {
>         def->avx10_version = -1;
>     }

Good suggestion, thanks for the reminder!


