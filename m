Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5285BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvya-0007EK-1e; Mon, 22 Apr 2024 11:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyY-0007Du-MK
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:02 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyX-0007c1-2n
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713801181; x=1745337181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ESjUTwshCUuctme6QRudtAHCmYhhHel8S50dn9oAu2A=;
 b=VCkuZO+mMM6DpI3hant1BUtz4V2IRrVirxXWQkCoA1o0iVe92vr7BvyD
 7Y32IsGrWOopSRqz9rCJXKerHaB6M6AzWvaaSeyd4cAhAuKaGeTl8DZe8
 D3zqsZJBiLxZsgPZHgK7dNhg08KnQ2ckST+TFmj9w2fhixEIFvCa1imah
 4Ify0/w08rCMjaLPtGD2TEpHsH44QqDmXRdKuwC9duha+vmnIhhUOV0hH
 CE8oJimgVt53poLSUpfc3vt9O0EmwbLgYZQ5+0hyWwPjFRTjYr8/n8gAO
 mW0JnIFxYwTTt6mO2o26+snAlsOK6qhu249pylZG5VqeUvhrpWKjpUM2A Q==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; d="scan'208";a="11027670"
X-MGA-submission: =?us-ascii?q?MDGupIHUeyu/bMr96QwLX/Qq1J7CwjAm8VM5sV?=
 =?us-ascii?q?Ddy8jG8FdFk5aJ86MsbbdHMq267N266hbt8emzoJ6c9TD1hlX3eYRrdD?=
 =?us-ascii?q?3+gQJ+53Ea2a/RjAG5wS8h3IaYptPrRlUzNLbwjjLk6fgxxY+0QJfXGe?=
 =?us-ascii?q?Reso7EVskhzGgKU4bWxT8RSA=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 17:52:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lerSqTJmQpxT6BhilYqwkF3HXG0LqcLQisVXXzgLIP1/BNhQgW26OdXvIri+KdT/XY0gOaGgFZ4AqhacFwNwLI1Xu6D2KMdnvdzKFmhh3bWxIBYyW0G0DEnqoMdRTimgk5ABqMnK9+WwfqvshZkGaUeEqBgwb2Gx74XrX58/GHCGjPgMvw3XYbGk9UYr/ngLdUn6xggIs2FpZLBDFI5Rt1x87caqHRjWlig1Eb5SVpvE5dZLZ3csCBFLh5UEpqKaK3F7DS+jNOWQnLvEV/OyklUolJPH9Rz7az8kjuvH724+TypEQlaRKAqo/vWYC3aLw4ukaGU/egta7nf6E5CItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESjUTwshCUuctme6QRudtAHCmYhhHel8S50dn9oAu2A=;
 b=RKrZXAF5UePnD1fqsNZFoAAAAM7fu0uiRFH53HguxjPr3UqlS8VZ+FBwmU8Fvwf3+2YbOOxuOWYIx1hOA6WVDO9Lou8rEcqXo/fUyqbFT24UOArU7HogF3ZTRWq70YRgAzO05eHHmEvar1eo0zFSMQRbdf7Nf/PcMacuvLbPnvGksbDS2LprEm1XY5RBtFJIB52WEKwiXz2WDS3SG/viPG2LOXC2OeXrU7vlRUZP2SSwxj4OvRCrLuJo2J0UWQ5hPVquCsnKQ+nAagNrGMYI79mi3iTC7fUQEmF+MxeY7q1BBWj0TKCCNVSPOJwihA7mf7RVImfy8dOJWSWi25Kpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9626.eurprd07.prod.outlook.com (2603:10a6:10:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:52:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:52:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH intel_iommu 3/7] intel_iommu: make types match
