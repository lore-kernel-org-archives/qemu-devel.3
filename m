Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3400C54E6A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 18:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlCYR-0003sS-B1; Fri, 15 Mar 2024 14:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rlCYK-0003rs-HK
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:45:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rlCYE-0002qw-Mc
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:45:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FH8xBY030245; Fri, 15 Mar 2024 18:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tB5IPQ86MS1UFnDQsxjsK8Df7Ft8cvKMKme3ML/zUro=;
 b=nyb2K3Mai2WY5QfbkWYrE11WYXDmLycJ8L7CNBoBW92FNYp/SToQ78B/qxLT8ojGUxiA
 rt52ROTqjq/tWvDZa4YresGtQ7Tk8yHZ+Is6t07HvZsuKsIqNb85lKyn6b7+6hqY99fG
 tyDhIahuCApZ0usPCA0NY1GKxp9GAylv6DT6hDFOupjzS9bpepvnEGFtNDR1qp6ZWs6c
 QyHIwuJxDi9eoe8M6dvkZhNnaud7biBRUgC5LJmMZ5hTN5lEzJfkyPfWy+guWIQFTolq
 ocJQkPLEspNRb7URR0LE7hz/UnGN09z/AwG01lLlPGRO+62C/scHNf18kKHPplnDv54W wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvt34085w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 18:45:03 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42FHJJRX037703; Fri, 15 Mar 2024 18:45:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wvtmmkaas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 18:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h930eseKHE+TFkM4LIlxMeltavBBw99jRXak6d/hWVg2Dj2dfraTn/LjtxPS2YmyyeF9CjoRL7CfViXS8/XRJN80geHytzEG2rXzl8Ucd5Q4TbB2jQCH9g+wXY1jYC/GmR+lwmNQqDMyPaWj6ism3lW93W6QSMADzo0cQDO1EdznqcODDtV6D9Mf6X+Tu6dL4VMpU+pk9f4wriHx8SShnz8UJfaKGCK91zcqAAkRKyx1MnP9/Tih+G+YB7I5H+ASRkc4lyNYIw31L3rwoSPTYhem1M/bizZMOUnlDQAjhPKjraOz/MgOQ89/1GMd3Aq8N76Z3XL67srZlR3iY+DZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB5IPQ86MS1UFnDQsxjsK8Df7Ft8cvKMKme3ML/zUro=;
 b=T77bGfBgnsmM2Zz46S915uU5nlruYj+oB3YnYAY91JwOxOq514ZHFDpyevI3WIWLpiqVmBsX0/1bRKszv25/tNv5c6CCXW6r6UAuCRTRbDZta85eRevCfGxlPIcwLyAY5dkwMBuWFP4q184ZmYHR3a8HLk4cGN4/bLJ9NSAkroMzi0ZZSAwirWeZzjEZWC3RjtNNe2qQthfsh2uGHSi0N1G/qG9CUh3Axc80BLgQ6af94r385a8yqxXtridghpAF+rssuEky70NOeME0b/TIIkGO+vvFva8QIaAhej1oWQmJJOLSfzjOisDm5GSU4L2jlH5i3BuDV9jdRmy1VLrC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB5IPQ86MS1UFnDQsxjsK8Df7Ft8cvKMKme3ML/zUro=;
 b=C7Qx1RYV4JTXvgApbr1PII5htkTStxazaR3mOfkJTYlRPNhttEMJhkwZYhnL/8NrhqgFzGIG/aBMRlmHsyJvdmfopb4PHcrn/am5tK5u2JdxAb/IIjArUKXK57aey5rr23gwHpSweyV+ifbDRtIIPmYkSJ8BD/73FhFZXJyD/OE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 18:45:00 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 18:45:00 +0000
