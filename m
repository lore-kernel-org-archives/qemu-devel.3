Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F12E8B364
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOc-0001ZH-Nn; Thu, 05 Feb 2026 22:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO0-0000TB-Va; Thu, 05 Feb 2026 22:20:02 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNz-0008HM-9N; Thu, 05 Feb 2026 22:20:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY7u6T1AyooBNTOBCHnuf3xY6LgCS9r0VIVfQ27G+WH/nELpQ8XYuic3du4oS3ZmKl1HqfSV1h+nQuWBW6zRdDg31tszBruau8Kcm7SaY+weFIfMTL/4BTNeuWIUTlXvGYBv0RA4LYv0cbkfv5fHAl5Q92aosJcuMepf44b6hqjnBlSDcKjbIHNfNt4/hluv6eRB4482cVYFViB8Vn1VzxmIqhTJfXWgDOyE6WdK2lox4xx3PJYa6044IAYXE1CbTEYH5zWIAWzx6L0kaQ+HgNxdXE8+BCAyv1/PK3vvxr6dwktbZHNNDL8ukDcavrI51jSZ/t4TQ+IL8e6rwpS9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZeYi2k/BYUyV6vZVVsERvxZE4kz8SZQz/9OzF+gA/4=;
 b=qH0yABRCR+MnlhsdbNQiXRYp4LsYJ0yzWo9jAcR/VVxORf3VwJEgqDEUm7CQlrL+9NDSID7fZbtQEvn9cHGhQnAb5QJ7dRBY6hVweHQz3GpM8pSIUfZ2MbTSxST4/UQIqeq8gwDNoP7IxFpE5e9xrjbAQxpxgCfR7hQhOwSxuseOXhJURjH75AQe3Wb5e9VFXXfahOmXk9JtbkO4DCtaCWPnDymDAD1lalNCQiYIRowArA1pzRhP0ZWevW/bnFnHAtAB+/ycUcE4Ng6beCvQL1OLRVW/gyNy4MWZLDnIZV+bHysZevi2WI6XRsrG5B9kbcJpza2j8sXpiP72lfGmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZeYi2k/BYUyV6vZVVsERvxZE4kz8SZQz/9OzF+gA/4=;
 b=OvUPY59xsyQoALhpzlRWfQwXsgFusJSLun9VQzx5YZINw9UzxEe68MBKRywRBWXxl/49QeZq159Rr1Eyi5nLDKzW6NiVR/+FdeiZgCZ06ZMa6mptX1tZLNqTzpLdNGjWWLZUgSkO3NoRpqNGJuA0gtpHw5HG/g92fTYJBwnHf6u46YeSu98tn8u0QcXOUEAWIhDmjsCWMa9OL+wBqJPHkmWd4i7dNhyMIrijgD+CbulFEfqtjJ+hrqK4M362wVY/apHMgRhXYpuwCDgvGbrIcf3NebowRjHs56HVCM1atfRG2+MxEfWeIOQBnR21lHlubIK1PigxObizSe6aNPygUA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:39 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 08/20] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH v3 08/20] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHclxdtyvITQkQTT02cWMiUplCsig==
