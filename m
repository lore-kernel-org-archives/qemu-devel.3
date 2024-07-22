Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B3AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVufb-00088Y-Dg; Mon, 22 Jul 2024 11:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVufZ-00087W-8b; Mon, 22 Jul 2024 11:09:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVufP-0004iA-W6; Mon, 22 Jul 2024 11:09:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC1OjK031944;
 Mon, 22 Jul 2024 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=/upR8xrd8bhbOcqASZ1xButsmAFUZM5jN0a3BTp+4zk=; b=
 Nz6Z+xp7r4+ZiDagJtabZwcHL1CmjtcF3lhY8qmwmOVLG/maD8Ng6mxaQ//I7nby
 Kpt0jEYyHfUB2LlupPg0CbVxlhnqePHjpvbajs1EOOfMzeCkAyxvhOftZ/DIe2L7
 AtEMamhyH/IizO/TDh7CXI8XENhsS/HhInZ0YsMqupIV1mlZZX4CxMOSmrAmuCXM
 knIMcMUSJ5cuh80NBAhGjOP4KcX1ax7Q7JTaif4DbMG0flJU01XzAVsMVkTpheox
 xiVDHcu5wiv1p8drEsAPAqj+Vjsw/s73gT8e4HUhZ0f2+bjq+JdS8PJzXF7xz2Pz
 CWfOeOM92fQuuz9ubuqCaQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpa6j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:09:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46METFrI033646; Mon, 22 Jul 2024 15:09:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2682j3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/Q+HPxPNx30l5PqBhhCP8nIF5IKw8v40+mifiyz6WFTPpLgrjZmSq8Z/GjzVQRUUkMNxELMSEn7ue7SICMWJXmpKb6KQNL/RI1zpVjRqndfVSl2Vdol0mIFJuUIfpjkJdZ+eLNM1s/t+pfp4L7HeLIdp3qAbj/hzLMD+g2sEeItmgoQIjHi7rBZxGqddRbYxmgPF/pQ9d2Ll36VOVfig0iSQKvJpaHBp/K9xqV0llyNo+f42LQpQO56KV37jLGiwdsHDsjO1cCa76MQ9gffV/5TiJAnXd0P0jV9vyEorpYDXtQLJDtdP1j6QxAgP+ysrfq64mWFUkUNKLjLaQ0jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/upR8xrd8bhbOcqASZ1xButsmAFUZM5jN0a3BTp+4zk=;
 b=OtHEe2AJK6/Hodct9k9ugIsCVffHrKZtYpWPMTxqfNkHsF0bkeSjzsLr4eBv0MwJYiLEuK8vVMvdVIgkM9K+pCGGpoJxOAf7W4bt6C2ZfLKgAHskyF/5R0bxRgnnLyIsMTArrrvS9y2dskJGlRoRqt+QrOl3anwItenU0YSuO13NFbMrQBnBsVQbilYJPU0mDVrf4Zrn/gUEYLWupsAb8q/FUMR+Ibbl0j9HXA4bjb0Aw2qhEmViOJMPy3ey8Xp7Sx2+5DcN9ybC1JTCI2pBlGBsQ3kqzhvfSQUNumqtZFVu+P74ko3o2AWBtzIc2JaPL3DhMVxvX9E5ALTWGhQr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/upR8xrd8bhbOcqASZ1xButsmAFUZM5jN0a3BTp+4zk=;
 b=erhFzGOibV3KKb/F6E4fEOtFRdewJmnUHx48b4i11Sc7LNf5GaCNcn7xWk7SN1Sn6nn4JJimLTU1kmGYxg6fWORoFgpTJP8f2Qe4bP8tyj8Kn3Dr3D5vz27gNeTWcxG22eltjXR9xM7hBo835SOpPAK2hNBy/Wjr/aLhEz4phTs=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA2PR10MB4443.namprd10.prod.outlook.com (2603:10b6:806:11b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 15:09:25 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 15:09:25 +0000
Message-ID: <3072c39e-fd1b-4cc1-a189-2aa64a1d5984@oracle.com>
Date: Mon, 22 Jul 2024 16:09:16 +0100
Subject: Re: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
To: Eric Farman <farman@linux.ibm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 qemu-devel@nongnu.org
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-3-zhenzhong.duan@intel.com>
 <40cf2370a1838b1aa1e9eb2cfc75a0543ceb45bd.camel@linux.ibm.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <40cf2370a1838b1aa1e9eb2cfc75a0543ceb45bd.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA2PR10MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: d8768ea4-a1dd-4453-365d-08dcaa604628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3RrUnQxRkVMa0hQdURJTnoxMnZCTFRUUHllWDh4MGhwQVZreE9jT0ZvbzZz?=
 =?utf-8?B?eG5XU001cHhjZ3ZiREs5OUh0MnRSa1NKZ3Irb2wrQUswYzZuZTIvd3ZPazN3?=
 =?utf-8?B?VXBTOUNKQUIwOEI1Q2MwQWU0VlMwTnViNkg1aWZQcmRFbUJaNlVydGNuV3h5?=
 =?utf-8?B?RGpwVmJyeVhVZUZhcnIxbVk3WURCdjBxN2pMNEJKcUdHd2Y2TWs3czRtNnRH?=
 =?utf-8?B?WGhMUzBkQXRHeFFaa0tNalNVTmNSOVl4WnVEUExsR0Q4Y1JqRUpraWtHaUlw?=
 =?utf-8?B?MFRYeWMvRGFSblNVamR3VzJNVm9mS1NTUG1WbVd6TlZJU1FLZUU4WGNxWTIv?=
 =?utf-8?B?SGZ0L0JvRnRaN1dNT2pUU3YvYmI1OUpxa05CSDl0K0FGVkV0MWVURml4a1FX?=
 =?utf-8?B?VGRRaHRraFdNMTFrNWE0Tm1BSG5QVmhhd1pmczNHL2wzalNGT0ZLTk1BL1h1?=
 =?utf-8?B?cE1OckJLbGUxQ1BNU2VsVmhWV3QrU3JDVmlKMW8vdG1odUVvWUZENlIwakZ4?=
 =?utf-8?B?WEkxejgycjR1bGYzamdaRi9JM1p0dTgxN29kZWNFWG5MSlByeng5TGFiZW9Z?=
 =?utf-8?B?Zk10TEx2YlJYSHFQUFc2UHpacHUwS293VHhsR01kZXZPbzhwQXg3V2lXNlRj?=
 =?utf-8?B?TjRKbEFkZC9ORDI0UTVEZ3JsU2VLVXpSSmNCbXVlUTF2bjJaYkZzWGkvclNT?=
 =?utf-8?B?ckVySFdkSytrRHdSSkhtb2wzZDRtNTVyWXB4S05pVnhUVG91N2lPQmw0Q2NZ?=
 =?utf-8?B?akV0aXRscEVjTDY2aWZWZ09JZDlFYkdzYWRWd1JJbTVqVkFISEZpZnk5Z213?=
 =?utf-8?B?QmJ5dWVsWjRPa2UrSDlERUVFMXFoTTk3WDdFdldNeTRIR2lpdHc5c01JQUtZ?=
 =?utf-8?B?d1IrbTRuOUlUeVVpMG5oYkExNlpTaEVza3Baa1R1M3VUd1I4bzlmaTV5NVJa?=
 =?utf-8?B?SVVCVzFJM1pmSU4xcTBCUVlMa0dkNW9zSyt0RWFBVDk2YzVaYjN0NnRlYVFW?=
 =?utf-8?B?cXBtSThqdzQwQWtPRHBNdkoySW14K2JwL2dFTitRL3ptY2o4L2Q1Qi9KQk5R?=
 =?utf-8?B?emhmSUI0dzlvRkdXT0VRMHJxazdtU1JCam5oV2x6MFBEbTN0N3hOcmVOYXQy?=
 =?utf-8?B?blFwVmVmYmZ4MDA1MU1xSGxIdnE5aU9JVmF0ZWpHaE9UK2p6aHZXdVMzVG1G?=
 =?utf-8?B?UWpqL2d1ZnlwK3lIMlFzTlYzYW1qbnF1SEtSNGVqTjBxVjFlbDE4VnFHS1N3?=
 =?utf-8?B?NUJjNGVLRlVBVmQ4UmEyZnJ0Y3R3NVo2MzUyRkZBMEs3ZjZvWVBwNVNXWGFP?=
 =?utf-8?B?OFJzdEt6VUZ5cnBqNThyNFpHMlY4eEpMR3pRN2czVlNwNUwxdldXcWQ4U21k?=
 =?utf-8?B?T2tBZUdWQ0RLVDVxQmg1NVBHUHB1M0oxZFRCaDNZK2xSWEhqOTRMRnBXcE02?=
 =?utf-8?B?RUhwSkNYNlZEb1RHQ044ZE5nb1RiL3BrZ0dDaG91OFJRL3VLN1lGdGtPWjNM?=
 =?utf-8?B?RjNub3k2WGxPN1p2Z0dzRkdRVHlaelY1NVFUbmk4TnVsQ1duMGdSbFU4UUZG?=
 =?utf-8?B?S3M1QTJNbDZEc1RTMGNscjF1cEhrYXdpSi9QOXBZWkdLalJkbnZ1Y0NDV2pH?=
 =?utf-8?B?K3hzNUF4ZEUydUZDTzF5TUlzRGNWV3FxR0c2WjJpNkZWM0RSaEZFSng3ZG44?=
 =?utf-8?B?b1pkLy9TbFZ1Z25YOUU5RHJBY1Jaa1diVG94SEdKQ210Y1IxWHFKd0JmYjM5?=
 =?utf-8?Q?1c0xbMqIBOVpmVprZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9BeFVFV2Rsdk56N0N4ZThDeWg4SStYaWtkemgyb3BiOENibzV2TEN5MXRM?=
 =?utf-8?B?K3VVMWFyaEhxeDFBRitpWm1oNE5IT2FUbjRpRWgrUER4dzdDR095OW5mYkxM?=
 =?utf-8?B?WTZoYU5NeGdPeWU1M1hCWEFoYTJrM1pIWlhaR2htd2ZyWmZXZVFJZVFGajR2?=
 =?utf-8?B?WXNpYWRQN1dQRnJHSVllZGlERUdNd3E2NVlLYi9yZS8zbFBVM0tDSmhEN3hs?=
 =?utf-8?B?c1ZwdUdob21yNHd3QUd3OWNQem5BYmw4NTF5Qmo3R1Rtd1E1TXlaeWxKcnBw?=
 =?utf-8?B?UHFLR2tmMjg3bDV5NWRrd2llREc3bDRPRTUrQzREdlk0NTlaTWpDMzNJU0po?=
 =?utf-8?B?R20vOVdsaEJ3bWNkS2t5OWtja1BmQWRmdHd5WVR1cEFUNHQ5WDVRRFNNTEZH?=
 =?utf-8?B?Q2V6NE9XNW1vQW84OW93N0ZSTm9iR0VyRHJaUXR5NFNhSjB3VkNnbFFPL1dn?=
 =?utf-8?B?K0FWWUNDRUJuZWZwY1lSa2ZQdFIrc3M5M05CdVRUZmk3SkZSSnFsOFJmV1p3?=
 =?utf-8?B?NE1kTWVnUzhjdmEwVGFlZmFmUzN1RFZCZ0JjcFdQN01yVjM5cmROekkybjMr?=
 =?utf-8?B?WTdWVmlsUkFheU0zMGd0QVBrT1BoUm1SaUphZUtuaGMwMUl2UDFsRm9QYlFT?=
 =?utf-8?B?U2NHSkN3S3pOL0ZnVmUrdzlVN0hPMDA2Y1oxczVpT1ppS2dtMlQyQUFxNENQ?=
 =?utf-8?B?YTdRaFZqWU1zNXlyeWNpSXZmVTFSbUVwNllnZ090eDBycEt0eEF0ajVEbnNK?=
 =?utf-8?B?TDYwWlFENkora3Job002NVZHem5BSDJ3S0I3YWNHK2E5VnJUU3lNalVBSkdW?=
 =?utf-8?B?b0ExQUxoaGNFajJOUitVaXd4RUJudG5yTGkrMXB3N2NYbkUvZDMwemFWWmIr?=
 =?utf-8?B?WGVLSHFaeGxVS2dBNGtrblpCY2Z2bG9Ncmg3QW5kMlJ0eUJNbStkaFVVc2NW?=
 =?utf-8?B?MmRBeEZPK09Kem1FcE1LOWRHMDRYak9OQzVCQXNla3JoNnhGL3ZERVkrNmZI?=
 =?utf-8?B?V1lXdk54ZmMycjVCTml0dEZoODYrc2RLY1dQU0htZ3VHNjRuMGw4VUprT2Vq?=
 =?utf-8?B?YytSMjBnektBZThKcnlLZTdzODlPYzN0VmxZNDBLR2FzZXNiU3dnWTNraXVv?=
 =?utf-8?B?OW1BYlBnU3NkbnhUL2c5VTQwbktDRHJ4Si8wY1Fobks5S2N4RXhyeDcxc3dC?=
 =?utf-8?B?bzl2dDE1OGNKWGJiSFAvQ09uMW1nWWpEcElibjJaZHVaanRtTHZqSVN1VHo4?=
 =?utf-8?B?NTFYQjg5SzhyR1RYbG5HaDl2OEdXbGtOcVQ5TWlCaFRyQlVKNHBNR3RpbEhw?=
 =?utf-8?B?cGRUYVIrcVVqdDRORVBRUHFnN1NtS2pMZ29oZHYybHZUckdpU2t6ZDNJeGhB?=
 =?utf-8?B?cWpJV0M2NEVIT1JUdTBGMjVOa01hZURvamRLM2htTFNwOWNZQkRBWEh4Yzlk?=
 =?utf-8?B?NElNOWZTZ05ZNUEzV0FlV21LTUdPOFBoVGhGazNtdUplUWpxRldTblRMSUtl?=
 =?utf-8?B?cElDbFhKTTV0blpDSnlnZkRveTlZT2t3NjFhckJOSHF2K1V6cm40NUJSV2lq?=
 =?utf-8?B?aEdJbnJ5OTF3dVBKUXV3RU5BNHlHUzB6RVpacVViTHhrRE5hQUZuMkh6VGdG?=
 =?utf-8?B?UzlKSmt4MDdoelU0K0JNQUMzSFptZzQ0dDdObjJWNnRSQ09Pc2djSDY3eXJt?=
 =?utf-8?B?MXRrVUVuT3d3b0xQN1A3bk4weEF0cFg5ak9pK2xsVzZEeHpzM1ZmMkQrQjFj?=
 =?utf-8?B?QlJWaytCUVRMaStzN0UxMndYdHhjYkFyMDN3K0wvb2k2a2hGTndiU0pENlZm?=
 =?utf-8?B?NGZsdTNxRm5QRDd0ZzFYZWNVNHFMNCtUZENOQWNXZ3Z2UEg3bDk0TDJsUDd4?=
 =?utf-8?B?T2M3NldXelJSUGQ2TE52bE1TVklrNmtwd1NKNGFydVFYS0xoNHlOYTJBK3Zo?=
 =?utf-8?B?L2tDdHpCYTRBUFVVbzhUd3R1SUpnZThlQm1xZkliTnVOWldHM0FWZ2NtNFZz?=
 =?utf-8?B?QXMxL1ZyMUpXL1FMYlEyVkRDdktSS2lKOC9IdllZcmg1M3BETkZIVXZoV2hG?=
 =?utf-8?B?eXdEWEYySTV4aGI0NjlpZHUwNDVPenVwSEJrQ0hXS2pubFJGV2FKWlVVSTkx?=
 =?utf-8?B?YlFvQk5lU0R6ak9yMlZDRlVwU0x2K3ZLRVZVWHl6TmxaZUoyV0VHVERvM1hM?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1U1y0dH/Y3bnPk3e3IfOtQmnksCOIEuvrnuqGLxfZsde4XWQub78Xp0JfQpnm3lj0RRfCpf2/XNmjiQl4jQL6M7pPEbxSzP0Rb1bmsWtQ2koNx+/C6czuY0x2X7dRqPhuZd3oWF5mxD1OecYEtTNQG2RPFBCBJ73x98PJdblTEF9zr8Ynzqq7IRmChGbG18MbzTuWeX7Igk1kErzEjdqOz5RATEFPdD+Qf2esSAlG3XNBR+nyPSP+6PDThnMeOictrW5SjZFtf3OynwjKw2zBxonHv9DDLhVN4ckYmQJ5VLHAuBsnrHU6yg6g9qAYILdkdHAzfvxVl3NeDoJsZUUT1F+2qVUU9fUURx+P3pk2BtwxmziSEfm4WL1hFkuP7Vh2XOkXXXXRM52rZcUbwbP7aAFavTRhUFsbtA2nNgw3DzPC8P+th1gELFGCEN1iiGrmDEUT/3AyD3HvQo05irwJ0KkKd4mAI0WZPPTuZP/bSMJcvSMp7V/3AWHu3/MBhmMjhFn9XodNWS+XZYKlMBx6bPnCNe913L6K48BWPeXpg0MRXGUcBFd4Aq2T/kq6d9kdIZogEWDdofejqpRaQJ/20+WbRlfI32Ezdiwn9Y18tQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8768ea4-a1dd-4453-365d-08dcaa604628
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:09:25.2901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06nLXyIMyT+oCXcqhuGLJO+8tQuUqTUGJMJa/dGoj2ZcwnwUgY9BycghUb6zFMpsdmhK1PmkDPtO0ZjetP9EZfhO46t7W0sjsCQqJKppulw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220114
X-Proofpoint-GUID: 5ayWgJ5PWXOKLHSId1kXZXjFkGXI3NA8
X-Proofpoint-ORIG-GUID: 5ayWgJ5PWXOKLHSId1kXZXjFkGXI3NA8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 22/07/2024 15:57, Eric Farman wrote:
> On Mon, 2024-07-22 at 15:07 +0800, Zhenzhong Duan wrote:
>> mdevs aren't "physical" devices and when asking for backing IOMMU info,
>> it fails the entire provisioning of the guest. Fix that by setting
>> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
>> presence of mdevs.
> 
> Hmm, picking the two commits that Cedric mentioned in his cover-letter reply [1] doesn't "fail the entire provisioning of the guest" for me.
> 
> Applying this patch on top of that causes the call from vfio_attach_device() to hiod_legacy_vfio_realize() to be skipped, which seems odd. What am I missing?
> 
> [1] https://lore.kernel.org/qemu-devel/4c9a184b-514c-4276-95ca-9ed86623b9a4@redhat.com/
>

If you are using IOMMUFD it will fail the entire provisioning i.e. GET_HW_INFO
fails because there's no actual device/IOMMU you can probe hardware information
from and you can't start a guest. This happened at least for me in x86 vfio-pci
mdevs (or at least I reproduced it when trying to test mdev_tty)

But if you don't support IOMMUFD, then it probably makes no difference as type1
doesn't do anything particularly special besides initializing some static data.
The realize is skipped because you technically don't have a physical host IOMMU
directly behind the mdev, but rather some parent function related software
entity doing that for you.

Zhengzhong noticed there were some other mdevs aside from vfio-pci and in an
attempt to prevent regression elsewhere it posted for the other mdevs in qemu.

	Joao

