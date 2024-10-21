Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB96D0E6C7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nQN-00040E-GA; Mon, 21 Oct 2024 04:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1t2nQC-0003yt-Bz; Mon, 21 Oct 2024 04:05:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1t2nQ9-0001jS-OL; Mon, 21 Oct 2024 04:05:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L1tiab018402;
 Mon, 21 Oct 2024 08:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=yqn6dnNHK6SDL1/exTXSA689Ogvb6Cte5a4e5L5P/ys=; b=
 LCtmmXuj9Gz4tDgzPvhzCrq+awquyv1HrzAUrmYr9wixPTg7NZ+bppo61l4t+geV
 /+oySMkmVaNGCKpMvPYYIKApBFH7n8w+xN+9dMLE71CvWb2BQtwrN8V9AVDurljb
 vo9oBQ5I3CaD/YV81XoOAxWou1kxhhVEo6dimOH/4LkVdNnkWUE0sTLToulp8+N7
 ZgV2yEdP64EGlzGxeX0F1wiXoLQDXx1mGwk1UHDGAbpK+hRmhl6v5qQ57133oRj1
 wIgiq7QNtfkSRbVYjPBFVxcTi+Gh5q+4T1eZM9whjBnBm0SM5Mp/R8LnyPN0+nv0
 J0AA5QBMl7Zi+Ku/iLxl2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qag0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 08:04:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49L6ZpBS007653; Mon, 21 Oct 2024 08:04:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42c37611wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 08:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZqcY95QfaVEa9eN+juYpAXs4ys44egc2IHKdm5Bamr3+c7QjGI7eljppc5+gy7K8AbzMFjxLqhs+gRNAtropw32gAOoy7yIaczFjI3gUKCUB56pwtY1bg3sjpJCqp3Y7pRt4rFjAj/epOElHZ4gtY9AaJJKwZTuj66AIiIocZz50FBUjzPDRx8OTXvzHPQ8jKOU030f0h2mm33vrnAKMRWuIqG02Pi3bbsSEujaMHowAqV0vXc4JJs2OUDRxCPdceCexHhdupqtvo+J3EgnWtzXYGmNgE2/REnT8xqlCmbjYRTojU8ODYlOWIZ3fu3onb96irhGeoZlESpcNarLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqn6dnNHK6SDL1/exTXSA689Ogvb6Cte5a4e5L5P/ys=;
 b=u3cMPr/5Xk3oEnMGxI6jAcPZzPa3QAVnZ7xJGJ6Fwwd8d2WOUzyVkOVXq4p4aJlXRrIxjArZkWqWVPGAxbLde7LL4HU7+oXTCy0QW1ZWGCVrPBH6Ed9TIuh5SWcaHj2xrV+Hiyad4ZrQc7/4+5S+C1Fh01U8knpYLoCB/XY6sg1HzJEUI0tKtP30YFnqmPoBJxrozjz0gUJBvsuQnXi4HtsUySr4B2jCFB1iiuR+a18rabwRGz9tcbNvhCjj8Sb7eAI4fK+BMiqCuGS8xgcXS6n12/3zdvjjF6DNt+8EBS92I+XG8wzLgukLvkYoF98HUGWFJ8uHZd90V6wphtpk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqn6dnNHK6SDL1/exTXSA689Ogvb6Cte5a4e5L5P/ys=;
 b=I/M8cb69eM9MUZD0QlEtxf3LGOjPk28dzTmVQ3kVXjhZXBY7miwcH5ps7n8AC8tR+0SGCs3CG6pWs1zrm3ORFXEJ95K5TmGN8OEfSIbzHUxZ0PMKchmxbyuhOSpuJIWo6nmhiBe7R02n4grx6WecQvrpvcGQXnSohBMJtDipTpE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:04:52 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 08:04:52 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
CC: Salil Mehta <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Eric Auger <eric.auger@redhat.com>, Will Deacon
 <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
Thread-Topic: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU
 Hotplug (on Archs like ARM)
Thread-Index: AQHbHm56whvhiJQb3U2TrOaR1/5F77KIJrkAgASqwgCABBFrgA==
Date: Mon, 21 Oct 2024 08:04:52 +0000
Message-ID: <2033A23F-0516-4C2D-BD28-CF130AA4E086@oracle.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <B1CFD37B-3422-4766-A5EE-64D000FDEC2B@oracle.com>
 <b2593ab0-f5b2-46fe-8a8c-3725598a6ae1@linaro.org>
