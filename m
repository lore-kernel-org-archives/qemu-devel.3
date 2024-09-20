Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5A0CF58CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 04:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srVVi-00053C-80; Fri, 20 Sep 2024 00:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swung0x48@outlook.com>)
 id 1srUq3-00079z-FF; Fri, 20 Sep 2024 00:01:47 -0400
Received: from mail-me3aus01olkn2081a.outbound.protection.outlook.com
 ([2a01:111:f403:2818::81a]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <swung0x48@outlook.com>)
 id 1srUq0-0003TK-Oo; Fri, 20 Sep 2024 00:01:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKT+Qjknt5JNoMHrgj/YJqWRxmaOykPqor+rAFUb8KYtYdglYIss+M5zGxcGlADfiuNO+Otd+ZT3DWrUoWQ6CGQpl6HcfOBkIIGljzmHotbl0fgfCw10dJOOi6tiHA+d52b/BjtTx2ecBpBM28R2ycIJuqdKPnjkRhhzha8HLaipmUMfdXHOi0QMTS7WFtttiPQfH4oQvhCiVJ67XWvq8jih1Pp/kJCM2wTvAzpg3grcPOOvG0QJrocRCCF+wRZ1c/JYR8sqRONVu76khcpiB6o0RqvHGzZBH67rY5IhVkirITe6UhJXb8c+N3HfMWURTpaimSsqWErev3Hu6HPZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex7raIjRS9Vz/xflVtDRKgPcFKc0WMt++ecnfwwBym0=;
 b=BqFXaDxT9dcxujOziXx2lY7V7pc7+5YxMDRoZjmHyLBZsT+C+QG3lYpITTrlqcDXLki63fxmzbKKFsKkvIO3eRWu62OgOATppVUfnDrIQNAz1kmPZOMju2ebBViYljdSQe+Ki+oJORWTOg2ciWZRxXdhcrgPGi+JiIOrG9I2oKfwTUN5DYmP57VPNX6eEAzYKvbwh8zEthT43bhWkuKsSuhjdOVGHNixBmVRFQc7iXoINOtBDltEFJ4OWevkDg+IHeifSM4epHNibMd0l3B/aitxKG8y8hNw3CRf/M6AewbTsl3sEDCB3waq2Joghya8MR4x11LUZ46jpon8TJbR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex7raIjRS9Vz/xflVtDRKgPcFKc0WMt++ecnfwwBym0=;
 b=egwty39qNpSVwdUQTJIyaOiK0IvQLCPHEuay/lwfRTowjqYJ2HhOzq5HxQc5bMsvTlVK0mGU/XhTd+vP/pHYbtMP1aaIALDc4hPsBAX1RfEUaezebymSbrarQEDi8wF+vdiM25OZP84fb0Ww4VgbpOltIoDeKo+DJljOOlGdlaf3/1ND752RyKhz5wihSDrQLRrp8t3ZriiaVZr7NDW2uG/h7lnYN2ovQsxtwoBARH7T+De7dKVDdlyOiBGaj+JnGS48lFhLggxcYEz6UwNQ3rtVGW7EFQ1sjUKpsOt8tZ5WlQILgQ6DHgSyoQOnr/vX1a9OEGA2nj9PeTzHEHpkbQ==
Received: from SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:262::8) by
 SY8P300MB0571.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:299::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.17; Fri, 20 Sep 2024 04:01:35 +0000
Received: from SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM
 ([fe80::70b2:a779:d7b3:2e0f]) by SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM
 ([fe80::70b2:a779:d7b3:2e0f%4]) with mapi id 15.20.7962.022; Fri, 20 Sep 2024
 04:01:35 +0000
From: 0x48 Swung <swung0x48@outlook.com>
To: Richard Henderson <richard.henderson@linaro.org>, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "bmeng.cn@gmail.com"
 <bmeng.cn@gmail.com>, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
Thread-Topic: [PATCH v4 02/12] tcg/riscv: Add basic support for vector
Thread-Index: AQHbBE6HkCjgGq4WQkCpc+O+WxTXqLJS672AgAofvACAAFJBAIAACN+AgAA+ggCAAlv36A==
Date: Fri, 20 Sep 2024 04:01:35 +0000
Message-ID: <SY8P300MB02825DF878585DDC68EB088CE06C2@SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-3-zhiwei_liu@linux.alibaba.com>
 <0d591570-02c6-48c9-9e3f-ef47ac20ce7d@linaro.org>
 <b87e7a7e-41fd-4b26-bde3-9adca9babb24@linux.alibaba.com>
 <33101e38-080d-4444-a8c3-9d01827e243f@linaro.org>
 <b88244bc-aaf7-42f9-a90f-e4027ac72ebf@linux.alibaba.com>
 <20e20fde-830f-4314-a944-e7973bda5d8c@linaro.org>
