Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B81C7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuM-0006ES-GA; Sat, 28 Jun 2025 14:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuK-0006Dd-L9
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:08 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuI-0004AW-W6
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133846; x=1782669846;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2NWq1a9yS6VjSusgparelcQnMW7ZjRwUm1a9S4nsPpo=;
 b=gibqILCzIRtn+kKb5PZIxlwD6Q9Y/oT6CpTST0r+HDB3Pqj9t1EXI/TA
 SjTg9jKZccIAWngX3mvIUUZ3J4mWbnISwu7lZtZK8TVW8rGgJBS+VHm17
 V/Tg79nEbuIR7X7cSB280y8OhLuBJ5Jw1JCE7tYsQrr5eeVSp70OF0BdT
 kA0bX7a6WU0vqz1rvNU8J5gGOmPAH+rxMwC9KtEuER/RvI2pmnzgmZcfn
 lCKKV3zMCTIJtvqT/Vxz66/OE/3pD3w3fekTdc3Cj1B6icjwOJ6FuC4xD
 knefKEPza1IrKupXcOeHQOyiRlPr7apS6hJP5v8YGVw5vb0dy+Oueqss0 A==;
X-CSE-ConnectionGUID: JXzZ/idvRum0wXW40jCMIA==
X-CSE-MsgGUID: kXqyn0zURuehB7HGr7J2Hw==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39512594"
X-MGA-submission: =?us-ascii?q?MDFySJ9/bbimVbQL7IpwW17YLFPd8FjadrWHM6?=
 =?us-ascii?q?O7Vfp7yaB9bP1LIcR7C2m3t1mWsNASWjCJDsCyLuR5CTLqamj+biI7Ty?=
 =?us-ascii?q?FzpOJjV1Qbgk5n8LbIDQ0PlfGryuNJxE12pBhGA521AfPNeL5Ck9I3nT?=
 =?us-ascii?q?AXvIJycKuwDHXAQrFa8Ax50w=3D=3D?=
Received: from mail-francesouthazon11011015.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.15])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj3YsBrf0iZtRKnmQdtH2D2auKd7WkkDcumXiIZDjeo6CDfM3qH+dRNGPSyNoKpSTNAYCjUV5KT01oemI46prGf/OZOTMAStTqm1Pi5kHfXJg0ni0pY6/0MuWiadkBJaxNez8ZhrVmleG6/cPBnmq2ojqLFSjRPORiDj91n++Ht75G9kbNS6kFR0iOkHbBUOx1jNuu1Z7RRDWWb5W1VAal2t8UvrhPn4niAZyLLyKAp3LsgOkCp4u9AQ9oohbBX8f2U484HOZLtuatjzQEurdHz91rXcXMlqUrfW5lm9q+xstqlO8j0sqhL0TmETAAoov8fdxT931zSmouFUjOshvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVVnpVceGl/N/JzKfQZfchNOQUu0mUCBkdHeNu5a03M=;
 b=qV5VfTC+ABkzyshFGDihqf6vg4OJdf47DYVeBoLBpVj2GDOAVXWOfTKh7Bn6GaBdNKoC8Pfl0vo4KI4Z2VjFzllqzwFzTWUPY4E80C9RqtUIEbYy9g163cfuG5A6KWHI6R8h0SUwsnkhn49bI+6iiyXXQP7yL7K3gDe5vWQAN3ajcEY2wjqqR2Hngbfrija1htSdzDgZ6kCgbq1MW1arKj2grMn9o/VwyeIw2joVsFz6AzRfx8fIuJqfeZpT7Ka7FIVra1GaICk/HexrKCnmP+C+PKfWwUaYlAe585wvi52LQE4PB7EvinfeiKDmjleDUnsqJJz+wCIILcV6//fN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVVnpVceGl/N/JzKfQZfchNOQUu0mUCBkdHeNu5a03M=;
 b=hOwG+ETxZv8ian0pmak9BqCmPou4yDW5H2OgV6hTfJAEkjio8C9QG5gkJLsNAZ72JLNPMkgS4tfyY6QMb+FqflksD+S/jhUGgDRF1my+gNh8+6vb9Nto2W72dBll1bmGyTgwu4k97oG8ggx1cNpRNr2diFDk4xaSPs9bZxtV9JuZEtA9MOaw8kqrgTT57FbR9Jv0M/xnVm9gGZHa1jhCHMmmRx5lfoCHaS6YP6/ucs1S8y3lIr/6R9XtfVbS9vhJN4r0L4oylbhvFSupRjnoWvNyRMSswPc5CKbSk3dtQ66DZnidU+M14dueee1VIWrFo2bZE8pXsxg/53NgbAAX3A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:02 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 04/10] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Thread-Topic: [PATCH 04/10] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Thread-Index: AQHb6FcHl/LGS3qxsky2KWCpP2bFjw==
