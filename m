Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BD1D0E6FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2quF-0003qr-3I; Mon, 21 Oct 2024 07:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2quD-0003ne-C1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:49:01 -0400
Received: from mail-sy4aus01olkn2082e.outbound.protection.outlook.com
 ([2a01:111:f403:2819::82e]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2quC-0002pe-0U
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdWAGPTLGauHbPhc2lzgHm7SKhJjGQy/SdOdHFc7sUq4lI780xgvqIPaPUB8BWJDAjzItdCVmTxGHPbObBWOE7VSkEgi+AdWqRHPdPWazAzkxFibkxcAP84YIrcqFzr5+eV8nftlis9MJ053ZQBqShdZ1BrFYwLa8iiO2kwGF1vRR1R7Wp08DcK2VSl4VuSFpphrEuJY8jjnHqDjoWvhF4YWsv2hKEScgi+3v+VqNdt7xZ6au3OwpTF5fmKauwPblHROl3OM0erHi/oVBIIs7JNWLIYyVPoaDNEC+jC7UFThukZ3/D8tT3DbskkVAPL7Ll9ekkOKZogXWby5TpPl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=372oQv3nUcElOQClT4qi0lcAQr9+FuBKHtDI0jIQG7w=;
 b=c6Sg/7xqnodi/7bUNssqzQSqg4cYi7G+XnS6LyOle+GsVngLXprFeTw5ZcU6ctM7D5xviLl1QSprE6yx/OkBzeyfg3GNOqiWGv/Qd/WoJsdQ2INQJICQmj+zGWbLdMK0wk1hInrx7rq+sIpZlNMz4EFHa/vbgeWcX49HB5d24fak5fyQUZf/dymR/fyqHiqLTJYDE+s2IegB7mUsmPCJBCyLcc/EuAmuOHfXGME9aYNJDUwzFV2D3WcntzxJBwDfgcHxQbZ30BjkUjlGKBlB1ICbEEFqudk778Ooph/yg3JGFoAxZzno8HGEnon5yFLZeUoyfFWmdo+oeANbQSWI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=372oQv3nUcElOQClT4qi0lcAQr9+FuBKHtDI0jIQG7w=;
 b=qcFurLEwE6nybXG5v2Ol0MrRRyxCTHNvIjr1QtLD3WnMg+EkyM686pdAxsImJLyq1LSx4RKMVqq/MKT8FWAiyqukCRtzoVj2ExsjKTloLJoaLojurZFlApMTDwp3TBi1r7du7tm+zt0yX15SRIxi5m35pfTHeafjxRpSIh0EytFQnxa2U/0KoUMwBtia/rY8eic3pniK2uvAgGwVdIZSPWYjSM5F3nitthLb8ix6QI7kUlmLhbB7Jlnb1/IY6x554rB6R1m0fbx/GKfdg1mGPqKaD/jMeDa5Z4tN1B412LxXrOIqjx1sNvKo4WG/H0LxIyUH35K1GDi9hzaecLBQqA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0171.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 11:48:54 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 11:48:54 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-14-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 13/13] rust: do not use TYPE_CHARDEV unnecessarily