In-Reply-To: <20e20fde-830f-4314-a944-e7973bda5d8c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY8P300MB0282:EE_|SY8P300MB0571:EE_
x-ms-office365-filtering-correlation-id: 9b5b4a7b-79a6-4e34-d1ef-08dcd928eb61
x-microsoft-antispam: BCL:0;
 ARA:14566002|8060799006|19110799003|14030799003|461199028|15080799006|12050799009|7092599003|9400799024|440099028|3412199025|4302099013|3430499032|102099032|1602099012|10035399004;
x-microsoft-antispam-message-info: =?us-ascii?Q?qmmZ1r53EyJ+XpcHotY8eJ0tsVfxQluGEtl81zKU6VqrdGxO3qBElSyrsbfm?=
 =?us-ascii?Q?qUNRcgylDRQH4ecvYzWwU2nyya77mlPUVMIPKDW3eGnwjXY9aJa12JuUN4d2?=
 =?us-ascii?Q?qK8eIUfIDAVbv3LIdBLsyl6IBVMD02N2kS+7YKYcgrastJQGjpMLo4r7zg4g?=
 =?us-ascii?Q?saQcwPw/fK5NfbfipgYRgacBrLGjZN23FCq8Zwn6e0k5Mqd37b1QQcLdqMT3?=
 =?us-ascii?Q?B1B2KJxSYYxXhJ6afVYDMr52fzQ4CmjeibdslHyeVNdnd64gYzvtJOxaBC8D?=
 =?us-ascii?Q?vin491yvCNvXA7AvmHBXiKBtn0Nb8zxEcSjCiWXkIpBNO0e0nn61yPi034gH?=
 =?us-ascii?Q?UGnee6VnXMH4mvqdjIXejpTxEmno5HryEttkfuk3Xh/zDsCwA1gOQr7IlspO?=
 =?us-ascii?Q?HLL62vJzED1tJko0NuhcrdPAJSfCkcG2GL/6fothZayNqNzNnIU92Q5qIzIS?=
 =?us-ascii?Q?EW+4ZvivF9zZY7HKcZ4qUhwaVytHe8Q0gXgbmVPg5IR6XitArA25KNSNQb2x?=
 =?us-ascii?Q?Z6DKomRZ/4ZAgLFK1Dtdj97PLo1IFS0HS88juWkZobIsXifJujnuT71pGs2U?=
 =?us-ascii?Q?lpz2brMLNwl6d3jMMX20eEjrnubAtn34v8omhDWKnYny0gLCW9i6Petu1UZT?=
 =?us-ascii?Q?AeGgcv1Tv8BzMhf0HwCUxr1BkC1NAr3nbANWPm62Bn/Sb2ws6OkxPaU7Bpcl?=
 =?us-ascii?Q?Z40foQPrpXPPq6TFNvMw2LwliH0KS7PQhgF7RieYq9oQM183FB9TaTPaUmfu?=
 =?us-ascii?Q?OxJo5TnomSmWZqDU/284rOu/neSYc305e/BsEfVFRmSkUrcNNtGEJgznFuMx?=
 =?us-ascii?Q?WxNKBwp/tjBoLa7G50QnKvgA4XFb+8fxQniMK8SNqIk+ykzQc41R0CHPfYnG?=
 =?us-ascii?Q?qeKq0vrwUuRQk1LXb4U3juU2uV/oRSB9IGmZnWzWhHRtBZ5igVeZ96wcSf2s?=
 =?us-ascii?Q?Ncw4C00Ur5WwXv4MVmjr/A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LObRskrN3EMe+SWFUyPVAqO6jA8j0lYHA4ipcdynIjECcqzwZcN0s5k1pyg3?=
 =?us-ascii?Q?EXikJ/q2QCLjXNl0er3EEVGwlk2x9oZHn2S6y3sOY/xFlO6khW2y1aqPdxSD?=
 =?us-ascii?Q?JILjHyFuA+BBkDMO8Kzfh6ZLk2KiFPvqSKki0p0h5us+QzSNJpc7hVg77vm7?=
 =?us-ascii?Q?hMYX48LBqbLSS4EtumJlgyiNt8lj7syrmEail+NZ1rRAe4dW14nPZHF4RamS?=
 =?us-ascii?Q?+S3x7nwe+HOK4O8909uKVjDqIJaUUa0GMpTiCnUY0/B2gAZv1FPrYOl9fpZ6?=
 =?us-ascii?Q?jbMntgnuSiQxdct1hFoSEzqgkNVRUBdo9UyyRFai0jYAmn0q8kv/Zg3to4gc?=
 =?us-ascii?Q?fqXgc0HMVM1ZeqwS5IeTsh+8DUSQeSreLTqlkq9Ar5jkW7vvuEQE20og8t6E?=
 =?us-ascii?Q?C+HPT86riq7GuAZMNhZvHvktbcQpcZgxeAGS09O4O6QWN34Y+jBaSQn1XqxS?=
 =?us-ascii?Q?cFLdjfIoiiHwn7rcb9nZnwihkxNWVXTYZ9baBHQAMWVo0ZzcMtsu0Ul3tYeE?=
 =?us-ascii?Q?bSL4Li9+wAntgQ33ZUQilGTUJT9ShS/gBlKRmaCwlqoGx4nhlUMPmj6cGKLZ?=
 =?us-ascii?Q?+XoDvNcX0UG1TDG0Uj2W9PpOQP6YL6oi4yXkvm2p9uYSZXNk+fLoE4fVuJd2?=
 =?us-ascii?Q?F9P3TpMzq+jC0yBcEVhhsRd53Cybg9zIy5zMglUAVNPz9mk/qPH1X/UtzSLc?=
 =?us-ascii?Q?y6oQT/r8BUuHVlfa4/9Vh9ZIGxk5nd5KnrUHJC9FzSJKykGjJ6BdLCNhJScq?=
 =?us-ascii?Q?PtPz86c+D/iQf0IPwpYs8k+GtZy2Q1ObA49ZFNXFN4Kw+r0uKU4hJD/hwSLE?=
 =?us-ascii?Q?I3FF5FRBHDr1sAoCdJojyolnZUqnR6VV+9ZtU/fVR1YgalGq9ar+BEIuqKSq?=
 =?us-ascii?Q?Yy9JrrvHL6n0FhkuCcX8IV9fgf9ObN+pt33KivFLWkPDF+BL2CId/rEFsRbo?=
 =?us-ascii?Q?R+MqIEKQH1HgLyhOgoPjFGY8+l2Db11KoNzNDiH14EuTDgH7VqtNXNskXcOt?=
 =?us-ascii?Q?BXR0E8mhkjYbot7inI7F8RB9390QTKs0x+VYR0lEcRH0QH51gO9zQ5oMAjm3?=
 =?us-ascii?Q?bGmi8lu/kxMHTuSbj94foRBR+PdvnBmF3e+Wl54eMQ8reoqgPIQ/P6/Y+sC+?=
 =?us-ascii?Q?jweBgGtjNDnmcy3wirA/5Sj5Y8XIFtrMVRGkCvKodZVe+3vM5JdPb8VafV7A?=
 =?us-ascii?Q?WlsTkv4/XCrqNOpMmH5+EDhkFNUE2Age36u9Vfo5bNdT79ag7XMSuVQi9qOP?=
 =?us-ascii?Q?XnDlf480qzBXjRquYYTA?=
