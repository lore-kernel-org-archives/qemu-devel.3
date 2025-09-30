Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CC1CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 18:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3f1M-0003CT-8E; Tue, 30 Sep 2025 14:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3f1I-0003Bz-6n
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:24:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3f1E-0001UO-IA
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:24:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UHxfHq009290;
 Tue, 30 Sep 2025 18:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ETDCXNpqltytznDsvO8tDTxtxKFDmu01rKe6xzg6sC4=; b=
 gW3lWhw3UZ3wZusPM1XYUqeaTlQa0vjtZFOPNNEOc5jbm2zOcxkOQ3H/mLQXyBd3
 g2xlhwI4RiLj0BtStwE5ooPvoVnDjnk2qHPDZKSSvhI9n4CjPSZMtkfgyPMNpLk+
 39J6fKgMVALXmvx9jNB2XePNRyq2OG57O8fefjbkPpCXg4At7BlE/QuRvji0K04U
 vu/XHzzMPaTkjbtsfPS2MNVmFF6i4FmFfNpqFNFahQFfktU+xL1A16h6O/UhHcrA
 6HmjmkCzlJfYoAJDhzLMJOPFK/pyGTUcQTf3B42/8rjnCVIXdVLdTx0WAviJXIqI
 Y6pN7HNPW5bma8uOpRlpXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bg238-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 18:24:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UH924E001920; Tue, 30 Sep 2025 18:23:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6cerb7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 18:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBeIKqmE7qPUdXfg7LD+IiJy2CsidhO8L1tt3LDV1XGISPNt+q3nJMdrMJXudANTP5fx03c6WSj3C/o4EaZrxWjWe2Jab8E96ybXzeGiUcCZKgW//n1QwHTv8XUedNwaCVmOrhz+uQiqIrPnk7mmxmR4dWAuQVhceHojMePkJY7vaoj5VQ8Vd72z1uP1w6JqtC1SuM0UZMccDPbJ/AeDc5XZuf96zyGjLOXkHynZXdgJZpkzm5wLOsxAQLs+9UvqrlZr4c17ooYfD5pOb7GvoKLXChZgs8kzFQTDQyWNs+YEfhEOTJYHMu/whRg3DlDZx43ffNqLPeUHQb2JomiHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETDCXNpqltytznDsvO8tDTxtxKFDmu01rKe6xzg6sC4=;
 b=OFR6keYrTISOmPKEgq2s8eYrsmEo3CyPEU8woF6Zw75B8Hy0NtpXL9jrxLrpIVMeu21Iv39xlnwpQ8FqPZKYRlUQjPuQmW4HT6SwNbimIUoM82ISkBhLC5Pkv/PaBz0xjsxLGgV2MZJWnH5YnvFeeUtogQic3CGN18iOt+VdtQpdLdbGkOH+x4jk1Y7h27PPriMXb4nKC9q7GZ4z13i/ZZ2gKsI8pR/e6Q1d8CJKDa0J5GuIkLT5XkiqylkBGHPLDUYCNObRFzRFw7btOjcrdasv472sqmuALTSE7grbBKOF+Wtifm+QpbxIXjdh/C7pJIHo7AjKo1ApXShixsq8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETDCXNpqltytznDsvO8tDTxtxKFDmu01rKe6xzg6sC4=;
 b=jps6TGvvwieefcObNJ2LWM+td61HgqFgDOT1niBTwio9Q1him7rrLSJy1DXlCHu3Yj+hJjC+2ilFDhiXXhr08JzSNA/DlyHKPzlTYVLJXn95wgVs/OmemKI1CBwJ8vJfXcAII9acFIhp8JD/Y6w2SNdRQ26i8XI2y0ncUrWGq2w=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 18:23:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 18:23:53 +0000
