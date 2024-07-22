Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B0AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxSf-0006jD-Ke; Mon, 22 Jul 2024 14:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVxSd-0006cx-W7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 14:08:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVxSZ-0004rx-II
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 14:08:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MHMXaX007947;
 Mon, 22 Jul 2024 18:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=xb6SrutegjqsNOFs9cyjYR4of9izWqd6GdyuR18zkxY=; b=
 dXHr3eJihnoGZehFkxMZJm26WBMD/4lnW+mmgtWeQh9ppRpyfvdkGvGXzkTCVz5p
 JDRtCgcEFyQJUIfO7Emsn0D7vn7cHONLKQzAi1uhzqKdMhmDTXs9Uv3CudFFcMz2
 aucA+Z8V+o8e5AUF3TKsR8S77wQ0lE5DxUPYBL7zK7oxdVbHgE9s2uv3BndHUXiS
 E2UwSgM14pKOboNRX7lUieOlGLgbXij/1zTTumv5U7z4EV/u/enlW8j+yrP3C5Av
 8v/szYT/FwArbQx0rxfvCZGImMXwHaQuWerQNwzT5RFxDQHlglG3/QCeK5YWtamO
 T1pGdzDkM0nqe0aoHcZeig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrar7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 18:08:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MGs586034280; Mon, 22 Jul 2024 18:08:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h27kd5e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 18:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzDVWhbEeWzbeohl/mB0m05rzh/GIaCcoF80J9xre/4QzDdHWvJn9dr908ickgEyk8Q3AMp0gGJmt2nYNFuRWQxIW3rlM8f2SdbQ6bbEZ2K8MWDbUA3/J2MKgTAJweJ4mz00l+KmtOQLeUYqptQHf3CIF5yU6PuX6sdIRILYOYv4sXCA39tQKCGHYGhr7yoX8rv0AU5w9LBfKzuukyHtQTAumrNYRnTTVKcrgXckkYY7KlJA4lxpaRRmDDAy7jCez2K+EedEB+whgBYzyVnbUkZ/5mDjTAqc/ZjOWWyt7bzh+8PPWeUOWgoQ01m1dzX0XftFho6PGtRO0ArnT6+K+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb6SrutegjqsNOFs9cyjYR4of9izWqd6GdyuR18zkxY=;
 b=DRdHWl7IEMbBhKN0SRH24xAzQdqv9Ty3I0qGa4M2fZVLt7+sCBKg7+lL20nGpVkZuzGaWKBHBwBWms4cdY/QigC/cvMJ5yjINk8mB7VyRRaNbmTZtG869OHTVJhWoNM8MhXabnji3xkEFVaSG9p8cPrJPh7Ag56mb4kycxR3tvQZ2qVUibqczE2CetDhZrSJRBwGw1e2vobQYyoHOHWq5IfYzb3oqzbYkn3i9RwpWcZlkHoS26thXSdaam3zTUHr+hN+8xwzS8oAHARfmYvGnjbHcm1fQYFurvWIBxBS7dAoll8GD9mFtg5+E74FQmJkmP2b1likTF8uJZbkdDR3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb6SrutegjqsNOFs9cyjYR4of9izWqd6GdyuR18zkxY=;
 b=Rrk+ldShqhOHZQNb/vfdHCV7bAQhePcVWpPT60XGu8VFIQMCIRUBDuvBA23yRmwDPWNHwqDUP39OcgIosvmD5ZfNo/qOEyGhj81k1EyUJYBBoPQuy/WEVqXol7QYdF1Wga1EV0TVyiw61bylO+1rLoJ4sQUCUJ+z3RIyHWHUsJU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 18:08:17 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 18:08:17 +0000
