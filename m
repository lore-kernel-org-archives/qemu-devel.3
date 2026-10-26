Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B5606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Hsi6ua0W;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=sA0uYq5T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLBrk-000143-Pn; Sun, 25 Oct 2026 23:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLBri-000132-1I; Sun, 25 Oct 2026 23:59:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLBrg-00029z-0A; Sun, 25 Oct 2026 23:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792987155; x=1824523155;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=z3mjqdxU33GCLJZ4xvmB6GVVZM2voSkSiGMuEdU5hho=;
 b=Hsi6ua0WIu5S3b9HXh56r8YZ1YKNYYkUuGx/2t8mR3S3s/6BYlVYSSEw
 w100f4X0WSuYVDNiW9LJjkt+UUPTp9FnLfYO8TagbiX7XE1ORm22aIPNr
 rfKv4QJNuX8wiwkEgtRF62yMu0O/TmZl03jnV74mxOmbTf39Tq9LGq+JL
 qzpb2qXwdqkbMwaffiZQxuse2GehDZM6UTHvD6WteCbLjSNN7FNpaONK8
 /1K2sTu5NreN+CMAWRgiSyMkE+wbJVdLAONCxE5PMeKopsEKVyKNrRaja
 qkiR9YoOMLPL5+Kh9iGjCixPGCw0QT/R8EGd9IPLs13LCPWPyHOQVtYqy w==;
X-CSE-ConnectionGUID: 7/TtwoMnRqWVVIcCw9409w==
X-CSE-MsgGUID: Sqh5jcHPR6ue7L9yk+2ing==
X-IronPort-AV: E=Sophos;i="6.27,178,1786982400"; d="scan'208";a="157376360"
Received: from mail-westus3azon11010031.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.31])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 11:59:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcoBQc0FDPBBQVnIOb7PvJOWjHphenkM23owh5XWQ7bwEnhi9BBVSHK8C2h0X7AvjaTRh+RaX3DLgM9PqkXJVukMJu6qzAm0V/6fRF9AxxLjrMwRHIkuWlVylOQdLrYY9G+W/HN+8CK1kKxyyKgN5lPaRgqfyU5HfG/NwJTjGJWzOxVA89xvZDNgL4MgnQ1xUs9RMXqSRzSIiK1mFX+bvovQosDj5k1NOdKGmcMX9vFMiRVkz/8yw6b5ri6uPgVF3KwlVKbXjodpjRCs1AMFrLPNfmEBqQgHz4xKOhrBayNEgKnU/Zrrwm8k/qEtaut/FYWZexnanBDYtZFwAh3Q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3mjqdxU33GCLJZ4xvmB6GVVZM2voSkSiGMuEdU5hho=;
 b=L9mHAQy0yf1+njHQcu9TxzxxSCfusptBsxUKGLJ9Yn+o8+mwet7G+18JFohBR84c68VhOU9ihabEOlrqDHc3XJA7sgv3pIEaKF7yvCU8jkQbzruosoYuOhGY8k3ma0l5fmDwe4Pmwy7o+MQPHIaKZ7Z31LN/opql9fquojoNcvgoN3hSJP3iYOMJaeLlYbjyK3mb8EAf3Vt9XtX/8kVE/q9UUHs4RKnx1EkMIS7lM66YNPmA7nogbHY8ve7evpAlzkBnWdfa4Bnhu0s0PV98CkdPgTsJLGhNBRW2S7QFwEX1pCR+Vgrsmbiia5OEypZlUHl1gCqiTSRkUD9R20DC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3mjqdxU33GCLJZ4xvmB6GVVZM2voSkSiGMuEdU5hho=;
 b=sA0uYq5T91vaqi/J3P9GUwPed/HT2O4Albkqn0y+uV9HAj5BfpwiSe9UHBRuk/FmKh6VWEA6Apniomz4MUBBeWbb9aPwhuhg6YziQtTRvG8LKUNoNHLzZf4pO3JaLZ+9GIjAbCVNzz0w3HU1XgBJVQwtByB7Wjvpl/oJ7Ecd0QE=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB7106.namprd04.prod.outlook.com (2603:10b6:a03:223::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:59:10 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 03:59:09 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "anjo@rev.ng" <anjo@rev.ng>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "tcalifano@redhat.com" <tcalifano@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2] target/riscv: Fix CPU state access on big-endian hosts
