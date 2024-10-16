Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF1D206A0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 06:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0xrt-0004bx-UR; Wed, 16 Oct 2024 02:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0xrs-0004bp-Nk
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:50:48 -0400
Received: from mail-sy4aus01olkn20814.outbound.protection.outlook.com
 ([2a01:111:f403:2819::814]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0xrr-0001ca-8T
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+Wb+jh3OWcPlsSjbO9KKujT3zSzX+I4wgEvNz/8yHiyA2ZLzImu2M4A7rnZ2ejLg1G5RxXN7Je/fHLxvyu19YoTPBCQpab0dL86Rz+lFNqTSplcYfvfhlHOunD9HaLoWOxzJBJBHyQOzeQtxRq0CAkcSNGK4uo1RWL0CpUODyY7sIMrh/qAHRIY9nQFYd3ex1BoP00Pi18Xcvz8ls62vhqJfz8A7jk/MXUEhzJeAd1nepe0pOuRps4v7HPQrNQJ7phKty8veKOmsTYiFY/vxQfTpgWgNX8Tem4A1KFxwIEHWG5MB3Lehox374tCRKKwb9NeFSfhbnPlYWi4ZWkrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYJbb3ErlLMTZeiN6tRiy6/ewCosD3+NRC17TFUgLWo=;
 b=KSTOVUqHQD7iSIFuGaL2QYjBbG+IxF7uQxCcmzxxgEETlrFDZdkGiGKiVLemUFzN5Sl0RzT9cVL3p4XNAjz0RYJP7EZJTwITi2A37bmG2zxCxQoV+v3QaXFDUTKY/DJwMVXeykBbRzkFGxL0KznM4nGCBQjMMew7vYPfdxd/QH6jEXKQ1yXbD6T0NprLYGGh5ZbWbfoUslqvuidP6AXN/M954D1+Jiz0/P78T1AlU5burqmbsJxMcKnMC0bgKT7AydesMfVVGdku7U/rqvSTQAfxp8bJ1FBJtjVkENutPbaXiYLS7niPGNO/aA6PjDOvg1CGTI2RtIGjngmR8cAC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYJbb3ErlLMTZeiN6tRiy6/ewCosD3+NRC17TFUgLWo=;
 b=f4QWf+q6m4RMjfmxHSiu74JyrEVnZjHi+IsWXyfSvKMIHoS24xKOojvscXn+sZ911GjE5EUy30IWVjZy+brO4CJ7VnNtgPQcc+7pDrTYUILQl9X2fdyk+sCJJSHREheUtpeGnszwPXwBpWxi7PO23Oi2x7RTeZMUT/+kAnE7fPd6/QszzTA8PDndfMNf8jCrjvEx40IDkqLd8D4BC9KbZgqlQK06AwYOsE9qnnPbVFl/ICoVTMTRrEe+XHfgzoIeyebdnli5a8Gri9jPQ32PazdQjHwuhG+E5CE7+XzaK+R0/5Hx2Tmm2nE8+XK6eYkdAwB9MHOL9BU0NK1S8mGlBA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0740.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:230::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 06:50:41 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 06:50:41 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-3-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/16] meson: remove repeated search for rust_root_crate.sh
