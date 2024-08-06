Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF37C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 20:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbRET-0001tA-Oo; Tue, 06 Aug 2024 16:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbRES-0001sc-Lb
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:56:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sbREQ-0001f1-MQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:56:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476Em5Vf030468;
 Tue, 6 Aug 2024 20:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=3Oq3CoLEdcfEI2KIzWMXKyIWtzRQcGJGcp9X2COykt0=; b=
 XyUyY8DA0GD1FyUoEV03UEdJxAJgsRDBJXIdOpME5e2AXfumd3anXiZUH1dUwg7e
 U5Nv//FaYvEsTF23ULWJ4f3zHQtDFygHjsSX57piPuGvi9uCLBYZq1PNVyMmI9mh
 V8ic//jEWqtOekEhy/xQK+p+iYwXs2YQNGFhBZaz6G+SGuVwLzO+L2TKb25OsGJi
 QwRpXZ9ixWmd/8GbHRblYi6de24q5CeiR8KO+EUVowX/3QHRQiKF1XYW8ZH+1h8g
 L+vCXNzEk7BBqvTZvq70UN+RGLOG6qR0vZxv53zEyhIzjEKoFhIntpOkw+jtgimT
 Ni+M29TISoB+T03Cq2wecA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce966mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Aug 2024 20:56:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 476JPZqT017007; Tue, 6 Aug 2024 20:56:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40sb0agbks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Aug 2024 20:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkgTCwOV9cB4B5o8cE1WNSK1QWpUa4XY7d2l3L/mYMbKncNuqfpZvl/Obxy7CQs+0JO2n8ieOpAkSNhrRoLP23n9u7sn63Bi9EEeo8G3ADrJH+6DZrlao55gPgOpg/AcuULW7P4TC+9bYKwqHdvtyQV6WQejsPPV6ekseOt2l+4HUfkl4eXuhNif2qLnbwaD2CIlxavHy/171pKxi63pt24INsB84A/InREHe5nEFi09MDRcr2eKTmu2Pjg7s14Y6mm2/y0C39AD70WyA6niaBTQzZlwwMp9vt/4tzJmMhcc6nFidG6KmW093/f+x6/jkDU7GLIGCWKPwpKKJRnV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Oq3CoLEdcfEI2KIzWMXKyIWtzRQcGJGcp9X2COykt0=;
 b=otBG6YxZjg0LcHafiNc2ddek4gsP4i758bhCYzkMLpni9uEICqkgwDQ0586Szxc+Ixf12HGAtvbqo0zk833hU1MQlUF9GTXm9DyLJ46/FTsgBRxKJZ29M/PoajZOpfaDHqr9nZoANP6htRU+TvlUxbgPmOY2a8s92OfwqeVWAiba9EfYA7wn0pAtFu6SQC4rlaSaZ2WexWVXHLBX70nMflRR/JxUcz+uEE5u/s4l9p3Zjjm9xv8uwoypU+ZZ4DJCD4kJH65yk3TJUH7DWsQMMFbFApFMKEfco/I1p+7GViSE8eUiOwm3DQPw+552br6qCC3xefH9+1sV3cPPg59ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oq3CoLEdcfEI2KIzWMXKyIWtzRQcGJGcp9X2COykt0=;
 b=cx9GPu+8awu5uetbJID+qcBGBBjKmTHERU6ypLaC7AhNVvx5Fj7dyu4EF4GfkEv5KreiZxMcUEXOlON4sKOZsYhb+GATfzDhKexS4piQn+vK1QG6ZpOQ8FBehlsEGPNScWzzCsIzT3q6JoeV5z+d6Q0jtKi6rD+zA6Y8lqU6FY8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 20:56:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 20:56:25 +0000
