Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C79C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmj0-0003oo-DD; Mon, 08 Jul 2024 07:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmix-0003nV-EM
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:03 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmit-0007rq-K3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720438799; x=1751974799;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=r6WyKd+WY8Yb8bDrXxdIwpfjKQeRsih/fOFlu4WzvwU=;
 b=qbGaApfJ7F2IUdapF/afKdAMAlhjXLPIOUxburs0WE08uRJJxjGOcQMH
 C0eTt0S6KqvYWR6seBKza7P30exJCSu6pY6/Agl62MWtEGnShvza6Xvnc
 NKpkfiH8Jsid70zmCImVpJDHdW30E+wInYIeuBEB6dwJ8nyEE7js387BV
 YSGftpMR4QMy+yTKEliuPovOuY2xV/dhCa0LQEXasU/4+c9Pw6aTSegCq
 K4nIJEeSC9aVu4+fhAu3mdiE3dBz8l8MM8hvZXFcjIkJQ2eSgOvpTITnR
 /MK0Tl11jfmDw0ZkHLgnuFpp0mKc+YSvWN9yLTvKinWF9fdLBmZbkSw/C g==;
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; d="scan'208";a="16087895"
X-MGA-submission: =?us-ascii?q?MDHO49zdhKfK930NtW0XntY4bGHTZPIK1dliWY?=
 =?us-ascii?q?anPiHFXuoQ7p9t9YRdHZ1d9HjeE6RSYDYl2e869Ir6f9t5jLl0bmoTAq?=
 =?us-ascii?q?nTZzhhaaBdiM43LOdtCmak5QfibcSzpxpwSJk1WcVr6+UJIZtaXDYpsq?=
 =?us-ascii?q?WICD8V9GtutYcak2EcKM5xSQ=3D=3D?=
Received: from mail-vi1eur03lp2108.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.108])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 13:39:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4veTFFRx8snHcZERsc2zU72CsC98NljYB7l5qeAgElVhWu/GBHA3EaGpECW6rhf9OfPOe0ORaH3mM0i4NbRHv/0uavMNSIHfzXs2PaXeWZDHGF3u07PMFcEYmrUBslwIoSefd1aU2UAVorAXxz3Lk16MDpRnv6ObEDYBwpu2V66gdB1XcqVwGfpFrgpRB2LgfxUFaznaXjPykcVf9u7flsmoQnrbCZZ4mnJ6+F0996NO5IVWg/91zM3pLVgiMzlVD8YutED7y/fcClF6oJ/uQzqOnVCvMXX4el3qCk0lqYy4EtGdOqB0rcg5gtfriKMQF9kSEwuhMpPiKzBsB1HBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6WyKd+WY8Yb8bDrXxdIwpfjKQeRsih/fOFlu4WzvwU=;
 b=C2PFX7v4rRLWAMIrbCidmIe7vWviqW/dnqWCBl7xMSWAzH5qhUNzGs4jqlMXemad9qLEtZ/HZl83XZy4bZrrYu6FTSd8j1Xoij3I7iHdpLOK2FE/lb6/AAldyZGZhCfH4kwrYmjs1uUTdoz0LdiD1w5hkt6XXG7m08Yi/gA43alr8HcBz0Vlom6ZyHESiD/NVClshTyqoxoecu9sc8iJoE0Sg97veYdfbz5OzGjdwA1ssGXMN76PNBDvU8G8Ae3R3h+z7jSmrEoO8Uam5r+yb64ZQrTQm/XWa4NTJKQ79FAf0+TiL1A8TlBzv0ROY3ZPylG7mNdldVxIuYk3YIOl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6WyKd+WY8Yb8bDrXxdIwpfjKQeRsih/fOFlu4WzvwU=;
 b=Sl/cNpPu5ERGQWyCt/eg+G8itJINTpBchczINaJ6o+BAJC3JJvTaPHm8Nk+RpbTegbzY05mCpnKOrqNR8slO2hxXov9Q+Bx5COCK52Pp36gdNPPUapz4IPyOc+4dyNJ12X5BJ/yDsiKSBjQECpuy2pQZ6B3kM56+Ba7X+LgTv4YRQYcke+fPPvRt/FrKqUOMNmnSPIQ4MBuiqew94Dx6BW7i0HS05IKP/+6dJbLNwyQip7suH4pChV5SC64kJjAGeSUFPxOb8YQ7hZqX6J/nMqHy1MdpddzxcgWvdnilvIpydzgZFK9QmkJ1dcqiCkXDYki9mlCFIEt8LalJXFVKoQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7400.eurprd07.prod.outlook.com (2603:10a6:20b:2a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Mon, 8 Jul
 2024 11:39:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Mon, 8 Jul 2024
 11:39:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v5 1/4] intel_iommu: fix FRCD construction macro
