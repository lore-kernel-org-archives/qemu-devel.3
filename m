Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815AFECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOg-0001tF-BN; Thu, 05 Feb 2026 22:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO3-0000UZ-8Y; Thu, 05 Feb 2026 22:20:04 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO1-0008F6-H4; Thu, 05 Feb 2026 22:20:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4TGM1sJADWdeJ5DSH5mm7VcKJgV/LkMKEt7q5FU9NPRgxnB1VhWIfPfih9v02iRFnquETicZpLHm0e6PnzM/FhzcTU+AMZHA3rw/GYibcj+vBZJ1N2DtuVUH0eiveRwD2234Os9B7VXSbAH1VagfHfxN3b10IYcGxfJbJ2/Ui+u+awjYHNg5pETcGfY6EGqm5oIY7DbfKm1spB+G/ZCfiO4DU6QElBlBl1nRAm9VjeOQDAU7h6Lgtj9Z/hfTdprkn1LfZSalssqFduRqFvacjD1fTv3CaU15I0M5rr3+s853XDuAZDVlGIDgK/NnPIwhdHkcLlGiFTTT5H2s/xTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z4H0ivFH0w77BDEXl5j1inCSDLr0zdIdVbkCCdeZhc=;
 b=kC/e9NImusTEjGHkdf1F60vpdSmLUtiIAtWNZgWh8RaRaFFIqfigMvxPeVLd0yUuQmjH+Yl3g4G47F1T6NUWcq+CnS0PuqRthPfu+lAbQeqCzVSQur57Ev57D1Hsp/lK2+e3TFIE4PUwUk87J4SM7dMBosur6F5yoODOhal6e3jO5ZveGTDrNBTB3ELOxZrmjabangQoCYjPfDm/H0kaYLp0QZWlrE1zAy97KKNzh4JBlJLx6eAqXnjeVJI2tjnpszT/z/+IccAfskt7cQjn/68YeEJoPgNFM6RRjR85sE+KxZGbm1r7Bxys5PYA0s3OGhLOMFh/+NV73t7yCNcNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z4H0ivFH0w77BDEXl5j1inCSDLr0zdIdVbkCCdeZhc=;
 b=XT6g1CZC7uzibi06SbDhDOYUyieIHEYs1wKlM6hk1x97zBLLs/K9Z+/WLVPJZs9hFHpwUrQ97bovnoKJSNQofcO02FHYogQe/9jkGF/8q6Z8LkGo9ylC5N9gQDm5LEc80ZsVSiWULTCzvgrBnrQyJIFiuI2Gl19lamm7QGj64sfoKJpjbHzQuJBeI94B1l6J7uWpdn9ajOHi4RRClzXsOFUnuD/uBODHgIhlV70P+VUyPOV2xkc3AkVaSb9x/HsiJqNhraYQ9iA9GKpatpQory2TPRM07TOYE49daYQG5INyr5rzKqmjWW0hIueXT1md2/aepSmgNvEmmkGds7Bh4A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:42 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>
