Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC1DC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCt9-0001OG-Ex; Tue, 18 Aug 2026 02:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saini.ranbirs@outlook.com>)
 id 1wwCt6-0001MZ-M5; Tue, 18 Aug 2026 02:01:28 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saini.ranbirs@outlook.com>)
 id 1wwCt2-00076T-T3; Tue, 18 Aug 2026 02:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V23Ff+0JSP3aRQiHtvs08NqlztaHYMV7scOe7/BsnunjJHKI0qyGQZRdQ6btxo9WRLMOfCWYT8j1UwgmPuqdOUcMe7Zo9MyBArK7gTRQHkJuqV13dv3yEklBsnaGD0LGXkfK7VFIRUrPc2EAhgeRcrjriiSvA+C+QZXJieQG4SJ+juUR1J4/PQ8h1c0wwrnQ4akq3ye7c/oVqRJcj8XDOltULGigpnYW0Uz9TLjWak8nAt1ipQ20LF4NK6B64s2KzQZZI/iZQ+Ws60BuKsZbCXLf7WHzllQ+wv5DShONwyqLIF0vz4uakQKsTeGb/z/lHOxEZAmCzcVeTobzwRDdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aPcQEE7cWgRrHi/K5g4hVTGWyfP2QyoNZmoVSiELLo=;
 b=GhjvKU7RvLWdFUT/6lEH+bl++CYzMo9ODSUp9kIF1dyE5vl0oe/2yab+a9moJJKdzZAdRCfOvu23U+8pKqCUofbA9a68v7fFc4xPGlQPdYYvz5ZHYZB6KJQ9eeoXCigbUSwWLl8LxJ//LN/G+TFBBPaYndAADN4JJfsnr+mwIy0PENmbMoXQ3F+noqmR9YrpE1Kko7i1ecrAHv3XNffAyrYxuLUuQbR9msOkTQEatalgRim7U1Qo9GHOXeijcfVi49ASly07K1P7Ds6oSyjF0N9hAmICJJgYc4Xuu3MdatrrQCwZne4WSdLPTZLJdqAV+YqBB+GoxLpI2bquts73tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aPcQEE7cWgRrHi/K5g4hVTGWyfP2QyoNZmoVSiELLo=;
 b=AXqb31KpjPU2PNyGQc6rqOgiZ8ylpN5Xk3UV/Fw8662Wi0kQ2Oh9ZiU1QYvF80LN+x+H/JAosldecohhP3NxgdxUw/ue7fy7o4L7kLyD6s6Myuz+bV2IaNap4x2NqAOmqtJonwHRRqZ22TGQMOj+apd9nFOP1FeFqU3v7ALZmJE6HK90o/AIKv5Q+HkscDwb/lJRt+3AQrYpHcuUtBbI+5xbA2maOTU/STEWYRC6K12C69abqWyZIF7BhNYYz1qS8Jtda720XkdW21PyGs4OK2Ro37M+RtkPs784UgziyBc2kAF0tHwR1P6X4D2+EMRhHhVzSj7mgZOeu/OEgY0Tfg==
