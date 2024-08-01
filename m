Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829CDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 06:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZPWG-0006Qa-BX; Thu, 01 Aug 2024 02:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Palumbi@tii.ae>)
 id 1sZPWB-0006Mj-RV; Thu, 01 Aug 2024 02:42:32 -0400
Received: from mail-dx2are01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2026::700]
 helo=ARE01-DX2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Palumbi@tii.ae>)
 id 1sZPW9-00006z-I3; Thu, 01 Aug 2024 02:42:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAin2oqNmbk8K+OT7K/FYKvo2lzJgwtLdwYg3NUGNeZramSTM6WCeOCjmX8Je7DcFAbre04xmh4hZhpIReAgPP7zNHXFxROoFMJJuG46gP/cmgt3rMflh+jY8QGKlvULr+xN6nM0aJFohYBbBioDGfw5tc1S/B5yXi1wegl+3Rl8GZzwvRxT5NBJouWXNe+FlnAPYipT+8DYQTrmdsboYMwacEXgMUt3EdO5hkSHm/8rcFkVuzD9FCCYrj8kBUHTwWsunLTLJR9cbOW3RStHlUjvvbOVUvCsgI7z3puqI6Z2uiZxmZ3X46XT2WqvcUSU4XL7dL3Ovu5TXhRAWkHgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyTasB6JA70G0JvyWp1rZXgz/E10f+5aFS+B2lq2gQM=;
 b=p9zNVxnWnTD02C9Jr17aTOli1nZdeiTlVvY3frQlcxJvQxonQp1MmvmVuP7WMyqx5hsXE2kdxpd63VYyfp+MQIixs6EsOCaswQI7c53+cGMMO5J2Zc0AFYDV637MhYoObKvDA0UX8H3yI/f/UGCrG6GnVge2t0Vv2pAeDWpiJZQ8fpzCG6WyxUpTsN/HN8mfjtPsIKY+lTVS1fp11/mcq96WpC2yonNAkxpqB4Ji66Rct+yHOs0o0Dndh4B5dUtB9Cp0GFIn1EEwl1ndlsnJOozKWXMM74qzJvduQu933aJB8dLnwZ2TW9RvUplrhm58b4D+xWYEP4JFl2NitersoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tii.ae; dmarc=pass action=none header.from=tii.ae; dkim=pass
 header.d=tii.ae; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tii.ae; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyTasB6JA70G0JvyWp1rZXgz/E10f+5aFS+B2lq2gQM=;
 b=XyPw6Ppzw2ybrMxgsb4ET1DH1a7Wm6p4FV5OIidnvfhSQrlTXZYvyRiEj4+vLoAoi3skcWz0wNnqt/YyQnxBb634oQ0fh6mcwhUPrcFNkaM5orHxlZ5iZ4sd5BHXRHymrSKDoCzNAYkNmKLOnMBJUa7uzmVYxuykkD8BsvlXm66R4x2ByNLLcbGCA6JWfFX0BjgGwERbUlT5jhlYJjjnsUsqyCxLIPaOH4oSmoQCtXiwzkEKRrTEcBGHfBagkc9OUqyzM+ODd3Bpi2lVtS/+hamqmqfhLCSvMzyZcnJabl82di5kssM9ICg5ZnD4XK/pOvP9WXubIQwU69liggSmgA==
