Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC328C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwyF-0000eP-Ib; Fri, 14 Feb 2025 09:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwy8-0000e8-JG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:47:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwy6-0001zu-EB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:47:03 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtVkI001534;
 Fri, 14 Feb 2025 14:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=BaYZ7/I1IAbXNUNuLMlUTBUOjSdmF93i4hgD2+mr5DI=; b=
 gkWS5B4YtC2FsxcbjhPYNPtwYQT0K3Js6+LE/kiSCCzmm+I2z63ZMbZldwsCPc9x
 TE52HlCuDZuCkr0vDDyOcRemuOG2XuH4bK3zCvfSofBQfNCAU1dvxe1uVeOeXZfN
 umAOYaxiUmfzgkxR+SPy52IoQ3t161s5vTyQthb4BDpg3a7HsusA8Fc4Q+hSBhbR
 11Xn49fwF+pU5WpcNc51PpqyzrbtKOx94LpqTvXu/uB4VnSGGxptKhzxV7n0tgPj
 MbSJraCGifLlK8PTMYkAj54WVGKijtu7mhGAPKOn/TAyr0TTNPddlMupfoOsrm5l
 3mnb+hvY5ysnC8QOVOgpOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2ktpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:46:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EDsvir016134; Fri, 14 Feb 2025 14:46:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqdag79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU9xd8ePHFfyyNct6xkZw1BRBW9eJijDNSane7UqiTtsTdZbUQwT9x9chR0mZf1hv59B/9PT3VpezELas3x3R1nvSAO4kVraSfi3f+/WZ8eW02/ordfDAOKUt9S9UJaWvqHCpK53CKfaLMX0YTaq21g7FbQcSNDgfFzE6bmyFoc3WQdixicyTXDuX6ykaYIBXf674gT6g1g6xwl4Fo15ittt+uLJZ2okLC6sBl3BpxBIuj/W6C0vUO8rQKF9BH5ajD7a6NTQ8P+mfQvty2MrISZr8207PglaOYPMEIXlogPNdDmvP9wTQ1BDcaIVhPC3IrGtjLYE3pVacnnFPcja5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaYZ7/I1IAbXNUNuLMlUTBUOjSdmF93i4hgD2+mr5DI=;
 b=kUb9iHybVLizMIDKZvlDQucpy4P0J2g8xIG3MmCey9raU9P19rx0GRLNudfcMEqSDKSqoW8jbFgj8ThQk++Owg1ZxtlqMyw1valcdI/Ui+b7R8Th0rOUhX98tIiymyQNXXYxJcxCm3yusJCn0vTHHFx0HpyTD9Kd+JkqtyAhqWSUKERn5UGHsC9AIPvilZqjqS+iORhM0XZhMwLBI3oer9StYIFIZAva2J0DGtm6EpvNLMqOYNQGYeaGckJDN1Ij7n1Br41ljseekaMfpo5jv4noZDlF6LuJchYy6g/rRXY6WAkb2VdYq16V1A8ddvejLOwpJT4CupUbY7mhrF7Pmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaYZ7/I1IAbXNUNuLMlUTBUOjSdmF93i4hgD2+mr5DI=;
 b=b6f+zC2rJcLNFxzcQRKpvtoAGzUWIh5ap2o4+MmqCodHmJ+dN4cDEf+KIpOs22VrzSFLJeOEY0YEDOaDvfbHxlzCRZSAA2Fa0nJVOa7T4mZ0X8uFJxRUSk9Pu57yhlTAJ/Gojxfm7ISN4cuF0OsEeTnomZewH0vQK0H/5yf96Qs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6489.namprd10.prod.outlook.com (2603:10b6:930:5f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 14:46:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 14:46:55 +0000
Message-ID: <a05c2040-e1d7-4bbc-baff-eb8ed4a6d415@oracle.com>
Date: Fri, 14 Feb 2025 09:46:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 15/45] pci: export msix_is_pending
From: Steven Sistare <steven.sistare@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-16-git-send-email-steven.sistare@oracle.com>
 <ee59365c-707b-441c-adb2-4db4e7758cda@oracle.com>
