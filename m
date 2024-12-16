Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55408E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 06:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN4Uf-0006QO-8q; Mon, 16 Dec 2024 01:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tN4Ud-0006Q5-Ag
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 01:22:11 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tN4Ua-0005Td-TY
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 01:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1734330129; x=1765866129;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GvlmLzmtPhJHSVK0Nk4k+V1K8f2GL6IgpKllqJjUXk0=;
 b=SyWkNkYuLCFe5xFq/+tF7WNnKfUQa72ET4T9zbBeJvmdFO9gI2mokLwL
 fNoSKQSGv93s5l33faya2VYJRcnc2o+XcjnnowkArPyayBBqia6HlJ9Wl
 c/WJKcC4qabA8M+uIRptPcRarL5sMMpRx1bberj6uGRY7jB5erWonqhvx
 dJ3XRmJd2g+gzE3esT3NylPP8nQIzufCbiHSs9uqIJN18MSKAQc1u3h5r
 agT406EVU4luKO1wqJPrZfgOeHd8D8keimUjAR0IJgV7NKPfSp2bZsTUW
 jP3deoiSTRlgeHtC5ObQUtFTQunYqWN9oTszeyRFpah4zvH62gnteK06r w==;
X-IronPort-AV: E=Sophos;i="6.12,237,1728943200"; d="scan'208";a="27655624"
X-MGA-submission: =?us-ascii?q?MDFDHmei8uEFCosOKQVQwd+7eDDrxP2BoRgpiu?=
 =?us-ascii?q?2NCHIfgZjTsJJGb4KqlvcMnls2MUCsCE7UR3sBKhKgl+v0dK2ocL9pGU?=
 =?us-ascii?q?Z2OMduW6tAosbZgK4kYXPzhorqze6QA+aiAokzAnmJ4AFCW1edOxxgTv?=
 =?us-ascii?q?jVtVhQv/Z/CRvKyGttV+BGeA=3D=3D?=
