Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9626CF9C64
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 20:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srkQE-00074F-RN; Fri, 20 Sep 2024 16:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkQC-00072S-Me
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:40:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkQB-0005wF-0b
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:40:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KItWV3031092;
 Fri, 20 Sep 2024 20:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=0VobiImQNpmP+3KpkKtEzqFk+/Z7/JXJsBv5GyBqXew=; b=
 k3OATtuoXdh19Yp6zenkvaK/SJnJ3/cT+5cYhzJILhxP2GudL99q4/9QaACAEzMd
 D6QQcHlbJwkj6Dm0s+VjDv/pgg1cxoc5e3cd4XMFuhh905z3yOoq8TCpcYQkRfcz
 LROL2UsIRrI5+rZ/1JlU6yg40+N77xr5/4EAht6CU7pVrZx12WD0aaehKVHLjx4P
 VGNEXZx4nAQfzBUP41Jn9jHxNDeIaVIrxqqYFpARG2AV/V36NZ509UDKeYpq1ATf
 5CMYtg3B6EMudeQ+EQmuGisNU1gePBGTkK/2exIRaIVJHHEB/adiyjSYMofNyQFh
 3KUooOWmBxHSyrOJxiUMxw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rk7hbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:40:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48KJvCTf000341; Fri, 20 Sep 2024 20:40:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41nye0wa4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB0F/YrMfhCgtJyCTwwZ0t6A4OjDVDBKKKf098t75QEModF3l7I2s6oNjKPi2EciC47nzqJa0N9l84ySCiYXhsUgCrGlrVynkOXgKBbXR2pf7o+J4fKQl7y7G8T4g104JJLW1IpPvr+KPiWEUmx+TScFwaZXLqxgcu/icvkUnLaqnH4kOcbLGwYCZ+1fuE+Ic6KDBaeszKzFda7N24CgJhISK1SGkT6jkozeg1+JJYalyU/hIORbKjBJX2gD4yEKq5maZYFsrKkoXw9Ev18T+1m4PkaLsUw2Qu0eclWgB2hiVntEka2qj4utvZ5BF3WNToKX9foxB6k1K4+n2TPZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VobiImQNpmP+3KpkKtEzqFk+/Z7/JXJsBv5GyBqXew=;
 b=tFiynsBCOR7jLVuj1g5gdAV+sL1ORy6CXSJN7rmNaHyGdlAfQZ0euHY2KfmeeE7TJG6KSM9cbjszdrR4m0cg8RmUVEaVmrQqS4fRckheOfE4WC0gaMOnPxV00ZTVAFr7WXJSLqc6zLFaY4/kDkrwh8nsJ5RO41cRKEyWTqQGowg+DEzWbJzhWq1eJ0i74wANn+5yRCB0WeNintjAI/8RxuG+lHcnmD6cIJHrYWDVGkG2oLkz/zF1828NdAgK5pGz+jXRscyLuWvJBfDsjGWsmHiW7qQyvD9qYymZ71pJo0kstNvRIZheYXR9fIUtns2uSgVU1Evj2+0vDPT4wMw7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VobiImQNpmP+3KpkKtEzqFk+/Z7/JXJsBv5GyBqXew=;
 b=i7BlDK38ZDm7JT4OcyKm9F/XF1NnEq5IJrzFRUHSqPotDtR/ZPd1BdyGlFaOxNu3O3CuwgauvM2m10YZm31l5K6Su1RJZVK4XXtaBXUo6RnuvWnTXJJL94ooguffAeFm7EY4QpM8yWikcBo4CETB0aefmJARLyO6T7OY4aZBgb0=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.10; Fri, 20 Sep 2024 20:39:59 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 20:39:59 +0000
