Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3058DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 17:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFzKf-00028t-L6; Fri, 16 May 2025 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFzKe-00023q-04
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:58:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFzKc-0000Sn-1r
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:58:51 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGgTDM013878;
 Fri, 16 May 2025 17:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=/WmZUA0qFyRBhUfL7E6u4MP1tTfoZak+mLTTJza4gCs=; b=
 fTSwm7nfmw3I+CaHeSOWhYrdvK/E5H6atwIcAvXBmiggRM5l1VHNQfKG1plOKpS/
 76CnJObg26gyxS8igyliZ+9B0KOjkUS76wejLmOpoosnOBQcUaMybdFw49KeIBo9
 R5eJj3bOY9AYw9sGytyc8Of4u9BJXKd35r/d7izevZeXo5SRnBrNvYuF8GB/5fRL
 obG37T/zyrKX5FJJtRVY/fde6NpAJOEUg3rIAhlh7c1UnDEOgKaB1T5M0tDuKAY5
 ZH4FnoAVbm6jO+G+AN0BFyc489YCYR+O2baaNERymMGfD7xRgjqvg4sqgWPB7E0P
 KLGClO06N1N24sVFoenxjw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdhws4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:58:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GGUawI033244; Fri, 16 May 2025 17:58:27 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbsc4cjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIH4Pd+MAqHtXpW977yOS331ATV9XBamFsei2I3M3f+T2ddn769tXLDLqHZtB7oagIr44pC8/a7g04FoOxwxP7BLyn6cexXoCHBm28voT2auxgHhmWu5sMHMUFidyG3A/CL0aQLb50UhoLOY/LeAfAQZBqTi9C0dvtAtvdkMNPVNX6tPPaWf08AkdLugvLsCJthfkrZaLRq2OMfY+few4fmI/D38pifhsxi7wwP2dnxzu/T8ANwxQF4qf0v1INilczUbW2qy0SFpCRiAnzBNRgyMxEP3lQxTf6KaG2fRRQ+E7qcqgwadijUKGXOPyrtOaZ2Z7BXBbn3eF0IoXsLrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WmZUA0qFyRBhUfL7E6u4MP1tTfoZak+mLTTJza4gCs=;
 b=vQJxVKJU6OXodWqGu9gUGjnrE1A3ChncNdsl16xH6YFoUmXwJWMqmE3UAMlFwpL1pen+HGEg35H+zetduiucEdpESzurBeLOl1ZkG/LakhSZcSq7mKtv1wlNC0Dqs9TAXR2TiFIHnLCdq9M2k4YDky5DCR4ACRJnw78SRs7KUbiInmj3+KlsH6iuCM9Yz72BIp1aEonEkU3Bh1UetCkChpFQncTb3/W6iHG94sFqtcpYqkO1XzBchP5oxPyvq8TT2YtqzCdEp17mOOJyhkGVs78w6NGGzT4QBsJ7RLnv5kOQvx7LhsaXGb6SJL7KutKfIpZhn3W4StKUNCYlFXeFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WmZUA0qFyRBhUfL7E6u4MP1tTfoZak+mLTTJza4gCs=;
 b=Ow/+2hqie9R1AYkoqkweXbMxcsvpMXaM5vIUivUxKFwrbfNZughxA9sQqNYiPq8/uGMimd/s9olj2n7UPYHj6bJQJEhnyDpGWDVQSpZBL3ihEtQj3NQ/8qlRCqvnNhYvNU7kJiqPfyFXolVAwMG/RhYCzIRTjZGhitNWEwzqLfw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA0PR10MB7253.namprd10.prod.outlook.com (2603:10b6:208:3de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 17:58:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:58:22 +0000
Message-ID: <8238ead5-fc34-4d93-9e38-d6120a8b3c29@oracle.com>
Date: Fri, 16 May 2025 13:58:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 14/42] pci: skip reset during cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
 <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA0PR10MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0a369f-7c80-4d43-573a-08dd94a33fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0tIM3BpU2pxSmVPVzRPc2JkVWdzNjQ2Qk93eHhJU1VNVlRFQlRqbXFHVFFt?=
 =?utf-8?B?RENMM2Rqc3FESTR6TjFFNmRPKzNvZ2VXeDRIcG5FTkNTaWtsSFJEcW1iV2Ri?=
 =?utf-8?B?MGJLelpuWmlqYW4wN0hUbFNsSldIbzFaWGFoQWprOW83bjBWVlI3bjNhQkMr?=
 =?utf-8?B?RGMwREZMSzNEOUlMZ1BleXpIOGRzYXQ2ay9CUGVFR3Q4YVY2cmlMdzdtQkdw?=
 =?utf-8?B?QTFJN24yRk9rMXZ6a3B3OGJ0VGR0OTF0aGhQSU50NHhER2NTUitoMVVPTVU5?=
 =?utf-8?B?NWFsMy9xQzJMdEIzZDhDRnpyeWY2ZmZ1UGJBSWlDWUFnTVgyNzVEOUJzdFpI?=
 =?utf-8?B?NEpRYTFyS1kyYUpVUzVFOVFRNmlmLzl1cHcrV3h1U29nNkhjZ0o4UzRHMVUr?=
 =?utf-8?B?cWJ2cGdMcHhPTlM0d3VKT3grMHEvOUVLd0hYeWlhQ1puWnkrRVdQNysxRytZ?=
 =?utf-8?B?dDV4eDdhWHJtK1dkY0NLZlNWeUxXK0tBR0p4QmJaSmVSMnpoU0FHbi9hVEhD?=
 =?utf-8?B?d3h0UnJTN1FIY2hvaFZpbHkzdVBZdTBkVFBjTTZaYmxrOUZwRis3NFdXemtE?=
 =?utf-8?B?Vk5WUXc0OStPcWVhMEY0bmZPdy9FSEZSVDhiTmpsdElQWTQxTXdCTEVXd1Bm?=
 =?utf-8?B?cGZmOC9OK0xyRUJtUGRZMW5nNXhnTHE0bEZTSzEwcnlPSEdHNmVvd00zaUlo?=
 =?utf-8?B?ZzA3WHE2U01LcVpDa0dlUTBPMEFuS0FSUFkzZGRuUllMR3J6enRWVzI1YzEw?=
 =?utf-8?B?MytCVlBaTHAzbEpoU0Z1SVlzUjFRMlRZYzZnOTJXb0hkb3NSZkNuZzl1VWN1?=
 =?utf-8?B?KzNMKytGOWRjOGpHVUtqcDVBK0NsQ3E4NnNobjJkYmlqRXlJazUybXExQWZm?=
 =?utf-8?B?eVlsTEVOT0J5aTlheEJEaGppSXI2bDd0SEpHc0FaUDdFdXY1QWs5Z2d4Rklq?=
 =?utf-8?B?Uyt4VkpOeTlkOWxubVhrWi9Jam0xbVExQm15Z09OOGkxSTBQeWZ5ZFVrc3B2?=
 =?utf-8?B?Z2gwSzJuTitZR1loaXRTK1dZL3BnY3BpK3FGSjZwSzk1ejJLTlVTOEpUQ1R5?=
 =?utf-8?B?Qml4cDZOckMrUTAzODZNb3FwS2h0Q1RoSmFrdC9VRWNqOG53eHQ0MWdPRnRE?=
 =?utf-8?B?djNWRkFmRmJ1SjFFb2RZUFc1NHZDdE83bHZJRVVyWkJ1ZFpIK2ozSTFreHNa?=
 =?utf-8?B?dEQ4aXJ5bWg0OUlIVk5YVVJ3WWVUV1RPK1NnUEpBNEZGN01YT1RJVWVRRE1q?=
 =?utf-8?B?c3Qxd2U2YXMzNjduemo1aUNFRCtlR2llcWllV3BpSlR5dVU1dmJiUnUrS3lt?=
 =?utf-8?B?U3JwTWFpUUhTbEdnOGFoQ0hhRWRUL2tVb2cxWTNXTXd5dlBNMXEvR2FhV2Y3?=
 =?utf-8?B?RVBCdEQycXhIcGhLM2EzN3RrMjFRNlVWUDZoVkZOSkk0RWNjOW9hdzhjN3lK?=
 =?utf-8?B?cEFZOVpZZmR3ZDhaZmJ2YjVab2dhV1RYK21ZUlRlVlFqb1Z0QnFGSjg5TXps?=
 =?utf-8?B?NmtpS211elR2WWcwdXQ4OFJZSk1aVWMvY2NQUzJ6MzBNY1VmV1hhbFR6ZUdt?=
 =?utf-8?B?U3hVeU5YcmNaWXpEbnp1RHkrUFdKOFBVZk9maGl2dG1ZOXI4R3pUOVlmOERu?=
 =?utf-8?B?V1NLczRVOWErRyt0ZHdxU2phVW5VRSs4cGdsTHRURS96UWJXR3NVblhYZTJp?=
 =?utf-8?B?eFZXbmY5aW50czdXblVHVnpzNnVkVVZKYUNkN1dZWk51TTZLSTBXYzVFRG5Q?=
 =?utf-8?B?em5aQjFrdVZvbnl0QVlmdE15cjZkK0dxUXFTMjIwV2hFVzJoUm9uUWZHWmVF?=
 =?utf-8?B?dmdWM3JkSlZYWjViZUt6aTdNNldQMko4VHRyU1U0SmUzSTJmRExUa3RkRWNJ?=
 =?utf-8?B?OXpLdVlZN1IwWW9ONUk4dTlWUzV3c0NIZDFNS2l2Yk9saE9xTnRTTTBLUXZQ?=
 =?utf-8?Q?k7sACRnmznA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRIclUwNi9kTzNhMFBCaUZpdnJaK3JHY1F4dVJBSE9JTndDRzRWUXZWejNZ?=
 =?utf-8?B?aWwwT0VSWU5GTXc3N0VtWEl2WjdpQy9XcjdCVnZBRDdwZERvK2YzTVRkMCtR?=
 =?utf-8?B?UEdOdmhmMDJRdUJ6MWxMa1dHOVExRUFsNWNhc00rSElJdzhZc1NHOWlRNGZh?=
 =?utf-8?B?cnJGSGNzOGNmMWhjaWFldnBZZGkrY1I5T051Z29TUnZCbTVQdnc4d3JFQ0Jv?=
 =?utf-8?B?Tm82eW1vY3c2MXA2NzZFaGpINHRNeXJ6ellKNitxZi9ZbUpnMXloVUxHdFEr?=
 =?utf-8?B?eTFQcXVLNDArUG94dGVzd1dFMEpnR1hLVFdtWVA5c0ZrU0kvc0tteWd0aE0v?=
 =?utf-8?B?YzNiYTNmN2V3ZkF2L3BuUjBRb3RGV2VldnVqZ3lZd0pCaGFsNmRwbFJGRDRZ?=
 =?utf-8?B?Nm1SdzJsa05ubjF2b1g2MWtqdEFzSGh2TXRpdXNLZGFseDhvdEJ2eEUxYTVo?=
 =?utf-8?B?RUgyTmZBU3piUHVkOVNCdk9nVUxIME5FQlVYdGVaUVJNZVJwVkoveFkydUhZ?=
 =?utf-8?B?UFc2NWFzVE50MkFWVVlwMlBobnZLdXpONmhPenNnM1E3YUk4elhleTd6eHlQ?=
 =?utf-8?B?bkhFbk9MeEhGR2h0MnpLU3NBM2NjT2pJcTUvRTlYK3owbjFVVVdSekFJTEI1?=
 =?utf-8?B?M214TDRxK3BhZUxlaHo4cnQ3Q0hEVG5aOHdnak95ZXFyTkNXZFYxamdQZ2xU?=
 =?utf-8?B?WHZFdWI0bGhSMGt0MC92T0d6R1U0ay9Vc09raFRDSDRjNFlVMktrd0hqN011?=
 =?utf-8?B?L0NCQ2dmK3pBRm8yY1FwTjk0K0V1cnZ4bGhYVHRCRm9EYkdxRDdKVHo4SFll?=
 =?utf-8?B?WGFVOVNGRzZEYWF1QjZkTVc4bVNIUnYyVlEzWHFpT2RqQVZ1a1poSU9sT3B3?=
 =?utf-8?B?QnUyT0tnTEcyaUFXajRMRzlmY3hFU2hvOFJteTFWK25GRkNKVG5zV2tLeE9j?=
 =?utf-8?B?S0Q3dWdDdjEyNEptNmxwczNtdzVyem10YVcyZkJ1Y3hERWZPcjZSWlNWVnpC?=
 =?utf-8?B?TmRaNGY3WlZLNHdXNys1S1NaRzBlRmtLNXRoR2RsaEtsUC9Nd1JxckFSeEsy?=
 =?utf-8?B?UC93K2RJK01hTERaVWhVcWRwbWs1UEw1eE5xRHNmOHRlV2MzdmY4Zkw4emNh?=
 =?utf-8?B?NmpUQ1NVYzBpQkVLbmdSdEU4RmhSN0xRY1c0anR6YW9lMHhJSDZwT2N3ZWZQ?=
 =?utf-8?B?ZVVEdUgvSk5oekVKTE1LYmRGaXp0WmRNdkM5Vy9hdmhXWStXQTl6bkZ6WGR3?=
 =?utf-8?B?UW5QM0gzcnJCSTJXWkh0Tzk2VWNUODV4ciszdUJrZ3pxOTljOVdIZ3dObTNP?=
 =?utf-8?B?UnlUeFhzUENVWlBXbEVmR2ladTRRYytZL3ROSHE1V1NJNElWNHJJb21zNlJy?=
 =?utf-8?B?bWkva0tVRjRxTlAxVTR1REpUTTJuK0d3aFgyV1VRT3hrZzA5TG1HdTVHaDRp?=
 =?utf-8?B?TllmZUpVR2lRNHUxeUl6Rk1LMnRybzBucjdRZmhpNWluWU1hUXZFdTgveHFp?=
 =?utf-8?B?dUFKSU9QVGZwSzdISUZHZXZmbWJyeHFoYTdFdGRZNXc0VDVBMWNCUTdzUjBC?=
 =?utf-8?B?czRHVlBFNHRQVSt0RHlEM2FHQjIwRnVJU20rVWFiRXRiREZodWNEM2ptdTBn?=
 =?utf-8?B?QzRNUXE0UHEwYmdsNGs4MXhkUVI4Q0l1ZFMrQmNhMWxLOUVTVVR2MnhZUWxU?=
 =?utf-8?B?N1I1QnM5YlgwZERZZDFROVpJUFArODcrWW5MVUM3TS9rcmNCdjlESVR2eWJy?=
 =?utf-8?B?VFRXRUtWdUZXNW9wY29BNlNsUzRoT1RBck9EdWNDSHRWYnRXb2NIZ0haRmdl?=
 =?utf-8?B?NkRha25lanhaellBVzNjZTRPWGVYNS92WWtGK3d6SUJWdm42Y3BZbmRsMldW?=
 =?utf-8?B?ODFsSmxRZVdmS3I5ZSt0a0k3bGtnNXBqak9URnhaZFJIbXp6ZVd6SllNTTk3?=
 =?utf-8?B?TnR1bjkwSGV4WUtNVTQvR3UxVFR4dmZ2RlVYWGNkamIwbWdLdzJkc0Fra2lC?=
 =?utf-8?B?eSsrWWdnbmNlVWs3blFQMkE0V2ZQbmNWSlpGUDlZOGNWT3pJMHpCVEZsOUtR?=
 =?utf-8?B?cmJLMGJDRjZEQVdxNlFmQ1VTNVIzZ3QybnFLRUkvL0ZPZXVPMTJzWHBsclc5?=
 =?utf-8?B?TXhKdktnTTZaYUtQRDJ1aU03TDZHVVlpcStUMDFRc0xzT3lyd1pWdFdocFgw?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eEQF9jEiMR6ISNLnR4ny20ytLV+MuJefNCntsZnUHe7m6x1a+wDe2qtpgfj57cdG60MleArlZ8D+SwJRvqiaZvVhu7Q3dqG1g2ViCzu0xtessg24fuqhETH7hDC/8E17tMKcX0rbfpmwapiK7kNPAdOTnYvqKIGVL4xwTircvIzzrwAGtmgLOWoqQ3KdFr6Z9gOkmdfpcPcksjpFAflP2xYoIh+FdC7Ggnip8jrrlVH6OJ1bKne96XR2w6lAB9GfgdwLPIsg+aclRXNv7bGPish4MACiCS6HvUg5ti/ytuvbZDkYjNBigpao90PSx476nGOb4j4YxscTXtn0k8hU7g19GvJBY1vGPhqSUdTEv1QvG9WiI+pRsWOK5BpjAI3ReDM6FYdJ3tPicIalBa9ZyW4r4mc1jveSTNzKs7iGrAkad84gb7PAgedfPKvBVbBTPZaQ8lmVtK8+j/iZM4zrcx0Obw3qxXVfccY8zhDKHC4tlvI7pDpALOQqMepdkjBLWcuGtKOPp9Sbo+i/QXkWuq6pfrJGb2LxNkWzck5gWEoLeVSZAPRTBdIMnohFbnexpLiZi+mrb+e4N4wTOcWLKGcLtt8uI7lZlkgmvZLEsw8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0a369f-7c80-4d43-573a-08dd94a33fc4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:58:22.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEh2QZyAUxllgX9b336hMIv7iVR0XgR2feVSvFmNmJ/CFWSRxr5Ax8eyvyBnIPB3W+8C417wc3drT81MDlTXygaBVCcHPGZrohWtTq1WRXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160175
