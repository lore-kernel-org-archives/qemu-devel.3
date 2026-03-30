Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD52DFF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DG7-0000xK-Rx; Mon, 30 Mar 2026 10:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w7DG5-0000w8-0n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:06:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w7DG1-0005rt-LZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:06:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDE66L1800706; Mon, 30 Mar 2026 14:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=iOudRsvQ6CFlRbsnZXopWDlpJ0mYRsqHALCDSD+H4h4=; b=
 cNQu9Ph0T/EA4p2NtrpwWHgTLVqlAWiSYS9iLWIOADZDR7uyuGhGerEFmXhggRl9
 tdyyxYsYR/UUDKc817dAevU/73MvLG2+SjPNhhaLD1IJqN5zkgu19dCWHYjuVdCP
 5CXOOC89pnxk26bu/ix+0c+CB+ebauCG7yqTN+tl8MPE4FZ17leFgW7FW1sbVL0h
 VpW76ZVVFqmpOX4j1RR+dXPLBJBfCXDomeP1ULwni2Yo4rKmH4ilYQ/CM4W7DM2U
 PqV7IQxLkGF0J9uauuc9yO/GCyRY/a9lLQjbc7Ez7vphpkkeb5zuYdgYby3eDHCU
 HOF3wU+lKuZ0XD4hw2p5MQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d67hqa9g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 14:05:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62UD1Bls022257; Mon, 30 Mar 2026 14:05:58 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65eeucsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 14:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKeuNXgHWQsHDVhSkempsR7+SHvLA4OmeZl6aC6bB+2UC1gbEy+Lk21om8S4uXMrW6DHQN+7xjfCwsSkWH8EZGo33MVRXXZg4JNAyMun1koqMhXqGTgMPjqcbj40X4RuWw40KKG3VImDlRMuc2rJoU+d7rcsIffb5Ci8hpmdaTfUOtpWQI7OR79knTaDer+4KK2MSkyuk9z7PyfKuoSPouZxUiXMUTwpriAm8DxJe+Dn8zoHELGt67iiZfRNXG6SRdig1Yneb4uhq54dh+jZ0M4g31dn203czw0GHX3hb0BaU5m5chTnIXTSV9bKCmKevXLgiHQP6PAMg804ja9/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOudRsvQ6CFlRbsnZXopWDlpJ0mYRsqHALCDSD+H4h4=;
 b=kr3FVs1T3617UBRbJg7rAIMnoLYAtvuXo4ZgsFpkuwjAajy2Jp1exv5Qwl//0m0hthVn6Mp2hYRZgTURwtoKvEI9UBGq7OwBRNKD11EuOyGGWfGIjgD621U09zpiV05B/E/cXW111/SFb83VXvwqGV3GEsTHpfsTEaSnjImeK8wFiK0wW6GgTc3qCSV6f8YiOCSMcc4MpTSb2mihEZc4jG730hmFnGcSY2VOZFnTMyJ/e+k0mLccgHN14COvrPtg4zwnqifjvleJ8zFu5cf+StE4E0qp5hpvL4LBRHgHRIFZbQJQUg6sZEhgnVCe9Fcr64ZjFpH9dqArPsBMy8MJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOudRsvQ6CFlRbsnZXopWDlpJ0mYRsqHALCDSD+H4h4=;
 b=SGAlYoVvvqKyo84OkHseVbpSa9rwVQevfMlnvQ/+NsbJQbzT7/tdk82B3f5rkIw+jrR4IG+1RJnYrx4Yv9sc+ctcGUpMtFduStfsKhIaKTikUHUxTVZJZU8OeZd9jukz/6YAG6HIYfDggyRZv4zWe0F0PPEIGvCHFhfw4CcfPCM=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:05:54 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85%7]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:05:53 +0000
