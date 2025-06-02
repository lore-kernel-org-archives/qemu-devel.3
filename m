Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5473FC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 12:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4Up-0008RR-7a; Mon, 02 Jun 2025 08:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uM4Ul-0008Ql-6b
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 08:42:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uM4Uh-00071b-UG
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 08:42:26 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4Yar031321;
 Mon, 2 Jun 2025 12:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6LRbdBvwjbaEYcJMwKrKUNq0E048gwTWaKyZsiWNHEY=; b=
 ZJmnzmKhi9SIvV/uoEch5HGpFUne/U9JpIIveYaiwrdwAx9xwsaEjCl4cTvuemrJ
 NXWVKNK2jHVq8L+N2hnGvV4gckVUZwyer4FdgOeeEBvaEWv3gZ6WBbc2isKuqE3u
 /jHPhqN4vl7X7YoXH3HhCvONfCRMi90ekFybLDpV81RMdrYvKHZv1GH3FmtpTxdf
 7M2sxA9/XcXioyUGcE9XqpqqYEfmwkuZXkeOIzPfQoDv6IXvuuc5o+hCmOSMXgdp
 vf7XyvpULUPDbGLZiWpNocJkVLkxTSY6qu2sSnKRFuOboaY6symsxxlOjrFEczBS
 YcIl1Qrw1M6mlGP7pMXbhQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrpe2hps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 12:42:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 552BkhZv016388; Mon, 2 Jun 2025 12:42:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr77x09s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 12:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9lRjaBZji6rXFcruwGuT8VMiQfF7GkqbnDO7pnYe6ckofLyVEC7bLF7i2U2ZRdfQ1ZW00M8bzHMmisyF3JwS76yJx9UugyTmxx7xSkY7/S2fXc5vaQ+hXL0KI6dHdfo0jYcaKVdEUo6sJtS+GiXydyLCS4BekHVe/qEqaluwrbVzH+ywkDUZfm1YjAE97HMU0OXrm0uip9Z3KpKrPjUWljLJjp+G/OKqSiyhn58T8ZS3ysrWLugtzU1y+kA0oDt/FC50Qe5BARwJ8inLCRPrlp72o0bcD0jB5oWhIqp+HgUHNEDrJeagfKIBbptKG8q1S59BZGR88K22jtclrdRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LRbdBvwjbaEYcJMwKrKUNq0E048gwTWaKyZsiWNHEY=;
 b=bSRShybSMHQuWESTvedx0SWMn7Tt7v6h7IAZjmNqACQkGL+wdaXHAJCmigZpt1mQSbrR+a3xCdhlFJ841wmGLz83WgfPOrtKhK3Yb01rezoh4IepMmnRRO9Jve24OOEVv4+1+Y2GqrvxH2MvnaqvHmwBa1CBcURqcN/UF0YF8kn687r44y4uJ6J1RsC9PH60ebhsXXvmj49bJjfF4tL/TGxcqOrOkp6gH62+GRH71VuzOqNUqlAgZfy2EF/AZngdYQ6RvVrxE0XGvrXCcm9Gb+vZymvOQCPVnej2XNdjwzB+0DjBvTjMGeL2BT3IAEeVwzpcEOZPeHUTb1P3fTfk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LRbdBvwjbaEYcJMwKrKUNq0E048gwTWaKyZsiWNHEY=;
 b=MMzirketadoGXNoY1ifjKsAS+Mf1jt52J+z/lq07n7hvyn2LHIV5fGWKZ3bwZZw2+/wQ0AQxM/cfd81xNxQPAZpdZEcsWnZni9AEsesWx6coDMcho0wsO13p1qS2y1aG6i43j5BTTwpHYFKtyoCWPZFbcSCdztgOvwQgnjQtJBI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7736.namprd10.prod.outlook.com (2603:10b6:a03:574::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Mon, 2 Jun
 2025 12:42:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Mon, 2 Jun 2025
 12:42:14 +0000
Message-ID: <6e256964-e91f-4c30-adf1-765b94f09780@oracle.com>
Date: Mon, 2 Jun 2025 08:42:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/43] Live update: vfio and iommufd
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Levon <john.levon@nutanix.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <11cb31a6-7787-4496-8e92-758c6578b4a0@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <11cb31a6-7787-4496-8e92-758c6578b4a0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0294.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e2c606-0d46-48da-a8c8-08dda1d2e6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW5jdy8rTEE0dFQ5OUkxWmpDRTUzbDJXczlnZ3loSm4weHhHWHBsZVpGMnla?=
 =?utf-8?B?cFpkdzFySUZFZUZCckQrMWxSYVp4dGhtcWtyUE9RSDlqOGtoaXAyREZGWllw?=
 =?utf-8?B?cDM3TGJGZ2MwQWJSWjRyT3JNemxLRlVXTmpQNm1tSHJWbm1waUtBbDZjeldV?=
 =?utf-8?B?MldMYjBicVFwb3diVzNkcUNTaFE5VXhWMGVFYjVRbW14c2w3ekV2RmdzTE9T?=
 =?utf-8?B?VHJObDZpd1NmNHQvVFp5bjJWMk1HZmNwMHNidkdvZzhHNTFQK3QzZjJyWkNs?=
 =?utf-8?B?YWhIREdBYlRJSGlKNE1DQ2IxZmRsVzdPK1diMG5pS3VmOHk0eVozdFZqdFov?=
 =?utf-8?B?Z3hqQzEzc3FWKzdBQWpKME5GbXVERHZsRGdpaEs0Um1jSlptNUdzdjZEckJa?=
 =?utf-8?B?cTIwZXhjMDBXZmMyRzRaaXZNcGw2YXVVY0RYQ1laS3AyWUtUMHE5TDA2STd0?=
 =?utf-8?B?WSttQjhmOFJJZVJCdFU4REFqWEQ0akdpWmZmWnc0Wm1uVFRvYWUrbC9PUjB4?=
 =?utf-8?B?QWxoK2JUQkFNODNlQ1YwdkFtbGlsRTQ5RjhkMDBraGJvSFgxOUFWZG1nZWpM?=
 =?utf-8?B?V0RYM0tSSjkzVHJSQWoyMmtQR1hGZ0hWVGNleHhlQW5UZHYreCtpUFl6NU53?=
 =?utf-8?B?eE5QazhPRGI2WDFFRk8ra0t0QktZbExFQW9HdVBKd2x2eUxDRFZTWHdHTXBl?=
 =?utf-8?B?d1MyM0lYTjRLWXZqaUVOd1VjajNDWFZ2bExDaEEwZE40Zjh0TG9HTmdmc21C?=
 =?utf-8?B?bmFWclk5bTJaSmI3dVYrSFZreDVSN0JDYmdLWmtKSVo1a2tHSDg4UjJqd1VZ?=
 =?utf-8?B?NCt5OHlHZWphd1lhaUd1L1V2S05ISm03d3FTVmRVR1RicHlROEJ1YUFsUk5Z?=
 =?utf-8?B?N1BRdWJMNWFXSkFKWDljVllEeEVYUnl3NU5TQzZxaTRRb09uejQyd3ZOZWpY?=
 =?utf-8?B?SmpFK1dwUWtXeVRGL1Y2ODVZN1BFcVBheTFJZ055VnlBMnZUVmNIMHR3VnI0?=
 =?utf-8?B?cVMrM1NtL3UzKzRNS3ZsK090Z3BVaEtJV0pIUVNqc0VTU3hLdXBTNkFMWmFi?=
 =?utf-8?B?Y2txRkJTQTJvVlBNTFkxTUIwT1NUL1l2eUJXczdtSk1EeXRtaEM3VXdFSWJs?=
 =?utf-8?B?cm1CUXBORW9VV252NWNQMkpRWHpTUks1WVY2NkMvcFUzYktYUUlRUDJWTWdi?=
 =?utf-8?B?aURTVnA3Y0gwWERHaStuWFJ4MkVRM0pzSkhSY0JqWi9acGlqZUFQNTFEMzhs?=
 =?utf-8?B?U1lFSS93Wnl4TWxLTmEwVUREOWd0RUwxSEE4a2ZqdFNiTFFKaklIQUdubmFy?=
 =?utf-8?B?bEowdVIrVDFSQjErYm9CaG4rbytPbnVRb1VKT0N6S0Fod1dxbW5SRXBGSHNY?=
 =?utf-8?B?UHVJWkw3d2NjWlI1cWdjK0tqdnZuNGFLNCtHeVRlQXJqbWFHY2hvLzFXNjFq?=
 =?utf-8?B?b2pTb0d4YlJ2bzNGbktBYWdrSDQwRmJCVmlKeHhCSC9OTUdpZmM3d2prdmw0?=
 =?utf-8?B?RWhmQURBdk5qZUNFaTJKRTR0Uit6TXZ6cVVMNXQ1aldqdWxaV1pSczBKM3RV?=
 =?utf-8?B?bnVxQWp4Wk8rdFlUbWdSVEozaVJBVDU3Z09wNDlGNjFjWjVxNkdiMTVSSzJS?=
 =?utf-8?B?cVJab2VnQkxncHlnTTQwZjJaUlA0M1F4dHpQblVDQXJHSElUS0FYL01WUkZG?=
 =?utf-8?B?UnFjREQvNVZlM2MvR1NuaEV1QVRIOGs2N3BEYjQrQU5oLzdYckVQVXFVRU1X?=
 =?utf-8?B?MHBUMEd4Qmk1RHl4VUFZY1lkTkZmQ1pMSW5ZQTF3cEFRK2N6ODZadWV0Q3Z1?=
 =?utf-8?B?cGhEZ2FUMStJaFZOMElmU1NUdGFCN2haSVhhMTdVbUU4bkZESzk0QlRNMnY4?=
 =?utf-8?B?NjV1TFh2R3dKa1owdEdMU1dkQkNxK0dia3Bla0JFdzc1dm9qYlFTdE8xRHJ2?=
 =?utf-8?Q?qpbsyIlL098=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5tdFViUHZrUGJWQzE3dWJENnFEekRYNzM3L1RoVk1sR2t3UnJSYUJMc2Rn?=
 =?utf-8?B?ZUhKaFIwUXNLOVBMM09LOHhJMjdDMnZVZFEycnlJSVlncFdQL0dyQjA2QlE3?=
 =?utf-8?B?L1EvVzFodSsvb3RkcTZIR1h4blZNejU0enQ3VUUyN3JkNi9jRXRhOWpBZmxp?=
 =?utf-8?B?bytRRmFCQUFyMFZZY25PMGlnOGI5U0JmZ1BIS05VSU96d2NSZU50eExmdzRB?=
 =?utf-8?B?ZHdHT2Rpb0F6VEliYlFhZzdoQ0VVSjhiaWdteEc0UCtXMDltQ2hVcUJGKzN6?=
 =?utf-8?B?MlQxZUwvOXRDSDFvYjNvNEdEcVcvV1VvaEJRR1lvT2ZHZlI5Y1NRaDNBTm9Y?=
 =?utf-8?B?VmwySjdrUVFQRnNuaWdSSmsvL0N4M0wzZWRoaVU0a1NPVU4wWC9JWWNMMmpu?=
 =?utf-8?B?SUJ0am9vbHVPWHdzTHB1bGpzRFRhZWFXcEtVV0RXNU9aMlUybUJvei92a2JE?=
 =?utf-8?B?bXpYYnd1aGx5Y1JKTXp5VUVJd2R2RmUzSnc5cnRnZkMxcUtKaU9aRCtERmNG?=
 =?utf-8?B?R3N4cW9wNHp6bWdEc2x0aXYrVE53eUVHcy9jY1JZbjUxaFlzaUxQdUdtM2Vn?=
 =?utf-8?B?amRoNFVlYmVuQ1l1TVNKTUZwN25ucG9VUkJoM1lLdmRSemxLZ1dBZ3UzQUZG?=
 =?utf-8?B?K2krNHFTeHJTaXFsR25GVFpWT054RXJ1QlhnanhKNzB1TVJtT2Z1U241QS9m?=
 =?utf-8?B?WXM2a2RoVEtHWFRNZ0hqZk5KbTRlcGtIeUdUYStNVCs0Tno3bTlxQm1xVTUx?=
 =?utf-8?B?U2NkNHBxdkRHVmIzdEdUVzBTZVVTMVFTSy9GVW82M05OMzJ4L3JoTWhxdUI1?=
 =?utf-8?B?YXBRWjUvSHNhMGFYNU9SeUtkNXU5WURXeVRCY0tybm1CcHhIR0NUVTNZeVdk?=
 =?utf-8?B?Z2hMTm50NytPeUdvbTQ0MUgzUDhUcGZyZzZqZU5BVytQODhHR1BWOSt3cmJh?=
 =?utf-8?B?STd6UE1ONHZqVWxhVHJ5TzZaYmtmSGFnck94d0pyOWhzMUhjeDI0NFJJZHdI?=
 =?utf-8?B?a0lJdTFCdDBDSHMyUmw0MjJ5OWtvWTJiRStzMlI3OGFaclhkYzNoakxxK2pk?=
 =?utf-8?B?c0dBejJBTHpTWEhJaU1ueXJIT29NN1BIaVR4KzZIY1B3eHdSazd6TlRHT0JU?=
 =?utf-8?B?b3JoaGFkbEQ0ZGN1MmJnTmZ4eThtN3VRTjdNMjdWNkxYSUxtQkZ0enVwM0NY?=
 =?utf-8?B?Y1hPZW00MW56NkdNcjZ1ajhZOXVSMmVuRHZtd1dZRG94NS9jWlUzeWlNTnBi?=
 =?utf-8?B?TXgrMXlnS3pPL0JiUjBpUEh0Q2NnczNNV08reXl4ZS9XR2hOZjJiQlZ3MGpR?=
 =?utf-8?B?UTgvb0FoVVBTL3lsSnZqKzgzSWxyM096MUpvczdmUlhFRU5YNWNSOCtzTlBw?=
 =?utf-8?B?czUzTkFyMlVEYlJKb1U0TnZGcE9sUm5hdEs5RS92L0wwbkJ3S2lhYi9tbC9S?=
 =?utf-8?B?ODFBR2VFUHAxczFsNmRmbmxaVU43MU1vNkxhTDNKSE10MEVmemRua2Q0U28r?=
 =?utf-8?B?dEQvZ0N0andnbWlXK3pMSENvOWQ4MHF4UlZhTVcwdkdpYk9PbGdGWjIrVXdK?=
 =?utf-8?B?RzBZeXI5Sk8vZE5TU1poTG5DSEcvaTJtSHVJRUVCbTlhOTRsVGNTZE5vL0lh?=
 =?utf-8?B?SkdYekg4dnp5TW9URGJ5Y3dWdEI5ODRLMDRtcUVkVkRTNTMzdHB3dktFak5q?=
 =?utf-8?B?enVoUkZ5Y3pnQytabk5nb0s0TERWMTFRMXdlNnZ2cGdydGdIS3R2U2lZM2Zq?=
 =?utf-8?B?NURwQXlIVk1ORk96NjZYbGNqNVdWY2YyNlpZWUNBR3l5UjF2dzdVZklJMFVI?=
 =?utf-8?B?M1pVRWNQSHAxdk1Pb3NoTHdhYUZFUXJOYXhtSlB4Tkp2RCttVmlpTC9nY1ZT?=
 =?utf-8?B?bHQ0bHQyM29wNlNMVFIxa1p0ckU4ZWphbFFOd2FxNHM1cTJ2Y1NBM0RwcFM0?=
 =?utf-8?B?R3E3bCtmeFp6bUdicG1naTJHZGJseWFHL3JKZGMyTTdpNnIvYlNnbDdRWkdh?=
 =?utf-8?B?eTB5ZUNzUzl3WXZhNzVBakNoQlM0WllVdFhJaWtabU1YdEdjVVZVN0ZVUmti?=
 =?utf-8?B?NlQ2dnJCQktrNEJDQXA2NFprTGpkbjRtR1l6ZXkyVVV6dGcvd2ovVFp2RW51?=
 =?utf-8?B?ZEpUVEd1K1pkUTM0eXpQOHdMemc1Z3JCRUp3YjNsNWYreTc2UHlmcFV6ZXRz?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZYiVob8234bNM3OlsbQiCXjh5dtqvgl1ziwQUe0e4Jvu2bDgaS+ObEOQB5vd8bx+J9PxpkyddIv86FKWzm1M0YjQOerO9Vo1KaTXmd88L47w2hC29Ta37uu+Gf/e6Z8VK5I847UZN1dJU8m1SnL6GYtyioh/y9b3bOCc/GZqGZvKEDyuyh58jWfKehQ7gXXysUvj41mv+qk9QKVb3zCY9G52gkorAB/u9CtovKHzLZwH8Cf+zihXV7CDEyy+/0R/mh2NevcAVk9EQVf4zYwJPU5vmyVXTgBGb0Q6jdJVIrt9Wmj9QUXk61iRWCNr0poO62eGzzvRZ/A/pk99zZX9xvmsDRjSobMGVFX9MG3vWc6u/3fmZKCChxniPdeYtgiVpacOkkU+pv8Rc2iNOslLFJ2JeW7wTcKiv3VZccb4Tw0m4pF6ZUeDqzpgyUEQyfnCyITYlzA3xYLG4hbWxrJK5J1c9D2EwM5ggeNohvqsIGi/l+RgIf/TfrxFPxvnLuXOSWd6WoyagB9m6yFcw1y7YP6+mD9m6HEpXRfpMwXh2zaI5yy8VAE53b41xXy4O2yWf3AplGtbr+P/V7P2CvU4lt8hRzkHd8dZD2mXHb8gBqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e2c606-0d46-48da-a8c8-08dda1d2e6c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:42:14.5356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46/xdfodtHm6eKfqGwSLD3Lh+ZratEQvgqgpLOKlCO/pTsJ3ixDGJRSIKTrzF1snVglgS1ujUwTguXhrvTf3rX+5epCMtJW7Cqkf7EAzEUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwNiBTYWx0ZWRfX+pb1SLeM0gix
 tIODLODPuUwbfc9NFEMAV32Ki2l5X9OuHHbWrysIXIFbM7BfNuWwk7M6vqfqkMJlypDYB4+5eFX
 4JpArd8ICA+1NC0xe1Uu38GKZtvOXJgv2G4+v+H4AWtMVkY7wfpNij06QTRu3HL+xDp0wE78yF9
 ngNS0Ypkq/gpes/GsiIw4umBUEBrMklXcY7bWwfXmGLlxD8ik3xGch6Vsi4Seh3EFGzZlQLrKx6
 XKbO3McFmteYF8IdbdgPh+uoOfyn3ELT8/vQFC6YRLc8hsYiz37qQeLPttGTvKHV0jbTHcTBPpq
 H7kFD6U0GvfxXlo+2K7v0DQZaV1EfsOMZeZZEJ/7tl93IeZhaeKkcghJa94uj44KvLDzzOpZS21
 8Ltbcxrmg21e9O+FsSvG8WMtiY5XmJjAHaejn95c2hqTHUVaBIyuNUd8+UjZzK12/JlXxLCR
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=683d9c2c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=lmK8_gI4wwjZzcLCBzAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gufmYYgLEf6eVJotcSV0WcsHTewGvl_q
X-Proofpoint-ORIG-GUID: gufmYYgLEf6eVJotcSV0WcsHTewGvl_q
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/1/2025 1:26 PM, Cédric Le Goater wrote:
> On 5/29/25 21:23, Steve Sistare wrote:
>> Support vfio and iommufd devices with the cpr-transfer live migration mode.
>> Devices that do not support live migration can still support cpr-transfer,
>> allowing live update to a new version of QEMU on the same host, with no loss
>> of guest connectivity.
>>
>> No user-visible interfaces are added.
>>
>> For legacy containers:
>>
>> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
>> skip the ioctls that configure the device, because it is already configured.
>>
>> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
>> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
>> QEMU and update the locked memory accounting.  The physical pages remain
>> pinned, because the descriptor of the device that locked them remains open,
>> so DMA to those pages continues without interruption.  Mediated devices are
>> not supported, however, because they require the VA to always be valid, and
>> there is a brief window where no VA is registered.
>>
>> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
>> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
>> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
>> data structures, and attaches the interrupts to the new KVM instance.  This
>> logic also applies to iommufd containers.
>>
>> For iommufd containers:
>>
>> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
>> backed by a file (including a memfd), so DMA mappings do not depend on VA,
>> which can differ after live update.  This allows mediated devices to be
>> supported.
>>
>> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
>> QEMU, during vfio_realize, skip the ioctls that configure the device, because
>> it is already configured.
>>
>> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
>> locked memory accounting.
>>
>> Patches 4 to 12 are specific to legacy containers.
>> Patches 25 to 41 are specific to iommufd containers.> The remainder apply to both.
> 
> Steve,
> 
> I am considering patches 1-23 for vfio-next. This is to be able to merge
> quickly a first part because we still have time ahead of us and to catch
> issues early. It will also help John to rebase.

