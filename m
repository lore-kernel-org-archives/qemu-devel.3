Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75D606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CrPV7Ydx;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=wRNfyh3j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK7US-0004ko-6Y; Fri, 23 Oct 2026 01:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK7UQ-0004kZ-2k; Fri, 23 Oct 2026 01:06:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK7UM-0005UV-HL; Fri, 23 Oct 2026 01:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792732006; x=1824268006;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=elJfo2wI1UNDZRCfkVXlbGlpduZhRvxjQDSbpqvD1Do=;
 b=CrPV7YdxVfnGSsaSKm+9cMRM4rip9gcsWae/n7SULlzXQH+ScNsIW7KZ
 yTPCIjo/vk8cFBz3N3SHXmaJM108awOcBbKMU7X+dkX5g5Qx21/8AL2cW
 wMMVpbTX+W1cBX+6DWlm4ciCVSAe2C2zodHPuXb0Yt6dPQ1p1jq7mzVJS
 hASEdOugG2xe+OQ8BKXmBfJPy+u6vic6Ssq8gklWgk9V2oQHUKnZfR0Rq
 +44c23PgShtGQ/HQJB7gawJtitYb6NgN8VtoA9HSOW2SKXF0rwv5+qQ5a
 K+4PUJLhTZl4y6RhOY+6KWwnADTjAXbLm1iCfODaJhtiscS5X9m8k7ipo w==;
X-CSE-ConnectionGUID: Ix14MgDaT4quu3cmxkZ2iA==
X-CSE-MsgGUID: DkQz5ZjMSjKyJZKh2ivN9w==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="157848121"
Received: from mail-southcentralusazon11013025.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 13:06:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZx9mM9P9yqoTAYNdYXf/g6VzKBDvHh+rDeLt2AZDN4gz6no5wfXeCu/Bk/XwrFimHshhbNUEWykHr14UsOpzZsvJ38DCScFl752pZ3aV0vc1HigTU/xeXLC+57bMES5DUBnZ8fHAmMXVJy4+30JqvPV08rXFYTamcy9hICmsDnJCqO56YUvOHCuc4iL1x5/p8b0kXYC6foO7yd4eMMUqO3MHf5+eMQHhmcNu/uP2bMMGDbuoTb2NtMMnEsmJhejPsWWO5CYsWq6sUAetX6Co/oO3uejj/KsVsd2QoEn4141fZbttzs4BweBfMBjzJYW2mP2F2Qq/MCa2FmWJJYcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elJfo2wI1UNDZRCfkVXlbGlpduZhRvxjQDSbpqvD1Do=;
 b=bMqlvBjUcpgjc5T1UPC5aSUUTWeEGNuWVQW40PRPMBeLmwxFP2RdtB0bRAl4bIOProNuu9U3xcDI/2NC5bh9TQiBf9cLx7y7blb0xMypYP2yeoxyUAi6zgCK5lqsMCqOOYIDld8B/F8rxC9SWsZkJL/U2aepQWAmaVnqxzLIAWSr71r8sjpw+xvd/gh+KjMRP1vHVPv3o/KQOnlRfUB1ydJ5S0jTDmg89pcIcN2mU4AzQpMAwjk3bDzL1/CmmlzMctHSQsdeNj4udVNjQeMg1mPRQE6x56bxMrKUDQCn19ZYvw9HeISnD7tNlTHv0IwfGl45HFiu13HCREDEe2oVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elJfo2wI1UNDZRCfkVXlbGlpduZhRvxjQDSbpqvD1Do=;
 b=wRNfyh3jqgKX2TGdQyjwjfzRR/4CTQDcRvI26fimvHYzS9BuFiX0XxESw5/J2E7pkOb7Yt8ibwi18bZ/bwi0FlQyf1Ba+3fS7i077a80uejDfP4/O1maeKv/PDv4KY+s6riyBzYENqFyLjIyOWUh+CSaKX7p2w92oCoiQ54EP2I=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH0PR04MB8227.namprd04.prod.outlook.com (2603:10b6:510:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 23 Oct
 2026 05:06:41 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:06:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] include/hw/intc/riscv_imsic.h: remove unused macro