Message-ID: <c9a32330-56f7-4940-bdd4-9c87f24a0a2e@oracle.com>
Date: Tue, 30 Sep 2025 14:23:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 11/11] migration-test: test cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-12-git-send-email-steven.sistare@oracle.com>
 <aNwOeCkXZpPtmPTF@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwOeCkXZpPtmPTF@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:510:e::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d4936a-ad45-4d0b-faf8-08de004e82a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEpHbE82ZU5zUEs1UUh4K2ZJK3BhQ3dXUE9iOGZEQ3lWSEtHMUNlUGZ2NzFW?=
 =?utf-8?B?K0lvMi9lWHFQVlIxVThOWnczMWdLazBoSlNYY2xidmxEY1d5UHAydXRLZU9I?=
 =?utf-8?B?c0NWcTJBd1pTSFZpWlBQeU9ESXBaclpGUGZJMUpnOUFxQTVFbml6ZDhzbWlW?=
 =?utf-8?B?b2hXVEtEdjZ2OGRFcmZicFBVUWxKNHVBYXFrdFFHQXNvR0lHb0pYd0RWNkYy?=
 =?utf-8?B?dFVNYXc1RVQ1YkRVUzFxc0lSZ0V4SHNLUXBoVDdXOEcrZFIwR1ordGVhZHZn?=
 =?utf-8?B?UDg4OE54b0hRR3lpUFhjQkZTZ1pudjVOK3Zva2wza2xZRjR3OHhJZS9VeGFH?=
 =?utf-8?B?ZktlOU9RbXdHZXhKa2dJRVNndjEyM25FY21WaWkxdWlqaTJGVXRuK1ZLZWhh?=
 =?utf-8?B?N1RQczRJcGVlbTZoaVVpYmg2SDZQa29ZZTZGL3pSek1rVVZweFh1Q3NmYW45?=
 =?utf-8?B?M3hDQlVtS3BtZmtpSW5JMlJRQXJaZ2RoWmM0OUF1b0J3VFh6cDJXSFdnVnBp?=
 =?utf-8?B?MzUyNHZmdjFveC9IK0R0SFppRmE5SlYxK2NBZGpTM29TRDRwYTF6clFXM1hX?=
 =?utf-8?B?WWl6T3Y2OEVSK2lTQWQvaTFOV211L25KVExvZUpwbXBuc2NxOVdWQkxQcW4x?=
 =?utf-8?B?b2VWeVdTWjE3ejA4QTdqcnBETkF6eFRNL0xwNy9DTjFDS0pML0tXMEhIeENz?=
 =?utf-8?B?MlBZK2pFazdPOWV0ekMwNDIvMHEwTnJxUG5haWpDeElIU2N3S3RnSGZOWFZT?=
 =?utf-8?B?dHRsQzg2Sy9zV2hwWE1SL2NPNmREcHhhZHY3ekhTSTVxY3pQZlFKOXdXbTVs?=
 =?utf-8?B?UzF6Vmg0TUxJWEZuekxRSmtIaXkxU0haa0FseWM3dDNiUTV2UGR0KzhVMlMw?=
 =?utf-8?B?M0JwQjRFUHlsTmNBQ2Z4cGljdzd4SnlheG9sd1c5U2t6Z3djTi9nY2lCL1V0?=
 =?utf-8?B?ak1UK0x5bWhaUTNodEpHZk8xZDZQUkRTQ0ltV3dIOWZXYnRsOFA2Nm1HcGFC?=
 =?utf-8?B?WjAycGNEQ0RFUlBLc3BKQ3hDWTJoeUVPVUZpYXJsS1hDeHBmMWJpak9rQWd3?=
 =?utf-8?B?RldBTDcxTWhDQms1SFdENDFySFZXcTFMOHMxRjZMbDduNU1lT24vR2ZtenBt?=
 =?utf-8?B?bGZRSFpaZlFPVWdGQi9raTNHSHkyL0M3Z3plRGZzWnlJcHpxemNsbjlDOEJn?=
 =?utf-8?B?Q3NLZjViYlZvZ2oyNm5oM0xOY3hnV1QzMzhtZWVXL1hRRmQzbGYzTzRwc3Ra?=
 =?utf-8?B?aE1zaDdMNENVaUp5OUpFc3RYeFRmUTFDZ2VycjNCakxPQ2o2UW8yaGFGbVow?=
 =?utf-8?B?UU5hbENJVStTdnRxeFNXdUdlRTAzdjdaamtiZWFsNU1IMk9XTzFLQmxabG5k?=
 =?utf-8?B?a3dFQkJiOG96T0V0SUk5ZnAwL0JZQ2E0Q2RTUEduM1pOaCtRUzl3TkUyMFhI?=
 =?utf-8?B?VVdxNUlTdEUzQVFKcHFkajYzY2h0VW1scis2Sk8wVnpqWEtWeVBqMjhRZnVL?=
 =?utf-8?B?RkxZQkV4aTFvTGFVZjRNN2V0VU1vRHZwYVNscERxM3k2UWdYZnFYY3dzbzRB?=
 =?utf-8?B?ckRpMzJFSmJVTmVtT1daQ1diamcvbm5UaFdGMTBIZ1VaMitMMXJTNlBiRjUr?=
 =?utf-8?B?cFFkMUt1SXJKNmp0MXVTaHRIUzhjVnBXcnM0UWdKcFdVRmtyN0dlL3VKcDYx?=
 =?utf-8?B?NWczaE45SklHamNySTg4elhNSFJScUJGVUF6eGN4UXBCc0ZlWFV4Mm9GSGlP?=
 =?utf-8?B?WTNEYTZyRGNHNUJwVTR1SVQ2T3ZYMzkvV1Y4WGNwOEFHNW0xaC9CS2VqT1N0?=
 =?utf-8?B?WXpQMG5qbit1VDdYd2duY29RbElnaGlOQUQxTUhFNkZzV3Y5SEQvOHhLQjhD?=
 =?utf-8?B?OWRhdStQdnByMzdKNDdLVWFxcHFhWmVYMUNubXBOMUQ5TGJzSTdMSEVTTVpo?=
 =?utf-8?Q?xmQojCDXmAIAEUsWMsHUQIILsRXn07eO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MStSODA3SFBmWS9sQTdNYTVFQm9SUkwzYUdYUTlWMk5HdmZUTDRtaEl4MW5O?=
 =?utf-8?B?ZUxTSjZiQS9ScFM1N0o1d25uWVkvMUZFb29lNERaZ3Z5WnNaRWFVZDNDc1Fv?=
 =?utf-8?B?TnJUbVhxeE5xWVZMQnJQUE81bFZieDJEa3dmYTVsME1DcS9PRDBkODVKTENC?=
 =?utf-8?B?UDNxQ3Y1eXdDYlI4TXQrb1dqMFZObkROdDhOdEpjWlNBcjc5by9Ia1Z6TjU4?=
 =?utf-8?B?WWtjU3puenFYa0J3RXlxaGRQcng5WDkxdTF1d2dhbE4vSTRuTWdIbUpibGpK?=
 =?utf-8?B?NVpJQkM0cHV2NUF2b2UyN09uamhSRzRRUlRMTnZIQzREc3B2bW96WjJ0Yndq?=
 =?utf-8?B?OG1mM1IzeGFWZjNNMDZRRm8zd25rdFE0QVNGYW14bmNkc2dJRFRlTElFVEFn?=
 =?utf-8?B?RnZnUlJPZnFzc3lzU0JxeXlYTTZvN3FrQyszVU9aL0t6UndhOUVIRWVqZER6?=
 =?utf-8?B?TXdEUTFnQUtaTHVlTHdVVE1wQzYxOHk5MEhYQjdidTFwdThnd251cmNTMFQ5?=
 =?utf-8?B?Y3poVEVTdFMxa1FBUVBvRHVkOU5Eak9EN3FOSlk0eHRnT2hQUVdzdUZ5VjYy?=
 =?utf-8?B?VUx4d3RvYUlIUnFnYkRmS05Pc3R4Qmo3UEZkYThRR0t4cWUyNDBLV3VpNmlJ?=
 =?utf-8?B?T1JPeVR1TlhJUGlVS3c2OVhpYVVzODB3dzNiMW4rTHgvNHRmTXkwTTc1ajlo?=
 =?utf-8?B?WkZhMm5iQzNwZ3BrajBUS01ubmc0YmpkYlZIdXVXTjdLZXN0MTVkeVlPSWV0?=
 =?utf-8?B?c0xPMzZQM0lkd01DTGNRaVZ3S3BTN25VL2M5WVNxTEJvN0NHd25HS0g0L3Ro?=
 =?utf-8?B?RW9LY2hYWFR4RnZoVlJKb1l0K0R4aXNmSmJFRmlMM2srMzlGRTgrY0svWit2?=
 =?utf-8?B?UWJXZDVydGUra2NwVkgvd1lVaEZNQmJHaksrdlp4VVJrdlkyTGU4cHlrRmRD?=
 =?utf-8?B?NTlibkoyRHJIS0lPK2oyUkFJU1dBOHQvamIvTjNaaXNhMnJBRDVIbUhESjBo?=
 =?utf-8?B?TzBhQ1dkYlFZaFdnRWtZSlA5dXpScC9EMjVaSWpNcDZWVjliSkhLaWZzaGhD?=
 =?utf-8?B?Z2k3R1NzN1hGMzFySmd2YmNnRUpsbWJHMDgvbERZOURUWkRKVnc2MVV2TndW?=
 =?utf-8?B?UElKanRWaHRiczkraTVUZ0pDcmduTUJEQ1VkOHFOM3lYRk5ONjBETmllRG9M?=
 =?utf-8?B?bEFNdHFEYVFJMVhOYTl5SkFQS1M5Q2k1TGQ2RlBmcElrYzFBSHNVWTl2WHJj?=
 =?utf-8?B?blUyWVI5ckpVN1B4S3hWc1RtQWJhSW4xUGlDaTJHRlg2RktRU3JnMG1DQ2pl?=
 =?utf-8?B?NkxqV2NSK0p5NU5RRHVDNUZsRHpuWGc0R1JQNnhMNnFyRHJLaXd5a1ltcFVt?=
 =?utf-8?B?SndxZXFpUC84eFQydEVLSTFJK0ZLeUtBUXFlc1A0MERNQ1FMbVF2d05PL3Vm?=
 =?utf-8?B?QzNJbzFNVkZKd005VWUyMnp2N2srM2d3MnlCZVpzQ2s0cEJtUGh5M2JVdGNS?=
 =?utf-8?B?K0dsS1BYYlVTYjdDUFBBUHR3NnhCTWM1R1gwVSsyZmxYWHBWM1c4SXhkeGxG?=
 =?utf-8?B?aXh5MHp1SXkwbHBIeE11cWc3VWR5QUFkbWNiL2Q0Q2QrZTYxS0xONDhtelVG?=
 =?utf-8?B?QTNjV3phZElITlhOTS9PTjVZd2tQcGFydDdVRWMyNHFaQk1PaFUvdGUzdUhl?=
 =?utf-8?B?aTZuL2xlVjhESWlFVzcvWlJxWWVPNnV0ZUh4NFRPaEFiRTZHNVpJV3N5SVhz?=
 =?utf-8?B?QnFUMDk3UnlUZkt5Uy80THlDVXl6ODJRMkUrV3Y3d28zVEY1QlYzaDR1aE9X?=
 =?utf-8?B?RTMzc1R1blVEaitJVS9XUjUvTmU2em9qNzJnY0dXbFFYcXlhMUdPeXlGd3dE?=
 =?utf-8?B?ZTVacjRWTlcwSFZ2Yld5SVprUWpzOUhzNXNKVkZYOWtrR2I2Q3dYbkEwTmty?=
 =?utf-8?B?RjJ2ZmZraE1hNFpKOS81NVgySVRiK01sckJxYnRHbWlFVEJQOENTQWlKcWkr?=
 =?utf-8?B?WlZxVmQzU2lwaWxjQzlaZk5YWmdOajkyMFk5RXA2U2lxUCtVMlBEK3dGT2Y1?=
 =?utf-8?B?Y0lXa3F1SCtYNXdCOVJnaVBpVGJERzVhYnFyaDBrSG1UWUpUTlo4bzU5V0ZM?=
 =?utf-8?B?cGtOOGFPM2lBRDM3K2VXSFNJRHRxL3ZwZHFVenFGMUZQelF3UTA5azYvNE95?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s2kaFbECzuzu625VsPGt1Y3fsgDVpLvuI7NaUNmQ5055VHEt9wMaxswI7CrWAf9Nh2hcAJaEY/9GkHpwELTBtu1ZlKnEM8QJMbcSiElWFgCQyPUBBLYz3Aq6U92tFXQ/kuO9hXw5jtcQQsn49tK2LWtyG2GiN3zWwLDNRB+FXc2Sino135t++/eU9mg73+O+3Xic/dFJr33/H3d8awaVaLpsbOIcje2kffXLJa+by6AYGn166ALbJePbDYvhSCHTaiaowAPA1HmMmm64GIRUXDSuLjUCgXf7ZrSWQuhN388y76f4BO/IyeJhgLH1d+jCIkxujy6JOigBSe5NsM2f7mnYBMi5m0rDTIpAqtQKl/6RQesjjkoh4kpd20XzJPvYqVVbYjLdu6AdvXVT5mEbo93W3GGwfci2+na1XpLhTxH8bKo5XrutkwZfNWJsgKLY30p+H/lTL181TLrrNYXBQ713E4eRkJWJS9tpdHjlNUvra4JW+voeanO1UA+POmxMLTUBBR3uOSh3Od0QyCbJW+oJQ76HZ0RNJBM0DL5q5NfdVCAy1dPYFNWpNFuhpNOH2Ow7mYxq3oKJ+jq8KYSb9MYqrtG97cvtNqbu1rRM+us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d4936a-ad45-4d0b-faf8-08de004e82a7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 18:23:53.4723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xDCLH/04NPbWKkjaL6QTFAMGzsHxCgpChCFE8XCqkwV5IsLxiz8x6k7r8Zcg2RLhMydl039sRqXfc8nFmIrVg/6MG1kpCu8e1Di6HRzP48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300166
