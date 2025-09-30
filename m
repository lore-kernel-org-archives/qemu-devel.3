Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043CCCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZrT-00071s-OP; Tue, 30 Sep 2025 08:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3ZrL-000709-2h
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:53:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3ZrD-0004ST-9B
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:53:34 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UCOaq4009186;
 Tue, 30 Sep 2025 12:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KOsQSetTaO3oHSun+FTh1aWIQiklVzBD3sQ34seqcAA=; b=
 WAmJNfXq08jHeqifNjJobXGCyedl+4C2s0wbmGefrAg/aGxLjv9HMWh2/GbqsV7L
 XlN67an47jOfd8GDUvC1IErO0abZQt+BWuGpHtCkB5IoIE7TGJyI1BHVl/3i3taT
 aB+zk/Dd/D6VDg687E3Nv6QKtwt0QtbHhn1bm6aDIFfio9qQXiSIUF/B2akdqjc7
 g810bCsfQJtpVtcWiJMC+A2f+Y/ny20PrWGTuEDLd00/wXzdesHiQjt/MxHC1S9r
 HJcvmndqUEtDuEwgBamn25Q0eBTCdd/ywFoL7FywqqJ8BasSP4UTgsDW/Wxna2uO
 jbVELPBzsrVYY9fyx/grFg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gf6b02j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 12:53:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UCaXYZ000585; Tue, 30 Sep 2025 12:53:20 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c7shf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 12:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED4e/zz+4zk0BIxaz4ztUHojj8g4dwTM1f2vDHfa/NjNc759wXYh1Ksl1YP7hi8Txn68+ww1b5tN7JLAGmaZcoBPHEmjOuYOpmFd7oLtmmZTkXnsF2irwn11EOXf6JTzNA0pJuDJfoypLOkekG8heR7+vpnMUSMAPHEkti5eG2aYUGDyXEDXcGWRJ0rx94dsLrqGvxIcOCtnR7nDaZLzVCZVY9vQLoJtVNC91PmwsbiJ1lRWU32PLGXlGcbu0SijGQs+TjufCpS20vmczeU6GHKBoNxBnTBU2PmY6SD+R6O2VS/G7AMT0IHTp9Lj9+/GQZ5O6Y0ioqHjaIjS7VH8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOsQSetTaO3oHSun+FTh1aWIQiklVzBD3sQ34seqcAA=;
 b=VJjHIa7KtSsI5i54clxDoVGVa0326MhyY8UQ54nnvAYI1Gks0Q1A2DDllRHrCJidDqxyixCp0igNW38qmtQ08vaXzBDoAv5jcgBocZw9G2ZDQtYIRJxd+QSbl0WzSZEFOxoTNAGZ7sVhR2Z9Xjf79Q6X710Muzt9hXcmd6DSPcsIBLr88fNON69ahbJqBRgdnCFSWcKTinFHuT096JpOx0LxR6EW0jYsQkbPOeu4zsPcjkGZzckJeesrJ+QqSsWt86hYEFf36JyF3gC7Bext3rFy45NmZl0NCe8G3B9k0tB6FKaZI0GGl8EKmHbB9UwVRa0/xq66b7maUH0OYZbGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOsQSetTaO3oHSun+FTh1aWIQiklVzBD3sQ34seqcAA=;
 b=oMLYjx4qajQee1d+DK1Zr0OCjidv6zZ3Q76vR6rQ0Ebt23ZBWX2KYzXpHuZZHON4DxMXP9510STG55Nv+t/JF9CJG92DgeCgWWOVOQjM5Lx/qfH/ZyerUabR+eJ5m9d1KWLeSaOKExnDqWYIlj9NcwHn1zfuIMXGfKehoJrVOKs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 12:52:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 12:52:56 +0000
