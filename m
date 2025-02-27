Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECD9C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbY2-0005Gd-9L; Thu, 27 Feb 2025 05:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbY0-0005F5-49
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:20 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXx-0005o1-Fk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653717; x=1772189717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m5wBA/DKT2nuLCzYeyNMgxFYfXCnhkVt7sDapOAU8cc=;
 b=ONa/V0HAFlPG4XSt9RPXXmQK6MGoKfmdeLIPKfFZPUmegdEYmlV6QQRN
 n577lGdRV/XhdHseu/XxSQAm5x4Zv7AHYs8HauEGUXGn14/szifc418mf
 h8tuUZC4ZmqdZ+S/lG+Ej3EjBbO7okNyv3gKynpVu+/5CBvbU6hajHvW9
 J4xv6IVcCzTT+AYEfn6Q3HfQetSFQSNyUwN5zoIUJ1S7oeJPs3x8yh6Tq
 pd6dPDaqjXo6Ce7RNgDX8J74pGzlqRx0wHSOdnBD1tF9DFbtpSuTWtQgs
 r9UUfy1rocKNlyUBaz/ylpIFBXtfLjDPKoLpehVAK//Z/HBzZWNAuxI6f A==;
X-CSE-ConnectionGUID: vAicnbXgTAicd4doYnoxZw==
X-CSE-MsgGUID: TJSQbYstSLaons8+2OPVeA==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331862"
X-MGA-submission: =?us-ascii?q?MDHkR2FPGDsvQcBl9Qq7/acCJs8ILOvSxNe9r+?=
 =?us-ascii?q?yNe0TN836V4+It1NjCauDHcykPF8S3EUIFmuijkyil0YRm0Ym7PVSoNu?=
 =?us-ascii?q?reHvaLEBrfEl9MXDNKHx+Q7s5mY+tsi1uQek/7tKnOUyXh5k1ovrfG2U?=
 =?us-ascii?q?Hy+qu3pxkteYX43aJ9KeVImg=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAeyMB5VXcYKIbGy3s5EAHUbbt/GCkViBmsKq85BzH+ULGwys7KX9UMs/oBxcWgJVrBFCQgPj0mEfTmRWFsJaz5Y9RC72b/8t/T3F7MS3iNYgH5YZqAJmbm8uP70A1VQBu+BwaZp0eLZ62mZ80MjVfDa6UCfM5OABLhuoiJ+xZ6iEBYoa5ddCrpYBPm95g8jgCQpA5VCBiWZLXE/3MKjso4Eu89i7O3W/EuGE3A4ek9egKVE2ukFrs8tmI9gjAE1+ns4jN61Gsms2+5lp542YE8Yp14R6CGUmeM2bVnbfb4i4Uocmffu4rePLjQa11+NfdKEd2ZK3apE1W542kgpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptdj9NpRDTE1Jdjyv9AgOzOvidnvjV1MSr75mHV7AxY=;
 b=roRIHifcoIqljA/E2lBa8RZrGHQDUYtt/LbP0IEK+0kgZ54lUmLt8b9pxT8PbXfUMPYsXE/dFeOzca0rVcCK957Ay2LoxMdAFHH03CaLwdOoGRSHLMuirBr+hggBsisJOGZRd2Xq5zIRtMD4ZZT4pRSgsPSfmLJpOhSLgjgCmjRAs2/XFlb7yGYpoL3o0kyDcFC/6L6k2BueoeFKQCsZZeE2tzGWRws3IOpRgfz0m3NDIaJKpTlJOXlum1CIQAnHBKdRigTmBZ/61WKdDCzIxcNitPAOEh5udHvtmQNSZfxudRh/9viTNU+Pg0Lb3hB2sRCmA2cDLfSijSXZxnQ/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptdj9NpRDTE1Jdjyv9AgOzOvidnvjV1MSr75mHV7AxY=;
 b=Q4HzAyyIxV8Ta3ScQYPR9jUc2b6QuwlX/r+SxbtgyvOpsHIM/x5996uFFxd4H6dOE8OHBJ/EPvS3ytFYg8TpPvmIuFrlMbJECGrgF3SJZapPEcoTguVRickRyCE/fNiyJrJFUK0keUn9LZeNOGixYK1nJgdzdyAKGMMdNlEr7e5R3tQomS6ZYzJPFnYd7n/VUy0h9PiwX6tu7PSBW1TwNXT5Kv4DV2UaEjCgKeDPG0fAjsiVPwJWqcVhOWMaeIuHWAlJfdsww6bAgoY0R2IlkKVnn8SgxkZIjP1QqN69Is9rlyElWcm4bGVtm6WM9jtqb90/WPaytdCGdeawb/4M2g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 18/19] intel_iommu: Return page walk level even when the
 translation fails
