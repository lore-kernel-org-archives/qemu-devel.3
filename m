Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE74E9413E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 09:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWV3-00071r-S1; Tue, 30 Dec 2025 04:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vaWV0-00071H-5a; Tue, 30 Dec 2025 04:58:43 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vaWUx-0007Ni-QL; Tue, 30 Dec 2025 04:58:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlYmZrLyAHfSoBOPmicNeGq80DOVVDDlQxvp38xcofZitaoX5VMg12uR6LuQOXtvnnuB5zL2uiCJ6anqGBzjtCM+H0cYuCXqTMUbijHKx+N1xIcPn4YysYG3PPwEj9STCUr7dv+YbEL9oCkbQ1cqUHmIK6Nq9XPy3CqSsqnk7jAnx9LKZCGjCzBqfo1YXEA/R/lYnqEhpNLpwVntt4xS2TQAocUHtT1V9+0D9rVcwabjX1Eso1l7Gtmkq9QbxgVeiV9nJZd7IQLx1q6JNRJlNzi4V8dRb2RjUE6OSB369pFtBR0j19YZ+b594gwkr2l522mGSYQv4VS/c7FXiNkRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe7seFbwkRRXgNKORRDIHr/fR29ME+nm1osR/chIwXU=;
 b=TqCaO9m1aV55j7zwWlOEAu0QgGVr2ac89rBS5szFj/PKP85wIT8nzkPNnHY7K/rkHhWnyr1nizuioXSDIk62Ttffhf0LFS0E+zoVQ9/+jZzMAusXjhMoFkgeC/ng6jBIz1XA8f0XkcAZwP8XysWkOfRaqsdvQfsx8IweDPwD0wqzcoKGr48hnd4w8FdUea7HwInaX/slD9pVSpd5jds1nyoGSwZkhKSO95C791B743ih3Dgr5aiQCpaGPIG8z1hW0IH/4G+Atg0NvySvojlQUIeutQajEHbCGDU4LBvBDFO3DMsurnWvDLD32d4YUHQUV9V4pO2dpkfH7j7Ek5DdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe7seFbwkRRXgNKORRDIHr/fR29ME+nm1osR/chIwXU=;
 b=HpytRiPYEwsLiA6FPdKOizgrwcr8ytD2AVU6bp9CqCw/uz0iEsPE/FyiAj7K5XCqq52sLO9Gn5u1ZIGbMhoEiZkvFNuypZ6V6TJnXMEHGrNEf89737gIXKmoCT7t/eVICBFByAh9Ow7ail8fvCOfLl+dKZcENVf8KcUWckln5bxyh3732DJysmzAZVd8nA9JpuhwG1ghIm/UICnmvWMqMgy/I1yRVosbK2PqlGEu+suTbbeOsGB/UtpWLvFcJkFd7Vp+J01trLRDj8YH6nTKAeIN0H7vPchEIEGcdBtIu2fUMUlid5ywdMwKe3bgZfR8CDri3+wZgk4EMyXPkUjO2Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by JH0PR06MB6440.apcprd06.prod.outlook.com (2603:1096:990:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:58:31 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:58:31 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: RE: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
Thread-Topic: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
Thread-Index: AQHcdHaIPJRDnyY3FkGdWJIplrk53LUwn2CAgAKBWUCAAqkRgIACJL9wgACYuQCAAFaGgIAALfuAgABdY5A=
Date: Tue, 30 Dec 2025 09:58:31 +0000
Message-ID: <SI6PR06MB76312518466322BC6BD67DC5F7BCA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <465b0714-bd08-40b5-9cf9-5cd206e8548b@kaod.org>
 <SI6PR06MB76312852C6243B1F48202A89F7B0A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
 <SI6PR06MB76318E7A596008386B0AE51CF7BFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <ed07c0f2-737d-4d65-917f-d39d02c37063@kaod.org>
 <006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org>
 <CA+QoejXzjvyLA0Pp0xJjCsrwSyegSBRBs-MaT7yP41Nd2B9BcQ@mail.gmail.com>
In-Reply-To: <CA+QoejXzjvyLA0Pp0xJjCsrwSyegSBRBs-MaT7yP41Nd2B9BcQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|JH0PR06MB6440:EE_
x-ms-office365-filtering-correlation-id: c24b2e85-7b03-476b-c44d-08de4789fd19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Szc5b3Q3bERacEhTcGg1WGIycnlENFJzTHM2QkNJSms1OThDNkxNVWlka3Vt?=
 =?utf-8?B?TmVpN1BpcWNMWTN5NG5pYlJGZFFBblNBQ2NkRFFqV3ZlVTNLcFovdVZ3YmJE?=
 =?utf-8?B?MndwR05iM091N3M1b1RWR3prWlBFME1JMENoUzM3dDRDWFpTbm8rd21RcEdw?=
 =?utf-8?B?U3pLTGo4QlRxckRudkFJdU1GUFlHdzZaS1hLYk5NT3grQ1hyK24xSUc4NlNG?=
 =?utf-8?B?OVp4alVDV3E1aWhRWGc1Mlo1aVQwSUlQNGI5SWVwM1VWdURTVmFrSWkvTkRJ?=
 =?utf-8?B?ZHo1STI3Rk9BYnZDNzhoTGtZdWc0VVhUZjZjV3EzMUZxWTFmTGhKc2l3QWU3?=
 =?utf-8?B?cnIzV1ZJOEovS20wb0x6ZVRzWjJnZE5aZHNjRWRpMWNBcTNvMnpkNnVCN0Ju?=
 =?utf-8?B?VEg0dTFYUGc4bzBtLy8xMklWbGJNZTZwOUxKd0t6UE5iQlR6STZtR1ZmQnBN?=
 =?utf-8?B?a0hHOENNVkxOckJwR3FNTzFYNEJmUVRKTDUwRGhEdUo0L2RDSGpiaDFjT2dC?=
 =?utf-8?B?d1lvaGx1T3FyTy9KbCtZWVNaVEswZUVrNW1pd29qYXhub2ZpRTdXRTFZMUtP?=
 =?utf-8?B?c1Z2OTB2WWJXSVRTYkJPUnBqenVzcklGb0l6aldJYzdkRVFuOGN2Y0YwK0hp?=
 =?utf-8?B?dVB2ZVJoNlJGVlpoQklTWHYxUUNsa1J1ejh4N1JaMG5sclo1Q2xQK29Cd1VW?=
 =?utf-8?B?TERxZ05xVXh5dUhkWTB5NWNWZUNud2xQa05NWkRyMWNFRjhldDZqdXdYMzgy?=
 =?utf-8?B?T0lMeGxaOHJSOWdnOTN0cEkzazdWRjB5b0gra2p5a1NpYnVNbk03OCtRY0dF?=
 =?utf-8?B?a0tLU2FZWVBoa3dJZDN6MlVtRUdUVXcxYSt1UHJaNGp4RGdMTVFEUndvVHA2?=
 =?utf-8?B?QVBsWUFHMnI3WUNaangwekRLdTVEZ3BMK1BuMU1yV0RTU2xtRE5ZbWljeGhB?=
 =?utf-8?B?ZnZKdmhLL0dDb2FVTzkvcmFaOXVFUnNIOThOd2VqdTlmQXdxZ2tvQ0ZTTng2?=
 =?utf-8?B?NmtzTFF0UXhUbHZvbWJQdDRMbm13bndHVVRhZ1h3VngrU1NkL0FrYmVxR1pi?=
 =?utf-8?B?MkJjamFwYzY1UUp6ak5ZK2JQWHBGb1VmQ1daeU9qTTNaU0krWFNjUytueGl1?=
 =?utf-8?B?bkR2WVY5STYwbUNQYUJqd1FaZnRRUmlkRTBkaWF1UHdMNHdwVkY4aVg5ZWNw?=
 =?utf-8?B?eGx3akpyUW9kYUh5R240ZXd5UUlWcFhLKzgyZmN3MXZCbVBWLzlDQkNlbDZH?=
 =?utf-8?B?VEhEZVljYkZCc2JXSmhVTmZDR1BqRkRkL0ZPNmhtZ2pIVHl5TEZ1WHBqYlI4?=
 =?utf-8?B?eU91NmNCanJ3ZXVkbzhVWW5BMk1DSndBalhRWHFFVU5KUnNKbG1rcmdBOFN4?=
 =?utf-8?B?cW9DZXVPMXplK3locDRWRmUraDB0emRPN1QycWQ0OGdkS0NEMTZlVStBWlNr?=
 =?utf-8?B?SXlHTm1iNVhidjRlSFh2Z1lpUHg5RUtWY3VMUmsvZ3FwM29KVm81cFBVby9R?=
 =?utf-8?B?S09sUVB2OGxnNGpNeEJMYUpnZHAraTN0djdrSndXeldpZ0h6Yi9KYzRqdlhn?=
 =?utf-8?B?c2J4MytIOEFvdFNrSDJLWU1ISEFsQmI0Z1ErLytyTi96K3VtRkZjS0FZelFC?=
 =?utf-8?B?V0NUczdlQzZFN2RoalM1bVBIK0J5azBJOXUyaFFjWGZiQWUzc3UyMTlXOXIy?=
 =?utf-8?B?eEwyZEtlUlRaejA0OThzWW1LMWhSN2swUkVETElmYVVERkU2Q241dm1ZcHdl?=
 =?utf-8?B?cTArQUl6NU9Pd3dxYnlRbzZwL3BRcXRRNCtOREU2U1N1ZE9BclRvdXF4TndK?=
 =?utf-8?B?TUJwY0c3VEE2QUFBa1I3WTVjY0dtVmR1OE0xcXk5Mk0wUDlxNEpNY1VXb0My?=
 =?utf-8?B?OS9vbUNicW5oNk9OR2xwZHJXMDNTTVdjdmk5OW02Z2o0MmJkcUR2bU9PVHBo?=
 =?utf-8?B?VVRkb0NWeEhKeElZdGxpUTY5WDlnVWUyN1lmblB4eG41ZjRUcDNTbjJjMWtC?=
 =?utf-8?B?OUQxb0oxL01NbW9XQkI5RkJDQndWTkF1blBaOXdFNHJxa05JZ2I4MXkvdUlB?=
 =?utf-8?Q?XrQADZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejdNVGJuR1J0UkVBUFE0dWJaYTJiYmJ1QlJtL3llMVVPZTF1K2ljekZmTW1t?=
 =?utf-8?B?MExIakQrSDh6ejBDNFJJbjZESFBqeXUrSkZTVzhkRUtydllFWHpGNFFhcjFB?=
 =?utf-8?B?QmtUK3JPNDQwMHF0cjd5MWN6Njd0bnNTcjNyZFdFaktQSWswYng2Z1NRMVBq?=
 =?utf-8?B?ZzRNQlppblJDLzcvanRoUWVZalE4M1NsSE4vR1loSEtQWGJMQWw5eHpiRkMw?=
 =?utf-8?B?WEwxVXg3eFc1Q2VMdndkRzlwL2lucU9IQ1VYWTJCc25IM09sMEtxWkVQUVhj?=
 =?utf-8?B?M2dGRUxsbkhzOGY0cXlpR2dhelFtSmNFUXVPZklmeXpieS9RT0dRTzZ5bUxj?=
 =?utf-8?B?cnNKSXBhZkw1T0JMVisyZjhCR1FvZ3pSOVhuOFVjZ0IwQXBDa2ZDT2tlcVBS?=
 =?utf-8?B?Slg1cEZhS3d2NmsxT2QrZEZTVSs1TlV3L3pwWGd4OWNFWC8zSGZNRUVESzFO?=
 =?utf-8?B?YmMwVlNhQ053cUd0K21KUktidVhjVnpHUFc2cjZkaVpsaWs3TUJpcFJXR09u?=
 =?utf-8?B?Y2pPRTVjOU9CaDhzdStrYm9SNTc0L1RDNkE4VEdZdDdjUjZ6OWZDS3MyT1FM?=
 =?utf-8?B?WVNVRDRSMDV0Uk5oVVhTZjNyWFZDd3ZPVzVFRGdTR1hySmd4YmVFQjZ3a0pa?=
 =?utf-8?B?bUhvYnVocUp3bWJ0WTdkWHk2Z1ltQVl1UWovTG5GMjQzOXhwZXdZUHo0V1hk?=
 =?utf-8?B?c2NCbHcyN1hwNXIwZm5QNWFkNGF0MTg4Q3I4SkhTUXM4Z1NOUjF5cG9EMThE?=
 =?utf-8?B?bWQ2ZHhRMWx4azFOMDJZTjR0dUgyWmkwUkFjbnJBd3hQRUJ3aG5UME5nMUlB?=
 =?utf-8?B?T2NDdlVQb0tGOWx5NXBDZGl0amxmdVc4bmpGdnZRTzV3MmJiYkYzb2dIeU8w?=
 =?utf-8?B?cGVjaGpOT0tKdFZJTkRTUCtyNGROcUVjSDQvOXJnc0llK3AyU2Z1RVc4S0lP?=
 =?utf-8?B?R2JHcDNoMzNkTWlFd2wrK2FiU09xNms1ZFVJaCtrQ1dpTkk5RUN0K0o0Nmpm?=
 =?utf-8?B?ZElvR0VTcmlYbXhxNDBXMGZkeUgvalRKU0dQNHpqSDR1aGM1UUhYV0dYcTE3?=
 =?utf-8?B?VCtJUThTdkx1NjlPWDB6SGVrVFZTYXpYOGRrTXRla3MzQ1R6cXRuMzZISlkw?=
 =?utf-8?B?VEtZaUJRRFRlb2kzSUZPdE5wZnhrR1ZHZXg5ZWdzbGpyeXpvdDlIelEzaEUr?=
 =?utf-8?B?aFpLUjd6ZGEvdDRUWlRaOGZQbGZLV2Z2YVJEZzNpNUovSW9MUlhJbjFIK1Bh?=
 =?utf-8?B?dnRZbmM5RExubWJsajRQWWxEaWtoazd5czE3dVk5N2FSM1NrOE1uY2Q5bUZW?=
 =?utf-8?B?SXA3VkFlZkc2LzFyWmJHWk5MMW5SQndiNnBIMjllM3NsazQ1cjc1ZkxlTTZL?=
 =?utf-8?B?SGtHc2dmbzFJcXByVFFGaGJPZnppdGxlY2FIcFpBTkFsMnA4ZHJaWUJtVWRn?=
 =?utf-8?B?R1pHYUlyVzZCZFQ5WE5OeHhQM2JYMjlYNWg0TWF2Ni8zZ0UvRXAxYWNQVld5?=
 =?utf-8?B?V3hvb3E3bnhpZEZBSlhWTjdBTHgyeFlpd2ZZeGRlWFhtWC9ZbXFpZDl1OFNi?=
 =?utf-8?B?YUZmUnkwMVZkRGlzNjNOdWNEQnh0YnVuZDNWdWFIOGNLaHkxRURYSjIyNUJR?=
 =?utf-8?B?WVZTalF6KzJxTTUrOTMvTXVMWkkyOEFLbXFYMGlWQmdnKzhMd0p0bFhRYWwv?=
 =?utf-8?B?eG5zOVBmTkp2TXFEYjZLcitzWFlXYWJ0eWtDT1UxNjJOcTFoVDhsbVdNcmhJ?=
 =?utf-8?B?eERwSmFVeGVXcWt0ZUM5WUNnNWNKTUl1VmxmaWNPM2pRTzhENW04T0dlZHJ4?=
 =?utf-8?B?b2psRWlrYzI2VGxFTEZZSkdKOHBiQ0xTald3YlNMQ1ZaOWtYWSsyK1NkajR2?=
 =?utf-8?B?ZGMwMFVVSFRZRFJDNzdXaFp5cXhEWDdEdVFBK3BFUFEvMEtQL0FCV1RKOC9p?=
 =?utf-8?B?U1VqL1RFTFhBVkxCZDJobEo0Q2dtYzhHbmFpSkJHRms2WktSdi82MkUrSjB4?=
 =?utf-8?B?VGRTUE1PUm50SjlHbWtPNDRxQ2YyODk2REtjSy83VnhmR0xWNmUvZG9xc1JF?=
 =?utf-8?B?Z0ZaNHJWMmRoMnVYUWwvUW9BSWRZOFpSNDlPVTd5ZitvR1Y0dHRPNFB4R2tM?=
 =?utf-8?B?ZXplOFVSTElOTEk0OTZkNndFZ0hSUzVLRjlPN0JoWTFud215SlorNk9NTkJG?=
 =?utf-8?B?YVJPb09nUk5aYmZkSlhiSlMwOVpQM1BtTFltQVdEWm5XSjB1WHptTCtBQWp6?=
 =?utf-8?B?ZFA3d2tKNW9hbElTSk5yR2JtL0JXNWJqVVRFWGVFL2wxR0wzRkFQZ2NlN1Uv?=
 =?utf-8?B?TGVTVVFQOUJOZFdFWTJhdHR6ektEa3JvOWhNWEVPU2tDOXpRUVYwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24b2e85-7b03-476b-c44d-08de4789fd19
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:58:31.5357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qr1de7B4NDfzZq5c/cnBAoGSeDYugba/IWqdrX/irV2+GKpLoH/3fb8KnkccM74ZGcskuwh5XZieqM0vebmVGWJktzuw6tfd1Ivk+IG/0Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6440
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYWJpaCBFc3RlZmFuIDxuYWJp
aGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMzAsIDIwMjUg
MzozNiBBTQ0KPiBUbzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gQ2M6IEth
bmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5f
bGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3Ry
dWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBvcGVuIGxpc3Q6
QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMg
Q0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgVHJveSBMZWUgPHRyb3lfbGVlQGFz
cGVlZHRlY2guY29tPjsNCj4gUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzE5XSBody9hcm0vYXNwZWVkOiBJbnRl
Z3JhdGUgaW50ZXJydXB0IGNvbnRyb2xsZXINCj4gZm9yIEFTVDE3MDANCj4gDQo+IE9uIE1vbiwg
RGVjIDI5LCAyMDI1IGF0IDg6NTHigK9BTSBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3Jn
PiB3cm90ZToNCj4gPg0KPiA+ICtwaGlsDQo+ID4NCj4gPiBPbiAxMi8yOS8yNSAxMjo0MSwgQ8Op
ZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4gPiBPbiAxMi8yOS8yNSAxMTowMCwgS2FuZSBDaGVu
IHdyb3RlOg0KPiA+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4+PiBGcm9t
OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+ID4+PiBTZW50OiBTdW5kYXks
IERlY2VtYmVyIDI4LCAyMDI1IDE6NTEgQU0NCj4gPiA+Pj4gVG86IEthbmUgQ2hlbiA8a2FuZV9j
aGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA+ID4+PiA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA+ID4+PiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluDQo+ID4gPj4+IExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4gPiA+Pj4gPGFuZHJl
d0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBv
cGVuDQo+ID4gPj4+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVu
IGxpc3Q6QWxsIHBhdGNoZXMgQ0MNCj4gPiA+Pj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3Jn
Pg0KPiA+ID4+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgbmFiaWhl
c3RlZmFuQGdvb2dsZS5jb20NCj4gPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8xOV0g
aHcvYXJtL2FzcGVlZDogSW50ZWdyYXRlIGludGVycnVwdA0KPiA+ID4+PiBjb250cm9sbGVyIGZv
ciBBU1QxNzAwDQo+ID4gPj4+DQo+ID4gPj4+IEhlbGxvIEthbmUsDQo+ID4gPj4+DQo+ID4gPj4+
PiBUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLiBTaW5jZSBJIG5lZWQgdG8gc3VibWl0IGEg
djUgcGF0Y2gNCj4gPiA+Pj4+IHRvIHNwbGl0IHRoZSBJMkMgY29kZSBjaGFuZ2VzIGFueXdheSwN
Cj4gPiA+Pj4NCj4gPiA+Pj4gQ2FuIHlvdSBwbGVhc2UgaW50cm9kdWNlIHRoZSBidXMgbGFiZWwg
cHJvcGVydHkgYXQgdGhlIGVuZCBvZiB0aGUgcGF0Y2gNCj4gc2VyaWVzID8NCj4gPiA+Pj4gUGxl
YXNlIGNvbnNpZGVyIGFkZGluZyBhIGZ1bmN0aW9uYWwgdGVzdCBhbmQgdXBkYXRpbmcgdGhlIGRv
Y3VtZW50YXRpb24NCj4gdG9vLg0KPiA+ID4+Pg0KPiA+ID4+Pj4gSSB3aWxsIGhhbmRsZSB0aGUg
bmFtaW5nIGFkanVzdG1lbnRzIGFuZCBvdGhlciBtaW5vciBmaXhlcyBteXNlbGYNCj4gPiA+Pj4+
IGluIHRoYXQgdmVyc2lvbi4NCj4gPiA+Pj4NCj4gPiA+Pj4gVGhhbmtzLA0KPiA+ID4+Pg0KPiA+
ID4+PiBDLg0KPiA+ID4+DQo+ID4gPj4gSGkgQ8OpZHJpYywNCj4gPiA+Pg0KPiA+ID4+IElmIEkg
bW92ZSB0aGUgYnVzIGxhYmVsIHByb3BlcnR5IHRvIHRoZSBlbmQgb2YgdGhpcyBwYXRjaCBzZXJp
ZXMsDQo+ID4gPj4gaXQgd2lsbCB0cmlnZ2VyIGEgdGVzdCBmYWlsdXJlIGluIHRoZSBjdXJyZW50
IHBhdGNoIHNlcmllcy4NCj4gPiA+DQo+ID4gPiBXaGljaCB0ZXN0ID8NCj4gPiA+DQo+ID4gPj4g
VG8gYXZvaWQgdGhpcywgSSBwbGFuIHRvIG1vdmUgdGhlIGJ1cyBsYWJlbCBjaGFuZ2VzIGludG8g
YSBzZXBhcmF0ZQ0KPiA+ID4+IHBhdGNoIHNlcmllcyBhbmQgc3VibWl0IGl0IGJlZm9yZSB0aGUg
QVNUMTcwMCBzZXJpZXMuIEkgYmVsaWV2ZQ0KPiA+ID4+IHRoaXMgYXBwcm9hY2ggZW5zdXJlcyBi
b3RoIHNlcmllcyBwYXNzIHRoZSB0ZXN0cyBwcm9wZXJseS4NCj4gPiA+PiBXaGF0IGFyZSB5b3Vy
IHRob3VnaHRzIG9uIHRoaXM/DQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3Rh
bmQgdGhlIGlzc3VlIGZpcnN0Lg0KPiA+IEkgc2VlLg0KPiA+DQo+ID4gVGhlIEFTVDI3MDAgZnVu
Y3Rpb25hbCB0ZXN0cyBmYWlsIDoNCj4gPg0KPiA+ICAgICAgICAgc2VsZi52bS5hZGRfYXJncygn
LWRldmljZScsDQo+ID4NCj4gPiAndG1wMTA1LGJ1cz1hc3BlZWQuaTJjLmJ1cy4xLGFkZHJlc3M9
MHg0ZCxpZD10bXAtdGVzdCcpDQo+ID4NCj4gPiBUaGUgImJ1cyBsYWJlbCIgcHJvcG9zYWwgcmVu
YW1lcyB0aGUgSU8gZXhwYW5kZXIgSTJDIGJ1c2VzICgzMikgdG8NCj4gPiBhdm9pZCB0aGUgbmFt
ZSBjb25mbGljdHMgOg0KPiA+DQo+ID4gICAgICAgICAgICAvYXNwZWVkLmlvZXhwMC5pMmMuYnVz
LjAgKGkyYy1idXMpDQo+ID4gICAgICAgICAgICAuLi4NCj4gPiAgICAgICAgICAgIC9hc3BlZWQu
aW9leHAwLmkyYy5idXMuMTUgKGkyYy1idXMpDQo+ID4NCj4gPiAgICAgICAgICAgIC9hc3BlZWQu
aW9leHAxLmkyYy5idXMuMCAoaTJjLWJ1cykNCj4gPiAgICAgICAgICAgIC4uLg0KPiA+ICAgICAg
ICAgICAgL2FzcGVlZC5pb2V4cDEuaTJjLmJ1cy4xNSAoaTJjLWJ1cykNCj4gPg0KPiA+IFNpbmNl
IHRoaXMgd2lsbCBiZSBleHBvc2VkIGluIHRoZSB1c2VyIEFQSSwgaXQgd291bGQgYmUgYmVzdCB0
byBhdm9pZA0KPiA+IGludHJvZHVjaW5nIHBvb3JseSBjaG9zZW4gbmFtZXMuIEhhdmluZyBzbyBt
YW55IEkyQyBidXNlcyAoNDgpIGluIGENCj4gPiBzaW5nbGUgbWFjaGluZSBpcyBzb21ld2hhdCBu
ZXcgaW4gUUVNVSBhbmQgSSBhbSBub3QgYXdhcmUgb2YgYW55DQo+ID4gbmFtaW5nIGNvbnZlbnRp
b24gZm9yIHRoaXMuDQo+ID4NCj4gPiBNYXkgYmUgb3RoZXJzIGRvID8NCj4gPg0KPiA+IFRoYW5r
cywNCj4gPg0KPiA+IEMuDQo+IA0KPiBJJ20gbm90IGF3YXJlIG9mIGFueSBjb252ZW50aW9uLCBi
dXQgSSdkIGFyZ3VlIHRoZSBjdXJyZW50IG5hbWluZyB3aXRoIHRoZSBidXMNCj4gbGFiZWwgbWFr
ZXMgc2Vuc2UuIEEgaTJjIGJ1cyBvbiB0aGUgbWFpbiBtYWNoaW5lIGlzICJhc3BlZWQuaTJjLmJ1
cy4lZCINCj4gd2hpY2ggY2xlYXJseSBtYWtlcyBpdCBlYXN5IHRvIGRpZmZlcmVuY2lhdGUgYnV0
IHNlZSB0aGF0IHRoZSB0d28gYnVzc2VzIGFyZQ0KPiBzb21laG93IHJlbGF0ZWQuIE1heWJlIGl0
J2QgYmUgd29ydGggY2hhbmdpbmcgdGhlIGBhc3BlZWRfaTJjX2NsYXNzX2luaXRgIHRvDQo+IG1h
a2UgdGhpcyByZWxhdGlvbiBtb3JlIG9idmlvdXMgYnkgbm90IHVzaW5nIFRZUEVfQVNQRUVEX0ky
Q19CVVMgYnV0IHVzZQ0KPiB0aGUgc3RyaW5nIGV4cGxpY2l0bHk/DQo+IA0KPiBUaGFua3MsDQo+
IE5hYmloDQoNCkhpIEPDqWRyaWMsDQoNClRoYW5rcyBmb3IgdGhlIGFkZGl0aW9uYWwgaW5mb3Jt
YXRpb24uDQoNCkhpIGFsbCwNCg0KQ3VycmVudGx5LCB0aHJlZSBkZXZpY2VzIGluIG91ciBzZXR1
cCBzdXBwb3J0IEkyQy4NCjEuIEJNQw0KMi4gSU8gZXhwYW5kZXIgMQ0KMy4gSU8gZXhwYW5kZXIg
Mg0KDQpFYWNoIGRldmljZSBzdXBwb3J0cyAxNiBJMkMgYnVzZXMsIGFuZCB0aGUgYnVzIGluZGlj
ZXMgZm9yIGVhY2ggZGV2aWNlIGFsbCBzdGFydA0KZnJvbSAwLiBUaGlzIGxlYWRzIHRvIG5hbWlu
ZyBjb25mbGljdHMgdW5kZXIgdGhlIGN1cnJlbnQgbmFtaW5nIGNvbnZlbnRpb24uIFdoaWxlDQp3
ZSBjb3VsZCBleHRlbmQgdGhlIGJ1cyBJRHMgZnJvbSAxNiB0byA0NywgZG9pbmcgc28gd291bGQg
cmVxdWlyZSBzaWduaWZpY2FudCBjb2RlDQpjaGFuZ2VzIHRvIGhhbmRsZSBkaWZmZXJlbnQgSUQg
cmFuZ2VzLCBtYWtpbmcgdGhlIGNvZGUgaGFyZGVyIHRvIG1haW50YWluLg0KDQpUaGVyZWZvcmUs
IEkgYmVsaWV2ZSB1c2luZyByZWFkYWJsZSBidXMgbGFiZWxzIHdvdWxkIGJlIG1vcmUgaW50dWl0
aXZlIGZvciB0aGUgdXNlciBBUEkuDQpJZiB0aGVyZSBhcmUgYW55IGV4aXN0aW5nIGNvbnZlbnRp
b25zIGZvciB0aGlzIHVzZSBjYXNlIG9yIGlmIHlvdSBoYXZlIGFueSBjb25jZXJucw0KcmVnYXJk
aW5nIHRoZSB1c2Ugb2YgYnVzIGxhYmVscywgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpCZXN0IFJl
Z2FyZHMsDQpLYW5lDQo=

