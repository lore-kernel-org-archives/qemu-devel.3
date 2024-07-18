Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68118C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR2C-0000QV-Om; Thu, 18 Jul 2024 09:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sUR2A-0000Dv-6S
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:18:58 -0400
Received: from mail-psaapc01olkn2048.outbound.protection.outlook.com
 ([40.92.52.48] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sUR26-0003vG-Ub
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO2ddkJ3V8HhM3A322GjmKN3ozLqZsnNas7NRJlG1PUM4ePukIzWgCAyWyJj82JUcuy5YwA4e5HclMiiWvv8+EeiKrriiowkZEbb7WTKZLZtxxm3r3ZSzEjo1CEP3SO+293X8HMwMJ3YK9tr1IpyjlpWqWandGe3OeRvMr/Cm+sGms0UtkZt/AUlqkA3HqniCH86PWIAIkf9zShMjDGfKqsghtLyfSAjKmXEMWs5phOmDYoMwR0k7HvkYtqz/mFB+lt/MzsIBwwhkni/YrcaG0cr0Z+jxk4egIxDuopOszrK9ZlaucXQ0Ke1p9IUhmDK0IqksE5iae5O86q1aJn1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EC/pJiCp/xOpe3G4v1JUONsZL8QE4sGSwaI1rHykaY=;
 b=TZTsv8qVpbGhdbh3DMlXW3QvLi/lzNpKX1wIl0NHpU7D5/co/IWElh3HDWlUyw7V4QwT6eYrtyWpzG/id+6Pcpi60nM0vocCXD+OzAT+Tyv1C/+s/zUYfg2RNDCnG/Pgp3/vWO1ugOm28trDeSxo/97A4G+CCW3rO9xCJ2a5FbbxjOkuEeqf3YqjXElsvdtXLvXEslwfCNMs0czpqvpZfCIlKlY8WDLJYeeKASl2QJO3Rlbgc2f4cv0XE5UbVk/FxAG5xVD/+iEW15tSkWGxbuLh7nzIGOuuDQA+lWhD0nwRoGwnFL3dR+WKQ2NdnpenkBjmeNBRqqDKPk2n+BvJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EC/pJiCp/xOpe3G4v1JUONsZL8QE4sGSwaI1rHykaY=;
 b=Nj7X21KIRbTc3IecneN9ijGRvM8eql1sw5LTMn5ozdCpgE7JwKRdiXyn1A8ERNkhjXlfPvSYC7aEUcWbGYeO6OwdUl9BY+g6lAbuqIzi6Bi87Q1YpTujxMx7lbUO5FurcSo7DxG7SobDGmBYfI0EObve+3/023rvSQRGN0jYpPwNhKxWK1xkFDMOWqyg3UDa9zhF4KyXpw0Uzzi3dKq4ZPTgCsTwl0RAkQ+N4ViPurPMit/jzMT27N3Kfg6HT/M0QgWqyqNDfub3lT4m0Tijx1nYMH+pI5YPoQRvDsfzbZGdLYf/O2bXQnrC69MT2I9WxTPbSxJjutO7+vRPYa5l1Q==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by SEYPR01MB5663.apcprd01.prod.exchangelabs.com
 (2603:1096:101:149::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 13:13:43 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%7]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 13:13:43 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Topic: [PATCH v2] hw/timer/hpet: Fix wrong HPET interrupts
Thread-Index: AQHa1Rtwdn1tm3IkKE2rzfA3EdJbv7H5Me+AgANLWcg=
Date: Thu, 18 Jul 2024 13:13:43 +0000
Message-ID: <TY0PR0101MB4285924D871AAB49D21184A1A4AC2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB42852FB948F0F0E8E753E257A4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <acc7f06a-0a95-428b-8946-71286fbcceb1@redhat.com>
In-Reply-To: <acc7f06a-0a95-428b-8946-71286fbcceb1@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [1hPbEbwYwd+HhaIEP9zJ/3k7h6ybs/5L]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4285:EE_|SEYPR01MB5663:EE_
x-ms-office365-filtering-correlation-id: 6c94a11b-0844-494f-1c6d-08dca72b72db
x-microsoft-antispam: BCL:0;
 ARA:14566002|12050799009|461199028|9400799024|8060799006|19110799003|440099028|102099032|3412199025|4302099013|1602099012;
x-microsoft-antispam-message-info: S/F6YNQyHKGPtkgC7K+kd8leU12g+/9HiepCVwpbU+xYW1pEzxs17AtSAYSNSSgGBU8z3U36znaiw1Ph+1fXzuw+DcQq9o++u//jO4Upxq89meK2x/MHiBIhmBKhHE6nQ9RFnoXnWetSl1xgFgZLrJKCvESJ7ljrmXk/oYVzmIYPFmgqG417xerI8egUNKQ3zlzqXoDbr8Aykd0CcZSRztmv4/da1Dfo1I2I8jbJcXUCCFCtbUiiiXv1ggrR4IMPaEAQzjlmp8QMXYxe3nofWbLds8jwu8+1JwXKqKs6/+S+iz9l16Gvs9CQPc/qVd3KV7CaHNfFT1M6vJtywwY6bksNcUV0B1Xkj4LozIpmv+SSotzc2bPalb0oSSb/FHwiZulmP56K99EZFiBfKJyjKNGqz5FOAiHbK0wKJT3BH7LSAP9HTQeAOFyqS4uvyY39HvBPlhpf0mAcj7+aJvooK5ZtR4Ps4nXgjgBaoJ4HJ1YZ9ybi8m1B45+fVXSA+K0vQqN5aymwqRbespoTgA+NKmbdlM3nduT4IklhqT0jOaPCEf/XM8IFlGoribrZeN3zvJCBchMwEKl74j3bNGV8HvBwcZ/y/H7R8MEopE/RkuAM/bBUGvFrf+LFazDm84q4Bx5fWzRlBB3kLLk7jqKdY63iSptRJX6deOPY7aMr6nKARw5kowH+yP42JyQd2DGc7jX9/1P0JXtcPmRbBcTJZju5Gc8gxV/tZADJVf4PgacnJumrUuv8UEHCI365Cgt36V01EhgyPn5VdYlPCnEac+Otz2dtrsmrM4D7AbZmqADcnIWR50PleAw4fAkM0G0Q
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?d0dnT0xJcWdxWUMrQVpRYnRXMGFicUZiMEx6MjQ2WFN5eWlKMDg5TnZi?=
 =?iso-2022-jp?B?dEFxOTRUdVNBbDJIUlB0ZldpNEFSMEduTGlYZmV4bXk2SFR5MVhUOHky?=
 =?iso-2022-jp?B?ajQ5Z3o0Y2FRT2ZmUS9kQUxpVkdneUVDUXgya0JjYzVDYU1zbjIwZzFk?=
 =?iso-2022-jp?B?Z1doVlA0dkxaMUdTZDZkQTdRYWpiTUlqbllTbDJING1zNmszRzkyZENv?=
 =?iso-2022-jp?B?SmNWVXZsQzI2dlN2bmFWNStLeFJDLytsZXltRy9pUmpzZnNja0UzME10?=
 =?iso-2022-jp?B?UXdkcStoL0tIOE02WGxPd0xzTTh4cm1aV2MweC9EbDZNRFhHb0xvK2Fu?=
 =?iso-2022-jp?B?NXovVnYzLzB1TGpPSkF6MlRUU1YvZTBaRndQTDBMRXhPSWNNVTUrbTZp?=
 =?iso-2022-jp?B?OVMvT2Fyd0RPekIyUWhFajVpdnhRY2d5dFdMQyszR0N6bFdpR1hoSzA3?=
 =?iso-2022-jp?B?cnBSRnZ6b25ZdWxmYWJtZitROHFsZFpzZnRJS20zZEg0NjlDb3puVzdr?=
 =?iso-2022-jp?B?OFdoWDVmaStjMUdDOWdIRkpEQWZuQXk4aktnUXJVK0RCR1VsVGhETnpD?=
 =?iso-2022-jp?B?N1J6ZGVjT3hiNXhDK0JyRTdzMldOYTBwZzYzcU9SdzZyK3RBUXBidzdT?=
 =?iso-2022-jp?B?Nm83amViSlQ0c1liWVNwREhvdlpwMm10WWVOcnRRZEt0TnVIMStYM1BH?=
 =?iso-2022-jp?B?dUpOWThYdlhMSVcxaEpKdTJzN3ZwcDRhd1c2c0JTY1gvNDRjTXYrZ0lP?=
 =?iso-2022-jp?B?SlFOV2toSFlURFkyT2RNRE5BRXlDakJFM3p1VTlRMDRTOVdES3ZXYkg0?=
 =?iso-2022-jp?B?bEl5aWZMbVNPcUVGUnRyVmZoemZDOENyWGhWV3hIM05icTQybW9EQXpL?=
 =?iso-2022-jp?B?aU4yM21kcmpydXU3QWtBcHZoVDdhQ3ZKb1pNRE9RTWVkRkhrMWhHR3Rn?=
 =?iso-2022-jp?B?S1hQcjRORGVuckVLRi9wRDJQa29hY0ZCcVYzcWg1VE52c2p1WkRlMDVm?=
 =?iso-2022-jp?B?dGdKVXBmY2o2TzdULzhwcWFkRGFyUmFDYnVYTVBTbjdTOTJZNGp4am9L?=
 =?iso-2022-jp?B?UTVkdVlLdm90eWxZNEg2dXdDNzZNR1BKYnlWckJQaHZod2RSU2lxUXNr?=
 =?iso-2022-jp?B?YnpEOGVORm9KQS9HYTZjWUxOL0ZrVUVTK0VNQjdlTmJzT3g3RG91OXB2?=
 =?iso-2022-jp?B?ZCtDQ29xWWYvVU1UeldXWCtuaExqd2V6VzllOHFuSjYra1BIQkJqRXV4?=
 =?iso-2022-jp?B?Sittelc1WDRaZVU0bkdyNjNlNlhxZlVvbndkUzBBbVJDTHpPMExIQ04z?=
 =?iso-2022-jp?B?QVJOMGhhbjl3YStodHhwK3JCTkc5cWdSd1o0K0V3Uy9yRDJ5dDRkVlI5?=
 =?iso-2022-jp?B?LzJtTnZiUzFtK2JKNVhObllkbEVDMUR3Qm9nSjNzeFo2Z3FIeUd2SEtR?=
 =?iso-2022-jp?B?YjNrTGJpTGxueU9JbXlRcVBVaDJCeUtQZURJVDcyb2h1Vndzdkt5S3hv?=
 =?iso-2022-jp?B?YnFXdmNlU0tqMUVRcTJVYjAyNUUrRG9PYTJRNnpWNVk5bTNLZkFUVmtW?=
 =?iso-2022-jp?B?alhMVUlmdFNFQk5wOEdBSm1OcDRMdkhVbVlZWUJKMXdxWGFxNCtjdmZj?=
 =?iso-2022-jp?B?ZE9YYkdXd0lERFpXMlFYTXZ3Nzh6a2VFRXowTTJIQ3NyWDRoWm5OTSta?=
 =?iso-2022-jp?B?bUU1ckZ4dy9ER3B4OEk5bWQ4ZGoySHRtK0VteUdpT1ZtUFo1bEFNYVlY?=
 =?iso-2022-jp?B?MzlZWDBxUnJUd05nWi93NE9samVIQ3VScjZIOUNIaGZYd1ZOV05OckU9?=
Content-Type: multipart/alternative;
 boundary="_000_TY0PR0101MB4285924D871AAB49D21184A1A4AC2TY0PR0101MB4285_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c94a11b-0844-494f-1c6d-08dca72b72db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 13:13:43.2091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5663
Received-SPF: pass client-ip=40.92.52.48; envelope-from=taisei1212@outlook.jp;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

--_000_TY0PR0101MB4285924D871AAB49D21184A1A4AC2TY0PR0101MB4285_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

I disassemble my HPET driver and confirm it does once 64bit writing to the
comparator register. However, QEMU does twice 32bit writings to the
comparator register. As a result, writing to the higher 32bit is rejected
because HPET_TN_SETVAL is cleared when lower 32bit writing. I think this
64bit writing should not be divided into twice 32bit writings. Anyway, I
will continue investigation about this bug. Also, please check the followin=
g
patch which affects HPET interruptions.

https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52=
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


--_000_TY0PR0101MB4285924D871AAB49D21184A1A4AC2TY0PR0101MB4285_
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
I disassemble my HPET driver and confirm it does once 64bit writing to the<=
/div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
comparator register. However, QEMU does twice 32bit writings to the</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
comparator register. As a result, writing to the higher 32bit is rejected</=
div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
because HPET_TN_SETVAL is cleared when lower 32bit writing. I think this</d=
iv>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
64bit writing should not be divided into twice 32bit writings. Anyway, I</d=
iv>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
will continue investigation about this bug. Also, please check the followin=
g</div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
patch which affects HPET interruptions.</div>
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

--_000_TY0PR0101MB4285924D871AAB49D21184A1A4AC2TY0PR0101MB4285_--

