Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F56C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZKw-0000qA-UP; Fri, 06 Jun 2025 11:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNZKs-0000pX-PE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:50:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNZKp-00034I-UN
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:50:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565NFgI032749;
 Fri, 6 Jun 2025 15:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OYARq/vNnxhMxKH7y6GT9yvlYEVt9P29TKcfyeHjocc=; b=
 nQdrJgHQOJI7wJv1LPaASaAtFJVFfygp/bwaeb9koPTmOK8cvPdeKj81PxNdP7Us
 PlquXQ0mUwddiv52soVtpLjSlnOyW3vJ01FsBcuvxdNODvCqFi6N8aylY6O0b2rv
 wRbOAAP3D/80kz+OMmQl66L827hyFOgI0AaVzzimT+UC4/bCHlK5p3XD0oKuJQN0
 HoinB+6ALCHZ4Ips4ETnHZSX3VWWXxhiX+ysaY3tgt5cvBgEF9exdHaeDwGENDt5
 nCDpTbtA3nWIsQkax8wqArakwguuxWUjJN7+9Cwoo3dQx102tjFe9Ot5Kq2Pne/e
 yVnB+uQbu7eiI5hBoP+tMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8d07xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 15:50:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 556FJuBt033804; Fri, 6 Jun 2025 15:50:18 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7ddwgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 15:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjBi4kPaNvyG7Faf85nuLRzjkUv9BQUZRQGsx0DTdAa0iN43BgQzS2pmjJheUS891Lfu1EotvPJN0S79zNF8vHMVh0QkejUR1e+2AWih8RGDYYQOqtZrN5FFu984QQhIEbvPFiVWTOBmPU86fZ0vmyZ3tvhFTu3xi++IM+NdY5glXQebkKtjccAXIL4L6CPtWWYIscAqQkh71QyO2SDP+YaT3VQFjds/09gcVygRboT5ljBSis8d/eEBf3HucmgPt5m302uQdOWBPV8dtfGdyXpa/b+A6omfSWIqaKFFEUIhaVab2K5NBdBiJ+abDt4CvczC9V2/yilvND/SOoeToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYARq/vNnxhMxKH7y6GT9yvlYEVt9P29TKcfyeHjocc=;
 b=o45GOylhNDg+7++65ZAkpuUvehh/6OzEzi2SLQcz2YFxuyyJbc4mHRMlXxmKidIHjbydYEr+3/qJjtSlgCseIBKmi1Pj9ymbiFyRaUNRxh1KFbMyEmKlcOx4247utTlTQmIfhLXZlLUf67WrQGyAlqyP/a87Uy32SQ5DpQGReGXTOBzpsWaQmNzXVO9wfDFgxGiGEMRqtv3ipVLxQDplW9CkgGySVtss0Elbe0hEiADuw9SrBb+fuPzoPdZPmacQhPPg7RH5OHdOuI/rt+55HyP3wN2ikT3Mg4gYVmf8RHVdZO1qiHfeHUnESgPxB51rlRlUmNXvXy0LcV/cCTUXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYARq/vNnxhMxKH7y6GT9yvlYEVt9P29TKcfyeHjocc=;
 b=ITqj72YStr2R8rlRAERW1uIq4NcOCLB4L7vRTVZdMR8Imipe1J5kPPJFYPxdshoP0vqE0ENvUJPjL78QAurazBJ2Qi3yBSQB9ku40UqeaUUs/IPEP27Z5ZQTRfXATWpMEUmvcrIkH+goRPD/mSN17tnHbkM3Z84YxaQLHJfzupU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6240.namprd10.prod.outlook.com (2603:10b6:930:40::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 15:50:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 15:50:16 +0000
Message-ID: <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
Date: Fri, 6 Jun 2025 11:50:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aEMMjtsKZLX_Bi03@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: dd74e3b3-1c66-4ed1-8d11-08dda511d4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE5TeU1KWE9nRkhwbkp2UERxcW1iU1NxRk5HeTBSbUNwMlpPNVdDK1FkR1dH?=
 =?utf-8?B?UCt5Z09sYXlYaDhlY0huQ3JHN3VHMFJRK2pGdi9hRHRZU2xLVDV0ZW5FNTh0?=
 =?utf-8?B?SndEZm8xaHhZTEhXNTdZSzF2M2ZpSWJhWXk3SURTV0IrM2d3TEVXcU9USEUz?=
 =?utf-8?B?bGNUYk1CR3NaRnJpNmYzMG1ZUEVXY2ZoMTJFV2MzaE5vQUk4S3NjQThZMkQ0?=
 =?utf-8?B?alZpdlEvaWZ5N1R6ZU95eDhyRG84Zklsc1NoVktxUi9OczI0M3Zic3BrZFR2?=
 =?utf-8?B?UkxJWFdWNXoycTBlNjZhcHJNTm82ZnFTYkZhcGtzS2JUNDBjSEZneEgvOHlq?=
 =?utf-8?B?RG8zRmlaM1dxT1ZMbmNnejhiSGdpWUhwV2czb1k4NGJoWldYcmRJZnFrVFJ0?=
 =?utf-8?B?Sjhoa1NxSzV3UVliWktsdnJtZnljb3BCYSt6SUxPd0o2eldDNkVlREh5R3Fj?=
 =?utf-8?B?dTgrWC95bEdNKzNrOEYrZnI0WlM0UTJHNW11aElvaUd6dG5iZnllM2Z1TGkr?=
 =?utf-8?B?OVJqL3BMVktqVTlaWWhiUHBTY0JsRnVOUG41ZHpGeXN3VnhBMjZsOWMzRmN4?=
 =?utf-8?B?RjZadHRrTTJNRjFVSXI4dzEvTE11Qk44TVBncjU0Yzg1bzRTRnVyWHRRNUVU?=
 =?utf-8?B?RHQ1b1ppbTdOY3VxZ0E2amVXeHprSEJRRlBVbmlzVWx2OGh5L01ZKzFaVlZ6?=
 =?utf-8?B?MDkrenlmenR0YWptTzJWQ3JRTXgzOG5ENm1aNTF3SmFkUHEyaEVpMDAxMHg2?=
 =?utf-8?B?bFh6aUZIbXB2SlRvZmwxRjlYL3BIWXlmQ1BDNFlBM1laWGVjajROVXovUDJ6?=
 =?utf-8?B?eUNlSnFnb0JyUXNtZFJ4alo5MXBRbWd6ZE84QjVtWnJTbjZmbjNseVMyZnlL?=
 =?utf-8?B?VjNaaHQ1c0JxV01UenNsZFhHMlRSckJMWUFLRXA3ZkszUHdMQWVoNGpOVVpZ?=
 =?utf-8?B?bXVhOExMVytrb01kSHV5SHJ5RHM4bElycFBydmd5VzlEVlJ4YjVJd1hDWEd0?=
 =?utf-8?B?L2hJN2IzQ2tMaklId3pZaGJFcmtVdTZoOFlqUmZ4Um9CSlBFUStjdUpUTFJV?=
 =?utf-8?B?M3YrMXcyQ2xkSnFGVlRuM0QyWFJ4UlRtaSs1UVk0M1dpei92TmNtSVFKbmtm?=
 =?utf-8?B?U21TK0diWjlST3VFdmJiV2pwZGp6ZGY0dDRKSG8wSVRZRERPOUU5TWVRTWVJ?=
 =?utf-8?B?TmswdjVqSWJQV3NrY2pxdFpPUkpvdkFwbGtOZGNsenNubXE4L3A3MXExQXAv?=
 =?utf-8?B?UWNJUnBQVjVHNy9jRmx1OEFKRndBTDBRa0FCRTZnOE45UC9NWVlUK216bkdm?=
 =?utf-8?B?MGhGZ2tVRERrdkRUWE1INWJVWUkxb3JGOGE4bkVvUHBZMTQzUHpZN3BaOW9l?=
 =?utf-8?B?N0NIcCtpVElSMm1GMEJkei9EbHlDWGd5R2lvZDNmZzZha1E4bDFVb1FxVjcr?=
 =?utf-8?B?UGpKRmFpT3ZGL2JZWTNkTy8zSkN1eEtmRVozSFFaeTJZeUNkT0dYcWFIcEVQ?=
 =?utf-8?B?UzZqUUNKbWdESnZ1L2NiNE5ZVm12K3pwOWx5ZHUrVEU5T2tGUWRNOU9tY0Vw?=
 =?utf-8?B?Y1dXMU1SSldRUUF4Z0pqYzJIdzIrRWFRck11bFV1YXIwR1dxN2hDdDR4OGoy?=
 =?utf-8?B?R0VwbEtzdlRldVc5ZmpXNXNXQnlYOWwxSkt4VE91Tmh6cFpjNERVQWRSdEdv?=
 =?utf-8?B?ckpZbWlZeHA5UDhzUWNNcGQyR3FObmdwTGxZUFNSdHliTEtraGROdHNOUm1H?=
 =?utf-8?B?aFQvSlBkemRnL3RVTm1PNFF3SzdXL2FqUDdFcW56cmQ3cVgyZVk5SjBBNkh1?=
 =?utf-8?B?SUFPc0hPYko4UkZ4Z203cG5PajZaWVhMR1AxZDI5dFBvcmQrK0d4YnR4WUV3?=
 =?utf-8?B?UndsYnJxQlQzYmtVMkt5SHhHd25kT2Z3bmkxT25ibVNyRE5EdS9mYkk3RVUy?=
 =?utf-8?Q?SIVhjYMKZOg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzk3blh6SGQ5dGtGRi9rbVpIOFVuZDZxREsyb0VTb25UT3VHVXhpc056RC9L?=
 =?utf-8?B?MjNvb1pFbFRHdjZheXJBeGo5ZVliQkpqMWF5QlgvOGRSTnpkWXhUMExTMXEr?=
 =?utf-8?B?MTY3UkNsRW5EWlJGcDZHZERTbUxrSG1lQVk4QVFlaEpyaWx1Y3RiSFZ1d3pH?=
 =?utf-8?B?UVFVSHQvcTdQQ2NDYzFVR3BRQkdMS3hnZ3hlS3NnLzB0VG9IcUZMQ2UyYkgr?=
 =?utf-8?B?OGNJdDRncTFEUElhY1NwekY3dHBlWkhJVEdYTDBnYjVDZGtxUUQ0NUkxb3NX?=
 =?utf-8?B?d0EvcXR4T1NrWDQ0VDM3V2hubFZ6N0tzR050aWFqZHhpYklBMnl6eFR0dmtO?=
 =?utf-8?B?TlVlK3FJRmxteWhLOGpOclVMVEZZdG1VRXdDUnFVd21pcTNuREo1SzdkaUJU?=
 =?utf-8?B?VE5EdkxiL09BTmxvZXl1aVFhb2NDdlM4ZHZlamRsV2pNdCszbjhjYnBXWG0r?=
 =?utf-8?B?OVErVEZYRkpyZVBuQzhnTXo4UzBRV0Q4bXF1aEtyOEFIWVd2RGpoQWRkZkhU?=
 =?utf-8?B?cnl3bCtXM1lRc1kwK05xaWt1Z2pEZnpOM1hjcWR0SEI1VTFiUlJ4MVk1WTNu?=
 =?utf-8?B?azB5cnAwRkoxSUMrbTJHS3QzME9pL2doYXZyNjl6UXFkV3VsZVRPWjhRWDI1?=
 =?utf-8?B?eGdlYkJsTlNhMlJhVFh1a0pwZE1vYnlJbnp3YWxjaW05c3A5MC9YWmJZSmlB?=
 =?utf-8?B?YTBsejZYekVFdnprY3lYcmw3d3JudnFZV2dKZWxrMFYvY3BNL2VlVTN3S3dk?=
 =?utf-8?B?SkVXK1NmOCs4bkM3QVNpN2xyY3lvTWcyQXplL3FUeGROUXNiWUp2c01PMU9j?=
 =?utf-8?B?SllxQk5GZ2gzaUVCNW1NeldPOVIwSXBGU2lVdExKSWM4Sys2QzMybW1VMzF2?=
 =?utf-8?B?QUx1MW5Kb0Y2UHhMZEsva3hXQmt2SFZEc2MvOGxKejI1cjdtaytJNGhTOE1t?=
 =?utf-8?B?TEplcGpwT1JaVE1VRElvbG5TZUZmNklvcGs2Ulg5TWZzNU5LeDlWeXorZ1Bl?=
 =?utf-8?B?NzllMkR5K3I4SjgraEhhQXRqcUZjN3JZcHdJa1Vaa0RkNUJOcnBaU0k5RGNu?=
 =?utf-8?B?NTJjbkpRRElOQlZ1eXRnZE5RZFczR1hsek1vdElwQ1IrYWhOMFlpYnB2WHZl?=
 =?utf-8?B?RSsxRmx3dWJKMkgxeG52TGtwQkcyNC9YQllTd3RPa0EyWCtZdUtBMUJ4aUtz?=
 =?utf-8?B?WWFuRFJPd1JKNkw5bVRsank0K0ZMMGl1MG5Kc2hKMTAxSlhEOTFSMEdDOGJq?=
 =?utf-8?B?TkFKb1gyaTlEdW9PQkRzZm0vYTJTc1M2Zk9qYlpYN0lTNktWY1dNS2JVVDdh?=
 =?utf-8?B?U3FUT3Y0emNSczY3L0kvMzFlUXZyUGNIdTdZdU9xNXZVcDIvZEh5cGlCVlA2?=
 =?utf-8?B?RktkbmY4bFQ5Q1NueVpGQ1RUQ05idGN6TDlqR1RPVFhxT0ZobVFUSGp6blBx?=
 =?utf-8?B?aFhWZVc0TWFRSnVpNnhDL3FRQjFIUk9UaVh2U1FMeU9yVFR0WDNjNFdYYlNE?=
 =?utf-8?B?ZlhzQk0rREw2T2laeS8xU2Z4bHNvSjRmc0g2Mys0UUdhLytkSWt5N2VROGlK?=
 =?utf-8?B?N3h5d1UybjR1NCtsMmdEaWVKLzlPSzE4NjVIbTVNakkxaTZhVHIrclRRcDlM?=
 =?utf-8?B?TURuclUzOUhxV3hDTEYwWnRoWXRiQzRyRXc3VDNrQ0dUdEErUlhhQ2lkcmlL?=
 =?utf-8?B?VkY0RWhja1hkQkp1eHZnNzk5NkVOcHhyZXJMdUltMHNEOHZCVGNjR2g3Y3ND?=
 =?utf-8?B?ZkxwT09zaXdVSTZLSGF6dnk4TGF4VHNKSzZ4UXh1czhNanBEdk9Nc3FiTmxr?=
 =?utf-8?B?QWZWWFJXQm9GQnc3Z2I5S3hQU0ExSFhkMjJsTzRJbGhZaVpqcWpTK00rOElh?=
 =?utf-8?B?cjE5R2Y0Yk1ORDFsWlFjUFpiUFNFRVFFLzExVjJxSzBQVEh3ZlVHL3BpQXRh?=
 =?utf-8?B?VWYyUW9PUDZYMDlNZHhjbTgwSDd0MldxUHJIU0FIMTBWbGo3T2p1YXBMS0M5?=
 =?utf-8?B?eDd2YnlwZTJaVllmbm9Ja2dJU1VGY0V6bC9oT3VaNzNFYTdhaEJ3TmhtMEw0?=
 =?utf-8?B?ZERDR1dRME1hYTk3aGlzZFExY0Q5a0s1RjNrK1UrQWJHejNQblhEaFQydFhh?=
 =?utf-8?B?YmdKeWJPRDFtZjM0cU9DS2NVbzBBWEZRaitQbmg4M1k4NWducWt3YlQyQ0lF?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aWPZfK53qe/fZlG7sLgveminGWrAv/2koxHvgKNT4M6GDjxAc7dpkDZHX5HXJFUeGHorojcOvR4lw+Y4o64d7GIA/iyeYLoetlXnROMguwtZPMBqlwCC3GIiLL8q5N7hzOTGyWBlBZc9tse1y1FCHb24fqMD5skJPjbMd5Q8/L6AGVs4xGOHo/+NWpigYT9Y7BhGTKOLZMIn9kl9dv9LYoIDJMhR6ntMS1mdg0OBkz/NxjNVbo0ulUkbmD0AOBOcP3hZx5lDMoXdzV6CNVpfDClZPjDx0rtC7dgZndjMGM504chDLJkSYZSdsjqjMhEJE8x0ZpMDhrf+yOMmeu4ndC1nz5ph0wYtKr2YBM5/o9u0tV2M/xRUjZYcE3FN1m/yFSS4gM7xhhptTtaOh4AI0qWCjEvaLL4+4rViALRWtgAjkK0D3DYbnh4SfyMsqhkZZ2zcYk2+P+NbAuCOYStl6oOvcSlLDoKcVHe7In4OCj+5GRnp/dY4Z0iUXbzYDCpCNeiyvATyMFra6zKPfSRbM/d7G8Oqib9tTfcHn4UKfflLrE+TcrY65/gjhZthNL1Cjo7nJ906R5VqAiopXz14pERTAagsXiQgG32FGnxGYGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd74e3b3-1c66-4ed1-8d11-08dda511d4ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:50:15.9477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S7NPRacrOZu2xrDvRoS95OpYG14v/1x05/RbaDECcPmlFsK81YcdM7dwFDSqebALBtMl8506L4ZQbFZx/kENXFjUBicz4W1n1JpSQxjye0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060139
X-Proofpoint-GUID: qNU3TC7lI1keCEYNy_91uM9FzbgD29Na
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzOSBTYWx0ZWRfX1BLJADab5YOL
 RuLQxLwRStl3oQKJ1wnxfQVuLeMoWgSbQIFL3Jbdvj6VTrtr1nZfvhYioY6jOoCNa4gmVfaBfcm
 zKdl3obfXk5dSk7NIjXaJH+wDt1cNvxwFbFC5KGS192GvJkIaXDUMzZjYiq4D/0iR01F7rasGM3
 md79kOVx8hyEAsJYnVfkEXVoV3V+3FT9oSTT+1lw1PcVIpAz8L6+qKZ/8YpUHXsL1wbBZjjb+jI
 w2Qfy3h4kaosEToj0G1uY2DSAb2D/Fb30Lyf6uRF/MqSOX1qZ081fnrUnEp+YLWrJ982wWKx6yE
 jxT0AaV2rQ4ryLyhubUMw6mTOUpMLtUBkPqDJfZSrWm3bwt5Zrx+vx15xuHBhufGaPN48wlPBN7
 EWNHkcJ78e/FiQhdpIBYPxKxvNrHVYN1oMjmoZa3jQIqY8/+WSmhKog+DQ+sQcKK9ivM0Pdn
X-Authority-Analysis: v=2.4 cv=KaTSsRYD c=1 sm=1 tr=0 ts=68430e3b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NFbW6BYMmh1-_ntTPhcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: qNU3TC7lI1keCEYNy_91uM9FzbgD29Na
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/6/2025 11:43 AM, Daniel P. Berrangé wrote:
> On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
>> On 6/6/2025 10:12 AM, Steven Sistare wrote:
>>> On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
>>>> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>>>>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>>>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>>>>> When the source VM attempts to connect to the destination VM's Unix
>>>>>>> domain socket(cpr.sock) during CPR transfer, the socket
>>>>>>> file might not
>>>>>>> yet be exist if the destination side hasn't completed the bind
>>>>>>> operation. This can lead to connection failures when
>>>>>>> running tests with
>>>>>>> the qtest framework.
>>>>>>
>>>>>> This sounds like a flawed test impl to me - whatever is initiating
>>>>>> the cpr operation on the source has done so prematurely - it should
>>>>>> ensure the dest is ready before starting the operation.
>>>>>>
>>>>>>> To address this, add cpr_validate_socket_path(), which wait for the
>>>>>>> socket file to appear. This avoids intermittent qtest
>>>>>>> failures caused by
>>>>>>> early connection attempts.
>>>>>>
>>>>>> IMHO it is dubious to special case cpr in this way.
>>>>>
>>>>> I agree with Daniel, and unfortunately it is not just a test issue;
>>>>> every management framework that supports cpr-transfer must add logic to
>>>>> wait for the cpr socket to appear in the target before proceeding.
>>>>>
>>>>> This is analogous to waiting for the monitor socket to appear before
>>>>> connecting to it.
>>>>>
>>>>> - Steve
>>>>
>>>> Thank you very much for your valuable review and feedback.
>>>>
>>>> Just to clarify, the added cpr_validate_socket_path() function is
>>>> not limited to the test framework.
>>>> It is part of the actual CPR implementation and is intended to
>>>> ensure correct behavior in all cases, including outside of tests.
>>>>
>>>> I mentioned the qtest failure simply as an example where this issue
>>>> became apparent.
>>>
>>> Yes, I understand that you understand :)
>>> Are you willing to move your fix to the qtest?
>>>
>>> - Steve
>>
>> Thank you for your question and feedback.
>>
>> I agree that the issue could be addressed within the qtest framework to
>> improve stability.
>>
>> However, this socket readiness check is a fundamental part of CPR transfer
>> process,
>> and I believe that incorporating cpr_validate_socket_path() directly into
>> the CPR implementation helps ensure more reliable behavior
>> across all environments - not only during testing.
>>
>> Just from my perspective, adding this logic to the CPR code does not
>> introduce significant overhead or side effects.
>> I would appreciate if you could share more details about your concerns, so I
>> can better address them.
> 
> Requiring a busy wait like this is a sign of a design problem.
> 
> There needs to be a way to setup the incoming socket listener
> without resorting to busy waiting - that's showing a lack of
> synchronization.

How is this a design problem?  If I start a program that creates a listening unix
domain socket, I cannot attempt to connect to it until the socket is created and
listening. Clients face the same issue when starting qemu and connecting to the
monitor socket.

- Steve


