Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31855D1AD39
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 09:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t10ji-0004cP-21; Wed, 16 Oct 2024 05:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t10jg-0004cG-17
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 05:54:32 -0400
Received: from mail-sy4aus01olkn20828.outbound.protection.outlook.com
 ([2a01:111:f403:2819::828]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t10je-0007DX-K7
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 05:54:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF0W9qMuw8DuExPvO8hBCbCGxngzmkNhFN6Hpd4NQB95dRQT+iIBSpFJCxpxn0Z4vncQSt8d0wgRh1LM8hItvhZbn2NlRR5sDZW0/K4vJIA/wfeTkifFFZlJQ7lipy6K/TBcUo9ms34MoV4hEYB4wlvJFoy0G2QtoY9Hf7TFIUeIz6so8f+1y0/H53m5TOFiA0zZELZotbPuna0SknZbweEWbjFqyuh7IdwKfjWOiwqYoGAV+8OFyv0lL0bjfGh9ZEWnQucKpEpWwp3VYqUqHK8d8ShPsblHubvDA0ULjPu9nZ/4n/UcAHm31dJEkRjHkADnLTWjapnV34pa8F3nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnAmyS3p5FwgIjta6+gnR7y3tt+nKPnukuH30W1LBIA=;
 b=BvW7GH2gGiJwW3GnqYChlfdNzyEH+VOsKPysvzuCW3FJ2+4spJik0xivQX0zyLutold4xr/7I4FlYvHWGgWxUfXt4Q9+hukM6mWXymVhvg9ajyrRLdXsmiYK/DkNYrL2Res45l7DWblDJnO4+T/3agWSIaA4RIaqQMqjq/3ndsokVeIwHkSHDgIJkIr4Uk015Ip2vleYAJU5srySQXV7Xe7kOAbt8ow0wZ1MShqUtXzqc1mFG1RQIWIGQVs/5Qj4DqPLi/n8a5x0YC/C4IgbT9PW2TxSI840jGx1XU/DibGCUJSKaUsA3NTk/TNTyK+JncNpsIpOsfhqV2xp/7z+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnAmyS3p5FwgIjta6+gnR7y3tt+nKPnukuH30W1LBIA=;
 b=HLKkz1gORRhDTciMF6I7spM95w+BtpIR6Fmj3Pu/LDRhVu04dcvCQtCwd0pMk5HNZVzfEJVvMqS6z/53QnA4J4w4pYv44csUeDlWNHgtTcmCoBWe7LyvUF/9mXtfSLuCOJfjtr2JcCauS00X9EAAoMd772HUQ+iUf+1E+vAoJm37TTVoneWA2DYYio23EIqt9EHkrpBrOiWbnx6R6O3gyw98qbZstyHBNl5gVeYNHl4PdmPH0WXhyCJXfYrIip7mraB+2+FaGKMwoDy5eLRnO2EDXB9ay4KRzvllkuxv49hDu6IT4Igz47saV8l9V21SBsyZHzrkA2LIBpfqpV2w5g==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0338.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:284::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 09:54:25 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 09:54:25 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-13-pbonzini@redhat.com>
 <SY0P300MB102670D06E55A6B463CD1BDA95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbqhmr=45c9ZiYoDAanM7Gsinz4RnwGMrivYDQgzP8kTw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 12/16] rust: allow version 1.63.0 of rustc
