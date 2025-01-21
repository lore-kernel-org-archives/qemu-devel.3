Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D14C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHLI-0004BL-Rw; Tue, 21 Jan 2025 11:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1taHLG-00049n-Ls
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:43:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1taHLD-0002p9-QG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:43:06 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDwoD000594;
 Tue, 21 Jan 2025 16:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tB7Ey7M29voEnQb2KuKi8xBRP21khv6BgNvCf/ElSNs=; b=
 orXWt7mfkEbLkN5BcHu5wbIEMPUefqifdJTM2vsWu2LCaEiWYkkPqfN1nh7ojZOh
 hDBKw4OVK7ITiBAu7zLrol9//KCuo1t4ppNg+rWZascYIpDePefr+rEmOEwpU09s
 4eLvOd1s6cdJQrkF/BLVNk6Sthfb2P+PvLy6D566AF7suU7QcG8NsJnnjkmB/wVk
 7+8RP0Bf3Aoqpap+tagOn0+WeZs7E9XbxJRCrkpVj6slC+voMxLoghZfooUlo4gQ
 ksPVfdKfnE/aAWopkKfyrWTr27ZFVolVkc4PrcbW2EzC5lInCNEugJxwZUWL0blU
 xYZ8igsfkcP3pV3M245z3g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsdrq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 16:42:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LGK6FT018931; Tue, 21 Jan 2025 16:42:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491c2h1v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 16:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZHFeq8bZTm6q/1Cv8SRkmyB+MFVR1IPW1AyvWsyh++aZxlUnpHiy4ULInI26TpL0ou1mHrh4KW3SMk/LyKvX8ndErjvLUHmUPi3+2ZbT5JxPmC0PpkBI/dNt+S9vLmQFiBM0b10w/SYo3G/6Rd1evuJLveGN8rpC3FObIH/Y1xXBzlXDV++bXzCsz7YoNBLhg8PSz5nMC+lct6S16Y8mOXxTt6HA6WxV/8X1L5jtHgw2oYbGddPRsd6ZAWPvqpKjF8F/WgYVgL8U0Rt4Z6h+TthJE5tZy3aV2wcbYI8+q0gr36O7BjvaSWWeXKKFsxAMX+iSpZKJvbZQTBLRxBP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB7Ey7M29voEnQb2KuKi8xBRP21khv6BgNvCf/ElSNs=;
 b=ZRsneYpKJGcdGqQZUuFdYyZhQXaS43JVUnowGttzjN4GJ2GHscS44zoaXpACqBT+bF2EBpAQbsjumVCzDxfH+MVCkAUdJsbRXIeAAxJliIQFHOi6gfI+2oTMKmZFBm5ND7szUZ1g/LRBdmHP4TSp8LeKtyRJl75eXXaEMH5m0HME//yLdklyO9fsF5o2HnSHlpOQZLy8rUrNEcksKzzsElAsjP+XwtY8AIJKIdMLQ2B040ROAmjsMtNU+svcsIA35fXFTJPMmNK/834zwp/+PU4gx/hBKoEmcAhoX7OELdEjhKmnm2lBTYPt3Ob1U6MqV9H9VV+64smo676kQuz2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB7Ey7M29voEnQb2KuKi8xBRP21khv6BgNvCf/ElSNs=;
 b=M4t4bVJZZ+SmGOdbGUVK8vJWllao4nc3Ant8Lcjc9tWWw33tZbzMHb+rimuBavx3wmtplsCzAdynNpuzpjmp5qS5mHJfCNnc2NiPQFK7UN8Qf5zQZthTFXPSb0p16qn2oBrb0hgBeoGhKTUygh4CwoEWEbBhHrr5TQDAuNt/nYg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 16:42:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 16:42:54 +0000
Message-ID: <0c390889-9103-4795-ad22-8a654ff425b1@oracle.com>
Date: Tue, 21 Jan 2025 16:42:46 +0000
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
From: Joao Martins <joao.m.martins@oracle.com>
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
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <CAMj5Bki5gaHrOnj=JSrv3nmva6N2Y2OrDB7sE03WQHkqyXSheQ@mail.gmail.com>
 <021568bc-6463-43a2-9312-12417c7be558@oracle.com>
