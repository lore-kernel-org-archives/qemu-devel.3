Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24EDC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZpl-0005hU-Tu; Fri, 06 Jun 2025 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uNZpj-0005gz-EL
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:22:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uNZpf-0008GU-1u
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:22:19 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565Nd5l003840;
 Fri, 6 Jun 2025 16:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=q58dhK6zVhvPJFK3jv
 XmWC4SSx8XY6Td9CdJknJRCQ8=; b=lNVs05WbajI1RdNinMniL5YxAk+AqnRB/W
 7vTYmTFAVSL38wmcxdy1oQz+eX7CY5nvRNfOL+/KvgyJ2OpP/z7MU64kuXcG29cW
 7fFiKEGgWlo4eG5wapcbHD9YEeB7/N01INclKm1Lrq3ntsu1IsUFZ0rX7FfB2vKv
 n/v+p9yDtJfijpgnp3QMH4JcGrHmoZJ605wo2FctEe21MjhOR6wEjt8eBJe6HFsj
 yLnklO9tjOjOPxw9Me8e3N4hR1VbKe2MfI4MYnb7fcPVHvuPks4fcMcTSp4+wVul
 6xKYjdI4saDFBUHKYZEZao+Mr28PbfoWuYsYJQ9eadbOwp8zhb1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahgd39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 16:22:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 556Fcvi6034516; Fri, 6 Jun 2025 16:22:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7dexqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 16:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ7zZKhUAdiuy4+7xXh57gRyBhsAbNqEMLn2DUZUPd/ZIxLBqejfxv1BmphQwI3b+Tkhoqr8wmZ2c/E620TbnaBRuSxesCf67ThFCoJiKrly8jMjODKraFZnRm1zkKitPwLz1Vemesi0B2Nu61Rx06qslojx9W4R7qWMO9dinPsBwJ9lgmsTpWfAfExBTe5jCqQEpXjRBAsvnD+Xo5UEtqitViaQLs8N1ghi2kyzzPfMGRg9TTw+2PqFvI8405DjQxSNLFK1DuNCZwZ8CLWCzjNDuQ56TTqvSxf1mnBmY2czb+Dc0I40jTBt2ZSqROy/RrDn7gz1p3xIjPn8Pmds8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q58dhK6zVhvPJFK3jvXmWC4SSx8XY6Td9CdJknJRCQ8=;
 b=tkWqyQphL8IV6YYEVu5D5W3jVqeG6/oGdV41Mxmeodsj58aO3NzB6DG7esnTWqaWQ2ow1oqHrGiQG5Jv6GMcShs8V+DpyPw2gYM698NIAXcF8Q01W4FXssMtsciU2kwlVaPpdAhU7n21otXwtXViHnXygPtzazqlq9Q4LbsBCC0ZOsrIGsN0rax5dc2wRkalKyFkDJOqV88tEY5Rt9A99+n2C1Iy9GBp6gedERPJgO/jLm3si9apCiRwHGxLp00A6N1JItZ+XsweejpGF+tRZt/9Y4Bctp/ky/VdlmW4I90QHnB2dj4d2DipXjhhSMLqc+rAcevtRlja1YXdcVJihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q58dhK6zVhvPJFK3jvXmWC4SSx8XY6Td9CdJknJRCQ8=;
 b=mGW4S6AzRueiATKOWTpCMhvWOrIbhR9/9nYhyp9Q0wJAsNffLajq6/fDw8SP+bLNNcYBUezF1dOKE+3u+41ZJOxoZos2bifTTAfuaPZVqstSbdkLQjLwNHLgWDb0OD94YHYTeyUISHKB3moZOoMIKCY2P0dk6XpCSH7iDedY3Lc=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 16:22:01 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%6]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 16:22:01 +0000
Content-Type: multipart/alternative;
 boundary="------------jgqvomhN5UK4CknRbfgGa61v"