Message-ID: <dd11eda5-773f-4030-be3b-cf45d5e65aec@oracle.com>
Date: Mon, 22 Jul 2024 19:08:09 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
 <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
 <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
 <103a2101-3f9e-46da-b45b-b8a4eaa7d6e7@oracle.com>
 <51012898-c535-4fb1-b101-3d613d46fc30@redhat.com>
 <27e2792c-6eba-4fab-a22d-40e46dae9cda@oracle.com>
 <f9e3bc1c-71f2-442a-8697-19b64a225d57@redhat.com>
 <1d7aaeb6-67ab-4897-96e0-e6128680dd4c@oracle.com>
 <544c0bfe-7dcc-48e7-80a3-ca7f4b255d1b@redhat.com>
 <ef81ddb4-385b-453a-b97c-bfc529c8e646@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ef81ddb4-385b-453a-b97c-bfc529c8e646@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::24) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1b7452-95af-47f1-b0a1-08dcaa794301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEZiVnZhdlgzZHVMbE1DQjdOekZ0QTFqRlBHR0FnT051S0pOeFBaVTVyZVN5?=
 =?utf-8?B?bHZ1Z09zK3I5TjNTR2R6N2hHUTRFTkpkLzRnMkcrMWVuSmdnSXIxSkxUWFhz?=
 =?utf-8?B?d2dzc1JFTFludEJDS2ZvVC9JdVJSbkpyS29DUmpDNmFHRDduVVBNaWYrTXRv?=
 =?utf-8?B?YzdEMWJaMkgrNmxhcDlJMzRabGVXRm5qd0FxaUtpeDRYNWtBMENXczYyN01D?=
 =?utf-8?B?cTU5K2FUbzR5RVJ2K2RkWm5TcExUeElyUnlndlA5RXNYc2ZVTVNjUDFYSkZS?=
 =?utf-8?B?dkVwNmpyS0I5cW56blJsVktDNm1uNkxEeWlURngrVU5GL01Sa2NkQ1gwZGhX?=
 =?utf-8?B?dXNPNUZ6VUxVU0xQa1BaVGVhaWNjSDNzTG1MOERkcmZPbzN0Wmdxa2srcDdo?=
 =?utf-8?B?RGp5MTR3RSs3R0Q0ZzVUNzJPZHpxUzBJUU03eWJPOVRrVHVPajVPL2o5ZVVK?=
 =?utf-8?B?ODVQZnJNV2pSeUNXcWVka0VPTldyTzFib1JKcVVWTWQyRFdpSnhRallCa2VM?=
 =?utf-8?B?S1dQNlpxRUVMT1BJdVM2OHhIUE50enkzVWc1aGp2MmQ0YTdEV1cwY3dTYUtJ?=
 =?utf-8?B?ZlVZYXRvOVNTV2M5bkloLy9CMXZhWDliMlFXODJ1ZUlPd24xM0M5cGVlVHNB?=
 =?utf-8?B?YXpjOC9QTDU5Ty81SDZ3bnd4dmVIYXA3TE1jTXJVOENqQUF6dFB5ZkNYd3BQ?=
 =?utf-8?B?ZmY5d0tCSy9XYnRGc2x4c3hmdzM5eWtKODd2UEFTRmliOVZOZW9zZnZwY2VW?=
 =?utf-8?B?Y0hvaCtOS1RpOVZ0RmJKR0VlcDF0ZXZndUhtNkswLzBNK3o0QllzTXd4QUpJ?=
 =?utf-8?B?ajl2TmxIN3hzTU1IODE4Y0ZYbklNQmxXWlh3SzZubXZlS0VSMjFKR25yRm1M?=
 =?utf-8?B?Zko3RTBidHVKdEEwbDhGczZrSzdkeGQ2WjU2Smt0VzBLMVpsVXdDUGhJcVZ5?=
 =?utf-8?B?eGFXaGFYTFE2WGdYSS9IRXBEZ1ZrdHM1UkZDTXB6ajJCYVVDOUpZRzNJcW90?=
 =?utf-8?B?c1FhU2VxNEZXSkdkN0ZsQVhLTFcrdjNGNEtobjdUMGFmczhNTCtpanFIUDdo?=
 =?utf-8?B?SGliVzN2UVFMcDF2ZHJSY3h3UjE1RVNmaWRCNGo1T2VPNTIvNmdnajFFbWJJ?=
 =?utf-8?B?TzZBUXlsaUhjc1dBMlpHNzdvSjRhL295clNjMzViOVozQjN5QlFhdUhnVmdJ?=
 =?utf-8?B?UnNrRDM1V3dQWHFpdkNlSWpnL0svQm5vVjhoa0dZVDZwd2JBaThUVUtwbDd2?=
 =?utf-8?B?akdFeEhZVklXSG9UK0IvQUlEcEJrYlFmcU9mQlVCYzJKQ1hFQWNQSUtldzVH?=
 =?utf-8?B?T3R5YnlIT2VqQVIyOUMrYUprRXlyYU9WOXh6VXp3d2tNYU5QQy9uTW1FU2Zr?=
 =?utf-8?B?S3IybFlxUXRPVXI0UlBTSFp4S0tUL005MTZWZVdFanpDWDZUM1JocStOSWg3?=
 =?utf-8?B?Z3RCcDVQWlc0YkEvTFVzV0xPa3ZJOFhlWk5aWmxxUlowQnErdDV4azkzT1FB?=
 =?utf-8?B?UWt4VUtZY25UNGo5UnVDaGpCcDE5RjdxZk1iY0lueUdkbStJSXlpMy9jS1hm?=
 =?utf-8?B?MkhsMHZoNzNvNkNDajY3QUc1UThhWlJzYkgrQ1ZBQmIxUzZtQWJkSzBwdGo3?=
 =?utf-8?B?UnJKbTFtVW9RWUhKY3I2Qm12dWJoL2hQcFRtTjAxayt6SFNwVXIwWkdaNkhW?=
 =?utf-8?B?MUZ3TjFicXUwTmw0bytNR1JNdkE1bTlDYTJBZFlYVkRoVlpCNXZzb1FlQytN?=
 =?utf-8?Q?UzH/om4hPu1PjGEbcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVjaEI4dGt5OFZ5Ly9MOFpraTJZY2g1S3p0U0ZiY1V2Vjg3ZTRGWC9aSEVE?=
 =?utf-8?B?a08wbUp3ckRMQ0YzcFV0MkhjRlN1a21BYU1RMS9PV1o0MHVaYW03dXZZQmZC?=
 =?utf-8?B?UVdvTExMS2t4QVBnMThaajg5Z3NJUlZ0NlNpVEdRRCtjcHlyeHQ3MFN5cVVt?=
 =?utf-8?B?cmp4QmE5YlJMbUpvaWEwS2QxeEg3bitCZVpWS0ZaeWVGMkRiLzJyOCs4UXBZ?=
 =?utf-8?B?dmdTTjVyV3NKMlVJb3NHUllLYUFIcUVVTy9wT3YvNmtFZUpkSFh0L3lSbWVr?=
 =?utf-8?B?Z3lsVXYxK3BqRElLT040c01DRzNwZnZnbzVTTSsrMmhJWWhrS004LzNMckc2?=
 =?utf-8?B?ZFNySDFaUlJaTkpwM3ViN0w5L0JJcXFQdWpQUFhONVQwUklXaGxOd0FUZmVD?=
 =?utf-8?B?SE5mallaL3NVK09hOWN0dEdLVTZHblJEblpqZ2orNkN5aEwvOTRBT1pZMlE0?=
 =?utf-8?B?RVlqU1VrM2llWGtpYWpmS3hlZlczZDMxN0IvbjE5Y0hGdGJwa29OaHNYU29t?=
 =?utf-8?B?K2lNd0l6NnpFUVdsRFVLMVhLbnJTNDFlWHZNTEVZcTlSdmhoaUFYbXZuNDFw?=
 =?utf-8?B?eG5aeW9EQ2tmMkVySUZsY2NtM2lMcERqblVaS1E4MmJXSXV2b1JtWGpKS1NS?=
 =?utf-8?B?NTJnQXBEVjdncW9qUGRBeE9wK0ErYmFHQ0tocTQybEdhb0NxZWxEbnl5dEUx?=
 =?utf-8?B?N01rdjhTcDNsVnQrQVlwUHBGSG9OQnhTMGJVMitZWFloTDl6Qmc5Q3hYZ29x?=
 =?utf-8?B?Y3JMejBpeXVNbGNERzlRdFVjcGNiUzMxTk9LUGNFM2NkWmplZ1BKYnMwOWR4?=
 =?utf-8?B?NlNQUWNLbGE2b2lqWUhleUxXU2hNcVJBY1R6UUZGaWhTdTZBQm9DeE9kTGVS?=
 =?utf-8?B?ZnV2dWI1TXY1RzllWFI0YnBZcC9BcWFTekN5VzVnOUlIREMveVp1NXFMVUJk?=
 =?utf-8?B?eUloV3c5M3FpZnpaVFpTVFZ5R0lyMUpyUWxwMHZ5ajczd0xtY2FMclBnSlBI?=
 =?utf-8?B?NVdiUXdzVTd2SFk2NHc0WXpRUjEzSlc3ZHZJdVk1cGJwRWJ1RU9hcmRtVmln?=
 =?utf-8?B?MG1GVXJabUR0ajFiQ1pKMHVlYk42SEh6RklPQ3g5b2kveW1naHhWa09wNEdN?=
 =?utf-8?B?WFNXNVZ5T3lVWHhKZWdCck9qaVQ2RUt4RU55ZWtPQ05PWXNIcUh2MWltYUIr?=
 =?utf-8?B?NFR4RUxZZjJhSVpUc2NTUWRyZHJrbzQrS3JybkdTM2JaQ0RpdFNCVVVjTm9h?=
 =?utf-8?B?ZGI1S1prc3F5d2h6SkdrV00rK1o3WWVGVnJESzI5d0dtN0owZkNuWXlibjJB?=
 =?utf-8?B?ZGJraFlUWVFFaXpQcGJxT09EaGhwcnRjckIzV3dGQko2aDZZSldTQ2ZPU09Y?=
 =?utf-8?B?SW95djArNFRWS2JRSTRmazlZTUJ1SXI0bVZsQWprVmdWdFcveDBpODBocVRQ?=
 =?utf-8?B?VDkrZUxxc3MvNmNPZEtYWGJpQ25UK042VVJheGNRTitEZnQ2Snk4K3J0TXlz?=
 =?utf-8?B?MmxORWNXUS9ETUdiMTdQRWl5NlBmVjZQQ3RyNG1aSkpORjBwWTJ6N1lRNEQw?=
 =?utf-8?B?TEgwY09CN2ZwSGx3aGZ0WGVVMHU1TW9Db0p0Q3didFVDVHlxVXhIYWUxQmEy?=
 =?utf-8?B?b0IrVGt0Y0ttbk80cFZJR3h0MnlXaENoS25qTWkxSkpoa0JQVHNTazQxUVZK?=
 =?utf-8?B?MUFqbTdGeTRlNFZKemxhVEx1c3pXejZXRG12SGFwWXJMek1taGtIcnc5Slcx?=
 =?utf-8?B?aDlJNDRscVcwbFNsbGMySXhxTFRTRlg3MWlMNFg0VTlsOGw0RDdTSWlqUXZz?=
 =?utf-8?B?NWtKaDJld0ZtZXN2TlhWZmJXdWRvNHh1T1pHSmYyR3lPVGJ6dUg4dzVTODQ0?=
 =?utf-8?B?YmcvQUFhRVo5dzU2bnB1RG9tUGYrQTgzMk5ZNmU5V3REL1RhSlRtQ0k0Mjht?=
 =?utf-8?B?TGl5R0tmcVBXSWc0OVlnSUQ0UFBheFUzL3J3RUEwMGFHRkhjRytxbG9TaTJu?=
 =?utf-8?B?MFhLbDRZaXI2MmE1Q2wrVG5rcXVkVGRFbWpVbUtFMU44YlNCZWdqd0ZrN2p0?=
 =?utf-8?B?ekg5UzFmRjVCYWtoUHNLRldiekdyUmxNV0lGUTlQZ3RKRk00UVhHa2xXZjBx?=
 =?utf-8?B?RTBoOUtCam5wcWdnUEU4b2cxTEtQOEd6ekI4RFJoMHZZMXVsall1SVh1eUdG?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KE4YxWoVUaHbpSFrnbGRkw1hqbJH1SKfgIkWX57beuGvKU5wow6hX0t88veP3krc3Mw33EIDDdy6AiOvu97kOZiI9yaN12NvK8wBhbe5UUg0hG3e75ZUtjQrqhqVlYLd5LoxNFoWLH7pFLRJmsu+eqLR4z95Bzq7rOjukofL+OyfKRmCQPuKItpZGR6goy1S42kYMou1uBAcq1X/RCgxZAVjh9M/SjhAT+jeOBdf8gSSBrOZvXrD/IxYuqSH7K7QqTAaekuzI9iR1Sg7Rr38lOiXvrDQV+HFSpuoc4Daq+MYFkTX5dAadg1SD1IbsZPjsNTCHhKx5IS1mGhcszUJbKGlkEtbAIWQz/avLtxe7DnI4l+Nu4Vzly1fEHpCBpbt9alR9WYFJotxylM68J0u4ZEd89cUKT8M9hAkbfW7CbeuI8mqnUnlTiyD0dOhqX4SbR8KI1Qax7KPwz5XOgjalZ1iUOpkEPCWRXR31WLZSGJUGuGiXtyQI1Z2H9gwU8UDS/vx6xOQX2qcUi6GMjMt9XiOpHjjs4j8pxM7vtLAptNotCFojmaF28x6mGi2HJ90bNmqy0DitFoB/W1WHKUoFNLg6Dn38YsZSKvU/CunN78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1b7452-95af-47f1-b0a1-08dcaa794301
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 18:08:17.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0XGS4CU+njMsdZwU70K/bLpokYQ33UvTYT/eQxy30RfGhvPlZnetVjNV+yiuNAWPJ6iHf89PeoFF4t35+SVMO1AbTj91ro6tlcVkPEyXog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_12,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220136
X-Proofpoint-GUID: 8T1QrOk5NqrUM7PEL1_uvbH1j0wocIWy
X-Proofpoint-ORIG-GUID: 8T1QrOk5NqrUM7PEL1_uvbH1j0wocIWy
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

