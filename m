Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5E8C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 11:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3BDs-00089H-GR; Sun, 06 Sep 2026 07:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stuart-J-Marshall@outlook.com>)
 id 1x3Aj2-0003IX-F3
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:07:52 -0400
Received: from mail-francecentralazolkn19013084.outbound.protection.outlook.com
 ([52.103.46.84] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stuart-J-Marshall@outlook.com>)
 id 1x3Aiy-0006l9-Kq
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 07:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3UBifL5VQKfDhHMFQJDQZwa8fPgC8jfUuo9HUuTn3pPBZrcfufvsAxqxIGDd7zXgGXo4ggzVOumPIpn0mfBQjO/DVfyOUsxLTKUEcqvDzpehsF4Jn1qzJ/8ulmHiVwFEn7rDhs/JY3oPl30z4uogNRZhrpBXZl9a7/nbNnK4XuvyqgxNNunNZ9z9o7oIi4csa7vLyBOf7i7WjOmb14DgOBSFpiGNKN9aMcMu8OpWFfzUz/eGCFs6k3xFXe1dUWjnS+x2y+KMr0qidiYVL5cbIiqjVZ+28r9gfiPQ7SnLr+HiMwAGCJiaVOQ7UzMu91ERxErDDdPT2q03UboQviecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUgf9WJNm6c14s+obEW843VFFEzxg2BsXl4jIl7L6HE=;
 b=c/sMgWqPHYD0UNQp4t5d/9ozgAkqOSlyHRlRmwSGQogK8SvdgIj62yebWoBDpX2tFqlQmgzVVN2pXusnYheNiyuAYG61fiJRZqjeyM6xY7sUkPX8r7aXSLqzduxGhU0eSaM9yd7DadAYuZnnP6x2PPV6/m/JJ/PxMT5NEUN3cv5oVIL8blExw4xMDXeFvhvZUWBtdFgRAvxzO2Ww2ZERX14vz4v1Yu71VvbX4CmxTlWzwur1JiuQ6O9alG0fA4AosVjfpCP0Neq1Xe4HE9dx2hrs+BV91k67ywkdhhZf06aOJqvG7+oAk1waYlh8jjx5RISSxpy4CI+amkQZEuixsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUgf9WJNm6c14s+obEW843VFFEzxg2BsXl4jIl7L6HE=;
 b=WeldcVi4ZV3yD83q1YrHwvzqdHo4Y778sFVn2k7YioFezt9FYxY00F90bpyCSgKRLnpingb1Qkj107nLvJGk5tgMluAt+ij0amoNm5ik2uUmkgRSv5rKue+ot+HJrdepiZv5Wl+z+0AnLuKmZVbOknkXi62acW9Swu3EWqMkFx5sIlQUn3z+Kd+T2IUt3XHngatMMMzg+zGUkrhhF4fXBfiOwQOO750+z2wONPMfugAvB5Nf3ShNGJAbV+MVRCy5wT1VBP+COVe9Tnhx2rHONBbtX1y+XWvAKotJyE6bGEznutoynzK86BUUfqsdapi/aRazHUtRqwaI2bGz+mWs+g==
