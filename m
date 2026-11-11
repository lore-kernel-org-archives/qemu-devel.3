Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC3606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bq01QP7m;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LOtkhpCA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0I6-0003qh-3V; Tue, 10 Nov 2026 23:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0Hp-0003hN-Tg; Tue, 10 Nov 2026 23:50:19 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0Hl-0000U0-Uy; Tue, 10 Nov 2026 23:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794372614; x=1825908614;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3eyPXiNFg8uXaDx8U24figQ4RRb6x5q0c5mzQQ7pflc=;
 b=bq01QP7msSFW4YV5RQWIW1bXA7POnxj0kMEPLsQFJftg/J5gp4t8K0Hv
 GRxNyrm1bx/7UoraQ8YS8w8QVzMZSTxX3vd1ppcpWOKDMzbmpYUevLEpn
 7LAz5TL5+FkoKFoqGg77jKO+9QfpfkduGxU8DwaB4HsXTnNVQocaq9dYF
 NED+5AEgcJlcgwROeMI4SHKuDPCCEvcOJv+5AO4Em+8yGX70+PUZt+f8C
 RyyeAmuZHHi0eiaC75y1NQuO1xWTuNyh8hTW9qCkDNGGAfl/P6zGTsSQG
 wsAisHhnrbZLfo3qdvZZ0J7mcoUDrYE8LgtPoqJKutDURt+0RR1Dcf1rr g==;
X-CSE-ConnectionGUID: EzUykSCTSCefWSRNK4DAGA==
X-CSE-MsgGUID: 6j3U0Cy5TkK06qYUfBiTIQ==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="160602656"
Received: from mail-northcentralusazon11013050.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.50])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 12:50:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlMyNqoW4qGfymAdzS4zwlxbm66FX+nz6AlRoUJYPjK65jo1afS7LZfPYWIoJw7QMBoIkrgrpZLyJH/uKPhzYTyBtkxizENTZtoQrsEwTOeq7eGZ7qsLssXmzC/HuJbUvThPnZCtnjBG9vGSomqOAgsKygvaO+Ci6uPO9xlv7G00gU9KprzwMv3AbqCojXs7RIVE+EhoFPHEPw0xgUnEEBLr3CjhaK79OnduAHPUm8EwwT0/m5iYR4Kid4A6X92uS9C5aP4ORJfQo1sSyOAaKII1KClWDBR7xYHzbW0Js7+8Q34vSDucdxovZdImXl45n84L1LrlyN1AzTt+wZf1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eyPXiNFg8uXaDx8U24figQ4RRb6x5q0c5mzQQ7pflc=;
 b=yLdFg1rrTDj97Od15WOoHM1hg5jsqVzxjQsxS//1sZElqpahXn3hn1zmlWfclDzyHPHuM6D2yBL1Wg+zoksRTsyJhHvCAaSHmkwZGO4ze2f3LsHQ4pZfhbkdMiihqnVC0+KILrwrIRQLd+55MPnfwK/UWFbEYaRzOxEWOZyBUPEmZRSYX3TYUJnAYRtIdt2VTgm+FPtqiXH/3igRvzVgQeTOqdsmByfZ2XicOpjeasrwxSQ5NNTWcuahb691ige2CoJjOxMKaSw6g1DDq0DPLX98jKRLcFEXKjVwE5PRFkqcHNlbE9w/VHHmLB0Z4wp1gswffkwYSUAjVKGKiiywVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eyPXiNFg8uXaDx8U24figQ4RRb6x5q0c5mzQQ7pflc=;
 b=LOtkhpCAY0L/GThBUQ/d00XkiwIi5D1oNFpJsOCpg+t1liwYbv3rJaeNlP13i/Vn3aoD6xkEGxjIXeam1QzeZntfTztx/pU7BVV2vGZ/pCQw8MteeQvYHa7cbqOHJidM7ovRJeu9Y+qLkuN6pPVh1oeDpF9tewjO2gc57AxVj/I=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by BL3PR04MB8201.namprd04.prod.outlook.com (2603:10b6:208:348::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 04:50:08 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:50:08 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "ralf@vmexit.de" <ralf@vmexit.de>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "ralf.ramsauer@oth-regensburg.de"
 <ralf.ramsauer@oth-regensburg.de>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "lukas.landgraf@st.oth-regensburg.de" <lukas.landgraf@st.oth-regensburg.de>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v3 3/4] hw/riscv/sifive_u: derive PLIC contexts from the
 harts
