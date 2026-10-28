Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=D9Fulq70;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=VygO9IFn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLulf-0001cC-6K; Tue, 27 Oct 2026 23:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75473350e=Alistair.Francis@wdc.com>)
 id 1xLulT-0001bg-Et; Tue, 27 Oct 2026 23:55:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75473350e=Alistair.Francis@wdc.com>)
 id 1xLulR-000716-64; Tue, 27 Oct 2026 23:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793159749; x=1824695749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X+JAnC7NXAjlfHnLcQIdjD3giRMpuO3B9Tosfy85Dbg=;
 b=D9Fulq70xr6qBjwFx3AuPqIUDFxH69u2HVR5QBCHp+zGOoIVHUKpHkPe
 ZGYCjwx7cyXudjrX/lrZxnaIIwzbIZfR3VuNNkoND8RUmeSeaGNwBP8QZ
 P4mP/ei73P8BaGf9gz5enbCMt3EaMhsUZM+wEePRERSLHZ7+80I7p6QbR
 i40Y2QRtDWyqG/8STgP5nncRkucGAljCvJxhIbk1di1XCxOkW/ZrEdimQ
 u4V9lr0BN3ISGXHzg0V97hoBVz17zkWEn34PChHyhd6Uq7tRDbTH7G+O4
 SbCqu9GpMBH4XRPAP4cLIgWVhUrWwLgJojmqlTw4KH+duDtmkmCnfOB4E w==;
X-CSE-ConnectionGUID: wdAV4jRwTFqbFtqDt6sYyQ==
X-CSE-MsgGUID: sjT8gzw1RwWRQNGTkJgBCw==
X-IronPort-AV: E=Sophos;i="6.27,182,1786982400"; d="scan'208";a="158209854"
Received: from mail-eastus2azon11010048.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Oct 2026 11:55:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St6kxrUurmaghYva/0bUEUv7Mdx0c6YFFqkD0JcngG1CemLbpFmFmjynZ3EuniOytUnZP9vMSPUvUQHQ6zLOOdVEZ7f/tpctgoWB4fB59zC5Z2DUbyVPDTRcp4ooiUxPFDD1VAx3DfpstxRE2mXDGbdeHkoacv1jPI8UxQ4EK14lImAa5lu3i8VKs6yNzbvAeMvvznqu9Pz44Sdv9ph4xyAvPblLLUYAGxEfM+xaOzXGSyxNMZAAjbS7kUoKjI7rvGrbsYd+CQZy7Iw0f6FPoqNuY1CMrKO0rIyVUzMPSNkbtQ/nt72gLmfEZ84NucKUGBS9OdyJ/s+EXFc2fMLp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+JAnC7NXAjlfHnLcQIdjD3giRMpuO3B9Tosfy85Dbg=;
 b=oYyoSfzxYJLQqZval1b80UG+srwahnr5PXjX3PRo9OmQwLPbzbHaX/Q24DTxWIbBJZqRD4ZZmeitR4rm/0ysPWorZ2bi2W3nP2BPWc7u8/dvWvJwvjfXlvncVc27kXBSO3WrKpEz1IJodPFYKtEhSo3RZYssMAG02xuxctfItc7BvyHMR5+Apc9v5a2qblmKavTtwpnVHbuupsFELqNSXeYRbGlrds5ofHvYYcieSW7/lis3GvCPLaQBQsrRcKXw2Mn/IVNuQQA5LqkIImkyLzZ+NP1c+1cPSG/JgT5gCpKOq8vMm+TctW8igiuzOtslK/UAZGlfjlwD2JqybgmVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+JAnC7NXAjlfHnLcQIdjD3giRMpuO3B9Tosfy85Dbg=;
 b=VygO9IFnxVo5sDfSdJmA5I5DalqhJ4vNhjYPsLT8pZ31po5/JXj0e6KsYHBYeP81ItTAuaEqXv+MimecHdYCajhSN4HHVFhiiXyPQc1jygeYZLwYUSUC5eF2v0vTtEckW7LLT3M0rJ+am5xKB0CB0RaFw0/mlqr8EhouESApe2M=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM6PR04MB7020.namprd04.prod.outlook.com (2603:10b6:5:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Wed, 28 Oct
 2026 03:55:40 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 03:55:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fustini@kernel.org" <fustini@kernel.org>
CC: "mindal@semihalf.com" <mindal@semihalf.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "sunilvl@oss.qualcomm.com"
 <sunilvl@oss.qualcomm.com>, "liu.qingtao2@zte.com.cn"
 <liu.qingtao2@zte.com.cn>, "anup.patel@oss.qualcomm.com"
 <anup.patel@oss.qualcomm.com>, "cp0613@linux.alibaba.com"
 <cp0613@linux.alibaba.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "npitre@baylibre.com" <npitre@baylibre.com>, "radim.krcmar@oss.qualcomm.com"
 <radim.krcmar@oss.qualcomm.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "guo.wenjia23@zte.com.cn"
 <guo.wenjia23@zte.com.cn>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "cuiyunhui@bytedance.com"
 <cuiyunhui@bytedance.com>, "atish.patra@linux.dev" <atish.patra@linux.dev>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v6 1/6] riscv: implement Ssqosid extension and srmcfg CSR