X-Proofpoint-GUID: fZ_4sDwvInRBaqYyFbshS1SgqgD_tT8b
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dc2041 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PISXQa-4vqkp_--6FNsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX6/rLPLO3Drp8
 LRGOwVm4b3i9RfL6TYXJeolvFrQyzVLl8+SR+bH3VEykVIQgcC8o2VAY2oPTk4KW6zKthcdxDiz
 Abb8zCKVE4jQrwrnrSAa4OzHO6u7e9tAB82utZsEGOJD08GbZt9PT1KQ37+r7g5uG0yNdET30Ae
 7fSXg6Q1ogu3L4VopHWeLzzYWmvJn9a1IUZwHWLbd4Nlk6eZaJQT7LKV8OqjcVyMZOjbkvKOJMW
 269IaN3gzT88FOU0SDDLKF5dRmNtY82f1aMwUsZ/a2RKgFuTzIur1qEsKR/slcSLO26ZQAaQgnA
 3ZAHOS1F2VhiDBQY6XRNzcOTMerRzdbQyk7Y/bz3uuss9WGNks3s33RHxQ4lErAaMuMz0j6gHKA
 qe/yOWPAblsv4owOIUJT6PSVbwsv20COpun+F5M/wtHB60hazP8=
X-Proofpoint-ORIG-GUID: fZ_4sDwvInRBaqYyFbshS1SgqgD_tT8b
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

