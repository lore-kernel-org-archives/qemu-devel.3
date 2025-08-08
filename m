Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39535C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIjc-00028S-9O; Fri, 08 Aug 2025 04:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ukIja-00027f-Kb
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:45:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ukIjX-0003LX-F2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:45:54 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786YJJ4027798;
 Fri, 8 Aug 2025 08:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=17Wz4NF+Z62D/lYso69MJIalTEQAe9aB3JNxtxIVfAk=; b=
 ppbtokS2VPHx/tqyI2kHFGYM1IyzAP1SScOrWf8sZNZMRITrYYpvbA/oB3lplTgi
 8QKo9jITKjNlV03UdvpuJKWBFlzzywpj5hOMRaTDNeqsmR9toIKUhkHBidbrQvfu
 vupMnNXb6Gxao7MSQCchbGm2w1tC6WW3+qj2h62F3DpOOiY6HUBF+7H94trcY71n
 NzMirxjutrF7FIoUO6fKQLSBHfo1MB7Zn27vez5Le5Llatd/5j/0X5t2trWheyf4
 xLbr2O/ifRFOycpvEuUCBIHou3z375IS7saDl7xrPTMLO8dNYmL+Aiex6gccCal/
 kvoQ8sbjkU6pglYhqW7peg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgws45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 08:45:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57888xBM018420; Fri, 8 Aug 2025 08:45:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwth62b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 08:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsgP3v8pWd5qbMcDcJcexSAilA8QP02+OUlF2N3Rsp0EQJfLn/H0peMn5cYsFcfa0ZDH+g2biTyD/L1HQLGzSWkhClbTx6L+pSB5ChBjcWsdw5nfDf8KWUh1vDT5bh1oAF0QxclswZgeRlFaCtfuiLjLDNUZ8hOW8ddtruvgVefHNIjsATTMc7y5oaDpjcBNJG4o7YD/7k74jY/W6j850JiZlrHtOrV8Lp3/ZzzRCvem/ChnDtKagKLxetSagYiG+2YOy+0TCZqmJwwJcf0qMd/VmUuFnPy8kiulTe6+eVmgf5NW/V4FPjPMoY6zEemYf83wNvPH/BbPXMeVyWm9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Wz4NF+Z62D/lYso69MJIalTEQAe9aB3JNxtxIVfAk=;
 b=YQxH8hJCYBHisJUZf9CwP5Jgn8n2KVpBSNilTrxrbUv/nQXE2LnZTctMB5CM/FghcyLmW7Y/5Kj2gjuVxA3eZiBOsYUGW3qhIsVh084ParAtcN1axzTSUDpi1QDJPPDeFNZKUzxoT+E/w/EZaa/ZLJO/hXV+toGs9m/CwDVHLKJWrkwXAJuR2V96K/YAMjiLMPJ1DT5V7MDBIo1WDIQ8wLnXv5cFT7bkdjjdWqzgYDH5MpZsQe8rROD61nebSm87CR8N6CbAXcepniM7h3zXO30ZX0iV7pbPUkzXTplszLRzNK986t5xn/9Tkvl6VURiQlZme13rHNr2A7Zujp59iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17Wz4NF+Z62D/lYso69MJIalTEQAe9aB3JNxtxIVfAk=;
 b=OOfRmTKUDUMC2xrHxzFH1d++VRFA+peRlG90jQG3e80yZGmDs9/TVZvfnEjcbFnEshhRgQVPnlHjrvL26Gh3IRxXY/GwF//uhQFDov3MpDxN+ERX9SxfE1gd3dqHXSezu1n/AqXkihZaJ+oMYOvvI1VM6cxXxci871HMD7dDqi0=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by MW4PR10MB5812.namprd10.prod.outlook.com
 (2603:10b6:303:18e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 08:45:11 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 08:45:05 +0000
Message-ID: <9202e1ea-7b83-4caa-85ab-7621413a50f2@oracle.com>
Date: Fri, 8 Aug 2025 09:45:00 +0100
Subject: Re: [PATCH] vfio: Allow live migration with VFIO devices which use
 iommu dirty tracking
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com
References: <20250808040914.19837-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250808040914.19837-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 129c025b-eeca-457b-745a-08ddd657df65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2drOUxaQkVteHNEWjBjTFJWSjh0YjgxbnkrTXJZbnZaQ3RndjdPNFhWSDRL?=
 =?utf-8?B?dC9HOU9xMXhCTXUvbnRUQjlsTkloYWpHQlFlQW43N0JUa0VJa0FrT0ttOC9T?=
 =?utf-8?B?NnhNSVp0a2NQeHdCZHJ0ZzdDRkZHTTYzOWFnbERYdit6enVwRDNrUFJEOHQ0?=
 =?utf-8?B?MTNOclhtbkVncW1FTXl3ZnpvcXJkNncyZ1JzVVlZRTA5d0VGaWxyRDF2Y3dq?=
 =?utf-8?B?NkVhQ3Byb3BCUjVDTnRSZEZLbmpkQTBzVDR2S3BEeEhGNzNuTTJYemN6RDVZ?=
 =?utf-8?B?TlZqbUlCWXFtMUNvRGxlMUFRb2xlQ0tIZS9NU0l3RmY5SVBac0RnQUJ1ekh1?=
 =?utf-8?B?L2JOQi92OEE4WGN3ZkdpK0xTM0QrbUpucUJwTmlQNmxMZ3BWSUpJajVxSk9B?=
 =?utf-8?B?bW1kVFpiOFNpaU0wdEd2M2VlUThnaXRGbjVIWklzMHVBZlFkRGpubGpsTnUx?=
 =?utf-8?B?N3NQQ3BpMlgwVk05amFra0NZaVZ5dWZJeDFzQ2RraVVmb3pIeXdHVHFWYWZY?=
 =?utf-8?B?VkJuV3c5K0gzLzJRVEFSdVZEQWRqNkdzbmtnamZhSjd1dzdaVVdTTWNNSzZV?=
 =?utf-8?B?Q3hTRHRtWVovVEh3czR4K0lnSHJlcFQxMzZiU2FtZEZMMWpzUnU3VTJwSzZr?=
 =?utf-8?B?RHVJUUhZMncwMmFqVzVSR1FpM09Gc21TbHR6NmVLQmM1S2JISXk1ZTluWWdE?=
 =?utf-8?B?bXBkVXlMUnNxcGV5ZFlHbXlSSEVEalM1MzBBZDBUZFgvV3EzWllVZnErVm1j?=
 =?utf-8?B?MWVjM3RYb0xQWmhUZklNQzNsVEZVVlJzTFhxWVRxZXErQkQ3blhyaGpEQU8x?=
 =?utf-8?B?eFBwOURvaDl6emdTMFRaNEhxQi9xeFVtNkU0blV4Qys0ZXJnLzNSVjZOd05S?=
 =?utf-8?B?UGw5aEIwQWZKT3VpaTJROU1jN3haVVRMbDNKd0s2WDMvU1RwOHNOWW95VGlu?=
 =?utf-8?B?SXN1emNQT2JqOHIwMVRHNjYzYnZ6dHBWdU4vVHVlTXVvanZrUTBqN2VYWDRr?=
 =?utf-8?B?akx1RU5tZWlVcUtJY0ozdEh2dlQ3cUFpeFdBZUdtdnR0TE1uQTUzSkYra2tG?=
 =?utf-8?B?dmxTZjRUcjhWVFAxaVhDSjZieENDOEI2OEpDaWxxekh4RU0vNmFjTStLajhS?=
 =?utf-8?B?TnZRdzBNTDJBNWkvQ3JabXpMOUM0bWYxNURIaWNVVjNhVENNOGNOZDR3SmV0?=
 =?utf-8?B?VDJsR2l4SndmYnM5M3lXaUNFN2xINTAxUWp3YzBWMUV2UU1RNDdxMnJJYkN5?=
 =?utf-8?B?OUpnalEvK1pZS25pOE9kYW45dUREaWpKUHRaKzJCeWhRaTFYL1RmcWZSUjVH?=
 =?utf-8?B?dlQyNmc5WmxWcXg3NkJ0cEY1K244NE5JQUVXcFNwV3ArUVJVd0haZjdRQVNY?=
 =?utf-8?B?Z2w4cm5Ialp5aVBPS1RwTTN0bXdZT25lTTc3Tmh2YVkrd3hEZ3NUaGVxK1hC?=
 =?utf-8?B?RXA0d2sxeW9IVTRtOUI5VE11SDNsS3k3dE5nWXFMUERSZzRONGZ5K2JYckJ3?=
 =?utf-8?B?dWtwaUtjZ0hUcjk0ZXhqTUNMU1JJSzJ4cldWMjRZbWpIT2pqVStMZlV4ZzJN?=
 =?utf-8?B?VlhqUkkxMEtmZHBwZFdEc0lXbWx5NHFzUGtiRG1HbEVuU1pnMzBObExrcC8w?=
 =?utf-8?B?Q3dKc3djR2s2a3gwMXlSczcyRk9jQ1pLT1VVZVNVQmVncFRSMk8vMEZSdWdj?=
 =?utf-8?B?SGRlQ1lYMEJEQWIvZndIcGpJRU5NdDJiM1YzeHEzY1Y2bVljQ0R5YU1wRUhX?=
 =?utf-8?B?WDNYNVZjd0ZFWDJ1NDlJVGJqOWNsVE5Xa3hRcFdZTlI4TUZZajVhRElXajBp?=
 =?utf-8?B?ak1YT1BhY20zQ0NwMDJOMFZSamhJNC9YSHo0RkkzYXdkSEJXNndPSkt5ZjV6?=
 =?utf-8?B?VmtINjRjcS9BUUdldExmN1JiMi9nUnMzUlFEWHp1L2EvS1BMSldxaUFmWG9K?=
 =?utf-8?Q?RFIdf1qhkaw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2RWbXBnbXpPRzU1NFRON2NYTDFLVWdGd3lSMmNrL1dyV01HYUxDTW9DMFRH?=
 =?utf-8?B?UWsyWVBBakd1eGliQVpoMFRVL1JxNi9WL3gwbW9qNXppVXFWd0l3ODNaSXFR?=
 =?utf-8?B?UnQ5dUt4VU9rR1BESVU2aEJkNmVxTmNuZE1PTDIvSnR1d1ZYMHU4d2ZBWHFW?=
 =?utf-8?B?RkJrbWxPcFpmMHlLSTZ6MXRQZHk2OUFKTVpVY0hTcWpZWUtybnBtajFERUZG?=
 =?utf-8?B?V3Y2SzQyK0NaRjRGcmhtL3EwbVZiNS9aZi9ESjJxM0o5cFQrbzFPRHdvdUht?=
 =?utf-8?B?c1ZtTUs4aTlzcFhWQkc2QVgzNm5VSmtYSjcyZTZDT3FoZFlTTHFxZXZwV25S?=
 =?utf-8?B?RHFRRlFVaWgrTTBLV1NOeEZhOGlFdGgyRzRRS3dVQS8yNmI4cUFvSTN3dWc2?=
 =?utf-8?B?b1FnbWpMdy93bUZGb2tpQkc4cWRnUGQyaXZFaGxzbldKQzZYaFFsVzBlbkI1?=
 =?utf-8?B?WHhrdlV4MVVaQTZRN3IxbVpaS1lQcnFETjhyeXR4VHFtMzg3eXYxMzFqNXoy?=
 =?utf-8?B?V05ld0Q1VzFreEVGTFVKdEU0czdXTElVNk9ic2dVcnp6cFMvN083bjkwVXpy?=
 =?utf-8?B?MnBKZmxwakswRVFjMSs5ZzEwRU8zMnVUWkNGVlRWNHcvY3lEMlJrTnJPWHM1?=
 =?utf-8?B?c0lxREJvaGd0L0JVblVMbjY3R3E5NEV6dEJ2WE50MVBrOHRUK0VXQzNIRXBx?=
 =?utf-8?B?UU53STlRWWxic0pyWC9uK0Zabm50U2EzWVVxTzMxdmZSOUdkZm5DWTl3Rk5R?=
 =?utf-8?B?elpzWkc1WDM3dXc5cVdnWlFCZVR4dHNvQlFUKzVKcDU0cldSMDVUQk1PQmVn?=
 =?utf-8?B?NFVRRGJNcE9idGJKWlpyN0hYWE5yTzJZdXV1RCttd1A4cm8wcThvdFVRS01C?=
 =?utf-8?B?MmxxY3FEWFlmMUJJc2ZkdEdOelFsYkFMeGxjWnlQOXNxQTYyWDNEYVJXdTVE?=
 =?utf-8?B?TFBzV0FYU2pwd1FSTkRQRXBjUXUvck9GRnNESHY3QzZxS0wrVk9HL3lLaitM?=
 =?utf-8?B?aElSbkIvMHZDbVdBNGsxZkNYMDRHK3dtR25MYVh5TlBTS2xFbE4yWU4xbkkw?=
 =?utf-8?B?djA4d25iYVFOWkdBKzRuRFpxOGxhd3VEZnV5ZzJXZjcySlNOWTl2eWVqdUVI?=
 =?utf-8?B?Mk40Mk5JbFFNY0JpME9qRllURnRVb3FmeURCd1hReDFvVXkwYzEyQ3ZVa3ZC?=
 =?utf-8?B?OVEzdmZOdUVOeEdldDhpNjhaK2xKcnMwS1FkSnRMQllXdWdlRUJaVnJOcitS?=
 =?utf-8?B?NExTQVVKcnlYM2NVQm5VOEd2ZzJyakptMEoyUUhxSGhoTzMrL1JOMU5SRTF1?=
 =?utf-8?B?cmtaVE83RVdPNGk5SE1CNHo1MXEzQjduZS9GZThqVDAwcnVKQWFTeHZ2R1Zm?=
 =?utf-8?B?c0VLK3RQTUxtTXVwT0JwY2FHYnRzQTZIRU9FQW85Vld6bXpFemV4N1lFcXBF?=
 =?utf-8?B?WEVRZ0ZYMVVxb2pPZURtTVh4Y3gzQUNmKzZpM0tVRVhwZ282TFEwN0UzYWZv?=
 =?utf-8?B?UWpVRkUyb0dzejFqWUdCS2hKUktJdEdicXJ4WGlPZkN3d2tIVXYrVWMxYjFS?=
 =?utf-8?B?SUhTb0dJTmJYSDN1S3FaTDhyLzhkTGVqUllPemc0aVRuYXlkVEdDc1RWTXBk?=
 =?utf-8?B?elM4ekZRRnduekR4bk80cUJDQkp1UFBnQ295L1BOR0pibHc2aGFVYzhGVkZV?=
 =?utf-8?B?YlpPeEltemYzRWN4Q08waExWaFdhQkNJYUthODJWcGdJSjRabjZpODByclRn?=
 =?utf-8?B?MldhL3VCYXpNWFR3RkU2alVXM3VhR1VEdlpaRldvd29ZdUVYYW1kT2k4OTQw?=
 =?utf-8?B?bXZDL2tWRDdKVnEraGRvT1R2RWxHczJiK1dKcEFyYlVzcU5ySWZraEh4NEs2?=
 =?utf-8?B?NU1ncDJvdFVYQitDcU9BQkY5aDRUbFV0TTVVMVZ2NThIdHdyUk1zejA3ZURQ?=
 =?utf-8?B?a1Q4RTh3cm52MW11b1AyMzlBS0FBVDNxbzFRaG0veXo3Tk9WaTkwMTBoMWox?=
 =?utf-8?B?N01BS2UwTWs5and4TlFXMUJMbkNxZEMvYWJrR2NaOFB5UzJ3RkpHdVhjckcz?=
 =?utf-8?B?QTFJb1NXR2hpRmlWUkJHY3p6b25TOHEyeUZrZGJBU01xSTB1TVB4MVA3djVW?=
 =?utf-8?B?Q3h5U2crS1Q5c3F4N1BadHBNY2ZWWjlaR0lzdWhBNkk3UjQwc1hLSWptOTgy?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s+4s16Nnz7+0/gFBpb1wuvbXIpOc35C2ppSjRev0xZA+XP8iqvE7ktm8UWGrUaQbpobPKk+vmBxWHTfmGPnwQv9lXCTdsPbWnE2HPmGNKa87UzivTmNdBOp/nKoVfEH1WL1KrITbmGD3sF/mwhh2X5+dLyoAfE9PVfJZ/E8rYLpi7oa1FYFjkVEkCDJzLKdVZ4NIQ/I6XuSU+tMZYYIxEap8mPah9utgzFigyEcps+InEF5JyYTJclEbw+Xooh3QYy8pzOilY0DwqP4FPZ4BXszatRh7/eotdCUa++mrYVJMOo1xEqaShrNaRgB6/DzlcE3MP0mv4pdWlWn7RN+5s5A36LlSQEdJOP8HQ4R/sbSjX+/H27RD2H6FoHVWm0QXHVlkPI4TcPF/3cpeT9Fg6CAHKvAnGMV96mlvloQRUn6KYGyhI6stZEuE41g3UUf+5yQON0BiilsNncXBHanVrak4dw0aZ6Ou55gev61tHeQTmMNRayKoeIkFZLfqxVbG2GfGgWEijl6fSAX17gNr/oXJOV0w4i6Rb96gCdxdoSPL8FNC3u5PpHCtCObfRqHSn1khlBD++8kzY4lTd/aaVYuaBH3bHJAKcl5hbXPile0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129c025b-eeca-457b-745a-08ddd657df65
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:45:05.7510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBwy5F2RJwxv0MZV+tTG2HIYxNSigD5bv1gZyzrtBKHEKCCX3PT4OrHEPYM1Uuw2+Ggc/FOHuNwGXvnKIrXG/u073RvyDlEPAnr457+br3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 mlxlogscore=978 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080071
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6895b91c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8
 a=G3LUnnKrErrm32wFjTMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: kONplHuqWbddzV0k_labylUOAY1WlTqr
X-Proofpoint-ORIG-GUID: kONplHuqWbddzV0k_labylUOAY1WlTqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3MSBTYWx0ZWRfXzEyr5R5atjdj
 MQfrUrlJ7QmT+N9H3WaWkpa1tzNNt4wOAFd+4NIpnR19ky9PqvhU4uCscbj3ApnMSaLNSVFpMtj
 wv4tBdU0Ug5myyYvlXNLMSeX7X3wRH046m7jRjUr9kgW3jlONawRjxobBIcmdJXOP58fR+7oNuS
 aUtPesUoJsH9gQkyeFAOdFVHO2t4244CNWIgbtXsENL1eghUbkYmH6+WTpwkITNk+jIeTAKIwO5
 HsB2f8HGDfW6kj2TKq1mLYe5ykb2DFAzuMEby76YryRpaGf2qZ1uH0jBJ8Itw4e38rtGwNC7UDc
 LHPJ7KQTkxu/8DMCdeVQUAMB9SLnNZzZum3IH9q2CRg21splup9eyce6XD5P1OoMapUZXe2GiAX
 XKlCnCdgxUtrYmDzTYYnhj2OQ09tevrflRv9j7pFyLx50q7mG/ik/nVyh42N9C+pZGuTh7iG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 08/08/2025 05:09, Zhenzhong Duan wrote:
> Commit e46883204c38 ("vfio/migration: Block migration with vIOMMU")
> introduces a migration blocker when vIOMMU is enabled, because we need
> to calculate the IOVA ranges for device dirty tracking. But this is
> unnecessary for iommu dirty tracking.
> 
> Limit the vfio_viommu_preset() check to those devices which use device
> dirty tracking. This allows live migration with VFIO devices which use
> iommu dirty tracking.
> 

The subject of the patch is a little misleading because LM is already allowed
with VFIO devices and IOMMU dirty tracking. Yet the patch is about VMs with
vIOMMU that get this blocked due to VF device dirty tracking. I suggest instead:

vfio/migration: Allow live migration with vIOMMU without VFs using device dirty
tracking

... It's longer but I think it rings a bit more honest on what we are doing :)

> Introduce a helper vfio_device_dirty_pages_disabled() to facilicate it.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

This is unfortunately not enough to unblock vIOMMU migration with IOMMUs.
Have a look at the first four patches of this series:

	https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/

These 4 are meant do this (41d778dda00^..d27e5a5db5f4). Feel free to pick them
up. I hope to take care of the rest of the series; though I have been heavily
preempted internally that I hadn't had the time to clear this series but I think
it's finally coming to an end

The gist of these first four patches is essentially that we need to query the
dirty bitmap before unmap, and we have an extra optimization that let us simply
read the Dirty bit (without clearing it) and so the query is much faster as you
don't have a TLB flush.

I think you can replace the fourth patch with yours as yours it's much
cleaner/simpler.

Mine was specific to IOMMUFD given that perpectual dirty tracking (type1)
required forcefully enabling migration to let it go through. But I think it's ok
for both to work

	Joao

