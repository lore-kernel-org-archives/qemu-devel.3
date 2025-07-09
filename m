Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C810C83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 19:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZaw7-0004vt-Rm; Wed, 09 Jul 2025 15:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uZaw6-0004vV-4S
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 15:58:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uZaw3-0003kp-4i
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 15:58:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569JgFww026092;
 Wed, 9 Jul 2025 19:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ANbwryvrt/srsqrjVY1qBEeccXD3GZpM0lKSEBr/jWY=; b=
 GEn4elepVG9NiYgWupdoKr/Jo8w6xc2TCoHaBo6i64PhVDuhx8h2Yuebv9D5P+EF
 Dtl4xtKmpn/ew4HQ/Ve8ZMR8Cdo3mpCvsqGiZoLmFkEa18TY3/cOa30Vy9WxxcrT
 QSoB+IWEu0jLhiPKOOLKZuFwZ7vd1O6ZnlZ4GoofUlxU+hBKvsBVuegfaxA6YcCe
 9OBhTdiRwdksQ2QfNWcQk3beN1w9rdAAn97TGOUL/JJ1d3QsndXQTArLiEq5UoLV
 p2TU53qcxfrNesBVdgT5kbis21WfAwh9TzseTacBNrjtso2yboja5YAF0H2SIkAT
 kMW/akNfA4sNs40lfN2Cmg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sxtdg0vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jul 2025 19:58:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 569J49TA021358; Wed, 9 Jul 2025 19:58:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgbcvru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jul 2025 19:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIy0zOhIO11BXVT8vLTZ0DZ/KKa1xOu8bqnEblkXXKTSG6382c4Y0F6rWl/VwauvL39z/TJN60YZyNxiQ8/xXWtDRBnPsrQODuD9kUwnZovFddPNmIEInFs1SSu131Or+lrr61GD7L17WTTZYC0dFba95FGR8j7vtiG923Xn/3brkWdL+LWfd+xPKmni4Xv2BhBtaRmQ7fe+YxWEB3d1JayjxUFNKm027NdL+GCVMAp6R6cvuSmJhrIqGzwtkoBV9GmZAwEzJ3CFyrOJKHp5aEmC3Ew68bNpxarF5KbGEHh00OZCgLIV1aPssA2u7IQwJdW3Dk2cttJd7bH+2UmETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANbwryvrt/srsqrjVY1qBEeccXD3GZpM0lKSEBr/jWY=;
 b=kMtiWYmLfd1U2NUIVhWXUHAcfxhXC8ndm7AdEDVdwjQhF0FgD/5468Yn263kGsbP1Zo1vxsi9AwHcRGGkGYWWVUtCwlhxMFlKDa47jw8HdGA6bYNLsuHki2xwxmwbWvcWTgBB+tn/C7b+iSUxGVX8y+DPHhGsaVQBIPQb/XYLOYpcLLbqBsDVexd9zdccdI/GgOkhoOLfUVYioI95l158U9TkPXCj33/1da9lxluYoL1AvcCuMvA4ool/jP9eykzizk95kwT6/X94lxeRNvMrKIH+6uQ10fS3/WbLSZZcJNEpQDkzcFWeC+HmtokMCRiJqtfH4NMN4xTWb58EqPFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANbwryvrt/srsqrjVY1qBEeccXD3GZpM0lKSEBr/jWY=;
 b=v5Nruio1OJcuba32zEg26lHco4qtuD16GNvFQ8UMuWPnPlTNmvGMxjuMTFM8l4nrBFVu3IB3oZh8GDlpLQNZxnznvHiBINcuMJi06W0N4QpHo7a9+BERGvAsfRbDPIJ/teYBgPCta+d9VF6T4+ffClKG6HO6KvuIPZF8ZLhPWsM=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA1PR10MB6831.namprd10.prod.outlook.com (2603:10b6:208:425::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 19:57:55 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 19:57:55 +0000
Message-ID: <71ae1a0a-a697-4199-ab57-426f6252e224@oracle.com>
Date: Wed, 9 Jul 2025 15:57:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com,
 parav@mellanox.com, sgarzare@redhat.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, Si-Wei Liu <si-wei.liu@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
 <87o6v6muq4.fsf@pond.sub.org> <8734cimtqa.fsf@pond.sub.org>
 <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
 <87o6uau2lj.fsf@pond.sub.org>
 <69bc738c-90fd-4a48-9bee-bb7372388810@oracle.com>
 <87frfcj904.fsf@pond.sub.org>
 <face37ee-9850-448f-914b-cd90a39d3451@oracle.com>
 <874ivnxfj6.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <874ivnxfj6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF000040A2.namprd05.prod.outlook.com
 (2603:10b6:518:1::56) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA1PR10MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b2fc5-505d-4ff4-9080-08ddbf22e55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDhubTRGRmhVeU5tRXRMckE4bVcrb0hPd3U5c2hIaS9JRjVpejlReENIVFdI?=
 =?utf-8?B?ZGxLaW9lczEwZnBFZ1cvVTVkQTF2SFFJa2dJL3FOU2xxNjNOcEl3WEE4d2to?=
 =?utf-8?B?K09oVlJCYWlCZGdraklFVFhjUEFiT0RkNVJSUUlOdWlQazdmQk0rSzJrdEQv?=
 =?utf-8?B?Z2s1M1BCN2VVbDhXVGFJVkFRbFM0cDhMSmVLbzhlbnVqZUVnOFRMb0hlcXFx?=
 =?utf-8?B?T0twTG9kSjM5b2Nrc1NKT2RQdmFaNytPSXlhWWluMnpjY05EaFkyMzE5U05m?=
 =?utf-8?B?cGQxSlVOWWhEVHJVRWNYRS9JSXdZNFhtWjRpQXEzbVkzVXp1QmorQ0U3SkhZ?=
 =?utf-8?B?MXN4TGNZN2VGbTVGTkRrT3pOUFphZWFmWUZaRzVyOEpIMTdIejFoYThCYzg2?=
 =?utf-8?B?Y1lSTjRuZ3NuTUt0aWN4OUZrZW9mNjE4K3JjSUlPTlhKMGM0RzdIc2Z1cWR5?=
 =?utf-8?B?YnRMNFd6QVBpVGpma2doTTU5b1VYYTdhc1A4aVJjZXlYNWhXS2Z3NlhuWHBP?=
 =?utf-8?B?eVRjUzQ1WG9vOWZTeWlJM1ZzaGtiNGdKNnMyVVNTemptQTYybnc3Q2M4S2Vr?=
 =?utf-8?B?cHpSSVIxSmZURTZtVWJad2dQcTB0TTY3aVg3cXhLMDJvUzk2SHVzMFBLVXRD?=
 =?utf-8?B?K2RQd01RMU1jVXhMTjhTbFdOUGIvcWlNbGp3Ri82cktHa3dhNyt4WnRnZzF4?=
 =?utf-8?B?eThab013NHRTWTFZOE9tSUNGSDc0V3lSZkIvM2c3V0p6NklRY3dLOGtKTkI5?=
 =?utf-8?B?TW1rTkdwMlhlZDIySTRXRXlWZlFmZ21XcDBOS1ovMHkrMDlHTzVnT09tU2F3?=
 =?utf-8?B?akhacUJjWldUQVU0YzgyWGRXM292QXM5NWJLdHArbWh0cDFVNGJ6OXdYM1Jl?=
 =?utf-8?B?U2FIUWhybTBlUFVVVFpUZGR3YlFSOTBtS3pVTlFqZVRqY1JMUUN3OHVDOTdO?=
 =?utf-8?B?L2NBNUtudmhhd3p6eUl6b3lnejI1WUtjVWlmWkl1UWZpRGtadWxLdzdiVGFn?=
 =?utf-8?B?SHZjdEdseGJUdXpPYzlOK29XanR4MmZNMk5RbjU1dG1QbmttZ21vdzZyM3Jm?=
 =?utf-8?B?eFpEYm82T0lVdnJZQVZoVW5Vb0tnS2VOTVVnMElnTjhiTldWUTNjbmw5cjhW?=
 =?utf-8?B?Y09vY0VyNzRadFV2SWVjQ0ZBNXJ5c2JZM2p2eEFHT05odHd3KzNZcW9VMHFu?=
 =?utf-8?B?UG5UV1RFbFJWazByZ1FaWjBYT2FIbWNJUU9kMGVsQWdnclFaOGViOHNkRjl2?=
 =?utf-8?B?Y25US0ExVEdZV3JhemhwQ2todU1HNExpL2U5TFZPOWF4cElOQWRIRm9JTkpH?=
 =?utf-8?B?TWtBaXFNcmVXMWxxTWRPV094cjZrMHdYQ0RTRXM2VFcyR0RpbmVucUxDVEp0?=
 =?utf-8?B?RGgxREZWRTZ0RWxpbnE0S3A0dU1RVkJxL1hkbys3NUtuVDRXR0dWV1lhZVlW?=
 =?utf-8?B?N1BmZ1BENWlBOUxndG85aHNScHJxTUNYVDhHKzVvRmhSSzcvbnU3NFJBSFlm?=
 =?utf-8?B?YzR0N1pkYmY4RjArZURpWjFaYU1PVkZ0Y3dYYjBtU05RRnFrQ3JlUFR2bEli?=
 =?utf-8?B?Tnkxd3pyUVFKTzlMY1FyU0YzRDVaOUFCUmxoSmxlSWRFMndmNWdBYkp4cEd5?=
 =?utf-8?B?dG9HaVc4TXVWVzU4bEVmcFNkS0xwZlNMRGxQakRzVFhmUy9WT3RyUElDYnRM?=
 =?utf-8?B?WmlSTXJITHB3Yk1aSUVDb1BLVGk4T3JlaXpyQmFlTDVlMjdIa1Q3Y3VaTkQr?=
 =?utf-8?B?ZkhYYzVZZWs1WTUxVnVCMCs4YjNBUEgvOGk3WDhTbW9Ca0wzVW5zZkVsRVhi?=
 =?utf-8?B?OEdrbnpaODJZbW1Rb010akpacWVQaUxEdERJNkpTN1NPOTNRUVU5MnVkd3Zj?=
 =?utf-8?B?SDJtYnhFOEs5TDg3cnVzVk1pQXZlSzhmZml3dWtVdlBjRnIwREJ3YWppQ0s2?=
 =?utf-8?Q?d8a3U0eaxwQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRETTNGVFlPQVRtOGpRM04rb3FZcDd6NWFLOGZQSW9aYUkrYWsvM09Yczl2?=
 =?utf-8?B?TjZaQ1dWYXJXUTdNSTY5dVE0RlphTXIzOC9QaVhmUG1tVW14M0RsL1lpQ29U?=
 =?utf-8?B?TjY0aHVGQUx1OTl6ZkNrajZLaFM4VlFrbzBDQWRNMDRWMHRsT043WnphL0RV?=
 =?utf-8?B?cFZRLy9OS0hVSWZsdE9pNDA4RTVpMEpEWHZMVkU1M0RuaERsUkhkQXp1L1Zw?=
 =?utf-8?B?QmxSL3N5d0YxaG14bGZkamZJYkYrS095UDY0bUJ0VDZKRi9pcnAxMHJISUtP?=
 =?utf-8?B?R3BSdWVwRnlrQ1ZRSFpNVjRVU0p6RlR1UXhsN3RKdFVUemNpOVcxSjdna1Fr?=
 =?utf-8?B?OHIrejd0eVgrSnVZbEI4a2FHU2x6RzhGYXNkWEgxRkdQU2xSZHVMN1FyMjV3?=
 =?utf-8?B?SmVSWXE5R1ZNMkc0OEtiaG9mR1dHUHVsN3dOUGdWUDhPUXZxV2Y0Nm1TRlcr?=
 =?utf-8?B?TXBDMTVtYmZ3Y2JZeHNTMkdQSmJ5bTUvRi9FbjFKZFRWWUF1c3Nxb2JwT1VH?=
 =?utf-8?B?LzZxQlhFc3ZJQTRUYmd1aW14dldHRStPbmpyK05CbXRxVXJ4YTJXQ1VUT0VM?=
 =?utf-8?B?YXJyVFU2ZzlTYnVUdXN3Q2htV1ZCOFA0L21oeFBJVHNnUDFnOW11LzUrN2JO?=
 =?utf-8?B?cERibGpGN1F2aXlKYWJRTWhMWUdQRnVwdkQ5K3puVmJaZGNSY05QRmVmZFMr?=
 =?utf-8?B?Zmw4bjI3NlJRVkJ0VXd0b2I5YmJBRDAwZXV6dXRzNzdIVG1tekNwTzZYaTNK?=
 =?utf-8?B?bUw3TXZPMXFzL2RidnJPMHJtRjBlQWZ1VkREMTNEd283bmhFTTZJWDJTRk02?=
 =?utf-8?B?SFdCc2NEYkN3THJTTWR3TmpIOW1ZRU84RjN2Q2RYMkw3R0N6eXZKZFVvQ2JE?=
 =?utf-8?B?dHVrNXAvRzVxY2N0cmRxcXFBdUpOYitHbHhtL0h4c2c5ZVp3ekR6alQ4WkRt?=
 =?utf-8?B?Sko1U1V4eUFsa1JmNVFSVDhPYVB3c29jR1FrMllaMFBrS3BIYkt3eit1ZFl6?=
 =?utf-8?B?UW5Ia2RqUmF0bm4reVA2TFhVcWt2ZGJQb0F5YjFzYm0yTURGaXZWM09NKzFS?=
 =?utf-8?B?LzgzQmhTamRHRCt4UnF3bjh1NkZIcEpBeTluL0hsQWhtaEU4N3R6NmRES0pU?=
 =?utf-8?B?cTNweGU3MnFXRlVJZTU3SWpHZ01nUHQvaFdjSGdhOTFuZnh5SWhTOG1hQ1lM?=
 =?utf-8?B?cWZadUhsa0F2YmVrdTBsV2g5OExPWGNDV2tEK29oQzNHbG9qTFE2cFFRMnNC?=
 =?utf-8?B?dld5aFp6UExtR2prRlJ5c3NqVFBlTkxKWWwzanlUcGppSHpHekJEL0l5SUpH?=
 =?utf-8?B?eWtsRFNBUTBmTkZkNkhER3JPdXNGSmFCeU5NL3l6cWpIaWRLRmZ2U3BYSUpy?=
 =?utf-8?B?WXF6V1ZZbm1xV003R2pLekZHQzI2ZklHeWswMkpjRnBhZDBESkl0bTR5eFFy?=
 =?utf-8?B?TVRReTc0Z2JLbWEwbVdZb29rSDRMR1YzUThMUDRVY3AxclhjTkN0ajhFVFQ1?=
 =?utf-8?B?RFRUU0ZCNVdOM0tqeE9CWStRelFOcThFMWVOVElXZ3AwZ21vWWU0SDQ3cDVK?=
 =?utf-8?B?SmsyV1dtNjdHL2Ixb21YbUI2STJ5cnR3MWJSNkRFdHdTZFBoMWdXNXJadXVj?=
 =?utf-8?B?VlI1RHB5QVNML0xzWjJHbkhRQ3VwNnJHUjBqZDFjTVIrMkozaHhrZHVWRlpt?=
 =?utf-8?B?Y08zTjRkTGNqMStnOU5CUDliVWcySlprTElEa0FiaWFmRmxkLytHd3hwemdz?=
 =?utf-8?B?ZHU2N254V3BjN01TRDVYRGVTangrNUNieUpSVUdFVTFKdEUwUmdhbStwZkJp?=
 =?utf-8?B?VVNHdjhVQTRIS0QzRElZcG9vSnZ6Vmo1cjFlYkJkekI2N0IyRkxsdGs3Rkdu?=
 =?utf-8?B?bDFHN0RoeEFNS29LaEJ2aW5UbjBZZkFDYTZwM0s4ZmVXeDF0TVpWRFBQRVNC?=
 =?utf-8?B?N2RpeE9Hcko5RjNDM291YlhrbTlycHlNRHIyT29WREtUZlhIUVZhbmRISDdB?=
 =?utf-8?B?aGFqNEUvOXZ2eG5wYjZjR3pJOFVJdVNCN2prQ0Z5MVpWZ0h6QWwrcG9xQjk5?=
 =?utf-8?B?ZFNRNVZIYmdJUGdSOHdMREVFMW0zL0FJU0lnd1E0YkdxS2dUdmhramI0SG9J?=
 =?utf-8?Q?y9C3V1pN00uaRaG4AvZ+SQCjB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /XTh5WR0xmXWUuUzBx/7z0YdvwcXVlS5Zi8EMhzhnFjqI9z2pR8jF16uhH4RiYDJGRuDNQAUG/02luuA1p5EP8QsyyltmSRlTMwJq1g/NuxS+MlxgX5i1IFAUvOpSobTebLceyecmVrjQ3obIVPmGnklj5/X0rNUwm6DJjz17RY6ZujutaK/yxAWHibSTSXGeg8Ga0xdSZt3jlcvbQg0b5rIeLeGTKMNjz/VwNUroyXvr3y09UJIeGFkilDKpYy71KlU4GtvfyQJKSvs9n1Pi1CZ8sPjhV8Ih3V+LAUKpFhrJyOamHwFzki3YjfM/YZ6YSFW/9U7xN8B8t8xKTO1EKuP/5GOl67HXwOSLUhltjeNxk+nypbZr6LFu0o9a0qA7mCNz++m+h1mR+aYT9fS7k8MWmezntr4r8K+U+bwVTJ3wili8W+cuRFD91KHQC8QU2Fj5dy840bviGkrpM1o34lQ2wggYpHLy0rotx7zE2TKVxVznUBeSZq9GwaTt7QS9M51SvOP5d8S9MEojun8ThMquq9R2OZ17l3oQY3ADUL6hirRujsSOioICwbqAOcIc+/VnZmUJsMA85SGoVKp2B3Z33HkcXz9uuqeh8/ae5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b2fc5-505d-4ff4-9080-08ddbf22e55e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:57:55.6122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LdmIor67EXGxqnBJalYVl5qgPMiQR0yZKonuIn7x+rbdjy9x2G30ifa/B/VCp+sMES4te4z0CkJVC0uKZlI0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090179
X-Authority-Analysis: v=2.4 cv=PM4P+eqC c=1 sm=1 tr=0 ts=686ec9e0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=DLHd_IRExHMK3NlxwjoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3OSBTYWx0ZWRfX0Lgnu7i0bygR
 yxjDdMzytDVHRFQfRzOFX8vQlLnAXJBzvUGy9gdPhOgpWBPXZ2or3ClY1w6Jw3P25a1fxBFKjck
 ioUGY3/FMduzQM+lJ9bofgCEDycVM0T2SApWWiqquNaafznmizJl4dYlkN+kA71d+3wqM10sbyD
 DnRks/xhNAevu+OkwGlWG4DvMnbLZmAqWBuMGPul3T2sIV20PV9QfnAw7eEdyaFn9Sh5jMSNfOj
 JasH/nTlKyzq+/zNwg//HeySlW5OS7P36y6F8vpOTSTLLYNIEr5daf7xtJvt9hI5NUMPc1ZuQZ8
 VjBYKjfqaLbQQc21ylNBzlfwVjgONxlXp0NQZ+EzGI/s/IoRe0nJFZlSKi+oocO5YNVxU0hBhAO
 PbDuP9zhEeUbhy9bVULX/B3EaVtG/xyR9HRyR6u5UcRbS3YJU2eGD3KMSTHkweyt18eSJhIk
X-Proofpoint-GUID: iSv0ToThiVzryOayKZhTAMM2qDyFVWQj
X-Proofpoint-ORIG-GUID: iSv0ToThiVzryOayKZhTAMM2qDyFVWQj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 7/8/25 4:17 AM, Markus Armbruster wrote:
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 7/4/25 11:00 AM, Markus Armbruster wrote:
>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
> [...]
> 
>>> So, total time increases: early pinning (before main loop) takes more
>>> time than we save pinning (in the main loop).  Correct?
>>
>> Correct. We only save ~0.07s from the pinning that happens in the main loop. But the extra 3s we now need to spend pinning before qemu_main_loop() overshadows it.
> 
> Got it.
> 
>>> We want this trade, because the time spent in the main loop is a
>>> problem: guest-visible downtime.  Correct?
>>> [...]
>>
>> Correct. Though whether or not we want this trade I suppose is subjective. But the 50-60% reduction in guest-visible downtime is pretty nice if we can stomach the initial startup costs.
> 
> I'll get back to this at the end.
> 
> [...]
> 
>>> Let me circle back to my question: Under what circumstances is QMP
>>> responsiveness affected?
>>>
>>> The answer seems to be "only when we're using a vhost-vDPA device".
>>> Correct?
>>
>> Correct, since using one of these guys causes us to do this memory pinning. If we're not using one, it's business as usual for Qemu.
> 
> Got it.
> 
>>> We're using one exactly when QEMU is running with one of its
>>> vhost-vdpa-device-pci* device models.  Correct?
>>
>> Yea, or something like:
>>
>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,... \
>> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,... \
> 
> I'll get back to this at the end.
> 
> [...]
> 
>>> Let me recap:
>>>
>>> * No change at all unless we're pinning memory early, and we're doing
>>>     that only when we're using a vhost-vDPA device.  Correct?
>>>
>>> * If we are using a vhost-vDPA device:
>>>     - Total startup time (until we're done pinning) increases.
>>
>> Correct.
>>
>>>     - QMP becomes available later.
>>
>> Correct.
>>
>>>     - Main loop behavior improves: less guest-visible downtime, QMP more
>>>       responsive (once it's available)
>>
>> Correct. Though the improvement is modest at best if we put aside the guest-visible downtime improvement.
>>
>>>     This is a tradeoff we want always.  There is no need to let users pick
>>>     "faster startup, worse main loop behavior."
>>>
>>
>> "Always" might be subjective here. For example, if there's no desire to perform live migration, then the user kinda just gets stuck with the cons.
>>
>> Whether or not we want to make this configurable though is another discussion.
>>
>>> Correct?
>>>
>>> [...]
> 
> I think I finally know enough to give you constructive feedback.
> 
> Your commit messages should answer the questions I had.  Specifically:
> 
> * Why are we doing this?  To shorten guest-visible downtime.
> 
> * How are we doing this?  We additionally pin memory before entering the
>    main loop.  This speeds up the pinning we still do in the main loop.
> 
> * Drawback: slower startup.  In particular, QMP becomes
>    available later.
> 
> * Secondary benefit: main loop responsiveness improves, in particular
>    QMP.
> 
> * What uses of QEMU are affected?  Only with vhost-vDPA.  Spell out all
>    the ways to get vhost-vDPA, please.
> 
> * There's a tradeoff.  Show your numbers.  Discuss whether this needs to
>    be configurable.
> 
> If you can make a case for pinning memory this way always, do so.  If
> you believe making it configurable would be a good idea, do so.  If
> you're not sure, say so in the cover letter, and add a suitable TODO
> comment.
> 
> Questions?
> 

No questions, understood.

As I was writing the responses to your questions I was thinking to 
myself that this stuff should've been in the cover letter / commit 
messages in the first place.

Definitely a learning moment for me. Thanks for your time on this Markus!

Jonah


