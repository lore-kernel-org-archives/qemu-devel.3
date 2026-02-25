Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D66BF5543A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OD-0003SC-3w; Tue, 24 Feb 2026 21:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O9-0003Qs-3C; Tue, 24 Feb 2026 21:12:33 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O4-0000HF-RA; Tue, 24 Feb 2026 21:12:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ur+LWJO/seD3DDkCttkJwsB31B9V/6omGhBpVacTkIH9G9nq/tgDMr17G+Hr/cy7fjYDllXF6H6fz2hdtdd/rZAsXE4Uq/k/qPX5OAZ6GqkQhn/CC4sRwYCnGob1yPys3gkB9FF7gveMJ4kdIbt881cBLy+Cpg8qL3MKhfiuCt1TKqQvUUYsXORCk+4lQlpYPjIwtA70DI7plB/iG85eNtSot6q1Dx31xk7GE0wHKalSMXvv2MbfsFef1LXQ1turVNicL7qvH+NmgGDCHK9lu43mN8u0DGwKqodAqNpe/beSED1HVv3nijGJjkiOQ6wOwgb8uWuGD7Bemvq9DpqPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnmXeYBvdtmxCSifXLzjcOYLqzLrFcXVllZQ+U+n+FA=;
 b=NKWk/8K+/yudyJMSpU8IRqXxhJeH7MHmkmX0sIBm20vkcL5kxpFGb9VZbLoV/TrrXJF7b/hi5p1SwQciRm/haIS+jE6/8h2FLnuTApupl+oUgPWXrx5mESorQNHco8YDdH0j2k+qVIkpZDYPZ3HrhLIl2ceTBnScX/U8DzoqAH/aK+SiczaXud2RCp8hR4yUo7eb21kyG0oMzQp/96kY87YzA7jwtz+2JJbT5mymP5DYXFXAoi1+Qw8mBb6G6ZUPupU6slTPGEMrNv48AJp4EKGW6mDg7hcI09sTraSgS1aFsoaKjpEpHo3RwT29935ZWl0xhVzLv2/AFApHUn5g4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnmXeYBvdtmxCSifXLzjcOYLqzLrFcXVllZQ+U+n+FA=;
 b=mqXvCDt12rQcelCylaQE1WPvCWkUmRA+2nDVpf83YDkMCmkGlQcK6twxyzLD6eshjUpUpA32/guEsDKHtX0P+n+FL4gzIvs4eLEbAQHZaPd7PwVUdYC0ArmDIeRHj9iXSfq0pz7dAL98xwNY4iT+Bq1ugO2nsBLqtkchaRRGzDaOrM9sR4Gd6OgNT70DlxxjQie47AvBfUg/M+g6EALhLYdIm/fGtVKWn6IqjahXpimnFvKXqjzURIUZVa1x7iydfIw/pJSH52R39TC9zsfYNb8C+mXJmoZsocEFqsvI621e9VM8VyKJBWxltJ5yIaC5vj75JO4XVi0WIlq7bV7JCg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:23 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Stephen
 Longfield <slongfield@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v7 13/22] hw/i3c/dw-i3c: Add data TX and RX
