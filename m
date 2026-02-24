Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD3BEFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6Y-0001nv-2q; Tue, 24 Feb 2026 00:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6I-0001hz-MV; Tue, 24 Feb 2026 00:36:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6F-0001J8-Eb; Tue, 24 Feb 2026 00:36:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqezWi7dCaO2SowLFYq1ovcqMrb0GyNefIG0UvRm437WUVRneqJ8uKiYoA0+tbivEXDTPcu1WU4tFDcvLsE42WTlPCeEmnNR212TAj1UUAE7yBg75NI1/chM7KB03cRLw24iVaasBLPHzVSTn6sHQPpL+To4qeR25WeUc5lhj/5Ps3VvQBCfsYgUscQynAwwB4QZW97KcxeA2U2kS92oHS2LyFYs/6ApW/uhUSIyNvqrx3R8c2YkZaxcL0WKe4cauU3nCQ7aibfsKrx5CkI5ZHWnGo2YLmFiIWA9GEBSAGw7LqBFZqfXpLUk5E6YhdxvzGicp1xv6BXtep12wUjb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMRK8DTRI7QK4ZNtlJyDluUy4WDOWPJtdL0ZWv3Ab4Q=;
 b=HADzWu1VanJFiFczv6zNuA4+nKGnnX1IKJeiMowih+aQPzi4YIMYgxRK0tDTj2s/2X7FiK3d6MoVgXyZtV4pFC1Uge16tk2IiPTMKNKP9ud3VI6ompEA5KigoWoQeIJUm+7VnBsNcJs0wdl9m7FQrNmma0+YZdq+BHHaHSyo6KizoxPqnJuD89/Je0wgMOQcDYf+oA6NygI5HnNyuu9aqo1E2Nn6M1JQEPtqRQc/Xu3SkxsGhC/EJu2otvD7DuLCPUA9pBFGadwxnSLkRFiiAV+kJDwTXJFJlNuq2okiYMvg197OIZLwWm0EzyBFATHAhuz/YdELtzq+8IcKfCX7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMRK8DTRI7QK4ZNtlJyDluUy4WDOWPJtdL0ZWv3Ab4Q=;
 b=qYMc+0xSniBLJomnK2woR/TUmK9kSwzBuVeiCpegQ9LTelNup8dyVlLsrWtJzRQ+sNw4aQ6HfqjnP5jPRNnLKM/1/uRFkOA5+QWYUzhbnzKLtRKPdj2yKVS3dAy3LosPRwIn5hmB1CvSm7xoaqkUkyXLioR53m+Lpzi9lQVLtnbgnONwMXie3Pyn5d6J/RoCPhnZIHIv/mD3sASiW2HbqViGRGz1XwtD5LoPiR4vkj0eOBZcRTetFHPLoPmxriluepaABEQSthI/O6D5Qy5q3QOJxzL2JV/A91beRk4SnjYLlcruRmC2+SMF1TOigdCAO0BkxMPhSj53tmPSExgOxA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:34 +0000
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
 Venture <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v6 14/22] hw/i3c/dw-i3c: Add IBI handling
