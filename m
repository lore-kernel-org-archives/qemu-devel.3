Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13470CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umvlY-0000F7-Tw; Fri, 15 Aug 2025 10:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1umvlX-0000Ez-CL
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:50:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1umvlU-000676-NZ
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:50:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDNASH015010;
 Fri, 15 Aug 2025 14:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=nOIoOYjnrwJ+/z5fmoFRjmDCnDeBs3XJ9WKQL6QbVbk=; b=
 U9QqwSBUUc28gGawVmtpPWYe6G4K9XiYGYXLQ9GY1+LnBTgsgoGECf4c5CyQPjvg
 +tRAYUHdsJlypp1GxHKbkI1ZnbbLvyz1DryyDzn0fSewzPU3vqLBZVD/FF3aZ4gY
 GIOSHt+++v/rwMyTVph2zX5IDebm6SfDuIJaW1zs3jQd7CIvpiie+yak2twFX/kp
 24lc9d1M+8/Oj5tvDMokE/frnspSGXVGuMEoU+2WWXIZJtrmaiaurAdrs/Kf6SXn
 8c3PLeRSAkNvYyq6DR14/+jeKY3DzloOmzQnF3clr+podr0LDcLgZGo5a0ZyNX55
 DQEQyjHKRjziXp7r6TVnhg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4m3rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Aug 2025 14:50:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57FCnr4F030076; Fri, 15 Aug 2025 14:50:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvse28q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Aug 2025 14:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1hAdeV9W5cEBEmYx78VMd7iHpSfklFZoa7e4+FQKM94VlyMOSpLd6Ax0gIy6782z5QmppM7+GPXRavMvGP0TlJacn9xLra03yOAfJOU9LlGi50bNY0t2kjY5HJnBSrvMZvhoid7Oe4ztjo1SYhwwcc8xJrBlxNVG5qStESiDvaSP7hOgyAqbgzRVe3XRLVeVKr0qltneeKRjVtAaUIpXXTXHQgvUzUZa0SbNelivny6dTKPrZVZvS9MXGKUog06VG6S1cTpnQJflAUgRMJXv//aqvYdLksgwPGMaOK0O7zAqVna+ZMhauPYDhARrS4WtglFzS8qAq50QmX1qsZ2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOIoOYjnrwJ+/z5fmoFRjmDCnDeBs3XJ9WKQL6QbVbk=;
 b=PeU/5hXT5RmISyAmCPPI4ICy0bT2WmPP3on1TD5gMCYOrDH2apw7A74Koxx6QiRUXfyolCjcf7XJW2oiBUxMpUvEqwa9OrAC2qKwnH7Z8Bme9Xwz9SfGL1N9HZ4PBvGWMjAJ3Tlek9Qpul8fwubGXZamtXRharwKw5lrC+AJlPMZfgNtZXnMUwAWCZGFsVzr1Jr19Tzc0I70TgfXWeHsKogAkElsrEIwxRhaonOyD72lL5ub3XGnQhykqx83jfc45mpobjZFtszibj27okRIYaB1aW332Af9rTMrCWyE61yOH0krrIV5Xc7/loaULiRf4gWsDzxIdI7in10jdDaQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOIoOYjnrwJ+/z5fmoFRjmDCnDeBs3XJ9WKQL6QbVbk=;
 b=oRbZYXZEzxuW2Mbxtaa6EboO+2eO7fq+9Diuh141GZApNip+oYRhV9W6VbzZZCAJ00WIolnla98UB3wDVPGwAumbEVBt16O3g9XXlgBqUA5FV4CaRuYk+4oPeh/LowmSBG9DVOeQCZx7msQoxK+TdsJ1fMxAYlK2U0Pk8E4nXOQ=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by PH8PR10MB6411.namprd10.prod.outlook.com (2603:10b6:510:1c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 14:50:25 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 14:50:24 +0000
Message-ID: <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
Date: Fri, 15 Aug 2025 10:50:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Eugenio Perez Martin <eperezma@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 Dragos Tatulea DE <dtatulea@nvidia.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:510:2da::11) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|PH8PR10MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc89a64-4f30-4de3-37a6-08dddc0b10e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b200VElEWTNMa2FXdFNTNXA1Q1pMbS80K3FvM3FHNllwOFRSbWh4K05tY0hM?=
 =?utf-8?B?c2Yzb1FnRk5KSkgzV2dRMTdZcFM2bGdrOXVzWlJBL1BRRTh0RWRUcHF4WElM?=
 =?utf-8?B?WS9aNmNOc3luT21QQmRjRWdSUklsN0ZVKzF2MkVEcUhjNGFUVUVLUWJQZWNv?=
 =?utf-8?B?dUtiSjhTajdtdVpMMFJpVThEZTlRdzVuOUJ0MTR4NENKa2V3Rk92SnJsVWMw?=
 =?utf-8?B?U3RnTVJKWjdxcFNsZERTekhjd0hTOE1tT3k4T1pHREdBc2cxZloveUdtSXJZ?=
 =?utf-8?B?MUxhZkpKVzdhVHAvb3hucWhTeE0zc3RwT0dkVG55VzRxUFRFcGdpNjBWNlhi?=
 =?utf-8?B?dXIzaDNXYjhmZG83RDNFS2NqVUhKN2dCcGg1RDFOVDhQcWgxSFp6ZXR6dWZ1?=
 =?utf-8?B?dXpSSUt1eFpuY3E5blVjQzVvT1Y2QlR2OWFINHZyQndYMTYyUGowZFdEZi9E?=
 =?utf-8?B?eklPUnNvWTF0cVFxN1h0aE1takFaM3BMa25MMDIwOG0vR0N5blNUbFJqVGZj?=
 =?utf-8?B?OS8rUG1Vc3UzYVlJU3VMbkh2Y0pDUHBTcThIa1BXY3U5UmlmNndPTjY4ZE0x?=
 =?utf-8?B?d1dkWEN4cWVzcVRqUlRVcEk2WlBjOSs2VDR6V2ZIeVoyd2JyRGRDbm41T0F2?=
 =?utf-8?B?djNDbWdZbUFTYXpoQ3dJWUZwYkZVU21JaWRLODJtT0FtNVhHaGhoRzZ5b1ho?=
 =?utf-8?B?Z3dNL3FmTFk1ZWJ1K3U0QnR2QXIzOVFQUHozckw1UmVKYm5HRk90SU5ra1dp?=
 =?utf-8?B?TVVFNTZaQjJlWHBYUEJsQUswcG9LY3VFYjhDbi9FTGZlT3dRMWpmci9FbVlT?=
 =?utf-8?B?NWRvU3NCZXBqZE9lcmtxcGtQOHVJdjdldjBpN3ZHWm9uZVRhT2FrcWRkMlhU?=
 =?utf-8?B?OWR0Y3RvcmpEdUI3aTZPVGxrUkE5SnEvNTBXOERzWUlsdUEvcDRHYlRaVTgr?=
 =?utf-8?B?MjNXb3NrblFPdlNuR1c1K25Pd1gwVHZhWGZ5dHo3MmtiN0M0UmRaR1JOMEI1?=
 =?utf-8?B?MkxGdWdKcHVJdGNxQUFORUpJU0FZTHdiLzl3czlrS2pBNFhXVU9vbXRMUHdS?=
 =?utf-8?B?OTF2bzUrZVYraUd3RzBOK21NdFVYYmhKaDNjOFBhbEFEMjArQVhPaVNYNDBh?=
 =?utf-8?B?Q2h4SWdZR09XdU1rbXVEQ0ZoYW9Kalg2UjZ4SWs0RU5SclVWbThPcVl3ek1x?=
 =?utf-8?B?ZFdENDlyTXltQ3RBMXpLSVkxWElSZ3F3MDRqOUhrZ3VmM3lpWU5rd1NaTFNm?=
 =?utf-8?B?TzlYb3pBb2FQdHlKQzNhNlNSdkFhL1U0aFdmOFV0Syt6aGdCcnZYSzhPYlNL?=
 =?utf-8?B?T3lQUmNsZG5rT0luaUcvU2tyWkxMVUh3NnBUTWw2dy9HdDFPOU0zaGpjWndK?=
 =?utf-8?B?Um5qTGYrYTdWRjRYdFBBd2lGSWljbzVoWElGOXZpUG54SWwvUXoyUCtsSDU5?=
 =?utf-8?B?ZXQxZDVvZ2hLdUtISGlIT044REhadEpzMVd1ME81UXJxYityT2RTOXBkcENp?=
 =?utf-8?B?anZJVlFFVUtLSmxTMVdHUkgxTlFPV0VkNnAvTmg2bTZna0tmU25xeUh1RFNn?=
 =?utf-8?B?SHZFWHp6RUJYVTU2TzdDa3E3NXRCZTAwNmlWSmZHQ0lIUU1saGd0WHVPMys4?=
 =?utf-8?B?Mk9KL0ZzQktyeHNnbk11VGZ4YnZBeGtuU2pwayt3KysxdFhPcWMyZnd3cUJ4?=
 =?utf-8?B?SXJyREZIQnFoUWFtVHZ5elNPTERMMldYSmdXVmovRzg2RjZoc1N5RmM5NDVr?=
 =?utf-8?B?Q0tsaS8ydGJ3RDEzbDUvLzQvWGJ6ZElrVFhSZmluc2lMU0lQYUx3Z0VNZFQz?=
 =?utf-8?B?Z3B3eWdYQmFrWkppUzZSdWhyZUtNL0dqSDEyd1lwa2tWYUVEVC80YTFFaXdC?=
 =?utf-8?B?VGkxb2kvVVRuSDl0Sm9KSlYyaDdLU3N5OEpOd3ZLZWl0c2FSb1IzNms2ME15?=
 =?utf-8?Q?729K5fnFNk0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9aZEw5cjYzd3VrYzZQeDNDdnV5cExuYzFEMGVFOXFkRExYUzQ4STROWXNL?=
 =?utf-8?B?ajN5bStTNURGT0JxYld4SjJGSG9RNlJadFRKNWRiVkdKTkI1NkZTQTNZTm9E?=
 =?utf-8?B?SVBIUVQyYkxtdmhQV25aRjlBNHAyNlhsODVmaG94b3JPb1Rhd0ZoT2dIRk9z?=
 =?utf-8?B?bmNrYmRQcXIxSFpTdjlzaFU2NXE4SzBKTThKSStsWnIvQi9QNnBWMzNkZGRs?=
 =?utf-8?B?amJwbDI3bDM0VEExM2NxRUhUMEhzc2ZTNTdmbWFEcFZma1Z1Y0N6V25FalBV?=
 =?utf-8?B?R09BLzFCTUk1N1ZQK2JaTEJiU3d6Um44VFVpYmFuZisxaFRVdWxoaUFWcVEv?=
 =?utf-8?B?WW5YYzh1Ym02clVTMElVQkZEd3FTRFJkUjBiSUVwTUVaWVA1Y0U4Nm5wU0Vp?=
 =?utf-8?B?WE55MHM2c2oxSVM2N0dDbFAwWTZERHptc0o0N3BGNU1mOE5yVVJIME15dGp4?=
 =?utf-8?B?aFlrYm5QejE2cldjUlRJdFhORmNxOXp6U1RoUlNFNzV0ODJiVUZKSXFlaHdB?=
 =?utf-8?B?eTRkbGZSVC9WcmlBakg5YUg1bUV1aHBIZW5aRVJ4Z2x5NDV1akQzWEMxbzhQ?=
 =?utf-8?B?bDhwZ09uVkdTR3BuVnppK0JoMEFpdXh4ZGlxY3Uwb2k2OWQ2MFRZY3VYYXpT?=
 =?utf-8?B?V3BBZ1hGYm00SVpwWFRPTHF2K1R2TDUzTkppeEpOU0Erek1KUkVjeVJWWkd1?=
 =?utf-8?B?S1R6QUh3ZVVydmZzbDBNREpybUtOS0hTSGNpV2xtQ2xLcHNRRWN4VU1TR2lP?=
 =?utf-8?B?OC9tRk54NlhCckplaUdxdS9ONGFiNzUxWGpaVzFleEhjUjFKb1RWbmtETUxB?=
 =?utf-8?B?YjVnNks5U2o1YzN0Vnl1SUZCM0RFOWpGb29sMGxJZHVJcHFQN3d0aW1oVS85?=
 =?utf-8?B?amI3eHc2T0tpQkcyRXF5SXMwTkFmUlJrVXdmdm5zRWZJb3AycU1ad09xbm9w?=
 =?utf-8?B?TCtRTlJlTU9FWWtPSk4xRWVUMkt4OWVBL05zYmpXRVhuV1JYUm9hNlgwaitQ?=
 =?utf-8?B?M2JWckNoVTlwRnhYQ3V3bFF6eFlHU2tMYkRXMzJpSWtjZXArM1JGWHhyUjYw?=
 =?utf-8?B?ckl5alRteXFwSlY1RTdYa2tZUXM4THNKWjlJZnlLc2ZCWThSeEVCOFJlU1ps?=
 =?utf-8?B?bWZwNHZ0bzlRSnRxSkplRjdXMlZwY0lUbWs3aUNuSVlHbzJQSTVHdzlLYXAv?=
 =?utf-8?B?N3p2U0tVV2tRTFRIOVoweWVjdFJlQm9qZ3dVdzR4azdOUzFkWHJCWXZRN0pu?=
 =?utf-8?B?R1plWTZhcGxLU0RYTi9Yell0cndVQUhXa1FDTmRGL2ZmalFBbWdHOXJEOG1n?=
 =?utf-8?B?UVZvK3VXQzh2aVc2a2E1L0IvUmJSY3pRWEZnRjhYcFBHY3BSUWlhV1hiVzhQ?=
 =?utf-8?B?cldkcmxlUHJ6eDhaVGg1eTVudG9xaml4ekQycEhRU0Y1ZGIvcE1OOFpqdXNx?=
 =?utf-8?B?dS9DZFI3VEp2Y3pVTyt5dm93VVpwTllaUkVBUDFzZWhYNGZyV3hXMFROd0pO?=
 =?utf-8?B?ejhjNFlzYmVBTzZuY20xditJbEc5Rk5CTVBRZUFEaGgyNnBsRC9abXhTaGNs?=
 =?utf-8?B?dzh1NTZzR3h4N0d5NzhoTGlaNE9tMDhoTWZMTWZKUHpnZmRxTkRML1FtQXhm?=
 =?utf-8?B?czNIOHlENVZHeEFNbFc0WnEvM2hHTVlZZ1YyeGtiTS9pOUpUM3ErZmVxR1R4?=
 =?utf-8?B?eFdodlJLK2F3T3lhN2gzTlVQYXcxM09LQ3NGamJQbFZXaDd4ckJsR1dSSHc0?=
 =?utf-8?B?TXpCTWtzblFmZVJPc2pwNzloSmVvKzZSK0NKU0lIaVZaZlQ2T1l0QmN4cWZo?=
 =?utf-8?B?NEMyY3JnbS9rZlNYc2tGZnZLMHcvaW1sWTdLZ1VUTHBJbVdnM3ZJczdSQnVJ?=
 =?utf-8?B?L3RBNDRXekx1a1FNWE1WN05ZUHM0elZaMU9rUTRUV1R5WlRYZGtiZW52cUZT?=
 =?utf-8?B?bWszbDJMUDZ3MlVzVUlrem1LWncwend0TW9aZEltU3NMVkhwdWl3VVFuanFt?=
 =?utf-8?B?djJwM1J4UGNuS281STNSTGFnb3kyTGRUeGNFUStzQzRWdkRRQlhTbFhrVllQ?=
 =?utf-8?B?aXFWQnRGMmp2SUxmNVQzRXdpcHVJYk4zc1RSVXZieWp6NWxiZnhBNUVQcnJq?=
 =?utf-8?Q?U36W1G615VWYF3UNFGb9QvjUe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 79r1LG4hdZSpdl8jX7ZjwGEzCJiJw47bRbZRgsJJedFruVu4p7ZBbMqySIPzXc8M82t0n+OyDf3c9BKRllb0wFJngRXEx/b+qlEcZSuvQDuA1MEfKONz8fEDCMsGhHkAvFbJvvmgy/6B9zKDW01NiIjL4YIGwMOV7yNFe+8Hdu1UlAywvmG6a3ZyM9JL0YD6Py1I/M2gXs2t7I6l4F+zDnoqheLiiTiqGM76Z8+CdlfkhecNxdL8O5UftmYuX3YL5BQL2T/wYMz3o2SAkzJeZyhJ1g+TnPnvOLvmzT/v2tP/x0Wp78y75mHmOwObCWoQtRH9G3U/MaF2QvgWfYPFzjfgd0ODerkAFG0QLqhn+NNGKaVMP67yXhEqTkSkhDIpQKfqCIyknuzfZG+CcP5sPKI96TjnxZX+TVNNmgWnJTbMHaEFKs3kmeN+EcAFn5Q46lgt9NR2XKIlhkchSTMXnLuVNKYMMj6MmiTRTf/SmvO9jWvP3eZHLtBMeIp4hngsxAhAShDbcI8jSVeYU+rX0USoqUm8w9x/7KgErJ7IQWZZ/9D04schMlVk1yNRdQFCBGL2qrsNuNYVeeTx/xcjCueEmFYKcG47+vPAXPWduRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc89a64-4f30-4de3-37a6-08dddc0b10e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 14:50:24.5960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9mD4CTK/5IDDagyg0UClRrQO7CfPU4n3QgKXZjkFTt2lyyojgJoseRbvcHv7k3Ap5yii7N4grztEYfT/oxdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDEyMiBTYWx0ZWRfX0mAaMVhYiJ38
 kkbTdHL1F0FszYtRSg/XGRPW7bn3jZvd7nnykG4kmG39oaSdCIoa+oK8Ds+f60XVDkWN6vlSi1Q
 JEStp7/ITsdTTLzFp3BVTEdbfinJX+Ms2fESf/v/6A9qiW1cstiY3njRitdJ+wUMS6WsEMhVcq7
 r8ssmQRUKNOYPjlnpPeTPHLgKkQKk+u3Ezl3+AppGkmm2Wj9Gi46Ykim+pEe1KXZ2mbyuwlvx9S
 enCEhKgqGtT25OMDiGhaV+aUZOiRj2SHjat+RcYCQ4huHmAPU6QSrR1nUO14x9jYSWldRsEzzTC
 pMYXKFnJam9GraRdKr29zeoPH+4f37VoPzZ77iO/DFj2rOuQipNvmotzf2esVU+8si8rE1qGUEf
 5BIWOFeFr075TsxDTN+fMat4H7l3iHLTA0NcSmWh7BVRRQieBV5FkqN9zndR7vJqrgyKaNFg
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689f4935 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=20KFwNOVAAAA:8 a=5d5nAqlXi4Xi9nU_ej0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gG-r85p6IuRiM2_wKDfpPafl5EXjvSDl
X-Proofpoint-ORIG-GUID: gG-r85p6IuRiM2_wKDfpPafl5EXjvSDl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>> This effort was started to reduce the guest visible downtime by
>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>> vhost-vDPA.
>>>>>
>>>>> The downtime contributed by vhost-vDPA, for example, is not from having to
>>>>> migrate a lot of state but rather expensive backend control-plane latency
>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>>>>> dominates its downtime.
>>>>>
>>>>> In other words, by migrating the state of virtio-net early (before the
>>>>> stop-and-copy phase), we can also start staging backend configurations,
>>>>> which is the main contributor of downtime when migrating a vhost-vDPA
>>>>> device.
>>>>>
>>>>> I apologize if this series gives the impression that we're migrating a lot
>>>>> of data here. It's more along the lines of moving control-plane latency out
>>>>> of the stop-and-copy phase.
>>>>
>>>> I see, thanks.
>>>>
>>>> Please add these into the cover letter of the next post.  IMHO it's
>>>> extremely important information to explain the real goal of this work.  I
>>>> bet it is not expected for most people when reading the current cover
>>>> letter.
>>>>
>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>
>>>> What are the data needed for the dest QEMU to start staging backend
>>>> configurations to the HWs underneath?  Does dest QEMU already have them in
>>>> the cmdlines?
>>>>
>>>> Asking this because I want to know whether it can be done completely
>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>
>>>> If src QEMU's data is still needed, please also first consider providing
>>>> such facility using an "early VMSD" if it is ever possible: feel free to
>>>> refer to commit 3b95a71b22827d26178.
>>>>
>>>
>>> While it works for this series, it does not allow to resend the state
>>> when the src device changes. For example, if the number of virtqueues
>>> is modified.
>>
>> Some explanation on "how sync number of vqueues helps downtime" would help.
>> Not "it might preheat things", but exactly why, and how that differs when
>> it's pure software, and when hardware will be involved.
>>
> 
> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
> about ~200ms:
> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
> 
> Adding Dragos here in case he can provide more details. Maybe the
> numbers have changed though.
> 
> And I guess the difference with pure SW will always come down to PCI
> communications, which assume it is slower than configuring the host SW
> device in RAM or even CPU cache. But I admin that proper profiling is
> needed before making those claims.
> 
> Jonah, can you print the time it takes to configure the vDPA device
> with traces vs the time it takes to enable the dataplane of the
> device? So we can get an idea of how much time we save with this.
> 