Received: from TY2PPF45B8CB2DB.apcprd03.prod.outlook.com (2603:1096:408::9d0)
 by JH0PR03MB8170.apcprd03.prod.outlook.com (2603:1096:990:3a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:01:16 +0000
Received: from TY2PPF45B8CB2DB.apcprd03.prod.outlook.com
 ([fe80::9f85:6f19:548a:7ab3]) by TY2PPF45B8CB2DB.apcprd03.prod.outlook.com
 ([fe80::9f85:6f19:548a:7ab3%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:01:16 +0000
From: Ranbir Singh <saini.ranbirs@outlook.com>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
CC: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu
 <chao.liu.zevorn@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 05/10] riscv: add RPMI system reset service
Thread-Topic: [PATCH v8 05/10] riscv: add RPMI system reset service
Thread-Index: AQHdK6kqExHW3ZAu6Uuy+1uhNySaaLajVjIV
Date: Tue, 18 Aug 2026 06:01:16 +0000
Message-ID: <TY2PPF45B8CB2DBE53D343D120C1CEA0A9BF9A62@TY2PPF45B8CB2DB.apcprd03.prod.outlook.com>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-6-subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <20260814045315.3416169-6-subrahmanya.lingappa@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF45B8CB2DB:EE_|JH0PR03MB8170:EE_
x-ms-office365-filtering-correlation-id: b67c65f2-e129-402a-8286-08defcee1ded
x-microsoft-antispam: BCL:0;
 ARA:14566002|15030799006|39105399006|24021099003|31061999003|22141099003|8062599012|19110799012|8060799015|25031999004|21061999006|41001999006|25010399006|15080799012|4140399003|40105399003|2607281247196008|12091999003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YMT0LO8mEqJf3OE4yAkqVPew9VOjKXN42BWTvBJ5IG3P237+RqGn93uQQa?=
 =?iso-8859-1?Q?DD+q3xU9FmvoXlwWVZ+zqX8gmE/rsa1KP+WQiYcs+y9AADdHGQ8JRJFSzJ?=
 =?iso-8859-1?Q?OVkIUG++m64Y2veAROhIZkVpXlFe6tUfq08H0DofYio3U04CmzB4E9ccCk?=
 =?iso-8859-1?Q?I+eSxjvcqmBPfVksjgpuOp0tBuKME2Hudq1DQOlZvOtnlyu02sNyK/sXdw?=
 =?iso-8859-1?Q?H+b6gB5fIEyZsWeHhDdgh20pnNXTU7QPoTXVCOm0RfX2CAzCeMzof7WMS3?=
 =?iso-8859-1?Q?cGQl51Pft1hl/EG3keLVGl8YqFWTSxttEdA+jcvGOp38zCAt/gg9l3Km1C?=
 =?iso-8859-1?Q?ixooJv4V19y/q59QmQT01A8NYDCBijNUu1aEf42ZnAUgy56IHTBYfzNnOk?=
 =?iso-8859-1?Q?0B2EFFDZwV896288PgzI3j+2QwAdZG8fCj55o6ZNTL/He+FYz+Jft6pUCD?=
 =?iso-8859-1?Q?0ZBhhZSkZtc0mz+FbD6o5koYpBRN4r7w6MLS0eeI9cLuBuKl/FuwLAqcW3?=
 =?iso-8859-1?Q?xHK6Xr823FY6/tMbVSkPhJTjCYu62+UAHflIaHlOCriTqGamq/RRxDKUX6?=
 =?iso-8859-1?Q?x9DYNdkGn+aIMsDkT5MeruZSy8mWvHwWzrrJEbjweNzhIx+QzCKUSZKk7t?=
 =?iso-8859-1?Q?VqrGXw1EN5by75h9Ab8nU4/IwgOHtq5W5fZT8+2Glw1XcC9pP5KOaYdPSP?=
 =?iso-8859-1?Q?0KQXeDnXAaEjgeaKYLj3tl+qUSNX1iKoKMYBGLspvjBaBUg6Y1LNJh/9Bq?=
 =?iso-8859-1?Q?DaKqdo7U1te/mC7OsFRMKEzv536nEBNAwjQAvJKuVIk5GXph0UprFvJ1kH?=
 =?iso-8859-1?Q?Gm9NaAW8WwoaiYzjdyDVRoUt74eoakOvWtIAQ3xFqFRjLcr78Ts1NtqS1A?=
 =?iso-8859-1?Q?BRcvzcsqu7Ef6ZmJbJavQm1QzKLIZ8kGoElBjO1optW/ekQade41ZOsWwE?=
 =?iso-8859-1?Q?64Po7Ql8kwYXfkKGoLzXq9YU46oeRy0tZ4o3sspi3Hm8NnMvzOUMKkfJzL?=
 =?iso-8859-1?Q?sVKk6Yq1Q/oT9tSWbKyIlGKdyZmK7ts7NLYBhBkazXjHoAVuL19bnLKe06?=
 =?iso-8859-1?Q?bAyQq6L9qBqF/HT7tLTyhUDDGll6Ca7jtON1pI2XB/CSmclViAEmUByhHr?=
 =?iso-8859-1?Q?BLj1+gzEvDgP1deoSe1k9KMM2uQCLJN1OPbbrBW3hl5JU9rYlg?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B2yPTY1C8LcWVsoAyIhGUC9Fk9O9sMFGOQ6sI1boJbM7048DPo+JP4QZmC?=
 =?iso-8859-1?Q?Hjg9Oh5UXBIa+exUbxiDru2pAKeG5B+BKOnAoNYNX5o0MXSOhajqwqTOyU?=
 =?iso-8859-1?Q?dhsbu5twr3GJPgp4TYERYQOOF1bqEI/yA6zg7rNGSqTzH1JkhPTbK3W++n?=
 =?iso-8859-1?Q?qHKkQpQC2tHPsyYKNqnBbBnlV9+X7GpxlHuN69w+oXQwMPgaIHU385z+Nm?=
 =?iso-8859-1?Q?H3Cg9obw+NSHMBqjdS9ze6nfHLwkgh3sHxx0Df9as53z4Uzeg5jylMOhq6?=
 =?iso-8859-1?Q?rZ/p9TVrMzx/XDulSPwRlbrRju7Vm4Az8ByeZMVcPIrBQhS6Ia+VHblw/8?=
 =?iso-8859-1?Q?ODkp2X1kz3ul/kRUOJFchhrFL3xqfqSrcHscygRlkpp3AFqLXkcwf0YAUr?=
 =?iso-8859-1?Q?SyCN7BajVFpUsiyPPkaBkYhFgGU3qSi1AvJTZWarz/j7zseyI2y1ENvJOF?=
 =?iso-8859-1?Q?udG7TUC1fFpM23JOtTAAY6cxj/ohSLujUqHqYScL/CY8J8JG5O12BM7+AV?=
 =?iso-8859-1?Q?Mq/gTSms7GXP1mYKDtwJWSbIxG2zfIb66JblpovOgKUJf1t02ShLpe5NTk?=
 =?iso-8859-1?Q?ItHAK5V3OXdmnccecRWaTPLLnH8YArLMvc+E5fGN9Gq0xvXFyIUqySAhmO?=
 =?iso-8859-1?Q?+0wAfNV8WZV93rIvaD+yi/rHMvqFH9nPrjf9snEuQEG+bRFzpY3fwz40vP?=
 =?iso-8859-1?Q?3BDCg2UJ/L7F4/ZxQ0K5tgSWSFMYQWtPIn1uk3JXjRfqF45Ya2pvkqtUWQ?=
 =?iso-8859-1?Q?h+xLF5EIgjuErgS6/cOjW+Cdv/diClpezcYUZqlai130wsiY6jd4oXrzOf?=
 =?iso-8859-1?Q?aRNGGf1KYxaqd0P8o6vpdhjTKgDYvWL1n35O+t4WJj95tw3v4+7NOds5B5?=
 =?iso-8859-1?Q?ybeTferf4fCzDrauC/aBT2kKfKCElnK/k8SK9yXCxMtzKxCmrTtcI94zC0?=
 =?iso-8859-1?Q?5aMGtZictA12cEr6pOmOzpBQHdVrk2hDNtKf0zThsf+tsz9tkpL2A1V8yP?=
 =?iso-8859-1?Q?Cc1FwGEFeaejUMsQ+2FMkOV5O+i/frWOVGaHKPzaheMJqOvnxK7gcQT1YG?=
 =?iso-8859-1?Q?Cv46b7Wp3CQzSLHOY17dzT5/has/nYa6HZQqDnYn4ZPRXUNoYeHVesBaVg?=
 =?iso-8859-1?Q?n97jOqbInOjWBVUadxhbNLYJYA79lIj7zwT+5LC9viyzovua9ArjEFf+nL?=
 =?iso-8859-1?Q?l/KHqmkyuJzJkWjyEtzren2U+Fgjg3c4uznr+Ab/RsgDVU7gsdZtfUuZ2d?=
 =?iso-8859-1?Q?zUgWxYcRA1jNRqLJQwNgNX5yWjkSvzpCKzr6Fl8mUUjR3OtGciKjjqRYwt?=
 =?iso-8859-1?Q?9SANB+NJ0ExogKE7CjSH7sn4+fHcwaKP5mBdeEBX008Bctc5Eg1RmIthfG?=
 =?iso-8859-1?Q?z2nfut5BNA7U7NZG+kz7MWAjvF4LZlBmMxQhDM3mjdfoB5Twmhl1tHYE94?=
 =?iso-8859-1?Q?NViwDcFfDfy3PjLj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF45B8CB2DB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b67c65f2-e129-402a-8286-08defcee1ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 06:01:16.7474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8170
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=saini.ranbirs@outlook.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

=0A=
=0A=
=0A=
________________________________________=0A=
From: qemu-devel-bounces+saini.ranbirs=3Doutlook.com@nongnu.org <qemu-devel=
-bounces+saini.ranbirs=3Doutlook.com@nongnu.org> on behalf of Subrahmanya L=
ingappa <subrahmanya.lingappa@oss.qualcomm.com>=0A=
Sent: 14 August 2026 10:23=0A=
To: qemu-riscv@nongnu.org=0A=
Cc: Subrahmanya Lingappa; Daniel Henrique Barboza; Palmer Dabbelt; Alistair=
 Francis; Weiwei Li; Liu Zhiwei; Chao Liu; open list:All patches CC here=0A=
Subject: [PATCH v8 05/10] riscv: add RPMI system reset service=0A=
=0A=
Add a QEMU implementation of the RPMI System Reset service group.=0A=
=0A=
The service advertises shutdown and cold reboot reset types, validates=0A=
guest requests, and dispatches accepted requests through the machine=0A=
reset and shutdown callbacks. This lets firmware use RPMI reset commands=0A=
while keeping the board-specific reset policy in the RISC-V virt machine.=
=0A=
=0A=
Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>=
=0A=
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/meson.build           |   1 +=0A=
 hw/misc/riscv_rpmi.c          |  70 +++++++++++-=0A=
 hw/misc/riscv_rpmi_internal.h |  12 +-=0A=
 hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++=0A=
 hw/riscv/virt.c               |  51 ++++++++-=0A=
 include/hw/misc/riscv_rpmi.h  |  15 +--=0A=
 include/hw/riscv/rpmi-fdt.h   |  11 ++=0A=
 7 files changed, 349 insertions(+), 17 deletions(-)=0A=
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c=0A=
=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index 92c9cd6064..482f56504e 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -170,4 +170,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('=
sbsa_ec.c'))=0A=
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))=0A=
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(=0A=
   'riscv_rpmi.c',=0A=
+  'riscv_rpmi_sysreset.c',=0A=
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))=0A=
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c=0A=
index 54a790fc7c..9575cd3a8d 100644=0A=
--- a/hw/misc/riscv_rpmi.c=0A=
+++ b/hw/misc/riscv_rpmi.c=0A=
@@ -171,10 +171,37 @@ static bool riscv_rpmi_transport_indices_valid(RiscvR=
pmiState *s)=0A=
                                           s->a2p_req_size);=0A=
 }=0A=