Thread-Topic: [PATCH v2] target/riscv: Fix CPU state access on big-endian hosts
Thread-Index: AQHdYrdB0dQdGDkxQUqgsYEcI8Z837cPN0QA
Date: Mon, 26 Oct 2026 03:59:09 +0000
Message-ID: <55735582a8a0cff61d659a7643c29c3c285e305b.camel@wdc.com>
References: <20261023063025.8827-1-anjo@rev.ng>
In-Reply-To: <20261023063025.8827-1-anjo@rev.ng>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB7106:EE_
x-ms-office365-filtering-correlation-id: 97fc9f04-7ba8-452d-ca81-08df33157d45
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|19092799006|23010399003|366016|1800799024|38070700021|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ZNlxpH1vUnnj/rO3egGXkZWScVArVKt3R9XCc7NS6S/26tLLZ69MRYNYP1qfWaJZcPt8pKuU+3SB0ilzq8PDma7RtboaxnV8eZ2SxADEXEkEcVZw6l43wydx0Q5S2lHQ5MLhbZFd2KSUwUlAKHhvUIgdWgI6WPT++JMP8A8lAZQGo7wptkxQ3CjvaUqoU3Hxkkyw33BGfaq+acTc/AsQEUfbbJlukztd1ArLg4TMCxFG+g9SXH8DjYtatNFjUFjrML7ebGn8kRPPeBhAEDOXJ70CW54VFzggZdtwDqRiaumrSd9jHxEpIVQ8jwP3/kPTll+7n3RV/B+gDNJqRwTj/2AnucwMuGQ1c0bda2S4b5W2cJihmmKG3ze0X0WpgH7SBrJOQDP7I9rboS42LPbRtdm+KKXesLGTy+2NaGUJHqyPcpwGHbQ6xgwSz4sAAiCOxaECkNYnOUCb4geEVATJ+HqfbgdQwJGtohQC2Yhm/7PIF5/Pec08ajwjfj3xJkkgAkvpBJCEUgQPCSDAyvCYjELGr3KNFg4Xfid3QYJvbZSPmrUkzXjDOcDCYseaVfLA4KMkUz1GkcTF0KWor5MEPlC3tPznU/e0Hof5riVgABDWJAyeahDtdZar+DC+iMJw2knHXBi0BZrCgmqoHPCrBj0d220KjfG8D1JJA6OBFQESS0JMWCETmposH6bRTxPw+pitY9cugJFasG284KBPaYySEIzKxyECJfvPgRS6bIw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(19092799006)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNRUHZBODd4ZTFqUnFlcWpqUTFkbmo3ZStGREhuMG5xOEgxbkc3ZTU4UVBV?=
 =?utf-8?B?QUhET2lQY3VQZ0FMcDQzcnhGTStWK0JSeWp4dUhmVWxRTlBTZDA3NmQ2U05P?=
 =?utf-8?B?MEl6R213Y1RzTjNzcnk0aldiVGhYVVNMN0pPVkhFNERTSWRTMkRVQnZ6NTBK?=
 =?utf-8?B?MHA3TnBZRUhYK2lyTHdXMlJGQkZwbkJCcWRIRXREL0xsVzR1N3BXdXB3MTNs?=
 =?utf-8?B?VkRlV2lhUzVrU0JxeEZqbjMrNEoyOFFvcGtUMmZ0bXlmeGFvY240QktXOG1k?=
 =?utf-8?B?TVZFQ3ZYQnQ1eUFNb09KSkJmMzZ0a1NUbHpUNmpkTXVLSFJudmF2M2E2a2NS?=
 =?utf-8?B?M2dXdFNIT2ErNXp5WnFMcTYvNVB4UVRGcG94MExzQzduaEFkV2RpVlhJRVpL?=
 =?utf-8?B?RGpicXNTYjBtTnNWeEtnMTNyOVlEanBqT1NpRkdmOUZYbzFmNlA1RzlBUndM?=
 =?utf-8?B?Y1p4RDVjWWNnNFdzSlVvYm1ObmlyWi9yNEM2TlVzYUtTMUw3b0NZak96OHRN?=
 =?utf-8?B?QmQ3QWhORi84YzdhVGxHeDBHOFltZEQ1cy9PZ09hV05oaWhGWUVNOWxTS2VH?=
 =?utf-8?B?cFhNVXJkUnI5eFRONmw5b0o1YUdzUVliYUFiWkxUN2prNFBkM2xETXJFeGxW?=
 =?utf-8?B?cFVseHROdE1XSUVhVFYvb3cycjU3R21CbFhXMTBkdW8ySjFOWCt2dmdpeXYy?=
 =?utf-8?B?MzBRNXBkSVJJZVpueVNLeGtRTS9qUUxkV2JTck9UYmRVb3BsQkR2S2trZTYv?=
 =?utf-8?B?RWhnMW4xTzlHbUFFUzNKMEhWbnVxdVZLSHVsWnJLbVhlS1NyVGszSERORHlD?=
 =?utf-8?B?OTE2bUNBVVFVWXExZHFEazVNRVJWOEdsSldRd0o1MnJRR2dqQlZVWGE0V2th?=
 =?utf-8?B?RUxKNHU2SGJpbWR4dWoydGJnWThnWiticFJXSkFqcTBKcTMvNWJmT2JnMnVs?=
 =?utf-8?B?QzNMN1VkMXdxYjluMmFLNmdUWTR1WDhDcHhzdEFucGFIWXZOTzl3em9Jd3BB?=
 =?utf-8?B?bGZ3eGNOWk9lQzVFZzVrQUlCWmhMNXIxd3dlZFhTTzdnYTVMWXF2TWtwNzRi?=
 =?utf-8?B?VW1zY3RzUS9qMXY1N1M4NC9PZlA3KzRZRE1ic2Q4TFFaTUxsS3czQjVUUUdi?=
 =?utf-8?B?cStpWU1OT1hHZ25lRml1a3VUemk4alpabTRzNEkvU0xUbjU0QW9tak9lSUFt?=
 =?utf-8?B?YU5OWmp6RDFuRTB4ajNmK2lrYVNuU3hxbDJKV25mdUF6TmE3Q1VQNlBPL2l2?=
 =?utf-8?B?a09MTXNBcDNTQk40YUp0QVEvR2lTU1Z2MWZTamNicGUxMVRUbzcxcjF4c3Rj?=
 =?utf-8?B?MDV3WkIwdTRGcHMwOEY4M25UbmF0ZmRTSjdtVlpsSjNBVXlQYmw4RW5OQWNM?=
 =?utf-8?B?V3pSMGR6Y0VpWm4vWWFEUHZaVjhTWnJrUEFJVEFnZkNHclpxV2ZTMmpRQ0Zy?=
 =?utf-8?B?d09hVUJIdVh3RmJ3UE4xbU5QV0VkK3EydzdiL2g1NlhWUG1IRW9KK3E4Uloy?=
 =?utf-8?B?UjdTaGZvOG1lUmFaVHBsblRxcXl5S0VuYUVYejl0bFVGVUhJNkRacUVDblpM?=
 =?utf-8?B?RjBScmhMdUZ4K2Qwb3dNRjlZakZpaUdrZVY5Vy85QjBZSmwzdEhQT09kWGNa?=
 =?utf-8?B?SG1xRFVuZ3ZOdWt5c0p0dlQzQWlNOWd3YUk1T2xDUUg5aEV2M0FYWGZEbURS?=
 =?utf-8?B?bDhmWHU0ZEhSNFlKSVR6RXRNSFVFZWJGbjlOQ0t4RlBxWC91QXFzMnd5UzEx?=
 =?utf-8?B?TGtSb3Bpd3NETngzcDVkSTlsSi9hTWZJL1phYnppNHpoQ1RISW1MVEtSN2RY?=
 =?utf-8?B?K05DSWNYUm45Vy9SVnVJSmJWM2tiU1d0Q3A3dEtYTGFQcnlvOVFqQktNM0Iz?=
 =?utf-8?B?aWtlYmNHRGFHQnBuRTdrcUw2ZFBuaGNqdysvd29vVGFYZjRlaGdCY1pieGFP?=
 =?utf-8?B?YnVuWEcvZVdFMlNWZU5zSC95S3VxQ1hDWm1ON2l6V2docXRHb2NQdUx1UDYx?=
 =?utf-8?B?NnRMNlpJZU41Q1lzaER6djFLQlhiU1VxRjNla2wzVDhOVFlEbTRFMDA5V0N2?=
 =?utf-8?B?SENmbDZnQ0dKSTlwdkc4anBydmFBRDRIQVhLSWM5czN2UkFJMHByakh4SzlB?=
 =?utf-8?B?L1QrNmZ2QlpkKzlqeDdRazJjcUhrTEZmcWZST1VzNjdmZnpmVm5qdTBxbjNX?=
 =?utf-8?B?dllUNjkzZit4MWhJTHNWUWt6NklEQm51R2k5Z1d2cXFscEpXcUR3RmR4Y0Iy?=
 =?utf-8?B?aEI1YjVZQ0dneDF6WDZ1Z1JpNitkWEE5MWgzU2UvZ3lHcTZicSs1ZjlFeHB0?=
 =?utf-8?B?TWlRZEMzRTJQVUZwa2VZdmJwd2ZIWTRXeGZwMnJLSllHODYwL1NVL1ZwTnU3?=
 =?utf-8?Q?LhItC8AAbM0WaZ7Lms7iv4VFS4t9Z8RA2DkNRaS5MiKbN?=
