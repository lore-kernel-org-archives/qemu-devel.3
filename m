Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5D1EB594D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlb-00054p-LB; Tue, 10 Feb 2026 21:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlT-00053U-Qh; Tue, 10 Feb 2026 21:15:39 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlS-0001ez-9B; Tue, 10 Feb 2026 21:15:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvcTK90UeFH9o8FeHdMpZkbkOUAoI7H6/TkBy7cUwIM550BvIRqYwrw0nGJeCIBjcbokXlY4AKPLLVNrMJYTmXO63cNOdPa4fREV7e0SQE3mAiP04I9k5A5iFFFquJvQtbrIv2FAuw4r+lVWqhA+iiCLUm2064FiNfP0ctmtGGPWktZnUZ+K6bFJwRElxY/rqmH9ti+dyvMGhceADeJYk8LrYcDwlRt4mCUVkU6NFUDHOlfTQdAmycS8SJF00LqAn/pi0OCbxWuWQiSgYKjdjVdfYGIghoVZWz0kaqNBmbFS8wBDM0GUYaGEiTOYHe/0UTYM4zzVmUe2M8ZgORufDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYaIs4jhRaKwXnx7cA0ZK0f/mrGkv6rE3J3u0vv+gVY=;
 b=PSdUWKzKMwbLtP36K/+pxrwhckYIYmcKLLFtR388WYjvS/XYl/AFGXG24RQXtu7En4/Qmzg8UeJh/VuaOa1KzMlzi/+qiqt4roN2+34QjCyvIL8u1ITgUTgi94EgD7BQIFnJTaDfYY7H8jOdBj/EPA1FzFo6drFRM0JgzR7UI5RMdvxxJlMqB7efqlgBF9apJqGCM7z3rwslnhDcV37X/nYclIIGW1utCFuCKjk9KvstpnVkS+iKk8qquU/kNuVcu1x6T5G7cQk9AP0zLVHstffcXh0d8UKl4+KqAhoBAnFKWCiR+7r6huHJGsDBN6neyeD4XLauJgwPNMR7gRxbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYaIs4jhRaKwXnx7cA0ZK0f/mrGkv6rE3J3u0vv+gVY=;
 b=rXOvkyzRyR/JuHBlntdr02/BN3gdk13xhtSFFyt0xo3AuUb169ZHZwjEEU7vW1FcqXgnkfvJNXVFg8EE+An0Z1HnyPtJoyH1PO8UJIBN+iUc6uffsAEOw7T2t6KKGfmSPreS3gT12xWXdogL0EOq4lFisFbRMJ05LjMQDv5akLZWu7CnGY8pVxDSyMlAy96VthkJGAFR4661fByFY25ruPKxrYpOgnlAb3fPVIRBIUqYWWRGxlYPWJ1Y2SReG208WufQlaUP0TaeLGIObEppEBzmuBHb0Rr0irGxUh34GpRJg+eFGEo/QIxbGV6eHHSlnLqmylRk44gVbSfatC7QbQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 01/11] hw/misc/aspeed_scu: Remove unused SoC silicon
 revision definitions
Thread-Topic: [PATCH v3 01/11] hw/misc/aspeed_scu: Remove unused SoC silicon
 revision definitions
