Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95899C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiy3C-0003kV-2K; Fri, 14 Feb 2025 10:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiy37-0003bs-De
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:56:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiy34-0005Xm-Aa
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:56:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFBcKl006492;
 Fri, 14 Feb 2025 15:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7fZRkrikUMH70wPFkas2vaFtXQqIpeujQj5vAdumlMc=; b=
 LIU9HuvC1iB/c0c0IHiUMNNEEa709Xuz6REUamDAykrUkIFnsqXjVq9S3amg4O4R
 2AtR4ubv4onPFl+dMA7QSvFf0W9PIt1k3OLC0pERzz9KJubHQC1fqX6SMDOSd0SX
 S4bTqxB3R3a/kARvUyM6awuCthnuFnQDbByCOtZOGd5RKAykiUYmdlUjKRsSqxFD
 VX4eHmGGcYu9EDZ8VTD4Po19gFOyctRHufvkYrCPSNfnvgib5DL13E1D0LH2R839
 JSumDgygq58LjHxxCWyzzzxeRp1C4xhVStOI1mn+6L/VKqQOqugMHI1CcURP/q2W
 IhdV0rAgjTzUeV0LGT8W6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4bujd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 15:56:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EFpqdN006640; Fri, 14 Feb 2025 15:56:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqd9kmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 15:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKLW/yDwGd8lS6ABEBh6E3tysTGln3AC9r/bzvWmZ/n2jjh2zo07H1He2DYB6qyQkfdEn9HqVizChU8tho/kn+apYz4vX87BVd0bH7VEOYWctPEUJBMv9PrAS4CxZnNFCybfxGYHl3WC0V4KCoyDc0JYuW5WvYBJR3BVX7QBwqO0U2Bu6n1eojjrEJOfNwN5QYWCdsjFqls5G84zR61G0TDED9CduVRrwSfJOXc0ecNmLKZdsO5r1N6OywkC7un4iUyHr9pnYLipnNfTJPtXkinbNcB5as1uljTgfHjbonJrVYDvuVXGfwrJkRvfkoGPTUJNbko2z3Ztjc5jj5RKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fZRkrikUMH70wPFkas2vaFtXQqIpeujQj5vAdumlMc=;
 b=dJ3L2fIiF/BW6p1LcCCXP8m0nLht8BwKFNUeC4Tl4nnBYG79+qbLcGNtzlNhjRsQsdyYQLvQM7kFPgnR/KMU7bebAoeP46r2c5BsjPgI1WVD7HixH7HckuXNdPK/GxSahvVn5PvG3bEZUddrPDshpV5uMC9DJUaAiN1U/UBl44qBA6w6ih8v2kojPzhPjO0N0R7hkCh1CPcc19uD7lEaz0vIaTUahQ0nJv5ihIZi5VwPGURFaSZ+mJ4y3/IYfS+XZlNtzAZpWA/q2zqYRLRDu+RhbNdpuiWmKTlQkX7eqe6lY+HVkz9/LXmh8aKAWlHSkbLhsYddTse6lC7CiiOMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fZRkrikUMH70wPFkas2vaFtXQqIpeujQj5vAdumlMc=;
 b=d1ecGc/8pnqt0c/Lj8VTnLclfefAqT6Ij2bzfmoIwRB0BeBB9oP31KP4BndimmGribzhv5SfVom1QFQ+bxTR3R9ZR4IVZ+B2NzXtu4b5pjnL9MGXXbK+aF4T/MneKRVvwz/3tleRMYe9e2DnWcgBGbTV4m+ChoIsIaKFlDHpyUU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4610.namprd10.prod.outlook.com (2603:10b6:303:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 15:56:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 15:56:07 +0000
Message-ID: <45420461-ead5-4b72-8f84-cddf53e2b95b@oracle.com>
Date: Fri, 14 Feb 2025 10:56:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/45] Live update: vfio and iommufd
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a0d11-33e6-4b45-804a-08dd4d101809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1M2YnAwUHZxcnlCaHI2cmJHVE1hSStuSWZVSXNsQkRlTDVxZkdkZGIxejc0?=
 =?utf-8?B?c3hlckQ4OGg5akMvMmk4cWx6MTFkV3ZtZENrZitNekZkVytYZVZla2J0Sm9B?=
 =?utf-8?B?djJJT24rYXk1d1NQUEJxREdMYUZ3ejcrMjVqcEJYemR4d2gvU1Byc0lQeEQ4?=
 =?utf-8?B?QXovVTZFSmVHREd4eXJRYi9ZaVlxSjZsbEVDcUZtbW5OWmpDR1doaGR3ZXBZ?=
 =?utf-8?B?dXBuV0tGb2tSeWdab3AxNDMwWEtZS0tJSWl3M3hqVnZER2dMOG5BU0NZakdC?=
 =?utf-8?B?a0k0ejh0ZzQ3aU9MbmdOVktjMWI0Q3BtaWJUZlpiZmpnengzWE9GNWdJNHhp?=
 =?utf-8?B?VXZaclNkTTR0MTEya1VOZTY3aWdxUWxnVWdnMklmcks5T0x2eUNCK3FHRGZI?=
 =?utf-8?B?b1hRSWhHaHQwL0RjK05CTUdvUGh6UTZTM3BjaExWUTNiSGM4TzNJQmtja2E0?=
 =?utf-8?B?QThiY2JheXI1WlFwWGhWZlRzTXdndTErdHE1MHRrQVFRdGhZbWZYaUVTRzBp?=
 =?utf-8?B?SEUrUC9QTlJyQ3dWSTkycGkzc1pBbHIyTTRxL1BHM0dkNG5XQThjL0M1ZHk5?=
 =?utf-8?B?T0UzWHhXeXZYenk3dUpUNVdKOFh0Z0hLUHVPN0ZxdkNpdm8vL0pKcHJCSDBt?=
 =?utf-8?B?bGJMRkx4c3F2T1NneHFYOFhLVDhYRnJUemVZM0FOUWN1QitrRzFISjc3ZlNR?=
 =?utf-8?B?cm9EWWVoYUVpaUErYXZOdWptY0Q4WVJ4bUdjRGFXdVA2NzMxVGMzNjhLUkNM?=
 =?utf-8?B?YUFBd0dyaDVsQWdYaFRta0RlVVJraW84K3RUbytUSDNqemExc0E2bGJQSUNR?=
 =?utf-8?B?NVdsc1h1SUplTGRsM0JSekdUWnZLbUNCaEdRQmFOa1hCNlV2bjFEaFA0SjFZ?=
 =?utf-8?B?dHdOWnVoTTc1WjU4OTNzaWc5ZnFSOWw3MmY2RmdFT202bHVIdklLUDhjZytq?=
 =?utf-8?B?a1pRbm1kYkdncy9DckVuR2ZLKzFxZjM3OHNwNjBuRmRsSmFtU2FmZjMxNEs5?=
 =?utf-8?B?bEdVeWdiZ1NDWXdzQU0wVXRaNFFWQXErbklRSVdsbVFMWTlkQWNBK3JTV1lQ?=
 =?utf-8?B?MnRRY1lsMGlKWGlzcWxQZkJRVVZFNDNpblFIcjY5bGFRR2l0MWlZN1lGdzlu?=
 =?utf-8?B?ZjZWalU4VWNWOFRMaXM4MHR5LzVVQ01jTU1nYlpLeDVjTnJqUFFLNFluR3pM?=
 =?utf-8?B?Z3ViUlY3R0c5UHlhTGJsbjJNR1FEUk5IaHNVdnBGL0hna1BEZ3ZjZk9lR0dC?=
 =?utf-8?B?Tjd3L0JkMVNGWElNbjQ0SkpoQnhjYmxSNDZWbkhJV2ZoMmRmL3lHUTJjU1FU?=
 =?utf-8?B?NitUNlN3dEJoR2UraDJZRGhVaDBIYXlmK1lZOW9JMTJheDVuV1BvTHYyYnFN?=
 =?utf-8?B?b1cyRXViT3EwRFY0cUNaWDFVeEs0Q0Ntai9jOTBaRkN1WDNNaHk2YWpOWXFU?=
 =?utf-8?B?bGgyVHEwUnBaV1ZRays0ekpYd3RrVU1Xb1duMGZMbUJtWUd6amRZWVQ5dHBh?=
 =?utf-8?B?dTQyUWVsTDlGdTVISFp3aFdPK0tXMXVlWitEWkx5VHJkSWd0RzZyUTc5c2ZM?=
 =?utf-8?B?L1lBMk4wQW9oUitSRVB6aGpBcWY4YkFrL2gxYk56UnQ4ckFxUUxEMElNK1Bw?=
 =?utf-8?B?b2VuZmFNcTNRcEVpZWl5NW93cktZSG9UNmRiZWo1aXN4aHJ2RC96clRFbkJL?=
 =?utf-8?B?RFVUZ2Erc3NxbFh5YUIxMkRMVktLSlh5a2R4SWRVc1lLdW9lMHJIQnlsN2pH?=
 =?utf-8?B?dmhZZEEyQjV5eFFhM1ZEWXZnOW9mbWdwRGJzWkRPV1MydzRBVmdSYis5SkZL?=
 =?utf-8?B?T1g2SFAzT2VXdUdVNmFWWkhaZFRMejY5aTJFOW5RTTJJNkN1czJJVnpHcThU?=
 =?utf-8?Q?/PQAMuqauP5X4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JlWk43MDJlMjAxSnpLRTRDekkwNnNFc2xJc1Q0Z3BoRjlBUDR6QVVxZ0Iy?=
 =?utf-8?B?L0twRkQyK1N0RHdnbG1UL2hHeE9IRlhlZWozMGV3cCtZb0EzR3ZpU0lDT2ta?=
 =?utf-8?B?MjM0bWdZSmZ2NGZGTGhrc3Y3c2dBRmtEMVRsU1BuUXg4UkRSbVBFVGtHL3p6?=
 =?utf-8?B?dDNYSVcwdEUyKzNYenFobmxQaGtLczEvVTIxd2IwbjEvVEJkK01tbHc5b25N?=
 =?utf-8?B?Q0Q1Sk5nVC9kdW03ZG9ESFhSQ3N2R1hFWkdMZjIxU3ord0dDWUdobFcrbCtt?=
 =?utf-8?B?akhoYktXNDhlcUpiMG85c2R6VXZvb1FMbEE2bWNDMlJZSUdmQk5wY29OWFcz?=
 =?utf-8?B?RWFrdjRLcHBEOUJ3eWtpc1RKY08xS0VHYlMvSEdYMk9kK0xjNEF3ZFNGZWE0?=
 =?utf-8?B?eTl0Tk1YclhlT3pwbXhaNzRIOXN0M1Rtam1OTm5kczZXZmRKWmtHbWR6N2s4?=
 =?utf-8?B?aEduNFFQRUxhOTBrVlUxd0JHOGMxV1BvUndaaUdTSUROL3g2b1gwYUNjNzZi?=
 =?utf-8?B?dXVXQU9MSWluQzgvdmlWNnZoT3BDWjZ1c3E0a1RqQ1cyTlNaeU5YN0dicElH?=
 =?utf-8?B?VWVBZXFTbTdXK3BBTXcyYVpWaFd2MUh0KzRKNC8rRVJvVlRJY3dXSjUwdm5m?=
 =?utf-8?B?SU12b2g3ckg3aXAwYU04cEhaaFFaT3J0a3czdXliTzAzNlRtYnhhenI4LzA3?=
 =?utf-8?B?dC9JVVZJc0tGQjhJSFdkTUVTeE5FNzdSajJKMDNCdmg2MkdmUW11OTdtRmho?=
 =?utf-8?B?NW9ldWRHTnpMTVcrQmR6MHhoZlZyUWZUS2tLZURyN2FkVWV2UG10UGluTWdE?=
 =?utf-8?B?b1BabU03MG41S0daMVBUaDRiM2Q0YVFKOVR6YlhJbEtmUnZUV1V6STVUTGE5?=
 =?utf-8?B?RlJJZmgzbERldHBsSUVrZmtMWmNzL2lRdG5TNkxMYVY4S2FISnRVRTFUK09p?=
 =?utf-8?B?azZPRGZ0ZXB1YTQrd2ZWTTZabzlXTm0xSEMzaXNsLzhGTjhiaW9vOUhrQU1k?=
 =?utf-8?B?YUFCQU0yWlpaTTFqYm5vcjl0NkpUWEZFQ2RIR0JjSC9jN1BUdkZMaU9GVFM1?=
 =?utf-8?B?eWFoejhVK1dENkFBQW1pN2pXTWJuZ21ZcVA3TSttWFpTRmdnY3FSR1NiOWox?=
 =?utf-8?B?THRwNGNKTXEyZVZ4a2tSVm1RMTkrUDl0QkZCOVBmWTZNa1FlWEE1NE9JVklX?=
 =?utf-8?B?WEl3c1FFNkJDQVlIcFlGb3EvQ1ZDK2E4SDdOOTBxNE9KdGhjVSs3ZnRQTFpZ?=
 =?utf-8?B?RUlkUm1GeTh3aHFFWXVXS1RlMFdmVmxkNnczanJTWkx1QXplUm9RVmxneVRm?=
 =?utf-8?B?QklpbFFxZlVZenpKRFpwRk1yZGpIcDJXanJCSUVXUjl4RXJxRHJWU0llQ3lq?=
 =?utf-8?B?NnpWanl3bHlKWlZxdElXUDRPdFpWZG5DVWFkdm5BaVJveVVpRlErdUEwYkI5?=
 =?utf-8?B?dHJSTTE2NVhBdVZJeGR5Y2EvSGo4ZVZhZmJ2ZHJabVFHcG44c1lOV0c0K2M3?=
 =?utf-8?B?clAwYlV2d3RMODZDYWlFeDdFTzNiVUVrL090cHlTbElnclM0eGo1STdKRm5S?=
 =?utf-8?B?S01kbHRwSXArZUpHaEQxd0FnSENuY2VucmZIRkI5V2RPR2Y2amxsSUlKdzhy?=
 =?utf-8?B?SVB0YXl5cXV0SzlyZWdSZVBBZ0tESllSMjRuQ2JuazF1MjNXMCtKSE1zWEVI?=
 =?utf-8?B?RXU5REFiSnAyR0ZhYmNzbjMzaFJVVWF2RDlyK2t1QXRCSjhrMWhXWlVjalU1?=
 =?utf-8?B?a1lpL21hT1pUcFFNaDNnYU95a1RXekJzL3NFRFhHWi92TXVSMVJ2YlZPUHg3?=
 =?utf-8?B?WkRmSWFTM0NZaGpMckxNSFhLdGdlUk5KTk9seE42UUxJN0tlNzBsbXE3WUlV?=
 =?utf-8?B?SkdVemFYWm15SGVkSGp2VFhoaFFUYlhoM25mMnh6VUVNM3ZmczdZUGV6T2Rw?=
 =?utf-8?B?eGJHNHRvY1BXeElkVzRCRTA1a2cvVVc1aUVTbVFnQ2RTTHdsSGxWYVM2Snll?=
 =?utf-8?B?ckZ4QTkwb2FHWGZxT0RlcFZrYUhSUXhNN3Z6T1pMQytsUlh4TkNPUlFEWlN6?=
 =?utf-8?B?aXdSSzFvdTZzS20xL2VSU1RRSmwzMFphUmp2L1Y4b0FDMm5RUmE1a1pNdHlv?=
 =?utf-8?B?RW1zajExTHNCZTBVOWF3VjNod0xOTUJTVm5Lc2YyVHhqWlJtdjlGY1JIbEZs?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fINL1Wgk0CgVuDzyG9YVthUJvp46/1b+fy6/qkD2QzR4OfzcEfkvK0NXMo+pPNdVHa+GNfwmhLTML3DXRgvR21OPSa7ATvbmEFa+pLVUQAgYZQEinmZmA61uW2IrMq00DjpxPBhEtwzeWZghrQV8RNgi0gJ+p5XUkHVDrmJtPUImilBbGASITnHBgavpGkYTSBB6eozZ6BZKslaAyPArzB45YWV2dlg4dvC3p/GzEKtE6eAu4Q1bQNUepDH66KQoJda7PmLxwWCTKn3db02pTgF8l5SYolHpMezmS3RD7/Ik88FxX4XsO1l4Hb9Ov0x1yLcUVnuKKH9XN6AhdYXcOA8hk8mIN2VUILza1g5HIllu3z+BxkXnRcKf3X8JhiS5VXTBTHxPxjFzLNJBsRwDqcClcpEM5MK3no9sFZKtN09rypvZnsJZp4XkkzxicL3BAxqeSxZegTgC7yFQqnufW1p52pKXeF1NrT8JTCI0fRxALEKUSWZhdABSOe6EZNqDmdGey0eUtRu4oF9TL0fR5eNYs8wi011gJzQBUI4dQJdxJaCHvGe8nV3pa0ZY/DX8MviGEF+ThULXOyMFdMKfixvrd+SGeuSfUAulRlqgcS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a0d11-33e6-4b45-804a-08dd4d101809
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:56:07.6393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/Xhhhkr7YrDtHe7eNxQFOZMVtDTA4PC7/EOS6p0lGmhkdiDFsJVNSpp3X8suSUquUT/y13ywIdqekD1zoJm3CtxYhJOKdNVPh3MwCOxWqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140113
X-Proofpoint-ORIG-GUID: vr6gj-4FrF4pgBbuJTNATwaq4yEvzcou
X-Proofpoint-GUID: vr6gj-4FrF4pgBbuJTNATwaq4yEvzcou
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

