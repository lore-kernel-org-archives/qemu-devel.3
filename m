Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2640AEE369C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYvF-00009K-57; Thu, 12 Feb 2026 10:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqYvB-000088-QO; Thu, 12 Feb 2026 10:48:02 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqYv9-0005Nd-2c; Thu, 12 Feb 2026 10:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKbZY1lP34J44zIIzoQM3VUAMnHUIWOhRazyEiN3dUzwbB01L8+R30JBOPqxJrCjxNaubtTq9Wlx/xbTzLse+xa3tTHHmC/WZKS/Gv9OJpmN1FILCVvwG2fJLrdK7wjxCzSQpv0wVcjfwCiO97uvaw7Y2Y32BYY7jDyNnPdgZnj7mJPY2onyIxcSGH/x0IvHLNbfc3HVZM+t2w6yALEMUqtEQlNG4xDXIpgl8jSnixl8boGS1SRvqEEUNZDyFhWhSpKDRKbUyDyoZSpxOIJzfZDgMXusv0SZd8NoxBfDdmg9+9EvRt6/FD/TIbNxhpJPd7DOTGBQBiXr9G5BXrW7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6WFJpXyoMZ5lpbvylbJu6GZ8tnQfNuS2GaczaZXMcg=;
 b=PKOf2m4jM0NWkrhXNCYqwcEh2R0k1sEr8SPv44TFTV+7UaFIgVEMgKC9O8gwYpsxngkt2wn0QUW33YdLmJrM6S3U4ue85U4XgYgaFepEJ2HH3F/QBJB7n++jr2A5+HlrhFSHPEnApLjIzGbS9mTSHOvu38yyP7VW0mXDm3MeGSTtPQuhUvOM0oViQ7HGPwUYowzDQu3ePkDcdhMTPhP33lIRuig7jOTgTzHdZ9tcWmRxoQIZ3RGFHvq0b7Pztxu1TPe/DgJ0U4qgaUuwmhmcCVTli3XHrZNkDIUiDpa2vYG9eDgQ5wmCePHt24JFrfnCkogijAKBlx0+uuay3Mp3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6WFJpXyoMZ5lpbvylbJu6GZ8tnQfNuS2GaczaZXMcg=;
 b=WpOM3iU5Wb11C0wjcHpQaqqgSYQfvDpqaHZZsgG2Oceg9N+uSl++9QAQsM4cP/PSLs2i+5QM/WDpAB3rheE/XWPTw0dwQMNDw64ugpa22vZiPHzJMUSw+6bQ+WhRwO9xrb/ZHzOx5OwO4eWD+/ikvamKJmOVFBcWGKf9ihUnCRqoxNB/A+pUufMPs0LQz4xXkcXyWbiCNpSUrHA895NZ0K4J0++EzFci2k64m5xE9vWOlySUpfEwGBPuixHrIt/SdcEB6qyleQ42m8n3rk2RNHmBlv4Pn7mmLS8w5h8vZGXBlY7SR1hOsloYpU0MCsZdEdKkL0gUbID4de9PNBCAIg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 15:47:52 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:47:51 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Topic: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Index: AQHcl3fclJVY+/1eUEyrJW1egg4NVbV6yXyAgADQx/CAA5IqgIAAAY3ggAACz4CAAABycIAACieAgAAB29A=
Date: Thu, 12 Feb 2026 15:47:51 +0000
Message-ID: <CH3PR12MB75481019FE5FEB62BCE96D58AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <46d3b859-6e05-4c03-8e77-0aa76629f772@redhat.com>
 <CH3PR12MB7548F06A2BB9C009FD2043F2AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <dcde8f24-7523-4e2c-8ce6-4048d3ca9c7c@redhat.com>
 <CH3PR12MB7548A87A5BC62C6D90501947AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <ef13c99e-29b3-47cf-a090-811294e723e0@redhat.com>
