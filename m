Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CBBCD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMd4y-0006iu-EG; Mon, 11 May 2026 22:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMd4v-0006iN-9e; Mon, 11 May 2026 22:42:37 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMd4s-0002Nq-VJ; Mon, 11 May 2026 22:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh/KO9C1pMuhQnw2uFj0aBUmk994/0UAiP814gmK2M9m5CF4s4z+W/0DeOdhjOWmiSVo2zItqHESmfJb2kBADlBNknUtsA5GC41Zt/KkQZA22to4flIiJ1gb0SLLwkejCAPcjo8kgJ9lhJEK3/R+fqgm5I1T5Oq+/3YM0B5PULdxrxw7VOrZGpf44FWmi837Qpe9AEFp/CN1rp52wYJEHzIoic66kq5QzCDgBWtiZJaLG6zfSAtNfQouPNdsTLoy5kbXEY+8np54cfautOvoYdx9v5xf6L8xQweqyzIKcaDL2H2zw/W7OmaO7+kAjaIaQBi/9aGqSvp46Yz6gqdPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EmI9WjkJljrocyAKaj11ayvWXi28MdoYPqdECOFt+8=;
 b=pWoZknFVzJw+9C9/xTuRf6oxytEE1DrynCNkmvn3Trl64RGJqFdX4L1iFkOBfqDCvE0JE9aTzJje/XBbr288d3L9Cya3bACiNTksoBEBgER/hPGSAQ6MVDYHOKr0xOr9Nf1c7jR/56EBV12Hj+Lyb8Q+yTKYCaKv9xV8GvWyv8+VHZx1mPS7qujJ+OR2X7uc6CwwND8EsClOFgfdlkAdWEnl3j+nlxFtfTsb3VgmXplNrm9Y4K581PCMxP9EPtjB+KiCKDEoQ9JFDkoYgLSiu221t2ab81V5EC4Qc7eFwBs4Z2BUbgA7FUx4j/9ZrEtz1JcU8grro2Bk+zIF0gswnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EmI9WjkJljrocyAKaj11ayvWXi28MdoYPqdECOFt+8=;
 b=QDV6BMbs9IfFgmQpfnd38G9f7Qt/0yhczD/BAmzIhwgBFKVLN+BvFmgdg33nY6HGwlb6uCxwVVq50eXZVC/yTSmeRhj0xNGLx4XZVznh6cFcIbvRbY9uKBfYvbMmMTlBcNOg+DzuCnzEwlhe4bHYjkwUxsr22JfUHfgkCooWo4or0tGQw/71KjPP6NbHG/lydeE8Kl15rbzP6c76XEsdRrkDXArDe7bUTjnz6wfqBUl5W85RXahFRrljKsUUwhVkDsskgMmgS6OE63QonjIbmVjVENOG1PptZNl5cBuDDNowwGsynjE59m/GRX1F8yJFOg5qVnc7ll9ltQ5kJ803ng==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6448.apcprd06.prod.outlook.com (2603:1096:820:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 02:42:20 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 02:42:19 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Topic: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc3qnPl3aK51F7Y0aXhHDUgxk26LYIf7+AgAAZCKA=
Date: Tue, 12 May 2026 02:42:19 +0000
Message-ID: <SI6PR06MB76319014B83F4B0E7F0FB756F7392@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
 <20260508051619.3887383-2-kane_chen@aspeedtech.com>
 <341d0267-cb81-4612-99d1-c1edd5a395dd@kaod.org>
In-Reply-To: <341d0267-cb81-4612-99d1-c1edd5a395dd@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6448:EE_
x-ms-office365-filtering-correlation-id: 826c3b7e-3233-4f3b-f39c-08deafd0168b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 0+5pUEkTrIlAG5XGcvrRQwZegkhWKJRNI9Vp7+zsusORh9NtCLvXgYqkkxkTTYLX7hG1bgH2gZ7ys8Jp6aFiRMu6ndO2mqLfRpOO78CcYE6VURoOUBC+YemxC4K9Ww6RhNPKKsxwkMd8/E5DAQyYUikFSOGEGC1xSPoDBJLqBCdu25EXgUrQV1tGu029T/AgL5bTKJqP7ESPXJtgU6Sd9jmFXNF0MXmff+jdZtgWLj7vUHk86Bq4ZRrNFjjWjGjt/gcm+pIgbPdPOkdLoZrUQIqDgXbS4UxIBDGz9NuyKjOigcAw7lFtWJppz7NotRpLye3VcljwQireyqv9k4gARBM82/o0lVLDys/+OuDO+meMa+uN2ynOEzhnKA0V4C29VEWBsojE42d7NV5QdF1t46LOeBYgouOwwjB1bKvTvnvSbuz9rCNH2/RQvO8YHsDid8lokOjCR+GR3AfGJLsJ1uQc6WfYN8xYQmw9UMGzwlsH+uIwwkPYpQ+PMYjQgQySqRMagy9svDeXDzJv29k7pjgt1IxVzg4wMLwSM+57GCZOICagkLgfWWbPl2Onus5grRxS+0FRLcnbCBR/Kn//T0guVXUhgb1aPuvdBWVPTJXnbiYwkVYQe9NguZwAsm8JsCxk8iXstSBsQ1lSgRpSYbHlaLeZi6VeWy3b2RhsUrwKjxxmoOLWadNiTYIHkDm6nf1U6lF9/1/3eU3u3U7dw8FUEVBqJbEg9/Xgl6SpiIoYy0yLIOYVFwRaGbOpWgeK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2xuQmR5ODFYZGl3L1d6UzFtNkdlb1NIaXJza0NXcXVqVE9lb3lYa25UbC9G?=
 =?utf-8?B?SXRZTTM0WDRBMjlRdkZOdkQ2RzlEdndzZzBZZUozOXMxNkNzSmFBT0krNDRk?=
 =?utf-8?B?TDFJTTlzUVFSOHdGVEVVQXgvTkJQYlVWRHhHYTJ0TG9LZkZNbnVGS253L203?=
 =?utf-8?B?Q2l1L0puNXR3cm04NDhVeFhld09tanBMVU03TENjL0g4bllhdHdxVnZlTmd0?=
 =?utf-8?B?cUpZM1poRmZJS1pyNnZyUVp5TlArd09QMUNLdTlHQmZjR3lKRUJyWUJLWE1m?=
 =?utf-8?B?SFR6Yml4a1gwS0IwVXhhTjRFUllpVU5wbmRwTHdRaXNJMjJxOGhFWUZoS2I0?=
 =?utf-8?B?cTFtM2F2bUhlSXAzMUVmK1F5V2I1aDNGa0RVTDFjT21XZGduRVljdGtiU1dV?=
 =?utf-8?B?WXFDeGZSU3BTUERiRnppam1xRFYrYzliQnEreEhqTmZLaHdaWS9Ib2tYVTZL?=
 =?utf-8?B?ZCtGSnNqTXRhVWVjR3JSUkpaMGNmM2NlT0dla3RsYWdLcXVvUm1wcDhyUHVx?=
 =?utf-8?B?OGdIUHRFMjZhY0h6T1ZYZXpzbnJtcHRORS82dHN5TUFNcS9tb3lxM1Y2bGhq?=
 =?utf-8?B?UjVQSExxZm1ObkI4blRRVUJSSkFmTG51cWRHWFFXQnVtSk1JMzRZU2VsNnNG?=
 =?utf-8?B?MXJaQzhROW56Zk9XZ2t0WFd0WjdhYXl3M0NXVFFuQnJSOXlRM1hySUdJaVY1?=
 =?utf-8?B?em9odm5TUHQ1bHRRREdaNmVwc1gvNjJFY21wbU9VWVpJK2lLUnExS2FPUG5v?=
 =?utf-8?B?T1J2eGgyWmltamlBTVdGcHhuUFFod21ZTHZQMlI4VEZudktJK2tXZGxLRGR2?=
 =?utf-8?B?VS8wR1NBSkdGUnkrYmlSMGMxcWo1ZUlSL0Ivb25nSU9IcThxbGRZV1Fqd0FB?=
 =?utf-8?B?Ni9KbzROMjNaYWdDTmVZN0JEbnRxTkp2ZW5YWm1LcEtqOWVFeEJDejZGaDh5?=
 =?utf-8?B?OEx3WDFKK1dzWVZISSthOGlNRHFCMkJ6TjFFbFNjcEJDQzVUcndxV2F6aWVq?=
 =?utf-8?B?bkVtak9kd1RXejhuTnp1Vnl3bGg4ZnVqcmxKM2FXTHlvWCttMlB6UVdlYTVX?=
 =?utf-8?B?NkxobkZQcUtxeGNRZ0dTMjRJc1RxdDRsNnF1MkhLbFJmSUs3N0dTcTNtWC8r?=
 =?utf-8?B?UzBLMmdmOTc5QzBteHpjUnJJc0FoNEFxN3ZQS284dk40bUp1YWNHRjJRdk85?=
 =?utf-8?B?Q3dwb3IyVEVVSDVvSXJWRjMraTR5b29jTmcyc21NTTlHRnVuZEFhYk1UMjBn?=
 =?utf-8?B?RFJFYlkrZzFGVFRkSm1oM3lMd0dEOCt3Vndsd0tHSGx0ZFdVYXJ3Ti9QUlBD?=
 =?utf-8?B?M2t3ZDhBcFF4KzRXUWw3bjJ2b0VsRDhXY3RNL0N1TUZCQlk2TWRtMzRNaEsw?=
 =?utf-8?B?TDRIWXVsRGVQSWhpZDdDZzB3TXYvVWNpNVBuY3cwS25qZ25OTG9ia2M5bXZQ?=
 =?utf-8?B?bG5uYTRZenJQMm9FWk5saTZUY3I3a0RqeVBla3NBZ3FrcThZektqQi81L3ln?=
 =?utf-8?B?cmhnSW8vUGlhNE13T09LNzNvL2VkOGNtYUk0QUxXR3dQZ2dFUjlWellvelFL?=
 =?utf-8?B?YWt1dVg1RGFnem05d2VLUGVCeXpaWEVSRlQzY0pJMi9uT1J4NVRVdUs0K1V5?=
 =?utf-8?B?ZE1Hb3FDakt2ZklaRmd0empsd3VVT0RBMWwzY2NXVnErVnRsNGhWT0hIT0tl?=
 =?utf-8?B?L2R0Z0ltU1J1VEF6VXBaVDFQZXRSM1FPK1A5ajNWZHpzVUN3a1NCMHlKT3JD?=
 =?utf-8?B?MUluaWxRVDA5NkdHcmxzQ3VscHZZeWFmM0FSUGN0TVJQMEdHUU9vQmVvV3NP?=
 =?utf-8?B?ckEzNGtMdE9XejQyRHR3KzhpSXJKSjNuZzBmbWZqOG5NTGVlU1ZORFQ3NTRa?=
 =?utf-8?B?SUVPekxFdjdHQzRsVENXRTV4Y3dOeXp0ajg1ZTlLVFRodVpUbGlSME1DVlBz?=
 =?utf-8?B?Nzc4NjJ0MEtEZGY2dUhlOUM4ZVJlU0tPdk9xcUFnYU5ZemRsK0EzSC92VTlM?=
 =?utf-8?B?UC9kN0J5eThnMXoweTJUMmZRSVJIUHE1QzlVcXhyTkVaZzdEVUVFNmJyL0w3?=
 =?utf-8?B?R3pmdUU0V2s0aFZPQ0NzQWRPNk5iaHZOVk9Sdms3Qmw4RWdVNjVOOUI3T29G?=
 =?utf-8?B?MTVORFVpL3ptR2VDTHlKZm9vTjZrdHhQUW16S1lzL2xjc3J3THJ2YzRBU2E1?=
 =?utf-8?B?MXFMdklNWmVEY3JuRE4rb0FKVDEvNDlTa1FoYTAyV2s1N29aY1RIOW1IZTll?=
 =?utf-8?B?RW4rejR2NjhyRzFqMEtyejhBS24zTXhwbjBsenl6WGtEUHdMYUE5ZHlvYmhi?=
 =?utf-8?B?SXJ0ODFvemxDczNHOW9iai9TZ0dtQmN3V0c1TWh1K2VzbHNXVUNJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MIJ0TZGdgZUCA3GAvAIO1HETCaEONsB0s/3PmlTU8shLHvuusphzedt+gxEdvlQg5SUS1B8iYlKIQghqK5bM2767glks11I1AfdsCEo0JNzEAKBM6s92lZSgwqgFXs5GsL+G9dNFM3DV23i6ju/5i/rtbVt+AvX/wC15R+3L+Zl+yufxij3HzFkK2Q/tQWfUuVXnb/JBjQWpibO/rUF+mqeK2RUqa8ReAaRlteJpsRD4vyZIvjmGOnDiwu5NrWsbov2PV0rTNHpGiB0fvNy8xFNqQDGooAc8q2SmQO8ZuqHig3bsG70mSNyn8lX68nPjyBcF/VjS8VNkpj4xchc0Ig==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c3b7e-3233-4f3b-f39c-08deafd0168b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 02:42:19.9333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgD3BpkDZTY0cMUUMUCzpwRQd+TkkOL2jgEnLJooCH6k9qaGrs1Ds9MZ0PMoRqsbAmpxTDBdK9qEE0HVbWIXQuF6wWEpklH+ypTae9nM5mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6448
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSAxMSwgMjAyNiA0OjE3IFBNDQo+IFRv
OiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4g
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVk
dGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNv
bnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBs
aXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRj
aGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0
cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIGFz
cGVlZC9oYWNlOiBGaXggbWFwcGVkIGFkZHJlc3MgbWF5IG5vdCBiZQ0KPiB1bm1hcHBlZCBpc3N1
ZQ0KPiANCj4gT24gNS84LzI2IDA3OjE2LCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gSW4gdGhlIGRv
X2hhc2hfb3BlcmF0aW9uLCB0aGUgY29kZSBtYXkgYmUgcmV0dXJuZWQgZWFybGllciBiZWNhdXNl
DQo+ID4gaGFzaF9wcmVwYXJlX3NnX2lvdiBvciBoYXNoX3ByZXBhcmVfZGlyZWN0X2lvdiBtYXkg
cmV0dXJuIGEgZmFpbHVyZS4NCj4gPiBXaGVuIHRoaXMgY29uZGl0aW9uIGlzIGhhcHBlbmVkLCBj
dXJyZW50IGNvZGUgZmxvdyBkb2Vzbid0IGdvIHRocm91Z2gNCj4gPiBsYXRlciBjb2RlIHNlZ21l
bnRzLiBGaW5hbGx5LCBpdCBjYXVzZXMgdGhlIG1hcHBlZCBhZGRyZXNzIGlzbid0DQo+ID4gdW5t
YXBwZWQgcHJvcGVybHkuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBpcyBpbnRlbmRlZCB0byB1bm1h
cCB0aGUgbWFwcGVkIGFkZHJlc3MgaWYgdGhlcmUgaXMgYW55DQo+ID4gZXJyb3IgaXMgb2NjdXJy
ZWQuIFRodXMsIGl0IGNvdWxkIHByZXZlbnQgYSByZWFzb3VyZSBsZWFrIHNpdHVhdGlvbi4NCj4g
DQo+IE1heSBiZSBjaGFuZ2UgdGhhdCBsYXN0IHBhcmFncmFwaCB0byA6DQo+IA0KPiAgICBUaGlz
IGNoYW5nZSB1bm1hcHMgYW55IG1hcHBlZCBhZGRyZXNzZXMgd2hlbiBhbiBlcnJvciBvY2N1cnMs
DQo+ICAgIHByZXZlbnRpbmcgYSByZXNvdXJjZSBsZWFrLg0KPiANCj4gVGhlIGNoYW5nZSBsb29r
cyBjb3JyZWN0LiBBbiBoYWNrIGZyb20gYW4gSEFDRS1hd2FyZSBlbmdpbmVlciB3b3VsZCBiZQ0K
PiBhcHByZWNpYXRlZC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQpIaSBDw6lkcmlj
LA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBjb21tZW50cy4NClNob3VsZCBJIHN1Ym1p
dCBhIHYyIHBhdGNoIHRvIGluY29ycG9yYXRlIHRoZSByZXF1ZXN0ZWQgY2hhbmdlcyB0byB0aGUg
Y29tbWl0IGxvZz8NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