Thread-Topic: [PATCH intel_iommu 3/7] intel_iommu: make types match
Thread-Index: AQHalM0i32KNWd9K4kWnjKS4kUptSg==
Date: Mon, 22 Apr 2024 15:52:53 +0000
Message-ID: <20240422155236.129179-4-clement.mathieu--drif@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9626:EE_
x-ms-office365-filtering-correlation-id: ba6e9a88-ea34-4ece-b493-08dc62e44549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?c2dLTmYzb0gzUFhIMmpqU2JNbzN1STJYeG9wRit2MzZuWWNwK0Q3MlJYWHRL?=
 =?utf-8?B?cXF2M2FKbmdCU0d2STBOczE0ZVMvV2ppeWNka3dXbjk0bXh6a0V0SlV6QjdO?=
 =?utf-8?B?SUovNTltdWFYdXZvOTNkSWJpZlhISkdSQm1MeGV0TWdNUzFya0RUNTVwTXha?=
 =?utf-8?B?VjVib0svNnFjMWRsQmxiTVEvYzNGS3BKaG0rRlQ3THdMeFZieWp0NkxPRS80?=
 =?utf-8?B?dkdRdHZXSStqQVB2a0NtcDVPQVVZblErYjd0TS9SMXBTSUllRmhWSUJ2VXFl?=
 =?utf-8?B?cTdwMGEwZVdxOGFlRE1Fb1N2SWc4cjNtMkgwaU5TenMwU3BSL2lpZUVFSW83?=
 =?utf-8?B?bXA2aXhucHNwc2NCSE1iMWU1L1lWYzdvbzZOVTJoWjBpNG1UaVN3elBvWllG?=
 =?utf-8?B?aUtnajlwa2I3YXJxWVBma01YMllLcnhZMDB6c3hUZlVMTHhISWxkM2YvM3pL?=
 =?utf-8?B?VWVkd2NYeXMxZWpnc05BMDdzTVlzdWZLV0QwNmJqdnBXcHFUV05Zc2lqeVpB?=
 =?utf-8?B?a0FoNnc5QzZ4a0l6UEJmZDNsS0FwRDI2Z2VZSW9VK0RzeEdHb2h3UDVWVGlm?=
 =?utf-8?B?b2M3L2R0M2kwL2pzbWNmdi9GM3ZwWHBsUFh3TTV5TFBGdzA0ZlM4MXhLVzZP?=
 =?utf-8?B?TDB0dHRVMStxdS80L24zVmVtVkllbDl6WEQ2enJpLzFHYkNoVlpCZElqTmo0?=
 =?utf-8?B?TEhSU3VXM2R2ZitkSm4yTloveGUrWUFqZitXSkdvQ3JITzd0ODFPb0dJOWFC?=
 =?utf-8?B?OUJlUFRsc0h2bXVsMFFLVmpvQ0ZEN3hERWNrdTd2M2JObE5rcGhWUE5zUEUr?=
 =?utf-8?B?SGphdEhuSDBDVVo1MmF0NTZwc25NY0dNZFh4SjYxSlRReWx2bzhOQzhCaUc3?=
 =?utf-8?B?Ky9MVzVkdnJlSldnMHpFREpiWVFKWGdlNXRMVTdWOGNoRmVWclhoZXhsQlFw?=
 =?utf-8?B?OC8wQTN0eWQ0UkE0WktPTi9Tcjc5WFRDWFFFVW9KZWNuVG1JVVJnQlA1TDJX?=
 =?utf-8?B?U2dwMDY0bzZaQzVGZXJRZHZUQlZFSitpU3p2NTlBMk82b0tTSFRqeUFTeHhZ?=
 =?utf-8?B?MGttTUVqSm9NYjFUckJIaEVaVGYzSyt5Q0FPOVpGVkZzV2dBYlR2a0w5TWRp?=
 =?utf-8?B?ckFjNUU4UjJ6S2lDaEdBK2tPQjZUbmZkaWhRREFDamdTWEhuNzU1ekZGUWdP?=
 =?utf-8?B?ZHgzaTRpeWUwYXdrcmlPWTRpUDZaOVhId2tQREJwb3NBeWc0ZHpXdDZyVEVP?=
 =?utf-8?B?Z0hxaFRZeUswTVRSZU9iZkMybmhkM2d3WFY5OTNSNGQ3NytmcVoyN2plMEQ0?=
 =?utf-8?B?OGJvNTJZeWRpNjQ2SmtaWkhRUUw3eWdRbVIrOGdBWXZmTzRZdEk1b1p3aG5u?=
 =?utf-8?B?RTlmZWl5L2dqdXFDMHVsQlMwZkxGRVNzV29rRDFuMmZpNUNOdzByUFduazFa?=
 =?utf-8?B?a2V3UXdZZzluZGlheVdJN3kxc3VGMnE4TUdyQThUdGRja1luV0FXKzd5djRx?=
 =?utf-8?B?eVpCb3dOSVB1d2RzVjErN3gwcTAzNEtzRWljZzVMRTNvSWxadGJ4UFRnbllo?=
 =?utf-8?B?bzg1Uy9IN1RDemtqMnBKM0lwVnBFOXdVbGJNcHk0SGlIemNJYzdXcTB2dVJK?=
 =?utf-8?B?TFQzVlJ4d2hBQ2RvNFJ0S3lXR3V5dkJkcjJmVDc3UE4rbFA2bGNDVm9vRjk2?=
 =?utf-8?B?UVFONFliVGdpSmRSeFlUWEU2N1lLbFYwbzhxNDVZVVJrZ05rWHJlS29FbHRM?=
 =?utf-8?B?bFNrNXh6YUtOQ285WUNxZTR1bDJGSmdFYnpQcU83ZDY4R3dTVUhEWmFNZ1ln?=
 =?utf-8?B?SE9oc0ZsYVRqN3JGQlVaQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVlsN3VWbC9jem45VEF0WS9JRkI4QmZieS9GNXA5KzBIN3RjSGZCM0xQTytI?=
 =?utf-8?B?MzRKWDZpN3BqbXdUYVluQUV3SHRSUHptaXZZMnhzQnFHc01LT1l6WHhERSsy?=
 =?utf-8?B?U0JYSFluNjhlY3pMbm9LSHZRK2UvTlNnOG04WnNuMnRLelBWakFLaURNd0l2?=
 =?utf-8?B?U0g0THlVaDVrTFNIdzByZERIcVpYY2VpNWNPRnZ4eU40SG9IQkNLQVhTS3RN?=
 =?utf-8?B?ZWJyVS8vWnE4Zjllam4yQlNhSktHYm44N20xMUlIbUg3THdtNWxhMy9rSWVN?=
 =?utf-8?B?MDlvMGpOTmZpTUxqdHVlR3NkTWRyWFF6Qm9QZzBJMkxkQTk1UGVjZmZXTmRo?=
 =?utf-8?B?S1B4ak5ITlgvaGR3TWVmdG9MZnVvTnZyRWxBNXdLKzZodkUrZi9MTG9hdThW?=
 =?utf-8?B?Z2t3eWRYRnJWNGpuOUpjay9HeGZuQ0ZubVN0alRmY0U1WDdORlVOQnVqSlVi?=
 =?utf-8?B?YTN3RHF0VjR3ZXBXSStFSktRZEc2RS8vUTc5L2x0WmVjNEs2U2l3MWNlejBZ?=
 =?utf-8?B?TlZzQ1M4azFaV0Zqak5QTG1VNHhSbWx1cWFkemJhWHVCREpwR1kzS1ppMjdO?=
 =?utf-8?B?ZXNaN3oxek41ajYwZG9GeUo5NDV4U2JXSGNyUnRzNkdjQnFGeTlSNHh4S2xa?=
 =?utf-8?B?MkVaVmVlQUhUOXg3WkRrL1hxVVdGWHFTR3hrRDY0Y1ZhNjhQMldjbzBXOWlO?=
 =?utf-8?B?RXhPUTZIZm9qQUIwY0VUYktyMVF2OE9WdmNPK0xWa05zWWk5YUs0WmptWnp6?=
 =?utf-8?B?WlpVK2NhWEVNYURHdW9NaDBFSHgvZzhDT043bVAzWUhaMG1vaWU5cFZFLzZE?=
 =?utf-8?B?VGZrUWtpYUcvWVpNYjFmUlhZUVZzWHUwZHFueExNWXlmaVhZbXJLSFZZbVlX?=
 =?utf-8?B?cmJUd2F0OWlaSWxab29DOXVjVis0VFcydkYvUGoyS1h6eFVyQlNxNm44OExl?=
 =?utf-8?B?dmhKNDJDSWJmSmI1Y3grSUR5VmFNTmg5YVo3d2FKbnJGdWoraG8vQ0tsS1FI?=
 =?utf-8?B?RmFhWXZXU0lVdjdwYXdsbzhoSW1uNFArWXdPb0NKak9OSlZNaUF0TmpUT09Y?=
 =?utf-8?B?TWxleUVaUGV6d3FvRkZCY0NNWDdReHZTd3N0WWVNWFhyT0I2dGlGUS9KdUlq?=
 =?utf-8?B?d1Qxb0dYcWx2bFJzU3VLY2R6T09XVHVpVzQ2ZlVidWpaUFZqOVFKcWQwSlda?=
 =?utf-8?B?RHVKQ0l3SWNPcHA5dTFRTm5PK0kwQVF5T3hRQkh4N08yeS83RjcrUjFlRWVG?=
 =?utf-8?B?Ry8zbVFiVnZxOFB0RmUvU2g1MWVrVFJwSzFzRFcvL0ZTdTRoYzhvK3N6Wjdj?=
 =?utf-8?B?Uys2MVphZ1ZkSU5MV1F5cGlvQlB6WDBrYkRwU3Jjd2lEaVhweHNrVEFWVHVq?=
 =?utf-8?B?MHgyeGhnbm9jUnlLcFZJV29kTUsxVEp5ZTZQQUpqc1ZleUZJaFE1UCt4Mm1T?=
 =?utf-8?B?Y2tRUUhVdnR3a2d1SnNmdDRQSmRzWFJiZVpKUUpqWmFLVVhRNCt5WURwQ0Yw?=
 =?utf-8?B?L1V1MSt5Qlp4NVdDemNwT0QwV3hJV2Q4ZERwK0FIMXRNbXZNVXp6Y3RWYWVN?=
 =?utf-8?B?VjBuRThIclpJUVM0WGZjbER2S0RvamYycmk3aWJReERYN3BNb3BsN1IyVDVL?=
 =?utf-8?B?azk1azEyb1NwMkxYMmlxSlNvSGlzQkxzVFNVWmxmbEN4anVKbG9Fd1pQc1la?=
 =?utf-8?B?aHEzWXdDakQ3S1l3TGRTUmlkTlFrQVhwUmUrMERnMmhqVHpWWXFFZmJTUWJw?=
 =?utf-8?B?azBHYjNxSEs3aXkrKzBscnJLQzByWWVVMHpVZStPUkZncWpCdE1sMDRONEZN?=
 =?utf-8?B?R3FGNnBuM2pacjhLcElrUFM1cjdaOVo5amwxY0ZGbDBlSEd4MWduaUppaVJB?=
 =?utf-8?B?SnBnOVo3bWZUZkR0UTJGOGhUcnZxVnZ1Tk1VbzdoeCtQQ1BpdnZ2ZUh2Vzhp?=
 =?utf-8?B?cWUrRnBEWjlxN3dKekdteWI3N0MrZmNSTnBORXhlbWZNMWloTlF6amt5UXFa?=
 =?utf-8?B?cTVYUVRjQVdvL1pVWUI0SFQ5ckxDL3BOVndQWVVqOXoyVHdwWGZXUVRNRUdz?=
 =?utf-8?B?NVBxNjloQUhUNkxwcDQ1N1N4SVBnUDh5Rm92YWdISGZzbENYTlBSdngxUGVR?=
 =?utf-8?B?R2J5Z0o4ckpySm1JaTNjZXpBd1dST2FSQVBWYUsvTXhpQkRUNzFKS1RkaDhH?=
 =?utf-8?Q?LrhoVv8bD3gV+bUcUiCnRQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ECFF188561B0743B8442DC143DDADF2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6e9a88-ea34-4ece-b493-08dc62e44549
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 15:52:53.1092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34W9htQZnmFrDEpnzJ+P2F9uJaU2k05e/WUKWQbJ0Osk335O0QBOLWbYKKbdRrzn8gURaGpyjrujOnAaT8LuPORGBuDrWLB8sZMeEawGyAtOqOs8x9QqB1ZhVlYI+q0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9626
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

