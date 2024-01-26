Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA67C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTRF0-0004Si-9D; Fri, 26 Jan 2024 13:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1rTREx-0004SB-TW
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:47:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1rTREv-0001M9-QB
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:47:47 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40QEi3oY024923; Fri, 26 Jan 2024 18:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lHLrXIis/rXFYWUOdmcQl8FUyqmmCH5OpAJkpV5Z7FE=;
 b=kePXKZ2RGjzm2XK7Rs83gadZWaoDG2JCvd7z4/W3SGCyd54gnsd2yEYmAhBxXZgUlxOd
 uYWSPin+k9Q/fDdF2jwqxUpQ9ynAHGo25mnX8zUCsCVQczWkkOq/rZ6aktTBymN+BeyV
 FrXgGa1/Cje90BVJVS/MD1JsCQ47PkX5gnnMXW0ZrORgpZkxOG9V7MVVeMwn76l+mFFD
 CZZu8J3zNpD7xj3q8xLtC7y5YJb5kwyd+7POkObtjvsTstzruiWZLQp6WjJjK+rHr7Oc
 ++7jq6lBeXgdHJHyd7YYkXm4CxM3H5RNRoTvqgQrRGSmDD87Zul1dZeZ+neboKAgyU1L FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cya4qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 18:47:41 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40QHRiVq026155; Fri, 26 Jan 2024 18:47:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vs31aq5v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 18:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDHg4yjgEzYIcDsgclr4hue3llgrrNyZuHNHeyDMB2PXUO0sLqnMPuicYtGMZUAaCG7SL3fhWO+I6wah0/NksOGjOtBAFRpHyU4sBjL5Trg2JwzzrW4l4OPOBsOzCTy7NvivM+nIfaNQT0FDrIQhe+0kQtRv1Frx/UpUAJeIsmHUpk53VC97zrDwIgybPfWzhB04oBeDnYE0mvMn+kwySbnGYJ+byMOd3mmjXfIV6LaJftXbVmcOOm3YeQtNZSK13kYKoihk18ELGlKR+lHJOrilTx0pemDDiwR1WtEhphw1oz0/f1ZM04QNLNE+7AgXhdYgMx7hYIlncPjz0iVZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHLrXIis/rXFYWUOdmcQl8FUyqmmCH5OpAJkpV5Z7FE=;
 b=l9P/PdV/kcjHgltaIzaaAYDdChYv46oqRfCORERtCrjMQQUVNyYH+a6r8Q4zufM4nNp4t808s+u10thOYQl15cnZxgNJvPn+3phtXbR5Ro8/6AfcswlCGjN9pp+kP+Qcl9vf0e1XqYuHqLpWOFjwvr0aL09yvOXZECEV9nagKj+1upXksZSHoXShlQbKh8avHTdl73V1cACDOcUi9rZlag9mI4wqPGDYdjVThWTmLJqE7W16dcWyXp9f7QZLZCsUxh+TfL+YX10zlUgNXTDXo1h9Na5lu/PKKwVkQ9wMhstRHAZxAlUCGjN2Ljk40vpGA29RQnd2ycbbQpIZ43THKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHLrXIis/rXFYWUOdmcQl8FUyqmmCH5OpAJkpV5Z7FE=;
 b=YbzOAPMI8J4KcT1binhT1DkW1Zigqbw3uOT7D6fSaRUv+04B8fCj3DmeOnGfj7ZC5Q1MUJlwk9YMc/7er0ACD+ep0SPifr25fVIwn3d+yv13zw8VbbLJBYt5Wsyw98OrHaogc8KV+QXUErvyGGubtyFcVmW+lHlhUXoAG0rHuR8=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 BN0PR10MB5032.namprd10.prod.outlook.com (2603:10b6:408:122::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Fri, 26 Jan 2024 18:47:37 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::2067:811a:3ac5:b30f]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::2067:811a:3ac5:b30f%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 18:47:37 +0000