Content-Language: en-US
In-Reply-To: <ee59365c-707b-441c-adb2-4db4e7758cda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 201383fe-c846-4348-fdef-08dd4d066d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzl6cDBTblNJUm00UDlSVWs1Y3BtQ1BBRWczSHNrdUtRL0tDeUNGejFWRy9x?=
 =?utf-8?B?bEpZR3ZPRitRZFV0ckVxa0tOQlptbk10eFdsdE5HWW9Ka3RLMXJrRFlNVkdh?=
 =?utf-8?B?WmJucndwN2pDUTJTYjhkbzlnZTV6MDIwdWdWVnVIMFV0RW9sME5PTmJOYkRn?=
 =?utf-8?B?UVFMcDhjdEljV1REZTRwcFd5OUpPSXN3T1BDaEVubWlLTFQ1ZDZmY3llZFYz?=
 =?utf-8?B?UGtkaDBKL1ZtVnk4T2lsU1UycmpOVGN0Q21CeWs4TzRWSXRZSzRUd2VUNFVw?=
 =?utf-8?B?VGp4Vms2djVyQ28rTHFLS2FhQjg0UTJncEhUZERWbDk5WTZPL3NNdVZoRGcv?=
 =?utf-8?B?czVWcy9QZEJsOU1zK25mWEtPOXd5V2F4WHE5UFVLNmRJM09IM0pCTHIzTDNZ?=
 =?utf-8?B?dzA3UGpJSzArazcrM0dML0oyY1Urakh1RHRkaWV1OWRqa2lUTkdZUUxoR3VI?=
 =?utf-8?B?enJwOTNiNFE1SHlPdXVqeEpsMHNSaEd0RDU0M0t0S2RxMFZsNXAyaGc5M0dj?=
 =?utf-8?B?aVhLQzRTOGlpNHdvREVSbEwxVWdqQzR4TGQrMUZBeVExVG5PeS8zRXlsQ1c4?=
 =?utf-8?B?VWtzek5pMFJLMksxRlpxM0IwUkl6T2twUnNyMkRQaFBzbVhMVThHRlExaHFo?=
 =?utf-8?B?RE8wRGt5Q3FOVTVxNHluZVJ6bndqcGVGUWlueGJVOTZhM2V3cm4wcEFqbUlO?=
 =?utf-8?B?eFNWQk1YM3BIb3d4M2hhenVnekNmTlUvaDlJbERzOUMvWnFMc2dKTENyMmdh?=
 =?utf-8?B?bXVaNWFXS3ZvalB5VFdrN0Vqa0d5WWRMWHdVZHIwMmgreitnVXlsRnFMNE1R?=
 =?utf-8?B?WnFZbFhGVzJoK3NVNytqK0cyNWJ4eUx4MmRZMVZGc1hUNlZVQ09hU3FWUEZu?=
 =?utf-8?B?SDlWL1U0WGlQRUJHZXFyVzRIWjRJVkxMUFJxTlNuamNKWFZqWUc5b1NWVEtw?=
 =?utf-8?B?dE4rZlI2RExybEk2amp4RENYKzBnSFRmRUZpQWtLbFY3TTNIQ25CTVRwME5M?=
 =?utf-8?B?T3d1ZjZ4Nmp6WUlnRy9KUWdlbVZaU2dpL0dXdGlMZXhuOG55azM1elY1TE9R?=
 =?utf-8?B?OFZGUHRUWVpKazk0Y3ZsNWZ0YUlxdUJBUnBDdEtiOHFNOG1Vam9GWWsrYVBy?=
 =?utf-8?B?T3Ywc1QzOWVLTWlUblpaMXAvMENMa3UzRGl0bk1nTnlFUTh2Y3phL2xPWGxm?=
 =?utf-8?B?dHkzVSswNWVhQjJMVElqMStYa3Y5aXlRZWd5STBJbEJEQW9WZlJaWEEzek4w?=
 =?utf-8?B?WXpBZzQwQk9BcnJ1Y21XUGpDcys0YTRzN2V2RXlkMXloV21BQm9MY0NxVjVv?=
 =?utf-8?B?NytvRUZlc3pJRnhrOENUOEpkZlN1d0pLdFVZN25sQjlpNlRnR1A1TDdUNjZB?=
 =?utf-8?B?NWZjVi9QOXFtamwwT0pqSTV3WlEzUU1RUDl3RllSUTRlS2M2MnArV1FTUGxu?=
 =?utf-8?B?RFNRT2duTk8xUnU4ZTQvdWdRRjA0YkRWSEpUQ0x5V2JaSElYZW15b01UazdT?=
 =?utf-8?B?c3NKUXFqNTNGNlVjaGdDTlZ6MUNxd1F6eEkxaVFVS3ZBZHc5akhOc3FvMTZX?=
 =?utf-8?B?NUdWYVIwSStMSERRYVJQL3BTUHhwL0M2aWNhUWtFSEhWT1ZQV0hoZFV5a09L?=
 =?utf-8?B?RERNZkN2OU9IRkNsUHVnTE9xbUJWY0Z4eFhjOWRmZXo3Q3pscFN4L0pRUTBC?=
 =?utf-8?B?R3JEWkhqNzNURTMwRzlnUTBhYXl0TTVkOWM0b0hwSFU5UlBFSWM3UzV2MFRF?=
 =?utf-8?B?RVBEQ2ZJZkdlaE5HRWZ3SXRPcEFLb2tXSklYMGxKZXlTL1lrODV1VllGTzcy?=
 =?utf-8?B?M3I0OEFUR1M5VFM1ZURycTlCU2dZZUh1QU55OStJdFVDeElPUWFubHFadWx3?=
 =?utf-8?Q?A+SVt4oWyCtdy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUFMS3BKdUFTQTVseWRjbTNsSHdBWWd3NmZQS1FkYWg3ZTZub040czJHanhR?=
 =?utf-8?B?bzl3a1VJbE11eVM0cE9LcVBKNGFoODY0QitjVzBxb1VyZ0R0MitoWmpmamFi?=
 =?utf-8?B?SWlybTE2THpyV0hxUWF1emQ3VngvWHNlSGFkcjl3U3c5bE1PbzYwSmVTeDlO?=
 =?utf-8?B?VlVwQmpERk41WlJidEJPTFFDb21VYndxY1VHRFE0dkJRZTFOempsWFkxMllF?=
 =?utf-8?B?YlU4aDkxY3VZQzh3eHpjSXJDTHl1N2JQallLZERLYlVSNjlzcEVoMXFWSE84?=
 =?utf-8?B?SHRMMGpkOEsxamVNM1lubWxtYm5PSStIM3k2d1hUSWVrL2pTdnZKd3RiWHhX?=
 =?utf-8?B?OVhGbzFrWm54SUtxOFN5MVZhUDJMRFg3RVZLOS9BMVlucUk2VnF0SHBXbC9N?=
 =?utf-8?B?UEJBRW9OL2FTME0rQVlqeUFBS2daVldtTHpMRlFPSEthUzFMQkRPK1U2RHFU?=
 =?utf-8?B?dm1TZUpvakQvaUJoRDJmMU5haDJDSXI0WktWVTRxZENEcDloRGcvSEVhcHBV?=
 =?utf-8?B?bnZFYVV5TlNib2szTERMYmZqL2s5bEJvZDlscUNUdmpXVXJ0YkJ1WWprS0NL?=
 =?utf-8?B?L0tybGtoNFRnTXBXdHIyUGMvcEZGNjBFcytnZU1VRmxKWmZrQWtYTWE4TGNa?=
 =?utf-8?B?ZUZydEtGZTlJZ3A4M3dFa29KckNkSnRHVkJrNGxoQ3NldW1qUmFoamFJQlZi?=
 =?utf-8?B?RzlzM0R0S1VzM2JydXVBYTFkbDVBVUtGOXJkVWYvK0IxWi9GNG5nZnZ6ZlB3?=
 =?utf-8?B?MTBxKzF3bVdWOEJEc2lrSDNKQjhIUmlzdktveHFiVDJjcDBaaGs3YUFlYmxT?=
 =?utf-8?B?OEpOMG1tbHNpUGVDY3I5WXpNZnZXYVR2Z3QwL1FxOW9taDMrTkVVTUFwdm1B?=
 =?utf-8?B?Ky8zM0lTam5pR09rRnlxZlozc3huc0tjd3E0Z1dwWCtqaUVrd1hab0pmQ2Ra?=
 =?utf-8?B?T2NNMGYxdGdYL2VzWGtwUUtObjdvVDMvZzlRZ09OTjJUSHVjOE5IcnlJc01z?=
 =?utf-8?B?VW1PWHFDSFBCelFTamxYV3FVN2pJb09lRUoyWitiM2lTd1YyL0o3WWRESmNx?=
 =?utf-8?B?MG5ITTk5T0pMRmhIUktWRFpMaWxxNHFubks5OUZGV2IveVhUV05VNU0yRHR3?=
 =?utf-8?B?RkhQSzBnMUZMeW90ell4R3Z4Q1ZrcWl3OUN6UVNVeDRDQlo3M3lyZUVad0s0?=
 =?utf-8?B?L1duU0ZxUWowVks3SDQwRXlhTFFoV0hoNGVsU1paZkJqbnJUOWROclc1eDcz?=
 =?utf-8?B?N1NKMWl0Wm5ZUFg0NGVZUGQxUzNsY3ZnVFBxVm9kMDRJRnU2bXI1U2ZZTzJm?=
 =?utf-8?B?UUdIdFZleHFKbTBZMCtuUUN2RmZ2Q2lwanRzVEdrcStYMkRrckpwZ3RXTCs5?=
 =?utf-8?B?djBzeUlXdU5kL01KYW9pMmdNTi9vUGw2T1h4QnN3ekJQa1FVZ05OMm95NUJh?=
 =?utf-8?B?Nzc3OWZ3c0srNDFyaTVkdDdXWGFWQ1UrK0RJUERJSVM2NGNaQ3lZTEVXWWg2?=
 =?utf-8?B?aS9sTFhYUlAyckw5Y2Z4VWtsL1VXU1Z2VjBLRnhhRzRUditFMXdsUm1KUDZv?=
 =?utf-8?B?T1FKTHY3WDJXbkF3dndkeStha2N5QTdRU00vS0NPcGk2UWwydEo2MTdDTlVT?=
 =?utf-8?B?Q05iR3MxdGxRWStSREo5eE1BSGhTcFFIVmhhalRYM2NIbzMxNmdUSkl5cmMv?=
 =?utf-8?B?VEJTZHNkQ3dGOGk1NEtMMnFhUjZOdDh6a3orVStaWHZFM2ZOL2FDaFRUSEJN?=
 =?utf-8?B?bVdmN2UwcW9ZUytUZHBabTkrTzNvVDZLVjdJakwwTEFsSUtJMmhwRCszOERW?=
 =?utf-8?B?c0EvVGpadEF4eUQ3NFVGamx1Zy9FdHVJWGpTNDJhYXMxcEp6SVZ0ZTRZOUxw?=
 =?utf-8?B?OWUzMGRSN0tYQjArbEdmcWc2d0pJMFhtQUdtSjBZNURkNGdZSDBwUk5NcWNh?=
 =?utf-8?B?dFM5K1lFcld0TVB2b1p1eUZSNjA1MTdNRGdLVjhMeW1rNFA1MzFVZTFES1R1?=
 =?utf-8?B?SGxmSGV0eUN0VVVYK1pRbWQvUFdsVkJwcGRObFU4TnZVSTVRN1BCMzRON1hm?=
 =?utf-8?B?MHNLTDRFWERvM1ZVSnRaMUdqRnpHOVpZSjZHQ2NMUUVVc0tHY2lBN3g3VVFn?=
 =?utf-8?B?YmpaQkttMmV4N1VxM0RMYVBIcFEycnpRd3BoL28vYTcyYzUyc1N6dHB6ZlpU?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XnN1haOw4n4wpLER5M6MM4T+YTXdatBVMrNLqN2xA9Ldlb87YThsslIBC1N2ySnfBnL0EEdLkjmbXuaTp4TK8u4x73kWPL9m+162CZMfIo7x5V5NHTfW2v0BkS9dYgqS/yasGqUqJv6cOqmdCxejjyI84QoynF1O5Y2R1WXfan4Rz/6GpUDWd7rHN+mBhmzjzhjMJDGtY6A2IahzulepBCl+cYQ90G31RJ6REmIFi/ORua87ZZuMXHH+2ttzYQ/kbvOPN6URlg0jbbnv1mDNgqZzJCghAEz+Zyy9rywaUhUruYp++aGKspXEFFNuYFrF2wkkdOmhWbLkWnnqQ/Mr1Vf1v9isIxM98XxZxwu7hHEa+J4gdrkW3KLjtE0Ra0ihFa4flizEbPZ3wSSkDOkXgDteyU2juvXH9dgvUuJPU/MaUy8ltpgE9599zmRdEWiVbXVzvXjLcybjibkrXF1WbMUeN2XgxV+036HylxlwFUyKFTEcxjCGFtexwEYskam4+PojjIrbAm2QeiVDtXDGsh2FldXeOtJOMiZdM+dOQaB3d3g8IutIv3FST2LGXVMTPrZ1NUufMbDif17gCXHUKqYEL9wIbrs16FPOUgHZsMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201383fe-c846-4348-fdef-08dd4d066d0e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:46:55.3287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtwU0TwfWaICrl+2TN04byN74fZX/MX90iQruhKkkusepWsCs6K+/8d/IM1SCCX0xhVobVg+briMfdgcNKcvja9UprOIYmV8lPfi52NWq04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502140107
