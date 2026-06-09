Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BDCCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzYr-0006uD-2t; Tue, 09 Jun 2026 12:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kiraly.tamas@outlook.com>)
 id 1wWzYb-0006s7-0e
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:44:08 -0400
Received: from mail-westeuropeazolkn19010020.outbound.protection.outlook.com
 ([52.103.33.20] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kiraly.tamas@outlook.com>)
 id 1wWzYV-0003rn-3m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:44:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ4xBKzF6NPt5/9kqwd+aqcEbDbEKgPDW/dtJus0HBJbCDrwI1c3UYIa5bYOmt5bUFkSaVBWI7rW0X1i9nHIrufVSIvOwOFyxCKcK3nX+NHcpWGWrTBgidpXnlnXYKz5N9mo6VrXopAe/MBv+GmCW4fopouLdtUnNAKqV0RW0RoVTDzoVhdiX4o5fSpSezx8Y7L25ZykOysUcXTZj8cUjlTmDXAC4UeQNYApr0IYCppPx9nXqG6Bo6CzT8qx+WPbapXwbHnmEsQB6zVB7qlOk/KhNBLhZU+RIzJsnv6XTsD4fsz1RRHb5UpoDMLmjg+g6XMy1QdFhaM9TRNSynmFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0VpekYlatd8fqik8qvICmMXhoPNbVikVP74VGH6W+Q=;
 b=e74QfK7t0skK1UkhnBcZaZsC2xNyZ727vQVedNRyqk3dOEfRutPxg754XfF1AVMYGawgC845o8X952FEyK7ugw6cv118kxvmLRd94yRfZm9+k8jxuKxChGcRNS6sDQrD30DrYKQzuRkHsICJpYK6aoWluf9/DDZn4juIWv+f7Oi9ZSqgZ6Rt0vHVTvh7cli8szrrWQkzvNa9z9FY/3JWFYstIlBE8hTAhsnP+ESfvAGPKvYQv+oOHob0PBTuuI4G3uLiSwklkQVYDAfx8FODXn+XOLecd0aoZNmJF+J1hgTQHgApNpHlVG7Q9TUu4URzR3xGmwEWbJlfiFc7tfn4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0VpekYlatd8fqik8qvICmMXhoPNbVikVP74VGH6W+Q=;
 b=aS1kwPpXkNpc7Sc+7ZTPkUTh7UqMRJtetG1VrtxWbKo8OeF7N6AfNNmXaXFOvr7MNAyhUdoR/xQW6sqJ96CastzKS9AVFv9vexJkhsKzUo9P5dHAB0tnzanz1PMYB8rBfzvib+wovbBwLqGRq9fada52RqnY+qRogRfL9TlGylQHURukF8UpN1FeBcs1QeizCWGuQTA+Ccd7VhWVXu3ccZgEGSXF7ElF5/6wuv7duXV3G/zVIlfuxyMIO0oCaVb00P41QZLq28BDXBCgNrxEOHQUECpQB4xCkYSgR0QjstMF20kZ8GWUweygSS6QVnldgxWigtc8Wxt3+d/3upoIkw==
Received: from BESP192MB2919.EURP192.PROD.OUTLOOK.COM (2603:10a6:b10:ee::23)
 by VI0P192MB3271.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 16:38:54 +0000
