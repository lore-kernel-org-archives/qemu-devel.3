Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B49D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsH4-0004Yl-DE; Wed, 17 Dec 2025 09:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vVsH0-0004YG-7J
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:13:02 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vVsGw-0000L6-G2
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1765980778; x=1797516778;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Vat5mCjOYrbUsCY3rGNs5wsE/sMVS/1Ng+wMk25eNDU=;
 b=IW2h8L3rX+4qerlxel7kXlDvUbLh1yRhl8nTCI/hzLVA5rTc3/AInM8O
 R03/SubSdtLPSSR3JBapaRhsGgy0CYGF5FhnoiMqV04//4oLhdNCs1Um3
 gL4xwJGzHDm0NnSjfAeO8lAiEDM+dYBk0zvrr1Awodb9lgkeP9i9wLydI
 W1PDM6gP3c+46Rk6bQuMBgf9Y4EnN87zSFPlA7HlsDMJEgDpPom7GeIJn
 oqtfK1shdNsBxdzsQUqEatmaQOvrczKf8Kl2ziz/EEMEHmDLvL9Uj4tM7
 7ywg7OR6npb30lE0sayYOdYH3+tVW3OERTP9iihp8+pfWv09rBZGbop3d A==;
X-CSE-ConnectionGUID: q3WmpBrHQ1Oew1NBkmJIpg==
X-CSE-MsgGUID: FfgOiKvbQYmGz6C8PCDoWQ==
X-IronPort-AV: E=Sophos;i="6.21,155,1763420400"; d="scan'208";a="45354994"
X-MGA-submission: =?us-ascii?q?MDEZTA6iooMAlaGMMPFhu4z3MQscYzav0WNMvy?=
 =?us-ascii?q?3DFTU9mR6AqPrFu7GvQTRr4dp4SGo0mKuAWfOPgQGM3yAxlsQ3K3UfL5?=
 =?us-ascii?q?ZfMSXFo3LwzMd+FTrspbDMZ/K8AUpdSz6O8MFk5Wm0Cu9+wql76sfwE+?=
 =?us-ascii?q?kQkhpWcEKTuS5HQrVY7ywfHA=3D=3D?=