Received: from DX1P273MB1304.AREP273.PROD.OUTLOOK.COM (2603:1086:300:65::7) by
 AU2P273MB0308.AREP273.PROD.OUTLOOK.COM (2603:1086:200:2f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Thu, 1 Aug 2024 06:42:19 +0000
Received: from DX1P273MB1304.AREP273.PROD.OUTLOOK.COM
 ([fe80::15bb:cb8f:883c:e1e1]) by DX1P273MB1304.AREP273.PROD.OUTLOOK.COM
 ([fe80::15bb:cb8f:883c:e1e1%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 06:42:18 +0000
From: Marco Palumbi <Marco.Palumbi@tii.ae>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH] hw/arm/mps2-tz.c: fix RX/TX interrupts order
Thread-Topic: [PATCH] hw/arm/mps2-tz.c: fix RX/TX interrupts order
Thread-Index: AQHa4lKe8XYFywo3GE2HZHp1T92H0bIQt6EAgAE/GjA=
Date: Thu, 1 Aug 2024 06:42:18 +0000
Message-ID: <DX1P273MB1304F6482821EF17109510FA96B22@DX1P273MB1304.AREP273.PROD.OUTLOOK.COM>
References: <20240730073123.72992-1-marco@palumbi.it>
 <CAFEAcA_7QDUuQ-zs53Xp2zcO83rDzj0Smga49GZ8J9gg26VBdw@mail.gmail.com>
In-Reply-To: <CAFEAcA_7QDUuQ-zs53Xp2zcO83rDzj0Smga49GZ8J9gg26VBdw@mail.gmail.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tii.ae;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DX1P273MB1304:EE_|AU2P273MB0308:EE_
x-ms-office365-filtering-correlation-id: 2022c4a3-04e4-4911-180a-08dcb1f516e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vtQAPZuaBQ3IodHgGcwfEmal8B9fNVl+bvyc5HhKQXsAOJr3TQ7a2juF1j?=
 =?iso-8859-1?Q?XI+tTakIV0bfyE2bR0MSSJ55ZjAvBU5CVMfFEASqwppTxQxv/qMmU8/voX?=
 =?iso-8859-1?Q?K/gKlz63MAZ18L0tGq6WtF70paKmy95aehZuVDZ3/yjOxFzsXufaAexnGx?=
 =?iso-8859-1?Q?IIlcQlctJkNJwVcCPN/uPiXTuCj8a90SVAGZew3wdnbVg50urr4/oB/C11?=
 =?iso-8859-1?Q?ZScl+kHaCT7J0q4kSalcXm6WkQbmyc0ZUfs3wQ9QFA33JZ9dHaTgaX7Ft8?=
 =?iso-8859-1?Q?wWgWJ3Kq+fnfruHb6RxXpLpN4pn+Tp27E2gStoSib3/r2rQ41FtabR3wzV?=
 =?iso-8859-1?Q?SZSBx38IDRrHM/mnCm8XNKcqG8uNEkpDPVGvNBqSZbTVT7prSSIvvc9tHS?=
 =?iso-8859-1?Q?yrQGUAzaqeq9Aa7ob2vUVlUwbyIM1wXTJ4HqUrlu7w+70/FyofMeImGR4j?=
 =?iso-8859-1?Q?s7leAvY2WhSPn5zDPXLb14s/5C0KaJtP4gmL/XHWW3k6gtd42NHm2Eyv45?=
 =?iso-8859-1?Q?C4D1GlTJqpKuvlLyDZqrigyag4flFT8r/3jY9Oet6ARqSeQxtPnpnhmNHf?=
 =?iso-8859-1?Q?BPscJVYwceFrqA8H0zcNFwvgkITmXOSrAGwslBPLO451L6Iwpr/jLRzN2P?=
 =?iso-8859-1?Q?Q3JjdoRoQcEUHDDu23wd78NOXHyMMDsqmyL6yqKfsGpfs7SjoZYC+k+2g+?=
 =?iso-8859-1?Q?hWBIvxianV2vbGgjs9HyB6R74bTjnkvyMbZBpm0TzlRu4BRkZ8IWfdGjsW?=
 =?iso-8859-1?Q?msoD/JD284F7NkwrSwD+qbfUpfF+ypG07h2YCZm9bKGf850mZxLQKKsFDj?=
 =?iso-8859-1?Q?mQjiyu7EyLadN3Xsxh6kkS1+TiBJMG8QPXGW5x/uGY23c+NkATMfJC4AZF?=
 =?iso-8859-1?Q?zS7HhMyTkmTTj1yF0SsOixrtPMIBI4tvK07IS4OmHBspcxiKysZsP6+JTp?=
 =?iso-8859-1?Q?b5HYVgYM69AYkCrO60sKMDAj8CoiCbYs9U6B/k8r5cjobtTsKFu3uc7lQH?=
 =?iso-8859-1?Q?UNTzYJQlArR33Rzr9KYbD8CGzQMS6AzXxzBPW6+4JPuQKTz5erb9TZtXAU?=
 =?iso-8859-1?Q?ZtK8p+h5unkRKGsbNJzBNwVWG8zoDXRJmw3xR4VmBjls5W6lB7XJVZwoAA?=
 =?iso-8859-1?Q?jqD+D/UxhpxuOdeWe2CqmxoDH+OVB0uoTjyjAN5s7cq3p/u28M7A8VT1CC?=
 =?iso-8859-1?Q?uxTyjN2J+3QHNGuGOSRIb1b+xi9rAJJUz8fgN/Ll5JIVRNeAjVSZy0zU00?=
 =?iso-8859-1?Q?XA+kO6UNeKXkl6RXmJgBLjKVEwP6PYEDUip97T/nQkZkl9B6PYIcD/6iMz?=
 =?iso-8859-1?Q?wZ0XcZ3c28YTqJB2WUMBLtc8eRMcs/d3M5Ul09i8AeHwT3ClTcvDWp+We3?=
 =?iso-8859-1?Q?shnOh5AjaR/9/OVhVfOzTe7SIHT958AQtoFodwb72KAM3PPYd79dO5xnJd?=
 =?iso-8859-1?Q?yFQa6UDQHVFdB0xz24U83sbYxCyUm8aXW9qk4g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DX1P273MB1304.AREP273.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rrfdjWES8nraSF5e8BJIoDaLga6ZAz21BPrxBp+8zBB4M7tUqKzK6XX00i?=
 =?iso-8859-1?Q?9/aDaJu2uqwN3O74+js3l3kHcfHSBupyLxJjBy9e+i6GUKyxvGWJrFez9F?=
 =?iso-8859-1?Q?dSO7fnS+DoL4cik2NIbi5zmI+D1cIhKuim3hcPuiZFm3VUhE/deXQzG7sV?=
 =?iso-8859-1?Q?o8c2oHaERs3k7Ain+u73MCyUs+tffRPQAey9qL2Dd63iG/EckjYCWZM5kc?=
 =?iso-8859-1?Q?QOVxJgvJBlrCG23HMIBPRi+TkZpi+U4eh7Xz6+yTE60S0RhIz2e2o8x91q?=
 =?iso-8859-1?Q?HDxpYSPiAZwrRwgytV03xUJi75WUB+75lDaeC/IV73HZzkLn6DoG3bzLSv?=
 =?iso-8859-1?Q?IrZJVhj3oU9+/5Fyz2Aj/Ghll9En7TJDwY/GtqJ2NIOyBoVpa0pr9cilbp?=
 =?iso-8859-1?Q?VfTh7AdFH76tA9lV6811AIVx+fJnuJqSpPNQHTV1z7HgI0Go9y/TC9j8G5?=
 =?iso-8859-1?Q?QwQsaHoU8p6QdZ6Oah9vbLhdAVDncl2DKWVLRrO2VCPifY90ct+RjNRQbe?=
 =?iso-8859-1?Q?aWeXrXh8SwpyFzXPAh8oQ/yg2vuGGMBWvIn70Pq+o/Y2VNw4YjgEZK7g3N?=
 =?iso-8859-1?Q?Ymqcmdmml7weE35IoD+hvcppWG/NSZhJkToMWAQuvHgW/k8knpVHIljx5U?=
 =?iso-8859-1?Q?lWii8sEjPDROHTdbBUMoy+ImcLbxmmnusQnu79s3xVWoxa17/ll/y9goSK?=
 =?iso-8859-1?Q?clV9f2ixxJtepE5+egh9RQbvmGjCTQ0AeAdYIoRc3qAAm1Z1ogB3pJwg39?=
 =?iso-8859-1?Q?vfyo8A17WUqpPFiyZhq+yYMYQyATopGBqYCCKmp/0QLsEBUa3uchjv3w9e?=
 =?iso-8859-1?Q?SdvUrOuDZW8vhoS8kOKavZWvKrZ0h9g58f7ESw1AkxqhJ/KvcnHg8RHOME?=
 =?iso-8859-1?Q?tZtOHzxGnmYXuVpnk6Wb6Ot9BPChnfIjL3dhC57jg75ATcO3+Uorx/duUR?=
 =?iso-8859-1?Q?tX5Klbq+ZCOZRr5gc65Nd1h24OFQ6bL90AhCSY+q5as6EcEJ8rDVdO2Tdx?=
 =?iso-8859-1?Q?8YYNbNbSlAP9MqxhSHa4DB8mMSE0bXgr1ax96BloN/75MkT1MzoE4jqMfH?=
 =?iso-8859-1?Q?KpxuBeG+n2fH5yVfcOukmb73T7Df0nAQF1k94vz9pKomkbqtOMim2E4m4l?=
 =?iso-8859-1?Q?aCAGooEYQyrLmhcJeZiJObaxlq1Rwqlu0Od/mGW5rWYwqWJvwWLUf7jVDR?=
 =?iso-8859-1?Q?atIvhAW0AEoE8YKUU3N3GqLBq+YIzODXj5zl8aDJNyNhyH5mwYKUsVv6fM?=
 =?iso-8859-1?Q?InUmDFXmWk53BwpnvYFB4Cir5UVOcWs8+5Ury/1fOJwnpwWwbPnE4Qd3p+?=
 =?iso-8859-1?Q?btQtP0VyAkx2K5RjqNnCMrcteY2jWqbeNQTytHOyQ1hw5edel76w7OtWmC?=
 =?iso-8859-1?Q?wZ+Cze1UBrhiawBwihNOsm7BXvkz3d4HHiJdm9yFc6HeggoiMfiHiOj3Hy?=
 =?iso-8859-1?Q?sXisBIh2Y9si4yb7FN3aMav5iAqZ2b6O1NBcOm+zI8WjGqDPYuUOA/7Dwk?=
 =?iso-8859-1?Q?Y3M5gb8mTcNmgpSC6Vu88I73HzlhuHTmxt9KAGrAJxG3jv3ReBSADJdRtf?=
 =?iso-8859-1?Q?rElwxqKioOPprAUibiiV5oXWBNcBql+vYE9MJlfLJbHcaXUxuFt5bU1yGV?=
 =?iso-8859-1?Q?/4wnV5BAb0MG8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tii.ae
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DX1P273MB1304.AREP273.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2022c4a3-04e4-4911-180a-08dcb1f516e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 06:42:18.8808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f0869253-be00-4a37-9c77-37742cb15c38
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NExSArk7i8dBCyA04HAV+9J4uJRSgsYAcua+29jhZunNcdaRim/flw4juvwvM0BmVPE2/JpWfHXzfPi2m6lc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AU2P273MB0308
Received-SPF: pass client-ip=2a01:111:f403:2026::700;
 envelope-from=Marco.Palumbi@tii.ae;
 helo=ARE01-DX2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Thanks Peter for your time!


Marco Palumbi
Senior Cryptography Engineer

PO=A0Box: 9639
Masdar City, Abu Dhabi, UAE

M: +39 349 786 0737
E: marco.palumbi@tii.ae=A0

tii.ae

This email and any files transmitted with it are strictly confidential and =
intended solely for the use of the individual or entity to whom they are ad=
dressed. If you have received this email in error please notify the sender.=
 This message contains confidential information and is intended only for th=
e individual named. If you are not the named addressee you should not disse=
minate, distribute or copy this e-mail. Please notify the sender immediatel=
y by e-mail if you have received this e-mail by mistake and delete this e-m=
ail from your system. If you are not the intended recipient you are notifie=
d that disclosing, copying, distributing or taking any action in reliance o=
n the contents of this information is strictly prohibited.


-----Original Message-----
From: Peter Maydell <peter.maydell@linaro.org>=20
Sent: Wednesday, July 31, 2024 1:38 PM
To: marco@palumbi.it
Cc: qemu-devel@nongnu.org; Marco Palumbi <Marco.Palumbi@tii.ae>; qemu-arm@n=
ongnu.org; qemu-stable@nongnu.org; qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/arm/mps2-tz.c: fix RX/TX interrupts order

On Tue, 30 Jul 2024 at 08:32, <marco@palumbi.it> wrote:
>
> From: Marco Palumbi <Marco.Palumbi@tii.ae>
>
> The order of the RX and TX interrupts are swapped.
> This commit fixes the order as per the following documents:
>  *=20
> https://are01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fprot
> ect.checkpoint.com%2Fv2%2F___https%3A%2F%2Fdeveloper.arm.com%2Fdocumen
> tation%2Fdai0505%2Flatest%2F___.bWVjMTp0ZWNobm9sb2d5aW5ub3ZhdGlvbmluc3
> RpdHV0ZTpjOm86YTlkNGRjMjcxZTBmMWJjNjlmMzc2NGE0OWY4ZmU5MWY6Njo0MzVhOjY3
> NjVkOGIwNWJkMzgwMGJkMzdlMWJmYmE5MmFhY2E2MzhhOTQyZjQ4ZDA5MmI0ODg2NTc1Yj
> QxYzM1MzY4N2Q6cDpUOk4&data=3D05%7C02%7CMarco.Palumbi%40tii.ae%7C063b7e0f
> d4634265eb5808dcb155575b%7Cf0869253be004a379c7737742cb15c38%7C1%7C0%7C
> 638580227306410621%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnW%2F6AR%2F
> E2tlpQ%2FSNSvDJyQf71YIbk83KVcZzGnmP5Lk%3D&reserved=3D0
>  *=20
> https://are01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fprot
> ect.checkpoint.com%2Fv2%2F___https%3A%2F%2Fdeveloper.arm.com%2Fdocumen
> tation%2Fdai0521%2Flatest%2F___.bWVjMTp0ZWNobm9sb2d5aW5ub3ZhdGlvbmluc3
> RpdHV0ZTpjOm86YTlkNGRjMjcxZTBmMWJjNjlmMzc2NGE0OWY4ZmU5MWY6NjoxM2NkOjY4
> YTI5ZTFmNDU4YTg3NTQxZGJmMzE1ZjQ4MWU3MTk1ZWRiMWRiOTdmNTIwMWU1OGYyNThkZm
> U4MzkzNWZkY2Y6cDpUOk4&data=3D05%7C02%7CMarco.Palumbi%40tii.ae%7C063b7e0f
> d4634265eb5808dcb155575b%7Cf0869253be004a379c7737742cb15c38%7C1%7C0%7C
> 638580227306419690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DYGw4NsxbW01
> i46Gm%2BgBzQIOB6nOqL16P3Deblg3OcRw%3D&reserved=3D0
>  *=20
> https://are01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fprot
> ect.checkpoint.com%2Fv2%2F___https%3A%2F%2Fdeveloper.arm.com%2Fdocumen
> tation%2Fdai0524%2Flatest%2F___.bWVjMTp0ZWNobm9sb2d5aW5ub3ZhdGlvbmluc3
> RpdHV0ZTpjOm86YTlkNGRjMjcxZTBmMWJjNjlmMzc2NGE0OWY4ZmU5MWY6Njo3N2NjOmQx
> YmIyN2YxY2Q3YWJjMTBhM2I1Zjk1NGM4NTBjZDlhNTVhYjA2NDMwZDQwOTUzZjNkZmU4ZG
> NjYmNkMmUxMTI6cDpUOk4&data=3D05%7C02%7CMarco.Palumbi%40tii.ae%7C063b7e0f
> d4634265eb5808dcb155575b%7Cf0869253be004a379c7737742cb15c38%7C1%7C0%7C
> 638580227306425926%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D0poH91SU6NE
> f4%2BD3%2BqH5WNDgTXXfZ4PA7buG0bwKQlE%3D&reserved=3D0
>  *=20
> https://are01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fprot
> ect.checkpoint.com%2Fv2%2F___https%3A%2F%2Fdeveloper.arm.com%2Fdocumen
> tation%2Fdai0547%2Flatest%2F___.bWVjMTp0ZWNobm9sb2d5aW5ub3ZhdGlvbmluc3
> RpdHV0ZTpjOm86YTlkNGRjMjcxZTBmMWJjNjlmMzc2NGE0OWY4ZmU5MWY6NjplOTcyOmUy
> MzEyNTdlYzlmOTRjOWY5NjY4YmExZDc3NGQ5NWNhYmY2NmEzNjI2ZGMwYjI3ZWZlZTU2YW
> UyZjQ1NDFhMTI6cDpUOk4&data=3D05%7C02%7CMarco.Palumbi%40tii.ae%7C063b7e0f
> d4634265eb5808dcb155575b%7Cf0869253be004a379c7737742cb15c38%7C1%7C0%7C
> 638580227306430786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DLWgkq6rb9vQ
> 0q4VhuPmflWyFLCtMTjg6DWe3j9h381w%3D&reserved=3D0
>
> Signed-off-by: Marco Palumbi <Marco.Palumbi@tii.ae>

Thanks for this patch, I've applied it to my target-arm.next queue.

I checked the other boards that use the cmsdk UART, and they all get the tx=
/rx interrupt order right, so this is the only place that needed fixing. I =
suspect that the guest images I tested didn't care about the separate tx/rx=
 interrupts and only used the combined irq.

thanks
-- PMM

