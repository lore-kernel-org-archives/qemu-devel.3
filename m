Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C215C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 17:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNED6-00038I-1R; Thu, 05 Jun 2025 13:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNED1-00037K-RJ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:16:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNECy-0003MA-Go
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:16:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtVgj001082;
 Thu, 5 Jun 2025 15:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=JCciwi56oUxIZUs48+yLjv9XUym/EBGjRDSald955rY=; b=
 CYJbwBEFaeOCB7Kyort8zzuGCrTRZTL5hN+XRRx3I3RsPmwBUuyuV4oy/9rvZlYv
 u5C4b5Axg510L+6vCwFrQPTCW5TQmkJhQy8AntWUhIQnurKDXsddVa5pQGMoHkU0
 lt/JvZGoJlI/Uxcty4rxKQP0Wymkn+db/cSxV/D0NFCCtrR64fIkPYFAEj9ilLo4
 5IH78gYw61EUHouTxukO5bR9hmfcQNODgUY079cbMngK1ANVqxDewtDbEcEuIsoI
 jvzXA22zsMM3DY2vTpKrBdgMq10bP6IzvuWnvV4DgA9UTBz/rbSdjzSq4sw45gH4
 rKRBJ5c1fPieKkqYvmJeVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dxd08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Jun 2025 15:16:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 555E3dNJ033797; Thu, 5 Jun 2025 15:16:34 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7c6ws1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Jun 2025 15:16:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiPYPMoMaDEVXnv9RsEl5pQ/oSpZ1qBo57p62Bbby3AQwN2BXNPHTpDGa25uO0U/bdHo8G/Xl7/Hl5Blgxgj34Rfl/2GfQNqeg/iMJ5ZdhlZnW1gi+foB1lWtf1zO/UH+2SdFAUMG2ArTaWqMwzkduuE07dcBz8BmbfFlf1oM5ZOX9L/YI7+LRSmGU/wgXOUtTlYqo4rzZWdAFibjrPB7uIRKtyoAObPg5spyTuCDc3oDWP2Pf4pP3AOZy8JO6kKJoE7Cb7BrgHGsNEB3e1P8yod6WUEuSNnQLVXRYd7Eqou8qfYHUtp2gGn5RuzkMNEXhzcmmiNATSgkqWHTB6rWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCciwi56oUxIZUs48+yLjv9XUym/EBGjRDSald955rY=;
 b=P7TdoOZQxiKndWLA5br9YzbLGL7ktWcUXywv5dY7HNO68Qzqatfe9H0NxvV/Gt53Dhj4smRwdl6qccB6yQcVaeSHeRKtiOQEsyyQvabXilLgZWAZWhW0Q7d0fF4Ap9YDRpD1HFaDbcuTuXJd6pGH8FoCm6/BZrJd5zGsEMzGfwHqGA2y7bJSrGlcalik6OacHjPqa9V/FbjSfh/0P5ZVBEW5OZZh8FtjsO+FN6N8k+Sthort5ZHsNfIMOSWM9QfYQtHDshTCjyQav0cw8aISC88OVFKD5R+OxOX78fzgfWunHxuYagg6pSu0QWkvf0beTdeapvbA9l5S7R+buHqzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCciwi56oUxIZUs48+yLjv9XUym/EBGjRDSald955rY=;
 b=DhA2nbbdF5gsVXTVnMSqmYlYmH8grd2CofVS8628o1eymmz0T9CE49NE+Cv2y+asA7/MNRLi2fUVWQfVJnbicjqOKW9BqeqRhMFAeMkC7cV2K2L9GyjhyNoS+pMRPWKreQJkRNEpHDESHILfExSjS0CYiWExvhah3nW9cLZvW6g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Thu, 5 Jun
 2025 15:16:31 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Thu, 5 Jun 2025
 15:16:31 +0000