Subject: [PATCH v3 10/20] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Topic: [PATCH v3 10/20] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Index: AQHclxdvfOSBl9b+SUy1x2GJUayTPA==
Date: Fri, 6 Feb 2026 03:19:42 +0000
Message-ID: <20260206031926.3227848-11-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: cf8954fb-ca30-4825-fd4d-08de652e91c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F87wKhudSjDwM28AlSPXqIHXDmrQZ8Y3/swLIE3Q72m3d60g0e4IKghZWr?=
 =?iso-8859-1?Q?mabRRvi1MAi9/wG/RSNCV/CiHVz6OmhFKfnVHaYkoh4z/D2bQIpMCK8PKQ?=
 =?iso-8859-1?Q?lfODqgAfjUmnyx1SZgGFo31Lqt9s55B+PnEiZinJ1g2Hu/Zek1QQyT4/+i?=
 =?iso-8859-1?Q?avKXmAK30A3/IQxOVCr9qdBAlLXofDi/2XO8GaIFk6RExn+Vzzh32l84ph?=
 =?iso-8859-1?Q?5htrSISDipe3sBQ69387pWvN9wtrR0Y0M8a8u6kWc0OzswMJN+N/GYvEOz?=
 =?iso-8859-1?Q?9vy428YJywjtnH6L1ugzABjxyKBS41WqHOSsSBUaLD2HKRmN9UzEF8YXi7?=
 =?iso-8859-1?Q?wbLKVPRUIYifBqwrtWUzg+LYhFx7fGC2ARIRaM1F1CIX/20JxucZzRCcVk?=
 =?iso-8859-1?Q?EDRMgj84ijC67Z2R6ny+NPOY/y8t0/aaEyei/aq640IfYKVha0YWBDJdwz?=
 =?iso-8859-1?Q?lROQSji0tHtzRqknq8grG8s2Q1PA9bdt18vM0hkXDAHCN8rZkKGJ+7qsUI?=
 =?iso-8859-1?Q?HQREdBB2ITHEGDQ0GpSv/P+1IKTezTNpwZXoGYYQwsF4kIk9bsQnvHu5pY?=
 =?iso-8859-1?Q?KhBbnkU9wJNHLc2GuSMRiQT/KLe2lAMNkRMR+bTAkbD/t89SDt+obKtAaI?=
 =?iso-8859-1?Q?IKu6sv+lQKiLIXCLLQjYmx5rX9eNeAzQ6dJIt8i3Qt0kVx0bSIZr1I8kU5?=
 =?iso-8859-1?Q?eNF54E7gCMnXU6/Y/4Jqq6kHLk6PnijjuTtTBzVaNdf2XDwTlbaoJppGsX?=
 =?iso-8859-1?Q?8N/Aehz5/RgN7z72OaIBU6/ur3JE200GEXu7sQ5pwzJfbTJDGB6uieNvQl?=
 =?iso-8859-1?Q?3HnWxvVwe7/QeubAPoQK0yVfg1OFF7cLDPi8Ev/ZktjA0L/SWw0B0ONI2u?=
 =?iso-8859-1?Q?L0HlKId6xw+F0AbrlrH3iL3Gj+tiK1XfPZOJ0bWwEBcykeO8H1O4kYsf/r?=
 =?iso-8859-1?Q?F38GZHQOLOrgRGrxZGQAcSc2e8b7zNCFbVJNDgfSSbvWq5jyZPNbn9pevp?=
 =?iso-8859-1?Q?JS24MFxb6u6Pqb/l8xrdc4dcJUGoJnyQ6K3tChWeKqRvxnj/oz3Y5f3xiX?=
 =?iso-8859-1?Q?ZaIEncJreLNo+bHcGmjCXxsOZjSq+dBVXtDXBu6/frjxKZY3F6JanfUxb3?=
 =?iso-8859-1?Q?c1k81HwbtNxo+S48LtVCSjr4aczvwPFu1ftLwnwXtCNMU4YuPFCJYpQgdM?=
 =?iso-8859-1?Q?+nBCfjtDFs6EDctbxZiGP5oHcROzOwIuyvQNTwsbg3V5njdOWmEvmJCPxM?=
 =?iso-8859-1?Q?A/UZRPXtZ7PJ7HpWwYK8U2Y1O0B2lDmeGpRO2iutf+Q5EBR/AB78JL6g6f?=
 =?iso-8859-1?Q?t37huGRc/iiyLNP12ea5qzhsn4GIKT4GwHlKq67EO3mYi8BWQARuLzE2Kt?=
 =?iso-8859-1?Q?DXcghkYcBM/P5tzp8hRK0ZgPkPe+AA6Snm2x3RQzBa8JBCES0lg9zBZ8d5?=
 =?iso-8859-1?Q?WIa68qi1HuSvbBiB05z09sdeqzaSBFHn1fxR1WYWd/d4wY0ut8Yk7kbQwn?=
 =?iso-8859-1?Q?x1xIyQCelCHGLeP8rjkihfiSDAO2qmXMWpEEZhmevKsfonj2UZMBDy3c+m?=
 =?iso-8859-1?Q?WrG2PxRvCqE+W8e4tp/1DWKENj9VKBmz4oGQBzlYBi0SLk8FqYj/eK4cyg?=
 =?iso-8859-1?Q?mC65M2uDZ6cNf9NZJP1vlUfgOJu6ZGwDzLnBbnAOcCaPUPlXu1iCMbfNBl?=
 =?iso-8859-1?Q?aiC0tZS8zqm/aarNwtfB0QNPQcLfzZRAPZhCZRNp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZLBjEf1K9HEJUGTWdrtBFxV6JCAYaoPnuAcvGpTJJg8anXVWTbQqK36TOa?=
 =?iso-8859-1?Q?yU1ZnrEB9VzEHwcAFqhoQiMH0Q00ahVCLlck0hqKJDe1I4rFZCZOTHk09F?=
 =?iso-8859-1?Q?p5jgmgi7flwEezmnMBQBjkcjudihQH+cizO4AckVwkZpKpr+9om/SPAvyT?=
 =?iso-8859-1?Q?M+MfugcD1HCLePzbdSgHeCkOofx9qNw00/LKsQorfug/nHyFPwGJJ/Uv8V?=
 =?iso-8859-1?Q?YH3Td2ICp90KzendRkkPHa7gUk8us61y/qWm5HfCVpPSAGe6WP7FhSTzXE?=
 =?iso-8859-1?Q?MVm6e73MuB/02a+XfX/86erLF/0vBp66s9YliUpluubHHJITxmzlOIN+hh?=
 =?iso-8859-1?Q?CTrPuV+pJxbhac8GTD+rfyuT8Elq3ZH33pGtsAAtJ8mdx8ek8Yb8sYplNi?=
 =?iso-8859-1?Q?fpGYHzBrL5ZV8ytc+GuW/Fp5RQGq11/igXjfhJCLvEPHezjc+YFDjgHME8?=
 =?iso-8859-1?Q?AvpA+ssjrT9/n/djl+ejdIqUJc5UlXvriusC2inOwMm4tNgBJCrtO1kOLz?=
 =?iso-8859-1?Q?J6hnaetiEPInJWrZXbGT1MLm9KoT5igfLz9Sd+3Tp3GT5/O1MEQAgCl1BM?=
 =?iso-8859-1?Q?32ZRFSrtMj+7t5e8xf2F7ijnZp0FlswCfJQFdG1AkQbr5L9v/bXEXMBlOM?=
 =?iso-8859-1?Q?L+FexeC3GXjzRjdd8vUgHU++zzLgSB/DGjfLNDYD+X4jTcZML7NvnKv7LA?=
 =?iso-8859-1?Q?fnJvKfzgKSjIMnOhPR6wBTfX5ll5+IwbguWUbL2EUVK3tJKmgyU1dI+bu8?=
 =?iso-8859-1?Q?3EcOTxHDvyPR/FzGGODR/B8bN2Y1GVH5qU8npOp3TN4r9UBAAanh2S5zmN?=
 =?iso-8859-1?Q?i28lmLAk9SwVKCaNCwJCktqIE/osDWPwmpnnyK7nSl5AbCqJEXimYX3rtu?=
 =?iso-8859-1?Q?qtr+CW3M8mcviP7FpyG63imMlsQkRLEaJ8EI9WixZK1lDf3vhk8Mf/pP0v?=
 =?iso-8859-1?Q?+8oxGEQ2DhJt9rMhXWD0ed23XEMLj2hm29EgyWQjRRSHWgL4TSsSSYhMH0?=
 =?iso-8859-1?Q?oLfaobSQ73DsA2Mn6/sbRBLlbbk5XzmdqMhvpZBLVeslMnY5+iWXtV+2KI?=
 =?iso-8859-1?Q?pHRU7A9XEMB/ElW0eYNWwbBn4WzjzDhDV3HrPW6TXDinm+JdIU242U5VM+?=
 =?iso-8859-1?Q?49IYi1+7zIl5YQQAnkC0lXnn5XXsQtc0TYFnVRDvwGhKBRn+CM0INUrwKB?=
 =?iso-8859-1?Q?mHfpe6/rLr8JBitAuxdzd8vuNnhIxJN743cfAc4viog/DLuBE/iDN9Fszh?=
 =?iso-8859-1?Q?v7CZUZnBzds5BFbdaOSpJodGWxOUFBx5n1yg21ItYnkYGjVIL088Vrq8oP?=
 =?iso-8859-1?Q?BXsVfyUq+kGQ7IURlm7LY9T3QQ6Z5AuL4jU+O4t8M9hkMD6bDQJBVAWLrO?=
 =?iso-8859-1?Q?GUzp0WWtR+V5GXeLC9YVnOhCIZKc8IUdHKRmS/KbVcr7WEgXFvBU5/OoJR?=
 =?iso-8859-1?Q?Orx4wuX5NJAfjmxnipdfxp1XU2LcN4Sz0ICUN/Dly06dR3qVkDQRu3w1ML?=
 =?iso-8859-1?Q?EsTcbZ+V2lvA9GUKu3e9N8cDyms0Xyoik/j8mpudMjrESTh8POinZdgvrP?=
 =?iso-8859-1?Q?LQljNGhl/zc27Lc/wHqdrQ2LWo62Xf3FyH/lm24MPL3PcAx8JFjcFX+z84?=
 =?iso-8859-1?Q?eGedIPVRgSgrefgzsopycSlHuIu0km6HiE8Mh0GcX/Qe86pj2laOx22FIr?=
 =?iso-8859-1?Q?XdFHVDcvofbGZJsx5tbi7+8uyVA4Ix+KqsSMdy2+XueIoMV4uoVUoOa+i8?=
 =?iso-8859-1?Q?mUpy6buN8XjrlXEF08pgRCcXtpu6bU0cCREVaZB7koP2XCRjF0Kkdh4+iq?=
 =?iso-8859-1?Q?wWhU6I8uDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8954fb-ca30-4825-fd4d-08de652e91c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:42.1225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhKbcZM9fiJ14GOAeY4DoKq9IhYNPRZtnghFhc9iEU4Ouyms43EYat1KXMXeIvVdwsYUnfj1VGDPivaEdeis34RH3bYCaSz8qj9N2+rTypU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

The registers are only 32 bits wide, so we should cast the 64-bit value=0A=
passed in to only be 32 bits wide.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index e20244de2c..9dc71aa3d8 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -363,10 +363,11 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
     uint32_t addr =3D offset >> 2;=0A=
+    uint32_t val32 =3D (uint32_t)value;=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
-    value &=3D ~dw_i3c_ro[addr];=0A=
+    val32 &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
@@ -392,7 +393,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
     default:=0A=
-        s->regs[addr] =3D value;=0A=
+        s->regs[addr] =3D val32;=0A=
         break;=0A=
     }=0A=
 }=0A=
-- =0A=
2.43.0=0A=

