Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF25606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Pt/xaeBB;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=A5XZi/Fh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0IW-0003vv-3v; Tue, 10 Nov 2026 23:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0IS-0003tC-Nv; Tue, 10 Nov 2026 23:50:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0IQ-0001bq-HE; Tue, 10 Nov 2026 23:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794372654; x=1825908654;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6rBpms+b/50CXFJvABTCzNHTD8+swqBHGeVMuRY8G5k=;
 b=Pt/xaeBBW9Z2pzeFU63MkI3hdVyHJiUhZNnyyNd6isXW4YB8jxWuIDDK
 y8Cc5pys+Ku5CgmrGKhzn2z4bs3ufJlK9SgARoF8viZFFAAm1TEp5oJUX
 OIV743Tnb4ucE+V8tKj5cAs0S+AuVQPB246AJVEgcBqPHQt67wC8hjXqs
 gHmf96gO/l9or4Z+DVj4Ulru99EBGNu8aAKwUL/SWwEh6X2Y8l7tNobDV
 GqqFcICiHRKzvKXW+tw0c3UFaS7EaG6CUsA1rvi8vYuDfLae0tak0iRZ9
 XIPeWULOGjo+jT3B2k65G6qIGxwlN4Ky9CVPQRjoVFln/zYRrYEgeZ+bc Q==;
X-CSE-ConnectionGUID: 8Eo/6mRBQD6e/WJL0KrSqg==
X-CSE-MsgGUID: PG3UTOUcRq+HCs4IVWX4kg==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="160602696"
Received: from mail-northcentralusazon11013028.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.28])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 12:50:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYndqmGbwppat5UGwjjcPJpYad/uUl8S94LWsd5JLj2bExo5vdqQOCxRj/EJNw9811TBEcn9vgPNHkVZUf8AlQqSVpDHud/+bbYA4v255m+QobWzBFOdaQEe6/JEpP/W94aVqf1vpZVE2Do/oj18kaJPcUV1gYkPCLsBf9ivoYAlz5z2HOA6JHqVghOjlXFox71DL0Oqpl8RkxzgQ+yRB72bsGZ9iz6LgEv+I5KLgh2EjwlC2Uj+62cLUicsJ1/K6YtkYnR7c0H03JtDCAEKi8lHQRzfHEMtzJK6C6vuKZkjap4Xx+2kBXX4z7AgXAbSAdsuGbO5CHIa98PazQ62Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rBpms+b/50CXFJvABTCzNHTD8+swqBHGeVMuRY8G5k=;
 b=yVeFnZ5rqvDCbTvCkbYQF9MkNAJRAkdNmDBMk7iUiD9PxEASk7A5N6+h5tTDVwMbmJ7e03sxS51uhDnAL8PNIUcs5sLuzzdw0mDIT3z79dglVOz0YfPnVR58wG5EYzoCcU4Lvq0gZEoH4JX1EULYEN1Y2mY9pk0B+zYIA+Wj2jVMvufo5Gez0vpQ1AriFRICGDv7dRPrThgXJE9YJ08T6zWlssUevsizyfjacZ5Ju4MNaSmmTgWZHRnPpCdgUEn7fkcdOdZKnCGBkaEe5OnA7D4lJDwDJTDDl/u9Jyaq8S7OsEzzaz2ysHv9pgZStt3g59LVpLgqIsQuv1yUSpL0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rBpms+b/50CXFJvABTCzNHTD8+swqBHGeVMuRY8G5k=;
 b=A5XZi/FhXfq6ixLMKVlovSvVs9alrW8jymRCYeZZpe2e5YvWgg/obLD6cV0a7HwOnQKdqvkHh7An1Oqd5YrirmX8pPpG8U92OaykO+rWL5e2ySFKZjlXvMar5+G5dOf85ovn9SzPklt8OYKfO0SZTl92Vj6v/wLmiZ0lkzSjpQw=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by BL3PR04MB8201.namprd04.prod.outlook.com (2603:10b6:208:348::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 04:50:50 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:50:50 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "ralf@vmexit.de" <ralf@vmexit.de>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "ralf.ramsauer@oth-regensburg.de"
 <ralf.ramsauer@oth-regensburg.de>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "lukas.landgraf@st.oth-regensburg.de" <lukas.landgraf@st.oth-regensburg.de>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v3 4/4] hw/riscv: share the PLIC interrupt cells between
 boards