Received: from BESP192MB2919.EURP192.PROD.OUTLOOK.COM
 ([fe80::adba:2c43:321f:433c]) by BESP192MB2919.EURP192.PROD.OUTLOOK.COM
 ([fe80::adba:2c43:321f:433c%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:38:54 +0000
From: =?iso-8859-1?Q?Tam=E1s_Kir=E1ly?= <kiraly.tamas@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@mailo.com"
 <philmd@mailo.com>
Subject: Re: RFC sensor simulation in QEMU
Thread-Topic: RFC sensor simulation in QEMU
Thread-Index: AQHc8pDt2DN3gYDPbESNmIREuyJwHbY2V2UAgAAWGCg=
Date: Tue, 9 Jun 2026 16:38:54 +0000
Message-ID: <BESP192MB29196ED401270A194315234F9C1D2@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
References: <BESP192MB2919F3C79FA633DBB40571C89C122@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
 <20260609154258.7fae97b3@jic23-huawei>
In-Reply-To: <20260609154258.7fae97b3@jic23-huawei>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP192MB2919:EE_|VI0P192MB3271:EE_
x-ms-office365-filtering-correlation-id: 865ac523-f415-4353-39ed-08dec645986f
x-ms-exchange-slblob-mailprops: laRBL560oLSPhlJ95/U7v6W/AahuugGaG+1Z3pODm7knVT8QXacep7pjEXza7wGlJcQqAwENV/hvzywiYj/0sCCkoislk+0a3LRQGBR4e03H4N30/p5BMKCMw8CuC//z8iwP7mF/ihLRy7KqESXYe+T04MxMMy6GQPKWFyZLd3zP+vw687hvIX6v245wHbvJ4i0iFuTulbDdAcEuYrX2urA7jtklp2jjCzqufffIxCfrFTL3tRELT6Xwoc9eqPLPYF5fIQRyjxwacFDfDaiXHLXMbzx55iXUQ4yVJN/ZCOZ253AgXXtw5VRs56Me3GLU6qfNDfXwsiQq6ZZ5lSq/cUj9anLzDX7JhdeuZWpwXCdt15pg9rCOnX9s5YQTYVkr9Rohb1ve4P64gwbNK8s4cpsI7XOraFkBC0n1nJmTWERWUHGm/PlzZFkp3YWLcpf9uwWj+mnu7ra7GMhTx1fcSUVUlBOCXVlQmMCnZ3eXFj8O/lgTY3GFkcLnsxL+lej5cxphDsIXDSjJQjrzXb74l0LST9FPEYE0L3MC9rr9lf7TsCB3eLnxY8S0VbWDDwVXsVicOr5MTlTLC4aNsxTp5+TQjWgHQ0wRA39o6T/oSMOeZ39MN8dwYA3q3TDpiaskrymtNg5KY1tlUyW/Dsd9Pfns7+G9YQo9cTp8jUx2cJTH2r9KONL4vkq9BtALfed5hF4z55uLheaoCIiuHazp9dvf+OmLTWu8EaExnKpxxWtlo84ZALXTIY9UYpTEU1PaJAdRnQ5OSqxMyK+9vQGHsA3bZnLWOjhM
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|24021099003|51005399006|15080799012|25031999004|22091999003|24121999003|9400799043|8060799015|15030799006|19110799012|12050799012|31061999003|26104999009|40105399003|440099028|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4lDgaWHYNyr9AMiPoS7lHjpVjaWFMZLWSDZIQLb0RyOS9N0yGM54DW3wGz?=
 =?iso-8859-1?Q?yPj6wcISY2Olx0z2r7wL8XZRE45hhKU/cdoIHL0M/hgOWz1sl3Ml4rhjcf?=
 =?iso-8859-1?Q?WcDJ6FqhDp6om0HWiTIOXw7WNYRAW4o1QO8E9hNEPBRooMzJn8nvlqQ8GX?=
 =?iso-8859-1?Q?tya4mxaxazOjV5Y/QQ7vU7HdKtmkxw6USW3OBJ6V0nhUXMFTD4rmEkGahn?=
 =?iso-8859-1?Q?h1wOuheM3Ka9bt8YX/4fo5fxcQgPm6KcyY/aDk/vqlqVwuGxMBfd56SK7+?=
 =?iso-8859-1?Q?M57ONxBwv3gDmgh0bebSiDxhba34o4KhQsXcMVv3b9BoSI0R9+LlF4OQfk?=
 =?iso-8859-1?Q?HmMCf/GdhA/7lPHAsp7pRJmAPOWiHemBIwdXC4GIAanWvt7St9ZWvxq3Or?=
 =?iso-8859-1?Q?rl9dN1WIP9jgtckV7fstdyXJL/0xFavDrIrUjY8jDbjxY+VDnTuLRKI3Dp?=
 =?iso-8859-1?Q?UIf5kTQueRVWKtzH+geUyfVG8Z+7WYImHRczZXXEWMRLx18zKdo4y9Si0x?=
 =?iso-8859-1?Q?qrVZBorVmAb8DrvJCpmH82ElzBmT8CwUvW49VqxO5/3S5jbZ76HUTYi/cn?=
 =?iso-8859-1?Q?uT1NSMXH9268Ccxh+Yzycse5pEWel0dnAfOOW9yhSX2AdtLokZtay/qEuP?=
 =?iso-8859-1?Q?TLVYKPo3wzI5ZeP2RIgbuAZbg7tipkvA5JTvownJjefDwjOjDHfGPjQm6z?=
 =?iso-8859-1?Q?SP63bkqO6jKfUGtkSSbYxSq3bFLNW9r/K7Zq1kEhVrsLCGEAR2bvetkmdv?=
 =?iso-8859-1?Q?Mzm9LJ7Ljq4Z5jjlE1ZkoLSyXOgfbefcztjTU1iw3cEtfLquBJg0dl8Xdp?=
 =?iso-8859-1?Q?x4L8P/ls3cUMiPur59GR9ii0v7p1WFfDI7lgDLFiceckYz5YoiVfbJ1+P8?=
 =?iso-8859-1?Q?iqygtbF78GImdPItLAfYAFIRQ2wnyHEv6gvYuo0xo3OVOWeyJyCXr1n+NO?=
 =?iso-8859-1?Q?K0JdnrpFweVxU/aOmHYynoIEyMEj4IvW5AVP1W1Ok4G2WOxVI54AqQS5zo?=
 =?iso-8859-1?Q?NuC2eMWipzshBazrSN0G5ECXaeGFszz/pWhHVXFDQCXP9T8GNlSw9rsW/D?=
 =?iso-8859-1?Q?GWiCYQwnYKR5vKqraVvqnb9lkXOyE4G5lVUDwt5CsE0MzNx8px59Knp8rk?=
 =?iso-8859-1?Q?pRdE3GMaXDJ9zwgeGTaHwjj3FqAbhTrKd94m9KQ9pGFuLeS8gUz0JQKN5H?=
 =?iso-8859-1?Q?rVeKQkgyJKsIGnSMSvChs8DdCYkpO8MZicY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p34k4QvP/E+MUxqIuPAR7cz4o3oiOgYUwBcxceTdkY9RALxe7Hb1cUKW54?=
 =?iso-8859-1?Q?MfPqw6T3VifeD1cEorSTNCLhTEWk+tOo2QRNVGTNMbcpwREVl4wM7jK4Un?=
 =?iso-8859-1?Q?3f2QEp2M+05NBkaCta6lB0USTybT5tFMu8MXto3mIGV/aphTVSKV2mLoeg?=
 =?iso-8859-1?Q?jGJPYuM1kINv4+DwLWCtH0vmaoiFznYFriNe0cxU7+GyUWOCvppdlKBz0K?=
 =?iso-8859-1?Q?X0dX50Zd6LPQ/7uBgpv4XwuR/zDISDqq/U8psY1WMhbBw8h6dK+ycnJWT0?=
 =?iso-8859-1?Q?fe2oHNxn00fAO7CwgvTIWq9TvL4um/ywDNkADqlNp8PHjxp8PwLB5SdGFA?=
 =?iso-8859-1?Q?c4gclRm1EibZfs/BMPxZbIZHxV2+qIuB3tpn85PJbOXpEJg3aRV4uKX1D0?=
 =?iso-8859-1?Q?0QgJwuQ3mz1aD6o6jGHnGNIK0g7ptzYr4vh7u/grSA9O11XGX/XQcAIpxX?=
 =?iso-8859-1?Q?IZVZZnMMJc4n8rhaihyAdPNC1bVh8rCybz1ZI6np2b1moCP99LUyK8vVa3?=
 =?iso-8859-1?Q?P3oZrK3Ea9wH191YsYkJmwOVeLiUPYlVCW1Xf3gePyYJPRRefaHI2kLSRf?=
 =?iso-8859-1?Q?JZG8uPjajzDAph13mqo1Gm3K7UPb5q+sGtwc3YuxAj7FK1UWnSY5VQt14Q?=
 =?iso-8859-1?Q?YVwjxD1tYXBygxOSH5wJOH4CcVVT7EVDSiP3B7fRwC5HQzW3N+Cb5cSRJQ?=
 =?iso-8859-1?Q?fh6aQHA9Sut5WhC6PxQDlER6PBviizRm04ZHV7RgpheTFc8skUsFDUaA5S?=
 =?iso-8859-1?Q?k5yotc3IwflCvsagOm89T5eXQi7cOUs9JnIkDGvixVSbAneqXaToe5dS99?=
 =?iso-8859-1?Q?hZw3ZkK4KxrAudAkaEgT0hUfDwjYC8ZDTwDPYp4yr4KfbnDVZw1zLeEAQw?=
 =?iso-8859-1?Q?5BwuXAj3vjGzU1O2gl6Z8M2norOp0Go3PJUJvp3qKZ7wn492EByxFBjFhP?=
 =?iso-8859-1?Q?ZYEQwMDD+4yR7Kp0P57KbjVOba7ytq8RychPyv01E4y4PPGgrznkmCUWZK?=
 =?iso-8859-1?Q?7glMlu9V43HYvypN4oTCpWQrxsRZvOrslpDSTj0ZCDugMk8fJBKQBmo4sw?=
 =?iso-8859-1?Q?Qgv3pZG9jQy0sNAY2ZO4s1Nz7DQ4CuTS4Ng1QtOK3Cd0jMV0353taPYyyq?=
 =?iso-8859-1?Q?eQ/uI/Vh9ZK4gEwbBjmAIqQzJrwifvV29WzFpsZZJXzqnBJmYfYxfhEBwD?=
 =?iso-8859-1?Q?KccONfqVwPYaEKgEuyNT3qg9SI6GKTGOZqzHvy8c37oEifVFFEudXa94A9?=
 =?iso-8859-1?Q?vAN25EwCxA3yI/KzpUiEX3O7t7Kz+AQe/TzXQd0WqGTs2LC5Bu9FWzi8Mi?=
 =?iso-8859-1?Q?exZfswDlL66KNJsMK+5jRSeAxmwfqE/zzxD9UBE7DVSRkvWNIv0RY1jYVa?=
 =?iso-8859-1?Q?6u0jbowxlZy4zlnBOZ+tsUDND0e+XyAwdDQTFvcYa4FRhQbGuy6jzDs6GQ?=
 =?iso-8859-1?Q?5wGt0zkXzxFq1loY5jnTYR7oRhzwo/StuvwyghFEt/mokrrmZ8hPR5oAiI?=
 =?iso-8859-1?Q?Eq01QFxmbe6zP26BzPridV?=
Content-Type: multipart/alternative;
 boundary="_000_BESP192MB29196ED401270A194315234F9C1D2BESP192MB2919EURP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP192MB2919.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 865ac523-f415-4353-39ed-08dec645986f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 16:38:54.5280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB3271
Received-SPF: pass client-ip=52.103.33.20;
 envelope-from=kiraly.tamas@outlook.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BESP192MB29196ED401270A194315234F9C1D2BESP192MB2919EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you for responding to my email. You are right I was a little bit vagu=
e with the topic, allow me to elaborate:

My starting point for sensors is the sensor hat<https://www.raspberrypi.com=
/products/sense-hat/> for Raspberry Pi. It contains humidity, temperature, =
pressure, IMU, etc. so I am mainly talking about embedded sensors which pro=
vide their stuff via I2C, SPI or similar protocol. A lot of these sensors h=
ave kernel drivers thanks to the IIO subsystem so the user side is pretty m=
uch done.
I think there is room for development on the sensor side, like replacing th=
e hardware with software temporarily for testing or other purposes. I can t=
hink of a simulation which generates for example temperature measurements a=
nd those are provided to the user (e.g. kernel driver) according to the BME=
280 sensor's register mapping and datasheet. The goal here is that the kern=
el driver (or generally the consumer of sensor output) does not see a diffe=
rence between real hardware and software simulation.
Always fascinated me that a piece of code was written assuming that it will=
 access a certain hardware and then I could swap that hardware with a softw=
are component and see what happens. Is it depending on an undocumented hard=
ware behavior? Is it able to handle inconsistent sensor state?

What do you think? Is this something worth looking into?

Regards
Tam=E1s

________________________________
From: Jonathan Cameron <jic23@kernel.org>
Sent: Tuesday, June 9, 2026 16:42
To: Tam=E1s Kir=E1ly <kiraly.tamas@outlook.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; philmd@mailo.com <philmd=
@mailo.com>
Subject: Re: RFC sensor simulation in QEMU

On Tue, 2 Jun 2026 13:23:14 +0000
Tam=E1s Kir=E1ly <kiraly.tamas@outlook.com> wrote:

> Hi all,
>
> I am interested in implementing sensor simulations. I already saw that th=
ere are some sensor implementations with varying details in QEMU. My questi=
on is the following: Is that a good idea to extend that part of QEMU or new=
 implementations should happen outside of QEMU and some protocol, e.g. vhos=
t user should be used to provide sensors to QEMU? I would like to align wit=
h the long term ideas. What was the original intent with the sensor subsyst=
em?

Hi Tam=E1s

'Sensors' is a very broad term. Could you be a little more specific in what
types of sensors you are interested in?

Thanks,

Jonathan

>
> regards
> Tam=E1s Kir=E1ly


--_000_BESP192MB29196ED401270A194315234F9C1D2BESP192MB2919EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Jonathan,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thank you for responding to my email. You are right I was a little bit vagu=
e with the topic, allow me to elaborate:</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
My starting point for sensors is the <a href=3D"https://www.raspberrypi.com=
/products/sense-hat/">
sensor hat</a>&nbsp;for Raspberry Pi.&nbsp;It contains humidity, temperatur=
e, pressure, IMU, etc. so I am mainly talking about embedded sensors which =
provide their stuff via I2C, SPI or similar protocol. A lot of these sensor=
s have kernel drivers thanks to the IIO subsystem&nbsp;so
 the user side is pretty much done.</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I think there is room for development on the sensor side, like replacing th=
e hardware with software temporarily for testing or other purposes. I can t=
hink of a simulation which generates for example temperature measurements a=
nd those are provided to the user
 (e.g. kernel driver) according to the BME280 sensor's register mapping and=
 datasheet. The goal here is that the kernel driver (or generally the consu=
mer of sensor output) does not see a difference between real hardware and s=
oftware simulation.</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Always fascinated me that a piece of code was written assuming that it will=
 access a certain hardware and then I could swap that hardware with a softw=
are component and see what happens. Is it depending on an undocumented hard=
ware behavior? Is it able to handle
 inconsistent sensor state?&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
What do you think? Is this something worth looking into?</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Tam=E1s</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jonathan Cameron &lt;=
jic23@kernel.org&gt;<br>
<b>Sent:</b> Tuesday, June 9, 2026 16:42<br>
<b>To:</b> Tam=E1s Kir=E1ly &lt;kiraly.tamas@outlook.com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; philmd@mail=
o.com &lt;philmd@mailo.com&gt;<br>
<b>Subject:</b> Re: RFC sensor simulation in QEMU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, 2 Jun 2026 13:23:14 +0000<br>
Tam=E1s Kir=E1ly &lt;kiraly.tamas@outlook.com&gt; wrote:<br>
<br>
&gt; Hi all,<br>
&gt; <br>
&gt; I am interested in implementing sensor simulations. I already saw that=
 there are some sensor implementations with varying details in QEMU. My que=
stion is the following: Is that a good idea to extend that part of QEMU or =
new implementations should happen outside
 of QEMU and some protocol, e.g. vhost user should be used to provide senso=
rs to QEMU? I would like to align with the long term ideas. What was the or=
iginal intent with the sensor subsystem?<br>
<br>
Hi Tam=E1s<br>
<br>
'Sensors' is a very broad term. Could you be a little more specific in what=
<br>
types of sensors you are interested in?<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
&nbsp;<br>
&gt; <br>
&gt; regards<br>
&gt; Tam=E1s Kir=E1ly<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BESP192MB29196ED401270A194315234F9C1D2BESP192MB2919EURP_--

