Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED4DC88E59
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56uj-0008FK-GE; Fri, 11 Sep 2026 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x56uc-0008Et-4P
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:27:51 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x56uW-0005xc-Ge
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:27:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZek1mmOK00AIApFxDWzQ2WbOOVZ2bko4mMIdXFtBtfvNQw2NMspeYXbJjVDHMkSjDu8U8a5GWTaT8YteBCWgD4/EdcJ49gd6QEncaT4lh38ClQW8zckJ4gus9XbIyXwQm/PgULdQhuGLkZi5lFsFpDjFoDB/29k0FXRfNG0+8Lsj//yS9UWJjUDDtLYNWuWDYte6rXuR6MaKTCK9rlxgIorUgSjxB3oc8Wn7h/sCbyHCk5pmzkcF0hRKz1x8lIY8jkYJL0P+9m5TXp26EDkfkrl2GqudHO4T1MxZjMaWGUJYDDJqnxLedCDaJSeYFRSv6F9WWgMB6hxnXARgwL1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=useCmkxq+Bza6tGFe7yOaem9wIzsBoubYD0sDRjG/YU=;
 b=aPpBimHhp2FRXvXJAlF5EjgLN89G+lyr/lx0SC7piO/dPrsoEf7WgP5Nw/Ud9e4djW8PnCZ2jVKqL2+A2MRIDbWRuuaLMNUXT54ZvfkSDgx+yOrp49tbkYfe77kMTKlrwdgj8D18C4GcrVSfEfJ8mVadHiQDFmVeRUHXQpe+ROQMDmCTNDuTv5+J36cB3Rn/yJPDbbuehDZz/l+ZYl4gm7xOHuELiz7eg2pEl1RrvNgx8/hwcpHLCQUtl8Ro94au87OgcewUEf+S1Cj88H1qLmaHV/LmFEdfm+oc+kll4eOdNx77MIIbEZUVQjFtXEE0wewS5P85PsSmOVKQyNO+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=useCmkxq+Bza6tGFe7yOaem9wIzsBoubYD0sDRjG/YU=;
 b=e0MaPB+WQu1fqIwgn9ZAeRRQ4SuXQRZvbyEe+ViR5cp1aPSqox15c7TQWS1t9pkCJ9K1BRY1VQcKHhw1wvD/khpILZL3uxytYRa2dXTLBuEfkVyg1hGUwXC54tezE8Cl8jrJEb5kDkdhcMrCM6oAoZGXfSgr6Cm1BaTuKoN+ncc=
