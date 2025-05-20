Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A5DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOO9-0000Xg-Ad; Tue, 20 May 2025 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHOO7-0000XQ-CV
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:56:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHOO4-0000hO-9l
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:56:15 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KE7CJG024594;
 Tue, 20 May 2025 14:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=50tR+KAgS4Jf0A61k3HEJ3x9BJcbLvLzCH60qKx4Xgc=; b=
 P0AeGRzIz2zyYNLYD7GfbjxxtZwxCI3pmUPnz1DLQ5/1J5ECv6L7Sq0nbZVHuh3v
 T55lPPYS0A37Uf02ELl7mig/XmJIgDZ/rOLZ56Wc11fxvIWoPeokBMSO9CSQytm1
 GwDZfuaVPcJO3LmIhifYLUJ9OR8cpQrDOr36LOHLuAv5rMuKem61Rt8dm//GtvpP
 fZ1vPXzunRsOwBXHiBLRHhjTRsI4Yd/KT7lHYTX/pUl7oi+CyWp92jpAxRzcVa9b
 Bo1mIHDMyntXZHvTwTnPB+hOezWL9LS+qrmnceZ94E9IU17PgpJXt8Nm7DBQSQZb
 240QzmhOwvbz9Bm94VQtvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ru7dr50m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 14:56:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KE1n1m037219; Tue, 20 May 2025 14:56:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw8vgf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 14:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQsCn3aqW6eHby5kAlGInkNWKQvca0go0bwHfQihteyIUTDTdV6JC0IZFRGEJs4mVev8uS79E2dO6ADypAYxNszMuj1WJjt4ZivYVpQe3UAfDt0chzen+wmYGDM84P7fXeN0r17Y0RS8wATWQzvVTxOH0GU7/yUhyTM15fAqJavoiJWiFXQscgls4aJdBFWsyViwCn9xQGV4+IaBZ/ehS/MWEr3LEawyW+CFGw8aIXyI1NLeoIFo5woB92B3FM8ri1VzPV2s/imLLOa1bIQ8JBeFlFOv39aLHYsIhhDhF4eFxSXy0H7FP4l63ojr3opZTjaT7oS7kTzIO2XWjLjLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50tR+KAgS4Jf0A61k3HEJ3x9BJcbLvLzCH60qKx4Xgc=;
 b=Y1gyuwv+hY+iQYxe6AgGAF3YRCoJQBZef9HsGXQdAwg5ayaFhckr13tovuHN69KzuKlPsjOd0gj2Colrcqf+8UGJVMptb9p4iT1opWKKoAlL5vzKieraeu8BRG2ahAw+oxrwQZN0A6VizpgTnrc4sRRF7QTeR7W6LepEeXqo77szSSffWhBpXQK96dLqQx/xLJFwTi647NArQo/gWQdU/Ryumz/+8Gfn0kAm9bcAMAaVU4b7NwfA7qHm2X7i6sjkXyj73lz3JFAPmeDnQVwvGkqEg82GxFQf7g/0YrG+h53yg4y3EXJZf2HmRnGDSNBW3gro1vU1UJCwBxeAa0wJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50tR+KAgS4Jf0A61k3HEJ3x9BJcbLvLzCH60qKx4Xgc=;
 b=Ta1dIGFGpr7pCR1ED3TASp/ekNAp9iNlHRzgCHJ01jMxPO3AojtK3aJoM01jRc099l0VUOXcv4Fd1VHY51hGVa6vopX0NhPezGOrZhxdjBghZaNw++PafN4kYQ3dmcY3MXEf8CAeOBHeyiUZ+g9mvfCAKNo5FBApIoBJFxMOjm8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7954.namprd10.prod.outlook.com (2603:10b6:8:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 14:56:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 14:56:05 +0000
Message-ID: <5b38eb98-58da-478a-badd-124a90e480a1@oracle.com>
Date: Tue, 20 May 2025 10:56:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 21/42] vfio/pci: export MSI functions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-22-git-send-email-steven.sistare@oracle.com>
 <c5696d3e-cd21-4d90-9e30-676434c1020c@redhat.com>
 <25435e62-50e1-4bf3-8227-e2ed93b959e2@oracle.com>
 <2e3e82f5-334c-4fac-aa5a-73e08967b431@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <2e3e82f5-334c-4fac-aa5a-73e08967b431@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:208:23c::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e572fc-82a7-4114-a8ff-08dd97ae71ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlNOL3AzSk81bElJdEFBSFpubW1POUNqNWs4aitkZUhnTkppS2ZQUmpXOUlR?=
 =?utf-8?B?dGtvR3dWSm1iZWN1TGdudDA0eURZa2dUdnBOQ3dhOHBldEloUjJXNk5sbEs1?=
 =?utf-8?B?SDUwLzRxV3pNdzl5L0dNL05lN1U5R1dsL0FTSGh6bG1oYVBvTTJjRnZuUmJV?=
 =?utf-8?B?N2VyQXNFSHJ6d3lucWc4cExXc0NNLzJNL1R5cytRSkRCWUZlVUhiMEk3WE9J?=
 =?utf-8?B?NWdqRTQzRTJTaG1xN0lVaGtGL1o3TktXWXkvZHh3c2RDYXVHRUxZS1NTcG9o?=
 =?utf-8?B?aVFBalJ4V3o1OFhPUHFLVWQxV2JKMTJVTUlFeHgzRzFQVDRsM1lFYVNPa2lC?=
 =?utf-8?B?S2pGTTFzRXRwN3loUTcxbjdDdzMzdFdEaG92dTFIT1psU2JDVEFIMERXdWI3?=
 =?utf-8?B?bnFVbU5EZTJKTVNEaDR4cEgweTZ3aTVTS2xCWjNXbGJqVDVIdDlBQXR2NVZI?=
 =?utf-8?B?Sk52TUNtSE9nZ3BQZCs5d2ZFOU55M2NBakhQY2cxVW5zZVdXMkxBRmlFSjFK?=
 =?utf-8?B?NXlNSFBwVlI2ZWhSWFdKY3hBalU2SFFPeEZySk9QcUVMSjJlL3VOTURrcmFH?=
 =?utf-8?B?UWREZWpZbndHaTZjdVRiOXZxbkZuQndCU0MrNTM5TGsvQ3VtUm95WC9KNHk0?=
 =?utf-8?B?dU5wVGZPRlQ5UjB3cFpDRzBMUk5rZlJxdnh0cWRQSTdHMjNEcWVBZkhiQVB5?=
 =?utf-8?B?RFltMTdPRGJSNHJzVXVwUDJ1V0FvQkVWSjJqWDBBUnpUbjVxdmREaWNLY3VW?=
 =?utf-8?B?WDlxREFFeXBSaHNwYTFuQnJvb1BsVEhtZFZHWEwwZzlQL01WYk53ajh0am1E?=
 =?utf-8?B?Rml5T21tU3l4cGl1WTVpNEdqbmUyaEZzT0NkTFZydDU1bHdORi9pZThGU0lr?=
 =?utf-8?B?WEo0bDllQWJwM0RZb2ZPTzhhNnNuSXBjUW9PR0Rwbjd5QlBNeFlrMTRUYkdr?=
 =?utf-8?B?U1J2K2t6TjZVR1RJSmtsZENiMTZVSEdYV3lSL2ZiV3BTL3A1NjRMbjJBMjZM?=
 =?utf-8?B?WmRqM1JOK3FxNEErUFRoaWdZVnZlbWFOOVEzSGc5K040RmRhWjVUNFZmZHk1?=
 =?utf-8?B?dzhIL2xTeTZQbVBwQmdhV2hFeDZpSU1lMlB4MHQ1bjVieFh4V2xlQTBZVVVW?=
 =?utf-8?B?VzJ3Wnk5ZHpzV3VPOGEwTlBGUE1aazE0OUR3MzJrSFljZkUvOWRvTUl3MXZm?=
 =?utf-8?B?RkEwY2F0K0VWYkVmQzBCaXVEU3VJN3J0alV3VlVhdGswMHlVaEIxbFlpaDZK?=
 =?utf-8?B?NjZHYStFQU5tOXNzbS9QZGZBbHhHcmhOekZJZk55NnovRlQ2c1Boa2VIcnBN?=
 =?utf-8?B?ZnR6cWxSS245emhscHhFeWoxbitXNytYMmxJU3BQbFo2ekdoVGd1Uk9sVHFR?=
 =?utf-8?B?b3l4cDlxWTJBOHNhTjJEazhVczBTK293QkhjRWlaRkh2ZFlYalZvTEJMOEJo?=
 =?utf-8?B?NUd5dzVrYnhyNjIvNjVPTjRndCtWMW1FZkoxL2tZYnhzOW8zczZ3TG1QZHpN?=
 =?utf-8?B?aEZKNDh2SFJQcUUrZTlhYkZrRm9BUk5rMkZDZmpZSUl6RUpNWURkZWVTZmcy?=
 =?utf-8?B?QXFYT1FNVUpkQTdjVHArcVpkY25reU51a2hOMGJZNzB6Q0l6ZHdQeWRwRUk0?=
 =?utf-8?B?S2dCakdrMHoyQnZqdTBMS2svV1pGM1lxR3l6dkFwRndCbElvVkpqRkcwNG5p?=
 =?utf-8?B?T2Jwa1Roa3FLdWZ4TmxtWWxDRURVQnJieE9WNHdhOTczMUN2UXRQNFFFOVZ2?=
 =?utf-8?B?b0ZsODV3bVdJTlNSYnN4eXNEdTNHR3RtYnlJSTdDTTFKUS91MjhvOGZ2enNV?=
 =?utf-8?B?U2hSZG8zV0JJMWpZTU9QZ0pneGJuOENQN0V1ZG9lSkQ3Q1p3SXBPVXREa245?=
 =?utf-8?B?NXExK2MxU2o3Q1pLa05HRk9ob2VSUlpvR3dla0pSbjBjRlBMRTZJcjFYUWtE?=
 =?utf-8?Q?nU1oJGGsGAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9Ibk50dmZrQnZOUW1aRWxMZUtFemNoN1hKTGRmUlNONUJXY3pmcFk2ZTJy?=
 =?utf-8?B?YTZLV3VWazNoN24zZDhYVTdwUGwzK1FLZVdqdHJqYUlkeFpPaDcrZm5HK1d0?=
 =?utf-8?B?MjBsZUdjWjVQZzRqS3V1RlFydDNUOTlMV0dJNXYrK3ZvbVVNdnNrM3JOSDE4?=
 =?utf-8?B?T2VyUy9pSEJJQk4xbDJrMGlNRkNGVTJNN1N2c3g2STVuelpEcUY3OWlWazNl?=
 =?utf-8?B?ejNHYi8xZmpLOXBwZC9lK2ZvQllRRmxuanJaSTVuZ1lFK3RHVnFtbHg1Wlg2?=
 =?utf-8?B?SGtSNzZaTnl5bmEwUlRLSm95WGd6RHFpWjdodkJTYzhYMEpzRnR5UU9keTBi?=
 =?utf-8?B?V1VQV0ZIeElieEl6dTlOVU5HbXBpRUJXVS93d1Q1RGcwRkFhR0ZQUmIxcEs2?=
 =?utf-8?B?VGtmdkl3SEVRL25mWkd2WFNYSmlleGE0WWZjZFRBdVdWck9RWEJJY2dhY09z?=
 =?utf-8?B?ZGdMSFl2RlJtaFlDY092VTh0V09HQTAvSkNtM2tGa3pQN3hmYnJveExjRHRz?=
 =?utf-8?B?SVhtM0dlbC8wWkhWMnJPMzNyYVNTUjlWd3RPMzRSdkFxZS93L3hXTnJLRm1j?=
 =?utf-8?B?b1YzcWFNTlhXU1R6UjM1M212bnJLTTdPcG1uckxydERoWUlsSWhFejgydFNZ?=
 =?utf-8?B?R3RGbCtwSEZqYXNja0NLUkFJNW5SRWxocFpVUHRzZnErQlJ4bm1VM25LWk9a?=
 =?utf-8?B?MEp2SDUxbUxYUDlrNEl1RjdYSWFFM0twWGd2NHFtZHRXeSsreEhscWZLTlli?=
 =?utf-8?B?RzIrVFhqaVczaW5pZHNEaC82MXR4YlB3TmlRVjZLYmV1Yzd2Qk9nK3djRVox?=
 =?utf-8?B?ODhyWHN3UUJGNC9yZ3JJemM0VUFRdHhsTGVjYjRJcjJMMUJvemtVUFVSMDBG?=
 =?utf-8?B?M2lPc3JqN1d5bjV0aU9rQzhacEkzRFlVM2xTUkN6VCtYK3hWVmM5bkJ3SFF4?=
 =?utf-8?B?ejNrVXB0eCt0Rit0czJqZkJFMjl0dW51RG9GdzVVdERIbEJKV2x1TnRaWTE1?=
 =?utf-8?B?SVpqVmlheTE0VXRRd1RiYlYwR1lHc01ocHBYcEtnSzNIalRuQjhqUk02MFpr?=
 =?utf-8?B?VTZZOTIxRk5RS1lONW9HR1V1Y1U2bG5vZjhTZmRiRmpvQnZRcjZmZ3EvcHBq?=
 =?utf-8?B?dUJMYkRJaCtMaDJnb1JqK0ZlbVdpUkwwQXB2aDhxRXRhbk5vZUdid08vSTUz?=
 =?utf-8?B?clNGbWFtVjNrcHFXMUptbnlaZ1loa0kxT241a1YxcjIxNHMxOEdTUWk3Tkcv?=
 =?utf-8?B?MzErRnNKb2FTeHNtTThqdzhJTU55RlFMUXlBUGp3aERjdkZIY3FEaHhCcUlI?=
 =?utf-8?B?WWRaVXpKODJxR0hhSnF5MUZzR2diR3J3dG11ZGl6ZG9vamh6bkliNmhmOVRl?=
 =?utf-8?B?VTlNYkpnVzVhYmtsZG9yT1JPRkNOaEVZaWVQMldxMmtoclByUWpKWWVCR1Ni?=
 =?utf-8?B?aTUyRDNWMk5XdU04VjZ5cGx5NjNOSU5LcDgrY29ZV1pQWTZMU212Z3hnNng5?=
 =?utf-8?B?UHFEbE91NjdveSs0c0pmYkdGZGd4RGF3WFd6NUVrdjNjZy9kb1RIVE9wc0tp?=
 =?utf-8?B?UHhvOE1jMm1adXRuemluc3o2KzlEZnl5REpXUmFLMjlkMjl3TzVhb0lMWXFp?=
 =?utf-8?B?bE9uV00yZkN4S3dsbFZMQ3lJN0R1QTB3SFErbGhkYmtLMlUvbE1BeTJneFA0?=
 =?utf-8?B?eGRGamx5WjFpb0JpNHZFQ01IUExSblNwMkFFUG91bng1RHNSYlhFbU9DczMw?=
 =?utf-8?B?T3RiQks0SWVheEduUjNBNnB6VTVJeSsya0hmZzBzUDFRdmdrd1FjT0E2RmVr?=
 =?utf-8?B?TXZPUXJFb2w5cDBaR2JqM09Jb2d6VjMrMVEwcG11TjBGd0pwVlVTSFNzM1ZP?=
 =?utf-8?B?UDR1ZFFNNDQrUnZQMXJaVk8xcXB4UFMwUjNqdktlN3l2N0Jsem9sQTF5TWZI?=
 =?utf-8?B?ZXJOZjFibFhRZHVIREJ5LzdlZWQweEdXd3U3VCtKU2Y3aW10Mm5aRWhiOFUr?=
 =?utf-8?B?VFJiOGZpSWVQdEN6d1ltMXVIdFJ4OHdubkEwVk83azBLaUNjSklldmJSTkpw?=
 =?utf-8?B?QmRYQU44S1NuNnpLSGVIYWNlV1EwU2dRWk1MeUFoYngycVFPNVkwWDh5S3Nk?=
 =?utf-8?B?ZXRDdU9LeUg0eW53c3k3MmR1Ly9XS2pzYzQ0cDcvRWMzM3B5aWpMR2hlcXhM?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +rGHjRxA+LFMqZE80qICqPbAB1b10nMFCs6lERS6SCkvRNy5BbXq67i84tRDW2S9rasfXOcoQVP1aeGudzJyQYvjxWZNuXvBQbKLlHY0fOJFG+E24JoIEcLXU94rMwAy8QVIwJnio2ln4IVsXfiL80PB6MKKe+dGSmhU2jmg98C4LLipPy44nhmbsIPAa42p6UW2heV/RvZXhg9Gm8NLloW1UExJAjkwEb2bxvxzK4FweddC6+Oe9fBg5MdXVubQs4dQs2S5gypA01kNqY/fkpUQqgHe4XwHsCI9kGa3nMISJl4u7gMJbBUcNn4VVTWATOBRlBT67oWAk9jcVb/Am5zezKbB2X2pfzL6WvhIjBEPeTfYSfEvQa2pkMjUD664XvIuJ2qAPhDBqJSBmAtVQ2pes3IazFG0WQCz02J+WIzoZ/G+ag7KTGCQXmkXcPVLKtMxiFjhU+WV6gzVQSydmHx1vZzL1wbCazE8yUw9BsM6dIqmaTSed7NJjXqwsDI6w1ikDMvBiEDCYBZdKRjgW0oqYVmezktOZLpTtN67PI8JPB/BYEabXVn85/Yob3WLT23LEqcTsrbvE8lfHDNojGMWOmnkrpSxO+uCDljzJQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e572fc-82a7-4114-a8ff-08dd97ae71ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 14:56:05.0223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CcJpBpKJrtk5e9uFt1zNCcD5xL5ZHcChgYXylW5VXb0fpRwzTLYqEIxLcxhJYAMCUp5J9iUknC1sLrwUl0nVvKlJa7pDHKBBmZdKhFm6JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200120
