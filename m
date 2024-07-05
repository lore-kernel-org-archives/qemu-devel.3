Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3175C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPbGU-0006FO-Kp; Fri, 05 Jul 2024 01:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPbGK-0006EY-5G
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:13:37 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPbGH-0007EZ-Px
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720156413; x=1751692413;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MSkKDVJCpXK9+YAAVpOCOBIuLEdFmoV4Kw8SryHi7BY=;
 b=ql7VcYGGvpgthxl3C4XrGJhoL8JjccBWR4D4IKJVdnOUe/ZIpYdsva3v
 jdaZ7YHOc4bhS/ik1eTk6ik+h9W3RuA3Amj3z1WKsFkH2jNYWf1XMZNu6
 3g5RVBTHKI8OJfK83At/ilnRtjVga5ZzJFb8GoPzlsv7pvCa93DVVdPkb
 QufXAa8qKPbEXcMw6iJkmuqwybhsQwFsEH5W0qoLU4XxFCBrwl+GHIkL7
 SBBk6UXRtUDTwjmXcy6OaP0pFZ39PpWb26WciPNHbEsH7z4Y2LjPujS7e
 2UcYZUDpcoE5zSZW8oxnXWd09iT2p1+p7YVQh/iq7ILlOllpu/VJHWSe8 Q==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="16030612"