X-Proofpoint-GUID: 78veqY_-FjNhm0sjglrt4h2nmL2QaZZQ
X-Proofpoint-ORIG-GUID: 78veqY_-FjNhm0sjglrt4h2nmL2QaZZQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/14/2025 9:45 AM, Steven Sistare wrote:
> Hi Michael,
> 
> You previously acked "pci: export msix_is_pending" -- thank you!
> 
> This patch also needs your attention.

Off by one -- patch 16/45 "pci: skip reset during cpr" needs your attention.

- Steve

> There are no other changes in the core pci area.
> 
> - Steve
> 
> On 2/14/2025 9:13 AM, Steve Sistare wrote:
>> Export msix_is_pending for use by cpr.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   hw/pci/msix.c         | 2 +-
>>   include/hw/pci/msix.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
>> index 57ec708..c7b40cd 100644
>> --- a/hw/pci/msix.c
>> +++ b/hw/pci/msix.c
>> @@ -71,7 +71,7 @@ static uint8_t *msix_pending_byte(PCIDevice *dev, int vector)
>>       return dev->msix_pba + vector / 8;
>>   }
>> -static int msix_is_pending(PCIDevice *dev, int vector)
>> +int msix_is_pending(PCIDevice *dev, unsigned int vector)
>>   {
>>       return *msix_pending_byte(dev, vector) & msix_pending_mask(vector);
>>   }
>> diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
>> index 0e6f257..11ef945 100644
>> --- a/include/hw/pci/msix.h
>> +++ b/include/hw/pci/msix.h
>> @@ -32,6 +32,7 @@ int msix_present(PCIDevice *dev);
>>   bool msix_is_masked(PCIDevice *dev, unsigned vector);
>>   void msix_set_pending(PCIDevice *dev, unsigned vector);
>>   void msix_clr_pending(PCIDevice *dev, int vector);
>> +int msix_is_pending(PCIDevice *dev, unsigned vector);
>>   void msix_vector_use(PCIDevice *dev, unsigned vector);
>>   void msix_vector_unuse(PCIDevice *dev, unsigned vector);
> 


