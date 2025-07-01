Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C8BC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwS-0005U4-4Z; Tue, 01 Jul 2025 10:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwP-0005TP-DY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwL-00028I-H1
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9AOX023999;
 Tue, 1 Jul 2025 14:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+b3F/9ZmMy1YL7ojGtfq9Enan0GwJmxePHwCGSc6rXE=; b=
 VFMsbo5jSCukVHWHnWYPi/BHry9Wv1enDQBnT6WG8F4OzkNf8Kz4bvgBTfhf0FU5
 p6aY1xRsvQaAXBgOwJAi8HnKoS4FBcR7b5MYmR0YX/GlcJ9WcOAzYaMpaS2+SoGW
 LnUq7PMAVJSNm8OQd51pyXy/50R9zJhgaNQiKgy/GBA509lkJajBhNGcqThY6dy/
 c19kdPGVv/6qslOV0RPMxs2UONk5zSx5AkCg+VfTAjcQNY4pdr87p5NjigGkdCY4
 iIdRbsPypTrc9vEY66P77n5NVCkFh++uovBll44/Pl31bkOL4bYI7w70wRcRG265
 yzJiSbVmiKfR6/NDdBA/uA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w4u6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWGj5033604; Tue, 1 Jul 2025 14:26:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6u9ugq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRyKtOYiuUFlcjQN1MTMRmZfXevAD42ac8xdta+ZPEHtWOHgmiIrEL6EQOk60YWYScYfFsacyduqaKjMAr3aJOVZenidiEOtV+1qYf7UZO8WHivy89CMz7enQY0dnHbwDvrzODhvSSbfB1zYYLNGDqGokY6D0yKQzkVG60H5z25WouxMfE1L84b5/Iwda5so68FwAqBHITHxg2JhTRkv5HgVKKRPV4Y40KJAUM8csrgqeNSdx2u5R0CQLu1+fcucls6/a5CecOdyKdPqI90kRdao8HKi7f205VfIvmsjiHMgINQqSCnxcNZZsEjssfYBtBrBJACrqgVptrwwAE8MBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b3F/9ZmMy1YL7ojGtfq9Enan0GwJmxePHwCGSc6rXE=;
 b=jvrtPHE2w/3wykR27ryminBq3DfbfbeMJPcCMGSTtNQNpuBGTPjJdANtRsqUqwiVGuVeEXnev/7R6LOGRlADMJTsb9eYjvLgilYU+J8k4biCLaK5kV4wmZHD6rK+kWD7M7uplsmJ6OX0cNzYAeg77XgNGnGc2QDG0xUIjoIQtHCzIe0bv5PyAYbpaTW2YrkGYp8dwlN9hGblw2eVRVwYe/+QeZy2cBchRVT6LkzWFspFOJh8OcEt1ml8Xz/sefMKNyyV5Bpj5IGahXnO5c7Tvw0YY4P4WZemT3Mx+vByU0tc0Q4tDOBMDz1LdWQF6SrhjttMcoyW7NfBFNDdsnTrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b3F/9ZmMy1YL7ojGtfq9Enan0GwJmxePHwCGSc6rXE=;
 b=gFixKYxN+9VujEb7pc8XOHcWQbUYH5UVZmw1akPRM8sDHXIy1KtPfkfIOdPo42xLVCbrGrGWIQxl5OUGzUD1cOXTJ8Az6DJdRIfiKzKDXzXNYiZpj9pCKmTYVmCCDahlwHCV2tICyJjfO1GhWfrLnVZ2wfRJ9FHOmdavem4ockc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:26:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:17 +0000
