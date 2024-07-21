Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C4DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 08:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVRop-0000yL-J5; Sun, 21 Jul 2024 04:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sVRon-0000og-0y
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:21:21 -0400
Received: from mail-eastasiaazolkn19010015.outbound.protection.outlook.com
 ([52.103.64.15] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sVRok-0002xe-B8
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNdiwI41b9NGz5NqegfSLPoLiULXrgZuV8M+HBHo4tRejaAGFFyLHIbTqliS55za/Ag2eE6U5J5PNeemhxVKUJMZIO8oq8ZeUYg/nTznHA+Xl9O/aeT/JgfT0uK9VEgcebUPoU6JY0SBugAUnNf7Y1w/6PGcQl84EP0Df3MKqu6Vh0v08Bo5RYqZggRD0kR442vxiUNDaQvwpHpmn7k0n3qJKPB/pqVpXQXEoPv25rgwr4DrFYSvvP1D4dND5IYjpXOuRhkQMpHcJDwB3QW0HRzoEfj1WqCsQWPWl6Vo9khoVJEHma3wXuz6OfqMCmGq2AEOsWKdLtc9NoEMnv410Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf5TeGVqxcN1/hh0Y0kCBnDQRZh5D7kcwradqLfHbmM=;
 b=xX64QAA3iOmInn8i8MY/++WySZXCNTXiUaDZ0mo3YG/Q71h4qSicDBnIdRkZQWIA5Aq/50aUBQY19/n52w9hFsOVLBpbU0ZI8U5qsh2BuNorL49yaHeTBCZ4nMA8w9fybxrkkh3a7y/dKf/qC15wRr7nti5cGYWUMqFvIKpoWCRnH7+6DKeA7R9JoEdPjphpZ48eKzJT5sm+vkOnSOF8p6k0cTqpBoR4RFcMTF4eUZdRpPEMc95tqzLd0L5UMGoSHjeIXtWIaUFkUPlctls6jcXQd8TXVZ7+BTFT0IzCmXlKk+GqI/9kubzSeksROKi9WatTON3GGQXYFX7yTLUSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf5TeGVqxcN1/hh0Y0kCBnDQRZh5D7kcwradqLfHbmM=;
 b=irhuRM1J6lSORKSI2WgZTKGLAuC9kZmqrATO9/iWTYBTUJ0gGKRRcpME9u+IrWwW82osi8zpbJtBTEJmYdGSkkNjHJ4sH9ynNH5knnm7e6IsXnSiR+UpJNiXGz86iu4H8Criu5x/wz69J2hXUD6SxEwDAWYOgKoynaQaOPhmlfXHXzamAFf/adSGiv+OWDUyUGdpTG9FIr7V6e+/wl0TxEZJ6gSMy9xWoqLHN5XnA3nd9BOQl6E77THyC3hutDkLzYkvzLd2e1AfMd7nz7pIZ3i0b4THmEwcRO9JwEyq1zCNWhtJwyBcvYd5WkwgzSOk+VTmPu/tzsOpJW08RHxCuQ==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by SI2PR01MB4371.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sun, 21 Jul
 2024 08:16:08 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%7]) with mapi id 15.20.7784.017; Sun, 21 Jul 2024
 08:16:08 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Topic: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Index: AQHa1Rtwdn1tm3IkKE2rzfA3EdJbv7H5Me+AgAZDt+WAAWuxTA==