In-Reply-To: <b2593ab0-f5b2-46fe-8a8c-3725598a6ae1@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CY8PR10MB6825:EE_
x-ms-office365-filtering-correlation-id: 6e9a9fe4-f876-4cd3-1ac3-08dcf1a70aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YklDNU5LM2JRMW40VVc3Q04wOTFLWGdiNUJhckdGckRjYzMzdThkM0hvK2l0?=
 =?utf-8?B?bFBmV1VOMDl0ZFZBdUM0S0o2L3RyaHkwaCtrSndrYlRmcGd0SDQwSmdGQzRr?=
 =?utf-8?B?S0FyYVFEaFF1TUNPZ3Y1cDViNnozRTlJcHJHemNPMlByMWFJWWFRQytRVnY4?=
 =?utf-8?B?bVJ1WFVibEFSQWZWNFBrOFVxQ1Z4TXBoNXBWV2ZBcEt1YU4yaEU0bmN3Zlky?=
 =?utf-8?B?L1JMMldhS2t2SjlaM2hyQU4rQU9nUG9vRGNRUkZYWnpwWVk2bXVzM1VLb3dm?=
 =?utf-8?B?Ylk2YmJBUHNjUXNJcTQ4SnZOb0RqcStSZUhNSHhXQm5KUUhqbkV2U3NaVzhp?=
 =?utf-8?B?eXBHc0FVYXYwMGZqbUFJcUJxTFZJdkFERVJienZobU40TVpzd2RPenExODU1?=
 =?utf-8?B?cmRtQk50VmhsZmxRZjNBMm5teFV5eWZJT3VEMTcxZHNST1hFS2NIZmJtYXNI?=
 =?utf-8?B?UlpISTlnU0d6YlkwczR6eEJ3RzBZT2Q3Y2U5SjE3WVhCTjZ3Z0lUVldUNHpV?=
 =?utf-8?B?Y3czZjRmaVQ4SGdka2gzNEliRDdQUklHbndiUElRQlBpc0JSb25GNlBEUi90?=
 =?utf-8?B?bnJDZ045VGVYaEk0TEluN05QY1RXRE00ZVZIcG1BUGVmNFM2SGYyOGtNNFpF?=
 =?utf-8?B?bDQ0OW1ONUZVUTBSUS9MSFIvL09KcVYwK2lpOVNDQkRIWFVDM3JKSis0MUpY?=
 =?utf-8?B?aUtlaEsyM2RHek9qRmYzaTBhYjMrd0tmUmhzczQ4WWp4Uk5zYm9xUytNbzAv?=
 =?utf-8?B?NWE3eEt0NE83aVRIVGxoUXdmbmV6cnVXeHptSkNXNnQ3dVI2UE1lcDBveCtD?=
 =?utf-8?B?NnBiYjdGZnowMVczY1NDRktQaWFRQnhvSVlTanJJdjJTdGtrMXhiR1hoQkdO?=
 =?utf-8?B?Z25hN0JQeHJ4SWF1MjNHaUxhT0lGcWRGODZRUHlYSVphUGlkQUs1M0hoUDBu?=
 =?utf-8?B?NktlVW5WOWg3RmloVTJjWTVQQ1lBUllDTlEwSUdEV2V0QXo5TGhPZUxYeDFs?=
 =?utf-8?B?RXFhUzgxZjVSR1VOTHpVQTVUdHdNbVlMckJJd29NVkh6U2N5OTFTeHlHZWZr?=
 =?utf-8?B?U2c1andrbnlNTXhkd3NPMkVFUHUvVDBDcGtEQUMzYVVJNTBSQWlxTGZHWFZG?=
 =?utf-8?B?UDArbjJKbFRLakFsYzhVSFFzZXpSalJBdCtWc3JqS2doRlh2S0VkMWhOV0RQ?=
 =?utf-8?B?Vlc2V1BsUzg1dkpudW55elJ0ZWFWbjF3b0RsTHF4SEFMM2xralVDQ0V2K0Vw?=
 =?utf-8?B?cCtDWk1aU1IzdVpTUU04UC84YThOU3pWanltZllpdExtbXhWUVFicG5MMW9O?=
 =?utf-8?B?Y1NVVkV5R01COTVsZjc1bk0wN0xWN0Y3L0VOTXNWazh0QkJCU2ZEWTgvZURU?=
 =?utf-8?B?THhtbGNUeis0OWpMemh4Z0dUVnQ0RzNUSlZUZlhmNnM4ZTJPKzJUTzhoWVhR?=
 =?utf-8?B?M29PRWM3OCtvbC9yanR6emNoeXNyeG5UUXNROHZZZWpSRkl6bnpLbmdzREl2?=
 =?utf-8?B?ZjA5SDR5WFFEQzRlSVZRNVNBQy9nUlFYZlp0NUNsYnFONkUrUFp3Nlh6SFBk?=
 =?utf-8?B?aXQvd0JhdUxkbHlQNmJnMlJEUUUvR0l6a04rZ0JXQUR2b2lxcjNBNWpCYnBk?=
 =?utf-8?B?NEoxdmtrUktpTVFHOTFRdWxqRFlLR2pXa3kxbUY0bUJtSkZpMWF5TEN2UFRX?=
 =?utf-8?B?QkYzTzdLZUNtODBFNmV2ZUozOTFEeHJxR2Z0ai9sRTlvTStqYlcrWElzcytR?=
 =?utf-8?B?cHJ2MHVyMDM2R0IwcnRvalFuVm9LZ2xYMjhCdExWV0dJVm1LaUUyamJYbys3?=
 =?utf-8?B?azdGdC93R1ptZjVvaEhSZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2grWkJQUGh2ZDJtUU1SM0I1U0p2UXZDODJXMGZkNG5USnNRWml0THZqQ1h3?=
 =?utf-8?B?NVNvQ1B4dmg3cDFoYW0yeno2VVdrY09ocWxKdnkvL2pVRG1hei84aFQ4S0Ri?=
 =?utf-8?B?TkFRaE5KSW9FV25ySXlLVjYxMC90WkZNdDdtUmEwc3FsVlVrMU1CcjkyVk8v?=
 =?utf-8?B?Mngrb2dPLytUaVlIUWVicHBLdDBMNlJyYWNQeEx2Wk5KYUlnMkh1dUNMM2tM?=
 =?utf-8?B?YlNDME5pWW5TREppMFQrcG9lbDR3OWxhNzFYQVI0Ukh1STJ4ZW9JNGhualJI?=
 =?utf-8?B?SmxCdkFjd3oyTGN4cU1JV3ppc2pLaHViME9oNEVkZW5FK3pRalQ5bUpDNXpv?=
 =?utf-8?B?T3BLLzdoQy96UElyOVk4RlZORlBrSHQzeG50eFBaQ0dtZFBwcUcwZ0lrRWdo?=
 =?utf-8?B?ODdIS0t5SXJmTzF3VlhCeTBub3RhV3Z0QjJaNWsxeTQrcTZmay9WV2tyNEhr?=
 =?utf-8?B?NC9od0FUQU9FVGU1aklpQkVZYW14cXlpbm5kbm13VUs0akJ4Z1IrREZTSjds?=
 =?utf-8?B?alFNVkJqMW9neGh6ZVU3S01LV2FHcTBkUjhESlFFQ1hsM2tFRElVM1lNRzZs?=
 =?utf-8?B?c1V3cE9zZk9GbTNwcmtmRy9mbjNrRzNWY3NUS0I3M2tabFRzRi85RERFUGJS?=
 =?utf-8?B?QmNZZ1ZwbmJSRzlhUmhmcmdOb0RYd09NWGxlRVFrSHNKQjhKc09NMVBYNVhH?=
 =?utf-8?B?UkhuZzFOQ3VRTzcwTGVDQi95U09KU2ZhSWVGek95SmFuZ2FkL3dJRnJRcHRn?=
 =?utf-8?B?aTRyb2ZIYlJBckhRdVpPLzFtMDNucXJyMFdiNld2djRDYmRLMWZNd1N5UE96?=
 =?utf-8?B?MzZiVGRIMkhJRXR5RE9ielNuaHdCMFVWVE0wYllPUFNhMHBiN0s5a1JHMml2?=
 =?utf-8?B?OFZVQ0pQSXcybUQzM3dRbXJ6K0UzL1VrTU1lakdleHpsQXpJMDc5RFQ1bGNK?=
 =?utf-8?B?VGFtSUYybUhYTjZXZ3FMN2VqRlExdkZuUDlSaExrUUdQNDdUMWNrN25nQTJs?=
 =?utf-8?B?YnRIQ3NoWnFwTVNsWUFIbjdhTVdjZWR5K1huQXhWOHFZSjU5a0dac1VoUVp5?=
 =?utf-8?B?SEtYb2dER285dCtjWEUxMU4zMktISzRpVlpScEtqcWl0Y3NaT1gydThGNXYw?=
 =?utf-8?B?R1ByeGRYS2tmM0wzTVlxTnRCaEY0VXVaMU5oUjlsY1hEdkxwdEtmYVhUSGxk?=
 =?utf-8?B?NU5rTE1xbkFlRkEvZE43Zm5ZalNaUThEYzAzb2NMWEl4MHpmYzk5Q001d3dV?=
 =?utf-8?B?bFFLN2xqM01QcjIxd0U2U0lubVNCd3FqdUovQnRIZk42SHhzRnN3UnBWWjEv?=
 =?utf-8?B?bDVnZVFCeVc4UW1wRjVRQW1mRUxTQlpxaWRJZGNsbGhjQ1JDL1ZiUDczT0xs?=
 =?utf-8?B?c0dBN3pITTlrNDY4S3BYUTBPeU1tWFN3bEM3T0tJQnY4MmN1Y3lwUjBSS2VF?=
 =?utf-8?B?cFQzWnNTWmlqc1AvVCtucVU4bjJielByQkZIZHBZTk5wbDZEZUZISzZUSUNq?=
 =?utf-8?B?R3dadUV6STJYamVLYWtOU3JkVnZVamxtRG1ITlNZYmdnYklRR0lkL2pjb2JX?=
 =?utf-8?B?RHNZNytPQVJQc1VzV1JETFp1ZlVab21zWDJYclJnTVR6N2toWmVSVklmNUgx?=
 =?utf-8?B?K0lBdEZQM1ZOK2h5aGErWnlRdFZsNGlRMS9ZOW03V1EwMlNpU2pKMjVSdG80?=
 =?utf-8?B?dk1rTU5MMTd0OC9KdzE1dEtXclFWQS9tamVQSjhqSVE1ZVcrSlZkdDlVRkxo?=
 =?utf-8?B?VjJ1NkFKL0lmUURPRFdad29SQm8wZ2grd3hwSkZkS09hZWxoM2FsQUNWUTlY?=
 =?utf-8?B?RThYZWtsRjVYKzVTZjV4SjhQUW5zSHFCK05xYTYxdHNEQmFrNGVaMEp2Mmo2?=
 =?utf-8?B?L3pWUHBNYXBHT2xDY0cyaERUSjk5N2djNXpSRi9PRkk2WUcyenBROHFLWTI0?=
 =?utf-8?B?bjlsS1VmTTRyQ255RjZMbnpsUjcrT0w2U0RnMnBYSXNFU0lHL0N4NTdTZ1Yw?=
 =?utf-8?B?ekNYTC9iQ3kxeDV1cHRYell0QTlITU85VXlRWHNETHFrenhyN3dBOXNOdGdD?=
 =?utf-8?B?ejJzSmMzdFBXM3pBeXFoMUhkcUh1QUFkNklSTXp2NGowYmJBeVcxdmdMUkpi?=
 =?utf-8?B?ZGt6T0w0aTZMUkxValZkMmtzaDFFZUJaWm5zbm9HdEVtblhGQzErK2lsckpW?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A840D59A0878874D8681E550B0EE2579@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vSbccUw6CFP7xdpI5pR2hMR9tNW6AbnVmRK1DyV+1iZnXkM3rQycEQztFrR49mZ0MirmN8GQNv7zsBgFtNcNhbCDlMA8pLU3J+hF2xy+XcbcdjcvFHvF79Id+B6omSqJEdjQ6hxJaUcDMM+vdcerwk6PgQcGgWDF/zZDmpeDmvAOw0h3fQBevfV7DnEJm0qzR4f+wwdKPv06sh7sIkIHfrEcYZHWz9NlVswkVXcP7N9u79/i7x6W8n4ofn5v/PI2MPKlCHzqcMtmQkE8gBASaKWCqCyXQ9fVK5oxDDM0eyXYmcRMQUVuCRvQ8RxBKfRqRh0pRZz0TyIPAk+k2+4NeY1u9iVFG8Zxkd3Bs0PKNZPxxsoXTWXJ5wUJEMMh97dRStUCRcrycT9fgfZSWLKfXG+ftLrrgnRcUFHZfbDy8sSMLyGPJMe/AKMTxHA8fVhgZNf0rufN5bOw/bbBQ4RwknzgxwkOsJtMV5LkeDF2BCa5mc6CF0YsjaoFGtagqGkDZQ3Teh6FoIzRtPORgEmUNokul+9Z39sjcboTFaRsnTVM7UKpnRagH6Add+aiWkOZmXckz3Vh9vPzYjNlbB+eBmK5ShVJMBd/FztMx0QTRgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a9fe4-f876-4cd3-1ac3-08dcf1a70aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 08:04:52.4411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRnWHyZJXekLEbidXoW5A+pSKW5pytyZiLxjloXIOaP6lMxT4wGJHFIt31D1dY+DrEjL3n3Xdz2uQh0kilxmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_04,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210056
