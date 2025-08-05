Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A166AC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 12:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujGSw-0001kp-Dy; Tue, 05 Aug 2025 08:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ujGSR-0001aL-0N
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:07:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ujGSO-0007Ao-CK
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:07:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759H0Lj026532;
 Tue, 5 Aug 2025 12:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=BEA3tBWHlCOADlcapIzGhqpxMAZCIt6ENfKOtFD1u0w=; b=
 CtpFAwnqGavR9u6NwrKMuRZh7e5GEGTYbqDukzCZ2PrGv9F7MYPviJwu1fm2cBHf
 8LMVdmlKvzDSWBb3GqfuiR1332GFLaL/GDzy1HaKOvweqFbTuyB2MiXfGDIYC0JJ
 MyLSxFjSbl398ZZL7X31JAZDMKqAEOEUh//al13Z+8A6dfISXeqPGM6ZoLJCQCam
 HizzmOzW0u2ctWG0SC0rGPOLTpBcGMLpy3VkOTEQGGGHhi3MARSi47JHe1F+B7d2
 q0r9Q8Xx5nbUjmI//9Luu/bPwka+egtMciT5qPDUuHkqkurrtziErubSZjisBO8y
 EL6+bEgCNGhwPkhwyxG92A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vvhw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Aug 2025 12:07:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 575Ag11t025466; Tue, 5 Aug 2025 12:07:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jtm9bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Aug 2025 12:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwfrigffi5ZK1DTgReo6IpI3RUbbcW9BW8Hd6j+OZBlvoVRUsQreJwA+mGVtacwMRWnj+DvyxipFrVH+KE90u0e2yw15LB+kV86qEi7Dtj4EqWESkJ08oA8i+3ZkBAL1AsI+zlNrk2F0ArJrNiZRz2dvcPzQwg3T3uA3yvQjTg0Z7ILCiCwbtQOPL/YtTjpRSVdI+smRUGL8XxyAd+ijWnjJHtz0QjZNl8H0XYyGm3tZxSV/jZPxlCbuWqPxOGDWK83qJtV040J4nkvnqSjIs3r1cohglHsT7nd0TaGsZMSAZLGArCPRnfJbLzhw0V7zv9MC8uRCDAKx597/BzfJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEA3tBWHlCOADlcapIzGhqpxMAZCIt6ENfKOtFD1u0w=;
 b=PW3kUEK5PDjGlObcrwdIevQi0mK425/1xh5I/fNFA6YBhZ7JtRRgJD91mIyLEdTEZSyOIEZwdu12OCdlcRv5qvJx0Vteb32XmX/6vMsoAEE4q4ElREWxT8usHm4KD9xf1lkSwZbTR3QrnALdFlg8FsrgNdUeuL+Wo4Rsyyvd6e6/mmHQdWlOmueyofYKBeOYEUBPd9I73/115/Ei9Oq5JY3MpQvYwgplvqiJ7bOJ7P9Ih6tEKP1KieodMrlWuRBR3lAeZ+lpy482qtMw/FB9cvfd7C7FeLPtZJpUFeO+jY/FOgqLsB+rxGagqV9o94w4fKwmvJtm8fANUyJdUR4oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEA3tBWHlCOADlcapIzGhqpxMAZCIt6ENfKOtFD1u0w=;
 b=T2SeZO0Eivb82kYf0rU5YL2cPOCQaX6A7FeN8zQYOA2PuTUS9eOG0X1js0lvdy1AjpWG9stiRbpX5ll0SP7om6ZGbRuV5OrZmooYQR1yAgqBrJhRlwemcEqbeuQR9SfSB790opl80va5G5KUVeFIt6V6ndQnRYS3SRmIbHfZG7w=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7829.namprd10.prod.outlook.com (2603:10b6:806:3ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 12:07:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 12:07:45 +0000
Message-ID: <703ad843-e904-4c8f-80af-4970f863ef6c@oracle.com>
Date: Tue, 5 Aug 2025 08:07:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] qtest/qom-test: Plug memory leak with -p
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-2-armbru@redhat.com>
 <a7a3ba56-680a-4256-b6e1-ff78f131fdf0@oracle.com>
 <87h5ymdzrf.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87h5ymdzrf.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cefdeb-688a-4afa-bef6-08ddd418b03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFFsR0FWRVdROEpTM2pUSVJybUF0akR3L2xJYlYxUnhZT3YwR0VtKzRVL3lE?=
 =?utf-8?B?YngwVGp0L3I5RHhQaGdSV3psT25Ray9KSVZQV2VhY2tOb3BIbTJrZlFNR3I2?=
 =?utf-8?B?bDhLYmhwblhXd1h6eUk3RFdoNkVSTSthS0NhODFqVmwxQ1MxZ243akphRGhl?=
 =?utf-8?B?OC9NbTdBbGRvb1hpNENpVEpPVWRhZWE5dktiUStaT2I0a0tEZ041dlpOTWFM?=
 =?utf-8?B?OFFkWis1WmxZa3hQdlEzV0d6SUFQQmE0Vmt3UmJQZmNyRytQM3ZsdGtXUEd5?=
 =?utf-8?B?VHg3UUJVSmR4KzVYQXRPb1diWThxblByKzVxN0IrT1Z0REExU3NNZUR3bENG?=
 =?utf-8?B?THI0bG9uNjRtTWF1WnhVdGI4OEVkUTFBUXJEa2FuOUFqWnJad3dsRmhITy9t?=
 =?utf-8?B?cWptSStKMVZKMS95THgyQ2NSblFWc3FSb2pndUJQdHltbFo2TUdPMUJKSzlx?=
 =?utf-8?B?bjhrdllPVUJMQ0c3NzQxRERmQU13OFRFUlRIeW1CekdtMVcrZEpLMmlmVzA3?=
 =?utf-8?B?SWs2b0M0ck5sY1owTktrRTZvRm9OdC9EWnV3YXV2NkllOHlHc281QWxMbGc5?=
 =?utf-8?B?NUVJYXc1cFpQZTZxbEs0YWZiaUVxZTV0NE5JWHhJUmd1NHFUbjJqRi82bnpv?=
 =?utf-8?B?NDAzeFdhUk9kQVo2aTBoMU84ZzdtQmFXejJqZk1lZVByZ3dZRjVOOHJRZjVx?=
 =?utf-8?B?VEZEajQwNjZJOFRMQmJXUUV0N1A4ZU43VjRnTXJqcHNHOGYwd2xjdVdlOTlD?=
 =?utf-8?B?UmttM0t2TlFJTHRyTjQ2ZjU5YUlrSnpmc1RZVVh6Y3RhRmNETXZ5VWRsYklQ?=
 =?utf-8?B?aTU2TndTZ3k1VG8wbVJEM3Y2c0dEOEFsNjRvZ25PbkVySll2Vi9Ec0RGdjdi?=
 =?utf-8?B?UEQ0c0x0bzJDY292SytBeFFWNWJaaGRWbFNyV2grZU5HSHVjN1JYSjd2bllM?=
 =?utf-8?B?V2xmZWt0VUU2em9NM3FaajhQSGx6S0x1aFV3aG1WcFZnTWxPanZhYTdwRy9V?=
 =?utf-8?B?MTNEeHJSMHBSNlgxOGVhVE9mVEFzYU1BRklnUWdjVmZNUnZ2QzdrMVk3QWdt?=
 =?utf-8?B?ZkZCMjNkVTlXWGRSbXJxOHlJcHBwd2VvTzR6QVRlY0NLNEJwRDRaTXpNdVgr?=
 =?utf-8?B?SXNLQWY3TG5KcVY4ZHpyNXpUZkZsRzNwWHlrQXlCOVRPQWNza1h6VitjQWJp?=
 =?utf-8?B?azMrUm8xV0c1MjFSZVFsQTh1TW1Ld2UrUlRvYjAxdkprZENzVS81NE45cVNO?=
 =?utf-8?B?ZzdHNTFtZ2h4SWZWbWJqMFROMTRaL2lpUG9qU3hZOC9EZlFQd2RwLzhBUXkw?=
 =?utf-8?B?N0VXSHlpT2t6VUR0VitYeTNnb1MzVnoxY3g4RXBaeHdHUnNOUy9EMVZtNDJ5?=
 =?utf-8?B?UzN0eGZLYlJrbmd3bks3ZUVFSGRtTnN3QmZ3VWZsc2Nyd0lPOS80SEpINHJj?=
 =?utf-8?B?NDhvSUZVdWZNVk5Malc5OW9qK09RV2JPL09yZHMzNXJKNytpZ2t4MUJUY2NI?=
 =?utf-8?B?RlNTM05EMk5UUUdidTNmTUlkY1lCajd0czdKY1k5c05Xck81aWRlMThBL0Ft?=
 =?utf-8?B?WGFqa0pLQVhocXNVZWhkMUdnVTdhUTJJWHVHbkR0eDdFUXF6c251S3R5YlA2?=
 =?utf-8?B?ZGRsejVyZlpoUElXUkpWZ1ZtYlozV1IxQTJ2dm53MTh3Ujh5dDk5dDZpTkh5?=
 =?utf-8?B?cVZYNWdzOGEvdjl5U3pleUZrb1hsUEoycm1hamJWRGZMUVYzWlhaVkEyNjgw?=
 =?utf-8?B?US9DT2hIb01VOE1TY0ZSUnlMZkhxVkJjQmF1bnozY3c4UkM4ejJCNmpTOHdh?=
 =?utf-8?Q?xsU1M26jTvywVIMfcJ0bUtGrbhool9zWGxfFY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0FYTURKSmV1TzRjWXRubERnQ3FJQ2VMKy9QT3F6TUx1UmVtWEM5ZnVONGIw?=
 =?utf-8?B?Q2FkQkVRZGkySkg1MmdwUjA4RGY4MTI5Wkovdkxqb2RhTWtmaUVQQ1lZR0li?=
 =?utf-8?B?RmNaMEI5N1lmN2JxUkdYMnZsQklSMnhoN3lDcndWMEdaOGVHYml0NnQybFk3?=
 =?utf-8?B?ZWxCeitxZ1EzTzA4WVgwZjdaMU42YUZHNUJzR1BVQk9NVGxIRGxEb2EzSGxU?=
 =?utf-8?B?MVdBUUk2ems0VmxNYzJzcU9jZG0yR2QrbEZjdmNrcUdZOXBxQWNtbFFwWlll?=
 =?utf-8?B?UEtOQnRqYkdJdzJaYXJ4cG5Ha0tUWll5TGJuRXhyQXkyck4vRzB5ZEhPdjhn?=
 =?utf-8?B?KzRKdGdIL3A4YkNzT1dJK0ZzaXhpRmFpREprRzNCMTBLaEc0blJpRzI4dlVy?=
 =?utf-8?B?QVdwZU9kSnl2L2cyWVdPc2JiZkhCdUdxQldnbDZobmhKUCtWZU5rNHlhZStT?=
 =?utf-8?B?dnFweFRNclhyR0FSWFp0bEs1Rnk1bkdZRGE3RGh5YnkyQ3U0N3M4VXJEZFlS?=
 =?utf-8?B?SG95T2t3NDJnNEkxUjNWTWFNMnQzMDVuN3ZyM2tRbFd4Z3V6V2lxZUZmZHlx?=
 =?utf-8?B?emloSlp1RmRLa3dPeDVMaHpjOFVmNzl2WWRnck0yRk9JZlVYVTJnK1BMUS80?=
 =?utf-8?B?YzloR3JDb29zVXpUblR4eFFVYVc5QVc1TEpiY2U5RUpkYVlIdnlmVEFLOG52?=
 =?utf-8?B?ME1LMG43M2xwS2xuanZhVUEydDZMcmg2REYydGFvbkdNTUtBYS8zM24yYnVl?=
 =?utf-8?B?aGVLUjdsVW9DU1AwN0hFaVdmNEtpRVkzb3k1RWlDeVRiMnFxVFBWMEFhR0Rm?=
 =?utf-8?B?eGRTR2dubWNWZFEzUlN5NC9PUUJyblhsNDU1SmVIQ0ZMM1FPa3NJYUt2SFpJ?=
 =?utf-8?B?ZC8za1JFZDAybFN4SEpJdWNDbEl4MUlNZ1pHWnZuY2RDMEYwOUpGMkpydWN5?=
 =?utf-8?B?SzdmNGUxYTJPei9xeGxxMkdyKy9CQ01HTWE0cEFvSnltMVlGcE5hVjB0QzNB?=
 =?utf-8?B?U1E3KzNrTlFUdFFnRVJqR3hKeE1jR1UyamxnWTErblZoTFgyckxlWTZ4NHd1?=
 =?utf-8?B?cVBQYmRKaHMyU0lldThxcEI5Q2w0bWUyc3pNSjVoQWdIVHk5aW9ZNm9uRmxQ?=
 =?utf-8?B?V3FNN3lCUXM2WUY4L1FJRTdMYUZHaE1lVlFGV2xCbUs2Z2E2anMwY3RqbWZV?=
 =?utf-8?B?MGc4ek15Rll1UFB3WFlQNUhSRUJ5TnYwYUdOKzRkSWhxeVZOY2tHUEJMQW5F?=
 =?utf-8?B?TEZqRDA1emlEcXpxSjE4WUE0ZXBCVlNaOE4zTjl3YkJZK3lMekdDa3p4UU9F?=
 =?utf-8?B?emF2T0RFaEhSRTM3WmFjU0RuYVlXbFU5aENJUkhGeE80WkJPZElFVWgxK2d4?=
 =?utf-8?B?NDZKRHhiTmszQ05mS2VPRUtpL0JDWVZraFBBb1dEc0Fab1VDUjJsNzRwS1lZ?=
 =?utf-8?B?bGJtNE9BM0phRkdZdzloWmN1RlB2N0JnajhmVm9VTW9XZzE3YVlEcGJ5aFJm?=
 =?utf-8?B?MXVJL1RTNnFwZGVnVzNFZDAzTzlLUUgzaEorNTVlZjdvaHNHVFhtRmNoTzJz?=
 =?utf-8?B?ckRabWRJTTl6RmJoMGVKNjRyRGp1RkRRNGZ1dXA2eEhieE9WUk0yZmVtMUNi?=
 =?utf-8?B?RFMvSDRZZ05ET3EvUnlmMjRBOUg4d2VJK20vMGs2TnYrWXhZR1E2aHRmTnRI?=
 =?utf-8?B?eUNqR3dZREdDVldqZi9UKzd6dnNOMUdxejloZ1EvSFV4NTNGQVEvYU5kM21v?=
 =?utf-8?B?WE1xTUliYWoyMUJuSUI1ajhhZmZzaVFDTUJWV2U3UmE4RnNONDlEZTRURDU5?=
 =?utf-8?B?WU1Ucis1ZnhOL2dmYmo2VjR2MlFqSTljUXBUdURhNWJKaUJvMDFsN2crakZu?=
 =?utf-8?B?Rk9nUDZPNXVtNm1BTmFoK3U2NGRrQ1dnTlNVckNQMHhaS0RDQkl6cGF2Ym13?=
 =?utf-8?B?WHlJZWJ0NjVUS1BVOWNZalZwM28rS3NMdmNDYUo1Y2Z6UGVHZC9YK3R4TFlE?=
 =?utf-8?B?ZlIrVC9FS1BoQ0F2bXFtNFp2cmJ5RDdtQnVSS1RQOTZWditieTgxZ2RuWVdx?=
 =?utf-8?B?NHBVcEp4WElvOGVEK1IyUmRRcUtUMko5WDF0SE1kdU1XMjN3Nk4xd29KY1RR?=
 =?utf-8?B?KzdTRWVyY2tuOExPLzkrcklxbVlwa1c4Tmx0NGJaK3lYM1pZWkxOQzZwbjRs?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XlFSqrVXdlY5Lftr3c0WxBUR4pExzR0saFEzPDrjmD6pyeY6NhDiWjVVCt044aTDhxEcpvSWlOAmKumhIHxjmMpuJmbRNH80Vn1Yp4BiDiNEbItG/uJVSV6GDze9qo70RNcN0x7UKxSaFeRzt9Ziwt+vDmV04JxLXdB7BmKyXewO3huZgk7+Pw0RY87cLxfUO5Dp76Z9UbAVCMxGTeL1MxDyCmgRgEcMiAFCiwKAWz6e2w6N1DlpytmtfZ/FiB7jKAYbXKM85rPG4Z3V+URnvvMTEyKgKzmpd3uMisnEZCuRd6A4jUUnm0euVanXWbIh+53doOFxXeQPZcgd+3MMZMLVWhlO2y7C5uK5io7XLDQqs3Bu3uWT5lESd1cINEM4GfIpFiBIOaAx6bGRn0amHjQCVVdtGya15vemX7Ky2scugRpJ2nhHccWvFD/iphV0gNeQU9Q1fkEMxF2XhzbFT4btTHnIAppmGMRwylM2RvVIQx7xV8fhPIyEyGqWm/r3YVbRKjnIuvjm4BX38TCKu/SPtjKraxAZ6nbJgcvQNgoVqoXrVRN7Wze8ZxXxjM/Qb8mhpgCTcYsYtC0gS5q9H9hbDR4+rH7VFDZTWjjCcW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cefdeb-688a-4afa-bef6-08ddd418b03e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:07:45.8908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mA33GqgrJoQmn40sIFlqYHH3sWurqlNfVrUgj9Yc/JJqdQ3RA6n3qXXsVdSEzWEKKQKHr7+a7UKgGjz29bssvKDMiZDt/6IfZUl8MHexyCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4OCBTYWx0ZWRfX5rAE+uK5aveE
 dVCMJXY265P/M1fc8GC4xDPs4drWp4Bom9QkxRQ5hxrUgFTbCusz5vvIxH4RKahFc43fcvBAxB7
 5sYQK/HB4gfTDUQl8oZpG6WNABxpbHOIYP0z3N2qmvtB3Pad/IjXw7Uv3Ygow4/CG+9BdayM5kn
 stsogw+W2t0tnIpOl/0Ao/bR9N57mKVN6twIejjaGY9EyGB6LSSeQPwC2erx/qb9FFe3dNWwPJJ
 s3ZS4TDSaYnNyi6xCX0IGJ98STD41LnuQrq7e4nTt/KxAmrDf1hVlf+PAUqxv4SrzttRXALzze8
 3wgkbLnvYlNc1Km+SaQ5GcxYlj4sYtz2Nk7GPY4+MZkPp235w94U98+vKL4/P7GjpoX/A8DQrOP
 L8WeEjE8/FQaiSTxvlOHc0uCIk8DBtLflFEyN+NrMfevubFoSQTRDEBiRqfDMKqwr9NZqc8I
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=6891f416 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=A3H8OfN2AAAA:8 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=v7jy1KifV_lzA3f73CoA:9 a=QEXdDO2ut3YA:10 a=eb6_e5ZlHzUA:10
 a=hKFNpMRl0UUYlmJlzFdh:22
