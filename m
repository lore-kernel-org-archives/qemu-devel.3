Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34108606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=ZUt3ncUE;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=YiGxB/x3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBWp-0003FZ-69; Wed, 11 Nov 2026 11:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBWi-000358-9n
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:50:25 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xRBWg-0003sc-7u
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:50:23 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF20k93977954; Wed, 11 Nov 2026 08:50:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UHEvL5EttREGOIa4bTe6/KnjSwHm/Ju1APjnEIM/C
 ZA=; b=ZUt3ncUE1Yv5xjOy9n0LVbcl96fIAhb5/heB0lxXQd50VIFsxPshpupzi
 cvupEp04K3+eMEpiGv6hmnyZUe/0/cuHDvpQw4hppmBw2hrIhtzPC2EHgW8eQl0Z
 7W8+FX5SRcWzA7NsKrQK/wwtLX/aNXtUl0z+F1GwD7mOgAtfzljEcAHfJOrXnD9j
 YEWKDQPxtRrU19KvLujqqkZUu1TJu0BtNyC9C4nNE62czLtlAiMf8bwoZYrrjyP/
 /oTzME+b1dav1WolQi2ahV/CAlyRG1wwBJCr+K0sOGTEdrfNknMzMV1VIYzmcy4D
 DgLZYTmqWbKITDWuSwvYHVNpvibug==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020083.outbound.protection.outlook.com [52.101.46.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hvdjjt11w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 08:50:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJOc2OXzsescEjRnzu5eWuZFKPZl9RoSoId9qspkUAoYPlHEWEKvcs2W0jJmkW74Hz9g1sEUdEb0NFR0dh9Y6Enyd6OhEZZrP7NTGFFVpddZAxhX3Igyeiy+ZUeJgiscJc7mUXS6CIftpTlDJAD9liC71LZb+rtMk1nz4nkuFh92mzMRtsE9DR6yby6ys1WvCb2XIIbTNp3yV2JZoAs5ZKz56rRFAePPmLV1eo/lMcI61wudxHSuquA4l+iXIhMBrRTyBxRZOxgL+TV/L9xlcc/xnWn+rvxVh6biPe/L817EoHok0sGBf/WyRQ299URSZHiBHM5DBJMVRJgn5xb6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHEvL5EttREGOIa4bTe6/KnjSwHm/Ju1APjnEIM/CZA=;
 b=Fwz+vk+dFvIDCkHOI84yVJ032S4QjNqWg6ONhEbetBkmf56KzL1wjK6aK8jOWU7kD2IVeCYt0FclVqAIwhgjTgBqQLfjMCNIO/LurxQkGBMRA6imAVfmwkByqL8ipoGPdiDZGMcjmMGJscH5yY9OB2S/eWoatWTmFc3C2LPCKNc12TAC1+fpSp0NgVfXejiqUtf2TSyu/uPRLVwoNXDC8e/wAGXR9oqccu6gPaEeXesddZPwhOEYCWK8fzyHg07Qio394/soG2bHoO327r2S60o2lCIklaGZDRPjYF4l/8ijAIPPhXR2G5cGB3Tf/t8GyuYBE8b+Z5ysMHew4Kq5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHEvL5EttREGOIa4bTe6/KnjSwHm/Ju1APjnEIM/CZA=;
 b=YiGxB/x3LIeHgPOjNKmBZ1pynvV42EKYTJyFGes3ABlzmi1/ByUgCbHV+FLaa+AH3hBMPrWBvsSuA+MxnnhSPIysLaPJmYacOXF2vqSkvFGU4XXs/N7VdL/KrqXaFwt/RldtAEn1KhoIDIwK4HazBSOrmja7HPOiL1H36ANZpHMdw9A6JxNHGCENAHBDUYXARlzpVRsK/de+CU6mXevc37rMml/u+Xa7ArwYkU2Se91JF4vl/kpif7B4SqIaHLzAfZwo7TMQ+Ql5VWCyZrxWJf3buPbx7NJQGdF8WTt0pQQagjK/wJ/Xt9PlPw+h2gXiENT0Vgm4NR53R7dFyZC2og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSSPR02MB11372.namprd02.prod.outlook.com (2603:10b6:8:374::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:50:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:50:14 +0000
Message-ID: <3cbfa917-788c-4a43-b13e-fa84ef2a1ce0@nutanix.com>
Date: Wed, 11 Nov 2026 16:50:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] backends/hostmem-epc: Register QOM type
 unconditionally
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-5-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261111122342.634370-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSSPR02MB11372:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdb9f87-8f72-4a2b-1467-08df4013db90
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5/KOrIJ16htlKnXp+2i/wrxu98NaxwniLe9fWv8saSMQUTvB1svlgil1HTs0JyS59FLoHQ5gFlXPYHo2/qfLooOqZ4Rl3pscK2mpce0kSi5bes5YOF4C4IlgTpw7MQd7F4N/25E8kswoi9NMll2e3jENx809HCGWV0FiyFfiEIBE7ZSfMm/umZb6XCiFhIndGckbLrWmL+jyRzIzj1evX7n8jBBbfFeUIoXmHrdFnauHd7UsKql68vIuhYNStN5L7VvxNe9u1r0vkl7f3q6VbXNNDeznixKoecKvo0EFh6UFP4dFd04EkwA/0yLTep9aVe1KPyiQNjA0qD579yyijTK1pl5VheEQZ5iT49zs70risIjAaZxaKMXXN6h0paLu15jfDe6I7I96r85vY0Fzy+Oir4sf4hMJR7RGgzTzNWobXA1b6f+UEu0mrv4OgfXTyTu7dwCAGiVZjD2FO76WZkdXsrNY5/cBP9T37cXod9UTH9EGCJ/67R+T679ZwRGDAgO7PRybdxpcsdqZ4gJnKeQlucvSBItRsmdUPO4FKW1DdUugv4dt9MgwHJRzGlFulNbVg3AgGKOa3e9GkbvrzL26Hza8MZEcLFUuhNdYLqqauMeYWuumeuAy0vei6WtpBabFovfsAWiWSx9EWwRvS5J6PvX/ionj8cAEb1D/yKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlRcWRVdmQydW1DaVh6Z1F6ZlFkTm5kMzR5Q3Jtc0pNeSsvTkJtUzFuRWpD?=
 =?utf-8?B?WlhzV3E4aVhpdlVQN1ZPWVRxdDBQS0FJd0F0WkxiV1BHUU1XSU5BV0d4L3ZD?=
 =?utf-8?B?dUxNVjNnOENLVHR4ZTlqSFh0ZnJvdG1LTzJlT0lkTXdUM2ZwSkptMnNYQ043?=
 =?utf-8?B?QTZ1S290Y2dDNWFsVi9WTGFWM0FwK285bXl1WStkcGJDbnFzemYzL2EzbHhr?=
 =?utf-8?B?ekpQWDQrang5TGlSYlFDdTdlQjVZMlczRWtLN29vSUZodDFXMGh4cFFXeG9l?=
 =?utf-8?B?bTk5U2xnMUFtTWNVTmVjVmJHNWJxWk1XN3RIRytWWnlpVW5qWXZRT3JkOGdv?=
 =?utf-8?B?dUkrQ3NyZTNCbUN0TUxoZkdsUmVNdnlDQ2RhYWxjS2srdUlZU1NtRS8vMkF5?=
 =?utf-8?B?Y0llR1ZyaFdxeVRBNHpsK3d3SndBMERoZEVVVDNnSHBBUll4OEcxUmswL3pv?=
 =?utf-8?B?ZlZ6YmY2MnM0RFJCREt6VTFPc0x4K0t1NVduSmxHZWhvaHROY2VBWXdtajdY?=
 =?utf-8?B?Ylh5YUgyWUN3S2VIajhHNXdkN3RiOXNTZ0dQMjlXNTRDL1ZjVW5OdGZmN1JU?=
 =?utf-8?B?SEFHTFpsU3U3cHlYVERZT25MQXNTMmE1OHg2c0tPRkJabkltWDR1bzJZWVhN?=
 =?utf-8?B?cHd1L1BCUE4vWjN2Ukt2SFZFMTNPU1dlV1JveGVVNGdZbHNMZVhEOG11SDZS?=
 =?utf-8?B?Z09CQW5JMlBhYWhpcWkvUDVIYTNkZW1YS0tTWDJlQTlxbkNTbDJnckorMGNF?=
 =?utf-8?B?akxORVpOeUF3by9QNFRiN1lQQ3VUSFV4RkRsR09JK2t0eWwyNkRxK2lucGxa?=
 =?utf-8?B?ajgwc0YrMkk1bDVrbFZNVGswU1ZzcG5WMW54dktOOGl2ME1pL1RIOXM4U0tu?=
 =?utf-8?B?WG96SjlyQWk4dWJDOVNHallYWEVVK042b2dFZHUyRzgvVUpzQmZaeEF5WkVi?=
 =?utf-8?B?T3ZTUTlieXFjaEcwOG1nejI1QXlpVnZIZWRjWmNHdEp4N0FVOFRMZE01RVow?=
 =?utf-8?B?KzZuODJrRTk4WmhDdVh5NFFURkQ4bXRtU1hwRGp2SzAvMWMvZ0dQZUJIeWhI?=
 =?utf-8?B?bUo3OEx0WTNaek1CN1dycE4za0lkWnlCVitWcktnaVB4NWE1NERzeGNnSk5T?=
 =?utf-8?B?UVJDRlFNb2hRWCs2MGVoZlhtNnhHUm84Z2xHaTlaSHhvNDhJR25GZklBeXoz?=
 =?utf-8?B?dGtjSjdKUXNQY0VrQXdFL3ZjRW5BQ3dQRjlSR3l5c0xQRmwzZzltaHVNN2tk?=
 =?utf-8?B?aVo2YS9HdmpvSkdLVEs4Y01QeVo3MElBN1VBckE1NTMyemp3eTVJdFhKT0RC?=
 =?utf-8?B?cGZjRDV0NlVrQXg3bWpaeXV0YlQza1BoeW9YVExPNHUza29ob1JnNnRqL20w?=
 =?utf-8?B?T2FrQUt2UmR2NHBIOCtGOW95Mnowc3EyZWpzbEk0cFRnM1JJYXZVSFBVZlp5?=
 =?utf-8?B?RFR1N01SQjJ0eUJJN1p2VzUvaDVZM0x6Q2ZWZWtpL1YrZE81YndBVFlDT212?=
 =?utf-8?B?a2o5NG9DTFBrZlNWVStQZkwyMXl6cUlVWGF5OXE0ZzJWMlN0UHVPMmRLd2Iv?=
 =?utf-8?B?OGREM2VDZ0dXV3dFby8rWXRSMi9RT2VIbXdoekZQYWRKeHlhM3lacDdJSXdE?=
 =?utf-8?B?ODJlNG5jS09XelVxNS9HVkNzb21BWEFyRlN0THpKcDltUnNyRVdQK0tKazg2?=
 =?utf-8?B?RHBjZHNoVjdrRHlObU1vMWYzQ3ZQeVJ6OTBzUXJFZmlkT2xtSU1aazRkcXlI?=
 =?utf-8?B?ZEsrK1N3K1B5YmgzMGdoZ1lnbXRPZFZPMHlGWGpHbEszdEpTaG9rWGl4aDNC?=
 =?utf-8?B?U2pRcEVzRll0MXlMa0RBbERHZGpJa2NSQVNHOEY0b0lRYk9TVXE1NTVzNG5J?=
 =?utf-8?B?NncyeWNYMWgrUHFYQ2kvcUtLOUlncU5lVGtLYTVYMEEra2RuQUFOT3kwblJH?=
 =?utf-8?B?S0wwNG1KbXRFNVEwd0h1VzJEb1lVRkVSQmpWY0FNamViOW01Tm0yVmtzL2tT?=
 =?utf-8?B?UkppZWR6bDc0Sm0zaGlyYis1MmNJMlVXK3hyM0xxV21FYjVDY2loWlVIS0FX?=
 =?utf-8?B?OEl2ejF6cHRyS242cFRQSnMyb2t4WnpPeHg0TWZyeWp6VWRlZy9SZ2FXajhj?=
 =?utf-8?B?bkdFK3liSHl3aU5JblU1RlVsZUp6czhDT3hSNjY3eHluTGlvRzhadU9FWVY4?=
 =?utf-8?B?c09uZ3dyZWo2S29OeUhiNk1iVTNUUzRtU29udmVMU2FDNDIwWTZ1Qk1tM3Jk?=
 =?utf-8?B?QldIQVVWa0VscEk3ck4wY0hjaTFiRTJyR2o5VVh6bndPbzQxaVJBQ2NiUU1W?=
 =?utf-8?B?alBVSTdMNHhZUytEMHY2MDY4RE5WZVlicWg2SkhiVklBbHkzQzR1ZHVGd3Rh?=
 =?utf-8?Q?ElXemLnn4AH5qPvU=3D?=
X-Exchange-RoutingPolicyChecked: f5Q4DE5Nic3oIuJOICukf5r2s8pv1ysuqZIqlFGJ1Dc+Bqqp5stAayh3vca1F0CChJGhhxHeZe8W8t5zQALf9dd7kSmU8pFGU3xf2saL95tQwBm3dwPziTe/Qu+YnENKl4YzcfNyc5In7HC1oQzOlAJPVXSjzRDy1vQVfVZKdm4xEGQ+eymfnsdfH6boVkCoxhMcPYZr/D/Pbv4dCRwXV6lBsMvCuxEMjPMXin4XgNvjOdITgfjf29bR4YlAjxu080kJvjj00tGWkvGiyiRqa7f5G+CjXmlU/K51OHFmI9qJ+cOaD3pGxgFUOrrAoUvWQN73n4BtftHJXUqKZMj9CQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdb9f87-8f72-4a2b-1467-08df4013db90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:50:14.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiPgHBGyFHhhY/ZInzxk6ng6GduKuaMzrBkFhfan4HclWopeFZDvb5+BmJdQuSwWpmFwXfc5cJAzWcnq/bWZ21wLVhC9tVa6JUOmIux3OQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR02MB11372
X-Proofpoint-GUID: PTx80d7M19bEiY2TyLJTGv-JNHDSBHIe
X-Proofpoint-ORIG-GUID: PTx80d7M19bEiY2TyLJTGv-JNHDSBHIe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX+1lcXsRXdez1
 9tE8kMGAC//jKcQsFSmmRaX8Iy72o+llNRuZ8IAFwI6YZRIdzxJdkYKaIo0fEUpL9F/d4Fw7UBA
 VS3OoQPHky4mLP7mKoVikFfXmea13iw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX/fnFlXob7/kP
 vmwvKdG6pjovXvt9MYQUV78BVUYRYhdD3eED2aEu6n4zTxEp1PiB1kGX0aWaWKFekGRq7GobvwW
 nISbirjG3nVVTcPaozEO3PC1Zg3YcYmdaJUROVgHMyIBwRiuDkJyr+sf5frth6+yzRtlQnbRISS
 M4XXu1FAYTIdSgswEYCqRcfMk5yW5ROnikedznSAqVcnRsI9t1nXtlGnI7zKTCi7HUIHhQ/3Znf
 6rhVaeFuU2YI6MmVbsQqsaoEOHBMs6/blYG8RkfkgaHXyPwHhIMkl3SBuCVo13pqCIOUmzW+Cx7
 L38m+wKx2PQamzfQyCvcb6MvKiAJ3oAi6jgCtwhv6LpOMIH5ac9R1gEe5LKibFSI68Y9DsqJoMK
 vmWBMuiNxwwWP45x8wPP8RCMG8BgllJbU/MLrzH1X3hPypVpBvqlcZ905qG6Np/idJWaapDhbtR
 N/aK7B89OW+EkOvDjWQ==
X-Authority-Analysis: v=2.4 cv=UYXE26SN c=1 sm=1 tr=0 ts=6af49cc9 cx=c_pps
 a=pfgRl+3joWazjPSajX+lRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=OdKKQXqhpsCl3fyKanMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:23, Markus Armbruster wrote:

> The example from docs/system/i386/sgx.rst section "Launching a guest"
> fails for me like this:
> 
>      $ qemu-system-x86_64 -cpu host,+sgx-provisionkey -object memory-backend-epc,id=mem1,size=64M,prealloc=on -M sgx-epc.0.memdev=mem1,sgx-epc.0.node=0
>      qemu-system-x86_64: invalid object type: memory-backend-epc
> 
> Device "sgx-epc" has a link property to a "memory-backend-epc" (SgxEPC
> member memdev).  It's not optional, so we must create a
> "memory-backend-epc" to be able to create an "sgx-epc".  In the test
> shown above, "sgx-epc" exists, but "memory-backend-epc" does not.
> 
> The latter doesn't exist for me, because we register QOM type
> "memory-backend-epc" only when we can open /dev/sgx_vepc read/write,
> which fails for me.  Such conditional registration is unusual and
> problematic:
> 
> 1. Management applications use introspection interfaces to find out
> what a certain QEMU can do.  Conditional type registration makes QOM
> introspection results depend on the condition, which generally makes
> them valid only for the process that produced them.  Undesirable.
> 
> 2. For user-creatable objects like "memory-backend-epc", it also makes
> QAPI introspection unreliable: query-qmp-schema claims the type
> exists (object-add argument @qom-type accepts "memory-backend-epc")
> even when it doesn't.
> 
> Conditional registration actually serves no purpose here, because we
> still have to open /dev/sgx_vepc for real when we create the object,
> and need and do handle errors then.
> 
> Register unconditionally.  The example now fails to create the object,
> like this:
> 
>      qemu-system-x86_64: can't create 'memory-backend-epc': Could not open '/dev/sgx_vepc': No such file or directory
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/hostmem-epc.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
> index e1c784249ff..bf5aecdfd45 100644
> --- a/backends/hostmem-epc.c
> +++ b/backends/hostmem-epc.c
> @@ -62,12 +62,7 @@ static const TypeInfo sgx_epc_backed_info = {
>   
>   static void register_types(void)
>   {
> -    int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
> -    if (fd >= 0) {
> -        close(fd);
> -
> -        type_register_static(&sgx_epc_backed_info);
> -    }
> +    type_register_static(&sgx_epc_backed_info);
>   }
>   
>   type_init(register_types);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