=0A=
+typedef struct RiscvRpmiServiceOps {=0A=
+    uint32_t service_group;=0A=
+    bool (*add)(RiscvRpmiState *s, Error **errp);=0A=
+    void (*remove)(RiscvRpmiState *s);=0A=
+} RiscvRpmiServiceOps;=0A=
+=0A=
+static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] =3D {=0A=
+    {=0A=
+        .service_group =3D RISCV_RPMI_SRVGRP_SYSTEM_RESET,=0A=
+        .add =3D riscv_rpmi_sysreset_add,=0A=
+        .remove =3D riscv_rpmi_sysreset_remove,=0A=
+    },=0A=
+};=0A=
+=0A=
+static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_group(=0A=
+    uint32_t service_group)=0A=
+{=0A=
+    for (uint32_t i =3D 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {=
=0A=
+        if (riscv_rpmi_service_ops[i].service_group =3D=3D service_group) =
{=0A=
+            return &riscv_rpmi_service_ops[i];=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return NULL;=0A=
+}=0A=
+=0A=
 static void riscv_rpmi_configure_base(RiscvRpmiState *s,=0A=
                                       const RiscvRpmiConfig *cfg)=0A=
 {=0A=
     s->platform_info =3D g_strdup(cfg->platform_info);=0A=
+    s->machine_ops =3D cfg->machine_ops;=0A=
     s->services =3D cfg->services;=0A=
     s->service_count =3D cfg->service_count;=0A=
=0A=
@@ -211,7 +238,9 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetTyp=
e type)=0A=
=0A=
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)=0A=
 {=0A=
-=0A=
+    for (uint32_t i =3D ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {=
=0A=
+        riscv_rpmi_service_ops[i - 1].remove(s);=0A=
+    }=0A=
=0A=
     if (s->context) {=0A=
         rpmi_context_destroy(s->context);=0A=
@@ -234,12 +263,12 @@ static void riscv_rpmi_cleanup(RiscvRpmiState *s)=0A=
     }=0A=
 }=0A=
=0A=
-bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind ki=
nd)=0A=
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_group)=
=0A=
 {=0A=
     uint32_t i;=0A=
=0A=
     for (i =3D 0; i < s->service_count; i++) {=0A=
-        if (s->services[i].kind =3D=3D kind) {=0A=
+        if (s->services[i].service_group =3D=3D service_group) {=0A=
             return true;=0A=
         }=0A=
     }=0A=
@@ -247,6 +276,30 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s, Ris=
cvRpmiServiceKind kind)=0A=
     return false;=0A=
 }=0A=
=0A=
+bool riscv_rpmi_context_add_group(RiscvRpmiState *s,=0A=
+                                  struct rpmi_service_group *group,=0A=
+                                  const char *name,=0A=
+                                  Error **errp)=0A=
+{=0A=
+    enum rpmi_error rc;=0A=
+=0A=
+    rc =3D rpmi_context_add_group(s->context, group);=0A=
+    if (rc !=3D RPMI_SUCCESS) {=0A=
+        error_setg(errp, "failed to add RPMI %s service group: %d", name, =
rc);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+void riscv_rpmi_context_remove_group(RiscvRpmiState *s,=0A=
+                                     struct rpmi_service_group *group)=0A=
+{=0A=
+    if (s->context && group) {=0A=
+        rpmi_context_remove_group(s->context, group);=0A=
+    }=0A=
+}=0A=
+=0A=
 static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)=0A=
 {=0A=
     uint64_t queue_bytes;=0A=
@@ -318,11 +371,16 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiSta=
te *s,=0A=
                                          const RiscvRpmiServiceConfig *ser=
vice,=0A=
                                          Error **errp)=0A=
 {=0A=
-    switch (service->kind) {=0A=
-    default:=0A=
-        error_setg(errp, "unsupported RPMI service kind %d", service->kind=
);=0A=
+    const RiscvRpmiServiceOps *ops;=0A=
+=0A=
+    ops =3D riscv_rpmi_service_ops_by_group(service->service_group);=0A=
+    if (!ops) {=0A=
+        error_setg(errp, "unsupported RPMI service group %u",=0A=
+                   service->service_group);=0A=
         return false;=0A=
     }=0A=
+=0A=
+    return ops->add(s, errp);=0A=
 }=0A=
=0A=
 static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)=0A=
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h=
=0A=
index c263033634..ca9838d256 100644=0A=
--- a/hw/misc/riscv_rpmi_internal.h=0A=
+++ b/hw/misc/riscv_rpmi_internal.h=0A=
@@ -18,7 +18,15 @@=0A=
 #define RPMI_PLAT_INFO "QEMU RISC-V RPMI"=0A=
=0A=
 extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;=0A=
-bool riscv_rpmi_service_enabled(RiscvRpmiState *s,=0A=
-                                RiscvRpmiServiceKind kind);=0A=
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_group)=
;=0A=
+bool riscv_rpmi_context_add_group(RiscvRpmiState *s,=0A=
+                                  struct rpmi_service_group *group,=0A=
+                                  const char *name,=0A=
+                                  Error **errp);=0A=
+void riscv_rpmi_context_remove_group(RiscvRpmiState *s,=0A=
+                                     struct rpmi_service_group *group);=0A=
+=0A=
+bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);=0A=
+void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);=0A=
=0A=
 #endif=0A=
