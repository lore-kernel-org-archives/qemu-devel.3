Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFeS8-0005AM-Ev; Thu, 15 May 2025 15:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFeS6-00056e-L7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:41:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFeRz-0000Yh-5G
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:41:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1nwo028457;
 Thu, 15 May 2025 19:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pdAXJ91bb5BNsJhF+uBJHyPonsDSvQu+YvmSUyVn3RE=; b=
 RtX906CYRtKFC8iV18wqn6BYwGiEVS2+d3WtSvPKaCRZmtznP9dIvQIsryEf8Adj
 0EoCD0D/gcOoEa8RoerxTrUkdnbB1k4eDKkC8GqnsfdJn2tgXfXplb/sub7pUCtt
 Bc/je+LqMnThjeYA+GsGiprg9tKdVLZqfTKLNt3qzXaiGVtlkbkajQKAkKBbO8Fw
 S8CjLSoQ7bjjVy/YKIY1ApMryEcvX0aDgaVyw0huKczDoKQ58mSHSfb8HJrnfOkT
 jeqssRUTMyiLLbeh4EfmElYfQq8ecpFrP4a3aYUbgINhK6NifClimCzvhBBitypD
 f24HQmjSeuT/eN40NMw6xA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmn3tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:40:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FIVC8u026847; Thu, 15 May 2025 19:40:55 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbt9sks2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:40:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbnhrMsdgTLDPxoJW/mswUBjnuO0qCnKsE1XaeLPYunaL0QjxtoRP62+yTrSqlRga8cUpSM2XfpFIRbx4qiP/0+eP7LPUzhirnChX2bacKhNCYIVDyEjXLzY2dDsHgbij3hAXGpyBx2j07BXRXfsDr1x1aR8P4/NdSWr/K3rbkfor8KZAOGNAX7Z1j2qQ5L/RsLvrc5DJnNkIAifw3d+/MLXb/Y0eCJ8GkoIhFgB7US8JE9E6W42mTViPZqGkXCt+evWiSXJRzvywGHeaYilMnRmsrswfijN7YrBPP4//aL5eLcI7Pc+HuDyEAdpycqsRE3WbGpIrOtgdaTSTMWHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdAXJ91bb5BNsJhF+uBJHyPonsDSvQu+YvmSUyVn3RE=;
 b=PVrO4v/cb+wmarkytU92PG0c8dyjqZBRuPkOUFZ/T0iMEshRVVWNXgEnqfje5TC+8LAtzFVUBSgMJzp0/JBrImU3FJx0v6SyEb3U5koFTbCFVPcq+IBI1DbG6pZ0p2ChlpQo+tumJF8eYR8AGl541c2wiEUgMzzDL2IOL4gLG/KvOOsS4SnwGneYM2yvIeOvx/qi6QEuI/VjMIuWd9oPAjEcFd77jprdmxBqwfsOgLOlbGdASpjSnza9TcazGCH+X0YQzGJdJTXL/UifME2R2NtjCserK+EKS8YbXJwz56DE2Qf3zujM6xfYrqXv81aiMVmah1o15cG2U9hJbyL+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdAXJ91bb5BNsJhF+uBJHyPonsDSvQu+YvmSUyVn3RE=;
 b=PW899IyWcv8AwEDTflL1tHpOUIPXR7XWeBOUG3Lb/JoitQthjRXwrLKyOzjwC2SgPiWLqeHnwNPM1uo1Iibq0bhZzicDZHLyCikRBqrycqhusHXAC7KKP5jarPudXtkTLsJ8+jZUfIoR7A85QYHqVPnYzC+79/0PJAhGVkdoTX0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 19:40:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:40:52 +0000
