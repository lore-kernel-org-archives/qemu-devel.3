Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CB606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WoT1LWmt;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=k62P/GJW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCvQ-0001mW-DP; Thu, 19 Nov 2026 19:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCvO-0001m6-DD; Thu, 19 Nov 2026 19:56:22 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7773dcc14=Alistair.Francis@wdc.com>)
 id 1xUCvL-00016N-5i; Thu, 19 Nov 2026 19:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795136186; x=1826672186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E7rKBfeNiiuX+I2tAoO99hB0LGCrVEh4IEJ2kPWpaC0=;
 b=WoT1LWmtRhrcQ08Tj4Fx5d8ncYpy0hMg96EfcnNaPztCcEr83WUvC2OK
 qS5A/5nyf9b7gxKZDave0wT0YudDsvjO9cuoEd5zpPhdD88lXtFu4eFXL
 9LbApXqBI/3DavK2lVgBULKQleWsPvESJ27X0bYXT98TzLMs2tHiAkGbl
 HByWT3nJiFQvtmI5vToXmfar9bvcwQ7mPqYwhyQS69ef+cR6ttR8ek9XV
 Xm3Ysjg0dg8jYyDcqLbWB7KrfyN7wxr6c9w7YmAeE9xIWbgqYflKenWZC
 rKIWSTsnB1YHcF6DTZ+RhteAnby1EBWn0tqaRZ8Koh3p73U5bkU2ZQo0Y Q==;
X-CSE-ConnectionGUID: NETerSHaSkOuUEcLHq7lIg==
X-CSE-MsgGUID: ZzQPQsR/ROiQTsuW8kRkSQ==
X-IronPort-AV: E=Sophos;i="6.27,221,1786982400"; d="scan'208";a="159709386"
Received: from mail-southcentralusazon11011022.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.22])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 08:56:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+ALk//gaJQ0vC5fH3kKkqcfCzr98T5PMlDAEsYMymxHKrdz0toB079e6CyNRGkSWB7rbMYWGR3hiNs5r8kDT53+wO3Z/e5vP51TdA4T0j43KzFHBACo6NbOqCAddspZ0pKUqOqUIGgq5aZTREAbyT23c39ooDzChBdWQUnZhkeXikuzaj2ANFW6yPhRqJKwuNJHLqzBui/JsbwdZCxmGgPnYnEdsLeizdzXPBAKJbMirozxtPtI8rpqPPg4df5DiQFBycssSnHNT8xZQSY1D6k29C1iCHDkvY1KtKXbhrVA4aoW6eRUHYCtumVq+t0cPlC+hPhQJzYqDieleQzR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7rKBfeNiiuX+I2tAoO99hB0LGCrVEh4IEJ2kPWpaC0=;
 b=MGgSUDEZndme9FonOillD1cl7IV07K6WYu6VeqrLcSa1xcFR+LFvNn1sfSdk0fsdjEQaS94vjJrVwAqfgWpa9lBU8vcK+gAlsA/n+T4LuVNM9Yjb7KEmG0nQTww9QaN6twY2BUC3h6YhFvnAhUt02a6lfLaOGw9yFDyoK2d2/gjIpEnJ3WnphREhJjYu1elwKtCiB/eJDZYuEOtVrcwaNFJPU3t84LyqPx3RNW2X1wc3IAMzmp1LdedOrpJBVY4njLPmiESeMtRWQwtmtInQ4xboxxWW+zMuuK6SoerZLalp2zajV4E+N66MaWdLcCtlpJ2rh1FTBkcDPPtVdnDhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7rKBfeNiiuX+I2tAoO99hB0LGCrVEh4IEJ2kPWpaC0=;
 b=k62P/GJWnhpzwtYwngNlGw23hwYBRQjf+OmyfUlC9X/VYEPnslhDlmOIvPaSmpww5WONDDXxJgST6xbR4FOXE6n1ps2D7vB1dXWXX1o0Oc7o1FBDkDWead/aWRQJG1l1vzBpPTy9mx1AiTQGcGc9O3cNTDx7NAjgWsODHRnre7k=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ2PR04MB8460.namprd04.prod.outlook.com (2603:10b6:a03:4f3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 00:56:14 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 00:56:14 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/1] target/riscv: do not write SXL < UXL [GL4821]