x-ms-exchange-antispam-messagedata-1: 3TRhpX8r1Vh5cMRIftfdwBilzXIRvA+Ltj4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71E2493725E753419C9B73049142BAAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bt0QGm8ujLmHXFlhMrS/xfZ5rHOVD1DtGP4B2QAUBoHG4Xc3i+LyZAsnTxdoNd1IJPv9j6+gl2WFXVbXErRIPOCBHcq2YFxKS5EykUSdkpVt6AFU2eo4juUBPGpxUyCOSSrCsJhU8853wFUq4AU9FJQ4omfRA6sAEUZ8RY/fUF/LvArl310UqgDhrxm0FPglxBfvVTmA/Sc5d7u4Nsvmjx9B3QUOium6LC+yg1P1obpDfe2929Qj+3e7EQGW3aHkp0Iv1byHMRdSg7sSkwh1upf6Yk8XTAERY01cEwMB8cXYzPisEoxY6IWTOHa7c2yLPCMlF26EmBz81qHs76yUeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B84y9BsKk7J5No7+Vn3gAcL9pOmPM563bsYhRrtqTgMYV+mf+2OyF2HG+a+YH+cc7J5jCwvOGnMOHh5kecQ62i7tW5HOMPnDXsHt2J+N62LfiFTHXv8g7m1Om82XIraaujtbQQElOcMWCbLBmjT7Mo52cYok3WGsFdkTxjG58wAUy2fQz6cG27z1A/UPxNrlGKfAMm5i6GiMpHZROFBLjhiohDhjFDMlGhvWwuTE6MCRAHGS7emOR5WIpw48IFBpdLcsejxzjEx6X4/Kvorz/myA/CK13ZXlZZifExHxYle6vuETx2/bL0gjyv70u2JHQZpfPSoakyWo6QnoNrfMjOCvDTbI77PbW2ZqhSDCUHHbMso5f7t97vbmf6MapmnBXgxAdEpfPKoFSHfSGI7fflkxWV50pZqgr6uEUNpDSwk/Ck9xj9r2SR6/Dr+pbfaRXI665bZIUafYKVcATOjfQ/hR/uyklmQrGEar3g8ie9507ZbGyv87bL4VFOFTBMylYVWy+7xcjT6MNr7XFCvwwAiyfDJCDlDZ2mp/a4ZPsyVW/7M2T/uFGU8EVQQarHYMkrK2IbFhRcyFTiXU194mZFQyPcdBDRhDVwUj6Cn7HuwE2B/EPbHNLB6yal9sa3DG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fc9f04-7ba8-452d-ca81-08df33157d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 03:59:09.8497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IccqF3/WGeuTEX79Mbp55ftIlhVw2RyRFbDsvq4QXgCMff4QH9nAnu2fLgPu3kTBSn2rsb3Gz6obfGf2FCOtuwAaGrgfWHfFV/DixuHkd3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7106
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDA4OjMwICswMjAwLCBBbnRvbiBKb2hhbnNzb24gdmlhIHFl
bXUgZGV2ZWxvcG1lbnQKd3JvdGU6Cj4gbXN0YXR1cyBhbmQgbXN0YXR1c19ocyBhcmUgdWludDY0
X3QgYnV0IGFjY2Vzc2VkIHRocm91Z2gKPiAKPiDCoCB0Y2dfZ2VuX1tsZHxzdF1fdGwoLi4uLCBv
ZmZzZXRvZihtc3RhdHVzKSkKPiAKPiB3aGljaCBvbiBhIGJpZy1lbmRpYW4gaG9zdCBydW5uaW5n
IHJpc2N2MzIgaW5jb3JyZWN0bHkgYWNjZXNzZXMgdGhlCj4gdG9wIDMyIGJpdHMgcmF0aGVyIHRo
YW4gdGhlIGxvd2VyIGJpdHMuCj4gCj4gV2lkZW4gdGhlIG9wZXJhdGlvbnMgdG8gNjQgYml0IHNv
IHRoZSBsb3dlciBiaXRzIGFyZSBtb2RpZmllZC4KPiAKPiBGaXhlczogMjg0ZDY5N2M3NGVmICgi
dGFyZ2V0L3Jpc2N2OiBNZXJnZSBtL3Zzc3RhdHVzIGFuZCBtL3Zzc3RhdHVzaAo+IGludG8gb25l
IHVpbnQ2NF90IHVuaXQiKQo+IFJldmlld2VkLWJ5OiBUb21tYXNvIENhbGlmYW5vIDx0Y2FsaWZh
bm9AcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2
Lm5nPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuYyB8
IDMyICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi90Y2cvdHJhbnNsYXRlLmMKPiBiL3RhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmMK
PiBpbmRleCBlZGU5YzI1NjNmLi43OWIwZjQ0NGVmIDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNj
di90Y2cvdHJhbnNsYXRlLmMKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3RyYW5zbGF0ZS5jCj4g
QEAgLTY5Myw3ICs2OTMsNyBAQCBzdGF0aWMgVENHdiBnZXRfYWRkcmVzc19pbmRleGVkKERpc2Fz
Q29udGV4dAo+ICpjdHgsIGludCByczEsIFRDR3Ygb2ZmcykKPiDCoCAqLwo+IMKgc3RhdGljIHZv
aWQgbWFya19mc19kaXJ0eShEaXNhc0NvbnRleHQgKmN0eCkKPiDCoHsKPiAtwqDCoMKgIFRDR3Yg
dG1wOwo+ICvCoMKgwqAgVENHdl9pNjQgdG1wOwo+IMKgCj4gwqDCoMKgwqAgaWYgKCFoYXNfZXh0
KGN0eCwgUlZGKSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+IEBAIC03MDMsMTUgKzcw
MywxNSBAQCBzdGF0aWMgdm9pZCBtYXJrX2ZzX2RpcnR5KERpc2FzQ29udGV4dCAqY3R4KQo+IMKg
wqDCoMKgwqDCoMKgwqAgLyogUmVtZW1iZXIgdGhlIHN0YXRlIGNoYW5nZSBmb3IgdGhlIHJlc3Qg
b2YgdGhlIFRCLiAqLwo+IMKgwqDCoMKgwqDCoMKgwqAgY3R4LT5tc3RhdHVzX2ZzID0gRVhUX1NU
QVRVU19ESVJUWTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoCB0bXAgPSB0Y2dfdGVtcF9uZXcoKTsK
PiAtwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9sZF90bCh0bXAsIHRjZ19lbnYsIG9mZnNldG9mKENQ
VVJJU0NWU3RhdGUsCj4gbXN0YXR1cykpOwo+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX29yaV90
bCh0bXAsIHRtcCwgTVNUQVRVU19GUyk7Cj4gLcKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fc3RfdGwo
dG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXMpKTsKPiArwqDC
oMKgwqDCoMKgwqAgdG1wID0gdGNnX3RlbXBfbmV3X2k2NCgpOwo+ICvCoMKgwqDCoMKgwqDCoCB0
Y2dfZ2VuX2xkX2k2NCh0bXAsIHRjZ19lbnYsIG9mZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0
YXR1cykpOwo+ICvCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX29yaV9pNjQodG1wLCB0bXAsIE1TVEFU
VVNfRlMpOwo+ICvCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX3N0X2k2NCh0bXAsIHRjZ19lbnYsIG9m
ZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0YXR1cykpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDC
oCBpZiAoY3R4LT52aXJ0X2VuYWJsZWQpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2df
Z2VuX2xkX3RsKHRtcCwgdGNnX2Vudiwgb2Zmc2V0b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVz
X2hzKSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9vcmlfdGwodG1wLCB0bXAs
IE1TVEFUVVNfRlMpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fc3RfdGwodG1w
LCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXNfaHMpKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX2xkX2k2NCh0bXAsIHRjZ19lbnYsIG9mZnNldG9m
KENQVVJJU0NWU3RhdGUsCj4gbXN0YXR1c19ocykpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRjZ19nZW5fb3JpX2k2NCh0bXAsIHRtcCwgTVNUQVRVU19GUyk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdGNnX2dlbl9zdF9pNjQodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0
YXRlLAo+IG1zdGF0dXNfaHMpKTsKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoCB9Cj4g
wqB9Cj4gQEAgLTcyNiwyMSArNzI2LDIxIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtYXJrX2ZzX2Rp
cnR5KERpc2FzQ29udGV4dAo+ICpjdHgpIHsgfQo+IMKgICovCj4gwqBzdGF0aWMgdm9pZCBtYXJr
X3ZzX2RpcnR5KERpc2FzQ29udGV4dCAqY3R4KQo+IMKgewo+IC3CoMKgwqAgVENHdiB0bXA7Cj4g
K8KgwqDCoCBUQ0d2X2k2NCB0bXA7Cj4gwqAKPiDCoMKgwqDCoCBpZiAoY3R4LT5tc3RhdHVzX3Zz
ICE9IEVYVF9TVEFUVVNfRElSVFkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgIC8qIFJlbWVtYmVyIHRo
ZSBzdGF0ZSBjaGFuZ2UgZm9yIHRoZSByZXN0IG9mIHRoZSBUQi7CoCAqLwo+IMKgwqDCoMKgwqDC
oMKgwqAgY3R4LT5tc3RhdHVzX3ZzID0gRVhUX1NUQVRVU19ESVJUWTsKPiDCoAo+IC3CoMKgwqDC
oMKgwqDCoCB0bXAgPSB0Y2dfdGVtcF9uZXcoKTsKPiAtwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9s
ZF90bCh0bXAsIHRjZ19lbnYsIG9mZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0YXR1cykpOwo+
IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX29yaV90bCh0bXAsIHRtcCwgTVNUQVRVU19WUyk7Cj4g
LcKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fc3RfdGwodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVS
SVNDVlN0YXRlLAo+IG1zdGF0dXMpKTsKPiArwqDCoMKgwqDCoMKgwqAgdG1wID0gdGNnX3RlbXBf
bmV3X2k2NCgpOwo+ICvCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX2xkX2k2NCh0bXAsIHRjZ19lbnYs
IG9mZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0YXR1cykpOwo+ICvCoMKgwqDCoMKgwqDCoCB0
Y2dfZ2VuX29yaV9pNjQodG1wLCB0bXAsIE1TVEFUVVNfVlMpOwo+ICvCoMKgwqDCoMKgwqDCoCB0
Y2dfZ2VuX3N0X2k2NCh0bXAsIHRjZ19lbnYsIG9mZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0
YXR1cykpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3R4LT52aXJ0X2VuYWJsZWQpIHsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX2xkX3RsKHRtcCwgdGNnX2Vudiwgb2Zm
c2V0b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVzX2hzKSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdGNnX2dlbl9vcmlfdGwodG1wLCB0bXAsIE1TVEFUVVNfVlMpOwo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRjZ19nZW5fc3RfdGwodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVND
VlN0YXRlLAo+IG1zdGF0dXNfaHMpKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2dfZ2Vu
X2xkX2k2NCh0bXAsIHRjZ19lbnYsIG9mZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0YXR1c19o
cykpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fb3JpX2k2NCh0bXAsIHRtcCwg
TVNUQVRVU19WUyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9zdF9pNjQodG1w
LCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXNfaHMpKTsKPiDCoMKg
wqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoCB9Cj4gwqB9Cg==

