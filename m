Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D816EC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bMK-0001FD-Q0; Mon, 13 May 2024 15:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bMJ-00019z-Ec
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:29:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bMH-0008OX-PF
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:29:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJ0ssp025006; Mon, 13 May 2024 19:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oyioXZS4dPmAVACIgdX1R8IAEFtwKAwhpoe8aEh6d8Y=;
 b=HKSpWi8NFbK0s5jX00W3bkGXZO+FM64jVtdhWLNrY56eLdgce0s7W8Nt9naMTIfV1h/3
 gWT7WhrYquZxzr+lOVw6uQfDDE8pzktFsTedGFJo5vVk9OpvVawIztSkAbrey2j0PaNS
 CevbVJrjWoHeEU1o4glnmeR/c3VALgwJrVnCo9RnP/taoJr3odh0kz0Q4wctzsYAZi9V
 YRnd8bMBdjDLbbXuYOOiAeTQflw/eOKIxOnLAr1Uw+tb60N6tfd9VCsjl1znuk4KY9R+
 xiPAqjBbu+Jbj9qHWP/SgP+j5Y81ucoOrYnib5fJcFJMoJ3cJwHOvDIJwaxdOr5K38dz wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qgv08rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:29:10 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DICfli018879; Mon, 13 May 2024 19:29:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y1y46cuhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU9skiMnjXB6mW1vr3/wAFlKNC93PApT2NWk/Y2U6FFaq+PxK61qNcdczgZUix0JISq9JRFVGmbAhltZQQjL02oatdtbM41B1hpHhFqmGHgm7Ii6j7+O+tT7q3GFUIE33zpAbAP5zQwLmSzvrV9Iqtuntl7/DFPbbu8Sdw9AVi6WYM2HLb/qJXoKllhBmlRk3WdVVtgEx2tCc2cEWXE5Mn2XS4yCrijWufAGtYqDdoje40P126oA+KJBnBvDFpZL1Z+v9zzdQ3sz1eIRI1uznxFw+g7xQpWToFv1qqe00emi/YY5nd7RGY6P9v3fhz2XPi83jB/cvqFGRk6AH03b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyioXZS4dPmAVACIgdX1R8IAEFtwKAwhpoe8aEh6d8Y=;
 b=Cu0HeCrRhUHjZ51peARCtmLuUZok8V7HionDuYZLUXymijGA9NaXm3pxDiw/X+vhVssC3Yacp9e3zbIDGbRSO13qCOxrsSTgOiEBQZ9Nwqra4foFX3aSziDHLbMR2rU0N/ib5/bCBiMpTmn9lLNWZ7Y7g3FOiPdb1KXaCFENkUiHZ1ZD2sdF6DsPTI1xltwmyN62tgtkhQzmpPzza4pHAQUAbj7dQcrla0YPXaYgX/g2gvZvQimEA6Ql5XsxnwGdx/J2cQRAsU7T5U67QQ06gLo/aAMjQ0k9YN9RMNmVOY85y5KIcCsVjjsgBaa2tPGgXh4aQwli5h+dGfFy/U1MJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyioXZS4dPmAVACIgdX1R8IAEFtwKAwhpoe8aEh6d8Y=;
 b=WdhBlVa7Rq2onPwtiQukRfg5jNXjv8gKxyV3OYPKjK/nuyUa4pezlBdote0Tu/3x4DiC/X6cF2ZNVSM7NHIf6/H51o8mnDwLo8COpyrhTF6GNGcTEQdPhQqmqOfP5VurouoIl7r5SyzZ54OdcmpQo1g8CU26vNjIShrsMaQdKkI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:29:04 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:29:04 +0000
