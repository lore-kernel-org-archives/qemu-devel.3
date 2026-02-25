Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7CF5543B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OF-0003Tl-Fr; Tue, 24 Feb 2026 21:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O4-0003Od-G7; Tue, 24 Feb 2026 21:12:29 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O3-0008Ty-2i; Tue, 24 Feb 2026 21:12:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO2COgc65YgDW3MO5hlGoWt2kiaAtMWZSIEKH612HWdryt34zcZBuuIivAeID0ToFz3YuROrSMxIyXwGif1LdizDQH18CmqqEYJSRk3ksXAZIlGtTnGjbVhlpLLaDx0ZVX3z2DvQpbAlQr22UtTRB6qYEKru3q1WJS0uzx9b7U37OkdQD3i8BdKaj/lzdSwvPSQUVi7uidPBCsq8TYlWLJ71b1u+dTXC1FfVbFoJfEyzeXr1Dk1oiuNKoeBqe8QcyZXde1KsESmbo6qrwhhqrEhcs0jRAfFOPWeEkLlI4T8/5aUFzgUnxJgWmYFU8ijVVecxOAFFTfj0cT8ellfC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/AYuRkWP6BeUepikGanog70cRJ8IwLDIUKHi20W3No=;
 b=voNxaMdveNCEsVp9onVqw6llwtQJqxyAMH4su1xNrwG5ZBkb+S6vMjj+yRzUavL0r+RTbwURRSqEMpFxkTqaWzSrP/oPD76QThODf/HpMmIB6a7s/8ab5YsK1QoM3KiKDFPrU7beNLRvqiW9RAOEs+5W4m6ktC/o+Ru7VXCLbyPMImsb1BYFQjsicVXh8VGz6fIOK30vr5NhoQWSZZsaDgdaNMeoQx6E/K4E0anHHjrm1e5cyjRU5kjUlTH3OHsEnOfSRpFJJdYylSNH3aZMKJqeLZjj34GsFrcjAs0s5MP9r/qagECKz2VqDixf8hyX1VsEA3LR2c1x56t1CgbQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/AYuRkWP6BeUepikGanog70cRJ8IwLDIUKHi20W3No=;
 b=SemPfTS/UK9lbtdFhINLgSuXecZ/gmAr02m5y24BefNEUGsC2yCy0dE1o/dGIEIzddBSnnCZYSkKwuqRAEn0xnIUOwuxLvW/Z5Lg46+9NKvQxRqtsvEQLVnhYQjTBy0+kJz0AXlvxd75iLS7L9f8g56oNyOocI/lOSunLZBO3GuWhaf0mokDFZrR6Do8yxyRqXylx3ZfYFtt9Nf01wJYC8HHYpzRczEXudlVmMlDIT7GXzQ6MRrZSXzSk4o6NHtaHzyOw67TxDig/XT4fXXGDyYiiof/Uwm5AOoVSrucwmE0gMJ9RszA745SNwK/IsN2+8rZzYRIlwnSi3xXZONtAA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v7 09/22] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH v7 09/22] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHcpfwpoZN+Aqf+ZESAvrpwvlIexg==