Message-ID: <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
Date: Fri, 6 Jun 2025 12:21:59 -0400
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
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <8734cimtqa.fsf@pond.sub.org>
X-ClientProxiedBy: BN9PR03CA0607.namprd03.prod.outlook.com
 (2603:10b6:408:106::12) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce193a-ac01-418b-b29b-08dda516446d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|7053199007|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THEzekJiRE14RHpzNGZCanp5bnpYYlZsTlZwWm1UTjV4enFoVWowcnNBSVlB?=
 =?utf-8?B?NEdSa25qYmJmNDZ4c0hxbzNnanAvbHlySmpTbTZoTVFuNWNMaUo5blJORG5N?=
 =?utf-8?B?WlR1RWdjU08wS2pYNnNxNlI0Z0EyQ2p3ZDFrL0VyOVRmNTV4WHVOdUtzbHJa?=
 =?utf-8?B?cHlDUDJjVnVIMEFQRkEvS1hQS3l3VWZHVG1oV1E2RDJyeGdCR3gvOTh3TVBL?=
 =?utf-8?B?czE4Yk8xdE5wSTh1Q01sMENWd044b1dJRWV3d1JPaDVWTEJSb1BIcWtUcmZW?=
 =?utf-8?B?bjJ0LzhTblFwc0d1bTM4Mjk3VlhTWFk3eWM5QWxtL1lacU1OWkttMDQ4MVk5?=
 =?utf-8?B?WnRIYjVSUEg1VGxsS2JDK0N5SklCR3IzQjM4UXZFbGhwWSs1VEYwRm1UYkI5?=
 =?utf-8?B?OWloYTIva05DSWFwb0M1dWNad2tOSXA1NkdKdWFrbGxGRVgrQmY4Znc1M0NZ?=
 =?utf-8?B?dnBRVFJEdWVPK25PSC8yQnhnNnE2dEplVWtIK1h4dHNiUjFnMndTcWhxd2pN?=
 =?utf-8?B?ZStxaG1qVVdIK1VKcXk1MHlTNDJqSzBlN1FYcEpHNGdXaHBlenY0aS9KQUFG?=
 =?utf-8?B?amcvU0ZqSGplVzJ2S240RFBwZVdnaUE5MS9KcUppb3RxRTVUWEt4VlBQNGpu?=
 =?utf-8?B?Y0xObUFxMG9MS09KWHBLem5zSlJZb3grTTRwbFFzUFNDSDlJVFEvZ29xb29Q?=
 =?utf-8?B?UlVpdUZ4S24rckxkTTFkTGhnMTJQcEpGUmlrK3Z5dW1BOWhyV3FmaklpRGlI?=
 =?utf-8?B?UkFlVi93N0ZyRGVZNCtFNHVsMTJkYlFxM1BlM042VkFBaXA1NlBrRW5MbzRw?=
 =?utf-8?B?VDZuZU5lZjhIaFNpaFdoTmcwZFdvK05xQzh3NzdpRHFSRUFET0ZLVENFOCtk?=
 =?utf-8?B?WHpvdkZEZ1lTcXdzSmpkYytRTkovOFpLQzk4QnNwNmZTTGVOWG5nVS8yVWJY?=
 =?utf-8?B?OTU2NU16eVVpVWR5SmJaMmRsdnh5VEE5MUxEbEx1a0xHYjBYTUFFc3NHVHRY?=
 =?utf-8?B?dHRXNVZTcXBWMXljRjZLL0dTdWJaRkVFVllKbzJZOGVMemNzL2dSUEZwdHNo?=
 =?utf-8?B?TnNpNWxvUFRtVytjR1ZyTnlCbXlJcVdHczdHa3BVb0pCQ0IvcHQya2VCdVZN?=
 =?utf-8?B?YlZER0ZkakxxdUxmVnlubW5IWTBGMVErNm4zR1BUZzFqRjg3dzFvdnBYU1lF?=
 =?utf-8?B?TWFTZkNuL1dOaWpLYytTWHJLNE9CVmozZ2s5SVJOZVgxcEpvWXdYTUlwUTcx?=
 =?utf-8?B?VjBlbExNTCszdHJscEdQQjdROFdpWEVNeE0yWURodTRZa0d3YjJYbHZjb2VZ?=
 =?utf-8?B?NHBvdk82YjI5N2N2VWg4L3B5ZlI0aFh6eFhHR1l6UHI3Ti9FZ2IzZnNxWmdk?=
 =?utf-8?B?bk00eCtMZC9rRHdUQnVuV2lub2lqZnljbTQ5MlNHeGQyK05XbThPR2NUKyt3?=
 =?utf-8?B?eFdrczV5YTNzeU4xSmh6Qkk0UkJXQmlwUkNWa2tqUUd0L3pIazNYbTJlRk9J?=
 =?utf-8?B?SnVkNGdXVDB2c0VTVUdVajdha2dVMVkvbHk2S0tIUS9FZFVTWURHNHhaWGtS?=
 =?utf-8?B?MUN0NGNaZUh2UmpqZ2pUWU4vZi9nWE9xL3JqT2tZdW9WOTl1UVM2QmtZdHJ5?=
 =?utf-8?B?azlWY0c5aDhhc2hYcFA0S0hOczYvV3hUNks2WVNDeTVzRzdBdGg4TW4wSDFy?=
 =?utf-8?B?MVJkR1ViUTJIUTNYZE8rTE1GRExWQW0xUmYvSVcvVElZK1pMMk12bmIvSkRz?=
 =?utf-8?B?VjRZbE5MU2tZUDQyM1F1L05OQkFFb1NuTkZrWDI0VW0rVGhsVEszWlJRL3Yz?=
 =?utf-8?B?WENaY2xFeXFnUi94TjBYNG9rOFBGWUJLeGNxcFYvMWdNMXhwZUdSVnFxLzBP?=
 =?utf-8?B?ZC9jcUxOYXR6Yzk4YnlTS0xPSndDOEozWUdSTmYxbzhOVlNiTEpDV2lhbkRW?=
 =?utf-8?Q?w57LbCKMw5CkCJ1ashj463EUs2IUJG7V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzhPUVVKK3AwQUZhb1RUR2MxdDRGYzRGeU11eFlSVy85UzR2V2RhNit0ZFZ4?=
 =?utf-8?B?TTFJWklqa0k1TTdqSVhERGVpRFhXWUx1OEZWMXdrNXcrckpHc0QzUnl3SU0y?=
 =?utf-8?B?WDhtQUJ5dzBXYlAyN0pOZlVXSTVqcDA5aGVHcU5pY3d6K1oyVmxrTVZsVGM5?=
 =?utf-8?B?aktFUXRXTklnbUpXbVpkQndLNFU0ZlpCWXg1V0xZaUtsS1QyS3B6RzJMKzVS?=
 =?utf-8?B?eXc0emE2QXZyMndZVUhBZk5xNURiOTRrZGI3MVJENnZyR2ppYTlHdW0zUy9n?=
 =?utf-8?B?ay9vMlBEa0F2U1Z0YUNtWXU2WjNEcFIxZTFYQzVWMDRkRHBuZGg0WjVZS0pu?=
 =?utf-8?B?Y0xWb29GcDJjWDI4WmQrRThOd1ZQQkpqK0VzNCtuN3FxWUtyWkZKUXV3T2Vx?=
 =?utf-8?B?M3ZuMEFPVk5EblBNUUxnTUdtdUlDMEtVOVpNdFpkQmRRZk1WSFVTTjd3Q29U?=
 =?utf-8?B?aVpjUXJQWEJyWXNCRHBDWlkrWjV6OTY1dzZmaWhGRkFNYUErNTQwazJMVVFS?=
 =?utf-8?B?aC92dXRYN1V3VW54dWw3TlAyL3B0d2xzek5UUTlHK3hMdDNlRXpoU0dXVnBO?=
 =?utf-8?B?Sk1RTUErMSt1dFBrZVdpWEtLaHU1RW5aakNTN2FJQ1VYRk5HVVlsLzdQenJB?=
 =?utf-8?B?anVYcTkrUjdLZDViR2dYWktvKzdjN2U3K05jNEI4QnJNM1JIeEY2VkN2UUZl?=
 =?utf-8?B?UVhEU0c4Q1B3enlkcWl2RUwzUi9UaHFRSElmd2lQYWxMTFpXejZzNzNMNlBQ?=
 =?utf-8?B?blE1YytJaXM2WHVjVUJhQXZYRVFoa0VJSW1JZWZETk05NDZwNkQyTnVlT0h6?=
 =?utf-8?B?TzhUUmFtdXZKWGpySGlTV1RJZzVTa2EzeFVEcXVjY0Z1VjBqbFhuM0VpM1hU?=
 =?utf-8?B?anJnemFNUHJRWlFjc3g5czY4ampkT1Fpb1JxYUx0alc5eklVT1JLaEV3c2hp?=
 =?utf-8?B?aEdnMzJXWVNHZXc5ZHZsSGQ0b1NRVWlFSE9qQXVLRDBKSEhhYmFrZ09QWXpa?=
 =?utf-8?B?c3RDN0FuSDdMRU5qeWRNWjVmNGR6czlNbWFVMjdGU2NWSUtpSWo4WXF1a1Zu?=
 =?utf-8?B?WVFWR01iR3hrTk9MQzNxSjZFc3FMVjBocnVFTzU0SlRhUVJwNVhFTVhSOUpi?=
 =?utf-8?B?aHhnOXNjc05VYnF4RlJjR2FBaERTaGdOSFZRdlBxb3dGRjhQdU1qVmoybVdT?=
 =?utf-8?B?cWVoZFhmSStTTnV0ekNkOStrdVFSY0h1YTVMZU56enpWRXk1L3p5SG5LVU8w?=
 =?utf-8?B?R0dtOThneFM4Y0tiZ3M0SW91TmR2WUZJOFZmQno4NGcwejVwOEpYTDBHU0FD?=
 =?utf-8?B?TEREL0Y3VEkwanVuelk0ekdUWkpST3JGZlpLM1o5NHFRYW1WWlp4Wk45WitG?=
 =?utf-8?B?MkxJdkV2TzdZVngyRlFDMEdlclBYU2NYZXRrMzNZN3poUVQxRFltWkJMclpm?=
 =?utf-8?B?amFNVzc5OW9vSFNUMnFFMWhjWXdzUldyWnNIcGxZVGZEQlR6dVhWVVNQZ1Vk?=
 =?utf-8?B?QUdFa3A0R0tGTUZKZjFGeXNneGVEWnZMajlnWUViSzM5ZEJhNVBuTWI3UE1i?=
 =?utf-8?B?ZExBV0ZtMXE1VkkvNEJzODhRblNHdVRDMDlPTThqV0tVZ2lIQXNxYUVOTllq?=
 =?utf-8?B?a1hLWW1NUWJrUjY2T3hLQnExeGRqNy8zblg3eWhxWVdIdVRPelUwbko3Mjl2?=
 =?utf-8?B?TFNoZEdIaXk4VlorZDkveTV4ekVWVHNRWGc1MEZ3c1BjTWJWaWR1UTdCdS91?=
 =?utf-8?B?b2hZS2FPUTRISGZCYm9YYTVTNVlKa1J5OGJ6U2hMYzA5NE5COXN3dVVXbHhs?=
 =?utf-8?B?YlExS0p6SXBGelpxR240QmgyNHJ3cVFIdy9ZNFBRQmo0SURYcmlPbi83citV?=
 =?utf-8?B?TllWVktLK1lvOCs3ZmxXR3psY1IyRDEzcldUVzZISWtxMUN1QjFIUDJZV0Yx?=
 =?utf-8?B?cEovZlJpRmVsSWJaNXM1U0Y2OGlCSFJzS2h6L3IyQUZqQkNrNXBTS3hhMENW?=
 =?utf-8?B?Y0ZQK3g5Uk9GcEVkb2V2QmNhTzRiVFpwUHd5QWR5Y0hnZGJ6R2p4Y0hDOGwy?=
 =?utf-8?B?UGxhdHlHLzc0ZFZNTUlCd3ptNmNET0hKQkNPdGJIekJPNUJVMXM1RHpoTmsy?=
 =?utf-8?Q?TEVH27utfg/dJqKI2D+S41MxD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FAW5FxAYLgG8MS+1kGMnlr7F/L2DBDuhJ0SP6BGdec0kpKztf4rGlIUYEpt/L3GI3sOeDQ7ex7qWEdRG2BB7uP+BvFYiPorjYsB5M7JMnTUiQxKp/51Y0cbngpqGTaHNNpYNGSm/d9ypOzBA+GKEjjFlj33NLgX5oH5BD7Hk3o9NJyCHoF7KuO6UnbmrVJ7QlEBVOF5Q33ylqKGKJ/TsRluQIY5j6WawArX7/5ZY1TyAqVjotbk3EE5QE13eS6oqo6jzA0KTC8Zs2fJZ3fRRchh5l3in52APtH2T60IvF06JE23btUsIwmhF/Mv56x9L3qNZpRpqXurecvphYI1uoh4eqdwVFi8VZe4r+GSp09EheoBEAUdUnB9a4R7HwIjHo7kD9qIK9iZBJnNArxvHb8QTndjHMACOgXlm6TBVbCJps1ifhI9mcwW8qrzukIQxqx+dZu1N2qNQKDR5yM3vvJeGRJk7ZIeBnmLNORIdnz6UvA5rt82/dxJgoJ3fl8rVrtTqJIyM75b7DxDYdcHDHmG3aw8RP1mQuzQiesIx5InZ5cmAD1aCkvzN1y/fRYdaLEyQh9PM4uOKc8YFD02eC9s3WsfVbhW8QQTG7Y+zmA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce193a-ac01-418b-b29b-08dda516446d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 16:22:01.4796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IS+DaUrRzKQ5+/9jpmDTU9SQqqjRmVPUlxV5K4G3NY7N+8zV7Oppxz+mWPt3YUaM+y8ymfzJc6EHRvHFICUEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060143
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=684315ae b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=p_4QU5vNXezN15V6ZOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZiMIAIO6AAAA:8
 a=41g0X3kjVq8E-Y2vLjAA:9
 a=ZbHWSrVHvFga-G1N:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=KohFQSMcaiS2QNUyYz07:22 cc=ntf awl=host:13207
