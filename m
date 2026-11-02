Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806E606A330
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=XQRJrSky
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGK-0007eN-US; Mon, 02 Nov 2026 04:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFN-0007LW-5h; Mon, 02 Nov 2026 04:22:33 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFL-0000W7-Ka; Mon, 02 Nov 2026 04:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnFfrHdPwWx8Y4Sw+qrKCqW1aK7frxtME5hYGM9EKBRdKCPf7LER1NMO5HZFpjviFp7Zw+wzLa3UAHSbAzNff9gN29yb5NLdLqIWExnOik9ba5ME9kKwzTqU7cCAEpHAefz7sk/SeLdXSc4BPdbdXtk0FnC3Wce2pk0xx00nO+FS4UWYDOIB7eGuYiKsELKdLx2rsK5ia/SeOmDu/Lvc5tzdFMupz5tV5NxIIrjp3v+5DlE7SeAuwuqRjZvgPr/pSc+LJYXxs8LTrYeDHFpgF28uhPFKRjhvF6JbmuXZBn74w7kcOR1M/Nyke3LaPhaOL/5KBbmYU2/jPFzLACmduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE60Gd690uM3B6chIq8hl6krRCwchDFsLEoPfV4qomo=;
 b=LsV+cYKjbQ70aqzu8Dzd+5utFdXP/qqETsiAdGjqCj+3lZ1LSIzqX5Oh+VcjVCv8VWEvkBWYdYzSP+acu+ty5F72UXIoM9sZjb7ZKOA6PJpQyLI5ku9Xwdr+FmtzkZEVzjesWkpdVafh/l3/d//Ape+iYyD5Aqq0vLk+eurSpcSIyJcwusrw5wPUl6jQY9ERcMlqxcHwv1vNvF9VbG+jfLcBo6fyCd/rizrzcgP1WL4olOnE4r1iVkuTZU5UYChzsspHI6f601EIjhCy4zfIsX4HkGzV1mxZZpg5ChlGftrlPX5qHcsE1N5kU9P3L7AGwmtzX5YNe7Aqo+qGkhgQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE60Gd690uM3B6chIq8hl6krRCwchDFsLEoPfV4qomo=;
 b=XQRJrSkyp5A6kuYitfEB57Qt+rDgE3EzphhYTbs5IjAsrZVAF1l1H11/BOcbsjw607n0ibJ1Rg9y3LEiuXFqNlMVwQrCAjtTO8ujTIWqJ1P7D+h27itE3A1tPn0XHXpCMxbYthp3BAOLMd1gxJCVKLLZSzP3PifpNLR9f9zHhLXmpU0cw7RFYbpzrvKFnHOK86wU2IDlZI7USjTPkMtM1/MzczKqKlbtUF4daFs1kJdaRz0Y/6vkw9tL860qJDj/rSUB4CcRd3BoNAjLzbi5Y8WiXOxx2bXvb4KU1fP26o6owDV3dYX7fkhxiLU27LvKADD3/G41qcGVBWrODlvnTg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5265.apcprd06.prod.outlook.com (2603:1096:4:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:10 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 04/18] hw/usb/hcd-uhci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v8 04/18] hw/usb/hcd-uhci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaquijhRoEsXvw0qx1kFWlJ7X5g==
