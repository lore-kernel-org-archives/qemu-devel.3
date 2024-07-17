Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D021C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6Ql-0000gu-7c; Wed, 17 Jul 2024 11:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU6Qa-0000ci-0b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:18:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU6QU-0007NI-M1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:18:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFAond006276;
 Wed, 17 Jul 2024 15:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=8pOsn9lCCeNIpUXm4rkzuMeOlHsbDqUWa1rarEiUU8o=; b=
 UtNfML3bZkpp5ZYjlmmnU/Q2CEIFPM6Pfl9mPxefvw0EcDI8gL8E3NqSe9a2DoSN
 6lNJ71IPRuw/UcvoJq7o6Cf5hNfSL3sETOADqEEzXdzy1HsA2yBYlvsxasZPyQw0
 ejJnoH7PW7WmNTffDw2OFXJJMvd014zqGyo1BdsyZOVjWUgWhoFpIpHKaU422xX/
 Usz6b6VHJs9N/tkFTfRuJ97eQ/YSYH2ElbdgstNo53+1SRl0ySOS2j1xem87LR3V
 El9Hf7j+FYyRmhf6xrzN+T4GHwKG6lEBGT5bLT3BkCFWaG8o9tVbS1ArqySyUeay
 H26fwS2nuOGZjh3T6Uy/kA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40egc2r0tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 15:18:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HEEOj5021734; Wed, 17 Jul 2024 15:18:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwetecw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 15:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpdZephaozDyhMLExCkjK2SgWrqSEMLTOJ778RaBnJgTJKnUJ5pqr/IoA2p+zZwFIWY0OserEzlq+swEKMkc6hkAHdFXZ9SIwWmSWmux1jOU9O56hDVEzFSAbl4qu78a2E1vmClgNmbMC4xTRTZV+vqC+nmKs7GpmJcU0sGY9aOmQcnCAJfiYzkJD8WAuMRjEPGyFlSWjNChL1sOoru+WBgYD/tBX3DXraqUIN28X4iN5+IIJl0pdIY6K0tUVdcPl9AYEkeLdTf1Vv1aY7gqQuPa48e5bX+HZbYZYJE2cj1z6put8LH+XOcFbdEjXnVgoc+/LqR+f+k6BOd8k3JIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pOsn9lCCeNIpUXm4rkzuMeOlHsbDqUWa1rarEiUU8o=;
 b=FHV5hhav9n434Msz9dDHSJedWRflgyTYYkIOND7/vZIGOkbwOMkXU865fI64nuFrEaosgiRSUP3FDvxF3++8xQ/EPCxaV1VOPXHCSHoevK8veT89w9P++EwTA9Ty2vb40pf4veldcwe+ETfvwVNw7v4E2pqpwCY/zlpNFyqIuFE170Y9OXcE8Zb+XApjkmLX4a5NyHF7ZlikvxbUYFLfOlfgOT52BpMXJV5GTAMGimrydDh7EWPsx9B1/qFCNkb93kWIgTs5dxsuMR+9HA+Imm0b2/PzgD1W9pFc7hui+dGHOKmVlwlIGCbyKjQBC0SiNTyelJzpIXBAY+T6JgTfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pOsn9lCCeNIpUXm4rkzuMeOlHsbDqUWa1rarEiUU8o=;
 b=zdHYuWLG1IYwx+Sy2bYzl+zZ+MyQ8f8yBcZ8AJjJIGYThl508PyYKavQ+aRk3uO1m9o0a5Xa4seyIlR8j/D1k8jeNawx54PlP24OLmwYfoWIdZ1Ufor3uGy8hTmLBwG+aky0UK3FoUX7m8MIaYm6eN2VX2H0bmOR4lU0N1lGs88=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 15:18:34 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 15:18:34 +0000
