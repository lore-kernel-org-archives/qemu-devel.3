Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B6606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=GFr5LDA0;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=rtS5YyLS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLAQy-0002To-Q4; Sun, 25 Oct 2026 22:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLAQr-0002T4-1Y; Sun, 25 Oct 2026 22:27:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLAQn-0000u3-6B; Sun, 25 Oct 2026 22:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792981645; x=1824517645;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=o9KJaVLOu6nnTvvdMa4b7RVJ4G7Zu/00hxw/Yj96LEs=;
 b=GFr5LDA0+C60ftFUwLQwzZP7UM0JZuRP1rX12mMdqS1s6tj7HfIBHf81
 AxwbR+E2SxM9FC6s7bNHJZqFiJ7kvY4AdwU7IsbGVcvklJnXJWfLxdW+5
 3Rr7WVx0bGiO4R1TqgFQfoDNEoMxoTIjFftTl2aAJBb4I8cyysrqYuppE
 DK6k34UM8esXnDGXzvF+Ev31/wYysz3pE+TxedvqEyDz+uaMpQhwVAwe7
 Q/6KDEsA1p2JnAvbeC9NFWh7MAo/IgCc38swrD8mjzB/ll1RStdAHeYY4
 wY0Zly0fsPLYJan0U+RpzE+yOXTH4pVczkKLCvVSNPdhN/lasyIMo59IO A==;
