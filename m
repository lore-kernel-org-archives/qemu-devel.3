Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BED7CAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh4E-0000mX-O4; Tue, 16 Sep 2025 21:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh3p-0000RH-8I; Tue, 16 Sep 2025 21:34:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh3j-00076h-SB; Tue, 16 Sep 2025 21:34:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqEgaYxJkAZ/rC6pXkCMDkvtU9mCOVRlp7KZzR1TZHBWSLCH7G2OYdzWiMN1dmDZ13BHtCXVvKGGyqmY7GL0yHJe1Xc0hjAekbTnweg3AM4yZ3XGGmmUFfFCoIXNNIwlqa0r0oAyIYjO/yvw2hLU7WWve9ldC4ENL4I9LT4SdG/pE8r/G9hT6XkNhlSZLPAk8Eu7Y8lc7YJ2iGhiuNBDd5b7W0Ch3Ug/i77jNnqRzG+CLrYL4J8drQxi/LI2Eeksprt9IXYKCIhpl0hodjFYXmGAlAubcesbA4v71fWuHkKrycAwKmHGiXB6OUhz+J0a+tjLY2urSEZHe579UDzL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SR+GMz3A1id4urOaDttfv7oMunV6tjSZE81bhGg2SY=;
 b=aFe0MAOxQ86qo4j9c8Uj60ncU8QxqvY/c61qNuyEHweUM6VaN/SW4qJoFqiLLmr8Q03J4QBxUZUBkL/0c55B5lmCEa0sIEB9NIkGv+5DL/75QR0XI/lxnCMFkeJLBtF7X4O7xuPxoBxSP9oREv+NleDVZcS3UTtyErqTloHoHmbS2A/4cqpQJsOAgP6RALvHHTKciBzInP7P7qQjNIYyhw7TYgoyQILtzuCJdee8YNfonoYrXpNDTjYJ0XGfyhLwz8KGHWNi4xWP2ALnCFADpu1oYBKtY9v045Lt4d4Xf61QREA0Zse/1ui20K3+jwX88ZFX2YEJerynGHQwKzgV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SR+GMz3A1id4urOaDttfv7oMunV6tjSZE81bhGg2SY=;
 b=gkra6gyu2el98Q6P/zHbiZmxGajmj0rfddD5R0EJIlcm1QUd1XWfjmZGbxop2EVcVeTSJkRT2TQnfzlpEy9dR6E3F+Vz0fINgUEX0/fJa/kQewBuM7Kjp+6l2Gr4ky7oJMdgneJESAnEcKyqPEW4O0aoy/QJ2TM8+5buXHPc8K2PrYVQZ8sRhsFw8y6PsHpKnXyFuywz2qjPw3wVwDg65lqSNbxJECKeCPeY5K0jzSJyZpqCTNVyQK/aEuytXr6OVeTVHe+EB4XhmD3Fp2xtiDXvnOcTzIw2LxJPG5PieBAj4wYma92BI/F3BY4KtXgEDqIKag0sykYOjcT+LjkxCQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by OSQPR06MB7230.apcprd06.prod.outlook.com (2603:1096:604:290::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 01:33:55 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 01:33:55 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "thuth@redhat.com" <thuth@redhat.com>
Subject: RE: [SPAM] [PATCH v1 3/3] tests/functional/arm: Add AST2600 boot test
 with generated OTP image
Thread-Topic: [SPAM] [PATCH v1 3/3] tests/functional/arm: Add AST2600 boot
 test with generated OTP image
Thread-Index: AQHcJuB++UmZj0Nen06ZBfdAVy+eLrSV94SAgACghiA=
Date: Wed, 17 Sep 2025 01:33:55 +0000
Message-ID: <SI6PR06MB76311FC197F76B228A01CACAF717A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250916080406.2430111-1-kane_chen@aspeedtech.com>
 <20250916080406.2430111-4-kane_chen@aspeedtech.com>
 <682bfb92-d046-48ce-beb6-55b3f455c850@kaod.org>
In-Reply-To: <682bfb92-d046-48ce-beb6-55b3f455c850@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|OSQPR06MB7230:EE_
x-ms-office365-filtering-correlation-id: f977592a-9be7-4ec9-a98d-08ddf58a43f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?MS80SnBvd05ON2JNTWhjRXg0cXdlWmJzWlEvRURhNDNVYzZMbXc5OWlOOUpG?=
 =?utf-8?B?cHA5bVA0cnI3SmthRlcyT25tN1RUSUdxaVl2aVA4eU1yYjdJWFMxT2psSUFr?=
 =?utf-8?B?YWdSbUZrTEs3R3lLVzRlK0pTOGYxWmREam85M00vSlBWK2hoMGRvSUNFcFdo?=
 =?utf-8?B?NC9GalRKRUF2aEdobVZuMHFaMnREZEl0eEE5Q2d1M1JRRkZzK25oM2lhamVw?=
 =?utf-8?B?bG5NUDFoazMyT3lkUFJ0VTFxYy9qbEYyNjFEeUZsb3MwbU94WTNzTGF3ZFJP?=
 =?utf-8?B?ZTFQa2Qya0RocE5CeklQK0RIQlZqQXRDaDV6ZkFkTnllS1B3WFpwcXRrdSs1?=
 =?utf-8?B?RVdUcUFtL2JjOE1IYittMWxIY1pDVmR4ZTdtcWdqM2p6TDRxTEczKzhzQk5T?=
 =?utf-8?B?NHhRTnZkc3JXZGRCbDFOOVZZWjIzaUpwaCsza0VOdjdlMGk1Q1BNZmNCVGww?=
 =?utf-8?B?WFg1bkpCMy9JWWQwNTVQQnA1U09hOGFqdWVHZ0NlNlMrc2dPK21WdTFGazdr?=
 =?utf-8?B?R1IxTktKdVNMUVg2R1Z0VGZrNWVxMmxZaDZ4MlJwWWxvU083aEhsWVBudHlz?=
 =?utf-8?B?dWc2dnArWHIxdmxleGpHWXUzN2svdENTNzVJY1FlZDl0NnBncnA2MkFoQUhU?=
 =?utf-8?B?YVlXelRqUUZQaE8xS1BTV1BKYkxyRjNKWjRuR2FrNTR4aTBKcGR0YUxQTFpk?=
 =?utf-8?B?QkRsTFNaQUp3OXVPWjQreE95VWJpZTVxNHpCdjJmYmZLamttYXFtaytpVEgv?=
 =?utf-8?B?ZE5DMXZzTmZJd1RsVC96YlhtcEJWQTZ1MkdYUDkyRGFFcW1Nd25YR1BrMEpP?=
 =?utf-8?B?M3JncGM3VXVmdGJ3LzBOZ3FVbXlDdzN4WDdsQ1RoK0xVV0RSV0U2ZWc4Sm9K?=
 =?utf-8?B?QXJ1OEdlbG53QjNkazk5a2tCSzE1YUpjdlJiTkJqdEV6T2JJWC9Dcytodm12?=
 =?utf-8?B?a296Zkp5ZFhnb2pPejl6Z0kwNGpzZTNCSFFWUUsyS3dST0lDWmI5Rk5aTmFn?=
 =?utf-8?B?UXVCWHc3c0lUajErTm1sSVFEYlZ4ZVRnaGJOTGVDNStZWnRGUnE5TG5pdWR0?=
 =?utf-8?B?N1o0NWxQOW1DRmQ0MEw2Q1BuazNGQmd4NnJkSnJWREZPRWpkNDJMZlczdWRR?=
 =?utf-8?B?Z09CRi9tbEpQc2IzcVhXUVBNWkJPVXFCa2R3SUdxNHVrRzJRSlNObmhwVXFC?=
 =?utf-8?B?WkllYlVKbU91UWliU0V3L0VieGJhdk5vcUsvTEJkOU1NU1BOdlpCc2NjT2Ux?=
 =?utf-8?B?WjFNVkxVemlySHljbzl5Wk4xelJvVzFUQWNzSk9LZ3l5cWxPcG9ZYnVWY2Fq?=
 =?utf-8?B?WlFpekNsUFBKNGtPQ3drZDZRUHIxaWplODFZSHcxdUpmQnZ2SlJSWWplZ3Ey?=
 =?utf-8?B?RmtnMmxCY3JiUVdhb0NCUE9Qa2E1bTU4Nm1BWDY1clE0T2h0S0RwaGxvMEZB?=
 =?utf-8?B?S2Jvd2VteVMvdXcvdkI0Umg3NWFMRkJJM2swTkdKaTFZNTAvRDBDTnJMYXlo?=
 =?utf-8?B?b1krWUszdCtGWjdtdGhtUmRXai9Uczd5c1hzZzk0R3hmTGg3S3VYY2hWOXY4?=
 =?utf-8?B?WUV1ZTdHOEEwK3ZJaFRVSWNmSCttOHVMUlJOMUFkRHMwOXBKbE90WGpkWEcy?=
 =?utf-8?B?RVQ1UEJkcDdrSEF5UTNHVzM0eEF5NVd6TVJ3Zk5ML0tNV0phODVKZVRab0Ro?=
 =?utf-8?B?RFRxTFEzTWVWQzlncTlHbTM5aTZmSkxGbjlKcExvc3pac3NkaG1uL0ZmQmR1?=
 =?utf-8?B?Wm92VXpxNDhYaGx1cyt4NFdFMk1QcUQ1WXFtL3QrWWdCak9qM0NHZ0ZVYWRS?=
 =?utf-8?B?Z3ZaMmZCdUNWWmQ0VnFnUHp5VGJMVDd6TGpjdGZSSDhpekFVZDljYWUzSU5J?=
 =?utf-8?B?YVJ6bW5DL1V4WHAxcU1ZVDF5RThRdEduRC9aYjE1bTRMWTJyMTkyNU5ObEo5?=
 =?utf-8?B?RDQyNDErN3IxdmZ3K1pXc0F2N0pvL2RhWFJNeHBwanVnSnp6cU9CamVuUjcr?=
 =?utf-8?B?UFhWSGgzMGhzdzFyLzZvZU5RUkdOWC9YS2h4emRoYUF3NGRzV2tjRjg0Ulpw?=
 =?utf-8?Q?ojUDHP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEplb1RIYWdKVUdjZGVWK0szYnhXZ0d6NWhOMkRkdjlFTDFESWlHMWRyVEEw?=
 =?utf-8?B?TWZaazA2UkpLQStTR1BabzhiL2dkR2g2MFpGengxWlNML3o4cW5JSVlXUjVD?=
 =?utf-8?B?dVpjbEhzZFNOOWIvN28xd1kyaEFmZzV3cS8xVUxqaVhSYURxekJWNERTcGow?=
 =?utf-8?B?NEFHQ001bFErcjU5eUdxZjIrYitqMmU4enhUc3ZFNFNtNUMvMmNObnEvaXc0?=
 =?utf-8?B?Q1JsVmR3Umt6dCtMdUJvQlNpK2E1b0V3QXdpaVF1ckQ5WjhBUU5yZitDMEpX?=
 =?utf-8?B?Qng3Y09ZcVJhc05tRmdHMjh6UGp6V0NYejFwR1l3cVpXNDBEYTdsL3ZON1lW?=
 =?utf-8?B?dnBpRTByVEtpbGg5dExvZjRTeDFyK1pBSlhjVE40Rkl1NEFZZTFxd3BSb0Zx?=
 =?utf-8?B?clFPa0dRMmdNSS8zamxFWkVvbzRnd211Q0h1U2lGd2UwaHo4ZnBpZ01OUWht?=
 =?utf-8?B?dG5SSEZrMTNzUHVuWmZEc3N2L1FYcGxWcmxYZmtFSWY3ZTlURVlRYUJmUWVy?=
 =?utf-8?B?TFlJd0o0UlJQOXdRUU1hb0xpU2RSbkY0UlFQeXd5cCt6S2w5aVhKVmVrbGMy?=
 =?utf-8?B?c1g1L25SYWViRDd6S04xbjQ0cWsvVkFQSzhEWkVweVI4WWVpYWJLbnpkMTJx?=
 =?utf-8?B?NU9CYlliMi9ITXBQUUMzdFMzN2NqQzQvQkxvT0VMNitkUkJRR09IeDRlbkxs?=
 =?utf-8?B?aFFhUWV0MHFnR0x1MC9JN3VYaW90Z1V6ZUl4WEc1SWlVSzE1MFVHQkI3UjE2?=
 =?utf-8?B?VGhScjhVZGt6bnR1QnNQSGlCL3psS09BZWNGV2hWT1JxVHdDaVF0c21VOFFm?=
 =?utf-8?B?dnR1M3RCWmwxQ1ZKKzlVL05mVkdZNDlYV3R0YUZKdVBBUmxSaUh4R20wVjBP?=
 =?utf-8?B?WnI2TElZRWFqUWhXcjg5NWlXQURHak5UN3VoeVdMclJrbXNlT1dGZmdMTzNH?=
 =?utf-8?B?TkJ3czlqVUtZZ0lNNEpmWGNmbzQ0UkdwZGxjUlB5dFd2V2tJM2hXUnU3a1BV?=
 =?utf-8?B?TGFKVFQ1TE5vaXhubTBIVHhSUCtFbzFRcHd6VmZtOTYxOVRmbS93RGJOcFg5?=
 =?utf-8?B?RGRKUDBSblRkTzBiVHJlZmtlL3RadmR1U0s2Y0dyK0VUdnZkcmhHdlRXRXhp?=
 =?utf-8?B?Q1RxRUtMWklpTWRyQnhXZkNpOUFPaEJJbUlxckxLcG5PbEpsNnhZUlFndzJo?=
 =?utf-8?B?TGtUWlJodXJDOFMvbmNRS0lGdjhmMFd2cFd3aHVVSGFqV2IwTy9IZjhZeVNR?=
 =?utf-8?B?Wko3bDBINTl2SmFrekZaY3RkV3hNY2ZwSjdSSVBVNm4zcG9ldlV1ajl2YzFK?=
 =?utf-8?B?eEZnN1MxdThvVlpkSHcwUnBJaCtiN05DalgrSkJIUEo1RFArRTNaOTZ5bXhW?=
 =?utf-8?B?bVpXUy96UUJsRXBZeUZTSE9vWVJLMmk4ZTBFNHZVMWtCQ24rb0VpM1BhWXd4?=
 =?utf-8?B?ejZ1WGZrdEZnQzZ4MmdlbjJFQS9kUVZWQ0ptbkdDT21DT3FJNm9xMlJPem5K?=
 =?utf-8?B?aGFFUWF6bk1PcUEvb3RQUVltNFhvSkhkTUtCbXI0Qkt4NE1iQWZZa2d1YmVF?=
 =?utf-8?B?d2tjaHdRdXU1ZFBtRVAyMUNydVdaeFZkd1hyM2lGYXZYWG5BeWhWcnpFRm5B?=
 =?utf-8?B?bTZMTGY0YU9pMWNSTFRmSG9haEhVSWU1eEplaG5DQ1NEYnZtcW9GVVZmaXFI?=
 =?utf-8?B?R2RhdGQ4Sk4zT2FnL2RDVVJISGR5WkNjakJ3YzJWbWl3Zmc1NVRNYWY3ODJW?=
 =?utf-8?B?S3BwVFdTNDhqNXhBUXdTeGQ0bkplbFY5U3BMRzRKcW0wZE5GcmZqTVY2ZEpW?=
 =?utf-8?B?WjI5YjAzME5hU0V6MzBuUjFCcGJZek8yL2dnMDBMc3BuUGYrU3Q5RVhqa1VQ?=
 =?utf-8?B?YkR5UjVQcENWajVqN0VZc2xlc3R6ODA0eXllTGlobkNaTXBJM1I0TzRUZG42?=
 =?utf-8?B?OFFUOHUvL2NMRWZWT1pqNXY4aDBpQXJHeXhmSzhlTURtSzA0bVlwYXRDT2FN?=
 =?utf-8?B?TXRxaGJaaVNDNk4rMVc4dURlUlI3WVRJUWdiUzJaYmJFRysvWXMwY3BpR3Rp?=
 =?utf-8?B?TzBoSjJnR2wyRmRxRkp0TVZkTHUxL1B1eEZUNWlWbjhZbzVhdStRNWptTExa?=
 =?utf-8?Q?AoZlc5Rhdgmra6muOSURliqfR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f977592a-9be7-4ec9-a98d-08ddf58a43f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 01:33:55.0786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fqassJw0LFD3dnfUMWFVT+s55UUEvPUx/ouFZCS1ax67OE6QOLnD8BJgbDCqxtW10iQ2oi3TseGDPnRqss2IC64yjG0NKVFPwxW+cYBOus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7230
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBmZWVkYmFjay4gSeKAmWxs
IHNlbmQgYSB2MiBhZGRyZXNzaW5nIHRoZXNlIGNvbW1lbnRzLg0KDQpCZXN0IFJlZ2FyZHMsDQpL
YW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSAx
MTo1OCBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRl
ciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2
ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsg
SmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8
YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5h
dT47DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4g
bGlzdDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENj
OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyB0aHV0aEByZWRoYXQuY29tDQo+
IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDMvM10gdGVzdHMvZnVuY3Rpb25hbC9hcm06
IEFkZCBBU1QyNjAwIGJvb3QNCj4gdGVzdCB3aXRoIGdlbmVyYXRlZCBPVFAgaW1hZ2UNCj4gDQo+
IE9uIDkvMTYvMjUgMTA6MDQsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4t
QVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEFkZCBhIGZ1bmN0aW9uYWwg
dGVzdCB0aGF0IGJvb3RzIGFuIEFTVDI2MDAgbWFjaGluZSB3aXRoIGEgZ2VuZXJhdGVkDQo+ID4g
T1RQIGltYWdlLiBUaGUgdGVzdCB2ZXJpZmllcyB0aGF0IE9UUCBjb250ZW50cyBhcmUgcmVhZCBk
dXJpbmcgZWFybHkNCj4gPiBib290IGFuZCB0aGF0IHRoZSBzeXN0ZW0gcmVhY2hlcyB0aGUgZXhw
ZWN0ZWQgY29uc29sZSBwcm9tcHQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4t
QVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL2Z1bmN0
aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDAucHkgfCAxNCArKysrKysrKysrKysrKw0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwLnB5DQo+ID4gYi90ZXN0
cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwLnB5DQo+ID4gaW5kZXggMTI5Njk1
Y2E0ZS4uMTgxMzYwMWZjYiAxMDA3NTUNCj4gPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2FybS90
ZXN0X2FzcGVlZF9hc3QyNjAwLnB5DQo+ID4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVz
dF9hc3BlZWRfYXN0MjYwMC5weQ0KPiA+IEBAIC0xMzYsNSArMTM2LDE5IEBAIGRlZiB0ZXN0X2Fy
bV9hc3QyNjAwX2V2Yl9zZGsoc2VsZik6DQo+ID4gICAgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRf
d2FpdF9mb3JfcGF0dGVybihzZWxmLA0KPiA+ICAgICAgICAgICAgICAgICcvc2Jpbi9od2Nsb2Nr
IC1mIC9kZXYvcnRjMScsIHllYXIpDQo+ID4NCj4gPiArICAgIGRlZiB0ZXN0X2FzdDI2MDBfb3Rw
X2Jsb2NrZGV2X2RldmljZShzZWxmKToNCj4gDQo+IHBsZWFzZSB1c2UgYSB0ZXN0X2FybV8gcHJl
Zml4Lg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gKyAgICAg
ICAgc2VsZi52bS5zZXRfbWFjaGluZSgiYXN0MjYwMC1ldmIiKQ0KPiA+ICsNCj4gPiArICAgICAg
ICBpbWFnZV9wYXRoID0NCj4gc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtfVjkw
N19BU1QyNjAwKQ0KPiA+ICsgICAgICAgIG90cF9pbWcgPSBzZWxmLmdlbmVyYXRlX290cG1lbV9p
bWFnZSgpDQo+ID4gKw0KPiA+ICsgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoKQ0KPiA+ICsg
ICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoDQo+ID4gKyAgICAgICAgICAgICItYmxvY2tkZXYiLA0K
PiBmImRyaXZlcj1maWxlLGZpbGVuYW1lPXtvdHBfaW1nfSxub2RlLW5hbWU9b3RwIiwNCj4gPiAr
ICAgICAgICAgICAgIi1nbG9iYWwiLCAiYXNwZWVkLW90cC5kcml2ZT1vdHAiLA0KPiA+ICsgICAg
ICAgICkNCj4gPiArDQo+IHNlbGYuZG9fdGVzdF9hcm1fYXNwZWVkX3Nka19zdGFydChzZWxmLnNj
cmF0Y2hfZmlsZSgiYXN0MjYwMC1kZWZhdWx0IiwNCj4gImltYWdlLWJtYyIpKQ0KPiA+ICsgICAg
ICAgIHNlbGYud2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKCJhc3QyNjAwLWRlZmF1bHQgbG9naW46
IikNCj4gPiArDQo+ID4gICBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOg0KPiA+ICAgICAgIEFz
cGVlZFRlc3QubWFpbigpDQoNCg==

