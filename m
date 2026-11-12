Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F411606A882
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=ruIeTRw6;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=AZf/4ylf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMZj-0003iv-0c; Wed, 11 Nov 2026 23:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMZg-0003iP-PK; Wed, 11 Nov 2026 23:38:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMZe-0006Gn-Lk; Wed, 11 Nov 2026 23:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794458290; x=1825994290;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TPyvTWt0y+8M5IXXZEdUQUFwWs0vVHLD3dfQ630vP3g=;
 b=ruIeTRw6JkzX3DAVBLJVnx8YC/OavgpQTsAMrUPOTa8r4d4BqQlbK7Vf
 BJmO48/Jg/xKbodKcuUalEfSTpQVrOx1FNirOwFzzVW5c1zsvTZlLO8QG
 FX24o0YnKf/hdGzzWopFOdvY+Bp3TR6LY17aetMuIDoWU3Lr0KKfcCh56
 NMGh4XeE1qVT6X45H74hzIAOmp7nmzy8PKslygri16yh7BTDDx96RWkHf
 bwECRo+1chhiqKxTMz2gj10ZCEGMKm5EMe1U+1ow4/9IK5IpVHh4nnbcz
 yGILAZHaa3WHDqIFFFYI0gHMhXq70M4idee8nMhXD6ssYMT2mMnLquoT3 g==;