Thread-Topic: [PATCH v3 3/4] hw/riscv/sifive_u: derive PLIC contexts from the
 harts
Thread-Index: AQHdYmMPtafAgN7vkE6C5n1n8Faygbcoa3mA
Date: Wed, 11 Nov 2026 04:50:08 +0000
Message-ID: <2b77b8699d1f0db5f9a7b16498d6af873e6a55e9.camel@wdc.com>
References: <cover.1792700406.git.ralf@vmexit.de>
 <f5bffbbaf8272e743f184e9f5681ec5931800e23.1792700406.git.ralf@vmexit.de>
In-Reply-To: <f5bffbbaf8272e743f184e9f5681ec5931800e23.1792700406.git.ralf@vmexit.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|BL3PR04MB8201:EE_
x-ms-office365-filtering-correlation-id: b16de9bd-9b91-4955-496d-08df3faf42e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|376014|7416014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: laQbF9Jcgd3RR/ZocUyP80lilWTAtIK4Qv9v2EHIVjEJFtOaLo76SrU9jnNlhzHmCId1BJ3lqDklBEHNTyrsvIjlJvJmp0y3llMbCdTNA3mhbLjcttEfzvLj5NlIPZirilxNx/zgTAGd4ZXBRFIC8dShE9OeDAqurExWodhMO/T14h39QCgdgor4U2duuUalcntT55v0XxELHw1eMp1PP/tLHRoGG0KXhDxgA94AJ0k5cBKD0otHghOctPRODYpr1hWHGZBlg17RdavirBMj7D1x6EjQ2PQGNCx9LiIMBLMjLR2KV8U6VLdSbkrYYmRxBeAzELh3FzuNIeXj0aW306FrLg/61J3dfu5EPzR3xQhko9urllLvsOhxF0S3VE7lX0xFX7AzBjl8UIeAk/GgLef4ka4niOoSwhmdySLHaICOeeYGEvy42v+sMDcVkPyu2TZi0/SP9MUWYCd9zHUqsinp3HVFsQFMQd7Qty9DjKKVGYhGWQPJfImtXS1lx5YbXCXsoaZdi9CMn2eXU/mMkUTvLxgxj8A+2EaXQ9Bx8VnpGDs8slO32+J68f2cYQYp44GyqJge+JlVaIF68/J7T2pS8hs1cFoXl+xAjk3EWA9ntC/kce0StT8rYCD6urncWcN2SaXZjpzPwRHVpuq16OlMJFgLNW78ayu/NbbYBgZVmQ7cff/53gqsoeh/3Kl2QSwUGMya9HwssCA0HToL4mmFysXfJNVyknSHl08Fuqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS8rN0NqT2NqamwvL21vV2RqU292ZTl2VGw4cDNxM1VlZGpWaEVrNWs4WXhz?=
 =?utf-8?B?S0JxTXBrQVpjN2dCU3d1VllTa29SMTZJOUdwNVNyWjFyTEpESlVOZDJyTnYw?=
 =?utf-8?B?TXVtV0NCM2FQekordEVzMFVHTy94YjR3ZzczdXpHSnNDTFBseVdLcllNelp0?=
 =?utf-8?B?MzVHMkpMTmFHbkpXWUl1MDlXSFRweHBRN1cwUUtvazNtY05KSXJjcGx0bHZU?=
 =?utf-8?B?YkMrMnZpSENwcGtvVWlJUHRubVhWZjVNc3Y1bWFwTnlndWoxdXdRamU5bDJz?=
 =?utf-8?B?alI4bnNHNm1iRytnd1RnWGx5Y2R1TTNlOWxRdW9EY2VjSnc1MnlMY0k2UXQ5?=
 =?utf-8?B?UGZ4eUxmRllpRk1QZnBrcnBFVG5vSzE2aDFYcS9pOFE3YXZteWFpbWVSY0RR?=
 =?utf-8?B?a0FJRDZFenhrTU5mSG9zNVB1QjFGeHZFYzVzSWZ4Q3NhbnBWRXZkNWFyVUVD?=
 =?utf-8?B?Tnl4Q2VYMXc1UnlucE4wcEs2SWpocUV0aVoxNmtuQlY5bmlscG81Zm5Xc2p0?=
 =?utf-8?B?ZHEvMEdVQVo5OG5qMmkrODAxK0IrUW14QjhhTlVCSlh0bk81MDhoc29DcDBU?=
 =?utf-8?B?Z0g3NWpTTlE4UFRlZVVqMkFyYlBxVkQ4UWE0QWhYaFo2MEkvTWlPSnhsbXFm?=
 =?utf-8?B?RUFFY21ndXRjQjl4Q1lSTENYZTMxQlV5NTFEdkJoVFFZU0d2UkJXVGtENjE5?=
 =?utf-8?B?M2JUZDZXOEQ3b0lITEt5aTZscGRXNkZIbzhtUzNRd05xU2NzUU9qMmhzcTJy?=
 =?utf-8?B?eHV3TmpucXNkTUs2VDFhNVNPNGtYQzIvUHFDVTZuWmpQa3BXSmRhbWlpQ0tJ?=
 =?utf-8?B?cEt4Q2Z3OTNiNjhhYkk4MzN0TXQyeUI3ZUp3aUVtMkJXTkEwVGdqVUYzSC9a?=
 =?utf-8?B?TldYb0Era1dsbHJiZmtjWnpvTHRkZDVvUy9ncTNSY0ZUYXZiV2NsanYyQ1U4?=
 =?utf-8?B?ZGJmMFdGcXgrM0hOMGt6dVZRN0d2TEcrZ2Mxa2FJQis2aUhpSXRnZW5qRWx2?=
 =?utf-8?B?NFc0U2N2Wms1T1Z4NE9TZXRVT20rSnVwRkFIMnVaaDB3TThzQkhxSENkK1Az?=
 =?utf-8?B?SGRtT0VPWHBxZGV0QUpRbjNqZjlUbFAzalE2Snd6QktlWS9qdnpyUTRUSTlX?=
 =?utf-8?B?YzRreXg2a2dPTmd2MXlMRDRBQVBGOU1iUE5NTlhaRXZCWVdiUFN2dkVHSkEz?=
 =?utf-8?B?a1B2YWsxQmYwNUduNGpsVHJESm5UMnVwUHZLaTFDbEs1WFNIZklWL1JEeHNl?=
 =?utf-8?B?cjFaeWhSV1lzbEhYS0p3dENiSWhvR3hGNm9qcmw5bERjSGsxNUFiSnRnQUVt?=
 =?utf-8?B?K1FzOHQwdTN5UHZBVUIvNWhaYnd4ZTJhdDQ4Mkg3cDU1aE5QeGIxZ28ySU5x?=
 =?utf-8?B?cS9nOTlyMmh4bEVSMDlXaHMzZHBZYTd4K2dGMSt1S2QwS3AySm02TUorVEg2?=
 =?utf-8?B?Q0RqS2RvMjVaZUtBa1Nva0k3L2dmMHlueEhWd3k1NlhkUkhwNS9pZHZMMGNR?=
 =?utf-8?B?dXcvaW5lMDdTTlVFRTQzL0VybGtySnNrbXF2VEVqbVY2UVhXZ2s0K3RyT1pO?=
 =?utf-8?B?aHdVd2VwKzZqbkRnN0xuS1JnUDJFSjg4cEtuRTFrSGtieHgwZUp3bW0yM1Bj?=
 =?utf-8?B?NWs2M3h0ckRnYlY0dU5CUlNpbUVsRGdiZVNqam16UEFacFNvb1lPTG1OQzRY?=
 =?utf-8?B?NnZhMUNzTVhDdEdqalNNbUhlYS9NWW5qVUs4ZEhVblU4VUtqZDhEcHhHVm5C?=
 =?utf-8?B?MjFUWkUwTkxXOVliUnRQd3l0UENoaWZJRWp3ckluRjR6L0NxVW9vQkZmckl4?=
 =?utf-8?B?cnhZb3VnWWJOQWZIVUtQNHJpTFlQcWRMSnplaks4NzJ0d3Bndk5vSzltZ2xz?=
 =?utf-8?B?ZDFiWkdyQnhvY29aOTV1Q2dqVS9oMFBBdThnd001eVdnd3ZOeDAza2dkUEdm?=
 =?utf-8?B?a1NVVXZDSWlPdUl4dDZLOTJ0aDJWWWx5WlVqWXVSN01ETDlYbm1HWUNqRURi?=
 =?utf-8?B?QnhaSU9rbjk3UkJ3Z1lWQ1FVbzFzdmFKeXlWNnpJemsvZ2t3NXNiVFJKZTAr?=
 =?utf-8?B?UDlKNGZLd3U4cUdOYVcvV2M2cjhjL240elQ2eUdjNTJWNENlaE4wSENqQ1pB?=
 =?utf-8?B?TFdENGZvQ294Z2laSUo4ODdXakh3UGU5OWIxMlY5b1VxTUU2TkVtVnJXVG11?=
 =?utf-8?B?cGsxcE1aQmIzaXVHVDRTbGdjbE5BSDFOUEI3cWQrVnpFai9yb0M0dHoxODl2?=
 =?utf-8?B?L0F6RUozMlRJR0s5Z2w1aXkwczlnM3VhSUxRL1NTZ2dPd0JMOHBSUWNReVgx?=
 =?utf-8?B?MEZuSFhUdUQrTnVjOUdvVXBJVThySTJpaHVBMm9VVjdlRFEzTm1ZV2JVVHlF?=
 =?utf-8?Q?Ob8P1GzC7BcEtaxqI5hpMQGKK+GSeuVPeyeWoBu2SzKz4?=
