Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=XsYk8U/4;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=y7DEPgUd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJirl-0006VH-1k; Wed, 21 Oct 2026 22:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJirj-0006UX-Jj; Wed, 21 Oct 2026 22:49:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJirh-0005O9-KB; Wed, 21 Oct 2026 22:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792637359; x=1824173359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dFS5qmzWHXQUMN29XqehaNZOHnvff2gpNmD+pBYs5tI=;
 b=XsYk8U/42jDQ8uyZxtgZTysyCzLh5ozGABMPuZBb8IE1wjtGgQR96Ud+
 Dp9+MI5Lx2L0vkdA0rDjzhVKi6ugxQOQ2CZaJMjYRp/1EzjyIGG5FDHWS
 SX1b4vT392yrHTpRK6Ymm4JKKdOhltwE5YghqUblmJhNGFYRVngKilJuV
 JS3P0mJbjHDrZtZqtMiP65FweyoLCJzGS2RoFqYbpP+uhynAY6pKGhUVM
 WlzGz+pFzwxCzT57DeoqRBE5R949yOuFYy1G6S/ZJ+XQRbX1gGF0LeNjK
 raUG64BuG3hGJidGJOAib2854xKnxSdH+aU/pYaI6yKLSRsJ3ukKxj4sU w==;
X-CSE-ConnectionGUID: cEwVc9MCTYGCafaEMDavAg==
X-CSE-MsgGUID: sXXCZ8qVSdaSdFdJ9N3JPQ==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="159655659"
Received: from mail-eastus2azon11010071.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:49:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8PcydYkE+Qe3FuaMdtQSYdgA7MEYjjqg2vZrin3QoP8Yt0YQGDmHXACIRjxaZd0YCWI5xueK/S3Nq0yYuwzvVDR8xIlhpLFDA9FGcRfBXHDs5JuHPXk2051r2BwxL9QP9XBds5JynW6iRyKR/cgPx9OFrq6LmlBujAilEvgpgUQa2nO8c5OrmpcNpVlrDjXm1wmdxEvvekg5L1FpEsFgByhOiNPVg9UAmY79rNnwhEHTG5UD7u8WGt+xsS0iEC+y5L0NjRNY+jYUmc/EeUjK4vg5JqzVdw+vkY/1qUd7Np4LOkUvEQX5iA1HUqC065vtAdUrgNDO7zKFIuxS8QxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFS5qmzWHXQUMN29XqehaNZOHnvff2gpNmD+pBYs5tI=;
 b=dENZnle3i8wx73K1pZWnxSSB82PUdqnu68EwVWr6rXNkB9JABPk8WSe9fvop2SfhTfq4b3u28cvaeG6i/tJ3ykk84Q95UUG90f/5hWMn2aIILEdCQvShf/RkH0UNWJifPWgtOI0PJAZ4g/jvCWj73tk8Yi4QmDkq49z0u1P5rNSzT/A3Yl4nRgTtUWH+xjM5Wgzl3KDDg5U07vKIsxt7ZhwocElBSi/J0W1E1cSzn7wIEBfpTJFTqDlX+icYjcsgfJOhwDTmXWgZF18URVkQNGYIoUQ1Ozrxxbvmp95R2GHo37oJtLcFvOFo+G+hR0jfK843S3P42WULBuGc2gALXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFS5qmzWHXQUMN29XqehaNZOHnvff2gpNmD+pBYs5tI=;
 b=y7DEPgUdwX66+JQ6buEL8AMk36JBxsrbtwD/4wMJvt3yCFftZ6//7XscxpsmEMoJt4L8rxCZso7ZX5VMhZ82rFgX19r+Byn3tteXAnrN3DeZ85jSBF+GfAQInuu5mCI4J60srQPOEVPdvT1ODY5jQBdfCC+SOrtilk6OXD3C4Oo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CHBPR04MB007031.namprd04.prod.outlook.com (2603:10b6:610:406::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:49:09 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:49:09 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rick@sloservers.com"
 <rick@sloservers.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
Thread-Topic: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
Thread-Index: AQHdUnSo+fwfToMizkip1Cgd4ZK4rLb7bzmAgAAVWICAAC6DgIANR9MA
Date: Thu, 22 Oct 2026 02:49:08 +0000
Message-ID: <8d80497127c968b7727eb2551ae8d3ca8588cba6.camel@wdc.com>
References: <mhng-29CE4AFA-6FA7-4BFC-8C6F-F6719A684302@Palmers-Mini.rwc.dabbelt.com>
 <f2600f08-73a0-4259-9175-7f644997c366@oss.qualcomm.com>
