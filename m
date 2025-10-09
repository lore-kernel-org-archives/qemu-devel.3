Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429A8CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wdd-0006UN-0s; Thu, 09 Oct 2025 15:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v6wda-0006U6-Sd
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:49:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v6wdT-00045L-2M
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:49:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GBx7P009295;
 Thu, 9 Oct 2025 16:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=98ve4+19bDZmXQHRve8vXe36TdE9Ah5VEGk4hDApkcc=; b=
 T7YL6HAgNPNBPc3DyUAoBIEdymtfDuNWvxp2M7qds5/QSGgYvxYwcgbFakUmoUmf
 5+tBTQ6eivYL7svAPOf6nF7fLzUI/h55dTt7MODDMKU7rfqKP3/lQ/v9rDvW1CuJ
 ykEzzZL/3pzpOzNzHNWXUrZAvD8MS94R7NGKHPRNIsTBDcNtzBzgnv3cyl0H3Zoj
 8ZKEsNkL8pr29rDaRi1DiVdx914SsHzZ8ry9bS7wnKvG2ubdx7oc18CAruAvVLHM
 d/Dt/ssojXoTmZokgvMqL7E4tUuCftWWk7ekmCP0D/ex7XEMCwGn7BBn081IMaCo
 s3RleDCwa8oKXDzbXbF+OQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8phya0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 16:17:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 599FVt49036752; Thu, 9 Oct 2025 16:17:48 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv67vvv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 16:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn87Axs8/60GtIqvnPLMHOIwkaisPqvbxqhEdSDagwat8FngItNP7n1/vCl/G2iODfXMYf8M5rvHvsYBmqneB4fYmREdsjlslv/pc/U/TyB2vvuP6i26YJQTWRJbsKPfANUtNyB+OWNQgLEhXrmB5+11pCxsPe3WRVfFTClIzkF3GnQm/nOETItmAJ6dHfQ17lTdqpO0o2d/BW7yd2BuBYimDph52v3A0Q3Zso6MO/Ntb4UDursABi9D8ymGfIgF0CNmnXc5IgCPrNZHeCimIB/eWeGmQNdav0UJqfQ6xyqbgRK6Rkd7kYCWlqArNacOnhNKbHxULsyRABCKgxFerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98ve4+19bDZmXQHRve8vXe36TdE9Ah5VEGk4hDApkcc=;
 b=nTkDYPcYpSmrWpHpZY4aYrgEHw4yiIuMn+5S0XAs6MsJl9CbCsVaQoceo9i4I58R/soR1w+BMaGuzQJ5e9qFXotYV3jps8drXTRz/Oa4f0WGhTCrsv0tboOX6iLTZrDQfcOvYR3Xk0CUC2wMqxbjAhJRUlZ7vxYWr6wh7EF85obO9+Es0zzFeq0DX4Gj1/XTUM8Bh7ZFoRAKJi4DkFl6lnWaOg8bHHCgBFzCV/eoGLW2bCjougCEtSbXbOpgwaPFssWchN5yvMd5aTSU28DENhGql6oAfsPhkfBk7/82Kq/byUweC5aRHceExOFvVI0fHbA/78wuks61epB9oKIOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98ve4+19bDZmXQHRve8vXe36TdE9Ah5VEGk4hDApkcc=;
 b=FAuQmRCjJaYv33AoSR5TPiAe7hnYBnRFx6aybUCE698Fjd9yhX9K1rn6LmJ/Yq02S7lcxKo569htvgC4sS/l0ymuITU/ZnhpUtbc3PrSUWnlMfHIVHKnAWxK5Tb0v3MMBCb4pZEbMnVjihhXzdMyv0hTgyhNiu68os2CF7IA9zU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MW4PR10MB5863.namprd10.prod.outlook.com (2603:10b6:303:18e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 16:17:43 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 16:17:42 +0000
Message-ID: <3756479a-aec6-4fee-ab8e-7629f9d87960@oracle.com>
Date: Thu, 9 Oct 2025 12:17:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix handling device on buses != 0
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 santosh.shukla@amd.com, aik@amd.com
References: <20251008164324.21553-1-sarunkod@amd.com>
 <20251008164324.21553-2-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251008164324.21553-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:510:174::7) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MW4PR10MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: d751cab0-a683-4776-1e9a-08de074f5f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mjh1OTdQQWZXL1BYWGM0Vjlhak5oWUNlUjFKbzdQK24wNEJ2NDVpRjlpaFB4?=
 =?utf-8?B?MkwyNkwxbTVtbkJxbnRpbExZeU1pWXdSMWVWOS83Yms2MFk1ZlkxRFRibDAz?=
 =?utf-8?B?OUFrVXBsNGdYRHFpQVFzV3VCd2VmQlZJMHhXejIrWG9vckljUSs3S2oyZkJw?=
 =?utf-8?B?ak4yVDB2bWFvT2x0ZUxieU5uaGZEOHNOZHE1bXZQWGlscUpGZU5RVlZVd2xt?=
 =?utf-8?B?QzdDOEJPLzF2R1grdDBPWmFjNU9GcjlGajZOVVZsUXYrRnNkL2pZcmpjS2tG?=
 =?utf-8?B?Z1hPSk9jemRKRWQwNFlrb2l5V1VQd1pIRVdPZ1JOZGphSHQ1UEthU2pDV3dC?=
 =?utf-8?B?eEFyaTRLaGMyQWNkaDlkN21XT0tPWmlLbjFWMkVDc2FRNytZZlFuMWF6dldF?=
 =?utf-8?B?aUdYM2RjY1MxWEFGZXUvTlIwQm14aEpQMC9yS2MvaSs5dUNHNnAxUm9SbWlt?=
 =?utf-8?B?R0x2a0F4SHNWZldudlFDOW00RDEyWU9VREFZVFQwOEdDOUt3bjB2SjFnSnE5?=
 =?utf-8?B?SnkrdnptSDZBd0E5TTMvZ0F6NHN3M3VkWmNTT0pZS0RYZ3hONW9MUzd4Ni8v?=
 =?utf-8?B?UUpjckt1RllpbVFDendqbUtub1BWYUpUL1o4TGFNOHZrZ1FDNDJja0hSWGl4?=
 =?utf-8?B?OTkyN21DUy93ZTBHaTd3MVFDNFFjbmVQRW9uSHowaFFOOFZVU3FnVmJqT1Bt?=
 =?utf-8?B?NzV1a1pIRlVvVFJGY2wrSDhJZXNYQW1TSGYxM3o2ZnhnQ1V5KzdZNnJkK2M5?=
 =?utf-8?B?TFdMMi9yRkQ0R1RnM0FiQy9MVXZ1ZkFZamQvUG1MTUs1ZmNTMC9McStnODNz?=
 =?utf-8?B?Nk1yQm1wMjFtbHlyRngwUnlhQnlOOHJUOTBFcXJ1V2k3Ly9hcys3Q3ZoU3Fl?=
 =?utf-8?B?YW1kcXdra0xnTDJjeUcreTBYamkrL095QlY5aTlQYUxwejNWekswaC91dmlr?=
 =?utf-8?B?T2E5UVdGdmd2U1VNMitVVWRad2dmRFJWS0tobG9yVDZGZkJPczF2QkhEWitP?=
 =?utf-8?B?d1NCY0FZOFlWZkdBSG45bytuMitmcnA5VzlUVTczRUhlQjNBbWc2WGpER2xN?=
 =?utf-8?B?aVdYOWZmTG1lLzErK2JHbEVic1dMTGVlQmJkL01MUnZWblBtdU13TXRFbzlp?=
 =?utf-8?B?Vkx4aU83c3pBWmsyRG5tTVFSM1FKd1VFWUIrOUVhUHRGbnU1NHY1REtYUGJ1?=
 =?utf-8?B?bTQ2SER3RFZQeUFFYXBVbnhlSHFqV2xzcnE1emRwaVk0VzlUQnk3c1JpV3NY?=
 =?utf-8?B?TDFWbGRPN25XbHhGTkdNS0ZwUERTQ3V2Rlp6Z0FQTi9JR0pGNkJxZWdWNmtm?=
 =?utf-8?B?RFRRUFJSbURQTnJsbjMvUDNWby84cU4rRndkeGNyV2JsalNQRGUxeGRLRnRI?=
 =?utf-8?B?Vmx6NzdaK0xmZzZSTHphSXJ2bXVmaGtNOHN0OVRUYXhuQ0pJV2dSS2NqaGRM?=
 =?utf-8?B?MU9WSVlqRnhacmNXK3dJTUh5UWRtZjU4eTk2Sk5RNG1oZTJOcnpOZ2xLMUhU?=
 =?utf-8?B?WDNxcG5KSnRDUGpnVEhJNHZKeXozSWt0RHl6RS9namE0QzFXVGtNSmZsN2NN?=
 =?utf-8?B?VUszQzdaZy9OVmZTNHZZYnRIeTUxNFdWanVCRlEvR0JTamJES1VibXNjQ3Vk?=
 =?utf-8?B?YVZtenRlMUVQRnJDVmhmYjZtR1BmemVzL2pJUVVpb1FwNDlsbnZid1dnc0hJ?=
 =?utf-8?B?WmthTWlHbk80UWNiTFBwU1VPTGt0Y2grWVhlN0Z0ZVBISjFXcERmbjlOVGNs?=
 =?utf-8?B?Nlh2b1R4aFc3NGNmRGlwOEx1N2NZL0NCa25pK3BtK015NmpOTDQwREhiMW5z?=
 =?utf-8?B?L0tUbEhrS2V5ODViSnNacmNTaGplSG02bitwdFNPZERHSXZSb0JBTXN1SktD?=
 =?utf-8?B?SlNMYnJ1SnpuRlprVE1UdmZIdzVnRnQzZFZROGhUc1lza0NpWkdhZGZPc2ov?=
 =?utf-8?Q?EMByx5Qf81XPZElfWobhy/Qk+n8Hyxxm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vloxck1XOEhKSGh0bVRMd3gwcjZxSWZ5NWl6VE1XME5ONVRkbFRrK1Q1QU1W?=
 =?utf-8?B?ZkgvMTVjdXJyVitFUGFQdlBxeE1KT0VZbmlkVC9PajFjVHhwQUZWNnhiZy9N?=
 =?utf-8?B?RHJCUnVnUDgwL2RKZGZRU3JML2ZoSUlLRWYwOUl1dHpQaGV4dmJhbEV6R29s?=
 =?utf-8?B?QUlSa1VNVGVOVGxoNUprQlM4Uk5WZFh5QmI4ZVFjVjBQL0M3QnNISTV2L21W?=
 =?utf-8?B?c05TRW9BdnBNdzN2cElqUlp1bk91Y0hhR2dQN3BtNEo2OWtqVis4NUg3QTQ3?=
 =?utf-8?B?eE9DemEyMXcyRGxsTVNqdWw2YXZTVlBOejJMOWc1M1VZdkdOUEdKMExrQnhQ?=
 =?utf-8?B?V2pQYlZXdzZrRFd0Vk92MkdSZ0ZyTDRvUWwvRGtvaWVWVXZ6THNxU1NRNHBm?=
 =?utf-8?B?dGx2dFRmOUl4WTJLZktGVFZhYVJVaW5ncjZ3ZDNXMkU5K2dLZTN4WFR4Z0FV?=
 =?utf-8?B?M0pUMGpsaTFwTk9HVEJIZEZia1h2eHQvQ2xVV3BSSFRXL2RqQVMvY203QU04?=
 =?utf-8?B?dTlra0VBdzVlZzVqcHdsZ2dReVJLbXdzT2tsR0hFVVdsdWRGOXFWWFIzYk9k?=
 =?utf-8?B?d0FxOFJYZXZHYlNpS2M4OTlOVUhmTmgwYzNJejM1U04rdW5ObjZDMDBmdEtR?=
 =?utf-8?B?KzZNeDdWTWtwbnBsZUxwbnhvNTYvQk8xb2N4VDNWbWVNZm1CMkxQUml1YUht?=
 =?utf-8?B?MjQ3RGRENmxvckRXaHV0QUtoOERWaHZQeE5LdCswUHY1L1V1TGZ0V3BYaU50?=
 =?utf-8?B?VXNUZDQwbmlnWFMzUUl5MHh4TGlOYi9Cd0g1QU5jdUV3TVk0TzJ2RkNtTnNV?=
 =?utf-8?B?QjNlRU9iVkFadGprYWVkeG80bk1xYnQ3MVFQdjNkcHEzT3R6WWpvbmU4bmM1?=
 =?utf-8?B?K2ZBRkl4Q0RqNDdMQmYwbnMzcGZSaHNvTW1NbHMremVpanpqbzArSSt4S1oy?=
 =?utf-8?B?ejdGdk1GZFd1dHZYOTRQaktzV0ZEQ2REQk9Ea3o1NWJKVFJob2hMaFAvVmI4?=
 =?utf-8?B?ZFNHMU9mUTVSenpnazFwSHhzYjl2NUlzMjdzVzZ2WXdzZ1hTYjI2M0JmYWtB?=
 =?utf-8?B?VzVKYzZ0Q1MwVVdwc0ZRWDdPNmpyNzQ4K1kzVW5WQnJUbEJsR3Roek4vcHdq?=
 =?utf-8?B?aEVRM2FSc0duemduVmQxRkdUZnFhR2EyMStTNHhPYnNpYXBsdmhZRU9pVEVz?=
 =?utf-8?B?MjdqbVVUbXVkLy9iemZVdXNRbE9xbDdabnNHVG9YN2FYaThUbFg3Y2JvQTlX?=
 =?utf-8?B?dCt2R1BnbTdBZlhsY2k2WG94TXh0NjVtTC80ZnpGaHBubENiYVl6VWpPR2gx?=
 =?utf-8?B?NThHMjhrMDlGOFUxdk9RQThybnBlU0QrNlAyK2xGRmhpalVSVjduTnFubWQ3?=
 =?utf-8?B?WFBMMHhKZlh6cGtkU1BSekYyeVpHVmVmWTBTSlRkK0Y3bVhKZlg1NVljaXNN?=
 =?utf-8?B?RWVZaXI4YkN3emQyQXpYUGpNalBVQWVMb1lIc05DYVJmVVFjaVJCbmRFdnhT?=
 =?utf-8?B?LzByQ1dIQjVZN0JDbHFyUTI5N2xsRmd4WkRhbndMTUhHbDB5ZDR3QnByempa?=
 =?utf-8?B?cEcwUW81d3l4cCtNVkU3dUdSR2Y3L2VHckpZM1lQa0hRa09PVnpIR1d6VVBF?=
 =?utf-8?B?OUEyQi9VZFNRWWpuU1VyeURpaE82bHlJY29tLzZlT3Q5SDdIVDlLUjhkemds?=
 =?utf-8?B?aFFyeVAxazcrQndKeWxRQ1BFWUxSdGNRaE1ldnpwNFVZOGZaSWlCa29paWhq?=
 =?utf-8?B?ZllxbnREbkpFM0l4VkROVG41emM5ZmpEVzdPL2dMa3djVElZZnh0OEtjRlVr?=
 =?utf-8?B?aXN0OVZFeGt5cGp6UEx1dVlwUzVvVVFLTzA2eXhRak9ldUJwSVpMMFVkRVkv?=
 =?utf-8?B?eWZXWnNxM1o4Z2Frd0lBTi8xazRpWGlqR0VTM05BT0taTWJOb1RRa0dvOCtP?=
 =?utf-8?B?c3poL29PWXlPTWxZdHMyQU1lMkdDOHNpWUlxZmdTRC9TNko4WnBaQU1PV0FU?=
 =?utf-8?B?MjhiSGRKM2ZjTHhFVUlUSnJYb3NETVhKbFVFcDhsUkVXK1dLOFRKc1k3bFds?=
 =?utf-8?B?SWJRNUdKWS9MUnRsaFJmL0V1NXhJeWhPWlc4Z2gxWTdNdjI2SUN5MXVzNzFV?=
 =?utf-8?B?U21QZzAzK042Mk4ycEd0NlRrcE9CWVVjTVhlT282N1BybXVHOGtjRW04OUlE?=
 =?utf-8?Q?eJcCsqvpdqVVP9HKwp4Fp0E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wOQ7sSEe9BaSzmqCvS3fx1urNSkhsv5ln3iIIDucYyMbF0XMe/l62mugPa4EdfnYqkaL//0TS+eh7SVP44jSAK/hooJDJfxm+xs9nYPQ8Qsozc9oElPlyhLmu6Ij9blqx57FESmskKBBMgXDAGoZ6a+pRiitvzJS9Gl0kvl9qIO5zrfXT/2YyvMEdeGQB+MncKhzRZ6hte8OB8YF4rdZtqZRn/4inm5sd8Gu6hBgDdfV1XVo17o0Q3G8yiCSCovPXAOmzFdhrcK9+NqCsAwlelYMQdlaJDHnyHczSqs8C4I8QfybqyDPDPkQEH0uFirOEvywjc9Po40jYWgaq96YW7nxVd8tuXAO9XByZcqojPqYiLOqrWma1kmIOerwCKN7JKYEGD2FQK71YojU6kzXG547p9j4SlCJ0SokZj1c5GNAkueOdDOiumY03YqO+GW2Og4Fnh0CnOU9mjsYLBuDyCA3/fsfcbf4Tcb6bByXwGVECANROwYgXsCfBUJjpPIZa4cfz89SyFyFC5sJ337fLVYIPYBy57rZz3wGItSDYJdBcOxfhw3PPlKrRbR9VZMNd4k4x8uWuaIYsRcrSkh2ZRvSTPfKp1rgQwiqGkGopec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d751cab0-a683-4776-1e9a-08de074f5f75
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:17:42.0842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/a3OgqJSjUs1Q9oCZ2fqcqnmHSIIvNzZy68ueUnIqH3UgTL7I8UwUFVL8LNDSQlxKFR8oPwWyHy2buxLxEbDNepUybh0VxrHLfKp+LvElM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090098
X-Proofpoint-GUID: _W93K7TCfqn2mSAhhVmsDfdEi0Mx70Vf
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e7e02d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=osJLeCJUdZNWNBklhwgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _W93K7TCfqn2mSAhhVmsDfdEi0Mx70Vf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX6MbYAoh1iVIS
 eteTwCNXaqeZbJ5CitM9+zlFufbTmMevz7/37F5OCjCqAaCCg7v9F9Hi4yfnAt8YjphFmoIfNA0
 IIHR9z3+5FLLCraOE5vmOiibPQeM7b3AlZXjhWUNKGhxYqoqXW66RtdTUi+XV5yh5kjjBuSsPk7
 IHBQcnzTtt7esEk2X+XEURvD9UGDMolunJHTrK6LmKaxirsM5sFByn7moGTYiPZ/NisKkOco5Yy
 PoklhsPkMOE01T9lUVQULTG53hrG/zQRChVJg4wRcBErjtdyPsukuK7muZE3UA/qsuQJnnAJ8xI
 mEDVfmPzU78KcB5Bwtm57Gv05KddyAiGyaLoXYsOlwuRZ2Eig+HSwuNWK2Bl0QgSwOB93uyejG7
 1rprY2AEEmTE7ipmJUl+MFzkrfLRcw==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Sairaj,

