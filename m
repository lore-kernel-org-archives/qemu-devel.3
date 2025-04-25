Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA9BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfw-0004Ij-L4; Fri, 25 Apr 2025 10:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8HpT-0004Iv-Dp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:06:52 -0400
Received: from mail-am7eur03on2110.outbound.protection.outlook.com
 ([40.107.105.110] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8HpR-00024k-2v
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:06:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzNHCqWwWBS9H6tbLqim9gTlOyKn1xEshJy0TcKe8ZveaIZVhoipWL9y3hKwAHhLuEIgwt4GSTnm1VPm5bb517W2POC28keHIh0dsCn5iXnn7n23ZJWBNicCmJZ9z8E82pdmbr/KEN/0JdSsTOKi/mnFJf0RXkjiKcw541bB0HBSl8amYKfzmrCGepWRXHwmb6PHJg0H9VkbTFO1nf3tEjFsbEStseQg2UH2M0GnrATYYPieixHP2sBxqA5cL/buQB0aR4XlOnjlZq9ZV0/LxeWA9bd9PN2L3ylsSorWMhKyO8gj5yxsD0wIK987VbY1LkqbNGy3Nh1irPddWOd0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiEsHc0Y2m1YaZy6JTgPAdtFMb2TN3clMrKrYfVh59A=;
 b=VffTJ07587NcOy5WgRawy+7mwR52HrWmlhNQ9bc4Zwuwq760HZdMD3eK1QwO1VbcoL9p7bxsKXuHagh+NOG5zMX3rR4AdLH1X4Wz6rzmk4mbDKN20nK8zKtjpEKv84PtWPZJCSYRSm6zYqyuY9MCzGE9BagPvTNB3A452j12h+fEIhzKXfdXkSDhZty6M6bsZ6EqB3ktCodB4PzUJGf6sE7hz0uFT8x5yWOvO+dzSdWg5tngvhNp+d3Qv+AXSJQI09PO2+hsaezq00kRY851jT7WPunsz3I5eQIrQSvo/VgrMPKNTL0qktB/XARJspps0TtJ2yGVAdNSI+zLWKs6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiEsHc0Y2m1YaZy6JTgPAdtFMb2TN3clMrKrYfVh59A=;
 b=IiiO+CTnHFoZXyiNhRz+UsK+7b3AUbwUBzy845AC2/p6b7CObi744TD3V2XKSi8e1QZbB4QGRiaJ73nHAXFST55KECrBtrZ2pHYoJXf8eAd904+0gMTSNAJFcAgjozvGTR9vs1qKKEOtutN/E67AoXx0LFn8JLVajF6rudKL2GM6Vp0eOh8QnhDXRBBnO6ulYoxuKI6Oa8WemwcT4oSFO8sJLocCXslMn8c4B7Hrqwzmj1cmGYpZnnekWTuPiaw4oTb0ZTkNZuIBpcmyO518AXl5uyZ+gHED0PDgwddLkxARthvdyJ3NBRRt9i4I8J7/UagOyKJ5H6QJgEHdyP3AQw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3713.eurprd09.prod.outlook.com (2603:10a6:208:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 12:01:44 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:44 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 3/9] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH 3/9] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHbtdnQOqWbi6UnUU2c8zTRtEd17g==
