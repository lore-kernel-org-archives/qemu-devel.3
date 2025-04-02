Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8728C36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyVr-0008Qi-CU; Wed, 02 Apr 2025 09:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyVb-0008Oz-IN
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:52:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyVZ-0004UA-0d
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:51:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN6bS030392;
 Wed, 2 Apr 2025 13:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=evXkrtg03iF1WuZAkHPCq9MlfpC9D+YY0G84YWPUzU4=; b=
 fPyGg7IOxtu4pgxz1uLljbHf8snTFSrmuConxiXegihOLDFiO5SxiUlCW31aHffv
 /+sTTBsIlXYRnD5AodMScfdPyHHQY9wri9w6dgOuHlqbCz/sYWPVbOuPaEY2H7YO
 gf3DCkdj49wHn1zu7dohHWK6JhpBQ3kvBaiXVqj+skkMm2b9ayMhYPn8C0TYFHPt
 +fiw3Ho2suUE7U8uGxO3gDs5tf7rzH9z33QDJ0PBseB8lIWWpo27l40dKYjsks9i
 DDa3dIVF5f+4zSNg/iQQZHRJV90eGQj67KlYaGjaFsBuM8aFnzOrHb1nYnVaLiQ1
 oJ+65WshAOWWSZuSXnai8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0jdj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:51:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532DpcT2003354; Wed, 2 Apr 2025 13:51:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7aamqb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE4cuOTbd9sJNUyjsBg/QfXQ2ypedrMHIYcE+bfkMVKqUxLxIWMKltlqPtXITd1nOVnrHf/N3DuzWg2nKyd6ITC+TPXD4KXwqbiEM3RFujnWU2yUqxFmqsPcbRZh85ZOobcTzeG2+O7bN1ZiECnBdHc9ucFpXHnxtTXDwn8WfbhaslTEYNZNxWaXWuTJnPzXjpl6lfbTesOSVYa8Dz5alT3pBQdV7mndnT6pIy3jeT8twbsCO8YvzJHph7dgQVjMoxMEXU1LakaPDTnDwQtv7m53TqbhN4fBkbX9gb95/+lqz8rdoEmKsVVLTCkw8Ygk5SeqcYdMPgbm+2SThziCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evXkrtg03iF1WuZAkHPCq9MlfpC9D+YY0G84YWPUzU4=;
 b=silI3Xvla2cyZugoSCXp+nK3CVOIkduJcTFyi9tPXXjWHO3S8720u1cpdYw7GhqPHH2pciZruVad4F4qnZdxr9WwFjDD0nzIgFfWXlE4UtRdbHjDPtyWmHIo9tL7y/ChJmXjTJ2s0SkdB6R2PLtG1hpldvSYWY+49NDvCcIhL2jfLhLMBaURkzn+EOB4DnE4PRQqRxV3gZb0ylq1gaud6WVFFT42n0xBXP2iEqPFbgV1SHE5zO+ujJOtaGTFMTG2h7vYJRHT4ShKgm2cg+XBygSIp7Cp26RtIervMg0w6Lnuu78FrDuByav3J7uOV09EOYmPJoDt0hyyELWpg0+tQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evXkrtg03iF1WuZAkHPCq9MlfpC9D+YY0G84YWPUzU4=;
 b=vLgrChaYFNHaAzD6B0IMFHZB+Fi6631twv7NTwjz6IluPBF1vxZhs6V0p2DgBxghAI9iVoozwXJMj6oy+CKbGNIyu95qLynGIzFypUzd+Ha1iHuhGkWpVCaRIseLQ/fuS5/IeX8Cc5Cep8tF7uqbZaJX9+lzmfDyuVKvEr+X4qc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 13:51:51 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:51:51 +0000