Thread-Topic: [PATCH  v5 1/4] intel_iommu: fix FRCD construction macro
Thread-Index: AQHa0SuMWtlLXh0D9UKhcXu+XOoyDQ==
Date: Mon, 8 Jul 2024 11:39:53 +0000
Message-ID: <20240708113908.19535-2-clement.mathieu--drif@eviden.com>
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7400:EE_
x-ms-office365-filtering-correlation-id: b3df6517-c334-43fc-068c-08dc9f42aee5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NDlMOHNQUUNwOGhrZnA3YXJIVXlYdTIyRG1zczZjckE0a1BHTzhSSWljdXZE?=
 =?utf-8?B?NUcvY2NGK2FiaVliQW1lNCs2MmcyVWhpSE5HQ3NVNzZjdWYzMnJOU1B0Rzl2?=
 =?utf-8?B?VVdrbUZ2ck9aTzFYcjBDRVNBclFucGVGbElDSHkrWGlOL21SMEVzMmdRL05a?=
 =?utf-8?B?WVlCb1hGdWF3dmxNNkJ2NnFHTkZkSFdFSzJWclRUcEtnUFNwY0VpYjM1RFo4?=
 =?utf-8?B?cXNZTWYyRjYvcDRobWFZcndsVU8rSEhoZ2ZBRkJLejZVRmhlNmJzT1BtaDlR?=
 =?utf-8?B?Z2tLaEZCTDRyUmRIV0d0dDRTUFhxcmtmYVR0K2RycmtST1ZPamt2WXhaWVhx?=
 =?utf-8?B?TWhRYm1lMkdJZzdnVVZLZXBzVC8xSkt4dTV5ajlXQjYzbUUwVDcwbUdCMmdy?=
 =?utf-8?B?akJwMWl4bmpKQ3cwYmZkYjVxSFNLWmJmSjM0SDNrQ2llYXg1YTlGRVh6azFl?=
 =?utf-8?B?UnBVcDBUZW5XdlltN1g0R3V1Z1REcnVFZjZlblc5d0N1b20yRzExemNlTmM5?=
 =?utf-8?B?OTlsRWtyWW5JSGd2QlNEQjd2ZUdIRTAzNGtscDNDTm9oZTJTaTdBak9PWlpF?=
 =?utf-8?B?Y2JUN0NUL0YrV1Z1Qlg5VlRidFBySm9sQ09id211WUlvSEg5UXlmS2p1NEU5?=
 =?utf-8?B?NXhIMmZRSDl6RXM0a2hmU1BORVJha2Y2R1R2MFlrTXpoRXFKZ205dmM4eUZT?=
 =?utf-8?B?OHpMQXBGRDN5d2ZXZGsyT0lJUXNpVGd3RmxuN1pQejcxZDRHVSsxMnh5b1Ru?=
 =?utf-8?B?UUVYY1EvekY1ejdDRWZuSldPZ1ZWY1VtcmRNUW1JSnFrclFUZWR3MW5qVlAr?=
 =?utf-8?B?eVNnU0hQeXdOeFltbFFwbDlxYzJ6S1RpNUtIanE2NW11TUpsMndzbFppaU44?=
 =?utf-8?B?MFJOcGZrZ2NXOXlmMit2WlZZcnlHUUN1WDhqYkhDRWdrZmlxUitaOWFHWGpW?=
 =?utf-8?B?OVlxYWNzYnQ4b0ZCSXRIRzBVU1J2OW1vdmxQbTEvUG51QXNjYTJGcGhBZ3ZX?=
 =?utf-8?B?MTBwd0tOdWJlMTNpTGhtamhscGJhQjVIK1Zhc3N6c3dxK0JJMVFLQlYzSE8z?=
 =?utf-8?B?VEFkempWcFpTYktYN3NmVlZzNTFBS3lVbWVNM3ladlZJbmxvNjBmcWhSRDJq?=
 =?utf-8?B?cVpaVlVQNkM5VklhQlhFYm5DRmRUOTl6UTNtdkJPU3owbENnSGcrNE43UE1D?=
 =?utf-8?B?VG1JUHphUUxOTnAydzdOUHhTQ0tjTVFkSDZ5dmJkbGZoVTdCeWh2eXlZSGhC?=
 =?utf-8?B?YU5Xb1pNOGdWaUtUb3FUcUhoSFllMS9ZUEhvU2JGcG81RVlIOFNLRmNyQkRJ?=
 =?utf-8?B?RUVWeGlFQUgzZVc4YzBFY1doVmFTdnNkaURQamNKSEwrZEdkM2RjYzJEZ042?=
 =?utf-8?B?dXZHUy9NNEhXa3ppbFJxTG81b2ZaNWp1Y2dvMS82Q1lwZnlZTVkwM1RmcDdl?=
 =?utf-8?B?SUpDbDBjbVIzbUh1SjVmakcxSjhLdFo2TC9Tc3lYV0VleUNrTXdwWmE3SkVw?=
 =?utf-8?B?U2VueUY1TjN6c0h6cVQyTWVwVE5NOXVtVzBDZXNjQ05KNkRtaU54aXIvcmZ5?=
 =?utf-8?B?RS9JbnZDbEp0bE1Nemo1Q21UM092KzhsMXNFRDFJcm9NcFl0UC9uUlUycHMy?=
 =?utf-8?B?MWlSUUJsS2F5WFRnSjhmVVpOVzZzazZzSERQMk1LRUJZTWtWVXZLUkF3OWFa?=
 =?utf-8?B?OTgvT3g4MzR5dkNQUmV0aEE4MWx2SVpYVUxINXEwNHBXSFY5L3d1VDlzcWdi?=
 =?utf-8?B?cnVCWlAyeXVEUHlKMTlkaUQ2ZHpTelNpVWxxdTBVM1gxeGlNdmh0djNDN25M?=
 =?utf-8?B?ZUhLN0pKT2t4THJHbXZXVHMzS2J4Y3RQVnhlaDl6VDFRREl0TEovMytiV2Fu?=
 =?utf-8?B?WEt5ZmVVb2lhekFoWmRqZjBqR1dNaVpSdFZkeHBtUHRGOEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emhHYkdSYms3TUE1WWdRRERIWlJ1TUFBR1RxOXNNWjBtUnMrU1dOc09pbHdp?=
 =?utf-8?B?cmtQY2ZyQlFwbkRPRm5XN3NueTBZTzEwZGVKWU9pRVZuUjdoNmlqa0ZiS01L?=
 =?utf-8?B?amk2M1drOFpwdm9UcCtSY3RoM3E0cmZWeHNvaXZERHQ0VTFrNUNWWjhVN0Qr?=
 =?utf-8?B?T0JuK3RyRHdZQzgvU1BFbkZCUFBPWW1iMm01TGkwS1pOcUxrdUJVYUZHR1ZG?=
 =?utf-8?B?aUt6WVpYbko3WExyMTRXK0hSamR1eEs2bE1FYnBUVFU0eERaM2t5ZjRnS1pS?=
 =?utf-8?B?RmswZy9ZamEwSzVrc2Vra1ZKdGQ4ZEwzTnZWbFduUjZVb2JMaUlhNDNvTkxn?=
 =?utf-8?B?aCt3UTRTYk9jV0xrdWJydWdiTXA4S1diaFFUMHczaWFDeFpOL09tay8vZzJR?=
 =?utf-8?B?Lys1d0hraEd3NkJxYit2aVRhT00vMVVMUjlSQ3BhdVdIaVpGbzkxekMwN2di?=
 =?utf-8?B?Y3JyVnQ3STFpYldtT0FMSkNsRm1rNmJWeCtEaGV6RzRENTl6aUl3RFdlTmxv?=
 =?utf-8?B?NHFyZ2RscXVsbEg2YnpudWJ0ZTUwcjlZdGlXY0tsdGZMQXRRTzB3YjBQcWtV?=
 =?utf-8?B?YUdzQVMvZmRoYjRMVE1tcTBHUjkrU091Q1Rxa1BDUHZjTG96ajFHamppMmRL?=
 =?utf-8?B?QmVKQkJaTjZGU3VZS2tkcHFuK1pWNFFOMDFPSE10aGpNTnVqU2VKY1pqMTk4?=
 =?utf-8?B?VmIrTlMrYXU3eDhDWkMxWWFHa3NWTVB1dDA4ZGU2NHI0UGd1N3NBTUFWaXpB?=
 =?utf-8?B?aVJPbVNSQUR3TmVtTzhINW1aT01ybmZZZzhBdzRoRG13YVNCU05ucTZZSWNW?=
 =?utf-8?B?K1Y1Y015YzJWbEVVclc5OUt3V3h4SEFzdnVxOFNBSUI3Zmp3NWltWFFLYmdT?=
 =?utf-8?B?b3Q3TVBIUzd0MVFhOUY3MzB5cldzZTVxQVV1WDRsR3psaUZMeWxCTUwycnI1?=
 =?utf-8?B?eFArTzlQaHlibmtTQnVMZVdMR2VPaTU2VFhWNExLNjBUN3BCK0ZFTTRlZlRU?=
 =?utf-8?B?R3l5NGFqczY4V2w0UGE4dW9iQ29kTUtrZ2MyNjVYUFpoUmsxMHJTSWhobVFw?=
 =?utf-8?B?YmQzeXU0RnVkcmtGeHkwSDVmUlhxbHZ4NUlOUGdoZS9EWkM0RndIU3RHTi95?=
 =?utf-8?B?U2N4NkdFZXRacUsxaDVTbXpoUWtJKzJzMldoV2VOQitwMldVWVJaRVlnZmNR?=
 =?utf-8?B?VzhoeDVReno0dXpSV2ZmZkRNZEZQL1lpeXJ6WUN1eWQrdlBZNmpXajUreXN6?=
 =?utf-8?B?aEdJdGZ2U0hudVllMENjYVRKa25DRHdxenZsRjJQQ1RDYTJ4azZBV2ZlSVp5?=
 =?utf-8?B?azJjNGQxS3hZT2ovR1FlaFZpTEJsaDhQYTlSU0Fpd1pjMTIxQlJkdWpTSWlV?=
 =?utf-8?B?UkdnYmJMSGNzZ25QSWNOZlE3T0F2MFhkOGdVc3BEK3BoSTZNd1kyYmFkOENy?=
 =?utf-8?B?bzg1d3NyVzdBUGxBK1VER3JiUTYvUG96MjRLMzdIU2R0ODhYa0QyOU93S3hW?=
 =?utf-8?B?ZzNTaHJYellRYmtrWTl2KzJnMnczSkxVRjNRTXlyTm9jeWs5bzViY1RkQnpT?=
 =?utf-8?B?aEpUSHh0SjdVQ3BveWVYNTMrV0M4RjlHZmR5cW1LTmlXNE9XZ2J0T29yTnFh?=
 =?utf-8?B?QW9qYlR4Q2pCZHltYTJFVG9ONlZaY0EzYnpRWU9QS2FuTXUzcEVzTWRWdXl5?=
 =?utf-8?B?Vi9KTS9LOU4rd3hUVTR5cXR4dWI2K2xJL3czS1JqRXQwMGFya1Rma0dBUlBl?=
 =?utf-8?B?eUd6QzNoWXkrdFNNbk53Tkc1VTM3WHErcjMvcXRvZmdtZ0ttWHBZTWJwZXJS?=
 =?utf-8?B?c3IwSjFodlNuRnVkMVFxSk9kM2RMamx0WHV0Q0FpVnlIcGRiNXpJbEhKcDFy?=
 =?utf-8?B?ZWZIM0h4ZkRGb0U0QW1TUEFVVURFTnVXb1YzWlFmUzJVMmxOZ1hqVEFPNlo3?=
 =?utf-8?B?ZjUzT2hkd0dxejRiRkhvMG84T2F6aFpkMUE1VjUzYjV6L2NzNXBZa1p3dmps?=
 =?utf-8?B?cisveG9KYnpVdWRYa0o1VWF4UzlFeUo1R3J1clU4bE1UYUZCYi9odGFQemVC?=
 =?utf-8?B?UVRSdjJLc2g0VVZXbnQzZ0JUUDRnWVhMMlVMWlJMY3RsYW8vWitqRE5Bd28z?=
 =?utf-8?B?ZGdac3FTRUlzSlBlNFptOUFWN1JFbWcxYUFXQkh3MGxuaGsyOG4wWDM2dFp2?=
 =?utf-8?Q?kdhevU+nsilrttUjwwI+Hz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <162AB7B83577174CA6EF253EDEC4126B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3df6517-c334-43fc-068c-08dc9f42aee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:39:53.0448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kyt2hs+Q6PWEp/kvXty1ZlKf4JetkYh8bGmcSgqJ9qIIJxxK4chiH7g7X4lEAWP6C5EYbSYgrwKagKAya8DqTL+1nLgHLVBrTSCGdl7Ppq13deJu/aC8jWITn2qosSWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7400
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50Lg0KDQpGaXhlczogMWIyYjEyMzc2YzhhICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1
cHBvcnQiKQ0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQpSZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KaW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAzMSAxMDA2NDQNCi0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQpAQCAtMjY3LDcgKzI2Nyw3IEBADQogLyogRm9yIHRoZSBsb3cgNjQtYml0IG9m
IDEyOC1iaXQgKi8NCiAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4w
eGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZm
ZmZVTEwpIDw8IDQwKQ0KLSNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAm
IDB4MSkgPDwgMzEpDQorI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwpICYg
MHgxVUxMKSA8PCAzMSkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkg
JiAweGZmZmZVTEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9u
cyAqLw0KLS0gDQoyLjQ1LjINCg==

