Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDC5C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 10:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV7OT-0007oD-Q9; Sat, 20 Jul 2024 06:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sV7OS-0007m1-GF
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 06:32:48 -0400
Received: from mail-sgaapc01acsn20806.outbound.protection.outlook.com
 ([2a01:111:f400:feab::806]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sV7OP-0002aJ-8M
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 06:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqECLAaFXlmfHMnpplzQDQnmD1LHeeJElaE2fCYLmRnPm29JAnaB4GnFvEBn/+MnYU0xl/J9NHgzFSHNBQbLrqlvfKWoSyNerZ0Gq+RVAjc1n3Yeex/o2Af5tg9vn1hffVZTDCmftReLuM/4/jPt41OTrO3ECL7SO34um5KH9/VTMTPYIYKtOzr1UJiwGgd+uo0voPojIek7r27kbl2uK/G6cCfyna/12P8yZvwAlKpNbyAZPCPZN1LHwxwjN+ul7/kBCB9WqYbfjVzwzahceGkk2xV8BBwNDklE4RUXy/aYqW+x/OVEqeGLjIegSn4keQZkeVUkEk9U0wqjl5s6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoYVBQp/4x/10TVLDvHFE/OPzzTvTXbemudPrvzoeVo=;
 b=anFrg9iueLyQT8zpzyNQhOcILPXbTvzaOuUCVAS+OfrvbeA6QOHKS92RBFWO9fG6zbxvA/AvQ5hSxDLw94P2SdeujP8+3CgjcWMh0+TA3eWdumib51U2dUdZeAkfA72kFa/8kh22uHJXe3Q/l9HbII/yvBSqyGeK8+Rmy9L3M+UT1lieCh7+kEivu1bNhu0UnkaApcJSXanGUpHZwwyl1gFmTYEuaR+QHLKHNJJjDjkKnGd3ua2IxAGy7Vzn0GhscoRlZD16sTgeXeREthShockZpxn0MLVGeWR13M8Ro29ahu9nRmOX+9WNU16PsOZManm04O4sXIlzPPFE3ED6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoYVBQp/4x/10TVLDvHFE/OPzzTvTXbemudPrvzoeVo=;
 b=nYKU36roVypopHoMjZo3GMzx9LuWHQdE3qFD1mkG1vjytA+R8ElX0RsPZ/ny7lZ1dZ/RRnbdZ4zqWcSsrZ7nVzsA0ARhOueA4bc+viuH4Y3XlDXW9YvOCVNYhKOwB+JJpaI+jX8HiJmm8cdT17VKAvmqklC2Sl5kk8NV8zN1oh1kADOK6foUMr6aQM0uWuefOy3CzofIaizXJpchLwTso2Co379G4Y8h5kQ89dmydw/jsZXG5cwj85yykH7+LB6qZ/HNmJxcuL+VKOLiEzpHGm3Uz7QAiETN7ubkNauFJlzNoKVsvdq7geJZ4G0wp+X6fCxo09fTMCV+pUcD6Fnj7w==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by SEYPR01MB4831.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 10:32:35 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%7]) with mapi id 15.20.7784.017; Sat, 20 Jul 2024
 10:32:35 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Topic: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Index: AQHa1Rtwdn1tm3IkKE2rzfA3EdJbv7H5Me+AgAZDt+U=
Date: Sat, 20 Jul 2024 10:32:34 +0000
Message-ID: <TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB42852FB948F0F0E8E753E257A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <acc7f06a-0a95-428b-8946-71286fbcceb1@redhat.com>
In-Reply-To: <acc7f06a-0a95-428b-8946-71286fbcceb1@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [ZelysuXBJoSbK1lbN7YuDAbnSzVuEBCX]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4285:EE_|SEYPR01MB4831:EE_
x-ms-office365-filtering-correlation-id: 9e448880-afda-4810-1d91-08dca8a744f9
x-microsoft-antispam: BCL:0;
 ARA:14566002|9400799024|12050799009|8060799006|461199028|19110799003|1602099012|440099028|102099032|4302099013|3412199025;
