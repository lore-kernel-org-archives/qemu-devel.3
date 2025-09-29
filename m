Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22243CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EM6-000233-Bo; Mon, 29 Sep 2025 09:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3ELu-000201-S1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:55:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3ELU-0007d9-2J
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:55:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TDOPCW026110;
 Mon, 29 Sep 2025 13:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cHf9KDk1Fno5U+YCc6dCFFHsCA13pGQedkVdSCURS68=; b=
 FXCjv/2x0Vqh4kaLew641diEme8Cy40LEjOgLVo28s1PVKs4Jkx1pivTt19tReN6
 0ZQfYiCMUohDlkf0x5cHN3n00/M2X2NWIn6fS5dNXdBFfSDGi31KvEttpvopCjs/
 /MGgOXsVQvU+CPVAQkqxNNfbUgEmRvkSnAVYIEpYFVkD3Hgi64jLXmWD1MKzD0mk
 ha2BC/Dy7Rq/mjFxWWTcSUn0U4O+upB5+8UreOjPTA8QL0FAdBNYNfSMt0/XAnmJ
 G57hQJSo3Ua91Apay/GNtc2cMQKgsf9O6GSmIRrQrWxxJoOIot+pVff9YZ9p2g7H
 uiuvdFxGn6rjkE5puVgRzA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ftye82hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 13:55:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58TD0FVD002102; Mon, 29 Sep 2025 13:55:00 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6cd0bta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 13:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX+bIBqhMSdulydo1AcoaAXZ/0L93clTrixxxmE+TghmChyqwC3JejOrpk7OpeJrFTYdKYH+kBS6AIRIEPBDvKnIpp8dTnWyWNrSKhDCMJUe1bOFUg38C3AOsjk/LvKGUyajWVqtRsvLk1oxK4fL9nTi8A2LLzy5ruCd4KoRiqIRSh9IIVfbWGd7ohMo47RCUhYb3zZIK5p8KNoyyxDzTXF/etTAAqVz/GvqXLxNXjwjGoDYNwksJiXDfI9L3dqWR8WsG/nned+03bptUPd8eseqVEiZiREzBG1i0TAHEQbxrWfTV2/TRYcmn+zpOpxmz+IlveO/0BbaKCCliG99qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHf9KDk1Fno5U+YCc6dCFFHsCA13pGQedkVdSCURS68=;
 b=bdlGTQNFjQbQ7ziBo1usQoEAik7QwPc6tC/gaGD3NE7dtVFQwAmCMWqp3j+nFdIa97NqpQxsClZWzFxRbvEYq9uBqBy/PRs9jCRaF0bVDtylRa2kvY07SwOWIErqLomYV36OV4gYiHp8HNaae4ScCQ1B+PtYzCpIk9O786gt7ThTa6tlLZ/6SPeURPkcFe3jjgCWnWng/pyOtovBfAj2yVDMhwCcTimGiAnoPreM5rT1ytqYGRjqevwyc2u1eczT09Q/bovQa4TAXQvdjw7Kxlyf097l16zByJn9nvW80G5dVLhzqlbrirkHvYhKp0bIIch9+TS0LD/fl2Q9v9YVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHf9KDk1Fno5U+YCc6dCFFHsCA13pGQedkVdSCURS68=;
 b=pbfuoOQhVS8mOmnmevsVf9JGKzVa39lt83mpDnMGDaeX1zpnQ8x5zA8l31jPA6JWLsE6SfF1bG18fjMu1ukU+i9gcGE3DLIjSwkL/6ZJLOB9PZyFHFCF+cN5XELWrte4M5bHhqaCdzEezhazJzflUXKbKlCOiT1WxgaauBOR5Fc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 29 Sep
 2025 13:54:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:54:55 +0000