Message-ID: <0f56e41a-8542-4ce9-8fa6-b868ed6f7c2e@oracle.com>
Date: Mon, 30 Mar 2026 10:05:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 13/14] virtio-net: detect pending Tx work for VQs
 mid-migration changes
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-14-jonah.palmer@oracle.com>
 <CAJaqyWeSr42GwqG82hWcj5Etpde0Kz8no1TMwFbVeuCazQghJA@mail.gmail.com>
 <428614fa-3903-4d42-a0d7-cf8aa977679d@oracle.com>
 <CAJaqyWe9Y=vLaN7k0yhf-dOTH2davRW3eT5ZMBz-k4oSq5=3Lw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWe9Y=vLaN7k0yhf-dOTH2davRW3eT5ZMBz-k4oSq5=3Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:256::35) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|CH0PR10MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: a62791e2-e25e-48e4-2f7d-08de8e657464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: d+uZG3lx22eZ1trpOMoJ/FtHHoE/70bFjANv9ps5RJNFYht7DCQ1wZiX2vzADl0rr9ZbW+ydVeXaPU50/KKmMcfFpKXkbiHzRTejaMYCv8wx4ckZDogngUJquJ7PiNjwGS1RKTrF2rN5k7drKGp500Aq31qlgigf4qXADUjLu81WbvN//TmWv3CPIvWhdljnLoh31eLmXJ6gAI62YykZPcP5/14D5g6OKra1o5RnxljojkrAMKDkLwGcM+zaKCfOWmBKWm/rx5kvZ7cHIZavi7742VbyVJkSwqvJNyPko0O9B03oOPEMWAygUlmkcbA74a05xtDCe72U21sNoKlWNHYhfA5yMuwI8Rm0tukhUSUJmL6kT3epYNuTvj31+usibRiqMTiOjrFStToOZDuvVCsDeCscqCzCBP0sa4wu4/JP3uQFs15cKd+gftOeTfCR7Lc5CidK4QOEYZuSDIg55Ns1Ujaa26OJTNptIXFKU+lpZKX6EcsVU1ih4ci+0i6hLZ0987H8smnbN4dgjdEnfsfpuns53rUsZaTycHZtscC/J/FYYS1ctID1yHKJgaqYBftoGpetH6TaNXhnbkrLN7DUdXAnCLegwvjdUFm34dxmPyQV1afWfHq6PJvl6huoXR5jhOFDOg5DxOk7LLjW9WSFiQYhcncOy8eTEMVa0SQG4bsvp1svbzm+aqLoFRn4SariK54ar5ZMHgXBHDaEeYbLXExvgN4SjQKcbJv/yMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU5KWnE3WU5DNDZrZERtZytDSDB4QUc2cjVLSFlKNE1pc01aWGRLZHY0Smxs?=
 =?utf-8?B?RnlZT1JIaGUzWndtdDVhSVU1dGh0a2orOFNRVG9TWEFmT2NaS0FIVFBybEpS?=
 =?utf-8?B?dDVyKzV6M3l5UGc0cXZlVmJWVW5IVGlGbzNERXVvanprbU56MGlSakgwaUVJ?=
 =?utf-8?B?THFuc1ByOGsxMnk5ZVArREQxblFuQ25lSFNLK3RnOTZBSG9LYW9WOGdXZU5a?=
 =?utf-8?B?RFFvYTEzays2VktMcmQ1SlpzSXVjTXcvZzBRQWcwZkFsQk93NmpWU0ZjN2JE?=
 =?utf-8?B?VFFOR2xoUStYRThIWWt6T2Jhd0ZDT0lmT1pJaEgxUVZicnVpd2tKQmllbGZx?=
 =?utf-8?B?ZTJSR01DRXhRNDdTaW5UVlBObEpPV3VTVEMvNHNyamgrV3Z1WnZsRERCb1RV?=
 =?utf-8?B?Z01IL0hxM2VBblpsdXNLeUZTVFYyYmpSVzhOdzE1V0Y5cWpZc3JNdGpSSCth?=
 =?utf-8?B?bUFWWkZ6ejNMNDM2K0h1QW1SSERvUTFiblMyU0JxbHpROEdiQm9UTXNrSjUz?=
 =?utf-8?B?SkY2S3lvNzVQTlhEVmlHYlcyN0UwYnI5dnZLV1hVeDFJdWNCWWtUY0VCUHJv?=
 =?utf-8?B?WTNyeGZ6dngvV2QwKzhUbVJ0VTBzY0dQV0R2OVNVb3N1dkxrTkJ4b0RuT1h1?=
 =?utf-8?B?cUpmSDR2SjIwVlhpb2taNGFrcUNudVR3ZHJLV0c3TGtBT3BCTk5MZkZTUUNH?=
 =?utf-8?B?N1Y4ZVZDcnRoOENIcklKMnl0MWMzY29VNGpEbWQyNGlPaHl5RzhmMXJOelFv?=
 =?utf-8?B?SlR4cURqTTVid2VIUDcrWjJEUno0UHU1Zndaa2hLNGp3aE01cU1yQ1pqYTV0?=
 =?utf-8?B?cjFlanF5enliUGdiVkVqVUkrU25Idm5LN1VidU5UUVhVVG5uS2J6ZHBzc0U3?=
 =?utf-8?B?QmlSdExIeUROaDVGeElEUGxva0s4MEM0a2tObHZYT2tnb1p4MlpMZG96NERZ?=
 =?utf-8?B?VTBUYTdOVUlSUUZQaTlnWGNYWmtVYTlaUHZ3WFlKRWhqRTYwMldMVGRiV21T?=
 =?utf-8?B?LzFPUklVQ2pZMTlQSzF4cWxxeStRWTA0N2xtVmdCWXhhN0wyL2lIMjY1czR0?=
 =?utf-8?B?TUl4Sy9manRWc1d6MUVRMCt3QlNzUG1MRzRKWHY4YVg3Ynl4bzhwS2E5c2xT?=
 =?utf-8?B?QUROb3lQQjZFSHlrWmYrR3lacTJ3NTEyQWlUTEd6UkROci9lWTh5b2I3aGdG?=
 =?utf-8?B?YXhCblo4aU0yY1d3WTQzQnc4cys5bmZ2bGNQcTRFbTlaR0hRWm9Sb0x6Qkww?=
 =?utf-8?B?dkYzS3B5TDU3MW5ZQzBtT3VZeUhtOWM5MzlzY0VlVzFVOTJpelR6Nnl6Ujhk?=
 =?utf-8?B?S3o2OC90N295N0pVb3pKbjVSeS8zdDdVR0F4UjU0enBFQ2x0L0RFYlVpa0Z0?=
 =?utf-8?B?YzQvM3dsYkFjQnZRSjdZRWFKTUtsNWo2dlcxY2U4NlZBZnl6dHNNMjNLNyt6?=
 =?utf-8?B?U2daTGt5Ulc0N1A2eHZjdUZJV3IySnE5cllyNmVETmJjdmJCbnZxc0c4MDZL?=
 =?utf-8?B?KzlubStTR3JmQW40Q3lRSGVHTkdCdENOM3NEeGtib3BwTVFVaWE1dDI1eVlk?=
 =?utf-8?B?TFF0OWxsVHdKS2RSY2pydHNnbUpMQ0xGdnczSXV0N1JhRHJXTG51ZUwzYytu?=
 =?utf-8?B?T2NBazRaUFgrbG1pV0JmSUJIaHJJbm81Nm5jTXlsc0pITklOQVdtZkNVNVJS?=
 =?utf-8?B?RnlaNDdKbHQ2ZUtqRGMwWFFFcWQ2SEtqbkpIS1dKWHI3WmxHMU8rKzE3TWE1?=
 =?utf-8?B?YUY3eTh6eEh0VHRSZEQ3MEtBcys0VGwxek5RUTFhQVpXK1pCZmRnYlVRbzdp?=
 =?utf-8?B?TGdjUXByeXZxK0ZxTmF1cVdNc0lVVklSbkptNCszTVpwc0RBVkxhMzNJRGd6?=
 =?utf-8?B?NXFVY2F5ekZwOXNaQ2dQckYzZERHVFltR0kzYUxSQWM4SmdENnlXcFRlc2hU?=
 =?utf-8?B?c2UvckZQcmZ5aEZ3UGtkU1NYWHVOc0NUbnBySmJYME5OMjJQNlU5bWFLWUIz?=
 =?utf-8?B?eTFEbzRpTzI3NDhYMkN2Rk9qb29DZHh6WE1xOXpjR3cwVFhGM3AxR01URlpo?=
 =?utf-8?B?bXM4UktPajFaOGlPN2hyVFpJUGhDSk5scnF0VFlVcENmTnF4MmsydkhMSDVz?=
 =?utf-8?B?WHYyWmhFelR5UlR3OFlmcjlzRHl0amtIdlpsVmErS3BoQ3dRclUvWCsyVDFo?=
 =?utf-8?B?SFJrVU9EQUduQThadDFRQ3hnay9UY3pmMFFjSlBMUVFSZkJxWDhyNk5hRitx?=
 =?utf-8?B?VzVaN3ZtZVJTYjFEYUc4YktnVmdLNTJYUE1RamhvY0F4a3Q0eE1tcWFJK05I?=
 =?utf-8?B?SnNZSCtQRW13QVdOdElmdlMzVUFORlQ3NUNVWlhoSnNndXVpR2JCQT09?=