x-microsoft-antispam-message-info: 52+YYeznf0jgLFuIF49Ca8seQYG8pMDgn/WbFbytHbyNp48zSPVG4D9qiwfDdca3vZtbaDACSQ5RxnbK4ZsE1xXF3xZim/Zz5x6LzOh9K1n6Zminqvili1fwnw2zlL639ZNkeqDNDauoRyzKrRnp1KxJi9/s38tGqIrjirw+Cn9JCBsvNWP3HzsZb6M38ZKL2NH3pp3XLUjq1sy5uo2dFT6JVWJQ13YEapipQacbwgaoBf95Cc0H8tVf2wSOHveZhkp4TQL05o5XaClMiF4TyUQZLOnLsjSwP/135iUuOx/zQPzxtXUbX+7uqZlt1K/iNFNoCo5TZjyw2XF93glvGAVyKQzD++kZKqDV9ZNRuUbR/sXc1IjcDKaRgh3pSYtUCkt63yuSqUZA/njNLAxzXh8wLb15yI+9nxCPFdLyK4avSGv8k6zOX68tZQ08GV+SPH95QkjO0Ebax8oOcBuOQzfnHkDuprcPSHXEq0KhEPKU306ua+PYXFSbDeifskVIQot0XtwH0cnVpRqR6jbPKAggE8QelgyL+EfTS+VXuYReBYFV4Zc/FcXozrZtG1eEfQzFZKhG0MJe3W2gTOMV9bjcwNH5M3U0bQdyCBED18t67OXlm5lrd9UCLaSFoHUtJ54otPUfgyVNfLP2JaZCYPqDqoi7E7+F9GkEHQflFIVmAuLcVWuVghB6HIPK1VoRYm8h5cztRRYAM25Ba81F4FUGseqVFLmCpfJRxh8TiJzK4AGu89A/DL6qg3eVvufnBMW6HKMQ4EvaXk8AIXIRRQXWjs3+Nf0GBltVTzbzYiTlPKQCexE2R7YQpes4xJT3
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QlRGSjFnOE1JalFVcURMbjhSZDg5OXRHWUx0QzM3Uko5OWNkelB3aVN3?=
 =?iso-2022-jp?B?SWtReitEdHU5ZHkrYURUWlRHdlZlZ0s1ZEEvQU5WY3hsK0NTWDV6SWxI?=
 =?iso-2022-jp?B?akhiY1R6N2dsUjBHOTlFcktDclU1NVFBUWdGTUoraDZYTDlwdlNIUTNL?=
 =?iso-2022-jp?B?M2VoUHhCQnpYaWU2S0J2TEIrNkhPQ096SFVaQllSdXpwbFJUZjFIMEVx?=
 =?iso-2022-jp?B?V0taYmFBYkpqdGZUSnMwVFJDNmt4Sisvc0ZpM255d3lqREd0S0F1S2t1?=
 =?iso-2022-jp?B?TTJEUmpJMWNLcHdYVk9lZ2hSUjBIZ3loc2NZblRDcWdnbll5WmpiVTdI?=
 =?iso-2022-jp?B?em5XakIvenhzZ3pJdjNlSHA4S3hnV1BrMEtZV3JiSmpXaXg4MjN1Mmly?=
 =?iso-2022-jp?B?SUZETnBHZ1dLWFVQMXpJQzNkMVFhVzNSYnl2MzBBa243WHNvTHQxZUpt?=
 =?iso-2022-jp?B?blM2clp0UjdrZ3pPaUdqK01ONGhvMjNxL3NZSGtoZVNsMUNGbDRLSkYr?=
 =?iso-2022-jp?B?WXB3U1o1TVBCUFAzd0t0Nmx4VTFGOThHWm1VOVJFM3ladGJpOGZwVmF3?=
 =?iso-2022-jp?B?ZGFzWFFwQmY4cXRnMFJUOFlPZUYvYXY4UW5YYzJ5Y09sbDYvRmhEQjBJ?=
 =?iso-2022-jp?B?WkFGUGI3MjhOa1pGc0FEQ2l4dG4xcGoyWGxrZEJEeVErWTVHVm8vcmxU?=
 =?iso-2022-jp?B?b1VZamFsS25sRnhlL1piL0VxbnN2UTJCeDFNeFJmdWZqTFp4d0ZwRW9S?=
 =?iso-2022-jp?B?aW8zZkRZZ2QvNk9vdi9lNkp4aXRRSnhmc0haek0rRnVCcXpFLy9JdTBh?=
 =?iso-2022-jp?B?M29KOGYvVWIxM2ppSVd0TDMvM3lOeEFUbkcxemVqODd4a0FVRmx3SWhw?=
 =?iso-2022-jp?B?V1o5emxjUFI2UE5TUEtWek1oR2lTZFRUMUllMS9wUkNtWjZwZkw0TjJK?=
 =?iso-2022-jp?B?VmxWVVdSM29MV2ZJdzc0V21pQXNFbTRqWS9TUGlJaFFoYSt4V29ZRUJw?=
 =?iso-2022-jp?B?M0NSRHdzSU9mbHhTZUVidVI4bXVDYzl2Mkh4ZmJ3aE5hQWdpdDdEeUph?=
 =?iso-2022-jp?B?UmhiSXF3bUVRNjlSUUV0cmZNQkhGbkpVdUVweDhuWll5dmFIVVM1WHpq?=
 =?iso-2022-jp?B?UnI1Q2c3dlEzc2wrSkoyVjhxVm1YZEpxNWJtTXlZc1h1QTN4bCtCVEhK?=
 =?iso-2022-jp?B?NEwxc1QxcHNmUm4yVDVuaW1uUUVOK1RzcFpnRHlRamM4TjJremo0L29y?=
 =?iso-2022-jp?B?RTkwV3RpMmpJN0JORkdpek56U3RtWW1KcTVUeXI1L0JYRXNCRU1XbFNZ?=
 =?iso-2022-jp?B?UFY2MlQrREE1K0VRNDVTTC9XN05MM1pJWkViQ01Xbml5SVk3NkxJU3R2?=
 =?iso-2022-jp?B?KzE2ZGdIbWtERy9JdTNxZlBxT0htSXBZNVNlMHE0QzBmWWx6RnFReWVJ?=
 =?iso-2022-jp?B?eWpGOXhWbFVvQU5qa09SYXNUWjhWUzkxL2NMYmhUU1VXWjYzWEpnaU1s?=
 =?iso-2022-jp?B?TVpsMXEwYXhmR2k4d1dZRC9WdFZCdHMvTmx3bnJxNTdNNnRNQUN5T2pY?=
 =?iso-2022-jp?B?WVhteGxiY3RSMkF4aTF2VXV4TDhicjk2c2JTTVFRT0pVWHZxUjJGbndT?=
 =?iso-2022-jp?B?QW5nOGtabEhiMUl4SzFjWDUxNUZrOU81TGQyOWFJT0xaK0ZwQSt2c0hL?=
 =?iso-2022-jp?B?QUdHd3cwd0x4dnl2eDM5aTd0d1ZWRVFTMmtVbTk5M0Z1ZnErZGN1NmMx?=
 =?iso-2022-jp?B?cExmMzdVZHVMUzF3NCtyM2ZFbnI3bmx0QTJHZXJWNkFsWjZlRlFLV0U9?=
