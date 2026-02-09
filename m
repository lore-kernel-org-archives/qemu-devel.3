Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F7E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO9-0004io-KP; Mon, 09 Feb 2026 04:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO8-0004iH-Dq; Mon, 09 Feb 2026 04:17:00 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO6-0007K1-Np; Mon, 09 Feb 2026 04:17:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzGDcc8CEZUyGZxTK9lgx7uPQzWQXvJdF8xkHDmnuOTvK/PocdOwI/BXtLxv7XpgPHVcwNs3HboEvYi5fjhmA+lKGwkZmwMGpYBFHJFiIzwttj24r4sWy5gxSJQ8zArn1XvKmNsiYBKPqIlMX9oDnYaYrthiUh+JTnfMjI4qM2ZDOPi2qolKBvYVp68E0Z5UaUT9Qhp5A4cH9nXtjj8XWw9Nen+JgegxVOhvcKJkx8BASDVFyXTOlvA7m/N8UUoFd+/lzfPkjV+TSjyfpP80NRSNIxuFqRXqByXl65JkTVmXlS/s6wE1PR/PVHo0t+Pz5vNjP8sG5z0k10D7KiU6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qOXWX1izpfi9XeMDcsw7pOXBrxewnrpCD/Sv9BVLCo=;
 b=u0bkhlpV2BJkoiPRCO4GzTcLwSn3yN0CLTPAFB67UdR2BmqHDa0JA9u+G4awS4KPoagRi2EblS8C9GdgWZZ2iMWQNOj5UWqYceIxUtXQt+E8Pg/D2aW4YKmD1L1/lg8TsN6IfT694DBCj1JKj65i20oHLsGdRN2bBmSEAo43UyoJnkNbChOtV2HcKcoLDlR1Pz45MmU1Av41npvPbojfFZHubazTL0IS4KvXulqg57qXhE+OfCAN7gGFZv1nx7pAXI5maMRUeKCSAUood0ywCQVYt+fekGRfAgyLSbYNVIXITRPw2irwjbcVNI4pPz77fRj8RqM+Pr1IWO9W+OTJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qOXWX1izpfi9XeMDcsw7pOXBrxewnrpCD/Sv9BVLCo=;
 b=HmYb7gBTYS6hwa5XrzoNhvNf1Gu/n2Vd/tYPWQBozx7otJwRF/neQYbyfPEYOxFyV1Tt6zAgI8FRCTSjmrB6frGSFbfFaSTP962HpHjkLngPmqhr3FlHXI2GzJiCE9BArvjxGq0u4/qlr7Hkbf5yAztzRM6Oxhxz1FEdtlwUo4KZJUZ2nAdktD5umxJi1wKGbdWoIHCRSeH7LkvIFJ+h8esqVQvGyL4T3Iu5iADKbP86Loa2D0get5um1ZhwUhhpn1b0oM+Ko+BuwHfXRal2RRotCx5LT0fiWe8WjtGDJYLJNrzSL8bBhpmCzNYgvesgRsicgzSgEGyazlRpTQnsbQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:53 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Titus Rwantare
 <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v4 14/20] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Topic: [PATCH v4 14/20] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Index: AQHcmaTTTH2ix/iqeE2WWxB3NjWyrQ==