On 9/30/2025 1:08 PM, Peter Xu wrote:
> On Fri, Sep 19, 2025 at 07:12:33AM -0700, Steve Sistare wrote:
>> Add a test for the cpr-exec migration mode.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Looks good, only some nitpicks or pure questions below.
> 
>> ---
>>   tests/qtest/migration/cpr-tests.c | 120 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 5e764a6..f33af76 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -110,6 +110,125 @@ static void test_mode_transfer_defer(void)
>>       test_mode_transfer_common(true);
>>   }
>>   
>> +static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
>> +{
>> +    g_autofree char *qtest_from_args = NULL;
>> +    g_autofree char *from_args = NULL;
>> +    g_autofree char *to_args = NULL;
>> +    g_autofree char *exec_args = NULL;
>> +    g_auto(GStrv) argv = NULL;
>> +    char *from_str, *src, *dst;
>> +
>> +    args->start.hide_stderr = false;    /* omit redirection word from args */
> 
> It's default off, right?  Could I request for some more explanations?

Yes, the default is false, so I will omit this line.  I will change it to
an assertion. (IIRC when I first wrote this code 1-2 years ago, the cpr-exec
test was a derivative of a precopy common test that set hide_stderr=true).

hide_stderr must be false when deriving cpr-exec arguments because of
this code in framework.c:

     if (!getenv("QTEST_LOG") && args->hide_stderr) {
         ignore_stderr = "2>/dev/null";

ignore_stderr is appended to the command line.  For cpr-exec the command line
may not include redirection, because we pass it to execv(), not to the shell.

> Could we also set it in test_mode_exec() directly if needed?

Yes, one can set hide_stderr when launching the source VM.

>> +    migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
>> +    qtest_from_args = qtest_qemu_args(from_args);
>> +
>> +    /* De-dup spaces so argv does not contain empty strings */
>> +    from_str = src = dst = g_strstrip(qtest_from_args);
>> +    do {
>> +        if (*src != ' ' || src[-1] != ' ') {
>> +            *dst++ = *src;
>> +        }
>> +    } while (*src++);
> 
> Pure ask.. when will empty string be present?

migrate_args() format strings "%s %s %s" produce "   " when the arguments
are empty strings.  Then g_strsplit("   ") would produce an array of 3
empty strings.

>> +
>> +    exec_args = g_strconcat(qtest_qemu_binary(QEMU_ENV_SRC),
> 
> Should this be QEMU_ENV_DST?

Good catch, thanks, will fix.

> OTOH, we can use migration_get_env()->qemu_dst to reduce referencing global
> vars.

OK, that works.

>> +                            " -incoming defer ", from_str, NULL);
>> +    argv = g_strsplit(exec_args, " ", -1);
>> +    migrate_set_parameter_strv(who, "cpr-exec-command", argv);
>> +}
>> +
>> +static void wait_for_migration_event(QTestState *who, const char *waitfor)
>> +{
>> +    QDict *rsp, *data;
>> +    char *status;
>> +    bool done = false;
>> +
>> +    while (!done) {
>> +        rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
>> +        g_assert(qdict_haskey(rsp, "data"));
>> +        data = qdict_get_qdict(rsp, "data");
>> +        g_assert(qdict_haskey(data, "status"));
>> +        status = g_strdup(qdict_get_str(data, "status"));
>> +        g_assert(strcmp(status, "failed"));
>> +        done = !strcmp(status, waitfor);
>> +        qobject_unref(rsp);
>> +    }
>> +}
>> +
>> +static void test_cpr_exec(MigrateCommon *args)
>> +{
>> +    QTestState *from, *to;
>> +    void *data_hook = NULL;
>> +    g_autofree char *connect_uri = g_strdup(args->connect_uri);
>> +    g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
>> +                                                FILE_TEST_FILENAME);
>> +
>> +
> 
> Newline can be dropped.

OK.

- Steve

>> +    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
>> +        return;
>> +    }
>> +
>> +    /* Source and dest never run concurrently */
>> +    g_assert_false(args->live);
>> +
>> +    if (args->start_hook) {
>> +        data_hook = args->start_hook(from, NULL);
>> +    }
>> +
>> +    wait_for_serial("src_serial");
>> +    set_cpr_exec_args(from, args);
>> +    migrate_set_capability(from, "events", true);
>> +    migrate_qmp(from, NULL, connect_uri, NULL, "{}");
>> +    wait_for_migration_event(from, "completed");
>> +
>> +    to = qtest_init_after_exec(from);
>> +
>> +    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>> +                             "  'arguments': { "
>> +                             "      'channels': [ { 'channel-type': 'main',"
>> +                             "      'addr': { 'transport': 'file',"
>> +                             "                'filename': %s,"
>> +                             "                'offset': 0  } } ] } }",
>> +                             filename);
>> +    wait_for_migration_complete(to);
>> +
>> +    wait_for_resume(to, get_dst());
>> +    /* Device on target is still named src_serial because args do not change */
>> +    wait_for_serial("src_serial");
>> +
>> +    if (args->end_hook) {
>> +        args->end_hook(from, to, data_hook);
>> +    }
>> +
>> +    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
>> +}
>> +
>> +static void *test_mode_exec_start(QTestState *from, QTestState *to)
>> +{
>> +    assert(!to);
>> +    migrate_set_parameter_str(from, "mode", "cpr-exec");
>> +    return NULL;
>> +}
>> +
>> +static void test_mode_exec(void)
>> +{
>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>> +                                           FILE_TEST_FILENAME);
>> +    g_autofree char *listen_uri = g_strdup_printf("defer");
>> +
>> +    MigrateCommon args = {
>> +        .start.only_source = true,
>> +        .start.opts_source = "-machine aux-ram-share=on -nodefaults",
>> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
>> +                                " -machine memory-backend=pc.ram",
>> +        .connect_uri = uri,
>> +        .listen_uri = listen_uri,
>> +        .start_hook = test_mode_exec_start,
>> +    };
>> +
>> +    test_cpr_exec(&args);
>> +}
>> +
>>   void migration_test_add_cpr(MigrationTestEnv *env)
>>   {
>>       tmpfs = env->tmpfs;
>> @@ -132,5 +251,6 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>>           migration_test_add("/migration/mode/transfer", test_mode_transfer);
>>           migration_test_add("/migration/mode/transfer/defer",
>>                              test_mode_transfer_defer);
>> +        migration_test_add("/migration/mode/exec", test_mode_exec);
>>       }
>>   }
>> -- 
>> 1.8.3.1
>>
> 



