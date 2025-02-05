Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EABC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjm6-0006I0-U4; Wed, 05 Feb 2025 13:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1tfjlz-0006Fx-Q3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:05:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1tfjlx-0005z4-C3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:05:15 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfnpi028357;
 Wed, 5 Feb 2025 18:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UPFvJyAhTuGV5VrqAVm4Qy5x0jqQpJz17KIaLuETW/I=; b=
 mWwPtbcmkpMRCky9Bt+Rj/nX1aNUpUJf01i0ToZnhtCuyiv2w7GhyLr+vVkAsOXZ
 CMOV/3FhUuQQeMOnqmNXKeTIOvkD3nFjz5bQx9z2I729x2wYOntLlLeLDz4KXnNO
 K1iJAYOp1xNXoNcsitfkESeW+fMxPdxPV0EYOjS73cWxkJLINvoUspC/hZI2AWaV
 DBTlK8yHNvZC2ZADSlAw9Tgl5Z1VOT48+neaEJa0Pfu+BJJPYihM/BMWiIZUMym8
 B04YOZuuVPXYUvH33ftdmfB48xvs+xjHAEREpkD+v2VfOdZN62DcNoY7HvMhT21k
 IintUlUPVdGnKY/R7DqQ3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgyw32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 18:05:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515GTeeB020641; Wed, 5 Feb 2025 18:05:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fqrdtw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 18:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvSFMH4bcdKCxz2Dvqy54k0se1Jv8veVkuTm+NhpdL52ZausGbucvNi4Uu1iuI7T8EG3zvid1TRL5akGxFYSGKMZXSZdOVbYbePGWXBq4Ge11UOLhIafHv85rsYopmhcCQioX6zEAKbgHiI3VQoNvBj+FqyH2NYd9gwb+dDw+E4gmZrEFDRvTtyWWre/LWmCK2A2IUtCX4g0uI1XKkOCq5Fr5d8OBsR0UBF8h9Ssery8uYg5aFtlFJbH3qKPsiq2CpxeM78mSSx4XXSMlfMdPlMYWutKiZGucAAQsgo+i9r0ML1ozT1qEdcxaMxL8rlVzDdlDDT+ODiT/f99g4GhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPFvJyAhTuGV5VrqAVm4Qy5x0jqQpJz17KIaLuETW/I=;
 b=j8OOgPcXZz0uKE16ZFIVEAClwinqP6bMlQsSZKMJHwsfIYyxZF8F3W+1OJxTza4ukvwvOdS4BBscQBxDIPGsZ7Kk9JmpNH0RJNfepgVnlxN1jqmQrm+0ecZPu1MbnbsUluJe7JsnL3fH8g2vDYWNwGeZxgyasFdL2VZYH/iN57yenWhgHfQwJCEWvhsG9S1zk2PqWWS6CxfmTC0FymBSZoQ7sV58F3MNsF5kYalVgscKdry6twm2n9W7yCnvSF4qI00gUqf6sHc8rs5cleFgntHQB7vdN1Nuupt/twE+pHLbeKZFlQ7jxjxUveMLdbsUpbfFVbWSVXF/+D7wmBEP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPFvJyAhTuGV5VrqAVm4Qy5x0jqQpJz17KIaLuETW/I=;
 b=g5nMWRypg2jOIS5fpDex7wr41oaeluKsXBJTQuUd2DlQpVpgo6l4ftr/T3ElOvDxg1tM5oDGLQw3AYzzEP2DntVGMCCDpaUwmM/7sBBkp532+e74jSZbWXZB8OZKsH1DtQQew9eTC6zRaNDqWrq9AQHAeiLpNbjZL5VhzHRjBvE=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by PH8PR10MB6599.namprd10.prod.outlook.com (2603:10b6:510:224::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 18:05:00 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%5]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 18:05:00 +0000
