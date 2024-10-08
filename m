Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E219CED24C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 00:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxxs2-0001E6-CL; Mon, 07 Oct 2024 20:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sxxrz-0001DZ-CI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 20:14:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sxxrw-00029m-QM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 20:14:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497LQlu7011943;
 Tue, 8 Oct 2024 00:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=XL/OpxpAcesUu9x77BCoRA0TEOs+QVHqbFFkclPpVhw=; b=
 MfQ6YtdqGLFgMuDuXnVWZ259OTWAzGTr+Y+sAqD+EifaHObAADd6hfJLbz+QKfM9
 9Wni3cLrmAP+gfSI7Na/BoXFpSwJwpXJfybyARuG7fwNlfXxx2Mr8Dc4BnMZp6uA
 nQLG127LzE+ItLBsnT+g313xVHjlXq0wXYvMC7l7ZW39hHDFwBy6L5cmH7rGG5In
 UmEg8JGyVdsVFyykmoWNL1/bVLqU9O4F7bcAHonqgLB/DNP8ixSExqU0n9l62+Dm
 UCDQP7PtytSIKRbl340PHp+dApH0ec4eVj9SODo1Mu9gA7eq1z085w0K/e1U7gRX
 EzpTD2KwnZSjFM5f50B2+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dvp52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 00:14:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498008Sv011759; Tue, 8 Oct 2024 00:14:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw6fa10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 00:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbmTcp0PCDi7UH31WyraKneJVFZzKfqO6CWbNc+kIwRvVff9P3lf+K3Fyd69U0gAez27k8Ud9RO/CNOm6Byi3XFKgOru50ZS9ZIDAj6zajTN0p8qQpb6mXkli5xOhhMonlifMztVXItylQ2sGxRMF6yKs6eeJ7hjiC4Ya0ihFA6UVaz11gMk9/RS/OoVIMKJz6wZCGl7dsU/AXXxiUsGJ4tZbYUW+bMvcyhlcEONXnoeg6Ni0CR1VoeuLeGrNDTDDVku10f2lVdtkmc+MaUGx0zbPWqW9qKYHcg8DXcXAq1hdFPFPDrHClnpRRFXbXQWS4ZRKVrhOFRUMnTh+ZzMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL/OpxpAcesUu9x77BCoRA0TEOs+QVHqbFFkclPpVhw=;
 b=b5IkzqkaNVb6Pnk02yWL2IyKe6AnaKxs7BDr2jlAguKBs6EO+AzlbanEtmDfaYAJXOCdoASfQTXXt4C5kkm46ekTVVlE+Bo9AnMDWYvF7PiZAZkkKneGjwwFk/6695vtGuwa2ozLmZjoWfMCDdxo3EEk2G8bnibMCGq6pNu+ZMXE08L3PjgXgi6PWuK5LRmd3AO4jhzmD0EllvQxYfODAyGz7kY3+typBPiWMsdwQEMhKopwneNuwRnq71lS+10wVrd4yGZb+nHrtU9WhWhnbaRoqM9GmeML6mPnZpPDPSx2w86gVtDGots5ohDLAIHAza5o+RwIfazNU4/N3FEvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL/OpxpAcesUu9x77BCoRA0TEOs+QVHqbFFkclPpVhw=;
 b=a85Rt34j4sMsMieA7UyiHWQ/AsSBYRSmC+O6Gm/vn9zHXrWE+kFvDY4cbElKIEY3Z5sQZMJhNXk5vmsw0NAB01rSQnyFZlOE8bQSPDbKu7bCMpBkSwMJf+9JR3UjAjzlxLSjlUZoIViOiA727FeBDeQJiIbFiTzFyV0M1I40TR8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 00:14:16 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 00:14:16 +0000