X-CSE-ConnectionGUID: N39Ww5NuQba6LLcQTIvjWQ==
X-CSE-MsgGUID: cA6bNxz4R/WQqSptljSMMQ==
X-IronPort-AV: E=Sophos;i="6.27,178,1786982400"; d="scan'208";a="159938839"
Received: from mail-southcentralusazon11013020.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.20])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 10:27:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdLtk7aJOuBL9uo3rDM1XUhZm7l6daIpzhJrwrcRBCaQ6Hg3hkeWi5q9e3xXHDstEjyEDIYWQM94W4amDZ0uZdaCtZVGGGmEjexAKu6Z5n2gOiedPHMlIaYHLy7Ca73df6gB/i5GaK21NfOKZavXkArGgaPuLj3YLMI9zclYI9skc7tHFqIHDZeN4kAA0HJy3XKqzxk+l5wndLXXgdiquzWAOMZDuI8DMMhdczVgSYFZGBdQ6BIraBFoP63JzjsvrbNRxJ5ksyvU63oHPANVX5fNTOEZ+Mio2tcRg3lu1naxwGr75LFwSafh12k69DvT4947dIZsvWUHO6EXaBuhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9KJaVLOu6nnTvvdMa4b7RVJ4G7Zu/00hxw/Yj96LEs=;
 b=H0p2acTBPh+wL6SXYC3c3qB3tnGBJ8/e47wshNm9vEMwTqJUmXsOoZ+lzARh1TN5mMcAAIfAS4Ek3YcOiBfaikDZJQyW797sXe6xenKq2yvGLeP7bM4pyzBAalUg3SwRGD8bK1+zVhrob/WN5fmvdXsePaG0PXwxHKhH1TtPd5+Go/rY1VHD49R2y0lP0rtNNMktZ2Xx+XVaIJPJ4UeaxJjWcFfjk+LSGsad49arkIetlOe+7JsITxTMIMF23iL0lSilEchRvKa9vDhY7EZRi6/FSBFklTYi0YCmssLjDitpvrGm41edKX9bF796k9hZpTU5MF1ng6vWuC/KmNSm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9KJaVLOu6nnTvvdMa4b7RVJ4G7Zu/00hxw/Yj96LEs=;
 b=rtS5YyLSRycED/ECHN+QKFqSZYcubcYHJmC/9g7zE9ZO5u6LoYpm+KAn6L0EuCEATevQJKDd/JKivuNE8dNTufZ+Wulh2RYpfe7cATE5BTwsl+6JoV+4WkryTf66UAa7KeRHbYQtZP5Q0bvCt7C4Licpzfz+nTpo5CAXXa7efHw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7555.namprd04.prod.outlook.com (2603:10b6:303:aa::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:27:19 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:27:19 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "harshit007k@gmail.com" <harshit007k@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
Thread-Topic: [PATCH] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
Thread-Index: AQHdYtHli2Yz3QbMjE+aOtPD9dTrIbcPHWcA
Date: Mon, 26 Oct 2026 02:27:19 +0000
Message-ID: <dd209add4ebf15a222917b720b5a50f67f7ad165.camel@wdc.com>
References: <20261023093522.34335-1-harshit007k@gmail.com>
In-Reply-To: <20261023093522.34335-1-harshit007k@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7555:EE_
x-ms-office365-filtering-correlation-id: 36b21d60-58c4-46c0-585f-08df3308a8c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10070799003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261009223027099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: /q/y67VFeIVUDvuMNjB+tGXuV0UNsnhTC0GDVMemYfjIMh/HSCb2VCVbvP2LMRfdOGPUqMcQTAdSHFbaE8rxrONmKt7MB2SBrQhK2Q5WvVXpdgx4WwrlFTiDFYrDlM2NQO1Fe527Gc1uU7taMHfCBk6oydXk6nshEPA7oG+Fv/LQUGDIJFthIxfcKTJkpejWm2pzi5n8N0RiKH8GXR6K50LUGY5pKFetP4Kll1gX0ZUwhPUt/g4jt2MtdqZQIR1sW4onknWlMefBr17BNqQhRaw23UGomSuaOG+qvzuvxsxeBYVl6vOM8/9gSMtHXNRLNrP27/QEndDyZ2EbUwSIyZRPQUci8xY0Gu1Zdvpsvr2aGjuNPhb5jBLE0XgjkoDRf0C+wZt6V08hfM/c2KqCWmHdFwiFNOoE0IYgQdbPUxhchaimIQ4h2Go0V0Mn+HlKUoFIDxaQfbxJyNz6raF2ImvsKzqCAS1/jo9bwPf8IlMLYQkSHOSwWgCm2m347d5ykbvm8To4bac9sZ/LGKkRPwBdJuKXTCaaGSGPo38f00NenMGzSZlTxntgSkwMJ0t0WrcYTEChkHq2XLJyj6OGVzI9tps1AKnoHdWWcSfrKDe+KonziP4wpw5WSwTHVEuxVFuInZVWeh+zXPwN3pb75wMZklZokfX+uRHz+m/YOnIaCrCUxkXMcQG2V2pz9gbDjZHM63XcYmfWRebS7FVsLLC5aCuTg3hyE41QdRJlZiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10070799003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWQrUDFmUlJKVStZbFE5YTVURktGL1Q2a2RnT3JnTndBb3dUUjNrVm4xc3M5?=
 =?utf-8?B?V2FBelNmdHkzMUxOeWhYaXdNczViWjdSa1A1TXYvMjFkZjF6RS8ycU9KY1lj?=
 =?utf-8?B?b0IzdURwMk9wbGQwQU5BZ2lyYjcxRDRncXpzNTBFQXg2RUN3OHFBMm03SmVM?=
 =?utf-8?B?dnY5aFVWQmxybExjbHA1M3BtdkxyWXJXNHQ1Y1JQQk9nbHpnOTl5MklrSno3?=
 =?utf-8?B?N09WUG8zUTI1czRVWlVNMXBvbVVIUEk5YWFpUkF2RG9sVTFRKy9DWjZkNEV5?=
 =?utf-8?B?RzZCWlBUKzlHY3BXTVBZWm1NMFJLZjR2SWxOaDFkZk4vUzhUTURWanQxUzA3?=
 =?utf-8?B?RHBlbHpEaURzZ2kzNkZleDJUaVZ0ZHo4c29RSUZxK0JPNTJzT0dTTFdDdzgz?=
 =?utf-8?B?QzRBUTBzRVpKOXFNMStvY3k2TlpOaWxlOGhyTjJySFVkWTVyVkFSUGV1L0M0?=
 =?utf-8?B?TjNRR1V3ZzFrM0lnNldLOFEwbGtoTzc0a05UWklqd3hhR2RlcC9KZHBWTFN1?=
 =?utf-8?B?QTdLVmpCS2I3aTc5T2FZU213ZWZlcGFiL1RmMjN0NEZLRzdsRUx6R1oyL01Z?=
 =?utf-8?B?VjNxeFYvRXBKNEttRWc0OGQ2L214enhOUTBiTkZzSU05VzVhK3Y2ZjFJN3pt?=
 =?utf-8?B?aEcxS3JkaTQvTlRzc3FoazJ4MXlXR1lIWGV4VkdMNjhSd0NEVndDQ3pQaTYw?=
 =?utf-8?B?dU1NSzlvT1l5eVM3UENqbTNvcE12SzRVb1Nzd0ZqWlRUcHVWd1BjL3Q3K1Ay?=
 =?utf-8?B?WDFnYlFxTjZsZElVTG1UMlRNSkFSb0h4T2lYWk1JTno4UkRxZ0k5UDh2SStY?=
 =?utf-8?B?RUt0bi9RMWtxa2trNWtINmhQcmR2eGt2RG5oR0txcXhaYStHdElaa1pKVC85?=
 =?utf-8?B?WDdQUU5CRUtNNzB2VEVhYjh4U1B0NzNqZFdRVE9WdEU2Z0VKMFpLSjNWM0ZU?=
 =?utf-8?B?OStQT1lrOHhGNzZKQUYyWFFTVEgvOEJ2YzZZVHRtN0hPbGhxTnJPRWJ5U3pD?=
 =?utf-8?B?ekFpcThlbVdWTUdkSVk3cy84emNLOTNyWHVOU0VzbUx6ZUJIcWFjd3p6MEtS?=
 =?utf-8?B?SXJtLzVVUXljYlh0Rysvb3ZBNWhNeFpDWXJUSHV2a05PdCt0UjV1RklJMTRq?=
 =?utf-8?B?eHBnd2NhUUFkeE5iOWswZ1FCZWlyWE41dVg1U2JqSnBKR09BUXJ0bHRSeHJi?=
 =?utf-8?B?em5HRWxoaUxwWlpOdzNaN3ZHbmYvd1FiZFpkRTl0UjhrUXpLSWs1MUFEQmUz?=
 =?utf-8?B?SXd4ZjN3WnFDK0NwdDBHK1Rob1ljcmwxUytWVXBDMmFQclpyZjEwWXEwUm1I?=
 =?utf-8?B?NGNnd2N4WFptUXEwWXZmZlFmS1o0ZzF0a1BjMHBDZW8waFFZY2w2NkRrUTg1?=
 =?utf-8?B?NCtJT3RhbkpmdVlGLzlONFRJemZTSGUwUFl6ajNYZ2ErOXlVTyt6M0V3ZkdR?=
 =?utf-8?B?SzFYa3BialljQmNKd1RuSzd2dFNab1RCWHFSK0pCWldtU2dUUHZsREE0NGZC?=
 =?utf-8?B?UEZqZG42THRkSkZTQ09QZFUwSlBZRW9LY2ptNER1eW5jTVFrUmw4ZXhqS3V6?=
 =?utf-8?B?OFltTWU4WlNyUFBRdW44QWltc2Y2WEZIZmQzdUJXZFFGaFd2Z2lHRWExOUVq?=
 =?utf-8?B?NHloT0o5MUxrM0liZjhuN08vd0hXbGdTaTFyWFVaaEhSeXJNWUVpVlpNelJW?=
 =?utf-8?B?VFovcGlFTVFqMTNGWDRUMzdScDhja01Ga0lXOHNLWFBlRGtWQWgyUXF0NUdp?=
 =?utf-8?B?eWFXWm1MWHFsVWdSRDArMVNCRkdsQjdlTWtSUTZCZG9Mc1BiaWJmQWJaWFli?=
 =?utf-8?B?RkZXRnJWYWhlUjlheDdHWFNUT3BGUGc0ejdyVHMvK2hzTm9XV0N0bU4vbHFO?=
 =?utf-8?B?bUxtME4xK3dXbWVxOTZ3RzFYcFcwTUFoVjBtVFFqRkF5VzBTSGd3bWhvRDZs?=
 =?utf-8?B?dGpTYy90MGcxV1ByRmtQNFAzcU9lVm50MTNuMklXQXlJQVRmNEh4OW9CK0NP?=
 =?utf-8?B?KytYaXQvSFcxU3JWeU5rM0R5NEFPV2VuTllrYzVkMksvU0NRUlBqSllQSmVn?=
 =?utf-8?B?RG9GVmJITDgwaHRrU3JDa1BQQmlGdVhtbFcwcnBZSXZnbDBIWlRhYmhwQ2J3?=
 =?utf-8?B?SEZrSUU5cjdhWUZRTVBHamJxQmxpcUhRR0c2RW54MjZkOFRrMGpDaS9sWjFH?=
 =?utf-8?B?ajZkMGFJdHpad1pMbXBGRnVESnNkblJYZ0trY2w3disxRDlZMklNQTcwMkFJ?=
 =?utf-8?B?c0FkMkhNSWR1cVBSME1KWTUxNWhHV3NyanN3YkxyOWNGbCtPUWk3MzB2NXVw?=
 =?utf-8?B?ckpVOUFqMHVrM0ZYeit3SXhGNzhiYmU2QVUvdHprejdUaklNLzUyN1NEcE10?=
 =?utf-8?Q?CoJZ/xLhAv8cjS6V0E7dEltboQwG4218TBU+6riOEgPB+?=
x-ms-exchange-antispam-messagedata-1: FXW13jiVG9OyemAzZy4AJBS8Qr++EfA8PGw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DE9FB9FAD38A44FA2618D7FF2C24D52@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GWyE5hQw/n4/rMlRHPlPmcMkZnECr8c0czl9yohybbFxNqHuauw/p4n6KbV8SFv4QRzmT/wFVTTPHNyDGUSossQsESftzhD6240yGf0X0GNg0aJ5lwXDPMH/GRvQIhgn/avx1MtqASpduiIJeb27iJE3btsM5XCSoPt8js2Fi6IwwUCJTpbZIZnjlXFLHTTY993eZDoMHzvchO9uHjYWD9eE2SGwC2AkDqiZlNd6OwxO+eMQpQBeiRp/aQ/fekNR13YOCqUE2gA7UCCtKS8RAXU5kqWfMLMcE5Q1c8oKAyQv720n03duT1ocWd2GTDbTFcod/KeF+vd/UXLXJ4J+2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VD2FeDMhUvdCzI476IZadXGhQh+RbjIz6INyJCEwiqCOV27Yx8quuwRt5ATFm8cU6hNaHUP4QyD0gfIgP3nrup6XN6p5cISEGxcB6d5uFw7Hx1aQuefdvICmSFYp4hd2Ki2pz/Z69I49M5BgAXU9CLvTRWXonxoygXkwo3akIR2FEnzQSb/0593iJ05c1btHGqvwNsh3f2bqiTFN8d5KOYnTtW+1/Jq/Qtt3DoEO7QhYpmQfEqAa7EXFLH6Q+wuIt7umsk5t3H54yvGfgYtRAHBLBIzHi2Behx08mgm291tMyIX99rIcqwSZUE23Jy2SyUtGK735L5XcfpPzUsSAakMBP+ywN7xY8u9th4XGjfUtZchhexhBIld6eUBV6wZXbhb9sOAhPAxhCfsfSBK3uvuU/6mQPdQFKJPkPV4IozBzPFLaOsSLg9FgXq5hKffOObP8T4omG9rNzR3thfobWcWSdL9X6I+lhcAbONYmqj5hogeAb7jrkD27gImmL/+Te5Zp8UU3cpc4dO0pI/tlVph60BjJwrPF4LWqbFqjQ/XsBLuVni23OVkqfZ/z/5qT8da8wZBCp0SpApE5f+/RqGvB0fUQRuD1XU7XfLsK5JJMeAYa4BACTu+z1DF3EutG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b21d60-58c4-46c0-585f-08df3308a8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 02:27:19.4043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwvJAafHtWs3OEbAa4xFuX/CXrVyCAsRkdMP55Wppu1kpfUJbVjNKn+1zdjHTYNLSc2ELV6tQ9E0n1vy8Im6g41MQBDhvfwpvAgWMbjMXKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7555
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDE1OjA1ICswNTMwLCBIYXJzaGl0IE11a2hlZGthciB3cm90
ZToNCj4gcG11X3RpbWVyX3RyaWdnZXJfaXJxKCkgcmVhZHMgdGhlIGNvdW50ZXIgYnkgcGFzc2lu
Zw0KPiAodGFyZ2V0X3Vsb25nICopJmN1cnJfY3RyX3ZhbCB0byByaXNjdl9wbXVfcmVhZF9jdHIo
KS4gT24gUlYzMiB0aGF0DQo+IHBvaW50ZXIgaXMgdG8gYSAzMiBiaXQgdHlwZSwgc28gb25seSBo
YWxmIG9mIHRoZSB1aW50NjRfdCBnZXRzDQo+IHdyaXR0ZW4NCj4gYW5kIHRoZSByZXN0IGlzIHdo
YXRldmVyIHdhcyBvbiB0aGUgc3RhY2suIFRoZSBoaWdoIHdvcmQgcmVhZCBmcm9tDQo+IHJpc2N2
X3BtdV9yZWFkX2N0cigpIGlzIHRoZW4gT1JlZCBpbiBvbiB0b3Agb2YgdGhhdCwgYW5kIHRoZSBy
ZXN1bHQNCj4gaXMNCj4gY29tcGFyZWQgYWdhaW5zdCB0aGUgc29mdHdhcmUgd3JpdHRlbiBjb3Vu
dGVyIHRvIGRlY2lkZSB3aGV0aGVyIHRvDQo+IHJhaXNlDQo+IExDT0ZJLiBBIHN0cmF5IGJpdCBp
biB0aGUgZ2FyYmFnZSBoYWxmIGNhbiBtYWtlIHRoYXQgY29tcGFyaXNvbg0KPiB3cm9uZy4NCj4g
DQo+IFJlYWQgdGhlIGxvdyBhbmQgaGlnaCBoYWx2ZXMgaW50byB0aGVpciBvd24gdGFyZ2V0X3Vs
b25nIHZhcmlhYmxlcw0KPiBhbmQNCj4gYXNzZW1ibGUgdGhlIDY0LWJpdCB2YWx1ZSBleHBsaWNp
dGx5Lg0KPiANCj4gVGhpcyB3YXMgZm91bmQgd2hpbGUgbG9va2luZyBhdCAjNDcyNCwgd2hvc2Ug
cmVwb3J0ZWQgbWhwbWNvdW50ZXJoDQo+IG1pc21hdGNoIGlzIGZpeGVkIHNlcGFyYXRlbHkgYnkg
NTdiNDg0ZTJkMjMyLg0KPiANCj4gRml4ZXM6IDc0MTEyNDAwZGY2NSAoInRhcmdldC9yaXNjdjog
TW9yZSBhY2N1cmF0ZWx5IG1vZGVsIHByaXYgbW9kZQ0KPiBmaWx0ZXJpbmcuIikNCj4gQ2M6IHFl
bXUtc3RhYmxlQG5vbmdudS5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSGFyc2hpdCBNdWtoZWRrYXIg
PGhhcnNoaXQwMDdrQGdtYWlsLmNvbT4NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRv
LWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3Bt
dS5jIHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2
L3RjZy9wbXUuYyBiL3RhcmdldC9yaXNjdi90Y2cvcG11LmMNCj4gaW5kZXggMWE0NjU4MzE5Yi4u
MDE2NWZhZjA2YiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYw0KPiArKysg
Yi90YXJnZXQvcmlzY3YvdGNnL3BtdS5jDQo+IEBAIC0zNTUsNyArMzU1LDggQEAgc3RhdGljIHZv
aWQgcG11X3RpbWVyX3RyaWdnZXJfaXJxKFJJU0NWQ1BVICpjcHUsDQo+IMKgwqDCoMKgIENQVVJJ
U0NWU3RhdGUgKmVudiA9ICZjcHUtPmVudjsNCj4gwqDCoMKgwqAgUE1VQ1RSU3RhdGUgKmNvdW50
ZXI7DQo+IMKgwqDCoMKgIGludDY0X3QgaXJxX3RyaWdnZXJfYXQ7DQo+IC3CoMKgwqAgdWludDY0
X3QgY3Vycl9jdHJfdmFsLCBjdXJyX2N0cmhfdmFsOw0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBj
dHJfbG8gPSAwLCBjdHJfaGkgPSAwOw0KPiArwqDCoMKgIHVpbnQ2NF90IGN1cnJfY3RyX3ZhbDsN
Cj4gwqDCoMKgwqAgdWludDY0X3QgY3RyX3ZhbDsNCj4gwqANCj4gwqDCoMKgwqAgaWYgKGV2dF9p
ZHggIT0gUklTQ1ZfUE1VX0VWRU5UX0hXX0NQVV9DWUNMRVMgJiYNCj4gQEAgLTM4MywxMiArMzg0
LDE5IEBAIHN0YXRpYyB2b2lkIHBtdV90aW1lcl90cmlnZ2VyX2lycShSSVNDVkNQVQ0KPiAqY3B1
LA0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiAtwqDC
oMKgIHJpc2N2X3BtdV9yZWFkX2N0cihlbnYsICh0YXJnZXRfdWxvbmcgKikmY3Vycl9jdHJfdmFs
LCBmYWxzZSwNCj4gY3RyX2lkeCk7DQo+IC3CoMKgwqAgY3RyX3ZhbCA9IGNvdW50ZXItPm1ocG1j
b3VudGVyX3ZhbDsNCj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiByaXNjdl9wbXVfcmVhZF9j
dHIoKSBzdG9yZXMgYSB0YXJnZXRfdWxvbmcsIHNvIG9uIFJWMzIgZWFjaA0KPiBjYWxsIGZpbGxz
DQo+ICvCoMKgwqDCoCAqIG9ubHkgMzIgYml0cy4gUmVhZCBlYWNoIGhhbGYgaW50byBpdHMgb3du
IHRhcmdldF91bG9uZyBhbmQNCj4gYnVpbGQgdGhlDQo+ICvCoMKgwqDCoCAqIDY0IGJpdCB2YWx1
ZSBleHBsaWNpdGx5IGluc3RlYWQgb2YgcGFzc2luZyBhIGNhc3QgdWludDY0X3QNCj4gcG9pbnRl
ciwNCj4gK8KgwqDCoMKgICogd2hpY2ggd291bGQgbGVhdmUgdGhlIHVwcGVyIGhhbGYgdW5pbml0
aWFsaXNlZC4NCj4gK8KgwqDCoMKgICovDQo+ICvCoMKgwqAgcmlzY3ZfcG11X3JlYWRfY3RyKGVu
diwgJmN0cl9sbywgZmFsc2UsIGN0cl9pZHgpOw0KPiArwqDCoMKgIGN1cnJfY3RyX3ZhbCA9IGN0
cl9sbzsNCj4gwqDCoMKgwqAgaWYgKHJpc2N2X2NwdV9teGwoZW52KSA9PSBNWExfUlYzMikgew0K
PiAtwqDCoMKgwqDCoMKgwqAgcmlzY3ZfcG11X3JlYWRfY3RyKGVudiwgKHRhcmdldF91bG9uZyAq
KSZjdXJyX2N0cmhfdmFsLA0KPiB0cnVlLCBjdHJfaWR4KTsNCj4gLcKgwqDCoMKgwqDCoMKgIGN1
cnJfY3RyX3ZhbCA9IGN1cnJfY3RyX3ZhbCB8IChjdXJyX2N0cmhfdmFsIDw8IDMyKTsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHJpc2N2X3BtdV9yZWFkX2N0cihlbnYsICZjdHJfaGksIHRydWUsIGN0cl9p
ZHgpOw0KPiArwqDCoMKgwqDCoMKgwqAgY3Vycl9jdHJfdmFsIHw9ICh1aW50NjRfdCljdHJfaGkg
PDwgMzI7DQo+IMKgwqDCoMKgIH0NCj4gK8KgwqDCoCBjdHJfdmFsID0gY291bnRlci0+bWhwbWNv
dW50ZXJfdmFsOw0KPiDCoA0KPiDCoMKgwqDCoCAvKg0KPiDCoMKgwqDCoMKgICogV2UgY2FuIG5v
dCBhY2NvbW1vZGF0ZSBmb3IgaW5oaWJpdGVkIG1vZGVzIHdoZW4gc2V0dGluZyB1cA0KPiB0aW1l
ci4gQ2hlY2sNCg==

