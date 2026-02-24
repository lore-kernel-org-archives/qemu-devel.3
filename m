Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286A5EFB7ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 02:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuiY6-0000Xs-JC; Mon, 23 Feb 2026 21:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuiY1-0000XD-5V; Mon, 23 Feb 2026 21:53:18 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuiXy-0006i0-8D; Mon, 23 Feb 2026 21:53:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6j2HA3zbdsAhk2CKTK5LvYKNug8sCI09XDNINTTWbWrcfKsf1AE4WBBpsphsc3DALjOCBFdDYMR3XTJoQp8CA00ox5b1r7+PwLqguxV62Spp+LYNAvqWdCn1cbYk+Aa6W/9YRN0j2ILvIdvTZ26te3ZZOR5ucOXemGEowb+JGnmRp76Gt5HIumiP5hthqOeK6oBDHQVrY5Pw2bKj+M2kZ4WbtJ8mm+QIuwD3e0inb6NAiZXGh8xrVQBEFT4bDxOplu4+l6Wqx4iWbNeyQIGRH+uNxoE8LvH0qP7uYxuNLYuKR+k/DvgtA7gxlnfjwKYqWE3v+XST1AVP8Y7eRBCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJvVAIedzHH4nyU6qWBw1p+tY6fkHbguscQYD77ScDg=;
 b=KD1aPeJAjoqX+vofZ46B+8YGf6Y5FljrlwfsJFTov73UiLzwRSRNvYKnqRWTZYagTAzmXtyOOoPSewx/SGi4Lwxon3HVLNFtm8rqAU7YmuZuiqazRpelwE8OUxJW2wkkLKIHECtW7oyqma45LwVbl+/eXuGWRSIgqqXyhvnkoNDc24tUJgtFmrNwtRTwUd1SrIz3t1TnxT6ue5WxCyBPH+mqfhqKg20iCH6iOvsbQlkgtFdGE00y6PKqVend7uwEc/NF+TdJb6s8WuT8trIKe55ipAzkfQafx3Irmhc6SKhBNZ/HPffDtT6isEMA6W/AvjkVU7hQe0JkUEv195LO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJvVAIedzHH4nyU6qWBw1p+tY6fkHbguscQYD77ScDg=;
 b=evrhhQYOU9FqtMRKABW9rh0WJrBg4pxVCEBzEe4aVyrIGl/1Z+gD8uz9mjXJXCe3kCEEgJzhNlnYrkyhthksYVi8Cju22RfrLrnD5ZbhYa1rAjd9laF6JYeeNp5TfDMvo3oPY4taIJiHevoJkyRGHQrptpseDK1tHLjYFjStJDzi+g5uQmnSJetwIURdN+hsl8/7v+UMKTDN996SYvOFH2ccC64dbAcX9qYgXKvLE6r8VCHSVQPmDNHm9a4HZ1YDS9I1qXKvCmeM+Za4STsKSVkd4wlqrxHl26V0ROlkn0HREPhjOZO4IjtGJKKdrhsBHF7Rkde678yCzXgEqUm77w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6518.apcprd06.prod.outlook.com (2603:1096:820:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Tue, 24 Feb
 2026 02:53:04 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 02:53:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Thomas Huth <thuth@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kane
 Chen <kane_chen@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Topic: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
Thread-Index: AQHcn/bXw5yLp/LOskOx+2qAxSW0vLWRLc5g
Date: Tue, 24 Feb 2026 02:53:04 +0000
Message-ID: <TYPPR06MB820657F01C98468E1F166C7FFC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
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
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6518:EE_
x-ms-office365-filtering-correlation-id: d7478c3b-7f53-4851-e8d5-08de734fd4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V0NMMmlDUG1MdVNCd2FyendrRURwS0Y1cCtwRjBiQSs3Ukt3R0VtemtFNDdX?=
 =?utf-8?B?aTRMREVvYUFkRG9XV0M1SWVwYmtuL2RPeENzdFNSREpYOUJlRlczSlFaQVBF?=
 =?utf-8?B?b2lZcWlYMDBzWFZXVlVLR3QxK3RqS2ZJaDZ4TmpPVysxaHNqMS93Ry9pQkJW?=
 =?utf-8?B?WENIWks0OW8vMXR2LzIvcEVZeU1MOEFYdnZoNXNvMDZIT3JGWXp5OTFPYXps?=
 =?utf-8?B?Q01saGcyZTNhZEl6RC9Ba0cyeFI5d3lFU0ZMVGF3NDhBbkJtUVJEdDZNUVE1?=
 =?utf-8?B?cStqbDQ3VVZYWW8xVk9pdGltWVA1dDVpSjAySjc2VUNFUjROWFA5TlJGZTgy?=
 =?utf-8?B?dERwMUNvbi9RL3orYjZhdENaWWg1TTVJK092RHNMdmNta084SHRzRDR3UDho?=
 =?utf-8?B?ZFBvcjZzL0xNZzNkNVppUWE0UnZBS0xhUmoxVVkyQWlGeWtjZk12RkNqSUhH?=
 =?utf-8?B?K0M5OHdTYnZqeklGRVpTTHNsb01FRUJ1d3RTLzdJUkFzOG42SW95OWdsK05i?=
 =?utf-8?B?ZlNJWXlCVXBtM1ZrZW5Qb2dIRGd0QW1qd2doYlgrUFNMZ1NVOTNDMUxNMTdN?=
 =?utf-8?B?RGlrMXc0czNLaitBZ0RxZmllcG1JckZhQzdkMnhsZFByTzhMaDNhUWpKakNq?=
 =?utf-8?B?RFJjZTAvVk0xenFLMitsU1ppaG5RcmZaSElLNEliN3hWOW1kZXZMSEVZYkVZ?=
 =?utf-8?B?Z0cvNkhXZm5qeVNsclNjNzFTaUo0YWlIa1p5dzB1ZENsRHBtb0QyWlprSXZI?=
 =?utf-8?B?TnRHRmlFc3NjWC82TksweHBxa080QWJVeUNqN0FONzgrUjlJakNrVk1DZVRl?=
 =?utf-8?B?ZGRzU0JpdE5DZkF3bnNBbVhYckRINVJqeGlkaU5OY2RNcXQvZDZzeHFzQi9w?=
 =?utf-8?B?K3RaaDBNL1VnYnlBTkpId3hNbE1FNGNtK1AxazRFMW5UVzYvY25YODBveHNi?=
 =?utf-8?B?V0dpVy8rYWdWSDFxaGdzSGhzZ2lwaXMzTkc4WVhRK1NlcDR5QnRzakNqUDZX?=
 =?utf-8?B?b3JvRmpjZ3hWZFM3ZWRtZVpLMXVLcCtmdXhzTnUrN052SmxoZHdwK3RibFRV?=
 =?utf-8?B?bnhFaWUxRENTY0tvOXcrZU55SVYyeUJlUmREZS9RRzd3Q0NvNDdZdmJ1Q3Nn?=
 =?utf-8?B?V2JMZ04wQnJpKzBVUDFXVXRPcTFQUklwQysxQkR5THhETGpOdGZEay9PTmds?=
 =?utf-8?B?TGNTWVFia0phdG1UazNpRnlCaU00US9MYnZzajNBMUJUeUhSUnpTWFprYjZ5?=
 =?utf-8?B?UUVKL0pIWUtIOTQrOHVjUGJBdVlZaGpaaE5kbTMvMFRjQ2ltY3VuYWpRL2JY?=
 =?utf-8?B?RjdqU3BqT3J0TU50cXpJR2UvR09Zc2VNL0Vmek4rMmh1UDVxRzY3dkFGOVJT?=
 =?utf-8?B?dDNPKzBySEpYRjFweERZVldMdjNiUk9iRjgwaVRYaDByWk05ZG5obGJRc1JW?=
 =?utf-8?B?dDdFMUYyaXVUaHBPclFFNitOaEVBVkl1dVRRdE1IaWJZaHFMS24zbVlsQ3N5?=
 =?utf-8?B?MGhlUU5GVTdWc1dRazBUbzBHOXN5aXRpbTZxU25yais5YUVsQlVtdk9EZFJN?=
 =?utf-8?B?RVJHRG5rWVJTRTNkZmFTNjRJd1FLdTF0UFJzWjJNSS9hL0tXVjhlcGIzN3hW?=
 =?utf-8?B?M05kaHRYZ243RzRnT0hKc2kyeDV2UC95NTVQcmJRQW9BSGx2ZVprQ0lmL0VP?=
 =?utf-8?B?THR4SGJtVVRodjg2dCt5SDZzZDZKYlc1ckkxZVp2U21KWlJkSTc0K0hhUmxt?=
 =?utf-8?B?S0pUMDZaREIwZmsvRkozWS9NZklYdzdkWmRuQzNOUkpPMEs3N1JCMjJjbVFV?=
 =?utf-8?B?KzlXTVFjTW5ybFA5dW11RFVTT2dWOWloYTZOVWFOc2tyWWdDd0dxYmp5M1dL?=
 =?utf-8?B?dW5FODdHbndsd1R3K0hUT01Eb2MzU0paN1NrWGVpUkRGOW5IY0dVNEdjRjIy?=
 =?utf-8?B?QmllZy9ibm9Bd3E0UFFKcXZaKzllN0FDanl5cG9OWWhUZUg2NzZxUlR4SEdu?=
 =?utf-8?B?K2V0LzBjcHlqbEVRVWFUZW1ldlZTOCtsRm5yZjFBY0NRZUtVOUJhU2hmZmty?=
 =?utf-8?B?dHBNSmljNzNaNy93NldpMTdaWlBrdVVtS3ZuZ0h4eUp6VGtNbVA3a0M0WXIx?=
 =?utf-8?B?MWhRNUlmMjdQem9WYkk2QzZhN1lGZjlyc1BoODEwM2FUOXZDYmI1TStPRnl0?=
 =?utf-8?Q?RJtgzcqO+NQiOKztYRUC8PM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmltaWdiaXhQSGw1MHJQZjBpeEt0TDZ5L0krUzFvMkV0SEVsU3Y5NU5SdjY2?=
 =?utf-8?B?REFnNkE1UlRHREZYM0hYOUFVQUR4UlM4Q096Q2FpRHZSaDc3TmZOaTFzTkUy?=
 =?utf-8?B?WmdNYmNUelFqaFFYM24wb2prRmFQNGQ1SVFndDJaOVNBSzRXcWJ3dDBNcU5k?=
 =?utf-8?B?VHJCRTZ5T0xkL1ROcytmWUJ1NDYyK0FHYnlMN3pTdkIvY0pLRnBXVzlkTXk5?=
 =?utf-8?B?bjJaVzVIUVdVWGJRQTJINVlRZ2NZQWphTU5WKzhKUnJybFlMN0wwMlZIM2lo?=
 =?utf-8?B?eVBTK3RNcUVCNi9xUnQ0OGh2MEhLZXpjTjdqQ2RBT3lOY2tsNlVuSzdmeDUr?=
 =?utf-8?B?MHI4L3p6Z0ZYRjhKR2xWV00xSjlsMFdncXY5NSt1L1FhSHNUUDNpSjVvTllI?=
 =?utf-8?B?ZlpOZm53d2NGOFFTNEdhOGo2Vll1cmNsZi9rdzZkTGlkUFdhdGw5RDBVSGRy?=
 =?utf-8?B?L0NGa1dsUllVY29OcnFHVXJaQTdxc0NpdDlJWTRJMWc2VzdNVjQ2bHlzZGIr?=
 =?utf-8?B?S0dldXo5ZlJ4dHRpeXdSWjBZZHNxbXdwc1lPNzZzSzhKZnRTNTNCUUhhdTdI?=
 =?utf-8?B?dnMvM1pBbXVzUnZBTnJYYTJYSFhvR3kzbkpjdEJMSEFHYXErK0pDYXFRZC95?=
 =?utf-8?B?M1VmWmdjUGdZOERaWnpaWFVPRFF2V3Qwd29ESHU2VGVPYVFmU056eDRpRENB?=
 =?utf-8?B?TGlzNlJialdNS0JFeE1LbjFGWXJyL0phemQwa2wvR04vMmRRejFtWUpTNmNJ?=
 =?utf-8?B?NVFJdEdsRlY4YTQ2Z2w1NEM2QTVxQ09lamVvMGRyRVVZajVlTnhIbDZ5ZWVw?=
 =?utf-8?B?SGRZb01ZbEZrRDZrY1ZIeWhJOW8ybG0vR3Q1MmJZbm9ld2ZVcndIc01Ba3FL?=
 =?utf-8?B?TDlhME9Zc1FZOHlDVS90NVZrL3NveGNwSzNvSko5YVpGbDJ6M2JmRCtCQW51?=
 =?utf-8?B?SGxqQ0h1dEI2cUkvQyt1UHRxTm9WSUxFQXp4RTlqejFsc2wyT1hiUXU0Skhn?=
 =?utf-8?B?aGNlWERaeDNRWXc3YWk1N1E3azM1WUg3Q3pDd0xpN1FHZ1I2RTVjM3FZVk5S?=
 =?utf-8?B?MUhkU2hPN0NGSDhPSnFKUFMrdmZJRU5ZbDZiTThrK3ErcERheTVLb0U2OWpG?=
 =?utf-8?B?M2I0dVdhdjlBNlRpU0YrbFBzbU5OWTd4QVk1U0prbng3dkpTQVE4N0ZRbTQy?=
 =?utf-8?B?RGorQjg5cDhxd0pmMDNwMkpPSm9CTzBkRWFTN2J3Q2ZTS3RDdnZaY2d1T29O?=
 =?utf-8?B?NnlXTERXY0RmT3UzZUcwZHVVUncyZ2tzV0pKRWFPNFA5Q1BXMUpiR3lkWWtm?=
 =?utf-8?B?OHViUzVpQm9yN3ZIekN6TTFCdm5pQWp3QkhPODhuWFlXUTFqOXVFdEM4QVlU?=
 =?utf-8?B?NG4yVWNqQzJqZ1c4anY4ZEI5V1hzWEp2RUttMUxXRmpwR3pFc1RSTDFIWkZq?=
 =?utf-8?B?RmxqUVRJN2dlbGNHQ2w0ZFA3YnIvakFhNVZMVnN5aDBUU0p2TG9MWmhEVmN1?=
 =?utf-8?B?WUlaSzNYVld0eUZtdUE1VVRjOWZPNGwrZTVHa25iRFpwZEsvRDZob0NTUkV1?=
 =?utf-8?B?RmdZekgwcW1ReDBpZ3J6M2dRVGV4UDhwalFqNVpabi9YaGx4WFRURjI2MjIx?=
 =?utf-8?B?aDBPNThCdmtrbTBaM1BxTnpBQ2UxZG5DRjFDTnNPNmlSWlhQbFdCUEttQTBp?=
 =?utf-8?B?aFAyMU9ZczBBOVZKR0NBd2FXTk1sdk01RjJCVDNRT1ZxMXlkVWJHcHZ3bnJS?=
 =?utf-8?B?OEY4TkRNZTNwOHZ1eG8vVVhUbUNYT1JXd2NRd2NCWDg0c0VSQUJndC9qSnhD?=
 =?utf-8?B?VlpiTlNHOW02cEZpT2lhKyttTnh3bDFST1FjaWV4T28xUWVDRTNGTi96b0cr?=
 =?utf-8?B?MXdvcVZJQW9aZnlBaXAzQXRxbE4vVWNEMm1hUjlVYTBRUm1MWUZJVmZOSm04?=
 =?utf-8?B?V29hM0xqdDMrdmQyQzJIeTJwa04veHZKWVpvYjBZVVFGYnZiNTRUdU1yUklI?=
 =?utf-8?B?V2k2bTBwdnpMY2FEejQ0c1o1bkhGTW5iYVRCWjJPdzlPRmVpOUJFeFllV00z?=
 =?utf-8?B?RkVlQ1ZoQ0xDUE1hZjg2RTZRa256Q1lRVDlmS2JURDhJVkFZRHJVY2FsajE3?=
 =?utf-8?B?b3dkVWR3cGp4aFBxcmhZK1NVV2FOWDcwUGQ0UFJBU2JMVnNNUmQrMXpJN1I2?=
 =?utf-8?B?NWl4cDB4TlNZNTd0dHBKWWxOSjhWamxSU2ZibEx5U2dGK1lmSmE0U1RLaXVs?=
 =?utf-8?B?S01pMVlIMlNtaHp2YTV3amdlczFiR21qQ2pZejhDbW9JUUtiMTdjaE1EUDcr?=
 =?utf-8?B?bFJkWTBVWFZPM1dmVTFzNUtmYlVNUWMxeTM1UVB2WWNUK004aFdKdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7478c3b-7f53-4851-e8d5-08de734fd4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 02:53:04.5507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwpQ4+ZfJkdNE5DKnH4ZSJN/PlOouIruQ/Gzbt9o9QOE0FXWCUBoo+2v/cSibucUACrGxzwwUWc6qNYV+UJRs0HLvUn2/GyH1N43yLdLwhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6518
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

KyBUcm95DQoNCkhpIEPDqWRyaWMsDQoNCj4gU3ViamVjdDogUmU6IFtQVUxMIDAyLzE2XSB0ZXN0
cy9mdW5jdGlvbmFsOiBBZGQgU0RLIHRlc3RzIHdpdGggTGludXggNS4xNQ0KPiANCj4gSGVsbG8s
DQo+IA0KPiArIEphbWluLA0KPiANCj4gT24gMi8xNi8yNiAxNjowOCwgQ8OpZHJpYyBMZSBHb2F0
ZXIgd3JvdGU6DQo+ID4gT24gMi8xNi8yNiAxNTo1OSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90
ZToNCj4gPj4gT24gTW9uLCBGZWIgMTYsIDIwMjYgYXQgMTE6MTc6MzhBTSArMDAwMCwgUGV0ZXIg
TWF5ZGVsbCB3cm90ZToNCj4gPj4+IE9uIE1vbiwgMTYgRmViIDIwMjYgYXQgMTE6MTMsIFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gd3JvdGU6DQo+ID4+Pj4NCj4g
Pj4+PiBPbiBUaHUsIDEyIEZlYiAyMDI2IGF0IDIxOjQyLCBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBZGQgZnVuY3Rpb25hbCB0
ZXN0cyBmb3IgQVNUMjUwMCBhbmQgQVNUMjYwMCBtYWNoaW5lcyB1c2luZyB0aGUNCj4gPj4+Pj4g
T3BlbkJNQyBTREsgdjExLjAwIHdpdGggTGludXgga2VybmVsIDUuMTUuIFRoZXNlIHRlc3RzIGNv
bXBsZW1lbnQNCj4gPj4+Pj4gdGhlIGV4aXN0aW5nIFNESyB0ZXN0cyBhbmQgdmVyaWZ5IHRoYXQg
UUVNVSBjb3JyZWN0bHkgYm9vdHMgb2xkZXINCj4gPj4+Pj4ga2VybmVsIHZlcnNpb25zIG9uIHRo
ZXNlIHBsYXRmb3Jtcy4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4+ICvCoMKgwqAgQVNTRVRfU0RL
X1YxMTAwX0FTVDI2MDBfNTE1ID0gQXNzZXQoDQo+ID4+Pj4+ICsNCj4gPj4+Pj4NCj4gKydodHRw
czovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3dubG9hZC92
MTEuDQo+ID4+Pj4+ICswMC9hc3QyNjAwLWRlZmF1bHQtNTE1LW9ibWMudGFyLmd6JywNCj4gPj4+
Pj4gKw0KPiA+Pj4+Pg0KPiArJ2VjZTFhOTM0MDk1Mzc4OTI5NzgwZjAzZTdkMDkyZTU2MmY0YjMz
YjI4NDFiODBhZDdjM2QxMmE4NTc0NGMwZjYNCj4gPj4+Pj4gKycpDQo+ID4+Pj4NCj4gPj4+PiBU
aGlzIGFzc2V0IGZpbGUgaXMgb3ZlciBhIGdpZ2FieXRlIGluIHNpemUsIGl0IHRha2VzIGZvcmV2
ZXIgdG8NCj4gPj4+PiBkb3dubG9hZCwgYW5kIG91ciBmdW5jdGlvbmFsIHRlc3QgYXNzZXQgZG93
bmxvYWQgZnJhbWV3b3JrIGhhcyBubw0KPiA+Pj4+IG1lY2hhbmlzbSBmb3IgZ2l2aW5nIGFueSBr
aW5kIG9mIHByb2dyZXNzIGluZGljYXRpb24gZm9yIGRvd25sb2Fkcw0KPiA+Pj4+IChvciBldmVu
IGZvciB0ZWxsaW5nIHlvdSB0aGUgVVJMIGl0IGlzIGRvd25sb2FkaW5nIHVudGlsIGFmdGVyIHRo
ZQ0KPiA+Pj4+IGRvd25sb2FkIGlzIGNvbXBsZXRlKS4NCj4gPj4+Pg0KPiA+Pj4+IENhbiB3ZSBo
YXZlIGEgc2l6ZSBsaW1pdCBmb3IgdGVzdCBhc3NldHMgcGxlYXNlLCBhdCBsZWFzdCB1bnRpbCB0
aGUNCj4gPj4+PiBmcmFtZXdvcmsgY2FuIHN1cHBvcnQgbGFyZ2UgYXNzZXRzIGEgYml0IGJldHRl
ciA/DQo+ID4+Pg0KPiA+Pj4gRm9sbG93dXA6IHdlIGhhdmUgc2l4IHRlc3QgYXNzZXRzIHRoYXQg
YXJlIG92ZXIgNTAwTUIgaW4gc2l6ZSwgYW5kDQo+ID4+PiB0aGV5IGFyZSBhbGwgYXNwZWVkIHRl
c3RzLiBQbGVhc2UgY2FuIHlvdSBoYXZlIGEgbG9vayBhdCBzbGltbWluZw0KPiA+Pj4gdGhlc2Ug
ZG93bj8NCj4gPj4NCj4gPj4gSSBzZWUgMiBiaWcgYXNzZXRzIGZyb20gYXNwZWVkIG9ubHkNCj4g
Pj4NCj4gPj4gwqDCoCA2NGQ4OTI2YTdkMDFiNjQ5MTY4YmU5NmM5ODY2MDNiNTY5MGYwNjM5MTI4
NmM0MzhhM2E3NzJjOGM3DQo+IDAzOWU5Mw0KPiA+PiDCoMKgIGVjZTFhOTM0MDk1Mzc4OTI5Nzgw
ZjAzZTdkMDkyZTU2MmY0YjMzYjI4NDFiODBhZDdjM2QxMmE4NTcNCj4gNDRjMGY2DQo+ID4+DQo+
ID4+DQo+ID4+IHdoYXQgYXJlIHRoZSBuYW1lcyBvZiB0aGUgb3RoZXIgZmlsZXMgaW4gJEhPTUUv
LmNhY2hlL3FlbXUvZG93bmxvYWQNCj4gPj4geW91IGhhdmUgdGhhdCBhcmUgb3ZlciA1MDAgTUIg
Pw0KPiA+Pg0KPiA+PiBXaXRoIHJlZ2FyZHMsDQo+ID4+IERhbmllbA0KPiA+DQo+ID4gVGhlc2Ug
YXJlIHRoZSBmaWxlcyA6DQo+ID4NCj4gPg0KPiA1NzMyMjU1ZDQ2MTdkOThiNzZiYmJjMTE2ZDMz
MWQ2YWM4OTkwNmZhMjEyOTY5ZWI4MjEzZmRjNGFlYTg2NDUxDQo+ICAxNjZNDQo+ID4gYXN0MjUw
MC1kZWZhdWx0LTUxNS1vYm1jLnRhci5neg0KPiA+DQo+IDI3NjhlMjUyNmJkZDNmOTI4ZGYzMTM0
MTgwMWNiNmRlM2I5YTQwY2E5NDJiNTM4YTNkMDgwMGNkMjZmYmRiZmUNCj4gIDE2Nk0NCj4gPiBh
c3QyNTAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gPg0KPiBlY2UxYTkzNDA5NTM3ODkyOTc4MGYw
M2U3ZDA5MmU1NjJmNGIzM2IyODQxYjgwYWQ3YzNkMTJhODU3NDRjMGY2DQo+ICAxLjFHDQo+ID4g
YXN0MjYwMC1kZWZhdWx0LTUxNS1vYm1jLnRhci5neg0KPiA+DQo+IDY0ZDg5MjZhN2QwMWI2NDkx
NjhiZTk2Yzk4NjYwM2I1NjkwZjA2MzkxMjg2YzQzOGEzYTc3MmM4YzcwMzllOTMNCj4gwqAgMS4y
Rw0KPiA+IGFzdDI2MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+DQo+IDRmODc3OGJlMTc2ZWNl
MWI1N2QzM2M0YWVlMTNiYjk4OWJlMTE0YzNlNDcwMzE1MGVhZWI2Zjk5NmJkNTU4N2YNCj4gIDU4
Mk0NCj4gPiBhc3QyNzAwLWExLWRjc2NtLW9ibWMudGFyLmd6DQo+ID4NCj4gZDVjZWVkNTExY2Qw
ZGZlZmJiMTAyZmZmMmQ3MzExNTllMDQ3Mjk0OGEyODA2NmRjMGQ5MGJjZDU0YmU3NjUyNQ0KPiA1
MjBNDQo+ID4gYXN0MjcwMC1hMS1vYm1jLnRhci5neg0KPiA+DQo+IDBlOTNmNzk3NjEzOWRhNzFm
YWI5ZGY3OTUyYTU4YmRkODA2NTBlMjNlN2FiZjU4NTNiMGViNjY5NWRlYjAyZDANCj4gIDU4MU0N
Cj4gPiBhc3QyNzAwLWRjc2NtLW9ibWMudGFyLmd6DQo+ID4NCj4gZTJiOGYwNDNmZTgwNjNkZDNi
NmRlZDkzNDIyZTM4YmQ0MTkxNGRjOWMzMjAyMTk5NTA3NjUyZGYwMjRkZTRkYw0KPiAgNTE5TQ0K
PiA+IGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiANCj4gVGhlIGltYWdlIHNpemUgZm9y
IHYwOS4wOCB3YXMgYXJvdW5kIDI1MCBNQiBmb3IgdGhlIGFzdDI1MDAsDQo+IGFzdDI2MDAgYW5k
IGFzdDI3MDAgU29Dcy4gSXQgd291bGQgYmUgYmVzdCB0byBrZWVwIGl0IGxpa2UgdGhpcyBmb3Ig
dGVzdGluZy4NCj4gDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIGluIHYxMi4wMCA/DQo+IA0KDQoN
ClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uIGFuZCBmb3IgcmVwb3J0aW5nIHRoaXMgaXNz
dWUuDQoNClRvIGFsbG93IFFFTVUgdG8gYWNjZXB0IHRoZSBpbWFnZSB0YXJiYWxsIHNpemUsIEkg
d2lsbCBjcmVhdGUgbmV3IHRhcmJhbGxzIHNwZWNpZmljYWxseSBmb3IgUUVNVSBmdW5jdGlvbmFs
IHRlc3RpbmcuDQoNClRoZSAiYXN0MjYwMC1kZWZhdWx0LWltYWdlLnRhci5neiIgdGFyYmFsbCB3
aWxsIGJlIGJhc2VkIG9uICJhc3QyNjAwLWRlZmF1bHQtb2JtYy50YXIuZ3oiLiANCkl0IHdpbGwg
Y29udGFpbiBvbmx5IHRoZSBuZWNlc3NhcnkgaW1hZ2VzIGZyb20gYXN0MjYwMC1kZWZhdWx0LW9i
bWMudGFyLmd6IGZvciBRRU1VIGZ1bmN0aW9uYWwgdGVzdGluZywgc3VjaCBhcyBpbWFnZS1ibWMu
IA0KSW5jbHVkaW5nIG9ubHkgaW1hZ2UtYm1jIGluIHRoZSB0YXJiYWxsIHdpbGwgc2lnbmlmaWNh
bnRseSByZWR1Y2UgaXRzIHNpemUuIEluIFNESyB2MTEuMDEsIHRoZSBzaXplIHNob3VsZCBiZSBh
cm91bmQgNjRNQi4NCg0KSSBwbGFuIHRvIGNyZWF0ZSB0aGUgZm9sbG93aW5nIG5ldyB0YXJiYWxs
cyBmb3IgUUVNVSBmdW5jdGlvbmFsIHRlc3Rpbmc6DQoxLiBhc3QyNjAwLWRlZmF1bHQtaW1hZ2Uu
dGFyLmd6IA0KMi4gYXN0MjYwMC1kZWZhdWx0LTY2LWltYWdlLnRhci5neg0KMy4gYXN0MjcwMC1k
ZWZhdWx0LWltYWdlLnRhci5neg0KNCwgYXN0MjcwMC1hMS1pbWFnZS50YXIuZ3oNCjUuIGFzdDI3
MDAtZGNzY20taW1hZ2UudGFyLmd6DQo2LiBhc3QyNzAwLWExLWRjc2NtLWltYWdlLnRhci5neg0K
DQpBU1BFRUQgd2lsbCByZWxlYXNlIHYxMS4wMSB0aGlzIHdlZWsuIEFmdGVyIHRoZSB2MTEuMDEg
cmVsZWFzZSwgSSB3aWxsIHVwZGF0ZSB0aGVzZSB0YXJiYWxscyBhbmQgdGhlIFFFTVUgZnVuY3Rp
b25hbCB0ZXN0cyBhY2NvcmRpbmdseS4NClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSBhbmQgZm9y
IGFueSBpbmNvbnZlbmllbmNlIGNhdXNlZC4NCg0KSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KPiANCj4gDQo+IA0KPiANCg0K