X-CSE-ConnectionGUID: A/7/axlyTgivWsd5x25SeQ==
X-CSE-MsgGUID: dejZrJToSiyR+iBgoGuP4w==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="161674370"
Received: from mail-eastusazon11012013.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.13])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:38:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZVuqE6BlVhzjOAKljljHgg583ngCoNzAeIpAYq8dRRUivRzV4RNXkc5ycRUTiBYoz7DWajt4Wk1gRTJI6qXNRpyv3NYKqWTLFccAVdeZAmB0bRcHSeRDoCLfQ9Us46a5SG3d67Zo+LWMAIq/XFiNyb+V0pWc2SFvFWdsCDxeBAdAC2CNhB/gEBDpbfaZt1NWvzEroIbSMpftZjSUIxB3pYn7MmVCDSdHWeDeEh4juBllB/kt5coZovJKF6+eWch4Ey8q2d7k1G+Rq1gdZYCtmXy3BwNwsji4bQzEXAkl9k70gyXqiva7qAtkW9279JoTivTrDBwAYX4bjEngOcbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPyvTWt0y+8M5IXXZEdUQUFwWs0vVHLD3dfQ630vP3g=;
 b=FZHjfRTDEgh7PX78NPrQplYkX/1LK1jMP9vWP/9jgApv8wUyJ6Zkw9jozWcZoeyi2YoLHwV6+kDn1AuFDQKhIjNo/pCnXF7BFIpgEFslvpJa0H/8Ya4/WiP/99e9H6HCeyIGm0AXV/5PBEMVSexXRwbqwdsPmU+ziY8wIVrsT3naXV0uQsHw2sPEufVnA7IdCyY3LAGtVEAD9pjTF74kLh2plc+AOdSKBIx6k/aXAhzkMP/fiGJZuT2JtmAhu5F/nsiHBnqPQ9NiWFJiiteWU5AUtdSwmVvHBwizzAuxd4Db+QMP+dMeOMqdXithUADgReJRM9o3PgRY/fefKsVBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPyvTWt0y+8M5IXXZEdUQUFwWs0vVHLD3dfQ630vP3g=;
 b=AZf/4ylf0PfcW6E1eLa3ASDBWXCfJI+b0zdJ89O4N8VhyV96RiCH36OCSndmhLQFu79eHskHY3vJYmm52MwDTHUAKnun56J4bpMobCRd6U9j8yhyjXFpeNzu3VY9P3hPtAi0rYPikI6CvcE4wuDpfzcG5p+ovDheLFzoxUyOuvs=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by BY1PR04MB9636.namprd04.prod.outlook.com (2603:10b6:a03:5b1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 04:38:01 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:38:01 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rishab@rispop.dev"
 <rishab@rispop.dev>
CC: "tarun.patanjali@utexas.edu" <tarun.patanjali@utexas.edu>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "christopher.elwood2024@gmail.com"
 <christopher.elwood2024@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
Thread-Topic: [PATCH v2 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
Thread-Index: AQHdb00LOHcW6ZDtikG1oislxQpzdrcp4JcA
Date: Thu, 12 Nov 2026 04:38:01 +0000
Message-ID: <84767ba5c78b331dba86ba7640b8c11dad71d1ff.camel@wdc.com>
References: <20261108064641.179764-1-rishab@rispop.dev>
 <20261108064641.179764-3-rishab@rispop.dev>
In-Reply-To: <20261108064641.179764-3-rishab@rispop.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|BY1PR04MB9636:EE_
x-ms-office365-filtering-correlation-id: 3f74eac1-e758-48f4-87d0-08df4076bbe6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|19092799006|23010399003|366016|7416014|1800799024|18002099003|22082099003|38070700021|4143699003|56012099006|261028144727099003|11063799006|10067099003|261102123227099003|261021121427099003|261026140227099003|261021123027099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: aGETLg7xha7t+X/uQpQIuxZl5Z1LhOkWsy9Jb3rurutp1wB2nUmMI8uNDPb9G65ll+etOZKKbotH9NmLmL41bwauBuFdKtld2Xd7toH2PUKDQJWBnCbf5oJRPEUmdPhOBaoW9gpVLVn9W2/47Z5okFZHxk9Zh7hzbqsMG+zUDQHpbP7iU3bi6FHnaEm1QOUGVVE1FkheOumgYyGDeTUCX480EP/w4f2Yb0wKrnSDT2cbPpKmkGud3Dc9c3hwr9NWX9NCvMfRynf/bOx20kw+gLpaZzgcnk+8Sy8gWLu+/4EszoF1oCLDA9Gt7IDKMEBQlkpD2mCAHFdwjP1KVPJrHa2RAyTMkO1FRJrw4M3vV/sTWHZZUphMdxB9zaxVA2I+Jd7iVDQ9Dwv8yMNWKDVUyFC5lAHUUHMloM5Yj/PYUIzbXvaHM4yUnt/DJGgjy6m8+KDJu1RMkXd3UQAXPam/ojYNWKHlAffXkgyKItaHYh5yw6QCA//k3vO9WdZd8nutQLGFSOkXYZLsoULlvY5BZybSv1fIB8YAe2hL9//SNYsImCIAkIZvOFZCvhQTuGC32BA/d0KO+A1sKRk3gpGn9Es47wztLqGGGp/fEflolV5+f4Gplp2nK9Ispi6dnlHjywYryq+nbMbHoDPtlKapKBshocu0i9oLjnSO3kEv4xL+g052lXkwdlS+ERqOJxRDiYJ3/uxwT8QF49MNNSr4CbYWG1vIGwpL/oq1Qjy7vvs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(19092799006)(23010399003)(366016)(7416014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(261028144727099003)(11063799006)(10067099003)(261102123227099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWtkMXRnMmJldWgzTmpXZE9zdk1VdjdpMVNCSGJYbEJ0SGlqWUluUDlVZ2Z6?=
 =?utf-8?B?TmUrQ0toNHRpcGYxRVNPTmJ5U3V1WEdiQ2dRcmpvWWU4OUJmZWJ0cTNONENX?=
 =?utf-8?B?NmRvUFpCZjJFRWZLSlkxQW1TMWFyMk9OR3RXcDFkQkM2QkQ3VFNVaU56Z3ZU?=
 =?utf-8?B?MDArUzJndlBsVkFYTEhJNGVISVBpdGZzYkFNOGE2NUlnY2RwVElVQXJXOGJJ?=
 =?utf-8?B?REhKQlRPSjVzc3p6WFlwYXlmRzZlTTFOb3Y0Z1NHVmY4UTJidXVMTTZ3TSs3?=
 =?utf-8?B?Q3RyWnh4Y0xaOGdGV2wyNEI0SzN5M2VxNEo5d2hlQ2l2ejJPTDlVemxIMUUv?=
 =?utf-8?B?MERoMVUvU0dlZEdLT1VNR2pmOUlzTk0zenlrK2x2MDMzL1FwVURLSnJFNFZC?=
 =?utf-8?B?STh3STNUbmlZL3hWRytOOEJ0VmlRK2I5TEloRVZMTzRzRHcvVHlLQWplcUxI?=
 =?utf-8?B?MnBKQUFYUnJCK09HTjRjaTRDbUIyMlBZU1IxZXRrT3J3YWtzbEQ5TGozT2lY?=
 =?utf-8?B?WHNIc2kyb2plMWVrc1hIRENBRVZ5RG5vWGRBb2JoYnJ4dG9TNWhHRUs4RVpO?=
 =?utf-8?B?Z2FyUGZrQ21TV2YvR3M4TnFPek5zNDVMazlqSVp3UnlNL0I0TXU5NThvZXZB?=
 =?utf-8?B?SWtvd3RnQ21yZU1tYWU1U3JTR2s1SmQxZ1ZSLzdhOWNqaTZndDJJWXNDaGNZ?=
 =?utf-8?B?aEZwUXJNcTZVVVdUcjVFV2JwaDVuYnk0aHd6anpSL2xNTm12UW9EUHBjYlV3?=
 =?utf-8?B?ckNBc2d4ZVkyWjNldTczTkV1QWdBRWJDQnc4ZWtTVnRUNXVpOU1aS2lvUGZ6?=
 =?utf-8?B?M3BWK2Q5TVUycjNmWW0vVHFRUUsxalg5ZWFtQXdQQUs0cWdrU05pTHB2a1hM?=
 =?utf-8?B?UWJ5RVZXZG9haklHUmRjWDRZUXVzc1NZOEJZQ0FGZkdqVmZNQW0wZ0ltYUk0?=
 =?utf-8?B?WXJhYng5RzZqYTl3Rk5hKzFlS3J4bktyYyt6d3gwNTN1U2Z2OUlXZklabis5?=
 =?utf-8?B?VTlyVG9jQUVCRnFCT2k0Y25iOSs4WnJiZUVnTXNLNGhpVHVXUFphV3ZtS1pK?=
 =?utf-8?B?dGh6SDI0bVo4VFR6bDBReDcxYTlReTdOekhhOThONXJTYk5hL2FNbEZpMjRM?=
 =?utf-8?B?RFNZc2ZGOG5LbjJUMWZVUythUXVTQkh6UVBEYXNIc01CVUI5dEdwc3RTME9T?=
 =?utf-8?B?amlJZk9JRkVvMHFETTZhb0JpNUp6SVUzNUMyQWw5cjVLVGI1QVRwZ05NWW9Y?=
 =?utf-8?B?VnRYbFJFb1MyaUxHZXZDVG45SW1UNFJ1QlFHZGRzRjYvcXB1N01hUHV5L0tR?=
 =?utf-8?B?NVVmdVZvS0ZFdGNxeFlFR1BVQ2xPVlVjaFRxOVdhZE9JWGcxZkY2MUhkbWs2?=
 =?utf-8?B?M1dCdTRpZmxZVFFoUStQVkQxeWs4WG1kZCtCY3hBdFNhZWl0K3BGUG9oVmFw?=
 =?utf-8?B?UlZxRUZjVHk1VXJUY2JQaVhlRU9qSmQ1Z1FZbHZick56cm5ZVStrd1NzU3JJ?=
 =?utf-8?B?K2J5YlF1K1RTOFl6SUVhUk1sWkt1OWJXU1dubmxhbDVSZFRmeUltWEQ0RHRB?=
 =?utf-8?B?WEltZ0g5TDBmR28wNEs4RWNLSDgxWE1XWHlwV3B2OEd5cW1OQUpLNFdacmtJ?=
 =?utf-8?B?TWhSejJ2Qm9tNkVqbHh4ZUJxOXRVRjNGSlZWQjRXNFZLQzU1MkhDZXI4cVBz?=
 =?utf-8?B?S3M2VHNVRGlLb3R4dmFqS3ZMcWNqeUxFY2VDRTc0YjVRM0ZBVWp2WmtYWFJS?=
 =?utf-8?B?aXlzOTl3OFFrU01JOEJrMXdxVm5KVTVMejFDVURRczF0bHAwclYvVGZQOVFG?=
 =?utf-8?B?cnlKaDUrR1F0cVBVQ0ROK2RFUXBObkJkcWFqb2R1NGZPZUFsK2FOTzdjZ1Jn?=
 =?utf-8?B?R1Y2NzlnL1Z1bXlTMVlHWU4wZnBtTm40YVdWZXdRaXVKdll6RTFuOEsxYU5t?=
 =?utf-8?B?dEpDTmJWd21uZzIxdWdtUVJDZHZ4dDZCL2FsVjNhYmJXeHBDSm9tMUVscXg1?=
 =?utf-8?B?L2JLNFhaUy9sWCtSdjdBZ1dLQXhvSFVnQkFTSEp5MFpZNFZUOGc4STVDblVN?=
 =?utf-8?B?Nm9JWDdnbklhVDRLNjVmQWFmQ2xhRnlPc2hOTjVJN0JJRGpCSUdQbHZLOGU4?=
 =?utf-8?B?MGkrWS9DbTVJeTZuMFlLSUthWnlpcHk1d2dCbGZKU3BUcVkydUVIWnVqRGtP?=
 =?utf-8?B?czlMMXpyelg3d3dGY2U5eHBkY0pLdmd3T21CQXFYaytSLzhDSGVETmVIYzFw?=
 =?utf-8?B?RGR0d2xIUFE2b0tHeE5jV0ZqNnRFUVo5eGNBTUVBT1p5R3ljTVk0cnBTVXIy?=
 =?utf-8?B?L0R4Q0dSR0EyaUVNQ0VYWXA0R01YSTd4QmFSeE5oZUd2V3FDaUtQRmc1MWFF?=
 =?utf-8?Q?GUdoacW8mgTYmk5iTsr1TNoMdJCtyWOjY2yaU6GNzBeLc?=
x-ms-exchange-antispam-messagedata-1: rBI6QvkE61WO2A248H1ciOEIc1ICRgA339I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <400EC43A1184E34B9E2F0F7CDAB2A6AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EO7f7qWW60VtTwP87Q074XWZvEYwKCM4pRt5j1cfdoeTE6fZoIjWHxjUZ1fs5upYF68XOyd3e4cAR50IszcEGJbprVZpJ7O8mDyX0y09KDN0AcOC0UrJeKVv4ygiDbWPN/6OYiKAkkXp9Bz5cHcHlZwVGXPkfG6c9rc0b8nQzVZyGolj7UhbYikD8XvjzlRqb3/Yqthhaj2V//6n0ARCaNVi/KaKOESgI6TI/6jhPLO+z1D9kzp42yhLWPKBun4bCmtqhoK4CKzEj4DtmfFp1kyilFkxtMZl74Cqnze16jMaocD9M0lTDjDfB0qin6dOQJgk/aBjJHAy0ov1VQXTLg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5dNtctEtqpHBkljhABz3WlgzAJMnq1bAUIHZx0Kjw/hDLMI/dx8Egz18cXYCr4umX+RuS4xFc/p5T09ExnmbiDsJvYidIN+94UfkmHTCubPEVYHsM2v4RwczX8dY2HXUV5ltbXo7ec1PPkq2nqDckCxUmRo53ekdAk93trqiuDFCTf4sVejCMuSmbU+f68EDW/EQwhTPXp+ht5TasTIEFj73L7/Dq2M3wBkcJaIOsnB8gUyTyMENtY9pHhfmPCCvoYcj3ZCvdx3OAybw1mreA7cNJ5xesPAkbs3IXCxVdnuN5avVHow4GF99+xSbc4SRdkCn4g7d8JAvXQa+XT+JIPVoEQ0Tsez3M5nnjLAfxn2YT2G3eVbaT6bazwh9QfD7DTalMR/KCncPPucGIEBX9jOAEUzk30nrPti6WVD7zqs/BRZ2Nxv4FjINKTp1/JiaaYEcbo87KqgDJ2hP0loBc6FOh8Q0kj8XBb7mcCG8Yx46U9oPFUezEwG0AJPrkuJTVVdQ0pT/80i3cm8S709AF/fsFepR8F2JynAp43EuEwLVdDlhKvn/OIhMdmIML8lRxRxXBnomJdLkasHAXoXxBVVJ3/7qmfo/42FNMcEBKradtHuK/9MzpgUiVVdDQeoo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f74eac1-e758-48f4-87d0-08df4076bbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:38:01.2065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44o5TCTiqhOGEeDP0fxuBnmqrqXpfzEQQ/xVe8fWbAr/P8/WlJICIEtVVxjnzwrCvz2SK0o2kAygfsqvyZqCSBjTuVLsNZQOl9drMh1qr9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9636
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCAyMDI2LTExLTA4IGF0IDAwOjQ2IC0wNjAwLCBSaXNoYWIgUHJhZGVlcCB3cm90ZToN
Cj4gRnJvbTogUmlzaGFiIFByYWRlZXAgPHJpc2hhYkByaXNwb3AuZGV2Pg0KPiANCj4gU1NQVVNI
IGFuZCBTU1BPUENISyBmb3JtIHRoZWlyIGVmZmVjdGl2ZSBhZGRyZXNzIGZyb20gc3NwIHJhdGhl
ciB0aGFuDQo+IGEgR1BSLCBzbyB0aGV5IGJ5cGFzcyBnZXRfYWRkcmVzcygpIGFuZCB0aGUgcG9p
bnRlci1tYXNraW5nIGlnbm9yZQ0KPiB0cmFuc2Zvcm1hdGlvbiBpcyBuZXZlciBhcHBsaWVkLiBX
aXRoIHBvaW50ZXIgbWFza2luZyBlbmFibGVkLCBhDQo+IHRhZ2dlZCBzc3AgcmFpc2VzIGEgc3Rv
cmUvQU1PIHBhZ2UgZmF1bHQsIHdoaWxlIFNTQU1PU1dBUCB0aHJvdWdoIHRoZQ0KPiBzYW1lIHRh
Z2dlZCBwb2ludGVyIHN1Y2NlZWRzLg0KPiANCj4gVGhlIFByaXZpbGVnZWQgQXJjaGl0ZWN0dXJl
IFNwZWNpZmljYXRpb24sIFNlY3Rpb24gMTcuMS4yLjYgKCJNZW1vcnkNCj4gQWNjZXNzZXMgU3Vi
amVjdCB0byBQb2ludGVyIE1hc2tpbmciKSwgYXBwbGllcyB0aGUgaWdub3JlDQo+IHRyYW5zZm9y
bWF0aW9uIHRvIHRoZSBlZmZlY3RpdmUgYWRkcmVzcyBvZiBleHBsaWNpdCBtZW1vcnkgYWNjZXNz
ZXMuDQo+IFNTUFVTSCBhbmQgU1NQT1BDSEsgcGVyZm9ybSBleHBsaWNpdCBzdG9yZSBhbmQgbG9h
ZCBhY2Nlc3NlcyBhdCBzc3AsDQo+IHNvIHRoYXQgYWRkcmVzcyBtdXN0IGJlIG1hc2tlZC4NCj4g
DQo+IEFwcGx5IGdlbl9wbV9hZGp1c3RfYWRkcigpIHRvIHRoZSBzc3AtZGVyaXZlZCBhZGRyZXNz
LiBzc3AgaXRzZWxmIGlzDQo+IHN0aWxsIHdyaXR0ZW4gYmFjayB1bm1hc2tlZCwgYW5kIHRoZSBT
U1BPUENISyBjb21wYXJpc29uIG9mIHRoZQ0KPiBsb2FkZWQNCj4gdmFsdWUgYWdhaW5zdCByczEg
aXMgdW5jaGFuZ2VkLg0KPiANCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXBy
b2plY3QvcWVtdS8tL2lzc3Vlcy80NzU4DQo+IENvLWRldmVsb3BlZC1ieTogVGFydW4gUGF0YW5q
YWxpIDx0YXJ1bi5wYXRhbmphbGlAdXRleGFzLmVkdT4NCj4gU2lnbmVkLW9mZi1ieTogVGFydW4g
UGF0YW5qYWxpIDx0YXJ1bi5wYXRhbmphbGlAdXRleGFzLmVkdT4NCj4gQ28tZGV2ZWxvcGVkLWJ5
OiBDaHJpcyBFbHdvb2QgPGNocmlzdG9waGVyLmVsd29vZDIwMjRAZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpcyBFbHdvb2QgPGNocmlzdG9waGVyLmVsd29vZDIwMjRAZ21haWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBSaXNoYWIgUHJhZGVlcCA8cmlzaGFiQHJpc3BvcC5kZXY+DQoN
ClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+
DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3Ry
YW5zX3J2emljZmlzcy5jLmluYyB8IDggKysrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9y
aXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnppY2Zpc3MuYy5pbmMNCj4gYi90YXJnZXQvcmlz
Y3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ6aWNmaXNzLmMuaW5jDQo+IGluZGV4IGQ0N2E5Zjlj
N2QuLmMyZGRkY2M4YmIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFu
cy90cmFuc19ydnppY2Zpc3MuYy5pbmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3Ry
YW5zL3RyYW5zX3J2emljZmlzcy5jLmluYw0KPiBAQCAtMjksNiArMjksNyBAQCBzdGF0aWMgYm9v
bCB0cmFuc19zc3BvcGNoayhEaXNhc0NvbnRleHQgKmN0eCwNCj4gYXJnX3NzcG9wY2hrICphKQ0K
PiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIFRDR3YgYWRkciA9IHRjZ190ZW1wX25ldygp
Ow0KPiArwqDCoMKgIFRDR3YgbWFkZHIgPSB0Y2dfdGVtcF9uZXcoKTsNCj4gwqDCoMKgwqAgVENH
TGFiZWwgKnNraXAgPSBnZW5fbmV3X2xhYmVsKCk7DQo+IMKgwqDCoMKgIHVpbnQzMl90IHRtcCA9
IChnZXRfeGwoY3R4KSA9PSBNWExfUlY2NCkgPyA4IDogNDsNCj4gwqDCoMKgwqAgVENHdiBkYXRh
ID0gdGNnX3RlbXBfbmV3KCk7DQo+IEBAIC0zNiw4ICszNyw5IEBAIHN0YXRpYyBib29sIHRyYW5z
X3NzcG9wY2hrKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfc3Nwb3BjaGsgKmEpDQo+IMKgwqDC
oMKgIFRDR3ZfaTY0IHdpZGVfYWRkciA9IHRjZ190ZW1wX25ld19pNjQoKTsNCj4gwqDCoMKgwqAg
dGNnX2dlbl9sZF9pNjQod2lkZV9hZGRyLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRl
LA0KPiBzc3ApKTsNCj4gwqDCoMKgwqAgdGNnX2dlbl90cnVuY19pNjRfdGwoYWRkciwgd2lkZV9h
ZGRyKTsNCj4gK8KgwqDCoCBnZW5fcG1fYWRqdXN0X2FkZHIoY3R4LCBtYWRkciwgYWRkcik7DQo+
IMKgwqDCoMKgIGRlY29kZV9zYXZlX29wYyhjdHgsIFJJU0NWX1VXMl9BTFdBWVNfU1RPUkVfQU1P
KTsNCj4gLcKgwqDCoCB0Y2dfZ2VuX3FlbXVfbGRfdGwoZGF0YSwgYWRkciwgU1NfTU1VX0lOREVY
KGN0eCksDQo+ICvCoMKgwqAgdGNnX2dlbl9xZW11X2xkX3RsKGRhdGEsIG1hZGRyLCBTU19NTVVf
SU5ERVgoY3R4KSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBteGxfbWVtb3AoY3R4KSB8IE1PX0FMSUdOKTsNCj4gwqDCoMKgwqAgVENHdiByczEgPSBn
ZXRfZ3ByKGN0eCwgYS0+cnMxLCBFWFRfTk9ORSk7DQo+IMKgwqDCoMKgIHRjZ19nZW5fYnJjb25k
X3RsKFRDR19DT05EX0VRLCBkYXRhLCByczEsIHNraXApOw0KPiBAQCAtNjAsNiArNjIsNyBAQCBz
dGF0aWMgYm9vbCB0cmFuc19zc3B1c2goRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19zc3B1c2gg
KmEpDQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gwqDCoMKgwqAgVENHdiBhZGRyID0gdGNnX3RlbXBf
bmV3KCk7DQo+ICvCoMKgwqAgVENHdiBtYWRkciA9IHRjZ190ZW1wX25ldygpOw0KPiDCoMKgwqDC
oCBpbnQgdG1wID0gKGdldF94bChjdHgpID09IE1YTF9SVjY0KSA/IC04IDogLTQ7DQo+IMKgwqDC
oMKgIFRDR3YgZGF0YSA9IGdldF9ncHIoY3R4LCBhLT5yczIsIEVYVF9OT05FKTsNCj4gwqDCoMKg
wqAgVENHdl9pNjQgd2lkZV9hZGRyID0gdGNnX3RlbXBfbmV3X2k2NCgpOw0KPiBAQCAtNjcsNyAr
NzAsOCBAQCBzdGF0aWMgYm9vbCB0cmFuc19zc3B1c2goRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFy
Z19zc3B1c2ggKmEpDQo+IMKgwqDCoMKgIHRjZ19nZW5fbGRfaTY0KHdpZGVfYWRkciwgdGNnX2Vu
diwgb2Zmc2V0b2YoQ1BVUklTQ1ZTdGF0ZSwNCj4gc3NwKSk7DQo+IMKgwqDCoMKgIHRjZ19nZW5f
dHJ1bmNfaTY0X3RsKGFkZHIsIHdpZGVfYWRkcik7DQo+IMKgwqDCoMKgIHRjZ19nZW5fYWRkaV90
bChhZGRyLCBhZGRyLCB0bXApOw0KPiAtwqDCoMKgIHRjZ19nZW5fcWVtdV9zdF90bChkYXRhLCBh
ZGRyLCBTU19NTVVfSU5ERVgoY3R4KSwNCj4gK8KgwqDCoCBnZW5fcG1fYWRqdXN0X2FkZHIoY3R4
LCBtYWRkciwgYWRkcik7DQo+ICvCoMKgwqAgdGNnX2dlbl9xZW11X3N0X3RsKGRhdGEsIG1hZGRy
LCBTU19NTVVfSU5ERVgoY3R4KSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBteGxfbWVtb3AoY3R4KSB8IE1PX0FMSUdOKTsNCj4gwqDCoMKgwqAgdGNn
X2dlbl9leHRfdGxfaTY0KHdpZGVfYWRkciwgYWRkcik7DQo+IMKgwqDCoMKgIHRjZ19nZW5fc3Rf
aTY0KHdpZGVfYWRkciwgdGNnX2Vudiwgb2Zmc2V0b2YoQ1BVUklTQ1ZTdGF0ZSwNCj4gc3NwKSk7
DQo=