Date: Fri, 25 Apr 2025 12:01:44 +0000
Message-ID: <20250425115912.912889-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 5f452e43-912b-4dfe-eb65-08dd83f0f2e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VDkXOosXk0Pswx66LhJeilFLfFu2QdFp9NC5zHduv8DkZrxtKo3s1v22wl?=
 =?iso-8859-1?Q?RYoMhH/RCDvsO6L6GJ/8pKAAfed7BqejwX9CN5nQBYZqVwfvQBtjWCNPXQ?=
 =?iso-8859-1?Q?0ictjXICNDgssbgok/EvrM0QFvoD2fgl6WcUl2oyCZdI6hLrNLd0/WLQTD?=
 =?iso-8859-1?Q?kYjHyqTgldqCH0bTN2HZkkycd//fCZYEbIWxFsVnQiGwOMUi0htW4Dgh8C?=
 =?iso-8859-1?Q?Mx09QSG/7ckZ2Im4UnythxOv560p7Wuld69uxUNzCEi/I4Y171ZI9CbTPZ?=
 =?iso-8859-1?Q?q+qgvdATB0QHh/M0n8wGB6GNqKnxS6cDen+jJZX+Pqz5JsNG3tXJkZiYGq?=
 =?iso-8859-1?Q?gmh52PEZ4RekayJp5ZIHrxQC60NYdAd84avPb8HZxy0siGzb0AedvjS/M5?=
 =?iso-8859-1?Q?Pi3OzUMnW5Zs24eLqYskrgTtepmpTjP4IB94Hl9+Ycp6HNe2xGosxTeae5?=
 =?iso-8859-1?Q?pEaqnOcbrQlH02JFUrwxwVJLsYepzyGRzdNbUS/FtsihY0WzmYpCcyBQMS?=
 =?iso-8859-1?Q?wKfhGZoAzhOclSnzAfKlKPQMnichgOtKy8snJwZpZF4alMDvRvZLd2yI/d?=
 =?iso-8859-1?Q?h0j0YHZL9mi5BwltCm+IKlHyTZN+eZCQNOlCAQ+n+8ObWjaeLDLyeR9ZXu?=
 =?iso-8859-1?Q?LHtktQXBwloYJEWZG8EGWZQDLodjZnD1BnqtKTJnsSRtUKA4H5tYR0OXp2?=
 =?iso-8859-1?Q?GSccv1oBgxRu68e9u1HSipaemr3Bh2Ad4WQYRkxlSKK2WzBqGuA1zP/nzD?=
 =?iso-8859-1?Q?QCu/GEv1dWOTzrVHe6Y5jknX7L4EQJXXNN7ibfKf3k8TMCTqo4yr7HQ2vx?=
 =?iso-8859-1?Q?ZiC+RnlHY7GZAtcgLATQQ3otqnOPmn8fc0NvzdJQnn+mr6YjqutAd/mYvT?=
 =?iso-8859-1?Q?2OzW+i9MndWtnjgViu54nKCO+9r+S8+GtfDZj0Q+xWXkTxIsnqX3YbAZ/9?=
 =?iso-8859-1?Q?DPhr7uJVjKEgtJkaC+o4pgAp4x/Tb+6xcPYeGtchQmMZid0Z8pDjfYpsps?=
 =?iso-8859-1?Q?DKNjhmABm+JmO11VhbEgL4SONjMNfS7kJFV17/WWK89NvOvI1WO3h1mlk2?=
 =?iso-8859-1?Q?xleG1R5Jwf75pSZjyWoKm36j8qZj9ZGn8cj/XX5SVX0osiK/wsI7pZGswX?=
 =?iso-8859-1?Q?7PrqrM/+PX3kVSjqAefFFl2HeJQ2SMqr4xO+SKr4LY0674v2O9+kw5y8MK?=
 =?iso-8859-1?Q?5Z8np2eWVWKwoyzMywU/LzlyS3GZXOisfwdBW5HI/GwVeePP44r4V6LRji?=
 =?iso-8859-1?Q?N0CNDZBe9IJ31sSwZJaSJqqvC3bpYwvruzWRbqx+yXwWA3v0eZD8UyI1aZ?=
 =?iso-8859-1?Q?5lhZhWyxkTHNCvSY9IUVwlXh/S417Ad6d8XS0rGBuEOsGygPmI24+2sGUf?=
 =?iso-8859-1?Q?StIFZtofWPAQNM7BvL+IwqdoAt/uvG5abVQlYNY+WViAeQhrm+ZAGn6bFB?=
 =?iso-8859-1?Q?Ikd8z9PylK96V4Hlzt5l26gKQKBTUicdhxhqcaXO6tq2OF9+S4aUsnBn67?=
 =?iso-8859-1?Q?fCrG2F+seneTkhCmPa0ft2e0VLHme0MZzHt7G0L4AO99fPtBGfYEJ179JU?=
 =?iso-8859-1?Q?oQwBqOg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q7uoZR6Ezwt+JOMN+8HMkxGSeByKi/fvz2aVGDQgVjk/WxjuAiPsQiWznJ?=
 =?iso-8859-1?Q?1AiST5RXbjSYYEx33m1RRvg81XYhsitfZeAC/asg0hCdpp+orQzcSneit2?=
 =?iso-8859-1?Q?37JofmKAoDw6ucFfKu2gbqUQbbt+k2EhvpWNc0EGDwZz8ygbdGe7SzITdh?=
 =?iso-8859-1?Q?Y7l8g49XTTEXN+7CTocy3JIxLNPnYqdNgu7/1sFrW+6o4dStqptSg93x4d?=
 =?iso-8859-1?Q?ii/tqiq98LkmD/7tIMtrq9Q/QXx5ypsYsxxWEiCby2v/OW+TYKZ1OOTyRc?=
 =?iso-8859-1?Q?fT8n8jvPXS77jL/K3SsAwaGmwv6k3JEFhr6ohkgKaAdtukkzSbxrWkefjm?=
 =?iso-8859-1?Q?G9NUQYOtsok8Bt9+qTCi2AludBF3258XuXbqzuZxNXPSt8bWURZ3zhiCN3?=
 =?iso-8859-1?Q?aliP6Usqa/S18PdXVRqOFSClGoV3/hbM3bOhwwEUaeGT1Zj81SeXOtg1SU?=
 =?iso-8859-1?Q?LhR8xbamNWNJBSNyRqrBpIU43z5gPHwmty/6Bvs3gOErE/JWVjAZs0vKei?=
 =?iso-8859-1?Q?1AsQcf1Ld6F3h1t6FmSNOWtuD0j0xJWFvgRS4V5WDYYGp3KXT9Gll3wvhi?=
 =?iso-8859-1?Q?g3iCW7KLRMuNORT02h5CDnWjgC1DDIzBsXIJHErV0i7jgWE/glfxfDHWV5?=
 =?iso-8859-1?Q?dCLJQ5NR2F6SxDKUbCt5oXzKWN5hxu7o6FhkTLJRAPbHMC854UxKqLmk1Q?=
 =?iso-8859-1?Q?p6nuYRWB6UOn770vzWFeVGJrI9+knaqk4vCZlFQeS72oIKGquQmeJo+t9T?=
 =?iso-8859-1?Q?/xBhheB/YZTfMbuO1Aoispi1oQevQBp1d3FnRAD7W3rBfSC8zMxuZ5zCEF?=
 =?iso-8859-1?Q?vcoWmMz1Ks6/KCQAZh5VpqhTkCdXqPdSoJ2SQIwW5xYXldmnGehI1SyJNs?=
 =?iso-8859-1?Q?wx95Gpr1Y0x55YV2p81vlQ0n/PRBBvM+fKmBZZmAeux/vRyT7CD/KrOFm2?=
 =?iso-8859-1?Q?g8TQWrb8RRR7Clk+DmeaR24MdJRBhyMaK25p8eAQpqx7Aqedmwo4iCEilM?=
 =?iso-8859-1?Q?SSjbxK8CRm93EOOIdOMoOdxn8pexKjTF+Y99oV9RfuAcmonvrTrgBPemn/?=
 =?iso-8859-1?Q?sfSUNwfSZ7hesNc/PP1pdj+GvqopucdgwWHueFR5MO/wDaJS/dXE6LIas2?=
 =?iso-8859-1?Q?c2b2ddUftjToGZd8kUyDzTGJrH28N87H1Z1wS85URMRVzVnSLD+mWX4SZ8?=
 =?iso-8859-1?Q?yZOhb1LZuwe3W6jGYVmz2xVAh5colcEC9idPfqExiW8eD9C8KENE51XgDr?=
 =?iso-8859-1?Q?Ro120tHnR8vQ3B+dmgmfmJbTk4mDH/Fa6w+DdQJh7BjL7bNrqOj/fXoN+y?=
 =?iso-8859-1?Q?ytkKeWbJjVVzRYOJn0VVe93u3zrzM5O9cjvJCNdtU6WqPEJZ0ecmPtAgtM?=
 =?iso-8859-1?Q?zqAd90Ps0aLNKtsb3qQLskR6iXtUND3tpRpCO3FBK1zNU/hfjRK4X7EfRl?=
 =?iso-8859-1?Q?/f88viExHN+y1S8OOrAcJPqN9xoPPq7LuxLq5z5SS72KQAxMDABvunafmi?=
 =?iso-8859-1?Q?s5CS0EkiO/w/f6BYSoVZUinJ2EPduwNoZSbec40UBZz/9lGn+oZFYk//d9?=
 =?iso-8859-1?Q?CT7or0aAQieYoPp4LYTYH/+AZUN6ofRc1b3u/kjQ+yBbVElPsHD7XGKQxB?=
 =?iso-8859-1?Q?Ghtj2wcRfs5S7gDtLphmKJFwUkPkLMHfv6CkT8OmxIDuogqRR1AfACpdiS?=
 =?iso-8859-1?Q?omXX0pxRQnF4DZnfBf8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f452e43-912b-4dfe-eb65-08dd83f0f2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:44.4147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2miDzpKcB6tQ8DedxJg65Kxfy7r/gCTFpsmL9hQAjLdI2gIWKJwbydqR6ggMcWpYlV4S7WlQTTWF101BDSCZLnByoYD5Wi4xux/uIpckxDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3713