Message-ID: <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
Date: Mon, 29 Sep 2025 09:54:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250928085432.40107-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f1a997-5c57-46f2-ed31-08ddff5fc551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2dtVkxqTVhRR0lsOXBLSFhyaDVFNjdaclhHMXVLSU5MVC9rTlFyeWp6L1FD?=
 =?utf-8?B?U3dmZGJyWlErb2ovcGl2aFBFVmVSdVkxVEdSeHpPeWwwZlRLZjg2Mjd6b0NK?=
 =?utf-8?B?ZGFlTUx6VGxXaFJiUm9UazNpcU8xL1UzRXZLUmdwcm9RZ2tBYXU1YnVZRnRQ?=
 =?utf-8?B?UVJ4c3d0ek4rcjQybDI4QVZuVWswdnVHc29RS1oxN3JMdHJYMzFXWDhOSXVn?=
 =?utf-8?B?a1lJdk95cm9aQldRQW5tWXMzSDRwWmIwNTJlQm9XWGl5a1I4RmJJWk5QL3dk?=
 =?utf-8?B?MVRFRFYrTktwNWpaeGxiVEtlRCt4TWdnMlcvbkFlUUJRMEMrZnNSV2FzdWpn?=
 =?utf-8?B?aUwreDVsdW95d0NHd0Q1eGRld3NFamFYZlg2NnhFc2VsSGpwQWVwbDZLYWEw?=
 =?utf-8?B?elVJMWVZSmhxcmd3UU5kUHlJc0o0L2J1blpweVpxVmpucHpIaWFraGp4QklN?=
 =?utf-8?B?WHEwQWJBWWpkaG5ZamNVa3Bpc3hpaG9XbnRGR0dCQXBxd1F1T0lSRHFnVzB0?=
 =?utf-8?B?NEtXSUtvbnM5YS9JK1pkeEQvSGZJenpYL2JlTU0vRjNQKzB1S0lrb1dMOUwr?=
 =?utf-8?B?MmFBUVJ5OVkyL2hPQUZ6L1JNYVhIc2wrS3FVMXFQSnFtbm9rZkg4VUNpb1BD?=
 =?utf-8?B?V09HbGpnK1VCdzBSSlEwVVNZbXkwWHZtZ040OUl6d056WnVYVWd5c1pmcTgr?=
 =?utf-8?B?b0JDd05McnlkL3dMcUlRTEpZbTFCaEhwOGVJUDNOZmhpb2tYUGkyR24xL25n?=
 =?utf-8?B?YkFiNkFUVWU4cFJuWGdFZkQxNWpwSW8wVTFZTnZwU0NCbldCalc5dlBYMzY4?=
 =?utf-8?B?TU1Ec0daWUs5UCtRbTYvRnRDSlhRYk9LNVF4S2d2SjltTmFvcTk1em54NnhE?=
 =?utf-8?B?aks2bldLTTBIdTMrSU9MY0RpUmxBc3l4aU1CYmwvYk9CM3U2RWloeElmU2hU?=
 =?utf-8?B?ZnRxeE9ZUks3ZTVLWnBFdVFKSGlyS0VPenoxTG1MM1JwbzhqT2V3K3F2eC9l?=
 =?utf-8?B?ZlBaVU93RkFTZGFVbHhmMW96RWlvd0lveU4xSS9KWlRaUUcvS0pwV0JkM1lF?=
 =?utf-8?B?dVN3RHovTmtucWV6ZHUxeFk4eWQzWW1uKzJBcjNZaEFnNnhUbzZFNVZydFVo?=
 =?utf-8?B?elBwMWI3TGErR1dLR0Y5aVJabStDckxNcVZFanBjdFRtck03WCtIaG1yYVZt?=
 =?utf-8?B?RXJRbzVSNDc1eUthaDNSTnd0WWJHRDdXTlI4ajNBLytSUWV4NTJzT2lKY2Nu?=
 =?utf-8?B?Q0RoL0p4S0RndFd1b2F5UGxTZTVCd0lVN1FROGpUNXJ1N3lFUDN2S1FtbXB5?=
 =?utf-8?B?L2M1ZkdENjB2TTFhQmczN3VXWmdBcEdNWTJLU2FsZk11UGJFSGRPQVE5eDM2?=
 =?utf-8?B?cFVKUk5acmdOZjYvK1FoTHFGRnRkbjNXMnJQSVhvTzNwQ0xNeEswQ3QvU0RN?=
 =?utf-8?B?S3JGb01JN2RXQkFXWkR4ZkphNjVoZ0h1MjA3dWNKNTh2dERoV1BzaGppVE1j?=
 =?utf-8?B?M3ZjSlVZWGg2QWJKR1NyNmYrcDBLZ0Y0OVE2T3hBUy9nT3htM2ZBOUhxYTZT?=
 =?utf-8?B?MnYxUUxjUnY5a3Buc2VTRHJFOXd1dmxvTUZTVEtvS3dTUjM2c2hJcWVxUHR0?=
 =?utf-8?B?V1FPRXlwcGYvNkNMZkFTL0g2enJNeXlQeENRYVRnemc3d1NKN1BkMFRLTXdG?=
 =?utf-8?B?UXhVK3hXMUhLQzVhRWdOZDJENjV0VktsSE8yWXhqTWpKRFZTQkh3Vm9KQS9S?=
 =?utf-8?B?clBwV0VnV0JCU3RzT3U5LzNSdGY5dmNUN3hyYnFHbzR0ZGFTV1E5TnB6WWtn?=
 =?utf-8?B?ejRQM1QvbElUZlFpdHJ6S1pUZ0FHNmlSSloxdU9sbXk0ZzExWmxwZnpzYmVz?=
 =?utf-8?B?cnNiWjRDaFNxMVE2VzB6MU1GTFdwU3RYM0d3QjRYK2RlVjdQWHJ1YS81dmZ5?=
 =?utf-8?Q?MryJ0gHeNbP8lxQKSXa8TBNN9PL4/70N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBReHdhWjlaZGY1SitNZGVqUHZBR1pTWnlwZ3NSbWVzMGxJZGFaam45RlF1?=
 =?utf-8?B?bTh6UFViemtmbFNQSDJBY2NOdmw3d2hEU3ZES0FjdmJxb1V2WVdJc0ZNa2p5?=
 =?utf-8?B?amJOdHIyY3N0MzYwRW5EekFtbTVIVS9TQVQ2ZWtrTmJTN2diZlFncUZ5VnZV?=
 =?utf-8?B?Uyt5c2FjM0pvNjg3RzhKd1FqS2kwWURiNWU5cjEzL214aXR1dW9iYnNoYzRG?=
 =?utf-8?B?YmQyQnB5eGZ6TGt5RmRHZCtBRFVkYkxzV1oyREtva1hWWVRvdUM1UndKa0d0?=
 =?utf-8?B?NWFZZTVxVXBMTE5BMVA0YmMwSTdDQlh0clUzTUtUbnh2eTZIL1FGSFBIZWw4?=
 =?utf-8?B?dWNLblNzZ3hBTnd6Nm5XQS9QQndaaCtuckNpUFN5MnBhcUJESnRtbmJJR21w?=
 =?utf-8?B?SEtWZVV0UWRHVksrc1drQ0Y0VFlpOTFXRXlqVmdjNWtFUWhFN0JQUU9BQ3BZ?=
 =?utf-8?B?QW01Q3gyTzJmL2ZvcFNsZURvNVNsVzEwalVvcXNQU2tYRTRZM0pXMmw4SHVq?=
 =?utf-8?B?d0t1dCtGSFEzT2JrUDJLSEpuSVhraDBIQTZ6NmNOWjAyaWUwWGhqNmtZOVZI?=
 =?utf-8?B?czhadkJoUzRRNzJuMWhjY3BhN1hUN24zU3REazA4WGJKb083K2FRRFdsdDVX?=
 =?utf-8?B?TzRhRWwyblF5Z1NhYTZhM1MzMlFwdkcyZUlQTlJpSlp2TlBET1h1YTFRZGxP?=
 =?utf-8?B?ZzduN1ovN3Zwb1VpVE8vMWxVNU9MdDBRUFZDM3V2cDY4YlI5NHF1bXAyU1Ey?=
 =?utf-8?B?Q1RLaFB2V05FTW1MNW1mRk9FVmN4RXpoNk1lbk0xWmVqSXpyS3NKRkZIalE4?=
 =?utf-8?B?a09WVFRuU3JNZmxUb0xpVk53K01qUmd1anNpcS9IU3pJMis0ZW9CamVoeThy?=
 =?utf-8?B?bXhpQXJKcFROcDJ0VmJmQ0xndHJoejBFOWtRVkVzbnE0T0crSGtGS0NGN1pB?=
 =?utf-8?B?SEVMUXRqOGFHdDNmdVhhY1dBRCtaNXU3LzNmem1yMmlIQTYwblRwK2U4aWgx?=
 =?utf-8?B?QnhIeWdrUzZ1UWppQmM5SDlvdDdlYTFyN2NoYkkyQk9kRlJ4UGQ3cSswc0V5?=
 =?utf-8?B?QUJ2dndyLzhSenRVdGcwTFdhMHgrSi9Va3V6LzhDSUJCZXozWGIyeGU0WlRZ?=
 =?utf-8?B?eXhzajhvY2wyVmNLNEY4UERRdE9tcGxTNzVYeUE0NG14MjVhVHpzUTgzaUd2?=
 =?utf-8?B?bENya2Ztb0dIYldLRkFuaS9WRUU0bXAxdHhPY1N2bENkalFCc3BqWG0xS1kz?=
 =?utf-8?B?YjB6TGhPSWxaNGl6ZmhyQ1p4YkZLSUJ4bkdKOEErTCswRGpxQitGNWc5SS8v?=
 =?utf-8?B?RElqMUZLZjFmK291UXNNSXVCQVRHRSs0c1RhbFUrTmZkT1UrdG9rSXVDRmFS?=
 =?utf-8?B?MEtKK3BVZU1oa2RnOUg4MkFoZUtuYld4QVRYMTJhMi9ldVpuVVVSS3RtRHl6?=
 =?utf-8?B?TkFOQ2IySG1tazB3NE1qTVB2UldMZTA1TVlNUmgxbEVTeUJQbmEvOG5teGhj?=
 =?utf-8?B?L0tTVlRsTFF4dktvaGlNakt6R0dZcEwyZi9zUkhENHVQMG5kLzIwcUtXT1Vp?=
 =?utf-8?B?aXJJVVpUNXBUNTVhZWRRTVk0TDRaNTlNWTlKVC9GNkI1VVB4Z0ZKV1MyZ1pG?=
 =?utf-8?B?YTlaWDFHazBsQ2VtblZ0aXdpc3kwSVNUSWlLbTkrMnNZZk12NEdQRW5DR1l4?=
 =?utf-8?B?TzRkUDhUeFJjK0NFS3ZwKzh0Qnc0bkFTYTB0K1cvMzFZeUkzVVR6L1dLeE5N?=
 =?utf-8?B?ZUpRK0RYK25HTUlMNmFnRERvTjExTkhPWmtIN0xVMmRzWFIvdEF3cW5rWVpV?=
 =?utf-8?B?TjhQRGh2V0RuMjkvbFNKRVNnUDIzU2VrNDQvQ1VFUDM5c2ZUTGhFblZJeHVL?=
 =?utf-8?B?Zkc3YXFyV0hCa2tlQjdKdUEybUJ2VDNoUklZbWIwbEtwQ0tWT1Z3OGN4bTJG?=
 =?utf-8?B?RkRKd0tQZ05nZ2RCK1hwdG5aOG5pS09veVZ1RUhaZ2d1R2oyWDViRHhESTVI?=
 =?utf-8?B?VVcvSVpIUFJ1LzJuaDV0RWYvZERRMUxWb05nRGNkazlkM0UrTU0vU2J1NGZD?=
 =?utf-8?B?K3N5RmMzYzRiVUdwY045U2NOeDRjMGxNaE5ZdWJLMms5aU54WTZGOHppRVdF?=
 =?utf-8?B?U0lWZmdVdklCcDhibEdFbXkzZ1pic2VMdjh5cEpuUHZoVFpMekJXa2EyY2pr?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OU6i+fPi9Oxdjc9udL3LCZADVvgnAXEb0dKNrCEVQCGBLGyjsP0Ju/382uURTWQuiRoVjlgEyXOQmehbtUS06dJaG4svRem/p6hg3dVHZaAfB8qJszr4qJtndMFKWhek8ChLb9Xf+lpHRIBN5MXHOgBs5G84YvrWkKPzsQ6rRmCh3AMNjiXimP5tG28efZQp7lq09dAEMSiAWsF1uEB4ZCXAWLznF6PIhzNO89by1cpZAF65CV2iECTo2qkKr/1sjYtYX4Yes21HgNdhoE0IOfu1M8vmcSYGnuSuj+LMaKp75sjzEsdKRUDKjFR5WL8SYZ42D1uxUM2QKnjh3hArKW0ZREgOtH4dFbBhakILIznpnXvk1Tr/GNVCWIMK9LFSATXEXFlVFyyOwz2YzmKN91nZPF+bbxkFbWVCGAAB7anvYgyfQU5QxK5O6ohUK7eh4Yk5hTXarcg/ZY6eKQmEX0Mpwl13KDIDL/hdrmRPeAJGSBg5GRldy1ZAD1MEXPEsaEhI6vp9ffKALcm8OQydTeW7RsIONQ+CnPLF+Puf5vz+5tW1vQcCX3MHytnXXtLbF5MbEjN7REArHTRDRETCiRJf6OSAaa/2COk5TvBo92U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f1a997-5c57-46f2-ed31-08ddff5fc551
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:54:55.6144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHL8p28qBXc/SSLovJi5xMCE9tI7vtgDCfu2ObysKWmY9SUd5gLBwEcgvJKpJ+E79WjN7f+dXMBZyubb7CY57fZz1bm8siqHHQaSCMWZbQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290130
X-Proofpoint-GUID: OvNyYOsKPH_3qgQ5FeBodaCELwfQFHxT
X-Proofpoint-ORIG-GUID: OvNyYOsKPH_3qgQ5FeBodaCELwfQFHxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyOCBTYWx0ZWRfX3rRZRqtvzYTk
 FK3qYCiKD4MCkapRd+kCs71KSVfCXGLp4UY1H+LKxHJwS9yIHi0RiskIne9ix73hFE1ojNv4gYR
 g+gOsWyNPEpbAUJu+bZJh9/l/Qwe428/zyny/kLqwR6Tw0PNC56FpNdeVzY4ckWeRSCmRGZDPdM
 zjidLfFwwP4/WhC5NPZnS3caOqLfXGxJGIRP6AGccaqXppdfB1cgNbn3rkKUB9DgKHEc1nD4/Pb
 +Ra6LTW5Gp9rmu7rGvu3WgMUrSBf6hH8my8xzTIEZP1X/Q9NXCY+w4jz3g5xi66ZEp+3SE8kcbZ
 yhilirIG5gnwZeVoMzA+Fb47SJiruIAG4EKniZP6cFf7OJEebmByB9wMTPktXhMgwDXjYJSwkwW
 9jKTjO5WIML5KWi2pm/r1MzFR1Xo7IW4xtUFKwer8aUcoZsXYRw=