Date: Sat, 28 Jun 2025 18:04:02 +0000
Message-ID: <20250628180226.133285-5-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: 5c0b81ae-84a4-4e2d-5fa2-08ddb66e29e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?essAYAHlmhmwi/hnbXvgzV5vQvIeNI+gatkHApXu7XypvBciHLspfFnfnW?=
 =?iso-8859-1?Q?SgcDHF85MV8glQsmAtHBEmVIlK4IDphlOVr/SR+S53FQLICNFXRWhyLIcR?=
 =?iso-8859-1?Q?OQvxGgz97JU2PjeCNN1LA/ABMC92sX/3QF16ELuB/UIakt3QTkD4iMTwNp?=
 =?iso-8859-1?Q?znxn4mfGHl5as9fomkij3oYJbIGYpZ6RqpzLF7gQTMrgjAcKkaFes+SXO4?=
 =?iso-8859-1?Q?BXnZco/8J+u0F+qa+W0uv+Qp+MDMwumU7eqcHiTtqAO1Pv8ODRrto8vfLU?=
 =?iso-8859-1?Q?CUZAlZ6GbboBfSa5cZmMBrp8bemTrDlv0TB+6euSRVqVgBGKOE7/391imE?=
 =?iso-8859-1?Q?C6n1T/tOLNs8AQJkTmCcQXGBUyEFi8CZuxSh2UX9hhtdipl4ls36lUbYhs?=
 =?iso-8859-1?Q?TImtRIODtacH1EpprneSdg8OOb2Rr1kNC2+wkXnQ9Ek9Ha7MgswS3+Ggm4?=
 =?iso-8859-1?Q?RlunKQ/HKWGR+T7x8eeIH3onM5CS/8uJNRjz2Ez+LPLEg0Kh/1zJFWfQWA?=
 =?iso-8859-1?Q?rcr5UjS0JgVi4zz80GmVYYMD1kkODyuV7g8HYZyMuxuXHmtVef98OcCdzy?=
 =?iso-8859-1?Q?xspL44eGKZT3v5R5Uuds/pfs3ieKVzvO1K3xvrn19MkLU4cpuS3qBFx2UV?=
 =?iso-8859-1?Q?moZ1HJLnyUyWpM8i7l4FE2IQMQ/5dIV9qcehXpqhx1Jr2DvGaT3vCiQa61?=
 =?iso-8859-1?Q?LThekkF+FX69F92vWAxlvtAQZnOL86xTlDLFIw4uT2+oMUypRFsqMtv9Ty?=
 =?iso-8859-1?Q?WrDJdMtwtLPDsYa/yL8vxUQaCVB0R+uiBkUR/+BqDzK5cSXOT6A6Lf6eR5?=
 =?iso-8859-1?Q?Mc7oKX2xNPNRV+UXZgth4S4/KqnmOiQ8KChXCitM5gCilMYdF0VCndodC6?=
 =?iso-8859-1?Q?olC7BZSTV5XrhNPwEJfBcmachWemu4Cd8Zeuddo2tIqNTtGlNv8yEVF870?=
 =?iso-8859-1?Q?sO0CcD7FSrpdNgt8GIy3rxTwUlVJKnprPLCjahIyhAFlbD8GPH9C5alPBL?=
 =?iso-8859-1?Q?oHq+ZlhKQ+Fx/5I5hC8rBYLWIAsOxAE0JdXvmpCo6JuNZyhKhpZbqnM0Uq?=
 =?iso-8859-1?Q?aSjr2OpqlYuwKgsd/wNzoPxeukZAMfAnDzGMh8IPiSqRpaTR+bI3X1vxZL?=
 =?iso-8859-1?Q?0PjnC2sPiayc0OzUwHvwNMWuQLPkFfaUKkzNX3nDqj/LXv/mlPcjUpJV7T?=
 =?iso-8859-1?Q?n1QqRMiGYOt6J/Os/FEgEFasd2I0f3dZRItQPkCTsP6YWMF3r7WCubXMP+?=
 =?iso-8859-1?Q?kSKRWlstU5UmYG+ZzTq/JyXltCbdeyBdnSyUoFV0dOUptuWKUQTedU7kt2?=
 =?iso-8859-1?Q?fjZmb7yUJJ/zZQuYxEGszU7u2yoZr4Rz94K/00W8MjMpeNz0TLrP2EYmJW?=
 =?iso-8859-1?Q?5LR9O9gGd40dCFye0UeZr/ESFTsZRAzugRXY5QVg6r3jHuv+Ts7ogZ7Igs?=
 =?iso-8859-1?Q?4FnZDVTczrmm/HEgTwItx1NrH36wg27deqxARcTbDz0MqHU7VJ0lkGa3PY?=
 =?iso-8859-1?Q?hiyaoU8N4Gq71WY4ynv3kwCEHBHk2gAsQC65IKoBCsmA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TMkp6DFCaWJYODZ3QYKQBDWKfHCYs/f+h1buhXctjRXRbK2fn6Usy/WAbV?=
 =?iso-8859-1?Q?SIWrDo7tq0CWZ+9e1z+fKj8T3a/fQrDwiomsuZkaykJu99Dh++l5tlrjvN?=
 =?iso-8859-1?Q?wsJ67TMVhRbkpPhYDUQL6RMWEuJYgRoLWLhrj1hxgljD/osFibq5vobWTs?=
 =?iso-8859-1?Q?3cVF0aoHj871qO34xH6RXa2h8K8S7gndxgcMLfyz90j+oQIbOIHgK7qGRo?=
 =?iso-8859-1?Q?nsTDaqCsKKUI4ala/y5J4FNxW/VNjfYgZThI8QDNPjeW6e5i40XGO0EV3/?=
 =?iso-8859-1?Q?FS1hc0oWR7xmaoyNpEr4nwPMl5BPrvL8R/rNyIEZBYa+8KcVuy+otBZOJD?=
 =?iso-8859-1?Q?51x5LeCcJhzr6Z5IhGS7Cksrh25nSxXqS9ukERfzkX6NLwls1KqUOb8OYc?=
 =?iso-8859-1?Q?VWLO8RmfBO1qccpmwp2lztNP+9KoRY4f5n+0QUTKz6nD1j3q99DmXYho4b?=
 =?iso-8859-1?Q?J9C3gpOZ/E4PlYB9uE+hzl9vHk90CUWBIWUkyOpgrFmgLq6BXis0FFjmC6?=
 =?iso-8859-1?Q?GZ9BTpMU6YjgqyUpf6igZEQO5AePThYqTIT5UQ6B20Qvi0AvDWKKpDsq0d?=
 =?iso-8859-1?Q?rfqmtuBxGrKFn8koVANsYuDzSzX3NjI299FVBkxUMYvghYOZ9h7E9YUlep?=
 =?iso-8859-1?Q?SpJf8yse45rvK6G7yqHyWBB6s6vMpz8Az+imjVWqKQ5SwfXqINceQAV88U?=
 =?iso-8859-1?Q?52eWLj1c4iluvUQB/iWpiGftP+hL4lvFMpYcgyMi7cIB3OpuTg3aoHocv1?=
 =?iso-8859-1?Q?zENP5rFW0tGS/wagq0vzDcSe/4urnGEXnVNB3Ojd6p6FMnysSDWrrcWUYb?=
 =?iso-8859-1?Q?X+2Ifi4hHB+OpLFFWjzm3bcnsYcQKcOJfsJhhrtXM/qTgGhFBVjSHrfIDE?=
 =?iso-8859-1?Q?mASc430e2FJ1EF30X5GZJwW3FpokNCO+lYgEiC6ijCJlCdzqFWZPVmw0+z?=
 =?iso-8859-1?Q?AAfgWJTYImToAzDMvpdMBmHGJfbs8m1Mz2hzPkhz/lr5f4gOPH8jAPc3Ez?=
 =?iso-8859-1?Q?iA6rLHLhX6KTP7dey1D6jYLr6U1KSGcxfX+xUuLWxUa28HvtpQVV8Mmsmu?=
 =?iso-8859-1?Q?LTxJ6Jrb3dA2alPM/FUy2nu2+3bjxJ3TsdeG0FQMcI6Gm9H0IYLh1JVdt1?=
 =?iso-8859-1?Q?PWdLBSMVo0x2jqWK9ie94vyjWfO2KmKlIMWEiqurY8SkDRkFotdjwnpHzW?=
 =?iso-8859-1?Q?k8wOE+XRYLzL7LGsFbn22giQ0Kp9CTy2GbxBVdxVWTYZ04cLuyvkuryMt2?=
 =?iso-8859-1?Q?KXUrIRxw3mrnvek3rN47LiBZonA8nZh33N0xWgZRAsqc0dm6Vov3o5Ff1K?=
 =?iso-8859-1?Q?4lmgGDpD+fTn6AQm/8M5k+IhGOdwYeavs19ly3fhNExHcQS2qDsktCiLZg?=
 =?iso-8859-1?Q?ZGfzi69dpC496tjKbm5jPmfjBUga//OFkpOIJdFA8XqNAB5aQQxZtMH0tX?=
 =?iso-8859-1?Q?o2hKbf+jbFGd8Dx1rsoOJgPN3X3BffqKRtnwBYcbl0VaBZbFT+2Q8y7YqW?=
 =?iso-8859-1?Q?XcHpuJEQzidsNf4t6YIPCTG8i4IlC0kE9+Qr3CZu7qUmKGx57/Hln2u3pt?=
 =?iso-8859-1?Q?XC0eNqhYjrGXo/1/ReMk4o3b67sl04Vb2gdeDzfQAyg3nN0wTX2g4EYGxe?=
 =?iso-8859-1?Q?wlHHN3VIO5cKWWXw8amQ+rufwI+9mm2Lup193M47IZzO1F6ADnqG/k06JR?=
 =?iso-8859-1?Q?QUmSzQ9ea99wdNIaZuk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0b81ae-84a4-4e2d-5fa2-08ddb66e29e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:02.1700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GIhXtEl5mSYygFg1NZu4/UfJjL7ZOjzdJVkqBwQ122R1wj5gfFxRqh24ZxEQUvdCDkNUZFoh8cVtQPJ72N3kOCuvMQA1D91YrtK3WfAOAcXv/ofJeb/oVZPuC4lRFFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

PASID value must be used by devices as a key (or part of a key)
when populating their ATC with the IOTLB entries returned by the IOMMU.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 69d72ad35c..0fb4350d48 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2503,6 +2503,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOM=
MUState *s,
                         .translated_addr =3D 0,
                         .addr_mask =3D size - 1,
                         .perm =3D IOMMU_NONE,
+                        .pasid =3D vtd_as->pasid,
                     },
                 };
                 memory_region_notify_iommu(&vtd_as->iommu, 0, event);
@@ -3090,6 +3091,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace =
*vtd_dev_as,
     event.entry.iova =3D addr;
     event.entry.perm =3D IOMMU_NONE;
     event.entry.translated_addr =3D 0;
+    event.entry.pasid =3D vtd_dev_as->pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
=20
@@ -3672,6 +3674,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryR=
egion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb =3D {
         /* We'll fill in the rest later. */
         .target_as =3D &address_space_memory,
+        .pasid =3D vtd_as->pasid,
     };
     bool success;
=20
--=20
2.49.0

