Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25816D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qsb-0002KP-0C; Mon, 21 Oct 2024 07:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2qsY-0002K7-Tg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:47:19 -0400
Received: from mail-sy4aus01olkn20831.outbound.protection.outlook.com
 ([2a01:111:f403:2819::831]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2qsX-0002kB-9q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g08qbOtW1Hby4PeKjbw7D+5kngIOX57GaewHKX6Jds0pPZckR6rIb/zGXkDeGi7/ybnfM/y2oh9ztdMFzZbiZAKOzRGbcd63o95WJ5sl+woUxjbSSP4NW6h1EKcWQOl8tueW27HFj0NoGo8RQlze8I10AhcTvYPvMR2h6pMNUlEKEMmBV3/KZIMExDoAHGZSM7Aveo4jVdJHHE16SVnw2AMesPtmFMlHb2DfVxImhpL6JDmvCJjvB4QBYOgCQZTFUxHUH1aPhmLiFneK+ejEzX8RokhyCrPB6o+10X6HrMGZszQDaG8cI8HOfEKtwam/3cD6/I7HR9EQ8X9sRHOosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtcYVmdQDbP5fMEXh02VRN1A3cNY81gOv8M+el4Gggs=;
 b=B+et5Au/ldbylGK85pl4KW3CjQqMx3pFh3Hx9iaq4Oscy4Snim71xi033W4zn/yCViUYnd3yK9/hHW/ll8YM4bM43TzW2JV/jbzmO9WChUrTWrZW5mK/9frNevO6TINHIVyNUp6EGLSyOaWQEIEu+7PLxYSUDg7C60BngFLc1GU/8Kr6BlSnUh3TGGJKkcupQT37eVlp8HmxiVYCriryThEZmTyfrMmPnOxy1Wzcmfdxw2nDSqK0Te5O6Nrrd8q27IKAmBkmyzc+6qlw1+A6ceuZylqgnaX181cJjdJflAf23x9FMyJ5TsHsT/SU9qqTP6AW8lCmAIKY/7mUZEE0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtcYVmdQDbP5fMEXh02VRN1A3cNY81gOv8M+el4Gggs=;
 b=IGQLOZStMflZufvNTN049u8nahjfNZMCarvRtvwQCB2IiYT466UoWHrf+Y+bf891G6N6Mp6B085E4Nd+DFyab4H6C40kZZ/NpB0A9lhW9JfURXbzp7EuqADh16BetypO4W5Q+9baPyf0Q5QwsS7icCnv5JflRgYsL4IOCXAEdn6ZhN969JLOdrfag+0e/m6Mn9FQpFoC3+TiF4hvojRvpmDxphrbxlSEZeB6D+Txq0J4MMVzAWv6uWEeNgcABTRMkka8eYvG997Viq2tAj+jrsToe/z5sdyI54tYTdp0ZoLPT8zAyY1OdsLWHfAK8PfjumLrATgSsJO4M9Hz9SsQMA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0171.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 11:47:11 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 11:47:11 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-13-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 12/13] rust: provide safe wrapper for MaybeUninit::zeroed()
