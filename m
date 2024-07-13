Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB28FC3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 10:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSa0F-0005lF-QX; Sat, 13 Jul 2024 06:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sSa0D-0005kf-Fp
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 06:29:17 -0400
Received: from mail-sgaapc01olkn2030.outbound.protection.outlook.com
 ([40.92.53.30] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sSa0A-0003SQ-Hf
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 06:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueC1lIBOerXWRBuM1Jbk1UeEy/5R3B2VHb0df7KyhbKYagXb0IgS/sKVu/cDMPDu3wE8L35x7AGKlw4NWK3qr1uExe/SIy5A3PUEa+TTic7Z1R4bewPqPXDTl0yxXcUf+FGCj1SjA4qfmGHpG4fE4QGUhKKF+2J1iC0HsHbmMYypjdbYTSYzaLFqNxdDQc01mbh+6tMVM2s1j5cGbThAwW075uTYHBD5VNbRPzh3A8uwvH0SD7wUWNRm4nhKhbhgXvxB6O9IXeblEUBxq+eFcH/4sOO8vONtvJcRXJsPAmdCml23RlwBdXuP+zBvpF79xlGwBAZxMdoD+3blI4Fhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7S+2mo7mL/AypsgBkpnufmfny9BwF7vhB3bdGfTAIE=;
 b=X+FGJP21eBrjg5APdWNPif0Yoc+bvc8xDJJ0DgCzd7tzmwy/omFh7F67e1orXxUTdv+n3PZzaX+Y4/XjO9Ih1WhrNmIhiyfT6sLJjCWrrG5DQCzo7JkYAALvtKZoOoVZ8ZX2dfcV0swktX9cpny18ZVNaMjHY4+4lJa/EgyEULJkM5mxK1NUfGg4PXnDdkrvJ6wkpicfvBLdv621DYAuI8NusvAZY7TCMNhHrrMaWukdh3cdjCKgry7KP3YtJjdPRJ55qNGaHIQywKxj5LOOJgpoNssj0NxpZNTGS9muxltRd7ORxFTvrdBbAuD/yecHihr5/mfVFqWjGnk2LFJhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7S+2mo7mL/AypsgBkpnufmfny9BwF7vhB3bdGfTAIE=;
 b=GtuWAUTAJvi8ffz60Bbl42cPqe5pXPkjBBac4a8sE27HFNknvLcOdl+ninLIl30pBPN+QmikL6cT2/iYLcAeMgo1o7bdu/RLfBmsLTR+A6T89+8rXHnewvvCcO/XcpSkpIacxImLYCX3TInUJCljCAkXgyNsa0A3EYqDhbznK3qFejrkyFIcaVRoqxF8Sxvx6Ugckco7ZLUNEZyiprBK1AKHLwKCTzA3zS9TYzAqMG3bw5h4aIwOTkDgVHTwk2EqtPxoYzglOhixsZIPT+AyNHWfDfI8sm7tWBmjdrF9WBFe5VulPCCcFos+p89TXK6Xe6ej7HdvSvNQwDj6TgRXWA==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by SEZPR01MB4574.apcprd01.prod.exchangelabs.com
 (2603:1096:101:79::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Sat, 13 Jul
 2024 10:24:02 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%6]) with mapi id 15.20.7741.042; Sat, 13 Jul 2024
 10:24:02 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Topic: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Index: AQHawYD83w/3eGv8102bpXalgrtacLHv3VeAgAS8m2s=