Date: Wed, 25 Feb 2026 02:12:15 +0000
Message-ID: <20260225021158.1586584-10-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: 544ac86a-b902-43b4-4d0b-08de74134bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BrOJIY+bLnzmA0nz+fgiCpcEDomfMxaJ9dy75faoYe4JrkvbadpffJlb0+?=
 =?iso-8859-1?Q?lm22g8kvPaQtfqYcwKYGu/MYshOENQssUsnT7HpKW6LcMhPh6ue08EuTK1?=
 =?iso-8859-1?Q?J34EVbdBi56A3rwy2VlTsGv5D3udRFiVWgTwBEjvxdTgolOHFe+TV8vk8V?=
 =?iso-8859-1?Q?k64mcoWzhsHVrx8Bcj5eMvSznOq7ulQaaRfF5IAgtRuy/qzPhDUTWpKrMY?=
 =?iso-8859-1?Q?1p8gaZH3LgXqqzdqRgQSvXoWtVgLEvbAUl+wpcakOqQ8RIwikfAb5DqHhn?=
 =?iso-8859-1?Q?LFHZ1vlZymqdaTkRgnV7Wv8awWDG+35L2OchQ+LWdiUWTHzFHTOlYU1tlI?=
 =?iso-8859-1?Q?px63ZmKQTFsEdHXNqf0OI+7rW9ghw11uAFgeurjmUFR05v1Xvwfx0XcRGj?=
 =?iso-8859-1?Q?GlOUDED2+iQGzuFMuxhb++LOZ5186oSGPaZ00eoVBg9JWjI8u+DOpfV6uy?=
 =?iso-8859-1?Q?iz4QzQV6xXA9pO8/2XufJnk1s3EuZBws8R6BQTMAg/x/k+QVBXsOZYLmWw?=
 =?iso-8859-1?Q?puTcOy5tZJggea/QB02D4IlrGTXgHrIv88aIypyE11SFkuDwGBRllFqqjq?=
 =?iso-8859-1?Q?COTvTPmIzcyO/OG543Wvfdthdhp1EGTAsThRCjh/Tvp388PZghGoixiRtm?=
 =?iso-8859-1?Q?coYwBsu9hMADnc+7Dj+Bd3puCIk+dRgYAPXg7TTMbGkzfagWF9EhWYVK1r?=
 =?iso-8859-1?Q?PKX7RKld0MCG9h5xs8PO11LsVVIdg7cZUJYNUo1+AopJs3EBqBFg8phHjr?=
 =?iso-8859-1?Q?b9e6VMOSRlKk5pwOoxBjeFr+HdyDsabI/dbSoEEOaLrHmUzy3pzhiF6iFR?=
 =?iso-8859-1?Q?1zX5JVUukR/Z9ghmzB+D0XIJhZImVhQ6tp9utTqmepiSbLwHE8K8ZzG9EQ?=
 =?iso-8859-1?Q?oLkuMwpvwFh7r/uuvXGH+8pzDZoXsYQckzBSA5+Leq4UYHxUDATCoHJDly?=
 =?iso-8859-1?Q?sMEKDLMKnaZG5V7964pOkjnNB949iea1JfjpMM9cQQ425wpMcpSJ0a00eM?=
 =?iso-8859-1?Q?tw0DQN0tMvOkCYGdbfwFrx5y3OpkD3PUThvkT5Iftnw7L8o/t0vfLybzuE?=
 =?iso-8859-1?Q?Jqr4wwkC2/hz0eUaNthdPMvGWz+dtbXJqvqfTbO4kK5qtkhdJl1uiMZx+U?=
 =?iso-8859-1?Q?QHdOc/aIJtiOg0eYWePG9Q2NJkG2JBC4rWQwh74EZa/UC56l8QRMwd3LTu?=
 =?iso-8859-1?Q?21rAUzQ4oi/IWk/hDFe8dNCE7aAaFxpgMjxuN0O4z+GejL93NENw4xXaW3?=
 =?iso-8859-1?Q?MMNPTaLM7oLCcgpwB3DaDV+j3KXbvNwUcfHPI3HAjCHSp88DGd4NbXIDjS?=
 =?iso-8859-1?Q?jQwO5FvFGcVZeJEct5XC+Cc7Jy1WvpYIIy9T50dLPXrfsmdCnFUxkxg4jb?=
 =?iso-8859-1?Q?fTXahpiVbB7rwpK+Dj69MPv+ynvmptu75Da7+w6JAYe6twdky7R9By0J+w?=
 =?iso-8859-1?Q?g7+VfZmK1jdfYif86Kit9xZbzki0YBVSFR6QJv4P7rgMeT6m6y7nPuV2nh?=
 =?iso-8859-1?Q?CbZbuzzQtlvQ2mjsq5ENpiiJwMxz4NIkfzOmqEv0RJXD8sIZ5lSaxF5BLB?=
 =?iso-8859-1?Q?GXcdLCuH8DBh3LOaegbUfXXyv4ZLJ9nC5Egx79o39PijXIcm+O3vH1kVh4?=
 =?iso-8859-1?Q?w6JASfRt7FaVgbJGzfy0BuyIkCFJjSnqxF+1L2BzlQVqTnlEFncDpFiFSa?=
 =?iso-8859-1?Q?tjDfT8ExISZ4g7U63sqCq+5+c5pExxewi6WdbcEf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wwU6B8sIrVxcFh8afNA3B2bFZwioHIVM5aKYa6dU0sq5WvYRCuQ6g/n6uG?=
 =?iso-8859-1?Q?AsMhiYFafjyANhgCYUOfDMgIWzpw3vHs0eGTVUh9i00bxOzzTpRkfYu9eN?=
 =?iso-8859-1?Q?zSQ3TjnaQJZlWfhfThsw4MwrETOkhc/0s+1qZBWvVsvUVa4IzFsZ8HnehU?=
 =?iso-8859-1?Q?ipt+mQAEhARVWuB4y4tZu89xLfM4jdZqrZosfU32Oqf4fWIkI+3YgunIN6?=
 =?iso-8859-1?Q?hOXNmB94UYvtguAeipdTWLK0I4YJQTHo8B1pLsTJHgTndpDAllgO/uHU1j?=
 =?iso-8859-1?Q?Jvn1r/z2Zngjhp9BZBazyQ3n0Ar38wPb73zRmMEQYnrkkpZQXutebN5B5J?=
 =?iso-8859-1?Q?XMtz5kCFVCuoKTGGUV4E8KF7oH5wJ6APi8B5UoFvcIeOAgW3ay1b2QUbnV?=
 =?iso-8859-1?Q?/SJCHmNMrsCGs9eKJA6KJpDQC237/1ifyLzO5mSKCVImTd1gPs+0Pn40vX?=
 =?iso-8859-1?Q?X4wJAGIhbWN9/hv3RMuhzOpKVWHLRBrtTkk3gti/eny1Wig4pNrqgnXbgW?=
 =?iso-8859-1?Q?KhxqHqn7qvEtZaB8QS0SVQ1Ad9BqUVoZ/CsgjvdYx3F3Gg/xDBn29Rb2M9?=
 =?iso-8859-1?Q?P4tk9kWUw2L5mYbcNeJXDPFuAl5e81xjw8rrt5rKZkRPRysQO7q7zuyk7s?=
 =?iso-8859-1?Q?kla7TVTMr3pkj6/icLeSdxka8HrCUgwbhPvIswHmi/cTI6oLCrhkaVfQ5h?=
 =?iso-8859-1?Q?vpENmgtBkE6GO9QsQ1HBudMtz+u/6OxqEZSlQybbQI1XpG1nLww5BY4fat?=
 =?iso-8859-1?Q?ecS70gSjlCC1oDDholmvkkSFc1+lJy6HLp6ZRkeuerN9yvogWaLqV/6LUI?=
 =?iso-8859-1?Q?FS8ktMNERMB+PgPPn5kH/PcwMG++DzXh5dZFKhYSIpZ0YeLyZ3UpDLzV8a?=
 =?iso-8859-1?Q?diV7xmwZldfErVn/1ybmNgvfDe0nOJKgFIy45Krpo1ReAM0bO8bjLlBMgE?=
 =?iso-8859-1?Q?TeZnUNL62bWCNCAgTcl43ReOoae+2lSLDQNIrLkqPXVxs6Neo4zgPNMOdm?=
 =?iso-8859-1?Q?9eKvn8lhjXplNO85fuNWNrARNmxKX4o6zOsW8bTvMfNZnI6QlqcoFbfgj1?=
 =?iso-8859-1?Q?fYz3xnGR0+qLQPex1rQeARTMDiTv6dO/zngU0brP2LPOIpVT0Y5UwP0o96?=
 =?iso-8859-1?Q?kUign4cATOTZBsgMfdMplmaCaod4x1O0byWWX1muirChaeevYF4hFwFx3S?=
 =?iso-8859-1?Q?RlYlBQn2PRqhEY+hWWq4wnz6I2kLb/d5UzCydMpM9SKB9lLkj5fU9lULlO?=
 =?iso-8859-1?Q?3WhV2qHW5FSuGmQ7D7F6nAagMDOnIT+5KkxmA6Fm7LKmFns1VWKGNJFaiS?=
 =?iso-8859-1?Q?wxIAPkbvOiEALnBVVLw55x0e8bF6xjnL6pwL8lvp9co24PkWxy/5sms284?=
 =?iso-8859-1?Q?iH8I18fA5IFHGSfksmbJKYRGTiSmJbes5Ow3jCLM74aRjgElNSWwOswq6f?=
 =?iso-8859-1?Q?H9qJxEi4Zf+IiPTRgyXxV+G7nWhXrlWx3++KNdrxRrisAalxiHCCiEvewr?=
 =?iso-8859-1?Q?ylPspxL8OhgtTlOiZgYh4jUKle/BcjkfReUQjDFA/Fd6et2S0vIe13GsUD?=
 =?iso-8859-1?Q?JerxvvEqyvl9SoG45gL6mUCGkwwWtWy8Fu8XTCkzdyF26sl2yHp6Q4C/tw?=
 =?iso-8859-1?Q?xSELrAEIVZFj0Mzx9iEWPklIN9mXW9O2fXpNrVemszGsXxQmGzY3cY4EZL?=
 =?iso-8859-1?Q?LurZ+1PZVg/xAJx2HTNXeJSJzAyzK5xYM4aP7J7ps4vroDPJlnMhgjYKzI?=
 =?iso-8859-1?Q?vLlVlNjWNm8p0jVXpzIQatIxhCL3DAiEFk1m+MPyeETRG5kyJ+4IC975fc?=
 =?iso-8859-1?Q?GI1RdB+MQg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544ac86a-b902-43b4-4d0b-08de74134bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:15.6914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fG31Yygij5FOKh2SudA1OqMwcxlxrxRuPSDU8eCEcqEnClckRpVpUtgj/dsy68vj1+xOGr2zjvjs1pt4Jsva1qSICMchVRnMvDHCc0+xPuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

