Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A3C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 01:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAf6m-0004Wx-EV; Thu, 01 May 2025 21:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAf6f-0004VN-Bd; Thu, 01 May 2025 21:22:27 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uAf6a-00016D-Gd; Thu, 01 May 2025 21:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxSX7kfpICKu59ijn3P0ICLIarDGf0NStlzYZRJoculXlndqm3y+FazpRD5LtPmAWkADcv7DYNUE4oGeBFhanWfJovUdx7YuRXVDVklXQVxXUXIxEEqro84FFmaocW2GB42N/0B5OPbhKvWTKrWzYkgEFSXoSkGPI3uazxh9ljeitKufgbhuXw+ELjNLRrDeGvcogkxDsfDgAte0iCXtisJu36Qh57+PVzMbUKGrbYtVA2q2lFGjsZg0cYL8iMEVkb3jDWOqmpzBl4LUN5WepexA5lRZPWXCHR0iSBNzXBofTiVstmT3USZ+mTpyqBe605vReomMmyCU5IEtYq6z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVKUDXxS3dlc6jxRrrCH+Y2ZcondI3goOCrFvY8e0qc=;
 b=og2mvuVsluz6imJsB8cGMj22bmdJDdJ92AH+sBeRUrtNkWXOxvMQtJUYypH/o5HHU5r8+qrO/IATf0seTerMMY36GB30UV0xESwwQoylO6foGsiHgPbeoRyWYj6mC+iVgRCbETXSABM0H2taKweUlt0bg9YZMZR9oN2gSihRtlmFu6fX06vVrLT+3aEtvGsfCDw0lKgrrOcMDLNraBxnnKJGIE4sxC3SLrKH/PFFap2YsFcVpP5zp0qVl1kYkui+rQgWykWeyRPOMd7mAoaGlBkJGRL3/tjkzqY4PAMgSEa5i5pje/wk3L+4p2tPcYlVLdGH4NMPm/OCbxv5qW6ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVKUDXxS3dlc6jxRrrCH+Y2ZcondI3goOCrFvY8e0qc=;
 b=LKz0IPow8lYlNsqqJM0dHpvdbuC5i+wpQIhbaZj4QSn+MFavEoVtdq93tQ134CTCQR7YqOhBdOKIxAtYEqMr9yyzbw4IfovlYTxWz3Cwet+L2htUGQclblgkU40KcCaXdbOB6jWkeTD/4FwJkrf4MpIYg8Qq03B1wTfcmukcNGVJ2/6d6+6F/P0LlpxpfrexWT63R0kiXMet04GA4rj2evj1Dt6saSm+pS8YKBwnmykUTpLrsWBg1fPlFNP54rEvTMVtX8cxt6kLxLcrQa1yZMV8H2iH95ybGaBCLJfqK31HZpeeuRPnDqy912uj2fGye/8sExvGiRjVSLf8WWExyQ==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SE1PPF3859F7047.apcprd06.prod.outlook.com
 (2603:1096:108:1::40f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 01:22:09 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 01:22:08 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 0/9] Introduce AST27x0 multi-SoC machine
Thread-Topic: [PATCH v3 0/9] Introduce AST27x0 multi-SoC machine
Thread-Index: AQHbuOe/MiMuF76Mt06pHpjY7Sq787O782cAgAKbCzA=
Date: Fri, 2 May 2025 01:22:08 +0000
Message-ID: <KL1PR0601MB418091FFA5FBCB0159A577C9858D2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
 <cdcf1ec9-9b67-42f5-970c-db82c91cf0bb@kaod.org>
