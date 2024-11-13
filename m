Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A40D41C0A
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 06:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7I9-00058R-85; Wed, 13 Nov 2024 01:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tB7I7-00058J-VI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 01:55:51 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tB7I5-0003RV-Gc
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 01:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1731480949; x=1763016949;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yOVF03eQrPQb5pFddq/NpF87fOcYOUa2+E1P9HXxqgs=;
 b=CSDE7MaORSVK/VOu/wAf/nPweQnSefUGAuVWQlg2DS6Ob1r/WkomY9vA
 dpefMHdb9oHgBZHW4xcLkS0dlNDBDbTY+xwcmfPoVtpmXJz0gCIKjDjgk
 w32/C403Pbr3aiX07OufolzieE94AtfvmzEagGHwEM8qfA8CdOcXEW4P2
 J4xDRPXbNO6pGVmvKpLqYoKvu+JEe8Vv3aYzeS5dfu4fylJk6mSA24GI9
 FXhDpKLgg+L8RpDOIbuo7i68dE52f6guxbYQM229/qbCHB3AHWQ5zxX3a
 G/iG/zKiNeOBbNQI0c/SjCezhdC9QgQ+1Xa+JSltYjayLunhzMrJtbcfw g==;
X-IronPort-AV: E=Sophos;i="6.12,150,1728943200"; d="scan'208";a="24472773"
X-MGA-submission: =?us-ascii?q?MDGpTkzkrOkGzPcPlZoTdhUdKi+jx5ALKj5pKH?=
 =?us-ascii?q?diqNQ7vrobJ0J/G4aeoDVT119Hi3hNjebRAqVh+uo5J+NDdFcrh+GUGa?=
 =?us-ascii?q?b5M7Zyn+bdlTscEzkaV2xvtKEGCoFdG9smAygyiYVGc9IY8mRLw02Hzd?=
 =?us-ascii?q?B1UvePsL4JuOAzdqv6sfjHFA=3D=3D?=
Received: from mail-vi1eur02lp2049.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.49])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 07:55:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikizsTjm0n2Ql67GIwMKV6HmhWpS1wyclrxTh7W4TddGRgA+AFO8r02OodjYLj7RFnqdo4mpuJkrFUmCFyhTHkXJWv0WG5THeE8HnBUAjfD3RlhOwyctda1npXZmFhYZD5hG7hqLdfwlrDquhzoRJqB1+MPXPCK5By9F2KVjV78c2RzgIJsxC2cWcXYGS3YN+jEdQd64E6dOTuVSd9rtxJWtbudkjg+64fqJuUjcJ4j1/aplg1b9eYEaxIyug6HHVqJBSiJ/4g3BivcVuDc8NyCFI9WolKP+FewjBpcDoL50/6RdBquWJ+P4Tj+nBr5DoN660YBlZAv7LAYNpaumVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOVF03eQrPQb5pFddq/NpF87fOcYOUa2+E1P9HXxqgs=;
 b=qlzSjsQXz2ZENhHjJlpKbaizVmwZ8qHbaMTO5VMhHpAAhyYScH+BdF4Dk8LVfFlhHd1IP6TIr+VbVvhBYaKno9XPdCJeEj1bnKwPrrahT6mVUKm3j/f3Y1tT79P282sMNAM2FBGO4U6geY+l+W8CilWg57h53M8jg+bNHOIRqRRCOojx6645U/JTKGq5Mrun1c3XcV0YXYHxjyhalBigA41noe4hMF67f5yJW6uFFyLZCXizbWKhOfDasAFGa7ZEAibxXTcbFvKvy/fakh6lRu7S+/ZpBZ42XPBQLwinUmkbziyWjyoODM+wuws5AUpyKVk5vNajJvNFxAfc3xLo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOVF03eQrPQb5pFddq/NpF87fOcYOUa2+E1P9HXxqgs=;
 b=OAaBy51EYTAu6Jm7IJjLCUzIm7aneZBuXZiM9lYwL0zXrkfaZqZRht5DS4lf7QbOm4pFXFp5UvcGZppZTDl7wrENUhM6orKRyUMWYiIHzLiSK64vjK2YYVsStyQnr7SpeecJNLZ31X38CSoi8H//M4Trin9vJvKziJUmPSpzSw0+6aIU1P5VZxAEv8j518RV2NIoU20ryq5h25xVq9AoikVNKw4y9ldR0b7Mi4nDMPfDuE9OQor3dQRxlBR/e9LXKNXSm+VMXfOweFshisGk73RDBueseon8L1KVbttJxOXr9tKm2bxNdb4FedjWok4seCDMMSuCQJ8WI8W7cTdPqw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6299.eurprd07.prod.outlook.com (2603:10a6:10:131::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 06:55:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 06:55:42 +0000
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
Subject: Re: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
Thread-Topic: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result
 with interrupt range