Content-Type: multipart/alternative;
 boundary="_000_SY8P300MB02825DF878585DDC68EB088CE06C2SY8P300MB0282AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0282.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5b4a7b-79a6-4e34-d1ef-08dcd928eb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 04:01:35.0379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0571
Received-SPF: pass client-ip=2a01:111:f403:2818::81a;
 envelope-from=swung0x48@outlook.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Sep 2024 00:44:48 -0400
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

--_000_SY8P300MB02825DF878585DDC68EB088CE06C2SY8P300MB0282AUSP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey everyone! Late to the party. Life happens sometimes ;)
Just discovered this patch and this mail list, and I'd like to provide some=
 background story here.
<https://github.com/plctlab/plct-qemu/tree/plct-riscv-backend-rvv>I origina=
lly provided my initial implementation in a downstream repo last year, name=
ly https://github.com/plctlab/plct-qemu/tree/plct-riscv-backend-rvv .
I'm new to contributing to qemu and also take part in the open-source commu=
nity upstreaming process as a whole, so I may make mistakes in my following=
 claims, but I see some confusion here:
1. The PLCT branch (which includes my original commits) is open-sourced usi=
ng GPLv2, which follows QEMU's upstream repo. So according to the license, =
my modification should be EXPLICITLY shown in the patch, but I haven't seen=
 any.