Message-ID: <a0e0b074-bb1a-4b79-a393-082de9227cab@oracle.com>
Date: Fri, 20 Sep 2024 16:39:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Interrupt Remap support for emulated amd viommu
To: Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com,
 mtosatti@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20240916143116.169693-1-santosh.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1f3f3d-ca2b-4123-5e38-08dcd9b4653d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJRSjlieHhtMFFaSjIwdS9FZEY1RUFZdnJiaHU5ODA5cUp5TVFkbjNyZjcr?=
 =?utf-8?B?eTRiQ3F4dWhqUW1jRUt5Tk1jczIwd2NnS1Avc2xPNFVhRVpsV3RsN0Y3anhl?=
 =?utf-8?B?cHp5dEgvSzY3Q1pFM1A2WkpTcGM3VTlnUnBrS1NOYWJZSit4MWFtRTV4Ris0?=
 =?utf-8?B?S3lVNkttUEVtZjRnNDVxclpKdVV2QUNtbG05TTdTN1lMVDBrUVdpUEgzNlEx?=
 =?utf-8?B?K2YvdVRNQWp0cDgzaWh2K0E5SHhBMTQ5QllWa3gwbVRZYUN6eWloRnZCRXVy?=
 =?utf-8?B?RFBXbWZYamxwWURQTUluamt6RjhpZS90d0RkMjY1ZkxUeGdnT2EvblRjV0xy?=
 =?utf-8?B?WDcwZEp5WTExQjZLS0M5RkM3Z3FMbmEyN3pFc2hBRFh5b1pOeXNwK0Y4MUtp?=
 =?utf-8?B?MDltK2V6WWI4ZzM3MjdvTEdyQlVteUR2bzB5VndjeUFVS09IS3M2eXowcmtT?=
 =?utf-8?B?ZkRycitEV01jb2xCRmYwQnZZdmN3VnNBSWRYVlhwYXlZZ2ZpZUhiUlROUFpD?=
 =?utf-8?B?Y3lhN2c1NU42ekR3QWNGYTVXVzV6bTVSV2JQUWFhQTN2eWhSWEcwd2RaSk1p?=
 =?utf-8?B?SGhlaHJOS3VSdFpyb2tZenFpdDVRT2w5WjcwWGRhUEdOVTl1L1U1K2s5U0p3?=
 =?utf-8?B?TWpRbFFjL0RrWWdRa1VCK1N5eXdIRG04eVIwZTVzOW00WmJ5RXJVRCtOYVJo?=
 =?utf-8?B?cTRYRlVUWXlPelBrek9SLzZ0a0NKZVhJZ2RJSVRsMDRPWVYzL25mVzdXTVBi?=
 =?utf-8?B?UzFyVmhOeHdUS2JoWWtSLzd4aWVxTHpsWUQrYzZqaWxTSVl3NHVWbDJJMzcw?=
 =?utf-8?B?a0lGb0dpcW8rd1pSZmRyTUlQdVN1dkxFV2dLeEUyMlZ6d21nU3JpcU9ibWhX?=
 =?utf-8?B?YnlSd1Eyam1WQlVxQk8wTnhrMVR6MDRyV0Y3QXo4c0RPZngwWUtjZUY4d3Mx?=
 =?utf-8?B?TDJmOWFQZjliMHZPdnZSV2puTUE1d1pBUTl4bjZUL1F2YmwyckUya1V6Qjhn?=
 =?utf-8?B?dlBSS05PSmk1NmM4cENaT3kvT3JRbUJnek1JdmJTZkQwdW5vcjhZa0UwTWRE?=
 =?utf-8?B?RytiZmtlRUgrQ2t6eVFNb3phcDhhMTdWbG1SbmZFeGdFRE0rd3ZyNkROdXNi?=
 =?utf-8?B?MGFHaVhNNUNLTEk2b1M4TnZ1MlB2Vlhwb0l2QkFJTFRsc2Zadkg1WGNDUVNC?=
 =?utf-8?B?ckd5RlQyTTdoaFBFS3RRSzNuVmJ6T2J0enJDL05qWHg0Sml2cWloZ3JJTFFn?=
 =?utf-8?B?SUFvcjh2dWVnOWFQYS9IQ0tOSFhaS2o1VExtUDEyUk8yeThZVVFjRlp6My9X?=
 =?utf-8?B?dzg0VU84RjEzL3hBOWZtVlMvcmVkVC9SdWNSRlZteEthY0lQRDZ2aE0weUFY?=
 =?utf-8?B?MWh2VUVHY25WS3RvY01IbTNLeU9LbGg3cGtBUW00RnVxMVZVbE5maUhaSUtw?=
 =?utf-8?B?RlZSSGFLT09pM2gvdHBSZ1JxVEY1SlpQTkJVZUtWdUxCRTdieFh4bkFpQ00w?=
 =?utf-8?B?RGxieHk0cWpuSWNGWWhqN2VZZkdVRkpha3Zhd2F6dmhrcndvNm1IcnB6YnZZ?=
 =?utf-8?B?VmNQT214STJZWk92WXZpVXM5ZmJFeWhlbzVUSjFCN3FNLysxbnppYmthWVR3?=
 =?utf-8?B?RFlhTUlqUXA2N2M0NkJzUFFKQ2UrTUdGQ1FFdGx1b2lXektyTWlGZE5aRU1I?=
 =?utf-8?B?N1ZXU2dsMmx4V1RQeUZlYWpWcCt0aU1wdFo3a0FCeWFHODNzVk9XeGlCdENv?=
 =?utf-8?Q?+v+s/ZAGdcHgo0g9DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGYzakNXamNsa1VlRGV0VGVNTTRnSmZKU0tFNmxnWVVqekYrY0RVSDNyZUtL?=
 =?utf-8?B?ZDhlbUZRTHZ4cERTaHgwb0pWL3lkL3o2eWU4S1JuS21aUmxVSFRhWEE5NlN0?=
 =?utf-8?B?K2JqR1JwUFU3OE0yanIyOXVxd1U2c3JVNCt3aDFJK1pqU1o0NmhEb3k0NFV6?=
 =?utf-8?B?TjMyeUFFdUY1QzI3QnBHaVhkVmpYb215YjRtbksyQTlWK3pHQVgwcU9mbXBD?=
 =?utf-8?B?NTA1ZjJjOGk1c0QxNENEbW9mcW9RZHczVlRBTDEvdXJaTW9aZ2dSM3BpUmlG?=
 =?utf-8?B?RUhrQVZYOGZYUjFWOWJBZ1JoaEJTNDdrVXFMY3NzQ09ZaW9pRkNYaFp5ZTZU?=
 =?utf-8?B?N1VlNU94L0l1S0w4ZDFrb0hlSGpNNDUvUHFxNHBDVUNoYXJnRVdTN29sNWln?=
 =?utf-8?B?WjlELzN0WXNoczAvQlhOYjZaMG51Zmc1ZFRpbXhyZ2JLUGhaMlBpcWJjaTN0?=
 =?utf-8?B?V0JTSm02ajRSM05kNGZyc3dPMkpZUkpZdnk3M2FhWWIzRVBzeFp6aEJrUXpW?=
 =?utf-8?B?NXJYVTFPSm9kQW5ObGZ0RnQ5VGNaT1NWU2VYSG9BajhMSmlmeUIrV1hBcGhn?=
 =?utf-8?B?Nm50L2NiMnQybGVUUlAweUFVdE1qYjJ1Y3FvVUFDdi9YV1kyc2tkelBJbHRv?=
 =?utf-8?B?ZEVQNGdQVVpYa3lCS2ZBTFZTMUtvZG9JejB1L3R5VUgzK1BsSENFaGNmTHlC?=
 =?utf-8?B?M0FKSk9XTDRGSExtZy94V25yWFVSdjFidkxGVlRHcFR3am1CNXpSQXhDcVAr?=
 =?utf-8?B?Tkdxdk9WODNHQU9FRGNBLzhVYUFJdVFkbTlOVVI0eVJ6UDNvZW14anBuSXht?=
 =?utf-8?B?czNhM3RuTVhUQjg4VnJ5K09LbGNQZi9iVmtrRWFUMGpJR25NaTNHV0FkRmhC?=
 =?utf-8?B?Umo4dGZCN1B6L2x6eXlYdE9GK3lXRVd1MnpCdjg4S0s0d0JTRVFjYmwwZEV6?=
 =?utf-8?B?QkY5STdRN0JjTWRtbkZRMVJnUjUzaVdYNmk2c2VrL1V0YUdPUU5rUmJQeXJF?=
 =?utf-8?B?SFRxRXF4bUI1RHROa1lrZmlLYVFrbmtvK2t3K0s0QkdPRXMvK0VxaWs2azNK?=
 =?utf-8?B?OGJsa2FnaW14L1RlYXNseUxHUVpvczZlNlBhaEUzUkprR2tWRXN6S1N4TWl3?=
 =?utf-8?B?d1haQkIrd1liTWc2V3Zmek9GUmxZSTg3MTZZMzIxYzRaRDcvTThqYU9XbEMw?=
 =?utf-8?B?L0ttQUEzVU1nZ2NEaTNIZm95My9jWUJEdDAySFFIS0ZJQ05KbnkwMDJRbEE0?=
 =?utf-8?B?N2dtcU1jMFJFTG9zaXZhOXpBMHExUm1kR3lNKzJOelRwdkNYUHBXbkJEazdt?=
 =?utf-8?B?RXRlQzRIM3Frd2RmSXU5bWJqV0VTOHZVZjJFKzM5TTFCdTAwV2VIcUNqL2RS?=
 =?utf-8?B?TmJaWjExTDJzb1pQZEtBeXlSQzlJNWxnaEZ3b1ZjWnlSUlNlQ2VLUmoyM2Zr?=
 =?utf-8?B?YkZHVGNqODVjYnAvb21nY0g5ZjRXUm55dWk2V2gvekFkZmpHTjZrS24wb3VH?=
 =?utf-8?B?QVYvZEFJV2lBWWl3c0VZRXFLYjlndVRpWlNmWWdzUHEvUzY4TkVRZVp6NWRG?=
 =?utf-8?B?amJUNWJSRWlYakhGY1EvZFVWNjBYZEZmSU53K3FOaFZpbldrV0JKZHd2aDd1?=
 =?utf-8?B?YnFScVlmRnUyNE1PbG1QRThJQUpreEtGN1ljcEZFUHRCLzk5WWtrMWFDWGU3?=
 =?utf-8?B?NEZQVm5UNnZmZ0lTc0RuTlJTeUh0QUlLM2w3NTQ1OTVicFFEclVXOEZQaXlH?=
 =?utf-8?B?SjltWFNBNmlSTFBhZmVKL0JjMkhjU2xlUThlb3lMbWZ6VHNZaE5mTW4xOFhD?=
 =?utf-8?B?czRmWEEyUWtOeTVaSEh0YjNQaXBRNklySDVPeDRSMUxYcjlxa0dZQ0tPT2RX?=
 =?utf-8?B?WnJGdyt0VHRHWmZYSm1HSkd3S1V4SDdQRjR1eWVhbDd3akRYYmRadzZCcUVt?=
 =?utf-8?B?ZXpnS0RheWsyMldwbEo1Z3VpdG1xVzdRa3BtWHBPOHdJUG0rM0RqaVRBMEdz?=
 =?utf-8?B?RjlGSHd2VjlGZGpITklIZGNpKzM1R0RqVlE3UDR2a1lHNTRacGpIZjNNbnpQ?=
 =?utf-8?B?SkcyVXkzc094bXQvLzV2VGJRU05WMzhpWWo5Nnh6UTZ3UHE5UHlySHRqSk9u?=
 =?utf-8?B?UmYwTkVWcE12SDNMYnd3VVdDYmlpVVhUWkx6bDNGMUFlMVFKKzUyWXJlendZ?=
 =?utf-8?Q?HB6vOUf0ooeI8GAtUWEhGXA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: niI867+kc6xdxtEHaQQGS+e12f6Hgak60PPTU/Ft3pG5z5dR+x2QKiLn8TTESsRr/kyFYT+sGESjiVIjsbGyuyPFFPCznHD7PpHrf9u7Phmlh/nh9iXcY2NFtTU1yO4VBGXcFxyhVPqcgkODlxnhRYTjO73mr2+EnYgJeF5am6YI/jpZpLJhJikjshtkXXKuoeXHSbj1GgR9VwrArTuyxmUsghK7xQMVcHeliDXcEfkwCu3O3R8KSyjHGg6XbqZCYl1lPKUZQ9Ko4FsHvVsohTr0QY0H76T+CpIPCtZn+rlt2tlHT7sNcgVA3SCjOC+6LGRNvmsmtkpZ+xuc6YjWdWz6ZlwtAVZgtxeB31MI59edOcB52qDtPGf8ZpjcjR2oOHtuDkYfUlCOb0wTBsUgkkC0EIEYsqtVJKFsYm6AdsVT3fb5fm+c0xaHeVz6ljAsX1BySSvCpRg8AJ97n3/GCfzNaAFN7T11CBVumlBWUyRxnJH4rb69uaJ+39F8pCAT/75JYAq/v3mNeu5GmuEwVa0HdkCRUTN585ZznlHp0qNA6agbIp3kYchWl3zTVLOvJ8B7F4b7JQ9pKtbkHL4T0KXe+M9mJHUgZMwOzZMuAso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1f3f3d-ca2b-4123-5e38-08dcd9b4653d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 20:39:59.6802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qkbg5chlJzeY8wAMMHqyE56wNAkP7Yfil+EJCWNWpHYqrgsa855KlDh7/F+g+cLheQZlsHsF8qecxd6EUGkA0hZfB2bswV73VeC2OP8wjyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_10,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200150