diff --git a/hw/misc/riscv_rpmi_sysreset.c b/hw/misc/riscv_rpmi_sysreset.c=
=0A=
new file mode 100644=0A=
index 0000000000..775eb5483f=0A=
--- /dev/null=0A=
+++ b/hw/misc/riscv_rpmi_sysreset.c=0A=
@@ -0,0 +1,206 @@=0A=
+/*=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * RISC-V RPMI System Reset service.=0A=
+ *=0A=
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.=0A=
+ * Author:=0A=
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "riscv_rpmi_internal.h"=0A=
+#include "qemu/log.h"=0A=
+#include "librpmi_env.h"=0A=
+=0A=
+typedef struct RiscvRpmiSysresetType {=0A=
+    uint32_t type;=0A=
+    void (*action)(RiscvRpmiState *s);=0A=
+} RiscvRpmiSysresetType;=0A=
+=0A=
+typedef struct RiscvRpmiSysresetGroup {=0A=
+    struct rpmi_service_group group;=0A=
+    struct rpmi_service services[RPMI_SYSRST_SRV_ID_MAX];=0A=
+    RiscvRpmiState *rpmi;=0A=
+} RiscvRpmiSysresetGroup;=0A=
+=0A=
+static void riscv_rpmi_sysreset_reboot(RiscvRpmiState *s)=0A=
+{=0A=
+    const RiscvRpmiMachineOps *ops =3D s->machine_ops;=0A=
+=0A=
+    if (ops && ops->system_reset) {=0A=
+        ops->system_reset();=0A=
+    }=0A=
+}=0A=
+=0A=
+static void riscv_rpmi_sysreset_shutdown(RiscvRpmiState *s)=0A=
+{=0A=
+    const RiscvRpmiMachineOps *ops =3D s->machine_ops;=0A=
+=0A=
+    if (ops && ops->system_shutdown) {=0A=
+        ops->system_shutdown();=0A=
+    }=0A=
+}=0A=
+=0A=
+static const RiscvRpmiSysresetType riscv_rpmi_sysreset_types[] =3D {=0A=
+    {=0A=
+        .type =3D RPMI_SYSRST_TYPE_SHUTDOWN,=0A=
+        .action =3D riscv_rpmi_sysreset_shutdown,=0A=
+    }, {=0A=
+        .type =3D RPMI_SYSRST_TYPE_COLD_REBOOT,=0A=
+        .action =3D riscv_rpmi_sysreset_reboot,=0A=
+    },=0A=
+};=0A=
+=0A=
+static const RiscvRpmiSysresetType *riscv_rpmi_sysreset_type_by_id(=0A=
+    uint32_t reset_type)=0A=
+{=0A=
+    for (uint32_t index =3D 0; index < ARRAY_SIZE(riscv_rpmi_sysreset_type=
s);=0A=
+         index++) {=0A=
+        if (riscv_rpmi_sysreset_types[index].type =3D=3D reset_type) {=0A=
+            return &riscv_rpmi_sysreset_types[index];=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return NULL;=0A=
+}=0A=
+=0A=
+static void riscv_rpmi_do_system_reset(RiscvRpmiState *s,=0A=
+                                       rpmi_uint32_t reset_type)=0A=
+{=0A=
+    const RiscvRpmiSysresetType *type;=0A=
+=0A=
+    type =3D riscv_rpmi_sysreset_type_by_id(reset_type);=0A=
+    if (type) {=0A=
+        type->action(s);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: unsupported reset type %u\n",=0A=
+                  __func__, reset_type);=0A=
+}=0A=
+=0A=
+static enum rpmi_error riscv_rpmi_sysreset_get_attributes(=0A=
+    struct rpmi_service_group *group, struct rpmi_service *service,=0A=
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,=0A=
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,=0A=
+    rpmi_uint8_t *response_data)=0A=
+{=0A=
+    uint32_t reset_type =3D ldl_le_p(request_data);=0A=
+    uint32_t *resp =3D (uint32_t *)response_data;=0A=
+=0A=
+    *response_data_len =3D 2 * sizeof(*resp);=0A=
+    stl_le_p(&resp[0], RPMI_SUCCESS);=0A=
+    stl_le_p(&resp[1], riscv_rpmi_sysreset_type_by_id(reset_type) ?=0A=
+             RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE : 0);=0A=
+=0A=
+    return RPMI_SUCCESS;=0A=
+}=0A=
+=0A=
+static enum rpmi_error riscv_rpmi_sysreset_do_reset(=0A=
+    struct rpmi_service_group *group, struct rpmi_service *service,=0A=
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,=0A=
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,=0A=
+    rpmi_uint8_t *response_data)=0A=
+{=0A=
+    RiscvRpmiSysresetGroup *sysreset =3D group->priv;=0A=
+    uint32_t reset_type =3D ldl_le_p(request_data);=0A=
+    uint32_t *resp =3D (uint32_t *)response_data;=0A=
+=0A=
+    *response_data_len =3D sizeof(*resp);=0A=
+=0A=
+    if (!riscv_rpmi_sysreset_type_by_id(reset_type)) {=0A=
+        stl_le_p(resp, (uint32_t)RPMI_ERR_INVALID_PARAM);=0A=
+        return RPMI_SUCCESS;=0A=
+    }=0A=
+=0A=
+    stl_le_p(resp, RPMI_SUCCESS);=0A=
+    riscv_rpmi_do_system_reset(sysreset->rpmi, reset_type);=0A=
+    return RPMI_SUCCESS;=0A=
+}=0A=
+=0A=
+static const struct rpmi_service riscv_rpmi_sysreset_services[] =3D {=0A=
+    [RPMI_SYSRST_SRV_ENABLE_NOTIFICATION] =3D {=0A=
+        .service_id =3D RPMI_SYSRST_SRV_ENABLE_NOTIFICATION,=0A=
+        .min_a2p_request_datalen =3D 8,=0A=
+    },=0A=
+    [RPMI_SYSRST_SRV_GET_ATTRIBUTES] =3D {=0A=
+        .service_id =3D RPMI_SYSRST_SRV_GET_ATTRIBUTES,=0A=
+        .min_a2p_request_datalen =3D 4,=0A=
+        .process_a2p_request =3D riscv_rpmi_sysreset_get_attributes,=0A=
+    },=0A=
+    [RPMI_SYSRST_SRV_SYSTEM_RESET] =3D {=0A=
+        .service_id =3D RPMI_SYSRST_SRV_SYSTEM_RESET,=0A=
+        .min_a2p_request_datalen =3D 4,=0A=
+        .process_a2p_request =3D riscv_rpmi_sysreset_do_reset,=0A=
+    },=0A=
+};=0A=
+=0A=
+static struct rpmi_service_group *riscv_rpmi_sysreset_create(RiscvRpmiStat=
e *s)=0A=
+{=0A=
+    RiscvRpmiSysresetGroup *sysreset;=0A=
+    struct rpmi_service_group *group;=0A=
+=0A=
+    sysreset =3D g_new0(RiscvRpmiSysresetGroup, 1);=0A=
+    sysreset->rpmi =3D s;=0A=
+    memcpy(sysreset->services, riscv_rpmi_sysreset_services,=0A=
+           sizeof(riscv_rpmi_sysreset_services));=0A=
+=0A=
+    group =3D &sysreset->group;=0A=
+    group->name =3D "sysreset";=0A=
+    group->servicegroup_id =3D RPMI_SRVGRP_SYSTEM_RESET;=0A=
+    group->max_service_id =3D RPMI_SYSRST_SRV_ID_MAX;=0A=
+    group->servicegroup_version =3D=0A=
+        RPMI_BASE_VERSION(RPMI_SPEC_VERSION_MAJOR, RPMI_SPEC_VERSION_MINOR=
);=0A=
+    group->privilege_level_bitmap =3D RPMI_PRIVILEGE_M_MODE_MASK;=0A=
+    group->services =3D sysreset->services;=0A=
+    group->lock =3D rpmi_env_alloc_lock();=0A=
+    group->priv =3D sysreset;=0A=
+=0A=
+    return group;=0A=
+}=0A=
+=0A=
+static void riscv_rpmi_sysreset_destroy(struct rpmi_service_group *group)=
=0A=
+{=0A=
+    if (!group) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    rpmi_env_free_lock(group->lock);=0A=
+    g_free(group->priv);=0A=
+}=0A=
+=0A=
+bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp)=0A=
+{=0A=
+    struct rpmi_service_group *group;=0A=
+=0A=
+    if (s->sysreset_group) {=0A=
+        error_setg(errp, "duplicate RPMI sysreset service descriptor");=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    group =3D riscv_rpmi_sysreset_create(s);=0A=
+    if (!group) {=0A=
+        error_setg(errp, "failed to create RPMI sysreset service group");=
=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (!riscv_rpmi_context_add_group(s, group, "sysreset", errp)) {=0A=
+        riscv_rpmi_sysreset_destroy(group);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    s->sysreset_group =3D group;=0A=
+    return true;=0A=
+}=0A=
+=0A=
+void riscv_rpmi_sysreset_remove(RiscvRpmiState *s)=0A=
+{=0A=
+    if (!s->sysreset_group) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    riscv_rpmi_context_remove_group(s, s->sysreset_group);=0A=
+    riscv_rpmi_sysreset_destroy(s->sysreset_group);=0A=
+    s->sysreset_group =3D NULL;=0A=
+}=0A=
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c=0A=
index e52ccfae1f..26b1a61fec 100644=0A=
--- a/hw/riscv/virt.c=0A=
+++ b/hw/riscv/virt.c=0A=
@@ -794,7 +794,8 @@ static void create_fdt_pcie(RISCVVirtState *s,=0A=
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);=0A=
 }=0A=
=0A=
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)=0A=
+static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle,=0A=
+                             bool use_syscon_reset)=0A=
 {=0A=
     char *name;=0A=
     uint32_t test_phandle;=0A=
@@ -818,6 +819,14 @@ static void create_fdt_reset(RISCVVirtState *s, uint32=
_t *phandle)=0A=
     test_phandle =3D qemu_fdt_get_phandle(ms->fdt, name);=0A=
     g_free(name);=0A=
=0A=
+    /*=0A=
+     * When RPMI is enabled, advertise reset and shutdown through RPMI so=
=0A=
+     * firmware routes these operations through the RPMI system reset serv=
ice.=0A=
+     */=0A=
+    if (!use_syscon_reset) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
     name =3D g_strdup_printf("/reboot");=0A=
     qemu_fdt_add_subnode(ms->fdt, name);=0A=
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");=
=0A=
@@ -1007,6 +1016,34 @@ static void create_fdt_iommu(RISCVVirtState *s, uint=
16_t bdf)=0A=
 }=0A=