Thread-Topic: [PATCH v7 13/22] hw/i3c/dw-i3c: Add data TX and RX
Thread-Index: AQHcpfwtShXMStDwpEihSkYYlsbTrw==
Date: Wed, 25 Feb 2026 02:12:23 +0000
Message-ID: <20260225021158.1586584-14-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: b987be64-1d9c-4ce7-25f0-08de74135065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pK4V2gmKXShbmdmaOBFQMjFpiPaJr/P1783hX/8mChnxqkR9WKGom1JF1f?=
 =?iso-8859-1?Q?59UTPoH1k4sSvPXVuwA95VewIRnZg2nk/S2UIglgWE516dmEh3an7rKIxd?=
 =?iso-8859-1?Q?aXeZ6xhZs7IWyX3pdXtU8Dei090rh3cYzG4pkLzNvpqpO8M2PgO7rbV6dD?=
 =?iso-8859-1?Q?bRsIKjhNRImH9FYpOgujnYGsL8QCzFLyXx0JTsIMAw9lnYj0asqnAc+mUk?=
 =?iso-8859-1?Q?CL2v5ktd0k0DnY5SVzFNQJs+6bPqtE5PMWYJ3dbYhLA0bu6ugZnCK3J1Hp?=
 =?iso-8859-1?Q?u/M8EVoZbLAth2WCM7G7EF9oTy8ROyS1V9KnPze4jivRhkaURmb7FaHa4K?=
 =?iso-8859-1?Q?yG/sicAe/W/M9ZaHQXhwEfV0ThrrQXJENjv3btR5vmsWxDjklSImxbFqQl?=
 =?iso-8859-1?Q?zJv0Hl1mYuYZ37l2HySgiXEyYhxJbdElNZ0TSRJWuJWpRsvaB+LkgIW2Wz?=
 =?iso-8859-1?Q?kEG13KyqDWSi7izqJEQgq57uiPPd7DcrVg4an5T7Axv13eGApTPdLRo7af?=
 =?iso-8859-1?Q?OfRqRCNw4MIlR3uy7Xw42ZUPIceNFhgSMVcJa/LG7stvOCzsa62974JQsz?=
 =?iso-8859-1?Q?WW4ZdLJJ2XuC7x0oQvCR1Lwt4O6wJa3qbaoG1vpB4UnuchggOBfE/4aHHM?=
 =?iso-8859-1?Q?bqruwQHLLtbqd6eW2Q3POPKADPwkrzONtzHeRPauT3yRDeNwHH8D4cW8m6?=
 =?iso-8859-1?Q?zvwQAB6QpV9Iz6Ua4vLgI2ElXLOXL8b/w7Fi0sflkrYkgcQfUmhwDyQtz9?=
 =?iso-8859-1?Q?U3xC2zocNWXdcOiQGalWmQUdj9L8PWco1xidMEaqkUdzv4YU4R+xeE4EEt?=
 =?iso-8859-1?Q?7QoA5Pi7KAzi8UInCMRNP4ytPfW0ddddpo6aIa5cXZONDhd5XddWe057QZ?=
 =?iso-8859-1?Q?vjaCG+xjXh9NI2mj+Rld5JAajBHC1aN7k4xx4VK87EtzkOmMtIVYPuHmAI?=
 =?iso-8859-1?Q?eTH0HV7IcRijy1OgPA4EcPIBproNTDsBcssPw0Hhh/O+H4s5JYfJ3QpS/4?=
 =?iso-8859-1?Q?Iy3VizPBUvpC+A+9tLa3LKVkvjePcwd9zQr0iwo8oKQKqVxEQc1tRZgVpn?=
 =?iso-8859-1?Q?z+OVBTz1chiaaC7R3wN34FP4sUmNsHTJNW3wOuQijdk250p2lM/pK7uWT/?=
 =?iso-8859-1?Q?09vG/FWwWuOX25TAQbzp0S/LJjNWYBgh60N0UTXuNV983+EYFd8dxkyiyT?=
 =?iso-8859-1?Q?o7WiMLzlqv9+wwoODBZTEmTB2LnbA5xHYlk1HgsBigqcnycACnkNevuLD1?=
 =?iso-8859-1?Q?bmm6SkGYGEiM6H+ZvRzLoXgWs1E+AYF6KKv9Wp8ZH2Emp8YkhNmkjCbr9i?=
 =?iso-8859-1?Q?OV5XgFeAC1MI0PDCWJo5EiX/ABc3LLF+C9XsbBdj9gwdmNGuWvtsQvSt4k?=
 =?iso-8859-1?Q?sK5WzpUfepRyNqZNvatA9hDbcdSkhV1jx815Uorbil4dViDwdgS2fcTNAV?=
 =?iso-8859-1?Q?NWEjafqEjrTcH2FP5Lk77TNLKAgCjuSSrY6JYeANqrsQ4ASiGKX7fLRvoU?=
 =?iso-8859-1?Q?nEkP9Gmggqg0xxMYfRVFA0THryz9o+qHL75GCbA3Tlax0LWsy+4IjaBNce?=
 =?iso-8859-1?Q?7O3v6c6plsC07wJRnvOFASJdfRi/jQtGhKA0Cg+2zRt/C+evvWZR/Kj7zn?=
 =?iso-8859-1?Q?MMzlDq+IiVyTAbJEj1f7LMOZkFsJxeQaV5jM42WaciKf29ZHYgbDbEA/rz?=
 =?iso-8859-1?Q?kcvdVIesNs+CvrbHpodJzimhYf74CpurtElO3fQs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hTp+NdVBa23IBLKJ6mIxU2XWKeoPH5TirLq6ogFztlOcAA3ZpBDckKnw7d?=
 =?iso-8859-1?Q?1+XW59aHKasTkobVhW4VntgkF+QB7JIBaygyZWPOKetCdiAXBCtjJHNz8k?=
 =?iso-8859-1?Q?6GfA4tI6L3QWL5ncaW7S8ZRYahwmjBUC0S6TTxs+1QlbaWDypS1jt7f0CG?=
 =?iso-8859-1?Q?kYQJGGLnHCEPZcBBLKXe9YQ4DpZVbvlZBdGXXFFjWA5WnmXo1Vkeogu+TF?=
 =?iso-8859-1?Q?zTkaHu2UQIaD7oa4k/WJUdnltIRWpkWiA9ZELMNGi1L1OmwQTjXYuHp9ZL?=
 =?iso-8859-1?Q?M1v3hg/ZuPAap2WSeY44J4gXerv1FJxUjqQnoXZ6oZEG8PQe4bIDCH8mYP?=
 =?iso-8859-1?Q?i0ANk0q6VCQMS8o09+/yMQHOLCCcjsRwr6uyn5px9t1eC0Ojvy2x/7sGmc?=
 =?iso-8859-1?Q?OxeHzNLC1S/CLknQfQ5oxuA6UcpsqSmogAaqE5dQnVGI/HJhKJVdZWhnt6?=
 =?iso-8859-1?Q?a8nf7nY6+BEPwtmPYUNliAo3pYJrXUO1fxZduocxi1uRCf8xbazzT+8faO?=
 =?iso-8859-1?Q?g/EazpgW5Mfxgr8NeAahRpyq+V+/mdaMje6udw+aUp1AXAnfvU0ZiNO8CT?=
 =?iso-8859-1?Q?Qx/wNHSpa54JEOjXx7BrRj+6kkme7y8v5GMqOtDcc+l04IwoYYt7U9B3jf?=
 =?iso-8859-1?Q?NFmdAq/qf8rTgU1MUt3kOMXrSo9onXA5uGglqN8/Fh2sDOmzQGmnV6B6SY?=
 =?iso-8859-1?Q?lu+y15vcF8nAgpiXhxwKP/fYp8GZPLvFkHNlMcZ2JH9//PiA/vFqSNdMPC?=
 =?iso-8859-1?Q?fDEueWYtfcFU+UhmpW8QeUGpMABJtOxbjH+MuKED5GiLEgsxyiUXT1OpLx?=
 =?iso-8859-1?Q?Au2yiebIsnDROZ6Jdxcsjlhf5vnha3ibTecj1xapNAnjEYKdgbqTPlbmMZ?=
 =?iso-8859-1?Q?v0924mjjQ8Cqs5Vz+AAt9sw2iwt7dPYrGTe5rlVfMc9lWxDg3dhzR17ywY?=
 =?iso-8859-1?Q?BZHaPIYWA9p7PRvhL8DnlX28wBkD/icbzKqxAN0ZlU5VipwMTUW4wi6hm+?=
 =?iso-8859-1?Q?ck0zPfpr73CthNjQOf/Bv7CGc/0pvuD9xuKREhJRz2lrAY116xCKQlF2v6?=
 =?iso-8859-1?Q?L3uUgZsrnD6FSQy8sXgH+eqyWA40hs9KojdEpWiGX9ECzSgvDfmbTVr8FM?=
 =?iso-8859-1?Q?dq1IsAo1XSBkk5qmAvAfuC445pA5ZwLxgkW2YvLA1zTQRJ9xRZWnxt7pMs?=
 =?iso-8859-1?Q?rxN3fNcrum8sgdx6zZikPS5y5kkZQj+N/LtVPpP465d1x8WlpVJBM/OK9k?=
 =?iso-8859-1?Q?yUtgwqJKkeW2NF9SqGvMSyzP8jQ1iliRBZeJZOSEfML2iAwfw+/G3LKYQr?=
 =?iso-8859-1?Q?YcYAs8Fd4w/S615V6Tij6Hm/MBm/cU7AhWZe2Dq3X7qlNOCszNBaqdy+cR?=
 =?iso-8859-1?Q?UZGrXgLYj+w2FkX7sw3GE79zZQQbXwhWJAcsP/rk63J6g+dq+xlk0xQfjz?=
 =?iso-8859-1?Q?YsxMcnueXzkUj7C3gAGT8QrQwqHJM1CwGHcQX0GKntcQCHtJ8wnNBVTiuP?=
 =?iso-8859-1?Q?zzGOgth6+ejxZHLg8hNLDkt6nDi7PldDUPtDiKyDdGHAGqo6r5b+WX+9uB?=
 =?iso-8859-1?Q?lMFIxtPRc/m5oXUVfzaCnEfarpbbwP1NLqoHo0RH2yH8w1ydn5xs98oaHm?=
 =?iso-8859-1?Q?8gDI0cgxEwC0Rtw20RwiRG4jlQtRyuAfoTvrP64vAUn5BJn4oWLnaNZVoz?=
 =?iso-8859-1?Q?mp1ZfrappnQeJeh/u7TMVoeONQHZopR9K4/loiunOUdTW8Vg3tspc6ninq?=
 =?iso-8859-1?Q?D+eLoPbswE0JKJA7wm1jQDnyqfowWv4vT7WyZ/kT7OJEfaPBoBNzIH1CA/?=
 =?iso-8859-1?Q?bBAIqw0Aiw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b987be64-1d9c-4ce7-25f0-08de74135065
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:23.4884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrPbdLJh/ClRRwnGrLahayvNcLSLJkT+/1WLKEreicPum5L3BAADHZaWv72H7umlmrpyE7o3Udy9tsljK1HcHJzxW7FlFQDNKnNTdxZV7cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012
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