Good catch. This issue makes my Linux guest unusable due to kernel 
watchdog errors. This patch fixes the problem.
I have a few comments, but nothing that would fundamentally alter the 
current behavior. Please see below...

On 10/8/25 12:43 PM, Sairaj Kodilkar wrote:
> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
> for indexing into DTE. The problem is that before the guest started,
> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
> kernel will do that later) so relying on the bus number is wrong.
> The immediate effect is emulated devices cannot do DMA when places on
> a bus other that 0.
> 
> Replace static array of address_space with hash table which uses devfn and
> PCIBus* for key as it is not going to change after the guest is booted.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 127 ++++++++++++++++++++++++++------------------
>   hw/i386/amd_iommu.h |   2 +-
>   2 files changed, 77 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 378e0cb55eab..0a4b4d46d885 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>   };
>   
>   struct AMDVIAddressSpace {
> -    uint8_t bus_num;            /* bus number                           */
> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>       uint8_t devfn;              /* device function                      */
>       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>       MemoryRegion root;          /* AMDVI Root memory map region         */
> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>       AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>   } AMDVIFaultReason;
>   
> +typedef struct amdvi_as_key {
> +    PCIBus *bus;
> +    int devfn;

I'd prefer to use fixed types i.e. uint8_t for devfn. Keeps it 
consistent with same field in other local structs and existing casts in 
the code (e.g amdvi_host_dma_iommu()).

> +} amdvi_as_key;
> +
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -382,6 +387,42 @@ static guint amdvi_uint64_hash(gconstpointer v)
>       return (guint)*(const uint64_t *)v;
>   }
>   
> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const struct amdvi_as_key *key1 = v1;
> +    const struct amdvi_as_key *key2 = v2;
> +
> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
> +}
> +
> +static guint amdvi_as_hash(gconstpointer v)
> +{
> +    const struct amdvi_as_key *key = v;
> +    return (guint)((uint64_t)key->bus | (key->devfn << 24));

Any particular reason to build the hash in 'big endian' format?
I don't see a problem as long it remains consistent, but it differs from 
the encoding used by the PCI_* builder macros in pci.h, as well as the 
vtd equivalent code.

Additionally, using uintptr_t instead of uint64_t when casting key->bus 
is a good way to document that we are hashing the pointer value itself. 
In practice I don't see any scenario where there would be a difference 
in behavior (the result is truncated anyways when casting to guint), but
technically/pedantically uintptr_t is correct choice to convert from a 
data pointer.


> +}
> +
> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
> +                                          int devfn)
> +{
> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
> +    return g_hash_table_lookup(s->address_spaces, &key);
> +}
> +
> +static int amdvi_find_as_by_devid(gpointer key, gpointer value,

this should return a gboolean to exactly match the signature of the 
predicate argument used by g_hash_table_find().
gboolean is ultimately an int, but I don't know if a strict type 
checking tool might complain now or in the future, and since we are 
already using glib defined types we might as well keep it consistent.


> +                                  gpointer user_data)
> +{
> +    amdvi_as_key *as = (struct amdvi_as_key *)key;
> +    uint16_t devid = *((uint16_t *)user_data);
> +
> +    return devid == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
> +{
> +    return g_hash_table_find(s->address_spaces,
> +                             amdvi_find_as_by_devid, &devid);
> +}
> +
>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                              uint64_t devid)
>   {
> @@ -551,7 +592,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>   
>   static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>   {
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>       AMDVIState *s = as->iommu_state;
>   
>       if (!amdvi_get_dte(s, devid, dte)) {
> @@ -1011,25 +1052,14 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>    */
>   static void amdvi_reset_address_translation_all(AMDVIState *s)
>   {
> -    AMDVIAddressSpace **iommu_as;
> -
> -    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
> -
> -        /* Nothing to do if there are no devices on the current bus */
> -        if (!s->address_spaces[bus_num]) {
> -            continue;
> -        }
> -        iommu_as = s->address_spaces[bus_num];
> +    AMDVIAddressSpace *iommu_as;
> +    GHashTableIter as_it;
>   
> -        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
> +    g_hash_table_iter_init(&as_it, s->address_spaces);
>   
> -            if (!iommu_as[devfn]) {
> -                continue;
> -            }
> -            /* Use passthrough as default mode after reset */
> -            iommu_as[devfn]->addr_translation = false;
> -            amdvi_switch_address_space(iommu_as[devfn]);
> -        }
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {

Lets keep the comment describing the behavior. This is something I want 
to discuss in a separate thread...

            /* Use passthrough as default mode after reset */

> +        iommu_as->addr_translation = false;
> +        amdvi_switch_address_space(iommu_as);
>       }
>   }
>   
> @@ -1089,27 +1119,21 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
>    */
>   static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>   {
> -    uint8_t bus_num, devfn, dte_mode;
> +    uint8_t dte_mode;
>       AMDVIAddressSpace *as;
>       uint64_t dte[4] = { 0 };
>       int ret;
>   
> -    /*
> -     * Convert the devid encoded in the command to a bus and devfn in
> -     * order to retrieve the corresponding address space.
> -     */
> -    bus_num = PCI_BUS_NUM(devid);
> -    devfn = devid & 0xff;
> -
>       /*
>        * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
>        * been allocated within AMDVIState, but must be careful to not access
>        * unallocated devfn.
>        */

I think this block comment can be removed now that we have a better 
interface to retrieve the address space.

> -    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
> +
> +    as = amdvi_get_as_by_devid(s, devid);
> +    if (!as) {
>           return;
>       }
> -    as = s->address_spaces[bus_num][devfn];
>   
>       ret = amdvi_as_to_dte(as, dte);
>   
> @@ -1783,7 +1807,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>                                  bool is_write, IOMMUTLBEntry *ret)
>   {
>       AMDVIState *s = as->iommu_state;
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>       uint64_t entry[4];
>       int dte_ret;
> @@ -1858,7 +1882,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>       }
>   
>       amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
> -    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
> +    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
>               PCI_FUNC(as->devfn), addr, ret.translated_addr);
>       return ret;
>   }
> @@ -2222,30 +2246,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>   {
>       char name[128];
>       AMDVIState *s = opaque;
> -    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
> -    int bus_num = pci_bus_num(bus);
> +    AMDVIAddressSpace *amdvi_dev_as;
> +    amdvi_as_key *key;
>   
> -    iommu_as = s->address_spaces[bus_num];
> +    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
>   
>       /* allocate memory during the first run */
> -    if (!iommu_as) {
> -        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
> -        s->address_spaces[bus_num] = iommu_as;
> -    }
> -
> -    /* set up AMD-Vi region */
> -    if (!iommu_as[devfn]) {
> +    if (!amdvi_dev_as) {
>           snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>   
> -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
> -        iommu_as[devfn]->iommu_state = s;
> -        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
> -        iommu_as[devfn]->iova_tree = iova_tree_new();
> -        iommu_as[devfn]->addr_translation = false;
> +        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
> +        key = g_new0(amdvi_as_key, 1);
>   
> -        amdvi_dev_as = iommu_as[devfn];
> +        amdvi_dev_as->bus = bus;
> +        amdvi_dev_as->devfn = (uint8_t)devfn;
> +        amdvi_dev_as->iommu_state = s;
> +        amdvi_dev_as->notifier_flags = IOMMU_NONE;
Keep IOMMU_NOTIFIER_NONE. It is the correct type, as you pointed out in 
a previous patchset.

Thank you,
Alejandro

> +        amdvi_dev_as->iova_tree = iova_tree_new();
> +        amdvi_dev_as->addr_translation = false;
> +        key->bus = bus;
> +        key->devfn = devfn;
> +
> +        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
>   
>           /*
>            * Memory region relationships looks like (Address range shows
> @@ -2288,7 +2310,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>   
>           amdvi_switch_address_space(amdvi_dev_as);
>       }
> -    return &iommu_as[devfn]->as;
> +    return &amdvi_dev_as->as;
>   }
>   
>   static const PCIIOMMUOps amdvi_iommu_ops = {
> @@ -2329,7 +2351,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>       if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
>           error_setg_errno(errp, ENOTSUP,
>               "device %02x.%02x.%x requires dma-remap=1",
> -            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
> +            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
>           return -ENOTSUP;
>       }
>   
> @@ -2510,6 +2532,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>       s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                        amdvi_uint64_equal, g_free, g_free);
>   
> +    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
> +                                     amdvi_as_equal, g_free, g_free);
> +
>       /* set up MMIO */
>       memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
>                             "amdvi-mmio", AMDVI_MMIO_SIZE);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index daf82fc85f96..38471b95d153 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -408,7 +408,7 @@ struct AMDVIState {
>       bool mmio_enabled;
>   
>       /* for each served device */
> -    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
> +    GHashTable *address_spaces;
>   
>       /* list of address spaces with registered notifiers */
>       QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;