X-Proofpoint-GUID: nXiLTfNd3p1xM74xQA9NsSrNHf78v0zo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE0MyBTYWx0ZWRfX4LKhIY3uK0zm
 7aYjLd/Op0YUWFgEenmcjMoGjfSXW3tDnrZwOSHocQfouHdO2uEmpW9N5685RIqZHrj4qjzVWj/
 pXRBzC10MNf9S6BuAqmWvuX2aZHDhROmmNyxmBxhC/DqdgU4INpcolP29ULtKJzjKDpHdYB49NQ
 CQU/RERJ23E/98d91h7/Wi1gkXRR6kMzByfg/NImpDdGXMmMa8Dr/0kMJ+TclR7CI/ZPA7NQXah
 YGqR2uRONfLI1UNqiBiWlWrTUNlb8eVYFj3X6Z0lJ86SxNuAfmTFWQ4fbpQZTjvsFJalmebWoWJ
 mSEUZKWzpTbPxdtVipY8MrSxHrmqWWds/4T/Y3Kvir77spu8qiSYu1qgwpDowmYcUTFeGvXyJXG
 IPCThNe0SvAUeUiaVwWUv+Z2FrH/gTIIdu2NZQyNjY1F5wVYCK0W/l6u0zmtCKFCaZjI9Nao