Content-Language: en-US
In-Reply-To: <021568bc-6463-43a2-9312-12417c7be558@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0124.eurprd04.prod.outlook.com
 (2603:10a6:208:55::29) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 356cb7d7-70d6-4ebf-9758-08dd3a3aa6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2hiSXk3QzJCWG1NdkY0QllFak0rZnZqdEhVTURyaTRGQy9WMnY4RnpnQlc5?=
 =?utf-8?B?b3p3cFMvWFYwN0twSDdQWS93RGhtSmdocTgvQ0FmVUhndHlQemJpZGMrTVVD?=
 =?utf-8?B?ejNObjdlNUFmVitmZmZSVzJJbnR5U0lQWkhxbGNYNmM3cURGdms1bTB1amtm?=
 =?utf-8?B?V2duNFY5NEViS1Nid3kzTi83WUhuWXNla053WHZ3YktjdkJjV0NoZmNENlk0?=
 =?utf-8?B?MVgyYUlycnI0bHFqT1MzTzFXZjNkWGZidk5sdnJEMksva2F5Tlh5Mlg0aTZH?=
 =?utf-8?B?VjVLWjZYVUpSWVJZeWprMFdLVi84U3VpdXBFTkJBaXJGN1BFTkxIZkhBTUJX?=
 =?utf-8?B?OUFrZUY1b3F2TSs4NGE3VEE2bWYwM1NNV0Y3bnJlSXF4KytqTG5iZWc0bjF6?=
 =?utf-8?B?YWIyVk41RGw3SGpJNmRPdlFKRjlkcVErcjRPQ2IwdEYxTFBtclpUbUdsUlBS?=
 =?utf-8?B?c3ArSHpTYktncnUvaWEvYjMxMzRSWDJPMHdXaEFxc2lxT2lqallxZDFPSVpj?=
 =?utf-8?B?N29kcm1waFltUk5qbGZKdXJiZGlRcmRBaEVHelp4ZjlqWlNkdmVkREl6UkpW?=
 =?utf-8?B?enU5Y2N4MUlQZ3hsU3hnaVl6bTYxY3J4MVlZNVErZE5rdE4xSCtYVGFPSGZ5?=
 =?utf-8?B?VHQ2SEhqMkNLUWdTNXM1ZmVVczZWT2VOSHNwTzJvS1djUk54QVc1Z0syZ3Jr?=
 =?utf-8?B?YkYrVmlSVmZEOVU5WWVnVkpSdjB5WjVkSWRZckk5dHMrTmc0UDlMSGRvRlRH?=
 =?utf-8?B?TVJtTkZVeUJLZ0ZRbTN4SE16eVY5b0JGZ1B3Q1hnUE8xd1dQbDBKYjg2dW5o?=
 =?utf-8?B?N1lmUnhHVmtMR0hYeW4zaU1CbnUvdm00MVJJVTYwc0tXcDJzYzhXbk45SlQx?=
 =?utf-8?B?YlN2eU5LVXVrb0ZDb1VGRHRGNUNYN1Q1bDhKN09DRm41KzY4RmlIZS9iS1Ro?=
 =?utf-8?B?c2oxNUZyeDNzbm1zZnJtYU8wOTVPamtEbVVXTW84N2ZLWGNSdmw2UTZmVVEz?=
 =?utf-8?B?TFphQ2p0S2N4YTlLVVpub21zSVRpNHYvcnNHaVYxbkJ4UnV3UkxXcGI1UkFs?=
 =?utf-8?B?S0dpNG4weW1BTnVLV2hFUDVSVjRVMVZ0VE5pM2c4b2JPajBKVEZLNzlGMklH?=
 =?utf-8?B?THh3U0hFSjlQNHVHOSt0Q2treGlQeDFhSjRXcXVwMUFjTXdMSC9UK2R4bEJY?=
 =?utf-8?B?bmdDOGVFNkpoWEQ0UXdObG9TZzZ2TWVoaExhRWNVN001ZHlLdGxkcm5sWXh3?=
 =?utf-8?B?Y0hmNFFLY0tOSGgxZXNJQzRyb0dDUzlNS2VlMk5ZcnJtdmtpOHdWZHFDNHdY?=
 =?utf-8?B?NFRSbERGMElCV2FOTldaU0NRdlVpQ0t0S0g2eWthQ2VWejFuVVA2czVFWGVF?=
 =?utf-8?B?R0tNSGl1N3pDd003SVRqNTBMeFIwaVlIbWM3NDVNT056VWRkdlZRQUhCZFlx?=
 =?utf-8?B?RVlmWFpEWnpwV1luL1Bvd0UzN2hPcUsyZkxvRWFRTCtpL3BBWUFtSGJPUTlE?=
 =?utf-8?B?THg3MGFjRmVmZURyRTR2NitlMTNPdUJ5ZXE1Sk1Rem9XeWYwbVBJNWV5ZFJE?=
 =?utf-8?B?WUYzUStwMzcrN210WVhwemxLWkZYdjkwSGVBL0tHd2JEN2dvbm0rL3VraXVF?=
 =?utf-8?B?bDV6SThReFlITS9LanRJUE9jRG5pdUFXcVJ1dllxZG1sVHB3R2p5SVNjRVcw?=
 =?utf-8?B?eUg1TG40Q0xiNkYyM0N5NVd4NUx4Sk5ZMG52STV0Z2VrSUsxWHFmeEcwbDR2?=
 =?utf-8?B?TGZXMGhDNDFBS1NwaVNwYThWcnk0dGhjRWJmd3o5UTA1NFY5azNlby9iY2tP?=
 =?utf-8?B?VlpWbzdWMXhZZk96ZWozUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtYamdJUVh0Wnd4Tmkvd2pDMkdycVlMQkNVbk5LcWIwWnVXNDB0cC9wMzVt?=
 =?utf-8?B?bDBWZjNCQVJWN1R1UkVsUmxxYXZYaTdMV0psc2VEZVJjRG90TWpiQlgyOEdB?=
 =?utf-8?B?b2d2M2hHVUlCd0JIMGp0VTlQOHJ4Qno1cW9LQ0lUNWh4dGVlUUlMUFlDT3Zq?=
 =?utf-8?B?YWZBVnFiL09QdWhIQ2tkd1RSdXgrakJxT2JMRm0vNG8vaTZpMnpOa3lPb1Rm?=
 =?utf-8?B?cW0zeW9sbjByaXVnK09xRjk2VGZtQnJ5alA1dkdMbmgzWFBhSjJoSlBPL3hM?=
 =?utf-8?B?VStrR1dvVDNmVjZ6ODQ3blVZSUtaUlpFM0xoVzg2dHdib3BUMnJZUjV0KzFT?=
 =?utf-8?B?dnFmRkRPQVI1TFdyMzAzdVNpU3k3eXIrRnRuQXBqVlZhcmFZVE9EZUN4ZzlO?=
 =?utf-8?B?WkxyQzZ3eEpxZDNJSEVNa2NlK0tRdCs1Nk0vLzczWGp1VGRiM2NySTJDeEhU?=
 =?utf-8?B?WjFpSlJOTDh3eVBucVpOMjc1VGs4QlNvcmpZNTJTQ2RsQVJ0Rys1aXdIWjNk?=
 =?utf-8?B?YUNSTkxjNHk4M0xqV0pabVRmUmFYRFFEZnBwVHJ3b3BVbCtEdlptRU1BV2sr?=
 =?utf-8?B?MXhlaDhNTHRBdWRlVlFPbE1pOTY5c3JrTGFSNGRsSmZNVXozb0lKMS91bGs0?=
 =?utf-8?B?emRiY3lYQnNUcWFQNDliamFLQnpKNmxFK3ZUZVhuMkRwU3IvTUwrVE9MTXNx?=
 =?utf-8?B?a0MrMWQvTDQ5ZDFMU1prekJjVnM3NklCSzZOeE5zejJuK1N3WEpybWhaRXBW?=
 =?utf-8?B?K1I5dE1NeVd3eVNBMFpTTGp2VmVna00xSXpOb3Y2eEQxQmFXVjhtT1Z4RklH?=
 =?utf-8?B?cjY2bjVRZG9qaEFnRGxwZEdYTjEvT3NiNDJjTmo4WktJUGVGa0pyVjFyVkxW?=
 =?utf-8?B?dWpubmludWRBYktZeFpYVEhCOEo3MDdEWEhJeTArSW1Hd1lDVDd0OFVuNXo1?=
 =?utf-8?B?YlBzc1FVUWM1dWgzYVY0TlMwQmhFQi95bUpzY25RN09GTVFETkwyd1VRLzRQ?=
 =?utf-8?B?SGdKSHNnSmM1M2g0YWVaMUFndUZvaGxWZXZQcHowUU5zckZ5WDJDZ3B1WW5j?=
 =?utf-8?B?UGxoTmR6Mi9yOC9xWmVJMVk3Mnp3aWZZZ2s4M253K2JtSEVpYWlCWmpuaWJi?=
 =?utf-8?B?VnI0eHlLYmpjOXh0cjlCK0VuRWthUGMySHJ5ZlIzSDE0YmltSzNPOGp5VHhK?=
 =?utf-8?B?ZG9PblBPSlk2eUxnSWI5d25sTVdxVWdRU3RpMUpBT1NDaVdzU0tUQ3hmd2hE?=
 =?utf-8?B?U0ZEM2o1YlB0WHpOTlNlL0VqOTZtRW4zSGFac2Z6ME51VGNOd0pCQ3NOTTR1?=
 =?utf-8?B?RUVESVVZeUw2L0JRMXZSQU10RFptalZwb1VyWlZZdkt0MWJSY0RKNFczZzUx?=
 =?utf-8?B?TVdCVXo1VCtmYUVrV2pvcUJsaEJydk9uamFWMldaNmwxbXBUVzRCRFE2bkM5?=
 =?utf-8?B?clVHOGVDSWJVelp4aHlBSUQvUXVWcVE4TXZOZnI0Y0xSMVVBak83elRSbEFQ?=
 =?utf-8?B?YllneGdqRHdLU1Nna294QW0ybGNGRVlDSEhQRjVUVFZHVnVUanZPOHQ1dW9X?=
 =?utf-8?B?SUs0c2VyaVExTFdkN0p1ZEVRSkc3RjRNc0VjNyt6RzZjUTFCd2l6aUs1T0N6?=
 =?utf-8?B?bWZpM2E4L050c0p5MEt6MEdyd0tsY25mNlp1Ni8vcSs1UmU1QVlkOTk0QW5p?=
 =?utf-8?B?T0FLRUFtb2o2SHVYN2JTRUpWaTJ4Um52R3I5emIwVTViZHpGUW1zSHZQQnBB?=
 =?utf-8?B?REpJSkZUd0YvbTd5cWpjRmRGTFY4czFUQnhJcVhQU2liR29aUkFyalFWTGdT?=
 =?utf-8?B?R1pOVzk5dzl2Mi9XNlpURngrVlVJcG5aeUdCQmdlRmJ6elZKSHc0bEhEaTR1?=
 =?utf-8?B?UFh6d2h5VE16WDVzd3lwa0Y3MkIxWWk1SDdIOUxqS09zZW1yaW0xZFloQUFB?=
 =?utf-8?B?WWdkV05WdkEzalA5UTQ3OE51QWE2STV1M0kwc3pyUlhLUWdiWjF1R2pUcnMy?=
 =?utf-8?B?RXNXRDh2WmN2SE5hdjBLY3RCWSsyNmljQXVXa0xpS2NvUUFPMFVoN3lrM3hq?=
 =?utf-8?B?U1IzWTE5OFZTN0ZqanhHanRnMU1LQklrSWg2U1VRenBiOXBIRE8xUGRkWUtu?=
 =?utf-8?B?U2RneUxtYStXbjZtOTNYdnJLcHFpTS93eStZdWIvRlFiNHF3VG42ZWZCYkhr?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Z9ryXyZqHeA7jqw6fCp7TsMPnYHrn35Okk9nlbZDL/QY35VQPc/qy4fFkJCVjM9calcGocunVBSHP9W7+fJAHuoTV5GkBlEpMo+oQh5CLknUV/x+pqLkLjF5mWdRpWuWr1pvUEF9+mefJvSfXZB9EUMJZ+aud7Y5ZxiBIPxKVFr0Tdp33ALV/+aGFCG5YlUjD2CBPY9IzVmEfyHntA1tyKPJMQ/jjNxwQTd/iFjOtrAJW5jR2d/OKfDsa74l8mppqqIHb00r9rG5xFjZFsP9GouPcPs66K8o59oPlN7LGFZNChiGqbxpSzlwE1dnvnpzRBpO2iJrsDdWQWQqfpWuAPb78ykwmWB6vU39j64Js4le+9AjQry+aOYKhO06GCdC+lY6Mn+IfHRlAAB6hGkfiYLbmqDjNlflzVhF/l5TxRYDJJOV/Vmr+wir3FbHnvJryNNOt16BxjYHhcNN8fWRDgrV4MEDvzMBMe3o6LpDVx2F92sKd+zNWQOrszNA7imTenP/FhkqthWY5glsEuBAtEvAUU8hKeoTM5ozYaWIWwRYySVqZaZ9Hwz8H0GmWemp4sslhzQ6WL4thteR7Qs9CVBErHWyFl6kXjlF5RXL2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356cb7d7-70d6-4ebf-9758-08dd3a3aa6e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 16:42:54.1800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX8o0IozG8T8izES5MT1acpjeIRox2dV3NfvO6h/aZ1hAr0/FmPeU3r+81S8sGrrv2xOe6g7cMU1dmFo3g9Qnp6Oo4fai7aL/K34AEhLd6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210135