Thread-Topic: [PATCH] include/hw/intc/riscv_imsic.h: remove unused macro
Thread-Index: AQHdYlH433P5rcgYqEuBohlzyv3P+7cKk+8A
Date: Fri, 23 Oct 2026 05:06:41 +0000
Message-ID: <b1ec32eb8419d59c69999742b7b35625ff9f060a.camel@wdc.com>
References: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH0PR04MB8227:EE_
x-ms-office365-filtering-correlation-id: d91b6722-baed-4295-f753-08df30c36d12
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|366016|1800799024|18002099003|261021123027099003|22082099003|261022105027099003|10067099003|11063799006|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: XX2hhrgtzzRvchv4nxfmT4YPAFvZQpY+/7QFk1VphCANBUoB0d6+a+uXr53w44oKEv8rKIKGth7bwCG/0wAYQrpWhMB6swRdCSN0H89S6hrXom0mUpkb3NyMzGaHq4rhjxb88uVmdl3p1pU9tubuDhLMhrycz4I99/nM5qf550/7YTNZi1uMTqK1TzAllWYV6kRAHt+E9e5wbuTzE+cqOLuydngbmMcey9mpE0JTjrk8yTUnpUIC6I0wTugunpifEO6fVxF5Lu3qLuV+mDjeRl0ZvP8TP2mLuXuNGnvqPYOfkmyhhUsIaLUbN/38gMvt7yFNM5myST6eSmBqplzGapAmEJSF3BEfbRVQpsqK4pw45XKtmtWtwcdqhso9uFn0yfHOsT8C0dhTGQVvohIPkIGQnwarhBrZgrntTKiHv7A8axUxshowjlbnlQlO89A1TLzQhACG0PSTzk8Z21GrXO5otMA7KEAj0uxymUX3rgiXGPlld1/89K9zG367lkS25j/jC1iCsziPcFIkOsvzF9Qs8Bu6QjE7FZjlJO5f+lQr8EltRECE1zHJCqwSEY36IHcfz9/jsXoOrmcvMDhwmrGVGK61Z67T90mWzfPoovw1UZ1DObX1jfmF4dcGP+fPonBZjsSs3fbU+zAwuX4GXN7+F5Jdv3wQ04ZSn0ZqXaTgWBcIYhYsFP2gH+JXfy47NFIw3YOuNE919poGAKc8/kDNzV3MLnn/MJzTBy4hKgY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(366016)(1800799024)(18002099003)(261021123027099003)(22082099003)(261022105027099003)(10067099003)(11063799006)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xpRmVpQXhkWWRLQlRLTElSajNBN2ZoWGkwb204Ylh3RWdEeUhiTEUyL2tK?=
 =?utf-8?B?b09uVFZHV2hoV1dQU2FTTWpZSUQrUHl1Y3FPZWNQWlo2SkI0TkswZjBXTmo3?=
 =?utf-8?B?ZE9HeVU0WDl0ekFzNEVsdllBTUtVSXZscmF0ZGV0cGczWi8zMzBkeDRSbitK?=
 =?utf-8?B?RDhHT3R6dFhwRStxTHVXQ2RQOEhJQTZEeFFUZFFjbmFQN3ZHOFhYQU1RMm1m?=
 =?utf-8?B?OVg2NXd1WlR4aVpJMWMzK1RWYi9sNG1WTGNRWUpCM2NsSndKRDJzNmN5T0Iw?=
 =?utf-8?B?OFVReEFhZzVEOElKU1ZFTlg1YSs5b3hYanE5NCsrbTdQaE9MVUJxUUlxNm9F?=
 =?utf-8?B?ejRETC9TZG83d1RvY1dFdC9oTE14M1U0V0dJSU9xTWxoQlZ6cjdYQy9tdkhG?=
 =?utf-8?B?WnpyTmIzSEF3NSt6bm1Dd3kyRWp0c0x5b2dhWnUyOFlWTk1sYVZaWnE0ZGFu?=
 =?utf-8?B?aFR4WktwLytVOXp5MGh2L3FlVjVOTys0L2hDaXV0WmZVVjJCbUhFVXRDVzJB?=
 =?utf-8?B?QVNHNC9IQUtRV09wb1JzUTJSUk8zK25kVzJHQzNXSXkrSE9JOEZrQkRWYXRu?=
 =?utf-8?B?Y2xGaEh1WWtBSWpVaG1ha2tKNlpkUUhxbkt2bVFiZlJ1elFscXFyY1BqdGk2?=
 =?utf-8?B?L2RUR1d3NDFDL1NkTFIvYjBOWFRzNmg1YktuME92TmRFcFhRMzdLcVBDM3hY?=
 =?utf-8?B?TERmRXR6dUFkTTVUQ2YrY3lySFpmTS9xRmloSEJwODhYQ05kd0p0WjJGQnRB?=
 =?utf-8?B?V1AvQ0Y3KzZCWDh1NDZPZVBnMjgyR1VCYisrMzdyMTkzWk5qRVFqcHJJMUov?=
 =?utf-8?B?WHR0N2NtWWg2MUwrWS9pTHk1MXRUYzhKUTlrOFZ0eE9nV2ZpK29vbHFZMnE2?=
 =?utf-8?B?V1RsdllYS2J4NGd5Q1h3M0ZnQ3JMS1RBQlpxTFEzYjliNG5KUmprd2J1WGZU?=
 =?utf-8?B?WmVGUlB4elJwNCtZZ0tMOXR4R1hEOEVTdWtBS1ZrejRnWGFlcUwyS3c2Nzc4?=
 =?utf-8?B?dVJ3TU1ORVZEalpLdWVGZ2Z2WlVQSzZrWW1UUmlYeWZDOCtIcE5NNUtNMm4x?=
 =?utf-8?B?bWsrV2RKNnA0RlVyMnVhcEVzdGpkQUxuQ0FmYXFyY1FaaTFIQXY4OFFGQzZ0?=
 =?utf-8?B?ODZhMElkZE9OSytpVEFMOXpBZFljMzJwOFRkek5ETzh6R1Ztd2F5Y3V6a1JB?=
 =?utf-8?B?bEVxRENlZUhITWJnYktvRk8zMHpDTzd1bFUycnVCQkRvYjU1cE1YZFN0TWh0?=
 =?utf-8?B?UUs2YlRIdzlJWDArN0NvZW5acUFMS1c5MVZ2TkFWSWh3dkpoYS9QaXY4TXVp?=
 =?utf-8?B?NGp3RFBJUnRRcGl0SFBJdTRWVHg2aWxXZkJXSVZsbjByUEt3WDhjYUs2c2ti?=
 =?utf-8?B?WTNBTUVRNzNpM1dDWk40amRkeEJBWjI3eEE0ZTNFWVdWSHdnNUU4NDM1RURO?=
 =?utf-8?B?SXp4V0JiUmRkRkxYSEtFZ0RsL3pjRW9oR0FPb1QzK1pPdFRPd3NIcWlwVlEr?=
 =?utf-8?B?YWFLMVlXWDF0WW1TVWhLQjVLcVpHOUdtcnAwU0hJcWFPZUFRcHI2YzdHNVYr?=
 =?utf-8?B?QjNZS2grUWk4ZmhkVzBRTWE5bWIxZnlCd3ZOdTIvanA0a0VZNEpPdHZjSTBH?=
 =?utf-8?B?UGpnR2NJOGJNN3QrcG9IOEJHUlZOYXhFYmE3RmNVNGZ4TmJFK0kyVjdFN1pa?=
 =?utf-8?B?U1YremhxWkhJM2c3WTJDc1lxNHNWUGRWa2EwbGRaOW5oVmRyMVhUZDVpSWRp?=
 =?utf-8?B?Qk50UnRRQmo3Q2F0NWRaSkp0UmJRbUV6TW5EbzM5Mk1XbklhY0F3MGtxczJj?=
 =?utf-8?B?aXpnZ0Vza1g3VUFQMmNaUTZpTld5UHkrNFFRWGpMdDN2Vmg4cktHYm82cXQ4?=
 =?utf-8?B?eG02c3hwbEU1Z0E0cnhFUjVHT1dLcktCQ1p0TlBXVUlQSUdobi9tRzBkZFZk?=
 =?utf-8?B?ejRzZGZ2QnU2N2ZSNFNvc3BJZlZSU2VSOXpiTVc1L1AzRVFCbmVJZHpJdzFm?=
 =?utf-8?B?SVl5anFYSnU0ZzRlWm4xVHBzUncyUFBTSm5GdmhHdWxFbHBPSHZ5UHV2QTM5?=
 =?utf-8?B?N1lvaUNtM3hnUFh1dW1JY0dOYVdjU0hwUWVSaFlFT3A1b1B2UHZxWThXNHhq?=
 =?utf-8?B?ZHR3Tnc4QmRTK1J1TFFyamxvZG1QQ0h3OUthUDR2MU1xTEhRTWRsTkhBNmcy?=
 =?utf-8?B?TVY2c0hPdmFCN1d5dHk1eDFvQUxKSXVzYVFvSUE1WDhHNVBVWndMMXNVRE9L?=
 =?utf-8?B?eWJZN3VPZ0lxSG1CaGQzVS9OMElwSCtkamVYTXRCOGZKZ2pDVG5uWUt0aHBm?=
 =?utf-8?B?Qi9wZjE2VmR0S2k1WmQ3N1k2aHY5UzFXd2paTy9JU1k0SU85cDhGMnBvNzFE?=
 =?utf-8?Q?dd4BALay38BFDn2xvAqWJIbrjS4EvJB9mL8N4u2c7tT5O?=