2. I do consent upstreaming my patch last year, in the form of a patch subm=
itted with modifications from T-head, and on behalf of them. And it was agr=
eed back in the days that I can be mentioned as one of the authors. But it =
turns out that there's no "sign-off", "author", "co-author" line mentioning=
 me. If I don't speak out in this situation, does it imply that this patch =
is purely LIU Zhiwei's work and have nothing to do with me?

I'd like LIU to separate my patch and his modification to two separate patc=
hes, and explicitly name where are those patches coming from, so that this =
patch can comply to GPLv2 license and can we clarify those misunderstanding=
s.

I don't want to take it personally , but I do smell something's wrong going=
 on here...

Best Regards,
Swung0x48 (aka. Huang Shiyuan)

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Richard Henderson <richard.henderson@linaro.org>
Sent: Wednesday, September 18, 2024 10:27:16 PM
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>; qemu-devel@nongnu.org <qemu-=
devel@nongnu.org>
Cc: qemu-riscv@nongnu.org <qemu-riscv@nongnu.org>; palmer@dabbelt.com <palm=
er@dabbelt.com>; alistair.francis@wdc.com <alistair.francis@wdc.com>; dbarb=
oza@ventanamicro.com <dbarboza@ventanamicro.com>; liwei1518@gmail.com <liwe=
i1518@gmail.com>; bmeng.cn@gmail.com <bmeng.cn@gmail.com>; Swung0x48 <swung=
0x48@outlook.com>; TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vector

On 9/18/24 12:43, LIU Zhiwei wrote:
>
> On 2024/9/18 18:11, Richard Henderson wrote:
>> On 9/18/24 07:17, LIU Zhiwei wrote:
>>>
>>> On 2024/9/12 2:41, Richard Henderson wrote:
>>>> On 9/11/24 06:26, LIU Zhiwei wrote:
>>>>> From: Swung0x48<swung0x48@outlook.com>
>>>>>
>>>>> The RISC-V vector instruction set utilizes the LMUL field to group
>>>>> multiple registers, enabling variable-length vector registers. This
>>>>> implementation uses only the first register number of each group whil=
e
>>>>> reserving the other register numbers within the group.
>>>>>
>>>>> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
>>>>> host runtime needs to adjust LMUL based on the type to use different
>>>>> register groups.
>>>>>
>>>>> This presents challenges for TCG's register allocation. Currently, we
>>>>> avoid modifying the register allocation part of TCG and only expose t=
he
>>>>> minimum number of vector registers.
>>>>>
>>>>> For example, when the host vlen is 64 bits and type is TCG_TYPE_V256,=
 with
>>>>> LMUL equal to 4, we use 4 vector registers as one register group. We =
can
>>>>> use a maximum of 8 register groups, but the V0 register number is res=
erved
>>>>> as a mask register, so we can effectively use at most 7 register grou=
ps.
>>>>> Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers a=
re
>>>>> forced to be used. This is because TCG cannot yet dynamically constra=
in
>>>>> registers with type; likewise, when the host vlen is 128 bits and
>>>>> TCG_TYPE_V256, we can use at most 15 registers.
>>>>>
>>>>> There is not much pressure on vector register allocation in TCG now, =
so
>>>>> using 7 registers is feasible and will not have a major impact on cod=
e
>>>>> generation.
>>>>>
>>>>> This patch:
>>>>> 1. Reserves vector register 0 for use as a mask register.
>>>>> 2. When using register groups, reserves the additional registers with=
in
>>>>>     each group.
>>>>>
>>>>> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>>>>> Co-authored-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>>>>
>>>> If there is a co-author, there should be another Signed-off-by.
>>>
>>> This patch has added a tag:
>>>
>>> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
>>>
>>>
>>> Do you mean we should add the same tag twice?
>>
>> The from line is "Swung0x48 <swung0x48@outlook.com>".
>> If this is an alternate email for TANG Tiancheng,
>
> No, Swung0x48 is another author.

