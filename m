Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56B0D3C544
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1dEJ-000785-NR; Thu, 17 Oct 2024 23:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t1dEI-00077v-FR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 23:00:42 -0400
Received: from mail-sy4aus01olkn20817.outbound.protection.outlook.com
 ([2a01:111:f403:2819::817]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t1dEF-0000Xg-W2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 23:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZpz2rznh32+3kXdinVh9Z+lJSFFmzM1Q+8JfvdUD/hjbQNounDSOsB1xSzbwMOeyLzEzRfQmF/C1b5N4IgFo27YF08VdidWkqX93ZSxdC9ZMTGY+3rX9i2XPIq5wjfkogbcvqfBnUsgfUGR+cZys4DhIJ9Q9//InXMcMhlcZ0RtgxtEyTK52fkRZawBhfBXcASWafxEGEuJ6lO1pxCpUOc6vNIbfjiMgZAxEGSfTMsI+mA+wAbNmKnWcULNxq4iVDufEnUWIFSthDvAKuQwxCJ+qkTiH+j9/FD25aBmkNPo+w/Qgia99bQWeb5KQAV2H2yz9/vjN6ydi26NKzSFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgRTJ4XMEdPwWt4n0iJPlWwydO0YkVfuJ3ObH45b7v0=;
 b=Jac+Awhh1arHTj2tDOTRHgqxdhzGh6v6/Y74HWlUGAVzFtEhvkhnGdcLRnmlCE6Pi7RyLxdX5Mww//TfkIBJH7/ilHTgf5ctdfixwFc4pKM5d6ne+wdf/siiSp56Fpd/UnFN+H/Y6vfxr8M2FTPEoDzlBtIcEnm9KH5ZZXOJYdA8rSqvZGiGDk6BWPbgI97ldGt81GTcSYF2P5chHDffS2jOcZaqqXuOeTULD5xAqmYy4LezlUg6PSsnBM9gDeRsEcF3oSP7FMT13X+eBs/fwtYxG2M0r+w8o7SxW8apMYDzAHZ1jucDBmRBCq07nbGO/D8vqLSHvtMEspq0AzNmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgRTJ4XMEdPwWt4n0iJPlWwydO0YkVfuJ3ObH45b7v0=;
 b=LmPt7QIwiJQNgJm3F4PGW2CZBQ4MirXKTWSQ6F2dFgCldcqjHsmG5po/BD0f7+qgDiT7ci4isLlwMR2/onarEb4cHmiWx/JpyoJ6lP4Pswq3lmSZWBB/zWYzTnMORbOtyaVatHCyMvKxntQI8MLM+Eohm+DQ4ddwvy6u+R6n/yBtkQPqdTIVBd4GIT5SAoYr8ZoLke977p8PB02GZPcay6lcE1iiWo0WJH4CpnxCBYdX05oWLVaHriIQFW9quyiziTrA8S2xOzVaACyMLmWKUbzvmJMLTxTOOUUMPX/yOd1IUjEeAmA2uRjxM/48sP6xKS2YDhooA6acriTa50fXVg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0055.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 03:00:33 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 03:00:33 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-13-pbonzini@redhat.com>
 <SY0P300MB102670D06E55A6B463CD1BDA95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbqhmr=45c9ZiYoDAanM7Gsinz4RnwGMrivYDQgzP8kTw@mail.gmail.com>
 <SY0P300MB10269110D64F40C0F5AF0E7595462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 12/16] rust: allow version 1.63.0 of rustc
Date: Fri, 18 Oct 2024 10:44:41 +0800
In-reply-to: <SY0P300MB10269110D64F40C0F5AF0E7595462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Message-ID: <SY0P300MB1026A5E47899229BA3F559F595402@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0033.apcprd04.prod.outlook.com
 (2603:1096:820:e::20) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87jze6m7y1.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0055:EE_
