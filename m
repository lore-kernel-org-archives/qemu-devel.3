Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62895C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 11:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7vVC-0007LK-0V; Fri, 17 May 2024 07:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s7vVA-0007L3-Js
 for qemu-devel@nongnu.org; Fri, 17 May 2024 07:11:52 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s7vV8-0006kg-7c
 for qemu-devel@nongnu.org; Fri, 17 May 2024 07:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715944310; x=1747480310;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s8ZCV85lDXFRYZ0XM5mV+bIMfjCweHfiN5CRkJNIS3s=;
 b=g7nGZkeiPHTzeyuiGmEGk1cxuIGtIKdQPG3uZMw9rIPB34FHPzC0vWnJ
 Bxc3PzaktuoXkHIx9P6vyxQXvDVuWWjP+rzDxX/+VtBlvl719fIJWKKg0
 zdD6lJwp0Nrz3NhgjSi9pD5rc8kLn6EfxNqvDPjUc54KyqpHUsre9sbIN
 3/vwJaZk8Pr0/vYlU2tZ9I2HYBX03R2wkZRnrF9OhKbfzwZxy8AmjqjEK
 zU+lf5SqAGCDIACyS+7Zx2Sh+8YJdUi7pNkiEYVVFEanBMVE7Oufj0yrI
 GgNDVzpz8dwIQjYMfOAa9v2k7DiK4ncNaqM3xTKxQwE2Jf7Q4UYjJj4LH A==;