Thread-Topic: [PATCH v3 4/4] hw/riscv: share the PLIC interrupt cells between
 boards
Thread-Index: AQHdYmMQw2Rc0sF3D0Csjm8yieB7bLcoa6kA
Date: Wed, 11 Nov 2026 04:50:50 +0000
Message-ID: <79e04a262eb70ce038fc07ce22980eb51b8565ba.camel@wdc.com>
References: <cover.1792700406.git.ralf@vmexit.de>
 <1fab0bc3d752c924f1c83f2a1f59cef0f520c62a.1792700406.git.ralf@vmexit.de>
In-Reply-To: <1fab0bc3d752c924f1c83f2a1f59cef0f520c62a.1792700406.git.ralf@vmexit.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|BL3PR04MB8201:EE_
x-ms-office365-filtering-correlation-id: 4363989b-0b49-45a7-9553-08df3faf5bee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|376014|7416014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: l/7a8rNJSMtJmWcEjwSKfHHHUIjFcrlypzvjfvqZ+O+ARBuaLoUBmCWT3NkI/X2IFRYlPFc3u6vHZm0w7K1kzm4umtIDQcQpyGSqnSxikwYRsREGPHMByJTGUObc3BCd+6lXgCEwj7JVyofRjPgYzBbX4oXp6IO10a9MPK4MW+X1a8pcCaMr/gzoNVWN11Ti3FL8YE/vPqQPEDkZ98ptO8kc4akcVhyvIngd/CfWCPpkNKzjRS2Brt7ZvWpYSNEboD50y3dv6CN0PzSiEDFp17Vpd/ULc7tr7bWM1DxeVgTL5wI7gIZOzCEUq2Go8LzJfTwuuDMP1U+ys5XPkz3ily2V3T2ueqPpBGXJNr4FLuiK5G8hhJHj3i0jyNIYElt1LMzCWlje01T/0NdQ+qK+f0Fb3OMmr7lJEBmOzRC9o3gYkAFM8w3/jRObs8jI0mh/oEoHrdxd69e0ozROy035C1pLiLM9P9pNqfs/mnbhCFi3ubsqQnsw4FmAdwLTwqIMIDp+nItcaYcepVrz7K/DYD/UL0kCif3mztT0mR9cFSyga7agPfXoGdVOrOhjbf0AsuV6X3yFCCgPhgqDM7T03LLaeBQZsEx4JU8mKrtB0QNyWToO+Xsdp3RPoxQcr9oSLuS6Kehf/r+ePSPc348/vkbxT6SI8brVVpaP7jAdIF1rmj1ewWrnG/qIjHAVBOj/mANxRX8M6EvNJs274icDZs+QayYJeI/GcTvOiKsqTSI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Syt5ZGNGN04vaHl1cWxXRFliREpxQmljV2tyeTFDZENhUmZSdkVZd2M1K1VY?=
 =?utf-8?B?a1ExdFBTeGl1SDZlWGFwZzZHWFJEMlU3UjNEbUlXTWFPNnlJS3BYbGhraFht?=
 =?utf-8?B?RlVueCtPQUpIZHl3dllYWlUxN0hCYnU2NlFSV2xmdGlBS28vWkhzTTE0cDlC?=
 =?utf-8?B?bkJJaUZFMWszcGZEMU1qNFR6VUxiMkpSWVdJNWdlZ3V3YVpGeFFJeG5jaGxE?=
 =?utf-8?B?bDlWWTE5aGg0dW15TlE2M3ZwcWpGOGRXdXlYK0ZHTnNRODFnTVhLaHJRVXZP?=
 =?utf-8?B?NnZOZkEwalRZWXRiL3puL1BxRW0rQTlwS1piSjNMQ0F4T3VBa2VGZkt6N0tE?=
 =?utf-8?B?cUNER2JzK1VmSzlRR0Q3cEpNV09LRjFpb3Q3VUROdUxXOTRQZlhlVFQxM0lM?=
 =?utf-8?B?NUdEWFlBR2s3TWpOWlNFbjRiMHhaalhLUGxtN25ZN210WURWMlBHSTR2ZzhJ?=
 =?utf-8?B?NXRCbE15N3N1ZVFUUjhyQzZtaFBjTXVMTC9DTktqaFZBNjZ6VDd5NE1OWXl0?=
 =?utf-8?B?NEoydEZNenlRVEh2MGJKalVUMmkxbjFRRHZvTnVVZnZPSEVnTkUvaVEweWtv?=
 =?utf-8?B?MGNSV3BJdzllU1ZiL1hnYnpYaURZMy94TzFIOE44VnZoNVNpcW9Td0R2NUho?=
 =?utf-8?B?UUlac1plSmFGYXRHSm5vdkdRTzlFU3YxQkU1R2MySkRXZG5xUTJDd21GeTUw?=
 =?utf-8?B?aStoclVqK2pIQzBXVE5kTGw0OVR3OVRlT210Y05oTjhCczdGTmtnSjFZK1ov?=
 =?utf-8?B?Z0Qxdm45MHh0ZkxwajEwNGI5QmhEWXh5WEo2aWNwaTl3SWVqdnZaSGs2YXND?=
 =?utf-8?B?MXpENU1kTUQyMXFaZE90WVZueVBvcndSM3Exd3EvWnFyQnVrVkZSVGs5d0VF?=
 =?utf-8?B?UVF0SG1GSkZ6TFBHSDBQWnp0S3hBWWdaN0daMlk0L0dRUjlMQU9RcnY3SGVr?=
 =?utf-8?B?Vk16VzVaZ1pmVmRrWlU0aVdnL2VWc01laW1JT1BYR3hRYVRSK3AxSGZxSkNp?=
 =?utf-8?B?b0pZV2NXRkZ6QmRTSDJ1SXFubTYrTFRKOVY4R2FCUEpGS0FuZC9jNGI2eEVS?=
 =?utf-8?B?aTdPTWU2NnRyOHoweFdYN3hnbm93WTJ5SGdYdnB4Nmd1cmI4d3NUVVVrdzNj?=
 =?utf-8?B?NXJXb01XTHJTVmx1eFNOOURzL3llMm9vd2lNWVRFRy9YeGtQVUdaY0VEeTVx?=
 =?utf-8?B?dHQ3eGgrbWdBYzBMV2FibkU1aU1acjZXWkpnRHJkK2hCWGoxZ2d2Y3VKTzMx?=
 =?utf-8?B?UTFrdkhVcWo3YXJEYnoxR2NRbVc3cWhHV29reStQSVpJUHRONzhQZC9Oa29R?=
 =?utf-8?B?dXpoOENyMWdnNzhib2FJdzlTMVltTi90Z2xGZmhSSXFWcjgrQlVVSklJM1FY?=
 =?utf-8?B?bEpoWXpld2lTQndRZlc2ZUJiZ1pjWHFpRjlkRVFRcTRPeFB2aTFya0ZCNTVJ?=
 =?utf-8?B?a0JCVGV4cFdHakhMOFdpVU0reDEvdzFBenB4czJiTXQ5V2RhZWY2eWZCdnN1?=
 =?utf-8?B?NXA0R09rYW1pYkdQa1Z6MzUrRitmVnR4Z2NMUFFEY0xQZVVzUFdDbnVDUFJy?=
 =?utf-8?B?aWdaSXdLS0pKeEZPbVl1amdlS2ZCS2hmbUNPYzNBdG9CWER2VnYzVnVXcjR3?=
 =?utf-8?B?SDFhKzZWM3JUMHlTR3pSQmxUSFBuWk9WUVVvR1hkQzNXK3dDMElqSUxhZ2Fq?=
 =?utf-8?B?NkVpVlgzY3NCL1hvSTF4dEFZalpRSktVclRNZTdRNG9vZEhzSDQ4UFlxRTlK?=
 =?utf-8?B?RHNYSTZnZGsreHpxaXBaQzRoMGVpK21uWmxWT2tucjc2ZjR1VXBHTzJZeWpU?=
 =?utf-8?B?ZitIYjRObm1FakpTVjNtWFJORXFmNlpQQjB5cmtNMXgvSGRGZmhmdFVOTjYx?=
 =?utf-8?B?LzJpd1BBV0M4ZkgyUTF1cmdiYndnWitoZlYyVDNyMzVybHJwb2lobTBEL2Nr?=
 =?utf-8?B?aWNOUXo0cE92ZU9PN3ExUFkwWjN6d3N5Rm9vZVJFNFJQSnMwOTZQY1E2WWJK?=
 =?utf-8?B?aitxeHlFcjlvMFVrVmFZcnpJQldXcEJrTzlRQWJmTHdSSGxrdEI0Qml6RllG?=
 =?utf-8?B?ZEUvUEh2Q0dBcVNLZ2tjSXhPUEJ4NFBNakRSVEVDSUJpNmJlUzJUT3dCRytp?=
 =?utf-8?B?NHNrbVVac0RMdE4rUkpWQnMrMExKVmsyWG1SV1BEUVBoa1JyT21adDEzNUR4?=
 =?utf-8?B?MHNlUkNxL3RUL1dkanJtaFUwRnM0c1prckZVRjVjRTFpWktZenBmMGdubTVF?=
 =?utf-8?B?T2REelR1ODltZ1VZek5nc0JndFVFQ2tpM25Ldkg0bWVoQVFKTWk3MUY3Wm1Y?=
 =?utf-8?B?N2JoQkszOWFuUjEraERuNTdicURvc3JlT3Q1d0FoVHdyM2RoLzUrTUpIdGd1?=
 =?utf-8?Q?3OIwRH6pjGR+geAeM4VqtNMfQsNq7CZHhRFxfPM3qomTJ?=
