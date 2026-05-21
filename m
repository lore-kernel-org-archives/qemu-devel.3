Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7AFCD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPxGn-0003H5-Bu; Thu, 21 May 2026 02:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGS-0003GZ-Qt; Thu, 21 May 2026 02:52:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxGO-00083B-3g; Thu, 21 May 2026 02:52:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmxnYIjRJ6KOSt8CeWIO210Kgp0b7Hm/UBl/54TRc5OUk81RY7yrZ0cL3HFYAMGh6YqqwVzWSiP3alyw4bpXXWYkBH2ctNQ/tTcMsCIBb6SprWdVuido5bEcKjH4DpzR9qWceKllK0JmfQnAU7GML309gr4Al7wyehDhIVroBBK5JJwtSiQs0b+PoSTpffDnCKvMohOFsErP3tbuIzgr1rqI1tVO2bOykQS+9AkZjLWjNalIiasnRJP1FrCgXiXjvUVq8d9GuAtKMNHVxOjwXqtulxK1HYGCv4cyNQUo5i2HzoEN/WIxP2PN/W2W6uZjWQY3iee5yFJ8WG6KIQ+0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL7chJkkNCxqr/mBJAieVlzjpGEnuFwqrZC9NnkkdWw=;
 b=jc1Y6MnMNy03BWWh3nWkEjbRMKp5lMbY1/bn0+omqYbLvWfy0p54ZOSCJbg4ie4tL+aVmMUIZsyhYGkFwW4naEqFH56e6isTESBMLs0FvZJKaTDBMmMUtx4D1uBsri+jFh/1WfO6/QIhyIEpv6JsfEQZVOdRUIw459mNITcEfUK7a1tZGUEtP0uyIlH9a/+Cy9/PyPOXnIIvELgHpIEYEUEWEWAelo4KNIewhig93D5OafMEqU8uZ/uYigJcP3WX79g+NzO+Z4bZjuXE9r7EgzKHUd2F0qIG6at2dX2uUANd/kpirudxST41rmZSCH24wbAk7W1NNAf5VQhdSyMMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL7chJkkNCxqr/mBJAieVlzjpGEnuFwqrZC9NnkkdWw=;
 b=nZLLgDEcuESRDNwSd2gOO4n/GZB9mTOKflcb4LpYpDKct9J9qd4fPQbeQXx06ChuuEu5swnZvKcA3oHD1gd0HxQaiOKilc+D/PV1f7TX2DjOKWwxGFaOkGR5YNYvz3MNFTghDlkeIv8BmleMiFDEWa1+VDYg5WjrhtL/Tk3d1DztHr6RYcE4gYa47GFWcnE9Jrpq7maK/Mn5aGVYhxJ/lelHwaVnjdnkKi2BTVnseXUZPyYGb/IWkfLfhwal5Xf3GsK9bOJH0EEhLWHqcaR+jssndWPnlRJaNXER1u9KDgGlY+3+4IxhddBgJ2WUIw7ScQ+Tfx6RjWJCdLImZ6ZBpQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:52:04 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:52:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/4] hw/arm: Introduce initial AST1040 support