Thread-Topic: [PATCH v2 0/1] target/riscv: do not write SXL < UXL [GL4821]
Thread-Index: AQHdeCNbYmocoQ0c6kuS/ss/qdWSg7c2I5qA
Date: Fri, 20 Nov 2026 00:56:14 +0000
Message-ID: <fc4c472c8652b624f8964eae5f0f95ec7c3a880a.camel@wdc.com>
References: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ2PR04MB8460:EE_
x-ms-office365-filtering-correlation-id: 97d86990-5e6f-4fdc-1cdc-08df46a113ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|19092799006|23010399003|38070700021|10067099003|261022075727099003|261026121527099003|261026140227099003|56012099006|11063799006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: /y24hDMxWddNVrPUXfq8ChRPLX9T00FgKyZKQ+H99ppLMJ3izxEm9YmHrUijkTZADFSu/Qeogz6jC6TGR6VrTqbBaB4zuojhRnBZrKu36X5GtQuuQZ0rcGYvfOvSxekUz/dgp3ib+2vWmMM6K1Eobc6vD3Hong/9Ajdrv2Ym0WoBh86f3dHtxAvXxRCxPvBtNhSecfXpXe4rQidB4+X8IBOSCiTJivvLx2Y61lH5Lgi0aKha4Ye2xITjRFsqGAotKKHvus7bizG+7V1jDaAHIXm1fWQZnls73LqpLiQjxpb/j4meeLbh8Z+bdsdl5VzOLiTgzGh/qWUO19t+zWVDS+ZPNdn2747tdjmfe1aaaWcJIHggRGukt1gLaBhnOujOkz+oNX427fJfGIrf3QRalu3iQbS3gTtIHrOeQbiPEpWWALGXU79Lqa6SvjDmpcPUTS8Sv+49n5sV88lyjhcQO1OJn1seGkDLN8e3zJHDo9xQjzdb3zX8rV8un/xfOI/iDoPAxVVrfHOtcnYh90NJ6o8KaIaFil3v74UdEDrwpbBMNFJIw25QSY06bUwWSUCbkTI8g/w+slb1IQIKc0eAyAa0k/IrpllvsLrbBJ0WbVOO3IDr0Yp/20IjTbBuERgjKsLvfu8yVAQUIoUnbxGHEdO7bSo8HYjh6qdSQhk6BYE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(38070700021)(10067099003)(261022075727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWJ0WGQvSnhyWFE3clBEcVBhN1FxeER1aWVnWW1YUXpvN1dJVjY4ajdNek1l?=
 =?utf-8?B?dy96d0hOcG11VEQzNENlMjAyZUxxamJuWEMzbElNWjhoWTdublZSRlczYmsw?=
 =?utf-8?B?TXlTZFhVMXBsYlY4ZDJiTUI5TnJrTFhNTG02Nmp3MUNDWUx2UGpPcm54dFFD?=
 =?utf-8?B?K0tQWGRxeWVQcTNLUWtsdXZTOXRpOC9XcllVcWt3WTJYU3lGRi9Hb2UxZUJo?=
 =?utf-8?B?dkp5eHJmNXN3Q3NBbkJiSFZHN1RWU2J0RFpSYUJNTTVHOEJCekJtOEExUi9Y?=
 =?utf-8?B?VElTOGtrV0tUaG5rQ3JvQ0RoV3p3ZFdlVVJ6Mm5NMVgydHFMUk5id1JkMzhX?=
 =?utf-8?B?aWtSeDNFNDBLSUdXbWRFaUVMK0ZnNkZQVDY5TlBKV1ZhR2pmMmxYTXlZayt4?=
 =?utf-8?B?Vys0dzdNRUpPalczK3FpOU5EUnFkNmdISWR0OExBbzhoTXZMRUpnbDdBVFRO?=
 =?utf-8?B?SHdxWEZpOEtZTFhMa01lYnphakpzVkZHM3IrbVBHdDFHdjhkVzVoOUc3aGNN?=
 =?utf-8?B?RHdCY05EWXRVSmNzd1FkK3pkejJYSU5SUVg5SzNQSzBOYVBmR2p2TDdNb0VY?=
 =?utf-8?B?bzVXYUxPejVUK3VHNkd4Y3lLd0ZtRTJlbkVEbUlyL1c0UkVFM2VoVDV0UjlL?=
 =?utf-8?B?cERXWGxnWXJueTlNRldTZVFDZGFRZlczdlFLemJkTkJJNkE5bjBNMUlvcjRF?=
 =?utf-8?B?dWUrY21yNFBDL0RqZVlUWkFBemV5WmpZT0MrVkQ5RDNXL2lNb0tRbVEwTUJW?=
 =?utf-8?B?dzdHR2htcW1XemJ6djFoNGVRelVIVEtlcE1DVGhoTXd3QWxpa2VUUCtiRml5?=
 =?utf-8?B?U3hJSHg1LzhJOVo5cTBzc1l5Q05oN3paQkRlbGJJSm1vUGxuY0lPMmVuK0sx?=
 =?utf-8?B?a0k0cFh3VWRKZnp3V2FoNk13UmZFenI5YVZxOTJwZFBreHB5ek5xK3QyOXdj?=
 =?utf-8?B?eGlJdVpPWWRaOWdzYm10MUdNY3ZCNGFlK1pZeU8vVGkzRGtUZnJ5ZDhwTjJz?=
 =?utf-8?B?TXI5bnhzaUg0YkZoN1M1S3BCdFpYb1puVmFuQ2IxNUdjaXQ1V0ttb2VJVWh4?=
 =?utf-8?B?NjhKc3I5VStOa2pMeWIwSUUvTFNVdkhSamZJUnJ6N0RjdTNDemVNQi94RGtY?=
 =?utf-8?B?SzZOOFFKTHV6VkpwanFIQ3NlOTJsVzJJVEJCMzg2bzgyU25MQ253MjJXaUxo?=
 =?utf-8?B?ODVlWSsvcmx0ajNOWGVWR21QZTVXbGszUUs5RWh2NWtFVjhGb2RHOStSeUkz?=
 =?utf-8?B?bElrMFhtMXFpT2pnblpJTzJrVVBDQjYySGE1TTFkUW1vS0syaTVWMEcwWHNY?=
 =?utf-8?B?MXk3UGQydWd3b0M3R0EvT1M3Y25iV1Z1OTBGcjZLaldEeW02eWFsQTNwYjZv?=
 =?utf-8?B?d1h5YUd1N2FLMzZjQzU4eXRRUkxaZ2owVTJoamtZV3BVcUtwejA0QVo1cWI2?=
 =?utf-8?B?dC9xNVR2Mlc4NllubXA5VjBtL1JGcW92V0VJb2FSVnNjZDFmS2JGWDlRNlhn?=
 =?utf-8?B?bllPd0dtNlk4ZVJrUzBnMFU1OXhJWXlvQnhoRENNaEFRdkUrL3B2aEVwOGFH?=
 =?utf-8?B?UUZackFhdUdKTFBMSUhKOHBhRjVSVlNQSVhvRXlJTkN2eVNwYXVUVFd1aUU0?=
 =?utf-8?B?Rkptdy9uWXVwWEVaYkUwYmpnVWQvenRRWVk2bDBLZUtreEtiRlYrdm1qdFpv?=
 =?utf-8?B?OGJtdU5yeDRBZGN6bnV0a0Z1aXYyQUxPZ3FHR1pwRlY2YzlBQzdhOFRCR3JX?=
 =?utf-8?B?QlBLUmFyaVk1YXVKdzZhWFhZMDdWRzRBOVRhaDVJNDRJQzZRWVYvczJoWjZL?=
 =?utf-8?B?UVg4dGZGQUJTSE5xRVpaNjlkdVlJclRqOWd6LzcwbjJkUUZvbTJKNHpKZ0li?=
 =?utf-8?B?aXhTcnlyZWlKbTVXYVdwTzdzSWJ1ejdSN1dwMS8ycW9nSjlMQkZ1QWdmR28y?=
 =?utf-8?B?Z1NDMUE3alB1ejN4ZW5UV1pEclZ2Uk5va1hrSnl5aEdEMkZ6SzNlZkwwN0pL?=
 =?utf-8?B?MVhURExybWtZMDRKRkU5c0w1L09DYVlZYmZHQldiRzlMRTVjc2hsUVl5MkRY?=
 =?utf-8?B?aVNsV3AzMzRFcFJiUElGQXNaVzIrdjlpOVJ0UTdkNE5uNzFVRVptRVo5ei9o?=
 =?utf-8?B?R1hkbUdGNmRFUzI1RSsvR0xkZlEzYUtrZlllSUkzS3VsR29XUnlyTjhmZklR?=
 =?utf-8?B?QjRIazV2clUzT3AvT1NKQmRVT1Y0VXVSZzlwUFphZDNUcVJEVUUrL0ZoMi9x?=
 =?utf-8?B?ak9hbVE5UEs2MHl4U3IzT1FsT2lXZEs5U2RoVEIzbWdvRWhsYnVnKzM5YWdy?=
 =?utf-8?B?MmdaMHljTEUyWWppMUJKblU2S3hEdUZkQlBqYkcrY3ZoM25PQjg4R042Z3Jx?=
 =?utf-8?Q?3zu99NXVUSXteE0UHsTShHG6x3zHxXeRU860+bMSaVEhp?=
x-ms-exchange-antispam-messagedata-1: oiWeiCbHEu0EhhEOK6cUCbIaJt4Spyp7bqQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF6BAEB97A836A458856F15606260E75@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nUn0a5hn9YTuJsA2mXRUGAMfVdG0DfKQUTPZzlZMfvqiIEcp6FrrJvK6qBuFwatoIPkna9bf2K/Ev7gAVWZThWCecj+z4gXrmbP6JDl/zAk3CdXtyFcr9+PacGZAuxdS2UF665mNGOU1HDYVcVRAdHhi1MZV9PejNqKVq1U8TPT5OlzD2j0iuhaty9VE0UqpTJEG046tdh8lCj8OaHgfGPsTyamQ9jikXnBS2cTnjS5Bs6zkNJrlZD4HvZ87BkPJH0uOqmOwhSqJpHrJyCCTUg4OayN2wt/cbwbdJueXV7C/dxNQFuV1H/htd5N9Zo8ho5VEbq0THvpIprOJIOKFaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uUOAI60sH7tu38DCycB3Fyf0OkCMdrVYJlrcpZ7kSmZMlnVGw35RLJpgywcNTqw8U19YRw+cEEF2OD+w4mO3vbHZZX/XL6QzAXmgwwX11cgfiB/MuEzrI2BX2a6vMJNxEYItswoEUY/nv0BmeSt61HceN+pRpgOVx5LRhsPiaXKLbpjrZpWlH6fwBO5jjMDXY9E+rsl2P+H5vmZmE+OX/YGASP5QiqK4+6qhYja20eXunYf5uhfgV3hVqIrLcL39EyyaibtDWeHKfm16C61z+21iybTekeYUe/x/RAUzhjyC7EODG0uwRoGAUkwc7dEm2XPHDuu+7vfEJjGKK3YdBvxwxNozZLTU5eABN7LeMglVoU1Qq22Y1rAF7nDFs7f/2i21XMW5hK4jzmKiRzbMCKrHxx273IeJwnh7hL9LJV4CO7Rj9vFiyz3/m1vJjJeXKX/EfEiMILaTW24Kj3YkJey7n0sR6cE+GWTJ9FvAJTv1uKOj3LjyvLqpZCsA0NBVZsq79+neEamCLQx5n095n6a2Ay3yphhP1ULVdUzYH/RX5Md8PgxzgwmHqLDvnx2XuhP8bqIoP7gNAIu6dE4qBDNU5h+XFIgkuAyEURlK+uGWcK0OQLDvBlGGq708MRhI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d86990-5e6f-4fdc-1cdc-08df46a113ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 00:56:14.7580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9O5RkAIMoUAS0tsiUIJsdaPhsEuIGsJeogcZG3S8aTfMm1qnqZGs0fcAjeqbe+Lf6mXF2fq6oKFcSloBqf7ma6j7UP76eXoz8ACT6SB7Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8460
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=7773dcc14=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTE5IGF0IDA5OjQxIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQmFzZWQtb246IDIwMjYxMTEwMjMyNjE0LjgzMDUwLTEtY2hyaXN0aWFuc2xp
bWFAcHJvdG9uLm1lDQo+ICgidGFyZ2V0L3Jpc2N2OiBjaGFuZ2UgbXN0YXR1cyBiaXRzIGZvciBy
ZWFkLW9ubHkgaWYgUyBvdSBVDQo+IHVuc3VwcG9ydGVkIikNCj4gDQo+IEhpLA0KPiANCj4gSW4g
dGhpcyB2MiB0aGVyZSBhcmUgMiBTYXNoaWtvLXN1Z2dlc3RlZCBjaGFuZ2VzOg0KPiANCj4gLSBh
ZGRlZCBhICJGaXhlcyIgdGFnOw0KPiANCj4gLSBzaW1wbGlmaWVkIHRoZSAnbWluX3ZhbCcgY2Fs
Y3VsYXRpb24gd2hlbiB3cml0aW5nIFNYTC7CoCBTYXNoaWtvDQo+IHNhaWQ6DQo+IA0KPiDCoCAi
LSBbTUVESVVNXSBJbiB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jICh3cml0ZV9tc3RhdHVzKSwgU1hM
IGNhbiBiZQ0KPiBzZXQgbGVzcw0KPiDCoCB0aGFuIFVYTCBpZiBSVlUgaXMgYWJzZW50LiBUaGUg
bWluX3ZhbCBmb3IgU1hMIGlzIG9ubHkgZGVyaXZlZCBmcm9tDQo+IFVYTA0KPiDCoCBpZiBSVlUg
aXMgcHJlc2VudDsgb3RoZXJ3aXNlLCBpdCBkZWZhdWx0cyB0byAwLiBUaGlzIGFsbG93cyBhIGd1
ZXN0DQo+IHRvDQo+IMKgIHdyaXRlIFNYTCA8IFVYTCwgdmlvbGF0aW5nIHRoZSBpbnRlbmRlZCBm
aXggYW5kIHRoZSBoYXJkd2FyZQ0KPiBjb250cmFjdC4NCj4gwqAgVGhlIGNoZWNrIHNob3VsZCBl
bnN1cmUgbWluX3ZhbCBpcyBkZXJpdmVkIGZyb20gVVhMIHJlZ2FyZGxlc3Mgb2YNCj4gUlZVLiIN
Cj4gDQo+IFRoaXMgd29uJ3QgaGFwcGVuIGluIHByYWN0aWNlIHNpbmNlIHdlJ3JlIGJhc2luZyB0
aGlzIHBhdGNoIG9uIGENCj4gY29tbWl0DQo+IHRoYXQgd2lsbCBmb3JiaWQgVVhMIHdyaXRlcyB1
bmxlc3Mgd2UgaGF2ZSBSVlUsIGkuZS4gaWYgdGhlcmUncyBubw0KPiBSVlUNCj4gd2UgY2FuIGFz
c3VtZSBVWEwgd2lsbCBiZSB6ZXJvLsKgIEJ1dCwgYnkgdGhpcyBzYW1lIGxvZ2ljLCB0aGlzDQo+
IHRlcm5hcnkNCj4gaXMgdW5uZWVkZWQ6DQo+IA0KPiDCoMKgIHVpbnQzMl90IG1pbl92YWwgPSBt
YXNrICYgTVNUQVRVUzY0X1VYTA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgPyBnZXRfZmllbGQodmFsLCBNU1RBVFVTNjRfVVhMKSA6IDA7DQo+IA0KPiBBbmQg
d2Ugc2hvdWxkIGp1c3QgdXNlICdnZXRfZmllbGQoLi4uKScgZGlyZWN0bHkgaW5zdGVhZC7CoCBT
byB3ZSdyZQ0KPiBlbmRlZCB1cCBkb2luZyB3aGF0IFNhc2hpa28gc3VnZ2VzdGVkIGJ1dCBmb3Ig
b3RoZXIgcmVhc29uLg0KPiANCj4gTm8gb3RoZXIgY2hhbmdlcyBtYWRlLg0KPiANCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gLSBhZGRlZCAiRml4ZXMiIHRhZzsNCj4gLSByZW1vdmVkIHRoZSB0ZXJuYXJ5
IHdoZW4gYXNzaWduaW5nICdtaW5fdmFsJyBkdXJpbmcgU1hMIGxvZ2ljOw0KPiAtIHYxIGxpbms6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjExMTIxNjMyNDIuNTA5
ODY0LTEtZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbS8NCj4gDQo+IA0KPiBEYW5pZWwg
SGVucmlxdWUgQmFyYm96YSAoMSk6DQo+IMKgIHRhcmdldC9yaXNjdjogZG8gbm90IHdyaXRlIFNY
TCA8IFVYTCBbR0w0ODIxXQ0KDQpXaHkgaXMgdGhlcmUgYSBHTCBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2U/DQoNCkFsaXN0YWlyDQoNCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzOSArKysrKysrKysrKystLS0tLS0NCj4gwqB0ZXN0cy90
Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQgfMKgIDcgKysrKw0KPiDCoHRlc3RzL3RjZy9y
aXNjdjY0L3Rlc3QtdXhsLXN4bC5TwqDCoMKgwqAgfCA1OQ0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC11
eGwtc3hsLlMNCg==

