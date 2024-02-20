Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E78C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNaM-00063Y-Jz; Tue, 20 Feb 2024 05:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNaK-00063H-Ir
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:42:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNaH-0002Ey-VR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:42:48 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8x8t3031252; Tue, 20 Feb 2024 10:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=s7Z2BBjLanIicTeEr5+YXZmCH70teh1rODX2MtBLlco=;
 b=CeESomaOFXH6wg8KxPd/u0EL9sJo12QIx5S5rRX8jce5/lXzO69XTrYdaNcZau6JZirB
 NWVZb49VeOYOIjL6e+iI+k64W8XPhRD5ZRTz2NFTVP/KoJt7KojAVrACMYi+FOwKEBQU
 DNFJCzJ69CXaGo0ffL4wuoauq+6RlWUe8hYWDJ8ojlnuOpYXd5SoVbrZ4ZI6WU2nUlza
 y9QPF76KFflGWy0p6O2M6GPFajlDwjx9G92wvVdkzxXqbUFXmujJ0j/WRVMd5kCrdcwW
 PMZCEu6es3fZ0tP2uN0laZPrRybNp82HfzGhjZf0aiIRNVLLYdXSFmucaQ4Ai1GmCaWU gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucxcnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 10:42:38 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KA18VI038490; Tue, 20 Feb 2024 10:42:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak871ym5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 10:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAP+M6dveHq+lnbVTjTG3Mze2FqFXG46yVSLTaPefUeG1oh9E2b2c1qTfuXp47jjA4LU626I6KVRBK0X5eMmjmTbbswFrrY/GgcaybTo2itrM59TtcEIOv+V7DEqtZvIQmaP2O0sP1MGY7twM6AeqALdzs5QBUk6r/myAbthFx4TQWGUQNLGvBcFV3wtYZCVqNS1OQvi9ZSDCM86tr8upATt1MeH/O2Exofwct5y2PuTErxbhTX13Dzhg8AYimar7aUdAWi2NJ+K+ZE8EEiwEdUfr1hUQXh7DHBlH0kC633RwApOfAnfhrnNg0BZfNvTGkY8myCSnccRS5q+smM3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Z2BBjLanIicTeEr5+YXZmCH70teh1rODX2MtBLlco=;
 b=QKSM0Sf3DSjgUyibLzJnq9cRPoCvLZLyrPyIHUfa8f7yWVQKlI3w0xJRehiSKIWiLSvL3nCUBqcnDgeYgVLU0phFaCZK7utMjauFvmMsfuYdINbEl63vLcjnBFZEZHByVX9F3WwMVPwYMTDb1ndFn8O5eZCsVqAF91Tm+KI2fMkPKgSdX08g3fAe1wYAgCsMv7aq8PSg1BsRcobSvGq4bcw67+W1yv2nNv4PmGa8VC5dQAcMtaJx4XvveOHlcqly8T0Lq3wAo/Dh2DeMvKXImKaMfXjdMfYe8XM7dRQxCgFGdIpKfmTHwmfGGnm2JU2GwqR9GAg0www5J+9HYpbtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Z2BBjLanIicTeEr5+YXZmCH70teh1rODX2MtBLlco=;
 b=iEpjP6ODMIDbYI9uOIXNA26ZfoYBXqSOvQGhF/PdVAgDpUL9L6VpYNG2Z4iMkGb2KMQ8grBj+Kpz8gt2Z/16E26HxzYI1WgRoW34nMoemJYzwjz1mqwFkfC01RspTcPlkQZ+zHaS+2fcduwoFBGAGatKxp1zNC7qy0SW/8tfgbI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:42:35 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:42:35 +0000
