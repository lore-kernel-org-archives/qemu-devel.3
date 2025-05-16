Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2132C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG0i7-0002w9-KX; Fri, 16 May 2025 15:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uG0i5-0002w1-Qc
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:27:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uG0i3-0001kY-MF
 for qemu-devel@nongnu.org; Fri, 16 May 2025 15:27:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGftNG007007;
 Fri, 16 May 2025 19:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=toj/XBlxxvTXIiATkTq6XsEH1tLlIxixX1+ddI6bqgI=; b=
 js1yukyVnXsMCHCxdja1r4qg8c27HeLHAhiNXunSaaXNwQRdd631bNezK7lJ1spH
 9I3WgJKCP1ZMe+QKK6xCHu06DR9EBXC44Osvl61qqk8rD6mEmulEdXGRzlDMclIh
 I3x23NtDlo6ZhtVveZ5Om4BKavJ5kvxcW4M4iJ/ckjQ/7qBSNxg9yAmqPfFDo6KM
 MeHyqHXITswBNVKD5gWtPMOmS0W0oBQO/yWNQPsA2qIjR/rHXj4wZiLdnilLfmaM
 Feb77IcUw8wElz3WkEkRUhUg9MoK4eft7uVuWyx3AxtjoZHia+WjYxdl/tt5MElO
 ZHLn3kQehWMa98PYEIg1Iw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbkt253-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:27:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GIx4wr016906; Fri, 16 May 2025 19:27:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mc36ehxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 19:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7yHOy0Ed1q8e6hCZ9gg6nm5Kq2wiWEzqafyMJ3F5h0O9JpizK60P7u+eoRHGZiRlClviMoAcAa8y+czxnwNWy3cgWMekHVbVb6fwRwEQDbgDeI0IsxOOCdT+nsQrfpQYo+sfmIS840Zkxd6vUExtW3wqpiKLJ1X8xToedQbw6lU5cqGOSei64krBEDwLUV5MuiTh//LTYWZZuKCYbcaO8G9UF6q0+J7ISF4GdemJeqWSCnpSzbeu7M5owqbOMe1cLrSBIh4pE2VXuRokoEvueAtq/7n14WCql97bzH1cuHjLvlx1weW+i3r7UQ73dpaRERCtsVEtfXmC+VIgfHnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toj/XBlxxvTXIiATkTq6XsEH1tLlIxixX1+ddI6bqgI=;
 b=T0DtnV0WLGl/eLZEfXwQMbK6xeotqYHOzrOK/dkc72znWWu76YyxUlBzFSeH1O+pY9FluHgtSwB0n+btjGt88Q5D1l7QzJkVsOg7NYZhpQ8/5FqpEq81h2S5B0BoECcsO3NUfHwRAq3bnuL1jmOCgfo1z8Ha5fp91AIQtNYhshijmQax7mOjS7+wKdE4iWa63rXNkGRQ0vtV4kAgtsjzNho2/137ihqG73Q9Q4ky5HrUmj1WEG2MqBTolyuSR4EKnEWCabGQng2JOlTxGzpmIPy9ChZcA/QeyzxKIcPWXUdE10GxVGbRPCBaKdWF9Vo4FH9jmv0qttZS3KupxNWnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toj/XBlxxvTXIiATkTq6XsEH1tLlIxixX1+ddI6bqgI=;
 b=z9j85KnUlDBDBp4SfCK02z+EVaAqzyZdE833yfRq+sUQ8SvH4xTvL/BFARo9D15LnlifcaPcE2XVaRrD8yl4FWoRttFnu5IgZUJ8+XoOI5sgVdXZf0fg4oYR+TCM7F3Hz98vpNkTIg1mH5rRVo5RlymJ4M0X84D/ndngvjfzf2Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4641.namprd10.prod.outlook.com (2603:10b6:303:6d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 19:27:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 19:27:00 +0000
Message-ID: <717acf0a-bdeb-45ed-bd44-7c054247836e@oracle.com>
Date: Fri, 16 May 2025 15:26:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] vfio: return mr from vfio_get_xlat_addr
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747415599-131553-1-git-send-email-steven.sistare@oracle.com>
 <e6b1e5ee-f8d3-40b5-a608-67469a8b599b@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <e6b1e5ee-f8d3-40b5-a608-67469a8b599b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0330.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff84a8a-568a-407f-454d-08dd94afa143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWZPQk1WMzZYb3dMdWNwWkNlVngwOWRoWHdSZng2QTBvc1J0S2lLV2EvRUVW?=
 =?utf-8?B?ckhMOU9KSGFzbHZWbmRWQ3VTNGRrQTQ4a0Nkb2FYYjhmdjZiTG00NlovZEJz?=
 =?utf-8?B?cUw2QUdmSWJxM1dvbEVyc2hOU3Y1cDFxT21wR0xzMkRBVUpjMUlaU01OOGc1?=
 =?utf-8?B?aTBEdEpTaDhFbytXdkJxOHg1Zk45Q3I2Z1hWN0U2ZDNsTFlqRHB1N2YrOHRX?=
 =?utf-8?B?a3pWNkkyZW1ndi9PRVBDTVZDVlhkUkJ2cE0wM1pUbHNrNEZQRGp5Sjc2OFA2?=
 =?utf-8?B?aU9NdWtoQklMRmdSOFdMUTJJQjJCMmdNTzgxa3FhSzk0ZGNocXdjTWRwaC9Y?=
 =?utf-8?B?Q053ZXhkY3owSko5alhhQjZGWE5FU0dQeGhXaWwrNmF0QlgvaU5tUUoxb2k1?=
 =?utf-8?B?RjZocnJINldtT3RFZXpCMlV5TFFROVNUcXFQMDUvV0FLWDRlcTRabGFublcr?=
 =?utf-8?B?NWV4TzkvdGs5NGNJQ1dOQmU3R2cwaVJLVVJXVTNFMVNLTjVTdlJiRW5xVWFZ?=
 =?utf-8?B?MllldEQzQWd5ZzVqWjE0VkxyZXFTV3FSUGtPY1hrQm5MT2xFRkM2eGVETjZj?=
 =?utf-8?B?QTFERTl1NHVCM2toRkJkR2RLRUFCSmhkblo1azdZeElhWEo0QzBtdXFxcVlV?=
 =?utf-8?B?b3RRNU9iOGVKb3NhT09hWitBSmdnT01tczladFZlQmI1NkNyb2hOR3VtTjc3?=
 =?utf-8?B?TWtwWC9KUmYzMlNiV0xiblJvK0toVk5KdGh6K2xKYmFGTlFaWTYzMUdvVmtX?=
 =?utf-8?B?R1hBaHQwMmd6NkRuOEFsNnBpNG9WcGpnMDZ3akcrWFZBMzRMSlpSUlpoeGtN?=
 =?utf-8?B?aWhMQkovcDRSUnVoRkhmcG9JS09xVHAraXJSRmFyNU9BQXlHcmFtMHZCYVJX?=
 =?utf-8?B?aDZ0SitZTmg1bTJZTXVjck9TMDhDOGZoT0xhZ3pUamdxdEt6NnMxZkU3QkQ2?=
 =?utf-8?B?SXV2KzZMWXNVLzNmRGpCWHlQbGRwT1FvZ0Rad2J3Q3RHNTR2T3QvRytBSmxZ?=
 =?utf-8?B?bFR3TnhIQkhlT0xtcUFLbGxsaGFIQ05HdVFjTng2Uy96eElmVmdTMXNUUmU0?=
 =?utf-8?B?UzFhN0RoRTFQYy9EL0FzSVVGYVBFNG1zQVlrUkhyZzJCQU5mNUFwWWE1aE5t?=
 =?utf-8?B?LzllNUNDK1VxQVBzUUppbXpGcVRlWEFMZ2hxclpiK3dONGM1Smgwd1dnQWdB?=
 =?utf-8?B?ZmJxYmtkcUdSWUdrTTlJdTN4dlVKZnJ0bmJIZUo1TEVIQlZTdVVpRE45bFB6?=
 =?utf-8?B?eFFmSWRWZ0I2eCt0U1laS0N6OTB4bkhFZlk1VlpjSlA1dzEzOG1OMVk4dVhE?=
 =?utf-8?B?d2p6Nnl0bVZld3dsUjEvUHFRdThvTTBDTGZNT0FHdXNTbU5FME9wRDJIOWJq?=
 =?utf-8?B?a3I3ZzVab25sSHR3aUxobGhNYzJqelE3K0JIbUg1U3VzN0lnUXJXYUtjWGRN?=
 =?utf-8?B?eU5LZU80QjlHZzhuMXNSWDdoZUdGaHBjOXQrWDBSTThJZ05EODRMWVNMdSts?=
 =?utf-8?B?N2lQaytqQUZ1blpSRFFyODQ0SXN2RkhIc0x6U2NtN2pkNXFsbjRBY0J0TVdw?=
 =?utf-8?B?dGtDb05NdVNPY1NRQUJzakdPeDRkb2V1U1pXTEZCa2ZhSkF0bHB6bDZPWUo4?=
 =?utf-8?B?Z2IzKy9jWDk1cThWZTYxdnBOemM4OG9IaGhYYjUvL0J5bVNWWkkrMGpjNzJX?=
 =?utf-8?B?alNyM29DTkxyRlFMQkMyT2F0RWNWSlo2Y1RnSkZkMUc3eFpyajFKUEV0dWJX?=
 =?utf-8?B?T2tLRnF5V3hRekZyNGhrYmtRbEVXdFFFU2Yvdm1LNlgwL3ROK2tOTWxWbmp0?=
 =?utf-8?B?U0FKdTFIVVZaeFRoUjRvSzI3TzRhWk8ycEJCTTRVUHU4UlA3QzN6VjJ2VU1P?=
 =?utf-8?B?MURGYmZVT25BK2k3ZCsrTFYrbzZIVEU1ODIxNkIyUTFiODNuOEw0RWp2Q3pP?=
 =?utf-8?Q?/lhPH8x7WlU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RVL05zREdiQ0VsOGIvUm5hSkZTWnNZcC9hTG5TUnRtclNUWXVrRU1FWlJP?=
 =?utf-8?B?MVllWW1yMnhLUktEMkJaTWQvUnVtOUpVYWNUVDdVUmswQUdHUzdjM1ROc2o3?=
 =?utf-8?B?R0dVcUg3VjZzaHIwcE9OdlY2eDAzdkRTNXN3eENKdnVwY1hjWXZRVjVmSzZv?=
 =?utf-8?B?RVhGMzBXTWk3Ny84YkpXYVRXWVBUSzZFZFh1WFVZOEx4YUhhZ2tCTXlscytl?=
 =?utf-8?B?MGlpKzZMbkIwdEVLNWpCTjBycHVjcEpkR0ExaE8wR0d0dVFTUDVCZGZVRGtq?=
 =?utf-8?B?dGdQc0V0TFJTTXlPS1BXZ1pBRzZpZWRFMUNjMTJvS3FqY1lLRG9lQ2JOUlZO?=
 =?utf-8?B?ME1qRjFicjJhRnJEUUk4Q1RNMmVtY2F0YzYzVG5qL1FkRWFnMU5OYlFYZGg3?=
 =?utf-8?B?NHlaR1VMcVM2aHVvMUtoSUVoeFdDa0tvL0hNM0FmNkpGNzV4aUQvQjJVVERj?=
 =?utf-8?B?dVVWaXBBZmk3TmpZZ1BLZTQ2akQwVk9ZT1pITFRPazNTNnEwSCtCV3lhZVk0?=
 =?utf-8?B?aldBK3BPc3Y3RnV3R1hRKzB5aHhuWmRHZjZQY0IwU01KeGRpOHB3YjQrK040?=
 =?utf-8?B?R3gvbkVZQjVYbmlhSVU0TS80L1UraTMrOWdjNnBCaVp5NUJjM1pZLzBiMHd4?=
 =?utf-8?B?amtTODBxdHF6bC9PRDRTME9DN3E0SllaNFpTdU1QOGFJUXNzcEExUEE4VjEx?=
 =?utf-8?B?SkNrZVdXb0ZMMENvK1dLWkhRcXdDdmZwZzEzU2s2SFlLbkRIelRYUmhVbWkr?=
 =?utf-8?B?Z3d5MlVZNm1zcjVyaW5lMUdEbGhSSUFQalJDYUdxd2YyYUdKQzFLT3pJOGdL?=
 =?utf-8?B?SEtISGYwZDdjNXpSbVcrMWZ6MmkwSkJjU0lPV3UvWDJaMlZIMUJ4TU83b21a?=
 =?utf-8?B?R3h3YVBiWkRTSWpuSFh3ZE9UTHVXUmR5RTFTUWh4bTZYcXhpcHNTdE9BaXRW?=
 =?utf-8?B?NHpsYTlzblNMMFpPR3hQTEl3Q2xBWHJKUzlSN1BDaUlSbWZ5N3ZFMG5NcDUz?=
 =?utf-8?B?OFNyU1liM0lUQWV5UU1vYm44SkVsS1ArR2lWR1llMVVXdjQyOFk3MkxRdmtX?=
 =?utf-8?B?K29mSlBmKzVBVGJ2YzZtL1N4andXcVdnSjlENFphS2N5bG0zNDA2bTJoZGNx?=
 =?utf-8?B?K0dFUVhpSFBudUoyZXl1ZHNOVHNiTWhmUWo5aE5UeEgzTjEvU0cvaWEyUHhD?=
 =?utf-8?B?MVZ2SFRua1NXTW45NWpSY1JyMjA0NTdTMGtRRFY0US91d3pGdTA5c1VGeWd2?=
 =?utf-8?B?OXV2RXZ0OGdtN0U1aVh2b20rMno2M2dyZXVjek9mY1hoSWcwVlFCRVZoVTdS?=
 =?utf-8?B?WEpORCtucUFTeVR2Ty9MWUI2SVdzWVBZY2ZHdmJ3WVlBaWFTcnhiUEpmeVdy?=
 =?utf-8?B?ay82OUc2aFY1TWFudUZ4ajhwVzI0NUF5ODJiSkNqZXZLaFlraXNKL3QzRGpw?=
 =?utf-8?B?MGVsck5idFNFQVBHY1BYNjJldFc3MGQxWDVBOFlwbitiWVlRUlpPVEZVRXQ5?=
 =?utf-8?B?VlgwT0s0dnNYbzRGaUVmR2NZQVYzTG1wRm1HYzlMd1NwNFIzMlVMaFo1WE1K?=
 =?utf-8?B?Mm9CcjlJQnB4bGdvdzZseDNjVHRkTGpBclNSSldQeTZNazc0UU0wSHQwaHJr?=
 =?utf-8?B?M0V0cW1pRUxWT2NEdXltU1YrVDZDdHQwVCt4T3dFT25oaUcxOWtTOERQaW5o?=
 =?utf-8?B?MThLTyswK0o0blR6YTI0WGNwTjEyOUxaOVZUTXR4dUZZMjhjbDdZeDF3bmJh?=
 =?utf-8?B?VlVPMGhtMFVZdnRaNisxVUZrSDQ5V3QrcHFhUkJRR0RHSFMwN1U1YVp5cm1X?=
 =?utf-8?B?TFJXYm5kTEJEQXVWaGwxa21TZUlXUS83UXVZVmk5UklZbEdSYy9lZ1dxdThp?=
 =?utf-8?B?WGpWSS9mZ0tsOEd5MllMWjBrK214Q1luV1JQSkgzY2R2aXlDSEhHNm5KU1Zh?=
 =?utf-8?B?VUtOZUlBZjRQdFBmUHRQaHdDMDNubDNlZ05yc1Vnd0UwTTZleWZjQklGdHpj?=
 =?utf-8?B?dnk5Tk00VEo0TkNhdWhWR1FsMWVnZHJkb0t3OUFrbkVkemZHQ0F3N1VCbkNk?=
 =?utf-8?B?YnNnWFJXeS9FVC9Pa1g0a0JNdWdUYmd1V0NhcWF2ME94b2tiMTI2bGdSVXRN?=
 =?utf-8?B?V1F6SThVNzJEOUpNZmZTaDBYS2NaVHBzOWF3MHlVOE01dEZBeHBOSG5WV1R6?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ewjIAaccJtdNjxZqcm5CBR2mTCRbdZ1VzQoNOErUMt7vif+8uRXq3a+bNogH6jG8m5+f+N5gopIdbN0RIaDsh09qKLp5UZL97ITTdkU+5EXdzlAFufpqkSqRJt6C0jVIEobWC+5DWdaA/LB519HAaapvrHm8DEw/a4qS+ic0n6PHydJCpjw++nHk39OW+xYS4rKI6vltHevuNsyEUTF6RJawDcXePTn/5/AkYZslgiPxpu+MQ1sLj29gIgs2IrSFVNOwiIBlYWlYHKeu1rRoc03+IcxRHUEnjj7H6ckAKqeDV7l/EIJpMOFcHsJajrCqdH2hwsOikmq54gkBBysG4UyzKo9t/kcMbVFQDve8AgzLWZxyo4QiuRcTaWUDEPTO5c3gutI/d4yrZyezLP53H7f2Oitd0CPBluzdgOGAho/AJDS7ukj789wxd1xBJ7PPbCKXCsNI2ugmWnCUgtJVRa8RTLCmAUaWOjlQD7cwrPUEb9AVBFuKNJDJ6YSSHqT0s7Du07NWHNQcrtvsxuVQCPVrdqHZBEfsJa7dmYvsC2CPfzSRl+phzNnyT+4ofTL0VLcoIK1EyQimLdbwcXuabaNIE4b5359a+3S2tPbp3j0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff84a8a-568a-407f-454d-08dd94afa143
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:27:00.4343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9PPpPQ9ApQmIQwnF3JzFOQ7OlBnZojoR/xdfC71LofEjVJ8RNL38itMFGRSiJF9l1HcM5VfvhztCy7pagfHui2dSreCGwETzRSymKWwjQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160191
X-Proofpoint-ORIG-GUID: ZITdEzQtBIo5ITM2py6NkhiUfwH3jbcf
X-Authority-Analysis: v=2.4 cv=OK8n3TaB c=1 sm=1 tr=0 ts=68279188 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=bIzmKkk9Uh1I5UMRlgwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: ZITdEzQtBIo5ITM2py6NkhiUfwH3jbcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MSBTYWx0ZWRfX4lggx1x7U3Qb
 SySs3xdFhAXCaAUQpbr64lvbNe4UHD6BW2QEciGDnnnRkbZKlsQt7Ej3vQ2Yk6m5KY+iyn79iTQ
 KGNgBFZ57/uI/VurwghuQjo1D+Yq4BoKyXH8sSHHnhJWCqQVWttCiEcnVkVhMLgw0wOd6BD0tX2
 DKZXeb/AA52bFV3/AthEUlQhE3RIEUFAncZG0zxenDwhNAJHa/az9NNWvDCuc1Zjau1TbmLUWlm
 uG5L6vMyuykHW5zCbNR/EnkgR63EdRQwSv0Uz9VeyCa5bRKluruuz2bUvZUN+aFMPQmYDXaA95q
 mFo5SXMX0zGVV08aRSo9hlWwA/IlQF8UGYMkuTrPUyA+XY9jL7BJ6JWFCxnGmru8ospdUdtughJ
 Q02W8usmE4JGhw+MeYzyxGWlssxxnTPQqR4Kef5Z5Ts75H10Hc0uq+8hHJhuFRK4GeGcLo3P
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/16/2025 2:58 PM, David Hildenbrand wrote:
> On 16.05.25 19:13, Steve Sistare wrote:
>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>> region that the translated address is found in.  This will be needed by
>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>
>> Also return the xlat offset, so we can simplify the interface by removing
>> the out parameters that can be trivially derived from mr and xlat.
>>
>> Lastly, rename the functions to  to memory_translate_iotlb() and
>> vfio_translate_iotlb().
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>>   hw/virtio/vhost-vdpa.c  |  9 +++++++--
>>   include/system/memory.h | 19 +++++++++----------
>>   system/memory.c         | 32 +++++++-------------------------
>>   4 files changed, 45 insertions(+), 48 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index bfacb3d..a4931f1 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>              section->offset_within_address_space & (1ULL << 63);
>>   }
>> -/* Called with rcu_read_lock held.  */
>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                               ram_addr_t *ram_addr, bool *read_only,
>> -                               Error **errp)
>> +/*
>> + * Called with rcu_read_lock held.
>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>> + */
>> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>> +                                          Error **errp)
>>   {
>> -    bool ret, mr_has_discard_manager;
>> +    MemoryRegion *mr;
>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>> -                               &mr_has_discard_manager, errp);
>> -    if (ret && mr_has_discard_manager) {
>> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
>> +    if (!mr && memory_region_has_ram_discard_manager(mr)) {
> 
> Pretty sue this should be if (mr && ...)
> 
> otherwise we'd be dereferencing NULL :)

Hmmmm.
That is why we cannot return mr as the function return value.
There are cases where the function can return error, but the mr is
valid.  We want to take the branch in that case.  From the original
code:
     if (ret && mr_has_discard_manager) {

So, I think we need to ignore this version of the patch and use the previous
one that John posted for me.

- Steve

> 
> Apart from that, LGTM.
> 
> Thanks!
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