Thread-Topic: [PATCH v6 14/22] hw/i3c/dw-i3c: Add IBI handling
Thread-Index: AQHcpU+JAV8ZZRVUCkePmEciG9wqvA==
Date: Tue, 24 Feb 2026 05:36:34 +0000
Message-ID: <20260224053613.589102-15-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 62db1997-7119-45dd-211b-08de7366ac4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MZ3rfJF13Tj6xXfpSl3czlh/L835bWdPZKxIn+YimQ+hYctPnOb4PqRIig?=
 =?iso-8859-1?Q?WrVoUDsUtk5g/5tZnLB4bXNwDzHRdEAz7/8GsHi6WXVDlcO52Ucnrsd8/Z?=
 =?iso-8859-1?Q?s8v5Y8wjgbW/S+9IeydzZrKOE6E6dMcyN35Bscxn04RzyYEH7xFKR2olZy?=
 =?iso-8859-1?Q?bFZ2K8c+15wQ2Z1aI6dWCfC5+ZlrEkecvuaZCJRPPSMGhY+WPmZZtV+lzC?=
 =?iso-8859-1?Q?wo6qH6RX4uhkJNbUuCYkROUCy6wSngvd7W08zBcf1jMOiFynpCWLNd4Beu?=
 =?iso-8859-1?Q?/BehAf2koV3gsB1P/B92BYCNxol8GXqT++RTYeNgwK4cLRWc7mHgw09Xdr?=
 =?iso-8859-1?Q?/Aa6FhM696QnDI8/l7IHaGmPAzMXnBu4UJ5d4+oq+gRytho6bz7yJSj0Fo?=
 =?iso-8859-1?Q?cM9V/4JQKqft4LV534ThQ+szKi0CZ8GurpFgLSCUq3w20typUADnYSsjLL?=
 =?iso-8859-1?Q?MX+Sw6OOed9cJb+dVzLuhRGxM5GtL2T0EiFs68hnj8iZj96MVAyXmDhiPE?=
 =?iso-8859-1?Q?SHeWWcwYSFRZKD7ozI4djUqeQ8VXmlKknSCIvEI7eanyuEFQOLFe3GBUy0?=
 =?iso-8859-1?Q?OK5mfuSumi9MTEJf/s0LqSi74sifzZh4ubz1EP9prN6m4CGnAl3CWwltoc?=
 =?iso-8859-1?Q?ecfBbNn8rijzszWoMQlrCQaq+stjuH8NuDoznd77ebNnN24dROaeJyfx67?=
 =?iso-8859-1?Q?c+0ccFwWRo8RAjfhLS/pUvLMKlwvrI5wjihjw7dzfS7XzUbOHLfuFsdBa0?=
 =?iso-8859-1?Q?UjwEZLSoDJ3Y893wc8zpf6azYRRxcW+2CiD/W9Dm5t7lzZ1h+4fiT0rORH?=
 =?iso-8859-1?Q?CCwvBAmAPRXGnCUNNSpx7gALqpGZhHiw41HUhFO11rMu+/7k56TQ6mypT3?=
 =?iso-8859-1?Q?rvAmuFzBQ6noho0mWUsglRfu+c9f6zNYeHR1+I1seD+xy/C13cZy30crs8?=
 =?iso-8859-1?Q?8XZ3eITU8Ni4Uo27gamHHYMn131gaAVxWX6R+2purCTUaWc8/4naviNxFn?=
 =?iso-8859-1?Q?R5utsPNqfBHlfO/TsMqWj+rycsE5ea47BRQI5G/sBhN1vuxNZZaO1SyNXn?=
 =?iso-8859-1?Q?dHdfNMXdNGTiAZl7R8KKGPF7Nyb3gM9HsoMAKFsIgsZynlQJUlNDywCanh?=
 =?iso-8859-1?Q?yXsccOco95RYCh2vtgRNr3j6S95ldYdm2j+6tJ0Objcr6xrdC8rm0DtmC5?=
 =?iso-8859-1?Q?raKmVU2ToUsB+Vq2x6OnFxMqB0j7crV7MVcKm89S2+UFl/wb9+QRgDUhNX?=
 =?iso-8859-1?Q?33aFbDKZh//7rAM7ZSAaRo3jhOlDwH/rEwNveZpK5j8c+HqfacCrtW/6Ks?=
 =?iso-8859-1?Q?kE2BpekJfK7yPXQZHr9KGu6rKesuxRrcp8/waiyt0DpModlyJ/Pu8KAX/3?=
 =?iso-8859-1?Q?ktEgO2TZqNbqEfMzwabqGzZ8LPDQlO34Irzyr9pTRJM4cdxABnH8wmdoNG?=
 =?iso-8859-1?Q?rjmsy5SxB1fXaThxbvGJ0Y6jvws9OmB56mHgELKZ3Cjse81fZEiD1nJHjd?=
 =?iso-8859-1?Q?Mj02z0lb//6nHUiBU+3ccv718Nl/019C8H5XOf3DTJVKrj8vpiC8KSKI2G?=
 =?iso-8859-1?Q?iZ9Wi+5BDHAQxnY7HMhiBBKBpUUjv25TUBZg0quP90j5DCJ87uM+BIXQqx?=
 =?iso-8859-1?Q?Zld69WmrbZb5rroCodxcbj+ZuIcHD1Edb7dB0CeR3WIDtlavZBACbX7CRQ?=
 =?iso-8859-1?Q?En8I2tLWaRjmW5cCyplZCCMvy0Hj5dHHgn7qLRNJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OEZJ+BAJYcstUokHokHvcC1XHoOHjLmBobx3hxTwwT8++lesUVYSykaIbF?=
 =?iso-8859-1?Q?DMP7hTA0TKU3qc1aakNeDc3BJTFShOFrgXG68LfAXdN2iFfBAAtRfNvTvu?=
 =?iso-8859-1?Q?ZC9fvRavchgFTaTb0+EQOYtU91y+percChBtQQGABL/pVtMdEWpXpLK06r?=
 =?iso-8859-1?Q?2x97yZYxo54i8Pxe3KK76nY6giM7RWf835tZEEvWehRUOvdq49YIgrzSSw?=
 =?iso-8859-1?Q?Ev1Fr+6JTkYDIWJHiWNIeO+aRSJBXfNmpT6hvyvr/0Tp1aulVkqoHAGWm8?=
 =?iso-8859-1?Q?YdP9WXuWj/1H1CSnu3WX+2TFlKOER0U1mNaFfRrmxVmO83HiZjN6JlZRQq?=
 =?iso-8859-1?Q?qy9SP8bH7sONHKYs0uuTLBmwwB/P3KmCik3Tql67MfNTDhnp8/7NwfzKtR?=
 =?iso-8859-1?Q?s7+S2dTtUI1u5okUHoAmFMR1LE9c1cBEcSiUcKYrQZYtm0mKdo7no0qqFA?=
 =?iso-8859-1?Q?Hrt5c+OBCRuYhIRBO9tude8bnhg/18Ks/OjNqVzu4rrT5412xd17c7V9I7?=
 =?iso-8859-1?Q?FlZW68AyYTxGARFYnlidIGP7fMh6XorqC9jh5LHa02xCvnaAviYnygLSAB?=
 =?iso-8859-1?Q?ArA0RnCRhEcSyIw1Xuhd6f//FA/bnJjUvfACyXO3GzAN7Ctzbfyury7yR+?=
 =?iso-8859-1?Q?eYZ5MA7YB2jNdjTUUJkAwfAwpq3gBQqgCEoEowmJTbFSd2EwbqKbkAtunV?=
 =?iso-8859-1?Q?daa/6Wtixm1uSQqie+84w1xH8Rc4nGGnorWZ+2LQNxG7WtUF85PI0pt6Uv?=
 =?iso-8859-1?Q?mm0yJv8hYBa//dQO2bA047Ai29JaLS1NBFsKXnY7U55nCDtcfOlLU/2WNq?=
 =?iso-8859-1?Q?3gBxsYSVxDelW0Xn3jX2JlzwVJo6pUoAs176/HEKvz2VducLHqlLon9XMu?=
 =?iso-8859-1?Q?qdw/zyFD88mz9DjIxMe1dSgPzEPTONbFblXYZBXNYG/ti4O6BitscJl1V7?=
 =?iso-8859-1?Q?MjYVH0cObjhjPlXS2Ir0Tq7k1Zc+Nres0phAkxPqkouGYuZVYhvt2Hhqmo?=
 =?iso-8859-1?Q?RI6UuKQBzzPtO4EkoLtG58tCTmN9WKhBmeK0uQXDtWNxGrik7wLTAO1ifo?=
 =?iso-8859-1?Q?unfkrRfdql5lG/GwWDz4gIvIW/Nh+mL5O9dUmOBKY30e7QwgQ5TzW74vrw?=
 =?iso-8859-1?Q?d42GCn58vXCb33ggL/9IUJPWfJ/6G26F26HN56fMXt+/tqzWa793GvZJ3q?=
 =?iso-8859-1?Q?vRwkDdHEsdIFuHRfB8IaCS3eVcP+YA2bYCqHvG0o8ZVfxx0xqCDaDaNrJx?=
 =?iso-8859-1?Q?vWYF/HtIf/k993dpFEKADLOycLnHGcKBlT6G82Jz/qPfZlePEKvhbkyk+6?=
 =?iso-8859-1?Q?qinboZRfOa7gcFM0RWz9Mtye4cv3lMo7H2anWW+VqyAivRB7Whv9uPeYiI?=
 =?iso-8859-1?Q?Hm/aI6YRUQYVkg8cgMWLJiIw5pdVdChooDr0+34p/RwhLZHxDSWm74f5uJ?=
 =?iso-8859-1?Q?Z24qmvFCzKx+/1aUMGzunFo4vvqJHbWqRk1fYeMaOXOikVFejAXUzl7BKf?=
 =?iso-8859-1?Q?Amt5IY76TgjXmnkEG5Z4jZ1RoN8q8+qtoGpPpt7Kmua3RxXejHu2y/c+vQ?=
 =?iso-8859-1?Q?IWoGzubSElnkxvgWDXE13U9tWwzR01ssVJp8Kt17abeZWbyHpLDiCmu1yn?=
 =?iso-8859-1?Q?aWQiF8jCqcMGDmLWr5+Av+l41X8VnRpisUOU4WUk7FxQw7HYAjodpf1KyI?=
 =?iso-8859-1?Q?ksDdxqi4PEUWw3tsxEqR2t+5CnX4re8YqZsJnsTfE9/UfRIiTXVnGsRPz9?=
 =?iso-8859-1?Q?jAZQh2rEjbKK8c6ewu+vyR/r6mE6vDNYTqHdHfL6i8SMJFiHctJCJRpQcW?=
 =?iso-8859-1?Q?efAgTOwtYw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62db1997-7119-45dd-211b-08de7366ac4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:34.6471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZyqNX3BJkJZ95cE4dfddkd8uj4HN3PiVnMI5Knpaj4Bc/Bbsy/PP1fE9t6CH/BXDaS7UEXx6Yh0jQ1eSmSpplfy34lavP3s6lUNQOLDLkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

