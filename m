Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BE5C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCN8g-00056T-TJ; Wed, 29 May 2024 13:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN8d-00056J-7S
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:30:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCN8b-0000EC-B3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:30:58 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TGXubK017461; Wed, 29 May 2024 17:30:53 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DEqSLTm4gF/7PEwizn22bfwsJ5F5dVBOJZSbgZD01gQo=3D;_b?=
 =?UTF-8?Q?=3DZ4gR/aOY8a124PbuhhcK7BcvJjoABhOGxVYUGniJJ3G9NQX9a+UrLVtwWgrt?=
 =?UTF-8?Q?vAUM4f3K_B828zD5YHC6e95nu/2otNKkRAf11++8ZhhI8Gt1dUdK+RZa/oOcQGZ?=
 =?UTF-8?Q?n0SHwKanrBL/se_e7RsGo+J89RIjWixQotOCt3wuKXAAnXs26st8ZiQ/4SYPMmt?=
 =?UTF-8?Q?5wAWiPGcqzP4rF0l5DJy_oio6sWTP2Xo9qIqN9G6T7SmXHp1FoxrIja1sndYoRt?=
 =?UTF-8?Q?mfs39Gs5vdEjdfg3068s0NjB9u_4LKS2rmY6IiYTlJCeRrwPIpu1Bc/S2tah8Wv?=
 =?UTF-8?Q?AmDcq74t4OVejyE1BWjS89EXk5OuSZfx_yg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9qbvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:30:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44TH1fTf026592; Wed, 29 May 2024 17:30:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc507h0bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 17:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht9nMSa/PAVVvK3Jv4I3m5q8GiqvwwRUVdDk63xXGIJ89kElF7Y0pAlzp0f5xCtmbHgEA5UNIYV030qAUUEVN6sOWs/gA+RUyfh+ZlvM6uCIMhp+E9ze/V8YBNBf/9HdOONkaZiCA0CFfqSIjP47a/J/sFATKER0SoWha8zu1Zj0SspJziSnm/qGPsdZ93yOTJ+mT+shE8gYrnwK0SL3Nhqz/Nq4fu+xzwk5yzZNA4OlhPfJXISPm8WI/AfMKzS1cpKhJ5FFliD01R922LR5KRrK2zSFV2/Fj0dK9aKgS/Gyla+tdRMXaqFIJPfum5vnAiJqn+XDYvsIWX3INExISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqSLTm4gF/7PEwizn22bfwsJ5F5dVBOJZSbgZD01gQo=;
 b=ARoDFEXBookSUGD16WN68EHCBBuLtuQIDiKNLiMWnRvQc0dttihGsjhIH0/WivUKX6G03E+S8pEWxKL3UhrhkZkSZalMrOGJtz6wuibMqfiM6UdkL2piCKndembpFq2eoLT9RlgK8ICTzFDgvgRlhDr/h1BB36wnBH9+lFaykhbxZR8K2WPz70hP1q4uJLWelvV5Wsx0FcpQdj4ZxA1Hvyn+tcMfzzSP7G2wwmPWWDKZzq5JaxSCRqnN5IWwwz5w1ESKeivXKSx3sUKKUxKCmwuNP4dL3o4wxDMlYT2NYbSF4yViIRrfekzF87fBAtK0XUEb76mCLFWmGf1+XWa8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqSLTm4gF/7PEwizn22bfwsJ5F5dVBOJZSbgZD01gQo=;
 b=CVzR2zjSKEU7p3eCxr0UL0BWNX/KIgUjRBUhf2zIjR8MKDPm+ieaW/HM4LtIktUOQs8Dq0bI4YBPHKcGTJxCJq0PhcndSet7JtskDOvvYcRXEwRdjmRMe/BN9TG9F3Qf7N8OnR2At5eKjuGsToHxHgNg9aiU0Cl2rPba8B+pLBE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 17:30:49 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 17:30:49 +0000