X-Proofpoint-ORIG-GUID: K9NWBhEgK1UyQXhDGOoFwSPUKYP4TjA_
X-Proofpoint-GUID: K9NWBhEgK1UyQXhDGOoFwSPUKYP4TjA_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgR3VzdGF2bywNCg0KPiBPbiAxOCBPY3QgMjAyNCwgYXQgMTc6NTcsIEd1c3Rhdm8gUm9tZXJv
IDxndXN0YXZvLnJvbWVyb0BsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+IEhpIE1pZ3VlbCwNCj4g
DQo+IE9uIDEwLzE1LzI0IDE1OjQxLCBNaWd1ZWwgTHVpcyB3cm90ZToNCj4+IEhpIFNhbGlsLA0K
Pj4gSeKAmXZlIHJhbiB0aGUgdXN1YWwgdGVzdHMgc3VjY2Vzc2Z1bGx5IG9mIGhvdHBsdWcvdW5w
bHVnIGZyb20gdGhlIG51bWJlciBvZiBjb2xkLWJvb3RlZCBjcHVzIHVwIHRvIG1heGNwdXMgYW5k
IG1pZ3JhdGlvbiBvbiBBUk0uIFBsZWFzZSBmZWVsIGZyZWUgdG8gYWRkOg0KPiANCj4gRG8geW91
IG1pbmQgc2hhcmluZyB3aGF0IGNwdXMgeW91IHVzZWQgZm9yIHlvdXIgdGVzdHM/DQo+IA0KDQpO
b3QgYXQgYWxsLiBJ4oCZdmUgdXNlZCAtY3B1IGhvc3QgYW5kIC1jcHUgbWF4LiBJIGhhZCB1c2Vk
IFJGQy12NSBmcm9tIFsxXSBpbiBvcmRlciB0byB0ZXN0DQp0aGlzIHBhdGNoc2V0IGFzIHRoZXkg
YXJlIGF0IHRoZSBiYXNlIG9mIGl0Lg0KDQo+IERpZCB5b3UgdXNlIHRjZyBvciBrdm0gZm9yIHRo
ZSB0ZXN0cz8NCg0KSeKAmXZlIHVzZWQgYm90aCBpbiB0aGUgZm9sbG93aW5nIGNvbmZpZ3VyYXRp
b25zOg0KDQotTSB2aXJ0IC1hY2NlbCBrdm0gLWNwdSBob3N0DQotTSB2aXJ0LGdpY192ZXJzaW9u
PTMgLWFjY2VsIGt2bSAtY3B1IGhvc3QNCi1NIHZpcnQsZ2ljX3ZlcnNpb249MyAtYWNjZWwgdGNn
IC1jcHUgbWF4DQoNCkFuZCANCg0KLU0gdmlydCAtYWNjZWwgdGNnIC1jcHUgbWF4DQoNClRoaXMg
bGFzdCBvbmUgcHJlc2VudGVkIGRlZmVjdHMgaW4gUUVNVSBvbiBiZWhhbGYgb2YgUkZDLVY1IGJ1
dCwgaWYgeW91IGRvbuKAmXQNCm1pbmQsIGluc3RlYWQgb2YgbWUgdHJhbnNjcmliaW5nIGV2ZXJ5
dGhpbmcgaGVyZSwgY291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vaw0KYXQgWzJdID8NCg0KSSBj
b3VsZCBoYXZlIGdpdmVuIG1vcmUgZGV0YWlsIGZyb20gc3RhcnQsIGFwb2xvZ2llcyBmb3IgYW55
IGNvbmZ1c2lvbiBvbiBteSBwYXJ0Lg0KDQpUaGFua3MsDQpNaWd1ZWwNCg0KWzFdOiBodHRwczov
L2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVtdS9jb21taXRzL3ZpcnQtY3B1aHAtYXJtdjgvcmZj
LXY1Lw0KWzJdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzMwNDc4QjE4LTkz
MkQtNDEzQy1CRkYwLTVGRDcwNTEwRDlENUBvcmFjbGUuY29tLw0KDQo+IA0KPiBUaGFua3MhDQo+
IA0KPiANCj4gQ2hlZXJzLA0KPiBHdXN0YXZvDQo+IA0KPj4gVGVzdGVkLWJ5OiBNaWd1ZWwgTHVp
cyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCj4+IFRoYW5rcw0KPj4gTWlndWVsDQo+Pj4gT24g
MTQgT2N0IDIwMjQsIGF0IDE5OjIyLCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNv
bT4gd3JvdGU6DQo+Pj4gDQo+Pj4gQ2VydGFpbiBDUFUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljYXRp
b25zIFsxXVsyXVszXSBwcm9oaWJpdCBjaGFuZ2VzIHRvIHRoZSBDUFVzDQo+Pj4gKnByZXNlbmNl
KiBhZnRlciB0aGUga2VybmVsIGhhcyBib290ZWQuIFRoaXMgaXMgYmVjYXVzZSBtYW55IHN5c3Rl
bQ0KPj4+IGluaXRpYWxpemF0aW9ucyBkZXBlbmQgb24gdGhlIGV4YWN0IENQVSBjb3VudCBhdCBi
b290IHRpbWUgYW5kIGRvIG5vdCBleHBlY3QgaXQNCj4+PiB0byBjaGFuZ2UgYWZ0ZXJ3YXJkLiBG
b3IgZXhhbXBsZSwgY29tcG9uZW50cyBsaWtlIGludGVycnVwdCBjb250cm9sbGVycyB0aGF0IGFy
ZQ0KPj4+IGNsb3NlbHkgY291cGxlZCB3aXRoIENQVXMsIG9yIHZhcmlvdXMgcGVyLUNQVSBmZWF0
dXJlcywgbWF5IG5vdCBzdXBwb3J0DQo+Pj4gY29uZmlndXJhdGlvbiBjaGFuZ2VzIG9uY2UgdGhl
IGtlcm5lbCBoYXMgYmVlbiBpbml0aWFsaXplZC4NCj4+PiANCj4+PiBUaGlzIHJlcXVpcmVtZW50
IHBvc2VzIGEgY2hhbGxlbmdlIGZvciB2aXJ0dWFsaXphdGlvbiBmZWF0dXJlcyBsaWtlIHZDUFUN
Cj4+PiBob3RwbHVnLiBUbyBhZGRyZXNzIHRoaXMsIGNoYW5nZXMgdG8gdGhlIEFDUEkgQU1MIGFy
ZSBuZWNlc3NhcnkgdG8gdXBkYXRlIHRoZQ0KPj4+IGBfU1RBLlBSRVNgIChwcmVzZW5jZSkgYW5k
IGBfU1RBLkVOQWAgKGVuYWJsZWQpIGJpdHMgYWNjb3JkaW5nbHkgZHVyaW5nIGd1ZXN0DQo+Pj4g
aW5pdGlhbGl6YXRpb24sIGFzIHdlbGwgYXMgd2hlbiB2Q1BVcyBhcmUgaG90LXBsdWdnZWQgb3Ig
aG90LXVucGx1Z2dlZC4gVGhlDQo+Pj4gcHJlc2VuY2Ugb2YgdW5wbHVnZ2VkIHZDUFVzIG1heSBu
ZWVkIHRvIGJlIGRlbGliZXJhdGVseSAqc2ltdWxhdGVkKiBhdCB0aGUgQUNQSQ0KPj4+IGxldmVs
IHRvIG1haW50YWluIGEgKnBlcnNpc3RlbnQqIHZpZXcgb2YgdkNQVXMgZm9yIHRoZSBndWVzdCBr
ZXJuZWwuDQo+Pj4gDQo+Pj4gVGhpcyBwYXRjaCBzZXQgaW50cm9kdWNlcyB0aGUgZm9sbG93aW5n
IGZlYXR1cmVzOg0KPj4+IA0KPj4+IDEuIEFDUEkgSW50ZXJmYWNlIHdpdGggRXhwbGljaXQgUFJF
U0VOVCBhbmQgRU5BQkxFRCBDUFUgU3RhdGVzOiBJdCBhbGxvd3MgdGhlDQo+Pj4gICBndWVzdCBr
ZXJuZWwgdG8gZXZhbHVhdGUgdGhlc2Ugc3RhdGVzIHVzaW5nIHRoZSBgX1NUQWAgQUNQSSBtZXRo
b2QuDQo+Pj4gDQo+Pj4gMi4gSW5pdGlhbGl6YXRpb24gb2YgQUNQSSBDUFUgU3RhdGVzOiBUaGVz
ZSBzdGF0ZXMgYXJlIGluaXRpYWxpemVkIGR1cmluZw0KPj4+ICAgYG1hY2h2aXJ0X2luaXRgIGFu
ZCB3aGVuIHZDUFVzIGFyZSBob3QtKHVuKXBsdWdnZWQuIFRoaXMgZW5hYmxlcyBob3RwbHVnZ2Fi
bGUNCj4+PiAgIHZDUFVzIHRvIGJlIGV4cG9zZWQgdG8gdGhlIGd1ZXN0IGtlcm5lbCB2aWEgQUNQ
SS4NCj4+PiANCj4+PiAzLiBTdXBwb3J0IGZvciBNaWdyYXRpbmcgQUNQSSBDUFUgU3RhdGVzOiBU
aGUgcGF0Y2ggc2V0IGVuc3VyZXMgdGhlIG1pZ3JhdGlvbiBvZg0KPj4+ICAgdGhlIG5ld2x5IGlu
dHJvZHVjZWQgYGlzX3twcmVzZW50LGVuYWJsZWR9YCBBQ1BJIENQVSBzdGF0ZXMgdG8gdGhlDQo+
Pj4gICBkZXN0aW5hdGlvbiBWTS4NCj4+PiANCj4+PiBUaGUgYXBwcm9hY2ggaXMgZmxleGlibGUg
ZW5vdWdoIHRvIGFjY29tbW9kYXRlIEFSTS1saWtlIGFyY2hpdGVjdHVyZXMgdGhhdA0KPj4+IGlu
dGVuZCB0byBpbXBsZW1lbnQgdkNQVSBob3RwbHVnIGZ1bmN0aW9uYWxpdHkuIEl0IGlzIHN1aXRh
YmxlIGZvciBhcmNoaXRlY3R1cmVzDQo+Pj4gZmFjaW5nIHNpbWlsYXIgY29uc3RyYWludHMgdG8g
QVJNIG9yIHRob3NlIHRoYXQgcGxhbiB0byBpbXBsZW1lbnQgdkNQVQ0KPj4+IGhvdHBsdWdnaW5n
IGluZGVwZW5kZW50bHkgb2YgaGFyZHdhcmUgc3VwcG9ydCAoaWYgYXZhaWxhYmxlKS4NCj4+PiAN
Cj4+PiBUaGlzIHBhdGNoIHNldCBpcyBkZXJpdmVkIGZyb20gdGhlIEFSTS1zcGVjaWZpYyB2Q1BV
IGhvdHBsdWcgaW1wbGVtZW50YXRpb24gWzRdDQo+Pj4gYW5kIGluY2x1ZGVzIG1pZ3JhdGlvbiBj
b21wb25lbnRzIGFkYXB0YWJsZSB0byBvdGhlciBhcmNoaXRlY3R1cmVzLCBmb2xsb3dpbmcNCj4+
PiBzdWdnZXN0aW9ucyBbNV0gbWFkZSBieSBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQu
Y29tPi4NCj4+PiANCj4+PiBJdCBjYW4gYmUgYXBwbGllZCBpbmRlcGVuZGVudGx5LCBlbnN1cmlu
ZyBjb21wYXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgaG90cGx1Zw0KPj4+IHN1cHBvcnQgaW4gb3Ro
ZXIgYXJjaGl0ZWN0dXJlcy4gSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIHNldCBpbiBjb25qdW5j
dGlvbiB3aXRoDQo+Pj4gdGhlIEFSTS1zcGVjaWZpYyB2Q1BVIGhvdHBsdWcgY2hhbmdlcyAoaW5j
bHVkZWQgaW4gdGhlIHVwY29taW5nIFJGQyBWNSBbNl0pLCBhbmQNCj4+PiBldmVyeXRoaW5nIHdv
cmtlZCBhcyBleHBlY3RlZC4gSSBraW5kbHkgcmVxdWVzdCBtYWludGFpbmVycyBvZiBvdGhlcg0K
Pj4+IGFyY2hpdGVjdHVyZXMgdG8gcHJvdmlkZSBhICJUZXN0ZWQtYnkiIGFmdGVyIHJ1bm5pbmcg
dGhlaXIgcmVzcGVjdGl2ZSByZWdyZXNzaW9uDQo+Pj4gdGVzdHMuDQo+Pj4gDQo+Pj4gTWFueSB0
aGFua3MhDQo+Pj4gDQo+Pj4gDQo+Pj4gUmVmZXJlbmNlczoNCj4+PiBbMV0gS1ZNRm9ydW0gMjAy
MyBQcmVzZW50YXRpb246IENoYWxsZW5nZXMgUmV2aXNpdGVkIGluIFN1cHBvcnRpbmcgVmlydCBD
UFUgSG90cGx1ZyBvbg0KPj4+ICAgIGFyY2hpdGVjdHVyZXMgdGhhdCBkb27igJl0IFN1cHBvcnQg
Q1BVIEhvdHBsdWcgKGxpa2UgQVJNNjQpDQo+Pj4gICAgYS4gS2VybmVsIExpbms6IGh0dHBzOi8v
a3ZtLWZvcnVtLnFlbXUub3JnLzIwMjMvS1ZNLWZvcnVtLWNwdS1ob3RwbHVnXzdPSjFZeUoucGRm
DQo+Pj4gICAgYi4gUWVtdSBMaW5rOiAgaHR0cHM6Ly9rdm0tZm9ydW0ucWVtdS5vcmcvMjAyMy9D
aGFsbGVuZ2VzX1JldmlzaXRlZF9pbl9TdXBwb3J0aW5nX1ZpcnRfQ1BVX0hvdHBsdWdfLV9faWkw
aU5iMy5wZGYNCj4+PiBbMl0gS1ZNRm9ydW0gMjAyMCBQcmVzZW50YXRpb246IENoYWxsZW5nZXMg
aW4gU3VwcG9ydGluZyBWaXJ0dWFsIENQVSBIb3RwbHVnIG9uDQo+Pj4gICAgU29DIEJhc2VkIFN5
c3RlbXMgKGxpa2UgQVJNNjQpDQo+Pj4gICAgTGluazogaHR0cHM6Ly9rdm1mb3J1bTIwMjAuc2No
ZWQuY29tL2V2ZW50L2VFNG0NCj4+PiBbM10gQ2hlY2sgY29tbWVudCA1IGluIHRoZSBidWd6aWxs
YSBlbnRyeQ0KPj4+ICAgIExpbms6IGh0dHBzOi8vYnVnemlsbGEudGlhbm9jb3JlLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9NDQ4MSNjNQ0KPj4+IFs0XSBbUEFUQ0ggUkZDIFY0IDAwLzMzXSBTdXBwb3J0
IG9mIFZpcnR1YWwgQ1BVIEhvdHBsdWcgZm9yIEFSTXY4IEFyY2gNCj4+PiAgICBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMDA5MDMxODE1LjI1MDA5Ni0xLXNh
bGlsLm1laHRhQGh1YXdlaS5jb20vVC8jbWYzMmJlMjAzYmFhNTY4YTg3MWRjNjI1YjczMmY2NjZh
NGM0ZjFlNjgNCj4+PiBbNV0gQXJjaGl0ZWN0dXJlIGFnbm9zdGljIEFDUEkgVk1TRCBzdGF0ZSBt
aWdyYXRpb24gKERpc2N1c3Npb24pDQo+Pj4gICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI0MDcxNTE1NTQzNi41NzdkMzRjNUBpbWFtbWVkby51c2Vycy5pcGEu
cmVkaGF0LmNvbS8NCj4+PiBbNl0gVXBjb21pbmcgUkZDIFY1LCBTdXBwb3J0IG9mIFZpcnR1YWwg
Q1BVIEhvdHBsdWcgZm9yIEFSTXY4IEFyY2gNCj4+PiAgICBMaW5rOiBodHRwczovL2dpdGh1Yi5j
b20vc2FsaWwtbWVodGEvcWVtdS9jb21taXRzL3ZpcnQtY3B1aHAtYXJtdjgvcmZjLXY1DQo+Pj4g
DQo+Pj4gU2FsaWwgTWVodGEgKDQpOg0KPj4+ICBody9hY3BpOiBJbml0aWFsaXplIEFDUEkgSG90
cGx1ZyBDUFUgU3RhdHVzIHdpdGggU3VwcG9ydCBmb3IgdkNQVQ0KPj4+ICAgIGBQZXJzaXN0ZW5j
ZWANCj4+PiAgaHcvYWNwaTogVXBkYXRlIEFDUEkgQ1BVIFN0YXR1cyBgaXNfe3ByZXNlbnQsIGVu
YWJsZWR9YCBkdXJpbmcgdkNQVQ0KPj4+ICAgIGhvdCh1bilwbHVnDQo+Pj4gIGh3L2FjcGk6IFJl
ZmxlY3QgQUNQSSB2Q1BVIHtwcmVzZW50LGVuYWJsZWR9IHN0YXRlcyBpbiBBQ1BJDQo+Pj4gICAg
X1NUQS57UFJFUyxFTkF9IEJpdHMNCj4+PiAgaHcvYWNwaTogUG9wdWxhdGUgdkNQVSBIb3RwbHVn
IFZNU0QgdG8gbWlncmF0ZSBgaXNfe3ByZXNlbnQsZW5hYmxlZH1gDQo+Pj4gICAgc3RhdGVzDQo+
Pj4gDQo+Pj4gY3B1LXRhcmdldC5jICAgICAgICAgcGF0Y2hlcy52Y3B1aHAucmZjLXY1LmFyY2gu
YWdub3N0aWMuYWNwaSAgICAgICAgICB8ICAxICsNCj4+PiBody9hY3BpL2NwdS5jICAgICAgICAg
ICAgICAgICAgfCA3MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+Pj4gaHcv
YWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5jIHwgMTEgKysrKysrDQo+Pj4gaW5jbHVkZS9ody9h
Y3BpL2NwdS5oICAgICAgICAgIHwgMjEgKysrKysrKysrKw0KPj4+IGluY2x1ZGUvaHcvY29yZS9j
cHUuaCAgICAgICAgICB8IDIxICsrKysrKysrKysNCj4+PiA1IGZpbGVzIGNoYW5nZWQsIDExOSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IC0tIA0KPj4+IDIuMzQuMQ0K
Pj4+IA0KPiANCg0K