Adds handling for different IBI events that the controller can receive.=0A=
This includes:=0A=
- Handling a hot-join from a target=0A=
- Handling a secondary controller on the bus requesting to be the=0A=
  primary bus controller=0A=
- Handling an interrupt request from a target.=0A=
=0A=
When receiving an IBI, the controller sets an interrupt to notify=0A=
software about what happened.=0A=
When the IBI is finished being serviced, the controller pushes the=0A=
result of the IBI and any data received from the target into the IBI=0A=
queue.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/dw-i3c.h |  27 ++++=0A=
 hw/i3c/dw-i3c.c         | 317 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events     |   2 +=0A=
 3 files changed, 346 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
index c50d67cc6b..d26f60580f 100644=0A=
--- a/include/hw/i3c/dw-i3c.h=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -141,6 +141,28 @@ typedef union DWI3CCmdQueueData {=0A=
     DWI3CAddrAssignCmd addr_assign_cmd;=0A=
 } DWI3CCmdQueueData;=0A=
 =0A=
+/*=0A=
+ * When we receive an IBI with data, we need to store it temporarily until=
=0A=
+ * the target is finished sending data. Then we can set the IBI queue stat=
us=0A=
+ * appropriately.=0A=
+ */=0A=
+typedef struct DWI3CIBIData {=0A=
+    /* Do we notify the user that an IBI was NACKed? */=0A=
+    bool notify_ibi_nack;=0A=
+    /* Intermediate storage of IBI_QUEUE_STATUS. */=0A=
+    uint32_t ibi_queue_status;=0A=
+    /* Temporary buffer to store IBI data from the target. */=0A=
+    Fifo8 ibi_intermediate_queue;=0A=
+    /* The address we should send a CCC_DISEC to. */=0A=
+    uint8_t disec_addr;=0A=
+    /* The byte we should send along with the CCC_DISEC. */=0A=
+    uint8_t disec_byte;=0A=
+    /* Should we send a direct DISEC CCC? (As opposed to global). */=0A=
+    bool send_direct_disec;=0A=
+    /* Was this IBI NACKed? */=0A=
+    bool ibi_nacked;=0A=
+} DWI3CIBIData;=0A=
+=0A=
 struct DWI3C {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -152,11 +174,16 @@ struct DWI3C {=0A=
     Fifo32 resp_queue;=0A=
     Fifo32 tx_queue;=0A=
     Fifo32 rx_queue;=0A=
+    Fifo32 ibi_queue;=0A=
+=0A=
+    /* Temporary storage for IBI data. */=0A=
+    DWI3CIBIData ibi_data;=0A=
 =0A=
     struct {=0A=
         uint8_t id;=0A=
         uint8_t cmd_resp_queue_capacity_bytes;=0A=
         uint16_t tx_rx_queue_capacity_bytes;=0A=
+        uint8_t ibi_queue_capacity_bytes;=0A=
         uint8_t num_addressable_devices;=0A=
         uint16_t dev_addr_table_pointer;=0A=
         uint16_t dev_addr_table_depth;=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 2453d74a8c..832fcf326a 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,6 +19,14 @@=0A=
 #include "trace.h"=0A=
 #include "hw/core/irq.h"=0A=
 =0A=
+/*=0A=
+ * Disable event command values. sent along with a DISEC CCC to disable ce=
rtain=0A=
+ * events on targets.=0A=
+ */=0A=
+#define DISEC_HJ 0x08=0A=
+#define DISEC_CR 0x02=0A=
+#define DISEC_INT 0x01=0A=
+=0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
     FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
@@ -356,6 +364,23 @@ static inline bool dw_i3c_can_transmit(DWI3C *s)=0A=
            !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);=0A=
 }=0A=
 =0A=
+static inline uint8_t dw_i3c_ibi_slice_size(DWI3C *s)=0A=
+{=0A=
+    uint8_t ibi_slice_size =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                              IBI_DATA_THLD);=0A=
+    /* The minimum supported slice size is 4 bytes. */=0A=
+    if (ibi_slice_size =3D=3D 0) {=0A=
+        ibi_slice_size =3D 1;=0A=
+    }=0A=
+    ibi_slice_size *=3D sizeof(uint32_t);=0A=
+    /* maximum supported size is 63 bytes. */=0A=
+    if (ibi_slice_size >=3D 64) {=0A=
+        ibi_slice_size =3D 63;=0A=
+    }=0A=
+=0A=
+    return ibi_slice_size;=0A=
+}=0A=
+=0A=
 static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)=0A=
 {=0A=
     return regval =3D regval ? (2 << regval) : 1;=0A=
@@ -509,6 +534,266 @@ static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t =
offset)=0A=
                       DEV_DYNAMIC_ADDR);=0A=
 }=0A=
 =0A=
