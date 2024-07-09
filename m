Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDB7C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4BC-0000is-2T; Tue, 09 Jul 2024 02:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4B8-0000gl-1d
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:18 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4B4-00080V-6v
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720505894; x=1752041894;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=G2NEi8NswOhG6gPA68L8MYt7Ej/ubgwv0BLN5se4lzM=;
 b=juEYZr9I3mBKfqOWSrHKzLImIzTvDe1FM7ZO3tNHq2pXCsjjYBDxYVZM
 nNzbRIWJ99+m5TfCWnShrRPtK962k92FiLUyQAajUkFBHIHRigFCewLqX
 cREahPQxEpri16zJN2colvRpq7BehHf/nHlFduROBrpTg9pBzMqEcsTjv
 OmOevlw+xckXno/4z0yAKwzt5GR6OcHxAFNuLdrteK2/PomaAZdbJulcX
 qNX63uxzJeJHvH5vVkGdHU42Dp/lKidbYaIHE371Cfmu/MI34jK525Kl5
 ol9/o68kJ+n/L7+3cbfHMnRpD8VnYImNQXUr9T/tKNjGWgyQafwO75nKy Q==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16237747"
X-MGA-submission: =?us-ascii?q?MDG1AIf74Eo8cWCLJ70YioV9EfY0HnGQeKCH34?=
 =?us-ascii?q?zBqaG0aoM5+gIjvtu3QeT1jx3ilcRv0qo8y3OF1jCw6/23LCy+Y+2vdm?=
 =?us-ascii?q?NRpXbUJ5+Scq4udwkSqIw7LLgOnFkS7aDHcLCrJemKv253M7+Q6dz/6G?=
 =?us-ascii?q?3b3ZwwStrjLicr0+URBB+jLw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 08:18:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDnTm5BHBjuFr74LuKEDCVCosPFmIZ062xoeSGmPrbFwGuQtCuhnSUTjbmUP92bg9wMPVm9UC3CtqtDKHHXOFQCuBmRC7lSyHuqxfP25NJq/ipr5g22V9VZ2pt2kNxIK0/Etbj1VXj9Z82ChwX6+5KubgYmakQo2GMDtcIp7DqtqsjK751uVsdGgtzrcl1qqnrm60JGkruaQLrRl2zVRVukyB+gapd/WSXAqKbnx1YXXC19Rx+Rfml2cTtTMqF+Vq21TkO1Lg8CXJqgctR14UqOIsTuvhamPOuqiwfIoVBagvZLNPE/3uUbgC89LzilrIkMcYd4jC0dr73Bez2MtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2NEi8NswOhG6gPA68L8MYt7Ej/ubgwv0BLN5se4lzM=;
 b=MUY1U6O8mtIKiPxyLYbTWx+siPJB7nwih+7/sIaBF+TviSqLXL8QWkGcs+vNYTGEpyffktY6dVBSB9v+HKUHKS7YqdoppHF13OOpZ+KO1FuFbODObCp/KfglO2YO8OYG0vzaU1nDl87nmoKckXuexrigT1IClsVIA12RVQGB2/RJgTrVxoBOQVMUbDCFXzrk/LmcrpQMRHS6kQ5wO8EhrEn9v9oowa5ioDJFGpqE2a4CZrkFJzdOCfqt5j2MNO9gc+7ZCYvZ84mJnXl7Oets39P45/uTGDFGMk6ppRCSP7AkE97aC7Xiy5mPG88aAk4YfXzS7PKkm4ySyQiijYFCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2NEi8NswOhG6gPA68L8MYt7Ej/ubgwv0BLN5se4lzM=;
 b=kevPtlBhRD7jjJ3ZC04vXXC39x/BDw52e79Q28S840M3U+mNi0badzvu+igEgJi3Bj3gyQZiqpeU29YYi5Lpf5Oxv+A6Yczm/yO51M0nU5JU7o4fmimd6MwgFvC1KcMjWSKG/zBMAeDCm51jYti6SCQUpmUKh/kmJeffD+3qTQkBS66Kh9qSsKSXYrIy/N2Ja7Sa8sJxRoYB6xoFX7PuzCMw9A8FMivvLq/EPEbIHPf4u4kX1FUqPcBUG7mOkgXdZQoXQ6Ie7EDQK93dHe38wiLXtGaJOmqmCWI9vZPxnhRu5V7OYaSHRS/jJ4GnvGXMxMAoiAAnhF7dy/PL7Mw/4w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8466.eurprd07.prod.outlook.com (2603:10a6:10:355::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 06:18:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 06:18:09 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHa0cfEukGxrC/dLUmtiYAPj/jVWw==
Date: Tue, 9 Jul 2024 06:18:09 +0000
Message-ID: <20240709061756.56347-4-clement.mathieu--drif@eviden.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8466:EE_
x-ms-office365-filtering-correlation-id: b7912557-9922-4d7c-e4fd-08dc9fdee76e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVRob2l2aVdsNFI5a2VxQTFWUDVPdTRnVzFSNTQ0QVhmN3VWR0NFRlNUc1Vy?=
 =?utf-8?B?ek5zd0ptWXBLR3hPaHRkL1BEd0pCeXd5TVlqYWZZeERmZjRNNWFPamNaeWsy?=
 =?utf-8?B?UWxkQ1phY1lqeHNhWHhkYS8yVWN1UDl4Y2gwQ2lzZFFMWXNtY3JxTWJaTjg5?=
 =?utf-8?B?ZnJPbXJMWmt3Y0FlWU1ISXFBMHg4Rno5c25hek1SZlgzSFZMalNuejg2a0N3?=
 =?utf-8?B?VmNFZTNmNW1YckJVblVEV25PSUorWHFIaXZjb0lOQjNKL3ZhV1RwVVBFcFYz?=
 =?utf-8?B?ZFVoenZwRmFDU2ExbVRRZHdnRlJqTms1TEhwTlBZcHNiWFZIaktmVDJUV0dj?=
 =?utf-8?B?TE0yVm8xazl4Q0hROGR4bDNIdUVlRXFFY1daUktLanFnS1Arem5DbWpONGEw?=
 =?utf-8?B?S01MZUZmbjIvODRKVWJ0RnBta2lXcUpxOUY5aXhrWnVDTk5SeDB0OGl1UFVK?=
 =?utf-8?B?T0VQMi8zWDZIU3E2Si9lTlgxUUhGbG9CT3VvLy9xYnlocFU5KzJkOHN0V1Bm?=
 =?utf-8?B?SlFxRTUreVdLTlEyU3NCUFdpbHhiMUovbUMyWVVMK1luZVZXSkZTN3gwWUNp?=
 =?utf-8?B?d3d3dm9OdlZPUzczR1RraWlXL0ZLUTVzRm1XM1JYTlMwbTNhOFB6aFlqYm45?=
 =?utf-8?B?WWFXVXFjTEsrbXFwSENkVTNHN0tZeXBocDVUdFlJWTR4TUNyaGNMZXZRY2xm?=
 =?utf-8?B?eUxiY3dBWlpnMUNjYTM5SVZ2WUFuaGFHalh6ZkZySklxRDJLZG1HL3A1dHU0?=
 =?utf-8?B?eW9QZUY5SWpWUEV5cFliaG9DN2dpZVhjOFBXSXM2M09aYzRLS2dhc2R2MmZs?=
 =?utf-8?B?a25lQXc4L1NJY0M2bHI2SEEzS1FrTmdhNDJMVEhiR0Z0QmMrQUtvT0R2emF2?=
 =?utf-8?B?R2dDK0h2Vm9oMEtwYzdnVml3dlI5VHd6UGI5b25mSmViTnNmVkszVFROTElX?=
 =?utf-8?B?TUZXSUk1TCszRjBadzdkRUE3NHl3bExFeUNWeko5QW5oYmN5U2t3WVJBL0Fy?=
 =?utf-8?B?b3VKYnhqbkhPK0U4WkhnMldoM3RtNkdYd0pRWXNpV2M4dVQ3Ym82MEpZM1d2?=
 =?utf-8?B?N0VFNXJ4VlI3N20vdlkzckNKelh0ZlpvTmlJNlFHM2N4WjN5OFVkalgvN0xv?=
 =?utf-8?B?a2o4bVFOS1ZKbnpLUVF4eDYyR1MwQkRjbm9RYXo3UHdmSm04Y25sVU9WTGMw?=
 =?utf-8?B?aHVRZ3hGdlptTFc5UlVLdFNuWXRUWllwVFlJKzUwcDQ3bTlHbFdYMUZFaFNq?=
 =?utf-8?B?NWNXTjRJYXRwM1BHVGJ3Z2ZwOWpxMDJ6MTdsbkI1NythOGpleEVsczlEUFR5?=
 =?utf-8?B?YmVESGhvYVl2RGFXd0xoOW5ycFZqMUx2ZFdRcFlIVUpZRzFsVHZyRVVwNVRq?=
 =?utf-8?B?a082Z2lRNnV1T25lU3djRjFjYUkxS3ZyclZKZ1hIN2V5NGNJNHBCN1VJU21B?=
 =?utf-8?B?dzkzYytNNEtZUnNxSGI1QUI4ZzFYZ1krMFArdEN5L0MzY2ZSMUpqZDZGclZz?=
 =?utf-8?B?alRjR1pGUWxvOHorZUZUeUFxL0xxQlgwWm4wQ2R1NmlUS21KdWJ3THltZ2RU?=
 =?utf-8?B?YjJUanFzVGRidUlWTnNWRmsxVUJPZmNOOG16NVR5M091ZGk2STk3ZzF1RkV6?=
 =?utf-8?B?cHpodXdmMmNLeTk3VStUeFZhYWkzTjNhRjBrdk9hMFcwQTFCME1vUEVqZk1O?=
 =?utf-8?B?MXgrUXN1OWc3Y2RydThoWnlkSmt5a3ZWdm9lOElmdlFlenJPN2NpcFBHS1hk?=
 =?utf-8?B?dm5RU2JlUzhqRHFIdEN0QzZhd0RJQUtNVm5hYjhBemtpVmVyNnQrYUw4a1B4?=
 =?utf-8?B?YjBiaHFmS1BtZFN3R1FWZHkzeUNaOTk1UzFuc1V6bUoyYU5WRVVrVTR5NHJm?=
 =?utf-8?B?NzBMZDRsSUdCaU03WnpINEhqQi9tOStjOC9TK0g0elJLd0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3F3TUt3M2RnNm55TXRPcnp0Z0FXemdhS2xjVTdMZkQxemp3T3VVOWdTZFJz?=
 =?utf-8?B?RUM5L3A2RWZzOTlUc1YwUlQ5eTBlbFZTS3hiOXhFcWpKYXpPclY4NXNZQzVS?=
 =?utf-8?B?cnN2alpIYTZkeE12RUJsa3ZLWERCUkpPY2lPL0YvZENjMTlFQ1BiUkdqU29I?=
 =?utf-8?B?L2QxaHFqMDZJemxPTXdFVXhNOUZ6TTFaZENXYTJzQ2hmMGlkb1lhUWxFNThD?=
 =?utf-8?B?bW9GQ3dYSlpWbTFWUWpjNk95YUpKbzB3Qld3L3pmZWdQdTd5M0xDU3g1VThp?=
 =?utf-8?B?T0RrMDV4Q0lKR3ExaEtqRHRNeUVQdkw1QzhmTzhwK0pET09NSWpGcjd5V25X?=
 =?utf-8?B?ZUhRQ3EwNWZWQ25RNFN1aldRMy8xVDVaZGhlT0V4NjZTSHFrZnRRNTlvOXhh?=
 =?utf-8?B?RmZIdVBqWkc3aktaSUxuQUJ3cjZ6a3Y1VGpwR2R3TE5nVWJtakFrQlp6eVZJ?=
 =?utf-8?B?S3N3QTh4eTd6SnpDcThtTlNzVUwrZlpKRUVsaDV2OFY1eWlUWWtOeG1kYS9h?=
 =?utf-8?B?N3pqUlUrZ1FMMnYxUDV2bm5uQmNKM3JSa0dyWkh0TkVVTlF2WjY2c2RUQVZ1?=
 =?utf-8?B?UVgzY0w0MFc2QTNwYmxJYU5MbWt2VzFoSmxjN1V1bElRckkyT29PYk42TU5X?=
 =?utf-8?B?YUt0Um9rOElFWVVKdHlRWXhWcmsvVXZDWE1NVk5EWlU4WWo1WkZTZkk0dkpk?=
 =?utf-8?B?S1IyajE3a05nTC9kN1VUekJSekRHbk92WXEzZURzcVVzSFhhTUd2dVBsVXA4?=
 =?utf-8?B?TVh2dmlSWE5EZENEV3RvWTM2SUloUmtGSjhNSndiUnJJTzJ3Vy95Z1kvWnpW?=
 =?utf-8?B?ZkRWY1V5aDRWT3hwTmR5cmJ2MUJOaldxMFR0LzdvNXVkTmFRU1VzVk1iaWlp?=
 =?utf-8?B?SURjWjgrMWJwN0NRd210M1REOFRpT1pjNGkvU1ZtcUIvMEdjSzdmdXRBdVQ2?=
 =?utf-8?B?Q093d2hGamFBMWFFOTIxOTJmeXdGclZ3dmhteExXRkpqZG5zVU9XcFJ0cktx?=
 =?utf-8?B?TXh5dnVYOXNaYWVocWIrRXZjSmhvQjNIbjhqWmFaZFZXejNKQnNBS0U2Qk14?=
 =?utf-8?B?R3R3c0laWlhkY1BMZndPcEVSS1ZsZzNoR0l0ejU4NzA4dXBkb0IxNlVSNEFC?=
 =?utf-8?B?MEFDWWREYmxNcWpyNk10SXRNNUQ5ajMvYjVpMW1ITHd4bVM0RHZBamtNN3Nv?=
 =?utf-8?B?S24yUUlOcEl4cnZtZkMwSThUalpEYlFrTExHdGFqcnkrOTdsaWduZUFvWG9B?=
 =?utf-8?B?M1k1QW5oTWhoTDFpam5paldEeTI5ZEtqeGlrNXlSb1hiWXpsYXBQMG5La1Qy?=
 =?utf-8?B?R05GYmE1NWkzVVAxaDUyVUdhMjZEOUY0c2xILzBKZzIybWgyeXlzcHpFT211?=
 =?utf-8?B?bWpiaWtnRU94bnNubFBtZDF3ZmRObFZNOXpMRE5VUVRmMDNhYkR0U0pzRlBu?=
 =?utf-8?B?SjM3WU9xdDUwdGw2VGJGSzZrREQvTEppeWZzVzU1a3h0OEh0NHJaZERWVlE4?=
 =?utf-8?B?Q3JiRFFSYlNUdy95a1gzWlFiK0w2TGZnZ0VsRXB0VTlzNERrTUZlZ0FNaldT?=
 =?utf-8?B?NjFpQ0I4UUEzU1VKYjRybThPTUlYZXgraTE1emZoWEtsK00rWENZY3NaYUpm?=
 =?utf-8?B?YlJrYU92cXRocVd6bVgwWkxzaTBOQXh0Mmo0Rk1pQXdSR0pBdkYvenNBV0J1?=
 =?utf-8?B?NlA3MUlVaFQzUzFhbUM2UkZNMk5kS29TcjR2RU9lRmFvbzBrNy93SzE3S3ZF?=
 =?utf-8?B?bHpQVHJkTVhvY1hMdGJTempGVWZUcUVWWmp3dzF5UFVldjhmTHpGVmZITXRr?=
 =?utf-8?B?eTNkZ3U3ZzZrbGx2RStiMUUwZW9uY2xtVWV4RTJDQmJxdEJWbUorTnYxZ1BP?=
 =?utf-8?B?YzZLTWRIWHVhMkUzcFhJWWQ4b0xIQ1U0NEZ1M0Q2NHRacEYreWRzaElMb3ow?=
 =?utf-8?B?QW4ycThZcHRBTXg5aitadHhwVnZSUkJxNk9DQWhUZk40ZWdldlBuMmRNQ0ZW?=
 =?utf-8?B?dGY5cER2ck9udys5dUZsT2NxMlZaWWxLcDNHVzNZU2dKZVFoOTNXdEwrZnVh?=
 =?utf-8?B?R3d1OFBhVFozbGErdllJQ1dLdlNENi9aMzlCeDc0M1BXK3Qrd3Mrd2d1T0Qz?=
 =?utf-8?B?Y01XTnA4eUd3aldMdmcwQVNiQ2ltSmpjUnBhOG9HbkZLbHZyQUw5emU0Y1Ny?=
 =?utf-8?Q?3O55kvigRBx0QqDvkFVPUeY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA2D682C301AA48AFD02470C66AE7E5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7912557-9922-4d7c-e4fd-08dc9fdee76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:18:09.3790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sj3V35/kuJoXfeGYQMzDcWfOWKYu/55hogeO79ZpNuBNHxkqGmtraVh2pPKF74zoyIVHrCq3vIZQLRpZFG/9pH3wVFoOdBGjry3GsmgqNOYNWtBr6AjnzWmXtqkONQ8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8466
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBtYXNrIHdlIGFyZSB0cnlpbmcgdG8gc3RvcmUgaW50byBWVERJT1RMQlBh
Z2VJbnZJbmZvLm1hc2sgbWlnaHQgbm90DQpmaXQgaW4gYW4gdWludDhfdC4gVXNlIHVpbnQ2NF90
IHRvIGF2b2lkIG92ZXJmbG93cy4NCg0KUGVyIHRoZSBiZWxvdyBjb2RlLCBpdCBjYW4gb3ZlcmZs
b3cgYXMgYW0gY2FuIGJlIGxhcmdlciB0aGFuIDggYWNjb3JkaW5nDQp0byB0aGUgQ0ggNi41LjIu
MyBJT1RMQiBJbnZhbGlkYXRlLiBBbmQgeW91IG1heSB3YW50IGEgZml4IHRhZyBhcyB3ZWxsLg0K
DQppbmZvLm1hc2sgPSB+KCgxIDw8IGFtKSAtIDEpOw0KDQpDSCA2LjUuMi4zIElPVExCIEludmFs
aWRhdGUNCg0KQWRkcmVzcyBNYXNrIChBTSk6IEZvciBwYWdlLXNlbGVjdGl2ZS13aXRoaW4tZG9t
YWluIGludmFsaWRhdGlvbnMsDQp0aGUgQWRkcmVzcyBNYXNrIHNwZWNpZmllcyB0aGUgbnVtYmVy
IG9mIGxvdyBvcmRlciBiaXRzIG9mIHRoZSBBRERSDQpmaWVsZCB0aGF0IG11c3QgYmUgbWFza2Vk
IGZvciB0aGUgaW52YWxpZGF0aW9uIG9wZXJhdGlvbi4gVGhpcyBmaWVsZA0KZW5hYmxlcyBzb2Z0
d2FyZSB0byByZXF1ZXN0IGludmFsaWRhdGlvbiBvZiBjb250aWd1b3VzIG1hcHBpbmdzIGZvcg0K
c2l6ZS1hbGlnbmVkIHJlZ2lvbnMuIFJlZmVyIHRvIFRhYmxlIDE5IGZvciBlbmNvZGluZ3Mgb2Yg
dGhpcyBmaWVsZC4NCldoZW4gaW52YWxpZGF0aW5nIGEgbGFyZ2UtcGFnZSB0cmFuc2xhdGlvbiwg
c29mdHdhcmUgbXVzdCB1c2UgdGhlDQphcHByb3ByaWF0ZSBBZGRyZXNzIE1hc2sgdmFsdWUgKDAg
Zm9yIDRLQnl0ZSBwYWdlLCA5IGZvciAyLU1CeXRlIHBhZ2UsDQphbmQgMTggZm9yIDEtR0J5dGUg
cGFnZSkuIEhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyByZXBvcnQgdGhlIG1heGltdW0NCnN1cHBv
cnRlZCBhZGRyZXNzIG1hc2sgdmFsdWUgdGhyb3VnaCB0aGUgQ2FwYWJpbGl0eSByZWdpc3Rlci4N
Cg0KRml4ZXM6IGI1YTI4MGMwMDg0MCAoImludGVsLWlvbW11OiBhZGQgSU9UTEIgdXNpbmcgaGFz
aCB0YWJsZSIpDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NClJldmlld2VkLWJ5OiBNaW53b28gSW0gPG1pbndv
by5pbUBzYW1zdW5nLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggZmFlYTIzZThkNi4uNWYzMmMzNjk0MyAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtNDM2LDcgKzQzNiw3IEBAIHN0cnVjdCBWVERJT1RMQlBh
Z2VJbnZJbmZvIHsNCiAgICAgdWludDE2X3QgZG9tYWluX2lkOw0KICAgICB1aW50MzJfdCBwYXNp
ZDsNCiAgICAgdWludDY0X3QgYWRkcjsNCi0gICAgdWludDhfdCBtYXNrOw0KKyAgICB1aW50NjRf
dCBtYXNrOw0KIH07DQogdHlwZWRlZiBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyBWVERJT1RM
QlBhZ2VJbnZJbmZvOw0KIA0KLS0gDQoyLjQ1LjINCg==