Thread-Topic: [PATCH v1 0/4] hw/arm: Introduce initial AST1040 support
Thread-Index: AQHc6O5VlWnJvwjVQUCyhiUw9T43wQ==
Date: Thu, 21 May 2026 06:52:04 +0000
Message-ID: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6044:EE_
x-ms-office365-filtering-correlation-id: ce638937-168c-4789-4e40-08deb705779b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021; 
x-microsoft-antispam-message-info: elDWUqVqYejpKAN29Os+i9KValQ79fwIMAUaxUUFT/ybV5HAEFygmW4agAQfDDOr/lYqS7gvIgkY28eH4CxBUSW3KeZDusYkwn4k93MoMdED5+zsrbAy+9eHp/GNXeg7RladwUSATlCjUn1bSs5C2s1QWdyDZ8Vw7Jb6myR/M3xokqMtE4YuieeyZGD/anWN5m5vutwLp9dsCjfisPTad/L9CZzhwoIJfTOebJijW9d/fArwZiJqL5ct9E9lBQofkaNKl+cdnjJcpztX0KSmhV8hKhL7IdCXpzYjhJAKvPau5ubvaxyTibR/g6BqeVhdREzAnnc8Ncy69Zq4WAx8SrH0idsd/zglehAogcuBXv0vDaguDKHU8VzpQKZTvZfybuJA1xL6GHcC1VjGsE/nfYV+qnpMcv/NUs1H3RWyjSWBMWYEZ/394t2MmvNgXhhzCj1xan4W3KDLz+FYiBWVH6p+yBKokD9UeDQYyeFrgA5ZA2E99IAxHdGQSqnqVpOWVJanjylm8XnOOIVu1kG1w5oNDUr71QVZrylWzT/VqUa7gK5bbpugVfULrMzfE1QX9ULo32duN+cJN+BYrZ7GcxC4eSZNKJYETDzxvG25mX8K+UJkVgV/GbWnHSeMEyv/0ts6fIw+X4IxcgjVhX0A4b0Mb4LkzQIZgjleeAPsEHnfbKwdxWUr/Xghw4U1IPdZXLvDdm5Ws5yJ890zCuKF+zHpKaj9d0Z7Oc1nLMnA1kOcUUhvRsBoDEZU2YRKxw7c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bvzLoDcP8WZXEFdjlc8n0LLLR3iJh3pBYWzopvk12Shh/R8qQdFxg4ELiv?=
 =?iso-8859-1?Q?CIYHy5u4IcpwLUIsKnnnS/poXdE3k3a5RilTJHycJG+K/U5tiytIMhi5UL?=
 =?iso-8859-1?Q?lCInxHChY+KGvGZTosjOwVL6fC43O/M1Qmvaxc0DG/11L1gGp7O+OKUxRD?=
 =?iso-8859-1?Q?xfQwXlSiC9CiSLArpgZjTsEu0APjWLz4aQzv4wZRpIehpKJxoflVk98Mfr?=
 =?iso-8859-1?Q?uTo7Jct3KmG3/YFn+nM9/h60okGOLeXE8bMgktoKTsRHQ3BbhdqLyc0W/y?=
 =?iso-8859-1?Q?3WDfRChiNPfNtbNU2PwPrBpM+8RPPeuJNh/XUafbzluVKpeuh3CVkPvdzf?=
 =?iso-8859-1?Q?uezT+V9zn8BYlLvFq63ZPNBn8U1v/HDbj65ZjJB8jJ4PSRwTQm/5nN4/I6?=
 =?iso-8859-1?Q?VV5l7ZVlBgqh5akAPWAMYkXg7eg3eXiqrrwy1M3DCHImPyTq5aDAkrQWut?=
 =?iso-8859-1?Q?JslijFtfW/4Nyut/c0KrzqoeQklQWAR+mNwYkItb6Xy3E46+vcaPFldFAy?=
 =?iso-8859-1?Q?ZnyCzaOZMrLriNiZvkMdnCQBXxM5Gf8D8u/+3PDRaeugVAlU0dKZPvqyuF?=
 =?iso-8859-1?Q?yeUafW8WcOOvIbYohlxjB0e10vH8qiOLgNZf0zPEKX6Bn1zMX4opoNjaXi?=
 =?iso-8859-1?Q?jwkO77tgzjWnHy2l/qYP6OSmjBPy8mEPGG4k8DsltcEWwAJ8682tKccW4v?=
 =?iso-8859-1?Q?LvdkyuSc2bThMoof2wfwk40edW6konaKtotPiATISBihC2rNlt3GxBW5oH?=
 =?iso-8859-1?Q?xPTULE1CgkprqomDb4xZ30gaf7gj96tgcpLnVjFiM5I9zrjXpZpluCQmKo?=
 =?iso-8859-1?Q?4eJgcDTP7rLZXBbU7OAPYc1qqpYlj5qLI4mXGM/pgC7yJU4rIejbmzBOwI?=
 =?iso-8859-1?Q?KGsyrkflkeb2ghm28NrlvI+xhFrxQz8pUttIZAooBHxPB649kygOd7EZZ+?=
 =?iso-8859-1?Q?L9gsskh21B8AEuJz54y7UXhyBR+yzw/1ce6jnoXaqpgoocOSRsruvW56TQ?=
 =?iso-8859-1?Q?G1HEbDkT7ixMS3TFGqJZYHY/7DQGvc4gZaPc33AEtVqv1f8/MlmNPGx/iv?=
 =?iso-8859-1?Q?ikBuz++dv4SWSMK7R2wATw1gLDrjOiPm0jWUqZAN3Lac+oxgaZKv0vAr2G?=
 =?iso-8859-1?Q?m8OVEKpWF80a0ApsbRkJCLphjfrrUOs105/YS28KpDQ9PL4ljMLn+N/roX?=
 =?iso-8859-1?Q?oWjNzj20Ep/8YCYKRGlipys4qVtxwJg1ws3bq0Xv5TuEdvm2wmS/TIj+y5?=
 =?iso-8859-1?Q?MfNnlykZblBgh9ic3Nd/6lr3kUuX2+gJltR6RmtfLP23DMOmUcwyacTxNB?=
 =?iso-8859-1?Q?QMdqukghKwJakuPbQKorWJZ/mV8AfeamJzc/Lol++tfrW+wKhfzj1h8KC+?=
 =?iso-8859-1?Q?xE0xNZ1uUBs18RJ4wHLKUhHKi5IeXOMbvwLdQ442i9aRQ6NniYHzu27n1u?=
 =?iso-8859-1?Q?CdwvF5XC+oiZWhUxil82TTHAJgV+3HCNAIrGJFKzLrw9+USAWpu0YX9z/W?=
 =?iso-8859-1?Q?YUtMX2VmmwnQ8eHp/EpFcnqkLOn3SbdUQbqwTh9jOp0sV7Q6MXCJ04oqeT?=
 =?iso-8859-1?Q?egb+MOp+OEDvaDrS7jkaDS67K75oLbbA89qKXhwvYrnnH1gVYTZn6ck16T?=
 =?iso-8859-1?Q?GPdfZ2HzCuEMTURzp83a3JfiTqxpr5Rhb5BIoMm7cilM2OQ0oxbTtn0YxF?=
 =?iso-8859-1?Q?xBcGxxDpD0uXNYmEDflT9pRSgXHI54n9amar+dwMxZNLoTL53kdKjI3Ygl?=
 =?iso-8859-1?Q?Sp8FPColaleIsXYZ4AwOuQkigX4N+fksU22Rd5iSpByWSNKv+ymS8CLpxL?=
 =?iso-8859-1?Q?kEjV0nRKAg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GF1pycCNjN8u0jvL4qxLGvnd61kAqBv/S/QhiissCS4FnbIf32NgxpYmXdYiXeECzmA5OoXCbxwukEp+bTv18v6ggvudTdlRUrGzsWgPR0f7DDBfgE4AiWIaYPiV8SDPN5nWkC/6xgsGM0FTCrnuwRmOGWFNh8MB2OLLl/jO0fdNPfLFjnB1dRNXV6AdaovrM6g+pnJSiKcMMRNxiN/l/trkSiKD19C0rqQH49doVujQqkx/En+Lwx5GBLNbfmjRS/GHCwCx9i28GDsiQHhYc35tuul4fMPHx9+Rkd0HbD2PFIZXfNZYgufTpmCGw57aOI4LAVPkpOep14CmNJStdw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce638937-168c-4789-4e40-08deb705779b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 06:52:04.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3ppNH+bwSnIlLP/Tx4Rgrrnfj7vBSI2emqUB6SBHaeRyt2JgsPWUeoBT/AGUyboE8HgwVd6VdFr+WL8VbtmBA4jqqclbIrTEOp0FxNEieU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

