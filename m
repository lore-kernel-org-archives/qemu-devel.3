Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53D7EE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soHFP-0000xe-US; Wed, 11 Sep 2024 02:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soHFJ-0000ma-Lj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:54:33 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1soHFG-0005Cm-BS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1726037670; x=1757573670;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jYilBBmPczrVbHU6yBfueP7d00I/RcEBL8QQTmXDOdY=;
 b=dJnBlLKYSYmmWzMUSI21HlQ0fmeOjVXTi8gzO4884wD9TkFpZntXih1/
 b0mPMx+b/j5JAvkJZRKdBqf8f9m0JgdZJNW1fsuf2sh8mpbni0GpQciJd
 MTKzwn7yGTVG/2H2KrokkgvCMLocSgi+PVgRq+ST6WIasU3sxITP8gyQw
 MEJulNJintnjGIbkqLRwid05g0ae8MRXPH4u4b3VbEWlbijbVgNK8cJV2
 3CGjmEj9tWGrxMHCfyiw9q0Y/faDZU+G46kNPK2cIll1ExqfybfjZn6sd
 AEQ1LxQDB7WBMRapDr9cNPp1Cf5ow6KjpDO1hMon61N81pmaBpr1kpotF Q==;
X-IronPort-AV: E=Sophos;i="6.10,219,1719871200"; d="scan'208";a="20045170"
X-MGA-submission: =?us-ascii?q?MDGemvK5B0BrDFtWUfR56K6TZvX3/gFL+8lMz2?=
 =?us-ascii?q?MecufNV11qAVJDYFsBcr1/+KPe/ifsLNp/kGoa6VaTibOtvUvqPmNj9+?=
 =?us-ascii?q?WHfrZYYIM8A0AA3bySUSiAFrhWY2es5CZP9rjwyknEAxr7ogCeaqKo6g?=
 =?us-ascii?q?GPFi9Bk3i45qIoOXKwDXKkgg=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2024 08:54:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiP/86HGPZ6uRKxGC0YLFxssplT8gxzbjfnyj6rRlfcAtOnkXdswqL9+X6Tt2X5CEqb009DurLNGuTbvxTQ19c5N7rXpvHfw16WgwKXh6+IWMzUpjySt1wIZo7M3joQFa2GcpgAQz3QsJKp4u+IVVWh7yb8Nc3cueMFfQipcwiCRecuBBs6yYKQrHoe86rcrwNqQ3uIBFVBLmzujiibArybynU6I2HAiQfXKgmTklRjUYH30MdxOnYQTFNGG04ChGAOYVtF2UpT4ZViWCLTv1Wayn1i/w4KK8is6L8ygiLR+ByCgsPxWwcua++lfSvT9k9bIQKZPl4Y43qQFAyoJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYilBBmPczrVbHU6yBfueP7d00I/RcEBL8QQTmXDOdY=;
 b=YAE6dd4s5yWyUvpO21oQfPHExhmOQfh+sZ2Fj5MOF9HbNYLKSvnIOen8+1EVsefIblUPwbB1cp1EU/lHqgQwrypWGnNrSznMwoF7ktN0KTPpx6fB8e0LH8ieoZhLKouc1nfiXu22uICTLMsuOwyKczNCbhFbCulax/5pNUb5xLP7QUcXsi61mRjEs0ZnK3eWtyush5yytB0VIzzzImkeVwOfui/bz30newpT72I5qo+xpr4iWZ2DGjA4186vef/1bf8z23+Yd2yF/dKEAA7NU/fiFkHvg8TnVEiZZfX45uvV8/AeLOQXu7YV8AcBJxOBMkpr42a/8MuXOGYYUm/BPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYilBBmPczrVbHU6yBfueP7d00I/RcEBL8QQTmXDOdY=;
 b=jm+cfGp8ZIgNag8hRfxE3COI69xOVIXK9NaWwCA+9zD+FbXzJJgW3QOQEZ64Q+77ulm1o4ofgy5kf0YXKbon4JoGNLR1LxViTbu61k+Ao/s9WVBEwzCNzsrfOT7b28UDAWGF3rnXbmqhyzaRDBCqDefBJ8aBfcdepSqCiLm1uNTJ2l/1DO1rq2bFgdnzbzypAe1rg4eK+9DojkvzhzyBfCdYyVBiSJcKyyiex24wwl8vV3K1IgdsGOHEqw/JMYC1N9wsYC2vt3WExaEEPYfOj77jNWnudSovuvMWnlhzWWKHh1wRD6waB/Yzw0bWBKmiPGmbXvvxFL4SMfD3VbsHfw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8373.eurprd07.prod.outlook.com (2603:10a6:20b:444::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 06:54:24 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:54:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v3 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHbBAsfHf5nqQOdV06l/KRkPXkE/bJSJquA
Date: Wed, 11 Sep 2024 06:54:22 +0000
Message-ID: <05943841-75ca-4e11-95e8-7aa73c49e70d@eviden.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-5-zhenzhong.duan@intel.com>
In-Reply-To: <20240911052255.1294071-5-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8373:EE_
x-ms-office365-filtering-correlation-id: 64c5eded-0d61-412e-c005-08dcd22e9105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MXBPRWVBUnFLNDJXQzhJcUFQNHM4NVB6M28vOW51NTVyUmZIN0FlZU1RUkYz?=
 =?utf-8?B?SVE5Wlo3N3ZXekFQTGRJOGNIQnNvekdSYjJhZGNrTzc0ZHpOdk5pUzdiWTBH?=
 =?utf-8?B?dkFuN0lKMUZFQWZpSUZXWWhKM0JudnFrMWZvWTMzbUpQZ210MDdZbTJieTh5?=
 =?utf-8?B?V0Z5eGpzYmM4bllMTzNCZGZmQXE5Y1FxUVUxcU1lQzBPNm9tYStrNzR5LzVi?=
 =?utf-8?B?YXpmcGhjWS9vRUl2cXNTQm5ybmtHTlU5YXlWTFREclBUNEpadG1VSkl2TFNP?=
 =?utf-8?B?L25QZmIrQlkrNml4UlBPL1ZIYm1EM1A5ajBCWEFYOWkzQ05VeGxxRURDUDcw?=
 =?utf-8?B?Sk1YblhVcm1qblpTV3dVY1NxL1NjcHQwVXZHVzRvZWxyUWxwN0hCTTRiQm03?=
 =?utf-8?B?a0I5cCt3VWxRTmdhTHREVUhBem9Ed0JTZlczejZlekFRazRVemNicUsyVWVz?=
 =?utf-8?B?UXlQbW1ySnBWbjNuTDdUQjJLTGNxTE9OeEZLREJFK3ovQW9UeEZpSkxGOXdl?=
 =?utf-8?B?V2FoaDYwSmVlMEJySFU4TExEZ0tuK0xmenhDems0N1U1NU9IMFpKRFQzWGZ3?=
 =?utf-8?B?RWF2KytjR1JzQlhVRjZTQ1J1RVNRdjUyUXZnM3dCTGY4WjJrdERtSEhxeFhs?=
 =?utf-8?B?cTRkM2pGT2V5MUw5c1orYzd3eXpwRlBwVlV4elZaZnJ1V3hpQUxQc1BRRlp4?=
 =?utf-8?B?bTV2d1VwdFd1TDlpcDZGUWdocStrNkxJSVpMcnNIa3VReXNBbHB2bHZseHRn?=
 =?utf-8?B?c0Qyakc3THNkb2hCRHEwL3RRNlJYOUViRlJSeVlyb0hJbitJNFBwK3FXRHVo?=
 =?utf-8?B?bTVaamZJVHYzK1Q2NTh3d0owQkhjVDdNMUNjcnRDYnhFQjk4UGtHWUdvNFYw?=
 =?utf-8?B?WjNvVFd5ckJCOThIVzVRUjBDQ0hBL3JheXpzTVN5aXMwRStjc1pwSmtUWXVH?=
 =?utf-8?B?S1FMZVFWZWUyRXJMUlM3TzZWa3p3T0JnRU94ajZFWEdhdkpaajFNUVFYeCth?=
 =?utf-8?B?N3p5T3lxclp0WkZGSlpoeTE3bWNOV1JrS1JXN3gzUHZIaTBOL3FPem1FOGpQ?=
 =?utf-8?B?T2Z1NXR1VEdTdVZuODlmOFZ1clVXWk01KzVibzNtandRL0xhd1ZIUmlqbndl?=
 =?utf-8?B?YStXa3pCaHYvS2NjblZDZ3Z2RjZQbk9aQWZtc25UNkdldTA3bFF0SVVFSFk3?=
 =?utf-8?B?SHZrTVdYMGloSE95b3JqSXc0Y1BVMXVSQ1lNTUNobnpiaXFvUE9qaTJIVUoy?=
 =?utf-8?B?Qk4xRUFBdHlHMzdXblA1blNwNldQQ0dLSi96azBRSGJDMjJMYnpPd3NoTHBw?=
 =?utf-8?B?RDRnM0lMZ1BpajhlVm5vb1BUUHQ1enBFclpLVEF2UFhMcjU5OTcvUGdGajdW?=
 =?utf-8?B?akpDZVRLR2ZaRFo3aFBVZzRkcWdSZXhFQ2psM2xPQ21vT0oxT1ZhQk1Wdmdk?=
 =?utf-8?B?K0g4citMaFZ2WFZ2NlRYMStZQ3BJRnRDRDRSVzNhSjdhSGxmT1hXSFZiY2Y2?=
 =?utf-8?B?d1J6L04vN2w2M1p0VGdSVjlGUm52WE9QU2tHOWszNXZiOFVObzQ0N0FZNGIr?=
 =?utf-8?B?MFBwVUEzZVVhdmEzeWRVVElDTHArZExjMDIyWGdsMHFic3JMZlkvUHAxNG1m?=
 =?utf-8?B?Sk1POFM1MmpBK1ZkaExrdzg1SGxWcnR6QzNtWG5uazhLejVTVlU1bG5GUDN5?=
 =?utf-8?B?Q1pTczRRZlkxMjlaVW83T1FqWWhmSDdDb0lNdUdndlMxcTVydURoWHdDYnYy?=
 =?utf-8?B?TnV1ejVWcXhDVCsrZkJTUFM5OVN2dVg5TEh0WUUrN1cxb3J5dkFYeGdHSnd1?=
 =?utf-8?B?ZmVxZk9za0YwdDZWSjZkQUdHTUg3cHlxWW1YOHVVeHVMTXQ0OENoZXBjMGwv?=
 =?utf-8?B?Vk1WRVpiS2tPYXhoWGRoRzREMmdSWksxd2lSQkdGZCtTeGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGlyVXExbkZxeEVxNHN5MmlnLzhzekRUU1VtM3FUdHdKRWlOQ1VZWUJkcE1J?=
 =?utf-8?B?OW02ZUtkb3BxWlRjamxCNkRjRXp3OWM4SWh5dWFSczVuSGhKdXVNR1lLbTd0?=
 =?utf-8?B?cmlFREZDNEZxa0x1MEh6Zk1NOENBbi8vMUtnTUxpUmEyL3pGYVpRR1N4czFq?=
 =?utf-8?B?cEFRUzlkWExGdDlOZXRFSm9hV3NwNi96Yll2OXVJSzl0T0VTNFF1V0tkZC9t?=
 =?utf-8?B?WjVvSUFIa2lZZldycjRxb1JVV0NVM0JudHZSOWszNlgvL1EzUnVNeTYxdVZi?=
 =?utf-8?B?aFplNjY1Zlhua2JuL1dtd05YSjF1MlJFSStRQlMxZk05WVJsazlaeUNVRHVz?=
 =?utf-8?B?emxmbVFxMFRhaWFHOWF2L3lnaXZSUXZmSzJmcVlhRmNrR3VjTUtKc25MUFgr?=
 =?utf-8?B?cENrSmltcHdvS1dxc3NqMi9ydW1WU0tjOGVJVFBQRUhuZE1USnFuTVdXTGxp?=
 =?utf-8?B?cmNVMHAvWUtQOWdlNmYzR2kzMzQrTWhJbVQ0YzY5aXd5UExxYldvMEc0cFZi?=
 =?utf-8?B?MzVPZGM0OVV5N1VsTEZoUmcrdTRIb0NBTUhDcm1FQnhQcEJOY3R0TEhKY2k3?=
 =?utf-8?B?OUV1SnROVFh2SWxvQXZJQUlpZFRVZkJ6WkV6VmVZeEVVN3RMem9DVmUyYWky?=
 =?utf-8?B?d2U4Qm91UWFGejdYeXU0bDZmemZ6SW9xbXFkSmNUY0E5aVBGa0ovZEgvS3Zh?=
 =?utf-8?B?L1RKbm1ZUVdMNDZXTGtQcStVcDhCdElJY0EybUVVeFp3R2RNUFRCLzMzUk1r?=
 =?utf-8?B?WE8wYVAwRmlMaHRCQ0xmRUN0ektpYUQ1b29jN29kN3BpMkJBQTgrdlVQNjVa?=
 =?utf-8?B?emFuWVNqWk5lTm1YQkpqRk16ZmtldENKeFpYRU0vM1NpaTBpTGVWV3BWZVJx?=
 =?utf-8?B?L2EwWEdOa3JxSnFYOCtKU2FqQVUzZUNGQjVURzlTdlV5Y2JvZjlCRUloRHdF?=
 =?utf-8?B?K2g3ZHRXUjhiS0ZqTWZJcy9QOW11RW5TQXpCeHRIQklPdG9MWWJDeE9wVGUv?=
 =?utf-8?B?eHlwd3hmdXhuT2crc05CUFFodHRhM3psbzl1ekUxOVFLbkdJalJyeVYvYWNn?=
 =?utf-8?B?d3QwK1ZNZWlEUjFTU3FHWjloQUtRSVB6cWtVaGowYzMvMEtEWkwwNmhLcGRs?=
 =?utf-8?B?Vzdya1hMQnl3eEduQnVHS1o3eU9sMFdqZ3B3NTBadkRPbW9OTDlTbEU2WUJJ?=
 =?utf-8?B?clYrTm13ZDdtdzd0RHJZcUNzZWFRaXkzVGJtS1N1TnluV2dNeVRWTTNzakRU?=
 =?utf-8?B?enF5MXJFQktzNzU3V3lEUk5PR2pzdnZYbFRuTitjVkRpendhY2E3SW43TzlB?=
 =?utf-8?B?dlNMMzJNdTdmU2tzQzcwVlQySng1SEpTOEc3aHc1QkJVS2hZLzJJemtibVVh?=
 =?utf-8?B?bTVuSks4N1ByaTFDT21sL1M1T2VGOHR1S1lRaG9zVVF3bU1NVXZMOE1CK0Ez?=
 =?utf-8?B?QjBvYlZ0TUdVTHQ0bVpPajNIcEpTTFNKaVdvYWVTMnVybnk0V3hoNXBiMHh5?=
 =?utf-8?B?cm5VbEdBMEwzNS9HbWw1WUVKSmFrekpqVXNaUnVzNGg2VmtRQkw5OXpET0tF?=
 =?utf-8?B?VjNRbEdJZWhWM3J2RmVJalg1QzlrVzVuYWF1U2gramVhTVhZbjNkYlViUHd2?=
 =?utf-8?B?Z1NwUnVmblNaWWNXQlkxbUlGN0N3NEh1U3IrZmJIQWFkRi9iRHhIRTVQWERm?=
 =?utf-8?B?cjI2dmdpbkFscjdPeUhBRyswTVZVRnF3Nml6SnFZcFdCc0F1Uk1sYUJMa2gw?=
 =?utf-8?B?NzlwT0hBRW95WUhveUxQQ1FDUlArUElHenlrSXRXSDkrdHVNQXVaQ21obVVE?=
 =?utf-8?B?Y2tVOXJkTUh3TlY3ZDlkNmdicTFlMktYbEJLMi9iWTFqcm9xRW9sV2wvaldt?=
 =?utf-8?B?WG01OGVOa3ZEN3pna2d3NnpzZkg4bUgyVHV5OWpXb2FvcW51ZUYyNlFFL2kv?=
 =?utf-8?B?YTBGbk5QM1JFd3MxUGtmMk9uOXBUdU9aSVJWUS9BRlYzZkwxNTRPRWlLVGhC?=
 =?utf-8?B?c285WDB3Yjdkd2R0TUhDN0l0WEZXeGx4ck0xRGRoUExYU1BZN1g4Zk9STmJp?=
 =?utf-8?B?bXBJVVNLMHhQc1RZaTlqUXZYQU8xeDlqQ1NtTC83dUlKWktJUFZxWFNpU1pR?=
 =?utf-8?B?TU1sYmpJU3BaWENYTkk1MEtNT1QvNWdIa1NQKy9ORkpwdkdZZnpQVmNrT1Bw?=
 =?utf-8?Q?5+yWBt+zae0Mk7pFXYet/xo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E74EE19759784348BC0D834C8F5CC3B8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c5eded-0d61-412e-c005-08dcd22e9105
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:54:22.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8eHNmTxPctL1zs+ABmE1j9paSoPAlYNilzbymMZQ0Zn/cSLnpHd7Z4dA8u/QTJg37MSO/CoxVPUuI/5EWwnkzxQGfYfVKr3vXtVg1B63MWu4lfVyfoFwCz9ROGkxhxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8373
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KT24gMTEvMDkvMjAyNCAwNzoyMiwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gUGVyIHNwZWMgNi41
LjIuNCwgUEFESUQtc2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbiB3aWxs
DQo+IGZsdXNoIHN0YWdlLTIgaW90bGIgZW50cmllcyB3aXRoIG1hdGNoaW5nIGRvbWFpbiBpZCBh
bmQgcGFzaWQuDQo+DQo+IFdpdGggc2NhbGFibGUgbW9kZXJuIG1vZGUgaW50cm9kdWNlZCwgZ3Vl
c3QgY291bGQgc2VuZCBQQVNJRC1zZWxlY3RpdmUNCj4gUEFTSUQtYmFzZWQgaW90bGIgaW52YWxp
ZGF0aW9uIHRvIGZsdXNoIGJvdGggc3RhZ2UtMSBhbmQgc3RhZ2UtMiBlbnRyaWVzLg0KPg0KPiBC
eSB0aGlzIGNoYW5jZSwgcmVtb3ZlIG9sZCBJT1RMQiByZWxhdGVkIGRlZmluaXRpb24uDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDE0ICsrKy0tLQ0K
PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDgxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gaW5kZXggOGZhMjdj
N2YzYi4uMTllNGVkNTJjYSAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBAQCAtNDAy
LDExICs0MDIsNiBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCj4gICAj
ZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9BTSh2YWwpICAgICAgKCh2YWwpICYgMHgzZlVMTCkN
Cj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9SU1ZEX0xPICAgICAgMHhmZmZmZmZmZjAw
MDBmZjAwVUxMDQo+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUlNWRF9ISSAgICAgIDB4
ZjgwVUxMDQo+IC0jZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9QQVNJRCAgKDJVTEwg
PDwgNCkNCj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEX1BBR0UgICAoM1VMTCA8
PCA0KQ0KPiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSUQodmFsKSAgICgoKHZhbCkg
Pj4gMzIpICYgVlREX1BBU0lEX0lEX01BU0spDQo+IC0jZGVmaW5lIFZURF9JTlZfREVTQ19JT1RM
Ql9QQVNJRF9SU1ZEX0xPICAgICAgMHhmZmYwMDAwMDAwMDAwMWMwVUxMDQo+IC0jZGVmaW5lIFZU
RF9JTlZfREVTQ19JT1RMQl9QQVNJRF9SU1ZEX0hJICAgICAgMHhmODBVTEwNCj4NCj4gICAvKiBN
YXNrIGZvciBEZXZpY2UgSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+ICAgI2RlZmlu
ZSBWVERfSU5WX0RFU0NfREVWSUNFX0lPVExCX0FERFIodmFsKSAoKHZhbCkgJiAweGZmZmZmZmZm
ZmZmZmYwMDBVTEwpDQo+IEBAIC00MzgsNiArNDMzLDE1IEBAIHR5cGVkZWYgdW5pb24gVlRESW52
RGVzYyBWVERJbnZEZXNjOw0KPiAgICAgICAgICAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdf
TUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSB8IFZURF9TTF9UTSkpIDogXA0KPiAgICAgICAgICAg
KDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSkpDQo+
DQo+ICsvKiBNYXNrcyBmb3IgUElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPiArI2Rl
ZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0cgICAgICAgICAgICAgKDNVTEwgPDwgNCkNCj4gKyNk
ZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUQgICgyVUxMIDw8IDQpDQo+ICsj
ZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUFNJX0lOX1BBU0lEICAoM1VMTCA8PCA0KQ0KPiAr
I2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0RJRCh2YWwpICAgICAgKCgodmFsKSA+PiAxNikg
JiBWVERfRE9NQUlOX0lEX01BU0spDQo+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFT
SUQodmFsKSAgICAoKCh2YWwpID4+IDMyKSAmIDB4ZmZmZmZVTEwpDQo+ICsjZGVmaW5lIFZURF9J
TlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwICAgICAweGZmZjAwMDAwMDAwMGYxYzBVTEwNCj4gKyNk
ZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDEgICAgIDB4ZjgwVUxMDQo+ICsNCj4g
ICAvKiBJbmZvcm1hdGlvbiBhYm91dCBwYWdlLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRlICov
DQo+ICAgc3RydWN0IFZURElPVExCUGFnZUludkluZm8gew0KPiAgICAgICB1aW50MTZfdCBkb21h
aW5faWQ7DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gaW5kZXggNTdjMjRmNjdiNC4uYmUzMGNhZWYzMSAxMDA2NDQNCj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
PiBAQCAtMjY1Niw2ICsyNjU2LDgzIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2lvdGxiX2Rl
c2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjICppbnZfZGVzYykNCj4gICAgICAgcmV0
dXJuIHRydWU7DQo+ICAgfQ0KPg0KPiArc3RhdGljIGdib29sZWFuIHZ0ZF9oYXNoX3JlbW92ZV9i
eV9wYXNpZChncG9pbnRlciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQo+ICt7DQo+ICsg
ICAgVlRESU9UTEJFbnRyeSAqZW50cnkgPSAoVlRESU9UTEJFbnRyeSAqKXZhbHVlOw0KPiArICAg
IFZURElPVExCUGFnZUludkluZm8gKmluZm8gPSAoVlRESU9UTEJQYWdlSW52SW5mbyAqKXVzZXJf
ZGF0YTsNCj4gKw0KPiArICAgIHJldHVybiAoKGVudHJ5LT5kb21haW5faWQgPT0gaW5mby0+ZG9t
YWluX2lkKSAmJg0KPiArICAgICAgICAgICAgKGVudHJ5LT5wYXNpZCA9PSBpbmZvLT5wYXNpZCkp
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUo
SW50ZWxJT01NVVN0YXRlICpzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZCwgdWludDMyX3QgcGFzaWQpDQo+ICt7DQo+ICsgICAg
VlRESU9UTEJQYWdlSW52SW5mbyBpbmZvOw0KPiArICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Fz
Ow0KPiArICAgIFZURENvbnRleHRFbnRyeSBjZTsNCj4gKw0KPiArICAgIGluZm8uZG9tYWluX2lk
ID0gZG9tYWluX2lkOw0KPiArICAgIGluZm8ucGFzaWQgPSBwYXNpZDsNCj4gKw0KPiArICAgIHZ0
ZF9pb21tdV9sb2NrKHMpOw0KPiArICAgIGdfaGFzaF90YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5p
b3RsYiwgdnRkX2hhc2hfcmVtb3ZlX2J5X3Bhc2lkLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmaW5mbyk7DQo+ICsgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4gKw0KPiAr
ICAgIFFMSVNUX0ZPUkVBQ0godnRkX2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90aWZpZXJzLCBuZXh0
KSB7DQo+ICsgICAgICAgIGlmICghdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNf
bnVtKHZ0ZF9hcy0+YnVzKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0KPiArICAgICAgICAgICAgZG9tYWluX2lkID09IHZ0
ZF9nZXRfZG9tYWluX2lkKHMsICZjZSwgdnRkX2FzLT5wYXNpZCkpIHsNCj4gKyAgICAgICAgICAg
IHVpbnQzMl90IHJpZDJwYXNpZCA9IFZURF9DRV9HRVRfUklEMlBBU0lEKCZjZSk7DQo+ICsNCj4g
KyAgICAgICAgICAgIGlmICgodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQgfHwgcGFzaWQg
IT0gcmlkMnBhc2lkKSAmJg0KPiArICAgICAgICAgICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFz
aWQpIHsNCj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgIH0NCj4g
Kw0KPiArICAgICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAgICAg
ICAgICAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5jKHZ0ZF9hcyk7DQo+ICsgICAgICAgICAgICB9
DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBib29sIHZ0ZF9w
cm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KPiArew0KPiArICAg
IHVpbnQxNl90IGRvbWFpbl9pZDsNCj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4gKw0KPiArICAg
IGlmICgoaW52X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwKSB8
fA0KPiArICAgICAgICAoaW52X2Rlc2MtPnZhbFsxXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNW
RF9WQUwxKSkgew0KPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgcGlv
dGxiIGludiBkZXNjIGhpPTB4JSJQUkl4NjQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IiBsbz0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19mdW5jX18sIGludl9kZXNjLT52YWxbMV0sIGludl9kZXNjLT52YWxb
MF0pOw0KPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgZG9t
YWluX2lkID0gVlREX0lOVl9ERVNDX1BJT1RMQl9ESUQoaW52X2Rlc2MtPnZhbFswXSk7DQo+ICsg
ICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKGludl9kZXNjLT52YWxbMF0pOw0K
PiArICAgIHN3aXRjaCAoaW52X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfRykg
ew0KPiArICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUQ6DQo+ICsgICAg
ICAgIHZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShzLCBkb21haW5faWQsIHBhc2lkKTsNCj4g
KyAgICAgICAgYnJlYWs7DQo+ICsNCj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QSU9UTEJfUFNJ
X0lOX1BBU0lEOg0KPiArICAgICAgICBicmVhazsNCj4gKw0KPiArICAgIGRlZmF1bHQ6DQo+ICsg
ICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCBwaW90bGIgaW52IGRlc2M6IGhp
PTB4JSJQUkl4NjQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIiwgbG89MHglIlBSSXg2
NCIgKHR5cGUgbWlzbWF0Y2g6IDB4JWxseCkiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICBfX2Z1bmNfXywgaW52X2Rlc2MtPnZhbFsxXSwgaW52X2Rlc2MtPnZhbFswXSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19JT1RM
Ql9HKTsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKyAgICByZXR1cm4g
dHJ1ZTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2ludl9pZWNfZGVz
YyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KPiAgIHsNCj4gQEAgLTI3NzUsNiArMjg1Miwx
MCBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMp
DQo+ICAgICAgICAgICBicmVhazsNCj4NCj4gICAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExC
Og0KPiArICAgICAgICB0cmFjZV92dGRfaW52X2Rlc2MoInAtaW90bGIiLCBpbnZfZGVzYy52YWxb
MV0sIGludl9kZXNjLnZhbFswXSk7DQo+ICsgICAgICAgIGlmICghdnRkX3Byb2Nlc3NfcGlvdGxi
X2Rlc2MocywgJmludl9kZXNjKSkgew0KPiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAr
ICAgICAgICB9DQo+ICAgICAgICAgICBicmVhazsNCj4NCj4gICAgICAgY2FzZSBWVERfSU5WX0RF
U0NfV0FJVDoNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

