Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C26CEFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6b-0001oi-1r; Tue, 24 Feb 2026 00:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6Q-0001l1-Fn; Tue, 24 Feb 2026 00:36:59 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6O-0001I9-2r; Tue, 24 Feb 2026 00:36:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9GR2zLfQSOf8Y9UhYzLqHxTu9UFB9axIWK08NRnPelibcf0+KLUHWxP8T3eJnBs7sya7FDPfqQ4S78jhlcDQ37gLLAuwugsWnxdel6vumrcCvGbTrcTEY93ncTIu9mlP3c1bLmgC36IbVXbCbAS9RJu7P71OZSmviPGUTaK6kdvRbJXRodBGnPbR5Yo3s65AX0NUnPviuMfmanCeMNbLJfHi77czHGRBsKWvvR8EUKbOBJVGRJ2vgoNeqO1jGGM2bm6r6jD87mFJ/EoOAi+wTokxzF5vRh+fwFIFy2NqETOWo1h8wUoKqldIUDaZmGWof91+dQTaoLPa6jeAOlmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZjFS/hdvT8y2d1p3xi33JUio+UqLSU4JtKs354VCAg=;
 b=tB1xFLquancPP1Q+d6SCJcgCxcXVzk6rJoLKgSFAdzPCmGp/Rd5W75eDcwA5I4CQebMpMdCw6AfuI+DS6a3o+Wwl0ZeA4N0S6KnIFeDnGohVrEOaw/rAy3+ZTXCB4d0826UraTx/39BldFnPpaP1+4a77Up9WfDmP1go7h82qnCYpAcae/2h1KmWXFW9sjnosV2EJfFQ6BE82pIdhZ/PAOpbEkwlJV009Xw6cQqrGCL3hgWfy5HopaHGKwIFqCDaW0oemJMvOrMUxpIFF5CHPR9SUTJlEGe47peHjxof9kh/5zuT4NLMnTCwQj78xhp2gDcPTg8q3xfCr3zhbR7X5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZjFS/hdvT8y2d1p3xi33JUio+UqLSU4JtKs354VCAg=;
 b=AeupAhlc6XpwW1KBGgyNMUXR5eKheTNZlO8R8vFmz88VDKarLhHxvmwgM/e8UbP1dbf1xJ1+7P6RBUrmh/ih3raErlXm8YwgEYT7eVHoinj1CIU3B68lz5v19r+CC00Ru6eFmZTJYt50pR4+u9PZuy2TiIxJxnORUfraj/55In6YaQBztWT8xVg1yxvEkFtb7vkWy5p//Dar5y+6YfC1Lr17Xk52Kr2kZuCpU+qdDcV8vdkYGCTGQixXM5dC8F3VozcnMCx0GcrJ2kHKpVToMSPVgRqXb2UgRJPITmOxy4SuE0UZL/sOfJCqB8qKzFsHL/UlCtyMCsBDZ57mvVmAkg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:40 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Titus
 Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v6 18/22] hw/i3c: Add Mock target