This adds data and CCC transmission, reception, and the associated=0A=
queues required for data transmission and reception to happen.=0A=
=0A=
The I3C controller transmits data by the user writing into a command=0A=
queue. When the queue has a command and an argument in it, the=0A=
controller starts executing the command.=0A=
=0A=
The controller can execute 1 of 3 ways:=0A=
1. A larger data transfer that involves using the TX and RX queues. This=0A=
   is the most common way the controller does transactions.=0A=
=0A=
2. A small data transfer that involves sending a couple bytes passed=0A=
   into the command queue argument.=0A=
=0A=
3. An address assignment command. This is how the controller does=0A=
   ENTDAA. When ENTDAA succeeds in assigning an address to a target, it=0A=
   updates the controller's char table with the target's PID, BCR, and=0A=
   DCR.=0A=
=0A=
The controller determines what addresses to send by looking at the index=0A=
in the device address table specified by the argument in the command=0A=
queue. ENTDAA also uses these addresses to assign to targets on the bus.=0A=
=0A=
When the controller is done executing a command, it puts a response in=0A=
the response queue indicating how command execution went.=0A=
=0A=
In order for the user to send and receive data to/from the controller,=0A=
the user reads/writes to a bidirectional TX/RX port.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h |   1 +=0A=
 include/hw/i3c/dw-i3c.h     | 143 +++++-=0A=
 hw/i3c/dw-i3c.c             | 882 +++++++++++++++++++++++++++++++++++-=0A=
 hw/i3c/trace-events         |  10 +=0A=
 4 files changed, 1030 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index ade5c42d39..b8827d31d7 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -2,6 +2,7 @@=0A=
  * ASPEED I3C Controller=0A=
  *=0A=
  * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2023 Google, LLC=0A=
  *=0A=
  * This code is licensed under the GPL version 2 or later.  See=0A=
  * the COPYING file in the top-level directory.=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
index 7143e8ca7a..c50d67cc6b 100644=0A=
--- a/include/hw/i3c/dw-i3c.h=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -10,20 +10,159 @@=0A=
 #ifndef DW_I3C_H=0A=
 #define DW_I3C_H=0A=
 =0A=
+#include "qemu/fifo32.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
 #define TYPE_DW_I3C "dw.i3c"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)=0A=
 =0A=
-#define DW_I3C_NR_REGS (0x300 >> 2)=0A=
+/*=0A=
+ * Sufficiently large enough to handle configurations with large device ad=
dress=0A=
+ * tables.=0A=
+ */=0A=
+#define DW_I3C_NR_REGS (0x1000 >> 2)=0A=
+=0A=
+/* From datasheet. */=0A=
+#define DW_I3C_CMD_ATTR_TRANSFER_CMD 0=0A=
+#define DW_I3C_CMD_ATTR_TRANSFER_ARG 1=0A=
+#define DW_I3C_CMD_ATTR_SHORT_DATA_ARG 2=0A=
+#define DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD 3=0A=
+=0A=
+/* Enum values from datasheet. */=0A=
+typedef enum DWI3CRespQueueErr {=0A=
+    DW_I3C_RESP_QUEUE_ERR_NONE =3D 0,=0A=
+    DW_I3C_RESP_QUEUE_ERR_CRC =3D 1,=0A=
+    DW_I3C_RESP_QUEUE_ERR_PARITY =3D 2,=0A=
+    DW_I3C_RESP_QUEUE_ERR_FRAME =3D 3,=0A=
+    DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK =3D 4,=0A=
+    DW_I3C_RESP_QUEUE_ERR_DAA_NACK =3D 5,=0A=
+    DW_I3C_RESP_QUEUE_ERR_OVERFLOW =3D 6,=0A=
+    DW_I3C_RESP_QUEUE_ERR_ABORTED =3D 8,=0A=
+    DW_I3C_RESP_QUEUE_ERR_I2C_NACK =3D 9,=0A=
+} DWI3CRespQueueErr;=0A=
+=0A=
+typedef enum DWI3CTransferState {=0A=
+    DW_I3C_TRANSFER_STATE_IDLE =3D 0x00,=0A=
+    DW_I3C_TRANSFER_STATE_START =3D 0x01,=0A=
+    DW_I3C_TRANSFER_STATE_RESTART =3D 0x02,=0A=
+    DW_I3C_TRANSFER_STATE_STOP =3D 0x03,=0A=
+    DW_I3C_TRANSFER_STATE_START_HOLD =3D 0x04,=0A=
+    DW_I3C_TRANSFER_STATE_BROADCAST_W =3D 0x05,=0A=
+    DW_I3C_TRANSFER_STATE_BROADCAST_R =3D 0x06,=0A=
+    DW_I3C_TRANSFER_STATE_DAA =3D 0x07,=0A=
+    DW_I3C_TRANSFER_STATE_DAA_GEN =3D 0x08,=0A=
+    DW_I3C_TRANSFER_STATE_CCC_BYTE =3D 0x0b,=0A=
+    DW_I3C_TRANSFER_STATE_HDR_CMD =3D 0x0c,=0A=
+    DW_I3C_TRANSFER_STATE_WRITE =3D 0x0d,=0A=
+    DW_I3C_TRANSFER_STATE_READ =3D 0x0e,=0A=
+    DW_I3C_TRANSFER_STATE_IBI_READ =3D 0x0f,=0A=
+    DW_I3C_TRANSFER_STATE_IBI_DIS =3D 0x10,=0A=
+    DW_I3C_TRANSFER_STATE_HDR_DDR_CRC =3D 0x11,=0A=
+    DW_I3C_TRANSFER_STATE_CLK_STRETCH =3D 0x12,=0A=
+    DW_I3C_TRANSFER_STATE_HALT =3D 0x13,=0A=
+} DWI3CTransferState;=0A=
+=0A=
+typedef enum DWI3CTransferStatus {=0A=
+    DW_I3C_TRANSFER_STATUS_IDLE =3D 0x00,=0A=
+    DW_I3C_TRANSFER_STATUS_BROACAST_CCC =3D 0x01,=0A=
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_W =3D 0x02,=0A=
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_R =3D 0x03,=0A=
+    DW_I3C_TRANSFER_STATUS_ENTDAA =3D 0x04,=0A=
+    DW_I3C_TRANSFER_STATUS_SETDASA =3D 0x05,=0A=
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_W =3D 0x06,=0A=
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_R =3D 0x07,=0A=
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_W =3D 0x08,=0A=
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_R =3D 0x09,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_TS_W =3D 0x0a,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_TS_R =3D 0x0b,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_W =3D 0x0c,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_R =3D 0x0d,=0A=
+    DW_I3C_TRANSFER_STATUS_IBI =3D 0x0e,=0A=
+    DW_I3C_TRANSFER_STATUS_HALT =3D 0x0f,=0A=
+} DWI3CTransferStatus;=0A=
+=0A=
+/*=0A=
+ * Transfer commands and arguments are 32-bit wide values that the user pa=
sses=0A=
+ * into the command queue. We interpret each 32-bit word based on the cmd_=
attr=0A=
+ * field.=0A=
+ */=0A=
+typedef struct DWI3CTransferCmd {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t tid:4; /* Transaction ID */=0A=
+    uint16_t cmd:8;=0A=
+    uint8_t cp:1; /* Command present */=0A=
+    uint8_t dev_index:5;=0A=
+    uint8_t speed:3;=0A=
+    uint8_t resv0:1;=0A=
+    uint8_t dbp:1; /* Defining byte present */=0A=
+    uint8_t roc:1; /* Response on completion */=0A=
+    uint8_t sdap:1; /* Short data argument present */=0A=
+    uint8_t rnw:1; /* Read not write */=0A=
+    uint8_t resv1:1;=0A=
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */=0A=
+    uint8_t pec:1; /* Parity error check enabled */=0A=
+} DWI3CTransferCmd;=0A=
+=0A=
+typedef struct DWI3CTransferArg {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t resv:5;=0A=
+    uint8_t db; /* Defining byte */=0A=
+    uint16_t data_len;=0A=
+} DWI3CTransferArg;=0A=
+=0A=
+typedef struct DWI3CShortArg {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t byte_strb:3;=0A=
+    uint8_t resv:2;=0A=
+    uint8_t byte0;=0A=
+    uint8_t byte1;=0A=
+    uint8_t byte2;=0A=
+} DWI3CShortArg;=0A=
+=0A=
+typedef struct DWI3CAddrAssignCmd {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t tid:4; /* Transaction ID */=0A=
+    uint16_t cmd:8;=0A=
+    uint8_t resv0:1;=0A=
+    uint8_t dev_index:5;=0A=
+    uint16_t dev_count:5;=0A=
+    uint8_t roc:1; /* Response on completion */=0A=
+    uint8_t resv1:3;=0A=
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */=0A=
+    uint8_t resv2:1;=0A=
+} DWI3CAddrAssignCmd;=0A=
+=0A=
+typedef union DWI3CCmdQueueData {=0A=
+    uint32_t word;=0A=
+    DWI3CTransferCmd transfer_cmd;=0A=
+    DWI3CTransferArg transfer_arg;=0A=
+    DWI3CShortArg short_arg;=0A=
+    DWI3CAddrAssignCmd addr_assign_cmd;=0A=
+} DWI3CCmdQueueData;=0A=
 =0A=
 struct DWI3C {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     MemoryRegion mr;=0A=
     qemu_irq irq;=0A=
+    I3CBus *bus;=0A=
+=0A=
+    Fifo32 cmd_queue;=0A=
+    Fifo32 resp_queue;=0A=
+    Fifo32 tx_queue;=0A=
+    Fifo32 rx_queue;=0A=
 =0A=
-    uint8_t id;=0A=
+    struct {=0A=
+        uint8_t id;=0A=
+        uint8_t cmd_resp_queue_capacity_bytes;=0A=
+        uint16_t tx_rx_queue_capacity_bytes;=0A=
+        uint8_t num_addressable_devices;=0A=
+        uint16_t dev_addr_table_pointer;=0A=
+        uint16_t dev_addr_table_depth;=0A=
+        uint16_t dev_char_table_pointer;=0A=
+        uint16_t dev_char_table_depth;=0A=
+    } cfg;=0A=
     uint32_t regs[DW_I3C_NR_REGS];=0A=
 };=0A=
 =0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 0b99c7edfb..2453d74a8c 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -336,12 +336,179 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D =
{=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
+{=0A=
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
+}=0A=
+=0A=
+static inline bool dw_i3c_has_hdr_ddr(DWI3C *s)=0A=
+{=0A=
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_DDR);=0A=
+}=0A=
+=0A=
+static inline bool dw_i3c_can_transmit(DWI3C *s)=0A=
+{=0A=
+    /*=0A=
+     * We can only transmit if we're enabled and the resume bit is cleared=
.=0A=
+     * The resume bit is set on a transaction error, and software must cle=
ar it.=0A=
+     */=0A=
+    return ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_EN) &&=0A=
+           !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);=0A=
+}=0A=
+=0A=
+static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)=0A=
+{=0A=
+    return regval =3D regval ? (2 << regval) : 1;=0A=
+}=0A=
+=0A=
 static void dw_i3c_update_irq(DWI3C *s)=0A=
 {=0A=
     bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
     qemu_set_irq(s->irq, level);=0A=
 }=0A=
 =0A=
