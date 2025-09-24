Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E05CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeX-0003ng-6i; Wed, 24 Sep 2025 05:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeV-0003k9-DV; Wed, 24 Sep 2025 05:19:07 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeT-00030I-DC; Wed, 24 Sep 2025 05:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq/Jd6SgbNlXX1I8W9VR1fjXq7cfOMY0D/FA8O+1+fzwZQ+fbhvYxtATXKvKHRdAeq4jAkCCYhJOOgx/JdpJauVGK+pk0/y8rW3V0uDKrP5Jt6aUfPJIrfc6XhjbWdPIt6rSPgvgIoz66/00AWwM8j69CIpN6kfoOlGY/UjFzAv+vd5qorfBE25HGO84ZAqHL8vSPVwNxXn8IztfhXo2ag7+xFYjHhzhKTgiu2Bne2OPopwyhRBSDLbR/uPhhEXBug8x08IVeUOmf2C/GtwGWUE21MggtDwgweINxmsUm2zgjDUtGQFgcNjbUCGUDntPQFXOsZEaMzUoMfSv5xQd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eC2z39Vf+7MGFSTzi8JX8b8fP2AzHsqmMcAR/iHhppY=;
 b=PpxWSrAzSS+1JmNedsnoSiqQW+SELbDnBkglbd0zzJsNQyxqVTqzS0EdQ0ZNRS70eD/QqOrQwYBCGjjzCBYt+Dua1A3xQveQiw3PeFS1RD5csoBIySAJqnPcjb8CuFsM8EHW6h2Cxvzfov3GjpJZkhcTZkycZ6teYE/yaxHdLz41DauiduRCAKK3Jb+ZVIw02XAlR3Q1TorD7sA5pM6CgGNG3W+1AfCknF4THtwbqjyvwsHB8hb2EdMdzxS5UadGtvZVFniHZLQTUU3qnetJO4U+jwHJW1btZevDOfOW2wnYl0q9cV8FPxeA1L/S2SATUcUnMCZmT5jtDdi4THfdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC2z39Vf+7MGFSTzi8JX8b8fP2AzHsqmMcAR/iHhppY=;
 b=EHiQ+OjKn2jwq9yuonIdcA8RWW6+QBz3MdrH379xJ9nJiChJ1LEaoE8DSYpL9FwXavO1a/+kVY6+6BHMsKHkMgFBtSnK87/Zz6sqFI3Sd+bPZOZi9mfzhuRVnXp0pIkOHki8JVw2OlKPZpymERxfGtjYyRSOWSOeVlqA2o3H/MxW+ERGw/04U/J9/A93nAthNoSH+eshWJFDFh0/xHMFbmWlSYUOGCvORc/5bTxFOjlhdR8uIii/yVc9nKtQSn1SzFznG9TuFhgaACBBZYhwH3FRBiiQytbNW92Z5ihEWz+6gPEEjA1BSAjXyovIln3i39Ks1gq9KwxjQ7GMYbxSSQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:21 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v8 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHcLTQpNMlUwFw1ck2qxI/DmLV3sQ==