Received: from mail-db8eur05lp2112.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.112])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 07:22:00 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDpJblqyLd35oAXOtZHILnB/aoRrwcbHSgDUGSuXlYykuexcwf6zXriRcY4GZDmtYOYbwESvoyPynpY/aYU7pGeE3RC0edeLC7uljvhqhBmJ/8nmJhV+FfeG22mRP8u4urFl1bYrj79FBwePR+QrJR8wXAGREglUgwGhGv2Lo7SsXTSrU79ful0tk427NJ+zYNIsCm5q2eIvpQgFGlcJO/JN9Rjl/8jnC0UBbG+WbT8JF21wMTV9FbMNBulmCw1Gpr2STqXIOWfezy3lQO2K96zbePpezwBio9eE7Z1gDeh8vx3mh0s0sqcYj5KsGf2v9pNpRhSBp7ZVsPBoA3BEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvlmLzmtPhJHSVK0Nk4k+V1K8f2GL6IgpKllqJjUXk0=;
 b=YaxZLxXqV7PHGGUao9MubpZJtjLn5kAdBe7GfdRx9PodPBWjamlzvS/Y79O63Az5RcUVm1CuyFUZ0wiZkzBoYbPhXvjeJ2sA1y8/kQ36lexV4g3CCpjzDabCGOxfqQl/nylBP0z1obtePwZUWb4dXPbIYjo/KU89nMQ24w7jgGSKdnIXjvKseQ6RrpNcMT7UqWev7bhkOsvWLSYSSj4T846JFgJ+ZfoANEnRmPjM9HSGHDlbCLTtjty+ViaBhPEy+OZJjiKNib2qcmSf3GfsGKcMCVciGBlhib6uxUm9EgKJCjTPoVRcPFExf0/RmuiTLIA9v8HIe05ASH3iBoCKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvlmLzmtPhJHSVK0Nk4k+V1K8f2GL6IgpKllqJjUXk0=;
 b=g4IbVudEHt94R+PTthlJ3YUUEwgV4sQex8GFflldeqjgmwPhBYDJDcrbeKPkEhHXg94zgl187rYfjQbcg60TsLVb4e7636neC/+3ClqiODjdiDY5Itn3lv8TvHzNN7Yhrl1C4VaRebDkBeifvff76jspEbLT5BEX4N3PojoAoF6PbTjAr7nRs63gNzxv9Gv2XQuH82V+jMtNw8MruwKod/5xKB1Ju+uXIjDlnCxGEaGxNspKrYJ8d6AZ398HFf55Jh7rE+/4qVMHOpAdFUHE5W8noAP3JrgE/QMI9aQBpqWeSz0pAORCTIwCA0Z8we43VC0P+J5lh/LR5J71VzlF5Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7509.eurprd07.prod.outlook.com (2603:10a6:20b:2aa::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:21:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:21:59 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Jason Wang <jasowang@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "chao.p.peng@intel.com" <chao.p.peng@intel.com>
Subject: Re: [PATCH v6 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v6 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHbTHGdsnYz8yfr+0uZAKmPdDkQILLiXZYAgAEruYCABONgAA==
Date: Mon, 16 Dec 2024 06:21:59 +0000
Message-ID: <52e96ddd-4ba3-4e71-9646-4c6ed46111de@eviden.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
 <a9f91dc0-a424-453f-bd8a-7777e269b961@eviden.com>
 <CACGkMEsYhZ2QwCMyDBzD5mBUZ9EuKaME=9=oB=Sm6YTudQaHjg@mail.gmail.com>
In-Reply-To: <CACGkMEsYhZ2QwCMyDBzD5mBUZ9EuKaME=9=oB=Sm6YTudQaHjg@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7509:EE_
x-ms-office365-filtering-correlation-id: f354b065-a9d8-44d6-a0f6-08dd1d99f2b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bTQ4dWo4WWpzeXJBenVMUzhQNDVLMFlMaHcyaUxFRG5CZVM2YlJIOEIrMzhK?=
 =?utf-8?B?cWJZNGhUREJOakpWYkR6NlV0WFd4TzNzSktxV3RHQUVRcjF4NXA0VUlvYlk5?=
 =?utf-8?B?QWo2LzQ4OERpaWNvclliMGtpOGdybDZoS2RBVlFCVm1ya0Rkb2U0aGZVU3N3?=
 =?utf-8?B?QXVHYWtiWUlIZ202c2pFNzFmZzl4enEzWDVVSjRaSUNWR3FxK0lOT3p6cDdi?=
 =?utf-8?B?d1BybjJjaENkVlBUSjkvUVVCS3J5NXRCNUhwR04zQkhnWTk5YVE2OHQ5WmJC?=
 =?utf-8?B?NXdOZEdUQmdXVDFsOEViWGpFblA0bXV3MEhWcEF0S3BmbXpINThoU0xRWFpa?=
 =?utf-8?B?eTgxN0I0L3VHQkZDbnVZR0hiY085c0J3Y0VoOWt6eUlXYWxRNU9OZFFwMWMz?=
 =?utf-8?B?aVZ5SmJuOXZzOEl3UkJNTG1TZ2I3YXVsV0hmbFJwSnBxQm53UDhtN3NCNUxU?=
 =?utf-8?B?dWFQVFVlY2QzMy9WRVM2WkFCWndaYURiOERSclplN3hDdllMUWNRTXJkTjY2?=
 =?utf-8?B?Mnk1cFd1enVKN09JdTdIeER5TlJHaUU2cHd6UEt3SmNkMzVHUFJVa0pENUFL?=
 =?utf-8?B?VXE2eHNJblNHOVhaZDlUK1ZGazRkN2R2ekFMRnVjSFpZK1lPbTd2QXNOU1JK?=
 =?utf-8?B?Yi9remFFQmRmYkNCWEp1SGwrZGdhN3Rkc0JzWkJhdGs3Nm81OXM1NUx3TzA5?=
 =?utf-8?B?bkEyWkNCYUp5V29id1lTOWpiK3ZyZldFSS9yUGZad0NhSmtZbDhrbit0azFK?=
 =?utf-8?B?TlpVNXRRL3pGQytwUlhDRS9RY0I1aFo5ZG0zVGp0ZGNrT2FydnU0bG93SW5l?=
 =?utf-8?B?OWN2TDVZWU1JWEpoVW1USzJubmVMWHRqY2h5YlVMNlR0a1F6Z21RYTI0SjFR?=
 =?utf-8?B?a1JYRDVWTi9GQ21CQ1pVQkZiZkErZGd6dytzTUJLZHFyRi9vUSszdGhmOE5r?=
 =?utf-8?B?VXNKbzA4ZGNXTll3ZEM1Z3hzT0VIR0cvN2FOa2xkT0JQWXNUTWJEVjJUNldh?=
 =?utf-8?B?Z0k1VmFvWmZOSlNqcGV5S2xseTVLUWppMGtvM2VPY0dvK0piVms4RGM4cW4r?=
 =?utf-8?B?R1RzaVdoNnhiTnNtZUVrazBIUjA4LzhjT28rTkhYSER0amJVTkRqTUJ6K0g5?=
 =?utf-8?B?YmwzNzI5L3NzRWZRaTZOVEdFMUtWSklxWk1tUkxkVjlkOUNXQ1c4L2NKZjk5?=
 =?utf-8?B?TEVqemlpWm1QNE5LRmY5b0VXNmFianVSZ1UrbnBsMTF6ZEs1UnZCTzJIUlh6?=
 =?utf-8?B?dmt4djFFNkErU0VNaG1yWEE1Q1ZmVHA4MEczU0JiRGp6azNnc0RLV1RmTTFC?=
 =?utf-8?B?WkhBRDB2VmwrUXJ3alFQQzErL1NwQnhEM004QlAzNW5YQlpFK1loQ3ErVnhv?=
 =?utf-8?B?NkdBVnVGWjM4eWlRaFh2enBzL2FNSTZDL0UzbWN2SklyRU10SVJuVHNRS0lI?=
 =?utf-8?B?aW1kOU5tWE1GcGVjWFV5YU5GY2IxTm1kMjhNa0tYbTluSytvWEtCa2cxZDk3?=
 =?utf-8?B?YXZ3VWkycGdONzIrQzJGSER5QW83Z1h0VlN2MHcwbXRXdFJTVFJlVmdVQXBP?=
 =?utf-8?B?RlluUFZhSVg0S3FGS2ZsL0l4TzdyZ2J6TloxaDgxR2ROaXFtM0tHV1RCWDBG?=
 =?utf-8?B?NFN0aS9JZFFERlBhOHVyRjJQR2FQWFF6T1N3U1ozREJzRW9EeVEzWGFRNzRB?=
 =?utf-8?B?cHZzZzNBUDIvZTF6OEM2UlFQNVlQTDNVaHRSUTRxOC9VMDBIdWI4VnBCNVZ5?=
 =?utf-8?B?Q0NoWHE3T1RFd1hPaGJIT2Y0L1Q0VHBqUnNTY2ZvTWh5ZG1Qd0loWFFWUjNH?=
 =?utf-8?B?TisvcXdoZUlGUHE4OSt0N0dBZXp1aG5QQ0pjRysramZZOHV6aytiNzVLSndl?=
 =?utf-8?B?MDdEanNTZjc1WHlyL2VLeW9ZUm4rVklZb1h2MFZMV0ZQZzhpeGpGaDZnZm9L?=
 =?utf-8?Q?hXjdSoUxGAZ4H235E+svimD7k9pSKP4D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjJBTWxqQkhXSWoxSWVMRmUxK2x4QjZleVdoZGtZdnI3MlB5NXRtemFxaDFs?=
 =?utf-8?B?a1RYYmN4MnNEZnlUeWttTktyR0k5c2lEWEJIcWM1djJsK0c3MkYvdFVvb0tJ?=
 =?utf-8?B?bVBHVnYzcFhPc3hVSmswUHIvWG9sMVkzKzZTN3pNS2RsajlZcjZlYUJwc3Vk?=
 =?utf-8?B?YUY4WjFqQUgxdkFoS3hEOEZGbXpJL0NXdHpULzdZMXNlU0d1L2tZdmJGWk83?=
 =?utf-8?B?Wm8wcFRDYnl3N2s2WHJkQWhvWW9GMHQ0VnRncUs4VUhHSDZLWWZ0RnB3MWF6?=
 =?utf-8?B?bjh0TXV3MUxzaHdoWTJFbEFWREJkeVRtbWZPRkxtVElDcTR4anVwVnN5UmI3?=
 =?utf-8?B?MjR1dUg5MjVsRmgxcGV6OGZ0MjJJam5odmgzWlVtMFhLOEVtS1BjTTIwaHdw?=
 =?utf-8?B?dTNKWEdBNkRkVjRrUDYxZlJqdzlGWDJ0THZ0VExJVVBERTBjRE14dGJzb1pC?=
 =?utf-8?B?Uzl5NnExdEdUVk8yMCtNdUVhVTIzaHJScXh5aW9MZHJaYU5kU3d4OU1NdkEr?=
 =?utf-8?B?U0c3SGs0eC92MFM0eXZxcTFBTDI1VmQ2bHNZdjNyQWxzcXNvYUxVd014a0xH?=
 =?utf-8?B?RE42VUtJSThsR20ybmVudHJ4VHh4d0p6elNmclUyY0RnUytaNEVJZ2h0T2Iz?=
 =?utf-8?B?YmlBdndzSEprcStrY1I0ck1GL0k1THhRVDNFbTZLQ0NNOU9JZG9RbDVEaHdK?=
 =?utf-8?B?dEhIRGduYkZQVkNidklUMk9pbnlzdzdoNVFNOWlmZGI0cVBmV3JpZDFMN2RC?=
 =?utf-8?B?WmJHZGNucUtaQlNNM2g4MVV3cXp1bXYxdFpETlZkVkQ3c25rN0FZTEhHQlRJ?=
 =?utf-8?B?eFBEMktOUTg0K0FlYU9PNGZQSU1LcVA4bFRoYlJFekdTS0w0ZGk1clpLUVoy?=
 =?utf-8?B?RWVSenZFeUp5aWxheThjSnBWK0E3Ny9QUVRFd2VpMmZ3RkdWN0VRcFhCbU81?=
 =?utf-8?B?TzlIUVdzd0VUbWVDTGxUOWxyQnVqTlJXSVpDT1VKeWFFNFFrNmZiN1c0RFB6?=
 =?utf-8?B?UVZpdm94T0pTUTJDL0YxdzhXSDZ4a3preUs0ZnZhdzBtVTQ3b3pYRVJ6anVG?=
 =?utf-8?B?R3gyY1RZaGJwcmo4WU1nc0pGMGh6SDc2N3VLWkRaQnJMc0pGb3o5ZGRmc0Fh?=
 =?utf-8?B?UXRvcVhuNExXQldMMUxPbTFTbitteUFqa2RHd0haYVMxSktrbDg5RGk2cXdJ?=
 =?utf-8?B?SXkzQ2FLb0tkalBxRmdtZWRtQXFQdUMxL0JvekR1L0o0akRLbHhqQ0wreHpR?=
 =?utf-8?B?TTVkSEh2R0ZMbjRFQ0cydE56SjhQTlYvWnhpWU00dkYxQTFLNk5LVkw1c25H?=
 =?utf-8?B?b0dqeGJUTmZCM3JnbDc3b0FzbnlzVS9sQWpSZ1RhK3dJREo5ZVY1cE9qV3h5?=
 =?utf-8?B?bDBMeTBoUXV1WXA5RGxmRmdWUWdFWkdrd2VQWDlwVG1LOU5IWkwxODFrTFM2?=
 =?utf-8?B?NFFXQjNxV1pwbllSaWFSajVmSUdKV1lES1BWUzJ4dnJMUXl2ZU96VHVoaWtM?=
 =?utf-8?B?YzNxQVZzR2RWWU03aHo5Rno5TThUb1BrdlhhbnJKSG5SdkpudDBoU1lCbnFK?=
 =?utf-8?B?cjl4S2VuSDVFa0loQy80a1cwTi8rQis1dytQUklJUjdoWE5KcGtaV2JsSlBL?=
 =?utf-8?B?b0djWEhqZWY5THJlUlpPNTdvWnd5aVB5cmZ3ZmZTa1RqT0dBYmVLOWpOUXU2?=
 =?utf-8?B?OVdBVW5lWTEwQUVhLzI2TVBoRE1aVERJSFNyWVk0SVRBaVVJZmtUcTA1Z29p?=
 =?utf-8?B?M3JzUGNoek8vbjYxdWd0SXFlYmRlK0ZNZFpGMm5YM3U2K25ibTlhRG1HT1U0?=
 =?utf-8?B?MGROWWM5Q1huVU12VGxQMnZRWEMvSHdQN3p0NlZuRVJMbnl5S0FZb3p6bEVr?=
 =?utf-8?B?TStGMzNNdHFOSUVuTzczZUxvcm1KRzRzY2ZlcWNxTEJLRUQrSERIUzJSTDNI?=
 =?utf-8?B?V01NYkgrN1RHTytYaE9WTk9BcnpPNkQ5c09VQWF0bHhEaVE4RHZoMlZNR1pH?=
 =?utf-8?B?Qm5NaGxRSVY2cnFEdUtjTXlvS3lHTDBjUzFON3Q2WFFQeDVsaXpkdXgvZytR?=
 =?utf-8?B?RlFRUDVSd2tGYi9aK1ZiR0JzaHo4OEVQUDVWcUtweEFHWi9yUUFDeTdjMkNm?=
 =?utf-8?B?aWgyOUtMQjdZcWJ2TWdwUytCS0pNTFpaWGl5L1J5UmhSSkNqTk5LQzdpa1pC?=
 =?utf-8?Q?+0akJXXTyKqtxMLb5t6Temw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F87E9B1727D3494AB8145E81B65295C0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f354b065-a9d8-44d6-a0f6-08dd1d99f2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:21:59.5570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PV8s+qY3Sz2gjTIvJoDZvED5pu32wTqSNZ6rEFxA4LVroaGcinZmdUfPsRZVcADIMfNRJcU3ZPNkIJPcsq9XmaHuBMZuHo133lrgEA+KTPfhyhE6pqfbUKwNGv9ziALg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7509
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCg0KT24gMTMvMTIvMjAyNCAwNDo0MiwgSmFzb24gV2FuZyB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBUaHUsIERlYyAxMiwgMjAyNCBhdCA1OjUw
4oCvUE0gQ0xFTUVOVCBNQVRISUVVLS1EUklGDQo+IDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBUaGFua3MgZm9yIHRoZSBuZXcgdmVyc2lv
biwgY2hhbmdlcyBhcmUgb2sgZm9yIG1lIQ0KPj4NCj4+IEBNaWNoYWVsIEBMaXVZaSwgQEphc29u
LCBkbyB5b3UgdGhpbmsgd2UgYXJlIHJlYWR5IHRvIG1vdmUgZm9yd2FyZD8NCj4+DQo+IEkgdGhp
bmsgc28uIChJJ3ZlIGFja2VkIHRoZSBzZXJpZXMpDQoNCkdvb2QsDQoNClRoYW5rcw0KDQo+DQo+
IFRoYW5rcw0KPg0K

