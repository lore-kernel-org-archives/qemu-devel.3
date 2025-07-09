Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E6FC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWbQ-0003Ss-L0; Wed, 09 Jul 2025 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZWZs-0000yJ-07
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:19:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZWZp-0000Vg-HU
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:19:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Eloog009688;
 Wed, 9 Jul 2025 15:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=RKV/qN3BRRtyEu48yRkMDebrXOoRKC4ZfoKzLYf5SW8=; b=
 cgOe4suGByoyCJVoMxsnXFxNIUPC1o0bEalbphXtnRWC288wQMmmrhxQu53Gtt3O
 8lmDCxERPo//kn8EkTIfkjBUXYfYmGAxnfAqo6TPPN60JNCHl6f3maMA3eWKNaq4
 vwQ+seS1d3dfzdtMTHrSbqOn7rrw7YccZdKrzj8Suw+oduR8upFGoaiMA1iBW3w8
 cYoz6h4jE7a91nGatsgUQE3YDwblj74oPyaByewPEDuREl20gFZ1D2WwoQqsR+eY
 +N04r217NyjeFqDbRfxVbF/UDBS9xIIDEyGlkeKoKZ/tGtt52wjhKRuH3riilQ5O
 w2cwRitoW0yQcgB5KCuFzA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47stg182uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jul 2025 15:19:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 569F12Dc013551; Wed, 9 Jul 2025 15:19:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgbvfhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jul 2025 15:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vp7W/1Yk1O17ugIXmHCI9Nswq87V/MPwDh8ZnscDCeD9kS66gxAmMS4sdgmz18zzFZxKNYpaOQBGhM+kGmr1fdgb6LFR/CyS/jWDrJ3LX4pV9i+YmVE6zMKPf65XHetQL8XiGbBqIfnek5ijDcXn+Xp3Z0z+DTLHX5gnfNOQp6rJLtSAwxv1FzjIhBZK6HE6+rLpWafxJcXy4NcIQvV5Ss9HwGFA6dshCWrApcrYMJAlETALXfKi2II6jYMdiBTNDkwG6sG2+pTq//SfUmQRRkiq74dkzMQaa0KMIh5McphfvWpyU2Kv2g1HTAftvH3wMqQiYg3/NH/yrYr3anmPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKV/qN3BRRtyEu48yRkMDebrXOoRKC4ZfoKzLYf5SW8=;
 b=aGu4eQ4PV1TwuAjy1U0yapDqUH1J3UM4mEpwpHYL5PJHbyMqJ+41LcAK6123CvnVtt1mnkiN8qrKsWlY8vRC6PWN/rzez8zdnMkE+cts/R37C/uo2xQ4AjLNo1vCrAY/DojhIzA+Xr+DbdYXg15x7sAE5yYtjOAtpR3yUHCz28HaEiFLfLu68rH/saMiOKchBEHpyuxndOGWsT95d3COx/mQMec/+tzef1b5vOUI5Qj0LvEbY7Xok5GhLEEl4YJ+ckjeE1DGUo8eDoGjFEYaWpy2wsjXR63ms5gXdw+DfaFE0nTvyPLyuWImsCXYD2HmyQ1m5venZmbJgTLGlOfKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKV/qN3BRRtyEu48yRkMDebrXOoRKC4ZfoKzLYf5SW8=;
 b=iF8yS3h9WJsYOUOKQ3xcTA+WvrlMvqqVmQ+4bqu6Sge+VqDbB4FtenoNXfc7Dh8wJl1IutP0v+5xrwHRadBTZVt5U7K02XjtYyiaRzBsolyH0Rz8/1GiMEIvEvxwBMQMbXpx2TgjivEujbN7bXVZwmpz11q35j4vKaSrpbxGhUY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 15:19:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 15:19:08 +0000