Message-ID: <63e063c1-e44a-4dbb-aa88-730d3226629a@oracle.com>
Date: Wed, 5 Feb 2025 18:04:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 armbru@redhat.com, pankaj.gupta@amd.com, huibo.wang@amd.com,
 jroedel@suse.com, liam.merwick@oracle.com
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
Content-Language: en-GB
From: Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20241218154939.1114831-4-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::21) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|PH8PR10MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d269a9-ecdd-4a2c-b62a-08dd460f9b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXFmSmFubHg4SHd5cDNsenkwd1dNWUhMUmlHOVdHT0ZOSlYrNDQ0ZER3NHd0?=
 =?utf-8?B?QUViUFhTdGlwS1VLZzhkNklkWjBGejJKeDhwV00rWnVudFFXSVhEQXlXRVV4?=
 =?utf-8?B?QUdJa0VqaGdGMDdYVURZUXdFVldiRjhsTlhzUnNyUUhGZXpqcXA1Mmg5ckw5?=
 =?utf-8?B?czFHWXZEWllrV0djNkluRnJ3SDl3MlZ1cXNtUjJDam9CNERmN29jQWNkVVRZ?=
 =?utf-8?B?ZzB1Y3EwT1RmS2JCRVJ0eUY0MnFhdE1NQndxYUlIZ0pxYk1UdGljV3hVaVFD?=
 =?utf-8?B?b3h2VURWb2piMU11QkVnQmtOZ3FUN0NWTlErekRYTlVWbU9leTFlOGpTcjRH?=
 =?utf-8?B?L294TzVpU1dUVncyNWxxdUhOb1NLdEdscVJtYyt2ODJDUVVjRWpXdWpGbDFD?=
 =?utf-8?B?WVIrY0VJT1VHSDNCMkV6ajhxdGduSk03Y0hpaHVQYmp3eGZBRDk2dDFpWU12?=
 =?utf-8?B?aTYzSVpWazduQ04vYVJsYXlnOER5azJxa1BNNitiUjM5UFVPU0I2aEE1WDJJ?=
 =?utf-8?B?RzdIUWlYN3RxSlhSZis1eEZudnl1TCtvVzhxdWRBUEFhSVA0Z1FWa3FMcnhV?=
 =?utf-8?B?Y0RkT09RZkZwclBwYmNEQjU4TEVjbnYyVnBCREJtdG5JUENBdlFBY2duZ2VV?=
 =?utf-8?B?bDNjMUpXQXgxcWY2OFl0WXlLcm1hN0QxdG0ybnZKakwzSklGUytudTVuaU5p?=
 =?utf-8?B?NVVacy92OWVyMjlwb2pnV1NMTUdrZ0xCdnRiTDhBUWxhcUdzWUVZYXZiYnEz?=
 =?utf-8?B?SUJnZVQ4TVdrbW8zMUFuY21FRUVzeXRFajY2K2MzNHJyRldlM2VtMUxNbkdI?=
 =?utf-8?B?dUJ0aEU5eWQ2TWtGU3FuTDRiWHVvQmhDUEVGRyt6bkJMcHJleTQrWm9ERUJ5?=
 =?utf-8?B?RG8rT3lZcDVsQ0xNc1N6aWM3YWVJdjgyWmc5R01Qd1hRc1RVZ2RoQUlRYVBq?=
 =?utf-8?B?cWJIWE5GVWdya2Z3dCtQVEh6V04xemVmSXNZUjE5Y2IzMW5yYlFFNVpkTGJp?=
 =?utf-8?B?TkdxUHl1L2hGd0xhSDU3a3RBVGxDbStkaUZ1amJZUnZlRVhpeEt4OHdJWkJK?=
 =?utf-8?B?V3c2T2ZtTURqdHdsNXBoUEJpWlVGOHNSSlRmSzJveWxvNEw4UU56MlF2Q0pn?=
 =?utf-8?B?L0lKb2llelQrRTJvNFhxUklZbENoM3hrWmlzRGRweWpWZUJaOWh3NHlYR3F4?=
 =?utf-8?B?MWlzWFBCaWk1R2VISUtiTnBEQ0JTZ2UyVEUrYXFhOU5VOUhXUEhkSmFudm1r?=
 =?utf-8?B?Q1VSRnc2dmgza05aM2c4R1JmWWIzU1ZaYUVOK1djbnU5V2h3MXBYcmpaLy9F?=
 =?utf-8?B?VFZwaGtCK05TZW1EZnJYK2ZHYmZ5VVN2bGdKY3JyTHc1b0lkem13Uk1DMXFs?=
 =?utf-8?B?ek91eU85VlY2OTkrYzdhcmNMVzBEeWwwNUZocDRXdW5NeFVSWWNVSEoxdjhv?=
 =?utf-8?B?OEw2bWdadFVPejFyNDlMQjgvMVIvdkFKck1aeGNqWStTSi9NUVlXTldSbERi?=
 =?utf-8?B?bWtGZG5LQTdSaTFqYklvSVhZWUF4QWdjMVJWQTZicTJ0WlZZV2dTRU9pSk5S?=
 =?utf-8?B?M2Q0ZDZFUUwrZkcxY0w1bDkxU0FHYkEvbzZ0QU1lMmdZdkRTb3lzbGRBUVYw?=
 =?utf-8?B?U3NUMXRZK2dXdDdpeGdhTFZ1NlFwZGtIQ3ZwK0JIVnN6Zy9FL0pGWHBpTnpR?=
 =?utf-8?B?c056Zk9hSjVNd2dGeHlkVDNIYjVEMkgxbWd0S0JFYWJaZUpnM2hDZC9OWCs0?=
 =?utf-8?B?MjZnOHhieGxLWTJYcVlHQWt2N1Z5RVM4TXExRE53SkFDSXhCWVBLZUo0U2hp?=
 =?utf-8?B?bVZLUGlYdCtYMXh5Rmt5bjdid2Q4aEw4bGpxRlRxUDJEc1FhSy9EQXNaSGtJ?=
 =?utf-8?Q?qBMGrDNV3gCmj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5030.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNhSnJ1bDI3OFNnNWljQzRwenRCdW8ySmgvYUNjUXdoRHM2QjV4OVhPZ1Vj?=
 =?utf-8?B?UERMSUxZRUtmQjE1RGdGR1VDNjN6eGZGd2I5Y0dHRHBWeEU4ei9zL05yMEZZ?=
 =?utf-8?B?RkVzUWxrQ2U2TlRRNktlUE9zRkx0cG1WTVFiRVlvdHpwUmxSMW9ubldpU3M0?=
 =?utf-8?B?QU81c3NTZFhLSmZzZzNLNDB6VDlxM2twWksxU1VxcDAxZk1hN1N6NGR6TVpB?=
 =?utf-8?B?VjA5WTYrUS9tbDJsdFl6MFFnNXF6L2xLYUlmMkY5NDBRRVNhVHdydDVCT0hB?=
 =?utf-8?B?a1IvdmE1SmtJR3hpSnRXM1BiVkJRdFp3Z1ZZczdvMzI1RzZvVmlGYmhrbkxO?=
 =?utf-8?B?SlM4SjQ1Qkk1SE5Vc0JOVXFQSldub1AxWkJFeDRKc0FVQzhSNVZyWHRGbXR6?=
 =?utf-8?B?ZXpxZ3Z5UnZzMFlWYktpbWNpeERqdlRMNkx5Y1Q1QzJIUlZqd0FwaHRmS3RE?=
 =?utf-8?B?YTE4VlRvdHBtYTlFT3YzendMcFIrSHkzMTNQcS9FbXMxNkh6V082Zjd3QVJ1?=
 =?utf-8?B?bmpXOW03MmVXNE9Ya2NteEFaRVB5ODZXazhENVBLZTViVHEwM2pYVW8vd3NN?=
 =?utf-8?B?K3NlTWlHYm8vNzR1VWxrRVRSaW84MVdQd1VjdXNiQkhqR3R4b05JRkpUNTN6?=
 =?utf-8?B?TG5EUnpkbk5KQndDaEdxdXdJc0F3VHU2ZWZOOW5wa3NRMFptNjBpMHltVEJ1?=
 =?utf-8?B?a2dwSXFmYkVoNlN6VUxkY0JBZURFL3V4WDg3VkpWVEpEcThjaitCSFlyZFE2?=
 =?utf-8?B?YzBDR0ZZVkV1TUpLUm5XV2gzYTMxdkJ3c2FQeWhZV3l4OTNJNGs1bXhUNE4z?=
 =?utf-8?B?dXNLQ3NMSnErK1Z5RXBjcGVDWVd0a0NwTm9WWld4Umk2c0pROWcwbUJBRnNo?=
 =?utf-8?B?RnlBT2ZLUTQ0Z0FWSU5lbGJHZ29DZExEeG5pMkR3K0RUVWxHNngzeDZYdWFI?=
 =?utf-8?B?SG5iRWpSZmUvMWZLakpYK1M3cnVXbkJFQjBJb0hRU3VkaWZaZVI5ZzlWeW1I?=
 =?utf-8?B?QnNKbTJ0YTltb3lLcnB6V210VmJ0TTlpQURQTnlQSUJlQkpMOVp4eUwvZG9k?=
 =?utf-8?B?eWsvNjhOYVJxeFE1b2lKemdYUXl0V21ySXN2amhvVlBzNnlnSjN3UEQ4UXJ4?=
 =?utf-8?B?akpZekVwNFQyY0NMUmdxaC9kSWNhKzEvUDRsSktUTUtFNE55Y1l5eWc0SUVT?=
 =?utf-8?B?UVhDUzFsM3VXVG5KNm5xWWpoWW5LT2w4cDdZdlVyS2ZwYTM4YWlEdlIvcmdK?=
 =?utf-8?B?aGw4NHNmZkVMUk5xZDF5b1VJc1BER0dFU2FqMWljeStXODBvbXJjT092bTds?=
 =?utf-8?B?b3ZLbG45SlEvT0d0eWJVdEdtbXpBVm5ncnlybFIrUXFrb3BQb0FoRk9RNml5?=
 =?utf-8?B?T1NvRmRjYTFCUG16TU9URzFlaHh4V25sMmUxdHhHR1YrSDh3STBVYzlRRURE?=
 =?utf-8?B?SXZNWmdwZ2pOV0kyQVB5VGN6YnE4RlFtcnRhOHpVSEdRVEZTQk1kQVBEUUJj?=
 =?utf-8?B?ZC9EL1BzQjFkc2h6TytXRkZuZTc5OVRMWUI0aHRCb2hoaUNUVGlaT0EzYmNm?=
 =?utf-8?B?bXF5Tm9nNVl6OG1zN0tEbTFIZW0vcVVwVVgwMkROTjdydDM0aFZvbUtYbmIr?=
 =?utf-8?B?bVljZ3BWckV6WGlKUHc0cDdJNGlIMUxxSytYQ1R5UUJrcExQWWg4cnA4dDFQ?=
 =?utf-8?B?Y0VQMHFENlNxWnNnbmhEaHpEOCtSemFZeXdJUHhpWE02MXlkUFhMUEpvaENw?=
 =?utf-8?B?SlYxMkdsWnlucTgyaTgzNzBYV0xTY2x3OUZXZGhZNldhOUNQRm1PS0NSdFE4?=
 =?utf-8?B?KzVxODlHY3pld3ArMEFCSWJkdElLcmhhWGVyam9tVUJuUWN3Q2dXUmord1F5?=
 =?utf-8?B?SS9wSXUvQ0c5WjRaaS96cXpYUncwMUV5NzcveDNyMnNHZ3VCTmlWUGVPNkg5?=
 =?utf-8?B?bFdzMlhxR2NTM2w2cTF1QXNhd2RjNmoxcFNYUkl6SE0wZGpuWmIxYjJkWHpX?=
 =?utf-8?B?SmRVTzBvOTFtN1VLSGdqOWJpYytESDBrYi9jVWhXblJDRXJ5S3J3bDNNUGdY?=
 =?utf-8?B?TXFhK09vb2lVZ0EremkwaGFzSEY1L25Yd29yTjZPc0VXSi9vZ1BTV2gxaFhj?=
 =?utf-8?B?NWNUMGo0SjkwaG1TRkNHS1NCQmV4emVNN1dJNkpVbXUyYVNOZ3ZMVk9Pbk8y?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t+VX3AQK7U8Ymq6u66UfYJDPZvuXeNEuGj6Psmrpv8iffsuknR06gB4lDFQq37utsU/foBgQD8/EbBF4HgD01+JugQHPaxiVtzEmEAdmIZM8HiQDSDLdvv8m//wR9+6JNDGuY5A+edrE2ZgRC5CRpQjZ8t5aedqZ4bkZVwGr5NBSTYu99pzWVmv799DH+XYRrwEVci37NseFd1jIfHFwv+TWuj0mx5CvQXuPa5gC7S0WcgJfifs9mn4vbGJ0dwtzWOWgsrDdIvSJ7yPVRWBAKCDVzOpfmp6SC+H6qqyetrQ1fhb65mmoyrqWEp3eMI4FQ/IMa02PoGRH0t6UcE6lMrlKdWv/FhBcoTlWsUXiqUda9bExwdeovVJGGd27dvcW57L3hPYeRjegUuNcD/9niPpFMkv/VODdLFZU/nFkkeX+rUcWsR2h5XIh9CWtFiJfwAuuoHnhEF26InRqX2DKKiMUGLXEQmvfExveuXRREEZrhFQT8+9AACxkHgXP35A1zArcohX1UOE+LeirJOHFkNkOmPFjbKbLznMmI2IOTu7OEdmn+sNcwprYToReAiIKic/E5tbFnBkwxS4C4ClHq3MEupBIRHJidcMk7SoMRbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d269a9-ecdd-4a2c-b62a-08dd460f9b6f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:05:00.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW+QhB+xvyVF9F1XCV260fofVoEzieApFdLxlJX0NLn0+1XhcINxbQvDJHC/Wqk7FJM/s41/7IC743ihVV1fEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050138