Message-ID: <b44ea0e5-340e-4baf-872b-0ab8fcb0fea2@oracle.com>
Date: Thu, 5 Jun 2025 11:16:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Cedric Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
 <IA3PR11MB913659879C0B2EFF7358B229926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aa0c0091-7db4-46f3-956a-03a9f1362c1f@oracle.com>
 <IA3PR11MB9136014A45DEE58E09ED31F0926FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136014A45DEE58E09ED31F0926FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d562731-80a9-4203-a5a4-08dda443f350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2dBckxZbWNDVlo5bGNaSVdIaURuOXowQVpFQXBSVVlRUjZ3MHk5VFBjLy8w?=
 =?utf-8?B?VnFUOGhUT1MvZ240Q2pJNDZITFZTbjhFMkNBRWt4ZkZqQk14dDNYUCtJckts?=
 =?utf-8?B?aERLWnNwYnB6WUhiY2MxRm1RcWl2NzhxbmFkWGhpOVNWWW1WK3pxN25SYmIx?=
 =?utf-8?B?eGROSytVRmxLRDY2bzJzanNwSkJ3TytFZnRLQ1FLUGwyMzBRS1BxaXZVWEdS?=
 =?utf-8?B?OTczREt0b3pXbFhHOFZqL3NaK2JlUjdBNENmT0hheitMUjg1QWZBRUZKY1lI?=
 =?utf-8?B?N1pFMk0xMUswMmJRSWhjRXFpUzNUR2NSZUdWQ09QYkp1VFBTSS9FZVNZMkNG?=
 =?utf-8?B?RkRsTVRRNEhxNUxGYnpySnZFNUlDZXFrNHlHTVdzRmV0cjlrUHE5bGlzZmpI?=
 =?utf-8?B?TmVYYjBhdWFUZkxid0w4QnFDTmI1VGxHWjE3a1ZJb1M0dTVyZkhaR2R5YUZr?=
 =?utf-8?B?RzFKT2hTZWVRekxsaVQ0RGtpUXhRTDJnWmt5Z3JBZGdrTmRsNGpnSHE3RzNN?=
 =?utf-8?B?dUk4YjBYR1hFZzRIdHhNb0xIM2l2RVdxSXJ6QmhTNTR0VXg0QTF2ejN1bzF4?=
 =?utf-8?B?S0RuUFFoT0F1WUUreHgybXBqcGZYcm1tTTF3K21lTzRPT1BCOXlER0YyRkls?=
 =?utf-8?B?bWFmZTNHTTFJZ0tXTWNZQktNUkVmc0xZNFBDZE9PdktFaXZ4SWxhUU51Zldy?=
 =?utf-8?B?a1JEMUU4M1lJazNodWxLVW1iL2hucGpKU0JJMHZOMkdBTFU3VE1RaVlrZG5p?=
 =?utf-8?B?T2grcENvdmJjbGNGTlZkb2tnWkJraktyalB4QzRaMTFiNCtCZFJ5RkFmaG5w?=
 =?utf-8?B?eXlpY0pMK0Y2U1dPRFlZcWhGd3YzRWVDR3MvVTFxbGg0SDBzcWJobkl1eE55?=
 =?utf-8?B?a21sVjlialkwaTQ1MVVFV2VQVVhaN01CbnBLNW44NjVOcTNtdWRFRWhrMWIr?=
 =?utf-8?B?VWQ2OEtMM2NycEhkZWliTk81cnY4eXkwU3VsTVBPQzVIQ0d2WHJTdTd2ZnMv?=
 =?utf-8?B?bHBEQXc3K3VScTZ2NlZ3RjZpaVNOVlRnMEkwUURkcEt4aTE5d1BLcGFMQThn?=
 =?utf-8?B?NzBTL3gwdEZ2VVFNY1phT3RNdlpkWGdYd0dJVUc0WTFDR2ZhUElnV1FBZi8x?=
 =?utf-8?B?RjByMi81OXlNMGc4UDcybXpGQTdXYXVKdXpzVDRyZENlYTh6SUhkbXp6SnpD?=
 =?utf-8?B?UDIrdi9hTlFveUpSL1loWnQxR24zeUpROU0yKzZTMXQwMTNrZytLR0hPdmJo?=
 =?utf-8?B?Q1NKT1FsMXN4cTlMNDhRdlI0MUNsQ2tXdVdEUUhFM0xZUzlBaTlWL1BsaGxk?=
 =?utf-8?B?cW1yMlRLTlg5Z2dtcnBnRnNxOGNDR0ZQOFJPYmtrL3BETEVvWVBiL2JpQnhT?=
 =?utf-8?B?V1k0TENyYWQ4cmszV3d0N09nK1NFclk1ZEZzQzQ5REFpMGNXMkdnR3ZTcUhV?=
 =?utf-8?B?bkVMUnZMdkJzQkp4RHZ4bXE2RkplV1FlWTZsTEJIRC8wMU5hdFhaUkx2S3pY?=
 =?utf-8?B?ZnhXaG1RcFVPa0wzaGRyNVJrTnlVU1JBc3cxOGh2SitDcHQ2QXFaQVhuQ21F?=
 =?utf-8?B?Y2RiTFdFdnJmTTFJa09ZZGtVcTlPaHRsM3RBN1ZaUVM1NDFNRG1NalRpSWpW?=
 =?utf-8?B?b1RjUUN6L1NFekt4N3FJVmJ3NFEzVDRrenZhTmJLMWhwS3d6VnRrbVU1ZThX?=
 =?utf-8?B?cVJqc25KeGMzNHdBOFYyZVh4VEppM01nMmdta2dxWFhXZnVDWDJCRVovem9x?=
 =?utf-8?B?cmswcXVKSXJCR1krSys3eGxHQ0ZmcXB1WHA4TUNRbm5lZFJYK0h6NkdxS05Y?=
 =?utf-8?B?NjI2K2N2ZVFZcmcycGdRQVZ5cVAxeDNZOVdxeXhscEhtQjVESTZBbFZpa3Vk?=
 =?utf-8?B?bEI1L3RSZm8yeEZXUURwc3lCTGp1aVQ4VmxKT2RsL3FIRUsxcGt6QXhtdTlF?=
 =?utf-8?Q?z6G9r/Cmo2s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRxTG50SEsrVEFFZTRPWE02WmdENUE1WlpnenE1TjFJVWh5T1RVcnE3RTlO?=
 =?utf-8?B?aU9SS2U3VzYxYTZpdm5iQ2src1A4R3NFbDJGVnM5cG10KzFhU0psTm14UjJz?=
 =?utf-8?B?dHdqWVlXY3RGV05HMmVLbzhpSVU4QU5MVGIxYU5XQnpTdzVLL3Y1R09iVFky?=
 =?utf-8?B?Yk82WkZrMzdyLzZsUTc2WS9JZUM5UDRqak5zUmNISFo0UVhZTjdmaGJFcSsw?=
 =?utf-8?B?blhWZzJRR3dPU05TSVkxKzkveW5US0VGMmhMUy9tODFSSXZhaE5JTFpUbEl6?=
 =?utf-8?B?STdpQW9ncGtCQkMzUVN2MW5XTTRUMCtsZEsvbk9CZ050elpiUUxhTjRIcU5X?=
 =?utf-8?B?ZUtLWlR1ZkpENk5KYTBjY04xelZBazhTZHdOQ2RmV3IxYk5KSTA1bXJ0VHQw?=
 =?utf-8?B?VGgwc0ZMMEYvdHludE5VcitxVXFrTE82am1ubjNyVzBQenp5ckJLY0hRcWp1?=
 =?utf-8?B?aHArZEEzNjJqdnJ0eGZZblRjM0pWNWlISnF4T21xazJEOVF0U2V0MFNUSm5i?=
 =?utf-8?B?T29SZWNQMTV1RmZVQWoyZ09rZmoxL09ScW5lVHJxeWovTVVsZDBQUlgxZHNu?=
 =?utf-8?B?a2VtbVpQSW50dXg5NDI2VjYwVUVmVWt0cVlPL24yRFcrd1Zsd1RPSVZseEl1?=
 =?utf-8?B?NVp1S29ESXZSbkliZm03em1sVC9LazZZekgrdW9jNXJIWkVWckFNTUpoUXMv?=
 =?utf-8?B?UkkzT3FiNHlPbFBoc3V0M1Q1OGVEZ1ovbHdKYmV4TUFkQW1YTCtPMmo5L29v?=
 =?utf-8?B?ZWIxbXBxTTYrdllROXRXZUJPUUFocnN3Si9UOEVpUWdaRlF2eDhaYzNvSGN0?=
 =?utf-8?B?YXgyQWFTVjU4a01tbGIrcFJSTE5HWm9jeEFiUGt3aWY4TFlRay9LTHREYnln?=
 =?utf-8?B?OGJ4S2FYWTRabHlRQnBKOUtka2ZhUFVpVG04NkVrYVUrNVhITlRTclZQbzc4?=
 =?utf-8?B?QmcrRVZaYzRJQldWRzJJZ29TMlpQZGRtMDQ2YjdLY2VhRVRmN1BnS21EaTg4?=
 =?utf-8?B?RlJCaU5BOWVINzVaaUdnd0MzNktIeC90K3BxOTBFYnU2ZzlLV1Q2aTV1cXI5?=
 =?utf-8?B?ZXhUOTdOS2dvcHBldkorcm9lb3loRTEwa3FSclRnSHQxeFJVWHlOZEkrdXg2?=
 =?utf-8?B?amVGZGt2eEIrQWZ6WW1sOVJkZjFscmxPcXQzdWhDSThqWG9qMk5xbCtNYUZB?=
 =?utf-8?B?R1JBdzJEZGhYekcvSUhySGdxUTFIT245SEliWkJuN29USXNFbjBmMEJ6enlY?=
 =?utf-8?B?YWdpZGZPemNITWVxZHVjT29rZGZhMTFjL2d5OWJiU0NGZm12Ym1uaTFGYVRx?=
 =?utf-8?B?NWJQRWR1bW9NMWVYMXVxL2ZuRkd0MnY5SEpFc3U1alB4YU1UYlVIbkhCb3ZH?=
 =?utf-8?B?bG9WaVNRTWZPOUt6ZDVRcS9nUWtKaVVZY3QvbGxKSEhHTm5XSFlQbDhiNFJ1?=
 =?utf-8?B?K3c5Z2lwTTEwdWExei9TNWZQMTFnR3d4bUVQVE1Sc0llR0JpdG5mOERZRlU2?=
 =?utf-8?B?c2FsbE5aYURUenRISGNtSzR3Y3ZidGZHZGVjMWNINEtJT0FUVWpvQnFiNG9s?=
 =?utf-8?B?NzR0Vi9jUVFXMXdENG1ld1pZN0podDRsVmFvV0xWeFc4TXdZdkhSaWthZjR2?=
 =?utf-8?B?RHR6MnZ3ektyMmVHVEJ4cThzeEQ5dGdkd3ZiZEtDV2dMamhoc1RKMTAxWGtL?=
 =?utf-8?B?QVhYayszZW0wTWZhSGYyNUJmZ1hqeElhdjY3N0RCbG9GRUdXcnQ1YnZ1TzNj?=
 =?utf-8?B?Z2RjMk8xSC9BMTVJS2t5cFZCNnYyMEtBYXJVcGNldjdtZVo2ak9uNldyWGk5?=
 =?utf-8?B?K2N4U0g1QUNJRGVzNjVLVWJTZUxjdWM2SmNkOVNYZUVuWGh1eFVsMk5pWTVK?=
 =?utf-8?B?WHhsQWpnc0k0emJCSnlVNmN5UmlIUG1DTThXaTFPQ3owT2tUQXZ2Rll6TW5P?=
 =?utf-8?B?MDRBYTRGZnpQVTZiNk9nU3RuakQzSVdhY0w1cFZBMzE4Rm5rSVRteis1cVBT?=
 =?utf-8?B?YWxoeUEyVTRJZXhEMWY5dGlCVFBoVUpza2JZd0lkU2x4RTdhOHo4dGxoaVJO?=
 =?utf-8?B?dnMxTDk3RmxwU2Vib3lOWWhTbElIYWZ4ZG05Y09hUmtuRUxzZXpLbVBudWNk?=
 =?utf-8?B?TzM1ek1qVXhhQmxKcEN6b0RpWnNueXBINEYxc2djUE9MdklSdkNoRGtDMUpW?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /UUIDICZlu0oM2Th68Aa5TKKFU+I3WoEnW56VZHW8lnstHer8eawRqnyev49EpuRl8V7TYWYpyynuDAmbM1rt8yBjwhB7oWSsShu7TKk4XW2FeL5l2vS4488LNMRnHC8AjJsFLY9GbtFGW90A+bXUPdoBp9M96qdXA8YqTeTIxcp87HQ/fZRj5NMl7RK8kTmWCzcgnSGfm2Hca2w4cYsQql/ZAMCPpNtQw1/jFO56Ma7/VXQA/hIBaXTR17QzMDdVrxWotLbLUGfm9ZHRGFvPd4/wfvqH7Yoc6HCuQfpA5E9v+XyuuIETLZUk5CHT7cMPIdqIYaDW/SE0QuhtwM3om/ok11axyqHOxpkWZA1f/bqx8rTKj0JQW4AXG/ie5Ua+uqMj616IDUtPeR2w9A2xsQkpNCv8cEDNoDqTbTMhDuzG5xwDI4NhNCV65QadbThTcS+qQjLwmMufG6xcsN9bshAJ08YXrJ1CAmqqad2bKw3fQ6QnQ4+2a4JzEG7vLG6Rd+rLWgskV5OxL72hEhm1ZLGbWCkuI70z/p64dTSH8EP8hU6z5KR6kqfjhSSXHp0ZwDJjQaAlCWbEHDAljOGao9wEp0HpoHAIW1MJ/8o+D4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d562731-80a9-4203-a5a4-08dda443f350
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 15:16:31.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgwUltw0SrhPTVkrHa4OmyTek0K5dhcj1IZm/+oPPfSO0+8Ys7vvajBOTh9Llrj3bmx4Q5v+l5RIUQhCS9V0j+h+oy1kU/qgeAPfTSpBTak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050132
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=6841b4d3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gDheZAOk9GMSQsd-NPwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEzMiBTYWx0ZWRfX1z8xKlBqYcQy
 GKkYASShIgmbUknlH+XuTwUMWNLDSvp5K2sq0dz4RR6xlyC8rJ8N8Ou1/GtrStIieMm57WhCoSh
 5MypLsePIe1/SXwXehXBaby8V0KrQvf4Ej59Si7wPnGCjynF0Qf5Wzb0XGu16K9w1R2tBjV0BVJ
 mm8M3jGNR6hOKSXXui3l5xQ6eMbfARAaGlYdmgzsrGrv2Xpe8ZeTFhRhRkKzuUATjhqlLFTIRZ3
 Au+CT9b5Cnda0U8rZAZvvqQBjfB8mdfaHlexWuUVIkRVFICuacvurX0hgWUXozaGa4sJrLDdpmY
 wToNpV5gdpBGtQMN2X7xlHxqf/3ju1hKN7HnR72Xuqr5ddC6E6Hn86uuJ+8qZWuFFbxkM2sNf/H
 ae4pw6enrYn8Kxavpo+Tm9nUk68fqa000mcEfEKbebTgMDB4tzhdMqxvh2LWlHXirzA/o+PH
