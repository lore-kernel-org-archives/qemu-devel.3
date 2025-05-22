Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C638FC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 21:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIDCa-00031E-IY; Thu, 22 May 2025 17:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uIDCX-000311-IB
 for qemu-devel@nongnu.org; Thu, 22 May 2025 17:11:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uIDCV-00027z-53
 for qemu-devel@nongnu.org; Thu, 22 May 2025 17:11:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHQjSL009777;
 Thu, 22 May 2025 21:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uzEyDrYfoIFFb2EU0sPt9o32UTJdDAq9YENTnFci55o=; b=
 TRrdlhGxyUun1o/bmXJHq0/+FGXP29WsbvrdOqq/T3Z7cI9pdn2ehf3ri+OP3jQX
 5bslWEGPuSxXmwIPdEoW12e39mmrB/7aWBTYY9yPsdx2xiL7FtVzh9ToRgZR7a+z
 lpJxTFF4hiBBcBygYmVzBjseAt1AqTGT3MJQkMQbRMvacsble2xXF+HGc1xhYoBB
 uCwRgc/pN4RJ4ggefwkINU07GGlCr2HogmwcavIygj18dJTAeYNieh+GWoi1gvb6
 wCczGnZwj6s4/ffNXIOMFjpnxerOU6lCwbxqQbyazAchX+S5PxhJqs3CSQmGTD0V
 TAyqKMxfSUVvfjiUSQ1AAQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t83s0gem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 21:11:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MLBEo6001723; Thu, 22 May 2025 21:11:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweu6kxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 21:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEUWEKgjWtkeBDrIrCdbdBQyDz2YfA8N7VWcCpaqqlr6Cz/Hv0hUS9qtj/uFA7rb1qd5DItIhBxaq5Fkdw56CsoQcECDkzAzCdEz0+1wiXa6SCnWJoTECS2mmWm7rMPYJWwxWhITZGYOyivGnGE0mxogp+k9cIJSNEjiI7XgTZn6aEI0hoEYMv5S7jZPufw9/MdhLQHIGdNGneQ0WE0ad4/9Y26czjE2Agtr7KacVWa2JdvN2V7aB4nVml3aYKIhwL0OKAMt/Tik3KJXUt+HBtWTWd0PHnHcdJr05+W/t+9kybR9P2ift15wMflcowC+UbLXujhkGFCqJyVlkeEqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzEyDrYfoIFFb2EU0sPt9o32UTJdDAq9YENTnFci55o=;
 b=LmGU6aQ+SCq37hYf+X44WUAxK3+RYR2+Y1YzGffvZ4EpEgZVUCVSCDEAk7uLXm03/KfBCpp7puwxOtuhMVMEG+z5+Z9CfII3nvlk81dfGBXXaR8xWqJx9cz2RmQV/qyOFvsAF6zVYsJSYnjmk5FVCkk+yqS3C8BPaFuAPA3srCgsV29d4ldsVID6sX1fTXsdFet6IJOaX9hNGnveXyVFQqg+pTsCJbF/8mgJf1hQXod3qGuIAREC5ZztYPKCzQzlA93NqfW52DAiyUlZvyVCmT9e9yhhqroUvZJx9RF7ZQv3w3PK7bM+gYnDb6TYbezINY2hU4gPwW22nWXHCD7z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzEyDrYfoIFFb2EU0sPt9o32UTJdDAq9YENTnFci55o=;
 b=LI/2unDaJeJA1YOeSPCWwUxsA+7UcONi1h9WrlnIUmpG8WTimjQYhdHiyFKyrHxi/ssRiFatNerv3Y2zTmXspMyk4vMp5EYkgOwLC3Usf0PBUBfe2LUDkgdVPYQeqn89HSZoEIZ6AHPY0Efk/mqFcry9+zyXL7R6qnnyh4BnjYY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB7076.namprd10.prod.outlook.com (2603:10b6:806:329::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 21:11:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 21:11:29 +0000
Message-ID: <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
Date: Thu, 22 May 2025 17:11:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
 <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: f107e7f7-eb44-4375-8afd-08dd99753848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnhhSHk0dTM4aVNRN2pYMEVtTVFIQ1Jqa2Z6NVRqMHo3TlBJUEJGdENMelR6?=
 =?utf-8?B?UU8zYmdrK3E0VGdjWFJNUVMvVXZOVTgwdXRQbzdBOWhxUi9wVEVnbGVITjla?=
 =?utf-8?B?dXVreVZ6WnZqWEE3dXp2WTJJbVVqRkREdnFSUmYzNUk0c1N2QWlQWXhXMGJk?=
 =?utf-8?B?Y3VWUjZOMnBIa3AvVmNVcC9oL2xQOVQwQ09pSVlRWnZyNWYzWFJyUExhZ3Qy?=
 =?utf-8?B?MkthdkpyU09iTUNpZUI2UStCWUVobnEyRUtEL3I3SHA3WmUyUEZWV1VvUnNF?=
 =?utf-8?B?S1czY1FpS1RmL0dDZUcxZFFDNDhGZnQwSVhVSk04aTNTbEo4T0x0Yy80b1BI?=
 =?utf-8?B?T1hST2ZjaDM0cnd5NVY4cDZvemhoT0ZRT3NtUWpwUlBQZ0Q1Tk42ajBVdFFt?=
 =?utf-8?B?d0VzOVRhRlZla0EyUkkwc1R5bk1wU0w5dUF1WlpiU1lVNFh5am5vU08xSzlC?=
 =?utf-8?B?YXBmR2Y4Z3Rjb2FaZm5HeHFXNXRyV01RSUVLbHhhZVN0N1NGWDlnMWd6WEkz?=
 =?utf-8?B?TzAzRjFINnZNRG1LaHA4b3ljUGlTZFdkdldOREVMQjVaSGdBanErNWJhMW9K?=
 =?utf-8?B?T2lmZW12dnZlN1FQY2xnbzQ4WFNXR3Fub2YxZWxLM0ZwZk1Ba3lmYUxvRFRI?=
 =?utf-8?B?SUVpV1BHaGI5djRXRUVJeHI2M2pxanJHakpuQ05abmU4VEt1QU1QekRGcEo0?=
 =?utf-8?B?SGhObHNGVGN0L0F0NVBYdEljbElYSzBXTE0wWm5TcUE1V0FYNVlESy9HeUdB?=
 =?utf-8?B?Z25MTUFZUGxMeUJsVm51TzlvUkNwVUFJOTBLc21pbVJkSnp2N1Q2QURXR0Y4?=
 =?utf-8?B?czgvT2FxbGtmNFNDZUF3T3hZU0NUNHJRb3NYREFxUXRZWUJENW1oellNenJC?=
 =?utf-8?B?ZURXRkwzVkw0ODFZdGNYSzV6MkJCVWV2TWU1QWx3ZW9TYVVXUlZSRGJDTE5J?=
 =?utf-8?B?SHBYOEc4R0RXRzFTRzBHZjYxQml2cDFrOTNQNlNtR0VYelBTNkhuMFI2OG5j?=
 =?utf-8?B?R3NnazRZQU1HWkRPK0NhcEY5OHE3ZXVuMnNXTnJNR3lvZDdQRWh0YVVVeDBk?=
 =?utf-8?B?WjZGVXBweVRkdXdWUDJyVXh2Z0N3VnhiYjMxWEYzamxISWdhNkxCRk9CbWEz?=
 =?utf-8?B?V3pUMEE0SDFpT1VHdGk5azk5Y1UzeXFFMHpTS04xUmtIR2kxOXRGRzgyeE9a?=
 =?utf-8?B?RjlFczdVN3luV2FCRGZ2enplT1FqTHZhekVvVmtTZ3k1S1FMMlhwRml3Q3JM?=
 =?utf-8?B?eVF2N2gzOERqd2NwTXdtOWxCRjgvV1g5aE1RVi83WnBTSDN5VVl1YW96ekR4?=
 =?utf-8?B?UWV2V2FDZUUrQTAyQnRhSDR4a3RYdld0Y3RidDlNbmMva2o5RWE3VDFQSDdi?=
 =?utf-8?B?OThWbWh0N2JzYjlybWdUMXpjL0lFOFlORFkzaXVINzhEblo3bFMvTWkreWRX?=
 =?utf-8?B?YzVCLzNtR0VWOW5iTG50OHAzS2IvaXczMlUrUkJJSkFPZGhDZmdUaFE4VzVk?=
 =?utf-8?B?eGFQRFBvZjd1Q0pRVHZOZkI5MTlvNldrNVNwb3pqSlF1STNzSVJzZmp5UWFa?=
 =?utf-8?B?YnNKUzJOS2YvaWM2cktDUzJOdmpzY1ZqUU5UR0w2ck8vbFdjQk00MXprOGQz?=
 =?utf-8?B?TEd6M2lkWEpRT1NNZm1zNmVkOEdZVW5rbmYxdjlic2J5REJ0MUd4bFRjNEN0?=
 =?utf-8?B?dGhrZkszTEdKcDhuU2lZMGtUV0lEaTFBNmNBNG1xa2U3OUpoZWZxSmZLQmlk?=
 =?utf-8?B?SU9NNHZ6ZFExUlFDaSs3eWxPWndpQk1OV1NveHY0T3RqNDR1Mm9jblZOY0pX?=
 =?utf-8?B?YllVcVhuUkJCbGxHV0RCQVRIUXUvb3JjSmlxUGlWclFROTRvRzljTnNKd0VX?=
 =?utf-8?B?eHdMOVdBMXovVEhrZFhzS0Nwa2ZBVEJvd05NbkNLSnNYeHRrNWVyQTZLNVZs?=
 =?utf-8?Q?9w+HGC2jy18=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JtUzA1MDJkWW1TS3UvQ04xdGFPbmZOY0FiOXhZcnoxb0dRTGUzYlNlT0E2?=
 =?utf-8?B?bUxaSCtJSHBuaUJSeVA3WWZ4Uk9uSVA0d1VIWWhlT0V0SnVQMk8zenZ0ZjMw?=
 =?utf-8?B?dG9DWDBWbTNkL0RQSmYxZmIzSTlYZkNqQ3loYUNVTXFNZnNmc1ZUd2pXd0kz?=
 =?utf-8?B?Q0kvR3FXamhKZ2UrbnFpN3JXMTJVRWZZcG9zY1ZwczBQQUxUYklhMEFHaVZ2?=
 =?utf-8?B?dkxjYkl6ZmFSNEl4N1drMURTeVVHVVBHckJQdVpYdmMxM2NiZzQ2YzhYRGhG?=
 =?utf-8?B?bmN6TDRsZHNhZ2c3aEMyQ0dpbDcrQktVeFBCeHBJV0J2QVJ0M2ltK0hsWC82?=
 =?utf-8?B?UTlRWDlJdVZuQUY1T2Y4ZDA5VTlKRE1yUHRrMFRyNVhrVXZkK3ZGL1h6NlJZ?=
 =?utf-8?B?c0dwbmFFK0lOeEtlQ0dTMVd1amVtVXU1N2svKzhQSGxHaDlLY0pkWmppcFZM?=
 =?utf-8?B?WmZraW9KamlmaUFvcDBuQ2FPcWVQSnhYampiWnVyaVBKSVJrSXhTRUtNcW5o?=
 =?utf-8?B?TVMwb0NYMldGSEZ2NjlDRmM5N3ZvMFBQZk9BL0R1emh5KzBZWW9DaDludzkz?=
 =?utf-8?B?TjQ3TmRoUXJTOTFqNVQ4YW1yYWtSSmpBZjJlcjI2SlNqSmw2cUUrdldhWDdz?=
 =?utf-8?B?eEFES3BESE5OVmpRTzJ3Wm9TTDFyU2U0RlJidE5RYjJvemExUWJId1hVWmFG?=
 =?utf-8?B?bEcvSnlueXZKTjFQR1Z6T3JRZmE1RytMOUFpTjRuVHJHazJvQitJZ3lHVzJN?=
 =?utf-8?B?Z0hxdW5WMm4xWXd5NGpJRVV4eUZ1UWNJQWhKMm0rMzVpVUlzVUZDTGNWTlFS?=
 =?utf-8?B?Z3dWNFNCK1NlZEJQU3VlaG8rVjJ4cHZYbXhpb1o2ckFnd3Y3TWlBZEV3TkU1?=
 =?utf-8?B?SFlVeXFiNTVnYzBrZ3JDOUpwNGlIdWpWR2FLaFRxU3lDbUNrV091ZG9xTnVV?=
 =?utf-8?B?NVhyaENHeFh0OTVNdHBYMUNCRVdWUVlBUkF1aTkyUXdpdlpoSGtKRU8rN2tP?=
 =?utf-8?B?YURlNmo4QjJia2xrVFMxNmhsbUN5eUJEamkrdE1qSUhXdXVRWnhiZmxMZ1Zt?=
 =?utf-8?B?aU54T05aeGR4MVdVSHZmNFBhNVdIenJHSE1JQzU0UXJYT0RQTjZTbC9zZFpz?=
 =?utf-8?B?czhRRitGaXByVTZlbmErRWYxYi9wbWhYVnB6aTA5MUxsOUtTUWJlTDQ4eWI1?=
 =?utf-8?B?dUI0cnhmVHg4ZEFqZTZKK3I3Ni8zN083dlllKzRLQkhCRUpyTmkyZFo5S2Vn?=
 =?utf-8?B?ZVl1M2lxc0Q0OEVrc2JaNDVrcUpuVmNVaks1SGowQWE3NWdTS0lPZ1BTYkZG?=
 =?utf-8?B?SzJhOFZ5azI0Q2J4WmQvelpUOXFzM0xSanlOZ2Z4WDBHVWw3OFRvZUcxakdj?=
 =?utf-8?B?anNFdEpNR01raVltcXZnc1BRWjZPRk1IQ2Rad25vTTQvTldOTUFYeVpsRzlU?=
 =?utf-8?B?YkVnbG5maEg0SkVTbWpBbU1OTzNmVC9GM0NkNE5RcVZYTitGUzVKSjdJSmJu?=
 =?utf-8?B?VndBb0U1eWtMRzh2bHBDa3JOdGNBRGM2dlJ3ZDV6ZUZNM1EzQURoSkJQeS8w?=
 =?utf-8?B?Y1RTa0xXM3h4MmhPU0tneEZVakZ0VVBhQ2d0RmRranAyOE5Vd1kxWHVUYytt?=
 =?utf-8?B?eTRmT3U5NU13NWxQRHlPTFVzL1VOdU55QUppdHpGQytpWXgwTUF2ZFdXL2g2?=
 =?utf-8?B?SWxpQzdvUnFURzllWUs2VGt6WWxxV3JEM0g1b3pjaFFyM0lUZlVyWnhKN3Zr?=
 =?utf-8?B?OUZyTmdiQlcwc2V3MjAvSm9zZ25uNVFqc3AzMHJoRGYrU2xaSnN2Y0lzWmF5?=
 =?utf-8?B?QUZzY21sWW8ydGo5aHFJbkdBQkpkeHVBb1lBRVNRdm1pa0xuODVIM0NnT1lZ?=
 =?utf-8?B?YWMwb29LR3ptLzFtR2FsaTF5QnZFRENDQTQvb0ZWa25KWjJYVTJtSGpyYWRt?=
 =?utf-8?B?TGJLbnBDT3JjbHR0VFpkNVJjNVJQcFR4YjVJbXBxQ1M4YnlMTDh4S0RaV05K?=
 =?utf-8?B?OFRlRDJFbWk5VUlqRE5QM0E0SFZWVi84ZU1YZkFQeGJsRmhmb0d6WEhXanlR?=
 =?utf-8?B?dmltTzZweXJNRWJ4Y2NFUldBSHZuVnEzQXZLejFWdGFnaXdyUVJmNmRaQi9k?=
 =?utf-8?B?Ukt2MnBvSlVhQkJBTGc2N1JIRk0xWVNubFJKZTEwSm95VWhlejZBK1c1dVF4?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: evJhwymsToOdz3WPWJpvkNBDxGlAnms4Mb80xY2bUBY9P3pRanCuSEprG9XZfAV8776B2E+OSp/uhE+cf43FCIQe4GaaRC/6LSBIHBDxgg/g9I2IZmuooqlj8n4Rbka2syqqM4TxCIdJ3lyF1BJzNnPr2em89fhfnpSgUDT5buLim222XF0nIwp1ZrebWJsQQompoy1a/0Wro9uE0Or61CbENWtb8iyj83Bl/JSmIDVJ61RXjk8hK2hN9offXTHV7cS+cfmSzosnekWf3BMI0TWIve9KWBgUf39QWmpAcTieJO23/x278NdprGMt6eyEZZ2DuaajtGJEQQB6VJhhtFysExRaXSzD5dAxgY+Yp4nnSYbuwybIZJHuAU8VRNr+2KPy8RP2P+YmhBw7dpZvsDY8NjU7oru2SGKQWpHnFSv29ymP7Lgh/LB7bjyt49MzeMIVa0oPf6BHm4EwRi1T8zQAN2vtMks0j4yH+ULwY2IvnlmgJcUWIuKFhLkCHECtcsAapxBKN++rCdPNJDDrLFP4qiNZ0GsyUa45wn+JlfUXp3rB722WFhVJ1Bc1leTSSGXxOfhkL7VFxygUcbtyW9qz4RXsfIt4QsVI6Q3TQwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f107e7f7-eb44-4375-8afd-08dd99753848
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:11:29.2456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6Xo/og4mJyHyIhRu8tL2hkHin72SuzLVhI7ObKI2DEJeO70r7nDFc7LtmZ5acddNEG3KEBl/x/RaXcC5vUzFSYYlLPAtvpwBNmytFaXE5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_10,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220213
X-Proofpoint-ORIG-GUID: IfOdfIFpdAF21c0lMgnlYQIuQLJp1tBC
X-Authority-Analysis: v=2.4 cv=VMbdn8PX c=1 sm=1 tr=0 ts=682f9305 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=68QWCXjWFiR_4n7R--4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDIxMyBTYWx0ZWRfX2w3eDd4ZZevQ
 +US2tqEFpbfTTAQZAhmhTnLGvU88kuKjjehfyw0sVlj9+XpoxiUA3AS9Mh379hxHeLvKAN2+gIS
 p8HFnIGvrnICYDEYY6ATUlss0EJMpa74op/Tev0ms1IzxxR2rs2hOwqLmX2Z6KKA+sipp8yKpVI
 ZzQ2sBaunh2TI419sFSn/6XwcciyGjVUROoQ+Uv9NxBAp0XxoxSbDO3njb0n6hMnpRdSB9Sl3k1
 LTtWAPU3hvz6BJY1VLCocTenGi7VxI9ZkBO0clcRgc6PEw5bma8U8mbvKxi9DaQjpqp//RrGjeZ
 6yUmnhymaeqM+CA9OTTd8s8K5kSa6UtDdFsLTfVaP1+dJoSbCjcFBDviBMnRvcpo9IbXn4vahAt
 dBHgidZgYBKfr66B5+LIg72cW8w+mtUsWYD1tqHeOnvNEktlwi2FG5zfU3TSmTN+L8O5A7Qn
X-Proofpoint-GUID: IfOdfIFpdAF21c0lMgnlYQIuQLJp1tBC
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

On 5/21/2025 11:19 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>
>> On 5/20/2025 11:11 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>
>>>> On 5/19/2025 11:51 AM, Steven Sistare wrote:
>>>>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>
>>>>>>> Define the change process ioctl
>>>>>>>
>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>> ---
>>>>>>> backends/iommufd.c       | 20 ++++++++++++++++++++
>>>>>>> backends/trace-events    |  1 +
>>>>>>> include/system/iommufd.h |  2 ++
>>>>>>> 3 files changed, 23 insertions(+)
>>>>>>>
>>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>>> index 5c1958f..6fed1c1 100644
>>>>>>> --- a/backends/iommufd.c
>>>>>>> +++ b/backends/iommufd.c
>>>>>>> @@ -73,6 +73,26 @@ static void
>> iommufd_backend_class_init(ObjectClass
>>>> *oc,
>>>>>>> const void *data)
>>>>>>>        object_class_property_add_str(oc, "fd", NULL,
>> iommufd_backend_set_fd);
>>>>>>> }
>>>>>>>
>>>>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>>>> +{
>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>> +
>>>>>>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>> +}
>>>>>>> +
>>>>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>>>>>> +{
>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>
>>>>>> This is same ioctl as above check, could it be called more than once for
>> same
>>>> process?
>>>>>
>>>>> Yes, and it is a no-op if the process has not changed since the last time DMA
>>>>> was mapped.
>>>>
>>>> More questions?
>>>
>>> Looks a bit redundant for me, meanwhile if iommufd_change_process_capable()
>> is called on target qemu, may it do both checking and change?
>>>
>>> I would suggest to define only iommufd_change_process() and comment that
>> it's no-op if process not changed...
>>
>> We need to check if IOMMU_IOAS_CHANGE_PROCESS is allowed before
>> performing
>> live update so we can add a blocker and prevent live update cleanly:
>>
>> vfio_iommufd_cpr_register_container
>>      if !vfio_cpr_supported()        // calls iommufd_change_process_capable
>>          migrate_add_blocker_modes()
> 
> This reminds me of other questions, is this ioctl() suitable for checking if cpr-transfer supported?
> If there is vIOMMU, there can be no mapping and process_capable() check will pass,
> but if memory is not file backed...
> Does cpr-transfer support vIOMMU or not?

I don't know, I have not tried your sample args yet, but I will.
With vIOMMU, what entity/interface pins memory for the vfio device?

> QEMU knows details of all memory backends, why not checking memory backends directly instead of a system call?

IOMMU_IOAS_CHANGE_PROCESS is relatively new. The ioctl verifies that the kernel
supports it.  And if supported, it also verifies that all dma mappings are
of the file type.

- Steve

>> How about I just add a comment:
>>
>> bool iommufd_change_process_capable(IOMMUFDBackend *be)
>> {
>>      /*
>>       * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
>>       * This is a no-op if the process has not changed since DMA was mapped.
>>       */
>>
>> - Steve
> 


