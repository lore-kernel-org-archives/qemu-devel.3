Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D30C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 18:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4l1Y-0002vj-LZ; Tue, 15 Apr 2025 14:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u4l1R-0002uJ-68
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:28:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u4l1O-00083r-GT
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:28:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FIN33j022412;
 Tue, 15 Apr 2025 18:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=jEkc+4IAISzZ/2TrcRzv5yrnMZyK3751tjtrgUPL1jw=; b=
 F6rJb5JghNx1LpZrUTRfGaTndHNJYGybnR06LJckrto3vUuMEFKYaN6y1pZCzElm
 DJEmBvA7O3LctqyxoaqNak3NoG/DO+85W73M05vtmKvDwXmWqk96+OB3VGTI8ulU
 NWqr278V3U0KDvG/no7MjL4qYi5TJBo5mZ/uOr7mjSG8UGYFScFyLNsufuQdf9ph
 +SqGE6kLF7UccJRLxXK9spBmHNOk1EBje+3HGOqCp3P7TYQVCO/2gG5x5VffiDzR
 dbMjOghFHuhl6/n6AOaUYHyG4mPkSuCbJpWUWQOl4n6jcQEdGdZ3dnoB0b8Wp8n0
 mc0LrL4prngN3NzfgYWKCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mtanm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 18:28:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53FGumst024656; Tue, 15 Apr 2025 18:28:29 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d50qxns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 18:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5vFREJLzoaLKXuRiB5XwvCEPqh6HKLgPl0AU1hLyN6LVlK86x6Vm0rpFMkgwxj/quH4juM63CKKqklDZa6CkuWx/qushJcIkzaixG996AfcMGtKsJ4+xam8L5EIUZwme697E7Q+C/dOxA8k8mW7IzewiSSlv4prB/TAV5Qm1kql6VxY7oKBwh64HChC0g1K6SdVO2RO/WKlg33wyFh/8CnUnBOg5AbRCTRIJaUE5rjXXXWyo7eZHSnGU4KxjVZjGEwZxWCF4vYFMy8FWQjN1DbRL7ma0LLHkW1TLWUkVfq9v+oKm3Lkvx1+NbWOrrP9+pdFk8AkkBnBvZSa/DSgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEkc+4IAISzZ/2TrcRzv5yrnMZyK3751tjtrgUPL1jw=;
 b=GsF31aRUpmqZn8yaxu7JWKDK7W3vVLUhJ5M5E3Kh19jVpCemVwApYnMWbCs8rITtXzieWeRx+VACM52PqvDe+ZMGJRa+hDrOJ0pB5wDWtdHDJZp/KudzuP+Pxjv/P5r3ge4d4tdQSXLQB+SWKlvNfFFJ16CmFvYhyUxEyPUEp0Kh+tZHNF+sEV/tu2XE9woe3As2BuK/dA0k8GvCBFhlIgmRyT3uh/TtZpNV7MapB5Y+Gg9JdEBQrEsWwA59rOPZqarIg//sDTBWW1dJrU6fkwiaQMqCuW1kt2CuypIhsrCy0ijLhE2C2WbEE7j80nN1+7dtH8XSOzrQAG2svfYwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEkc+4IAISzZ/2TrcRzv5yrnMZyK3751tjtrgUPL1jw=;
 b=Md1g5R631cblahrIhSlwfvxPjgiGQpOiyYnZ0ICo6BT8nv5PVZtAc62HUgY4xnC9iObaelqShFsw4NquAHN8lF0/OMBceGUkxEys9tfW50G3hZwLnCpqvULPIKaXvb32ZdgNgGJQMrTwATIBWT3t7IBEmxxFME46ch8/v4fW6jg=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 BN0PR10MB5174.namprd10.prod.outlook.com (2603:10b6:408:126::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Tue, 15 Apr 2025 18:28:26 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 18:28:26 +0000
Message-ID: <c0a214d8-f9d4-4fa3-8262-88cdd4372878@oracle.com>
Date: Tue, 15 Apr 2025 14:28:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix device setup failure when PT
 is on.
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: suravee.suthikulpanit@amd.com, joao.m.martins@oracle.com,
 philmd@linaro.org, vasant.hegde@amd.com
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-2-sarunkod@amd.com>
 <914314b3-611d-4da3-9050-3c8c1b881e40@oracle.com>
 <63acddc3-bc7b-47e4-9e7c-66bdc40f23d2@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <63acddc3-bc7b-47e4-9e7c-66bdc40f23d2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|BN0PR10MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b50ad7-6ae6-4e24-5b5f-08dd7c4b500b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1U0RUZ4YmFPeGh5akZHYXkyT0xzZmYzdWhHcyt3UjNwMWNoeVZ4d1U2cXAv?=
 =?utf-8?B?ZTdnTFJmV1pVdnM3V3pZNUNUbXhhZUpXVWVINzBpZDlsZE9jQnJFbitQUjh5?=
 =?utf-8?B?d21qeHNIUlUzdFFMb3JaaXRHN3oyYXhQRkpZMXJlaU9BRksxUlkzYUZpaXpm?=
 =?utf-8?B?WWdKR0s2WktoQVVBZW5OOFp3Unc3K1l4emJiYVpVcFZ4VEJlVmxoS1llalVz?=
 =?utf-8?B?ZHJjT21QM0tkNWVlQ21OV1VoZzZ4YVhkR2tXVzRwd2taeVBnK2pYNG9EMTVR?=
 =?utf-8?B?RVp3cmhQUTFiWVB2T0pLYkVJUDB2S0pZNDAvL2Q4RmNEUldrSGZBYTRGVE9w?=
 =?utf-8?B?Sk1NdzhySzlzWXpiQVcwTnFYYVZxZVpZay9XQ2VOY2pDeEFkNlc2Slc4aHBv?=
 =?utf-8?B?VEFaS1B2Vi9zUGZGRHhOZXpnYURGbGw3T0VIK3h3bnhqUlBuQWZQeW94b2di?=
 =?utf-8?B?R21rREppOVhMbXZHM3FWbGUyY2lUVFZwTHErMS9VZUZLNTRpYXovWUJDdXRK?=
 =?utf-8?B?bkVhU01YTDBKenhiS2dhRVJIcTE3Y3RFa214K1JsMk1FT3A4MU9vdmFGTlF1?=
 =?utf-8?B?cXVlOVkxRkJhZFU1RFVsaEFjMGV6NjdDcUFybGFEcU1rYytLaGk5dXdveEtm?=
 =?utf-8?B?TGxsOUFoMzRHZW1qVGNDT2hONTJEaEdESjNoS2d3ZkxqcWc5a09iZzlVZTF4?=
 =?utf-8?B?RnBHZUF6aXhwOUxBQzYwYXU0L3dWc24zd0N2SU5DRFJ3T1BQVzZLN2hnaysv?=
 =?utf-8?B?SWtPZHFHMXFOU3Y2LzlJd1EzaXNxM2J2aWNTOTB0bXFsV001SkxISUlpUDR0?=
 =?utf-8?B?VlJuTXc4Y1dMc1N1RHQvTFc1bXdUM3krMnVPcVhWRXNpSTJGT3N1dzdnZzRU?=
 =?utf-8?B?UXZCSXdOYXpNN0psKzRkWkg1TTJEM1pPQTNlZE5Ccjk5cDNFdHdaVVl5cDlL?=
 =?utf-8?B?NFE5U0tnVlQ3VEVEeFlVR0F6WXVRU2ZOTlY0R1dnZU9WMDFhUDY1V21ZOGZo?=
 =?utf-8?B?bzFtdDVlMDUyc1pRVWY2YUl6blFMeCtSWXVpS1cramhGdnpTSDNLaE5FNFlr?=
 =?utf-8?B?MVFzKzFBU3dOTDZNRUpnZ01ha0pJMUIyVkZGN0cxSFp2R2ZoRkJxRlJ0dXl5?=
 =?utf-8?B?ZG1pSVhiYXZRYWl5dEppcWR4bGlMVlJTM3ZVejgwaXc5a1NnUFFEZXc3d2lS?=
 =?utf-8?B?MDZ3UXZ2OFlqeFpRdWh1MzBJcjdLQTlxTDMyVUtLbitIbUlCQjhaQzhnUjRJ?=
 =?utf-8?B?WGNkSDlxdURaa3BFTTRkWFBOVkpob2dnYXJrY0dhRnMwbnNrdlJMQ3d4S2xy?=
 =?utf-8?B?WENCdDlZK1oyMVhuMy9MWTlTYjdjckhMM0VhTVk5b1BxZEg5bVlVZlZHWlNF?=
 =?utf-8?B?d1B4R2RZWFBmN3VqQkhmRzdoNW1PUGFMQmwxZXAvV1ZRWnYrWnUxMDZ5c2lN?=
 =?utf-8?B?MCsyK054cjlkdG15dFpZL1E0M21JZy9PTVlYQ3V2c0VCdEFyZXcwWjJpK3du?=
 =?utf-8?B?UHkzYWlKVXJxSkhxNVRoaC9VSTJIbndqVnNEY2ZXdEJsVjQ3bUZYVjNzTTdD?=
 =?utf-8?B?djdQWmRYSUYxd29EaUxDSnp0NTFyeVdEOG90aExtNStkNFpnbEpZeDlaMDhn?=
 =?utf-8?B?bUpKY3lRaEYxS2JwUmQra2xITUhmK2hmVGFmRWZyMVN0eUEvcXBnWXkyT25a?=
 =?utf-8?B?dDVzOUlmdEJaNDVmVktDSFBXZHdLdVVseFpINGJYaVQ2aDdIODhRZUFVOHhE?=
 =?utf-8?B?NTQ3blBNVzdYdnoyWVVGTEcwM3NObFcvMnJXWVpPUHNrS3BLV3dWb0RNRy8r?=
 =?utf-8?B?RHcwR0RHb21QU0ZUME9ldnFSdlNmcDdRdU1wM3pIbHFhWG1reW9VS1dBNVpm?=
 =?utf-8?B?NzZPWVJsU3AzR2JZMkxzR2tYd1NXT1RTYysrMGkwZ1NtS1M5aE96OURlUnVy?=
 =?utf-8?Q?pIL4jwQVhZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JTemZyYW82cWRTank3Nk9EbURtNHBnTTZOV1NkTG5xZU5uZjRtRCt2blV6?=
 =?utf-8?B?YStZRzNzQlc1Q2pBNTUxQmxRanhuWWpDWGZtYVpPV0ZpdTVWTUk1QWY5dklD?=
 =?utf-8?B?Zm9sS3FZbGw4MXUxdXE5Qy94Q2lBSDc0QnN4cjBFWXpVN1N3c3NLdDd2TVJS?=
 =?utf-8?B?SjlycGJ4eHJoWEM2bCtvL21UV2dMVmE3RXl4eG9FTEc3bldBUVNTQWExd0Nu?=
 =?utf-8?B?WFh0TVJ0NUhKcmNhWmk4UURCUHpEOGFZbnk1Q3R2RzRqS3Vza1YxY2VQL0Jy?=
 =?utf-8?B?bGZmN05TYXdtS2UrdGpRVFZOTXVlQ2FRazZDWGJkTTJ3YnFKZG1SZ0pJWlR3?=
 =?utf-8?B?RFdlaDBwT2RKbzFqVjhGbUIvUEhXTk0yM2hQMC9KbnU4T3NLKzRHL3U0alpV?=
 =?utf-8?B?azQyL3k4V293Q1lDckRXS3J2OFpQWnExQnVqeG9sVW5GTFRFaS94QUFXVnUv?=
 =?utf-8?B?Q09qZE5WcEVhVTRMeVBaOENnczZyTGJCblEycVlXQ0M1azgxaGNMalhyZ0Ez?=
 =?utf-8?B?eGttenFDS2dvakZJVUtXNkhrOXNxUXI4bmlTUzEvSExld3FEdGVGOW5YZG1O?=
 =?utf-8?B?bWtMQ3NickhmRXZyL29VZzhBWERzUGpmaTJnR3BTd3NyMlFDQ0NJQVhaS2Fv?=
 =?utf-8?B?c0dWaFZYNWtVMzRaUytsMzhkRnFqc3o1SmJLMjBlZ2krMCtSNzRpRG8wdVlV?=
 =?utf-8?B?eHZXdFowNkptMU0vZnl4MEJSTlpaOFNSenFoeDlFT2txc0FlUHlKbzdYQlo2?=
 =?utf-8?B?UFJPWkxlK1J6UXYvTjIxbVpXQ1BzOGV3K2dHYVlGbXVVcGJjNmY5L1BUMDAr?=
 =?utf-8?B?ekwvNTZaSitsRTNJZlZ0V0xmRjdIRytoQm1xWjVKZU9IVjhJU3RLNU5hQjRx?=
 =?utf-8?B?WTZxcWNtWi9MRHg1UmtqWk1uU3RNOTdZZ2Z4cUpsMXpnWmhCWHFKaS9LMGxO?=
 =?utf-8?B?aXhPQlFZRXN3cmtpL3VsOWRaMFJ2V1NZampYR3F5SXdDSWlZZVF0RVJTbUJI?=
 =?utf-8?B?V29mY3BWNDc5L1I1UU5pNTF6elJiKy9XN0ZjU2FKanZQUkEwZlp1UTNPc2Qr?=
 =?utf-8?B?UWprQVVsQUJvaXdPN0hYeTFoUFE5ZFIxeW5Ha08xMWYrZmZUV3pnOEZSK052?=
 =?utf-8?B?cnpWYnVhUURKY1JoSWNVbTNNOWZwS1QzMEtHbWtaQ1NKWWQwbndNelA5QkZL?=
 =?utf-8?B?ME4xbVAvaW9NamRuWHllY3Y0WHFGWU0yVXhxZU5ocHN5b1BPU1Bzd2NEL2JU?=
 =?utf-8?B?NnMrOVh5NUdHdFhVTWZDek43aXNreEFRMDVZOVhXeWtvQU1VUzZNMk5JOWRJ?=
 =?utf-8?B?eXRFSmZJMkVnWUxja1ZrbENsZkhLM20rN2RxTUhSWEpqanY4ZVU0dTV4THd5?=
 =?utf-8?B?ZVptVkVrQzNRQTNBTDNiRDhKR1E1bDNJWGo0dlQ2TjlQazE2a0lTL1Y4SzYr?=
 =?utf-8?B?Z0dVdCtwK0RybkVGYTIyZjBCVDlMd3N3Yi80VUJOb25KcXM5M2xFZW5EcXlx?=
 =?utf-8?B?dXpHT252YXgyWlQzRXlkQmlkcTVoU2pBUTJuVDBRRy9oRnoxR3ROTVBxNWl0?=
 =?utf-8?B?STRpV1ZYMzhIMTlxNXdzYXdYL21ZbENnTjhCYTRLQ0NoS1pZcWlPdjNVb1hl?=
 =?utf-8?B?ZDNyTHpMbEJESkxUODFjQ25CVUVlY3NyYjJlSGtWMTNNTEJZY1RISXBURHNM?=
 =?utf-8?B?WUlHMVZpbW11cFFBbFpVR2w5TGtNZFRLWlRFWDhxRzBERUViTnNSS1MzK1JE?=
 =?utf-8?B?YlRkbWJpMm9BZDR0bDlGaGJVOSswTStiZ21FQ3NCb1pRRTRrVDUzOVpOaWlK?=
 =?utf-8?B?L3Jad3FZcjgwWEhETzh5MzlXMmFyTThsY2FJQ3J2U05lV1BvRVFwSFRyZXFN?=
 =?utf-8?B?QTNmSDhFMzdxOHFxd0lwams1NWFieGQ2Nis4em53OHRDam9weHp4MFIzNjkx?=
 =?utf-8?B?c212TnVrMVNwZmtmcXJ3L3Rnb0h3UXNyYWdHRnZ5d3RMak5OVDhOZFJ4ZFAx?=
 =?utf-8?B?WVJOWWhnOXRzVDVjMjd4SkZmdUNETU01N2lHTUpTbDdDaU9iL2RFV0x1Z2RG?=
 =?utf-8?B?YWxqbnJsMzFaM3BFMmVCNCtjN2pmdFdvelFJZXJVeG1HcGRLRVVtNXl3aW5I?=
 =?utf-8?B?bnpIL1hRVXF4NmZWN1hnUUY0eG1FUTl2UVpwdjVWTTQyb3ZmVSt6N3Vnd09S?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L+lZPxIWLgPuVrvru/b3dKp7HipPoTDKyKFE8cmNWXvZhAoN+6PVZEygIAoKWYQ9hSzZ8u1JU/VSCkplZ+U1VWRKwRmdqFZsGT8gDPssBCuUz7+55MF1VTe1gTiUMql2WkNEBpnl4zBekMYrJtiuYg5M2ZkNhssVmlOe9Ozy/UAG2pgXPm7GoKVnUbVZ1NOJKFm37X8UkAXdfgPTEeFIrs0SpleIJXflzdoFziG9ZbDNnDaMAso7Tl/dmgBcFpIDc3A13zxr+alFFfPX3dlmsjbEwLVSvAuvEsMdsiGLEgp40B2F/C6CL5MvE/N7cYyhUvUJ9X8xA6PCy2G+JSVuQn4HS4V7c/ndPK/ndglOMo/d7TeVojnYc0c4Z/unM+lGLZhydkXh3ZgZfUMu68V4Pr5kJn84EUNf8F1Pj166ggPYpjd4GXzUYdK9wZK6aMbqDitZUSyZUpcEvOh7ZaUtKZRbXFoSVF/mQMtzYhuGItplNJ5q9MnJ738M2KN7j6AQNou/pmx2e2I4zD1mfkQjthXGGeXdbG8VAJ2NU08USA8L2ChaMbP/CW5daRdTJh50IFtl1KetJGJLF2C1h/OSgbGGjZ3QD7xgn71755rA9UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b50ad7-6ae6-4e24-5b5f-08dd7c4b500b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 18:28:26.7516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2ph5MCS2yLd9zMnMuDOfrR9biCfxv1MGUow6y7vDLM0U2FiZ3aLomYO2BDE83gVsqBrmVwORkPXHLb97hG25h1QrQzLVCy2xtWTpL2xWjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150129
X-Proofpoint-ORIG-GUID: t4ptRW1T_dWL2yA0qUM6IylZpE-TuROP
X-Proofpoint-GUID: t4ptRW1T_dWL2yA0qUM6IylZpE-TuROP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/15/25 2:38 AM, Sairaj Kodilkar wrote:
> 
> 
> Hi Alejandro,
> 
> On 4/15/2025 1:56 AM, Alejandro Jimenez wrote:
> 
>> Hi Sairaj,
>>
>> I'm conflicted by the implementation of the change, so I'd like to 
>> make sure I fully understand...
>>
>> On 4/10/25 2:44 AM, Sairaj Kodilkar wrote:

>>> Fix the issue by removing pt_supported check and disabling nodma memory
>>> region. Adding pt_supported requires additional changes and we will look
>>> into it later.
>>
>> I see that you are trying to essentially block a guest from enabling 
>> an IOMMU feature that is not currently supported by the vIOMMU. 
>> Hopefully that limitation will be solved soon (shameless plug):
>> https://lore.kernel.org/qemu-devel/20250414020253.443831-1- 
>> alejandro.j.jimenez@oracle.com/
>>
>> But in the meantime, I think enabling amdvi_dev_as->iommu when DMA 
>> remapping capability is not available is likely to cause more 
>> confusion for anyone trying to understand the already convoluted 
>> details of the memory region setup. 
> 
>> To a reader of the code and the commit message, it is confusing that 
>> to support the "NO DMA" case, the nodma memory region must be 
>> disabled, which is the opposite of what it is meant to do.
>>
> 
> I dont think that I understand above statement. What do you mean by "NO
> DMA" case here ? is it iommu.passthrough=0 ?

I meant it from the point of view of the vIOMMU configuration (since we 
don't control what the guest can request). So in terms of vIOMMU modes 
and corresponding Memory Regions that must be enabled to support such 
modes, I see it as:

Passthrough(NO DMA) --> MR: iommu_nodma: enabled && iommu: disabled

DMA remap --> MR: iommu: enabled && iommu_nodma: disabled

But I recognize that view/model is probably too rigid for now, although 
it should be the "correct state" once we support DMA remapping.

> 
> Essentially, I am trying to support the "DMA" case that is
> iommu.passthrough=0 for the emulated devices, by reverting the changes> that introduced the regression.

I understand the goal is to make emulated devs to work in more scenarios.

Because of that view that I mention above, is why I don't think of 
c1f46999ef506 ("amd_iommu: Add support for pass though mode") as 
introducing a regression, but more of a prerequisite to support both PT 
and DMA modes.

> 
> If I understand correct -->
> The original intent of the flag (in case of Intel) is
> 
> 1. To turn on the optimization which will use nodma region (dynamically
>     enabling it) if guest configures the device with passthrough (pt=1)
>     for given context entry.

This is why I said I am conflicted with the implementation. Your change 
always disables the iommu_nodma region, where the default for Linux 
guests is to use passthrough mode, which "normally" would result in 
iommu_nodma being enabled. I almost suggested on my first reply that you 
instead forced x86_iommu->pt_supported = 0 in the AMDVi code, but that 
creates a similar type of contradiction.

In short, I understand what you are trying to do, but I think "the 
trick" as I called it below should probably be documented.

> 
> 2. The flag should not enable no_dma region if guest does not configure
>     device with pt.
> 
> Intel driver does this dynamically (for every context entry update while
> guest is running). But for AMD this is static and does not change with
> the DTE updates, which is causing this regression.

hopefully solved soon:
https://lore.kernel.org/qemu-devel/20250414020253.443831-15-alejandro.j.jimenez@oracle.com/

Alejandro

> 
>> To explain the "trick": this change is always enabling amdvi_dev_as- 
>>  >iommu, which is explicitly created as an IOMMU memory region (i.e. a 
>> memory region with mr->is_iommu == true), and it is meant to support 
>> DMA remapping. It is relying on the "side effect" that VFIO will try 
>> to register notifiers for memory regions that are an "IOMMU" (i.e. 
>> pass the check in memory_region_is_iommu()), and later fail when 
>> trying to register the notifier.
>>
>> If this change is merged, I think you should at least include the 
>> explanation above in the commit message, since it is not obvious to me 
>> at first reading. That being said, in my opinion, this approach adds 
>> potential confusion that is not worth the trouble, since most guests 
>> will not be using AMD vIOMMU at this point. And if they are, they 
>> would also have to be specifically requesting to enable DMA 
>> translation to hit the problem. Unfortunately, guests will always have 
>> the ability of specifying an invalid configuration if they try really 
>> hard (or not hard at all in this case).
>>
> 
> Yep, I should have explained it in details. Sorry about the confusion
> will keep in mind while sending future patches.
> 
> Regards
> Sairaj
> 
>> Alejandro



