Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB79CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Leu-0003yA-BZ; Wed, 24 Sep 2025 05:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeX-0003nU-0D; Wed, 24 Sep 2025 05:19:09 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeT-0002zm-E2; Wed, 24 Sep 2025 05:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDeTLiMS1xxvmSk0cMlEaGVrw67xvGqNzkGVaWidlL4u4n4pR/otzDWMiB0NNijwOUEUMFgqfk+gvK20xzEymPdLUAPmBAKeS4eIAAdZbxj+2ri+x3rvXq4AFHa1gXQNWwEWDFBcisM3qQJ2Bfz5kg+GnUJiJl5Zug+h8AXc/cpGSTkNk/6qx91z+WhoWpzqfi5pQH58/HpuSJybUQUXBnCxpV9nqmn3/5OKMow72FM8z7X8Y5rKoL59c4PDn4f0yI5FZkEzQ4IlGki7SOR+iNXMNiA+Yq/INL7FWY4KOIdrU879dvHskJ9EP+7Zf3PJznYGk7GEaLdjPgRj1Zer8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnALfnlm/Vpkyi1mSgG82l415+049KVo4AON3Xp0OwA=;
 b=Bhl7REAj6omsHxuQwUeUDXKY38j3sv7cSxXC6+fAFTiILCzNcev2iTGOqbhR5Z2irSNA1Cbm+uHvj3amb37IGFUXRVTuBGBr2ZWuuLeHEpMVhFbdbWBt3viXUWbNUeJHT0VpHZDV4Swu5ot0sbBMNSYiJT99nkUcuLcziFkV+tV1iTji+3td+lqOx5/g0pG8Kw2OGUpwlKA5fDGa7j3msezXwxbhd4JSCvyYHhOQxSqvdL020Jh13DzxkD50lWsSMCz5MrZnZCq7wQ17LHItjNYzv3HgXnqIHb7PJlCKsPM/EhxlaY5SoE0nWpic+XA/H4wZv58wsnNU+Q/V+Gayyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnALfnlm/Vpkyi1mSgG82l415+049KVo4AON3Xp0OwA=;
 b=FKhmykKLxQud0DnGkbyPdGGnAtC66Et4zLeHuMF2rbRwmxhEE9faInKEi/b+Y9/Oe8ds88RWvX5CBhHStxL3cCWU9SXjwtlaeTAtqM5J3VmAZaFUy/2fBHiSAZwZ+9bw0XqlgfrdbRhH0y+MQUM5M2lFU5Ri2v2KFfILeC9vuMjJmcTau+jY9c5k5Kv0yq9LFkcq6hafZqUowowCdOK8yxD9A3Fn5w/irayFVMo9HYTqkqE89MmmlW9UNw83yz4HJYqH7rx/F576w2xN6qfAbAiElAul6f+GzZHgXbkvZfOsIEikKGxXJDGNf/rm97DeLir0BaxDeJYfVxWKKW8yTg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:22 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 13/14] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v8 13/14] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcLTQq/PmzLV+X60OT7+e3eV5Quw==
