Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232DEC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7bf-00036g-0Q; Wed, 15 Jan 2025 12:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY7ba-00033w-SV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:55:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY7bV-0003cK-1k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:55:02 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHBtSl005117;
 Wed, 15 Jan 2025 17:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=5c/7aqGcVpYCVOpTEE83X9K1yNBfTfc03wbN584S0yU=; b=
 jSUdWT1c2o1T1jX6UFJI/ZEU9ov1Dbyj/53Havb5omCA49PbZXQV6klKvpcWvQUh
 DOf/yFoQWJuMpYkGhL7wc8rgYRdfkgRi5dsdJN011BW09nCZxx6HFmKpfokbAZAK
 ljQ0sSAu40ZevM1mEsHunfzOq4tPyB3ejVidX0A6OjmK6G96/xuTBnZZKI+CW7xv
 XQHmsYoSaqDT9plkWQ31meNkza0V/z0Wwq+Z6iSUg9QFDeO3hwRAnJH/JNn3lbbe
 33gC8+PoMcZ7sQps3W9xHlz4T0MRiestY4BmEvh1tTCxJidoCEHd1gvzEMCnPDrf
 mkrTDcfM3/MAsI5VTAr/kQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjark8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 17:54:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FGWYjR036440; Wed, 15 Jan 2025 17:54:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3aamjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 17:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUvZRA85JiQ2S9kdo9xtEYGHxNEGOgxh83b5GyGzAaccxPHTL/hEiSQShJsaDHGWt9r5nBAwwPclu+S2LsTMOk62F8qyB5NQKS81d+dpEeNlwXw7SGJ03trCw+qPVr+3Enrt3RNiGMU2/m9mLrh8xWHK2u/0p7LxvmDyNDGXJ7zlZARCmVBx/4syfDtuqY/jyPltP3BHWRiWfnL8aMpFB3NGA4gBY9aMwfvQBZCEHbeZ/6HiIhuN6T2vAHJSq7A+yxQPMYb3VZDpV2fAJ/WnIeKgMXqnUwLHq7erVE5ldZXNMAqgIvH9W+H3Yfwr89oqZJWWq0lXY6Xmw0FTMJTSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c/7aqGcVpYCVOpTEE83X9K1yNBfTfc03wbN584S0yU=;
 b=eYtIeSAFc3Th0Kr+5VenEQf+U1VLawer6R9zEzE4HtBytIAaulk96Zfe0tAWtYMvQmzxuMhmb6Qnk91uLKd4IOFywp5AEAseIcayTTsZjYFAWNFWL1D2NlM+OaeWT/F6SRSnmkolHVcRQXKebO+2LJyPp0jApVpYXSnFzMo6N01bLSLnz5mkhCegdGuKOtwnsA4BiU+OhRYoZ6UniQhvAKl/GDKv0o9x2/G0rW+NygYF8JtxeyAMBFx1dNSpz4PHzZqj1xZcpBdcRihDsmwNfojDDmMkg9K+uNE1XLByaMlNtO2bYWzOJfoqAIvGUMBhxf7mUAi8lSPn9VNdH0h5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c/7aqGcVpYCVOpTEE83X9K1yNBfTfc03wbN584S0yU=;
 b=aBzYOcut2sKoTfFYtwfs40RINGkCFuFnEmMESrpgZ88cZE7SgKq0sXzcKxE+X0m8UWJ6pX7raEkZMN2oxZ9QeRYyI9ReYa8ObhwJNWUALDekfM0FhstSME+heF8/asLIv+xNQ6Os9b+bZcFD2ieigwXPw90Yz29t2v6UK4K/P48=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6174.namprd10.prod.outlook.com (2603:10b6:8:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Wed, 15 Jan
 2025 17:54:44 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 17:54:44 +0000
Message-ID: <64954ade-7b7b-4372-b758-bfea0f741cec@oracle.com>
Date: Wed, 15 Jan 2025 12:54:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/24] Live update: cpr-transfer
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <87plkpf8bn.fsf@suse.de> <87bjw8f7tm.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87bjw8f7tm.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ef9e0e-b987-4016-21e2-08dd358db1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE53R0ZhemlPQ2dYNEorVEFOYVIvRndHd1dDM1BUN0FIOG1seEhsK3ZQR003?=
 =?utf-8?B?bFRtQlpGOGFMQ2ZFY0Q5S1RCc2M5aVl3N2cxYlZjYW42OVZwOXAvMlBMN3I2?=
 =?utf-8?B?bkFZT1hHSUJmOVNrNEVoQTNQUTRHdmlySU1PeThhY1E5VjE0dVBMeW9hU01V?=
 =?utf-8?B?bmV4dDc5bjB6MmtTdTJnT09OQTVWMmR0dTU0UERUQlhZOHl6amNJd0JiVThp?=
 =?utf-8?B?K1ZjNmRzT2dIZDNsQ3U3Ri82YStIQlNIdm5tVm0xNEYwdTRZRXZ5d0Y0YlBZ?=
 =?utf-8?B?ZEF3RXViQ0FXb1FEUzZPRTRWK1Q5VkxLYmFCcHZHSE5Xa2h3M1VCdGl3NXBq?=
 =?utf-8?B?b1V6RGpEM3BKNkdMZzBmeXkzVE1VR2w1YzNRSlFOcGd2SlVRMThVN0IrQmF5?=
 =?utf-8?B?Ri9kK3dROHNpTlFPUU9OdXk1cVI5Wit2WHp5eFhvZWtaY2IyTEJZakZJT1Fn?=
 =?utf-8?B?K0xycTMrR0ZUUkJmRDk2SVNWM2dQOVk5S05kSms1bkVjK2ZzUHA5YU9zK0Zk?=
 =?utf-8?B?WGxqY3BmZ3VtL0srVWZaWDN2NVgwMWZ0dVBaUVJpaHR3cVdoM2NhdWpCQkV0?=
 =?utf-8?B?cU8rUFdieGYvbHdkTGpIcWVtNUFidWtJaGtxd2paVVZ3VHZxWVZaQkhNWHlU?=
 =?utf-8?B?WXlISFptU1FlbkdHdkRWWEJKSXpFZ002VTZjQ1o1YzAwbU9Oa296ZFpmRW1D?=
 =?utf-8?B?RkgvUWVrZzFyM09CeHJtWlRRQVhQZEt3c3lHVUdqNzJLeDJOTEN3WVc5Ym1E?=
 =?utf-8?B?TXdRalJOZm5rL2lPK1FYQURMc1lJLzBlaGU3MUM2UkUzaHlxbG5NK0RoUzUy?=
 =?utf-8?B?MytkOHk5aTlObWp6QUNSQ3l0ME1jQnhwazQ0U1hKWWlZTC9OTDhjY2owK0Y0?=
 =?utf-8?B?K1Fwc1hLY0prNFFkK1R6c3pYVXo1bW05OHFlb0N1dmxydmZYWCtQSDlXRmkr?=
 =?utf-8?B?T2FoQ0s5dzE1dmZYZjlSeUpRMHIzVFhqL0JhOCtPV3V2U2c4SXArUU1XSkV6?=
 =?utf-8?B?NHlXK2crZmZreVA4L0ZQRW16T0lXcFpnKy93OUFId3QvUmNFMzZiSzM3Z2tB?=
 =?utf-8?B?N3BYYTNzMzJOTnlBcHZrL2MwRzVHUFVGL2luWndXSy80LzV1dUgyVVpkY0lo?=
 =?utf-8?B?N3lVQ1UyUUxsejNMUE5EL01YWUNjMWQxNTQyKy8yWlp0R0pueEZhS2dkKzBy?=
 =?utf-8?B?aGFQV29FQlRJSXphMGJUOHZGL0V3WEN0cjdGenRXaEpOOTZaSWRwTVNLY29D?=
 =?utf-8?B?QkRtTkYvMVBiY3FROVZlSXdvSkZCMEc3aUt4U1FEb1doWVp1amRyRWxHMjB4?=
 =?utf-8?B?NEVSMm90M3ZOckpqM2phN3JpdjhqZnlhYmUrRFZ5cDJ4UnY5TUtkd243OXdT?=
 =?utf-8?B?OTE3cXpYTnhCK1dHRklHaUxmMFNtZW4xMEZMWjdqZFNPL2hnR09tbWxzMFhw?=
 =?utf-8?B?RjROK2UyTlNnaXdpbGRLLys4YkJrcURKTEdtRldHQ2FNN1QrQ3hOYktIa1dq?=
 =?utf-8?B?UCtwVS91aGFvc1RUNi9XbW5MdTRCZHZhenhoM3M0SUtKbFg4M21SbXBjTEhQ?=
 =?utf-8?B?K2VVdnd6STlsNlh6WGpYTEczc1pienF0VEJFUURsUnN0c202MG5jZHZ0Z21K?=
 =?utf-8?B?QzVzRHljdER2c1ZvODZwZHNaa3BkOHlJbitkcHR4RkY0djdWUjVvR21nejZx?=
 =?utf-8?B?eU0xQngvOVJQVDV6NTJRSE8zT1ZVQzIvY09tdFoyYnIwWTdLV3JWMVY3d1J5?=
 =?utf-8?B?OHQzV3h1OElWRjVzTnlXalk3YnlOeWtIUmxXR0FlcHFyQ25JQVZ3eGFpYk9j?=
 =?utf-8?B?Nno2UjhRNU5md1hmZEUwMEVrdDdTT0tEbXRacWpiSG1oOEE1Ukx6YzBvM0VY?=
 =?utf-8?Q?zlWRoWsuodikn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlcxb2p5QVJtVEtIRzZCOGlia3liZm1mdDJEeHU4bjhubGE0bFNzRDlEUEh1?=
 =?utf-8?B?WSs0b0psdFBoZnMyb04wR2dpYUJrSG1DMEo1NlovZkJoNlIxVDRmZTI0Y09t?=
 =?utf-8?B?aDlYT1NHbUNhR0F6RDBlaGd3SUFmTGttT0oxRFVENjdyMk83bisyQU0yOGF4?=
 =?utf-8?B?NzZWTzlPRUxXdWowcmJBRjVEcWp1RHU4NDFLL3REaHNSdms5SFU5OHc4ZFZV?=
 =?utf-8?B?djhGWXZvZUlVSGxnSVNRcGVHMDd0UldDWWtKWTBQanlna0hHMzZJekcwb0x5?=
 =?utf-8?B?M2tZQ1d6c01FWm9iZGpIVjJlUTdzelc3UmlvdnZnSVV2ZmY3WjZPRjFXdElq?=
 =?utf-8?B?VWljQmVZTGJwaXZDeEdTQkl3VWk3VWhhd3N3aEs2TXBCL2duZWVHaW1OcXlB?=
 =?utf-8?B?RWc5Y1ZWWDM4WUhydkwrOWJ2ZkxodHlPOEFiVndvOGJ5MHVhNW1DRVlWNnZ2?=
 =?utf-8?B?MVVTVlByNHZRYlNLZGhGeGFxWENWMENqaTFkSy8wTGlhT01ZS1Fkb3d3aEZv?=
 =?utf-8?B?SWVNN2sweWhQcXJCcGZLZDU0aWxqOVlCczJTcEtCdmhCN01HajVVTnp2MW1O?=
 =?utf-8?B?ZVlDbytsZXRLd0pHRnpaZjhQQTR4SmYxaUZyY1JPSVVtWFFqUXNTN1BmUGQz?=
 =?utf-8?B?eTVuMHNYcVJ3OTJ2akx3OVRDVDg2ejdHaFRzeURkMXJWOWtXUGJKNnJXMEE2?=
 =?utf-8?B?NHdNWStvS242NDVaUmorOEZCOWRERjFWK1pPc0d0NmhDUlVIOHJJQjE1QnZV?=
 =?utf-8?B?WE13MzYyaEZVZDdsOEpYMjJoUG81R2JBbWRjUVBjb0FodnJuYkcxeUF0SHZR?=
 =?utf-8?B?aTJ6cUNNTFFUd1JoSDlZMldxR0s3YnpieXJBUXBiUkFBQ3BramdUWHJSbmpx?=
 =?utf-8?B?ZWJOZmNxckNVTlYwVWt1ckdYMENrSkhDVXFGQzhxTWpENHQzZGpOTWtOM1NW?=
 =?utf-8?B?VmxkUVUyOXJKL2dCU1Q4c1BqODYrQ1g5Q29ab1EraHMzSThnOFlncEt3elZL?=
 =?utf-8?B?YThKdlpqbkNtUUUwYUs2UjNWV09KM2tIS3NJTzJZNmsyT0pHRGFzbGlWOS9O?=
 =?utf-8?B?N2J6NEU3WEhoUG1BRURTT3pQdll4MHpBMFRvUjdkNmpBMkJ3eGZwWjN4U1Vz?=
 =?utf-8?B?VUc4c28vOUpVb3VkSzFmZ2xReWJJOHhadnpEN3pxQmRtSkFyOUMrWk5wL2tF?=
 =?utf-8?B?WG51elpTN2Y3K2JkT2xWVlY4NGNHYkVNSUl2Q0p3QldYSlhlTG1DTmVFWU5o?=
 =?utf-8?B?b1kwMFpXOUdNS1U5ZEhSVnpCRGJoaUh0WDlUdG42ZkJrTXRoR2NGdGN4Mkhq?=
 =?utf-8?B?TzVFa2hxQzUxdThmR1F5NVhyT2dqSzZRQTZ1dlZ4SUdyam94RTNraG52bFNB?=
 =?utf-8?B?ckl3UkwvNVU2SzFnQmVSNWRYMTFqcjhRai84OTZzSFRWNnEydHNvd0ZnWUkr?=
 =?utf-8?B?ZEx0NllsU21YRlJSeXAzWGM0VUFpTFVMcXpicW9kVjR4MklCN3I2aFRzNVhq?=
 =?utf-8?B?R2RVS0U2V28xUVI4UVlnc3paUkV5UWRxTGdnV1VsTEJWc2dNWC9lWkpYanhy?=
 =?utf-8?B?Y2Q2ZVlPV2dBLzdIUjUxNWpiOTdxNEE5Zlh6elFNcEtLbXREUER0VnRiQnB4?=
 =?utf-8?B?dFN6OXpNV0hiN29XQjM4WEcwQ2NlL2hnZVNBcnllL1pOKy9DVGcrSkZDZjZt?=
 =?utf-8?B?bXBmS1BWWkhoVkFENWh1VzYrNkowMkRUdDhPZmh5UUlEQlpXeTlKZjR4Qm1M?=
 =?utf-8?B?RXZPbHE1QWFKT3FYSm5US1RDYUNYRXdycm03ZXV0cVkxeEdMSHQ1OHdLSllp?=
 =?utf-8?B?NEhxakNITEtaUlVUaVJtWTZSRnlHSTRoN0lCWXVFNTlScGI1d3lUajVnS2FC?=
 =?utf-8?B?dytxTytDcGdEeHZ4ZFZmS1dheWptSHJZcXQyV1FRUWZxcWNsUGlYRUtJckxC?=
 =?utf-8?B?ZERtODVyRmM4SG54WU1LekZDd05XOVg0dXZZWEx4UkJLbzJ4dDluakowaTdM?=
 =?utf-8?B?RStEVyt1Z2JPTHFUekF3K0NrNUE0b2ZWdVRIWlpTZVZIS2QzaXN5UDdabEJO?=
 =?utf-8?B?TDdhdTNiZW81SHlsWTVNYzF5b0VaWUF1MjZZYWdZUEZZVktsMjROeUtWeEpZ?=
 =?utf-8?B?WjlNdGNuRG5TcVVuNDhiN0NHcy9FMkNuMHVveE5IRmFZSFh0N3hZcnNBUjhp?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sPt+I9J1hMnYZN80dveJYc2i3r/mq2cKApArnt/qw33YvSj9583eZcF/3xAFFaEqySCosr3FTMxlt5gvcuxV/TmS9mUANH02qcEkD8nomrisi43CI6orYPEy6eZ9wXszFMWlIzyLPgQ9jhmfDUk5VDrFO6wUn2UMkJmzUd8zIePfgp8cf/wlDsAMEfnMSF86r7tD848M21U1w1RaZ56hAPtyoEdl7GzchnJo8YfX2GlErTHriLl5BhwcmyaXNvGGYQ4Cr4mYyn+BgO8jVViptj2llvzlqGhF2i6HXbOQmIUEoK4my6VvOPJqKKxaQ7aDsWFpS4ZPw+HFnGcr9oTuat6aS/UuHWSxi7q7Qle7sSNXTk/Q2BJMsT9V/XDCIEdvS7yaQ2K6684C8vbrOgu+xmOEIstZFGSgEs5yEqgG2ES4i9KCr2IbvXSyYOcDYEsgE7IcBTaii4m3vM8oK8hANsTfftzTaRZu1KWZreyHLgFiOMz2RudLlW5YUlF3fimQvFpp4KxkHQlG8FYrSrS8soPlTD0Sz1Z6TKss/sv5JWpUitFAA980h3Q6gyj6cJkdSJG4LpWGVnHIDFIJryqOKeHxlLxD+uz1mQkbGUb3AME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ef9e0e-b987-4016-21e2-08dd358db1d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:54:44.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1Mwnbxkvr+Y+qqbRy3t4QzauzDRmvhlJVTw15s7SjzjJt7Dl+EOfEYvb5kz07M8mq5djEmirPC2YPly+8OK3GkJC+0u9mwXjzDLTWVl8+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150131
