Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97A7EB596C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4Gq-0004bP-DR; Wed, 11 Feb 2026 02:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq4Go-0004WO-4v
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:04:18 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq4Gk-000167-Uw
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770793456; x=1802329456;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=6SagR5sLtjmWnazbeIrSMQLAJQnqFGo3YpBLFpYAgj4=;
 b=Qa60Bam6TWmpHzJwxDbHfLnFhR4kL7C5Gq7IwUdJeCt18kYKbVg1bJ8b
 +VHp+kU7Bb1yD8R9sgaGW2DkV+gEywOxvDoeErE2ECDmcqZZvVwX0BCiU
 CGzZudXMIkEVW7BIIR56ta2wqjwpWwi61cS4pVhDykipw3nCSkcGYpj0U
 BjvoJXJMfpUxFRVGqtJ9jDhDecQVDmQdwhyxQ2hulX6Rf8gtQuGsNIj89
 NfvalPo0Kb9froucoEvL3XSdBRlOwIiGySJVofiEJk0toXCXhCBBNJESn
 6MyHOuToZQsIghn8+eZUQzdFOL6mYxcm69cxLXsS3UnTF+RF6iticlwt9 Q==;
X-CSE-ConnectionGUID: vkqGRllBTDyTE241865OCw==
X-CSE-MsgGUID: fNvm2eeaQLG7l/qDlkBCeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71832326"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71832326"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 23:04:12 -0800
X-CSE-ConnectionGUID: abLghdbzRAeWjMB7ucDigg==
X-CSE-MsgGUID: UWDyrnE1S16xoVJ3zrpwrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216467956"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 10 Feb 2026 23:04:07 -0800
Date: Wed, 11 Feb 2026 15:30:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Message-ID: <aYwv/mcUBXy9kUYZ@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYsAuFNQQvwYiLPI@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 10, 2026 at 09:56:08AM +0000, Daniel P. Berrangé wrote:
> Date: Tue, 10 Feb 2026 09:56:08 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
>  properties accept flags
> 
> On Tue, Feb 10, 2026 at 11:23:41AM +0800, Zhao Liu wrote:
> > Update qdev property interfaces (qdev_property_add_static() and
> > qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
> > This enables marking qdev properties with flags such as DEPRECATED or
> > INTERNAL.
> > 
> > To facilitate this at the definition level, extend the boolean and
> > uint8_t property macros (as the examples) to accept variable arguments
> > (VA_ARGS). This allows callers to optionally specify flags in the
> > property definition.
> > 
> > Example:
> > 
> > DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
> >                   .flags = OBJECT_PROPERTY_DEPRECATED),
> 
> In other places where we track deprecation in QEMU, we have not used
> a boolean flag. Instead we have used a "const char *deprecation_note"
> internally, which lets us provide a user facing message, to be printed
> out in the warn_report, informing them what to do instead (either the
> feature is entirely removed, or there is a better alternative). IMHO
> we should be following the same pattern for properties, as it is much
> more user friendly than just printing a totally generic message
> "XXXX is deprecated, stop using it" 

Yes, rich deprecation hint is better. I think this still depends on
USER_SET - distinguish internal/external or not :-(.

Since when we mark a property as deprecated, its code remains in the
code tree, and internal calls should not trigger warnings. Deprecation
hints are intended to reminder external users.

Thanks,
Zhao