Message-ID: <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
Date: Tue, 30 Sep 2025 08:52:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:510:325::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM6PR10MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd4cc5d-1e1a-4977-1ffb-08de002046d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEpORmxMQ0d4OW9jM1RTZlFURU9IUlRNT2p4WFJFWUEyVVFxeGM5eUNDVVla?=
 =?utf-8?B?NEJTNHhla2VUbk5JN1d5blhCRjJQM1FiL2FTUHpFR0FDNEJnTFN5azlsWjNm?=
 =?utf-8?B?RXd0USthaUYzMnZsVkJsQjRyN2FQR3hSVWUxeVpuc2s0Q3FHbDZXdmsrUEtG?=
 =?utf-8?B?REhjNWFoRFJhZmFUM1JPRW5hRUgzSUJFYzM5K2JuZkE0Y1p0YmMvQkpZYW9G?=
 =?utf-8?B?bHJSWEg4ejFIa2VHblRjd0RRTE1kSlNEaVVGa3RESE05R1FDZ0ZyL2h6Vldn?=
 =?utf-8?B?OEF3ay9Kb2xuM09ieWtNaUtYRUwvMlhoemsvRHNlMi8zeXA3Wnp1WFowSnQ3?=
 =?utf-8?B?T0JWbkprdDJtS2lWUllGcEYrSHhSUFJkS2pkYVNCbmNZdWJLbkhLT2VVYzYr?=
 =?utf-8?B?aXZmbjc4R2crVjVadXNDSWRvcUc3SG1rbGdZb1VGZTdWSEwrRHZlcE5zTFJG?=
 =?utf-8?B?eGRDSWNWLzYrK2Y4b0RzdExuOWh2ZXJsRmxJY0VmM2pBWWhFdll3RVh0R1Mx?=
 =?utf-8?B?U2Y2YXBEZlJ0WFc5L3RlS2xwbU0xUEhONGtyNVlXUWFoelVZbWk5UkdCVFk1?=
 =?utf-8?B?WFRMQ3JYaHNVN0RqT2xzUjZKRXZxVEpHVFkxcWR6ZXRTSFpmSTliVm9zaVVk?=
 =?utf-8?B?V2FiY2hhcEJ4RkVFN3gxK2hvOHRYT1BwWjBmanJvYXprMHN2SEsxSEp6Vnk2?=
 =?utf-8?B?LzVaSjFTNEFOR2lRb3hWdWxTNFlnekxnRXBMV2JPT3VnM29qelpIZmRjcDhh?=
 =?utf-8?B?VDFlYURQT1A3WVZsQWthZUdRdmJDb3B1M2NRWmNUakhieVM1ODgzRWpaRmZk?=
 =?utf-8?B?MTl2aDQ3ekNQakJXS2F4TndrQm5XdkFMYW43UFhWMFl2WHR4aURPOHREMStZ?=
 =?utf-8?B?OE1xWGl0YlNBdTlJWXhRUXJqZG5QOE1sSEN3ZUpsdjQ4YTE0cWliekM2SGIx?=
 =?utf-8?B?NG9hQVdQOTFGZWRPQnJKd3J5T0tpMC8rNFVENTBrYWFiRkRyRG03V21mZStl?=
 =?utf-8?B?bi9CczJ5WmVVRDZkMGpoYlRlbmVaTGNmYjVXb3UvVzdlaGtPNjVnUVVHaFNk?=
 =?utf-8?B?S1NVZUpVN3J6WmkwTkJyYTVleFFTNUNYOUJUTElFVnJYTlRxOEpIc3MyRFpj?=
 =?utf-8?B?SWZKeHVqYmwyZnVVRXh6Q0NrNlB2WnBKd1JjMWJRaG9HS1ZhTW9kSmtJQkth?=
 =?utf-8?B?TTNrRUQ2UEFOa2xEWDBHcDdPNHdOTVFtTWFkMWZ5MXc5MlQ2ZEsyalFJakxv?=
 =?utf-8?B?aGtsdXFlUkJhQ3Y5d0gxeVFBYlNiZWR5aDEzclh6cGtKRVA5QXRGdHVzZDA1?=
 =?utf-8?B?RUNBVVdKMWRBTExXTHA0Q0VoMnlxKzNnOUpSMVIvRXFwaFZkRDBEUkJJVzZl?=
 =?utf-8?B?dDNBaWxkejVtOEcwYnNIVDBpYmdoNzROZFJvMGhCQlNQbUxwUFlUUmF3Rk1R?=
 =?utf-8?B?RnB2VE9BdWMxa3lUdkxqaHRPaEtBTXI4RGdsU2Y1cXNDVngrbWxldnNjTDRj?=
 =?utf-8?B?V0dyNDRMRGErRjhJTm9aNWt3NzVKK3NKNHRaTlh4Z2VhY1JEMjNxZ3hUSk96?=
 =?utf-8?B?N21JVCtjWnR2cXRuMmx1MDFKRzY0WTZNTE5MNFRXOVRRS3cydFhEbW4wOXJQ?=
 =?utf-8?B?Z2h5TjhUcjgwbG0xT2xGb0VyQlhPQ2dWZy91Nkl6T2lHTTFIWG53N05pblNI?=
 =?utf-8?B?cm1QditqNlQwVFRNR0NDK002ZTB1OFpSN2ZUUFBiL3kwNVZDT1A2amlQRTRs?=
 =?utf-8?B?R3RVTElqbGNhYW83dkxJSVdwL25KNzdRcVJWaGkxVUZkeDY3Zlk1UVdDMlE4?=
 =?utf-8?B?cC9jbHZpTXFWUlFhdlNXeFVtUEZqOEtXOW8zdHd1NmJqeUFEM2hqeHg2MXZF?=
 =?utf-8?B?Uzg0TVVJajh5MDloNFdveUNGK1FOandOQUcyaGFNNS9XZGhUUXEzcDExRDJY?=
 =?utf-8?Q?X7SXyy8nyN/h/g3aSoAFVHW0Q8/1TDmp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnd1cU1RUzhVNThOZE1vZGJTWHdBQnNJQnFjRE1PNTNDM3ptbEorZnlHOXBj?=
 =?utf-8?B?ak1LWnZEN3lMNmJjQWZ3Q3VOcllFeDBEZzBvWU5qTUtvT3RoTVNuQ1ZOdHMw?=
 =?utf-8?B?MkN3Nm5VazhmdkxTWEJjTmFUTjREdGVGZ2J0QmJMUnVoUUVmcWpzV2RNZHJp?=
 =?utf-8?B?TzdscnNDbm9yZUIwanQwTDFrSWFCTGdGckhBa3RQQkVUTHhGV25DLy9MTXZD?=
 =?utf-8?B?Nm9lNXBjOC9oK3hPcUVLUXYxVGtHWCtiTlF2RWVEdy9oUjBwYzBQNW9TaG9x?=
 =?utf-8?B?OS9DOXFMYkZqV25XTXpwU3hFSkVPM2FKWHIzV3NBVGo4OTJWL0pjNVlneUhN?=
 =?utf-8?B?NFRkSGtEVU9sMFI0MVp5a1p5dER3dStwTXZ0SmVLWCtZUC91ZjNGdlBRUGw0?=
 =?utf-8?B?d0N5TUdwUHhmQ0tKcXBYVVlaZ2tQSklZREdvUTRFSlNtUGZsYlhhYXdHMnha?=
 =?utf-8?B?MHNXTVFKdXAwbjcwbG0vbXhoYk45SHVFMVFWVUk5YVlHZDcrVGpPMzd0Y1FF?=
 =?utf-8?B?cU1oZEk1N0FoZEJuM3A0NkJLdHdvLytoZG8rYTh3MGFoMk4yQi9XdEM1Qm5a?=
 =?utf-8?B?YnM0RnJOY08xRk4xdzBtSExsakxCQ1BaR0FhTzhFaEJJUWRzeFpPeXZZaGtM?=
 =?utf-8?B?Q2RNQ3RTRjg4anJUckF1SnZHS2w1YzFWUkxodnlZcVdTdEFldGtzMTlYK3Uz?=
 =?utf-8?B?QnFlbnNseGNIOXRwRi9oRnNDVVFQOGlQb1NwdnNWVk1FTFVJekdwQ05YZFBq?=
 =?utf-8?B?TjdVVWNMWHBNUElhZTRjKzMwRTlkVi81NUM1S2Z1c1lqclduUXJvbXZNVkNF?=
 =?utf-8?B?aWxyeTlrdy9tejVSQkVXWWgrL2s5bGV5Zkw1TS9veGhlWFNFQ0MybXM2Wk9R?=
 =?utf-8?B?Q2Q5R3p4OHhpcnhqUkNKTVo1OTdZVmlxTG9QZnczQXF2R1l4VWlUSmZOdVFY?=
 =?utf-8?B?SmhpYTJKL3JEWlgzNmV5UzdGbFJKM1NJQkxCUnJObGs5b2FkTTJhNGRCTVBa?=
 =?utf-8?B?RW1UeTlENk5jU2hQOFlGQ0pPUnNEbENibVBGa2QwUUNGRHQ4dE5wcWxrQ1p5?=
 =?utf-8?B?TjE2S0ZtU2FIMjU0aDU2N2E0bHJ6QWM5NmpoZEY1Z2Rqb0xCYlJWQmZWTXA1?=
 =?utf-8?B?WmZtMUVhTHVMTkYrcXhEdFY4VzJvdVZFN2ZrM3l5ZDdEKzlRYjl2SjlLYlNK?=
 =?utf-8?B?amVBRm52MFdONnVkYXhrMVRySU5zbysxZyt2VUV4OW5KZjVRRkVWb3JHQW9M?=
 =?utf-8?B?UkN5eFZTLzdWTXNqOHEvMjNkd3lDcGgwcFVtaS9LMDFWTXgxNDZML0h3K2d2?=
 =?utf-8?B?bHlmMG9LWW4wYXpmSk9XWW5Za3AwUTJ0ZkJ3cDI5cmloU3BvSDAwdmttV2xV?=
 =?utf-8?B?VmhISW5Ya1VMUzByVDhRSllvT1dvUGhZbGhaNkNuSTdjVUxqeHFpMlBScGU1?=
 =?utf-8?B?U0x6YWR4VFBsVENpWlRhcFJ4TGJQZ1Y3bFVmajMzYVZjZi9vejlvV3Z6dUgy?=
 =?utf-8?B?ZGw2ai9sUEhXWi9VWkkxOVhJSTZ0a3ZxRlowOUVCell4cGxwNExJcjRSemdI?=
 =?utf-8?B?MzVjaFYwd2QvSnJhVmV6WERyZGdHS2dWUEdYYm1ZV2h3TXN6MHI5MGp1QTF1?=
 =?utf-8?B?dFB0T3Mydm5ucUdrdFF6TzBGb2o0am92SlZFUkU0M2k1eGFYSGFScWZ0dmRu?=
 =?utf-8?B?UGlwN01iUkhVcitXRWVvWHRndGE1NzdJUWJUR1lNcEc3c1psU3hHMEVvaDV4?=
 =?utf-8?B?ZGhqd2ZyNUNUeTFWWnU4Z2h6UlZrNFRuY0JmbmFyWG1xYWUwd1N2ZzNBQmxG?=
 =?utf-8?B?d1hxZ05FNXprTFlxeFl1ODBqRUdKeHZ4UDF2QUx6ZHRQdmlFeS9HanMraVNN?=
 =?utf-8?B?UXhQd0c2aHNNY0sySWVLY1dRUG1xTGtLbGw2L3drNUwvMXYvYkFsN1h3cWxt?=
 =?utf-8?B?bWNJSTM0Vlo4UUZDRGhWRkdJRDRRdm1RRHNwcXlVYkpIUytsYytzNGM0dEdt?=
 =?utf-8?B?Nk4yN0dPcFlaS3BlNS9wL1QrZyttWEdxSDkvblFka3ltVjkzUVM2SUhoYks0?=
 =?utf-8?B?eHoxOC9BWVUvR3B2cldMd1p0UkNKUEsvU0ZSL0tkQS81dHp6Rlp5dHhRUjRy?=
 =?utf-8?B?OE55WTZTN0lGb2hESS9Cb3lrbVliR01BcW5zUCtuT0cyczBwbmdKQnN6R0VU?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0YOiqIipMA7yy3wcWYPS9Lkv7K77e7o61d5hT0NBpPZaoEpv1XSIwxo0HfSQJ0JNpk6x8cb63ZLOCnIZZmGh6M0YsNuwl49TZ5z7WN36+JpiJ8g0FCQRAQOlKFHi+6bdNu4Pv5VJAjKKqXPpZvDYIYCeyaBw/RDFdxu549U8MP+zt6/5zBiThBCQl4XVVXE8XFGXoae3rwt/0zw/bOYIOaHndwatgZpmz/E2Hc4MidtNJtHNgv0TPU6GJquufPOOvo9A+luMHJTQ9XMoGgEDwjpiTPtPM4jraEay774YH8n/vSP0/wbTyeHQWOgA4ePFoFUtboHNWJTaJs3oIsuwjoiURBq5POSLJYmIiGu8uVAJ281HDrE65Gx6luplq5ZQA66nyMcCb47QDSHnqDIOs0TfzQof5b3PN0ngSATDHglVOV6iFnbPr0ydvtv7CvnyWTFBMWXL47926C86tb5bGRISE1LxsLaIYl5Iw3rpHJz4g1IRGP0NrPKbVcpTodYbScwX86glEmOCYrSvGX8zobhxOZLxG8NH/EywQFxZqvpMT11q5UmnZEex30XfQ5r3ENS6zfojf79SmyimA6HoQh2w8GK2i9yiS0vDbWKIgxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd4cc5d-1e1a-4977-1ffb-08de002046d2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 12:52:56.3029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6mDIqhayzL4RTx9I//FczuWQSVmlidBrxP85O8PY5pN0MkUBobEQgqO0zYwHyAH7Yabke02J5U0pOahqH5tOX1NpX/J2vl8c6zHQv2TPZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300115