X-Proofpoint-GUID: mvQCXX0NL5x1KWn3Qvv8Qi8jmvC4Qi0f
X-Proofpoint-ORIG-GUID: mvQCXX0NL5x1KWn3Qvv8Qi8jmvC4Qi0f
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/5/2025 2:54 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 7/25/2025 9:50 AM, Markus Armbruster wrote:
>>> The machine name g_strdup()ed by add_machine_test_case() is freed by
>>> test_machine().  Since the former runs for all machines, whereas the
>>> latter runs only for the selected test case's machines, this leaks the
>>> names of machines not selected, if any.  Harmless, but fix it anyway:
>>> there is no need to dup in the first place, so don't.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   tests/qtest/qom-test.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>>> index 4ade1c728c..cb5dbfe329 100644
>>> --- a/tests/qtest/qom-test.c
>>> +++ b/tests/qtest/qom-test.c
>>> @@ -220,7 +220,6 @@ static void test_machine(gconstpointer data)
>>>       qobject_unref(response);
>>>       qtest_quit(qts);
>>> -    g_free((void *)machine);
>>>   }
>>>   
>>>   static void add_machine_test_case(const char *mname)
>>> @@ -228,7 +227,7 @@ static void add_machine_test_case(const char *mname)
>>>       char *path;
>>>       path = g_strdup_printf("qom/%s", mname);
>>> -    qtest_add_data_func(path, g_strdup(mname), test_machine);
>>> +    qtest_add_data_func(path, mname, test_machine);
>>>       g_free(path);
>>>   }
>>
>> This will break if qtest_cb_for_every_machine ever composes a machine name on the
>> stack and passes that to add_machine_test_case.  Unlikely, but the strdup makes it
>> future proof.
> 
> Hmm.
> 
> qtest obtains machine names via QMP on demand.  This is
> qtest_get_machines().  Once gotten, they live forever.
> 
> Used to live forever, actually: commit 41b2eba4e5c (tests/qtest: Allow
> qtest_get_machines to use an alternate QEMU binary) throws them away
> when qtest_get_machines() is asked for another QEMU's machine names.
> migrate_start() does that.  It appears get each one's machine names
> twice, because it switches back and forth.  Wasteful.
> 
> Anyway, you have a point: more stupid shit happens below the hood than I
> expected, and even more may be added in the future.
> 
> Moreover, at least test-hmp has the same leak.  Plugging it here and not
> there makes no sense.  I'm dropping this patch for now.
> 
>> Also, mname is not the only leak.  path is also leaked when only a subset of
>> tests are run:
>>
>>    qtest_add_data_func(path, ...)
>>      gchar *path = g_strdup_printf(...)
>>      g_test_add_data_func(path, ...)
>>
>> Leaking seems to be par for this course.  Maybe not worth fixing.
> 
> valgrind shows the machine name leak my patch plugs.  It does not show
> @path leaking.
> 
> Let's have a closer look:
> 
>      static void add_machine_test_case(const char *mname)
>      {
>          char *path;
> 
>          path = g_strdup_printf("qom/%s", mname);
>          qtest_add_data_func(path, mname, test_machine);
>          g_free(path);
>      }
> 
> Always frees @path.
> 
>      void qtest_add_data_func(const char *str, const void *data,
>                               void (*fn)(const void *))
>      {
>          gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
>          g_test_add_data_func(path, data, fn);
>          g_free(path);
>      }
> 
> Always frees @path.
> 
> g_test_add_data_func()'s contract[*] on its first argument: "The data is
> owned by the caller of the function."
> 
> I can't see a leak.
> 
> [*] https://docs.gtk.org/glib/func.test_add_data_func.html

Agreed.

- Steve