x-ms-exchange-antispam-messagedata-1: mkwInje77IymmMDdTYDmQUCe85uyh2ESyIs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1A103F4478554AA7AEA09472A963AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n/5nD1zraad9fTWfovxDNvnbWNqLeZgTDU4jgBU+TZbcbbXYBZR3Eev1mFOTw7rznyzMcLYY7GJve/oWbhj8Aen0XclysAcu4eGSsa+91AkV5vRwX1EwhGj87sZCQBoOk9W46lC6sbg6E1ubinlVjPeIozGrqoXoy5bTjwgj8MOz6xos4eIPl7+Nyd5Bqlx5UksRDRRBv/NJ6SmDFL7M8cIPI8jWtfvyf8EytkYqxRlKXipgsVBQ4i36gtO+RyxnQkLYAma/bfv57TsH+IHo9x/RvDl7xt88XtjUrhiBW1w/fbOAjapHQ+I9QbbGeZ9smUzZvv2LqiIs7Nh0XmLrog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dqVyS5KOy8ByACUoe5py+4vLj4jR35WbddlxVoZxQl98aB4vspAMdocnhw3+hB52UrJ3pyQSxH1UBRDsIRHFoHZ0fqU5yiLkiV2qClCVlE5TY2WwecAYXqV4MCi6JoZgo9bYAI1U5kPL+0/9IWgFCY01iBliBN2om4Jinzfq1sonyViPNkgjybbmdBsbT1AP7ozYd4sBnhBdLMyxQ1h+99NQaMS5u55/CwJZ2RnomcWxGXeV5oMN9Uip6aGG+1BpmHiw7VpLYMj3p3vN7hOuX3MfYiuT7T+C2qosIIaYtYFxDQaly3y7X3VzeT3WpFlYv/DepAkvkVdXaMN1Su4imhE48Yd599FZPpzJKKstSG59h6tVuGdsgRuHqIO3gD3CmFcNsOSy/gqoL1fQEljcOeeKnpqfoagMwRJFMuf/0XxFFMvEaRX7bTompglMbPdDzlDAdnGDXL8uP3f5f+Aqefh7Nlik0FBUekk8RlPigwFnvia53CIGUQwesxUjtT4GhhdapkhQkZQcNKZ6d0Rn4DwxAMQLsFnT8Cj8E8qAoHYSD9u6d9NAIVFXkKjvjia8Qy5oVjLQbMDpmIGs+WBKocGxxZuSkrstiH1RpB7mJAZiJIoIwcCpQew2JrSl2bEZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91b6722-baed-4295-f753-08df30c36d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 05:06:41.6528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtLR+WYJJaHdah4GF7BVGOt3cDtpIH9WXFXd+eX/uS5k8zLFBmvKoGQ8ggjmpXRL0B8HZ9OrMO5PsNnOVGdejvRqvOfK48vBzCakwumPJeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8227
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDE1OjE5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gRm91bmQgd2hpbGUgcmVhZGluZyBJTVNJQyBjb2RlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5x
dWFsY29tbS5jb20+DQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0
DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgaW5jbHVkZS9ody9pbnRjL3Jpc2N2X2ltc2ljLmgg
fCAxIC0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvaW50Yy9yaXNjdl9pbXNpYy5oDQo+IGIvaW5jbHVkZS9ody9pbnRjL3Jp
c2N2X2ltc2ljLmgNCj4gaW5kZXggMGExZGYxYzJmOC4uYzc0NDgzNjY1NyAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9ody9pbnRjL3Jpc2N2X2ltc2ljLmgNCj4gKysrIGIvaW5jbHVkZS9ody9pbnRj
L3Jpc2N2X2ltc2ljLmgNCj4gQEAgLTMxLDcgKzMxLDYgQEAgREVDTEFSRV9JTlNUQU5DRV9DSEVD
S0VSKFJJU0NWSU1TSUNTdGF0ZSwNCj4gUklTQ1ZfSU1TSUMsIFRZUEVfUklTQ1ZfSU1TSUMpDQo+
IMKgI2RlZmluZSBJTVNJQ19NTUlPX1BBR0VfU1rCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFV
TCA8PA0KPiBJTVNJQ19NTUlPX1BBR0VfU0hJRlQpDQo+IMKgI2RlZmluZSBJTVNJQ19NTUlPX1NJ
WkUoX19udW1fcGFnZXMpwqDCoCAoKF9fbnVtX3BhZ2VzKSAqDQo+IElNU0lDX01NSU9fUEFHRV9T
WikNCj4gwqANCj4gLSNkZWZpbmUgSU1TSUNfTU1JT19IQVJUX0dVRVNUX01BWF9CVElTIDYNCj4g
wqAjZGVmaW5lIElNU0lDX01NSU9fR1JPVVBfTUlOX1NISUZUwqDCoMKgwqAgMjQNCj4gwqANCj4g
wqAjZGVmaW5lIElNU0lDX0hBUlRfTlVNX0dVRVNUUyhfX2d1ZXN0X2JpdHMpwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXA0K