Then we need a proper Signed-off-by line from that author.


r~

--_000_SY8P300MB02825DF878585DDC68EB088CE06C2SY8P300MB0282AUSP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto">Hey ever<span>yone! Late to the&nbsp;<span>party. Life ha=
ppens sometimes ;)</span></span></div>
<div dir=3D"auto"><span><span>Just discovered this patch and this mail list=
, and I'd like to provide some back<span>ground story here.</span></span></=
span></div>
<div dir=3D"auto"><a rel=3D"noreferrer noopener" href=3D"https://github.com=
/plctlab/plct-qemu/tree/plct-riscv-backend-rvv"></a>I originally provided m=
y initial implementation in a downstream repo last year, namely&nbsp;<a rel=
=3D"noreferrer noopener" href=3D"https://github.com/plctlab/plct-qemu/tree/=
plct-riscv-backend-rvv" style=3D"font-family: sans-serif; font-size: medium=
; font-style: normal; font-variant-ligatures: normal; font-variant-caps: no=
rmal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: sta=
rt; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; white-space: normal; color: rgb(0, 120, 212)=
; background-color: rgb(255, 255, 255);">https://github.com/plctlab/plct-qe=
mu/tree/plct-riscv-backend-rvv</a>&nbsp;.</div>
<div dir=3D"auto">I'm new to contributing to qemu and also take part in the=
 open-source community upstreaming process as a whole, so I may make mistak=
es in my following claims, but I see some confusion here:</div>
<div dir=3D"auto">1. The PLCT branch (which includes my original commits) i=
s open-sourced using GPLv2, which follows QEMU's upstream repo. So acc<span=
>ording to the license, my modification should be EXPLICITLY shown in the p=
atch, but I haven't seen any.</span></div>
<div dir=3D"auto"><span>2. I do consent upstreaming my patch last year, in =
the form of a patch submitted with modifications from T-head, and on behalf=
 of them. And it was agreed back in the days that I can be mentioned as one=
 of the authors. But it turns<span>
 out that there's no &quot;sign-off&quot;, &quot;author&quot;, &quot;co-aut=
hor&quot; line mentioning me. If I don't speak out in this situ<span>ation,=
 does it imply that this patch is purely LIU Zhiwei's work and have nothing=
 to&nbsp;<span>do with me?</span></span></span></span></div>
<div dir=3D"auto"><span><span><span><span><br>
</span></span></span></span></div>
<div dir=3D"auto"><span><span><span><span>I'd like LIU to separate my patch=
 and his modifi<span>cation to two separate patches, and explicitly name wh=
ere are tho<span>se patches com<span>ing from, so that this patch can compl=
y to GPLv2 license and can we clarify
 those misun<span>derstandings.</span></span></span></span></span></span></=
span></span></div>
<div dir=3D"auto"><span><span><span><span><br>
</span></span></span></span></div>
<div dir=3D"auto"><span><span><span><span>I don't want to take it&nbsp;<spa=
n>personally , but I do smell something's wrong going on here...</span></sp=
an></span></span></span></div>
<div dir=3D"auto"><span><span><span><span><span><br>
</span></span></span></span></span></div>
<div dir=3D"auto"><span><span><span><span><span>Best Rega<span>rds,</span><=
/span></span></span></span></span></div>
<div dir=3D"auto"><span><span><span><span><span><span>Swung0x48 (aka. Huang=
 Shiyuan)</span></span></span></span></span></span></div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Get <a href=3D"https:/=
/aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Richard Henderson &lt=
;richard.henderson@linaro.org&gt;<br>
<b>Sent:</b> Wednesday, September 18, 2024 10:27:16 PM<br>
<b>To:</b> LIU Zhiwei &lt;zhiwei_liu@linux.alibaba.com&gt;; qemu-devel@nong=
nu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> qemu-riscv@nongnu.org &lt;qemu-riscv@nongnu.org&gt;; palmer@dabb=
elt.com &lt;palmer@dabbelt.com&gt;; alistair.francis@wdc.com &lt;alistair.f=
rancis@wdc.com&gt;; dbarboza@ventanamicro.com &lt;dbarboza@ventanamicro.com=
&gt;; liwei1518@gmail.com &lt;liwei1518@gmail.com&gt;; bmeng.cn@gmail.com
 &lt;bmeng.cn@gmail.com&gt;; Swung0x48 &lt;swung0x48@outlook.com&gt;; TANG =
