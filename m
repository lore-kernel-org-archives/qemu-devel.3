Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592E5C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehTv-0000tW-1j; Mon, 26 Feb 2024 15:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rehTt-0000sd-8V
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:21:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rehTr-0000Km-Jn
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:21:45 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QGmjSL028013; Mon, 26 Feb 2024 20:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h//WTGAsnfu+a1DthAroLo4oGyiCTg+45TxK32yQt1Y=;
 b=B6c5IrF5Olr0UufhdNSmfnWFpswNCjtJHFOJbbe8wqet74vKOOOyRlL8HsHn0eJow0tG
 EWNP3gGTGjfFBHE3g+yownFZHBZGmV4xqEk6QGiBRPmNCkdxeaB5ieib/fOG5Wu7metU
 t/Mztx8hbg5wcA5bwBgn43b6+9YmSFon1UrAkUsEQQoCw88v0JrmCyLzi5iilB9Pl6k6
 sxyxgMA9/yKOKVeX18le828ROiPCb6oNg+i9Pa8JaYa1Fplgk97+BiCo9t/sKtU4UuPg
 IiffcDxWlTW9fJReUm731gGoXv7l+snI7uJztOCNUNXVsIQNxko7JsKtEAHQwOn8iLdA oQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdwjtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 20:21:41 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QIrdGU009790; Mon, 26 Feb 2024 20:21:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w64df8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 20:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8iC/z/rnzrSPz5YSUEaj+foTzbZn4dVmTvX0ShsmycCXdX+SJ4g/aFrYctEkkO/4UXfsySOlO0yyuoOqy1j12/bXXCTnvEhmKeFWaZS4VmnDJw94uz4bC5edvnXo7SD/+pwr+H4Q5tTjIm8BphUe5yu+3UisXyEO92ZhbrUhKC/4YoYPoCQDl/Tb9mGFY2n1WY4t/YtZQiYEPBp2N82TYQrslgO0YhhLjp3DO1BzQQDpXu79WTlNPmiwTMTjnAY3fUmnPyG7hIjo3qHxOrI79e4A/M6Dle29MjvVQA6cp8nX/YdFvltVln9n9LYsf4K3PtCBKYtzuWK4FhQfT8j6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h//WTGAsnfu+a1DthAroLo4oGyiCTg+45TxK32yQt1Y=;
 b=Eb2t4ZobQYd4rpSQe2+3B9r0r+j3mNkJzcaZBSs44wkJJfGis0UNRvwOIgsrwgeqNJXoeqXQMLbLjeku8kCDEaTlZZrXSZySOk7ztVYmbE6dmbERhEzQSFX3rf3OR2z03BA9i9rbc8yAudfO0IbYmyf5Vr6v8H15tgMp5fnwVkLhFHSuNxzQfF+ExnIcjnszaqzxuEMf+poCC6T1oLDKJ1JEgUQ0FjX87F+fDbtgERnVdgfnZsHAX3fHVNj5pYJhuEhKcx460BcwgkeoJtpgYwFM4F38aq/dA18foR3Vr7FrjyA8PedPOJoNpG/cq5+HF6bHeiVbKHlG/b4q7mtsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h//WTGAsnfu+a1DthAroLo4oGyiCTg+45TxK32yQt1Y=;
 b=XjhDcA12r06JYxtHj1pITtfyZx7ShdiBbfcqwd8G9S89Yl+mjRzvXBrGXTktRGZUkeshG7zBeu0lKTnQ+34JroG6kkl5KHb6NHESw50ryy16KJ5+hM8jF5hWyS9tzJMsRzfLquYR+9gqKlyM+PPyNZiLuaBaEXo5/EEJ4MmWhCE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 20:21:38 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 20:21:38 +0000