X-Proofpoint-ORIG-GUID: nXiLTfNd3p1xM74xQA9NsSrNHf78v0zo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------jgqvomhN5UK4CknRbfgGa61v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/2/25 4:29 AM, Markus Armbruster wrote:
> Butterfingers...  let's try this again.
>
> Markus Armbruster<armbru@redhat.com> writes:
>
>> Si-Wei Liu<si-wei.liu@oracle.com> writes:
>>
>>> On 5/26/2025 2:16 AM, Markus Armbruster wrote:
>>>> Si-Wei Liu<si-wei.liu@oracle.com> writes:
>>>>
>>>>> On 5/15/2025 11:40 PM, Markus Armbruster wrote:
>>>>>> Jason Wang<jasowang@redhat.com> writes:
>>>>>>
>>>>>>> On Thu, May 8, 2025 at 2:47 AM Jonah Palmer<jonah.palmer@oracle.com> wrote:
>>>>>>>> Current memory operations like pinning may take a lot of time at the
>>>>>>>> destination.  Currently they are done after the source of the migration is
>>>>>>>> stopped, and before the workload is resumed at the destination.  This is a
>>>>>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>>>>>> (downtime).
>>>>>>>>
>>>>>>>> We can do better as we know the memory layout of the guest RAM at the
>>>>>>>> destination from the moment that all devices are initializaed.  So
>>>>>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>>>>>> while the workload is still running in the source, so Linux can start
>>>>>>>> mapping them.
>>>>>>>>
>>>>>>>> As a small drawback, there is a time in the initialization where QEMU
>>>>>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>>>>>> 0.2seconds.
>>>>>>> Adding Markus to see if this is a real problem or not.
>>>>>> I guess the answer is "depends", and to get a more useful one, we need
>>>>>> more information.
>>>>>>
>>>>>> When all you care is time from executing qemu-system-FOO to guest
>>>>>> finish booting, and the guest takes 10s to boot, then an extra 0.2s
>>>>>> won't matter much.
>>>>> There's no such delay of an extra 0.2s or higher per se, it's just shifting around the page pinning hiccup, no matter it is 0.2s or something else, from the time of guest booting up to before guest is booted. This saves back guest boot time or start up delay, but in turn the same delay effectively will be charged to VM launch time. We follow the same model with VFIO, which would see the same hiccup during launch (at an early stage where no real mgmt software would care about).
>>>>>
>>>>>> When a management application runs qemu-system-FOO several times to
>>>>>> probe its capabilities via QMP, then even milliseconds can hurt.
>>>>>>
>>>>> Not something like that, this page pinning hiccup is one time only that occurs in the very early stage when launching QEMU, i.e. there's no consistent delay every time when QMP is called. The delay in QMP response at that very point depends on how much memory the VM has, but this is just specif to VM with VFIO or vDPA devices that have to pin memory for DMA. Having said, there's no extra delay at all if QEMU args has no vDPA device assignment, on the other hand, there's same delay or QMP hiccup when VFIO is around in QEMU args.
>>>>>
>>>>>> In what scenarios exactly is QMP delayed?
>>>>> Having said, this is not a new problem to QEMU in particular, this QMP delay is not peculiar, it's existent on VFIO as well.
>>>> In what scenarios exactly is QMP delayed compared to before the patch?
>>> The page pinning process now runs in a pretty early phase at
>>> qemu_init() e.g. machine_run_board_init(),
>> It runs within
>>
>>      qemu_init()
>>          qmp_x_exit_preconfig()
>>              qemu_init_board()
>>                  machine_run_board_init()
>>
>> Except when --preconfig is given, it instead runs within QMP command
>> x-exit-preconfig.
>>
>> Correct?
>>
>>> before any QMP command can be serviced, the latter of which typically
>>> would be able to get run from qemu_main_loop() until the AIO gets
>>> chance to be started to get polled and dispatched to bh.
>> We create the QMP monitor within qemu_create_late_backends(), which runs
>> before qmp_x_exit_preconfig(), but commands get processed only in the
>> main loop, which we enter later.
>>
>> Correct?
>>
>>> Technically it's not a real delay for specific QMP command, but rather
>>> an extended span of initialization process may take place before the
>>> very first QMP request, usually qmp_capabilities, will be
>>> serviced. It's natural for mgmt software to expect initialization
>>> delay for the first qmp_capabilities response if it has to immediately
>>> issue one after launching qemu, especially when you have a large guest
>>> with hundred GBs of memory and with passthrough device that has to pin
>>> memory for DMA e.g. VFIO, the delayed effect from the QEMU
>>> initialization process is very visible too.
> The work clearly needs to be done.  Whether it needs to be blocking
> other things is less clear.
>
> Even if it doesn't need to be blocking, we may choose not to avoid
> blocking for now.  That should be an informed decision, though.
>
> All I'm trying to do here is understand the tradeoffs, so I can give
> useful advice.
>
>>>                                              On the other hand, before
>>> the patch, if memory happens to be in the middle of being pinned, any
>>> ongoing QMP can't be serviced by the QEMU main loop, either.
> When exactly does this pinning happen before the patch?  In which
> function?