Message-ID: <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
Date: Tue, 6 Aug 2024 16:56:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZrCi8DWCKFiBHQAQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e19d5c6-b5ed-4d1f-69f6-08dcb65a3c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2pVL25CWklCaUFMc2hFcjVDbjRUSm5RUGlCNDhydFIxaWMzc2UyQW9rZm9N?=
 =?utf-8?B?N3VSTlE5WWdTMzVVU0lFbXVmYmJDNEdtUFhPUEZ1RFhsZ0R5TTZreUpZcFZh?=
 =?utf-8?B?RlJWeFR3Tk5Ra0ExRmJJaU02MFVZY2NWdEFHRllZSUJwZ3Fmblo1cWZOOUl5?=
 =?utf-8?B?QzVwUS9SMmFncjBaWVpycVFNVGFqYnBkb3ZJYy91R2xtWnRuWnRldEpCc051?=
 =?utf-8?B?MEZzSy9aWlpVSm15RDRXQVg2RXlySm1ITVBWQkJDd0pFWUpDYzBoa1RVRkhH?=
 =?utf-8?B?MzlOTEx5anBGRDgxN3BtaytzeXdJdVZwenJ5ajN6SkNHVVVwR0p2d1VQOTBy?=
 =?utf-8?B?OWRtbWlzZFVWaHF5RTJjTEtyWmVDR1hUblA5dDJZL0NUeTRaelBmMXdhYkZM?=
 =?utf-8?B?SDY3MHdoUFpyVVNOdk5nTXErMXFDL2pIa0pTcVRrS0ljN3hXNFhOSVBKK1Ft?=
 =?utf-8?B?dmdNTVFmUUtLcTUrKzkvS05pSHNhUzY4MU1nckhUSWpBMllmUDREbGNPYjZM?=
 =?utf-8?B?N1I2WHZtSWVKRHQ5THU3eEZKMmRHQ2JKcEtEcGhRSlFxdFdlRXRraUlLN3hZ?=
 =?utf-8?B?L0pFejJlcGhjZ1NxZnVFUWVyRmZncEluNHVxeXZjNHpvRGFSZmFQNG11YjFS?=
 =?utf-8?B?Z25yc0ZQck1Bb0VmNU1UMVR1ZWp2c1lTZjBDYlE5K3VrUmVaYVBEQWtTbVFs?=
 =?utf-8?B?cXI2TjZUQlJSNXJocUZoSGxLR2xUVVk1RlhVTGs0amNZSXFVODRNdU1PM3FQ?=
 =?utf-8?B?c2szRTkxNEpwUzcxWFlub3hBVnA0bWpOT2pDNmlSTXBIbTlaRTVzeExkMEtD?=
 =?utf-8?B?dVMrRWFuRWNFUzI4bGFjUmw2UUpXWElvVGhIQVdBUE9WVnhZRFFCTi9qTTZW?=
 =?utf-8?B?S0RJODlsK3NESmIzSVhBVDdoWDdnWjFqaEZrSzcvSjVYbm9aZi9wN2VjVWRj?=
 =?utf-8?B?M2Y4ZldYMkdPUFA5QjJvdk93WjErL3VLVHlmRUZsVlY4L2FSSldXS3RVTG0y?=
 =?utf-8?B?NE9SMnU0dUNCWHRSYWpERWp1NCtaaDdZWnRIWnVQb1RQS08rb0tWVHVOQ1J2?=
 =?utf-8?B?a2JpTThiWFZ0WnlMeS9uaDUvSXBld2lIT3BhNGxYVklXMWtGTmV1NnpNWDlZ?=
 =?utf-8?B?SUZJQStXaUpkcmg2aTFyWmp4cUpaTnExWG5BSFJzM1lIRm5IK0Q3WCsxL004?=
 =?utf-8?B?aVVCdWh6aDBtR0taU3JiYm02ckZkZ2xIai9uQUZXRDRKaEgrZ0RmYXJFOTVQ?=
 =?utf-8?B?S2RpeUlLRytublFhTlNhNDFlczFaM0tVTnA2eloxU2hDNkZid3Y3SlhZTzZp?=
 =?utf-8?B?MFJCZ0pLS3hVYzNmamhhbWlsOE90VVVQWXdHS0JxTFdReXBkQ1lMeFdzZURN?=
 =?utf-8?B?Uzd4dzRnNGZmckdFc2NVSXBiWktZRDRDaUlqdU12MW5xSnRDRE5NL2c4QWFR?=
 =?utf-8?B?VCtXT2ZqWGlLZEdwMUtQQmJrWWxpb0orWjZTRlJUTXlQYnFXT1owbHZxcHFp?=
 =?utf-8?B?MGQ0QzJLNS9Vd1ZUeS81N0I1V2gvVWRxMS8zVHVxN0ZOT1A0Um84TU00ZFBQ?=
 =?utf-8?B?QzlmZWFFVHNLejFqbWlEZGlKZEdVZ1Bpa1RrOVNaZkRzTmlhMXdkNllpRW1P?=
 =?utf-8?B?ZTdCSkhBbHJxNDBvY25kenZLR2prZ1lCNmZCMXBrNWU5c3ZYOXZDTnZMNXFZ?=
 =?utf-8?B?bWliS1RuQmtGbWl3ZmZEa2VhNmVMQXN0NldjOXNUSE81U3NyYkJaTXdzUlBj?=
 =?utf-8?Q?qkGSnPSOhNyIRZma7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFE4YTZRMmx4TTVnL2VUNjBuTHdRd2R6eWJNcXRMRzA4aHhCb0JpZXUrbWsy?=
 =?utf-8?B?MTZQNjFwRGtjSWVEbWtLMTI0L2tpQ0ZhMHVsSWpBV0hESXFVZ3VBTXRYdDhu?=
 =?utf-8?B?VWF6NExhYW1GVm1MbzlPblhCdzBSWTJjY0lYSm5SNzhqR0R6dDdhcUZKOEZD?=
 =?utf-8?B?Rzc3VGZtUWxKNnAvZWNkc292WFduK2JUSm1hZzdwVmpYZm5GY0M2bjJ6Z1Ev?=
 =?utf-8?B?VkhuSndZMXYxTXVROEhudUZMRytWNjVpdldFSG5id3BoOWhrV2QzVEswUVBw?=
 =?utf-8?B?QnB4TVo5R20yTzgzN3VZNzV3aEVMQTJ3ZW5hT3VML2VMYyt3OHRra213eWln?=
 =?utf-8?B?OHRuNDNjSHg2dTZlMWNYb0plbkFNYlZsdi9hNlRVeCtQQWd1UGZId0NUWm1L?=
 =?utf-8?B?SHhsdndhZlhhTnlsTWYzWXJxekNQUmowS2RTNnk3dElWc2dYRzlucHVrTFgr?=
 =?utf-8?B?dWpmMFNROG9hUUJjSTRxazhRVFlBVVlZakpGcjg1VmEzb3BpN1IzVEtYVVBo?=
 =?utf-8?B?RTFxTnFMaUQ2Zlk2RzlTZVI1cU1DZjhDVUk3WnJHV1k0Ly9HeEo0dUtRZ2ts?=
 =?utf-8?B?dnlYNGwwQlFhcEc1NUhvQk10TWpPWVdqMHprN3llTFZlU1EwK0NqYko0SnV4?=
 =?utf-8?B?QjJMc0NwaEFjYnZIdXFmcUs4VHVpZVRRb0tNZFpoNWVQVHZtUElDY0h1T1dU?=
 =?utf-8?B?djBtTkdTcHNlTmFjWDFiYUNyWCtscnA0ZUJQaHJleHJxYTdpeklXTW13bnZW?=
 =?utf-8?B?S2JYVndlcW5yVmQ0RC9DOHMwZGJuTWpZUHltR1ozbGNlaDdVOTl3YkhjOE9s?=
 =?utf-8?B?UnRCUHNMTUY3dVliVnVTTjRoWUdQRHkraUZOUS9hNWVZRjh1K0hOeDMwSEw4?=
 =?utf-8?B?OHA3K0lyZGorSmp1Vmdub0FENG1FM3N3N0Vxd3hpVm43SlRIdk1aRDJtVFp6?=
 =?utf-8?B?VWlKWWRrbllaUm9iN3k5eWJEdHoyaWt0M3BvbytUK3ZKTVRzTDBJdlFrUlFl?=
 =?utf-8?B?RGpoSDNBVGYrSXlnSnlWRDkwTURDTDVFMjhGeEhWcmRzODNnZEt2ekRPamgy?=
 =?utf-8?B?NDZOQ1FvcGZ2RFVEQllNL0JHTjgzSlR5eGlybm54Qk10bFhYM0w4RlNLRXV0?=
 =?utf-8?B?SW50SGhvQldUdEpiZ3VkeHFsY2pzT0t6K3JxTXp5RXVLOXFZOWhOc3NoRXdy?=
 =?utf-8?B?a2VxY2RSWms5UmhNZzhRZ0tYUTREL1NuR2ZpdGdEb2lMbTdXU1oyUlgvQktp?=
 =?utf-8?B?YnJhMDVvdk9rWEpIZzB5QzhJT1grRTFaRE5sMC8wRFI5T0JpVXJZMGQ4Nkd3?=
 =?utf-8?B?Qy9RVTRaMHRERW1tUWYzK2gyd0ZQWk00MWVkTDl1ZmhBeDRzdnBlNG9jRzZk?=
 =?utf-8?B?aklSSGRpOWROa1BucXVDaHEvSU50V1JHWTY4SmxBYWZKMmoxK3l0cDEwOEk3?=
 =?utf-8?B?Z0VOMGY4ODBsNWpEb2EvbnIreFRKTHpFV0tYOXRPUEtyajhPakY0RzlEczZN?=
 =?utf-8?B?K2FPVWpTdDJDWmZNVU5QdGZhbkpodlg2RFc2V2g4S2RSZFRUQTZ4ellrSHdo?=
 =?utf-8?B?QVpZRlU0Mmx3MzczeGdPVVFLQzNBVHJsV21hVVZ5TWVGY2ExY3d4TWxHTFl2?=
 =?utf-8?B?b1JuNEh6WXlrUXB4c3NJQlp2MDc4NVNZQkJGM3NlWTRkY0FRaS9ISFlZOXlH?=
 =?utf-8?B?Uk1MTVg1VkY3eXdSeGJVYlpNeUdXZnNISzZ5TVNJbXRJV1RrNWdpZUZmUkNy?=
 =?utf-8?B?aFhpcXRtazd4ZEhPOUtKMnk0WHE1aEFERGlONi9SSVVaQVlCOGZYYnhPSG94?=
 =?utf-8?B?cVYrWEhCZzluLzlwRTZKazVoL2hGdTY2dnNiVEsvLytxWENhaEJBRFJMV1VP?=
 =?utf-8?B?UHVOMG55b2hMRkIyUW1DOHVEUGczV0tUeWd4VDN3THJzRmNSMzJURjNOb3dL?=
 =?utf-8?B?UEJWWTAzR0xnS3JyZEw1cGN3VDY1YXk2SUNXR1JtOTNjTWtjT1Z4YTBKMFBp?=
 =?utf-8?B?Q1k5UzBkVnVHSzJJU2s5QXhUb2NlMU8zNS91OEFRQ2pnODZkN08zRUVUZ3R3?=
 =?utf-8?B?dXFzNnIxU0xINzY1TWZaRkF1OWF1TmFaUCtVQTV4U0tyS202b3BWRE9YZi9a?=
 =?utf-8?B?UVhCRGNPaVkwVUdxbEdLc0o3UVRhQ1U5aHZBQ3NrTTJNaWpNZk5SUUpBc21x?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8toHB+yPdoPnrH5uhcRgh8yoU1bUj2d5URSv8zoKDmQI3TKLTaPNdyE5s5vR3ucswv1g2bCgOiDX3BcdbWdKAELUE9AQxier08b2ecNsgH3iaW8k83YyoukByN1po9/7IRRu3LITbSHnzgaZyR1dyzS+pUNKwNMvbSUROKXK8pjF4IuoMeKSyMXxyrwhDXtI34CAFeaoqTxParKkfswSUaDTzqpI0LHIhLS/PWjPTqLfzOBdol3OA71wXHpGUtnbH8PFBJC3LRAOh9h++8uL8iSlo2ZxgnFz8aN7q5RF+5LGhux1ZHXxNBvFjzta7yrjEy3PzdidluG3Sez9uplI4REvLDanmlk82SSU1YfwNO2hE4IYvIolE3Yva/agFKe5IR6v1bPzuWLMRB43gDZO52uOzZ54a7BHJyzI0qMtQQhHXWr0OG9NamAxMMM5VcYaBd5gQn84pJQRc+f8Kjt9ggU+rGC7amTjtQvPNIAtuEHM4szp76a9hJQ9lfBvnAYJgHosg4ZN9CWJbCPgVukzSRLKCx/lj12xMahuBItpOQ0+WzrJ92rHhTAhACxu+Gdx9XpyvW53wCfZi5KMYjQWzGZPcOYM7pEnmKD4fiwg88c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e19d5c6-b5ed-4d1f-69f6-08dcb65a3c45
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 20:56:25.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIkRhhPFJxnC+K5ZWhb/owTRRzwAvvLtTetCXST25Vsh765eyob9F0ui2WmyeEkEyFmv6l8iRr0hVGIZKmLrc+PsuIYRAA7fX9wd5oUIyEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_17,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060146
X-Proofpoint-GUID: NeC4wUqpmC5xqukK-yI4RztF9CEf9-3Q
X-Proofpoint-ORIG-GUID: NeC4wUqpmC5xqukK-yI4RztF9CEf9-3Q
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/5/2024 6:01 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 18, 2024 at 11:56:33AM -0400, Peter Xu wrote:
>> Steve,
>>
>> On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
>>> What?
>>
>> Thanks for trying out with the cpr-transfer series.  I saw that that series
>> missed most of the cc list here, so I'm attaching the link here:
>>
>> https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
>>
>> I think most of my previous questions for exec() solution still are there,
>> I'll try to summarize them all in this reply as much as I can.
>>
>>>
>>> This patch series adds the live migration cpr-exec mode, which allows
>>> the user to update QEMU with minimal guest pause time, by preserving
>>> guest RAM in place, albeit with new virtual addresses in new QEMU, and
>>> by preserving device file descriptors.
>>>
>>> The new user-visible interfaces are:
>>>    * cpr-exec (MigMode migration parameter)
>>>    * cpr-exec-command (migration parameter)
>>
>> I really, really hope we can avoid this..
>>
>> It's super cumbersome to pass in a qemu cmdline in a qemu migration
>> parameter.. if we can do that with generic live migration ways, I hope we
>> stick with the clean approach.
> 
> A further issue I have is that it presumes the QEMU configuration is
> fully captured by the command line. We have a long term design goal
> in QEMU to get away from specifying configuration on the command
> line, and move entirely to configuring QEMU via a series of QMP
> commands.
> 
> This proposed command is introducing the concept of command line argv
> as a formal part of the QEMU API and IMHO that is undesirable. 

