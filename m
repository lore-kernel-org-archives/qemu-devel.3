Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22418C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucpK5-0004yU-5m; Fri, 18 Jul 2025 13:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucp38-0003Yq-5h
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:39:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucp35-0002ay-2n
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:39:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHI8ce020048;
 Fri, 18 Jul 2025 17:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Gk43ryN5c9UmlEsA/mpbfDGYyjEPmK0p1+a5n1hoJFI=; b=
 CWJZTS+kSQQD1TSMPwFtdxxy2Ro5WWCrdml4ZYkfuhKY7+3yZTJVTv3oCvpQAyoQ
 3uutGsKabLhTlzm9jcY1oRPt7eyHKsaX9dV1LOyRgWtW0924fWP3M+TZveGHzrL6
 YjIq6KMnvBPFJwelKQMfymDknm2Dc4CEvijKor7spLfUln6hbnv26ncVQ4mazHiG
 VBLgRWnNAorfsRfEdkbAJX2WiASQGd6HyBszgCvv10OowouLMVRws6OaRI1g1oSo
 Pi+Zrz/XcNGenMYjmNztSXEMVpfCVbJYusMfpUWCKMoF62uetBoV3qGqugavW/4c
 D94SedX82cQRM15pqLMLBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqxc5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jul 2025 17:39:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56IGXViD013842; Fri, 18 Jul 2025 17:39:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5dvfa1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jul 2025 17:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+aqc/ktLvllSAP/TFIGAvyrpXlKOrmqQIJ3/wN1quq4I2IpF1rXBEBjWFWqZpSGS64e/wfne8v+SN9O2afKHiCJKuzAlo32WAj8A1vVZgZ9hLDu+rHBdQtQXjidFgVpwgj8eJC/2IHGTzVp+7Wpcy5HAbPeOUAWhQdVtafuRcwHbK27rt9n4DmDomehtGP73dL6Xv884z4sTcaS6roua1Vvn1Cki6hpoJrPAcYhPGvcrWX4khJ5y0lLujsXDnWtS0S6krd4IjeKWZmhSicM1Qp9t+3DConK3LT5+rcRbmP2xpg7WKi+MwGcSn7YyydgJG6kvgJEU8/B7F3QON46gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk43ryN5c9UmlEsA/mpbfDGYyjEPmK0p1+a5n1hoJFI=;
 b=cxC9KVDVst19VhnT+zS1OAbqGlUYD5xip+McI3YR3QKAQmEJi0e8RAT6eyd0sKqw+aWMUJ+yjgsgQ1pVF23DjeDNmsC0JoHOc963HDroNGY96qMabMP0Hu9PIrqMdRqM41SuuD9pfkAWujlDQQxZNtvW0OmLcszyWfg33ZYjEXZG7a6eWHZ7AQ0UsKW5HbEgVXIQpHDYlSSnwIix0fSbKhVf/DJUaNplfWKANExfTnx1gBuuPvZBkiXNkRJf0F2S3YVQe00w9wuyllWmSEzcw715QDdB/wOC44ykkzudad1WvrJthoXCDrqm2hSbdT1nCfkhDo/nD3hfmmxqBEt1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk43ryN5c9UmlEsA/mpbfDGYyjEPmK0p1+a5n1hoJFI=;
 b=hwKoQim3OEVI5cr4dBYwjKUo9zIaEtyzrfPXlC7afXE6aPC4IBOH/Du08k7iKdm3xjPJpjE6mkoHugfVhfsJ4Du89JzYXo1zvIAWojhlCdH2TuKOKdRgum6Hb/m3ahRQ1Ey4kV3ZDKlU8355HbvYFW4OC8lOHJDhTZ6toY9+fig=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7317.namprd10.prod.outlook.com (2603:10b6:8:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 17:39:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 18 Jul 2025
 17:39:00 +0000
Message-ID: <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
Date: Fri, 18 Jul 2025 13:38:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: fb85a8fb-5053-4335-cd93-08ddc621fb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmVGMFhGa0Myck5XeWdZUlRtbVBVRDFWeFZ6RS9tOFI3ZitMdXBoYlU5dmtx?=
 =?utf-8?B?c1Rmb0JZY0U5ZUFKUVByVnBzUUI2aGlVNlFvYUhpc1RzWEVwb3graGFmUlJZ?=
 =?utf-8?B?ZGNxdUFVTVRCaFcxWGJ2N1RidkszOGNhUktLSDYybVk3aU03eWk4dVFPenM4?=
 =?utf-8?B?RTRPYU5FOUVJUVVSdXJKckxWNjJ6SjVRY3g4NnJsbXpzYjcyYW9ZQ25JcXlX?=
 =?utf-8?B?b0RWVXE0SUd4R2s1OERId21pSmkxczczTllKcC9EcUltaW9nRFNSYUg4OVNh?=
 =?utf-8?B?Mit0aUdJWU1pa3Z5Lyt3RXZ2ZXFqV3lLKzRSTEl3bzZyUXdFbkFaZnM2anFS?=
 =?utf-8?B?aVpSeHRoc1NOTDlXOEhNWWdCdVQraFhvV3NlUm5MdkcxbGlhTzVrZ3Vkdzgv?=
 =?utf-8?B?NW4zVWdBODNMSHM0THRaVjNJMkY0NktoOGhFNGlCM0ZiZnB5TFNWWDJrYlMr?=
 =?utf-8?B?WHhYK05vUERUVlk0RW1Ed1pzenZuMnZidjJQSCttcm5FdEwrby94NWN2TlJq?=
 =?utf-8?B?M213ZVV3bVIxd2VWclByREswM1hpOGZNNDVaU2lSYUxMVjhnRDVENVV3OVc3?=
 =?utf-8?B?MlBsSmtsVnA0Sy9Sbyt0M1dyNU5VVWRJS0trZitidkYwOUQwMStsUmFGSkYr?=
 =?utf-8?B?cWpmWUVhb3hObWxQODA0eXppcXErMFVjYnN4clhyRUVVdjJ5RkFhbjhHQ3ov?=
 =?utf-8?B?NkZlZ05TWTVBbHVOY0dJWHF1U0lSeFJaNk0vNnlWREV4Y2lBWVBLYVJTV2Jq?=
 =?utf-8?B?SWNkYnFvcVhDUlVDMkk1U1YxOWlIdkhqeGJhSkl4NnFLdkxGNlh3WlAwSnJR?=
 =?utf-8?B?UnlMMG5WRGdTSmphS3dtc2lzUDFpektoOEVDVGN3Tk5SalpaRkF5d3ZNNk9I?=
 =?utf-8?B?VXMrNHRNMWcrdERrbENSVjBNcElkdndzNkU4c0RxaGpITDlkMktYR1ZRUkNh?=
 =?utf-8?B?R25KbzZIMm96VW8xdXVmUkZDU1Z5NEtGNXlLek1randpNWFVZ2pRajBRZmhN?=
 =?utf-8?B?YzZsN2dyTE5FMjBVYm9sNVByVmdaaXB3OUxSSEkzQ2FaemMwdDkwemI0VEIx?=
 =?utf-8?B?TjB1Qml2SkQ2NHJVZW9LOTRlVkZ4a2ZCZFExK3RXTldmUXJFRmxCZmU1eTlM?=
 =?utf-8?B?OXZhRkF6N1I0QTJmcDFmY3FJWU84RzJKYWcyK2hkOTlqNGk4czNOWDQ5aXVJ?=
 =?utf-8?B?bWxJQjJvV3k3a2p1MVJGdlhXZmxBYmVkVTdiOTREV0hBR0JMOFh6YWg5cXJF?=
 =?utf-8?B?Vlg4UDM2eUwzWGNZcUQ5TWRmZkhydnF1MjVBdnVVN0N0RCt2RmVvMUNJUFJX?=
 =?utf-8?B?TG1Wc1ZRUk12eUNFRzRnM0tvYXVqSlRIY1IxZkxkVy9CM0JUN1N5TFJ6RUZy?=
 =?utf-8?B?VHVTVmhSYWozZ1hKbnF6UkFSUWNLTlJnRnBuKzlZbnNnZVRPRmxaNDJEVlhv?=
 =?utf-8?B?WFkxcUlVakV4ZG5hdFlwOUJLOWJDT2RFano4aXZGSVFEZTVYMVNFRkt0Z0or?=
 =?utf-8?B?dGExNkxPYjMxTEJoSzdzMExzcGdPUmozM29NbWxGV1FOTGZVcm5sMDgxSnlm?=
 =?utf-8?B?Q2ZUaHQxR2RTZFRwMjlUQzRURjROMm9WWElqR3pyQTlVZzEzcEN1Nk16TXha?=
 =?utf-8?B?a2FrK25rRzFNdlYvUDlvY1RwdXc5MVpKQVhiS1VyVTkwbjVPc3BiaEgvb1JR?=
 =?utf-8?B?eGxVeGhHYjl1YVpzbmFjZEx5d0J0TkZ6M2JuNTIzdGIwVXpWMklSRDMzRmVN?=
 =?utf-8?B?angxWStkd0NJaDVCbmlFK0hwQVBma3NsQTIrUi9oTkliV3lVdlV6VVpwdm5a?=
 =?utf-8?B?QzJzanBpUW10WllibVpaTXgvS056ODhYT0w3NzlwSjVLY0s4WVdQZWlWaHdi?=
 =?utf-8?B?N1V0d09sRFJIc0VBVXRYai9lZXhid0Q1Z1dFWmJRWDJLK2FxK25jTkh2bndW?=
 =?utf-8?Q?ZeGrAxbrvV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Fpa1NxVWw3aGlMWXRPNEo3M3RYM1hyWDBVaU5aRi9sZDhpaWN3SGZiVnBk?=
 =?utf-8?B?cmhIVlByTnJCc0V1S00vSzFuTlRjZlREbWU5Z2hnRFkxcXRxNEhKMjJ2Y2Jv?=
 =?utf-8?B?MC9acHhnS1FicTVWaXZsQnE3TkNHZHhkbGJQdDRxSklhK1dpUW5MZUR6bHdP?=
 =?utf-8?B?b0tSYUFKNFByd1FPSGdzUElQVmJDT2E4c2dLYlhUVU5URnI5ZDIrWldnbEpp?=
 =?utf-8?B?VEl1b2h5V1dBeStLYjBIdmlKdFdMMVlqYlIxZ2VYWTlwY1RuNWlrWUNlK0F0?=
 =?utf-8?B?VFJIMUp5Z0Y1N3lSUkVUZnlwYUZlSnk1TlF2VVRKTnpob2dldGpJcUZnUStZ?=
 =?utf-8?B?d0dPaEYxczhMRjF1ZmZyaU5aSjNhSHoxSzhhWXJDR1hRY1ZSNWlXNTZNbStL?=
 =?utf-8?B?UTRyK3IxbE5uaU1Zb3IyUXRFejhsU1Fma1BaeDRtWlV1QVR2d2RDUEpKQkd0?=
 =?utf-8?B?ZFRFZ3dNUDBjMUJGdFJMZGFzcyt4SGs5U3VxdDBJN1BwcHR5N09LRlM1eEIz?=
 =?utf-8?B?TEdBdEZLSklCNWh5RWFBUXlncUFveFltWitGMFMvM1ExY2dSMTJqMjgxVmxQ?=
 =?utf-8?B?QkRJVjJ6aTlaTXZITlg3T0g2cHZDRjZXM2o0WklvOWlWOVR3dzcvdUhCT1VY?=
 =?utf-8?B?b0FBZWxhRWNmL1dMR25oY1VNUTBhd0hKL1daSDNWRjg4cStkN1JaYWR2ZXYx?=
 =?utf-8?B?QU54VmNLYTV3aUxZblIzTWtxb2cvd0tZVTg5THVkd2xCVm13Zkg4dmw1c3Ru?=
 =?utf-8?B?RjladmVqanpZYkdkdXNBYkkxb0FlSzBITUJyVThWY29haWx0VFdoeU5EWWJS?=
 =?utf-8?B?ZndNakZubDlRYlZFNTFZN0MxaW9iU3crT1ZjT28vM1hpV0FjelhPT3NzMGRu?=
 =?utf-8?B?RnNZVXNtZ1BVdkk5aXpiRTFZOTRQWURJZDBZQ2lBNlVVR3BkRkJtVjhWaTJY?=
 =?utf-8?B?SmFoQms4L1l2V2IyM05NRDJmYUd2R3ZubHpacTFRRm1tRTBuR0RLMmVOby84?=
 =?utf-8?B?NXZkeC84MEtzU3N0TEtQVTl6OCtIWHdYbG5iL0xTK0lwTHNKc3dhVlJ2a0J3?=
 =?utf-8?B?SDlRSytnQnQrM2cxa0NmeDVBdHZlWHFhaWtEMUdQTzUvem9kOXhBdVZRVnp5?=
 =?utf-8?B?RXd5RDNoaUNZYktubFMxeldUVmQ4aVJjTmxUY1hXb2VnRkFZd1ZrcXBXZTdp?=
 =?utf-8?B?TW9FMThXS0xVWVFIWHc3RitneDc5emh1ZWRHRzJ0NHhGUmtuZXdQT3I3cFNi?=
 =?utf-8?B?UkoxS2lIOG1jcGtjNmRaVXFLN1pCakZJdDduWXd4bHFIdlhzM01PUzZlYkM2?=
 =?utf-8?B?U21oTlIwWUlLdTJGZTFLKzgyLzVSZ3dpRFZreEtUQ2R4SzQvOEVhemNzNno2?=
 =?utf-8?B?Sm1aRmV1UjcwN043ZDZEc3MyZHlPWHQ4V2hEenVpb0xKMHV0RklzNWI5QXlP?=
 =?utf-8?B?YzNTZ3lHb1grd1d1MVp5bllrVXFWVHNlUDFGMVBzZHJPZFNrbFRKWm9Dd2dG?=
 =?utf-8?B?WGxwandpMXp2eXVJWVl5YTVJUEFFUHdPYnd4RHlNcDFsa2NxS25Fam5jdkRF?=
 =?utf-8?B?Zzg3MzhVWVFVWFVOTU91SU1WaHZReVJSdGh1bVJTcjUrVHZBWkszcUVNWlNE?=
 =?utf-8?B?b1o4LzhDcEVqNmhzb05ZRExGRzdnMVpSdTRTdGVyY2xiS0liNzcvSFVLbXRU?=
 =?utf-8?B?TTcwMzFRbitFYkZ1N0lCL2hOLzhjOHhYbzZGYVFhMUNWajkxWGlOTXp5akow?=
 =?utf-8?B?VEZsblF3byttQkdkeTJYQVl1aVl1UUJMU1ptT0FSRVpCYk5xbTJBaTcwMHFs?=
 =?utf-8?B?VXk5RUN5Y2RHM1Y2cmtHaUMrcGEvdU95SjRzNHFxNDV0dGgrTUlTRG9XYmRY?=
 =?utf-8?B?VktENkxlUUJnUS9TSFpEa1d3MEo4bWFRZ3lVVFNML0V2LzkrbWkrMThmOThI?=
 =?utf-8?B?SlBkdDVzOWF5bVlNMk01NFdGcHhtVnVtNW5YMlR1NkVFNnhIcUVBOFRFYWht?=
 =?utf-8?B?cndocURRRGVZZHh1Unl1SUhXTmNoU0ttcmlVaTlLRDhOTitnTDNaT3E4RHBx?=
 =?utf-8?B?RjMzczZqNngyVnJ5Y0Q2WEg2dTlJWmdnODVkZFROUUM5d0c2ZVk2STFoVytJ?=
 =?utf-8?B?TjkvcjRpaklOcEZvWEhpQ21iQ0RNalVrcmdFaUdPdlQ2MkpJYlJLTnZ1dFQy?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OswGMN25vGxzvK3fkj8A/m7uVDSSbthDVF5L+u8z40u1i5EUhj5MD6P3SqVZr62Lyv3Z4sUPq1Kb7jJv0JDBxKJWrvejHkYwQnMOMLhQzD2YOM38NPzwkh/FxlcrLOSWVWciirv63VTPaSzESYE0ok8LdEXniZniRQ1J42R+a0t6bpYug88PGuozjO3TMBb+I0lJl2e810JjwBWeRy51dO5fIMxGca/w9EnQnrnLUUAArKcG+sQ2nGKidGxXKliLfGM0g8iRy1hC+TZojeaQyi5cT87OFpPkzIRg7CZMceB44HMtYZE34zQJm7kGY2ZqJez50NrJAJ8mXx7RKct/tRQEoqZf+1aYAV8cPwdQpBZvNSKTEUPYUx0y1WsIqFPGDBWUtIM7I+1P+tQO6lzR7fjdqgLn7nTSiYeFYdm4tr9N2UI0JjIvqR8AkmqYtPRlQxWJhJcWGeFr/KlYIKnU4ngOT2jktfsBMLpovaRlBcWk4VRK/6VCV3e0FT/3d2FbwHeprN1ZMBhGgNqWmXg/UqpfZKE3U6mQ3IT1K1iSXuxYVIhHWZ31ST8Wo9jhs8QUpDKhp2Zyl/WKjtPKqLH7s2RpsIFaHCxga5QKuzMq+ZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb85a8fb-5053-4335-cd93-08ddc621fb08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 17:39:00.7181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi2QVbRgCcVuKui0swy4n8potbmkYXykXXK36qNyHuUeQrSlXSmQ0kcOeu6AJnWG0GoUZXGF9oyu37xhGgUp5UfRYTxpRQToWk/zba13698=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180140
X-Proofpoint-GUID: aNF3lnHA0__UrGnmORf7FgEh-hV7FsnX
X-Proofpoint-ORIG-GUID: aNF3lnHA0__UrGnmORf7FgEh-hV7FsnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0MCBTYWx0ZWRfX6IZ84LpGzgEH
 l3fWYUnAN1sDNWmN0aQuz76LxOJ7wREmUtPSqutnoV+/W3ychUs0HDZ4cBWFQQZeLB1J/ykIayh
 eitgKSwR7NwQQYoqzmUxaJVAoNtYyfD8UrbqRhEMz+OfJQMZYN5iNnXbCqv3t98TDmiABa587B3
 xMQZfY/8G+n43LKfI//HwrYxYjXfA4bHcGC8mtZFatI2oGGPJo0JZ5fvDe/Nvvf9N3SOSUn/V3W
 c5Qc2yp9TMz2661gnHNlycqaRDfUg+6sMJqwZkjWR9soPOvUUaoX2IVJFBvmxKXjPaLO7MRldKt
 B8NVxt7HqVxRTKQaSXPG4/yH4owN5BebVyxm6zwGmhDy7qzOmwJJbU23XfpC9lV1j2diyhBGcdF
 YrZN1pLzVDs99yx2q8vkwXZ5Yl1rQgy/09Fm0D8dLAm2gd5YLVkBC6l2c3R+L635WVnxd0Y8
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687a86b8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Z9xao1b4iD_sc7ps_AoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/16/2025 10:43 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>
>> cpr-transfer may lose a VFIO interrupt because the KVM instance is
>> destroyed and recreated.  If an interrupt arrives in the middle, it is
>> dropped.  To fix, stop pending new interrupts during cpr save, and pick
>> up the pieces.  In more detail:
>>
>> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi --> KVM_IRQFD
>> to
>> deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
>> After this call, interrupts fall back to the kernel vfio_msihandler, which
>> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>> eventfd.  When the route is re-established in new QEMU, the kernel tests
>> the eventfd and injects an interrupt to KVM if necessary.
> 
> With this patch, producer is detached from the kvm consumer, do we still need to close kvm fd on source QEMU?

Good observation!  I tested with this patch, without the kvm close patch,
and indeed it works.

However, I would like to keep the kvm close patch, because it has another benefit:
it makes cpr-exec mode faster.  In that mode, old QEMU directly exec's new QEMU,
and it is faster because the kernel exec code does not have to traverse and examine
kvm page mappings.  That cost is linear with address space size.  I use cpr-exec
mode at Oracle, and I plan to submit it for consideration in QEMU 10.2.

- Steve

>> Deassign INTx in a similar manner.  For both MSI and INTx, remove the
>> eventfd handler so old QEMU does not consume an event.
>>
>> If an interrupt was already pended to KVM prior to the completion of
>> kvm_irqchip_remove_irqfd_notifier_gsi, it will be recovered by the
>> subsequent call to cpu_synchronize_all_states, which pulls KVM interrupt
>> state to userland prior to saving it in vmstate.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/cpr.c              | 91
>> ++++++++++++++++++++++++++++++++++++++
>> hw/vfio/pci.c              |  2 +
>> hw/vfio/pci.h              |  1 +
>> include/hw/vfio/vfio-cpr.h |  6 +++
>> 4 files changed, 100 insertions(+)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 2a244fc4b6..bca74ea20a 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -198,3 +198,94 @@ void vfio_cpr_add_kvm_notifier(void)
>>                                      MIG_MODE_CPR_TRANSFER);
>>      }
>> }
>> +
>> +static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>> +                                  EventNotifier *rn, int virq, bool
>> enable)
>> +{
>> +    if (enable) {
>> +        return kvm_irqchip_add_irqfd_notifier_gsi(s, n, rn, virq);
>> +    } else {
>> +        return kvm_irqchip_remove_irqfd_notifier_gsi(s, n, virq);
>> +    }
>> +}
>> +
>> +static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool
>> enable)
>> +{
>> +    const char *op = (enable ? "enable" : "disable");
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int i, nr_vectors, ret = 0;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        nr_vectors = vdev->msix->entries;
>> +
>> +    } else if (msi_enabled(pdev)) {
>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        ret = set_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
>> +                                     &vdev->intx.unmask,
>> vdev->intx.route.irq,
>> +                                     enable);
>> +        if (ret) {
>> +            error_setg_errno(errp, -ret, "failed to %s INTx irq %d",
>> +                             op, vdev->intx.route.irq);
>> +            return ret;
>> +        }
>> +        vfio_pci_intx_set_handler(vdev, enable);
>> +        return ret;
>> +
>> +    } else {
>> +        return 0;
>> +    }
>> +
>> +    for (i = 0; i < nr_vectors; i++) {
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +        if (vector->use) {
>> +            ret = set_irqfd_notifier_gsi(kvm_state,
>> &vector->kvm_interrupt,
>> +                                         NULL, vector->virq,
>> enable);
>> +            if (ret) {
>> +                error_setg_errno(errp, -ret,
>> +                                 "failed to %s msi vector %d
>> virq %d",
>> +                                 op, i, vector->virq);
>> +                return ret;
>> +            }
>> +            vfio_pci_msi_set_handler(vdev, i, enable);
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +/*
>> + * When CPR starts, detach IRQs from the VFIO device so future interrupts
>> + * are posted to kvm_interrupt, which is preserved in new QEMU.
>> Interrupts
>> + * that were already posted to the old KVM instance, but not delivered to the
>> + * VCPU, are recovered via KVM_GET_LAPIC and pushed to the new KVM
>> instance
>> + * in new QEMU.
>> + *
>> + * If CPR fails, reattach the IRQs.
>> + */
>> +static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>> +                                 MigrationEvent *e, Error **errp)
>> +{
>> +    VFIOPCIDevice *vdev =
>> +        container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
>> +
>> +    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
>> +        return vfio_cpr_set_msi_virq(vdev, errp, false);
>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>> +        return vfio_cpr_set_msi_virq(vdev, errp, true);
>> +    }
>> +    return 0;
>> +}
>> +
>> +void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>> +{
>> +    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
>> +                                vfio_cpr_pci_notifier,
>> +                                MIG_MODE_CPR_TRANSFER);
>> +}
>> +
>> +void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
>> +{
>> +    migration_remove_notifier(&vdev->cpr.transfer_notifier);
>> +}
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 8b471c054a..22a4125131 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2993,6 +2993,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>> {
>>      vfio_display_finalize(vdev);
>>      vfio_bars_finalize(vdev);
>> +    vfio_cpr_pci_unregister_device(vdev);
>>      g_free(vdev->emulated_config_bits);
>>      g_free(vdev->rom);
>>      /*
>> @@ -3442,6 +3443,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error
>> **errp)
>>      vfio_pci_register_err_notifier(vdev);
>>      vfio_pci_register_req_notifier(vdev);
>>      vfio_setup_resetfn_quirk(vdev);
>> +    vfio_cpr_pci_register_device(vdev);
>>
>>      return;
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 80c8fcfa07..7989b94eb3 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -194,6 +194,7 @@ struct VFIOPCIDevice {
>>      bool skip_vsc_check;
>>      VFIODisplay *dpy;
>>      Notifier irqchip_change_notifier;
>> +    VFIOPCICPR cpr;
>> };
>>
>> /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot
>> match hw */
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 80ad20d216..d37daffbc5 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -38,6 +38,10 @@ typedef struct VFIODeviceCPR {
>>      uint32_t ioas_id;
>> } VFIODeviceCPR;
>>
>> +typedef struct VFIOPCICPR {
>> +    NotifierWithReturn transfer_notifier;
>> +} VFIOPCICPR;
>> +
>> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                          Error **errp);
>> void vfio_legacy_cpr_unregister_container(struct VFIOContainer
>> *container);
>> @@ -77,5 +81,7 @@ extern const VMStateDescription vfio_cpr_pci_vmstate;
>> extern const VMStateDescription vmstate_cpr_vfio_devices;
>>
>> void vfio_cpr_add_kvm_notifier(void);
>> +void vfio_cpr_pci_register_device(struct VFIOPCIDevice *vdev);
>> +void vfio_cpr_pci_unregister_device(struct VFIOPCIDevice *vdev);
>>
>> #endif /* HW_VFIO_VFIO_CPR_H */
>> --
>> 2.39.3
> 


