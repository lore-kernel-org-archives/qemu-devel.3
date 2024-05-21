Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA099C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHl-000807-7h; Tue, 21 May 2024 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0007i4-FC
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHP-0001aH-MQ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297107; x=1747833107;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JJToM5aUVZELZtQhaipfZSocc6vx0ws4JjCmNvITMS4=;
 b=Q4ORA9NQzvt/9qGsZ9NsecRk1oRlnQPuGSjQc/a/Pn1skVBgL26ybrtK
 0KPrntxOrabZlrLTnw7k1L4OUUGZbqYciTjGSppBD3MUjvz0HTC7z6xZq
 WmpQI7eJPtg3ZgxuWsUjLg8Qnf8r28NIx1vUv+r1nm5H5itON/HTNHuZb
 DTXWzMyjrApZfRT25uk1UlfCyAao8Qd8sqCB6KyZCfvQ6g0qUL8tkheEc
 yuLtJd+CwM7hSn4lfGoYqsJusau8Y/1XTmaSwDHMeAstcbF5GYQ/v9C6k
 SVhPrZXKCZIAHKHmqlRVywD96bz8q1UK6kWE0vgV/3+s8MsJSQus8E8zn A==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061499"
X-MGA-submission: =?us-ascii?q?MDGGmiUBTtPJ58NJ3am1XcxCnTVKvHX9z2M7Zb?=
 =?us-ascii?q?68JTmXlydljWyvft7Sm5CVtmJ/EZellkdczteT8VVfZ+n5jRFC2pxw5J?=
 =?us-ascii?q?cfGc9+HZDZEFY0xm0pnnf3UqKQ3549K3yQ7PbrgWA1U1ifSvOvcooiQ6?=
 =?us-ascii?q?MHa9HwwwQlYqbYmCfci6cDiw=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVqjDoiaN5fLIVimr0e/TAcbscvVjwz39szuZOhf71/yzbppimVUs6TA/FUsugN2X6i48CbCKdpwbX4WBnIGVJ7Yb7JOZlpDpoZCbNhMpe3a8DEohFfaDJQp6IHzJMXq3Zb4uqMvGuPrWpVIisIjIE/qpurYX4L27vCV6zmvENtKVURxiGeDjN+v84o9DEOOhAxm8h7bRw/8zfHn4DtZGba9Llx3owq82lTeKa9pvK1N7buU9M/9uP4sTOG3zXLHmeckdB+4R2xPbJjwU7QLoEBUoaBLwE/nzLXlepOCFcoj4lMuz2FuiwEJSwPInWnVd7aAxrIeSJKi+KfmgVQEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJToM5aUVZELZtQhaipfZSocc6vx0ws4JjCmNvITMS4=;
 b=Taq9Lwr2dFpCIF8fy9Ul+bxt/Wm6eMeqm/D++C+M8oV2rdGBd5Cl7gCLCeybGq7xpba77VplJSaGBU3N2bkOwcYnnPTQrd11sDYobyCO5lgsh5oAhCzB3xul6P8BHm1Tm6qPA4BAJ+vztt9uFaT/+/Kyr9INIVudGDfHZ65qT75gwZcPkg/I9XR9Jd0T3FrcpoU0R5Ac0iixNUGoBGsFrsuEzqZpBlVRZVhm3gtlP/y6S4UHRwhYmrn34hgcYwByIB9Py7+XSKIq/i2yjZSmlal77nTFJEC5RaLvL62H5Zp45qxRc5m0hCn5RZWNsC2DwLthOjIu5gxUj2o+yEiY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 06/22] pcie: add helper to declare PASID capability
 for a pcie device
