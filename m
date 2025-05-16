Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B313C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 17:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFyh6-0004PM-Ee; Fri, 16 May 2025 13:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFyh4-0004PC-7f
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:17:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFyh2-00048t-50
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:17:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfuWf007346;
 Fri, 16 May 2025 17:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pwgGexU4FaveilW4PCJCn/dpo05CKShg9TLaBzDxmGE=; b=
 axDdwDSY6IHYJyzoqiacomGkO5YhPdq6hl/QfcWmaE2rmQ98wZuAZcs27+i1AsmN
 z4iVqB010m8SwJ6aeX+ohP+7x0hgFrEdpDcXQLPtP4v0bRYqpNZzwNr84SjRiVGt
 YA8X2WiQqn3pFuOTYOl51caj10aU5SuVyiPLsyXHGmq3iS3YBMsVu7IVUVw9ICbW
 Khv2n58KwffWYHfSKGQ2fODLHPZ6YroykSZkmLk6NgWIwlXMaNpJ6v9zlJgD1pEa
 /83d33mvdk6z9jsdu8g55YyNE5Ya2u6f6BYFppQ5ZDuzYpFK6NS7rvqIxwW1Kyzr
 hm+toyqBbc1T8uwsKrT4nA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbjsv8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:17:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GGJDJw004270; Fri, 16 May 2025 17:17:51 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010007.outbound.protection.outlook.com
 [40.93.20.7])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmfku29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP30sadMTqIBnaWHkwuycMxpEsRIwO4eEDOderuZNRRG9mI9ZDGPXS6a0h/69h584LRAEHXTjfX0serKN9yQ1GL7LDIhV6tzfqdR+v/L7iiVGtZOy49MD7naRZY2oB4/BAqoHe3Dv9GGTykcLAZpTpkxt0OkrSJbZFhORTq5iMtmeRXCxzT/dnxx7IdLIcE6RHuLmmwXPIA4De5HVPc8l+5MuCaM0rSUtQX4ixsRSAI9cJGZwq1SDnN3nkQrYLnQ/Q677el/ZEGvKwaSeeeg8sBXG3NjZKQncKC+Mfs74tE3BlGgiJXy9u9iH38w5RZCdurT0tWVGp63kVC1yRxorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwgGexU4FaveilW4PCJCn/dpo05CKShg9TLaBzDxmGE=;
 b=UiXhngnI9SFNxg1c1YDGQ7sYEk/+YgfZmD2fWVA9xSlYFAVSHwT5PU3YPF5NBFjB/xSO2FzU0kZ2NGPAnu7+Z7WuldyD/ApePBgM/ROPxILyu7Zr9XD7VJpICzMOLZWbtd5xwW8NsQEk4AS15VOr2tDNxWviBhQgYUNa2h/Dz6Neaboq2tf1hItr4Nj9Qne1LrIln6JNxUpfEs/NnCbLnV+hsUpxxmdYkT3m5Uz2GJXlOjzYa+fTK2ExL79ZwFNwjqeGPJn2cHKjeerSXbMmZAacVR1f8VRaesFTCT7wtkhgvsW5Sb2AUNG272fnKdvBHKlCx50HNswXmFBLRXoLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwgGexU4FaveilW4PCJCn/dpo05CKShg9TLaBzDxmGE=;
 b=jk5PKQOQeK1UGRYCSMg42UJx0ErBxBYtxYa/AbT518mlkvHpovGscuab9fQ5Oy6AYp3w7azP0ADCyRFcoVttX7a6S10sG7xYo1W5JSeVKXkg0LR+U6FAKJDWJROB5XejMI4qqARwmy32DoXuS9/DxY1cwGAmW9caLzXQQqZxU7U=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5663.namprd10.prod.outlook.com (2603:10b6:a03:3db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 17:17:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:17:48 +0000
Message-ID: <e13a8672-9c76-4739-89fc-91033b0a031a@oracle.com>
Date: Fri, 16 May 2025 13:17:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/42] Live update: vfio and iommufd
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Levon <john.levon@nutanix.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1ad33986-dac9-4d89-ae54-e2ba31cee748@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1ad33986-dac9-4d89-ae54-e2ba31cee748@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:408:113::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: f6db6a06-ca15-4598-3bd2-08dd949d9478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmJxOU8rVFZPZWZwbXZ4cDQza1NTSnBQcGs5VTNKRllRRkkwN3ZxVUxhNlVX?=
 =?utf-8?B?K1B5eTJ2L09hRnNhNGNEdlFQZUVlSklsTlptRFZMbmtXclBWTmFxMXJyN0pp?=
 =?utf-8?B?WHpZM1dHcVJzK0g4c21lcFdpMjR2UkZyQ29vZTY1dTNlNEpEMFJvbm5kdGFO?=
 =?utf-8?B?ZFhoWmROSjIxSzVZcFJtOGtCQjdUVmpLVUc4N3lpcUZxdnhLV1c4d0NiMmMz?=
 =?utf-8?B?dmRTWTJxTWlScFo1U0RPNDBlVzd6Sk1kVHl1eUx0U0pER2F0am4wYWlyT29J?=
 =?utf-8?B?K2ZTL0EwSU5sZEVUTVkvSEJiMXk5VWJXWnNqSDhkYUdIbmVkV1djSjNPbnE5?=
 =?utf-8?B?c1JTQ1BIM2I5NWxIZkNOOXhXTkV2RzNYZHQ0RU9sOTdibVRUMEo2M3FCcVAx?=
 =?utf-8?B?eWlqK0pTVmZhRGNTSDBjTElPdGJHQWZGblZXand1M0NBZkVUMUxqSW1jcGxo?=
 =?utf-8?B?WC9VK2VoQTd1NVVHdUg5V1g3NmxlblpWUE9paUZWeHRsWlJNZ0tSMEQxQ08r?=
 =?utf-8?B?SjZUVTIxZVdtWFRZbkFLaW1GR3J5SjFVQVFUdkNpaTl4cFl0ZzZVK2s4U3Bu?=
 =?utf-8?B?RFhUQlBRN01uYlBNQTlyYXZWR1M2cWVRaU5oelI1eW80NktVUXBCRHJ5M3hL?=
 =?utf-8?B?emNQaFFER0pVUG8zb3Bzb2ZTSmhDRjFxTXQvZFp0RmRFTDFRbSttd1UyZDd5?=
 =?utf-8?B?MStGODgrWkcweUVqTVZYL1dGbTIxRmgwbGxreDhham1NOXVCbExKdFhORVRt?=
 =?utf-8?B?UVoxblpJSmtaTy8wa1NGQXE5a2I2UTgxZ01FenZjU0swcVNxYmgwWjZpczQ2?=
 =?utf-8?B?WkJMaVNqaUdnZTBJWGM4OXFuOWFRL2toaFQyMGt0Qm9FcjJsMG9QT1lKa2Nu?=
 =?utf-8?B?ekxLdWpjcFNkWEw0RmlKeE1NL250MVd1aHlCNjh1TTBINU54UERzdUhZQjQw?=
 =?utf-8?B?Ky90OStZUTh2L3lndWNoWi8zbHhrdW4vTVd0c2thSVNRWGFzdGFhbDY4SGNo?=
 =?utf-8?B?K3dTK1lRK0dscWlnd2xLVjZRa2tCRXMvTlYyVlRzMG5Bb3JxcUpOeDNjMW9N?=
 =?utf-8?B?L2RoN3VzRExjcTBZMGYyZWNyY3FzVGRYY2UvbHFUUDYxTmRCbGpSMHNQNjhD?=
 =?utf-8?B?SFpmKzQrL3VsY1lTUU1JaXVNRUs0Rk1WQldNQWpLa2c4K1ROUXFENEUvRldm?=
 =?utf-8?B?SlEzSlhLZEZJeEJObmtybDVhT1hpKzMrZjE4WEJLY24yUDdTdzFQT0V1QVph?=
 =?utf-8?B?S3B1Y3J3eWRMSk44dkovRGloYmw2U1h1T3VHdUx3U3R3UDFaMlF2WVJaaWsr?=
 =?utf-8?B?TnZNVjE1Z3BmSW5FRTdxRmxBWWVQZTRzYVEzc3I4MG1UaFNuWEVIYk42UWNy?=
 =?utf-8?B?UFlzSmw2dm40QkhaV3lRRWh6VElxRHR3WW5yME1MZTA4aG9xR1dlUERobDVZ?=
 =?utf-8?B?cHlZSmNSR3JkVGtOd0Vnczgweit6dW1tcFlyRFE4ZzNBNjVEUU5Ua2NuKzhw?=
 =?utf-8?B?TDRjS3FlZ3ZGaEdWLy9kcjk5eVlYaWdWMFFidmZkK1F6eUdWczhVZ0FXbXRH?=
 =?utf-8?B?RnVpSGJLcTZ6dnh1OEJlWHdEaVJESmw2MzVIN0tNRW93MjV1Uzh5aFlvRTJW?=
 =?utf-8?B?WGJhMTMzL0VudDNUN3dTa2tMWnp2ZTlkQ2dpcEtMY0VoeFBEOGdlWXdJTjVn?=
 =?utf-8?B?dm05ODlWU3dnL2JvZjNHVysva3hBd25Iekl0bk9oSk01RzFTajFFNzJGUUNJ?=
 =?utf-8?B?TU1GTFlkNVBPbExJNVZYZ3JaSllZNkpoUExUVHVPT3dham5OWE1rY1hXT3VD?=
 =?utf-8?B?Q2o2dUh5S3FsK05QRno2ME1WU3MvYmZrbGxQbHcvTHFBVDJQc3RoQytBWXRO?=
 =?utf-8?B?Qm44bGtsdW53cVNWb3V1Z2RTYno1MTBjTEVXQzVTSm9EcWVQRUlkWkd3dlQz?=
 =?utf-8?Q?jhqMxWhgXOM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNOM1ZVTEFnTW83aUFIMDhyVzlKQzNUTUpjQ1F4a2dSSXJoZGN4SEdIUDVI?=
 =?utf-8?B?S0tiMGtwdXhXRjZyeXFHK3VSNytqWnNIQmhNekE3TXFjcXdDRVVIOGRyVUNU?=
 =?utf-8?B?OWx0VzRFVHlDK0ZsTGQrK28wR1lyc1ZSMVpDbkNzTUJpTTFVdklCcklEcTh2?=
 =?utf-8?B?eklZdzNpb05LaENoMkt5M0pvWnZzYkZtWFJORTRoWlJ1dFNzK2l1eGZkWTU5?=
 =?utf-8?B?SVVwVHUwR2tJRmZtUHZTVlk4WG0ya3ljc0F1dEJvZ0pCM1lrWE9taWVFV3FZ?=
 =?utf-8?B?dTdlVUp2SU9MYUJWSHpKK3p1NzBiU0VDU1ZuVmx4dzh0VUFQY21YK1pKN01y?=
 =?utf-8?B?b3F6bW9HYlZZVG9YQ2hPS1Q0WklpSDFxUEtRUTNLSndZU2k4RElNcU5KcnNS?=
 =?utf-8?B?ZW1JNXR0VHdJWEo0RVFUK0pXVC9CaWRzSUFOeWl6TE9Hc0VEb0d2NDFsMzVq?=
 =?utf-8?B?VUE2WW5xTlR6WjRGaHRvQ3F6M2RsMndoZ0NtMjR0UGJPMXdWRnhYaTl3OCtv?=
 =?utf-8?B?dkEwVjNKMnFiUFA3LzJPeVl3c2laaEZXZDgwTENXV1lpTDRqZUluZFhENVVX?=
 =?utf-8?B?eFR6UFF1TDZoR0FPbkZ6NlBjMGtnM3AyVm5rcEVmZlcvaWVxQnV3Q08rMUZR?=
 =?utf-8?B?SE9jWGM5S3doTEpVWHp5ZDIxYmpEOU81clVOSWo3THZHYnpLQWZhMExDMUwx?=
 =?utf-8?B?VmV4SmlDWDFZRGlxRy90aGFRcndCOTlLeWRwa2RUSUxaV2VTWElVZU11VG4z?=
 =?utf-8?B?RExwUXRRSWozSnpsbWVvMFNteURTUURJZmJuZnc3dFZ3d0hvMTJhWHhNUXZJ?=
 =?utf-8?B?YUJtMXdEZnRXQmZpSExKRHpGM3NObmtWWFVqSVNKOWhram9MZjRURDFTanQ4?=
 =?utf-8?B?RlJDc0lZMVNnYmdYVytQMzU0UUZvS2FhbmMvRGpveTd6RzhocCt1Zjg1RExD?=
 =?utf-8?B?WGZzbTYzWHZjcVBSU0J3L250b1NrNU5pZjdzcFFHUklJdWdlSStEWnZBUlRx?=
 =?utf-8?B?eHl1SzNiV0J0anY5RGt3RlFiR3YvaTE1S1RtTUE4WklQRkcxeStPQ29Raysy?=
 =?utf-8?B?WGRoZjRiTExCVktQTzFWM2xQNUJSWkRLQ0I1Z2UyZXdlbDUvcklja2RjMWRM?=
 =?utf-8?B?L3BHZ1ZrdUlQUWQzQzdmVlZ4MG9DK1dJd0FQL2pGY1hYQlJIWkVpU0FaY0Ft?=
 =?utf-8?B?ZndCM3psL2tRdHR1bXF3b1g5QnZEUlNDdmxQdkhRa1lTWEpCUFRNT2VpaitW?=
 =?utf-8?B?OXBwaVdUeitnRGdNcnd6MXVUdEZNY1c2WGRwYzNkTTdGUHF6WGdjcWhrRXlW?=
 =?utf-8?B?citObXEzdjU2dVQzRW4wWm5kSS9GRDUzRHQ4Sko2V3I3MXBSNFdodTlYeGpi?=
 =?utf-8?B?NTZwOGt4blNiY2RZR1pOZ0xhQVBlZENBRFFoZUNmaENSTmVaRGdxREFwSDVB?=
 =?utf-8?B?MEJ5NzFuYndodDduY0ZxZjlOV2d5S1FtdFhWL21KMHFzRTZ5OWNjTU8xMUlP?=
 =?utf-8?B?NW5IWE1KWWplcVNLQ004a0xZZjZBbktYaEhsaXpyL0k5MWRzNHh4NmJwNTFo?=
 =?utf-8?B?cGt4OUlEai93ZTRGbzJZbG9nZWFkeVRvUnhmRkJJbTJsbTdTWTRJK0tBakdN?=
 =?utf-8?B?blJUSDBRQXU5M1c3RmU4Vk5uN1FScmFCVXlnakZjTXAzUE5aU2ZlSU9oc1M1?=
 =?utf-8?B?RGd0Z1kvcitZUWhjdUcxZ3hsQWJqKzc4RTNoM2JQeUpyVkFCR0RvcmIwbzJv?=
 =?utf-8?B?YllUYXIwampLQ0RvdnFxby9vNFBDRStCQjJzUXh5b2liRWFUcWI1SkhjbEhF?=
 =?utf-8?B?dkFoWWdPdCtsTTd6ZzZTNE5lOUVseGQ2WWtJdEYrQXVEY2RPVGJpaGx2eTNr?=
 =?utf-8?B?N3lySERLOHJCd01FQzR1MGFHVDhzWGxYMURiNzlsWjVtZVpoRXgrd2x6ckMy?=
 =?utf-8?B?NE81RVh5VG0wVTJkaDExSlZlWjhCZ3JMaG5qUVhTM0ZzVXJEaHpYcU9rMDVL?=
 =?utf-8?B?b3loQ01DNjhHaFA4QURwaXVNQ25DUTc3Zk5TR1NKYVRqY1ZOOENNVTE2S0E3?=
 =?utf-8?B?dTgrc2tva2IybCs2WGpRZ1dzdnRQZkN1RnRzSW9pdEZVRUlzSDk4aW9LQTly?=
 =?utf-8?B?ZkdpbWRPZ3RhYnNSWTVXZFAxTkw0bFlXcWZFdnhsRysrT3Vqa1J2SEVBM0lF?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PykzKN+O1DYmFZJfQuGuX/ZFMzGPm68qfl0616N6kuUsuq1/rHS4ODY67EoSdDhZGFro3fFQjiL/zoqKFaIjPbun+oz7iN8dvcOCBhfoLbi77NIRIvA3YRDcCH98l/yperfTEuZwXScx+ggLLAueakH1G/IrZYpzbyRSYZUlyHKd5Rwk8wWshsGD77m/pzmQELWHPKaG2/eHeYEYeBOdNE/bF8+oPmKECWO50TrnE8LWwfzu0qDpXAC/6IbM4Sn4TdXt5vU5s54AMQhS4TzUGfoU9Fzfy2iKCm9bI7QB/2ZaCeTkl+TANOTCfgBiinORM1hI6j6X4veLWZkZmxK7EJOshJ/OF07MwhCr6wFaMpAPrMccSOS8/uUFGdX4lcDmR+g9J1hs8iPunX3t1g/MqrQOFTzlMOpOHNmcfFvuEm0O46qzlqInONe7DFccxeFTm+4rmoXJDYfIYgvFPXlAOxNBpdmajj+XBqo3d2blv5m7NDChhhTrWZC1795+nqtP2N3+FaKKE5QNMLtu90ZUtoQxzFtdVeCH/e+TUam+MrYjdKBb3YL2PISQCd31IK8ivQJ/7LWvLS4GMRPiZLNorLG5SQ3y/KbXwmER2JcgdkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6db6a06-ca15-4598-3bd2-08dd949d9478
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:17:47.9920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKqGZqrCYM8N523VBy53msP8hMdS29r1kue05hXmDTCR2VUdt2/cVm7tAA5FYXuLxmE4w+ulAWAgmH7ypQQzMZWCywKm5iD79sbUTOUo/RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160168
X-Proofpoint-ORIG-GUID: D-O9GAUDRuSreWv43iuCA13GS46gltlH
X-Proofpoint-GUID: D-O9GAUDRuSreWv43iuCA13GS46gltlH
X-Authority-Analysis: v=2.4 cv=aYxhnQot c=1 sm=1 tr=0 ts=68277340 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=vS6kf18766ogJBKHdYEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE2OSBTYWx0ZWRfX8Rjp3FI/wcrE
 VeFdbpZUMi/tJndbNpxclPx8jJvQ+P6g2rkPGZqepuA/CMcQfnzGARJs/9gWieqNRKDnCu1b3W9
 yY30XJStoA+fDMa2N/8+iZBBsaTgKOkdMhWnLbe9/YGEhCA9RQYmEQd8QRkA66bnnR6HCaxTfOu
 OMertNt0uanz35HHvI6JzYT5l2vykRrjQkBIWd36HC62klMXH2nANOIiYjAUj+veuaOKpqUyHjN
 6gw8OOWQM3knrCMLnd+cBpbZvdxHLDHyuchOMHLywhlq2JAXpcntBbHJ0jyzF96N0dzAK4faI3o
 zugEjh+RBURJ3rnZk3XUoC4jfWlul9KC2s2Ik+TVXwwXALhTlUt5fgQS0bWJOchvh8GJrN/1VGd
 Ur+d7zJ9VxtO2OMLlvCn2qKYRCTRtFVCGVNQhghU5cepevt8kpUwujLW4vrS2kcrxeSiV1yy
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

