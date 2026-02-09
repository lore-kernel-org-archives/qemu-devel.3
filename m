Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B3E7E0B4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNnE-0002Vq-Qv; Mon, 09 Feb 2026 04:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpNml-0002Ie-FV; Mon, 09 Feb 2026 04:42:28 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpNmh-0002m9-9X; Mon, 09 Feb 2026 04:42:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjQ6Zz8PPyNycZpfjQ4ygZFxOYYhBzfwA+fZxfSs9i19iqDcMo98Uc2JF15Wj54l9V1mBZHyjtaDM5RIoW4K90MWrJ5owXxrrZ0EQ1T1Z1h8PW1YqbcujXxrDO1P8YKMn7hX09eUE6UnnnDYTLyiB4J+dW/6BNE537SW5NgfqLX4QLjpVZIzUGu79/KPSijAhnvSYCx8xnQVnIXbv7/JXWG428ChLb/R8Yj171m+9fC+ivZjYgsWiMhVccMSK2WC+GNoZ5cG/C6CbVBsreEvuEbUwRclO5Up+9s1OleJECDlTwwpp7W7ils6fp+TRqE9Xuarx2388jQZRU0AC8e0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x3onXWeIfLeIYg2LsiJEKKjyqjMANf+wIyqiXGWkAQ=;
 b=XGSNQJlgvHk0qp9n1vybBRaGOzSpgjT/tzG9TTvKKaHm8JmPbJVXSpkV2jQ8muAqqhMxgby3Was9IORrwt/kAwK72bGnAbdAWeyor4z8OY6OsaSTdDfVcq/9tXEYR2OfdKzM8wMu9wvOvp8ZmMZvLhH5nvqFj8hljGDq+YWqeSM34QyCYkJ7Ig1SaOTL9DDXZNSFg1Jd8CJxWThOOlJqJe0ilUbp1TW1hXrmp1Y+ee4H08D58vgHGVdjcYaHe9ojsgz1UsxXOm+piulRlO8O0NrqLxhn/A4vcmA/5e9cxqcR9wi54nArAyxGZISmPHg6digdhMshHSuK/VDoMTa71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x3onXWeIfLeIYg2LsiJEKKjyqjMANf+wIyqiXGWkAQ=;
 b=i9sTQG5tVkc6YZRPRYDa5FjCd96dCIJ9aa6VA78LEorFIZ94HUMGx5GG1AWMw4Qn/unaBR5jxaHXdgpWSJKA2LnU3aHjNg+C4KN2BcaeEJSgbNeuFJD/hTRWIlAKpbQ4/szO2DfxTgEzdfGkQffRCbTysWVduntxifOPecMh7yn7pmXlkOm0HzmXKqd044XympxwKjHbSbPkxLqpmV4Y9Ub8zWI0rH01ZhTzomkHougTAZFi6qFg+7IgFP1uNIpTjQTKGALveJR934Khk91RAdGQ4BMjBywQnfK+osWklTlCjmelT56W0ZZaJ02bLmdK4LZgfYGXotKb83SCLnB1KQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB5198.apcprd06.prod.outlook.com (2603:1096:101:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Mon, 9 Feb
 2026 09:42:12 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:42:12 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH 1/2] tests/functional: Split Aspeed ARM tests into
 separate files
Thread-Topic: [PATCH 1/2] tests/functional: Split Aspeed ARM tests into
 separate files
Thread-Index: AQHcmZ53IZu0ok7GIEK1jv3u+UAjOLV6EoNQgAAIwoCAAADtIA==
Date: Mon, 9 Feb 2026 09:42:12 +0000
Message-ID: <SI6PR06MB763153AD074A77902C35FC8AF765A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <20260209065044.239378-2-clg@redhat.com>
 <5e9e55de-77fe-4871-97b3-8627892abdac@kaod.org>
 <SI6PR06MB7631CD6C25E9E4AC9D1286F6F765A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <b0c0c671-b983-42df-84fe-2f8ac0be58ab@kaod.org>
