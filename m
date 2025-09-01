Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC05CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5FS-0002uF-Ow; Mon, 01 Sep 2025 10:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ut5FO-0002pP-Mf
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:11:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ut5FK-0000fn-Ef
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:11:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gQeI019348;
 Mon, 1 Sep 2025 14:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=msviRn5QlCPzdaTbkArswM+z5vQRHTPhnABIleW2ykU=; b=
 XSmfAZx32z0gaQQ7c7Egh/CO0WdSF0KgQZHru1FW6VJMJfByg8Hxn/mME8z3xoOd
 fAvHY52pjCQbcPfEWMbfHaf81eRFixUr+3SUGb5ajlQ4/vv3kADwFLKC0UvR/qXY
 Ymm5ElrJf7vFcAyLrwUM77L36pdLBo/alJaBx5JXdJFybD40cW/Lxlo3kDReApxX
 lUqmJqLAAjvN5bi8BXVbjUBPRy0icooOa6iy88RWXSPdnmhOgsIq38zf5SjEpyMM
 R1BXjPitFNwVG0xp3MFzp3PUG2cJxsYVYLxslp57QevfW103etWU5BJ61DT195pM
 wdACrRXih1xL5Yoy7Z1/1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9jjjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Sep 2025 14:10:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 581DQKdh026837; Mon, 1 Sep 2025 14:10:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48v01mebxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Sep 2025 14:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yF2gRCA2K0Dpn/XjfoXYTGQsit8F0Y3JZjmwVuUHM2pvZqbH2adS3rYSmTFxxnHRWHKHYmPMtNt6LVcCo+6653xt3li0Dp1qgsPGg3LZ4Pwf/bog+x4ki4wYaiZnw6Wt3HdAtfC6qcHtIIGYD/e5huIQ30APwmLb411b8+m/KU1mYKA0QwJQCQ78OAGCdY+hbbhHv8OwDJ2dx39YzRwEgwNAa1Hf8myVOzdipWUZZauqNafxWN8FFqUOcv5aERyE+xVWd+53dpB9X9b76+c7q2A/Z8LgwVejdcq+6EI+Yn9f89gYcbxcSDkU2EX1UDsoSiPYn6DhOSBQCtA3cecAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msviRn5QlCPzdaTbkArswM+z5vQRHTPhnABIleW2ykU=;
 b=w4i7aU/BWfwBPNsAvL5PUkM7FO6at/aTVrkbRq5zhqWPElH/1a8CW1DnnB5ELfsLFcUzplvmoVmSvU5SGT6KILVe6sNyZbRJQmmf7Voge+93PhsoKC/ab+XcLcCAUBMnfBlv6qBmaizOVVCokRIzlngCKf7bTess8A7SRVvo+kgA8TPGlMtJ+wRRwtq27DeT/Imf2DoXHuxhEMkBAHHRAJVCLA9kyAWcsnqUZ/QxGBaJvfkXkobxAihwaHQSmBnEHmcblKdJeXfseSuMVoE1223f/s0XMUn+g88ASIlM8cP6V/h4bEl6b2v3OvUtFpM5W8vCLlFGwYf2Y0knsRitIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msviRn5QlCPzdaTbkArswM+z5vQRHTPhnABIleW2ykU=;
 b=ytONvezbxmF//s6LMM6OerRC6ilHbrEFvRG+NClXuzyREM44RGQlcTwELisYK6ERsk36xGo6VRFPkbLKqpvmsWe5wW59nx7jZANOWvji4P40kQZfg/tyRzUfzFxTLVhoNMxfNT358J/xrM29NYwjBO2Dy6ZdJ3CYlGrbvV/1W08=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:10:52 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Mon, 1 Sep 2025
 14:10:52 +0000