Date: Mon, 2 Nov 2026 09:22:08 +0000
Message-ID: <20261102092201.1729245-5-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5265:EE_
x-ms-office365-filtering-correlation-id: b49c7ea6-26db-4e7a-990f-08df38c2c4ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|921020|38070700021|56012099006|261021121427099003|261022113327099003|261026121527099003|261009223027099003;
x-microsoft-antispam-message-info: kz6AOl4PzjbI36rDYqpZnY2m7YaweWoUI0wI2MSTe0iTWC+GOGhsSFounPEd1eLsYwAnXRp6QT7tmqgLDhBQp7sYJMSxRSJl/P6EylsIsYEYjkPEKx9kMWejs+WChtwc3IyFbbxX/F+9MEOYl4BwxeEBw4IsC7hp0QIbOUAT2GsFa99kFMutgg3WvgXU3b3JK/aMwKxL9x8xQX4cdLKYeMH+G1NTal/8AU1ynWRYs08Y0eRqUzQdUFHm6otbu+w4SlGAVu5+7HeEaNj4pOr+e732y7d1hFfGzA1Si1zzFBZjl+paSi68NQj01ZHIAvPe9obKTBADxAmEFwc5LOjH1w3sUItVuTYRH09pDjHyRpWXa4lWqoYqFwAg2BII1rTDooJX5kPOtVLRHLrGb8qRv0a2ib8uoyzJFK1NzgP4tU+hbnxCtU4QJ5BBs/jIFNcar2ZFJJ3SREgUrrejByQZ3FqQ1ODvkOKH0SpqjX9g4pUb3pyhQL6ACCnTruGIwqsiWlDLeWSiAVxl5dscuXbUmOV2V2O8/e5JEANvz/NuMYp7Kspcz1JgiKJ8nqyWpzZtwSYsBtsle9XnBcaiD3nNe3AghhMQxD2plmCpH+irbZBO8drOoCLzNWJ+rBrbomVbtwUj1dHCmJYky5UEl3QQucowthMdtoP5kDRhvodtkrWTvc99oislOWAOSLRfVLz4PbT/RSIADM+iLBIV8UjYF2jFXh5Ly+1GolfYrFc6CNxWK3AZejxHe5pcERPeqF6r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(56012099006)(261021121427099003)(261022113327099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KTwT2wbUYlaFwjzRm9rICONNE83T24EmUZu+qaF1epqdIkT4nsyCnu6z4u?=
 =?iso-8859-1?Q?IoDcieBngK+GucMjQBY/iCC/4AehB17OeP48hGPUosaXZnfLiZbCqy/ZYL?=
 =?iso-8859-1?Q?6wtC2Ud5kuoPHLju0hZr0XG2u0cCtGi6vxKOXETGheV7Masxqd9s6b7AAK?=
 =?iso-8859-1?Q?09lBgWq9hNYmE90mlGJSHkdhFl7sy2C4lmJFGkLUIzvJGhZE+cixcxQtGV?=
 =?iso-8859-1?Q?tCxNr8ekxHOAzhtao41nVuoZilegZ4nxcIZBvG2RgmQhSibAjjVeAbfhH/?=
 =?iso-8859-1?Q?HFbE9Nz/Z9/bugHOhmbYygcPf8WTXBP68CQ4JxMkJc1nIbO+5nkwBIBLie?=
 =?iso-8859-1?Q?GTn06AHEG481jKztsZ8H0YDLIiC3meNjR75oiG6DXzwfvd0UyBzIzKlphS?=
 =?iso-8859-1?Q?84vXXel8W3Uqep8I04j4lQtBaRyClEPzQYIWraOAgcW6hnVVzttyPAQNCV?=
 =?iso-8859-1?Q?6R5rY6kwPT9ktIu+idMpys/gUr1dGogoO4tsBjDiy14gNwgRrLXu+a3oJ8?=
 =?iso-8859-1?Q?1rOtdKd5lrBWmHZiI0RHN0YiDxoQyBcYkIUW8cOSTUlRTXV9gSY/ZbJjEE?=
 =?iso-8859-1?Q?+/435kOpLJLDN1cky4b+4JMDN48wAyHhsU1ZEX0xNELnxXCeQytHsJHdg3?=
 =?iso-8859-1?Q?8uAaXr6YjtLvjGglsaDelkKd8qsL2GcN3Hbg37XMupUwHf5bVjd7PC5R72?=
 =?iso-8859-1?Q?rer9yIYsEp0ZSxcT9bBBQY+MhCqY3ZP6b+XHTyzM0QacvxaL/uYS7uq2WH?=
 =?iso-8859-1?Q?E096NgH4ey1ipE22CYkQ0chv4t4tQdN2bBgDTA3Zixfxx/ofsxEIOIblf6?=
 =?iso-8859-1?Q?pM4pzkZvxyxXMwKXRND8J2oWF+nXwWUY0qB7hwwkPzQBmyiWBw9jSYInOn?=
 =?iso-8859-1?Q?nRkHN5LnQrOmxiryxn8ml3dmCcfk/DXM7eTQxR5vAHbnv8U2gHXnTBAwqo?=
 =?iso-8859-1?Q?eIfCi0f0o4rTbgm/WnixsH8niaPlbu74tCVE2IF3r1hkgM91nf9Y/upUA6?=
 =?iso-8859-1?Q?ag+Ca7KQpYC9slFo78dlbWVs8Bg0s6M8AK9WwEmlFOBAUz2ShyfKvCls1k?=
 =?iso-8859-1?Q?uM1WfaBilGrpakwyuRygrTXGQ/Yy/5caxOc/tl41hvlWv35EQKVMBbWFEt?=
 =?iso-8859-1?Q?EKzKFkYMAj7EmgcbdaY2eUR2g1OqUzzma5ttUF90DO/TY5vqiWLiiVbsvN?=
 =?iso-8859-1?Q?i66v9d8n7iGtzBHVlCKC1JxL/7FiL7oKdeRGnoUOGuvRUJV6g2nXlw20wp?=
 =?iso-8859-1?Q?jLlY1hXyjKbq3y3qkrikvZYX7ZGYmCGZs/w8HZTFHAzm6sKsk4eNPUz0sF?=
 =?iso-8859-1?Q?n4rzKPKqysf6nmW1I35rO1uFiNLQmAfueCThgIztTiiVhxDOVXXV3+hs8A?=
 =?iso-8859-1?Q?eoLX+OIzVwGrZNgJBM0gbHkMyf7DQ36G/OE9Eezewy7PmZxsXefcQQ79fe?=
 =?iso-8859-1?Q?4tWt711uklhOSaRtLEVyjh6PkjHaJL27DHpoxpOxnzPVqzztYTklwQHHW+?=
 =?iso-8859-1?Q?RBcuyPwAJ+6DnBUKdhj4UDFRa8lfV8rHPCM6EhgYsazlJf1X77of3J7stn?=
 =?iso-8859-1?Q?s/sFRz1/OuTg2cMqYOfhV1sTwlS9asrl8CvQacmx6EhnLcGnk5685Ehduf?=
 =?iso-8859-1?Q?dJQ6zfAq/DAXnF8P1Kg8uuQcP/HS8zzdrFnS4enY+cEaX/QJGsDWl3H0Kr?=
 =?iso-8859-1?Q?mAcpk6I+DAEKnpncz3sLA8WkUG8aZddFBpUlHl7vDnL4q5LQD8b47VMeB+?=
 =?iso-8859-1?Q?Sjy9MKuQXQmzvyaYpjkUWzVlVxBExZYBT7PUIjuKcr/N9FqNj2iNFrfqTs?=
 =?iso-8859-1?Q?xYpxFes/Dw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T26Jhc52y+vZhkfPPHQRZg+ajmrG+JqMVzeP7Kn8iTI3+RbmA33CceHIkTzRSX/UvA8i/GT0WzwM0n1s4WzH+SZj37u76MFomBOuZ+w/nKwFbNXpFlLt1jxykWGyT4ACO6uBsCidil2uRNSS3VKQcit+VjK6grGOo0w8vNoYziBLdSK0naT/5UWAao7b/5778ViNna209cDW4PPR0ct3iDZXMigyVymozt0HRJYZiFxdzhim/nFaCSmaj5ZRTz61cLxxlekiH3dW+huXfkoWxI3xLbNF6LJrP58hnF8o/f0mJvSYVFoP6pnAtQZTcktBfRoJ2EJv3AoeLRHtgz3tKg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49c7ea6-26db-4e7a-990f-08df38c2c4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:08.7727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zqZA4Fk7xR6O5nYc40QpiG+pjjYwCVp3XWWlHn65j+V9XrPJHspshqxW0/SWYK7jxsAcepVx3AmwEoA79iGLXg87pzauQ8qCao7qIBDIBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5265
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older=0A=
machine type keeps the hub it has today and a guest saved by an older=0A=
QEMU still loads.=0A=
=0A=
A companion UHCI adds its ports to the EHCI bus instead of making one,=0A=
so there the EHCI property decides. Both property lists still define=0A=
auto-hub, because hw_compat_11_1 names pci-uhci-usb, and QEMU stops=0A=
when a global names a property the device does not have.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-uhci.h | 1 +=0A=
 hw/core/machine.c | 1 +=0A=
 hw/usb/hcd-uhci.c | 3 +++=0A=
 3 files changed, 5 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h=0A=
index 3154837f1d..06433ce3de 100644=0A=
--- a/hw/usb/hcd-uhci.h=0A=
+++ b/hw/usb/hcd-uhci.h=0A=
@@ -72,6 +72,7 @@ typedef struct UHCIState {=0A=
     char *masterbus;=0A=
     uint32_t firstport;=0A=
     uint32_t maxframes;=0A=
+    bool auto_hub;=0A=
 } UHCIState;=0A=
 =0A=
 #define TYPE_UHCI "pci-uhci-usb"=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 0103038cad..f79337e7d7 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -46,6 +46,7 @@ GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "auto-hub", "on" },=0A=
     { "pci-ehci-usb", "auto-hub", "on" },=0A=
     { "base-xhci", "auto-hub", "on" },=0A=
+    { "pci-uhci-usb", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c=0A=
index a7b9fe1317..36d4076c25 100644=0A=
--- a/hw/usb/hcd-uhci.c=0A=
+++ b/hw/usb/hcd-uhci.c=0A=
@@ -1213,6 +1213,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **=
errp)=0A=
         }=0A=
     } else {=0A=
         usb_bus_new(&s->bus, sizeof(s->bus), &uhci_bus_ops, DEVICE(dev));=
=0A=
+        s->bus.auto_hub =3D s->auto_hub;=0A=
         for (i =3D 0; i < UHCI_PORTS; i++) {=0A=
             usb_register_port(&s->bus, &s->ports[i].port, s, i, &uhci_port=
_ops,=0A=
                               USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);=
=0A=
@@ -1260,10 +1261,12 @@ static const Property uhci_properties_companion[] =
=3D {=0A=
     DEFINE_PROP_UINT32("firstport", UHCIState, firstport, 0),=0A=
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),=0A=
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),=0A=
+    DEFINE_PROP_BOOL("auto-hub", UHCIState, auto_hub, false),=0A=
 };=0A=
 static const Property uhci_properties_standalone[] =3D {=0A=
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),=0A=
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),=0A=
+    DEFINE_PROP_BOOL("auto-hub", UHCIState, auto_hub, false),=0A=
 };=0A=
 =0A=
 static void uhci_class_init(ObjectClass *klass, const void *data)=0A=
-- =0A=
2.43.0=0A=