Message-ID: <ec3dea21-4a80-4563-86ea-d4bab38b7f88@oracle.com>
Date: Wed, 9 Jul 2025 11:19:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] qom: qom-list-getv
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
 <878qkxrc5i.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <878qkxrc5i.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:a03:100::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 884cf9fb-249a-404a-60c5-08ddbefbf308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW5hdUFKQm01Z0hLZm5uUDBaRE1qQ2V6bUhMcmFCSWV4WDhsMlIrRVJ5YWhR?=
 =?utf-8?B?M1hJOXZzeHZWa3NBMnhTc1FMZFlpKzJVNWRaNlJUaEwvL1d0LzhxWkk1L0Fq?=
 =?utf-8?B?TWI1eG16cGJRN09YK0hWN29ZeDVDQlVGa0hyQXYvWCtaUFFwbFNDdXU0eXor?=
 =?utf-8?B?VkU3K0ZOTHNxbjFZMWJjcExobU5NMzRRKytPS2tGWDNRems5NjgwTTlFeGd6?=
 =?utf-8?B?L3diK0FQNGdiczl3dDVYOWZQbEhFb25HTCswNlI2Q0tvMHB6Z1JSS09CUlBX?=
 =?utf-8?B?RFBXejdwM3ZNK3ZGM3E3VExWNFVyMXZwckx1WmYxQ0hWUGJVcjRXMlNkS2lR?=
 =?utf-8?B?cjJPNmhqMGRVNnBYMkc5a2pmNWhodFhMUU9TdUFsbnRoU1lRWlpabG9oWTB3?=
 =?utf-8?B?dmE1WnMzQnJ5TlhpdDFMODdHalFUbnpqY2cxVXZxUUg4d0FmRnJmUDFWT1BO?=
 =?utf-8?B?QTViRWc2L01PdHhndFZ6Nysra2xhZkVZQ1c5WVN0alVDUFF5OHRHVUhXbjcv?=
 =?utf-8?B?dzBzSXRvbVVXeVJqVWhIYU5aMjNXOEVDcUt2dDY0bER2aGt3Zy9GdE9tK3Nn?=
 =?utf-8?B?TmkwTHRqSE5yYytpMWE4Mk14UXRTbjhwWXRlVm9wVkZhdmlVV1k5bi9LREhp?=
 =?utf-8?B?cjRVeXFnNXVLN3BjaC9UWXl5R3lmeW5SbHFtYVcyN2YrR1BEMHRtaGxiMUtF?=
 =?utf-8?B?L0F0U2NqOEdVY0xGWVBacVRNZFIveitRaTJKb3pkdHBLc25zdjI3WmNvTXZo?=
 =?utf-8?B?YkgrK1k0ckt1a2t0cnY5aVdxS2dtM29IYm5CMFlyVFo2emd3Y3EwakN4b0ZY?=
 =?utf-8?B?S0thQXRacU43MkpYWUpENDJlQzB6QlFVU1g2bUk4Znl2ZkFBdGRNMjExQXJX?=
 =?utf-8?B?QWVFNzgwTG9Gb2pvdFVGalp3YUJSd1hvMHNTS2p4R0xaQUpzWk1jaEV2dUFB?=
 =?utf-8?B?TnJJaldjV2xEeUJ6SDFnQjBSMVRNZWNYN0NDNnlOdXM3NHZCK2x1Sk51QjhO?=
 =?utf-8?B?SUNVbGwzenFMWTl6QlFHVUdWNDgwOEdIekErM21wVnpvVk1TSFpPREVGWXdY?=
 =?utf-8?B?bS9WSFV3NUVwNGc1RDUxeUZicldOU0NlVlVhazdpanZjUVBaVGZ2SC9xNE55?=
 =?utf-8?B?K0gwZkt3UTZ5SnpaYmFsaGhWWXJvSnBMNTYyWERjcWJ2RjhucC8wTWFHVFVK?=
 =?utf-8?B?b0NTTkNNdWJuMHZGazhLaDdmY3FyRGpObzRqTTJGTXlma1JQRjJzOG1seU1G?=
 =?utf-8?B?V0RyNzJJZ3NFdUw0WDRTa0RPZmN4VnR2M2FDU2tLaFZyWHltd3hBUkRQMGZh?=
 =?utf-8?B?M0JNdTcvU3hSd1Zpc1M1R3N6S3hVckNqNWFzTTZvUy9veGJScTdEZlRQcDRM?=
 =?utf-8?B?bVN2TlBaRVcyelVtYXpEbklwUlBvUUUrbjF6cUZtcERkL3l6MTdXemFaQzVZ?=
 =?utf-8?B?RHl3NTBCSnUvbk9uYTNpVkYvSk1tdTM0U2FkVkhNNnBwdUtwTVJIaWk2cnR2?=
 =?utf-8?B?S0l1NlBubjFDZGpXdWRpQ1ZUTVd4eE85Zlk3b05mdXQ2ZjJNWkwwc3VQdng0?=
 =?utf-8?B?YWZEN0djRFI1ci9QaU10RXNIbzhFM1lDYnV4cUhUTWNtakp5TWVkNVlrN1p5?=
 =?utf-8?B?NjlSL1lsbkExdEJtMyt0SkR5Y3Y1aE0rL3cyQWpYdHNCWkhreExIUFM4RThy?=
 =?utf-8?B?NUF6ZmRTVzZlSWpVdE9tVGJLZE5salBteUVPVS85eWJPd0MxOXVHYm9OSkNh?=
 =?utf-8?B?Tkxzek5uRXhlSVczeG9HRXpqbWNMTTF1ZWtQTHNtSll3VjlhRzRpUktiRmZz?=
 =?utf-8?B?R1lDbEhxWVhMLzFkN3EzWHhacGRnMEhjR1V0UlNTaWI5RjZtMXlUMXcrUmQ1?=
 =?utf-8?B?UWl2Q0NzV0hQNlRIYTNHWXVlak40Zzd3RGc5a3pqZ3VMUzlTNDJCNTFyV1N0?=
 =?utf-8?Q?1+CjnEJGjP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy84WEJTTGovOUNvanQybFA1eENiV1Z2K0pRUW12OFkxam9kWVVhKzhUQXZz?=
 =?utf-8?B?ZEIzbEVIa2RSN2dRKzJpUGtCRUY4TTZtU1JWKzJ0SVlJWi8wVUw3MnlzcUdL?=
 =?utf-8?B?SUhLdzFJV1BVRzRLOGh2dERxbitkazZrbWp2a0JqcEdVZWM1cE5RYzRLYlBH?=
 =?utf-8?B?bkNYT05OamdKTW5Lcyt1WjNpeHBZcktwVUJheXFSYWplYnlsMTZRblBXZGtS?=
 =?utf-8?B?eUlDQ3cvMUI2Q2ltUTBEMW93ek16cFRKQlZPM3dYdlR4TXRIcE0zZjZUYlVq?=
 =?utf-8?B?OEN2NjM3WE5hRENXdFNsU2t3UGQrNzBGdzYrNDVHcFJ2VG96akxkZ1oxVENj?=
 =?utf-8?B?eHdSZmdrdWpYb1FhanFWUWlHU1lWeHNTSVZiek5yODFseDdJM3NnTHVFZERS?=
 =?utf-8?B?SnJTUWRqeEZEUzlIejFZYS9nZk52dXc2akRpQ2lzVm9iTnRrWUJqYXZLOFJX?=
 =?utf-8?B?c0F0MlRrZ2ZPRzc5eUlkMGxSK1pyN1dwWjFVeVUycGU0bjg4VGlneU9Wek8y?=
 =?utf-8?B?eGgrS0hISkJuUzJaMnpLNlVSSlNpVUF1bnVMZHQ2cjRCbHdWTGdHdVduWnUw?=
 =?utf-8?B?Y2VlVTFPZ3k5UFJMblQxOVVIRE5td096YkVsUE1wR2hqYWI1aWh5cURPUWZ6?=
 =?utf-8?B?UVJqUWtINFJ2NkhTdkx2ZWExdUR1dytDQ3pwNEs1b2lsbERTNUxubW5pU0Vw?=
 =?utf-8?B?bVYvczZUSUhyZFpLUlBmc2JtdHRMY2FLN09iS3JpVU9qZll0UXVVMlo2cUVa?=
 =?utf-8?B?amhyOFZNS1A4NzdHcGtCempzOTk1Zmw4YmFTUGJ4aG13SjZKTDVhWklGWTNZ?=
 =?utf-8?B?bDljUUlKMi9BT1dtazFTUUk3R0tpS0tYRG9ZQnlWUE1abmE5dkwyd01JUkpB?=
 =?utf-8?B?eVFlV2txNXpqK0JjdG9SYzQvbjk2NEgvelBGMEJUOGFWbmRpZ29yczVHVTF4?=
 =?utf-8?B?alBrM0FXRGhCZVVJZlgvelJoTE5rSDZ3WHI0eE9MTDcyS2Z1SmcvNng2bTJx?=
 =?utf-8?B?dzJYQW5NUmxxODlyYUkvb0V1dTBrMFhFWmRuT2hNL2xJdVNndTBWdTRNZTBl?=
 =?utf-8?B?d3BuS1A1TTVmQkYzWDN3OWd0MlhIV3lLczg0UklIZy8xSmEvYWRvbUszMW9u?=
 =?utf-8?B?Y0NzWFZYQVdMNVpSUFV3Zll1bGxxWjZFN2pHaUFpNmNvSmFxVEdrS0hsYXdK?=
 =?utf-8?B?MHJGSWxtdzI0YUNYdzVCS0xYZU5KNE4yNDhaNHp3SlI1dWprOUpJM2dPTWVs?=
 =?utf-8?B?d0o5MTlHRGxCQThLS1U5cDk1RmFza3lkNDZRdXR0Vm16bFFMVHM3SVJENmVp?=
 =?utf-8?B?NnJUL2RzZVBSZnVsdW80anN2Y21ZOHo2RjFNSkhiTmJRUVIrTGFmMWNpSmRP?=
 =?utf-8?B?S2Jpb3U3M0dkNjFHenplTlBGSkVGL3UrVWRTL25vZWVoVWZBMUFjMWltRzJB?=
 =?utf-8?B?a2NldVFZbmNtcVcwbnBjS1llTStvVXFwOWdPTXV1eEJhalp5QzlmZkx3WTlx?=
 =?utf-8?B?dG1OUDlKVGdhblhtalRBU05YaXJrQ3lGUUk0Q1Y1QzhjdmxhK3RnR25LL3Mz?=
 =?utf-8?B?WE1sQVRVSlZBR1pmNmZ3MTBnQnRMcjRPM1hRTlR4M3hJYS9CR3ppMWE5MDZw?=
 =?utf-8?B?TUp6L0RKUHZPVGxjWmxaMGJmeTgwMjVDTklteFpjbHQ5N3liR2pXYmZTZDgx?=
 =?utf-8?B?aC9lZmR5QVRjS091cXU3aUNPZTZwQkdTVnMzNkhUYTg2MlhScmd3TWJjWkNZ?=
 =?utf-8?B?OW4vY0hSYXRSbnJwbzdDdHhlK3FmZ1NjK2h6SVU2cnIxWHZEOUlqV3pNRzRq?=
 =?utf-8?B?NHQ1bXRydnRkYkw3czZlZmVsdktSMk1LSU52VXRnK2l0WHljU3NMcys0OWta?=
 =?utf-8?B?N0MxejhMQ3N0d2lseHplYndMdHB5SFJIdTBtOUVza3pRR3Q2WE0yNFV4cXBO?=
 =?utf-8?B?K2VrdERCV01FTDFJNU1zMndCVVllZkFZMzdCdEljL01FVjhWWDRzS0Jldm8v?=
 =?utf-8?B?RGE2L2JwNWlFdysrZ0puU1JyTjRoSUZlVkI5QUt3RVo0eTFTVnB5QXZsOHU2?=
 =?utf-8?B?bGlZYmErUWJoZGp6aHZ3THN5am1qRGI0eXppcVd0eTF2MFg3ZUpKcGV6VnMx?=
 =?utf-8?B?TzJFNUE1YnlOUk5zN1JEMEZ5OHUxKzJXdC9aZldDbVVvWTlZVElnVC9XSnNK?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3LbJz45A32kwbLNym0IQO+DDB0ddX8fT8fHMjcgHpQREzJELCN7D73xc90jAU5JHQ0wEcggGaNuiUQ82D4tD6WxU6qVUv9D/4suknygGLD8JsN2Z/Z11DNrkwHNseliOq77dHwfpzDMtXnphrfVka3jI8kOPRIU8EufqIBHimJW7c+PU9Aqs+pKEvqi8JV2c85yz9raG+Rd7KAq4AeQq+3LZ8JOT/L9JCp+3oblJ3roJgpKuFKqu9YXbBAS73ayxCnvMxkLp55v/VbbFZhJwWLopD4eBQw5Qc+bFnsxHg/gfmTawl5GZiEU/5TLnyfM0N41BSxQ39zTSrcZHOrkciUmoye5kA3JxBOJ5bpmdhQBBgCDiNhCEDTTmnU7EggaP3VjhUlLOD+JUVpLE15bbj+3IPOXKtZOY31Lggp18lvQU0mpCb3tN6udhFPdy1ANrkmnQ7EBlNwbmoOXofnN+8QhyI6BhoAQjwkIA9ayWydCC9ItAN3tWIP602v14QL+kN+1LtkqP8BhRDossvIk7Wwk/sA70Yeeb1OpknACw4nlNnSqEmmd919qKv8n2r7fGQVo0fT89r8+V6oaL2gSIbxHVXKzsAWfAO5ku13k5H48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884cf9fb-249a-404a-60c5-08ddbefbf308
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:19:08.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/YNneN8tmgkX9HLhXHelyu+bjBVukdXb4xbWMCmQBBXf+FBUeCswT8CoXobOOJqbrE5H2uhdQqvA3ePNwkRX/uz0ep2227R/VAjPCn1178=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090138
X-Authority-Analysis: v=2.4 cv=b8yy4sGx c=1 sm=1 tr=0 ts=686e8871 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PmYxQZ2rMpVNhtnSXOsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13565
X-Proofpoint-GUID: yPGwjNMwzNiZYf1tqwcT8tXlBaqVDaGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzOCBTYWx0ZWRfX3fjCufSLo7+3
 MAemcMaLy32BhoQkcmBcXhG9IflEC3VbbjSdQ6LPf3KT0Odf53tmcDw6rUh4f+pWGzc56O+qIe5
 g0Sl0jR1SFRRSb3dvgmSGFfl/l4oVsnI4oxi3T/ARiTSBeIRoLJ3e0KniBRgouBtoUbV/G65HER
 IZjyAOJXyJBunrWYLosFn20+LFuh8fkjzHBTXnlMmcAASV9xSEkJVCoq8oa0RwE3+IKSpX+PpJY
 UmSCoLp8m2MZ0/bvyIvV7wedF34Hn2T2d0hxpXdlLdl94/OWqNujbXGMbQbT7gN4HOb9RdeVDi9
 WvUa2tBbkUcFPv1YPOxlJFKC9gpviifkWWL8xJoBriH6lTGaa0VRKrABuy5ppBeTi27B+hrHaMn
 veVvNGC43FwlA5ZvMBlYrIttB/ePe+ActV5csCoSj0pCeraXhtZy67sPi0ssKxuT8gkyIdnG
X-Proofpoint-ORIG-GUID: yPGwjNMwzNiZYf1tqwcT8tXlBaqVDaGA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/9/2025 4:39 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define the qom-list-getv command, which fetches all the properties and
>> values for a list of paths.  This is faster than qom-tree-get when
>> fetching a subset of the QOM tree.  See qom.json for details.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> You cover letter explains *why* we want this.  Please include the
> relevant parts here, so the rationale gets captured in git.

Sure, and I forgot to delete the reference to qom-tree-get:

   Define the qom-list-get command, which fetches all the properties and
   values for a list of paths.  This is faster than qom-list plus qom-get,
   especially when fetching a large subset of the QOM tree.  Some managers
   do so when starting a new VM, and this cost can be a substantial fraction
   of start up time.

>> ---
>>   qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 103 insertions(+)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index b133b06..c16c2dd 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -46,6 +46,34 @@
>>               '*default-value': 'any' } }
>>   
>>   ##
>> +# @ObjectPropertyValue:
>> +#
>> +# @name: the name of the property
>> +#
>> +# @type: the type of the property, as described in @ObjectPropertyInfo
>> +#
>> +# @value: the value of the property.  Absent when the property cannot
>> +#     be read.
> 
> Best to consistently end the descriptions with a period.

OK.

The majority of short descriptions in this file do not end with a period,
so I inferred that was the recommended style.

>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectPropertyValue',
>> +  'data': { 'name': 'str',
>> +            'type': 'str',
>> +            '*value': 'any' } }
>> +
>> +##
>> +# @ObjectPropertiesValues:
>> +#
>> +# @properties: a list of properties.
>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectPropertiesValues',
>> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
>> +
>> +
>> +##
>>   # @qom-list:
>>   #
>>   # This command will list any properties of a object given a path in
>> @@ -126,6 +154,28 @@
>>     'allow-preconfig': true }
>>   
>>   ##
>> +# @qom-list-getv:
>> +#
>> +# List properties and their values for each object path in the input
>> +# list.
>> +#
>> +# @paths: The absolute or partial path for each object, as described
>> +#     in @qom-get
> 
> John Snow's "[PATCH 00/18] QAPI: add cross-references to qapi docs"
> rewrites things so they become links in generated HTML.  @qom-get
> beccomes `qom-get`.  Please use `qom-get` to avoid the semantic
> conflict.

OK.  I see his pending changes in this file.

>> +#
>> +# Errors:
>> +#     - If any path is not valid or is ambiguous
>> +#
>> +# Returns: A list of @ObjectPropertiesValues.  Each element contains
>> +#     the properties of the corresponding element in @paths.
> 
> I understand you patterned this after qom-get.  It comes out like
> 
>     Return:
>        "[""ObjectPropertiesValues""]" -- A list of
>        "ObjectPropertiesValues".  Each element contains the properties
>        of the corresponding element in "paths".
> 
> in the generated manual.  'A list of "ObjectPropertiesValues"' is
> redundant.  John Snow's "[PATCH v5 4/4] qapi: rephrase return docs to
> avoid type name" cleans up existing instances, including qom-get.
> 
> Perhaps something like "A list where each element contains information
> on the properties of the object referenced by the corresponding element
> in @paths."  Or shorter: "A list where each element is the result for
> the corresponding element of @paths".

OK, I'll use the latter.

>> +#
>> +# Since 10.1
>> +##
>> +{ 'command': 'qom-list-getv',
>> +  'data': { 'paths': [ 'str' ] },
>> +  'returns': [ 'ObjectPropertiesValues' ],
>> +  'allow-preconfig': true }
>> +
>> +##
>>   # @qom-set:
>>   #
>>   # This command will set a property from a object model path.
> 
> The schema looks good.  Not entirely happy with the names.  Naming is
> hard!  Type names are not part of the interface, so let's not worry
> about them too much.  The command name will be set in stone, though.
> 
> When you named the command qom-list-getv, you also had qom-list-get.
> qom-list-get works on a single path, and -getv on multiple paths.  The
> "v" suffix feels like a natural choice among people used to C.  But does
> it make sense without its buddy?
> 
> How do you feel about calling it qom-list-get?  qom-get-many?  Other
> ideas?

qom-list-get is good, as long as we never add the single-path version of the
call.  No reason to IMO.

In the cover letter I will rename the existing qom-list-get to qom-list-get-one
for the purpose of describing the experiments.

> 
>> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> 
> [...]
> 
> The C code looks good to me.

Cool.

- Steve