x-ms-exchange-antispam-messagedata-1: shAD13zRpv+zwm/AlHKstsosCZ2b4z3F6i8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74345FEA10FC544F9DE4A924C9673F3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uO40YBvKq6BOkAOSK6uEbBQho0U2drwznSg7hfcqgkgoCU94nA4HvL+jTi11bReqVaiWIhSh1e52cdqGyyLYHE7VrK65Mo1ZbgZ70MY/2nDOs+Rds9TRoDybFgzakBgtjNxobOM2aKIu8uwVwo/oKBqllK+x1efo0Kp8MlJZhym4m8Fg//Uk6g2uq89ytHIWf/8h/tv4uE+mH5Mmv9LNpUcFXwpVk5GEJGk0Pf4XUMEoEVblZPzMt0YV0nSfHXDGjFRssj7KqtZbVSJceeH4s4Rv6YVV1WH6CSgeOpIiAbduqmGD/DmiJEEaDhv6Doewwhz1UuyQRKXjZb6pEHjAdA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UKlTAx3Ar+qunKm7RvWd0S62xoYWP0oj/0erlrHtpmncQI1hPW3y6Auwm/GyR6toVnv+jY1Ll7NREcCmwy+xl+dPD04yUECSkzdUJDBR/TyXxSNGsCsZsjVyoVHdY+tg7Y3ukMGIBzyQ2WCL4SynKDzFnF2mLIoJHKqwqPSWieIzAs7cenTXahNvZ5bAW7NPApTfjwP+mScLkmMonZMC7ENtclvWK7ftAvn+fIoa6ijXHMyVQ49cDT//ZmZGaHy5BW+26assKJE0jTJRf0u6XceDb52rpuM2Uro5b1B3tjg+UmcjXllzJtlwbGn+q6bxx5n5+6UGyrvr++NQIeJtOC+PNBImgZJXh3KnyLRxK/+g4KemZS4Ds1oupnFRGhHOG9tGZnZr9PzgU+n/7CRQuOjartmblW1zpuCtS7dtUnjiWG1LTrpPRG0vq9o0rw1wyHpkpmTxZonRwo9CKDhlnEJvsOv4K0vvetED7Cazisg8rMdP71Uj6MktfPXZhlwjesoRCnG974371xE75lzj5OHPEc7TMrfvWrkMrP88fYMbqff08KUeL9VQhcyrO+iqqxb2Iu/HhE7jffyeqryo5MWX1Zzx/8Mi52n33QR5Pxjcy1PKpuxfSGBZNSggCrOF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16de9bd-9b91-4955-496d-08df3faf42e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:50:08.3670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XTzn5FfhUoiT92TPpklYQ00oW/EzFKfDgTGXPBLVRuLRowpqXtm5oyv+UqM9gSNrgek4JAl1ycgtqNRzICBlVa2G3TH1UJAIRTOOIYvYlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8201
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIyOjIyICswMjAwLCBSYWxmIFJhbXNhdWVyIHdyb3RlOg0K
PiBGcm9tOiBSYWxmIFJhbXNhdWVyIDxyYWxmLnJhbXNhdWVyQG90aC1yZWdlbnNidXJnLmRlPg0K
PiANCj4gVGhlIFBMSUMgZGV2aWNlIGlzIGNyZWF0ZWQgZnJvbSByaXNjdl9wbGljX2hhcnRfY29u
ZmlnX3N0cmluZygpLA0KPiB3aGljaA0KPiBnaXZlcyBhIGhhcnQgYSBzdXBlcnZpc29yIGNvbnRl
eHQgb25seSBpZiB0aGF0IGhhcnQgaGFzIHN1cGVydmlzb3INCj4gbW9kZS4NCj4gVGhlIGRldmlj
ZSB0cmVlIGluc3RlYWQgaGFyZGNvZGVzIHRoZSBmdTU0MCB0b3BvbG9neTogbm8gc3VwZXJ2aXNv
cg0KPiBjb250ZXh0IGZvciB0aGUgbWFuYWdlbWVudCBoYXJ0LCBvbmUgZm9yIGV2ZXJ5IG90aGVy
IGhhcnQuDQo+IA0KPiBCb3RoIGFncmVlIGFzIGxvbmcgYXMgdGhlIGFwcGxpY2F0aW9uIGhhcnRz
IGtlZXAgdGhlIGRlZmF1bHQgQ1BVDQo+IHR5cGUuDQo+IFRoZSBib2FyZCBzZXRzIG5vIHZhbGlk
X2NwdV90eXBlcywgdGhvdWdoLCBhbmQgcGFzc2VzIG1hY2hpbmUtDQo+ID5jcHVfdHlwZQ0KPiBv
biB0byB0aGUgVSBjbHVzdGVyLCBzbyAtY3B1IHJ2NjQscz1mYWxzZSx1PWZhbHNlIGJ1aWxkcyBh
IFBMSUMNCj4gd2l0aG91dA0KPiBhbnkgc3VwZXJ2aXNvciBjb250ZXh0IHdoaWxlIHRoZSBkZXZp
Y2UgdHJlZSBzdGlsbCBhZHZlcnRpc2VzIG9uZSBwZXINCj4gYXBwbGljYXRpb24gaGFydC7CoCBD
b250ZXh0cyBhcmUgbnVtYmVyZWQgYnkgdGhlaXIgcG9zaXRpb24gaW4NCj4gJ2ludGVycnVwdHMt
ZXh0ZW5kZWQnLCBzbyBmcm9tIHRoZSBzZWNvbmQgaGFydCBvbiB0aGUgbnVtYmVyaW5nDQo+IGRy
aWZ0cw0KPiBhcGFydCwgYXMgaXQgZG9lcyBvbiB0aGUgdmlydCBtYWNoaW5lLg0KPiANCj4gQXNr
IHRoZSBoYXJ0cyBpbnN0ZWFkIG9mIGFzc3VtaW5nLCBsaWtlIGNyZWF0ZV9mZHRfc29ja2V0X3Bs
aWMoKQ0KPiBkb2VzLg0KPiBObyBjaGFuZ2UgZm9yIHRoZSBkZWZhdWx0IENQVSB0eXBlOiB0aGUg
RTUxIG1hbmFnZW1lbnQgaGFydCBoYXMgbm8NCj4gUlZTLA0KPiB0aGUgVTU0IGFwcGxpY2F0aW9u
IGhhcnRzIGhhdmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWxmIFJhbXNhdWVyIDxyYWxmLnJh
bXNhdWVyQG90aC1yZWdlbnNidXJnLmRlPg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVl
IEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0
YWlyDQoNCj4gLS0tDQo+IMKgaHcvcmlzY3Yvc2lmaXZlX3UuYyB8IDIxICsrKysrKysrKysrLS0t
LS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9zaWZpdmVfdS5jIGIvaHcvcmlzY3Yv
c2lmaXZlX3UuYw0KPiBpbmRleCBiN2Q1ZTdiNGRhLi44ZjUwYzY3YTE0IDEwMDY0NA0KPiAtLS0g
YS9ody9yaXNjdi9zaWZpdmVfdS5jDQo+ICsrKyBiL2h3L3Jpc2N2L3NpZml2ZV91LmMNCj4gQEAg
LTk5LDYgKzk5LDcgQEAgc3RhdGljIHZvaWQgY3JlYXRlX2ZkdChTaUZpdmVVU3RhdGUgKnMsIGNv
bnN0DQo+IE1lbU1hcEVudHJ5ICptZW1tYXAsDQo+IMKgwqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMg
PSBNQUNISU5FKHMpOw0KPiDCoMKgwqDCoCB2b2lkICpmZHQ7DQo+IMKgwqDCoMKgIGludCBjcHU7
DQo+ICvCoMKgwqAgUklTQ1ZDUFUgKmhhcnQ7DQo+IMKgwqDCoMKgIHVpbnQzMl90ICpjZWxscywg
Y2VsbHNfbGVuZ3RoOw0KPiDCoMKgwqDCoCBjaGFyICpub2RlbmFtZTsNCj4gwqDCoMKgwqAgdWlu
dDMyX3QgcGxpY19waGFuZGxlLCBwcmNpX3BoYW5kbGUsIGdwaW9fcGhhbmRsZSwgcGhhbmRsZSA9
IDE7DQo+IEBAIC0xOTUsMTggKzE5NiwxOCBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KFNpRml2
ZVVTdGF0ZSAqcywgY29uc3QNCj4gTWVtTWFwRW50cnkgKm1lbW1hcCwNCj4gwqDCoMKgwqAgZ19m
cmVlKG5vZGVuYW1lKTsNCj4gwqANCj4gwqDCoMKgwqAgcGxpY19waGFuZGxlID0gcGhhbmRsZSsr
Ow0KPiAtwqDCoMKgIGNlbGxzX2xlbmd0aCA9IG1zLT5zbXAuY3B1cyAqIDQgLSAyOw0KPiAtwqDC
oMKgIGNlbGxzID3CoCBnX25ldzAodWludDMyX3QsIGNlbGxzX2xlbmd0aCk7DQo+ICvCoMKgwqAg
Y2VsbHMgPSBnX25ldzAodWludDMyX3QsIG1zLT5zbXAuY3B1cyAqIDQgLSAyKTsNCj4gK8KgwqDC
oCBjZWxsc19sZW5ndGggPSAwOw0KPiDCoMKgwqDCoCBmb3IgKGNwdSA9IDA7IGNwdSA8IG1zLT5z
bXAuY3B1czsgY3B1KyspIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBjcHUgMCBpcyB0aGUgbWFu
YWdlbWVudCBoYXJ0IHRoYXQgZG9lcyBub3QgaGF2ZSBTLW1vZGUgKi8NCj4gLcKgwqDCoMKgwqDC
oMKgIGlmIChjcHUgPT0gMCkgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjZWxsc1swXSA9
IGNwdV90b19iZTMyKGludGNfcGhhbmRsZXNbY3B1XSk7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNlbGxzWzFdID0gY3B1X3RvX2JlMzIoSVJRX01fRVhUKTsNCj4gLcKgwqDCoMKgwqDCoMKg
IH0gZWxzZSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNlbGxzW2NwdSAqIDQgLSAyXSA9
IGNwdV90b19iZTMyKGludGNfcGhhbmRsZXNbY3B1XSk7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNlbGxzW2NwdSAqIDQgLSAxXSA9IGNwdV90b19iZTMyKElSUV9NX0VYVCk7DQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNlbGxzW2NwdSAqIDQgKyAwXSA9IGNwdV90b19iZTMyKGludGNf
cGhhbmRsZXNbY3B1XSk7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNlbGxzW2NwdSAqIDQg
KyAxXSA9IGNwdV90b19iZTMyKElSUV9TX0VYVCk7DQo+ICvCoMKgwqDCoMKgwqDCoCBoYXJ0ID0g
Y3B1ID8gJnMtPnNvYy51X2NwdXMuaGFydHNbY3B1IC0gMV0gOiAmcy0NCj4gPnNvYy5lX2NwdXMu
aGFydHNbMF07DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgIGNlbGxzW2NlbGxzX2xlbmd0aCsrXSA9
IGNwdV90b19iZTMyKGludGNfcGhhbmRsZXNbY3B1XSk7DQo+ICvCoMKgwqDCoMKgwqDCoCBjZWxs
c1tjZWxsc19sZW5ndGgrK10gPSBjcHVfdG9fYmUzMihJUlFfTV9FWFQpOw0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoCBpZiAocmlzY3ZfY3B1X2hhc19zdXBlcnZpc29yX21vZGUoaGFydCkpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2VsbHNbY2VsbHNfbGVuZ3RoKytdID0gY3B1X3RvX2Jl
MzIoaW50Y19waGFuZGxlc1tjcHVdKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2VsbHNb
Y2VsbHNfbGVuZ3RoKytdID0gY3B1X3RvX2JlMzIoSVJRX1NfRVhUKTsNCj4gwqDCoMKgwqDCoMKg
wqDCoCB9DQo+IMKgwqDCoMKgIH0NCj4gwqANCg==