Message-ID: <622bf043-49d6-48b0-af93-73bb7f3dc415@oracle.com>
Date: Tue, 1 Jul 2025 10:26:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 33/38] vfio/iommufd: reconstruct device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-34-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136ED60B695DC51D2C4C3E1927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136ED60B695DC51D2C4C3E1927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: b62a1cbf-200f-4977-14e3-08ddb8ab3e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjNlbFJOOG95YWF3aWdaRElOUzBhN1pkVzkydHZGQ2ZqaGsvV3N6YlVGSkln?=
 =?utf-8?B?NTdCaTZzNVFYY0pLTjBYQXZkUHNaNVEwZ0F2a0h0My9oTWRjR0EzYWxINjVo?=
 =?utf-8?B?eVA4akdWSWNtQzdaMVd3UVdaTFF5S1lpS0hkQW1rWUlyU3ZYcVB6Sjd2VnJl?=
 =?utf-8?B?ZnAyZytxTldobnhwbXdPbnRCT0xNME9hdXptOHRjYnlrSVBkZHRFSGx6V2NU?=
 =?utf-8?B?SkhuTlc2VC9rZ3B3WWp1YVpDaWlISVVwYklsMnlzQ2FhR0NLT2JRazlpLytQ?=
 =?utf-8?B?YUU1Vy9sNkM2YU93MzJUMUF5ZnRuUkpBK1h6ZGw1dVlKV0QrbzUrSExCTWdV?=
 =?utf-8?B?Wlh4dktpWGVUK1IxVXdhcXJOVVFSMUp0ZHJrbk5Gb2pKckVnYjZXL0xoY09J?=
 =?utf-8?B?ZzZGaWR1eFcwQ29DbUIxYXpoM1lydStmMFhHRkI5RU1EZVpJcS9ud08zRVpY?=
 =?utf-8?B?bnB4MzBXU2NUSUFXZkVMY2JmeGtHeFFxQWYzT203eFNtZXZSUnNpcGxiRXdo?=
 =?utf-8?B?SWlwQ3o0VjBtWmpjTG0vbHp1TFArK29FUVdtMlpReDRJVTJaYWl5S3VteXl0?=
 =?utf-8?B?OTFwaG5YbEU5U2w5QnpHUnhEejN0bWgyUDBybTdaZUVMTkV5UmgyazU0Qlh5?=
 =?utf-8?B?TnMrYzJlS2o0RmRtTXg5RklZRURVSmtZUWFDVFRRM3BuQmduVFc1a3dyMDgr?=
 =?utf-8?B?ZE9LV2NycmZPYXVWR1FMVzZtc2RjWjRpeDVSZTZvUjlsZ0lBUitPN09hZ25O?=
 =?utf-8?B?RlJKUWJHNExCREpsQk9ITFdPMWo4UVNYTFlodjlpMTBWUlk1bGZxNFNIMklS?=
 =?utf-8?B?QTVVZjlOa0I2UnZ1OTdQTFFINUk0c1Zzc2FqdHllNzdpR0QxZHZCNjVFM0VE?=
 =?utf-8?B?RHloaHNvYWthY25weEJ4V1Y1ZEExc3N2b1haa25pdGozRmR6ak95RmJSdFE5?=
 =?utf-8?B?S2hWSnk4Tzgwb2cvd1d3OXpMSTFodXRYQWNpZ05EbTllN1hoZHorUjE2R291?=
 =?utf-8?B?M1VkQXhvSkp5WXczb0ZsUGZleWpYRVFOM1U3S253Z0JGc090dnduZk5BcCtt?=
 =?utf-8?B?eDl2cTdaZFNCR3dqR1FydTZtODNFMzVmS1hWWEJmRjNieUs5bTdIb2FFN0Zl?=
 =?utf-8?B?cktobUNhWDVzYXc3SGU4WEE1RlhFbm8rOTZDTzZoK0NVcGN0TGltNVArVzU3?=
 =?utf-8?B?N2xwbks5alU0ZWpzZWFXQUlFUndGUmNuL2F0OElWMVRpRWh6dVY2a29tUDFt?=
 =?utf-8?B?L1RYanAvNWd6YjhQMTZHSk4vVHM1YldOaTF5aEluak81UWFiS1VYT1l1K0FW?=
 =?utf-8?B?NHBWaWhiSUU3RENZQXhPcWRCVksxK0NUOXlGdGlobHNlNXVLRDNJYlpsdU1U?=
 =?utf-8?B?N3l6aExFMFdGUkNXTDd0UXp6WEJ3UFNvcnp5Q3NVZjBZT0hBclk5RVhSZmdP?=
 =?utf-8?B?R2o5ejRNcGh5bElTdTRZR1d4N0R5NVU2UGFXcFNiTnZsSEFpaEpTTnc0RmZJ?=
 =?utf-8?B?dzJ0VlBHaGVpTHd4OG5LVnhWdk90cGNNUFZ5L284NWo5K0pwOVFvTVZSZFBI?=
 =?utf-8?B?UDRLakRmZFZ2NkIzZHpaQVlYYnJqa1lqUjdrcGVZaGhKcGdEZEFQS0Z6SlNk?=
 =?utf-8?B?cWd2YnlWQmdPQVhiQkdBdGpaL21MMnFNWWd4cFcwQS9TR2lTYUkwei9NVk1B?=
 =?utf-8?B?WXg2cVJSbTk0UVM0YmlGYy93dEo1R0lFKzlCTHFIVDZDQloxbDBteHhIaGc4?=
 =?utf-8?B?RWNmeFhqWUl2U1M3RlNTTW10M3RsYTdEdHBjc2dBay9mZTMrWjRlZWZ6NmZh?=
 =?utf-8?B?NS9yd2ZpY0NKS25vWVF3Q2tzVy9LVDBGb3MwWDNWQ21Pc25wY2o1MVA2WFNF?=
 =?utf-8?B?Zi9zQTN6bXEyanBKY3hpMURSZWRjTlloMUNvbFdJVU5CTnc3bTlZWG9CQ1cv?=
 =?utf-8?Q?FUWG4hgd/9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtVdUpQcmMrZGxvWW04RkpnWWsrL0Z6ck9BeFZ6eHJwZmFQUDJGRUVGN0Vi?=
 =?utf-8?B?QUlTTVFKU3FwTzFGNzBkWGl0ak5aSmdDSTB5Nkd5cWp6cjFQV2k5QytkRzFk?=
 =?utf-8?B?WGVVOGtzcEkvblg1SjB1eDFSdTU0UnQ0aGVYTlpzZlpJMVpzRUlhRkp6ZTg0?=
 =?utf-8?B?RjNQaE5ESGtqRTJ6TWtTOG1SZUhGV2l3T01WT0ZyN1JqMHZlYUx6MkpQaEo0?=
 =?utf-8?B?QVZYRGMxcXYrVjlWSFBkYW4xRUhDV2FwWTBFc3ByTzJGZzdSK3VWdTdMbGJ3?=
 =?utf-8?B?NG5CSEh3clp3UStUVVY5T1FuTk1VL0ZmQUtXWUgzVE1zU2NnbThpVSt4TC8r?=
 =?utf-8?B?bHdwMWljUk45NEdVQTRXY1E5QXYzclFWUFdMYnFVMHo2SEZtQW5SWGhPclJq?=
 =?utf-8?B?c28zMGJTcGpLQWpnWnR3TEI2VlRrWEpaTVlQNnEvQnRFSEFlZXhWS0o2UFJr?=
 =?utf-8?B?ajRkYWVMM3diRzBpdVg2dzE4WnFRQnRSVjlRUFY0TTFTMzhHNXM3TC92ZC9k?=
 =?utf-8?B?YUFCM3RxNzdOSmxVOWw0cHFrODFLT3hRemdIa0krRUJLa2w5a0Zld2I2WnJ1?=
 =?utf-8?B?WE5kZVB4VkY3VVhDUm5XODYzQzVIbjlyVTIvUmo1WE1maVFXNnFOTUVYL0hK?=
 =?utf-8?B?NkI3UE50VHhJeU9SMHloT3g4ZWluV2dDeVZaUEp2N0hnOE9XeUZaaTNVWTA5?=
 =?utf-8?B?Slp1ZGZTU28wSmJBcERYZG0xSmpJKzNQbXhOc1ZzZXM4L0F6VHlUaGpkcTZl?=
 =?utf-8?B?UzlSUzJBU3JMdWlXSkJnNW5hdVVkV09zSndDekxuRC9FZ1B4SkxZY1hmMS80?=
 =?utf-8?B?QmRJZndhQXVKeWlLUE5SUmVpTlVoNSt2OVRQMXdPODNIck1kVU9rbitJSWUr?=
 =?utf-8?B?NkFCeXhWSnBMNjJNckJ1eVhQY2VvNjFqaDJmVkVhUVRmZjh5TkMwNGo1b2Q4?=
 =?utf-8?B?REpVdmVQYThNQ0xuT1RhUUdqNElQWWlSbk9QeDF5VHhwU2JWL21NTEtCU2lr?=
 =?utf-8?B?aE12TzMyZFFMYnh0d1U4RzZuK0d1ZmE3TGhkSmROdkFTcXcrdnRvR3VSTmYx?=
 =?utf-8?B?QUpNMVdvcGdPUW0wRkU3dDAxeTI4UlZST0NWOTZFeUIwQldSOCtJUE9oeXBs?=
 =?utf-8?B?YlEwWUFxZ0hoM1VOM1BhQ1ZBRU9oMGRYNzkyeExJN3g5c2x5aVRkSVRrU2s1?=
 =?utf-8?B?UlU1cWRUaW5mUnpMdmkxemEwVTVQMUp1a2laUUhlazdnTFREOXZEMmhjTGdD?=
 =?utf-8?B?bnlJbWJNd25HYVlPdnl6aCtWdm9DdUZKVU1XMnI2SEtSckRNU3dUa1NWc3Fx?=
 =?utf-8?B?bnFseHEyY1lyMDdBMGZDRFBrUCt1bFdsNWl1VWVmYjR4Sk44OVNKdFZnaGdi?=
 =?utf-8?B?MXNrUWdxbElEYzVPa0ozcTZSVzJvUDdQZUVMRmlZK3prRnRnVC9yVjJ5N2k3?=
 =?utf-8?B?bTY2ZkdSS2VMUHBTRVFpdkZvUmlJalJTWmNhUWVZWEk2UnNCSkZ6b0x3MDli?=
 =?utf-8?B?dktMTG9wUERsdkc2REU4ZUdUR1hYT212ekpScExQTzZzM2pVeDdYRStYMVRm?=
 =?utf-8?B?QXJDS0d3WlZnTDdZNDg4MXpZcnM0TXNPTEY5UlE4bXFoVTArdGFRYnVFUHNx?=
 =?utf-8?B?Q0JVU2p4d1lwdEI1Rm02cVg0aXV4ODdOUm9YZW1ZcHdDZjZubE1Vbjk3N3BW?=
 =?utf-8?B?V05GMGJhTnR0NlM1ejdpVGxibWFaL3cwUklrK2pkRnZzS1YraTFrWmdmNk1O?=
 =?utf-8?B?K1ZPVEduVWJWZG1JT2JnOC9SK2Z1enpBVTNlakZ1VGVzVUNWcDcrQ1luNTc1?=
 =?utf-8?B?Y2JhR1ZlNmhTRnVqbTlMZWlrN0Q0Rlc1WkhmeG8yT29nQmIzSnFNQnhuVElk?=
 =?utf-8?B?djVMeTRSdTVMZjF6ZWNNTlVZZlNVSVRHbm9IaTVjQU9PZGlBQ1d5cE5Tb2or?=
 =?utf-8?B?elAwZ1JuTE1RbjFHVzVwSWcySHB3cjZoYVRjY0lTb2Q4ako3UGNFd3NqWTVs?=
 =?utf-8?B?ZUhyN1JHZm1xR25DaWQ5NnZrRGMwWU50TmhKS2V5M1pRNVZUTlNhbDZsUGla?=
 =?utf-8?B?TW5DS0Z4TDRZRU1UczhRMnBpaERMTW1XNS9iWEo4YTdDanJsVk1QelVGV2kx?=
 =?utf-8?B?UWNWblFHTktWelQvYzlHM21vSTRTSkNDMUFkeHdHVjh6YUZyT2dPMFdaRjBK?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SX5jc0wNTaPX4zfhB8tFdMmiFRhP6rJo8gjoo8f1uJY8JsDnjwCY651MJc2p3sDgcqR/IrshmBfJKKfwHOTLUssjOrRCqlNrWMElK+iRunaeuJzdzBRVw65a1N58CLRLfDT4Iqmgc/blM2C/TM74YXSakkpigaloBnbOZucw72X1eFamIfJUt1HluhtEWX5CXQEg2PT5B1g47RVSU4t2PE6CNWcbx/nMVLIfTXsn/1gl864JabCQ96rXBXZHKKA5tI6F7SwrC1Ig64yiIZAKoo1ISLHJVpx/RIXqyflp2DpnBDx3nmU2L2hOnqsu4bj1LYWAaKptQSFE+IlZKpjZ5Gn5r2cqVnZJK2A0qjpUltcD7P/+tsMj0uHUjU3jQT9iZ7iroKAgJGLNKs78fOUXp2gNMo6m62g57IJYM2/tZdcUrFysGNEmr9PD2kYhYHNeJ0dHtYcXIep7ZmMwRFiGkURB2Sie21npeJGuwFwPlhS6rObqG1nI42qGqsRZhzV+TW4VfHXYZDCJIxFNppoXwILp1rJd1TcgJp2i0ERkUNd7xT/1/kuvJVvBB/Hwso+TMZvc6KU1tOYBU8IjC6ZTYx3vy8573icFwYGJ2Oc/3xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62a1cbf-200f-4977-14e3-08ddb8ab3e03
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:17.7273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/8C2aLGsC++xWW+Padv8IFHTm8OWX0//t8W4BlrLOEXUe0OPqyqjTf8UlioxEVyIapKpMmhdM20nLSW7sJMl/2Ovm6HPQyYkqWR/aC870c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010094
X-Proofpoint-GUID: WUrfjLMvWk9BIUmFDV-LEDDbt4M1xgjv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfX4ClaQK8WJrOy
 8rCLHF2VeZf6u0hYDobeGllqxUWyHlvgHYf6pmbZRx3ov1bbBkUNttr/Fbiuk+R4xek9EKMzbbs
 ZvFJHAN69ZV7pS6f1bGWBYk+7mgN0p82Mj3zPSrlJ+MMs6vsAf1/Nj01snkZDfr+T/f+fDtU1dB
 9rKzPLT1hmBWlCJ559BQOjlC9YTwAGfAe7ahR/uIvuGli2Xp8SvFH7Wh90ocF7FErk5OhMjqf1s
 E447T50OR3cMujUcffCDBTRxxoEbJMPM90jbKf8bk8Jdwz8PvN0h06m0vCawqv4RrNCU5PUXsEC
 tRwUuCYn9HFcwwWSVJOqrro6UTp0Mj/IfDQYeed38O2Vzxlfcm6V8vbhEXzEzVQtmAiVJh6NKKB
 3A0Tku+h2ws+iImhfZT5HhK6Zw/9tWnBboRRIlzASCJLd4qHj3q1ggYqiV2bwh4XtkWScQYv
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6863f012 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zViU_969gfVu1lBoOIYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WUrfjLMvWk9BIUmFDV-LEDDbt4M1xgjv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 6/25/2025 7:40 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 33/38] vfio/iommufd: reconstruct device
>>
>> Reconstruct userland device state after CPR.  During vfio_realize, skip all
>> ioctls that configure the device, as it was already configured in old QEMU.
>>
>> Skip bind, and use the devid from CPR state.
>>
>> Skip allocation of, and attachment to, ioas_id.  Recover ioas_id from CPR
>> state, and use it to find a matching container, if any, before creating a
>> new one.
>>
>> This reconstruction is not complete.  hwpt_id is handled in a subsequent
>> patch.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/iommufd.c | 30 ++++++++++++++++++++++++++++--
>> 1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index f0d57ea..a650517 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>> #include "system/reset.h"
>> #include "qemu/cutils.h"
>> #include "qemu/chardev_open.h"
>> +#include "migration/cpr.h"
>> #include "pci.h"
>> #include "vfio-iommufd.h"
>> #include "vfio-helpers.h"
>> @@ -121,6 +122,10 @@ static bool
>> iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>>          goto err_kvm_device_add;
>>      }
>>
>> +    if (cpr_is_incoming()) {
>> +        goto skip_bind;
>> +    }
>> +
>>      /* Bind device to iommufd */
>>      bind.iommufd = iommufd->fd;
>>      if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>> @@ -132,6 +137,8 @@ static bool
>> iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>>      vbasedev->devid = bind.out_devid;
>>      trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
>>                                          vbasedev->fd, vbasedev->devid);
>> +
>> +skip_bind:
> 
> I'm not sure if we should take above trace for CPR..

