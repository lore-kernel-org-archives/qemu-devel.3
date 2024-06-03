Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAC8C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jm-0006oW-Pb; Mon, 03 Jun 2024 02:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0ji-0006kQ-1t
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:03 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-00071B-Oj
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394399; x=1748930399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iWMaK1JrTCFHi3BheGFgAXWAS6o9as2GR7+CmB8E6vM=;
 b=Ht6vv6V614i7/xjiNl2RVoaJHDO5JmzdJ4XjbU6s14/mJ3fJzNFB79O0
 79H6bWX53hKsqk2jYs7zmjqiM2C0O06hYOOcAaMy9Zc1SQNO9VllLUXsb
 iIUbIzIFHEedDk4tcexX+hq0cmmCx3NeUkVj5RPll5e8mVm2tyfdnx3zC
 IPFDgGLK2l/6LRji+686wlFXr1pVc/dgnVrmnBrlDUvDrP4K/YRGnF3oy
 m0Y/cJf+seaY0K+thPxPih3eCX7uXVs5F1+hzhtGAfKMq7IE8kqjpCO3E
 /2slRcGVvrXISy+qu7rSXqDi8DyJ5ouLKIGw0OIlSJQAQn1Z/R8qBWO3j w==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815879"
X-MGA-submission: =?us-ascii?q?MDHyJ2Ua9jzKmhGJw4TxygAADNa75MbRYLi4We?=
 =?us-ascii?q?Cr6nU4ItIlwlm6empiFhNjpwm4s1vQfqqclKLwDmRCwnBXh3JxVJx4/W?=
 =?us-ascii?q?NErlmX13gr8SocXYuHB36+1QqKbaSjxhyU18CK7A6fl5Ay0moFyyvtA1?=
 =?us-ascii?q?uUnclElyChXYdUbQFbfvjnrw=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgKK/2utXekTt5TqkA5he8QLEFHT5DjEaeu/PkPop5POZhR6FdjO6ZRqLz4x3hT+/kqjfVeARgPwNohZc12D1Q2J0UGoau4d53CF3D46XB7e8/xWjtNQ6EctmXMD1UdjCDMW1oWtDnPhs82qDj4qRt21f1342W9gDEdYWiSxZiwdGmCO7FrWRKjCckmYvGLwBbgd6sKFw+ilbdrmv/aK4+LNVhCysHNJynPSx9HjyyiBAKhMF/mNHyVFBYC3Ibhq5lMM7g9cZCTJFTFUZMcxE3UJ9MC7lIT0pz/og5rrhLanCWyTMgz8XDaNfXvDXqzkHzj9a+Cm+T+t7ko4vpBH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWMaK1JrTCFHi3BheGFgAXWAS6o9as2GR7+CmB8E6vM=;
 b=UjMoUCE0vAA/8hVEyasRIJkqIS+3zUi9ordWqQo3cUESlhinu7H3+vXbeWOjGaegGVLvU47nKwl6TE6wncXMlbbgq41d00FYCq17Jej48i9ub5iv4Z0kf5Qf1R+d/uMk1y8XEGsWzlHKSXz3cI4u7vbtUKy/+EL18P+9wrNlkTj67EDQDL4EFIq3W7DNFTE1V/Gq77dEDqoX12M0dgdUmFEojLc18dgbvuQT5FNpqUtE1/qyORd4y12pD3aXkDdN+8KCmfOzGfrO313bAJKbsaem5cgdcWwPVHUUxo4kSms1sbzHSbnH5tCZr1R2TyFpJrZWKUZjvivfSnozfnlS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWMaK1JrTCFHi3BheGFgAXWAS6o9as2GR7+CmB8E6vM=;
 b=X2corQdqsRJbGXLb+203hLdzdr7/o6T3ykGCHQ0egNqpQQCS+cz13d/5B+rWZZaWMWWhtYK73zzNEPZrm9JbqalfAAcyy0o4qbCm74cR6hHUid7Or+cyy+S+Bqb+UOFrNswYDZBLe1SVw8pHrTda5fBENvRNJoR9Rkr+rDX2oApIhshWbVzh3dPHH5p+WoAyfaOv5sfcTUxy5HNbX+FL9/DSL4Hs0SuqFbWLNbrBJa/YoqGR/eYDip6RIPYu2AD13EQj1E3eU5jR3VS1UyqLJ8kpsL7eG1KfQjrEPpBQqV7u6YXleSMx9mS5Vt1IjCOYBpz2qoqHpLGr2RVvIgCEUw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 08/22] intel_iommu: declare supported PASID size
Thread-Topic: [PATCH ats_vtd v5 08/22] intel_iommu: declare supported PASID
 size
