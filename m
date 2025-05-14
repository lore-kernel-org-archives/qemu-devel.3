Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5ECC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEGX-0000DY-I8; Wed, 14 May 2025 11:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFE5g-0004GT-Ea; Wed, 14 May 2025 11:32:21 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFE5e-00018V-HG; Wed, 14 May 2025 11:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747236735; x=1778772735;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PIjFnfnYW+H9SVImmOI0C1OSncQ/MUhmxQEZA/8kCt0=;
 b=d/fcDRVSjjB1THJzrQIw+QS8qbINwZBfDLs56Zpl3t2mFUYzHfClvWrV
 D64tMLM/Mm5rdkNQAX5ldMVMh8rw1dXJpfGUlIp0zLJpV59Fi2c39sw0E
 iS6DqYHhGJOjxtt8QIZO6GNT1e2ZLN0Gd6pshsl70I3ALa+5T533X58hR
 7A5eo2I2wUm82iFziO4qtCBpYKPjQx7vQKH+oHtW/yhZ/VaT5wqSIvHCn
 K6SiWaVOlMS7WQZDpP7cJj2VH96nNZ1gSTAr93yB19azUWUoWRXdf/XhQ
 Ynaj8/R3kpiuPNsM40nsTNRn/C6fTnxMPp27bqqGJFvMtYQRZAfaiYTqx w==;
X-CSE-ConnectionGUID: zbqly3kTS0iJjR0Ijs3Xhg==
X-CSE-MsgGUID: wA85CKvkRqSks3bRqTeXRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59366817"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="59366817"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 08:32:11 -0700
X-CSE-ConnectionGUID: /LRnnEpSTMuXggeUjxigKw==
X-CSE-MsgGUID: ktthpLA7TESE/mgTNTnYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="138128811"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 May 2025 08:32:07 -0700
Date: Wed, 14 May 2025 23:53:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Message-ID: <aCS8aHsF+VAuj01D@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
 <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

> > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
> > +                                          s390_pv_guest,
> > +                                          S390_PV_GUEST,
> > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > +                                          { TYPE_USER_CREATABLE },
> > +                                          { NULL })
> 
> I'll note that existing callers of OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> happily ignore the line limit and put it into a single line.
> 
> (which ends up looking better IMHO)

Ok, I'll onor the existing conventions (which I'll apply to other
patches as well).

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

Regards,
Zhao