In-Reply-To: <cdcf1ec9-9b67-42f5-970c-db82c91cf0bb@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SE1PPF3859F7047:EE_
x-ms-office365-filtering-correlation-id: 487d6614-724e-4ee7-bcde-08dd8917c1c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1lkLytzMS9NK0V5VXJ3NzRpWkU4TVEydk14S3dNUVREN1MxVytrTHlmY1ph?=
 =?utf-8?B?cmdGWHVqcko1RHVqY0JHVEpDTEh0TXF4eXdqOWFqMFVVUzhxb0UrY3BUcHJD?=
 =?utf-8?B?Z3h0R05hM01UVFdlTy9LVlVJZjhQMGZHbmU4MG4vc0FkcEw0alE3M2hwU1hm?=
 =?utf-8?B?RkFCbldHSFVxSXVSWVQwUEhITzlORTVZR2JnbG1yS1hMakNqZjMxcjVjWkVw?=
 =?utf-8?B?dzVlbGpIb20xRm1uK3dXdGhlY2JJQ1ZIN1JMbmpEWFdwZjFQWCtoMVk2WlVr?=
 =?utf-8?B?dWo5K0RBbWNlSUY1eStJMGNrRjVzZmU5ZFJXaFVLRTlCdkRVMWR2bHNtKzZm?=
 =?utf-8?B?NEdFZm40bStEZHF0by9Vb2tISWN5UkcwT2Vob1hyZXFWQmRVQVdCZEoza2h5?=
 =?utf-8?B?ZkE3eGRkMUFzTVN3UGFKeEhPYmY2eTAyaXc5WVFLaHhubFZFenMyK2lVSnlE?=
 =?utf-8?B?WkdTa1Z2YTFpUnp5bEV1ekZENHZMeENHTG9ualB0SVNUd2tUcGVGdm5tWFRa?=
 =?utf-8?B?dG9jTHJxL0h3Z21OREJ5cVRLOHN0VEFmc3FtY0w5cWt1dWJHZ0E1dzgwQ2ZK?=
 =?utf-8?B?MUVIL1Y3R0dETUg5RmlIZ0pxak15V2hBVmd6dkp6RmdoZVVYZ0RQSWlZQitr?=
 =?utf-8?B?R0xIUUZ3bDFnRmZyUUw3RWhWa0lwWVJuc2V6V2t5cW1nVGtqd3dDVVNIYlY3?=
 =?utf-8?B?bFd6NmtSby9uYjFUVkVkaGpxYUdvOVVrbjhsekFGaHphd3grQjQvSDlkUHQy?=
 =?utf-8?B?cmIvdC9Qd0dWdHg5ZlBMNzNIbVpSWW4ySkNZMHNNWi9wbVNwbEJKSGc5NVlT?=
 =?utf-8?B?SG5GMWRscDV1cHFxOXZHOEdIS0RoaVluSDU0L3dCOG5OODI4ais5TWdBU3FC?=
 =?utf-8?B?RVNvc2dOc1dKOExLN1pYb2x0VmNPbndVNy9xY2ovaW1HKzU0bjZ4eUVkb3hF?=
 =?utf-8?B?N0NLNUJoOXRlUzJMQXR4VlRaYSs5bDJ6YlpkU0NURFMrMzloTmxna1RqMktH?=
 =?utf-8?B?QjdWb0JJVEcxaUhHL3g2OEtQRHpucXhncFNjN3RlS2FJTzNhTnpCaEZaZU1Z?=
 =?utf-8?B?QTdZNE91N3pSNlMrOUU5bTdveENhLzhhVUxmNDR4RExwVXpWTERnSXpYNitF?=
 =?utf-8?B?WUNPRzlvVGxTOEFCenJtQUMxMnMrMnJFWER1ZGRUWDEzQ3RocEVNZ2ZURnli?=
 =?utf-8?B?UC9BYnRRVUo5UEFzM3Z0UFZhZTVLTlpxVVpyby9uNTF6akZjOGg5TWl0TWtB?=
 =?utf-8?B?ekl6d280SzVLSW9pMDF6V2FDWHl6bzBudTlaaWc4bEdHTitOS01TV2N4WE53?=
 =?utf-8?B?STIyeHJGdjJIc0F0NDVzUnFwdzVZQ1M4K1RweFQ3VzY3NmJWU3VSa0Z3djY5?=
 =?utf-8?B?aXc3Mm5sNWk0VHpONk1VbHBYaHlHeHJKeE9vVVlwOGdFTE9lQVZWTkhxaHBn?=
 =?utf-8?B?U085MUM4NUZaYW1iMiszSzlkQWVtNlBnZDFVUGpOTC9Vd1lFNVM2ZDdrcW9I?=
 =?utf-8?B?VTFwQUVyVzM3d0RZQjZpZ2dZclBLSklNRDd6L2RPSURDU2R0WGliSUFkbXBi?=
 =?utf-8?B?Qml1NkZZNElXeGJzdXo5N1JnN2dmc3ZnSlhSWVRMOEREQUJCcUhublJPdGgx?=
 =?utf-8?B?Vzh1aThSQjhsUGRVN0tyVEpaYXJjNTFnQkQ3RmZQWEdIVWRRbFZzeDlaYXc5?=
 =?utf-8?B?dlFoRStWN21WdU4vWFZLU2hQRXh4WXdmWmxadnNTL2FGNzh1aFlLWXRWNFBJ?=
 =?utf-8?B?WFZNT2VpM1VGV0JXRmwyVEFrbk1IVDdFMk5NR3kxT3YzakZHSURpUUluK2ly?=
 =?utf-8?B?MThGeXMvUG1nTURFbU4rTzE1OFNEQUEyN3Rib2lHenNzYjRpc2FmNzlPOWtJ?=
 =?utf-8?B?WFhja2E4bzRzMVZUQ0w3bDYyRCtvU1RqNlRaVWxUdFQ4elJLZU1zdDJZTmV0?=
 =?utf-8?B?VHZOTEhUalg3ZG5oSDJVeGZQeVF0THE2L2NjM2pBYXFmS3MzYWZyWmZJUVVh?=
 =?utf-8?B?SXViVTFvcGVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnBwd2VkaHU5ZEp3U0Jobm53T0tJRG5jZ0YvdHZuamE2c3VSbW8wSWM2UnVQ?=
 =?utf-8?B?RElWajVnVTFlUnIzb3JMWmxqU3RVSURTK3djcitEeXdxV0dLQmZib3JDTTda?=
 =?utf-8?B?aDZ4azBOTzhmT3hBRVNWbE55a253T1VCemF2Q0oyWFpybjlrZ3Z3d3NPa0Jv?=
 =?utf-8?B?dGR1bW1acmRyMmhjSmZycnZvN29QalhCQURLejNCT2lobUN1OWk1TUgycG1C?=
 =?utf-8?B?UmZQU1d4OE1qTEVINnhUcFFqVkJvdVZqK2VObXlQcVhTVGtzbTJ3K2NXOVBi?=
 =?utf-8?B?WmVRVDFlZWJqMWJZalA0VEMyQkpZcXluZzl5VUdlV2pHWVJMMG9KV3ZRYkk2?=
 =?utf-8?B?cXFKOVFqbVFGN2pxZWs1VkY1a2lOOVNwUHVDTlFMYWo1aFRnb3BEZ2dTekdJ?=
 =?utf-8?B?Qmp1WW4zRWtsM3BBTHA5MlF6a21WYnlKTVRMaGJJZ3YzcTBDQ2hFclZ3OEhr?=
 =?utf-8?B?cy95cWhkRytDdlM0Z1FjRW5XL2NSTWRMU3lxVjRxSjJjdnoxcDhqVllHZUli?=
 =?utf-8?B?TlRTUWRrcjdZQk44aWl6WjRML0NDUXBNRUx1NlZnTS9xeEZBOTBMVzJ3WkFG?=
 =?utf-8?B?NEtUcDVvYjNFRkwvb1RROHZ6dXRYNERQQUZybEhPVVhuL1VpSk92QWRmMUNr?=
 =?utf-8?B?UlQzbEtrVGZmdnZIVHN6UXdWOElSUmIvcmxEMG42ZEZhUjV2amQrTWcwa0ZZ?=
 =?utf-8?B?NS9sRlZKNlRQRGttaUhaSXpDK2tDQlN1OS82d2I4VVhOUVlsUGE1c1kxNHZW?=
 =?utf-8?B?MVM5Wis2eDUrZDBXYVhESzZYcmZyVFJGak96c2U1R0dsaUhHODVDaDVWb2FB?=
 =?utf-8?B?TFpiTS9pajc5MzdpZ2JLdlY0NlZFSFd3WWtIcFppSGd5Wk9SeWwzb0JESHZF?=
 =?utf-8?B?RGFLOWJHTkF1MzdhaUFYbU0raVhYYUdxQXdYQkQ2UUE5TjVUWnp5eTZ0bG4y?=
 =?utf-8?B?MldvZHF5SndrS0VJYjc3Kzkvd2xRbXNaOGg3RkpoNXZmcEVzbmNtRkwvdGxy?=
 =?utf-8?B?YW5WVlphd3IvTUxCdnlpd1FJbklIWldITmd0RkI3NlBUTEUxS3ZEUG1TSUZQ?=
 =?utf-8?B?Q3R3alNCNlJHSW9oZ1lvWDYxRm5GMUFsR0s5VzJMcnJ6ZDYwcDg1bDVvU3cx?=
 =?utf-8?B?aTV6cnVjd2dVSzZhRmYxV2xiWkNNZXBYQ002NXBCSUZZMU5GNDFvZyt1TGRn?=
 =?utf-8?B?N0pSZng0b0NJd01tOFFTeHozM200Q0pnWThPVytKVVZ6REdPY0lQdStmUzll?=
 =?utf-8?B?RUMzcVhoYzc4emlLMmVRKzdZMzZYSUhrUGZXTlVkbjRVU2x5aVhZemRmMHV3?=
 =?utf-8?B?NXRZVGphdW9zZnA5TGFHaUxZc1hRb2l6YkhVRDFUbnloZkZlV0xxQ3ZjTjlG?=
 =?utf-8?B?VFp1U3FzMEhJQ1FUelgzUkZMN0o5Z1NkVE96Qk5LdFc4d1VScUVhb28yajF2?=
 =?utf-8?B?N2toSWd5YkRRbG0vWXpWMDhMTnBxdWZWOFoxbHdFR0JGa0JEVXJ5bmxKejBC?=
 =?utf-8?B?NklvanZkL1FHTG1mbGNOd1FRRWFmUCt4RGRGUzI2L1ZKY1cvT2VsNkdMSmx0?=
 =?utf-8?B?N2dPeThrb3Ziei93SGpMclR5VHBidzdNUCt0UE1uelQ4c2FDaDN3SjhrUGg0?=
 =?utf-8?B?VThYTzh4MFBoMFRIcDNtZWhuNVdHdnBMMHl3WWtqSHlzWjJzVUZpMHRVRW1a?=
 =?utf-8?B?RDlQaCtEUTA1SjZNckVTWGVzS0xVK0xBSWR6UUNsU2xTM0I2bzZ6QXRGU2JT?=
 =?utf-8?B?Z0gzNzRYdEhZWFdpQ3hDYm1BQS9Fa2hGb0FJcVVBcnVGdGpIU1hBSGY2WDFw?=
 =?utf-8?B?ajdCQkNaTS9uWUNvZXJOZ1ZFWXZWVTJJZVRHeEg3WU1DOEtQQ3Nydi82OXJa?=
 =?utf-8?B?bjhHMjFZaGlTYmIrUTl3ZFdMcFBySjd0TURTYjRZVitPVDN1WnBxLzN1Y0ht?=
 =?utf-8?B?bHdCaDZ2OUpabjQxdXpPU3BQL2krVktzUytscGNadkZoWkFtZmU4RllLL3dS?=
 =?utf-8?B?M29TbFFERDB0U2JMWW5JR0dUZE5XRDN3OEw2bUNhUEpUdjVlWnhrdWZoZE14?=
 =?utf-8?B?K0Z2clR4STZjR1pyRVRqTlcreEg0YWdTbUdXODhEMCtSMFUyWUlUS3krenFl?=
 =?utf-8?Q?YFUD1wnK+b/uCGyukxHh3TGm7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487d6614-724e-4ee7-bcde-08dd8917c1c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 01:22:08.4326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1V74oJhluP27nAF4SeUUvj8MIUHFmin5lq1dC9zeUyIGBur26oMjz4l5CSrhlBQRPKHMAZh3HS2F+7L0efPAsbtcIMjvHXLTmMZB1gyniG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF3859F7047
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=steven_lee@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMw
LCAyMDI1IDU6MzEgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExl
ZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvOV0gSW50cm9kdWNlIEFT
VDI3eDAgbXVsdGktU29DIG1hY2hpbmUNCj4gDQo+IEhlbGxvIFN0ZXZlbiwNCj4gDQo+IE9uIDQv
MjkvMjUgMTE6MTgsIFN0ZXZlbiBMZWUgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW50
cm9kdWNlcyBmdWxsIGNvcmUgc3VwcG9ydCBmb3IgdGhlIEFTVDI3eDAgU29DLCBhbG9uZyB3aXRo
DQo+IG5lY2Vzc2FyeSB1cGRhdGVzIHRvIHRoZSBBU1BFRUQgQVNUMjd4MCBTT0MuDQo+ID4gVGhl
IEFTVDI3eDAgU29DIGlzIGEgbmV3IGZhbWlseSBvZiBBU1BFRUQgU29DcyBmZWF0dXJpbmcgNCBD
b3J0ZXgtQTM1DQo+IGNvcmVzIGFuZCAyIENvcnRleC1NNCBjb3Jlcy4NCj4gPg0KPiA+IHYxOg0K
PiA+ICAgIC0gTWFwIHVuaW1wbGVtZW50ZWQgZGV2aWNlcyBpbiBTb0MgbWVtb3J5DQo+ID4gICAg
LSBJbnRydWR1Y2UgQVNUMjcwMCBDTTQgU29DDQo+ID4gICAgLSBJbnRyb2R1Y2UgQVNUMjd4MEZD
IE1hY2hpbmUNCj4gPg0KPiA+IHYyOg0KPiA+ICAgIC0gUmVtb3ZlIHVudXNlZCBmdW5jdGlvbnMN
Cj4gPiAgICAtIENvcnJlY3QgaGV4IG5vdGF0aW9uIGZvciBkZXZpY2UgYWRkcmVzc2VzIGluIEFT
VDI3eDAgU29DDQo+ID4gICAgLSBBZGQgQVNUMjcwMCBTU1AgSU5UQyBhbmQgQVNUMjcwMCBUU1Ag
SU5UQw0KPiA+ICAgIC0gU3BsaXQgQVNUMjd4MCBDTTQgU29DIHRvIEFTVDI3eDAgU1NQIFNvQyBh
bmQgQVNUMjd4MCBUU1AgU29DDQo+ID4gICAgLSBBZGQgQVNUMjd4MCBBMCBTU1AgU29DIGFuZCBB
U1QyN3gwIEExIFNTUCBTb0MNCj4gPiAgICAtIEFkZCBBU1QyN3gwIEEwIFRTUCBTb0MgYW5kIEFT
VDI3eDAgQTEgVFNQIFNvQw0KPiA+ICAgIC0gQWRkIGZ1bmN0aW9uYWwgdGVzdHMgZm9yIEFTVDI3
MDBGQyBBMCBhbmQgQVNUMjcwMEZDIEExDQo+ID4gICAgLSBBZGQgRG9jdW1lbnRhdGlvbiBmb3Ig
QVNUMjcwMEZDDQo+ID4NCj4gPiB2MzoNCj4gPiAgICAtIFJlbW92ZSBBMCBTb0Mgc3VwcG9ydCBh
bmQgcmVsYXRlZCBmdW5jdGlvbmFsIHRlc3RzDQo+IA0KPiBQbGVhc2UgcmViYXNlIG9uIHVwc3Ry
ZWFtIFFFTVUgYmVmb3JlIHJlc2VuZGluZy4gVGhlcmUgYXJlIG5ldyBjaGFuZ2VzDQo+IGJyZWFr
aW5nIHRoaXMgc2VyaWVzIChtZXNvbiwgY2xhc3NfaW5pdCkuDQo+IA0KPiBBbHNvLCB0cnkgY29t
cGlsaW5nIHRoZSBkb2N1bWVudGF0aW9uIHRvby4gVGhlIGxhc3QgcGF0Y2ggaGFzIGZvcm1hdHRp
bmcNCj4gaXNzdWVzLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KSSdsbCByZWJhc2Ug
dGhlIHNlcmllcyBvbiB0aGUgdG9wIG9mIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11
L2NvbW1pdHMvYXNwZWVkLW5leHQvDQphbmQgZml4IHRoZSBkb2N1bWVudGF0aW9uIGZvcm1hdHRp
bmcgaXNzdWVzIGluIHRoZSB2NCBwYXRjaCBzZXJpZXMuDQoNClJlZ2FyZHMsDQpTdGV2ZW4NCg0K
PiANCj4gDQo+IA0KPiA+IFN0ZXZlbiBMZWUgKDkpOg0KPiA+ICAgIGFzcGVlZDogYXN0Mjd4MDog
TWFwIHVuaW1wbGVtZW50ZWQgZGV2aWNlcyBpbiBTb0MgbWVtb3J5DQo+ID4gICAgYXNwZWVkOiBh
c3QyN3gwOiBDb3JyZWN0IGhleCBub3RhdGlvbiBmb3IgZGV2aWNlIGFkZHJlc3Nlcw0KPiA+ICAg
IGh3L2ludGMvYXNwZWVkOiBBZGQgc3VwcG9ydCBmb3IgQVNUMjcwMCBTU1AgSU5UQw0KPiA+ICAg
IGh3L2ludGMvYXNwZWVkOiBBZGQgc3VwcG9ydCBmb3IgQVNUMjcwMCBUU1AgSU5UQw0KPiA+ICAg
IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3A6IEludHJvZHVjZSBBU1QyN3gwIEExIFNTUCBTb0MN
Cj4gPiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwOiBJbnRyb2R1Y2UgQVNUMjd4MCBBMSBU
U1AgU29DDQo+ID4gICAgaHcvYXJtOiBJbnRyb2R1Y2UgQVNQRUVEIEFTVDI3MDAgQTEgZnVsbCBj
b3JlIG1hY2hpbmUNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbi9hc3BlZWQ6IEFkZCBmdW5jdGlvbmFs
IHRlc3QgZm9yIEFTVDI3MDBGQw0KPiA+ICAgIGRvY3M6IEFkZCBzdXBwb3J0IGZvciBhc3QyNzAw
ZmMgbWFjaGluZQ0KPiA+DQo+ID4gICBkb2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJzdCAgICAgICAg
ICAgICAgICAgfCAgNjEgKystDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAg
ICAgICAgICAgICAgfCAgMzIgKysNCj4gPiAgIGluY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5o
ICAgICAgICAgICAgICB8ICAgNSArDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyAg
ICAgICAgICAgICAgICAgfCAxOTIgKysrKysrKysrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLXNzcC5jICAgICAgICAgICAgICAgIHwgMzA5DQo+ICsrKysrKysrKysrKysrKw0KPiA+ICAg
aHcvYXJtL2FzcGVlZF9hc3QyN3gwLXRzcC5jICAgICAgICAgICAgICAgIHwgMzA5DQo+ICsrKysr
KysrKysrKysrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICAgICAgICAg
ICAgIHwgIDc5ICsrKy0NCj4gPiAgIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgICAgICAg
ICAgICAgICB8IDQyNA0KPiArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L2FybS9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArLQ0KPiA+ICAgdGVzdHMvZnVu
Y3Rpb25hbC90ZXN0X2FhcmNoNjRfYXN0MjcwMGZjLnB5IHwgMTM3ICsrKysrKysNCj4gPiAgIDEw
IGZpbGVzIGNoYW5nZWQsIDE1MzAgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+ID4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMNCj4gPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3QyNzAwZmMucHkNCj4g
Pg0KDQo=

