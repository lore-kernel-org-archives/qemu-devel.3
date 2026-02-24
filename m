Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BA4EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6f-0001vr-03; Tue, 24 Feb 2026 00:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6T-0001ly-Ne; Tue, 24 Feb 2026 00:37:03 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6S-0001I9-2I; Tue, 24 Feb 2026 00:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHjqsZj7Roi6U9nmSnricRlRWgNUK/IUUDjOIKDrjNJGxoPtagcLcbZmNDPJ+eKopqFKOwijkKj9ZQsX2eKMdnWcxQyxrQ/eca/ZmtVUv30mKHestydB6WUuKx8l29r1iyy3zjnR0qcZpQDl3rnM43mjJi01HrXCq/ZV2Ej8hwBr8oA9pMCjsig/snud41Qcb9RC0FI9bAvU61s6yGjNgEvTIdhfHsejuTMH8pXZm5a61qPIf/VllRTRwdXd3CTYiQhHZUhgcfyk9k6a3TSUVWI+IsMxJPqABah2JhuzLYriVEYLxgS9UjNZn/Li6JuAD4T4kHit6qHEuwrtF+OBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgEJQN7A3LetzcY4YoTnwpWTyIH0rOx/JzL8j2HLGNA=;
 b=gViKLHj1giet0XY88DjmaP+tWeHwrREW+KtU/Ph9Ae3s2y2TMzTJAJarCHaZlFYkDBuVDrE/jj2l+f6fGu+6Xszyv+Ym8C6LHfCtdN1xnQAvUsd0Ksk3Zp0S/AQydZYnBO67imMcVadm7Ssgj3rLYCfIc3/JfeUy9wo21+hLd/VIdr8gc9uBZy2oPNBezf/6USn3TMoAv2hHsRA97OqLz5biKMjtz9S1ntRkYAFS/mGdpZoffMERT3W2rJLdvVzjZb0A9DwIpNXlrUgDcdKHMDqrf4VS+qaCRLf4eNYmL9pWZnSzg2Zvx4Q9cg1MWTLKU4ngVSCIFfhS3X/pucHsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgEJQN7A3LetzcY4YoTnwpWTyIH0rOx/JzL8j2HLGNA=;
 b=a4SjFqUIbahw2v0WPSfCnnMzu/q+VoOck19KBLYNQ0vR2qovRQEBKbupucaW8clzcrvfe0E4DNQpu9JHAP6e4cj3AEPKsFWki7fE54WPPZmlHVPHqPUBpQEKKnW1KciXkwteE+8y9ZE1EaCPPMFKRtXK5g1a9VrVkl5+0Nh0qoLUMfmbcXQoSIVlwEk+mhw+dNdrsriJrskb0p8dS9xJoG9TTFMAUMBsld7nJcbhUQjg+sZw8OkvHkdlSBsTysmS/NWc1K+4UAL/wLG2fm9Mb7KYonbgySCLriDsk+9xPmQFJcbJuh8846sQFye+5ym2Re+7g5RqUB+Cgse1D3gZzg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:43 +0000
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
Subject: [PATCH v6 20/22] hw/i3c: Add hotplug support
Thread-Topic: [PATCH v6 20/22] hw/i3c: Add hotplug support
Thread-Index: AQHcpU+OZuqm6KBljUiondA30Y/s1w==
Date: Tue, 24 Feb 2026 05:36:43 +0000
Message-ID: <20260224053613.589102-21-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 4544ac9a-91ab-439b-24c5-08de7366b13f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sTkLDBurc8nU+0wKWn01eF/SHvtB8oCsXz/z3Jlwc8i8n3Ja/sXXflprms?=
 =?iso-8859-1?Q?6AWjy/trq7HhbnSUsVCQuCJ1RuSdQadh86FqtIWFYxP+S4fx+T1RP4+iLQ?=
 =?iso-8859-1?Q?UI2rnZKtDZPCOwjjdQiP69dhxr8gBQQCsySsXryA07YAy4IUzWr4CtwWee?=
 =?iso-8859-1?Q?dTg0B7yoUb/h+E6yGW/usVkqJrciQpMDI4+eyms1fmiwJxPtK5mfDO/0iC?=
 =?iso-8859-1?Q?tnp+WVG0ejCpYQlaMqQOJCKo3yQeCC1reLfecQ9phynbx/XhhchfEx6p6J?=
 =?iso-8859-1?Q?GE6j2TjvXJyEVg4zNtJ6nSVU1yCE5kw2Z69O8z1lVhNgy8ytdr8x9boqoX?=
 =?iso-8859-1?Q?6uhZzBuMqd/EXP4fEBBwNqRqzoc4ppalspk0hkBkgjo8daPFLT3jwH2pMx?=
 =?iso-8859-1?Q?PV2dVNCfCARxjrmhxQO1A9Grl3a+CpNoV+QznQ7TpBNpvv3lyj08cR3EjD?=
 =?iso-8859-1?Q?1SvAuftetRIyx0eEt3gUMCJZr8KrUCFEUR9wO8gratrv8D/z0M9uHIzQGj?=
 =?iso-8859-1?Q?u+T4G/8LgG+bxf6myYaTwC1+aYYEth8n3EgvggmEivUM9ighDw7TOmzhyC?=
 =?iso-8859-1?Q?n9WmxJ2jXOnxd9kiFCTQZOpVOP11K5zXpBu0l05KO7vza5zaef1puglOUQ?=
 =?iso-8859-1?Q?GI4IvYLkvNrmflWYuK58qWJaE8sax9T/mHFfc+s5KLlqjF0OcEgN9gSnwk?=
 =?iso-8859-1?Q?pK5im2Q8+1iWc/4Q66g613b3/84SX8YE+hVeWQSFl2nIEo0VnfJbAbwStZ?=
 =?iso-8859-1?Q?PeBAGuN9z8/fm6oeFRp+FQPGeJEoM6kWYfecscy0EQY8hFNhH4IkNgAVdu?=
 =?iso-8859-1?Q?C8gwoDZuxNe79iu1EmbRUwNpQm9mEusW9omfWOLxKQs2ajvuKdtfb+PQh4?=
 =?iso-8859-1?Q?fNhHw9Y7VB1rDdu8PpBuoYAC3iP+Z1gmzs34GVu8iYeRFSjlGFpphBLiyR?=
 =?iso-8859-1?Q?nbuNU4IOJbiLtsiWGLPY3/sBBYCv1DXVBCXwefWY3ESX0X/VUTOlOo0ZLP?=
 =?iso-8859-1?Q?qZf13p6KILon7a6LCUJ5Q56xOixnw/tjzN7bnqsg0kbAb81PUuB8fx279h?=
 =?iso-8859-1?Q?CVi5qSysqoQ+oyv8FhLfa399bT2S3kYRtIW7hA5HbRnE+rdvri84XGYoNi?=
 =?iso-8859-1?Q?yxTFW0D7LriNRxFoWbIU+f+eo+jjVG/BAskOppuCHP7KoTQdPipe7X/Hgb?=
 =?iso-8859-1?Q?nlu+57PS/bsc9LPaZBWXz111VhJOE5nV8jdYeNwOveqkAnuuUH8yJYgxlQ?=
 =?iso-8859-1?Q?nDaAV+0sNHDdp9eCwrqWE4mbTw3iZiHPV5QABnJvmauwyQwbNVrUU8e5dT?=
 =?iso-8859-1?Q?Qoh1b0DbwZgI4N35Y99NE1sJTUWyBoF7/tPQglrD7fSRaidKHK+KRnvNvy?=
 =?iso-8859-1?Q?rQmSwb8Q2tRv5S2LeQRPV7AnB24T54wevOw6dt4R7Vi196cjLkIdGsQR0a?=
 =?iso-8859-1?Q?L9qNpETE353USsaxxH4mqFYmLKvoB+5PeKRnYHWxe483gFa59ZtbDoYzDX?=
 =?iso-8859-1?Q?smYJf7JJatI8/ZLEcGedDA9NMYg3eTlIbFIlBhPE7EizYT1ystk4u/1qyq?=
 =?iso-8859-1?Q?Tb81occCMF2JwWGDcAk3zfROH+cFeJfxGLnEqjGEps0I6+IAtgmh2xtpWy?=
 =?iso-8859-1?Q?gVC+Poxkqy32Q4JINYE/YnyHoHO+F5yVBif7D6X33bxW0GMmTaOlp2g4Wq?=
 =?iso-8859-1?Q?j0iIuUb0w0X6bcf9NAiS2sZrwuThIf9nI8x905vm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eVgc2ZlfWwrql849VXKCi1nPBHzSyxbahS+mMR1Jhg5d1tM6I7Utm/v9Z3?=
 =?iso-8859-1?Q?HehreCqQWbJyRZdoy8zVLwr4m/m5YgGMmNW93LuQVgfCS1+gC5xhduXywm?=
 =?iso-8859-1?Q?Gr0WAsd4D/jvLcrXJIwQ5SeC9LqbUCYGRDOx0wMH3ORKko8/8fma15ACCa?=
 =?iso-8859-1?Q?PymiXnqzt7r2cUr/fUXtNTh9FZLnzHZeoGPsSdnwQt2GuzW+4TWNRBga//?=
 =?iso-8859-1?Q?7X3oJ8hLQ3GYgGJ6EJ4LwQVHmzVrq+jledC6fFsmkEGRU+ICZqQO54i0CC?=
 =?iso-8859-1?Q?yNkGxyiCxXXAjh5Vi/NS+x87fSEJf9nQQ6/UFPw4LxRIvDsAW5FBUe7t+p?=
 =?iso-8859-1?Q?70WXgBIkMntr4Z/wFgdUMZ8Ef1UgkG7OERD33AFSQYh2I2m4Cgkc0HVtDV?=
 =?iso-8859-1?Q?W1h2m+L1eNj9ExJN/2nV1+RnFQrasRzJygQZ4J0OgbFamQsDTqa17BR8iB?=
 =?iso-8859-1?Q?fOCR016Um0pPlkNWeC1FwOUhp0yr5TwAgCQtmqN9F7tMM5Hd46UDNkLFCs?=
 =?iso-8859-1?Q?isCq4AIGR47RDcMfECEpTfbAYqMqvXkUEGnpF84FVwKOSzORsa6yHbj65J?=
 =?iso-8859-1?Q?fQ05eVt0aZWwCqffGlxbgVOL5IqYu3tkTjaizudStozsDW94yf3/ejpMej?=
 =?iso-8859-1?Q?621f7CihPmZmVUcuM7uNjMAtDCHbdgwOQGVfb3RTYsS8on4iyYfEVI0jSV?=
 =?iso-8859-1?Q?RzgOSILF+ju2MUKDCY+GW67DYDPa+UupIsVxZFwsANuxoeRjyIWLsGraej?=
 =?iso-8859-1?Q?YtX+k1X9iR/X7pnKSqmWG761TEvOA/djSu5HFgrZjpA4jJCmk/hn6zdD1x?=
 =?iso-8859-1?Q?QwLwY7FR5gfyywE1uuQ4zZrfG/hg3OQ3KXfVTCq4vz0Qu2DErTZ/zqec7n?=
 =?iso-8859-1?Q?2hQWWXdz7SvXCutuqsTluPukDUGmdfnGpXMZi+51HdGFNvhZPW0metlZDm?=
 =?iso-8859-1?Q?ExIFFUzmdGWEcBoMxl5JeC9V32zwIf1hKbGUUv0/B1hMj5cXYzB4CzX53b?=
 =?iso-8859-1?Q?XR67HcE/G6lnoiRMrmHx0CphUrXBl3v/ilC6YCCEI7q+VoGkjQGH5Zq1kR?=
 =?iso-8859-1?Q?LkskpFpiZM2ho28XmI8ihOEpFk1LxIkNnRFI3hoVrA8F6IIlh8SmKwou7q?=
 =?iso-8859-1?Q?IycUMUGlqA8HbkE7os+QEx6V3Yplr9EaeNajyW+f1grZofjxxVqnGmRiSi?=
 =?iso-8859-1?Q?5gYp9fZlT2VTAKweZUcAp7QHI4S6njJK+JREjODhBsHdGsZGP2cSwbGZHf?=
 =?iso-8859-1?Q?5pBOHlG3l34eBvtlUoDWyPdFNozUudF4RUHj8bKrqi8IC8PyZi8Mjw/QwH?=
 =?iso-8859-1?Q?eRukwlWgqNi4ibj2LFkVfu1cfvfujiiBAPpB3nsubaktkbMr84WDHxdjBh?=
 =?iso-8859-1?Q?1VEds4lKLgOsz0ijyRK48Ex3vBMpzkIdejrGlUyHSSYcC9tKtaW5YAPrye?=
 =?iso-8859-1?Q?s1rXRr6nFyGKXP7hs4VgrG2z4P6IMmjd7Pzb4hPNlI8qyxU8RY2OWObd1A?=
 =?iso-8859-1?Q?161o2AsBhEnNSVWn0/wlZJ5kIhZVAsmEB8jwzuLR3R9LKIfBvlJL8nGlX7?=
 =?iso-8859-1?Q?uaB104qYZi39OybCpHH9bSSenASyCOiXaSj1tOKiwe5ZHaa5bZVQHkEMbR?=
 =?iso-8859-1?Q?FReON0IqLnKc67olKeNRWx+9XZrYPXKBzhlmXh+2OyxqEle8PTmf4v4i5U?=
 =?iso-8859-1?Q?0iCi9wKPsDGk1lnTQqxtWLyBfsxihGhGXZvYR3pjc6nrX2NzJE+N+Xpq7k?=
 =?iso-8859-1?Q?kgofSnysmPpDndJ5ITdiL3/azsTpzcl+GxxHcc+3tRQgeqSXG6jEclSZs6?=
 =?iso-8859-1?Q?9XfmXz8niA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4544ac9a-91ab-439b-24c5-08de7366b13f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:43.0690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOMZgaXqPBfElizMPx46MswnD2froD1be+qhuIXa3PW/ukvPaXro6MRQcy3z2C+k4q/ajqbS9vjXIIKjEhvkspBeboiuNJsLCdI62C8d7sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
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