X-Proofpoint-ORIG-GUID: lhcAQC_5UNmQznTAhSxcLZmtumJkGDE5
X-Proofpoint-GUID: lhcAQC_5UNmQznTAhSxcLZmtumJkGDE5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi Santosh,


On 9/16/24 10:31, Santosh Shukla wrote:
> Series adds following feature support for emulated amd vIOMMU
> 1) Pass Through(PT) mode
> 2) Interrupt Remapping(IR) mode
> 
> 1) PT mode
> Introducing the shared 'nodma' memory region that can be aliased
> by all the devices in the PT mode. Shared memory with aliasing
> approach will help run VM faster when lot of devices attached to
> VM.
> 
> 2) IR mode
> Shared IR memory region with aliasing approach proposed for the
> reason mentioned in 1). Also add support to invalidate Interrupt
> remaping table(IRT).
> 
> Series based on ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a
> 
> Testing:
> 1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
> enabled
> 2. Windows Server 2022 VM testing for > 255 vCPU.

Tested on EPYC Genoa launching a guest with 380 vCPUs, with VFIO passthrough NIC, using "-device amd-iommu,intremap=on,xtsup=on,pt=on"

I pointed out a few minor nits, of which I think the most important is to correct the error message on PATCH 5/5. With that addressed:

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Thank you.

> 
> Change History:
> 
> V2:
> - Fixed non-kvm build issue (Reported by Michael Tsirkin)
> 
> V1:
> - https://lore.kernel.org/all/20240904100257.184851-3-santosh.shukla@amd.com/T/
> 
> 
> Suravee Suthikulpanit (5):
>    amd_iommu: Rename variable mmio to mr_mmio
>    amd_iommu: Add support for pass though mode
>    amd_iommu: Use shared memory region for Interrupt Remapping
>    amd_iommu: Send notification when invaldate interrupt entry cache
>    amd_iommu: Check APIC ID > 255 for XTSup
> 
>   hw/i386/acpi-build.c |  4 +-
>   hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
>   hw/i386/amd_iommu.h  |  5 ++-
>   3 files changed, 85 insertions(+), 22 deletions(-)
> 

