Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E71C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfOt-0002vA-Vf; Tue, 15 Jul 2025 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubetm-0002is-QQ; Tue, 15 Jul 2025 08:36:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubeti-0001R0-S6; Tue, 15 Jul 2025 08:36:42 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9YplH020374;
 Tue, 15 Jul 2025 12:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fkUDLBnbWj6G3Tdt/+jyXCkPow9ioSYAxtrvXag7j+8=; b=
 UFcZJfSVczwOO+93YwsBJkd5XNPh5T8O74KxM1+4nTYd8epv04300+IWVBgcGpgU
 DlecAORgKJyo6bfkOogxKrkwn13f61W7bNwo3/5RUh++bxIKYe5+mkRe2iqgiUvM
 SfJTqrdPceR6goBLqZpLAApVL9MzU4XEQ3pA3Q7sfGc/1oL3hg+Plv6JvmaBq0Ch
 S4bUmTtdFCi1DykzMNSdoTirFDevIri0I8YPJekZpbGVK8aQG4wtyQSZigTmI/S7
 s45UKsWMNHRwpoTSZp/A47zAaHgBsqjiXBNWHbkQ6PyJw1FHJg+DW+Uro4HTA1ff
 xJYMnngxBw9W9v9gujMC4w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf6ygu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:36:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56FC2WPF023714; Tue, 15 Jul 2025 12:36:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue59w96q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBaRUKdWzpSdSJMs9STYM7JqeajvSjMSFuvfKkFqHhG8urX+3dqg6oX3XoK3mv7oSwgmb8x70YyHlcWUqwHsy9ufTUl3XIPjQ/Vwc63Yh2mIuIu5sNRXl/faZ1eElzv46vdN9i+Z+UIHClCNkL1vomf7dSe4EPvdCF2PLVvU9Ay2cdjxVovMYbutjkoElfhixIOZ2ocBy2sNhoM+PnWWRK1Kzpfbtg6iXwKnh+Gelv1Kq2gLAMaJKoVh543MjShWJqVuTQKHk5+RXk7/WABQqseP7MvT1HtJMCSmprUjDJXbhP7R6ZKRnF6KiYwJ+TlFQyc0g3qkpUKr8bmUZc6uFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkUDLBnbWj6G3Tdt/+jyXCkPow9ioSYAxtrvXag7j+8=;
 b=fKM2RmkNDux1wV9tBsCraEEM3FbIY/AIEdaxEdaC0bVPMP9FSEKoekBFL0GEIC6iOlxukDS+2cDMHUS3CsbH9DKLwfAc8cZedwjTlYSCbZ5v3pL0omV55Osi2U2Wj+vAQd+rT5noqQSuMnn0AlnxTMc3Lj21oc23UBQmIREK/giFQ+DzOYm2uB73+MDl8vb7oyLKdfYvx6saaYJsbjOaSe93x4a3wS7SX9GCap769zgoAQsL+JI3G4Ey5Wy0OReQrSE+EsClUaD2IuObGHgdei8Kc4dTXO0eUjkTEl5A9bPAUS11sAU0OyJAbP8FH3yEpNwZKrTDudd4sebXMvrCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkUDLBnbWj6G3Tdt/+jyXCkPow9ioSYAxtrvXag7j+8=;
 b=ffPcP0lyptj++OfSZUHAbtKTfOmVpepoZViQsTG07JWKEGSmEdEemTpGmJWIWmm6ZQmfocAJLENCRpuUCnShFoLkeFCZgg1Uet4iIDKfLovv8PveWCmOt7UBH5cbZ+kdhi040CouVzoEAvOlfK+XYf88LECQB2vmmHEnY+T+A6g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH4PR10MB8049.namprd10.prod.outlook.com (2603:10b6:610:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 12:36:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 12:36:21 +0000
Message-ID: <fdaf07da-e2be-43f9-a530-995ced88bff1@oracle.com>
Date: Tue, 15 Jul 2025 08:36:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] hw/vfio/cpr-legacy.c: use QOM casts where
 appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, tomitamoeko@gmail.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-4-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250715093110.107317-4-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:510:174::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH4PR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: fed48711-bcaa-437a-41f8-08ddc39c3434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm1QUUl2Y25iZXFUNGJnZE51MGFySitpUWE1OUtaWVdXOW1hZ1U5a1BUSFdB?=
 =?utf-8?B?cGI1QzNNM1VVdzBqTmdLODFIYW93V29kZEhSYWwyaGVzN2RWb1Y1MFNSSGpM?=
 =?utf-8?B?TEdzaWhwOTVMTU9ZL2tBcURyZ2pqZDloaXBhSFMyVkVHOWFzdEViU3hXbG1Q?=
 =?utf-8?B?YzUwcVNITjJDeU1TVVphM1l1eUE5ck9va1ZadnFFSDdxeE04M0hIUFZSQXRF?=
 =?utf-8?B?QWZUMzhoYm5kNzhJTVNnV04zcUhhTXhob0xGbExlQXo1TGRoZG9VUys4eVlt?=
 =?utf-8?B?bFdrejVjMmNSOUdjUDVOZW5pM1o0bWVkWHFpNE9kZUoyRjZtSWNycjdwcWVm?=
 =?utf-8?B?bUY1cmtkREJvVXVTMVUwNzZFeWFXVFNQSHNHazJWRFZNd256N2hKaURuZWVJ?=
 =?utf-8?B?QTBRWTc1cDEzMXhDZ2hZVnRKcGZDNXFFZkdmVnd1MmsxaHJlMDZQYWREWXBN?=
 =?utf-8?B?ZkIySnVRVzZVRDlLZ3NqNGUzNlJWdGJjUUIrVW42Z2FhZzYrdWR2NmJ2RXF0?=
 =?utf-8?B?eHlLRno0d2NBRFhCalhwcklmWWx3Rm43MzIrNUxDaklyZ3R5UTE4N25tRndl?=
 =?utf-8?B?K3RNVHRqYjZDSGdJVWV3blJXQzR2WFI3Vjh5RGdHakUzSnh1NlMya1FjQWNh?=
 =?utf-8?B?V1pra0d0c0ZReExwcmpOTldOMlRYcHYvN09HTGxJNjBORWNqWlpKM2haVi9O?=
 =?utf-8?B?c2E5SEJFWEkvQ1RGVU10Y21HQkdRNXgwbHhSRFY1YURvbTZ3amdQT2FNSDNi?=
 =?utf-8?B?L3djeTNjNUpGMm8rR2srYmZRZk9hVk5IUW5mUnV0RDc3ZnlFWFhCWXN0VEJZ?=
 =?utf-8?B?NE9WQ0U3bVJBMVc1N05NYXFqZC9ubmlNbDFKQzlMS2ZjOGMwL3NXSmhYRnBu?=
 =?utf-8?B?WUVTbHM0VmxmTDdkTTRrSHdwNDkvUk05RUF2MmEzRjc1Rmd0a1h0NE1RNG5k?=
 =?utf-8?B?cTN4T3J2WitqYnZ1WS9nTm9KWEhuck9oNkt1SGpFV3VnbCtSdVZVSVhVOUpV?=
 =?utf-8?B?bVdzZVVOSGx0UFJEeE1uY1RXMGhYUUJuT3dqT2poaW1qbStvTnRSeW9ncGZS?=
 =?utf-8?B?eTZqb2RROW0xZVhZQ3ByZ3lkeG05eUp2NUU1bGRPdkI4dzJ0NmlCNytjeFVM?=
 =?utf-8?B?dmp4a25xZzkwYlBhL3gyRklrczVWYVdrR2hGWEY4VlY1SkRjNHdwVFY5M3Bq?=
 =?utf-8?B?L29tTE9FU0xHempMb2dsYWh6aTZCV1FTa25BaTR2b09RVC9XTEl6YjA0QkdZ?=
 =?utf-8?B?Tlk4WlBJNlhFdkZWekF3Q2srMjNzSlgva3IwRjkwK3l3bkdjMGtRaVJHdVNX?=
 =?utf-8?B?UGpPMlh1all3UlJzbGI1aFRhVk11UUcyekkvRE9OcmNYK3JyUDNsQWlLM2p0?=
 =?utf-8?B?ZU8zanNHb3hhRDNraGtDdkhrcU41REIrTS9HbUkyMlJwM1NnMktuQm9RSXlQ?=
 =?utf-8?B?bi9MMmNtcTRrMnhBUmtTN1dSR1E5OUV6MExoQmxncEt1NUR2dDlmVmU5b3J1?=
 =?utf-8?B?ZjhYZ09rQS9jbWRjdC84eWtSSHhqdEpCWmE5R2Z4akg2ZlBMS3hWUitRalBi?=
 =?utf-8?B?L2ttTEtQU0U1d21mV0lwYTVMdGU1N0F2Q2xYQmg4dzh5Z0kva01mZFhKbFV6?=
 =?utf-8?B?T0tVeXMrTkxmbng0ZExCVWtJMHRSeDgzKzI1cjdrbTdJeGZtbHNhY0lOYStR?=
 =?utf-8?B?Ny9yWXhLb205aENrZnExYytnM2MvaDd4N0VCVDgyT0NwMFMyeHRQbHJ3Q0JF?=
 =?utf-8?B?VWhsRlZqSjhtczgwdHRLc2pNc2p3Q0t5azV3UmlxdjNVSTNVaHp5Z25EcDda?=
 =?utf-8?B?NzN5M2FvTDV6TjlqdVMrd2ExSVFnc2RwTm9HTDFKRWJ4R1NvWExvb2FQb0R4?=
 =?utf-8?B?NlJzRktOWGwxR3hZS0xUdVF1b2JTK0RWSDVUcWJpRXZjRjd1VG5ReTE5VHE0?=
 =?utf-8?B?c0t3UXBqczlSL2NVU2xnSng4Sm1Da2RuTGRDTzFZc21VMzhDUHgreVFJaHZ5?=
 =?utf-8?B?N29jZE9yeXJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhadXc0UXVNR2ltRGFMTndEMkZ4SkZ4UmhyNG0wR0N0U2xwSkp3NHp0dFR4?=
 =?utf-8?B?bDZFTzdjdUs4MzZkcUZ4bkZpTEx2QmpwN05qUmU3dnZMZ3k0Tmw2ZHRTUkZt?=
 =?utf-8?B?N0dWcmx3cjE4S0QycThXYVJkdFNTUVllU2dVK09UYmFhOFJVZVFwTHRoRzdU?=
 =?utf-8?B?ckllblJ3SWRTdENzSjUyM3JkSDEzTmltVnR0czE4c3JWUmRScURvclloT29R?=
 =?utf-8?B?QmlEOFk3QkdPclRONG9TTkFnZmpLYXVUc0VEZExiSmYrcC91c2JRRVFUSjVE?=
 =?utf-8?B?TWxoNnpGLzA0NFZTTGlpNEx2K1krNVE0SkNiZG1KWE5sNDJpTm9qWXB4UmJv?=
 =?utf-8?B?ZWs0c0xDcGtORlcwK2M2WEZUUmtkR3ozaXN6aWNDaFk2elpEYXRGSU9zM0dN?=
 =?utf-8?B?b3FCK3o2Tmd1bUo2KzMwNzFtcXppdjBObjY4MW5OZ1BHYlhxUTRzZldiWnBQ?=
 =?utf-8?B?d1ppNnpnNHlSK2tLMHpqdEJWU09raTBwR1FEUkZNeTFVZ1BBcXlHbzVKQVVI?=
 =?utf-8?B?bE5TbTA2OC9XckFpUjZiUlpZdkR2NGNJbEpRWmJ6aFVTbHhuYzFPOTRBQXdp?=
 =?utf-8?B?cU1XaEhvUTB6SlNDTEk3Q0xyQURBZUdEZnlhZ2t1OFV5eDFBa3JBTm5INGw3?=
 =?utf-8?B?ekNSalRpbStWTVJXY0JNNDhqdCtIVTB5MkFjZGo3V1grY0s4REdwc1pPMFRu?=
 =?utf-8?B?U0lwdHl1Zldxd0M3M0MzWEVicVFXYnFHSVN0UUZIa1hYalExU1IxbkNrL2Vx?=
 =?utf-8?B?N09UTDFyT2lETjQrc0xaRUlWR3ovSmFKdVZxSlpTbzlDdi9Idno1ZDR1WlNR?=
 =?utf-8?B?eTNuNE5uY25UTlpHWGp0SEpkbW9JTFA2bDJPSitPUGVIcGw3bGloWmEzVUw3?=
 =?utf-8?B?TGxIV01PbHI4aXdZWjd4Nm1rdWZubkNORFFaNlJ3QWVSQ1F3UjdkSkFMK0VN?=
 =?utf-8?B?ODFudHJtcitIRG9xUG9yQVhMZnZHWVBsUkRadmFoUElDN2grVmdhMEhwaFph?=
 =?utf-8?B?TzVVeU54M21uclJaV085R3hTV3RqN3FRSHRPVjlSWkJNY280RGRTdG4zdHlB?=
 =?utf-8?B?YVpmRVhZL2k3VjFEdUo2OFEyaUR1aW1LOGsveVFjWHZXRGVuV2RQdWtLNGhH?=
 =?utf-8?B?VG80ZWxxNklKMEF2NGljWDF6bFFVQzEvcnBlNUhoK0k1OU0weEpTMjB3REd0?=
 =?utf-8?B?QjhibTRpdTZKNUxNUDB4SjJ0dU9sdmV0OWVPeXYzTkdZSVlGWndDRGgyUUxT?=
 =?utf-8?B?K3g2K2o3ekZZM1RBMlFPdzJhbk9melJXbmdhbllibmFjNkphbXZabXkyd0Jj?=
 =?utf-8?B?ZEtBMGFUN1JiQWw4aGgzL2VOOXVEa2IrSVdnNDdNL1UxdE84WUFlUVNKMkJq?=
 =?utf-8?B?WWZIbnU3ckdoVXBYREhtbDgzLzkyY0UzMXFZeGtTZlJJSDlTNGdvd0RZQ1FY?=
 =?utf-8?B?dkFndVVURVFsMEdTQlJIT2hKOUpCaDVtQ1l5cit0em5oYmdraUdnZll0SWVY?=
 =?utf-8?B?b1I2Q204TGRNcENvbXFnSlVDOGJKd281R3V2K2lNeXJBc2phNk9NQnI4UnJP?=
 =?utf-8?B?cmVaSCtlSDJFUGpkL2VSUnpWUmZwTjQ5ei9SWDNwa0RzdWN2MXhkUEVhbHBI?=
 =?utf-8?B?MEttZE54MWxFNVBSRFQxUWR0MzJDcDZKcCtpOWlBRWs5UG1rMmo0eFZnSkxj?=
 =?utf-8?B?OCsvY3Z0VWlzWGhXQ1pEb0VPV0tjbEdGS3VMb3VZN2U0a2FVN1V5elU2RWxM?=
 =?utf-8?B?Z1AxVk16eHhFaTE4VTVSbDBLYmpUczJ3Q0gwdWVRQURwK1ZmU2NuYWZhSDZ5?=
 =?utf-8?B?a3M5aUdIS1dLTk1FOEVucWxzeXVMSXI1TnMwTzVBcmp1NWdNRXpqSXdXckZP?=
 =?utf-8?B?ZG5iazhsNW0zUWttckxCbmFOSlNxZ2IzWnZwcXZQUjJKRGI3YUhqUm9maTBy?=
 =?utf-8?B?enJLR3NhSGwzOXVLM3kyU1NiRFJBeStHVHZDREliTytTMFIyM0ltSXA1bHox?=
 =?utf-8?B?MDkyZVBTaExXL3o0eU5sY3JmdktJS213eXhCSGlSdEtqeHg1MkNvZ3RNZVpO?=
 =?utf-8?B?SzdnRk5lODFTRFk4eFprUXNzUlV5eTRUMDlPbGNhdjlUSEUrVzZmYWFvTXBu?=
 =?utf-8?B?UzM4cyswWE1mc0NpZmsxakpnSVU2d0ZzejF2d2creGhVYUl0eFJwQzRjVHBt?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OaMqZK1panuxNCR4DP4ZuGdqJHpXebdPX1uaG49Ly5yvjqrM9/TND3YVA2eTjtj8ZC3MGEG+9yhq6hWogaHYJweUD5PUiQVDKJGGzJaRS1YMbLFLzXLktcUgsPb2CZ9bL9lcpgKh1ljLSVR5hX4ffOC9p7nWdULdsUdjKYNrdwVtWG1UCek9jOGzYWo90Qwp2RtD82d6JFXe7YVw0JAwrVm/75urOYot72IEg9vEjS6Dzzc1e5m1tmUisBiEkO1IMb11Q/vhyBeF8hR9CpzneZUfKHUeTEgjICHcgb1bu0V29cv10JolxiT8XGRvi3BMRCiOahf9v1bBQgUwXvn5DhXZqMR4Lq1/hzYtRw46XNibK0+0UTy7i5m+m5AX8U5oow2a7U6jqr9rUiP7culRpX2kzTvpRTI3fDEv+ClXwLZgORt7OCGfS5w8jk+6PXvRWAyyk5ZkZLzIMuBm/AA0Y/TCDHzemKOoINn/fbLQu7GjE1Jze09gDZKGM++SXJcfzt+m2mepGr2LYl9pt++P2w01nA580iASrXQpvITejNrzxzsC7iGJn0FbCAAplzZ+5x/hlFwxcoYSL8thujFxD2z6ayT6uLvvBKiFQbAag/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed48711-bcaa-437a-41f8-08ddc39c3434
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:36:21.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JgW/441T9JvV9o3nT+4ClwZDQYXNBXbliUmzKkCyVwekO8oYFsw7mtPZofE/y5mDu97ger5v4H9xaYv2EUSlnV7J60bymyZZtC19r25jrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150115
X-Proofpoint-GUID: zNVzoSaHhbx8AXFlUXLY7oyX44huJxae
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68764b4b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=64Cc0HZtAAAA:8 a=yPCof4ZbAAAA:8
 a=CW3U6tPuvI0nifRizXAA:9 a=QEXdDO2ut3YA:10 a=AqYkckc_seYA:10