In-Reply-To: <ef13c99e-29b3-47cf-a090-811294e723e0@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH0PR12MB8549:EE_
x-ms-office365-filtering-correlation-id: f8e9e571-8e62-4d97-25a1-08de6a4e1492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RldTdiszZHl0amNDdE9aUnUxaDJJMGZJQ3dyY09WYjBkR2xUTEpMVG16Zncy?=
 =?utf-8?B?UjZIUHpWV1J6Q1pPOFdBL01ZV2tOUzVJekRjd1FkVzZYdTY0VHUveThROWg2?=
 =?utf-8?B?cjlsUWc4VFFSQy9aNDFDOVpoVWxpb0NvU1VRNG9pZysvUndhZTFpRjUrUmkx?=
 =?utf-8?B?SE5LbS9iUk9MWkNoSzVvclhwVnZiNU5wM0FBQUZwcmVIQXR1akxNOFB6dXVU?=
 =?utf-8?B?aTl1RWdZT0FxK25KampVUXFyRlpYWHN1WjQ2ZGd0NnhWS0NHdmd6RWpOc2lh?=
 =?utf-8?B?b3Z5ekZEN1Y5N1k3enhOMXJBTTYxSFd0anJqSWtVSEV3SDdCM0VsRTZsWmhB?=
 =?utf-8?B?bmtxNFVSdjFkR0tMTTQrVHFBOGU0djc5VmM3Y3RaSDBnUGJQZW5vM3Y1NjZH?=
 =?utf-8?B?ZlRPT1hXU1pXNEVYeURXSlpvNmEyeG1CK1VJVWdXMDNpb0JpTVBZblNlUEdk?=
 =?utf-8?B?TDJrTm4ybklGWjczenlUS3ExeWdPM1pvVWJxVlhuamcwUW5VU3FxZklPQzRu?=
 =?utf-8?B?dGtGQ0xRaFZsbC9EMkZvL0g5QUJJeDhKN3EyaWtYdHZxb0RxMDNJb3UreXl6?=
 =?utf-8?B?ZWJRL2xOUzJ1NmdnVDdEOVQ4Q3V4TE5lTno0dUtnN3MxMForZWcwYWgvY2dJ?=
 =?utf-8?B?UzVBZGc2UWVyd2hnMEl6SUUrS0kvRVhCd2tSaFFGVnliQVhGcTJNZERncEpO?=
 =?utf-8?B?WDI0L0luaW95SlQ1NXp6SWhVeTBZV1R6ZHFDZHcvRHlKUUJGOG1ZRDFzdGhs?=
 =?utf-8?B?eUV0T0NYTE5kVXJvVi85WXhnMlFGeXpMZGhjSVdXVGVsMGEwWE5ZMW94M0lJ?=
 =?utf-8?B?MWFPMmF3aUJWdGZaSDRoYUd5dXdHTnJkdDFHbGg1OUVXMVRldHdxcUZzTm44?=
 =?utf-8?B?MUJWdW0rdDlrL3dqQVpjMHVBZzhmNkdBZ0JHYWxCMFh0eGdrWkZDMDZxSmpF?=
 =?utf-8?B?bnFSYVZUcWRSNGdqN1B3NlJ0dS82UW1LL0pMZStiUzJQdGVrVkFIZkNDZ0ZZ?=
 =?utf-8?B?WkM5cFUzR0Z5dXhLdGpBSDJlVDAvZWliZmdpUlVHeEJzT2U1TzR6Y00xZ0dS?=
 =?utf-8?B?OEpaa2Rrd2daYTVUQVVUNnhiaDBnbkYrRlNSbmdCRDBvUzRQWkFTUTdHeHps?=
 =?utf-8?B?NXJuWUZqSXNVRVNRemh3bG5Ia1FHbWxTdVpVSkt3dUxCV0RMQUl3bHkwcDhK?=
 =?utf-8?B?OUxXSmtEdGt4NWgzTitMMnYxbmYxRUcxVDhubm00cHVFdnpmYlZTcy93WjlR?=
 =?utf-8?B?cnNNOUF6RlVPM0lHMWoyMzIwRXp6RUNyUDB3eHg3ZXMyQmFlRFVlT1RRVTV5?=
 =?utf-8?B?T1lFcDgySXBEMWt1VmZWSXBXbE9JeHpIN3lHYzAwdlAyTHBpZ3QxdURQd1Qw?=
 =?utf-8?B?L2h3OTdUbEloOTNEK0FYMUhDNWUzZDNVaTVNM2V0cTJvQUcwbmgxdS9xQkhi?=
 =?utf-8?B?S1dWbzZpSXNaeHY2WWlCd2RwWGoxcW9QSm9kWXZoVjJ5eXlkcndJa3B0NHoz?=
 =?utf-8?B?NVNaWG4xanFnVGUyU0ZkenNuKzhqRWkwSFZERStRRDBwZmN0Qy9Xb0JvQkc0?=
 =?utf-8?B?Y0NxVDFabDNtaGY1NzZIVGxkVjVHSnh1bTFsVnpaZzlmVkxmQTdUMUw0WGlr?=
 =?utf-8?B?dFg2T1JRaDhWa2k1TnlYWmtHMlpMMW5GcG5WdHN1cThreU5LM1JEVVI0M2FO?=
 =?utf-8?B?TjloVXVsWHJrZjF1VlFoZ2JCVGZpN0s5T2dSK2NGMzkvVHlPTnJLN3FLdVQz?=
 =?utf-8?B?b0MwRjg5NnJxWnJad2Z1Zkg5d0FaTVdKZVhMaThtWmZBd2ljVnRmM3prS0lZ?=
 =?utf-8?B?WFArOVlhQVNHUnVQb2RRUE9WTzJsd3VyUjVETzQxTUlCSldxOUdlNXJHaTBH?=
 =?utf-8?B?SkUxZXYrQ2VKbjdubXh2WDBCSlZJcWVsNVc5emxjRVRoaWZ4cXR1ck9ESkla?=
 =?utf-8?B?S2FOWFBSTTVlS1NvZzQ5bDQ5KzZYcis4VXo3NTM5ZjRyZE1LYit5WDNTRmZI?=
 =?utf-8?B?VFFEcERSRjI4SEZPWG5TVUU1QmNEcS94SnQ3SUJqanJwYVhlV0ZncTRnb0lm?=
 =?utf-8?B?aEZlVlJKY1U2ZDVacWRxQ2VPeW5ZWmZwejRjdnVUL3QyZTBNQVhxdGZTWVMr?=
 =?utf-8?B?VGdHRWhGc1ZZNlJoQ0tYSnZZeVc0UEpFRHZrYTJjR1lhRkVaYTl2RFJmbWlo?=
 =?utf-8?Q?OV9kyUXsNKu2o+NfR7puJ3w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZOZ1gzREREYlhkbjY5MHNqYWNIUjFOaEtEU01pWFg3TGlNelY5UVlVR1NZ?=
 =?utf-8?B?NTV1YnJ2Y3ZTZTBMenBmb2IzK0tPbWpkVS9zcnBQVTVMRVdYWmI4VktDU28r?=
 =?utf-8?B?Yzh0aDFlNmZCT011OHVWczU2WE8vMXFWUGZmVUZMVkpYNnptS2xmQ01JV0Fi?=
 =?utf-8?B?a1JRMDZ2T3JiQzFyUzNUQWJOdlRucUc1aDN2MlRJUFEwN1RvaDJQTGErVmN2?=
 =?utf-8?B?VjBaMVdyZnYxVkUzM0JDbzgzVzlQYTN2cWZWMHlGU0F2YXJWWmordnRkK3ZY?=
 =?utf-8?B?S1I5OW5hV0ZwU0xDejJ1M0UveDhnY242UmJPYlB0c2NPSmtLNmR0c0F4Vy81?=
 =?utf-8?B?NnFidVhadVVtaWdYV1EvSEV3Y0JaWEZTcHh2VHhqUU03alM4ZnJkS1l6eW1D?=
 =?utf-8?B?WUQ5NTlRYkl6YnIxa2VLajBLVkpsazJLNmhCTDVyVGUzV1lnUGRwWDVpNG5R?=
 =?utf-8?B?eTBRWVl1b25wRWtSQlJEbnZaK2lPQ0ZzaE9xZmNKdW56ZXZoWWlZejFwVFBZ?=
 =?utf-8?B?cXl3bE9yM2lZSnlidnNUQTRkNUxzWE0vc0tmb0tZRXdqZE5hcjQ1NHFEVFRQ?=
 =?utf-8?B?cG1iYnhPRjF4TlRQWGs2M21EdHp1Z3ZJMFBGalYwZGU2N0FKWWNFZG1HODdF?=
 =?utf-8?B?Z1VyL3BCdUk0ZHpiLzVHeWVyMkFSWWdtbXhteERkMDI1Uk9ENmpBbmRNRjhM?=
 =?utf-8?B?OEFJOGpkVWZGQ1VMTEVyZHhEMVg0RXpCSHZhdHQ4U3dMd29TMFcwVzJzRlFr?=
 =?utf-8?B?b2J2dTNSK09GNFovaHRUY3BpU3BNVk85OUt1QWxXK2xZWk56Y1FxK3BBWUsx?=
 =?utf-8?B?U1hrekdpK0dsbk1hME1KQk5Oa3gvcVYzbEdOUU9tU29VYldwQ2p1NFQ4OGVk?=
 =?utf-8?B?RE5ncVdvM3dNN0l4a1p4TytFaFk0WXdHYmxYak9ocGRXdUYyYnpOTWJvY2xC?=
 =?utf-8?B?UUh2bGRPTUtYMzkrWHpkU0M2TDlGWmp2U2FwdVJKa0xyMjErNzhGeElheHJt?=
 =?utf-8?B?eWhnTlpxYmpQSllzYUJMVjlDVEZqUW9IN0dtclRoM29kdTc0c2xOK1FRVzRy?=
 =?utf-8?B?czYzR0lYSktoY1ErM1FJY2RVVm1LRVp2OThRUnIrVDJlRmx4WlhLN1Bicmcx?=
 =?utf-8?B?T0FLWjNlZVYxZGU2bkRxUVgzUmpTcUhXSzZ3RWpaMGsvdFd6a0dhVC9jSmVL?=
 =?utf-8?B?Vy91Q1QvdHl0WkJZT2pZQ245Ny90TExSR3B3ektwdXRjbkszcmFiVzNvL3U4?=
 =?utf-8?B?cWxTKzhYVEtNKzNJR2Jpd2FqMmw0ZFFjWXRuNVFwSVVCUTArVitDV3JaVWh1?=
 =?utf-8?B?bGM0cXZsa0NWV1h0YlVqQ3VZQVdPWU5JTk9Femg5MWVmU1FIUGs3N1NSdHYz?=
 =?utf-8?B?NW5HYzZuRHo1S0FGalh1MlY3ZUV4bXR0SXJGa2FGdmFMRlp3RGdEaEZyTndo?=
 =?utf-8?B?UUc0Y2o3bG9xMStqMWlTM0piaGo2NGdCK3htSElhVVN0L2JwT3RWL01OUzBY?=
 =?utf-8?B?ZXJtajYvREVqc2ZoQkltZERsRWxvZTI0RnZkQXkrL2g3RGUzNGI1bHJqK3Ar?=
 =?utf-8?B?TURBUE9NSVZhSGVncGNadTdNSzZyNEJYajc4TlZsSWs4YjR6OXpoOTgrNERt?=
 =?utf-8?B?dXhmaHhwelNUbTVGbGZmL0pzd1RlWUJlaEdEY05SS052SGJ4MGNLbG1tTi9N?=
 =?utf-8?B?ekUzL01mRmRQRHlRSkZNYkg2d3kvUFlMMm5keHRJQVhudWVFU3R2K21RbDV3?=
 =?utf-8?B?Y0luNitzdlFCL01qc2JaYWQzMng5c3VyYmxySTZ5NFpiK1VGSzVTR2ExanFG?=
 =?utf-8?B?L2FjTEFnWDl4Nm85c0RrWk9ZZjI4K1YzSkJXdkY2S2p0eVFkRHVDS0NGYWla?=
 =?utf-8?B?dEwvTDNMMklsWkpHamNhd1p5bW54Z0F3eThJd01CY205cC96b3ppQytxQlJa?=
 =?utf-8?B?VW82TkordWlKYmNOYXZ6T1VINDB5QjlJRzY5YzVDelFpd3NhVTlXUlhyRGpo?=
 =?utf-8?B?eVhWc2EvbGdqbklnSDJPVXdoZDFrR3ZMZ0hiSHpKRVdTSHFoeXdSS2k4ei9p?=
 =?utf-8?B?RzA4ZVdBblRXdVJrdVNndmh6OHY0YlJIRHAzUWpxdWtrS0ZMSFp1blhvbndp?=
 =?utf-8?B?RU91TytOcmNobUZiUy94djVIM0dOZUVzK0U0SWNNNmJOOHp1VTRLT1hiOG9j?=
 =?utf-8?B?TkxqdG5uYWhSdU1ZbGhCUytiRm93RDlBSnQvMElPOUMvdjRDZXpaVlpuRHlt?=
 =?utf-8?B?WmhzZkRkTWtTYTNLUEJHL3RKeWlmN0FFWFJFbW5aZFFFZEF4Z0ZuaXRGaWZQ?=
 =?utf-8?B?WEgxWVFpWXp4QnBkaFc0Q0YrWnVHVDN4aUNrV0dFbmNKbG1HR1ltUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e9e571-8e62-4d97-25a1-08de6a4e1492
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 15:47:51.8109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYlDEcWNUkitELSDYquUo5VDtM2TsCzwS6KcL2KG9M6i/3jzzleernLaNsZvsqKkpL4iZiYyVZ5fc6O4HEg+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDE1OjM1DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE5pY29s
aW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBj
bGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNA
bnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEppYW5kaSBBbg0KPiA8
amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsNCj4gam9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gemhl
bnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1LzI0XSBody9hcm0vc21tdXYzLWFjY2VsOiBJ
bnRyb2R1Y2UgQ01EUVYgb3BzDQo+IGludGVyZmFjZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAyLzEy
LzI2IDQ6MDUgUE0sIFNoYW1lZXIgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPg0KPiA+PiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDE0OjU3DQo+ID4+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE5pY29s
aW4gQ2hlbg0KPiA+PiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPj4gQ2M6IHFlbXUtYXJtQG5v
bmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gPj4gcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOyBjbGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgTmF0aGFuDQo+IENoZW4N
Cj4gPj4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47
IEppYW5kaSBBbg0KPiA+PiA8amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0Bu
dmlkaWEuY29tPjsNCj4gPj4gam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZzsNCj4gPj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2Fu
dCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1
LzI0XSBody9hcm0vc21tdXYzLWFjY2VsOiBJbnRyb2R1Y2UgQ01EUVYNCj4gb3BzDQo+ID4+IGlu
dGVyZmFjZQ0KPiA+Pj4+IEkgaGFkDQo+ID4+Pj4gdGhlIGltcHJlc3Npb24geW91IHJldmVydGVk
IHRvIGEgZmFsbGJhY2sgaW1wbC4gSWYgdGhlcmUgaXMNCj4gPj4+PiBzcGVjaWFsaXphdGlvbiwg
SSBzdGlsbCB0aGluayBvcHMgYXJlIHJlbGV2YW50LiBFcmljDQo+ID4+PiBUaGVyZSBpcyBubyBm
YWxsYmFjayBpbXBsZW1lbnRhdGlvbi4gU28ganVzdCB0byBjb25maXJtLCB5b3UgYXJlIHN1Z2dl
c3RpbmcNCj4gPj4+IHRvIHJlbW92ZSB0aGUgb3BzIGNvbXBsZXRlbHkgb3IganVzdCBrZWVwIHRo
ZSBvcHMgZm9yIHJlc2V0L2luaXQgb25seT8NCj4gPj4gRGVwZW5kcyBvbiB0aGUgY29kZSB0byBj
b21lIG5leHQuIElmIHlvdXIgcmVzZXQgYW5kIGluaXQgcmVhbGx5IGRpZmZlcnMNCj4gPj4gYmV0
d2VlbiBub3JtYWwgYWNjZWwgU01NVSBhbmQgdmNtZHEgZW5oYW5jZWQgYWNjZWwgU01NVSwgdG8g
bWUgaXQgaXMNCj4gPj4gc3RpbGwgcmVsZXZhbnQgdG8gaGF2ZSBzZXBhcmF0ZSBpbXBsZW1lbnRh
dGlvbnMgaW4gZGlmZmVyZW50IGNhbGxiYWNrcy4NCj4gPiBJdCBpcyBub3QgYW4gZWl0aGVyL29y
IGNhc2UuDQo+ID4NCj4gPiBUaGUgdkNNRFEgcGF0aCBkb2VzIG5vdCByZXBsYWNlIHRoZSBub3Jt
YWwgYWNjZWxlcmF0ZWQgU01NVSBpbml0L3Jlc2V0Lg0KPiA+IEluc3RlYWQsIGl0IHJlcXVpcmVz
IGFkZGl0aW9uYWwgaW5pdC9yZXNldCBzdGVwcyBvbiB0b3Agb2YgdGhlIHJlZ3VsYXIgYWNjZWwg
Zmxvdy4NCj4gPg0KPiA+IGlmIChhY2NlbCkNCj4gPiAgICAgYWNjZWxfaW5pdCgpOw0KPiA+DQo+
ID4gaWYgKGFjY2VsICYmIGNtZHF2KQ0KPiA+ICAgICBjbWRxdl9pbml0KCk7DQo+ID4NCj4gPiBT
byB0aGUgdkNNRFEgbG9naWMgaXMgYW4gZXh0ZW5zaW9uIG9mIHRoZSBhY2NlbGVyYXRlZCBtb2Rl
LCBub3QgYSBmYWxsYmFjaw0KPiA+IG9yIGFsdGVybmF0aXZlIGltcGxlbWVudGF0aW9uLg0KPiA+
DQo+ID4gSSB0aGluayB0aGUgbGF0ZXIgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzIG1ha2UgdGhpcyBj
bGVhcmVyLg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgZmVlbCB0aGUgb3Bz
IG5lY2Vzc2FyeS4NCj4gDQo+IGRvIHdlIGhhdmUgYW55IHdheSB0byBpbnRyb3NwZWN0IGZyb20g
dGhlIGtlcm5lbCB3aGF0IGNtZHEgdHlwZSB3ZSBoYXZlLA0KPiBzbyB0aGF0IHdlIGNvdWxkIGhh
dmUgYSBjbWRxdiBvcHRpb24gd2l0aCBPTi9PRkYvQVVUTyB2YWx1ZSBpbnN0ZWFkIG9mDQo+IGR1
cGxpY2F0aW9uIGNtZHEgb3B0aW9uIGZvciBlYWNoIHZlbmRvcj8NCg0KTG9va2luZyBhdCBpdCBh
Z2FpbiwgSSB0aGluayB3ZSBjYW4sIGJ5IGNhbGxpbmcgSU9NTVVfR0VUX0hXX0lORk8gd2l0aCBh
bGwgc3VwcG9ydGVkIA0KQ01EUSB0eXBlcyBhbmQgY2hlY2sgd2hpY2ggb25lIHN1Y2NlZWRzLg0K
DQpUaGFua3MsDQpTaGFtZWVyDQoNCg0K