Message-ID: <b0232c4a-bd8e-44c1-923a-229877be206a@oracle.com>
Date: Mon, 1 Sep 2025 10:10:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
 <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
 <87ecsypq85.fsf@pond.sub.org>
 <1636d435-d13d-489f-be59-5a225286b12a@oracle.com>
 <87sehdl17h.fsf@pond.sub.org>
 <985602de-88a8-46a9-9b76-e494c9f4ac33@oracle.com>
 <87cy8efpl8.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <87cy8efpl8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::9) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 96922a9a-29a6-4dd1-6fef-08dde9615c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHBzK3hVSVZkYm04d3UvZit6VEtKMzNBNWpkQ21wbzJxZlR0OFdpdlhsaktO?=
 =?utf-8?B?cndTNUtRdGlzT2NFSE4vY2NoRzdoTzNVdTRrNFAxWWxEOXdTRWJpaWR4TnFH?=
 =?utf-8?B?SktaUllWZHJWdTRFR0hJZzhCWEoyQWY0TG10Y2tpeVp2VEd2dEx2ZHArdFJS?=
 =?utf-8?B?Zlpua3FhT1JUa0lQbUxEei81RlNhZHNpS1BsMkQ1bGR1VTUyWEYvYU8xaUc3?=
 =?utf-8?B?cVc4dWdoOVhDUENYN0k0aDBMM2RvNTh0MU1tVHIzNm5lN3FxWWQrRE9ISklu?=
 =?utf-8?B?dXVKZlpDMHRWN0Z5RFRUajBUWUxpNkFtNUgzMTQrczMzeVovRmNXQkk3UTBw?=
 =?utf-8?B?N0YvTmVlSGMyZm0wM1ZoU3l1dmVmMTUrQ2c5dkhpM09rcjkrWDBYZ1pxaXVj?=
 =?utf-8?B?YlhpTzduVWE4T1RQeDJxUWtIYVgxeWc3Z0c1Z3E5ajk5ZE1zSGhWLzVYaEZo?=
 =?utf-8?B?NDBMUXEwRVBJdGtLUkg4c2NKRlBlTEpKMm1IbzFtNmU3UU9YQjRQS0hyQlZu?=
 =?utf-8?B?S2xRRmNiZnR4WVRXZVp1WlAzUHgvMTZyMG9BWWk1OHVFNnQyUGRyT296VU54?=
 =?utf-8?B?M1BFUVVLOHdNSU1aWEpBRmNPVEpLL09EdUtCSWhydXpycWRXajJLcmxmZHB5?=
 =?utf-8?B?TU9qT0FVcmFFSXc0TCtlc0xWaDZQWXF2c2RKK3hHN3IrVmVsQnJrMnMwV29D?=
 =?utf-8?B?cTV1M0NORkpaQlB5dUVHZnM4SENCekFXL3ZKeDJXMnliRWRIUlhGU1YwOWg1?=
 =?utf-8?B?RzVZMjdrdWhpUXJIV2ZJNDJqY1I3bTV4WUxMOU9BUGQzMTJxZlFZSjUvRW5G?=
 =?utf-8?B?WHY1c2hKWmtIQmZwTE9rbWg0OFhmSGlwaGJkZGVsSnk0V0s1aEpleE4wekxX?=
 =?utf-8?B?dFRWSHk1RlVSei8zenpxVXFQOEtPY3V5UXpIQzllTlNVRnN1NFhaalhKOCtt?=
 =?utf-8?B?WEFIUk9BWWlHVmlGdG4wT21SU2NzellpRXJJaHpZZm5JZU8rMlY5N3JEazRo?=
 =?utf-8?B?NDR6OWZYN29rQmNlQk9Fc21PZlQyVjhVZnZQT1lYeTcyeEM4L0FlRWJLb25t?=
 =?utf-8?B?aXdlQlJSdjVmcHU2ZjJ3Lzc4ajVYcHM3Wm54eEtLTTk0QzBZMFI4Q0Y0SmtC?=
 =?utf-8?B?Zm5qNmtDNVpuR3JSMU5BUGYyMmpMTEU5Nkx0WERKOGlIKzkxa1UwM2twMFMr?=
 =?utf-8?B?bUR4Q3R5aVNNN3BuUzkybmp2Y1Vmb2hsbm9jZFA4N2FWM2dxTTAzMG5PdFNx?=
 =?utf-8?B?dWM4dFRRdGtwTy8wdzJEdnZEVWNuK0liY3pjNEk3aWUzL2ZQOFY0QlJIK1VY?=
 =?utf-8?B?VU1ibzkzQ1krM3RnWlNxYzcwZUpMckJhYlFUKzh0dmhwNExibGNIbmdWdGtP?=
 =?utf-8?B?Nm5PZ3VsTWZhVzVGMUxQN3IvV3Z1QVlhUEhuNndwSXZqd1BVcXNkamZ6QmJa?=
 =?utf-8?B?a3pIUDEyMjQrdkcyTXhWUkRsdFRmMTVUbmJKdWRCaFMwZ2g0a1BIaFlsSjJq?=
 =?utf-8?B?UFlGbWF1cW5SY1pmUHFUL25PUzVvckpKZ1ZpTnh1R2xNb3ZkZ0htWVJleGdl?=
 =?utf-8?B?cjFXN0t4K0JqemJsOUpzNnBabGFjNnk1eWpkZkJ6M292d0E1NXZzUkxPeUVX?=
 =?utf-8?B?MUgxYkNUUEhTWm9xZnp5cENsa1g3YTNLM3c4TGoraUZkQ0RKSlllSU91RGk3?=
 =?utf-8?B?YWRDMFVjWjRxQnlIaVlsVm5XeWxlSmFhVEw4R1hEcEFkaDJtdWhRcnExb20y?=
 =?utf-8?B?Q3ptUlVYN0dHZm02MVJ0emY0QklVTkpqakpjQjQzcGcvQnJ0am9TYm5LUUJn?=
 =?utf-8?B?bU5hc2REN0Q2L1BHWFY5SmNDU3FEbDZJWllpazVTbUw2cWgzMHhRbjBSSEdh?=
 =?utf-8?B?eFl2NWFKNEFxa3NKbHU1M0IyZUp6TXB3TEtOdUROdXFZUnN2UHpQUUJ0MWdM?=
 =?utf-8?Q?h5OvxBxKxeI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlkWDhWRGZaZWljbnlKY2pwWWJ5QWNqNTlwK01Nb2I1QlFBZFB5clNUWjcv?=
 =?utf-8?B?S2tiOG1yTU1SZlNYWno0b3hrdUtBQWErSXorSGFVTWNWZ0t4cHk4QndjU040?=
 =?utf-8?B?WFVLcXBMZ290Nyt4ZUhtYUtKbmFLR1IrVmp6eU9mTkh2WTUzSkJYU29VbVBw?=
 =?utf-8?B?ZWpLdGorM0YrcVU2L0xMQUhEcG4xdmxhZVFpc1ZDSW5DMllEQWdZYWkrS2tT?=
 =?utf-8?B?SU9QWXpJakNvMWhyM0R5VlZManZBaFcvZi9xa0dJakk3cCs4c093blhVUkJP?=
 =?utf-8?B?Z2wwRXhYa0Q1QldwVGdhT2M2YWxFS0VVVjFTeUxwdi96QlVQaVo2NElHdHdJ?=
 =?utf-8?B?NUFuZldpcStqT0VVYTZpTU9ZWVkvcXF5RU45SmYvbHU4U2NJMXhZdE1RTlRR?=
 =?utf-8?B?VmlWUDNBaWtNOHJMVndYUG1WK3FudHExenE3TFM0Z0NVdlJEVzFaeDRRbG5D?=
 =?utf-8?B?bFpwSTlTRzVINVpENDdkS0tRdEdWVFI0Nm54T0J4WWpNUjVFUXBraXpCQ3h1?=
 =?utf-8?B?TGR2aEtyaUJtcEFYa24ydUxydDJ5M3VJOEIyMmZSZFlidTZlQWxZZUFkaGxz?=
 =?utf-8?B?UjFRMENLS01qQkJ5eTlTUDhzMnZNdy9SVmVTTG0ySTd5Z0E4dGRjNERONU4y?=
 =?utf-8?B?QmozS0pRbmliWVdYSEMrZUJ5aHJ3bEhuZGN2STVlMHprMlp5cVBoc3YvbEVK?=
 =?utf-8?B?KyswK2RhZWRTeTJHM0hEZjBJdy9raDhZS2tGZWMvZi9xbUtsUzRxTFZHbUZB?=
 =?utf-8?B?Q0l3MVVsZkFxa2FtdGNJTy96b2JQTmRrS0lZVEF2ZFp2SFFiVi9ERmRNenlt?=
 =?utf-8?B?ZXRSY0Rld3ZhN21FOVJyMlZLaGRwdkdHcVdDYXA4a29kcmh0R1VTU1M1R25K?=
 =?utf-8?B?STB5R0NyL3l5QWsyZG1vcElncERLRVozSkxQS3R3OFNvekhuaUJ0emZnWEVT?=
 =?utf-8?B?MkYzYm1PdXRiajJoVk9SRTRIRmI4QURDS3oweEhGNzZsSWZYTFIxUWtMS2x5?=
 =?utf-8?B?UCtVVGZKN1MyazNhWGNLZEZnLzV1QTQwUDU2SDM1ekZpdktqUmNlSXgzOHRE?=
 =?utf-8?B?NU9HOW10UHFSaFJzaVNXV2RWcFlEWE1OblRqTnZtYjY0cG8xMGM2ZmxLeWdK?=
 =?utf-8?B?K0tBeEhrdnlnMmVtempPVHNHSzdjYmdoZE9ySHB1VEJoamZ2QXhtQWpyM2Iw?=
 =?utf-8?B?cjN1dUxtT2F3RG9xd2g5VnAwQ1VkZWNmTmZLb0EyNmNyaVpqSzRSVHNqMHM0?=
 =?utf-8?B?NlZabW9oU2JreG5pRXVPYmFkZTQrVmRFQkl2czBhSVlsU3NyaERwS3MxcXFW?=
 =?utf-8?B?Q2pNZVNLUWlyS3BsRGVJSGQ5WEc1VlRzTWZvR3RvWUtCZ0t0aUdzSnZOUHJO?=
 =?utf-8?B?cUcwUi8rT2VWaTFBUllNSFRmczh1ekxsOFBRdmpyUjg4NXlUMlRjT2FVQURm?=
 =?utf-8?B?K0ZDSDZLUkwxQkRMZW10SzlDUmR5TEE0WlozT3FPS2ZsN21LOEZ6SC9ldkxn?=
 =?utf-8?B?cjhHQ2k5TndZRkYwYUxwS00xQVZGODlYYjVSa25jTTh4TVpyQ0dTNDU1dXVu?=
 =?utf-8?B?SGtXd1BHN0ZielE3Umc4MEFuSithTGxHRnA0TDlLU1JqazkzUDFENGo1VlRC?=
 =?utf-8?B?ZVNKR09zakJadFBYN3ZZUHVERFdLNGh3Um1HL3ZzWVVCNDE0cWlkdnBxcTZY?=
 =?utf-8?B?dGRtR3h3aFdJcHhCUGUrYUVKS2FjTzNTQ21Kekh6cWl1bWpzTXJ6c1YvMlR1?=
 =?utf-8?B?QldYeHBBZnhvZG0rQXV3eS80YWs1VmJta2wwSWpLRjZTQ2toQjg1akZ6ZGhH?=
 =?utf-8?B?cDFhYlZZZmRyRG5KNTJOQS92VE9yTjlVR2RqblBFS2ozUjgyc09yMi85aW5S?=
 =?utf-8?B?Rlc5TnJBdUlBRG9hTDQ5RG8vbUZDcDBEeFRxZHV2cHVPYm5ZUzlOaXd0QXFH?=
 =?utf-8?B?QjZLUXAvSVFmL3NiWVY4NU8yb05aQ3NaSzVTdzVYeDVWbWxyelFXaDl3QXJx?=
 =?utf-8?B?VlZCTFQ4bHI5MkI2T2w2d3B3SHhIZXA3TE1vSmw2NlV1YjdQcmxLSm9XdHFo?=
 =?utf-8?B?ckNLUEF4VmhJLzRNclNoVFR5YVEzYkkxVkpzVXFWenFUeHp2VjB3RWc0WE5l?=
 =?utf-8?Q?j9af/Ab9Dgm2PjMshobyomSLN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Di+U5yJ5m6DsP1WQELiA8ILwELbnr+xGC/EcuI0bM2mYKMqOjxjkBNZEYDi5j5BeWotdFTdGHAQ7SeJswBUnmqBrwhNaS7ym+YxQ664xWqQJBP9OIrdXSgq5gQ8cUN2jzTrn/m1k5ABHHj94rvx1cVdLP87crewhhswBoGwIrhTTa2tXLZzWrxZalqAndRxsVh3uSodK0chaRxdvO3FQZV69HbkyKOO6LtIpaHKtdPA9t+JvyAOmxyVt6Xp42bBJYqynM2cZ3HFiNft71LXiViocoJTgbDW8lcoqxpA90Lc5wohFXm/5svs/w3SPHftYgiIjg1tWDeo+SmJBDMYI6Y9nb4BsuAESoMeoqWfvMhMPrqiU2aKi3xGeAalqLIuiK+MpUR4ZJdcuHbaDC0mWHpS/9JM18V88kvFuCeNh41E6MGq6mMek3sYBIELWS1W4/1lZYFHW/sTKE36Y1dwvrCuSrH7mZX1R9hToMVf+p1LU2CyRhI0vTb//9x5Gyy5nSi2+Ojqj8UwR4se5eXRVpsr5X1WzoILr6CSRuPMIz/8AaybmD0LFGY2fHhoKqUkA9SjwTU0u+bemjAJ9LgEN6BL18lD5+x6X1G7uKRkCfwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96922a9a-29a6-4dd1-6fef-08dde9615c2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:10:52.5549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhIIgYFSbi8fXffqVBwpFRTadDq/69eQZtF2xUPA0BK/jBbchta+Ak7YPLgN/FSAI80v4+s8kmv+NEmZ1G+yIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010150