Message-ID: <aecc643c-1c5d-41b0-a4f1-b1101ec3ad41@oracle.com>
Date: Tue, 20 Feb 2024 10:42:29 +0000
Subject: Re: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-3-joao.m.martins@oracle.com>
 <62269e45-cfd0-43e2-a08b-6b3091a34778@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <62269e45-cfd0-43e2-a08b-6b3091a34778@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cab37fb-d993-4b6e-2e60-08dc3200a64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srkqLZgkL8GdVvlumXBvkWGPQz4R/6eJtz7nVydr2XJ/bW4F8py6MVLoLV2Xe6bVuKPFnWxnc1xizqHEqzN98Ag+6dFce/PFpmkgWakkaU0j9J1ZOIpktUiz2UlIH1Mc1hXbhJJpNEeYKhe3Ut6CwfuAVgB5bMgppXMwVpompOTsDOPswyVhGoNV+USiGoUZ7735l4rCgWMkCwa/68Zqs0trszcERcTpNp7UzZ6giSQ2PnW13sodCNm6AoJ/5qGcB24VnbyBe8ax/beTyCvKDymqbjEs2W9AbdgvM7ACuubXmA3vK+WAlUHA3OMDtUkyLNqZy/Y1a8wNGVnwwBCCiQM91mz6zspkvWI9zA6Xf+bB2YnKVNwAyKaWFWV9nOEDEA+w1Xe/v2TT/0y9G9WKYaQ9Udc6umJL6SIuzw24UNMlQC11iWBLwXBHhfUIz8jdKbNAXFn/fOMWD8Zj+I8/OiZfpgDNs9gwbumcqg5LXi/O/Lg4TV1TpgVGMcp3nY2B/FNTdW49Wtccxwg5Jx5TV2Pbjh0kewY3rEhWamR18WhjGpDRXT+GW0AB5z1K31WB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0p4TnpyaXNVaCtGb1BzVzV5WkZBOXdMRG5JRWxFN242NGs2ZlN5Si9yNmRw?=
 =?utf-8?B?WTFaTXlzVUowUFViWTBPTnpTRzBWKzMvcmdlN0tKT2I1WG4xZUlXVzBxUFNY?=
 =?utf-8?B?MGt1c0Vaa3E4d2V2NjBUUHJoWW1rQUtTK0xpYTFZZFBDWkJ3dVB5dFNzRXgw?=
 =?utf-8?B?VlJBNTB3cGZKd2JndkZ5eUZiTmRVYlQzUWc1Z21HYWJBaFRmUVZDaVFHRk9h?=
 =?utf-8?B?N0M0NFVleTBmVHVXTjI1SzZWMUgrakNXaDNJYVJWc0NIK3gzMmFlQzlqdU1S?=
 =?utf-8?B?eVhlWHkwTXQyZEoyazlRTzFxaGVqaXJPbHZqQWpWRmFQaUx1ZzlOMnVEUGhB?=
 =?utf-8?B?U2NPNFU4REg0YWhEaTBhVmg5NzNKRFV0ck5jOHE4ZWhEV3JmNTRYNWNlcWhY?=
 =?utf-8?B?QnhHVzRIZll2Umo2RlI5N1VkYzdwY0xKQjhUWExCZnNiNkt3eHZmT0lzbXY0?=
 =?utf-8?B?S2liNERMQmNuYlpGZkJpZGxWakd6WkE0TkgwS2NMVDJERjJFTHg4SUh5QXpR?=
 =?utf-8?B?aWk4UUVWQU5MT01yUW51Wi9ldTRqeVNHcEVHVXJpZ2FVRmtRWWFRNUJKeHhv?=
 =?utf-8?B?Y0phajNHSW5ZN1BaZms2SUI3ZXpJMmlNTW5rc3I4TG9XZG5vcXI0Y2p6QWxC?=
 =?utf-8?B?NzBnTzU3S0VUa2VzcWJmSjlueU5IUm1Wekt4RW1BREY5MXJTd2UxMXN4Uk5i?=
 =?utf-8?B?LzV3Y3ZOTVBTenNja2FnMC9aUi83d3VwM1JPdzlsdmsyMmFmN2dWenphR2FR?=
 =?utf-8?B?VmZFUS9ObXY0MlQ2Zys3bEZVcnZiRDk1bTRzbmlkYnZRc1o1bnh6WDRKS29q?=
 =?utf-8?B?YnZiTWVDN3Z5cVE5RHVjeE9QY2xKakgxVmJTTHpCVGRpQUpPSlBLR01WRG9s?=
 =?utf-8?B?K1p1U0RVZ21ydlJkTU4xOVh1ZjVFZHcxOTBzQUt2dFV1MXJWYTNWVnRSWUFh?=
 =?utf-8?B?RFhweUhwdjlvcUNrMWlpNWhFd09SWFRJeWtqZEFjSkswc21venJJZXNwMDFV?=
 =?utf-8?B?Y3hILzFkV2hZWmRXa0RPa0Z6QS9JQUsxNEVXT0tYaWQ2NVd6K3UySWY2WCsr?=
 =?utf-8?B?aDZRNjZlUU5EUEw3MDlmVy9tUjc1MEJpcFFCaThzaTlWaG91L3RvdjVUQ01q?=
 =?utf-8?B?L1c2VDVrTGJLN0QvTjBPRFgyc3dEd3RISEl3VDVaWGJrZUU1VjRINnNlYncz?=
 =?utf-8?B?Y0dEcktSVFQ3eVN2dW9XMTZUdGh1MFFjV1ZkNDNEVHpyc3VmdmdiYkwyQTI3?=
 =?utf-8?B?NHM1cjRsMVVwZEIvbUtDNFF0cDhTSElUZ1FLRW9EenlRdlh6aUlFU0R6aW1L?=
 =?utf-8?B?Tm4zOGpTNmFsQzZ5MEVMWTFvdDV2Lyt1cHdGUy9CYnJMSGxiUWdmQ1Q1MWIv?=
 =?utf-8?B?Tjh1dWRxaEdHVFR1V2JxSFQ1eXRDeGxDdE5iZWlmWXZQL25UZlhYYW5wWDdO?=
 =?utf-8?B?cDBCcC9BTXBjR0FZTUdQNlJ4bjNuNUJRYTdsdWh4RlZZd0cxS2J2eDJWQmNm?=
 =?utf-8?B?S1ZEMlZYa0VJdVRhemFMblU0RTVKdzNUek1EUEhHOFhHS0dBbW1COXAwdGpp?=
 =?utf-8?B?RmRyL0QwQ2RYemVwcDh6NmlRWXVPTVAxY0RTdTI3bk1VYmI2aWc2M2tnNUd0?=
 =?utf-8?B?SE1mQjVaMlNVTEZpcmFBTTRPbXpsaUMyOVY3bjU5S2RZZkplN00yRUZOMklQ?=
 =?utf-8?B?Z0JXcVdXOGZJV2tVSlBKNHdTbUcrcDlmRkFuaWpBaDJ2dVJVRkZ3VmpqcHlm?=
 =?utf-8?B?WkFwT29pTzkraW41c2s0c2lRejNOb28zMkYvRFNQSFhoRkpkV3JDYThzNGp6?=
 =?utf-8?B?czVPZmlWWTRma3lnZUIwZHE2U1oxZWszdkRyV1pQRmx5ZG5GZlF1WVhIQW9U?=
 =?utf-8?B?U0g2VHlNUUh0QzhaZVpDczl4cWFYaWI2bk5ldzdpakMzZXcrZk0rMy9KTFMw?=
 =?utf-8?B?ODhwMmtGMThkVkNER3hjRjhYdFdCRkYwa0dXWFdiNWNRblVLVGpWSnJBVklD?=
 =?utf-8?B?bGJVTGZZK3dNMkN3Z2Z3K3phQTNnS0pyTU9pUk4zUUFkejhBSkJVSS9PSzBR?=
 =?utf-8?B?N0I1N3ZXeldKWkg0ZEJjbGNFU3hmengxYTRSQkRHRHlOVnFLaGZQektFWXRW?=
 =?utf-8?B?ekZQL0FRWGZHS2JQYUpOZ2I1QWRDM1piQ1FnUXl1QmU3cFpoVnJlOFdNU1BQ?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ty4RDtwM8BwkpArIJB3CV+3Js9U/MwX/oaYNh9Y4s98V+sSc+5U2by/pMbkhjuseWg3Sbvd/T48ageK6eaWLz5Goiib6O4VrNkEmP2dJTMbtDy2R8uXGRrxFaWC3SGUbLGKvIg5yWEFs1ZJ+9c0jNgzUtd8vTUU4u5tvt1VMos7SIFz9UtMjSG06amrflvsqdUszazcsdD2Wik3BXFroRZzYG1lX18hG6ZxgRVZCO/3chHORRg7EpIpkp9BYPdmsfkj+jhVTtEQvs51oO0IudVmMepWVBg6ytlWfBPJmow6u/fZbHz6vQyekBCn19thhKw++7DQZODQNstwNKBBqSJWX7tdBGOl811sB/2hxgSokdKXvD8gOAYsMCTfcBz1USt9iRgcUDFq6MeqVXGM+le85z5+erPvIJFAfmR1145FDX2KkR1JdNkHTufRGBtlj+cBjgFxzTQhoLypX2qKc5pwn7jRBAljSAP2B6QBlj9HzO+uWc+4VEjlbBlYHI5G2uhZ8Y4ilLJ5FWH3K9RCvIMvZkkNZ3idYd8dabEenmq7gbmfRSzLE/HNxA/81dY6Jm/5Q+K7z7+2gzreHrIh6sil2xaGJDS4H67iA2oX8D3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cab37fb-d993-4b6e-2e60-08dc3200a64f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:42:35.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRL/9a3vIRtEZQQ0XZszJUlzDs0R77Ul+4zgiYkbWspfshx2PpqYK1538zvlV3iLL2udoWDKXSRgV0Rtg4hkTBKi6t/6M+FE5xhCS41YPmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200075
