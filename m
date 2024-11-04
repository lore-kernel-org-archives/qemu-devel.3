Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE34D111B0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rGz-0008Bp-Gh; Mon, 04 Nov 2024 02:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t7rGx-0008Am-AA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:13:11 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t7rGu-00048T-TN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730704389; x=1762240389;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=o/a2PwNnQRZDdAB3TDJjoexrz3vXcXOsu3xEdno0YxA=;
 b=wan22vEAXrKFtEvFetk8YSHZuVPG/93wWDjLWMuBRrcNtNo0Qp9DaiZn
 MeCjDYQtBTEZYUQ86tzHG4V7DCC2pGH1w9zm/KMh6dB2nZqJnfuJ+RotQ
 aP11Ox9FuANr03BbYsyIMYmui0QdELDT92/I5tJoxUFxH2a4KSwbFFfJ/
 LbtloB88pVPIhh3hzcXGiCtUPkDYY8CSkW/YIcn+D62DAv+JqkTdg/2F9
 jXR+1ixgLAZUg7qg3KGUG34KMxUvAa7Ym39N77qdJ4qfelRmGjUbq3W62
 RrmpPa7rpteY6CJ6NX9thXv9Q5YbZ0j84dGmC/4qNnczetKKsRGM6d1CQ Q==;
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; d="scan'208";a="23735352"
X-MGA-submission: =?us-ascii?q?MDFS8fHdNNQMSPTR7tR0s2MaSqG37aWqH2d8W9?=
 =?us-ascii?q?kZVGN9wvWcsNFBjjZ3yNnsPlJN0EeIqK+I+BcjNHL7Sn77SjD7xL/ca1?=
 =?us-ascii?q?OtYsSKBERg1TKHiEGAcQm/EVWwPwe4y3Eop/FyJO8p0TYih36Gczcu6R?=
 =?us-ascii?q?yzTjpYAqjkX+f8sqJxfCyB4A=3D=3D?=
