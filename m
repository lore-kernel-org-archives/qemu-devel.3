Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5F7C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoFm-0001Pr-P6; Wed, 04 Jun 2025 09:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMoFJ-00018r-Fa
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:33:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMoF2-0005U8-Ck
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:33:18 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549MtsZ025723;
 Wed, 4 Jun 2025 13:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=SCr9U7MNTFk971fkdwZ58UvIwIZmYmrIzUF0107PQww=; b=
 rjPkGGHDb1wHuZPSQ/T5792ziVU3XpgyGkD1CZ/D1b5EcW9ppij+l+zcRPPbEsTe
 UDkKd4UiiWJ4WoLCM7k+wRpGszeSkuhAoZCjLv44A+ryGxl3wSaUxzJjT0FUZw8K
 vlTO39yh1zgPDONRbvdLKxDbKhMnepBUtMHr8NrMooPD8UXCPP1Cb75QbalOPmME
 dsJltWSlUoC4z+b9xL+GAirkkHPRuTKzdItZJ/2fdUry5remyASp3UY068m+tksM
 uhVraGQe8dT0nQ5rFjQxPZfyiezLZgP8L3LgjjJugP/VXSrbF4iEh7+pPjKScv1O
 gLONedwJd1A1e3KIzqSw0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahc2xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Jun 2025 13:33:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 554CJuCb039184; Wed, 4 Jun 2025 13:33:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7asyc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Jun 2025 13:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJiInqyungOrlhVhgcFq4TAOn0UXD5ctFs3ojERkKbuJWzO44KtRprhSucH2ohKiK4rnHTByI/uflKYITks+ZNwJUeOKcbtPt8OOODEUV3wHjgi+kMgX9fEO5ri7tiuZlSDfNHIEao4GpFH6e5nrbyBWLhvdi0QeAq3uQdZMs7ooYwC/ThkpS4qTF9IX/+BDzCejHe5jHSPaLwTLudV6sc6tuKLQdIuoapsCkUCwKOGnFsOUkXrTv/MnIITmeD//ukKWwLxd2e1N4XL6JzDEmwn0djaKOJRAg6yEOr+79BePJ0X8wDp3k8pJzJ72OiNHsEgZSwiLV+I81d0NTv6zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCr9U7MNTFk971fkdwZ58UvIwIZmYmrIzUF0107PQww=;
 b=nBKSDQki7vwW9wFJirztviHb/ilJFg1pXbpMiFaYwoMXzPxhFTiotEQrUIldKahu16K+ETsUQSm7bw2pSDgXKaW549AtgTp2y9FLD/2pgPjC4M+bKHYRXZVcbui3v5Fym/3Ewlrya6xttm4QbmYqcPkj52QUu28x497agXY8XTp+BDM11JyXc8kVgZO0Cs0iA4dXX8qr5PHrSi0ngs8mT9vwoXTBXATO/BgCiZlPz9vWSeef4tP7J3nIZazx7Iws4BqKStxAyQYUb2TGZrvBdSIGthvkMOj3VXP1OPppydr7jEByX7Uqur5NVxsIrADHMoRNc0/ra3u6re089edS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCr9U7MNTFk971fkdwZ58UvIwIZmYmrIzUF0107PQww=;
 b=oKktUVua+ddjtWCHgUY7TOVKQCUEAckHJNHUYXjCqLK8DXxQ0KGHpqukuE4XwT8hCFZESNfeAfqCgtdflWtD4JRWU9CftnThrqqr8BE3K21PDyZwkcnkfKzH6v2+XD4yw4mZAZdozdr5Q3AarM4tHMKz49ur6bpCG4SbUztOBs8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6407.namprd10.prod.outlook.com (2603:10b6:806:269::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 13:33:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Wed, 4 Jun 2025
 13:33:09 +0000
Message-ID: <aa0c0091-7db4-46f3-956a-03a9f1362c1f@oracle.com>
Date: Wed, 4 Jun 2025 09:33:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
 <IA3PR11MB913659879C0B2EFF7358B229926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB913659879C0B2EFF7358B229926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0866.namprd03.prod.outlook.com
 (2603:10b6:408:13d::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b52c7c-2b61-4a1a-3879-08dda36c5863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWpZSVovL0lBWVdCN0c3RFFrcER2MDFVOFR2aC8wV3BmNWcvQVRRdG5YL2Q2?=
 =?utf-8?B?blZVN0dtM0hnamc2Q2JyTjhEdXVCMHVLNHNpdnNuWmhwOHk0eVRlL2Z1QXlK?=
 =?utf-8?B?MCszNi9ldE0vRFdZV0ZqZWNlQ0g0TDV3dXBKVWF2Y0xJTVVISmpPZWd0dWg0?=
 =?utf-8?B?d1JGUlU0VG95NGk4SXVqdEVEZVk3SEg1K3BaZ0FSNXZnM1U3SDlxbzZONitJ?=
 =?utf-8?B?TW53Y1RtSHdrTldhOERkK0tQMEszRGRXbDYyQ3BGVVpLQSt3YVdTVFVhaGMx?=
 =?utf-8?B?dFI4YVRhWHNEUDgwazNXRnpiMmU1aDQrekYrZUlxQlhWTkFQM01oQ082d2lz?=
 =?utf-8?B?WHcwSExCSER5WWY2SXQ2TVFHOUliOFFkVGNGSVhYUkUzek1Ma1RkNWIrVTZ6?=
 =?utf-8?B?SG9DMUZ6blNjL3F6SHBPTm82QnNhd2dJdXJ2azQvVlRYMmdQaTd0cjN2aXBD?=
 =?utf-8?B?aDAzQTBuQmxTUDI5T2NYWHVzYXhqRlE3Uk9qRy9PNW53WXdlSUxHbzdVaEY3?=
 =?utf-8?B?Y0JBNTVEWE16b2hlRG9LN2ZycnpJMEsrWXdDMUllK21pQ3VmZ2QrQ3J3MExw?=
 =?utf-8?B?TjVRRkZkNHlTeHJFWklnZkpSeW1LRFVJTFhicmxUeThZZ2NhOFhBalowOXFz?=
 =?utf-8?B?UVo5a3p6b2piMXI4MEhHbU9yMEFlcjllTVlqOUJsRytWK2o1OU1TSE5vUUUy?=
 =?utf-8?B?VkFWbUZ5am9aaXVVZnp0ckhUdmVXV2lkc0lkYXd1dG83YTZQWC84Q3V2eWdh?=
 =?utf-8?B?ejdaeWw4OU13aGU1VGEyY0wxM3pNTkpsc1pKdXBha0hCTk5OUjJVZ3AwNG5W?=
 =?utf-8?B?ODg3a0RQUHlTRTdUMnBlb3gxMFhjMjRWVkNiTkJhQ2JSWTdjK2MwWGZwaU4y?=
 =?utf-8?B?dzJZekU0ZldLWWtCVlVCU0o5bG96R0Nhckkyb3N3dmF0STZnWk5RMmZPQ2lJ?=
 =?utf-8?B?N2VuenVlNUZqTml0bXEzL3NrMmN3cjNNUGU3SFFpQ2Q4QXhyVytzc1NqYVo1?=
 =?utf-8?B?dVRjdHBFTUJ4S2ZNOUR4TGxzdm9EaE1BZHBkWWQvbVNSNW1vTWc2akxnS1VK?=
 =?utf-8?B?cXdxKytCM2FjN1dPQ0FXM2VXTW9wNWoyalJmallCdmo4WW1IQ3VIVUFNZ1NC?=
 =?utf-8?B?dUdqUUxHNWdmR0dPTGhlV2V1L3JJK0s4MklmMzhLV0llV1h6RUVoUEYzQWoy?=
 =?utf-8?B?aUQ0ZkxLU01zNE9HOUtjTEtEOWpYU3lnL0FOa0N5Sld5WEtmQVhlbGpVZjlD?=
 =?utf-8?B?UkxhbWxIZUdxOHk3bGFqbFJPSzhVd1lBWm8yK3FpTzdwdnd3VDBnTUw4NG03?=
 =?utf-8?B?ZWMrUlZtOVdFUzN5N1E1YkxNc09VQkd2Yjh1VDRVUWdVR0lTMWNvMUxZOTVP?=
 =?utf-8?B?UVBrWFhjekhGTC9UK0xMTmpOOThvUWZ2NTFHa0IwNnJDSjdyODVyeFdITmJZ?=
 =?utf-8?B?a1ZyUVJ6eE14K2loWGRhbzY3WkF4c1hWeXdrWXFhL0svaEJWTUk4ZEFCVWt5?=
 =?utf-8?B?OU5uNm05YVZLbWVmU1l0dnhvYURoa0NOYzRiVHBUdmU3c3pyZVVaYjZXNHlt?=
 =?utf-8?B?WDRrWXhZRWV3WVEvUTJZSDFXSkZ5UUJZTEJxeGI1d1lLOVVHcnlHNDBZT2R1?=
 =?utf-8?B?UHIyUVZQQU5sdFdQVE9wN1FHYTUzMjVhbkd4ZmgxektxNkh1ZmpBNkNXTlB4?=
 =?utf-8?B?YkN0YXZNdlBvZzhmZlFQOERnd0p2NjB1VkE5encwTXZyZGpBU0dJY3ZVQUJj?=
 =?utf-8?B?VHJmaWJFVXd4cTlvdmFGYXFKcitvZ0FFVnRTQjk2N211amE3RlRMMmFFMHJm?=
 =?utf-8?B?RHNnSGFEanJCWWtvd0FUN2s1T0JmRGVuS0wwbVJGblo3WDZTZXhuMXBSVkVh?=
 =?utf-8?B?eDRtZkg5ME9ZejB2WHV6bVZGcVFJaVVVbUlHeTRsV1EvZ1VnS3lydEwrVXVL?=
 =?utf-8?Q?H/K+NgDq1AE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHBQYjllcEo3bDdMcmZYYkZhbk00OWhkNVpBK0pPOW5FNUJzTktsQTBBdmVF?=
 =?utf-8?B?cFFsK1dhYzkyN0JRbll0aWN1d0cyVU44ZjQzNWcxWWpvbmdGSGhobmxCUmQ2?=
 =?utf-8?B?U2xXRnBybE9TVGdNZzhhTnc1R0dOV0FGZWpUVm5VMHAxRExXeFN1dHF3UkRo?=
 =?utf-8?B?SExHLzVuRmlMWFB5Sk5YTEV4OTZ5VGhHU2g0OG1tUU5FREFPZTMrcFAvZ0Ew?=
 =?utf-8?B?TmR6T1ptTEVtR2w2L2xwRCtZZWhOSzFBRzFPbHBhN3l2dGhSOERxcGoyd1cr?=
 =?utf-8?B?R0FoTWJBZi82dVNQQkh2Umhnd3RJOHUvZ21kL1JRbFZ4ZFU0cVp5K3FxT3FR?=
 =?utf-8?B?bE1zaWFwamYrNU1xeGZKUVU2Z0wvbGk2ZERPVzlDL0tMQ3kzVzk0NS9tMnRV?=
 =?utf-8?B?NXJGK25ySEhBdnFUV1Jia2o3SERZeE9qQUYzK0d4SG56cjZIRXZncE9xcE52?=
 =?utf-8?B?a2dZTU9aYnBmejFWN0dwOUF5NTM5Vm5VaDl3ZUk2V2dTN3VxU3ZwL3hCOUFK?=
 =?utf-8?B?YnFzRDFnZE5KU0QvMUsvNlpzaXRUTUpLcFZTVXo4RXRPM3R2UTQ5WnBXNFlT?=
 =?utf-8?B?VythbjZLVVRoSjhBMGI5UFZqUmxNT1F5Z01MTnNNNnBEU0loYmRYQ0dxdXlC?=
 =?utf-8?B?eWZnZCszWnBLdUpwWjlCTDUzd0lEcWFvL2tYS2hHQmN5RGdKR01HRkZzSTZW?=
 =?utf-8?B?YmZRSVRLK0RHVXYzd1QzTnoxOTRnazhic0FWZmU2N1pVdTdxVlpwZG5mcjd3?=
 =?utf-8?B?MngyWGZ4ajhHMzFNNUoySmQzRUVIMDlNeWJITXFDQkxrOUovWmVTSjBUN2lr?=
 =?utf-8?B?ZGVqWE5sUzVldmEyeTdSMXN1bWNwSU41Ny9IaFJxenFTZlpvTHRyZUw5S2Qv?=
 =?utf-8?B?ZXMvcFhTYVByeWEyTmRaMW00T1FzZWIxQkhnaGdkNEVIQjVjY2FNVmRBNUQy?=
 =?utf-8?B?QjlDKzlzNmYvMEZnWktSR0VyWWpnT0R5dytFNjNrUytGaENkOXgxK0s1cE9H?=
 =?utf-8?B?SFZCUFZCSENTa0p1bklWdWFrbkFWdzJVaHU1bVAvRHVVMkhWV2QxUGVLZUp3?=
 =?utf-8?B?YVpBV2ZQLzlkTGNQRE81ejliS05vL1F0MlNwVDRhK1lUN3cyaWJaODZKNlox?=
 =?utf-8?B?YVMvMDF1YXdzR25Ma2pXYUU4dVNXcWpXaTZhRVZLVU5PVjF5aXZlRnViaC9Z?=
 =?utf-8?B?OWxwM2hmYUpyZ1QxK1N2M1AvbGJhZHNFcWRnU2FIWWJramRyU3JxTFpEMDlD?=
 =?utf-8?B?RkQzZEY4SytsUUNOeHFGMUUyWlJLWUVwN29haENMU0t6dFRGUmFGQStrWWVH?=
 =?utf-8?B?UEltTnAwazdQd0FFdmF6dy9neDNWdnc2OFpkSWtUTnpFa2NsWEw0QlhjcVda?=
 =?utf-8?B?OUZmdVJiUmFlZEt5eUhsRk9oN2hFN3NHWk1najlkRWZWUkk0NXhWWUwyRU1r?=
 =?utf-8?B?SE5lSlpuWlZWd1ZWWEVyN1daSzliM2QwN05FWmt5TkNNbFNjQS9ZZlYzQlRC?=
 =?utf-8?B?VXBXUTF3ZFgxcjVlZnpTZkFmSlBDOE1XSFg4VlYxcURKRHpKdC9NaUJRMkQ3?=
 =?utf-8?B?ZllQT2ZITEZSS0NMVFhzVnlIcjg1VkR1YmlPTHFTWU5tdlFReXFibGp2R3ZF?=
 =?utf-8?B?TXdTMXg2N2VZM3V1amFQemE2YlpTMk1MY3BDVlNnZDdzcU96Q0FudC85eU51?=
 =?utf-8?B?MWpmSTIrQjJ2T1pwVzgwOXFTMzdjQWJnb2liQS9tQWpTTHVrbkIvNUlnMlQ3?=
 =?utf-8?B?WDNEbEpQVk53aDFjOUI3RXY4U3pXLyt6U0tEZTJ6WDBIV1JmVTh6bWVXOHFi?=
 =?utf-8?B?STlwSm1LV3RYdmVGZ2hVb2lEOEFkQjI2Qi91Q09BbmFIdkRBWERhNFVCeTNw?=
 =?utf-8?B?OHlMOGJKNEpiS2hLOU5HcHV1NGNHU3NXNXpFcFdiSEhlejFCazVCK1dqWXpK?=
 =?utf-8?B?UUh0US9JRk50UVhVTHdjZHRBOUt5anpJT3ZxMEIvOHZPOUYyTVZneXRqVkVO?=
 =?utf-8?B?QnVDa0xOMEl2Zm1XaktxTTE5Y0xvTjJKV2haK1o3VjVJeldDT0lTOUpnS3k1?=
 =?utf-8?B?dkZHRUZ0dzFCa0R1V0pmTG1pOCt2REJKNWhJeVgrWFlKWWF2ZGpURmhQelVU?=
 =?utf-8?B?TWhnUWhWZ1ZnWlJPYVNOWjJHSXlHa2phL1NVOU84NEhKcnUrRjdmNGk1WHA0?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CDqMEKk8dOXvKtz6nmNa7UEczK0L6lLtb6hRhIwv0Z32y70fhDyTR23mWWEClRmUdqtudKGvr1j8T26OJ7a06oMHtKT5027d05nwr2Ni8+iqRdPiKnzQ/I7DgdrvvobeO5JCcbEzgaq01L7x9oTHJtEmCxlMQW4276BBXHJk7FgH8CDmBNkq9v716lZR3H/J9JaZA8Eg291lf+86IszFkGP8/yWNhboEggyWEPhs2eFIXCPq13SjKuJIXX4FLXtOqHW8K4WpRtCOnbkKv6aJynIiYkybNFZjuZ+TvnbI46QkMEdmac8MUtGGq1yoVfj6hM1BZvG9PedZIW/vSHKRDjqvbdUj72LKqsaO/7kWOEJUBM0gXljjkHdcsK5PxQmmj82SiNDXg57APKZ0MOkATUMeFw9kyke0OFs2Gu0XGgHiIgr/j9qHBsIxkuX68UsMkr4juAwtFof2xVmewSRhA6WQfCnjirN4UqIarevGKlDgKMly7tll+l+JTE7Hds07Ho2bP2i5WERz96Fk29Jn0UkYJ+igdHEvlGseFHYzfrr15wiZNRnpT5b8ifltlAX1CDGfjoNCseaDvunrljUWA1PsZLI0iFAe5ZSmjPru7/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b52c7c-2b61-4a1a-3879-08dda36c5863
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:33:09.3154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7krbwYiAx7PrQuvJPuVDbnLB4NDMqJMZqWPGICwkck1IrbdaX9eBt8bWwQFD3J7wkotk+R8jo0yREI6po8uCj96W8efQYOgkQaqH+ucLW4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040102
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=68404b18 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YA5KhkqCfEwNnlGfxuIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WCVcH7BY5jJ0h8p8JaPs6XoSLIEd6t6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMyBTYWx0ZWRfX80zD//v/6b3H
 Y5EbUMwLD66TzK1ivTIAomQzJmAIsbjDYscPja1smSCDj6GnBfE9PglR6jghjrouTODB3AWhFEB
 Rr8lZ8l34GxwohEsnMc5pdT+rATSGIH/XamBMDPskI9yb8dL5yLx6kvAoUajze8+ONk0q6Yz4Gk
 +10H9iHpYrW8+EIAhUOf8BMORsdw97+VsTVi6VscZWqyYQ/6G6lKtFiJuWobh5+ra7j4VgXSzH2
 uJXzT2xqLD7DoIAiwRfYvQGY8nMdaXYKBYLZqpZN0SFuIMF7nHrGKhrjOSCIdvAp2LwuocsaTbj
 3g7YCO5elssVBUee7/SIjcfSpFdB0ygHe6o6DpMaxmnQ+cKwcLAXFM6OkCitm0Tmr87XBxKLlgj
 xIUPWBIkv7dZ8Op8xU3G+7NRXyUWWg/l0XGYozSNJxqlQBviUax8XVUACUIhism8x4/Eb0kI
X-Proofpoint-ORIG-GUID: WCVcH7BY5jJ0h8p8JaPs6XoSLIEd6t6I
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

On 6/3/2025 11:55 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>
>> On 6/3/2025 6:40 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>>>
>>>> If vfio_realize fails after vfio_device_attach, it should call
>>>> vfio_device_detach during error recovery.  If it fails after
>>>> vfio_device_get_name, it should free vbasedev->name.  If it fails
>>>> after vfio_pci_config_setup, it should free vdev->msix.
>>>>
>>>> To fix all, call vfio_pci_put_device().
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> hw/vfio/pci.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index a1bfdfe..7d3b9ff 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3296,6 +3296,7 @@ out_teardown:
>>>>       vfio_bars_exit(vdev);
>>>> error:
>>>>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>>>> +    vfio_pci_put_device(vdev);
>>>
>>> Double free, vfio_pci_put_device() is also called in vfio_instance_finalize().
>>
>> If vfio_realize fails with an error, vfio_instance_finalize is not called.
>> I tested that.
> 
> Have you tried with hot plugged device?

Not before, but I just tried it now, thanks for the suggestion.
Same result -- vfio_instance_finalize is not called.

- Steve

>>> Early free of vdev->vbasedev.name will also break something, e.g.,
>> trace_vfio_region_finalize(region->vbasedev->name, region->nr);
>>
>> All unwinding and calling functions that might use the name is done in the
>> vfio_realize
>> failure path, and the very last operation is vfio_pci_put_device, and the last
>> operation
>> of that function is freeing the name string.
>>
>> - Steve
>>
>>>> static void vfio_instance_finalize(Object *obj)
>>>> --
>>>> 1.8.3.1
>>>
> 