Message-ID: <d31416fe-117c-4e9a-a9da-bf7ad53370b6@oracle.com>
Date: Wed, 2 Apr 2025 14:51:45 +0100
Subject: Re: [PATCH for-10.1 v2 10/37] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Yi Liu <yi.l.liu@intel.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-11-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-11-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6dc243-5256-4059-a885-08dd71ed850d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTdpeHlRRjNWd2JrMWxzTzh4SFZtVDNReTVoS0RpNzkwUEtaemhLcGxCRGdL?=
 =?utf-8?B?SXVGalprY2dTdnk2eXVIcVI5bmphOS90RGsyQ0dmZGNFQWJQamVuSmR0WlY5?=
 =?utf-8?B?TlFKeGVEUkpWd3ZtNE5sMi92N2xjbXpoN2UzOGFiK3ZLOStrOWZTZlUwZzNx?=
 =?utf-8?B?MjNWTFJFS05jV3Z1enljM3VjMTAvekdLUUR5T3Nvc0JtSGl1Uzd2bDM1Mk44?=
 =?utf-8?B?VXlhZUU0aEl2anNWT3hiNHlDdURzVnlNbW5ucFNpYzZ3czg3blNiNHRXVVYr?=
 =?utf-8?B?aTBLNHZqVXg3a3lMNUFIQWVpQ3llZlZibmtLUVUyTnNMeERLai9QVHlxY3Ay?=
 =?utf-8?B?Y0JtazdIOVJwczhsbzJ1ZUUwOXlXZHloT2dXQWdXWVFEeHFLeGxGc1Brdkdk?=
 =?utf-8?B?ZnNDVDY5TlZndWpzcjMxcVZiZnZoeC9sclpVeW5PajVuOExGL2VTSTJCUWxw?=
 =?utf-8?B?MGJyQnArNGxoS1R0UnRoOW9aK3ZpOEpXbWZ2UFoyU1JmSDJJTUErbTdocXVv?=
 =?utf-8?B?Mk0vbnJQQnJtK1RieXdjS1FVSDRKc04xZjBwWjJ3WGRFWm44R0h5Q2w0TW9w?=
 =?utf-8?B?d3lLTW0zNkFnT0swSWg2dWJxR0RRK1MvdU1IajN1RXhpOFFWRjZnSzl5SFcw?=
 =?utf-8?B?cUYwQVVHc1JxOW16QVRRNzBHc2dxTDhCamU5WEVQTDJYK1VuRGdwWEVWUUJs?=
 =?utf-8?B?Szl1TldtWmxHblk5ditBTjFNTmdpOW1WOHdXSWtqN2VsUS9PNUkzcVpKdDAz?=
 =?utf-8?B?R0dwVUxSeE9MUlVJOG54L1I1ZWhxZFJlZjlubkxOOXlaeVBjMTdTeFdOc0lN?=
 =?utf-8?B?TmFlWURTM05YZzQxOW9jVnVNNGxzT1lzcmR6V21QMkpoSjdhNndlWXlobFFo?=
 =?utf-8?B?bUJqcnV6SWN2YmpoMjI3L3YrTjQrSWd1NU5NV2pDQ2NsdzM2UUlBY1hGdEdp?=
 =?utf-8?B?RWdSOFFYb0hnUlNMcE5VK1NvRjMyUk1yMkQwb0VtQ0dQSkJMaGwvVElFVGRk?=
 =?utf-8?B?UmlGVFVGU1dTUGgxamc4VFJwQnFvWG80RDZnMTZXUUdVZlNnR3hwS2lXSUtV?=
 =?utf-8?B?a3RiUWtSQmQrRkRNRDAvSS9aREl6TExLNnpaR3M3alVGZ1J0MDRhdEVJOGFz?=
 =?utf-8?B?NG1IaG8yTUxQakxpaUl5dnJJQUZGUVd1d2o0QzQrdmVPZDFTRUhFUVJ6UE5Y?=
 =?utf-8?B?bjhnZnpWSHNBTFoyK1NsYVNkRlVqL2lzd3ZBSXBIL3ROQTVkd1RZcEJVUkdI?=
 =?utf-8?B?YmhJWDVKMGtaMXkxUmxxaEs1TWtma2JKZy9PTTUvM1EwRjMrVWlrankzUTl1?=
 =?utf-8?B?NVNWMXVnZmJUbDlod2FsSmltTXVVMXJvd3ZxZ2ppTVBveldyRi9hSzBSTXVu?=
 =?utf-8?B?cCtlU3lSWGQwZ3c2bWJpSHVjVFFoUTZNU29Fc2FvYm9TMUN6ZnlnT25ncm40?=
 =?utf-8?B?YVN0N0lNTllWbGVTVzNKQjlUSnhCM3Nlc1Nqc2hQNENvTUY4djZ6WVVRcXo0?=
 =?utf-8?B?M0QyeXpRd2N6cEFzcDF2am83c1c0WGtRa3Z4bkh5NUNHMnJSV2ltancxeEUy?=
 =?utf-8?B?YkxaV3NMdzFSZ0diSkhIY003aHErM0hjVm9ac0VFU3A4eGVZdlRIeVV0bmdj?=
 =?utf-8?B?NU1yaWQrcVYvelFqemI2YlN6VXEvOTRjck9YaGhDYjIyREM1TkxNSEljR3Bl?=
 =?utf-8?B?NEVXQXFNc0V1MzRCdi9JRENla0J4a0E0akhPcnljaFRHTndJR2hBaFZUMHl2?=
 =?utf-8?B?VC9JZUZERWNJeDFLTWw5cDA1TXNvbmlkK2pFcGNjQXI3elZPNERPbTZBSENs?=
 =?utf-8?B?dml2eUxVcnJhL0U0VXkrbS9mR2N1WFowdGRhcU53Rzl0MzBsZ2pGRDlFVUxH?=
 =?utf-8?Q?lHgOUlOKzrJJP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXl1amsyODUyNlhtNkRoT0pjaFc3aGdLYVUwLyswR2ljSmFOb01HcU9neUJQ?=
 =?utf-8?B?aVUvbXF1c0hvMmZEMDBFeFRPdEtOZlJkbkJSeTN0QlN2SDV5blRqSVJxYmc4?=
 =?utf-8?B?c3owSGY5MVVLbVcvb1h2MVJCTjBuNTVEUzhUdld3QTJXajBYV3R1Mk5Ka21o?=
 =?utf-8?B?bEZIVWViM0NZK2t4WUVQandaeDdSMytSZ2Y4aDRiZG53aFZTREFndUlSOCth?=
 =?utf-8?B?NVgzV2QwbEc1bnVyanpodTBnNTFsOTkzN3pUUzBrTHRmbDZlZXZBa1JBV1R6?=
 =?utf-8?B?Y055VC91K0YyeTNLcWs0Zk01dTJRMkJUL3BXQWN2TUZRbjFwRE1uRVlwcGN3?=
 =?utf-8?B?aVcvTWZiSzQzbE8zTWdScnRpTHBRZzZRazFyRkJJT2JSQW5BQWIvV0czZHVo?=
 =?utf-8?B?bSs1dHNJUmRaUXdLL3htNUloZG5qRHMrUWt2OTFsaG90c294S29JZjNucUVX?=
 =?utf-8?B?M0xwVDAxcXM4MXRRRUsvL1JIQklSaXZNK1Zsdkx6dk5TdFJZdDJNVTJaOWhI?=
 =?utf-8?B?VjRuZytEVlFDNC8wZTloUnY0VXk4MXY5OUN3bEJKY1k0eEdFMDRac0orNzdL?=
 =?utf-8?B?NDh0RlpVOHU2VFYxejdiekFkdVRUbmlENnFadFNyaG9Bczk2ZkpneWFCVUVR?=
 =?utf-8?B?TGRlL1M0SmRVc1BHQUU3SUM3dGd6S2JNdFREeU1WQ1Z4dnQxNFhKU25HSE9p?=
 =?utf-8?B?Tm5hVWhxRzdUazc1Q2h0UXJOQjlGMzFVOFEzTlVXR3JaTVZuc0UwVFFoUmNo?=
 =?utf-8?B?Zzc0QVFtYVJhTzNhZ2pjT3R0dGlMMDJPSkg4STdEcTNWWjJrRWc1aFhSSEhC?=
 =?utf-8?B?UWdtdi9rK0JlRWlieXdMODJaL2plNzk3U1ZKcDcwZDVjQzdrcElsakZMdHN1?=
 =?utf-8?B?SGM3Wml0ZDJFQWgvdEVtdGk5MkNjV0xSbVhmYkMvd1YwQmVqSnExVjhyc2JM?=
 =?utf-8?B?LytjUzdSeVNocmh4OWZodTRxVlVzc0k3WmRndVNJMkp0eExSZVpXNStueXJm?=
 =?utf-8?B?MDI2Zm90WWJkYk54UGcwZUNSclBmYVlFc3Y4dTRDdk1QMnp3TUFhbmFVSkcr?=
 =?utf-8?B?STVyb0ZTODM1SmlTMFFJdU1HM25GUyt1VEwwVlUxbmU5VXEvNHk2Rm9ZeFhU?=
 =?utf-8?B?NmtHb1ZldzIvUHpmZjNCQTUyelZvM0o5RWF5OE1qWGxGR3lzQ28xbjZIOWtZ?=
 =?utf-8?B?SVQyRmh5TDh1cTZvR1FPdE9ZWVUyclc3MVlZWGJRQnZRNUwzZVltSzFpL2s0?=
 =?utf-8?B?TG9DWEhWOUV4ck1lclFIR3dEelpnUFZhNzF4Nkp3UUxxdkNVTmVrSmF3UmR4?=
 =?utf-8?B?b05DRHhTQ0JQMGFrYkdUck9NYkJac0V6VlJzK0hPTE54UVUyK09tYURmWGxt?=
 =?utf-8?B?TDdKYjdRTjdZRHlxbjhFRzcyQzA3czZCN282MCtLOHhqL0N0V2RnZlR6M0dH?=
 =?utf-8?B?VS9DM0FDZFRwOE52RGhQbmZWdnBQNXBWR2ZNTEpWa0k5djA4eVFOaDFWWXlv?=
 =?utf-8?B?a0IvaExNZzZDRFlhYlFJd3FyVVBQdmZKZmJwSWZWeGVMMnZNUlQvU05GNnNN?=
 =?utf-8?B?RXUwRnZ4ZFYvM0VKTTE4MUVxeHB1NE90TldwdndWVndQc2pPR2h4Z3JGM0Z3?=
 =?utf-8?B?d3VQbVNmVTJaa2JNdU9Pc1M0RXNrbHpJcEtnR2lub2gyb0g3VFduamJOcDAr?=
 =?utf-8?B?ZC9lY09EckpMZnUwU3dUK3RzaXNzbDJRNzJjc2c5b1cvcm96QnNHaURkWTI4?=
 =?utf-8?B?dTAwOEdQY2dWVGcvemRtV2RpdUVSWHFBMHlsWnloZEJxVU5CZnFDTkFEMGpT?=
 =?utf-8?B?R0VDeGVMUUloVlZoRlFudXFyN3pPR0tOWjJDVTFsWnB2Qml2d1VWenVRb2Z3?=
 =?utf-8?B?T1FrWDc4MVZsNWx1eDhNRDNQTG45bW1PS3hnMDUxRm5mN1MwNEdveXcrWEFi?=
 =?utf-8?B?bGhhWjhwdlJKUGFFSHFybTB3aVlaaldlN2RMMTV5aEdUeGQrUUtDekFJeTdX?=
 =?utf-8?B?V1M5blBwV0YvaVVvYkU4Z01tb2I5dE5lUTFJd25OUjNsakJiQWlUYkM4SDhs?=
 =?utf-8?B?OU5uYU4yZGpFOURZWHliQjhqcXJobHkxKzFOcDA1YWlkUGdQb2pyWG4zUkVZ?=
 =?utf-8?B?MW1yTncrVFY4UnlMc0lnNlNBSjJBL2xMbU5SbXl4NjRKQmUrZlJXMHFQRDVy?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dvst72z2kCg1F5l0dkbrSLvQffceJM43wrSOwuLxd7NRsQwfOBFYnRdliG0cixC9vHfgDqIeD46o5dCrz4TR9tpmTMX+2VVzTLPuY8y0c1jAVhqHTkXqZvoP0iPwEmrE5nNxCkNYcU3ZBItyDZ3J8eGDpl5cKxzRhPgNqOXFOyIOHq2kL8NQT98+Qv9GIAVRd1DGMbi96aaadO3T/ZCXxupe+tWNklYKAX5SWT34d6s1p/ckIhXXk6F1Di8kMjLuUiDcVylRPpNRUVjONMrQYFdULOqr4e9P1evroROgQneXMlXA39hbNU+HUKN7uilq9PN1MIOphqiHLEU27RMIUShHRdYLhGl5nwpx8kU873iUGVlkSGT9wqX2TUcDUoMvafzdqFf30H5MuAqZTCI2DHbYM6683vLavVZ0DcZ0JkTzxD+BQYpHaUaeS+QNruif6M1Dglc8a6Js+ZzMUommv1boii4YavsejRZBki2axwkgKE07GHlt+APl+vlOrdjBEg4eP6ossju9NW7CQztd/bbKq52NobeQLwStJCXCEjlNKJ2fbMm7Cg5DLLO9SjRa+kvIFt42vGX7E1ghBtFWIWltj0lfceoxZIMAYA59JDc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6dc243-5256-4059-a885-08dd71ed850d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:51:51.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuuHKB/G45ohhUTlYkruIHS6dh3xCd1DCjUO4K9+OnE/2GatVjy7wbG/zGUrwtlimVnevPkDbGmcCe+2243Na8zJRErL1s9nKNvKlujRF4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020087