Actually cpr-exec-command does not presume anything; it is an arbitrary
command with arbitrary arguments.  If in the future QEMU takes no command-line
arguments, then mgmt will pass a simple launcher command as cpr-exec-command,
and the launcher will issue QMP commands.  Or the launcher will send a message
to another mgmt agent to do so.  It is very flexible.  Regardless, the API
definition of cpr-exec-command will not change.

As another example, in our cloud environment, when the mgmt agent starts QEMU,
it saves the QEMU args in a file.  My cpr-exec-command  is just "/bin/qemu-exec"
with a few simple arguments.  That command reads QEMU args from the file and
exec's new QEMU.

> Even
> today we have backend configuration steps only done via QMP, and I'm
> wondering how it would fit in with how mgmt apps currently doing live
> migration.

Sure, and that still works.  For live migration, mgmt starts new QEMU with
its static arguments plus -S plus -incoming, then mgmt detects QEMU has reached
the prelaunch state, then it issues QMP commands.  For live update, cpr-exec-command
has the static arguments plus -S, then mgmt detects QEMU has reached the prelaunch
state, then it issues QMP commands.

> The flipside, however, is that localhost migration via 2 separate QEMU
> processes has issues where both QEMUs want to be opening the very same
> file, and only 1 of them can ever have them open.

Indeed, and "files" includes unix domain sockets.  Network ports also conflict.
cpr-exec avoids such problems, and is one of the advantages of the method that
I forgot to promote.

- Steve

