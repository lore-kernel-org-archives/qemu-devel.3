Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378CDD30008
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1muR-0002FH-1U; Fri, 18 Oct 2024 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1muL-00025d-L1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:20:45 -0400
Received: from mail-db8eur05on2070c.outbound.protection.outlook.com
 ([2a01:111:f403:2614::70c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1muJ-0005z0-62
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2L1I9ppqshFrdcITxr7P/wPNeWo7FCw7BlayahrBN5nLIKlsHBVVtMZElPc6HplpluYPvkyU6bNJEFfOPFs8dey7nn7eP7N+FN5/Sc5/G6dRXTK4KNzYhae3dw99gyyzJD/1bjsIqsNVfIxtZ+aIw/Gxx2QbTiWBEcQ79ugLSHcRC73q14yiCeSnkR1vxMGY8ifvVgkm5bmpk6C6QQ57buf2WHSgQLEJwR4kvnQcC4xXYhH17Qh3lPGlu99RqiA64KCuNR2up1B2p7RdI5dNHpOsHzS6PG7KUyQu/s4gbAB8dcoDJAIjqzhd1988Pv3WTrzpg8vtXrTHUBXLdZ5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pw7byDgk/+Jxuc/fzwu/j1NGienyRfKY3Skzg8UAQc=;
 b=ln4Ta9NedDfobz7XizLDjzk0onaYqaJLQz5Nc5t/o3m7S1X5nTGOCm43TE6+Af3t+t87Z8akrZAwNzqUdLujJcWY5Ta83e108iTmdAJKJYj14SeldDhWgjmvBLST2FQHh9wTxeRrBsg+tDczBn05SatvMnRlHCLzpZL6R/aTXOkJE08js6Sm5WqZ32hO2VN3LrD78rxA3dtl0Nerz6r+GnEdqUQkGesFeIU0obz5ZzsJ12I/19A9IZPCJ+HV/Q2l7KUBmweXRFC4uFAjOTBZKBO31aiM1mzWhavNC7FXgMBPRB+DXWbPqZt9wZk4PQGk+kVbcb0ECPtzMFAmq3gXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pw7byDgk/+Jxuc/fzwu/j1NGienyRfKY3Skzg8UAQc=;
 b=hqBVKH0mBxqN8jOSkxUmfzBeDQ1eroGCKCQWdYEz3zUrUjTqXe68pIxH1sU70/eOGQ2feB3Qm7piydGUlVVM8oY6ZpVvJFbG7/UCqnrfv0LNG/L+4f2MPgEd8yKy9jUkoglVvepPFtohGnOKrxY5tgaQl9lkXaGUwHMhVHVILZ53erSauObNbPkmSJ7BWTrYxuGibIBlO4FO+4uC/CZ/6A0euBvHtc26LKPGDoqOzemGto8GTW5B6TzIy/LsR1VGlTYRa30XPz0ew42DHZz0Fo5wXmkFsQVrvEkiilTFBaJ56Hd69leAiPfjoWdEPSpxKE6ziupNFE9bA7o42zqV1g==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by AS2PR09MB6191.eurprd09.prod.outlook.com (2603:10a6:20b:5f6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 13:20:39 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:20:39 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 6/8] Revert use of clock_gettime for benchmarking
Thread-Topic: [PATCH v2 6/8] Revert use of clock_gettime for benchmarking
Thread-Index: AQHbIV5yGIypzXaEQ0yci6Mb3PT1Lw==
Date: Fri, 18 Oct 2024 13:20:38 +0000
Message-ID: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|AS2PR09MB6191:EE_
x-ms-office365-filtering-correlation-id: a696e74d-acc3-4ca9-c05c-08dcef77a8ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b4YjCEKvGMnYkZKUqkX+oY7DXeM5M7BkEsBillBmSUGR6SmYObgIR9LcbU?=
 =?iso-8859-1?Q?+aJaKPokiR9UcCOC9SUmCC0AsSrQVYL3rsEIjhTrZQj/t5FVWkIXJoQKJP?=
 =?iso-8859-1?Q?E/Qx56DAULO9xeihEu8Sm8XoQbXFfj+IApVSiKCCjQvgbxcORCuOVR/y7C?=
 =?iso-8859-1?Q?kroUoq26TUjM9OzIztmvXbD9k2pFH70+F+dcI9klXgJJUlWgw5Bgyu+Pyv?=
 =?iso-8859-1?Q?cPhjI1t3VD8DlUKyFhK57nLRGoZY8aMISFNo2FbQMgtiCRXmY2Oq2bKIgW?=
 =?iso-8859-1?Q?4Hi0Qcee6z/vtrpXAk9SVYOy7E7T/yJ18jzsBdx6suvUBDL9oNliBGIK4K?=
 =?iso-8859-1?Q?6NyUm4+3BBMpcCqKlNK56hs5KW8Z/9sMxm8KK7Rz8U5+AuIBgMx66ADLHA?=
 =?iso-8859-1?Q?vS8GxvV8CPW+3BpyAQRcx94ZvgCRW+qIIcxtkjPCwFsYNYY4AD46OLaMFi?=
 =?iso-8859-1?Q?bx4n3IRgOpiIwxjaXavUGkXY6XvIEgPTeT2fRXlqYD9lBMMg8dkXX4fYl4?=
 =?iso-8859-1?Q?/9uALPcVDvhEERGEyf8QxDKmegCXEmE5KtAf6W1Mynu/uDTJ2yul0FX1z8?=
 =?iso-8859-1?Q?R/nDOHTN08fuVHH+TWiU4QyDhjTwisXfXhTkhEsMhWHLLjjXx+6a+hOizM?=
 =?iso-8859-1?Q?LXB2Mrx0gBuAQCkwGFDligVQVWXO5948drfx5G1npoOR5Hf7VDDGudczb0?=
 =?iso-8859-1?Q?0edCmPpvQrtzEnXQ+WcHG2kh2EPcFyVv6la4YTu61peLieqZYoR5BhRCzr?=
 =?iso-8859-1?Q?Xfzr/Bnyt61LUS8+0PHxp4dhCURiePRhE7Nb+/AShCqLcY1XIQ9TvQpkYZ?=
 =?iso-8859-1?Q?3c59B0rhuR0Qcx4WRDsBiaGwLwvth8lW8HxvCJVSScJdzVHVhgTAfpefxc?=
 =?iso-8859-1?Q?JQtTMd+4ywm0H5sRFBYUh9XkQGXaWmT2JgwiPulQxUY5/qlE4RdJ4etxUM?=
 =?iso-8859-1?Q?kPooGKJij60SJdRYpW0QN+prg5lHoXM/7cKHiTaTUS2D3GrBxTNVE3ExLn?=
 =?iso-8859-1?Q?HsXtSDVWx/u9RPKA6UhRVeZEpIOt1jNKX2L4uGS9gils6Wvnv/wUh3+VtW?=
 =?iso-8859-1?Q?e1xELRM4vfLYqx6oXB6gLiS153Jdol08cFILfcFp9hzza9EKWl54ooO8IW?=
 =?iso-8859-1?Q?wb3w680RR+NSels3xAvBou1arx3Page4+vUDQrItFvOehrb4/UUWEZSGjA?=
 =?iso-8859-1?Q?i7OA5UkGA6bshPoGBuOF+Tbwj5zTUHa9NOH/kXJlzxAc6ltH8PUt3gaXzB?=
 =?iso-8859-1?Q?+VbRUUKKIn9tjca06SBybUjE3Wg7w67qO3RgwyIVIvQFjmyNeygwMKBoS/?=
 =?iso-8859-1?Q?zhWhcn/7h//42lmFaIvqmKCCkqplEWH2RympefFcGL+kh1BQ4w5YvIMywz?=
 =?iso-8859-1?Q?vDOlD9+tPUpY+J914v41TUiykpclL038RcvzyEm0WM2UwmbRIYh3g2RsAt?=
 =?iso-8859-1?Q?9aEJgn8drzZ/D1ol?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T3lzjiQrA0hLKASJUURpC2waIdS6fQuyQRq2mNJnZpB3OBVXv2X1BK2QfW?=
 =?iso-8859-1?Q?eCsL4F7UHZ3qSuYjGz6dAJsz6Ya+v+946NR7cNE8VXgzVLOR/uY/9irszP?=
 =?iso-8859-1?Q?krRT+zKeGuB/sbW/ecjJIfEvbNP6HOJ0uuNR/LPopGjspXEW1BZ0+MgLrQ?=
 =?iso-8859-1?Q?XWyz1ZJJXkAE/7/qEJ5Ar7uWNnGAdAJ7akpweA4+Kat+joLuM5MjF62YPN?=
 =?iso-8859-1?Q?VmlcBteOWvf3eLQef6Bm4jJaj5qUNpIbQg62YAMnE608OKe+y3YcuEF2f2?=
 =?iso-8859-1?Q?cWS4yOrVYV1+ejwnlP0pgAWK7QypZ2LaDS2hcf8rgO0oilhk6Kb481SpHE?=
 =?iso-8859-1?Q?sDw8ZzU/tF1qysf4q9KRhmO9d8Z0TO8L1iduHd+biKC1qyokl7HBxdHpHN?=
 =?iso-8859-1?Q?krfz0JjXMF/qPArbs5ON2Sg2x9lW1InQ3CBPYquzIzJnCA1erBPdiKku/9?=
 =?iso-8859-1?Q?ILpeoIHRDoWG0VYXTMPzSr/DNSvXjjwIM9ISMsMP9KgdyLrB416qc06x+t?=
 =?iso-8859-1?Q?aEELw8qgxiKFNakhm3NEWWwlZO7kYGQiiX6cMGqqOGR3yzl1EdlrYQ9Qhj?=
 =?iso-8859-1?Q?I0d6FTh1uhIuyzog5QCaCRipRosgVqNnn/Sol+vPLT89tGnKuGou8NDTT6?=
 =?iso-8859-1?Q?MBa1lxvAkQbRrCqn12HGj7zGP+sMSSItfgGj9FGMuQeANQH+3XILwkdv/f?=
 =?iso-8859-1?Q?fdF42pwGWOr6L1454HE3XwXHynw+1UljglKv90hbd764ZU7Cp4/sEpauYS?=
 =?iso-8859-1?Q?mso1hR2cJWgmT1sJheduw5s7cqKBEKh7sxUGTVaFRXhi2OAqjks/Xg/djk?=
 =?iso-8859-1?Q?I6pbjxkxHmlApnEJpgH3V+INrXNQxlLpJPDiAJ1yrg2AB2vJHUOjcMfpRZ?=
 =?iso-8859-1?Q?ncCpGkWa6FBOs+HjFzOQJPyh5WrEAFPco+k3h2ztkRDZjhUPSKXsbIagzd?=
 =?iso-8859-1?Q?JLQAEbQZJFO3A1JcwFK9kPSFe8KSpzmCLBAw0v0QQ2guRcP4C8yix+fkdD?=
 =?iso-8859-1?Q?1TR0Ak5Jn4xFQO6pw9fZ5tsLk0dfCM13PG4MhjlOassafzJGdZWvXjJ324?=
 =?iso-8859-1?Q?NxsASy6dAlA6jEXZZ7AjvcF5TOcoP/16oR8wEkjqkzLus+Bsnv4g6rlNFL?=
 =?iso-8859-1?Q?ko85+jKmZFZyP/LE2X+zt24/QFVKtllN6pVpVxKfmcckitLkq9fVxg7VKc?=
 =?iso-8859-1?Q?IKZM5ePwiU7X/JULfoRJPdtFoJN3m6DERY2Du0j9XQNGnFD6z32f2OMnIM?=
 =?iso-8859-1?Q?5cUNf4LV/20X9Y7cLAkxDpnVX4jFjolXhsZ37sJX8CRt+e70Eekkqs5J56?=
 =?iso-8859-1?Q?9ze5dmFDUR+/Wyn/vLu1vdqeKuc3+xzHqM7ZWXIsO3la3xzgGc3sLJHhbB?=
 =?iso-8859-1?Q?K3n9qVdzvpS+uTL779vf1G3IlpIF7LMp/d+vh3vwVLy0/oZbzgL1Ddo4wc?=
 =?iso-8859-1?Q?pR2fnIv2dKdbsQzLOg3wp9GR5N3vxAnVHiMeV6lxS1XG67j53dyGmIcIHf?=
 =?iso-8859-1?Q?5InZKcvwOPpXSKGpJzkyQlk6VBVBrbRScugN95oz/UG1Lkayx6CZ7nAf5t?=
 =?iso-8859-1?Q?oPEYTaAb7hE4sBflcMMWsN2IClOcSZJR/+lYL2qt3H/XptaoiSdoRZW1Im?=
 =?iso-8859-1?Q?Xu7O9uR0+dsmcqW/+X/oiU3Cs5frU09juCdejCxw56uNPaisqeKDN3zA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a696e74d-acc3-4ca9-c05c-08dcef77a8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:20:38.9445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmimBcbzikTjV2hcMadDylZRSjiXWVcjl255MnVr4YkZxTkrzJvAPSBSxDRDXBuHC9RptNB4LWC4gSU4NWDH/i08E+LAMwcLmXAwjYEjahY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6191
Received-SPF: pass client-ip=2a01:111:f403:2614::70c;
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

This patch reverts the commit (with SHA=0A=
50290c002c045280f8defad911901e16bfb52884 from=0A=
https://github.com/MIPS/gnutools-qemu) that breaks for mingw builds,=0A=
where clock_gettime and CLOCK_MONOTONIC are not available.=0A=
=0A=
Cherry-picked d57c735e1af1ca719dbd0c3a904ad70c9c31cbb7=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 qemu-io-cmds.c | 77 +++++++++++++++++++++++++-------------------------=0A=
 1 file changed, 39 insertions(+), 38 deletions(-)=0A=
=0A=
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c=0A=
index e2fab57183..a846746553 100644=0A=
--- a/qemu-io-cmds.c=0A=
+++ b/qemu-io-cmds.c=0A=
@@ -259,21 +259,20 @@ static void cvtstr(double value, char *str, size_t si=
ze)=0A=
 =0A=
 =0A=
 =0A=
-static struct timespec tsub(struct timespec t1, struct timespec t2)=0A=
+static struct timeval tsub(struct timeval t1, struct timeval t2)=0A=
 {=0A=
-    t1.tv_nsec -=3D t2.tv_nsec;=0A=
-    if (t1.tv_nsec < 0) {=0A=
-        t1.tv_nsec +=3D NANOSECONDS_PER_SECOND;=0A=
+    t1.tv_usec -=3D t2.tv_usec;=0A=
+    if (t1.tv_usec < 0) {=0A=
+        t1.tv_usec +=3D 1000000;=0A=
         t1.tv_sec--;=0A=
     }=0A=
     t1.tv_sec -=3D t2.tv_sec;=0A=
     return t1;=0A=
 }=0A=
 =0A=
-static double tdiv(double value, struct timespec tv)=0A=
+static double tdiv(double value, struct timeval tv)=0A=
 {=0A=
-    double seconds =3D tv.tv_sec + (tv.tv_nsec / 1e9);=0A=
-    return value / seconds;=0A=
+    return value / ((double)tv.tv_sec + ((double)tv.tv_usec / 1000000.0));=
=0A=
 }=0A=
 =0A=
 #define HOURS(sec)      ((sec) / (60 * 60))=0A=
@@ -286,27 +285,29 @@ enum {=0A=
     VERBOSE_FIXED_TIME  =3D 0x2,=0A=
 };=0A=
 =0A=
-static void timestr(struct timespec *tv, char *ts, size_t size, int format=
)=0A=
+static void timestr(struct timeval *tv, char *ts, size_t size, int format)=
=0A=
 {=0A=
-    double frac_sec =3D tv->tv_nsec / 1e9;=0A=
+    double usec =3D (double)tv->tv_usec / 1000000.0;=0A=
 =0A=
     if (format & TERSE_FIXED_TIME) {=0A=
         if (!HOURS(tv->tv_sec)) {=0A=
-            snprintf(ts, size, "%u:%05.2f",=0A=
-                     (unsigned int) MINUTES(tv->tv_sec),=0A=
-                     SECONDS(tv->tv_sec) + frac_sec);=0A=
+            snprintf(ts, size, "%u:%02u.%02u",=0A=
+                    (unsigned int) MINUTES(tv->tv_sec),=0A=
+                    (unsigned int) SECONDS(tv->tv_sec),=0A=
+                    (unsigned int) (usec * 100));=0A=
             return;=0A=
         }=0A=
         format |=3D VERBOSE_FIXED_TIME; /* fallback if hours needed */=0A=
     }=0A=
 =0A=
     if ((format & VERBOSE_FIXED_TIME) || tv->tv_sec) {=0A=
-        snprintf(ts, size, "%u:%02u:%05.2f",=0A=
+        snprintf(ts, size, "%u:%02u:%02u.%02u",=0A=
                 (unsigned int) HOURS(tv->tv_sec),=0A=
                 (unsigned int) MINUTES(tv->tv_sec),=0A=
-                 SECONDS(tv->tv_sec) + frac_sec);=0A=
+                (unsigned int) SECONDS(tv->tv_sec),=0A=
+                (unsigned int) (usec * 100));=0A=
     } else {=0A=
-        snprintf(ts, size, "%05.2f sec", frac_sec);=0A=
+        snprintf(ts, size, "0.%04u sec", (unsigned int) (usec * 10000));=
=0A=
     }=0A=
 }=0A=
 =0A=
@@ -467,7 +468,7 @@ static void dump_buffer(const void *buffer, int64_t off=
set, int64_t len)=0A=
     }=0A=
 }=0A=
 =0A=
-static void print_report(const char *op, struct timespec *t, int64_t offse=
t,=0A=
+static void print_report(const char *op, struct timeval *t, int64_t offset=
,=0A=
                          int64_t count, int64_t total, int cnt, bool Cflag=
)=0A=
 {=0A=
     char s1[64], s2[64], ts[64];=0A=
@@ -707,7 +708,7 @@ static const cmdinfo_t read_cmd =3D {=0A=
 =0A=
 static int read_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false, vflag =3D false;=0A=
     bool Pflag =3D false, sflag =3D false, lflag =3D false, bflag =3D fals=
e;=0A=
     int c, cnt, ret;=0A=
@@ -825,13 +826,13 @@ static int read_f(BlockBackend *blk, int argc, char *=
*argv)=0A=
 =0A=
     buf =3D qemu_io_alloc(blk, count, 0xab, flags & BDRV_REQ_REGISTERED_BU=
F);=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     if (bflag) {=0A=
         ret =3D do_load_vmstate(blk, buf, offset, count, &total);=0A=
     } else {=0A=
         ret =3D do_pread(blk, buf, offset, count, flags, &total);=0A=
     }=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("read failed: %s\n", strerror(-ret));=0A=
@@ -904,7 +905,7 @@ static const cmdinfo_t readv_cmd =3D {=0A=
 =0A=
 static int readv_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false, vflag =3D false;=0A=
     int c, cnt, ret;=0A=
     char *buf;=0A=
@@ -964,9 +965,9 @@ static int readv_f(BlockBackend *blk, int argc, char **=
argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     ret =3D do_aio_readv(blk, &qiov, offset, flags, &total);=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("readv failed: %s\n", strerror(-ret));=0A=
@@ -1047,7 +1048,7 @@ static const cmdinfo_t write_cmd =3D {=0A=
 =0A=
 static int write_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false, bflag =3D false;=0A=
     bool Pflag =3D false, zflag =3D false, cflag =3D false, sflag =3D fals=
e;=0A=
     BdrvRequestFlags flags =3D 0;=0A=
@@ -1190,7 +1191,7 @@ static int write_f(BlockBackend *blk, int argc, char =
**argv)=0A=
         }=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     if (bflag) {=0A=
         ret =3D do_save_vmstate(blk, buf, offset, count, &total);=0A=
     } else if (zflag) {=0A=
@@ -1200,7 +1201,7 @@ static int write_f(BlockBackend *blk, int argc, char =
**argv)=0A=
     } else {=0A=
         ret =3D do_pwrite(blk, buf, offset, count, flags, &total);=0A=
     }=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("write failed: %s\n", strerror(-ret));=0A=
@@ -1260,7 +1261,7 @@ static const cmdinfo_t writev_cmd =3D {=0A=
 =0A=
 static int writev_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false;=0A=
     BdrvRequestFlags flags =3D 0;=0A=
     int c, cnt, ret;=0A=
@@ -1317,9 +1318,9 @@ static int writev_f(BlockBackend *blk, int argc, char=
 **argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     ret =3D do_aio_writev(blk, &qiov, offset, flags, &total);=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("writev failed: %s\n", strerror(-ret));=0A=
@@ -1355,15 +1356,15 @@ struct aio_ctx {=0A=
     BlockAcctCookie acct;=0A=
     int pattern;=0A=
     BdrvRequestFlags flags;=0A=
-    struct timespec t1;=0A=
+    struct timeval t1;=0A=
 };=0A=
 =0A=
 static void aio_write_done(void *opaque, int ret)=0A=
 {=0A=
     struct aio_ctx *ctx =3D opaque;=0A=
-    struct timespec t2;=0A=
+    struct timeval t2;=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
 =0A=
     if (ret < 0) {=0A=
@@ -1394,9 +1395,9 @@ out:=0A=
 static void aio_read_done(void *opaque, int ret)=0A=
 {=0A=
     struct aio_ctx *ctx =3D opaque;=0A=
-    struct timespec t2;=0A=
+    struct timeval t2;=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("readv failed: %s\n", strerror(-ret));=0A=
@@ -1537,7 +1538,7 @@ static int aio_read_f(BlockBackend *blk, int argc, ch=
ar **argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &ctx->t1);=0A=
+    gettimeofday(&ctx->t1, NULL);=0A=
     block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,=0A=
                      BLOCK_ACCT_READ);=0A=
     blk_aio_preadv(blk, ctx->offset, &ctx->qiov, ctx->flags, aio_read_done=
,=0A=
@@ -1692,7 +1693,7 @@ static int aio_write_f(BlockBackend *blk, int argc, c=
har **argv)=0A=
             return -EINVAL;=0A=
         }=0A=
 =0A=
-        clock_gettime(CLOCK_MONOTONIC, &ctx->t1);=0A=
+        gettimeofday(&ctx->t1, NULL);=0A=
         block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,=
=0A=
                          BLOCK_ACCT_WRITE);=0A=
 =0A=
@@ -2159,7 +2160,7 @@ static const cmdinfo_t discard_cmd =3D {=0A=
 =0A=
 static int discard_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false;=0A=
     int c, ret;=0A=
     int64_t offset, bytes;=0A=
@@ -2200,9 +2201,9 @@ static int discard_f(BlockBackend *blk, int argc, cha=
r **argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     ret =3D blk_pdiscard(blk, offset, bytes);=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("discard failed: %s\n", strerror(-ret));=0A=
-- =0A=
2.34.1=