X-MS-Office365-Filtering-Correlation-Id: b69bd719-db1f-4d87-91bb-08dcef21085c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|5072599009|8060799006|461199028|19110799003|1602099012|10035399004|3412199025|440099028|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info: TekBbxQWPy1LuZ2LyWQw3vYNTsTtegAj2Lt0LTTY3lcLvT9uLWTSX+W4uKFx+AM/tTpxOQcsC1ziWsjEks+ww10yBQN/15tS2sE32BpZSH8am1e0KdtbuMIlO2TcWI8Ca/NvhK3CXe2pXd4gCGX8fdXJVuBAHhTNzAbEMzelKrGrK3QioPRIBM14UokViOXn/GQP6bBCJ2Yp/WW3zKWdCSfJPaVxQtL6vfvxcnk1gz5Gro3OCfgLNzj+co0qxCEtq2deD95lJ33fVBmErk+axhhAgML27ESuJDkptyQ9y0Ec1k04ICbcxWdtzqIc1fd7BZ8jCbQFgTGEqZuvgGC0SUQUpx8oRD/mLkyr1CzX3lcQk37dVVlNb812qQs8y5FX5eaIZgAHBEiJ3CIpzb/VMOmu1iSE+6E/FBXti2lyQVUoeBCNeiRWEi4W2sKGXImGEfGy6oGmxYLri1OuALvsx/5ngNfl36v2E8r1VNVr+vrN8jYDyxDNREWR3lIS/VzBRB603oNGKGtGQgsCWCcm8Y00YBTkebLEcAc0WnKJu4xYmhKOMyfJK2oI8cjzKzoFHZAFUVaTSGWY0mXw4u6KeNpfIwecimrDV6W5hDgZvnA440WK/J70joHkEg+E2WSrMeUAPgQkpcOTSwVo1xGTq8uRdLT0DmN5f8x9H2UK795jQzudEl3EevlYJhxVPcneIFyoP2tAYb1y3mUkNroONWx5XfPYX0yoBQORlqvrbyMYvX1XUNc78goj1BJ2DAdLGv71wJHvGABqq6Y8g6djMKIxmG1W8QK0oyTTBf4GhndMi8GVhBuUOZAEsTVcU/Uv65Qfy53QrAkK0t95Sa8Zbc55GHTNNt7RQRRsozsBk3LsX1L0OULURysOHZ7J2OxNQohu8E2wImDQDO66rxVJDQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4PoQA8+6aDxmQzUEtx6Bb734SD3vR49zvVqAZ+A5x5fB/gUoiR5KRrbcsbkL?=
 =?us-ascii?Q?FihDZ6AO01kd5LqzlRiT1wZwzVgNzwzSsGxvIoIPfRboCNkIZXTOLuOD7U1E?=
 =?us-ascii?Q?VYmlpl6k5JwNTKefX6hBxigDmPw3pfypuo5mB7VZlKNZbYRIwXHsCGCo0mhq?=
 =?us-ascii?Q?aNne6zNasFeu42fABihN6oID01HeuTZo01HgUxncrFaH/5LlkL9gCKX221mo?=
 =?us-ascii?Q?L2RBj/+UThLxgQDUA+3z2jJow+ccaxuAIIIAgY90Jl9plBBo46xFzOgCYLm5?=
 =?us-ascii?Q?4Ag9mvMDiqOyNpcLEL6OetQDAT4bgYTgbEPQ1nOF9fG8nKKJMLME9t6gACrT?=
 =?us-ascii?Q?7Yg2TgoVxYlenNaHhuWg4Brw+h4uPiocuEGlli85e4Ev8r+Wt74Wq3LGYAqx?=
 =?us-ascii?Q?UyDNBa633F69/s4fslc0VlxslPUj9uPbgWja7HvW6ZmTd69gA25TmkTyB6lt?=
 =?us-ascii?Q?xeWIouEKvtwDZKL4gIXY7yCp4yA4rZVbMZF5GzEpEIS9zc6shRVT4SpgiGek?=
 =?us-ascii?Q?xs6oHxatNsPo/Y+WZiL4FvNKja6bLYxZZ19aQgD0VncRe4ZbM/89j9bH9WDi?=
 =?us-ascii?Q?FFUvnLs6SGAm4mHY3K1EcJrwnkHhE8pdS2fHlIVmOQ122lkfbepK5c/R9cEY?=
 =?us-ascii?Q?X8+ViCg5WFbHh51aloeInZYceDDkhdLfiP106WKGKl+o+Hs7gOAV/l8HdoK9?=
 =?us-ascii?Q?6K7P/1ClrHkyCc6y8D/5/Lgpk43ucPbN0t3ioTKGFaD/vfVrZA9VDTD9dQ1Q?=
 =?us-ascii?Q?OpnELe0xjWwz1IEtyFAmcgbRINIh6qo00k7GIto0L4T9uMu5JOrfFRf1ia8d?=
 =?us-ascii?Q?eqCKk8kEFxkcMVtq2fPGKt19Lamlq2BaODC9hHtHxifdpg+ufck/BCOFX2eY?=
 =?us-ascii?Q?gdBV8EmK3rg9s5ajAxifX5+EmFKydz6DvsjE0DXzHmU9+FDHWZVzdI3F1spr?=
 =?us-ascii?Q?Gg+3l9Mzok9Ai2FPcMU2FLnunAHUYjEP9W9ag4Z7Qfv8n6eksrgN8dt/rnvJ?=
 =?us-ascii?Q?1Qh6FJYym9gB323D/4lR1JGwNqE8YOqYVvai+hTMLwnk5QRAZoONXrV/s8dU?=
 =?us-ascii?Q?U/VrMl9OR0gmr5CbNnSFfcpzgcc9AN0CkUc/PwSgLllvOkNXo4gcJoG5VgMy?=
 =?us-ascii?Q?LQIPiexDTc228JcqyWdCqaZXYC8SsDqAWpDuJVStpnr7B+mZfXdWPDGWXKxu?=
 =?us-ascii?Q?1FyNC+3TtqbFJj8FFwRwvPzz7eXWZASUEuovXbgoG2Zpq3+9asAPOHzyKqc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b69bd719-db1f-4d87-91bb-08dcef21085c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:00:33.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0055
