Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993F2C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwBf-0005BJ-Ej; Wed, 02 Jul 2025 08:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWwBd-0005B3-Cz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:03:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWwBZ-0002ga-17
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:03:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BiiLE016475;
 Wed, 2 Jul 2025 12:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=/xbA4ss+0Tb9ISXT1e7SrQyhr3e6cZoSdItUQpaQWPU=; b=
 dF0Mqr4qQlXYn/Lb3IriIXCx2hIdpqJpHTWoJSVje0BAXYwbnFinHhuqR7b41fwX
 aglhabZwyD9dheSoeyAxOiuQhKDLTXulXjye+wkezmyS6NG5tL0lhASLFnVOJYvK
 ilGPV3YiDdX2HGrdsNLSvAmjFque0ClW8sD/KWWoq+IdNC1r9wYuL9lSk03mYhS1
 B9y3SwDVEnLYozxCVWN2Fa+zR+gBPA7HUeaj0BAw3No9f+5S/QbNNTkABRl3dNln
 6MpZQJXAXKvdCenQIEsaeWzX59zI37GRVp68EPyX1bATikn9XEJC+xm6Jw7WrRDL
 InjnLre4itcCLy40P7tvcQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx6rcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 12:03:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562AePDu033766; Wed, 2 Jul 2025 12:03:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ub47xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 12:03:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYe2TYUNO4IkQsZ+1rjtpgyu1KJR4cpwdJT9Toi1RzFMLfLUPMyxaliN2fQv34kMOeds9Lx14QdJGm/DxLSzPBm+1DWXD7oOScq2pnpCNg0gD2cjg9KTsYPIKSHDY4tjhZNYvZ55W+gWx2FpYSrq+vzjGUpDsxhfiIUezuN7E/gp/BNDigi8p1kJxbH8CdAE0eadOx6fGA+MZpgxjsBvfSVTeydgm8+dY/V50BvOH/1oKK6+tcGV2pax/6nbAi3BspB3N4etZ5dDUW5wJgC31yRBtuvPzscEXxrVk3KCjT8yVsxjvnsmIktFAswgJ5sSssliJCIyA91PujgSRfLrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xbA4ss+0Tb9ISXT1e7SrQyhr3e6cZoSdItUQpaQWPU=;
 b=dZEOH0ixdgZohKB+NBpS9+5UCNIyzJT6AowtMvnkI9Fb28xVfb3wS0/Dawlr91MAJfcrRBLovkIRmBVRtetZVQV06rS8SzVFz0VP/xncNTecRL+ZbDl5I+/3BvAJDYyr+jt2aHHJVvEXJs5+EF8qeO2AUVTPGnKf/X706519nwrvdEQkQrqlu3dhHMUX65tswEIVklohdWrTLKT7n9a6zg0iBdhGrM4n46yu+qMGZ8zg42aANklcb6bVOMIVUEu7JgKEGu/IJPbakZt6Myynq5Wmyo0hWS5cyEL84hFXw1kNE4QqszSazx3p5RJ8foUWIvbhL3gfKlOTAx4ZUxXX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xbA4ss+0Tb9ISXT1e7SrQyhr3e6cZoSdItUQpaQWPU=;
 b=COcYhqAC+CEBXDByMTeF/UXbkbQtNIT65/G0S9/rkwU4e2QFB8dwzBn+XpYzrBX6M43b1CYeITp3xgIVIoe0sK1jm/LL5BTtneLafZuYO4ETTaWpfytg/9M3h7tN4HjX3VYcPz4aKd82qoZgoMLfLyoBVXJigY9hNw8d/riW23k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB5164.namprd10.prod.outlook.com (2603:10b6:610:da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 12:03:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 12:03:18 +0000
Message-ID: <f45b2206-f9b3-4858-8dfc-264e63f5122a@oracle.com>
Date: Wed, 2 Jul 2025 08:03:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 18/38] vfio-pci: preserve MSI
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
 <ab244c5d-7a15-43ad-a3e3-807f819181bb@oracle.com>
 <0c98026c-fe97-454e-adcf-017cd4549d83@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <0c98026c-fe97-454e-adcf-017cd4549d83@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8dd879-9615-425e-7934-08ddb9606eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1k5bGpnOXMxaHJ4UXZKWGhvU3d5dXY0N2xRRmpVQXRBbEtYME54cmZZQ3Mx?=
 =?utf-8?B?a0JkOVZVSzF0dGQ2OHVkekRZK0xSQ3UyWndwSk56VWkwYUZBNHdwY1ZWdHpO?=
 =?utf-8?B?VGpFUVk3WERBbGpIZWh3S1ZuNEhUeVZ0eUh5OUlLeldYZHl4bzUvUnJVMUpH?=
 =?utf-8?B?cll6NERudDlUM0FUdUEyY3JpNTFiRE9ycU43T3VDM0F5NmhieHRZc201ckhK?=
 =?utf-8?B?bGJndm1nczJZZ2RoeXkzaGNmajZhbkhlSlEybHdCN015N1dUVlQ3dGlMamhV?=
 =?utf-8?B?R3BvQko3TW1YRjJMQlNZaVpreEkrRkxpcE9OM2I1aVIwUTFCSi9abnBqUXZU?=
 =?utf-8?B?bDEyU3pLOWJzQ3dEK21rbktQYXBvaElWM3prc0ZxL09ST1JuajNJOFBGS0o0?=
 =?utf-8?B?ZitPeHFvTjI3bUxlYTZTQnNvdVNzUVp0R2FjUE9xOHQ0Q0xNOGFha2g2ejNy?=
 =?utf-8?B?WTRhT2NtWjdEUVdnRUFMeVBRZmZteUQ3a3dqU1F6RzVlenZyelloUm9mUXpm?=
 =?utf-8?B?Nk5NVVRRalFxNzdDT3gvV0NaeDYraXBrQ1EyUGpILzR3R2lBSHFqWkt6N2Jw?=
 =?utf-8?B?YWxzMmhWc1Z3cmtxbFR3NDhpcXJuZ2c3YjBLK0QzckJWMGp3RWFnS2Z2Ukt3?=
 =?utf-8?B?Um41YzYzK3ptSmswUWp0VjhQc2pQMkVMZWZIcHo2NzhRNDBwUXdvZnZBaXpL?=
 =?utf-8?B?Nk04UkcyRVZPUEhDUnVuVVhRMGZqZmtrWnhmR0xpL3F3NVNrb3ZQMEpuc0wy?=
 =?utf-8?B?ZW1RMlpheTZiaExNdzYySVlFbU9sQW1DTFVQaXUxdjlyeWRvbS9EWi94MTNy?=
 =?utf-8?B?ZDZ3QXIxR3gwQnI2dWwvYXdCYmdvdlh2WHN3cWU0OGVyTjVrV2ZQV29taEdr?=
 =?utf-8?B?a0VrVDBRUjFNa0xyRW1Xb3FZZGpoSkpzS0FTT0ZZcXJhQnE4RDNXS1BtMjJv?=
 =?utf-8?B?eHB6a2hheC9SQTVhUzdlcWZ6ejVGc1I4c3NXdFE5MnplSmpiM1cvbHQyNS9z?=
 =?utf-8?B?b2dTNlBaeUk4cFJFcCtRWEdXL0pLQ0w0aXBpUDZSdFNBbE1yMjA1VXlOK1ZE?=
 =?utf-8?B?Ukh3VlU0bDZvdTl0b203ZGlYeSsrNXlJQVRiTUdrVis0a0Y2aGJUNjhNVzRX?=
 =?utf-8?B?Qll0UStkczZ1Z3pwRkNhakRjaUMwaWFpdnpwNnl3V1EwT3pGa2F0OFZDUDZH?=
 =?utf-8?B?T3g5N1pQTEdoSWowdStrN2M1NTMrb0tSTjVwc0RZcWtzSmdSVHVtRDZ2U1lC?=
 =?utf-8?B?SEk5RlUxSEFqcUpwUjh6anpLaVB5ZzV3VG1wUkcwT0FxQmNYcG1peU15d1FG?=
 =?utf-8?B?cytjWGJ4Yk0wT0t4RjYxbnBhQkZZYzUrR3ZTOWs1MkxmcmZnQ0lKWXdUN0Jh?=
 =?utf-8?B?UW5iOFRQTjRaNDhNVjZqbmdOVVdvOXd2d0lVY01BVXZWNWFRaDE1MjRhWFpV?=
 =?utf-8?B?QiswK0RRUDBtZFRvYUR3aWNSbmlxeUZpcXlBR2d3WmhVa0o3QjJPSk56Qjlw?=
 =?utf-8?B?MUExNmRha3F2TWJFZE0wckpLOUhUMmpnQzlwdVdkbXJZRTQxbjJoeXhScnlj?=
 =?utf-8?B?L2ZlTmlXSWI1cllGOVA5eGNPQXFwM2tXTklkYmxoV2Y1YWc3bFMrQ28wai9Y?=
 =?utf-8?B?Q2IyMjhaekphakpPdFdzV1BwdkFoVCs5REgvcGhrUTRTQTBseXdGMkhHS05u?=
 =?utf-8?B?RFNPdjFaM0ZJbWxjemozcFJ4bEVVUWVHcFFSMnRDTjg0Y3ZRZVNWYmdtdjdK?=
 =?utf-8?B?cENFMEJvVm1yT2dLRGxZWWMvNDhXVk1FUHJZanZJUEhOR3phc1dIQXJ6T28y?=
 =?utf-8?B?OFFtY2ZFcDFrMC8xT0o0dm4xZC9hRlQvZTNoZzBlRTlhVC8zdXR5cGVyN3RZ?=
 =?utf-8?B?RDc5bExpMEdNTU5WZDJObzhqQ3M2Vlpra2ZSM2ZocWFnYjVwZjlkSC8ranlj?=
 =?utf-8?Q?fzd1nNCNaeI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UytHalpNN0Q5dVJGaTJQYVFDemV1Y1c2QldwWitxYU1IOEFxN1NhNkpHV2Iz?=
 =?utf-8?B?Mk50V3RCb250NjhSQUFsWEhMSjdjV1p3V1NKMnArZWpaN2w1NTRqZ3BWZlQ2?=
 =?utf-8?B?SjZXV0NRTTJ4cDVlajRHNnZ1Nkw2NlRhTmhrOXFVWld0RUovcjVkQ2dCQnVB?=
 =?utf-8?B?NXFycGZSV2RCZy9ZY0psNzhlZ042MHpkTkxuSnVzbEpCVG5xT3MzRkk0U2Fj?=
 =?utf-8?B?OWM5S3VkK3lUL0xkcGtkSGY2cG92WENQc2thbzNDUExGYXArSFQyOWw2b2pU?=
 =?utf-8?B?WlFzaE8zbzF5M25BVW96cHFMa2RuenFoYXRhbmN3SDJveC9pSnExOXIyZGJM?=
 =?utf-8?B?bDZJYzlGa0U2bXJFM2QyRTczMnl0RU0yeEVOM2Ezbzk0aHhZZHVWL09JSnpw?=
 =?utf-8?B?Vm8xV3JzYnF3WDMvN21JRmM5MmR2SWpWV2VJUlZJZktUWkIxYjZZa0p5WUFC?=
 =?utf-8?B?dFRTNmF2cENReWlQK2UyeWt3ZVFJSndYSEJUMEZhbHB2L1AxUHpWcXB3ZXBD?=
 =?utf-8?B?cEIzeWthbzV1U0pFQS9MaUNmN3UzQVZzMTNUWnl2eW1RNWtWdHFpKzhtN2FQ?=
 =?utf-8?B?NmQxWTY2YkJXdG8zK09Ud0RoQ0l0bmZwZUxxQmk1dzdzUWVhZWxKZEV4ejh0?=
 =?utf-8?B?dmxCcHJ4Lyt2cGswUE90MktFU3F4UjNkUEpBcUg4UEp4Wmd2aTlOTDdYMnRU?=
 =?utf-8?B?RXNIcUFVOGozTXhXOXhHMWdhSW1kRFhXdCtITVZ4Ly9xYm5BcjJCcmozUDBH?=
 =?utf-8?B?ZU1WZjJJQ08rOUZsM2J5OVM3YTBJV3hFM3QwWXZ0RzVyck1ZU1FwSEEwZUNp?=
 =?utf-8?B?aVE3bkRPMWV2dS8vVkNXR0lSblZxOWRjVkV2aG1OanNLallra2daUXVPbnVM?=
 =?utf-8?B?RDBoUW16bDU2d1N2a2o4UCtWS1ROODd1Z3BYRGZtL296SnJncE44Wm16aW11?=
 =?utf-8?B?Qm5NZUpTK0c3WmVDL0c0ZUxpQ0UyZW0rd1I2MFYvaEVuQ1NEdytTdFp4LzRZ?=
 =?utf-8?B?eXQ2WCtOclZjRjR2c1dEbWtmb2VEQUFOUVhEQ2RIWXV2QVcxUGU2TTJLSzEz?=
 =?utf-8?B?a2M2Z3NYWUxXMThEQnR6Tm40MnJhU240ZjBXbE9VNTVXSTg5WW11SmxJVDdp?=
 =?utf-8?B?eHc1Yk1CaGVZRlRIaU5yN3VNWUNQeGE0cXRBS1k1ZnNraFRkMkhhdTJCYnJP?=
 =?utf-8?B?dEp6bzRwZTJBaWVDMmhObTNtODlaSk5yemhzV0FLQmx0ZERCVkZ2K25IWXRL?=
 =?utf-8?B?NzF2WWx3LzIzb0VBVlJsbzl0WlZOUVRkTWQxWnhwSllHcS9zOU9KcWpuSElP?=
 =?utf-8?B?eDRiNk42VVhUeE5vSFBHVmloU1JsNW5wKy8zR2FFZ1dQQ2JvZjZvRlVPQS9h?=
 =?utf-8?B?SkoycWNaMGxxL1RaWGZpTUxnaTdUcmovUGx5NXlGWnVWbGxNa0dMQUlobkxi?=
 =?utf-8?B?T3c5azdzNmQ3TFVaZFFFd0NlUiswSUptd2VFc2I3UjRQNjNrTFUzUHpBQk5K?=
 =?utf-8?B?d1F3NTA2ZHRWaS9ncVJQQmM4RUlDUGFtVVNDZ1pzNDl4MHhnY1NzLzJCSS92?=
 =?utf-8?B?d1JnRFQxNHhkZlE2WHRRV2xXd2xEMHg4QXZmcEtFNW1uclFxNmJNZzlRTE5k?=
 =?utf-8?B?eFJzd0tOaUJIaitxNUQ4MlVQN21CRzluc1FRdFJNNlJ5YitUTlBqejNlcThj?=
 =?utf-8?B?NHY0RVVVRUkwYXZsRFdHVi9tSUdFWEp3bU9NNmRIWUZ6eFhUYkp1SzRWSjBy?=
 =?utf-8?B?bWFoQW41MUdpY21xRlYzcWE0clZsZTJwQ1RlZGlSVGQzS21udm1rYUh0RElH?=
 =?utf-8?B?UGY1NjlPdjh1dWhReEtPWUxzSDBlTldNOXFRODJZL2w0RFRISG0ycGdYbTNN?=
 =?utf-8?B?TzdIVzJKUU4rQ0FFY1ZXT2ZxTmJLeG5MbG4vcm9IcjY1djJOWkVCZFpRcjRC?=
 =?utf-8?B?VnlwNnp4dmhxdCs4b2h4T2lzczUwWCsyd2ZLQitseXVLbkZENDNsYTMvZGVq?=
 =?utf-8?B?Y2Voazl6R0JNd2lMUUFwd2EvWjhnZmlUUWhaZjF3UXI0ZTZPYUlpMFV5VTNY?=
 =?utf-8?B?djF6R3ZGSFN2cGF5a0ZZcXU0ZmtzYjQ2RU1FeExxWVJsMXg2WUdZMklrWEk3?=
 =?utf-8?B?Y1JDQmNwd0RqM3NCTUJzVHVCbnp1L2hSYmxKRXRjdXluUlNhcXljV2h5Wk9T?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l2xrjWaHt7luAoAvY7oqRduEdrEYGCFTURJyBx+jExdx9T0ls+nWUKILKgjuh9XeTHloYhYenDznzfEvEIMUJF3pOzwaqeELUOeccfrdkheDy7HE0pdHwL7HHHWxopfFDnE42Pfg7xg3jOC0/rNoh8Ef8d+FtS1gR1YJdG06Ijw+xMHfjJfckvKqlox6dCqROHiCr7jBOm5PnbG133u1JuyCVKjJ6WON6GNVdvnWmJt9tOzl0YCSO37muCamnXgDSinYdfE4V3st+DPQ8LHpHjXUouC+GO7OTtoc+eQhodubXVicJ48kftLZrTA8DeMJUOS9iTkA1MjDIHXHWLcFA/5ncI5ox8vwMNtDlObBp0ugdl7NKMwVkzsHDoGtrvhQxj50+6PzvB9H5jJ63+lYW21C6L1WH72K4/pGYPO4YksUvkkQfwgiazEOnH7PjZIzeK8odSinYDaGH04vQ2dYMEok6ZJqYT4Yrszo/zibxWrkCL+Ou7weElezPF9N5HhZipd/F4FXktt8bKhksB4mktXSzVC8GqacC6t9cYnOYblaUdOJZ8iTNFs0OffNwAQl2R99peoK87yha5izEP9WWSMseRnue16Z3b/LFh44jTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8dd879-9615-425e-7934-08ddb9606eef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 12:03:18.6948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toj6ZSXTJClD8tLbF9uirPc0y5ai14OOEty8uq6VULhtKOthhJqJrFFm8J2Rmh5LqTfrO7PD6r/nrR1phZpMmDnBUUXbB2W2YWfteijak50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5OCBTYWx0ZWRfX+BplOZBYCKBT
 JLENUeFd/YQ+efgBWN8+T3jOjq+Omsl11FLZr+fIb4e6RLNO+08gib+dd9qpeciD+6CKs6eufkm
 XpYou+E7K3bC7twdQMNSpvZ2oYSeiuqWcDWlTdkIRGaFs/LLhof8k5IXr84zzxrlGcLRjeztrnC
 dFdtb3fjHCMIkb0ZKlVA4xqfZ4AXNlGB9ajyjAn7YcJC4KwaYXIvZfwcnVfvWxHW622zrNdAwiS
 E5/z3DSiAJd7qt4K7oQTSK5jjg99WRV0iT68T5kqyVkuq145orpRz5POGi8sJnO7kl8pnzNWrHV
 JfPLVJv3Fk666Yyt2VXrZ6Dd3QCopSA/k8VE/C3r2Suecmk2M4Q7UnZ4VxTmDPG106yOipu6O/S
 I0UnKFlzYvOWiLg3oZ6sneeBP4t1eiXVbOTUbTCxs+LkRx2PX3M5OoADogIEPtyxjnnAo/u3