X-Authority-Analysis: v=2.4 cv=Pr+ergM3 c=1 sm=1 tr=0 ts=68dbd2c1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=6OrfQoSQ54t-xm_i3W8A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: kXtdQWADvt0P81wGpW8OqxAaxlLAdVfU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDExMSBTYWx0ZWRfX6c1I1+J7O8ea
 khlJyf2t0kG37rZrGVFHClKsz/7HeEOXgCCILtMJB5YAIOW73YHnCD5Z3CWsvE/D51fkoI9oGTI
 0NkHOdoVBLQ/9P20VXCQTmo/OFQVzZ1fGWjgpdjgMahWBuqfg97IrXovbOu87sQB0p5QvszfSQX
 X4VjgUGw6fRIpAt8BunnoygIA6lNrRGE+6l8I47tBCBGoiw4xGwd2Kb6DJyEU3u3C3CWICqhaQL
 V+el7tsnBW6/FpbToG2r2YwyQEyOawhnhhsJeGg/j65OTt2nPKHWYzHkIPb3fWHV0cNUwMRvHSP
 wTALrA3c1NC+1bUKPaEYusDHvYXPkdnNrkZqIIvdzjvRp5q64e5NhFnwb6+Yn1JaQRNLAVgac41
 f/UgybZV2uknq26EQw/+5jJW2Sd+ooOfS2eX1/iZRCFFwBhAUoE=