Tiancheng &lt;tangtiancheng.ttc@alibaba-inc.com&gt;<br>
<b>Subject:</b> Re: [PATCH v4 02/12] tcg/riscv: Add basic support for vecto=
r</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 9/18/24 12:43, LIU Zhiwei wrote:<br>
&gt; <br>
&gt; On 2024/9/18 18:11, Richard Henderson wrote:<br>
&gt;&gt; On 9/18/24 07:17, LIU Zhiwei wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2024/9/12 2:41, Richard Henderson wrote:<br>
&gt;&gt;&gt;&gt; On 9/11/24 06:26, LIU Zhiwei wrote:<br>
&gt;&gt;&gt;&gt;&gt; From: Swung0x48&lt;swung0x48@outlook.com&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; The RISC-V vector instruction set utilizes the LMUL fi=
eld to group<br>
&gt;&gt;&gt;&gt;&gt; multiple registers, enabling variable-length vector re=
gisters. This<br>
&gt;&gt;&gt;&gt;&gt; implementation uses only the first register number of =
each group while<br>
&gt;&gt;&gt;&gt;&gt; reserving the other register numbers within the group.=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128=
/256), and the<br>
&gt;&gt;&gt;&gt;&gt; host runtime needs to adjust LMUL based on the type to=
 use different<br>
&gt;&gt;&gt;&gt;&gt; register groups.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This presents challenges for TCG's register allocation=
. Currently, we<br>
&gt;&gt;&gt;&gt;&gt; avoid modifying the register allocation part of TCG an=
d only expose the<br>
&gt;&gt;&gt;&gt;&gt; minimum number of vector registers.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; For example, when the host vlen is 64 bits and type is=
 TCG_TYPE_V256, with<br>
&gt;&gt;&gt;&gt;&gt; LMUL equal to 4, we use 4 vector registers as one regi=
ster group. We can<br>
&gt;&gt;&gt;&gt;&gt; use a maximum of 8 register groups, but the V0 registe=
r number is reserved<br>
&gt;&gt;&gt;&gt;&gt; as a mask register, so we can effectively use at most =
7 register groups.<br>
&gt;&gt;&gt;&gt;&gt; Moreover, when type is smaller than TCG_TYPE_V256, onl=
y 7 registers are<br>
&gt;&gt;&gt;&gt;&gt; forced to be used. This is because TCG cannot yet dyna=
mically constrain<br>
&gt;&gt;&gt;&gt;&gt; registers with type; likewise, when the host vlen is 1=
28 bits and<br>
&gt;&gt;&gt;&gt;&gt; TCG_TYPE_V256, we can use at most 15 registers.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; There is not much pressure on vector register allocati=
on in TCG now, so<br>
&gt;&gt;&gt;&gt;&gt; using 7 registers is feasible and will not have a majo=
r impact on code<br>
&gt;&gt;&gt;&gt;&gt; generation.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This patch:<br>
&gt;&gt;&gt;&gt;&gt; 1. Reserves vector register 0 for use as a mask regist=
er.<br>
&gt;&gt;&gt;&gt;&gt; 2. When using register groups, reserves the additional=
 registers within<br>
&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; each group.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: TANG Tiancheng&lt;tangtiancheng.ttc@ali=
baba-inc.com&gt;<br>
&gt;&gt;&gt;&gt;&gt; Co-authored-by: TANG Tiancheng&lt;tangtiancheng.ttc@al=
ibaba-inc.com&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If there is a co-author, there should be another Signed-of=
f-by.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch has added a tag:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: TANG Tiancheng&lt;tangtiancheng.ttc@alibaba-inc=
.com&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do you mean we should add the same tag twice?<br>
&gt;&gt;<br>
&gt;&gt; The from line is &quot;Swung0x48 &lt;swung0x48@outlook.com&gt;&quo=
t;.<br>
&gt;&gt; If this is an alternate email for TANG Tiancheng,<br>
&gt; <br>
&gt; No, Swung0x48 is another author.<br>
<br>
Then we need a proper Signed-off-by line from that author.<br>
<br>
<br>
r~<br>
</div>
</span></font></div>
</body>
</html>

--_000_SY8P300MB02825DF878585DDC68EB088CE06C2SY8P300MB0282AUSP_--

