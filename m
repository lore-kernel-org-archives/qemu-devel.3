Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04ACC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2mz-00063R-JE; Mon, 19 May 2025 11:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2mx-00062z-A0
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2mu-0000VC-Sh
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEW0V6012741;
 Mon, 19 May 2025 15:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0lwpcTld8cTQnZRcwXhBbRw0ArD+FoWSrUKyiiWC00E=; b=
 lhd6nZ5VSMwwNkKy026JRek3wI2mDdCcdSqNDWY5oSgH5RRV8em0hIRDKkmJMrTQ
 Yb4HTPOBCRqUH9ttfwbeGVtYpt16nKjOfpfeZ1n1BcE22X1hHI05EmRaGDHGZP9y
 5DNiatIFC9GVlnN8mA506A/anbfNR3IosxLuk7kYWNn2QejtqRPJng3l/Hgxbyys
 jFGLXdwldHhKjaL4iT18fWY3OL3H4n1hI8hwT0kX46SuZxTbB6em/5hd9erQOcOV
 ZDxWOwi/V1gJptBOlNxHGMiTq8cw5E0VuAEo3hB0ZHglMdibXjaUEZtD5DMmUvWS
 OUEA5r+knt1iUlmUTDai5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph23bdvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:52:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JFA7ZN028878; Mon, 19 May 2025 15:52:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6uvjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:52:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3DWf2YPCMNqGFoGPzfMIEWqgtjA36Np8BYEAk09HvqSXFqJLAm2mXKvW5HRRVmgFU/nlVk/6oc8qNC13m0I7GvURU9dnfo1NzSBUl4kgo8dRelTQ4olUNeyE9Cym2xVQciKxyfoVVSmYlW7N0NpYQj4OpkRuh/O34E/tnO6agVgYmk9rEZ9jr4sZx+DeZaWmaOHIXZga3LQJxMItlz2CbyETrh1dcvwSBF5hkgTOpJuZlX/cE2QWl62rVh2I4HqaKplidp9O6OP4gIepwtIc23d/XmzJNfDDTTwFGbfqNpZNM62BchGRH0DESmIl9MIUCXCCloczGnh/ew7zwBViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lwpcTld8cTQnZRcwXhBbRw0ArD+FoWSrUKyiiWC00E=;
 b=cl5tE3laqBoJWjberjYUoLk75x4TB4yOzkxqyEAMO3DH9xbHpye7moU7NUFjlO1SWNWzaVGwPMcYY0ygCXfmXTFpZIFNwTmvhXw3yMqS/MqnQAPVxCKcdqecIbJ2Zy7iSgW5MMeFd/mGgbkljdkAyB+l/DLUrvV39mutCnK9R0Z+608yUEo9dMVSrtcpE6NbAanOZdVcMTqQXV3hBO/AeJYYkkHu+ySk1XjkdRU1SGmF5/hKwgM/IqfZY9VvKoN+K3RIrlUwS47SAL+vd5RT5TKYk7L6NJ11JEWrvmAtivKfeRlkjxHKVsuM3KGiZdP4pdpudOYcC7VFBMnsU5WXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lwpcTld8cTQnZRcwXhBbRw0ArD+FoWSrUKyiiWC00E=;
 b=u67ovC40G1JNBgfa0j5nMktSrIUiXaTb4ZeT7By1em6nNzvPmOaBHmEpd2HZTf4Z7M9VNb8MVUFVrq7PK9uzD8qlbaClIixr7SN5Oblo/M0NcvjnID7cxRZD2ZOqDJqNw8QUmlxgCixjfuaZlGDTxKq3MTLVhwfOPuJrSf3mKA8=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 15:52:17 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:52:17 +0000