Date: Wed, 16 Oct 2024 14:50:09 +0800
In-reply-to: <20241015131735.518771-3-pbonzini@redhat.com>
Message-ID: <SY0P300MB102634560EAA27EB7973406695462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::24) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <875xpsr16w.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0740:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f3af68-0184-443d-d4bc-08dcedaed9c7
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799003|7092599003|5072599009|15080799006|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: rcrjcQaWY40GdzvhqbrgBaqeBl6LLgrYsUwKoLgk4yruQ5ettC1jTbrnPXl5GekoXlmlZ/nDajiIYKD721QrlOEigzGE+wXNAOpUfNhyhKHrdT6RIrJolnuYAUCH3zmr3zW/CpCB45SWZRWHHWehLx/63ecwyO339WOxGStvQPcKPu0qa7ZFyH25J1ix0i1InBe5pljcy/8AZROiNm794+RreyT4g4vnB9tXN09MITXHEXMoJOhzGYNihwYVS8tBFrWEZOrnZ9S0gVTP65Xkn+FIq9zYsF699kVVlAkN4Q+RRTqapaoOQ21ZxXojBhdsB5ZzP+U6f6l4Db28pGBLjUKmuibnvOKkaihoqxkaduysbNrSkoLbFOX72XgWAHioWkph3StNe/NGHH9Vhn9i1HV3VTuYmEbEf49gXhHpQQ2BvG4EJTDA8pt3c+s+1I/Zp5kCJnOhJZKU96Yu85sgVbj/dNDsNIMYHuCd63TqaInvK0fr4xN9HvomBrkBaEIs4UGAg+QqBalarsnhI14aoi5DDTMO+P+TX/8Vv5wPivEbTp8J5rwt/T0A8IqZ14VgoK85trngfi5c/3sLpHw5JpqaxwDycGcXnPTQjkvJKVX94FKctd8FzEDsn3QJxXNd439zcefDBGNpbbw7UpcDiG+AaoFh0Z8W8W/4GKkH6lxTTBUiekUueoqYuMtQR0azfQ40FmhB/FQ4UZO+dCFamV2zDKd0cpFp4kYcPAlSZv4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8Zuug2VrN6Bd4g4LiCmsukLu6A+Pn70eFvPWsuQl7jvgAUlmQPBriG1molx?=
 =?us-ascii?Q?0GjXESpSosLV4F1V68PMcMo+DgRwdEhBPdWcT5eItgXf0TGEjMaGwuuntvDA?=
 =?us-ascii?Q?NzK7HrNy1FSHvtzjoTFjnsNyUXkNAsW82atCeX3Iw7VXU3kEI9sXN1cQ4Euo?=
 =?us-ascii?Q?OwBnYd4yyZvkyK/N2KOZeJ469r9UjLhui8+0rEQyahlFjlxuozBEXFn4IbFV?=
 =?us-ascii?Q?VZw3zsdVusfU3i3LYPZvGRImW+Lr/AZfFC/FfWNIZZ+l5aLofpZImpCbsSSx?=
 =?us-ascii?Q?DCEbEaH9rCtjLwP1Lr1VXuEsbE8Ddyjpa5hy2X0yylyoGQCvV+DvnJ9cDO1g?=
 =?us-ascii?Q?4S0Jzo5ditcLVYW9l/Ct1MT2fH4HjlRs5L+wsMx2/if5Q103yIXnIwQZFdwx?=
 =?us-ascii?Q?jbB8aPsb5mOitGeeetUslb/bGmu89EeQHlHo4602uFRntCJ97vafhktZOkcU?=
 =?us-ascii?Q?K46cCWyGL3S4jBDahHSpDBtO2r28GAO23bXQ7V41qBrpgvc5+TQWzMmksqhZ?=
 =?us-ascii?Q?sT8c5CpgpWoMlIW75Rs9VmCWbteuzijN0tTKOjWz/n42VHo8OR74hgHQI018?=
 =?us-ascii?Q?z9dViDxtyh+q91YKSY9ECuS/BSelp0j6hmYNT1pc54mGGlEHhpCS1t8duiv2?=
 =?us-ascii?Q?O3VoncXdA9lypnhfdwzMfNJo0Fh2g+bNLNvuzBokDNRWLj8nW/YQnVh8Y3AE?=
 =?us-ascii?Q?WTvtB5JCai9p0RuyyGZxP10ugui/sodCu/QOgBhyK+sFk+Vd8OZLcF1EeYQb?=
 =?us-ascii?Q?cWvsf5d9M5U8DNSAZcR+qr2DQiaUdlHHweJT0qkQjXtxxTZWRXdow1SBk/mu?=
 =?us-ascii?Q?Ez4ni03AIPXLjjGwIYSR3eA+KZDWs/k3xi8fofOFkW/01pgwnNYWxVVNUxo3?=
 =?us-ascii?Q?seEXA3cP/2ptIgl9VnKBBuURJygb6zrAysAPfYn9JWhn+EK7QFRk94a8AGmV?=
 =?us-ascii?Q?Isrr+C8kmx41QU4D/6TOmGmjc85hzEoib9BXadiTLAKBHiLd+d3Ue0HOXaEz?=
 =?us-ascii?Q?T7ETYX8XXcfuH2U/6Cbys+W6ZpNDIEvR7mIM063TXXDb9/Tqdo02QSk1ZOFY?=
 =?us-ascii?Q?83VUH93/SMWIpLGXnm+BARamZ+URZW3T/m4J0HB5PJ4rcErHajFM6lwhbGeh?=
 =?us-ascii?Q?l66Ug7M8+/vKARtaDao4xBWSSHCYuEdCbNLS/qFYEqj0V51DeCsUkXMGWlmK?=
 =?us-ascii?Q?LfPUuPjabUzfXSgpKNHEXaxLpVgjTmfHRYCf7oY0wrn4JTZ4+yYjkuPFEj4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f3af68-0184-443d-d4bc-08dcedaed9c7
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:50:41.5637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0740
Received-SPF: pass client-ip=2a01:111:f403:2819::814;
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Avoid repeated lines of the form
>
> Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/upstream/qemu/scripts/rust/rust_root_crate.sh)
>
> in the meson logs.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

Thanks for cleaning this up!

--
Best Regards
Junjie Mao

