Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D38C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfp-0004BA-Bt; Fri, 25 Apr 2025 10:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl5-0001eP-Ki
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:19 -0400
Received: from mail-vi1eur05on20702.outbound.protection.outlook.com
 ([2a01:111:f403:2613::702]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl3-0001Mx-MH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k28O38k9e67SvZyHkbakPUbdmssvB0jA8zgON0JDi13seYBcCfxEqV3x+ssqSen0VqnQ+GGkQq/K5gG0kWhnLWUsP92wXrcy6+6b/E582hjWCQJ92sazHyHTedJpgU8/6d/MB8aUcDKikfbMVseqQS5ssoYLipYIovLk0EAUs5IVe07im6VeDdMSgtbtsPk87qRY49wZR6PAMu/c9wKjCGeXgHwCPXc04vTXibpSY3kURxcY+CWNJrnxYlyAWYnOzNBeZrXQHeSjm8wIkitjBrqTbIkxQuj15WUHs7lilX15bDqH87u9+lVQechgtpETgF1jIXUsJ1mstjqO68DOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FbZl7E7MGpP6O9uTPS0ZduTlFeAzR4/SYRIyPDbsQ0=;
 b=CILiqpSxsvZU6e9SaOne+QdttEQmUKbpEuHPUwoP7qPfiKrF9/U9g+LfoW5FDrwcnE5ZYoOIQt8U5Ph4tqEeYwDC3fZc9aZUsKl9SgyQpaE6Bhb+PSDBrRxdKYZtld8xturhjGi8l5YpbzangzobHd/U1bwJ7sWTgz9WObxqlNJGrLYinVLUQD0P06fBEIKoIeoeu2kOvFY1XrVhCZBLYZoESYREW9k29FS/csqeF4NVVh5fQdErrK+WwsJQdUoxu1VTYBjZDN3R2UFHfmB4Uiy168qB7iCUG0RN/31+mJzYIGP7MRnIK54e7TmDZVJGkYNmXAJWKzFupa9HPHt73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FbZl7E7MGpP6O9uTPS0ZduTlFeAzR4/SYRIyPDbsQ0=;
 b=ODGeInHKhOlFEV7stwsXkJkksqxFz1n9VctwS5OBn6RvUnSsKnR1Un42Ah0vEb6aUbESKu2IuwHp1EK4l3NUtnx0nBoPclGxouOFVkBA6oyFv8YKwfRRrWpTrzaQKGmyhIFbUEKdvNXKdcjvXa/WyD7wGD57g8wOdBZ0y8MAcgWd2fnaitR6Hm/MOSfKtcSi0D3DPxCpnFmY4ISQKebL3M3P3zj9Ez2G5xR95af5NmHYh83RXOYQw1Qdo/Ql6VgxmTyJEFvgZ4SKY3Ph3bbnAxi3NdqulWlKNwpgT/I5fKHlWEXk45YsKXM30C9FvhXZ3816tBn970DGWtgGNMmzsg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3713.eurprd09.prod.outlook.com (2603:10a6:208:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 12:01:47 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:47 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 9/9] hw/riscv: Add a network device e1000e to the boston-aia
Thread-Topic: [PATCH 9/9] hw/riscv: Add a network device e1000e to the
 boston-aia
Thread-Index: AQHbtdnR2nq5Co130kOgqDZdZa37gg==
Date: Fri, 25 Apr 2025 12:01:47 +0000
Message-ID: <20250425115912.912889-10-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3713:EE_
x-ms-office365-filtering-correlation-id: e0756760-e119-450a-b398-08dd83f0f4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d03+uGaeVlHlk0MTtaiGY1GJIDF1ayNmhDDbNSJ/kw8Kwh/NgRuGpoasq2?=
 =?iso-8859-1?Q?I3GYl4l6ZFjitRD4NimnOl/6QQ0nZtOl59Dk6CQprlIkeloy8jT5PTF151?=
 =?iso-8859-1?Q?Un+Ef8fBSkCGRusvMMcqra6lJ+k0zkNUKHivivhpMf+nF4GdVXZu+XaKd4?=
 =?iso-8859-1?Q?LCaFO5CduuSIdGLl9Qdmlnd6Kw3t2Jp6PtM1ON5DrElA7VQfGDZ/gNkUoa?=
 =?iso-8859-1?Q?6bpdQHIm160Kix/tnLG9hik3AeuCeecu+Ajm05ePM+jZYrEEyBzzQk0qdp?=
 =?iso-8859-1?Q?0yAq+g8Ldn3UwoAtCcpJu2E0gL6NkqFT1UqF2SrL1PiHmvStQyqH1qliXl?=
 =?iso-8859-1?Q?Xzg7IE1kZ5YhHxwhvs25EuqXu4lJg+P2pP/cPIvPDMnSATFPCRCYEFATYT?=
 =?iso-8859-1?Q?vn+lIzwfHOIyec3UJPl4nurEU/vhv2fNb6q/r4AYpLn/gM4W1tgjCwRJt4?=
 =?iso-8859-1?Q?m2lSR3f2h23f7s2/D58ya5PPvrdAj5HVPgmjqHmC8pOxF5Rs9hNyAzU7Zj?=
 =?iso-8859-1?Q?JzWILhGP3qk/LyW8hqOw1kkPlsdqR4keR6ktkwHI71/4Oc3WqbULF6ZaIy?=
 =?iso-8859-1?Q?t9P1DmBLBD/BWyEUq+zuNWuI8wwKmHi50lLtohly3fA8ksdTv5bKeXh6Ie?=
 =?iso-8859-1?Q?9sn4FLvUOOEh3sDEbazIzYnQJsF/baqpqF2lUHxOIA4mDfWfhcllZfEdoG?=
 =?iso-8859-1?Q?stkrjr8XId3CHwW+oHU49nMbKm5lTFHfaKTZ5SyLwBehySYpKk3eY1hyOd?=
 =?iso-8859-1?Q?+qP1vQky3FZ003aEgibc2WhWN1iKaV2p/5fo8rKGRvi887QJ2AlCaydgGI?=
 =?iso-8859-1?Q?KO/BurHuUCcYY5QRoVi2Yr1BPOAHwMh0V8MlSMJxbmNNZ+dEwhHO8w8gO2?=
 =?iso-8859-1?Q?XTwB0RAihKRTzR5YCsF48UsrUkcH4okkFsQrBc+EWmqwggVygKVKfN0tAW?=
 =?iso-8859-1?Q?uIJCJHvHvdRuvjtRGzTXqPsNJ0t7IVoOQg289CpRUXuVYw5/aB12K2+WLb?=
 =?iso-8859-1?Q?yyWpdF9ZGHb2M9HJqIuPQ5BmQnOvxyPy+MQLp5iReCqqa52qoQD5k1c7UH?=
 =?iso-8859-1?Q?SLGyexmVfxUgRpMApOG0EcEBorkx+L0ix4boFai9f/p6zHb/fLZIkFnfrq?=
 =?iso-8859-1?Q?H5OXCNT5bngIeDVZQs5gMGQRR7p8s0ZRuJ26UCcn9OilhZd8UsiWKbkFap?=
 =?iso-8859-1?Q?JWurd8yLLx+kaHscxGG2EyFHQXJFyB2EAzW4WL5OtCJ4V212qGJy6inz8i?=
 =?iso-8859-1?Q?hDXmVP/QzFZo7Ff4qcAC1fgZ3k8LfJG1iOpvAWM8i4jU5Yz0nRVqaLSvwL?=
 =?iso-8859-1?Q?oWtEYdK7RHiAGA8g4RjnBd0sUrnMfo5ovw0HFQfjmbEM0vf61L4TJ4kTjP?=
 =?iso-8859-1?Q?mAtvoWNbN52GtLO4gEH6cYEkeOWBoXieht97F5gfmlLLbWsiOcobzymbwO?=
 =?iso-8859-1?Q?vAYnH9jcuBlB3TuB4ak4hBBjPmubsdLdPiKmIrbaCB9MLxn+onoRVlXdsp?=
 =?iso-8859-1?Q?QbWjGgNkJvn3l5K73qDsUOnpIHRCt0xFrB5lFNpMmPFOw9Ef1wT8wJ2Xu+?=
 =?iso-8859-1?Q?vtMG108=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VH++/s02RGGZmbOKNlUUbimlc59XBKRAjsbndEqbDpHwarPzQjyVOItP0U?=
 =?iso-8859-1?Q?7wnRJBse3l/F+yEeBhzI3/CwL4/YtV4pPFYQyYdJy0o/ogB0udGkzdUTRH?=
 =?iso-8859-1?Q?rhxkqRbnA8Ua2DlOjSa46jlnwFb8AgIFMxjGeJNS/LZjAZQk3krsF5QOA9?=
 =?iso-8859-1?Q?evDawxLgoO2YcbThqtv5xoOBWa73mfMmlhNewUSUtZPflS3gdcdiZ0yfHm?=
 =?iso-8859-1?Q?kxLC5RHgfolICGyI7auDyNK4N/lxhT8Gikdz+Y831WdKsWmV0MEIdOjDr3?=
 =?iso-8859-1?Q?kJl77SJk6o3rxibLW+ZCR3k1JOiwhkBWVLjmNs+JuDZ3EJazU2MTWJam3R?=
 =?iso-8859-1?Q?ZJQuR2Nh7fDyEn2q6E2Y2riblZDLt6rApsFH67dj23ODqe3FIllOhUnEL1?=
 =?iso-8859-1?Q?yo0+ldZSaWyW8UGNC2SVgZz5i9bQ+z5OTI7hazypKAXJqtDmNRSbo7xBYx?=
 =?iso-8859-1?Q?F9e70JaFh+f45erth1dHHeL4kV4lKBgzGVPj8fwqoYQodZe2SCyTUcBbOa?=
 =?iso-8859-1?Q?YvYHxMPWm33RsBVHBvebpfihpYpE/ajQ8BUDeYJ01So7OLhMJP9AV7u4xd?=
 =?iso-8859-1?Q?onMVJu7aYPM305q89oBaOL96SK5RKAsNoutv3opAXYW+XtZt8vBX5XadTY?=
 =?iso-8859-1?Q?PVZ58bmYJKQ0gDE3XwtQhBA5rqTZHSuavz055jRG8QQeZa681ZtaWcVXmz?=
 =?iso-8859-1?Q?6YzEZJM1eBroZrqmsBWN9OoQcq5cLjrXRC/Qtiunoh7KatbT1TLUzL7q32?=
 =?iso-8859-1?Q?2T+RePsDls+JDVJyj7L3Sjj4tBpjNEzDOhU1abqG5Ev2uwPvrM6KjlpA+C?=
 =?iso-8859-1?Q?Bd8M8W2hAsju6sDlAr/akp/kppdCaGmwbiJRIXoP3x2njlX0R/Wd7oa6Sk?=
 =?iso-8859-1?Q?9ngPaiqKIytNDuJk8QnEIgRg8wbbxHU7f+B6d6epNmzNJHTCoepOGwVKaL?=
 =?iso-8859-1?Q?I/WvjoVstC8d84VMLvVl71sI36EYqmHBp6aEujHf7GFGMMskxlkTDHPDXD?=
 =?iso-8859-1?Q?d64mWQ59feR/fKAfcAmmyNTbsTRcWx/6k2+r1YST9T+TjzQE3ISMSuOydn?=
 =?iso-8859-1?Q?58HKh9+eHgttUVwknCLzk6A0lkLyQXFYNckWNApcDcixUtAT/Fi+C9VVLZ?=
 =?iso-8859-1?Q?/P/EanY4ijAm2fT24aV9F7rcUk0SxFGseVwFIKCPUV9dYyAHM4INrp6ksy?=
 =?iso-8859-1?Q?1oJqvEzUWjEiFxFj5sLPLO5IadZQrVnaLANWdT1nlxOH/FgQZUA2pwx0Fe?=
 =?iso-8859-1?Q?E4koU4vCmavvNc6Vo5tZZ3i0/At73UMhsgxMt7FZFzD49IqW0QD+JJDtPO?=
 =?iso-8859-1?Q?YFmJdHcJ0YMtXNO5N3aK1k2WQHBQdzxySbb7nmRUP8UgedguxRVVeBVLU1?=
 =?iso-8859-1?Q?oo3auaRbO05UVqOe7Ff24ot7wR+gO/4ZaFGHyvZ04uXTPu+W9mydhPLiGP?=
 =?iso-8859-1?Q?zpmNy2nN7WfCwL8duveMBqzBFNYFMwkpEfOmU8FAFHN9gKhk9wppSUvy99?=
 =?iso-8859-1?Q?nENd3Q1pxDC9TFPpHqh+yeLqKk/no/knICfaekPB+MGXNyCQsvZrqvYHkQ?=
 =?iso-8859-1?Q?p9FQ1Djrcvjv9lIcViS6cO6QNW74uM8DsmUoW+4y6LiXNDpgvxV6W/+SGP?=
 =?iso-8859-1?Q?02HMoYCFDaquj6Y40EPGsjZ9jUOa3lbcGFp2dtdwHUKUxIu27m3zLBn0T4?=
 =?iso-8859-1?Q?ta9lGePDIFrxnaZhM04=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0756760-e119-450a-b398-08dd83f0f4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:47.2062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gt6dgBjJ765TlW3ts8chqXfh+dXCzKoZAYl6n6ki2p+JMeZweDtSZL2TKBRHrzrDj8aSV+/yoFnJCUmei0HlyW3625T/VrPKY4/Fhkl5ZjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3713
Received-SPF: pass client-ip=2a01:111:f403:2613::702;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

Add a network device e1000e to the boston-aia board model.
There is no pch_gbe emulation, so we add e1000e in slot 0 func 1,
instead. We need to pass func to call pci_parse_devaddr to find
out slot and func.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/pci/pci.c          | 23 ++++++++++++-----------
 hw/riscv/boston-aia.c |  5 +++++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2844ec5556..9748acda09 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -980,16 +980,15 @@ static int pci_parse_devaddr(const char *addr, int *d=
omp, int *busp,
=20
     slot =3D val;
=20
-    if (funcp !=3D NULL) {
-        if (*e !=3D '.')
-            return -1;
-
-        p =3D e + 1;
-        val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p)
-            return -1;
+    if (funcp !=3D NULL && *e !=3D 0) {
+      if (*e !=3D '.')
+        return -1;
+      p =3D e + 1;
+      val =3D strtoul(p, &e, 16);
+      if (e =3D=3D p)
+        return -1;
=20
-        func =3D val;
+      func =3D val;
     }
=20
     /* if funcp =3D=3D NULL func is 0 */
@@ -2039,13 +2038,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const ch=
ar *model,
     int dom, busnr, devfn;
     PCIDevice *pci_dev;
     unsigned slot;
+
     PCIBus *bus;
=20
     if (!nd) {
         return false;
     }
=20
-    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) =
< 0) {
+    unsigned func;
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func)=
 < 0) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, model);
         exit(1);
@@ -2056,7 +2057,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char=
 *model,
         exit(1);
     }
=20
-    devfn =3D PCI_DEVFN(slot, 0);
+    devfn =3D PCI_DEVFN(slot, func);
=20
     bus =3D pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index e075dca33a..2615b41a48 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -432,6 +432,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

