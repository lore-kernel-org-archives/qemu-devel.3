Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCFCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa8BO-0000iB-Qa; Thu, 18 Jun 2026 04:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.bueno@openchip.com>)
 id 1wa8BJ-0000hK-ST; Thu, 18 Jun 2026 04:33:02 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.bueno@openchip.com>)
 id 1wa8BD-0002Lu-TH; Thu, 18 Jun 2026 04:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKx1sLBcanNks8qDFY0WptZ157wlqTZFVvpn2DHZrZ7dZhTXF0TFUDAGmyq9czuyB7jgY/IhwTMrb1+rKm6RE48OJHCh+etFfU4QbgVV6y6ubboPu2AR2jzD2jDOz2PXoJOSnkakBMUJtt8n/NklXdDvjdGw7ZDeNmp44LPPEykoYhMtF321Rc4tq4LGcLKmvY0SmU2+WwVvcw89JIr6Yqjz3wBBnhUY1fvOm1LNWWdKBZZE5+lMYm/uKx9UNh2pMWEiyrFvUZF+Al8Hd+kndZlsjSmOMoz1cPvviA4EI9t/bfJPdNYAf6aWYfYO7cfFg7jP+gjUEN6ue5CrV+qnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFFpXP9ve4AlS8tj+aXM8mg5It2KZVxrY/yxQWvLdg0=;
 b=iI9lmE2MYE1X9lHspSxVlcskdvLmS5oEEQv9YF6r+XwS3au2cRD94C1ATFZZ1etkfpraHWZqJSl8u7CJkhQmxyLikegl9nem0Ja4rSbt0UXwYFEwKU3pTyn7Cj/EvGqjtRINUhpq3kvktu5wv9FYnZNWp+L4QcYd7vddhdUhi4tLxbA++oAdnR+ow65JsGrdoMop74ooxons0VXrpKr0+9fph7MUJ/VBPWZAuLsYo1/k2irlSiNU81Kpg+PVLgfCI0ZASdhGizbtxz9dHgAfi1lGk7u88odFgPbtgywqIfxV1X8RNloGUAn7cH8FO5f2+iRySU6fiM/ZFYrxsbxARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFFpXP9ve4AlS8tj+aXM8mg5It2KZVxrY/yxQWvLdg0=;
 b=S5LkdE1i4QSIps1YzAtSBXfp4yuD3NHsXFzmmj40LvmA6O2rPFpCFQtlVJ+p8Q+JiRRL0PgeK5yWbOp5CSS47YkzP9d33/ddeRYrHvuI2NtVnfuQMH+FBaSBZ2p7V9js0+5iEs0D5+5417uHdzWp9hW5Zrfuw27mf5ym3relxJOUYcpidV9T4cynZl5HFrCLt7GRNXs64CtqY9FMjzDt21SvSNLLUWSnjvkv08XpKveyEmAjXelYJUSpySrErRbpHv0nl+hfpWIuU7gL3foaZo44LJFLFTrzp08IJAPsH9mhQy9RCOt2JBt3OfiUg4gfH3R8dHtP7I6E2BsWJLfsPw==
Received: from AS8P192MB2176.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:639::5)
 by GV2P192MB2592.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 08:32:45 +0000
Received: from AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
 ([fe80::f998:ee7f:add9:9782]) by AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
 ([fe80::f998:ee7f:add9:9782%5]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:32:45 +0000
From: Joel Bueno | OPENCHIP <joel.bueno@openchip.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH] tcg/riscv: raise VLEN limit to the specification's maximum
Thread-Topic: [PATCH] tcg/riscv: raise VLEN limit to the specification's
 maximum
