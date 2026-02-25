Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D528F55440
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4nk-0001wm-U2; Tue, 24 Feb 2026 21:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4ni-0001wR-Oq; Tue, 24 Feb 2026 21:38:58 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4ng-0005ja-3h; Tue, 24 Feb 2026 21:38:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlRmafMQ04vICH/uAogNBDy9KOMQYQgX2aHkc6POAzo6/5huahhnm3xh/SrvgAIrQdBxAPfZo3zYfDR6kxKmE6FkKI8+o2/6lO6K61qrj/nXjUZGH4TRDfxoliSfpfr5pmynSVTesUcEEPcKCRFLT+oK1QTuNe/9FKkvNWdd24W/4qkk8bxQn8MfoeXKC47NcmUVaue9XSzXahNRCo1VSVvOaohul+vqyFhrK6odX7AkFaegkQSdEtjG8Mmj85ZS+X9fBLBye5vAMOapTyPB6AWUJm6qvMjq7LrQH9h6Ox9RCdzc7dY1t7nBofsLuIX3Re4sVs8lTkAaQnkCfyMMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D8C1tyfqq82KmnymuAocp154kcIhETGZxHUH/nBvqM=;
 b=B/ygk58sVguBoINkXmcALmPFWVq+7+c78V+AzjtaIDr/cYtPSzy4ma0Q7KAo6MGzCJt9jB+isKcW1qgtFyFx7R6fQmt06RiVIXKLlN1jX0J2VBUK3fDq7egotMRdknQDZtXoJtqJeWtLP+VDffKdGnsK0JvrqCv6l8h8bzYlGfPSthXDg397vdfBP+tJH7YOLWIb+T1p5wLqptVuu3j12VWMu/NzRCub24WPGT+j6SKIngF+GeIFY5IoZs3PjXzmFr1/Y6VAM8HwvRI/z0chGDprjSS15nBYwWt+3mpGPXkJWso8kzQrDFLMjfBw2EeaE4A+X8xe/jdoMpqVzyID+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D8C1tyfqq82KmnymuAocp154kcIhETGZxHUH/nBvqM=;
 b=Hxbpi0+XnOxwL98QfDD4rFTXXEjdlBWx9dXXy9XiWQci6Bph0zPNLdiW4XofFgMZI4wfAfWJCygRNe1ED2GQLkplhIZlpda7Kn46S1MlVT+OOh+vuO7BqoXg/asUBb2eUnjKpFAraFFHA0TTeiazIzc+a24nrrNv9z4AtQrnMCwIpbqQXvxGzdsz++4OaTJgaIUuDvEav/YvtQ9e7eprXJmQhmc70jua60sVdPZpdIseDdxidp+XP/nALrhnIkHramJ39w6Fs8boNT8SNbshc3yWGxxy/+LbjG/t9Qn2WEaEjLcm8ecwoEhkNwyxWVQO07fB2mSAVSc7bnnhtojb4A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU2PPF9730E669F.apcprd06.prod.outlook.com (2603:1096:d18::4a4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 02:38:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:38:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kane
 Chen <kane_chen@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Topic: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Index: AQHcn/bXw5yLp/LOskOx+2qAxSW0vLWRLc5ggABt1gCAAAOLEIAAF7uAgAEEUJA=
Date: Wed, 25 Feb 2026 02:38:45 +0000
Message-ID: <TYPPR06MB8206A6B15C49657A1465DA4EFC75A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
 <98898cd4-de19-41b7-b519-541c48b462ea@redhat.com>
 <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
 <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aa6cbbb8-d8db-451e-9f9d-c430b2e030d9@redhat.com>
 <TYPPR06MB82061B01B8E9B13A241A6AF8FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <6be71017-6be7-4be1-9010-6a1cc4391bd8@redhat.com>
In-Reply-To: <6be71017-6be7-4be1-9010-6a1cc4391bd8@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU2PPF9730E669F:EE_
x-ms-office365-filtering-correlation-id: 29aec055-fb2c-4998-d15f-08de7416ff3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VDNkS3dqQkZuaXg0VmtsRiszWlNOZlJTTDZYOG5WcEZvSTFZZ2FHN0JIdisr?=
 =?utf-8?B?akxyN1g0VUNTZzVxZ3creFdVazhqZll6djg4Vnl4Zk45L3Z4YitrS0trUGd5?=
 =?utf-8?B?eVZ1Nm9FakZicXpRMFlTUG9vVG83WDhoaUdCQXJQM1c4STEyVVh0NTIxbUs1?=
 =?utf-8?B?VmFXTnhtS1U4WHJHUVhUWmEyRTBtUzRLWnBmb2ZKOUh3andYeUxOTmlTM3Rq?=
 =?utf-8?B?Z1V5MjlwbXRxTGRCYTNmbHQ0ZDV4SDFONWNwWkhjcFBlU1BmQVlGVzFla0hk?=
 =?utf-8?B?QWZiZ05rNjJEc2M3T1ZBL25qSTVsRUw3NFRnNEhzcEVxazNkNUE3YUFtRTZr?=
 =?utf-8?B?blI5SjVVVTcvaXRBQWhTRXhnZXhWQWd2eUQ4bWxwaXJLcldBdEREbVVud1FE?=
 =?utf-8?B?Mngyd3V0Z2dkS1ZXNmpwNllBYWxmcFU4MmVhM29VdVVMK09Ic2Vzc1prZy85?=
 =?utf-8?B?cnpXM3Ixd0tDM0VpYkFEZVkwWm1hKzhEaDVZaDIwSFduMmdCMmM1aG5xYnAw?=
 =?utf-8?B?enhBTkNjSGNZdXozQ2kwMnRNZE10TlliSzdiR3A0WkZyQTN4dU1xTEk0QkhD?=
 =?utf-8?B?cXJoUmNZNTJiTkY1RTkzOHBXbzNwa3VUelc1UGtiUHZhWGlZdllJblFBb2V3?=
 =?utf-8?B?Q21JZFgrcGR0cDEzQjR5TFBJNDJGUGxaNnZhTDJsNDNZZWxIeWkyckN4YS9x?=
 =?utf-8?B?YlliS1lCTC9qY2NUdWZyeURWN25VODNVTGZsMHpLNTBUcjZOT296aXYxTCtj?=
 =?utf-8?B?ekN6UnMxalVIdlZ5SWxncXR0VHA2a3B1bEU0UW1LVlhWNFduaWQ3TytIMTUw?=
 =?utf-8?B?WFpKb3ZWK2U2MjdMUWwzTTQxQ216dzRpKytwVnlGaXNjTTJGWERqbjF6Qy9p?=
 =?utf-8?B?WTRXZ3E3TzVBNTVlNXZtRDlEWktPaXk4YzcvVUEyTkxhdWlkMjZORlNhcVRK?=
 =?utf-8?B?dWNKRElKUnhDazFWV3RHMlFON3hFM1FUMlBYanAxbnJxNEFFY212SnFpSGY1?=
 =?utf-8?B?L0g5b0Z0M3AxSlhrT0FQMnU1MUJwM1B3ZTg4UDZuRDZLOThscHNSVCtyYzVs?=
 =?utf-8?B?Z0JmWlN1SFVUNjBNK1JTSlpDSjllcnVNWms0ZGNaVWhJbEZVc1NuQjU4YkR4?=
 =?utf-8?B?elZ1MW4yR2tCcjVyZXFWVzdudmg0WFNMZEhGSHVaQVZTNEZkTW5RMkg5Wm41?=
 =?utf-8?B?eEhrTHF5aWIvRmpYQldNckNLM0hFYnZORG80ZHRCMDBUSGNaeDlBc0RDOUtw?=
 =?utf-8?B?eDh0V1VKVU10WHR5L3dDYUZqaUk3ZkZkU05ubEU1M3VYYmFUS1JCRUx2ME9r?=
 =?utf-8?B?N3RYMDFLYkFQWmdsczU1NnpxSFhGWkE2clRack40V3hYbkFSaWM3aWN1c3Zt?=
 =?utf-8?B?UFdpRjVnTE5CQUh2VDFFNG1HSkE4aTBneTZoUi9KWERneWwyVTZZb1g0anp6?=
 =?utf-8?B?dWZuNXAwLzFsWjhnZGhSeWZSaEhkQmh6ZUpXWm1hQ0VWS1pBTStHNklIRFJZ?=
 =?utf-8?B?MlBROEM5cThGdTdVK0g1MlF0UVpBRHlVT1FLNmo0c0xzRVVMRUErMEM4emxQ?=
 =?utf-8?B?WXQrZnJVZE5xT3RBUEhkZW0wVFN5RzJHd1JLUkswWlVrT0llYW8zWEVaWEtJ?=
 =?utf-8?B?b0cvc3JFTEQ5Z2Q1Z0k5bU1SZWxwZXNocVZJaG5yaXZOWmtCbDhsTzVwNFdz?=
 =?utf-8?B?QllvTHlUcmZPd0k5ejN3SmtnSmdDbjgzS3BzSGJZVWV5RDN5OTlIeE4zbDg2?=
 =?utf-8?B?VTNWQkZsemFTa3E1RTFlN294TTZFR0VxbmJBQVVYM1lWMUhPUnNPV2VkTlhP?=
 =?utf-8?B?cE1iZ0VxVHpOSERwUlFpTEFxdGZzN3JPNDFOSEwzb1dXbXFlZEpzVzA3Ukt6?=
 =?utf-8?B?QVBtbm5TK0M5Y3c2OG84SWlUdkhnZUpNc1FwaVVEQVZBNVdKL05WZmV2Wnc1?=
 =?utf-8?B?Z0docFNiL3pQQzdXS28rUVF5ZjdHdTBDanhmelYyMmFYcXBUakVjNXpkM1Jx?=
 =?utf-8?B?bWtwRlAxcURTRlAzTC8wS3YwQU4zekV6VUYxb3Z2TEpodTZxcit3SlA1ZTZZ?=
 =?utf-8?B?MEg1R0tGOTRiZ0ZTcEVsUzBhS2xnSWVMaVEwYzdUSVdjLzdrcGlPaGJXa251?=
 =?utf-8?B?b2hGaVpQekNRUGc4bzc1UVVvbS9GVHlPU1hvVVhPb2hxSmExL3VXTkVwSTR3?=
 =?utf-8?Q?PknmYWvrVQQWk2J6sY79J7E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUJRSk90Tng4Ym1EQXAxbUdLeHBCWjdyenBsUUVHUUtCRVRQeEV5djNNQ0dZ?=
 =?utf-8?B?U1lvck9ITmcrSmJURUlnZE9IdUVva2VwOEs1U3pEVklpS1lpZW9hRWtLT2ZS?=
 =?utf-8?B?Mm13OVBodXdsNG5jREo5alhNSFVjNDFtbFVodUszYnBXQTNoaFRWTzJHekEx?=
 =?utf-8?B?R0xmcG9qK1BoL2YxUmpSbXNYL0FhQWhoSHd4RXRNSy80dGRmZEtvR25HNldL?=
 =?utf-8?B?c0hERTlaN3YrYXh6NFIrdVRQQ3pYUmpiZjg5WDc2V3FhY2h2V2kwSHVJOFFs?=
 =?utf-8?B?MkIxTVFadmovSTNCZXk0dFBFQU9pVm5tQXJRWFFUZVBZQ0k0TU0ySGpXTHBq?=
 =?utf-8?B?Q09xbXVjclo4YkdrblBHYm1VTCtLbDczanNJYlNYNWdCcU5kQk5pVTNPSmtw?=
 =?utf-8?B?eklTU1RvbUMzR2paSTZVcTdHd08zTk1YQnJnSlUyNEZyUWNaMjZZSUJGa0ZZ?=
 =?utf-8?B?YmdYbDI5VEd0N0FPbDBUK0JlSlZESWw1TnMzVHlmeW15cmVNVUVLWHRORm1Y?=
 =?utf-8?B?K0hzM00yKzJzUzJjTmV6VDVySy9KNG5WOXkreDhSREhkMDN2S1NVSmlEWkpS?=
 =?utf-8?B?QWRXNWpZWVFqWG01T0tRSVZTTmdQZ2trZWl0dlc2TE9WRFh6aU9lQWdnYnVu?=
 =?utf-8?B?bGw0ZVQvazI5MnZRWVkzZDF4ZkhmSE16WXpzNHVGVzJiT2JaOG9MazFCdklL?=
 =?utf-8?B?L2IyWGJldG9BeVU0Q0xXSGFuNkV1RHU0SEFHdjVPR2UxQWlzWVBEbWRIbDJj?=
 =?utf-8?B?ZGZSNWg1UjJSN0l3YWR4d0s3S1lQek5sZXdveUd4bEhKTFRKeHg4aFFDZjVW?=
 =?utf-8?B?REZMRWpyeHhOOCtmVTlwUkE2Qms1aG1hRzdSenJTMjBPV2pTSzVSeGUyRzNM?=
 =?utf-8?B?MlREc3BUaXFvdUsyWWxsaWswSVMveWVFWnNKSmtoMUVNZk5tdmhKQVlPOTU3?=
 =?utf-8?B?ZGh3bGdBOEZueU4vQUN3WWRkUEhoMTcxd09xZ1FuQ0lXVEVUZkQ5ZXZtaVZF?=
 =?utf-8?B?U2p4QWJrN1B6VFhTKy9tbCtMNEhES2U0ZTBRTWlVakdTT2Q0blY3b0VjSFJi?=
 =?utf-8?B?YnBxTWg0cFNBWXFibUlVKzJqcWlKdXRaVkJHRndjS2hGT3kvVlZ5eXRsMTk0?=
 =?utf-8?B?QnJBTmxKMUNPWFBPQzdTRE9sYmZkV3pONUhUVzdvSktUVFlFemM5OW1rNGVN?=
 =?utf-8?B?czMrZGtxbjBLZXBuYlVwdk1FNTh5ZTN1S29icDRpVjFzby9rVnpKbEkwU2NZ?=
 =?utf-8?B?bHorNVhHVFRYbDd1dU0vQVBpVkF3Q2FLOEduaERUWTkxbVN4V1J0N3JCeHZO?=
 =?utf-8?B?dGhSL0hzeXpiOUlhN3FobXlGbFl0bGRrUFY2YmZwWFV0aitadldiVm1ZVDRT?=
 =?utf-8?B?SjNyYXdvM2N5R0RSR045aC9abENnSmVvQXJxbHIzTS9FN05OYlprWWZDaDcv?=
 =?utf-8?B?TXBmSEhES2s4UXZHZ0IyZk42ckUxTXQra09kdFBIOHdHVTFFS3JXOWRPZlpD?=
 =?utf-8?B?Y2VVNzVNWmxUTVZ1NWdFaXJuSkhRMnJoTHFMSDFLSHhtL20waFZLeUFRSWU0?=
 =?utf-8?B?bGo3S29CYzkydGQ1NGYreUlqUFdNL3Z1S2p6YzZnaVR1UGl6ZmhwODBVUTJD?=
 =?utf-8?B?YXQ0Znk5OUZkTElqZnpWZWdoTVVVR0R1YXp4c2tWWlhHQUJwanY2R0F5UkRm?=
 =?utf-8?B?SjhkZzA3S3J1R2o5SEljQXVtcDF1VUV2ZXpHSEdYWk96a3FXVmYxbTV4R1VB?=
 =?utf-8?B?TCtldXI0cWJ4RHBjakV5UVFjU3NMMGhyTStaV1Z2c1hvYmNraGZkZzFnRHJs?=
 =?utf-8?B?c0pCUWcwdXBNYnR2Z0tuQVZKZ011WENPRWQ0MnZScm5EUVFtOFBUWmVnYkQ0?=
 =?utf-8?B?SHJIU0hlc1F5b3hoUld4YkJGZS9qYnBMUTNYTG05WXAya0dEY3pDOVE1cTFK?=
 =?utf-8?B?RzlEK2N5bm9Rd3I2MDRrVXRQb3JTblZ4UytFdXdqM25Ia1dWU2w3RE9lUVFh?=
 =?utf-8?B?cWpzVUlBNUFKamM0Q1N5OWRsekJqM3U5MERVTXNBZ1hiako4Ti85Mk81MGVM?=
 =?utf-8?B?S080aVQ4TW9WTlRTVXBGRzkrVVBaRGErSk9ZVHE0WXh0SE9SK1JibEtjZFBT?=
 =?utf-8?B?RWp0SkVkQ0tHYk9EaXFMOW1TdEQyQk9WaTY0YjR3WDVzUnlWb0JMekNkOWI5?=
 =?utf-8?B?eFFaeWRWYWxUck5hMXNRclE0Qzdqb3RZUVVuTzdENXZZSk5UcElUVUpSb21w?=
 =?utf-8?B?N2l2Sk4yUjVqbXA2Z3pQakFvcU1wa0FPSXhXRTdPWE9GT1U5SGMyVytXZHVK?=
 =?utf-8?B?YlhqcnNWb3NMdjU1VEVuVGZxR3ZFdVNleFdWUzRXVDREaUFvS0JaUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aec055-fb2c-4998-d15f-08de7416ff3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:38:45.2888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7FZ/rXYoP3LdKHPZEMH75A/c46miF6Z6qZ5uW35OFAh9er2nodW7adu6v4e0bQ3eSKg24YoYKgNXYLxZCAoY4X7FmdGpA0/gKhWdcx6wPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF9730E669F
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUFVMTCAwMi8xNl0gdGVzdHMvZnVuY3Rpb25h
bDogQWRkIFNESyB0ZXN0cyB3aXRoIExpbnV4IDUuMTUNCj4gDQo+IE9uIDIvMjQvMjYgMTA6MzMs
IEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDw6lkcmljLA0KPiA+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUFVMTCAwMi8xNl0gdGVzdHMvZnVuY3Rpb25hbDogQWRkIFNESyB0ZXN0cyB3aXRoIExpbnV4
DQo+ID4+IDUuMTUNCj4gPj4NCj4gPj4gT24gMi8yNC8yNiAwMzo1MywgSmFtaW4gTGluIHdyb3Rl
Og0KPiA+Pj4gKyBUcm95DQo+ID4+Pg0KPiA+Pj4gSGkgQ8OpZHJpYywNCj4gPj4+DQo+ID4+Pj4g
U3ViamVjdDogUmU6IFtQVUxMIDAyLzE2XSB0ZXN0cy9mdW5jdGlvbmFsOiBBZGQgU0RLIHRlc3Rz
IHdpdGgNCj4gPj4+PiBMaW51eA0KPiA+Pj4+IDUuMTUNCj4gPj4+Pg0KPiA+Pj4+IEhlbGxvLA0K
PiA+Pj4+DQo+ID4+Pj4gKyBKYW1pbiwNCj4gPj4+Pg0KPiA+Pj4+IE9uIDIvMTYvMjYgMTY6MDgs
IEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+Pj4+PiBPbiAyLzE2LzI2IDE1OjU5LCBEYW5p
ZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+Pj4+Pj4gT24gTW9uLCBGZWIgMTYsIDIwMjYgYXQg
MTE6MTc6MzhBTSArMDAwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gPj4+Pj4+PiBPbiBNb24s
IDE2IEZlYiAyMDI2IGF0IDExOjEzLCBQZXRlciBNYXlkZWxsDQo+ID4+Pj4+Pj4gPHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZz4NCj4gPj4+PiB3cm90ZToNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4g
T24gVGh1LCAxMiBGZWIgMjAyNiBhdCAyMTo0MiwgQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRo
YXQuY29tPg0KPiA+Pj4+IHdyb3RlOg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IEFkZCBmdW5j
dGlvbmFsIHRlc3RzIGZvciBBU1QyNTAwIGFuZCBBU1QyNjAwIG1hY2hpbmVzIHVzaW5nDQo+ID4+
Pj4+Pj4+PiB0aGUgT3BlbkJNQyBTREsgdjExLjAwIHdpdGggTGludXgga2VybmVsIDUuMTUuIFRo
ZXNlIHRlc3RzDQo+ID4+Pj4+Pj4+PiBjb21wbGVtZW50IHRoZSBleGlzdGluZyBTREsgdGVzdHMg
YW5kIHZlcmlmeSB0aGF0IFFFTVUNCj4gPj4+Pj4+Pj4+IGNvcnJlY3RseSBib290cyBvbGRlciBr
ZXJuZWwgdmVyc2lvbnMgb24gdGhlc2UgcGxhdGZvcm1zLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+
Pg0KPiA+Pj4+Pj4+Pj4gK8KgwqDCoCBBU1NFVF9TREtfVjExMDBfQVNUMjYwMF81MTUgPSBBc3Nl
dCgNCj4gPj4+Pj4+Pj4+ICsNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4NCj4gKydodHRwczovL2dpdGh1
Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3dubG9hZC92MTEuDQo+ID4+
Pj4+Pj4+PiArMDAvYXN0MjYwMC1kZWZhdWx0LTUxNS1vYm1jLnRhci5neicsDQo+ID4+Pj4+Pj4+
PiArDQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+DQo+ID4+DQo+ICsnZWNlMWE5MzQwOTUzNzg5Mjk3ODBm
MDNlN2QwOTJlNTYyZjRiMzNiMjg0MWI4MGFkN2MzZDEyYTg1NzQ0YzBmNg0KPiA+Pj4+Pj4+Pj4g
KycpDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFRoaXMgYXNzZXQgZmlsZSBpcyBvdmVyIGEgZ2ln
YWJ5dGUgaW4gc2l6ZSwgaXQgdGFrZXMgZm9yZXZlciB0bw0KPiA+Pj4+Pj4+PiBkb3dubG9hZCwg
YW5kIG91ciBmdW5jdGlvbmFsIHRlc3QgYXNzZXQgZG93bmxvYWQgZnJhbWV3b3JrIGhhcw0KPiA+
Pj4+Pj4+PiBubyBtZWNoYW5pc20gZm9yIGdpdmluZyBhbnkga2luZCBvZiBwcm9ncmVzcyBpbmRp
Y2F0aW9uIGZvcg0KPiA+Pj4+Pj4+PiBkb3dubG9hZHMgKG9yIGV2ZW4gZm9yIHRlbGxpbmcgeW91
IHRoZSBVUkwgaXQgaXMgZG93bmxvYWRpbmcNCj4gPj4+Pj4+Pj4gdW50aWwgYWZ0ZXIgdGhlIGRv
d25sb2FkIGlzIGNvbXBsZXRlKS4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gQ2FuIHdlIGhhdmUg
YSBzaXplIGxpbWl0IGZvciB0ZXN0IGFzc2V0cyBwbGVhc2UsIGF0IGxlYXN0IHVudGlsDQo+ID4+
Pj4+Pj4+IHRoZSBmcmFtZXdvcmsgY2FuIHN1cHBvcnQgbGFyZ2UgYXNzZXRzIGEgYml0IGJldHRl
ciA/DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBGb2xsb3d1cDogd2UgaGF2ZSBzaXggdGVzdCBhc3Nl
dHMgdGhhdCBhcmUgb3ZlciA1MDBNQiBpbiBzaXplLA0KPiA+Pj4+Pj4+IGFuZCB0aGV5IGFyZSBh
bGwgYXNwZWVkIHRlc3RzLiBQbGVhc2UgY2FuIHlvdSBoYXZlIGEgbG9vayBhdA0KPiA+Pj4+Pj4+
IHNsaW1taW5nIHRoZXNlIGRvd24/DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSBzZWUgMiBiaWcgYXNz
ZXRzIGZyb20gYXNwZWVkIG9ubHkNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAgIMKgwqAgNjRkODkyNmE3
ZDAxYjY0OTE2OGJlOTZjOTg2NjAzYjU2OTBmMDYzOTEyODZjNDM4YTNhNw0KPiA3MmMNCj4gPj4g
OGM3DQo+ID4+Pj4gMDM5ZTkzDQo+ID4+Pj4+PiAgIMKgwqAgZWNlMWE5MzQwOTUzNzg5Mjk3ODBm
MDNlN2QwOTJlNTYyZjRiMzNiMjg0MWI4MGFkN2MzZA0KPiAxMmENCj4gPj4gODU3DQo+ID4+Pj4g
NDRjMGY2DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IHdoYXQgYXJlIHRoZSBuYW1lcyBv
ZiB0aGUgb3RoZXIgZmlsZXMgaW4NCj4gPj4+Pj4+ICRIT01FLy5jYWNoZS9xZW11L2Rvd25sb2Fk
IHlvdSBoYXZlIHRoYXQgYXJlIG92ZXIgNTAwIE1CID8NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBXaXRo
IHJlZ2FyZHMsDQo+ID4+Pj4+PiBEYW5pZWwNCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlc2UgYXJlIHRo
ZSBmaWxlcyA6DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4NCj4gNTczMjI1NWQ0NjE3
ZDk4Yjc2YmJiYzExNmQzMzFkNmFjODk5MDZmYTIxMjk2OWViODIxM2ZkYzRhZWE4NjQ1MQ0KPiA+
Pj4+ICAgIDE2Nk0NCj4gPj4+Pj4gYXN0MjUwMC1kZWZhdWx0LTUxNS1vYm1jLnRhci5neg0KPiA+
Pj4+Pg0KPiA+Pj4+DQo+ID4+DQo+IDI3NjhlMjUyNmJkZDNmOTI4ZGYzMTM0MTgwMWNiNmRlM2I5
YTQwY2E5NDJiNTM4YTNkMDgwMGNkMjZmYmRiZmUNCj4gPj4+PiAgICAxNjZNDQo+ID4+Pj4+IGFz
dDI1MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+DQo+IGVjZTFh
OTM0MDk1Mzc4OTI5NzgwZjAzZTdkMDkyZTU2MmY0YjMzYjI4NDFiODBhZDdjM2QxMmE4NTc0NGMw
ZjYNCj4gPj4+PiAgICAxLjFHDQo+ID4+Pj4+IGFzdDI2MDAtZGVmYXVsdC01MTUtb2JtYy50YXIu
Z3oNCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pg0KPiA2NGQ4OTI2YTdkMDFiNjQ5MTY4YmU5NmM5ODY2
MDNiNTY5MGYwNjM5MTI4NmM0MzhhM2E3NzJjOGM3MDM5ZTkzDQo+ID4+Pj4gICDCoCAxLjJHDQo+
ID4+Pj4+IGFzdDI2MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+
DQo+IDRmODc3OGJlMTc2ZWNlMWI1N2QzM2M0YWVlMTNiYjk4OWJlMTE0YzNlNDcwMzE1MGVhZWI2
Zjk5NmJkNTU4N2YNCj4gPj4+PiAgICA1ODJNDQo+ID4+Pj4+IGFzdDI3MDAtYTEtZGNzY20tb2Jt
Yy50YXIuZ3oNCj4gPj4+Pj4NCj4gPj4+Pg0KPiBkNWNlZWQ1MTFjZDBkZmVmYmIxMDJmZmYyZDcz
MTE1OWUwNDcyOTQ4YTI4MDY2ZGMwZDkwYmNkNTRiZTc2NTI1DQo+ID4+Pj4gNTIwTQ0KPiA+Pj4+
PiBhc3QyNzAwLWExLW9ibWMudGFyLmd6DQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4NCj4gMGU5M2Y3
OTc2MTM5ZGE3MWZhYjlkZjc5NTJhNThiZGQ4MDY1MGUyM2U3YWJmNTg1M2IwZWI2Njk1ZGViMDJk
MA0KPiA+Pj4+ICAgIDU4MU0NCj4gPj4+Pj4gYXN0MjcwMC1kY3NjbS1vYm1jLnRhci5neg0KPiA+
Pj4+Pg0KPiA+Pj4+DQo+ID4+DQo+IGUyYjhmMDQzZmU4MDYzZGQzYjZkZWQ5MzQyMmUzOGJkNDE5
MTRkYzljMzIwMjE5OTUwNzY1MmRmMDI0ZGU0ZGMNCj4gPj4+PiAgICA1MTlNDQo+ID4+Pj4+IGFz
dDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIGltYWdlIHNpemUg
Zm9yIHYwOS4wOCB3YXMgYXJvdW5kIDI1MCBNQiBmb3IgdGhlIGFzdDI1MDAsDQo+ID4+Pj4gYXN0
MjYwMCBhbmQgYXN0MjcwMCBTb0NzLiBJdCB3b3VsZCBiZSBiZXN0IHRvIGtlZXAgaXQgbGlrZSB0
aGlzIGZvciB0ZXN0aW5nLg0KPiA+Pj4+DQo+ID4+Pj4gV291bGQgaXQgYmUgcG9zc2libGUgaW4g
djEyLjAwID8NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBUaGFuayB5b3UgZm9yIHlvdXIg
c3VnZ2VzdGlvbiBhbmQgZm9yIHJlcG9ydGluZyB0aGlzIGlzc3VlLg0KPiA+Pj4NCj4gPj4+IFRv
IGFsbG93IFFFTVUgdG8gYWNjZXB0IHRoZSBpbWFnZSB0YXJiYWxsIHNpemUsIEkgd2lsbCBjcmVh
dGUgbmV3DQo+ID4+PiB0YXJiYWxscw0KPiA+PiBzcGVjaWZpY2FsbHkgZm9yIFFFTVUgZnVuY3Rp
b25hbCB0ZXN0aW5nLg0KPiA+Pj4NCj4gPj4+IFRoZSAiYXN0MjYwMC1kZWZhdWx0LWltYWdlLnRh
ci5neiIgdGFyYmFsbCB3aWxsIGJlIGJhc2VkIG9uDQo+ID4+ICJhc3QyNjAwLWRlZmF1bHQtb2Jt
Yy50YXIuZ3oiLg0KPiA+Pj4gSXQgd2lsbCBjb250YWluIG9ubHkgdGhlIG5lY2Vzc2FyeSBpbWFn
ZXMgZnJvbQ0KPiA+Pj4gYXN0MjYwMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+ID4+IGZvciBRRU1V
IGZ1bmN0aW9uYWwgdGVzdGluZywgc3VjaCBhcyBpbWFnZS1ibWMuDQo+ID4+PiBJbmNsdWRpbmcg
b25seSBpbWFnZS1ibWMgaW4gdGhlIHRhcmJhbGwgd2lsbCBzaWduaWZpY2FudGx5IHJlZHVjZQ0K
PiA+Pj4gaXRzIHNpemUuIEluDQo+ID4+IFNESyB2MTEuMDEsIHRoZSBzaXplIHNob3VsZCBiZSBh
cm91bmQgNjRNQi4NCj4gPj4NCj4gPj4gSSB0aGluayB0aGUgaW5jcmVhc2UgaW4gc2l6ZSBjb21l
cyBtYWlubHkgZnJvbSB0aGUgcnNhKiBkaXJlY3Rvcmllcy4NCj4gPj4gUmVtb3ZpbmcgdGhlc2Ug
d291bGQgc2F2ZSAxRy4NCj4gPj4NCj4gPj4gQ2FuIHlvdSBrZWVwIHRoZSBzYW1lIHYwOS4wOCBj
b250ZW50cyA6IHUtYm9vdC5iaW4sIGtlcm5lbCwgZHRiLA0KPiA+PiByb290ZnMgZXRjID8gSXQg
aXMgZ29vZCB0byBoYXZlIHRoZSBkaWZmZXJlbnQgT3BlbkJNQyBmaWxlcyBmb3IgdGVzdHMgdG9v
Lg0KPiA+Pg0KPiA+IE9rYXkuDQo+ID4+DQo+ID4+PiBJIHBsYW4gdG8gY3JlYXRlIHRoZSBmb2xs
b3dpbmcgbmV3IHRhcmJhbGxzIGZvciBRRU1VIGZ1bmN0aW9uYWwgdGVzdGluZzoNCj4gPj4+IDEu
IGFzdDI2MDAtZGVmYXVsdC1pbWFnZS50YXIuZ3oNCj4gPj4+IDIuIGFzdDI2MDAtZGVmYXVsdC02
Ni1pbWFnZS50YXIuZ3oNCj4gPj4+IDMuIGFzdDI3MDAtZGVmYXVsdC1pbWFnZS50YXIuZ3oNCj4g
Pj4+IDQsIGFzdDI3MDAtYTEtaW1hZ2UudGFyLmd6DQo+ID4+PiA1LiBhc3QyNzAwLWRjc2NtLWlt
YWdlLnRhci5neg0KPiA+Pj4gNi4gYXN0MjcwMC1hMS1kY3NjbS1pbWFnZS50YXIuZ3oNCj4gPj4g
b2suIE5vIG5lZWQgdG8gY2hhbmdlIHRoZSBBU1QyNTAwIHRhcmJhbGxzLg0KPiA+Pg0KPiA+IERv
IHdlIG5lZWQgdG8gZ2VuZXJhdGUgYXN0MjcwMC1kY3NjbS1pbWFnZS50YXIuZ3ogYW5kDQo+IGFz
dDI3MDAtYTEtZGNzY20taW1hZ2UudGFyLmd6Pw0KPiANCj4gVGhleSBzbGlnaHRseSBleGNlZWQg
dGhlIDUxMiBNQiBsaW1pdCB0aGF0IFFFTVUgd2FzIHBsYW5uaW5nIHRvIGVuZm9yY2UuDQo+IA0K
PiAgICA1ODEuNiBNaUIgWyMjIyMjIyMgICAgICAgICAgICBdICBhc3QyNzAwLWExLWRjc2NtLW9i
bWMudGFyLmd6DQo+ICAgIDU4MC4zIE1pQiBbIyMjIyMjIyAgICAgICAgICAgIF0gIGFzdDI3MDAt
ZGNzY20tb2JtYy50YXIuZ3oNCj4gICAgNTE5LjMgTWlCIFsjIyMjIyMgICAgICAgICAgICAgXSAg
YXN0MjcwMC1hMS1vYm1jLnRhci5neg0KPiAgICA1MTguNCBNaUIgWyMjIyMjIyAgICAgICAgICAg
ICBdICBhc3QyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gDQo+IEkgc3VwcG9zZSB0aGlzIGlz
IHN1ZmZpY2llbnQgZm9yIHRoZSB0aW1lIGJlaW5nLiBJZiB5b3UgZmluZCB3YXlzIHRvIHJlZHVj
ZSB0aGVpcg0KPiBzaXplLCB0aGF0IHdvdWxkIGJlIHdlbGNvbWUuDQo+IA0KPiANCj4gQ29taW5n
IGJhY2sgdG8geW91ciBwcm9wb3NhbCwgYSBsb25nZXItdGVybSBzb2x1dGlvbiB3b3VsZCBiZSBp
bmRlZWQgdG8NCj4gcHJvdmlkZSBhIG5ldyBzZXQgb2YgYXJ0aWZhY3RzLCBvbmUgZm9yIGVhY2gg
UUVNVSBtYWNoaW5lLCBjb250YWluaW5nIG9ubHkNCj4gd2hhdCBpcyByZXF1aXJlZCB0byBydW4g
dGhlIGZ1bmN0aW9uYWwgdGVzdHMgOg0KPiANCj4gICAgIDx2ZXJzaW9uPi88UUVNVSBtYWNoaW5l
IG5hbWU+LXFlbXUudGFyLmd6DQo+IA0KPiBXaGF0IHdvdWxkIGJlIGVhc2llciBmb3IgeW91IDog
Y2hhbmdlIHRoZSBleGlzdGluZyB0YXJiYWxscyBvciBhZGQgbmV3IG9uZXMNCj4gZm9yIFFFTVUg
Pw0KPiANCg0KSSBwbGFuIHRvIGNyZWF0ZSBhIG5ldyBzZXQgb2YgYXJ0aWZhY3RzIGZvciBlYWNo
IFFFTVUgbWFjaGluZS4NClRoZSBvcmlnaW5hbCBwYWNrYWdlcyB3aWxsIHJlbWFpbiBhdmFpbGFi
bGUgb24gdGhlIEFTUEVFRCBTREsgcmVsZWFzZSBwYWdlLCBhcyB0aGV5IHNob3VsZCBub3QgYmUg
bW9kaWZpZWQuDQpUaGVzZSBwYWNrYWdlcyBhcmUgdXNlZCBieSBjdXN0b21lcnMgYXMgd2VsbCBh
cyBmb3IgQVNQRUVEIGludGVybmFsIHRlc3RpbmcuDQoNCklmIHVzZXJzIG5lZWQgdG8gdGVzdCBz
cGVjaWZpYyBpbWFnZXMgc3VjaCBhcyBST0ZTLCBVLUJvb3QsIHRoZSBrZXJuZWwsIG9yIHBlcmZv
cm0gZnVsbCBPcGVuQk1DIGZpcm13YXJlIHVwZGF0ZXMsIA0KdGhleSBjYW4gZG93bmxvYWQgdGhl
IGRlZmF1bHQgcGFja2FnZSAoZm9yIGV4YW1wbGUsIGFzdDI2MDAtZGVmYXVsdC1vYm1jLnRhci5n
eikgZm9yIGNvbXBsZXRlIHRlc3RpbmcuIA0KVGhlIGFzdDI2MDAtZGVmYXVsdC1pbWFnZS50YXIu
Z3ogcGFja2FnZSB3aWxsIGluY2x1ZGUgb25seSBpbWFnZS1ibWMgZm9yIFFFTVUgZnVuY3Rpb25h
bCB0ZXN0aW5nIGFuZCB3aWxsIHN1cHBvcnQgcHJvZ3JhbW1pbmcgdGhlIGVudGlyZSBGTUMgZmxh
c2guDQoNClRoZSBjb250ZW50cyBvZiB0aGUgbmV3IHRhcmJhbGxzIHdpbGwgYmUgYXMgZm9sbG93
czoNCg0KMS4gYXN0MjYwMC1kZWZhdWx0LWltYWdlLnRhci5neg0KICBpbWFnZS1ibWMNCg0KMi4g
YXN0MjYwMC1kZWZhdWx0LTY2LWltYWdlLnRhci5neg0KICBpbWFnZS1ibWMNCg0KMy4gYXN0Mjcw
MC1kZWZhdWx0LWltYWdlLnRhci5neg0KICBpbWFnZS1ibWMNCiAgdS1ib290LmJpbg0KICB6ZXBo
eXItYXNwZWVkLXNzcC5lbGYNCiAgemVwaHlyLWFzcGVlZC10c3AuZWxmDQogIGJsMzEuYmluDQog
IG9wdGVlL3RlZS1yYXcuYmluDQoNCjQsIGFzdDI3MDAtYTEtaW1hZ2UudGFyLmd6DQogIGltYWdl
LWJtYw0KICB1LWJvb3QuYmluDQogIHplcGh5ci1hc3BlZWQtc3NwLmVsZg0KICB6ZXBoeXItYXNw
ZWVkLXRzcC5lbGYNCiAgYmwzMS5iaW4NCiAgb3B0ZWUvdGVlLXJhdy5iaW4NCg0KNS4gYXN0Mjcw
MC1kY3NjbS1pbWFnZS50YXIuZ3oNCiAgaW1hZ2UtYm1jDQogIHUtYm9vdC5iaW4NCiAgemVwaHly
LWFzcGVlZC1zc3AuZWxmDQogIHplcGh5ci1hc3BlZWQtdHNwLmVsZg0KICBibDMxLmJpbg0KICBv
cHRlZS90ZWUtcmF3LmJpbg0KDQo2LiBhc3QyNzAwLWExLWRjc2NtLWltYWdlLnRhci5neiANCiAg
aW1hZ2UtYm1jDQogIHUtYm9vdC5iaW4NCiAgemVwaHlyLWFzcGVlZC1zc3AuZWxmDQogIHplcGh5
ci1hc3BlZWQtdHNwLmVsZg0KICBibDMxLmJpbg0KICBvcHRlZS90ZWUtcmF3LmJpbg0KDQpQbGVh
c2UgbGV0IG1lIGtub3cgaWYgdGhpcyBhcHByb2FjaCB3b3JrcyBmb3IgeW91Lg0KDQpUaGFua3Ms
DQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gVGhlc2UgcGFj
a2FnZXMgZG8gbm90IGluY2x1ZGUgc2lnbmVkIGltYWdlcyBpbiB2MTEuMDAgKGUuZy4sIHRoZSBl
Y2RzYTM4NA0KPiBhbmQgZWNkc2EzODQtbG1zIGRpcmVjdG9yaWVzKS4NCj4gPiBGdXJ0aGVybW9y
ZSwgdGhlIGNvbnRlbnRzIG9mIGFzdDI3MDAtZGNzY20tb2JtYy50YXIuZ3ogYXJlIGlkZW50aWNh
bA0KPiBiZXR3ZWVuIHZlcnNpb25zIHYwOS4wOCBhbmQgdjExLjAwLg0KPiA+DQo+ID4gVGhhbmtz
LA0KPiA+IEphbWluDQo+ID4NCj4gPj4+IEFTUEVFRCB3aWxsIHJlbGVhc2UgdjExLjAxIHRoaXMg
d2Vlay4gQWZ0ZXIgdGhlIHYxMS4wMSByZWxlYXNlLCBJDQo+ID4+PiB3aWxsIHVwZGF0ZQ0KPiA+
PiB0aGVzZSB0YXJiYWxscyBhbmQgdGhlIFFFTVUgZnVuY3Rpb25hbCB0ZXN0cyBhY2NvcmRpbmds
eS4NCj4gPj4NCj4gPj4gR3JlYXQgIQ0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEMu
DQo+ID4NCg0K