Before the patches, the memory listener was registered in
vhost_vdpa_dev_start(), well after device initialization.

And by device initialization here I mean the
qemu_create_late_backends() function.

With these patches, the memory listener is now being
registered in vhost_vdpa_set_owner(), called from
vhost_dev_init(), which is part of the device
initialization phase.

However, even though the memory_listener_register() is
called during the device initialization phase, the actual
pinning happens (very shortly) after
qemu_create_late_backends() returns (due to RAM being
initialized later).

---

So, without these patches, and based on my measurements,
memory pinning starts ~2.9s after qemu_create_late_backends()
returns.

With these patches, memory pinning starts ~0.003s after
qemu_create_late_backends() returns.

>>> I'd also like to highlight that without this patch, the pretty high
>>> delay due to page pinning is even visible to the guest in addition to
>>> just QMP delay, which largely affected guest boot time with vDPA
>>> device already. It is long standing, and every VM user with vDPA
>>> device would like to avoid such high delay for the first boot, which
>>> is not seen with similar device e.g. VFIO passthrough.
> I understand that hiding the delay from the guest could be useful.
>
>>>>> Thanks,
>>>>> -Siwei
>>>>>
>>>>>> You told us an absolute delay you observed.  What's the relative delay,
>>>>>> i.e. what's the delay with and without these patches?
>>>> Can you answer this question?
>>> I thought I already got that answered in earlier reply. The relative
>>> delay is subject to the size of memory. Usually mgmt software won't be
>>> able to notice, unless the guest has more than 100GB of THP memory to
>>> pin, for DMA or whatever reason.
> Alright, what are the delays you observe with and without these patches
> for three test cases that pin 50 / 100 / 200 GiB of THP memory
> respectively?

