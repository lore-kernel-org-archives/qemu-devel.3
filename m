Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEE7F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OJ-0003Wu-Gm; Tue, 24 Feb 2026 21:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O6-0003Pb-Bu; Tue, 24 Feb 2026 21:12:30 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O4-0000Bm-Tk; Tue, 24 Feb 2026 21:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZwO0iBlMPi9DPodiWJ5ONwxdJvTUtaV70S/ycu7DWG15cIX8dXL9/40juxpnaIu+k9qOoOMFH5AVpuwUACFHreBH633xtJ/QcTlQ0Vb/ZD297SlXpOTEJp8s7ViTPMODfEr4BRRlvABJeRBHKe1AvpQLB1lKg3mF6skBry7Hsud6pbEMXskvomwSEVFz1fT6LuEjOxHB3o9ZpPjpl//Jcv/IQPiPgiwi+3HpLAFCMAa1urbGIPthtVzjAFfxRS2fE7o8qI3Ntxk/RYk1vzhrXjwgEm3sf9OtAb0LCielVWsv4oSpB6T30P5EwCAVVa640iyLw+tm8BT1uoG42OYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tptWmcjjG0th2rGgP0TRbzpP7B1VjMK9fwenPJhZXuU=;
 b=No/kL6ZbguBU5QfUzLxrPLdIhB3TQ+Wdvf74YA+k9KX8itkoJPZtCTsXvM4iIqHD+C6tsUxjLkvsFTjt4LSlkJsZ0UrSHwm+LExWVj9k89lPcXNFoZ4q2gDSzemmsXIGEVVP/vJQNqbw5mq3by8FEE7Iw/c3VJhA0viVUhsA0P63WK3Zjk1Je3kOgjJ3Lyntv9jgEg5+2wDDw1WDCwbmvZ1LE5VmZdftFnMfk3TGA4BvJ2h8tzoL29c29zVGXmLMHfpd2TZVCyei2rZ25lRdrZYVqicPtbJBz4NC/Ry12QA2bkVJ58NA2d/8DsdZM80AmKV0N/9GHNIoq13raOLkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tptWmcjjG0th2rGgP0TRbzpP7B1VjMK9fwenPJhZXuU=;
 b=eJJ8M7zwIZ33AqR+6ENMM9/zXCXNf4UsNQeBHdxvKA7VWvxad/AzLJSMV0LVB3+J/+g4FFWjHYnL/9sUWATuNWdDctOuKC3iO4MD3JCeTIXW/oLQoXPD71+7//5y5u/PIm3TRRVj9VpqSm1wYzAAljKhoe0oOjvYJq9RCE0cPasc3YY02hW8p1lPZq12h2xJWHff/w9d4Bf4SHjjKN2JIhlLe2uEGgpnJUzYHLelH3lYFZ+mQSzhvHc01Zg3x8r0thQDB4sc1sgfftDOsaI1KsHKRWG8jNguKjRfsMEigzHtHepxwIkkKx+koH9PDwUTAj6bZ0cMDpLxulQvFGg2rw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:17 +0000
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
Subject: [PATCH v7 10/22] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Topic: [PATCH v7 10/22] hw/i3c/dw-i3c: Treat more registers as
 read-as-zero