=0A=
=0A=
+static const RiscvRpmiServiceConfig virt_rpmi_services[] =3D {=0A=
+    {=0A=
+        .node_name =3D "sysreset",=0A=
+        .compatible =3D "riscv,rpmi-system-reset",=0A=
+        .service_group =3D RISCV_RPMI_SRVGRP_SYSTEM_RESET,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint32_t virt_rpmi_service_count(RISCVVirtState *s)=0A=
+{=0A=
+    return ARRAY_SIZE(virt_rpmi_services);=0A=
+}=0A=
+=0A=
+static void virt_rpmi_system_reset(void)=0A=
+{=0A=
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);=0A=
+}=0A=
+=0A=
+static void virt_rpmi_system_shutdown(void)=0A=
+{=0A=
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);=0A=
+}=0A=
+=0A=
+static const RiscvRpmiMachineOps virt_rpmi_machine_ops =3D {=0A=
+    .system_reset =3D virt_rpmi_system_reset,=0A=
+    .system_shutdown =3D virt_rpmi_system_shutdown,=0A=
+};=0A=
+=0A=
 static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,=0A=
                                         const uint32_t *hart_ids,=0A=
                                         uint32_t hart_count)=0A=
@@ -1018,8 +1055,11 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtSta=
te *s,=0A=
         .a2p_req_size =3D VIRT_RPMI_A2P_REQ_SIZE,=0A=
         .p2a_req_size =3D VIRT_RPMI_P2A_REQ_SIZE,=0A=
         .platform_info =3D "QEMU RISC-V virt RPMI",=0A=