So with THP memory specifically, these are my measurements below.
For these measurements, I simply started up a guest, traced the
vhost_vdpa_listener_region_add() calls, and found the difference
in time between the first and last calls. In other words, this is
roughly the time it took to pin all of guest memory. I did 5 runs
for each memory size:

Before patches:
===============
50G:   7.652s,  7.992s,  7.981s,  7.631s,  7.953s (Avg.  7.841s)
100G:  8.990s,  8.656s,  9.003s,  8.683s,  8.669s (Avg.  8.800s)
200G: 10.705s, 10.841s, 10.816s, 10.772s, 10.818s (Avg. 10.790s)

After patches:
==============
50G:  12.091s, 11.685s, 11.626s, 11.952s, 11.656s (Avg. 11.802s)
100G: 14.121s, 14.079s, 13.700s, 14.023s, 14.130s (Avg. 14.010s)
200G: 18.134s, 18.350s, 18.387s, 17.800s, 18.401s (Avg. 18.214s)

The reason we're seeing a jump here may be that with the memory
pinning happening earlier, the pinning happens before Qemu has
fully faulted in the guest's RAM.

As far as I understand, before these patches, by the time we
reached vhost_vdpa_dev_start(), all pages were already resident
(and THP splits already happened with the prealloc=on step), so
get_user_pages() pinned "warm" pages much faster.

With these patches, the memory listener is running on cold memory.
Every get_user_pages() call would fault in its 4KiB subpage (and
if THP was folded, split a 2MiB hugepage) before handing in a
'struct page'.

I believe this to be the case since in my measurements I noticed
some larger time gaps (fault + split overhead) in between some of
the vhost_vdpa_listener_region_add() calls.

However I'm still learning some of these memory pinning details,
so please let me know if I'm misunderstanding anything here.

Jonah

>>>>>> We need QMP to become available earlier in the startup sequence for
>>>>>> other reasons.  Could we bypass the delay that way?  Please understand
>>>>>> that this would likely be quite difficult: we know from experience that
>>>>>> messing with the startup sequence is prone to introduce subtle
>>>>>> compatility breaks and even bugs.
>>>>>>
>>>>>>> (I remember VFIO has some optimization in the speed of the pinning,
>>>>>>> could vDPA do the same?)
>>>>>> That's well outside my bailiwick :)
>>> Please be understood that any possible optimization is out of scope of
>>> this patch series, while there's certainly way around that already and
>>> to be carry out in the future, as Peter alluded to in earlier
>>> discussion thread:
>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/ZZT7wuq-_IhfN_wR@x1n/__;!!ACWV5N9M2RV99hQ!Kf05aVONsyUTIqQv0RRYw5IaU2V4k0KB6Fur5X_ocHbuT0SQV-xMr4tjggz6NJ4qgkUfONJVoswPoECB$ 
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/ZZZUNsOVxxqr-H5S@x1n/__;!!ACWV5N9M2RV99hQ!Kf05aVONsyUTIqQv0RRYw5IaU2V4k0KB6Fur5X_ocHbuT0SQV-xMr4tjggz6NJ4qgkUfONJVovdnMan-$ 
> Got it.
>
>>> Thanks,
>>> -Siwei
>>>
>>>>>> [...]
>>>>>>
--------------jgqvomhN5UK4CknRbfgGa61v
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/2/25 4:29 AM, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8734cimtqa.fsf@pond.sub.org">
      <pre wrap="" class="moz-quote-pre">Butterfingers...  let's try this again.

Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 5/26/2025 2:16 AM, Markus Armbruster wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> writes:

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On 5/15/2025 11:40 PM, Markus Armbruster wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a> writes:

