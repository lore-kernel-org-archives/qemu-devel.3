Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522DFEDF026
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNYa-0003is-Id; Wed, 11 Feb 2026 22:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vqNYY-0003iU-Tt; Wed, 11 Feb 2026 22:39:54 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vqNYW-0000sq-DC; Wed, 11 Feb 2026 22:39:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOf0PzPWfNPZI2UbbAmv6EiY4vhjdAet8qwRqN9ReWk+tsfOOZba2ZAv342F4WSvzeGSIZ9WdnIQoqFyS8RQ93koj0M3xnAhOoQziDmNhvdx6PRWXF7ikTDp/wF32bZnIbuEXvnAApDOvr5SaJGfr1IhF4ahwHSjXNQYmp4QVcPQqQP/Xzocsl7FjUdSUUJx59jZI0a75zWhY2BruXbGxQHC/ezs+dCNRCgEsVsoxhNe2wlzXwgQwWM/q0oz+x88V0zxrfSftgjdj19I/JSfLN7zt9feD8zjVPsU63FSU5ShJFolTrlow2+d6xkQP6xzf7ov1eRmevB4MeS7xff6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWyBm4i4F8DCo6glEy8vRRfkoAxSd5QvIGIsuew+Ejo=;
 b=mO9Yj9yb7obdGajHy+oNdFNg2CGN4i8jCz+IozuuNVQaRrFfUPRgClV830ikcDBSeN0eTR+7KJLOnrLEt25ds/FHpCmb+LFfLljIWlPI3Hvle1gem7HGqdWYv7PjCSzL3437Zf0plSdroEi3ACyyqcNQzGRhDwOwb5v4CSJ/DE8grydM1QpIB2jXApEraW+JEyDGgML4qVTyHDM13NpI5Oio97/wfv9Nc2qwnp+2LpHxtoPu++Ci8zBxlF4QfvfZMG1s9wFYPRVjdq2cn2/rvkWMYyByPN+CjIHpIQkRvTRcRtqhIZRv35NDOrwprJDGyRRPWpXq1jJew1F74dqgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWyBm4i4F8DCo6glEy8vRRfkoAxSd5QvIGIsuew+Ejo=;
 b=G5Yv5H7XPi1YEXUiKJXw4x2iV/7NC7TwPMDQ7EBW7EBdMXJE3JwOvS8HiOeATfRcJJmN4UASJVSY4LbWMcgaC3KKjRORNzK3nN8cNnmu93ICztxT0eptIp+P6EkRN2ydJkg6uPhEfIXtYHJaET9xarBc8MTBvc/q6mwIghAl0fzjyn2JyRN/nLKBwOA8JybxL9ezjqMC214zUHBNxbF3/eOCQ5z177VZcol+EbBIwvWgt6srxXvN3v8SkNtEGK285U8+qusRpDWfCgY7r4DzCGVz8+kISEHj4SplqSluhLTLKFj2rIoCRd4B4jgtIXXiLYclztrn+71hYTf2iUt3HQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB5293.apcprd06.prod.outlook.com (2603:1096:101:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 12 Feb
 2026 03:39:45 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 03:39:45 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
Thread-Topic: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
Thread-Index: AQHcmzEHTn6qqearhU+57e3eAUbxWbV+Zxsw
Date: Thu, 12 Feb 2026 03:39:45 +0000
Message-ID: <SI6PR06MB7631B5BECA948F629031A0E1F760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <d56d900f-d9cd-4c6f-ac44-a0cb0e6e6b13@kaod.org>
In-Reply-To: <d56d900f-d9cd-4c6f-ac44-a0cb0e6e6b13@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB5293:EE_
x-ms-office365-filtering-correlation-id: 30911a3e-55ac-4420-054c-08de69e85d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y2xJTDNKSkhpTUtkZnBZVGlQNjZhajUveHhTN1JIR21kblBqR044TE5ySTJQ?=
 =?utf-8?B?VUY1YWgvaUErakI1cFRHSjZHYXlSdlg2ZFVBck9teVNDRk92NktGU1QvNUVt?=
 =?utf-8?B?dGxwcFl3QVZkOFlIM1VsMjVhc252SUEyS2plRDZXckZEa29VNHNpZk9kcStm?=
 =?utf-8?B?ajBIVWJLT1V5Ti91OEFOcXIvTGp5b0lWalZ5STBKSUF2OTFlM3FTSVA1Mkt5?=
 =?utf-8?B?Y0x3dnVsZUszVWhFbFdjSkw0UlVZVXF4TkxwZW1uRHdFZHZwaXRrTUw4OS8y?=
 =?utf-8?B?ZFNrVFUvQzRXbXAvdkd0TnduQVFTZXBOVXJQMFJvc2lrTHNPYmNNdGJqN1dL?=
 =?utf-8?B?SmkyVEZwUTRDYUlKeTk3aWYwU28yYmpMSUQzd2ZsR1UvMjdFY1YzT1JwczdO?=
 =?utf-8?B?U081dnU4MmRLeWNFM01pVU1hVzE5RTNnK2xERkRObjl2ek5YTG83azdXRURT?=
 =?utf-8?B?ckFDY0t4aGRjdzVWTG9FU0RjVDFReDVBTnZsNHM5Z1RQTXpKa1BPb3VNQWRO?=
 =?utf-8?B?N1QzRkdUQ1R6NFZaTjBsZTFBajk0bDlBYUlyTy96c1pYb3Zld3d3OVpTUFRP?=
 =?utf-8?B?VUFiQVJkckRIaFZyelpwU2VNNFE0THJQWUJTSk1Uc1hFejlUU1A0UCtXeG8w?=
 =?utf-8?B?OUZFUGJhN3VJWUhmRnoxVUdmbDd2ZGp4dkFtdE4zY085ZU1NT0VoRjlnS01v?=
 =?utf-8?B?Nm9BT3VEWDRZbVVXRkpncG5xNzl0Vlh2Skx6dU0yYW1Fa0hYdm1qaEl2Vm9V?=
 =?utf-8?B?VWQzQ0tZc0MzaHUrMGtyTlNvVVowV1BKL2FKSmQ4S2RTY3NkcytUVjBDQ08r?=
 =?utf-8?B?ZnRvU3A3ZEVVTG9ybFV2WUxyQ0ppQ3I0MlFsN3A4QytmZWxQaHJGdFdSRERN?=
 =?utf-8?B?ck9zK1krRjNVTjBvdCtaT3UraCtyd082NHJxZ3o3Mkk4OTRaMUNiMDg3VVpy?=
 =?utf-8?B?ZUU4aHJnYnlNcnBjVTFRZ25EYUtqbjJBOTFhQ29FQThMcHlNOHZabzJYYzVt?=
 =?utf-8?B?dHYyWWlqSGZLL2RWdkJXVUZkM04wZks0SWZOUzg5RWhwUWxnbjlxV0ZyazBY?=
 =?utf-8?B?Q2ZkM2lORWg3WkgzMTMwTnFZMFZDN2NJU2JmcWxydjhUSjl6dUVDaXdFU2JV?=
 =?utf-8?B?SWJQR1N4ZG5nMHRzSVU2WXVkR0VwNzJWUmJYcUxNaXZId3ViSTBMZG90a1Rl?=
 =?utf-8?B?WjRGcXUwSnc1a1haa0gwNzVHemgramVuSEhQaUpmVDlXS1huMmVlVjBYS0g1?=
 =?utf-8?B?TE5xcWI4aUhvLytKQk8zSVRzbTdYSVBnb3IvZGdubGY4RE1zN2wwQjk4SGhX?=
 =?utf-8?B?N2lrMTFrWE5hakhaaUwwc2tIRmMyemY4S3RURXJQQURpL2tpTjNmWEVUT3hh?=
 =?utf-8?B?ZHFYSk1iN3hWSi9hL0cvai95VmZyUk1scktpS3U3Y2lzdDVaUU1zRVFuVnJC?=
 =?utf-8?B?ZkZPQlVIbGtBQXVxQWZSY0llakYvUFVLWmUzbStWSGpxditTb0lsN0hCQmN2?=
 =?utf-8?B?a0NHc054WVBGUFI5RlIyaURLczJUclB4RkJab1RYUUlvQlRLbGYrdzh4SGtV?=
 =?utf-8?B?UnRJTFp0Zm40WDhUMi9ucUQzang4UFNaNlZpT3Y5ZVVYc084VDlJUHgvNmFD?=
 =?utf-8?B?d1dqcHFJR3JNNk9Pb1NMU1JKd01zaDRUd3FCSjU1cnBiaXB2RTFySWVFdU1C?=
 =?utf-8?B?TW9scFBjSGxFSW5Ka0dTTU5HbmdWb1k1Zng1dEswdytiT1lia2lXUm11Y3c4?=
 =?utf-8?B?OVpjTWx6TmxiOUtSQ2FXSDQvcEtEU3VGS096bThHZUR0d242TnA1TVF6cXFh?=
 =?utf-8?B?QXRPTnlsaWZvQXpWL2RabElBMjJuVVl6b1lJb0g0R3Z1bC9xWStESDFud0Uw?=
 =?utf-8?B?N1JHaEVMK1RzWW51aldvUHIzM21OSHMzaVFRbndMK3VwdmpSbGExc3pkNUNY?=
 =?utf-8?B?V05mVllRUFF2M1Z4SjFzYXRPOThzNmVPeFZjSzl3ZW5hNndJZG45NG1HaG10?=
 =?utf-8?B?djlLY0NjcUVZS1hPTDVDQ29jeExCOXJ0d2NNUTBqREhwcXdWSE83ZVZCS2tn?=
 =?utf-8?B?RS9mOC9nMzdtWjA5d0lLUFZWZE9jNlNidWxkcytib3JaMHdJdlBsUE1OZ3cr?=
 =?utf-8?B?TjhIaGU5cGNNNnRaTnppT2xZWjZwVzZ5OE5rYnAxcHJ1RVBudGFiUlhMUWIz?=
 =?utf-8?Q?f7a4oeCyESkWmJOcckZXhCE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em9XejIrUFZHMzA3Z1VKNzU1aHBXVWxISHJBQkZOcDVaZDVBQzFEemQzWUxz?=
 =?utf-8?B?L0pCeTN4K0JsNjdsN2UrNVAzckJTaDR4NmdMb1dSWFVPMWoydWxsd2hkUVZH?=
 =?utf-8?B?V2x4TDJkUXF0MWdZOEZpYXNUekl0UUpoN0JBRWwxSjh6RkQ2V29SOERheFlU?=
 =?utf-8?B?YVY0NVZhNUlWSEpMZmVjQ0YvWERlcHpzR0VxRHZZeUovU0haSi9YRXpJSkRM?=
 =?utf-8?B?dk9BM1dvRUN5bDhqdW1YNGx3UlU4aGdva3dQM1RRYVF3N1RkaTJOZ0pkZWNn?=
 =?utf-8?B?akxMN0t6bFdhalAzUDZ2MHJJVmtPN25MaGZRRFY4bElldE5RSmIrSW81VVlN?=
 =?utf-8?B?QnM3TVVmYjFJd2hndlRQU01wMEs5WnRYRGlZL28rdVJ0SVRvaDkxZkwzT3ZU?=
 =?utf-8?B?NjZDOWQ3K1lKdmhaM0lQa2FlVkdPVWhhSGpvbWVTbGhkbTFXbm1kdzVuaHI4?=
 =?utf-8?B?QlQrWWRRQ0ZBa3BzU1lFczFLenhRTHhGWUt3a1hpcUpCZ0hoOFJsYW1TK0kr?=
 =?utf-8?B?ZFNvWjR4cDBpL2JMT2hOcHFPUlZUb3o4WnVpdHQ4aGZJVmR5TVBaa1g5SDNN?=
 =?utf-8?B?cWt0K3h1MDJZQ205NDJFWk5Va01Sc21yUmtpbVdXeFpBZFJXT0lrMlNDRXNs?=
 =?utf-8?B?N3grNE11eXFKTzNZemZTUEFFR29BaHowYUErYXpoTVBTL21sbEthQ3ZvZ1NY?=
 =?utf-8?B?UE0xVjVtZGU1Q21zQzAwNE1wYjdLbUVnVitYYXRMWDVKYnBUa0EwVmVOOUp0?=
 =?utf-8?B?cStrUDFtekJEYVJzS0t4RURiTVBLaUFDSHhKQ2RnVk0vRGYrUWZldTJPcWNr?=
 =?utf-8?B?UHltZ2wzVVZlTzBDZ2psUS9FUWhFTWpNVE9xOEhBaHh3a0xoKy9Bdkl5ai9n?=
 =?utf-8?B?eldOSEVwcFpGZGRWRnZxMVdFUjlvdTYvWWM3U0R4Z2haOTBzOXFTMm1va0ZR?=
 =?utf-8?B?dEw4WU1KZy9ZTituVWt5Q3EvZ2JhMnMxMGRjL09rRWJWekRSWjR2YWhkenN5?=
 =?utf-8?B?QUtQVWlOOGNFRkNjank2ZXhtZjJpUm1BYmVnbk5BenJxNmFlQzdRQXRKVDFy?=
 =?utf-8?B?OW5pUWEvWHJudzEzV0xiRTltYU02MlpteG5oOG02THU2Skd4WkFmcHB0Mjdw?=
 =?utf-8?B?aWRRZFVOTHp3UDJXY2Y4bWgrcnRKZjVBRnhTMkNTLzJlelMvWkZrbjNzWDFI?=
 =?utf-8?B?Ykk2VXp2OUJ6T2wrdjhjOGMxMGNyaWRGaEgvSnBvNVBLams3MzMveStDMFYz?=
 =?utf-8?B?d2Q4Y3hCdjd5OGVDU1BrbEI2RG9obi9DMklyNGxxbGt4TXFVYUZBL0M1UExK?=
 =?utf-8?B?SVdwOVBocXRBVXJPVWhiakhZcm1rZjA5dTUwalNXWU4vcyt0bW5ReXJxcFIv?=
 =?utf-8?B?Q2Q5VThYaEQ5Q0hkZm9QbnNpeHhQSU5CbjRqVzRlVElSc0piRzRvdWdidUYz?=
 =?utf-8?B?NzFxTytUb2E4S0k3dC9RMzl1OTZpdkFiMUxHMUI5ZVJiSWNySkNUWGZpWnF6?=
 =?utf-8?B?STRKU0tsNDVxWmNrUUZEb0JNTnpWNzZOWnZreDZ1TWFTNWRwYmdub1BVQ1la?=
 =?utf-8?B?YUxreXZsa2pYZnBXYXhFWmpjK29NMmR2eFQxT0NCUndBbDlYWGMrZW5kODgv?=
 =?utf-8?B?QjVCRFUyYjhZK1Q5ZWxBNTJrVVhVdTJtZHA3eUtWTUl6a2VCdFZ6eGpwc05F?=
 =?utf-8?B?L0FkL3hrK0VJZWVaNEZBdzhLSnV3N3dHVXQ5SE4yMlJoZWdpOGlCdy91Mjk1?=
 =?utf-8?B?bnM3UFk2YlZ4OUhDZHdwWjlFVzlWejhaN1U5cDFWZGZHbEVra05RUnpOVjFs?=
 =?utf-8?B?TldsaWVHditaWHV5WndrU0UzM3VlbGVBNndrdGZFbHRFYkhxN28xbis2cHdm?=
 =?utf-8?B?YmVnc3Z4V2ZZTnh1UWNxdHgyMVhZYXdVTnNtRVRIcUk1NXkyUWFhenIzSEFK?=
 =?utf-8?B?SjJQbDlVOWR1bTdIM3lENGpQVjlBNm8yak9kNG1vQ2IvcHRtYkJDMjA2cUx1?=
 =?utf-8?B?eUZ1dmNjNHZiOEJEeGpOako4ZldYZWRpd0F2R3pvMWpKaHhLU3hmdU9wMVVx?=
 =?utf-8?B?eU8wN1lXYWpSN21tM3ZiUDFqSjBMOVJtcnZMR0xqT2ZBTkJoRFpBMndZL0xs?=
 =?utf-8?B?eTMrL0R4RkxFM0diT0JWMG9sSTlGM244Y0ZmN0VQSytiNTN0eGh4Mk5JdG5R?=
 =?utf-8?B?UE8ra3BabWNQZFhOaE13dUpnOXpjUXFXVFd6LzVJUnZ5UFBXYjJPTEltUm1z?=
 =?utf-8?B?bXpQclV1TXY1MFcrQndSMkY1cmN1TDFDeTFGR3RwelpRWEVPKzV1ODZ2Y1po?=
 =?utf-8?B?NkZNbzhmanE4bkozbWR4dURwNmd3akF3elovK0xlL09rNDhXNzFsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30911a3e-55ac-4420-054c-08de69e85d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 03:39:45.4021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrMuAiRtsahkKRbbUxkgU/BN3rB4IKgLjok0l9a+W5oQIJBRsbRthpH37Lpr6Nrvq62LBcDWXJzWdlwES6bC6nOSxtgIC1pXiulouC2FB4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5293
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDExLCAyMDI2IDQ6MzMg
UE0NCj4gVG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsNCj4gcWVtdS1hcm1Abm9uZ251Lm9yZw0KPiBDYzogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8c3RldmVuX2xlZUBhc3Bl
ZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbg0KPiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4gPGFuZHJld0Bjb2Rl
Y29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBUaG9tYXMN
Cj4gSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT47IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRl
Y2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gdGVzdHMvZnVuY3Rpb25hbDogQXNw
ZWVkIEFSTSB0ZXN0cyBlbmhhbmNlbWVudHMNCj4gDQo+IEphbWluLCBLYW5lLA0KPiANCj4gQ291
bGQgeW91IHBsZWFzZSByZXZpZXcgdGhpcyBzZXJpZXMgPw0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQo+IA0KPiANCj4gT24gMi85LzI2IDA3OjUwLCBDw6lkcmljIExlIEdvYXRlciB3cm90
ZToNCj4gPiBIaSwNCj4gPg0KPiA+IFRoaXMgYWxsb3dzIHRoZSBmdW5jdGlvbmFsIHRlc3Qgc3Vp
dGUgdG8gcnVuIHRlc3RzIGluIHBhcmFsbGVsIG1vcmUNCj4gPiBlZmZlY3RpdmVseSBhbmQgYWRk
cyBhIG5ldyBzZXQgb2YgdGVzdHMgdXNpbmcgdGhlIG9sZGVyIExpbnV4IDUuMTUNCj4gPiBrZXJu
ZWwuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBDLg0KPiA+DQo+ID4gQ8OpZHJpYyBMZSBH
b2F0ZXIgKDIpOg0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWw6IFNwbGl0IEFzcGVlZCBBUk0gdGVz
dHMgaW50byBzZXBhcmF0ZSBmaWxlcw0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWw6IEFkZCBTREsg
dGVzdHMgd2l0aCBMaW51eCA1LjE1DQo+ID4NCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvYXJtL21l
c29uLmJ1aWxkICAgICAgICAgICAgICB8IDE4ICsrKystLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25h
bC9hcm0vdGVzdF9hc3BlZWRfYXN0MTA2MC5weSAgIHwgIDANCj4gPiAgIC4uLjAwLnB5ID0+IHRl
c3RfYXNwZWVkX2FzdDI1MDBfYnVpbGRyb290LnB5fSB8IDE0IC0tLS0tDQo+ID4gICAuLi4vZnVu
Y3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjUwMF9zZGsucHkgfCAyOSArKysrKysrKysNCj4g
PiAgIC4uLi9hcm0vdGVzdF9hc3BlZWRfYXN0MjUwMF9zZGtfNTE1LnB5ICAgICAgICB8IDI5ICsr
KysrKysrKw0KPiA+ICAgLi4uL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX2J1aWxkcm9vdC5weSAg
ICAgIHwgNDEgKy0tLS0tLS0tLS0tLQ0KPiA+ICAgLi4uL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAw
X2J1aWxkcm9vdF90cG0ucHkgIHwgNjANCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgLi4u
L2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrLnB5IHwgMTUgLS0tLS0NCj4g
PiAgIC4uLi9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGtfNTE1LnB5ICAgICAgICB8IDI5ICsr
KysrKysrKw0KPiA+ICAgLi4uL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nka19vdHAucHkgICAg
ICAgIHwgMzQgKysrKysrKysrKysNCj4gPiAgIDEwIGZpbGVzIGNoYW5nZWQsIDE5NiBpbnNlcnRp
b25zKCspLCA3MyBkZWxldGlvbnMoLSkNCj4gPiAgIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3
NTUNCj4gdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MTA2MC5weQ0KPiA+ICAg
cmVuYW1lIHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3t0ZXN0X2FzcGVlZF9hc3QyNTAwLnB5ID0+DQo+
IHRlc3RfYXNwZWVkX2FzdDI1MDBfYnVpbGRyb290LnB5fSAoNzQlKQ0KPiA+ICAgY3JlYXRlIG1v
ZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI1MDBfc2RrLnB5
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUNCj4gdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9h
c3BlZWRfYXN0MjUwMF9zZGtfNTE1LnB5DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUNCj4gdGVz
dHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9idWlsZHJvb3RfdHBtLnB5DQo+
ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUNCj4gdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3Bl
ZWRfYXN0MjYwMF9zZGtfNTE1LnB5DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUNCj4gPiB0ZXN0
cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nka19vdHAucHkNCj4gPg0KDQpI
aSBDw6lkcmljLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBlZmZvcnQgaW4gaW1wcm92aW5nIHRoZSB0
ZXN0IHN1aXRlLiBUaGUgc2VwYXJhdGlvbg0KaW50byBmaXJtd2FyZS1zcGVjaWZpYyBmaWxlcyBt
YWtlcyBpdCBtdWNoIGNsZWFyZXIuDQoNClRoaXMgc2VyaWVzIGlzIHJldmlld2VkLg0KDQpCZXN0
IFJlZ2FyZHMsDQpLYW5lDQo=