Message-ID: <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
Date: Fri, 15 Mar 2024 11:44:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: f34ba05c-7c7c-4505-eaee-08dc452004e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4itkGkhj0m1tqiQqRWVGSSO7D+2hqsMJYcMP+/El88lPOtwApjF1sYZvZdcpl0uYllqcyqbIBJIwD42HwN7IM+Lpe3/V5f6hjHUVyZdJgOjEqazFlSfPnMrb1MerbbNObXcdsE23xplge8pqGRuNnYuw4YI9WRidlaaiL8yZlQfRvgt2OgAygbLt2TEkFqrFaCI9qzilFIA64oJtqPYvKfM6C2wEhEEkwI1qBYQJtyJPtrlL5aqTN/cy/3EPdh+ZcIGv0WT0EIPzxC8I13kIPEYP+b/DQu5MSfiZAknh59LiJNhx4FBKOjTsHZ6fJ60i7cUsWRycsVzB8IBBX7hxVLeQ6sqKP8J/8PVbj+/UcvkN7Mhj7xGALHguWayYxKZsxSoX51+WtyMYmVjCHSgnMNgdml6e+xZfCzkhhL7CuuRucPLMvJ5NiZJ/LUN+63tNvITqXPmna6Qotz9HXd7ViuFZ/9Q+Q7ImcTPjSuloraslJiomr68QHt5IqINuhAZcYjIW1tjN4YGNg3+wOcCpgkqHoHR+v2gBf8zbcXUyGz0DnQJNea0gqFuZrqqu4Sup+R3qVNihLlDjReDtqCfpO0biqKB1qtaQC/IboqTZJ/Tno7JnnEbOTH3uCyLlzepfltqmuviFoss8OyxxVgC34DH3z+dfsbqkteudsd6mlRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJCUFlXSmluNDBPVForek5HdWpmWTBrZ3lUbFBlVTRCVnNkS0dvRDhFOEtq?=
 =?utf-8?B?dXVTanVlMXl2WStzbFZtd0xvVjdxa1FDWHFZdjY0S1lwd3FVSzJkdmFtZGkx?=
 =?utf-8?B?Mm5BK05QYzRkdnR3UVd5d2k2V04yWW1QcnoxekxFWFlRdlpNYitRRnBGUzRF?=
 =?utf-8?B?aHJEZXVFeHNsRDZrQjkyQ1RKVlE0ZEhndGhSb1BYN3NZaE02N0htMnZJQW8y?=
 =?utf-8?B?c2xmTXppdkNhRWw2dUljUUJZMlhFQUIvUmdEWjJlbWo3L1BKTDFaM2Era0ZW?=
 =?utf-8?B?aEFFL0FBQ1BrSjNpUGFjeHIwS1ZjUjY2RnkxSEJkeWQxbThSS3YwcVlkY0xH?=
 =?utf-8?B?dTUyNytYQlI2N1Ayck95UmdRRDJBUzZjTlE5ZzVMbTJ5SFdselpkQUd6YmtK?=
 =?utf-8?B?V3dLcFJ5eUF0WWtqenBoaFIzYUoybzdVaUpaU1ZnNVB0SHdmMUtBdFppYlcx?=
 =?utf-8?B?c1haYlZLcUtuL0YwSnhrUHprdXdaMkZjR2Nhd2VLdDdXQkVHUitxQXRkaTll?=
 =?utf-8?B?RVZHd1U4L3ZVSWxQL3BITHMyZEVDaUxDeENBMmNUTGN6b0puMlQvcWRLWDZo?=
 =?utf-8?B?VHpMMlZsa0FNZkNicmQrVDZuQzh6bEVzUmkyZFBONjZiK3o4MFRocHpuOHlB?=
 =?utf-8?B?R0VvT29Qck1HZlAwOVlCTnl3NmZxZTBrZzFqMGx1eCtMekYzUWlBOWEzYWov?=
 =?utf-8?B?ZUlhR1pIa3dNRUg1VVlLc3Q5R1R4cURzTTZNamlQMjY0YUdFY1NpSHVwZStR?=
 =?utf-8?B?SmV6cjNrdkRVSERrODA1Y1M4TVZjcVJvNzZPMHlmZ3A3RTdpY0svRUl5VE1V?=
 =?utf-8?B?OUozOVVuS2IweWhmQTlRV2hZNjhuSUFqZUpKek5tOEZYNHZQK3Y0WkF4RnJC?=
 =?utf-8?B?cTFNVFpCd2U3WjliYitBL1U0cUdIZHZHZUFWQmNwcWlvNyt6cmZ4UDN2VnR3?=
 =?utf-8?B?aTNNdnVFZXpzUnlpcmFsRWoxNWtSbUMvM0NveVhkZ0VkNzBnZGlGT0hmSi94?=
 =?utf-8?B?dVM1cmhUNEhCamk0YjdCSVJ0QThSYjZOZjdUSG0vUXl2WXdhZ1Q0My9wZDJ2?=
 =?utf-8?B?ZWo2WnRVcS9wVjZDNHhxWU44aGJ5OS8rT3hQeTNkMnhFZFJGSjFBekUyNFVt?=
 =?utf-8?B?Q09OSGQ4Skoyc1NzK2Fud3l2UlZFS3lCOFVTK0hGcXE0d1VhdXUvR2NxcE1Z?=
 =?utf-8?B?S1llbG9lVk9XWGRWbDVLaDhvV2hHZG0rWFVmbnVMb0J5M3dBUy9YeVcwdGlG?=
 =?utf-8?B?UUE0ZEZleTdXYnA5OHBYeHdVMTlmUlZVNE1kOWk0c2duRVZTbXhPeXQvSEZU?=
 =?utf-8?B?NCtXM0dNZWdYYmY1YllUZEV3V3FubnpXSUM3Q1YrekZ0clBYbFlZQWdST0dm?=
 =?utf-8?B?T1JmS0NSZ3lPRDNLdllnZEdJN0dKck9mNUdCMXNORURycU96ZEhDeHc5eWR5?=
 =?utf-8?B?c05VQzBuMnRYSllSKzM5Yi90bmpXN2tDMkxQbHYxQU83Q0FwZkFzc3JSL3lq?=
 =?utf-8?B?SmlKaC9VeThSTE5VZkhKeEU4VWtDVWEyeCtoMWlwejhzZStlUHQzdGJnWlhr?=
 =?utf-8?B?OHNIaTU1a2tFOHUvdE5LNFJjNUZVeHlDYlNDMFVBVUplSTBNaGhMMUxwY0Ry?=
 =?utf-8?B?djd1aW5xUnpoY3pBU3dVcGFMUVpteXowZ3V3eGpDUytRZ3ZlNFo3aG4rTXEx?=
 =?utf-8?B?Q0dTTWRvRGw2TFlIUk1PWnBOUjVFZVBSNkl4ODJaa0VzdHgvc2NidmZnVFFK?=
 =?utf-8?B?am5IN0d0RmpoeTRhNkxnT0tDaDVTUWVMZk1aTkh6NmVOTUg5QmRaNXB4R2Q0?=
 =?utf-8?B?RTJvREU3UEFvRE95akhUSHR3cVRCd2hwVXZLQkMxZXI2dytSNFFjUkNBQWIr?=
 =?utf-8?B?S1N3VVpZSTdKV3lnc2lxV0ttSy8yb0RMNmhndW1kN1JyemdCYUF1RXBYM2dT?=
 =?utf-8?B?NkpSZVV5SnhlaXd3TUNtLzhiQ09aQW1keDVaZmhuZW0raG51YlJ4NFRsSFJp?=
 =?utf-8?B?R1hWckhZbHI3S0psTDJxakl0bHhHcmpxMmRLSnh3cFZ4eFB3S3NhcGJYWEtS?=
 =?utf-8?B?TG8rYnAwazBYUkhnc01OZjVHY2JnSE5WQ2p5TzY3UUZNMWRyckluRUVacHRU?=
 =?utf-8?Q?7sGAhiJUoc566zxoPyjbgr3ag?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8v/xT7nlIYjAHRVIS7IMR36y+GJaijaTrT9xaeqdrR7rmiKx5YlsuxxcHRCfl4/++nuN9KW4ohQ64CvTZ/XtvvN8M7UQrstrPXTzUyDsWpsg1F40JTHSrKkfF9IiqTB1fsY97zT2fngPviy9eqRw8eELCPSNlh1H9TKTFvaSVWIwNq5A02hVAXHYP8GLQgO/5yaYhcIKWwclBgSfqcRusyn+XbpNuIFzvTjTbPRdeJephgHP2uhT8SVhQyDsP260BIoEkehWpv510GlOCqjd1qQ4pLKeulfGmV9Gm15kky1MdnLXcjEjwXOVHO+8lc1rmDAX3UeF4c7XCq2XpgTnB1E6XNuaWBanCAanMN/ul8yxqPHkLvI7jkGvwepO54vJ4avCDYURJzPoVDxw5zdriLlxzjJOwOtRRpz/gqKWdqkrjY7Z1JkNNvQQLmY7lJLdM0DWAOIW61p3oV6WI5bhMbl+q6Um65493uY+ptsOlNL2bxjWWHwaCElnU+dYI0eBif2kxpzwOm3Jab81N0plHhC3kpYtRP4Y3lJWSskJU20fkG96VEt+GGM14v+QI6somoYxUDXVqUDqv2nj32kMasEmukPM0Cu+Q/9+aHCFvtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ba05c-7c7c-4505-eaee-08dc452004e7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:45:00.4795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8gTgfEiHIBoAfFRQzQjSf8tkGCCi6YpO1girzGBNRt4LYAnU8qCHZe++bOXaoeCUdE/1RkdczKm+HkEX8dKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_05,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150152