X-IronPort-AV: E=Sophos;i="6.08,167,1712613600"; d="scan'208";a="12833998"
X-MGA-submission: =?us-ascii?q?MDHJ7lbeCmsy6HGyYj0Tcfl39MClSo4yy+8I2q?=
 =?us-ascii?q?RXAHySnhyQMOPbkbtzJpkFPviq+I7Qy6UvOdUrOjHMuUA7PQ6ZE2YRSL?=
 =?us-ascii?q?+eTcEBmcsDREEVEFOyGw8L8la6PGDpn0TIUR40szPt369atPolXAJ8yE?=
 =?us-ascii?q?nGUj7YYnw2ghjvtRr1GwEgBQ=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 13:11:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPgpOqvOz/+Szs+w2mBfAfEqOPrMM+Gg/e5zGE1YQjTozybv2uHPQoCNT7LJcwfCjgfxxcAlFNdfAIRSKCb5BOPtLDtsJsPWBTpidXtxs0JtxSQCQLP182W3zlUCZ7J1LH00rdj2KRzHP1pF3xqBN5TWmTApXaAjTXGhtj3ccYqaIudPhhQ18iAMw1yd1nfrMh1bjfjPaJ1CcxAFVVkrlrdEdoYh0ElPMsP+KgtUNJErW64pzi+MWs81vDX2O5Otf+226I6RswObYSJUSHuvOITi+1lfJ6EhKQYn5uoUvPZfOJyK6ui0aaAIMC+tyqnUnHWLr0W7+uuc6DSJ9RCylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8ZCV85lDXFRYZ0XM5mV+bIMfjCweHfiN5CRkJNIS3s=;
 b=PK8C8oV63RU6U9XDPBMrbW/U8kTnj6Z4OMPtIEffeqfScFPrAPe4qDC3wwnwuVSpGkBV92vaAQijL3azptz27ZNHluUK7n0vVZLJ9N0BL+Zy03OmzM2a7wrwAdFlKasP6zhBf8QylYIkrXgn9DzIVsa+UBvAChOofBXNGC5XsM0SMLUN6JLfr4fL7ZdAJ8N85OxEZjbl23OOKKTbzRdKdH022GlcuNy9hAKI1D1/byRicG3fHSxWCB+/OJE+FW5BLqaDPmNIXVFgCoRBKLbf5HV9afnPw10MiG8/Y3kGbfIRG5ml9X824D3W1qtpSUvUHU00wVUrri4nscAaQ3IwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB9862.eurprd07.prod.outlook.com (2603:10a6:10:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 11:11:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 11:11:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHappeALIV+LSCFtU2DUckW7CrvT7GbQBqAgAAIqoA=
Date: Fri, 17 May 2024 11:11:44 +0000
Message-ID: <2f86f14d-67dd-4390-99d8-469945279c04@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
 <20240515071057.33990-21-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB674421DBE60D5C9CF3584C6C92EE2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB674421DBE60D5C9CF3584C6C92EE2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB9862:EE_
x-ms-office365-filtering-correlation-id: 2f91beef-1b77-4286-5991-08dc766222d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eXRpMjcrZnpYODBzZVhkdnlIMFI1S3pIRitRby90MFU0K2IzSy9tQ05jUHc0?=
 =?utf-8?B?LytqRjUxUVdIWmEwM1Ava3oxdGgrYTlpSlBabmhpbWhkMWhjM2xPRDk3Y3NE?=
 =?utf-8?B?a0lzeGJCWHFOdU9zeTJZbEJzYnh0a2J3VEdBeVE2R2J4OFdycnNzaUkydnR4?=
 =?utf-8?B?cnQ1bkJzUGllS2FvNi9nSlJ2Y2ZuTU9pSVV1SnYxZ1B3UTlSSktaWmpqUDBJ?=
 =?utf-8?B?YmVQcXFKSTlZRUFKNlpIQnFZL3V3dUo5UThiRmducTk0Z21PNHc1V3J2NHM1?=
 =?utf-8?B?M0VQMEFvd0YydnluSGRjRDlnYmliUmZIbWdLT0t6Q3NBMU9Xc2tXc3RSUnhI?=
 =?utf-8?B?cXNVUlN1cjJVZ1F2Q3RLR1dBYkNiSlFwMFNLK20rQmdwek8yVHA2RDIzWVZ3?=
 =?utf-8?B?RFhMbG1iVllwbXhYaTF4Z2VMRldzek1LbWJlMTQzeDhIWndidW9GWTExR3dR?=
 =?utf-8?B?cmRITHFYUzNJOFRkVExNdFJybmhrb0F6MHNzcHc2Z0VKa1dnR0czRHQyN3dn?=
 =?utf-8?B?VDFNSi84TkZ5Y1FnT1hPdGxnVWh1c0RORHdKU2ZFY254Sy9jMGFKRVI3TEhu?=
 =?utf-8?B?UHMxQWJodloxOGkxdkdIOGNoVmdvbytac0hnUHAzWHVPSzc0VkxwWm8zV2tD?=
 =?utf-8?B?eFExZ0pTanU3aFdwNVhMRVNNL0lLYzhibW16dlNZTW0vcDl4MHF4Nlg0N0hV?=
 =?utf-8?B?VW1pK2xlTDJUWXBFd2RkNFB6WGVNaEsvZ25hanJRS29UN1hYcGRINlM0ZU5W?=
 =?utf-8?B?ckl0MFZYUW5rTmdlS1RHUUhwTHM5TWZzRUZHV2NwOWRhU1U4TFl5c0E1QUcr?=
 =?utf-8?B?eVExMUpLejBsMmg2L0ozUmdUenh0TW1wd1RLUnhkeWFjVkRhY1FtL2VLeDdO?=
 =?utf-8?B?MVZnNStLcTh5Z3lhVHNudGNJQ3JCbWFJUnVPWTc5dmlaQ3EzeUdVb0F3bTE5?=
 =?utf-8?B?Y0NBU2pwNFp3SGt0aDJCbjhQN3dMKzYwaVpYQkNEL0cxVFZnQ0hWQ0Z0bFUr?=
 =?utf-8?B?UU5iZ3ZlaFJ1WlJNdjh2QWRESFEzbkpXVXd6cW4zeU12ZDVzaTlUR1QrVHdn?=
 =?utf-8?B?OHJIL3p2MDNFWjBLbURmS3JrOU1OaDN0LzEwanZ2OFNubElSeG9hWkIwQTVw?=
 =?utf-8?B?VDNQVHdWZWRQbmdubVpLcU9CeTZ5b3RjQzFNcXJCQXArelpOTDlMRnpnUVhr?=
 =?utf-8?B?YnRoblcyNzEyellISFhQUXdZWWpna0x1MXk2YVpMSHQzdmJ0Q3RkZnFTS1NG?=
 =?utf-8?B?emRTdmRjbFV2Q0daOXhvYXZ6TXA4RDhVWTJyb0c3YS9OUjllbHdnUFYyZGZl?=
 =?utf-8?B?eEE3NEpQTzNEWnlCWWpjQk1MN1BYeDZzcFU2WVJSc3poTWtNOUd4TEFTa2FJ?=
 =?utf-8?B?a3ZPQTI4R053L3k1N1NuVTFvaWgxMWpVM1J4Y1Mra0JKUUhxV0k5cE5JeTYx?=
 =?utf-8?B?eWpUQmpCSXJicEJRdmJWTUNxZkNGcGhQcDhlRnZDNjgwRFN0eCtlT3IybEFo?=
 =?utf-8?B?NitsNXUyS1FMUms1cmpmUmdZY3NPTVg3d1c2aFQ1YjNBdnNwd3pkanJlb25T?=
 =?utf-8?B?VEp3ZTJPdWJuRElYdEthYTVWWU9YVCt6Um9DaXNpRHhvQkZHVmEySmpaM21u?=
 =?utf-8?B?c0ZITXJaNytLcWdMY2tGWHJhY2FGUmV0WXQ3OFlIS3lVbS9PTUsxWStHY0pQ?=
 =?utf-8?B?bUd0OHBhZVJWS2RaMWp2ZWhCaXNObW83RklmbXYxOXVBWVdjMHFaUkw5R0xu?=
 =?utf-8?B?a2wxcGcyUUV5cERvd0NXMzBxL0xldSswTzJYalorUURsU2hpRnQwK1VLNlVz?=
 =?utf-8?B?VXVuSHQ1dVZDd2hYQ1YrUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXhwVkgwY290b2hMdE03UnY2Wm5wbDUrWFdYVkZQS2h6MEN3SU9talM0TTY2?=
 =?utf-8?B?NkNLUmtFMVNSYzgwbnl4cDNnTmd6YmZ0MmRHd1drSlVwYWVWVFpzemoyMkVU?=
 =?utf-8?B?bUxEcEloVEVUdWx2UitxYlh4RFJUaHJKNGNwNSt4SzZsMUxiZEFaUDg4VG5P?=
 =?utf-8?B?eEppYVJ6OFMzUFBVVUtINTdxNTFnd09KdVpIcTlkYWpkNlRyUFF0MGdKVTVT?=
 =?utf-8?B?YVpXRDZrS2VMeWFwSlRIeU9UKzNGaFo0VUVyektGZFIrV2I4anNRZ0xmL1Bj?=
 =?utf-8?B?RE0vUG02R1R0SkpNK25wRURsemhHZTlYZzIxKzBHWHMzM0k5ajdpNE1RdDdC?=
 =?utf-8?B?VUpudUV0N1doYUFHV2xYL2Q4eXp2RzVKS3YvY1p3SHNFLytNWE9QTjNrTm4x?=
 =?utf-8?B?a1R4eVlLQ05CbjhGL0RzNktmTzdHTFlVaDNkRnlHVnpIdHQ1cytVR0s1QXJD?=
 =?utf-8?B?cCs4UTdTMjhZWFljMEtKMGZDT1g2UDhrVXp0MDFqVVZTaEVDdGFDOVpMVjE4?=
 =?utf-8?B?b295NU5oRkhkd2dHVVRVSUhxTDdCZWJOSVk2RW1OYml5TGN5cHVmVWNrN0ov?=
 =?utf-8?B?aC82Z0Rzd1JVTjlZZG91cnZXN2R0emltZGx6eDBUeUEzVUdtSFBQZU1YeHhF?=
 =?utf-8?B?SkVXb2hyMU5YeE9mVVpEZXZIazNZNUIvS2pSVlJyeFdGTkttckJOWC81S3Q4?=
 =?utf-8?B?NnpIZmorWmFyTm50OGdiYzhId1dTSVpYcTVUcXBPcFV3VGRVYnlrcWZpQXZj?=
 =?utf-8?B?VG1HUjB3elhnMUo3bEhlZGxodjU2blgvekFtL25jU3RjeDJhYlhEM0VnL2Vm?=
 =?utf-8?B?eTBISUdISTJLQmJuZm1iU2V2VGkybXVNWi9JUW1yaUNJM0RZRjNFcUlwRFJa?=
 =?utf-8?B?TTRYZmtEZC91ZHJVZi9PSDJDdEE5M3Fhb2JkQVNZQm84em9wYW9CT1FVd0ky?=
 =?utf-8?B?ZXBxdmNzVWtCeW5UMlpiVUpYMGZMdFJCeHY2Q1ZTSStqck0yS1lnMldaWUFX?=
 =?utf-8?B?ME9hNUZMV255OXN3NjV6UlZ6b3VJTzBVNDRrSEVtb3RzeEFjNVk2VmJNczRv?=
 =?utf-8?B?S1hrcXpNZGJxbUlXT1oycUd6Rkc4OU82QzRydVVPemlzdjJaeU5EZnRHayt2?=
 =?utf-8?B?Qk9BSWlXMmlwWHZuNE9nNVpvbkZ6T3dOTVB0SkhkTnRzUytnQVdJODVmZ2FY?=
 =?utf-8?B?M2lvNW1kWWpDWElRQi9HQW90Qmo2WGhWL3pXZnFlejQ2bWFTTTVJQTFjWkxB?=
 =?utf-8?B?aHFjVlgrWmp1a1c5Y3dZVjdYUEVOMXhoWDEzeFN0aWVGTjh3VmQ4THJvcXlR?=
 =?utf-8?B?cDNFckRuNmFPK3VyRUFNMFVuZVFUdUtHWDhxcE1LMDBjdWJUU2tBNHpFVCtp?=
 =?utf-8?B?c3FDa2F1RnRJQlZxdDJ0UEdDMTQvU0d0VVF0TitOazVDM1FkdW5GNWN6UXlv?=
 =?utf-8?B?T1JNb2RzNWw5Y0VSUS9SeHRRUWx4c0tZNC9EUGtzSklyZUxjTVhvVE1Odi9y?=
 =?utf-8?B?L0cwMGFLZTNpN0d1VjdnZWhOaXB6a0dGWWxpY1hWdnNUaVlTSnlJYkU3UXE5?=
 =?utf-8?B?NmVPVG9ubVpIMHdXSS93aG40TC9sdlB1dEc3Rm1TcmdqeGlBczh2WXA1RlVm?=
 =?utf-8?B?citmaE5EcWNSZmI2Y3ROeGdPazErNmFJUitlbDkyd1p6T3ZaOGp4MmM2SnNL?=
 =?utf-8?B?YVUvL1ZaVjN2MWlIUXdKMHJyaFo0THRuRG1SdWxWSnJWT1Q2OFl4OXNEZEF6?=
 =?utf-8?B?MGVVTERBelVRU3pQSjcrN2oxdFlFU3FRamE5RTI0Rkw2Qi80YW5nSjhNaVlo?=
 =?utf-8?B?cGphRDlwOTlOQSs0d3Fwck5MdSs4cjZHTkRjRXNoQkt3N0gzSWRIcTZ2SkNH?=
 =?utf-8?B?Y3JsUGJNbE44b210RGd2dHhrWXFqdXRNWU1zTWdPVXdXc0huTEpDYnIzWXAr?=
 =?utf-8?B?OUZlZWppNjkxMzk3ajE2Y1ExemNpZlpMbmdiZTdrWGFuK055MXJRSTgvSVU2?=
 =?utf-8?B?REV2OU4zVzJYSERTbEVoTXpmUU0wdkxNL2I1VWJYdUxqY0pkM0JpRkIwbWNO?=
 =?utf-8?B?MGFIdjNuZ2xWMFNYRlNRVGlCTkVwazc3K2pPWEtBMGUzUnJSVVpxYUxJbEoz?=
 =?utf-8?B?V294K3hDSFFLNzdwN1F5SEVSWHNaeHh4UUpJNzBFWExudklScUVkbXhOWUVm?=
 =?utf-8?Q?bePjVLneHuGLIFOkimWZ6gg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C2DA171502A149B16B0DD23CF66046@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f91beef-1b77-4286-5991-08dc766222d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 11:11:44.2509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wd1ljDNLUa8IEo7f4JSlAlfQdFrupWclOfUcP5X4kFn5/3ZsW+uzh3bUyB/kWwCnxWXn895wbaa4Z3vV2uHXSJvtOV5Oe6rZ1sg21Vs6+u1k95mjjQClBDMu6WXQ9fm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9862
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

DQpPbiAxNy8wNS8yMDI0IDEyOjQwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+IENhdXRpb246
IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywg
dW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KPj4gU3ViamVjdDogW1BBVENIIGF0c192dGQgdjIgMjAvMjVdIGludGVsX2lv
bW11OiBmaWxsIHRoZSBQQVNJRCBmaWVsZCB3aGVuDQo+PiBjcmVhdGluZyBhbiBpbnN0YW5jZSBv
ZiBJT01NVVRMQkVudHJ5DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0t
RHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiAtLS0NCj4+IGh3L2kz
ODYvaW50ZWxfaW9tbXUuYyB8IDcgKysrKysrKw0KPj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDUzZjE3ZDY2YzAuLmM0ZWJkNDU2OWUgMTAwNjQ0
DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4gQEAgLTIyOTksNiArMjI5OSw3IEBAIG91dDoNCj4+ICAgICAgZW50cnktPnRy
YW5zbGF0ZWRfYWRkciA9IHZ0ZF9nZXRfc2xwdGVfYWRkcihwdGUsIHMtPmF3X2JpdHMpICYNCj4+
IHBhZ2VfbWFzazsNCj4+ICAgICAgZW50cnktPmFkZHJfbWFzayA9IH5wYWdlX21hc2s7DQo+PiAg
ICAgIGVudHJ5LT5wZXJtID0gYWNjZXNzX2ZsYWdzOw0KPj4gKyAgICBlbnRyeS0+cGFzaWQgPSBw
YXNpZDsNCj4gRm9yIFBDSV9OT19QQVNJRCwgZG8gd2Ugd2FudCB0byBhc3NpZ24gUENJX05PX1BB
U0lEIG9yIHJpZDJwYXNpZD8NCndlIGhhdmUgdGhlIGZvbGxvd2luZyBzdGF0ZW1lbnQgYSBmZXcg
bGluZXMgYWJvdmUgOg0KaWYgKHJpZDJwYXNpZCkgew0KIMKgwqDCoMKgwqDCoMKgIHBhc2lkID0g
VlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCn0NCg0Kc28gd2Ugc3RvcmUgcmlkMnBhc2lkIGlm
IHRoZSBmZWF0dXJlIGlzIGVuYWJsZWQuDQoNCkJ1dCBtYXliZSB3ZSBzaG91bGQgc3RvcmUgUENJ
X05PX1BBU0lEIGJlY2F1c2UgdGhlIHJlc3Qgb2YgdGhlIHdvcmxkIGlzIA0Kbm90IHN1cHBvc2Vk
IHRvIGJlIGF3YXJlIG9mIHdoYXQgd2UgYXJlIGRvaW5nIHdpdGggcmlkMnBhc2lkLg0KDQpEb2Vz
IGl0IGxvb2sgZ29vZCB0byB5b3U/DQo+DQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCj4NCj4+ICAg
ICAgcmV0dXJuIHRydWU7DQo+Pg0KPj4gZXJyb3I6DQo+PiBAQCAtMjMwNyw2ICsyMzA4LDcgQEAg
ZXJyb3I6DQo+PiAgICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4gICAgICBlbnRy
eS0+YWRkcl9tYXNrID0gMDsNCj4+ICAgICAgZW50cnktPnBlcm0gPSBJT01NVV9OT05FOw0KPj4g
KyAgICBlbnRyeS0+cGFzaWQgPSBQQ0lfTk9fUEFTSUQ7DQo+PiAgICAgIHJldHVybiBmYWxzZTsN
Cj4+IH0NCj4+DQo+PiBAQCAtMzQ5Nyw2ICszNDk5LDcgQEAgc3RhdGljIHZvaWQNCj4+IHZ0ZF9w
aW90bGJfcGFzaWRfaW52YWxpZGF0ZV9ub3RpZnkoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAg
ICAgICAgICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1v
cnk7DQo+PiAgICAgICAgICAgICAgICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBub3RpZmllci0+c3Rh
cnQ7DQo+PiAgICAgICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0K
Pj4gKyAgICAgICAgICAgICAgICBldmVudC5lbnRyeS5wYXNpZCA9IHBhc2lkOw0KPj4gICAgICAg
ICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBub3RpZmllci0+ZW5kIC0gbm90aWZp
ZXItPnN0YXJ0Ow0KPj4gICAgICAgICAgICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2Fk
ZHIgPSAwOw0KPj4NCj4+IEBAIC0zNjc4LDYgKzM2ODEsNyBAQCBzdGF0aWMgdm9pZA0KPj4gdnRk
X3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21h
aW5faWQsDQo+PiAgICAgICAgICAgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJlc3Nf
c3BhY2VfbWVtb3J5Ow0KPj4gICAgICAgICAgICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0K
Pj4gICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0KPj4gKyAgICAg
ICAgICAgIGV2ZW50LmVudHJ5LnBhc2lkID0gcGFzaWQ7DQo+PiAgICAgICAgICAgICAgZXZlbnQu
ZW50cnkuYWRkcl9tYXNrID0gc2l6ZSAtIDE7DQo+PiAgICAgICAgICAgICAgZXZlbnQuZW50cnku
dHJhbnNsYXRlZF9hZGRyID0gMDsNCj4+DQo+PiBAQCAtNDMzNSw2ICs0MzM5LDcgQEAgc3RhdGlj
IHZvaWQNCj4+IGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNzU3BhY2UgKnZ0ZF9k
ZXZfYXMsDQo+PiAgICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KPj4gICAgICBldmVudC5l
bnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCj4+ICAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9h
ZGRyID0gMDsNCj4+ICsgICAgZXZlbnQuZW50cnkucGFzaWQgPSB2dGRfZGV2X2FzLT5wYXNpZDsN
Cj4+ICAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAw
LCBldmVudCk7DQo+PiB9DQo+Pg0KPj4gQEAgLTQ5MTEsNiArNDkxNiw3IEBAIHN0YXRpYyBJT01N
VVRMQkVudHJ5DQo+PiB2dGRfaW9tbXVfdHJhbnNsYXRlKElPTU1VTWVtb3J5UmVnaW9uICppb21t
dSwgaHdhZGRyIGFkZHIsDQo+PiAgICAgIElPTU1VVExCRW50cnkgaW90bGIgPSB7DQo+PiAgICAg
ICAgICAvKiBXZSdsbCBmaWxsIGluIHRoZSByZXN0IGxhdGVyLiAqLw0KPj4gICAgICAgICAgLnRh
cmdldF9hcyA9ICZhZGRyZXNzX3NwYWNlX21lbW9yeSwNCj4+ICsgICAgICAgIC5wYXNpZCA9IHZ0
ZF9hcy0+cGFzaWQsDQo+PiAgICAgIH07DQo+PiAgICAgIGJvb2wgc3VjY2VzczsNCj4+DQo+PiBA
QCAtNDkyMyw2ICs0OTI5LDcgQEAgc3RhdGljIElPTU1VVExCRW50cnkNCj4+IHZ0ZF9pb21tdV90
cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwNCj4+ICAgICAg
ICAgIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciA9IGFkZHIgJiBWVERfUEFHRV9NQVNLXzRLOw0KPj4g
ICAgICAgICAgaW90bGIuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQo+PiAgICAgICAg
ICBpb3RsYi5wZXJtID0gSU9NTVVfUlc7DQo+PiArICAgICAgICBpb3RsYi5wYXNpZCA9IFBDSV9O
T19QQVNJRDsNCj4+ICAgICAgICAgIHN1Y2Nlc3MgPSB0cnVlOw0KPj4gICAgICB9DQo+Pg0KPj4g
LS0NCj4+IDIuNDQuMA==