+static int dw_i3c_addr_table_index_from_addr(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    uint8_t table_size =3D ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POI=
NTER,=0A=
+                                          DEPTH);=0A=
+    for (uint8_t i =3D 0; i < table_size; i++) {=0A=
+        if (dw_i3c_target_addr(s, i) =3D=3D addr) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void dw_i3c_send_disec(DWI3C *s)=0A=
+{=0A=
+    uint8_t ccc =3D I3C_CCC_DISEC;=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        ccc =3D I3C_CCCD_DISEC;=0A=
+    }=0A=
+=0A=
+    dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                 /*is_i2c=3D*/false);=0A=
+    dw_i3c_send_byte(s, ccc, /*is_i2c=3D*/false);=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_start(s, s->ibi_data.disec_addr,=0A=
+                                     /*is_recv=3D*/false, /*is_i2c=3D*/fal=
se);=0A=
+    }=0A=
+    dw_i3c_send_byte(s, s->ibi_data.disec_byte, /*is_i2c=3D*/false);=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_hj(DWI3C *s)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN=
)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    bool nack_and_disable =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                             HOT_JOIN_ACK_NACK_CTRL);=0A=
+    if (nack_and_disable) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_byte =3D DISEC_HJ;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_ctlr_req(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_R=
EQ)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, MR_REJEC=
T)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable controller role requests. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_CR;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_targ_irq(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IR=
Q)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, SIR_REJE=
CT)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable interrupts. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_INT;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_handle(I3CBus *bus, uint8_t addr, bool is_recv)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->parent_obj.parent);=0A=
+=0A=
+    trace_dw_i3c_ibi_handle(s->cfg.id, addr, is_recv);=0A=
+    s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_stat=
us,=0A=
+                                              IBI_QUEUE_STATUS, IBI_ID,=0A=
+                                              (addr << 1) | is_recv);=0A=
+    /* Is this a hot join request? */=0A=
+    if (addr =3D=3D I3C_HJ_ADDR) {=0A=
+        return dw_i3c_handle_hj(s);=0A=
+    }=0A=
+    /* Is secondary controller requesting access? */=0A=
+    if (!is_recv) {=0A=
+        return dw_i3c_handle_ctlr_req(s, addr);=0A=
+    }=0A=
+    /* Is this a target IRQ? */=0A=
+    if (is_recv) {=0A=
+        return dw_i3c_handle_targ_irq(s, addr);=0A=
+    }=0A=
+=0A=
+    /* At this point the IBI should have been ACKed or NACKed. */=0A=
+    g_assert_not_reached();=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_recv(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->parent_obj.parent);=0A=
+    if (fifo8_is_full(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    fifo8_push(&s->ibi_data.ibi_intermediate_queue, data);=0A=
+    trace_dw_i3c_ibi_recv(s->cfg.id, data);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_push(DWI3C *s)=0A=
+{=0A=
+    /* Stored value is in 32-bit chunks, convert it to byte chunks. */=0A=
+    uint8_t ibi_slice_size =3D dw_i3c_ibi_slice_size(s);=0A=
+    uint8_t num_slices =3D (fifo8_num_used(&s->ibi_data.ibi_intermediate_q=
ueue) /=0A=
+                         ibi_slice_size) +=0A=
+                         ((fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue) %=0A=
+                         ibi_slice_size) ? 1 : 0);=0A=
+    uint8_t ibi_status_count =3D num_slices;=0A=
+    union {=0A=
+        uint8_t b[sizeof(uint32_t)];=0A=
+        uint32_t val32;=0A=
+    } ibi_data =3D {=0A=
+        .val32 =3D 0=0A=
+    };=0A=
+=0A=
+    /* The report was suppressed, do nothing. */=0A=
+    if (s->ibi_data.ibi_nacked && !s->ibi_data.notify_ibi_nack) {=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_IDLE);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* If we don't have any slices to push, just push the status. */=0A=
+    if (num_slices =3D=3D 0) {=0A=
+        s->ibi_data.ibi_queue_status =3D=0A=
+             FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=0A=
+                        LAST_STATUS, 1);=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        ibi_status_count =3D 1;=0A=
+    }=0A=
+=0A=
+    for (uint8_t i =3D 0; i < num_slices; i++) {=0A=
+        /* If this is the last slice, set LAST_STATUS. */=0A=
+        if (fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) <=0A=
+            ibi_slice_size) {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN,=0A=
+                           fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue));=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           LAST_STATUS, 1);=0A=
+        } else {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN, ibi_slice_size);=0A=
+        }=0A=
+=0A=
+        /* Push the IBI status header. */=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        /* Move each IBI byte into a 32-bit word and push it into the queu=
e. */=0A=
+        for (uint8_t j =3D 0; j < ibi_slice_size; ++j) {=0A=
+            if (fifo8_is_empty(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+                break;=0A=
+            }=0A=
+=0A=
+            ibi_data.b[j & 3] =3D fifo8_pop(&s->ibi_data.ibi_intermediate_=
queue);=0A=
+            /* We have 32-bits, push it to the IBI FIFO. */=0A=
+            if ((j & 0x03) =3D=3D 0x03) {=0A=
+                fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+                ibi_data.val32 =3D 0;=0A=
+            }=0A=
+        }=0A=
+        /* If the data isn't 32-bit aligned, push the leftover bytes. */=
=0A=
+        if (ibi_slice_size & 0x03) {=0A=
+            fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+        }=0A=
+=0A=
+        /* Clear out the data length for the next iteration. */=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                         IBI_QUEUE_STATUS, IBI_DATA_LEN, 0=
);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,=0A=
+                     ibi_status_count);=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    /* State update. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_finish(I3CBus *bus)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->parent_obj.parent);=0A=
+    bool nack_and_disable_hj =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                                HOT_JOIN_ACK_NACK_CTRL);=
=0A=
+    if (nack_and_disable_hj || s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_disec(s);=0A=
+    }=0A=
+    dw_i3c_ibi_queue_push(s);=0A=
+=0A=
+    /* Clear out the intermediate values. */=0A=
+    s->ibi_data.ibi_queue_status =3D 0;=0A=
+    s->ibi_data.disec_addr =3D 0;=0A=
+    s->ibi_data.disec_byte =3D 0;=0A=
+    s->ibi_data.send_direct_disec =3D false;=0A=
+    s->ibi_data.notify_ibi_nack =3D false;=0A=
+    s->ibi_data.ibi_nacked =3D false;=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
 {=0A=
     /* Only return the status whose corresponding EN bits are set. */=0A=
@@ -569,6 +854,25 @@ static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
     return val;=0A=
 }=0A=
 =0A=
