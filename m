Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211ABD2F7D5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 05:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1JFS-0004HD-OR; Thu, 17 Oct 2024 01:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t1JFI-0004Fv-BJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 01:40:24 -0400
Received: from mail-me3aus01olkn2016.outbound.protection.outlook.com
 ([40.92.63.16] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t1JFG-0000YN-5O
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 01:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJro/0QJy+9aJRBe46MF2ocR+PVQNKX/NqgH6PLHqOhptx4tUvVQeqIymxQ2T9Lc5R+CmWIjDeFnyDuvVedoLmIohrqTaxL2JZMlSOsQnWtH0TRlYRCyo/7WXFeJV/nMb4Ya3agnlCTZyPn7W6NXdCdXa0hW4EHlOTQ/SiCz9bEiuKbCbU/jCa2NBBEMN1Ul7pPzGLLPhM7tVDBCT9iKT7aNRCskhoMJHvEqTOMFPvCedGLzeAa0sysjK4Wg9z65vpdBO2F6onZ/3OrA+gECPZlaAyymY73cGz9ly77tsntkq0msBlbM2VRLLFKtrFCf5uaoIIef+NaOZ5HNqmX+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnglJ7OwKMZCpE8ModZ6dH2wZ5In0wU371gaO/RT+eg=;
 b=LXi3aGQkWurYjat1PMTnwOxjAUcFAy83lIqqe2/K/1YDpMNg8JQ5iQOuEVgWrhie8Ya0v7vDKQ2qzA+jXvOYkhRFajXlFsXCqMFTmrByAXHO2HvTnS29Wq5+65URbDa1RTT5K7yII2KZqwRnVwMcULXqphluSqq7ugx8rnKe8a3KCzayxcoo8lCwWeR45Z6YuowtGJHPPvpj20kW2rzTwaLPvbssifAkwND9E8Gb6sRjcHlwUHymS41+aLLOGGqmd2wAYLQJqdsYaW433QOfD876iqgZi3JCjnZLOBamj3OEnhW8qiAZ4oWg4eVzYpvabiaXqcRKdfl+UHRTMcU3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnglJ7OwKMZCpE8ModZ6dH2wZ5In0wU371gaO/RT+eg=;
 b=R6lSZSLJl8ooXip/o8v2dyW/I7DbQPXbkNx5OdyVlPjKysLVMUmPdW+0rQ2gUYqpI7sJXJaYOLPmPke7ewD0O7DMVl4xKynY2wQU7vl+BNQsqEuSE6EXPxSIF7x6KmCpGo1pBsqvr9IIpIz3sfoUWR1etmrf0tOWAKTB5tr7ICg8a6kTTIfqsRX6h/mBYCjSVYFAwTlNBHuBEtorCuxjwSeZYkrZjlOZykHIXfH22924uX6PpkgAC+F7nfz99oVnIvsJPut7m7b8Tkdi4jXDVXe2HdBdDGwv54GIEm6yAYj3PG5hBeavBtE1anO5SnuorMl4DQzhPIi11ZA2mOCMCQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0628.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 05:35:02 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 05:35:02 +0000
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-11-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 10/16] rust: introduce alternative implementation of
 offset_of!