X-Proofpoint-ORIG-GUID: yx11uSzFiSy2bS34INRlQBSpHT18WIl1
X-Proofpoint-GUID: yx11uSzFiSy2bS34INRlQBSpHT18WIl1
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6865200f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=kP-EV8whGjUMg4fpBJMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 3:17 AM, Cédric Le Goater wrote:
> Hello Steve,
> 
> On 7/1/25 18:12, Steven Sistare wrote:
>> Hi Cedric, what do we need to do to get this patch in, and the patch "preserve INTx"?
>> Just review, or are there conflicts to resolve?
> 
> I haven't looked at it yet. I will before the end of the week.
> 
> I should send the last VFIO PR for QEMU 10.1 on Friday. On PTO
> next week.

Hi Zhenzhong,
   With Cedric out next week, we have very little time to finish the iommufd series.
I can post V6 today if you are satisfied with my most recent comments, and if
you review patch 29 "vfio/iommufd: register container for cpr".

- Steve

>> On 6/10/2025 11:39 AM, Steve Sistare wrote:
>>> Save the MSI message area as part of vfio-pci vmstate, and preserve the
>>> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
>>> then the vfio-pci post_load handler finds the eventfds in CPR state,
>>> rebuilds vector data structures, and attaches the interrupts to the new
>>> KVM instance.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/vfio/pci.h              |  2 +
>>>   include/hw/vfio/vfio-cpr.h |  8 ++++
>>>   hw/vfio/cpr.c              | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/pci.c              | 54 ++++++++++++++++++++++++--
>>>   4 files changed, 158 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index 6e4840d..4d1203c 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -217,6 +217,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>>>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>>>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>>>   bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
>>> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
>>> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
>>>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>>>   void vfio_pci_write_config(PCIDevice *pdev,
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index 8bf85b9..25e74ee 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -15,6 +15,7 @@
>>>   struct VFIOContainer;
>>>   struct VFIOContainerBase;
>>>   struct VFIOGroup;
>>> +struct VFIOPCIDevice;
>>>   typedef struct VFIOContainerCPR {
>>>       Error *blocker;
>>> @@ -52,6 +53,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>>>   bool vfio_cpr_ram_discard_register_listener(
>>>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>>> +void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>>> +                             int nr, int fd);
>>> +int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>>> +                            int nr);
>>> +void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>>> +                               int nr);
>>> +
>>>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>>>   #endif /* HW_VFIO_VFIO_CPR_H */
>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>> index fdbb58e..e467373 100644
>>> --- a/hw/vfio/cpr.c
>>> +++ b/hw/vfio/cpr.c
>>> @@ -9,6 +9,8 @@
>>>   #include "hw/vfio/vfio-device.h"
>>>   #include "hw/vfio/vfio-cpr.h"
>>>   #include "hw/vfio/pci.h"
>>> +#include "hw/pci/msix.h"
>>> +#include "hw/pci/msi.h"
>>>   #include "migration/cpr.h"
>>>   #include "qapi/error.h"
>>>   #include "system/runstate.h"
>>> @@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>>>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>>   }
>>> +#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>>> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>>> +
>>> +void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>>> +                             int fd)
>>> +{
>>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>>> +    cpr_save_fd(fdname, nr, fd);
>>> +}
>>> +
>>> +int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>>> +{
>>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>>> +    return cpr_find_fd(fdname, nr);
>>> +}
>>> +
>>> +void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>>> +{
>>> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>>> +    cpr_delete_fd(fdname, nr);
>>> +}
>>> +
>>> +static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
>>> +                                   bool msix)
>>> +{
>>> +    int i, fd;
>>> +    bool pending = false;
>>> +    PCIDevice *pdev = &vdev->pdev;
>>> +
>>> +    vdev->nr_vectors = nr_vectors;
>>> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
>>> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
>>> +
>>> +    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
>>> +
>>> +    for (i = 0; i < nr_vectors; i++) {
>>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>>> +
>>> +        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
>>> +        if (fd >= 0) {
>>> +            vfio_pci_vector_init(vdev, i);
>>> +            vfio_pci_msi_set_handler(vdev, i);
>>> +        }
>>> +
>>> +        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
>>> +            vfio_pci_add_kvm_msi_virq(vdev, vector, i, msix);
>>> +        } else {
>>> +            vdev->msi_vectors[i].virq = -1;
>>> +        }
>>> +
>>> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
>>> +            set_bit(i, vdev->msix->pending);
>>> +            pending = true;
>>> +        }
>>> +    }
>>> +
>>> +    vfio_pci_commit_kvm_msi_virq_batch(vdev);
>>> +
>>> +    if (msix) {
>>> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
>>> +    }
>>> +}
>>> +
>>>   /*
>>>    * The kernel may change non-emulated config bits.  Exclude them from the
>>>    * changed-bits check in get_pci_config_device.
>>> @@ -58,13 +123,45 @@ static int vfio_cpr_pci_pre_load(void *opaque)
>>>       return 0;
>>>   }
>>> +static int vfio_cpr_pci_post_load(void *opaque, int version_id)
>>> +{
>>> +    VFIOPCIDevice *vdev = opaque;
>>> +    PCIDevice *pdev = &vdev->pdev;
>>> +    int nr_vectors;
>>> +
>>> +    if (msix_enabled(pdev)) {
>>> +        vfio_pci_msix_set_notifiers(vdev);
>>> +        nr_vectors = vdev->msix->entries;
>>> +        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
>>> +
>>> +    } else if (msi_enabled(pdev)) {
>>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>>> +        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
>>> +
>>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>>> +        g_assert_not_reached();      /* completed in a subsequent patch */
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static bool pci_msix_present(void *opaque, int version_id)
>>> +{
>>> +    PCIDevice *pdev = opaque;
>>> +
>>> +    return msix_present(pdev);
>>> +}
>>> +
>>>   const VMStateDescription vfio_cpr_pci_vmstate = {
>>>       .name = "vfio-cpr-pci",
>>>       .version_id = 0,
>>>       .minimum_version_id = 0,
>>>       .pre_load = vfio_cpr_pci_pre_load,
>>> +    .post_load = vfio_cpr_pci_post_load,
>>>       .needed = cpr_incoming_needed,
>>>       .fields = (VMStateField[]) {
>>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
>>>           VMSTATE_END_OF_LIST()
>>>       }
>>>   };
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 4cda6dc..b3dbb84 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -29,6 +29,7 @@
>>>   #include "hw/pci/pci_bridge.h"
>>>   #include "hw/qdev-properties.h"
>>>   #include "hw/qdev-properties-system.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>>   #include "migration/vmstate.h"
>>>   #include "migration/cpr.h"
>>>   #include "qobject/qdict.h"
>>> @@ -57,13 +58,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>>> +/* Create new or reuse existing eventfd */
>>>   static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>>                                  const char *name, int nr, Error **errp)
>>>   {
>>> -    int ret = event_notifier_init(e, 0);
>>> +    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);
>>> +    int ret = 0;
>>> -    if (ret) {
>>> -        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>>> +    if (fd >= 0) {
>>> +        event_notifier_init_fd(e, fd);
>>> +    } else {
>>> +        ret = event_notifier_init(e, 0);
>>> +        if (ret) {
>>> +            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>>> +        } else {
>>> +            fd = event_notifier_get_fd(e);
>>> +            if (fd >= 0) {
>>> +                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
>>> +            }
>>> +        }
>>>       }
>>>       return !ret;
>>>   }
>>> @@ -71,6 +84,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>>>                                     const char *name, int nr)
>>>   {
>>> +    vfio_cpr_delete_vector_fd(vdev, name, nr);
>>>       event_notifier_cleanup(e);
>>>   }
>>> @@ -394,6 +408,14 @@ static void vfio_msi_interrupt(void *opaque)
>>>       notify(&vdev->pdev, nr);
>>>   }
>>> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
>>> +{
>>> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>>> +    int fd = event_notifier_get_fd(&vector->interrupt);
>>> +
>>> +    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
>>> +}
>>> +
>>>   /*
>>>    * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
>>>    * fd to kernel.
>>> @@ -580,6 +602,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>>       int ret;
>>>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>>> +    /*
>>> +     * Ignore the callback from msix_set_vector_notifiers during resume.
>>> +     * The necessary subset of these actions is called from
>>> +     * vfio_cpr_claim_vectors during post load.
>>> +     */
>>> +    if (cpr_is_incoming()) {
>>> +        return 0;
>>> +    }
>>> +
>>>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>>>       vector = &vdev->msi_vectors[nr];
>>> @@ -686,6 +717,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>>       }
>>>   }
>>> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
>>> +{
>>> +    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
>>> +                              vfio_msix_vector_release, NULL);
>>> +}
>>> +
>>>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>>   {
>>>       assert(!vdev->defer_kvm_irq_routing);
>>> @@ -2962,6 +2999,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>>       fd = event_notifier_get_fd(&vdev->err_notifier);
>>>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>>> +    if (cpr_is_incoming()) {
>>> +        return;
>>> +    }
>>> +
>>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>>>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>> @@ -3029,6 +3071,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>>       fd = event_notifier_get_fd(&vdev->req_notifier);
>>>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>>> +    if (cpr_is_incoming()) {
>>> +        vdev->req_enabled = true;
>>> +        return;
>>> +    }
>>> +
>>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>>>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>
> 