X-Exchange-RoutingPolicyChecked: wE8MzNl7MjRfTrACvIYZjAi74EauzmglKw/iBjo4ZRr4CJE6GlTLkPe7d77NeaL4/qNKcZHrHF+X4h+adrKgp+FyIRZcUyuSSUFPrkAYDwIkf6ukPjKcZLLx/1G2InOd2NR/jKgMcKR2HGz8sdKZVDz013jm/Bl4w65pHklEX8DMZAHJNrcnsMh5iVPnyfgClPaD/yrrzOihh8UelK+5Ho+PBnhJxYusqRS59jmMSNnn/O5gXJjVtC2PYNBpyWeeSzBm+C2eDwhnBCntkumBTzqnurK5+hnvBLNajBt9o681dDUvHNzH1MT4xxLXv8PwAf2vuGXSee7jaJAoZGwTYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ps6FfK7eoN284Q9tIPXSpF+eyagtVx9TsWW65xIH7/YnY7WkjwU7FJbwZUai2Q0UlAKiRutDDI9ljv37CmoHz5l28pNexG7dxpPxIAMulNtgLHLG7/SkXUM6en/O+vD30P2XT+IVlUOMyhfVMAIlRjCjTjxOsDnxrvKWiqc4Crx15vhsMX/fGTpLYuveB7kPeAIwGVL5pYQ7vY1qBi8ivSAvqQtduMRxqJg8FqpwBGSlL1Q/SXx4T1/PHLPK81dnyly4b6vUHHGOeXgFbN80s92AripG1qrNhODi+322W47cTDGkVbcBnVw1T/0YZuppegTcAL8eXa4URr56YFnZ9UdFF6CDIevTYTpBITEAwtJvp89+3V2nDzLueKTFK+zczEcVsGbgnpLSmgSncxfLnSKXKzWTSSv93CT9bx4X1V9KP4o/KFHdPSXcO4gHimc2Ggr1BTOfog5oi+ru9HyBvU4g2EhfTSDAupt4PiZHRtQJobHlW4a9NletdM1NkiBRiFHCu65JB9ZFm3YE0tkJi8byJCrN1e7gpiZ1FE2Tk+//4qUYDgJt3+f4tNz5vAbFDLCtbfXKfFc4AJc6V3FAKvMoDYgdWJyxxkkStClj/tA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62791e2-e25e-48e4-2f7d-08de8e657464
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:05:53.0517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1WG7VO2Hqg5kUXpHYAA9lzKgPs9GVc1+rHY6SJVVl4Vm9tmgOs4vkuqyICjHvuMsYRd+jprzkKFfmlot5zhmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300110
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=69ca8347 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=wF_JoFQq0km3OyNBZKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12275
X-Proofpoint-ORIG-GUID: TLJb8Cm35HO3kghi1bvW8wc53k7SnK7u
X-Proofpoint-GUID: TLJb8Cm35HO3kghi1bvW8wc53k7SnK7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDExMCBTYWx0ZWRfXwyoNv7SXsvvv
 B7HokB3L8XP13J7FY/Q/PBw1dQmUzbAmjxfSWiVO47A53dOC4wfucsVKOn+7MjYKYPvMaiIxXPa
 8iyo9MM0RBhOryD0WcNHUW8Nf5wh291b4gs6g7g3zqh/ul/OGdfnapjL6bft1shj3Oclg/q8huI
 ZpmtL+3TkVl7EAVUUuyu9HX7VqptKlqT5GLfPLWL5P/or8vIGiLYjRHYULj1MY3/OvQSERt9ysL
 bYgMNNle8GAAOMiAwEFri//HUki4TMwe1mCxTcqp+EW28jsCR2UiqSVvNuC5ejaPxJO2dNL7Riu
 wVsUcpYBtl7ojr072+0evc+MVYGe7VTq4YnLcuarFeTXiyoJI2ZHK3+oOffbPmV2L1UGhzTYhoe
 o0sK9bsjHznQRyENUVzmIaNag6AgqsgdINeez5rg6nTB1kQbxkeYsFoDpH3/lrwHdCg8efmj0Aj
 07gHCw7NU5TSiYfYcVOiWldFAe8CoN9WUixGqaGg=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/26/26 6:30 AM, Eugenio Perez Martin wrote:
> On Tue, Mar 24, 2026 at 5:48 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 3/24/26 7:35 AM, Eugenio Perez Martin wrote:
>>> On Fri, Mar 20, 2026 at 3:21 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> Track per-queue pending Tx work state during early migration time.
>>>>
>>>> This includes a snapshot of pending Tx state for active queue pairs,
>>>> checking for deltas at the end of migration, and freeing the snapshot
>>>> buffer during device unrealize.
>>>>
>>>> With this final delta signal in place, drop the temporary always-true
>>>> fallback in virtio_net_has_delta and return false when no deltas are
>>>> found.
>>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/net/virtio-net.c            | 26 +++++++++++++++++++++-----
>>>>    include/hw/virtio/virtio-net.h |  2 ++
>>>>    2 files changed, 23 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 3ee49a043a..483a43be4f 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -3943,6 +3943,14 @@ static int virtio_net_early_pre_save(void *opaque)
>>>>        vnet_mig->mq_early = n->multiqueue;
>>>>        vnet_mig->queue_pairs_early = n->curr_queue_pairs;
>>>>
>>>> +    /* Tx waiting snapshot for active queue pairs */
>>>> +    if (!vnet_mig->tx_waiting_early) {
>>>> +        vnet_mig->tx_waiting_early = g_new0(uint32_t, n->max_queue_pairs);
>>>> +    }
>>>> +    for (int i = 0; i < n->curr_queue_pairs; i++) {
>>>> +        vnet_mig->tx_waiting_early[i] = n->vqs[i].tx_waiting;
>>>> +    }
>>>> +
>>>>        /* RSS state snapshot */
>>>>        vnet_mig->rss_enabled_early = n->rss_data.enabled;
>>>>        vnet_mig->rss_redirect_early = n->rss_data.redirect;
>>>> @@ -4254,6 +4262,8 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>>>>            n->migration->mtable_macs_early = NULL;
>>>>            g_free(n->migration->vlans_early);
>>>>            n->migration->vlans_early = NULL;
>>>> +        g_free(n->migration->tx_waiting_early);
>>>> +        n->migration->tx_waiting_early = NULL;
>>>>            g_free(n->migration->rss_indirections_table_early);
>>>>            n->migration->rss_indirections_table_early = NULL;
>>>>            g_free(n->migration);
>>>> @@ -4412,6 +4422,16 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>>>>            return true;
>>>>        }
>>>>
>>>> +    /* Has any active queue's tx_waiting changed? */
>>>> +    if (!vnet_mig->tx_waiting_early) {
>>>> +        return true;
>>>> +    }
>>>> +    for (int i = 0; i < n->curr_queue_pairs; i++) {
>>>> +        if (n->vqs[i].tx_waiting != vnet_mig->tx_waiting_early[i]) {
>>>> +            return true;
>>>> +        }
>>>> +    }
>>>> +
>>>>        /* Has the VirtIONet's RSS state changed? */
>>>>        if (n->rss_data.enabled != vnet_mig->rss_enabled_early ||
>>>>            n->rss_data.redirect != vnet_mig->rss_redirect_early ||
>>>> @@ -4439,11 +4459,7 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>>>>            }
>>>>        }
>>>>
>>>> -    /*
>>>> -     * Always return true for now until we're able to detect all possible
>>>> -     * changes to a VirtIONet device.
>>>> -     */
>>>> -    return true;
>>>> +    return false;
>>>
>>> I'm failing to see one thing: If we add a new feature that the guest
>>> can change during migration and it's only added in the
>>> VMStateDescription vmstate_virtio_net_device, will this "return false"
>>> prevent the state from being resent in the stop-and-copy phase?
>>>
>>> Mandating its addition here is ok somehow, but I'm not sure if I'm
>>> missing something.
>>>
>>
>> Correct. But this is also the same case today. That is, any new
>> migratable device state would still need to be added to the appropriate
>> VMSD/subsection. For example, if today we added a new member to
>> VirtIONet that also should be migrated, it would also need to be added
>> to vmstate_virtio_net_device (or the appropriate subsection).
>>
>> So it's not a new *kind* of maintenance burden, but it is an additional
>> place that'd need to be updated.
>>
> 
> Right, we're on the same page.
> 
> Half-baked idea: Is it possible to update it only in
> vmstate_virtio_net_device? I'm thinking in a method to store only the
> relevant fields by iterating vmstate_virtio_net_device, instead of
> manually coding each if (n->field != vnet_mig->field) return true.
> 