+        .machine_ops =3D &virt_rpmi_machine_ops,=0A=
         .hart_ids =3D hart_ids,=0A=
         .hart_count =3D hart_count,=0A=
+        .services =3D virt_rpmi_services,=0A=
+        .service_count =3D virt_rpmi_service_count(s),=0A=
     };=0A=
 }=0A=
=0A=
@@ -1028,6 +1068,7 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32=
_t *phandle,=0A=
 {=0A=
     RiscvRpmiConfig rpmi_cfg =3D virt_rpmi_config(s, NULL, 0);=0A=
     uint32_t rpmi_mbox_handle;=0A=
+    uint32_t i;=0A=
     RiscvRpmiFdtMboxConfig cfg =3D {=0A=
         .shmem_base =3D rpmi_cfg.shmem_base,=0A=
         .doorbell_base =3D rpmi_cfg.doorbell_base,=0A=
@@ -1038,6 +1079,12 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint3=
2_t *phandle,=0A=
=0A=
     riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,=0A=
                             &rpmi_mbox_handle);=0A=
+=0A=
+    for (i =3D 0; i < rpmi_cfg.service_count; i++) {=0A=
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt, rpmi_cfg.shmem_ba=
se,=0A=
+                                        &rpmi_cfg.services[i],=0A=
+                                        rpmi_mbox_handle);=0A=
+    }=0A=
 }=0A=
