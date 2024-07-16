Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B855EC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlKL-0001MA-J0; Tue, 16 Jul 2024 12:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTlKJ-00016c-Kv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:46:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTlKD-0002CZ-Sk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:46:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GFMWIl002735;
 Tue, 16 Jul 2024 16:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=liHfpPDA+xmAYG7opOH62RGvuDuPftKol7CEgIOAXGc=; b=
 kVwTx2uF4ZJrkWbRIpcqvJ8+p5yM1Z57zeyq7sEpK5cqGA4NLL0xwdSE90jZJmGK
 BH8/dwoXNKKtI7Kl0quGB65JRrcu1MoMX67P2eamM33LnhKCuFtp5JAU+7HVrGH9
 o05187qcV433nTPB7iESfOWsBUdU3Xy+vYR1mkPgNMcJP049MYfyi02MkK3uOLt7
 WlPVMLfO6spVNQIEo0Je7Dyo/+ar+0b1e6EFnSfNHDFB1qrQPrc0Bz1LQ6oZAgLf
 am+hgnJE5VEGfglyAe9KXnUSa9QENzUVgfk2nWu/u4+DjZCNvhsyBH9Yohof1+Yp
 U9e2qO2sJW1O1Q/UagApQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bj4tp494-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 16:46:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46GFRkeu010635; Tue, 16 Jul 2024 16:46:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg19tt93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 16:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+QB31SWPRsoLjaIL2AaJFSTwXCSVKwRXoCzFoE2J6wqAkdQ6naqnEs/uDk/c3WunLj8RvCOXdPvORGEdhGlibUihY8byQt3OLYBxlJaMudwst5RNAOuuMkq8pCJ3SZLf9nJaAG5NnnLnCwD9XOOyJzMY2lNdQTtgUxW8k5+1gPPZNR5YKkrw5QjaMQlFPnm+tuIhgobYSPqfv8r/hEpPYDzNPHLgcpfq5a/OEYPwHR5+9XjOiQcdsMTFwAY/J/+98H7e3ZDLGPvq2FJFZXDjtn7J4udrNttSA+13VzVuQg/1u1hEkJSXp39UsNszaSME6uRcR9deaimrV/ogBXfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liHfpPDA+xmAYG7opOH62RGvuDuPftKol7CEgIOAXGc=;
 b=bcyuW+YgOoyeGOh1Dk/LPp2ruShS/1XA1seI1zHfIEr+Gn1hLtXplQO3yDrpvypC81pYreO+ii1IW3lTTC0VnHxP0NbFedPXkk+ixLslBVlCrjMUNzyjAZWJ3P8dO7/FxmVmBv0UXUuZAslrXrInwtWnitZ477OaIcFKtuatAgy4JRjfq08ep9Fof8hH80C2iC6ZhtzhqGLRRsAcxBm6tE0mTFAvDvuUtki5GHp6e8J2LtrkyDTxZJnWaW4uYX3goEHk+cMbu4B11X8LlmDy/yL8klLjyegP3TnDm9zX1ORADJ8gnYEdpsDNdyLmD0KctXUHOuYPULEYs5RUmUn+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liHfpPDA+xmAYG7opOH62RGvuDuPftKol7CEgIOAXGc=;
 b=nSo8L3dxmiu5HwyFx2d2RE1/Nk+j3GOUYGYEBRsv1FAtBRzUAM4cyDUS2nXC6ouQEXkGXKzFviTZ1zh4krtgtUacD+Cpup1aDu8TVmjcFyO3k+fhfMth6krCni7DJDEBEpeYDlKFl6eb/3qPqIuDskTVLCu37twDVTlMiCa51Lc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 16:46:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 16:46:43 +0000
Message-ID: <a67edbc5-68ce-4967-b8b9-a440904ed1b1@oracle.com>
Date: Tue, 16 Jul 2024 17:46:35 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
From: Joao Martins <joao.m.martins@oracle.com>
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
 <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