Message-ID: <287bcc2b-3268-4622-a649-8ce6b7e4f8a5@oracle.com>
Date: Fri, 26 Jan 2024 13:47:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] hw/misc/pvpanic: add support for normal shutdowns
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de>
 <20240107-pvpanic-shutdown-v4-4-81500a7e4081@t-8ch.de>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20240107-pvpanic-shutdown-v4-4-81500a7e4081@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:a03:333::9) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|BN0PR10MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 10872230-0bfb-496a-a378-08dc1e9f446b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zm7Hv64JPRbwi1XszxYzgNuB45VdMCM8FmKugdfdbX9Um572VzLshht53TeXyygL2qzgR1xZLGJW7C0e35BY2/N158GOuHlUMC8gvQ4hDBg1okb+orzpEQ5DwejfhYWdpDN0X7pmazfYOJ0lS7W+Zq53v3ie0g1JHFnchs/4OFXi+43+CmDltBmsi1mVxkvfL3/ONK235G89NgzOWqAkkvbR4QRAzAawq9YVo9ba8r4/R23H3fDez+4tNOORl+yepyEQxWeTjw7/t5B/PrNelueHOyn1W8ODEsEbMmSSIh+4qTgqWsxtZg9DVm84jrIn/AbOAC6SQ1+7uo4pn8wnu4ypljtwk3f99kO5PqyBuHH+iFlsIM7T/a3k6gud/pxAonu24v7zR4OAI2ya4QmIii7Ib04tTX2G8V8vW8Sb+PiqNjiAAmJbZhdo+EE24kadXJzi9RUVkI5U05ozqYxMH4fEJ62nehDYMz+qnwNeL5AkgtyuXPHtoua41MT4SOgo/wkLpSmhHZhLvXOi4noNKejieqwXZQ0P/sfgKu1GshyJ83NG4bpEhFWn2oA+RQK8Su8Mv4ActElJlWVdTnBF7Wzhf3OaazUKOFD2VnykRmEyE8vYAW2Aw1BNaBKt4cWdBjX4crw7YossuWneoJ82hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(66574015)(38100700002)(26005)(53546011)(8936002)(4326008)(5660300002)(8676002)(316002)(966005)(2906002)(478600001)(41300700001)(6512007)(6486002)(6506007)(6666004)(66556008)(66476007)(66946007)(110136005)(2616005)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3IyL3JZdURzVE9xc0ZpTGVYNk1nMnI0UHNtYjkrRThIdTdzb0dsMkRMUUtp?=
 =?utf-8?B?T0hQMXowdGpHZC95alJjR3FabHhlakIrUVIyWERnakxwbUxZUWovd1BEMUJt?=
 =?utf-8?B?NU81TlB4QWNWK2ZQREZaOG5FU1Vtc2hPdkZ5K2d3NzBMcG04akkvc1VjYm1H?=
 =?utf-8?B?QWhHZHVORXk1MjVLTVQwc2R5T3BsWnZIbWQ4d3hZOHYzNnVSeUk1SEdSYW9L?=
 =?utf-8?B?bndoVlZUVXZmZEpjdi8zaUFnSzQ2R2RxR0tyZ3pTMU42d2hyd0tMMUJURGI1?=
 =?utf-8?B?YXI1YUM3RzZ4UG85cVllYWFKemRSbVRMRlFhQXZMOHhHc2tNcS8rK0JUbENk?=
 =?utf-8?B?aWdLWVVuMm9HR3pEQWZPNDNRMWQwaVIyN0gxZ2lQbEppZ1FWbmh4eWM1K0c1?=
 =?utf-8?B?N01YcHlKRURqQzlaZWE5eXJ4Zlp4WnlyMVRVc0ZJTEdvRDZMbm9BSDFXUmRl?=
 =?utf-8?B?dHZRc2E5RlZCZFE5dnlhb3JWQ3d0Q2pRbW11RXUzV1hiVWcrMkpEWlBQUVRx?=
 =?utf-8?B?WkE0R3E0SkIwcHJMWWhYSWRWbHpRSE11RXg0aEhDRTRROVRmZjB3ZG9MdjdQ?=
 =?utf-8?B?d3JzK3E1djNVdGNXK2pZekorY3NyY2Q0TXJ2amlnMERKSDJmdEZwVkxtZlEr?=
 =?utf-8?B?Wk5tUzJnaHVSRmRMY1hBNFN6cHQ4S3BHbUZMVnpMdWVHNkI1SHVFS3l1cFA4?=
 =?utf-8?B?Mm5lVkl1dG44U1hkNXpjQUlPMmFrRzJBK3dpWm4vK3B0MkJGQzIyWHNPWElL?=
 =?utf-8?B?c0ttVUlITUNkWmZxRXh0TlpKQmxNOHJySnVzbDkvaFhjYm0vTUNGN3JvMVho?=
 =?utf-8?B?WStIY01tQXFwbWcvRTdoVzlIZy9ENjZkOTExNGxQa1VwWmVHQUNaY2lCVWhl?=
 =?utf-8?B?dDBqQmlZRGdqdzhrallOUnBlUkVGbTJEbW1UL0JONEJ6aHFuUnBMRFpWc2VF?=
 =?utf-8?B?TFJRUHh2MjFadkE5aW9NV3JWQzBreDVzMnVZVldUWUtWdVlWWmdxbXpYaGpV?=
 =?utf-8?B?S3N3UWF6VXJONEJaeVl6eWY2bStCcUNWaFFGRW9XM3J6UDBrRWpXTEdBS2ps?=
 =?utf-8?B?UEN5TnlsVGJoM3VrRVR2VDd0NHY4cEpFSVhKbGFFL01vQ0l3bnBVaUYwdkp6?=
 =?utf-8?B?Y1ZNZ1VleEdVZStsT3ZKd0wwQUtLNU9FSGFNL3ljd0o4Zno2azdnUitOdCs4?=
 =?utf-8?B?dWpjUHFEdkxDdWxjV3RpZVpxbENXT1RYZ3lYMDdjeG9tc1cvdW9JRENpTitP?=
 =?utf-8?B?NjdhYVJOZ1FTNE9YZS85VUFIemd0dWhKd29pY05DY0FTS2lXL01JV2MrS2Na?=
 =?utf-8?B?OE5yOVJ3eXhzL0grRmNiN1BSU2hWN3VHNVg1eFpQeERHVFcwY0VGYjBqMDlI?=
 =?utf-8?B?Q0R6ZWhpekd5aWRUWThBVm0zbXJkQXQydThKcDZaWU96bTFNaVB5QXJUVFRq?=
 =?utf-8?B?K0ZpTXRhWXlvRGg1UUlJYnVjWCtyVUl1Z3Y0Z2xMY0tTNGl4ZzNXaE82MGVr?=
 =?utf-8?B?UEZBQ0pacnk0dUZqcUZEbFlXKzVsWXhEVmpaNGRMY0RYZUhvQnd0RVg3MjlN?=
 =?utf-8?B?QVdYajQyVHprQjd4My9PRCsrUTRNalpOUkU3N3kwSW0xQ1Q4d1NoV29UOUVq?=
 =?utf-8?B?eTZoYlV5MUlRVytJaTJOOTRaajl1TW1vZUJad3hYS0dQenIvTjVkc0JMeDUy?=
 =?utf-8?B?VUVMQ3lnR05qWVR0RXZKSFM2aFE3RFpyZDdNd0dET1BFOFJ4Yks1akIyYmRs?=
 =?utf-8?B?ZjI0UVNZM0I1NkdHRFU5OWJRQXlRVFVQZk5hbTk3Sk84Nlo0SHFVeUE2NE94?=
 =?utf-8?B?bEdlaVdaZC9uZko4N3l6ekVZeWFHWi90aDMzdloveThiSmM3TkVYY0U1V0tD?=
 =?utf-8?B?ZkNQamFDWlM2U3MveDVDN3RDbEg4T2IyR3lyZjhLR0ZiUGlhZ3kyQU90c0Q1?=
 =?utf-8?B?VG4yNVI3SFNmMGZ4ZXZaeGszOS9NVVB0U3FUM0hpcnJaU1NOVDhnUDBkN254?=
 =?utf-8?B?blc0RlJhVnZOcjdOWFlDSUsxMHdxSXloNnF2RjBWdzFkbkZ2ZExUczhoWXFi?=
 =?utf-8?B?VUEwWEw2bXFKbm5hRUZRL1VZQUpsRitYc3VqV29OOXJUWDNIMDZqbEphbGhX?=
 =?utf-8?B?NjU1Ty9TMUV1Yk9FTnRsVThBYmJLaU1kZ0Y3aVNrb0I4ZlNucGdCRGlzeWtP?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /Xohxdek3CmtYbIVRf5VM/7dMJjc/7XP5DXx+1Dd0MiAHXitmBKxKp2eletd04eXZqnKRknJXjZCJMAEo8THfMVQQgUHbPsSW46H4Vyy1oHBz8qjv8Khl/AoIR25hxOrVxwAQRgoC8EUOFEBXAWUHV4Y41k8ARg/tslqxq7GPu7V4GOyPaZspnFT7HSwZTtNs91YQ75WbBRw8iD72zEX1Oc1/v8b61kQWElKtrI8rsVa9ldN9sf8buggPl7ey0ZahVhSHVJlwZzWNQdjjH9N6mxRoMne1b3nWyS/rv87PuBVSCAnTSQGO3RdTISLMFnShv7WJ9FmEqWF1GcFy/FmSaIH6h4hal+V6PfI6Gnvvf3jFWcQEEhXq2hE+DpLoEo0oAgbc7v/5ndxhHy/vz8XrXhTCRNI520TGfyEl9Tq72uyqb3usaNLzVwp7H9Xjau7IGO7S3cgSXoGeCPfUf02nxbQGMqQTDbJu1Ou6JoC/rVRopKGVuYTzZpqqUsw6Tnb2R2HgEGQB37b3busWCc72b4MvKYnLixttrhf0T9DoIHpdAnOZdiAnphbMB78TRuNYrc+ofB2j+1KGhkXEYadErgy98VPCnqU0+Ms/SyTUjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10872230-0bfb-496a-a378-08dc1e9f446b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:47:37.7676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qC9D53YWcgDM0bJkUdWGxjeI1zJPC0wutgO7838UxTST0u4OYEQ6gZqsJFHm9IInEyUJbap2Y+KLVho4VJWpKG1jqIshG6ZjXqKqF5O8OrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260137