X-Proofpoint-GUID: 4tvqCY_LGZEFHpyWuLrb7-Gq397CEQk5
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b5a970 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=11-KymgGRQZU_cCVpAwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX0hs/URkpLQDB
 j6hg3/sl/5jFoRcQpvhdqeP9SLtF0L5d0t6m97WEGD5O2u/F26SmF6eDbxaETkxbMipPopeFWrm
 82gnYq5Unr0OIzJUR5btuNbOBlfIN8s5ENSZyFIcW6xfQ18+ibuyq0TkfXP/UPxFkOPvlEPx7Nj
 PLYd5kr4Xuam9uhVc73OUwqYS+VgeWQ6Mjh8DwGKY6h/xnPYpxs/u39S6tsvsdRhlzvG8PiXP2G
 L1/2yvdsTTOhitbeueg3Caxx8hEIukrOeIEfXmwfHD/I8ykA6gf+rp/jlIjzDyTAUqOxuEdpmpI
 Zrd5EnQ9/N51MNGBE8zFPfi+kdayB5z5f9Ttlwmru58urBJsPdW17eOSSUqYFYeSvUyUr9ydpaj
 YZ5RfI1X
X-Proofpoint-ORIG-GUID: 4tvqCY_LGZEFHpyWuLrb7-Gq397CEQk5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 8/29/25 5:24 AM, Markus Armbruster wrote:
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 8/27/25 2:37 AM, Markus Armbruster wrote:
>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>
>>>> On 8/26/25 2:11 AM, Markus Armbruster wrote:
>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>
>>>>>> On 8/25/25 8:44 AM, Markus Armbruster wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>>>
>>>>>>>> On 8/8/25 6:48 AM, Markus Armbruster wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>>>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>>>>>>>> virtio devices, where supported, to iteratively migrate configuration
>>>>>>>>>> changes that occur during the migration process.
>>>>>>>>>
>>>>>>>>> Why is that desirable?
>>>>>>>>
>>>>>>>> To be frank, I wasn't sure if having a migration capability, or even
>>>>>>>> have it toggleable at all, would be desirable or not. It appears though
>>>>>>>> that this might be better off as a per-device feature set via
>>>>>>>> --device virtio-net-pci,iterative-mig=on,..., for example.
>>>>>>>
>>>>>>> See below.
>>>>>>>
>>>>>>>> And by "iteratively migrate configuration changes" I meant more along
>>>>>>>> the lines of the device's state as it continues running on the source.
>>>>>>>
>>>>>>> Isn't that what migration does always?
>>>>>>
>>>>>> Essentially yes, but today all of the state is only migrated at the end, once the source has been paused. So the final correct state is always sent to the destination.
>>>>>
>>>>> As far as I understand (and ignoring lots of detail, including post
>>>>> copy), we have three stages:
>>>>>
>>>>> 1. Source runs, migrate memory pages.  Pages that get dirtied after they
>>>>> are migrated need to be migrated again.
>>>>>
>>>>> 2. Neither source or destination runs, migrate remaining memory pages
>>>>> and device state.
>>>>>
>>>>> 3. Destination starts to run.
>>>>>
>>>>> If the duration of stage 2 (downtime) was of no concern, we'd switch to
>>>>> it immediately, i.e. without migrating anything in stage 1.  This would
>>>>> minimize I/O.
>>>>>
>>>>> Of course, we actually care for limiting downtime.  We switch to stage 2
>>>>> when "little enough" is left for stage two to migrate.
>>>>>
>>>>>> If we're no longer waiting until the source has been paused and the initial state is sent early, then we need to make sure that any changes that happen is still communicated to the destination.
>>>>>
>>>>> So you're proposing to treat suitable parts of the device state more
>>>>> like memory pages.  Correct?
>>>>>
>>>>
>>>> Not in the sense of "something got dirtied so let's immediately re-send
>>>> that" like we would with RAM. It's more along the lines of "something
>>>> got dirtied so let's make sure that gets re-sent at the start of stage 2".
>>>
>>> Or is it "something might have dirtied, just resend in stage 2"?
>>>
>>
>> Exactly. This is better wording since it doesn't necessarily have to be
>> sent at the "start" of stage 2. Just at some point during it.
> 
> Got it.
> 
>>>> The entire state of a virtio-net device (even with vhost-net /
>>>> vhost-vDPA) is <10KB I believe. I don't believe there's much to gain by
>>>> "iteratively" re-sending changes for virtio-net. It should be suitable
>>>> enough to just re-send whatever changed during stage 1 (after the
>>>> initial state was sent) at the start of stage 2.
>>>
>>> Got it.
>>>
>>>> This is why I'm currently looking into a solution that uses VMSD's
>>>> .early_setup flag (that Peter recommended) rather than implementing a
>>>> suite of SaveVMHandlers hooks (like this RFC does). We don't need this
>>>> iterative capability as much as we need to start migrating the state
>>>> earlier (and doing corresponding config/prep work) during stage 1.
>>>>
>>>>> Cover letter and commit message of PATCH 4 provide the motivation: you
>>>>> observe a shorter downtime.  You speculate this is due to moving "heavy
>>>>> allocations and page-fault latencies" from stage 2 to stage 1.  Correct?
>>>>
>>>> Correct. But again I'd like to stress that this is just one part in
>>>> reducing downtime during stage 2. The biggest reductions will come from
>>>> the config/prep work that we're trying to move from stage 2 to stage 1,
>>>> especially when vhost-vDPA is involved. And we can only do this early
>>>> work once we have the state, hence why we're sending it earlier.
>>>
>>> This is an important bit of detail I've been missing so far.  Easy
>>> enough to fix in a future commit message and cover letter.
>>>
>>
>> Ack.
>>
>>>>> Is there anything that makes virtio-net particularly suitable?
>>>>
>>>> Yes, especially with vhost-vDPA and configuring VQs. See Eugenio's
>>>> comment here
>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAJaqyWdUutZrAWKy9d=ip*h*y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com/__;Kys!!ACWV5N9M2RV99hQ!MHkMmGR7j2n9i2We6Mh3xXX03yEve90Bhs0aEDCVYU4Z0n-op-0aDlpWMBGZ7CpjDOBnhTkDVJjx8QcQ$ .
>>>
>>> Such prep work commonly depends only on device configuration, not state.
>>> I'm curious: what state bits exactly does the prep work need?
>>>
>>> Device configuration is available at the start of stage 1, state is
>>> fully available only at the end of stage 2.
>>>
>>
>> We pretty much need, more or less, all of the state of the VirtIODevice
>> itself as well as the bits of the VirtIONet device. Essentially, barring
>> ring indices, we'd need whatever is required throughout most of the
>> device's startup routine.
>>
>> In this series, we get everything we need from the vmstate_save_state(f,
>> &vmstate_virtio_net, ...) and vmstate_load_state(f, &vmstate_virtio_net,
>> ...) calls early during stage 1 (see patch 4/6).
>>
>> Once we've gotten this data, we can start on the prep work that's
>> normally done today during stage 2.
> 
> This is unusual.  I'd like to understand it better.
> 
> Non-migration startup:
> 
> 1. We create the device.  This runs its .init().
> 
> 2. We configure the device by setting device properties.
> 
> 3. We realize the device.  This runs its .realize(), which initializes
> the device state according to its configuration.
> 
> 4. The guest interacts with the device.  Device state changes.
> 
> When is the expensive prep work we've been discussing done here?
> 