Thread-Topic: [PATCH v6 18/22] hw/i3c: Add Mock target
Thread-Index: AQHcpU+NLHSK36NzN0qGLzvsV3BuiQ==
Date: Tue, 24 Feb 2026 05:36:40 +0000
Message-ID: <20260224053613.589102-19-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: f9265ac3-b6a4-4717-0923-08de7366afae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MnXOpJdAp/npt5D2m1iIJiraTMc3PWaB6tfX7ntzluj8sU6dkCJ3RykIO1?=
 =?iso-8859-1?Q?xYUuw8o1BcTAPVdwNd1u+MgPP3adAvzwQnbglmjs1+G4cxd693Mr+SZ+/3?=
 =?iso-8859-1?Q?CnCr8bIVyvJzJw4w8Wo5PFrzKcaEq3NziGneDxASWpYnAShmxcjYTgzCZY?=
 =?iso-8859-1?Q?UW5kr2LUheO59H8aj+XHOPSBxmcdXRzoWcWDBPaLbVn21902gV/fr3fyuq?=
 =?iso-8859-1?Q?hNSnf/2AiHRJO1ykmGml51p3ATUqEOnjuW+1quHMeS8naxlIYkjpugm8kj?=
 =?iso-8859-1?Q?77dSrV0XW99hHwTNHxHXoKZjkKo4xnVftmmdbyLTqXTBLBOx82mYn+NFDd?=
 =?iso-8859-1?Q?ZuLWBx7CkS4XaT2gGSIZ7OH52GczhNjpU45dNLvwGKwcfvnwNqEy85KU8N?=
 =?iso-8859-1?Q?5cyIzDJ6Yyl1uc9IUlR5SDGt318+i7Sj6t+KWlzzRB0BZiT4vXbcG0GENc?=
 =?iso-8859-1?Q?JUrxGJAeSm2ejvFFcBQX1Ulwk0ruE2Ux0jVD5cSMxtu3HUaTiFWf2TOn2V?=
 =?iso-8859-1?Q?hc/VmOQVqiDhzm5CLvoXRGOugzadvaH3Hsk+iwMCrKV7KSRCkG6JIFr8qz?=
 =?iso-8859-1?Q?DUZhWyQQ7OWDbnegzsYA6Wfy58juXwFeEzfo7eFTYef7Gfw65VziNphByh?=
 =?iso-8859-1?Q?pjmTo6G9zN7KUWJJqISFELF8UVml3+LX737AE4ONqOxSxyIB8GlGVvPKcU?=
 =?iso-8859-1?Q?/6QLw6Pn2ef6g/ASxe2TEBBonlNl9BkKwLohpBA43VCdeLfuL8J/u5Ca49?=
 =?iso-8859-1?Q?xEI2+p1y1fB5TrHNXfFGHCgY5SB/KryvZM6NYJbrXSPhlfCvpfm4zXa+rp?=
 =?iso-8859-1?Q?yXfrSs9mbZp+QVOqqH41W+XkBvP2HUfWbog+h9H5ZGxBQkgjdtRBAL3CSh?=
 =?iso-8859-1?Q?bFp7gQ99aQnNZ26vH3gs1tsxR8o6dwod3Y75PKQpeAstzUiupkoo8Z05aD?=
 =?iso-8859-1?Q?/0ESZujGIkMyxYfm25nWpcW4tg8Onh0at4XtY2DrMJzf3G6lCIqpcrZTbB?=
 =?iso-8859-1?Q?44XxcsspD4eKbUTRgf8q0sTPuM+ekTQ54y1JJIlmTyIyd9mQRhYW8hJpKf?=
 =?iso-8859-1?Q?hPGPdegyikH1/h8EBgmmh5P0Tdfg3IVmZj7x+5srZJAIACKRck1VUrfN7X?=
 =?iso-8859-1?Q?J6WYvZqUhODIVvrV8MrxVQXqTT/9y+9C0WwWZorkgSDx95rvaFKptOoqBL?=
 =?iso-8859-1?Q?wNlweSxKsHb7JIGI8tElVsVHCto/Gdj5ctjUyYrs8ItPFZXW3sFUG94Nrx?=
 =?iso-8859-1?Q?VDkAktLpHBuh84zuJKK987JGq4TVZV/soT2wee284blPWRfdaI3TK6G6zx?=
 =?iso-8859-1?Q?IYH75B133LPOCdvg7xaXmRNJWhtuud0TeZ63dOfP45P/bsYOwLHyxtEx3+?=
 =?iso-8859-1?Q?7//CJVdXFXtK9ZBXjm6qvkpHK0Y+uZ/PnOFud+fZj5QMnB33WfYtS+ArEC?=
 =?iso-8859-1?Q?lJAA0CwEVUr4IwsYiAcxx1zAOPeAG3x0sfbjAuzIxUwLV2vdST1Z2UH8MH?=
 =?iso-8859-1?Q?D0h4XCdyxR7U0krLjz7IaZuQZ2c9xzyh8hrfUN2IGUEmP77/V6boNk5t6p?=
 =?iso-8859-1?Q?GFlahxJp8XG/upOnxnxGe2WXgpxPH3Bx4uurPA42qpgaGph2IM+HaMQnw4?=
 =?iso-8859-1?Q?qYvzd3hGEz90tIKocgflHxsnxULz4HuTBKGvIXtMa2HCtRUwn6euwt6UrO?=
 =?iso-8859-1?Q?av2PFCIGZp04XOA0U6+lPgrSYeL8MOC1E9TCmR/S?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BXe2FeWc/ASQBZTXRUsSflxMOxIsqx/x4QY1gWa/RmOrdKX+Z/Po2xs8/3?=
 =?iso-8859-1?Q?4KAH391QvI+dIaw6egueToGd7pBpCl2lAfkpcQkFY67za9Bi40pZeO6hy+?=
 =?iso-8859-1?Q?1JvgjNoPG2RDyjt6c9hN8KAUOO+4owTjC8CZJNJXxRCakl6xn+fe6xVbck?=
 =?iso-8859-1?Q?tzajTCnHeOibNY8rpi/1k/54unGv/2BN3T5BJTvfbAxuTgC6IWuejrsBmY?=
 =?iso-8859-1?Q?Ln9VrIClFI/7eAhl1N3YdpHTiIVCvG6rQMGxwAkGKEJSm9o601F2vCObTS?=
 =?iso-8859-1?Q?dlkE2WrhVOXaOowRbq14wbv+oYdDkpwz/DlJ1cSrouQBxTh/qsLs54Lk6w?=
 =?iso-8859-1?Q?Rc+Pu3aCCu7GnXoIP3eFK/gNPiHXj7nNQGECDoCtQUD11uMv8l2EUMVBGw?=
 =?iso-8859-1?Q?1j8kHPhjylliYHiIfGZbDfnDTXnjX7Mp0gC0SPIMvINQgGxxHLvRpLexRa?=
 =?iso-8859-1?Q?tGdOpxoIYWNeYQVmL8IIJC86OAYJM3QUGuuvRSanm698h64bcI12LGLmHC?=
 =?iso-8859-1?Q?aMvn215aAY6Ud2zMWRnf1FZy3oiR1Fxso2we4p8brViQ45GJM0cEwa2e+p?=
 =?iso-8859-1?Q?+0m0/LXO4tKEeJwWoXpxVS7xR6ynBJZWiVYZwBd4dHoU0AqfCuyXFzPUqN?=
 =?iso-8859-1?Q?c+5xQkdz7jlJ0CEO2wn/KJtEK/p6NNrilcse67r0zNutwt2qjBPD0GaE/Q?=
 =?iso-8859-1?Q?5K789xQ0xpln0mnjoLIhENxc9okgRwj8uDqaCvfL/BS1mwG1Ceue1CabDo?=
 =?iso-8859-1?Q?VxcwH6ID8j3vCHk+tRUp/7fO9cb61BraXIp7+sqhl+q8GuoGZCvRxb2fqV?=
 =?iso-8859-1?Q?eeuvKY58LGgTel0ioR35h67rFxYE9lOvVUI1SFNvZbiGIDx9+oD7LKQmeE?=
 =?iso-8859-1?Q?geTsCJdtA7TIYwCxPr1UlVNMDXfuz9a079AXqJxW8ceHDJh8I4KGrP2m/0?=
 =?iso-8859-1?Q?myq5Gd+ya+9M3TMz8H8f6ppOkswMjfkNDutGUaKny/QsOYEsu7MwbWXuyj?=
 =?iso-8859-1?Q?LzI8NmH0FT7XVM7kRvtcoVwkJxb4+j+XxvsUWgJalnC4HtK/Oa+nfti7sc?=
 =?iso-8859-1?Q?NnBJQKY1N4gPkWRqq6BdbSDDqQWd0Jnnho7MJdub0ryocgmqKod++N5coC?=
 =?iso-8859-1?Q?vptHWkPf/PO8v61aqlz1raYHj+DN78j1VNMNPK/fYMPKWsDBE4nwhPLQRE?=
 =?iso-8859-1?Q?LgeWjfF5qNCUltvxYC5DAVj9ELMMt/RYQKDYdnWL0j791KVaoUzH4AFxTZ?=
 =?iso-8859-1?Q?gSLomxC7U3F1NjNEYalEAnZ5gnD8cY6EvqKDHjJYVhJlsxGkuYuQIEuuKl?=
 =?iso-8859-1?Q?ck+3PuVY+Yfj/pZ+zTPAFarrNgeYjqhCoeP6D+indyZAfm0k95ECalIhrl?=
 =?iso-8859-1?Q?Vbkhrtu5RfmsbD3f1wqV3P+cWwt42Dct4ghcINx5jBFWBtF64tGbXI9VuR?=
 =?iso-8859-1?Q?4gA8SuSA7T3fcBZqE8U9R9GU6so3ervveHqmsTBvjHEMKWpfj+/XCXxmiR?=
 =?iso-8859-1?Q?KVmdxAvnC8NJErdjH28tdJe3rgCBc+OoBqmSojbmIsQmPm21vPIjQywJKC?=
 =?iso-8859-1?Q?UkeKqUNN8ESbK+mCR8W4nEOu31TzDLBe3xWIOftbHZafIPohxvz7j0eJB5?=
 =?iso-8859-1?Q?3SjQPPMn7/rLn8GERlYrpwhpiG1OQ6uNGG0LDwpijX7OQofVhONPpWtLyq?=
 =?iso-8859-1?Q?cUTqSMG3rwVaN563rdTjnZkcLeeY+LP6+huJUQgxPbCIn2/vRw31Dg4u5v?=
 =?iso-8859-1?Q?1PptlLfRtO7/lcEECzmJokxJnNn1dW2G00+4VUlF4lHR/bt7duVXTGeItA?=
 =?iso-8859-1?Q?UVBE1wOrPA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9265ac3-b6a4-4717-0923-08de7366afae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:40.4231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aco61LNhZSg6iX/QfU9+yIvEg8QKJF2RvpCfvkVDJhsdiqVNYlqrDbRdR3R55GZhbvV66VHzoy3UQjHe5dSBv+as1vAMEBx1SLhgZCQyxTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Adds a simple i3c device to be used for testing in lieu of a real=0A=