Thread-Topic: [PATCH v4 18/19] intel_iommu: Return page walk level even when
 the translation fails
Thread-Index: AQHbiQYF47bBqYuATkaQbMxdaWNCbA==
Date: Thu, 27 Feb 2025 10:54:49 +0000
Message-ID: <20250227105339.388598-19-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: 2008729d-66ec-4a70-2a61-08dd571d2865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aG4bfca6LoxC0nVk0qn8KCByAYAK2d82mJUxEOQHBymVwD5bEp3g3mDjdv?=
 =?iso-8859-1?Q?SaOtWG37JcORyl2nhgID0jYO4SWAUHnV/hD8hn6VvMtii+7hC0Om9DiqEB?=
 =?iso-8859-1?Q?thru+KEkPh2p24jvceCzyEBam7dKkIkWsGusjvhEvWVvxj3zowTqNh5/+u?=
 =?iso-8859-1?Q?Y3xgOyPoJUJ8dfPnqp/pLKuWRyeMvXKGTk6+IpFHphau4CEMTZeXaqseon?=
 =?iso-8859-1?Q?1p4GdBdj0tNfZ5EevwQS4t7gEJ5/DGBpFD0luAYjxWt/SMrPAivrLugtZ9?=
 =?iso-8859-1?Q?uSiWoDJZ6kfS16GqkAv3p8xCmeP+7ASnCFa8lCiHvRAltjRB4AwGZLSTo7?=
 =?iso-8859-1?Q?07wyBP1kywO7J7kWo4w/bn1o1d3GHo/v+ngy+yQIPR+2/DEstcLIMfE/+t?=
 =?iso-8859-1?Q?mgdJT0e6mynjftAUp5xOFybDj/OWdJ/etpK+8kZ1ZSl+9Z7ulWaVOMLiWt?=
 =?iso-8859-1?Q?3s/bF6AdaxPVwyYPfD7LwAi9OMzdcdkmAhZEjIGz79JP33gHvAlnHx9m/n?=
 =?iso-8859-1?Q?OvJ3Lb42VNZuWUmkrLoTNQYPOIRZVFYB4mlKFaUCKQcMrjhPUCzOhjDUUd?=
 =?iso-8859-1?Q?K2klwiScKbOmGmFDRqsuK/yFxteEkMSfcSnffa5ggTFH7J0aMqgo5ei2oG?=
 =?iso-8859-1?Q?VqcJv2O9TycI8q66xUkHOUye67/X1uCIT8oFouIPPSPOUjPjUeujrlquMw?=
 =?iso-8859-1?Q?hDtDip4XZAQDp0pU8AFRKK1MpiaQQHz9ZtNEF8BrsFYOh64lTL/rQ5GIUl?=
 =?iso-8859-1?Q?z/IQJYGnmw7LXwiskRTltDvvoyzsiHRQSOBuJYpzBm7F2+C94gf4zr9hpZ?=
 =?iso-8859-1?Q?vNIprxFr73AAzdS6FgVn4sCyOj0kJU8wkJl4p7NQ14Id0ExKL76+Cs5hht?=
 =?iso-8859-1?Q?bYxPG0O473Oq792cjTZwncxWh0TYWVpOCUjMmf4Dm4TNx67V8FK85m7bUw?=
 =?iso-8859-1?Q?R5NgDFRtk3gGN7x+nSIeBZ4RVAiYV9fgG43+kS3rAtC5zDR/WAzMzH+qLR?=
 =?iso-8859-1?Q?lAXpX4aKii20tmGvsEvNOIQ5wrJqBnsIMZ//z/To3swIV4b0NZ3KUnzLCP?=
 =?iso-8859-1?Q?vKDP/Xk3nQBq89pFpDcZuXk658VuDktry3A8bq4k/7NHk8abQf4ShJlJxH?=
 =?iso-8859-1?Q?a/fRFbwLSq05+/VQPR6d/+Y7l7cuiKv4LEDsjRofhicl6YomA+rvBqKGcE?=
 =?iso-8859-1?Q?cXoMvEPD0GGFQIq0V6aGWXiRPjZZ/wbvingT3Om8O4G0Y+fyPksVKaaei4?=
 =?iso-8859-1?Q?4BM8TxztmjDXPQjdTw8sbZLav8OOyK70KwzEmeuCqhJPTztz9BzVZz1axq?=
 =?iso-8859-1?Q?5PhthOdPP6eikgS94rEpMihl93zELQYgmbKG+Bs3mBJKsDa5gFjxKm4bO+?=
 =?iso-8859-1?Q?jVo9/IrK6TvoHtJc3kbZ32YJZgcrDd4dRcSIP/Wh9A0FMFwx/aqP7tJomi?=
 =?iso-8859-1?Q?GiqqroOcGT+Bu1NK88GtStFTcoPWV9oYs40A8K0L3VR1TeUKiUE+K+53P8?=
 =?iso-8859-1?Q?udWwbaVgtyQXqBHFOCLgT2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5Pgz7DZ/lYYj1pf0Vxm2gsQguVB4OJwhuEECduYgQ9rZAVAefiEridOrRX?=
 =?iso-8859-1?Q?qbA/wOPHV9oSvzOi+Co+iDb9GTnLRaRIpV4U+aa++IqUp2EHs/em4HK5Aa?=
 =?iso-8859-1?Q?wBSuc6+LrjJWq3OKc50Zt6bbMqNcnvNtjo84m2E2ORcSPYzsbd3ZZKQ404?=
 =?iso-8859-1?Q?2KHQ8BFQOzbrx8wKqv5Dz9p6W3bXfmxg7qc1waHyNcOTM+K8NVmDNq1sDY?=
 =?iso-8859-1?Q?AspcSF8DH687nQgDuDcF/m5ZFF+esEArKSkZ6WKUxz1pNisUfOjOsDNQ3F?=
 =?iso-8859-1?Q?zwHbxi/NBPJY7+Ln7Gf3JlZng67JSe+LkdVTKIp+vT71cG2UMt+BfWFQcx?=
 =?iso-8859-1?Q?AQiHawoZcd+4S6Gc6+M+iM6ZUVGecwV9JeTXuKU4Gddsy81TBSOW07zvJ3?=
 =?iso-8859-1?Q?HzyE8N4PUrrSzbQAAA84dA5HlSSwBMqiyKoVfjFgLiUdRdEl/m2HI8AECB?=
 =?iso-8859-1?Q?sGPr36jOteL35jMrboQdUYUmJpjY3PZ8wm/a/As/Ehhr+QWUpF78v+9iUt?=
 =?iso-8859-1?Q?W92fb8y7knSmnP98134kfo08ksWU3vYpZHgeB0s61JqePPH9Qzp3tJW6jD?=
 =?iso-8859-1?Q?PCAppeJXgm42MnDxbs0lR0BgeXdApaIATrAXt3ZlnNG57RPKT9qmvvs+L8?=
 =?iso-8859-1?Q?f0RJjzlyfRojt72uF+2HmN+xJI7qs2fCK2PGwWOixVgXWGecMM18TzblJU?=
 =?iso-8859-1?Q?Utg+nFhD8R37HXG9DJjjECt+3rBJquqaW4U8sS0WdqWM4zF/8HoLDvpxYU?=
 =?iso-8859-1?Q?vEhiZW6Kkzv9Q3ZTZE7yxCDeLy1q5GXjnFQa3iyma2FJcxMx1YdizWXwGF?=
 =?iso-8859-1?Q?yOEG0TfBK/D44ciDXthIKl4trzUmy0Cjs9cjWasWf2A8Pr5CCRlg9O9V6a?=
 =?iso-8859-1?Q?iegFLNB4oMxZSEOQOpyH4fsfdkMicLY8kHGRlbl3opSf3DHVG4H3lRq3DV?=
 =?iso-8859-1?Q?0N3d6ys5RtbsEWXi9G0xqSoZs9BUVt3FK94LJATgutoI4pk/TQ4iatQqBK?=
 =?iso-8859-1?Q?povrp83aBquiCMJQ/bN97KRu8jcW5FWAlnyZY9pOdFcWZKLPkL1VA3U7Y9?=
 =?iso-8859-1?Q?9Dh9naHSFgTm8qrPNfzOsvpOYg0SYrjm19AYIxdfDEgiPo1mYNSosdSvJT?=
 =?iso-8859-1?Q?J0FrEMYilz+a7FI7In22fI2jFwz3F+jGAblm4Sh3SjTJrFpQgbueDTg9GP?=
 =?iso-8859-1?Q?jKGbOqnYZOOxPePUlsn+zj8bHF34wVhgvOvWrXU4Lq+trrIY/wtGwa8Zrc?=
 =?iso-8859-1?Q?0BORlKOc8MaCAr4uKgI6DBtJafhk62fRmiJuAhKJk7qtidy1sm7fqmKyp7?=
 =?iso-8859-1?Q?jFDsmV8spMqr/SGYgPIb9s5LH06OaifN3/e2+KmDF+PJ91is+OzESZ6gGe?=
 =?iso-8859-1?Q?NpA4B3wYTiBfuRLT7qJhSC9rqm/hXHPNneu1F8ZbSMjDqS4l9b0HEZ7ztq?=
 =?iso-8859-1?Q?wOShvRJVCkX03gylBFGAn54RtF/6GeEPwQGkj64YmnvU5HA6Iejn8QOyv7?=
 =?iso-8859-1?Q?ATI/0UnJ4yuSVnQGLraVjtjHe2VElt4oFafCLSwdbGpbtXWhTMdufU1K7a?=
 =?iso-8859-1?Q?Zlk2F9ibsXibslbSJGbsC2OoH29e+Cl5ombteWfaeODJ+OAksFd1piKRte?=
 =?iso-8859-1?Q?k4phWFfMkMxFlkUUIVKOcT1+NBAYIyj6lfdzK78h6UuezlM8YB0JoPR6xD?=
 =?iso-8859-1?Q?Zn9Wzo4A6KfATjp7daU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2008729d-66ec-4a70-2a61-08dd571d2865
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:49.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNQmyzqLf28F7Wf+jiul625AIzpOUAZ2K66SQBdDUTrcUimOPsSI6H6iaTr8nzAfYXJWM2+xxA1X+p4fgyqrQqtV/sAKl30wzNypAFSb/5GzEb1+jPYZu9a7crA89zZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