+static uint32_t dw_i3c_ibi_queue_r(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->ibi_queue)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->ibi_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    return val;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->resp_queue)) {=0A=
@@ -606,6 +910,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+        value =3D dw_i3c_ibi_queue_r(s);=0A=
+        break;=0A=
     case R_INTR_STATUS:=0A=
         value =3D dw_i3c_intr_status_r(s);=0A=
         break;=0A=
@@ -1345,8 +1652,16 @@ static void dw_i3c_realize(DeviceState *dev, Error *=
*errp)=0A=
     fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);=
=0A=
     fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
     fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);=0A=
+    /* Arbitrarily large enough to not be an issue. */=0A=
+    fifo8_create(&s->ibi_data.ibi_intermediate_queue,=0A=
+                 s->cfg.ibi_queue_capacity_bytes * 8);=0A=
 =0A=
     s->bus =3D i3c_init_bus(DEVICE(s), name);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(s->bus);=0A=
+    bc->ibi_handle =3D dw_i3c_ibi_handle;=0A=
+    bc->ibi_recv =3D dw_i3c_ibi_recv;=0A=
+    bc->ibi_finish =3D dw_i3c_ibi_finish;=0A=
 }=0A=
 =0A=
 static const Property dw_i3c_properties[] =3D {=0A=
@@ -1355,6 +1670,8 @@ static const Property dw_i3c_properties[] =3D {=0A=
                       cfg.cmd_resp_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,=0A=
                       cfg.tx_rx_queue_capacity_bytes, 0x40),=0A=
+    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.ibi_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,=0A=
                       cfg.num_addressable_devices, 8),=0A=
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 044ff06a01..a262fcce39 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -9,6 +9,8 @@ dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t da=
ta) "I3C Dev[%u] read=0A=
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PR=
Id32 " bytes to bus"=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
+dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
+dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

