Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC193C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 12:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2UlL-0003r2-Lg; Wed, 09 Apr 2025 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2Ul9-0003kR-O3
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 08:42:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2Ul6-0003ui-JY
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 08:42:27 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5397tvKx025297;
 Wed, 9 Apr 2025 12:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gSGzlf/Yq1WUn9xS1R1Y1syykuyuUYkt+2HKj20lgI4=; b=
 ARDvks4Nhzb1V0ObEXqa7NeekQvaiJYaJWW90EZdJao/M+I9q03eoZ1B8ODmuC/h
 6N0uNP12ip8ZvWk049Eb53hiHlYHvjKocN7Kh/ZEFzC++Xy87xqtSRSvTPhIhYLt
 kUoytQ95LjaEaCyiNVokuahIGBGMFSmfXtx81XtcBd3O5Ki4VlHCBKu+kvM/PUB4
 u5zacWWkBrf0cOj0Y807whPJdfTnFn0VG7daOT4C1ZTELrPsoeRKDuY9n1xupTBj
 rRS3fsVnomBZYSDUdfSmq71B4lfp6zIEsPoLhkjwBlqyCZ6o6NWAaQ7FSezgVb0d
 KkXMD5QoZ7B1nrz0HSql0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvjcy4m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 12:42:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 539CFCYY013695; Wed, 9 Apr 2025 12:42:16 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010004.outbound.protection.outlook.com
 [40.93.20.4])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyh2j6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 12:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3ccy3zwl3sYgIiOR/3ZBWD1s16eH6vhEgEi0VMqUJ/CO/h/BONxScc/hQ9Q+B4cAU+crYLk7lExUK+QBjq2fRpb+P48Y+b6bq2M9Lr4g8lux+sH7YXat9TbkZ5etEyO9zE5CnpsjdSFJOpl5GL0BcPhpXKuLrN7fpMwBl+H2k4dQkXB5Qf25f2fnoRHhTG5KUJ05zXiqtO8Bf5iuPbyzO3bAjm0lB9schzmPOv0+ALZIoWfLM70FZjxvTHpk2Yey5cQAidg7s1cNHoA10+3dfqrqlw+20UGDQzTPMIVobrMXmFBEIOJE9IAYIcZ88qafpLWwO1E5yopGjaY4uyQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSGzlf/Yq1WUn9xS1R1Y1syykuyuUYkt+2HKj20lgI4=;
 b=VVXGWaaEtGSv/mrd1ZezIRHUVlq3V0nscCBE1SMF5RmOqVKGKP6N5ekE1HBI879tYZi1Pje513lAj5dUQihMcR6UrhcvPFsO/5RY8Nh9w8CVViuIlF6f0oPV7plLkWKnuLKJW9TNIpRl1j+yeasyITpY/CBiIXeiaAD4NfEsUUav9XKdz2R1EXGRgTSwbC/aOSftvXij4AXR+M49vRbB6Iu2TFoRSBgXne8ik2KBWsQO6wEGa/VB5lL3d8Bc1ARUGb9pvuq8/CsOqE4IMuHp+NDAiNirVEApHDs/9ZDapr65ahV7RQh8wUyfwMidIYbWouOaIor8gAuM1dj19oLn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSGzlf/Yq1WUn9xS1R1Y1syykuyuUYkt+2HKj20lgI4=;
 b=Pdk/t4PEBdC2s+f8XMvjKxSHuOuCigd6lqd6DZ7e2xaiFiVs7Vg5kvx9mh6ZBOZer9HkABCfLUL6K+uzf9x6N23MscG4LYWXFQfHT4do8ST25btAN1XNkOi6i/afEOr53QK2jIi8doA1+Y7uaHWnSvSppMcfq2LiCSwY0H/q/Ak=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB5993.namprd10.prod.outlook.com (2603:10b6:208:3ef::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 12:42:14 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 12:42:14 +0000
Message-ID: <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
Date: Wed, 9 Apr 2025 08:42:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/6] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87friheqcp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:408:112::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c23d99-1437-4311-9a01-08dd7763f430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFVFZm1DU1pzKzVxVXN4dzFEa29WbWt0MldBT1JiRjdKMXNJWGJMTUhrM2Uv?=
 =?utf-8?B?N3huVy8xMENOdjk3a2tyRndXTGs2T0JzVWpRTWtTR2lIVko1aUFSVUE5MHQ5?=
 =?utf-8?B?bHA2K24zci9acVU5U2lGUnZxMmIyVnM3YU5VRzhicHc5Tkl4WitnNk5tYThl?=
 =?utf-8?B?U0RRU3RrUFFuZytGbmNuQ0p1MDd4Y010bTFQbVIveDM1c3lSSTdiMGdkZER6?=
 =?utf-8?B?RFAyRTFidWhYWVJrTkNFMXo0L2l5YWptRnpaQVExWncxNG4xdnkyVzU4cWNt?=
 =?utf-8?B?SWhobm5YUkRQVi9UNjFoS2tqbHlxS1dwZk9lS0d4YS9wWTJhQjFUYlovRmcy?=
 =?utf-8?B?enkwNnVoU2phcGJUR0lHVkRNV2hLNVNtZm4xSjBReC9CWEwxSFFXdUQzWVBW?=
 =?utf-8?B?UWg5UmYxYk95ankyYi90cmJMZGhQaE92aTkrNXVPajF0b3IxUHEyNnhKb0li?=
 =?utf-8?B?NkJ4SCtBRktxek5LQVl0cHptcURzMlBPMTBsY1BlNEZ2bUNMZFh1ZHFEdEZP?=
 =?utf-8?B?TUhDZG1pVy9PYU81WEc4YmxWeTJteDVSSW50b1E0OXc3OG42NEJmQUgvRVpB?=
 =?utf-8?B?QkhlbVpURDQ2eGFuMDFNTjhCZFhDemJ3aXFRZzlVUWFsUVptRG0reTE0eGx2?=
 =?utf-8?B?K2Zla3l3Zk1UWkNieTQ3K2VDRU5oOVlsWVF0Q3JoSFpOWWFrcEVOekRVQlNI?=
 =?utf-8?B?T05kM2pzQU9Hem1oNkN4V2MveEFoNzNzbktDZ3MrL2NKVGFzZ0ZTLzM3NkJH?=
 =?utf-8?B?MlVKZjAwU3oyU0lNYjlDcjZiaDZ0dFVRanM2dys0S3BoSTdJV1RLK0dPTTlE?=
 =?utf-8?B?bzhEYVByZW8yc1BROFRRTll4Wjd5NHBPZlFQRkpkUjMxYUZXdWxXRk1hcXox?=
 =?utf-8?B?dCtLcU1scVRqS1BlY3hoMUd1VkhueXVHano3OTR2SUU4TTM1dWl5NUxzREcw?=
 =?utf-8?B?UWgzMUowNEt1TFNaczFnM3BBa1ZoN2pQd2N4a29sK2Q0QnJ6OG82LzlDeXpP?=
 =?utf-8?B?SXNoRUVQZ2t0clNOcHBIYUhodlRZR1VqNUJTbFE0dzZKNDFVZGRNck84TSti?=
 =?utf-8?B?TVYxTzNIL0ZGd2puRTZDZkdwMm94cjB6Z3d4b0FXL1JxbmhSUHFBbC9pcU9j?=
 =?utf-8?B?UTNKQlhYR253YStLbU1nNCtyQjAwb2QxUFFSajlqWDhNTWxRajFNTU5QVklj?=
 =?utf-8?B?QzVBQUlQdHlPc0V6TmJ5dVBwb0R0UUU2N3VsMFNYV2IvbWlHbXZjcXdDQzRN?=
 =?utf-8?B?bHQvcm52ZUJidEUvckJEOU1ZZU1oc1Iyazc3QnZZQUlPajNlRktNRzI5LzVw?=
 =?utf-8?B?aXAvbWYyZjVkSnlveUo0cXd1VGdKRTluSytyTjdOTjBjVjcxRS9RMFZTWVd3?=
 =?utf-8?B?eU5TcEV3aXByRjlEaDVMblBFNHlPZVlhMzBxUE9kMXVWSDBLMFFTMG1wN1hG?=
 =?utf-8?B?Ly9aaGJoUXdER3JITG9jT1dmM1dmQlJLSlcvK05Ybm9UUkdqZnlXZWgyL3kx?=
 =?utf-8?B?dXk5MmRHTlZybjhWNEp2QWRJQlRvSEgrRk1VVmlEa2MxS0tnTklqRVo1dzJE?=
 =?utf-8?B?SkJ5Y05RVEJPQWR2QWV3UnhYa09oV1Mrem5LWEk1dyt3VkpkUzJ1RnN3ZjlI?=
 =?utf-8?B?RzE3MDJGdEtyaXhaa0VXN3IzdEpubDk0RUZROUIxY2JiWEdYZ0lHRmxMMWJK?=
 =?utf-8?B?RlEzWG8remFySUJvWE5aTU5NVlNQUWl3Y3NXTTNZMWdHMHRGS2UxbHdRQk1m?=
 =?utf-8?B?UWh5Rlg2c3NyUUxBZ2VqOHZMRm84bXU3M0E3K0N2aFRuNU5hcDlvczBjeHFJ?=
 =?utf-8?B?ZmlZTDVVeFg4UTJrcjhoZ09TZlhGbnhmc1hia0xtUnNzVWkxeWZ0cWlIU0c0?=
 =?utf-8?B?a2IvOHBpYTlNelIvdUFJTlRtWEdkdGFVSXpQWlFDeW55UTRiYTE1UjRlb1ZG?=
 =?utf-8?Q?DVWyDxvL1V8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNDaHhObU9WMUpjam82YTJxWUU1Y0RrMlcxUFVReW1hejdIdTE0UkhjYytS?=
 =?utf-8?B?N3IwK2Voa3pJMEhKc2dFQ2p4eGJGVlprUFhMK3RLb2M2YjdaRkRMYVlVQzdE?=
 =?utf-8?B?cDNjOFk4cmRvdUFSc2MzZVJXcE13R1NEVkFrd2FYRjNuZXR3dzQ0c1BWdE9X?=
 =?utf-8?B?N3p5aFdMN3k4VThOVWlkSVpkRHlTOXRxbStDbFVia0tXNUVTQkxPeDJxOHl4?=
 =?utf-8?B?WWpVSUw3TXZ2eFpSQkVMb0Y0aFZMY2xDS2thQVI1dDFIeWlqS1lRaDdOY2Vl?=
 =?utf-8?B?aU53a1FTSDZtbm9KeTg4VGJyQ0pMSkdlUjVGTkVUeDBGS0dEODY4MVVNOGFk?=
 =?utf-8?B?SEdVNld6cGdFckdnMnN2bmRLOGY3R2UybkoxOUx4UGExZ01iUkRSejd0d2hr?=
 =?utf-8?B?eGxzKzA3SWpMSnYwQ1JtRGxqNGp2Yjl2eGp5TjR3QmNramlBVkhCZEZxNWtM?=
 =?utf-8?B?VHFVYms2NW1PNE1LdjRFZTJVWHdoRUdNdXljclJYOFlyMWp2Tk9lQmpBdmdB?=
 =?utf-8?B?VmNpa3JSNjViNXdRWTNyR01EZ0RvWWpUVVR1ZTlmbUNhZE1pZlU4LzhOVWgz?=
 =?utf-8?B?bFMvenhKNTRjaWJBM1Y3Wmo1bE1BRklzSmpQY09rL3EyRzNFamFHS044WGlN?=
 =?utf-8?B?c1g0TElxNVRTS3NueVllNTc5VTFVV2tUSmZsMHMrSnBQcGEzckdhQnpEL29p?=
 =?utf-8?B?NmV6SXdmQjhUbnZrMkNmMjlBTGZzV05HV0FVUzMwVjNtbmtZMkI4aWtBYzFQ?=
 =?utf-8?B?T3hVUHEzQWZBOHQyVUo4V0FlSUZlWlZnaEdINlV3NG1oK2hCd2luTFNUTVR3?=
 =?utf-8?B?MEQyTmtoVHROeDRKTWNhWk9oOGtHQmZ3eWkxWXA1QjlmZG5uS2NQWUFPMGpP?=
 =?utf-8?B?aWRYa0Y0RnVvd1FHY3c4RjY3MG1uQ2RZWWdSMTVOdjRWTGd4a1Z5TG51OGkv?=
 =?utf-8?B?YWlQbzBZVUhqN1pmMUxrSUh4UmJTNHpDRG5jbmdXZmI0Nlp4SDZ6bnhqSnRu?=
 =?utf-8?B?NG1ZWktFWnZOZHVkSEEzbjVKM2tQS1Jmam0rSWIxbk1qckwvZEZUY2FCRXpy?=
 =?utf-8?B?R3lRUzBnMjdjOGtpNzVKSjBEVWcwYnUwSGNvS3FFOVE0TTRPTzNBOVpFZUJW?=
 =?utf-8?B?Vi84L0xGc013SEZsdXpWWE5oaGZaZmNUWHJhRlp5UmorYTlZZkRCdFJXeWgr?=
 =?utf-8?B?Nms1OVZNVU9GRDRQV1BoTSt0NHJPdnJPNU41RmpuNk1GNWF1RHRraGY4ZEpa?=
 =?utf-8?B?UklWeWt2TmwrZndrdlJUQlY5UlVKa0VkM3o5SEZyTUh0YnBMK3BUK1FMaTVR?=
 =?utf-8?B?TDNSb1RaLy9MdHRraEdrRUlsZFNPaWtKVkZsTUlGemVOMEl1c2dkMm5qMmVz?=
 =?utf-8?B?MzR3ZjI4NTN4UnNjYy94Mmt5bHV5V1dOMXEyOEQ2ZVg4RFNrTWRYSUVHYWY3?=
 =?utf-8?B?SmNuQ3l0VC9Udlh3MUtrOTBiVGJmUDhuZXdJRldacjgwbWt0S0xuSEh2Sm5s?=
 =?utf-8?B?RnlXbTl0ZjJLMWUzZjFkU3ZZLzlMaDVLTDdiOHN5QjM2MHBSMGp1c3AvSjlO?=
 =?utf-8?B?cmR3Qit3MDY2dzhXMnF6QUw1QUUrVjVNa1V3RjIrV3lnZnpadkxOWmxGYzB2?=
 =?utf-8?B?WGN4dVk5MG9Db0hvUlhPODVuOERKa2d2TTA0UGE4R2JtRktJeGJsWld5ZkxP?=
 =?utf-8?B?ZEU4TWU4SlpVNnZXaDNBSFFDcnpFWG9Nc3JDVmV3bUtsRE9yN2lTckVCTVJo?=
 =?utf-8?B?RS9VZFFOazdFNXIxeWN2eFVrRGk0aVVWcDY5dGIwdVZkaGdCS3A1NDJRb0hW?=
 =?utf-8?B?OWJuMG5HZmRoWFVJTzZGbDdVRDBiM2NaeEJXRTJBNkV0THRya2Vta0tKdjh2?=
 =?utf-8?B?NGtIbGtpTERKRVErS2ZPMU1Ed2ViWmJLbjI2UEVLSmpEMTViSFl1aldlcXFv?=
 =?utf-8?B?MkhqcVQzSU9rTlZsRGVZNVFvenZpcDE0a3hhQnF2dXlWcU54Z0JkY2dERXJ6?=
 =?utf-8?B?Vkw0d0JCa1VCMDIySC85NWViRW42STJMaXdQLzgxelpGM1l1NTBkYXRodEEx?=
 =?utf-8?B?Y2lwUU9NeHl0RVhTaUhzbFBRYjVrUk9sUzZhOXpHb0RLOGk1Y0tMNFVScHoy?=
 =?utf-8?B?ZzhDS1lLbDF4bXpyY3I5RXN0dVNFY3krUkYwT2dSVTVQZWJoNUJqMUV3Rmlj?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1R6HGwDdKA4Y0Dn5otz5xUVfAQ6iVYRmcdOxT+sidMEXp0YHpS8gvxI02EPQy35/KKad++RbMNkI9PQgPyEbUwZql4SBvtZT1EXv2Zz3dXO8y/fZcX8eGNlhukXT37GwDNnMLwC5f936mPF5pzq1w14g0QkLW3PuujroucTdbPX0yaPd6NqMj4D8V+8LofUUJtOzWZQIzg79olQXiAgZHZN2KLqT0Sc0fUQcVOhqGakASAGtsJi+wIC/y22sL1k7oq7bVAPzITMy8Hbsa79UtedJ44phkjDHay75/OLJKv82cr8AjBu63qD6+vQUTSd3vRS9C4aW0RsjfbVwT5Ngwuun9m9NrUWph0HbbK+AH5uVs+6MOg2nEZ7A2k/uuO6VA8MIxFdyNgm6Cc4ky9ylqXFZf7uMgjXhJfQizG8o1gzmCXkhg0Ez/ufnUCdCDm/xKUWe+xfrwLXhmtLg39Fk0rMLBPv0sx727+LqE6MykZXQVKSOYkEDn0p2kmWWfd4EDgFJ3SpU9rnBGDb7VlRZWMBE13RSMq9dvzGyNt0GxwejlAB7evwSeW9pJyEqRvKAJk0J2jOZiOnEVQD9ALbTTMr6LRPm3OXtibPiyv8tA/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c23d99-1437-4311-9a01-08dd7763f430
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 12:42:14.0706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MioxWh2xuW7cbH908zE2COU3aP0fRy/AwOkmzWvxFnbeYSy5D6Jr77V0H9KBm/HX3fLsp6t+sHMnQYYShDGwCYRgTMMZoQTvQ+FRr/eryNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090075
X-Proofpoint-ORIG-GUID: Ra_1PuVTuAKyjDrXSB_9d6dpISSKPHnW
X-Proofpoint-GUID: Ra_1PuVTuAKyjDrXSB_9d6dpISSKPHnW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 4/9/2025 3:39 AM, Markus Armbruster wrote:
> Hi Steve, I apologize for the slow response.
> 
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Using qom-list and qom-get to get all the nodes and property values in a
>> QOM tree can take multiple seconds because it requires 1000's of individual
>> QOM requests.  Some managers fetch the entire tree or a large subset
>> of it when starting a new VM, and this cost is a substantial fraction of
>> start up time.
> 
> "Some managers"... could you name one?

