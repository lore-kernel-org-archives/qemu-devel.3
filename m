Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B08E77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 13:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUn7e-0000cS-7i; Mon, 06 Jan 2025 08:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUn7a-0000b5-Px; Mon, 06 Jan 2025 08:26:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUn7Y-0007DR-D5; Mon, 06 Jan 2025 08:26:18 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5068tpi7003650;
 Mon, 6 Jan 2025 13:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=8WMqcwkggxgx3ocRfQw8WeLu/f4rt0YcHe9LnWO4Bdw=; b=
 FryKpjSDL3P45oodBcDtoCelSH3/6dUDL+8LJUzM9MofOFnLUQia2Tv3jYgcG7zs
 u2A2UnTHcFvUKw5RzGTSr5p88PY02de1zIZg7vnXVUqE7aVjL8oxLKVsaGNmEDhR
 HLpVSHRUWTmMpziE9XOcTjC0WyAbVaJ/oOpnTFNPZfOMrY10a8bCWVjFuknengGP
 +6yeDamWIpovC80fr4ec+KGqzR+GrtA5EGz6EwExbpLXNSRb2xCWb8HQ33iXKYmi
 TbOHTcg/VE5rEnDNMJZeRcbVqj1LWVOW1OZZVPcgtwiAtxGX+4tA2EUZPA09VjAe
 Lt6/gtrGyQMYudYikqBxxw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb2j92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 13:26:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 506D16hc027471; Mon, 6 Jan 2025 13:26:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue7h1aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 13:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu6auxLHsYP5GeByMPjVrRr465ad1OQdOA4I2+3EvW0JfAM+HnAPKpq1XsKTOKEWXxqsk5eSz6Zm6PPc3GBi6vX+G/r8ZQNZE0DjvjHFIYELnSXAZWkDMGUQwwUVI/JYl/a554YYY3inzYq/srcvFbtCNvBsG1Ko4os1H5W1MditQU9cigFAGZ85iAi93iY579h/cxmEY1VHUpmHtwuy+Gb2wxkSNnrLBFRrxCA74ppEgwPhVqveqbhSdcx4mD4+MMzDFdYfZNTGuNNJnTo+1Ay9UGXkryNwoJCUBFYviD8wXzNAsZHjSsb2QP16or6MWc9OR4iuRVYcG7QgUivnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WMqcwkggxgx3ocRfQw8WeLu/f4rt0YcHe9LnWO4Bdw=;
 b=wpzH+oeoPKn0bBKkUKt5FZs4NVUW1IDDIDFx1Zzm+RgdhM30GQZMS0ajTX3sP3b8p0U1SCQ6XkT1EZV/Yc2xfv6tIYmZHDXE+KoQAe+eeWh6Qx84ftIiQ4bPU2/qE/jXvpCsrtAVhDobz1X+c8NRd0vEBiINSijH46XQcNKXooVGGE27vNyNYrXpzv3Fl4Wl4nKfQrwIGk041NIXg6rG2eOofbmhyMvQBVSrr1ZM+UtMpPuRDrS0US0bl+s08FxYrs2BLZnwSnE19SQRHbQRPZ3ybWzKA6tdpRgXSwtxQ4HQvxDO2+EVz84SroTP2f/vtkffwK/gJwCfDwjH2kmj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WMqcwkggxgx3ocRfQw8WeLu/f4rt0YcHe9LnWO4Bdw=;
 b=L4jodTtzmLw29t5M02XRFX1o6BFyBzvx2F3UooFM7EW7wbO1WdYrmYPLxn6Np/vO7ANLMBkJsPZmzQpWt5uEzxqh1UmD3lHp00WA/8EFhiCjhoUMdYoPfw7+YGs9t7vUjSgQ4kSQN1bkLGtGlQZhYYaIPGPuYMPQ8iWA6bQosSI=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CYXPR10MB7973.namprd10.prod.outlook.com (2603:10b6:930:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 13:26:03 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 13:26:03 +0000
Message-ID: <511cf8f8-03ea-4375-abe0-317ac3131b1d@oracle.com>
Date: Mon, 6 Jan 2025 08:25:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmp: update vhost-user protocol feature maps
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, aesteve@redhat.com,
 hreitz@redhat.com
References: <20241216170914.1346403-1-lvivier@redhat.com>
 <c9341f03-ecc2-4a62-860a-35ff2b660651@oracle.com>
 <6f1dcbe9-3a7e-475b-92ef-14f1d04ffc2e@tls.msk.ru>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <6f1dcbe9-3a7e-475b-92ef-14f1d04ffc2e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0445.namprd03.prod.outlook.com
 (2603:10b6:408:113::30) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CYXPR10MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f67be8b-61c8-4fbb-4e0e-08dd2e55aacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHpKTmdCWEdxbUlCaWpBZDEvNjBGVEZNTjkvUml2Q3g2czVCRDZGYjlsWnB1?=
 =?utf-8?B?bFBadzloWHFYZlQ5UnhOMXk2ajBnY09HK3YvajhOVnBja0pUQWpKV2FwWUtt?=
 =?utf-8?B?dFY1WnVOQjhIbFFXcWthK3pyczRoME13MExldXlQa0ZRbTE2amRqV2ZYZC9m?=
 =?utf-8?B?d0RFN1dRYlpXMUZ1c2pZVG9ic05zVFJpRnlqaXNGbXRSR2tJaktkMVhId1NZ?=
 =?utf-8?B?Sm95TUFVVTVqWFhPQW0reWg3eWlhMnBaTTRmQkVXRUFVSEc3ZkhhSVduYmx0?=
 =?utf-8?B?SU1nUHQrMXNubmJ3NW50SmRPelM2UnNoYUthZVM4RGczUTVwNzZIbUtPcU9a?=
 =?utf-8?B?Zy8wOGRUajJzeEIxVkh0aW9Jd3YzV0RVNTZya1hEZDIxS3BkQ0FWOGs1MXFW?=
 =?utf-8?B?ZjNFT2sxZUk2ZTdTVnVlOTJPeWsyWFp4VS9ZaDFhYmhrc0pqakVvb2c4T1F6?=
 =?utf-8?B?NXhoRnNCb0lXT3hFb1NQenVGL3NGVWJBOHpPZFpLUENUSGFoZjhWMHZTVktG?=
 =?utf-8?B?Qkdqd0hjOGdPYThOOUIrdTlvNExsdVh2dVA1RHJwcGlYY0M5Z3VIMVY0ZG80?=
 =?utf-8?B?UGx1VlhiMDIzUHFlTExlYis3eVluVTI0UU91bWZBendlS3U2V01HeEJYZ1Uy?=
 =?utf-8?B?M2lVdGFQM2tabjJNSTJ1MG1yVVVyQy9CdXBXV09ReHZubFVZelZiQm5IbitE?=
 =?utf-8?B?c2Z4MFpyYzdyNzRrR1ZBdno4bzJxMGRLUGh5Zlh0QXlrNWMrcElYTU40dktS?=
 =?utf-8?B?bkRoMmIxMzRtYXVFNnZsd3hNWE9ocFlLVThVUzFXdFpHYmw1QnJxa0RXRUNa?=
 =?utf-8?B?OWFXNktQVy9aUkF5dFgzMXFqTVlTUWgyYkN0ZkRxSVJFRDA5NXhEWU84Y1Vq?=
 =?utf-8?B?eUxpeS9kZnBjSmVKd2lrcUMwS082eXZzRVA1cDFYdjN4MFh4bEtWa1k4VFo4?=
 =?utf-8?B?MmpHb2tuemhybGIzcFVWcElUUUtWYUJublVza1VYaEN5Qmx1SEJqK0JRa25H?=
 =?utf-8?B?S0Vldk1zek5xNlZQb3AyTjdHZjlpSFFjbm4zaDB1OE1uYm1jcXhxYVIxa0px?=
 =?utf-8?B?bmNFZklUZlFqSUtBYVVJd2Q1ZjRUNnNEN1lwMUJpQjV6QkRVYVN2cWhNbEhQ?=
 =?utf-8?B?WkJVSTIyL2s3aDE4cTdrRjBUL1BiSnYxSm84TmVlTTRIc0dSZ1A2WDVDYVBy?=
 =?utf-8?B?b2FUdloyUDdjcGdFUVF2dzloQ0hKMzFlbEFpeE1YY0todHM2UXNCSUxhMU5H?=
 =?utf-8?B?cm52d1RKbXcwN0ViTWRuQWxqTWFDaHdsUE5XU3RZK1lOREhmNERnQzU4ZjU2?=
 =?utf-8?B?SUppYkUvRzJtS3h1VmNvVENzVXVlNWJUbWdGdGpKOE1QRHRaR3ErWVpQQmIx?=
 =?utf-8?B?elkrZDZwLzAwb2RNWnRjN215M3R4aGo3OVdQSGMzR0dPVFpBdFhseEZBUm5r?=
 =?utf-8?B?OWxNK1BRbjEvRjV4RWRQS2VFTU1tY2hma2NkSTQ2citTOWJOdXpIQnkzZG5q?=
 =?utf-8?B?NUtMeEhGOHdidzZVWENKZzZFeENaQ1RlcVJIdFI4NU16VndqZGtyOWhTZ1g2?=
 =?utf-8?B?NlBzRzM2emF4Y3Q4cGZYWDZseFR5VHQ4bWdCR1JaK2s5RFZ6U29CVEVjM0w3?=
 =?utf-8?B?NytPd1NIaHltQTRyTmsyQStIeTVMaE11aWo1UHNuOEp3dGo2cDdTYW1UWm53?=
 =?utf-8?B?UzNWYytTVUZxRVVtVFVlUXlvS0lHeVNaN1hzdFB1N1l5bzJaaU1FaTI0T0NV?=
 =?utf-8?B?dklPQ2pCS1R3YzkyeU5rLzJPa2RuVExPbURUSzUrbEI1QStLa09QeTFiSFY1?=
 =?utf-8?B?S2dWWW9CbjJQVFZ3VzlUNURnY2gyLzNWT0pieS9yTlFuNG13cTcvcldwL3BG?=
 =?utf-8?Q?PTj1J/AGKnSNy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVxU29nSnNvR1dLWnhNd2E5UHUwZGpsRHg4Qk12dG4wK0xGaEE2emk1cUs1?=
 =?utf-8?B?RVltbzFKa3IwREQrclc2L1B2TlhjSUpPaklwd2JtR1lnVk1TUWFnNjJWNUJY?=
 =?utf-8?B?R3hoS3psNE5ETXUrNTA2d2VLdE5SUFk1akdqeTBWTG5pRHFaYTduT0U3TUN6?=
 =?utf-8?B?NlNRdkU2MGF1VVpjZWNZV0YvR3VSbENodW5VMWg0ZnNxMXYzdm45Rmk5UlBy?=
 =?utf-8?B?cStuOEIzNzBxU01UUFgrcnhCT25YaUJLdkpNb3ArdWROK0dBUU1rOGM3eC9r?=
 =?utf-8?B?bmFvcDV3VGJEV1YzbE1odXU5cThWc2ZpQWk1anhzUXUrK1NkWnFQdEpyZkdD?=
 =?utf-8?B?MlhJMVZ2NlZUSmZNTHVnNW5wUEc2MXRvWjBiUXRpOTJMSmhXQWJMd2oyRlgy?=
 =?utf-8?B?eUhlVjhaK29uVERGQTJIU25BRlhmYzZsWDRmWG14M0UvK08rZmgzQm9lWFM4?=
 =?utf-8?B?Y3dWcDVldzdSTEk1NXFDOHRCK3VrL01iVXVlaWxYanBBaXhqZGRzVlg5V2hY?=
 =?utf-8?B?T21MRjlEMDZRZGt5Y3Q5c0ZpRVVSTG5hOVhkeEcvdDhkTUpiMVZ2cjBFV3F6?=
 =?utf-8?B?WXJuN2huRXBDcjg1d1I0Q0RtTFg2cGtQNEVpRzJBK0E4ZWlWOUN1cytHYWFK?=
 =?utf-8?B?RHBBMnE4Mk1WdWlPaTNQZ3MxMnoxK0poNnZvQVkwMlZWemVqR1Uyb3ZVR1ZR?=
 =?utf-8?B?cVJHUyttbS9XOXhSa0JhUldGRHlOQzhvVTlnQlVXb0Y1dG03ZTdrckVaSU1n?=
 =?utf-8?B?TDZEamtYbmhrQ2RNUUIyK3psTU9ISi9VUzU1TWZOQzJsQk9NWjNrUHNBenRW?=
 =?utf-8?B?ZVluYnlMOHUyazBmc3ptc0VjWFZlQklodHAvV0JXQ3J5dzRIeXhrQWhJc0FH?=
 =?utf-8?B?WEIxc1VMVjc2TEZwK0JVVlBiNEJzZCtzQTAyb05BYjE0QkhNSEZPVkYvU3Nw?=
 =?utf-8?B?bjJlL25HRFRkaWJkUDE0ZytuZWZmdVVSN1dmRlJSL2pYMFR6M0trYkZUMzV3?=
 =?utf-8?B?YldCK2VZbGhneEdPN0MwUWR0ZDFDdlBNY2JMWjVvbUVpS2xUZFZQZ0xwc1c0?=
 =?utf-8?B?OFNxVEtRcTd2VFZyWWQ2ejdnL1VUVFNsTG1JVE5ZeG1NWnJ3ZG9TOUs5ckha?=
 =?utf-8?B?cUlWWEllVVpoUDlFUVg3eG9vc0t4dmxKdzQ5dFR1SG9MNEoyN0dkczB3WUdv?=
 =?utf-8?B?a1FDdW9ZbllmUm05cmsxdkVhSy8wck52Sm1FelczNmlaelp3L0lUdkYxNVBK?=
 =?utf-8?B?NUJPdHRoNXJRMXBqeWZhU1hja0F1Skxzc1VQaC85ZVRwZnRaV012a2hxU0la?=
 =?utf-8?B?YkhYYjMvWmZsZzR0RTZyNzNJK2haSnB5QzZPRmRXT3RVZ2VMRGFxR1BqbW9T?=
 =?utf-8?B?NUJhemd5VGwrc0VOTm5Beis1MG5TNC91NmxYSW5OY2R5aDlDU2Z2dkh1cUdH?=
 =?utf-8?B?NFhBYnhHZ2RpcSt4N0ZSVEp6NnFPWlNmYzBEby9JZ3pURFRQYS9wQzEzblND?=
 =?utf-8?B?aVNrU0p2WnlURUNWdEdHOGpVNE4vYmFCa3Fmcjg1OEZwdTcxNGt6ZmtVMStL?=
 =?utf-8?B?VmxEVFRUelZNQ3NsRVFhVDc2SS80KzJUbjhQMHVJMDQzY3pBVXRwczA0d25p?=
 =?utf-8?B?dlEyLzIzSnc2VXB3UXU2dDNPZXk2VmFtSkpIZnY4Q2dhUVpySWZWTXVOSHFL?=
 =?utf-8?B?WEdHbG1KeW9VSEtHdUVxeFlBVjhLSWN6bVBnNG5QYllSSVc1dERuSkRGOVcr?=
 =?utf-8?B?SUwxRjBEZzh2NWhQY28zblBibnNHMC8zVlp3clJkZDkvOEhiMjQ3elIrQ1Fl?=
 =?utf-8?B?emlDZjFOVEZKQXBTNHgyV3d5QWhrZHJQNUo0TUR3cFpteTdDam1Pb0s3RjNx?=
 =?utf-8?B?c1ZQc0JCbnNzdVlwc1VJK0pyTnJoSDdxdXFtTDIwSStWbEp0WGNiSElMczlq?=
 =?utf-8?B?Wlp5ck5yUWZWOFBGZDBPTzZOZitaYkVFQithRG43WjlYaXN3bkhFTGNSb0pP?=
 =?utf-8?B?dERXTVM4YzhxZXcwY2dtSHJleS81RU40dURlMmpucjFiemJoZU5IR2laV3Zu?=
 =?utf-8?B?bEdIZENqWUMxOUxpSVh6N3ZKdE96REV4UCszbm1QUHJuTGJkaWthR1doUGhK?=
 =?utf-8?B?M1Y0SFJNZWg5dEFGclF4SUhmYXlxMnViTDdjcTczb2pQaEhIWHVxTGd2T1VC?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rp+w5nWvD5pCnB+U+IbG+Uu/Q0Qtw8Ydyu0XPx9HYimb5vg+x8qzh1fQmNH+JJqPo4sEMPbVUImIUm1AsO/EN0K22q0ls4FtRt6d53zS5iM6uddgzTnrT+IRIeqYIXM8G2pQCv6nQLVy5qDJcHcpIkN9R/4eCOVy8X2hpTQeP4j9LUGT1qQm0rdp0LpZcViLLWWEkND208WH6rVFlIywBuMn/e8oxY/v90tJL19K/S9onVCn91frgFCepKktkEO8cT52BrLFVZTuAPwHHi3M0E+c/WG1naB9sxs19Fvov2zIrFnXttWB4z2+lIf+2lyBfjGTWXVTBb0F+Supx0bq/XSqk7k7t0wzE5aWGaSxX3QA1TeZ6c7U/OPeejVvN2SRem13IY+WcERjW6NNickxvySkiOP1hE/MPwIQao9YaOdU+v3BNmONCmGB4m8NIHgQXwqElOW8PxLOJ+VACl4Uf+55VkZZ0yFbV1IYZ8mNtbyQgKCg2gissPX7k3lR7kWFgog+jGX+/FWJAJWMrSIeegmXDWhQFxWHeH3HXsLrLN0nOMWyHJgbY6UpH8bFEDZZ1rziRxTXJOZ8kvjGf7E4DLc5iL3lrpPOJ/OY2j8BD+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f67be8b-61c8-4fbb-4e0e-08dd2e55aacf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 13:26:03.2358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y+iO01mVBTIh0LiP0qzFzWBu+JsYnOU/4iKY0h1yfGlE6hPfhsATibelFMFLGLvXKNEzw1HNDCAczocQXH8RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060119
X-Proofpoint-GUID: SPqgDjhweLF1s_sJEY4wGNrvEOiNY6ss
X-Proofpoint-ORIG-GUID: SPqgDjhweLF1s_sJEY4wGNrvEOiNY6ss
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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



On 12/22/24 4:13 AM, Michael Tokarev wrote:
> 16.12.2024 20:30, Jonah Palmer wrote:
> ...
> 
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> Should this be a Reviewed-by instead?
> 
> Thanks,
> 
> /mjt

Oof, yes, it should've been. My apologies, I was on vacation and only 
saw this just now.