Received-SPF: pass client-ip=40.107.105.110;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:57 -0400
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

Introduce MIPS P8700 CPU and set reset vector to 0x1fc00000.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4cfdb74891..da2fb11d93 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -53,6 +53,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..029e2c7929 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -514,6 +514,34 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp =3D true;
 }
=20
+static void set_resetvec(CPURISCVState *env, target_ulong resetvec)
+{
+#ifndef CONFIG_USER_ONLY
+    env->resetvec =3D resetvec;
+#endif
+}
+
+static void rv64_mips_p8700_cpu_init(Object *obj)
+{
+    RISCVCPU *cpu =3D RISCV_CPU(obj);
+    CPURISCVState *env =3D &cpu->env;
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | =
RVU);
+    set_resetvec(env, 0x1fc00000);
+    env->priv_ver =3D PRIV_VERSION_1_12_0;
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV48);
+#endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_zifencei =3D true;
+    cpu->cfg.ext_zicsr =3D true;
+    cpu->cfg.mmu =3D true;
+    cpu->cfg.pmp =3D true;
+    cpu->cfg.ext_zba =3D true;
+    cpu->cfg.ext_zbb =3D true;
+    cpu->cfg.marchid =3D 0x8000000000000201;
+}
+
 static void rv64_sifive_e_cpu_init(Object *obj)
 {
     CPURISCVState *env =3D &RISCV_CPU(obj)->env;
@@ -3261,6 +3289,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1=
_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_=
nanhu_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_MIPS_P8700, MXL_RV64,  rv64_mips_p870=
0_cpu_init),
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu=
_init),
 #endif /* CONFIG_TCG */
--=20
2.34.1