Content-Language: en-US
In-Reply-To: <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0210.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CYYPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 242b2199-edbd-49b0-f0c3-08dca5b6df56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3F0bTM3Tkxjbi9zeTlkTUZWWjZjREtQWUdRcFpLWDUrNlJEaUoxTWZ0RmRC?=
 =?utf-8?B?aXRKZUh3bzI4ZXNZS3QxZ0ZiOFpMT2xKU3dLNEU1YU5xVXRxcVZFQ1V3Wkwx?=
 =?utf-8?B?eWRyelNmRCtscE0wdHZaQ1BwV2MyQTA5YlllVXVGUVUyUmdpS0VvOG1uVmNG?=
 =?utf-8?B?RGJweFpkZmNZVHhmaEZqb1EzakE4a3Y5czRQYWZmd0oxNWF6MWRIVHVCYUR5?=
 =?utf-8?B?bWlwQ2NVRE5PbHhSa1FtM25MSTUwL2c2T0Y0bHgwc1lIZjJOZ0lSYTE1cjNv?=
 =?utf-8?B?WElqNDZpVjV3Mlc5SEFQbnJtbktzVUd6b08xSHppZ2lXUVpWQ2VnUitYZzVV?=
 =?utf-8?B?R3FpTHBpeUVUcEQ3UEEwL2djME1NaDd6azlpRWNFU1JFR0FMU0RtSVRkMHh4?=
 =?utf-8?B?Ym1kemVYc2ltcnVicGlYdC84OTFMdDBZREdsOXFiWnI3cG1Sa2gvME9MMVda?=
 =?utf-8?B?YWIycUVPNE5rQlhId0xFSGl3WGoxKzlET1FGMEJ0MmYrVnN5UVNHRWEzaEl3?=
 =?utf-8?B?MnVBTnJJM0k1VEtqdVNpaU1RalZzMVRhbTJTREVOTVN6VERBLytMUm1kMnlv?=
 =?utf-8?B?TXBSVUdaMDVsOXBXbENMQXlTYVJCY2s3elBuRk92VTAvRlpIVGUzcGtQTkRP?=
 =?utf-8?B?bHVVNEhOd2tVQ0pndnEzbmFiM0hFdXZTcnVUc1JsQkt2K2toY2QzbXBXU1ZE?=
 =?utf-8?B?bkZ6dllVZjFJQzZKa1FFTHFsZkMzOHU4MDdzalZrY21tQ0RKWGI3ZndjeGFq?=
 =?utf-8?B?dzZLSE04Qnhrd05OSWVOWkVRYVA3WEpJdVJuK0d2WkZDTTcxRWF0ZzVJK2Zo?=
 =?utf-8?B?Mm9XK3k4ZUI4ZnlMRXNwQnhHdDdpV3o1TlU0SWx0TXlGVkZ6UU1wSzFVRW93?=
 =?utf-8?B?ZUNvZXQ1WWQ0ZW91QjQwd0xnVFBMSVpvNGJwUWdmMGtIYU1uMW5iVWthUzdh?=
 =?utf-8?B?Sm5xeVJmL0pCQ0Zqbkt4NFVsVU4zL3pnb3NJNWsxT05qcmg0QVdWbk83NUNZ?=
 =?utf-8?B?VXUzUWwzTlhrSEgvOWNJcXFGVFJKcjZLNTZBSDNDQnZmQ0hXSGg3WUZkait5?=
 =?utf-8?B?NmFqeXp2cnU5dHVQdHhLSldrK2laYjFibzVCb2pqU3lRV0o2ZHZjZFRnWHRC?=
 =?utf-8?B?anoxc00zT1Bpc0krdUhxWUdQTkVZVDhFTEI0UWswMlRmSmY1dHk5Z0taN29q?=
 =?utf-8?B?S3llMG9Idzh4WHdiZlFEem1CUFZjTExsN0tJWGJqOFp2M245MXFrRkdwSWMz?=
 =?utf-8?B?YmhPSW9xZ1BELzFNOXNHMXU2SktJTWJNQTVlNDh5SG9jdmUzZjgwdDM4NEMx?=
 =?utf-8?B?WG5TdUJQMnA5WkI1YUNlUzVUSjYrTmRTMW80SXRIWUt3ZW9IVURRZ0tsOUJB?=
 =?utf-8?B?eGtRV3RiRFArWVpUZzV2SGZyR2JVMDBpTFVPNDdTd1hCbWV3R0dyeW01Wkg4?=
 =?utf-8?B?Q3RpeUhEUGNSYVJINkF5TXBxdkF3MTJQaVZmdGZKd2RPcUZoSloxZ05LVUFG?=
 =?utf-8?B?ckg3MjBVbTRwL2NhUVdIc3lpbVFjZDlIaW5JdVVzR09lTFExYkRwUjk2MGJh?=
 =?utf-8?B?dHlWdXVZNk9MVllFYVdiWEFjZUt2QmtlVE13SGFvTWR1ekV3bHN3a3pEOGMy?=
 =?utf-8?B?RjdtdEUzc25KL1hLZVF5ZktSMHJPd2pWYVFVdGpBYkxRZHJyeHFMMUZNK1Qy?=
 =?utf-8?B?S0V4ZkFua2F5cUs2SWVRTCtzbzRHQ1BSbXEzbk9vT3h6Sk5GUjhIRDBidVdH?=
 =?utf-8?B?S2ZYa1U4eVh0cDVDeUpsQTQwK0pvbjkvNjBSSC81cjVTV0JoZEt5THA3d2x2?=
 =?utf-8?B?TWFsQmJLTHRxVHljUXVqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXRVV2xuRkU4bmdSaTVRWm96SjJudUJLME5NUUg5UW9rOGVMMnMvV0lTSlp1?=
 =?utf-8?B?R2RPWk8wZnJScHEvUzIxMVpmZGhVTlBLTU95ckUxdDlid3lCczJtaUZJcEdY?=
 =?utf-8?B?b1BsQm5qcTZSVy8xQ09JNWRYWCs1OGxza09FOEFET2xKbDlSRlRIQWdUWDhO?=
 =?utf-8?B?UmRxQjRmN09XTG5mSFFINXlhSEt3eXFXTlZRNThIaUMrdUFGSlZPenlZaTRU?=
 =?utf-8?B?SnQ1elhsMm9mSXducEd6WVdIYy9MbUN2U2dqUmVOMzJDQVJMWnd3bUJ2Q285?=
 =?utf-8?B?QndVVVUvd2NhdERoRC9zT0xmeTNvSFUvQWg2ZkxsM0o0U05rckpIWk1xR041?=
 =?utf-8?B?dVk4RTFvczBsMktXV3VCTjhtNkIyYWxudzBSM0xGdnlZdXNQdllHcnlkS3cr?=
 =?utf-8?B?WkwrR3BwU2dNN3lacXJCa2tTL01tbzBocVJVSUhrYWRYSDg2WmlhUmh2N0pF?=
 =?utf-8?B?bGVKQmdzN2NQYVNIRzJzVkpsNy92clhHcUpMK1BDUHhxc2ppdHJ4YkpHYWpH?=
 =?utf-8?B?L1daMWVtSGpHYU9ra2VHbzhkUVRZaFp2Qk9ObVB4Vnk3TWwrSmRHaGVucnk3?=
 =?utf-8?B?aEVlSStXK3hWckk4anYvMVNmaHZOS3k5Tk1wWlUyaW50YytWM1FOV2tmTXhl?=
 =?utf-8?B?R1pmbGNXMmQzempOYnU3Nlh1dmV0SE5US1pPMXZERGpJYU95TGdFUWxRc1N3?=
 =?utf-8?B?b3BjNkYzN2JscGJpVEZ2QXZPbUZxQ2tSSloxRzFWbmFjMmpWL1BpczVmWWNl?=
 =?utf-8?B?YXpUMkRlOHVaYTBubHJZKzhOd0E5bTFBM1Uya0h5U3ZYeE45UWxidzZmdFpu?=
 =?utf-8?B?bFlhOW9BVndvQmdoWFhScTgvRjZDOU1tSVR0d2s0bkdXRTI2Qk9SYjZpWGl5?=
 =?utf-8?B?T05udHQxOXBrVFZMdGN2ZGZqWW1qdUxKSHZ4ZGkvak52S3pmQ3M2cnRxZng3?=
 =?utf-8?B?Y1JRWlhteHRWWVRTc2hDVnJ2SnBEajdTL1hrRlBaZHZjOVpBc0tucldrUU9h?=
 =?utf-8?B?TU9pQkFvZFVvWGpoRVNGc1B2cWMrOXJaZDYzbUpLOXY2b1VTOXpUMDFFd1ow?=
 =?utf-8?B?N3JaZDk1VnFhMzBtYWNRMHBkVUxPVEE4OTMzQmJ1UXRnVmtrUkc2NUd6MlFT?=
 =?utf-8?B?enJRaE1tVDIzdDFNdUZFdkFWY2xZYlgxNTdrQlc3Vm5iZElXekwrVUFtaTFN?=
 =?utf-8?B?SFFFNE9zbVhlaXI4MjM4N1JSZ3pobEZKSXVRa1BDbG9BOC9sZUJ3c2N3QlJk?=
 =?utf-8?B?aS9TSmZQdUVZK3pRL0tQTWhkVHQzMUNCcmV2YTF0ZWFRZVJmYUxCbXZXN2V0?=
 =?utf-8?B?NldBNmpnSHhXVFpWRFU2dHZMMkxxNDk0b2lWbThOaDZHOHpTS0pDRTNoTVNa?=
 =?utf-8?B?aVhJSjRFNFhHbFdONlZYc0Fla2s4LzJSVVJweU8zTFFubGVxRC94NjZUZmpx?=
 =?utf-8?B?aHBDSDV2c3FscUJscHg1S1FEZFBjNGNFVkhXWGh6VzNBSllrRmpkMEJUQmRu?=
 =?utf-8?B?aW5mQXRKUEdMRFRodkxRWmtRbGRIUWhMekRob0NLZEVRaVIxck9hSU9jQnJ5?=
 =?utf-8?B?MFduODQxT2dxREN1SWxFd0Z0cTJ5UEtRcExMaVppS0M5VmljZVYrMUIrT1d6?=
 =?utf-8?B?TkM5WjJZeDM0WGF1empUQWJPS3loQjhVRDJHcSthbzFvem40YlFrOUUveGRy?=
 =?utf-8?B?SkpwSHJFc2N1K3FvMitTVis2S0pnNEtwSDdvMUpFajNybWprY2IvTUdJdWM3?=
 =?utf-8?B?OU91eWJvem91a2lHZ1pNeGYrVjdyMEtDeU9JYmFJR3NCUXVnZUdkWWlPSUhR?=
 =?utf-8?B?V2h4RzhQUEllbndleDZrY1pIbXk3NmpiWU5aQVVTNXRmU2k2a0NkK2JMR1VB?=
 =?utf-8?B?QTlpeUxCemJXSndGektaNmNQcVVBd21sYndJejJsSGl2RHdIRlBTRHlJTGZP?=
 =?utf-8?B?VGk4RHhNbjN3S01pZkh4UWNkNmJzNnFJM0kxcEplOUZhd3VsUmczSi9CYVIx?=
 =?utf-8?B?aXRWbGUwK3BzWTYzQ3dZdDRnMG9UMkhSSU5OeW83MG5iZVhQUld6S3hHOGUx?=
 =?utf-8?B?a0RzVnUyblp0TFp2RmRta2xVbzNlcmlrdC9oTHJXTFExVDh3TWw5b01wQ3R5?=
 =?utf-8?B?Z3haNjIyWGJKY0p3SGxvTnNrZ2N2L3phcktSdHVBdzJVNVROOE1ZcDJVbVpw?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 39SB3f0eW/X6u9WwR8/zbBOru1JhptWbldFcycYE5ufOMugfeKQs0y87apJt3U5++AU8H+aB6mf8jA6gvdKTOfrgfzbtIgBhB/B2urjd7msto/u23UEgekXKxCtof6I3y7YbrVfW0WJGYZ1GYlzl45P1Q3PjIDgttazj/F5q0ctmJgEiiv8h1eJZ6QWKcgTqwj+j1Tn2BVULKjo8fTUfW/eR3uy3jJKfDe3XlwZBUmR7Ndsw+0hPE2a3z4EoZuTHvjalcgI1gXNC9ZFtv8OApsah7yp/5TBAaVm8/ePLXMms9M0jfs1PqwfyO8IeZCLYdHicoQrcXiyExYb5Imd0J+QCkNVUmrT5tn2p8BayFl59KrOfvcQ8QwpYqH9lOCA7ryDpFsHAX/W7EDjXHBNvn0TsqjU5WZcsr4bTnWS9Mvz+AO+hgMP9PpOD5vpVfsopNdGp6BgkmMecGtPQ1kL1w/K74PgDswkROo6iOiEHTgrEZcmFM8finubx3nJgYI/QMffZIfSKXyySmMPeh9B8rb25O604Rv37ckvbPxUXwLB8jtch5KfWZMHJwmqiiLQfWZo1IqgoEZ2+A92oI4sd+xhZnWd2VIr+SlUhwfEy65E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242b2199-edbd-49b0-f0c3-08dca5b6df56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 16:46:43.1670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9ZKTtFO1pXIlS5fAWq/hhd/l0sH39yuwF/MtRh6HXp8ZzviyjodysayfeX0NpGfPSOQZDr2A59xyjCDgF4A25ckCOpmimSMJtTvnRdAfrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407160124