Date: Fri, 6 Feb 2026 03:19:39 +0000
Message-ID: <20260206031926.3227848-9-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 5db8e429-3f8b-4a3b-fefb-08de652e9001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8G3NCyjzM7S2Jb4A0k4PTHTeB2Zrz7Q/hvWbjAHCozk1SmdmgUo4iXpCuI?=
 =?iso-8859-1?Q?b0rOM3RwlUoCyITjG4+rniQXX2TF1n5tg9cFazxstkO9t+F7341I5NBrBh?=
 =?iso-8859-1?Q?CPriPHqzuQ9XxtS1Ce+XFr82d1eZx84Ou+ggObkUCDwas3tzE3MzJzeKG0?=
 =?iso-8859-1?Q?jUGU/HbBZyOb54CY3xzVUFrpY9DGlzEic444ZgG4ODoOurUDrEw8YaB9ns?=
 =?iso-8859-1?Q?mL+gDh2eBgObUQF0Xy7w/EB1XPHgVgZhxF33XkXETBLgashz/pXiXD+rX4?=
 =?iso-8859-1?Q?DMrkqLoHlLdiO0DvszF/r8993oAW4lZC7iCUEYKjeoQZ9UShIEMzFJZJcq?=
 =?iso-8859-1?Q?+QUbwUNupUYuMmX2Y4PllKG5ebTnLEq5ktYsGG7zDJmD56Iih1eq1J93uz?=
 =?iso-8859-1?Q?hhZzwI2nr7QfgKFLgEOIz8Jsd1ByyY9rtzySPjKh8iLiXA/OSraj1teCki?=
 =?iso-8859-1?Q?/kCX5wcHXJzjwPSzpWPLvrfJj/ub86jDPc3jDpRi/6VdhzmTrINbfc87HG?=
 =?iso-8859-1?Q?jZp71yhdIXGfHY9dwBzV7sQ8L10KtXC0vvFZAu7si/0cT3XE/7qbCLf3iR?=
 =?iso-8859-1?Q?c9zLi3PoWbDxj2+VGp+i2fTn4Ka5FjRDvjMA5i7T1WwAG0NC0upxuZTgKX?=
 =?iso-8859-1?Q?583SFUpls8BU7CWsLsvI4cW9qjDLLzxIS8AoDJDTMeLDfx+taSl2U7m4ny?=
 =?iso-8859-1?Q?/lj6FY7YyUyEVVKU9V7zsqVk0tWyV/c6yJcikR74qYm8zal00j3ypdGwKf?=
 =?iso-8859-1?Q?Ss3T6QjJe19h/DMiug+zkFXoHkgMEMRByNOUCX1BbQiMEnnW1b9ksaobT2?=
 =?iso-8859-1?Q?tNWDwkbA21cCZARh2Dt/BR8BfD+6DlPt8W0R/Ja9H8zt3ZvgMYZ9W0FLBc?=
 =?iso-8859-1?Q?V0NyZj3KOYvlg7TfvXIfNGa2Siu1zW6zXz1HJpthZM65hKbvw6LO+2IWRA?=
 =?iso-8859-1?Q?bowhVuN3YAcqF+CY2edGsETvqUoJTbZo4jdNKgwomC7hWz+GpG+I+GY8IY?=
 =?iso-8859-1?Q?1H+ZqpetQboBJ1iv5ZkXKHL+rtejePsFqqkrkbt2hWSWMhdUW1ABMLU9f+?=
 =?iso-8859-1?Q?bJSIFkcZ4TkUAI1lRpbkyMmYOymG9hxW699rPusimIE2uSNGd0YfcsTh4l?=
 =?iso-8859-1?Q?WtI+1REFpzNP3Y9FnRYky7/aSzZGuxAig0opWEvSoXdonpjvwk07sK1Drd?=
 =?iso-8859-1?Q?qMaBpegjcre9jw05+318AYg7wDv1kflRVcqlnGUW+Xjnnu8w7lvMsKSVrF?=
 =?iso-8859-1?Q?cRWZiA1hIYNPGCUYsZedZ3RQyEtBEuyDfzlo5HDhtI4xKtWLf4Kcc3DN4C?=
 =?iso-8859-1?Q?R3SshrIcH/5AqePxoQMZufbz/I/3n6g/i951n+vq9xwWO7NaXptjFjV1Jw?=
 =?iso-8859-1?Q?REeQbaGi1vgMuKg5h704X7g2WRzm79RZKVUX+1phNxB4rnS1AEC3PPzRnG?=
 =?iso-8859-1?Q?1a5xTPjX/5LJ2pCG30Xn3na7Qi0C2s7koMoAW75D1YGrV9IjG1bW+MWESG?=
 =?iso-8859-1?Q?Ns/weG3ZRzpVGdS6nQo+DiybshmsrT0y9LQOnHcJX4cplIa12/rIHX/a0m?=
 =?iso-8859-1?Q?rKIQWoWn/jx9OIlxfZKID5MOthPx4WBkX+VCACWqc7kaGPp9LEcEFQZiDX?=
 =?iso-8859-1?Q?2o2K6iYyow76uh09JAmf2EYO8KVuj1Ua2KdprSG5AWgc6j6EZVqE/QDERv?=
 =?iso-8859-1?Q?54i4TIdP6QGvUqHb18Lcaofc3RokNdN06sxWrmQe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S8WUBLfi036dJfFG8nXt2A6h3HpkSOG+IyBQVo5yO9Y+CCPRjXIX8GVXLC?=
 =?iso-8859-1?Q?VOW2dySoF4J9cZ/CmLG5qxJbE3yM21uxZrsl8tqHtstvc3btqig255xLt3?=
 =?iso-8859-1?Q?85r5z4WNgjaf3Ab0fsjomPtXmq0aKyUc5VFgWbVwEiQT+NlzUr+e3BlxmW?=
 =?iso-8859-1?Q?U6kcGcsmHOmQAG4AglJhtWeZCq7IIVivcVpn15XggYjLppIedAVWudHVzw?=
 =?iso-8859-1?Q?Xe0nEP8cLGOCEw0tKHFp+zajNsm432UzonNDMHyXWtmilQn1lMIj7bXKw8?=
 =?iso-8859-1?Q?7OXQFG4Lj9Jf+JOtlNHgS3CleehpZ7zcaoAEBbkHxxWlVQszdlCtsBjTNe?=
 =?iso-8859-1?Q?TKYR8d27XeEXX4QJYGLKOxJawR4jCa7BuDVd0BwVtb8OvauFMyGjd4YX6t?=
 =?iso-8859-1?Q?+k3xjTYq218Q9VhAyTV6KA0TmN8zLZA1JfgyWba7auwDHRXFWGqq22PCvU?=
 =?iso-8859-1?Q?o19SiVkNqoI7KxyxbB2fol16W7gpCTofLGb1uK2ovofZeAhEBnsN2j8ypx?=
 =?iso-8859-1?Q?shmhm86SFHHpwps93FbfAhTPjkBkeSwFBlARxczjxqQBG/E3n5GrskmqXn?=
 =?iso-8859-1?Q?6gzUdQb+0qKMnM/QnFz+Dpq9qzWQ8jmFGQb0OsR/AZliJTYfSI2rH2Re9g?=
 =?iso-8859-1?Q?Myq/MYw72UfLf2iN6mrnvMUw5nvKYUA4+RFX5M7+H48yYbI04IrHFiVNb5?=
 =?iso-8859-1?Q?N8tZdtYgDmfy7SHRgBTl4FjaMeH7nqGgAw4NCTo9cVV9jdarYvEPUx0dJv?=
 =?iso-8859-1?Q?hLKmoKylw8TCj9XlY94qp0JGYt4TNwZv8kdoa5D5ZVJdhKk4TC23jb6QwT?=
 =?iso-8859-1?Q?tWpnni4CTZSbWC8yWgnHFj1vWe+RhzYcy/CWSrSSAQdfu/dDVLipoVxBY2?=
 =?iso-8859-1?Q?QK/rGWM9bMKpa9byzAZtyELPl55PbwTifjF8byBvnVYLcYOUpAOi+9nhVJ?=
 =?iso-8859-1?Q?UNbI1LHciVbZKVtRBc3ov3BIM22tmoMowtc9qFMxBJ+kD37ZA1pSWGGAze?=
 =?iso-8859-1?Q?FNTHcr4XC2sWeUZlgSJq6s7ngW0R+nqNSkbSoP0+FKflMlFMTtuNHRblqf?=
 =?iso-8859-1?Q?0fmNTY966itr4bj42gtlNW9uR0UNgrT5fVVdZqA+9BbTr5el7KFQYcQXVQ?=
 =?iso-8859-1?Q?iQD8fB/KOOuxwlJfsk/izUZVldOGuZ/bW9aORBUhGqAfISVZpBiV8+58yX?=
 =?iso-8859-1?Q?4W9LGetRLpB5uPOQTYRc+mG+awOMpg/agwgDjqoJl34SPONnB0PbhzZK9i?=
 =?iso-8859-1?Q?mJvrVYJge6ZoXK5t/NEtfVJrERcd1N9Pn0qRnF6DBaXLfWYW7q1lrye1j+?=
 =?iso-8859-1?Q?QpQI8jPBoK8OyehS16Ju3iJ/LYRFUGP4VVZQS8T3CF3JOqHgIxf1hsLNqP?=
 =?iso-8859-1?Q?K9/v/cjKJzVQNd6E+CAto3QN5zvVDS1YwvUayYXJbL06qTGSk4PNqhDMlx?=
 =?iso-8859-1?Q?J58O5Qz6OwPVH6lDIN0+SHnwUNUG3mjrTIcSO3UhId0UgkzWQX5XK7IcaK?=
 =?iso-8859-1?Q?TuRlR9N94JI08oJn9yNhDeDMe9XvxqMWReARmfWBo+Osc4Dbo8u8/Oz33B?=
 =?iso-8859-1?Q?qiMU6Hiz42iv/7sSoCdLkSKKeMlu7EqhrwATJTFf6JE8j0o/FnoYuJdoL5?=
 =?iso-8859-1?Q?AtiJBtT/lUa1EIQ/5x/yNKKjpiyxJZFGH7gYZTyIszRl5serC0gLsYZZBQ?=
 =?iso-8859-1?Q?jQktQSEH90O0aUhzSLTXOKx4mj3Bw+p43KW9vVys5Ch6p/MmPPkqA78gwP?=
 =?iso-8859-1?Q?Hxt8jJUTsirKCLa+WFKTVbVpOfRBnT0kihgl4YLR0J77bz7PN/m29La54H?=
 =?iso-8859-1?Q?r6u8m5ZDjw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db8e429-3f8b-4a3b-fefb-08de652e9001
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:39.1699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFdyRq0NkjI4cIwDv92GdUXBzl7rNe598753se8KE8of+I4jSTOVJT06XayttNq/xeQCm1+wTBaAKmk2KRN65bDKFBxEgUdIaCP5sdxHrp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

Adds read-only register masks for the DwC I3C controller.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 40 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7bb33c7a9e..02fa9b3c00 100644=0A=
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