Thread-Index: AQHbNBUeMwd02aV0pkCrJjkNtdphnrK0ye6A
Date: Wed, 13 Nov 2024 06:55:42 +0000
Message-ID: <04f7b400-b754-417b-8c17-7605d9676e76@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-9-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-9-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6299:EE_
x-ms-office365-filtering-correlation-id: e3e22eee-a749-409c-cd40-08dd03b030ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WUJvYWlIRTZaaVNOZERiMytsSWxJa3QvL2dzQStXZFpaam1FdlB2S0JhN20r?=
 =?utf-8?B?ZVRoVytHZzZMSi9vTlNkU3FrUlF4cGhpWlpOQ0Z4TEJXR25adkZ0Qk8vREp4?=
 =?utf-8?B?N01SOFZSQ3puMVdkZXNhTmsyWVI2TU9OVHBJRWgzc0pEeVdxZU9jQTVoK2Ni?=
 =?utf-8?B?QzFCdW5CSmFFRHRTME1BMVJ4dmdiQzdHazF5TWJ3dzdzaTlUZ2JOanNGZ0pk?=
 =?utf-8?B?NDl2RVJwakJBaEJVaW10dU83bDc5YVUrZ3VXS1lkcUc4eFBzUUFkclZwOGJo?=
 =?utf-8?B?T2hpWEMybFgvbExvQ2pNTUZSUEtEQURVb29xa0hFMjFYV1N5dU9JOTlnZUow?=
 =?utf-8?B?V0M1OWh6UHRNZkh1bjE1ODRmbWg1bEZtbHdla0hROXlTRVpNVU9vWG9OK3FL?=
 =?utf-8?B?V0JNYXo0dXhpcEhxaEZOZG8yeVNnclpIZXFpaTlleW5ySnVMNW1wMHg0dVE2?=
 =?utf-8?B?TjJCMEZvcFVyenNjRVUyOFZkQW1Ya05sdzlmM2JRQTczZW80ajcvbERibzh0?=
 =?utf-8?B?c2ZvUWN2Y0tDbUhVQ3JrWGR0MEJtRHhkbnMxbXM1Y29xWDY4clloaFZOY1Zh?=
 =?utf-8?B?RVR1VmQwaWFnNVBCTlM5U29CSitJRWhJeTlpMFB5TkhRb1puWjJHejdYSk9D?=
 =?utf-8?B?N0ZpY0JucitMbUJWWXBCWGFYZ28zZ0hUeS9sTkpYclFjZktNRzVUNTlGMlht?=
 =?utf-8?B?Y005MkhPKy9YbmUzRncxU0FYMG5vV2p2Mkg4ZVhnRWNMZm1obUNPcjloQ2F4?=
 =?utf-8?B?TDR3YUFQSW5qUFIyWW1pZ3k3aFJDZmxCODR6M0tlWFU2OUlsVStyWFpZY3ND?=
 =?utf-8?B?SmMra0JKWXFvU0VLcVNWUllPYkxMYWJRYk42L0ZNREZNcVF0TEZJekh2eits?=
 =?utf-8?B?UFJ5NEtEWEp3TkRxUS8vcExaOEdkaVlzWVZWMFBzTUl2M2t4YUU4ZGNCVWVO?=
 =?utf-8?B?akIvdTJNaGU2K3dJeG1IbS9QS1ZrU3ZodzlzNUR0SjU5TUdLV0E3a2xoZmM3?=
 =?utf-8?B?QndEQnFVdVlOSG5xRlo1Mm43clMxd2ZRWXF6dHZoQURKZmVDK244bHhTUnN1?=
 =?utf-8?B?WHQrQkpYdm95ZGFBRnBxSmdLSEpCa0tiQlpGTk1QMWpheXprcFVyNzB2MXM0?=
 =?utf-8?B?Uzg5VG5WWEduQkZNK0dwS1c0bnBuOWVxUHdWbVN6bnlTRy9Mb3g1QWx6THlx?=
 =?utf-8?B?Z2tWVy9TN0FCNTZvQnQ0VGtvRjJpeUgwTHB1YkJyZXNKZHRHdDZwQ0lNMkdH?=
 =?utf-8?B?cStwaVNDYmdYK3FCOVA0aVg0aEphZ0c3YU9vTG1XMExmaUFxVUtuMVBGWFhJ?=
 =?utf-8?B?N1pINVlRZW5UenFPa0dMdUMyakhLbWZEVlg4djJLbmNnTHNVTmxzdmVIQXBG?=
 =?utf-8?B?VWw5OTIxOFBoaTZYWnhrdkd1RFJKY2hyeURaTkZKNkZWd01aaW14VEh2YUFv?=
 =?utf-8?B?aDBrNmNXNXJMZDhyaVg2T0NRcDh5M3RRd1h1WEJqd2xEc3pLcGVKWGdBY0Nl?=
 =?utf-8?B?eWhEWnNiZjhtckhQalU3QWdBRmJEcXdtWUs0N241YkJHSjNpNmlsbzhLdzdy?=
 =?utf-8?B?LzFuak1kM1dYVUVlWVA5SE1GVVhQNXhjbTFvaVg5UjdLV1ZWV1JnaWNQa3Zv?=
 =?utf-8?B?bk9RY09SK2F0MHRMRVlDZHBQQmFOUXg4SWw1b1ZEMlk1MU4vVDBwa1FQNmVT?=
 =?utf-8?B?dHdFbFprdklUWVlQb1pvUDZUQmQyNnk4RVlxK1dPRUFVUGZOS2t1TExXYk5X?=
 =?utf-8?B?SkF0Mnc2SUFxVThJdjJCRzdTRERBVTNQQi9MSEhOdURBdFZkNVcwMnVPSFZ0?=
 =?utf-8?Q?loDOtY8f76cXwXG29Frm6P/cfjDlTQAGpV1e4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2s1ZkNtbDFvUU9yNnZrSnRRMVAxeStmSlJzczNmcnJmUGcvV21MM0wvY0VG?=
 =?utf-8?B?bXdjRmRFQXliYit3Ym1YMFZPTmZwMHlGT1U1OCtLanZoZFZYcDlTcTNHZlJP?=
 =?utf-8?B?RzZrakpRUlRDd1gyZS92RGJSSFJtR1JkUGlnV3orMWc1Wm9mZ0RmUlV0RFVS?=
 =?utf-8?B?RGplV3kxT0VKVTQ3MGc5OVY1TlV6L2pRdHlJa2RJMGNHeW5udTFGY3N5VzFG?=
 =?utf-8?B?bGpSU2RKbVh3V0xBdGhBUVNDb0Fxdm1tN2lFdUR3b0FSN3lHaER0UzlWY0JL?=
 =?utf-8?B?VmRxYXFsZGFwZFNtNXhlSldyMXpqdTdxaXRaME5zazBGQTUrcW5iTDdGalBJ?=
 =?utf-8?B?UVRkSkRZQ0gyV3pUU1RmVjliUzh6cnBOL29zTEZCZHd2ZHVhdm5hb2o2VUY4?=
 =?utf-8?B?NkF6cTNhVFVUaUpZQmRzV25GK1duUWZnVXVNQXRCSW9OYXNtWU00VGxPaWtw?=
 =?utf-8?B?d2I5bGd4TEkwMCtmdkVwZ1A1M1BwNUZaSlVWbU9lUTNiM2UvbVRCNXR2VHh3?=
 =?utf-8?B?SFM4c2ZKOU8yeDZXMzNIRkZ2NFJ1eXVmeXlObzNMeVViSzg1a0NGcExUK25p?=
 =?utf-8?B?QmpzSGZuc1kybVZuam9wL2thOFVmU1dRd2dOeHhwaXNZSVRsRExQcGl3a1hy?=
 =?utf-8?B?c0JqdktvS2tFSk1FQnJXb2RLeDdlamtxMDlVcDNiMVFRdmVRT01EZEZUZ2dM?=
 =?utf-8?B?enYrSlJTbEhiUzdZSllIWk9KRjQzT2VCWUZVNkN4TFJKemIrYjJHaWdhNURW?=
 =?utf-8?B?b0RxTWpFUG4yeVlIcVpLQnh2Y2dwL1V2OGZ5WUZScS9CZHd1T0F3ZTExY0xC?=
 =?utf-8?B?WG5NN3VNZitBLzBXU0M3ZEtGazJJeEtlR21HeWErOE9MK2Foc21pc3hEMVRz?=
 =?utf-8?B?K2VCS3lpTXF3ck9WbHFXK3VmUlc1RXNQS2tKdThDcGVOQjVUeU0wRFFQT2pw?=
 =?utf-8?B?bjZOMllzL1g3Skd1MVVZSE8rdFlJQ3pzd2xUU3BPdmk5NTJrSVdYRFZ5dHZv?=
 =?utf-8?B?Vm1XZ2VyUGczNld0WWFvR1FOSDRIUmZPaDBqMDhxTlBYVDEyTm40WWRYemx2?=
 =?utf-8?B?SDJadGFTd3BJcjU0TUloQkNTeGlrUVZOMVgvNk9paGRRanRhcXVuV213MDRB?=
 =?utf-8?B?QUtFRkVUUDBNMGRHVWN4M2FxV0hiNmxONk9hdENjRGlTazRHRTFvNjRTYURQ?=
 =?utf-8?B?am5aRWluQVVxTVF0bG9pT0ptcDhVWlQvajE5NENZM2xLUFhsdkFxYmtheW1R?=
 =?utf-8?B?dHN2ZmltL09SNlZEbStHcU9VNG1hZktJU3U3bU9ZWHZSZUt2LzUzVzRWdTdw?=
 =?utf-8?B?OVU0V1Z1eVJyeHBDbUNBVVl6dVdSTzhKU3ZRUlRJV0Z4akRJS1NCaC9Id29V?=
 =?utf-8?B?SS9oZUk3K3ZoY2dQSjBINTMxaWFjdnVuTGhyNzNQbmRtSEhsMU5iTUVXbldI?=
 =?utf-8?B?VU5ZaDBIeXhOdUJrRFRnOW9OSU5pRTU1Y0R6VnhWMElIYnZ3bUN0UlpuNStL?=
 =?utf-8?B?Qi93SnFUbHRTNkFkYjdZVGRTNHZWOFBYdEFOM3Iycks2dlAwTTVUTWxueEZh?=
 =?utf-8?B?WGpmQUU0dUNUdElyQzdidWVvMG4zMEJmUFdOL3FNeWlhVHo0OXhac09rWTBN?=
 =?utf-8?B?V2ZxUU1Ia0pwN01MU1NhZVZsdnE3UXRRczFORHJrVGRrUW8zUERjMUxmai8w?=
 =?utf-8?B?TXpxTUMwS0Q5MEV4RmhiS2xvTnV3Q1Rxaks5QVc4OHFzaWc2Z3N1RnJNZWlz?=
 =?utf-8?B?UzgxeldiM1VERUtlczlJYlRtb09rKzdoeTJTQUQvTEwvTFVLVTZvV1AxMnZN?=
 =?utf-8?B?Z0hmY0pLTjNnTnRFRlZaRFN2bHVFV0g5YStEK29QM3VRdjhGMHlWcXBkWFBC?=
 =?utf-8?B?VFAzWDhXRWhVWXBNeUNrOU9xMHA2cDhwV1hSek5mYWV6MWVlaHJoamVsRnBt?=
 =?utf-8?B?dnlWdzA2RXQ3bFhtZHAzVVBOQTYwc1pmZy9qaW9JL3I0bUlRdlkyamdWVGF1?=
 =?utf-8?B?N3NsUkR6c2cyVHBiSFFwelNvNEZoSXJoOVZMN2l5K3QrK0RodWtHZ1RFYWE5?=
 =?utf-8?B?cng4QmJ6UGhwRG9jbXA5b2JhQVlEZ2kzVXJDdHpUWXNLeThxTnBmMWcvTEFl?=
 =?utf-8?B?YS9DQTRmcStJaUlCVjRWcnlkOTJEUmZKTWllU1VLQ1F0RWR1Q2FtcHVZcE1n?=
 =?utf-8?Q?iNmN362mxKd5thJ1iFW+Zgc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31378920F4F2CE40BFCD842AF9CE8BDA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e22eee-a749-409c-cd40-08dd03b030ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 06:55:42.7315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSxk62JYKq1rTM7VrLinvJDVXi0kuSHoVK/Ze8oBJ63lGKm47+Qhn1LcsefKOP47Vt0ywLwlduzGmR/xFNYP4V1lASyHQjZxe+Dq3x7wyvd5R1ZYpohXc7AnRczFYBHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6299
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

