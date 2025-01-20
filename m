Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F811C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmp-0004zr-8n; Mon, 20 Jan 2025 12:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmj-0004rI-G6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:01 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmh-0000c8-OY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394920; x=1768930920;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UgB59vyp3H3Jn7V5ztZldIZgHg8c5PO3izwVPJX5VW0=;
 b=aCwWwJPCkL09quRP5mCnZ0r8d6kClwvahYLAW0qROKfBFO456RG5RkZw
 WL5d+QHHfLoQcDltud83MJvhlwPDwmwjIiny4f56IjfCpjayAjGKB/9Jy
 j5+PXyTRSc+m8w75H2TKFtvEqma8NPwRG5q6u63LQCnEGLwiRwHAvDCz4
 DcNSjdxZkbTbBV6wnGd6JMJXNdeR0BunWdHxFAmiaf8EFxZ7WUPs203sx
 q86xSQnMbWfkL9o9XleXTY9tCsiy+9Q5Y1delSKN9iBSw6WYG4K+4Z2X5
 3YRIS6s7g7uKwOQu0OjxX5HKsx3PSvqP/Qq63iIIyMVCtTRGd6QtAkU7g Q==;
X-CSE-ConnectionGUID: 0JOv/0Y4TPyWPCZfQCs9TA==
X-CSE-MsgGUID: UtrTgLj6Qca4SueB8bJU/A==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291723"
X-MGA-submission: =?us-ascii?q?MDEJ4Wc6wyL4sE8+RShbBIHvVrnE8P6itHe7K0?=
 =?us-ascii?q?W2Ut+8/SnwWC9GURbfTBLJA8jbAQVjDRDh3Owu/BTPtM47zox2SH3mDh?=
 =?us-ascii?q?DYWPGj4E5HHiuEUixT47IxsOKvV+TBAgLRbQexVTk9YNbx/HM9oBbnMu?=
 =?us-ascii?q?TuY5Owr8GYV+Myr2Uaz0mu+A=3D=3D?=
Received: from mail-am6eur05lp2108.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.108])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:58 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwEOEpatIMFx6ztVt14EXGNEPCzcjb79EhlWgua2OtBqIr4ABIZrcNNMOinV/LIjlhuoHeHvUBMZfvYpIXactZWwofNuxS2Nfub01Xemof45VSPwPEu/OsgKyRG9ibE/wDhzNiw5bRBPll4gFIpGVNTWK6XY3rWhNu/uVR+mqzbk3EQsMtlGChtnAyGhlSRrb9xeLpz2QbMW+fBgMDZDrVK33PbWAQQ6OYVQCe/onJiJhQJJYXjjO7GUkL8Aj8CPtrn+w6HMvBlxjE5hqFpEeT3Yx0ID9sQzxfjVY1AptWdV7iqar7QQSmxgCV/YVqiw53/bKYDEsZMFncWG33vhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3aoXB9xnRHA18HBbamlCYkaq59Z3CUVOBuKGlxl1II=;
 b=nAEteMkza4pNzM4IuD1A0iU+zNcGmDQOe7ICmL52REEBiOAGD8cqmmNFYziz5OOwhJ7F08lFWSVIitoTR5JgPddmYjdHfMO3KHQ8NCdpfrHQcVOzsVqOdPEKNGTsFKbKnTo7x/9IMmGGHah4FZBD3hjFNBZZiEtk5pHXkjKq6+TGH2ubJNj7WxeHp/yi2EmWGgipCIB0mlBwHVfGz0UEE6WcZsgjc6xM31Oc5NRbPW1Vfr5smUyPo0pBRFPnQQOtrmh2lu/hKU5Ec1QVTPnj4aQs4KOyEi45hAjIdiSkWDGs82aid7qSWfunsqsUtO2/DtOknnGHh25HNCALm0l7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3aoXB9xnRHA18HBbamlCYkaq59Z3CUVOBuKGlxl1II=;
 b=sG2a4mi73Vb0Ek3TouQ1JIf+wX1gamZMXE+KGkSqBGET6K7PQpgL/YuhvsJvQ4ZdwD2burRaW8XwyYwruesBFe/YdEaB7Hr7n/WoJTyVA7f1rGdLdCn0fOkVs6AIunmqFA51Ivf/kAZhGiMNWBFKU8moU4IFBlpJfTCjK5V6y3vAqj0/pRKpNCblwF7f5W2W4UdZZH4Y8BGcWfCNi9uONOh6j2oW+P9OkumVHjmGqaujLY3s7wmzsigO6MIyDYYgG90SQtZUuReqUFbPlsyI74AMCatdpwHIDQcHVhZMrWCxDQh4OBuUpHHpqImYOMwQ0axuJ/OyOg6NY8MWMqtvnQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 18/19] intel_iommu: Return page walk level even when the
 translation fails
