Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2807E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXz00-0001ZO-Qd; Tue, 23 Dec 2025 04:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzy-0001YQ-Gn; Tue, 23 Dec 2025 04:48:10 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzw-00026J-Gw; Tue, 23 Dec 2025 04:48:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQMeBu6cyRMnG1cy4mtku3tbk/BXq/ZUZWao2I0ehdfqV+CfycEwA7woMqEbepwTz82X8CMxkhcSaUYa4Kq/ilCPVNgYLE/33OqJroPly3U1XrAH6e0mkLGO/S+FGZ/3Q8VzQFlc+8vPwM8Q9ufqkHSqG0CjHrqW1o0eqKCU1lIuYr0TLsgwEM5nF9Q6wbFlOfTqiWsJ+P34faraFDM9njJ3EywOoR5ijkfTtl1+Oub9/NmNvumFj4/hiqPxuds5G1k5Q7gJPEDL2wzTjTPhJDFngocFlvs+5D0VMWsqmQHPLE9AfC9gitmhx8G2nZztN9bDa7M/3AJQDERPYVbYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj6QD9gF9ExNpegQdBxEG5THvEZ2RZQdRwUJN+TN48E=;
 b=gY66vMCTiRwIUs5ZYqZo0IyWCSSl7IqHM+g4rir/vUxH4yGVDeQF+bZgLP6oFy8rqjzmWw+ZLygzqPplNfRHXJfYXjiTInNIOCWyAhj5j+fDswDqqeI13xqZJIZ/XbUDACS+bD0RGrTiLV3yP2LUCoFqsxqsYVV/PBGTkwX16t6vza1R13ljL8ljqETnFlYtTBAuQdSwO86tldocQTez2al4zY2Xupzm6KiGbCVVwE7yRDRCs5gKRBBzt6DMw3qTM7QYNh51+UN0pu+rakXboO8fUN45xmAuO3z62ws1DD7xNgxjHmS4rox09R9qQL48iH7kHSbl0TGTpSi+gCdpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6QD9gF9ExNpegQdBxEG5THvEZ2RZQdRwUJN+TN48E=;
 b=MzqxnzFjvK0FpNuHyA0UkXcFYB6udyyv1GG85gCgs2CGQhyjT3WcmiEn72We7tFRPoalDa5uSXc7Vz3j4Dblw4qbK/cymAbLF68pqgjYzlSmqrM1g3FpFvegY3J7mGQ4owXh5kIkvrgz3knJ97BwHJjOVJXuNFAJheSJ6bt4uRjuzjyMO4GBTwB7egCF+VHSbLj7o9qniXqUheidWD7x6bTi2zsGf69Td1WbSHNmNyEBB4SKP5uzS9SGrDpLnQ3gCZogdDpWnuI8cuC7mZgPP93G0iouAPUeoz3GeZUZ485Cmg85rdmRDen8HvPvhZDVJGWpq28Mljl2N2m9Pp/xhg==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:58 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:58 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v15 09/12] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v15 09/12] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcc/E2AC0Vq2hmpUeuGRuO9m9Ykw==