X-Proofpoint-GUID: qtB8_xCB_yWVw2RE_LS7OKsPqQ3OkC7t
X-Proofpoint-ORIG-GUID: qtB8_xCB_yWVw2RE_LS7OKsPqQ3OkC7t
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.793,
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

On 1/15/2025 9:52 AM, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> Hi Steve,
>>
>> The CI shows some issues, please take a look:
>>
>> https://gitlab.com/farosas/qemu/-/pipelines/1624984802
> 
> The asan build is also upset:
> 
> ../configure --target-list=x86_64-softmmu --disable-docs \
> --python=/usr/bin/python3.11 --disable-plugins --enable-debug \
> --enable-asan --cc=clang
> 
> QTEST_QEMU_BINARY=../build/qemu-system-x86_64 \
> ./tests/qtest/migration-test -p /x86_64/migration/mode/transfer
> 
> 
> Direct leak of 392 byte(s) in 1 object(s) allocated from:
>      ...
>      #2 0x5607648c3fd0 in object_new ../qom/object.c:789:12
>      #3 0x5607649a3da3 in qio_channel_socket_new ../io/channel-socket.c:64:31
>      #4 0x560763f59845 in cpr_transfer_output ../migration/cpr-transfer.c:28:34
> 
> Direct leak of 392 byte(s) in 1 object(s) allocated from:
>      ...
>      #2 0x55dfe6727fd0 in object_new ../qom/object.c:789:12
>      #3 0x55dfe6807da3 in qio_channel_socket_new ../io/channel-socket.c:64:31
> 
> Direct leak of 120 byte(s) in 5 object(s) allocated from:
>      ...
>      #2 0x55dfe67fc671 in qemu_peek_byte ../migration/qemu-file.c:777:9
> 
> Direct leak of 104 byte(s) in 1 object(s) allocated from:
>      ...
>      #2 0x55dfe6727fd0 in object_new ../qom/object.c:789:12
>      #3 0x55dfe6825e0f in qio_net_listener_new ../io/net-listener.c:29:29
>      #4 0x55dfe5dbdad4 in cpr_transfer_input ../migration/cpr-transfer.c:57:36
> 
> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>      ...
>      #2 0x55dfe67fc671 in qemu_peek_byte ../migration/qemu-file.c:777:9
>      #3 0x55dfe67fc7ad in qemu_get_byte ../migration/qemu-file.c:790:14
>      #4 0x55dfe67ffc1b in qemu_get_be32 ../migration/qemu-file.c:840:23
>      #5 0x55dfe5dbc584 in cpr_state_load ../migration/cpr.c:189:9

Thanks very much, I have root caused all of these and will post V9 with
all fixes soon.

- Steve


