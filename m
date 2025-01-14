Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66778E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhlp-0008Al-7E; Tue, 14 Jan 2025 09:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXhll-0008AQ-JX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:19:49 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tXhlg-00071j-Ev
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736864385; x=1768400385;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9krtnxq/pblrYODrtTCDcoAHY5iUajPwsbbSLDfAhAY=;
 b=DQIWVJFoQ+sNLf1+9FFHfM4Vn5XrXDsDfwoVAmY2/Sx/zManSKw9UbY6
 MfqAK3gCxTcZ566QRjr9H658epKFTZXH3HNAMdlqkFzi1Z88d/qUijZMi
 m6khTYostw8pLz8sqZUk5JE+woz5qjut4u5qy4YpjxFYF/WBQeuMEc5R+
 2cWM4PQb5nWybRaex/Lh5Wg5TYJgotDWAgFXh9noN2jCniyHQ8ZfZMhbo
 oRIp8yZxoFsfeyNbtJZfuXhV2Nr4QEI/Xn9mOHMhRRUbSAs5KmBwgbYyH
 gMgZNkgJqsUhwGCXu8/lvwHUB/eir4uV+12b8J02SxVpjWiptlKdo31Eb Q==;
X-CSE-ConnectionGUID: ouwfRpKbRra9QchpEU68DA==
X-CSE-MsgGUID: 1+VTkj+RRzyow2fZ7c+2Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37323341"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="37323341"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2025 06:19:41 -0800
X-CSE-ConnectionGUID: LHB81+DRSUuUkfGlmjiezg==
X-CSE-MsgGUID: eHiPk9KBQZGWFtIJxigv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; d="scan'208";a="104759857"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Jan 2025 06:19:39 -0800
Date: Tue, 14 Jan 2025 22:38:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <Z4Z25p0YvBEtV2/Z@intel.com>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

> I this specific case, one basically replaces /machine/unattached
> orphanage with explicit /machine one and many 'cpuN' children,
> which ain't any better than device[N].
> 
> and in future I can imagine that at least in x86 case vcpus
> might have another parent depending on configuration.
> (i.e. being parented to cores instead)

I remember that this was your idea all along, and I'm not sure if you're
also referring to my previous patches about hybrid topology :-), which I'll
continue to refresh afterward in future (after all, the hybrid architecture
will continue in x86). And I think, since socket/core/thread are the three
default QEMU topology hierarchies, I understand that it would be best for
thread to always have core as parent.