Received: from mail-am0eur02lp2234.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.234])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 08:13:03 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjrQxdZIOV2GjGtNAE3hmhRwU0PR56rCSOcBFmPuWRq3D/zrxpmhehcg70b2F6ZOIjxhKNCRanxfb+2/f7V3qJbrDb++v3TPvX1zlc5wkrGDas6mBen65Xyh3CLDfRrogMGPB7AhMC9+YFcW+6GfQMcPqujwkOPVWf3hfdSB1Z0QvSaSsHUPpcAMntdqq1OMhtmHeRIyomP2DjqAMySkN4HKHbdVhCTYUTn4nRI8QeQnh6Ll8T4Gkpx/Vc/oBm+zkiJQ7jvZCn5Rc8wwuipSbpuWNMc5elJas53zKXQr1dhkX+5J8d6hOiEGwzOOFt7Ad9HPlB2kNkW7LG6wgk+bRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/a2PwNnQRZDdAB3TDJjoexrz3vXcXOsu3xEdno0YxA=;
 b=xMkpDZ3TjTARKBhG06gudEE6GZqqIJ6pH4KFwMW5oLva+YC8YkeGDJLizLn0oZ1Tu4fZvNjHzaQv8bXSRDD9QerhZ14CKKESusD7wmrImPQeSrOIvr2TyHjXGeyZ0n15KEAYmwdlmhbh20Hxgih8A6gP92hFbvNEZbo1jMVk3aCfo9lQwn/My+z7QbpF1U/q/VxdjE1gnMGLp9JJ7mVDFfxa/TPpXZAqnNwpp8A93WFMQZFVmTV6Oq5KIGnibLV4Eom34N7yQ4fenu7UIEev+E7Ef0+bExEbhZz3Ti2FZOBkPm38UUgF3Zd1t0SJiEeWTCgNrfcHFdD77ZtPjguGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/a2PwNnQRZDdAB3TDJjoexrz3vXcXOsu3xEdno0YxA=;
 b=e5hS3msqauwDEp5af0+XXt2Xd/LsaSE4ODo9MWxXrDdLBgP5nk+FHOHqba6l1t80KMiCfJh6+dNWSfPmF0igNg1H/t4u9iOfZQHbiEuqXDEOIg+sf6CrEHDzoJsjEBqe3guJfd+6HAAhEqPfOvxfGu2BC/RdFCliEhtnyA+2vxkjMBflGEx5PcE1hiQL7UG1rOm42MnXnoCBMixfOJ2l3QaSzCAgOzNxAyizsEXjxY98t2w57UgAmpEOZEisAhh4Xy71aOqzUTi9+7lyWgez+A63f1rHOQKg94uqI/Uzqa5662llnMEdSOcPeNycRSaAYps6Z/d6FKergZMQ/f0R+w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8702.eurprd07.prod.outlook.com (2603:10a6:10:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 4 Nov
 2024 07:13:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:13:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
Thread-Topic: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be
 string option to expose scalable modern mode
Thread-Index: AQHbBAs//n01sT5+oESCeHmeoqdac7JrHayAgAAqM4CAAtazgIAADHcAgDifB4CAAD/PAA==
Date: Mon, 4 Nov 2024 07:13:01 +0000
Message-ID: <7d196f8b-221e-4b75-a10f-6297d91b8a27@eviden.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-16-zhenzhong.duan@intel.com>
 <CACGkMEutsgWhp0mrCG6A3QA1NXnMj8RFDHMKPq3eBv3WxaQ=Vg@mail.gmail.com>
 <SJ0PR11MB6744EE9C94E4BD7FC7275455926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEvM1XHr-9Fyts5SZdwkhVh4rf=J-MjD5ZBPUcKqJ1s0dA@mail.gmail.com>
 <SJ0PR11MB6744F7B57D686541929B02C492752@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <bbcf1216-19b9-4d05-ba57-e451f3566f4f@intel.com>
In-Reply-To: <bbcf1216-19b9-4d05-ba57-e451f3566f4f@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8702:EE_
x-ms-office365-filtering-correlation-id: 73c003ce-6b6b-4023-e6af-08dcfca01e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d1ZVN1FIT3ZZRVorTUdCWUdDVDVYeEhYeU93aEYxMkRGNlMvQ0JlV0dYVkRI?=
 =?utf-8?B?NmVjM1QxYitSQlRXVjVsTnFuS3lKalhSeTdiREpVZWVUVXR0YWVmcFRXeWRM?=
 =?utf-8?B?aHdlM2J1MWthSDBrMVZVRW1sWW5kcERPVEd5ekJhS1VwYllNdUtRRk1UOWdz?=
 =?utf-8?B?bmhqTlJSMjlTODlPVHBwdmZEWmREdUFSZGlvUDlyMFZKK0NiRGthUUF2K0Iv?=
 =?utf-8?B?RE84RHNUMVpMcHFOSWNucTRtdDZDUUxKb0lCbERvQkRMS1o0amFKZFVPQkNH?=
 =?utf-8?B?N0xXYXpNWWZMYXhIb1dnWFZPeGh2OEdzMjlLKzk0dEZCTXA3WXBRblBFR0gr?=
 =?utf-8?B?MFc5bW8wWlZlMXplcklYcjJRb3ZJOXR0cmUydUNIWllHZFg1UTBMSGU3d3hF?=
 =?utf-8?B?WmtaV2hWNmVLTWRHakw5ZW15akF2ZTFkZUNoRTRlK3VBQmtMSDl4RkM3T205?=
 =?utf-8?B?Z2F1bnVTYk9uVGpHZjVEN1dFVXRBcFUvVXM3YmxTbUlaWTVPRml3am5kcVVy?=
 =?utf-8?B?YlZBOWJkT0xNUDRtK3Q5S2kzbnc5QlJtRDNGTXNFN1lpS1VjQzJyaEZHNnBv?=
 =?utf-8?B?N3NhRTNTMEhCdmVhOFVQYi9QRTVWb3ByanRQUncrQkhyVUFFWURFSjl1WDR1?=
 =?utf-8?B?cDhISklETjdrMlRMVVdzZ2Y2QmJpRUZTTU9wcHVjYVVPTnFITEhhdGZhTXI0?=
 =?utf-8?B?NkJSekV2R1ljNTRvY1ZCK0taZVJRVnNnd3Nic01maXA2MHZNZ3dvMms2VnIz?=
 =?utf-8?B?a0JlTXc2WmpodzF2bmYyZXZINktNTm10cHN5Skp2dVc5UFVGUEFDTzljMXNz?=
 =?utf-8?B?YmVRMU1XZzlFTjZwNlg2bnA4cnhrR3ZWZG5QWlQrZlVTaURkcXkrU2s2SlJa?=
 =?utf-8?B?emxOVXZ6Qnh1VXBNS2YzYnVWY3ZEbXNYaGVZL0RkVTQ2QkVqMlEvOVp4SnpW?=
 =?utf-8?B?WUlaNThkcXA4WlRVTjNZa3liSXdwYUtIb28zMVdyQ0VuS1NiaXhnWTNxajFV?=
 =?utf-8?B?OFRnbzlvTXFIRkdDem52bVlmWGJmMGdETDlwS0RMVURMNlRqY3RZZDBtRGlo?=
 =?utf-8?B?aDVwWEJjR0YwdXpDemFqUytHTkp1cCtwdnZOeXVDeXBIemlIYWF4VngrbjNy?=
 =?utf-8?B?SHk4VU1haDhCNHQweE9JMXJmSDhBa09VbHgwU2xpY1psdmY1S3RWRHJCcFVv?=
 =?utf-8?B?akdTSXJ4endXdGltdlplWTBhMXhOUHdZSlFyTUxRckg4aVNKUDcrMDFPNW5m?=
 =?utf-8?B?VGovSGJBMkh6cU43cjh0V2JtaUNOdUJ5WHNMb0U1aHpQOUxOUndpL29Ebkpp?=
 =?utf-8?B?dXUzR0NvMFBRdjYxM1hadEZ6RU5qdXZSL0ZCUHNQRUFZWGFFUkNmbXZnU3d3?=
 =?utf-8?B?LzFuNS84VUIvUHA5aXNlV3RCYjNCSUM4ajRLSlNPelpRNjFGRFI5Z2F5UUt0?=
 =?utf-8?B?NStycUkzbHVCRDRQY09pWjhZenJIZVdlL09GQWIyWkRObVh6TEpEL1E3V0Fp?=
 =?utf-8?B?K0xqTzdyaUdEYmN5MEZGeUNTYVhpUWVJZDJ5NWVuM2x6NEl6MTYveXZzb3lh?=
 =?utf-8?B?RFN5a1BDcER1Yi9DeFd4U05WWVVTT21MS1BHVjlJZGJQVFE4aEVWWUV6VzBp?=
 =?utf-8?B?c1pLOFB4bERBUjREc1VaSlpBV09QSTMvL25wTlV5UGRubGoyUFdkV1hOR1pQ?=
 =?utf-8?B?YURBVzhDVG9jV2pZMHdWMmN0RHBoUmdiYlZJbUtqQ0dUUXM3NU1pRGZYZVBC?=
 =?utf-8?Q?EL6XgW8TF0P2YDvUgOIlEhSnlQ1rPt0rbViItIi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU8xaHpqdE1KYWRUSXdBbTRoemZmREkvelRvR0dUK1hRR3NmTUVnTVVvSGps?=
 =?utf-8?B?dWp4M2E0UmgrTHB5dVFTWFlCeFh5b0crSUkrVENsWTNhYzZmUTg0NWJidFdp?=
 =?utf-8?B?WW9CV2tPZnhMaThTaFRUNDBIUkhsTUdxWVFvWTJ5Q01kTVhLcVRNdTBZbklN?=
 =?utf-8?B?UEswMzFIanAxYk5nTWQybHduc0NQWFdCK3RKSXI0a3B4RGR6akplQm4xdlpQ?=
 =?utf-8?B?YXhBcFlhN2ZEVmd3OTU2RmN5eStIWTJ4aXVwcWw1WWZPdVpUbW5wQk9FWG01?=
 =?utf-8?B?cWQ4QTlNamUxWittZFZxaWJxejJ4c09JY3lnb0hhbmJDenhlclB2YjJKY1FL?=
 =?utf-8?B?NnB5VE5vQ0w3VEhSUnRhVHgwTTNuTVhBMzVQcXpZdUY0WTFwb0JlckNmSTdh?=
 =?utf-8?B?Um5VTTVyTk02ZDNGRjR1VWVnYVV2WTRuemNHeUtmaHVaN1QvVWRBbTd1OWda?=
 =?utf-8?B?dmNFbGVRZmUyQm9oTkF3b3dWeTVoZ0MybVRURzNyVUc0L1lsL3VlcEF1eWtU?=
 =?utf-8?B?YzZ0Ym0rc1NhYlpwYlR6RFFHWk5aZDVkelJQZ0tuVms3MXZKU1JrMFkvYmcx?=
 =?utf-8?B?eEsvZmxwYkpZTVR3NkFZdGhXSHVaOC9yN21FOXc0TTAxcFdiN3BBUGROT3B4?=
 =?utf-8?B?WjdJMVZHaDBFaExzVFRHcEtFRVdiZ2REcWNFUnRIRFFLdDJZOTdaVVZ6R0Ju?=
 =?utf-8?B?c1NDS0ZWakxSWTBJUVFMWVAyRjNNVnU4RDc4QThZWEdKVUVnQmhQVkN3SWJn?=
 =?utf-8?B?dzRIUklCT3JmZTFDVXY3UmtTSm51S3dZNlNjUnN6QVc4N1BNWnRRRXFSYVFn?=
 =?utf-8?B?OXFQMk44VFRUVS90MDBKUkFNbmJRRVFaRkhEeXJnRmxCU2MyeXQrcnVyWXNG?=
 =?utf-8?B?OEdJaXB5Zys1eWhTYXNmL0c1QkcyYVVQdWFRVTJCLzRndWRYL0JPNzg3VUJn?=
 =?utf-8?B?cTF5dVZsTzROVUt6NjJuRkV4TFRzQVYza29CbTNjMFNROGhrRThzdnpBTitr?=
 =?utf-8?B?Q1E5STNOQW9oT0NLMXpiUW9nRjhBY21KOGJ5ZVlLcklXNGlYZ0JGY2JZTWho?=
 =?utf-8?B?NnJJcHRlYU5mcUZpOE1meHR0QllHWW9rRDJLaWlVNnY5VE94NkZuVzBmZUFB?=
 =?utf-8?B?c1I1b0ErVTlWaENnYTZURjRVVWdycWRqLzdxUE0wNmhza1J2Vk9VMnpDRy8x?=
 =?utf-8?B?QlJ5UkJyMGpuZVlXak8yZEQwK1dmMTVtdEpPeG5abkZqcFF4ci9iWDI2RDk2?=
 =?utf-8?B?MVloTUJuMUZuanVqRzZjZWFvdk10T2w0QVZCV01NcGtuZzZBQlJHSjdvVnNU?=
 =?utf-8?B?bUFvTEdLTEV6QmZtSXdPWDUzTFpFd3ZMNEhrQnpuV25yOGZzY2Q0S2NxWHQz?=
 =?utf-8?B?K0o4WUNlQmdaOS9SOU42Sk1SYnRDbDRPZTBDUWFYZHNHMVExNFd1aS9WTC83?=
 =?utf-8?B?M1VLejFLYUNjZTlOMytyY1kvb1ZHWXBsZDNTcGVpN3doZmw2eTFnRTVGV0lx?=
 =?utf-8?B?OC9qcEdZUmtMME0wVUhxNG9BSkFSQ2ZlWTdkZm9hVjBUcWxFMHJGWVJBK1lF?=
 =?utf-8?B?NGxIU2lNMGxaQTBkZ0RibDQ5RE1GRWIrZEZGaHh2Nlk4clFpVXpiakFhOTZF?=
 =?utf-8?B?VjRnemVKVzJHWjNTdjE4cXFGKzZBcVEvZkVoQk5oVG9LY1NpcnFFSXI0WnJB?=
 =?utf-8?B?blZvZEtVWUdCNEUwNzl2UTBBbGg2eE5hbkxWcVNIM0tMNXVRUG02aUdhR1FB?=
 =?utf-8?B?Z29TNTAySVJFTElHY2I4eVNZd2x6NC9ESW1SS0lJY2lJVWlOYlhPMTFRVTZQ?=
 =?utf-8?B?cE5IRnRoaVhkU2x6Nmd6dUpGU0kwZmRCVE5jZG9iaEJHazg3azZZMlJyNjNY?=
 =?utf-8?B?ZjFrYnBNWW4wbGI3dVRnQUN2Z2NBcWc5cEk4RHZjMFdLZ2xtZTdsYVM3UXpH?=
 =?utf-8?B?R242TGt3TVEvTGJ5TWJ4WDZYSmRvVHd5NUVrSXhhUll5S2FyM1JHb3ZzdTBU?=
 =?utf-8?B?emRYVzZRb1Y4LzQybUZLUHQrUStvNmZidXg4Tm9WMTNpQW12OHhBeDhTQ0Z2?=
 =?utf-8?B?c2tXdDhBWXJzeDR1TEY2bHE5SE5HTWRDOWZIOUJTUzgwMW9GUGpva0FpM1NK?=
 =?utf-8?B?WUpkOEZKa2VpWGU5N1kyMWRESTJNc1FrM2VHWnMwZXR3TDZIcXM2dCtMOFhU?=
 =?utf-8?Q?133UVKTzLWLNnii/8au0aZE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F4A878B3189D146BF570B8C9A8D4E80@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c003ce-6b6b-4023-e6af-08dcfca01e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:13:01.3870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57tWTk8h1h079faeMQHqB3WTqrUCbseonzK2cul49aCOI6y1Z10FEeB+8Mlo2T0QgAaJz03BoQKe9wTWDFi+0XyHjxrikl04GZBUxKT4y6ecoNMerXTzAqKkeEvfrfAA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8702
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCg0KT24gMDQvMTEvMjAyNCAwNDoyNCwgWWkgTGl1IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRl
cm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsDQo+IHVu
bGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRo
ZSBjb250ZW50DQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDIwMjQvOS8yOSAxMDo0NCwgRHVhbiwg
Wmhlbnpob25nIHdyb3RlDQo+Pj4NCj4+PiBBIHF1ZXN0aW9uIGhlcmU6DQo+Pj4NCj4+PiBBcmUg
dGhlcmUgYW55IG90aGVyIG1ham9yIGZlYXR1cmVzIHRoYXQgYXJlIHN0aWxsIGxhY2tpbmcgZm9y
IHNjYWxhYmxlDQo+Pj4gbW9kZT8gSWYgbm90LCBtYXliZSB3ZSBjYW4gZ2V0IHJpZCBvZiB0aGUg
IngiIHByZWZpeD8NCj4+DQo+PiBXZSBkb24ndCBzdXBwb3J0IHN0YWdlLTEgYW5kIHN0YWdlLTIg
Y29leGlzdCBlbXVsYXRpb24gYW5kIG5lc3RlZA0KPj4gdHJhbnNsYXRpb24gZW11bGF0aW9uIHRo
cm91Z2ggc3RhZ2UtMSBhbmQgc3RhZ2UtMiB5ZXQuDQo+Pg0KPj4gQ3VycmVudGx5IHdlIG9ubHkg
c3VwcG9ydCBlaXRoZXIgc3RhZ2UtMSBvciBzdGFnZS0yIGluIHNjYWxhYmxlIG1vZGUsDQo+PiBv
bmUgcmVhc29uIGlzIHN1cHBvcnRpbmcgc3RhZ2UxIGlzIGVub3VnaCBmb3IgY3VycmVudCB1c2Fn
ZSwNCj4+IHRoZSBvdGhlciByZWFzb24gaXMgdG8gc2ltcGxpZnkgdGhlIG5lc3Rpbmcgc2VyaWVz
DQo+PiBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcvaW9t
bXVmZF9uZXN0aW5nX3JmY3YyDQo+PiBmb3IgcmV2aWV3Lg0KPg0KPiBQUkkgaXMgYWxzbyBhIG1p
c3NpbmcgcGFydC4gOikNCg0KSSdsbCBzZW5kIDIgc2VyaWVzIGZvciBBVFMgYW5kIFBSSSBvbmNl
IHRoaXMgb25lIGlzIGludGVncmF0ZWQuDQpNYXliZSB3ZSBjb3VsZCBjb25zaWRlciByZW1vdmlu
ZyB0aGUgIngiIHByZWZpeCBhZnRlciB0aGF0Lg0KDQo+DQo+DQo+IC0tDQo+IFJlZ2FyZHMsDQo+
IFlpIExpdQ0K