</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">On Thu, May 8, 2025 at 2:47 AM Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a> wrote:
</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.
</pre>
                  </blockquote>
                  <pre wrap="" class="moz-quote-pre">Adding Markus to see if this is a real problem or not.
</pre>
                </blockquote>
                <pre wrap="" class="moz-quote-pre">I guess the answer is &quot;depends&quot;, and to get a more useful one, we need
more information.

When all you care is time from executing qemu-system-FOO to guest
finish booting, and the guest takes 10s to boot, then an extra 0.2s
won't matter much.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">
There's no such delay of an extra 0.2s or higher per se, it's just shifting around the page pinning hiccup, no matter it is 0.2s or something else, from the time of guest booting up to before guest is booted. This saves back guest boot time or start up delay, but in turn the same delay effectively will be charged to VM launch time. We follow the same model with VFIO, which would see the same hiccup during launch (at an early stage where no real mgmt software would care about).

</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">When a management application runs qemu-system-FOO several times to
probe its capabilities via QMP, then even milliseconds can hurt.

</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">Not something like that, this page pinning hiccup is one time only that occurs in the very early stage when launching QEMU, i.e. there's no consistent delay every time when QMP is called. The delay in QMP response at that very point depends on how much memory the VM has, but this is just specif to VM with VFIO or vDPA devices that have to pin memory for DMA. Having said, there's no extra delay at all if QEMU args has no vDPA device assignment, on the other hand, there's same delay or QMP hiccup when VFIO is around in QEMU args.

</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">In what scenarios exactly is QMP delayed?
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">
Having said, this is not a new problem to QEMU in particular, this QMP delay is not peculiar, it's existent on VFIO as well.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">
In what scenarios exactly is QMP delayed compared to before the patch?
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
The page pinning process now runs in a pretty early phase at
qemu_init() e.g. machine_run_board_init(),
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
It runs within

    qemu_init()
        qmp_x_exit_preconfig()
            qemu_init_board()
                machine_run_board_init()

Except when --preconfig is given, it instead runs within QMP command
x-exit-preconfig.

Correct?

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">before any QMP command can be serviced, the latter of which typically
would be able to get run from qemu_main_loop() until the AIO gets
chance to be started to get polled and dispatched to bh.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
We create the QMP monitor within qemu_create_late_backends(), which runs
before qmp_x_exit_preconfig(), but commands get processed only in the
main loop, which we enter later.

Correct?

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Technically it's not a real delay for specific QMP command, but rather
an extended span of initialization process may take place before the
very first QMP request, usually qmp_capabilities, will be
serviced. It's natural for mgmt software to expect initialization
delay for the first qmp_capabilities response if it has to immediately
issue one after launching qemu, especially when you have a large guest
with hundred GBs of memory and with passthrough device that has to pin
memory for DMA e.g. VFIO, the delayed effect from the QEMU
initialization process is very visible too.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The work clearly needs to be done.  Whether it needs to be blocking
other things is less clear.

Even if it doesn't need to be blocking, we may choose not to avoid
blocking for now.  That should be an informed decision, though.

All I'm trying to do here is understand the tradeoffs, so I can give
useful advice.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">                                            On the other hand, before
the patch, if memory happens to be in the middle of being pinned, any
ongoing QMP can't be serviced by the QEMU main loop, either.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
When exactly does this pinning happen before the patch?  In which
function?
</pre>
    </blockquote>
    <pre>Before the patches, the memory listener was registered in
vhost_vdpa_dev_start(), well after device initialization.

And by device initialization here I mean the
qemu_create_late_backends() function.

With these patches, the memory listener is now being
registered in vhost_vdpa_set_owner(), called from
vhost_dev_init(), which is part of the device
initialization phase.

However, even though the memory_listener_register() is
called during the device initialization phase, the actual
pinning happens (very shortly) after
qemu_create_late_backends() returns (due to RAM being
initialized later).

---

So, without these patches, and based on my measurements,
memory pinning starts ~2.9s after qemu_create_late_backends()
returns.

With these patches, memory pinning starts ~0.003s after
qemu_create_late_backends() returns.
</pre>
    <blockquote type="cite" cite="mid:8734cimtqa.fsf@pond.sub.org">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I'd also like to highlight that without this patch, the pretty high
