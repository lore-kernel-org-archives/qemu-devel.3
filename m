Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94911D10376
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4588-0001tb-Gk; Thu, 24 Oct 2024 17:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4584-0001tG-Sn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:12:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4580-0003C7-4K
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:12:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHmclw018718;
 Thu, 24 Oct 2024 21:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=I+ZT4Z6Rse1GcRnTH7hETrKgCRlYMSJJD/DbRS8Djl8=; b=
 T/RD6CIrvpbZcQL8SUdYYPt6v5PKL3GXsUmw3MdmVYDAyvd9x6/SINulo4fsVFSB
 vwQPMNWPQdLdbL/2E+y0Oyqf/SmkwYC76I1SAyIyfUIZModR+ZfXxFwA3rJ2TF31
 s6TaI6YOLfF5NP4LbezFUtc61Em4l3Rm8JJMIy2l+UYuG49yMD3vbxKDjzemTvIs
 L7R8ZBqhPA641T3Wwwr0bUUY/VB201GkCEHc5qKeI/j4RIMvPk7SeNB3AHyo6mlB
 faytb5KXTmgsQvaEkjnqx72WkVDRHnJ7qVCBAuSy3K0ycFIjSJv+/CbBlFu0J4Ev
 KW0Xx9ixcmS17jBUmFrhcg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5askqf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 21:12:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49OLAh8K018363; Thu, 24 Oct 2024 21:12:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emhmk8ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 21:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfIaL1zJb21veiOPN8Cwl+6uB0rYIhJ0dkRYOpcUDV6Nqfcgz8MoS1Wjl3dAWHI4gD5E0xbpTSchOHaxSxn2zpuSIBiTSH2dKga9T/5BzE0hkySrn4NFpJWX1jY2ngVPR/w8rgidvqLMu8dqymYzptUckW6ahJfDadChR4v8//lk2lDEX6uFabqMMRqjF3K++bsymkQFnr8ixAd4pYF9F4733ZqkMzMsNZ56RuEQ5uTr83rzICsxksduY8YQDQOcQnxUPSW1qTs+3l7IbJygRU8mJS/eSk1URoozHy9OYsqRsXGm1NxAr7T3j9jTp+oI7IqBzeXRr9Lin2ywTY4Otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+ZT4Z6Rse1GcRnTH7hETrKgCRlYMSJJD/DbRS8Djl8=;
 b=ML6sU+Hvsmuevgca90iq7hhNDWaLRgynRkjXoW5Y7BQ7+dkeztUx7ji4TJZ+pvUxNN/rt4OYddmGHaXea6uZsdV/kELKuc5czB6rlTN+lcPaix4E2xzvVaibxzR5640WmMfDJRxEKabnjRwbxqpv5Cr1wXin344HKLRREFHktH2uoQvFj8GDVWJejjYrYHkX4sr7KfirCAWT1aRON1HpM8sQmZ2draa0r2oWR98b2OjvcCmJTPWcYgAMKT0FCU9RWFnixmeXddDKSPRsVeHSyHTrj944AXzowlhMrIMJkB43bj3WiOeyWvcjXB5VYDbEPiwGMqKQ2HDqcL6Ja1qSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+ZT4Z6Rse1GcRnTH7hETrKgCRlYMSJJD/DbRS8Djl8=;
 b=sFbN0cDpCai5/i3HULwTFD/byuqkaLuxFpRuXhCnas/HA91WEbO/6szwYVoj9wfOzYbYWZ5kK63ne09hFq6+Ch1llpcQBT29P9mPaVW42LuP3koq6owLIV/47k+XDs54DuGSHkG2wUAhfyaxJDT/jE44I5+Tv4O4xRSWsT1aIeo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 21:12:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 21:12:07 +0000
Message-ID: <6d626aed-a78f-4dbc-b1c7-111bc42c72dd@oracle.com>
Date: Thu, 24 Oct 2024 17:12:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n> <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n> <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
 <ZwbpQiK7YWKpqHTk@x1n> <198913f5-32de-4771-98dc-02e73c4f0754@oracle.com>
 <ZwhFyOQanyqWqr6I@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwhFyOQanyqWqr6I@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:52f::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a015f82-a417-44f4-e559-08dcf470845c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW9NL3h0WnZiT2lvRWwzYlllS0VEVFI3azIza1BMaG9URFhtaXphUjZiQ3d5?=
 =?utf-8?B?T3RrZlFLT1lhdGlMdlJDemN2ZG9oalp6NUZndTFUUWQwc1hrSFUvN1lUdUtP?=
 =?utf-8?B?Y21nTGFXUXlQcDBaK3U4dlhxNXZoWEZzaFN6OWNCN3hkSW5GcGVNNnZtTjRt?=
 =?utf-8?B?UXZNWURRKzZFbnlNS2hFcGpLQ0daY3UxSVM2V2lJYUdweGZya2RGYVQ3cUlt?=
 =?utf-8?B?eEpTckJhOExpbGR1VGk3OFdPN2FhMEhndXYwQnE1WEhRSmx2empYZ0JOWlBp?=
 =?utf-8?B?ek43YjZDc2IrZlY3NjhtRXp0R1REVHVDS0djenpTQi81WEVMakhXbnNHdHl3?=
 =?utf-8?B?N3lFOGJQUHR3cDJNNTlrQkd5ZFpKanpPQ0lHM0twZkUxemlzdndDZXNjRnpZ?=
 =?utf-8?B?WlYxSE5STC9MelJGczFjZnBoQkJKemtOYXppTE01bFkzSlk2dkV2VW5CeXV0?=
 =?utf-8?B?dnNXUm5wTmovbzhEVmxlVjF4MUt5QnZDY1MzMnE5ZzBIU1FYTmZVR2dhbzZy?=
 =?utf-8?B?czJPZjluczJHWFlCSThLTjZSWXpQQlM2WFBmT25ZSjFxdm9Ic2lYYmh5aTEz?=
 =?utf-8?B?VVJjNUh2dGcrQUZFUUJrNHlVWG1ZOVdkbys4L2tEb3pmNk1qUG5zeE93dDNm?=
 =?utf-8?B?USsvV3RNdnlpTWFINmUrd0pVZmw2MitFcUpRYjBXdWZJc0dQL3RSMXhTVTJl?=
 =?utf-8?B?WFZMSXI1VzZjN041dUs1M0xWMDY1eHpUOE1hWTZ1ZXF4OVNRRW9KNWZDYm1U?=
 =?utf-8?B?cFhQUWx6NWpGVE9qdXQzK093QlRQenJlOTFpaHl5Qm94NVNiYVdkQndiM2xC?=
 =?utf-8?B?WHVXMURzWWpKeWt1S3lmSld0K0NjWHNyZFhPZWVXb09WaS9PeTdmd3JQQS9B?=
 =?utf-8?B?UDhlY244WGlJajBMenY5VG1YN0pIbnppYXVsbXlPNnYrQzhOOTRyNWZ2Q2t0?=
 =?utf-8?B?aUJvOXRHWTBxSk4zWU1HczZ4UG9FcDZQOTdUSEN2S2tjT0hWWXNvdU0rK1h3?=
 =?utf-8?B?S1JCL1ZPamEyaTRiYm5NUFIxdVVFOXl6Ti9rbnRGZkhWQlE2QTVqekRKY0Zn?=
 =?utf-8?B?ZGVvWjF6clNrOEhicmM3MmgxY2srK1pKemNILzNYLzZtZWJnRnkweVc1K3o3?=
 =?utf-8?B?VGNTazFWSlFFajBGcnVJVXdhaEcwOXV6Y253eFNwOGZXTjRHbGxrdTh5NWtT?=
 =?utf-8?B?MnFMbkpRK3l6N25jQWNOYmJvNG1PYUNnYlRmb2xLN1E2R3V4S1MvcGxaWnNn?=
 =?utf-8?B?NVI3TmM4L3RaR0R1dnB6aEluSU9UcS9zTmRHRGluYkkxdkhVaTNCRzI3S25C?=
 =?utf-8?B?bEM2d2diYXVYanVsYnlNbXQrRTN2WjdQc3pGMStZZ1ZtNEVrM2JJeFhMMGFL?=
 =?utf-8?B?L3orZlVROWR4Z2F0bkh0QmtsQmxibyt5bUx0SHk3dEY3bFU0dXEyK0hzdWtU?=
 =?utf-8?B?VklPSlh4VENPaE5TN1VqUktaQkszM2Rmdm9HckdZemlFWlF1QVowalE0NkV0?=
 =?utf-8?B?MjU3MjIyUWE0bklDRHNIOXBkS2ZXMjhhZVVDTG9XcXFsSUZpd3NRM3U4Y0R2?=
 =?utf-8?B?YlRCN1M3VjdvbE93N2lVcVNXczZmQUFtVXZTRkV6VWNhZmdPbGxxbDFIaGlF?=
 =?utf-8?B?T1JtbjJBb2FVajhrVzZlNFBKOW1UMEp1d0EvSVVOdmluSG9NbU8wTUwxbnlk?=
 =?utf-8?B?U290SXJmaGhHdmxON0hnRVNjNmxic3AwZmxaTUl6cVJ2YW1XOVNIY3lyN2to?=
 =?utf-8?Q?LObC298E1cHuKKhcE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azdObU5PcW4xSWowb3RjZ0dIZkt1NUtwOHJqZFhHamMwZmJra2c0eVoyVlQ5?=
 =?utf-8?B?VDNqazNsNFpGMGI2S0FkZVNmWDhBSnl5ZGtRTCtHcUU1WWJjWVh0MS9FSGhh?=
 =?utf-8?B?N1RFdU9ORzVkeW9NeDR5b2x2d2orV0FXdVQ0WFN5UDdvNUVhdWZvTmM1aU12?=
 =?utf-8?B?QkwrNVdpUHlkUWlmaVJadGdkRFVGd1o1Yi9UZHlwckoxek5URjRldjhaRkl6?=
 =?utf-8?B?MTZMUytIQ3hrSjdxV09BKzVYdGluMXV2eml6bytqVG9TYm44anhwZ2ZjdEd3?=
 =?utf-8?B?WW40VEVwSytKdk9QY3pmTUNGbEdOMnlDT08xbmZMYXdEUkUvZkNQdWhGQjR3?=
 =?utf-8?B?Zk9UUU1WVS95QjZ5Nm5xdDA3elBMUDJJUmc2QjNrRFo0SFBRSHBTdWlvb1cv?=
 =?utf-8?B?YUM5ZytlUWtEUUFqbC9paXVER1IrTjZwU1pHK2ZEVkxUc3ZTRXJVVFdJWTl6?=
 =?utf-8?B?cW9VQW5qSVNqUDRsOW1QOUExb0xKUlAwV2FaWisyM3puVUtiRlplZmQ5YjE3?=
 =?utf-8?B?VWs4RWxEV01GVG9KQk1NZGw0ZzJEbXFhZGRlUFJMK0lpNHpSbW11OW1tSFJt?=
 =?utf-8?B?cVRwUE5zS3ZCKzhTQ3BqdUtLNGFVRWpSU0RjekxXWm1LeUtDM3VBRTkzd2pi?=
 =?utf-8?B?ZWZ0ZXkxa2hKcnhBdktBN0VHVTFMdDJrdXcydndIT0I0bGVHaDRzOUhLUE5N?=
 =?utf-8?B?M2RhK2tkUUtvWFo1dE13TFIvOGplWFhmaDd1Z0NUK0hhTUxpbHp2YzJydVZ5?=
 =?utf-8?B?dHhBS3NzWkgyb0hXYjJlNUhsWmZxenJkOE55dkZ5cmE2K2N4a3JJbEtja3Fs?=
 =?utf-8?B?TXdNb2RwSnpPK3ZRbFhjaGZUZWJqS0E2QXNPcGVoSmVZN042Q0FJT0dqQTFB?=
 =?utf-8?B?UnY0Yk1TQlJKdm1tRTVHQ1ZhMnd4YnJoMzhacDBreUZtbEtiL2dFdllSM3Nl?=
 =?utf-8?B?RldtWmZQYTU5TndyL3Axa0FNb0MwMG4xVDRnYlo0d3ZCQmNpeHo3emVucnVO?=
 =?utf-8?B?cFIwWnlGV3F6RldHMmpwV2NyS29FdFU3ZGIyMnpWdk1rSm1PM1FLZ2FHT3ND?=
 =?utf-8?B?R2d6SmVaakFuZFhnNFNqY3FCRDhoby9EOXlqcFJsUlJXWXgyUG1aNmFlUHJQ?=
 =?utf-8?B?TVBPbjNCSXhCYWZrRnVEWXZjelg0MDhUTndlaVBua1JYRlNOVWRIUDlTMGhn?=
 =?utf-8?B?UjBYSy8vbzQ2RDJwUzh1S3JqSGk1UDA5NG1CRkxhQjNBMkpwbHRER1hNTWtq?=
 =?utf-8?B?THo3cGVxQldBZGxjSStkakJYMTU5VnNXMW1vblQxNnVwZXpFNDJMRnRoSW52?=
 =?utf-8?B?ditua0R1MU9hQlB1UkJkRTNScHdCTktsV2xTRlhoemY0dVZDYmpTV2Y0OGYr?=
 =?utf-8?B?L0tQOSsvU3VIN25hSmpOZ2cxS0FZajBPdE9hVi9yS0k5cm1XMEVmb242Wlc5?=
 =?utf-8?B?M1R4QVpaZ2JybStEOXg0ZXRrUWJSbXg3dUxpdVFReFROakdEbWZiSGMrUkRz?=
 =?utf-8?B?d21rWVlPTUtBaFVWWVg5OUMrWXU4NHkvaTlLZHdMRC9ucmNqSURock9EVTlK?=
 =?utf-8?B?dDQvbkhpQzFiemNLWnZmNWFDUW5ob1M1dzRDTWx3WUpzN2RSZk9IYTBodzJY?=
 =?utf-8?B?VVNJZldsM3c0LzQzd2c5Rjg1UURVdUgrcjR1bkUyQ29wODBmRG9CT0QzWnlQ?=
 =?utf-8?B?U0sxOEVza01iVmF5eHVvR0lidTJLb2pOWkh4MHVTTjNHblBrZ2FsNlFOVXdG?=
 =?utf-8?B?RzJrdnQrWDdVb0VCSXlsUnMreTNFRExTWTBCSTJXaWdFL3VHVlJmL1VlVWs5?=
 =?utf-8?B?Um94blllZ0lTM0gyZDRTZTA0OEtZUWtZVWhya0JJRU4xcGltWWkvb0xTNEdP?=
 =?utf-8?B?Z3NNRGNud1cvcm8zdkFWbjFHc05XSnBtc0dHVEg4d1pkNUdad0JmTkp4a2Zz?=
 =?utf-8?B?dzB1cWlrR21xdXpxeERhNGdDWENDd1V5aHVvVjNxUURBRjhUcGxQSmVRWE0r?=
 =?utf-8?B?c3FiVVpMN2IwZURwdDdBWlpnS20rdWNLTjF4aFFVUWhhZzlDR2ZPSmV3dzd4?=
 =?utf-8?B?Mk02Rys2RFNZY1NIbDd0SDNOWVhzeFE0NEZzeis3N1BDeHFKMW5CVXZVZy9V?=
 =?utf-8?B?NEwrWjJEbXRiQnNWMFhsMGllYXBlYzZ6VHpQSEtPK0UvRzJpYWN5bWc2MFBj?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 98iqlSezTE7tuEQbtf4QBX8SIgeccVBtT8igzFyT/tTqIdxUo3cvf48JJYHn04gW+KIDcRxaj9/SeiVvPaaWUxQ/MHuamwsVScpjfPNGH2U/l45O8Ml9L3pNJ20jhsOzPW7etJd285R2I/UUVwtioIInA6JLqTYDTxvkn+6ueVQv7vXwSJLRAJ/1prh+4FfE0cN+u8q8fUH1ypc+w94x+de4C7F1MkpfbQ29BGvk2Bx9/fLP2+qAUC+upuZY6aDx3Y6EcQKm9xiCNe1lnq7mti7OPM25qYe/vAiWrbS3X/mjaZxYKk295GCOVc3YFe+dGw3vLxOGUUxTbQ4unbkTWUQFWsSOzCqkGUlfYyIGzp6DmEGFGOKelTmd2LSLQuf4AC//Jr9EnJ57A9FrxTXoOw+gXgErDpoaKS2cBbwm+hw75RupM2pHS58926JrAVH9Ma09qAScnLEtRPnYhfFA/sm9RHRzJmdJUpoLa5JUQq7QtPn9QcXQvQ1L4nUd4ODAvmBgXlVRjKO4IO1p2rkAPszMDX/e/275+cCCvjG0qKjpqQhwQbAHHjvmCwBrr6qWHhSftoosHayRYPE0ab9j33KnZQu95onrwi4OSZZ+eKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a015f82-a417-44f4-e559-08dcf470845c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 21:12:07.5742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jyoeIV+A3D2wr1TWnvA1crBC+/sru+BNtVw2Y6QnZFn06J8EAp1h2jEPAaG2XSnkaIajaV4x2so185E4qN2B8dHUsUpbHTyiIAaqbhxAzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_19,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240172
X-Proofpoint-GUID: fdTJ0UoDSZjpaPpy3ssvieObe0DeG9Dr
X-Proofpoint-ORIG-GUID: fdTJ0UoDSZjpaPpy3ssvieObe0DeG9Dr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/2024 5:23 PM, Peter Xu wrote:
> On Thu, Oct 10, 2024 at 04:06:13PM -0400, Steven Sistare wrote:
>> vhost requires us to stop the vm early:
>>    qmp_migrate
>>      stop vm
>>      migration_call_notifiers MIG_EVENT_PRECOPY_CPR_SETUP
>>        vhost_cpr_notifier
>>          vhost_reset_device - must be after stop vm
>>                             - and before new qemu inits devices
>>        cpr_state_save
>>          unblocks new qemu which inits devices and calls vhost_set_owner
>>
>> Thus config commands must be sent to the target during the guest pause interval :(
> 
> I can understand it needs VM stopped, but it can still happen after
> cpr_save(), am I right (IOW, fd wont change in the notifier)?  I meant
> below sequence:
> 
>    - src: cpr_save(), when running, NONE->SETUP_CPR, all fds synced
> 
>    - [whatever happens..]
> 
>    - src: finally decide to switchover, vm stop
> 
>    - vhost notifier invoked. PS: it doesn't require to be named SETUP_CPR
>      notifiers here, but something else..

The problem is that the first step, cpr_save, causes the dest to finish cpr_load_state
and proceed to initialize devices in qemu_create_late_backends -> net_init_clients.
This calls ioctl VHOST_SET_OWNER which fails because the device is still owned by src qemu.

src qemu releases ownership via VHOST_RESET_OWNER in the vhost notifier.

Thus the guest must be paused while config commands are sent to the target.
We could avoid that with any of:
   * do not issue config commands
   * precreate phase
   * cpr-exec mode
   * only pause if vhost is present.  (eg no pause for vfio).

- Steve

