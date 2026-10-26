Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WrvBcOpE;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=xRVzf8Vb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLUQK-0004Pa-UQ; Mon, 26 Oct 2026 19:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUQE-0004Ox-Ey; Mon, 26 Oct 2026 19:48:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUQB-0002xB-V6; Mon, 26 Oct 2026 19:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793058487; x=1824594487;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=cV8CuXPGm5F3WJHZS3uSjoSvhxA9V+xqznhoztCZcmY=;
 b=WrvBcOpETTGp/LMPvilrjWZi+s7EScF6nlwqjsrt3SZa0TBCoZ6xJkxR
 3V/Tcn+1/cHBY4LqnOcQ2HCRy7NUJnPHHu4mFcjjjcFYrBzr20CCr8+lb
 pVklN0wBHw4EfGglHzWVh5xsK2+sMOC7Mr4PSbIaObDGVd2pNBcZDWNDm
 wd/qI6mfIECwWra7sqyjERDITex8c+xhNQgMpCdqvy4AW+SdP4r4KcpPb
 CYMf8VQSH8XLOXi5hYSIBwv8XSc7S9zkKV8Ervh3o2LWb2ww5qDFX6hMa
 vwLdORpO/b4TVK2Sr4pnIsvOW0ObF2V6Y2YGMQ7iU/8mld+kUnWgU5ia9 w==;