X-Proofpoint-GUID: bbAn9p07brykWG5xdeXwUkup8JvhN5f0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExOSBTYWx0ZWRfXyTVUTm5S6/6N
 pOndVIiay6t9Gjh00mSIwCKSmWbcuTsVpy4EhLqviBJU20CEBeW9hPRuE/6HJgZ1/+HZ6eZhj6j
 hX9xMCovY9DVld8BDhEBp+49KKeCVSUlWNzhTXCDr17UTg4YLGaG4GydQYyTegU2dE0fWtTJ7Ae
 t9jdEN8Nk2sT+ZDmvIe2IbJTvqwy+F+aZDf77aB2AhT04+nyxor8CJQxCcFmYDKu7AmVylE4a1p
 hlxUJC9bQl/3Hu/jl88VXLCIbuJ+slFEMqXb40rYLNugYXtyZkFaoGgFCjnAZoqzCKqBcZuEHcl
 oBeZB+VOIc1rxijLLG1DXF2ki99T8kq+gTeZa9D7uXh73E3/ka31ybfAY7sqbdDkNDnhEk/2Gaf
 Ht8U1oWyb/7JBfMRIxBJqzmj2JsBouLfHft+1k6qjamZAB0Y13e7r4PBswvPwI4nF1Irs1dK
