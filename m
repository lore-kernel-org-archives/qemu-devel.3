Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336A7C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Va-0003ui-6i; Tue, 27 Feb 2024 12:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1VY-0003n8-Ld
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:44:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1VW-0005WK-W3
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:44:48 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFYolL004377; Tue, 27 Feb 2024 17:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yk99uDn5ciKARJBm0nD4bvUpUThEPZRDh1lTaRvelDw=;
 b=onXYdY+WHs+gjZ+gEcOmaHkOcob+YqYJPj1d1EeK82UJbVN9Gap5N4ovnha0gVYmlfsf
 EPv623XWz5lkLZMXUNweKaf8LkDIkA70RXlF3+oHEQgDj9WGDw9KRIMX71B8PFcoUHu/
 LIrFiJVNh+TFFaE2bth0uZwhupAAgaQYvOsaALrCoPUP2hJB+R0E3CAUubt/jeHCi8g5
 gds/2rGTXmfxXh9i5AQoxgUPAbO+xwvMktb1e9iNkfdmjNyvYbSp9Mlw3pEhyawHNlwE
 +5LvTMYjtM0qX5jCZSCd2kD45XMOARNYp8eNotppF5LY3AXP4xP6d+vwuivWZ17wKzuZ Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccfy5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:44:41 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RHgXZk009884; Tue, 27 Feb 2024 17:44:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w7jpdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEsSCYupXdM+Re1ui0qoKVnnxSBRy3VQGnGh3qhbw9wPWL70Hv16Akc3+u8lXwy7P2S/Yxlw/DSfkfD9JcvO4rDMYOYDVHaIDff52/Q77WCRu28T3/4xJVBTcrbL77tdsYCOjggd92ArmxzaRHIJYIdChCrwKc87M7MtMmCcEVZD7QgEsv4NaRfKOOz4Z9pRHYiqHFIqQjw6sut+zie/7eDc7iV5ANvMIy4e1YnhvtDxWWJ8SD0rYo0I76cA6xwB3sSwcrm7xMwud2S3FJnuK2+aEe7nszj9/q/CW6uDl4FLkPqLbb7QvYWsFNS7aVjJ6T8Rv0HEPUDcbWupBuLVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk99uDn5ciKARJBm0nD4bvUpUThEPZRDh1lTaRvelDw=;
 b=JcaWyAQeRmmlwP+QXYUPcmwYYQ48m2SZGFjIXxUc1M88KiCmwozaTj8AROoIzkYhXjnqvP7x6kzWfBFcGqr2IGc0nAKCKQT9pG8ch8iWJTngtaL/GDr/GDr1rrjf9eEJt5Bap+atu+ySxs4XljXHdHL3IRm+tL3bA08ePqXZbYgBikSxJliDw7e6zvWkHAwenpDW1X8hW3MUPaVKl9BoSb7OvXkGV+SzCTuclhb0Etc0vJ1G5yYVVIChyFfFIstrZ+Pl66xDoi2wCl6h9aqU1+hHEz/bzN67TCYn8kXBy7i/wmQpbruV8rsG5VwlkOyOnlz0TTSdjMR+tNO+/8mrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk99uDn5ciKARJBm0nD4bvUpUThEPZRDh1lTaRvelDw=;
 b=CuxPeVlNRTS4QlC8IwS8GemNilAjULCvIZzyjhyJzNOJnUw9pChsKMdalspLNTb1eIndDoWLAQ/xskSdkHCkqlnjltY2O1qdcZKhYDsobNV7p5dtxIfO0bJ39YTu1/uMjXQ8RgNBd6PHANLI+Tu9xz4mv90FqRp2KOXQ0KxWVNM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB6853.namprd10.prod.outlook.com (2603:10b6:208:426::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 17:44:38 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:44:38 +0000
Message-ID: <09afc07d-b9d8-449f-9ac9-0eeca2a5046c@oracle.com>
Date: Tue, 27 Feb 2024 12:44:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 00/10] privatize migration.h
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>, Alistair Francis <alistair.francis@wdc.com>
References: <1709055731-315052-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1709055731-315052-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc4c96a-26fc-48e0-6500-08dc37bbc4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1YQGUybud979tfmBpViRq0AlzhQPHDqW+uZRJUwJAVMnga1xlR/T9/5e0WBmTARS9CjVeLJmiQrbYng5jPHh6xoO8Zn7/W9GgQzMH8ncn04+41xZHK8FT5X/TRH7c6R1jnHiR5tu+zYQflufG7S6axEKAHipbRFDQdW4lX9kZp2MkFF5s7P28cPu7u07V3tVmi1ui62G9Np24dBFXYKjAY8oyfd+VhNCAr5JBXBQV7fN6a5opNregaiTydwKR89R9ko8+E+YjcIwnZmGEWeNoEaGrK/52pblhMk9LeVzeI24qzN3Qqc5rUJsLc6QgsRNsHbnDYZPte1Ii90wkGhZC7rvngVyaOLjrrVAYwpjpvGEqYkkDMfECLaWI13nxfPIjrZZtCpfSZVOcfPdP+k9VF2jGos9k1BjK5H1U6M+an+k7bo7ENBTEYcxQhu3fbrwEvp8E0IQB/dM1NEgfGWbDNSwxaRW+1PRp9uUOzoIo2su5tZ8OC3IMBcih59rOc6D+GiFAfi5kcBuD07myIRL/1/OOlqrsdbexZtsZQFd5ij32gA+3MzJDaGUiwKcDrR/u5z6U+FHcWbEBdoFCuU9UFr3rUkzAybTbO037H3NSZkZKKklUlNPMRI6z+uXObYmA04hipBOqVP2nByDRrj3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xRditob0llYTdzaWFTTThtTXlNL2kzQnFGR1poVlU2SS9DdFcxZC91KzR5?=
 =?utf-8?B?dzB0RVA3dy80cFNRVXRlSCtVSkNqSFE0NVkvdnd2dm1aMWgxRnN6RjNNZDRO?=
 =?utf-8?B?eGVaV3BlMGhPUFZ0cThNc3Q0azBLZHYxUmN0MVMzZHVtakMyajhDOGRTRGxx?=
 =?utf-8?B?dVZ5aHRTMkl1U3FmSVQrdnFlRlc3SUd6U1RWS3djRHc2bVF6Z21mak9JcWtO?=
 =?utf-8?B?a2hEUUFHUExFc2JrSGY1OURDTTFkQ24vbm96VjhFcWZPZ2lCUmFtd0diNksw?=
 =?utf-8?B?R2czRHlXK2FHNzV6ZFJ4a3BRTWc5dmNRSmFQRWI1OExRcEFudHA4SFg1VjVX?=
 =?utf-8?B?bi9qczNBVllkdUltTXJlcFlQR0Z2cmtyVW9XOU95QVZqOUFReUJ3M0Znc1V5?=
 =?utf-8?B?K3J5dHpVQWx4ekJ6MkVaYzRaMm9OU1M5QTIwOXJUdnBpSklodlJEOCtLN1pM?=
 =?utf-8?B?U0o1YS9Ld2thSTVsd3RKUkd4a2lPZ0lYRis2Z1pyMDErRjJsUlQzSHJIa21C?=
 =?utf-8?B?b1JrdUV1RENzYXU3OWhPNm5KNDFqTHl3Y1FHOG5GeEkwTnhjY1JEOEl4dTd2?=
 =?utf-8?B?dDYvMVNjWTNpeUpxQmVpSU1ZUGVzd3JXclZBWjRQUEMybU00OGR5bzRvV0ti?=
 =?utf-8?B?bmp2WHNzSWl6ZUdTbUhvWTRjZ0trOEZWbGVoakd2a3AyNytweitwMEg1bGxy?=
 =?utf-8?B?emdQeVcvTlN5bGkzZlhIS09SSlJzelRjTFR3T3ZkSE5FemxsNktDV3NyT01R?=
 =?utf-8?B?aG5ZRGxVTTNVeWxqaEM0cElobGp6aDJsT01mbzYwYnQ2TUZmWkY2OERjYU5w?=
 =?utf-8?B?N0ZhUkxOa3VXZFlpYmw4Zmp0c2t4Ty9hV3g1YkY2bGVwVSsrbmVKMVVnaits?=
 =?utf-8?B?VTliZDZ1WSt2ZERHMEd6c1ZWRnYyclV0U1pad3ZXYWpVK1FYOXVTWHM0V1hG?=
 =?utf-8?B?bDdIRlQ3b0NWaGp4WlJZd3pRUWEvc1VvMlB5TUFXOCtNUTl3dlJjQlhQQm4z?=
 =?utf-8?B?TmRTZ1l5MVVmZ0o0VHJJTzFmaVp4Z0diUThIRVk5bHRvTDk2R25FMUtvcXls?=
 =?utf-8?B?L2JMWFVxaEs4VTRIOTdVcHJZRnVqakRjbjd3SHBYbWxtZ0tSVEpYbGtIOEEy?=
 =?utf-8?B?dGp3dDVFTXc1dTYzbW53VktOdjExYUdtV2tEZ1J4QlpicDdDc3JqUUJaQmlK?=
 =?utf-8?B?UWdyMlpXQjdhMGdlY0Qrc0wyUDV1MFZOVVF2dTB0YUJXWjE1ZlNBMWRYSWR0?=
 =?utf-8?B?MkxZN2dqMUVTcTR1NGE3M3VtVGhXdXFLVVZlU1RWTTBYUjhiNzZCVXVUZC9Z?=
 =?utf-8?B?VUFVeDh4ZDF1amxwOURGcmkzNjR6ejkxZ0V0Q2tpL1R3MWp5Uy9WZGhVR3g1?=
 =?utf-8?B?b0tnM2JXdk9HRnlyMWhmekZHSmlaRkxOclBSaEdIbXpaYjdMNyt1UHBYbTVS?=
 =?utf-8?B?dCtoN2V6VHpQVS8vTG1UNy9uL0lWWVNVeXFqMUNrTC82RnF1QXUwVFJzZWJ1?=
 =?utf-8?B?ckZxRXUxQWtRS0tJN29TaU5MTkdnUjdmekpEenBaZkhGcGlFYmp6Zkk1MEZo?=
 =?utf-8?B?cmZMcXhwZ3ZydWhKbmJKWllYVkFTUGF4RXg2OThTaGJ1MW93UzBnZWk4L1hp?=
 =?utf-8?B?a0RrWFVuTFV2YXNOYVRNMnJqaUFTREdXVlF3UVQ5QlNXNXRoZnBBUWY0THl1?=
 =?utf-8?B?Yk1LeGU4YmFFTzhKWE95VjA2bXVRcVFtVXVGNkd3T3I1cVNRdVlhTURpY0Fa?=
 =?utf-8?B?VzEwa05sck80VlN2eUp1YXBCc08rbFQwZWhLMW4zSzJGWXV4aVBKeGt6aU4y?=
 =?utf-8?B?TmFTZE1TS0pPRnhjeGVXd3Rjd2dBQVk3VEVmMm1kMnlHL0E4SmQ1OHcvSDJx?=
 =?utf-8?B?TTlQWEdNN1R0S3d0RmtHdnk1by9PUmFCK1VXcC9PejNjd3d0Z3hIY1BUaXBB?=
 =?utf-8?B?VDVBck9WN2x0RXRQdEk0S0tSZ1krZ0NnREkzendBb2RzVThiZlcwZmh2WDdK?=
 =?utf-8?B?WGNySDE1TGRqTEZ2TWw4OTg5MkpYdDBkU1hvVlpMK3JZNUY0WTV0dVJFZ2gv?=
 =?utf-8?B?SzYrb0tRNjdGYUFXRmR5dUlJL0dkSmQ4V3dVZFVpVDF4eXpPR3E0Sjkvem5D?=
 =?utf-8?B?UkRrYkJSdi9vQVZhUmp0Y3JTWnQvK0drTTJUY08yZ2luRC9xSm5na2NGR2JN?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 48KyLTrtar28eDVF7O0+ufwqYlSPqC2S0ZmqvLcosUSOiyj51sWGOivi7KixFVML2kEDq+0XlOJpKl4BlD6dQzdiDUgt2tU2VnYGzGkVguBQ/gbZi76ZZR0SuF/mGfuZ/TBFNKiEE9kKbuQG/UoxtfQ1bvmpXr5qCG0m6UFaQ509jA3WH6jIXSPmwoQTIn8324bS5AiaglLjlCFbB0+lXzUqTPN3FwSGO+m8fv5TD9s6nRhGiqLPPidfD7KGZ/7C++2FPmi2nfR167pLgg5fXxZ0+jT+lbpZLusPKJ9KaJBfOxgwF2xTW3clLyDYIV2OjPg2W4FU+qIAM6L16I3L+NuOONFJSEY6bZSjanN6FT/2hkrwsia3MjWjEuQ488cSEroPcC/k9QlKLGIHVoDrjkNQx+OJhSlFs2DRbqp2R6z6DX9BGwAb9HSqThK6VXn2tp5pUl87ZYFYck/BGUdihmfMg3fdJOvSQ7QPPeFLNzstieJHYVE39HsXAyoj8n0N2jeGueeKnLWf91JRb2IzCSnCEoS9F/12lf6BozjQDgfoLWiREHf9iwNZhvnegVan1tfOnAjewUKjX+gAiHLcHQyBej+aCiCtONrWklwWR70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc4c96a-26fc-48e0-6500-08dc37bbc4cb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:44:38.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMNN55e1TburmKLQodIlIPN4aiWRxtVjabf3eoVNalpFGEV4kwlg6vxQ0seuXFvm8pWWGnNO+luUaaimXi2f9BkV8PFih4obuPCA4MOlgyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=952 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270137