Thread-Index: AQHc/mxtgAzybrtY/kada2VxldkwarZD9MB9
Date: Thu, 18 Jun 2026 08:32:45 +0000
Message-ID: <AS8P192MB2176D336C78894BE13327D57E2E32@AS8P192MB2176.EURP192.PROD.OUTLOOK.COM>
References: <20260617151657.1299840-1-joel.bueno@openchip.com>
In-Reply-To: <20260617151657.1299840-1-joel.bueno@openchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P192MB2176:EE_|GV2P192MB2592:EE_
x-ms-office365-filtering-correlation-id: 3175c250-b105-4a10-7ef5-08decd142be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|10070799003|6133799003|8096899003|56012099006|11063799006|3023799007|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: Y3u/Oj+4qS5nF//4lXpkShM0jXFPWRnqflGNnsLGqAxAVsLxSBDUdjm2OBUjF8b39jNZqSh6NRODW88gSWOj0lCy/9cNd2zVdfVS3dMHeKBb8OqAP4wwmejlXDX3h8738CFrUNV+MBcxTCmigyweMiRcFgel9fzknkIobmTx8ukJnPCD2+Qx6iXmZ3xqPu0ShiBdkxywT6MP+qkq2bFmKzxU2JrUK1lQBvsyNfbO1+rU1PKjRpcCki6pOGa/GUFsavAH9H58KQj2pxXezgjvBHynyYNPl2ZunLPzOYJOiU6KBlUfPjvhwZbGISvYSrQ/Sl1IGHuD6QKWJUoLZzHzBYsKfmUi8blvXlMwf3Bz51b8ZnO2OIwoC2tWTZFPDIEoEPMB8xV6lAksMzYfXhIbw/jXPV41q8MCYGZ0JCul2HNrODT5MTrdbCndj8jWBfmtdlvLU8DNKcjq/W35X7umlL7LF37GtOT37/6RAvBXWGjRw7xCeCOmjognm1jvRxPfkAFcwjlx6xbhZT7+Hb0KYj8llApEKQX1fd7bA+zoyRU5DJR8eYhymhYysAng7y7Fz4iTzFkujqW2FSCaiUyjJlMYTza46LnDqMfenbR8oIuw4qAEBcJQ4N0y49iYKcsGQg0fkb4a0achY4kB/6M8/XXR++7PKmnfyL0tl6ioAWMUY+nwa+eXrs4BuGQI/OHh+bksvs4Q7ZdMlnRUkZ1VaT8M4aXkbzcvww+co/5EJZtKnAJUdKNyhkBCrz7vaQB+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8P192MB2176.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10070799003)(6133799003)(8096899003)(56012099006)(11063799006)(3023799007)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nHcKhPMPWbmhrkUzfA/+cmt2DSTfuyJyLYaSDSDEtjpBKBl+mXAYeOFdw8lD?=
 =?us-ascii?Q?OYIkN5ZwbdlymxneUWN/vzKMfcpbLhzkIMFAVN4tYoXpfd0FUzacGJJi3m/o?=
 =?us-ascii?Q?Db8QnkLsFQfSwIhWabKoC+UaJxbWbqpDeULufBIdzmxW2hhi0MUp0og9hoaq?=
 =?us-ascii?Q?RGtNEb+XJY2GJxiHd4gosWqyYBVEH2z2NyCNRC19F3uQKXFzEx46ZQ9MiXpV?=
 =?us-ascii?Q?tuxXqc7Y/0LBwoJScRykNSyHVv0X/vsBexRiBJm+Qdh/UnOgWWSJBYw9qxOH?=
 =?us-ascii?Q?ojdjW10Tv+SgD99ieTNrNSHan/L+NFxpXePtSD2ALaBPKDvQkldbNeCOMmDU?=
 =?us-ascii?Q?0UH0n0In6Y4b5JhBsm7y3Oq0ZisE3SST1i4uwppcMuBCeixr8L0OJJcJORNI?=
 =?us-ascii?Q?w62BqB4dy69aSOaKCvBK8X2JTXxD/HEzN9lCiArnMIn/50qGHRS7S5EvpcyK?=
 =?us-ascii?Q?D9YdrvaKcKgnKK7zHa/3Auuz+ybnY5XTFj78qD47rPMxlJU60R4VmwBxDaU+?=
 =?us-ascii?Q?dPrLoYqKwZqnFhCB8GE7kZwqLrsCi2+ygFyA9xfHSsBQjnZ+sXz4Vv2nrumq?=
 =?us-ascii?Q?mSF5CzA7aIHqyixmVbzmuofsRh4Bj6AnVxO3HGuo6xc5RG0xFVFWntmi/F3S?=
 =?us-ascii?Q?oQhDIZIq3ncD8r8kKXPDIXZhyse6Q40mkvMBL+8ymbywzqkt3FTXprM922Yv?=
 =?us-ascii?Q?M4ux5JrhKt573CaSFMya9navkK/9N7pDu9PEVCFS9rP9R0PJZqozsTJzPMt5?=
 =?us-ascii?Q?Do9ddZpJZSMAhM+FC7c1JeSC/b3ZW1/CFHW9pWLbFzcR4b0N7P+jMgoGOivd?=
 =?us-ascii?Q?RDTFynuWVvTdcCGjh79j6+DFWyTdkQ2g/goeh1yW4XUr2TLaePSyLEOTtqHz?=
 =?us-ascii?Q?q5ckUhllB/exkB+oEdw3JFE/CZesqa0uFuJSfalnIn/YP0SyXFyy0yRirzaH?=
 =?us-ascii?Q?fqJq1rUbMWmgpJsbJV/QBexbfaez8e9nYfA9N107A/UzruN2lWP7u73VyhJL?=
 =?us-ascii?Q?z33cCeCj2rNRMqtZ5C0OL3ZYGTVCoWF6GdH45HW5rySz982vgLtDUE2Rjzv0?=
 =?us-ascii?Q?+DkvdoMfcVcqiaYyx0ATeV3Kl3qVtoP4YY1oeWqcU/GYuVmxNraLjPLYY1ZR?=
 =?us-ascii?Q?AwpXYmirkGtPKN8V/hBYcR+ZCoJ27kZT6FShrFVcQyyp5eO4LFrKEw7whCN1?=
 =?us-ascii?Q?9cD1TIfBASvVmt33LnLG/UqbGmBHs4lNGJeKvHb+I2Zlg+0ZV0JJYiuyLQ54?=
 =?us-ascii?Q?iNur+oBLCkFFORmhMLdRpht4zJhlsTOXhLlU8l+fHPLSXMw76nVmGlqDLVWC?=
 =?us-ascii?Q?bxJwcwjw1ZIKb2MW530wsvZEEc0PSadE9ea53YqAtdJVxPcA5iVM38WCPHvH?=
 =?us-ascii?Q?zWCQJ3dI8EWUEHb1KNqikKiHSgBA5MIE2lQKeVh8jR2/PEVWuSD+NGj853v9?=
 =?us-ascii?Q?5X/zngnHaMr+g7/cmdYp1FkyHnB9WsqAl0aWMmbVX5nvHdijDwsbvkeiCect?=
 =?us-ascii?Q?SA5TIEHcSxkTRdm7OeWE0qmg2219UvPSSLCdpRtCM/FrGBA6PZSQlH4m+cUI?=
 =?us-ascii?Q?EXg1uWTVJwVkDQyg5q2QQXGaIRW2U0NEVRImUlO3djMkWiiNoyh0Uzzz5bTq?=
 =?us-ascii?Q?bUx7C4Om6kQULpkycvPXcVFNpqBidX+39LVwfWUY5s6q8UQFWGLfgj1tyc5w?=
 =?us-ascii?Q?TFDz22K3g7G6Siaaafzzb3CQacDcUAiF8jW6c6zjyQJNdsmYrQ5xyifJe60K?=
 =?us-ascii?Q?OuRtbAwsJwU8BJXkG7LIYv+4IB0ogqbngFt8HHtM073G4F+bGMl3j/YRNfAL?=