X-Proofpoint-GUID: A2m9qaxhWUdQ4NEDQ5uiGHszh70LH5kM
X-Proofpoint-ORIG-GUID: A2m9qaxhWUdQ4NEDQ5uiGHszh70LH5kM
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=68277cc3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=0ch75LPG49Q5viAL-YoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3NSBTYWx0ZWRfXymahNyphHKDT
 Pvd2lrj0jPibEIS3w8bOFliujmZTF2QVQUcqRH3dbnlrgomOB9JpurtjkUoEV+mHRcjD6IhqgCc
 Bmw88de9wNxgE7pq+j9JDqIT45AVStTE73WClyQZSseRpecviiCsPxFJiIhkqd2tEevPNXVPr4v
 idxgzcNWRqHwt/qCuI4RqyZHHySpCfW+CvKiVsSp6Nhqr68S3tj31YS4tRrbNWrDVCHJJKHW8ku
 U7BnFgLKdw6BZimxKtAiOeWMZsE/9w4ceBB4+C3ytSB766AbsWr0OBroiRm2LjvGLjYfRScg9WD
 3ad9RroSui+dEWGOnn0XuiV4UzHcvIhx4UdyZDFdYUBJ+v/HyLANK+UumRqYvoNXO+WJp1lzFzH
 X06PBEsAv4uYREF+a+QVG7E+0hGx9q0Jpe0d2kEFBbqS9HlXnt5TjyvjZQRfGtZKnNrmk6Jg
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