This adds support for hotplugging in I3C.=0A=
Conceptually this can be thought of as an I3C target being physically=0A=
socketed onto a board.=0A=
It is then the target's responsibility to go through the hot-join and=0A=
DAA process so it can participate on the bus.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/core.c | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index 22e6e226a7..8a37099ce3 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -11,6 +11,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "trace.h"=0A=
 #include "hw/i3c/i3c.h"=0A=
+#include "hw/core/hotplug.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 =0A=
 /*=0A=
@@ -26,6 +27,17 @@ static const Property i3c_props[] =3D {=0A=
     DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
 };=0A=
 =0A=
+static void i3c_realize(BusState *bus, Error **errp)=0A=
+{=0A=
+    qbus_set_bus_hotplug_handler(bus);=0A=
+}=0A=
+=0A=
+static void i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    BusClass *k =3D BUS_CLASS(klass);=0A=
+    k->realize =3D i3c_realize;=0A=
+}=0A=
+=0A=
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
 {=0A=
     return i3c_init_bus_type(TYPE_I3C_BUS, parent, name);=0A=
@@ -633,6 +645,11 @@ static const TypeInfo i3c_types[] =3D {=0A=
         .parent =3D TYPE_BUS,=0A=
         .instance_size =3D sizeof(I3CBus),=0A=
         .class_size =3D sizeof(I3CBusClass),=0A=
+        .class_init =3D i3c_class_init,=0A=
+        .interfaces =3D (InterfaceInfo[]) {=0A=
+            { TYPE_HOTPLUG_HANDLER },=0A=
+            { }=0A=
+        }=0A=
     },=0A=
     {=0A=
         .name =3D TYPE_I3C_TARGET,=0A=
-- =0A=
2.43.0=0A=