delay due to page pinning is even visible to the guest in addition to
just QMP delay, which largely affected guest boot time with vDPA
device already. It is long standing, and every VM user with vDPA
device would like to avoid such high delay for the first boot, which
is not seen with similar device e.g. VFIO passthrough.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I understand that hiding the delay from the guest could be useful.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Thanks,
-Siwei

</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">You told us an absolute delay you observed.  What's the relative delay,
i.e. what's the delay with and without these patches?
</pre>
              </blockquote>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">
Can you answer this question?
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
I thought I already got that answered in earlier reply. The relative
delay is subject to the size of memory. Usually mgmt software won't be
able to notice, unless the guest has more than 100GB of THP memory to
pin, for DMA or whatever reason.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Alright, what are the delays you observe with and without these patches
for three test cases that pin 50 / 100 / 200 GiB of THP memory
respectively?
</pre>
    </blockquote>
    <pre>So with THP memory specifically, these are my measurements below.
For these measurements, I simply started up a guest, traced the
vhost_vdpa_listener_region_add() calls, and found the difference
in time between the first and last calls. In other words, this is
roughly the time it took to pin all of guest memory. I did 5 runs
for each memory size:

Before patches:
===============
50G:   7.652s,  7.992s,  7.981s,  7.631s,  7.953s (Avg.  7.841s)
100G:  8.990s,  8.656s,  9.003s,  8.683s,  8.669s (Avg.  8.800s)
200G: 10.705s, 10.841s, 10.816s, 10.772s, 10.818s (Avg. 10.790s)

After patches:
==============
50G:  12.091s, 11.685s, 11.626s, 11.952s, 11.656s (Avg. 11.802s)
100G: 14.121s, 14.079s, 13.700s, 14.023s, 14.130s (Avg. 14.010s)
200G: 18.134s, 18.350s, 18.387s, 17.800s, 18.401s (Avg. 18.214s)

The reason we're seeing a jump here may be that with the memory
pinning happening earlier, the pinning happens before Qemu has
fully faulted in the guest's RAM.

As far as I understand, before these patches, by the time we
reached vhost_vdpa_dev_start(), all pages were already resident
(and THP splits already happened with the prealloc=on step), so
get_user_pages() pinned &quot;warm&quot; pages much faster.

With these patches, the memory listener is running on cold memory.
Every get_user_pages() call would fault in its 4KiB subpage (and
if THP was folded, split a 2MiB hugepage) before handing in a
'struct page'.

I believe this to be the case since in my measurements I noticed
some larger time gaps (fault + split overhead) in between some of
the vhost_vdpa_listener_region_add() calls.

However I'm still learning some of these memory pinning details,
so please let me know if I'm misunderstanding anything here.

Jonah
</pre>
    <blockquote type="cite" cite="mid:8734cimtqa.fsf@pond.sub.org">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">We need QMP to become available earlier in the startup sequence for
other reasons.  Could we bypass the delay that way?  Please understand
that this would likely be quite difficult: we know from experience that
messing with the startup sequence is prone to introduce subtle
compatility breaks and even bugs.

</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">(I remember VFIO has some optimization in the speed of the pinning,
could vDPA do the same?)
</pre>
                </blockquote>
                <pre wrap="" class="moz-quote-pre">
That's well outside my bailiwick :)
</pre>
              </blockquote>
            </blockquote>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
Please be understood that any possible optimization is out of scope of
this patch series, while there's certainly way around that already and
to be carry out in the future, as Peter alluded to in earlier
discussion thread:

<a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/ZZT7wuq-_IhfN_wR@x1n/__;!!ACWV5N9M2RV99hQ!Kf05aVONsyUTIqQv0RRYw5IaU2V4k0KB6Fur5X_ocHbuT0SQV-xMr4tjggz6NJ4qgkUfONJVoswPoECB$">https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/ZZT7wuq-_IhfN_wR@x1n/__;!!ACWV5N9M2RV99hQ!Kf05aVONsyUTIqQv0RRYw5IaU2V4k0KB6Fur5X_ocHbuT0SQV-xMr4tjggz6NJ4qgkUfONJVoswPoECB$</a> 
<a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/ZZZUNsOVxxqr-H5S@x1n/__;!!ACWV5N9M2RV99hQ!Kf05aVONsyUTIqQv0RRYw5IaU2V4k0KB6Fur5X_ocHbuT0SQV-xMr4tjggz6NJ4qgkUfONJVovdnMan-$">https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/ZZZUNsOVxxqr-H5S@x1n/__;!!ACWV5N9M2RV99hQ!Kf05aVONsyUTIqQv0RRYw5IaU2V4k0KB6Fur5X_ocHbuT0SQV-xMr4tjggz6NJ4qgkUfONJVovdnMan-$</a> 
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Got it.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Thanks,
-Siwei

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">
[...]

</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------jgqvomhN5UK4CknRbfgGa61v--

