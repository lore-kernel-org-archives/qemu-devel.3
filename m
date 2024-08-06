Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E38C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDlm-0004HB-CP; Tue, 06 Aug 2024 02:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDlk-0004Fp-Mg
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:34:04 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sbDlg-0004rB-1Y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1722926040; x=1754462040;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hwGKkz5SuOmTvWHnMk/8zfj3qn9dsXCly7b78aEGJFk=;
 b=BwPT5670GfazknB5/pA6ix7q6VjhiVBxpIkIJYX0ouYim+/axfjzjTVJ
 d9KFUBP/nfmUC3Lp1ekCupK6KZM2JlMbmiHWeoF6OLAy9ZC+I1yeJPn9K
 Ed4KhPlFqQ3ACD7cU/3RroFooqm7+O6q8w/MC9gGlNvRqR8dbsdrISDNO
 zknTAYDHowaIVVZAqJWYDtW9y8axWXhZAJK5KwDzT3TOCBNEKf2nRyW8m
 /s6OwVZwWl1D0LP7Xa1n1/O2IQaVyirNj5ffVStr8FBLvi/mqFsnUhfWp
 X9lV38NwEwMGyPTXUtm4DvGrTtL55tfSbBO5gJRxLfo7qYDiqsgjf9X9Q A==;
