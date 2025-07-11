Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5F8C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFky-0003nL-Gn; Fri, 11 Jul 2025 11:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFeg-0002q0-MJ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:27:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFef-0005eH-1n
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:27:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDRBg1004559;
 Fri, 11 Jul 2025 15:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6bLsAAq8z3ZXK40LQH64P4u1xPumG3KkjQf/3r5LDoQ=; b=
 FM8Twfuo14PfV0AmgP3a02699fo8xPIUNhjLofxEjSZ3uUFK1991z/CZwEMRkgHF
 t7b1cvo3cjcDAxgUr0AhO5s8mCtbHy1kE7Tz8glACl/i5AzuBnxpqhXKsUt4w5en
 D6XCwOvxKdtYYgj77eaznRpAZsTNmSspM3mzMsQ8Wq/gx4UKGGgLxVBBnGbO/2dD
 9Cm0a7SGZ7uN+nWfOf34uDHoUWflAbRB9loRoDF/88swes9BmIDHINo/8IJbWaa9
 2ydm1K9ZqQZr8RX8NhXBSagXGR25v8NZ42ry4ofCzQnMNRdFBjCsSY4OCLD69nzV
 qUj9enzJ4nnSgxhj8t7T5g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u3gk87x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:27:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BET6sU027323; Fri, 11 Jul 2025 15:27:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgdpr1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXRjndRtf8cGFepuGYBvjpLQ+aEL+M+TRhDfQvjRrfnw0NLh33GIn2OZXaxDCqe4XvVooDYBSrMeRrRtQqW/R9NqpHoQKbNzYXVJGD5SUD7g6dIujM2L/sMyDxKF/RqwygXX/nY3w2OZqwdaWCo8CL0uHJ+NZVpdv/X1GBEyySOlLliO/djYDrVBYG8uJ97CAbeuodgxAXZFQxW9qNZlqIRNddgb7cQSMnEbWwlRhtrMGX2VN8MIxkQKhjOhKKEZRTCEyc13d9qMWCFJgwN5cz+OIeUezVFOkbiPEGN7Et4C1vgo+LlFL+UUhkktvDlNDd5Dk0IRbDt5yLnBKELgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bLsAAq8z3ZXK40LQH64P4u1xPumG3KkjQf/3r5LDoQ=;
 b=coFdbuCAdChkiiT2MSlkOufkwoM8Hlnrp/cTGoMHTyiiYiDispWIBDxVl8BoAjwDV+5jNcWehC3jj/3kRBnmRodJuhJGrST8zVhYziaNmLODUjvuCfJtvt1pY57OcA2IDfMEi8grMJuLr/6qSi3OfqZSZP80tVkhwsl2gFcs80URBbe+jfp9xTdOB3L7Zx/svYEXTDJyg11/tRKN8CM2Ii/fguC7T2u7KYDJaB8dhG/P9dhj5fsbeLdJlziqoeDzZR9V+tlrb3GcqpBsvvZ73GLnvdTr06kFYK4b0m4R1pLn7mwVHUN1xubkJd5LxsYk6fiwo0QZUzTkX3hcyRQy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bLsAAq8z3ZXK40LQH64P4u1xPumG3KkjQf/3r5LDoQ=;
 b=AmxfcynswNUrtLxE+C1Itpf8lf6cuAhI7yKU203Lakom1bm1SGujCTffkUL9VlsHKT1mSzaYtvrtcFLHlAiPJwV7C1UUHZGyOciOdul32kVY1Nwu1hOc/v9/BrBqGg+ZSL30BXj7Er0DghyQqhWKJaOJ8ZjoXKkbpYTeuD605a8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Fri, 11 Jul
 2025 15:27:08 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 15:27:07 +0000
Message-ID: <333c0d2a-4a89-4a76-a284-d23cbae30108@oracle.com>
Date: Fri, 11 Jul 2025 11:27:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/3] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <87bjpqvkbj.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87bjpqvkbj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8cefdb-014b-4f6a-0ff7-08ddc08f655f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2kvQyszSlFkaTlJd2Z2UHVodFVKYjZwSGFFQWtjWXozTmZLb25LUUxpd25B?=
 =?utf-8?B?ZjdrNy9EREdLOVE4M20yd2lDckNEVHZ0blhoYUZBVFV6RFN5NzJMcmtraUhH?=
 =?utf-8?B?U0hhaVkyOXpUTTdFQmFYc25qV20xSG1XSmdBRzBKeE53RzEyMHZuMU9mdG8r?=
 =?utf-8?B?emh4WENSOFUyZWZFcm9ZM3AveTJTSHpGOVAwUTBoaGhpMkhycUs0M3Vtc2tT?=
 =?utf-8?B?Qk9QeURDVVZjZlFoU0haRGRzWTZrTWlQV01wVUVJV2VQd1ZLZ3ZPakdpdkdK?=
 =?utf-8?B?K1Q3SmFXN0lRRFpLdzF5UzI5MWVtU1RKNExQaTZQM3dYamdxL2lhTW8vMnNH?=
 =?utf-8?B?ZUZrYzAyR1ZZbGR6R1pOYWNkWVUrZDh2a0JSN21ydEluVnFQZlB1bGVDeXFG?=
 =?utf-8?B?UUpWSmlQYW9YdFNNZjBCRGExQWY3QmFDaWJRd2ZzdCtKbUl1U1o2aGliY3Fj?=
 =?utf-8?B?dDFiME14alZyeXdUYXpaVUFWcElEVnZwM3FYQXZadjJzQU5nY09TT3c1WGtw?=
 =?utf-8?B?K2IvclJZT05VME1jbjVMcmtFM0gxUlREQ3c5cW5zV2pJcVk1OVR6di9UeG8x?=
 =?utf-8?B?SCs5VkxYY0h3Q1I2VTNsM2J4QnQ3M3ZXWlI2UDJJUUV5Y2trM0YyQlpPZHph?=
 =?utf-8?B?NUxrazRiQUJ5WkphcCtCbzE2REk3S3hMclZ4akdjNDRjZ1loTjJ2NWhQUHl1?=
 =?utf-8?B?QVN2NWo0SFRmanZLNXB3MHpQWnFMNllRRS9PVTJIRm9aeE1MOFdSeUNlYkRw?=
 =?utf-8?B?dHFSNXFITXJzRkh6WFFBNnBzSmswdlh3SjJ3RXkvRWRGbWpiNnBrS3pLckZu?=
 =?utf-8?B?czF6cExtVjhGUWpJSU1mRzlZdVVoK1c2dTdFT2xPZ3VjSWlIYXNKN2dxNnBP?=
 =?utf-8?B?RmdWVXdwVEY2dlVJenhmOWFDb29sd3dGclZPU2VOYU9qTWl3U08wN3NZMzFu?=
 =?utf-8?B?bDh6MHZLT0RpeU01ak9OYlhPZS9zS0w1RmtUWTUra01kWUJZT1hBNURWN09s?=
 =?utf-8?B?c2F5QzZMT0p2R2YvT0VwZDk5dzByL1liN0w0WkdTNEdFQjdVM1owRllwMGVk?=
 =?utf-8?B?c3YvMHRTZ3JJUlJNVmN2UlBYZzVERmpIZURMUlJtY1ZpRnhGeWQrL2s0NVBx?=
 =?utf-8?B?Z1ZWY1J6Z0JPUnlwaUlDSmY2Z3BTUGNTZjNSMW16Ry9FNlY2TWwrTnVwQ2dV?=
 =?utf-8?B?eUlWQmc2RDh5WmwwaWNFOEQyVlhyR2d0QlJNNGgya1pzUVNZUjlJSTVOa28z?=
 =?utf-8?B?YTRmN0txbW52MXd3TlhCK0VsRnR5RStIa1NGMStOUFhpaHBnUVRZc3dvQUxw?=
 =?utf-8?B?TFcwN3o0QmRQREJER0sxYjRZNGJzZUhOVFM1SFlubCticWdZRUVYTXBMUzZh?=
 =?utf-8?B?ZjRRd3V0QVF0UTRHT2c2c1hwQ2NZRE1Bc3JsOXYrNkpiSzJnSC8xV1R0RUhF?=
 =?utf-8?B?ZUhRVmJJTzRWcGlDSk5aUnFlOXczblYrclNXTGZaVS9CaENpN2xjbFNRaHcr?=
 =?utf-8?B?T1Zxc0l2WEE3RnFBWUFBNmdMMnl6QW0rN3VXdHUzcVUvR3dodSszUlRFTnYr?=
 =?utf-8?B?YVRET0NpYzQvR3JHVFYxazFIRW5Ga0dBZ01TaEtXQW96Z0J5eWR6ZWdNbCtF?=
 =?utf-8?B?UG1UQmhnQnJ3YzQvcjAwbWFqSWJXYVJuVmVDak5YdmpiOWtsc1ZZM2NGeXJn?=
 =?utf-8?B?OG8wNHVVanpVWGd6c3Z4VU84WG5Bb1lQaWtoaVQxSjg3NS9nMjlsbGhmMGIr?=
 =?utf-8?B?WkVOQWRUS1JDTUsrUmQxZzFpSERsaVQ3QjhZek9Xb05USzlVb3ZVdDQvOUYr?=
 =?utf-8?B?WTNkeXFjZ2R0eHEvTXV2bWFiaTA0QWR0dlAxSnV1dFBzaS9NdzZLeEpXeVpO?=
 =?utf-8?B?U1h4NnRySUlHdE9aQndsMWhBUi95NkxBdWZBeitIbjdjeTNVb0I0ZzQvaGwx?=
 =?utf-8?Q?iXBmE2xWKA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STViQ0NCQnRUbmdsNmZDK1N3SkJ6bzZ6SEUxNUh5STN0WDBCVGdTVDc2SFRx?=
 =?utf-8?B?ZXRMOG10V29YNUtjNEZDVExsR0c3YTVXYURXeVc3Tm9RZW1yMTBjOVNLVHVr?=
 =?utf-8?B?R0w4cUxOSVhCZE9BdVcvamg0YnFsdmVJakZmTnJsL053aWNwVkNnK0pYWENP?=
 =?utf-8?B?RklqR2JVSDEvR3Y4blJjVFdRSm1VVFYwRHd6cVQrK0czWWZRQTQ1Mmg3MHZq?=
 =?utf-8?B?bU5uS1B5NWEwRVFFQktsdUUzN0h3aWducmJCS3djTmhZVzFHVk4vRkhXQ3Jy?=
 =?utf-8?B?VHc4RTFUd0VOWW9meEZqNnVhYTVQZkpNbzFmVUM5T1FMdFE2QnlPb2w3UzBS?=
 =?utf-8?B?MlMxbWVKRUVNY0RuTjZCbnBJemlZR3ZLK2tyR3N5VzV5S1QwZ0ZhQXIrakxT?=
 =?utf-8?B?alhRUUhPVmowSGNOWDBVZnBpNGFYajJhSlMraHk4MHFncUlubmR1Sm5kck1K?=
 =?utf-8?B?Ukh0LzFDTytxeVYxWjVTaldzVThHMWNPVldRbFoxSThsNUJqT28yTllRWTYr?=
 =?utf-8?B?c0JtOTdUaEJPclluK2EyanNRemdNU0s5anFReFJaQjB4OEZBRFdzSldxek9X?=
 =?utf-8?B?ZUdxT3ZXZzFMZElMRUFUY2Nad0JGSFc5Y0IxU3lWOStLRkFOUXd2Zm5kMGxi?=
 =?utf-8?B?UE8xWWNpZlBUcGZaN3JxQzVPVWhIQmJQbTlFWnVmakZLQWNPTmYxUjhTL0tT?=
 =?utf-8?B?UG9Id25wMitseWNvSFRER0c0elhJRXhlMVRueExQWmZEUk1Iam9LSVYwdUZh?=
 =?utf-8?B?ZUFoQXI3SDVneWd2RzRESVY4OFZLaTAxZHdkVjU5Q0JPMGFIcnlHZVhLa1ZG?=
 =?utf-8?B?NlgvT3UxOTkyanJKNk53YmV0ZnhvK0lTdjBsRHRaa3JxL0ZWbStXTWtXS0E0?=
 =?utf-8?B?bms4NUdwdjk3TlVkY0hVaHN2eDRQeDlwdlp3YnE4aHF0WCtiekpiVUNNb3Br?=
 =?utf-8?B?NVdqbm9CVm9UN1o2Z2NTR1RxSWh4cnhGQk9GZlRYb1R3OFdVMDlxamFTOTRK?=
 =?utf-8?B?cW1vWUY0OFI3NUtITXRib0N3NmJGSVFYVGN6a3duZyt4K08vek1qbDYzRkE3?=
 =?utf-8?B?ZDB0b3pSUVNtb2R2QXhtVUdib2NhaFZ5K3FzZFovbURjWmExOFZ3UnpQT25j?=
 =?utf-8?B?d1ZaLzFsRDc0cE9GdXQ2UzYyaEJjcVVKQUZnemhhYXFsTkl6M21TaldqWVBx?=
 =?utf-8?B?aXhxK3lGcTllOHkyU3ZGOXBWdDVxOEc4RXNvRWkzVEUvQURTV1FRWHN6NS9p?=
 =?utf-8?B?NFozSk9jSklyenBacFd2dVA0VDVWNTFnL1EyN2NCajVQVkFXTTBEcWphbGJW?=
 =?utf-8?B?OWxCYkxFZFFrOGpBL2xId2t0L1dNSi9PSkFybkRnRmZRNjBuYktydWtWZkRn?=
 =?utf-8?B?ZXJyNnA4TFBFSnAwU2tnSjNEb25PSC9qK0JJT25OV1hLVlc0SWZRTWtwaWRJ?=
 =?utf-8?B?dkZtdi92dHcrRVkwYy9TMG9pTmoyalVWbHpzTVBsRUZLam1SYWppSlFHelIv?=
 =?utf-8?B?cFlGWEowdWpNZmFRaUErVUM2SGRrbEszUjVUayt6UFFGU1lpMFJ5alBVcmp2?=
 =?utf-8?B?ZytUYXNhUml3WENMaXVCWDZUZjZwK1l5YzhEZWdmWlpid3ZqQ0xUbFZNUjRx?=
 =?utf-8?B?VVU1U3FyL28wU29jcWE2dWcxeDd3T0hDSXBxRnlGdWdwbnIwOHpBdjRUOXll?=
 =?utf-8?B?ekZyV3EvQkxUa2YxQk9MMkxaR1ZTV3prT29WWGVjL0tPcHlBQlhVcnBzZ0pC?=
 =?utf-8?B?b3VnTFh0ZGd3SHBUS2tSMTh0QlR6TGlQZDRIVnhHQmtOUzl4dFNKWll6b1F0?=
 =?utf-8?B?a0ZUcnZtMmV4WlBGVysyd256L1ZIdFlWZTRxUXhLWVAxemtLdUg5M0Q0SEwv?=
 =?utf-8?B?SGh2ZGRHMFRsc2wzZzJDbXo2TGJheEpIekdZMDc3Ky94TElPb2lna0JuZlhu?=
 =?utf-8?B?S2dvSVpWYnllUXg3VmttVFB1bjQ1Mzl6TjNBRnF5TzhtNWlQQk9xNkd3SEJT?=
 =?utf-8?B?Tm1iMXZLKzIwSkFwUTFVNnd6QTVhb2R4ZWF2bmZTSjhFY2VEUzA0L0hXS0dQ?=
 =?utf-8?B?VmNVS3R6ZG1rYlF4SGVxSy84aGRjb2RLdnRuZ085ZlBGZjdnUjQzTFI1bzkz?=
 =?utf-8?B?VjRBNjNGWEZGYWJSN2tiR1QwR3lvdzM0d0tpa3NLVmFxWURJbHoyckJmb2Vy?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KxckuvfPBfiFZjeYZQd2LQXwUoGj+Lt0rbOSoX4BMAisljIUgwlxi3ppLKYDKQLcajPdQTJCk+6GuqBlG6lXEO3YO4xzNrTsPaSRdie6uvTJhaFhB3f9RK6mwQ/u8JQ1Qp8sz8QUWbqkkZPKEm2rrZ5Gav7wQyPqSgLFMZ2UkfwBluJ13SRc6sFgDJBWXFrzJl+E7TRPRvvWFSz5uJrxFp9yqIM99+hwHqbAEgB/p9zcyCs3qFLzvKxbxieuSEkV+9niD7Wcj0PI/c0Q4L4Be1Xp65K4nTwdXionPUWsLUup6cOIwrm8IEF7OESgLMduaI9ZgSxDBTvCp7oBS4UTtwSMmX+dhfLxyFy7IxHGVHPGKiU3G8bLt0iK5n+1EWqH77iZuFlUKciRt43nJB3GZn8bSMZEgDeG7pBnHcRZrwGlX4Aiq+Hch97s73JOA5+HzszjS4IQJOP+5/VGCLlWS5gRhhX0e97p0M86a0T+WgOLRSPIkmGe10Mi9UwT5fslaFRfnzhAmX0ef5Qot9WzuqDYRYSIjIL/f6zqrnqpqHUQ/RGxyaMdglbIy0fcgNvBoZ1P65g1IA9J1F2fz2APkNhu8KFEiaZTxq/WiAzZWtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8cefdb-014b-4f6a-0ff7-08ddc08f655f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:27:07.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RQza1n3FxejakJ0syK1lN1ic7WCRdZsdvz9G8lnmlEJpXYrJVPj9Z5v4kXIgEQBWkJDvu3X0CkgvoIddC/0R3rnGz9FGRAwPfcClbrrBls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=952 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110111
X-Proofpoint-ORIG-GUID: rIvVhTqqAymTd0d4kD7hDmvuIB22jH8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMSBTYWx0ZWRfXwjFPJRvUuGxb
 wYrGJHrkQy8e+Qmh1YCKmlP/jjvJms0WLV9M1lR8HoYsrU4NVT578Yw1YyzM01JP+nnCumiNSe5
 NxlwDLrFVPg9yASulcSjTdRcIDYDydKm/YAYCvB/HcGKcXeKt6zt6NnQJVOFh9oK1v4QXnr5qia
 AOCDfwOMhFapNy9m/2XVdj4QrrBH0DXCtI1DxMhty8UJIX1VqtBe6tkiJ4zDIk5Kw3JvSFQT0G6
 P8CUoXrW1g6Kbk701cQk8/XO1WdwGsYw/fN92iSSTPj1y8LYaVGAjvc50EOCJfFYPYvPv+vchKF
 kLNyMAbuZVO5NsXTHj+xtcVrjv7HIQovEuHgv0w1wBnGrXD42LPnuquXF/rYVuE8q9WSwd8ycBE
 XCeA/UEv89REei7z60NBXHnJzMtQJqb4OPaHheoVIOibr6D4+2k8sBsHcIuyk9CPAU3e7CxB
X-Authority-Analysis: v=2.4 cv=eK0TjGp1 c=1 sm=1 tr=0 ts=68712d51 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=f82JQ1oqg7WCr6nrkUsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: rIvVhTqqAymTd0d4kD7hDmvuIB22jH8d
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/11/2025 11:06 AM, Markus Armbruster wrote:
> This feels ready.  Have a look at my (few) comments, and tell me what
> you think.  Happy to apply finishing touches in my tree, without another
> respin.
> 
> Thanks your your patience!

I'll send V5 with the final changes.

Thank you for your time Markus.  The result is more polished due to your
careful review.

- Steve