X-MGA-submission: =?us-ascii?q?MDHtUwVL+Ty97FBNx+Ob6Lbk4b8CRsgiaXzjow?=
 =?us-ascii?q?+wJ+2bVfFJaW7KY5l5eZ4JHh6uzGMqx12f9j6ADnIrsszdk4JnCQcGPV?=
 =?us-ascii?q?ughPo400CE+3+Yo6Yu5Xv6s5TOE21uYT1qzw8jAuPlC9pDL+QabJoFq7?=
 =?us-ascii?q?s44s0PK0YN8PVfRA/qMLB0oA=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 07:13:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJPwgzhJe068tq/GZ00r8fDGWatj5YhYqjuOPzsUEK21g6mvky8FrwHp4wkV9d3DlTeOV8bHnK7qxNdmhal2zWZnHWkltTn9NUEW65487OHGLnNO2KdLmSwHdoUYF3SERqI9D8DJvFq15XC2tMJMSVZyFvQXwzhbyVA5fr+kzL7azKkJhGoBVjH6hjhQkphP/FvEZyLV9FRgLOMCQDDX1v4s/ZPno+ykPybikLkxqRIBPnVR075r78sBY+wSvwy8vxYWzCqspylu8mJ1x7qwg+1p7HlhHhd7Y6DTCclCPlSCJlHppkCJtH6WQREVqCmfCeCMHGRz1dYE/SDCEz4uJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSkKDVJCpXK9+YAAVpOCOBIuLEdFmoV4Kw8SryHi7BY=;
 b=HsvTxhbrw5mLtO/rt61LcXjKSEDV5FAJPHDITlYNpzLUeNDMKri8koMotvmvCHss2dricPQO9wxWT+zUUrI5zOpT/DB2gktLxi0TiiUTWfTzkmEMm1lIWM/6n5nFb+wlx6txlWFzwsUGj+YphwUYCn1giJHMQeVR77TAe19Oz1ojLP8TiTu5qK68RqeZKaPeYbkvF9Sh4+yK6ltHxbVpw/pcFWkCRVaBq1XTIo5l+T1EdhsJrqAlM5jlNs6HagiEjth44C7OqGh2lz6r39IbdUXSzGSrRuujKpL/sHyFvtOSpIVlPx0YXr5ZgQ9Vfsh+Ftg3LuIiBXZuOaqfShz0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSkKDVJCpXK9+YAAVpOCOBIuLEdFmoV4Kw8SryHi7BY=;
 b=FYRQeZd+H4eIzQsTYSWaQZcrmw8yi69dFJE7q0uknDj5V7ryKmpg8SbQYYTtQTmcolj5IAPf41CqRLXUZdnAVVd90dO95+nMeWPggRVkvPdp27uEPzVmR/oF/9X7ioIMv+XDlRoTGsSvV5W2/DWob2x1Nv/Ktmc1/ChGW37Uw6mP1q3S/QKZj2ZlhBiOwzgSYBVjztuJEDkJOWjaCwgeTsQRCNteUde5mxljnVkR4qxGVkuiqXo7PcNqWKZDcwFaEWPM0mifqwdv7Sz8dkOxlGX+agUgQtQKlNWoyFVVFevJaMxmpNOssF2Ir5UwwCGjGhoVPkX4EWRKuTRF52RNrQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7103.eurprd07.prod.outlook.com (2603:10a6:102:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 05:13:28 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 05:13:28 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
Thread-Topic: [PATCH v1 0/8] PRI support for VT-d
Thread-Index: AQHasoxiO6+dgN7t50iro7G2HPLUFrHnqsIAgAAkSAA=
Date: Fri, 5 Jul 2024 05:13:28 +0000
Message-ID: <a72b873d-9641-47f2-8306-7e9f304037fe@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
 <311d4200-a5a4-418b-bc54-9f2c871235b0@intel.com>
In-Reply-To: <311d4200-a5a4-418b-bc54-9f2c871235b0@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7103:EE_
x-ms-office365-filtering-correlation-id: 8539d846-6ece-4af9-4c00-08dc9cb134cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlB6MDZGaEJLSGR2VGNTUzBTaWhZb1MxZDZlNG50RSs4M2FzcWwrRk9ESHkx?=
 =?utf-8?B?N21peHFONVRFRlZ6OWE0VUwya1Nudm82MFpzeCtQYm40VXlSNG5pWG95RmVD?=
 =?utf-8?B?d00xRlVCME81QTFjV2JQZXY3dWpJZVQvdU5VTXZvZzkvelNSRXdlZDRRN1RQ?=
 =?utf-8?B?bjJXdW51ZjRpQnJVOXllOElnbzV3V0JETHQ5cVlhTmxkYXVtK3hYc3N2S1ZT?=
 =?utf-8?B?RjVXWG1WRUpSYUZvYm9uUWI2ZTlEcWh2aDRBdkdiQW96NHNxN1VUT2dyeWV6?=
 =?utf-8?B?ZWFaT1QvdG1xenBjZTBrOFB2aTZETmFma1FFOGVQZGpVVXJhUU8rclFJSHJs?=
 =?utf-8?B?eVNrMUU2NkN0cFMvWitiMzk1OStHS1EvMDJrM3ZaYnROdEo4bjFvaVByZ2VS?=
 =?utf-8?B?RlJWZzZBNWplZ2YxbWc3WkI4c2RqMHliOTNHSXNKdWhab2RjZWlMY1V3V1Z3?=
 =?utf-8?B?YTByUmhHeDJiTWtPT00yL3FRQ3NjcTVhdVhQM1lQaEJzSnBWSUpZd0t1K0xN?=
 =?utf-8?B?YWhPUWQvc0IvOEQ2UVVuNTdYc05RTkdSTkM5MU96NldsaHBsd2p2bTBQZDJX?=
 =?utf-8?B?cnBrZ3ZZSkoyVXVmTVpzRnNnM0p1TFZoU0orSnY0MUZUUUxoU01BMTVsVDdx?=
 =?utf-8?B?SXNxVkdwMkxvd0liUmduVjNhSzlnOExST0oxR3V6SlpjQkhyakVzNHg4SkJG?=
 =?utf-8?B?R1hyNHBKMjlWMzlmTXU4QXBMWjJMWDc4ckVTYjI1VlVieFJOcFJOaXB6aks3?=
 =?utf-8?B?TEdRVTdZUzlETFBVd2lXU2NSSWc0Yk02NHlKZ0d0V2xPWXdxaGd0bmZjNEVS?=
 =?utf-8?B?NnFMK1JFMzlmcU1ZR0VFS0FaN3oxZGV6NFhHYlMvemRjMzN3Y1RaampibHR0?=
 =?utf-8?B?RmY0SERQOGlKaUx0YmhiWEkxYm1NLzJIQnQwd1JtenFvTHlBam83SjNacTN0?=
 =?utf-8?B?dkZLUEZDcXJ6OS9UWVltY2Q0U3pyS3dTWGtnVDFVdG5XeG54bmx0dEhFZStU?=
 =?utf-8?B?WEFVdk1jVDVqK3NRelcyZ1Y4OGpVVkh5RUwzaHZaVnFuank3YWVUTlFmNjcy?=
 =?utf-8?B?a1dFTGx6UlpHVnBqN3JWMGlUaXUvOUhTSUQ1ekNXUDJsbHNrVTlGWnVObUxW?=
 =?utf-8?B?SnNQdXdqV0ljU2pQZXZYSWNaRVVON05ydzRTbHhDbzNOOFBuOXY5RkppMjIr?=
 =?utf-8?B?cmVvTmQySHhsclRKL1Ixa2xPTDRQenp4aGIwKzRQUkVseHNtYkMrMXZHcnhh?=
 =?utf-8?B?V2Zndk5uNFVab0hXcnoxSjQ1RUlNYjYrUm5vY283TXJkT1h0L2p1NHl0K09G?=
 =?utf-8?B?U1R1VHl0ejJFbzNRN2t1TXNaKzNKS2hvQTFzMXNPZHFCUXhBNHNpNmZTY2k5?=
 =?utf-8?B?bWM1RXJYY3oxSEU3UExDRGRpQ1BzcDdoVUZ3eVNkMXRraHJ5a0tPL29DWHlZ?=
 =?utf-8?B?cTZIcVR3dkJLQ09VSlRZZnFIcjczU24wYVpkTS9UajJHKytid2dUSGRlUldK?=
 =?utf-8?B?M0hjdDF5SlpFMitpRzF1RXN2MTcvYXRjTXoxU3B4emdPSDhQbGQzUEVJcktL?=
 =?utf-8?B?SXZraXVHTFEvQ0V4WFFzbnk5elRQdjFMWTZ1ZzlTRlRacGZlQXgxVFk3K0NF?=
 =?utf-8?B?VnRMK3dOTjJXclRSczdqNkhXVUNkaVBEOGVidk9aMmxJR1N1VmVjQmtBUzN3?=
 =?utf-8?B?SmtINjVFNzRJMGE1WFhDVEFEaWxzQ1VrdFA4TnVLS3FuWWRnQW1kQ2F4ekZN?=
 =?utf-8?B?V0dMRkdSNUxmVjNUaHZtU08ycDc0M3JSTGJveHJ6S2tVd0Z5RktrKzNQQ3JJ?=
 =?utf-8?Q?DzaNdHsVNYdb7YoHvYcx8yC5Cx/BlIYozBwI4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDhaYlhTWVlLN2NJTElrL3JMNEVqMnRJSHlud2N4ZWJyZGVnWU1QWW03NEt2?=
 =?utf-8?B?SUhrWTJHMTNlS0ZCNWpFUU5jVFN2T1JXQXZ1SDI1TjBqRTVlR0hid3FWTnF1?=
 =?utf-8?B?cFJ2bkViZUxrZWltcVV5SUVyMURBZkc2SjU5cDV6UXlGajM0VmhJeURRSXNq?=
 =?utf-8?B?Q1ZTaUVqS1M2c1RqKzk4ek5QOE9iZlF5UnA2S0drMjlzWEtlaCtMeks1M2g5?=
 =?utf-8?B?Mm5RRFlhT2hrU1FYdkw0VjlXdDM5SmZSYzQvSUJxU3BqS2NvS3AwejloOEho?=
 =?utf-8?B?YnVMUTZibUJLWUUveFM5b2RObVp5cUVybUg3RzBHUHFRUFdyZEZwOS9CZ3B3?=
 =?utf-8?B?a29JQkp3RGZGc2VzQ2xYOVUxOW9Ea0dZSnlSWG5PZ0pNY0JHVXhVVlpEMUN2?=
 =?utf-8?B?TTVPaUJBdEw2emVVbkpTNm14Z2pmMm02VUEwZkJKVWFhOEJyZ3c5Rzkwd3Y1?=
 =?utf-8?B?YTVQNk43c0lCNHF3ZUg2Z05Sd3p2SFB6aWN4eXIzR0xkR0I4Zlg5TzZXWTRK?=
 =?utf-8?B?Q1FscXVWM0daQXFGdmlFY0JUdDAvVHZ3U05HNE9pOGpJenYvNHFKQ2duTjdk?=
 =?utf-8?B?WFVMd0lmQSsvRzkzMVdYSkNHdUkxNXMvY1hBWHBBdnIrSk9NK2taSndKYXBY?=
 =?utf-8?B?UE9FenBVbXE5MWpTZExkVnVZb0d1R2hxaGpXV0ozeUlBTWhJSWtQL3laZC9C?=
 =?utf-8?B?OW1Xakd3QzVSLzUybnh4alhNdmJ5UE02SVZFUmNNMzZ0aFRsUmVlVmFvV2NH?=
 =?utf-8?B?WVVWM2NqMXVobnd6U0dqZk1ML1kwT2hrNVRkQmxObnR2MENONm92cW52TURG?=
 =?utf-8?B?RXlKVFZrdk43cDFIMmg5cXBnS0VUeTBDQTlYS1ZiZFBBZFFaZ0hVRTZzY0x4?=
 =?utf-8?B?Ky9wMDNPTlhiOWU2NTNGN0pnQklWNGk4UThLYWxHbkFFWE1UNytEalgwS2xa?=
 =?utf-8?B?dDh0YkxXUjdFWkRYaFVjbGFyR0puanM5QjFtaG1xWGdzclRYdXI3dmNCRG5r?=
 =?utf-8?B?SkpVd0RzV3pkeENYR0dQOEt6cXVacEIrbG14M0dWenlJWXlxSXVzL3F3NHFh?=
 =?utf-8?B?NEFXMVlrMUg5MUc1Um1aOFpPS2pEWFdSSEVKbU5rajk4aG96MVJxVWpPcDNK?=
 =?utf-8?B?ZHlBc08vRkY2VlB3RHRBTjdQVlRHR3RYQ1hYMTNEekVHNFdMWktWY3U3L092?=
 =?utf-8?B?dndzVFFvNHRlZGphL3ZvdE9NcWNZVGNKR0hmUHNDYmpvNDVWREdKcmJlSER1?=
 =?utf-8?B?bXJzVFZBaFg3bUMrU3lVSHU0cXRxMVJBMXUzZWVNNmdTbytKQkdLRDRMbjJO?=
 =?utf-8?B?cmQ1Y1FHaElrN05hWnlsd3B6MFMvRllyRmdDY01lUytuQ0JlOTh1ZGZjZFFu?=
 =?utf-8?B?ZU84V25oelZKb3RCVnVVbUcrT3VPckc3dTMvOW92SG5iZGd0TzFZMmw0NXJU?=
 =?utf-8?B?T2JQNDA3ODd3NlllREVtMDhVbUNYVkNXL0F0Rk9kUEFBdVlCU25vVHhRZkNM?=
 =?utf-8?B?aktTZXBaVlUvNkZsd0lNVGdmUExZSmR6eG1sK1NKT3VYaTM5bjEyNDFmVEtG?=
 =?utf-8?B?MHY3RHR6QVIyalRtT0tDVTludC96cXNrV3RMTVVialZybFJlQU9HQlZJRzVs?=
 =?utf-8?B?bGw4ODhwTSt6eG9ia0xHYldaMER1bk5NYkNhS2JnUVN4RWZRZ1NZdS9Ld3lQ?=
 =?utf-8?B?eEVGcXR4NkhRWHJVeGhXaFc1bk1pYnRWYjN4enJMYzJ5MzhNY2JiZGtQQ2Zs?=
 =?utf-8?B?a1Z1TGZNUDN3WEYwcndwWTZRanF6OVE3YXNHTFJxUzRPWDBwOHp2cGdYQlhC?=
 =?utf-8?B?U0JscmhPU21zUnFsR0tQYVJ1V1hqci9kcUpTYVVMOW1aa0NyT2ExUEpqNFF2?=
 =?utf-8?B?MTk4cEk2QjdwS0NSelk3YU95UEpDSnFqei91U0dFdkd5T2N1ZDArRjFTVVMv?=
 =?utf-8?B?OUZ0L1RLaHM5aDA5M3RWamR2cjJYU0tTVHhUR2VLeHJSa1cvdkFjMmc5Zi9H?=
 =?utf-8?B?SENUZDJvclYzYWZHSXpZUFlNdGZudkhxdURnODdud21RQ2hacWQ1RUN4SlBh?=
 =?utf-8?B?TDREYStTRTh5MGhGeEUvQjR5MkJ3QWJZdEdNUkJJV0ZtZlF1WDZVUCt1bFVh?=
 =?utf-8?B?ME5qQWRWc2ZnSjFUekllNTNxUFplSjFIV1JGQWRlTlRrazEvRlp5V20wekFG?=
 =?utf-8?Q?OxKcQ3EtJnVlRHzITUDyRLA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C89858D2DBF2B145A00A59EFCCFDB5BD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8539d846-6ece-4af9-4c00-08dc9cb134cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 05:13:28.8563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pZXzqQfQnticeAfuga0RYlvuceTpnoaL/fmFOiP3cPnZ/JCq6gQgwUFgb72/UeneXQYWvuVyDmkLSbXGfDYiNuyA+PF3l47TH6svs84mdCJWX2jwhZIN4848HM1LaRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7103
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

DQpPbiAwNS8wNy8yMDI0IDA1OjAzLCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywNCj4gdW5sZXNz
IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNv
bnRlbnQNCj4gaXMgc2FmZS4NCj4NCj4NCj4gT24gMjAyNC81LzMwIDIwOjI0LCBDTEVNRU5UIE1B
VEhJRVUtLURSSUYgd3JvdGU6DQo+PiBUaGlzIHNlcmllcyBiZWxvbmdzIHRvIGEgbGlzdCBvZiBz
ZXJpZXMgdGhhdCBhZGQgU1ZNIHN1cHBvcnQgZm9yIFZULWQuDQo+Pg0KPj4gSGVyZSB3ZSBmb2N1
cyBvbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgUFJJIHN1cHBvcnQgaW4gdGhlIElPTU1VIGFuZA0K
Pj4gb24gYSBQQ0ktbGV2ZWwNCj4+IEFQSSBmb3IgUFJJIHRvIGJlIHVzZWQgYnkgdmlydHVhbCBk
ZXZpY2VzLg0KPj4NCj4+IFRoaXMgd29yayBpcyBiYXNlZCBvbiB0aGUgVlQtZCBzcGVjaWZpY2F0
aW9uIHZlcnNpb24gNC4xIChNYXJjaCAyMDIzKS4NCj4+IEhlcmUgaXMgYSBsaW5rIHRvIGEgR2l0
SHViIHJlcG9zaXRvcnkgd2hlcmUgeW91IGNhbiBmaW5kIHRoZQ0KPj4gZm9sbG93aW5nIGVsZW1l
bnRzIDoNCj4+ICAgICAgLSBRZW11IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZvciBTVk0NCj4+ICAg
ICAgICAgIC0gQVRTDQo+PiAgICAgICAgICAtIFBSSQ0KPj4gICAgICAgICAgLSBEZXZpY2UgSU9U
TEIgaW52YWxpZGF0aW9ucw0KPj4gICAgICAgICAgLSBSZXF1ZXN0cyB3aXRoIGFscmVhZHkgdHJh
bnNsYXRlZCBhZGRyZXNzZXMNCj4+ICAgICAgLSBBIGRlbW8gZGV2aWNlDQo+PiAgICAgIC0gQSBz
aW1wbGUgZHJpdmVyIGZvciB0aGUgZGVtbyBkZXZpY2UNCj4+ICAgICAgLSBBIHVzZXJzcGFjZSBw
cm9ncmFtIChmb3IgdGVzdGluZyBhbmQgZGVtb25zdHJhdGlvbiBwdXJwb3NlcykNCj4NCj4gSSBk
aWRuJ3Qgc2VlIHRoZSBkcmFpbiBQUlEgcmVsYXRlZCBsb2dpY3MgaW4gdGhpcyBzZXJpZXMuIFBs
ZWFzZSBjb25zaWRlcg0KPiBhZGRpbmcgaXQgaW4gbmV4dCB2ZXJzaW9uLiBJdCdzIG5lZWRlZCB3
aGVuIHJlcHVycG9zaW5nIGEgUEFTSUQuDQoNCkhpLA0KDQpBcmUgeW91IHRhbGtpbmcgYWJvdXQg
d2FpdCBkZXNjcmlwdG9ycyB3aXRoIFNXID0gMCwgSUYgPSAwLCBGTiA9IDENCihzZWN0aW9uIDcu
MTAgb2YgVlQtZCk/DQoNCkknbGwgbW92ZSB0aGF0IHRvIHRoZSBQUkkgc2VyaWVzLg0KDQo+DQo+
PiBodHRwczovL2dpdGh1Yi5jb20vQnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0K
Pj4NCj4+DQo+PiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg4KToNCj4+ICAgIHBjaWU6IGFkZCBh
IGhlbHBlciB0byBkZWNsYXJlIHRoZSBQUkkgY2FwYWJpbGl0eSBmb3IgYSBwY2llIGRldmljZQ0K
Pj4gICAgcGNpZTogaGVscGVyIGZ1bmN0aW9ucyB0byBjaGVjayB0byBjaGVjayBpZiBQUkkgaXMg
ZW5hYmxlZA0KPj4gICAgcGNpZTogYWRkIGEgd2F5IHRvIGdldCB0aGUgb3V0c3RhbmRpbmcgcGFn
ZSByZXF1ZXN0IGFsbG9jYXRpb24gKHByaSkNCj4+ICAgICAgZnJvbSB0aGUgY29uZmlnIHNwYWNl
Lg0KPj4gICAgcGNpOiBkZWNsYXJlIHN0cnVjdHVyZXMgYW5kIElPTU1VIG9wZXJhdGlvbiBmb3Ig
UFJJDQo+PiAgICBwY2k6IGFkZCBhIFBDSS1sZXZlbCBBUEkgZm9yIFBSSQ0KPj4gICAgaW50ZWxf
aW9tbXU6IGRlY2xhcmUgUFJJIGNvbnN0YW50cyBhbmQgc3RydWN0dXJlcw0KPj4gICAgaW50ZWxf
aW9tbXU6IGRlY2xhcmUgcmVnaXN0ZXJzIGZvciBQUkkNCj4+ICAgIGludGVsX2lvbW11OiBhZGQg
UFJJIG9wZXJhdGlvbnMgc3VwcG9ydA0KPj4NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgMzAyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgNTQgKysrKystDQo+PiAgIGh3L3BjaS9wY2ku
YyAgICAgICAgICAgICAgICAgICB8ICAzNyArKysrDQo+PiAgIGh3L3BjaS9wY2llLmMgICAgICAg
ICAgICAgICAgICB8ICA0MiArKysrKw0KPj4gICBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggICAgICAg
ICAgfCAgNjUgKysrKysrKw0KPj4gICBpbmNsdWRlL2h3L3BjaS9wY2kuaCAgICAgICAgICAgfCAg
NDUgKysrKysNCj4+ICAgaW5jbHVkZS9ody9wY2kvcGNpX2J1cy5oICAgICAgIHwgICAxICsNCj4+
ICAgaW5jbHVkZS9ody9wY2kvcGNpZS5oICAgICAgICAgIHwgICA3ICstDQo+PiAgIGluY2x1ZGUv
aHcvcGNpL3BjaWVfcmVncy5oICAgICB8ICAgNCArDQo+PiAgIHN5c3RlbS9tZW1vcnkuYyAgICAg
ICAgICAgICAgICB8ICA0OSArKysrKysNCj4+ICAgMTAgZmlsZXMgY2hhbmdlZCwgNjA0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPg0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBZaSBM
aXUNCg==