Message-ID: <18f50a98-8f9e-4448-b3e6-1f73f6a88816@oracle.com>
Date: Mon, 19 May 2025 11:52:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 34/42] vfio/iommufd: invariant device name
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744ED7B4B490D35C50A75DD9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744ED7B4B490D35C50A75DD9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::25) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: a4eb16ca-4391-483b-6fd7-08dd96ed2165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHpURHU5bDlWRVVDdGhVb3cyb1N5UnpDVTkwV0M2VGEvOEF0VW5VcHA4UGlY?=
 =?utf-8?B?RXVhUGZpZGppc25ZU1E2RHplNmRzV0hvTjQweFJqNlZZYUhFOFUwaS95QS9W?=
 =?utf-8?B?TDkrWGJIM3V4bkVtMzNXcEkzMUZFeGRvY0lmRTlQNmt2Y0xJRFhiNzFQaTlU?=
 =?utf-8?B?Y1RFUjZSOURZbGY5Z293eXBhTFVUdG4zSUNvRmRYRU5yd2g4bk1yVlFwMmZj?=
 =?utf-8?B?QkN0c21uRi9OY3NWQnZCUTRBZEFnTUIxdW9CdVlwZDJrbHNDcFhMcHFuY3E1?=
 =?utf-8?B?NG9xTHd5L1pmYkJXQ1hkZEhYOERaaWlsVWFSV0xRRVBXeVVuZEdseFdLdVBt?=
 =?utf-8?B?Z0xicWVNcWdRMmF3UUkvZUhhQXJuSDVYSjZXV2FZeVo0cmYwRmdTa2xDM3hJ?=
 =?utf-8?B?TlBnOUM4S2p3eVBoY3VRaDlaUzFrUDFlSFZ6ZStpUnVZWXJ6azZFRUt2NzBp?=
 =?utf-8?B?WEhiS3dIcVNrbGlmY3JoZ1FZT0JKRGtrWG9iTWVIVHJJbCtiQmRWbTJzRUkx?=
 =?utf-8?B?OGMrSCtiYXd6QnNRRy9FUERCcDlaVDJocEQxZ0FLNkxiSXBZanJGVk5UdmRU?=
 =?utf-8?B?SGRuZDdyV3RUd0gzNzRkL3FPK05MSzRFYThNbTVybUN4T1RVR0xNSlRXVzN4?=
 =?utf-8?B?bW4wQmlocmlvQ3Z3T2ZHaHV3YzVRMjAxMW5ySWdsS3NmRmhLWGtwNFF3dm1K?=
 =?utf-8?B?czJBMHIzMTIwSDhEdkFNL3Z1RUxnaXRNd0NJWXBTSUNXVnM0ci9YOVgySUpQ?=
 =?utf-8?B?Rm1HbmZNWUxhci9MNktsVUFBVW95ZXBGMTRYNGgzUkZzZHBXYTFDSEo4V01R?=
 =?utf-8?B?SnlJNjZzS2RHV3VySnhTQmllL1hnZ1EwV3pLV2ROTEFwTjY3OStxNEUyck5C?=
 =?utf-8?B?VHVwUkdUeFVNWVloT2N2WmQvbng5WVMzaVNZWjVYQkkvc3BwOVFvS3UwU3hl?=
 =?utf-8?B?TThkRDdSb1Z4eXpqTmdIcnlrMkdDYnNIdU02Q0RxbUxoeDJPWVFUdzd1VXc5?=
 =?utf-8?B?UngvemlTMEdFazV4b3B6VjBhelZtb3pJQnZCcXBjbHdjQi9HMTUzQXVVVXR3?=
 =?utf-8?B?V2RaUjVEUmFOelk0SHd1UGUrcGpkQWZad3Z6RWI0ZG9xT2VtNS84NktkUDNB?=
 =?utf-8?B?ZE5HN3RUeTBvVjVpL3k2MHl0MUpLc3NPNFU3MzgyOE05dDZIb20yQXZlOXVv?=
 =?utf-8?B?UXdXTTBNdUxPbVZlUzQvajhzZjNHWFp6ZjNDOU1xK3k5THZKVU0xd3RkMGlL?=
 =?utf-8?B?UnZZaXVmZi9NNjdLQ2llTkwrWEZqVjc4L3ZiSjQ3RGhpOXlHK1ZTQmJ0Y2x4?=
 =?utf-8?B?VmRtb3lKaDZwVHRRZnVTVERYNFd2QVNJcElaaDRaSUtUcjVXUG8yem5WdDBE?=
 =?utf-8?B?V3liSzBEbmYycFpVUmd0ODZBN2UwcEZVbThvL2F5b0pacDVpUGpxSzFZdmVT?=
 =?utf-8?B?SFpIOWNWdiswdUlrRm1MWVJ5dXE2RXFGUSt4NGVYZlN3OFFZT2FobFkwdkt3?=
 =?utf-8?B?ajFQdTZLRE11VkNoUmJJY0I3ck5OamtFRHJDMkVTMUZQZWg5UnF3V0NJVlZB?=
 =?utf-8?B?ZVczMjIzbDA1SW8vNGsxN1lXU2FtZGwzNGt6SVk4ejY5R25OSFVYcXdUY21k?=
 =?utf-8?B?OC9xdG9kWHZvR01kM25EWThmdjBxVE1XLzJHM2R4dkRVU2tyYXZDZWROd0ZJ?=
 =?utf-8?B?Uk9PUS8yc0psYVo0K1VSbU1Mc3Yvc2RueHFYekhqcGhzUGp3L2dRTG5VTjVR?=
 =?utf-8?B?K1ZyQmZxcnRKZGQzWWZubzBpZXl1UTQ1cHNiOUxIUzZ5dHRCM2NGZVlZblJN?=
 =?utf-8?B?STBSeVlBZDl3YkJaRXEraG8zU2ZBWU5wZDVpUFFKYWVjWWRDSG5hamhwMW9a?=
 =?utf-8?B?MDZyWFFBcjA4K016dmI0bHVJZUVNRUpwa3k0Z210Z0pUeUxwRVJrSy9wbGlh?=
 =?utf-8?Q?HQQInZQZKlM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2p6d3JNRndaQTMvSlI4YWY2c09ydTRaQnVNRkFGVDJZZVQ1U29teC9vNXo3?=
 =?utf-8?B?eVNJMGpsYTd5SXJKOFcrRDRHdnViaUJROHAvbVE4YlZmZTBWeUdyUUFuekFh?=
 =?utf-8?B?UVVBaVFKK0JrQjQvYkZHOTNJOGNidkpBZExWWk5qTFJSNjQ4RGthWUtvWGU2?=
 =?utf-8?B?TFNJWmdUY3ZFcDVTUllwejh5NHRWanBJMU1SMjJKRDF0QzVhSGlha2oyOWpm?=
 =?utf-8?B?VFhDRFNYT1hWaVYyeENGTUV6bzZhc3lxQlFQMU5MV0RtcW11RmV3a3FVSk05?=
 =?utf-8?B?NnkwSHhGUUxzQkZNUnFzeDdCTEFhb2JlV1E4b1ZCVUtKRW9qZHpKVEJOd0dS?=
 =?utf-8?B?MlMwQS9SSmh4QTdBczJPbFQ0QllaMFR1cTA5UFg5VW9PV1RNMUVaMzd1N3NB?=
 =?utf-8?B?aUVLY0c5Y0VqcWQ2R3RHcXBYNnljRDkzWXRyemRvS1pYVWg5MTltemp4TDVk?=
 =?utf-8?B?QU5UZ0lKa2JiMisrdGJYVzdNeXlTbS9PbkRqakF5SHJzWjRqVHNudUhZNUlw?=
 =?utf-8?B?VlR6MldmOVpNd3hxMnpYam1TTWVnTnB0WXRLbVArcGxEYmVxRFd1VE4vWkJT?=
 =?utf-8?B?SERVWEVmMTJ2bFIzVHlZWTNXVnk5VmhhZW0rcSt2TFVyNUNJZXNxdVgvcHdv?=
 =?utf-8?B?OHR2MzJlT3grRExVRXJqa2RoMUYrcVhqbEdXV1p1RTd0L3hrdnJ6UGt1MXN2?=
 =?utf-8?B?RlFwWjNjVG9DUlYyQzg5ampTODNzSXo4Y2dvbGdPNWVCSEdSSk1UQXc0MFZs?=
 =?utf-8?B?YkU2TDBOZDYvenl5L3RMcS9yemlUM1FCRHVzaVdya1ZhY3puQlBTK0w0U0ds?=
 =?utf-8?B?cDl5QSsxMHVBWDhqMy9pZUViRGtpZ0h6Sk1SOEpjVmhpdmpEUVhXb0l6aita?=
 =?utf-8?B?Mys2N083Q3N1d1ZLLzdnUzB1cTBMd1dTSUNsYmVNRjdjN1hmeDVoRHlYUkl3?=
 =?utf-8?B?RThOM2VFYldVZmxsR08xcHplbjBIK0hVZkN3cmNiN3h3YVFoUncwY2FNazZ6?=
 =?utf-8?B?MWpsMnprbE1Kc3VoQTFWV3hpb2s4T1QzQ1pPbWYvZ09OZHBiWUdMYlR5S3or?=
 =?utf-8?B?b1kvOE9kWGRqbnRBR1RqOXVIUHJNaytEOFFnYkFIVm9PdTBxYUFoUnZpQUVt?=
 =?utf-8?B?bUtlUlZkNmsvOUZsdVFLUk56aXI3RFRreEpTZ0hQMjBiUlhZTmxqenFnZ2Ur?=
 =?utf-8?B?dlNPMnVqVksrL2lOMjkyZHZCM0xIdkMvbGwwK0JrT3hRMDJCaXZyWlpaTnhV?=
 =?utf-8?B?UWNZdmJmRUVNMzZtaUZyV1RWSTNPaHd6anRWMUtaY3U2d1BEWm55dnZZZDdJ?=
 =?utf-8?B?VklWV3pWWkJ3bzMzWVI1SUJaWHV4Q2FlVXdLRFVTL1Vqby9DWEhrUnVJTEV1?=
 =?utf-8?B?TDZqTHJQS291STZQMEx1b0o0MWpWVDlqcHdxNHZGV1Z5MDJmVC9BT0RCSnBE?=
 =?utf-8?B?L1ppYlF5ZmQ5aE9zN1BqQVF4R2N6QlVCckwrVWZYbHFzZmtWQ1ZEaG9Zak53?=
 =?utf-8?B?aEc2OTRJZ1hvaUUvUHRsdkM5ZDNRTlgyUlNNdW11Rm0xMzJJYUlTWUpOR0pu?=
 =?utf-8?B?VGEzcnVuOXNqT2t6RG5XVEhTLzlLaHJBVWdXQkJxSmhOYzAvZ0ZmTXptK0N1?=
 =?utf-8?B?RTNGKzF2cHU0bk5LNklBUTZEMFU2M1M5Zy9YWnRWK1VCczBLUy9LaHhUQnhi?=
 =?utf-8?B?M0NOUDNaOVVHaVcvaWg2UnE2d2VURHZ2SlIzbzUrQU44RVd4MnRJbWVFa3BZ?=
 =?utf-8?B?em9pVkRjaG9DaG5TZXNidHVhb2R6QWVEZXBNbm91UnE4U25RNTZYYm9ML05W?=
 =?utf-8?B?Zi9MTytQUTdXb1NqZGpJYzBDK09pVUQyQ3FQL3pkdjlpZWx1U0x5cDZHVTBK?=
 =?utf-8?B?U1VacWFCWFlVcEZQdHE1Zk5hMjg2a1RRQTBOM0dIVmYwcWZQVmhLbXdxdFg5?=
 =?utf-8?B?QlMzTFFBOG05cG1wVEFmNVRkcHAwejVoR0Z0dmJ6UmgzcDh1MjdNc2w3d2NZ?=
 =?utf-8?B?UlpoSmJnU1VMUVloYzl0K0w5NmRmaHlXUDlnTm1xaFBjUS9QOEFjck1kbVZ1?=
 =?utf-8?B?bEl0Q3hCdWxodFVLSi9MamJDUit3b1ZrTi9TenFONkVHNmxMOFo2aUFveGls?=
 =?utf-8?B?ejhiZHd1Mnplb0dlS3llQzRqUHc4bFFsRVl0Q3pDbVVLT1pqRG9VTXdqNFZP?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vb0zqp/ljZ1Kf5t0swpsmyU16whkmr2SiSw2DTMes9t4m61wFNRHLOvQPm8ApydiFgxyrxICwtAElnJ1ggHfbADk22vBwMC/FOwzRZtMkta2EIumzsr6/QBFH4dXXyoRvek3MM3HMUTE6k/ikPiMmOzEmzctl55kU+230sAdzAKePv2YFVMk1n6sKznRq9LD81Adh+RkW8/xNHEeoMxO1NJfPT9V/0+8dGnorZHx6MB/xCM/X1KPTdv7JG1ehJdDp7OBlHz3n8mYV4aQkp9yNy4ShsjsD2M4xBdCt3Wsy1tKmOzguWT82V+M6zmVX10TZEJNYrNdt95iPL5y+yr8wGqLsUWBzuW6VNY2MQHRxGP7ennzNw691WDTA9zVFFkgcTJ2fH11hMeXQ9OxRcGOwVl23/ACRSv14qouhPNVND078R1n3FSn7BlTPaPONvT4bhMsgV4TVNX/6ARQB9FNx6ryrQiI20DEHSgimd5m72aOnzzNj+Mx3TI9QDm7ZR4xhTNPTwIB4nUSkE1Yyp48ld/Ov/hTheDfNg584bGMDpEzILub5j5qDW1bCQuoQkVLTcXg92LpRkLHFdYoYLZUvA+m3WCQ1QYXJeiH9g6Woio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eb16ca-4391-483b-6fd7-08dd96ed2165
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:52:16.9725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WulNG78Qdjgr3vdMO54yIG/jpxyNTKE70epkRoJOUzJN/tLQ+t+PnJgAtdAL+71kDavSVFnUxIJdJla6GkVXCOGvxLttnz/ffrlvEPqGSl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190147
X-Authority-Analysis: v=2.4 cv=GN4IEvNK c=1 sm=1 tr=0 ts=682b53b5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=D-c654x8L2pRQVsxgF0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6hnNxWNLREOKO-_Znd1i64ZtsKW7SJvH
X-Proofpoint-GUID: 6hnNxWNLREOKO-_Znd1i64ZtsKW7SJvH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfX9wXBeImlCH65
 DKw+mFDKDQwto0chtnUKRuyy0oMQrYt1zjstoqg6Z42NrfSrEoJe94rEm6pSCRQBn5dg4J0ZHYd
 AsjjBmbcRvxaZ6C2qsUYrOuDkRq1MHGfepVx9pel+OymtnovtFOhGFbe2+uFGXPFUT3wtornZ8c
 U+ObGHf+SMJr6BgEjSDf5vwww2GJQGBvrKrZBHkIsPXox1ix7rSjdeysvwMiNsqlKg/pQ8BsxxJ
 FjmJ1ptqanSDa8gSyzuekIBOB9h0p945GZRFigN3+Ib8UaWVlBfXNyIcLAO4DIj36m1FRrThTpj
 GMy87CktLP2nmc/ReIe1tl1psc6xuX6T3EG5r9IVAtSiscNdIQoNBFk38scHxIesoCVWNbOuln5
 JRcesILGUnAH5RLfKuIKOS3zPhW1tN3RRfP4+LFxTnBy8LXkxRkKfeGAOCmMbFo9cbi7cHbG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 5:29 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 34/42] vfio/iommufd: invariant device name