This series introduces the initial ASPEED AST1040 support for QEMU.=0A=
=0A=
AST1040 is the next-generation bridge/BIC controller platform=0A=
following AST1030 and is based on an ARM Cortex-M4F CPU core.=0A=
Since QEMU currently does not provide Cortex-M4F support, the=0A=
existing Cortex-M4 CPU model is used temporarily.=0A=
=0A=
The current implementation provides enough functionality to boot=0A=
basic firmware environments with UART console support, SDRAM/SRAM=0A=
mapping, and NVIC interrupt handling.=0A=
=0A=
At the moment, AST1040 firmware has not been publicly released=0A=
yet, so this series is mainly intended to provide an evaluation=0A=
platform for users interested in AST1040 development.=0A=
=0A=
Documentation updates and functional test coverage will be added=0A=
after the firmware release becomes available.=0A=
=0A=
Currently this series is able to boot Zephyr successfully to the=0A=
shell prompt:=0A=
=0A=
  uart:~$=0A=
=0A=
Example command line:=0A=
=0A=
  ./build/qemu-system-arm \=0A=
      -machine ast1040-evb \=0A=
      -kernel <zephyr.elf> \=0A=
      -serial mon:stdio \=0A=
      -snapshot \=0A=
      -nographic=0A=
=0A=
v1:=0A=
  - AST1040 silicon revision ID=0A=
  - SDRAM support in the Aspeed SoC framework=0A=
  - Initial AST1040 SoC model=0A=
  - AST1040 EVB machine model=0A=
  =0A=
Jamin Lin (4):=0A=
  hw/misc/aspeed_scu: Add AST1040 A0 silicon revision ID=0A=
  hw/arm/aspeed: Introduce SDRAM memory region support=0A=
  hw/arm/aspeed: Introduce AST1040 A0 SoC model=0A=
  hw/arm/aspeed: Add AST1040 EVB machine model=0A=
=0A=
 include/hw/arm/aspeed_soc.h  |   2 +=0A=
 include/hw/misc/aspeed_scu.h |   1 +=0A=
 hw/arm/aspeed_ast1040.c      | 246 +++++++++++++++++++++++++++++++++++=0A=
 hw/arm/aspeed_ast1040_evb.c  |  72 ++++++++++=0A=
 hw/misc/aspeed_scu.c         |   1 +=0A=
 hw/arm/meson.build           |   4 +-=0A=
 6 files changed, 325 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/arm/aspeed_ast1040.c=0A=
 create mode 100644 hw/arm/aspeed_ast1040_evb.c=0A=
=0A=
-- =0A=
2.43.0=0A=

