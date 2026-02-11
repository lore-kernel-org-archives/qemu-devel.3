Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB111ECD6C7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqDnX-0001f2-2U; Wed, 11 Feb 2026 12:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqDnV-0001er-3V
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:14:41 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqDnT-0007Lc-AU
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:14:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBiyEBENM0BFnz9TbebYjxuTa/dJqwuY0ZGkQU6hClxMIcO6C9A6Lt8w000wUtcI+Zw9SK6YMy2EFebCJpR978qKnZ0jnsJtQHnOmAtEbwip1BeOxDRAFV1fBiLkpWggXYm6XnjaIoyzHjvFHollcb63Uhm5ZDx+UE1Pp5sDl2uzDPXRjJKHYoalsLut7loCKNuDIOer4eitCQC2lF1K6LnN9u4wl6ywh6FMnMfdFoAzRFJJzSdBFMwzKJZ7yMM5wn5JJW/1iR/fQZS9IogX8ZQiORN+DftMWeXfjWp8vSJ0LH6TDYmLGdMnPYjIezUEl67V68STisHWh+fRDg21cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZtaC4rTb0gWyvwQPhyfFYcXTFbhxjcmoLY70o4jzTI=;
 b=S2OroYcK9GUvEUhzqd9tQJN5+U+Wxzb0pFYgNbyvEWNCO55mcsgadY1jswdSmb5CLrbvSejWFawObNvd83y6IvKGO6WXv/15DpXdyLgLyRSP7AuNyuf2Tynhs05SDQ57l78WCdMdufrzogBKZXNTNu4StRdIJqc7985VsAOd83RRQJPufcl/DJHJ24jPdGsIOF6dRQ7/UQFlMiSz8dsHjD8XevR2WkbWmPisrvbTnx8/Xsf3H3D6o/Kegol8IFRsgv39dqcpSjcifHzX/8r5gY7RqJQRIUIFBrqU2Bh4WpcekPzz7w7inJBWnmMu2JpMn16SSbYRMCzTz88F1l9jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZtaC4rTb0gWyvwQPhyfFYcXTFbhxjcmoLY70o4jzTI=;
 b=pdBSXG99mqtX8ZGjdD99Y5doU9qGii9EHYyCf/5XRwQDR1Gy0p3uyXCt5Hzt5zvVjSyp3lcgAaZN+0D2SOaG7sNgcDgS1aaI8JMI99HAzzEcUgOk761KzuvBfvqKi7DTgLdiXhFpIDtcWEuvG0iyr/RSj+H1JiOOrU1TwTJwoBv4nR8DyXyQBKdGDd4/sriX8ghVUNaBEfmd14RxaW/k+AEh/WYrBRuXdmSViwtKMbdX4fylpG1ppk33EeJ0TWFhnSqkby4Kq5kX16LsEq2f7+Wc0asBtJ9MLmbYAjLFDuavGIFbowgN4aj6rb65bTD9YMmTl/+bD6bzxlTTw9I66w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 17:14:33 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:14:33 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Topic: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Index: AQHclk1A0jbRvwQcXUyYvASyugR2rrV9OhEggAAecgCAAG5A0A==
Date: Wed, 11 Feb 2026 17:14:33 +0000
Message-ID: <CH3PR12MB75482AF23DD73B2D37742AFDAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
 <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN6PR12MB8470:EE_