Date: Sat, 13 Jul 2024 10:24:02 +0000
Message-ID: <TY0PR0101MB4285B93E13A52EB6956C91A1A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <85f63a2b-00ed-40c0-b5b2-6544c67a3a28@redhat.com>
In-Reply-To: <85f63a2b-00ed-40c0-b5b2-6544c67a3a28@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [q1wb8bHCDiwqcSZPYm0lS6+4MgCYNFRG]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4285:EE_|SEZPR01MB4574:EE_
x-ms-office365-filtering-correlation-id: 339582f7-8fbc-4a5e-bc56-08dca325ea8e
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025|102099032; 
x-microsoft-antispam-message-info: D3IEOAw5TvgKGiyy5G3HCa2f12JMOd+opx7Qg/EvbPtolLJnTsack25qpa7g9tRpOITHgK5IQfJB5vXF7swOzWSBDX9RJucmYtDnzkJVMjWerpOvqVrLg+I90XLJ9ulhi6sTWCNX7xyynbMiIi9hP3RpH3F2wx44zo83lJ8zM31wti4CBNWjl1v+lrQk2wjSO01C8GyPOa0uEjhlbYeagAHYfluS9mqfKIdU3bcdY7uE+9iKO+6DPnJfgcNe4Qe738hGw7nhexUwUub7lkloBKhw9pCeP2hRsOmFkftuzfnWw4pNvIywPLdyFrWX4IdUVY0JtZx+ENdf/zgblAxVpY6aaiBXkkWR0lnFek7EFSS76ru2ridsk3Rvg5DG/c7cr4rCII8CmVT2dgzy0Jm8/TeHRNMiFR2qJ5kLfxMW05+K8flKSxri3YFifuyHJ3aaxyDBLjlqZz+pC58ylhOzZeOHxgwDmtm6fF/FDOC+EpUVgaMVBE70kT16HCIMFTgTCB4I8+W63fEoTZpJjoi5UQXXogWumAoEWmyOc98LEaSih8viV4s7Pu30UtfWbsvtqTmJNrmZZe+GNTrQ7svN+3cuj3Z2SYQg2FGJPp2QhSj1WxtUBhKDtYzWCf/E08lAvzpv2o8+KwHC30+DdVBpgw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VE0xaFN4QnpXbURJR05XbUNwMXQ2VFo0TWRYNjFxTkhoWVM4UkNrMWpo?=
 =?iso-2022-jp?B?cVBKWExlcWE0U2NYaFdHT1drQW1RNEFuZm5xSGVxTEVVSjhKWkEzSlRH?=
 =?iso-2022-jp?B?Q25JaUtVOXdydmorM0wzbjFnZkN3V3Y3MElVdUJpOXlsYzM4dHQwOGpK?=
 =?iso-2022-jp?B?Mmp5RUovVUZ3ejcxTFp2V29nR0RuR3k1eUhlbHR4WWNlbjJlRkN6NFFP?=
 =?iso-2022-jp?B?bVJoWk5tcm90T0xaL3lOSUNublliNVJVS1pIUXdhZmtMd3FOVjR3L25u?=
 =?iso-2022-jp?B?UWxJSzZVS3lURDFaRDlkUXhvc2F2a2cwRHZ1N2x3YytlOUNicWQrNzlM?=
 =?iso-2022-jp?B?a3hoSEx6aE91cVhVcmpJTVFVN1pNL2VyMHlqYVB3THJmS1dWVlNHZXdB?=
 =?iso-2022-jp?B?K3lKdjJYSFcxc2tXUSt0L29DaTVnSkt6ZlB0ZEp2czlLM2xWOVhNOEEw?=
 =?iso-2022-jp?B?dlRsRHlIc2Q5ZEJCQnVmUXg2QkEvRE1zTmtZbVlBOUxJTDljb1ZCa0o4?=
 =?iso-2022-jp?B?RnAydzFaMk92RTNGVHBzNkxkcWVlb3VWbGJINEt4eWV4WkcvbHNsS2dN?=
 =?iso-2022-jp?B?OTdxRHczZTBjUjVaRTlVT2dwd3JOSUtSRlIzZXM0bmNXTVJGQzQwM0dr?=
 =?iso-2022-jp?B?a01ETlNwQ3JLZG8rd2xkU0RTdks1MjB2M0lvanlHUndlcXhyVDFJNkgz?=
 =?iso-2022-jp?B?cVJvZVE0TW5jczh2Z1UybVRjWlRETUdnclpzR0RvekFGUG1jUWh1ZFc5?=
 =?iso-2022-jp?B?MkFjV1RDaHlvY3FOaEpXcXVMcmsrSHdPSUoyKzFpWWNmYm50YmRVd0lh?=
 =?iso-2022-jp?B?eFhPa0g5TWphM0lucVFkRSsvYWdGWGRPZDNsU2pRdWlrbEVQQ0R1Ylg1?=
 =?iso-2022-jp?B?Z1hneGVyb3JTRHRKL1M3MUUxUjNQVnFCalBsYnJDTHNXZzVzT1IxWTlC?=
 =?iso-2022-jp?B?Zk1GaWFMdGpEZ1k2WVhuZU1IcnZ6MmZRU0NsRkNYTnI1eEtPaVE0RVdZ?=
 =?iso-2022-jp?B?NjRXamloV2FlQmtZV1N3NmtwM2t4MUVUblZac25sdXd5KzYwQlUvNmJL?=
 =?iso-2022-jp?B?OU90a3oxSkY5WmIzL1J2M3V5KzAxS3VDQVNxcjRkb2tyYWxnTXgxUmtC?=
 =?iso-2022-jp?B?NitxQy8zVXJLYVlkWk1Jdlo4ZXQxM3FGa1E2ajlSeWdSYktZWHZ4YldJ?=
 =?iso-2022-jp?B?L2FzeURwVHlNYlp2L1BycXFrSHJMV2hMMTlPOURFam1hODI2bzFQcCtW?=
 =?iso-2022-jp?B?bGpQZlQ2aU9tUENpN3RXdmxkQlFoUFRmclNWOHJyZVpxNDhYejlhdmdF?=
 =?iso-2022-jp?B?OFh6eTFHbC91TzZONkdTek56d1B3T0Q0eGVzYmFORm9YVm90ck85WDdT?=
 =?iso-2022-jp?B?czhZYWtFL3cwOC9jaUIrdW1PbGtYV3c3WWRNdzJESytuWHlyVWsvS0Zk?=
 =?iso-2022-jp?B?U0QyK1RhMHA5dGN3ZE81YytkcUh0TU5KU2FqeDQxNVBYWDdHSE1HbXQ0?=
 =?iso-2022-jp?B?aDBRbTZ2MUIyNU9JYzZoakxBQ3ZxYmhLUzgwWHZ5cEthdzQ2SXRORFZS?=
 =?iso-2022-jp?B?QzE1aklTRmVoTTlmVld4bnlETUdSMFFpdXc5cVE1Z1lFWHZvM1V0ZE5C?=
 =?iso-2022-jp?B?bXdmUzcrbXJYQ3RtNEcvRUM2S3M0cHVtSnpUcytyeXU0TFFIWUdYQzRT?=
 =?iso-2022-jp?B?WjYxTUR6SnptNkxSbUZJb3ZKN0RwdG40aFhsNnlDWDA2ZGJvdVBCSmZW?=
 =?iso-2022-jp?B?YndnaDVTNGhqTzBoRnJ5VVBPK3FqZ0drYkpidEJHS1FuWHRDVzQ5RFk9?=
