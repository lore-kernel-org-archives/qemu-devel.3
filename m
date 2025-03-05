Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122EEC282E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnPU-0002ct-5R; Wed, 05 Mar 2025 06:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tpnPR-0002YK-OM
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:59:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tpnPN-0003sB-H9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:59:33 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255Mg6Y008018;
 Wed, 5 Mar 2025 11:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ko4Pp79c7Ka9Uwh/xTZhrmg3AfjofcIu7oVD9IuIvPM=; b=
 a0W/b3BbVExuF7DHXr4AQp2lfikF6Ukjz/ToXb3/86vN5T+KIPnMypU0I2kbgpW0
 sCe6fixlF4BuOp9AdKnKYtRYiqrJsCEJUZwc3sNNrjFTCfJR6ayZrkj7JsnZwkis
 73+myVv60ygp3Guk2P2XAwl31fbvmbjjfItCfa93ikp/esrhA2QzT1wEgbXKukDZ
 7DnIprbyNDluRuqXAMt0mXhHYl0+2EvPWtdVoheFcA5a6jCax6V2x15oh9Yl3Vcy
 E0NaOwdLEfQhfXAMwLsWQcuuO+Q/n/AZSCFTT+uqNAwVFnn2MiDx/un7CDrFqJcQ
 6K5HCns6fAmS1DxNwQzgvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavyctc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Mar 2025 11:59:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 525BexCY021865; Wed, 5 Mar 2025 11:59:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rww8vdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Mar 2025 11:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mb+e0bqIsOO3+jrLAqzTNbjWhYyZacadUJakeudvBVPpaRc6GAnFV4mTkhsGMUuAAW935qdld0aO+HKY7RwMqU9x8bCk80Mm1t81ImEfeUHiyHxUkYLkcBU/PiwGuygWH1vPU9o2bW3lrUfRqz80eXCMjL/MborQraLTgdHj1uGHBG+EbrvVDeAate1h3/knzGMAUkhDOLp2HYSiFwvusP9au36esg8JR80caN7UBzCar/gtcX2z65gjRFqPElRZs9BLLK4oT3kXSWP9pAZJxYqX3ieJPO7bRjmGY+h3PycEqDM7Pm9/8a+Q/vtOccrn/dvgPFOw9KBKwWdpG8v3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko4Pp79c7Ka9Uwh/xTZhrmg3AfjofcIu7oVD9IuIvPM=;
 b=wH+C/Btc6AwywL2aq3Sz+CWkSnPqU4HPme7qm7jgCCEiWSqgvSuwjqhP8Xdd8tk4S9YiSSQpavpjzsOZTlAfHHhjHxaLPb9ibz+avv9Hd6dCg93n+ZVblgeElLx91DSttvcewkF6FH/ini2VhSXkUuHpDueESgTV2ByP+ydTIII7B5ZA5K4eGnL+o6yZv9D3JukNEJpfCJMwUWaLLoIAcxVAPzBYG5e+t+zUtbJ2cbasaEhEOdl2Q3zHhonsvIHBNJezDHzjgp8obSpCO+E555HSCtC9TPPGlonuTmxAXbIppKfzWBAc5K/kcLiMZQzVX5NCNWYJivKT5mYbj0tyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko4Pp79c7Ka9Uwh/xTZhrmg3AfjofcIu7oVD9IuIvPM=;
 b=aodzhp+6lAYRxbMGqHfvnqQCKJwOb0UJATQfw6QBA7ZMduBJ7N3k96T4HMtK/03Y5vODlLlZ+/8uio/l1vfxSkIW8qY6yd9jqI/dYbwX/DLji3gyXAcXb96/TW1Sj4Dba9CJHeIiVWAvj9H7gP5JIQ5pPy4ODYaayjVVZn9tEm8=
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 11:59:20 +0000
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::6e6e:4f53:8802:73d6]) by SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::6e6e:4f53:8802:73d6%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 11:59:20 +0000
Message-ID: <42942254-371f-4616-b943-9eaa0015bc9b@oracle.com>
Date: Wed, 5 Mar 2025 11:59:12 +0000
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <CAMj5Bki73PNZdZvNAsK1YJiWGMeZugQCZ18QPekCM5EN61QqBg@mail.gmail.com>
 <62d4bffa-a912-48b4-9a7c-b16b21bffb7a@oracle.com>
 <CAMj5Bkh9zEGBa6NgWAD3X7F4sG_we5tnKKyQdA6HF_ZyPBqwjA@mail.gmail.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <CAMj5Bkh9zEGBa6NgWAD3X7F4sG_we5tnKKyQdA6HF_ZyPBqwjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::6) To SJ0PR10MB5891.namprd10.prod.outlook.com
 (2603:10b6:a03:425::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5891:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5ab37a-936d-473b-d1bd-08dd5bdd29f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzErWm1iZW5ZN280czhUaVJFeEQzek0wM1QrckZrN1M5T0UyY3VSOUh0Y3hL?=
 =?utf-8?B?UmhlbzUvUXJpb1RINzdiSW9vdUxtN3BicHRSekJMdmdKaXJXRjZiNFU3UmNn?=
 =?utf-8?B?b0tZZmdITmY4V1A1WldhUXNleFFyTHdnaVNWTHFpRUdoVXVNSmFRMFNLOUp5?=
 =?utf-8?B?cjNiNmVkUXlsSXJzTm9mRy9ma2g1ZVg0WXExbkUxWmFKYzRKbUUzZW1tSGxT?=
 =?utf-8?B?VE15aEl5ZkN4am4vYmtjK0RhVTRaOTZlTEtsTVlCRVhuRTBRSk8xVHRWR0h2?=
 =?utf-8?B?V0o1MTN1YitkTWtmZng1dThHUkZlYzZLTXFuRFFaYTJPb0ZmZ1NSRlhwVjIv?=
 =?utf-8?B?RUl5WUdndVZzUmk2ZysyU1ZhdzJvZzhlU08vNFdoQjA0QkRBOXJHN1VnZjIy?=
 =?utf-8?B?emRaQVQzUllRMk1SMWRqaTR1V29VT1Mzd29xSkV0RXdGMXVYKzd0RWt6OEVF?=
 =?utf-8?B?Nnp5cm8zMUM0ZHNKRTJCdXFjTU9jTlhFdmZ1eVd3bGtGcnAyOEh0aXRqNkVI?=
 =?utf-8?B?MzN6cjlHMDYvMVZlY1czYWw3UWJlcTVid000WEhmL3gxYTUrUHRYcE5pNFBR?=
 =?utf-8?B?NEdWOEd3RzFXeGF4RkxXdDBCRlNJaGVOZFZkVDczazBHbnBWOTBwVCtRQjlh?=
 =?utf-8?B?b01tT3ZxK1g5aVAxR1ErbWNYUXNaNnl3QXpYK3hIek1GTXc4V0wvNUtYTVZB?=
 =?utf-8?B?anBNUTlKWmpBSVdsVlAwTTRQZmU4OEdWeVZuVHNIUm05anE2Y3N6ZWNkd2o2?=
 =?utf-8?B?RWU2T1pwanBiMWR5ZnB0MjV2WU50dHdBTk9UZnlqbkhhYzRaUXQ5U3Bic2xh?=
 =?utf-8?B?TVZlTTNFaUpKQjFjQ1R3QkxjZGRha0FxS3RpaDN5ZXdEbWdqTnRmMUFtdkxX?=
 =?utf-8?B?WG1qcmFKRHpHUml2S0JxQzhoMm0vbVN1RFlHNmdRWFNtQUV3ZmpqbVFFRHpG?=
 =?utf-8?B?RFBYRUpOaHdTZTdnOWJkQlpaK25VeFRKSFQ3Sit2d0psdS91c1I2UjVBaFhS?=
 =?utf-8?B?aklvSTBJK2JDZ0UzaDJKRi9ibGxZMGFzNkpTY2tjcU05WDBhRDBHM1ZvRkEr?=
 =?utf-8?B?S1NTZTRZWWp6d2loWjNKdXZJYmh2RlplakRZS1RENVRUTG9BSjkxOHRrWEJZ?=
 =?utf-8?B?amtpenkzU2VlRk9TeWtlUEI2QkN1OUhDMmltS3h1emxpQ3lzdUxNak1RNi8w?=
 =?utf-8?B?ZEE1aHQ5VEtTZ0ZaLzJNSmpvcWZ1V2JyeGltbGtZQXl3ZG9GMGdoWjFOSjRn?=
 =?utf-8?B?SDdKUDZvdXFId2l2TDVKMGZWYUg3UjRNd0RlRm9vSyszSlhUMmd4bklnaUVm?=
 =?utf-8?B?NnpHUGk5RzE1UWViazhpVjRRdUU1U2QwUENVOEkwcVpxKy9nMStMaWVodmpk?=
 =?utf-8?B?VlpsU1FtY2IrenNDNGJ5M3VQQWo5QTZpVURlTVRLTXd3NXJCdUZLbFNqMFBq?=
 =?utf-8?B?QXhqRTJ5cWMwSjdVcmp1Vm9WaHArcTA4VlBBSlNIK2piUkVTaEFLZXpMcUJq?=
 =?utf-8?B?VXkzRUFKSUlQelpXUEUxLzJaMEM1V3RMMXhuYXJuRm92cGp6bEowaXRVVmdS?=
 =?utf-8?B?bk1pSkFhcUJIcEJPS2xsSzVVVlVWcno0QkVMUDROTE5UdFhxanR5RlBVOXNy?=
 =?utf-8?B?ejIvZTMzS1ZYdWgxOGlrUndZNldaemhlRnJmeTBqR21iSDlMRVBtQnVIU2tF?=
 =?utf-8?B?L3dua0ZOSW56bE1TeUhsMjAxQXFBM3UvVmExTW9QdWpSU3FsNlM2MmQxNDdi?=
 =?utf-8?B?azkyZXZ6Y0MvQk1nQlRUQWRvVUEycnByS3psUXRsV1daS25GbFZOdW5XNk1t?=
 =?utf-8?B?VXJOaXNSdzV1ZEdab2ZnenZFbnllcUVCY1c3bGRsV04zaFcwUkhEN2lVR2wy?=
 =?utf-8?Q?TaDuDDikTuHl6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5891.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG95Q2ptdDVIVnFUanNJbGNtb0tLODZ2TzkycjN2U3pEbXlIYWZvMzc0Ti96?=
 =?utf-8?B?eDBvekpSb3hjdSswalpGSjZjcXZuWUFtbkMxNElVc0w3QlVjSy8wQXBlT1pn?=
 =?utf-8?B?STF2blNtajUzZVlHTjNWRUJ1U1VId0ROU1hiTU5VcmJyV0ZBUjV2Y1loMlB3?=
 =?utf-8?B?TVBYSFpSYWd5WEJud2pDWjljSlpyVjdNWmY3YXlKRDJHZ2puV3ExZm9NT3FL?=
 =?utf-8?B?YlY5bE1hR2NUaUNYZzlHMkVJRGpJUXF5WWtQZXRaY3dBb1NXeTkvYUlEREV5?=
 =?utf-8?B?VUh5SHFkRlRMKzllUktQcndDNkptR1M0REFSeXdjWkJScWxidDU4M0tHZHdI?=
 =?utf-8?B?R2VDU29jNGw5dnNJWndnU1ZMeEpScVpBSk51b29mTWVmKzlHT2JXM0VNZWFP?=
 =?utf-8?B?NmR5eFQ0bWl4VmRZRTU4a3VOdnUra0JwTjU5Rk9tUFQzblM2dVNRbmhIcmVl?=
 =?utf-8?B?RER5SittOFhNcTJlZ3dvR3cyL1FLbU1sZFBRaDJ1Z3lBWjJYd1UyT3NuY2FB?=
 =?utf-8?B?RGV5ekI5ZCtaQUlNV0ZQYnp0bGlJUlFlYlJEWlRDbWJKNVhOK1cvN21xVGFZ?=
 =?utf-8?B?N1hKamZsVGRRY0J0QzdLaDA1LzQvTVRmUkpvaWpMVjZmdXNkZ0RBdDd0bHY5?=
 =?utf-8?B?OE9sNnI5b1VNL3kvTTk2YXB4azhZZEs4Mzljd3cxWHNNVVFzelFkQXltMmRs?=
 =?utf-8?B?Q1FuMWJZVFRQdmNBYjVPeWxVRWFsRnJ6Q3lkRG5obWNuR3U5NjJCam5hM20y?=
 =?utf-8?B?bTBXOXRuZ3BUa3dPTklGUm94eW5oWFlkcGtReXRrRk1ZSTY5UE80SkdKSW9w?=
 =?utf-8?B?UDdIeHlQc0VUUDlmeTdiWjdGVHhWMmhqcVhHVW1YTFBpVFFXczNTejBlWTJU?=
 =?utf-8?B?dERkMVU3dVJnTXdJbFBqK3Q5NkhjYUgrejJQd3FpTWhES284UHlYUXI4Ukl4?=
 =?utf-8?B?Y1h5WG9zaXRvQ25kS1ltd0txZUJncW9vOURndCtYSWlIQVpIWEJ2azBmS0NI?=
 =?utf-8?B?RUo1emw4Y1VFeTdyQUpLZVZDU2ZZd2tONG8ycW9RTUpSb25pREFQWTdTS2Vv?=
 =?utf-8?B?S25vUWlBZTVzcTdpSEl6c2ZLWklLTkI0TVZwaEhVejJWVjIwQ0NyNjhET2Ju?=
 =?utf-8?B?SmFxTkVoRVpxU2poeGpzMFdhbVZYQU5SK3kxMVA1eG55MGxDcFBTemtkMFk5?=
 =?utf-8?B?K0VVcHN5WS9sb1gyWmJhUHZTOGJZVCtuZ3B5RzBGTS9zNzI3cngzdUJpQ3dU?=
 =?utf-8?B?UWdUQ3c4ZklrZmNTTFRiTzFwSUZCQnhTUjB5QUVkeVNmNjhnMnpnQ3lBUy9o?=
 =?utf-8?B?RHovQUg1cDJCWlhqemF0eHdBMnhiWmRVYkJWQitnYndkMmthaXFwN0J3Z0xa?=
 =?utf-8?B?WFJ4VmgvS3hyMTZlcHEraFNzb1UveWoyYkxTUk83cGVKdTgvd0N6NWsvMDFY?=
 =?utf-8?B?YlhOckhLTjNIWVMybUdpbTMxVW9NdS8rWDBKb0t4N2lheit1VmFxdlRlV1Ew?=
 =?utf-8?B?V0FuRWw2N3k1Q1VjU3hsUW1sZ0hDS21FRGUvNStwODIyQWNmSGxCQ2pJTWc1?=
 =?utf-8?B?SGxhYXo1U3p0ZUNkMzFhRit1eUh1eEszZjFEaVowRTBobm9CTEQ0NVdNdEp0?=
 =?utf-8?B?R0dCaHNoNU1rS2hWaWQxZUMvaU41L3hQRkt2MHdXaHExMTQ1d1VJQ1QzMEtt?=
 =?utf-8?B?Mlpybzl6OFpHQXRFOXFFZy9PbmF5STBzU0d5UXIrZmtzUWhvTVVmTG1TMndD?=
 =?utf-8?B?TWt1SnQ5Sm1ubzFIY1BwdEZXWWVXQ1JKRlhsRStyUiszWGRWMHJNMmt6VTlY?=
 =?utf-8?B?WXVhQ245WFFSOXNOTjE0OVpPSFhOb3N1TzZQZ0I4QTNUTlpzdE01MHMwMXpF?=
 =?utf-8?B?Yms3OFlPNmkrL1BFdk1BRWxvWXFvRFIwUEZIVFRGbEhSV3poTzRHYkdVV1VS?=
 =?utf-8?B?UDVRY0RhQjEzWEFoVEhJWFhvSVpYU2VZM3NPVmlzOGJjNzRUMXo4YmFGaUl4?=
 =?utf-8?B?ZGdlT09IMldIR2pBR1lUTVhxUUVwQWEvM3VhSUlaMDdRdU5tMkYrM1BVR1NS?=
 =?utf-8?B?UXpNMlgwTXdBaWJ6eU5iUTNWb1lFWFdySmJONGlBY1BMVW1keEdSdTRxUk5j?=
 =?utf-8?B?UkxOVENYT0J6aVNnU2JyT3RjRUNkVDJpR1lKNDR4QlRoUnN6VUluZXdlTURq?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MCKuqfgUXsK+edVfH0AnaWUcD0f/5HbQr7s7U/4xlVgA3zikDCQUJH7IRPUQl8RH6s5ymX48FBSEvvNjA8rLtxFklA/DFphQc1KtQgLKvrQuwChdBJ6A9lVu1W1P1NGNkks2Xupmi6APkE91+tAAXlhREu1hWnIIaeaqEDpgLNnH0hJ6gZ6pCiKCtIHAoUSUxRJFbiNEuElGNuVwcJrg/5mW1DMRj1c392Kmf9Pv4gj/VIcFxHFL+MUSNfBcqh07qlzIQW62afS51vGmm/g9ITd7sgmkQwybrkTFY09nncQFcg1pSXuRvoMbLHP5cQDVVjqTcJszLkZldPw5BxLvzjIVVCV4lkhrkcKQUkLfIYFqiAdXmi2XrccqMoQgirW7kvwKWbS4IYZHAo3NGqA7mK+qVapiv9rYMoesxublJameWQVvDBzGTHc/qIZ6BxHaLx0WBAXokpJ39s1/BDUDYUacKRycesDK6gELjnGlOUxMFzvK7ExFKPX0Mlele6iGMZ/uU01ogqig+SreiLeFktVarsf4n2fYXar7Pxotlvcd07mfHCNyjBT3Yi6EBIccHz+LmsZreOM8SAKIoGE3aFxgT7RFIHfWoKa5nbV/TBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5ab37a-936d-473b-d1bd-08dd5bdd29f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5891.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 11:59:20.7985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MNHA7mVW0VwdcxmgsLBU5EUINea6ykK/T88GgXJL/aie9E0XrA3wHbyBte8tA81pCFf+AcaVpauyhlxUYK8cy/4P5V4ebDS1sK/6b8G0D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503050097
X-Proofpoint-GUID: 7iMJvsHvAWY273RM6tMlE0iOPkXLLBrs
X-Proofpoint-ORIG-GUID: 7iMJvsHvAWY273RM6tMlE0iOPkXLLBrs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 08/02/2025 02:07, Zhangfei Gao wrote:
> On Wed, Jan 22, 2025 at 12:43 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> On 07/01/2025 06:55, Zhangfei Gao wrote:
>>> Hi, Joao
>>>
>>> On Fri, Jun 23, 2023 at 5:51 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>
>>>> Hey,
>>>>
>>>> This series introduces support for vIOMMU with VFIO device migration,
>>>> particurlarly related to how we do the dirty page tracking.
>>>>
>>>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>>>> provide dma translation services for guests to provide some form of
>>>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>>>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>>>> and remove the migration blocker when vIOMMU is present provided the
>>>> conditions are met. I have both use-cases here in one series, but I am happy
>>>> to tackle them in separate series.
>>>>
>>>> As I found out we don't necessarily need to expose the whole vIOMMU
>>>> functionality in order to just support interrupt remapping. x86 IOMMUs
>>>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>>>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>>>> can instantiate a IOMMU just for interrupt remapping without needing to
>>>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>>>> the same, but Linux doesn't quite support the IR-only part there yet,
>>>> only intel-iommu.
>>>>
>>>> The series is organized as following:
>>>>
>>>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>>>> establishes their first DMA mapping via the vIOMMU. So these first four
>>>> patches add a way for vIOMMUs to be asked of their properties at start
>>>> of day. I choose the least churn possible way for now (as opposed to a
>>>> treewide conversion) and allow easy conversion a posteriori. As
>>>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>>>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>>>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>>>> was doing in v3.
>>>>
>>>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>>>> DMA translation allowed. Today the 'dma-translation' attribute is
>>>> x86-iommu only, but the way this series is structured nothing stops from
>>>> other vIOMMUs supporting it too as long as they use
>>>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>>>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>>>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>>>> we've then tackled item (1) of the second paragraph.
>>>
>>> Not understanding how to handle the device page table.
>>>
>>> Does this mean after live-migration, the page table built by vIOMMU
>>> will be re-build in the target guest via pci_setup_iommu_ops?
>>
>> AFAIU It is supposed to be done post loading the vIOMMU vmstate when enabling
>> the vIOMMU related MRs. And when walking the different 'emulated' address spaces
>>  it will replay all mappings (and skip non-present parts of the address space).
>>
>> The trick in making this work largelly depends on individual vIOMMU
>> implementation (and this emulated vIOMMU stuff shouldn't be confused with IOMMU
>> nesting btw!). In intel case (and AMD will be similar) the root table pointer
>> that's part of the vmstate has all the device pagetables, which is just guest
>> memory that gets migrated over and enough to resolve VT-d/IVRS page walks.
>>
>> The somewhat hard to follow part is that when it replays it walks all the whole
>> DMAR memory region and only notifies IOMMU MR listeners if there's a present PTE
>> or skip it. So at the end of the enabling of MRs the IOTLB gets reconstructed.
>> Though you would have to try to understand the flow with the vIOMMU you are using.
>>
>> The replay in intel-iommu is triggered more or less this stack trace for a
>> present PTE:
>>
>> vfio_iommu_map_notify
>> memory_region_notify_iommu_one
>> vtd_replay_hook
>> vtd_page_walk_one
>> vtd_page_walk_level
>> vtd_page_walk_level
>> vtd_page_walk_level
>> vtd_page_walk
>> vtd_iommu_replay
>> memory_region_iommu_replay
>> vfio_listener_region_add
>> address_space_update_topology_pass
>> address_space_set_flatview
>> memory_region_transaction_commit
>> vtd_switch_address_space
>> vtd_switch_address_space_all
>> vtd_post_load
>> vmstate_load_state
>> vmstate_load
>> qemu_loadvm_section_start_full
>> qemu_loadvm_state_main
>> qemu_loadvm_state
>> process_incoming_migration_co
> 
> Thanks Joao for the info
> 
> Sorry, some more questions,
> 
> When src boots up, the guest kernel will send commands to qemu.
> qemu will consume these commands, and trigger
> 
> smmuv3_cmdq_consume
> smmu_realloc_veventq
> smmuv3_cmdq_consume
> smmuv3_cmdq_consume SMMU_CMD_CFGI_STE
> smmuv3_install_nested_ste
> iommufd_backend_alloc_hwpt
> host_iommu_device_iommufd_attach_hwpt
> 
> After live-migration, the dst does not get these commands, so it does
> not call smmuv3_install_nested_ste etc.
> so the dma page table is not set up and the kernel reports errors.
> 
> Not sure if we need to set up these commands in the dst, or directly
> copy the existing page table from src to the dst.

Whatever constructs the 'root' of the device page table (STE entry?) that allows
page table walkers to get resolved, need to be sent as part of the device state.

And then the post-load callback is what then mirrors the 'present PTEs' into
host IOMMU pagetable(s). At a quick glance this guest information looks to be
migrated via ::strtab_base and ::strtab_base_cfg of the smmuv3 vmstate.

Your problem seems to be that nothing is loading it (in the post-load) and thus
nothing walks the whole (migrated) thing to reconstruct what you had in the source.