In-Reply-To: <f2600f08-73a0-4259-9175-7f644997c366@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CHBPR04MB007031:EE_
x-ms-office365-filtering-correlation-id: ac8b8acc-17f3-449b-b39e-08df2fe70bba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|10070799003|1800799024|261021123027099003|4143699003|56012099006|11063799006|261009223027099003|38070700021|10067099003|18002099003|22082099003|6133799003|261021121427099003|3023799007;
x-microsoft-antispam-message-info: pUlID2cNUIbyAmhQ+rAaZau8k58iP+t82TdKWZzd26jRF1sd4/ZHcMMwWIUbg58jwYGaK6GOPlyz3Py91rrLDOaVVazLoWf9X3kPwB+Qb/5Ggd91VatNPkji1uXQL9GdG0XFGbMO7bdurqYHNnabwZCf4wchxcPvorucJ5wySz6ZwU5tfppnOCSy6C7Umk5aSy3p5rV8u46lO2YUVvM0suNjtorb/18dgPViCdNjOvVf3IKN5OT6klC0xFdG8fd9Y7Xzat9QD7/f5oJljSY7aLiNzh8J4/XyE8tH+BBmXhkpojGb5vgjwIeZjWLTbb08lyBlT3sv3YzVjJzQxVnHY6D5CRjpHtPF0QrWQvZIfIkSOfee242YwjQBoILciC5vBzW5FZtg1AoirEDx4WeM7JEOvU77CyVQgMnyh/IZT7f8A2Q71ZBQ+tiheki7hOTQcE5z1IaRb3J+7LmWDboEF04Onul8OW3231w+0zQCZCXHrariDrccyQKtoP4/4Pyt/nW1DDZHsvW8myVOl6ucTYOGIik5eHNxvmbJzo7oEJRPHm6bOrClUawbQ1XE7oHfS6mhhGDv/72uwmeJuLKL1qyXBzoFhd5syRXsuAmR+CCbOp3foP+4G0ijcNuAEhOLIwL1cskB4BYjY4csvjr4KwXyM5tafne7JyzBOYhdVHs30UhxTueTqNILj4Powfwg0s+qbE302iivj3KJpI5xWiP7wHaM228QQfP5wAA4++E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(10070799003)(1800799024)(261021123027099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(38070700021)(10067099003)(18002099003)(22082099003)(6133799003)(261021121427099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3EyRTBsZjFIRUlSTFlVSDVzdlpEdzRNUE1aSjNwQUlqUUhsdkRPd1cvSVFk?=
 =?utf-8?B?bE9LcjVzNWQ1UXl6YUZidGQxdHE0blAwTXEzQ0tiVExWZGxoWkVVUDZHYWl2?=
 =?utf-8?B?RnZGaExKM0YyUkpkbXVkcHY5TlVhd1hzM0VOMExFUHdVUHQveit3NDNOMHVN?=
 =?utf-8?B?U21kYmZGS2xvcThHajhKNmpyQ2YyMDhSMnhzTTdOcWVGYWV5M2JRQzE2S0Z3?=
 =?utf-8?B?b0UxTDcySUZ3MWFDN0JTUmlGaGxsN2ZNMENWeU5PNWtZb1JxOWlzZkZXVHE1?=
 =?utf-8?B?OFM0NFpWZ0lyWTFaSWxXaWtsVWZkczhLbndZZ1B5NWkrc096OG1tbWp2OS9R?=
 =?utf-8?B?RVJuMWM1LzQ0NVcvS1hnK1J0d09RTDF4eWt1NG9oc0hTVkt6bXpiMHNFdHJj?=
 =?utf-8?B?UHE2a0dlNFpOdWd1RFl1WC83Y0tneXV6WFdrdHNLWXgyQzFybEVZYW5iVDls?=
 =?utf-8?B?RUtqMVFtNkk0cWlBT2VKWEVkRzRDRHY5SkJYMW9RTm5OQTYwK09XZkt0RU0w?=
 =?utf-8?B?WXFqa0pKcWNmbFhOMmJYK2poMWE5L285MndwTzRuWTU2L0JaUWpHd3lKc0k1?=
 =?utf-8?B?ZjY1M2NjNG9SMERVczM4dTdXUE1POWFEUmRZL3BRQ1ZadjAvV0o2M012QW9I?=
 =?utf-8?B?UjZ4Q2MreTM4d0p2SVhTTHZNdkV3U05wbUV6MTE1S2RHbXdhU3dmQzJXWkZx?=
 =?utf-8?B?MVVCbG5CQUVNMkg0aUdUdHFqQnlER1FIcWtxQWZjUS8xQmExUmtja0N1dWVL?=
 =?utf-8?B?V3VjbkVBenBMS0R0SXlwRHRodWhsL1JjNytBV2xWNHpGbjNJa3ZZZ0hjNmps?=
 =?utf-8?B?aXRmOGVib243UVlIVXk0dndwaUVZdmxLRTFDM0xNZHRzZTYwekpKZVJDZTFP?=
 =?utf-8?B?TUZCYTNzZThaTDRVUXVsVysrNFNtYkk2aVRKckllYjM1U1lINVVHYloxSmdt?=
 =?utf-8?B?RTNFVTNWT1hEV0FKdUVBQmlCWXlOQjZWZVdacDRCNmZDbWhhRkEvNTkwYVF0?=
 =?utf-8?B?blNxak00TWNPQzRUU25GNzNpd25QMEU0eFB1QzFOZW5iZU1pY1lXQ0RvV1BU?=
 =?utf-8?B?eU9wa053QklrcEp5NkxORklBZzY2NFBNdlYzTGpQNzU1aTEzU28xQWZSeTlo?=
 =?utf-8?B?K1BUUGUvOEFFd1lEWFB4bTlCeUtPYnJDOHVLR3NncVo3a3hCKzdNMTFCZDQ2?=
 =?utf-8?B?eHZoejdHY3lGbUQwY3IweUVlK3ZFaWpCb0F3cFJkZ2ZUWW1aWWpDR0tBdjJl?=
 =?utf-8?B?WFJZMzNMV1JXUENrS3BrZ3MzSjdtVjNrSVRGakxWNldyZ0QrK2ZrblovbHla?=
 =?utf-8?B?M3p1RlJMUS82NVhSRHdZc3BkKzlsanBNbmNXZVdic1YvNVZQUGNkSE1FTXgy?=
 =?utf-8?B?VUExZTdtOS83NVlQbExFbWdwdkJVT0dQNyt5ZzdkakVibDc0aWVQOTk2L2lt?=
 =?utf-8?B?Wmd3UXhzUFAzSng4NWRSMDdURDVjRXE3d2c5bWpkUXJCNjVEallocnh2QkxR?=
 =?utf-8?B?djJleVY5Z1kvWlJyL2JrOTRMSVBobkVSR04rVUxSSkJZQUZudm16N0tPSHE2?=
 =?utf-8?B?M2ZTdVd2SnN1ZkxEaHFneTUxdHhrN2FvallKNUZYaDNRWG9RWjZiRU15MFl6?=
 =?utf-8?B?aHRpcENFUnlUN2d5Y3FKZGFvdVhVM2F2bzlMMlh0aXlZTmZBZ0wrOWFqS0F4?=
 =?utf-8?B?RFJwaUZGdjZVemNibnBSWGZrdlJpSFlZTnd2TTUvVy9LcVdFbW1LejRmUFNJ?=
 =?utf-8?B?Z1lDZTJ3V0s4RE1vODI3cTZXMGVYRU1YeUlkM2p6clcyY2ZReUtIQ3NMZXR6?=
 =?utf-8?B?ZVJVM3hSVHpEVUhuOFp0Wm1EaGdPcUE0T1BrM1AwL1NxK0Q4TFBYTTBxeG1F?=
 =?utf-8?B?QlVzaE1iS2dPWFFHdVZMMUwrd2djaEx2SkJoT2RLZWFPSHV2K3djSWhnakpX?=
 =?utf-8?B?ejRpeVF0VU8zTzVuNG14eDRmQnN3V243bXhDUGNQMzVnSnB2RXF5V3pHZWtI?=
 =?utf-8?B?N0R5djJRT21nQXlTRDdDdUdBKzJpK2dLZGwzbGlFbnVFWVdkYldjZVNibEtx?=
 =?utf-8?B?bzBQQXFiL3dxQ0ZJbVpzczZyeHZRWnptSkRRS0t1ZVczQVoyb1EyVXVkaldk?=
 =?utf-8?B?NzZpWjNHQUNWbE5ydnJaczBFRGM5MUZCRllyL3N2bXVaU2x2RGgzVnlCVUdo?=
 =?utf-8?B?bVhHaDYvd01CZ0tjSWhzaGkveVFEeHJ3aWVKUHMrQW9nWjJCTTRvSURiUFIv?=
 =?utf-8?B?S2VxTy80MUpKNk04ejFxR29lR2toK0Z0T05BWS9LTVlUZkI5aWlqOUMrMjFV?=
 =?utf-8?B?VUZCTWV3ck1xbVp5NUJEQ210M0ZJOEU4akZDOHFrM3JDUUtkM0hVdnBMMnhU?=
 =?utf-8?Q?mAir/WXUBq1szfXLBuGIFC65w8RVaPtjkJYCVo9Fz2FtA?=
x-ms-exchange-antispam-messagedata-1: 1TE/74VcV1rSbAizuNICCjC2oUidwUGSz2s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E6DB4B61D88CC4FBE8344D92910AEED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D0tSC35rOti9L5QXqDrjN449Tbxu1Ag3iRKb2ZDpr/fINzG9sYSES2izWbUglaY71oz16dl0DSUAXFtDHeKx6sK/DmbpxnNW/Gfl0+sCw0snAW8NKD8o1GKILXk3b3EQM29xT3pGP+Ew1ha4R0q24c4FTXn+lqZDhieRGg/Cn6ognYB0xgVrIBbSj21/sm3ikgzbWS4Xyk84DpXVrda1juPj78a9W9U06c/0raJE22ZgimTWZ9sMnJPoardVkeSdKosjv0EAknglztFJoHJOuqha6FwZVsMB78/kB+0Ulz0/VVvw6TAevwvlMMBTl9fG7HVeo2uYATTZnss4nHwkDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zoszvnED0572onE812NZei+6Q1CcYHIKX/GqsnbBLb6CRTvsL6NwyHG7HHZaIJbAlUnP49AfKFW3lrTcusGHUU7rpH8y6bnT4f8cQhMkr5tbID0D8bqJ+x54NvHQ4vVh9PJwDVnfOcEvqeBfogp8YR9XXM31nvC10MIQC1r8E4p2tRgKbmEp0fZmbkJOJMwDf1PZtgSL/NkFTuU+CVSlT5Je7O+1xyl5JwSWbQ3ueY9y6tWOOEGN4v8nTSjSNfZypjz4R5HSg8R+Fyw23RJmfiIdTYDFIeeggzTYIcvpAoomJCYFJ/tk6YBhSoHKpjO+mKN3Gv7e0OV8YkmWJDOrlEdwE5ZICUrC55gTeC+em0O60/EnOhG2RlWWcdAexDV4C/ReoED+RjjtnXr8ZU9P220VNQ4dxUd/g2mV5jd2lCGzIguI1BdYf1VlTSjHCpYgX2+Ac7ufaX/CY7CR0MhgWwQsZbVsOih88hHt0e37/2+SM/W54DehX6p+Ahnn67R5PiR1n3ud5qsVvbyagSeTSbMpMzmycL0cp6OZhJmsOzzZoo/Xt+guxjxNUnn5dOMXcUTSf1P4BsF85HwLtVLwe78c+WXhBp9cMMwqCJAyWJY492OhyziImm7oug0O38DM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8b8acc-17f3-449b-b39e-08df2fe70bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:49:09.0170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaPgBMoGoL7RffHZd+6mkqoA70GR9dM/svXsSfRKWUWV+i4hBR/xQDUzbwe49cK6GMHIv+9D+pS0WywexR6qBBnJapCBOm3bGqViz9qKbww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR04MB007031
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTEwLTEzIGF0IDEzOjAwIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gDQo+IA0KPiBPbiAxMC8xMy8yMDI2IDEwOjE0IEFNLCBQYWxtZXIgRGFiYmVs
dCB3cm90ZToNCj4gPiBPbiBUdWUsIDEzIE9jdCAyMDI2IDA0OjU3OjQ5IFBEVCAoLTA3MDApLA0K
PiA+IGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb23CoHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiANCj4gPiA+IE9uIDEwLzIvMjAyNiAxMDo0NyBBTSwgUmljayBSaWNoYXJkIHdyb3RlOg0KPiA+
ID4gPiBXaXRoIFp0c28sIHBsYWluIGxvYWRzIGFuZCBzdG9yZXMgZm9sbG93IFJWVFNPLCBidXQg
dGhlDQo+ID4gPiA+IGJhcnJpZXJzDQo+ID4gPiA+IGFyb3VuZCB0aGVtIHVzZSBUQ0dfTU9fQUxM
LsKgIFRoYXQgYWxzbyBvcmRlcnMgYSBzdG9yZSBiZWZvcmUgYQ0KPiA+ID4gPiBsYXRlcg0KPiA+
ID4gPiBsb2FkLCB3aGljaCBUU08gZG9lc24ndCByZXF1aXJlLCBhbmQgaXMgZXhwZW5zaXZlOiBv
biB4ODYgaG9zdHMNCj4gPiA+ID4gaXQNCj4gPiA+ID4gYWRkcyBhIGxvY2tlZCBpbnN0cnVjdGlv
biBhcm91bmQgZXZlcnkgbG9hZCBhbmQgc3RvcmUgaW4gYQ0KPiA+ID4gPiBtdWx0aS10aHJlYWRl
ZCBndWVzdC4NCj4gPiANCj4gPiBUaGFua3MuwqAgSSdtIG5vdCBxdWl0ZSBzdXJlIHdoeSBJIGhh
ZCBUQ0dfTU9fQUxMIGluIHRoZXJlLCBJIHRoaW5rDQo+ID4gbWF5YmUgSSBqdXN0IG1pc3JlYWQg
dGhlIFRDR19NT18qIHZzIFRDR19CQVJfKiBibHVyYj8NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTog
UGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gPiANCj4gPiA+ID4gVGhlIGJh
cnJpZXIgYWZ0ZXIgYSBsb2FkIG5vdyBvbmx5IGtlZXBzIGxhdGVyIGxvYWRzIGFuZCBzdG9yZXMN
Cj4gPiA+ID4gYmVoaW5kIGl0LCBhbmQgdGhlIGJhcnJpZXIgYmVmb3JlIGEgc3RvcmUgb25seSBr
ZWVwcyBlYXJsaWVyDQo+ID4gPiA+IGxvYWRzDQo+ID4gPiA+IGFuZCBzdG9yZXMgYWhlYWQgb2Yg
aXQuwqAgVGhhdCBpcyBhbGwgVFNPIG5lZWRzLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gRml4
ZXM6IDA5YzRlODg3NTkgKCJSSVNDLVY6IEFkZCBzdXBwb3J0IGZvciBadHNvIikNCj4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIFJpY2hhcmQgPHJpY2tAc2xvc2VydmVycy5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVl
IEJhcmJvemENCj4gPiA+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiA+ID4g
DQo+ID4gPiA+IEkgZm91bmQgdGhpcyB3aGlsZSBsb29raW5nIGludG8gd2h5IHJpc2N2NjQgZ3Vl
c3RzIHdlcmUgc28gbXVjaA0KPiA+ID4gPiBzbG93ZXIgdGhhbiBhYXJjaDY0IG9uZXMgdW5kZXIg
YnNkLXVzZXIgb24gRnJlZUJTRC7CoCBUaGUNCj4gPiA+ID4gZGVmYXVsdCAtY3B1DQo+ID4gPiA+
IG1heCBlbmFibGVzIFp0c28sIGFuZCB0dXJuaW5nIGl0IG9mZiB3aXRoIHp0c289ZmFsc2UgYWNj
b3VudGVkDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBtb3N0IG9mIHRoZSBkaWZmZXJlbmNlLg0KPiA+
IA0KPiA+IE1heWJlIHdlIHNob3VsZG4ndCBkZWZhdWx0IHRvIFp0c28sIG9yIGF0IGxlYXN0IG5v
dCBkZWZhdWx0IHRvIFp0c28NCj4gPiBvbiBob3N0IHN5c3RlbXMgdGhhdCB0aGVtc2VsdmVzIGFy
ZW4ndCBUU08/DQo+IA0KPiBJIHZvdGUgdG8gZGlzYWJsZSBpdCBpbiB0aGUgJ21heCcgQ1BVLsKg
IENoYW5naW5nIHRoZSBtZW0gbW9kZWwgZnJvbQ0KPiBSVldNTyB0bw0KPiBSVlRTTyBzZWVtcyBs
aWtlIGEgZGVjaXNpb24gdXNlcnMgaGF2ZSB0byBtYWtlIGluIHRoZSBjb21tYW5kIGxpbmUsDQo+
IG5vdA0KPiBzb21ldGhpbmcgd2UgZGVjaWRlZCB0byBkbyBiZWNhdXNlIHRoaXMgcGFydGljdWxh
ciBDUFUgbW9kZWwgbXVzdA0KPiBoYXZlIGFsbA0KPiBwb3NzaWJsZSBleHRlbnNpb25zIGVuYWJs
ZWQuDQoNCkFncmVlZA0KDQo+IA0KPiBJbiB0aGVvcnkgd2UgY291bGQgZW5hYmxlIGl0IGRlcGVu
ZGluZyBvbiB0aGUgaG9zdCBhZmZpbml0eSB3aXRoIFRTTywNCj4gYnV0IEknZA0KPiByYXRoZXIg
bm90IGNyZWF0ZSBhIHByZWNlZGVudCB3aGVyZSBhIFRDRyBDUFUgbW9kZWwgZGVsaXZlcnMNCj4g
ZGlmZmVyZW50DQo+IGV4dGVuc2lvbnMgYmFzZWQgb24gaG9zdCBjYXBhYmlsaXRpZXMuwqAgV2Ug
aGF2ZSBlbm91Z2ggb2YgdGhhdCBpbiB0aGUNCj4gS1ZNDQo+IGRyaXZlci4NCg0KTm8sIGxldCdz
IG5vdCBkbyB0aGF0DQoNCkFsaXN0YWlyDQoNCj4gDQo+IA0KPiBUaGFua3MsDQo+IERhbmllbA0K
PiANCj4gPiANCj4gPiA+ID4gT24gYW4geDg2LTY0IGhvc3QgdGhlIHBhdGNoIG1hZGUgeHogYWxt
b3N0IGZvdXIgdGltZXMgZmFzdGVyDQo+ID4gPiA+IGFuZCBjdXQNCj4gPiA+ID4gdGhlIHRpbWUg
b2YgYSBjbGFuZyBjb21waWxlIGJ5IGFib3V0IDMwJSwgdGhlIHNhbWUgYXMgcnVubmluZw0KPiA+
ID4gPiB3aXRoDQo+ID4gPiA+IHp0c289ZmFsc2UuwqAgVGhlIG91dHB1dCBkaWRuJ3QgY2hhbmdl
Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSBhbHNvIHRlc3RlZCBpdCBvbiBhIFJhc3BiZXJyeSBQaSAz
QissIHdoaWNoIGlzIGFybTY0IGFuZA0KPiA+ID4gPiBkb2Vzbid0DQo+ID4gPiA+IGdpdmUgVFNP
IG9yZGVyaW5nIGluIGhhcmR3YXJlLCB0byBtYWtlIHN1cmUgdGhlIHdlYWtlciBiYXJyaWVycw0K
PiA+ID4gPiBzdGlsbA0KPiA+ID4gPiBob2xkIHVwIHRoZXJlLsKgIEV2ZXJ5dGhpbmcgcmFuIGNv
cnJlY3RseSwgYW5kIHh6IHdhcyBhYm91dCAxMiUNCj4gPiA+ID4gZmFzdGVyLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gwqAgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2aS5jLmluYyB8
IDQgKystLQ0KPiA+ID4gPiDCoCB0YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ2
LmMuaW5jIHwgNCArKy0tDQo+ID4gPiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydmkuYy5pbmMNCj4gPiA+ID4gYi90YXJnZXQv
cmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZpLmMuaW5jDQo+ID4gPiA+IGluZGV4IDQwYjRj
OWFhLi5kMzFlNDI5NSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNu
X3RyYW5zL3RyYW5zX3J2aS5jLmluYw0KPiA+ID4gPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2lu
c25fdHJhbnMvdHJhbnNfcnZpLmMuaW5jDQo+ID4gPiA+IEBAIC00MjQsNyArNDI0LDcgQEAgc3Rh
dGljIGJvb2wgZ2VuX2xvYWQoRGlzYXNDb250ZXh0ICpjdHgsDQo+ID4gPiA+IGFyZ19sYiAqYSwg
TWVtT3AgbWVtb3ApDQo+ID4gPiA+IMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiANCj4gPiA+ID4gwqDC
oMKgwqDCoCBpZiAoY3R4LT56dHNvKSB7DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2Vu
X21iKFRDR19NT19BTEwgfCBUQ0dfQkFSX0xEQVEpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAg
dGNnX2dlbl9tYihUQ0dfTU9fTERfTEQgfCBUQ0dfTU9fTERfU1QgfA0KPiA+ID4gPiBUQ0dfQkFS
X0xEQVEpOw0KPiA+ID4gPiDCoMKgwqDCoMKgIH0NCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKg
wqAgcmV0dXJuIG91dDsNCj4gPiA+ID4gQEAgLTQ4NSw3ICs0ODUsNyBAQCBzdGF0aWMgYm9vbCBn
ZW5fc3RvcmVfdGwoRGlzYXNDb250ZXh0ICpjdHgsDQo+ID4gPiA+IGFyZ19zYiAqYSwgTWVtT3Ag
bWVtb3ApDQo+ID4gPiA+IMKgwqDCoMKgwqAgVENHdiBkYXRhID0gZ2V0X2dwcihjdHgsIGEtPnJz
MiwgRVhUX05PTkUpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoCBpZiAoY3R4LT56dHNv
KSB7DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX21iKFRDR19NT19BTEwgfCBUQ0df
QkFSX1NUUkwpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9tYihUQ0dfTU9fTERf
U1QgfCBUQ0dfTU9fU1RfU1QgfA0KPiA+ID4gPiBUQ0dfQkFSX1NUUkwpOw0KPiA+ID4gPiDCoMKg
wqDCoMKgIH0NCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqAgdGNnX2dlbl9xZW11X3N0X3Rs
KGRhdGEsIGFkZHIsIGN0eC0+bWVtX2lkeCwgbWVtb3ApOw0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYw0KPiA+ID4gPiBiL3Rh
cmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCj4gPiA+ID4gaW5kZXgg
YTIyZTJjYWUuLjhjMjFhYjg3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNn
L2luc25fdHJhbnMvdHJhbnNfcnZ2LmMuaW5jDQo+ID4gPiA+ICsrKyBiL3RhcmdldC9yaXNjdi90
Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCj4gPiA+ID4gQEAgLTczMSw3ICs3MzEsNyBA
QCBzdGF0aWMgYm9vbCBsZHN0X3VzX3RyYW5zKHVpbnQzMl90IHZkLA0KPiA+ID4gPiB1aW50MzJf
dCByczEsIHVpbnQzMl90IGRhdGEsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoCAqIGFyb3VuZCB0aGUg
bG9vcC4NCj4gPiA+ID4gwqDCoMKgwqDCoMKgICovDQo+ID4gPiA+IMKgwqDCoMKgwqAgaWYgKGlz
X3N0b3JlICYmIHMtPnp0c28pIHsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fbWIo
VENHX01PX0FMTCB8IFRDR19CQVJfU1RSTCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCB0Y2df
Z2VuX21iKFRDR19NT19MRF9TVCB8IFRDR19NT19TVF9TVCB8DQo+ID4gPiA+IFRDR19CQVJfU1RS
TCk7DQo+ID4gPiA+IMKgwqDCoMKgwqAgfQ0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoCBt
YXJrX3ZzX2RpcnR5KHMpOw0KPiA+ID4gPiBAQCAtNzM5LDcgKzczOSw3IEBAIHN0YXRpYyBib29s
IGxkc3RfdXNfdHJhbnModWludDMyX3QgdmQsDQo+ID4gPiA+IHVpbnQzMl90IHJzMSwgdWludDMy
X3QgZGF0YSwNCj4gPiA+ID4gwqDCoMKgwqDCoCBmbihkZXN0LCBtYXNrLCBiYXNlLCB0Y2dfZW52
LCBkZXNjKTsNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqAgaWYgKCFpc19zdG9yZSAmJiBz
LT56dHNvKSB7DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX21iKFRDR19NT19BTEwg
fCBUQ0dfQkFSX0xEQVEpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9tYihUQ0df
TU9fTERfTEQgfCBUQ0dfTU9fTERfU1QgfA0KPiA+ID4gPiBUQ0dfQkFSX0xEQVEpOw0KPiA+ID4g
PiDCoMKgwqDCoMKgIH0NCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqAgZmluYWxpemVfcnZ2
X2luc3Qocyk7DQo+IA0K