device.=0A=
=0A=
The mock target supports the following features:=0A=
- A buffer that users can read and write to.=0A=
- CCC support for commonly used CCCs when probing devices on an I3C bus.=0A=
- IBI sending upon receiving a user-defined byte.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/mock-i3c-target.h |  52 ++++++=0A=
 hw/i3c/mock-i3c-target.c         | 298 +++++++++++++++++++++++++++++++=0A=
 hw/i3c/Kconfig                   |  10 ++=0A=
 hw/i3c/meson.build               |   1 +=0A=
 hw/i3c/trace-events              |  10 ++=0A=
 5 files changed, 371 insertions(+)=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
=0A=
diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-tar=
get.h=0A=
new file mode 100644=0A=
index 0000000000..8c6003ae8b=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/mock-i3c-target.h=0A=
@@ -0,0 +1,52 @@=0A=
+#ifndef MOCK_I3C_TARGET_H_=0A=
+#define MOCK_I3C_TARGET_H_=0A=
+=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+=0A=
+#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)=0A=
+=0A=
+struct MockI3cTargetState {=0A=
+    I3CTarget parent_obj;=0A=
+=0A=
+    /* General device state */=0A=
+    bool can_ibi;=0A=
+    QEMUTimer qtimer;=0A=
+    size_t p_buf;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    /* For Handing CCCs. */=0A=
+    bool in_ccc;=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+=0A=
+    struct {=0A=
+        uint32_t buf_size;=0A=
+        uint8_t ibi_magic;=0A=
+    } cfg;=0A=
+};=0A=
+=0A=
+#endif=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
new file mode 100644=0A=
index 0000000000..875cd7c7d0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -0,0 +1,298 @@=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/mock-i3c-target.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+=0A=
+#define IBI_DELAY_NS (1 * 1000 * 1000)=0A=
+=0A=
+static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,=0A=
+                                   uint32_t num_to_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    uint32_t i;=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (i =3D 0; i < num_to_read; i++) {=0A=
+        data[i] =3D s->buf[s->p_buf];=0A=
+        trace_mock_i3c_target_rx(data[i]);=0A=
+        s->p_buf++;=0A=
+        if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Return the number of bytes we're sending to the controller. */=0A=
+    return i;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)=0A=
+{=0A=
+    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+    timer_mod(&s->qtimer, now + IBI_DELAY_NS);=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,=0A=
+                              uint32_t num_to_send, uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    int ret;=0A=
+    uint32_t to_write;=0A=
+=0A=
+    if (s->cfg.ibi_magic && num_to_send =3D=3D 1 && s->cfg.ibi_magic =3D=
=3D *data) {=0A=
+        mock_i3c_target_ibi_timer_start(s);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (num_to_send + s->p_buf > s->cfg.buf_size) {=0A=
+        to_write =3D s->cfg.buf_size - s->p_buf;=0A=
+        ret =3D -1;=0A=
+    } else {=0A=
+        to_write =3D num_to_send;=0A=
+        ret =3D 0;=0A=
+    }=0A=
+    for (uint32_t i =3D 0; i < to_write; i++) {=0A=
+        trace_mock_i3c_target_tx(data[i]);=0A=
+        s->buf[s->p_buf] =3D data[i];=0A=
+        s->p_buf++;=0A=
+    }=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    trace_mock_i3c_target_event(event);=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        s->in_ccc =3D false;=0A=
+        s->curr_ccc =3D 0;=0A=
+        s->ccc_byte_offset =3D 0;=0A=
+        s->p_buf =3D 0;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,=
=0A=
+                                           uint32_t num_to_read,=0A=
+                                           uint32_t *num_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+        /* Default data rate for I3C. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D 0;=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Support I3C version 1.1.x, no other features. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D 0;=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D 0x01;=0A=
+            }=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+        /* MWL/MRL is MSB first. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
+                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
+                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            s->ccc_byte_offset++;=0A=
+            *num_read =3D num_to_read;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t =
*data,=0A=
+                                            uint32_t num_to_send,=0A=
+                                            uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    if (!s->curr_ccc) {=0A=
+        s->in_ccc =3D true;=0A=
+        s->curr_ccc =3D *data;=0A=
+        trace_mock_i3c_target_new_ccc(s->curr_ccc);=0A=
+    }=0A=
+=0A=
+    *num_sent =3D 1;=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCC_ENEC:=0A=
+    case I3C_CCCD_ENEC:=0A=
+        s->can_ibi =3D true;=0A=
+        break;=0A=
+    case I3C_CCC_DISEC:=0A=
+    case I3C_CCCD_DISEC:=0A=
+        s->can_ibi =3D false;=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCC_SETAASA:=0A=
+    case I3C_CCC_RSTDAA:=0A=
+    case I3C_CCCD_SETDASA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_do_ibi(MockI3cTargetState *s)=0A=
+{=0A=
+    if (!s->can_ibi) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_do_ibi(s->parent_obj.address, true);=0A=
+    int nack =3D i3c_target_send_ibi(&s->parent_obj, s->parent_obj.address=
,=0A=
+                                   /*is_recv=3D*/true);=0A=
+    /* Getting NACKed isn't necessarily an error, just print it out. */=0A=
+    if (nack) {=0A=
+        trace_mock_i3c_target_do_ibi_nack("sending");=0A=
+    }=0A=
+    nack =3D i3c_target_ibi_finish(&s->parent_obj, 0x00);=0A=
+    if (nack) {=0A=
+        trace_mock_i3c_target_do_ibi_nack("finishing");=0A=
+    }=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_timer_elapsed(void *opaque)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(opaque);=0A=
+    timer_del(&s->qtimer);=0A=
+    mock_i3c_target_do_ibi(s);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_reset(I3CTarget *i3c)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    s->can_ibi =3D false;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(dev);=0A=
+    s->buf =3D g_new0(uint8_t, s->cfg.buf_size);=0A=
+    mock_i3c_target_reset(&s->parent_obj);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_init(Object *obj)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(obj);=0A=
+    s->can_ibi =3D false;=0A=
+=0A=
+    /* For IBIs. */=0A=
+    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_el=
apsed,=0A=
+                  s);=0A=
+}=0A=
+=0A=
+static const Property remote_i3c_props[] =3D {=0A=
+    /* The size of the internal buffer. */=0A=
+    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100=
),=0A=
+    /*=0A=
+     * If the mock target receives this number, it will issue an IBI after=
=0A=
+     * 1 second. Disabled if the IBI magic number is 0.=0A=
+     */=0A=
+    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, =
0x00),=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *k =3D I3C_TARGET_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D mock_i3c_target_realize;=0A=
+    k->event =3D mock_i3c_target_event;=0A=
+    k->recv =3D mock_i3c_target_rx;=0A=
+    k->send =3D mock_i3c_target_tx;=0A=
+    k->handle_ccc_read =3D mock_i3c_target_handle_ccc_read;=0A=
+    k->handle_ccc_write =3D mock_i3c_target_handle_ccc_write;=0A=
+=0A=
+    device_class_set_props(dc, remote_i3c_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo mock_i3c_target_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_MOCK_I3C_TARGET,=0A=
+        .parent        =3D TYPE_I3C_TARGET,=0A=
+        .instance_size =3D sizeof(MockI3cTargetState),=0A=
+        .instance_init =3D mock_i3c_target_init,=0A=
+        .class_init    =3D mock_i3c_target_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(mock_i3c_target_types)=0A=
+=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index ecec77d6fc..d5c6d4049b 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -3,3 +3,13 @@ config I3C=0A=
 =0A=
 config DW_I3C=0A=
     bool=0A=
+=0A=
+config I3C_DEVICES=0A=
+    # Device group for i3c devices which can reasonably be user-plugged to=
 any=0A=
+    # board's i3c bus.=0A=
+    bool=0A=
+=0A=
+config MOCK_I3C_TARGET=0A=
+    bool=0A=
+    select I3C=0A=
+    default y if I3C_DEVICES=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index 83d75e7d5c..e614b18712 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -2,4 +2,5 @@ i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target=
.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 39f33d9a50..9e58edec99 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -36,3 +36,13 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx=
8=0A=
 legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
 legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
 legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
+=0A=
+# mock-target.c=0A=
+mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8=0A=
+mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8=0A=
+mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8=0A=
+mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "=
I3C mock target read %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx=
8=0A=
+mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) =
"I3C mock target send %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI=
 with address 0x%" PRIx8 " RnW=3D%d"=0A=
+mock_i3c_target_do_ibi_nack(const char *reason) "NACKed from controller wh=
en %s target interrupt"=0A=
-- =0A=
2.43.0=0A=