In the next version of this series, the different delta states will be 
explicit sub-VMSDs so that the destination is updated only for the 
specific state that changed, e.g.:

static const VMStateDescription vmstate_virtio_net_delta = {
     .name = "virtio-net-delta",
     .minimum_version_id = 1,
     .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_net_delta_status,
         &vmstate_virtio_net_delta_mac,
         &vmstate_virtio_net_delta_mac_table,
         &vmstate_virtio_net_delta_rx_filter,
         &vmstate_virtio_net_delta_vlan_filter,
         &vmstate_virtio_net_delta_guest_offloads,
         &vmstate_virtio_net_delta_mq,
         &vmstate_virtio_net_delta_tx_waiting,
         &vmstate_virtio_net_delta_rss,
         NULL
     },
};

static bool virtio_net_delta_status_needed(void *opaque)
{
     VirtIONet *n = opaque;
     VirtIONetMigration *vnet_mig = n->migration;

     assert(vnet_mig);

     return n->status != vnet_mig->status_early;
}

static const VMStateDescription vmstate_virtio_net_delta_status = {
     .name = "virtio-net-delta/status",
     .minimum_version_id = 1,
     .version_id = 1,
     .needed = virtio_net_delta_status_needed,
     .post_load = virtio_net_delta_status_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(status, VirtIONet),
         VMSTATE_END_OF_LIST()
     },
};