Received: from SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 19:27:34 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::11) by SJ0PR03CA0005.outlook.office365.com
 (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 19:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:27:34 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 14:27:33 -0500
Date: Fri, 11 Sep 2026 14:22:33 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <n7rvq6pj3gfdzfh7e3celud7zopx6df5pfmuettyjhaik3uavn@rlokkyvupeki>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
 <87ecf3rgb3.fsf@pond.sub.org>
 <wli5vbctw6wxsqlxs6e5ojarvxq3xj3xv6ottjfenios2ndxld@etwnuqkbvmzf>
 <87mrtobabo.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87mrtobabo.fsf@pond.sub.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa0c58a-a09a-44cc-d584-08df103abb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|3023799007|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info: JETXfxdyg28QT+HR+czO7ez99lDSpFtWkNpR8lBgFR8SUd3oM64nK8eulrXI5S1jhmO/H6dOwxA5cLLLlrthSEoLdh95RY4QmvUUYqye8EfaRXgkCESDx136twlzd9hjvIWw2ZIvOQQEFDRbeb3AQ+aiQUHY1ZrN6KNmamzAzJ0fntUmLfVeFsQETiTVL7ZoKJ6MATV877n/e2ekXd8drCHlyU9SHivq7iKzfKrsoKOkHFeK9fUx+KF+g49ds067UozQGObgBuHYAaQgqfrAkYo5pIgWUwrQvDe/NwxRrwYoZKKOz7+dvwpADW6eYpQ/9gJq3pXthKhDaQBvjuedi3omxuFJNKYrsE5yV7XSKWqXaDtYGmPwmQCUqEdAdIfxEa8HGe386Eh2K1gjGAretwlTtia4TCfpQfcEuGsh+HKd/VQ2Ro0QNrBCvlpUOEM0wAtHFj75JmuZGxkMQa4w6cBfvIfVJ/Z0cqu84G3SO0mZwIR5DMoCuyYJ58Ssp3rRKm/NsavQUbZWL0Dt8p7hP/6B3Co7RXPyDZ4lBT3Slx5hrpkAAf3O8dlyUu1NFsnh2UgAxeygW+IK+1IC2FiK9KGXFVOdsSrQLBiOFahP5hPXVsqXzmBn8/h3sUZpsOwyD9ve+DTWh82+g8VvFNahLeNOgR2FE/gLN5u2YgiwthriL2xRktzhzgi6NSPefBbduskMJJ2dsMT5REoxpFSIcTwTgUg3SpeW6n53VtVLADIO1Vnv/FqfSKFpnOn/4Wpb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(3023799007)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FpXhxRqqL6+1jsce3MK4CS/NaYjPqfzcZgqBGYSOXQoXC5sQG092kK7FwdQFE/kL2s1keUsT0xpcJQDAIRU6OF90bIcT63sLSEVjX5q1LnBOWEVHqT+R/pQF7N8O1nWv0ICO8Ioof1OWffpDMSPjKbYkrlAdKPO2Y/nImHeVoIbGgNH5gUlpKyTsJhZ8DlQnABobIZdKo/NI2kD8ntpzmcrSakJ9VCslbCjE8rBZKuVpdJxyMSWurvOyG75zE+F0XlOvElMLwneezbA0DAJzg5IguEB/09sAKhzij9HCocv+9G040W0L5QoohFROg5fraMqe/VOqi08IydrpjLsoP+/rMIPK5ttJ44LkZkrh2ayT7MHgXdiBy4Pbd6OXdld9YbI5MMX0W4E853Day9SLzUH76WNVJ+/Z3/VnqhiO4o51PqsaSOUlvfevnt6UqJDa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:27:34.3829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0c58a-a09a-44cc-d584-08df103abb38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 11, 2026 at 07:56:11AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > On Tue, Sep 08, 2026 at 04:03:28PM +0200, Markus Armbruster wrote:
> >> Michael Roth <michael.roth@amd.com> writes:
> >> 
> >> > From: Peter Xu <peterx@redhat.com>
> >> >
> >> > Host backends supports guest-memfd now by detecting whether it's a
> >> > confidential VM.  There's no way to choose it yet from the memory level to
> >> > use it fully shared.  If we use guest-memfd, it so far always implies we
> >> > need two layers of memory backends, while the guest-memfd only provides the
> >> > private set of pages.
> >> >
> >> > This patch introduces a way so that QEMU can consume guest memfd as the
> >> > only source of memory to back the object (aka, fully shared).
> >> >
> >> > To use the fully shared guest-memfd, one can add a memfd object with:
> >> >
> >> >   -object memory-backend-memfd,guest-memfd=on,share=on
> >> >
> >> > Note that share=on is required with fully shared guest_memfd.
> >> >
> >> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> >> > guest-memfd may return negative but not -1.
> >> >
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> >> 
> >> [...]
> >> 
> >> > diff --git a/qapi/qom.json b/qapi/qom.json
> >> > index 4a9b7f9088..909add4299 100644
> >> > --- a/qapi/qom.json
> >> > +++ b/qapi/qom.json
> >> > @@ -771,13 +771,17 @@
> >> >  # @seal: if true, create a sealed-file, which will block further
> >> >  #     resizing of the memory (default: true)
> >> >  #
> >> > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> >> > +#     (default: false, since: 11.2)
> >> 
> >> What's guest-memfd and why would I want to use it?
> >
> > I'm planning to squash the below documentation patch into this commit so
> > it can be referenced in the schema documentation for the @guest-memfd
> > option.
> >
> > I think it explains the "what", but the "why" is a bit awkward at this
> > stage because we anticipate a lot of use-cases, and potentially it
> > becoming the general default for backing guest memory that doesn't
> > specifically need any functionality provided by the other
> > memory-backend-* implementations, but admittedly at this stage it would
> > be primarily for experimentation and getting infrastructure in place
> > because there are feature gaps like hugepage/THP support that would
> > prevent it from being a drop in replacement for memfd users.
> >
> > The first 'real' use-case will come when either one of the features
> > mentioned in the documentation below (or something else) goes upstream,
> > or (more likely at this point) the in-place conversion patches land and
> > the @guest-memfd=on functionality becomes a requirement for Confidential
> > VMs that want to run in that mode (which does have immediately tangible
> > benefits like not needing to reallocate memory after every
> > shared<->private conversion and will likely deprecate the existing
> > out-of-place conversion mode currently used by SNP/TDX fairly quickly)).
> > I plan to add that use-case to the document as well, but it seems more
> > appropriate to do so in the context of the in-place conversion series
> > where I can talk about it in a non-theoretical context.
> 
> Would it make sense to mark it experimental until then?  Also makes me
> more willing to accept documentation gaps, and could serve as a reminder
> to fill them.

I wouldn't have any objections to that. Though once the in-place
conversion support lands and comes to rely on it, we'd probably want to
drop the experimental tag at that point. But that all seems fine to me.

Unless there are any objections. Peter, does that work on your end?

> 
> I've come to ask "why would I want to use this?" more and more.  QEMU
> has so many knobs to push and turn, and we provide so little guidance on
> what to use them for.  Users' need for guidance is easy to miss when you
> don't feel it yourself, because you're deep into the feature.
> 
> > But hopefully the below documentation is enough to at least let people
> > know who should/shouldn't care about this option in the context of this
> > series though. If that seems acceptable I can it into this patch for v6
> > to compliment the schema documentation.
> 
> Yes, please.  Consider wrapping lines around column 70 to make it easier
> to read.

Will do.

Thanks,

Mike

> 
> [...]
> 