X-Proofpoint-GUID: kXtdQWADvt0P81wGpW8OqxAaxlLAdVfU
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

On 9/30/2025 2:00 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>> "query-balloon" after CPR transfer
>>
>> On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
>>> After CPR transfer, source QEMU closes kvm fd and sets kvm_state to
>> NULL,
>>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL pointer
>>> reference.
>>>
>>> We don't need to NULL kvm_state as all states in kvm_state aren't released
>>> actually. Just closing kvm fd is enough so we could still query states
>>> through "query_*" qmp command.
>>
>> IMO this does not make sense.  Much of the state in kvm_state was derived
>>from ioctl's on the descriptors, and closing them invalidates it.  Asking
>> historical questions about what used to be makes no sense.
> 
> You also have your valid point.
> 
>>
>> Clearing kvm_state and setting kvm_allowed=false would be a safer fix.

Setting kvm_allowed=false causes kvm_enabled() to return false which should
prevent kvm_state from being dereferenced anywhere:

     #define kvm_enabled()           (kvm_allowed)

   Eg for the balloon:

     static bool have_balloon(Error **errp)
     {
         if (kvm_enabled() && !kvm_has_sync_mmu()) {

- Steve

> But clearing kvm_state will make some qmp commands which dereferencing
> kvm_state trigger SIGSEGV. We can expect failure on those qmp, but SIGSEGV
> is worse.
> 
> E.g., {"execute": "query-cpu-definitions"}, below error print with v2 but SIGSEGV with v1:
> 
> KVM get MSR (index=0x10a) feature failed, Bad file descriptor
> 
> 
> I also see inconsistence on "query-balloon" result with v1 patch, before cpr-transfer:
> 
> {"error": {"class": "DeviceNotActive", "desc": "No balloon device has been activated"}}
> 
> after transfer:
> 
> {"error": {"class": "KVMMissingCap", "desc": "Using KVM without synchronous MMU, balloon unavailable"}}
> 
> It's confusing there is no synchronous MMU support but we do have it.
> 
> Thanks
> Zhenzhong