------

While this approach wouldn't fully automate delta detection and fully 
eliminate maintenance requirements, it should help a bit. Maintenance 
then would look like "add base state + delta VMSD subsection (if mutable 
after early send)".

With your idea though, we could automate that delta detection part, but 
I still think we'd need these delta sub-VMSDs to tell it how to properly 
update the destination.

>>>>    }
>>>>
>>>>    static bool virtio_net_needed(void *opaque)
>>>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>>>> index 88074a0976..dbbacc83bb 100644
>>>> --- a/include/hw/virtio/virtio-net.h
>>>> +++ b/include/hw/virtio/virtio-net.h
>>>> @@ -180,6 +180,7 @@ typedef struct VirtIONetQueue {
>>>>     * @guest_offloads_early: Guest offloads snapshot.
>>>>     * @mq_early: Multiqueue state snapshot.
>>>>     * @queue_pairs_early: Queue pairs snapshot.
>>>> + * @tx_waiting_early: Per-queue pending-Tx snapshot.
>>>>     * @rss_enabled_early: RSS enabled flag.
>>>>     * @rss_redirect_early: RSS redirect flag.
>>>>     * @rss_populate_hash_early: RSS populate hash flag.
>>>> @@ -201,6 +202,7 @@ typedef struct VirtIONetMigration {
>>>>        uint64_t guest_offloads_early;
>>>>        int mq_early;
>>>>        uint16_t queue_pairs_early;
>>>> +    uint32_t *tx_waiting_early;
>>>>        bool rss_enabled_early;
>>>>        bool rss_redirect_early;
>>>>        bool rss_populate_hash_early;
>>>> --
>>>> 2.51.0
>>>>
>>>
>>
> 