DQpPbiAxMS8xMS8yMDI0IDA5OjM0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBQZXIgVlQtZCBzcGVjIDQuMSBzZWN0aW9uIDMu
MTUsICJVbnRyYW5zbGF0ZWQgcmVxdWVzdHMgYW5kIHRyYW5zbGF0aW9uDQo+IHJlcXVlc3RzIHRo
YXQgcmVzdWx0IGluIGFuIGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCByYW5nZSB3aWxsIGJlDQo+
IGJsb2NrZWQgd2l0aCBjb25kaXRpb24gY29kZSBMR04uNCBvciBTR04uOC4iDQo+DQo+IFRoaXMg
YXBwbGllcyB0byBib3RoIHN0YWdlLTEgYW5kIHN0YWdlLTIgSU9NTVUgcGFnZSB0YWJsZSwgbW92
ZSB0aGUNCj4gY2hlY2sgZnJvbSB2dGRfaW92YV90b19zbHB0ZSgpIHRvIHZ0ZF9kb19pb21tdV90
cmFuc2xhdGUoKSBzbyBzdGFnZS0xDQo+IHBhZ2UgdGFibGUgY291bGQgYWxzbyBiZSBjaGVja2Vk
Lg0KPg0KPiBCeSB0aGlzIGNoYW5jZSwgdXBkYXRlIHRoZSBjb21tZW50IHdpdGggY29ycmVjdCBz
ZWN0aW9uIG51bWJlci4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVs
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNDggKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCA0Y2M0ZDY2
OGZjLi5lNjUxNDAxZGIxIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0xMTM4LDcgKzExMzgsNiBAQCBzdGF0
aWMgaW50IHZ0ZF9pb3ZhX3RvX3NscHRlKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVu
dHJ5ICpjZSwNCj4gICAgICAgdWludDMyX3Qgb2Zmc2V0Ow0KPiAgICAgICB1aW50NjRfdCBzbHB0
ZTsNCj4gICAgICAgdWludDY0X3QgYWNjZXNzX3JpZ2h0X2NoZWNrOw0KPiAtICAgIHVpbnQ2NF90
IHhsYXQsIHNpemU7DQo+DQo+ICAgICAgIGlmICghdnRkX2lvdmFfc2xfcmFuZ2VfY2hlY2socywg
aW92YSwgY2UsIGF3X2JpdHMsIHBhc2lkKSkgew0KPiAgICAgICAgICAgZXJyb3JfcmVwb3J0X29u
Y2UoIiVzOiBkZXRlY3RlZCBJT1ZBIG92ZXJmbG93IChpb3ZhPTB4JSIgUFJJeDY0ICIsIg0KPiBA
QCAtMTE5MSwyOCArMTE5MCw3IEBAIHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fc2xwdGUoSW50ZWxJ
T01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPiAgICAgICAgICAgbGV2ZWwtLTsN
Cj4gICAgICAgfQ0KPg0KPiAtICAgIHhsYXQgPSB2dGRfZ2V0X3B0ZV9hZGRyKCpzbHB0ZXAsIGF3
X2JpdHMpOw0KPiAtICAgIHNpemUgPSB+dnRkX3B0X2xldmVsX3BhZ2VfbWFzayhsZXZlbCkgKyAx
Ow0KPiAtDQo+IC0gICAgLyoNCj4gLSAgICAgKiBGcm9tIFZULWQgc3BlYyAzLjE0OiBVbnRyYW5z
bGF0ZWQgcmVxdWVzdHMgYW5kIHRyYW5zbGF0aW9uDQo+IC0gICAgICogcmVxdWVzdHMgdGhhdCBy
ZXN1bHQgaW4gYW4gYWRkcmVzcyBpbiB0aGUgaW50ZXJydXB0IHJhbmdlIHdpbGwgYmUNCj4gLSAg
ICAgKiBibG9ja2VkIHdpdGggY29uZGl0aW9uIGNvZGUgTEdOLjQgb3IgU0dOLjguDQo+IC0gICAg
ICovDQo+IC0gICAgaWYgKCh4bGF0ID4gVlREX0lOVEVSUlVQVF9BRERSX0xBU1QgfHwNCj4gLSAg
ICAgICAgIHhsYXQgKyBzaXplIC0gMSA8IFZURF9JTlRFUlJVUFRfQUREUl9GSVJTVCkpIHsNCj4g
LSAgICAgICAgcmV0dXJuIDA7DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgZXJyb3JfcmVw
b3J0X29uY2UoIiVzOiB4bGF0IGFkZHJlc3MgaXMgaW4gaW50ZXJydXB0IHJhbmdlICINCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgIihpb3ZhPTB4JSIgUFJJeDY0ICIsIGxldmVsPTB4JSIg
UFJJeDMyICIsICINCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgInNscHRlPTB4JSIgUFJJ
eDY0ICIsIHdyaXRlPSVkLCAiDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICJ4bGF0PTB4
JSIgUFJJeDY0ICIsIHNpemU9MHglIiBQUkl4NjQgIiwgIg0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAicGFzaWQ9MHglIiBQUkl4MzIgIikiLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICBfX2Z1bmNfXywgaW92YSwgbGV2ZWwsIHNscHRlLCBpc193cml0ZSwNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgeGxhdCwgc2l6ZSwgcGFzaWQpOw0KPiAtICAgICAgICByZXR1cm4g
cy0+c2NhbGFibGVfbW9kZSA/IC1WVERfRlJfU01fSU5URVJSVVBUX0FERFIgOg0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC1WVERfRlJfSU5URVJSVVBUX0FERFI7DQo+IC0g
ICAgfQ0KPiArICAgIHJldHVybiAwOw0KPiAgIH0NCj4NCj4gICB0eXBlZGVmIGludCAoKnZ0ZF9w
YWdlX3dhbGtfaG9vaykoY29uc3QgSU9NTVVUTEJFdmVudCAqZXZlbnQsIHZvaWQgKnByaXZhdGUp
Ow0KPiBAQCAtMjA2NCw2ICsyMDQyLDcgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5z
bGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+ICAgICAgIHVpbnQ4
X3QgYWNjZXNzX2ZsYWdzOw0KPiAgICAgICBib29sIHJpZDJwYXNpZCA9IChwYXNpZCA9PSBQQ0lf
Tk9fUEFTSUQpICYmIHMtPnJvb3Rfc2NhbGFibGU7DQo+ICAgICAgIFZURElPVExCRW50cnkgKmlv
dGxiX2VudHJ5Ow0KPiArICAgIHVpbnQ2NF90IHhsYXQsIHNpemU7DQo+DQo+ICAgICAgIC8qDQo+
ICAgICAgICAqIFdlIGhhdmUgc3RhbmRhbG9uZSBtZW1vcnkgcmVnaW9uIGZvciBpbnRlcnJ1cHQg
YWRkcmVzc2VzLCB3ZQ0KPiBAQCAtMjE3Myw2ICsyMTUyLDI5IEBAIHN0YXRpYyBib29sIHZ0ZF9k
b19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0K
PiAgICAgICAgICAgcmV0X2ZyID0gdnRkX2lvdmFfdG9fc2xwdGUocywgJmNlLCBhZGRyLCBpc193
cml0ZSwgJnB0ZSwgJmxldmVsLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnJlYWRzLCAmd3JpdGVzLCBzLT5hd19iaXRzLCBwYXNpZCk7DQo+ICAgICAgIH0NCj4gKyAg
ICBpZiAoIXJldF9mcikgew0KPiArICAgICAgICB4bGF0ID0gdnRkX2dldF9wdGVfYWRkcihwdGUs
IHMtPmF3X2JpdHMpOw0KPiArICAgICAgICBzaXplID0gfnZ0ZF9wdF9sZXZlbF9wYWdlX21hc2so
bGV2ZWwpICsgMTsNCj4gKw0KPiArICAgICAgICAvKg0KPiArICAgICAgICAgKiBQZXIgVlQtZCBz
cGVjIDQuMSBzZWN0aW9uIDMuMTU6IFVudHJhbnNsYXRlZCByZXF1ZXN0cyBhbmQgdHJhbnNsYXRp
b24NCj4gKyAgICAgICAgICogcmVxdWVzdHMgdGhhdCByZXN1bHQgaW4gYW4gYWRkcmVzcyBpbiB0
aGUgaW50ZXJydXB0IHJhbmdlIHdpbGwgYmUNCj4gKyAgICAgICAgICogYmxvY2tlZCB3aXRoIGNv
bmRpdGlvbiBjb2RlIExHTi40IG9yIFNHTi44Lg0KPiArICAgICAgICAgKi8NCj4gKyAgICAgICAg
aWYgKCh4bGF0IDw9IFZURF9JTlRFUlJVUFRfQUREUl9MQVNUICYmDQo+ICsgICAgICAgICAgICAg
eGxhdCArIHNpemUgLSAxID49IFZURF9JTlRFUlJVUFRfQUREUl9GSVJTVCkpIHsNCj4gKyAgICAg
ICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogeGxhdCBhZGRyZXNzIGlzIGluIGludGVycnVw
dCByYW5nZSAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiKGlvdmE9MHglIiBQ
Ukl4NjQgIiwgbGV2ZWw9MHglIiBQUkl4MzIgIiwgIg0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgInB0ZT0weCUiIFBSSXg2NCAiLCB3cml0ZT0lZCwgIg0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgInhsYXQ9MHglIiBQUkl4NjQgIiwgc2l6ZT0weCUiIFBSSXg2NCAi
LCAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicGFzaWQ9MHglIiBQUkl4MzIg
IikiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGFkZHIsIGxl
dmVsLCBwdGUsIGlzX3dyaXRlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGxh
dCwgc2l6ZSwgcGFzaWQpOw0KDQpIaSBaaGVuemhvbmcsDQoNClNob3VsZG4ndCB3ZSBhZGQgdGhl
IHBndHQgdmFsdWUgdG8gdGhpcyB0cmFjZSBhcyBpdCBjYW4gbm93IGJlIGdlbmVyYXRlZCANCmJ5
IGJvdGggRkwgYW5kIFNMPw0KDQpUaGFua3MNCmNtZA0KPiArICAgICAgICAgICAgcmV0X2ZyID0g
cy0+c2NhbGFibGVfbW9kZSA/IC1WVERfRlJfU01fSU5URVJSVVBUX0FERFIgOg0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC1WVERfRlJfSU5URVJSVVBUX0FERFI7
DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICsNCj4gICAgICAgaWYgKHJldF9mcikgew0KPiAg
ICAgICAgICAgdnRkX3JlcG9ydF9mYXVsdChzLCAtcmV0X2ZyLCBpc19mcGRfc2V0LCBzb3VyY2Vf
aWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIsIGlzX3dyaXRlLCBwYXNpZCAh
PSBQQ0lfTk9fUEFTSUQsIHBhc2lkKTsNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