Content-Type: multipart/alternative;
 boundary="_000_TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2TY0PR0101MB4285_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e448880-afda-4810-1d91-08dca8a744f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 10:32:34.9323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4831
Received-SPF: pass client-ip=2a01:111:f400:feab::806;
 envelope-from=taisei1212@outlook.jp;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2TY0PR0101MB4285_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thank you for preparing the hpet branch. I tried to use the branch. Your
modification was not enough to solve my problem but I confirmed that the
problem is completely solved by adding the following 2 patches on your hpet
branch.

https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/
https://lore.kernel.org/qemu-devel/TY0PR0101MB4285D5A3587179A5788F3356A4AE2=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/

Taisei
________________________________
=1B$B:9=3DP?M=1B(B: Paolo Bonzini <pbonzini@redhat.com>
=1B$BAw?.F|;~=1B(B: 2024=1B$BG/=1B(B7=1B$B7n=1B(B16=1B$BF|=1B(B 19:51
=1B$B08@h=1B(B: TaiseiIto <taisei1212@outlook.jp>; qemu-devel@nongnu.org <q=
emu-devel@nongnu.org>
CC: mst@redhat.com <mst@redhat.com>; marcel.apfelbaum@gmail.com <marcel.apf=
elbaum@gmail.com>
=1B$B7oL>=1B(B: Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts

On 7/13/24 13:54, TaiseiIto wrote:
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
> register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits=
 of
> the register doesn't affect itself in periodic mode. (see
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
> main counter is 0x00000000aaaaaaaa. To solve this problem, I fix
> "case HPET_TN_CMP + 4" of "hpet_ram_write" function to ensure that writin=
gs
> to higher 32 bits of a comparator value register reflect itself even if i=
n
> periodic mode. About the other two problems, it was decided by comparator
> value whether each timer is enabled, but it should be decided by
> "timer_enabled" function which confirm "HPET_TN_ENABLE" flag. To solve th=
ese
> problems, I fix the code to decide correctly whether each timer is enable=
d.
> After this commit, the 3 problems are solved. First, HPET periodic timers
> cause the first interrupt when the main counter value reaches a value
> written its comparator value register. Second, disabled HPET timers never
> cause any interrupt. Third, enabled HPET timers cause interrupts correctl=
y
> even if an HPET driver writes 0xffffffffffffffff to its comparator value
> register.
>
> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
> ---
>
> Changes in v2:
> - Reflect writings to higher 32 bits of a comparator value register rathe=
r
>    than clearing these bits.
> - Fix wrong indents.
> - Link to v1: https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC5=
6DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/
>
>   hw/timer/hpet.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 01efe4885d..4b6352e257 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr addr=
,
>                   timer->period =3D
>                       (timer->period & 0xffffffff00000000ULL) | new_val;
>               }
> +            /*
> +             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to =
the
> +             * high bits part as well.
> +             */
>               timer->config &=3D ~HPET_TN_SETVAL;
>               if (hpet_enabled(s)) {
>                   hpet_set_timer(timer);
> @@ -562,20 +566,22 @@ static void hpet_ram_write(void *opaque, hwaddr add=
r,
>               if (!timer_is_periodic(timer)
>                   || (timer->config & HPET_TN_SETVAL)) {
>                   timer->cmp =3D (timer->cmp & 0xffffffffULL) | new_val <=
< 32;
> -            } else {
> +            }
> +            if (timer_is_periodic(timer)) {
>                   /*
>                    * FIXME: Clamp period to reasonable min value?
>                    * Clamp period to reasonable max value
>                    */
> -                new_val &=3D (timer->config & HPET_TN_32BIT ? ~0u : ~0ul=
l) >> 1;
> +                new_val =3D MIN(new_val, ~0u >> 1);
> +                timer->cmp =3D (timer->cmp & 0xffffffffULL) | new_val <<=
 32;

This seems wrong to me.  The comparator must be reset using
HPET_TN_SETVAL, otherwise it just keeps running.  From the specification:

"If software wants to change the periodic rate, it should write a new
value to the comparator value register.  At the point when the timer=1B$B!G=
=1B(Bs
comparator indicates a match, this new value will be added to derive the
next matching point. So as to avoid race conditions where the new value
is written just as a match occurs, either the main counter should be
halted or the comparator disabled when the new periodic rate is written".

The sentence "at the point when the timer=1B$B!G=1B(Bs comparator indicates=
 a
match" indicates that the comparator register is not written.

I suspect you're hitting the other issue, and HPET_TN_SETVAL is cleared
incorrectly by a 64-bit write.  I'll try sending out a patch to fix that.

> -                    if ((&s->timer[i])->cmp !=3D ~0ULL) {
> +                    if (hpet_enabled(s)) {
>                           hpet_set_timer(&s->timer[i]);
>                       }
>                   }

This is incorrect too.  "hpet_enabled(s)" is always true here; I think
the bug is that timer_enabled() should only affect generation of
interrupts.  Are you perhaps using level-triggered interrupts?  If so,
it makes sense that you want the timer to be running - and then when
setting HPET_TN_ENABLE the interrupt will fire.

However, we're making progress; you're just finding more bugs.

I have some ideas on what needs to be fixed next, and I placed them at a
branch "hpet" of https://gitlab.com/bonzini/qemu.git.  Unfortunately, I
don't have a way to test them (writing testcases is on my list but I
don't have time right now) and as the branch proceeds things get more
experimental; but let me know if it helps or if you can make small
changes to the patches that fix your testcase.

Paolo


--_000_TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2TY0PR0101MB4285_
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
Thank you for preparing the hpet branch. I tried to use the branch. Your</d=
iv>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
modification was not enough to solve my problem but I confirmed that the</d=
iv>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
problem is completely solved by adding the following 2 patches on your hpet=
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
branch.</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://lore.kernel.org/qemu-devel/TY0PR0101MB4285D5A3587179A5788F3356A4AE2=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Taisei</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=1B$B:9=3DP?M=1B(B:</b> Paolo B=
onzini &lt;pbonzini@redhat.com&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b> 2024=1B$BG/=1B(B7=1B$B7n=1B(B16=1B$BF|=1B(B 19:5=
1<br>
<b>=1B$B08@h=1B(B:</b> TaiseiIto &lt;taisei1212@outlook.jp&gt;; qemu-devel@=
nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>CC:</b> mst@redhat.com &lt;mst@redhat.com&gt;; marcel.apfelbaum@gmail.co=
m &lt;marcel.apfelbaum@gmail.com&gt;<br>
<b>=1B$B7oL>=1B(B:</b> Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interru=
pts</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 7/13/24 13:54, TaiseiIto wrote:<br>
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
&gt; About the first one, for example, an HPET driver writes 0x00000000aaaa=
aaaa<br>
&gt; to an HPET periodic timer comparator value register. As a result, the<=
br>
&gt; register becomes 0xffffffffaaaaaaaa because writing to the higher 32 b=
its of<br>
&gt; the register doesn't affect itself in periodic mode. (see<br>
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
&gt; main counter is 0x00000000aaaaaaaa. To solve this problem, I fix<br>
&gt; &quot;case HPET_TN_CMP + 4&quot; of &quot;hpet_ram_write&quot; functio=
n to ensure that writings<br>
&gt; to higher 32 bits of a comparator value register reflect itself even i=
f in<br>
&gt; periodic mode. About the other two problems, it was decided by compara=
tor<br>
&gt; value whether each timer is enabled, but it should be decided by<br>
&gt; &quot;timer_enabled&quot; function which confirm &quot;HPET_TN_ENABLE&=
quot; flag. To solve these<br>
&gt; problems, I fix the code to decide correctly whether each timer is ena=
bled.<br>
&gt; After this commit, the 3 problems are solved. First, HPET periodic tim=
ers<br>
&gt; cause the first interrupt when the main counter value reaches a value<=
br>
&gt; written its comparator value register. Second, disabled HPET timers ne=
ver<br>
&gt; cause any interrupt. Third, enabled HPET timers cause interrupts corre=
ctly<br>
&gt; even if an HPET driver writes 0xffffffffffffffff to its comparator val=
ue<br>
&gt; register.<br>
&gt; <br>
&gt; Signed-off-by: TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changes in v2:<br>
&gt; - Reflect writings to higher 32 bits of a comparator value register ra=
ther<br>
&gt;&nbsp;&nbsp;&nbsp; than clearing these bits.<br>
&gt; - Fix wrong indents.<br>
&gt; - Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/TY0PR0101M=
B4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.c=
om/">
https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</a><br>
&gt; <br>
&gt;&nbsp;&nbsp; hw/timer/hpet.c | 24 +++++++++++++++---------<br>
&gt;&nbsp;&nbsp; 1 file changed, 15 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c<br>
&gt; index 01efe4885d..4b6352e257 100644<br>
&gt; --- a/hw/timer/hpet.c<br>
&gt; +++ b/hw/timer/hpet.c<br>
&gt; @@ -552,6 +552,10 @@ static void hpet_ram_write(void *opaque, hwaddr a=
ddr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;period =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (timer-&gt;pe=
riod &amp; 0xffffffff00000000ULL) | new_val;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; * high bits part as well.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; timer-&gt;config &amp;=3D ~HPET_TN_SETVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (hpet_enabled(s)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpet_set_timer(timer);<br>
&gt; @@ -562,20 +566,22 @@ static void hpet_ram_write(void *opaque, hwaddr =
addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!timer_is_periodic(timer)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || (timer-&gt;config &amp; HPET_TN_SE=
TVAL)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer-&gt;cmp =3D (timer-&gt;cmp &amp=
; 0xffffffffULL) | new_val &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } =
else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (timer_is_periodic(timer)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FIXME: Clamp period to reason=
able min value?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Clamp period to reasonable ma=
x value<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; new_val &amp;=3D (timer-&gt;config &amp; HPET_TN_32BI=
T ? ~0u : ~0ull) &gt;&gt; 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; new_val =3D MIN(new_val, ~0u &gt;&gt; 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; timer-&gt;cmp =3D (timer-&gt;cmp &amp; 0xffffffffULL)=
 | new_val &lt;&lt; 32;<br>
<br>
This seems wrong to me.&nbsp; The comparator must be reset using <br>
HPET_TN_SETVAL, otherwise it just keeps running.&nbsp; From the specificati=
on:<br>
<br>
&quot;If software wants to change the periodic rate, it should write a new =
<br>
value to the comparator value register.&nbsp; At the point when the timer=
=1B$B!G=1B(Bs <br>
comparator indicates a match, this new value will be added to derive the <b=
r>
next matching point. So as to avoid race conditions where the new value <br=
>
is written just as a match occurs, either the main counter should be <br>
halted or the comparator disabled when the new periodic rate is written&quo=
t;.<br>
<br>
The sentence &quot;at the point when the timer=1B$B!G=1B(Bs comparator indi=
cates a <br>
match&quot; indicates that the comparator register is not written.<br>
<br>
I suspect you're hitting the other issue, and HPET_TN_SETVAL is cleared <br=
>
incorrectly by a 64-bit write.&nbsp; I'll try sending out a patch to fix th=
at.<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((&amp;s-&gt;timer[i])-&gt=
;cmp !=3D ~0ULL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hpet_enabled(s)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hpet_set_timer(&amp;s-&gt;timer[i]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
This is incorrect too.&nbsp; &quot;hpet_enabled(s)&quot; is always true her=
e; I think <br>
the bug is that timer_enabled() should only affect generation of <br>
interrupts.&nbsp; Are you perhaps using level-triggered interrupts?&nbsp; I=
f so, <br>
it makes sense that you want the timer to be running - and then when <br>
setting HPET_TN_ENABLE the interrupt will fire.<br>
<br>
However, we're making progress; you're just finding more bugs.<br>
<br>
I have some ideas on what needs to be fixed next, and I placed them at a <b=
r>
branch &quot;hpet&quot; of <a href=3D"https://gitlab.com/bonzini/qemu.git">=
https://gitlab.com/bonzini/qemu.git</a>.&nbsp; Unfortunately, I
<br>
don't have a way to test them (writing testcases is on my list but I <br>
don't have time right now) and as the branch proceeds things get more <br>
experimental; but let me know if it helps or if you can make small <br>
changes to the patches that fix your testcase.<br>
<br>
Paolo<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2TY0PR0101MB4285_--