On 5/16/2025 4:19 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> Do not reset a vfio-pci device during CPR.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/pci/pci.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index fe38c4c..2ba2e0f 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -32,6 +32,8 @@
>>   #include "hw/pci/pci_host.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>> +#include "migration/cpr.h"
>> +#include "migration/misc.h"
>>   #include "migration/qemu-file-types.h"
>>   #include "migration/vmstate.h"
>>   #include "net/net.h"
>> @@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
>>   static void pci_do_device_reset(PCIDevice *dev)
>>   {
>> +    /*
>> +     * A PCI device that is resuming for cpr is already configured, so do
>> +     * not reset it here when we are called from qemu_system_reset prior to
>> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
>> +     * safe to skip this reset for all PCI devices, because vmstate load will
>> +     * set all fields that would have been set here.
>> +     */
>> +    if (cpr_is_incoming()) {
> 
> Why can't we use cpr_is_incoming() in vfio instead of using an heuristic
> on saved fds?

We could (and we had the same discussion in V1 or V2).
I thought it slightly more object-oriented to derive the cpr_reused
boolean where an fd is involved, and save/use that in the associated object,
rather than call a global function everywhere. I do not feel strongly about it,
but it is used a lot:

$ git grep -F cpr_reused -- hw/vfio | wc -l
19
$ git grep -F cpr.reused -- hw/vfio | wc -l
27

- Steve