Message-ID: <6d269740-b274-4046-bb15-7ce7f2784ca5@oracle.com>
Date: Thu, 15 May 2025 15:40:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 26/42] vfio: return mr from vfio_get_xlat_addr
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
 <49dad632-fd30-45fd-8dac-80c8bb446809@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <49dad632-fd30-45fd-8dac-80c8bb446809@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 570ec5b6-fd1f-4c26-4540-08dd93e866f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWVUZ0hvaDA3WTNtWjJIMUg5RkY5TGhkVThZeFBFTHM2Qm14TG5BcytkSU12?=
 =?utf-8?B?ejRjOURtVys2TGVBcEMycWg3SlM0aHFmZVBIcXpOSitBQVZQSm9sNmZ5a2F4?=
 =?utf-8?B?UGR6a0Y2OTdaUkdYNUNheFppdHlCM0lHK3BtdVVZcUNZVEY3UEJtTUwxbzFn?=
 =?utf-8?B?TWJqT2tybnpPTWtUdVdPUDlweXhYMXlJZ0treTBWb2Q4N3k3VWRBRGdNNXdt?=
 =?utf-8?B?elJZUjhNbE16QzdMckI5SEM3UTAzZ29VMWNJdmg2RmdBOWZzV01FdzVSSjVl?=
 =?utf-8?B?ZjUrS1NlU3RSakhsN21DREdkdU1KK0tPckwvK3M0a2hWWE5XYnBIaHdGWjlE?=
 =?utf-8?B?UDZ2S24raXdtZjN1ZkRTc2g2M0FHTTJ0cHU4T01jV0pVWDN2K2hnQkR3cWxP?=
 =?utf-8?B?YWppemNyaG5qeWUxWTRQRHM2TEpVT3NWbTFWWFJ6Ym1oQXA5RXBKVVFqU0ZQ?=
 =?utf-8?B?Tk5YSXlTc1h1RloxRFZNUy82bnhLWXNsckxaZVBpS2EyYXVyVkdFcVl5a1Rz?=
 =?utf-8?B?amRSRWwvMENPM29kcDlqbElRSUtmRnNzb3A5K01hVHY5M2RseUdvdFAxM2l4?=
 =?utf-8?B?azZrQm94aEJscWdEd3BsMkJ0VTBtNERiZEdHT2hwS3h0KzhwTENsb3p2cE5h?=
 =?utf-8?B?Si9BQlRJL05tOVdaay9oR0JxdEF6c1hObFZFbVp0cENlYnEvT0xWNW1SUmsx?=
 =?utf-8?B?ZU55dk5JMkxMVHU0Z01MNXl3bHljK3dScDA2alVyWCtiQjVKbWJrRjBveUJS?=
 =?utf-8?B?MmNvOTdYaG5yRENGY2RIaUNBS1NLSmIzZU01TXNJTGFmeE1mWkNWVTRZUTJw?=
 =?utf-8?B?Q0E2ZUhMOFBBNlJZV1dqMTBoWXc2UklOekJ5UzhxTktaU2NOUjBZdmRaQXZ1?=
 =?utf-8?B?VkFaZk81NnRoNjR3WTAvaWlXODBNVHZFc0NpcGZ6dnlzcnZQUXR4blJJbldt?=
 =?utf-8?B?UGVoVjdBWVMra1pOOFNxTDN6aFBVWllVQkIzV2hTVURMcWIxMzNjejZvNkFE?=
 =?utf-8?B?VUxsTjczZFZTSXlTR3lsKzBQYWxLMTU3ckxQVHBpQUQvYWVCY1BLMjN3NUQr?=
 =?utf-8?B?SGk2UDVGVVc2dlQwREpBK3pGdTh2aXV1b2JLcTJQZlg0bzBSRlNHVjBVcHhM?=
 =?utf-8?B?akJpaHNxMkw4akVxQTRDMVZUSnlJbGpyOVVaQ3dDY2VIQkg4R0hIZlhKVlZR?=
 =?utf-8?B?SkdJNVdSZ2dpWGZVNDBXbkFMWjlVc3NhMFc0dm5wZzE3d1FPUW9mYnhGNkxJ?=
 =?utf-8?B?aW5BOHd4c2hFdmQ3ckFKaWxOcWlaTFQwUkZjMUNZdmdBSWJvcVNpNUkvR0FV?=
 =?utf-8?B?TTBLOTVhL0NjOC95TU5KaFNFZ1NaamJMRW5KMnhLWGpHQjJPYUE1anFlejM1?=
 =?utf-8?B?emE2aDFSamZxRlpxemJuZysydDdKZ2hxR0k2RkNTTzdEYlduZXF2R050SVQ0?=
 =?utf-8?B?VlREREVLYnZLMU9oQ25KdmhnYk5FQ0xUVHBZR1NtWkdremR4RnRQUmxLTWlh?=
 =?utf-8?B?ZFQ5TG1xNUdEbUNrS1dJZUZ1VWxUS0trbGtEK0xjNmJDRnBUQkhESWh1Z0lm?=
 =?utf-8?B?Rmw3SncvS0I5MEpUTW5GazN5OUR5NW5ic0cwWi91UXVYdmM4MUNQT0QzZ0dN?=
 =?utf-8?B?S0JGWlYxM1RoYWdDa3ltYVhqZVhWbkxhYlNhYk9Hd09pbkVRTUZYcEVQbml0?=
 =?utf-8?B?MFpIWUk4OHpwRy94S3VxVDFjYkJZWjdDNXNXbGxQVHkySCtkK2hhOWk5bEJ3?=
 =?utf-8?B?dTViNERrWkJzbkVRN1ZHZy9mbjQ1aUtQYlFZOE96YWZzY2M3aDJqSk1Ebk10?=
 =?utf-8?B?QUZYSHZxZy8wTCsyMmpDL1ovMkhwSG9NRzBKS2thdFYxS2RxaC9tUFRsaU5k?=
 =?utf-8?B?a1dTRWN1SXJwQWhJSjM0R2ptOTNoenBBRzlJdklLRVJ3L1MrL0Jxa0NZSWJT?=
 =?utf-8?Q?myWwl+c+Msg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9YMEVZei9tNzV4MEEvZFRTdGVoZ2Q1dkVnSjAxZTAwbFpibGcwV3FOZ2xK?=
 =?utf-8?B?RWtxMEVZaG9pMUtKaGlOMkVjZ3NzbUEzOXlvT2ZiVE5uU0FOMDJKMVhmSlY3?=
 =?utf-8?B?bDUwdUFyS0tCcnNmV2NLajFQT2hvTHFadjQyTmdxaHdmVGhwTDFsV3ZQWGNy?=
 =?utf-8?B?VUVSMDA2b0lML0xFVG52UjBPdEtycVAvQklsWnFGa0VVaEpGS1hYSmZNRDE4?=
 =?utf-8?B?M2FDSzJJMFRsTVhKZE1xYnp6a2ZiVHdqVkxJMjBXbUxwbmVEd1hPK083TFlT?=
 =?utf-8?B?NkEwdVR2alp1eEFHYjRlcW1yQVoxN3JpR3JQRDFWOE00SkFTNXpnc0NKUTlo?=
 =?utf-8?B?cVU5NWtSSVFpeTN1VTdxTklJVTJ1TEg1YVQvckF4a0w4bS9YWVFCaTdSSGVq?=
 =?utf-8?B?V2VMTFpSaEtpamRyRjJZUGFuZEprQ3dsdFRlNUFpNXE4dlFNZlBLRXphN1VL?=
 =?utf-8?B?aFoyK21uejlidmRvUHpMVDkrVDErNkQxT2Jwc1ZRNFRMZjJydnFkY1lSMnRB?=
 =?utf-8?B?TjR1ZWJnbnpqN1doV09MYlBxQm5kMnZPUHhvN0JDeVhNejY0Rml3c0lWRUJY?=
 =?utf-8?B?a0tVcnFxaGlubzNlWnhQRUU5MEc5aGNxblM2QTlxeUU2UGtGYW9nK3Q1RU9H?=
 =?utf-8?B?Tldjd1YwUkFaM1lCcU9RZ3lkQzVLYTFyNklFWkRra2VNSzhuVmQ3NkVTTGdB?=
 =?utf-8?B?bGF0OTQ4WVVJMzFpZ015dk5IYWUyUTZOYlBDa2t5Q0diVEN4RjJudGN3THov?=
 =?utf-8?B?dUpmQzB2SEJCVE9ZUysyd21Xc2ZnbUIrK090eG9lbS9Wc3F4WkRoK0lGaUFn?=
 =?utf-8?B?dXJRVGhhSjFlN21XOHFmODNLT2doRmdkdGdjeGFuQkU5b2FUdkY5MnkxMDYw?=
 =?utf-8?B?R3Q2SEttTjlWN1Y1dDRzQVMwWkJ2aGQ1MlRpRisrYktKKzlhL3JRT2lRNmph?=
 =?utf-8?B?c0dmczBQdlpwMTYrUTVkRmx6eVlHaUV2MEJBTktvbStERWJOZnh5eVl1Rjg5?=
 =?utf-8?B?azkzbTBVMzRSKyt3SEo5eW4yNkNRNW1oQXd4dVpVd0lKRTQ3MHhPZEd6YzU2?=
 =?utf-8?B?bzk5UzdENU1vcitFOS9PTGtkYTFJeEh3NytWbUhmTXhQV09OM0dENmliQjBy?=
 =?utf-8?B?WVJwaXBkQjZ3dWVTQlNRcEhmRGlIdVYxNnNmRmg5Ry96dDh4QzlESG9LY0cv?=
 =?utf-8?B?L2o3aFhhbVpJZXV6S2w3ZUYrWmVmWEFRNm8vcVNwYUhTSEVSZDF6OTdIc0Np?=
 =?utf-8?B?eTRvbDFrVnVrQkhaNCtYYnJUeHV5U3NNMk5PWkNKelRRbjdBSUxmTS9SSDNM?=
 =?utf-8?B?cWpQVnRYekxPN3B4UllNbGY1MjR1c3pRMFF4Q0ZTMmZTSEQraHR3bGZWWGVV?=
 =?utf-8?B?eXpiOVNCYTFIczV1ckVSVC9NTHhIMVRGeUZKYWVjMWIwMFdOS0hLdlVEWWk4?=
 =?utf-8?B?S3dybkZZNWdBTlphcmttWWVYSGUxRktJbTFvekJaUkttaXNGRnVYZHZVMHk4?=
 =?utf-8?B?WmxmTDVGN05oTlNUZUxzSUV2VFBkNFM5aG5oR01yYlFwa21GSnV6UjBUZHdh?=
 =?utf-8?B?MzQzeGVVcXdCRkdwdU5iYTBLVHkvNHk0TnJ4QUVnOEhaeElwd3U4c3psMVoy?=
 =?utf-8?B?Wno4aHdVODZEVG4ya2NrL1F3YlFLdlRHUWFYS1pRbUdWb1FtTGlDSkE3N2lZ?=
 =?utf-8?B?dU5tUFpPdnRMSi9nZjNoSGo1c29MZE5rRzEzeE5jR0VxSXp2NlBjak1YVnJP?=
 =?utf-8?B?eStSbnVGY3dyZDUrc3JibXNqeWRNdEpaMEdCR0UrN1pMYXNDMXBUZWhZQXhD?=
 =?utf-8?B?NWx6N3NGSk9VeTZtQ3ZhSUVKZXI0MHBWdVVmeTUwdGhaK2VzQjFHa0g0Unhr?=
 =?utf-8?B?UzZIejYremxDRHRQMnR6VVNUQUUvVEV6QzFyNHFnRnpaT0NFR1dWcytCeTRD?=
 =?utf-8?B?VmYxRG5VWEZZeVJzRGRtd0k4N2Z2N21xcjdJbTJ3T2YyeEVuZTdPcXdLUktP?=
 =?utf-8?B?SjRyS1NPYk9EK1p1a1VWcEJsak9QK3JvU2libTFacmFWbHdEKzFNOU9lS0oy?=
 =?utf-8?B?YXo2ck4zQkNzUWhqWXN5cTE0Tks4NDNlczhTYit4ZmNWR2Z1T0tvWGgrL2VD?=
 =?utf-8?B?WWVPVjB1Yy8rWW0vWGlEeUJnZXJJbzBnNStKeEN4WWY4QklHSUVqNUhDdldy?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7+DETk9B8O+fSeZIh5Zlm9doDo5sEyZnfU2ti7mZwh+Owsb8+E3xdqBID3Ns4n/YL3h+rqz5jT44P3hQHKpWXcPXDrFRGzaUCF3BRQFyH924iFV3pgddL7UKXqI279aRfrIpAnmDe8RhLMmdvwC2yhzNFXRqLwOVPTYsE9C4wfY2ibTKjsgQLPdwly7MH6s3E4kN/8eFTkKyv/3zGahYa7QfxzUjJ5Eo6LGrVJElol9QEoHOCdl5mucubjdDyo2vtDumns6314fOOpfJw00d3Ilr5z04T1bCbCJ/BysSlCrReKhdxmyWkwqBixO3N98sUCSIIWHcxOw9hREaAsNQ4NxukqYHZ8v8F3pJchbBPBwSwabaU/XpxniBjcRvNSab63Zv5rwcg8tlwmTYBsGQ6NnGCw5/Hz9juudxg7I+siec/0DaICLc3D4r85Ld4zbmHT5n6rm8Dhn8uI9kRmf7nKklWeNcX3sUXCBu2X2IPvpK3BVYRC9tuVJKx2QNDmJis6of7kMAe3x7Be/3vRYuqGfHJje0Ls95r+Rl+23roFpaIcO2xRlxOeKW/AHdOcIl8HqsB9IEDgN0n499mqgtcD7gFbSHiOb3g40D8rbVxsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570ec5b6-fd1f-4c26-4540-08dd93e866f5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:40:52.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckCjqwoIXxu0UTvTlkLf2fEGg0RYhqM3ZDlc1F/VEDZQNsZuCzPwSf+j32j9Z3isaxBQP1W2tsLb+aGL5v7tcOXxek+39onGTQkMYZbV1iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_09,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150194
