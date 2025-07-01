Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D1BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwL-0005Q4-25; Tue, 01 Jul 2025 10:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwG-0005Ou-KE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwD-00026o-8S
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9PWv024325;
 Tue, 1 Jul 2025 14:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=WHSPwUz9wXIu7O1cfDNksh184LuHML4EF5BJCgO0h+I=; b=
 bri9FrrfGxoKtaFxph1dfJaAgPOHu8u714+NjTHscsfzjflSbE7qYTaG43+UdMZm
 799vMCntLg5Yvunmyqdj2z1n2I1D8A/EM6uWlN5Ck7RXEEQC7SHwDgCE4Q/LZpOM
 PYiQi6emn03F26nSkXzBvWbcCaIvWunohQ0UagaBJtDL+PQhctmTn8NP8sBc94NW
 gZL+rhxw7mVh4KR4kmE8hnkCy9QbJZk1bTDz3KkOHmGWduo9866HWtb156Gj4mfO
 xrHOUJ0f9WRqt4ybR+e3Hya3EmWNnxjwf2uEJe3itIy5hU967Dg8/CLCYwvZOOPx
 4NTiMun/4vERjdll9wuUhA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704cx0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWIG3019568; Tue, 1 Jul 2025 14:26:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6u9kkpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOMeXOh2ZykEav/WqnVXDAJ6IvXC9VweHrQp/7nhcKJ6yRlcBaZtt41FfntjnnI6ZNc3wOuAz3+SawUsv/0sEXaZSD0eUARNhKZrUbiv+i6iENXUWAk/2rm9vTmv8k7+f1wFZjXn/wFnTSCoajG1esTyxb/0QxUSFhl2kRWA2EEOZm1AO1jUqHhGX3oDM2Hcpo5UsJ1k6vG3Tzdzn/XoZvxNwtpldmfk2JJj6SF8njsyc7DqOXrne+T+eajDBxEwj50d/eCa9JUcNMBYZd8wB/MofDTfG2Rik1C7RCdMzOZ3yw5PqWPlN4wgM/VEw6n/Z8U0jgCFPHCgBg2y0cDdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHSPwUz9wXIu7O1cfDNksh184LuHML4EF5BJCgO0h+I=;
 b=QQX6xXSEgfn454F1jqp3pGuD3cnb3m9CZJTFKEmHDcqo/jZyTIOid8Aj/wbJyoeu8BhM4v++llABWJjkIodrNRBGv85UZjg00D6RCmMK3gTUvj7CrTRw1uMJw7DYrFYJc4oWm4atbCAJGSzFm61bQjzSEpbwSwjlK9tLZEy3X6QqlOntAzSrEhuUX/qc9aVXCf0iOKCOw/tbPr6t8jEi1qPJoQrJ7lb2SI3v1mWnAd612RS9BSuhR3PdCDG2h9Ii0r4OzkWkitr/Bx/ByhI9djRHp5u9kBtFMI2ManArJdmpHx3ribzTLKMXGCZuGXy5aVYl6nfRocmG2780SimKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHSPwUz9wXIu7O1cfDNksh184LuHML4EF5BJCgO0h+I=;
 b=depNrXytnDBG1HpjWc7HVeE3rCkzNQbTBGXyaKWyb/O5EiYn5vZPElgpQ3PWEspQI2qEi2IRUdU/7vAioalo1J1qxs2fbrHc36Olx1MsduAEC1KKqdBVpPnTug6zHHJdbFt92AfNWtn7XeqJ8ZFl7QYVMg55zCcWE4e9er1rCts=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:26:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:01 +0000
