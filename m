Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B48E6F07F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzp-0001T4-Hk; Tue, 23 Dec 2025 04:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzn-0001Rn-AP; Tue, 23 Dec 2025 04:47:59 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzl-000255-2E; Tue, 23 Dec 2025 04:47:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqlnNOC1Wl70piBNvBEaDzFpRmobSmEuCV4wU5ewcB0R/igtqoh38LOpsYEGAJ/7z6R5dlE2rgdlxiknh8XcgyReUcdPfxmnQiNeKJ0MgTF7Xg8uIR3mQrvQFX2Ipnnn9B16lIhHANduyT9IUXl9PUFchtwfYvZCQFaIvTvYI2xAjTg+vOazgGc/0BJmZRj4M1u9YjyWIUpRZTJqMOIgZDEAFhdXJwTdoKYULkMCBJgaywGNIkLflWOxVdHBJDH1mhyMfKyEVWgxWItYQcJBWhiDCj8pbglec/6CMXsmrO8yNOlVtF3LBS9GbSKAUkNctRPenfglNwHULDClG+998A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHTnjJ9Zo/ISkcTGdTbverksGAURwQBDdP7P77tlJok=;
 b=AJSKHljhqJpm3v79SoxMomebuS15K9lJyS4zEui8i6sp3EafTeFiZYIoSWCLLVTnAbzdaUbTwxPV1aXXWBAYRc/CdOwFYoiMuNPjgQ3IBu5ZWsNE4MUQaeoNIYUAYxfy1ZVXqTNl5z3W8Zge3FlpfgbHd4u1FqS2Mnbwk7rcGUpKFqJ57sqUxluQ6I7uLxP2pRVu0i0Xp0QyX738DXYg5mJ85L/3BiBJVMsQB9YdOULX9k2BVSNbXVOtTfR0h30tMWLUnCm4//1k+RVGUEQfgbDbkdadfgzTjQp57lS69jU6zPDSNb7EjEiZ6hYXUbt/OJiL4WMI5NH1Fc6pNyuuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHTnjJ9Zo/ISkcTGdTbverksGAURwQBDdP7P77tlJok=;
 b=j5ni61bgcOfDdtt6HJTLzVgRYN5JhBVGKyGd5hVNvuyUz6CWK11Rywc1zpB38VHySksDZP/jLGzNLGUZBXrCFjnG+XjEMGfWdnJXUs1XrvyTdDPGJKhIMjF8tIJETb1TL9Yz0z7KgYgiI3WeRWnwCdVcfbPT4+JXBd1IkhwBaDR3tnhVEKakilMV+9/FNbi+oI9rXaHzf3iy/qN9U78C8fV4Prpe5RMA8EgmNfsRyp/1qtY5u0O1fr2m6bKGNv3c/S1W189mtnVcoa+SPnqpylBtvxwVQh96/t8IEvZmXA4sXt+3vpm4DYwHvHQMhnSDwL7GuoAPBZZwFApIdo5nqQ==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM0PR09MB4435.eurprd09.prod.outlook.com (2603:10a6:20b:168::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 09:47:52 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:52 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v15 00/12] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v15 00/12] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcc/E0juaYnBuBQ0qaYLeQ8yu0cA==
