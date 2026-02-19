Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B327AC531E1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 22:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtCCi-00032l-9C; Thu, 19 Feb 2026 17:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vtCCe-00031L-7B; Thu, 19 Feb 2026 17:08:56 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vtCCb-0004RX-I2; Thu, 19 Feb 2026 17:08:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB2/Iyi03n1kNaZXQMahyI8hWEwtu1uh3ujsoBCmWCHWkgxW35mjfXvdKN4jHIbVeibcIhTqspYZAn4maT1+fqT/bzQSqXwtXPQs1nUpAtZGB6VYtL/RswoTIbINH1Jr6jKXTNiG5vEdjnuQIv6sSWjoPsOlUW0PVy+AKrdWoU2rcAH0NuFDpig5yIP+Zb73Mi5Z99YSeK0uW5deQpNwlsUdLqOGe8PZ9h7VytY53OHh07VQpfSWGJ+HRDypsTM03b7Bju83XXVMiM1xwHpOYHcQolVYtk/pOMuQxceQENlwdRpNQmAbW3w2BepJyikcQfS0kBM7kpsz9pguh3WBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yisBPvvGkI0b8uq9HUCB+DEHvJBw2A4bgKPdSqXSbH4=;
 b=ulGeq1qqwPgCIEyx+Nvx2/jPp9xb9WL/dOrbJgsOkbTB4yfBkv5pisqvkdwHNHknIsrdTXPYxfHFqzezN7mR/oZzYuu93UPCn0pkl5ZwTrzER/LwpoYbukLUOnPl5NigRR7UmMs5dJBJYED06UiV0UkJD3bDyiQl4bJYEHkzpsfPWBtSNTA4u/lBGe4gLFSagVrKUJPQaTa8ZhFiAJo4xTgcLHR/1fAaK+OlfeVUsVyp2q7Ra/J3rDbKZ1tvHLMUJ1wBtI8VIk/Weu8Y2yPuFhB0KLRWa08MKmTs1+MOyh8VOq+PsRSN/ntocabuOjW2ps3eYSr3AoEVYxANLinMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yisBPvvGkI0b8uq9HUCB+DEHvJBw2A4bgKPdSqXSbH4=;
 b=K04CEG9Rf5IG6q/Qta1DtcXr/N+VhNnfQvKZInPGivPjbY0SnykHNzWRrM2mpW4dA2h6vLw31K+bjfQkJhZEEl5DqCf3xRUgbMHIn+w8K/V1afsPXIiaKJd/RbG2ljTqMhm0Esfgym7rPky2j03ciRdFOB2BUTRjDcPVPzJFUdlDfXeU2TvgOYIoN0sqYRJLgBzxUY/XvJugpUw4VDHRPlY+LkbNR8JCzNrUzhrvOxptLXgpH3HCVjKM4SEANnex75PbdPCyCM3yaVS/RrzOmK7xPOWBhHtQRWwqYaxfe5haIUmHGauRVNwayFVKZ1sTs4J5ULCAvFp47LOSp65+/g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6599.apcprd06.prod.outlook.com (2603:1096:101:17e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 22:08:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 22:08:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?gb2312?B?Q6imZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?gb2312?B?RGFuaWVsIFAuIEJlcnJhbmeopg==?= <berrange@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
CC: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kane
 Chen <kane_chen@aspeedtech.com>
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Topic: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Index: AQHcn/bXw5yLp/LOskOx+2qAxSW0vLWKl17E
Date: Thu, 19 Feb 2026 22:08:43 +0000
Message-ID: <TYPPR06MB820602C7A633D644D46CCC0FFC6BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
 <aZMwvfw4O5xeH-Gm@redhat.com>
 <98898cd4-de19-41b7-b519-541c48b462ea@redhat.com>
 <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
In-Reply-To: <7b68fe15-f8fb-4d72-9559-8b6b89bd7563@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6599:EE_
x-ms-office365-filtering-correlation-id: d35b67ce-df6e-4bf9-5f42-08de7003725d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?gb2312?B?YjNKaEU3S2Ztd2VaTVVjOEVtcTVFZlhpV3VuZjlRVkdsampKNjhROEloWU9i?=
 =?gb2312?B?N1JIbTA1TnZnR2tVWUMzSjBYWDJFSlBaSjEyTXdwTlpXL0M3cmJKOFByUDZs?=
 =?gb2312?B?L3YvZm5BOE1wdGdaNjhLT3NOSHhQYXd5ZWtqNkR6RStyU2VQY2hCZ0w0V3lZ?=
 =?gb2312?B?TGV3Unl1cHJCM2U5TVhPbDhuN0JvaFU2aS9ML294bEZoOFkxaE9WQVZ0VzRu?=
 =?gb2312?B?a3BmRHAyRExrZVIzSmZEVHJtdGxXUmRvY29vQjN3ODcvS0FObEVQSEh4V0lZ?=
 =?gb2312?B?b004NWcvcXEyM3JDb2MwVVZLNHdrQTJWbEVMbEdnUmt0VlhHTzNmMWNCdUth?=
 =?gb2312?B?S1gzSFIzVkNXY3VtV01meHpoWkcvcU1jYURTR3A0NmZQZVA1Z2QyRkVxY1Vy?=
 =?gb2312?B?bFNWREZqbUUybzhZNEdwTmN2VzRiT2VNYzBXOC8vK3ZtTzBzVXZhSzY5S0xy?=
 =?gb2312?B?YmRqRkZCcE8wbU96eWl6SmJuYTdiUVpKWjRLMk5lQ2JXOTdvWjRHSkdsay9u?=
 =?gb2312?B?NGFoRGQzTFF2TklIU24wcFR6NlIzQ1B2bVo4cUl6amNuZStOYWZhU281UnVy?=
 =?gb2312?B?RFFqUlJPdlh0eGdJbHJPWHI5T3dMLzBkeU0yU09SaXYwODJmenNsRmgrTjhz?=
 =?gb2312?B?MjdOQjBKdmlkR01xUm5RelFlWGc3NzVoblVkWXh0aS94Skl0VUEyMWVCUERK?=
 =?gb2312?B?QTE3VE1Jb2pGUW9yR2taVGZuR0xnUGJRNG5QKzhvNjhSajdkVWRzS3JZeFZv?=
 =?gb2312?B?VkVMd2p3V2R1cXJvdlpNNzdld1dMMFJRV2ZEcWxJcDZYVHlCbjlmUWgzREts?=
 =?gb2312?B?T2J1WHZkUU1sUUF3dlQ5ZlUrdDF0a1o5ZENlcEVmSXhocXREdWhHTUx5bW1F?=
 =?gb2312?B?YVEvaVY4L05Xb20zbDlIVnM5TUc0UmowdTdUUnJETXhWeTJXYnNsTll5eHFY?=
 =?gb2312?B?TEN5VFRzZnlUUlArMTFoTldiTTVNN25ZemxwZXo1ak93c09BcGhKeDM2bWhV?=
 =?gb2312?B?Mm1BMVN0VWxzaXhOYVVOdHo3QUoyVmhWR1gxUlBNd0RlM25hM1JaUklzQUt1?=
 =?gb2312?B?MXRxQS9XYXhJQ0hCc1o0Nlg0OUxQRDA4b01OTGtsc1Q0OHlqNnhicllMS1JP?=
 =?gb2312?B?cWpDZXgxcmVXdzB4Si9KRHFOc201dkNYTndxUHNoSzN3bjR6cmR3ZTlXb0l5?=
 =?gb2312?B?TU01Z2FHNlo4N1QwTGgvdnkzRDJaeG1ZWmJpYjAxeW94eFF0eDNkSGhpQUNy?=
 =?gb2312?B?b2wwTXJPdXR5UnhvM0p4bkRRM1VTVDRHc2VtaE1TblA5dFhyU2dGU1A1STZL?=
 =?gb2312?B?djI5Q2Vhb1ZPcmE3YTkxRU0vU1dDOFZkbXRCR25yNjBsdUdwbTFCTmV0MEQy?=
 =?gb2312?B?VE44K2ZEQ01MQ2FDeGIvUFM0Qkphc1djTjNBTzljV2lBQzhjc1JBK1hYNFBI?=
 =?gb2312?B?Qjh2RzFBa2JxTHpHQ28zSUV5S1ozWldReUQ2VDRVczZwdzExOGg4Q2FRQ3N2?=
 =?gb2312?B?OFZTZjdWOHdRZTFpR0tHUDJLOFRyOU1LeTVwbmRYRHdzZDI5b0NTYUNGU0Rm?=
 =?gb2312?B?Mk9DSU1DZkVYWFZodVNQUkhxemt6Mlc5Rk9xVUNHaHZXQ3UxbzBrckF1a3p2?=
 =?gb2312?B?WjEvb0V2T1o2d1RsMFl6UDh1elNpbU0xVnlYWSt1N3B2U3dNRUpoT3VMc29v?=
 =?gb2312?B?QVlyNDVDRksxVWl4RVpraXlmTjVyK3JQc1RXYkhZU1MwNW5yM2VVcEtUN1lq?=
 =?gb2312?B?UDEvWUh1WnhnMmU2enRQeGdmOW43Y0cySm0xVk43ekdVZG16US83ZDc2UEFF?=
 =?gb2312?B?M0hWbzY3UnkyL24yT3JiU1lqRVdFdzRZMzl3S0NFR1Mya1hMZEZjazdUTDdM?=
 =?gb2312?B?ZVVsWU5DakxmSlN3dnZySE9qSkJMM2VOSjFHQ2dSTUxPaCtneTFNMVdpSldM?=
 =?gb2312?B?Y0xoT1J1QmZMWE83TndXNGFsYlF4SXo1TDB5RGh3TlpuN0lGbk1OL1pycERr?=
 =?gb2312?B?MEhyOWRtaDdzdUw2QURUZjVMaG5EOFd6MnZRMVFwVmlzRlVFTyszcXRha2Zm?=
 =?gb2312?B?Z25ZNG5oazRtSHBkN05QMGFYeGRES1lRTXdIaXkzbVdOc3kwaTltbTNjcDVl?=
 =?gb2312?Q?3kOo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z0lZRE1SaVN0enM2dWZuY2ppQjk1dlZPd3lNb3FGY09FekRCaCsvcmZMMWFp?=
 =?gb2312?B?cWVwOWVXTlFnUTJZWGtJc2VEQUpqcm9WOVJ1MG9Sc1Z5Nm5nL3pBdlNEaG54?=
 =?gb2312?B?Sjg1V2l0VHFQUzNMYWIvbmtYVnltQjd6bHVheUgwSEI1R3J2SXFWS0d1YjF3?=
 =?gb2312?B?Tjd1dXJYRlVqQXJoZ09iQ1FzeVhUNjVNYm4wV2dVNDA2K3JORTZUWWhXalFo?=
 =?gb2312?B?QlpnTVh0clplaC93b001cUNiNFBOMnM3TzlwV2QySGJoV05ZZkluRm10NVpG?=
 =?gb2312?B?WTJ2eGVMeDUrNHBCWkx6TnQvekoyYU5CVDRuZTBCYmE1ZXVTKzdxRDEwZmJU?=
 =?gb2312?B?V3JrMEkwTE9OTUVRQ2c4ZzV6U1hRTmlhMDA3NDUweTl0bS92bjNhU0hlNXFs?=
 =?gb2312?B?bTdkeG1nMXN2ME1FUXJxNHhESUVkODRQUlBJYUNDa2FmNHg2bWNYY3lVQXEr?=
 =?gb2312?B?VFpDWFdPZFBXK1UvRG5VeVVFZklpUkNER1hPLzdtajlwVW9WTkN2ZEdlN2dq?=
 =?gb2312?B?L05uRSsyZm5nTDBjc0pEV2pNeGlMM3lzbkh2eVhKdmpxSExOUWNJaWMwNWNB?=
 =?gb2312?B?WnU2bGpmeFR4bGh6aGtXWGR3cytPMFNuVGJWQVhxZW1ndkhJTU9mYnVNemlo?=
 =?gb2312?B?VUpKcGtoS29Wc0grWHhhZDc0elNScjlJVVhYVWVMODA4bkFaL0hrZWtSYWxw?=
 =?gb2312?B?Rm1VMjU2SGppbVRxNWRybUxWdXV6Yzg0SjlGL1JpTGhMNGN0L3hDSy9JSFBx?=
 =?gb2312?B?NFFMT2IyNUdhSzVxa1F5R2xhWk9BS2hXNVl6eXliQUE1NzR3MGpFMzZCUUJL?=
 =?gb2312?B?cytLemJJa1Z0NnlxT1JEczh1R0ZYd25WRG5GZlR0TXhGdzJ5dXNLS0hmZnNo?=
 =?gb2312?B?ZENwSmhxcHAyMVFQcWZFaXU0MkZvdlFuQXd6cEp3QkQvNldBOVM5SjRnTUI2?=
 =?gb2312?B?OFVMUDlKL0llaWdqZmdwS1JjeHg2TkgrQzhzWGh3UnRBTDRVL2txOUhUcWhn?=
 =?gb2312?B?RVBNdXAxVTFBakhTcGEvZUIxdnp5RmRieDlqanY4bUZyNitKY0Z5RjFzMkNs?=
 =?gb2312?B?SDUxL1U1b3c3WFVscUh0R09GTjdmNThxR3RFYXdEemhoaWlrckI1MlowN0tB?=
 =?gb2312?B?OHU0cmN0bGxiSUtmK2dabXh2RTV5Ni95VW92L0V2RVZUdi8zRzdpN1c1ZmU2?=
 =?gb2312?B?R0tDa0NOZjZKcDBEZlFQOE5VOGEycCtkcVVSV0g1KzgydGJ0TXROaHdkOVEx?=
 =?gb2312?B?SzV0SC9YM1NZM1YvYmZDVUkwZ29xOStwRW9IblN6cm5VK29vYVJNWFc4V3ov?=
 =?gb2312?B?a3BXV1hlQ2ZqVDQ2TVFKRDd0NE4zUmhDRzgzRXpvM2F5YVJNWTVHMkRiekZS?=
 =?gb2312?B?OTljRG45aWdvU2ZjMlBYY1NUNU9SY3BNV2h4czIrZXhhRDVCbjJ0TzM1Z0Iv?=
 =?gb2312?B?YmVEeEdEaHA3OWQrdS91Z1F5cExWUklIaGNneVZ0cEJrV2V4WmZoYTk5Y1FM?=
 =?gb2312?B?OC9VVUlXWGpnMnNPRExTZm5rSjdNbm9Hbk1PZEh5WENuVVVjaS9GTkUyMGVY?=
 =?gb2312?B?TDFzbXJIeW93eEVXV0RqbzdVNDRhcmd2YUcxZm9vMHM5ZXU3T1dVUDN3M1RT?=
 =?gb2312?B?VGY3RTZ4a2FiSGp3bUh3Z2FpazRHTW10N20wdlJKblNFYjhjbGdEeVJ1clNl?=
 =?gb2312?B?ekI5TUZPa2cwVVNNYzZNTml0c1JzZnpPM01NeG1qNHAyRDdXc3Rkc0FUcHBk?=
 =?gb2312?B?STZXY240WE8xSW5JTXloNW9ZM0x6aEdOeWRIOWNxakk3eFdITzBRS1ZBamNW?=
 =?gb2312?B?emNOUjlaZGdvWHBHWDdSOFNiSTVEMEFOQXJQR0FScWZ3UTNHSFhiNStWbWNh?=
 =?gb2312?B?SEVPdUtlL1RrSXp6UTV3MkZKNG8zODZpU1dnT1QzZ2t5RFVxdlVHRmRrNjZZ?=
 =?gb2312?B?dGljQUlaZDNETjRRTGZTdW15WndYOHBRNlVyOWR3V3dFMG9vbVo1ZkFhTU8y?=
 =?gb2312?B?M1JNZmN4enlaSzRVamwwSjdrcGhPMUwvcGtpTmJrQ2lKdEVzTFlZL0ZrdDE5?=
 =?gb2312?B?cU9mS1BOeDMvejdwOXpoc0swVHJUaE1ZU0lpQkV5QUExVVdtU1Z5dHV1T0Vj?=
 =?gb2312?B?NS80bElDWkJtblNvQmVIcnU1Q0I2UFQ2WVRFSlY5SHZ0RUFzcnFoTG1NTWRF?=
 =?gb2312?B?cSt0c3ByZ05kWnBHRW9FS0xxZEZKSjEyTVRxblVLSHJ6RjlXYlE2Z1BmbkpO?=
 =?gb2312?B?dmxJb1cyckRUT0c2b2dNa3BLK2NWV0VxTmdITlVNQnZZYVlzNmd2U2NmVUhF?=
 =?gb2312?B?U2txRjFER2pwelRVRXRtWVVCL3hUdTRsWWp1QUJwTVFhSkswcFo1MThqUEFT?=
 =?gb2312?Q?+qn/EYrXmBaP53Bk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_TYPPR06MB820602C7A633D644D46CCC0FFC6BATYPPR06MB8206apcp_"
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35b67ce-df6e-4bf9-5f42-08de7003725d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 22:08:43.9057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDMkz4ar8GDp4wwYC5VMopj5XcVMJ0MwhjicTIQdNm/4FnULyU0K9GAiYpIkcY8oBpJo1b7hstyStwe21HnM4jXn167hKklzHZx34WgPii8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6599
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_PASS=-0.001,
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

--_000_TYPPR06MB820602C7A633D644D46CCC0FFC6BATYPPR06MB8206apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgQ2VkcmljLA0KDQpEdWUgdG8gbXkgdmFjYXRpb24sIEkgd2lsbCBiZSBiYWNrIGluIHRoZSBv
ZmZpY2UgbmV4dCB3ZWVrLiBJIHdpbGwgdXBkYXRlIHlvdSB0aGVuLg0KDQpUaGFua3MsDQpKYW1p
bg0KDQrIobXDIEFuZHJvaWQgsOYgT3V0bG9vazxodHRwczovL2FrYS5tcy9BQWI5eXNnPg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IEOopmRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4NClNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDE3LCAyMDI2IDY6MTk6MDQg
UE0NClRvOiBEYW5pZWwgUC4gQmVycmFuZ6imIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KQ2M6IFRob21hcyBIdXRoIDx0aHV0
aEByZWRoYXQuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgS2FuZSBDaGVu
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4NClN1YmplY3Q6IFJlOiBbUFVMTCAwMi8xNl0gdGVzdHMvZnVuY3Rpb25hbDogQWRk
IFNESyB0ZXN0cyB3aXRoIExpbnV4IDUuMTUNCg0KSGVsbG8sDQoNCisgSmFtaW4sDQoNCk9uIDIv
MTYvMjYgMTY6MDgsIEOopmRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiBPbiAyLzE2LzI2IDE1OjU5
LCBEYW5pZWwgUC4gQmVycmFuZ6imIHdyb3RlOg0KPj4gT24gTW9uLCBGZWIgMTYsIDIwMjYgYXQg
MTE6MTc6MzhBTSArMDAwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4+PiBPbiBNb24sIDE2IEZl
YiAyMDI2IGF0IDExOjEzLCBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
IHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiBUaHUsIDEyIEZlYiAyMDI2IGF0IDIxOjQyLCBDqKZkcmlj
IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IEFkZCBmdW5j
dGlvbmFsIHRlc3RzIGZvciBBU1QyNTAwIGFuZCBBU1QyNjAwIG1hY2hpbmVzIHVzaW5nIHRoZQ0K
Pj4+Pj4gT3BlbkJNQyBTREsgdjExLjAwIHdpdGggTGludXgga2VybmVsIDUuMTUuIFRoZXNlIHRl
c3RzIGNvbXBsZW1lbnQgdGhlDQo+Pj4+PiBleGlzdGluZyBTREsgdGVzdHMgYW5kIHZlcmlmeSB0
aGF0IFFFTVUgY29ycmVjdGx5IGJvb3RzIG9sZGVyIGtlcm5lbA0KPj4+Pj4gdmVyc2lvbnMgb24g
dGhlc2UgcGxhdGZvcm1zLg0KPj4+Pg0KPj4+Pg0KPj4+Pj4gKyAgICBBU1NFVF9TREtfVjExMDBf
QVNUMjYwMF81MTUgPSBBc3NldCgNCj4+Pj4+ICsgICAgICAgICdodHRwczovL2dpdGh1Yi5jb20v
QXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3dubG9hZC92MTEuMDAvYXN0MjYwMC1k
ZWZhdWx0LTUxNS1vYm1jLnRhci5neicsDQo+Pj4+PiArICAgICAgICAnZWNlMWE5MzQwOTUzNzg5
Mjk3ODBmMDNlN2QwOTJlNTYyZjRiMzNiMjg0MWI4MGFkN2MzZDEyYTg1NzQ0YzBmNicpDQo+Pj4+
DQo+Pj4+IFRoaXMgYXNzZXQgZmlsZSBpcyBvdmVyIGEgZ2lnYWJ5dGUgaW4gc2l6ZSwgaXQgdGFr
ZXMgZm9yZXZlciB0bw0KPj4+PiBkb3dubG9hZCwgYW5kIG91ciBmdW5jdGlvbmFsIHRlc3QgYXNz
ZXQgZG93bmxvYWQgZnJhbWV3b3JrIGhhcw0KPj4+PiBubyBtZWNoYW5pc20gZm9yIGdpdmluZyBh
bnkga2luZCBvZiBwcm9ncmVzcyBpbmRpY2F0aW9uIGZvcg0KPj4+PiBkb3dubG9hZHMgKG9yIGV2
ZW4gZm9yIHRlbGxpbmcgeW91IHRoZSBVUkwgaXQgaXMgZG93bmxvYWRpbmcNCj4+Pj4gdW50aWwg
YWZ0ZXIgdGhlIGRvd25sb2FkIGlzIGNvbXBsZXRlKS4NCj4+Pj4NCj4+Pj4gQ2FuIHdlIGhhdmUg
YSBzaXplIGxpbWl0IGZvciB0ZXN0IGFzc2V0cyBwbGVhc2UsIGF0IGxlYXN0IHVudGlsDQo+Pj4+
IHRoZSBmcmFtZXdvcmsgY2FuIHN1cHBvcnQgbGFyZ2UgYXNzZXRzIGEgYml0IGJldHRlciA/DQo+
Pj4NCj4+PiBGb2xsb3d1cDogd2UgaGF2ZSBzaXggdGVzdCBhc3NldHMgdGhhdCBhcmUgb3ZlciA1
MDBNQiBpbiBzaXplLA0KPj4+IGFuZCB0aGV5IGFyZSBhbGwgYXNwZWVkIHRlc3RzLiBQbGVhc2Ug
Y2FuIHlvdSBoYXZlIGEgbG9vayBhdA0KPj4+IHNsaW1taW5nIHRoZXNlIGRvd24/DQo+Pg0KPj4g
SSBzZWUgMiBiaWcgYXNzZXRzIGZyb20gYXNwZWVkIG9ubHkNCj4+DQo+PiAgICA2NGQ4OTI2YTdk
MDFiNjQ5MTY4YmU5NmM5ODY2MDNiNTY5MGYwNjM5MTI4NmM0MzhhM2E3NzJjOGM3MDM5ZTkzDQo+
PiAgICBlY2UxYTkzNDA5NTM3ODkyOTc4MGYwM2U3ZDA5MmU1NjJmNGIzM2IyODQxYjgwYWQ3YzNk
MTJhODU3NDRjMGY2DQo+Pg0KPj4NCj4+IHdoYXQgYXJlIHRoZSBuYW1lcyBvZiB0aGUgb3RoZXIg
ZmlsZXMgaW4gJEhPTUUvLmNhY2hlL3FlbXUvZG93bmxvYWQNCj4+IHlvdSBoYXZlIHRoYXQgYXJl
IG92ZXIgNTAwIE1CID8NCj4+DQo+PiBXaXRoIHJlZ2FyZHMsDQo+PiBEYW5pZWwNCj4NCj4gVGhl
c2UgYXJlIHRoZSBmaWxlcyA6DQo+DQo+IDU3MzIyNTVkNDYxN2Q5OGI3NmJiYmMxMTZkMzMxZDZh
Yzg5OTA2ZmEyMTI5NjllYjgyMTNmZGM0YWVhODY0NTEgIDE2Nk0gIGFzdDI1MDAtZGVmYXVsdC01
MTUtb2JtYy50YXIuZ3oNCj4gMjc2OGUyNTI2YmRkM2Y5MjhkZjMxMzQxODAxY2I2ZGUzYjlhNDBj
YTk0MmI1MzhhM2QwODAwY2QyNmZiZGJmZSAgMTY2TSAgYXN0MjUwMC1kZWZhdWx0LW9ibWMudGFy
Lmd6DQo+IGVjZTFhOTM0MDk1Mzc4OTI5NzgwZjAzZTdkMDkyZTU2MmY0YjMzYjI4NDFiODBhZDdj
M2QxMmE4NTc0NGMwZjYgIDEuMUcgIGFzdDI2MDAtZGVmYXVsdC01MTUtb2JtYy50YXIuZ3oNCj4g
NjRkODkyNmE3ZDAxYjY0OTE2OGJlOTZjOTg2NjAzYjU2OTBmMDYzOTEyODZjNDM4YTNhNzcyYzhj
NzAzOWU5MyAgMS4yRyAgYXN0MjYwMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+IDRmODc3OGJlMTc2
ZWNlMWI1N2QzM2M0YWVlMTNiYjk4OWJlMTE0YzNlNDcwMzE1MGVhZWI2Zjk5NmJkNTU4N2YgIDU4
Mk0gIGFzdDI3MDAtYTEtZGNzY20tb2JtYy50YXIuZ3oNCj4gZDVjZWVkNTExY2QwZGZlZmJiMTAy
ZmZmMmQ3MzExNTllMDQ3Mjk0OGEyODA2NmRjMGQ5MGJjZDU0YmU3NjUyNSAgNTIwTSAgYXN0Mjcw
MC1hMS1vYm1jLnRhci5neg0KPiAwZTkzZjc5NzYxMzlkYTcxZmFiOWRmNzk1MmE1OGJkZDgwNjUw
ZTIzZTdhYmY1ODUzYjBlYjY2OTVkZWIwMmQwICA1ODFNICBhc3QyNzAwLWRjc2NtLW9ibWMudGFy
Lmd6DQo+IGUyYjhmMDQzZmU4MDYzZGQzYjZkZWQ5MzQyMmUzOGJkNDE5MTRkYzljMzIwMjE5OTUw
NzY1MmRmMDI0ZGU0ZGMgIDUxOU0gIGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KDQpUaGUg
aW1hZ2Ugc2l6ZSBmb3IgdjA5LjA4IHdhcyBhcm91bmQgMjUwIE1CIGZvciB0aGUgYXN0MjUwMCwN
CmFzdDI2MDAgYW5kIGFzdDI3MDAgU29Dcy4gSXQgd291bGQgYmUgYmVzdCB0byBrZWVwIGl0IGxp
a2UNCnRoaXMgZm9yIHRlc3RpbmcuDQoNCldvdWxkIGl0IGJlIHBvc3NpYmxlIGluIHYxMi4wMCA/
DQoNClRoYW5rcywNCg0KQy4NCg0KDQoNCg0KDQo=

--_000_TYPPR06MB820602C7A633D644D46CCC0FFC6BATYPPR06MB8206apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
Hi Cedric,</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"auto">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"auto">
Due to my vacation, I will be back in the office next week. I will update y=
ou then.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Jamin</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family:Aptos, Aptos_MSFontService, -apple-system, Roboto=
, Arial, Helvetica, sans-serif;font-size:12pt" dir=3D"auto" id=3D"ms-outloo=
k-mobile-signature">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt;">=C8=A1=B5=C3
<a href=3D"https://aka.ms/AAb9ysg">Android =B0=E6 Outlook</a></span></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> C=A8=A6dric Le Goater=
 &lt;clg@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, February 17, 2026 6:19:04 PM<br>
<b>To:</b> Daniel P. Berrang=A8=A6 &lt;berrange@redhat.com&gt;; Peter Mayde=
ll &lt;peter.maydell@linaro.org&gt;<br>
<b>Cc:</b> Thomas Huth &lt;thuth@redhat.com&gt;; qemu-arm@nongnu.org &lt;qe=
mu-arm@nongnu.org&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;;=
 Kane Chen &lt;kane_chen@aspeedtech.com&gt;; Jamin Lin &lt;jamin_lin@aspeed=
tech.com&gt;<br>
<b>Subject:</b> Re: [PULL 02/16] tests/functional: Add SDK tests with Linux=
 5.15</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello,<br>
<br>
+ Jamin,<br>
<br>
On 2/16/26 16:08, C=A8=A6dric Le Goater wrote:<br>
&gt; On 2/16/26 15:59, Daniel P. Berrang=A8=A6 wrote:<br>
&gt;&gt; On Mon, Feb 16, 2026 at 11:17:38AM +0000, Peter Maydell wrote:<br>
&gt;&gt;&gt; On Mon, 16 Feb 2026 at 11:13, Peter Maydell &lt;peter.maydell@=
linaro.org&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Thu, 12 Feb 2026 at 21:42, C=A8=A6dric Le Goater &lt;cl=
g@redhat.com&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Add functional tests for AST2500 and AST2600 machines =
using the<br>
&gt;&gt;&gt;&gt;&gt; OpenBMC SDK v11.00 with Linux kernel 5.15. These tests=
 complement the<br>
&gt;&gt;&gt;&gt;&gt; existing SDK tests and verify that QEMU correctly boot=
s older kernel<br>
&gt;&gt;&gt;&gt;&gt; versions on these platforms.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; ASSET_SDK_V1100_AST2600_515 =3D As=
set(<br>
&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '<a href=
=3D"https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2=
600-default-515-obmc.tar.gz">https://github.com/AspeedTech-BMC/openbmc/rele=
ases/download/v11.00/ast2600-default-515-obmc.tar.gz</a>',<br>
&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'ece1a9340=
95378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6')<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This asset file is over a gigabyte in size, it takes forev=
er to<br>
&gt;&gt;&gt;&gt; download, and our functional test asset download framework=
 has<br>
&gt;&gt;&gt;&gt; no mechanism for giving any kind of progress indication fo=
r<br>
&gt;&gt;&gt;&gt; downloads (or even for telling you the URL it is downloadi=
ng<br>
&gt;&gt;&gt;&gt; until after the download is complete).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Can we have a size limit for test assets please, at least =
until<br>
&gt;&gt;&gt;&gt; the framework can support large assets a bit better ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Followup: we have six test assets that are over 500MB in size,=
<br>
&gt;&gt;&gt; and they are all aspeed tests. Please can you have a look at<b=
r>
&gt;&gt;&gt; slimming these down?<br>
&gt;&gt;<br>
&gt;&gt; I see 2 big assets from aspeed only<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;&nbsp; 64d8926a7d01b649168be96c986603b5690f06391286c438a3a77=
2c8c7039e93<br>
&gt;&gt; &nbsp;&nbsp; ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d1=
2a85744c0f6<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; what are the names of the other files in $HOME/.cache/qemu/downloa=
d<br>
&gt;&gt; you have that are over 500 MB ?<br>
&gt;&gt;<br>
&gt;&gt; With regards,<br>
&gt;&gt; Daniel<br>
&gt; <br>
&gt; These are the files :<br>
&gt; <br>
&gt; 5732255d4617d98b76bbbc116d331d6ac89906fa212969eb8213fdc4aea86451&nbsp;=
 166M&nbsp; ast2500-default-515-obmc.tar.gz<br>
&gt; 2768e2526bdd3f928df31341801cb6de3b9a40ca942b538a3d0800cd26fbdbfe&nbsp;=
 166M&nbsp; ast2500-default-obmc.tar.gz<br>
&gt; ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6&nbsp;=
 1.1G&nbsp; ast2600-default-515-obmc.tar.gz<br>
&gt; 64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93&nbsp;=
 1.2G&nbsp; ast2600-default-obmc.tar.gz<br>
&gt; 4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd5587f&nbsp;=
 582M&nbsp; ast2700-a1-dcscm-obmc.tar.gz<br>
&gt; d5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76525&nbsp;=
 520M&nbsp; ast2700-a1-obmc.tar.gz<br>
&gt; 0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0&nbsp;=
 581M&nbsp; ast2700-dcscm-obmc.tar.gz<br>
&gt; e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc&nbsp;=
 519M&nbsp; ast2700-default-obmc.tar.gz<br>
<br>
The image size for v09.08 was around 250 MB for the ast2500,<br>
ast2600 and ast2700 SoCs. It would be best to keep it like<br>
this for testing.<br>
<br>
Would it be possible in v12.00 ?<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_TYPPR06MB820602C7A633D644D46CCC0FFC6BATYPPR06MB8206apcp_--