+static void dw_i3c_end_transfer(DWI3C *s, bool is_i2c)=0A=
+{=0A=
+    if (is_i2c) {=0A=
+        legacy_i2c_end_transfer(s->bus);=0A=
+    } else {=0A=
+        i3c_end_transfer(s->bus);=0A=
+    }=0A=
+}=0A=
+=0A=
+static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is=
_i2c)=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    if (is_i2c) {=0A=
+        ret =3D legacy_i2c_start_transfer(s->bus, addr, is_recv);=0A=
+    } else {=0A=
+        ret =3D i3c_start_transfer(s->bus, addr, is_recv);=0A=
+    }=0A=
+    if (ret) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed on TX with addr 0x%.2x\=
n",=0A=
+                      path, addr);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);=0A=
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);=0A=
+    }=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send=
,=0A=
+                       uint32_t *num_sent, bool is_i2c)=0A=
+{=0A=
+    int ret;=0A=
+    uint32_t i;=0A=
+=0A=
+    *num_sent =3D 0;=0A=
+    if (is_i2c) {=0A=
+        /* Legacy I2C must be byte-by-byte. */=0A=
+        for (i =3D 0; i < num_to_send; i++) {=0A=
+            ret =3D legacy_i2c_send(s->bus, data[i]);=0A=
+            if (ret) {=0A=
+                break;=0A=
+            }=0A=
+            (*num_sent)++;=0A=
+        }=0A=
+    } else {=0A=
+        ret =3D i3c_send(s->bus, data, num_to_send, num_sent);=0A=
+    }=0A=
+    if (ret) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed sending byte 0x%.2x\n",=
=0A=
+                      path, data[*num_sent]);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);=0A=
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_send(s->cfg.id, *num_sent);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int dw_i3c_send_byte(DWI3C *s, uint8_t byte, bool is_i2c)=0A=
+{=0A=
+    /*=0A=
+     * Ignored, the caller will know if we sent 0 or 1 bytes depending on =
if=0A=
+     * we were ACKed/NACKed.=0A=
+     */=0A=
+    uint32_t num_sent;=0A=
+    return dw_i3c_send(s, &byte, 1, &num_sent, is_i2c);=0A=
+}=0A=
+=0A=
+static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,=0A=
+                            uint16_t num_to_read, uint32_t *num_read)=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    if (is_i2c) {=0A=
+        for (uint16_t i =3D 0; i < num_to_read; i++) {=0A=
+            data[i] =3D legacy_i2c_recv(s->bus);=0A=
+        }=0A=
+        /* I2C devices can neither NACK a read, nor end transfers early. *=
/=0A=
+        *num_read =3D num_to_read;=0A=
+        trace_dw_i3c_recv_data(s->cfg.id, *num_read);=0A=
+        return 0;=0A=
+    }=0A=
+    /* I3C devices can NACK if the controller sends an unsupported CCC. */=
=0A=
+    ret =3D i3c_recv(s->bus, data, num_to_read, num_read);=0A=
+    if (ret) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed receiving byte\n",=0A=
+                      object_get_canonical_path(OBJECT(s)));=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);=0A=
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_recv_data(s->cfg.id, *num_read);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
+{=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    uint16_t dev_index =3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_PO=
INTER,=0A=
+                                          ADDR) / sizeof(uint32_t)) + offs=
et;=0A=
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,=0A=
+                   LEGACY_I2C_DEVICE);=0A=
+}=0A=
+=0A=
+static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t offset)=0A=
+{=0A=
+    if (offset > s->cfg.num_addressable_devices) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device addr table offset %d ou=
t of "=0A=
+                      "bounds\n", path, offset);=0A=
+        /* If we're out of bounds, return an address of 0. */=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    uint16_t dev_index =3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_PO=
INTER,=0A=
+                                          ADDR) / sizeof(uint32_t)) + offs=
et;=0A=
+    /* I2C devices use a static address. */=0A=
+    if (dw_i3c_target_is_i2c(s, offset)) {=0A=
+        return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,=0A=
+                          DEV_STATIC_ADDR);=0A=
+    }=0A=
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,=0A=
+                      DEV_DYNAMIC_ADDR);=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
 {=0A=
     /* Only return the status whose corresponding EN bits are set. */=0A=
@@ -376,6 +543,56 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val=
)=0A=
     dw_i3c_update_irq(s);=0A=
 }=0A=
 =0A=