X-Proofpoint-GUID: EXy9wbGsMTF1sbzTM9P-bmxUNFNs7ryo
X-Proofpoint-ORIG-GUID: EXy9wbGsMTF1sbzTM9P-bmxUNFNs7ryo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 3/14/2024 9:03 PM, Jason Wang wrote:
> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> On setups with one or more virtio-net devices with vhost on,
>> dirty tracking iteration increases cost the bigger the number
>> amount of queues are set up e.g. on idle guests migration the
>> following is observed with virtio-net with vhost=on:
>>
>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>
>> With high memory rates the symptom is lack of convergence as soon
>> as it has a vhost device with a sufficiently high number of queues,
>> the sufficient number of vhost devices.
>>
>> On every migration iteration (every 100msecs) it will redundantly
>> query the *shared log* the number of queues configured with vhost
>> that exist in the guest. For the virtqueue data, this is necessary,
>> but not for the memory sections which are the same. So essentially
>> we end up scanning the dirty log too often.
>>
>> To fix that, select a vhost device responsible for scanning the
>> log with regards to memory sections dirty tracking. It is selected
>> when we enable the logger (during migration) and cleared when we
>> disable the logger. If the vhost logger device goes away for some
>> reason, the logger will be re-selected from the rest of vhost
>> devices.
>>
>> After making mem-section logger a singleton instance, constant cost
>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>> queues or how many vhost devices are configured:
>>
>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>
>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>> ---
>> v3 -> v4:
>>    - add comment to clarify effect on cache locality and
>>      performance
>>
>> v2 -> v3:
>>    - add after-fix benchmark to commit log
>>    - rename vhost_log_dev_enabled to vhost_dev_should_log
>>    - remove unneeded comparisons for backend_type
>>    - use QLIST array instead of single flat list to store vhost
>>      logger devices
>>    - simplify logger election logic
>> ---
>>   hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
>>   include/hw/virtio/vhost.h |  1 +
>>   2 files changed, 62 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 612f4db..58522f1 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -45,6 +45,7 @@
>>
>>   static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>   static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>
>>   /* Memslots used by backends that support private memslots (without an fd). */
>>   static unsigned int used_memslots;
>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>       }
>>   }
>>
>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>> +{
>> +    assert(dev->vhost_ops);
>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>> +
>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
> A dumb question, why not simple check
>
> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
Because we are not sure if the logger comes from vhost_log_shm[] or 
vhost_log[]. Don't want to complicate the check here by calling into 
vhost_dev_log_is_shared() everytime when the .log_sync() is called.

-Siwei
> ?
>
> Thanks
>