Date: Tue, 23 Dec 2025 09:47:52 +0000
Message-ID: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM0PR09MB4435:EE_
x-ms-office365-filtering-correlation-id: ab969771-d48b-464d-435e-08de4208570e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?w+SMCe+UplrMapOg+Yz5Z5Ts0Cv1LIlExPRu35PxKRwVg5y7vdFqGqRb94?=
 =?iso-8859-1?Q?MUIl6X6RTy7Jmi2ffFk/GcmIJS2KD36Cu9ACcl+BH87mWkjl4s/3JhFTml?=
 =?iso-8859-1?Q?WRg4XbtvSJW527nIq13iZqePczt8tmTo6SumM8CRLcGNK/5PwyNmzSsHPN?=
 =?iso-8859-1?Q?ttEt33zQ6dRtzSsNWpo8GZSLu5J16TEUw7r2ctW10/X8qzVJ1t61iXGFAt?=
 =?iso-8859-1?Q?sEJ0VFnOaTAkRKs9La+Xm9dwNKvIJlINADyYCIhwT5IGRet38QT68cZ3iJ?=
 =?iso-8859-1?Q?x4M7Az+34dsSFur3X6a3SQIRnLyKiIwyZB3UyoUOF95wK4eztFd5cNeSzS?=
 =?iso-8859-1?Q?iBASknKFeyHRDi6Y96+AYsfrNXC9s8OELyeIUPB236LYE7VGODEW+LJb4K?=
 =?iso-8859-1?Q?US1f708lcb18xLVR/3mfE2dBessBSLQf8MWsZiX1hjsSSd1XWXnu9dK+03?=
 =?iso-8859-1?Q?Em/4Ih3PZid6Zk56lSQm1xS69cxnfuCe0FCymki58z5lLe9UQxrDiDIDdx?=
 =?iso-8859-1?Q?Sr2uJbHgZO24yIcbddHxabOjByyVP3LseFxEJCoW1SVS26nrdWMYiDWX3a?=
 =?iso-8859-1?Q?TolD3AN6eXcCzB3+S+M8IA/TWbnDKZMDmfZxVpQEqWRXKkLXCClEoR4rZr?=
 =?iso-8859-1?Q?Ae0NFWRq0DQ6bBA90ULmTOO1Mwto8yI2ianpVSlnKkeOseZ9Ym2qrdQEpl?=
 =?iso-8859-1?Q?s8jjy04rkkZJiM0lnmMeiYOorSnMYnrml21AIMQxDntOm+t+OOJGKNVxGe?=
 =?iso-8859-1?Q?6ReTHYzCVUPnzxLzR+u9vyVAdQB4HQy20bWH5Ff31GWZuBbFx3mjtpx8jR?=
 =?iso-8859-1?Q?97CpZrtfGb29K9b6z8GThyFlhcmat7lOOBiKE6f1dKdAKB/413snmHJ53a?=
 =?iso-8859-1?Q?8Ad2fhV1OvM09ToZmJBpcqivHNp+b+koPB0bn0RkvyD9brJ3cS6xowZzgR?=
 =?iso-8859-1?Q?6fatt+IyFtN1QwdN0TAY3KnxwpSxolPSP1g58JCJAaX4HdKiwiUH9dhgq+?=
 =?iso-8859-1?Q?pTm1Zorx4MKbQpkCJmXoL2o2H4PSutWxyMvNZhxaQpbNTCiud0WRwPmjn5?=
 =?iso-8859-1?Q?lsKyng6piTeWoEA4Fag7jrgRY8q9pYg4RD8/qR00QG+A2XlId6JCm0GpcM?=
 =?iso-8859-1?Q?X3BJONEGkfjSw9aS+gtEWqbDBlc724UpFn/ti1QPDnWpVhjFmGr5oKMLbU?=
 =?iso-8859-1?Q?foygCHUqSWfghno/ZDujz8AaXuIy5MM2cO9lbwOkEp64JBKiSliBnLUFrJ?=
 =?iso-8859-1?Q?OZydu/AHRkIDkIoEbxe3BKqbYpef7dA7oF8V8Lol57HqvA344MGO+sCgxt?=
 =?iso-8859-1?Q?WLqM4e6E1g4/dh6QwcG69YEvqrZx8idhmBDKbqer9Ssg5FML6BVafUjOUy?=
 =?iso-8859-1?Q?11eeHAmpdlyx9+DSlauUMqW1qYKxUFMMHYTFk0UM0zXp43sBClSFzJxNNu?=
 =?iso-8859-1?Q?7CF28xGFXlzKTEugPkclyRGCGDyYlcGEY6/rSa6MQsMByMh/vqvPEtboWi?=
 =?iso-8859-1?Q?crupLl8HYCQSxePHGTZAMA4E8rkrfDINPckNvBPmcnqrHEqtItPlqizVD3?=
 =?iso-8859-1?Q?g2Htfyv+3nOVww0d+4eK7HHSlbYM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HT9f5SABs+HlU7t+12hR/BY4CY7rQ0VmVUjlcca5fjX23/MFKxh6WkV4dY?=
 =?iso-8859-1?Q?a96XmZ+twHcvvLdDLnc9zCp4+3EWQsHla/25ll5PdrUVV/wW6A58O5aGNx?=
 =?iso-8859-1?Q?PEMb5IU9E8hNuRhtQUJoXg4sRy/4Z2YyTKOf8+LNzvGboKcL0cTMDCF4HB?=
 =?iso-8859-1?Q?KAMKR0/5NnN392qQXZyILrH+rBeXQ3urygAt45tIS/waNCg2u14sErUvn9?=
 =?iso-8859-1?Q?y35Ts4hkwF38kqOsVpgOWTVMZ7tR+zMhSYf7n8PhHY3p7YJGjPujerKNrA?=
 =?iso-8859-1?Q?NPJmm4hM3IgrOhhh+BVrE7nx2GXLF+CPXv41DBs+1ADg6tw8vYn9GhgFjE?=
 =?iso-8859-1?Q?SQbOsR7pdn8FIyUf6Uug/v81BEGzlWHNU/KjptiJP0aX88hT2VGvvlLu/y?=
 =?iso-8859-1?Q?NcqoClRqF1bYkL7Sd7V9FsEez7b63F84L/VIQqBiWGE22PnMnuOMM68pgX?=
 =?iso-8859-1?Q?zo+P4A1So+3k4Rx5uZL3d+f4uDtQhsqJAPmxnXbKkr18SKXeQrhnkBVDE4?=
 =?iso-8859-1?Q?DhGAADHh51djLsE/tmAnIvb6qMIhnGvBkEoz56dk/p/LkRiSvPu7xX/Ryf?=
 =?iso-8859-1?Q?KGSz9OkbjeE4+aFXTvkbXPdwOd2C+ckhJI9hpzUUv8P3SolbVQhKj37OXB?=
 =?iso-8859-1?Q?QERxa94d+bZk8TLNAodq7lX7WYGMMmkq7o1fiCTbrkQQYpOudN0XxNhr14?=
 =?iso-8859-1?Q?/gVbryJWIswAwgXS2NJVc4dxUWTK2D7vS4PN1ldEb/unOXNsgDBxg95XXa?=
 =?iso-8859-1?Q?i27ftmoWLVdBC+85arz531IV64SFqeBJRf4H0PPCxOUpNw93gobrkh7QoR?=
 =?iso-8859-1?Q?ueHJ8x4f7UCCYQkcLXH9T1VNRsaNtuEePwX49st/xqIDyIhSm4Wskenrjp?=
 =?iso-8859-1?Q?Sx+A8hJFCxEaxyQ4LQY9z/XVd06CLPNGbPyZMeYrwQFBlQbgERnqsIlawr?=
 =?iso-8859-1?Q?0CoV0KPYgp9N+Ou3ZqIzXkrXHanPF5g62fUXqbDhckKpKi1gX3jAq7ilE1?=
 =?iso-8859-1?Q?RtaX/Vsrm4oHInSwrrE6zkOaU9crKWYkn1q/jd6rxXnIKsASezN+89pcb8?=
 =?iso-8859-1?Q?CaMaIyqhybu4uekzlgCjeoGaLttOqTw2C11uB2Q3eOGyEPd+jC3o5Qx4ja?=
 =?iso-8859-1?Q?naqnQEfkS3rNn3tXeznyE5hQYye1PNRztkC1wjSEwTPzsbYd6QLcw6q6CP?=
 =?iso-8859-1?Q?VTHdJs+PklbGcpngAuTUpKbpddWpDfnfA4otHkGBF8kyWNCD2vQiUBefYX?=
 =?iso-8859-1?Q?EKRyA2YoYrpfFaJULKWKGbTd5cbS7VD93Wrjp7g2c9znZ7ynJ696VLf8ln?=
 =?iso-8859-1?Q?8E5nbzsXgNEVSHFYPIPj67aok4HonwA3d8ogtR/lkHju9T0++AK+OPH2/T?=
 =?iso-8859-1?Q?ANXQzImGTyyVDYrUmNxI+sFPUQObZFTB70Q53SckYl5XQWpAwXVaolZv2h?=
 =?iso-8859-1?Q?VKbdXkXtBcZXD3SETCLKCmTGN09dqQpj6c00q9vIXu0KWOGet1HXlhvNwv?=
 =?iso-8859-1?Q?Vhw2dLApjCr+zuXOZ0QYNT6W/E3J2YBLzwMx9ZBOizS6fEpcLxAwJ7p3e9?=
 =?iso-8859-1?Q?21WX9ywVFm37oe0QEkaf5gqAo/gEwnlhjaazjO9j5zI4yGWBAcgG3sAj92?=
 =?iso-8859-1?Q?wSw7KH1QTa2hx9SNh75tv1OOyPho80jHxu7wqY1xh/J4H2FaNoLaG09zuB?=
 =?iso-8859-1?Q?kPziGSf2nR9uPT+PGYabfDlzGvM42ivunUFjFW37w4B/Bxeadz83CwXonb?=
 =?iso-8859-1?Q?kMVnY5wjqTUuCfH33220O9n+F5UYBSdP6VLsn64K/pCfwZBX/fGSrVtAKX?=
 =?iso-8859-1?Q?Jx3qNTnDygpHyVWH8wNRDbNryFoiJhfixmdMxuwBYoTVlbMx3otw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab969771-d48b-464d-435e-08de4208570e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:52.0702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdQ63RMP27g1vi75SGIK+jvGpMw5AA9PfcIQcki6AUWVBTFCD6S9jKoxI+xyoIMcUyDljwURdzCnDHtI7Rb3T9YfS4FARsisED7wwBS2pnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4435
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

Rebased on top of master branch and removed patches that are merged.

Djordje Todorovic (12):
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 hw/misc/Kconfig                             |  17 +
 hw/misc/meson.build                         |   3 +
 hw/misc/riscv_cmgcr.c                       | 243 ++++++++++
 hw/misc/riscv_cpc.c                         | 265 +++++++++++
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 476 ++++++++++++++++++++
 hw/riscv/cps.c                              | 196 ++++++++
 hw/riscv/meson.build                        |   3 +
 include/hw/misc/riscv_cmgcr.h               |  48 ++
 include/hw/misc/riscv_cpc.h                 |  64 +++
 include/hw/riscv/cps.h                      |  66 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  44 ++
 target/riscv/cpu.h                          |   7 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/cpu_vendorid.h                 |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 136 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 217 +++++++++
 target/riscv/translate.c                    |   3 +
 target/riscv/xmips.decode                   |  35 ++
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_boston.py     | 123 +++++
 27 files changed, 1988 insertions(+)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/riscv64/test_boston.py

--=20
2.34.1

