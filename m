Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517D9C2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 08:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcfeJ-0007kF-Ny; Mon, 05 Jan 2026 03:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vcfeD-0007jh-Lq
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 03:09:07 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vcfeA-0002Z7-Es
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 03:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767600542; x=1799136542;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=C/ESKvPoYQ25jGL1V9iWNitjx4rrjRjsa5yd1yUDkA8=;
 b=RATWm1QZwNDJfC6hQaDh+JmcXQDk5LmRwAN3KIkzEGRmWGceLpU40XcU
 YW6AyqU2NoTLAZds9f2T1qElEVuKfgW7Mcq0UdnSeHEvHyzYXV9G94KJh
 apHBTSXknQcpRu2nSV1d1U8O9QdcRRtrCFhW5ykQyrV6QciEvx7yGuY7A
 hK8H4jEywIqzCtyZKoexBFJvL+yw/knCSxDg8ZHywjWKFKu5LucMmVu51
 g78qovy+8xOUT065zWS9wh+Qtx+x8xXULReuf2fINaZiYHCPwjNLqVOAA
 eRgtF21jRMaS7L0C3ykWMGF7xX363qnt0d1ce2cGAS0IoW7gIJBnUbHtY A==;
X-CSE-ConnectionGUID: qPx8ck9WRR6tGXassbYbXg==
X-CSE-MsgGUID: CMG0IBGhS5OUGSGBOe7mHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="86552121"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="86552121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 00:08:58 -0800
X-CSE-ConnectionGUID: Zt2oDJz4Sf+sOBOcMz544g==
X-CSE-MsgGUID: bUFwb0cFRCanTS6lkJSeRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="225867180"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 05 Jan 2026 00:08:55 -0800
Date: Mon, 5 Jan 2026 16:34:20 +0800
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
Subject: Re: [RFC 07/10] hw/core/qdev-properties: Allow to mark qdev property
 as deprecated
Message-ID: <aVt3jJ2JqWI96yZE@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-8-zhao1.liu@intel.com>
 <20260102132717.1211737f@imammedo-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102132717.1211737f@imammedo-mac>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

> > +#define DEFINE_PROP_UNSIGNED_DEPRECATED(_name, _state, _field, \
> > +                                        _defval, _prop, _type) \
> > +    DEFINE_PROP(_name, _state, _field, _prop, _type,           \
> > +                .set_default = true,                           \
> > +                .defval.u    = (_type)_defval,                 \
> > +                .flags       = OBJECT_PROPERTY_DEPRECATED)
> > +
> >  #define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
> 
> adding flags to the end of the names, basicaly spawns a lot of vartions of the same macro,
> 
> perhaps it's time to just add flags field and consoladate existing 'flag named' variants,
> the one won't need to introduce DEFINE_PROP_UNSIGNED_DEPRECATED at all,
> just use appropriate flag(s) when decaring property.

Good idea, what about this?

-#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type) \
-    DEFINE_PROP(_name, _state, _field, _prop, _type,                       \
-                .set_default = true,                                       \
-                .defval.u  = (_type)_defval)
+#define DEFINE_PROP_UNSIGNED(_name, _state, _field, _defval, _prop, _type, ...) \
+    DEFINE_PROP(_name, _state, _field, _prop, _type,                            \
+                .set_default = true,                                            \
+                .defval.u  = (_type)_defval,                                    \
+                ##__VA_ARGS__)

...

-#define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+#define DEFINE_PROP_UINT8(_n, _s, _f, _d, ...)                       \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t, ##__VA_ARGS__)

Then we can mark a property as deprecated by:

DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
                  .flags = OBJECT_PROPERTY_DEPRECATED),


Regards,
Zhao