x-ms-exchange-antispam-messagedata-1: F5H0boc/f6EIQFu7zz9NSlRgaQA1HEblyw0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2872EBA7C88E1E4AABC3C3920DC18CB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xOfzwKT+kb7UFVKuUwGvBDbsseinpE27DAhW6hKF5Jp0zKUg90Rnt109y6RovzhjIgOPIGMISlE2GTZ4k+uBciFEF4OqWJq50Z04KX10MROnUKgH3EKQZiYW1S6v0MBhI1EMYhGif0ocd4+ZBRfp5Lf/Fpm1jUv4ybEMPBao9ZDclmch6OKhwIBVohfI0EPupLetDZhb42dewtrwdUn40Sc+UIGPySbFEvKrNBtzyFiR9Crr0QTXQdDhTWCpqgeFs9YnuZ2OpDjy2araqOaGWKR3UXjNNIUZt/zb93GwNYoXaKE30nw5jNL94xP84fPfdtQrfgHQHpMAmWfn2Abg1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cX1pazWXzpx8ZgjE3UNbZix2J4MyhWlvwv40QvXyprnvpxHu0EGRH9kPFRYxuhF7Eag0wO4Yq2Y1U2lbZBW/xa6+dVazP0EYmrrTmzXGRLX++QgPk/PsdHe/cQgZZTfHbHWYjmdPoaW8ueaUjtGNS91cT7csSrlblbBb4Y9xfk+JHKhN02jHCPiL54IDv4k5hBaqYPqh5+2wsnL94iWO5i+XtvDuYSkfTjIfAp8JRrvYS1enbazw1LAjHG+oGklI9l0a3a4CJA8+a5eY8GxLwmF/g8vftQEewDedvEHi/itDXSJOJ5PfmYaaARakUcSBT1DYhiAYrQoIJC4aoChodLcexNU2ic6H7OKY1woMqfNW7kmZ3BLYrdZft4RHO9ZB4M8srQtOZFIMkkLPQSgpaOCItTE5hjhtqETGsYT2OO0lrQhCJzoze+p/LqLUjzLKXHwcPu1oTKhZyKGM075HHoDkt4m5LfvpEndCuO0XgYVGan4NaT3K2cFTTtJx/GiKYI397xyPyIuy2KxzGQL+DXFUU4QLzEkTFwxPNfOB8UOG2XImmdFtaYrn7tYR94SVhjeWNVhu/qZEZM72H5ECDdrPdlWjQ6FOMSW1J+XZHGAThve3PEO60neZySpX1msv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4363989b-0b49-45a7-9553-08df3faf5bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:50:50.3645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+cH0lbVLfuGDFWS6crs+OM1CD9iocYVhFNmpC40f8xTOPX9Tdp1u5syT3/ZkL5R9DkdDIuLwi/GI9RV/c3Z+2vW9XHExn2Hcod2SDTUJAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8201
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIyOjIyICswMjAwLCBSYWxmIFJhbXNhdWVyIHdyb3RlOgo+
IEZyb206IFJhbGYgUmFtc2F1ZXIgPHJhbGYucmFtc2F1ZXJAb3RoLXJlZ2Vuc2J1cmcuZGU+Cj4g
Cj4gdmlydCBhbmQgc2lmaXZlX3Ugbm93IGRlc2NyaWJlIGEgaGFydCdzIFBMSUMgY29udGV4dHMg
d2l0aCB0aGUgc2FtZQo+IHJ1bGU6Cj4gYSBtYWNoaW5lIGNvbnRleHQgdW5sZXNzIHRoZSBoYXJ0
IHJ1bnMgdW5kZXIgS1ZNLCB3aGVyZSB0aGVyZSBpcyBubwo+IE0tbW9kZSwgYW5kIGEgc3VwZXJ2
aXNvciBjb250ZXh0IGlmIHRoZSBoYXJ0IGhhcyBzdXBlcnZpc29yIG1vZGUuCj4gV3JpdGluZyB0
aGF0IHJ1bGUgZG93biB0d2ljZSBpcyB3aGF0IGxldCB0aGUgdmlydCBkZXZpY2UgdHJlZSBkcmlm
dAo+IGF3YXkKPiBmcm9tIHJpc2N2X3BsaWNfaGFydF9jb25maWdfc3RyaW5nKCkuCj4gCj4gVGhp
cyBtYWtlcyB0aGUgc2lmaXZlX3UgZGV2aWNlIHRyZWUgYXNrIHdoZXRoZXIgS1ZNIGlzIGluIHVz
ZSwgd2hpY2gKPiBpdAo+IGRpZCBub3QgZG8gYmVmb3JlLsKgIEl0cyBQTElDIGRldmljZSBhbHJl
YWR5IGRvZXMsIHNvIHRoZSB0d28gbm93Cj4gYWdyZWUuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmFs
ZiBSYW1zYXVlciA8cmFsZi5yYW1zYXVlckBvdGgtcmVnZW5zYnVyZy5kZT4KPiBSZXZpZXdlZC1i
eTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21t
LmNvbT4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiBDbGVhbnVwLCBub3QgYSBmaXguwqAgQ2FuIGJlIGRy
b3BwZWQsIHRoZSByZXN0IGRvZXMgbm90IGRlcGVuZCBvbiBpdC4KPiAKPiDCoGh3L3Jpc2N2L2Zk
dC1jb21tb24uY8KgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysrKysrKysrKysrKysKPiDCoGh3
L3Jpc2N2L3NpZml2ZV91LmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEyICsrKystLS0tLS0tLQo+
IMKgaHcvcmlzY3YvdmlydC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE2ICsrKysr
Ky0tLS0tLS0tLS0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvZmR0LWNvbW1vbi5oIHzCoCAzICsrKwo+
IMKgNCBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvZmR0LWNvbW1vbi5jIGIvaHcvcmlzY3YvZmR0LWNvbW1v
bi5jCj4gaW5kZXggY2UyZGNiNDNiNC4uNTAzZDgxOGRkMCAxMDA2NDQKPiAtLS0gYS9ody9yaXNj
di9mZHQtY29tbW9uLmMKPiArKysgYi9ody9yaXNjdi9mZHQtY29tbW9uLmMKPiBAQCAtMjEyLDYg
KzIxMiwyNCBAQCByaXNjdl9jcmVhdGVfZmR0X3NvY2tldF9jcHVfc2lmaXZlKHZvaWQgKmZkdCwK
PiBjaGFyICpjbHVzdF9uYW1lLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGhhbmRsZSwgaW50Y19waGFuZGxl
cywgZmFsc2UsCj4gZmFsc2UpOwo+IMKgfQo+IMKgCj4gK3VpbnQzMl90IHJpc2N2X3BsaWNfaGFy
dF9mZHRfY2VsbHModWludDMyX3QgKmNlbGxzLCBSSVNDVkNQVSAqaGFydCwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdWludDMyX3QgaW50Y19waGFuZGxlLCBib29sCj4gaGFzX21fbW9kZSkKPiArewo+ICvCoMKg
wqAgdWludDMyX3QgbGVuID0gMDsKPiArCj4gK8KgwqDCoCBpZiAoaGFzX21fbW9kZSkgewo+ICvC
oMKgwqDCoMKgwqDCoCBjZWxsc1tsZW4rK10gPSBjcHVfdG9fYmUzMihpbnRjX3BoYW5kbGUpOwo+
ICvCoMKgwqDCoMKgwqDCoCBjZWxsc1tsZW4rK10gPSBjcHVfdG9fYmUzMihJUlFfTV9FWFQpOwo+
ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIGlmIChyaXNjdl9jcHVfaGFzX3N1cGVydmlzb3JfbW9k
ZShoYXJ0KSkgewo+ICvCoMKgwqDCoMKgwqDCoCBjZWxsc1tsZW4rK10gPSBjcHVfdG9fYmUzMihp
bnRjX3BoYW5kbGUpOwo+ICvCoMKgwqDCoMKgwqDCoCBjZWxsc1tsZW4rK10gPSBjcHVfdG9fYmUz
MihJUlFfU19FWFQpOwo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIHJldHVybiBsZW47Cj4gK30K
PiArCj4gwqB2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfcGxpYyh2b2lkICpmZHQsIGh3YWRkciBhZGRy
LCB1aW50NjRfdCBzaXplLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBwbGljX3BoYW5kbGUsIHVpbnQzMl90Cj4gaW50X2Nl
bGxzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB1aW50MzJfdCBhZGRyX2NlbGxzLCB1aW50MzJfdAo+ICpwbGljX2NlbGxzLAo+IGRpZmYg
LS1naXQgYS9ody9yaXNjdi9zaWZpdmVfdS5jIGIvaHcvcmlzY3Yvc2lmaXZlX3UuYwo+IGluZGV4
IDhmNTBjNjdhMTQuLmJlMTk0ZjhhZWMgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3Yvc2lmaXZlX3Uu
Ywo+ICsrKyBiL2h3L3Jpc2N2L3NpZml2ZV91LmMKPiBAQCAtNTgsNiArNTgsNyBAQAo+IMKgI2lu
Y2x1ZGUgImNoYXJkZXYvY2hhci5oIgo+IMKgI2luY2x1ZGUgIm5ldC9ldGguaCIKPiDCoCNpbmNs
dWRlICJzeXN0ZW0vZGV2aWNlX3RyZWUuaCIKPiArI2luY2x1ZGUgInN5c3RlbS9rdm0uaCIKPiDC
oCNpbmNsdWRlICJzeXN0ZW0vcnVuc3RhdGUuaCIKPiDCoCNpbmNsdWRlICJzeXN0ZW0vc3lzdGVt
LmgiCj4gwqAKPiBAQCAtMjAxLDE0ICsyMDIsOSBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KFNp
Rml2ZVVTdGF0ZSAqcywgY29uc3QKPiBNZW1NYXBFbnRyeSAqbWVtbWFwLAo+IMKgwqDCoMKgIGZv
ciAoY3B1ID0gMDsgY3B1IDwgbXMtPnNtcC5jcHVzOyBjcHUrKykgewo+IMKgwqDCoMKgwqDCoMKg
wqAgLyogY3B1IDAgaXMgdGhlIG1hbmFnZW1lbnQgaGFydCB0aGF0IGRvZXMgbm90IGhhdmUgUy1t
b2RlICovCj4gwqDCoMKgwqDCoMKgwqDCoCBoYXJ0ID0gY3B1ID8gJnMtPnNvYy51X2NwdXMuaGFy
dHNbY3B1IC0gMV0gOiAmcy0KPiA+c29jLmVfY3B1cy5oYXJ0c1swXTsKPiAtCj4gLcKgwqDCoMKg
wqDCoMKgIGNlbGxzW2NlbGxzX2xlbmd0aCsrXSA9IGNwdV90b19iZTMyKGludGNfcGhhbmRsZXNb
Y3B1XSk7Cj4gLcKgwqDCoMKgwqDCoMKgIGNlbGxzW2NlbGxzX2xlbmd0aCsrXSA9IGNwdV90b19i
ZTMyKElSUV9NX0VYVCk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmlzY3ZfY3B1X2hhc19z
dXBlcnZpc29yX21vZGUoaGFydCkpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjZWxsc1tj
ZWxsc19sZW5ndGgrK10gPSBjcHVfdG9fYmUzMihpbnRjX3BoYW5kbGVzW2NwdV0pOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNlbGxzW2NlbGxzX2xlbmd0aCsrXSA9IGNwdV90b19iZTMyKElS
UV9TX0VYVCk7Cj4gLcKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqAgY2VsbHNfbGVu
Z3RoICs9Cj4gcmlzY3ZfcGxpY19oYXJ0X2ZkdF9jZWxscygmY2VsbHNbY2VsbHNfbGVuZ3RoXSwg
aGFydCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBpbnRj
X3BoYW5kbGVzW2NwdV0sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICFrdm1fZW5hYmxlZCgpKTsKPiDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDCoCByaXNjdl9j
cmVhdGVfZmR0X3BsaWMoZmR0LCBtZW1tYXBbU0lGSVZFX1VfREVWX1BMSUNdLmJhc2UsCj4gZGlm
ZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IGluZGV4IGEyODUx
YjUwNmQuLmVjZThlZjAwNzAgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jCj4gKysrIGIv
aHcvcmlzY3YvdmlydC5jCj4gQEAgLTE1MiwyNCArMTUyLDIwIEBAIHN0YXRpYyB2b2lkCj4gY3Jl
YXRlX2ZkdF9zb2NrZXRfcGxpYyhSSVNDVlZpcnRTdGF0ZSAqcywKPiDCoMKgwqDCoCB1bnNpZ25l
ZCBsb25nIHBsaWNfYWRkciA9IHMtPm1lbW1hcFtWSVJUX1BMSUNdLmJhc2UgKwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAocy0+
bWVtbWFwW1ZJUlRfUExJQ10uc2l6ZSAqIHNvY2tldCk7Cj4gwqDCoMKgwqAgYm9vbCBudW1hX2Vu
YWJsZWQgPSByaXNjdl9udW1hX2VuYWJsZWQoTUFDSElORShzKSk7Cj4gK8KgwqDCoCBib29sIGhh
c19tX21vZGUgPSAha3ZtX2VuYWJsZWQoKTsKPiDCoMKgwqDCoCB1aW50MzJfdCBjZWxsc19sZW5n
dGg7Cj4gwqAKPiDCoMKgwqDCoCBwbGljX25hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9zb2MvaW50
ZXJydXB0LWNvbnRyb2xsZXJAJWx4IiwKPiBwbGljX2FkZHIpOwo+IMKgCj4gwqDCoMKgwqAgcGxp
Y19jZWxscyA9IGdfbmV3MCh1aW50MzJfdCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5zb2Nbc29ja2V0XS5udW1faGFydHMgKiAoa3ZtX2VuYWJs
ZWQoKSA/Cj4gMiA6IDQpKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzLT5zb2Nbc29ja2V0XS5udW1faGFydHMgKiAoaGFzX21fbW9kZSA/IDQgOgo+
IDIpKTsKPiDCoMKgwqDCoCBjZWxsc19sZW5ndGggPSAwOwo+IMKgCj4gwqDCoMKgwqAgZm9yIChj
cHUgPSAwOyBjcHUgPCBzLT5zb2Nbc29ja2V0XS5udW1faGFydHM7IGNwdSsrKSB7Cj4gLcKgwqDC
oMKgwqDCoMKgIGlmICgha3ZtX2VuYWJsZWQoKSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBsaWNfY2VsbHNbY2VsbHNfbGVuZ3RoKytdID0KPiBjcHVfdG9fYmUzMihpbnRjX3BoYW5kbGVz
W2NwdV0pOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBsaWNfY2VsbHNbY2VsbHNfbGVuZ3Ro
KytdID0gY3B1X3RvX2JlMzIoSVJRX01fRVhUKTsKPiAtwqDCoMKgwqDCoMKgwqAgfQo+IC0KPiAt
wqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2NwdV9oYXNfc3VwZXJ2aXNvcl9tb2RlKCZzLQo+ID5z
b2Nbc29ja2V0XS5oYXJ0c1tjcHVdKSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBsaWNf
Y2VsbHNbY2VsbHNfbGVuZ3RoKytdID0KPiBjcHVfdG9fYmUzMihpbnRjX3BoYW5kbGVzW2NwdV0p
Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBsaWNfY2VsbHNbY2VsbHNfbGVuZ3RoKytdID0g
Y3B1X3RvX2JlMzIoSVJRX1NfRVhUKTsKPiAtwqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKg
wqDCoCBjZWxsc19sZW5ndGggKz0KPiByaXNjdl9wbGljX2hhcnRfZmR0X2NlbGxzKCZwbGljX2Nl
bGxzW2NlbGxzX2xlbmd0aF0sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICZzLQo+ID5zb2Nbc29ja2V0XS5oYXJ0c1tjcHVdLAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IGludGNfcGhhbmRsZXNbY3B1XSwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFzX21fbW9kZSk7Cj4gwqDCoMKg
wqAgfQo+IMKgCj4gwqDCoMKgwqAgcGxpY19waGFuZGxlc1tzb2NrZXRdID0gKCpwaGFuZGxlKSsr
Owo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaCBiL2luY2x1ZGUv
aHcvcmlzY3YvZmR0LQo+IGNvbW1vbi5oCj4gaW5kZXggZWI5ZGI4Mjc4ZC4uNThlNjM1ZTllZCAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaAo+ICsrKyBiL2luY2x1
ZGUvaHcvcmlzY3YvZmR0LWNvbW1vbi5oCj4gQEAgLTkzLDYgKzkzLDkgQEAgdm9pZCByaXNjdl9j
cmVhdGVfZmR0X3NvY2tldF9jcHVfc2lmaXZlKHZvaWQgKmZkdCwKPiBjaGFyICpjbHVzdF9uYW1l
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBzb2NrZXRfaGFydGlkX2Jhc2UsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgKnBoYW5kbGUsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdWludDMyX3QgKmludGNfcGhhbmRsZXMpOwo+ICsvKiBEZXNjcmliZSBvbmUgaGFy
dCdzIFBMSUMgY29udGV4dHMsIHJldHVybnMgdGhlIG51bWJlciBvZiBjZWxscwo+IHdyaXR0ZW4g
Ki8KPiArdWludDMyX3QgcmlzY3ZfcGxpY19oYXJ0X2ZkdF9jZWxscyh1aW50MzJfdCAqY2VsbHMs
IFJJU0NWQ1BVICpoYXJ0LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBpbnRjX3BoYW5kbGUsIGJv
b2wKPiBoYXNfbV9tb2RlKTsKPiDCoHZvaWQgcmlzY3ZfY3JlYXRlX2ZkdF9wbGljKHZvaWQgKmZk
dCwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHNpemUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHBsaWNfcGhhbmRsZSwgdWlu
dDMyX3QKPiBpbnRfY2VsbHMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGFkZHJfY2VsbHMsIHVpbnQzMl90Cj4gKnBsaWNf
Y2VsbHMsCg==