Date: Tue, 23 Dec 2025 09:47:55 +0000
Message-ID: <20251223094739.1983381-10-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: 56be97eb-88a4-4bf5-626f-08de42085ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nrtZuH1i2DsuA+TCggbWvwYBMGxJ4UoLijT723YCY//gQ53n+iJHHd+Y0a?=
 =?iso-8859-1?Q?EGZFXKwiimV53dU+8tsa827XMefmzPZp76sL4xRhu+OAPTL4f4BNyewPrl?=
 =?iso-8859-1?Q?G6ThZHFEt2RSAJ6niNWST85R93xNhml2Djm82VYIyasguXfi8g88VgZZsR?=
 =?iso-8859-1?Q?kewl4khDAaeg+TG00fslumwgon0Num9K64Zgdd38EqYcbXJ/utaE7tJwGD?=
 =?iso-8859-1?Q?4KUU9iW4fzEK/T8TQleGu4owuAoqAFy2fabzt72moKpPQvdXhbh1Jd6PfF?=
 =?iso-8859-1?Q?pwNqXesYKoIjWqHFeeZJrdAdho8z1bFSqXBaBBHRW/JTBjA1A5HNggB6Dx?=
 =?iso-8859-1?Q?sS2WjsxOXxl23SnvRHkjhkbldN0sBQTR6pxz6W16aPOC9ItP7cVrAM536C?=
 =?iso-8859-1?Q?9H954tqyThgwSJ9ejpr7V5ngxAo7vwEyBHilhqQlbxxZXErPhQNwl49x/a?=
 =?iso-8859-1?Q?3sDpdCwbljQ8j61ci86Be1nrWK8S0gQbAe4ijR5rktLeQno1ADhjEeM8wd?=
 =?iso-8859-1?Q?/R31O9/QeoSYHEqDq+pRIoq8VMb6/obNjsBz86oZEJ6fDHymfjQapEJj9f?=
 =?iso-8859-1?Q?YjgcgD4YUrUyp7+Sqa3r0e4nSF31WbFkVs7mHVbdyXEfse4I1paYSTzPO3?=
 =?iso-8859-1?Q?1Aw6sfJBaUevCRPG7FnsdZEgkNJUzc22hmZHlK0R76KdttUkzPfQgArzRv?=
 =?iso-8859-1?Q?RBxJYrFEJLjG4402qIKPHM+hcn9y5RE4kIwDLJlE6i7fHN4NWbY1Ar6E+y?=
 =?iso-8859-1?Q?9DbEkYmpOIhCxqSiTFIbphDaJQamHYg1ecQiIFrb8HdTWyBZdBUGy45qdN?=
 =?iso-8859-1?Q?0DAzoksP8hJ7+LCPROz4Y8STPYAe2gwDfuJfDeLnHc1iVk7Pzd3wDE4ALD?=
 =?iso-8859-1?Q?uY3DpL9thlOGoLB+jX7a0UjiyORS3DA9BJb6m6LXdHE/Nv6OvNGX74pHO3?=
 =?iso-8859-1?Q?a9VDmrvkuYPLPqlT8lz6pdvQJC8r/ZMuCVdvcqyhsuRD92FYhbg/bP8PHH?=
 =?iso-8859-1?Q?T2la1d0No9ZZdKZtaOT7Y3mupKd2Y8hwmQEbJszZoFwzEIx1nYdpNSgVcN?=
 =?iso-8859-1?Q?K6eLnz4HiSOHfjYmZcnbpDLYMvfVDtK29jMnSCXNNVD/ftUFTKjZzYfwpw?=
 =?iso-8859-1?Q?oea4HLXpCdAP8d60ExA414cpQSSRa/iZmPbu5MV4gbXTSPSZs2sgn3wXal?=
 =?iso-8859-1?Q?SG40dYB4k+wUrGg4EGk3Hg6JWz/j45XM2ET75kLSzo7wf6jdabHJGd5u7O?=
 =?iso-8859-1?Q?mmgYpsOKXrNSrsoIAlC5bn3IgM3IhcUI8KI9NEHRw5024iORkb5gcP2QmQ?=
 =?iso-8859-1?Q?6EXjMYDrih589gzWRJXhsEZgRQLhIp1iP/YCEH7ZTFhioCmCcU1IRFrtfW?=
 =?iso-8859-1?Q?jv3yGahMTNlSPzGQU3AuZxmYbqwlw+5VKd2RFbYuClHE+T4LyolpI0xj/T?=
 =?iso-8859-1?Q?smeqHw0ZXS+FL3FwBsnN8Rh/0sD6N2824tkNcbBYbw9WFj00poWTndlxsS?=
 =?iso-8859-1?Q?hXvz6Ez75YjbZH9weRJ2xCb3qYq4Pp91MD68S4x95IScD70rN5+Fdw/bQa?=
 =?iso-8859-1?Q?lSoQbgpNbFcBulqZQgfduswT9aoj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4yKEp78eKimBvC8yE6cLcRmeUVNcpBzs19Eg2bYsxXzXlvunERGaAq7UW8?=
 =?iso-8859-1?Q?edg1if27fJ7Evk3XgfkXMsSyW3ernry3TIhhgdfbC4cR6HZ2GhvBJf2rrb?=
 =?iso-8859-1?Q?NghUpufpQWOL/saXvXXeqwlzKqGfsRPT8Fx0NVAdmLLvtg35TIIdyajIkp?=
 =?iso-8859-1?Q?M9zM5OoYL4OOlSLelxMEPBHnHa3F4kmqO0iz/b15iX4aP8h5PzIp9cJ3fj?=
 =?iso-8859-1?Q?+l572Uu3RA1VNMsKr+rMZKSKgrrFtgG70L9c6avWj8Fi0uyJNgKvvnGa9f?=
 =?iso-8859-1?Q?ut6v1exfpSXaq3No6slhlPzB22VCF+0St4zkXcURXbA+H2t630NJLyNsfo?=
 =?iso-8859-1?Q?Ak9UwL1i1rFjEy2//pRgTs8PQ5mmmCIv7k046EQuJdrKzp64nXp0m1RnMP?=
 =?iso-8859-1?Q?Bck6cjonUhLWznT37I2nsOxCgWpYKzSmSUNzIylqsFJ2Vp0GPfAEbivw5Q?=
 =?iso-8859-1?Q?C+enMEjkaCix0k6lT3sL3mSHfukVW4/pYfm/skGn51GDGzjI/6fKq66jUb?=
 =?iso-8859-1?Q?PiBKwcew5SoGds5wNn5GBsZr9y46/t98xlZ5Id6AJMoDWQnByUb/T4c1NN?=
 =?iso-8859-1?Q?OTrs6wMKVFoX0nJBxT15sI6Sc3F4iCm9NpIO8RZ9FyCXT0ZY/QVKQeyGAH?=
 =?iso-8859-1?Q?DK0ACAJPM9q1QQn2KC249lQFuezM3HUroHxWck+yAbTpSjQK76GBzA+Vi8?=
 =?iso-8859-1?Q?1oxnuuSUHSZfw33/w3mlm+Nt2MqWDT4pBQmzRZmIgSDoTc3nWvzckNA2C3?=
 =?iso-8859-1?Q?BKJy0I97QiOOFwt9XDWQy8JFmadlbDfdmJEu3rmHfNYSsM8U/21pyO8aTD?=
 =?iso-8859-1?Q?2q46NiQl/XNCuRqqwwAFYtT6LQ5NOX4VFcNdeJsnL5GnHr+ru/4+YdKRTl?=
 =?iso-8859-1?Q?eBl7PfTK5c5pZcX8A4K1ykPdTjR0Mnjfo0+n3dJkQneuOs9SvVHr6KSwYh?=
 =?iso-8859-1?Q?EgqJaz7hc//9ImAk25aXW1ogJv3yxFAnEYLnBWWm2Xp/w2lSl+Uv1UEz0H?=
 =?iso-8859-1?Q?im9F064dKmjOKdZk8eOPW4SlhimuhJVkonePI2rsluyQtTxxYVWUCf6HFh?=
 =?iso-8859-1?Q?hE6mIkpiuK2iZb5tw00Atojk5tFsEtONujLxKChSOTXuAwSKK6f70M1gjg?=
 =?iso-8859-1?Q?Rtj2JJ/Q1LVngb6AEHfVIck6xkeVGzM72CVaNfQpps7iJGbSPHUCXZ5HHP?=
 =?iso-8859-1?Q?4RzYLwoR4M7lbEo6QaUQIxWXKqlwE5m8bwYdN4msO0CI12EQ+PIh/mZzDz?=
 =?iso-8859-1?Q?qUdZjoVKx9u+WZBKrOYcVMYWS12Xo+XLx39SU3X6fzF7w/Sxiqh/ypebv6?=
 =?iso-8859-1?Q?feFZq2cYb7HxOl93yi4agbsEIH3b33uWoije1wDz3wEqXAuWNM/zapC+/B?=
 =?iso-8859-1?Q?i90RN4Ms11dWYS70J7SsZlcgkpEzCdlfBkzl5hezPZfPh4otOnjwW8T7kT?=
 =?iso-8859-1?Q?hpsyynw/YyHhoF8zs5vF5cwozxFMZ/o/Lud7FsyXp0fGDTjsaBZyr4iaPk?=
 =?iso-8859-1?Q?bVKfeYxPeNgpHbIKEIjnfCB0MFkbfOMTTJCmvYAWF+HTf/s7+va2yoy3/d?=
 =?iso-8859-1?Q?pp/GyWkPjhbr/Z/5l1R11ra4cxy3DRPMw031XG/BV6cFvRynRrYuZpIegH?=
 =?iso-8859-1?Q?5fKVoPN2j5o4ICN8ABiPaidKgi1Ukvv2yGRLom3AmPbibVd/3FsxIwZyfF?=
 =?iso-8859-1?Q?hWs9BTJckTIMYmyDgHsLvRtb2AIeWUidUx6X1Luul0ICR1zIlFyuqeEPM7?=
 =?iso-8859-1?Q?5J+Hu/AxVHlf/R7kUuZ/2DMPWJfk5R7ymweMbsQabb2COskmQcI+lZhxv8?=
 =?iso-8859-1?Q?Ml+tVui4dB6PdFgzTKnsOIXWwRnTaytVpjaX0XtLyzd/wH72DmZ7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56be97eb-88a4-4bf5-626f-08de42085ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:55.8470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwECGUKyG0FBv1XwzP69isGKdBblbtsenXc5MteB+bIwl7XvmnfSr/k2wyXpb79K60jHgKKqaLMFQ8qu9zkodSRXt6wCZiaxETaHgL00y+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig        |   4 +
 hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  66 ++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 38be72b141..4a22d68233 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
 config RISCV_MIPS_CPC
     bool