X-Proofpoint-GUID: 50t6SE0L0GrutRKpy_hSs6xN7plGQmG6
X-Proofpoint-ORIG-GUID: 50t6SE0L0GrutRKpy_hSs6xN7plGQmG6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/11/2024 18:29, Joao Martins wrote:
> On 28/11/2024 03:19, Zhangfei Gao wrote:
>> Hi, Joao
>>
>> On Fri, Jun 23, 2023 at 5:51 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>
>>> Hey,
>>>
>>> This series introduces support for vIOMMU with VFIO device migration,
>>> particurlarly related to how we do the dirty page tracking.
>>>
>>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>>> provide dma translation services for guests to provide some form of
>>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>>> and remove the migration blocker when vIOMMU is present provided the
>>> conditions are met. I have both use-cases here in one series, but I am happy
>>> to tackle them in separate series.
>>>
>>> As I found out we don't necessarily need to expose the whole vIOMMU
>>> functionality in order to just support interrupt remapping. x86 IOMMUs
>>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>>> can instantiate a IOMMU just for interrupt remapping without needing to
>>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>>> the same, but Linux doesn't quite support the IR-only part there yet,
>>> only intel-iommu.
>>>
>>> The series is organized as following:
>>>
>>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>>> establishes their first DMA mapping via the vIOMMU. So these first four
>>> patches add a way for vIOMMUs to be asked of their properties at start
>>> of day. I choose the least churn possible way for now (as opposed to a
>>> treewide conversion) and allow easy conversion a posteriori. As
>>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>>> was doing in v3.
>>>
>>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>>> DMA translation allowed. Today the 'dma-translation' attribute is
>>> x86-iommu only, but the way this series is structured nothing stops from
>>> other vIOMMUs supporting it too as long as they use
>>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>>> we've then tackled item (1) of the second paragraph.
>>>
>>> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
>>> IOVA address space, leveraging the logic we use to compose the dirty ranges.
>>> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
>>> addressing limits. This tackles item (2). So far I mainly use it with
>>> intel-iommu, although I have a small set of patches for virtio-iommu per
>>> Alex's suggestion in v2.
>>>
>>> Comments, suggestions welcome. Thanks for the review!
>>>
>>> Regards,
>>>         Joao
>>>
>>> Changes since v3[8]:
>>> * Pick up Yi's patches[5][6], and rework the first four patches.
>>>   These are a bit better splitted, and make the new iommu_ops *optional*
>>>   as opposed to a treewide conversion. Rather than returning an IOMMU MR
>>>   and let VFIO operate on it to fetch attributes, we instead let the
>>>   underlying IOMMU driver fetch the desired IOMMU MR and ask for the
>>>   desired IOMMU attribute. Callers only care about PCI Device backing
>>>   vIOMMU attributes regardless of its topology/association. (Peter Xu)
>>>   These patches are a bit better splitted compared to original ones,
>>>   and I've kept all the same authorship and note the changes from
>>>   original where applicable.
>>> * Because of the rework of the first four patches, switch to
>>>   individual attributes in the VFIOSpace that track dma_translation
>>>   and the max_iova. All are expected to be unused when zero to retain
>>>   the defaults of today in common code.
>>> * Improve the migration blocker message of the last patch to be
>>>   more obvious that vIOMMU migration blocker is added when no vIOMMU
>>>   address space limits are advertised. (Patch 15)
>>> * Cast to uintptr_t in IOMMUAttr data in intel-iommu (Philippe).
>>> * Switch to MAKE_64BIT_MASK() instead of plain left shift (Philippe).
>>> * Change diffstat of patches with scripts/git.orderfile (Philippe).
>>>
>>> Changes since v2[3]:
>>> * New patches 1-9 to be able to handle vIOMMUs without DMA translation, and
>>> introduce ways to know various IOMMU model attributes via the IOMMU MR. This
>>> is partly meant to address a comment in previous versions where we can't
>>> access the IOMMU MR prior to the DMA mapping happening. Before this series
>>> vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by the
>>> guest. As well as better tackling of the IOMMU usage for interrupt-remapping
>>> only purposes.
>>> * Dropped Peter Xu ack on patch 9 given that the code changed a bit.
>>> * Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers.
>>> * The patches that existed in v2 of vIOMMU dirty tracking, are mostly
>>> * untouched, except patch 12 which was greatly simplified.
>>>
>>> Changes since v1[4]:
>>> - Rebased on latest master branch. As part of it, made some changes in
>>>   pre-copy to adjust it to Juan's new patches:
>>>   1. Added a new patch that passes threshold_size parameter to
>>>      .state_pending_{estimate,exact}() handlers.
>>>   2. Added a new patch that refactors vfio_save_block().
>>>   3. Changed the pre-copy patch to cache and report pending pre-copy
>>>      size in the .state_pending_estimate() handler.
>>> - Removed unnecessary P2P code. This should be added later on when P2P
>>>   support is added. (Alex)
>>> - Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
>>>   (patch #11). (Alex)
>>> - Stored vfio_devices_all_device_dirty_tracking()'s value in a local
>>>   variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
>>> - Refactored the viommu device dirty tracking ranges creation code to
>>>   make it clearer (patch #15).
>>> - Changed overflow check in vfio_iommu_range_is_device_tracked() to
>>>   emphasize that we specifically check for 2^64 wrap around (patch #15).
>>> - Added R-bs / Acks.
>>>
>>> [0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
>>> [1] https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a3b@oracle.com/
>>> [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
>>> [3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
>>> [4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvidia.com/
>>> [5] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>>> [6] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
>>> [7] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/
>>> [8] https://lore.kernel.org/qemu-devel/20230530175937.24202-1-joao.m.martins@oracle.com/
>>>
>>> Avihai Horon (4):
>>>   memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
>>>   intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
>>>   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>>>   vfio/common: Optimize device dirty page tracking with vIOMMU
>>>
>>> Joao Martins (7):
>>>   memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
>>>   intel-iommu: Implement get_attr() method
>>>   vfio/common: Track whether DMA Translation is enabled on the vIOMMU
>>>   vfio/common: Relax vIOMMU detection when DMA translation is off
>>>   vfio/common: Move dirty tracking ranges update to helper
>>>   vfio/common: Support device dirty page tracking with vIOMMU
>>>   vfio/common: Block migration with vIOMMUs without address width limits
>>>
>>> Yi Liu (4):
>>>   hw/pci: Add a pci_setup_iommu_ops() helper
>>>   hw/pci: Refactor pci_device_iommu_address_space()
>>>   hw/pci: Introduce pci_device_iommu_get_attr()
>>>   intel-iommu: Switch to pci_setup_iommu_ops()
>>>
>>
>> Would you mind pointing to the github address?
>> I have some conflicts, and the github will be much helpful.
> 
> Yeap, I have a series -- picking up from Cedric's rebase since 9.1 soft freeze
> -- but testing is still in progress.
> 
> Give me a couple days and I'll respond here as there's a little more changes on
> top (now that we have IOMMUFD support) will get for v5.

Here it is the WIP (there's still 2 wrinkles left):

	https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/

The first four patches relax the LM blocking of viommu if it's using IOMMUFD
dirty tracking. The rest is roughly this series that optimizes things a bit
though mostly useful for VF dirty tracking.