x-ms-exchange-antispam-messagedata-1: kfwyf8jmY5FhXQ==
Content-Type: multipart/alternative;
 boundary="_000_AS8P192MB2176D336C78894BE13327D57E2E32AS8P192MB2176EURP_"
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2176.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3175c250-b105-4a10-7ef5-08decd142be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 08:32:45.1780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmp8RSyf7T92ERPA2MwRUhWfFq9rguT0l7P5LCtdWQ/Os97gZBdoYpYxKjlMgk29QTi24W3cPkklnCGj5My7gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB2592
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=joel.bueno@openchip.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_AS8P192MB2176D336C78894BE13327D57E2E32AS8P192MB2176EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone!

Sorry to bother again but it's the first patch I send out for the TCG subsy=
stem and as a bit of follow up to the patch, I wanted to ask some questions=
 about it:

The biggest thing I feel is a bit clunky is this section of the patch (targ=
et/riscv/vector_helper.c):

         if (flags !=3D NULL) {
+            void *page_host;
             *flags |=3D probe_access_flags(env, adjust_addr(env, addr), cu=
rlen,
                                          access_type, mmu_index, nonfault,
-                                         host, ra);
+                                         &page_host, ra);
         } else {

I basically did this because probe_access_flags would modify the host point=
er and when the actual memory copy would get executed it'd segfault (Becaus=
e now the base address for the vector register file is pointing to the last=
 page) with either vext_continuous_ldst_host or ldst_host (Both use that sp=
ecific pointer).

This was basically done (In part) because on probe_access_full_mmu there's =
logic as to when to discard phost:

int probe_access_full_mmu(...,
void **phost, ...)
{
void *discard_phost;
CPUTLBEntryFull *discard_tlb;

/* privately handle users that don't need full results */
phost =3D phost ? phost : &discard_phost;
pfull =3D pfull ? pfull : &discard_tlb;

...

So I saw it fit as a solution since I didn't want to also pollute the patch=
 (Making the function similar to the _full_mmu counterpart) w/o knowing if =
there's a specific need as to why probe_access_flags doesn't have that logi=
c built-in.

-----

The second thing I also wanted to check with you is that the "heuristic" th=
at I chose to basically delegate to the helper function (When doing vector =
ld/st) was the following:

-    bool use_helper_fn =3D !s->vstart_eq_zero;
+    bool use_helper_fn =3D !s->vstart_eq_zero || ((s->cfg_ptr->vlenb * nf)=
 > 512);

This basically works for us but ideally we should not be using a magic numb=
er. 512 may be a bit too restrictive in this context but we have to be wary=
 that a high(er) number poses the risk of delegating incorrectly to the "un=
rolled" (Can't find a better name for it...)  variant and thus making it as=
sert again. I could not think of a clever way of doing this but perhaps the=
re's a much more intelligent way of doing so?

With all this being said, I also wanted to point out that this patch has be=
en tested using the full llvm-testsuite (Targetting 16k VLEN particularly) =
plus some HPC benches (STREAM, primarly). If anything is needed on this reg=
ard I'll gladly help with.

Sorry for the additional message, thanks for reading and have a nice day.


________________________________
From: Joel Bueno | OPENCHIP <joel.bueno@openchip.com>
Sent: Wednesday, June 17, 2026 5:17 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; qemu-riscv@nongnu.org <q=
emu-riscv@nongnu.org>
Cc: richard.henderson@linaro.org <richard.henderson@linaro.org>; pbonzini@r=
edhat.com <pbonzini@redhat.com>; palmer@dabbelt.com <palmer@dabbelt.com>; a=
listair.francis@wdc.com <alistair.francis@wdc.com>; liwei1518@gmail.com <li=
wei1518@gmail.com>; daniel.barboza@oss.qualcomm.com <daniel.barboza@oss.qua=
lcomm.com>; zhiwei_liu@linux.alibaba.com <zhiwei_liu@linux.alibaba.com>; ch=
ao.liu.zevorn@gmail.com <chao.liu.zevorn@gmail.com>; Joel Bueno | OPENCHIP =
<joel.bueno@openchip.com>
Subject: [PATCH] tcg/riscv: raise VLEN limit to the specification's maximum

From: Joel Bueno <joel.bueno@openchip.com>

The RISC-V V(ector) extension specification allows VLEN up to 65536 bits
(vlenb =3D 8192 bytes).

3 changes are needed to support this:

1. Widen simd_desc SIMD_MAXSZ_BITS from 8 to 10, raising the maxsz
   encoding limit from 2048 to 8200 bytes. This costs 2 data bits
   (22 to 20).

2. Raise RV_VLEN_MAX from 1024 to 65536. This increases the static
   per-CPU vector register file from 4 KB to 256 KB.

3. Widen the vlen CPU property from uint16 to uint32 so that
   vlen=3D65536 can be specified on the command line.

To ensure TCG emits instructions correctly, we, clamp the vl_eq_vlmax TB fl=
ag
so it is never set when the total register group size (vlmax << vsew)
exceeds the simd_desc maxsz limit. This forces the helper-based path for
very large register groups (e.g., VLEN=3D32768 with LMUL=3D4), preventing t=
he
GVEC fast path from silently truncating the operation and zeroing tail
registers.

We also need to fix probe_pages() so that vector ld/st works due to larger
vector register sizes in regards of how many memory pages they span. This
enables larger memory operations to succeed since address calculations can
now properly span more than 2 pages.

To finish off, we add an additional check on trans_rvv.c.inc to properly
decide when to use the helper function or not; this ensures that we never
hit:

./build/qemu-riscv64: ../accel/tcg/translate-all.c:356: tb_gen_code: Assert=
ion `max_insns > 1' failed;

On high VLEN configurations due to the amount of ld/st it generates (Where =
TCG
tries to halve the amount of emitted instructions so the generated machine =
code
fits on the buffer but fails to do so when a single vector load/store opcod=
e fills
the entire buffer (Or overruns it...!).

Signed-off-by: joel.bueno <joel.bueno@openchip.com>
---
 include/tcg/tcg-gvec-desc.h             |  7 +++++--
 target/riscv/cpu.c                      | 12 ++++++------
 target/riscv/cpu.h                      |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  3 ++-
 target/riscv/tcg/tcg-cpu.c              |  4 +++-
 target/riscv/vector_helper.c            |  8 +++++---
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 704bd86454..6c277fedad 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -21,7 +21,7 @@
 #define TCG_TCG_GVEC_DESC_H

 /*
- * This configuration allows MAXSZ to represent 2048 bytes, and
+ * This configuration allows MAXSZ to represent up to 8200 bytes, and
  * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
  *
  * Encode this with:
@@ -29,9 +29,12 @@
  *   2       -> maxsz
  *
  * This steals the input that would otherwise map to 24 to match maxsz.
+ *
+ * MAXSZ uses 10 bits to support RISC-V VLEN up to 65536 bits
+ * (vlenb =3D 8192 bytes).  This leaves 20 DATA bits (was 22).
  */
 #define SIMD_MAXSZ_SHIFT   0
-#define SIMD_MAXSZ_BITS    8
+#define SIMD_MAXSZ_BITS    10

 #define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
 #define SIMD_OPRSZ_BITS    2
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa497e5e8a..b5c2139810 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1637,10 +1637,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
                          void *opaque, Error **errp)
 {
     RISCVCPU *cpu =3D RISCV_CPU(obj);
-    uint16_t cpu_vlen =3D cpu->cfg.vlenb << 3;
-    uint16_t value;
+    uint32_t cpu_vlen =3D cpu->cfg.vlenb << 3;
+    uint32_t value;

-    if (!visit_type_uint16(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }

@@ -1663,13 +1663,13 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
 static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    uint16_t value =3D RISCV_CPU(obj)->cfg.vlenb << 3;
+    uint32_t value =3D RISCV_CPU(obj)->cfg.vlenb << 3;

-    visit_type_uint16(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }

 static const PropertyInfo prop_vlen =3D {
-    .type =3D "uint16",
+    .type =3D "uint32",
     .description =3D "vlen",
     .get =3D prop_vlen_get,
     .set =3D prop_vlen_set,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7582874c35..5796aaf04b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -186,7 +186,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied=
_rules[];
 #include "pmp.h"
 #endif

-#define RV_VLEN_MAX 1024
+#define RV_VLEN_MAX 65536
 #define RV_MAX_MHPMEVENTS 32
 #define RV_MAX_MHPMCOUNTERS 32
 #define RV_MAX_TRIGGERS 2
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_tr=
ans/trans_rvv.c.inc
index 23262b1d03..f34fea3407 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t r=
s1, uint32_t nf,
      * Update vstart with the number of processed elements.
      * Use the helper function if either:
      * - vstart is not 0.
+     * - total transfer size potentially exceeding emittable buffer length=
.
      */

-    bool use_helper_fn =3D !s->vstart_eq_zero;
+    bool use_helper_fn =3D !s->vstart_eq_zero || ((s->cfg_ptr->vlenb * nf)=
 > 512);

     if (!use_helper_fn) {
         uint32_t size =3D s->cfg_ptr->vlenb * nf;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b73e3e9dd4..021f9c60bd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -33,6 +33,7 @@
 #include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
+#include "tcg/tcg-gvec-desc.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/boards.h"
 #include "system/tcg.h"
@@ -125,7 +126,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)
         uint32_t vlmax =3D vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
         uint32_t maxsz =3D vlmax << vsew;
         bool vl_eq_vlmax =3D (env->vstart =3D=3D 0) && (vlmax =3D=3D env->=
vl) &&
-                           (maxsz >=3D 8);
+                           (maxsz >=3D 8) &&
+                           (maxsz <=3D (8 << SIMD_MAXSZ_BITS));
         flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
         flags =3D FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
         flags =3D FIELD_DP32(flags, TB_FLAGS, LMUL,
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e321ca2616..d62ae72349 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -176,13 +176,15 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,
                      mmu_index, ra);
     }

-    if (len > curlen) {
+    while (len > curlen) {
         addr +=3D curlen;
-        curlen =3D len - curlen;
+        len -=3D curlen;
+        curlen =3D MIN(-(addr | TARGET_PAGE_MASK), len);
         if (flags !=3D NULL) {
+            void *page_host;
             *flags |=3D probe_access_flags(env, adjust_addr(env, addr), cu=
rlen,
                                          access_type, mmu_index, nonfault,
-                                         host, ra);
+                                         &page_host, ra);
         } else {
             probe_access(env, adjust_addr(env, addr), curlen, access_type,
                          mmu_index, ra);
--
2.43.0


--_000_AS8P192MB2176D336C78894BE13327D57E2E32AS8P192MB2176EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello everyone!</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry to bother again but it's the first patch I send out for the TCG subsy=
stem and as a bit of follow up to the patch, I wanted to ask some questions=
 about it:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The biggest thing I feel is a bit clunky is this section of the patch (targ=
et/riscv/vector_helper.c):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *p=
age_host;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *f=
lags |=3D probe_access_flags(env, adjust_addr(env, addr), curlen,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; access_type, mmu_index, nonfault,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; host, ra);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;page_host, ra);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I basically did this because probe_access_flags would modify the host point=
er and when the actual memory copy would get executed it'd segfault (Becaus=
e now the base address for the vector register file is pointing to the last=
 page) with either vext_continuous_ldst_host
 or ldst_host (Both use that specific pointer).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This was basically done (In part) because on probe_access_full_mmu there's =
logic as to when to discard phost:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
int probe_access_full_mmu(...,</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
void **phost, ...)</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
{</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
void *discard_phost;</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
CPUTLBEntryFull&nbsp;*discard_tlb;</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
/* privately handle users that don't need full results */</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
phost =3D phost ? phost : &amp;discard_phost;</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
pfull =3D pfull ? pfull : &amp;discard_tlb;</div>
<div style=3D"line-height: 19px; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
...</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So I saw it fit as a solution since I didn't want to also pollute the patch=
 (Making the function similar to the _full_mmu counterpart) w/o knowing if =
there's a specific need as to why probe_access_flags doesn't have that logi=
c built-in.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-----</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The second thing I also wanted to check with you is that the &quot;heuristi=
c&quot; that I chose to basically delegate to the helper function (When doi=
ng vector ld/st) was the following:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
- &nbsp; &nbsp;bool use_helper_fn =3D !s-&gt;vstart_eq_zero;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
+ &nbsp; &nbsp;bool use_helper_fn =3D !s-&gt;vstart_eq_zero || ((s-&gt;cfg_=
ptr-&gt;vlenb * nf) &gt; 512);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This basically works for us but ideally we should not be using a magic numb=
er. 512 may be a bit too restrictive in this context but we have to be wary=
 that a high(er) number poses the risk of delegating incorrectly to the &qu=
ot;unrolled&quot; (Can't find a better name
 for it...)&nbsp; variant and thus making it assert again. I could not thin=
k of a clever way of doing this but perhaps there's a much more intelligent=
 way of doing so?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
With all this being said, I also wanted to point out that this patch has be=
en tested using the full llvm-testsuite (Targetting 16k VLEN particularly) =
plus some HPC benches (STREAM, primarly). If anything is needed on this reg=
ard I'll gladly help with.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry for the additional message, thanks for reading and have a nice day.</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joel Bueno | OPENCHIP=
 &lt;joel.bueno@openchip.com&gt;<br>
<b>Sent:</b> Wednesday, June 17, 2026 5:17 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; qemu-riscv@=
nongnu.org &lt;qemu-riscv@nongnu.org&gt;<br>
<b>Cc:</b> richard.henderson@linaro.org &lt;richard.henderson@linaro.org&gt=
;; pbonzini@redhat.com &lt;pbonzini@redhat.com&gt;; palmer@dabbelt.com &lt;=
palmer@dabbelt.com&gt;; alistair.francis@wdc.com &lt;alistair.francis@wdc.c=
om&gt;; liwei1518@gmail.com &lt;liwei1518@gmail.com&gt;; daniel.barboza@oss=
.qualcomm.com
 &lt;daniel.barboza@oss.qualcomm.com&gt;; zhiwei_liu@linux.alibaba.com &lt;=
zhiwei_liu@linux.alibaba.com&gt;; chao.liu.zevorn@gmail.com &lt;chao.liu.ze=
vorn@gmail.com&gt;; Joel Bueno | OPENCHIP &lt;joel.bueno@openchip.com&gt;<b=
r>
<b>Subject:</b> [PATCH] tcg/riscv: raise VLEN limit to the specification's =
maximum</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Joel Bueno &lt;joel.bueno@openchip.com&gt;<b=
r>
<br>
The RISC-V V(ector) extension specification allows VLEN up to 65536 bits<br=
>
(vlenb =3D 8192 bytes).<br>
<br>
3 changes are needed to support this:<br>
<br>
1. Widen simd_desc SIMD_MAXSZ_BITS from 8 to 10, raising the maxsz<br>
&nbsp;&nbsp; encoding limit from 2048 to 8200 bytes. This costs 2 data bits=
<br>
&nbsp;&nbsp; (22 to 20).<br>
<br>
2. Raise RV_VLEN_MAX from 1024 to 65536. This increases the static<br>
&nbsp;&nbsp; per-CPU vector register file from 4 KB to 256 KB.<br>
<br>
3. Widen the vlen CPU property from uint16 to uint32 so that<br>
&nbsp;&nbsp; vlen=3D65536 can be specified on the command line.<br>
<br>
To ensure TCG emits instructions correctly, we, clamp the vl_eq_vlmax TB fl=
ag<br>
so it is never set when the total register group size (vlmax &lt;&lt; vsew)=
<br>
exceeds the simd_desc maxsz limit. This forces the helper-based path for<br=
>
very large register groups (e.g., VLEN=3D32768 with LMUL=3D4), preventing t=
he<br>
GVEC fast path from silently truncating the operation and zeroing tail<br>
registers.<br>
<br>
We also need to fix probe_pages() so that vector ld/st works due to larger<=
br>
vector register sizes in regards of how many memory pages they span. This<b=
r>
enables larger memory operations to succeed since address calculations can<=
br>
now properly span more than 2 pages.<br>
<br>
To finish off, we add an additional check on trans_rvv.c.inc to properly<br=
>
decide when to use the helper function or not; this ensures that we never<b=
r>
hit:<br>
<br>
./build/qemu-riscv64: ../accel/tcg/translate-all.c:356: tb_gen_code: Assert=
ion `max_insns &gt; 1' failed;<br>
<br>
On high VLEN configurations due to the amount of ld/st it generates (Where =
TCG<br>
tries to halve the amount of emitted instructions so the generated machine =
code<br>
fits on the buffer but fails to do so when a single vector load/store opcod=
e fills<br>
the entire buffer (Or overruns it...!).<br>
<br>
Signed-off-by: joel.bueno &lt;joel.bueno@openchip.com&gt;<br>
---<br>
&nbsp;include/tcg/tcg-gvec-desc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +++++--<br>
&nbsp;target/riscv/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 12 ++++++------<br>
&nbsp;target/riscv/cpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 2 +-<br>
&nbsp;target/riscv/insn_trans/trans_rvv.c.inc |&nbsp; 3 ++-<br>
&nbsp;target/riscv/tcg/tcg-cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&nbsp;target/riscv/vector_helper.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 +++++---<br>
&nbsp;6 files changed, 22 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h<br>
index 704bd86454..6c277fedad 100644<br>
--- a/include/tcg/tcg-gvec-desc.h<br>
+++ b/include/tcg/tcg-gvec-desc.h<br>
@@ -21,7 +21,7 @@<br>
&nbsp;#define TCG_TCG_GVEC_DESC_H<br>
&nbsp;<br>
&nbsp;/*<br>
- * This configuration allows MAXSZ to represent 2048 bytes, and<br>
+ * This configuration allows MAXSZ to represent up to 8200 bytes, and<br>
&nbsp; * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32=
.<br>
&nbsp; *<br>
&nbsp; * Encode this with:<br>
@@ -29,9 +29,12 @@<br>
&nbsp; *&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; maxsz<br>
&nbsp; *<br>
&nbsp; * This steals the input that would otherwise map to 24 to match maxs=
z.<br>
+ *<br>
+ * MAXSZ uses 10 bits to support RISC-V VLEN up to 65536 bits<br>
+ * (vlenb =3D 8192 bytes).&nbsp; This leaves 20 DATA bits (was 22).<br>
&nbsp; */<br>
&nbsp;#define SIMD_MAXSZ_SHIFT&nbsp;&nbsp; 0<br>
-#define SIMD_MAXSZ_BITS&nbsp;&nbsp;&nbsp; 8<br>
+#define SIMD_MAXSZ_BITS&nbsp;&nbsp;&nbsp; 10<br>
&nbsp;<br>
&nbsp;#define SIMD_OPRSZ_SHIFT&nbsp;&nbsp; (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_B=
ITS)<br>
&nbsp;#define SIMD_OPRSZ_BITS&nbsp;&nbsp;&nbsp; 2<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index fa497e5e8a..b5c2139810 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -1637,10 +1637,10 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 void *opaque, Error **errp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CPU(obj);<br>
-&nbsp;&nbsp;&nbsp; uint16_t cpu_vlen =3D cpu-&gt;cfg.vlenb &lt;&lt; 3;<br>
-&nbsp;&nbsp;&nbsp; uint16_t value;<br>
+&nbsp;&nbsp;&nbsp; uint32_t cpu_vlen =3D cpu-&gt;cfg.vlenb &lt;&lt; 3;<br>
+&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (!visit_type_uint16(v, name, &amp;value, errp)) {<br=
>
+&nbsp;&nbsp;&nbsp; if (!visit_type_uint32(v, name, &amp;value, errp)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1663,13 +1663,13 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,<br>
&nbsp;static void prop_vlen_get(Object *obj, Visitor *v, const char *name,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 void *opaque, Error **errp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; uint16_t value =3D RISCV_CPU(obj)-&gt;cfg.vlenb &lt;&lt=
; 3;<br>
+&nbsp;&nbsp;&nbsp; uint32_t value =3D RISCV_CPU(obj)-&gt;cfg.vlenb &lt;&lt=
; 3;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; visit_type_uint16(v, name, &amp;value, errp);<br>
+&nbsp;&nbsp;&nbsp; visit_type_uint32(v, name, &amp;value, errp);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const PropertyInfo prop_vlen =3D {<br>
-&nbsp;&nbsp;&nbsp; .type =3D &quot;uint16&quot;,<br>
+&nbsp;&nbsp;&nbsp; .type =3D &quot;uint32&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .description =3D &quot;vlen&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .get =3D prop_vlen_get,<br>
&nbsp;&nbsp;&nbsp;&nbsp; .set =3D prop_vlen_set,<br>
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
index 7582874c35..5796aaf04b 100644<br>
--- a/target/riscv/cpu.h<br>
+++ b/target/riscv/cpu.h<br>
@@ -186,7 +186,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied=
_rules[];<br>
&nbsp;#include &quot;pmp.h&quot;<br>
&nbsp;#endif<br>
&nbsp;<br>
-#define RV_VLEN_MAX 1024<br>
+#define RV_VLEN_MAX 65536<br>
&nbsp;#define RV_MAX_MHPMEVENTS 32<br>
&nbsp;#define RV_MAX_MHPMCOUNTERS 32<br>
&nbsp;#define RV_MAX_TRIGGERS 2<br>
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_tr=
ans/trans_rvv.c.inc<br>
index 23262b1d03..f34fea3407 100644<br>
--- a/target/riscv/insn_trans/trans_rvv.c.inc<br>
+++ b/target/riscv/insn_trans/trans_rvv.c.inc<br>
@@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t r=
s1, uint32_t nf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Update vstart with the number of processed=
 elements.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use the helper function if either:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - vstart is not 0.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * - total transfer size potentially exceeding emi=
ttable buffer length.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; bool use_helper_fn =3D !s-&gt;vstart_eq_zero;<br>
+&nbsp;&nbsp;&nbsp; bool use_helper_fn =3D !s-&gt;vstart_eq_zero || ((s-&gt=
;cfg_ptr-&gt;vlenb * nf) &gt; 512);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!use_helper_fn) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D s-&gt;cf=
g_ptr-&gt;vlenb * nf;<br>
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<br>
index b73e3e9dd4..021f9c60bd 100644<br>
--- a/target/riscv/tcg/tcg-cpu.c<br>
+++ b/target/riscv/tcg/tcg-cpu.c<br>
@@ -33,6 +33,7 @@<br>
&nbsp;#include &quot;accel/accel-cpu-target.h&quot;<br>
&nbsp;#include &quot;accel/tcg/cpu-ops.h&quot;<br>
&nbsp;#include &quot;tcg/tcg.h&quot;<br>
+#include &quot;tcg/tcg-gvec-desc.h&quot;<br>
&nbsp;#ifndef CONFIG_USER_ONLY<br>
&nbsp;#include &quot;hw/core/boards.h&quot;<br>
&nbsp;#include &quot;system/tcg.h&quot;<br>
@@ -125,7 +126,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vlmax =3D vext_ge=
t_vlmax(cpu-&gt;cfg.vlenb, vsew, lmul);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t maxsz =3D vlmax &=
lt;&lt; vsew;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vl_eq_vlmax =3D (env-=
&gt;vstart =3D=3D 0) &amp;&amp; (vlmax =3D=3D env-&gt;vl) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (maxsz &gt;=3D 8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (maxsz &gt;=3D 8) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (maxsz &lt;=3D (8 &lt;&lt; SIMD_MAXSZ_BITS));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D FIELD_DP32(flags=
, TB_FLAGS, VILL, env-&gt;vill);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D FIELD_DP32(flags=
, TB_FLAGS, SEW, vsew);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D FIELD_DP32(flags=
, TB_FLAGS, LMUL,<br>
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c<br=
>
index e321ca2616..d62ae72349 100644<br>
--- a/target/riscv/vector_helper.c<br>
+++ b/target/riscv/vector_helper.c<br>
@@ -176,13 +176,15 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmu_index, ra);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (len &gt; curlen) {<br>
+&nbsp;&nbsp;&nbsp; while (len &gt; curlen) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr +=3D curlen;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curlen =3D len - curlen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len -=3D curlen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curlen =3D MIN(-(addr | TARGET_=
PAGE_MASK), len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *p=
age_host;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *f=
lags |=3D probe_access_flags(env, adjust_addr(env, addr), curlen,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; access_type, mmu_index, nonfault,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; host, ra);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;page_host, ra);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr=
obe_access(env, adjust_addr(env, addr), curlen, access_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 mmu_index, ra);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AS8P192MB2176D336C78894BE13327D57E2E32AS8P192MB2176EURP_--