X-Proofpoint-ORIG-GUID: G3D4OZr5JXHOWg8low3OWfmlsCJi8HKx
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=68264349 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=Xmw0dQW0L04pwpxZ2r4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE5NCBTYWx0ZWRfX+gudVOzzWfUz
 5XhmGfSy0fum6+NvLHwtumnORUahke6Rnvf3pZUIAgULC7sPZs+5KQaBrhhFRa5v60W2cfP5gm/
 RR46p9s+Daal4QYZTgHHsuGLFt63rKSGPh3koszNJq33K4X93MxReoCBRgECsaWUXX5SR/xn7Rs
 +Mnx7ry0ClOjXYCxmgBureqehYm5OvfAhMyv3mrNKBGbfs5PeEuyAid+Q6G9SIw6QiK8i1qSHDW
 SF6+/sp+363sQbf9eFMGMkDPEJjiOEfXFLZMcuty+RllLPF3SBM1PNVF6OvIMQGt6qXrjuUtKEC
 lRVmzsLH7ceQTPyCHaxrokXOWSKVdJO8EJ64fWMZP226YkYdyxJkV0dMBWG0VxLfEil+BEF/s3E
 ES3u6P0SjBNc7AtAi0Xy+7p6177wyuWGu2pHLTZGR1NN6SBuCG5pJEeuqFe0cFRF9LgcNr6H