Thread-Topic: [PATCH v2 18/19] intel_iommu: Return page walk level even when
 the translation fails
Thread-Index: AQHba2KZIdJ9XQWqrU+jq7FbQLTqYw==
Date: Mon, 20 Jan 2025 17:41:57 +0000
Message-ID: <20250120174033.308518-19-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: 6c90f56a-4787-4deb-fbca-08dd3979bc6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ntWV250InIe9rqfHqVgKei+mhf7kFn5iLLecRN8otN9wnphpphYJTFtuKB?=
 =?iso-8859-1?Q?XIjpo/Q3DhXWH4Zr5MdJ1YK00lLbvn8EzHWKu7Mbf9GNl3QH+BgcYj+uMB?=
 =?iso-8859-1?Q?rccGKOLbQsVEwMldNsWyvGzvXxtMGAEZq5eZYtCDo/93csUp5uon4pfvNF?=
 =?iso-8859-1?Q?VHSfZiMQ/lsJm7ja+eaAPuZA3DvlXM6Esf0FiVA0UzqN8F5aUgyJY4MfsS?=
 =?iso-8859-1?Q?tZeF/cmABVr0SXGBwIR6mT2jmLg1zKCXuXRlLSecJ2HeY8h/J87wsqkuTO?=
 =?iso-8859-1?Q?2ByuVvbF+53bjqKiOF+hmk2jpg2W2br0XBIdTDL0BAQmCjWjg8FhJBpIla?=
 =?iso-8859-1?Q?c7oa7kZEyiYVZB4xr3F402ItvyQZzkSNmm9gQmWP40Xrs1bl87o6s1nLgC?=
 =?iso-8859-1?Q?hjaOhVcyV73NHmGOkUPH8EiUnYSW9552BrlIryfTGOzqo8qKvBvsb7vSRL?=
 =?iso-8859-1?Q?FrNr5GqX5n+Gljj7TgVPRoV8LnxnjP3H+CJiOi/OxNSpR5k6AjUjYqlK8D?=
 =?iso-8859-1?Q?HK1GfOu8cjBM/MCiZxB+UWdrZ3e4PQYXirw9mdQp4/c/cmOg7u+UvFsKxB?=
 =?iso-8859-1?Q?JiX1sYY/binOD2gDOEGzIf7Vaa/capyzJGggEFSP6Oz7Te7s3SNhDE/CAw?=
 =?iso-8859-1?Q?Ebz1anrhKnucBzIlIntz9B4kYFEYX4kjswqzuPg1x+EXs4idOe3mO1aL+W?=
 =?iso-8859-1?Q?DTdU2svZBuoFIcdXi7HOMqZ7R3jn0LNB8yCRZeawBTWcoTQZYO8ZYvCS23?=
 =?iso-8859-1?Q?U7zIQklv0EaWxM18Sol0ZJ8XAyXO5ogWeid9HmB9sDqkNX70Krk+cgQBtX?=
 =?iso-8859-1?Q?JQyohQkbtgEkrHdV/gZULwUclDO47f9bftQ2WjXoWR57YAkK08gqge2b2L?=
 =?iso-8859-1?Q?miuPOZxm/y0wfU+kCbxfL7ZVUkQwqAMv3CblWeWJblQ4K+zcujgklAVBGD?=
 =?iso-8859-1?Q?MldA5zJnOGvOZhU9y7E7ovFS2CgF94+7x0//G8HFX4KWQCcckv1jfR5SMT?=
 =?iso-8859-1?Q?Yu2RMqBCqpgyqZqike3CFGGC5FvRu3RJDYTEWDy/HBHmDj5C2FLrJkBqS0?=
 =?iso-8859-1?Q?4mwffqj6MVtu1BsNBJhVmFTRQyv2PlKQ/K3OMPa3ylv8SnF1o4eGEFTi9j?=
 =?iso-8859-1?Q?oEIj8Sm21Cw18Unx5gX4xXXeZvJqomZRb/QRuQtheRZM3T62s0Aq1INfnJ?=
 =?iso-8859-1?Q?0u5W75eRdfBBb2C1lg7r1s3pEgN+VvG3zg6irzRU/IEgJbeteNTD3pCmvA?=
 =?iso-8859-1?Q?ZOmecQIbjUYQvv5KYvsXJsBTMciMLWAfhRk6hXHgnzQ6YEUYTH0Uc1HeWK?=
 =?iso-8859-1?Q?35QELDeHtPRSRB4yzkzjH0nynEbOj2HeQ3vTtdyiHk6oq/kH42wkOOSAfx?=
 =?iso-8859-1?Q?GBcXVJKCo/LvGHlmyHHqlTi1a7yE29pNGs3Yfz6Lwpxb3NUdLcnp5xXVey?=
 =?iso-8859-1?Q?XQOjlXwHZMIKcyuFOs6edPY4mZtIoFYEjfrx1oi1M/egStwqcjTzgbv/bo?=
 =?iso-8859-1?Q?QXddonzEKm0hEXKzvenPpH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nJ2mPoDiv+daiZkJOiYiqfSp/XPInGfVl//2FEsuU+/6qdDrLx4o8/bWht?=
 =?iso-8859-1?Q?L8SOf038J7IVvgnJiXyes54QLVNkIwrbyWXwyzmgdub/7Lrj5E6via3nIY?=
 =?iso-8859-1?Q?JDcsi1PkBREufDii29GgZezpg2854fgMftQFFIIZG3Qa7f0CsPFSOKpsZG?=
 =?iso-8859-1?Q?h5sSOWjosRz8wyRCeqhNaO6KvqwWw1S/92dHvkXu3fI1xNO/1qYECiUt7A?=
 =?iso-8859-1?Q?MRJEV3ljfQvp5MXZjOACRC1Q92s8pgWttFFJQFzvKuCYmy+rbnS30wwWPG?=
 =?iso-8859-1?Q?/g7mmsvjAKFGscMzP0Ls69etYVNnvTVHC3/V0iw6z06lA0pNMwh9S2xBiu?=
 =?iso-8859-1?Q?8LJ3RJ8SU3/vXRjnxGNMw0n8wJWbyZQ77JcRzR5PthVwqd6Y/+7kECGN3t?=
 =?iso-8859-1?Q?2K/UbqetolZZwUrn5Pya9N1n9OEUBN+xNYFHkStJ7NOCP63j+HHe2oef3N?=
 =?iso-8859-1?Q?NmKJfzcw8kDOJtPNeszb6GQb2KWXE9OXw9Ve0rbdBf5lg8oToCk1aePZ27?=
 =?iso-8859-1?Q?Ytd0kRH/iorLzSmlIpuAw/FJXbCmRgMvqlno6Zgf1ANXOveVrh1TUETt5M?=
 =?iso-8859-1?Q?EJf5y1uORf+0Sn59bIyVYlwrzYSN4p4LlUB38dnp7tz6S5eozHV0mWxmZF?=
 =?iso-8859-1?Q?kqPsmbtT3OLZ+SKTC+cqqNqj+xa+KwKrrdSTxBl+cSau9aqhAqp0oJvobN?=
 =?iso-8859-1?Q?+Ckq72uJpsqsrelQlVHNoXDEhpiygaF4RnoBRFpGl/D9Uab2MtfQ11xKdn?=
 =?iso-8859-1?Q?EEQi5xWNbxvulwABEF6ImXhLTAdXF91kuCKSmoRQTz91nAYchuFgSsHkcl?=
 =?iso-8859-1?Q?xaJcBO4I3VolPy0BUGcdjnAC6R9aT/kvHzAff/ofyoA5u5rBK9KI5Tl7Bx?=
 =?iso-8859-1?Q?n2SSvUeXarwUsYsoGvVReUog5bPf5Sc/LkEG+XJ0c5M72+2Awi4K3DNp60?=
 =?iso-8859-1?Q?P9yEa9wTDaGd0D+OuKdI+ioANUUqIFNskbq/YWdwKUn0s3RFxbVTvYnmDh?=
 =?iso-8859-1?Q?RyiHmFxan83Lk6Wdj9bi3rR9EgSAAqaBPcCDmsCUvQ+w0PX2UgvwlCN/P7?=
 =?iso-8859-1?Q?oi7FhN0W5f/JyxrhwyYRGqSysOOW494ul7pQGg0HVceuTL7Bed5hSc88sK?=
 =?iso-8859-1?Q?ouE7Fp3LwyvkEfqCQUoPb3BwIhHpHG2JtCbg5LV2n2nufNzrM2RZAIBq7p?=
 =?iso-8859-1?Q?iskcXXfprAyVkLvOZoBAPzF+j+y7s5qnMblqHYhi0pb+N/eCno3AvAhAvR?=
 =?iso-8859-1?Q?eLQ4wmKnSQf+VU6uKaD++U8lzCz5gftUaSYRzVdU7kXYoRCeSye2AjwJFY?=
 =?iso-8859-1?Q?gcVeokILn45OBPlwrW1FGfquxSJqZsN/dr0KaPpYTVWK+zR0Az3HIWTZf5?=
 =?iso-8859-1?Q?oSIMcE5AJAUURxuvg2zeDQUGfBmIjQF7jXUcv/Fiu/oJi2ZIeiGYf3mUgj?=
 =?iso-8859-1?Q?Eba3vDnJXV+DwgGGizN0JGC9NYkxY/G1cuWac6Whcg4UzjI6hOD4CFfAJy?=
 =?iso-8859-1?Q?i6YVXvg2LlDpaT8nkESIaaS1mqRxxU0t7t85dauxu1wz7WNksaXoVWfc3s?=
 =?iso-8859-1?Q?Ajr3d5R6NKlCQSFfXaMtjD0+exkzFOGOF6BNUZmP3OYmtbpv9JRhEs4FpI?=
 =?iso-8859-1?Q?0NobZZzwhcMCio/E46ZzRqts860iNhLVn+Ne4fgFRzYy51sxDm9OHidcZJ?=
 =?iso-8859-1?Q?Zqjf0yirsRlqvVVcENM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c90f56a-4787-4deb-fbca-08dd3979bc6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:57.1050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ErH0fGvVuliYHbgOHiUic24Bp9OL1zuieSbGFnu9KKpCm7kt9HLuCR89dqDmK3g3mfGjz4Dm8RQ29f4zuvtIT6tGXUSVyci628to5uQmDdOjL/AJMhJb5ysxAjjtYpd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

