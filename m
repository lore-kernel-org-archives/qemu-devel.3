Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D9606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MvNIV2tB;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RCBBOhxV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6ky-0006ow-1t; Thu, 05 Nov 2026 18:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xP6kw-0006oC-9v; Thu, 05 Nov 2026 18:20:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xP6ku-0006cJ-Cy; Thu, 05 Nov 2026 18:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793920828; x=1825456828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kLaF+BydkqKPGeWkqEvgG4YzqFcjTP3CAF/XhDUIQP8=;
 b=MvNIV2tBrqrjYf4cVSVFkLbB91o0THvTEcixeurFcRRu11NrES2eawHt
 ZBADV4GJrt8KOoZaKDzkNb9ntreMQJDBZ3AmEjyudzG9aXSrJ8xosibZS
 wSYoVMwIKLV3nHee2RNGR6Se3GWSr6t2inR+TO9v+LQvJGtCvpqQ+dpx4
 avg4dMCA+VRHzNsgzTLJyJFgL8eOZrzTUHiF5astQ+0vKwtHXoZZTy/jD
 75i136l0/HpWo4j5+fSgg7QWIdtjdYBs4aDgDiWmGtxd4w1ecDbTrsbjJ
 RRgqQ2xmEOKC5kw58RzYZrndXdj9JVaBZSlccyRTOQg55E4MGQfc/JW4a w==;
X-CSE-ConnectionGUID: phXt9ppoTGWDcX9mXyBLQw==
X-CSE-MsgGUID: ta3hIBGyQCWMIl13mpVU6A==
X-IronPort-AV: E=Sophos;i="6.27,197,1786982400"; d="scan'208";a="158337408"
Received: from mail-westcentralusazon11013065.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.65])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Nov 2026 07:20:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCSj5YnM4X6qtX8FoCiuHRb229bf2e5YaLrlm5khFbbOIsH2GEVVtzx04eQKHBRXQwnPXY41pTKEfnd2zJLQlQJlSzjHpDmmVMXHpMCdCtvh65X9gRbrpmLWLyhz4rEd7fVXoyeOAqUtQwf9b0k4p81Uu82o//07bmBeJh0ptscs1dFNfLBb691mDgV19/40ud4+uopRgX7hc9v2cDCmzNKdK4mPSycJbRo9sYRp/c1P9nbuEah5KAucqcq3NSqIdfI6FuAz6OiCC2SSkOzYZ0999gn2NniQkc46icnWmL+AmMNXcLad9yuG2yTYDLzuvYjn0uhVDZ+uozGJOHdT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLaF+BydkqKPGeWkqEvgG4YzqFcjTP3CAF/XhDUIQP8=;
 b=aOgYhJ5Y2fMerMYh2J/T89KonthOYkJm+1OJJSh4Um2V9ZmUSC3ejCjKHvTrS1DMGPKKjaL04KX8QxlUKyAl9j+BOHACJs5aXrgRmlE+eKNEd7V1jRiScg7h1M6OGhnykzj9WTU7QN/AxqlNmWbX9tG68vPu7OSR00VklEGxolO4sE3qfqyx5LYKotAWWkiOiJWKwUIfrNg//s5CQjj6CHvj+ntkb7JS7zD3FW3LIUHD70f8zYR+YRsqzKkRC6ut+I6nb3eSytCdYevB8yuLy0sQCWijrZ4neHAVU1J1sojr1iY2wpaM8Pfqh+bZlBSZVon7AR88loHiwWYdy/RygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLaF+BydkqKPGeWkqEvgG4YzqFcjTP3CAF/XhDUIQP8=;
 b=RCBBOhxVreXRZG6JRBA/d5gITvlA4Ac6RRHmyba4ALaHoqA2WUXyzXbVaJeHSwNogH+bST6j3igxiloo/BYdw+VGQnOzwT/IenfIz1Mdb0JYeT0Zn/gD0Xn7gz1bgYhfQr6B4Ayf7xYYinhveLVUM+kOzkkFJRq+rx66TGL001M=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH7PR04MB8756.namprd04.prod.outlook.com (2603:10b6:510:237::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 23:20:23 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 23:20:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH] hw/intc/riscv_aplic: Check config value bounds in realize
