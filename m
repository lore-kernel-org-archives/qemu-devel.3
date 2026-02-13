Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D88EDF148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqrc-0007vc-II; Fri, 13 Feb 2026 05:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqra-0007tp-O6
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:57:30 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqrZ-0002HD-3v
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:57:30 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7m6as169814; Fri, 13 Feb 2026 02:57:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+DtDdbIM61ylQYLn4168WitY+dXlkxo3rU4Hl07s/
 dU=; b=qkDlEhM7hfoDVeiUrxBVk4EElQAK+iEpOSL/Os6Sew/+euEuQUS14Rf5g
 67iXY3lonqwzkO/P18PtQ0TjjUQh2fiUG0zqqtnECCC8vbcWQ6Nd9BZXoCZRhMxM
 ToYf+qnS7mvu4ql3cmMT2lOAZ97Mje1zQNu4p4IjhE9E+h+3n+RNLUAB6AeJ24QM
 hUTBDwyieQi+I/UzgohUK67BHS1y1u+YUP9+0AfbJVPLHMK1CcIW61Y5w7IVoutz
 dt5Wx7HjNdSQnw9ncL7mXD8PhLV6Jde20rJZxnmk2eL4ZSRHTzMrmwc7abvwftEY
 94cuxvR7J7snkcod2g3BSprA2dOoA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021121.outbound.protection.outlook.com [40.107.208.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9yvvrec3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:57:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzQ1tO9z+SZmluE38n4RW69NARP7C0fXA9hTHrjcuUu9AJTKEykrQmC6OoeUJyhZ4wQy+Ig0agUBDYK1brAoSTsWUzzPIvvnz8KoDFoscl5byoWS8Te69wR6OMX+amdXNFHiFaXpHF6PGFrijDJhIvOjH9SixYZ56TTkPXI3SvOkc2dvAEOLuBD3kOW+z16DV5dfZ8L+2T0jmpgmC7AULPyfHZTSTD2uL9T/TZ6OXcLIy34BvQppD1gXOw7zMohCQrBDVQle0Uh88Cx0ySRVTMgRTUO7aXN2A30WTG5GUzOAFuxdABIJakKJwm0ZGr/LVv2o6IuN11VWXHcgWp9Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DtDdbIM61ylQYLn4168WitY+dXlkxo3rU4Hl07s/dU=;
 b=mopRHeRBE7XiIRCqApkG8lPYUd4QD5/2bkdx3F8Pt4l3JnUFxVMkre72C74q++FDtzyPu60WbWXCU+LI8uqTGIWLTAmlu40ZHKPSaeW3CyAUwbKuDIEzZMCvk9vtdgwQzOhhAgoAMJxLdge245J+AApykZa02mgyM7tbZHYijOUfs2yFykGGwiHlbLPhPOS6xKe3Bzdg4M3x/lAVEsni4i4X+81fgowVDKfUpYWuilB4kDOZrngye9PMz0U7k+spJMwXHpJRGP29hrn6w65jTJr+2IMZl3m8cJLnvZP9d/pRxpAxW0BgKAK4q/oaLSZTJIAc4ZtihguSgv+U3C16Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DtDdbIM61ylQYLn4168WitY+dXlkxo3rU4Hl07s/dU=;
 b=Rb1g8A8+FeAAWLxjv8PK2Ti5eTGcHiiU64f9YDXriwSGbKGTbwbs73+EgKRampAfHtV+Dg5HkisBzXN6fqiKNQ42ZJChQt/+2nhp+Ww/MxYF7dFwFHGaSj2/Mp265tCPsYmF13mZrZMLEmRHjHT2Zwk0nmhU2bIYd26pUX0w4JoFjNENJ7kvxl3lO8UeBfw4CES4ZxAhxq+VIX+zyTVUlFBBE06osibbtKnd9U/Etjy2C8HbRqiA5r/KPq+AdDDlqs19WJ7jLNPv/pAtLjJnxNitpsK637we+jT5Ema/GD+vnElrwyPgfeJEQTXZW3Ql6iJs1fqlib3NysCIUpxotw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9987.namprd02.prod.outlook.com (2603:10b6:610:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Fri, 13 Feb
 2026 10:57:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:57:24 +0000
Message-ID: <06147b18-3de0-483b-9833-b98e4247f4fb@nutanix.com>
Date: Fri, 13 Feb 2026 10:57:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/43] audio/dbus: remove unused AUDIO_CAP macro
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-21-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0379.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b40008-4894-4c46-eb0b-08de6aeeab45
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1BpVHhlZ1E5MkNaOXBJK0NrVjlZQlJDdHF3cnNTb2g0VmpKbU9wVmxDc09K?=
 =?utf-8?B?dUsrWXE2U09WZ2ZjOGMwNVFwOWZ2TzJFYTRnUTl0Z09JRCtEQVhPWk85Szd6?=
 =?utf-8?B?dnlnTkcwbkw5czl6SWZyVDZ4SU1za3RBSDB3WnZOT3ZXakZmVjkraXZUY1Bq?=
 =?utf-8?B?bVZZdk5KOHBxaFRvcU9pejVON2FSSzRsS0VVbS8xNGw1eVlBa0kyNzY5eU9S?=
 =?utf-8?B?SGwvb2swSkVFcXRCUm1uL2JFamxKWm1PY04rSDdIQXFETjZJRHl6YzFuOXJL?=
 =?utf-8?B?cnVmOWkxY2E2UTEyVVFrb21ybVJrQWZJd21PV2crcFpBUVZDSm82L3cyc3dk?=
 =?utf-8?B?c0Z4VVNsU3lZajdXZnpoa0lVdWtCY2FHWjNuUDkyWXJFdGpWWVRvM0swVmQ2?=
 =?utf-8?B?Nm8zK3hpQlZjTWc3MHBDOHc2RXJ1UjlVbXk4WCtOY05XcjRaVUdwTFZJZC85?=
 =?utf-8?B?TE1qdlRaWDRnb1hZUWJiQlByNWtmMzhUVU9adTVwa2VTK0dLVC9YeVVYZWJw?=
 =?utf-8?B?SGgvT2YvNGMyMEY5ZXVKc01QZ0dvVVU3L0VKcXZhaWpodEs3NThhVGRHSTg2?=
 =?utf-8?B?TXYxbjZsdlc3NFpZK3FhZ2hSNURyMmU4WXM3Mkd5OTFRejYzdmE5REhyQzhJ?=
 =?utf-8?B?cjk1RmRSZDl5Kzk0QVZldGw3OTV0bHA2V3paVEFLVG1qSVQzMVUzL1UyVUs0?=
 =?utf-8?B?amRRZVFERHo5K1FYQmRTcW9vL1Vpek1YemN2aDVJdXJpMkh2QnpMWkwvUW1r?=
 =?utf-8?B?anVZb3IweUtXUWhzekNib2FraC9KaGlGYTVQZFpMZXpVKzMzZy9INVRkTk5K?=
 =?utf-8?B?QWN1bEdWQlY0My9TcHNZdUsvRjhjeFhkbWdMVmhFbkFUUWJXUDVrbjAzVVVy?=
 =?utf-8?B?WEt1VW5YeVUvZkVsNmpUMitNQzRnbUZoZUp6UGw3d0hjRnRtN2MzSkw2M25r?=
 =?utf-8?B?VlllWUVDaFFlNXpQdmdIeWNEVDNNZ0pMWnNrdG5uYmZoZ2JaRUNpSU10TFdy?=
 =?utf-8?B?WWdIa2dWMzBPRHV3T0FSdEJnVHFRdFNYQ0ZwUng2RnNrb3lpVlN3dGRPYk9a?=
 =?utf-8?B?WHlpRm53bUhKNFNQd0xyaDIrQnhXNUNsSTBoZnZYWGFTK1lqVHBwNElnWWxP?=
 =?utf-8?B?eGNQUnN2ek53UjkvMVN4aGthaHhUQ2RRcGJhT3daZVFoMFVhdkZqUTBNZEJr?=
 =?utf-8?B?TXhXMWc4SGl2VVU5SDYrdFRyODRIdnN5ZndwaXM4N3JmS2xlWGxlUmpCbE9E?=
 =?utf-8?B?aVFvS2F0NEVrYWZwUzd2TXM0bnJuY1Z0b1lXeGJ5UnZoUnV4N2VjUkNHakwx?=
 =?utf-8?B?YTlVcnRvTlJHazYyUmRaU0NvL3FqNXNqZzNPUHZwaUJyYjBWUUdGVG1mUWhJ?=
 =?utf-8?B?UVFYa3U2ankxYXFOc1JTR2tJWGV1MmhzYzJPL2diWDZGbFM3OXhvZUlhdkxs?=
 =?utf-8?B?Y3p1cmIrRmxWSUIrdU5aQWVVN1ZuQ055ZHVOQWdzeXMxRGZBbEwvclhpSmVB?=
 =?utf-8?B?RGwvT1dPeHBBdmIyMDhQZnE2RldTSTlzVmJ6MkxNa1EzcEpwL0l1M210Vnow?=
 =?utf-8?B?MVAvRlUvcm1SWW1QT1IwYm1ZVkF2TzhPbCs0cVEralpEWkZhQ3JOQ2tmWHIy?=
 =?utf-8?B?M0VZMktVbC9pK2FzOUFVSVZEUlVoY0FpSitjUktDQ2kyY093b0dXUUtiek9m?=
 =?utf-8?B?bXFtU0lnSjVGUGhtNWNqR2s1aW1jVGd6dzczVGlSMFBDVjkwSjQyOXNHbUNp?=
 =?utf-8?B?SkV1cVJUOWxSTlNMMWF1MEJ6RXVpcWZtZVJMUmZvY1dRWHNlYXdCUjZsV1BI?=
 =?utf-8?B?dGI2eUlneXdtQytRekI1WW5mZmlkTlFhemdaTEx1RDFKcHVpa2JvZXRwcW9J?=
 =?utf-8?B?bzFxMDVDRC9BWnhVZ0N3ZW9ISGhQU09WTzFmeVFNNElFRkJKOUkwQmZZSkRO?=
 =?utf-8?B?T2g3QlBpdWxpWFFOVSsyWjBCd2NwL1BUREJuSHFIL01vZ3NsMFRaNm90MndP?=
 =?utf-8?B?L29aUkpjZUxZZi8vZzV6akx4ajJNZGJJUUFtMWJiNkIyWmdCZUhTWUF6bnVK?=
 =?utf-8?B?bytoVXk5TjBYenhUZStRZlg2NjRIUW13OHVwSFJ4ZHZDaGpaY0tBV2RnVkZ3?=
 =?utf-8?Q?tYiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hEcWlRbkJObTFnY0dySzl4UDRMSTFrRnRBU1RRTWt6TnlHak9YMm91Zklt?=
 =?utf-8?B?WU5wdC9kTWlzUWJ6YnA0VitDTm84N1pzTkhyZUdFU2NkL01DTWx2TmZOcWFZ?=
 =?utf-8?B?RWtvUjhobXphV2tWdDJGdjZta1hQc002ZWMxdkpwTjUrMzJYdzNuVmdwc0tw?=
 =?utf-8?B?RThzSG9XcUk4STNJNGloeWx4WjI2WGhMbm1EWjJSOE9xSXZoQWl2UGlHNTZC?=
 =?utf-8?B?c1ZMa1BIbDlIUmlLWHVmVnl1em92bllBTnFUQVJXc3dDNitsUnFVQ0cwMzV3?=
 =?utf-8?B?eWZUVUk0YlZNVTN3cm50UHhIZUI5NWo2WjhhRFpZUUNINVZMNVVEbEZMT2VH?=
 =?utf-8?B?cEZaMit4ZGFsOVhJRks1Z2dFMFZndlduTmZoN3F3enV4MmJ2TTRWN24vY3lN?=
 =?utf-8?B?ODdQNHdWL1QrZmVDT2ZhbGN0MkkwN1NaWXV5TVBWSUpaMW1zaDR2Z2FoQjE5?=
 =?utf-8?B?MjNRZk9HWlZVOXBNekZ5MitTKzh1eHRpSFpiWnJoK2d0TXNqRXJPdXJKczJW?=
 =?utf-8?B?Z2JqNnZBekovakxKa0Mwbml0amNsdFNvZkdnRkNNQWRnajlZU2k2RUMxajVV?=
 =?utf-8?B?c0FOK3BiS1NPV1R0S3owYXJsSUhKb3VHMGJidm9OeDc4OU5Zb1Vqci8wTldX?=
 =?utf-8?B?Qk1xMXFNS1c1dlJBb1lQWXkwVW9WVVJJVTVNNGlyRExLc0NrRTFYUzVQS0h0?=
 =?utf-8?B?aHd0VERpaFBMN2hBMHJqOGZpQmZRMS9ibUVzYVpQaitXZFA4K3RHYVQxODll?=
 =?utf-8?B?d2MxbzlsTmVFSlIzZWppMmhhK3pOdVBkd29VL0xNSzNsQnhsT1RKbnlDTHhQ?=
 =?utf-8?B?dVdNZWhYOENDRndxOFhGSmozeUEvSXZaa1FFNG1TSXZ0Vk9tdk5jWUJCN2NV?=
 =?utf-8?B?dDBFaHZhNm11dldZUE9ZMS9WRHdlSHpmYk43bVV6dlNXSmZQTUtlL3hwT2x4?=
 =?utf-8?B?NW9saU1FaWc1OHcyZTgya254UzVSMmswRERWemg4WlY0Z1B1K1NwVzZzUzhk?=
 =?utf-8?B?QjBGNWJTWE5lTFRUcTRuc0g1QzBYL2hIamNhRkFySUxXcHB4ME1keDVEZTk0?=
 =?utf-8?B?cXhnNkdGT2xFT20wYUczaXpRckY1aUpiR1RrVUtBQjFpL3l1dHpER0kweER5?=
 =?utf-8?B?bWZuNk9Yc2xySUJFQ2VVLy8rTWw5V0Iwbk5DbGI0V1l1OWJxUGRJc0RSL3k1?=
 =?utf-8?B?VzBnMWY0S2l6dSs0MjEyWVdUNUpNUGdmQWRueTFOQ0dyWlNndW0vVlhneFA3?=
 =?utf-8?B?aFZuTkFqZ3Jsc2xQVDh2L1dBeGRuenRuYmtCVng4YTgvRk5lRkJEU3VKYkVK?=
 =?utf-8?B?ZWhqTXVlNnVCL0g4MExFaVhsZFdYMTZ4Vzd1Y2c4cGQzRTIzSE5iSlVHaW91?=
 =?utf-8?B?QVRBTDgvelhHaDBlSjFVR2Z4TGNRcUVUd241N0hSMnNBN1pCZkRsOFVEYkRs?=
 =?utf-8?B?c0FmUmc4ZW1WenJSallrblVYZWFoWm9KeTYydkpyQVgwK2l1ZEpQdkw5T3VG?=
 =?utf-8?B?dGl1OUZMYkFDUjBBMlJrVlVEeVg3akM0N2I0dnNSc3lhcmM3SHYybXBoeTJN?=
 =?utf-8?B?MjFLN1dtYkkvNzlhdnFhUmxyV2RHZm9zd1hBbXUvQU05MWJzU2daSTJDVk93?=
 =?utf-8?B?anNNVmY0NW1URm13YXAvV29Ua2FlN24zb1dKbVdNQjNGT0NEdkt2cnNFbklo?=
 =?utf-8?B?Q29Ub3kyQitLQ0xrTm1qTmNzcUJNMEVWZncweUVXUVJoYkYrTUJaVzVmWGlF?=
 =?utf-8?B?SkcwRDBONlZFWWd5b0lwVGhiOHVCeEVyQ1lVakVCQ1RQazl2TmlQQ0hvSDM3?=
 =?utf-8?B?ejVkemtYdlpPdm9kS3JMcTFFSVZOS3VwNnZBc0xQYTMrUEFBM3o5WU1GWlJ3?=
 =?utf-8?B?NHcwWDFpS0M1cjhQOVlZdjN1SFk3MWNJa0NjdE9sUytaWDArOGhUZnZrbU1R?=
 =?utf-8?B?R2pqNTB5R2hkWHRVbjhqMWZzb1ZZcmxOMEkwcmpKNXR4ZGJVbEVJajQvQnZU?=
 =?utf-8?B?NmxRR1YwUFIzN0JLRlFWUklIMzZyTW85NFkzZWNGOUhKaDZLRGtPZ242WS9t?=
 =?utf-8?B?QlNRVXVTT3Nzd2pvNEdPeVNtbzJXR2hsMVFITDVMdFZsd3Iyd25QaHkwajdz?=
 =?utf-8?B?elp2ZTM0VUovVjg0UDFqY1piZXlINURFWVVlbWIya1hJSGYrQmdmcUY1RDBH?=
 =?utf-8?B?ZUo2d3F1Q2VQb3ZMNWZsNkNhdjYrR0FUV0E5Y2t2YU4rR3ZJNjRyUEc0dlFE?=
 =?utf-8?B?cHdzb05NdUZqZEU0MmJlY0dHekVyUy9yT3RvRCttVGYzVTR0VHFVS01mQ1dp?=
 =?utf-8?B?OXFaT2l4N09lcVphWWZiRFNTSnI1VC95UlNDYlh1alhjOEtjZnU2ay96TS85?=
 =?utf-8?Q?2OSVrbtVKuvfsOHM=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b40008-4894-4c46-eb0b-08de6aeeab45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:57:24.3299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66vsPwiUWo4/tkfko3E4jPg6cUw6xs577iInqBfEQrtFLgpI1JD1h5nd9n5ttuAKtYcnpRLSGClMeAgmaR5w6dMt1HS+VplFQQXKW1E6CZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9987
X-Proofpoint-GUID: 4Pfhz-bxIFb82TXRMyG6OaWVW1DvAEoC
X-Proofpoint-ORIG-GUID: 4Pfhz-bxIFb82TXRMyG6OaWVW1DvAEoC
X-Authority-Analysis: v=2.4 cv=CegFJbrl c=1 sm=1 tr=0 ts=698f0397 cx=c_pps
 a=jMYSYhjavaUERamZK80FfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=6XtqTBZJzmaJ0dneH3sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NCBTYWx0ZWRfX9fW4Z7q79/CV
 6Qf81cpXRt70CnnHQR4lqdqfD1x6EAJUPBoiZPfZPaMTZXFUgFL1T+0CDiQhnbibs09Vt5xpiO3
 egS0YQ9SI31JOy2B45QB6NAwdbzPv++RG6KMxS7r81erfJT8cR0ml6Akj90tUyB3wrMIDcR6fDx
 yNQeG5JD0LoA7bCUBIATb4n4HXGhVFcV7F2IjbE0AjrWRlq6HTgJTR3+O9wykk0ZPtbTKJFfLT6
 qNFwZ+QAOwXxK1Nn7ckPiNo2NOMuIA3wipIvVpN1Ivdle+Bq+k8qoNyrTESwN21qVx/JWhHDqD+
 Ut2Dt51jCdruMzI4C0XmgD0+n/y9dV9ihOHSy/O/YQ+1iT4U/RRwjr0sSvgdFezwkGzIrZ+PnPR
 KU50fSjL2B6snN3epYFj8jfF/yZj7gtFPwaWiB6GZy7fZOc4rl5538bwjZBcCTEQLhaW/+2fpr9
 T/HCLZd6kW7nSlwr3/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The DBus audio backend already uses error_report() for error logging.
> Remove the unused AUDIO_CAP macro which was left over from the old
> logging infrastructure.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dbusaudio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 9d5331b8c47..e284542b2dd 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -36,7 +36,6 @@
>   #include "ui/dbus-display.h"
>   #include "ui/dbus-display1.h"
>   
> -#define AUDIO_CAP "dbus"
>   #include "qemu/audio.h"
>   #include "audio_int.h"
>   #include "trace.h"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