Let me know if this isn't what you're looking for.

I'm assuming by "configuration time" you mean:
  - Time from device startup (entry to vhost_vdpa_dev_start()) to right
    before we start enabling the vrings (e.g.
    VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).

And by "time taken to enable the dataplane" I'm assuming you mean:
  - Time right before we start enabling the vrings (see above) to right
    after we enable the last vring (at the end of
    vhost_vdpa_net_cvq_load())

Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:

-netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
         queues=8,x-svq=on

-device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
         romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
         ctrl_vlan=off,vectors=18,host_mtu=9000,
         disable-legacy=on,disable-modern=off

---

Configuration time:    ~31s
Dataplane enable time: ~0.14ms

>> If it's only about pre-heat, could dest qemu preheat with max num of
>> vqueues?  Is it the same cost of downtime when growing num of queues,
>> v.s. shrinking num of queues?
>>
> 
> Well you need to send the vq addresses and properties to preheat
> these. If the address is invalid, the destination device will
> interpret the vq address as the avail ring, for example, and will read
> an invalid avail idx.
> 
>> For softwares, is it about memory transaction updates due to the vqueues?
>> If so, have we investigated a more generic approach on memory side, likely
>> some form of continuation from Chuang's work I previously mentioned?
>>
> 
> This work is very interesting, and most of the downtime was because of
> memory pinning indeed. Thanks for bringing it up! But the downtime is
> not caused for the individual vq memory config, but for pinning all
> the guest's memory for the device to access to it.
> 
> I think it is worth exploring if it affects the downtime in the case
> of HW. I don't see any reason to reject that series but lack of
> reviews, isn't it?
> 