=0A=
 static void finalize_fdt(RISCVVirtState *s)=0A=
@@ -1063,7 +1110,7 @@ static void finalize_fdt(RISCVVirtState *s)=0A=
         create_fdt_rpmi(s, &phandle, msi_pcie_phandle);=0A=
     }=0A=
=0A=
-    create_fdt_reset(s, &phandle);=0A=
+    create_fdt_reset(s, &phandle, !s->have_rpmi);=0A=
=0A=
     create_fdt_uart(s, irq_mmio_phandle);=0A=
=0A=
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h=0A=
index f5fd1ee8c7..a9ccc950e9 100644=0A=
--- a/include/hw/misc/riscv_rpmi.h=0A=
+++ b/include/hw/misc/riscv_rpmi.h=0A=
@@ -27,6 +27,7 @@=0A=
 #define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)=0A=
 #define VIRT_RPMI_P2A_REQ_SIZE 0=0A=
=0A=
+#define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3=0A=
=0A=
Can we replace the use of these macros with the enum rpmi_servicegroup_id f=
or service_group field in struct RiscvRpmiServiceOps so that there is no ne=
ed to keep adding such #define's for various service groups.=0A=
=0A=
 #define TYPE_RISCV_RPMI "riscv-rpmi"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)=0A=
@@ -36,12 +37,11 @@ struct rpmi_service_group;=0A=
 struct rpmi_shmem;=0A=
 struct rpmi_transport;=0A=