Message-ID: <afde67f0-b68a-4382-b0b6-16a20656d70b@oracle.com>
Date: Wed, 17 Jul 2024 16:18:26 +0100
Subject: Re: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-10-joao.m.martins@oracle.com>
 <bcac1f67-95de-41fb-ae34-9c479db29969@redhat.com>
 <bff9d18b-1286-414c-ad47-6898b55ae9dd@oracle.com>
 <1beb7010-a9f2-4379-9469-971b35adbe58@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <1beb7010-a9f2-4379-9469-971b35adbe58@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: f294de05-c411-417b-d0a6-08dca673b992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmNYWTl6eHFtOVNmb1dQMW01ckJNaVEvNms3MkN5K3JuQW5GN2plemMyemxQ?=
 =?utf-8?B?UjBPYnRyUVVDSlBEMFdQN3hlb3hLRFRkTkxacnlzRDB4ZUNJYk9SRGUrdEVs?=
 =?utf-8?B?bjl4NWltUTJtNU1DWlNDbVBjTHJHWUxsR2k0WmZtTlgvUWU1b2Y0MHNpMmZ6?=
 =?utf-8?B?bUxWSUxFMldlT3FEaXBQSkpnNHI3Z3oyZStKTFl5VjRLQjdlcXEybjBCY1hn?=
 =?utf-8?B?L3k3aDBJcVZ0VXdHNVV0OGJCY3ZqWFJwUjNrWFpheERkb3cwOWh0ZmlTVXRw?=
 =?utf-8?B?WEFLWEphVEVDV1VybU9RRHdLeFl4ZEg1KzlSYndXS0xucmVBUytyWVRKR1JB?=
 =?utf-8?B?MVVGQkwxSWRkR2x1QTJ1WVI4SVltRHVXWUNscW9uSnRLdUJaTkxlYnlvZ3V5?=
 =?utf-8?B?aDhxd092cGdkZnk2ODhzOENrZS9kYmRHSkZLVi9oNDBRZ01Wb1M5TUR5T0l5?=
 =?utf-8?B?Y2pzZkU2UGFwYkE0OVhmU0wvbTN0TkZDQW9yTnJIUjZCbWNKKzhmbTltbS9z?=
 =?utf-8?B?U2xYeXF1ZVQ1WlJsZFQxcXJnK3E5N2NTcTU2RkowcTAvcFI2cDBtSUpOa1Br?=
 =?utf-8?B?VXZqSk9TYXc1K0x4N1J0WlFWd2N1czVGeElJaEltNmZhVjVKMHNmaitTZ0xk?=
 =?utf-8?B?OE5FY2pNTkIyTjNZNjJ0c2ozZVZyR1JFU1RuUUlBMUp5cmw1MkwxbVp2ZmJh?=
 =?utf-8?B?VTlNNmJ5L0swSFU1MGhqSU94RHQ5dVJDZzA3NnRiTm04TTB0K3FKbWhGaUo5?=
 =?utf-8?B?a3YwVlhPSzh0MnhiRm1IMTIwTlhHUyt4MVRWaERaNlRuUTh4VUp3UndSYVd4?=
 =?utf-8?B?ZytMaWJKSkptdXZYMFpoWHlrM292Mk5iY01aTGtFSkh1OXlLTVFLaTVYYTJo?=
 =?utf-8?B?akhwVk9QSkMyS2x5RTlPTXcwNUxCTVVJT2x0ZldoMkFwbFFON3hLZWRNazVS?=
 =?utf-8?B?QnNGUVVtVVJjVlA0TDlvcEVnQzYvUEpRb3V0S1JFNStNTjRwZHNEaUtaR25M?=
 =?utf-8?B?WGxqSDJ3R1FtUW85ZGVtdDBTQVpSOHdBdEEwanlMTUNQTHhpZU4vVE96TS9l?=
 =?utf-8?B?TlM3NURMZ056ZjlKVHlOdVZPZHkrck1EcE8ra1ZmdzhJOUdjeXpOZDJNT1lT?=
 =?utf-8?B?ZHNoL0RHYndWRDNCRE5pNVlSTzU4V3UrVWtDS0lwUExFeEQ5bndKOXhZT2E2?=
 =?utf-8?B?ajdGOThKTldJNE5NS3hML0NLYmlwV0tzb0lOQkRxaW9lR2tOTE91cEtTV1V1?=
 =?utf-8?B?S2tnL2NpN2NTTWFhUFRnRm43UDk5MGFSL01UcWxkaklrcTJSbVlHUnhSUlpW?=
 =?utf-8?B?bHBHem8wK25nQXl0Y3hVdjlVRWJzUktHaVJTRGFVbk5FOFVRSFpJSDE3K0Ey?=
 =?utf-8?B?N0JiRWhFREhHa2Q1UWFLcFA4cWFoeEkyNzVCTzJhaks4d0Q1YUZXTERBdWZW?=
 =?utf-8?B?U29VS2o5L3B5ZG5wQVczS2FOQlVBN2lkQ0FsZ05WbG9POW5VckRoTHRZRUk2?=
 =?utf-8?B?WFVOV1BNTkFZRExIbHZ5U2VSTlRCbGttWG51UUI4Uk5oNkVzUnA3WTdjdEZG?=
 =?utf-8?B?WUJSMnFYa2VwZ2E5WUlESTJkV3ZyVmMxU3Zxc1d3Nmc0U1VUUXJhem1wQmh4?=
 =?utf-8?B?eG05SWdDWTNsT29idDkrQmxrckNNSUpVN214WkkydTA0Z013NXBwdGNUeDdh?=
 =?utf-8?B?VDlCMHBkQ0EveUJhNmJsNkd5cGVaOVRhZFBYczh3SHZrYUR6ZFBUZk1XZ09H?=
 =?utf-8?B?RVlvMVVjd0ZyTmdMckhOTVJLcyt2KzRRQ3RVSFNQNUxXeExVQlJiZXduam0w?=
 =?utf-8?B?bmpUUDBqTFF6bDh3QUdqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUh6Qk1HUzk0OVJxZ1Q0UGxmVThqZXByODlXMzh3UnJqT3dGa1Urd0xrT05z?=
 =?utf-8?B?R0U1L3dxeFJXMVAyRW5PQkplVzVSYkVQYVVIOXZMYitWWTltd0dFZy9RdWRv?=
 =?utf-8?B?Q092T1VxYVR5MnlMTGc2K2lmM3lyMW5mMjZreUZ5dU1tbXJJUCtSZHBPUTV3?=
 =?utf-8?B?THFmZXR3bHROM1lBWmgvbEZnMnhrOW1wL1FnMjJWNDcybDJqMmlHMVI3NndB?=
 =?utf-8?B?cTZhUWtGQTliVXIyNEJZUVFUWkI4bjZ5KytUbG56dGR1OStwZGZWbGxkYkpH?=
 =?utf-8?B?SWFzc0tkakl4a2gxdy9rRFdXbWFqcnpJUGszZVZoVVBNUVE1eDA2M3dKc21Z?=
 =?utf-8?B?c2ZCZWRCaUZNNUJzM2VYUGFibEdEZXE5REJzVlNZb2lrVUc5dEhabWE4SVV0?=
 =?utf-8?B?Zi81bjNKdURqUnhLcCs2Z3NibFQxdTdkbGVvaElCSmlGa2pkcmJTNVRRaDVO?=
 =?utf-8?B?MWMyUml4UnFTdTJ6eTRtM0NPNVA0ZUV1eGY0aHc1RzZGZUVaMkE0VFdLZzRK?=
 =?utf-8?B?eHIycHg5SVg2SWZvS3YxWnRINlRxRXRKM0pSdkhsK2xTcFVoNnkxaTZVbjRC?=
 =?utf-8?B?TFE1Sm1hRWcxMVl5b3ZlaHpPWmNJSFg2UXNLVmVPVHlkc3k2RGY0cTNmSktV?=
 =?utf-8?B?MlFMaE9Ca2xUUXM3NDZXckNSaW8vRm91ZHllRDc2TVQxWjlUUTNCZ01IVVVa?=
 =?utf-8?B?YVE2YjJVQ0Z2bGF4VlhnV3krSGIyZ0VranRkaTdKdTJYK2NoaWRSZDhLQmti?=
 =?utf-8?B?dWJNQ3JyY3A5Nlk4MldtbkZ1Zlh2SS9oS2FSTlJCcnBJT0JpcGZ5bVJkcEpy?=
 =?utf-8?B?RStNRDBtNTFkUGtFM3d3VGJBYWlaSVFtOTd3cUQzeHdBSmlKK21YSnVOWXMr?=
 =?utf-8?B?NzZZOWhlZkppYytlZEpKT1I2L1RSV29rcnNhTUxRR2dRQkwyK3RvcGFiL3Jq?=
 =?utf-8?B?Z0JRQTBLbXVMdnMrMElXWER3eEZ2S01TOTlqcDVLaC8xUE5RMFJDQ3IwS1ZM?=
 =?utf-8?B?S01FaFhqbnU2em9TSFJNZTV3akNGTHpFSXd5TUpXQ2RsVVhmKzh4eTdjNFlU?=
 =?utf-8?B?U2xBZW5iY0NDTHNuY0diZDlwTlI1VXE2aXZ5cEE2cVgwYUVLMTJtdGpDZDZZ?=
 =?utf-8?B?MHRnNW5Xd2piVnkydmZsa1p1cVVrdTNoUEExMHRrd1NWMERNMXhWMG94dmF0?=
 =?utf-8?B?bUR5bnZqUWROK283ZndIZGJoWUMyQzZ4OHpGUGRrR3Z6clRJRzM4cmFtWFdi?=
 =?utf-8?B?WGpaYW1mdG9VRlI0QXVvVkpSSENZRlZ6S0xQT1hxU0o5dldoWUFodG1vZlFB?=
 =?utf-8?B?SkdzS01nRzRRVTVibjdKS1owM1EyTENEY3QwTWJScCtDaXVpZzVGSnU5Y0lz?=
 =?utf-8?B?UlRwUGF2d1QzZlZuZ2d5NWhSSkN6TjVRbURac1VoazNOeUd4WHA0TjlwMExL?=
 =?utf-8?B?U0ptM1pTaWZ1eWFRSHc0eldmZlZURDhlci9MTjRTUWxCL3l6VGFUOEgxRmJQ?=
 =?utf-8?B?c3VEeXRuaEJ4azZwMzJDNFFnZTdWMlJ1R1JxTzhkZDJ0Vy8xK3RJZUxyK1Ft?=
 =?utf-8?B?eHUxZzgrQnRITzZtb0J1V3pWRlgwZlN1RlNTd3llSVcyelFVNVpjVjhIK3ZE?=
 =?utf-8?B?NHhndURNazVIb2g1bnNpdlJuNkdsV05Ec0M0YzE3VHFlck9lWWMxZkZteEdY?=
 =?utf-8?B?czVENE94MVM2MDdnTUhScGRSWHdBM2luek1EVlJORzZSOFVrU25HLzN4RmpJ?=
 =?utf-8?B?S3FsWUtQdWVqMlRqRXZLOU1vajhaenVRM3BHWCtnNEY2dU5sOG9tVFFOUFlL?=
 =?utf-8?B?ZFhuckk2aXFJWlhaUFlSMzhGaktFN2lFcXk4ZzZXTlhXQ2w1aWJzN3hpbzdh?=
 =?utf-8?B?UWN4MEhldWUwQ2laeWU1ZmgzUzJtR3VTNTJYQkpiazVBbnNwRnh3SC9jOTln?=
 =?utf-8?B?cU5LNVBQMzc4dVM5Qkp5L3NOaWowL3F5MmdVUHl4UXpYaVFGRWhUNXkzVXBS?=
 =?utf-8?B?NEppbnZ3eXArWStIVVErWk1jRW1vMUIvcFFPMyttbVltYm1kQkY4NE1QTE1V?=
 =?utf-8?B?TkowQU1hYUcydjhqMTRJVDd3cU1pTUlReEdtd09IWmthWldpZ1NxVFhVTHF6?=
 =?utf-8?B?YmcybWZMVVJTdmJWa3NhUFF3RFVlRnJ5MEd5TXQydmJ6TWhGb3IrNXYrZm0w?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CJXNG+qdLMgHmNx45lnDi8Xlm5o9dsuFkOHpknKsDheqdGJC87FjePydziWweaH20gXbu9tEjyl904DrbRLv4M5RQk+PGVr/O39eOwjpeIHk381uttitmqvoQFEVdY6FU0sba9MzN6tGHQdYBteclwnyMPpJMbqMiXoJ3HF6v7iSk+qLc6HaLSnQaVEwyzIHofj1CTP4XRdAtrnUMF0JaO52KT/9YuvZct4tU1fozUQ2qgQz221JpL1yz07o1cHXOCRLapIorkwLB2b0cVY6NSwLle/U6Dbrk8+gJbOGU/j8zQTCRT8e3g7I8FtE4mrcqdXx3NZj6nd+ZIDu/eEVCkmA4X60/0jKCTaV32VqiCOOVgwz8cZVdSyY4BZRVd1tldsHiMOf6eW9icVn3Ark5gus7Uhj57A8snbo2DiNDZyiHpw8sHxUwQQn2dio4BPP4a+GUd9vGNhR6NtJgthofpCuokamXY864JW4qss72C62qFYDJnoa9iJvJJ24+r0+Qv13kke7/eUkyCA4NnN1rR1f0D5Hluo7PGv7Iy5Ohe+IMBzx137E4sQvElggR9cgF3IioNiykAGgD6T+0NS8B0NO0/bl90fVGn4zLg+Y2s8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f294de05-c411-417b-d0a6-08dca673b992
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:18:34.7562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxhchYQL8YSuHjy/PCLpNVSd+FpsheNH+YM+S4Y8LzbUBbl/pIHxikIa10MB1h2eLtgibg5QijB996mmOVhSSv8xnyRrXQPQGhjIbT5HPog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=601 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170118
X-Proofpoint-ORIG-GUID: WlMN25MTFsGBXCNoymSSUSKTTXQkcO6C
X-Proofpoint-GUID: WlMN25MTFsGBXCNoymSSUSKTTXQkcO6C
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/07/2024 14:34, Eric Auger wrote:
> On 7/17/24 14:41, Joao Martins wrote:
>> On 17/07/2024 13:36, Eric Auger wrote:
>>> On 7/12/24 13:47, Joao Martins wrote:
>>>> The checking of hwpt::flags is introduced here as a second user
>>> ?? -> introduce iommufd_hwpt_dirty_tracking() helper to avoid code dup?
>> Right I am doing that already. Not sure what the problem is with this sentence?
> 
> "The checking of hwpt::flags is introduced here as a second user" phrasing sounds weird to me.
> I guess you just meant that you need to check 
> hwpt::flags in another place so better off introducing an helper.
> 

Exactly.

