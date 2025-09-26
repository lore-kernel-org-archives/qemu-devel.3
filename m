Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C267CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28TR-0001Xa-Mc; Fri, 26 Sep 2025 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28T1-0001KP-PX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:26:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28SP-0005Te-8v
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:26:17 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDMEHi004956;
 Fri, 26 Sep 2025 13:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fdPLb81SfcxaeI+IlC46BklbO480lwvbaXwYCGy2oms=; b=
 K744OBF1EG5e+LoFlwE6uJ2e1804sa6s8LUBEFLh7id5Fke7/rj1GGdR4qL7+ACP
 da9N90CtSQIW1MEq0KlGw8m8HnBw6xOsn7ldFGQHw7yiVPd8jHFd0fPTjCI/Jast
 vDQR/D6bBKkxfwmJm+N30XhdN+kAjflD8InTV/IvyN/rapa7PUQiJtucpdxis64r
 BNInZTDTUmcUXpmqLDDHlYzKWzKxMVPNW/FWW5+93UCcH3c64xDdYQDjX/HzTgr5
 r9ktqAjFHnddrRSCBO0sfm4s01D8UVQ9o8iBZKjo15ltj+1wIIzohcPaiEyiFm+r
 osk+vitTndCgPTpmx46hNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dud2r1ns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:25:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58QCDaaJ031604; Fri, 26 Sep 2025 13:25:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49dd9d2h7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBWtx2PS19I4QKVrj7xS/IAOb7Y+XbmNVxuOGkENdowYMge29375XrRRvSXcMzI/FOEw1tnisFTpNL5waEGlqKiyc4BeXLn46cuqQg8IBqV0qYLlflbB/XgbE044QZihkJHBgXClkZooopgWjqaYSvFu9E6V5ideZdgvkWjgrQpWiMzxkPWg8WL1gqFP1TC3LkDO+rZr2KSoDYhF0AWA/cwwo3UQavXBy+gAao/AA2PEJEmcd2zcIdW0ya05qkqM4JhdLJl7Y6XK/5dXt97AVLsYNV4abA8wK4TYOFKywENviYp95rhHZd1AKAsGf5swOG0xxcKxjlhghI50+N+EVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdPLb81SfcxaeI+IlC46BklbO480lwvbaXwYCGy2oms=;
 b=WkAc7aUMG0CUuqHc+tTDtvaI9pKvAGRsyt+/c+1PgDtTRb04sbxSx3ApfXG7iRMFSusianVFCMtcYZKPm3CZeRSu0aYX4zxtU8W3L97u6VktC+HCcLlnjgKNBEm7gsuUty48JB8R20n/a4zTprS8tbC5/KzqO4ubZfUNePZdVN7rqggRGyJsfUVOUgmkyG8rMuugqSfocRBNZJD2jcQCu4bJ3NkHlNZoM/4r8JsFXMlO0qqCLGx4jWHbKiiDGChkKRrnUT96QN2ExOe6AJHCQq/bRVzrroTz7zPau3GfUVYHEtpomheP30XBcE8ZJBO2p13k5a1cA/fWEkojW8bmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdPLb81SfcxaeI+IlC46BklbO480lwvbaXwYCGy2oms=;
 b=MdrdHNZrvenqFv2BKZxxMJj2B9pEk5tx1i1/hcBYCbXEQfDYf/OWxbYKjo/Gw5BvnBH4yJHaNPiDVrGhTI5mwSj1ZdDBbviX707gLB7bltNo5t+YBhzUOVTwHyKXaNMUFCEOrHTkmXCupL1PoujQhuZcLVE3Vj9bihIhq1E4p/4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 13:25:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 13:25:42 +0000
