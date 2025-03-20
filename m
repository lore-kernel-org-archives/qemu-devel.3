Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C433C36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEWH-0002zH-FG; Thu, 20 Mar 2025 07:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvEW1-0002yj-9G
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:56:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvEVv-00007Y-QT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:56:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8BthQ030528;
 Thu, 20 Mar 2025 11:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tcuwvWm/GLuIayXAuiYx5GrwHOSg8/UcbvcSjX4+G38=; b=
 ofiJ1EUkzjD97L+loBP2d1fkgM3QeEJg5Ct57WCEWB4kZcSIa9hXHSA5YB6CnaDs
 6hy3DcLttrVjO6Jdt8/JtMEqWC+cco6GdgBgLHuGR837tn1TQZz5vKFb99oKKRx4
 qA01d4CVcU2PP2dvGLPLAHR1tpGChBhLk8IIpEsHyPYfgPuj8eyxUrnKDVlduLl5
 RKoOMlYPqy8NXCJ96ZuFDd6um3k9WsdjkcA1eTqNPQLBnoSc4s2lISzXi/wVYOZu
 pI+ye7Dp2BXOSQIzQK6tdhkxU6Sl83JCWOIJ1FmA8SVJIguidXdTtdIXVQqi47I1
 IwduLz1kERHObSypEXuOgQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s5x5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 11:56:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52KAVX0d023955; Thu, 20 Mar 2025 11:56:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxej794m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 11:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6BLpGtvP4KFTjlBkjsDhlc001wy1ljCxV+UHbd2aO1Yrb0kEf8LAV1Ewxi4t5ae+gQ+xKbc5fxeJWHQobPLQCrqFn0DaZmdehEyYFRbHT/RnmC1fvzIiPKRIHHqDMoJl7l86QMtJqr0/dKmlRF73GFA7G0U9saPx5aFFw7xjVzoLnW912NcAfAh7LR4S9fHFx6aFjpCxq5nhaqk1dbx6QBSNnzUp19MVJYEfQkxhIKY6iY+CTxM1mTukL/gIjiYYPRlH5b11CGehUVWvLkMcrIYJkcyM/LxeYeQeXZJ63zfAdTwaPZ4KD6BsDAvfsns1LYHelzdmD3hTcmLjm+3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcuwvWm/GLuIayXAuiYx5GrwHOSg8/UcbvcSjX4+G38=;
 b=F3iHpnj65vX4wX65MJcRRTXEeV09CBHQD0Pqq46CY2jTAuWTGC4fGyATSIkkddgAAjyK5YiIr+aXIEAKkaWOUfoH3yU6MqJ3DZc+UxeWn5dQg3h8RkAtW+dyacgDfvnI9WWpH0Hh+6g6UG4QDKe4p4PuDk/F/ovpQs0TihhK2IjQZdaYRx4IQ+pA/l0CqdiqY2+1DwvTDzYw5CQGpWc/6AwHq8wA9xA5Cmf+LY2ptSTfCxe1LF3fdzPLB2QPAGhVYxivfx4XnErphD5xAKe4gVmIs2LlgTWIGDjtGJ5NPuXSQsuooIe7o+sWpBI7cI7OWOaTu2usyZ0yCYvs59bC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcuwvWm/GLuIayXAuiYx5GrwHOSg8/UcbvcSjX4+G38=;
 b=QG9t0jMffB/YNmRJNqzIkrfpDb2Yx6Gk9PIK2l4EIu0wrEst7mzrnIQej7kEIqbpIU5bgz32mrlFsJL5BIoOOTmzNKivgsM+H3jHxgIdO8gBOXdhEhbMb+bv7ZB4D94HKjsMgMV7BTS6ziuM2GEyzvQ4fV4xEVWALMEQDavcxTE=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7631.namprd10.prod.outlook.com (2603:10b6:610:180::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:56:37 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 11:56:37 +0000
Message-ID: <3ed50b04-f783-4e1e-806b-7ba4d218950e@oracle.com>
Date: Thu, 20 Mar 2025 11:56:28 +0000
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
 <621d6268-ca2d-4028-814c-f4c2ddf5d567@nvidia.com>
 <ea1b19e8-245c-449c-a7bb-31b79c62b799@oracle.com>
 <ff5edbbc-b6f6-4064-840a-5ba146190ae1@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ff5edbbc-b6f6-4064-840a-5ba146190ae1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: d11bd799-2702-4ab4-af9a-08dd67a644bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGVNcHZPQnRNTmZ4SlJYRTNXZWt2cHdackpKMmZVdVQ0U1ZsL1dQczFSbnN0?=
 =?utf-8?B?RzFpN0dGSTN6dVNQVGNhWjJ5YjJVdkN6b1g3V0tJbnMreStRWEVBSUFRcWQ4?=
 =?utf-8?B?ZllDd2dnck1lRWExOUE1QXVXanZwS3JTVDAwWUNybHRzK0ZIRnZnTjFUWjlx?=
 =?utf-8?B?T2Y0NDZlSyt2UjBvb3dpWHNncmJoQUwwWjN3LzNVZDA5eXh0VVZFc3ltdVUr?=
 =?utf-8?B?MEtMcXRCdlpndDFzOFpiTjhtVFNVSG9OSElJTUpRZWpHODhBRDFBNUpockM4?=
 =?utf-8?B?TE1obFcrY0h4M01JbjVNVEJJN2UvM1NJeTB5ZVJtTEROakhmZFkyLzdzZnFK?=
 =?utf-8?B?UEUvdEpvNTZ0YTdpU3hTeUlxNkhrYy95UGNjME96TUFucW8zOW1TYWNWSG1Q?=
 =?utf-8?B?ZWJ4VXNGSGNUdzZ1Qml2QzJ4NWNzNWFWS2lpZnc0MDg3ZGo0a281WGVZMEFG?=
 =?utf-8?B?eUM5Rnc4eUQrL2h6OFFzdjR0SHlJMC95aE5FcjdRUFNSQW5nbmNLWmp6OE5X?=
 =?utf-8?B?dlB2NWRva1Q5YTlrQk1sYXVNVUF6aytnSU5qOGZVTEFzUXE0cEZ5bjc2YnNJ?=
 =?utf-8?B?SlZUTUZjN3VHakdHcEpKdE9EWFJMVFlaemsyWXNFRjZDZGJMWnJqOXdmblNr?=
 =?utf-8?B?RzVmcUJTUUhLSUJrSlZGUlF0aW5tcm5wbFR0QitsMGZqZjZmT1ZrdUU3NE5X?=
 =?utf-8?B?UUVsSmExMWZlLy9IRGZVZ2s0bzJQcWhlV29wTUpSbTJNMHFOdHRVUmV2U3FW?=
 =?utf-8?B?ZFNwNElrb2VCcnhkTzJ5RFIzOXEvejduK1ltbitJSEc1Vm9jVll0aVF3bjd1?=
 =?utf-8?B?UFpyRC9XVXlLTDltNlVhNGlzWlZqd2ExQ243Mm1OZFJJSzdJdG4yb21yQUQy?=
 =?utf-8?B?T0NBYU9lZU5DMGRtaEhYQ3g2dFc5MHlmYnBZZ3hXVkFBY2piVmtYTjlpV0Vu?=
 =?utf-8?B?dTR6N3lFY1VoeE82Szlic1JKaW1OOHptMWVoaW80LzN0U0wwQlY2dlBqTERL?=
 =?utf-8?B?WlBVQ211djhRT3d1bWVUa1ppV3B3SVI5SGZJWGt3UmlaVkYyRUIwS3R5Yytu?=
 =?utf-8?B?MlBCLzBlOG1vTXNIT09BQ1kwOEppVExHL3R2c21XWmtQckhEVzN1YitLRC9R?=
 =?utf-8?B?K3lMd2NacU44djZBdC9pSWNZR3FFcVM1NXEwc1dlK01Hd1c5K25Wb0dEMUlp?=
 =?utf-8?B?ekJnMjFsYXpucnBockVkK1B5cWV2L1c5dk93VmFhYjF0SkFtaHJVM3QwYWdH?=
 =?utf-8?B?UlkralIySUhoSGloQkc3YjhadGxIRC9uYnZPbS91dzd1bytqUHRxdWVZdmt5?=
 =?utf-8?B?ZUR1UEpoM0RmZDE2NFBMRjFqSXRldlZocDBOWVFZYnAzVlAvbTg2ZVFtNFp4?=
 =?utf-8?B?UHV3c2xYNUtDWmJvb1ZCSHp2STZRQVZKZXZGa2d6dDI4czlxUHF3VWFWQjhr?=
 =?utf-8?B?KzE3MUZnTjl2V1k1NktMQVgwOTlRNDhVQ0FvRStpT3cvT2FWVndlWmdNT3ds?=
 =?utf-8?B?Zml2d2d1b2UvMmlQMlJnUklLRGtzZnh1cmpqaDFVRklzZlF5cXpLU2lzelR4?=
 =?utf-8?B?endJcUhpcWxPN0J6czVuSVIxdFlib2tRcUZkVVFuREwzVE5zRWNCdGEvY3JX?=
 =?utf-8?B?dXVjb1BnYnJPbTd2TzhwTEFyQjBXcGhzbnM5WGovaU1GNkxnQXhZYVJYMVN6?=
 =?utf-8?B?TzFtb3BydUliTXBNVFNjYWxCTVlEWEJXUnFmRnFqYTNDSnpha3RVQU1kYUFx?=
 =?utf-8?B?R3ZQV0s5dnNvVkFZR1RwOHdFN0hSZDBQZjBBY0h4RHpjZkFEbCs4amVzbUhV?=
 =?utf-8?B?TzF2TFZKSVc2eVR6YytCU2V5YXFjTnVRckRqL3dwR3g2Vm40a3B1ZWI2KzZl?=
 =?utf-8?Q?1PUzWKjQLNISz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpoSUZMMU1OSzgyWHR6RzdId20vVFZpV1J6UEJHeUxMYTE1cXdmNFQvR1BP?=
 =?utf-8?B?U2NreWorQXZ3RGs1dUgxL0Jiem1iN1EwL2hueEtDdFBPaDNDQlBSRlVpT1pS?=
 =?utf-8?B?SHhpeFc3b0hyTldJanRFRk16VFhVMTZwQjBDcVJ2V09zd2F1WEFrVmRjZGZO?=
 =?utf-8?B?QXR6MWtZZE9heDI0Q1c5bUJ5ZnZVcGlvbGxmT1Z6Mk1WNzVQK2FOeWhZcU5D?=
 =?utf-8?B?OUlxYmJZS0oxd1c4VVE3RTNZK09XVzIxeFlXUk9tcHZLeS9xK0c3djFqQ2ln?=
 =?utf-8?B?eU80OFFXR00rYkgzaGl2bnp1Wm9hYkRENjBjcmNXN2FhWDlGUDc5aVlWekpT?=
 =?utf-8?B?K0RBZkVYbXM2aDNrTGR5OGFSNThyR0kyN2JhaGdaT2hBVC8xdFBwR0FPZ2FF?=
 =?utf-8?B?dWRKM25OcHFnOHU3Q3F4TUY3MUZnNzI4eTBrVkFseUdQYjJIcC8xeER6Y2VP?=
 =?utf-8?B?c1lUTW9rWks1MVVDQThDOWhkRWMyTDVEd08zWTQxY1paV1FVelNMWWpvWDZq?=
 =?utf-8?B?YXNuenRYNTZNaUNiU0RVQUZndlF6YkRrVHV5aXd0MEpRWTdpbVY5YjlUWFNL?=
 =?utf-8?B?UFkvQWtJMERDZksrNDJMSEZhTGEyOU5IVXVoVDl5UVYzZ1p6d2dGRS80ZUFD?=
 =?utf-8?B?aGVVOGVadGhwTWFINXBSMXdRc05NdE92bnFLdVFaU0txMFk5c1BTRTZNTDJp?=
 =?utf-8?B?RUtGUkFnczlHc1NVVjJwVDRQNEQ4QklLUjdHRnRwQ0FEc1M2aGQ1YUhGOWts?=
 =?utf-8?B?L004cnhwQ1VsL3BMWHd1RXlmZk9lOXM3Tm9PMUZWRk1uM0cwYXBZdGZMUGsw?=
 =?utf-8?B?Z0VKa1kxclM5V0hycjRXMGxCSnBKcEZmVzN0NkVsWGpWdmJrRFlIbVp6Tkdz?=
 =?utf-8?B?ZFI3U3N0UnN4SXdQTzFPWXFiQ3RQYVo0TlZrOWQrWkVWMklBWTBFelMyNktm?=
 =?utf-8?B?azBNSEJ4cGptMitaSXl6MXlxMi9PVU1rQ0lxRnYrQ1M1UWY4USt5K1luTVlP?=
 =?utf-8?B?ZHNtWkI4bnBCbFpubzMvM0RrcDFhNGhlOTA0TnhMVkkyT2FFZ3FZTGdEbHRp?=
 =?utf-8?B?ZG9zZndLa01nd1FueU9LcHVseFdGM2ZQbkpaT0NCc3RRazFXZjl4NjQ1aDBR?=
 =?utf-8?B?TVlFYm9JemQ2V2t2OCtwQU1kR1lxTTlIaUQ2L01mYVY3cXVGalM0L3FqOGVR?=
 =?utf-8?B?dWNZTDlnUzNkdStBSzh0ZC9FSE83NkNTSkh2SUFzOUJudjV1T3pQbnJNTEd6?=
 =?utf-8?B?MFMrU2c3QitpYzJCK0UxNUVwR3Vvdk5SdmNJYUJnQU9LZFRSaGNXemozQmFU?=
 =?utf-8?B?UzVoNk9kazZCU1oxMzVJeFBsVzd6ZmxoeU9KUUwzT0czeUJ5d21oVlR4blov?=
 =?utf-8?B?Mk5YZGlJTEJldWcxbHA4eXpldnhKZGZuWjhVQXFIRkdnZkx4eUhkczNmZVVD?=
 =?utf-8?B?RXB2c0pVVnE4WjFScFdROGtDUFdKSHNnL3Z1aWRHK09tVkZLVnhlSXRybkNs?=
 =?utf-8?B?ZlNjTzhhNWE4OGhJSUR3emp6bGxCb3hZcWh6dS8rRUpGWWQ1eEwzWVBESnhp?=
 =?utf-8?B?UlZjWGhVNVJoZG5FY3ZqVEZoM3JUZTYzYm4xeXFWdnlCZGZUeWhkZ1lCaFla?=
 =?utf-8?B?RER1Zkt1QVkwS0FDenQ4Zm5hWitSQzhxeTl3Z1NJemhSUmE0eS9OLzJCbGFj?=
 =?utf-8?B?UTlPU3pYZi8wQ0FybE1CTHJ3Uko0QW4vTlA2LzhmT1MycVZhN3V1clpheGpJ?=
 =?utf-8?B?dk1rMm5KMENMNVNRNVZFdW54UkpCeW9kMVU2UjN1UlNSTmFNcVFKOE13Rlpp?=
 =?utf-8?B?bzc2dUJKdmUzS09kbHZ3QlNnMy9Wa2RzcHBZT0ZuTndkL3dEclJBMTRhclRC?=
 =?utf-8?B?M2I1dmE2bXhpZWNENkFRbTBZRi9GTDUwZDhvYkFOckNvcmRxdjNzTStQMmlJ?=
 =?utf-8?B?TjZSN0dTY2VvWS9kWVQ0bS94MHQzRnRJbE40QkJmVEN4RjN2NGZaa2dPZ3o5?=
 =?utf-8?B?QzZhbWpNd2YrZEV3QTN4SHQxMWZtY1pxbU41V056bkk5TXZtaFZwYSswcTRy?=
 =?utf-8?B?WjVaRmM1dVlqd2Z2WVZOcHFjbktQaTFJb0ZkMjBFVy9ZZERrU3hwaTdWdDVP?=
 =?utf-8?B?eXo1T21NUzNvYVRaTUpMdGN4cmoxc0k4SWRRTnBzYXlxc1RZbmx6L0NlL1N6?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lboxLavAIefPJsz+bfZcJYNJpIpu0tfPkEgic9Z4+NfMTmeNHmIkp7uFST2kIOLudEDWcdZ9KTZ0QnP6Eb29wmIMuQEwZwvJeRTmC+3tnzPlKbiVpe2nP0Q9IN2QSpqO1bd7TTSJRv6HssnlRXpFPsZIIJ69bUvhMbnmF63n6giwCKPWhNnNpok2MLkr+2IW3QvsOXqwgDGXDdJB0Gh/MlMPEBlf6+4762YOm4GGFOmWbCBU4/5ACuYB3YdOzOeGSuz6cidusDs7uo8xeqaFkRr8xyPLhNojjcEHf+ITN+xpCuxPb9LGBfBIXvKJEaJNtebKQ0FWV9BTmfNmcxOVtmddPdWpjHE+oOQiwcsqR5dR0AJdejd99cpN6eVgypq9QGl2n2hjVHRsuNN59u3KWCNioUoJMiCRldcrM/5gwFJmr7bPB/gxhiWSUVPMTIVGv1u3eOEe235MPw1IeOYwW4LoSiPJgPTn8FED9oxW9V2KzEzgCa5SqsNP6wxcRPBnALQ3o1OTQs4cCtr+8BGzi0X/SDB7h9Vj5G4F6nTR1G8Se/f7wkQMIUbTraOZF+/DsRO5wrRsU5BUIpU2A9C2t4NGVrN5itzhyjuTvYsceSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11bd799-2702-4ab4-af9a-08dd67a644bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:56:37.5563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fu5j+rUFUlMIDD5eB13k7I7BrW5yQx8Rf5MujGCrmorJnqAHj2KyJ/CfHVBCfPXoM2dmRHj+7reQ92J8egb0YvJRxTOcYlZehssVn3lJf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200072
X-Proofpoint-GUID: uLGs45IIJEMgmkPCcFTRRs-8paT70s9s
X-Proofpoint-ORIG-GUID: uLGs45IIJEMgmkPCcFTRRs-8paT70s9s
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 20/03/2025 11:45, Avihai Horon wrote:
> 
> On 20/03/2025 13:18, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 20/03/2025 11:13, Avihai Horon wrote:
>>> On 19/03/2025 14:21, Joao Martins wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 18/03/2025 09:54, Cédric Le Goater wrote:
>>>>> Rename these routines :
>>>>>
>>>>>     vfio_devices_all_device_dirty_tracking_started ->
>>>>> vfio_dirty_tracking_devices_is_started_all
>>>>>     vfio_devices_all_dirty_tracking_started        ->
>>>>> vfio_dirty_tracking_devices_is_started
>>>>>     vfio_devices_all_device_dirty_tracking         ->
>>>>> vfio_dirty_tracking_devices_is_supported
>>>>>     vfio_devices_dma_logging_start                 ->
>>>>> vfio_dirty_tracking_devices_dma_logging_start
>>>>>     vfio_devices_dma_logging_stop                  ->
>>>>> vfio_dirty_tracking_devices_dma_logging_stop
>>>>>     vfio_devices_query_dirty_bitmap                ->
>>>>> vfio_dirty_tracking_devices_query_dirty_bitmap
>>>>>     vfio_get_dirty_bitmap                          ->
>>>>> vfio_dirty_tracking_query_dirty_bitmap
>>>>>
>>>>> to better reflect the namespace they belong to.
>>>>>
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> The change itself is fine.
>>>>
>>>> But on the other hand, it looks relatively long names, no? I am bit at two
>>>> minds
>>>> (as I generally prefer shorter code), but I can't find any alternatives if you
>>>> really wanna have one namespaces associated with the subsystem:file as a C
>>>> namespace.
>>>>
>>>> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
>>>> when talking about this stuff, but it seems a detour from the code style to
>>>> abbreviate namespaces into acronyms.
>>>>
>>>> Having said that:
>>>>
>>>>           Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>
>>>> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
>>>> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
>>>> shorter.
>>> This file is not related only to dirty tracking, but to memory in general.
>>> Maybe a better naming would be memory.{c,h}?
>>> Then we can have vfio_memory_* or vfio_mem_* prefix and rename to the below:>
>>> vfio_devices_all_device_dirty_tracking_started -> vfio_mem_device_dpt_is_started
>>> vfio_devices_all_dirty_tracking_started        -> vfio_mem_dpt_is_started
>>> vfio_devices_all_device_dirty_tracking         ->
>>> vfio_mem_device_dpt_is_supported
>>> vfio_devices_dma_logging_start                 -> vfio_mem_device_dpt_start
>>> vfio_devices_dma_logging_stop                  -> vfio_mem_device_dpt_stop
>>> vfio_devices_query_dirty_bitmap                -> vfio_mem_device_dpt_query
>>> vfio_get_dirty_bitmap                          -> vfio_mem_dpt_query
>>>
>>> dpt can be changed to dirty_tracking if that's clearer and not too long.
>>> In patch #31 we can rename to vfio_mem_{register,unregister} or
>>> vfio_mem_listener_{register,unregister}.
>>> More internal functions can be gradually renamed and added the vfio_mem_*
>>> prefix.
>>>
>>> Will that work?
>>>
>> I would associate to memory if we were talking about Host windows, DMA mapping
>> and etc. I believe that's more fundamentally related to memory handling of VFIO
>> to justify said prefix.
>>
>> Here the code Cedric moved is really about dirty page tracking, or tracking
>> changes made by VFs to memory. Calling it memory.c would be a bit of a misnomer
>>   IMHO :(
> 
> Hmm, yes, the majority of the code is related to dirty tracking, but maybe we
> can view dirty tracking as a sub-field of memory.
> Dirty tracking doesn't seem the perfect fit IMHO, as this file also
> contains vfio_dirty_tracking_register and .region_add/.region_del which are not
> entirely related to dirty tracking.
> 

Ah yes, it's a small portion but still region_{add,del} is indeed about DMA
mapping and not at all related to dirty tracking.

It's almost as if we should be moving ::region_add/region_del alongside
vfio_dirty_tracking_{un,}register into a memory.c file and leave this one as
dirty_tracking.c / dpt.c

Which reminds me that perhaps vfio_dirty_tracking_register() and the name might
be misleading and should instead me vfio_memory_register() /
vfio_memory_unregister().

>>
>>> Thanks.
>>>
>>>>> ---
>>>>>    hw/vfio/dirty-tracking.h |  6 +++---
>>>>>    hw/vfio/container.c      |  6 +++---
>>>>>    hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
>>>>>    hw/vfio/trace-events     |  2 +-
>>>>>    4 files changed, 29 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>>>>> index
>>>>> 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
>>>>> --- a/hw/vfio/dirty-tracking.h
>>>>> +++ b/hw/vfio/dirty-tracking.h
>>>>> @@ -11,9 +11,9 @@
>>>>>
>>>>>    extern const MemoryListener vfio_memory_listener;
>>>>>
>>>>> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase
>>>>> *bcontainer);
>>>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>>>> *bcontainer);
>>>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>>>> *bcontainer);
>>>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>>>> *bcontainer);
>>>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>>>> *bcontainer, uint64_t iova,
>>>>>                              uint64_t size, ram_addr_t ram_addr, Error
>>>>> **errp);
>>>>>
>>>>>    #endif /* HW_VFIO_DIRTY_TRACKING_H */
>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>> index
>>>>> 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
>>>>> --- a/hw/vfio/container.c
>>>>> +++ b/hw/vfio/container.c
>>>>> @@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>>>> *bcontainer,
>>>>>        int ret;
>>>>>        Error *local_err = NULL;
>>>>>
>>>>> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>>>> -        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>>>> +    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>>> +        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
>>>>>                bcontainer->dirty_pages_supported) {
>>>>>                return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>>>>>            }
>>>>> @@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>>>> *bcontainer,
>>>>>        }
>>>>>
>>>>>        if (need_dirty_sync) {
>>>>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>>>>> +        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
>>>>>                                        iotlb->translated_addr, &local_err);
>>>>>            if (ret) {
>>>>>                error_report_err(local_err);
>>>>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>>>>> index
>>>>> 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
>>>>> --- a/hw/vfio/dirty-tracking.c
>>>>> +++ b/hw/vfio/dirty-tracking.c
>>>>> @@ -45,7 +45,7 @@
>>>>>     * Device state interfaces
>>>>>     */
>>>>>
>>>>> -static bool vfio_devices_all_device_dirty_tracking_started(
>>>>> +static bool vfio_dirty_tracking_devices_is_started_all(
>>>>>        const VFIOContainerBase *bcontainer)
>>>>>    {
>>>>>        VFIODevice *vbasedev;
>>>>> @@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>>>>>        return true;
>>>>>    }
>>>>>
>>>>> -bool vfio_devices_all_dirty_tracking_started(
>>>>> -    const VFIOContainerBase *bcontainer)
>>>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>>>> *bcontainer)
>>>>>    {
>>>>> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
>>>>> +    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
>>>>>               bcontainer->dirty_pages_started;
>>>>>    }
>>>>>
>>>>> @@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>>>> *bcontainer)
>>>>>    {
>>>>>        VFIODevice *vbasedev;
>>>>>
>>>>> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>>>> +    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>>>            return false;
>>>>>        }
>>>>>
>>>>> @@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>>>> *bcontainer)
>>>>>        return true;
>>>>>    }
>>>>>
>>>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>>>> *bcontainer)
>>>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>>>> *bcontainer)
>>>>>    {
>>>>>        VFIODevice *vbasedev;
>>>>>
>>>>> @@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase
>>>>> *bcontainer,
>>>>>        memory_listener_unregister(&dirty.listener);
>>>>>    }
>>>>>
>>>>> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>>>>> +static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase
>>>>> *bcontainer)
>>>>>    {
>>>>>        uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>>>>                                  sizeof(uint64_t))] = {};
>>>>> @@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>>>>        g_free(feature);
>>>>>    }
>>>>>
>>>>> -static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>>> +static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase
>>>>> *bcontainer,
>>>>>                                              Error **errp)
>>>>>    {
>>>>>        struct vfio_device_feature *feature;
>>>>> @@ -940,7 +939,7 @@ static bool
>>>>> vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>>>
>>>>>    out:
>>>>>        if (ret) {
>>>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>>>        }
>>>>>
>>>>>        vfio_device_feature_dma_logging_start_destroy(feature);
>>>>> @@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener
>>>>> *listener,
>>>>>                                                     listener);
>>>>>        bool ret;
>>>>>
>>>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>> -        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>>>> +        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer,
>>>>> errp);
>>>>>        } else {
>>>>>            ret = vfio_container_set_dirty_page_tracking(bcontainer, true,
>>>>> errp) == 0;
>>>>>        }
>>>>> @@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener
>>>>> *listener)
>>>>>        Error *local_err = NULL;
>>>>>        int ret = 0;
>>>>>
>>>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>>>        } else {
>>>>>            ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>>>>>                                                         &local_err);
>>>>> @@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice
>>>>> *vbasedev, hwaddr iova,
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> -static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase
>>>>> *bcontainer,
>>>>> +static int vfio_dirty_tracking_devices_query_dirty_bitmap(const
>>>>> VFIOContainerBase *bcontainer,
>>>>>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>>>>>    {
>>>>>        VFIODevice *vbasedev;
>>>>> @@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const
>>>>> VFIOContainerBase *bcontainer,
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>>>> *bcontainer, uint64_t iova,
>>>>>                              uint64_t size, ram_addr_t ram_addr, Error **errp)
>>>>>    {
>>>>>        bool all_device_dirty_tracking =
>>>>> -        vfio_devices_all_device_dirty_tracking(bcontainer);
>>>>> +        vfio_dirty_tracking_devices_is_supported(bcontainer);
>>>>>        uint64_t dirty_pages;
>>>>>        VFIOBitmap vbmap;
>>>>>        int ret;
>>>>> @@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>>>> *bcontainer, uint64_t iova,
>>>>>        }
>>>>>
>>>>>        if (all_device_dirty_tracking) {
>>>>> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>>>>> -                                              errp);
>>>>> +        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer,
>>>>> &vbmap,
>>>>> +                                                             iova, size,
>>>>> errp);
>>>>>        } else {
>>>>>            ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova,
>>>>> size,
>>>>>                                                    errp);
>>>>> @@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>>>> *bcontainer, uint64_t iova,
>>>>>        dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
>>>>> ram_addr,
>>>>>                                                             vbmap.pages);
>>>>>
>>>>> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr,
>>>>> dirty_pages);
>>>>> +    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size,
>>>>> ram_addr,
>>>>> +                                                 dirty_pages);
>>>>>    out:
>>>>>        g_free(vbmap.bitmap);
>>>>>
>>>>> @@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier
>>>>> *n, IOMMUTLBEntry *iotlb)
>>>>>            goto out_unlock;
>>>>>        }
>>>>>
>>>>> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb-
>>>>>> addr_mask + 1,
>>>>>                                    translated_addr, &local_err);
>>>>>        if (ret) {
>>>>>            error_prepend(&local_err,
>>>>> @@ -1147,7 +1147,7 @@ static int
>>>>> vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>>>>>         * Sync the whole mapped region (spanning multiple individual mappings)
>>>>>         * in one go.
>>>>>         */
>>>>> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>>>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova,
>>>>> size, ram_addr,
>>>>>                                    &local_err);
>>>>>        if (ret) {
>>>>>            error_report_err(local_err);
>>>>> @@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase
>>>>> *bcontainer,
>>>>>        ram_addr = memory_region_get_ram_addr(section->mr) +
>>>>>                   section->offset_within_region;
>>>>>
>>>>> -    return vfio_get_dirty_bitmap(bcontainer,
>>>>> +    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
>>>>>                       REAL_HOST_PAGE_ALIGN(section-
>>>>> >offset_within_address_space),
>>>>>                                     int128_get64(section->size), ram_addr,
>>>>> errp);
>>>>>    }
>>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>>> index
>>>>> 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
>>>>> --- a/hw/vfio/trace-events
>>>>> +++ b/hw/vfio/trace-events
>>>>> @@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end)
>>>>> "region_del 0x%"PRIx64" -
>>>>>    vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t
>>>>> min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64"
>>>>> - 0x%"PRIx64"]"
>>>>>    vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>>>>> max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>>>>> "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"],
>>>>> pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>>>>>    vfio_legacy_dma_unmap_overflow_workaround(void) ""
>>>>> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size,
>>>>> uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64"
>>>>> bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>>>> +vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size,
>>>>> uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64"
>>>>> size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64"
>>>>> dirty_pages=%"PRIu64
>>>>>    vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu
>>>>> dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>>>>
>>>>>    # region.c