+static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->rx_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read RX FIFO when emp=
ty\n",=0A=
+                      path);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->rx_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->rx_queue));=0A=
+=0A=
+    /* Threshold is 2^RX_BUF_THLD. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,=
=0A=
+                                         RX_BUF_THLD);=0A=
+    threshold =3D dw_i3c_fifo_threshold_from_reg(threshold);=0A=
+    if (fifo32_num_used(&s->rx_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_pop_rx(s->cfg.id, val);=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->resp_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read response FIFO wh=
en "=0A=
+                      "empty\n", path);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->resp_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         RESP_BUF_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->resp_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -392,16 +609,635 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr off=
set, unsigned size)=0A=
     case R_INTR_STATUS:=0A=
         value =3D dw_i3c_intr_status_r(s);=0A=
         break;=0A=
+    case R_RX_TX_DATA_PORT:=0A=
+        value =3D dw_i3c_pop_rx(s);=0A=
+        break;=0A=
+    case R_RESPONSE_QUEUE_PORT:=0A=
+        value =3D dw_i3c_resp_queue_port_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
     }=0A=
 =0A=
-    trace_dw_i3c_read(s->id, offset, value);=0A=
+    trace_dw_i3c_read(s->cfg.id, offset, value);=0A=
 =0A=
     return value;=0A=
 }=0A=
 =0A=
+static void dw_i3c_resp_queue_push(DWI3C *s, uint8_t err, uint8_t tid,=0A=
+                                   uint8_t ccc_type, uint16_t data_len)=0A=
+{=0A=
+    uint32_t val =3D 0;=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, ERR_STATUS, err);=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, TID, tid);=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, CCCT, ccc_type);=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, DL, data_len);=0A=
+    if (!fifo32_is_full(&s->resp_queue)) {=0A=
+        trace_dw_i3c_resp_queue_push(s->cfg.id, val);=0A=
+        fifo32_push(&s->resp_queue, val);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         RESP_BUF_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->resp_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_push_tx(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (fifo32_is_full(&s->tx_queue)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to TX FIFO when =
"=0A=
+                      "full\n", object_get_canonical_path(OBJECT(s)));=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_push_tx(s->cfg.id, val);=0A=
+    fifo32_push(&s->tx_queue, val);=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+=0A=
+    /* Threshold is 2^TX_BUF_THLD. */=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD=
_CTRL,=0A=
+                                               TX_BUF_THLD);=0A=
+    empty_threshold =3D=0A=
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);=0A=
+    if (fifo32_num_free(&s->tx_queue) < empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_pop_tx(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->tx_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to pop from TX FIFO when=
 "=0A=
+                      "empty\n", path);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->tx_queue);=0A=
+    trace_dw_i3c_pop_tx(s->cfg.id, val);=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+=0A=
+    /* Threshold is 2^TX_BUF_THLD. */=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD=
_CTRL,=0A=
+                                               TX_BUF_THLD);=0A=
+    empty_threshold =3D=0A=
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);=0A=
+    if (fifo32_num_free(&s->tx_queue) >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void dw_i3c_push_rx(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (fifo32_is_full(&s->rx_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to RX FIFO when =
"=0A=
+                      "full\n", path);=0A=
+        return;=0A=
+    }=0A=
+    trace_dw_i3c_push_rx(s->cfg.id, val);=0A=
+    fifo32_push(&s->rx_queue, val);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->rx_queue));=0A=
+    /* Threshold is 2^RX_BUF_THLD. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,=
=0A=
+                                         RX_BUF_THLD);=0A=
+    threshold =3D dw_i3c_fifo_threshold_from_reg(threshold);=0A=
+    if (fifo32_num_used(&s->rx_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                                  DWI3CShortArg arg)=0A=
+{=0A=
+    uint8_t err =3D DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+    uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index);=0A=
+    bool is_i2c =3D dw_i3c_target_is_i2c(s, cmd.dev_index);=0A=
+    uint8_t data[4]; /* Max we can send on a short transfer is 4 bytes. */=
=0A=
+    uint8_t len =3D 0;=0A=
+    uint32_t bytes_sent; /* Ignored on short transfers. */=0A=
+=0A=
+    /* Can't do reads on a short transfer. */=0A=
+    if (cmd.rnw) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Cannot do a read on a short "=
=0A=
+                      "transfer\n", path);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (dw_i3c_send_start(s, addr, /*is_recv=3D*/false, is_i2c)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+        goto transfer_done;=0A=
+    }=0A=
+=0A=
+    /* Are we sending a command? */=0A=
+    if (cmd.cp) {=0A=
+        data[len] =3D cmd.cmd;=0A=
+        len++;=0A=
+        /*=0A=
+         * byte0 is the defining byte for a command, and is only sent if a=
=0A=
+         * command is present and if the command has a defining byte prese=
nt.=0A=
+         * (byte_strb & 0x01) is always treated as set by the controller, =
and is=0A=
+         * ignored.=0A=
+         */=0A=
+        if (cmd.dbp) {=0A=
+            data[len] +=3D arg.byte0;=0A=
+            len++;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Send the bytes passed in the argument. */=0A=
+    if (arg.byte_strb & 0x02) {=0A=
+        data[len] =3D arg.byte1;=0A=
+        len++;=0A=
+    }=0A=
+    if (arg.byte_strb & 0x04) {=0A=
+        data[len] =3D arg.byte2;=0A=
+        len++;=0A=
+    }=0A=
+=0A=
+    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+    } else {=0A=
+        /* Only go to an idle state on a successful transfer. */=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    }=0A=
+=0A=
+transfer_done:=0A=
+    if (cmd.toc) {=0A=
+        dw_i3c_end_transfer(s, is_i2c);=0A=
+    }=0A=
+    if (cmd.roc) {=0A=
+        /*=0A=
+         * ccc_type is always 0 in controller mode, data_len is 0 in short=
=0A=
+         * transfers.=0A=
+         */=0A=
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=3D*/0,=0A=
+                                          /*data_len=3D*/0);=0A=
+    }=0A=
+}=0A=
+=0A=
+/* Returns number of bytes transmitted. */=0A=
+static uint16_t dw_i3c_tx(DWI3C *s, uint16_t num, bool is_i2c)=0A=
+{=0A=
+    uint16_t bytes_sent =3D 0;=0A=
+    union {=0A=
+        uint8_t b[sizeof(uint32_t)];=0A=
+        uint32_t val;=0A=
+    } val32;=0A=
+=0A=
+    while (bytes_sent < num) {=0A=
+        val32.val =3D dw_i3c_pop_tx(s);=0A=
+        for (uint8_t i =3D 0; i < sizeof(val32.val); i++) {=0A=
+            if (dw_i3c_send_byte(s, val32.b[i], is_i2c)) {=0A=
+                return bytes_sent;=0A=
+            }=0A=
+            bytes_sent++;=0A=
+=0A=
+            /* We're not sending the full 32-bits, break early. */=0A=
+            if (bytes_sent >=3D num) {=0A=
+                break;=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return bytes_sent;=0A=
+}=0A=
+=0A=
+/* Returns number of bytes received. */=0A=
+static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, bool is_i2c)=0A=
+{=0A=
+    /*=0A=
+     * Allocate a temporary buffer to read data from the target.=0A=
+     * Zero it and word-align it as well in case we're reading unaligned d=
ata.=0A=
+     */=0A=
+    g_autofree uint8_t *data =3D g_new0(uint8_t, num + (4 - (num & 0x03)))=
;=0A=
+    uint32_t *data32 =3D (uint32_t *)data;=0A=
+    /*=0A=
+     * 32-bits since the I3C API wants a 32-bit number, even though the=0A=
+     * controller can only do 16-bit transfers.=0A=
+     */=0A=
+    uint32_t num_read =3D 0;=0A=
+=0A=
+    /* Can NACK if the target receives an unsupported CCC. */=0A=
+    if (dw_i3c_recv_data(s, is_i2c, data, num, &num_read)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (uint16_t i =3D 0; i < num_read / 4; i++) {=0A=
+        dw_i3c_push_rx(s, *data32);=0A=
+        data32++;=0A=
+    }=0A=
+    /*=0A=
+     * If we're pushing data that isn't 32-bit aligned, push what's left.=
=0A=
+     * It's software's responsibility to know what bits are valid in the p=
artial=0A=
+     * data.=0A=
+     */=0A=
+    if (num_read & 0x03) {=0A=
+        dw_i3c_push_rx(s, *data32);=0A=
+    }=0A=
+=0A=
+    return num_read;=0A=
+}=0A=
+=0A=
+static int dw_i3c_transfer_ccc(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                               DWI3CTransferArg arg)=0A=
+{=0A=
+    /* CCC start is always a write. CCCs cannot be done on I2C devices. */=
=0A=
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                     /*is_i2c=3D*/false)) {=0A=
+        return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+    }=0A=
+    trace_dw_i3c_transfer_ccc(s->cfg.id, cmd.cmd);=0A=
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=3D*/false)) {=0A=
+        return DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+    }=0A=
+=0A=
+    /* On a direct CCC, we do a restart and then send the target's address=
. */=0A=
+    if (CCC_IS_DIRECT(cmd.cmd)) {=0A=
+        bool is_recv =3D cmd.rnw;=0A=
+        uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index);=0A=
+        if (dw_i3c_send_start(s, addr, is_recv, /*is_i2c=3D*/false)) {=0A=
+            return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+}=0A=
+=0A=
+static void dw_i3c_transfer(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                            DWI3CTransferArg arg)=0A=
+{=0A=
+    bool is_recv =3D cmd.rnw;=0A=
+    uint8_t err =3D DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+    uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index);=0A=
+    bool is_i2c =3D dw_i3c_target_is_i2c(s, cmd.dev_index);=0A=
+    uint16_t bytes_transferred =3D 0;=0A=
+=0A=
+    if (cmd.cp) {=0A=
+        /* We're sending a CCC. */=0A=
+        err =3D dw_i3c_transfer_ccc(s, cmd, arg);=0A=
+        if (err !=3D DW_I3C_RESP_QUEUE_ERR_NONE) {=0A=
+            goto transfer_done;=0A=
+        }=0A=
+    } else {=0A=
+        if (ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_BROADCAST_ADDR_INC)=
 &&=0A=
+            is_i2c =3D=3D false) {=0A=
+            if (dw_i3c_send_start(s, I3C_BROADCAST,=0A=
+                                             /*is_recv=3D*/false, is_i2c))=
 {=0A=
+                err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+                goto transfer_done;=0A=
+            }=0A=
+        }=0A=
+        /* Otherwise we're doing a private transfer. */=0A=
+        if (dw_i3c_send_start(s, addr, is_recv, is_i2c)) {=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+            goto transfer_done;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    if (is_recv) {=0A=
+        bytes_transferred =3D dw_i3c_rx(s, arg.data_len, is_i2c);=0A=
+    } else {=0A=
+        bytes_transferred =3D dw_i3c_tx(s, arg.data_len, is_i2c);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+=0A=
+transfer_done:=0A=
+    if (cmd.toc) {=0A=
+        dw_i3c_end_transfer(s, is_i2c);=0A=
+    }=0A=
+    if (cmd.roc) {=0A=
+        /*=0A=
+         * data_len is the number of bytes that still need to be TX'd, or =
the=0A=
+         * number of bytes RX'd.=0A=
+         */=0A=
+        uint16_t data_len =3D is_recv ? bytes_transferred : arg.data_len -=
=0A=
+                                                          bytes_transferre=
d;=0A=
+        /* CCCT is always 0 in controller mode. */=0A=
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=3D*/0,=0A=
+                                          data_len);=0A=
+    }=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_transfer_cmd(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                                DWI3CCmdQueueData arg)=0A=
+{=0A=
+    uint8_t arg_attr =3D FIELD_EX32(arg.word, COMMAND_QUEUE_PORT, CMD_ATTR=
);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CMD_TID, cmd.tid);=0A=
+=0A=
+    /* User is trying to do HDR transfers, see if we can do them. */=0A=
+    if (cmd.speed =3D=3D 0x06 && !dw_i3c_has_hdr_ddr(s)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR DDR is not supported\n", p=
ath);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        return;=0A=
+    }=0A=
+    if (cmd.speed =3D=3D 0x05 && !dw_i3c_has_hdr_ts(s)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR TS is not supported\n", pa=
th);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (arg_attr =3D=3D DW_I3C_CMD_ATTR_TRANSFER_ARG) {=0A=
+        dw_i3c_transfer(s, cmd, arg.transfer_arg);=0A=
+    } else if (arg_attr =3D=3D DW_I3C_CMD_ATTR_SHORT_DATA_ARG) {=0A=
+        dw_i3c_short_transfer(s, cmd, arg.short_arg);=0A=
+    } else {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown command queue cmd_attr=
 0x%x"=0A=
+                      "\n", path, arg_attr);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_update_char_table(DWI3C *s, uint8_t offset, uint64_t pi=
d,=0A=
+                                     uint8_t bcr, uint8_t dcr, uint8_t add=
r)=0A=
+{=0A=
+    if (offset > s->cfg.num_addressable_devices) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device char table offset %d ou=
t of "=0A=
+                      "bounds\n", path, offset);=0A=
+        /* If we're out of bounds, do nothing. */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Each device offset is 128 bits apart in the table, since each devic=
e gets=0A=
+     * 4 * 32-bits of entries in the table.=0A=
+     * / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
.=0A=
+     */=0A=
+    uint16_t dev_index =3D (ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINT=
ER,=0A=
+                                          P_DEV_CHAR_TABLE_START_ADDR) /=
=0A=
+                                          sizeof(uint32_t)) +=0A=
+                                          (offset * sizeof(uint32_t));=0A=
+    s->regs[dev_index] =3D pid & 0xffffffff;=0A=
+    pid >>=3D 32;=0A=
+    s->regs[dev_index + 1] =3D FIELD_DP32(s->regs[dev_index + 1],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC2,=
=0A=
+                                        MSB_PID, pid);=0A=
+    s->regs[dev_index + 2] =3D FIELD_DP32(s->regs[dev_index + 2],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, =
DCR,=0A=
+                                        dcr);=0A=
+    s->regs[dev_index + 2] =3D FIELD_DP32(s->regs[dev_index + 2],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, =
BCR,=0A=
+                                        bcr);=0A=
+    s->regs[dev_index + 3] =3D FIELD_DP32(s->regs[dev_index + 3],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC4,=
=0A=
+                                        DEV_DYNAMIC_ADDR, addr);=0A=
+=0A=
+    /* Increment PRESENT_DEV_CHAR_TABLE_INDEX. */=0A=
+    uint8_t idx =3D ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     PRESENT_DEV_CHAR_TABLE_INDEX);=0A=
+    /* Increment and rollover. */=0A=
+    idx++;=0A=
+    if (idx >=3D ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                               DEV_CHAR_TABLE_DEPTH) / 4) {=0A=
+        idx =3D 0;=0A=
+    }=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     PRESENT_DEV_CHAR_TABLE_INDEX, idx);=0A=
+}=0A=
+=0A=
+static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)=0A=
+{=0A=
+    uint8_t i =3D 0;=0A=
+    uint8_t err =3D DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+=0A=
+    /* Tell everyone to ENTDAA. If these error, no one is on the bus. */=
=0A=
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                     /*is_i2c=3D*/false)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+        goto transfer_done;=0A=
+    }=0A=
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=3D*/false)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+        goto transfer_done;=0A=
+    }=0A=
+=0A=
+    /* Go through each device in the table and assign it an address. */=0A=
+    for (i =3D 0; i < cmd.dev_count; i++) {=0A=
+        uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index + i);=0A=
+        union {=0A=
+            uint64_t pid:48;=0A=
+            uint8_t bcr;=0A=
+            uint8_t dcr;=0A=
+            uint32_t w[2];=0A=
+            uint8_t b[8];=0A=
+        } target_info;=0A=
+=0A=
+        /* If this fails, there was no one left to ENTDAA. */=0A=
+        if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                         /*is_i2c=3D*/false)) {=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * In ENTDAA, we read 8 bytes from the target, which will be the=
=0A=
+         * target's PID, BCR, and DCR. After that, we send it the dynamic=
=0A=
+         * address.=0A=
+         * Don't bother checking the number of bytes received, it must sen=
d 8=0A=
+         * bytes during ENTDAA.=0A=
+         */=0A=
+        uint32_t num_read;=0A=
+        if (dw_i3c_recv_data(s, /*is_i2c=3D*/false, target_info.b,=0A=
+                                        I3C_ENTDAA_SIZE, &num_read)) {=0A=
+            g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed ENTDAA CCC\n=
",=0A=
+                          path);=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_DAA_NACK;=0A=
+            goto transfer_done;=0A=
+        }=0A=
+        if (dw_i3c_send_byte(s, addr, /*is_i2c=3D*/false)) {=0A=
+            g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed addr 0x%.2x =
"=0A=
+                          "during ENTDAA\n", path, addr);=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_DAA_NACK;=0A=
+            break;=0A=
+        }=0A=
+        dw_i3c_update_char_table(s, cmd.dev_index + i,=0A=
+                                            target_info.pid, target_info.b=
cr,=0A=
+                                            target_info.dcr, addr);=0A=
+=0A=
+        /* Push the PID, BCR, and DCR to the RX queue. */=0A=
+        dw_i3c_push_rx(s, target_info.w[0]);=0A=
+        dw_i3c_push_rx(s, target_info.w[1]);=0A=
+    }=0A=
+=0A=
+transfer_done:=0A=
+    /* Do we send a STOP? */=0A=
+    if (cmd.toc) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+    }=0A=
+    /*=0A=
+     * For addr assign commands, the length field is the number of devices=
=0A=
+     * left to assign. CCCT is always 0 in controller mode.=0A=
+     */=0A=
+    if (cmd.roc) {=0A=
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=3D*/0,=0A=
+                                         cmd.dev_count - i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_cmd_queue_pop(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->cmd_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to dequeue command queue=
 "=0A=
+                      "when it was empty\n", path);=0A=
+        return 0;=0A=
+    }=0A=
+    uint32_t val =3D fifo32_pop(&s->cmd_queue);=0A=
+=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    uint8_t cmd_queue_empty_loc =3D ARRAY_FIELD_EX32(s->regs,=0A=
+                                                   QUEUE_STATUS_LEVEL,=0A=
+                                                   CMD_QUEUE_EMPTY_LOC);=
=0A=
+    cmd_queue_empty_loc++;=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=0A=
+                     cmd_queue_empty_loc);=0A=
+    if (cmd_queue_empty_loc >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s)=0A=
+{=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    if (!dw_i3c_can_transmit(s)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * We only start executing when a command is passed into the FIFO.=0A=
+     * We expect there to be a multiple of 2 items in the queue. The first=
 item=0A=
+     * should be an argument to a command, and the command should be the s=
econd=0A=
+     * item.=0A=
+     */=0A=
+    if (fifo32_num_used(&s->cmd_queue) & 1) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    while (!fifo32_is_empty(&s->cmd_queue)) {=0A=
+        DWI3CCmdQueueData arg;=0A=
+        arg.word =3D dw_i3c_cmd_queue_pop(s);=0A=
+        DWI3CCmdQueueData cmd;=0A=
+        cmd.word =3D dw_i3c_cmd_queue_pop(s);=0A=
+        trace_dw_i3c_cmd_queue_execute(s->cfg.id, cmd.word, arg.word);=0A=
+=0A=
+        uint8_t cmd_attr =3D FIELD_EX32(cmd.word, COMMAND_QUEUE_PORT, CMD_=
ATTR);=0A=
+        switch (cmd_attr) {=0A=
+        case DW_I3C_CMD_ATTR_TRANSFER_CMD:=0A=
+            dw_i3c_transfer_cmd(s, cmd.transfer_cmd, arg);=0A=
+            break;=0A=
+        case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:=0A=
+            /* Arg is discarded for addr assign commands. */=0A=
+            dw_i3c_addr_assign_cmd(s, cmd.addr_assign_cmd);=0A=
+            break;=0A=
+        case DW_I3C_CMD_ATTR_TRANSFER_ARG:=0A=
+        case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:=0A=
+            {=0A=
+                g_autofree char *path =3D object_get_canonical_path(OBJECT=
(s));=0A=
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received=
 "=0A=
+                              "argument packet when it expected a command =
"=0A=
+                              "packet\n", path);=0A=
+            }=0A=
+            break;=0A=
+        default:=0A=
+            /*=0A=
+             * The caller's check before queueing an item should prevent t=
his=0A=
+             * from happening.=0A=
+             */=0A=
+            g_assert_not_reached();=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_cmd_queue_push(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (fifo32_is_full(&s->cmd_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received packet =
when "=0A=
+                      "already full\n", path);=0A=
+        return;=0A=
+    }=0A=
+    trace_dw_i3c_cmd_queue_push(s->cfg.id, val);=0A=
+    fifo32_push(&s->cmd_queue, val);=0A=
+=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    uint8_t cmd_queue_empty_loc =3D ARRAY_FIELD_EX32(s->regs,=0A=
+                                                   QUEUE_STATUS_LEVEL,=0A=
+                                                   CMD_QUEUE_EMPTY_LOC);=
=0A=
+    if (cmd_queue_empty_loc) {=0A=
+        cmd_queue_empty_loc--;=0A=
+        ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=
=0A=
+                         cmd_queue_empty_loc);=0A=
+    }=0A=
+    if (cmd_queue_empty_loc < empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_cmd_queue_port_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    uint8_t cmd_attr =3D FIELD_EX32(val, COMMAND_QUEUE_PORT, CMD_ATTR);=0A=
+=0A=
+    switch (cmd_attr) {=0A=
+    /* If a command is received we can start executing it. */=0A=
+    case DW_I3C_CMD_ATTR_TRANSFER_CMD:=0A=
+    case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:=0A=
+        dw_i3c_cmd_queue_push(s, val);=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        break;=0A=
+    /* If we get an argument just push it. */=0A=
+    case DW_I3C_CMD_ATTR_TRANSFER_ARG:=0A=
+    case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:=0A=
+        dw_i3c_cmd_queue_push(s, val);=0A=
+        break;=0A=
+    default:=0A=
+        {=0A=
+            g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received pac=
ket "=0A=
+                          "with unknown cmd attr 0x%x\n", path, cmd_attr);=
=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,=0A=
                          unsigned size)=0A=
 {=0A=
@@ -409,7 +1245,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
     uint32_t addr =3D offset >> 2;=0A=
     uint32_t val32 =3D (uint32_t)value;=0A=
 =0A=
-    trace_dw_i3c_write(s->id, offset, value);=0A=
+    trace_dw_i3c_write(s->cfg.id, offset, value);=0A=
 =0A=
     val32 &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
@@ -433,6 +1269,10 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       __func__, offset, value);=0A=
         break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
+        dw_i3c_push_tx(s, val32);=0A=
+        break;=0A=
+    case R_COMMAND_QUEUE_PORT:=0A=
+        dw_i3c_cmd_queue_port_w(s, val32);=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
@@ -475,22 +1315,56 @@ static void dw_i3c_reset_enter(Object *obj, ResetTyp=
e type)=0A=
     DWI3C *s =3D DW_I3C(obj);=0A=
 =0A=
     memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+    /*=0A=
+     * The user config for these may differ from our resets array, set the=
m=0A=
+     * manually.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,=0A=
+                     s->cfg.dev_addr_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,=0A=
+                     s->cfg.dev_addr_table_depth);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     P_DEV_CHAR_TABLE_START_ADDR,=0A=
+                     s->cfg.dev_char_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH=
,=0A=
+                     s->cfg.dev_char_table_depth);=0A=
 }=0A=
 =0A=
 static void dw_i3c_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(dev);=0A=
-    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->id);=
=0A=
+    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->cfg.id=
);=0A=
 =0A=
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
 =0A=
     memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,=0A=
                           DW_I3C_NR_REGS << 2);=0A=
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
+=0A=
+    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);=0A=
+    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);=
=0A=
+    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+=0A=
+    s->bus =3D i3c_init_bus(DEVICE(s), name);=0A=
 }=0A=
 =0A=
 static const Property dw_i3c_properties[] =3D {=0A=
-    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),=0A=
+    DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),=0A=
+    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.cmd_resp_queue_capacity_bytes, 0x10),=0A=
+    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.tx_rx_queue_capacity_bytes, 0x40),=0A=
+    DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,=0A=
+                      cfg.num_addressable_devices, 8),=0A=
+    DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,=0A=
+                       cfg.dev_addr_table_pointer, 0x280),=0A=
+    DEFINE_PROP_UINT16("dev-addr-table-depth", DWI3C,=0A=
+                       cfg.dev_addr_table_depth, 0x08),=0A=
+    DEFINE_PROP_UINT16("dev-char-table-pointer", DWI3C,=0A=
+                       cfg.dev_char_table_pointer, 0x200),=0A=
+    DEFINE_PROP_UINT16("dev-char-table-depth", DWI3C,=0A=
+                       cfg.dev_char_table_depth, 0x20),=0A=
 };=0A=
 =0A=
 static void dw_i3c_class_init(ObjectClass *klass, const void *data)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 2d944387db..044ff06a01 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -7,6 +7,16 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C writ=
e: offset 0x%" PRIx64=0A=
 # dw-i3c,c=0A=
 dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u=
] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PR=
Id32 " bytes to bus"=0A=
+dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
+dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
+dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
+dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
+dw_i3c_pop_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from TX FIFO"=0A=
+dw_i3c_push_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to RX FIFO"=0A=
+dw_i3c_transfer_ccc(uint32_t deviceid, uint8_t ccc) "I3C Dev[%u] transfer =
CCC 0x%" PRIx8=0A=
+dw_i3c_cmd_queue_execute(uint32_t deviceid, uint32_t cmd, uint32_t arg) "I=
3C Dev[%u] execute command 0x%" PRIx32 " arg 0x%" PRIx32=0A=
+dw_i3c_cmd_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push =
0x%" PRIx32 " to cmd queue"=0A=
 =0A=
 # core.c=0A=
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
-- =0A=
2.43.0=0A=