X-Proofpoint-ORIG-GUID: rKvn2NQbvWSIFukoJDTsvhYFBuZz4VFU
X-Proofpoint-GUID: rKvn2NQbvWSIFukoJDTsvhYFBuZz4VFU
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

On 6/4/2025 11:02 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>
>> On 6/3/2025 11:55 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>> Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>>>
>>>> On 6/3/2025 6:40 AM, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>> Subject: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>>>>>
>>>>>> If vfio_realize fails after vfio_device_attach, it should call
>>>>>> vfio_device_detach during error recovery.  If it fails after
>>>>>> vfio_device_get_name, it should free vbasedev->name.  If it fails
>>>>>> after vfio_pci_config_setup, it should free vdev->msix.
>>>>>>
>>>>>> To fix all, call vfio_pci_put_device().
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>> hw/vfio/pci.c | 1 +
>>>>>> 1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>>> index a1bfdfe..7d3b9ff 100644
>>>>>> --- a/hw/vfio/pci.c
>>>>>> +++ b/hw/vfio/pci.c
>>>>>> @@ -3296,6 +3296,7 @@ out_teardown:
>>>>>>        vfio_bars_exit(vdev);
>>>>>> error:
>>>>>>        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>>>>>> +    vfio_pci_put_device(vdev);
>>>>>
>>>>> Double free, vfio_pci_put_device() is also called in vfio_instance_finalize().

Agreed, this line must be deleted.
Cedric, this must be fixed in vfio-next.

>>>> If vfio_realize fails with an error, vfio_instance_finalize is not called.
>>>> I tested that.
>>>
>>> Have you tried with hot plugged device?
>>
>> Not before, but I just tried it now, thanks for the suggestion.
>> Same result -- vfio_instance_finalize is not called.
> 
> That's strange, I tried below change with hotplug a device through qmp, I see "vfio_instance_finalize called"
> 
> device_add vfio-pci,host=04:10.1,id=vfio0,bus=root0,iommufd=iommufd0
> 
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3167,6 +3167,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> 
>       trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
> 
> +error_setg(errp, "faking error in vfio_realize");
> +goto error;

Thank you, with this I see finalize being called.

In my test, I had injected an error as late as possible in realize, to verify all
state is unwound, and I did it wrong:

     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);

     error_setg(errp, "forced error");
     goto out_deregister;

     return;
   out_deregister:

and finalize is not called.  Probably some reference is taken in those last few
function calls, and is not released.

This is correct, and calls finalize:

     error_setg(errp, "forced error");
     goto out_deregister;

     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);

     return;
   out_deregister:

- Steve