Adds read-only register masks for the DwC I3C controller.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 40 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 28da6016a1..87c8f63da9 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -296,6 +296,45 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =
=3D {=0A=
     [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
+static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=0A=
+    [R_DEVICE_CTRL]                 =3D 0x04fffe00,=0A=
+    [R_DEVICE_ADDR]                 =3D 0x7f807f80,=0A=
+    [R_HW_CAPABILITY]               =3D 0xffffffff,=0A=
+    [R_IBI_QUEUE_STATUS]            =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0xf8f8f8f8,=0A=
+    [R_IBI_QUEUE_CTRL]              =3D 0xfffffff0,=0A=
+    [R_RESET_CTRL]                  =3D 0xffffffc0,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0xffffff3f,=0A=
+    [R_INTR_STATUS]                 =3D 0xffff809f,=0A=
+    [R_INTR_STATUS_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_SIGNAL_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_FORCE]                  =3D 0xffff8000,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0xffffffff,=0A=
+    [R_PRESENT_STATE]               =3D 0xffffffff,=0A=
+    [R_CCC_DEVICE_STATUS]           =3D 0xffffffff,=0A=
+    [R_I3C_VER_ID]                  =3D 0xffffffff,=0A=
+    [R_I3C_VER_TYPE]                =3D 0xffffffff,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0xffffffff,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0xffcbffff,=0A=
+    [R_SLV_PID_VALUE]               =3D 0xffff0fff,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0xffffffff,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0xffffffff,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0xffffffff,=0A=
+    [R_MAX_READ_TURNAROUND]         =3D 0xffffffff,=0A=
+    [R_MAX_DATA_SPEED]              =3D 0xffffffff,=0A=
+    [R_SLV_INTR_REQ]                =3D 0xfffffff0,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0xffffffc0,=0A=
+    [R_DEVICE_CTRL_EXTENDED]        =3D 0xfffffff8,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0xff000000,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x0000fff0,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0xfff00000,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0xffffffff,=0A=
+    [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
+};=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -324,6 +363,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
+    value &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
-- =0A=
2.43.0=0A=