X-Authority-Analysis: v=2.4 cv=BYbVE7t2 c=1 sm=1 tr=0 ts=68da8fb5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=tIAIElnxm74-U9QCJHoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
> After CPR transfer, source QEMU closes kvm fd and sets kvm_state to NULL,
> "query-balloon" will check kvm_state->sync_mmu and trigger NULL pointer
> reference.
> 
> We don't need to NULL kvm_state as all states in kvm_state aren't released
> actually. Just closing kvm fd is enough so we could still query states
> through "query_*" qmp command.

IMO this does not make sense.  Much of the state in kvm_state was derived
from ioctl's on the descriptors, and closing them invalidates it.  Asking
historical questions about what used to be makes no sense.

Clearing kvm_state and setting kvm_allowed=false would be a safer fix.

- Steve

> Opportunistically drop an unnecessary check in kvm_close().
> 
> Fixes: 7ed0919119b0 ("migration: close kvm after cpr")
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   accel/kvm/kvm-all.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 23fd491441..b4c717290d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -639,13 +639,10 @@ void kvm_close(void)
>           cpu->kvm_vcpu_stats_fd = -1;
>       }
>   
> -    if (kvm_state && kvm_state->fd != -1) {
> -        close(kvm_state->vmfd);
> -        kvm_state->vmfd = -1;
> -        close(kvm_state->fd);
> -        kvm_state->fd = -1;
> -    }
> -    kvm_state = NULL;
> +    close(kvm_state->vmfd);
> +    kvm_state->vmfd = -1;
> +    close(kvm_state->fd);
> +    kvm_state->fd = -1;
>   }
>   
>   /*