Thread-Index: AQHcmvxKfsrLRebqWE6TSIcBUlaWdA==
Date: Wed, 11 Feb 2026 02:15:29 +0000
Message-ID: <20260211021527.119674-2-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: db8d6646-405d-43c7-c0f0-08de69136d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uec62wioKc92qeZ+MDNudgvQeYWKekGNeIeenKVS+JDG0OW7oG9ulT5sEm?=
 =?iso-8859-1?Q?xrVe11SAZSqEf5OoqsCakJ1XS710aa/iSC8LEAyHd9Gacb69MeiCeUggwK?=
 =?iso-8859-1?Q?6sgpVoGpp8VFjGs5l0a+AyKHSlU2GEi/f3dV+JcbVIIGHYn2PyYP3pg2VH?=
 =?iso-8859-1?Q?9WmJ/m6GDYHLadfbFCYxBX87tpcgMb2l/DBGd3vSYi5F8BQ1aYdQfuarr/?=
 =?iso-8859-1?Q?4Ay8ldSgth1BfgYDUzqZV7PmTIqLVHkIHgyrI38Dy339N8l8CyNcOuZNqD?=
 =?iso-8859-1?Q?HQ9ChySfU7N5hmikSFOUeNYWLVT+r5tb/TP1p4v7ddwWQ9Q9vCi0KQZ8c3?=
 =?iso-8859-1?Q?kAo12sQoyfG3K0y7Uwd2BSXYdcVowaUXdKD/2STXurwBmtywh4rQvTLaMo?=
 =?iso-8859-1?Q?rXnOZLKawCrpejCl9GHr5DyNXvc9g7nVTSYZQ5wGB88gKsSJuvtC97W/9c?=
 =?iso-8859-1?Q?dYSn6otgkBDW+9slBgxhrN64dxU5SGRkrSZbmVdmk+1QZ+d3BqGZhrE8z/?=
 =?iso-8859-1?Q?6ogcDER1WmiNt3k4wYmpLmij4DXb4sZvpAeyMPvpM2ZK1oYkZyQrldWeJ7?=
 =?iso-8859-1?Q?ohNRuApZIJ/tZtdghA8KnGEayGQv6tBhKSyxlIkwhshj4Cz87lmo9Hw8DT?=
 =?iso-8859-1?Q?JZ1EHWcnhqrCbQBDDhjio93DCoXi3sEi5NwkqbYBMuh+ssuQ1aHxVB9C2+?=
 =?iso-8859-1?Q?9nUHp/AyE772lh1EiPEN/zAznpTDLa7AHXusIOx3HffElX9HC+/RBvf1i6?=
 =?iso-8859-1?Q?zDH+8faISdfH2cjrVvvIG+dIPsTLYVUpxT6AFQrVEVDScA4Ouy5O+oAVKB?=
 =?iso-8859-1?Q?nTa4bGWLquwzWq8dAnwrIspZNurvfLldKKUgRx5i2rjzt+4NsR5v6tvJVh?=
 =?iso-8859-1?Q?TJXCpma5W34cGiX0kE/Rrh4bkaorgJuYqnJUTpNPHpUO92otHksMre25Zm?=
 =?iso-8859-1?Q?QhBsXKvPbE5VMTjTTHATELQEINOmHm+9CwCNKcIChXOuCc3xpoFdAuGWUe?=
 =?iso-8859-1?Q?DOy8yi+ImHeLazC6OKo9bVKWuQQgExkkUkOppV3CYY2m1jglJ/XyQa2WHD?=
 =?iso-8859-1?Q?Tf7FbC5wzwhqOQ5hUiwAWOoskb6lE6KtpnpkQ+aU3tRwvo8T5zqmTa/mDQ?=
 =?iso-8859-1?Q?NeM4rqAsQXre0d1y7PYmAVg35cisJd57MVTAUD1oTTMmrWUyYpzoliR32Y?=
 =?iso-8859-1?Q?2qexyOXX7cLiLJLX9clP21OqB5397rN5y6Cv2nfwiwDzVPvzqySJECkZf3?=
 =?iso-8859-1?Q?IbCcfLE2SAO478Y0JFwugWF01X5uqMUpo0AjijVXlFT1bNla1Ig11L7zDv?=
 =?iso-8859-1?Q?X9G+xZNUasp47XsfPb6kv4HNYTlXnm87Eg94Z9eMpUzddtDURjmfwTqeu6?=
 =?iso-8859-1?Q?+hNSqkqywCSuldhnf/oEGVgbGcWaVJQsYzxFT1/hCWtn5IK8fXrg4KamI9?=
 =?iso-8859-1?Q?ZTMkzc17Fu691GVJQI9Kuv5Fgg9ei5FF9fMZyeTtzjNg7Fft5DuilKB5Vi?=
 =?iso-8859-1?Q?0mm5WYz3AQPIvwCRgcjj3L3E91sNAd1FhrQjRKn3MBSSljNth6xV7/v66N?=
 =?iso-8859-1?Q?Adu6Fj/762O/qMTrrBPrivLORar+XGpdIB3lfSkmdM2yrkErIVcA12drgm?=
 =?iso-8859-1?Q?oZjuGOTeLNoF77glQDnpqr/1LpZ8FU5+UEX3985U+U3dAcWcC73irCBAuS?=
 =?iso-8859-1?Q?QT8jRjOIl+6gVb4SYe4fn8R7lwrEWnNIzgcVd2oM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?302VNFJf7tlCyKagtFAPXc4HeNbuBQrLUWMeZEwTStOphRR8o60VUCRzZ6?=
 =?iso-8859-1?Q?DICllq6X2DpGB1LmNR/y7KxDwNsy7DvIwBrCXUNONbf6HyNzDcopitqypL?=
 =?iso-8859-1?Q?fWl5mEmlyF3F6sc4Jjy1lfyPSXhYqkKQCa1VXQeiKvRuK2h5TBmpc4+F9U?=
 =?iso-8859-1?Q?PuPO8qVtrqKWx2O9tmfgIpC2UjdcSbIiWYxZ6MDLzLgXOoLkHdj2cSnzWG?=
 =?iso-8859-1?Q?3f0hANYLZK27vNxtwgaptzKTFraZ8ib+g2vTiV/Bahw++2H7HZ+l+Oblab?=
 =?iso-8859-1?Q?R+W1hSXVxmusEkNkit41qhf/mVnscSocp112la+T0G7aUaJumuRkZ25+Eu?=
 =?iso-8859-1?Q?puWZBgz++ylRPeoKTS/EVP4/JBQh85nVbV+SiRg/sKxUhZPEZumWf9RszL?=
 =?iso-8859-1?Q?/yCijEFN7FZpNf/BZErlir9i+AjvW6Lnt4iSC0gTxbnQ32qmKIdAyOpQLx?=
 =?iso-8859-1?Q?qhqxq1R3ioZc6hk4awwbycIlWrZfq/NQqmxzUlWzVoAeYiszgxBKxdevNf?=
 =?iso-8859-1?Q?seXO0PZPHrKOtty66ijxGLwQ9D+DIo11RCT8vj0DWmWePgGNB3CvwXzh4R?=
 =?iso-8859-1?Q?31wpDZfkRgv4CBq1oWhSOpr5mhPiK9gyjxNrqeHp5nXGd3bDWGZ8q+6fhX?=
 =?iso-8859-1?Q?1G2NGlp6D4U5r4oGMi2yUeRQRmszdz56IS/tDtsgn/ct4s6SIOLGkfgzXM?=
 =?iso-8859-1?Q?Wbesp/wEQ1kKoKyqM7gqwIqbN588kiSaHOAQKkQHkYJczSj2dj0syqn9kP?=
 =?iso-8859-1?Q?vdbziOpSKeMWrtC9bd6Mzl4U5klNe3+TWdyMSRnYKCl/9FvJGTJxtV4Ogd?=
 =?iso-8859-1?Q?YPXX6VpWk/ATOWrnZRqylb9BJWpmgHP8VALYUD8HobajDPtETKTGiahUQ3?=
 =?iso-8859-1?Q?dW57lh+YOKCBwhSgpiqTrErBx+EXb2ZVuV+dBohst2uljrcnxM0Oy7cJzu?=
 =?iso-8859-1?Q?JyNpP2UW5vkYt75G68pFqoY94LSNQLenKeHWazUvplPqhz2oM5kAeJdyKc?=
 =?iso-8859-1?Q?/i09OOGkyQkcaREuK/WezJkJdwHGEMKndhVOfLQrWXlG/JpumqdxU+qPk6?=
 =?iso-8859-1?Q?P59ao2KCysjG5dwc9Knpo3yxNA5dha0kwNnQW+qzOcZSPVmQvFbyB0kZPN?=
 =?iso-8859-1?Q?EuBLeiKmd3P6StCLHyUs9ZrJjLYcKjxeh3dGGRY+w+L0ErSjS6mwSTfdlT?=
 =?iso-8859-1?Q?wJSQ8ddUa1nEdlfjbRn6aw6swkuApvWq8W5HIjJG4tfrTZozlDkHShhXpy?=
 =?iso-8859-1?Q?Yv4+9CJ64RkZMz3TRI01XNC6X8pa2giIoem77uM5ugBZcv8ooSMJHXLh4F?=
 =?iso-8859-1?Q?GVK7B4dm9qi9qkR9BWWkYnkIwTHpgQMceQLCc15apUk10saCRlnvXIOqAA?=
 =?iso-8859-1?Q?LB/KclTepujo+5kxXNKp+mA0JD7V4AS57g2rPYdHN59UQpj56YGQ+hwi5J?=
 =?iso-8859-1?Q?MJxRHyX1wC1asSUKRyj1Abl2nJHuKGUoiliCMhOl3vM1NuGc8rEYpkSTgb?=
 =?iso-8859-1?Q?T7DZN4K+vINwFCT00+0mLZwgmZyMekmo4lvpLxiQL5X49r5qoGfxCAmhgM?=
 =?iso-8859-1?Q?rPJMlOa1kNUkdGRNHBzpS1De/nHaOGP5F1NWRe2O7x7lKT8Rig0Q4PqNoX?=
 =?iso-8859-1?Q?6Ij8EEBMvIBUXYI+q93iVnEAf75TTD1dprC20UZ0sGEVEC0J2Je4s4pB50?=
 =?iso-8859-1?Q?7FaoaR6EPVoH9kKu0aRxUokCYlYGvSxjy5pqd8PWkQn7uAqjMk+xbJJ10O?=
 =?iso-8859-1?Q?2VKjtWEtXPnP5asF28JSeqhFgV6tvVQpcNZVhgRMXy/ehfeUKUnn29Kk7L?=
 =?iso-8859-1?Q?nZxlNZua4A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8d6646-405d-43c7-c0f0-08de69136d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:29.1843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8fWohGPiFcHuEZWWiK+642MrR5gDEmBef3vKt/ad+RWMG+oHPt4Kix847KC8WkYVa4gOvhzb8uKAyGuholLnCFJOEAYaiZUuxlgBkfoVU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Several legacy Aspeed SoC silicon revision definitions are no longer=0A=