X-Authority-Analysis: v=2.4 cv=bo1MBFai c=1 sm=1 tr=0 ts=682c9808 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=QcR-EGDFSmhku1WbrUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13189
X-Proofpoint-ORIG-GUID: bbAn9p07brykWG5xdeXwUkup8JvhN5f0
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

On 5/20/2025 1:52 AM, Cédric Le Goater wrote:
> On 5/16/25 19:58, Steven Sistare wrote:
>> On 5/16/2025 4:31 AM, Cédric Le Goater wrote:
>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>> Export various MSI functions, for use by CPR in subsequent patches.
>>>> No functional change.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Please rename this routines with a 'vfio_pci' prefix.
>>
>> Are you sure?  That makes sense for:
>>    vfio_vector_init -> vfio_pci_vector_init
>>
>> but the rest already have msi or intx in the name which unambiguously
>> means pci.  Adding pci_ seems unecessarily verbose:
> 
> We are slowly defining an API for an internal VFIO library. I prefer
> to ensure the interface is clean by changing the names of external
> services to reflect the namespace they belong to.
> 
> All routines are implemented in hw/vfio/pci.c and most take a
> VFIOPCIDevice as first argument.

OK.  So this:

void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                int vector_n, bool msix);
void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);

> vfio_msi_interrupt(), vfio_msix_vector_use() and
> vfio_msix_vector_release() are rather low level routines.
> I think we need a wrapper to avoid exposing them.