Date: Mon, 21 Oct 2024 19:48:11 +0800
In-reply-to: <20241018144306.954716-14-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026AAD671ABBF2F7139B3F495432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <874j55smlf.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0171:EE_
X-MS-Office365-Filtering-Correlation-Id: 815e9812-b87f-4df2-e053-08dcf1c656c0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|5072599009|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: Hwwfj6FjVwoPsd9KaZgy4/A6hiyjhCk1GYmW/L9sDJo8rFGdMHZ0u3jqrbGM/Ne/aFs9AAvl6WJyuQsKdcSAK/LPhmVRB1NAUEE9wOWhhnghEEDeJJmNxAJci2vm5VXg1ckl2HYCbyldx7vjfaPnJA0LZTam2xD9ksI6Ae7z7BZBpwzAuU2igjjPevqKjAw80g9Fs8hCd22mM14CgD8sQPGa2Csi9KIC8/SwO1aS4lE2EhmMhgo5/xGnl/W/MGDXMDjRjF6Xqo0c5y7xbv+jdj2UAVSSwJve6pzFbV4gSU64ehVElHGXQaXppGP0WBOb0xPJ0Af+h5IIIJQGf7c+bhZDgR7kxv70WSve5/EdhWiDLoYexbFHhhUu5VY73w/tecSdVMVK0FSAbA1hHnWZm5ZgWlZQHQAOWRvl3WiBawMofb1pPDz3SPuCRacygBeVebWMsN45BTsiALZHUwbOKEeETvqQl+hac3GklQIQ4uetkYsVjpw+AEUhYW4Q2+N4k5q5ioPbkXCPBK0ryLZ6c8iISztAX6impLD2M2dnDcd1kAvU+Ijyg7ma/XN/FEgRArCCKCodnwLzu+bdDoBHh+VtyUdjdVBh+OO3Z+2vFbR61zvUJ77mstcUgJMFxHvDsN/3O9sL+PcUeS5e1SOoIxhIQFMnv1bfVRwUE4cRY+W67/psEMXCn/7qMMau2A3vVBtvltX1rTUJ1XvzkLROkvwxeCOR1g30PDFIxLaRei0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8zSFp79PJpBTYQG2Gki0IjNYCDVo4cevtZ1UqPB/IQd7h353KI6tNtqDE5g?=
 =?us-ascii?Q?f68395as/2uPVooeZtEHOlkesTF7O2JjUsQq0y2ai24YKQkrVn0UDBnFwtGH?=
 =?us-ascii?Q?Vko6OAfOhubLYoPFRGiHcay6sVhY+CDY+s0PrAknNUpYuO0vPoCZdKqzo7qM?=
 =?us-ascii?Q?wIeda9u5wDWfAebDbv4DJDgQEzhZ+xJhS9N2FDAfgW2wF/0A0iJTGtXj3IMw?=
 =?us-ascii?Q?RJ2fOA2UtZ2eIvWVhFMdmsZNJg+D2KwbviGEyaUhYyWWzZPoI0UaWw2xfmCj?=
 =?us-ascii?Q?BndfNSMIK5WEeLIcz1bl3AUkmPIrmjMH+JAvs2DjMzdWxI2aIoltSsp/bcjy?=
 =?us-ascii?Q?jFWfFOhn09jIOQUJsDxrdUeJRlkFhTwZMKmBXPuPtPjFnUOBEke6yK14juz9?=
 =?us-ascii?Q?pIhFQfTZG/hp990xrH3IXHOJ9QPgv7WpsFNom0TyxeKssE4VWyq5F852QduR?=
 =?us-ascii?Q?VDGjjGQPhhw61r0HD3gAHO49HBOV00I26r/Ww+H3mESvUVPyMd8wGGktOyGx?=
 =?us-ascii?Q?zu7kLyfpEPsNkLBdI4Yjr7uvDMej4fn36yR33XAznDChr0RCok3H8pMBxwcQ?=
 =?us-ascii?Q?q+88kiopnKzyGUjDB/oq+JnDCvovUHpbuvTOA5LLruT209fTo2GqkFtHJ6Ym?=
 =?us-ascii?Q?jstk4Jl5ysPKLCrA78ppSnrE7wD2bxVgCIIulnCVSvgKcS06HaoDNIGt8fa5?=
 =?us-ascii?Q?AfKnJQxlEgPXWtZ90+zxBNlrv5EKOyWfa5C50A+BAKJQma3zWObILX040B36?=
 =?us-ascii?Q?cKIUtKAcCx89MWTPNQT3wNHgwAiZh0ndDUrgln8HB/Lmon5CDiy3luj9oXAv?=
 =?us-ascii?Q?cWDHz4T0jbvq1mH+kKqfpqTx9kMdI44DGi2KcP1hMQuwzF+N+HxkAiihirXO?=
 =?us-ascii?Q?p1IjS/BAEy98+973f5sQ9PbP5RRZfW+lNib8XarSVIqRwcV/azJU2kvE7UuW?=
 =?us-ascii?Q?PW+lgLEXoNqpchb/ZrmeiX0Co1Usmq5utzPY2wYqMq+C5NQMTn7YzOnUK59n?=
 =?us-ascii?Q?y8XSb6zHL97GWeqKDSctQbnQm4AEWKu9JUBESEusgPk7evyia4nuKLkb393o?=
 =?us-ascii?Q?oqJcjjKuhGtn4ZuvdB1QmsNIMqHv5g8Jtu6W2v2Pv/30C6Gxktdhpgib/mIC?=
 =?us-ascii?Q?aHIuXU7ZTKfpT+7tmRq4HEsxgbgXX0XdUn9A9WMh/NgEiEDKnCrIzgjQ/UU4?=
 =?us-ascii?Q?aP0e65EjGo91Z0gmu3X47PB+t0jkWlcfxFM8B1oGG9Da03QyCSxWMYDixGU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 815e9812-b87f-4df2-e053-08dcf1c656c0
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:48:54.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0171
Received-SPF: pass client-ip=2a01:111:f403:2819::82e;
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

> In the invocation of qdev_prop_set_chr(), "chardev" is the name of a
> property rather than a type and has to match the name of the property
> in device_class.rs.  Do not use TYPE_CHARDEV here, just like in the C
> version of pl011_create.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