X-CSE-ConnectionGUID: kgZzZ20UQLe60HXviFLHag==
X-CSE-MsgGUID: MvgSK0D6SK+8Y25zfruFNg==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; d="scan'208";a="160015344"
Received: from mail-eastusazon11011057.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.57])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Oct 2026 07:48:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx2qeLoIb8MkQ96TLmhgdaaKFbA6lUMwNRphPqo4HhGIrScvwcFRonNbrdpHYf5H4M4v29rEqkfpM8wNq/GfyLY6QutRxjWhseO0XGhIYDdIKuUZM+pKPOUF2nbRzGykKzKwyGptN7DwsAjNNWQ9hWpcTdpEOlovWA64esUla38zXnxvOSGMWYnuQ/o505j4AUmkr/JugDSo0zsXriAI5GoZXP5n6JHkz68ibK5nZ60zerLFEhsYa80qatnMzyb5dCWFsr+KR+MpN+5RpkbFceRs32OCFqdHdwmAfjlU1mfNaleYmWpUjuq0/agRDZVGrPxJgByBNCFFgxvxo+Zdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV8CuXPGm5F3WJHZS3uSjoSvhxA9V+xqznhoztCZcmY=;
 b=tTWQ17FnU0w5nByy/ib4+awPctNEGwUOg5hnCRkDUuKYZSEUoS250QwYXczn7bvCneyhB9UWVBaEE/shdi3AuAWxt5nqgtti2+bD0K7BeYmW9aIplhGlLsfQ+I4zJsFYdwBO01WZgZMsMpQ8wQ0GOvd2uYpmSVX6ElO5p/vOqOMxqkhO2s52DrAUmvHTnpDWqxdfRQXrgpu9qEt9E8+M9SnqeBhbaE8CYiM8CCysKa4cq0fjwepPFbTUtx5kFbEnPQGuZuJDiMldLCC99i2QVqIGExeYbLOQga4UUhmsoUnDxUagb04szPTJnJZCdQguOHIvBBHcpsda3weMVKIlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV8CuXPGm5F3WJHZS3uSjoSvhxA9V+xqznhoztCZcmY=;
 b=xRVzf8VbO97CIiLQyI6poZQkJoxqAl7zoHcK9lqAoxXpx12QRizdLbkPgByDz+s9OwEbbXrWgzY/AYKOVGeF2rmdVj9/Mfv5hIhhLahl+DFSkYHJe9rQ6tGxAmbQ1cvvTj9JYRMaQSJE+C/vjDsOR4jR+VD5QaSD/d+I8StBkTI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM6PR04MB6428.namprd04.prod.outlook.com (2603:10b6:5:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:48:02 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 23:48:01 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Thread-Topic: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Thread-Index: AQHdZPgCL2dCZtEmR0+ZRKog0GBNTLcQfu0A
Date: Mon, 26 Oct 2026 23:48:01 +0000
Message-ID: <75862250d3ed30aca53d8f3132b6eeb192db6245.camel@wdc.com>
References: <20261026031144.631964-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261026031144.631964-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM6PR04MB6428:EE_
x-ms-office365-filtering-correlation-id: 47263aa3-fbdd-4d6d-cd5d-08df33bb9271
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|19092799006|23010399003|1800799024|261026140227099003|38070700021|11063799006|56012099006|261021123027099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Hmwr4u5AqNjqcXGUODPkMXs964MoRasyiUVJlyJlaR7bUTHEX6gu/puV2fzy9jyg6CrnZ4DImPruvK8cPeebYm9sBR9LBpXnrqJdY/0/MI+//EMMH1fuZmtgUkboLkedmjqKqoUTpsjHGNjihyy+LNMgLK5xGMfY7Sqtwy6bsaB4UR+zWDRliJJa7sG8ATMDW1aC1sU8d7G3Xd6TC4VJXHNsD8yYKLxYGHr9EuszKGaUBZF/2Dx9TVkLH3p02b7Ylf8ELSEsohIBzLZcYsAuhjs14hfOWmvChx3t7VbatlpBdqwYLgbXfMc9CcwFsiN42MuAMiMtmvCqDtmf7vRiKIHd0azMh3/yduGrjy79rC1+aCWHb4coS+Gweleo6qcEsD0MkrpI5lP9rSI1XJyAZhn3xDPWwpdRJe7POi9XVCSAOZp///Fv8eSM7bJy8wSEca6iv0v05fsVPTz8mhcSf1qoUtzulDPB7u+ME0QA06IEEhd7Go1HUNx7GxsQx+svfrmfrUV23TQO9gPuIRNKD2DAQmB09foKlXWuBEgeIDMsoF1c7HhpasZaW2h9RZWwQ/oSDt8qmU1rHWqug2gX3XKo0Vwal8NtZP1ewpTjo5rbUONRw1Q568ASRMRNjAhU8iAkGOCW8XUFijz4hwK1qHPr874o8zLB9k6AuUwN48w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(23010399003)(1800799024)(261026140227099003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2NkTnJuNzc5WHBiVlV5ZnVpUTQyVU1RU0wyakVPRXM4ZkM1dnh4bER3L2s5?=
 =?utf-8?B?ZDVxU3NhTWU0cEN6V1I3ZnJNa3Rtd0FpNWJjU1IrOHNoMWJrTDFYb3dXdEhh?=
 =?utf-8?B?aW93bHhvUTBtSThqbXR2N1VIT1pwcFJpUHlyanhZNGtQQktNb3VkejFUK3M1?=
 =?utf-8?B?L2VpWnNDNjMvd3Z0eGVzYys2emFVcS9PMjFvTnRFN2lCTmIvdkVoZUp0aXZa?=
 =?utf-8?B?dDFVWi90dkYxaGRqZW5ZcWFBNkpvbTVGdUd2akp6MElnZUQ5cis0U2NHM09w?=
 =?utf-8?B?bTZDdG5EdjByOC92bm1UclVNZFo0ZkFTK1owUjhnVzd0bUJOM3BZaGtKd20r?=
 =?utf-8?B?M1hQaXFzVFMwY2srWVJUeXkyZzFVM3JGd3JpczJWSzRpSGVkeEhyenlCMFZ6?=
 =?utf-8?B?cVFxOFZsQjdRRGNOZHVwWGdyZjIzODl1WWdNc001Mk1SNVY3OFdDZmtqeW1y?=
 =?utf-8?B?RlhSOTR3ZG43SmtYbWN4dFRLLzFGTEdUUUhBenVXNDVDN3hwbmgxRkJPMGFo?=
 =?utf-8?B?aE5EYzNBTFNRaWhwY1NycW5zTjBpTWlTbGZWbHJBUXc4eVRrVE9oWThGbisv?=
 =?utf-8?B?aGRFaVFVMnhCL2EwQUNxNytNang4UTRQaDVKd0hDRHZIM2UwR1N4MGhrQitY?=
 =?utf-8?B?OFJEem96VmZlUFcrdTA2clBlYU0xczYxcHB6WnhKNG1lTm9vNjNQWFBqMXg4?=
 =?utf-8?B?Wng4R0lYMlB0WlI3SG9OeStWSjNDQytsUzE2MithTFR5empqSk90ODEyNTll?=
 =?utf-8?B?OXRrTXp4WnZOSUROeVRIR0U2eXFRdnVkWisyUWJQVnh1Vk1Vd0EzWWlwMlhE?=
 =?utf-8?B?Y241NTVuRURCQTRRWEVaTTFxblVrRVRVdTZnRk1ydmhJcGpmSzRWREgrZnNw?=
 =?utf-8?B?RWhyVzZ1WEhTZktVYnhlei9JR0RvMGVtVHVTUzlENU9Ma1REZFM3Ylc5OUNY?=
 =?utf-8?B?N3Z2Z29vK2wxdjhqdllHZmpzU1NYdkVpaHFDdFFOU2FyY011bnYvd0JCL3Vv?=
 =?utf-8?B?YzJjaWYydWhsWm5qcDdBaWJxc2FtVDErL3hEU1krUWh0cW9BRVBwMFVFUHJB?=
 =?utf-8?B?RmdrTk5jcnhYT04vcGNValk2WStqRmJtbm1qcmhtSmM3ZXNPd3lXcmYxL01m?=
 =?utf-8?B?RzEyWVJBOTB1R0lRdnIrUnE0eTR3SlJvSE5PVXFPZFZOZWRURGwxUHRzR0Fv?=
 =?utf-8?B?SUpMQVovU21KaktveWkvNS9NdWlnQnozeUdManJNd1NHNmJaclZ5NGh1c3JQ?=
 =?utf-8?B?cjlPWVVxS2kvVDQxcG5YNk9YNVZQK2NxSkJsMCsxVnVXWDRFNHlKRHF0SnNO?=
 =?utf-8?B?NFJZYmpydmtYeDdCemlnK2VUSWRXb05md1FzbGJZUjNKTHh4bU5mVXZyV2ZE?=
 =?utf-8?B?Yk1keU91aEtJT3dWcDR2Vk1DTG9lTzBna2gvWXI3cm9CM3V4KzFwRWdqZXo3?=
 =?utf-8?B?NXF4UVEvQzk4RGFqd1FpNU9xdmQvVG5WdzMyc3VKSzdCSTlXc1dFL1pKZDBw?=
 =?utf-8?B?WnJnT0hFMG5KTHllZERpMUIra1JhYnBXalhKbUpQSmNocWUxenR6Ky9Xb2Ns?=
 =?utf-8?B?dnBDSjJ0Mis3UEd3djNucUNjQXFTdDdhZkowQ0RyWXRuY25FMEd6eEcvR2pR?=
 =?utf-8?B?a1h0dlZxczRHdmgzWXk0V3M4blkvbnNPSndZRDVlaEhBRlFmZ08zaXFmRFBX?=
 =?utf-8?B?QXZQVWxicGxKMFp5akZ6WTdEM0QwMTRmdWNCclRmbitPZjFxSXR6YkRZZUlt?=
 =?utf-8?B?MjFHK0ZlR3Q2cjR1VlZqL28xNjJPeG9Za2FZYURuV2FDUVIzdDY5ZXQxaEhj?=
 =?utf-8?B?MVk1RGlPOU1NeE9pVUtjandBSmtFdFoxcjNpY3kzUHIrLzZOU0Z3SFVycGZp?=
 =?utf-8?B?UFAwUkVQTHBrNEZpRXN4elRxVDR5WUY0MG1EcGs1TnpaSHNiYjhNbUpYMkF1?=
 =?utf-8?B?WU11ZlB6dk1TcnE1eHIzWTZZMG9PSVRZaEVUblZSR0RsenZjcFg2ZkFhQmc5?=
 =?utf-8?B?bGJWWTFRdUtnNzB6R045R2IwNUpMdkV3SXdycFdXMStpeE5SdXJBenA3RURH?=
 =?utf-8?B?REhsZHRqVzc2cEVpYUhvdHZCdFR2enNBTmd2Ukd1dmh0cWtacXQ0NkI2MHZZ?=
 =?utf-8?B?MHFrN0tnM1lEdlJwNkFmQnNOS25EbmtZQzMzUE1pUGhHcUZkMjY1WUY2OVpO?=
 =?utf-8?B?NlV2bGp3SDdPOHNWaWZVVnJSODkzcWI4T3hObnlyVnJCV1NmRWZJeE9jc1Za?=
 =?utf-8?B?OEx3bkRabmw3ckUwUmE5eFZDWVpBVHFpSmRYc3RER2psdUxDSGRaTUo1MjVG?=
 =?utf-8?B?aEZaTWRhRFlLZGtLdEdHTWlQQmpUUkRTK3BqVkRaRk1LSmxxQ29ZRVlPR0xS?=
 =?utf-8?Q?xTgfR22oiHPoxWKh+4vk3tv5UoqYLfyhh1doV9QWNNBq0?=
x-ms-exchange-antispam-messagedata-1: ygMK3PDoYj2eOYAU+tMTZ1jHytj1KFUskDw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <557B60AA220CE14697412125B7C473F1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bFN1y1qf9cDvaV6URYumqblFrd7VCLwKs/12oB4bD+AScwlLwFDFN05ZqDCtMD0NFMBNWVxOdpg/7atbQevFHupN642fV4R8l5q4oYw9RBdqW4xqf2iH6Y5vb2bax1DfdPQ8iNQNQZ/np4n0fBz20Uo6woZl0PzGh4D4F0XwhLhY6dilCCSMxUgUrAAFMVUTI4dSTDF3R1sspI4JKsdA7xejfxTs7xtdtiSmXy/Y2pjHkVPlnk1ITf1pJQN0uNs/iDoXx71KAQWejsW6c5KHWEVj7B2+FFmv/v8/pjdpoqP6i34m2raZkrknhS/CvHk49Wbhqd8n3qr/93LCuLvG9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jXyRDGNAIIg5XbXij/IBEuIjH6Vho1fSwt3M+a5xS6L3FBc7C6L5Ud3CxopsfwrEb5vjPPMJWuIuxAdmRcdoA3kJYeDapANkJmen9bkWULxbBWVhl01Xy/DRFVmHaLho5Da6IjW7cqme1TfziXwFhF/aPPKxe41W8pMMiMV00jCKfEYSmi4RA96wFy/5fZr4ra6+9btxCa/P1vhVY8WIPwYLZQ0TqT48m7FlGLxg8RVAg1x46/mAAM1tBOxtW9H+stMnW10jwfhaH5Df9ep5YLzybeVgLPG+R7hUcqEX8beYihUKsLj+W9Jw4jeQ2Gj7HSdwYespC8614sH7EdABtFfdBahHei2roD+fJP56qQfKdPAgauTNLQUWvmFNkOaLCwL8/Zz64jkPPhyOONziuYubd9qfgSRqsZgVajvxvCILvdut7vDu0VR3VBDE/M0z8lqRwxNEbkbmNVSSaVFoQZmD5jJI7hqxM6Af+eImHB6rRhhviO/GACOLgWowtXDMzIrXstVvQ5Sel16blwOYutQuAUtEKIlyy3Nae9Xbw2OUgzVaHfC91y09w82WL3uJsiR1HSm+a4nhV7vWO+8kSFalrTyucr5RSS4BJkR6aLgQz716W4HJGEOCJMmkJred
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47263aa3-fbdd-4d6d-cd5d-08df33bb9271
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 23:48:01.8574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuNpY/Q4oiCueMaFIwVBKVDRmAQiZf1q5ThAMuk/1EuTLrBcemj2M2fIGJhkBg3jmq3j7KPATsCD0tHi4Q4A8MMGjGr8jYtYx6cbnmxkcTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6428
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjExICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
TU1VX1VTRVJfSURYIGlzIG5vdCB1c2VkIGFueXdoZXJlIGluIHRoZSB0cmVlLiBJdHMgdmFsdWUg
aXMgYWxzbw0KPiBpbmNvcnJlY3Q6IGl0IGlzIGRlZmluZWQgYXMgMywgd2hpbGUgdGhlIHVzZXIt
bW9kZSBNTVUgaW5kZXggaXMNCj4gTU1VSWR4X1UoMCksIGFzIGRlZmluZWQgaW4gdGFyZ2V0L3Jp
c2N2L2ludGVybmFscy5oLg0KPiANCj4gU2luY2UgdGhlIG1hY3JvIGlzIGJvdGggdW51c2VkIGFu
ZCB3cm9uZywgcmVtb3ZlIGl0IHJhdGhlciB0aGFuDQo+IGZpeCBpdHMgdmFsdWUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiB5ZWNoYW8tdyA8d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbj4NCj4gUmV2
aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3Mu
cXVhbGNvbW0uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIEFkanVzdCB0aGUgcGF0Y2ggZGVzY3JpcHRpb25zIGFuZCByZWJhc2VkIG9uIHJpc2N2LXRv
LWFwcGx5Lm5leHQuDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI2MDEwNzE2MTMzNjEwOFJidmdJRUoxcHd3X2ZLWnRNcmVGcEB6dGUuY29t
LmNuLw0KPiANCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmggfCAyIC0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5o
IGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+IGluZGV4IGI2NWQ2MzE5OTQuLmRmNzQ3N2ZjNWYgMTAw
NjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1
LmgNCj4gQEAgLTE4MCw4ICsxODAsNiBAQCBleHRlcm4gUklTQ1ZDUFVJbXBsaWVkRXh0c1J1bGUN
Cj4gKnJpc2N2X211bHRpX2V4dF9pbXBsaWVkX3J1bGVzW107DQo+IMKgDQo+IMKgI2RlZmluZSBS
SVNDVl9JTVBMSUVEX0VYVFNfUlVMRV9FTkQgLTENCj4gwqANCj4gLSNkZWZpbmUgTU1VX1VTRVJf
SURYIDMNCj4gLQ0KPiDCoCNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiDCoCNpbmNs
dWRlICJ0Y2cvcG1wLmgiDQo+IMKgI2VuZGlmDQo=