X-Proofpoint-GUID: 2L7T66-kkGe311Ct5vrp7chtPTzq9q3x
X-Proofpoint-ORIG-GUID: 2L7T66-kkGe311Ct5vrp7chtPTzq9q3x
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=liam.merwick@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Michael,

On 18/12/2024 15:49, Michael Roth wrote:
> The GHCB specification[1] defines a VMGEXIT-based Guest Request
> hypercall to allow an SNP guest to issue encrypted requests directly to
> SNP firmware to do things like query the attestation report for the
> guest. These are generally handled purely in the kernel.
> 
> In some some cases, it's useful for the host to be able to additionally
> supply the certificate chain for the signing key that SNP firmware uses
> to sign these attestation reports. To allow for this, the GHCB
> specification defines an Extended Guest Request where this certificate
> data can be provided in a special format described in the GHCB spec.
> This certificate data may be global or guest-specific depending on how
> the guest was configured. Rather than providing interfaces to manage
> these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> to request the certificate contents from userspace. Implement support
> for that here.
> 
> To synchronize delivery of the certificates to the guest in a way where
> they will not be rendered invalid by updates to SNP firmware or
> attestation singing/endorsement keys by management tools outside the
> purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> obtain a shared/read lock on the certificate file prior to delivering
> them back to KVM. Only after this will the attestation report be
> retrieved from firmware and bundled with the certificate data, so QEMU
> must continue to hold the file lock until KVM confirms that the
> attestation report has been retrieved/bundled. This confirmation is done
> by way of the kvm_immediate_exit callback infrastructure that was
> introduced in a previous patch.
> 
> [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
>      https://www.amd.com/en/developer/sev.html
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   qapi/qom.json                 |  23 +++-
>   target/i386/kvm/kvm.c         |  10 ++
>   target/i386/sev-sysemu-stub.c |   5 +
>   target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
>   target/i386/sev.h             |   2 +
>   5 files changed, 288 insertions(+), 1 deletion(-)
> 

...

> @@ -2393,6 +2613,26 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
>       memcpy(finish->host_data, blob, len);
>   }
>   
> +static char *
> +sev_snp_guest_get_certs_path(Object *obj, Error **errp)
> +{
> +    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
> +
> +    return g_strdup(sev_snp_guest->certs_path);
> +}
> +
> +static void
> +sev_snp_guest_set_certs_path(Object *obj, const char *value, Error **errp)
> +{
> +    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
> +
> +    if (sev_snp_guest->certs_path) {
> +        g_free(sev_snp_guest->certs_path);
> +    }
> +

I think there needs to be a check here 
(sev_snp_guest_set_certs_filename() in snp-certs-rfc2)
or sev_snp_kvm_init() that the cert file path exists as otherwise once
the guest boots and there's a request from the guest to the host to get
the cert, the failure in open_certs_locked() will crash the guest.

Regards,
Liam

> +    sev_snp_guest->certs_path = value ? g_strdup(value) : NULL;
> +}
> +
>   static void
>   sev_snp_guest_class_init(ObjectClass *oc, void *data)
>   {
> @@ -2428,6 +2668,9 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
>       object_class_property_add_str(oc, "host-data",
>                                     sev_snp_guest_get_host_data,
>                                     sev_snp_guest_set_host_data);
> +    object_class_property_add_str(oc, "certs-path",
> +                                  sev_snp_guest_get_certs_path,
> +                                  sev_snp_guest_set_certs_path);
>   }
>   