Message-ID: <d5852290-2d0a-4d73-a10f-cdf847dbb047@oracle.com>
Date: Mon, 13 May 2024 15:29:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 09/26] migration: vmstate_register_named
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-10-git-send-email-steven.sistare@oracle.com>
 <874jb7kqya.fsf@suse.de> <871q6bkqe0.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <871q6bkqe0.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:208:239::20) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 6339e816-3748-4682-b4f2-08dc7382f325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2laTFIrNVBISktTdlBWWm5FS0h5QzcrS0VRQ2c1NXQreCs0SmFxRit4bmJ2?=
 =?utf-8?B?K0FZcDB5Mm9yMG9zTzJSMmh3Y1lRSUE2d2R0YmIvZklVZll6MWVvUzFpbnlR?=
 =?utf-8?B?aU5YSzRHQktFampZZlo4NmRCY3JGNVFUOWd3Y0djVmxJMVNnQkxacXJjSHdG?=
 =?utf-8?B?S3B2czJqSFdnMnlzcnZBTkhlcGxKMmtIYTh1U1grYjV3aW4wTnI0OURmcmxP?=
 =?utf-8?B?RjdLdGxzMXVmZkJGSG5oYnZIWjNLMW1adER6UFptMmNaeTAvcUh2MWxHamhO?=
 =?utf-8?B?cENQOENsNnZxRy9idU5RaUprR0RvaHoxWmpPU2FieW56cmxxazFBRlZMUlov?=
 =?utf-8?B?OFA5eVQvdFRqaXdQV1ExQndCOFAwWDZROUtCWVZaVjQxSWxMbGxsTjVWM0x6?=
 =?utf-8?B?RVZWRElzU2E5d1pzUGNhSFc5bEszblRTbWZoRzlub1FycExJNzNRTE1jSENY?=
 =?utf-8?B?eG5PNUJBNWNWWVZyblhiM3lRSkhhT3pabmlPYTZCRG5qUVVMR3M4NGVrSW11?=
 =?utf-8?B?UktpU3FrT1loVHpwV245MkgxTkhsb2NSbmFtTlVKTjY5blRJRE0rWktPdXpG?=
 =?utf-8?B?dDFCVjMwRlNQdUQ5eGxZMHoxQjAvVncyUWZrTzJJY3FQdWdIY0RoNHVEN0Uv?=
 =?utf-8?B?K3NKOFYySUNMTlduN1NiKzdJWWpwZ1FEcjA1R21YRVM5R2NBQWJ2VG1QRTAy?=
 =?utf-8?B?N2Y0ZldsbGNoaDdaUVZtWUhlaVgrWEYrckd6QUt4Uk8yMytLN3VVMWUzeGQy?=
 =?utf-8?B?cndxYzlXTU9wVTN0WVA5ays4YmZ3aHFMNVVXN0lHVWpYTEl4cjRtbFcrU041?=
 =?utf-8?B?SE1KQkxJY3VORC8yaTYvVnlhTUs2SXFJNytOeXd3MnNKRFVqeHRELzlTKzBm?=
 =?utf-8?B?UStsU2JrVHFwZEJodTlwUE1wMzRnSmhZTzR6WWhNTFhrejhST2x5Sk4yVEhN?=
 =?utf-8?B?dGdpdGE0R3UrSnBLS3Y3VG1TTW9Vb0hYanNRYy84TjJWTDBxUHgvUGNpRkJQ?=
 =?utf-8?B?NzYzd1ZiK1EyM3VRUXpNcTEyTzZIUXVzQ3kydkN0dHAzV3FsdVU1WHFhY2JQ?=
 =?utf-8?B?Y2N1eUlFMldkUUUwekQvaDlRbEswN0lkczZyNEw5dFowR25FNDEyMjlqTTJP?=
 =?utf-8?B?TjZpY2JObCtJT05Nc1FWZkVuYnlNYWllOFFndHF1emtrb2JLR1VQYzg4T2N5?=
 =?utf-8?B?OERnb1R5U25BZGR2eWZ4T0pvdVdiRXZ1bDFLL3R3WnJMSVo3RnJaTnhGT0lo?=
 =?utf-8?B?RXRYeEJPSGlzZTN4MTFUNFBqL3EvbVJ1NHRZeXQ1YzdPMERNeFBsNlZ4aTI1?=
 =?utf-8?B?ckEvTjRVM3VoL01vZHhxRVhEVndGU0RkaTh4VmptY0hqNWoweHprVnIwd1hU?=
 =?utf-8?B?b3pHUXdqRDRsa3o2azdSSHZmUS80aHlwcDFvalltcHM3RG9ka3ZGVGZ1ZHB0?=
 =?utf-8?B?dEkyaTJDZ2M1Z3FVLzlHL282akhFNlZnSUJ2eDY3c0pDNzFFZkFYL2tmYXBS?=
 =?utf-8?B?VW0ra1duLzJQM3JQa0VPeGwrQ0drZUVLZGxaMXlqVXpsMDJkZkFEaXB2cTRs?=
 =?utf-8?B?Q0pYOVFDNyt2ZHdTWlRUOW1aVDdHQ3h1NGpmUEJCZG9lOHN0Rzk5cFBiRW9z?=
 =?utf-8?B?c1dxbndaY0pXQSs3RmNZOVd0dytNWkhaZ3pqWi9GMnJzYjBKMTBBRWx5NlJC?=
 =?utf-8?B?ZmZIREVtQVhXVTFuOGZCcDBJRlduZktWTkN6NVgwNUtUemhnS1RmTjFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UllmdlZZOVNWM3RJMy9LNy9ibE4rOHRoS05WWnk1aWMzbjVvRnZLM3JFRUJY?=
 =?utf-8?B?dG5mV091aldseW1CZG8vYlBlR3BQSjJ0MnU3d1dZcEwwazBxNnZVOU92Yms4?=
 =?utf-8?B?YS9lY0JsNEFCTjNzUTRrR1cwMzlNK2RTdkloK2N4ZklJdjFOWFdoWHgyL0dr?=
 =?utf-8?B?S1VVeEJMR0xTMVpjenVtRUFJb3Bqa09Odm9XTmk2YzV2enVGWk5hM2tCUzll?=
 =?utf-8?B?QzFmWXEwejNwOWl5aFRSOUw1aXFCT1ZpWnZhWDVpZk81cExvMC9RQ3RQYlBD?=
 =?utf-8?B?K3RkRkp2Q3B4ZHNrK1VpOFlrZmIzNjc2cUNycGo0YlpZaDgyV2JqTHo5ZGFZ?=
 =?utf-8?B?RGtPU0N4L0p2QTVLNGladTAxd0pqRHc5YXhMZzBJT1VZNmhOTHpoM0NoUjFE?=
 =?utf-8?B?WlZRSXlrVnhQV1YyLzI3RFI4U09TUmJJbFFQS05uZ3QxRS83U2xQT0lSR0Vu?=
 =?utf-8?B?QnNtMjVnRVRSTHh3NEU2WkV1cHFDcFNxamFEWFJIVnoyZmtZRHRsVStUTENu?=
 =?utf-8?B?ZTFPU1QrRURCY2ltWHlFWG9iVXlodEdicEdUTnNpZUhYYnU1dGd5ZlJiVG1o?=
 =?utf-8?B?cHd0bWtKNHlQeFp4bkhYZ09FUzVJaEw0VlFxaWxDRFdGS1oxeUFIY2xJTVJx?=
 =?utf-8?B?aTFneUFURC9Cc1Vobmt4bVFGVnpSc2t6YTIwYlhkSW05NnZSNEp3RDdDLzhl?=
 =?utf-8?B?Wms5eFEwUFZnZGVtYVE5SWgzTVlXbXRPWGluVkh3ZytQM1c1Y0ZFQVVnSE5N?=
 =?utf-8?B?ektvRFlPZWJmN1Y1d0h4MXNXQzRRTWlvYlhIS2JnZzFtNWxtWlZhL1hOaUxL?=
 =?utf-8?B?MXc5YTlzbEVJMVU1NEhUZkRzU2ZLTEplQnB6ekw3L3Ayc1d6MzZFbnNac09p?=
 =?utf-8?B?YThzbGEzTGpzUHU0OUxTSkdZTGo1bDVPYVFNem54Q3k5VVZmK29XekNZVjNs?=
 =?utf-8?B?aXFlVFRNSEl6Zm9Cb2k4aWJvQ1VVdWM0Qkx0NHNweFVSRmwrVFpERWVZT1hE?=
 =?utf-8?B?NjMwSW9FcHNjOFpkMERpQThMNDdVSjZmcHZNcVJ4TkIxMm1LZkRBdE9yd2U2?=
 =?utf-8?B?Tm93U0hwNVVCT2psZkhFdmNRNzhHSHI5LzlvK0RDVmkreGFhLzhmZXdzajd5?=
 =?utf-8?B?TXN3dnRVUXhFb0lMYkdLdHZtRmk3N2dibUFmdEdtUzgxUW5yVit6MkZCV0Va?=
 =?utf-8?B?U2UwQUdRSHdUZXRIYTNCcVl2ZVcyL1ZLZWU4eGh0QW5qY3dSYVQrNEtuTTBo?=
 =?utf-8?B?ckZzdThNcjY5NjllNW1BQzM0Y1JNYVgrSk9YT1pOWGl5eVVkcWNlZ3htcmFn?=
 =?utf-8?B?ZXZ0TmNOY2x3MDQzNURHTndINnpQS2hmR1BVM3BwTnZJL1NWTG92R3ZEOENK?=
 =?utf-8?B?MHhKdFA1NmdhWDlWTXloQXB6WHgwbTF4UTA3T2lHSU56TUJMQlpGYkFJMGRh?=
 =?utf-8?B?ZTVBNzZ2NE1YVFE1SlBGVzZCdGNHUG5qQkkxNWRwVkZzTXZzeUVLekVZUk9o?=
 =?utf-8?B?Q1ViZ0U4cjBzallrZHBnNU9zOG1CMjVvd21iUFpUZ2dOdmNsNmxDUHpqWTFN?=
 =?utf-8?B?anNQWWh1M1JpTm8waVU2MUx1cS85TnNwNWRISDRCMjRhWjQxOHRUdFpyTWxq?=
 =?utf-8?B?QWFmZ1N2bWI2cmEyWkZJSDJiTkVpWXE1N0pBZExaZ0NFQmlXbWpjSHFtM0FB?=
 =?utf-8?B?WkpZYy81bGxoMXJwcjlFRS9RNHNXLytaVGFBT1A3M2NNZHR1UzVuV1I3ZXlS?=
 =?utf-8?B?QXh3Slo3TXBRZFhwMFk4bGpza1lvZUg4OWkzZkJQcXVsa3AxYStlalMrWVhJ?=
 =?utf-8?B?VU5LZmc0c1lrREQ0S0RmTHAyLzJ5cWFwSXhrTXNVVzl6RGhra3ZIWlJyTDhx?=
 =?utf-8?B?Qk1uZ1VQRVhhQWwzTEJ5ZXE3ZXB4eGNpWjg0M2tyTVNOeExSaU9wa3FzWFQ0?=
 =?utf-8?B?SDZZaVJsMUM4bkF4RDBqZ0sydTYyeUNudG8ra2V1TW1qZ0N0b3lDaWgwaU11?=
 =?utf-8?B?ZWJFUHJlSWNjald1UXJhZFo5NzA2MkVMV09pSmgyZjNxa0UzS2Z3YmxVcU1J?=
 =?utf-8?B?ZVVDU2RRdDM0SWxhRWZaaVlyTVloSjdONXNjWEU1cHJGQXNVRU1rZnlRb2R5?=
 =?utf-8?B?WTZScGcya013clpLWVBtZ1FaNmQwMUIrUVlMYmV5dTBCdDU5M1ArZU9LVnpE?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nh7K5pDzVXOPU+9kjrMuWZTGn7x2ssKH77ouUMoVObsfda/GsL9eJ6Otj1OPww9uPR69MO/MygmRcfCER1l+9Zc2OAXwVFYUSZYXh924JaQZx6S8BymD4mgNWGr/UYrZn1SPKqGKos+6HDIaHrQubNy1FjY2iIb/KVo4pvDbxwd2ox4ttKhkhdERTq2l64Rc6/UmTome3AwKQVz5YFPCmQPUUfsJsYclJccCeUF6sxabFA2rPRc+QQnCm3JbyiZVTHNjIHRlNcuXDTPqmVFd6OuDSZwEJkT3M8dgTYKy0PKqHswnH4/Y+ANPja9VMMAXBndElbzM0ZCO9Xo4frC24fRKoZOvIPPFyqbRAOeVE9W3IG/F52ovlRKwCq4CNmKWR6ZdXZtOaLIsB2xbrnUNnqyx2GWaigex3IUraAF2kh1FHROq3aUb66RBwUqed1N0+MG6JitOfTBnw5JvH5O5UaZIje+rLCHYhPPGEmBWd+UiNGHs+9WBm5A8ppFp4M2fzFBeVmKA6yplmcCq7uZKdeKU8U/g9EWoRXrx1czs+ds4ETge+H14wvKxKs2SoBlQ1ATxxTJwUmqO107XhtZSbaCLNRpshOdFpvuavS/zUNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6339e816-3748-4682-b4f2-08dc7382f325
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:29:04.3103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/AQnIUWls7ej7gX1gdNU8r+8/YGkHOTJr8nf0S0TqzCVgY1JuX1Nf9KHco72IidAL+gQwQ+ic/QTauF+MwzZ6JIoIjgvOQuCUtGRLHdBJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130132
X-Proofpoint-GUID: ujbwN58XZEz3Jzc5GbUYVI7yIguUX_FG
X-Proofpoint-ORIG-GUID: ujbwN58XZEz3Jzc5GbUYVI7yIguUX_FG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/9/2024 10:32 AM, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Define vmstate_register_named which takes the instance name as its first
>>> parameter, instead of generating the name from VMStateIf of the Object.
>>> This will be needed to register objects that are not Objects.  Pass the
>>> new name parameter to vmstate_register_with_alias_id.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Actually, can't we define a wrapper type just for this purpose? For
> example, looking at dbus-vmstate.c:

One would need to provide a separate wrapper for each struct to be registered
as vmstate.  This patch set only has RAMBlock, but there are more coming in
my next patch sets.  vmstate_register_named avoids adding such boilerplate,
and makes it easier to add more cpr state in the future.

- Steve

> static void dbus_vmstate_class_init(ObjectClass *oc, void *data)
> {
> ...
>      VMStateIfClass *vc = VMSTATE_IF_CLASS(oc);
> 
>      vc->get_id = dbus_vmstate_get_id;
> ...
> }
> 
> static const TypeInfo dbus_vmstate_info = {
>      .name = TYPE_DBUS_VMSTATE,
>      .parent = TYPE_OBJECT,
>      .instance_size = sizeof(DBusVMState),
>      .instance_finalize = dbus_vmstate_finalize,
>      .class_init = dbus_vmstate_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_USER_CREATABLE },   // without this one
>          { TYPE_VMSTATE_IF },
>          { }
>      }
> };
> 
> static void register_types(void)
> {
>      type_register_static(&dbus_vmstate_info);
> }
> type_init(register_types);