Content-Type: multipart/alternative;
 boundary="_000_TY0PR0101MB4285B93E13A52EB6956C91A1A4A72TY0PR0101MB4285_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 339582f7-8fbc-4a5e-bc56-08dca325ea8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2024 10:24:02.3970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4574
Received-SPF: pass client-ip=40.92.53.30; envelope-from=taisei1212@outlook.jp;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

--_000_TY0PR0101MB4285B93E13A52EB6956C91A1A4A72TY0PR0101MB4285_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thank you for reviewing.
The patch fixed by you can't solve my problem.
However, it is able to do this with minor modification.
I will send a new version patch.
________________________________
=1B$B:9=3DP?M=1B(B: Paolo Bonzini <pbonzini@redhat.com>
=1B$BAw?.F|;~=1B(B: 2024=1B$BG/=1B(B7=1B$B7n=1B(B10=1B$BF|=1B(B 19:01
=1B$B08@h=1B(B: TaiseiIto <taisei1212@outlook.jp>; qemu-devel@nongnu.org <q=
emu-devel@nongnu.org>
CC: mst@redhat.com <mst@redhat.com>
=1B$B7oL>=1B(B: Re: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts

Hello!  Thanks for looking after the HPET, which is not a very well
maintained device.

I am not sure your patch needs to mask the comparator with

        timer->cmp &=3D 0xffffffffULL;

I think that's a bug in the "case HPET_TN_CMP + 4" part of
hpet_ram_write.  The logic was changed in "hpet: Fix emulation of
HPET_TN_SETVAL" but the commit forgot to apply it to the high bits of
the comparator.

The whole handling of writes to the comparator is very messy.  I can
see two more bugs:
* Idon't think it's correct that HPET_TN_CMP+4 does not clear
HPET_TN_SETVAL
* the clamping should take into account that new_val is shifted by 32

Can you check that this also fixes the problem:

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885db..11df272fe87 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  timer->period =3D
                      (timer->period & 0xffffffff00000000ULL) | new_val;
              }
+            /*
+             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to th=
e
+             * high bits part as well.
+             */
              timer->config &=3D ~HPET_TN_SETVAL;
              if (hpet_enabled(s)) {
                  hpet_set_timer(timer);
@@ -562,7 +566,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
              if (!timer_is_periodic(timer)
                  || (timer->config & HPET_TN_SETVAL)) {
                  timer->cmp =3D (timer->cmp & 0xffffffffULL) | new_val << =
32;
-            } else {
+            }
+            if (timer_is_periodic(timer)) {
                  /*
                   * FIXME: Clamp period to reasonable min value?
                   * Clamp period to reasonable max value
@@ -562,20 +566,21 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
              if (!timer_is_periodic(timer)
                  || (timer->config & HPET_TN_SETVAL)) {
                  timer->cmp =3D (timer->cmp & 0xffffffffULL) | new_val << =
32;
-            } else {
+            }
+            if (timer_is_periodic(timer)) {
                  /*
                   * FIXME: Clamp period to reasonable min value?
                   * Clamp period to reasonable max value
                   */
-                new_val &=3D (timer->config & HPET_TN_32BIT ? ~0u : ~0ull)=
 >> 1;
+                new_val =3D MIN(new_val, ~0u >> 1);
                  timer->period =3D
                      (timer->period & 0xffffffffULL) | new_val << 32;
-                }
-                timer->config &=3D ~HPET_TN_SETVAL;
-                if (hpet_enabled(s)) {
-                    hpet_set_timer(timer);
-                }
-                break;
+            }
+            timer->config &=3D ~HPET_TN_SETVAL;
+            if (hpet_enabled(s)) {
+                hpet_set_timer(timer);
+            }
+            break;
          case HPET_TN_ROUTE:
              timer->fsb =3D (timer->fsb & 0xffffffff00000000ULL) | new_val=
;
              break;
@@ -605,7 +605,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  s->hpet_offset =3D
                      ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU=
_CLOCK_VIRTUAL);
                  for (i =3D 0; i < s->num_timers; i++) {
-                    if ((&s->timer[i])->cmp !=3D ~0ULL) {
+                    if (timer_enabled(timer)) {
                          hpet_set_timer(&s->timer[i]);
                      }
                  }

(the final part is taken from your patch)?

Thanks,

Paolo

On 6/18/24 15:10, TaiseiIto wrote:
> Before this commit, there are 3 problems about HPET timer interrupts. Fir=
st,
> HPET periodic timers cause a too early interrupt before HPET main counter
> value reaches a value written its comparator value register. Second,
> disabled HPET timers whose comparator value register is not
> 0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers who=
se
> comparator value register is 0xffffffffffffffff don't cause any interrupt=
s.

> About the first one, for example, an HPET driver writes 0x00000000aaaaaaa=
a
> to an HPET periodic timer comparator value register. As a result, the
> register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits
> of the register doesn't affect itself in periodic mode. (see
> "case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
> which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, t=
he
> HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
> comparator value register (0xffffffffaaaaaaaa) indicate the next interrup=
t
> time. The period (0xaaaaaaaa) is added to the comparator value register a=
t
> "hpet_timer" function because "hpet_time_after64" function returns true w=
hen
> the main counter is small. So, the first interrupt is planned when the ma=
in
> counter is 0x0000000055555554, but the first interrupt should occur when =
the
> main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the code=
 to
> clear the higher 32 bits of comparator value registers of periodic mode
> timers when HPET starts the main counter. About the other two problems, i=
t
> was decided by comparator value whether each timer is enabled, but it sho=
uld
> be decided by "timer_enabled" function which confirm "HPET_TN_ENABLE" fla=
g.
> To solve these problems, I fix the code to decide correctly whether each
> timer is enabled. After this commit, the 3 problems are solved. First, HP=
ET
> periodic timers cause the first interrupt when the main counter value
> reaches a value written its comparator value register. Second, disabled H=
PET
> timers never cause any interrupt. Third, enabled HPET timers cause
> interrupts correctly even if an HPET driver writes 0xffffffff to its
> comparator value register.
>
> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
> ---
>   hw/timer/hpet.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 01efe4885d..2dcefa7049 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr=
,
>                   s->hpet_offset =3D
>                       ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QE=
MU_CLOCK_VIRTUAL);
>                   for (i =3D 0; i < s->num_timers; i++) {
> -                    if ((&s->timer[i])->cmp !=3D ~0ULL) {
> -                        hpet_set_timer(&s->timer[i]);
> +                    HPETTimer *timer =3D &s->timer[i];
> +                    if (timer_enabled(timer)) {
> +                        if (timer_is_periodic(timer)) {
> +                            timer->cmp &=3D 0xffffffffULL;
> +                        }
> +                        hpet_set_timer(timer);
>                       }
>                   }
>               } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENAB=
LE)) {


--_000_TY0PR0101MB4285B93E13A52EB6956C91A1A4A72TY0PR0101MB4285_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thank you for reviewing.</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The patch fixed by you can't solve my problem.</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
However, it is able to do this with minor modification.</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I will send a new version patch.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=1B$B:9=3DP?M=1B(B:</b> Paolo B=
onzini &lt;pbonzini@redhat.com&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b> 2024=1B$BG/=1B(B7=1B$B7n=1B(B10=1B$BF|=1B(B 19:0=
1<br>
<b>=1B$B08@h=1B(B:</b> TaiseiIto &lt;taisei1212@outlook.jp&gt;; qemu-devel@=
nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>CC:</b> mst@redhat.com &lt;mst@redhat.com&gt;<br>
<b>=1B$B7oL>=1B(B:</b> Re: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello!&nbsp; Thanks for looking after the HPET, wh=
ich is not a very well<br>
maintained device.<br>
<br>
I am not sure your patch needs to mask the comparator with<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;cmp &amp;=3D 0xfffffff=
fULL;<br>
<br>
I think that's a bug in the &quot;case HPET_TN_CMP + 4&quot; part of<br>
hpet_ram_write.&nbsp; The logic was changed in &quot;hpet: Fix emulation of=
<br>
HPET_TN_SETVAL&quot; but the commit forgot to apply it to the high bits of<=
br>
the comparator.<br>
<br>
The whole handling of writes to the comparator is very messy.&nbsp; I can<b=
r>
see two more bugs:<br>
* Idon't think it's correct that HPET_TN_CMP+4 does not clear<br>
HPET_TN_SETVAL<br>
* the clamping should take into account that new_val is shifted by 32<br>
<br>
Can you check that this also fixes the problem:<br>
<br>
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c<br>
index 01efe4885db..11df272fe87 100644<br>
--- a/hw/timer/hpet.c<br>
+++ b/hw/timer/hpet.c<br>
@@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;period =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (timer-&gt;period &amp;=
 0xffffffff00000000ULL) | new_val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 high bits part as well.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; timer-&gt;config &amp;=3D ~HPET_TN_SETVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (hpet_enabled(s)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_set_timer(timer);<br>
@@ -562,7 +566,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!timer_is_periodic(timer)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; || (timer-&gt;config &amp; HPET_TN_SETVAL)) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;cmp =3D (timer-&gt;cmp &amp; 0xffffff=
ffULL) | new_val &lt;&lt; 32;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tim=
er_is_periodic(timer)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FIXME: Clamp period to reasonable min v=
alue?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Clamp period to reasonable max value<br=
>
@@ -562,20 +566,21 @@ static void hpet_ram_write(void *opaque, hwaddr addr,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!timer_is_periodic(timer)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; || (timer-&gt;config &amp; HPET_TN_SETVAL)) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;cmp =3D (timer-&gt;cmp &amp; 0xffffff=
ffULL) | new_val &lt;&lt; 32;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tim=
er_is_periodic(timer)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FIXME: Clamp period to reasonable min v=
alue?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Clamp period to reasonable max value<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; new_val &amp;=3D (timer-&gt;config &amp; HPET_TN_32BIT ? ~=
0u : ~0ull) &gt;&gt; 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; new_val =3D MIN(new_val, ~0u &gt;&gt; 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;period =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (timer-&gt;period &amp;=
 0xffffffffULL) | new_val &lt;&lt; 32;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; timer-&gt;config &amp;=3D ~HPET_TN_SETVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (hpet_enabled(s)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_set_timer(timer);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&=
gt;config &amp;=3D ~HPET_TN_SETVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hpe=
t_enabled(s)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hpet_set_timer(timer);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case HPET_TN_ROUTE:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; timer-&gt;fsb =3D (timer-&gt;fsb &amp; 0xffffffff00000000ULL) | new_val=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
@@ -605,7 +605,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;hpet_offset =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ticks_to_ns(s-&gt;hpet_=
counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; s-&gt;num_timers; i++) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((&amp;s-&gt;timer[i])-&gt;cmp =
!=3D ~0ULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timer_enabled(timer)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 hpet_set_timer(&amp;s-&gt;timer[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
(the final part is taken from your patch)?<br>
<br>
Thanks,<br>
<br>
Paolo<br>
<br>
On 6/18/24 15:10, TaiseiIto wrote:<br>
&gt; Before this commit, there are 3 problems about HPET timer interrupts. =
First,<br>
&gt; HPET periodic timers cause a too early interrupt before HPET main coun=
ter<br>
&gt; value reaches a value written its comparator value register. Second,<b=
r>
&gt; disabled HPET timers whose comparator value register is not<br>
&gt; 0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers =
whose<br>
&gt; comparator value register is 0xffffffffffffffff don't cause any interr=
upts.<br>
<br>
&gt; About the first one, for example, an HPET driver writes 0x00000000aaaa=
aaaa<br>
&gt; to an HPET periodic timer comparator value register. As a result, the<=
br>
&gt; register becomes 0xffffffffaaaaaaaa because writing to the higher 32 b=
its<br>
&gt; of the register doesn't affect itself in periodic mode. (see<br>
&gt; &quot;case HPET_TN_CMP + 4&quot; of &quot;hpet_ram_write&quot; functio=
n.) And &quot;timer-&gt;period&quot;<br>
&gt; which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next=
, the<br>
&gt; HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. T=
he<br>
&gt; comparator value register (0xffffffffaaaaaaaa) indicate the next inter=
rupt<br>
&gt; time. The period (0xaaaaaaaa) is added to the comparator value registe=
r at<br>
&gt; &quot;hpet_timer&quot; function because &quot;hpet_time_after64&quot; =
function returns true when<br>
&gt; the main counter is small. So, the first interrupt is planned when the=
 main<br>
&gt; counter is 0x0000000055555554, but the first interrupt should occur wh=
en the<br>
&gt; main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the c=
ode to<br>
&gt; clear the higher 32 bits of comparator value registers of periodic mod=
e<br>
&gt; timers when HPET starts the main counter. About the other two problems=
, it<br>
&gt; was decided by comparator value whether each timer is enabled, but it =
should<br>
&gt; be decided by &quot;timer_enabled&quot; function which confirm &quot;H=
PET_TN_ENABLE&quot; flag.<br>
&gt; To solve these problems, I fix the code to decide correctly whether ea=
ch<br>
&gt; timer is enabled. After this commit, the 3 problems are solved. First,=
 HPET<br>
&gt; periodic timers cause the first interrupt when the main counter value<=
br>
&gt; reaches a value written its comparator value register. Second, disable=
d HPET<br>
&gt; timers never cause any interrupt. Third, enabled HPET timers cause<br>
&gt; interrupts correctly even if an HPET driver writes 0xffffffff to its<b=
r>
&gt; comparator value register.<br>
&gt; <br>
&gt; Signed-off-by: TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; hw/timer/hpet.c | 8 ++++++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 6 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c<br>
&gt; index 01efe4885d..2dcefa7049 100644<br>
&gt; --- a/hw/timer/hpet.c<br>
&gt; +++ b/hw/timer/hpet.c<br>
&gt; @@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr a=
ddr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;hpet_offset =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ticks_to_ns(s=
-&gt;hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; s-&gt;num_timers=
; i++) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((&amp;s-&gt;timer[i])-&gt=
;cmp !=3D ~0ULL) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_=
set_timer(&amp;s-&gt;timer[i]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HPETTimer *timer =3D &amp;s-&=
gt;timer[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timer_enabled(timer)) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (t=
imer_is_periodic(timer)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; timer-&gt;cmp &amp;=3D 0xffffffffULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_=
set_timer(timer);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE=
)) {<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_TY0PR0101MB4285B93E13A52EB6956C91A1A4A72TY0PR0101MB4285_--