Message-ID: <a9ec6164-3c4b-4807-8954-b3cf1ffe3bbd@oracle.com>
Date: Tue, 1 Jul 2025 10:25:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 29/38] vfio/iommufd: register container for cpr
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-30-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-30-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: eb29f08e-c92b-4e59-9fb6-08ddb8ab3442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pQdUp0SWtkcWZrR3ZJbnNzZXNPS2RCWFpGc0ZPZ0JLSTBleWpiOUFPM2dR?=
 =?utf-8?B?bGprY3JjUTBCQUdDdGY0bEROWUYvdkV2WWpidXhQZXlaVjZHMWlmaDU3MFNz?=
 =?utf-8?B?SmM2ZFptRjFjT1RVZUNZVFBTbzhFRnlvZi9GK0Q3S0RwVEtHM0U5NGZJRnVN?=
 =?utf-8?B?YXZ6K0RzTjhRWU1SdzRocmVxbHkya1F2L0NIV3RJQXVDNjg5QUlhV0dYa1li?=
 =?utf-8?B?Vmh4UnlEZVc3TTBwa0E1L0lQaDAwd1ZmbWd4b1JKNlRaSjFxRngxU3NFcjVz?=
 =?utf-8?B?ODFrR1haWi91WlBZU2ltRVorSkYvRG9EMDJuRk1sRkdKSSt0ZTNlYkYvVFhM?=
 =?utf-8?B?QUxiS2pTNW1VTThHZ3BjK3B0TDBUUkR0SFRQMmF1NjRuWDkyUlRVMDl6TVZT?=
 =?utf-8?B?RkpUQlB2N3RlMlJRUkNHSFREdlJ4L1ZXZ0JYeS8xc0ZzS0Fma2ltNml0NnRk?=
 =?utf-8?B?OFk3VWhjT1lhTVBRV0NiL29YaG9PWW5rcitmY2NZTE52TkFCcVlUL1Fici9a?=
 =?utf-8?B?cUtFOE5BaHcwQkFBNndVakVBUXRCVEJMMUM5ZFBURE1lcTFjL2tXSTFaSjFF?=
 =?utf-8?B?aVFUSlpGckxEQk5qYk10RlBkWU8ySUVMS3pCalpHU241bnJIZnNrVlNoRjll?=
 =?utf-8?B?RmFWM25KWVQ4OEJtcTNYRjJUamNPekRuRFFvWEM0QnVEaDNmbUZFbXNnMG91?=
 =?utf-8?B?VVRoVXlVMitObkhBK2h4RHBiQ25wTysrZ1hoNTJZa0xoeDk5WmtZY0pxQ1NC?=
 =?utf-8?B?UDRuNldpR2NXR3BBdEl6TVdOdVhYREZJbWluZHZVY2xuYTJQZWM2WklpWDha?=
 =?utf-8?B?cFRXTGQ2ckZqMkhYVnFZRlNPSEFzbEN4UTlEK1QzWTRtR1FPMVZGTzJDOTJr?=
 =?utf-8?B?RENubzRMNFVoZEZ4RXF6dzV5czRONDVGZ000ZlZ1RElSQTJ1Y1p5TGZyeVdz?=
 =?utf-8?B?a0Q0NUdiSzRkVmJZK3ZwNmEvdTJVMDBKSVRQWVhLcmlsVWNzSjFrd0U2b3F6?=
 =?utf-8?B?TXhiNkJrc290SGR1VlFxdDJyN2pGckoxOG1QUEV5K3ZEZ0dZcEplMXJ1STlW?=
 =?utf-8?B?WjQwWFJWd3duY3p4ZFArYU14dWpIT3VwQmE1R3d5VWk2ckJidVFZYUlIeEhs?=
 =?utf-8?B?Z3B4RG40Y2xTNDBTTU1PMG1vR20rbit0NENQbmZ6cG4rK1Vqdm4vdXJaVWRR?=
 =?utf-8?B?L0xBRG9zSnpHVEJlOVRqMnlBNDE1UXFIMzJvVDRJc3pHZVg3S0xPSmlIdnNT?=
 =?utf-8?B?YkcxTWdmRW0zZVNUQmVUVUxGdEZrOURMN1VyczRFcW0xTDBtcHpIRzVuMGJL?=
 =?utf-8?B?bWpKNGNUZVRwazFtRWxIOW8zNTNSTi9zV3FqU2tvMXJVWjFwa1UzNjMrT0hl?=
 =?utf-8?B?eEZpbWZTVjdCNitnMVNSek1iN3lMMnFUMGVvOGNLVFhJQnFPVXIyOHBpSDlR?=
 =?utf-8?B?akRDR05hQTdoKzFlSkx1NktFL01UVG9tUWlvS2ZuYXEwVURCdlJnWWJNaHY5?=
 =?utf-8?B?dEpPM24wajRlMG5mRnRwUEJJcGVGN0FjMUtOaUZGRzFnSCt4TzdJN3dmanlt?=
 =?utf-8?B?d1pxYkE1REJrN3NjbVhKUmVjV0FXMVNNaUJoQWprcklXLzVrSkFVU1BWS250?=
 =?utf-8?B?V29PK0xoV1dacGpBaVl5RDNONmt4eFhFWXVQWlF1Vlh5OUdFdjBneFNQR1pa?=
 =?utf-8?B?cU0yOTRkbFJLR2xFVWNHczlEQ0kyWnk2VGUxQ002WnVFWjBqa0JXMnE3T3dW?=
 =?utf-8?B?ZlhJZ1UreklqS3hKcFlCZmxxdG90ZnNDRXNyeDlpeUcxZlpXaDdUUGhzMGRi?=
 =?utf-8?B?MTJldGFnODQ0YTgxZU1YcHQwS2dzdFN4TEwvYVpJR2VnZ2Jsc0c5ZHphYmJu?=
 =?utf-8?B?UTNLUEpuMStqYStZT2czUG5qQ01oNkhDWjd5dCtnSU9KNkVGWDVELzFWRkpS?=
 =?utf-8?Q?njt7LHDvbFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YklZa1BBdEIxcEZWM2VYcEdtZmFZVHJ0Z0tadHQvc2NRcEY1cEhYeXY0SWc2?=
 =?utf-8?B?R2ZtT0lpOEozdlY1aFpvMnVtSWJqcS9DelJFdHVpYUROaU5QTzIxU0MwTC9t?=
 =?utf-8?B?UU9nNHpJNXhBSytKcHVyR1FHUDh6Y0V1bml4YnYrbW1PSFB6REMxNGdudUMw?=
 =?utf-8?B?VUxOdUFJWmI1T01mYjZ2UjdwV0JzVUh3dU9lYXgxZzVzOXRGQ3RKVmJkRlZ1?=
 =?utf-8?B?bjRyN0RHNFJ4aUIyMzJZTFJvVCtVa2Y5L0J4bDFSNVVOWEV2elNGTUhuSC9p?=
 =?utf-8?B?NEJ2ZTcxMHJCR0hreGMvTDYya0x6RWl1bmQ3OEkyblM4WWJsK1BRWjNHN1Nh?=
 =?utf-8?B?MENkd2hmc2lGditpTkNiVFAyKytoNnNwWEo3NUZQdkdYbkQ2QTZZQ3RlQm9Y?=
 =?utf-8?B?Q2ZWaGtZS2x2WEYwMjZhMG9UVVdCWlJhQkFiN3JLcFVXbndqSGMvWi8xYm9y?=
 =?utf-8?B?M1VySXlVZmlIUXRqL2RIeVdhYVRwZzFEZTlyVUtiSHlsc0JDNFFKUDI5Vlp6?=
 =?utf-8?B?VFpIMVZmbHU1SlZWRHhzaHlodGNIYzFtTTJqaDcxaXA4VG05UWVZRzJnSUoy?=
 =?utf-8?B?Mmx3cWxPeWVaMjl6b2xkSDVrWngrUmNMTXV4RHUyeENCK0haNExjV25aVkk4?=
 =?utf-8?B?QkMycCtkQUhhb1VFempEZXNqT1pXeHEwenBGWFpveWo5YlJuOHJQbmlqMVkz?=
 =?utf-8?B?bFl3RG01TVJXUzl1Uml5M3dSeUo1aEpaaGxmbXdycVpyMW1mSjNnc29QYkg3?=
 =?utf-8?B?emcvQjBNQTBQalo4d0IzN0EvOFVBTkRMSUhFZ2dpbmZFL1VYS3drVnVvRnFJ?=
 =?utf-8?B?VlZFeXdWSi9WeGMydXRLazl4Ri9QWlRpY2haMTNZSUcrUk9uOWJlZjNObXFs?=
 =?utf-8?B?dWlzazdCeVFSTTFpWlVVQWtjdjVFMjVGM2FTMnl1eDIxUEg0V00rR2VzbEJ6?=
 =?utf-8?B?Tk5pa01DUk1tQzB0RjRPL0U4aFRoL1ZMU1NzcFJXdmQvSHpsL0ZJMklYbDUv?=
 =?utf-8?B?a0oyMVV0NEQ3ZlhsdFRtb3ZVQTRxeUx0SlFCQTJYOU1FQ0xudi9KeXNoN0Rq?=
 =?utf-8?B?S3Qvc1QxbERHTms4SjhEWHBDZWNZTzcxTjVCNkhuL3JvWlpjMUdFa0ZlYVlB?=
 =?utf-8?B?R1NJS2VrRDRCbjByVWd6cmhKazR2SzFScUxHV0lBcWh5NzBLcVVIeG9wUjMr?=
 =?utf-8?B?SG82WWo5Z1MrRXZxM2tZT0tWWVRMa2JuaFc2T0xscjdEb3pWaWFJeCt2eGtM?=
 =?utf-8?B?cHM1VjJySmswNUcyUlQ0cm1OL3JPRFNTVFY5Yk1sRFdtZk9meTh6aEFlRm5N?=
 =?utf-8?B?S1A1NmJSOUVqRVI0OTloTXZiVDBuNzErQkc5Yklab29WbXZRcGFOTUp4YmU2?=
 =?utf-8?B?T2ZUYldHYmFCTE1nYjZRcFIvU0g3ZDNUaVdhMXk4cytGRlh6SjFTc2FzTWlo?=
 =?utf-8?B?aEczcFBvWGNwbk1EajdiNHBFRGdCNVlNdWhTUHlMY05SY3VEbjRZd2tpN0x4?=
 =?utf-8?B?ZCs1WkVYNWMrK1dlVmVvUTloWGdQNjM3WGpXQXdKOXQ2KzV1dlIxZmNsN0JW?=
 =?utf-8?B?K2ZDNnhjSTUrWmdJQjFYZEoyeXU3UkNQQXhVNHZpVDJlTFc2aTR6SzVoNjVQ?=
 =?utf-8?B?QWZtbTRkU3RmdTVTQXpYeWFMNDBHempablYzb2JHMFZKd1Q4a2lYcGhETGJk?=
 =?utf-8?B?QzNscWN4ZStYVlpybkRyZmNOZGdmaVl0QTVCdEhzVmUzNmdKbUxIWGY0VkUx?=
 =?utf-8?B?d1B1QTJyR2NsTFJPQ1dZRU52T2U0SFRIZzRRbERGeWFjMU5tRExKZHdvU2ta?=
 =?utf-8?B?d01lbmNrSE5qWHRlWEJVbXZnY2VVVmpiRC9ZQTNlcENDeVVlY2lUWm9TR3VJ?=
 =?utf-8?B?UzVXSi81K3pYZUxIR1N4NkxqbVQ0ZVlueEl2WVlpZ2NsVjhoUzMxalBSSUdj?=
 =?utf-8?B?TUF6MmhwbWtiam1FUUFqTDJFaFlIWjBWSGNqcUZ5cStTK0RXMTFBZjNVUGdQ?=
 =?utf-8?B?NjMvTkhCMDNVVkloWEN1blJQTmNzK3JWR1VhUThlL3VmbDFSeUtVenlXUGhv?=
 =?utf-8?B?Q2JqYmlEK3hjd1hJR2hZSDRPUmlQRmZHYnVPTUFrL0NnUGZxMUFkN284V0VE?=
 =?utf-8?B?Qm5ZTXJhbnJsRG9yUzRLaXhoNDhNV1FnZ1U0d1F5ZTJ2ZzhxQkJIUjE2dllG?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NYltQ7JonJ68wN7WlaoR2P06BO6FpvlbFzE1x3KOOgums39Vl2yd2C1APr6JAMqkzNXOPtUdPlSnp4k8hasCIhr61/3fuLa+oL6t87TIWHorvyiEAuAeTcgblo87iuT0P4e79Onve6CltG+T8pdUxuqfMkUtAAIugkalZZ4RZmzJSDFtzn6PtyurRaf1b4Z6IZgKk4bhVk5Kx5qCZmlJ/zj8yZFa/UF4uVzljRlTrmAMdJ0WOdy+7VqHz7DetVbwAXUwSlJenpAZ2w4ZieH+dqCXwdTpOwqS5wz1qagoQI4Rh1TZR0iD/xZRuaCLgreimilkCfaZ6rLbRExNyhAzu884HbUrr4DheBBEq0dMUYeyuRYbP0UWoU0RBwYDXNrq7wRRE0YXCrmdRKmPwe28FJusWDAdZaz+Q6gTCcli84Ms/JWPYBVnvOaoNMOAMjCh5s4bmR1ULRvCmKso2dElBpAkC0M+HyK9NTC7YkVFarZc37nqneZX14U3hm+hIucbzEbcEi2bjrswNeSjltQaBsF05wyhhiGywX5dcKfzeZ0gXwiMSguWxM2pjzrfv2ZKc5/qNW1pkL/FIRgEQ8gaj06vga4LnNeIO1VIHAyObvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb29f08e-c92b-4e59-9fb6-08ddb8ab3442
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:01.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyDjUfdpI9nYHuU0sFFpZB7Kx0Z27AoDZuX+82U7Hjh4I4QLVLag9VWDR0ZQWLrX8ZAACcRmKK6n4SkF6cpDSQQyGpab8SDrmeS9R576USI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfXxDzII6BGBvay
 DOBFy9SUEVjfD/ZjKBKiDhQZTF2W35Bm+iiqB54IqqAgHBi45ft3yaNw7QTnMrQNEnZLphWZ7qy
 EEEGpMFB7vYT/Y7Ldd+g1Gb+frGRnscA+DyPmkFa++EDVwb50WN/olWpKzwMlw0CD9KLayx2/KL
 vHqFeyRXjf4Hmg3TLz7vn7PBFoJD0zb52vSrDcHPePBvIrTRh5TRDaEz+F/+N9P2hezq6j2UbLJ
 aSwPeLIXCeuKVcZtbKlzpH0kvU15mULvuKe/qENC+fLWG21KbLXvjfy9JQ5mtSWSXcNmSDj7a9P
 7JlihpSpi9BoWgxZ5QeEo68jDxHVJBkc+uidporn5B1FKIiHrlO1DOVGgCWemP6A1go6BxQMuAk
 rH3HX/PME3bVL5l08I1RE36U+SeYPcOBd1HbC+LQZ+Oon+HnX9+j1u3SETJhFu+lL8FU1cYU
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6863f005 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=twEcGank5lYH7YUZZjQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5PWMzWl2DvNtVbAuBNxHs3xVeRd5ekZ7
X-Proofpoint-ORIG-GUID: 5PWMzWl2DvNtVbAuBNxHs3xVeRd5ekZ7
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