Date: Mon, 21 Oct 2024 19:46:04 +0800
In-reply-to: <20241018144306.954716-13-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026366BDEC5CD6196BCC88E95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <878quhsmo9.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0171:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d95bbf-a365-4cba-2b48-08dcf1c619b1
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|5072599009|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: hHxenJ5DPRa6rY/GH2wOrIqEHVY+c/iPElThwdGppsp585t+cPou+r3TFWdWsOpOoDc09AblMDKmEf9ISiI/vC5mDm1bPMD/LgM3GYVO5/aONkNYadPpd4wdB0lnd69vDPX/yNIGvcw+AQ1Z0YW4k/GFIfq5XT3A7KhqVh+bLZDADqJkSraoLbC8yS6dMIdgBkRPuZC/aK9qWu+8gKtDTKKVv6vUBX4PT1QIjwIblVIhQDjmxfFXHmKZGLN9CY2y6ek+rDUFF3AP49XheFyB8z4qr+ek+B9CqAODuZu6UtEzL0jybMWAceo29pCXspm3xl/HGf92WkMGsa+gIRviLxKYM0L9BxAy8QqtJO6Cjwg5z6gLNJ2Gon2bnyIxi3mn9IaaZMJDfLJbvqKSiva3iVPMyh4iRfAEnIEdEWn+8kfK1pxBBhsMTo77gA/l7YkGYZJ0ugr9qiSBm8iHgj0H5qIk8rvVD58sehNoh2s5GOLlfbciAwFIGcxNj4nWacn4JaSL38Qla/6v+ddiRVLu8mH1MjRmKtkmRsFimsFysUWzEwaQy6CNGFpVm8SBZx14iuj47ekB6RlWMRsxz0A0PbhY6RZQtcVVuVvr5OpH6IzNh83Q9yoo6ODmTDvURSQyexUqVXga2ISzTA+H2KRyxwhFKNCqbUebOSWM39XF6YglSUhYvc34oZteGH+KQ49RP3L2fskYgQRRmeAwQgYzZQEHGy2hBqPypZlQiNOwcsg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPiKyswg2xtMNbJHfO7+5rEA88CFv6+ufS1NxxeXNbP06wuZ3+WfrYtCnOuG?=
 =?us-ascii?Q?WJfRX+09+wWJqk8jLYfgxgSyUgFD5VjuFzKVxXpIVM+m6RYxqFYmMtVT0LlX?=
 =?us-ascii?Q?mw5/Ti/9+61J5rWHvV3EXjh+gjJSG+bTKPn92eSyE8SKQ8rk2Ykgg0y94VMf?=
 =?us-ascii?Q?tegRLoNUkvN2IY+S6aQ0+uYuhLV0xdY/ufSYpIm+p+RB6rdLhE+a5GXUy3Sc?=
 =?us-ascii?Q?Ort7Yqwbdag4rkTpdVn8iDnzUgO0ESk2kAYcIvWoA1fo69azq/ex2qWv/w1y?=
 =?us-ascii?Q?74AsZy2k+1qoYxZC13ecipIS8YwI5sqLRM8D7PYnwHHfgIMqhgi542MNiR1d?=
 =?us-ascii?Q?6rJCoZyH5Yvy/NpRWM1GE6PvTfjfxl6SUCXB6QoRC8pa8ofAt2A7trAbv80A?=
 =?us-ascii?Q?3N8qRTOlFaxdiLFtJVAJGw3JoM1Rf7NcXjdvQMMpzY/FcJLgkX9mN8fik12n?=
 =?us-ascii?Q?5XjM/GIBWZwfqlLT4b53Jwfxf3piJUk1kQTVT1wLhTyPw0Bn1CgenJkMp3AY?=
 =?us-ascii?Q?jbs30kTuizlDHJOgpRTnlHk3Lr2mDvZ6YDZOPZosjCvjnOt46DcUTY8alqxg?=
 =?us-ascii?Q?LNCqSq15D7yuNhdepdoVE40DNhMhJ8Ri//hF8J26xZdLohPsYvkOEK7fZ+nV?=
 =?us-ascii?Q?VnGJc6z5FjT1MHWWUKfA7UFIu0Qmpr6Gfxi13Y5iK1S3kvB7epJQqXpedN9N?=
 =?us-ascii?Q?JEq2yJK1zdws0fsLnYyr7kbGEQJ4ABYnGxtM1jfCiWasm3Txs4CIBGOaujPr?=
 =?us-ascii?Q?/AhgpdZ8voEfrrjcBdI6krO6SBYLzlW/cBJL1jOIQq0G60SrZYmMAvbl2U7p?=
 =?us-ascii?Q?teR+HeVPPolrZc95K1izCO3GNeKohs+wxq+4Q+YxmbXnr2ubXKr9JNtMipEd?=
 =?us-ascii?Q?0H2qYxQHlNyBsa/AFChPwMqpmopxLBFiKtQshZS/DF2/f3vkTEfB9blQQ21S?=
 =?us-ascii?Q?LxgEHB22wzw8hvUGyZeYDsYctFf93NVEv0P2agRhrHrG8amJ3V9IUwnawA8t?=
 =?us-ascii?Q?5r/tPBEbipZpWWAi5RIU6uVwPQwXX7x6prVMxq+3hqfxuAUz+sjDV/VwTcRB?=
 =?us-ascii?Q?sfnyDL+jor2M3IiqdOgpt0j51kQym178LnfXkYgBAFs/qnA3Nihy6V6PxQTC?=
 =?us-ascii?Q?LftvzkX4cKNyUftBkVDtdKivju1FnTIw3tDxWHyNGZB3IL8Q6BZ+IF2rcXRy?=
 =?us-ascii?Q?sTDEtlU6ZviPDQ30pV3VcBuQKjmhFl4bpZfP4jMhK+apkwQ7SEFe1zmmA+E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d95bbf-a365-4cba-2b48-08dcf1c619b1
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:47:11.8123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0171
Received-SPF: pass client-ip=2a01:111:f403:2819::831;
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

> MaybeUninit::zeroed() is handy, but it introduces unsafe (and has a
> pretty heavy syntax in general).  Introduce a trait that provides the
> same functionality while staying within safe Rust.
>
> In addition, MaybeUninit::zeroed() is not available as a "const"
> function until Rust 1.75.0, so this also prepares for having handwritten
> implementations of the trait until we can assume that version.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

