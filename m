Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F95C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnK9-0003eq-PK; Mon, 07 Jul 2025 11:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn0J-0005MS-ME
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:39:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn0F-0005ZG-RM
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:39:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567BMN2g027044;
 Mon, 7 Jul 2025 14:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=n6RdhUmRd+o69Qd9G2aAsYob6qD56fi/n7fRmVeLJlg=; b=
 Bnjzs+T0t1w6J3m5v6Gd5MRvijAmpB/bsecf7M9YLAi9/oeSUIT465Lcf/hu34oC
 KasL2xMBSLbaJ+DrjhetJInTY2u29P6qpid616MJ0PaZ+VJHQLs7K+jOUniTSPQz
 Lu/xdwRAVUukl+MwS/YvSL1n5W3d8QwaOWbcgzvimNULvnSCTOKAhyX/cu54PTl1
 0hF1KbIYab2dyWMgvtDKKDiOI11P/KREyHj5WKgqTHGYetLb3CaxTFaAIPMyt7gV
 pYyoNtBsOIuWmX2C//ElwKD54QgBfiuXyfwkhBxUCzzsyWENmBeqp6hPvpQMZCRo
 S7CiIX98ibfY2RwQmhs6TA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rda18ekf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:39:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567DKHIw021371; Mon, 7 Jul 2025 14:39:27 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg8aqkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhKBtatQcjj3hl17cTHxkRuTx6ey70l5vwZIfd8JQxDH0iZD6rDbtf8Ay0TWYR4q/bhydXdYPbKmeu4gwmMErOFuv4OagioRYDj0xBNjkEzsVKs2vw132AuzchBMWquERKZ9PxRy4Zmu/v1ycLbAtwGa4LqWTw6W0TvnCvPbirkkyE42n5W5Tk1tBR94tBPUT/NLiXl1vhMmEq7u2PE4PBvNgE7Ut8nFXv4i+5/8aBKInoMUKZ2ontphGm2USXbV3porzcEt1hI0U2Y85h85IUOuwqRLvVYqGuPhz5cf81yelLCXhE7nPLQWZo1H6Cjr9CO4PAAgDjG/EXvUlXGYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6RdhUmRd+o69Qd9G2aAsYob6qD56fi/n7fRmVeLJlg=;
 b=vohBeG0lDu/Kc0EIaJAWeo2SyQbKBuUq7yig1819ovUN1GyZD6Sq19L9HCo4GqKRAWaB2wT7vAhg8t6ZPjqaG+xm9pHdAo2KCPPdXIOUX4ogMIoqtpRPcpEO7XqiB9oaSX/dCuwJJFOBz1ZJxWwrZUJDalvaucIq7k6HbC10ZMZxbDf6jKEsoCI7uw6J8IuMX/Suh8+QjoMdg26dlYzapLliB1RLShw2aLHuePCxXtJPGikhcVUJbI7DrFHoRf7t5nTafsmTpqSLhm3NN8lNJztoyqep45urEUaarPPqKcFO+Tuh9XNco/4aiHg+DuPdKNs/t46pVHdkX+auIxVz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6RdhUmRd+o69Qd9G2aAsYob6qD56fi/n7fRmVeLJlg=;
 b=Q6cRot1x2d4FPd7Fy/sXhkb6IPPoPIObED0aNZWq5ksO2PJZhms7qpITu82hQ6jla5hUU0XZDhM2gheE4SKgzUgXMId+IjB9BLBYBRkbBeMnuuBSZSN4UeKHd5z4c0xghKWKN0j5RzBlCI9i+NkY7UR2pTrLYCN/7H52aEv6EV8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 14:39:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 14:39:23 +0000
Message-ID: <18c8edef-6b8e-4c1b-8721-d70f57402cdb@oracle.com>
Date: Mon, 7 Jul 2025 10:39:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/5] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <87qzywm8yb.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87qzywm8yb.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a57d0d-90e4-4f94-2bc9-08ddbd641102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3FiNzFqMkg2Y0VVTE16dWJhWU9XMXIvRzBkcnUzNGY2OElBUFdsanJDM2Vo?=
 =?utf-8?B?VGhVY2VuRFpEZmNrSnJTdVY1cE1BbW02alUzcnNtWkFxUGJMamx0UlBET2J3?=
 =?utf-8?B?aGdiQk1kbnpoeGwwWHBHNTFWS1Rja1VKNVZIRm9ib0pGV1YrY21xUkpyUGJK?=
 =?utf-8?B?RmRBZUM2NFlvYnBMNDJPc2xtRFR6ZXRDekxCVGtvTlVGdTRqeHczVms1YS90?=
 =?utf-8?B?d0dXbWRWQTZXT056bER2TUgrWHJtd1V2Tjc5c2piYS91WXk3RzY3aGtRQjlz?=
 =?utf-8?B?dHFGTDY2bjNacUFoWFFDQXBxTFVVc2cxYWtXaXJnang0eHYrb3hEajVBeUpX?=
 =?utf-8?B?Yk02UzVVN2RoRk5RYkg0S1FGSjgyZGhNems4Z2RNbHBLTXk4VjlCdWFlSUZa?=
 =?utf-8?B?aS9zUGRnVTZVYWJBWGVFTUtNVjNSQVlVTTNlV2ttZzQ3Vko1V3gyNU5Ram5y?=
 =?utf-8?B?V1hpRGloeGZoMjBodllFb0VPb0tUT1BublFLY1ZiRkZYM2Q2cHJ1dFgxZW56?=
 =?utf-8?B?SnMzODdiU1lQcllQWUdaMTM2MEhLRSswbzFFUEFXOXN6MGNKOHBXdFZML2hW?=
 =?utf-8?B?aUdnZWxGZGptS01QR3VDMitmWVMzMHZOTUYyWHlkUGdVKzRMWnk4dzRrekQr?=
 =?utf-8?B?bmgzTEdxVk01akthL3ZZQkN0aXpTcndXbHRhdlVQMU9qamF4d2hma0FoU0JO?=
 =?utf-8?B?aDBCUjBuYXNHTVprcWo5eWg3OFpxdnlkWkd3MFFrZjZHTzJrV1JYMFhvcXda?=
 =?utf-8?B?NWpneFRxN2pOOGxIeWtBYVlUMVpDOWFBKzNXK0o5M3Fya2VTak03VURFZUl4?=
 =?utf-8?B?U2ZyZjl2UmdHWmw1NlNmOFFXd1NGeTVzY3BTYUlzN3FsZDFFNkZpaUcxWStX?=
 =?utf-8?B?R25qOWd0a1NMVklucHJ4NzNhTGdhQjg0SGV1SGdZK0VwWjZZNjJwK2srb2pr?=
 =?utf-8?B?NERpTjRGbVR1R2lkSEROdEpwZDBWM3ovRzJtOFVLZWh4cmxQQitPRlB5a24w?=
 =?utf-8?B?N2xCUytlcjZLQi9vYVRVMG9zZTdpTWZJNlk5Yzg5L2dYN3ZHeVRYWDUzLzk2?=
 =?utf-8?B?ZUY2UXl5eTQ0eDJKbnFFQ0hWaUtXVXQvMFBaekxwYlNhcmdMbzZUd0FmYklu?=
 =?utf-8?B?Y3JJLzVQclMyc2xPa1Y4OWlaaW9oQSthYjhiYkZ3OTZaZFkrSUFKNlAxRUtM?=
 =?utf-8?B?QlVoSlMzekZLY2RuS1h5Mng1UmRSQVcrZ3BJbGZBa1JoWldSbS9TVktPUC9z?=
 =?utf-8?B?aytwaDdkaGgrU3VQZVhWZjJuMjZRdnFpVHJyS3hWeUUrN25SREtlZEtKaXpS?=
 =?utf-8?B?MEN4aHQ0S2tuV3BwOERlWUpGUWpOZ3dLOXdZWDFCV0FPS3QvajNZa3d1eHZS?=
 =?utf-8?B?MUxQSlVFdnpUbERvWEx5K3RROU9UR0JSK0Vpb21YbHB3V2t0d3RpNzQvNmhu?=
 =?utf-8?B?NXQyaitwS01FU2FTR0loVmdXa0dqWm1rN3YrczE2dHo2cldBSkFFQ05YTUdq?=
 =?utf-8?B?UzQ0dlp1bitOOUNJNUhQZ3RqVk1rOEJjQ1Z5aWRPYUFqbWw1Um9TTlczd3FQ?=
 =?utf-8?B?Sk1kYjU3azMraC82bEZRbzdSVEIwSDRDVUxZVlpPd0d5SUpXZDNjL2NtRmY1?=
 =?utf-8?B?bmYzN1BkTDBBZlJDVkFnQjF3VzAwd0Vza3lJS0QvaWljdDZhdnhSV3dScm1t?=
 =?utf-8?B?N25xTFdwUG9KV2c2ZXd2emovaDFVK3BDbjJRNTJ4dmMwRUdwRGNRblpDZlhN?=
 =?utf-8?B?T3NCRW1xQS82WEhmcFFkU2d3NFd4bi9KWGRObEEyQTdjTmJRV29VL2VUSzcv?=
 =?utf-8?B?WTQ3UzN4U3hPSlBxU21ieXI4MkgxUUlUZHpRYXhEZXZGeGFBVW5VUFdzcDBI?=
 =?utf-8?B?KzNRMEV3Smt5QWJvRElBZDZ2ZTNlTUlQUC9NWklPeXdMcTdkQUlLQVhtSmJX?=
 =?utf-8?Q?WnrUvBQNQY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlptNTc1eG5meDU5dzRGa0RGZWNRU0s2N1ovdU55S1FCM1lFVCtGY2ZVRFhx?=
 =?utf-8?B?NFJFS0NOdmhNSXUrL3hrZUdUWjZxeXZmUG5ZSWVuS05rNkUwRnVDQWhRWkNM?=
 =?utf-8?B?aHFHQVppNmk5OStaVHdFbEdZTyszVnllTm5JbTJCMHRhK0owYndZSHg5ZWdV?=
 =?utf-8?B?b3RZU0p6amVNQzJyNWxKWEY2WS8ybEdDZXN4aTYvenpiNFZpU2R3MWFHaXpN?=
 =?utf-8?B?aXhON0tqTlMvZUo1M0h3Y2w3eTkyZlhmbHIwVVpNUVBDZHJBNnV1aFBZNVZJ?=
 =?utf-8?B?a3lsbHZzRUkreUo5a21pWDB5cERoR1lVNnVmYUk2aFdJZ1Z2UDh3SnpzQk5P?=
 =?utf-8?B?U2pZc1RQZW9BL1ZIRTNXRkgwenB1TWVENVA4YjRrUHE4WEtEaldjT0xOK25s?=
 =?utf-8?B?TUFrQ3pzWHRJZndwUW05dkZjN1ZjYUZKV09BdFprUCthSmpBNEM2cHYxY1VT?=
 =?utf-8?B?SHQrcG12aUcyQkNVRHdoYi9BZm1JazR5MHI0WFFvWTNva2IvK0liUXlxM2pa?=
 =?utf-8?B?SXpGRUJabVVETmVDWWZLclE3c0lGNi8vdmNzcHFoNXk0UGFDV0cvWlg1L2hz?=
 =?utf-8?B?TjQvMm5naVdveHFJaHRFazJHa29jM05tV2NGYms5TjRHa1gzeDB2QncyY2dI?=
 =?utf-8?B?blVyUk4vWUN1TXJOd2I0bGcyanNFbWs2dzNZcG1OcVJpbDc0SklCdmhML3J0?=
 =?utf-8?B?L2RMYUEwTFZ2cXhzekF1eHI3MGppTk1kZjMvVkVoTWJMa1Y3MGFsVzE0WG1o?=
 =?utf-8?B?bWM2VlZLcnZTL09BdmpKNDFZR0RQaWtGMzhncXdvQkpvUDZaeFg5cjM1WDNP?=
 =?utf-8?B?SDhxTzhVUGJTZkJqM3ZuWkN0VFRXdC85d1hGcm5FWXBCYis3RXQzSGkzR1hL?=
 =?utf-8?B?aC9PSTF3ZGFxc0tmcmk4UWpRMWRVWWtNeWQ4QkplMFkxVmFrM0dtclY3cFJt?=
 =?utf-8?B?djYzK2tiODhtaDBLN3p1aDdMd0VTbUdOdUZSbFg5cjlYbHVDQk96c2FENUc3?=
 =?utf-8?B?K0dSNUZ6TmpnemtyaCs4QWJtbHI4QkhKL3p3R1dqcjFtakxlSGc2UUVSRWoz?=
 =?utf-8?B?OGdHR0h2eVNyVU5ORDlDK28xVFczRW40VHR5TDZBcERyMnJFUDNJRUxwMUQ0?=
 =?utf-8?B?bitYM0IwcWhoMk1JTmc5WEhxV2w4cmN2OEZsUGY1eGxBNkdOdTVYZTdqM3A1?=
 =?utf-8?B?RGRQWDRpQkw5VGRncEhjNUlPT3U4Wkx1d0kvS3l4OTdyS1BCYS9JcDRzVVFp?=
 =?utf-8?B?YnIveEE0T0xzWUNxOEM5VjAzYmQxK2NEc2lHaEhWbEFUbncyUzh2aFBNcUEz?=
 =?utf-8?B?bk5tMXhISEZ2bXRtZE43cTlQazNLM1AzSDNKUVpEWDduMlVDclNYWFFZSTdl?=
 =?utf-8?B?dmo0MFZjQjlDc1hqZlVUcmZtRUExSjhMMmFFL0VubDVnZzNaQm5EVzJkSjFy?=
 =?utf-8?B?MTR3c2tMZ3l5RWxBK1VlTEI4WEFJMFB0TEpsUW83UkhOTjdnNWJVTDJleU1k?=
 =?utf-8?B?MDJaNGtkZ3VvcndTNDlKMzFHcUJ3YlU1OXhOY242ZUV3a3dHeVRXTTgvNFh6?=
 =?utf-8?B?OVNpVjdHZmdmSEl0UVA1M1FQejdkOFVrWUFKbXIraXNMRTg5NjRyMWE4M1Er?=
 =?utf-8?B?UVVkU3hNWDZwZWlCOWJUM2x1djE5Z2tVTllBR2thdDJYL3ZHbGIzYWZpeEsv?=
 =?utf-8?B?a2V3RnVDZGNRV1pGejk4eU9MOG50VmFQVEpRdnlKaDRyVWdxSXdzNlVnZlN1?=
 =?utf-8?B?dHcya1VkV3lTbkJrbFVHODE3alJ1T1hKVWZLRGxCVU90Mjl1MHpaUjBkUFZq?=
 =?utf-8?B?cThmNFBPcU0wN3owSHk3WFFHTXE5djhSS1I0LzU1V0xNK0FWMXNPcmdFM0tl?=
 =?utf-8?B?WjliYmtwT1I1ZWkxL25ueFoxcyttVEdGbDJYWVRNNU95VUxjdFREMWFRNGhK?=
 =?utf-8?B?VWFkWU5ZYkg1L3NUWEVUaWtVdWdadkZMQmNiMTJUcTdadXBpMitzczM3ckJo?=
 =?utf-8?B?Ym5kNzVlaW1DbnNnUXJnL3RtRlptTGc3Yk53NGRZb3VEeFBoSWdWaDB6MGdK?=
 =?utf-8?B?R25wUGh5a2l1dkdZWXBaN3M4OEgrYkdscmFjbURxK0FIRk9NVWx4ZzlTTHRa?=
 =?utf-8?B?MkhINUFLaHplOVhFVTlBTlg2TW1OS1p5K3U3Mk5hTDljMEFFMG5GdW5Wa0FT?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yj7mTwr2Lb0rraUqJOUptPMM+GZTNUGvb/Q7sYejDZK8rZ2YjyGWC8POhROplSfl7R12BkQ/nnHwgUW18iwRH/pOCcTD7zSyJYQ03lN0hM668Chp7KiJ2S5kK6a+YR/L20arRIuzphJVpv25v/Wt0YUZdG1bAayMkPhVCqPXPiTgeH/gjotOujEPuqjF99O/zd0Pa55h5jLqF/7syDnb9Q+U/imC3ztCBLl3g7zSLc95CSIaDDa17K8P/mVdGmmouLmZAsnVaP9Sx9bC1O0OJHs9815hIsmtnJtxtmegczQURmYyKFbTV+imKCXg0QpCWM3/vX/Ccr3khnjMFQT/+cuHVMnizMGDVHcCK6X620s3nNpb5sFnyzQxy/E4q0NJ9xBcX1oq6TqYGhqHZQXL46BjCGqHsyZON9apqJVLaBQMfIKvu4ptAtmAxSH8+dcDJWDwAHvZp3cwJ3WeX3gAaj/EGOJLyR2ClgGNO4tA00YJLxWffMEU+Hi7hAXAuQgXLJyRk8SUdgdUXWpXHJ3bv+hRNmzQXD3PeC8VsDsyB7zpOV+/4YXkecVEEXaLyukDTxfDSEbh6Y3qP9y+E7+R+xKYjcNyFp16yMWIjXkUTIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a57d0d-90e4-4f94-2bc9-08ddbd641102
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:39:23.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/oOP3+YPpZcs/PeF12xJxDhBp8750dMLU1slAoOgyaQcTLeF3/SHbPc09xlYsdmgavhas5GEguEoVNLsThY4bcSHy2GtIWnYgMiMIDVis8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4NSBTYWx0ZWRfX15E1sBC92mkL
 lWZf/44LxGgs7NCMftHx/2SNuk5+V4nW52sCyMqCU4EojcPewJNMxAFxN1FzhCIHiJUcSbQx2Wp
 50OacQrZB3SKrIoDGH3ruGGSbVGLLO8UOT7EgwVrIFY04MWsVBX/gfoHzXt+CCkXECpD5C1wpbH
 cYLkX/6xcQTq4CZ+ePg3AkT4ukPlNGl516BEfiZP24ndRkHWtCsET2hPw9hEX0xeyJMJh1ITSGG
 Xu7WWgoEBQPOoyAYd1fBFZHJhzZmjIUSaZbPqEH2gO0QwPm5ZwMI9mNp07VfHjNDUv7PKkdw709
 h5kmmi/D4E7+nnN91ve93Vs3rQLPOfrgPGMJIgPDBWuOi5MAlbeqtytND8sX68EDpGK50VYpOD8
 82fJnN0N5OiR6LRYzy1niEcTfcR0jVT13lF++QY7UKWno0GcXB7Kk4SWQEKRzVdMsIwnkK2V
X-Authority-Analysis: v=2.4 cv=QMNoRhLL c=1 sm=1 tr=0 ts=686bdc20 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=BRStOHnk2n1hFW_jU9EA:9
 a=QEXdDO2ut3YA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-GUID: fOL7A0e-IHLglpgC0Dp-N38MaxU3EgtP
X-Proofpoint-ORIG-GUID: fOL7A0e-IHLglpgC0Dp-N38MaxU3EgtP
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

On 7/4/2025 8:33 AM, Markus Armbruster wrote:
> Steve,
> 
> My sincere apologies for the long, long delay.
> 
> It wasn't just for the usual reasons.  It was also because I had a vague
> feeling of unease about qom-tree, and had trouble figuring out why.
> 
> I'll try do your work justice before the window for 10.1 closes.
> 
> QOM maintainers, please have a look, too.

Thanks, much appreciated - steve