Thread-Topic: [PATCH v6 1/6] riscv: implement Ssqosid extension and srmcfg CSR
Thread-Index: AQHdZXKKNPK3USFmk06vVFZIYfd9g7cQh3mAgAG+RACAAA/AAA==
Date: Wed, 28 Oct 2026 03:55:39 +0000
Message-ID: <d342acffc48a50d7c2b0db896b4cb8fe97183aab.camel@wdc.com>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-1-1a367a35cd0e@kernel.org>
 <20219a9e5fcaf2f50eee2bd123a12a04c05cb97a.camel@wdc.com>
 <auFlBAtOZSw94vnk@thelio>
In-Reply-To: <auFlBAtOZSw94vnk@thelio>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM6PR04MB7020:EE_
x-ms-office365-filtering-correlation-id: ceab0771-1148-4ce6-4c11-08df34a754f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|10070799003|23010399003|10067099003|4143699003|261026140227099003|11063799006|261009223027099003|56012099006|261021121427099003|261022075727099003|261022105027099003|6133799003|261026121527099003|18002099003|22082099003|38070700021|3023799007;
x-microsoft-antispam-message-info: rbiKi4D1loAXYoySSgkHfJakdXwR1KGYqRGlAfVOZWCbdHTRsTKcE0nr2kRfyzrEAbzdVA/ZbnPZ1YhPMIc7W2NxVF5m2xMoPJWMQAYBOLixTilLKZ4WYkd1Qz6G1NRfttsstyYgJefveF/+g/Fr1cDr358TWtruzLBZnEvFmLhwH/wuGe2NNWVA0qB30/EF5KN8EpGaOgSm/ii1t2gamljxWFBlX+kjnGejcbczBjzWEKmPwyQqKMWuKOYn/jj1J7gN+t6JxVxJrdViO7G/7KZ/pz107S5iPlaPxO099YEGhvoc9aiMcR5fiHNzHtdyIqpLzq5G3wF/VDNNFxY/iO/nNsLVDOWGTQfzpDNLDtO703XcxjHz+oglvYUq0INPkln6fOkyozlwV0nNePE58XH2h6we0nnxDWVgasK5G+VWg4bD+mh+S0XIMGSYPBcGQIRHW4/sYJHgdb+oyD0PbshlxCBEzn9N874SuA4VTjJUuzL9o5DEauKp3DKiPpqAYouWg+cw6hKhV23uNvw03TLMYDfQIVCWJ2+wObKYx+r6IcWkxnVtHtXJD+tFLDrLZ79yS0RIHuuAgFf5XyhwgKTFlfL75sky/JYOgWRCqMDQUy9+z0YqjHYq38UERhgjZkyCRKWPAQCEi3vTFgqvZJypVO5kx2KjjrHQxvJmSII=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(10070799003)(23010399003)(10067099003)(4143699003)(261026140227099003)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(6133799003)(261026121527099003)(18002099003)(22082099003)(38070700021)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXpmd1VBNXdYb09OVWhNSkoraU5RNXBzWFlRYnl3QUJrdG1kQU1pOHhVQWtS?=
 =?utf-8?B?R1p4Zmg5SUUxdHpKbkxwRkdQdlNycUpiVGtWWThBZTdtcnFWS3dWVTB5ZmR4?=
 =?utf-8?B?SzJJa3M4M3JMOWkxUm9JZC9aVXlwK3JtME1IQ0RTWHNhZ2xYV1RvYmJMMDZl?=
 =?utf-8?B?RDJtb1VUQjJ1VnN5RGZaYXhvVUVSdnU3OC84WU9QbXBHYUpKUFYwdFFiL2p6?=
 =?utf-8?B?K1pENGIwTWJxbHZTNFowVmppMjRSbG9jMUtRdkNIaWFRMnBFYUFSdUl3clox?=
 =?utf-8?B?Q2phRC81MzZnYm91cG90amQrTTI4NitzbkxYNkZkNVJnYWlsN3REdjQ0QU05?=
 =?utf-8?B?YnVKa051dmZmRnhEWGhkR2N2TWs5WGp5dFF5b2svWVlVUmo1dVk0RXZkaTBE?=
 =?utf-8?B?TDNFcG96VG00dVQ3U0hJa1NaL3V4UzQvTjlnNU44d0tBc3k2YXRqSWNtR0hm?=
 =?utf-8?B?d3RtU1dNNkY2Q253eWppZXlkQnJHdFhoWmNWeEpSSnBMOGJiOHZJaVBZNUNn?=
 =?utf-8?B?ajVLUlhtRExIb3l1Q1ZacXhDd280aWxKL2FwcEMycWFkZ0l1N0N0ck1iSXdq?=
 =?utf-8?B?M1REMFJiK0dqUHo4WDIxTVZ5MlRJaXFZK0tEcm9iR1MzV1lMVGVwOS9lMWxE?=
 =?utf-8?B?SlBmYlZTT1dBTlFFZHNNVEJDVW1makRJNkI4aWI2K2lMRDNvMVp3N0g2UDBY?=
 =?utf-8?B?MCs4SG5qREE0bkMzUTBmL2FuT0kvQkxxZmlQVE5ZZmN1dUJobUFmZDc0ZytB?=
 =?utf-8?B?SXdnVWs1S3I0UWdJN21JY0RVb3B2YXc2UjN6UHRHQzVGSEk1VW44TXF0L09U?=
 =?utf-8?B?RDFjeTFVM2FqOW11UkwycHZFTkt0dnBjekdVUm9Gem5kREpZME9LMEdLVUxD?=
 =?utf-8?B?ekhnc0VpY1p6d3VpK0hPTHRBdjFuWXlod1A3RjlmK1RzUnJpMmdNOGp0QkZJ?=
 =?utf-8?B?RHZjaTJ5U096aUNmZlExVENIdU84TzJwWEQxUW9VdDZxSjRQZnFOTEQ0VHc0?=
 =?utf-8?B?RWt4MlhTNG9sV2VSdUtOTUxCVkNiejFQMCtxQkpRam5hbDVxZnNpK0xGeS9X?=
 =?utf-8?B?NFgxOTlqUTV4RTZnTnJxS1RXN0pNK2RzUWxmekdPSEJNVzdsMFQ0V1ROQnpB?=
 =?utf-8?B?V3pxbmxobmd5cTVwRFY0eVUreE9SL0pIemVVOFRSY01VaGkwK1ZCZ2p0Znh3?=
 =?utf-8?B?S0dRZVZuV0JiWTBZclp6RzdrRW4rNXljSGtudVFLV09EdXA3R1d2SFRvM3kw?=
 =?utf-8?B?R3h1V0VGcUJzT1JndUhKMkg1dm82VEUxNVJERGhSbS82dHd0VzlOSEY0UVpP?=
 =?utf-8?B?Znh0SjQ3am1VMHFacTJYcFVjWjVoY1B6Wm4wOEtRelc0RjVEQWRMNVEwamhG?=
 =?utf-8?B?dUtWeC9GUFNia3IxaUVOVWxmVmVJT0c3VHRscjBRekdCVUQyckZjOHgvY3FK?=
 =?utf-8?B?VVprOWJidktMUUpqcHdaeW8weTgrVWlWQllEZEE1RHllM2MzVStrQ1l6bXBB?=
 =?utf-8?B?N1poWmcvN0VvNHFxWndEOXNES1U0ckpqV0FHVUhLV1hrKzNSeFdVOU5DRU5V?=
 =?utf-8?B?M0dQUzByY3htWll3a3pPV21XTTJrWDNRY2ZyU1JwZnpFVVVhaFBlL1paUVBF?=
 =?utf-8?B?d2tObDZCcG1Wc0ZBUVNIcHprMlF0YkJIMVR2OW0zVS9ydXFEZVdpVlgzZm5y?=
 =?utf-8?B?TFRSY2VEYWNGb05YaHJ2TloybU1vaWRsQ1JVWEtvcml3T25SNXdSYmNsZWJO?=
 =?utf-8?B?bnBua0pzMW9XZ0RZTTdwRzdTdHN2d3RxT0djNGsvUHJpazJaeFBydkNzdENP?=
 =?utf-8?B?WVdkNFM2eWRrSWdQNUZvcUs5c3ZnZHlxYiswWFpYc21DZHZvSUVTblZCYjE2?=
 =?utf-8?B?cndlcG5lYVFJMjFJUkIzS1JUSmpKR2lSTEs2QXVpcUpHZkczelkvbDZOZUk1?=
 =?utf-8?B?L1dzUDRaZWJzVFdxTktSVklWemU1d0V3clNQeVdUdWJjT1VBVjFUVTFOWlcx?=
 =?utf-8?B?RlRnMERkWm9PZEJ1VjFuVWNQbThmQ2VsekZ5cnBIZ21OVGswaytyT0w3eWl0?=
 =?utf-8?B?c0phVEtqdlBSUkFaYjVlZXdNRTBUT24ySzVXQlE0cjEvWGRLcDZCRlk3SHJH?=
 =?utf-8?B?eUcwRHliMWMreDlpeDVtazV5QnFrSGJoYTJmY2pmSDdVZWVvVVN0OFJFWC9x?=
 =?utf-8?B?Sm00SFlUVCtZNFBmdGFUYXhrcDVHVVNyT3lLVFlkN1d5S0VwVFl6SG9zSzJt?=
 =?utf-8?B?SU1KWkV1WHNsMmJaTGUxVXFDOGlpQkNSaUlZOEJ1TU90SzNVUThvcmtvTmJy?=
 =?utf-8?B?VWtMTGdoZzE3VW1EK0lVZnlUYXJkOS8vZmtNbDVJdEdsMDRlMWZFRzFtMEN1?=
 =?utf-8?Q?k3GSS8mF/b6a9Iw5ZrZvNdYsN+SDjUlF9yHK86lsxpeE+?=