Thread-Topic: [PATCH] hw/intc/riscv_aplic: Check config value bounds in realize
Thread-Index: AQHdYmXdiPLfr9TGh0WwJQqU0gJNKrcKYbeAgBVXtYCAAHo8gA==
Date: Thu, 5 Nov 2026 23:20:22 +0000
Message-ID: <ad25825972058e58fea695840b3704a617fa61f5.camel@wdc.com>
References: <20261022204223.854640-1-peter.maydell@linaro.org>
 <97a6d73ce1cca97a8de68bd7bc58b575e4026345.camel@wdc.com>
 <CAFEAcA8NTaF9JGkCfnuJDb4Ei65SStN+NcoG2gBNyEt=1C0QCg@mail.gmail.com>
In-Reply-To: <CAFEAcA8NTaF9JGkCfnuJDb4Ei65SStN+NcoG2gBNyEt=1C0QCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH7PR04MB8756:EE_
x-ms-office365-filtering-correlation-id: 6a251f1f-da60-4201-9280-08df3b935d94
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|366016|10070799003|1800799024|10067099003|22082099003|18002099003|38070700021|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|56012099006|261022105027099003;
x-microsoft-antispam-message-info: 5fHGSbWs9blo6CLy83yQOBafq45omd3LnAY8InqC/m0N3KG5zeCHlvQG8EdSwbfK7d30oBiYWnZDTB0FfnFpyPjem0h0gWsTl9sGH24dIR5+AY72S2ZPUeV+MVYoFPsDASHa3QsIQiOeiUQoNST5TkE1UWdClmJOmUcrq3B8zQp9p2XXL0G7BSd9PZf7uhHcrR87tRsgwVf4uYCxEvNlxCE7D7uSLeB6s1ieQqVNL3SpjrnRvmloGKhoWj07ZE6mI55jqyBFWiIJrYPwP8scfiIotVuHZrxFObh9yzGA/pj8ofYOoIl7divbRXMwKrpPIYzl86RhyWKy9RLmrt6qp9I6nqjsUS3RLaAxRKgpQ9gionODL6Yy1CAw+UD8RRqMft5Phdtmh6RRch/NzpzOfoCs31kQbMOIwVIfITdEChq9uPOBESIpGrfoBQS2keBydHZyVM9UWSEbG2kG3a6yiUHJPYu4O/3rhBpyLNXASqXeMMbdJsBrEvpfI64EVepb4CHM7nmqjAElu7297Uffd+tQeUCSd1sBRRLMeGnmzE3GSjMD5erG2ALycBuYBkLjsLoRwFOYJK3/78xl452O6RnjwFA7t84fWW0D15kmxbFEuhRUiU+gafBZRmOLnfhEKJ5bs0awWc7tmtO5UFW98afPUTSTqCaPyyExRjr8Aqo9bNnm1sedgoV2lSJdcePxGsvOGM1qmiVqLKveiSrgVI96dmSSPHoATfN4U6fT8Qg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(10070799003)(1800799024)(10067099003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(56012099006)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVdmVnpFNFhMeVdzU1ZjU3NUNlN4aTJoUWQydU5mSW1NcU1nUzFTQ0JJVVBW?=
 =?utf-8?B?TnJ0Y2JYek9QbFc2S1ZFc295bnZLSWZqMnlNaTdveWVWdEpxSUJPMHlkdHdj?=
 =?utf-8?B?aDVVRVRuTS9CVWFDT2RCSzh5M0YxckFxakZ6amJvbmlwcUFOZ2QycTlVMFV2?=
 =?utf-8?B?Zk5OdHRrYTlxZ1dVcWRpR3M3NkI3ODZiRGRXbnQ2azByTUFqL0JVcFg0NXRt?=
 =?utf-8?B?UXo2S2gveTBQZzJ5NzRJcnBRUVNsY0cvQWhiOHNLMnFLM2hVYmxyQjk0bTQy?=
 =?utf-8?B?MXpPYjZjZjNoWFk4WHVZYWpWcmxVTmlPOS9JRmFLdndGYlBLOEZwVmZOaEZo?=
 =?utf-8?B?dlM5NS9RUFFzeXc0YzQ2cUZrL3ZmaUJuY0lOVVk4Y1BDTG5Ed2tvenc4bi9p?=
 =?utf-8?B?M1MzQUNVc1hMdUNXNDJLRnQ2STVXdmdpVndSU0M2eC94ckZ3SGNmUXJMRHVu?=
 =?utf-8?B?cTk4c05lQVhyZHpSWkVaenQyTHQ0QXVYZWFyWFNlZnNFVHVWeWdEbERTVDBl?=
 =?utf-8?B?Y3FwVmsrMUtZWCtUWG9nSTlzTUkrMGJqK2hBWDcyUFhNQzFETTBhdktyMnRO?=
 =?utf-8?B?ZjhNS3JwaDBmT2Mxd0RhazJsc3pWM0tMMkdzZU9zS2JSaWRIR0VUTW1aczRB?=
 =?utf-8?B?dk1RaC9wd2ZUSUZYbHNJZzlLTVBiNjlFc0Q3OE9XamQvc3FKZEt3Y0tGMFJp?=
 =?utf-8?B?bUNTSWp1Q3V6QTU3b1dlMHN3cEwvNU5HNWpDYUFXMURFaEpYUVpPUUFrbFN5?=
 =?utf-8?B?UlNISzU4LzV1WHJUek5EdUw3Wk1ldUFwbjArOEx2bkhaN05Mb0N6Q1o0c1dS?=
 =?utf-8?B?emw0Vy9Ubmo5eUxlSFNlTjZlRnRtVkZ0U1l6ck1vMjZPTFVjOEVQYklZcHNh?=
 =?utf-8?B?aDREOGdtOVliOHBMeXFCbUh6bksyakY0OURyd3RQRGIvK3pXQ09DUVBFaTZt?=
 =?utf-8?B?NkJoUkNVVThPMVh0VmM0Qk4zUDU4eW5ZekZvbFAxZTV5OXR3Y1EveUduanFs?=
 =?utf-8?B?bVpUcVNsaXhNZDJjaThZdTZPM1hpZVoweS8xczZHdnpEeFM3OEQzU0ZFOHlm?=
 =?utf-8?B?VzJWYkZabU1HaUVoUHpKQk1EMFd2NGhlQlRucXZmb0lwSzBMTmdRVTQvZXJ3?=
 =?utf-8?B?OFpOU0RKNHdBQVpTR1pvRzB6azR4eFZGU0szSWdTeDZKNGtzMHRUSU5BVEpm?=
 =?utf-8?B?dmo5VUp3WWM3dUxqTU5GdWhlU05rZWRIYjNUdWNWZG5wZkk5MW9UN1JxTXBE?=
 =?utf-8?B?WEhUZTVoTWMzMjZZMXlJSTNUQjJSTXplamVZNkdSNkIrSnp4a21ibkRuT2Np?=
 =?utf-8?B?R2RRN0VKenBBMGREZmdvWnJLRGJOOVZnSTNzZ3JrSGFkRzBCcmZNUUhndjNw?=
 =?utf-8?B?bkRJMklxdG01TkdZUmlodTB6ZVNXK0tDSEsrMGxVVmg2RVlOL1p5T2RxdWVh?=
 =?utf-8?B?Yi91b2NhMlY4Nk1uYndJN2UwU2puRUplVmQ4aHJmYmE3SXEvTEFkNUVWTVBo?=
 =?utf-8?B?dmRJSVhvMEJvVlgwdHlxdmcyNDkrWFRkMXZnNEREaERBQ0Z1cXJ4UUE1cTZx?=
 =?utf-8?B?d3dTTUE0MmFEdkl6NDR1c3l2N2J3RmFwNVdXekVzbEcxMXkranpYVTdtWU1L?=
 =?utf-8?B?QlR1UWhONGJVZUFnZncrYnQ0QWx6VGZEM01oY0pBakp2WVNwVCtRVlZMMHFh?=
 =?utf-8?B?SnhhVllGMjI0R2dRMmd6NVBHbGZuTWZXeG1ydE80NGJFYm9oNlJ5dWI4Q1RQ?=
 =?utf-8?B?VFlodFlCR1ZnK1Q4SFlROWlOL2JZNkx5Y283U0h0NWp6ZGVvOEhjVHlVbVQv?=
 =?utf-8?B?ZFpnOFFZYjVzNHhhNmhNKzk1dENDRzUya3RIMmxpMjJJWTQvelpoRGw3elpX?=
 =?utf-8?B?TCt2ZnRKSytRcmNid0t6M282U1ZpeGhWcFVBbEY2VHJrQ3A0ZVBudDVzaVFn?=
 =?utf-8?B?V2pMcllWaU1NZThYOFFjTVpES29Jc1FHQVUwb1ZXakV2djhOSFJBVGlEbzl3?=
 =?utf-8?B?V1NZc2RiaTZLRWk3djBkMGxmZmFDT0ZOdmpCei9zeGxmeFQ2Q1ZjVHRMdjU5?=
 =?utf-8?B?VU9iVndtNUpxa3NyaVZsbC84ZHhYSHdIMFdwUGptQVJ3ZzA5cDlYYlIxb2xB?=
 =?utf-8?B?c0c0THpqY1NBYUhBZ0tYVFJDNmlSSWVBYVVTVm43eTg5ZHBmZ05FTU5YSzZs?=
 =?utf-8?B?ZXdQVGdjQmNCWk5aemJKeGY4M1ZXL1czUGZWcENLdDJkWjEvTW1vSzBNV2Ir?=
 =?utf-8?B?czUwWTRPc3cwOXRhc3RKVGM2NDVvRmFtdEVvQU8zTmdwWGt4VEovanZjNnNP?=
 =?utf-8?B?OVEzbnFmbWE3bEtBajUvQWgzNWMzb0JtYmZTVWRWSjkzVEJFbTFwUm1VTFVa?=
 =?utf-8?Q?e0jawjwWdaoSokSxb1wYZY12CJ9AIpYiwdiNL5hky/Dh5?=
x-ms-exchange-antispam-messagedata-1: KnBMDB8CZjycalxoaIVX1WjxZStv/WN6DW0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F193E4264C92D418587B0B503D3B7C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2IjkRhifLgy9qUB5kDI60uXHSG8R+4bcPRLjZ6u2yilGkfcpJrDnPnMsGWgvyQ72QDxBIkJp4nYXWiiAM3m47WX57lCunyqIMUzkkFDdWH1bRSZHiwicqvYoSOyA2ip9VptcQDO49Yr5w0g72tOP1ykmdpg1QdonfCIGbC0fugHslntRQz8wpVk5OYhjire0p6seoh5lwF/MXNkmlPYqP9YasYE5VNIleUVvh9ac43w5HgbuDJF6Z3srDmkm0YbM8kvfe1dqD6nH9UwP3tj775WpywvhKmBeyNX13Gu8eNVfSBh/CbbnmJnI+qoMwh0Vav9YhUePbCMEt1xu7Rynmg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ic+a5cgdfI84Xj0/tqkLnPomnPhwThciJ6jawKch+Haml3a9PCB/0jN00/MGoMB9373uwrDOzKi5A6nQv5SfLJ3vvIKKZB+XiXXFn/2iLlEmtHnVirwkyJZW7CffzeShiPDMZhdumKcv3ZWEj6pPj5wlU2UzZHV/k1jMUTTUcYD5Ebo6g1CwLEyOw9/9d6SFEVltnea7WRXZFQ30fR1ub3BrPZVa3eGNBKxjxrh5cxoTjmq1Po2TBfRLPpk5uW/5ei/WCk8dLutRzhq6sXXdBc5y+kQkHXX/m036j4FkD5KddEBLM9IKPPE1Tc1oBfRoYy/YLmxn2jfWWiD3Frsz1UCYwjCNiHxe5BGPtxCX4ztvKz/ClUG+PsguhaOo61nImZsc5MwuOKtS9++nznX//uY52YgS/GSaLPzzIndGpr7p5OZ1s0p/WSguTvnbRJmp0wx5chmd1DRSsqDXAyBRWB8L49cCGQHW3oOq51fbqkuedZnBCP34Ckntwgw0U/cKU7dkfXRd6dojUfxRnUBv6p8aGL9WWxSoiAbdw5X/t3YNl5muB0IP2cU16RuqaF4vhYMQ5++DTkclahnQEUi3EHjPCrQiAFfpYy8bwhbPzjFiy35erBxFucsLP8M/hxbV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a251f1f-da60-4201-9280-08df3b935d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 23:20:22.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfatwoiI3OVt3S+RRHP4NN2Cvqj/S40EbCIuP9Ka9cgePkgzoUTUw7KlJBlEIIeEkNhstd0DSQaegSC6UO32tKNGmpUfnjDFoLhz+Vzo/HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8756
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTA1IGF0IDE2OjAyICswMDAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBPbiBGcmksIDIzIE9jdCAyMDI2IGF0IDAzOjA3LCBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlz
dGFpci5GcmFuY2lzQHdkYy5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAyNi0xMC0y
MiBhdCAyMTo0MiArMDEwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gPiA+IFRoZSByaXNjdiBh
cGxpYyBpbnRlcnJ1cHQgY29udHJvbGxlciBoYXMgdmFyaW91cyBjb25maWd1cmFibGUNCj4gPiA+
IHByb3BlcnRpZXMgZm9yIHRoaW5ncyBsaWtlIG51bS1oYXJ0cyBhbmQgbnVtLWlycXMsIHdoaWNo
IGhhdmUNCj4gPiA+IGFyY2hpdGVjdHVyYWwgdXBwZXIgbGltaXRzLg0KPiA+ID4gDQo+ID4gPiBD
dXJyZW50bHkgdGhlc2UgYXJlIGNoZWNrZWQgaW4gcmlzY3ZfYXBsaWNfY3JlYXRlKCksIGJ5IGFz
c2VydCgpLg0KPiA+ID4gUU9NIGRldmljZXMgc2hvdWxkIGNoZWNrIHRoaXMga2luZCBvZiB0aGlu
ZyBpbiB0aGVpciByZWFsaXplDQo+ID4gPiBtZXRob2QsDQo+ID4gPiBhbmQgZmFpbCByZWFsaXpl
IGZvciBvdXQgb2YgcmFuZ2UgdmFsdWVzICh3aGljaCBpbiB0aGlzIGNhc2Ugd2lsbA0KPiA+ID4g
Y2F1c2UgcmlzY3ZfYXBsaWNfY3JlYXRlKCkgdG8gbWFrZSBRRU1VIGV4aXQgd2l0aCBhbiBlcnJv
ciwgc2luY2UNCj4gPiA+IGl0DQo+ID4gPiB1c2VzICZlcnJvcl9mYXRhbCkuwqAgVGhpcyBpc24n
dCBhIHByb2JsZW0gY3VycmVudGx5IGFzIG5vIFNvQw0KPiA+ID4gY3JlYXRlcw0KPiA+ID4gYW5k
IGNvbmZpZ3VyZXMgdGhlIFRZUEVfUklTQ1ZfQVBMSUMgZGV2aWNlIGl0c2VsZiwgYnV0IGl0IGF2
b2lkcw0KPiA+ID4gb25lDQo+ID4gPiBmb3IgdGhlIGZ1dHVyZS4NCj4gPiA+IA0KPiA+ID4gTW92
ZSB0aGUgY2hlY2tzIHRvIHRoZSByZWFsaXplIG1ldGhvZC4gVGhpcyByZXF1aXJlcyBzbGlnaHQN
Cj4gPiA+IGFkanVzdG1lbnRzIGluIHNvbWUgY2FzZXMgYmVjYXVzZToNCj4gPiA+IMKgKiBwcm9w
ZXJ0eSBudW0taXJxcyBpcyBzZXQgdG8gbnVtX3NvdXJjZXMgKyAxDQo+ID4gPiDCoCogcHJvcGVy
dHkgaXByaW8tbWFzayBpcyBzZXQgdG8gKDFVIDw8IGlwcmlvX2JpdHMpIC0gMQ0KPiA+ID4gDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+DQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5l
eHQNCg0KPiANCj4gVGhhbmtzOyBkbyB5b3UgcGxhbiB0byBxdWV1ZSB0aGlzIHBhdGNoIGZvciAx
MS4yID8NCg0KU29ycnksIEkgcmV2aWV3ZWQgaXQsIGJ1dCB0aGlzIHNsaXBwZWQgdGhyb3VnaCB0
aGUgY3JhY2tzIGFuZCBkaWRuJ3QNCmdldCBhcHBsaWVkLiBJdCdzIGluIG15IHRyZWUgbm93LCBi
dXQgSSB3YXNuJ3QgcGxhbm5pbmcgb24gYW5vdGhlciBQUg0KZm9yIDExLjINCg0KQWxpc3RhaXIN
Cg0KPiANCj4gLS0gUE1NDQo=