X-Proofpoint-ORIG-GUID: 3pRVieMPwU3LfxUEUBhVCu_UFbzrzQmR
X-Proofpoint-GUID: 3pRVieMPwU3LfxUEUBhVCu_UFbzrzQmR
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 26/03/2025 07:50, Cédric Le Goater wrote:
> Gather all VFIOIOMMUFD related declarations introduced by commits
> 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend") and
> 5b1e96e65403 ("vfio/iommufd: Introduce auto domain creation") into
> "vfio-iommufd.h". This to reduce exposure of VFIO internals in
> "hw/vfio/vfio-common.h".
> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: John Levon <john.levon@nutanix.com>
> Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-10-clg@redhat.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/vfio-iommufd.h        | 34 ++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h | 21 +++------------------
>  hw/vfio/iommufd.c             |  1 +
>  3 files changed, 38 insertions(+), 18 deletions(-)
>  create mode 100644 hw/vfio/vfio-iommufd.h
> 
> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..07ea0f43049645a5f3782048117fd9bf22083053
> --- /dev/null
> +++ b/hw/vfio/vfio-iommufd.h
> @@ -0,0 +1,34 @@
> +/*
> + * VFIO iommufd
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_IOMMUFD_H
> +#define HW_VFIO_VFIO_IOMMUFD_H
> +
> +#include "hw/vfio/vfio-container-base.h"
> +
> +typedef struct VFIODevice VFIODevice;
> +
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    uint32_t hwpt_flags;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
> +typedef struct IOMMUFDBackend IOMMUFDBackend;
> +
> +typedef struct VFIOIOMMUFDContainer {
> +    VFIOContainerBase bcontainer;
> +    IOMMUFDBackend *be;
> +    uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> +} VFIOIOMMUFDContainer;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> +
> +#endif /* HW_VFIO_VFIO_IOMMUFD_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3355c2d4e57569d7bb01b4d9378fb49a807335e8..8d48f5300a791d8858fe29d1bb905f814ef11990 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -69,27 +69,12 @@ typedef struct VFIOContainer {
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>  
> -typedef struct IOMMUFDBackend IOMMUFDBackend;
> -
> -typedef struct VFIOIOASHwpt {
> -    uint32_t hwpt_id;
> -    uint32_t hwpt_flags;
> -    QLIST_HEAD(, VFIODevice) device_list;
> -    QLIST_ENTRY(VFIOIOASHwpt) next;
> -} VFIOIOASHwpt;
> -
> -typedef struct VFIOIOMMUFDContainer {
> -    VFIOContainerBase bcontainer;
> -    IOMMUFDBackend *be;
> -    uint32_t ioas_id;
> -    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> -} VFIOIOMMUFDContainer;
> -
> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> -
>  typedef struct VFIODeviceOps VFIODeviceOps;
>  typedef struct VFIOMigration VFIOMigration;
>  
> +typedef struct IOMMUFDBackend IOMMUFDBackend;
> +typedef struct VFIOIOASHwpt VFIOIOASHwpt;
> +
>  typedef struct VFIODevice {
>      QLIST_ENTRY(VFIODevice) next;
>      QLIST_ENTRY(VFIODevice) container_next;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 42c8412bbf50724dddb43f9b19a3aa40c8bc311d..7196c4080125674ec58b1ebf02dad84b4387c355 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
> +#include "vfio-iommufd.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)