=0A=
-typedef enum RiscvRpmiServiceKind {=0A=
-    RISCV_RPMI_SERVICE_INVALID =3D 0,=0A=
-} RiscvRpmiServiceKind;=0A=
-=0A=
+typedef struct RiscvRpmiMachineOps {=0A=
+    void (*system_reset)(void);=0A=
+    void (*system_shutdown)(void);=0A=
+} RiscvRpmiMachineOps;=0A=
 typedef struct RiscvRpmiServiceConfig {=0A=
-    RiscvRpmiServiceKind kind;=0A=
     const char *node_name;=0A=
     const char *compatible;=0A=
     uint32_t service_group;=0A=
@@ -56,7 +56,7 @@ typedef struct RiscvRpmiConfig {=0A=
     uint32_t a2p_req_size;=0A=
     uint32_t p2a_req_size;=0A=
     const char *platform_info;=0A=
-=0A=
+    const RiscvRpmiMachineOps *machine_ops;=0A=
     const uint32_t *hart_ids;=0A=
     uint32_t hart_count;=0A=
     const RiscvRpmiServiceConfig *services;=0A=
@@ -73,7 +73,8 @@ struct RiscvRpmiState {=0A=
     uint32_t a2p_req_size;=0A=
     uint32_t p2a_req_size;=0A=
     char *platform_info;=0A=
-=0A=
+    const RiscvRpmiMachineOps *machine_ops;=0A=
+    struct rpmi_service_group *sysreset_group;=0A=
     uint32_t *hart_ids;=0A=
     uint32_t hart_count;=0A=
     const RiscvRpmiServiceConfig *services;=0A=
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h=0A=
index b157bda1d1..60c5df75d0 100644=0A=
--- a/include/hw/riscv/rpmi-fdt.h=0A=
+++ b/include/hw/riscv/rpmi-fdt.h=0A=
@@ -26,5 +26,16 @@ void riscv_rpmi_fdt_add_mbox(void *fdt,=0A=
                              const RiscvRpmiFdtMboxConfig *cfg,=0A=
                              uint32_t *phandle,=0A=
                              uint32_t *mbox_handle);=0A=
+void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,=0A=
+                                const char *node_name,=0A=
+                                const char *compatible,=0A=
+                                uint32_t mbox_handle,=0A=
+                                uint32_t service_group,=0A=
+                                bool has_mpxy_channel,=0A=
+                                uint32_t mpxy_channel);=0A=
+=0A=
+void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,=0A=
+                                     const RiscvRpmiServiceConfig *service=
,=0A=
+                                     uint32_t mbox_handle);=0A=
=0A=
 #endif=0A=
--=0A=
2.43.0=0A=
=0A=
=0A=

