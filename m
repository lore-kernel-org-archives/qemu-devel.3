Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4650CC369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zla-0002Mc-2Q; Wed, 23 Apr 2025 09:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1u7Zkp-0001rM-Ib
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:03:08 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1u7Zkm-0007Gc-0s
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac7AuZDhgKkI6KmRAtZHqS4EnFv5XCstKt7a6rHjEsfkb61QjNsLGmgjYPU573J1SHIT7z7/9hZQPnyd+0x0hYsUk0drkbkz8+Y9WfqYbV+4GixlKu1lS/orZTHIgsRXCkx5ioHUb832IiUoq5aFSxRT5IjybAYVQJCf6mBKzG79Hg9Z//EwqLa7R0bdMmUKSUAf3U2gx/eAGawf0aD8tWvp9e8O0fT7CugxnPGYdmraWRlMAkV1gcB8n7hEPyVs6PtyiLgcC5L+hpLKvCy6Lcu6Qa+v88hpSkiu9dgSl58D4EUfWb4VwMo5wtbWDhZEVFqhM8Dk8SqyjSwE4+qjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjYblLukaodqWo7/CcS+76/nNWnT8rFc/XAtYDY0IIQ=;
 b=vU++uPM0g8OVJy/4yD1IcV+FhuXB5+Dg44Sl4yQzO0JiSKRfFEPkxHydWJrRyrigFPzXukXutPGOu4GsipuhZ+vbMBOBmaSsJJIgM/43iVqCweyti4S3miERrACX0R4OTN5jekn0blON9jO4+x45RhELnEl0cCkuFw8f5LicXRI+C16RZLpnQJV3Cf1qvFQQ9JyBC0aGGKGQUnsO6mtd2mUnEvbppASnk/8tv76oke7LZoiFFq2fDXmKIiIgFRujXWBL/QaMtpooABiK5pTGLZQ+tBgBNXO8q7edNIwOzP2oKtahPBo6ZgM3nGK5V42WWh7bXCZMV6qbqH/4IqMJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjYblLukaodqWo7/CcS+76/nNWnT8rFc/XAtYDY0IIQ=;
 b=Kcjyqa4INO9SLzn1+ybxnW9F+frhNo+5sPuRXoNIrGiFXfLT0aG9YGrVgiYxwOr5I2pvF9/kex+BkvJH6q964e2wg/Gm5nVnXsG8mg87cXFD3Y8EMQ3RGmUVr/6HOhHitknbYYpBsX/Z5xUjEQGDgvL6GGtT4vIYTMQz7gfcQq3c5SKUBB1lNQYObmnAE3YGo+a9mLGtTDBf889auc7PBcUe/AWEuU2rwZQ7DGCWhu8AdFPhxX7eT4NjxtiWZgVEnm57EvWoTQjvlFbW8UC/2+s8azF5o+ztn1zuLc7XGIwK3itzt4kGjiSbh8VjNIaDTIM7CExB5eB8fHnOrioZ8A==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by AM7PR09MB3624.eurprd09.prod.outlook.com (2603:10a6:20b:109::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:57:57 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 12:57:57 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "cfu@mips.com" <cfu@mips.com>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRrNvpGeAgAlizQCADH3GgIAsCEIH
Date: Wed, 23 Apr 2025 12:57:57 +0000
Message-ID: <PA4PR09MB4864D472FB32302BC1BD162584BA2@PA4PR09MB4864.eurprd09.prod.outlook.com>
References: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
 <20250326123059.1268756-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250326123059.1268756-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Enabled=True;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SiteId=9f85665b-7efd-4776-9dfe-b6bfda2565ee;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SetDate=2025-04-23T12:57:57.416Z;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Name=HTEC
 Public; MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_ContentBits=0;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|AM7PR09MB3624:EE_
x-ms-office365-filtering-correlation-id: 66321541-70ef-4088-3357-08dd82667897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vlwvVJrntwZMiAozOKQSp6wRjDI0Tr5+AMOqRoRGuB3wsR9jO0AIdnOlwe?=
 =?iso-8859-1?Q?C89rDLC9kad2U7sg5j6v5YedeW7tTpAxbzJV8UOn24gAhZNZE1stG91yip?=
 =?iso-8859-1?Q?KVCd7n7vu4Gi8Gzly9CDGKLVYdg0/G+sxVHIgo1ppr3OlB+GJXydcbUoto?=
 =?iso-8859-1?Q?uATcInhSW+kayi9qYiY/k6KYFVzyXxkLSGKZTGzvrsmsh2utBYBnMAMy5D?=
 =?iso-8859-1?Q?zAkXdg3XVZgx642mx/bbRpb5VK0H5ZtIiEplYEt1VM2xtm9jOBljWVfmfZ?=
 =?iso-8859-1?Q?SSsXn2jjjbtvNFyDXg3d3aPfeBkNDUzuuhg5N8yUqDHVORfD9kLb7SGQfH?=
 =?iso-8859-1?Q?NaBDKrWBMjBzVyDgtH78HC4sE2eCdVzvbSINFo1EX+wLPTIkQF2ndoiZrr?=
 =?iso-8859-1?Q?0S1sfny8eTtDBLtZjMmWM637tl+zx9MNtaGTZt6u7AbcPuw0rmA6PVndMJ?=
 =?iso-8859-1?Q?cx3H1eQzwis3rJGzlxIEjO7KZRtqyV01L6iLiPbO9IblFgw1UQu68jjMAh?=
 =?iso-8859-1?Q?tK8XexA3ebgRbh1S4s2Sk2KpYT7eSnkIlOI23YDucyp9Hym6lFV/ULulnA?=
 =?iso-8859-1?Q?0aM/ndbR1/O7VfTDjBE2A5/cWP68tmit3p1LBro6zBqm/JTZRuPoiWHk6T?=
 =?iso-8859-1?Q?bou8X+rKq/iDMsFxtqYnxtw4ASJi+CQHsJiyoREkgTP7F4K2UAmzdoBj7A?=
 =?iso-8859-1?Q?vrRneUrHDeUBm7xZX2E2IppdpIiLkBiY9Bxf+SPrzRpvY/ign4lfo/rLGV?=
 =?iso-8859-1?Q?FUgc+SKnNTQpBXUBvMepbgDCGuUly8iU+MqDS3j6TTvwMT5sH7JEaa0MIi?=
 =?iso-8859-1?Q?cxuEthjQ/Qj5erjZvA9y1ONZMGoEbQC0IhWMQOAFrdJpBYl0C7ugT+Jt88?=
 =?iso-8859-1?Q?m57Z1Fclr+3YnOOLq5me2h9tazWrya9ziXnWtRI67Gp7cPeqkOO1LUrEj7?=
 =?iso-8859-1?Q?YjiUhNsiYZipnqJFmcMlqYxovIqcWBZ15vgStI2tKvyiWE948hcAhxSrF/?=
 =?iso-8859-1?Q?COJT5FPkRO9qyOUAKRJQoqW0LmoxBQJLz9SIYRxXA8V3QbJzWIfyfPaDHv?=
 =?iso-8859-1?Q?5aHzxfxx+zfs8NbfhFYM1TGqr883nqB95PQH9VVsUBLiErDBzOts/scTXt?=
 =?iso-8859-1?Q?p26nrf9gvngpiNdSd0n3lIHjxhflBKB8KGBKmTGVAOwKk6EEMElduVg3ic?=
 =?iso-8859-1?Q?EN00RwHbmjYC+u90HwtoCptWoRlBq1CNYyLj6kt45jE1XnJCfoJ96I1W+c?=
 =?iso-8859-1?Q?AQO7h2iatxAkjt28Xu6+2sqHybgdBtk2xSoAaFKbgjqxh9XXB/9+5QhowZ?=
 =?iso-8859-1?Q?fSc/n2a1mLm/AB3Q164E+o1n3iMSJwZtQwHUggACpEm6oCoROpOsyT/xJ7?=
 =?iso-8859-1?Q?sO7IvNMQpUUvNfYZjPY+vc+x/PUBgvvnZEOg6SIhoVRrS6qJKqDpWMwSe5?=
 =?iso-8859-1?Q?TSzNAy8WIfIycWK1S3IjnSDzXX4AL3WwNPXyQo34laMKTFWPFJIWOPhgoj?=
 =?iso-8859-1?Q?QMHlr6ygfsc2VhlhClh1tL1ZyJ2e9q4YC03+NixJSjvw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4chiuB3d5AOl+AEneyoOf6ZOOSVDXyUW51XUd8h8nBWZshMnPzH+vQg1Ol?=
 =?iso-8859-1?Q?0169z2vsYuiNh4wdRcQ1VT37hwF1wU5t0xrogotiuBwQXvN2ANyDr47eKU?=
 =?iso-8859-1?Q?vlEStPT9z38YFaCgwhaycpa6xWMjUlnAbrGrvTgz1NwvWDEsyzp0Yjezh8?=
 =?iso-8859-1?Q?ee8awE1BOEvQBU+osXPtxNZ41F9lONWuvmTNTjdD7bsPLWtokM28eINN0O?=
 =?iso-8859-1?Q?K+Ss4sKjnGS1P4/1I3SJxN6lXJDo2tPtDqJ5/3WUd1DhA6cJWGyNJDXDhl?=
 =?iso-8859-1?Q?UZ9yu6HFyqaa9A3xXSaKurI3uP1Jel9HBvwE0YmSq6ba7orZT5Snj1XgaE?=
 =?iso-8859-1?Q?CzUkd6JQJYHXyZShEZStKvLMEtwjbodROsrCTRqDjBQFZA+UqzoIZVMo4+?=
 =?iso-8859-1?Q?WttVEvtYltrNb5q1WsTT1MbSaNcK7DFFA9xSd/UH2q6IOgW6m4FiXu9Ed+?=
 =?iso-8859-1?Q?/et41u99vRNOqgJoZ89FrIcLougV6RE62Irs2kKqzVQA1oKKAdt4AL3/Fn?=
 =?iso-8859-1?Q?i1IvQsJYqG/veObG7xCHWqY6xyE5DpvRQ6pdLStX6tZ1cSaKoXZe/+7syw?=
 =?iso-8859-1?Q?WagzVa8txCmpK/Y0mgQ6905Bprgy6iJvGrJQ6vHli3c9h46bB1cxJcwUDz?=
 =?iso-8859-1?Q?xBvT+SSTFc8hg2lGaazinF3tatNKvdUOmcv4Nqv6kMQI69DYBDsj/61rua?=
 =?iso-8859-1?Q?TPUUCwzZLwT1fcWGYzgRhKq4Drm++qVoHyhGc2G5eUnKNE+xuAkGUpZDc9?=
 =?iso-8859-1?Q?IGCCi2KJpK1CxSaJLYOB+ByhFHIAYlyKMOC1SWNDKjuDQbNt3YqVawbIsg?=
 =?iso-8859-1?Q?w3xeRSzj+/+zOFBY/mm59TbDacIxr0c9rwz0pCG2WqTgSKhxzcOfspt2x4?=
 =?iso-8859-1?Q?tu9uPjDE4B02ejIcd0JzXTShq1I1cXSNzUgDG76EXBqE/bVcSpheJzyejH?=
 =?iso-8859-1?Q?hvV/fxTlLLDtYGPSHf0Yfl7ESdBbZrrIBFslXkARGDCxxH66lIXYkOXVUW?=
 =?iso-8859-1?Q?504A9TbCycowZRZP1fyeYw2kYhda3JiHac07d5VZNZ0KGlNXonRl+LxhQO?=
 =?iso-8859-1?Q?sDnIGYKHqygzRcXKTtl7pjFzM9/zWmPH8qTnpHfBG3FIF3pi4SkCsU+KAg?=
 =?iso-8859-1?Q?jvrdhl9A8gGVBj4Agid1hbdQ/U+uGGrLnjjpdy1Apf0ztPe5mXMc+zDrSL?=
 =?iso-8859-1?Q?pQyvE7o0uRkzTd9VnE4WE1EWhA1p6ovhwhyZkyAQSjXjVoeS1FbbsenoCD?=
 =?iso-8859-1?Q?FDGiP0BW2QxdKh3EXS4bO+6PLuJxtnTJJNLb5fxNrRod0qmsJnLxEMltJ/?=
 =?iso-8859-1?Q?kf9EIE4rPd5nin7ltdPTJo7m8TYeuoAsNA4XGhGUxkETaQC/2x5F3sIA8+?=
 =?iso-8859-1?Q?2vJev4A/cCyhVK0geOYvYcKoKy0AE5GaddS0OQn2LJSnKfWq0csmspDTWd?=
 =?iso-8859-1?Q?I1Yc5twaSbd+n3pTSkHAtXdsLYWKuSmlAFfaOzmDcCyHdVOkepiWTQENvD?=
 =?iso-8859-1?Q?jhd14WU/3zK6t+pIhqeRkIrJe+gaGtiHP2nETkZ+zwrSD10cZ4FuRh+tee?=
 =?iso-8859-1?Q?EMke7e2v6587dZOkKYqanlEKmDi3u2O4fV83w+vY9EJmSbBipnCvo0oFBU?=
 =?iso-8859-1?Q?e+fLIX+k0joAqsuzuqt80OZBsWOW7oN48aUTq0QzU/NBsBUC7uPvVvZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66321541-70ef-4088-3357-08dd82667897
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 12:57:57.7445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4yplOqviECcLqvw5bmQ5hV2BTN3ddq6xUaa1ndSH8hD0+F9T960PzdI4FAhS6PgauCQDr1/8mIQes1Hk70ewiM6oXghvq59W1Bp5mT4JNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3624
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

HTEC Public

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic

