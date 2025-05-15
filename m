Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD9CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFdur-0004bb-Lp; Thu, 15 May 2025 15:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdup-0004bP-Ee
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:06:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdum-0004yL-Og
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:06:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1qcv022297;
 Thu, 15 May 2025 19:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=nAq3Q4ogUN74+u62atFyTxLlNXIekvgbqURCmdXs464=; b=
 N5stNP1/uouUihsiutp1m9GZNcZDuTrOCJsstP3cSjdU3vXglR8BA26iO2xNb6uQ
 HFZ0I9QXGbzReaGEfmglYXfQMjdufmGUJUD0M+/5Uo5iie+fJlufdDd3IGNSx5D9
 oxiNNlbccIZwFAd7Feoea4xQtItCLLUzWcLToJtkInjiu0IUlvltF+IAOrUPnK3n
 tCGeBekIYKRb24n34Pm8P5iwUpv2bBwMcrcR1LXOWzQNJvy71g9+eLIfKdKSjucG
 6QTlBp14VQFfYErCuRG4SabCsi1r+ytpQrOeuKGS8SMHZ+Glkj5ra3eZvNNnTVD5
 BN2P8FtVSZt2owtZSz4wxg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcm510r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:06:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FHPkhB004282; Thu, 15 May 2025 19:06:38 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmegwqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9oh/P3AbWLx47hN+0K2aSDyg3UhlN+tae8A+lL6EYPPElxbyL7mC1tiNkBWy5e7nggTbKL9CLOOpX9GkUKbQ/fQvKAOTw0hK98cyM7fPHg8jDGCtzN2SXwn4QWg+dr0axJYUvHMimmjINB4IQByGMTMdL/86Og68m+XfDzO8r4dci95i7sea8KVCu2Mtf9cL+VCgNi9QyxCjfVYEUEqBYR3zA+DwkHLxbtfpRpl+OfrFuHwAM1e3jQhHTr4sMnBKBXcErilNDOXDgIuT56GXxrLQOfRUwp0yIyUNT4WWd7fBHp+bApdUnsyt/o3No+PEM1Tb87jWaBZ6D5QA+68hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAq3Q4ogUN74+u62atFyTxLlNXIekvgbqURCmdXs464=;
 b=qEIYhSUh1X26uetdPb6FPQZAae1URs5F8LjSJely0MusPDgklK4xSpeA/OSOC1OwJmgKqQRVAxvcwMw/BToCCzAubItLGQjEFSqF4ukyYRBnIed+KFOZZt94+D1HxxIvJe+ZhZoQr4vSe7twgHguPCy0VEyy5dUDX2/fpFs5/wCu2RgCvIJ1am86dSfQkOSa6JyT/GkJvZLDF5+uPnx3BwvuTib4zRZ/Czz/7z/800IypdU+OKZZL3ZHB8FXsfPjt6pCNA2tTmVZ0Sxio4tEAZsGVjFxICNG9QpZznGBrLavT1nKq0Y5zEYgWUWSb8goT6CryTeTE2ATN6WrgLuFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAq3Q4ogUN74+u62atFyTxLlNXIekvgbqURCmdXs464=;
 b=R338BrGHkQJYb/EhDq0aIFRpiVaAhFWEbnY7VICdbIWsXkqkOPqjHxbC9KZT+mk3gduJgwfD5Gg+V1mNkZqduFHo7Afgmk4P8nMfmr2kPqt7BUw2ai80G3OvWX3Dgz+bKMN/qRCKylUWVUnG5GTeXr+4F4FwVKtLlmx/ScTprRI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8495.namprd10.prod.outlook.com (2603:10b6:208:55d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 19:06:36 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:06:36 +0000
Message-ID: <2f36f035-6704-4a73-a9e7-953c27fb32d2@oracle.com>
Date: Thu, 15 May 2025 15:06:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/42] vfio/container: register container for cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-7-git-send-email-steven.sistare@oracle.com>
 <161947a0-f3fb-4ddb-b6c1-6e1a1e4d6849@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <161947a0-f3fb-4ddb-b6c1-6e1a1e4d6849@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:408:fe::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddd577e-7482-47e5-ada2-08dd93e39d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWt6Y3R0MXRGK3E0V3BrK3dDbEwyOXBYRW83YlR4K0JRODJzN3FDOTVrczdn?=
 =?utf-8?B?WDZnclN5Vk5Qd3NyMmI2bXcyNHpEbldmL1NRdFB2eTZEUjFEaEwvSDNEcmR5?=
 =?utf-8?B?cVF4UWc4NVQ1U3dmOHk5N3F6NFdoYU9NNkRuM29jSnlEU3kxR3RwZEQvV0ov?=
 =?utf-8?B?OGV1bkV0UEsydzZTRlQwdmJLaHVGakpXdTVaOWhUbGFXTGtOYm5UV3Nudm9h?=
 =?utf-8?B?VFZmSHFLZFpvM0RZc01PY2VlOXVEdVRwQzJhSGgwWkpDTWpRNnQ1RXNEU1gx?=
 =?utf-8?B?S01WYktobnVWSGM2RHRpbzFBS0x3WmdGMDF6VDRleFZ1Mm8vRjFVU1pPZE9W?=
 =?utf-8?B?eCtHNnJoYXpZbXNsc2tGZzJ6YStSK2tkais0dWJvWkhPb1hWbEZtejV0WExh?=
 =?utf-8?B?Q2ZscEZScG8rQS96dFMwZGR5RE02UzdpaGsxUXovTWtyTFErcy9CdGxUdW1P?=
 =?utf-8?B?elYzR3E1T1dIUU5ESm95S2xUNElqczZtMEdtd0JhTzBoQ1hHMkE2Z2FDYXdP?=
 =?utf-8?B?SmZQaEc4THEvL1VoKzBjQ1hyOW01RWxONUR0ZytyOTg4Y05iNHVycVM3b2lt?=
 =?utf-8?B?bG1oa29mYjU3ZlQyN1o1RXNOYlNmbHhUMEtxS0NiVFlMWkVNbGZXaGdDSTRr?=
 =?utf-8?B?VU5ITTVNSjBxL05PYm1nOHIzMXptQm5IUlNPbWFtcjdIVWhnK3VlUHNNRjdS?=
 =?utf-8?B?RGp0TFVhT1ZPbjN4R2JLSTdxd0h2ZElHNC9KMnhuVDdheEV0WHdlNHZ4UXA4?=
 =?utf-8?B?MHpvbWl5RWhqNmdSUmR6a2FUbmRvbkNXRU1mRmFxcFIrZFFpUzBGbXNIWnQv?=
 =?utf-8?B?Q3d2OXpMRm5oNFl6bjZlUi9lTnFVR0pONkJaZlAvT0xoTWZzVWR6VzBCN0Vz?=
 =?utf-8?B?ZnJ1anZmbHBnM0QyNVBRamZOUlVWY010REtiL3JKT0VXeFlka04vL3p6Lzln?=
 =?utf-8?B?bmVNNStuQUZHKzdwTHdQK3NwcXRiaWNQN2UvaVQ0YTlqNjQ3Um9PVHFjUnE2?=
 =?utf-8?B?RnBFY1lrdVI4T2w2alh1dFh4SXlqbTdwakZUY3N4cDMwb0lmd0J1bldCMmg3?=
 =?utf-8?B?dk9UOVNvZEN4T0ZvUHdmZEhVblA0ck5sTk9zZmZnSEc1YiszZWR2TjFRQVRC?=
 =?utf-8?B?MnVrRmhFOHRzVHhvcTdyc1VtRGhuN3phNG9NeXlYU2JJeno3VW9nNWxvWWZ2?=
 =?utf-8?B?bWpPZjE4RTh4ZWx3aDBRTXc5TjRQcXpFWDcrSHV6ZmNPeCtob0tTQlo1YUtK?=
 =?utf-8?B?ZmEweitITktEV0dhRjc1SWx2ZWZrSi9GbDNsaUNvczNWSVViKzgvdGU3Z1Nm?=
 =?utf-8?B?UUNveEIyYkZCTWVBSEdlby9sZU1PRTljbUwyaU0wV2RwMDh2YkRrTmwxSHAy?=
 =?utf-8?B?czlCbW1LV09qVTZtNndWUmV5UExrK2M5cmpqcFJ3WkNjQmRMVnVwbXZIUWFP?=
 =?utf-8?B?eGtGZnFJb0FJRGkyblRDSGdqS2pkeWRWaHkwWlFRSTUvblFjdWJ2SnhHTWNZ?=
 =?utf-8?B?b0ljZElPSktGSG9jSHZBZmxyZldxbGcyaHRzSlRONm1jKzNNalVubnNlckhx?=
 =?utf-8?B?bFhHenhlOGV1WmtGaGxBSllOOHlnU21DdG9PT1hmTXpnQlp1WkR0V2tpV1Rq?=
 =?utf-8?B?N0QzcVlsQWp6a1dabnpYMStOSjZPMitqWFV0MzZXYTRzYnJqc1VIVEx0WHdk?=
 =?utf-8?B?L29TZzVBTGxlQktzS3ZoMWpIOVh6SnFsd0NOVGNXdENaTVlDVWZYekVKYkts?=
 =?utf-8?B?emZuWVEwY1ZEdE95QWNmWEdWRTN6QTZsbmpERHFlN3N6N3I0djNYU0tlQThi?=
 =?utf-8?B?V2NlS1lEamd3Z09SdThRQ2lHVE52VTloK1BCMnFzVy9mK2ZXT2hxU0t6OGpk?=
 =?utf-8?B?RkN2ck9XcXVSWnB4UFByTlVSRkFjaEtlK0pERmRTa0pBWWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlUdnA0RCtnWGd3dWdaazdOWmNsQW1iOWZrM2p3THhMbVJTYWJTWlVhd3Yx?=
 =?utf-8?B?YVdPWFFsVXc5bjdwWXpRbmJCNVlzbGh1SkJyTmtaYlIvU3BjaE1XRjJTTEFv?=
 =?utf-8?B?bVNGTHFPOHJBMkN4b25Xb1d0N2ZSZHplR3IzVmJHWWFHTjc0eWhCdTZwWVI1?=
 =?utf-8?B?ZFVrUkhDUUVGcC9kTjdueEREQXBMQ0ZhZXBINzF2UjUrNEs0anFqSVR1bUdh?=
 =?utf-8?B?b3dvZG50cjJ4ZEU4VFpDemlHZ3BZZGlhNktMZ0dBQTZVa2p2THBlZ2NKUkpz?=
 =?utf-8?B?RUJQcnF5ZkZrQ2N5MExLWSs0VEJFc1JBNGgvbFk3a0JoZlRWNVc0dlNJLzc2?=
 =?utf-8?B?M2lUNS91ZkVZT25iQ2FHUmR1MGhpQzk2ZUUycFZzNTV1RUdzUFltekVBMUJZ?=
 =?utf-8?B?Z3RXMnU3aGZkNVFpR3Y4cE9CbFROdDA3QlJKaFRaM24wTmFCdWt5ekpHY0th?=
 =?utf-8?B?eWFwS2ZiUlB2V0N1eWRUVmFjSmpwYlBLOWlmREdUc3lsRE1GdDA2TFJ0WWRC?=
 =?utf-8?B?Z3Y4WkVrdUpPYUZjVjVHeHh6Q2l2SmdXaFZNa1Q2Wko4L3g2TS93OWZNdmxv?=
 =?utf-8?B?emdGMFpkRlpzbnZsTVMwSGFKdWlGNXY1c1FDbGpYRGxESGdrdFBwT0MxYk9S?=
 =?utf-8?B?SWdWaTkxNERkUDhsU2xWTVlyS2xaYlRkYUllUE1iMlU1cWRCNC9Zd1FGOW1N?=
 =?utf-8?B?T2Y2SVdlSCtYdVF5Kzh4bWFMcmFrVFEvaWVVbXhwYlhEbmxUdXNkTG9NRm84?=
 =?utf-8?B?MXRDQ3ZmUnFXRUlHSlhaNjB4RmZZN3pkS2RUcEZ0YlZmK3BwSzdVcTFCNUFv?=
 =?utf-8?B?MVZKeDdEYjd4T2lQcnZhWE0vd0duczJNcDc5aURqRGNjUjBhTGVvVi9OZGl0?=
 =?utf-8?B?V0ZmMEk5dnFmOU1VMU0zM0VGY2lHK0YraGVvSGhrV1lBSHBTRzFXczIrampv?=
 =?utf-8?B?bWJyaFdvZW9FMmhpSU5FQTFOYnFIdTlScldYcGplbFF0UWRCMERCWVRFalps?=
 =?utf-8?B?MmRzREFyNldGanNjZjFSalZxMUEyWS82NWhkMTNIZkVwdi83M3Z4eWt0NGow?=
 =?utf-8?B?OUZ2WklvaFJKWVI1cWxyTXdnZVhlZ3pqamR1T0FLQUJ1UzlFaDB2Z1VJWmNU?=
 =?utf-8?B?eW11NjdIN3hPVGljeHB6Q1V1RzYvYmF3aHd0Q2puR3Ribnd4UjZXb2x4Mnpk?=
 =?utf-8?B?R3RocTNrOE9xMk16RENXTzVnTGk0Q0o1NG16SXByWmVuOU5IZzJVdEdhUWlu?=
 =?utf-8?B?b25XMlBLNFVaTHh5ZE9YRW5GbXdsbE5YVW5HbkI3eW12SzRZTmdvTE9zSUha?=
 =?utf-8?B?aFZpTjZYZDBxRWJoMmk2VmpxRzZDQklXSzk0T0lxcStnaU5hdmdZVzdGNFJ2?=
 =?utf-8?B?MXZTN1Z6WTlvOFc0WU5wQWRzWHNxVkxScjZHa1NhcDZjWWtEaXZxSVBzRDBq?=
 =?utf-8?B?U2ppL2JIN2JhazhXZ1hiRFZNVEpEYnRjeFNrcEpWTXBRTy9JaldqVmFIQzhs?=
 =?utf-8?B?dzgzVHlZYVp5c3V6VWFYTWdpTGxlMWl5TElEY2RYOC9YVUdyU0tjUlpaYUZu?=
 =?utf-8?B?ZHlTdTRuR2x3S1VZa0hVN2dOME42MDJqL2xlWlNCUzRlK2FNbzFGeVZCakZ1?=
 =?utf-8?B?Wkpsa1QzZGw0WUN1ZW9SNmxoSWlSaG1RemVZT1ZJYWU5bElCeDA2N1dOWlRn?=
 =?utf-8?B?UnplVWgyZ2NKUm0zdFhmdEM5UWtXVnRIOXRFMkFVYkVKblM2c09Qb1FGMld5?=
 =?utf-8?B?TlFKMDRzMFJYRlJxem8ySEREbUxZdTRHTlFsWFZDcnFiVkl5Y0syeWxIVStY?=
 =?utf-8?B?QjVaSi8yVzBsRm5nV1daMkhFaXh0NWd1NlVHV2ltR09QVlhoYVlodnI5V0tW?=
 =?utf-8?B?YmRlWDgwSnhXMGIydmpOZmdqeW1SS2U2NWtSaFUwbG5LSEpHckkrYnBYQ3Nr?=
 =?utf-8?B?S1p1aE1lQjMveFF1L3puOHZZU28vYTBTb2FnVjdYUVl0ZDg4RVBTdE04aEJh?=
 =?utf-8?B?NWwvbWRvMWxpQldOanZENHNVUU5VOEVZeE42aEtaMTFsYmVoa1F5d1IxV2JV?=
 =?utf-8?B?TDZrVWZISDNjNGxDUXl5cy9HTVpWQmU0Um12RTZVTXJFTXdYY1kwSU5uOUNw?=
 =?utf-8?B?NnpFVHY3cFRuMjh0WGhTMTJGeDY0ZGw2b1lrT24ydndVZEpKY2NqSi9IMnlD?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EwcFcXnw3oshGpIGkLfqXczON/zQW6f0dPapLBYotImcjfiDOFxFoZcj8pL+g4wR+4Nnb3qcZY7ervOFJPGj7YoNZAfW5gXcDxhYLhfWea3z12U0H18KjTyAu7YWwQNgWqYAdLeTiRHJwZIiHM9uNSlFwEp+v9LdEclJNho17EcxJxSgSDiiK2fvjkY6uBYYy+CziHjMxzpXjl7cC7Ijeenhk9aFwdHhhyJfrCCk6tTl/JRgg1ruYoXyazUCedPWX09MMjGOUfRyVI0dvYK/2AZCJRtDIvXa2FanlBYBpqi1GEbxG2+/fzTOdyXlEDyV+CFq2MavyU0iGCkkPCKeAIMW3JGH5+M9aB2s/Uea0BbiopXGGk05tLGVseJ3qYe1yYABYXpihlsa/fRkvJV7Ybtb2tmT7n9WjR7a7+UiHAIEcOnztrsTJa+XyjV9WcrQaPRP3Iq8J6+xFRKxG1yEdxcT2AK8Y6QqtC3pWiMt/0U8QJVOj99PJQhoTjdjz1ae+lC/gKkaqN6Y6doyGb5W5F8uVOkwXEjYKnIPR3gPHNs6N1LAPhoiCuyixl9uGoGg49X6KgzKNQhrrdMvKfV4f24q6jZMMVQ51XTBwu2djBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddd577e-7482-47e5-ada2-08dd93e39d06
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:06:35.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P1cOiGiU2yhHoilJQWh4bsabdehbM4iMreyucOU8qJwXLSqaD38dL7DyCWqy4BTvyveXgDnRBV3QKuBAwjRZ555Ft2OhBUyY/hhTpjrHWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150188
X-Authority-Analysis: v=2.4 cv=DZAXqutW c=1 sm=1 tr=0 ts=68263b3f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=QF0vp_4-zkBLhs63CusA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4OSBTYWx0ZWRfX5ODHVtY3m074
 KkQ4GQ3uFjx2kn6v+xywv5fTwKezJpDTAB0HdX0wJDuyiSKVs/LYWPBSZu4/wuWdRrJEWZIMYBU
 Tm7/f1aUDm4lh4BfJd4XLZlkwe5hFZnlcTWi0m2ajBx0bY2OAZ1SB2hV1ESOUz3Wr6ud7h0Rhe7
 REsKxdxgbpgDlDl2jTIxYKpBgNG1IQcury4E+aGt0OODmDSF25HK/4MiFG/KGenV6FCGmc/AndE
 A5hdhrkbJngrGtAQbdk6SNwPIePnavgrVkV689ukCSw+bAo1OR5NB5i9VNDUraCX7ApB+RvWMP0
 Gx0UIQ8GS7Y+DZd0ZaBxgC30xrtrnw5DVLF+Nn4g7JReTGr+MqlhvYAeiflSZwbywuGBtvhZ4fh
 m3XB+ESH3b1ig8mYDoRKUcmSio91xXWM8lbtGS97FyNoG1Q42zLqx8F0QaMBvvl5TBGQR1Xd
X-Proofpoint-GUID: seG5k25KjO5_SLpHv8WRlmcebBenu8aC
X-Proofpoint-ORIG-GUID: seG5k25KjO5_SLpHv8WRlmcebBenu8aC
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

On 5/15/2025 3:54 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> Register a legacy container for cpr-transfer, replacing the generic CPR
>> register call with a more specific legacy container register call.  Add a
>> blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c              |  6 ++--
>>   hw/vfio/cpr-legacy.c             | 70 ++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/cpr.c                    |  5 ++-
>>   hw/vfio/meson.build              |  1 +
>>   include/hw/vfio/vfio-container.h |  2 ++
>>   include/hw/vfio/vfio-cpr.h       | 14 ++++++++
>>   6 files changed, 92 insertions(+), 6 deletions(-)
>>   create mode 100644 hw/vfio/cpr-legacy.c
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index eb56f00..85c76da 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -642,7 +642,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       new_container = true;
>>       bcontainer = &container->bcontainer;
>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>>           goto fail;
>>       }
>> @@ -678,7 +678,7 @@ fail:
>>           vioc->release(bcontainer);
>>       }
>>       if (new_container) {
>> -        vfio_cpr_unregister_container(bcontainer);
>> +        vfio_legacy_cpr_unregister_container(container);
>>           object_unref(container);
>>       }
>>       if (fd >= 0) {
>> @@ -719,7 +719,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>           VFIOAddressSpace *space = bcontainer->space;
>>           trace_vfio_container_disconnect(container->fd);
>> -        vfio_cpr_unregister_container(bcontainer);
>> +        vfio_legacy_cpr_unregister_container(container);
>>           close(container->fd);
>>           object_unref(container);
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> new file mode 100644
>> index 0000000..fac323c
>> --- /dev/null
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
> 
> Please add a SPDX-License-Identifier tag.

Sure.  I'll do the same for my other new files.

>> + */
>> +
>> +#include <sys/ioctl.h>
>> +#include <linux/vfio.h>
>> +#include "qemu/osdep.h"
>> +#include "hw/vfio/vfio-container.h"
>> +#include "hw/vfio/vfio-cpr.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>> +#include "qapi/error.h"
>> +
>> +static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>> +{
>> +    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>> +        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
>> +        return false;
>> +
>> +    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
>> +        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
>> +        return false;
>> +
>> +    } else {
>> +        return true;
>> +    }
>> +}
>> +
>> +static const VMStateDescription vfio_container_vmstate = {
>> +    .name = "vfio-container",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    Error **cpr_blocker = &container->cpr.blocker;
>> +
>> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>> +                                vfio_cpr_reboot_notifier,
>> +                                MIG_MODE_CPR_REBOOT);
>> +
>> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
>> +
>> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +
>> +    return true;
>> +}
>> +
>> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>> +    migrate_del_blocker(&container->cpr.blocker);
>> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>> +}
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 0210e76..0e59612 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -7,13 +7,12 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/vfio/vfio-device.h"
>> -#include "migration/misc.h"
>>   #include "hw/vfio/vfio-cpr.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> -static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>> -                                    MigrationEvent *e, Error **errp)
>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>> +                             MigrationEvent *e, Error **errp)
>>   {
>>       if (e->type == MIG_EVENT_PRECOPY_SETUP &&
>>           !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index bccb050..73d29f9 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>     'cpr.c',
>> +  'cpr-legacy.c',
>>     'device.c',
>>     'migration.c',
>>     'migration-multifd.c',
>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
>> index afc498d..21e5807 100644
>> --- a/include/hw/vfio/vfio-container.h
>> +++ b/include/hw/vfio/vfio-container.h
>> @@ -10,6 +10,7 @@
>>   #define HW_VFIO_CONTAINER_H
>>   #include "hw/vfio/vfio-container-base.h"
>> +#include "hw/vfio/vfio-cpr.h"
>>   typedef struct VFIOContainer VFIOContainer;
>>   typedef struct VFIODevice VFIODevice;
>> @@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>       unsigned iommu_type;
>>       QLIST_HEAD(, VFIOGroup) group_list;
>> +    VFIOContainerCPR cpr;
>>   } VFIOContainer;
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 750ea5b..f864547 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -9,8 +9,22 @@
>>   #ifndef HW_VFIO_VFIO_CPR_H
>>   #define HW_VFIO_VFIO_CPR_H
>> +#include "migration/misc.h"
>> +
>> +typedef struct VFIOContainerCPR {
>> +    Error *blocker;
>> +} VFIOContainerCPR;
>> +
>> +struct VFIOContainer;
>>   struct VFIOContainerBase;
>> +bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>> +                                        Error **errp);
>> +void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>> +
>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>> +                             Error **errp);
>> +
>>   bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>                                    Error **errp);
>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
> 
> what about vfio_cpr_un/register_container ? Shouldn't we remove them ?

At this patch in the series, those are still used by iommufd containers.
Those uses are removed in "vfio/iommufd: register container for cpr", and
vfio_cpr_un/register_container are deleted by the last patch in the series.

- Steve