Received-SPF: pass client-ip=2a01:111:f403:2819::817;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Junjie Mao <junjie.mao@hotmail.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> Il mer 16 ott 2024, 08:10 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>>
>>  In my Ubuntu 22.04 environment (rustc 1.76.0 and bindgen 0.59.1 from
>>  apt) the feature `proc_macro_byte_character` is not yet stablized but
>>  used in proc-macro2. Downgrading proc-macro2 to 1.0.79 [1] and syn to
>>  2.0.58 fixes that issue for me.
>>
>> This is handled by patch 5. Try "meson subprojects update --reset".
>>
>
> Yes, that works. Thanks for the info!

After cleaning everything to build from scratch, I met another issue:

  bilge-0.2-rs| Downloading bilge-impl-0.2-rs source from https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
  Download size: 24524
  Downloading: ..........
  bilge-0.2-rs| Applying diff file "bilge-impl-1.63.0.patch"
  bilge-0.2-rs| patching file src/shared/discriminant_assigner.rs
  bilge-0.2-rs| Hunk #1 FAILED at 26 (different line endings).
  bilge-0.2-rs| 1 out of 1 hunk FAILED -- saving rejects to file src/shared/discriminant_assigner.rs.rej
  bilge-0.2-rs| patching file src/shared/fallback.rs
  bilge-0.2-rs| Hunk #1 FAILED at 22 (different line endings).
  bilge-0.2-rs| 1 out of 1 hunk FAILED -- saving rejects to file src/shared/fallback.rs.rej

  ../subprojects/bilge-0.2.0/meson.build:9:0: ERROR: Failed to apply diff file "bilge-impl-1.63.0.patch"

It turns out that the sources in bilge-impl have CRLF line endings and
`patch` does not ignore that even with the `-l` option:

  ~/Projects/qemu/subprojects$ tar xf packagecache/bilge-impl-0.2.0.tar.gz
  ~/Projects/qemu/subprojects$ cd bilge-impl-0.2.0/
  ~/Projects/qemu/subprojects/bilge-impl-0.2.0$ patch -l -f -p1 -i ../packagefiles/bilge-impl-1.63.0.patch
  patching file src/shared/discriminant_assigner.rs
  Hunk #1 FAILED at 26 (different line endings).
  1 out of 1 hunk FAILED -- saving rejects to file src/shared/discriminant_assigner.rs.rej
  patching file src/shared/fallback.rs
  Hunk #1 FAILED at 22 (different line endings).
  1 out of 1 hunk FAILED -- saving rejects to file src/shared/fallback.rs.rej
  ~/Projects/qemu/subprojects/bilge-impl-0.2.0$ file src/shared/discriminant_assigner.rs
  src/shared/discriminant_assigner.rs: ASCII text, with CRLF line terminators

Meson uses patch with the command above as the first preference to apply
diffs. That command is not yet customizable.

--
Best Regards
Junjie Mao