x-ms-office365-filtering-correlation-id: a1f9905b-08cf-470f-6f68-08de699106aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UFpkSWoveWlDeElGcmlEb2kzT0Q5TXQ2d2lUeDU4N21lSTgyU1I1OTNYdUJq?=
 =?utf-8?B?MXREazBCcDFWOE9XUE1MU1QxMHV2VUVJMW9Xc3VuRlo0dHRTRGlDd2xJQmYr?=
 =?utf-8?B?YUxaVzVkUHl1YVZnVjBjTXAyRUhqVXJhazhYTHc5bDJMMkptRlk2cDlzZE9a?=
 =?utf-8?B?d0libU1YTzYxUDBEZTV1eGZOSDJkeFZHVXVHTkMyVnNTM2pDOXN6dS9mYm1F?=
 =?utf-8?B?U1hadlpudFBCZWltUEZaaUdnMlpUUXN0MXBteXVEbC85Q25wUGJaZXIyOVZj?=
 =?utf-8?B?czdpWlhyY0pyLzdleUZtSXBrTk5PSll2YTI5c1dvaTZjT0ljVnVSNGY3dExx?=
 =?utf-8?B?aE14WUphcVJUaVV5cFRnOFBNVzYyVTJBbEhlTWJSVU13MGljNTRHdVNNWFRG?=
 =?utf-8?B?cVViNHB2SWtpV2l5WEdrUzlIaUVFdmRvYzZxZURKS0t1NWhkb1Y4L1JmT2tv?=
 =?utf-8?B?NVdHYnR1UzhYbHpQYkVsRUlIMFFtRWFyUEhLT1NtV2s0dW9WUEgzV1pnMnNm?=
 =?utf-8?B?eXhMWUExMThROUFQSVlTZFljWFZnc1ZWclJGQUUyZjhWZk0xWGxFczhCaDRw?=
 =?utf-8?B?bGFIelEvdytwL0xNblQ3Vm5qOVNKN2pDdVVCN2t4RWVrbmw3bFRLelpZTGpX?=
 =?utf-8?B?N1V0b3RWM0x1SkN2RzExUHp3bTlkWmNTMDdkWS9FTUNrUHpJQk12RW9xZWFE?=
 =?utf-8?B?ckM4S3pQbklMeVV3TCtGTmtoRlBFdHZyWW9oVnE5ZjE0VHE2NjZDcUFoVTRn?=
 =?utf-8?B?NnpKV1ZYLzZQOHFoUkh3aE1NMUgzYklaQy9WSldIV0pzeW84dzZTeTFEdStj?=
 =?utf-8?B?NmR0K3NWYmVkaXpZakl4YU1xRXhoUTdRZnNvT1FkblJ6anFVWkIxL0dpU2k5?=
 =?utf-8?B?UHlYT2lseSt4WXppTVE2N2c2ejFuYUUzK3dURHBKVlZBNUN4UlFHVGNKaXV3?=
 =?utf-8?B?eGJFdS80d1JsRmVjTU95WUx6eWY5YTBuL3RrQ0pOMnlzVHMxVElQbjZzdkt1?=
 =?utf-8?B?RVNHUVZLNENQQlpuOElNV0tmeGNSbWRNN1BvdzFEZlhCaE1oZTVtc2F3VU1B?=
 =?utf-8?B?MVdFWnFTRDd1eldKMm84ZVovWEkwR0pzcTZEb0tSemZubU41cG1YSzZyYWt6?=
 =?utf-8?B?TSsxMnF6ODlIL3BqZUswQ29OaHhHNWl0TEtkWVRhZmdIa2s0cEJzSnlrc2Y0?=
 =?utf-8?B?eUcrSG45WVBoczhFbmRtaG5YTVF5bmk3TVdPZHBVRklVUkJXcTIya2ZhWHYw?=
 =?utf-8?B?UWdKQlNBaUpmTW0rNXo0cDdOTmNueU4yQmJJeGdzcTNqSDFsNGRSQ3dQaVFo?=
 =?utf-8?B?WWZXdHhYUE9MYml4T3BzQlFGK3JwVlZuZTJNMlh2V1NZVk5RWEZxRGVEblZZ?=
 =?utf-8?B?MlE1VEtVOVBFVXQ1aW9sTjZidDh2VE1pRnJYQzZkQmpTRFFZeXNYajRraVN2?=
 =?utf-8?B?Qk5yQTZCN2k1Q09ZYnBxeUd6clRmWkNMWG00UTlsWkpLV09XTUtOWUM2U1JI?=
 =?utf-8?B?MkVCZnBqV2xiKytFcFpRYzh6SFdQU3lwc2d0a2RYZ24rQkFhbUUrb2gxZ1Qw?=
 =?utf-8?B?QjErTEJXRW1DRktxT0N4TGZqS0NwcXc3dFY5ajRuTTdFR1g3cEUxUFZkQVBN?=
 =?utf-8?B?WUF5R3JNaHRUZ2pnSE9YcjJySUlJdnEzTXlpL1VmTUh0YnhYZzQ3dDBlVnNo?=
 =?utf-8?B?V0d0bCtzWGQ5bHA2K3pERERCK3I5eUhCaGh0WnZhM0o2Qkh4RUpsdnBWVFA4?=
 =?utf-8?B?N0l1OVhONGRnYVhkeURaV0VKRjg3dlcyV2ZvTDVnb3VzUXZ5M1F5SmIwK2kv?=
 =?utf-8?B?ZFd4OWtsVGRRcUppZ09jUGNFek5rS0FHUUVaU2UzNWpzTFppNFBVQnZ1M2RM?=
 =?utf-8?B?V3kwWHVHTFVDbUJPZDZOdTFiVTM1TEFjc2NYMEZTTDVSUTRGNkw5TC96VjYv?=
 =?utf-8?B?Zm5RS05mVk03ODQzKzAveDhPTFd2WitMN2lEdW9sb21uaWtrdkhEbC95NWpO?=
 =?utf-8?B?dmN4cFQ0SWpkZGpXQUpiai93K3lrbjE2bHFxckttc1JxaG5hNjNzamljMW5p?=
 =?utf-8?B?UUQ0MGowNHVGUlk2RzhuNHhrd1NkSkkrRU9JNHozSE9ETnFVM21nUjlxNXEz?=
 =?utf-8?B?YmtucTNSRVhpUkdmaWs2WldITndSd1prQityQUhKQ25hbTI2UG44dkFhcXUx?=
 =?utf-8?Q?frv8mo7Ck3UKL2CfMHoJJ6I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHg2WEJNQTZxVW1hYkJJNGxoeXdnYklhcUtrV09tMTM1WkwzMDBRSUx1WVFG?=
 =?utf-8?B?YkkvbmVJOE9LVzJxeldqOEpsSGZCZEkrQ3BaZVVacjlLVnN5MEVkK0lZOGxS?=
 =?utf-8?B?R2F5bTk2VDRDUWE3aytrU0lNcm41T3J1TElBdFQvL3ZPb1dOUHBiUnZ3bXBw?=
 =?utf-8?B?MElVcHU1Zk5SbmhGNWkzd3BzUHpsbkYveTdQamtBQ0VqaUxNMWw2cmhndit1?=
 =?utf-8?B?cFE5dk4vZWxmNndVOE9tL2RJRmxteVJUVkZzL0FPbXc2bTRYTHNkcVI5YW5a?=
 =?utf-8?B?Y09UbVlYakdidUtmVEdyRktwTzlvdHRSbjZxVGUreWhGS1ZIcnhoeTNFTzdS?=
 =?utf-8?B?cGZOaXRlamhPdFEvSWpyVUhpS3R3Y1VXNjVveWs5bDk3aU1WallNYUxJL3NC?=
 =?utf-8?B?VURBMitaS3NlNUt2cU04bGNlaDdST1JwQW5NWTZuQy9zdnJtcFc1ckNGWWNs?=
 =?utf-8?B?ZTNvTmFpSmxlWVNqM2FJeDQ1SW9vN0ZOMnl5UHBIWFQvNEtja2xFOEI4RnB6?=
 =?utf-8?B?TnVlVkdxVzFwTk9zMGx5cWppbEFFWEZhbUR6bjZGUis4UEFhcXk3aE5xQUt2?=
 =?utf-8?B?NlNCYlduaVZtWU1rdGxXQnJ4bWQvZ2lpdmlWNmhKdXRMUXMzQ2dEQXZCcXV4?=
 =?utf-8?B?YmFYb2NrSjNmek9QYXRTUDZ6U243MlFRa1BlYWZObHN1ajUzTmhXc1l1dTF5?=
 =?utf-8?B?UGNHc2p0MVRrMXA5U0J5WTE1NndIMmV3aG9GS2ZaUCszcS9nVmliOTc1ZmVq?=
 =?utf-8?B?MzdZbzhaVk1wVXFyWEtCdmJ2bGZvZFVmTzBJdTlIV01YQTgxOXlWZWhhZFJU?=
 =?utf-8?B?Wlk3S0RpV09WWmpyWGRjMWVDRXhIeXR5YnJKc2Nhb040NUdMNlNXM1Vod0dx?=
 =?utf-8?B?eS9IdTVrU25STlhDeWVFcnFQRG55VDV0NEptV3VFMmFFbkgyQ2xCbnR6M25J?=
 =?utf-8?B?TGcwU1ZMZU03bGNBR3hOMlQ3Rk40bDVCU3NJd1gzNVFiejFzcTNBRDFib3hT?=
 =?utf-8?B?S3JjMzJGWVAzSndVZ2hHOHk5Z1BGOHZ6OE1kVm9aNFhoQ1YxeHBObGh6ZldU?=
 =?utf-8?B?Zk1xRnU5eTJKUWNWQ21KamN1TFNMWmJnalFvalVpWnc5blpCRDY4U3JaOFlt?=
 =?utf-8?B?c3R3YzN4WmJWTjV0a0dpVEMzY0ZKVkVYZUtwdjd2d2FwR0ExSUd3QmFSZ3hi?=
 =?utf-8?B?WFlvSGthSlVmeWl4WWFKNmo3VHJ0bzZ6U3BPbmtFVDVhNEZFdm9RR0JIdGpS?=
 =?utf-8?B?RVVEZ2cxQzgyelhScTRJUzhtWTEzQmN6bFlJaExPTk1VWExJTmhQR1Riejl1?=
 =?utf-8?B?UjF6TjBVMDV1dzB4MmF5amxydFg2Q3hWSGc4b25jWHB2YXZpUjlQNnMvY010?=
 =?utf-8?B?Y3NLd091ZzFjZ0JLb0lZOE1mZFpEOE5GU1JJU0Zhb0lVOXlWMTdvMEdHSnVE?=
 =?utf-8?B?Z2FHUkN5ay9tVzRSdjc4a0FlNW5SN3NPU2l0WmNQSGFycGs0OTgvNmlMVDBP?=
 =?utf-8?B?bmtReHV5QzRoeS9nQjZFekZjNkZWTTlFTFE4NEN2N05GV2NVdi9TemYwLzhZ?=
 =?utf-8?B?WWxMcEt3cnk5T2JMamxCd0ptbko0ME5QbjFETHdObkZYRVk2bTJvOGNqVjgx?=
 =?utf-8?B?ZW9NMkQ2UGZoa2dMMUUrMUpuV1ErWE9SVE52WWljVDdTeTNKNHA2Q3BwNS9G?=
 =?utf-8?B?MHBkOWEwbXFpRkpEOUs4TW1VdnE3OHpualQ3akR3VHdOdkJKeWwrTjZFL2s5?=
 =?utf-8?B?SWZVbURGeFJ4dGxySlU0a29hT3JvVm94MzE4Um5xSjJ6bkZpc0ppYUZzUVA1?=
 =?utf-8?B?c1UrMTlVbW4xUFpYTldaZVFNL3g1S2drZDVOVHAwbjRMN1lnVFhLcFhsYXg1?=
 =?utf-8?B?TjAveWtoRVAxbTFyTWFqbnUvUHc1MHF4SG52WDMwQjc3aDJnWlZLK2RRNEli?=
 =?utf-8?B?TTRDRUg5cWt4eXFEUXdkemVNblJhS0RYbVFwaWRLV0NmK2JDVnJlTm9JUXdu?=
 =?utf-8?B?RjlEUldjZDNOeE9pK3huSUVFdEYrN2poQTRkTlB1bG9mTU84Ymc0UUREK2Y1?=
 =?utf-8?B?d3pXdDg4a3NXOFlVNGZmZlEwVEp6WFJSZzIxeFlwK2JLZGNzSGlqaFlOUVYz?=
 =?utf-8?B?Y0sybm9GMXRBcTFxcHpVZDNpdDhHK2ZqS1BFSENzUDNXRzJhZTZUTkhlbk5x?=
 =?utf-8?B?VXZRUTJBaU1LN3kxQ3VoNTlYWnpuZUM0RXFSZ0dlenlLMTRadEliWmZmV3dZ?=
 =?utf-8?B?M2M1Zm9mN25MU2FRYkN4MU1YdndIN2R4ZUtrdVlYVy9sdWMvUVk3WWlxRW1t?=
 =?utf-8?B?ZWYyTTVrVmV0T21KNytJMW5NLytIdDRtcDg5TWI2TTlTU1RSOGNKQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9905b-08cf-470f-6f68-08de699106aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 17:14:33.5842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/fG3Wt+Q7aGIGwLhiS51Kd65Tc5tk5ACiqGko+iUKWeG1nzNqJ1kxqLQMK9X9xzSqzG5bWv9/wdVnq5Pz/O8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHVhbiwgWmhlbnpob25n
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IDExIEZlYnJ1YXJ5IDIwMjYgMTA6
MzgNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29t
PjsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogYWxleEBzaGF6Ym90Lm9yZzsgY2xn
QHJlZGhhdC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4gbXN0QHJlZGhhdC5jb207IGph
c293YW5nQHJlZGhhdC5jb207IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBO
aWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+Ow0KPiBqb2FvLm0ubWFydGluc0BvcmFj
bGUuY29tOyBjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbTsgVGlhbiwgS2V2aW4NCj4g
PGtldmluLnRpYW5AaW50ZWwuY29tPjsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBI
YW8sIFh1ZG9uZw0KPiA8eHVkb25nLmhhb0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUkZD
IFBBVENIIDAxLzE0XSBiYWNrZW5kcy9pb21tdWZkOiBBZGQgcGFzaWQgYXR0YWNoL2RldGFjaA0K
PiBjYWxsYmFja3MNCg0KWy4uLl0NCg0KPiA+IEhhdmUgeW91IGNvbnNpZGVyZWQgZXh0ZW5kaW5n
IGF0dGFjaF9od3B0KCkgdG8NCj4gPnRha2UgYSBQQVNJRCBpbnN0ZWFkIG9mIGludHJvZHVjaW5n
IGEgc2VwYXJhdGUgY2FsbGJhY2s/DQo+IA0KPiBZZXMsIEkgZGlkLiBUbyBleHRlbmRpbmcgYXR0
YWNoL2RldGFjaF9od3B0KCksIHdlIG5lZWQgdG8gYWRkIHR3bw0KPiBwYXJhbWV0ZXJzLCAiYm9v
bCBoYXNfcGFzaWQsIHVpbnQzMl90IHBhc2lkIi4gRS5nLiwNCj4gDQo+ICAgICBib29sICgqYXR0
YWNoX2h3cHQpKEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBoYXNfcGFzaWQsIHVpbnQzMl90IHBhc2lk
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGh3
cHRfaWQsIEVycm9yICoqZXJycCk7DQo+IA0KPiBhbmQgcmVmYWN0b3IgaW9tbXVmZF9jZGV2X2F0
dGFjaC9kZXRhY2hfaW9hc19od3B0KCkgYSBiaXQuDQo+IA0KPiBJJ20gZmluZSBlaXRoZXIgd2F5
LCB0d28gc2VwYXJhdGUgY2FsbGJhY2tzIGp1c3QgbG9vayBjbGVhbmVyIGZvciBtZS4NCj4gTGV0
IG1lIGtub3cgaWYgZXh0ZW5kaW5nIGlzIHByZWZlcnJlZC4NCg0KU2luY2UgUEFTSUQgYXR0YWNo
L2RldGFjaCBpcyBlc3NlbnRpYWxseSBhbiBleHRlbnNpb24gb2YgdGhlIGV4aXN0aW5nDQphdHRh
Y2gvZGV0YWNoIGZsb3csIEkgd291bGQgcHJlZmVyIGV4dGVuZGluZyB0aGUgY3VycmVudCBjYWxs
YmFja3MuDQpJIHRoaW5rIHRoYXQga2VlcHMgdGhlIGludGVyZmFjZSBzaW1wbGVyIGFuZCBhdm9p
ZHMgY29kZSBkdXBsaWNhdGlvbi4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

