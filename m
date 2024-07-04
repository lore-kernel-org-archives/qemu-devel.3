Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AB0C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKvZ-0000SO-PF; Thu, 04 Jul 2024 07:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sPKvB-0000OE-VK
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:46:52 -0400
Received: from mail-psaapc01olkn2043.outbound.protection.outlook.com
 ([40.92.52.43] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sPKv9-0006p3-9P
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a71SilfVqAWcI3eK18GsQdvW090Y31fg+oekrDDKZhGjR2IPjQe57BnRJzE1BOcTLdPtPk8JGZ4bxdIBTa0NA+oAexH/vPgD45nFMa8VnctJkhoBHLcsMhk495yg5h2C7/F1XMqEon8kJPbe46suSpEeljvu7q5I8hnNKXfbhtsMAZTXSlqJxAl6h/bUNFigo86tRcgXOn9FqhHlB65jzsVonW5VG7LVnZX+6ucEh8YfiXbpM/vejmSNYcKyJhOAgLLjEMwKiBFavpTx2jjXktiIJJH3E30yKubFhWyuHMXBxXNvt01k8NP+i4D8Fz+VdzBtEWpSoOwaunjEbmrHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qa6n0X+dkBwMnLj58pB0afoR0708MFJ/jgSl1iQMlg=;
 b=f2c2tGyyaFjzz9Ml4znmBzv/8Jw/GKkhMGrntTBr2aWfyNkMpTXIwN/B4x6L8P0/AlDBZUv2+87wz7VvCqxjOZoglm/oPztZ/rp7p7oaJZWuXtu7WTUm0W+aUhBjmAxzYYt/V2+pC1HbD5FsJwTsRSatxqthEdLbF7x3cI+7rOs9Z+qlAAl4IBMQOdHJ3RdMJGtO1Gxl5P5hFcXBA8CykesiUGKPEf6eyvEECfPFU1LCbujgC7SEhzE+FyfVs8yWFCXlOpU+Mcr1q6oMsPpbTao9TiMle6sQdjVqzy8tLwVobC+ZrS9UJkwBd0/M1FCfOocXN6uUFArWwyg+rrnWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qa6n0X+dkBwMnLj58pB0afoR0708MFJ/jgSl1iQMlg=;
 b=phtolmfxVFIYzyUirzubGe2cDoeFzesOSGFU+tPF+1UQDm+PEFlPfTKLo7NCylRZcZ0CqyzQD3c9eJW9c4aAbn6sWyXbPIK1zkQpL4FA2+5WEnusjqh1zUPTI5z6kXlggJOR1aTcgDdLAW/qvnk8jXTYA6wqEXj0SabL+zDTY5uuYduODmwU8P9I5D6SWPrAlmROFRrwNjr5ldxXWtIlM1KQcUV5tQJyY7PJ+onJfXmdLPkHleYIJ0FHcbc8FUCzjW0ypG06dtl48KXddCby3kM1URP2S28g5s811+o+PL//M6KQI4dC5W+utvmO/EgoA/4HFf34V/O2q6OyULTh5Q==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by TYZPR01MB4233.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 11:41:28 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%4]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 11:41:27 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: [PING][PATCH] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Topic: [PING][PATCH] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Index: AQHawYD83w/3eGv8102bpXalgrtacLHmijKV
Date: Thu, 4 Jul 2024 11:41:27 +0000
Message-ID: <TY0PR0101MB4285AC5DF808D423B1E8EC66A4DE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [Ccj+370vPsGTtopOz5OMrlw/UVhImozM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4285:EE_|TYZPR01MB4233:EE_
x-ms-office365-filtering-correlation-id: 4ce333db-a6b0-40e6-2d88-08dc9c1e3d77
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|9400799024|8060799006|102099032|3412199025|440099028; 
x-microsoft-antispam-message-info: 1P5NEL2N9gd6kFHdNi3AhHi2h7uwaO0FS9o5s6Z0LLhYv380exnRPQdmgRJDZyo1UFGyb7jtC8FrvCbl7SiETQ93YPwhVAjXfYEFvZB3L3/Y7UZe5jkMNgc8r7J5c5wtNbZ0lR989Wyl24gQ79pPpcbHaBn0230Te/5AcaZ3jrgoSNscc7aWzICYbVhCnd0PIN7DQm+C0l2roGaE0uO+xzMw5oufHBAnNagSkMSgMV/2ECewGg+VIGYXVpgY/Xc/pjYfnhoI3p5wnmW5Lnd1f2gbR4VxyCGoSv/JliawLc0VVj+6J5tQL8wFeq8y9E5FDgNLqQP534hmxMZqTOoeWoP/KBNMiMRcDT2FM5W02qGhsOfAqkIbgdrrMBdXX4eTizQ7uHRG1CA3aBsp8fMk92G/DvQpSKNkjnsL7p7UZ0cYqSTJlXkt98H/kmP/hRZ9WZFI4wRQ7s62bKJJz27zyNXn2PhxncIz8Jdx6QrjeG9zQW4SK+dt3pGyhglIIhUWvhQHqLHMC/zsgSraIQvGPXS5/Q6lQPhCqLizrQSarbScERf2Q/9X5qGmJiAj+PtJykQayIPF3w7GtZzfvxnVgcQFpw7x6SZ6vRLqVJKN0X7TenXZnS7CdE/iIeOtenE/4xsvmiMnLrYiWFDtj2QWVTbY+77261G8fgj8ZspywM2MsqK0hYd6Z4CcbDXu2Xuq
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RSs4NmdId0RJT1RmSHVzbERSQjdJTi92aWlWQlpCK3lmMytmU1Yydktp?=
 =?iso-2022-jp?B?d2IxcDBxd25sRVl0RDhSdU1ESU83KzNZZDRtaXVQTDRxQ1BSakc4emdy?=
 =?iso-2022-jp?B?UjVGWTlvTmw4Mm1uMjZQSjZCTjk3NkxGazJMTThpK2VOMUF4KzdLZklW?=
 =?iso-2022-jp?B?cXd1OUdmbTVScENVQkdrT3lzNFY5SVk1dVJkOGdVZTIyTzlxZm9adHcz?=
 =?iso-2022-jp?B?amplUkVqMmgzTnluTnZ1ais4cVZ4bDJaYXBDcnNMb2F0Y01UeXJTUzZ3?=
 =?iso-2022-jp?B?c1BOanZZL09ETGNSY1lMeXJ5ekFaUVErVlpFbThSelBqd3NCRjdFVFlV?=
 =?iso-2022-jp?B?Uy9ZdXZJb1k5WEJnMVZucGltUzd6dzQwbGNSem02bXdLQy84bFlOc01t?=
 =?iso-2022-jp?B?S08yNEtGNzM3OU8wNFdzWTBJNXROb2hQNHA3dGYvM1ZIa2lyMFVUL0xH?=
 =?iso-2022-jp?B?YXc5dStsR2R0aG9nczVsMWc3Q2VhM0dlOURvRVp4dEFQN09MTnhtQng5?=
 =?iso-2022-jp?B?eVU2TkxHaWJSdmh4OWYxcHcrZEdJbGF5STdtd1F2TEEyUi9wTGN2NlRx?=
 =?iso-2022-jp?B?ODJldmZNWVcrR3RiOTZ2a01YeFl3MnExcWxuQkU0bkJZSlVZYnF4Wlky?=
 =?iso-2022-jp?B?NnhmbnVmS2c1NDUzdnQreHZkU3hhenk2ajNhWDIzZHllUHI3Z3ZGWHlQ?=
 =?iso-2022-jp?B?M29tYk1CajlMRUs0Q3dHeXNqY1p3aVRieUsyak5OQjN0eEJCQzFBdkFC?=
 =?iso-2022-jp?B?U2M2S0F0cC8yT1ZYTU1MUWRCSHYzMHhWMFgySi9Da3BJdC9IREFmNUpx?=
 =?iso-2022-jp?B?enkxKzV3R0R6b3V3VWl6VlBIVzFCZHhZejhTMDcyTDF0SHZBOEdvZStv?=
 =?iso-2022-jp?B?QTFTV2g4MGl4TXRXd2ZTNWluSnlnZUJtQnFvSithSExYU0hRT2RrMGxu?=
 =?iso-2022-jp?B?WVBJbUl2TDB1bm1NbTRFQlZMTVJZOWc1OEZhRnVVSU5VdDBZeHloT0JH?=
 =?iso-2022-jp?B?dWMybTByeFJEczZLU2tScDlQR3BNcUN5eVZtNFpxQXpmODYxNHNuMjh6?=
 =?iso-2022-jp?B?cS8xbUtJdVpLbzZLTDdQUDZXT29Yb28zbWpnR0JUUndhbGpKV1pFc3ZL?=
 =?iso-2022-jp?B?RVlaNElLUG90RjIxYUh1QmlpSC9FYWRHTFRYRmR6YWE5ZzBZdy9Mc0hM?=
 =?iso-2022-jp?B?SzRpak5GWVI1cEx0SFFkS3lHTDlLWElnMU9xdXhjNk13bE8vRFYwUE4v?=
 =?iso-2022-jp?B?L3V3TWJxYTF6dEJ2OTM3dnVwS1N6VkZtMEVjKzhQa3hnaGMyVnpCTzg2?=
 =?iso-2022-jp?B?dzJ0SXdvdVZTY2VkdGVBM1N6YU1RYnhOU3QrSnhiSVVjekNFSGZDekp5?=
 =?iso-2022-jp?B?ejZvL0txcERtZnRjdi92NDFwWitRYitxSjBqUlhYUE5oRzYyNk1nd0Yx?=
 =?iso-2022-jp?B?UzUwcnRkaTNWeUZObzg0SnhXM0x2RkNhWFNIWFhoWjFCend6M1hBZHYz?=
 =?iso-2022-jp?B?R2RaVFNqRCtQWmNCR1E5TmlyU2FqUE1ZZzZhRHMrSDNacFJTRXdzYzUw?=
 =?iso-2022-jp?B?UkYrYXQraWhHSGQzeU54MGh2RE5GaU1UYU83M29USDhhMi9oMUFVUGJC?=
 =?iso-2022-jp?B?SG80YW5Tb0RXMGFsQVg1NzBhcjQ3RHBXY0lWYklkcUpXZjVLbVpGQ1VZ?=
 =?iso-2022-jp?B?aHBnTEtYUmtEYnAwSk5oWk9tL295QkxjZXE2TjZZU0RWVGNTeUdJRFJO?=
 =?iso-2022-jp?B?b1JNYVJBbnpxS0FDOVVRZWN3QWUwc2tkK1lYWHcvOWk0cTc4NTdJaFU9?=
Content-Type: multipart/alternative;
 boundary="_000_TY0PR0101MB4285AC5DF808D423B1E8EC66A4DE2TY0PR0101MB4285_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-b4c57.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce333db-a6b0-40e6-2d88-08dc9c1e3d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 11:41:27.3417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4233
Received-SPF: pass client-ip=40.92.52.43; envelope-from=taisei1212@outlook.jp;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

--_000_TY0PR0101MB4285AC5DF808D423B1E8EC66A4DE2TY0PR0101MB4285_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

This is a ping for the patch below.
https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/
________________________________
=1B$B:9=3DP?M=1B(B: TaiseiIto <taisei1212@outlook.jp>
=1B$BAw?.F|;~=1B(B: 2024=1B$BG/=1B(B6=1B$B7n=1B(B18=1B$BF|=1B(B 22:10
=1B$B08@h=1B(B: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
CC: mst@redhat.com <mst@redhat.com>; pbonzini@redhat.com <pbonzini@redhat.c=
om>; TaiseiIto <taisei1212@outlook.jp>
=1B$B7oL>=1B(B: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts

Before this commit, there are 3 problems about HPET timer interrupts. First=
,
HPET periodic timers cause a too early interrupt before HPET main counter
value reaches a value written its comparator value register. Second,
disabled HPET timers whose comparator value register is not
0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers whose
comparator value register is 0xffffffffffffffff don't cause any interrupts.
About the first one, for example, an HPET driver writes 0x00000000aaaaaaaa
to an HPET periodic timer comparator value register. As a result, the
register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits
of the register doesn't affect itself in periodic mode. (see
"case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, the
HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt
time. The period (0xaaaaaaaa) is added to the comparator value register at
"hpet_timer" function because "hpet_time_after64" function returns true whe=
n
the main counter is small. So, the first interrupt is planned when the main
counter is 0x0000000055555554, but the first interrupt should occur when th=
e
main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the code t=
o
clear the higher 32 bits of comparator value registers of periodic mode
timers when HPET starts the main counter. About the other two problems, it
was decided by comparator value whether each timer is enabled, but it shoul=
d
be decided by "timer_enabled" function which confirm "HPET_TN_ENABLE" flag.
To solve these problems, I fix the code to decide correctly whether each
timer is enabled. After this commit, the 3 problems are solved. First, HPET
periodic timers cause the first interrupt when the main counter value
reaches a value written its comparator value register. Second, disabled HPE=
T
timers never cause any interrupt. Third, enabled HPET timers cause
interrupts correctly even if an HPET driver writes 0xffffffff to its
comparator value register.

Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
---
 hw/timer/hpet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 01efe4885d..2dcefa7049 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 s->hpet_offset =3D
                     ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_=
CLOCK_VIRTUAL);
                 for (i =3D 0; i < s->num_timers; i++) {
-                    if ((&s->timer[i])->cmp !=3D ~0ULL) {
-                        hpet_set_timer(&s->timer[i]);
+                    HPETTimer *timer =3D &s->timer[i];
+                    if (timer_enabled(timer)) {
+                        if (timer_is_periodic(timer)) {
+                            timer->cmp &=3D 0xffffffffULL;
+                        }
+                        hpet_set_timer(timer);
                     }
                 }
             } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)=
) {
--
2.34.1


--_000_TY0PR0101MB4285AC5DF808D423B1E8EC66A4DE2TY0PR0101MB4285_
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
<div class=3D"elementToProof" style=3D"font-family: Meiryo, =1B$B%a%$%j%*=
=1B(B, &quot;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
This is a ping for the patch below.</div>
<div class=3D"elementToProof" style=3D"font-family: Meiryo, =1B$B%a%$%j%*=
=1B(B, &quot;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<a href=3D"https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3=
D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/" id=3D"LPlnk339=
185">https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3D1CCFD=
A4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</a></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=1B$B:9=3DP?M=1B(B:</b> TaiseiI=
to &lt;taisei1212@outlook.jp&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b> 2024=1B$BG/=1B(B6=1B$B7n=1B(B18=1B$BF|=1B(B 22:1=
0<br>
<b>=1B$B08@h=1B(B:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<=
br>
<b>CC:</b> mst@redhat.com &lt;mst@redhat.com&gt;; pbonzini@redhat.com &lt;p=
bonzini@redhat.com&gt;; TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
<b>=1B$B7oL>=1B(B:</b> [PATCH] hw/timer/hpet: Fix wrong HPET interrupts</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Before this commit, there are 3 problems about HPE=
T timer interrupts. First,<br>
HPET periodic timers cause a too early interrupt before HPET main counter<b=
r>
value reaches a value written its comparator value register. Second,<br>
disabled HPET timers whose comparator value register is not<br>
0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers whose=
<br>
comparator value register is 0xffffffffffffffff don't cause any interrupts.=
<br>
About the first one, for example, an HPET driver writes 0x00000000aaaaaaaa<=
br>
to an HPET periodic timer comparator value register. As a result, the<br>
register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits<b=
r>
of the register doesn't affect itself in periodic mode. (see<br>
&quot;case HPET_TN_CMP + 4&quot; of &quot;hpet_ram_write&quot; function.) A=
nd &quot;timer-&gt;period&quot;<br>
which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, the=
<br>
HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The<br=
>
comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt<=
br>
time. The period (0xaaaaaaaa) is added to the comparator value register at<=
br>
&quot;hpet_timer&quot; function because &quot;hpet_time_after64&quot; funct=
ion returns true when<br>
the main counter is small. So, the first interrupt is planned when the main=
<br>
counter is 0x0000000055555554, but the first interrupt should occur when th=
e<br>
main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the code t=
o<br>
clear the higher 32 bits of comparator value registers of periodic mode<br>
timers when HPET starts the main counter. About the other two problems, it<=
br>
was decided by comparator value whether each timer is enabled, but it shoul=
d<br>
be decided by &quot;timer_enabled&quot; function which confirm &quot;HPET_T=
N_ENABLE&quot; flag.<br>
To solve these problems, I fix the code to decide correctly whether each<br=
>
timer is enabled. After this commit, the 3 problems are solved. First, HPET=
<br>
periodic timers cause the first interrupt when the main counter value<br>
reaches a value written its comparator value register. Second, disabled HPE=
T<br>
timers never cause any interrupt. Third, enabled HPET timers cause<br>
interrupts correctly even if an HPET driver writes 0xffffffff to its<br>
comparator value register.<br>
<br>
Signed-off-by: TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
---<br>
&nbsp;hw/timer/hpet.c | 8 ++++++--<br>
&nbsp;1 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c<br>
index 01efe4885d..2dcefa7049 100644<br>
--- a/hw/timer/hpet.c<br>
+++ b/hw/timer/hpet.c<br>
@@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; s-&gt;hpet_offset =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ticks_to_ns(s-&gt;hpet_counte=
r) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; s-&gt;num_timers; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((&amp;s-&gt;timer[i])-&gt;cmp =
!=3D ~0ULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_set_t=
imer(&amp;s-&gt;timer[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HPETTimer *timer =3D &amp;s-&gt;ti=
mer[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timer_enabled(timer)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timer_=
is_periodic(timer)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; timer-&gt;cmp &amp;=3D 0xffffffffULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_set_t=
imer(timer);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } =
else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABLE)) {<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_TY0PR0101MB4285AC5DF808D423B1E8EC66A4DE2TY0PR0101MB4285_--