OK.  These will do the trick, defined in pci.c and exported to cpr.c:

void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
{
     msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
                               vfio_msix_vector_release, NULL);
}

void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
{
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     int fd = event_notifier_get_fd(&vector->interrupt);

     qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
}

- Steve

>>>> ---
>>>>   hw/vfio/pci.c | 21 ++++++++++-----------
>>>>   hw/vfio/pci.h | 12 ++++++++++++
>>>>   2 files changed, 22 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index d2b08a3..1bca415 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -279,7 +279,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>>>>       vfio_intx_update(vdev, &vdev->intx.route);
>>>>   }
>>>> -static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>>> +bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>>>   {
>>>>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>>>>       Error *err = NULL;
>>>> @@ -353,7 +353,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>>>>   /*
>>>>    * MSI/X
>>>>    */
>>>> -static void vfio_msi_interrupt(void *opaque)
>>>> +void vfio_msi_interrupt(void *opaque)
>>>>   {
>>>>       VFIOMSIVector *vector = opaque;
>>>>       VFIOPCIDevice *vdev = vector->vdev;
>>>> @@ -474,8 +474,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>>>>       return ret;
>>>>   }
>>>> -static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>>>> -                                  int vector_n, bool msix)
>>>> +void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>>>> +                           int vector_n, bool msix)
>>>>   {
>>>>       if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
>>>>           return;
>>>> @@ -529,7 +529,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>>>>       kvm_irqchip_commit_routes(kvm_state);
>>>>   }
>>>> -static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>>>> +void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>>>>   {
>>>>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>>>>       PCIDevice *pdev = &vdev->pdev;
>>>> @@ -641,13 +641,12 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>>>       return 0;
>>>>   }
>>>> -static int vfio_msix_vector_use(PCIDevice *pdev,
>>>> -                                unsigned int nr, MSIMessage msg)
>>>> +int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg)
>>>>   {
>>>>       return vfio_msix_vector_do_use(pdev, nr, &msg, vfio_msi_interrupt);
>>>>   }
>>>> -static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>>> +void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>>>   {
>>>>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>>>>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>>>> @@ -674,14 +673,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>>>       }
>>>>   }
>>>> -static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>>> +void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>>>   {
>>>>       assert(!vdev->defer_kvm_irq_routing);
>>>>       vdev->defer_kvm_irq_routing = true;
>>>>       vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>>>>   }
>>>> -static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>>> +void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>>>   {
>>>>       int i;
>>>> @@ -2632,7 +2631,7 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>>>>       return OBJECT(vdev);
>>>>   }
>>>> -static bool vfio_msix_present(void *opaque, int version_id)
>>>> +bool vfio_msix_present(void *opaque, int version_id)
>>>>   {
>>>>       PCIDevice *pdev = opaque;
>>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>>> index 5ce0fb9..c892054 100644
>>>> --- a/hw/vfio/pci.h
>>>> +++ b/hw/vfio/pci.h
>>>> @@ -210,6 +210,18 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>>>>       return class == PCI_CLASS_DISPLAY_VGA;
>>>>   }
>>>> +/* MSI/MSI-X/INTx */
>>>> +void vfio_vector_init(VFIOPCIDevice *vdev, int nr);
>>>> +void vfio_msi_interrupt(void *opaque);
>>>> +void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>>>> +                           int vector_n, bool msix);
>>>> +int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg);
>>>> +void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr);
>>>> +bool vfio_msix_present(void *opaque, int version_id);
>>>> +void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>>>> +void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>>>> +bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp);
>>>> +
>>>>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>>>>   void vfio_pci_write_config(PCIDevice *pdev,
>>>>                              uint32_t addr, uint32_t val, int len);
>>>
>>
> 


