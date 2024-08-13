Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81199C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlnc-0007aF-TY; Tue, 13 Aug 2024 03:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdlnb-0007Z1-JN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:18:31 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdlnZ-0004WG-5D
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723533509; x=1755069509;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=I4xQ0YJyq5oH3rxxkgoQAJMGj9B8q6CeEnfaFs4WUCY=;
 b=JTX9rUE3PtZCXDW3RuUXfoJiaP/Tyl5RfTAQHVCmHZKeialijyvlQCgi
 tytpG6tSlFOUldxDDewPvTBcXjcCtWK/xsagfI04OnYZwEX/q52FSeHyD
 2xCEw6SgC9ZJ36i6lhhgRpY258kIEqXzaj1wNrZGaZBlJaeyG46H6+Thf
 KgZ13lVeIbOUHkK+24H5FyQN8a+mYhCqW+eQMk/97aE89LT73uzByYBFF
 i3lUeSyAYc643roWRA6Tgy4NWjr7WAmq2+gMVeo7iPNwqD4ek4bUfYZRP
 XRlRkOEuBXSBv4Bt1zi6qCaZuW5xEV2DuQKHHvp1D3yUWSJLspwQIBXwi Q==;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; d="scan'208";a="18268203"
X-MGA-submission: =?us-ascii?q?MDGDx1Q2q/y5xEQkuyvkfxMad06+rVV/HapmA4?=
 =?us-ascii?q?lD78fjPhI9/7Vv+pGgnJcPrG8NgbBW/AgR/yGymlh69JJI2STq7Jk5Dv?=
 =?us-ascii?q?My4WILoY+r41CQcUxSfHG1CqD0ex+WzPtt1ATGuPcGcr+8UnNGuwUp4Z?=
 =?us-ascii?q?9yk3U/CsRPhkOMqoeIadb5qA=3D=3D?=
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 09:18:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXCq5TBFCd6siomZ+jUicIjP98NxqxjmUM0jgA46cxD7qiWVqhPeaqbc86k0oCTUUs4nhatA3un+Awfku+FXgr5RAFL63YWfl8LPxm9IhFbOljsdUnLXnJuJmFATIO+YsjpIvRXM5okCmK6iAUw7ocUCSYTuckJ4hqKaDHxvUZiVmviTFbAE6peKVk1g5XWr988svCugwtqsAPseio1zugz9yRlVGPau8kWR80EGEeholmTzesPFypHmBXZKqxBgVbXUPyUBc1lOsW2/dqcoVLylAAo7rICmebFl6NyiNWKtF6G8jP+mieOVSSXERx6VaCrZfHSPTvXPOS1yO22nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4xQ0YJyq5oH3rxxkgoQAJMGj9B8q6CeEnfaFs4WUCY=;
 b=UaaefGGWxE2/Mt9vQ760U+sEpBjkGY1UkuUODGxkjkuBP8F8nBQ5J9yhGfpnPhvlp+zxXu7kcUfjgFusdc1+LhEGZc4BxnECsit78c6rzmN6uFpNdoY3iXMJBfgRJaud5CbtJXRpK3fPbyxugFoHmfSeuFrhPR5esxDZKNTpY8C3Cd0IpbTSSPTNpJW5XZ/Aq5WgZhH2rkOMOSm7gkYr3oIGaZzkM2x0aFIfQpV1I7oIyK4ThDbKqRDUiv0R2q2MRctB5jmRiXgjmmHsm5pgUxsPfIx19YQQTVOPj+BImp51tBVhaM/m1hFSAktk3rlarpw+dP3x2Npc4Lpa9uVDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4xQ0YJyq5oH3rxxkgoQAJMGj9B8q6CeEnfaFs4WUCY=;
 b=VeguDtMbSDmGQVCHl5D1l4fhL3EtuGoPAgaQ7F7MHMraw58Afb/2fbrmFfcalr76qL64r0qNkycimk6Z6qoNWyTwlt1e+Mot6utMJrRfp/yfHt0mJZXzlL49lWmicZvLiKhbA2TKc8ZuI3y0Inw/dvQTQdAmUrsKw723ZXjrK0fy/h0fJLo3SPYO6OyKN29J94/n7Knu4XCeUP0/MtCJpfNFHBEq10VYrkjLvbz+d6/XRV6giqy2/wjcFLDUOY619yraVseHxd2pFcds5eZQluMrQJ/2B9AxodDRYRtZl4ErDT4CXbo6qPq2msT9ux2aN9Mi7KPEm6wvPIV5KqMoZg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6415.eurprd07.prod.outlook.com (2603:10a6:800:13d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 07:18:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 07:18:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHa5wD3t0aSWs4KZku3dYcmr1ZjXrIZx6uAgAOKqACAACXlAIAHBk8AgABT+ACAAAFggA==
Date: Tue, 13 Aug 2024 07:18:20 +0000
Message-ID: <5f4814b4-28d6-4c25-ad86-af98b4014a50@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
 <ecfaec89-bdfd-0512-b9e4-d2dc237a9c56@intel.com>
 <1b46fc72-7e51-4585-865e-1d32b2ae6997@eviden.com>
 <SJ0PR11MB6744A4015D28C6BFAD241B2792862@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <92631633-27ac-4f46-adb9-e0cca90321b6@eviden.com>
In-Reply-To: <92631633-27ac-4f46-adb9-e0cca90321b6@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6415:EE_
x-ms-office365-filtering-correlation-id: 85dd6e8b-98ec-4dcb-814c-08dcbb681c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N2pCNFRuQlVpK0JmcFMvSms4TkdFN2JqdVdnU3hBaGhsWHdiMjJNNVJYSXIz?=
 =?utf-8?B?dSt2UGhJWDBlcDRtdlJuRStCRDZRc0lTQlk1RlVYUkNnOGFtMTcxMXdQWmZm?=
 =?utf-8?B?WTVjTTVlWWl1d0ZlbTg2U2h0YzdyQ0ZOWkl1RU9tWTkzY3JmQTJMZkh4ZzQz?=
 =?utf-8?B?dDVzSUI5M2ptVm9SUCt6azJrNEZUdkFwUzFxcmVtMko5M2ZMam9aZXNYdVZa?=
 =?utf-8?B?TmFGeDN3Skg0R0pzb3grdVk1UVpnR0tiOVhyOFN5L2FteXB0MmJaTWtOOWw3?=
 =?utf-8?B?VzhYN05XREFhM3VKeWdaTzJtV2tDUmg3eTNlQmF4bVlhbzc4blN0aVEvV1hT?=
 =?utf-8?B?bm51a09WZEhiZDFnaXpwV0xIb0ZudzEwWUY2eFJFTFNpKzJpcWVCWWIzQ0pw?=
 =?utf-8?B?dkd4cWxmeUo2YVU0VFdwUDFub3ZDZFJCQzE1Y0xCY0NSL01Jc0lwcVIxNE9N?=
 =?utf-8?B?SHJBZkVTcncvTnRjOUQzRDI2RE05M09wU1RhLytkeFB3MlI3N3Z6ZUxsTlpF?=
 =?utf-8?B?MDVxaEp3S3FYTHVwUXpCVVZieGdPRFEzdVpsM0Rxd2lOUlJINWxkNm1pUHUx?=
 =?utf-8?B?QURvcUZ4QUZ1amI3K2JjeXd6NjFzWFVidE9zNlN2UEJZR29IbEVPQVRlVVU1?=
 =?utf-8?B?YzlCNThIWjhrd2JMYW8vV0JBRVZZM2l4Tk1LYkNkTVY1Q3Zld1Jjam41L2tG?=
 =?utf-8?B?T0svZjNlMStaMVpLeHNITXEzZmpKK0FqSjZwSHNVeW9tcDZzZlRSVUloSGxy?=
 =?utf-8?B?NkhGcjFYTDl2R0xtMVltSHdveXgrVlNWYVVuUWZwdjVqU1kxNFlweEZxL1lY?=
 =?utf-8?B?UVNDL2xVcXVVMUplYkQvTThNanZaeG5EeXB5U09jMTF4dFcxVEp1anM3bWl2?=
 =?utf-8?B?alAwallMYjRvczdGZE9YcXA5Qm5lK21vZjE1cEltV0N3cDdueTYxZFpBZmJW?=
 =?utf-8?B?cGJPZGNGb1VpYjVHcXNxRUF4UEhFNkNqWDFtbjdaYVRCcW1LTGRId0x6azFT?=
 =?utf-8?B?N0c5RXVWZFJ3VWoyRnQzNERHOHE1ZFJ0U3k0L2psMm9ycHFVUW9zQzJpWlpl?=
 =?utf-8?B?dVBhVEp2T3lmRnpCV3I5NEFMWGh3RklleTBNd2g5clYza2FGT1J3MHZLUzZG?=
 =?utf-8?B?ZW50MEovUFBPMWdES0c5Zmc0QmU4MnVoK2RyWWRucDAyYnh4TENoWlpMOStW?=
 =?utf-8?B?azhTT1lFc1VHMmZrR3lrZ2ZOOFl6MVVVb3VUWFh1NDRCREVkN0ZydGFnOHJq?=
 =?utf-8?B?cTIreHcySTZyWHQ3azVFTkQ3cGJtalhic3owaGcwd09rNk94SXYyeEM0b3J0?=
 =?utf-8?B?WUc4ekNIRk9TLzdkM1h4b29vM0FwdDlNZVZOeUt4ZGJJeS9qb1o2S0EzQ0tp?=
 =?utf-8?B?L2ozMVB2MnM3SUJiSlhobTJZMTdZaFVpSkJ6aEw4U1hQUVJiRUwzb2FzWk9v?=
 =?utf-8?B?VkpJdEQ5UHBFaDVOVU5sL3NCdHlmSm8xR2pqVUVBSG5BdnJqQ0pDUXA2Z1VY?=
 =?utf-8?B?Rm5aWXVsajFUeHVnMGtlYldiQlJ6MFk3RU5Vd0h6YWYycVNwbHFmcXBWd3Fr?=
 =?utf-8?B?akNZbUtVVjdpeDA0UWpwb2hQSXpZaTZSbzB5ZkFpR3FWUDV1b21DOU82ZmNa?=
 =?utf-8?B?MVBvSFI0bjQyakJxc2VjQ2gyZVB2aFB1dHIwaEVKRmtwMk90U1pMVkVVcHpv?=
 =?utf-8?B?bnlZVmgzaWN6TFhtN0xBVmlITStQQlFqVzJBT2t0YVBhV3ozVTBTbFNOZFhL?=
 =?utf-8?B?OEZMdUZ4QjRnYk1QblZ4dFNNOXZ2QjBpTnJjdHZ4dytCamlENXh2Y2UrZyth?=
 =?utf-8?Q?M1ldzGOtSd69m3uGr6eSM3UsLMcU+l+5f4FqU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUdZRi83T2tQU2ZnQURVREEyZUx2dlBMYjV0YWJ5WUY0MDlqSm9oUUVtb3hQ?=
 =?utf-8?B?ZmFsVXZXS2J3S0RJYVFsZmpZOUUwUFI3TGFEYjFGSXNaNmh1K3lSM0hWWURl?=
 =?utf-8?B?Z2pOVitzOGJZRSsyalQ0QTJXRElSejRhYlJWY0c5RS9JamQyMkhkemo4V3hs?=
 =?utf-8?B?eklHcTFQN1J3VmhVZnFwTTY4S2NzT2gwMDFQTUJyb1crTlEwaWpaWEdNQXlL?=
 =?utf-8?B?REt3WXFmQlJNREkwWHg1dGNWVHJrODZaN1l0TWZKbjJNbHVYRW9uR2R6QUgw?=
 =?utf-8?B?dlJLSzR4eTVia01acEIvMTdhMGxhaTlROFdSb0ZLVEFFc0JMVmY0Qk8xandV?=
 =?utf-8?B?S0dxRnhjQVBJNUVCQkZoR0hQbC90dTNpWXNZUFg1ZC9sVk5tbXRDWEo0am1v?=
 =?utf-8?B?d0tsQjdlZUVmMUVsMjgyOERITTZhTnI1Rlk5ZXF3WUxLUWhOTW8vMTBoSERJ?=
 =?utf-8?B?ZkpWS084UDVaK0w2WDN1Z0NkdE10VUxLNXpoWk0vOENuVHJZcnVsUXNaZzQ2?=
 =?utf-8?B?NzBSeWJQZVBKaHRya0lVMitvZDlBM1NOMjlVY1JPVG9sUjNBbVNwb3FQck1w?=
 =?utf-8?B?QVZWcUFuMEd0Z1ZCVTE5TFNLVU9USlpXQTR4QUtSRjhUTTFuUWRtRk9Fblk2?=
 =?utf-8?B?WnN1OEh2cTE4MEF2NXBhbUlFdFgxZUE5L1FKdjlJR0pnRC95ZjZsdCtpcEVj?=
 =?utf-8?B?ajRhVW9yTHpBdmZ1NnFLd0ZHejF1ZDl3Q3ZxQ0ZoSkREdkhua3VzeENTK1Iz?=
 =?utf-8?B?eDdKYjRrRnNsekloWXE2V2VNcEUyOXlKNnZ5Zkg1djVCc2tVNExXd0FLV29l?=
 =?utf-8?B?ZTh4b3pLQmdVenJMbzFqRDhsdko2NjA5YVBXeXpEWVJxZjRNWVpGUmt2M0lX?=
 =?utf-8?B?RW1aUHZEb2dhVzNKcWR6bkF3UjVkQy9tWXBFdnJGT3A2aTlmcVpydmw4OXpO?=
 =?utf-8?B?aVJxVVFxa0FrSFdJdnNKTmlCb0hLSWU0emtNNW9oRjl6K3VQQWZ3b2I2QXJt?=
 =?utf-8?B?N3AxVTU4NUJDNE1tZW5DbmJqdzNUZi9rRXJ5MVM0UC93eWRsUkU1a1dtWVds?=
 =?utf-8?B?SW9sVzVWaFp4RTZ2WEFqS0hLblluSTNuZW1kTDlZbGFoV1hJS1RYWDBRQ1ky?=
 =?utf-8?B?OEhrOTIxNWpVOE5xVklsQXBoVjlzdC9ZWEdPVGh3L1VnTGMzRUd0b0lqR3gr?=
 =?utf-8?B?SXBxSjhud3k1VExEK1MxQStDTEpPUFEwWTFyQUllWVFRNDhDaWdxVjNWT0ti?=
 =?utf-8?B?WVF0d1pXMW15ZjliNnhmOXVWejArVjQ4aW4xL0x6ZjFzeTlqZ0lJcVpmOXIx?=
 =?utf-8?B?RzBaM3RnSkFzOHZXeisrM1hMZ3BYSHp6bjg1dTFER2xZcUVGUmwySzdZbnFp?=
 =?utf-8?B?SWgxT0R6MG1ZTFluQ09sV3Zpa2l1UDhBOS9idWEyMUNFczdNa0J4ZjZKN0Mx?=
 =?utf-8?B?M1VuK1RjS3EzQVkxanJCUEZhKzU4WWVQU3VRS0E4UWZvTGw5YnNvMG5PeDR6?=
 =?utf-8?B?MW9XSlRNbFQxd0pZNUxkNUpnUGV0dzRNWUpBcU1mV2FPTkVzbWE1NG5OWWVr?=
 =?utf-8?B?Y0pMWDJQOGFBdTYrL3FPWTlheEJqT0kyKzdKRE5mdlBMalZ2YkxHb0kyWkta?=
 =?utf-8?B?T1orUzA0ZzZhRHRVWmwxcGl2VHBvVEtVNUJlM0kxSGFCdEIvaHlqNUxYQkdL?=
 =?utf-8?B?NVZQQ0F3Y0RyUDUxRkY0YmVNSXl3U0tXRlViRnB3eTc2NzVwOFJ2amJ5UFVH?=
 =?utf-8?B?aFhSSmU2YmhHYWpJZXN3cjdZYWVOVVpseUV6c2ZvZFBhUEZrbjBXYjBuQ0tC?=
 =?utf-8?B?V3BnOUhaTWZCQkptSkxsMEx6OFFvSFcvbFVUNStUR01PVFBDTCtoSnpqby9M?=
 =?utf-8?B?Y2hOMytHQVIrbGhSTU54eit0RmhEU2o4OUwvMlBtTm5VczVMYlpkRVcwUWtO?=
 =?utf-8?B?ZmZaaTZxdUhFSGg3bTF5OStXcDA1dTFvOWdhamgzdHZjNlYwck02ZzRERVFN?=
 =?utf-8?B?b1ZDenFVYlRsQUdGVEFrS0pZbzl6bkRBSjk2RGpZYyt1emlXT1dyL1VwVk9V?=
 =?utf-8?B?Q0ZJd0IzTmxNa0RJeWRvQzRzcFBoMzViMkVzZW5va1VlUUVUbkRINURUVzdn?=
 =?utf-8?B?RlRxVTA4dEJDcVBFR2ZEc1JCRytHcEpoWHRvdGpITEx1Y3ZhQkhURlFUVWRn?=
 =?utf-8?Q?RhYKy5hu8NIGUHpioelcpFU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F89D32A66A28A5418A7AC024D9076F0D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dd6e8b-98ec-4dcb-814c-08dcbb681c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 07:18:20.1851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlZ8FXZIj3byALeDdTjWCMF9ihUkT13GiPjkUCsJxkvBwlfDLXBZVwLl0xFRXQfpRrVy0exZVN4VAionZhzdy8SLfRVaFwQX2p20hfQu9wSu+6WWtdH6CNj9euiOex02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6415
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEzLzA4LzIwMjQgMDk6MTMsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4N
Cj4gT24gMTMvMDgvMjAyNCAwNDoxMiwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMTddIGludGVs
X2lvbW11OiBGbHVzaCBzdGFnZS0yIGNhY2hlIGluIFBBU0lELQ0KPj4+IHNlbGVjdGl2ZSBQQVNJ
RC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24NCj4+Pg0KPj4+DQo+Pj4NCj4+PiBPbiAwOC8wOC8y
MDI0IDE0OjQwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywNCj4+Pj4gdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQNCj4+Pj4gaXMgc2FmZS4NCj4+Pj4NCj4+Pj4NCj4+Pj4gT24gOC82LzIwMjQgMjoz
NSBQTSwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4+Pj4gT24gMDUvMDgvMjAyNCAw
ODoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1h
aWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLA0KPj4+Pj4+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50DQo+Pj4+Pj4gaXMgc2FmZS4NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gUGVyIHNwZWMg
Ni41LjIuNCwgUEFESUQtc2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbiB3
aWxsDQo+Pj4+Pj4gZmx1c2ggc3RhZ2UtMiBpb3RsYiBlbnRyaWVzIHdpdGggbWF0Y2hpbmcgZG9t
YWluIGlkIGFuZCBwYXNpZC4NCj4+Pj4+Pg0KPj4+Pj4+IFdpdGggc2NhbGFibGUgbW9kZXJuIG1v
ZGUgaW50cm9kdWNlZCwgZ3Vlc3QgY291bGQgc2VuZCBQQVNJRC0NCj4+PiBzZWxlY3RpdmUNCj4+
Pj4+PiBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gdG8gZmx1c2ggYm90aCBzdGFnZS0x
IGFuZCBzdGFnZS0yDQo+Pj4+Pj4gZW50cmllcy4NCj4+Pj4+Pg0KPj4+Pj4+IEJ5IHRoaXMgY2hh
bmNlLCByZW1vdmUgb2xkIElPVExCIHJlbGF0ZWQgZGVmaW5pdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAxNCArKystLS0NCj4+Pj4+PiAgICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8
IDgxDQo+Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+ICAg
ICAgMiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+
Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
Pj4+Pj4+IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+Pj4gaW5kZXggOGZh
MjdjN2YzYi4uMTllNGVkNTJjYSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4+Pj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4+Pj4+PiBAQCAtNDAyLDExICs0MDIsNiBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2Mg
VlRESW52RGVzYzsNCj4+Pj4+PiAgICAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX0FNKHZh
bCkgICAgICAoKHZhbCkgJiAweDNmVUxMKQ0KPj4+Pj4+ICAgICAgI2RlZmluZSBWVERfSU5WX0RF
U0NfSU9UTEJfUlNWRF9MTyAweGZmZmZmZmZmMDAwMGZmMDBVTEwNCj4+Pj4+PiAgICAgICNkZWZp
bmUgVlREX0lOVl9ERVNDX0lPVExCX1JTVkRfSEkgICAgICAweGY4MFVMTA0KPj4+Pj4+IC0jZGVm
aW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9QQVNJRCAgKDJVTEwgPDwgNCkNCj4+Pj4+PiAt
I2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFHRSAgICgzVUxMIDw8IDQpDQo+Pj4+
Pj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEKHZhbCkgICAoKCh2YWwpID4+IDMy
KSAmDQo+Pj4+Pj4gVlREX1BBU0lEX0lEX01BU0spDQo+Pj4+Pj4gLSNkZWZpbmUgVlREX0lOVl9E
RVNDX0lPVExCX1BBU0lEX1JTVkRfTE8NCj4+PiAweGZmZjAwMDAwMDAwMDAxYzBVTEwNCj4+Pj4+
PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUlNWRF9ISSAgICAgIDB4ZjgwVUxM
DQo+Pj4+Pj4NCj4+Pj4+PiAgICAgIC8qIE1hc2sgZm9yIERldmljZSBJT1RMQiBJbnZhbGlkYXRl
IERlc2NyaXB0b3IgKi8NCj4+Pj4+PiAgICAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9J
T1RMQl9BRERSKHZhbCkgKCh2YWwpICYNCj4+Pj4+PiAweGZmZmZmZmZmZmZmZmYwMDBVTEwpDQo+
Pj4+Pj4gQEAgLTQzOCw2ICs0MzMsMTUgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZURElu
dkRlc2M7DQo+Pj4+Pj4gICAgICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01B
U0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPj4+Pj4+IFZURF9TTF9UTSkpIDogXA0KPj4+Pj4+
ICAgICAgICAgICAgICAoMHgzZmZmZjgwMFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9T
TF9JR05fQ09NKSkNCj4+Pj4+Pg0KPj4+Pj4+ICsvKiBNYXNrcyBmb3IgUElPVExCIEludmFsaWRh
dGUgRGVzY3JpcHRvciAqLw0KPj4+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfRyAg
ICAgICAgICAgICAoM1VMTCA8PCA0KQ0KPj4+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9U
TEJfQUxMX0lOX1BBU0lEICAoMlVMTCA8PCA0KQ0KPj4+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVT
Q19QSU9UTEJfUFNJX0lOX1BBU0lEICAoM1VMTCA8PCA0KQ0KPj4+Pj4+ICsjZGVmaW5lIFZURF9J
TlZfREVTQ19QSU9UTEJfRElEKHZhbCkgICAgICAoKCh2YWwpID4+IDE2KSAmDQo+Pj4+Pj4gVlRE
X0RPTUFJTl9JRF9NQVNLKQ0KPj4+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFT
SUQodmFsKSAgICAoKCh2YWwpID4+IDMyKSAmIDB4ZmZmZmZVTEwpDQo+Pj4+Pj4gKyNkZWZpbmUg
VlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDAgMHhmZmYwMDAwMDAwMDBmMWMwVUxMDQo+Pj4+
PiBXaHkgZGlkIHRoaXMgdmFsdWUgY2hhbmdlIHNpbmNlIGxhc3QgcG9zdD8gVGhlICd0eXBlJyBm
aWVsZCBzaG91bGQNCj4+Pj4+IGFsd2F5cyBiZSB6ZXJvIGluIHRoaXMgZGVzYw0KPj4+PiBZZXMs
IHR5cGVbNjo0XSBhcmUgYWxsIHplcm8gZm9yIGFsbCBleGlzdGluZyBpbnZhbGlkYXRpb24gdHlw
ZS4gQnV0IHRoZXkNCj4+Pj4gYXJlIG5vdCByZWFsIHJlc2VydmVkIGJpdHMuDQo+Pj4+DQo+Pj4+
IFNvIEkgcmVtb3ZlZCB0aGVtIGZyb20gVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDAuDQo+
Pj4gT3RoZXIgbWFza3MgY29uc2lkZXIgdGhlc2UgemVyb2VzIGFzIHJlc2VydmVkLg0KPj4+IEkg
dGhpbmsgd2Ugc2hvdWxkIGRvIHRoZSBzYW1lLg0KPj4+IEZvciBpbnN0YW5jZSwgY29udGV4dCBj
YWNoZSBpbnZhbGlkYXRpb24gaXMgOiAjZGVmaW5lDQo+Pj4gVlREX0lOVl9ERVNDX0NDX1JTVkQg
MHhmZmZjMDAwMDAwMDBmZmMwVUxMDQo+PiBZZXMsIEknbGwgbWFrZSBhIHNlcGFyYXRlIHBhdGNo
IHRvIGZpeCBpdC4NCj4gT29wcywgSSBqdXN0IHNhdyB5b3VyIHBhdGNoLCBzb3JyeSBmb3IgdGhl
IG1pc3VuZGVyc3RhbmRpbmchIQ0KPiBJIHRoaW5rIHdlIHNob3VsZCBjb250aW51ZSB0cmVhdGlu
ZyB0aGVzZSBiaXRzIGFzIHJlc2VydmVkIGJlY2F1c2UgdGhlDQo+IGRlc2NyaXB0b3IgdHlwZSBk
ZXRlY3Rpb24gY29kZSBvbmx5IGNoZWNrcyB0aGUgNCBMU0IuDQpPaCwgeW91IGZpeGVkIGl0IGFz
IHdlbGwsDQpzbywgb2sgSSBhZ3JlZSB3aXRoIHRoZSBjaGFuZ2VzLg0KU29ycnkgZm9yIHRoYXQN
Cj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo=