In-Reply-To: <b0c0c671-b983-42df-84fe-2f8ac0be58ab@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB5198:EE_
x-ms-office365-filtering-correlation-id: c7e4bbda-6e5d-4c9b-ea36-08de67bf807a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V1UxRFFnelFUT0RiU29BdURGZ0pKY1ZQTG4xbjZ3M2svVEhVWVpYQTU2cytI?=
 =?utf-8?B?dkpLZ1lKQko3YzZaamlSeSthcEJpVktQWXhlc1pUV0QwZlNlcFBwbHZWZWVN?=
 =?utf-8?B?WWc5ano5RUIxTWNFd0FmZm5CMmtpa3RIM2JoMDVkNW95c0x0OVJTUWFtOFk0?=
 =?utf-8?B?ajZnOUx0MHE5bmNIdE5neUt0cE1iUVFodUxQK0NtYmNZNFJ2NUZSdTNLZWQ4?=
 =?utf-8?B?SC94TGdtTGFmWHhoUFBCVUl5aUFBZG1vVSsxdWNKYzVrUGhKU3BuU0J2amtI?=
 =?utf-8?B?eTlaQnZBWWdMdCtvMG9ySi9lUjB4Q3N3MDZzc3UxeHJBdTQyTnVvaTA2OWk0?=
 =?utf-8?B?dEZIeE8xZnhrSFdrYmV4N0NkQkxPeWEyOEdvU0V2VDlhYk1WWUJha3pXQXgy?=
 =?utf-8?B?Z3VTeExoMENEZzlkb0lMdm5oWENjWFU1eEdnNlBVaHZEQSt1THBkOFhUUTRs?=
 =?utf-8?B?WXc5ckhHeEY0UmlsQU9LS3VkZ3hYWHYvbDJjL2xVUCtlV1RVbjlJdEZxQ1lp?=
 =?utf-8?B?bm1ya01NSzNDanU4MW81U3RoVTBsVWpNUGxtZjBEUllESnJWMEYrRW1qd3d4?=
 =?utf-8?B?aENTclAxYVdpd09Objlnc1R4ZEY2TVpaWE90aVFUdGl3MkVvOTc2S1dLaXJS?=
 =?utf-8?B?ZjZyYWIwM0Nwa1pBNS9xbjYwNGJSVWk1azlpelpEQjhJWm85WWFiSmQ2K1hC?=
 =?utf-8?B?cExLUWc5MGdFNU9ESXlVYkZSSFJZaGNrS1piL2VXc2dDVFNUYmh0QmhPK0NQ?=
 =?utf-8?B?ZGVJaVlnbXZ4RWlrZkFzNW03dHAyRlhTY09ZRlZoRTlDandYYmdPYTF3ZGVU?=
 =?utf-8?B?QVN0RGR2anlIR291OGFZclJ4dCtBV01lUW8raUc5VGQrS3FCd1FQM01JYWlC?=
 =?utf-8?B?amFuZmFIcVBORFI5QUNxTFE4NnVGZ2xYRVVIMG1UZnVPdG5WTVI4cnJZQnl1?=
 =?utf-8?B?TVY4KytXK0V5bWc0NDFBWmNOaXB6b0Q0aE5FYXlKL21uT0QwWHRYbmN1RnVX?=
 =?utf-8?B?enBsZDZQZVVueUUxa25HNnRWcXZ5MGsvSFZaS0l4VnZBN1hkaDkwL0t0UUZY?=
 =?utf-8?B?UmQwWElQT1RWUzBEK2YzaUR1U2tmMDU3eWpWUS9Xazh3RVFXVnQ2Sm1nUzBX?=
 =?utf-8?B?Ull4bWl0WG10d2RqNW5IbThrK2xMSFZDT3c1TFFYa2JidG9KQnIrWWk2R0Vl?=
 =?utf-8?B?Z1Q2YTZLOXNSZmpnTGlzUWxmTEhyS2tid2pQbDUxRGZEZ044ZllsV3JyNk1l?=
 =?utf-8?B?NEwzWE81RjdLVVp5Vy9EcWJvQTBqQldDTWdrWTJkZHFiWW1zNlV6cGJPSXBj?=
 =?utf-8?B?U1dWZVM5YkdOb1V5bFlxNnk5MGg2WFU1RTZuUjZjWld3cTNpWWtvWWx6aWxL?=
 =?utf-8?B?enZLcGNDcFNsQU44UXA5M2tZNFNEaFN0MTlLcmtOaDAxUEpiRmczQ2NxTGhS?=
 =?utf-8?B?c2dnL0g2Zm9aa3pscWRrbVdjQnpaVlFPUnY2Y0M1YUpWV0RlZ3YzTW9SanNz?=
 =?utf-8?B?WlRpYkV2THN1czR2ckk3UzZLNTM0U0k2cVZIUW8zemdrZ2NEV0w3Um1zVERI?=
 =?utf-8?B?dUdCMG1pVFF4UnlUUzRKSmNXTzdjME9jMUdyWDdoRldUVmp0VDNBS1hJTzdT?=
 =?utf-8?B?bDltUEtyaEhKUmg1T0NIRFY0WUJzKzlTL0pXT3JwZ1l4b0ozbG9SSFB4aDZJ?=
 =?utf-8?B?dmdPc2h2TEFPUTBnTHJHcldLVlVocDBJMDBZek8rN1lBNHpCMkZhcm4xMDN4?=
 =?utf-8?B?dWszd25sMVlBL0poNnJWUG43NnlwWEpNeVZHUEZjMTZZSjZpMEdpY01Kd1l3?=
 =?utf-8?B?UnZTMEFCMHBTSGxhS2prZnhjUXMvb2IxRG1rWU1TeE9aWDJ4ZEsvbTdvSUNM?=
 =?utf-8?B?SGYzZUJRdjV1Q0RoeDNLZ2tia2FrTWk3ay9OWkM4bTJYYUQ0Yjk2V00xdnNk?=
 =?utf-8?B?c1pnakR1b1oxNzVPWlZML3NRemdqUklLYjJqTUdnQXNtcW8wUVBXZVFwRHpp?=
 =?utf-8?B?MnpXQ3BNdVp3cmxQbE5EcXMvRll2SUMzU21iTWNuZ3hCN0NVTTA1TDlGc0Zs?=
 =?utf-8?B?Rm03eERjUlQrRENZVVlONnhqamltMVpJalhSMnFGckJlRCtGRUxJYkNjTXRG?=
 =?utf-8?B?WTBuR2k1a2ZoMFRLeVRSVjRjZXhjdklOdjI4NVhtZXpTRUJnc1JtZmc4bTdW?=
 =?utf-8?Q?KRQvyVcrzjFstijODpp4y8k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGdRR3hJWlBMSlN0d2dFbFVhWnZ5TkFLTnM3M0ZrLzBvOEtUdGkwaWtHVkhL?=
 =?utf-8?B?K2wyK08xbGVoRmxXV1NZZlNwdkpJMEVQejVibHBSUUFnU0E5alpHZklMc1ZU?=
 =?utf-8?B?VzFJb1dKRmlCNGk2NW5OVXFsL21DUzVvT1k4QWVkM2V2ZzBUMXVtME1PbWxW?=
 =?utf-8?B?S1FLV2ZJZ21GNVdDZ01QaWpVV1BzT0Jqbi9SL0tSUXZxMU4velQ4S0lkVGVj?=
 =?utf-8?B?elJPUGxvL1VqUUdHeVdSQ0FVUlZtZm5Td2tMV05maEVwMm4xYjhoQ21CRDFp?=
 =?utf-8?B?cHp6WkJPenp2VS90bDFsSDdxc21wMy8zdXRTdW5yOUdMZXQwNHNXYWkxS2JE?=
 =?utf-8?B?T0x5NDkwZEhsSUtkWFpGRW9BTzl4VmgxMVdxTXJNMFNBY2NHY1B0T1J1VTBO?=
 =?utf-8?B?c0FUUUhEOUYzWThYa2ZhSmFvYWI4VzAwZ1d3Q0ZLK25OWkRwdFd2NG94UUEv?=
 =?utf-8?B?NGN1cU1vcldqWTZtTlh3VVJvbXc0dXdaWStMbWF1cjU5RlErN0Y0RkpUTDk0?=
 =?utf-8?B?TkNiL1hndy9NS0hxa0JWdy96TkxzbGhNMEZzb3JVNDVTTmlzOUJQYU1sd3R0?=
 =?utf-8?B?Mmh4Z3R6N0h2MVp4Y3d3S3JPRmJDNGNMcGFrVmpwWFg0c2lWUlJaY2FoRjRH?=
 =?utf-8?B?YlN3dy8zNTVnYit3N0dabGFDcXFpNWNkK0k2SzFVendPWW1Sb3cxSmNLMkZt?=
 =?utf-8?B?Yk1vWWhpYTNvcWxBUFUwZUMyWjhmdS93cmhaMFBBSHpGTlNYTHRUVG1PMXBv?=
 =?utf-8?B?a1NhNjEvQWt0MmNSSzhVeE5yUktXM1BBWkxhaHdDS0pJdjdub25qdWQvV1hC?=
 =?utf-8?B?NjBDS3hFbGgweW5mQ0pDcVRiWUJaVnBER0UvWXpKUm5Fei9hZDZMc2FQajdH?=
 =?utf-8?B?L3l6ME1NUWJ2N3ZQN1hINnU3VCtodFErakoxZGxOeDlMKzZFL2dmVHpBdldu?=
 =?utf-8?B?RnprYUEvRzh6OHdjVG5SQmZLN0h1eXNudlJYSEl4TDRFN1g1QVN0c3Z6dFdo?=
 =?utf-8?B?UHU4ZnY1OUZPMXhHWTBwU1RDTENKRUlOVUlYSnZRdFpmUytPY3JzTndIbXFU?=
 =?utf-8?B?dDMyU2FUQk9kcmdtL1NCT1NPZGhTNUZMdk9QMUVXREVyVUlnV1c0SDlpVTFz?=
 =?utf-8?B?WHRvOWZwdHRlVTFHZFZHaGJyQWJvVTVuK3ZTRTZVTXNUMjZQc0daMzRqb294?=
 =?utf-8?B?MUFoSURBWThkS2dvVzAwZDExYXU1eXNYdlBPc3hnNU02MVlzMFBxeDlueWFz?=
 =?utf-8?B?b1lVK3djdWU0Vkpodnp5NFFlT0FIUUkrbTYyQzdMOVBaVUcvYzBUOU5uaTA1?=
 =?utf-8?B?L2F5TU9oOFlwTW9NN09zaFptS3MzaXVrSTN2RnZiZkF3T2cwekFlME9CRVNG?=
 =?utf-8?B?ZzRXelQwNE9KeVZVWlpkSThBQldYZFdSVkhxVHI5ZXMwTnN6Qi9uekMrajJs?=
 =?utf-8?B?YTdMOWFuOEVVRkx2b2xiZkJaYmRXSlRVSzhrQzhiWkFZZjdka2JvZkpWWHFy?=
 =?utf-8?B?SmtQYlNGQXZuTm8rT0loK1hIdFU3UjlwdEdFVnFXYURrbzNzNjk1elB6cThN?=
 =?utf-8?B?L1Nib0VsWnljZ3NFUTdDbU4wR0Jpb2hUWnZGeksrdnFUMnk1SmFMNVBQemJB?=
 =?utf-8?B?RHB3RDBzSm8wSkpDV0dHSksvaU9Rbm1DRk1tSXU2ZGRIRWVYRmF4MHhyZEtW?=
 =?utf-8?B?U3Q4czBrWVVCaHJoSkRKUHFBN1hyRlc5Qml2Y0pHVS96Wnp1bmdBb3A0cEpI?=
 =?utf-8?B?Y1NsVHljN3llT3BBWEJ4V3hMOVoxYjNuRWVWU05tSTlFZ2pzcEIzS24yZ3BV?=
 =?utf-8?B?MzdQcWNtUWxUbG9vbEdsRWl2U0lqWm8zMHhzSDNFQWdVZC9VUzcxSTlzUnJy?=
 =?utf-8?B?cjNOODdCWGVlbk1GQkw5d2ZvMUh4MHN5cDhESWlSdEgyVms1NVpXNGo1QUty?=
 =?utf-8?B?MEpBQmhoaFVlYnhIMUVXWnJoTUxlRGxEY296UEgzR0hOYVRHL21TZkxVcm5s?=
 =?utf-8?B?SFFjMWwzZ2RFYmE2bjVBb0lZS0NRS2F2dXc0WktYTWg1R0ltYTJ6QjJNUjJz?=
 =?utf-8?B?NjU3V3Nsc1lyRDlWZDN4TkdCdThyaGk5a2RpcHFXaDZCa1JXeEpIVGowQThj?=
 =?utf-8?B?R0pxcHpMUFFsVEcyM0RXMUJOYjNyKzNWbXpPdTlwZFpaOE9nQk1DOXNRRi8w?=
 =?utf-8?B?SmhkdTBzZTJ2YWRNV3R6NVk1MVVSSXJVS291UFI3c3NUenNYQlBiT1l2bzlW?=
 =?utf-8?B?NUg0NWNydng4NzB6Wk1kcGpmUXpZakxkbXN1eC9NZ25nRmFLdHczVE12REdI?=
 =?utf-8?B?Y0JvKzYyd1JTK0FXRkhLbDFZb0xucFQwY0JMaXY3NE51WU1hTGd3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e4bbda-6e5d-4c9b-ea36-08de67bf807a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:42:12.4896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNQN2y2qdGzk2UBdobqz0YUsLPTIVQdDUJlKwhDutHZ6ERv7Gzwjj5v+SaLpdTuXCKZUdlHykxpUTlbi2jUTjj2G3obd0RWlNxyqfEdLSkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5198
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDksIDIwMjYgNTozNCBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdv
YXRlcg0KPiA8Y2xnQHJlZGhhdC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJt
QG5vbmdudS5vcmcNCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz47IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8
bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2Vs
IFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgVGhvbWFzDQo+IEh1dGggPHRodXRoQHJlZGhhdC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB0ZXN0cy9mdW5jdGlvbmFsOiBTcGxpdCBB
c3BlZWQgQVJNIHRlc3RzIGludG8NCj4gc2VwYXJhdGUgZmlsZXMNCj4gDQo+IEhlbGxvIEthbmUs
DQo+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLiBJIHdpbGwgZXh0ZW5kIHRoZSB0ZXN0
IGNhc2UgYXMgc3VnZ2VzdGVkLg0KPiA+DQo+ID4gSSBwbGFuIHRvIGltcGxlbWVudCB0aGUgT1RQ
IHZlcmlmaWNhdGlvbiBhdCB0aGUgVS1Cb290IHN0YWdlIHVzaW5nIHRoZQ0KPiA+IFUtQm9vdCBP
VFAgdG9vbCwgYXMgdGhpcyB3aWxsIHNpZ25pZmljYW50bHkgc3BlZWQgdXAgdGhlIHRlc3QNCj4g
PiBleGVjdXRpb24uIEhvd2V2ZXIsIGlmIHlvdSB3b3VsZCBwcmVmZXIgdGhlIHRlc3RpbmcgdG8g
YmUgZG9uZSBsYXRlciB3aXRoaW4NCj4gdGhlIEJNQyBMaW51eCBzdGFnZSwgcGxlYXNlIGxldCBt
ZSBrbm93Lg0KPiANCj4gSSB3b3VsZCBzYXkgdGhlIGZhc3RlciB0aGUgYmV0dGVyIGJ1dCBpZiB5
b3UgdGhpbmsgdGhhdCBjaGVja2luZyBmcm9tIFUtQm9vdA0KPiAqYW5kKiBmcm9tIExpbnV4IGlz
IHVzZWZ1bC4gTGV0J3MgaGF2ZSBib3RoLg0KPiANCj4gUGxlYXNlIHNlbmQgY2hhbmdlcyBvbiB0
b3Agb2YgdGhpcyBzZXJpZXMsIG9yIGFzcGVlZC1uZXh0Lg0KPiANCj4gUmV2aWV3cyBhcmUgd2Vs
Y29tZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMsDQoNCk5vIHByb2Js
ZW0uIEkgYWdyZWUgdGhhdCBoYXZpbmcgYm90aCBpcyBtb3JlIHJvYnVzdC4gSSB3aWxsIHVwZGF0
ZQ0KdGhlIHRlc3QgZmxvdyBhcyBmb2xsb3dzOg0KDQoxLiBCb290IHRvIFUtQm9vdCB0byBjaGFu
Z2UgdGhlIE9UUCBzZXR0aW5nLg0KMi4gQm9vdCB0byBMaW51eCB0byB2ZXJpZnkgdGhlIGNoYW5n
ZS4NCjMuIFJlYm9vdCBiYWNrIHRvIFUtQm9vdCB0byBwZXJmb3JtIGEgZmluYWwgdmVyaWZpY2F0
aW9uLg0KDQpUaGlzIHNob3VsZCBjb3ZlciB0aGUgdmFsaWRhdGlvbiBpbiBib3RoIHN0YWdlcyBh
bmQgZW5zdXJlIHRoZQ0Kc2V0dGluZ3MgcGVyc2lzdC4gSSdsbCBzdWJtaXQgdGhlIGNoYW5nZXMg
dG8gYXNwZWVkLW5leHQgc2hvcnRseS4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