VGhlICdsZXZlbCcgZmllbGQgaW4gdnRkX2lvdGxiX2tleSBpcyBhbiB1aW50OF90Lg0KV2UgZG9u
J3QgbmVlZCB0byBzdG9yZSBsZXZlbCBhcyBhbiBpbnQgaW4gdnRkX2xvb2t1cF9pb3RsYg0KDQpT
aWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDIgKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggNmYx
MzY0YjNmZC4uYmE1NDU1OTBiMSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMzMzLDcgKzMzMyw3IEBAIHN0YXRpYyBW
VERJT1RMQkVudHJ5ICp2dGRfbG9va3VwX2lvdGxiKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2
X3Qgc291cmNlX2lkLA0KIHsNCiAgICAgc3RydWN0IHZ0ZF9pb3RsYl9rZXkga2V5Ow0KICAgICBW
VERJT1RMQkVudHJ5ICplbnRyeTsNCi0gICAgaW50IGxldmVsOw0KKyAgICB1aW50OF90IGxldmVs
Ow0KIA0KICAgICBmb3IgKGxldmVsID0gVlREX1NMX1BUX0xFVkVMOyBsZXZlbCA8IFZURF9TTF9Q
TUw0X0xFVkVMOyBsZXZlbCsrKSB7DQogICAgICAgICBrZXkuZ2ZuID0gdnRkX2dldF9pb3RsYl9n
Zm4oYWRkciwgbGV2ZWwpOw0KLS0gDQoyLjQ0LjANCg==