Hi all, it would be nice to get this into qemu 10.0.  Without it, the
basic support for cpr-transfer already in 10.0 is much less interesting.
Soft feature freeze is 2024-03-12.

- Steve

On 2/14/2025 9:13 AM, Steve Sistare wrote:
> Support vfio and iommufd devices with the cpr-transfer live migration mode.
> Devices that do not support live migration can still support cpr-transfer,
> allowing live update to a new version of QEMU on the same host, with no loss
> of guest connectivity.
> 
> No user-visible interfaces are added.
> 
> For legacy containers:
> 
> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
> skip the ioctls that configure the device, because it is already configured.
> 
> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
> QEMU and update the locked memory accounting.  The physical pages remain
> pinned, because the descriptor of the device that locked them remains open,
> so DMA to those pages continues without interruption.  Mediated devices are
> not supported, however, because they require the VA to always be valid, and
> there is a brief window where no VA is registered.
> 
> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
> data structures, and attaches the interrupts to the new KVM instance.  This
> logic also applies to iommufd containers.
> 
> For iommufd containers:
> 
> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
> backed by a file (including a memfd), so DMA mappings do not depend on VA,
> which can differ after live update.  This allows mediated devices to be
> supported.
> 
> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
> QEMU, during vfio_realize, skip the ioctls that configure the device, because
> it is already configured.
> 
> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
> locked memory accounting.
> 
> Patches 5 to 14 are specific to legacy containers.
> Patches 27 to 44 are specific to iommufd containers.
> The remainder apply to both.
> 
> Changes from previous versions:
>    * V1 of this series contains minor changes from the "Live update: vfio" and
>      "Live update: iommufd" series, mainly bug fixes and refactored patches.
> 
> Changes in V2:
>    * refactored various vfio code snippets into new cpr helpers
>    * refactored vfio struct members into cpr-specific structures
>    * refactored various small changes into their own patches
>    * split complex patches.  Notably:
>      - split "refactor for cpr" into 5 patches
>      - split "reconstruct device" into 4 patches
>    * refactored vfio_connect_container using helpers and made its
>      error recovery more robust.
>    * moved vfio pci msi/vector/intx cpr functions to cpr.c
>    * renamed "reused" to cpr_reused and cpr.reused
>    * squashed vfio_cpr_[un]register_container to their call sites
>    * simplified iommu_type setting after cpr
>    * added cpr_open_fd and cpr_is_incoming helpers
>    * removed changes from vfio_legacy_dma_map, and instead temporarily
>      override dma_map and dma_unmap ops.
>    * deleted error_report and returned Error to callers where possible.
>    * simplified the memory_get_xlat_addr interface
>    * fixed flags passed to iommufd_backend_alloc_hwpt
>    * defined MIG_PRI_UNINITIALIZED
>    * added maintainers
> 
> Steve Sistare (45):
>    MAINTAINERS: Add reviewer for CPR
>    migration: cpr helpers
>    migration: lower handler priority
>    vfio: vfio_find_ram_discard_listener
>    vfio/container: ram discard disable helper
>    vfio/container: reform vfio_connect_container cleanup
>    vfio/container: vfio_container_group_add
>    vfio/container: register container for cpr
>    vfio/container: preserve descriptors
>    vfio/container: export vfio_legacy_dma_map
>    vfio/container: discard old DMA vaddr
>    vfio/container: restore DMA vaddr
>    vfio/container: mdev cpr blocker
>    vfio/container: recover from unmap-all-vaddr failure
>    pci: export msix_is_pending
>    pci: skip reset during cpr
>    vfio-pci: skip reset during cpr
>    vfio/pci: vfio_vector_init
>    vfio/pci: vfio_notifier_init
>    vfio/pci: pass vector to virq functions
>    vfio/pci: vfio_notifier_init cpr parameters
>    vfio/pci: vfio_notifier_cleanup
>    vfio/pci: export MSI functions
>    vfio-pci: preserve MSI
>    vfio-pci: preserve INTx
>    migration: close kvm after cpr
>    migration: cpr_get_fd_param helper
>    vfio: return mr from vfio_get_xlat_addr
>    vfio: pass ramblock to vfio_container_dma_map
>    backends/iommufd: iommufd_backend_map_file_dma
>    backends/iommufd: change process ioctl
>    physmem: qemu_ram_get_fd_offset
>    vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>    vfio/iommufd: export iommufd_cdev_get_info_iova_range
>    vfio/iommufd: define hwpt constructors
>    vfio/iommufd: invariant device name
>    vfio/iommufd: fix cpr register
>    vfio/iommufd: register container for cpr
>    vfio/iommufd: preserve descriptors
>    vfio/iommufd: reconstruct device
>    vfio/iommufd: reconstruct hw_caps
>    vfio/iommufd: reconstruct hwpt
>    vfio/iommufd: change process
>    iommufd: preserve DMA mappings
>    vfio/container: delete old cpr register
> 
>   MAINTAINERS                           |  12 ++
>   accel/kvm/kvm-all.c                   |  28 ++++
>   backends/iommufd.c                    |  83 ++++++++--
>   backends/trace-events                 |   2 +
>   hw/pci/msix.c                         |   2 +-
>   hw/pci/pci.c                          |  13 ++
>   hw/vfio/common.c                      |  91 ++++++++---
>   hw/vfio/container-base.c              |  12 +-
>   hw/vfio/container.c                   | 216 +++++++++++++++++---------
>   hw/vfio/cpr-iommufd.c                 | 172 +++++++++++++++++++++
>   hw/vfio/cpr-legacy.c                  | 277 ++++++++++++++++++++++++++++++++++
>   hw/vfio/cpr.c                         | 176 +++++++++++++++++++--
>   hw/vfio/helpers.c                     |  20 +--
>   hw/vfio/iommufd.c                     | 139 +++++++++++++----
>   hw/vfio/meson.build                   |   4 +-
>   hw/vfio/pci.c                         | 194 ++++++++++++++++++------
>   hw/vfio/pci.h                         |  12 ++
>   hw/vfio/trace-events                  |   1 +
>   hw/virtio/vhost-vdpa.c                |   8 +-
>   include/exec/cpu-common.h             |   1 +
>   include/exec/memory.h                 |   6 +-
>   include/hw/pci/msix.h                 |   1 +
>   include/hw/vfio/vfio-common.h         |  20 ++-
>   include/hw/vfio/vfio-container-base.h |   6 +-
>   include/hw/vfio/vfio-cpr.h            |  69 +++++++++
>   include/migration/cpr.h               |  10 ++
>   include/migration/vmstate.h           |   6 +-
>   include/system/iommufd.h              |   6 +
>   include/system/kvm.h                  |   1 +
>   migration/cpr-transfer.c              |  18 +++
>   migration/cpr.c                       |  92 +++++++++++
>   migration/migration.c                 |   1 +
>   migration/savevm.c                    |   4 +-
>   system/memory.c                       |  19 +--
>   system/physmem.c                      |   5 +
>   35 files changed, 1490 insertions(+), 237 deletions(-)
>   create mode 100644 hw/vfio/cpr-iommufd.c
>   create mode 100644 hw/vfio/cpr-legacy.c
>   create mode 100644 include/hw/vfio/vfio-cpr.h
> 
> base-commit: de278e54aefed143526174335f8286f7437d20be
> 