X-IronPort-AV: E=Sophos;i="6.09,267,1716242400"; d="scan'208";a="17871223"
X-MGA-submission: =?us-ascii?q?MDFQ4NyJB0OHpPHWDD4Oed3Xu7jMkEJxglh9Pp?=
 =?us-ascii?q?tgKYhLWES+YVL55u9cZoiACUa82T2NZ3D35mgLJfzIf0Gg2WzZ8X7WFi?=
 =?us-ascii?q?CwVJexsDpkPl2/bPdoLUmGCHHriUAaBNQJkRTeIA2wC8EKfrg9UZG2w8?=
 =?us-ascii?q?fm5ZUqB6lGl/Iqz84P9RWK4A=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 08:33:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZZ0C6L8lLlem+s4SXiuGeNXP47Xk2DG3EYEZ35JA825n9WZemEykXII/nOJCNXPquMRiMyfltdxW6IaQ/KGW/1u9KMlY10UPy7JXZGJrDo2cTmRvI1mm0C98FanHkqyxYhqMO8UA4zOAqDUqt/RJQ3tyM0JMIgtIWWvOtjgV3AWWICKdch/dtCRQmTCWPK0xNl9Syr/1D6XGZ7sHVb/ETlNF1hsEMzGCbqjxP0SsNZzywSLKvxsBROKhONZJHM8R5MLIhJsOZ8go+KiEzHLtFcZ83l5Q4WcyHEKJ71VHxRxEaZpu9qi34fA7mUy2IG7znziu/QAUjtCUczxo/CpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwGKkz5SuOmTvWHnMk/8zfj3qn9dsXCly7b78aEGJFk=;
 b=zN/laemo+rV2ezZVdmhpEN4VsnloEHLzC9zS55g5jZEgtnC4Hsy/I8YNhtNKNs5I/9jtcBfcaF1pt+gqchTtpXGn3YpoACM89h+7DsxFifnT4SZdDFkMyln9aw5tp7Gw8cR04BqWcBZQCA1U40JZn5Yu4U1Sc/KTHDiNDUEdVsSmmBHHhku3ZSWdrQuqtDsGN3xO3b5ozZv5q9+kIUxihN9BeA66qtuCX29/1zInO3rRgmqJcrXKGYQMdJeoFt7EFtdYFn+WWCWfd4MGNkD6sE8D9R2VPJsaSAiOc2F5eAz3G2ef3DxlfNEnwthAzOenJySKF1C5dRwOMsNngUUDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwGKkz5SuOmTvWHnMk/8zfj3qn9dsXCly7b78aEGJFk=;
 b=JWSHqcqaG476z1eVSFHcwpnTcF3Aow/p6D3pI7Je4Sb+qNEM0Pk++FSuJSKyAxT3iJuQGLTXR+iC0/jp/qq6kxo6DQQXbxZjRbDUANdtOOFbOnRFRkk+0d/MdoUEUfNSoIZ2RX9caYPn/RGnOvEXdCJFT4Hc9utNfGOcLKkqgjrTTx36uP7hyk7XgB/NNJiikXNCtbNxjVc4P7GGLjeG7T9fuyCkOG72eNJeUut29l9Ww5MqKOjMLjCPPcwX+Z3Pw01V7f4eJRVD1JbraTr6xaipS+McfnGyP9josH462i3OECqog8vx5UY4o15W03cqy2S0REaAOu2Ext2nh0Cc8Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9752.eurprd07.prod.outlook.com (2603:10a6:150:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 06:33:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 06:33:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Topic: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
Thread-Index: AQHa5wEZwC9f1V2Rs0u1jtXCpsOY7rIZxyOA
Date: Tue, 6 Aug 2024 06:33:52 +0000
Message-ID: <aed8af95-4d2f-4c43-a936-c082c1e9a160@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-17-zhenzhong.duan@intel.com>
In-Reply-To: <20240805062727.2307552-17-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9752:EE_
x-ms-office365-filtering-correlation-id: 26af1113-d137-4875-5297-08dcb5e1bd14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZEtYSmo2NURCWlZtb1R3QlJvN2NDalFsTzBRUytnOTFaTy9TdGs0V2FWVDZm?=
 =?utf-8?B?b3lRRTJNalBwYlEvMFBDOWRNdzUwTldYNnEyRW9ia0dTMklEcVR4RjIrSGh5?=
 =?utf-8?B?L2JXUElZRzIyL0ZCY0VZcVVmUXFRWXRSSUtIUWpYdnFpSDlhcTF2c3d2cGVq?=
 =?utf-8?B?UjFOL0RDYkdOeEpJWitHbjJSckNvWUUrRG9xWklQbDNsaXNzV0ptS1pabFNJ?=
 =?utf-8?B?Tm1jUTI1YWVkV3FybThxWG5iQUIvOWVqbWJwYTZiM3NXRXR4Z0NWU0hyWHZt?=
 =?utf-8?B?cUw5VjdpK29wSWF3c1dTQTRrYk1jTE0yNWovUU55ZGVNY1RwNmFOUTRpM1Za?=
 =?utf-8?B?cWY0ejdYSWNaQ20rRzBzUDRmSlM1OVp4R1R5cUswcWN6M1FIaENFZUtjYUw4?=
 =?utf-8?B?aktVZjkvRmUvTzljdTkwU3RWWWVCdHNZTGZ5ZUg4anQ1QVRFeFJGb3ptdTUr?=
 =?utf-8?B?dWlLVjRxK0RqQlFHN244bWhXRGRUODhXNFlHZEVmN1IrQnY1MHlNY29FLzVK?=
 =?utf-8?B?akJjSVV0VG9PZzU4SG9zazdNV2xCT0M3L2NPeldYdTArTFdMNXIvcFptNjlv?=
 =?utf-8?B?eEFqOHl2NzU2RTF4VEllOGVqdXZWL3laVGVpNnhvUzV2RnhqMnZRT3NRVEhh?=
 =?utf-8?B?U2F4SzNJbnZmY3hHQyszSUdDV1BvclVQaGVxdXNXc0o0RGxrUVFXaGViUGRU?=
 =?utf-8?B?dXJpUWI3TThkdDdhalhCdFF6eEd3eU05V2JGdDB1dnM1dTFKSkhqZHgxTFdk?=
 =?utf-8?B?ZWVTRk10d3dSU0ZwSEtKdUVrT2tEMERlc1dYcUhYTzJDNndKWHp1U0Y1d0lU?=
 =?utf-8?B?azhuOWtWcTYvWDNrb1FYVVpaTlhpakc3REpMZTYvVU5LL2VUdy9lZDlqQnUv?=
 =?utf-8?B?YlV0Qk8yNWFUUnl6MVNyRC8vajg4ci9ybWN5MGQxYks5UVhXRm1LVmZVN1BI?=
 =?utf-8?B?S3lXekkwN0k4Q1BCdU1rQUllQ09WU0VUQjdzT3JMTEo1ZmREWC80bDFQUW1J?=
 =?utf-8?B?eGJyS2tpTWQ2QWM5S29XeXZvQnZhNW9LQ2FGS08vVzk0ZE9Ia0ZucjlWQnpw?=
 =?utf-8?B?T0ZVdkNVU3VXME5rT0xUNE5PMlJ6bWNyRnRLc3ZQUU9qVGlBUVFQTVFWWW5H?=
 =?utf-8?B?bjhncGM2eEx5TFVZWGVIZ2ZkeWRvMHBCTXR6R0hCMXlQWjcvVlUreGtxZ1Jp?=
 =?utf-8?B?VzZHYkdWT256ZFlOSm9haFRqOUJnRTI2WS9hN2taQmpVRTlZUTZXUEIzOHRl?=
 =?utf-8?B?Tk1UL2gveXczcGtxd0FxdTVkZVBIQ0t6WXkzcTcyUC93MDcyUXJQZWxhUGcv?=
 =?utf-8?B?TXlWMnFxbzRJZWtzSmdLTFRTRS9INlpuenlDZiswK0FYQ2NQSXdTRXVoUUoy?=
 =?utf-8?B?Q3Z3UW9wUFhsVlBSd2JqODVwdzFhS0p1TUsvVW5EWXVRa2lCVzlMblI3SU1k?=
 =?utf-8?B?Nmh4aVk1alZYT2ROTU9RYU5rQVV2Y2I1NXlOM0QwUFVtU0pyR3k1eTFsN2sy?=
 =?utf-8?B?cVNobytrMTdRbCttVjhhZUFYWEd2SldSSW9RNVV4R1VaVUU4d3JOUWFiL1Ju?=
 =?utf-8?B?ZGV3dDB1Vk9EQVFIdnpoUnF3blNudDRNUHBkZ0phQW5XTnVKT2M2L1JJZWJL?=
 =?utf-8?B?cDlhWmFvb1RZTytVQUkxNTJUaFR5Zk96ZWZNdlNxRFd6S0NMditLSFFJNmow?=
 =?utf-8?B?enpQKzdwMGdCU1BLU1lWcTFDTFZnYXNMUnNKYXMvT2prRlUrV3ZRZmMzUGFC?=
 =?utf-8?B?dE8xZUpCU0EvanB0eFVERit1RVF2dThPeVd3bE9TaElaMmRBdXpXZU9FWTNQ?=
 =?utf-8?B?L1VHVGNMczZNUU8zbXhiZVhSUm5OTHdWMFRSNTBVS2g4VUdiNkM0eFEwTG5h?=
 =?utf-8?B?Z2xnUUgyZmt0NjNTV1RsVTFIbEVOUUdXb3Q4NVJHTjdkZnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVpaSGlVNUpldE53NEV0WlNWZzlubU1mYzM0NnZ3d0doMnE2NFl5WndUZWZh?=
 =?utf-8?B?WlM5N2RXYjh0SnZvblJhZUZ2MkZEdXUvSHVUeHlFc3d4aHVSVnZRQ2haYkta?=
 =?utf-8?B?aHVNUml3aWtHTEo0eG9UaVY2VGxwOUp5NkFLTDhtUmRWdHQxSFVhMVVTWHBn?=
 =?utf-8?B?TU5EalpPZ0ZaSjdLNWZVeGlWdzlIOEJLSGxRMGxXOHdsKzR2OGpUZkd2bGJF?=
 =?utf-8?B?blRmMkN2cmhZWlNRVmo5Y0dWQjhvRHFLUDFkR2ZjSnloSGVxekd5S3oyWFVQ?=
 =?utf-8?B?OU8rKzdUS0docFZTYnBvMTEycStxZTdNVGlMSFdmMkxkVkdJUWZ4RXNMUFJy?=
 =?utf-8?B?cTh0RkJ1TzQ3Yk9xYVlZblQ4SXM0ODJrSGFYZkUyZlBZVzAvS1ZOTHdvdGxN?=
 =?utf-8?B?eHg0R0dkNmNsWlpqekZlSVZ5SWw5YlZ0NDBuVFArcWFROHVrdFJuaE1zRUJa?=
 =?utf-8?B?bTBKc1docThhcGQvdjFvMUxwd080SS93dGlqSWM3bWNVRUowYWxtL2FVeFBI?=
 =?utf-8?B?dGpQTndob0VyWTNkVnQxcStpUEhVMERsbVhXWFdPK0tvQXlldmNncWlwdjZo?=
 =?utf-8?B?eXllR0dwbEFaK09XZW4vcTBMcW5mSSt0dEQ2dmJZWVZmZmJKWDZrelhwLy9Q?=
 =?utf-8?B?QXB5NEhvb3hHZ281bXRCTmN0RUxBUjcrUU5XdUJacVhKSUVueEs1NHBvb0ZX?=
 =?utf-8?B?NnYwTXBVMHlSbm1TS2JYOUJTVFpLNjhlS1Y1ekFoTnFFbjc2UE5QU2d6ai9p?=
 =?utf-8?B?ZWtwRUVFWElwd1BlendTNkE1SHFJQ0dFUGt1ak53VFAzODBqOHBrd0NtUUlW?=
 =?utf-8?B?SUFoT0hkVHZZTWNPVkVXUmc4ZVdCQVpLUHl2b25XWGpWb2RmMWJ2UjhPMUdj?=
 =?utf-8?B?VXY0WDdaZXZPbzZxcDhrN1BTM09IT3N3bU5NWnNFdlJaMWxUOTdJZXhoTkVR?=
 =?utf-8?B?MFBzOXpQcHN1SmI2YmxCeUMzSFNKWkNibWVCRnA5bVdSN0U1WGhxSklxTGVr?=
 =?utf-8?B?QVdIYmt3akVyLzVrRWQ2b05nSnB1Wm5JOHBjcFNZWFkzMW8wS1VuV0VybEZ4?=
 =?utf-8?B?RW5LazRrMXJHQm1SSkVlbUtuKzlENGk4bmVWVjJraGtxOUp5Ri9ZbWNGS3I1?=
 =?utf-8?B?bnZlUkptUWhndGZDSTNOZjZRdHVIZFRwd1FJNlcvaHFHb1RwU1dYbDZ4cktp?=
 =?utf-8?B?RFU2c3VQRGZKOVN3U1RPb1lRMnFzQ1BnN095WjcycEJqdnJqMTVEQmM4OGtJ?=
 =?utf-8?B?dkh0YzRBbXVIaVhzWG5GNDFOaTFaa0dTZ0JadVNuWW9LK1k4cU1JWmY2UnB6?=
 =?utf-8?B?NzQyVmNuQnRKZHBQcFdFRFI0NmVsY2phMHhSZjJlRlNweVc3YU1sbHlGSTZU?=
 =?utf-8?B?bncvV1JLNnhZZzJadC95aE9mVm5lOWthMUZ2ZnJqQVNOakZJL0xpY0xQM25u?=
 =?utf-8?B?aWdzUTdJaDBIbHV4U1NYdjdZTXZaMWZEN21Od2U5Z2Z2ZEwreXN4RVM0SGNa?=
 =?utf-8?B?blFvUDc3NzVyUS9LWHc3cTlwMkxRNnFUWGFBS0daY1lKSU1jT0JzMHI1akZ0?=
 =?utf-8?B?ejNvSTJzNXAvS3MwYW9GYVVlQnVleDQvcmNueGJWVTFHSVpmTmZwclZGU3h4?=
 =?utf-8?B?MWVnMzVvWDlpajVLN2krM1pwL0Fad092dTloVjNpVmxVZ25pb2cxR0U3TnBy?=
 =?utf-8?B?UjlRUmVmaUlheUZlTUxJeEFHNHJMYWVwdmlPRjN6UUtYM3NQSFVkR0dJL3lP?=
 =?utf-8?B?WjJUU0NqSE5CcksyNmcwc2lvbGVZMmFpT1I4a3hRckRUQkZuK1p0cURiSDFW?=
 =?utf-8?B?c0kvaWswYzgrQUxmd0xldm1TZTRYYlU2bzFKUTNLNDMxeUJWYXA5WUw2amFO?=
 =?utf-8?B?SmlOWGV2OWNqeURIOVNJLzhHZmc3WjM2bG9IdStkbWdGWG9rN1NKZTVlYy9n?=
 =?utf-8?B?SHA3ZTc3WVR3Z0U5ekxZYnp3aTYva2VuU1g5dm00WmMwK0xQYlRhOE9obEYv?=
 =?utf-8?B?bUZpME9WdGlMT2hvMGlFVUZLRjVTWCtnU2tJeUdLVENPQ0JEdmYrSVl3c2lu?=
 =?utf-8?B?VEZTNXRDb1ZrNE5VWFk4NEJBbHQxWUZ4ZjJzV0dLSTFDQ1F0aFVxZUh3Vm4x?=
 =?utf-8?B?K3drWlNhdDZqUDBtNlFnelFSczNxM3dwNWtjU29VVDZvL1VERWlkenhsYkFz?=
 =?utf-8?Q?u6gnSLOmGPMJMMUWOoFK81A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6DC64FE6EDE74CBD997490ACA796D4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26af1113-d137-4875-5297-08dcb5e1bd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:33:52.3933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2iJw3N9N4hVki0HE+Oa0fk8QB21NJ1Pu9COL7zboifuqNcAB87WLVzIfHddlU8O6Ld7R+glqrtC0vJeXvRM2l/M2lKRP3yfFmVUwi8Q1KneSkTc8BJnFNWiK9zm9NI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9752
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KDQpPbiAwNS8wOC8yMDI0IDA4OjI3LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBXaGVuIGhvc3Qg
SU9NTVUgZG9lc24ndCBzdXBwb3J0IEZTMUdQIGJ1dCB2SU9NTVUgZG9lcywgaG9zdCBJT01NVQ0K
PiBjYW4ndCB0cmFuc2xhdGUgc3RhZ2UtMSBwYWdlIHRhYmxlIGZyb20gZ3Vlc3QgY29ycmVjdGx5
Lg0KPg0KPiBBZGQgYSBwcm9wZXJ0eSB4LWNhcC1mczFncCBmb3IgdXNlciB0byB0dXJuIEZTMUdQ
IG9mZiBzbyB0aGF0DQo+IG5lc3RlZCBwYWdlIHRhYmxlIG9uIGhvc3Qgc2lkZSB3b3Jrcy4NCj4N
Cj4gVGhpcyBwcm9wZXJ0eSBoYXMgbm8gZWZmZWN0IHdoZW4gdklPTU1VIGlzbid0IGluIHNjYWxh
YmxlIG1vZGVybg0KPiBtb2RlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiAtLS0NCj4gICBpbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaCB8IDEgKw0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwgNSAr
KysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IGluZGV4IDY1MDY0MTU0NGMuLmY2ZDliNDFiODAg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+ICsrKyBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IEBAIC0zMDgsNiArMzA4LDcgQEAgc3RydWN0
IEludGVsSU9NTVVTdGF0ZSB7DQo+ICAgICAgIGJvb2wgZG1hX2RyYWluOyAgICAgICAgICAgICAg
ICAgLyogV2hldGhlciBETUEgci93IGRyYWluaW5nIGVuYWJsZWQgKi8NCj4gICAgICAgYm9vbCBk
bWFfdHJhbnNsYXRpb247ICAgICAgICAgICAvKiBXaGV0aGVyIERNQSB0cmFuc2xhdGlvbiBzdXBw
b3J0ZWQgKi8NCj4gICAgICAgYm9vbCBwYXNpZDsgICAgICAgICAgICAgICAgICAgICAvKiBXaGV0
aGVyIHRvIHN1cHBvcnQgUEFTSUQgKi8NCj4gKyAgICBib29sIGZzMWdwOyAgICAgICAgICAgICAg
ICAgICAgIC8qIEZpcnN0IFN0YWdlIDEtR0J5dGUgUGFnZSBTdXBwb3J0ICovDQo+DQo+ICAgICAg
IC8qDQo+ICAgICAgICAqIFByb3RlY3RzIElPTU1VIHN0YXRlcyBpbiBnZW5lcmFsLiAgQ3VycmVu
dGx5IGl0IHByb3RlY3RzIHRoZQ0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IGluZGV4IDllOTczYmQ3MTAuLmQ3ZTczNTRkYjQg
MTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gQEAgLTM3NzgsNiArMzc3OCw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB2dGRf
cHJvcGVydGllc1tdID0gew0KPiAgICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUi
LCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCBmYWxzZSksDQo+ICAgICAgIERFRklORV9QUk9QX0JP
T0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVTdGF0ZSwgZG1hX2RyYWluLCB0cnVlKSwNCj4gICAg
ICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLXRyYW5zbGF0aW9uIiwgSW50ZWxJT01NVVN0YXRlLCBk
bWFfdHJhbnNsYXRpb24sIHRydWUpLA0KPiArICAgIERFRklORV9QUk9QX0JPT0woIngtY2FwLWZz
MWdwIiwgSW50ZWxJT01NVVN0YXRlLCBmczFncCwgdHJ1ZSksDQo+ICAgICAgIERFRklORV9QUk9Q
X0VORF9PRl9MSVNUKCksDQo+ICAgfTsNCj4NCj4gQEAgLTQ1MDYsNyArNDUwNyw5IEBAIHN0YXRp
YyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+ICAgICAgIC8qIFRPRE86
IHJlYWQgY2FwL2VjYXAgZnJvbSBob3N0IHRvIGRlY2lkZSB3aGljaCBjYXAgdG8gYmUgZXhwb3Nl
ZC4gKi8NCj4gICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPiAgICAgICAgICAgcy0+
ZWNhcCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfRkxUUzsNCj4gLSAgICAgICAgcy0+Y2Fw
IHw9IFZURF9DQVBfRlMxR1A7DQo+ICsgICAgICAgIGlmIChzLT5mczFncCkgew0KPiArICAgICAg
ICAgICAgcy0+Y2FwIHw9IFZURF9DQVBfRlMxR1A7DQo+ICsgICAgICAgIH0NCj4gICAgICAgfSBl
bHNlIGlmIChzLT5zY2FsYWJsZV9tb2RlKSB7DQo+ICAgICAgICAgICBzLT5lY2FwIHw9IFZURF9F
Q0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPiAgICAgICB9DQo+IC0t
DQo+IDIuMzQuMQ0KPg0K