Date: Sun, 21 Jul 2024 08:16:08 +0000
Message-ID: <TY0PR0101MB42855E481140E3E99E51CC36A4AF2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB42852FB948F0F0E8E753E257A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <acc7f06a-0a95-428b-8946-71286fbcceb1@redhat.com>
 <TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR0101MB4285DE1F3A47F29C5BC0018DA4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [kY1IKrDf7wCppMy7VelvPd6Jyg9z7JGV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4285:EE_|SI2PR01MB4371:EE_
x-ms-office365-filtering-correlation-id: 81afe49a-73ab-4c1c-c36a-08dca95d5feb
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799003|9400799024|461199028|12050799009|8060799006|440099028|102099032|3412199025|4302099013|1602099012;
x-microsoft-antispam-message-info: z6xZSPByAzAlaIzeu/bTukJiYavcjjmTl99WazOvsEpBZgXSh7M6cDaFdLkhzz4H/rhlreUguih2IvFtgrs2h25X6OWOUUQcdR78rvTnH6AOmEUhjE1GXrRGh9Ivu6HyhDb9spz9cCes0IWCWQrnpVzIC5+uzHoy5laJZgA3dPJ5R0LRNPp/N3lF/83cOAQbCBSmYKzwIi3sQU0o8aNlUABVifL8K1VLReKniQKYuPqgpAbqVNkmU3wpDYMucfCTDaFGex+jNEhMOlcCI1zOCbDi9jeicPEdG8XLUWGmo/JhK+zdXuGB3UjJ6nvMvLDLAGORRe9HogmG9ceDAvShqzBBvFmKlbMYp7mx0851S4cU6qRyYOQFJGOdGO47gMC042nOVzMKPKYB+AjPgVVXS/j++9cRdYYv9E8ahzzj9BRt3C0Z+I2rYuuhaQZKOHZQ+amLPL/geUB50X+shWGM/I4iJZBEbLYPuYWM8FFkTa/ZsYdIRE2MwbJs8tVT05eWh2xlyRWgu5LdsZbEicTWxezUUPa3AQzdWyQb54LOU31ZeVPo89aTNEtk755mDwfqWeS52h58pfrEepLwgqW8qpu1TDOCYCcXgEqWycmBg5r+8QLCcnz1nxNgQsIm+PD/eI6X7zR20Nj8y2hpC8HoJn76Dx+0Q1gCdP4iWetO4bZNHND2W2KGArlyxduYI9bVbwEeTS+1oFMjH6J4NWeQMHb/FAS5mBOt1qHG/1vZnRc1n/5DMjrv7DkjyBrhT/zv5gATHTcD9xJDrMN1iIkGRcbp8k+UjNDb0lWMdo5MHA9XVkcGmVEtB6q4HjlNcxaL
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Y0dVNHd2UjJzZjFqRWxDcHNaSUN1SUF1QkN3dExZbHZ0dGNBcDJOQURU?=
 =?iso-2022-jp?B?Sk81RXBKUGxSMUhyU3lYZlFZTGFLK1FIOXc1aUt1NTd0NGhBUDkwaTJX?=
 =?iso-2022-jp?B?ekx5K0VQM1pIeDlFM2gveWtVZU0rV0lrUTltbjM5alQwbU5Rb21NcDcw?=
 =?iso-2022-jp?B?bVdtNk43N3FReWhxSU1pK25HVHB1VnhBMmFwV2JSRmdMczJWRDg0MGxZ?=
 =?iso-2022-jp?B?SzBtVU11V3ppd1doVWVtZWJXOTk1b0J5OUtwTzBlSjRwa2hJL2Fkdmt4?=
 =?iso-2022-jp?B?R2VDclRYQTlJa1pCcG1RSkJ3TnFyZ0EwdWNRSGgyVWpqb0JWQWh0VDlZ?=
 =?iso-2022-jp?B?ckdnbTdWVnQ1ZmZqeDhKMkt3Z3h5dG9POGk0SW1tckNyZVpMcGZEMU9a?=
 =?iso-2022-jp?B?b1pNQlZyTmlUUzVwT0VaZzByZWtjMDFmQzBSbGNTSHoyRHF0WDlqSFRu?=
 =?iso-2022-jp?B?U2QwOFpQM21KUXdXazNBQ3p5UWZHbjU2ZmRIL3d1NUhwc1lUQlMzbVJ1?=
 =?iso-2022-jp?B?eW4rL2JKZlhDSEU1YVpKV0hoOFROdThueWhXbEFDNGgzb0daUzJmOFlr?=
 =?iso-2022-jp?B?MGkvMDhIQ3JNTW5SUzVUTERoRmwrUkRhR0ZnbHRnaEtDcWJFck0yUVBa?=
 =?iso-2022-jp?B?NEJhQ2hWY1o3ZUoxL01rUXhvZE94eWExYUtUeGxvNmRCR0VjTk40MDd5?=
 =?iso-2022-jp?B?NGRQK1c0SlpmcGpUWHhPQWxWd1A0d2Q3aC9FbE1wRnVETHdNa3Fmbi81?=
 =?iso-2022-jp?B?dkcwTnBDdGx4N0YvdGl6T3hMT1dCYWxUZXBQNk1RVGt6RFVXTU9DM3pZ?=
 =?iso-2022-jp?B?cUc3ZHJPVS9QYS95U3dobzlENnNpemI3ektHd1VGQ3lleEExMVJ3YzRK?=
 =?iso-2022-jp?B?UXZLSVlzb3ZWczJvUEloZ0pJT1NiUVo1d0J6a2VmWDBldWFocTIrcjE4?=
 =?iso-2022-jp?B?SjAvR2planhDSWEzZEN1VmNjWmE2TmJ1alNMbUVtQ1JsZy9IclN2Ymlj?=
 =?iso-2022-jp?B?NmF3dzBZdWtuMHk5d1BXdlRyTWlTaGdSUGg4RUVMejd5MmdpbU1PYVIr?=
 =?iso-2022-jp?B?NVAxNi82bGNlTjJlR3BublF5V3diVTFWanBsUitaajM0STJ5UDZBMVox?=
 =?iso-2022-jp?B?YmRVWDVkN0ZYTkxJV2RRSmRvTHgxZGljT1VjZXIzMVJVRTBvZUNzK204?=
 =?iso-2022-jp?B?ejl5RHIvNVNPdlZKcDVrbDY1ZW1sVU0raXY3enh0WTRCK1QwMmczK0tr?=
 =?iso-2022-jp?B?RXU4eWNIdXRUTU41VjZ0Z255bU9QWllZTk03Zk05ZDRiMDlkbW41RmFQ?=
 =?iso-2022-jp?B?SnVPdWZ0TFBMUkhvYXRsZzFldHV6bFdtUVBGT1czaTRISU1LbDZJcGcz?=
 =?iso-2022-jp?B?WVVnTmp6aExXRzRtZE1EQXN5M1hXbWFXbXJXalBKaVZ6T0FScEZtQnVw?=
 =?iso-2022-jp?B?UDBKWEVUazZyRERkTFZJL0ExSmhweEI0ZGlZVjFNd3RadTVVOE1mQitQ?=
 =?iso-2022-jp?B?OGpNNHRPSEUvVjJCWmhvZ3J6WDhmcHRaUmYrQUQzWGhpdnZ1Uk9kZTBD?=
 =?iso-2022-jp?B?eTZkVDNaNVdyVzBxbEptQ3NGVG0yVEUvcC9RVWpPbU01Z1RpRTNnU1ky?=
 =?iso-2022-jp?B?MEp6Q2xZMWZtdTk2WWJnUHVHRVo0NEFVZlp3NVFaa1JSSDFBS1ZtMFRZ?=
 =?iso-2022-jp?B?Vk5hNmEwNGxkSHdSZ3gvdWszdjBXbDNZR0hzL3dPaisyMXhKcjJNSFJh?=
 =?iso-2022-jp?B?RlU3SzdKRUhlV3RWMFk0STh5NGt3Y2hlUG1QWFJ1aDlpeUJNMVpIckE9?=
Content-Type: multipart/alternative;
 boundary="_000_TY0PR0101MB42855E481140E3E99E51CC36A4AF2TY0PR0101MB4285_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 81afe49a-73ab-4c1c-c36a-08dca95d5feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2024 08:16:08.5610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4371
Received-SPF: pass client-ip=52.103.64.15; envelope-from=taisei1212@outlook.jp;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_TY0PR0101MB42855E481140E3E99E51CC36A4AF2TY0PR0101MB4285_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Peter Maydell said my second patch is not right. So I modified the patch. I
forked Paolo's hpet branch and added my latest version patches. Please
confirm the following repository.

https://github.com/TaiseiIto/qemu

It passes my HPET test.

Taisei

________________________________
=1B$B:9=3DP?M=1B(B: =1B$B0KF#=1B(B =1B$BB@@6=1B(B <taisei1212@outlook.jp>
=1B$BAw?.F|;~=1B(B: 2024=1B$BG/=1B(B7=1B$B7n=1B(B20=1B$BF|=1B(B 19:32
=1B$B08@h=1B(B: Paolo Bonzini <pbonzini@redhat.com>; qemu-devel@nongnu.org =
<qemu-devel@nongnu.org>
CC: mst@redhat.com <mst@redhat.com>; marcel.apfelbaum@gmail.com <marcel.apf=
elbaum@gmail.com>
=1B$B7oL>=1B(B: Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts

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


--_000_TY0PR0101MB42855E481140E3E99E51CC36A4AF2TY0PR0101MB4285_
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
Peter Maydell said my second patch is not right. So I modified the patch. I=
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
forked Paolo's hpet branch and added my latest version patches. Please</div=
>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
confirm the following repository.</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://github.com/TaiseiIto/qemu</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
It passes my HPET test.</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Taisei</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>=1B$B:9=3DP?M=1B(B:</=
b>&nbsp;=1B$B0KF#=1B(B =1B$BB@@6=1B(B &lt;taisei1212@outlook.jp&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b>&nbsp;2024=1B$BG/=1B(B7=1B$B7n=1B(B20=1B$BF|=1B(B=
 19:32<br>
<b>=1B$B08@h=1B(B:</b>&nbsp;Paolo Bonzini &lt;pbonzini@redhat.com&gt;; qemu=
-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>CC:</b>&nbsp;mst@redhat.com &lt;mst@redhat.com&gt;; marcel.apfelbaum@gma=
il.com &lt;marcel.apfelbaum@gmail.com&gt;<br>
<b>=1B$B7oL>=1B(B:</b>&nbsp;Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET in=
terrupts</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thank you for preparing the hpet branch. I tried to use the branch. Your</d=
iv>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
modification was not enough to solve my problem but I confirmed that the</d=
iv>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
problem is completely solved by adding the following 2 patches on your hpet=
</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
branch.</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://lore.kernel.org/qemu-devel/TY0PR0101MB4285D5A3587179A5788F3356A4AE2=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Taisei</div>
<div id=3D"x_appendonsend"></div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri=
, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>=1B$B:9=3DP?M=1B(B:=
</b>&nbsp;Paolo Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b>&nbsp;2024=1B$BG/=1B(B7=1B$B7n=1B(B16=1B$BF|=1B(B=
 19:51<br>
<b>=1B$B08@h=1B(B:</b>&nbsp;TaiseiIto &lt;taisei1212@outlook.jp&gt;; qemu-d=
evel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>CC:</b>&nbsp;mst@redhat.com &lt;mst@redhat.com&gt;; marcel.apfelbaum@gma=
il.com &lt;marcel.apfelbaum@gmail.com&gt;<br>
<b>=1B$B7oL>=1B(B:</b>&nbsp;Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET in=
terrupts</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">On 7/13/24 13:54, TaiseiIto=
 wrote:<br>
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
&gt;<br>
&gt; Signed-off-by: TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; Changes in v2:<br>
&gt; - Reflect writings to higher 32 bits of a comparator value register ra=
ther<br>
&gt;&nbsp;&nbsp;&nbsp; than clearing these bits.<br>
&gt; - Fix wrong indents.<br>
&gt; - Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/TY0PR0101M=
B4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.c=
om/" id=3D"OWA6bd48e3a-80e4-f9e6-8946-57c50d72759a" class=3D"OWAAutoLink" d=
ata-auth=3D"NotApplicable">
https://lore.kernel.org/qemu-devel/TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</a><br>
&gt;<br>
&gt;&nbsp;&nbsp; hw/timer/hpet.c | 24 +++++++++++++++---------<br>
&gt;&nbsp;&nbsp; 1 file changed, 15 insertions(+), 9 deletions(-)<br>
&gt;<br>
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
This seems wrong to me.&nbsp; The comparator must be reset using<br>
HPET_TN_SETVAL, otherwise it just keeps running.&nbsp; From the specificati=
on:<br>
<br>
&quot;If software wants to change the periodic rate, it should write a new<=
br>
value to the comparator value register.&nbsp; At the point when the timer=
=1B$B!G=1B(Bs<br>
comparator indicates a match, this new value will be added to derive the<br=
>
next matching point. So as to avoid race conditions where the new value<br>
is written just as a match occurs, either the main counter should be<br>
halted or the comparator disabled when the new periodic rate is written&quo=
t;.<br>
<br>
The sentence &quot;at the point when the timer=1B$B!G=1B(Bs comparator indi=
cates a<br>
match&quot; indicates that the comparator register is not written.<br>
<br>
I suspect you're hitting the other issue, and HPET_TN_SETVAL is cleared<br>
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
e; I think<br>
the bug is that timer_enabled() should only affect generation of<br>
interrupts.&nbsp; Are you perhaps using level-triggered interrupts?&nbsp; I=
f so,<br>
it makes sense that you want the timer to be running - and then when<br>
setting HPET_TN_ENABLE the interrupt will fire.<br>
<br>
However, we're making progress; you're just finding more bugs.<br>
<br>
I have some ideas on what needs to be fixed next, and I placed them at a<br=
>
branch &quot;hpet&quot; of <a href=3D"https://gitlab.com/bonzini/qemu.git" =
id=3D"OWAbe7ef143-e84d-8df5-8891-4a1665527918" class=3D"OWAAutoLink" data-a=
uth=3D"NotApplicable">
https://gitlab.com/bonzini/qemu.git</a>.&nbsp; Unfortunately, I<br>
don't have a way to test them (writing testcases is on my list but I<br>
don't have time right now) and as the branch proceeds things get more<br>
experimental; but let me know if it helps or if you can make small<br>
changes to the patches that fix your testcase.<br>
<br>
Paolo<br>
<br>
</div>
</body>
</html>

--_000_TY0PR0101MB42855E481140E3E99E51CC36A4AF2TY0PR0101MB4285_--