My personal experience is with Oracle's OCI, but likely others could benefit.

>> To reduce this cost, consider QAPI calls that fetch more information in
>> each call:
>>    * qom-list-get: given a path, return a list of properties and values.
>>    * qom-list-getv: given a list of paths, return a list of properties and
>>      values for each path.
>>    * qom-tree-get: given a path, return all descendant nodes rooted at that
>>      path, with properties and values for each.
> 
> Libvirt developers, would you be interested in any of these?
> 
>> In all cases, a returned property is represented by ObjectPropertyValue,
>> with fields name, type, value, and error.  If an error occurs when reading
>> a value, the value field is omitted, and the error message is returned in the
>> the error field.  Thus an error for one property will not cause a bulk fetch
>> operation to fail.
> 
> Returning errors this way is highly unusual.  Observation; I'm not
> rejecting this out of hand.  Can you elaborate a bit on why it's useful?

It is considered an error to read some properties if they are not valid for
the configuration.  And some properties are write-only and return an error
if they are read.  Examples:

   legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not readable> (str)
   legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory' is not readable> (str)
   crash-information: <EXCEPTION: No crash occurred> (GuestPanicInformation)

With conventional error handling, if any of these poison pills falls in the
scope of a bulk get operation, the entire operation fails.

>> To evaluate each method, I modified scripts/qmp/qom-tree to use the method,
>> verified all methods produce the same output, and timed each using:
>>
>>    qemu-system-x86_64 -display none \
>>      -chardev socket,id=monitor0,path=/tmp/vm1.sock,server=on,wait=off \
>>      -mon monitor0,mode=control &
>>
>>    time qom-tree -s /tmp/vm1.sock > /dev/null
> 
> Cool!
> 
>> I only measured once per method, but the variation is low after a warm up run.
>> The 'real - user - sys' column is a proxy for QEMU CPU time.
>>
>> method               real(s)   user(s)   sys(s)  (real - user - sys)(s)
>> qom-list / qom-get   2.048     0.932     0.057   1.059
>> qom-list-get         0.402     0.230     0.029   0.143
>> qom-list-getv        0.200     0.132     0.015   0.053
>> qom-tree-get         0.143     0.123     0.012   0.008
>>
>> qom-tree-get is the clear winner, reducing elapsed time by a factor of 14X,
>> and reducing QEMU CPU time by 132X.
>>
>> qom-list-getv is slower when fetching the entire tree, but can beat
>> qom-tree-get when only a subset of the tree needs to be fetched (not shown).
>>
>> qom-list-get is shown for comparison only, and is not included in this series.
> 
> If we have qom-list-getv, then qom-list-get is not worth having.

Exactly.

- Steve