Message-ID: <d2f1ac35-d834-40f1-a4e8-dfe74663faad@oracle.com>
Date: Wed, 29 May 2024 13:30:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 08/26] migration: vmstate_info_void_ptr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-9-git-send-email-steven.sistare@oracle.com>
 <ZlTRgsNatkvsLKpL@x1n> <f0d4b6af-a3eb-451d-b131-62addb72f3ef@oracle.com>
 <ZlYgo0UupFdQJ95L@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlYgo0UupFdQJ95L@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: ff72a122-8efa-4a09-4871-08dc80051520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RldTRUhJSjdBVjNkaUlkZGhtM1EzRWlGcFZDc3E5VUc1M1BEMHRXd3N1Njh1?=
 =?utf-8?B?NjdhZEJ5dFA3TDEzdktDVTlTWUxjUnhaUktPZmMrakpmQlROYSthSTk0VzBM?=
 =?utf-8?B?OUQ2b001UWNzTUN1eUVSQ2orR28zajJUWFFpNUFKa21VYUtSNkhZc2lsUUpm?=
 =?utf-8?B?OUNQVHg0RHZRTmlZbUx0KzVrWUw3RTVnb3YxUGpBaEJ6WmgzSzdZYmdrc2Qw?=
 =?utf-8?B?WWZkbmU2cmFmenpLUWdqV1ZQS0lYVUt2bWFpWndNdHdjMm4yQnh4QnN6TnJ2?=
 =?utf-8?B?WHJqbjlRa2MzMGFQd0pmdTVPQ1VnY2dUVExWMG5tc25MNld1ZC8vbmFhSzlX?=
 =?utf-8?B?OFdUem94ZktzL21tNk5CUytOYzRtditpT0RiUWVWVG1OK0QxVlVKNy9iWEVl?=
 =?utf-8?B?MFljQ1NWSjRUblV2ZVNCN0o5cUZqZ1ZhQVBqQXFpSVVjS1pzeURPbjh6eXps?=
 =?utf-8?B?c2xGbmFvQ0tWejZ3KysyQ0VtVGFMZFJCS0F0WkRqVUVYR3Z4Y2g2b2NiME84?=
 =?utf-8?B?UGtuMTRPcUVleDJqenBneFlkc05WUEZkOTJJb1BBRU1qN3B2aWJqZmpueUov?=
 =?utf-8?B?UWNLS1dwcFQyQUdHNG8rTS94WjJ5UmNqbUdZOXllYVpMQTBYeTVuZXNRcjJi?=
 =?utf-8?B?c3pWTjhNbE9qNGwya1VDQmZYaXMvdjBUblhXKzluT2RZa0RRRGgxLytLK0pm?=
 =?utf-8?B?WVg2MTZXNmtObjEydlJISFRnclV5VlhpQi9TWEl5UWREazB1dHNCUUlpaTJq?=
 =?utf-8?B?NjN6bnc0NWZGWjhhZ1V1OFJNWHUzMzVqeDZQQ0t6RkpNNEZlQW9mZnB6cmYv?=
 =?utf-8?B?ZzR6bmdjMnEyTXJ3RHlCY0ZjcUlJVnI5MWI0cjM5d2VFcWV1aURBZHR2eHZn?=
 =?utf-8?B?SHBlem5sNDIwRzRFUldSZzdtcHlMMklMUkpOc2w3N2RHMWVPWUZqNHV3TlVh?=
 =?utf-8?B?WnlYaVd3V0IzcWVhMjBMSVZvcHZCS2czNnQwdG9TMjcvYVlPVDEzMTR4bGRi?=
 =?utf-8?B?VEo1SFR1UmxoSFB0bXVKMnVSVXUvTUpRa2RXVkJIVnhnVVR6VjFMOXEvSXFF?=
 =?utf-8?B?S1RWY2dnejR3WnBCbksrODk1L3VsbElnVFdLdGpQUisxdUk0bE4wb3FIdUhp?=
 =?utf-8?B?MXRYc3FsbWdndlZ3cEFkaUM2bjZHTkxDWldMMG00aEQyNXBLbGxrQ3RNZENV?=
 =?utf-8?B?ZmJsWFlPMnRSOTdJenh4blNYRCt6aTNIdG5WbkRibEZuVVYwZHRkbDNZbU1F?=
 =?utf-8?B?Sy9WRG1FMjdlYUdGeXZKWmJDbE9EWjhBMnphdTVJZ1BORFd1YnU4R29oRmhj?=
 =?utf-8?B?a3VCT2J6NkFRZklEUFRFcy9PcS9JLzBremZyZEJzT2xHclNhZUlZcm1zbmZC?=
 =?utf-8?B?QkJQazRPU29QSm10c3owSHEydlNlbzgxY1ViWXpOcTRlRmRvYVAyeHh3bUtL?=
 =?utf-8?B?YXdkU3RHZmZpR1FTTVZwRDBUZUxOVTZ3QlZxdXhjZHVUdng5eWZCRW9JcDcz?=
 =?utf-8?B?QXllWXdRL2h2Z0xkbFFTMnN1VDdDYytFaVhoV3lidWtOVU8zdFdMVnNBQXpm?=
 =?utf-8?B?Sm9aSlc5MEtpa1UwSnc0cS9POTRoQnpmU1VQem8zQ2c2MHMxZXV6bzhpS204?=
 =?utf-8?B?RlpCVEU2VmU4VTFqZEFhTm9kaCtoQUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUhVdk9RTjl4MlJWZnE0cWtSdEQ3MEY0UndxSlR6MXdDOVY0dWVhNk4wL0x4?=
 =?utf-8?B?RkRRQ1FBOXhadlRpN0kxUFRMcTVoQWVVeUZ6VC9mMEhiYlhMclluRUFvS3ZO?=
 =?utf-8?B?R1kzVjl1eTA4bzNFd1NReHRYTENsZjNXOTYveGRLY3ZQTXNPV3BHdHl3djd5?=
 =?utf-8?B?K1JtT2lpMVJxdE9QNWFka0NkZlhMSllVRUFSVGxGWXY2SHhYMW1zOTRsZHNu?=
 =?utf-8?B?RUc4d1RYRlMvbEFLWWU2OGljak1LcUdIZ2hwWk1HaVlRMmhuVGdaZmxQVGlI?=
 =?utf-8?B?dG9UMng0MDdoM2xLN0ZsSUR4RkdOYzN1M0VHQ3Nsb0FGNmUxWmNzWkEza1JY?=
 =?utf-8?B?ckZQNU9HNXNnK05XWGkxdzh0UEZkVFdiNjFTWlZDbWlMTkxXTG5UMUNaYlJj?=
 =?utf-8?B?WnczaDVaaGJSRlFoU2VLdXIrRVZlam1XT21CeXNzYUg2ZytReTh6K083NFIz?=
 =?utf-8?B?V1JqTDdIMkJrNnNCdHc5RjBiTjVyOG9WWlN6L1VFMld0bmM0Z0xRdFF6RWF3?=
 =?utf-8?B?RVB0OEUvTytXUWZXNUh1M3g5T1JYaXlJcmpEZ3FpL3BCNFJVd0dXUUdTenVT?=
 =?utf-8?B?OUhpbHFmNmc1OXdrZmlubGRYQVRSL1Y1TlJCelBRdTlHajVSbXpzM1dHMHlz?=
 =?utf-8?B?YUsrUnA2QXdPaTJHU0tIZ2NSM1hlaHZLaW95Tms3ckxmV0RnYVN1VEsveVBO?=
 =?utf-8?B?MDlaMFdIaERVU2V4STMybTF2N244M09ZRUtDd3RDczljdFNVR2NRcHMyRDRN?=
 =?utf-8?B?NStRMUlOMkgwbXcrd1E3ZzNKQTdHOWdlVXcwSlZ5VTVDL0p0NFh5RTBlTmti?=
 =?utf-8?B?Y0MySDlFc1FVZTdRYXhNTXhyRWlaL2x6cStLR2l5SnJhSjAxVCs3N205ZGwz?=
 =?utf-8?B?VDhBVWZkZFlMb0Jrd2llT1lMZVpiZVhHYWxmVWFMVk5JTkx4eVRaWTNpUTBB?=
 =?utf-8?B?OVFIYnVNUlZ4b2daeno5VlZ5b1VydVFLU1VxWG9GM2RuVVZOOVpxZW44OGRn?=
 =?utf-8?B?SWlWZDFCRnhRb3hXVWdGby9kYnRGTzNzMTJ6ZjJOd1pnTTZ5U0t1R1FxMHgx?=
 =?utf-8?B?R25wMmhoT3VYaFByM0VSYlJQRTBNZ1gzZkNGU3IvMUhvcnBQaG5ZUEJESDZy?=
 =?utf-8?B?RnNQR2N5ZENCeWVXWjNyMXpVUzZUNHphSXFweklqUkZqbGc3cFRSM0FGYWEv?=
 =?utf-8?B?Rm02OFhheUl2TXJaRjlTdE1mQU03cUdUUURkWjlaQzdCS1dGakFUY1VxWjNt?=
 =?utf-8?B?RXliY09mVHpadzJkMVRzZ1U2SzMwRENtNWdBeTI4b2Jwd2ZjR3dlNjdwSmVJ?=
 =?utf-8?B?L3g4a1gzd3lJdE8vZXJtN2YyVkI4dkpyVHE0YkU1UjZ2d09IcW5GeGgvNy9I?=
 =?utf-8?B?eGxjd1g3UEdaRERzMVFPUllqQ3JES20yZFlTTXNVYkMrdjFoMTl1bHM4SmFK?=
 =?utf-8?B?a3I3T1orK0gvU2JNVVpYTmcvWE9VT0tucDlrYWsxTVRsMjZtWm9raGVNWU5L?=
 =?utf-8?B?aDdXT29xQTF4enZSQUFhcnpiZm9xbTJSVFZEOHpQdjBwdTZJN1BjUVgybnhn?=
 =?utf-8?B?cjZRMFEzMzVxSFdvZGVrMHE1ZGdOWHA4THlGTnphU0NLMTYxSkMyWFV1ZlV0?=
 =?utf-8?B?TDM0d3NvZGs3cDdPZTdpSVhNVGpDKzVZWnZtKzU5SnJyWTZnbndPallCZ2xQ?=
 =?utf-8?B?VkQ4KzMzTlRoY2hGbDlZV3JodmxacGsxTkVrRUlhekJQeXhvdGYxa0RoOG10?=
 =?utf-8?B?NERtdnovMGN1NERCcWR4c1RIWnVjRmlMOXFHZEpnYlArR0tFcnFKYmJZUkFR?=
 =?utf-8?B?THFBWTErbnFRUGNrRGNLWWtrM1NCa0ZoZkN4ZGhncUVwaTFJdlVoZVZEQVlB?=
 =?utf-8?B?NVVQcm9CcGlGeVpSSE0rWTNqelpxcEJyTzQwYmJuYjYyK0t5T3RERzNEKzI2?=
 =?utf-8?B?YXpBcW56R20rcE5oVVN2VG5XeVdpeWxmSFB3OCtzM1hPM01YRm5URnVIWEZB?=
 =?utf-8?B?d1M4QzVKRUVqR0NMeG1mYVpPZk5MUmVxZmU4bFJ2ZjkyRFF3ME5hT3ZOKy9N?=
 =?utf-8?B?Q1FxSTZMeW1tcDRSZ3JNMDBFb3BkTFRZWmk3NDRlMTFIb1pQODBwbTVXTDNI?=
 =?utf-8?B?R2FzU2JDcDY2WWhFOGxpY3JMWXUzTi90WUhuYkVjWnFOTDFSZHR1eVZYOFlJ?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dKJmtTCnwo4uG11x8z8G/gvFgIUk9+BjbzlXgTfFrwD7nlP/g8ESKo90HQ26IEvKoxaN83fW7dHjLSKtAWAQhy6ubzaHv47MD40ICqvzTmbYRMkXrJ8dwlTudb5Q2zvZzs/+81au3ew78YmvCvCq46Ctqb2sGmx955MqanYonyOAa8Mas/TZelAl1CCIfj1RDYlZ1CCwUyZcYufzfvrCpJoGh9Lv1aKOLY+P9Veg88H9PW/03OSklfB0iH9YT/X7vxLdbB1i4r5GgiliSTq4RcOEBedH8BiCFCcbB5jaZ+BCRqktbCWHSpdiGj8iP/0kRIqR7cK2zK0n8ODnFTNAjd8QSA0stIuhGChM3dCPwhbYIV632TLCbh0o/8uQ5WEX6S6vFOlMWeT9G/USyItJhmk27SPbRa/LA2ljg9+FMQ5gjSn3x7HSQH2T8D0xxn13mQ0Kr3PHQtoXpgv1djPkh0y5/C5uB6YqAoCBNe0ayvmvvmQtxD9DMgRt4ZkemYDUDUo/ciATkIKlo3frahB2GDFJPC74jZYHCBROx2ItYM2+TAwlkPQ8vJ2OmISk9nVN9zIDiD10UjqvQdy7YQdXdtVU8Ll2iIegQHPVL56/LK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff72a122-8efa-4a09-4871-08dc80051520
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:30:49.8336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JIGCBhlQ8y2UAXp19wAFRE7Jk2KCOviFgCbH4tGxkA8bc6btxsPaxd07BzAxsrQ4coSjP0YmDUvh8H+sP6LjGjGd/RivC+PCxV9Ggm8nvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290122
X-Proofpoint-GUID: 44Uaph1g4Qw7KH59plG0k5XY-O1O3ji5
X-Proofpoint-ORIG-GUID: 44Uaph1g4Qw7KH59plG0k5XY-O1O3ji5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/28/2024 2:21 PM, Peter Xu wrote:
> On Tue, May 28, 2024 at 11:10:16AM -0400, Steven Sistare wrote:
>> On 5/27/2024 2:31 PM, Peter Xu wrote:
>>> On Mon, Apr 29, 2024 at 08:55:17AM -0700, Steve Sistare wrote:
>>>> Define VMSTATE_VOID_PTR so the value of a pointer (but not its target)
>>>> can be saved in the migration stream.  This will be needed for CPR.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> This is really tricky.
>>>
>>>   From a first glance, I don't think migrating a VA is valid at all for
>>> migration even if with exec.. and looks insane to me for a cross-process
>>> migration, which seems to be allowed to use as a generic VMSD helper.. as
>>> VA is the address space barrier for different processes and I think it
>>> normally even apply to generic execve(), and we're trying to jailbreak for
>>> some reason..
>>>
>>> It definitely won't work for any generic migration as sizeof(void*) can be
>>> different afaict between hosts, e.g. 32bit -> 64bit migrations.
>>>
>>> Some description would be really helpful in this commit message,
>>> e.g. explain the users and why.  Do we need to poison that for generic VMSD
>>> use (perhaps with prefixed underscores)?  I think I'll need to read on the
>>> rest to tell..
>>
>> Short answer: we never dereference the void* in the new process.  And must not.
>>
>> Longer answer:
>>
>> During CPR for vfio, each mapped DMA region is re-registered in the new
>> process using the new VA.  The ioctl to re-register identifies the mapping
>> by IOVA and length.
>>
>> The same requirement holds for CPR of iommufd devices.  However, in the
>> iommufd framework, IOVA does not uniquely identify a dma mapping, and we
>> need to use the old VA as the unique identifier.  The new process
>> re-registers each mapping, passing the old VA and new VA to the kernel.
>> The old VA is never dereferenced in the new process, we just need its value.
>>
>> I suspected that the void* which must not be dereferenced might make people
>> uncomfortable.  I have an older version of my code which adds a uint64_t
>> field to RAMBlock for recording and migrating the old VA.  The saving and
>> loading code is slightly less elegant, but no big deal.  Would you prefer
>> that?
> 
> I see, thanks for explaining.  Yes that sounds better to me.  Re the
> ugliness: is that about a pre_save() plus one extra uint64_t field?  In
> that case it looks better comparing to migrating "void*".

Yes.  Will do.

> I'm trying to read some context on the vaddr remap thing from you, and I
> found this:
> 
> https://lore.kernel.org/all/Y90bvBnrvRAcEQ%2F%2F@nvidia.com/
> 
> So it will work with iommufd now?  Meanwhile, what's the status for mdev?
> Looks like it isn't supported yet for both.

I am currently working on the kernel and qemu code to support iommufd.
It is an RFE on top of this initial cpr-exec work that I will post separately
later.  I do know that it will require the old VA, so I am proposing to
preserve old VA now in the migration stream to avoid adding extra backwards
compatibility code later.

I have prototyped userland code that supports mdev, based on jason's suggestion to
fork an extra process to handle mdev translations during the transition from old
to new qemu, but it is a work in progres and adds complexity, and I do not plan to
submit that any time soon.  Another RFE.  For now mdev is not supported.

- Steve