Date: Wed, 16 Oct 2024 17:53:46 +0800
In-reply-to: <CABgObfbqhmr=45c9ZiYoDAanM7Gsinz4RnwGMrivYDQgzP8kTw@mail.gmail.com>
Message-ID: <SY0P300MB10269110D64F40C0F5AF0E7595462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::13) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <871q0gqsop.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4244449e-c28b-44de-897f-08dcedc88437
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|5072599009|19110799003|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: mxLyaJVZ3rLj94Vea6w7Jz/b7Vuv9/4jro6WgYh63LycqebiG579yf5OmkMDFqVMUvLD/P5ZqWWh/E+CSq+bZzvvD4lkt2TiO6YMiZRnGO9isu+50WxftM11DrITS6+AKBxqN9SHUNXmgLa6U/l+WBqiD9B+tO3Ct0dUrkEGXw+UItzjdIeHI+Y6OoWLWUhLYx3lRHf4Hf811o+ITgx0O4A11RforRsGoAPH9kpVld4E/+aepVTzuLwYuvVmkWjjIipCAFYKr1sgdU0nSOy84fXYIiRJctiOl9iqsbBwKeIkJRijWQwHTQYxwqukz8xhqosCjyJkrL7CVSv+xaaFZMtWpsYrzZUclWjvDLU4qEgxfdtEtJnyaWzpLE2PQlo6Dnd0BNbCNSV5YQLwt2elLq5tKXErzwx3L3D3swAFXdEt4vTsBc7mDHAZsi4pVUcQ1mTMledDyO51+56SOEoGybrmZn1sJsnYODSOhbHCHtWnNSOlFd+IYIMQHVyiq2oiz07gNacvtNl4Q53Var+M+mr0Mpuyi0N+sRAOIds7Mj0Vatd/np44tEliVzKyhkzhtxOZI+kaSTY+HX2MjBfX6HyUNpCkBdsKv1lV/+WH1Krk0jpAY26pMSTrfHdlCHfmDOjDNNx6azpZOTHPSLD2mseRDavc4Dr3L2HB6sL7Xr6fOEDVDAnUILIFQJ/j+BhinMj04BlwSQLsiJrH65xIv72JPB4z9Kiht63lXEqswmY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAXtHHfXKZKhNrALPz4Hu2KMT5v5aLi47wRxOIt6g4HEhvruQaVSyM2JeYyH?=
 =?us-ascii?Q?+DSYd6dm2XC4SNJutlnS9DxpZAttQNKS0qzESuLTPyj+ZzKWW5OhxapvBikI?=
 =?us-ascii?Q?1oKBeZ7eM8aQm9k+oBTOiIycAQP0HWA8pNxz+6KKneStMDtIMgIh0ywUeKWy?=
 =?us-ascii?Q?2njWOQK7EfI+mPzeFHbgyhkWMWLY+JpkgQxGfOCgMEalZq21JwMs1Db270jW?=
 =?us-ascii?Q?viFV3+xPzmIHau+4AwW0s+3m6WDQmF3uzIs2Fa+DkzH6fOG4i5tFrnxy0Tni?=
 =?us-ascii?Q?vsDV5WQupuSGPF5x/5nevnP3FvPZPnLIxL9PRTemtCFzsSOrH4eLvpxaZDYw?=
 =?us-ascii?Q?E4COG2rO0Ri9DJkLqhy4mt2IvrxwVX+7hypfmnm2v2gS/PuArm8W5gH2mCAD?=
 =?us-ascii?Q?uw/OS00AT0lCavKtnPdIuamlOFCO2zAk+MtVt9K8XlluhC4MyUd5iyrpcpwG?=
 =?us-ascii?Q?8PzGlqy5Av8+1qYWfZCTTSmYtqgkf42fgNM+apjnCRIZUCtgGUxVaXFwJnEP?=
 =?us-ascii?Q?VV2qq0vilbOaJXYCp+rIFl5+ueR20QeqyYu1vFF9wiW4/CPVWdpTr7Tbzn3Y?=
 =?us-ascii?Q?VsjBKCRaDvt9pXQnBuE1AL/fwbOQZIfMskniikO6h9DdrI0Z7Djg/S2+2tDp?=
 =?us-ascii?Q?XHtuipJ2LA+gDwXdr4VenEnJil7xCJo4DBa3kyIrJDQfDWnIiCZxjFherLym?=
 =?us-ascii?Q?bHvJae5GwAdmSZ9R0U9JNhBiXJixWRCPba2rVksJDD2VaC/6mPa33Sj2ya69?=
 =?us-ascii?Q?EisTXlHUxaI0f9I9N8/25nmU5pgescFWqxh3tIAOw0omndHfNPUsUqT5HeRj?=
 =?us-ascii?Q?sPemrvthFN+3nI7Hvadm3/2RJXyvEKLJmL6bufqYC/uOMTeZT+U3X+vqMxG0?=
 =?us-ascii?Q?qRyaJhmr4jjryVl6JdEB3BZ+juLTj34Sq28MJjdWQPufUl5WL+IK+IyOcgIq?=
 =?us-ascii?Q?ngDQcMLncPSx4/4RYqWqLKkbGpswivCnw7hGKP0Yvttq0XtOvuMonn6P/ceb?=
 =?us-ascii?Q?KaezmxeXqSkan5ggXeX5qiPPpGYKjmPaTyhuperE/vcGp4zpE7xITfmQBVdW?=
 =?us-ascii?Q?wMSNHLgTeb/CogsWKMnzoThlU3JWqarU7EudcU83mSLrARsT3xVld1JmZoGI?=
 =?us-ascii?Q?yyi8dBmggOskaptuAPc3kxBiYJ0NNePuvQdFS3pZJCftVqQki+C09WCvQ7qL?=
 =?us-ascii?Q?tDOz2VPNmTN6p+l0hbgT0/pzODsXp2+ubgCCUJv8qapjfvrosZDuZmIxMFs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4244449e-c28b-44de-897f-08dcedc88437
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:54:24.9100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0338
Received-SPF: pass client-ip=2a01:111:f403:2819::828;
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

> Il mer 16 ott 2024, 08:10 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>
>  In my Ubuntu 22.04 environment (rustc 1.76.0 and bindgen 0.59.1 from
>  apt) the feature `proc_macro_byte_character` is not yet stablized but
>  used in proc-macro2. Downgrading proc-macro2 to 1.0.79 [1] and syn to
>  2.0.58 fixes that issue for me.
>
> This is handled by patch 5. Try "meson subprojects update --reset".
>

Yes, that works. Thanks for the info!

--
Best Regards
Junjie Mao