Date: Wed, 24 Sep 2025 09:18:17 +0000
Message-ID: <20250924091746.1882125-13-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: b2672f90-3589-4e64-2035-08ddfb4b4ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z2VRVlRMNmJUd3diaCtBU2UrTi9vcXNwSCtGRi9qZlY5QUlncEFTQ21YdGpZ?=
 =?utf-8?B?VXlRajZXZFJZMEJJN2NaZE04VnBZSitseWtZeDMxckFZTzcwVmVJZi81OVVL?=
 =?utf-8?B?Yll6U0szQlNzM1JxWGRSVjBIQ3JvM1VSazJFNUdnOGxCdXJORGxUQXpaYXhY?=
 =?utf-8?B?UHlVMkM5OFdaanhqR2dCdkVzNGhvL2krcmJLY3BjYmhoTDltRnpSdXQwODhJ?=
 =?utf-8?B?Zk5PcElOclY3a0lYVU50Smdqc2VsQlRTelNMRG1lZW15YytTTmpHOVAxSE9E?=
 =?utf-8?B?NlZ5R3NLYTFOZWNwZVlWWE9hM1NhamRNUGhTdDUyUXFONUxZbS9ZM3Y3VEpl?=
 =?utf-8?B?TjhVUitKdVBHRXFReklCMlYzRlh5SENyTlhkc3hLd1FTdVRjLzVCMWxwSTF3?=
 =?utf-8?B?QUZlazdHZzhacW9FZll4NktxVERuMU1UTHBGU09aKzh2S01McFovTDNIU2xi?=
 =?utf-8?B?dGpOci9keHdlL0p3K1FWd2NqWUV6TFlpQ3pRdDhlK3lYQWtmWXdydVVJR2lG?=
 =?utf-8?B?ZUwwSUk2VGREVnFSdXc5RnNTT20wVkpaNytYWFJ1NEJodVpRUlF5SlRkNXBW?=
 =?utf-8?B?OXI1ZUV1bE9tOFJaWllaWUxwMEVXd2V2Tmc5UVQ3Um1kNm1QQ1ZlMVhjZGRp?=
 =?utf-8?B?QWpUcjdCNEZST3dZYTc3blQ0YW9nZzYxd3lBakhSZnMyUFIzNVRTY3FrblFG?=
 =?utf-8?B?MVFORnhCcmhCeEowQmd3TTg1UTduWElLZi9Vbm16U3pCdDR5STdDQmJRK2U3?=
 =?utf-8?B?MVQwN3k3anhtRW00eEQ4eDEyd2lZenk3VVRaTjhZQTBZUTVxdzBRbU5odzNK?=
 =?utf-8?B?WlhFNWZteFQwNkx2bGR3Z3p5djJCNkxjMTRKNm0xKzVTWS8wL1VLbEFwNlJR?=
 =?utf-8?B?TzBtQ1NScVNDOG9WZ3NFMDg2ODhUME82RWVPOXUyQVdtbUZEN01pQWxwaERU?=
 =?utf-8?B?enBJb2xzZ21SRFZYcmp0VGJvc2o0bFBwMlpZSmlyM0dMY2ZDL2lvY29EVy94?=
 =?utf-8?B?ZVhVNlU3VU0wS1Q5WFlrV2FiWUlWMHB5RlIxWWdpZkNDbWtnQXJ6ZDNkTDFL?=
 =?utf-8?B?OURXSEJqVkdtQnRQOHFybzZ6c2xvMU9DbVJGL1ZWbnNnYUlsdi93YittRXdQ?=
 =?utf-8?B?MGplSHNqZU56emNaWHl2NEZHdzRVZTZpOTh3L3UxaHMvaXVCZ0NYaVYyUmx0?=
 =?utf-8?B?V3E2K2lKS3hFbUZVdFA4UkdZQS9zZU03ajZ6ZlNmWmIwamo0aHpzMUNvbmd6?=
 =?utf-8?B?L2EvWlU3Y00vL2tBa0x3ZGtud3NoR25jZktzcG1la1ZLSnVHQ1U5MmNyajgx?=
 =?utf-8?B?MUZtMmNUN3p1UDJ0REdEQUZGUlFuZW5VV0tvVDNESG5zZnFKd2N2NWh5c2JB?=
 =?utf-8?B?OVZiOUJsWDNCdlc5VUErcEJ3blpUa3ZLSVdIMFk2Q09YTUU4UmR3aVlJTGxV?=
 =?utf-8?B?dUJiV25vODBmTXJSQUFYRWRmYmtmNVF6N2x0V3dJK1VjT0E0TVQrejViNERR?=
 =?utf-8?B?UmtxUlBoQ0dMemFoM0wrSTlZM2FXeVkwSVJwUDV0Q2NybUxnWUV2MXl4NmM3?=
 =?utf-8?B?VFZHWDJKWWl1dXlhc0dmYkNYMjRNczJMSVZzSlhIYis2QUFKL08yWUFUbS9F?=
 =?utf-8?B?Uk9obXJ2VHg5WlRXK2twcEszaFpYd3pzb0NTb0EybCswcTZyZHNmY0FEK0hD?=
 =?utf-8?B?cGY2QWp1UzV3dG0rUlYveDBwTXRqcnE5UFlLaUl5TnpaR2N4YmJ5eUdwRGVu?=
 =?utf-8?B?WW1QVUZzVHVPSFJUNzhLNjZ4Zk8xSW82eVVPc2VhZWliWW8wa28zMDJYbzB2?=
 =?utf-8?B?MXBZU3JuMjJGQTJTMDlKWVpqRnoxZWZuQjgrdDFmNkRJT2Z4S2xZdmpwVmJk?=
 =?utf-8?B?Rk13c3JyTmpMejFXMHVUMlJmbzJMZDlpc01rbjNySkIvNEExSlZuQVZpU3Zy?=
 =?utf-8?B?Z3prcFFCWWcxVzlTOGFlMmpLbFdUTG1EcDhUR1FIQksyQjFsWXRSdndjVzVG?=
 =?utf-8?B?WUJBVzZpTU1nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzRKVC9rMmFLL1lQZ1ZYS0xsS2NEdTNlcTNjcW1SVEdhMnQyaTlGL2szSCtu?=
 =?utf-8?B?WDFDcmlNU3FIRUNRMUFJMy9zdnNyUW9QaWdMd1B6L2UyaDZGREUxL2VwQjI3?=
 =?utf-8?B?TVVtbmhBN0JXOUpsUFJ3QWRZbm9DVnRTSURFR29VbWtmT3dFY1NTL0NKUmRj?=
 =?utf-8?B?b3RLL0tWWHI2cFgvUnpwelljSUsweW03akxWMlhJaXd6Y2JMdE8zOTZ5eEFj?=
 =?utf-8?B?OGxKWjY1c2c1bUZVbXI1dFA5SHY5TlBGdmpnTDBRTU44dDdGWVpGV1cxWWVX?=
 =?utf-8?B?TXVjcldRakRWYWFnc2F1dTk2V2VmTnpxY04xamFyOGdIWjlIaVNMMVdqU0JP?=
 =?utf-8?B?UWpiazdlTEhYdmFVWjUwV3owL211SFlvaGMwdzFxNEE5eE12cGtReE9ETTdN?=
 =?utf-8?B?ZXNGYk1ZdDExTUdQb0xsK0lFUVlsMXF0YUZIcnRtVTBsaUhhU21YRVFQQ0lx?=
 =?utf-8?B?c3VPSEVEQVVsOGcwUnhGaFY3VUxpaldqYStHQWVvOXJURVFVWjU2SFI3bmtH?=
 =?utf-8?B?cjVYQ2x4QTBWSXNqdVcrbVZBdVVhR21PWmk0WnVYSS9KclYrWUhLRjkwdnhM?=
 =?utf-8?B?VGtwUHdwNmwrRUttWDY0OFFtS1JocmdTR3FIZ0MwV1pMak13S2hzVDV5VXhE?=
 =?utf-8?B?aUFXZWtJakdjd2NRL1RqR1hhQmkwSVMzS09EMC8rdy9keldDZUl2OE4vdFVn?=
 =?utf-8?B?MzlVSVh2N2pSUWRxcFhHMXF4STh0T1dtaFRxcGpxdCs0YjRFd3VqcHlZUG5y?=
 =?utf-8?B?L3RJdTh3WEdwaDJ0UWhpdHFjNzc1bitQck8wZk94OFF0TXp0WUczbHdJaVFN?=
 =?utf-8?B?Ymc3QXNjQTVjSkdoYkFLbXJudkRSYjVaekVqZldjK21BZ2tUK3E1Zm9QSTlC?=
 =?utf-8?B?RTNHZzVoZVhWYk1ORHlqcHY3U2NxSXhETlZoeDRUS3VONkU1MXBYdWdGVVZP?=
 =?utf-8?B?VTJnL3JUYXhFZWF6emVVOEFzMUtvdWdNUk00ZGFJZVZ0UVBEQ0l0bWdOb2Yy?=
 =?utf-8?B?dVkvOGNuU0tUbjVPamc0d01qcmRHU3pLSGdOSFlSekk0RkNZaE1OQk9PTWlq?=
 =?utf-8?B?SFgvcDlNOVdtR3QyNHpVMHZ4cksvM1liMzQ1UVlISmczR0RSNm1ZcVFLb004?=
 =?utf-8?B?K1RLdk04U0JDb2ZsOWVQK0E2bzZoa0ZEZFhkNTNnUEtBTVhpandqZnBnZEtj?=
 =?utf-8?B?eWhsQzAzRjhwelNZb1JOV1c3cmNFM0F1NFRNSkQ0NUFYM3hwUHlUd3dHMnU2?=
 =?utf-8?B?VmNZdzJzUjd6NXBtanlhSWhUQWY0V3ltdWJ5cEwxdVBBWnNCclgzWjVaemRh?=
 =?utf-8?B?UVRHZDU3Q2dHN3hIRGpnZDg3ZTUxSitzT3psaVo4UWhLaE1vdkRYUGYrYnJY?=
 =?utf-8?B?LzlRY0drd0dOdUpQdDN5UVRmOUhIblhJWU41S3FVdTBkTmFYSERFdHNmbE1k?=
 =?utf-8?B?SS82N05UUEVNREprZkhySStkY0J3N3pNcm5USjVxU2ZHNjJXRCtKamIvTW5S?=
 =?utf-8?B?bUplcWJmcVlaVXg2NlVJbVJlK29JYnVjVGJSeEZiWHIwdlBPVmw2ejRLWmZZ?=
 =?utf-8?B?L2hrOWs5QkhCTHk4SUJUNVR6OTA1cTZ3N1U1b0xRWGRpVStnZG9oTm0yNFdB?=
 =?utf-8?B?MDhFN1RWdlhaVStDZDJXVzFxbGRvcGxJSXFPbXFCZ3FoWXFmR2FXblhsakVI?=
 =?utf-8?B?SmRjZmk3dklPdXU1MktETklXMjA1OHVuWlpLUzUyOXBzbmtOZG5VQ0x6Rnk3?=
 =?utf-8?B?QkZtbmRyOFl4L1hmNmZEaEtXZWhKYWlkUlR0UU1zS3BxamlZMGxXMTNJSlpQ?=
 =?utf-8?B?em42bkxRck9pMUJQb1EycmYxR1ZyWWxqZjA2dzZENDZmY0RPNWdRNjVTZUdP?=
 =?utf-8?B?ZEhtWHJGYmsyQ0VaZGVTM2taQTc1dURNV3BNZ3U4ZW5jYlc1QWhFbXFLWXFO?=
 =?utf-8?B?SHdMRmZOVTZBazJ1Zlh3VXlzVlltbWswK0FhUnQxZlYzb0FGOS9yNlB2d3Ur?=
 =?utf-8?B?bnZOOHBqQlRlN3pUeWNCNlNuVTJaM25Mb0drWWFDSDZ6empCL1YyQUd4dkU5?=
 =?utf-8?B?NE9vVEtaNlArOVpVcjZYKzdtcTFSQXczd0dxMmI3aDVQZTNsdzBNU016aC94?=
 =?utf-8?B?NlFiNjN3RW9MRThkcUFGYzljY2xBZUJ1UEhGVmFEdTVtb3EwNFZVL1hwM3pJ?=
 =?utf-8?Q?Ctf137vQpM+dq3+OyIG9dNw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <880FEA0B115BB94CBDC54F9099B00E88@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2672f90-3589-4e64-2035-08ddfb4b4ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:17.9394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkioj/78qIsr8LZoGZgbE71Y8+VDQtTrlGIy5pNQEj2mRK1pVslBywnyP/9tW5EwleexYRzoZ0LXRzUj6Fyz8W6GXOv1+0y1r3VJsk0TQ5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