Thread-Index: AQHcpfwqKzA+tQjZKkqpAgAVelXVWQ==
Date: Wed, 25 Feb 2026 02:12:17 +0000
Message-ID: <20260225021158.1586584-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ef4d07f2-3ab4-437a-5194-08de74134cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?q+lqSP5kGQ1i2jexx3LjC6RHfl2kvi5uxNC65IhJZYUSZuWPvoZFe6u/lV?=
 =?iso-8859-1?Q?nK9KVfuVYYmu92KnXECNYfkbgwX74UU2l5BBNoOQQx0nDZrZM5ciWGb+1z?=
 =?iso-8859-1?Q?4Cxq4Y6ahd4vKO84K3+afHh/5eXp+5Ouifj3SIt8YyXxfiXGUxMAnnmevK?=
 =?iso-8859-1?Q?Ue3E9QcAEYBlNPKLcu1O3Prm6WMczFZe3+Zo0apqTxoeRuF5pKbPl354to?=
 =?iso-8859-1?Q?QUfkDJYKWpAo4rLHPGsIZgxrPKBhX0FvxNOzsQi5fzy2PlfZUAH0NPIYCH?=
 =?iso-8859-1?Q?cQjrwAv+lsO7j8JNaqZJByYkO+Mh2VeVpOM1p0V7/kxW1Wm1P5awuR/akU?=
 =?iso-8859-1?Q?Sf3oLLwsPPF5DZV7hFTbCKvWAx24O2D2HMffELjejL89VbBaPAmAMxxhiE?=
 =?iso-8859-1?Q?AQ0hnqRoanSO2GRSqCvbmN9qXvv11xy6Cifae9lz9xC6jMqbFBqhRIyKG3?=
 =?iso-8859-1?Q?cMkq3zybFDFFNyCCij+leALkH6svaZJAFHt4cXJk4vZaSPGjOxCsbH3WlV?=
 =?iso-8859-1?Q?8QROhrUsptTAT09nbBj4HvOURhMLIGjmeBbAj2IDbWj99mqKVqPC7LhxNw?=
 =?iso-8859-1?Q?umw6Nyb2NLftO5gETpjqw1U01TfHhJNMA5LDDxDnWYYEm5TscQZCWMMXlR?=
 =?iso-8859-1?Q?gByyWr3STytdr2d+cnbRisFblvyXUm6Onis0AcMImFim6adK2k+g9638a/?=
 =?iso-8859-1?Q?1KhRVwWiOS3gpQ/BpqOuX5CDkwkZtx4hI1iqhp5ycBaLg8wQ/Fxi8Df9Xa?=
 =?iso-8859-1?Q?3DK3UNup1NnLt/XY9ujvBTLHOdWfHY2/aHFhhnktjgeFK/5qwUbX7YlltZ?=
 =?iso-8859-1?Q?Q8bqPhZXC714K7lrHBtaslMsHdBqklFQ2VwB+wqRwszfKnlbbQthcWu6/X?=
 =?iso-8859-1?Q?/9szvzYXdQrqUgYcZBJTu2S/vgOm+Gox8uUquAvSc6WVW9nBTOIm90FHHa?=
 =?iso-8859-1?Q?IfNlQmH95jk+9N5Q7kUrp9QFS1kcHQ0RewsiCPQ1tRm80K6bX93JL3hkPP?=
 =?iso-8859-1?Q?P8zQonAagxuIHnaG/sJ8PxqJtvKgKTyejth7u3MzVzYXc3ckvnfGFoL0RR?=
 =?iso-8859-1?Q?FfqLS1/7u33yALVw93k0MbAxTGymIAA0bMo2pjVqzHEBV6K+CnJjthcDFi?=
 =?iso-8859-1?Q?gyVFGEvTP/0ly99OTH8deU6ZZ9R+8J3wLr8VixZq6PvbYBKlCFPo0MvuaV?=
 =?iso-8859-1?Q?dajJbPjiPIOy3I2boFHIo2v/NrzVvRkWqL3xrLTHtCx64oC7HAHL5hP6Dd?=
 =?iso-8859-1?Q?SDVA8y09wTAB8s1wqP1ZuBdSjhNZl8Lqnmvkw6c8YW7tl1vO25W+T805em?=
 =?iso-8859-1?Q?nAt6sKGM+cq+0nFwm1Bv7mvBNAtLW+QvhJxJqEwBggYulAvSpl7cYIMt2S?=
 =?iso-8859-1?Q?m6VJCwAJs7VbHFwjOJGoQ+kO2SkxqxyzfUcFykKwNFmZx6SvVPxhUf+ozS?=
 =?iso-8859-1?Q?o3MjpjvYXtCQN3fniYWKryg5FMyyTGnDs/GwIcT0/7K/CjIpEWLtIByxVP?=
 =?iso-8859-1?Q?XpBO4mE4S9D09qfH0faQVaC3ifp8IbEfSZURX9MT3amPR4Af2v7nodHPp/?=
 =?iso-8859-1?Q?YI+cU1aOWyz5iF2hJ5P6WEwNcexJrxSvxfJD4XLGaczOy0cM7Arq+r77AW?=
 =?iso-8859-1?Q?yq2QF6c64wde3pdyZ+2BgbrW5nRd0eK+kF+4O7AySuqDIqxCpEd7CnhSUP?=
 =?iso-8859-1?Q?jt1kr35TGvmegM9IubH9V00SOr+VsWllHo3w3NJo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AVA9act96NnNzQ4ylG/2WV13diEB83TmrqHQvU1jLBhCSOm7IHrMIAXC1A?=
 =?iso-8859-1?Q?8cAzRWrzs8B4OqPDYX6vgpB4rstagCQcMWmtlEhatuak3wCC6tuekwXS7t?=
 =?iso-8859-1?Q?+r/+sEgG7PziIZbnHMpKPFweQImb1is+oE0PBmiSyp7QMTv4of4Vr3J3Dn?=
 =?iso-8859-1?Q?AUiMzR8pFukKe0YHE6SQibF3FFEpRu2SeL1PFzJtakMmpL2PwT1+9xVKlz?=
 =?iso-8859-1?Q?rMchvYYePdqSHEA9PRWwyzsPiCiMFFxGN6UbBBri/IUd9Y8JplJgZs/O8Y?=
 =?iso-8859-1?Q?Woc/KDPAnxsy004BS2UW2mOc+hViKVzgxi5KvbGogZ9B+jvKkAE8k3BY5F?=
 =?iso-8859-1?Q?7Wdz1mOZKBCFyW8l48IADb7z4XXAj0NgNSVhWWfBYlTY+8zdcz6JDgVG5F?=
 =?iso-8859-1?Q?P8h4aLDOcqzDYJiUB5rwGKpV/dOitzc5ZN8fzVChA0B9IdSuLIh2C7/1g2?=
 =?iso-8859-1?Q?aYMTw5TEtssfCct7HMfC66geFpVh47vyPmPFvvNj0y+06uyfw0ytfENjER?=
 =?iso-8859-1?Q?bmepj271AwjNTOvg5x3QKyLj4vDrrszGqmT11KZ/MV8c+GgEvtQtZtXpSl?=
 =?iso-8859-1?Q?fRAkYiUrZtTkSKEJS308CahdWbCP1hkPTevzglcLamwDqcUka7ilCVgTuD?=
 =?iso-8859-1?Q?kqgLXThEAmqVc2OKFevf84C3yfg6zSD3qXKpswhpF5LvUO7egKugpiBHp5?=
 =?iso-8859-1?Q?SDR0IsdddPWuEvi5QD5HK2V//2R1UAoZI59DFpi9zmpzGqOr76fHm2g6DH?=
 =?iso-8859-1?Q?RoYMXbP1NeYa17rwtBbkDp3DMfEtyhid+VJM+HDTpnyePiaEhz2lqrhqIn?=
 =?iso-8859-1?Q?TIWJ+FtdvCPfw8Qw3qpWWVYPfJLDvIeaaYIi5Lc3YOYnsLrs2Apx/QZT/Q?=
 =?iso-8859-1?Q?KglasGiwqngd0CQEkBItpHpU//tr3vYVamHjcx5H9veOKbMrtlWji5nvpP?=
 =?iso-8859-1?Q?d+E+aHpdYvDyV4WTkeks8ZQpLs44rVGM8MDDrC0HKwVmKhyrgDPhh5ni+K?=
 =?iso-8859-1?Q?sGG9ulJNM1AYzPrf8OzE5NYBf3ggLuTua9wBDwGKq02oKZBoVT9GOtTRjd?=
 =?iso-8859-1?Q?f4uZPFNwN/Fz+vIvWMPrTdfEuu61ImGSEjh1Px8XQZQSrHqB0tIu3kSMcE?=
 =?iso-8859-1?Q?IDth8clLXdk+FQQPmAI15TBDXjdwcDuj3XUF3SiSP6q6qquLLY1FRssw02?=
 =?iso-8859-1?Q?l0iunPiaLMdWCqLpbR6SgqeZ+AOJVAq34JVkrFXidKUUv0hRlBHo0w1YK8?=
 =?iso-8859-1?Q?jLsiuugX6q9v0AB49bJNQi9QVUsZMNGL2wFUaEGqbnvQrcm4oi6Ka2zyFO?=
 =?iso-8859-1?Q?EjUs+RNl2xPtXywsT9nE8D5WLwvrm85XxerkxgDQ7N+psEErl/W6fvn7gY?=
 =?iso-8859-1?Q?uMDhz5BnR3Qn3TLMuWXiR4jQO1t1p07BummKA3+7jwNNRDiL+09qecxH4x?=
 =?iso-8859-1?Q?FjcQ+ikbxYanjzwQ5N0wBAPaB3sE1CsTz/ujwX/AGzh77NhhETh0h9noCu?=
 =?iso-8859-1?Q?QshUigKMC4hw1grOusHxPMNol5seGG64Q+cSsOBNytESUNDqrDgqU2PJVe?=
 =?iso-8859-1?Q?2RhpJ8uuc/bOPSSNN4DnbgnF3sSi7saMSZrK9fLjPXlOvYPWmLSeez9QdZ?=
 =?iso-8859-1?Q?I4JDuRVgA7/o0s117vjUNzYlSomwqnA2AbH7e0i0nLNfdy4VJnl4b0MB+8?=
 =?iso-8859-1?Q?FBDHn99l0UkFHKNK0kbg/JoxyRijoXs3ht1xKLXlXkNm9taN+GR6IYr9fh?=
 =?iso-8859-1?Q?UgkqVzXsEX6UQQ+ipVACsHmjbXtGGcjS4JOvq5Od6/gaov4Ifhwk0XDRB1?=
 =?iso-8859-1?Q?yrhaRSDt1w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4d07f2-3ab4-437a-5194-08de74134cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:17.5503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCptBRYCJUFNqtEjiZbuc1Y2F8Rsnfe/rZqltrnum8CamQqYTo0Ntn9xZz3FdvzB1j/FkW5T3iqaKs33pSguuy8yCEr/D0oZrme3YL/+DZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
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

RESET_CTRL and INTR_FORCE are write-only.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 87c8f63da9..eeaf1125e4 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -342,7 +342,10 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offse=
t, unsigned size)=0A=
     uint64_t value;=0A=
 =0A=
     switch (addr) {=0A=
+    /* RAZ */=0A=
     case R_COMMAND_QUEUE_PORT:=0A=
+    case R_RESET_CTRL:=0A=
+    case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.43.0=0A=