Date: Mon, 9 Feb 2026 09:16:51 +0000
Message-ID: <20260209091629.823457-15-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: b981bc41-879a-4d16-ed52-08de67bbf6cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5oVl658KJQfCr90i0y+CDNx/1IC7s83f3YPp+ESddwZ0O9e2W0892QcRaM?=
 =?iso-8859-1?Q?M7hp8wB8BTlqzVwzKBOcbewH5wTWXqlCCAZE15/RwHql2Kc5zk1HzuwMgZ?=
 =?iso-8859-1?Q?lP8f8rA85TedzEEl+YzOlPqnIwQ4yC++f/5c1bFAsEvGOqYRJXeSmznRT5?=
 =?iso-8859-1?Q?dIJH465KlQnDngfv5j2ujBKjr5eFEm07J+jrFL8bWoEDf/yx8bwRFGhXdc?=
 =?iso-8859-1?Q?8kGwxBmdhNDphNAjOm0imV3Fhuz05yIn+ObP6EWWTS7K5ivsPOSgVmM5Cw?=
 =?iso-8859-1?Q?q4W046K1yzkhUbiDNdKAObo8Sj23zrBdAk3gjNXPq96vdZmo7opF2vyq8P?=
 =?iso-8859-1?Q?JNgoJqohNw+a4Md+BJwck6pD6dhOCq22nknwsCoLA/nmEStOJcLoelu7k0?=
 =?iso-8859-1?Q?AslENm3y/RhwLBHe503mRknSoOB7DGFKQP4QSnNas+HDTkiEBpVFE0hUHg?=
 =?iso-8859-1?Q?S8bfOzAh9eq+WHCiaITyV1hixhpXnFdSscKlRHdL5C4VXGddh8m1REIthM?=
 =?iso-8859-1?Q?4GwgcFtpFv4lUVfDH/68XfPEvp4lDXbOGDu0JjEVYtJTKbuYn4qgo1XeTS?=
 =?iso-8859-1?Q?9y18gaTUeGxro97FG7DG6XJJussUoozD6idilYPYUYj3+xiA3rFxqx92xU?=
 =?iso-8859-1?Q?py8BxTIVhU4bY80eozmeyQmePvhjJTVHkBMxP730nuVlz8CZSQ11HXCkBm?=
 =?iso-8859-1?Q?EGpr8ySmSPkOwviHgh9ZRJARTVTEZAhIqypdMnlM+66Mh7+cfUmmmhvTOQ?=
 =?iso-8859-1?Q?UVnRAKfTHpKj0w3h6G1zVdjVwDkcHoHRTlEJ9meEdTUdGGbR2mLoRhl7GP?=
 =?iso-8859-1?Q?QfFmbQUIDT+Lac7hT01e3a9cUHjTekqa+RVPzIe9Qs0JCzMHha00i2AR4L?=
 =?iso-8859-1?Q?mxEYy0KgfPYa6vrXSKt9hu72F9KqT06HaASf+iaVUfUq2ykCD/o6/B2ePe?=
 =?iso-8859-1?Q?z8XC6sa/A7WhIw4ptFvZaFESEZGWKP273hDxRu0pbAQ21BzkbtpYd+1nDB?=
 =?iso-8859-1?Q?ib5t8V1Et49wyquEbh5dNlzhiuL8cAvbTsbBEXANT/+pGf7t49KXSqCiVh?=
 =?iso-8859-1?Q?Fp5Ha6QcPGHLYUN3AKkTRqbr/Hwpe7GrZhY8zw4v3EjNnQtm8M3gdEb47D?=
 =?iso-8859-1?Q?YH2No344fQyKBOUiw+qXSQQYnmxn19vNtkDbfS6oCxD2o38SKrIBQuJKlw?=
 =?iso-8859-1?Q?G0fU9iX1rYG9vXjS2+0idV8fHw6RLC+M4G/wV3EavmiGZO5jE+VUPFNyzo?=
 =?iso-8859-1?Q?JGjWI2DvNDxSySMlnS1DMbSMKh3Ir5w/oKGqIAqgKalKn2e0PRcY4hGNpl?=
 =?iso-8859-1?Q?tEyxraEkUYBSDY666B8dxC7Wwuhd5FKfogjBN8BLNlNJcYZd3X78fkwbcO?=
 =?iso-8859-1?Q?Xq2qYAc2UxATGYPC8R1MOk8S07kXCQFmmBhTyRAsniXlPQa1m9ZAZeECMO?=
 =?iso-8859-1?Q?UDAfNEKkia13zWxOc7IkTL+TNwMumnFdHae1TPDAoGU+E023ve2tHfodYk?=
 =?iso-8859-1?Q?KYKH3GcQiGVJRqsdI4k0r9kf9YDgVzB+C36z7MIdVManYxlYXFcqnezSkC?=
 =?iso-8859-1?Q?1U093dITpspIOdSok+OX0ax8EFGfaP4a5servTjtbLtafRx9leiHv3Tr6J?=
 =?iso-8859-1?Q?Jtr/drrasFIMTdkRgKMk7U2jXogakO2H1BsP5cYC7x6FoCZBXqPf5ytQBX?=
 =?iso-8859-1?Q?9FGZ1vHwQY2remoeqo9vgyNR9aRRwnHhi713kifY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cm8LcVPYET/LPn0xCQyzBH3kLb/R46eM+w48Ku1QGUW55ZGfvps0utKeKW?=
 =?iso-8859-1?Q?L0zJUajvPDZ2Maa+gT3TnBJnuODVy9yGzuvweNjJOTgtSfWaNj+fvkBlW1?=
 =?iso-8859-1?Q?+aQIX544pSE+iUYoNioeTmIbjiKuOl+Y0nGYky4BhggOIFJnuhWhczlpS5?=
 =?iso-8859-1?Q?/LXHUlpxpLkN2MYVVSzvYyMh58aNcMeSj0GH9hZP8UxiJ6NaM+kEjYrcPU?=
 =?iso-8859-1?Q?hr1kzFfJ+CrtJ/lWo4ASWMnCO5VX7YQBefhlecmhOAmabZFNpyMVXmC97L?=
 =?iso-8859-1?Q?zjMS3e6XLl+qwwmILSgRG6gVmjcu00PEHgVwuFFT/YOJDUWlmrG32Ju9mz?=
 =?iso-8859-1?Q?wtsaTytKY/v5nLenMXFzQSXzy0iS8dN5LhY0IPne68zCVe4rqNzRK8Jb9N?=
 =?iso-8859-1?Q?zqmA+JTezpIPAYDYiPiPmBmZjHemgwxj6YCxGeexZ96VIL0XqsdEG8b6Wr?=
 =?iso-8859-1?Q?q3e8tisNIYrEOLCl+iOOb2vxEA801mVjVe7MkzqIGqN2P8Hpy9qurFo2To?=
 =?iso-8859-1?Q?AWQHI7eZRwEXMv9q5XSMIQ8wOaXPCiqdyJeSztwR/ZmZ9ia4soZJBzHGRb?=
 =?iso-8859-1?Q?ikyQoJkmndUVHCumzDZ13cTDqb8cZntEGxntJPIGP3GhYD90hG2lwWgyX6?=
 =?iso-8859-1?Q?8fpZazrT1ILKyYxoFtggEsKeDKefdueq4t2dRSPz9EBtQzSf12/T8vhbSB?=
 =?iso-8859-1?Q?aCF0hWKLIgbyCKrxgX22f0nMlJMOqrwEenSTLWcg2kTK3ShrbFztLpI/Zh?=
 =?iso-8859-1?Q?3YgNq9F7+v++YW4eR5sAZoB7XYuYZghBzQy2tzwmAsc00nkIK1QDKQivC4?=
 =?iso-8859-1?Q?BI3iuV41CRC0XjtETcOCIBYjxjmHcf6qRvPq6TzjGcgpCOnWZUiH1iiFgq?=
 =?iso-8859-1?Q?QA1kOTzzMrCMRBK0HbozNIAWlrb5SErxFoxPjb0aH+WXNQW9HY3AizfUb7?=
 =?iso-8859-1?Q?eHeH7x5VcpUyz1WQsGt3Kl44cUCyfVuEZmHUHEijAMMyRRv3Z3R/4ZdLUK?=
 =?iso-8859-1?Q?vetSFvim6fvgwzVD6Pg+EJ12Zn/m2rB9w6yf5aGGGrVSV/T+EG+6uO9m/T?=
 =?iso-8859-1?Q?F7ZKpWXByxTBdT8y+V55dWO3/fUscVgqzQGI4HLb8Zb2tddSdCyRKqgg1S?=
 =?iso-8859-1?Q?sNmBBvBuIw71TsTETob8j/q0ogbT/XECXnaZwMzL7MecMxfVbA3fAXPtOv?=
 =?iso-8859-1?Q?qwIspaqkm/GWfH5jGT0O38hhRxsYqOk5g8KqyrcDmdE/6COCIDe+bVaZG6?=
 =?iso-8859-1?Q?NA9I009aVetVoXnFW9ODeqW8TJOxpoWsIjbmeGe1D4YtEdClTK+urTrG92?=
 =?iso-8859-1?Q?sSFroGValWINNfAgNp+RRYprDKO0CnKV5lsXS9FbHwumZCt1nEmjQWFjlp?=
 =?iso-8859-1?Q?w6etEGBlBQv7+c2k4mm0FJroONUWUVseW8n6m7WwmyAj9RZKFenRyLLqDe?=
 =?iso-8859-1?Q?6ZX94B228z6L5Tjj414waUxmGeLUldyx685wlaeTfeyTpsfBCgQHzF0tVs?=
 =?iso-8859-1?Q?Bdg8vssQbg7ohdodkpVq/3SOhPPzX1kfz0fnIVai/96Hk/VJaBQ+3g8MHT?=
 =?iso-8859-1?Q?i8KrXmzD5h5vaUStkwHcCN5jJhKhZ/xRTE6+2SdWeQakjNiF45AoOEuEqy?=
 =?iso-8859-1?Q?AiiDOnazour9tRIAlMSHHA8o8TEpT576Q+5tTyKfxrrbR8khJvdSRaZ4S9?=
 =?iso-8859-1?Q?Ag6KwsVwCF8ZNv5Yf30kG4Iwam8EkRzSj/t6U83Np6k3SxD/B/3QvqMLuU?=
 =?iso-8859-1?Q?LIbmb7T8uQXSu1DsGthsmYmZRPB/RR89akwZ9xzoM4WRGKuIv5dyLbP8fx?=
 =?iso-8859-1?Q?QoW77161mQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b981bc41-879a-4d16-ed52-08de67bbf6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:51.3766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzAwMDtH24ioBablYsPhN/BZClMqN0xD/zF94j4IANMxFuI1NUSbqcyHv1ML2KTg6C1uXqpJ9B8eRt5Hp0mRf74ae1tHSGNWBe+LOp0JvwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
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

Adds functionality to the CTRL register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 35 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 9a0460cf31..7a1f79e10d 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -344,6 +344,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s);=0A=
+=0A=
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
 {=0A=
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
@@ -503,6 +505,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uin=
t8_t *data,=0A=
     return ret;=0A=
 }=0A=
 =0A=
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /*=0A=
+     * If the user is setting I3C_RESUME, the controller was halted.=0A=
+     * Try and resume execution and leave the bit cleared.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);=0A=
+    }=0A=
+    /*=0A=
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP i=
s=0A=
+     * sent.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/true);=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    /* Update present state. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+=0A=
+    s->regs[R_DEVICE_CTRL] =3D val;=0A=
+}=0A=
+=0A=
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
 {=0A=
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
@@ -1575,6 +1607,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       "] =3D 0x%08" PRIx64 "\n",=0A=
                       __func__, offset, value);=0A=
         break;=0A=
+    case R_DEVICE_CTRL:=0A=
+        dw_i3c_ctrl_w(s, val32);=0A=
+        break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
         dw_i3c_push_tx(s, val32);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