X-Proofpoint-ORIG-GUID: zNVzoSaHhbx8AXFlUXLY7oyX44huJxae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNSBTYWx0ZWRfX9wm/3Xiivuln
 2GF8eiFCAg5cOMpH4tBExdAOfJmjK7/qjWeu/x9K7mM7aQGaN8XuJd4yphfbUXsZc0TsVtzCAfa
 5Jw+XGAyYKLkLyR93plME6WQHyOm+FV7a2ZWGvwViXXE5FCxAnuIPrJ9TpuBzXXsTJZCImhnhE2
 osOERLziBNqVpKbk+xsuNC9Tvseo1J+e8FXUtQ/7bmBpx1UlcVlJwI8sDPt5YMK76N/dN3aq//J
 hopQ5q8eMeyTogcJGIpL7G43MdgO5lLZwdXLJjEgTQUDIxSY/Ryk8DYqTpTa6xJF4R4yOo7Rqbm
 /4WWoZ7P8ZBtc6sYtOxnce2LUiRwe93nQykc5kMB50LYMvIxwHkgO0YtEu+Jht3aPJsIdqwafLA
 n5qZ51xlKLoeJvWt+29wOg+5yiCh04v/c0Vj7FMY1c37btNSqhXs5WUrbNby5wfxSkkKF55K
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

On 7/15/2025 5:25 AM, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
> of accessing bcontainer directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