Cool.  Do not pull these 2, they landed in vfio-next a few days after I posted V4:
   vfio: return mr from vfio_get_xlat_addr
   vfio/container: pass MemoryRegion to DMA operations

> I think patch 16 can be simplified. If you agree, and Michael too, please
> resend just this patch. I will update the series and send a PR.

Will do, depends on Michael's response.

- Steve

>> Changes from previous versions:
>>    * V1 of this series contains minor changes from the "Live update: vfio" and
>>      "Live update: iommufd" series, mainly bug fixes and refactored patches.
>>
>> Changes in V2:
>>    * refactored various vfio code snippets into new cpr helpers
>>    * refactored vfio struct members into cpr-specific structures
>>    * refactored various small changes into their own patches
>>    * split complex patches.  Notably:
>>      - split "refactor for cpr" into 5 patches
>>      - split "reconstruct device" into 4 patches
>>    * refactored vfio_connect_container using helpers and made its
>>      error recovery more robust.
>>    * moved vfio pci msi/vector/intx cpr functions to cpr.c
>>    * renamed "reused" to cpr_reused and cpr.reused
>>    * squashed vfio_cpr_[un]register_container to their call sites
>>    * simplified iommu_type setting after cpr
>>    * added cpr_open_fd and cpr_is_incoming helpers
>>    * removed changes from vfio_legacy_dma_map, and instead temporarily
>>      override dma_map and dma_unmap ops.
>>    * deleted error_report and returned Error to callers where possible.
>>    * simplified the memory_get_xlat_addr interface
>>    * fixed flags passed to iommufd_backend_alloc_hwpt
>>    * defined MIG_PRI_UNINITIALIZED
>>    * added maintainers
>>
>> Changes in V3:
>>    * removed cleanup patches that were already pulled
>>    * rebased to latest master
>>
>> Changes in V4:
>>    * added SPDX-License-Identifier
>>    * patch "vfio/container: preserve descriptors"
>>      - rewrote search loop in vfio_container_connect
>>      - do not return pfd from vfio_cpr_container_match
>>      - add helper for VFIO_GROUP_GET_DEVICE_FD
>>    * deleted patch "export vfio_legacy_dma_map"
>>    * patch "vfio/container: restore DMA vaddr"
>>      - deleted redundant error_report from vfio_legacy_cpr_dma_map
>>      - save old dma_map function
>>    * patch "vfio-pci: skip reset during cpr"
>>      - use cpr_is_incoming instead of cpr_reused
>>    * renamed err -> local_err in all new code
>>    * patch "export MSI functions"
>>      -  renamed with vfio_pci prefix, and defined wrappers for low level
>>         routines instead of exporting them.
>>    * patch "close kvm after cpr"
>>      - fixed build error for !CONFIG_KVM
>>    * added the cpr_resave_fd helper
>>    * dropped patch "pass ramblock to vfio_container_dma_map", relying on
>>      "pass MemoryRegion" from the vfio-user series instead.
>>    * deleted "reused" variables, replaced with cpr_is_incoming()
>>    * renamed cpr_needed_for_reuse -> cpr_incoming_needed
>>    * rewrote patch "pci: skip reset during cpr"
>>    * rebased to latest master
>>
>>    for iommufd:
>>      * deleted redundant error_report from iommufd_backend_map_file_dma
>>      * added interface doc for dma_map_file
>>      * check return value of cpr_open_fd
>>      * deleted "export iommufd_cdev_get_info_iova_range"
>>      * deleted "reconstruct device"
>>      * deleted "reconstruct hw_caps"
>>      * deleted "define hwpt constructors"
>>      * seperated cpr registration for iommufd be and vfio container
>>      * correctly attach to multiple containers per iommufd using ioas_id
>>      * simplified "reconstruct hwpt" by matching against hwpt_id.
>>      * added patch "add vfio_device_free_name"
>>
>>
>> Steve Sistare (43):
>>    MAINTAINERS: Add reviewer for CPR
>>    vfio: return mr from vfio_get_xlat_addr
>>    vfio/container: pass MemoryRegion to DMA operations
>>    vfio/pci: vfio_pci_put_device on failure
>>    migration: cpr helpers
>>    migration: lower handler priority
>>    vfio: vfio_find_ram_discard_listener
>>    vfio: move vfio-cpr.h
>>    vfio/container: register container for cpr
>>    vfio/container: preserve descriptors
>>    vfio/container: discard old DMA vaddr
>>    vfio/container: restore DMA vaddr
>>    vfio/container: mdev cpr blocker
>>    vfio/container: recover from unmap-all-vaddr failure
>>    pci: export msix_is_pending
>>    pci: skip reset during cpr
>>    vfio-pci: skip reset during cpr
>>    vfio/pci: vfio_pci_vector_init
>>    vfio/pci: vfio_notifier_init
>>    vfio/pci: pass vector to virq functions
>>    vfio/pci: vfio_notifier_init cpr parameters
>>    vfio/pci: vfio_notifier_cleanup
>>    vfio/pci: export MSI functions
>>    vfio-pci: preserve MSI
>>    vfio-pci: preserve INTx
>>    migration: close kvm after cpr
>>    migration: cpr_get_fd_param helper
>>    backends/iommufd: iommufd_backend_map_file_dma
>>    backends/iommufd: change process ioctl
>>    physmem: qemu_ram_get_fd_offset
>>    vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>>    vfio/iommufd: invariant device name
>>    vfio/iommufd: add vfio_device_free_name
>>    vfio/iommufd: device name blocker
>>    vfio/iommufd: register container for cpr
>>    migration: vfio cpr state hook
>>    vfio/iommufd: cpr state
>>    vfio/iommufd: preserve descriptors
>>    vfio/iommufd: reconstruct device
>>    vfio/iommufd: reconstruct hwpt
>>    vfio/iommufd: change process
>>    iommufd: preserve DMA mappings
>>    vfio/container: delete old cpr register
>>
>>   MAINTAINERS                           |  10 ++
>>   hw/vfio/pci.h                         |  10 ++
>>   hw/vfio/vfio-cpr.h                    |  15 --
>>   include/exec/cpu-common.h             |   1 +
>>   include/hw/pci/msix.h                 |   1 +
>>   include/hw/pci/pci_device.h           |   3 +
>>   include/hw/vfio/vfio-container-base.h |  38 ++++-
>>   include/hw/vfio/vfio-container.h      |   2 +
>>   include/hw/vfio/vfio-cpr.h            |  78 +++++++++
>>   include/hw/vfio/vfio-device.h         |   5 +
>>   include/migration/cpr.h               |  21 +++
>>   include/migration/vmstate.h           |   6 +-
>>   include/system/iommufd.h              |   6 +
>>   include/system/kvm.h                  |   1 +
>>   include/system/memory.h               |  19 ++-
>>   accel/kvm/kvm-all.c                   |  28 ++++
>>   accel/stubs/kvm-stub.c                |   5 +
>>   backends/iommufd.c                    | 101 +++++++++++-
>>   hw/pci/msix.c                         |   2 +-
>>   hw/pci/pci.c                          |   5 +
>>   hw/vfio/ap.c                          |   2 +-
>>   hw/vfio/ccw.c                         |   2 +-
>>   hw/vfio/container-base.c              |  13 +-
>>   hw/vfio/container.c                   | 101 +++++++++---
>>   hw/vfio/cpr-iommufd.c                 | 220 ++++++++++++++++++++++++++
>>   hw/vfio/cpr-legacy.c                  | 288 ++++++++++++++++++++++++++++++++++
>>   hw/vfio/cpr.c                         | 161 +++++++++++++++++--
>>   hw/vfio/device.c                      |  40 +++--
>>   hw/vfio/helpers.c                     |  10 ++
>>   hw/vfio/iommufd.c                     |  86 ++++++++--
>>   hw/vfio/listener.c                    |  93 +++++++----
>>   hw/vfio/pci.c                         | 232 ++++++++++++++++++++-------
>>   hw/vfio/platform.c                    |   2 +-
>>   hw/vfio/vfio-stubs.c                  |  13 ++
>>   hw/virtio/vhost-vdpa.c                |   9 +-
>>   migration/cpr-transfer.c              |  18 +++
>>   migration/cpr.c                       |  95 +++++++++--
>>   migration/migration.c                 |   1 +
>>   migration/savevm.c                    |   4 +-
>>   system/memory.c                       |  32 +---
>>   system/physmem.c                      |   5 +
>>   backends/trace-events                 |   2 +
>>   hw/vfio/meson.build                   |   4 +
>>   43 files changed, 1576 insertions(+), 214 deletions(-)
>>   delete mode 100644 hw/vfio/vfio-cpr.h
>>   create mode 100644 include/hw/vfio/vfio-cpr.h
>>   create mode 100644 hw/vfio/cpr-iommufd.c
>>   create mode 100644 hw/vfio/cpr-legacy.c
>>   create mode 100644 hw/vfio/vfio-stubs.c
>>
>> base-commit: d2e9b78162e31b1eaf20f3a4f563da82da56908d
> 