X-Proofpoint-GUID: pehS0jC-sdptocjz0rto8rLy3t0IXBcX
X-Proofpoint-ORIG-GUID: pehS0jC-sdptocjz0rto8rLy3t0IXBcX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/02/2024 08:58, Avihai Horon wrote:
> Hi Joao,
> 
> On 12/02/2024 15:56, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> For dirty tracking such property is enabled/enforced via HWPT_ALLOC,
>> which is responsible for creating an IOMMU domain. This is contrast to
>> the 'simple API' where the IOMMU domain is created by IOMMUFD
>> automatically when it attaches to VFIO (usually referred as autodomains)
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
>> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
>> to IOAS attach.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> Right now the only alternative to a userspace autodomains implementation
>> is to mimmicing all the flags being added to HWPT_ALLOC but into VFIO
>> IOAS attach. So opted for autodomains userspace approach to avoid the
>> duplication of hwpt-alloc flags vs attach-ioas flags. I lack mdev real
>> drivers atm, so testing with those is still TBD.
>>
>> Opinions, comments, welcome!
>> ---
>>   backends/iommufd.c            | 29 +++++++++++++
>>   backends/trace-events         |  1 +
>>   hw/vfio/iommufd.c             | 78 +++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h |  9 ++++
>>   include/sysemu/iommufd.h      |  4 ++
>>   5 files changed, 121 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 8486894f1b3f..2970135af4b9 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -211,6 +211,35 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be,
>> uint32_t ioas_id,
>>       return ret;
>>   }
>>
>> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>> +                               uint32_t pt_id, uint32_t flags,
>> +                               uint32_t data_type, uint32_t data_len,
>> +                               void *data_ptr, uint32_t *out_hwpt)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uint64_t)data_ptr,
>> +        .__reserved = 0,
>> +    };
>> +
>> +    ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>> +    trace_iommufd_backend_alloc_hwpt(iommufd, dev_id, pt_id, flags, data_type,
>> +                                     data_len, (uint64_t)data_ptr,
>> +                                     alloc_hwpt.out_hwpt_id, ret);
>> +    if (ret) {
>> +        error_report("IOMMU_HWPT_ALLOC failed: %m");
>> +    } else {
>> +        *out_hwpt = alloc_hwpt.out_hwpt_id;
>> +    }
>> +    return !ret ? 0 : -errno;
>> +}
>> +
>>   static const TypeInfo iommufd_backend_info = {
>>       .name = TYPE_IOMMUFD_BACKEND,
>>       .parent = TYPE_OBJECT,
>> diff --git a/backends/trace-events b/backends/trace-events
>> index d45c6e31a67e..f83a276a4253 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -13,5 +13,6 @@ iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>>   iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
>> size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
>>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t
>> iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64"
>> (%d)"
>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id,
>> uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t
>> out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u
>> len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d
>> ioas=%d (%d)"
>>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 7d39d7a5fa51..ca7ec45e725c 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -219,10 +219,82 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice
>> *vbasedev, Error **errp)
>>       return ret;
>>   }
>>
>> +static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                        VFIOIOMMUFDContainer *container,
>> +                                        Error **errp)
>> +{
>> +    int iommufd = vbasedev->iommufd_dev.iommufd->fd;
>> +    VFIOIOASHwpt *hwpt;
>> +    Error *err = NULL;
>> +    int ret = -EINVAL;
> 
> The -EINVAL initialization is not necessary.
> 
/me nods

>> +    uint32_t hwpt_id;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
>> +        if (ret) {
>> +            /* -EINVAL means the domain is incompatible with the device. */
>> +            if (ret == -EINVAL) {
> 
> On error iommufd_cdev_attach_ioas_hwpt() returns -1 and not -errno, so I guess
> we need to change it.
> 

/me facepalm yes indeed

>> +                continue;
>> +            }
>> +            return ret;
>> +        } else {
>> +            vbasedev->hwpt = hwpt;
>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +            return 0;
>> +        }
>> +    }
>> +
>> +    ret = iommufd_backend_alloc_hwpt(iommufd,
>> +                                     vbasedev->iommufd_dev.devid,
>> +                                     container->ioas_id, 0, 0, 0,
> 
> Should we explicitly pass IOMMU_HWPT_DATA_NONE instead of 0?
> 
That's better yes.

>> +                                     NULL, &hwpt_id);
>> +    if (ret) {
>> +        error_append_hint(&err,
>> +                   "Failed to allocate HWPT for device %s. Fallback to IOAS
>> attach\n",
>> +                   vbasedev->name);
>> +        warn_report_err(err);
>> +        return ret;
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
>> +    if (ret) {
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +        return ret;
>> +    }
>> +
>> +    vbasedev->hwpt = hwpt;
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    return 0;
> 
> I think we need to improve error handling in this function.
> There are various places where err is not freed/reported, not NULL-ed before
> re-used, or used in error_append_hint() although it can be NULL.
> If there are places where Error can be ignored, we can pass NULL instead of &err.
> Plus, errp parameter passed to this function is never used.
> 
Let me fix all those for the non-RFC v3.

>> +}
>> +
>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>> +
>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>> +    QLIST_REMOVE(hwpt, next);
> 
> Shouldn't QLIST_REMOVE(hwpt, next) be moved inside the if?
> 
yes

>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +    }
>> +}
>> +
>>   static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>                                            VFIOIOMMUFDContainer *container,
>>                                            Error **errp)
>>   {
>> +    if (!iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
>> +        return 0;
>> +    }
> 
> If errp is used in iommufd_cdev_autodomains_get() eventually, we need to make
> sure it doens't contain an Error object before using it again below.
> 
yes