Thread-Index: AQHatXs86D8amCVVAk2BM7f5OoE+mA==
Date: Mon, 3 Jun 2024 05:59:45 +0000
Message-ID: <20240603055917.18735-9-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 7082c18c-433f-46fd-622e-08dc83925ee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZG0zVmx0aUt2Zno2U0dRdGRUeUZxLzYzM2t1ZC9uc0tleDF6U1Z0LzBETms5?=
 =?utf-8?B?dnJ0SHZiYUs1QTM1Z0NCSGpZWjcrL3JwWUhlMmpBbG5FVHlJVjdiUzRBZzNW?=
 =?utf-8?B?U3RBYzA5TDhpOUtPbTRWeFJ6bVJWek5WeGxxVUVwTTh5U2pSRmd2dXIyd2Uy?=
 =?utf-8?B?MmlySElDUkVjYWZ6VWVJYUQzbVpucEVDZGU4S01sUSszeDZvRXJJOW0zc2ND?=
 =?utf-8?B?ZmRNS3BhVUR2ekF4OHRHeEgwSmE3WW9UMUQvQXhpb1RmWHVoWjR2ZVAvcWFH?=
 =?utf-8?B?ZDB1UWxocTNKMVFaeXFWRnJXRnFvaHRUU0hNYTlEZHBrZG5YK296Rk5DK2JQ?=
 =?utf-8?B?bWJpS01vdTl4cVkwd3doNzF4K2xCWU9oNlRySXFjbGY2aFBDaERNZmF4MStI?=
 =?utf-8?B?c3JUTGVaKytsU2h1WCtDZ0hSSWkrVlNsaUdHZ1JVUE1MUFhPb244VVFXeWVR?=
 =?utf-8?B?VTlZY0ZKVS9DZnVkTDVkcGd0U1QxUXd3ZmJDN083RDhScEs5ZFYvd2l6ZU83?=
 =?utf-8?B?UTEyaWltN0J0WVB2MTdMOS9ZaVUzU0xqRURRSGdSQ08ybkhnZXdlZVYzNXow?=
 =?utf-8?B?dG15SXlaZHZwbzlRQmVtM3BrKzJ3ODc5aVNTbTFFM0hUTlRZTVlKYWlUcE9G?=
 =?utf-8?B?TWRNZ1V5ZTRHNWdDdDBjdmRwLy9KL1k0bnBtTkpDRTdpY21MOUNKVFowZ2ZM?=
 =?utf-8?B?dVJ1THZSa2JZQ0wycEFIdk53aXNQZUo2MngrU0w2cVlyQ29JWEhLQXAzNldE?=
 =?utf-8?B?L3RTUElTWnA5M2NKVGMwVHJFbEZCQkIxWHZlcGtnR2xiUDZKYkYvQXFwVTZx?=
 =?utf-8?B?WDZyQUdvV25CQ1ZCWHZEdmVmK1FNOEFNOHV2YkFkeG9IZzBoRFo0dXJxZmJI?=
 =?utf-8?B?OE9OalZ5UW1qYXNnRStSb0tUZFNUcjl2QmoyN0wvbVJyMzZZVEsvcFM0S2lJ?=
 =?utf-8?B?S1VxVTA2WjJSaWlOV2p2MW5Lc0JqYm1XcmxraW1EZm5XSzFDMWRiUWl4S3ZP?=
 =?utf-8?B?blgySE5rSy9Gb2tYQi9PSUJYanNUTmZ1K0xtMXhrckxDTnFSVzM5ZTMyTER2?=
 =?utf-8?B?aHRObG1TR1dQSXZreW5xZldIdzYyR2JrQ3pVSW9CYmNnZjhqakttS1JXTjZY?=
 =?utf-8?B?ejdVNjdrZ2FGSDlML2UrWlBtV295YlVLaVUyaHkvN3V2MmxiemtLd2RLaVVG?=
 =?utf-8?B?U0t4enNFRFJUUlpIWllIcVlaa2Qwa2k2VmtVNE51NGpXN3RjUzlNZTZpaDhK?=
 =?utf-8?B?NzBHbmxtcGtZQ0xORXA5QkJXR2lpZC96MTF1MzFQdm94TkhGWElnVTFibTVV?=
 =?utf-8?B?QlFjZ3k1aC9rc2xGQ2c5Wm80WHhoWkVIdGZadG95d0R6SGhPbHYvelF0QjFu?=
 =?utf-8?B?TS9HTGpkeW92MmFTUWtaMDFaZmE5N3NrR2tCaDJHaGxoVmNCU3YySituU1A2?=
 =?utf-8?B?aVA3L0dXTjQvWEVBYjZXcEwyMVJoWi95KzhwYld6b2pqbk51NDg0dG9JOWpR?=
 =?utf-8?B?N3U4enpGNFd0WDNZZEtsTThxWEZjNlhqekREelNyMEZneEZtaVZZUUJ0VzdH?=
 =?utf-8?B?UmVuVDhkRnhvVEYyKzNzTXBZaktMMTZISnNoZmJGWWV0cXVMazF3OFVIb0xF?=
 =?utf-8?B?NnF4MWV2T0ozRGZnNDRuY2VMd1JxVHp5ZWJWVHJULzRUa0Yza3owY0NyQjYv?=
 =?utf-8?B?T3phaFpZZStUYTNNTXRucUxlaklrbThJc3dWaGQxZlZjRE1uYithSGFTQ3BT?=
 =?utf-8?B?b1ZKNlRFMmhyWG1DL0pOU1RyMk8xV3VMc3RVVTZFQU41SE9NSUliV1U0eDFP?=
 =?utf-8?B?Vjc2TEpuUEFORGk1dzJKQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cElmenA5R0QvcjRMb05NSU1kOWx5N0xGc1ZQb2JKQ3BEWnJtbktoZGFTTFlP?=
 =?utf-8?B?RkZjRGU0cVVYL2dnNk5YM1htaklvV2tZYkFGWlFQcXNBbkVNalgrSEtxN2s0?=
 =?utf-8?B?bXc5RXVrVDY5aWdoeThUOEpkVEtPaFBMTEhOem0rbmUzSWFWaVpsVlRGUTdF?=
 =?utf-8?B?WHh1N1FyZWdVMWl3blh5UjNSK2djT09oZHRSRXpXd2thZUx3WkJKQm11QWR4?=
 =?utf-8?B?V0hyZXFHMmx4TUU3cmhCb1Y5YW9KVmdsVUFMTHQwNnNnMkZVZ05SSXI0ZmJO?=
 =?utf-8?B?Qjk4RUd1MFJieUJNR3d4K3MxaGN2NjRzbFpSdnlUNkUvcFgxNDJxcXJSRkV4?=
 =?utf-8?B?TGxnNXpCZ0hCbmoxWGN5L1BrZFFYZHY1djFnVS9nWXJaVTNwM3RLVVQ5bTRE?=
 =?utf-8?B?N003Sndtb1htTGoralFiYitSZ2lFU0ZBTDVDTHBSbXhDdWZSYUFBeUJLaW16?=
 =?utf-8?B?QWlxdW5OSkdXYkQxU1lOUFIrc3M3Y0tRdWJ3emIrTXpGdjBqV09NRDU2SXNU?=
 =?utf-8?B?R2tBKzU4NTVSek9JUmd1bkh5RUFVWnNqQVlrS01lNWI3QitoejcybG9uQS9m?=
 =?utf-8?B?QnRHY2pCZUxRc3prZjNLcXdwQkxkOGs5UENJM2N3OFFyWTZ3dXhFNkJJWUs5?=
 =?utf-8?B?NVBKZXNZcS8yYWRqSDUvU0w2WWVlTEx3Z2pJdVZiQ0ZiWVRZODl5clZMSmFk?=
 =?utf-8?B?ZjQ2citkL0c2THByTlhSL0l1OCtteFNYOHJXQ09YSkdUbE9qN3I0NmFoaTMz?=
 =?utf-8?B?NmR4NjF5L0l6WkZUNDZndHRpM1A4NU0wR3VPdWlpbG54aWxWRlNkS1cxcXNJ?=
 =?utf-8?B?N0NYelk4UFQyR21DZFNrU2U0NXg5RFBrRkg1N045QndEWjc3SUhYd3FTTDBp?=
 =?utf-8?B?c21lWFYyUkU4NzlYb2xmL1lPMmsyWllkOVd4c0kwY0xVcER4SVVLeDRLdGlQ?=
 =?utf-8?B?dHMxSnQ0QWR4d0lJcTYrOHNtMkc0UkVYZzEyR0cxblEySVhReHlWRGRYVzA0?=
 =?utf-8?B?TTlwcUc2UElkdEhkenluWlNWYktJelJTZGdIcGNNTktCdXhXMk9FUDU3ZTVj?=
 =?utf-8?B?c1ZWQWVrUjkwSDhoQkM5TzZsR1hHZGNUZWVFU0tuamhLL3Vva09LTGR0am83?=
 =?utf-8?B?VVlJbWI2MllnRUVCejJCSThUQlBoQXFHUENQK2Y0Z0VWcDdkbVhUTjRyNFpp?=
 =?utf-8?B?UEYyVjdaY2ZBb0swYk5SNlllNE1CU2VYTGREOTFuNmxhd0FuVlFOT29zTitw?=
 =?utf-8?B?bXpLY0l4dnVNRCsxcVVYbm1jUDl1enl2Tld0b1h2eHFHUzJMOFNrZHpaaFpV?=
 =?utf-8?B?dWw4VVFDRUIvU2ZmcnhrZHNGcndmWkxmV016SStUVmwyUVRKZStCOTVlL3k2?=
 =?utf-8?B?R1NraEdIQ2h2V1RrZndhenVWdldnMTY0SnFyNmp3aEE5RDc5WGxYTmtWSzZ6?=
 =?utf-8?B?Snc5d1hQUVFDbGVDTmFvc3ljYTRiV0NHdm1OUmoxTURDRGQzczdyQjhhcExR?=
 =?utf-8?B?VTA0NEFhaU4rY2xVOFBreU4zYk4wMnNoa3dhaUNhRkMxTEZLbXlvcTNaOVBi?=
 =?utf-8?B?QTh4Uk84Y2g2NENsVVZvcHc3b3dKY1VzdTFDR0Nvb0dCRHg5UW1TeWNlcDJX?=
 =?utf-8?B?NVNydndTVmpteUkvRmtPZU9pN3laK08ycW1iOXkvWVUzZktlbGgxNEVUT3lB?=
 =?utf-8?B?OEgrSnNuczd4M1IrQk9McWlFRmYrd0xtV29FZktKS0JHbDRQdjV0ZUJURlNx?=
 =?utf-8?B?cWgvRXFzMEs2SmdrWUlVbU90RUo0Y055K3lXdVZUZVZEVHg3aElhdHZXQXl3?=
 =?utf-8?B?aGN4QWdtbDc2M3BMYjZaNEpOK2ZteHFpRmw0SDVrOVcrSjBPTW1oaFROL3Zs?=
 =?utf-8?B?anppNG0zMmlwTUlBWEd5MG14ZlUvWkZxQUhqNE90RmEybzJNekZBbFNGRk1F?=
 =?utf-8?B?Z0Zqa1ZrZVRUUUowZHZKelpvQVp1LzVMd3FpZDc5NXJ5M3czRnNyekxhTk44?=
 =?utf-8?B?alNJTGhENi9TdEVsLzY3aHZIdi9UdWFPZkJpT3JUZW1TT1FyRFpvcEJGM3pM?=
 =?utf-8?B?VTRhbnR1YjNOajRyL0Q1T0pZb2tlOFlLNWpvb0hzRWRFaTlzTUcvY0dRUHUv?=
 =?utf-8?B?SnVhQzFOald2RkliWWNyZS9oNmxjS2QrYU1qTzJZajI3VjBSWnN2V3lEUEpQ?=
 =?utf-8?Q?QhV5k0O19e2/KALzNW81Jwc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D0B3D6B2160FD4EA6A9FF6316759583@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7082c18c-433f-46fd-622e-08dc83925ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:45.9895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSPP8xNVXPqE0FxVxWhOhXNoJpmOimUfgMzU146D3MTig2NKoLA5kLnABt9olyR3YoTR1fhHO0LEbnD1a32rhb3x58iZxBmBmxg19vJQ3rzGTmBR/TN11aEh2WbLWKEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgMiArLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEgKw0KIDIg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4