X-Proofpoint-ORIG-GUID: 2XV1K81wzWT_S0PqDCQ_L-IMsQYJkWmc
X-Proofpoint-GUID: 2XV1K81wzWT_S0PqDCQ_L-IMsQYJkWmc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Thomas,

On 1/7/24 09:05, Thomas Weißschuh wrote:
> Shutdown requests are normally hardware dependent.
> By extending pvpanic to also handle shutdown requests, guests can
> submit such requests with an easily implementable and cross-platform
> mechanism.
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   docs/specs/pvpanic.rst    | 2 ++
>   hw/misc/pvpanic.c         | 5 +++++
>   include/hw/misc/pvpanic.h | 3 ++-
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
[snip]

>   -------------
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index a4982cc5928e..246f9ae4e992 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -40,6 +40,11 @@ static void handle_event(int event)
>           qemu_system_guest_crashloaded(NULL);
>           return;
>       }
> +
> +    if (event & PVPANIC_SHUTDOWN) {
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);

I would suggest that instead of directly requesting a system shutdown, we should follow the same convention/handling of the other pvpanic events and emit a QMP message signaling the specific event that took place, to help a management layer application that might be listening to determine the cause of the shutdown. It can also be a helpful signal to let us know if a guest is (ab)using the new functionality.

If you agree with my reasoning and you'd allow me to piggyback on your series, please add my complementary [PATCH 5/4] change that implements the suggestion:

--

 From da4355344771206b69fc97d40ae9cc6510239e14 Mon Sep 17 00:00:00 2001
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Date: Fri, 26 Jan 2024 17:54:16 +0000
Subject: [PATCH 5/4] pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic
  shutdown signal

Emit a QMP event on receiving a PVPANIC_SHUTDOWN event. Even though a typical
SHUTDOWN event will be sent, it will be indistinguishable from a shutdown
originating from other cases (e.g. KVM exit due to KVM_SYSTEM_EVENT_SHUTDOWN)
that also issue the guest-shutdown cause.
A management layer application can detect the new GUEST_PVSHUTDOWN event to
determine if the guest is using the pvpanic interface to request shutdowns.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

---
To be applied on top of the series:
hw/misc/pvpanic: add support for normal shutdowns
https://lore.kernel.org/all/20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de/#t
---
  hw/misc/pvpanic.c         |  2 +-
  include/sysemu/runstate.h |  1 +
  qapi/run-state.json       | 14 ++++++++++++++
  system/runstate.c         |  6 ++++++
  4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 246f9ae4e9..24001b9437 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -42,7 +42,7 @@ static void handle_event(int event)
      }
  
      if (event & PVPANIC_SHUTDOWN) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+	qemu_system_guest_pvshutdown();
          return;
      }
  }
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4..e210a37abf 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -104,6 +104,7 @@ void qemu_system_killed(int signal, pid_t pid);
  void qemu_system_reset(ShutdownCause reason);
  void qemu_system_guest_panicked(GuestPanicInformation *info);
  void qemu_system_guest_crashloaded(GuestPanicInformation *info);