x-ms-exchange-antispam-messagedata-1: hMTiD8WehMnOqTodqu2YkFZpOdeyd7bnFPo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB341D5FAA8DB040B9EDFC24A0F10A74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YNQ7/YeIzxopMlaBfj6TVExAVqK9bGGbP3glkmA2XvoqPJFw9ip6kR9f47jf95L1O4cvLMATK3gzo+Vg/asiWs8+Y6Cn8MFmxYX4DWEBsPy0NtJL6Qbck2ULbbFpDAj8u7nFsJwXTcxHosz6lq0SStln+vZoZMdHeE7uJMMe2cAcWdKht+qt6cKTbv05oi9MS7ap00vX52uJ/6wYTVbzRq2RqgIzEA7VnIqnGQXdsKmmFWzN3S49v2oMwROZGnb3znhLNn5G4u7uxAuSnI1oW7c948WhkRNAmo7QpxBdmVnSnGgKUIXAqPOcVSkjclfRxN9ud0wLQ7MFmfGf2sBWmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pXPaGLdZytzQ6DkenxeGki4oCcd3k09GPnsMIXho3VMT33trTISoJRDu+LfM9UfsKrPF5cHbKmPrpAPdYLrbHJHtgAyE+y60JFBComd9H0sI8BF4/Z5ckpB/0iXLvee6HmlhzGKLHwpYydOXwpwng38t8xj0gJywRed1ibTMthpymm8xNe3CyTbb6W9LRqT+p5ZxKqpUovoP3cxx683c4vsR6n0hzsd74KgAPaS9oHAZmiwho6w+DtBOE7UE9KHDHSeCJv5XSrDBCVnWgs62kcGxpBuL+/HyHATUI0WEHH79F999VB1RybzslaZ/c58/6eiG6itVwJAirYx6lKpWgGkdN/WArzNstTjh97VN5DtzYz4cm+GKIWTIXB7o7gUxUu6nHFfgdFV97t4rusUjcu8tdyz18WgJ5z6jDcnZlfISnQQZBnSwnTC6M308efUK4Zz2Ki9ah1Lc1yf8ImnZCN/1M3YdMaLZrzkI8/fSE4wLx6DCqlynSCH5f5VXKLOXCxCL2/qaPpSysVCy5O/7CAPTA659jb5mfBPKGDnm8m9hYXIRK6kgWejv/lOmbv8QgP1hi5IP4ySNvzPAFPGfgB6sejk6HyLnGm76hy8/jd898Pz0tUXAjTpqiuRjuPdT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceab0771-1148-4ce6-4c11-08df34a754f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:55:39.9313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2pU1Usy/OyeFgBBoy1MsCd3vdF3cv/EY7vHSsNaiIJLWjc4Wm6zy6G2Hf0gaVEBoVfq8Ehei3o7P7h5Ub+fdmyBt8J/3b2rBQbrUAsPCxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7020
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=75473350e=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTEwLTI3IGF0IDE5OjU5IC0wNzAwLCBEcmV3IEZ1c3Rpbmkgd3JvdGU6DQo+
IE9uIFR1ZSwgT2N0IDI3LCAyMDI2IGF0IDEyOjIyOjAyQU0gKzAwMDAsIEFsaXN0YWlyIEZyYW5j
aXMgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTEwLTI2IGF0IDEwOjQ3IC0wNzAwLCBEcmV3IEZ1
c3Rpbmkgd3JvdGU6DQo+ID4gPiBGcm9tOiBLb3JuZWwgRHVsxJliYSA8bWluZGFsQHNlbWloYWxm
LmNvbT4NCj4gPiA+IA0KPiA+ID4gSW1wbGVtZW50IHRoZSBzcm1jZmcgQ1NSIGRlZmluZWQgYnkg
dGhlIFNzcW9zaWQgSVNBIGV4dGVuc2lvbg0KPiA+ID4gKFN1cGVydmlzb3ItbW9kZSBRdWFsaXR5
IG9mIFNlcnZpY2UgSUQpLiBUaGUgQ1NSIGNvbnRhaW5zIHR3bw0KPiA+ID4gZmllbGRzOg0KPiA+
ID4gDQo+ID4gPiDCoCAtIFJlc291cmNlIENvbnRyb2wgSUQgKFJDSUQpIHVzZWQgZGV0ZXJtaW5l
IHJlc291cmNlIGFsbG9jYXRpb24NCj4gPiA+IMKgIC0gTW9uaXRvcmluZyBDb3VudGVyIElEIChN
Q0lEKSB1c2VkIHRvIHRyYWNrIHJlc291cmNlIHVzYWdlDQo+ID4gPiANCj4gPiA+IFRoZSBDU1Ig
aXMgZGVmaW5lZCBmb3IgUy1tb2RlLCBzbyBjaGVjayBtc3RhdGVlbjAuc3JtY2ZnIHRvDQo+ID4g
PiBkZXRlcm1pbmUNCj4gPiA+IGlmIHMtbW9kZSBpcyBhbGxvd2VkIHRvIGFjY2VzcyBpdC4gSW4g
YWRkaXRpb24sIGFjY2Vzc2luZyBpdCB3aGVuDQo+ID4gPiBWPTENCj4gPiA+IHNoYWxsIGNhdXNl
IGEgdmlydHVhbCBpbnN0cnVjdGlvbiBleGNlcHRpb24uDQo+ID4gPiANCj4gPiA+IExpbms6DQo+
ID4gPiBodHRwczovL2dpdGh1Yi5jb20vcmlzY3Ytbm9uLWlzYS9yaXNjdi1jYnFyaS9yZWxlYXNl
cy9kb3dubG9hZC92MS4wL3Jpc2N2LWNicXJpLnBkZg0KPiA+ID4gTGluazogaHR0cHM6Ly9kb2Nz
LnJpc2N2Lm9yZy9yZWZlcmVuY2UvaXNhL3ByaXYvc21zdGF0ZWVuLmh0bWwNCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEtvcm5lbCBEdWzEmWJhIDxtaW5kYWxAc2VtaWhhbGYuY29tPg0KPiA+ID4gW2Z1
c3Rpbmk6IHJlYmFzZSBvbiB2MTAuMS41MCwgZml4IGNoZWNrX3NybWNmZ10NCj4gPiA+IFJldmll
d2VkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJhZGltLmtyY21hckBvc3MucXVhbGNvbW0uY29tPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogRHJldyBGdXN0aW5pIDxmdXN0aW5pQGtlcm5lbC5vcmc+DQo+
ID4gDQo+ID4gSSdtIGp1c3QgbWVhdCBwcm94eWluZyB0aGlzIG9uZSwgYnV0IGl0IGxvb2tzIGJl
bGlldmFibGUsIGxldCBtZQ0KPiA+IGtub3cNCj4gPiBpZiBpdCdzIHdyb25nIHRob3VnaDoNCj4g
DQo+IElzIHRoaXMgc29tZXRoaW5nIEkgY2FuIHJ1biBteXNlbGYgaW4gdGhlIGZ1dHVyZT8NCg0K
S2luZCBvZiEgV29ya2luZyBvbiBpdA0KDQo+IA0KPiBJIGNhbiBydW4gbG9jYWwgc2FzaGlrbyBm
b3IgbXkgbGludXggcGF0Y2hlcyBidXQgSSB3YXNuJ3Qgc3VyZSB3aGF0DQo+IHRvDQo+IGRvIGZv
ciBxZW11Lg0KDQpZZWFoLCBpdCdzIFNhc2hpa28gYXMgd2VsbDoNCmh0dHBzOi8vZ2l0aHViLmNv
bS9zYXNoaWtvLWRldi9zYXNoaWtvL3B1bGwvNzUzDQoNCkFsaXN0YWlyDQoNCj4gDQo+ID4gLSBb
SElHSF0gSW4gdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYywgbm9uZSBvZiB3cml0ZV9tc3RhdGVlbjAs
DQo+ID4gd3JpdGVfbXN0YXRlZW4waCwgd3JpdGVfaHN0YXRlZW4wLCBvciB3cml0ZV9oc3RhdGVl
bjBoIGV2ZXIgT1JzDQo+ID4gU01TVEFURUVOMF9TUk1DRkcgaW50byB3cl9tYXNrIHdoZW4gZXh0
X3NzcW9zaWQgaXMgc2V0LCBzbyBiaXQgNTUNCj4gPiBvZg0KPiA+IG1zdGF0ZWVuMC9oc3RhdGVl
bjAgc3RheXMgcmVhZC1vbmx5IHplcm8gYW5kIE0tbW9kZSBmaXJtd2FyZSB3cml0ZXMNCj4gPiB0
aGF0IGVuYWJsZSBzcm1jZmcgYWNjZXNzIGFyZSBzaWxlbnRseSBkcm9wcGVkLCB2aW9sYXRpbmcg
dGhlDQo+ID4gU21zdGF0ZWVuIHNwZWMgKGEgYml0IGZvciBhbiBpbXBsZW1lbnRlZCBleHRlbnNp
b24gbXVzdCBub3QgYmUNCj4gPiByZWFkLW9ubHkgemVybykuIGNoZWNrX3NybWNmZyBnYXRlcyB0
aGUgbmV3IENTUiBvbg0KPiA+IHNtc3RhdGVlbl9hY2Nfb2soLi4uLCBTTVNUQVRFRU4wX1NSTUNG
RyksIGFuZCBTbXN0YXRlZW4gaXMgZW5hYmxlZA0KPiA+IGJ5DQo+ID4gZGVmYXVsdCBvbiB0aGUg
c2FtZSBkeW5hbWljIENQVXMgdGhhdCBnZXQgZXh0X3NzcW9zaWQgYnkgZGVmYXVsdCwNCj4gPiBz
bw0KPiA+IG9uIHRoZSBzdG9jayB2aXJ0IG1hY2hpbmUgZXZlcnkgUy1tb2RlIChWPTApIHNybWNm
ZyBhY2Nlc3MgdHJhcHMNCj4gPiBpbGxlZ2FsIGluc3RydWN0aW9uIGFuZCBWUy1tb2RlIGFkZGl0
aW9uYWxseSB0YWtlcyBhIHZpcnR1YWwNCj4gPiBpbnN0cnVjdGlvbiBmYXVsdDogdGhlIFFvUyBm
ZWF0dXJlIHRoaXMgc2VyaWVzIGV4aXN0cyB0byBleHBvc2UgaXMNCj4gPiBzeXN0ZW1hdGljYWxs
eSB1bnVzYWJsZS4gRml4IGJ5IE9SaW5nIHRoZSBiaXQgaW50byB0aGUgc3RhdGVlbg0KPiA+IHdy
aXRlDQo+ID4gbWFza3MgbGlrZSB0aGUgZXhpc3RpbmcgQ1RSLCBQMVAxMywgYW5kIFNWU0xDVCBj
YXNlcy4NCj4gDQo+IFRoaXMgaXMgYSByZWFsIGlzc3VlIGZvciBtc3RhdGVlbjAgYW5kIG1zdGF0
ZWVuMGguIEkgd2lsbCBhZGQNCj4gU01TVEFURUVOMF9TUk1DRkcgdG8gd3JfbWFzayBpbiB3cml0
ZV9tc3RhdGVlbjAoKSBhbmQNCj4gd3JpdGVfbXN0YXRlZW4waCgpLiBIb3dldmVyLCBJIGJlbGll
dmUgaHN0YXRlZW4wIGJpdCA1NSBpcyBXUFJJIHNvIEkNCj4gdGhpbmsgdGhlIGN1cnJlbnQgYmVo
YXZpb3IgaXMgY29ycmVjdC4NCj4gDQo+ID4gLSBbTUVESVVNXSBJbiB0YXJnZXQvcmlzY3YvY3B1
LmgsIGVudi0+c3JtY2ZnIGlzIG5ldyBndWVzdC13cml0YWJsZQ0KPiA+IMKgIGFyY2hpdGVjdGVk
IHN0YXRlICh3cml0dGVuIHZpYSB3cml0ZV9zcm1jZmcgaW4NCj4gPiDCoCB0YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jKSBidXQgdGFyZ2V0L3Jpc2N2L21hY2hpbmUuYyBuZXZlciBtaWdyYXRlcw0KPiA+
IMKgIGl0OiB2bXN0YXRlX3Jpc2N2X2NwdSBoYXMgbm8gc3Nxb3NpZC9zcm1jZmcgZmllbGQgb3Ig
c3Vic2VjdGlvbi4NCj4gPiDCoCBBZnRlciBsaXZlIG1pZ3JhdGlvbiwgc2F2ZXZtL2xvYWR2bSwg
b3Igc25hcHNob3QgcmVzdG9yZSB0aGUNCj4gPiDCoCBkZXN0aW5hdGlvbiBDUFUgcmVzdW1lcyB3
aXRoIHNybWNmZyA9IDAgd2hpbGUgdGhlIGd1ZXN0IGJlbGlldmVzDQo+ID4gaXRzDQo+ID4gwqAg
cHJvZ3JhbW1lZCBSQ0lEL01DSUQgYXJlIHN0aWxsIGluIGVmZmVjdC4gQWRkIGEgdmVyc2lvbmVk
DQo+ID4gwqAgdm1zdGF0ZV9zc3Fvc2lkIHN1YnNlY3Rpb24gd2l0aCBhIC5uZWVkZWQgcHJlZGlj
YXRlIG9uDQo+ID4gZXh0X3NzcW9zaWQsDQo+ID4gwqAgZm9sbG93aW5nIHRoZSB2bXN0YXRlX3Nt
c3RhdGVlbi92bXN0YXRlX2VudmNmZyBwYXR0ZXJuLg0KPiANCj4gSSdsbCBhZGQgYSBWTVN0YXRl
RGVzY3JpcHRpb24gZm9yIFNzcW9zaWQuDQo+IA0KPiA+IC0gW01FRElVTV0gSW4gdGFyZ2V0L3Jp
c2N2L2NwdS5jIChpc2FfZWRhdGFfYXJyKSwgU3Nxb3NpZCBpcw0KPiA+IHJlZ2lzdGVyZWQgYXMg
YSB1c2VyLWZhY2luZyBleHRlbnNpb24gYW5kIGVuYWJsZWQgYnkgZGVmYXVsdCBvbg0KPiA+IEJB
U0UzMi9CQVNFNjQgd2l0aCBubyB0ZXN0cy90Y2cgY292ZXJhZ2UgYW55d2hlcmUgaW4gdGhlIHRy
ZWUuIFRoZQ0KPiA+IFJJU0MtViB1cHN0cmVhbWluZyBydWxlcyByZXF1aXJlIHVuaXQgdGVzdHMg
Zm9yIG5ldyBleHRlbnNpb25zJyBDU1INCj4gPiBhY2Nlc3NlcywgYW5kIHRoZSBzdGF0ZWVuIGdh
dGluZyBhbmQgVj0xIHRyYXAgcGF0aHMgYWRkZWQgaW4NCj4gPiBjaGVja19zcm1jZmcgYXJlIGV4
YWN0bHkgd2hhdCBzdWNoIHRlc3RzIHdvdWxkIGV4ZXJjaXNlIC0tIHRoZXkNCj4gPiB3b3VsZA0K
PiA+IGhhdmUgY2F1Z2h0IHRoZSBicm9rZW4gU1JNQ0ZHIHN0YXRlZW4gYml0IGFib3ZlLiBBZGQg
dGVzdHMvdGNnDQo+ID4gY2FzZXMNCj4gPiBmb3Igc3JtY2ZnIHJlYWQvd3JpdGUsIFdBUkwgbWFz
a2luZywgYW5kIHRoZQ0KPiA+IHN0YXRlZW4vdmlydHVhbC1pbnN0cnVjdGlvbi1mYXVsdCBnYXRp
bmcuDQo+IA0KPiBJJ2xsIGFkZCB0ZXN0cyBmb3Igc3JtY2ZnLg0KPiANCj4gPiAtIFtMT1ddIG5p
dDogaW4gdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYywgdGhlIGNoZWNrX3NybWNmZyBjb21tZW50DQo+
ID4gc2F5cw0KPiA+IMKgICJ3ZSBuZWVkIHRvIHRocm93IGFuZCB2aXJ0IGluc3RydWN0aW9uIGZh
dWx0Ijsgcy9hbmQgdmlydC9hDQo+ID4gdmlydHVhbC8uDQo+IA0KPiBJJ2xsIGZpeC4NCj4gDQo+
IFRoYW5rcywNCj4gRHJldw0K