=20
+config RISCV_MIPS_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..8642d87fbc
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,196 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s =3D RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MA=
X);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    CPUState *cs =3D opaque;
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s =3D RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Validate num_vp */
+    if (s->num_vp =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vp > MAX_HARTS) {
+        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
+        return;
+    }
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, s->num_vp);
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster =3D s->num_hart * s->num_core;
+    int num_of_clusters =3D s->num_vp / harts_in_cluster;
+    for (i =3D 0; i < s->num_vp; i++) {
+        cpu =3D RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Store CPU in array */
+        s->cpus[i] =3D CPU(cpu);
+
+        /* Set up mhartid */
+        int cluster_id =3D i / harts_in_cluster;
+        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
+        int core_id =3D (i % harts_in_cluster) / s->num_hart;
+        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid =3D mhartid;
+        qemu_register_reset(main_cpu_reset, s->cpus[i]);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+
+    /* Pass CPUs to CPC using link properties */
+    for (i =3D 0; i < s->num_vp; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_set_link(OBJECT(&s->cpc), propname,
+                                OBJECT(s->cpus[i]), &error_abort);
+        g_free(propname);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc)=
, 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
+
+    for (i =3D 0; i < num_of_clusters; i++) {
+        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
+        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, /* hartid_base */
+                                      MAX_HARTS, /* num_harts */
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, /* hartid_base */
+                           MAX_HARTS, /* num_harts */
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken =3D false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, fal=
se);
+    }
+}
+
+static const Property riscv_cps_properties[] =3D {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info =3D {
+    .name =3D TYPE_RISCV_CPS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPSState),
+    .instance_init =3D riscv_cps_init,
+    .class_init =3D riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..9023b80087 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
+riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..00f17112c1
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,66 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/*
+ * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+ * bit 0.
+ */
+
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. *=
/
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+    CPUState **cpus;
+} RISCVCPSState;
+
+#endif
--=20
2.34.1