Date: Wed, 24 Sep 2025 09:18:18 +0000
Message-ID: <20250924091746.1882125-14-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: 3a23954c-d181-41fa-1fdf-08ddfb4b4ed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?m5YBOql6ezSdgUqNpqdIJsvQdLQdZ40qmggwy0berpG+JvY0KauUMEENGj?=
 =?iso-8859-1?Q?u9X+znYNpFc+iIeLWEfsjbVPK6qc5S1qr4s4n6KRy4eFbrLPMr5ALnnuZS?=
 =?iso-8859-1?Q?j7FN5htCWcPRkko7Uia4Lq8bxw/P84Gi6F/graFlczWRCKjzuDlsmB0evA?=
 =?iso-8859-1?Q?aIVowRwTbh/RikSKi2ti45+Lvjoxv2T7zETQaesG5AXzNvXWWcy4v8Xalx?=
 =?iso-8859-1?Q?O4W8s82pq838KWDJDv/oRS1XCGmqDQUlcjBExhvCDiXM5OR3td41OrWCb+?=
 =?iso-8859-1?Q?K0VUAty+PYTBIquJlvrK0WZDQR6hQC0zAuMOE/zXFMQUE1M+1w0+NH/G9F?=
 =?iso-8859-1?Q?SR+d1r6H4yhHQSCLkGyLdp6BBNCO5FOpW15oippPq0N/HWE5l+5aNswVYa?=
 =?iso-8859-1?Q?/I6vA6Mybla8v1J7Ji8ho+uRDvo1eV/ec5HKVZixPvLx2nU8hqOxnPIvpB?=
 =?iso-8859-1?Q?aLe5MW8wsllRLtyoOH2C/keeRLQ8rIgjcmdg10gETt2+St+l2FVfucAMWF?=
 =?iso-8859-1?Q?r73uNVY//3hTC6MSQBeX8CNPtUpxcFvAC2ns8VJmWbSUcJPffNEMkbHsF+?=
 =?iso-8859-1?Q?FGw2QepjhTQvwbk5/SFWeFy6NLn9cCV5FT2Gj+Hl7atAhiHnHOz9dMww1R?=
 =?iso-8859-1?Q?ard6G1l4zmVnc/1WgD7ALHAiLE8TCsJ8vWq7WAhcpZx9y585hBTPrQXeQd?=
 =?iso-8859-1?Q?Wyg6PgWaR6an96I8CrtGx1NwyumVv+bMv3mdX5L7UuVt4MfxLqkx/on4nN?=
 =?iso-8859-1?Q?PnIRXZHr7X0f3NGmzlXjQEgtVZIV1z5bQW0BhaaxJRT87hxMucrRvFbRMA?=
 =?iso-8859-1?Q?g3VSgZ7M2MRPoJDLKTF9WbwHeYFOzKK3AoCOrXNJZwZxLK9Q/l1xTqdb98?=
 =?iso-8859-1?Q?haAHtgwrHohV6xDqJdwkh3YZBopPkML4/pE16wIjmP4bBg5ugvpg5K/Fls?=
 =?iso-8859-1?Q?9jGrb5d0W/1xABEKRF14p5WT459P/SKYrTGwIQl2iphvgpoKoMJMDFnNan?=
 =?iso-8859-1?Q?IRy4HmnfRFB5YfAwvlSYLDlKGks7zJvz7dNF8d68HAPyv5kgA3CHz+PhHn?=
 =?iso-8859-1?Q?rCknjVsbTyoYmWBo33uhmkumhc/z+NB+iaiLYW15K1+h0bGnKHiT3Hdhsf?=
 =?iso-8859-1?Q?q3L1pyQkVIWi5A+l6kPs3ELLD4cLNIpyaW18+TDoGTok7ioaflInzXtY1b?=
 =?iso-8859-1?Q?pbZf6jzZcVaOZX+VCIgsfGAKw6d9+jzKsBYNB/J3WEL+FFCqGoEXx5LTm3?=
 =?iso-8859-1?Q?1U6s925M+8uCZl4DudBKM0vtCUgDcW0nmlb8PtusGqlV0GYvbonufSp9BG?=
 =?iso-8859-1?Q?kyT0ygNsq+x1fkiKJajDd+hJPryzyO0WmlqZm7+Vo65Uw8tayvjX8BvxBO?=
 =?iso-8859-1?Q?VVK5ImePYiwSJnJYvORoQFQBqr9r1fWJuc1fmZKQSgjPfFIXDKil4WcqjU?=
 =?iso-8859-1?Q?KxVpwjrEiL7RrJICL++NozAn2HhZ/Zq9vqkjuLd2pR2T/s/zeMKbKRK956?=
 =?iso-8859-1?Q?zd/SXXTTDydoXuVHh8dEzzqIlpe5LdXgb9LV1gX44bSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ks8g6lcAQs7ArcKoPxEgKJ2vczEoDDUBpqWeqnnImtnMv4y9tVHCGbDvGE?=
 =?iso-8859-1?Q?PcXyEM249XxI/otWMYQugUYFhP0gXpkC2qRJz2kJ0JG+Vz12OVxLo/g8av?=
 =?iso-8859-1?Q?3dN9On2jzWBPLGW0JNFNurctWq2PrHsJ8dFjWlU5masvgq+5JnjZInhluz?=
 =?iso-8859-1?Q?f7moWnCQrViMHQSL3ltV/+a8C0VQPO4+6VXPy7HDLc+8HJPZKz5DryuuNG?=
 =?iso-8859-1?Q?P842h8qGwiSy7jFOWTkyaUCCVLMPdOnrWhT+h8cYLuCPw3qRZg8CAlm464?=
 =?iso-8859-1?Q?7cZEAABEUWRT1N0tZMRPHNtv4cVX6PSnBdEUFQidnrI9xrS4ULt6ACJmIQ?=
 =?iso-8859-1?Q?EFpbnTVYpDIp0CbbldoNbHNOZLOFr0kazqGrVia/8Xsf6GS13OfBps4c6u?=
 =?iso-8859-1?Q?3LnUF3XhkZfAJwVTafnCbLdfNSehfxa17vUEEzDrJy2Ywun4Lzx0dLt3Vr?=
 =?iso-8859-1?Q?4L3QXpqIffUOPyX06Bg2yUHmfKqc4TZQz4afvb/6jPVUy4Qjqs4D6vbnOQ?=
 =?iso-8859-1?Q?aJglQah3H6a99VtaiS+9VnjrT0uq71inTEPkb5VuaJTEazvRFvCR8wKMj/?=
 =?iso-8859-1?Q?GZswVWyXH3/WNwPsgSc+g2jJUweWGx5e21oh0yVrMMrIsgMuuq2Vun4ISK?=
 =?iso-8859-1?Q?/UU7qoxRIw4DYSoetpA7muWOwXeYpx0J1leM4g1vrBFR/enON2I4xyiGBY?=
 =?iso-8859-1?Q?K2PfCQcIgScIn3SFS8WuJiU2FWkkOR+/nw7cMoLj5HMwpaVNFdKwnoVeXQ?=
 =?iso-8859-1?Q?upiSpV7nc0nNtUNkZUfG47MeB/l4YHPytma2FOcYhLCX/m1qr7L7OQQNK+?=
 =?iso-8859-1?Q?rhKRv9VFqIe/BDfeixGxNqpkGXi1X4uAxbwSNmAsd2OcmDrjCgXKhzY7qF?=
 =?iso-8859-1?Q?tmPIkAmB5xKTtndqrDdKTBh/I9hMJ9sFBSgSLdWfr3WdTIdcoVXuj6WDZr?=
 =?iso-8859-1?Q?6RB07z4VS4wbipIA4N+BSihJZVFWeo0Q5blCPyflQIVgWvkvmLaFG61axN?=
 =?iso-8859-1?Q?57me+NPI+7P2sY14Ehu6aQbIv7es3N26Lc6qnC95vd155xnWiyE5y6COva?=
 =?iso-8859-1?Q?R0y07BIY3iAmXguEMBblT4y1LoNqVtCUHzyem1lhUbbjsRXbfIYb/MGp3H?=
 =?iso-8859-1?Q?KlH9X4/PXnu5md7xH6Ag1+N2VEv7Qzuq7C17jPa5jMGdI90dpCvfcWXKEm?=
 =?iso-8859-1?Q?Sr8i+BBZ+AX3eAnu/1W8UTVEHunroChV4F6YYOM8C+kEy/H47G+0Zg/2gz?=
 =?iso-8859-1?Q?EEiw7byTWkxy8LPpCIQv8GljOh7W1QrpqlopI+HcFOHqwfdlL3wVbz34oV?=
 =?iso-8859-1?Q?Ys2aqvajIwnPL7kt09/8s/MpDIvotgXOBhn9a8MPJQ3nUUZbuDcLQbg1pg?=
 =?iso-8859-1?Q?Wp0Kap1G4GTaujAvXj3gsKme+9rkepO1agaBqkNTBa1QjXVybF9tE6V5YH?=
 =?iso-8859-1?Q?AgTtKQda07HoocUXuXj9J1HfOLwE1EruZpQYC8jyQ25jmX9keJ7o4WVcfC?=
 =?iso-8859-1?Q?faAcy9JtQN+m8+sQVnw4VtwIUv3nRAQvDihFPnaUf7K0+d1UcDo1zL6li0?=
 =?iso-8859-1?Q?VxOEV5DAcwpk6+bMUuTr8Qtv6pFsY0w1XTCvcEjfI4XBR92o2LnYcV52fA?=
 =?iso-8859-1?Q?0JjacugrkO+ksgcWW1uyD8QU/q/98pHp+X8D1jIxOhAGv12gQ5tKYyHT/I?=
 =?iso-8859-1?Q?kBwE1ED8ucePQvVGG1E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a23954c-d181-41fa-1fdf-08ddfb4b4ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:18.3271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whwrxMZbqTpCSeWdOu8twAd8J4AvlJhOAJoyzl1k8V1tsVuPhcaKU8v4JZYkd5IlNj7KfyZniGmh2yD/4+3yIPzAH53amHm0MaoJC4cKjSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index f7c4bd0f85..46b7f1a3d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -425,6 +425,11 @@ static void boston_mach_init(MachineState *machine)
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