U2luY2UgdGhlcmUgaXMgbm8gcGNoX2diZSBlbXVsYXRpb24sIHdlIGNvdWxkIGJlIHVzaW5nIGZ1
bmMgb3RoZXINCnRoYW4gMCB3aGVuIGFkZGluZyBuZXcgZGV2aWNlcyB0byBzcGVjaWZpYyBib2Fy
ZHMuDQoNClNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KU2lnbmVk
LW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5j
b20+DQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KLS0tDQogaHcvcGNpL3BjaS5jIHwgMjAgKysrKysrKysrKysrLS0tLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggYzcwYjVjZWViYS4uNWQ0ZmZk
MGQzZSAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3BjaS5jDQpAQCAt
OTg0LDE0ICs5ODQsMTUgQEAgc3RhdGljIGludCBwY2lfcGFyc2VfZGV2YWRkcihjb25zdCBjaGFy
ICphZGRyLCBpbnQgKmRvbXAsIGludCAqYnVzcCwNCiANCiAgICAgc2xvdCA9IHZhbDsNCiANCi0g
ICAgaWYgKGZ1bmNwICE9IE5VTEwpIHsNCi0gICAgICAgIGlmICgqZSAhPSAnLicpDQorICAgIGlm
IChmdW5jcCAhPSBOVUxMICYmICplICE9IDApIHsNCisgICAgICAgIGlmICgqZSAhPSAnLicpIHsN
CiAgICAgICAgICAgICByZXR1cm4gLTE7DQotDQorICAgICAgICB9DQogICAgICAgICBwID0gZSAr
IDE7DQogICAgICAgICB2YWwgPSBzdHJ0b3VsKHAsICZlLCAxNik7DQotICAgICAgICBpZiAoZSA9
PSBwKQ0KKyAgICAgICAgaWYgKGUgPT0gcCkgew0KICAgICAgICAgICAgIHJldHVybiAtMTsNCisg
ICAgICAgIH0NCiANCiAgICAgICAgIGZ1bmMgPSB2YWw7DQogICAgIH0NCkBAIC0yMDU0LDE1ICsy
MDU1LDE4IEBAIGJvb2wgcGNpX2luaXRfbmljX2luX3Nsb3QoUENJQnVzICpyb290YnVzLCBjb25z
dCBjaGFyICptb2RlbCwNCiAgICAgaW50IGRvbSwgYnVzbnIsIGRldmZuOw0KICAgICBQQ0lEZXZp
Y2UgKnBjaV9kZXY7DQogICAgIHVuc2lnbmVkIHNsb3Q7DQorICAgIHVuc2lnbmVkIGZ1bmM7DQor
DQogICAgIFBDSUJ1cyAqYnVzOw0KIA0KICAgICBpZiAoIW5kKSB7DQogICAgICAgICByZXR1cm4g
ZmFsc2U7DQogICAgIH0NCiANCi0gICAgaWYgKCFkZXZhZGRyIHx8IHBjaV9wYXJzZV9kZXZhZGRy
KGRldmFkZHIsICZkb20sICZidXNuciwgJnNsb3QsIE5VTEwpIDwgMCkgew0KLSAgICAgICAgZXJy
b3JfcmVwb3J0KCJJbnZhbGlkIFBDSSBkZXZpY2UgYWRkcmVzcyAlcyBmb3IgZGV2aWNlICVzIiwN
Ci0gICAgICAgICAgICAgICAgICAgICBkZXZhZGRyLCBtb2RlbCk7DQorICAgIGlmICghZGV2YWRk
ciB8fA0KKyAgICAgICAgcGNpX3BhcnNlX2RldmFkZHIoZGV2YWRkciwgJmRvbSwgJmJ1c25yLCAm
c2xvdCwgJmZ1bmMpIDwgMCkgew0KKyAgICAgICAgZXJyb3JfcmVwb3J0KCJJbnZhbGlkIFBDSSBk
ZXZpY2UgYWRkcmVzcyAlcyBmb3IgZGV2aWNlICVzIiwgZGV2YWRkciwNCisgICAgICAgICAgICAg
ICAgICAgICBtb2RlbCk7DQogICAgICAgICBleGl0KDEpOw0KICAgICB9DQogDQpAQCAtMjA3MSw3
ICsyMDc1LDcgQEAgYm9vbCBwY2lfaW5pdF9uaWNfaW5fc2xvdChQQ0lCdXMgKnJvb3RidXMsIGNv
bnN0IGNoYXIgKm1vZGVsLA0KICAgICAgICAgZXhpdCgxKTsNCiAgICAgfQ0KIA0KLSAgICBkZXZm
biA9IFBDSV9ERVZGTihzbG90LCAwKTsNCisgICAgZGV2Zm4gPSBQQ0lfREVWRk4oc2xvdCwgZnVu
Yyk7DQogDQogICAgIGJ1cyA9IHBjaV9maW5kX2J1c19ucihyb290YnVzLCBidXNucik7DQogICAg
IGlmICghYnVzKSB7DQotLSANCjIuMzQuMQ0K