Date: Thu, 17 Oct 2024 13:07:46 +0800
In-reply-to: <20241015131735.518771-11-pbonzini@redhat.com>
Message-ID: <SY0P300MB10266B5144972CDF92AF065795472@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0025.apcprd04.prod.outlook.com
 (2603:1096:820:e::12) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87bjzje1hg.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0628:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe91608-bbca-4fc7-cc39-08dcee6d72b3
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|5072599009|8060799006|19110799003|461199028|15080799006|440099028|3412199025|10035399004;
X-Microsoft-Antispam-Message-Info: XhrV+9S5K6AOv/+14rvpY0PPG9JzGSNqHCKXbHHILzaLGO517MEAdlsgq5KaLDZuKZ04qyOzwJ4jNo5ArFt0JbTRJfP7j2Gj9S9wriwUIrIfG/6di59DP5ZXiqFGIj8qKmTqtXyzXzjV9/bjqlgSjJroC1aDvCvgSPr3y3danIWlUxMgAOoA+u5xGO/F10n2e7hwtH7ovFy9f51f4397xxlkLcrfrSGXzDb+wdMkzPHUiKArn19ywPOuCZH2HLV+Z/LF8vFz43C/KnXlwAfEzHyrXuhLLEx222+a/To+gCvsAdxsMLV0TuQTR4rTkEYv0R7DS51N7KaLa7JXTMoIVElS9RZaultvdxv4tpybLovtoiUdvC7mTF0PJ7UWKiPB3vXsKZitVKWK+yHtMeXsJktauM3JuMvOGX02p/OhrZnExkzMEt/wKsJPYeBMDs0cTT/BHB+CjlDik1gd5GmyEnI2KwTPFEwmdqw5I9Vi7LBmoqfWCMiVc8RPHQqdz0QRFjAdn4QyqLW+V6PyP74jnOBFbKZ1zew9tv8c78kfm1TSoMwQMTuHnH1g996/GAueonOkLtWAT7c59PXGzLH3blogDzfepT7Xor+DVtiqNuyPUMHlu/Dms54dCDqUFZtX/hdl/BJeLR+xHKVC9TJWVJldmgDo+MIa9UJCA5QjtukI/knNqAQYwWwWdumh3UCV9kiT4cxIDx60PNb0t4AlOqw+hRLwgAWkRAv2eoXXzCJwqc+2yb2KzaSplZAx1xrpkiiKifwFuVlzP0DceHSXI74JPeSwLspQl0Y03uSa5xIYr7lHAZeQZxq3MMuZX1Le
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+sa65FVKDD5D79OvHDyzEZTvL7fAkTPTP2GJ6Bwc6nwYe7guydtZYGi6Ma4R?=
 =?us-ascii?Q?7kt5TxEkHaBUSKYtNlsN9rro+ziXA7sCq6Phj5x2wGq/UTdc6C0sqVNGmpsl?=
 =?us-ascii?Q?hnb71Uv5L1CWA2hAB9aIh0sr0FNd9TYPcs7vuekuLcDVT3bSOBqfwAj72b4g?=
 =?us-ascii?Q?zSEYyR43BHSijY+/EyWEczHCDIs+vHe2SfvQEJ5vtaO4gV6U9E+1rEsjxB2R?=
 =?us-ascii?Q?bzfJQKRgWeFZsfUMDA755wNz9KJFcUIi8skh+Kz9XboPLYJFJUHywIb/fcLf?=
 =?us-ascii?Q?GHkg11yY5u8fF3amKc0wTf818VrbFabI1V2XgyY8ixLlyeD8CmvTItv6PcW/?=
 =?us-ascii?Q?LKQI7wCjZvirJdftHOv6DpAaUAEoyNQ1bBYCBglKj1W9T36perPgN42gQF0D?=
 =?us-ascii?Q?hLmHsMjAigKk/DkAov1OSqbfoOK8bU8Z8PMGVuQs2F5Cfk6XvjNxb73U88Hl?=
 =?us-ascii?Q?qkstKW+RxdqsnSqcdlxLgW8Tk5KNofsIt4Z4MsyU4eKQ642CnWV0KRFK3lyW?=
 =?us-ascii?Q?QbJtYZWWLjcphdR6+wRJnzJ9fLhEWdSw349w6XFN6/5LXuSNN/zqkFdSvHLZ?=
 =?us-ascii?Q?QaOdxNGx7+WQ7CTnfRWaRlAhIioN/YocPfduz7TQM1hTe7VbT5aYoLlVK5/q?=
 =?us-ascii?Q?wtuKtti8Xbldx7vuHW+ebT/2UE52LnjwXFCNRkYBqgrSJCA5kwVaE2HsY347?=
 =?us-ascii?Q?4bVC4d3GYJMDibgvQ1njks7m9PM9l/Sz2HGNX1dcsChKImBi+dC09d44ebXW?=
 =?us-ascii?Q?crhBtzK0jNfVYAYMu0tODyXWyHRbm9g4loD3ngVL/Vs8WsMtu8U1QfeuFOy4?=
 =?us-ascii?Q?ON3KKKN1D4DppJSuV6kHmXyNQmy32EhJ3Y+6KUTTM5hIfKoi3kUszR0e9DVJ?=
 =?us-ascii?Q?I/qPgy89nyobQXgF/Canxhh23NJzHJT8qhwf2QakqnjTBmeRCXoHENMML+ad?=
 =?us-ascii?Q?RmtrEuY6pRzPf6bq/s8KzpSK5nZEjT9hPKESkYv3XLGY3F8sR6atNGji9aHC?=
 =?us-ascii?Q?CHgthQpu+l5bvSIOwBHde7KDxi2BIIOhxje+Qyq9UDMZJXurdHujB4cv+fAm?=
 =?us-ascii?Q?IFBur1tqOakKQwNz6DHpudv5akQby+pfJzt0Y8K0AEhGYrVhUFFO+dTnZ/by?=
 =?us-ascii?Q?l2bHXOOGLIPiyKsx99DGHBd3xXZ9CiPfpUn6mFn62ZavKcdH4az+23N/OA3o?=
 =?us-ascii?Q?Z1525eYDZsfUdFEzFmCTzSJ0CEicSEpdfw1X5mRZzcdnAVbNc1O4UfesvpQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe91608-bbca-4fc7-cc39-08dcee6d72b3
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:35:02.5282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0628
Received-SPF: pass client-ip=40.92.63.16; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=-1.277, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> offset_of! was stabilized in Rust 1.77.0.  Use an alternative implemenation
> that was found on the Rust forums, and whose author agreed to license as
> MIT for use in QEMU.
>
> The alternative allows only one level of field access, but apart
> from this can be used just by replacing core::mem::offset_of! with
> qemu_api::offset_of!.

How about a macro like this (which essentially comes from memoffset
crate [1])? It has the same use as core::mem::offset_of! (except the
same single-level limitation) and does not need wrapping structures with
with_offsets!.

macro_rules! offset_of {
    ($parent:ty, $field:tt) => {{
	let uninit = std::mem::MaybeUninit::<$parent>::uninit();
	let base = uninit.as_ptr();
	// SAFETY:
	//
	// MaybeUninit<$parent> has the same size and alignment as $parent, so
	// projection to $field is in bound.
	//
	// addr_of! does not create intermediate references to the uninitialized
	// memory, thus no UB is involved.
	let field = unsafe { std::ptr::addr_of!((*base).$field) };
	// SAFETY:
	//
	// Both base and field point to the MaybeUninit<$parent> and are casted
	// to u8 for calculating their distance.
	unsafe { field.cast::<u8>().offset_from(base.cast::<u8>()) as usize }
    }};
}

[1] https://docs.rs/memoffset/latest/memoffset/

--
Best Regards
Junjie Mao