Message-ID: <0b7b2a2e-efa8-4280-b7cf-dc6bfb6e4bac@oracle.com>
Date: Mon, 26 Feb 2024 15:21:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com> <Zdv0BNtJxkd8413g@x1n>
 <02bf2132-ed34-4ecd-841b-5f93eded7ea4@redhat.com> <ZdxTVHJ8p4lYRPxo@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdxTVHJ8p4lYRPxo@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: b6efded9-66fb-446e-e0d0-08dc37088940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTzlZXHKIErZeVqz4Pqsm2ohE7n+KafaPYCqQSX5RDw8Xz16LpZena2qxoBkMWbcHmIrBuiXTR8eN+CuswMuxCXAaGhMEdUA4DuKch9KtAb42lMH42blndrwWO4AlbdcMvpsaHVvUKXH0qnxKKkMa2npfpEhq5EmA/y6LuExg+Kx3oG8QLufrkjSaTdOSojAZy/vwhrYP/sGwlVuGY5G9+/jKaVArmwnCRZrY7+FSb+8BLOhzXRQBCjVhewQeO5jXZAR1gErBgxS2e5lZrk1NgDJYoBdPywlgEFmkFOIcZFE4ISvcT6j7jxAgI9BJwzVbdgsiNxd17tCjjRVllcK3IdL5vLPuTs2AYWG1C2XRWy+9YZjD9JC7FTCTA/F4E/kjveetQVCvtHuVCwVVORxO0eDa315+2jLIAZow9aDdpH/4GJiqNQ2lt5nPevCu81tJIFBejFcaSuFhj7us6d+YHwzoh/AJ01yChKq1cgfWOjwm0H/a+rp9u5O9D9318mdbnlx7x3jrP9PKNfBtIyJHUmI8aBLGMrvFIsugXPkQOr5EE8spDdum4SY7MATvKIuEVxF4+U0HqntN0ElTLFWVlJR4ecqLECMqrVbCFmi87UvpXvfa62ouf42bFAeevaj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRIdmVOcGJEWkx0WTJEdVJRN2FIRmI5bUNLMUphY2Q4czlmMkJxakM3cHI3?=
 =?utf-8?B?YXB2LzRDdHYwcFZONTZBWHZ4RExNS3ZOSWZPZ01OcTVNaUl0WXoyWlpDQSs2?=
 =?utf-8?B?MGk2N0p1OUlxM0JRTzVnbVdodXkyYU1HOUdyVU15eDdkWWZGSVpXczRnWEJU?=
 =?utf-8?B?RnFPL1FacGZqd1RvYWZMajZZTEVJR0lOTDNIUWNEM0NvNDRISGZJVEc1UFpZ?=
 =?utf-8?B?MXVobDI5bzFmbWhGODZKQTBjOGxHNHREeXdSQy9EOVd2eUpZNXUrWEc3ZVJV?=
 =?utf-8?B?K3dSNlVTcjB1SEIrZWowR2xWNnpQNlFRaDVZbVhLOWc4SkZ3YXhXWGhHdmpK?=
 =?utf-8?B?Y1pxUldQckRZZXRSN05MY1RtY2diNWRkMmNpS2dPQWZacGgxWjY1andpTEFj?=
 =?utf-8?B?em5CMXdWMXAyV295NkViSytDSXNFM28zTFpHd1ZTUXp6MnBUWEsvRlFDK0Vr?=
 =?utf-8?B?M080cTcvRklGT0dQVWZ0ZU9ieFVjTTZlZ2MvZGRIUWtuYWFKYUhCTStLMXpY?=
 =?utf-8?B?ZXBKcCt3NXBXT0RtbHVZQzhKMGtsK0swVDFMM3Y1VCs3cUx4RkMwUWdYK3lj?=
 =?utf-8?B?cjVvZFEvM0x5aEkrcjBaZk9CSlJoK2d0YUV4dExvQmt5ajdUSXl2SzFML0NB?=
 =?utf-8?B?emlEaEhpMUsxcTkvODZWRXJueWhySTg1enNYa1dybWErWkV4WGxXWUEzZCtV?=
 =?utf-8?B?RFpyRVlXVS9Tb05JVWZISEFFZnZyM1RIc05WY1ozQWxuNGpFS04zSmxTVHA3?=
 =?utf-8?B?L2kwb0czR0luZmdnYVBpVzYrWGoxcTI0TlFRbjd3NGMyWUpRZ3lONFNEVGhh?=
 =?utf-8?B?ZE9WUGdSN2hNTWFYOFN1T1lGQ1EzT2g4UnVuNGpmU1lrVHJMa0hLdHU5SzM2?=
 =?utf-8?B?LzhEaUdJWXY3algzNmcveTlRU1ZVcGZCSm0rbkRkN2lHbVdPVGQ5bzhyMFB5?=
 =?utf-8?B?OGMvL1FhL2puTVFZQzJzVHZSZkpuL2hGaERObU9STnFoTVNacEhycW9tWFB2?=
 =?utf-8?B?bnEwRkZQQWJUdDR4UlRBWEZ0N0ZDNU8rRlZ6TVA2LzgrRjhXditveWRIUkds?=
 =?utf-8?B?bUhnLzBtREc1eU4vWWpXWkZWQmVrTU1lc3FqMTBseDUvZ1k4V3ZFQnZyMmRK?=
 =?utf-8?B?OGp3RU8xSDFYSnJwSXBUdS82emRJM0JPd3FxdTAxSlhPdndXakpycjd0d0N0?=
 =?utf-8?B?a1czMnM0dTdMUnpWVGhUUHpoenN2aXBUSFAvZUljSHlNeXlGWTNxM1UyWWxo?=
 =?utf-8?B?eEtHcjhTWVNNQVM5WXhNTG5VKzZrMTZWMHZaY09PM0NYNjd0eVpNN0F4bmti?=
 =?utf-8?B?ak52Y3lVdU8rcmEwM2pzZy9sU2t4TzJtbUt2bWkxNEZiSzFGcUt3NVgxd2JB?=
 =?utf-8?B?NVk1NGRDaE1OeTdOVEhWRjZiSFVydkorVEtVV3QrOXNUSjQ5QStzVjhaMnVJ?=
 =?utf-8?B?cStvV0JwVnozbUVLbGdRK0ZCT2RkZG9IZnpqd0hoR1NFUlF5a3FXNmE4L25W?=
 =?utf-8?B?OWxRQi9EMUJrRnlFWGlnZzlHcWdWR3hSTDRKNkY4ekExcVRacnBTNE9Zc1Qv?=
 =?utf-8?B?aTBsRnlWNDJYdHliRS82YVUySGFYNSs3dFVZbjI3M3E1TlIrdEFNdks5bmdR?=
 =?utf-8?B?V0s3YkYyekhkZUtWamtnSzJJL253aUxwSkI1WGZ3RVppazkybGRDRlhrMlhR?=
 =?utf-8?B?RHIxbjlWbjcvbEY0SGNyWmZzOGpRa3FMZmRDVFR1bXlaSTFkaWk4dWkvTXRB?=
 =?utf-8?B?aVJMazJJM0RBOXcyRTUrT0dBTm56NzNSNXhrUGdLQ2RCdGhIOGlib3ZXSkNG?=
 =?utf-8?B?MmxsSjI4Y0NXQXh0dHk0L3hadlBIR2tXaXo1d1V0dHVuNVpITGxmdHZwS0Rn?=
 =?utf-8?B?RE5yS0N1V0hIYzEvdmsrQ2cxTDh4ZXJFUnEyRC9mWkFGaXdsc3RETUhCdDMy?=
 =?utf-8?B?NzhSdld6RWR1S0xBeVRMMFE3WWlzSUdSTkxhdE1mNUw1QlI4R3dqeUxkSlZ0?=
 =?utf-8?B?Rjdkbm5WTjFtQ2NwNTU0czJvSlBGVzQrTE9WRmhTVDFId3Q0RngrY1NiZ3p6?=
 =?utf-8?B?QWdrR1d5U0pYY05maHZ0RGRlUklFTy9Ra09vdUt6YWlaay9rSktBQ2pONGZC?=
 =?utf-8?B?QkI0TWNOcjlyYXphQUdmZVF5Z3FBV1NDWTQ4TVluSDlXSWNrdGJDM1Zva1Bj?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wj5SOv0OrPZi1zTuEysJy9oPK4sabXREY/BIGtuEIzzO2F7XLcHbu6UKnzv4l/jXQ2jc2TfMxW6s3Mr6RzHM/HucWs8C81apOXE9R2j2EZ4O11J1Gk5FEPjbWy//Nk6zfx1DKT9sDLtwdAiqYGhfcxSpAyaa8Ae3Ab0MbFf+sUcN8X8pZ8V6Vz7yQRt9yyFly7wXssYjNrLeKujbSMSVpzDEtfEdvaev2T8H9UO3iFh2TC4jh7ZVH0sNUSdu/RpbpvBvzC0QA+uFqUCc2DwsMOWY423TwS/5tCXDdoFQXIaEt/yU2fcoQTDbEJnb1D6KjBfUpM+OsD/pfqmPuFwkGw/OkYHC501xsLCpNRKyZvvIct8q1AFE2FD86whOcdxfre+CvAAZdbehSxxnUJvZawTf3BRJDHKHHKoTfydWsjd47aPUFv4FOPyOVbteYJYETl/XznzRERo+DJNE8Elc1T7A5Hmk/5m1tyEb7Cu1Q5HS9h3s+Gpw6nYQEcO20aQl44kdchN/2Fv2vgW07RW41ACGLiZMa9coZNi4ALzpmrK9nmiJTVEiMijAhaQqtQNZzKyCXhzHt3bbbeyNBvgJeuOnqRMaS/Hk7TOtKSIfdXY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6efded9-66fb-446e-e0d0-08dc37088940
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:21:38.3773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESNXvB++dXJk4NttcOLQ2dxS8O/9ZvrYlm5dopGV8ghTHARnQsAdR6q5SxSB9Z3dMraW4J6UF2WmoSa91GpzKbdb1NfDbgxWw4EZhvAJ8kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=869 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260156
X-Proofpoint-ORIG-GUID: hGHChVT2JjCnuyt2_PCn8UPfsR-xUpYP
X-Proofpoint-GUID: hGHChVT2JjCnuyt2_PCn8UPfsR-xUpYP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/26/2024 4:01 AM, Peter Xu wrote:
> On Mon, Feb 26, 2024 at 09:49:46AM +0100, Cédric Le Goater wrote:
>> Go ahead. It will help me for the changes I am doing on error reporting
>> for VFIO migration. I will rebase on top.
> 
> Thanks for confirming.  I queued the migration patches then, but leave the
> two vfio one for further discussion.

Very good, thanks.  I am always happy to move the ball a few yards closer to
the goal line :)

- Steve