Hi Zhenzhong, this is the only iommufd patch you have not reviewed yet - steve

On 6/10/2025 11:39 AM, Steve Sistare wrote:
> Register a vfio iommufd container and device for CPR, replacing the generic
> CPR register call with a more specific iommufd register call.  Add a
> blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
> 
> This is mostly boiler plate.  The fields to to saved and restored are added
> in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/hw/vfio/vfio-cpr.h | 12 +++++++
>   include/system/iommufd.h   |  1 +
>   backends/iommufd.c         | 10 ++++++
>   hw/vfio/cpr-iommufd.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c          |  6 ++--
>   hw/vfio/meson.build        |  1 +
>   6 files changed, 112 insertions(+), 2 deletions(-)
>   create mode 100644 hw/vfio/cpr-iommufd.c
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 170a116..b9b77ae 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -15,7 +15,10 @@
>   struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
> +struct VFIODevice;
>   struct VFIOPCIDevice;
> +struct VFIOIOMMUFDContainer;
> +struct IOMMUFDBackend;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> @@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>                                    Error **errp);
>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>   
> +bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
> +                                         Error **errp);
> +void vfio_iommufd_cpr_unregister_container(
> +    struct VFIOIOMMUFDContainer *container);
> +bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
> +void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
> +void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
> +void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
> +
>   int vfio_cpr_group_get_device_fd(int d, const char *name);
>   
>   bool vfio_cpr_container_match(struct VFIOContainer *container,
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index db5f2c7..c9c72ff 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>       /*< protected >*/
>       int fd;            /* /dev/iommu file descriptor */
>       bool owned;        /* is the /dev/iommu opened internally */
> +    Error *cpr_blocker;/* set if be does not support CPR */
>       uint32_t users;
>   
>       /*< public >*/
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 87f81a0..c554ce5 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -108,6 +108,13 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>           }
>           be->fd = fd;
>       }
> +    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
> +        if (be->owned) {
> +            close(be->fd);
> +            be->fd = -1;
> +        }
> +        return false;
> +    }
>       be->users++;
>   
>       trace_iommufd_backend_connect(be->fd, be->owned, be->users);
> @@ -125,6 +132,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
>           be->fd = -1;
>       }
>   out:
> +    if (!be->users) {
> +        vfio_iommufd_cpr_unregister_iommufd(be);
> +    }
>       trace_iommufd_backend_disconnect(be->fd, be->users);
>   }
>   
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> new file mode 100644
> index 0000000..60bd7e8
> --- /dev/null
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/vfio/vfio-cpr.h"
> +#include "migration/blocker.h"
> +#include "migration/cpr.h"
> +#include "migration/migration.h"
> +#include "migration/vmstate.h"
> +#include "system/iommufd.h"
> +#include "vfio-iommufd.h"
> +
> +static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
> +{
> +    if (!iommufd_change_process_capable(be)) {
> +        if (errp) {
> +            error_setg(errp, "vfio iommufd backend does not support "
> +                       "IOMMU_IOAS_CHANGE_PROCESS");
> +        }
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static const VMStateDescription iommufd_cpr_vmstate = {
> +    .name = "iommufd",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_incoming_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
> +{
> +    Error **cpr_blocker = &be->cpr_blocker;
> +
> +    if (!vfio_cpr_supported(be, cpr_blocker)) {
> +        return migrate_add_blocker_modes(cpr_blocker, errp,
> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +    }
> +
> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
> +
> +    return true;
> +}
> +
> +void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
> +{
> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
> +    migrate_del_blocker(&be->cpr_blocker);
> +}
> +
> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> +                                vfio_cpr_reboot_notifier,
> +                                MIG_MODE_CPR_REBOOT);
> +
> +    return true;
> +}
> +
> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
> +}
> +
> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
> +{
> +}
> +
> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
> +{
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 962a1e2..ff291be 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -446,7 +446,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>       if (!QLIST_EMPTY(&bcontainer->device_list)) {
>           return;
>       }
> -    vfio_cpr_unregister_container(bcontainer);
> +    vfio_iommufd_cpr_unregister_container(container);
>       vfio_listener_unregister(bcontainer);
>       iommufd_backend_free_id(container->be, container->ioas_id);
>       object_unref(container);
> @@ -592,7 +592,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_listener_register;
>       }
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>           goto err_listener_register;
>       }
>   
> @@ -623,6 +623,7 @@ found_container:
>       }
>   
>       vfio_device_prepare(vbasedev, bcontainer, &dev_info);
> +    vfio_iommufd_cpr_register_device(vbasedev);
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
> @@ -660,6 +661,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>       iommufd_cdev_container_destroy(container);
>       vfio_address_space_put(space);
>   
> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>       close(vbasedev->fd);
>   }
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 98134a7..56373e3 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>   ))
>   system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
>     'iommufd.c',
> +  'cpr-iommufd.c',
>   ))
>   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'display.c',