used by any machine models or runtime logic.=0A=
=0A=
Remove unused silicon revision macros and corresponding entries from=0A=
the silicon revision table to reduce dead code and improve=0A=
maintainability.=0A=
=0A=
No functional change intended.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 10 ----------=0A=
 hw/misc/aspeed_scu.c         | 10 ----------=0A=
 2 files changed, 20 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 9e28bd4d2e..313a79f2f7 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -41,22 +41,12 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
-#define AST2400_A0_SILICON_REV   0x02000303U=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
-#define AST2500_A0_SILICON_REV   0x04000303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
-#define AST2600_A0_SILICON_REV   0x05000303U=0A=
-#define AST2600_A1_SILICON_REV   0x05010303U=0A=
-#define AST2600_A2_SILICON_REV   0x05020303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
-#define AST1030_A0_SILICON_REV   0x80000000U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
-#define AST2700_A0_SILICON_REV   0x06000103U=0A=
-#define AST2720_A0_SILICON_REV   0x06000203U=0A=
-#define AST2750_A0_SILICON_REV   0x06000003U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
-#define AST2750_A1_SILICON_REV   0x06010003U=0A=
 =0A=
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D 0x=
04)=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 6829efa2dc..0edf9c1b16 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -555,22 +555,12 @@ static void aspeed_scu_reset(DeviceState *dev)=0A=
 }=0A=
 =0A=
 static uint32_t aspeed_silicon_revs[] =3D {=0A=
-    AST2400_A0_SILICON_REV,=0A=
     AST2400_A1_SILICON_REV,=0A=
-    AST2500_A0_SILICON_REV,=0A=
     AST2500_A1_SILICON_REV,=0A=
-    AST2600_A0_SILICON_REV,=0A=
-    AST2600_A1_SILICON_REV,=0A=
-    AST2600_A2_SILICON_REV,=0A=
     AST2600_A3_SILICON_REV,=0A=
-    AST1030_A0_SILICON_REV,=0A=
     AST1030_A1_SILICON_REV,=0A=
     AST1060_A2_SILICON_REV,=0A=
-    AST2700_A0_SILICON_REV,=0A=
-    AST2720_A0_SILICON_REV,=0A=
-    AST2750_A0_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
-    AST2750_A1_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