+void qemu_system_guest_pvshutdown(void);
  bool qemu_system_dump_in_progress(void);
  
  #endif
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 08bc99cb85..d5a63e14ba 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -460,6 +460,20 @@
  { 'event': 'GUEST_CRASHLOADED',
    'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
  
+##
+# @GUEST_PVSHUTDOWN:
+#
+# Emitted when guest submits a shutdown request via pvpanic interface
+#
+# Since: 8.3
+#
+# Example:
+#
+# <- { "event": "GUEST_PVSHUTDOWN",
+#      "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+##
+{ 'event': 'GUEST_PVSHUTDOWN' }
+
  ##
  # @GuestPanicAction:
  #
diff --git a/system/runstate.c b/system/runstate.c
index d6ab860eca..02b0a1f8b9 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -572,6 +572,12 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
      qapi_free_GuestPanicInformation(info);
  }
  
+void qemu_system_guest_pvshutdown(void)
+{
+    qapi_event_send_guest_pvshutdown();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
  void qemu_system_reset_request(ShutdownCause reason)
  {
      if (reboot_action == REBOOT_ACTION_SHUTDOWN &&
-- 
2.39.3


> +        return;
> +    }
>   }
>   
>   /* return supported events on read */
> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
> index 48f2ec4c86a1..9e36a02d5a4f 100644
> --- a/include/hw/misc/pvpanic.h
> +++ b/include/hw/misc/pvpanic.h
> @@ -20,7 +20,8 @@
>   
>   #define PVPANIC_PANICKED	(1 << 0)
>   #define PVPANIC_CRASH_LOADED	(1 << 1)
> -#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
> +#define PVPANIC_SHUTDOWN	(1 << 2)
> +#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN)
>   
>   #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
>   #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
> 