Message-ID: <b4c4adda-75e5-4729-9e67-2844eeb0c5a0@oracle.com>
Date: Fri, 26 Sep 2025 09:25:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vfio/cpr-legacy: drop an erroneous assert
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
 <20250926022348.1883776-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250926022348.1883776-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:510:174::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: d406490b-a9fb-43f5-4058-08ddfd0030dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alk0QWRRdEpxR0xNRnpSbGtPTURSZDVYc1FrTHp0VC81NHY0a29zL0RwQjNE?=
 =?utf-8?B?UE1vczFsbWJuaTBlS0k3QXVQdHJvcVp1NDg5NEtPd1p0NWdmV1hYaXA2WHNx?=
 =?utf-8?B?aHBxcmgzNE1HeEh0dllZWkRJZi9ad3JmUjdaZUs2QkpZdi9pL3VUQ1ZCYkFU?=
 =?utf-8?B?MUpHMWx6K1FNSU9yODlOdGZYUWRQNk1BVnU5N1BSQWptRGRoQzEwRHZ6SVhU?=
 =?utf-8?B?NXdYbGFjNWtWaUY2OFVoTHhYSTk0SUlaMktFWnBTQVpqZFRvWWplSXNOVHQ5?=
 =?utf-8?B?OGpWMlRBbEdJVis1dGY4bDdGQ2VaeExwcUU3VlYvWmFwTm5BRERNTmllWEFH?=
 =?utf-8?B?ejQ2TXZyZkkwOWw0R1JLYTY4ZVRCYTBIY1FjUFhoNDQ1YVFzSmNhTjRHbWRL?=
 =?utf-8?B?OGx1SURBS2pKWnh1N2RkOU15TU9TV0lJMWN0aHVnU0pDWGRISU5KZk1oM0ov?=
 =?utf-8?B?d1hPVjZJeVlHSGZnR2lBOStodkt4ak15amppYk0yRUJJWHlZYXU3VUFvd2c5?=
 =?utf-8?B?Nk1vUTZqR0xVazdRREV3UWpoSTI3bnhPSUV3UnlUc2VyRWxkais2dDdIdlJs?=
 =?utf-8?B?SUVLa0oveDBZUzV0YXc3MFh3Z2VsbnJ0QmVlei95NWh5c0UxSE9ia2V6SGhv?=
 =?utf-8?B?VUE3YWs1RThTYTlXa3l2UmQ4N0hBRzVjYU13YkxBelE0c0VqUkQxLy9xekRn?=
 =?utf-8?B?eFFmVmt5M2Q3eWxnbGk1Vk84VHNzRHRzV05lQVczN3BHNU5xSUpxTUJWbVgy?=
 =?utf-8?B?ZjVKZ0hUTmhUYzdsMytWbHVicTJrT3JETEJjcVQrU05ZanNoU2RRblJ5V1pG?=
 =?utf-8?B?VHE2aGR4MEU3bHBEQ2g0UjZDRnBRRCtIckw0Q1dtdVZUOEpmSkRDcGdZMTVZ?=
 =?utf-8?B?S3crY29YcTJvaHhQSklFK2cxVTFvQmdmYm4zb3ZSUUxvY3lJUEt2YUNSK1pT?=
 =?utf-8?B?MU82YzdSUnE3UGN2cjZ3UzU2Rkp5amtKWVIrVUF3S0Qvb1lvMGxwVUhteUVX?=
 =?utf-8?B?VVROTTA3SzR1WE5Ib0g5RGVRUk0zQ2xST05Ec0VzR2xOZ3dDNzNYb1R6aWNj?=
 =?utf-8?B?WE9QYkk1KzFVTEZjcDRraG96VUpvQUhJekxwa1Z3bVU4YXIvcms0bjVXN0l5?=
 =?utf-8?B?MDZxN3B4ck9IL2lVeXB6eU5XS2RReEhqbUw2QUxveWR3eFp1NVEwNVNZSHA5?=
 =?utf-8?B?QkpxcWlZSXlNQTdsMkVvZS9IejFOM3ZUU3ZSLzE1ZXlmUjBIeUpZSmRtZWxH?=
 =?utf-8?B?eFd4YkdPamR0c0ZGOG9MQloxdVE3T1ZNSlVZT3hiYWtycmVOUjNCYUVLSG1Y?=
 =?utf-8?B?NjBkUEJhUVo2MDN6YjQ5alpXeDc4eG5qU0MzVUkxamF5aTJHc0Q0bGhHRGpt?=
 =?utf-8?B?cklNNXpxVGtYUnA4cjNaSnVuMktJY1Q2b0prQmdQdVk0UTd0akl0R1duSFRy?=
 =?utf-8?B?MnJNSHUwcTZhN3BrWGQ0UDJMRlpTejR5OHkzUFNQR0dNbE1CSStGZkNkSXBK?=
 =?utf-8?B?Uy9tZTBsZkNDcUw4R1dIQWdPUXB1MGRqSldWS2ZBQXVqRTdWbWJnMnVsNFY5?=
 =?utf-8?B?Vk01YkJLMUUrb20rTzNFM1BYaXgwUjZnNS9UZjZKMWtkNWJNaWJTYjZ6U1hY?=
 =?utf-8?B?V254K2p0ZC83L1J4WVJqczdxcnpIeGp1NXdCNjFDTzUxTWNoNmxWWldWMmY2?=
 =?utf-8?B?c2FhZ1JQZkdrM21XQXlGRnlCdzcvUm9VZVU5MkhZZWRPd1ozYytCV1BqdWxZ?=
 =?utf-8?B?T3NxNGxWL091KzdrWGFDcGpLbWRxWTVNU05OZnVPaHNYV1A3VkdWczRLN3Yx?=
 =?utf-8?B?N0pNTERvdnQwbDFzK096NWh4SDdZQ1Q0Q3paRXZLZHZzOGg2RU9yanRyUzF4?=
 =?utf-8?B?RzNsZGhIeTZzcXZ0VmNvVGNCQ0t5TUxWY3k5ZUxMZnVQUE41VlJGWW8zZC9h?=
 =?utf-8?Q?19hp4f3uTOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRZK0dXTWNvL1paUzRuU1ZVR3UvRnpuNTJ3MDRzUXM2V1J1eTlTbFIrQjQ5?=
 =?utf-8?B?WVdNOXhmOHZwUXNqQ2wyZzZYekdaa2NVMlN4bHlZVURNSEpqOG1SOCtYN0Vr?=
 =?utf-8?B?Z05GdndTQjBHczJCellxMWdrdTkwNmRzZWVPTGs3bHhqYWR3bktWVW45UHU2?=
 =?utf-8?B?SE5HTFVsTXl6YlVXTU1xWnBwM09ha0t0TDNTeXFqS2FTNHNsd3NSNTlkejBh?=
 =?utf-8?B?dEJUUDlzYlVpMC9udXo4NHN5QUFDZldrbTZ3VXl0blF5YkZaVmVPSEE2L2sw?=
 =?utf-8?B?bldZUGZNeHRvdHZhbnFVZU5lV0VxeDZqMHR2UnpQZUtqZnJrVEtOZUV2UklC?=
 =?utf-8?B?bUtKTHl5ZXJvQUs2R1dod3E4bDg2OG11dWxwc3pUNjV1dk5mbVVMcXdtUXhX?=
 =?utf-8?B?UWpWcTQwUlZMRytpUHAwUVBvK2lNVUhaY3psVzB0UE80Z0J4Y1VSRm1zNUNU?=
 =?utf-8?B?VWVWcHo4TnRxTzZhMFhkMVB6Rm5QL3NhRlBkdWtMVDl5R2hmWDFjdFBsS2xF?=
 =?utf-8?B?czUwYmh5cTJKYVFKaDFEbFdDVlJZaUNlYmlNSVdSckswZ3hoYkZKUkM4eldB?=
 =?utf-8?B?VkU5VUhsYVo3Y05Mb0RMYk9lbVhOb1ZOcUpPTWtZVENDQ0Nqb2MxeFQyTGU1?=
 =?utf-8?B?MXQxd3RLajFqb2pZTUF5T0lCeUduKzZaZmJ3NGE5Y09jbFRoOVpLOGtrSmph?=
 =?utf-8?B?YWg4WUhmdS9VTFZlaElGK2RPOTRncDMvTi92Y1JEWlNIVk10NE00d3duaU5P?=
 =?utf-8?B?T1ZoK2dnemVoNXVIVFpJdW9NZTJyOGNtVW54d2UvR3haTGtqcE02RWZYRTZ1?=
 =?utf-8?B?WXlVWTZKVFNWN1lyMUpaQlpmOG1IWU40ZXpEMHlLVVFBSEhxcVRWdWVlSWRJ?=
 =?utf-8?B?VUN0N1U2NVlhRGltcmszaEFqK0JHaCtrTWlyYzRyaVRXN0pVVjdoVlZaSE9Z?=
 =?utf-8?B?TEJWempJellrRmRHRFJYaE9rTldrMVZxc3lmYzQ1Vlk5U2haMm55aFFXQkVv?=
 =?utf-8?B?UmFHRDBHWFhreWtJTFRvN3ZiZ0krSXc0TWtnM25CaWdDOVpRLzhKS25zSUEy?=
 =?utf-8?B?UzltbG1DNEUvY0VtRElMN3JhakM5SUhwL3M4dE9iREhKVGFYNlRZUmdJcFo2?=
 =?utf-8?B?U1pzUmNQRnhhcWlKc3FRbXk1YS96WWZaVVoxTWNmbU92TDIwckpKTS90bVdQ?=
 =?utf-8?B?SW1aMDRXQWRISWl2ZmhsNGZWV2pTdndTMGQyWUVVR09uZE8ycXkyMDV1S1Zh?=
 =?utf-8?B?Y0k0ckN6czJETDhmamg0SjFyL3ZHUVpUYjhTKzNmR2NIM1R4ejcwTW1sbzJG?=
 =?utf-8?B?d1FDbWJXbyt4OEpteTJ1K2RucjFIQmhJVnNHZ3htck52a0lWUG5wcEJzVVg0?=
 =?utf-8?B?d2djTFNZQXVTbUdkaWw5RzRsNk9rZTRrVnBPR3F2cTFqNFlUaWR3N2lFMEc4?=
 =?utf-8?B?S2NkaXBDY0NUeENsbVA1elVucUU1c3FWQ2Z4SndYUE4zMk5NWEszNGpEb1Yr?=
 =?utf-8?B?MVJLNkZzTGpvSjBTODBIZUdFMmMzdUliRk96Q2I4Q0RJSk1tVmxiMFpNem1C?=
 =?utf-8?B?aWlQWlBiTCsvdW53VXBJTFlaY2U3eUlkdE5uQmxpeG11cHdoSm0vRFpiMWJW?=
 =?utf-8?B?Qmxvc1FzeXM0a0MzTkRaaWQzMXdOd1N1VDMrQ1BSNHdiUkNBUXdMVzlXbzlS?=
 =?utf-8?B?QmQ0N0sxSC92citGbHBOeU1rZDE1UXJkWGtXKytjQW9xV2I4ZVNvK25hb1gr?=
 =?utf-8?B?aFdRVkdpZlRNZWc1Nk5VeE84Y2tBcGQ0eHhmM1JvMmJQN1IyYWpMVzA3a1N3?=
 =?utf-8?B?WGRxR2wzNGRpRHhESWFsL3hIQTZlMkFJK1JGL2VMV280cnZyVVYvcFAyYTkx?=
 =?utf-8?B?TnVCaVQvSDQ3RDV4VFBLcHYvdGNRdFlaSFJLK2orb1FPNGdYTWdqVS9qRmZG?=
 =?utf-8?B?bTQzWHUrNjVNRnh5OXNnVjNiRzJJZ05sY2RwNEJQa3FFdUovSUVvMmUxdHNG?=
 =?utf-8?B?RWpTSkhVZUtKSDVXeWhWOG5iYnVXR3dDTW1oeEdsY09oVytmK3YvUHZEWW9B?=
 =?utf-8?B?OWl0cmVsMVRremcyU3RidUg4b2tlL25TdTArODV4SVFpbkJyYTVuZXpocG50?=
 =?utf-8?B?TmxuWkRSenRBd0x0cHBaNG4xMkdlUGtWYmZTaGhJUzRBcTlPazZxckdnWGgr?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: POBPXXP7Tq21n0lpbYttXTAAaAD+GUstNAPtcU5SLhfB4SJrMOitLSUarf6fF2NKMymTFedUdLUdjxbdjkPiy6WZQapWVj3BJsp/0r/sr9bYEvLT/TDPdUkfwGSytWcphWBEr0D9eqcfe0kpPXG2Yi0YITW7cyx4F/tsd519UbnMleKXqhl6HFxa/BV7rrNKbX7i6bxTv3J3S+b6Rqp1g0yOnHIdWerWakMY6Hym6je/txm00XamoXF80JLTKH+tu+jLKf7puLDq/lG5CGtu7eGhYFISsjyPRX77MVVLp0wPKEs0jzwF1jMLPt2UQ7QsOjnx4Cck3WEVvKUCGPrDkoNTUJ6/zKXTF9kU27ckTNO8QfiiPaKfZekOU0T44h2IuWHbh83MPHGVLL3lBW0IRD+4YdrMUch6zi/iZYxCL6tvFY92aCRKKqAjeoVK2OnPHO6GLVYyT2CBHMa4oTQ5vPonTGkt+Np7C+Gi7/+YfYa/9wulTdqHZi47apRbWp6WOmKMOAlaJEBX7+m/wEYnmm9+QuzqgP8l738wyz+t/bTrT6eRB0bKBNsW5gv3RKtBhhvbbv/iBkILwD9YOTaYBplh83d0CZthlA3y1cr0o2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d406490b-a9fb-43f5-4058-08ddfd0030dc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:25:41.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDfp7R8xtog6JlpYEeo7Ir6U0jwxC4uGAVr+xMdIzVyq9qu4QJpU9TZdYctTlQn8LZTz5/VTEV29HJF+Bp1f/Vu7g4ipMAbonwPLYbS0VS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509260123