During 4.). The expensive vhost bring-up (e.g. for vhost-vDPA) happens 
during vhost_dev_start when it has to send ioctls to configure the 
memory table, VQs, etc.

This prep work depends on negotiated features, device configuration 
(MAC, MTU, MQ), VQ layouts (vring addresses), memory table, etc. It 
doesn't require dynamic VQ state like ring indices.

>>> Your patches make *tentative* device state available in stage 1.
>>> Tentative, because it may still change afterwards.
>>>
>>> You use tentative state to do certain expensive work in stage 1 already,
>>> in order to cut downtime in stage 2.
>>>
>>> Fair?
>>
>> Correct.
> 
> Got it.
> 
>>> Can state change in ways that invalidate this work?
>>>
>>
>> If, for some reason, the guest wanted to change everything during
>> migration (specifically during stage 1), then it'd more or less negate
>> the early prep work we'd've done. How impactful this is would depend on
>> which route we go (see below). God forbid the guest just wait until
>> migration is complete.
> 
> So the answer is yes.
> 
>>> If yes, how do you handle this?
>>>
>>
>> So it depends on the route this series goes. That is, whether we go the
>> truly iterative SaveVMHandlers hooks route (which this series uses) or
>> if we go the early_setup VMSD route (which Peter recommended).
>>
>> ---
>>
>> If we go the truly iterative route, then technically we can still handle
>> these changes during stage 1 and still keep the work out of stage 2.
>>
>> However, given the nicheness of such a corner case (where things are
>> being changed last minute during migration), handling these changes
>> iteratively might be overdesign.
>>
>> And we'd have to guard against the scenario where the guest acts
>> maliciously by constantly changing things to prevent migration from
>> continuing.
> 
> Yes.
> 
>> ---
>>
>> If we go the early_setup VMSD route, where we get one shot early to do
>> stuff during stage 1 and one last shot to do things later during stage
>> 2, then the more that gets changed means the less beneficial this early
>> work becomes. This is because any changes made during stage 1 could only
>> be handled during stage 2, which is what this overall effort is trying
>> to minimize.
> 
> Stupidest solution that could possibly work: if anything impacting the
> prep work changed, redo it from scratch.
> 
>>> If no, do you verify the "no change" design assumption holds?
>>>
>>
>> When it comes to early migration for devices, we can never support a "no
>> change" design assumption. The difference in the design lies in how (and
>> when) such changes are handled during migration.
> 
> Just checking :)
> 
> [...]
> 
>>>>>>>> But I think for now this is better left as a virtio-net configuration
>>>>>>>> rather than as a migration capability (e.g. --device
>>>>>>>> virtio-net-pci,iterative-mig=on/off,...)
>>>>>>>
>>>>>>> Makes sense to me (but I'm not a migration expert).
>>>>>
>>>>> A device property's default can depend on the machine type via compat
>>>>> properties.  This is normally used to restrict a guest-visible change to
>>>>> newer machine types.  Here, it's not guest-visible.  But it can get you
>>>>> this:
>>>>>
>>>>> * Migrate new machine type from new QEMU to new QEMU (old QEMU doesn't
>>>>>      have the machine type): iterative is enabled by default.  Good.  User
>>>>>      can disable it on both ends to not get the improvement.  Enabling it
>>>>>      on just one breaks migration.
>>>>>
>>>>>      All other cases go away with time.
>>>>>
>>>>> * Migrate old machine type from new QEMU to new QEMU: iterative is
>>>>>      disabled by default, which is sad, but no worse than before.  User can
>>>>>      enable it on both ends to get the improvement.  Enabling it on just
>>>>>      one breaks migration.
>>>>>
>>>>> * Migrate old machine type from new QEMU to old QEMU or vice versa:
>>>>>      iterative is off by default.  Good.  Enabling it on the new one breaks
>>>>>      migration.
>>>>>
>>>>> * Migrate old machine type from old QEMU to old QEMU: iterative is off
>>>>>
>>>>> I figure almost all users could simply ignore this configuration knob
>>>>> then.
>>>>
>>>> Oh, that's interesting. I wasn't aware of this. But couldn't this
>>>> potentially cause some headaches and confusion when attempting to
>>>> migrate between 2 guests where one VM is using a machine type does
>>>> support it and the other isn't?
>>>>
>>>> For example, the source and destination VMs both specify '-machine
>>>> q35,...' and the q35 alias resolves into, say, pc-q35-10.1 for the
>>>> source VM and pc-q35-10.0 for the destination VM. And say this property
>>>> is supported on >= pc-q35-10.1.
>>>
>>> In my understanding, migration requires identical machine types on both
>>> ends, and all bets are off when they're different.
>>>
>>
>> Ah, true.
>>
>>>> IIUC, this would mean that iterative is enabled by default on the source
>>>> VM but disabled by default on the destination VM.
>>>>
>>>> Then a user attempts the migration, the migration fails, and then they'd
>>>> have to try and figure out why it's failing.
>>>
>>> Migration failures due to mismatched configuration tend to be that way,
>>> don't they?
>>>
>>
>> Right.
>>
>> So if we pin this feature to always be enabled for machine type, say, >=
>> pc-q35-XX.X, then can we assume that both guests can actually support
>> this feature?
>>
>> In other words, conversely, is it possible in production that both
>> guests use pc-q35-XX.X but one build supports this early migration
>> feature and the other doesn't?
> 
> I'd call that a bug.
> 
> Here's how we commonly code property defaulds depending on the machine
> type.
> 
> The property defaults to the new default (here: feature enabled).
> 
> Machine types older than the current (unreleased) one use a compat
> property to change it the old default (here: feature disabled).  With
> this value, the device must be compatible with its older versions in
> prior release of QEMU, both for guest and for migration.
> 
> Once you got that right, it's fairly unlikely to break accidentally.
> 
> The current machine type then defaults the feature to enabled in the
> current and all future versions of QEMU.  The machine type doesn't exist
> in older versions of QEMU.
> 
> Older machine types default it to disabled in the current and all future
> versions of QEMU, which is compatible with older versions of QEMU.
> 

Got it. This is something I will look into then for this kind of 
implementation. Thank you!

>> If we can assume that, then this would probably be the right approach
>> for something like this.
>>
>>>> Furthermore, since it's a device property that's essentially set at VM
>>>> creation time, either the source would have to be reset and explicitly
>>>> set this property to off or the destination would have to be reset and
>>>> use a newer (>= pc-q35-10.1) machine type before starting it back up and
>>>> perform the migration.
>>>
>>> You can use qom-set to change a device property after you created the
>>> device.  It might even work.  However, qom-set is a deeply problematic
>>> and seriously underdocumented interface.  Avoid.
>>>
>>> But will you need to change it?
>>>
>>> If you started the source with an explicit property value, start the
>>> destination the same way.  Same as for any number of other configuration
>>> knobs.
>>>
>>> If you started the source with the default property value, start the
>>> destination the same way.  Values will match as long as the machine type
>>> matches, as it should.
>>>
>>
>> Given that migration can only be done with matching machine types and if
>> we can assume that guests using pc-q35-XX.X, for example, will always
>> have this support, then my concerns about this are allayed.
> 
> Glad I was able to assist here!
> 
>>>> Am I understanding this correctly?
>>>>
>>>>>>> [...]
>>>
> 