On 22/07/2024 18:15, Cédric Le Goater wrote:
> On 7/22/24 19:04, Cédric Le Goater wrote:
>> On 7/22/24 18:29, Joao Martins wrote:
>>> On 22/07/2024 16:58, Cédric Le Goater wrote:
>>>> On 7/22/24 17:42, Joao Martins wrote:
>>>>> On 22/07/2024 16:13, Cédric Le Goater wrote:
>>>>>> On 7/22/24 17:01, Joao Martins wrote:
>>>>>>> On 22/07/2024 15:53, Cédric Le Goater wrote:
>>>>>>>> On 7/19/24 19:26, Joao Martins wrote:
>>>>>>>>> On 19/07/2024 15:24, Joao Martins wrote:
>>>>>>>>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>>>>>>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>>>>>>>>> By default VFIO migration is set to auto, which will support live
>>>>>>>>>>>> migration if the migration capability is set *and* also dirty page
>>>>>>>>>>>> tracking is supported.
>>>>>>>>>>>>
>>>>>>>>>>>> For testing purposes one can force enable without dirty page tracking
>>>>>>>>>>>> via enable-migration=on, but that option is generally left for testing
>>>>>>>>>>>> purposes.
>>>>>>>>>>>>
>>>>>>>>>>>> So starting with IOMMU dirty tracking it can use to accomodate the
>>>>>>>>>>>> lack of
>>>>>>>>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>>>>>>>>> migration and thus enabling migration by default for those too.
>>>>>>>>>>>>
>>>>>>>>>>>> While at it change the error messages to mention IOMMU dirty
>>>>>>>>>>>> tracking as
>>>>>>>>>>>> well.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>       include/hw/vfio/vfio-common.h |  1 +
>>>>>>>>>>>>       hw/vfio/iommufd.c             |  2 +-
>>>>>>>>>>>>       hw/vfio/migration.c           | 11 ++++++-----
>>>>>>>>>>>>       3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> b/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>>>>>>                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
>>>>>>>>>>>> Error
>>>>>>>>>>>> **errp);
>>>>>>>>>>>>       int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>>>>>> uint64_t
>>>>>>>>>>>> iova,
>>>>>>>>>>>>                                 uint64_t size, ram_addr_t ram_addr,
>>>>>>>>>>>> Error
>>>>>>>>>>>> **errp);
>>>>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>>>>>>         /* Returns 0 on success, or a negative errno. */
>>>>>>>>>>>>       bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>>>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>>>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>>>>>>> @@ -111,7 +111,7 @@ static void
>>>>>>>>>>>> iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>>>>>>>>> *vbasedev)
>>>>>>>>>>>>           iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>>>>>>>>       }
>>>>>>>>>>>>       -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>>>>       {
>>>>>>>>>>>>           return hwpt && hwpt->hwpt_flags &
>>>>>>>>>>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>>>>>>>>       }
>>>>>>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>>>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice
>>>>>>>>>>>> *vbasedev,
>>>>>>>>>>>> Error **errp)
>>>>>>>>>>>>               return !vfio_block_migration(vbasedev, err, errp);
>>>>>>>>>>>>           }
>>>>>>>>>>>>       -    if (!vbasedev->dirty_pages_supported) {
>>>>>>>>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>>>>>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Some platforms do not have IOMMUFD support and this call will need
>>>>>>>>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>>>>>>>>> the IOMMU backend.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This was actually on purpose because only IOMMUFD presents a view of
>>>>>>>>>> hardware
>>>>>>>>>> whereas type1 supporting dirty page tracking is not used as means to
>>>>>>>>>> 'migration
>>>>>>>>>> is supported'.
>>>>>>>>>>
>>>>>>>>>> The hwpt is nil in type1 and the helper checks that, so it should return
>>>>>>>>>> false.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally
>>>>>>>>> didn't
>>>>>>>>> consider. Maybe this would be a elegant way to address it? Looks to
>>>>>>>>> pass my
>>>>>>>>> build with CONFIG_IOMMUFD=n
>>>>>>>>>
>>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>>>>> index 61dd48e79b71..422ad4a5bdd1 100644
>>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>>> VFIOContainerBase
>>>>>>>>> *bcontainer,
>>>>>>>>>                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>>>> **errp);
>>>>>>>>>      int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>>> uint64_t
>>>>>>>>> iova,
>>>>>>>>>                                uint64_t size, ram_addr_t ram_addr, Error
>>>>>>>>> **errp);
>>>>>>>>> +#ifdef CONFIG_IOMMUFD
>>>>>>>>>      bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>>> +#else
>>>>>>>>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>> +{
>>>>>>>>> +    return false;
>>>>>>>>> +}
>>>>>>>>> +#endif
>>>>>>>>>
>>>>>>>>>      /* Returns 0 on success, or a negative errno. */
>>>>>>>>>      bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>>
>>>>>>>>
>>>>>>>> hmm, no. You will need to introduce a new Host IOMMU device capability,
>>>>>>>> something like :
>>>>>>>>
>>>>>>>>       HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
>>>>>>>>
>>>>>>>> Then, introduce an helper routine to check the capability  :
>>>>>>>>
>>>>>>>>       return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>>>>>>>>     and replace the iommufd_hwpt_dirty_tracking call with it.
>>>>>>>>
>>>>>>>> Yeah I know, it's cumbersome but it's cleaner !
>>>>>>>>
>>>>>>>
>>>>>>> Funny you mention it, because that's what I did in v3:
>>>>>>>
>>>>>>> https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/
>>>>>>>
>>>>>>> But it was suggested to drop (I am assuming to avoid complexity)
>>>>>>
>>>>>> my bad if I did :/
>>>>>>
>>>>>
>>>>> No worries it is all part of review -- I think Zhenzhong proposed with good
>>>>> intentions, and I probably didn't think too hard about the consequences on
>>>>> layering with the HIOD.
>>>>>
>>>>>> we will need an helper such as :
>>>>>>
>>>>>>     bool vfio_device_dirty_tracking(VFIODevice *vbasedev)
>>>>>>     {
>>>>>>         HostIOMMUDevice *hiod = vbasedev->hiod ;
>>>>>>         HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>>>>
>>>>>>         return hiodc->get_cap &&
>>>>>>             hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL)
>>>>>> == 1;
>>>>>>     }
>>>>>>
>>>>>> and something like,
>>>>>>
>>>>>>     static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>>>>>                                          Error **errp)
>>>>>>     {
>>>>>>         switch (cap) {
>>>>>>         case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
>>>>>>             return !!(hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
>>>>>>         default:
>>>>>>             error_setg(errp, "%s: unsupported capability %x", hiod->name,
>>>>>> cap);
>>>>>>             return -EINVAL;
>>>>>>         }
>>>>>>     }
>>>>>>
>>>>>> Feel free to propose your own implementation,
>>>>>>
>>>>>
>>>>> Actually it's close to what I had in v3 link, except the new helper (the name
>>>>> vfio_device_dirty_tracking is a bit misleading I would call it
>>>>> vfio_device_iommu_dirty_tracking)
>>>>
>>>> Let's call it vfio_device_iommu_dirty_tracking.
>>>>
>>>
>>> I thinking about this and I am not that sure it makes sense. That is the
>>> .get_cap() stuff.
>>>
>>> Using the hw_caps is only useful when choosing hwpt_flags, then the only thing
>>> that matters for patch 12 is after the device is attached ... hence we gotta
>>> look at hwpt_flags. That ultimately is what tells if dirty tracking can be done
>>> in the device pagetable.
>>>
>>> I can expand hiod_iommufd_vfio_get_cap() to return the hwpt flags, but it feels
>>> just as hacky given that I am testing its enablement of the hardware pagetable
>>> (HWPT), and not asking a HIOD capability.
>>
>> arf. yes.
>>
>>> e.g. hiod_iommufd_vfio_get_cap would make more sense in patch 9 for the
>>> attach_device() flow[*], but not for vfio_migration_realize() flow.
>>>
>>> [*] though feels unneeded as we only have a local callsite, not external user so
>>> far.
>>>
>>> Which would technically make v5.1 patch a more correct right check, perhaps with
>>> better layering/naming.
>>
>> The quick fix (plan B if needed) would be :
>>
>> @@ -1038,8 +1038,11 @@ bool vfio_migration_realize(VFIODevice *
>>       }
>>
>>       if ((!vbasedev->dirty_pages_supported ||
>> -         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
>> -        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>> +         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF)
>> +#ifdef CONFIG_IOMMUFD
>> +        && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)
>> +#endif
>> +        ) {
>>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>               error_setg(&err,
>>                          "%s: VFIO device doesn't support device and "
>>
>> I would prefer to avoid the common component to reference IOMMUFD
>> directly. The only exception today is the use of the vbasedev->iommufd
>> pointer which is treated as opaque.
>>
>> I guess a simple approach would be to store the result of
>> iommufd_hwpt_dirty_tracking(hwpt) under a 'dirty_tracking' attribute
> 
> 'iommu_dirty_tracking' may be. 'dirty_tracking' is already used to
> track ongoing logging.
> 

I can consolidate all that into a new VFIODevice attribute, and drop the
hwpt_flags it that helps.

I'll try to restructure and try to submit a new version before Zhenzhong wakes up.

> 
> 
> 
>> of vbasedev and return the value in vfio_device_iommu_dirty_tracking() ?
>>
>> if not, let's merge v5 (with more acks) and the fix of plan B.
>>
>>
>>>>> I can follow-up with this improvement in case this gets merged as is,
>>>>
>>>> I can't merge as is since it break compiles (I am excluding the v5.1 patch).
>>>> Which means I would prefer a v6 please.
>>>>
>>>
>>> Ah OK -- I thought this discussion assumed v5.1 to be in which does fix the
>>> compilation issue and all that remained were acks.
>>
>> v5.1 proposes a CONFIG_IOMMUFD in a header file which is error prone.
>>
>>>>> or include
>>>>> it in the next version if you prefer to adjourn this series into 9.2 (given
>>>>> the
>>>>> lack of time to get everything right).
>>>>
>>>> There aren't many open questions left.
>>>>
>>>> * PATCH 5 lacks a R-b. I would feel more confortable if ZhenZhong or
>>>>    Eric acked the changes.
>>>> * PATCH 9 is slightly hacky with the use of vfio_device_get_aw_bits().
>>>>    I think it's minor. I would also feel more confortable if ZhenZhong
>>>>    acked the changes.
>>>
>>> I guess you meant patch 6 and not 9.
>>
>> yes.
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>
>>>> * PATCH 12 needs the fix we have been talking about.
>>>> * PATCH 13 is for dev/debug.
>>>>
>>>>
>>>> What's important is to avoid introducing regressions in the current behavior,
>>>> that is when not using IOMMUFD. It looks fine on that aspect AFAICT.
>>>
>>> OK
>>>
>>
> 