Received: from AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 by VI0PR08MB10992.eurprd08.prod.outlook.com (2603:10a6:800:257::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Sun, 6 Sep 2026
 11:02:44 +0000
Received: from AM7PR08MB5383.eurprd08.prod.outlook.com
 ([fe80::b296:502f:be8e:4fda]) by AM7PR08MB5383.eurprd08.prod.outlook.com
 ([fe80::b296:502f:be8e:4fda%3]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 11:02:44 +0000
From: Stuart Marshall <Stuart-J-Marshall@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: submitting code for QEMU
Thread-Topic: submitting code for QEMU
Thread-Index: AQHdPe27/IJk9JCjeUSphaZFDit96g==
Date: Sun, 6 Sep 2026 11:02:44 +0000
Message-ID: <AM7PR08MB53831A09C35366C17A229BB0A7B32@AM7PR08MB5383.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR08MB5383:EE_|VI0PR08MB10992:EE_
x-ms-office365-filtering-correlation-id: b548d895-e141-4546-84d3-08df0c0660dc
x-microsoft-antispam: BCL:0;
 ARA:14566002|25010399006|8062599012|8060799015|19110799012|4140399003|15080799012|24021099003|15030799006|31061999003|20031999006|39105399006|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7bKnOyqX0dJHQYOJRAEEE+5yLg5vDF8kiBqVI/gYQ1yFdVChDjvQw+2hh4?=
 =?iso-8859-1?Q?t36rEMobfi0j6BPdp+zfRCVIpJu7TC4jn/XJmpfgvw/kz1weN/38Cujgs7?=
 =?iso-8859-1?Q?ZYnxIeTC5W+hhTu4wnqsMWLT4u7Fc4PNWAH+lrwuKMrqzA5HjfQyqke5cV?=
 =?iso-8859-1?Q?ybmOLOHAUxf8ZTbHQlQDFpoIWP64nEeSKGD9cPqSsQCLpUNb/8jZE7Kkbz?=
 =?iso-8859-1?Q?HpJBBOhwKhDuWuwesd5wilnqFS/AWY7MDhSWnKTaOcSMLFKqkJ3/RMp9qz?=
 =?iso-8859-1?Q?1N+d27e3zNffXhRi9tbk4VozFzErW4pObkPisAMzdauyMmtjL7C8h0Xn5H?=
 =?iso-8859-1?Q?uCY/WEArOS5NsJCPww89KMvltHvvNJoUPfnk8+UFwSNB8tJftZ87lQeSly?=
 =?iso-8859-1?Q?XxQ62cnRiKGWzfrt9qS5tisIJ0zpX3LQLTEa0u+llAXrzH2AnskZso63yh?=
 =?iso-8859-1?Q?9OTPRbi5ufomfp5B2dm8NOWKk18GoEJ8twUmiRZpMgv89Ze5mH8omcQAil?=
 =?iso-8859-1?Q?Rz9jA4hdB1sIStKC2OQgYsJrulEDGJ2JJ1vYXa7aoH+rraHDT5C3fVxjda?=
 =?iso-8859-1?Q?zt6Norg3rGOELr4fUO6M6SGyvAYflN1hry7i+qYmKyjczdbj2iJMVFFKUB?=
 =?iso-8859-1?Q?f1p0/ECBqZKnTXT5xYfS1hZz3sxTwH0S6F5MojHG05ZJznh7+8I6NoxC/g?=
 =?iso-8859-1?Q?9Q0MAYBiW9HEFmYYOPzPy1ZD5Q1cc66zMNAwMTNxUv4WKIpvnw4flppImV?=
 =?iso-8859-1?Q?pZhVBatM7FffuqSbxlw7cABY6/csNYxdSyqcqo6erJO+hlBj8Xm/aVZMJB?=
 =?iso-8859-1?Q?rU/0XSIEVDOvt+IGuAJCk59Hc1xcHId8DOGb6kL1zkf3MFdFUeYvAYu97Y?=
 =?iso-8859-1?Q?hGcTWojN9IUwDbKUGMEb3wx3rPANi7iJpLxrlUsip3qOvxicYe2kZpVE+u?=
 =?iso-8859-1?Q?prxspWTSnhsWRC74IHzK/K98b88opR74HSK35MfcHpb6MWbWk8E+ABzJhN?=
 =?iso-8859-1?Q?RNCsDTi7dASZ1Pn6wQZhsCOCJn6sToiodoE6Ok?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3yoTBh3tZy/Gdv9xQ2So+mVTv7CFuVMuL7+w5eYmMKBjuWVup8UCKBDo37?=
 =?iso-8859-1?Q?d13SLBQj8zt0jCLFpkTy2MYsw3/a7QEkbwkZCo3meuzP6CdRa1ocU0HRSs?=
 =?iso-8859-1?Q?I2gqKnTjUykn+SWkNTKKvvQANGDNJvRKixptMan/Ng+5RijHJtwfhX1BlI?=
 =?iso-8859-1?Q?CiQ/YqFN+LQuB/UOeWc8HyINuEQ5Gkqa08XwPMmNqDnyiwzpSCJVUcsjut?=
 =?iso-8859-1?Q?sIZT8DUrtM3WzF2c5F+JKcqUEwT4N++hcpI4q5R7SnxbeGj6qjQLcEJFDT?=
 =?iso-8859-1?Q?ghzrdug295HZUK+POcxalO+sRIM7eAph6oBFopUxM9PmZRsqdR7CXZ7KE1?=
 =?iso-8859-1?Q?yGyIBDorvRVZa/UKwBb1tVeRnHM4ZsT9/bCQi//hjVSEu9IjgTCyD09m17?=
 =?iso-8859-1?Q?W9tp0oGbyri7ZPzpw6jUv+G7a6KNKOOPXIwKLLGAw6HtQkLxDKvpYjPpGx?=
 =?iso-8859-1?Q?HMmKolBJKS5riX25JEdxcJwFB+U9yI4qB7ynIXN5FZF4ea22Mx9Vb9i8dE?=
 =?iso-8859-1?Q?scC8qfOAhWT/vXcC81KSzccqnPxWr5Pp5MzItxrOeX6P62mHP9PPBkoHJp?=
 =?iso-8859-1?Q?BKFxJv5DaQguD95uNR6Ty6EBfrOOnagi6qj5jCackykyKAEfXnMi5yUOMN?=
 =?iso-8859-1?Q?Fmw6kSx7lPd0QiIqpoF5PaCzIgCHjS5u1TTO49W4QoSfoX7IwARIQ6zd6P?=
 =?iso-8859-1?Q?lomsLHI0jWEFJ9+6vet4X9ytalkT4+w6tETYdS2QFdhcm70LerNhhoGfDM?=
 =?iso-8859-1?Q?mHbqJTfcbNeBczFLWqXrGE7y4fbVvhWBKmq4J37w7uDNh5bP5ohz3q/JWV?=
 =?iso-8859-1?Q?HsMDHNFuSCkrUbA6NWms0JsfD/xHmsAHtbvPkiW4gugP/qqJLARmbuN8wi?=
 =?iso-8859-1?Q?yEBF09Wt2MBOvX2jeM1zftUFUsW9ovJ5Rj2jknlAdHYWXZB5sXV51/R6Vc?=
 =?iso-8859-1?Q?c2EMKYWv1coQmIXdWpgwX3AtLHNsf17XUQONKvO30BNEZUCzVmAkAQHKzp?=
 =?iso-8859-1?Q?7fRdGS8wkXAM4hrs2mVb3+RNfs27uf4M7KHtAhIrdYPSVVAzfahySBI+AS?=
 =?iso-8859-1?Q?52KfT0s0ytqTqyOY+WNsAcvIJNQSfDZt5Rfs0utGyQwB/3r/hRR3nkeMHa?=
 =?iso-8859-1?Q?Ws9k0sriEvXRXgEnKjCWJ4cagRl2i9aQn1T2m71rXSCI4l8qNfjdTDuTry?=
 =?iso-8859-1?Q?eU6lhkfzSmd4kslnkl1Z4/USFRl52aTK6FFeo4fI3KEFhHmftixY0DFq6O?=
 =?iso-8859-1?Q?YwMFMlX64HCmUn2KoUoHni/fzNiNP1aPW9KYZSUa0p0vwYBmPqoRxP636C?=
 =?iso-8859-1?Q?lehC7F+lWQikST3doBYw6uBZDUWjGlkADhzz+pjmxvOWhu5KHz1Eil6d7W?=
 =?iso-8859-1?Q?i5THQ+nDpJfe9VUCzRL6qLKQjUPX28B539cYoUXs1WwrQ5mgsabLN+9Yol?=
 =?iso-8859-1?Q?qI6j16lvcPoqMbk5qqnAtg6gru+NV+kvRNfyIA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM7PR08MB53831A09C35366C17A229BB0A7B32AM7PR08MB5383eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5383.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b548d895-e141-4546-84d3-08df0c0660dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2026 11:02:44.4262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10992
Received-SPF: pass client-ip=52.103.46.84;
 envelope-from=Stuart-J-Marshall@outlook.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 06 Sep 2026 07:39:42 -0400
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

--_000_AM7PR08MB53831A09C35366C17A229BB0A7B32AM7PR08MB5383eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I have been developing an x64 OS with USB support, and noticed that, every =
time I introduced a bug into my xHCI driver, QEMU would often silently cont=
inue successfully where real hardware that I tested would error.

Would it be helpful if I were to try and add warning messages into QEMU log=
s for incorrect but recoverable usage of xHCI? This could aid other OS & dr=
iver developers, without breaking drivers that rely on the permissiveness o=
f QEMU, but I'm not sure that it is the mission of QEMU to have conformance=
 warnings.

From Stuart

--_000_AM7PR08MB53831A09C35366C17A229BB0A7B32AM7PR08MB5383eurp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have been developing an x64 OS with USB support, and noticed that, every =
time I introduced a bug into my xHCI driver, QEMU would often silently cont=
inue successfully where real hardware that I tested would error.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Would it be helpful if I were to try and add warning messages into QEMU log=
s for incorrect but recoverable usage of xHCI? This could aid other OS &amp=
; driver developers, without breaking drivers that rely on the permissivene=
ss of QEMU, but I'm not sure that it
 is the mission of QEMU to have conformance warnings.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
From Stuart</div>
</body>
</html>

--_000_AM7PR08MB53831A09C35366C17A229BB0A7B32AM7PR08MB5383eurp_--