X-Proofpoint-ORIG-GUID: aQcGjiqYd_UKGULvuucmVWDF8XLLUBiw
X-Proofpoint-GUID: aQcGjiqYd_UKGULvuucmVWDF8XLLUBiw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Please ignore this solo message, I accidentally sent it alone - steve

On 2/27/2024 12:42 PM, Steve Sistare wrote:
> migration/migration.h is the private interface for code in the migration
> sub-directory, but many other clients include it because they need accessors
> that are not exported by the publc interface in include/migration/misc.h.
> Fix that by refactoring accessors and defining new ones as needed.
> 
> After these fixes, no code outside of migration includes migration.h,
> and no code outside of migration uses MigrationState.
> 
> This series depends on the following:
>   * migration patches in the series "allow cpr-reboot for vfio"
>   * singleton patch "migration: export fewer options"
> 
> Steve Sistare (10):
>   migration: remove migration.h references
>   migration: export migration_is_setup_or_active
>   migration: export migration_is_active
>   migration: export migration_is_running
>   migration: export vcpu_dirty_limit_period
>   migration: migration_thread_is_self
>   migration: migration_is_device
>   migration: migration_file_set_error
>   migration: privatize colo interfaces
>   migration: purge MigrationState from public interface
> 
>  hw/vfio/common.c                   | 17 +++-------
>  hw/vfio/container.c                |  1 -
>  hw/vfio/migration.c                | 11 ++-----
>  hw/virtio/vhost-user.c             |  1 -
>  hw/virtio/virtio-balloon.c         |  1 -
>  include/migration/client-options.h |  1 +
>  include/migration/misc.h           | 17 +++++-----
>  migration/colo.c                   | 17 ++++++----
>  migration/migration.c              | 67 ++++++++++++++++++++++++--------------
>  migration/migration.h              |  7 ++--
>  migration/options.c                | 11 +++++--
>  migration/ram.c                    |  5 ++-
>  migration/savevm.c                 |  2 +-
>  net/colo-compare.c                 |  3 +-
>  net/vhost-vdpa.c                   |  3 +-
>  stubs/colo.c                       |  1 -
>  system/dirtylimit.c                | 12 +++----
>  system/qdev-monitor.c              |  1 -
>  target/loongarch/kvm/kvm.c         |  1 -
>  target/riscv/kvm/kvm-cpu.c         |  4 +--
>  tests/unit/test-vmstate.c          |  1 -
>  21 files changed, 96 insertions(+), 88 deletions(-)
> 