X-Proofpoint-ORIG-GUID: 7nWAgV5JW-sGs3PUET_IVhMPWoM_bDZk
X-Proofpoint-GUID: 7nWAgV5JW-sGs3PUET_IVhMPWoM_bDZk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/07/2024 17:44, Joao Martins wrote:
> On 16/07/2024 17:04, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/12/24 13:46, Joao Martins wrote:
>>> There's generally two modes of operation for IOMMUFD:
>>>
>>> * The simple user API which intends to perform relatively simple things
>>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>>
>> It generally creates? can you explicit what is "it"
>>
> 'It' here refers to the process/API-user
> 
>> I am confused by this automatic terminology again (not your fault). the doc says:
>> "
>>
>>   *
>>
>>     Automatic domain - refers to an iommu domain created automatically
>>     when attaching a device to an IOAS object. This is compatible to the
>>     semantics of VFIO type1.
>>
>>   *
>>
>>     Manual domain - refers to an iommu domain designated by the user as
>>     the target pagetable to be attached to by a device. Though currently
>>     there are no uAPIs to directly create such domain, the datastructure
>>     and algorithms are ready for handling that use case.
>>
>> "
>>
>>
>> in 1) the device is attached to the ioas id (using the auto domain if I am not wrong)
>> Here you attach to an hwpt id. Isn't it a manual domain?
>>
> 
> Correct.
> 
> The 'auto domains' generally refers to the kernel-equivalent own automatic
> attaching to a new pagetable.
> 
> Here I call 'auto domains' in the userspace version too because we are doing the
> exact same but from userspace, using the manual API in IOMMUFD.
> 
>>> and mainly performs IOAS_MAP and UNMAP.
>>>
>>> * The native IOMMUFD API where you have fine grained control of the
>>> IOMMU domain and model it accordingly. This is where most new feature
>>> are being steered to.
>>>
>>> For dirty tracking 2) is required, as it needs to ensure that
>>> the stage-2/parent IOMMU domain will only attach devices
>>> that support dirty tracking (so far it is all homogeneous in x86, likely
>>> not the case for smmuv3). Such invariant on dirty tracking provides a
>>> useful guarantee to VMMs that will refuse incompatible device
>>> attachments for IOMMU domains.
>>>
>>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>>> responsible for creating an IOMMU domain. This is contrast to the
>>> 'simple API' where the IOMMU domain is created by IOMMUFD automatically
>>> when it attaches to VFIO (usually referred as autodomains) but it has
>>> the needed handling for mdevs.
>>>
>>> To support dirty tracking with the advanced IOMMUFD API, it needs
>>> similar logic, where IOMMU domains are created and devices attached to
>>> compatible domains. Essentially mimmicing kernel
>>> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
>>> it falls back to IOAS attach.
>>>
>>> The auto domain logic allows different IOMMU domains to be created when
>>> DMA dirty tracking is not desired (and VF can provide it), and others where
>>> it is. Here is not used in this way here given how VFIODevice migration
>>
>> Here is not used in this way here ?
>>
> 
> I meant, 'Here it is not used in this way given (...)'
> 
>>> state is initialized after the device attachment. But such mixed mode of
>>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>>> be added on. Keep the 'all of nothing' of type1 approach that we have
>>> been using so far between container vs device dirty tracking.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  include/hw/vfio/vfio-common.h |  9 ++++
>>>  include/sysemu/iommufd.h      |  5 +++
>>>  backends/iommufd.c            | 30 +++++++++++++
>>>  hw/vfio/iommufd.c             | 82 +++++++++++++++++++++++++++++++++++
>>>  backends/trace-events         |  1 +
>>>  5 files changed, 127 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 7419466bca92..2dd468ce3c02 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>>  
>>>  typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>  
>>> +typedef struct VFIOIOASHwpt {
>>> +    uint32_t hwpt_id;
>>> +    QLIST_HEAD(, VFIODevice) device_list;
>>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>>> +} VFIOIOASHwpt;
>>> +
>>>  typedef struct VFIOIOMMUFDContainer {
>>>      VFIOContainerBase bcontainer;
>>>      IOMMUFDBackend *be;
>>>      uint32_t ioas_id;
>>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>  } VFIOIOMMUFDContainer;
>>>  
>>>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>>      HostIOMMUDevice *hiod;
>>>      int devid;
>>>      IOMMUFDBackend *iommufd;
>>> +    VFIOIOASHwpt *hwpt;
>>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>>  } VFIODevice;
>>>  
>>>  struct VFIODeviceOps {
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index 57d502a1c79a..e917e7591d05 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -50,6 +50,11 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>                                       uint32_t *type, void *data, uint32_t len,
>>>                                       uint64_t *caps, Error **errp);
>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>> +                                uint32_t pt_id, uint32_t flags,
>>> +                                uint32_t data_type, uint32_t data_len,
>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>> +                                Error **errp);
>>>  
>>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>  #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 2b3d51af26d2..5d3dfa917415 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -208,6 +208,36 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>      return ret;
>>>  }
>>>  
>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>> +                                uint32_t pt_id, uint32_t flags,
>>> +                                uint32_t data_type, uint32_t data_len,
>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>> +                                Error **errp)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>>> +        .size = sizeof(struct iommu_hwpt_alloc),
>>> +        .flags = flags,
>>> +        .dev_id = dev_id,
>>> +        .pt_id = pt_id,
>>> +        .data_type = data_type,
>>> +        .data_len = data_len,
>>> +        .data_uptr = (uint64_t)data_ptr,
>>> +    };
>>> +
>>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>>> +                                     data_len, (uint64_t)data_ptr,
>>> +                                     alloc_hwpt.out_hwpt_id, ret);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>>> +        return false;
>>> +    }
>>> +
>>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>>> +    return true;
>>> +}
>>> +
>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>                                       uint32_t *type, void *data, uint32_t len,
>>>                                       uint64_t *caps, Error **errp)
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 077dea8f1b64..325c7598d5a1 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -212,10 +212,86 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>      return true;
>>>  }
>>>  
>>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>> +                                         VFIOIOMMUFDContainer *container,
>>> +                                         Error **errp)
>>> +{
>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>> +    uint32_t flags = 0;
>>> +    VFIOIOASHwpt *hwpt;
>>> +    uint32_t hwpt_id;
>>> +    int ret;
>>> +
>>> +    /* Try to find a domain */
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> +        if (ret) {
>>> +            /* -EINVAL means the domain is incompatible with the device. */
>>> +            if (ret == -EINVAL) {
>>> +                /*
>>> +                 * It is an expected failure and it just means we will try
>>> +                 * another domain, or create one if no existing compatible
>>> +                 * domain is found. Hence why the error is discarded below.
>>> +                 */
>>> +                error_free(*errp);
>>> +                *errp = NULL;
>>> +                continue;
>>> +            }
>>> +
>>> +            return false;
>>> +        } else {
>>> +            vbasedev->hwpt = hwpt;
>>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>> +                                    container->ioas_id, flags,
>>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> +                                    &hwpt_id, errp)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    hwpt = g_malloc0(sizeof(*hwpt));
>>> +    hwpt->hwpt_id = hwpt_id;
>>> +    QLIST_INIT(&hwpt->device_list);
>>> +
>>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> +    if (ret) {
>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>> +        g_free(hwpt);
>>> +        return false;
>>> +    }
>>> +
>>> +    vbasedev->hwpt = hwpt;
>>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    return true;
>>> +}
>>> +
>>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>>> +                                         VFIOIOMMUFDContainer *container)
>>> +{
>>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>>> +
>>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>> don't you want to reset vbasedev->hwpt = NULL too?
>>
> Yeap, Thanks for catching that
> 
>>
>>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>>> +        QLIST_REMOVE(hwpt, next);
>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>> +        g_free(hwpt);
>>> +    }
>>> +}
>>> +
>>>  static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>>                                            VFIOIOMMUFDContainer *container,
>>>                                            Error **errp)
>>>  {
>>> +    /* mdevs aren't physical devices and will fail with auto domains */
>>> +    if (!vbasedev->mdev) {
>>> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>>> +    }
>>> +
>>>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>>>  }
>>>  
>>> @@ -224,6 +300,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>  {
>>>      Error *err = NULL;
>>>  
>>> +    if (vbasedev->hwpt) {
>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>> +        return;
>> Where do we detach the device from the hwpt?
>>
> In iommufd_backend_free_id() for auto domains
> 

to clarify here I meant *userspace* auto domains

*kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT

>> Thanks
>>
>> Eric
>>> +    }
>>> +
>>>      if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>>>          error_report_err(err);
>>>      }
>>> @@ -354,6 +435,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>>      container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>>      container->be = vbasedev->iommufd;
>>>      container->ioas_id = ioas_id;
>>> +    QLIST_INIT(&container->hwpt_list);
>>>  
>>>      bcontainer = &container->bcontainer;
>>>      vfio_address_space_insert(space, bcontainer);
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index 211e6f374adc..4d8ac02fe7d6 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size
>>>  iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>>  iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>>
> 