>>
>> cpr-transfer will use the device name as a key to find the value
>> of the device descriptor in new QEMU.  However, if the descriptor
>> number is specified by a command-line fd parameter, then
>> vfio_device_get_name creates a name that includes the fd number.
>> This causes a chicken-and-egg problem: new QEMU must know the fd
>> number to construct a name to find the fd number.
>>
>> To fix, create an invariant name based on the id command-line
>> parameter.  If id is not defined, add a CPR blocker.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/cpr.c              | 21 +++++++++++++++++++++
>> hw/vfio/device.c           | 10 ++++------
>> hw/vfio/iommufd.c          |  2 ++
>> include/hw/vfio/vfio-cpr.h |  4 ++++
>> 4 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 6081a89..7609c62 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -11,6 +11,7 @@
>> #include "hw/vfio/pci.h"
>> #include "hw/pci/msix.h"
>> #include "hw/pci/msi.h"
>> +#include "migration/blocker.h"
>> #include "migration/cpr.h"
>> #include "qapi/error.h"
>> #include "system/runstate.h"
>> @@ -184,3 +185,23 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>>          VMSTATE_END_OF_LIST()
>>      }
>> };
>> +
>> +bool vfio_cpr_set_device_name(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    if (vbasedev->dev->id) {
>> +        vbasedev->name = g_strdup(vbasedev->dev->id);
>> +        return true;
>> +    } else {
>> +        /*
>> +         * Assign a name so any function printing it will not break, but the
>> +         * fd number changes across processes, so this cannot be used as an
>> +         * invariant name for CPR.
>> +         */
>> +        vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>> +        error_setg(&vbasedev->cpr.id_blocker,
>> +                   "vfio device with fd=%d needs an id property",
>> +                   vbasedev->fd);
>> +        return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
>> +}
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 9fba2c7..8e9de68 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -28,6 +28,7 @@
>> #include "qapi/error.h"
>> #include "qemu/error-report.h"
>> #include "qemu/units.h"
>> +#include "migration/cpr.h"
>> #include "monitor/monitor.h"
>> #include "vfio-helpers.h"
>>
>> @@ -284,6 +285,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>> Error **errp)
>> {
>>      ERRP_GUARD();
>>      struct stat st;
>> +    bool ret = true;
>>
>>      if (vbasedev->fd < 0) {
>>          if (stat(vbasedev->sysfsdev, &st) < 0) {
>> @@ -300,16 +302,12 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>> Error **errp)
>>              error_setg(errp, "Use FD passing only with iommufd backend");
>>              return false;
>>          }
>> -        /*
>> -         * Give a name with fd so any function printing out vbasedev->name
>> -         * will not break.
>> -         */
>>          if (!vbasedev->name) {
>> -            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>> +            ret = vfio_cpr_set_device_name(vbasedev, errp);
>>          }
>>      }
>>
>> -    return true;
>> +    return ret;
>> }
>>
>> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 8661947..ea99b8d 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>> #include "system/reset.h"
>> #include "qemu/cutils.h"
>> #include "qemu/chardev_open.h"
>> +#include "migration/blocker.h"
>> #include "pci.h"
>> #include "vfio-iommufd.h"
>> #include "vfio-helpers.h"
>> @@ -669,6 +670,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>      iommufd_cdev_container_destroy(container);
>>      vfio_address_space_put(space);
>>
>> +    migrate_del_blocker(&vbasedev->cpr.id_blocker);
> 
> We also need to del blocker in error path, e.g., when attach fails.

Good catch, will do - steve

>>      iommufd_cdev_unbind_and_disconnect(vbasedev);
>>      close(vbasedev->fd);
>> }
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 765e334..d06d117 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -23,12 +23,14 @@ typedef struct VFIOContainerCPR {
>> typedef struct VFIODeviceCPR {
>>      bool reused;
>>      Error *mdev_blocker;
>> +    Error *id_blocker;
>> } VFIODeviceCPR;
>>
>> struct VFIOContainer;
>> struct VFIOContainerBase;
>> struct VFIOGroup;
>> struct VFIOPCIDevice;
>> +struct VFIODevice;
>>
>> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                          Error **errp);
>> @@ -59,4 +61,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev,
>> const char *name,
>>
>> extern const VMStateDescription vfio_cpr_pci_vmstate;
>>
>> +bool vfio_cpr_set_device_name(struct VFIODevice *vbasedev, Error **errp);
>> +
>> #endif /* HW_VFIO_VFIO_CPR_H */
>> --
>> 1.8.3.1
> 


