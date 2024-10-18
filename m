Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84C6D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mt8-0008LZ-MJ; Fri, 18 Oct 2024 09:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mt7-0008LQ-Bl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:29 -0400
Received: from mail-db8eur05on2072a.outbound.protection.outlook.com
 ([2a01:111:f403:2614::72a]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mt4-0005an-Px
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDa/Z4LVPHfoZx2oebpbJhsgR/8CSdvZaHYASq3FfziCh9CaioA9nU/k+OSurNgbOaWiOybmxQ0HtJBbz8cGa/1IH+hFxXKHAvkjR7wOSLESC7/EHVv7cvjPCytqQZlwhQAJHLGQqfN7p0qRSCrLO4VO1tz36xDcIHOivHOZAsaoNSeV0sEoZQNNBhVlP73reKCQ2g0ybqca0g6zur5O8GxJMK6qzkm523kuz40GtIT6uQpORG73LPXVkLjfJWsVm3cSZrq5O+ZjAms6H+zjvZynpTW7tqYCgzDLN8jCBCWLhmi7w0euKZzAZuN/u/FtHFqb7njNXk2jaqzD9ISCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEmKwWCGcmpH14NswYF3OEdWGiRmw06OjqX/pb8ejko=;
 b=XLW3AOHv2de47C2pbs4rDJxXX9ZhR/hNOEAu0CGPiHdLWbB2IlIve28XOrIGF2HQNo3TnGH03tgBuxS81RIpvutPS4FunVKNeoStLl0K704dA0AZPtSk9cOEIKiVuv01mS282xF7dj311MX2mv38xU9WI3jCNIianh1Vhknbo3IkQ2051YafLJyCR58kfC53JDFEg9RkagOhyd5GVjUQHl2ktU80rDs59MgkdL6qiyWBV2DShWAAfVnNWuLPfsW6vICYBL23UuEf0hvsYL4IA9j3Q0J31AUiPhCHYgx561a2CdUITkq36/Vfmr6bb9eTR9zS+FI4W6iznNUHkE0zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEmKwWCGcmpH14NswYF3OEdWGiRmw06OjqX/pb8ejko=;
 b=VhKzAEiHNx8XfLviQJkZ5zLPYp8loD2jzPMyfCtv+7ZBawIet7QKIOvp1NS8EGhO7HAvvc/VmDhPGXcZiVzrEQyFrkv2QlPQoigeWc6c+K9xZIFRzjHzAUpfKYVkGDA9x5pVBtiXJiv1i1/idgb/O9+1UAT6dm7WaEY0t8yUahHQCWZkvuqac6icxRdY0T17TvWvB9PfT0WNBB1d198KuRiDkt/FQELoFCOsQtMnCr2BCDwOtukgV0wkuAbzdlHcNCIYOWiRCJKM5rTlw/6KBoXrvJd+GQa4qAB4UW3WBKYHtd0Y86+QQ4sojjUrt1CJFFzZTyV0LEL5GTGWHDiZDg==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by DU0PR09MB6298.eurprd09.prod.outlook.com (2603:10a6:10:415::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 18 Oct
 2024 13:18:46 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:18:46 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 1/8] Add CP0 MemoryMapID register implementation
Thread-Topic: [PATCH v2 1/8] Add CP0 MemoryMapID register implementation
Thread-Index: AQHbIVwvyUJ3qMyeD0CUTzhAqgeeqA==
Date: Fri, 18 Oct 2024 13:18:45 +0000
Message-ID: <AM9PR09MB4851FB6034EDB7FA191BA47E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|DU0PR09MB6298:EE_
x-ms-office365-filtering-correlation-id: cbce13e8-c90a-4125-e8a9-08dcef776521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nXSmvegtG+lDBimP5TjsAZUungwHun7xuSxc5pDj2V2wrxYB0SXFM70hi3?=
 =?iso-8859-1?Q?tOnChcL5TPp4yUDoAs7TSITVxX4CMWXRd/tpb9mdf4h6o8kz7JaCjYvl1f?=
 =?iso-8859-1?Q?KCZ1UH/eFsQzNjMFceydck/V3coMjVK2HPbqacvGoHkxH1u1DSdc2+VrDG?=
 =?iso-8859-1?Q?g+VghITu+Ny1zPd1+MeGwDcT9myLmHe9aff7VqrOza+YC9X4O3f93M/cHT?=
 =?iso-8859-1?Q?Eq0IXWTzHHgs1Ovziq3WAq5MdSsrRjo9sDxn5glRCJA6CI0diMHOqtcCIv?=
 =?iso-8859-1?Q?DkYboGBw+vxyanEi5EycbI7cd3g2Ew2V94kat/SNXAKNhm1lrkyXIXVQWd?=
 =?iso-8859-1?Q?7v3VALO7zNCNorc2wv/CMoAkXUtN5OHwICK5TMoE2YofbpU7tUQLJPocKJ?=
 =?iso-8859-1?Q?uPDBAHCR4paGyRyCVrtGTrzxJH1VgeQRsjTZJdRSONN4Ek4gyHvpRXqv0E?=
 =?iso-8859-1?Q?HsX7zigkG3yeYGIK7665+UNUgjMudjKUiWAqIrxhjMV1LcSl8WRDXJFl4J?=
 =?iso-8859-1?Q?xvLHn/gazzU69rENJn++7neYs3HJS/L5cM6R6Qww0eRRSA8Jq8cx5e07uZ?=
 =?iso-8859-1?Q?C1oFsBYI/LXm4a7nICmyFFZvymKMwWzrfVSqc8g1+DylvR0+AZGsI4Oi7g?=
 =?iso-8859-1?Q?Bya7jn6XyQQ17UmXgYQ2LOfPnjRqAeN+iESBKO+Lbe970mmVE34I0hrHis?=
 =?iso-8859-1?Q?6aODpJ8VGVYzWTfIMgJl2APPu4HGKxJSBS4Ziy9+PcHo2+7E0DIAWBtPrZ?=
 =?iso-8859-1?Q?oV4QDIlo1mAlNShScm5A3iQKvo6OCyi75ZWajJ9zfWCyzFRdqy94wkgjwn?=
 =?iso-8859-1?Q?/DA/l4/M47vx/tJ7hkuv4DMsb7BSpEr8BrWDgNrn2S8LRII/IZkvF09QjB?=
 =?iso-8859-1?Q?im0w/HicW1l7NhKaF9JCLihMlZybuNlqmlNT0krMKWzdFD6S02jZBLqSh8?=
 =?iso-8859-1?Q?6kyJILqWM9hiSAm8QxVtv2Yd+yEAvKPcKU3eiglWqJjH0qQHDSrY4HHFRe?=
 =?iso-8859-1?Q?5QcJ+XmsyQcxE8wrdvcTN2Dr0+lEAnLRrkA0TXzq4U4Wm1VTAts3NjiQoC?=
 =?iso-8859-1?Q?fJEJA4nHP5zD3J6kTKOOWuMcYCe0hsojKyxqzVdbBVs3y2MuZZm4k3/wOc?=
 =?iso-8859-1?Q?hyobo038+dwnHmHtNrqtxl+eZkAJ8+jouValrzlYEeuZePYBI3/s7z5wDd?=
 =?iso-8859-1?Q?H2OBBUJMtxnQMHAJGkV53pm0+m46rpsiF8yMQhfTuX2D7iojwKpOme41Ll?=
 =?iso-8859-1?Q?tDhMa9wEqXR9KiLlLUsImbaJtyzmSdt1RzXrx1ynYSQ/7q19ceF2gpXGqt?=
 =?iso-8859-1?Q?oWOkZOkEvycSUGbjfxNN3uDFlUS6cjwobx7li1D5CWKrsgTH1VkaKW2SEY?=
 =?iso-8859-1?Q?c8ZUR4RUU2dDV7p5+de9lZkp6U4wX5OKYb3Es2ie0XHt/gHkQDPx2CYL8h?=
 =?iso-8859-1?Q?j2apC1lvgIElcKUy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e6u3y5naVV1VGMPiYJgAwferqvgORyho4o8aZ9psrijZjuWwnhbpPOm9J8?=
 =?iso-8859-1?Q?GdoUZle6akBlNycLL+nnFPCH/auYAhM9pvLAUA6bLm+uSGjkl0wRlsi6d9?=
 =?iso-8859-1?Q?F7CBYNC2SpQySwHgkWlhSY8cLA7ms0u6iEltoBJpGPl484xTRHzeuQfDA1?=
 =?iso-8859-1?Q?0tfjOHEqsT5xNgfTvCAfOC0x1nCyoi6Yd9Z/i8BHmmSIvZGiq+0+GvoAdu?=
 =?iso-8859-1?Q?CcM+Bhpnb9iF/q+SMb7xx+rwqmCrtu/at1MDfszydbhvPezKgIxR+ceeFj?=
 =?iso-8859-1?Q?XTkWM70mCw89nZFkgBSSQ0EZVS900RtH8iOddRNFA8jv6odpxwq6s9ohoI?=
 =?iso-8859-1?Q?4TMToXVd4nTuR2usqvqLdT5mXpXRxyZfGa6rv/lBCg7Ogn8xibkTi7zwwk?=
 =?iso-8859-1?Q?hTF9+QW7KqgYQ4A7wg0VGJhFZq2TMcsvuczX1c59aNrCJIvR2j5SKvC+jb?=
 =?iso-8859-1?Q?VPXlOZFO0ShKji6LtAlPhPajzWDGZq5Ps2lJ3CpniiBPdQrpMFkp+uKIcY?=
 =?iso-8859-1?Q?tebiri02rOS1O0IFb+ygFvdZOHkH1rxiE5k6cF4Fu4TMu/Cr86o3ECo/VJ?=
 =?iso-8859-1?Q?wq52SpRm2QDIvLR4hW5kfXjq2TLZPt7sBY/W8rVztiUXuw1RlatsSAluvy?=
 =?iso-8859-1?Q?4EQV6vQus/ZC/1M1PfTIg8Cd0ZomqP04fQX04sY8zuYwhvPKWa06uetnt3?=
 =?iso-8859-1?Q?pbGTivLgfA1lSupdrXIq5uNNZI4iQ+zxzuO8AGXDil7C9qo6mDJGBv0Hhm?=
 =?iso-8859-1?Q?pMGGz8xsZd//dMS+5DunxAn5SJ4QaWesylR9CaV/+0vipGdvnruWbywiQ0?=
 =?iso-8859-1?Q?N3EkDelZ2I4iPC0cr80OzBc0GlC8tYS51lr6fEFicOh0G6u+vZX95aBQ1G?=
 =?iso-8859-1?Q?h7FWYBnkJs8Fy+NBtJSrsu08qBagY7j+/WLXfduJY3t0fLyuFKxzWR7ycf?=
 =?iso-8859-1?Q?BSi5SsGF0+8dmRCyY/iTgfUHE6a+ipsLzU3WXqTqDljhKLBDdPiJG0CDy0?=
 =?iso-8859-1?Q?l+jvc6kYQNUWmto3zEdYl9htL53el4Jgd9XuRzMU9S+1mvrggAPT67S/uv?=
 =?iso-8859-1?Q?1yJA4uo1HiZ9MlhkrBHRfF0yClRhDREVNX4Qmdz+HTeYEIeOclxieIKcmR?=
 =?iso-8859-1?Q?0Yn/DQn7H02PuqVq7TxFLMH8KKtpjr6u/5iQ4TBvJjTibJeL2clKjbRVWC?=
 =?iso-8859-1?Q?9qKEtYQAoaFZq+MlUKLUlF8iv60gCRHon9IqnSuiSWhRS4/foOqyuyimdw?=
 =?iso-8859-1?Q?TT0zmwpfQF/uR3ZnBHy3UPiyGO/rpEeH/APqbjN2keCcuX8fVXcfNVf+SC?=
 =?iso-8859-1?Q?baNXeg6IUvNmSa+jiJ0vLwfgP9FZScy92cGyqdmmrgNJJNHOjD/ND1v0Vx?=
 =?iso-8859-1?Q?AxJGVFNhwP+CONuiIn7Lg7hpHBKbcYNDf575YUVIr3YCMaLu6xeLRyQv28?=
 =?iso-8859-1?Q?0n7PWtmkjYeNJ0Fs7zcPhrRwp1ljCWvE3zBluQdK/74JWdmlSv7ZyyTSgm?=
 =?iso-8859-1?Q?EohGkaEdhHa3lhn7l5snkmGLsm4vn5sHlDS7I/BR+MLVEkG1TbG6pu/ciZ?=
 =?iso-8859-1?Q?7JZy/vYBti0Dq1+OVJ11Koe9jyL+736T0gJkFBWDsj20I4YdpSK9PGMElg?=
 =?iso-8859-1?Q?0J8aG9DmJg39fMLEwZ1+V83bc1K7w4AwZBZQmXmqSr6PjJhOWErRlM2Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce13e8-c90a-4125-e8a9-08dcef776521
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:18:45.6013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP2Fkh8s6Oaki2LuLzV4R9QnNpNWHlHsAYtrYjBMZPSgojAY8lRP76YGLzITqd7LLPoDl+HRGvvqHwIvOMr7X0Ln/2CNMu+89MdMN6W1drs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6298
Received-SPF: pass client-ip=2a01:111:f403:2614::72a;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

Add CP0 MemoryMapID register implementation.=0A=
=0A=
Cherry-picked 9e0cb40adb110c2c76e2e97719ba8afcce72bcf5=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>=0A=
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/sysemu/machine.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c=0A=
index 213fd637fc..91cd9f1900 100644=0A=
--- a/target/mips/sysemu/machine.c=0A=
+++ b/target/mips/sysemu/machine.c=0A=
@@ -142,6 +142,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,=
=0A=
     qemu_get_betls(f, &v->VPN);=0A=
     qemu_get_be32s(f, &v->PageMask);=0A=
     qemu_get_be16s(f, &v->ASID);=0A=
+    qemu_get_be32s(f, &v->MMID);=0A=
     qemu_get_be16s(f, &flags);=0A=
     v->G =3D (flags >> 10) & 1;=0A=
     v->C0 =3D (flags >> 7) & 3;=0A=
@@ -167,6 +168,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,=
=0A=
     r4k_tlb_t *v =3D pv;=0A=
 =0A=
     uint16_t asid =3D v->ASID;=0A=
+    uint32_t mmid =3D v->MMID;=0A=
     uint16_t flags =3D ((v->EHINV << 15) |=0A=
                       (v->RI1 << 14) |=0A=
                       (v->RI0 << 13) |=0A=
@@ -183,6 +185,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,=
=0A=
     qemu_put_betls(f, &v->VPN);=0A=
     qemu_put_be32s(f, &v->PageMask);=0A=
     qemu_put_be16s(f, &asid);=0A=
+    qemu_put_be32s(f, &mmid);=0A=
     qemu_put_be16s(f, &flags);=0A=
     qemu_put_be64s(f, &v->PFN[0]);=0A=
     qemu_put_be64s(f, &v->PFN[1]);=0A=
@@ -204,8 +207,8 @@ static const VMStateInfo vmstate_info_tlb =3D {=0A=
 =0A=
 static const VMStateDescription vmstate_tlb =3D {=0A=
     .name =3D "cpu/tlb",=0A=
-    .version_id =3D 2,=0A=
-    .minimum_version_id =3D 2,=0A=
+    .version_id =3D 3,=0A=
+    .minimum_version_id =3D 3,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),=0A=
         VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),=0A=
-- =0A=
2.34.1=