Thread-Topic: [PATCH ats_vtd 06/22] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHaq4BsddIhOUtVnUa3KEFa1N4Zig==
Date: Tue, 21 May 2024 13:11:41 +0000
Message-ID: <20240521130946.117849-7-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: 2cbb2d2f-5b03-4f81-814c-08dc79978e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OEpRb2NoSCs0NWtEaGpKOWdjTVJLNC80TjlCdWthb0JQZ3FhalpjNVF1QTJq?=
 =?utf-8?B?V1NNWkY1bVR2VWt0SENPRGdEdXFjZmh0aUxPcEFWejFNb0lBb0lia2QzMWNm?=
 =?utf-8?B?VjRQaWxBUFZHZGhiTzh4MnNObDFYMmVibmJmWkFXc2ljTHdwODdXaG0xL2JQ?=
 =?utf-8?B?TnFObG14RXkzNEJ5cGVaQkdlRTdYVmwrMmozT3FvUlBUc1hPS1RoN0xSckNu?=
 =?utf-8?B?R0o0WXVERzNJUFVxeHpUREIvdER6RUlnUzh0WXdtVnhrSXI1MVcxOVpMeGl2?=
 =?utf-8?B?b00xa1F0N1o1OGdCVjhtSGlXTVJKOGtqNXl0WXhHMGhxVDNvS1gzSlRTdnNZ?=
 =?utf-8?B?dzlUdnhHRXQwdmZCaUhmSlBvTXZqRmpJcG01VFpxYy90Qm9OK1VLQmxmdGta?=
 =?utf-8?B?UGhsZlFTQ25URFpYWmVMOC8yUVdPMDhTY1NITnR3Tk9nUkQ0K3lldVd0cldq?=
 =?utf-8?B?MmxRSTRXNTFOelBGZ25UYkV5eWtlZVpNLzVvamV0RlQ2a1hCYTlNaHRNZHda?=
 =?utf-8?B?VGF5S0sxQU96MGtEcUNwTi94a1RtdnFNM1hKZzY2Z2I2Z2c2MnpCUXhXTGNG?=
 =?utf-8?B?VnRsVWJXYUhCQ1ZjT2tJZ0g4VW01K243ZzdhMWM0bWpuUktjVGw0Snpyd0J4?=
 =?utf-8?B?bEh5Q0NjUkwwbzkrem1UbU9mRjFrYWRXN2hqM09vSk0ybjg5Nk14bVpZYmR1?=
 =?utf-8?B?NFZNR00xQnNLSXdqTTZVSjZYR3QremdiSlFSREVEQWpyWUp3TkRkSk1MNUJV?=
 =?utf-8?B?OXlBWVFBTkRsTWdCZTZFRVorT0dHRXpLYS9teXMwRm05UHRBZ1JETzJtVEcr?=
 =?utf-8?B?eEVSVS84N21VU0ZKRFVCek8yVEIrYmFGdzI2aUZwVXQ1SGhLQlUvZG4wTlZY?=
 =?utf-8?B?WmIvRzZIS2pBcEtUWW03eGlyOFgrUkp0bkNvTnhNNWNoVVhhaGJ4NHRoZVF2?=
 =?utf-8?B?UzNoMmJJczRIZHZjRWJsVU10NmlpZGZQR1lNa0p6dWs0YUUrZGFYT3dDcHg5?=
 =?utf-8?B?dU1RUi83K0poYUpyb1FReDlJSURWYi9yZlpiZGRxcHl2elgwTUx3RG11S21m?=
 =?utf-8?B?RHppeEFncW9tTktrMlZlUDZ2SFlicnFjZUs4elM1OGVJYnViTUVTdERvS2J3?=
 =?utf-8?B?S0FkSlJBSzhaTS9zdTFZREpWaW9la2pEdWZRMTQwakRwc3JGV2ZIUWUzS0lp?=
 =?utf-8?B?VXZSSnNCTnM0cE5PNGh2UmdTVDYwbjdtNUwwTjNKOUExTitUckUvVzU4Um51?=
 =?utf-8?B?MXZqbmRwRjIrL0FGM2s5MTk5c213ZGhCVHJUbWUxOWptYklXTlRWTlRoQzJa?=
 =?utf-8?B?OEFPY0hYV0RwNk5ZVExkdTlWMUZzYXZmRWoxbmRMT2RmRVR6Q3ZuQUlJcWpZ?=
 =?utf-8?B?MFF5OHdTcXBlOEhRWm95aUljWjJKNU5sM3c5SnBJV3E5WDJOdUZsd2xpdFVr?=
 =?utf-8?B?YXRRWENtR01hV3pwQXJ0dUs1Qk1rV25jdFYreHpsSDZpVDJOVGZubUUxNmRR?=
 =?utf-8?B?NmduRkVnS2dLUlBrTUVLbEQwVFRKUGUzYlZDaG5sejNVL1VDVzN2MEZKVzB4?=
 =?utf-8?B?bFJyMkxIaE9FSC9iRi9YcjFHZnJ3UzAvTEZsS2ZDbEVPNzgrVlB2a1g0NFVJ?=
 =?utf-8?B?ekZKYWRXU0h0Ym8wdkFsYTE5Um5CYm41eFovVm1tWDFjekpqbGNVbDhnTlM5?=
 =?utf-8?B?bTVTdkF3Ti96ZDhxeXg4MVZhRWd2Y3E2NUQvSXFDSWxGdDZWekorakRVRXAz?=
 =?utf-8?B?MjdaekRZbW9JSkhGLzZNUVRuR0V5UWMyU1o2VmUyUmpUZ3p2dFFGSVZDUG8z?=
 =?utf-8?B?UGhrWVQyQkF2Vit0WndBZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnRmMWphVEoyTDMvOW5CT2ZySHVCSDZIdjA0SUpja0lTT0k0T0UwcHh5QTJp?=
 =?utf-8?B?NWU5MmpOSC91eVl1OFNhSEV0eTJkczhPOXNoVVErLy9oZlA1Z1VIWjJsVndz?=
 =?utf-8?B?ZHBRWm1qanZob3pUOWtrNmV6azlLWFp0bXk0d1I4clh6WTRJSVdDWEdvWEtN?=
 =?utf-8?B?azNaVzRuNXBwbE9jWXBpRXpqVDNTbXZBY1pVMkVWWlZmeERNQTE2S251MFZG?=
 =?utf-8?B?UTY0SG1EL25ua1ZIU3hHODBydUU3YnNPQ0xIU1hKV2dWaXl0SXhzNTlXdERJ?=
 =?utf-8?B?VHBUWTVWNGoyWGhTQklQMngzOUpUYnROd1RSb2xmNzZ2UG80VklUVGNnSVph?=
 =?utf-8?B?dnNwNnZHaUVWS0ptc2NUVC9rdENmMzNkV3Vya3VMZ0duYWh6ZWM4MEc3YXlh?=
 =?utf-8?B?MG9SaDFnK2ZvenBzLzdLSEpsdUlCekN2ZkFKanJXaUgxNDJzTHphR3RMRmJT?=
 =?utf-8?B?WFRXNHVaa2NsL3c3dE5mUlk5c3htMUZ3WWUwc2Z0UU1PSDlHWnQrelo0UStW?=
 =?utf-8?B?UkRVMkcxNEJITTIrSGhBNlVFUjdNeVExc3dXU1p4TlBoMVdvRXlXMzFpMHdl?=
 =?utf-8?B?dUVqdVJFUXdYT01KdVpaMXlMblJrV01tRldWSVdxWi9DRWNmNlIrUDlLaTVF?=
 =?utf-8?B?dkZCbitDOWVqN2lPMFpPYnVVSnhTUjZBUVN5Sk5URUpjSFAzd0JFOWY5aEhX?=
 =?utf-8?B?aC9IeWMxYzFUNG5vMGJ5QVVPVi9MVHgvTWJPZEllb2UrNnlOQy9qNXFPd3A3?=
 =?utf-8?B?Z0M4czJxNnBrMjVaaVA2OGpNdVRvWjJRU2g4a1IyZk44S2pJcGlxYjdSeDRE?=
 =?utf-8?B?MDMydDVmellYQ0s5UStZaXVLeHRscmFsSGl2ckpIeUQzbTc4QzQ0a25JaTNr?=
 =?utf-8?B?TTNBemFBZGhmMFhXOHdNQzQxa1pyRmhRZm5mYzFsRFFCZTVjek5ZbGJsMTAy?=
 =?utf-8?B?TGxKT1cvT2NERVh1UGYyKzFoQTV1VnhvYkpKL0xUOXFnVU9EcnVhbTFybjcr?=
 =?utf-8?B?U3g4bmtDOHhuTEYxdm9Ncml1Ulk5THJNUTQ1bDRqRTNRbVkvUDBPZnJoYkhN?=
 =?utf-8?B?amM0cm05S1hJeGFNRHZ6RlN2SGNrM2dmRjJDZm0wOERPeU9vd09Vd1NXb3ZG?=
 =?utf-8?B?UUFuZHdOOXArTXN3cjJicGRoQURUSWJEcHVnaktXNXdMRmZrWWJ6QytGWTNK?=
 =?utf-8?B?Zk5DdVdZa2NyWEl0a3JsK1VKQ2plRlNVT2JZOEZUL2l5NW1DS3U1K0hSMDhN?=
 =?utf-8?B?ZWVoQjhaaXJLNmp6eGRxTWRkanAvcy9JRVR2dXppMnF5NlRlRm5wR1JEeWsr?=
 =?utf-8?B?ZUtLY2pIS3cxbXd5UDFlWDZBRGNSNFNNWEVNd1NKM2YzTlo0OGtQb2FPOVlR?=
 =?utf-8?B?KzlydW9BOGY1cmhJMXBobDg3NUQvQTBFdVFJbUJwRFBZQWpIRWZvU3JrYzQ0?=
 =?utf-8?B?U2RIc1pzQlc1N3M1bzR3YUNxM0JBc1NmMzBEVS9PSVNjb3M2WUI5Q0NITW9t?=
 =?utf-8?B?N3ljdTBWU0FDNjloMlFCSjJQRHBvdmVKaTV2NTR1WHhoYk56cnVPazZZL1JM?=
 =?utf-8?B?ZXB0ZmlsMnFZOUtFakQzTG5EZkk5MEhwZFpVVzRORWFTRUYzZVNRcFhiWHFw?=
 =?utf-8?B?ZklyWHhzMjdZd2R3cWpKejlhUmJ4eDlpaU9RcjI5T2xCS2s5STZvNG94NXIx?=
 =?utf-8?B?Uk95dkVua1RCL21aR054RlNrN1VNbXAwdW5BTEMxbmNabVJoS1NTSTZtSWZY?=
 =?utf-8?B?aEF6M0ZmK08wRFFSekpCLzlXa2pMTlMvdDFWNDg5MFY4VUNXSUQ4RXBGNTdS?=
 =?utf-8?B?S0NTVVZiRmN3UTVyblNKeGpyTDhLZEZlRkROVG5DcEsva2E4dDhJRzdxN1cy?=
 =?utf-8?B?ZlYyWlY3c3d3ME1DeTQrVDJGcTcxcGwwV1FhL0ZQNTZ3c1JRekRlRkZaU1c4?=
 =?utf-8?B?L3lZemwwUHBQSS9EVjlzcTBmVFpLTVhlQmdDa1Y2M2xFdkJ0bEFQVnZVUUVE?=
 =?utf-8?B?NCs2U01Gb0w1bjJIaDdEc01vREc5WitXeTBPZENaR1hTWUpjSFB1eXhicktv?=
 =?utf-8?B?UE8xdlpDTmUzbCtQYXprLzV6MjhZVWhkbDdFWHZPelZ2QXg5cGdkQ0tqei9j?=
 =?utf-8?B?QmFNc2VYR3d0eG9ib21MWk1ZU09WQW5EWUlRQWtBK0hEa1RwT0xyc2c4YnVh?=
 =?utf-8?Q?PnCTNZNGuYDmtGUdtaWRQtM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDC454CB11B2FA4DAE6E87724F28D3AC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbb2d2f-5b03-4f81-814c-08dc79978e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:41.7446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMRGYmhClema51FExHKXmDWGnVVZdqvdFnIt8sqY8NTBuoXx+zfuzDfvQl9aY7cO/G9rGOHdr1MXBEwtBfYFN5+3QFCyDOH4BO4pQ/tiUn7XLUOUBGbtY3yxHKEkIySk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNp
ZS5oICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysrKy0NCiBpbmNsdWRlL2h3L3BjaS9wY2ll
X3JlZ3MuaCAgICAgICAgICAgICAgICB8ICAzICsrKw0KIGluY2x1ZGUvc3RhbmRhcmQtaGVhZGVy
cy9saW51eC9wY2lfcmVncy5oIHwgIDEgKw0KIDQgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUuYyBiL2h3L3Bj
aS9wY2llLmMNCmluZGV4IDRiMmYwODA1YzYuLmQ2YTA1MmI2MTYgMTAwNjQ0DQotLS0gYS9ody9w
Y2kvcGNpZS5jDQorKysgYi9ody9wY2kvcGNpZS5jDQpAQCAtMTE3NywzICsxMTc3LDI3IEBAIHZv
aWQgcGNpZV9hY3NfcmVzZXQoUENJRGV2aWNlICpkZXYpDQogICAgICAgICBwY2lfc2V0X3dvcmQo
ZGV2LT5jb25maWcgKyBkZXYtPmV4cC5hY3NfY2FwICsgUENJX0FDU19DVFJMLCAwKTsNCiAgICAg
fQ0KIH0NCisNCisvKiBQQVNJRCAqLw0KK3ZvaWQgcGNpZV9wYXNpZF9pbml0KFBDSURldmljZSAq
ZGV2LCB1aW50MTZfdCBvZmZzZXQsIHVpbnQ4X3QgcGFzaWRfd2lkdGgsDQorICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBleGVjX3Blcm0sIGJvb2wgcHJpdl9tb2QpDQorew0KKyAgICBhc3NlcnQo
cGFzaWRfd2lkdGggPD0gUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIKTsNCisgICAgc3RhdGlj
IGNvbnN0IHVpbnQxNl90IGNvbnRyb2xfcmVnX3J3X21hc2sgPSAweDA3Ow0KKyAgICB1aW50MTZf
dCBjYXBhYmlsaXR5X3JlZyA9IHBhc2lkX3dpZHRoOw0KKw0KKyAgICBwY2llX2FkZF9jYXBhYmls
aXR5KGRldiwgUENJX0VYVF9DQVBfSURfUEFTSUQsIFBDSV9QQVNJRF9WRVIsIG9mZnNldCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRVhUX0NBUF9QQVNJRF9TSVpFT0YpOw0KKw0KKyAg
ICBjYXBhYmlsaXR5X3JlZyA8PD0gUENJX1BBU0lEX0NBUF9XSURUSF9TSElGVDsNCisgICAgY2Fw
YWJpbGl0eV9yZWcgfD0gZXhlY19wZXJtID8gUENJX1BBU0lEX0NBUF9FWEVDIDogMDsNCisgICAg
Y2FwYWJpbGl0eV9yZWcgfD0gcHJpdl9tb2QgID8gUENJX1BBU0lEX0NBUF9QUklWIDogMDsNCisg
ICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgb2Zmc2V0ICsgUENJX1BBU0lEX0NBUCwgY2Fw
YWJpbGl0eV9yZWcpOw0KKw0KKyAgICAvKiBFdmVyeXRoaW5nIGlzIGRpc2FibGVkIGJ5IGRlZmF1
bHQgKi8NCisgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgb2Zmc2V0ICsgUENJX1BBU0lE
X0NUUkwsIDApOw0KKw0KKyAgICBwY2lfc2V0X3dvcmQoZGV2LT53bWFzayArIG9mZnNldCArIFBD
SV9QQVNJRF9DVFJMLCBjb250cm9sX3JlZ19yd19tYXNrKTsNCisNCisgICAgZGV2LT5leHAucGFz
aWRfY2FwID0gb2Zmc2V0Ow0KK30NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgg
Yi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCmluZGV4IDVlZGRiOTA5NzYuLmI4NzA5NThjOTkgMTAw
NjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3Bj
aWUuaA0KQEAgLTcyLDggKzcyLDkgQEAgc3RydWN0IFBDSUV4cHJlc3NEZXZpY2Ugew0KICAgICB1
aW50MTZfdCBhZXJfY2FwOw0KICAgICBQQ0lFQUVSTG9nIGFlcl9sb2c7DQogDQotICAgIC8qIE9m
ZnNldCBvZiBBVFMgY2FwYWJpbGl0eSBpbiBjb25maWcgc3BhY2UgKi8NCisgICAgLyogT2Zmc2V0
IG9mIEFUUyBhbmQgUEFTSUQgY2FwYWJpbGl0aWVzIGluIGNvbmZpZyBzcGFjZSAqLw0KICAgICB1
aW50MTZfdCBhdHNfY2FwOw0KKyAgICB1aW50MTZfdCBwYXNpZF9jYXA7DQogDQogICAgIC8qIEFD
UyAqLw0KICAgICB1aW50MTZfdCBhY3NfY2FwOw0KQEAgLTE1MCw0ICsxNTEsNyBAQCB2b2lkIHBj
aWVfY2FwX3Nsb3RfdW5wbHVnX2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwgRGV2aWNl
U3RhdGUgKmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7
DQogdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpo
b3RwbHVnX2RldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGV2aWNl
U3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTsNCisNCit2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lE
ZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KKyAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9kKTsNCiAjZW5kaWYg
LyogUUVNVV9QQ0lFX0ggKi8NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3Mu
aCBiL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQppbmRleCA5ZDNiNjg2OGRjLi4wYTg2NTk4
ZjgwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmgNCisrKyBiL2luY2x1
ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQpAQCAtODYsNiArODYsOSBAQCB0eXBlZGVmIGVudW0gUENJ
RXhwTGlua1dpZHRoIHsNCiAjZGVmaW5lIFBDSV9BUklfVkVSICAgICAgICAgICAgICAgICAgICAg
MQ0KICNkZWZpbmUgUENJX0FSSV9TSVpFT0YgICAgICAgICAgICAgICAgICA4DQogDQorLyogUEFT
SUQgKi8NCisjZGVmaW5lIFBDSV9QQVNJRF9WRVIgICAgICAgICAgICAgICAgICAgMQ0KKyNkZWZp
bmUgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIICAgICAyMA0KIC8qIEFFUiAqLw0KICNkZWZp
bmUgUENJX0VSUl9WRVIgICAgICAgICAgICAgICAgICAgICAyDQogI2RlZmluZSBQQ0lfRVJSX1NJ
WkVPRiAgICAgICAgICAgICAgICAgIDB4NDgNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3N0YW5kYXJk
LWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaCBiL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51
eC9wY2lfcmVncy5oDQppbmRleCBhMzkxOTMyMTNmLi40MDZkY2U4ZTgyIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3BjaV9yZWdzLmgNCisrKyBiL2luY2x1ZGUv
c3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lfcmVncy5oDQpAQCAtOTM1LDYgKzkzNSw3IEBADQog
I2RlZmluZSAgUENJX1BBU0lEX0NBUF9FWEVDCTB4MDAwMgkvKiBFeGVjIHBlcm1pc3Npb25zIFN1
cHBvcnRlZCAqLw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DQVBfUFJJVgkweDAwMDQJLyogUHJpdmls
ZWdlIE1vZGUgU3VwcG9ydGVkICovDQogI2RlZmluZSAgUENJX1BBU0lEX0NBUF9XSURUSAkweDFm
MDANCisjZGVmaW5lICBQQ0lfUEFTSURfQ0FQX1dJRFRIX1NISUZUICA4DQogI2RlZmluZSBQQ0lf
UEFTSURfQ1RSTAkJMHgwNiAgICAvKiBQQVNJRCBjb250cm9sIHJlZ2lzdGVyICovDQogI2RlZmlu
ZSAgUENJX1BBU0lEX0NUUkxfRU5BQkxFCTB4MDAwMQkvKiBFbmFibGUgYml0ICovDQogI2RlZmlu
ZSAgUENJX1BBU0lEX0NUUkxfRVhFQwkweDAwMDIJLyogRXhlYyBwZXJtaXNzaW9ucyBFbmFibGUg
Ki8NCi0tIA0KMi40NC4wDQo=

