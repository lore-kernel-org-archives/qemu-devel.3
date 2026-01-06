Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F81ACD042C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 01:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcwC3-0007i2-K5; Mon, 05 Jan 2026 20:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vcwBw-0007gB-78
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 20:49:00 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vcwBs-00063x-MZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 20:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767664136; x=1799200136;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oQw37mrPeKCONvqxalv6NuwWIUs2ilGsowyaUG3DAlI=;
 b=N2Gb3MQCoJ9rVdjKVt4CV7OYV+T6PfVkl2yYNS83oKIO+B+SEm/MRwFF
 4dErb+37uQzioW175Clw3QB2DtSdEYxZD4ECgP4jfMzSuor6mgwqZoQmT
 ar0HqqQWlwyackfin3AQdzdCpTCCubG/pG2hKDihuHPJBvDWXpo82rM5G
 sqVSqIedeSuuq9FFxpnsPbCWhAsiD980f4QGVS5S83AlbwL/z7lzC+seA
 In39ECE0MbLFCkBFn/8n187lbutEyvhgap43E2Tj151iEwrcVDCGl6+Zf
 EVXkpvKCcS4vMdTXSe+Mt3JSuSI5OPCA6SFCKXdUFFevoPXSmhRDyfTLp A==;
X-CSE-ConnectionGUID: s+o/Q5sUTCqFZnMjfb95dQ==
X-CSE-MsgGUID: 7dMn8AzNSROYQRTGIFffPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69191602"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69191602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 17:48:52 -0800
X-CSE-ConnectionGUID: wxjDbLhHQkKH49kU/7tWmA==
X-CSE-MsgGUID: NTUsodWlTYC5Pp26oSc7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="207007568"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 05 Jan 2026 17:48:50 -0800
Date: Tue, 6 Jan 2026 10:14:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 01/10] qom: Rename ObjectPropertyFlags to
 ObjectPropertyAccessorFlags
Message-ID: <aVxv9zfg1S1CVNcW@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-2-zhao1.liu@intel.com>
 <20260102131253.5b60853b@imammedo-mac> <aVtuOHU6xmhuDx5v@intel.com>
 <20260105132820.4a411827@imammedo-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105132820.4a411827@imammedo-mac>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

> > I'm not sure about this. Currently, these read/write flags are actually
> > specific to pointer properties (as showed by the changes in this patch,
> > which all involve object_property_add_*_ptr() / object_class_property_add_*_ptr()).
> > 
> > Other property types doesn't yet support flag parameters, so additional
> > interface modifications are still needed.
> > 
> > And for now other property types either need to explicitly specify get/set
> > accessors (e.g., object_property_add_bool()) or directly use the default
> > get/set methods (e.g., object_property_add_link()).
> > 
> > If we extend read/write flags to other property types, such as adding
> > "flags" argument to object_property_add_bool(), we must ensure the
> > OBJ_PROP_FLAG_READ flag align with "get" argument and OBJ_PROP_FLAG_WRITE
> > flag align with "set" parameters.
> 
> Ain't thouse accessors callbacks?
> /I mean to you still can check flags inside of generic object property code
> without touching setter/getter./

Ah, I see, the default flags is OBJ_PROP_FLAG_READWRITE and I can check
them before calling setter/getter.

> >This would introduces additional complexity.
> 
> it still might be woth considering to compare this series with alternative approach.

Yes, will try to reuse current ObjectPropertyFlags.

Thanks,
Zhao