On 5/16/2025 12:37 PM, Cédric Le Goater wrote:
> Steve,
> 
> + John
> 
> On 5/12/25 17:32, Steve Sistare wrote:
>> Support vfio and iommufd devices with the cpr-transfer live migration mode.
>> Devices that do not support live migration can still support cpr-transfer,
>> allowing live update to a new version of QEMU on the same host, with no loss
>> of guest connectivity.
>>
>> No user-visible interfaces are added.
>>
>> For legacy containers:
>>
>> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
>> skip the ioctls that configure the device, because it is already configured.
>>
>> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
>> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
>> QEMU and update the locked memory accounting.  The physical pages remain
>> pinned, because the descriptor of the device that locked them remains open,
>> so DMA to those pages continues without interruption.  Mediated devices are
>> not supported, however, because they require the VA to always be valid, and
>> there is a brief window where no VA is registered.
>>
>> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
>> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
>> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
>> data structures, and attaches the interrupts to the new KVM instance.  This
>> logic also applies to iommufd containers.
>>
>> For iommufd containers:
>>
>> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
>> backed by a file (including a memfd), so DMA mappings do not depend on VA,
>> which can differ after live update.  This allows mediated devices to be
>> supported.
>>
>> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
>> QEMU, during vfio_realize, skip the ioctls that configure the device, because
>> it is already configured.
>>
>> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
>> locked memory accounting.
>>
>> Patches 4 to 12 are specific to legacy containers.
>> Patches 25 to 41 are specific to iommufd containers.
> 
> For v4, could you please send a first "part I" with patches [1-20] ?
> I think these are reviewed, or nearly, and could be merged quickly.
> Even if the "Live update: vfio and iommufd" series is not fully
> reviewed yet, there are good signs that it will before the end of
> the QEMU 10.1 cycle. The same applies to vfio-user.
> 
> We need to bring together the proposals changing memory_get_xlat_addr().
> It's important as it is blocking both the vfio-user series and yours.
> This can be done in parallel.
> 
> Then we can address the iommufd part.

OK.  I was already preparing memory_get_xlat_addr when I received your email.

- Steve


