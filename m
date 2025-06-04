Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8976C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnyI-0003Hj-9v; Wed, 04 Jun 2025 09:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMnyB-0003HQ-1E
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:15:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMny7-00034G-QG
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:15:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549MfVU010235;
 Wed, 4 Jun 2025 13:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=eNwH2zHf+VbKFH8NUiizhpqO0YfTbrIWxkWsRxzL8Gc=; b=
 FQqnWHo/7d/iQ5htq3+eNq18hq5pYEQVQeE80eUXz8mX/jYzEFyOPrCXV86Cp7fG
 j98OaLIYMBNdCkqxKCUf7QltebKcGP2iCUBuZK/SNeb0CJpij+RPvi2NLODX1nG4
 mtZstWkwj2GBbx4KLSAxHfqgP7yeEIjduIFiLEuDK6Fd0jniBjCjjyD1Vnp3gJtY
 Kc/lVQkjvln+C95F3xp53Cbw8+Aexm19zndNJudNImfCwTM+R44lO6NpDp17GihU
 S2tP8WYWe0TviTffLTJUFca4q9ljjt4paieeYxuWVA0k8BtWCK7wrQAH/x7VdSno
 osJkV50CwAUrB7D5iJV9Yw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8kbymk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Jun 2025 13:15:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 554Ba51O040095; Wed, 4 Jun 2025 13:15:41 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7b07j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Jun 2025 13:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAbAHWlSAyc9DOSgZ+Abg6UXz1M4FpQ1k5eDbZmy5LHaywBWVEP5qoPG2hgZSf7W1RZUAqnglOrE0I8KFEx0B09QHnXqJSHmANpwcCJwPm91PDs6X34M0Yby2oILZ93jrP2pto006UUpcbzaFhdQJv/w/LnudR595Pu7/PpWj+KcOJqMstte2hJiCeHy9yyyJ8nF0nY6RFgcQ/UG1c4h93APcovOEoIIbbOgMI7HmIJ3yGJj5PsDKSwx2jVnwJq0WqlDFR9tTD502nXYbSPeFh3Dgn6uEr+3N3Giz6UXcA8M3MF3Ke7iMGVmExJbWni27Y8MIBHcsr8tZmZ/fW/FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNwH2zHf+VbKFH8NUiizhpqO0YfTbrIWxkWsRxzL8Gc=;
 b=jkRnsCgenVsx9RXzD81EQz2gbiaPvSHNZEgEzb4Dr7/KS09HhdDCnKvrq1GGBJEdjQomdaTExUpA4yDJHRflb9q6vKr6UgtZvqlxf/v8KYAJEx+zi9ecqQbQckhgyVJ6uacNRFtjsD4QIlgawTMm0F19ve++qhLSnWqr80nTiOpHJjYUMqWrMHx7GYelIp5VNAahdF6k++Rj5qIBD0kQLvJkWcOTpbik1OXHcvIVkmgBRYbw+X4TAoW4wUqb/cplqPnmDk+rGD/pS/ikZqNyA+Tf8o/vdarBTuSWqJ3LNbG3jLwuytZJx+LWWtOuxgeiqgBV5OLwTVYHSWRElDgElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNwH2zHf+VbKFH8NUiizhpqO0YfTbrIWxkWsRxzL8Gc=;
 b=CJV+fYhB1Qqbz+ynrOhe/ZItpzTkTaZdo8TmkNRmH9YHDFpb1ns3QEK4roE69hsZ1xXOWfFZswal6bV5EDC7l3CiI4SnAXfoXWgXcbZ81cB8QjJr1k3ENPN5DzmbFQ/owgLiaixK0Rjh+T/sp9pKz8KoL/I8YnfLNszBLLu/eVY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6076.namprd10.prod.outlook.com (2603:10b6:208:3ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 4 Jun
 2025 13:15:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Wed, 4 Jun 2025
 13:15:38 +0000
Message-ID: <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
Date: Wed, 4 Jun 2025 09:15:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
 <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:408:f7::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6f2bab-0489-437e-0572-08dda369e621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1FDMHFNeEFLdUFPeXM2TnI5aWZCaTgvRFh4VXROQjVFS3EvOWY4N3E3Nmxl?=
 =?utf-8?B?dWRrSEdLMXZyUVlQSVlSUGtIclZyS3drcXZjL3dTbThFZE16Vm1VdE9pWWM3?=
 =?utf-8?B?YmMvZHdQQi9mV1hPSG14cndoVExYMWdaRkZvY2Z2b2FrYUZWV0N3Y1Qwc01I?=
 =?utf-8?B?TzVNcnprWGJNUnF3a3BYOWpKbUF6MnNIUDZQaCtoM3VzQis4MzVUUTNuRkVE?=
 =?utf-8?B?UnFlZ0pFU2x2SnFFV2lLZmlmMUVvWkpNK0pHL2ZrKzNtL2E0czNaOWQ2VHEv?=
 =?utf-8?B?U0ZqU3BIYUttTzZvYWxqZ0ZlSzU5dngrN0FKWHBWUFRCV3krOExHY2c0aFdx?=
 =?utf-8?B?R09pT1ZpR0lwMElScEdBMXZ2b0tXemt3dzBKWW5jeWlsdGdTcnoyYjVQdEFv?=
 =?utf-8?B?dkNnR2N5WXVwaFpuMitpKy9ydjFvRHhUNkNWd01xZGV3N3FvT0FHbkptdDhh?=
 =?utf-8?B?UkU1YmFkUEdsUnV6THBCd3AwQkI2Q0l1OEYxcW9vbXlEL0lSNWxXRlFCMDRR?=
 =?utf-8?B?WDNJTGhvTHZWNS9CTEdocHJRZ3czVnhwTDBFUnJ2aEprSFBzN09ZN2hQdlh1?=
 =?utf-8?B?TzVNRHloQit4WFJ5UWlDQnFsWG9adjhseG5kMkJPcnpKWStLYnUwQkNwUHRY?=
 =?utf-8?B?QzlQUnM1TFIwTzBxTTZYbXJ5OW1BcmFXblEvYUJDZUFBMVZPZGl2U0FpYW9O?=
 =?utf-8?B?dWo5NVpiT2VKQVdrMTU0c0VmK2QxOVJnVitFSHBaT2NTSHYyMGFMbTVsdGlV?=
 =?utf-8?B?S1FycTF0bWVTL1gxTGNjN0hEOXZJY2tjZFlweEFvbC9tNFNFNU5pWW45ODF4?=
 =?utf-8?B?TlNHZHAwUkpTZmZ6aTkzY2g2Q2ZiUUc1ZzhzMVNreXdXeVdrMjkrS21MQ1k0?=
 =?utf-8?B?ZEkyYWs0VWV3ejVSckY1VDZ1eHBxWU1CTm9UcHlsbThMdlM1eWdaTW1hY3Fy?=
 =?utf-8?B?dUFtTE9RRUo0b2U3SEtSQnd2WWE1dDlXN2pTUmJqSFoxbmUwbWt4dUptUU5N?=
 =?utf-8?B?cSsxUXg1Q3dPVDZTc1VmNnkzQUxIckg1MUpBU3ZoaDR3cFRIdDgxWHE5Y0Rn?=
 =?utf-8?B?cE9WMnNPWi8ya0t0bVQ2R2h6RCtRVWdlampRTEJlREVjV2tnZzhTc2Irc2Rq?=
 =?utf-8?B?Qmwrb282R1M0Z3cxbVZHUE9TU3NRa3FzWUlQc0VzRFYzNWVPNWFTNVlCb3ZU?=
 =?utf-8?B?YW80bS9Mb2k0QmFlWG94cUJPSmloVEFRY2Q3aFp2Z2xxNXFDQjI4RTFQL2hY?=
 =?utf-8?B?MFozQ3czQzBzdVZ4MTQyd2tId2pTUC9MUDRXdE56Q3dTWk1BVTVYVGhkQVNj?=
 =?utf-8?B?SFV0R0ttOUhmdjUyMC9IczcvTmxycDVPT1JnbEJnTXd0R1R0N3hBejZqOFh0?=
 =?utf-8?B?cXkwY3E5bm5oL01uUmdqOE9Ib3d1YTlKTWh0NENiSkkwVFZNMVFrbEc0cS9T?=
 =?utf-8?B?RmFXQzFIVHlKUXhleTl3eHZPNEFHN1FkWitFejdEWWNvNGFudnA4LytEODNM?=
 =?utf-8?B?UDVMYXVwRVI0S3ZCU25qcFNPbVZWdXFmYW1PRjdjL2lvV3hVMnJPSGpRTkpB?=
 =?utf-8?B?Z3I2MThhSWFCUldRYjM3UlRRREsvalVqb2ZsODFKdkRsQ1dTUHdkNzIwMlJS?=
 =?utf-8?B?NVJsRXhlNm9MUWFXOGNFMnpBVDM4cmtheVNJYnJxOFZ3WHZ4U1NOemRncmsw?=
 =?utf-8?B?ZGJ4RXQ1cUZwTzh3RVBiOVBEODU2Y3c3UlV4LzlJMWFtWTdaRFMxNU15a3Fj?=
 =?utf-8?B?Z21ZMmF3NHI5bjhmMHA1cmsvM1lrM2hMWW9WUm9yWDNNWitiQzJRN3IyWUpV?=
 =?utf-8?B?V3dvK0xRMks1YzJyd0JGbHVXdWZxS0l3SGxlbDMvYXBCUmpaRGhTNmlNWi8y?=
 =?utf-8?B?eEJ2akFsZFVPb2ZPY0Q5cXh6Szk2L015QSt2TzBRZWRtK2RXUG4wdnhMQWxu?=
 =?utf-8?Q?dYa30psFBp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUYzN2lZZHJ6czk4cnBVWUIwSHI0Y2ZORkZlUkZGTWdjc2FDSGlicjA2VzJy?=
 =?utf-8?B?aEIrOE5XYTBYenIvdmt0OGlWTXljemRLa2lEQkdNWEJ0b1AyMUNTck9lT1My?=
 =?utf-8?B?WTBqdjVIUXhNdlpLallrdHhjd0oycDk5NUJZbjBXYmpRUHUvbGxXejA3bVdF?=
 =?utf-8?B?U2NrbE9xaFdGb1cvckRvRUxZWVhTR3E2bm9sQzQ2MkFJUzAxd1hrNDliNW45?=
 =?utf-8?B?TkhwYmhtbVIvd3hHaGpUUVY5WmU5dzFxc0ZrREhYRSt1b1Y5Vk1yZ3lJMW81?=
 =?utf-8?B?dDNVZnRTVGNLR2NvVHFNSW0ya3d0QU9rMkR1c3lPSzlFb1RKZWdtL2I5N0F6?=
 =?utf-8?B?QXlWNUZCUFFOME53a2dURlVnb3dGWWpOMmNsanlCRDg3cHYrZE1vbzBIMFpx?=
 =?utf-8?B?WjAweEwzVXhST3ZFZzNwK0Q0NHFrNGUwaE8vUGZNNmNtc1BIcnBPdC8xNXB0?=
 =?utf-8?B?dWoxcHVlTzRpWXBMQUNVNjdkU3Q2dlZGd2FVSmtjTHEvamdPMm5UNWt6R1FY?=
 =?utf-8?B?SjU5Sm54N25sMCtiSjdrQlF5NjR6UG1IK2Z3SlMxeHpCNUlGaVdndHlYVmo1?=
 =?utf-8?B?WVhVWjBva1BHMUFyTFJDQkpBYTZrOEtLc1ZWaUpqaEc4WTd0UVlLN2dhLytV?=
 =?utf-8?B?YkQ4VXA2NkljQW9WN1p1YzVaM2Y0QXNLOXJ4TUtORU5pYUU5YjMwR1N4WXhX?=
 =?utf-8?B?TDRkZkk5U1hTZ2RLOGpMazZ4NElLVmtUeFowd1lvbWFCQjhPQ2lmbkZnTHUx?=
 =?utf-8?B?OHNjMmM0SUZHZWFCSHhNTXhZVWxESmxGNkgyUXk4M2VQeld6V1lITk0vTXly?=
 =?utf-8?B?OGlEYTNlN01ZQXkrREFSZ2xrbkVJL1ZOZGlja0EycVFyVGdvcXp6RDVSOWxp?=
 =?utf-8?B?T3g3Z1BaTjNNcnpMaDg2Z2IrcmxZY1h2bC9vaVdzTFhoL3huT2RWcFlTMVl1?=
 =?utf-8?B?SlhvQktOclNEc3pwMVdFZU12MmRlZU11c3Q0d3VMZitBTWs5QkRqMlN0b1Zx?=
 =?utf-8?B?aW5UQmdyejQ4ZTJLeGpzZFJaclN4UFRDa2JVS0orTFJzcnZSY3Jka1V6Nmgz?=
 =?utf-8?B?d2hWSWREZlJCaFNDaFlDMDFWODdjdUo3Z3RpMFdoYW1EdUt6YllBTWxlbkY5?=
 =?utf-8?B?RlhKYllRUk1LcmdqaVNpVFJKNTZodmFCaEk4TWR0Z1p2U0hNeHNRaC9yd3pr?=
 =?utf-8?B?QVhDZ1Y4M1NsU3NPYU5KelVaTXNCRHlCR25yTW9ackhESHppUDhoTy9MTjhw?=
 =?utf-8?B?VmY2ZjJqQVJ0anZpalNKVmIxY1dJSGozck1rRk8wU0kxVStXejBHc3FRRjlv?=
 =?utf-8?B?dXQ5YXdnTlJPOUxHc0FhSWtaRW5UOUh1U1ZzRllIRXRUMjlTSXRUSVBPdFFo?=
 =?utf-8?B?dlU4bk9VbTNwcytKdlF4UXNrUStweUNHWU1qdkU0d0p5WTgwT051d3VDNldp?=
 =?utf-8?B?aDlJekFFT1hxVW1BK3gzQ3RaQ0dFV2RoVVBxTmtEeU5CaDVsRWpyaXpnVzVm?=
 =?utf-8?B?cGRUOVFaTDNvMmk0UExuckpIUFZnQkZ4STdEZFlEMDYvSFdXY1dUNHVOWjMw?=
 =?utf-8?B?YlV5SGU3T1FFWFgyZkpIeTVneUNvQWxIZVRNTUZqL2RSY0RyTml5bTNHZ0pw?=
 =?utf-8?B?Vm9mV2dBNDJmRE5xVjB6QXFxK0duNlJpamxkd2kzSUMvS3B1L1Q2MGZiM0s0?=
 =?utf-8?B?RHRTVjI4ZXBCejBHRTF1TTFiNCs5Qmlvd0NCQTkrRk1zYWM2VThyelBxWG9N?=
 =?utf-8?B?bHdZa2hnNWZRTlVLSkp2R2xDZm9QVFhvM1pQZnVWaWR5RkhQa0l1STYwbGJk?=
 =?utf-8?B?WU40bVJyb3pSTnZINElocEZtcWVPNFNZaWtSby9TeFJrUjdNK0l1czlmS1FE?=
 =?utf-8?B?YjJ6Z0dheEp3U1p3NHFLNnY1V1cwSzBMYitMdHZ4RmpmZ0FYc09yYkpzSmRn?=
 =?utf-8?B?aThRSnF5MlYzN2tMbmVLR01hbnEwTDluV3pZWWYyZ0xaNCswNitZOXl0cUd4?=
 =?utf-8?B?OWJJMHdSdDV0RWpRTExhL2dYQy9vTVZyb0dqTVVsK3U5bmlNc3VLWmpnQW5s?=
 =?utf-8?B?VjNuWlpJVXlnMmY3OHNMVmtDcUZ0NjYvS3Q3SWxpSy8rRDJONVdjcElpTld0?=
 =?utf-8?B?U3NyMW0yV202d3F6SnhobnU0RXdvM1Y3YjF2YzJZVTlDdFlrWVlDamIzVnBG?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dXaR1Dq9JXO4jQNMgOj1+BaxbPlZp9C0aX30i1ENj8Kkj5Ow0J/d8j/q5LT0/0J+PjvBBKHTwa8acocA3hrP2m9NCv6FCYCF3Hn3nL5IKxCs+9qHl0/0dS3YeFAfCmhIfXS36IkSovvV3gc2fhxFN9Pr9/FUgvKVjdHBFBx/a870/wJ4r2mKQG/lCoofccAlZOOKL+veAJ0VEzz5+ulIpPWUIvwLFNt/qKSljDhNsYEahCX+YRktYL6GdguqMZUN7W42JjZgB5B3NGoHaMtN21mauTAPRaWGKjfqaVsBPNPuGdwtPPaTfX2Ao7WJmUrXwizyLJqZhvjy+5HHuVVWHUIba2AM6kFU35PiO679DXj5liqoKMDfP/LnBDz1/TXKe35NltBoYA3IpOsVmo5IlI7fNiRealvQdyg6Tu8fqZ2FWQFzFXOmUIrc202BYbUSfYKDcEziZukMNvXvXNALHceDMWgCzvoRV6/lOSMKqSK051m7O5rvfrSVrYTiwD4wm07JprpQ3+5jvsUN8jUOoctBHYi3oL1rmHQb6xgo24l0g45tVvShcLeq6ul7Qu/QSKUtuJTUAPrJIKczpMLbMdF+22/8YkrDGsXBv2nG5/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6f2bab-0489-437e-0572-08dda369e621
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:15:38.5999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUJ3Pwp6csV8iCcLDYHiARvkM/4jOEpWl7L/M69PkCyfEezKPMjv+tdz+Ah01n8kJPbhwiL+HuiIlARRcfHjTWEiGAs5cuVsXHrTBNB4mWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040100
X-Proofpoint-GUID: ZcNaMB6EIIyPRhorMPZDmK2ghgPyuEx-
X-Proofpoint-ORIG-GUID: ZcNaMB6EIIyPRhorMPZDmK2ghgPyuEx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMCBTYWx0ZWRfX9Qwet+4xqe/O
 Yzc4WUcwjticEaJHK7KqvMZsVgJsn/umMC8ZSylG0ZSl0CBsBtqS6KvpUR+ecxrw3TzE1nnro1Q
 tgnq1gm7Ud+NApAS6KSJtJs12Z8f81SomhmIyNgfR9Ly4RzJHFtzKwYGVr82WMmIwE5YVLlP50L
 C68/V4xGHUNmETqMybvs4pfiQmT0pC5bSulupHxOT3eCJBETk1wafQOkwRD81TOR54ziboeJsqL
 2pe7y2gC0+spJdE4eXg39FFLMs16U2kFp91W+VwmUqhO44hWe8DBOdxrYlYmMZgObIfKIaoki35
 w+VpTMMoFeu/9qesI28iaP0wDTUcdAfo/xBP3oIAEAx8VXBDh9HEBRPSBtObgU1pYH90F3NqeuL
 cl8uItDJqznSc/piWlrK3+OKhDpvSkhsmJfVjNJpZr9ka5gg6vBgThbfDzrnZEv9QmHXV2hn
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=684046fe b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=DH7QXOmxiI-7iC7dIEwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 6/4/2025 7:59 AM, Cédric Le Goater wrote:
> On 6/4/25 09:09, Cédric Le Goater wrote:
>> On 6/2/25 14:36, Steven Sistare wrote:
>>> On 6/1/2025 3:07 PM, Michael S. Tsirkin wrote:
>>>> On Sun, Jun 01, 2025 at 06:38:43PM +0200, Cédric Le Goater wrote:
>>>>> On 5/29/25 21:24, Steve Sistare wrote:
>>>>>> Do not reset a vfio-pci device during CPR.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>>    include/hw/pci/pci_device.h | 3 +++
>>>>>>    hw/pci/pci.c                | 5 +++++
>>>>>>    hw/vfio/pci.c               | 7 +++++++
>>>>>>    3 files changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>>>>>> index e41d95b..b481c5d 100644
>>>>>> --- a/include/hw/pci/pci_device.h
>>>>>> +++ b/include/hw/pci/pci_device.h
>>>>>> @@ -181,6 +181,9 @@ struct PCIDevice {
>>>>>>        uint32_t max_bounce_buffer_size;
>>>>>>        char *sriov_pf;
>>>>>> +
>>>>>> +    /* CPR */
>>>>>> +    bool skip_reset_on_cpr;
>>>>>>    };
>>>>>>    static inline int pci_intx(PCIDevice *pci_dev)
>>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>>> index f5ab510..21eb11c 100644
>>>>>> --- a/hw/pci/pci.c
>>>>>> +++ b/hw/pci/pci.c
>>>>>> @@ -32,6 +32,7 @@
>>>>>>    #include "hw/pci/pci_host.h"
>>>>>>    #include "hw/qdev-properties.h"
>>>>>>    #include "hw/qdev-properties-system.h"
>>>>>> +#include "migration/cpr.h"
>>>>>>    #include "migration/qemu-file-types.h"
>>>>>>    #include "migration/vmstate.h"
>>>>>>    #include "net/net.h"
>>>>>> @@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
>>>>>>    static void pci_do_device_reset(PCIDevice *dev)
>>>>>>    {
>>>>>> +    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
>>>>>> +        return;
>>>>>> +    }
>>>>>
>>>>> Since ->skip_reset_on_cpr is only true for vfio-pci devices, it could be
>>>>> replaced by : object_dynamic_cast(OBJECT(dev), "vfio-pci")
>>>>>
>>>>> Thanks,
>>>>>
>>>>> C.
>>>>
>>>> True but I don't really like driver dependent hacks.
>>>> what exactly about vfio makes it survive without this reset?
>>>
>>> The kernel descriptors remain open and all the active kernel PCI state
>>> remains in place.  The device was never quiesced or de-configured in old QEMU.
>>>
>>> The cast is fine with me; it depends on what Michael wants.
>> I don't see any good ways to avoid doing the reset when a cpr resume
>> is in progress. I agree the cast is pretty ugly. We could keep the
>> 'skip_reset_on_cpr' attribute and make it a class attribute instead.

I don't see any advantage to making this a class attribute.  I looked for examples
of using such attributes for vfio to configure pci, and found very little.  It
sounds like overkill since vfio already sets and gets PCIDevice members directly
in many places.

I defined skip_reset_on_cpr based on this existing example:

vfio_instance_init()
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS

> Also,
> 
> I wonder if the resettable interface, and more specifically the
> RESET_TYPE_SNAPSHOT_LOAD type, might be useful. Have you explored
> this alternative ?

RESET_TYPE_SNAPSHOT_LOAD (or a new type such as RESET_TYPE_CPR) would skip
reset for all devices, but we only skip for vfio_pci.  All other devices
(including virtio) save and restore state using standard migration vmstate,
and must call reset.

- Steve