My thinking is: on cpr, we do not connect or bind, so we should not log it.
iommufd_backend_connect() is called but it just reuses a cpr fd, and we
can observe the latter with cpr traces.

>>      return true;
>> err_bind:
>>      iommufd_cdev_kvm_device_del(vbasedev);
>> @@ -421,7 +428,9 @@ static bool iommufd_cdev_attach_container(VFIODevice
>> *vbasedev,
>>          return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>>      }
>>
>> -    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>> +    /* If CPR, we are already attached to ioas_id. */
>> +    return cpr_is_incoming() ||
>> +           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>> }
>>
>> static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>> @@ -510,6 +519,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>      VFIOAddressSpace *space;
>>      struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>>      int ret, devfd;
>> +    bool res;
>>      uint32_t ioas_id;
>>      Error *err = NULL;
>>      const VFIOIOMMUClass *iommufd_vioc =
>> @@ -540,7 +550,16 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>              vbasedev->iommufd != container->be) {
>>              continue;
>>          }
>> -        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
>> +
>> +        if (!cpr_is_incoming()) {
>> +            res = iommufd_cdev_attach_container(vbasedev, container, &err);
>> +        } else if (vbasedev->cpr.ioas_id == container->ioas_id) {
>> +            res = true;
>> +        } else {
>> +            continue;
>> +        }
>> +
>> +        if (!res) {
>>              const char *msg = error_get_pretty(err);
>>
>>              trace_iommufd_cdev_fail_attach_existing_container(msg);
>> @@ -557,6 +576,11 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>          }
>>      }
>>
>> +    if (cpr_is_incoming()) {
>> +        ioas_id = vbasedev->cpr.ioas_id;
>> +        goto skip_ioas_alloc;
>> +    }
>> +
>>      /* Need to allocate a new dedicated container */
>>      if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
>>          goto err_alloc_ioas;
>> @@ -564,10 +588,12 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>
>>      trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
>>
>> +skip_ioas_alloc:
> 
> Same here, others look good.

During cpr, we do not allocate a new ioas, we use the one from cpr state.
I think it would be confusing to print a trace that suggests we allocated
a new ioas.

Perhaps I should add a trace in vfio_cpr_find_device:

     trace_vfio_cpr_find_device(elem->ioas_id, elem->dev_id, elem->hwpt_id)

- Steve

>>      container =
>> VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>      container->be = vbasedev->iommufd;
>>      container->ioas_id = ioas_id;
>>      QLIST_INIT(&container->hwpt_list);
>> +    vbasedev->cpr.ioas_id = ioas_id;
>>
>>      bcontainer = &container->bcontainer;
>>      vfio_address_space_insert(space, bcontainer);
>> --
>> 1.8.3.1
> 