IDdiMGMyMmZjMDcuLmZiNmM3ZDFlMzMgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTU4MzgsNyArNTgzOCw3IEBAIHN0
YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQogICAgIH0NCiANCiAg
ICAgaWYgKHMtPnBhc2lkKSB7DQotICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEOw0K
KyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9QQVNJRCB8IFZURF9FQ0FQX1BTUzsNCiAgICAg
fQ0KIH0NCiANCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGM5YTY3MzU4NWYuLjFiMGQ4OTU4
YWQgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTE5NCw2ICsxOTQsNyBAQA0KICNkZWZp
bmUgVlREX0VDQVBfTUhNViAgICAgICAgICAgICAgICgxNVVMTCA8PCAyMCkNCiAjZGVmaW5lIFZU
RF9FQ0FQX05FU1QgICAgICAgICAgICAgICAoMVVMTCA8PCAyNikNCiAjZGVmaW5lIFZURF9FQ0FQ
X1NSUyAgICAgICAgICAgICAgICAoMVVMTCA8PCAzMSkNCisjZGVmaW5lIFZURF9FQ0FQX1BTUyAg
ICAgICAgICAgICAgICAoMTlVTEwgPDwgMzUpDQogI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAg
ICAgICAgICAgKDFVTEwgPDwgNDApDQogI2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAg
ICAgKDFVTEwgPDwgNDMpDQogI2RlZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDYpDQotLSANCjIuNDUuMQ0K