Message-ID: <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
Date: Mon, 7 Oct 2024 17:14:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To PH8PR10MB6528.namprd10.prod.outlook.com
 (2603:10b6:510:228::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 195ad135-f984-4741-b986-08dce72e24cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDBaZHlESDdvaURibUlRUFU2aW94OEp5QStHcmppSDU0Q3lWb2hZR056UXV1?=
 =?utf-8?B?ZC9iUEgwbEZFdk1kalRucm9RSjJZNHJ5TFNNVmo1NjRabDhpbVJxVGJhUG1R?=
 =?utf-8?B?ZTdhNWNBbmxwdktjNHhOVGZmKzZhSzVWSFNzZWVTTlkyZ3VxZWEwd2dGOVJQ?=
 =?utf-8?B?OE5oSjNoNGVIMndSSGZ1bVl1elNoTUtnSlFuSUthVERTN0dycHhzamNDL1ZQ?=
 =?utf-8?B?SStOTWdDaks5bmI5WDVWdXFYbkZIUkZMUGZjUjd0K1pOUXl4cHJEYWhoMUNV?=
 =?utf-8?B?VFJuZE9EcXo2TmtKSzk3VnZvYy9iZVNlaU92NEcwcDc0RllsSlZDU0RQM3FU?=
 =?utf-8?B?S2xIWm05dXZJd1lrdWhvRUw3c0ZBWStMZEVTTmR3ZU9hbmtFQi9aR0g0b3No?=
 =?utf-8?B?ZmhZTDZITkVqckRMZi9vWjZTbExWdFJrbEtwOXdEWi84cGZuV0J5U3hpR0g0?=
 =?utf-8?B?Tzl6eE1GL01xdVhDLzduMmltVFRWWDFZNS9ZTTNlOEwzNThURXhVSDVoa1A2?=
 =?utf-8?B?eVJKMURIdVdxY3lxSHZKQmZNeUkvZC96WnZHSGF3MW5RVmtrQ2hWVXJXaUdX?=
 =?utf-8?B?cllkaE1tR09xV1RhUXNHeklSbE5va1BCTVAyUVhmYTV0UElBZmdlSFZGVTFu?=
 =?utf-8?B?ZzJINFl2cXFjak93T1VzN1R3S3hsRzZwUWdRa0lRZGY1cUZVU2VnNElhWVF5?=
 =?utf-8?B?bTliTVlMR2NFQzVCYkxydHBObUZ6VVo1d05jcE1nWVd3M1Mrc0pVSW16TUZO?=
 =?utf-8?B?ZDJMcUxaVnBPYWNBZzRkRytCc1l2Q1dBTjNlKzExakt1aWQ1RHprMFVaellV?=
 =?utf-8?B?Q21yQVFQUm9PV2NLOWREYjJSQVBCTkZlc0h2dTFGeFBwcXRBbXpRb3pPVU05?=
 =?utf-8?B?TWwvTzZpdW5oOE1IcUROeVpVNzNjUnN6U0VMa3BGSGdNVHFvOEJKNXl0RzR3?=
 =?utf-8?B?anJTTUhUeUUzSVc3RUI2bDAzRWozNDdxUStKOUhERXBOVDdJa1prcmZFdDNP?=
 =?utf-8?B?SlJTZjFGbmRCVEEzSnlhUk1nZGF4ekhITHpEUGZCbEE5R3AzcEZFWGh5OVk0?=
 =?utf-8?B?N0lsajY4eldyT25yajR0UkM5MER6d3ZrN21TTm1UZ0dMMGFkYkRsNzl4OFdn?=
 =?utf-8?B?SVcvYU8rVXoxak1ZVm9rM0V0Y0tyN2gzQ282SHQzNExya0ZFalIrMnUrQzFi?=
 =?utf-8?B?emhaTlVMSVdEU201Y042S1RoR3ErRVdmMHVLZmhHOVlwL3BCT3dyVkZKcFdN?=
 =?utf-8?B?ZGlsck45ZXN3UlV5ejNqdTk1TFZwenNWUlJZTlEvWlUramo5NzVyV3RRU3dI?=
 =?utf-8?B?ZmpmWWhWZm9RdTFhU1dYR2lMcCtNMTNEdEN5WlBxRnc2TkpwUmY2MER3cTFv?=
 =?utf-8?B?bHk1QXBHNlpYNG9RTkEwRVJOcHZvSmRrdWZ5UnFzdHZOcjNTTityTHpNTXFY?=
 =?utf-8?B?L2podWtDczROb3Vnc1RMcW9MYk16NzFkR2YwVnVKVmdCYS9HNmh2UDlOL1Zh?=
 =?utf-8?B?MzA4UVFISmI5VFA2aDArRWovZ1E1VW9FcXhvVjlMVjRUUFBTeW4yZHcwRmEr?=
 =?utf-8?B?WTFpVEZwbkxOaVEzRDRGTjllR1BkaWZPSWFUZXUrUFEwYmpLbkhBZ2d0OHFo?=
 =?utf-8?B?T3hrNzNlK2FXQmZTSTJsYTA0YW1VNFhGUzNDaTgwaDVPb0tBSkJ5SEhPQUdF?=
 =?utf-8?B?OG10bFk5Ykw4UUtpSTQzNGJaZ3pZR3JoRUhDdnUyZ1VyNnFadHAxc1BBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxSY01zc0Y0NHpIeld5YW9Faks5ZGlReUphelQrWVAvYWNFRnFUQUlNbk9n?=
 =?utf-8?B?T1FoekdPS0U4aDlyeDI3cy9vTkJJb1JoNzdEVU51NDF1Tlp0WnNRL2lBd05q?=
 =?utf-8?B?U1J3YVhlRFVqYjBQNGJsVjhRL1dPWEdnV0xCeGtrcGorVlM1clFSTGNPQmRM?=
 =?utf-8?B?WitsSERKYjNKTzhyc2lVTEdzMk5vc0lCbWZwM01JUzhXclltTEIrTml0a1pL?=
 =?utf-8?B?U2YrbGZvS0RUOFpubDdWYzlhd09tZXlHMDVmd3hmbHd1cGUxV0RhMHRQNUY0?=
 =?utf-8?B?QldrUFlCR2g4NDZsbU5oMGVGN1FwY0YveUVqbU80RHhWWUQ1Uk9BQWdWQTNJ?=
 =?utf-8?B?YjV2M2xmWmcyMkJyVVppU25pQVlkTlNsdE9Wb1BTVjB4cEcybEJOMVZTMExx?=
 =?utf-8?B?QmJ0NG1hcjZETXpEL0VzSW9WMEg3TWNvdEd2VVFIR3hxZ29CNWoyTjVHeTRS?=
 =?utf-8?B?TndEc1JEVVpuZHdlMVlpV3pZbXkrTUtxQXVGa3RZVFlta0hjSXFxWHVwV01u?=
 =?utf-8?B?L0x6VjRoMzI0UDZHU2ViYis3V21MbWloYkJqTjFOL2lrSG00eFdnaXpoUm5J?=
 =?utf-8?B?aEFaclJXanQ0QnIrZ1BlL3o3UnZrV3h4RXNSYndJWWNaSlBMdnFZZis3a1lP?=
 =?utf-8?B?aVRmNEkxc3QrZHR1Rzh3VWdzbHlDcGhlMjhlUDhYM3FBeFZDbTV1R3l3Ky9G?=
 =?utf-8?B?c2ZCWWhqY1pxMzlLYzFIY0xJcUoxKzlsVGhLRlE5N095d0lRcEZFeXlBT1Iy?=
 =?utf-8?B?K1NtLy9hOFg0RUgyM3JSaFhxcS8vdWRlM0lzYjc4UWZaS2dXdStrOVZpVDFP?=
 =?utf-8?B?aFMvODdZVHhOd1ZETGNoeW9YSFc0RnYxTmxQdEJVTk9DNmtWU1Q0UzhvNXVY?=
 =?utf-8?B?SDNreEd3NThySE45d3Fua0R0QmRNUlRHTVZqTnc1RzJpemRCVUZSWFN0a1Fr?=
 =?utf-8?B?TTlkc2JsVnMrNERxZlQ0dVNlTEhWS0hwN3NTdStaNUxYZEJvTGZURXMyS0hp?=
 =?utf-8?B?RXYyUEQzUVBHSWRLVi9KM0tjaDVGa0dPeERCamtKb1gzUjNLUmFUSnJ1WXl5?=
 =?utf-8?B?YTd5dW9hc0lRZjU0SmpXa3c1OVdoc1loOWJKaDZVWVR3d29FWnJuZDQ0R0xP?=
 =?utf-8?B?SGp1R3E4M2Z2SnJrLzNyTWdpSitsU1VQc2hqSnRFQ2hlYnV4Yi82N2pKcjFK?=
 =?utf-8?B?bnkxYVUxRGZHbU8rN1g3SDBnRk5XSEhiS0lIazN2ZFdBVHZ1dmtiMm0vQTA2?=
 =?utf-8?B?eWxvZ3VWNW1welpSbDhOVzVwOXpZbHpXSlRCSDF5UVBFMDJBK0RiRUU1Z003?=
 =?utf-8?B?TlhPbjZoTDYwbjV6eFJ1SVdtYWdTM0tqV0RneUlLTis2K2VuRTFXNDk4SjJT?=
 =?utf-8?B?RVdjT21MOXEzSG1TMUxRbTdWWUhkVmRLMXREcFdFd1J4RkVnYUhrS2EzQ3Y0?=
 =?utf-8?B?MkxKTk41R3VnUllWZjJIUXNzNXhjMS8vbDEzL3B6Si9wc1YyTWtWK1dxU1Mv?=
 =?utf-8?B?VDNPTzN5bG9qeEg1bHBYeUN4WU9sdEZXa01Yc3EyWHVIK0RnUjBrVXJ1UlRt?=
 =?utf-8?B?OVdMblhjQlUyRDQvNzhCblJzNXNsVmVWc0oyN2U1TVRRcytMZ1BsMUVVS0hs?=
 =?utf-8?B?UkMzTVdJVUw5QTcrS0R3WnJHUk5QeTZkcDcwYSs2dCt5bXdWWXhHZjg0dUdo?=
 =?utf-8?B?b0piNkpwRlNhcWlqWDI1ZjdVc2F5cVRxTXRlYXZFWW56MlpHVllHVlNJbDlt?=
 =?utf-8?B?NWdjVTVWNDFpbE1NbHpxWGRHQU1meVZvUHJ1bGViNnJuSHdYalRCSFVaNE4r?=
 =?utf-8?B?ek5ZblU0YVJXTzV3Q1hNWVVKZjFRdjZmaldpN3g3Mm9Ic2RPTWtCeld3REFn?=
 =?utf-8?B?ZS9GNUNpQ2hONmpYL1pnMGxmSU9TVDc0aERnQk1xeU91K0JhZE1leGpla0VF?=
 =?utf-8?B?MFJmaW1saGtRU0V5eEJ2VUpNeTUwRTEvTklnN0pISlNEYnY5RGJmOFA4T3Vs?=
 =?utf-8?B?QXd6bmlRRlFOaEMxcW9JVC9xamxLQUkyUnAyOFQxTUh3WStoeE1CNEhrQzgv?=
 =?utf-8?B?NEJ2QlYyZ0dUVGwvd2JMaWIrU2hJSS9nU1RxM3NwVTF4MVY4ell1dnYvaUFv?=
 =?utf-8?Q?iGK47MWe50mltnf0SR6eoyEmN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2TS1Q4/HUMHYwpRNtXoykxYWNnj64WqYYoij3wXkYnAyHsyYeIa08b6nUttUrkWSqeRaMgWX9F1JCzf889X+aZKXZic1N5dwGGOaLJGy6VysE/3zxv48WJrEYxcTuSIk1kkNQujClBfC1WrRx2cxj7FwYkjZFGnt6YUM3UELmcZwv80gFkHWhbdbn7RW7G4zzll9lebfW4nM17TtWuUFRxzvuVk7ydlfRZi6bjqmj/kWPTtnII3Kc0B5EjaYQhVNCvrBbufJ9aLiEal/65rV9FaKSxZ75AzxSzEM6s3IvLDoktiS0q3v7DM6XCKz35Gl52k7f5vOor+3QlMll0Hom/oRImK1WSQwN10s18/eJ0IwBrDlkwD6w7fP9yVGktWEfUYpLWI4iDdtrdgHwNSSJYyx1qPfBqE5oU70W8JWx2tlF2uG4JRWso5BR1/cCFPm5yZuXBdnuYUV/uJKuEReyU5RfFy+aw2JB1o7w362pHmFGfgjfdairW6Wgi/wfP8EcJAKTfDV8ZyW0RF7uFR/Z5ZnEaFIDrcuzfqU1y0LtUcdIsOf6HUUKBMCL62ueaZtfOe+DPNzpyjfEL6lPD2b4lJ1zD+v98K1b56bRYuU42Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ad135-f984-4741-b986-08dce72e24cb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6528.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 00:14:16.6442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYbJjTWZtoQPynJOYy60AHiTK/0gAuArKaedDqRHOjGwCIakAHYIxIX6du3bTAFsZU3A5PUUGtQnBqKb8tO3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_15,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070166
X-Proofpoint-GUID: bwQJDB6GF36-WzIjDNzrKtC_NdtawHZs
X-Proofpoint-ORIG-GUID: bwQJDB6GF36-WzIjDNzrKtC_NdtawHZs
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
> On Fri, Oct 4, 2024 at 8:48 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
>>> On Fri, Oct 4, 2024 at 2:45 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
>>>> translations for guest memory regions.
>>>>
>>>> When the guest has overlapping memory regions, an HVA to IOVA translation
>>>> may return an incorrect IOVA when searching the IOVA->HVA tree. This is
>>>> due to one HVA range being contained (overlapping) in another HVA range
>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs to
>>>> translate and find the correct IOVA for guest memory regions.
>>>>
>>> Yes, this first patch is super close to what I meant, just one issue
>>> and a pair of nits here and there.
>>>
>>> I'd leave the second patch as an optimization on top, if the numbers
>>> prove that adding the code is worth it.
>>>
>> Ah okay, gotcha. I also wasn't sure if what you mentioned below on the
>> previous series you also wanted implemented or if these would also be
>> optimizations on top.
>>
>> [Adding code to the vhost_iova_tree layer for handling multiple buffers
>> returned from translation for the memory area where each iovec covers]:
>> -----------------------------------------------------------------------
>> "Let's say that SVQ wants to translate the HVA range
>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>> with addr=(0x20000c1000 len=0x10000).
>>
>> The VirtIO device should be able to translate these two buffers in
>> isolation and chain them. Not optimal but it helps to keep QEMU source
>> clean, as the device already must support it."
>>
> This is 100% in the device and QEMU is already able to split the
> buffers that way, so we don't need any change in QEMU.
Noted that if working with the full HVA tree directly, the internal iova 
tree linear iterator iova_tree_find_address_iterator() today doesn't 
guarantee the iova range returned can cover the entire length of the 
iov, so things could happen like that the aliased range with smaller 
size (than the requested) happens to be hit first in the linear search 
and be returned, the fragmentation of which can't be guarded against by 
the VirtIO device or the DMA API mentioned above.

The second patch in this series kind of mitigated this side effect by 
sorting out the backing ram_block with the help of 
qemu_ram_block_from_host() in case of guest memory backed iov, so it 
doesn't really count on vhost_iova_gpa_tree_find_iova() to find the 
matching IOVA, but instead (somehow implicitly) avoids the fragmentation 
side effect as mentioned above would never happen. Not saying I like the 
way how it is implemented, but just wanted to point out the implication 
if the second patch has to be removed - either add special handling code 
to the iova-tree iterator sizing the range (same as how range selection 
based upon permission will be done), or add special code in SVQ layer to 
deal with fragmented IOVA ranges due to aliasing.


Regards,
-Siwei





>
>> [Adding a permission check to iova_tree_find_address_iterator and match
>> the range by permissions]:
>> -----------------------------------------------------------------------
>> "About the permissions, maybe we can make the permissions to be part of
>> the lookup? Instead of returning them at iova_tree_find_iova, make
>> them match at iova_tree_find_address_iterator."
>>
> Ouch, I forgot this part. This is a small change we also need, can you
> add it for the next version? Thanks for remind it!
>
>> But I understand that the problems with this is that we're assuming the
>> SVQ translation will always be done in a transient manner.
>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/virtio/vhost-iova-tree.c | 78 +++++++++++++++++++++++++++++++++++--
>>>>    hw/virtio/vhost-iova-tree.h |  5 +++
>>>>    hw/virtio/vhost-vdpa.c      | 20 ++++++----
>>>>    3 files changed, 92 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>> index 3d03395a77..e33fd56225 100644
>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>>>>
>>>>        /* IOVA address to qemu memory maps. */
>>>>        IOVATree *iova_taddr_map;
>>>> +
>>>> +    /* IOVA address to guest memory maps. */
>>>> +    IOVATree *iova_gpa_map;
>>>>    };
>>>>
>>>>    /**
>>>> - * Create a new IOVA tree
>>>> + * Create a new VhostIOVATree
>>>>     *
>>>> - * Returns the new IOVA tree
>>>> + * Returns the new VhostIOVATree
>>>>     */
>>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    {
>>>> @@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>        tree->iova_last = iova_last;
>>>>
>>>>        tree->iova_taddr_map = iova_tree_new();
>>>> +    tree->iova_gpa_map = iova_tree_new();
>>>>        return tree;
>>>>    }
>>>>
>>>> @@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>    {
>>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
>>>> +    iova_tree_destroy(iova_tree->iova_gpa_map);
>>>>        g_free(iova_tree);
>>>>    }
>>>>
>>>> @@ -71,7 +76,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
>>>>    }
>>>>
>>>>    /**
>>>> - * Allocate a new mapping
>>>> + * Allocate a new mapping in the IOVA->HVA tree
>>>>     *
>>>>     * @tree: The iova tree
>>>>     * @map: The iova map
>>>> @@ -108,3 +113,70 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>    {
>>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>>    }
>>>> +
>>>> +/**
>>>> + * Find the IOVA address stored from a guest memory address
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The map with the guest memory address
>>>> + *
>>>> + * Return the stored mapping, or NULL if not found.
>>>> + */
>>>> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *tree,
>>>> +                                            const DMAMap *map)
>>> Nit: Not an english native, but I find vhost_iova_tree should not be
>>> broken for coherency with the rest of the functions. What about
>>> vhost_iova_tree_find_iova_gpa, like _gpa variant?
>>>
>> Yea, I totally understand what you mean here and I have *no problem*
>> making it into vhost_iova_tree_find_iova_gpa.
>>
>> Just to add my two cents on this, for what it's worth, now that we have
>> both an IOVA->HVA tree and a IOVA->GPA tree, coming up with function
>> names that operate on this new tree while conforming to the
>> vhost_iova_tree convention and being descriptive in the naming is a bit
>> difficult.
>>
>> For example, to me, vhost_iova_tree_find_iova_gpa would seem a bit
>> misleading to me if I didn't know about it beforehand (or was just
>> seeing it for the first time). Like, are we finding the IOVA or GPA or
>> both? And what tree are we operating on?
>>
>> If this was some personal code I was writing and I had free reign over
>> it, I personally would go with a format like:
>>
>> vhost_<tree this function concerns>_tree_<action>
>>
>> So a name like vhost_iova_gpa_tree_find_iova communicates to me that
>> we're operating on the iova_gpa (IOVA->GPA) tree and our action is to
>> find_iova (find the IOVA).
>>
>> Similarly for something like vhost_iova_gpa_tree_remove or
>> vhost_iova_hva_tree_remove, etc.
>>
>> But obviously this is the complete opposite of personal code and
>> certainly not something that's needed so I'm totally okay with renaming
>> it to vhost_iova_tree_find_iova_gpa :)
>>
> You're creating the patch and you (and everybody) can comment on it,
> of course :).
>
> To me, the fact that GPA is stored in a separated *tree* should be an
> implementation detail not exposed by the function names. Ideally, the
> user of the VhostIOVATree just knows that some entries are tagged with
> the GPA and others are not. Saying otherwise, we could replace the GPA
> for another struct, or merge both trees, and the API would remain
> unchanged if we just add the _gpa as suffix.
>
> Having said that, I'm happy with both names so feel free to keep yours.
>
>
>
>>>> +{
>>>> +    return iova_tree_find_iova(tree->iova_gpa_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Allocate new mappings in the IOVA->HVA & IOVA->GPA trees
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The iova map
>>>> + * @gpa: The guest physical address (GPA)
>>>> + *
>>>> + * Returns:
>>>> + * - IOVA_OK if the map fits both containers
>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>>>> + * - IOVA_ERR_NOMEM if the IOVA->HVA tree cannot allocate more space
>>>> + *
>>>> + * It returns an assigned iova in map->iova if return value is IOVA_OK.
>>>> + */
>>>> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, hwaddr gpa)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    /* Some vhost devices don't like addr 0. Skip first page */
>>>> +    hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>>> +
>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>> +        map->perm == IOMMU_NONE) {
>>>> +        return IOVA_ERR_INVALID;
>>>> +    }
>>>> +
>>>> +    /* Allocate a node in the IOVA->HVA tree */
>>>> +    ret = iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>> +                              tree->iova_last);
>>> Why not call vhost_iova_tree_map_alloc instead of duplicating it here?
>>>
>> Great question with no good answer! For some reason I thought against
>> putting it in there but will do that in the next series.
>>
>>>> +    if (unlikely(ret != IOVA_OK)) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    /* Insert a node in the IOVA->GPA tree */
>>>> +    map->translated_addr = gpa;
>>>> +    return iova_tree_insert(tree->iova_gpa_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Remove existing mappings from the IOVA->HVA & IOVA->GPA trees
>>>> + *
>>>> + * @iova_tree: The VhostIOVATree
>>>> + * @map: The map to remove
>>>> + */
>>>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
>>>> +{
>>>> +    /* Remove the existing mapping from the IOVA->GPA tree */
>>>> +    iova_tree_remove(iova_tree->iova_gpa_map, map);
>>>> +
>>>> +    /* Remove the corresponding mapping from the IOVA->HVA tree */
>>>> +    iova_tree_remove(iova_tree->iova_taddr_map, map);
>>> If we remove it blindly from both trees, we are keeping the bug, isn't it?
>>>
>>> I think the remove should receive the "gpa" as a parameter, same as
>>> alloc_gpa. After that, vhost_iova_tree_remove_gpa looks the right iova
>>> into iova_gpa_map. And only after that, it removes that iova from
>>> iova_tree_remove.
>>>
>>> If it makes things easier it could receive (hwaddr gpa, size_t len) or
>>> all of the info in a DMAMap. What do you think?
>>>
>> Initially that was my plan but this only gets called in
>> vhost_vdpa_listener_region_add/del and in both functions, by the time
>> this removal function is called, we already have the correct IOVA.
>>
>> In vhost_vdpa_listener_region_add, we just allocated that IOVA and saved
>> it in mem_region. In vhost_vdpa_listener_region_del, we already found
>> the IOVA via vhost_iova_gpa_tree_find_iova prior to calling the removal
>> function.
>>
>> But I could be misunderstanding something here. Let me know if I am.
>>
> Ok I missed that. I think you're totally right.
>
>>>> +}
>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>> index 4adfd79ff0..511c6d18ae 100644
>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>> @@ -23,5 +23,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>                                            const DMAMap *map);
>>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
>>>> +                                            const DMAMap *map);
>>>> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
>>>> +                                  hwaddr gpa);
>>>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
>>>>
>>>>    #endif
>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>> index 3cdaa12ed5..591ff426e7 100644
>>>> --- a/hw/virtio/vhost-vdpa.c
>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>> @@ -365,9 +365,16 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>            mem_region.size = int128_get64(llsize) - 1,
>>>>            mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>
>>>> -        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>>> +        r = vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region,
>>>> +                                          section->offset_within_address_space);
>>>>            if (unlikely(r != IOVA_OK)) {
>>>>                error_report("Can't allocate a mapping (%d)", r);
>>>> +
>>>> +            /* Insertion to IOVA->GPA tree failed */
>>>> +            if (mem_region.translated_addr ==
>>>> +                section->offset_within_address_space) {
>>>> +                goto fail_map;
>>>> +            }
>>> We can move this cleanup code into vhost_iova_tree_map_alloc_gpa, isn't it?
>>>
>> Sure can. We'd still need to check if vhost_iova_tree_map_alloc_gpa
>> returned IOVA_OK though and goto the fail label.
>>
> Yes, right.
>
> Thanks!
>
>>>>                goto fail;
>>>>            }
>>>>
>>>> @@ -386,7 +393,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>
>>>>    fail_map:
>>>>        if (s->shadow_data) {
>>>> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
>>>> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
>>>>        }
>>>>
>>>>    fail:
>>>> @@ -440,21 +447,18 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>>>
>>>>        if (s->shadow_data) {
>>>>            const DMAMap *result;
>>>> -        const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>>>> -            section->offset_within_region +
>>>> -            (iova - section->offset_within_address_space);
>>>>            DMAMap mem_region = {
>>>> -            .translated_addr = (hwaddr)(uintptr_t)vaddr,
>>>> +            .translated_addr = section->offset_within_address_space,
>>>>                .size = int128_get64(llsize) - 1,
>>>>            };
>>>>
>>>> -        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
>>>> +        result = vhost_iova_gpa_tree_find_iova(s->iova_tree, &mem_region);
>>>>            if (!result) {
>>>>                /* The memory listener map wasn't mapped */
>>>>                return;
>>>>            }
>>>>            iova = result->iova;
>>>> -        vhost_iova_tree_remove(s->iova_tree, *result);
>>>> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
>>>>        }
>>>>        vhost_vdpa_iotlb_batch_begin_once(s);
>>>>        /*
>>>> --
>>>> 2.43.5
>>>>