X-Proofpoint-GUID: G3D4OZr5JXHOWg8low3OWfmlsCJi8HKx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/13/2025 7:12 AM, Mark Cave-Ayland wrote:
> On 12/05/2025 16:32, Steve Sistare wrote:
> 
>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>> region that the translated address is found in.  This will be needed by
>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>
>> Also return the xlat offset, so we can simplify the interface by removing
>> the out parameters that can be trivially derived from mr and xlat.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/listener.c      | 29 +++++++++++++++++++----------
>>   hw/virtio/vhost-vdpa.c  |  8 ++++++--
>>   include/system/memory.h | 16 +++++++---------
>>   system/memory.c         | 25 ++++---------------------
>>   4 files changed, 36 insertions(+), 42 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index e86ffcf..87b7a3c 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>              section->offset_within_address_space & (1ULL << 63);
>>   }
>> -/* Called with rcu_read_lock held.  */
>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                               ram_addr_t *ram_addr, bool *read_only,
>> -                               Error **errp)
>> +/*
>> + * Called with rcu_read_lock held.
>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>> + */
>> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
>> +                               hwaddr *xlat_p, Error **errp)
>>   {
>> -    bool ret, mr_has_discard_manager;
>> +    bool ret;
>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>> -                               &mr_has_discard_manager, errp);
>> -    if (ret && mr_has_discard_manager) {
>> +    ret = memory_get_xlat_addr(iotlb, mr_p, xlat_p, errp);
>> +    if (ret && memory_region_has_ram_discard_manager(*mr_p)) {
> 
> I'm trying to understand the underlying intention of this patch: is it just so that you can access the corresponding RAMBlock in vfio_container_dma_map() in patch 31 "vfio/iommufd: use IOMMU_IOAS_MAP_FILE"?

Yes.

> Given that the flatview can theoretically change at any point, it feels as if the current API whereby the vaddr is passed around is the correct approach, and that the final MemoryRegion lookup should be done at the point where it is required.

The existing code already guarantees a stable address space when vfio_container_dma_map()
is called ...

     vfio_iommu_map_notify()
         rcu_read_lock();
         vfio_get_xlat_addr()
         vfio_container_dma_map()


> If this is the case, is it not simpler to add a call to address_space_translate() in patch 31 to obtain the MemoryRegion pointer there instead?

... so it is simpler and more efficient (saving a translation) if we simply
expose mr->ram_block in that range of code.

- Steve

>>           /*
>>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>>            * pages will remain pinned inside vfio until unmapped, resulting in a
>> @@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> +    MemoryRegion *mr;
>> +    hwaddr xlat;
>>       void *vaddr;
>>       int ret;
>>       Error *local_err = NULL;
>> @@ -150,10 +153,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
>> +        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>>               error_report_err(local_err);
>>               goto out;
>>           }
>> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
>> +
>>           /*
>>            * vaddr is only valid until rcu_read_unlock(). But after
>>            * vfio_dma_map has set up the mapping the pages will be
>> @@ -1047,6 +1053,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       ram_addr_t translated_addr;
>>       Error *local_err = NULL;
>>       int ret = -EINVAL;
>> +    MemoryRegion *mr;
>> +    ram_addr_t xlat;
>>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>> @@ -1058,9 +1066,10 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>       rcu_read_lock();
>> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
>> +    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>>           goto out_unlock;
>>       }
>> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>>       ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>                                   translated_addr, &local_err);
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 1ab2c11..f191360 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       int ret;
>>       Int128 llend;
>>       Error *local_err = NULL;
>> +    MemoryRegion *mr;
>> +    hwaddr xlat;
>>       if (iotlb->target_as != &address_space_memory) {
>>           error_report("Wrong target AS \"%s\", only system memory is allowed",
>> @@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
>> -                                  &local_err)) {
>> +        if (!memory_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>>               error_report_err(local_err);
>>               return;
>>           }
>> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
>> +
>>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>>                                    iotlb->addr_mask + 1, vaddr, read_only);
>>           if (ret) {
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index fbbf4cf..d743214 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -738,21 +738,19 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>                                                RamDiscardListener *rdl);
>>   /**
>> - * memory_get_xlat_addr: Extract addresses from a TLB entry
>> + * memory_get_xlat_addr: Extract addresses from a TLB entry.
>> + *                       Called with rcu_read_lock held.
>>    *
>>    * @iotlb: pointer to an #IOMMUTLBEntry
>> - * @vaddr: virtual address
>> - * @ram_addr: RAM address
>> - * @read_only: indicates if writes are allowed
>> - * @mr_has_discard_manager: indicates memory is controlled by a
>> - *                          RamDiscardManager
>> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr.
>> + *        The MemoryRegion must not be accessed after rcu_read_unlock.
>> + * @xlat_p: return the offset of the entry from the start of @mr_p
>>    * @errp: pointer to Error*, to store an error if it happens.
>>    *
>>    * Return: true on success, else false setting @errp with error.
>>    */
>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                          ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp);
>> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
>> +                          hwaddr *xlat_p, Error **errp);
>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>> diff --git a/system/memory.c b/system/memory.c
>> index 63b983e..4894c0d 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>   }
>>   /* Called with rcu_read_lock held.  */
>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                          ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp)
>> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
>> +                          hwaddr *xlat_p, Error **errp)
>>   {
>>       MemoryRegion *mr;
>>       hwaddr xlat;
>>       hwaddr len = iotlb->addr_mask + 1;
>>       bool writable = iotlb->perm & IOMMU_WO;
>> -    if (mr_has_discard_manager) {
>> -        *mr_has_discard_manager = false;
>> -    }
>>       /*
>>        * The IOMMU TLB entry we have just covers translation through
>>        * this IOMMU to its immediate target.  We need to translate
>> @@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>               .offset_within_region = xlat,
>>               .size = int128_make64(len),
>>           };
>> -        if (mr_has_discard_manager) {
>> -            *mr_has_discard_manager = true;
>> -        }
>>           /*
>>            * Malicious VMs can map memory into the IOMMU, which is expected
>>            * to remain discarded. vfio will pin all pages, populating memory.
>> @@ -2229,18 +2222,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>           return false;
>>       }
>> -    if (vaddr) {
>> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> -    }
>> -
>> -    if (ram_addr) {
>> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
>> -    }
>> -
>> -    if (read_only) {
>> -        *read_only = !writable || mr->readonly;
>> -    }
>> -
>> +    *xlat_p = xlat;
>> +    *mr_p = mr;
>>       return true;
>>   }
> 
> 
> ATB,
> 
> Mark.
> 


