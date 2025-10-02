Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A180CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4JdF-0000IY-VM; Thu, 02 Oct 2025 09:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4Jco-0000D1-Rf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:46:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4JcY-0008LC-IX
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:45:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DNK3C015096;
 Thu, 2 Oct 2025 13:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=E4kpTHnTYs6tcf9qq/zLTJ2LD78efLQePQnqetMMLck=; b=
 Cd4XIZWIRyVIO/VuRmWYBHulbAUS5+lvQnUTBDnGppSXuV/1c2OV1wxF5LT0FPAW
 j2BMIFZh5pt98jFyhJ/magKv/Tiu580Nc4Ib05r807EY9SiF2E7mlz0rEhPHsyQB
 nP+rHZ0RSk+vZhx09Zt57gUvmFCDEwY1uyuppum2TAPPqs9pGLFbtPZyQ4KFOu9Z
 MEaQwmYAnyfmrXVd5M9XsiA34iwbC2Lyu/9bC0M2FzhpfsojhA7VzBAP8zJBi5l8
 vF1zU6y94wYRZind/aZbaOgeXVLrwGCdbebxOwf8Y7pwLFCd1n3E4BAKjguMBb4t
 ZiE62XOTEvZvO9rm+B3EPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmrfua94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Oct 2025 13:45:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 592CwRrq004073; Thu, 2 Oct 2025 13:45:07 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6cadbbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Oct 2025 13:45:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkAZ/eoE3Gps2caeyiTxgu3eUXIKGuQeG4Q9VUZpzjVXFpQ63DnGC2/IYoUiUhDJuUBLG5y8FDaX4XOlORUOThmGPcDPC9SW+YsZmm03otCWz4dBDZaWvPFcSwMoCd6iqhEeT82QEqSywhxMH+py22QP+P5EITSry8lufljeHWRp1ETbYNBPar12CJ5E/wH46SwRGj6GMOXp/UlmMHNbrPLi7+0t/ZzX4l/oo/WVRQkIZnwDxjVHVOe1ha6p/nQ1H0B4/8albpORslb+PXB0eJQeNUA4Vg6EdchdnOKt7OLDSmf3QPLOYAvnzMOjryhA7teRMu3AHcmkqpdPqNFzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4kpTHnTYs6tcf9qq/zLTJ2LD78efLQePQnqetMMLck=;
 b=KVxtbQZ+2HEAHhqp4gCjHjF4apW+43hz/gok6wUglh78Wo3dQwJJlRZN3BT2TaP6Lzhc6QnauCHwU36H/E3XCdX2PoOx31C3lJWHObbfSVXh7RzlTSdo2qsEvVM9criguFdRB3VbvrRBGE8sVaoiVzKU/I3ekRfH50A8krrGU74eEwYs+qn6VjeDgU10TbXOv855ohBHuvSTWPM4iLGcaHr2RYo5itfiS4D6wiKzwl6xMKFO6c7u7wMeeLN184lF08uk0LSIsPo9G+wlLBYSJjridTR2phGqaq1rTv/734qaE0LcExG82mpxeA7XgWx1Jfh20SPEdRRN0BK8wcmcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4kpTHnTYs6tcf9qq/zLTJ2LD78efLQePQnqetMMLck=;
 b=njbPn0fMgP2EA889T1cVG0hvg3eG1vD+RFQtPEir2oDJk7iurRBQcBpMGQjY8CJgHaDZIviBG1YO8eLUUoFqK8D1caI6M1PSNX10+eJl7FrG5ZSjnFq4Mz8h8intwX6IF7OW8P1hTkqDPdXo5kNOtskJoaNFejsbEYquz5KGVpw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO6PR10MB5603.namprd10.prod.outlook.com (2603:10b6:303:14a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:45:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 13:45:02 +0000
Message-ID: <b01c7919-43ae-4bc6-97a3-6f739ec1ee34@oracle.com>
Date: Thu, 2 Oct 2025 09:44:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <aN2JE0D44AdV-qK5@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aN2JE0D44AdV-qK5@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH2PEPF00003851.namprd17.prod.outlook.com
 (2603:10b6:518:1::76) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO6PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 81868091-7048-4bda-34c4-08de01b9e2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmZwL2dZNDBxTDNnZDJPMzVXeXA2b3ZSNFc3TnhFT0FES3pxWmpnTXEwNUlQ?=
 =?utf-8?B?M3QxNTkxZW8vemkzdmNmTmxhWFFVV3B3QnVGRjkrTnN5MmFnQkNxQjlNd0xF?=
 =?utf-8?B?ckNieENGQTVPNVA2elNaY04vNmZXOWdFcTdxUklPL0RSanFHaFoveUVJQW12?=
 =?utf-8?B?WEFJUkNIbzBralNSMjN1S0dmeFA2YUZmRDFhNFVzNm9BMXV1d3ZHdy9kaktk?=
 =?utf-8?B?c1RjRTJsZ3U5eDNPWmZORzhIZjkxb2VWR05wOXpma2l4N1NzQ0d4aFgvZFJu?=
 =?utf-8?B?U2dkM1RBcFBEUmNzNlBLNDFyTFhiYThWT0tmOEJxNnJHZ2tjTDdjV1cxK1Ur?=
 =?utf-8?B?aTQ1MGxjY2Fmb0VrMUN1Q2dHQ0hiN294RVlrZWpwTFhZUEZFamVpM1h5NUs5?=
 =?utf-8?B?bEtuZjZ2KzFCN3JYVGZHb1A0d1FhY1R2NjNrcHUyUnpReUlnSmU2cUU3OVph?=
 =?utf-8?B?c2tZOUt6Uk5DMi9EVVdXRlhrN1RIRnhFN0xXWjdXTk9QUkdNa1JIUnE0RDg5?=
 =?utf-8?B?eGFwL1AvOXRmSkJ4dGJYN0tublFmLzhVNjBMcTN2K0U5U3RTaG5tcUpZNWx2?=
 =?utf-8?B?SkxOK3FIbXM4aVlKTkl5bmNVTlc0SFZtQmRENkdIRXFOTldlVHBkeXBBVVVB?=
 =?utf-8?B?dUhLa0tSRXVJQW1YT1IxckFzUzdaVURReDZ5c1hQcFV2R2V2YUt2RlQ3Mmhx?=
 =?utf-8?B?U1hPODR3LzNXY0JIcWN3TXN6WG5iVGcxSTIrRFk0T2NpOG5GOERoRzUxYklF?=
 =?utf-8?B?OHMvMDA3bzNDN0RkWklRdlBPSGdmdUNxY3lqdC80L1BkazdMZGdLWFJvd2hH?=
 =?utf-8?B?S0dsYkFKWkxhVVZPUDRDQWFvclZhQkpjTVM2VnNaZzZFNGROYTdsOVZQWUJX?=
 =?utf-8?B?aUlqV3dCRmxrNlhGQ2pXcXU3Z1BuS0l2R2ZxUWZnRDFnKzdMekVha3pJYnBj?=
 =?utf-8?B?Q1d6NDMrb25tZC9xbHhFSlBhWkxTUlhqWTh6U29FZm8wOWpkNk1UUnhoSFhR?=
 =?utf-8?B?SFdpSFRxTXdMRU9NTkRoN0xRT0pubFR2QTZDOXcxMFFoMGU1MU1MMjkvRGRh?=
 =?utf-8?B?Nk9iQk15K3hsa0NpSDNMODBWV0RKdDEyRzgyZ3BzL3l1Z2ZiVGN0UHNNS0Q5?=
 =?utf-8?B?NnN3UlJNb2NuR2twVHJLZ2Y0c21ObWVaS241bDRjQS8zYTdGdWtJZW1PQktB?=
 =?utf-8?B?U1p6WTFEbVc5ME11cEhZSEsvZjhXU0ova01ramxZYndCQjAwNFVQckxQb2lx?=
 =?utf-8?B?cFE2SjBKQWx2eDJFQktPSUd3blZoT2J5MmMwaFoxTmhsOWFnZENPbFBjV3Bs?=
 =?utf-8?B?U0hTWnUramV1bXk0aG9uOHRLM1BkVGZRSXVKUTUrL0FPbURKQjNNYlRma0pW?=
 =?utf-8?B?ZlZGQ255Tk1RMC9GVmZIcklrblQxRWkzUDA5a2g0YU1wb0hFenZkenlRT21r?=
 =?utf-8?B?UlR3bWFpNlgrbm1uSm0zS0JuNnYwKzZYbEh0K3YxRDNSVXRmdWZneGZnbGhy?=
 =?utf-8?B?YkpMY0h3Q0hCVTJXR3lXbnJaM3pLc0dabVVCeFJ6eWhJV2FBcEFiMk5Ra0t4?=
 =?utf-8?B?STdWVWZBcHd4SlUxajkzQUhLalhXTUtTSHl4OHFPNGN4bjZtaDQyN3AwMTdl?=
 =?utf-8?B?ZCttTE1CazZoSE9yNWJQMUtRTEtqZ3JFMEdYbllta2xocHJRbHNVZHVURkhr?=
 =?utf-8?B?ZUZzK2xFbXlRTS9vRHU2R0lSd2hWSTJGWElVQkRTeXQzaHBIWk1xNGc2akM0?=
 =?utf-8?B?SmdtRWxvRWlNMVBtbDdIajBUNmxXTFo4YlVkYnM3ZExFbDRobUg3dXdUNzEr?=
 =?utf-8?B?Zyt0a2ZxYUdGTm1XblRHNjJSZ3MxNzlpL1MydzNVMG80UWVsaDAvOExjSk9F?=
 =?utf-8?B?OGl5RVdydFZiNVVUL0VobUV1WnNWdkdUQ3FvdzliTmRsY3FYREVUMzVrQ0Rw?=
 =?utf-8?B?eHJOeTJxenlMWHJtZ3lVMWJzQWkxbUFWa2ZvZTF0d0hqaUNLUit5Y1hlRU9o?=
 =?utf-8?B?Y21IOVJLNW93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFTNi9tN1JhWHpBZlkxUFJZbGdSTDFURjlNTDF5RW5QQXUxL3RBRTRxOG5R?=
 =?utf-8?B?UzFhRU5WUjNnTGZpNkloUUZML3BQdnpLNzBEYytlSTlGL293dkxvRWl0WElk?=
 =?utf-8?B?SEFSZy9lNXo4VDRBblluTFVwRitsVEtCUGpBZjE1NVBKcVJHK1hKNXJ3VENw?=
 =?utf-8?B?aTZRVEFzVzlBUVc4ZzVPT3VoaXVKZWZ5WlpPQkNoS3VvWmYzL0xaMWFSbHZB?=
 =?utf-8?B?TllRUnJ1eWR6YWE1c1lIYi9IbFUrY2FXdU9aRTVNdVBueThMQTZ4Y01DMkdI?=
 =?utf-8?B?eW1GWERNaGYvWTZiRlA0TytSbHEybkNEYUF6SVM5Z2IwS1JydGNDVmFzTVUw?=
 =?utf-8?B?YjhYaXNoQVB4V05Wa0VST3pnMFpKVDdSanhRbEpleHZEbjEwaUZzcmtoT3FF?=
 =?utf-8?B?SE5ndG5sT0pyUG5EQitQS2dYSkRFRmJiY3Z0dGRaR3ZkYWVRdUVXZUp3TTY4?=
 =?utf-8?B?YXFwOTZtYlFHZmtOZjd0dUU4bGxYZDNTMU8xV2tiRVhCaXk1VFlOanlEd0R3?=
 =?utf-8?B?eFlDNTJZV25ObkR6dUtOQ2lHM3A1TmNhU0p5N216SzlvRWREdlZaNHpYOGFT?=
 =?utf-8?B?SG5mUHVyeGU3WVpHQitVbUdDUEV1SnlLcTljZDJOU2JTcFlTZURKeG5XZi9z?=
 =?utf-8?B?Vk5LNVc2YVFDQ3g0RWlSbjMxK3NBQ25yTHpJOGNYd1ExYUpkZnZJM0VLVWpE?=
 =?utf-8?B?YXdRdk9aMUpLVmZwMXdYcHBMTExneGZSbTZHR2RYZ1JUUTZMQ3ZOY1ZnelJX?=
 =?utf-8?B?VTd3RjRUUFNhTU1acThPMlQwclYxNXdXa3BDbDFOT2FTNG9nQjgwMGw1S3pv?=
 =?utf-8?B?ZUkzVTErQ2NjYklYSXNxWllodnJTYkllNTJxVHV4OVZMazNLYmY5NXJkRXZn?=
 =?utf-8?B?cXJ1aVFUeGxPMlJsTzNUVDNha0YwSVF6T1BGek1FcVh6dTVJbHl1TWo4VkY3?=
 =?utf-8?B?RTRVQzZxSkVONGVTWFNPcHpROWZkWDJjNmk4NmNYUm1EOVY2VTIyMmFQc0hj?=
 =?utf-8?B?UXVITnVpWmxIV0Z1Y1BoUFo0aC9DN2ozaFJPSm8yNnVMRm1RMlE5bGVQc1d1?=
 =?utf-8?B?Vlhib2d6VEdWVitrT2tsVDQ4ZlBxYVcvcThFemk3dkIyaXFUSW92a0RMUGNy?=
 =?utf-8?B?SWFWNTYyRUxlUEttamFMTkI1dWlNNUFOcDFQTnBYdWkzSW9XMno1QmJEMzB5?=
 =?utf-8?B?VTFoekdrYllGV3cxb255N0RObVF1cUZUOVZCWkQ0WWg0Sis5TjhpSmR1QWUz?=
 =?utf-8?B?UWpjSHk5aDRRWUJ3ZHBiNURnK2pMc3BvN1p3Z1ZnQnN2N2ZRV1h4b21hTlE2?=
 =?utf-8?B?eWp3MG53NzhvdTdMeXlqd2pJcVltaTdsUjZhL3k1eHcrcmJlR0pudXgrRndO?=
 =?utf-8?B?N3dldmF6Qys5Wmx5RExSWlpWYjdvSTB5MWw1L2lUTUIzOUx1VmlkcWEzYitq?=
 =?utf-8?B?enJJUmZjdHc5MzhEM3k2THM5bHNnZHU4NXFLcktYUEFscmNibkYxOWNtdzB4?=
 =?utf-8?B?a0FLKzN6N3AwZUFJb2JJUnZXV2xOR0I3M1ozUWVHS0RidEl5UHA1TVduT25z?=
 =?utf-8?B?VkhnOW5SSDY2TXZJenhidVFSek1laXEvcG1CVktSRVhMQ1hwS21icUx1eWQ2?=
 =?utf-8?B?enE5ZFlBMWFzcmJvdzhBQjJnRUV5L0kxMzVKb2szZTFJMlF4NkxRV01vZm5j?=
 =?utf-8?B?WmlseVNma0xUc0xSSUh3SVIyNENJTGZ4R3VGeWVDa1JhMkJ3dUZFR0YzbmNS?=
 =?utf-8?B?T0lGUkt6SEVIWlFFenhzaThjZ25NY0JsU2w0UjJxTndka0JHNFhBSlhrelgw?=
 =?utf-8?B?MTZsVnZYbkdwVW85bWxvVm5tVjdLSURSZThRYVkrTmtGMEduWGh0YVpHL250?=
 =?utf-8?B?WmJGMEVId3dhUFVsU2FXaTNGc2ZTRkRWMlZyd3QweFhKdmhIWHlJSkdBYXNU?=
 =?utf-8?B?RHB1bm5CWThKSmRWaWVBUmx1R2tOVnMwVmFHcllySWllam1ZMWlBaXNUMkda?=
 =?utf-8?B?b1hrbUZVT1RpVitnRDJxbGZJQUk4UTV4RTBNTndKdnRJeFhxbit3d29pRVNK?=
 =?utf-8?B?UDZaUEtpWGFiTEw4ZC9wSHpUNStPU0I1T2tZNHdWazEvR0pUVGhFbXB6NEdn?=
 =?utf-8?B?eXR2VnI0OTVyaThJYVFDRmVubXlUUTZDQjkrdzI1blh4NVBqL0Q4U0N1UGFv?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jHGgqG1qRzyv3yuLXBky2RYmqCrcypZdar8ZB7PMW+awy1JVF0qXZLFXX9gJtQYvCERbC4/0snqodxIoSxUlFJ4ay62xygZf9zbvB1icLYWxpA9cKLI7JvmqLrFchftY/mzoy+qX1oXgvx6xVOsEUsszq/3IUCM+NEMOgCWsS3UgMsT3VPEIuCmT7aqIwZ9NqUwfW8tff0Be0lx+Kk4+j5MiVPJMq5q/KXZRYQVdwlyaqzvQz10rrnAxbQdnUtqClPmFjdaVU/VvuQPnqsW0f9iLJAy4pJUtbdowK2AzRxu5l2qA3ytbjlwKnu+fFCcRVso9YZ9ktFbvmEjpLqav6C7hsLSRUkuAOp/YwPAhlUkQ4BtG4OxtjKof02+lr3BogyvNNCsELBNEptJaEhVT3+t2kPLuVGUuRfsoOwbcDoIeHkFgWcGTZbPle6fsY3upKASBQsZAjlRsz8CiDYZTIyGcegVGdT5up5DYryifmT/uN/WIoQtc6S4fV8OjlwrjcC2fh5hWx6DMU8QJTApeWCgN56XdI+LqNBwVCxzougrkvdkxrg8QvRKFKbxohimi4X0s9yEKHOUvIUyxU3VcYX6EGOPFqscZTX6BS0p2YUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81868091-7048-4bda-34c4-08de01b9e2d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:45:02.2348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mVA3k+k8LK8qfpApB8wugELYXkpVVh9p8HgYZQL72C82AiUnzY8/8fj1/XzN3lbBc38SsN6yiyJ0jgjVLv2OmWXPMHvtusDrTn0wy1ny+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020116
X-Proofpoint-ORIG-GUID: LDiQtF8MViB3nYhOX0HMotQ580DoFdiP
X-Proofpoint-GUID: LDiQtF8MViB3nYhOX0HMotQ580DoFdiP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE3MCBTYWx0ZWRfX8P67aI1+5+O7
 ElPTJeoVtWw+N9cJRzAFDuPS1XN5Mg30nWudVBFvA0OK0dwmkW3c7QgvX/Uw/WDqmS0sQzCnebm
 5A7Z1J5f59YF9HGfFe38RzwK0MqwVlLOCuOtbGgGKnBRpqyhGZfIdCXZf6m3dRAKzrGBxQ8bc+0
 N7YHW8ucS8FX8uyjDYIwDN3xaQjzsI54KmUst0sJjfWZLJoaFnjNP7d82PQHYmzXoQO4QRYJZSv
 o2s7ecSdIChIBfgMNpvcxHaxLmZT9hG66OlXEooe02ETWqiGvUxJ1a9zzISYyvg+IhWT2q9uu+C
 xLyEytigqC5l86ubTg4zbMLmN5LU8WdJQUJ0jh25rcn5vKjKznD4+oNRXT4IWVHMciMNDOQboZA
 GrqXuc4HHmAcYiMENVOEtv0JWmzl5Q==
X-Authority-Analysis: v=2.4 cv=VpMuwu2n c=1 sm=1 tr=0 ts=68de81e4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=p0WdMEafAAAA:8 a=wqDUOpz7wkOCvpq3ml4A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
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

On 10/1/2025 4:03 PM, Peter Xu wrote:
> On Wed, Oct 01, 2025 at 03:07:23PM -0400, Steven Sistare wrote:
>> That does not make sense.  It already does that, which is why I used it:
>>
>> util/memfd.c
>>
>> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>>                        uint64_t hugetlbsize, unsigned int seals, Error **errp)
>> {
>>      ...
>> #ifdef CONFIG_LINUX
>>      ...
>>      return mfd;
>> #else
>>      error_setg_errno(errp, ENOSYS, "failed to create memfd");
>> #endif
>>      return -1;
>> }
>>
>> Did the windows build fail due to a different error?
> 
> https://gitlab.com/peterx/qemu/-/jobs/11566477462
> 
> See util/meson.build:
> 
> if host_os != 'windows'
>    ...
>    util_ss.add(files('memfd.c'))
>    ...


I see.  So you were suggesting, as the minimal fix, to add ifdef CONFIG_LINUX at
the call site, not inside qemu_memfd_create, eg:

QEMUFile *cpr_exec_output(Error **errp)
{
#ifndef CONFIG_LINUX
     error_setg(errp, "qemu_memfd_create requires CONFIG_LINUX");
     return NULL;
#endif

     int mfd = qemu_memfd_create(CPR_EXEC_STATE_NAME, 0, false, 0, 0, errp);

     if (mfd < 0) {
         return NULL;
     }

     return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
}


Do you want me to re-submit a patch, or can you add the above to your tree?
If the latter, feel free to tweak it.

- Steve