Received: from mail-westeuropeazon11010034.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.34])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Dec 2025 15:12:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do4WmNVaMo5xiyCzgJjcjFeqP16IOkT12U5yYq4GcMZuc6Zg9bH0PAIWnnAu7tZsqMvL2h2iRuA1KJsy1CCEmdrHsrHYVe3lr2H9HEr7Kf4fd1XElHw2CAQL7+JtjJ4F7RfKID68NtJxDbKagYb3bfCqMNSzF86vsI3h0JUG+ofDqASkUN+4HznfUEDhHDzqFrgRm2O1S7Ga4tyn+GXrk+IHMQlpI5vHUIaF8rSvWfBLwcawhqefoo0AQa8E4MSaq16tjxVttMahrgvuLoh6kTQeboZsSp6nB/sFqxE8jKpuIV1PUJW5uc+Tn+T3rr5w+iICfWXtpHnCxbpi5evPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vat5mCjOYrbUsCY3rGNs5wsE/sMVS/1Ng+wMk25eNDU=;
 b=U1HNWUWc5bkcMIrg5Ri/oVTvQ9A3TGf6OqtrFvficlryWkNAKWKhf6CvGM+rPXE/LsqoQB5BITmRWYuu/jWIXzSDZFSIMX7KU44KyIZ/K/GPUWcT/1Eb9U5VWf2R59jwai5DjXri2SUR92t30yX3KB79AVstUYb8Jv8g/tjhxanx+CRTO8JM2cqYusFMFcEKXEpYue0TfL8/IECB1Q4KPiyVKvdxwhhXGmfr+Nixn+rn+Zyu6pub3IOaOCGPXxrcWbh2jqyFGiTVPvcATINlh82bo4XNEPEGcnSHdFmaec62DktXr4gLQfrnGO3NcHlzNBiixZPMNgcxOFU5ca397Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vat5mCjOYrbUsCY3rGNs5wsE/sMVS/1Ng+wMk25eNDU=;
 b=W6Jd/kjOH24OjnpG6A0XLgTWIlI1aWDBFxUPi6J6xXA1dKzXqVd2Gczr2l3fl3mOM+UyL91BJNd72Cgn7BdiKwkKVxS7slNfXt56P/mB7y6bQxs2XbsEHv44OXLv/3BHzrIah0jJJUKYGX/GQ6ov7HpLBO7BWR7hZMJ0T/ZOZDr0pkq4IFLYpOZQ7Xh1QOC6zPWnp4S5wGDCkeGsQy5yhBBjdX7T7xZWRxqQbeBdsakv7xrlhsnEhYWBRhTU5VBtZeOinjJJ92CfBtfsJa3ta6/yWIJ+GSPAE9u5Tw6Ki9lM8YuYfiOfayHHutIJGYUZEjGJusrDfBKqPTiAPPJQXg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB11672.eurprd07.prod.outlook.com (2603:10a6:20b:741::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:12:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:12:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, tugouxp
 <13824125580@163.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael S.Tsirkin
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: How do  i know which "iommu" i used on VM? qemu emulated or
 hardware DMAR?
Thread-Topic: How do  i know which "iommu" i used on VM? qemu emulated or
 hardware DMAR?
Thread-Index: AQHcb0voyjL1Js8EX0qgMTM0yvYSjrUl38yA
Date: Wed, 17 Dec 2025 14:12:47 +0000
Message-ID: <8cb142e6b6bef3bdfd8329322a4a9b5d5921b001.camel@eviden.com>
References: <e29aa4d.52b4.19b2a89a442.Coremail.13824125580@163.com>
 <87ecot2uj2.fsf@draig.linaro.org>
In-Reply-To: <87ecot2uj2.fsf@draig.linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB11672:EE_
x-ms-office365-filtering-correlation-id: ce1d2b06-ce0e-41df-2939-08de3d765add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S1VVRXBqTVgxNTRqMndyWGNLWERrem9qb1JTeVZMN25HTTBLOTdNelNQQTEr?=
 =?utf-8?B?UXFaNUdIc000QUhCL00rTXRrQithRzVDUG9VTEFxRGdDRmFyRU5kQXpPS0t2?=
 =?utf-8?B?NGtGTk4rV1c4VlN3QTFLSkpCWnp0bVpJWWFZSEo5KzNFOWJrWnVIbXowOU1x?=
 =?utf-8?B?QnRDSGI4NnJqL1ViZDFITGg5UXlYRjBsUlkyKzAweXMxQmk1NXZ5bDJyN3F2?=
 =?utf-8?B?OVprS2k5REFZT0F2ZlZtSTNOT0hCd0ovTUk3eGExYnV2L0xtSHpnVGlQekNv?=
 =?utf-8?B?a0JmR0hpZ3FlUm81ZmQ1OHFDTFpxMHNZc2RlUHhsZmRvNFN0ZkhDUW9yU09L?=
 =?utf-8?B?UFRlQ3dBTDF2K3FUVlllMXhESitQUzdjZGVoakg4czIreHQ3aEZMWHZWUjM0?=
 =?utf-8?B?SDF0Mmg0c2xjcWtnbnI3azQzMjhINmV0dUorQnB1Qk1ITHZQTzcrVTJZT1pE?=
 =?utf-8?B?S2xpTzhuc3pPUGlPTmVPSUxwSHk5KzU4dllCckZvMGRmRUIvcGlmYmtmU1Ur?=
 =?utf-8?B?T05ZSE5XaDI4S3oybUpjRWNncnRUMlFxckphVUdaTGo4dXpKWHBTV2dja0Vi?=
 =?utf-8?B?a2VNemI3S1BOOUNNTnUzMHlxdFlGZGFmcUQxT2RoSWpkNk8yOGNHbmIzSjZy?=
 =?utf-8?B?MXUra0VNZ3NOMkQ3NGFkVUZQaHhqNGtneDVXRURlWGhIVzdVYUcxdjhkd0Vj?=
 =?utf-8?B?cFlSYUJ1ZHk1MXowL1F6NVFEc3FRYWY2Q3R3ZW1xLzZsanRjSU1vM2pxQ3JW?=
 =?utf-8?B?eWtJMUtKQ3E3bHBjcXcwWFJNZ1BwWDR2R2FHY09hbjVNVlBEWjRETTdCR2pZ?=
 =?utf-8?B?RzR3cEdvT3ZNSjhSWWJsYmRuR29uMWxpQ0lKaTZ4bTZHOFFCR1JBczlLZlp4?=
 =?utf-8?B?US91Z1JZbkpQV1NpTm9QaW05eitUa2xDdjY2eFBTUklmN3pBdjN4Y3cyMXIw?=
 =?utf-8?B?M1JEbEVhSUd6VzZ4MUdOcW4rY1hiTmw2bm1nZFA5RlJFUHQ3TVFsb1NnVmdN?=
 =?utf-8?B?UDFaOWcwa3gvdUVWV0tUWVNOU09SMlI1Z05oY0hZbTZ4MFhINE5ta0xBZFBy?=
 =?utf-8?B?N2Ywc2Iyd2tvemYxRzduRDJMVFdlblFhdm5IcEtmalFQRjVzVEMrbXhBVm1G?=
 =?utf-8?B?Qm1nNnMwbzVkeXZPMnVPSzFUOTlMS0VPa2d5REg0R2VtZ3kyTVh2WkVkaWJj?=
 =?utf-8?B?NlpPOVJkRFo2WDkyUWRMdEEzMlhDK0hYUHpMajNXbmg0anA1aEFKV2FMOUtx?=
 =?utf-8?B?aUtiY1BwSngvVm12TFdVczVyZEQvamtWbjBPMTd6MytvcXYybXkxTFZlMUJD?=
 =?utf-8?B?Z3paWTluUTFLSjliQUxXL3dNR015ZHdrUkp6Sng1dUo5Ty80eVpzYm82ejIv?=
 =?utf-8?B?NU9ZNjdBd0tpV0NpK0U0M2dNaFE1bTZZeThzR2pZRXdaZ28xcm4xblBXZzc5?=
 =?utf-8?B?cXB6dkl4V3g1Z21QdHF6Ykx2bDZwUHNiRGxucU5JUFU3QUNVQnA5VjNtNkxx?=
 =?utf-8?B?a3VCWWN2Nm5Sc3VtMmtvVUdlamthdEp3cW5NMGRiL2lrUlFtWFZVVDBUbllC?=
 =?utf-8?B?OUZSTVFVaXdWSTF3NDFrVXNHbVJ5anZrdEVxTWFNS0Y2dDdWWkFkenQ0L0o3?=
 =?utf-8?B?c1B0Q1c2b1F5aFAyWGVjQ2lubStNS1ZGaGRpT1MxY3lrcUZIOThuRk5YTlpp?=
 =?utf-8?B?OEl6MHgyczlGRER2aTBGb1A5U0NQVDZGeGpjSXkwcXB4NVRVMTJaYzBNVUU2?=
 =?utf-8?B?MEE5VmlTK3AyZWc5Q2t0UXpZNE9iUWE2MFZ4LzB4T0hSMlI5SXBEa2F5NFlk?=
 =?utf-8?B?bU1OT0lHMUxweGJQMEdiZnpEZVd3RUJ1WXM2T1B0eWgxazdOMHhwNjgrNUtH?=
 =?utf-8?B?OFpGdUtvME1OcGtLZGs5YVlNbzl1bXMydDhUZnllNVFVOW9LclhjQTFEVkt2?=
 =?utf-8?B?WU5WOVZpWVJYWUErU21NaUNxWHpPb3dXcnNaazEyODNRYUF3WnpQVmtzd1k4?=
 =?utf-8?B?MVlBYlZESlBVNVpaL0FqTVNhSlJrTlZzd0wweDBaSWJHTHhSQUpHeUwyOWNJ?=
 =?utf-8?Q?ADYn+N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW5oMVNEdE1GaDRRR2ZYMEVpcWdpcDNmWnpzV0pnWnVyTSt4Kyt2QU5wQlFw?=
 =?utf-8?B?MkkvUktRWjRkbEhJWlRUcG1jTDdVVWdQWGREc01XRVhVcnlDaU11WHFHM2xY?=
 =?utf-8?B?WmhPNFlzSTdPbnZ0aDJTdXgwSW1QVDN6SFo0OEdYTUw5cytPeHBKSDFyQXRz?=
 =?utf-8?B?YkQ2Y2RpcGYyVUFSTitqWUlGK2NLZXI1d01jdy9nOHkvdk44STdFak5iVGRG?=
 =?utf-8?B?a3pPU1FlN0hDYmNmazBUNUszMTlTSEx1Yy9JSHVtRnFjNksrK0VtUVhRcFV3?=
 =?utf-8?B?TjdXak1tOE1LS2JjWXhOY1MzQ3dWeHFUVHRoVHJBS3FwbkhnWnFUVUZLYmdJ?=
 =?utf-8?B?Q0xtdjFwaVhnZnpLUWZvWVdNcFpOQm4vRm5pd1h2b1ZIUUkveEZkRTVUaFI0?=
 =?utf-8?B?enFJK0NqSEFXYkY1NTNKTkswTFRDY2hzMG5TUVgzaW9hck9LZHVkWCtEbGxD?=
 =?utf-8?B?Z2FQbm54QkpoRVRJUEwyQXlIVmZsbTk4OVZ0Mno1OUY5bS9hOElLbm9CWlRq?=
 =?utf-8?B?anVKdWFNY2ltSXlnYmdqdzJsd2JMYno1L3ZJZVRFb2FVTDFnNzhab0lJZHlP?=
 =?utf-8?B?eHdUZE80ZlR3VktqUW1ia2hsZkZ2Q2F2VjRyMlVZaGYwN0htWXNVRUZvNlVk?=
 =?utf-8?B?b2Q0a2hKYzZweGxaVVZ5RzB4SklIOFhaWWtRNWRQOFI1OUxUUDgvdmdTOWhj?=
 =?utf-8?B?RE9ZbmVFMmltT3FMN3FYdFJxYVhmL21yZ3VGUU45dy9rbUpMd01VN0dsNXBy?=
 =?utf-8?B?ZWRzS05OTnBncEVOVWVsV01kalVINHZCYmtjN2toSVJ2b1RMRFpuaS8xeHJM?=
 =?utf-8?B?RWFKQmlSU2kyZTFxQzRkcG10bTZUdnE2aXFVNVZJamdCbVFaTDVtZ0hzWFEr?=
 =?utf-8?B?U3JzeHl3SG9NZ0ZKRXlWT3Z1OGdTTHgveGZPRTVTWi8xZEVsN2pOblBLSC9t?=
 =?utf-8?B?cmY2L0xjTHRLNDNHUGFOdWRjeERUVUpXY3dXcEJkRVduaU5rSHZyUVY3NWo1?=
 =?utf-8?B?clFjMlVrdC9meEVLdHp0U0JoZk5mMFA5R1d0b3IrZFVmSTJoUkExNEF5dHlR?=
 =?utf-8?B?d1BDbFNZR0xoYzBjbzh6aDgvVGgxL3JkMnAyaS85aGdYMUIrZ0QyblYranJx?=
 =?utf-8?B?WGY3Rk5wWjRlRWxlaXBvTGRITkZLRzZqZU12RDEvYnlFRzZhYmU0R1k5MWla?=
 =?utf-8?B?RHgvZ2ZoZzJJKzZ5ZlhjV084aGdvUk1QOG5QMkZvL3UwUlNIdkNQcjd6OXl0?=
 =?utf-8?B?RktNZ0lZcGUxQ2xjbDdpbWNzaUt3QTBaY0dPanBRU1V2TVRqZ0cwbTE0emhx?=
 =?utf-8?B?dU5VWFBJOVdmNUh4K2pSQ3FVY1BjeVA5cWMxR3dFeWk1S2RVUlRZRitNVnhO?=
 =?utf-8?B?RUpxUkxYV1pBRzlybzkvNk95eTJuSEFOcVlydzRSMTJpQllHSjJ3QWtBU0pJ?=
 =?utf-8?B?cmtRalphaURzUXdkUXBpVTlUWk9MbDZOR1pvdUFwNkdkc2psL2hGSEl0NG84?=
 =?utf-8?B?QkpxUStWQkJwRFplcUMrZ3VlWHlNZHp2YnJoc3VtQ245OGNTU2xNMS92Unhu?=
 =?utf-8?B?L290QVpDdFFEb2VMOFNWVS96ZU03UXBJZE9wank3M0MzMjNFODIxMVVEdDhn?=
 =?utf-8?B?UUhIMEQ4UkQ0U1RSaHJJb01VQTB4K3BXYllzS2xOWnp4NGNtVlZzdzJZejZY?=
 =?utf-8?B?TXJVS0JVVEVkTmE0QnpoMnVONXN6WkZaeXJpbHpQWVl0Z3kzSTJyOEZYZ1p4?=
 =?utf-8?B?cUc1TTVZTFl6SURYUUxGeFFnVTg1UXNhTWZTZXdKOXQ1aENCYi9qRkhZQkxL?=
 =?utf-8?B?VndpajRPdHdxZnRYWFZObXkwbUdoaDYxeTRtcEZXOFE4cTNqUUgyNFRGU0FM?=
 =?utf-8?B?aUJkOWhQK243WEppaEZxVkR6UVVuZUs1Z1pVNnM0cGd5K2VETm52QWt3a05O?=
 =?utf-8?B?S0JhUjd0alc4YTQ5R0ZVNS9QZDdCMkRWbzJOR1h0NmxpMFNDRURMZW5jTkJ3?=
 =?utf-8?B?akRTdVRlTEJrdGFGMVNpb25tTk1kaHIzaUh0T2E2emN3Z0VwT3RId0UyZHFa?=
 =?utf-8?B?d1g1eU9Ba09yL244ZVhrejJJa3hGaGE3ZHVHWFRRNjYzWFo0WC91MDlaRlJR?=
 =?utf-8?B?SzNQNWFyQmtNTjZOZThmcjRxNFFXMDdDdTdsbTY2bzM0MmtVdzFyTzNkQWNB?=
 =?utf-8?Q?Jn7yx8LByq6xDQQaSX6HilY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F08B3136A02DC459429FA6AA8E5D3C7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1d2b06-ce0e-41df-2939-08de3d765add
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 14:12:47.3040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ccgqr4TclclcMmHeIEvAu99mZ1eR2AwLUQqGf6yB3w0oUdYG2/r0fezBkCqRYsR6GFC6o87PZj2l5p/IPNOOwy0lA84RIewYMlsS0mKQq9sgr+VSOD3zYx5H/Asd86Fo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11672
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

DQpPbiBXZWQsIDIwMjUtMTItMTcgYXQgMTE6NTQgKzAwMDAsIEFsZXggQmVubsOpZSB3cm90ZToN
Cj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNs
aWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFu
ZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IHR1Z291eHAgPFsxMzgy
NDEyNTU4MEAxNjMuY29tXShtYWlsdG86MTM4MjQxMjU1ODBAMTYzLmNvbSk+IHdyaXRlczoNCj4g
DQo+IChJJ2xsIHByZWZhY2UgdGhpcyB3aXRoIG15IG5vdC1hbi1leHBlcnQgaGF0IG9uLCBhZGRp
bmcgc29tZSBpb21tdSAgDQo+IG1haW50YWluZXJzIHRvIHRoZSBDQyB3aG8gbWlnaHQgY29ycmVj
dCBteSByYW1ibGluZ3MpDQo+IA0KPiANCj4gPiBIaSBmb2xrczoNCj4gPiDCoCBIZWxsbyBldmVy
eW9uZSwgSSBoYXZlIGEgZmV3IHF1ZXN0aW9ucyByZWdhcmRpbmcgdGhlIFFFTVUgZGV2aWNlIHBh
c3N0aHJvdWdoIGZlYXR1cmUgdGhhdCBJ4oCZZCBsaWtlIHRvIGFzayBmb3IgaGVscCB3aXRoLg0K
PiA+IA0KPiA+IEJvdGggbXkgSE9TVCBPUyBhbmQgR1VFU1QgT1MgYXJlIHJ1bm5pbmcgVWJ1bnR1
IDIwLjQuNi4gSSBwYXNzZWQgdGhyb3VnaCBhIGRlZGljYXRlZCBOVklESUEgTVgyNTAgR1BVIGZy
b20gdGhlIEhPU1QgdG8gdGhlDQo+ID4gR1VFU1QgT1MuIE9uIHRoZSBIT1NULCBJIGluc3RhbGxl
ZCB0aGUgVkZJTy1QQ0kgZHJpdmVyIGZvciBwYXNzdGhyb3VnaCwgd2hpbGUgdGhlIEdVRVNUIE9T
IHVzZXMgdGhlIGRlZmF1bHQgTm91dmVhdSBkcml2ZXIgZnJvbQ0KPiA+IFVidW50dSAyMC40LjYu
IEkgYWxzbyBlbmFibGVkIElPTU1VIGluIHRoZSBHVUVTVCBPUyBhbmQgY2hlY2tlZCB0aGUgSU9N
TVUgZ3JvdXAgbGF5b3V0IGZyb20NCj4gPiBzeXNmcyIvc3lzL2tlcm5lbC9pb21tdV9ncm91cC94
eHh4L3R5cGUiLiBUaGUgcGFzc3Rocm91Z2ggTVgyNTAgb3BlcmF0ZXMgaW4g4oCcRE1B4oCdIHRy
YW5zbGF0aW9uIG1vZGUsd2hpY2ggbWVhbnMgdGhlIHRyYW5zbGF0aW9uDQo+ID4gcmVhbGx5IHdv
cmsuIFRoYW5rcyB0byB5b3VyIGV4Y2VsbGVudCB3b3JrLCB0aGUgc2V0dXAgcHJvY2VzcyB3ZW50
IHNtb290aGx5IGFuZCBldmVyeXRoaW5nIHJ1bnMgd2VsbC4gSG93ZXZlciwgSSBoYXZlIGEgY291
cGxlIG9mDQo+ID4gcXVlc3Rpb25zOg0KPiA+IA0KPiA+IDEgSXMgdGhlIElPTU1VIChETUFSKSBp
biB0aGUgR1VFU1QgT1MgZW11bGF0ZWQgYnkgUUVNVSwgb3IgZG9lcyBpdA0KPiA+IHNoYXJlIHRo
ZSBzYW1lIElPTU1VIGFzIHRoZSBIT1NUIE9TPw0KPiANCj4gDQo+IEdlbmVyYWxseSB0aGUgZ3Vl
c3QgSU9NTVUgaXMgZW11bGF0ZWQuIFlvdSBkbyBub3Qgd2FudCB0aGUgZ3Vlc3QgdG8gYmUgIA0K
PiBhYmxlIHRvIGRpcmVjdGx5IHByb2dyYW0gdGhlIGhvc3QgSFcgYmVjYXVzZSB0aGF0IHdvdWxk
IG9wZW4gdXAgc2VjdXJpdHkgIA0KPiBpc3N1ZXMuIEhvd2V2ZXIgZm9yIHNpbXBsaWNpdHkgdGhl
IElPTU1VIHByZXNlbnRlZCB0byB0aGUgZ3Vlc3QgaXQgIA0KPiB1c3VhbGx5IHRoZSBzYW1lIGFz
IHRoZSBob3N0IGhhcmR3YXJlIC0gd2hhdGV2ZXIgdGhlIGFyY2hpdGVjdHVyYWxseSAgDQo+IG1h
bmRhdGVkIElPTU1VIGlzLg0KPiANCj4gVGhlcmUgYXJlIGZ1bGx5IHZpcnR1YWwgSU9NTVUncyAo
ZS5nLiB2aXJ0aW8taW9tbXUpIHdoaWNoIGNvbXBsZXRlbHkgIA0KPiBhYnN0cmFjdCB0aGUgaG9z
dCBoYXJkd2FyZSBhd2F5Lg0KPiANCj4gSW4gYm90aCB0aGVzZSBjYXNlcyBpdCBpcyBRRU1VcyBy
ZXNwb25zaWJpbGl0eSB0byB0YWtlIHRoZSBndWVzdCAgDQo+IHByb2dyYW1taW5nIGFuZCBhcHBs
eSB0aG9zZSBjaGFuZ2VzIHRvIHRoZSBob3N0IGhhcmR3YXJlIHRvIGVuc3VyZSB0aGUgIA0KPiBt
YXBwaW5ncyB3b3JrIHByb3Blcmx5Lg0KPiANCj4gVGhlcmUgYXJlIGFsc28gaG9zdCBJT01NVSdz
IHdoaWNoIHZpcnR1YWxpc2Ugc29tZSBvZiB0aGUgaW50ZXJmYWNlcyB0byAgDQo+IHNvIHRoZSBn
dWVzdCBjYW4gZGlyZWN0bHkgcHJvZ3JhbSB0aGVtICh3aXRoaW4gY2VydGFpbiBib3VuZHMpIGZv
ciB0aGVpciAgDQo+IG1hcHBpbmdzLiBJIGhhdmUgbm8gaWRlYSBpZiB0aGUgaW50ZWwtaW9tbXUg
aXMgb25lIG9mIHRoZXNlLg0KPiANCj4gDQo+IA0KPiA+IDIgR2l2ZW4gdGhhdCBib3RoIHRoZSBH
VUVTVCBPUyBhbmQgSE9TVCBPUyBoYXZlIElPTU1VIGVuYWJsZWQsIHdoZW4gdGhlIE1YMjUwIHBl
cmZvcm1zIERNQSwgaXQgc2hvdWxkIGdvIHRocm91Z2ggdHdvLXN0YWdlDQo+ID4gwqBwYWdlIHRh
YmxlIHRyYW5zbGF0aW9u4oCUZmlyc3QgaW4gdGhlIEdVRVNUIE9TIGFuZCB0aGVuIGluIHRoZSBI
T1NUIE9T4oCUd2l0aCBWRklPLVBDSSBhc3Npc3RpbmcgaW4gdGhpcyBwcm9jZXNzLCBjb3JyZWN0
PyBJZiBzbywgYXJlDQo+ID4gwqBib3RoIHN0YWdlcyBoYW5kbGVkIGJ5IGhhcmR3YXJlPyBJIHVu
ZGVyc3RhbmQgdGhhdCB0aGUgc2Vjb25kIHN0YWdlIGlzIGRlZmluaXRlbHkgaGFyZHdhcmUtYXNz
aXN0ZWQsIGJ1dCBJ4oCZbSB1bmNlcnRhaW4gYWJvdXQgdGhlDQo+ID4gwqBmaXJzdCBzdGFnZTog
d2hldGhlciB0aGUgdHJhbnNsYXRpb24gZnJvbSBJT1ZBIHRvIEdQQSAoSVBBKSB3aXRoaW4NCj4g
PiB0aGUgR1VFU1QgT1MgaXMgYWxzbyBoYXJkd2FyZS1hc3Npc3RlZC4NCj4gDQo+IA0KPiBJIHRo
aW5rIHRoaXMgd2lsbCBkZXBlbmQgb24gdGhlIGltcGxlbWVudGF0aW9uIGRldGFpbHMgb2YgdGhl
IHBhcnRpY3VsYXIgIA0KPiBJT01NVS4NCj4gDQo+IFRoZSBndWVzdCB3aWxsIGNyZWF0ZS9tYW5h
Z2UgdGFibGVzIHRvIG1hcCBJT1ZBIC0+IEdQQS4NCj4gDQo+IFRoZXJlIGFyZSB0d28gb3B0aW9u
cyBmb3IgUUVNVSBub3cuDQo+IA0KPiBUaGUgZmlyc3QgaXMgbW9uaXRvciB0aGUgZ3Vlc3QgcGFn
ZSB0YWJsZXMgZm9yIGNoYW5nZXMgYW5kIHRoZW4gY3JlYXRlIGEgIA0KPiBzaGFkb3cgcGFnZSB0
YWJsZSB0aGF0IG1pcnJvcnMgdGhlIGd1ZXN0IGJ1dCBtYXBzIHRoZSBJT1ZBIGRpcmVjdGx5IHRv
ICANCj4gdGhlIGZpbmFsIGhvc3QgcGh5c2ljYWwgYWRkcmVzcyAoSFBBKS4gVGhpcyB3b3VsZCBi
ZSBhIHNpbmdsZSBzdGFnZSAgDQo+IHRyYW5zbGF0aW9uLiBJIHRoaW5rIHRoaXMgaXMgaG93IGlu
dGVsLWlvbW11LGNhY2hpbmctbW9kZT1vbiB3b3Jrcy4NCg0KSW5kZWVkLCBjYWNoaW5nIG1vZGUg
YWxsb3dzIHVzIHRvIHRyYXAgYW5kIGhvb2sgd2hlcmUgbmVlZGVkIHRvIGJ1aWxkIHRoZSBzaGFk
b3cgcGFnZSB0YWJsZS4NCg0KQSBuZXcgbW9kZSBiYXNlZCBvbiBuZXN0ZWQgdHJhbnNsYXRpb24g
aXMgdW5kZXIgZGV2ZWxvcG1lbnQuICANCkkgcmVjb21tZW5kIHJlYWRpbmcgdGhpcyBpZiB5b3Ug
d2FudCBtb3JlIGRldGFpbHM6IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwv
cWVtdS1kZXZlbC8yMDI1LTEyL21zZzAxNzk2Lmh0bWwNCg0KPiANCj4gVGhlIHNlY29uZCBvcHRp
b24gaXMgZm9yIElPTU1VJ3MgdGhhdCBzdXBwb3J0IGEgZnVsbCB0d28tc3RhZ2UgSFcgIA0KPiB0
cmFuc2xhdGlvbiAobXVjaCBpbiB0aGUgc2FtZSB3YXkgYXMgaHlwZXJ2aXNvcnMgaGF2ZSBhIHNl
Y29uZCBzdGFnZSkuICANCj4gVGhlIGluaXRpYWwgbG9va3VwIHdvdWxkIGJlIHZpYSB0aGUgZ3Vl
c3RzIGlvbW11IHRhYmxlIChJT1ZBLT5HUEEpICANCj4gYmVmb3JlIGEgc2Vjb25kIHN0YWdlIGNv
bnRyb2xsZWQgYnkgdGhlIGhvc3Qgd291bGQgbWFwIHRvIHRoZSBmaW5hbCAgDQo+IGFkZHJlc3Mg
KEdQQS0+SFBBKS4gSSB0aGluayB0d28gc3RhZ2UgSU9NTVUncyBhcmUgYSByZXF1aXJlbWVudCBp
ZiB5b3UgIA0KPiBhcmUgaGFuZGxpbmcgbmVzdGVkIFZNcy4NCj4gDQo+IA0KPiA+IFRob3NlIGFy
ZSBteSB0d28gcXVlc3Rpb25zLiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAhDQo+
ID4gc29tZSBpbmZvcm1hdGlvbiBhYm91dCBteSBlbnY6DQo+ID4gDQo+ID4gMSBRZW11IExhdW5j
aCBWTSBjb21tYW5kOsKgwqDCoCBxZW11LXN5c3RlbS14ODZfNjQgLWNwdSBxZW11NjQsK210cnIs
K3Nzc2UzLHNzZTQuMSwrc3NlNC4yIC1tIDQwOTYgLXNtcCA0IC0tZW5hYmxlLWt2bSAtDQo+ID4g
wqBkcml2ZSBmaWxlPS4vdGVzdC12bS0xLnFjb3cyLGlmPXZpcnRpbyAtbWFjaGluZSBxMzUsa2Vy
bmVsLWlycWNoaXA9c3BsaXQgLWRldmljZSBpbnRlbC1pb21tdSxpbnRyZW1hcD1vbixjYWNoaW5n
LW1vZGU9b24gLQ0KPiA+IMKgZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDI6MDAuMA0KPiA+IDIgdm1z
QHZtcy1TdGFuZGFyZC1QQy1pNDQwRlgtUElJWC0xOTk2Oi9zeXMvY2xhc3MvaW9tbXUvZG1hcjAv
ZGV2aWNlcyQgbHMNCj4gPiAwMDAwOjAwOjAwLjDCoCAwMDAwOjAwOjAxLjDCoCAwMDAwOjAwOjAy
LjDCoCAwMDAwOjAwOjAzLjDCoCAwMDAwOjAwOjA0LjDCoCAwMDAwOjAwOjFmLjDCoCAwMDAwOjAw
OjFmLjLCoCAwMDAwOjAwOjFmLjMNCj4gPiB2bXNAdm1zLVN0YW5kYXJkLVBDLWk0NDBGWC1QSUlY
LTE5OTY6L3N5cy9jbGFzcy9pb21tdS9kbWFyMC9kZXZpY2VzJCBsc3BjaQ0KPiA+IDAwOjAwLjAg
SG9zdCBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIDgyRzMzL0czMS9QMzUvUDMxIEV4cHJlc3Mg
RFJBTSBDb250cm9sbGVyDQo+ID4gMDA6MDEuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBE
ZXZpY2UgMTIzNDoxMTExIChyZXYgMDIpDQo+ID4gMDA6MDIuMCBFdGhlcm5ldCBjb250cm9sbGVy
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjU3NEwgR2lnYWJpdCBOZXR3b3JrIENvbm5lY3Rpb24NCj4g
PiAwMDowMy4wIDNEIGNvbnRyb2xsZXI6IE5WSURJQSBDb3Jwb3JhdGlvbiBHUDEwOE0gW0dlRm9y
Y2UgTVgyNTBdIChyZXYgYTEpDQo+ID4gMDA6MDQuMCBTQ1NJIHN0b3JhZ2UgY29udHJvbGxlcjog
UmVkIEhhdCwgSW5jLiBWaXJ0aW8gYmxvY2sgZGV2aWNlDQo+ID4gMDA6MWYuMCBJU0EgYnJpZGdl
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUlCIChJQ0g5KSBMUEMgSW50ZXJmYWNlIENvbnRyb2xs
ZXIgKHJldiAwMikNCj4gPiAwMDoxZi4yIFNBVEEgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRp
b24gODI4MDFJUi9JTy9JSCAoSUNIOVIvRE8vREgpIDYgcG9ydCBTQVRBIENvbnRyb2xsZXIgW0FI
Q0kgbW9kZV0gKHJldiAwMikNCj4gPiAwMDoxZi4zIFNNQnVzOiBJbnRlbCBDb3Jwb3JhdGlvbiA4
MjgwMUkgKElDSDkgRmFtaWx5KSBTTUJ1cyBDb250cm9sbGVyIChyZXYgMDIpDQo+ID4gdm1zQHZt
cy1TdGFuZGFyZC1QQy1pNDQwRlgtUElJWC0xOTk2Oi9zeXMvY2xhc3MvaW9tbXUvZG1hcjAvZGV2
aWNlcyQgY2F0IC9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8NCj4gPiAwLyAxLyAyLyAzLyA0LyA1
Lw0KPiA+IHZtc0B2bXMtU3RhbmRhcmQtUEMtaTQ0MEZYLVBJSVgtMTk5Njovc3lzL2NsYXNzL2lv
bW11L2RtYXIwL2RldmljZXMkIGNhdCAvc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvKi90eXBlDQo+
ID4gRE1BDQo+ID4gRE1BDQo+ID4gRE1BDQo+ID4gRE1BDQo+ID4gRE1BDQo+ID4gRE1BDQo+ID4g
dm1zQHZtcy1TdGFuZGFyZC1QQy1pNDQwRlgtUElJWC0xOTk2Oi9zeXMvY2xhc3MvaW9tbXUvZG1h
cjAvZGV2aWNlcw0KPiA+IA0KPiA+IEJScw0KPiA+IHpsYw0KPiANCj4gDQo+IC0tICANCj4gQWxl
eCBCZW5uw6llICANCj4gVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJv

