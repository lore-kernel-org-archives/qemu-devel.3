Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015FCD232E3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Lt-0007HA-VI; Fri, 09 Jan 2026 01:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve6Lo-0007C7-Jm; Fri, 09 Jan 2026 01:52:01 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ve6Ll-0001kA-06; Fri, 09 Jan 2026 01:51:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cttae5S58aWAIIoFfArCm3PBPPfV8ND7kxVVVbqLnrqpYh9TJXE7pMcD6gvfF0YwYOlkAwDsKBGfcAekFWrj6OH+sP+CQrp74SkGm254CED5agv7RCmR37s8v+3VUr3kSZN8iI/0wPZLVWEPfD8NHFrvakowGNDe9/SoE1+ss+FloZ+b6l3+fRExaDwsWJSj7aLmA0BnxJu2ci2TFlEisebHtNByDGJmIyYGdALf40bR0NYGHqlBJBxL/B3RIlEUs8FFTV80hdTnie8RVtLeaaFPYJnOstyPoaHPfyyk4wFEp5BydSjSJczCXydRZeXpLD/k0v4pQa6ZMMWIrfbONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1Ewmu9MSgwuAS6fanMlHsaMfTHDm8Mxm94ZPj7PZBA=;
 b=OrN21s1S2GzDGQYMT/XW/GocIp2o44tdzIPuX/5A/f0iSZ2eDDBHJjLQAhvdlYC1vv0uTqGMl4QqNgIX9LP5do4H4ncnikO0YriADsU/nKRfOb58y46PzkW6vZBQqGR2FYq7vXRSBhLyUofwLpBzIpHgCzb1e3QoS38la9ZqcY+ndnzDlUWvj+mB2ampRufnvhBLKFIBpuYGDNEzfwYka1DcioeGbJoxX1gUvRyXtm9MMxzueuCoP15TZnQzRBfnmHcOhhEQJakBvXt8360jg3G5pEX6V/mPYXsGmvFWouksnGkxY/cmmnM/LMn6JmHtp5XL7VYJgwTYM2M+qCOlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1Ewmu9MSgwuAS6fanMlHsaMfTHDm8Mxm94ZPj7PZBA=;
 b=gcifV8KS+qCsOalspfoZ002QB4J7wnNr6yCdZgNrRUXCWZmGsUMpYVjTi7iX7jSDKPFg5GWELS/Y/rO171AYm1s8pdiBxevfelcLsGgD9FuDeTuKEUKzVgJOHQ0UaizFqJDVOHC5xEzQy+kpYWsNyYsx/mkldc2CfiOFPdfDmnEx2COu8MGIocX97/xZFQeaEloWNZTNTp/FjIv1FAjcZWu4l6z0mFKWIBQP3+egr4XVfpPzwbDTSLLbPhVaqCf1zeFPo4+wh0mtOHeJjkTJCsC22S7yetPD8sPIBxhgS+PoaoFOY6ZG1TPkFAp8KgYpOrDFWdcGnW4Gap/SuA1m7w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5962.apcprd06.prod.outlook.com (2603:1096:101:d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 06:51:50 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 06:51:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 06/19] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH 06/19] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHb2/a6ZdC6p30rN0y/oNhjEpOzC7VEZv/ggAZJalA=
Date: Fri, 9 Jan 2026 06:51:50 +0000
Message-ID: <TYPPR06MB82067001A067746FE05F5734FC82A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-7-komlodi@google.com>
 <TYPPR06MB820699FDFDAC4F1C1D290F64FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB820699FDFDAC4F1C1D290F64FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5962:EE_
x-ms-office365-filtering-correlation-id: 3aa2b400-095a-4093-9187-08de4f4b910f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RG9xSWNJdThHK1A0VE5RUk96MElvU2N2VDVOSE5yWk5uaks3SE0xZEw4QjNK?=
 =?utf-8?B?cmRJOUhBYXdpZ1ZoeEtRbEQ4N0crUFZpbENaclhCcmZ2bE9iZ3dMS3dmSHNy?=
 =?utf-8?B?eFhzZis1cEpNREFJV2s2UXZkTUJTdlMyM1F6eHVBc3l4TGlZaTVvM0phenpm?=
 =?utf-8?B?MERtcVhxaStyTHJlc3ZSRC9zWHF4NnZENEJwcmxVcXpkbm5ZZWdWT091QUh3?=
 =?utf-8?B?aWQxQlc4dzE4Vzc2VDZmRFpiV2ZPK0lscVRORW5VemhoNi9ucjQvci9STG5V?=
 =?utf-8?B?ZSszY3orR2ExOS9sMVdUNkJHT0VUZ2k4K3dXRFRBVFBjZjBLYWFZUVZZMERJ?=
 =?utf-8?B?VzA2ellKUnhGQzVWbjRjS1dkNWxiYVB2aXQ0ci85QnMxSEN3cTVDTmhUeXU1?=
 =?utf-8?B?WXJia0QvUDlzRHVtcVJJZEJDYXM4eGNlNlVadWxrNCsxcEFDVlBJOGRReHlt?=
 =?utf-8?B?V3pCSloyN1cvSHZkcDVTTFlLbzNtSmY5ZnlMVitKVmZCZCthY3FGQkpCaVdi?=
 =?utf-8?B?bE9Jd2dkdTNIWUhEekx5T0RkSlFOOU9lTFI5TFZJWXViRFhMdGs4M3R0OGVV?=
 =?utf-8?B?YkpBeHlxMG9HZVpoZFFoNFFBUXcrZ0c3K0NHRVZaejZYa1JqTmp4OFVRb3Y5?=
 =?utf-8?B?VkE5L1BJMWg5cjM1azUyTytDVHkvYXZiQXhmbEJ6QTIyd0ZmQ2hnSy83UVBm?=
 =?utf-8?B?eW0vOTU1L0xsckJyVVUyVGlNNXhqRkxweGdHYlpqdjNxZnh6SWJKRWZCZmc3?=
 =?utf-8?B?NlVqaE5NbUlUMVFHSFVZc3N2VjBNajY0bFhNMWxxdFpBRDVYQ3ZUNWdxSWJV?=
 =?utf-8?B?NWg3YlhGSnI2N3ZTdnpZRUZUcUJlcGU4c2VmK3FUWSthd0E2cjJBZUZsL3cv?=
 =?utf-8?B?MlJuVWYvbDNrWDlOY0NFa0V0Snd0aU5uRWpabzlqTVROeGFlRmNkSUlQbUlU?=
 =?utf-8?B?eFdSOFpvQlp6N09ueitJM2EvNCs5YTZvVGFkVkVVYWxxemRRVDcxZmE1bzBk?=
 =?utf-8?B?U1R4dWp2ckVhQU9Nb0hIOGxGN1NQSmR0Umovdmk1WWt4YWZ0NDlFRGJxSlB3?=
 =?utf-8?B?aTV3eWZqUk1RSkRienhOSHBNdTJrdk1jMDlXenJ1OXlndkZZMU9QcE9yenlW?=
 =?utf-8?B?Z3dBODljYzR0QXN5emp3KzBRZDhML0E3L2xmczdwSTBoSGJ4VlMwRmxQb2JP?=
 =?utf-8?B?bStuYWp3TXVHdHA2NFZLNjhtM0c4cUdYbXREVWloUGptSEYvT0xqL2x0Z2Fq?=
 =?utf-8?B?SHEwdjZSSFMzcFNyZVpzQ0ovSEc1Ym5PbFFEZ05tTWZWR3IzUUVhOTl5WlIw?=
 =?utf-8?B?RmpKMnhkb0h0TmVDbVdmTHlXYnFBY0pJNS9GNEpHdnFPUFcyVWRsbVBmekZB?=
 =?utf-8?B?dFNyNUxuMVk3VEcxQzhpOGtFUlQ3clE3QWQvZkdtN1hWODRTOTlLeTlWS3pS?=
 =?utf-8?B?WmUwOWhZNVZZMW9lOHp6VW96YjZCTnFJL0tJUHBINWJab0RPM2VNaGlIeE1P?=
 =?utf-8?B?MmNLV1RGZkhYcW1QdHpBaVh5SDJpSSsvWFBYNEdURERqMis0KzA1RkxZRzcy?=
 =?utf-8?B?YjN1UGx0RnBNRU81WUFMTHE5VkZ4alk4bS9LbGd2d2ZnaW5zQ2JLaVJmS1M5?=
 =?utf-8?B?Sk1IRU52MHMwTkN5ei82US9vbDR1UHlTc2V5MDNEd2g1djg2VERENGJqWk1F?=
 =?utf-8?B?TVNNd013V25HOUNQWjYrQWphcTBoS2dleEdYdUNLZTdEYTlnVmxnTWpPTzRs?=
 =?utf-8?B?N2llSE9OTkxNajRXdzBHMVFEREFkRWFNaDFxU1h1YzJWV2Jpc00yTnV3V09H?=
 =?utf-8?B?NDl1cWdBaHRqTWk3S3Q1ays3UXlrRm5XZTdXVWNGcE15STNiUmZVWnpqMklJ?=
 =?utf-8?B?VU9xR0l4N1o0b3Z2NjREL3I3VDdPNmV0SE8xV3lJL21XUnJuSzBhSXpmUm1a?=
 =?utf-8?B?TUxpSmlPR2plMGpWWVpsSkQxUzh1OGtNcEpNY3Rjenphd1NobHROUHJCSkFo?=
 =?utf-8?B?N3lTUTZjZzQ5S1l6OFdvVWdjRjVVMGVpbG1MVlZWdWpWcUNkOUJ6dHF3VktV?=
 =?utf-8?Q?yOZJ9j?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hObEtublQ4VE5PRDd3ZTAvRVVEMElrNU9YbVQrcmtiemJCZUJtaUx1Tkww?=
 =?utf-8?B?TmpYRFd5NktYQWpsZDAxU1l6NFJ3RHJrZnowS0ZCckYzY2ZyUXJVNDRDMXIw?=
 =?utf-8?B?bDhmWFNJa1BpVUhTQmNWR3ZXb2lVQURCcGs0SmI1bU8ranNRdFdNWWVmeXlp?=
 =?utf-8?B?Y2hDb2hpSUQ5L2ZvOG0rUUpwK253QlNIM25TRU1Kc2VuTlNOc0t1TjlNRkw3?=
 =?utf-8?B?TEhOejd1dng4cWE1WXErY3lmK2I3cnMwT3VtQ2FyL29neS96ZzdvMzFyQVZw?=
 =?utf-8?B?bVdmWlF1QUw0UjZQMm1IbVFjTW5NZlprc2IrMlhhQXlwa0MwcUo1djB4WDhI?=
 =?utf-8?B?UFdWRUl4cWxpQjRjcE9jeFc4aWlCeVRNSHRSQ1c1YWZnR0FSUC9hdys4cUp5?=
 =?utf-8?B?c1Z5TGorL0h5eW13LzdsdFdCYzdpM1g5SjlZSjYxWXJaOWE4bzBrRWQySyt6?=
 =?utf-8?B?MUQxN1gxbW5mTlQxUUtzSW5vWkZGSkJodnZ6bFBsdEcvdzVCUjk1NUdINWFl?=
 =?utf-8?B?VFE0QUUwdWFieXJmN25XWEtUQTN2blcrSjR4Z1RPclpqcEZsbXBYOUQxZGQ5?=
 =?utf-8?B?WHVvQTkyeGI0RGlHNG44cEE0SlJwRy94WUo0SEZnYVBRUVVjMDVrbERkdVRO?=
 =?utf-8?B?eUh3VUErbDNiTmcrMGNieVkxd1hZWTU2Q0huOUswQWhKSkFyajdjd1FvWERW?=
 =?utf-8?B?ZFFqSTFVdTdZS2RjV0szNHdpaFdGUUt4UnYzMGMzYjNwNzNyRDUvZkZjSzhh?=
 =?utf-8?B?ZWVESVlIR2JjcU9MVWxlUmFrd1R6WDBkM0hqUlVKQzkwTThUbzFoU2F2ck14?=
 =?utf-8?B?MkVlbEt4QUZCaWl1YkdzNlpMU0dJTW12eDhvQzE0N3A5Y2dUdElkT2txMHY5?=
 =?utf-8?B?VnRGTFlwekpXZnpZdzIwOEdFTk9oaUl0blJHMVVnL1V4a1Z6US92c0c1amRh?=
 =?utf-8?B?VWRKWFozVWQxVDlua09QSmJMRXJNRGk1a01VUUo0R3YrWGtvN3lIVG43a1NN?=
 =?utf-8?B?RW5XdVJWdmtNRFBVWGpoL0tQNXd4Ly9xMnFWRitOa0dGcGZwNXVOY0pzZ3Rs?=
 =?utf-8?B?UHpUS3lmUnFOT2syUDVPRExocEE0VzRtUmNSVlZCL243Q2N2aXpYaG83YnZN?=
 =?utf-8?B?VEUxU3c2V29JZkgrcXJ6NVlLMXBkek4xV21sQ3VaU0oyOW9BMkpNUkRKQU5q?=
 =?utf-8?B?YzlMdDBpU1doWkVZU1VyVjdaUUl4cUh6dkwwUjB6OFZtKzBKNTlXdG0zdnkr?=
 =?utf-8?B?SnRVL3J0a0FuQ3pVd0xGbVhDTmZMSzhVN1NKSU9HSks4Qmt2SUs0UlI3dDZk?=
 =?utf-8?B?a1BJcUtkeEw1V0E3dmlscU52eGNKVmdDMXBIQ2ZFbkdWZGc0OU9Xbm1iZDVJ?=
 =?utf-8?B?RS9acTRQcURpQThhK2x2eFovOTZVeGtqOUhMUEhPazE2QVcwZDVaK1YwNkYv?=
 =?utf-8?B?MWZKc0VYVTBZRlMrcWRva0N1SU1DamM2TUk4K0NNWG5PaDQ5bTI4WlRRWloz?=
 =?utf-8?B?dTZSa0Jhd1c3QXc0STU3K3NuWTF6TUgzSHR0TGlhTzlnTlJTZXZuZzB2ZHl0?=
 =?utf-8?B?RTNpMVYxbWtvdEtaVTI1QUJLTUtkLzdsd3poaGcvV0ZtbUZ5YzU1dWh2RXBu?=
 =?utf-8?B?OGo1SDdzQzFhRlh5Wm1JbklXb3lEVlYrRHhPejdXbHNpRjNqRlYzbmhKUWNk?=
 =?utf-8?B?eG5CUklsQlJCZHUwNldEeXpZL3lYZlVEVzVGN3FpeGRFYUcybElDRVJWM1RX?=
 =?utf-8?B?b2xQcVV2aVNYOVB0T1JWeWJRY21LRVozVisrTFhnRmRJcEUrMzlrcWZqQlZi?=
 =?utf-8?B?VDY1Rkx0MURYdFZCNWJNUVVDdkRQQ1VpZko3KzZRZzl6VUQrR0grd1V1RWNT?=
 =?utf-8?B?SVJxemgrNUZadURhMHJSVnNZdWxWR1JPMitmclpPOTlNQjk3WDcrNGxmcnpH?=
 =?utf-8?B?V24vYmI2c2VOU0Q3QVlnRWtBL1ZtQWNaWDFXVzFzOTBaMzRJb2lmc1hROVkr?=
 =?utf-8?B?N3NORE9tUXZUc2RDeWpLclRuRG50UEtGRzdHUm56RklaTlZVMWdxaU5jSW1u?=
 =?utf-8?B?bGtHZlQ4LzdJQlF3RWljZWJ0K3Z4TGRDRlhzdFJIR1FrcWtNaXVnb3oyMjM1?=
 =?utf-8?B?YU5vK3ZCMjMzbktCUVRaSEF4YmVpa0lCT1FzRzl6LzNTSE14T1hsM2VKdzdJ?=
 =?utf-8?B?ZXFDOXRnanZYSzUvcUhLY0l0cGtTQ3B1R3lxQmRWam1odVZYWUZ6R1J6YW5T?=
 =?utf-8?B?YUxhWnE0K1p0eWtzQ0dTRUQvZXpDU0haTjZ0Sml4alF4K1pOMDBLRUpBS2Yz?=
 =?utf-8?B?ME96RURoQW9BUWdWS3VZU2dHTnc2UTlBS2tKM3NXc1ZnUmk0eHB4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa2b400-095a-4093-9187-08de4f4b910f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 06:51:50.7805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwwWqeJrl8YosBvIGVCNERvCyWnCNiM0ltNNZ7Xj5naMoXPgTVQKFN3oQj1xUKC8Pr2hoMGLt1XofOlBYEX5I3GRgpFb6/8rhkYvzr8ALjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5962
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgSm9lLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDYvMTldIGh3L2kzYy9kdy1pM2M6IEFk
ZCBtb3JlIHJlc2V0IHZhbHVlcw0KPiANCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMDYvMTldIGh3L2kz
Yy9kdy1pM2M6IEFkZCBtb3JlIHJlc2V0IHZhbHVlcw0KPiA+DQo+ID4gQWRkcyByZXNldCB2YWx1
ZXMgZm9yIHRoZSBuZXcgcmVnaXN0ZXJzIGFkZGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Sm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBQ
YXRyaWNrIFZlbnR1cmUgPHZlbnR1cmVAZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvaTNj
L2R3LWkzYy5jIHwgMjAgKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9o
dy9pM2MvZHctaTNjLmMgYi9ody9pM2MvZHctaTNjLmMgaW5kZXggYjI1MjkwM2VhNC4uODQ1ZmJk
NWVmZA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kzYy9kdy1pM2MuYw0KPiA+ICsrKyBiL2h3
L2kzYy9kdy1pM2MuYw0KPiA+IEBAIC0yODUsMTQgKzI4NSwzMiBAQCBSRUczMihERVZJQ0VfQURE
Ul9UQUJMRV9MT0MxLCAweDI4MCkNCj4gPiAgICAgIEZJRUxEKERFVklDRV9BRERSX1RBQkxFX0xP
QzEsIExFR0FDWV9JMkNfREVWSUNFLCAzMSwgMSkNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3QgdWlu
dDMyX3QgZHdfaTNjX3Jlc2V0c1tEV19JM0NfTlJfUkVHU10gPSB7DQo+ID4gLSAgICBbUl9IV19D
QVBBQklMSVRZXSAgICAgICAgICAgICAgID0gMHgwMDBlMDBiZiwNCj4gPiArICAgIC8qIFRhcmdl
dCBtb2RlIGlzIG5vdCBzdXBwb3J0ZWQsIGRvbid0IGFkdmVydGlzZSBpdCBmb3Igbm93LiAqLw0K
PiA+ICsgICAgW1JfSFdfQ0FQQUJJTElUWV0gICAgICAgICAgICAgICA9IDB4MDAwZTAwYjksDQo+
ID4gICAgICBbUl9RVUVVRV9USExEX0NUUkxdICAgICAgICAgICAgID0gMHgwMTAwMDEwMSwNCj4g
PiArICAgIFtSX0RBVEFfQlVGRkVSX1RITERfQ1RSTF0gICAgICAgPSAweDAxMDEwMTAwLA0KPiA+
ICsgICAgW1JfU0xWX0VWRU5UX0NUUkxdICAgICAgICAgICAgICA9IDB4MDAwMDAwMGIsDQo+ID4g
KyAgICBbUl9RVUVVRV9TVEFUVVNfTEVWRUxdICAgICAgICAgID0gMHgwMDAwMDAwMiwNCj4gPiAr
ICAgIFtSX0RBVEFfQlVGRkVSX1NUQVRVU19MRVZFTF0gICAgPSAweDAwMDAwMDEwLA0KPiA+ICsg
ICAgW1JfUFJFU0VOVF9TVEFURV0gICAgICAgICAgICAgICA9IDB4MDAwMDAwMDMsDQo+ID4gICAg
ICBbUl9JM0NfVkVSX0lEXSAgICAgICAgICAgICAgICAgID0gMHgzMTMwMzAyYSwNCj4gPiAgICAg
IFtSX0kzQ19WRVJfVFlQRV0gICAgICAgICAgICAgICAgPSAweDZjNjMzMDMzLA0KPiA+ICAgICAg
W1JfREVWSUNFX0FERFJfVEFCTEVfUE9JTlRFUl0gICA9IDB4MDAwODAyODAsDQo+ID4gICAgICBb
Ul9ERVZfQ0hBUl9UQUJMRV9QT0lOVEVSXSAgICAgID0gMHgwMDAyMDIwMCwNCj4gPiArICAgIFtS
X1NMVl9DSEFSX0NUUkxdICAgICAgICAgICAgICAgPSAweDAwMDEwMDAwLA0KPiA+ICAgICAgW0Ff
VkVORE9SX1NQRUNJRklDX1JFR19QT0lOVEVSXSA9IDB4MDAwMDAwYjAsDQo+ID4gICAgICBbUl9T
TFZfTUFYX0xFTl0gICAgICAgICAgICAgICAgID0gMHgwMGZmMDBmZiwNCj4gPiArICAgIFtSX1NM
Vl9UU1hfU1lNQkxfVElNSU5HXSAgICAgICAgPSAweDAwMDAwMDNmLA0KDQoNCkkgZG9u4oCZdCBz
ZWUgdGhpcyByZWdpc3RlciBkZWZpbmVkIGluIHRoZSBkYXRhc2hlZXQuDQpXaGljaCBkb2N1bWVu
dCBhcmUgeW91IHJlZmVyZW5jaW5nIGZvciB0aGlzIG1lbWJlcj8NCg0KPiA+ICsgICAgW1JfU0NM
X0kzQ19PRF9USU1JTkddICAgICAgICAgICA9IDB4MDAwYTAwMTAsDQo+ID4gKyAgICBbUl9TQ0xf
STNDX1BQX1RJTUlOR10gICAgICAgICAgID0gMHgwMDBhMDAwYSwNCj4gPiArICAgIFtSX1NDTF9J
MkNfRk1fVElNSU5HXSAgICAgICAgICAgPSAweDAwMTAwMDEwLA0KPiA+ICsgICAgW1JfU0NMX0ky
Q19GTVBfVElNSU5HXSAgICAgICAgICA9IDB4MDAxMDAwMTAsDQo+ID4gKyAgICBbUl9TQ0xfRVhU
X0xDTlRfVElNSU5HXSAgICAgICAgID0gMHgyMDIwMjAyMCwNCj4gPiArICAgIFtSX1NDTF9FWFRf
VEVSTU5fTENOVF9USU1JTkddICAgPSAweDAwMzAwMDAwLA0KPiA+ICsgICAgW1JfQlVTX0ZSRUVf
VElNSU5HXSAgICAgICAgICAgICA9IDB4MDAyMDAwMjAsDQo+ID4gKyAgICBbUl9CVVNfSURMRV9U
SU1JTkddICAgICAgICAgICAgID0gMHgwMDAwMDAyMCwNCj4gPiArICAgIFtSX0VYVEVOREVEX0NB
UEFCSUxJVFldICAgICAgICAgPSAweDAwMDAwMjM5LA0KDQoNCkkgZG9u4oCZdCBzZWUgdGhpcyBy
ZWdpc3RlciBkZWZpbmVkIGluIHRoZSBkYXRhc2hlZXQuDQpXaGljaCBkb2N1bWVudCBhcmUgeW91
IHJlZmVyZW5jaW5nIGZvciB0aGlzIG1lbWJlcj8NCg0KPiA+ICsgICAgW1JfU0xBVkVfQ09ORklH
XSAgICAgICAgICAgICAgICA9IDB4MDAwMDAwMjMsDQoNCg0KSSBkb27igJl0IHNlZSB0aGlzIHJl
Z2lzdGVyIGRlZmluZWQgaW4gdGhlIGRhdGFzaGVldC4NCldoaWNoIGRvY3VtZW50IGFyZSB5b3Ug
cmVmZXJlbmNpbmcgZm9yIHRoaXMgbWVtYmVyPw0KDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGlj
IHVpbnQ2NF90IGR3X2kzY19yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwgdW5zaWdu
ZWQgc2l6ZSkNCj4gPiAtLQ0KPiA+IDIuNTAuMC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0LWdvb2cNCj4g
DQo+IFJldmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
DQo+IFRoYW5rcywNCj4gSmFtaW4NCg0K