We use this information in vtd_do_iommu_translate to populate the
IOMMUTLBEntry and indicate the correct page mask. This prevents ATS
devices from sending many useless translation requests when a megapage
or gigapage iova is not mapped to a physical address.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b9b5d492f5..9daf8025cc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1995,9 +1995,9 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
                              uint32_t pasid)
 {
     dma_addr_t addr =3D vtd_get_iova_pgtbl_base(s, ce, pasid);
-    uint32_t level =3D vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
     uint64_t flpte, flag_ad =3D VTD_FL_A;
+    *flpte_level =3D vtd_get_iova_level(s, ce, pasid);
=20
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=3D0x%" PR=
Ix64 ","
@@ -2006,11 +2006,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
     }
=20
     while (true) {
-        offset =3D vtd_iova_level_offset(iova, level);
+        offset =3D vtd_iova_level_offset(iova, *flpte_level);
         flpte =3D vtd_get_pte(addr, offset);
=20
         if (flpte =3D=3D (uint64_t)-1) {
-            if (level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
+            if (*flpte_level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
                 /* Invalid programming of pasid-entry */
                 return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
             } else {
@@ -2036,15 +2036,15 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
         if (is_write && !(flpte & VTD_FL_RW)) {
             return -VTD_FR_SM_WRITE;
         }
-        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
             error_report_once("%s: detected flpte reserved non-zero "
                               "iova=3D0x%" PRIx64 ", level=3D0x%" PRIx32
                               "flpte=3D0x%" PRIx64 ", pasid=3D0x%" PRIX32 =
")",
-                              __func__, iova, level, flpte, pasid);
+                              __func__, iova, *flpte_level, flpte, pasid);
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
=20
-        if (vtd_is_last_pte(flpte, level) && is_write) {
+        if (vtd_is_last_pte(flpte, *flpte_level) && is_write) {
             flag_ad |=3D VTD_FL_D;
         }
=20
@@ -2052,14 +2052,13 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
-        if (vtd_is_last_pte(flpte, level)) {
+        if (vtd_is_last_pte(flpte, *flpte_level)) {
             *flptep =3D flpte;
-            *flpte_level =3D level;
             return 0;
         }
=20
         addr =3D vtd_get_pte_addr(flpte, aw_bits);
-        level--;
+        (*flpte_level)--;
     }
 }
=20
--=20
2.48.1