We use this information in vtd_do_iommu_translate to populate the
IOMMUTLBEntry and indicate the correct page mask. This prevents ATS
devices from sending many useless translation requests when a megapage
or gigapage iova is not mapped to a physical address.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 530b75a9a3..3c31dc1047 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1995,9 +1995,9 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
                              uint32_t pasid)
 {
     dma_addr_t addr =3D vtd_get_iova_pgtbl_base(s, ce, pasid);
-    uint32_t level =3D vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
     uint64_t flpte, flag_ad =3D VTD_FL_A;
+    *flpte_level =3D vtd_get_iova_level(s, ce, pasid);
=20
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=3D0x%" PR=
Ix64 ","
@@ -2006,11 +2006,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
     }
=20
     while (true) {
-        offset =3D vtd_iova_level_offset(iova, level);
+        offset =3D vtd_iova_level_offset(iova, *flpte_level);
         flpte =3D vtd_get_pte(addr, offset);
=20
         if (flpte =3D=3D (uint64_t)-1) {
-            if (level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
+            if (*flpte_level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
                 /* Invalid programming of pasid-entry */
                 return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
             } else {
@@ -2036,15 +2036,15 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
         if (is_write && !(flpte & VTD_FL_RW)) {
             return -VTD_FR_SM_WRITE;
         }
-        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
             error_report_once("%s: detected flpte reserved non-zero "
                               "iova=3D0x%" PRIx64 ", level=3D0x%" PRIx32
                               "flpte=3D0x%" PRIx64 ", pasid=3D0x%" PRIX32 =
")",
-                              __func__, iova, level, flpte, pasid);
+                              __func__, iova, *flpte_level, flpte, pasid);
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
=20
-        if (vtd_is_last_pte(flpte, level) && is_write) {
+        if (vtd_is_last_pte(flpte, *flpte_level) && is_write) {
             flag_ad |=3D VTD_FL_D;
         }
=20
@@ -2052,14 +2052,13 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
-        if (vtd_is_last_pte(flpte, level)) {
+        if (vtd_is_last_pte(flpte, *flpte_level)) {
             *flptep =3D flpte;
-            *flpte_level =3D level;
             return 0;
         }
=20
         addr =3D vtd_get_pte_addr(flpte, aw_bits);
-        level--;
+        (*flpte_level)--;
     }
 }
=20
--=20
2.47.1