X-Authority-Analysis: v=2.4 cv=M+9A6iws c=1 sm=1 tr=0 ts=68d6945b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=1KhBTgNCXQYTksIhCHUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-GUID: hBAIBMzd49JcYYBnDB6gZIeN2dKODtP1
X-Proofpoint-ORIG-GUID: hBAIBMzd49JcYYBnDB6gZIeN2dKODtP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyMCBTYWx0ZWRfX8+I1C+iiEEGQ
 mim5cI4IEU7efVAx1rm58XPrqjgqQHMLP0SAo+vI3w00cVselqpw2z9DEPCDzjmr07PWoNAM9dX
 a9Y114hWImEl3YRM3qFMMWmHdSI1RuqNfED1QIA4h5G2xKOoX72LSASShbZglMqKpueBBXyeEXr
 5XKM2q/liIUvh7vSMXVBjDP1g4Xmq27QNgIq6dfFujVipnaD/ygJILEQ2lwDV3b84xARk0QxMYT
 e3+vLk9RI6MLVxdtdkyXMD8dXim1bDSk+KWXmZnsKJgbB/suzh5WX0swaVm1/8G6iXoRXOo9yjc
 pQZRDX/VUEapCNuYeFr1LPQRrYKBRPnl+pmxhZhm1D8fM51HIT+MMx4YIZaWONem63aA35BP9OT
 AXLnSsR+DjvV36iGkbQQZlwQDaXRIWl1SUwkmup3iVvuw5iUgYY=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/2025 10:23 PM, Zhenzhong Duan wrote:
> vfio_legacy_cpr_dma_map() is not only used in post_load on destination
> but also error recovery path on source side. Assert it for destination
> is wrong.
> 
> Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

> ---
>   hw/vfio/cpr-legacy.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 3ea24d60de..19fd8b60d3 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -51,8 +51,6 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>           .size = size,
>       };
>   
> -    g_assert(cpr_is_incoming());
> -
>       if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
>           return -errno;
>       }


