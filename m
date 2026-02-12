Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EAECD6F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSHX-0000N2-0S; Thu, 12 Feb 2026 03:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vqSHP-0000Mc-PD; Thu, 12 Feb 2026 03:42:32 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vqSHC-0000Gi-Ke; Thu, 12 Feb 2026 03:42:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU2kfNLyQnxFnbDegDXHHO6nFMN3bs25PTRB5AvNwDWS8/ZJMcCOGUzBc5hmMXBH8mU5wjrsxaIb+VE3DuA1fm0SlyGnNOmUevlHpiEDDlXyZMU8YSj09dZE1+HSxz8KDJqzr9U04LuL/jad9p2OIatn8iBwu9Zt1L1ykSJhfTZSsF0AhWrOcleI6BplaCxV6ANe9wWMVlB3cRxJ4Enm4a0KChT9I0B3aoHeTEhVd4GtdZjS8CSTQYYtZxDCE6hhByUd9AxmVZ8BWh5saNrQxSI96MSig/bLT07NP4823soP+YWqwnXZiJIg+0W50qWQZ8U5ZeNn0C7e6aUaymcc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM+woNvadaOpMmGs1uPFQWSixeVlsR0keNYxQHZH1iw=;
 b=bLdrAZXXUVVhNip+Ou8DZNr1c6xObIV/Y6dkbW0lEoqZuPRZ3X/KG4CjGuGSEeWen60kbDPZf3psJdWCFvaH9MwaLASZqi6XyOS802XZKM7xpa2h8w9eLPLesWfAIPY3MRVUEq33x1SqVpSr7bFXShLHDyPZLYwxzdKI7w+KaoaIuUrHNhmcEA1VETdPQ0vop4YM5b1FzwHuRfNKXsMGPocGd8hKbijZwWmvSc/UC+mSx/zgLp1aNzKHsC5hvWOBMzFRl5KlaniYIlxleEXC76crYSbiZBwz6BCCeatyjBu+QbbIR0b57DTsCDsr8E7QaCa95j58kKcpFTOIwHr0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM+woNvadaOpMmGs1uPFQWSixeVlsR0keNYxQHZH1iw=;
 b=rlS2xQD7xg5KaJ9R9F2Vtq9vWkG9Tmup6aRJUywO9bgrcMEtN8m5YFFaznGKlVkB61NyiENpoToRnHY3ZqlWurThgYSz0wF+MA4Uldjf0oXojEXjFwm38+gSU6p4xxU6Nnsbz5s7yYe4nowqViSJ71sPe5dvITBqfNQH6pPTiZj/TI2Tugv4l67Rq4BaAqcIb8J0Os12nfKPPFx8+3eugzUmfv3YwrSatgCvchIb7xWYa+P1UiO2eXaaE0h5OkHf1vujiKwFDbrp+rdYScI8AmXiHOPrCCJKNGF9PvYiYL88YNfcFLypuj+Wsj9JQBgFlAMLY6z9UXja37Gdgc3mvg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB5167.apcprd06.prod.outlook.com (2603:1096:101:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 08:42:10 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 08:42:10 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
Thread-Topic: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
Thread-Index: AQHcmzEHTn6qqearhU+57e3eAUbxWbV+ZxswgABMhACAAAPgAIAAAY4g
Date: Thu, 12 Feb 2026 08:42:10 +0000
Message-ID: <SI6PR06MB76314A18D04E22F724D61C57F760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <d56d900f-d9cd-4c6f-ac44-a0cb0e6e6b13@kaod.org>
 <SI6PR06MB7631B5BECA948F629031A0E1F760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <44801358-496e-4cef-a33e-ca91745a15c8@kaod.org>
 <16417646-e328-4ffd-b648-dcdda4492da3@redhat.com>
In-Reply-To: <16417646-e328-4ffd-b648-dcdda4492da3@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB5167:EE_
x-ms-office365-filtering-correlation-id: 2e8205bf-98e0-4958-dbca-08de6a129cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VDk2NlN4ZEozd25LYmI1a20zSllRbnpqYW1mMzB5SHVRRmJXdVdoenkyOHhS?=
 =?utf-8?B?YzZpeWJJYUtkZitkV0YvQlpqMjViUG5DSE1SVlBNNWRzemExQ28xZllmcmRZ?=
 =?utf-8?B?akpIeTg5NnpaMnRrdEd1SFZFL1EySng4OTR0RnM3SnJwTEg3RTNLUElhaTcw?=
 =?utf-8?B?NXdOK1Raeis0UzF2c1pKTXJrSWRDL1VpUHQvQ3ZJQTFRdDA0K1NDOEMzNFJy?=
 =?utf-8?B?WXRLdFAyNzBYT2Noc0NFSTdwT0tNbWp0WE5mRWF2V3pJS1dxd0dKM2pLTzM3?=
 =?utf-8?B?emhrSTQySFhESkJxQWQ4OThuZU5yazNmTjZrYTJYeENZRHViTWovQ2tZNE1n?=
 =?utf-8?B?MGZZWnI3STVublRBdnhER3ZCU0pIU2ZKLy94VVBndWkrUFRTamg2RkFKTlIy?=
 =?utf-8?B?d09Vd0IzTEthMCtlcDNkYVduNHJqKzgvQ28zNzNlakhlMGQ3Ym15Z2V1SUY2?=
 =?utf-8?B?bjhaQ2pWby94VHNnOFFBc2lLTFZlNTc3bTFtK3NFZkp2WS9sb2pjTi8rTjRC?=
 =?utf-8?B?bGpob2lxeS95dlZORndYR3Q0d1FiV090d1c3ZHRTdUgyVityNHM4d2ppYjZv?=
 =?utf-8?B?c2lTYWNwRWZwTVJnMXN5UkxzdTI3RlpiSkdnMDFkZGFkUkhSWU5qMGM3T1c3?=
 =?utf-8?B?aEFwZXRoMWRhaWIyMlhJc2NDakJMRmFlSjBkYUc2SmgvamYrNE5CQ0xRYUZI?=
 =?utf-8?B?Z0ZGckpGYjRmdnc3WFJXekd4YkNOTnMwZWZGTXlHNnlMa3RsK202cTlmRXFT?=
 =?utf-8?B?OFZ6S2RHOGhWU21qS09tTno4djVXdzBUSWZhcHlqUjYraTdaQ1lhQlprYXJs?=
 =?utf-8?B?Mmp0a1E0TkdNZ3lSK1V0QnNUcWVCRU13MEU3WUkzc2dMZng1Q3lSTklVRVN2?=
 =?utf-8?B?Sk9zZkRjS0M5NzQzeDlsc0MwaTZJem1zL0NSeUdSZi9QN203MWJyZThpQ1Jk?=
 =?utf-8?B?MEgveUgyNXdVdnJsYjdKRUtidFVMWDFPaG1IRFlna1hmb1hKTnF6bmorRC9U?=
 =?utf-8?B?eWRMT29zMWNaaHJuNXF0dlFBYXFYLzFNMS9JU2ZZazV4RGFTbXhrZXF6WWZ1?=
 =?utf-8?B?ZGxaSk4xdjU1WjUwZDhrU0o4TndhdVMrWi96SUMrTjhVdGFDZ2J1WTg2aU96?=
 =?utf-8?B?eWV4ZmJIaFAweDVLK1A1d1ptUXRxZ0hsbUY2ZjNVVFNMU1JISXkzUTlzRUc0?=
 =?utf-8?B?elVBNU1TRmUwcTl2bWFiZ3JtcUxaNFluSGhJZzY5UXFQb0xUdTJ5TFBJd2Q3?=
 =?utf-8?B?RnBtWmVyWkRYRUl4eVhUalk0aWdhaW1VTW5DNCtlMUhlcXFQTWl4MDlXOS9Y?=
 =?utf-8?B?SnNPUEVhc3VWWm5uc1JxNGpEQlc4Snd4OUNubzVKWWJVc0hXdXVlRmlHdklI?=
 =?utf-8?B?OGxVZzcydHJRWUpFS0lqQVBPaGZoNDRCeWJFZVdTK3Vnb1dhbnZQNkg5Qyth?=
 =?utf-8?B?WncyMXRCN0lZeHR6azFXZTVWelRkMmw2bTVFRDkzZWcxUHJvYTQzdGNZMjRE?=
 =?utf-8?B?UG5oQ1lYV2U5cmxhd2U3ektobm1lTXk2MjVsU012SzVqNWJzUHpvS0FIWmpy?=
 =?utf-8?B?elRpWW9tZVJmRzhMTkFCOUVRQlZaQjd1YzhONWxKUmJZcVQwbkxMbHJsTXVh?=
 =?utf-8?B?ZTZ2TXdGR2l2eWxKUy9uZVFZZ2d2dUV3V2FQYjd0c25lcFRiaE82L2xRNEp1?=
 =?utf-8?B?QUVkK3F1NHk4b09MMXVBQTZGWW1yYnJ2Q2xoMllqUFMzLzBqYzAzb1RMVS95?=
 =?utf-8?B?djdVSUFQdEFDQlZWQ3lVU3NvUVc3dXdqT3hETW4wNjNIVUxxbmdGbHBOMWR3?=
 =?utf-8?B?QjRLK3dJVmhrT2hXSzB4czlpTW1QNzQ4RktYWG5MQzZTMkIzVnFaRzZ3Vlhk?=
 =?utf-8?B?ZzdQMlNlYlNrbFpjNlN2cmU1SENHcVVTUEdOamdHc01uSHN1aVY4dGxVZy93?=
 =?utf-8?B?d0JoNnR6bmhMVEQzTUZZT0c5QWFISmx1N0Z0RlJDemRzNEFCcGRkaUpldjFU?=
 =?utf-8?B?RzZzOGlVNWdGUjF6MWRWc1UyQ1d5WlhrR21OemRTSUVOMjFVclNmdFk4ZzVV?=
 =?utf-8?B?ampEZFFjZ1hkTFJrUFVzQ2ttMk5jTTg2UnJXaStVUndzeStsaUJtWExHQ3NJ?=
 =?utf-8?B?SHUraWFZZ2xMakwrMVBxSUk4bzNzQ2prVXFOY3dyZ0kwVTNWOWcrUFJoTXZZ?=
 =?utf-8?Q?nK3LGOYjX6dYJ0+hUB4XpYg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzVFMkVFcmpuY1JOSUlhaXloTkw5L2pNYWp2THFxUjQ5eTZ0L1RSYlM3S09j?=
 =?utf-8?B?clNrdkY3V2tVVXVoQUJ6eVh6RU1ZcjVhbnhoMWtPbzN6SStTLzNqdmdoR0Y1?=
 =?utf-8?B?Lzc1NUt5d0FEL1JqQnFmMVlBbkQydWlXQ3g5WUd6cTI3bTlPZHA1eEp4Q2dU?=
 =?utf-8?B?aDVDb25VS1haVXBhRiswV2ZKTExJNFdRelhEaksvalhLQUFzWkJaeThPYUFo?=
 =?utf-8?B?WHlkRVUvSXRTTW44M2VtREw0c0t6K0MwQ2RCQXVvd3JONXBNWE5YQllXQ1Iz?=
 =?utf-8?B?SElaOFJCNmsyRXpaVjd4Sm1aSkE1S2E0SDlGZ3FQNDYxSzVHL2c2ZmhYdENo?=
 =?utf-8?B?clIzT1ZqZ0pHenVFTjdneERWRXFUd1ZsQnRVa3drbEVYb1BiK0lTTWdVeWkv?=
 =?utf-8?B?R29YUXpqcXhsQnFZcGsvblk2TUFldEZsRDJhK2IzQmU1dnlhekVNaWVjZXNi?=
 =?utf-8?B?Zm1nMkFuckNDVjFMNmpUdXU2b0cwbUhjWDFOVUpVL2FpQjgzN0NjQjA0cWpK?=
 =?utf-8?B?bFJYT2MxS0pVbmFSZGI2VWp0YkxIbkI0RmdZWXlSaDNZOU5ZWW8veWtUTDRU?=
 =?utf-8?B?NFBUT3dLOXk1QktxVnljak4yL29sOHVSUWNYSTFFMjcxYUZVdGxPL3Byc2Jw?=
 =?utf-8?B?aHgrUU40UHFwMlNMUXFrejl5OUNtOFpXOWhtQ1FuN2pJdFM2YXdjbmFwT1hL?=
 =?utf-8?B?a3NwWUhFeStGNmEwZi93T2xNOStBT2RnbFhWSTZoaC9qdUZUc0tUUGtqZktY?=
 =?utf-8?B?eTV5QlZ0NGZucmZtV3hNaklYWStKVm9CeGkrQSsrdEJsMDRFcCtXMGFwYS9G?=
 =?utf-8?B?eDkyd2tUUVU1cXRCWGk0YXJia2MzTHJQV0Q5dWN6VmNEVGwwajZOUTYrbEIx?=
 =?utf-8?B?VUZ2NkR6RGluZXJ4SUlzcmxvMWlTdjJGS2VSYW0yT2pQY0kvNDE3QnUzYmlI?=
 =?utf-8?B?Y2Rab3VJYURteGM1NnY1QUlWSDFpUFdwTlpLaEZPa0IxVEhVL0NSQUhpMHdz?=
 =?utf-8?B?R0V4NXRrVm92L2laakQ1ekVoT05WSjd3ajBnL3dJemVwVmEzeTNIT0pCOW1n?=
 =?utf-8?B?WUFhVmM3dFFtL0FKL1U5NVdOTUExUyt5U2p1czJ1RHQrMXZWOFQwRFEyazhW?=
 =?utf-8?B?SWhPd0FJSVFKazlXOG9RbXJNbkdDTGF1QVhlbUtZMUZScWJucnpwVTBOSFZi?=
 =?utf-8?B?RlJoYUFRWjdybUh2TCtlRElPZWJEL2t2bnpydFo2UjNwaDFLY0VHR3lTdGtD?=
 =?utf-8?B?N3dmbWNmVGVVRCsyWVpmSS9HRi9CMFhOV1d3N3RqRzAvRzgvdXdhSlhOTm5I?=
 =?utf-8?B?WEcrNUVEMDZ4SFc1ZCswVFl0YVZvVFJBZG9rWmJXb2JveDhqK0pmYUhjL093?=
 =?utf-8?B?UWpBYmdOUnlBZWYrbkhtTy9odWxVWlJtWnAwU2RmMmR5VllKYTlOYzNCeWEz?=
 =?utf-8?B?aU9HRVhXY2VKa2tOR2Q1NnNFTE5DeEpkS2svWDFacDRqM3drTWJIdTBKVkNZ?=
 =?utf-8?B?alJQN1RHZFpFRUNlRjdqUjE4dzZBYUZhOExoeGlFbEdvNmdQN2JCWFRiZitz?=
 =?utf-8?B?SlBrNVltakRyTDhLWVo2Y253WXc3WVE2MXhoaEdJOXlFSlcya2RrdU5PMGRt?=
 =?utf-8?B?VXJiK1EzYlBvM2drM25DeURUbGRSQytEVGJWaFRjSGhSS0VqQkQ4YXE0em9Z?=
 =?utf-8?B?dUVmMFk2M0oxTUIyeXFlYXkyanpQOFJYSiswMk9UN1dIU1NCOEl0RUI5Y0hs?=
 =?utf-8?B?VnVBYWFzN000RHBhcElyRFBQdEpidDMwbGkvYnB3Wk91eDBsNUdRaEZhL25u?=
 =?utf-8?B?dnRuLzJOcDJJSlRISXQ5WUk3dWJ2c3B1SEN1QXNLOEJMbytpOHNUbDM0V3Ix?=
 =?utf-8?B?T3BRM2tGakVLQkxXb3NQOHp0S0dJb1B3UzViSG1oZEhJcHB5VDF5eU54K0Ey?=
 =?utf-8?B?VVEvRTE3ZDB2R1B3VmdUYzZFekd4OXpEM3c0ZFFRODhKUkFmM0U5YUNMcUwr?=
 =?utf-8?B?c1R5Z3NlN2NmUHFqazFvOThaMnp3V2RZZWd4bzYyTWFPTHh6a05FUlZNd2ll?=
 =?utf-8?B?MEhlTkZtdm42VkNxRDE0akdCUVh4ZmRVWXpHOTRLcGg3Mk84UXZmdFRHQXl4?=
 =?utf-8?B?VEh5a1RZWjFlN0xZTm9Gdzd0MXRjclZNRXZaS1kxUGQ4S3AxenE2bWZkemVH?=
 =?utf-8?B?aTNOK2FMRnpUS2txR1dqQWZBbFVhS1dEMVlGYWM1TDFNK3UzMVZ5R2p1QzFL?=
 =?utf-8?B?WTgvWnd4c2lXd3ZjRnlmbWI1VVN3Ull3VEtaVU9xM0YwUVN4dmtnMWJqTXln?=
 =?utf-8?B?YTFkVW9qRnNsVUhieTlnV0RYK0RQRGpURXlJblNXVEJscGlkVEE3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8205bf-98e0-4958-dbca-08de6a129cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 08:42:10.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEB7n820Jjff3R1O0+Ip1Vj0xrWvgHCUaessV/FtszHfhT37JiTjo43d/iNtJ1gxCFIV3r8GjL6Pr/3MruQo0ZiZjwEaMp28K02KRU4pl1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5167
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxMiwgMjAyNiA0OjEw
IFBNDQo+IFRvOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgS2FuZSBDaGVuDQo+
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHFl
bXUtYXJtQG5vbmdudS5vcmcNCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz47IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95
IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+
OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgVGhvbWFzDQo+IEh1dGggPHRodXRoQHJl
ZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSB0ZXN0cy9mdW5jdGlvbmFsOiBB
c3BlZWQgQVJNIHRlc3RzIGVuaGFuY2VtZW50cw0KPiANCj4gT24gMi8xMi8yNiAwODo1NSwgQ8Op
ZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4gSGVsbG8gS2FuZSwNCj4gPg0KPiA+IE9uIDIvMTIv
MjYgMDQ6MzksIEthbmUgQ2hlbiB3cm90ZToNCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+Pj4g
U2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxMSwgMjAyNiA0OjMzIFBNDQo+ID4+PiBUbzogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0K
PiA+Pj4gcWVtdS1hcm1Abm9uZ251Lm9yZw0KPiA+Pj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUNCj4gPj4+IDxzdGV2ZW5fbGVlQGFzcGVl
ZHRlY2guY29tPjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4NCj4gTGluDQo+
ID4+PiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4gPj4+IDxh
bmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1
PjsNCj4gVGhvbWFzDQo+ID4+PiBIdXRoIDx0aHV0aEByZWRoYXQuY29tPjsgS2FuZSBDaGVuIDxr
YW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0g
dGVzdHMvZnVuY3Rpb25hbDogQXNwZWVkIEFSTSB0ZXN0cw0KPiA+Pj4gZW5oYW5jZW1lbnRzDQo+
ID4+Pg0KPiA+Pj4gSmFtaW4sIEthbmUsDQo+ID4+Pg0KPiA+Pj4gQ291bGQgeW91IHBsZWFzZSBy
ZXZpZXcgdGhpcyBzZXJpZXMgPw0KPiA+Pj4NCj4gPj4+IFRoYW5rcywNCj4gPj4+DQo+ID4+PiBD
Lg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gT24gMi85LzI2IDA3OjUwLCBDw6lkcmljIExl
IEdvYXRlciB3cm90ZToNCj4gPj4+PiBIaSwNCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgYWxsb3dzIHRo
ZSBmdW5jdGlvbmFsIHRlc3Qgc3VpdGUgdG8gcnVuIHRlc3RzIGluIHBhcmFsbGVsIG1vcmUNCj4g
Pj4+PiBlZmZlY3RpdmVseSBhbmQgYWRkcyBhIG5ldyBzZXQgb2YgdGVzdHMgdXNpbmcgdGhlIG9s
ZGVyIExpbnV4IDUuMTUNCj4gPj4+PiBrZXJuZWwuDQo+ID4+Pj4NCj4gPj4+PiBUaGFua3MsDQo+
ID4+Pj4NCj4gPj4+PiBDLg0KPiA+Pj4+DQo+ID4+Pj4gQ8OpZHJpYyBMZSBHb2F0ZXIgKDIpOg0K
PiA+Pj4+IMKgwqDCoCB0ZXN0cy9mdW5jdGlvbmFsOiBTcGxpdCBBc3BlZWQgQVJNIHRlc3RzIGlu
dG8gc2VwYXJhdGUgZmlsZXMNCj4gPj4+PiDCoMKgwqAgdGVzdHMvZnVuY3Rpb25hbDogQWRkIFNE
SyB0ZXN0cyB3aXRoIExpbnV4IDUuMTUNCj4gPj4+Pg0KPiA+Pj4+IMKgwqAgdGVzdHMvZnVuY3Rp
b25hbC9hcm0vbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4ICsrKyst
LQ0KPiA+Pj4+IMKgwqAgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MTA2MC5w
ecKgwqAgfMKgIDANCj4gPj4+PiDCoMKgIC4uLjAwLnB5ID0+IHRlc3RfYXNwZWVkX2FzdDI1MDBf
YnVpbGRyb290LnB5fSB8IDE0IC0tLS0tDQo+ID4+Pj4gwqDCoCAuLi4vZnVuY3Rpb25hbC9hcm0v
dGVzdF9hc3BlZWRfYXN0MjUwMF9zZGsucHkgfCAyOSArKysrKysrKysNCj4gPj4+PiDCoMKgIC4u
Li9hcm0vdGVzdF9hc3BlZWRfYXN0MjUwMF9zZGtfNTE1LnB5wqDCoMKgwqDCoMKgwqAgfCAyOQ0K
PiArKysrKysrKysNCj4gPj4+PiDCoMKgIC4uLi9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9idWls
ZHJvb3QucHnCoMKgwqDCoMKgIHwgNDEgKy0tLS0tLS0tLS0tLQ0KPiA+Pj4+IMKgwqAgLi4uL2Fy
bS90ZXN0X2FzcGVlZF9hc3QyNjAwX2J1aWxkcm9vdF90cG0ucHnCoCB8IDYwDQo+ID4+PiArKysr
KysrKysrKysrKysrKysrDQo+ID4+Pj4gwqDCoCAuLi4vZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3Bl
ZWRfYXN0MjYwMF9zZGsucHkgfCAxNSAtLS0tLQ0KPiA+Pj4+IMKgwqAgLi4uL2FybS90ZXN0X2Fz
cGVlZF9hc3QyNjAwX3Nka181MTUucHnCoMKgwqDCoMKgwqDCoCB8IDI5DQo+ICsrKysrKysrKw0K
PiA+Pj4+IMKgwqAgLi4uL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nka19vdHAucHnCoMKgwqDC
oMKgwqDCoCB8IDM0DQo+ICsrKysrKysrKysrDQo+ID4+Pj4gwqDCoCAxMCBmaWxlcyBjaGFuZ2Vk
LCAxOTYgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pDQo+ID4+Pj4gwqDCoCBtb2RlIGNo
YW5nZSAxMDA2NDQgPT4gMTAwNzU1DQo+ID4+PiB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2Fz
cGVlZF9hc3QxMDYwLnB5DQo+ID4+Pj4gwqDCoCByZW5hbWUgdGVzdHMvZnVuY3Rpb25hbC9hcm0v
e3Rlc3RfYXNwZWVkX2FzdDI1MDAucHkgPT4NCj4gPj4+IHRlc3RfYXNwZWVkX2FzdDI1MDBfYnVp
bGRyb290LnB5fSAoNzQlKQ0KPiA+Pj4+IMKgwqAgY3JlYXRlIG1vZGUgMTAwNzU1DQo+ID4+Pj4g
dGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjUwMF9zZGsucHkNCj4gPj4+PiDC
oMKgIGNyZWF0ZSBtb2RlIDEwMDc1NQ0KPiA+Pj4gdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9h
c3BlZWRfYXN0MjUwMF9zZGtfNTE1LnB5DQo+ID4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA3NTUN
Cj4gPj4+IHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfYnVpbGRyb290
X3RwbS5weQ0KPiA+Pj4+IMKgwqAgY3JlYXRlIG1vZGUgMTAwNzU1DQo+ID4+PiB0ZXN0cy9mdW5j
dGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nka181MTUucHkNCj4gPj4+PiDCoMKgIGNy
ZWF0ZSBtb2RlIDEwMDc1NQ0KPiA+Pj4+IHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVk
X2FzdDI2MDBfc2RrX290cC5weQ0KPiA+Pj4+DQo+ID4+DQo+ID4+IEhpIEPDqWRyaWMsDQo+ID4+
DQo+ID4+IFRoYW5rIHlvdSBmb3IgdGhlIGVmZm9ydCBpbiBpbXByb3ZpbmcgdGhlIHRlc3Qgc3Vp
dGUuIFRoZSBzZXBhcmF0aW9uDQo+ID4+IGludG8gZmlybXdhcmUtc3BlY2lmaWMgZmlsZXMgbWFr
ZXMgaXQgbXVjaCBjbGVhcmVyLg0KPiA+Pg0KPiA+PiBUaGlzIHNlcmllcyBpcyByZXZpZXdlZC4N
Cj4gPiBDb3VsZCB5b3UgcGxlYXNlIHNlbmQgYSBSZXZpZXdlZC1ieTogdGFnID8NCj4geW91IGRp
ZC4gSSByZWNlaXZlZCB0aGVtIG9uIG15IEByZWRoYXQuY29tIGVtYWlsLg0KPiANCj4gVGhhbmtz
ICENCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMsDQoNCkdsYWQgdG8gaGVhciB5b3UgcmVjZWl2ZWQg
dGhlbS4NCg0KSSB3YXMgYSBiaXQgY29uY2VybmVkIGJlY2F1c2UgSSBpbXBvcnRlZCB0aGUgZW1h
aWxzIGZyb20gYW4gbWJveCBmaWxlDQppbnRvIE91dGxvb2ssIGFuZCBJIHdhc24ndCBzdXJlIGlm
IHRoZXkgd291bGQgYmUgc2VudCBvciBmb3JtYXR0ZWQNCmNvcnJlY3RseS4NCg0KQmVzdCBSZWdh
cmRzLA0KS2FuZQ0K

