Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA8606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XA/9q1pV;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Rct0mVgg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTG5V-00043U-MA; Tue, 17 Nov 2026 05:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xTG5T-00043M-UH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:06:51 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xTG5Q-0008Nb-Rn
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794910009; x=1826446009;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cAPLDuvBRLRAv2oNV+Qq4ZwRjQ6nqDSTR2XkzJNl/64=;
 b=XA/9q1pV43i9b2d0BTu2UXFhU4N7Ze0u/rOE24jkPZh8znhCDggPRwav
 Sl2Zv/U6aCTsQpsJOhwuZuBoL5CwZ6IXNLafNmr5HPknwmgrY+YtSacaQ
 LRArNRF54d8qvdw98hy7PJzlXg1uHCWOleIzKT0foBCL4U4iCkYAOGaNa
 SKxO+hA5+ZI3QJARyhiy3MfbWwKu8t5ZyQlcMDwaGZMMX5DwhVDPUtsEW
 OvHKkK7+odYRpm+5aHissRBp44+QDPFtX27zXYC4kLye2P2lSoHInQzqF
 9aqtXYjYYZELpN4pesQYD+5g86D0oTpDfUzHcYQi9eD2DIhM6nVRBZVqg A==;
X-CSE-ConnectionGUID: POehdO8sRuCj6DRRBYn0qg==
X-CSE-MsgGUID: iSBbTaP6S6GnnOhlc7pzuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3688749"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3688749"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 02:06:46 -0800
X-CSE-ConnectionGUID: OBaKocjfSA66Bz2OFg5uVg==
X-CSE-MsgGUID: mIeNJyO2SauYZQ7vwvH5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9853422"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 02:06:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 02:06:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 02:06:45 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 02:06:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC0drlkSKPZ2lvclhvz5IUFLDBThyCY/UKQ7kPhZPWng/3N6xZBfTRwy4famzKw/b1JJelA5nO9AKgrVh/xaL6md2IVru5n5gTXGSB6aLO1F5YiKZZB63MXu9cHQJSUpKri618C1g/6yV/7JJgcko35iTvU3h1nrVcx6GmM6Djyk8kPQSJ+MHAOaGnmiJnaoZPeZ3ccRF9+VHannGvjhsWY5TMxi2f66icKr942WHeaHd7EnsDL858DJgwxM4TiuYOdH3tUQu8F3iFjO7vyNijh/p8RRwj115zo4z1RozSsI/jJruAPrvvj+KQkQTw6KLUVJGyKXMaVeyT3CqaYRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAPLDuvBRLRAv2oNV+Qq4ZwRjQ6nqDSTR2XkzJNl/64=;
 b=jdaEo4iA4Pmd9515hXeJVD9VJ5+ln7vNJbl4G57A4XgTBDbvIdaTxKycgS4ZPH0Btv+Afa7GObeJwne6BU4rWSJHL25+ONMxwd5b3l5KFX0A63hKD6oENVBnhRlJGVsl0mMbd8kCEHaFwCxUv+vjdWoqD/tcGRAVeph6fBodztMP4dqBtUoWFxXfuFDVYAdgSfdEC7uw5B7wpkDl6SJA+EJin89mYosO9jAtNUHd2tTDWElkSR4c9iuX+T2CKy9hC1r0s5VXloo8DMbt5XVJHor0/krwj1aenuz/d+uDFhnKvqtJCKUVb7OfLV3zefEx3BqiVDawzckW0rZgqzAhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAPLDuvBRLRAv2oNV+Qq4ZwRjQ6nqDSTR2XkzJNl/64=;
 b=Rct0mVggz1FucdmMC3n1LaTgS26Qyo8NG6cKjTztny04gpjHXaXdOWjA+tBMZfSlH5nenOyojBgKLeF0JL4ycOjIQGb6n4kX0dCtmTlOl/aCpv3Adki+gPHZaGI3TTPADFX9f2eKR+r5NM0h8q8imvRfw0IQl3N2ajpSlSmsx8o=
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF46B98A11D.namprd11.prod.outlook.com (2603:10b6:f:fc02::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 10:06:40 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:06:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowangio@gmail.com"
 <jasowangio@gmail.com>
Subject: RE: [PATCH v2] intel_iommu: Keep PASID cache consistent with PT fast
 path
Thread-Topic: [PATCH v2] intel_iommu: Keep PASID cache consistent with PT fast
 path
Thread-Index: AQHdbCtNxowMNmON6ku6WAa7/acLC7cdr8SAgAF8WOCACzkKAIAHt7Qw
Date: Tue, 17 Nov 2026 10:06:40 +0000
Message-ID: <IA3PR11MB91364F33713C9694313BD6EB927B2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261104070740.1577884-1-zhenzhong.duan@intel.com>
 <86bbbf9ad97d897badc74185ffebc281fa64f1c1.camel@bull.com>
 <IA3PR11MB91364207120A69BBF491522B92772@IA3PR11MB9136.namprd11.prod.outlook.com>
 <c279d0e3-986a-4978-b0f7-e0fdeb7fc11d@intel.com>
In-Reply-To: <c279d0e3-986a-4978-b0f7-e0fdeb7fc11d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF46B98A11D:EE_
x-ms-office365-filtering-correlation-id: 0b6f9d1e-f58b-463b-d3d6-08df449279a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|4143699003|11063799006|56012099006|10067099003|261009223027099003|261026121527099003|261022075727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rUFQTrIw1FmQH3SgwmG0uVqFqB6nZKapw+5Q1KKv7n0I+46aUzn7GCu70I3dpF1WxesPyB0oIunIucOFTjVSDNX54bedicldBZaiJ4DY7c4NuB7xneoKK/bHq7p9T/4+ZWiKV1LBs2fjUsd+UhCqpzd44/W+iNpqMwaw2//jHICXESVkyn/zkqXriq869ZgasN/3Hq5VxtCiK0yZeCWGe1fapb4Ov7IS1Sya7ru2EKNev74W5kgeoqG42sSFpH1aYMn5q3h4K1GHiJAJJMlc7bOsgQzAB7r8W9XAl9BMBd3c/pZjWKGSNawrZBxE/dHtAWLGBuqSUUVU3h9AANVfg6DQgXSbpM0DcE2i+fGMsklruRZvBH/zb/Vaps/6187wIDIDLpj6zi4lz79FJWWBmQC9r0vxV0I6rvH39UKM4g+wHECsNvjcW7ReKqVLhmw97qLrCE1DELlF53kGFx7yXKIPMGHac1ZT4PmF0WtiKk6EYRFIwMS/ph5XyoaZ7zzr3v4SznD3uoqFrEpwVYbxULECEp3hTpvf6yqVTenhTvCDseHZa659wu3SHw91htooeRPBYSnbRx37JxeTBduU3IIkufDAdiLTlPkkX27OlWtPcFPhrbQzEINC7ATv21so+nPFYFK2fIaTYnMCwzgcHwH3zQjO3TB+shRJrH89Gu1ux/3ZwZkwtmVdecEC+zHBmXTtAgeoXJHMGcVc/MXK0V4w88TC/HpNBLtykcD9F40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(261009223027099003)(261026121527099003)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVZPV0FiUVNJNEhrNlZlbjdWUkVwMjFqNGd3a0VIQlo2VGtEREtZVExocFRj?=
 =?utf-8?B?WjYwMGt3aFJBL0JGZjc2ajVKNFJ1OVNaNFhQWjNmQk5ydWx5V285YWxacjMy?=
 =?utf-8?B?allhVWpRVklTZXcvd0YrTExGMC9PV2Jpbkx6aExjRkM2Z0VyNVAwU3lIaEtm?=
 =?utf-8?B?UXRDQWVFSmNqRFV6T292bEFMZHRKT00yUzFKanpBSGtFQlBhQkxFNHZsM0Jz?=
 =?utf-8?B?OEgvY1N5ZTBaaWZTQXRJZkFRQndNamFvK29XSVZIK3E5aXNmK1ltUmhoTGFI?=
 =?utf-8?B?RlVvVlJhdEJWNVlmd1FHcXBVbWNLQ1VGRzVFNGMxT09OaU04UFd5RWZvRmNr?=
 =?utf-8?B?bDRRUmd2OEVma2w2eWtrQ3JNeDVkL0o1Ym1hL0phT3lHblUzcTZ1SGh2SU9l?=
 =?utf-8?B?WE5iWWI1VXEvMmY1RnVQVHRwczhKSE9iS0k0UXE1YUFRbkNFUWo1WWF2d09u?=
 =?utf-8?B?dUFobmhzckl4dTZjQ2dLS0Vlc1laeTBGcUIrT004cjVHcGdUOFdRQW54THll?=
 =?utf-8?B?R0ZRUkdBdHpkSmdSMHQwL2xwOHFXQm94RUJxVVY5T0Q4ZFZvTXBjZjcwQVR3?=
 =?utf-8?B?ZXJrbENTQ3U4b2I0M0JHZ3pYOGJMN0dpdWZoRXlsUFZDZitVcXgyUDhNMjVH?=
 =?utf-8?B?VGZLMkpNODJyRjZQcmM1S2RhQXN0WmJmWnFFOG1sQnFsSndEcDhGbEpJaEQ5?=
 =?utf-8?B?NHdvblBKYWJPNjQ2Wk81VllpaHNGNW1xZjFyS1JDT05xdC9DMjdZNGxsTXlP?=
 =?utf-8?B?NXFZYWl6c1hsdC9wZnNkTHJvSmxjUnF1SnZ0dEtIaGY5SWFITGFRaXE4VkN6?=
 =?utf-8?B?K1ArREhaTExBTENZZFl4c2pPZjVIdGpvU1QzSXdDemw2ekFIVS9QWk5JeVBq?=
 =?utf-8?B?UzZFSkpTcVBIRjlJNVlHZXBYYmZLUnNpM2VENGxYWmEyNmdhVlVSeVZ0MXVM?=
 =?utf-8?B?TVg4OVpDRGExbXlzM2RhditSNHVKZDh0VkkwSjRsY245QTNZUDVQSTMxWVFR?=
 =?utf-8?B?b1JaY0k3enlINTVBdHlwS3Y2R0xKUk41Vzh4a0Y5OGFoaUU1b2FqSzlMNk8z?=
 =?utf-8?B?M2JWOTdadDlxVnpNNjJZSVB3MDJQZFRxRm1EaDQ0bnd1a20vOXh0d1oxbThV?=
 =?utf-8?B?N0hVQUlEWEZ5anVSMmxpcUFLUWRnYkt1WWpCMG5pNDhUTmNaVTdaeDl5Skh4?=
 =?utf-8?B?TDZFcG0rTHVRS1JUNjNlcmtMRFJtUWl6TkFtR3FKUHRtMTh2YkVmTTcwR0NP?=
 =?utf-8?B?UEVOOGxGcmVUQUFWSXJvR2k0THJkUnpDbnpnNDN6T1NXVS9pa05DcFEwTFM5?=
 =?utf-8?B?OTVwb1d0THY2UWdOaVhYK3JBYmhVSEYvdGJnQkxmSmNlaitJeUNocHluMURw?=
 =?utf-8?B?WmtSaDlRZnZ4aVNvR01UMHJtY3BQeWhvaWRCeUlEMSs5U2w3djZHVmI5dHpE?=
 =?utf-8?B?VlJCQitpWlRCdTRvUXpKWWJTQkxud1phSFZoRUdBTE5mM0pHWURaQjR3OTBB?=
 =?utf-8?B?K1c4OFZBWUQ5MHhXcW11VlNNdkkyQnVzUWUwWUVZT0V1OEVHUzZxODQ3VlZ4?=
 =?utf-8?B?ZE55ZFRJWDNnSU5vd1BQYW5FcmFhSjdQL1NTeHVhRzB6Ynd2M3BvRUp5TjRI?=
 =?utf-8?B?TFJUYlRXUkxDT0hwT2xjSXZ4cGg2MlZtVVY0V2FUaXo3RE04Q2NmaGF4WlpC?=
 =?utf-8?B?WjZ1bjlONFJ3WDBEZWxvZ1pkSWRTYWpFUzY0alFodU80WGpERGhkcGYzNUVZ?=
 =?utf-8?B?N3dzaHIzOXMwZDJXZG1UcStmeUhPejN5T3ExNU04d09HZ1pqcWd1QnRVdFp3?=
 =?utf-8?B?bmtNUUwwbTFRODI3U3lFUHpZTkZGc3BEOEthS1FsRXUwYXdsWEJNR3poTGw5?=
 =?utf-8?B?OUNjTjhyTkhCM0Jjam16NjhaaFZDM2VNV1NPR3BEQndEbXlrQ1dIaDE5QVNy?=
 =?utf-8?B?Rmhmalpud3d0cmVWcjNralVYVHdNODB1OTRzdnJ4U2t4VEtrYWx2TU16VS95?=
 =?utf-8?B?azd4MW1jU2tST3lRck9oL2YyZ08vRlozUkY2MDZ3TnQ2NDNLYXAxZ214U044?=
 =?utf-8?B?NG5qcHZJa2k2NnU3aHRYMjdjRStSb0s0N08xQ3RuTnMrRVNiemdDYkMzY2Mv?=
 =?utf-8?B?ZjJhQ1NoY2h1QVd4bnlkT29iNVRFeDNlTUxiNDBZdGRvUzJ5R25IMjN3YnJr?=
 =?utf-8?B?N083R3J4c25qTXFnUW8wMjZSVWx0NFM5RHBSU3huLzZUb1ZQYUs3ci9qOEZV?=
 =?utf-8?B?eE9aQnZuTDBLZ2YwMUhENHVPZVQzSk12d2Q4M1pFTVRhMEU5cDRDSVlQUG1V?=
 =?utf-8?B?NzFSc3AxUDdKTk45SjJOKzVMT1hqRlIzb3I3SWFFWVVzSmlHY0Zydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u4zc5X/oH4Iqol56F2cJ9IJG105heDJEQ857At0IBkJgJCDCrGcsXBPCLsdtX2v5fvGMwtuna2FqHrc/rFWQwcXXfeDIFw+gVCf1cqHHqxFZEWGhC7tzYF4PNCcN82cvtMMrVwCnx4pAq1XvIv45hfkRjhQ1+6rDRF2ZhhAikM6MuXdt1qqU6Ixv/B8ZP4z9kU1pKPn+BxsQduUXq4C2ZaD7IYl9gV2/iGpnuq/DCZ9PvRKf6eU2iuG2kjKTxQXyxlZ0MhTsAhkYG6zxPy2Z4Mm/Eu9UKz2PIO6/61nKlYVgDjoc1m8C/N5fcYXYI8pHHxQIwiBc2D7IkQWldUZbnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6f9d1e-f58b-463b-d3d6-08df449279a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 10:06:40.6137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWUarTFjRrgE2BG31VRwZsFIANsqokVDZBqj5UaFjjKZjs2SvbjlsJXd9fpn4nNmWiuHCMdYQJUGHj8hdSJVpPEP0X3asZTR6bJQCH+4kn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF46B98A11D
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGludGVsX2lvbW11OiBLZWVw
IFBBU0lEIGNhY2hlIGNvbnNpc3RlbnQgd2l0aCBQVA0KPmZhc3QgcGF0aA0KPg0KPk9uIDExLzUv
MjYgMTc6MDcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIENsZW1lbnQsDQo+Pg0KPj4g
R29vZCBmaW5kaW5nIQ0KPj4NCj4+IEl0IGxvb2tzIG5vdCBlYXN5IHRvIHJlZmFjdG9yIGFsbCB0
aGVzZSBhcw0KPj4gdnRkX3N3aXRjaF9hZGRyZXNzX3NwYWNlKCkgaXMgY2FsbGVkIGluIG1hbnkg
Y2FsbHNpdGVzLA0KPj4gbm90IG9ubHkgZmFzdCBwYXRoLg0KPj4NCj4+IEkgc2VlIGluIHZ0ZF9z
d2l0Y2hfYWRkcmVzc19zcGFjZSgpIHZ0ZF9hc19wdF9lbmFibGVkKCkNCj4+IGlzIGNhbGxlZCB0
d2ljZSwgdGhhdCdzIG9idmlvdXNseSB1bm5lY2Vzc2FyeS4NCj4+DQo+PiBJJ20gbm90IHN1cmUg
aWYgaXQncyBwb3NzaWJsZSB0byBjYWNoZSBDRSBhbmQgUEUgYmVmb3JlDQo+PiBhbGwgdnRkX3N3
aXRjaF9hZGRyZXNzX3NwYWNlKCkgc28gaXQgb25seSBuZWVkcyB0byBjaGVjaw0KPj4gY2FjaGUg
Zm9yIFBULg0KPg0KPkkgaGFkIGNvbnNpZGVyZWQgaXQgYXMgd2VsbCBkdXJpbmcgcmV2aWV3aW5n
IHRoZSBwcmlvciBwYXRjaGVzLiBJdCBtaWdodA0KPmJlIHdvcnRoIHRoaW5raW5nIGFib3V0IGNh
Y2hpbmcgYm90aCBDRSBhbmQgUEUgaW4gdGhlIEFkZHJlc3NTcGFjZSBhbmQNCj5nYXRpbmcgdGhl
aXIgbGlmZSBjaXJjbGUgYnkgdGhlIENDL1BDIGludmFsaWRhdGlvbiByZXF1ZXN0IGZyb20gZ3Vl
c3QuDQo+SW4gb3RoZXIgcGF0aHMsIHdlIGNhbiBqdXN0IHJlZmVyIHRvIHRoZSBjYWNoZWQgQ0Ug
YW5kIFBFLiBCdXQgdGhpcw0KPm1lYW5zIHdlIHJlbHkgb24gZ3Vlc3QgZmx1c2hlcyBjYWNoZSB0
aW1lbHkgd2hlbiB0aGVyZSBpcyBDRS9QRQ0KPm1vZGlmaWNhdGlvbi4gVGhpcyBpcyBzcGVjIGRl
ZmluZWQgYmVoYXZpb3IsIHNvIG1pZ2h0IGJlIGZpbmU/DQoNClllcywgaXQgc2hvdWxkIHdvcmsg
Zm9yIGxpbnV4IGd1ZXN0LCBJJ20gbm90IGNsZWFyIGlmIGl0IGJyZWFrcyBPUw0KdGhhdCBkb2Vz
bid0IGZvbGxvdyBzcGVjIGluIHRoYXQgcGF0aDopDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

