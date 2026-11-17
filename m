Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB34606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=aymQORdq;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=sGe3Hdyk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT8yy-0006NL-Qx; Mon, 16 Nov 2026 21:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7740b39ba=Alistair.Francis@wdc.com>)
 id 1xT8yw-0006MU-AI; Mon, 16 Nov 2026 21:31:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7740b39ba=Alistair.Francis@wdc.com>)
 id 1xT8yt-0001GW-JF; Mon, 16 Nov 2026 21:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794882695; x=1826418695;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jJvp5GvwZXyEBny3rfw9KnhPScUnb99zzN/d8TkW8RA=;
 b=aymQORdquEuhSdg57pdiaiKivwlbnXw0YM9C8M1rU7o5rUMGhfQl0EpV
 Frqbx35Ot4SkEYLWYajBN3ZFLxpQFDycOdfy0MZ4kROobkSyNl+Aky7th
 sHC0EStDdn0eqN03CgkBetNPtrIGghDfObgzpzFnt+xShn8aWwX0JQVxq
 tO9yDjrdbB5sqNXvkD/FrmB151uEhzmdnTu3cNFdTI5g0GWylC8TwAz5+
 XHJwvLAQ76Y2AGKJSzx5xJWrVUt0+aqZOG6DB5n+suqIeklVNCE0hi99u
 GzzwzV3hb2rPzucHWJpckx1k9p+nAIhRkbU+2X6n5R7Y3ANv1ozNu/EnL g==;
X-CSE-ConnectionGUID: ImzUUyLDSrSgleFP4kxxIA==
X-CSE-MsgGUID: o5GiONF4QnKCjlkQfmvgTQ==
X-IronPort-AV: E=Sophos;i="6.27,217,1786982400"; d="scan'208";a="160081949"
Received: from mail-eastusazon11012046.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.46])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Nov 2026 10:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph1YK4yGBvQznYxRXHdRiByG4zsLRrY/6UKadVtNEw+fTK1g5JSz3zyWwv1lHXLgNRK+57Dz4QzWwYSrIZ8Tg+Y4bL+XnbYFaLlx0qpr9p2DMiqUQgc1qwrSPHtGZGIAQeTp4KIaokWVm5Sje+EeQswCPtTJjwDYlyVs0y+x3cV14WsKvOqSpd4Ap2Rn8DkWePD6hq4wlBZdrrvAETN6zc6sDB0jq/Dgim1eKYA1cVkU1uCrU3t4lo+xYzbRzizR/3hFtHY+W+SSl41ZYYa5PoPu9Eirdz6MrRX9wgM6m4Zxq5mXoP3g25pnhfIdeaWyujlheEk1XGum6vmvGOBV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvp5GvwZXyEBny3rfw9KnhPScUnb99zzN/d8TkW8RA=;
 b=HCRijDMBMNZeySWNvB1hv1/AhTls1frjWXZD9YquYvRUA4XLCdZJpoAg30+zSTjMUJvsLSioXVk+nKtQ8Rh/AM/A/46tSU08o7szyhEtSGzqVsJuAvZjm3Lsvh7VrAWjQm66ej44kfBVLVbs62O91oZP/NCPQ9iFJY8LsqRGtSuQ+S1PCg5LHK6cJiaXiZKOMx/1YVtFNme+FFc6XqQXbhEbEqkUemkg6d/RWRSd3xncnD338nNBuoWVHAjc622HI1vMGxr/A0Tm7RBjhAD2c7Oi8rUs77ieLKwRmvEKuCXM5m5B7QFnw1nUAVQvxw4yND9Z+SQSd4mHgLkfuhnIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvp5GvwZXyEBny3rfw9KnhPScUnb99zzN/d8TkW8RA=;
 b=sGe3HdykvWMR6ezlD1gTgj9jFQtOOwuj7+RGxwBUvo6SllABh3htW3zCZperoB1p4WlmPEckcjdgU6V9KeMrrb5KxBbvLttSSYmwou81y7A4tbDzk0HT7qrUQNsmINuk3nK/G/jfmNkw3Fz8HgJUASMR5fAF1DAFeDSABZ0wCwU=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6755.namprd04.prod.outlook.com (2603:10b6:a03:22d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:31:26 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 02:31:26 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 0/3] Fix RCsc store->load ordering of release stores
Thread-Topic: [PATCH 0/3] Fix RCsc store->load ordering of release stores
Thread-Index: AQHdMTgBpAryGhjvFEqYObuDmMpCFbcxn54AgAB1bAA=
Date: Tue, 17 Nov 2026 02:31:26 +0000
Message-ID: <c1df4a9e33b9e6a5e76cafa75a00d3c4a901fcbb.camel@wdc.com>
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
 <CAFEAcA8Nmt_Nsvfm77en_oaE4orcQ3BdCBQWNAXmi0iqLgV7fw@mail.gmail.com>
In-Reply-To: <CAFEAcA8Nmt_Nsvfm77en_oaE4orcQ3BdCBQWNAXmi0iqLgV7fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6755:EE_
x-ms-office365-filtering-correlation-id: ee4cd38e-aecb-4298-972b-08df4452e127
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|10070799003|23010399003|6133799003|18002099003|22082099003|3023799007|261026140227099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261028144727099003|261022105027099003|56012099006|4143699003|10067099003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info: RqVuVaE855vPnV4PG5m5+PPFZEQiUKtq44uTqqg47CYU3icGjVKsXiURo4XTDbOwShHu6r5qrwvMSw8sHbkMxP91fiJfnxf2yB7KEPYwsYadgOG8ZVcTtBQJueT6nk7UrmLVaCQFAHZ3SLqxdPwA2gJw5pYZ2FonUngYwiP/ohvh1Bjj7Is/lKkV9mCekwFXCP6j8djxTEICLuDkwi/vXmtaLyaHeAKDSpklD2p3cPcBpUUKX4I4hrZW+bS+PXsvQ3x+6tokOga1a31KWFMhjEDI9fUVVTvo4aMdOywQ6bNeFVo0HNHg+bYMQ6nXix+RMqM31r+0wn0Fd2j0zoSLV9GNzzYBIiwhsh01dybMKwWTSaWfv3jxDRTv5x9aNPxY2JiaAwdFoHkPN4zI4yDOuHlf5fyeUyMFHDzJ9OABzKwvyi5cyBq+uGDMNhz2Lhy14lAc49XAGzaw2JKEYZpAhwz1rH43WZQpeV2hQCCcaPQmHtdmki3rLP2vsKeLZi/6gNPUMmfZTMzF7Ke597Bz9E20CE0ExNP4RyPC13zQwgFfi52S8YZYJsnVkG4H0COnbNW3vhT+cZlhKK8oo29MUGSKkwAdKYz6BH/92k8aUvpD4QfUsep3HNzutDtJHSkVQnMpyL7FwuOavVRYfSt5tqzoA1oQl9zsMWR2TNTPGc2krKXYC5w7VxZa9gs9qgfslctX4VTRTL7FPPc5acZ528dq41bvZP0cmQKyQL7sprA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(10070799003)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(261026140227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261028144727099003)(261022105027099003)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjJzVzdqWklUTnVLaWpnSEppZEhoQ0xRN1pqOEhXRG9HbWVhT0VnV1BCMzl4?=
 =?utf-8?B?YWJXVERNS1k2M1d4WFJBVXk1VkhWbDRkdTMyMDZWSUs0ZFhVOGxWeW1zK1ZE?=
 =?utf-8?B?cDZsdkJzZGZwbURwVXVHS2lyWDNyeXg5RVBQcTRPOU4vNGFkS1NRL2ZFdFlt?=
 =?utf-8?B?YXNlWEkrM1ZaTCtLZmNjSGMyM0pGa2QrNTVUWldTNUd3QktHcGh1R05YMTNi?=
 =?utf-8?B?dHNZVkQzbEJWdWFYbEpqUlcybC9xN3dHUURpalFjQWpxVUZZUyswLzBvL0hU?=
 =?utf-8?B?a0RmZlRqNGVFVytacG02U3BGSUFBSnBzbFozaXlEdUM1VjNmdHVsSTRQMEZu?=
 =?utf-8?B?ZjFLVlRwTlZzQW00dVlIVlM3eXhjNXM5T2dtQ1JmbkpvQ3N0RkRzUzgvbTZQ?=
 =?utf-8?B?QTIyUmo3QVd6QnJHK0JicHhrUElzaG1pcUN0V2lFTVdxQ1AyZzJYOWtjS2pn?=
 =?utf-8?B?clJINU8wTkhEVXRYV253VXZFMi8vMmxZQ2NoM2RlL1RGd2ZJLzY2VERyQjlw?=
 =?utf-8?B?bUFsRytjZXFLUVdjYXpjWFhyV1FyaC9XMWZka1JQWGhlSFhWOVd6aG5IMWxG?=
 =?utf-8?B?SkRCQzloSHR3eVVnNDl2dkFsWk1wRlpDTEhuakc5ZXFlM2RXdzVUdUV5ZmZo?=
 =?utf-8?B?bm5rQUxLMWx2R2Y4bG82OXdNOWpnVFJxVnFZaVlqNXdHZ01mUkpOcS9yNWwy?=
 =?utf-8?B?V3BUTEJjK0R1QU0wQitGUE5EaU5adjRXdTBRUWhZTEpPQ0dkb2xiMkN1K2pT?=
 =?utf-8?B?cTRuZm1VRGZUcEdQZWZjOGsyM21SRGR2QVhDUUEzK2YzS1E2bW5NdGw2eUJj?=
 =?utf-8?B?cGMwc2sydit6bHgySzJDUjRYWnhqM2VJUmhWVFAya01ERlQzSXd6alNaSndy?=
 =?utf-8?B?TkdmZ3NGanA2a1RXQ25reEtWaVhVQWtTekRWdlpVSFN0bDMwOVpvQ2hyeTRI?=
 =?utf-8?B?QmE2NVBLSGcxOC85bFhzcW9mc1ZtaXhjeTVSNUl4YWNDVU1FbFRLR0Nqazlq?=
 =?utf-8?B?QysvK3VGRURPTUhzNEU2VG5vUEJvUEtwZGlnd2NSMmx3eE1iRG5nUmI2M1pB?=
 =?utf-8?B?OTdaTDlLVTI2K0tiQmJ4eGk3K2M4Y3RoWlZCREZKRGxDOGVhcDIrTEp1S2hD?=
 =?utf-8?B?dEoyQnJZcXlxaGptd2Vlcyt5eWVoNFFSNUk2blYrcDJ6dDAva1lpZEo4a051?=
 =?utf-8?B?bFJOY1VXa2R2T2t5K3ZBQTNFRlNqMmc4dHA3TjMvTUVxRVQxRFNGZm4xWDZY?=
 =?utf-8?B?N2ZHSVI1S2tVTFl1UVNTbVplRmt2cHZzVmJoWkZwQkoyRXAvUFhlaWZMNkI4?=
 =?utf-8?B?R3FaMzgzVWorZ3dXVHYzVE42R1hweXowWGp1Qm15bmxvNTlLcXdRMnRzMnBY?=
 =?utf-8?B?emd4RWJWQmhYRzJ2V1hMMzNWU0g0dVE3YlVJMng3dUVmeElUTFpnS1hQU09W?=
 =?utf-8?B?WGhsZ0pCSFFDQjlPSVc0cXQwbWQzVEhRRFA1TVNVRGY5NW0zdndqZ0RMMU4w?=
 =?utf-8?B?bzI1Y2tsbWdLN251cThCVlFaOFNIaENxNU9FbzFqZGFnVk15RDlJbkwrUDQz?=
 =?utf-8?B?Nmg3NG4xbjFoY3hGeERyczFJWnRML056c3dTbDl4d3pqSlVoTjdBYzUwcU1v?=
 =?utf-8?B?MEt3eWRGak5zYUNYWDR3cVZ4K0RFRnVpWWswTWZnYnhHY3pWM2h5Vmx4Szhm?=
 =?utf-8?B?bkx0Q0NBam5BVDlvU3ZNYVFvTXJKOHY3Y2d0Nk83bnZOdnE3Q0ZXb2hhZUZr?=
 =?utf-8?B?Wk0venduanZyMzZmZlhraGw4Sm9GT3BpcjQvVHp0L3A2d2pLWnI5SnhqWTFj?=
 =?utf-8?B?NURQR2p3b2VIcWxzWk9VUnVyeVpabVpLLzd5aXN0Z0JFWWRDQmRyK0pKK2JD?=
 =?utf-8?B?MGpZZVh4V2UrU3MrMHcyZVJodWpEZ0NabHBzbmJOdFl5MVhaZ0tubjN1WWdE?=
 =?utf-8?B?K3FMb0l5Uk5QNC9TZFlCVVc1akdieGtjQWpRa3cyQ0NXRzgrWmtFVlpNb1Iv?=
 =?utf-8?B?Z1hqSTU2TGdLL0lJOUlwM25OWFBYaEExckwxZEhkYVMvT2pmcEZNeHY0WTZP?=
 =?utf-8?B?Z0pOMGFRbGxTU0Q4NDEvNmlEUFMxVGwrNDM3TzZSVnVCYTArK2VyblQxNTR1?=
 =?utf-8?B?NDNNUyt2UUFKTFlQc2NHTzIzS25SaUYwc0U3dUNhWE12ZWdTRWFYUFJFeUsw?=
 =?utf-8?B?TGQ3RzlPUTNDN2NNNzByeU1qZENORHFTOHZBQ1Q4M1Qxek5ZR25JL2F4bWZz?=
 =?utf-8?B?R1pvQmZlRUNnOHlxUms5Yk9JcVl2azlVWkxKbVFTbHFZRzZsNmJIUDFlcDQz?=
 =?utf-8?B?MFlQSTREU0p6TXQwK0RvRXV2ak5hU3N2dFNhV3ZDaWVNWm5CUktXVTc4S1hY?=
 =?utf-8?Q?QBZ9s7tpOgIoDnzFbXxz+ebvhAQi4HjLLKbUrQTHNW1oV?=
x-ms-exchange-antispam-messagedata-1: Pp1dsZpTZU4n23QyaBuMSneV9sVXxDuFZ78=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D220EE1E4303C0429D459C7B6B30E3CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CFNMsDg7t4pakG9lpO8NXE/P45MoUOZ1e9vIn7Qvs9Kpxbk/Kmcy7lbqW/XoefrL3O9nX5ehzvIjS2ljdb71sBj3B0VPm9kvfmgmWsndpta/pThZAH+1+RAUiOS+0q0Bh0NsX5OD0DCqBkXWsKD1QvI82Z6Cxy5xt++2xIE3dxueeM2HSXUS5nk7KQjmFX5W4QKiVxe98vpZFhO2iqBA9moFr2PTKaW/gccf14a8m7ifti/df+PI4IvlL/y/Q291K4df1jZdIXYbu0oUjWWFrj7vqFQ7w67BXGt9b1MjnwTUlxPGCDWWFJJ0mOXlUvmIUmjV4OWufUDbgpitSdIvWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LnLe1DZ+k3SrT5RXJ1jaxY6pZlnRpvc1fMQHmWW2yoH7PC+zXUEDtsnOpc10Tpu7sSOGW2rwDf1B2f30q3SjvHsjk5G+PlFYV24ZBD/rphU8dIoNixtcAzEbS3RdXsfupKj/woiorbIkEfjPHLOO0IRUgJg3AdE+uxibdtlI57utz5Zmlk4zgHwL2ymYYmW17zBkKmxt4ie8tNkAZuBNS4EH4QAeuEub3EPkQRfzOlVRjcAj3xl4RhalBAXLq0Ln44d7psmv/CZo5/wK3euLoNKhWilB4XmALhtSILYq9xIG7WB8sKKyJHMx6EpWVfL6w2mWvZk2jd8KL6s515wwy6EfPneRbmhUAIwSbk1R5wUKRiAsnQF7Q6mYo6d+r7b8/kN3O5HPJYvW5IZsUptu1gYnbIMoeQZj/6dS7/pdHU5LNVHOEcVMl1mhdb+aRL/HNPDvMerJ2/cHxAGSkrgpvFAG0zMweNTiK3T/7V1E6nCEH9zJk4yKwJpBdTyvBRUXLNuASu/JSFBd8ZjRYgaxrQs6BPz/jVdBaX8X42vMwWfovJHeS7WH0AvqNu6gOS4CiblAJZKQFeepI722hIb9G/ynlgGIVRdssLcyDLz1AneFLm4kXE9EcAHioUGub6sz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4cd38e-aecb-4298-972b-08df4452e127
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 02:31:26.4944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNsyOP1gnVKyxubBZc94wrFHzZ0s2466WXjYDzRfIDZAvx/6ljq5ZUFUAf7X5MqAM8q5mpdYpjJmII0yssL1i7EOmM1GVbK9vwagUO6jrO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6755
Received-SPF: permerror client-ip=216.71.153.144;
 envelope-from=prvs=7740b39ba=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTE2IGF0IDE5OjMxICswMDAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBPbiBGcmksIDIxIEF1ZyAyMDI2IGF0IDA3OjQwLCBMSVUgWmhpd2VpDQo+IDx6aGl3ZWlfbGl1
QGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBTZXZlcmFsIGd1ZXN0IGFyY2hp
dGVjdHVyZXMgZ2l2ZSB0aGVpciBzdG9yZS1yZWxlYXNlIGluc3RydWN0aW9ucw0KPiA+IFJDc2MN
Cj4gPiBzZW1hbnRpY3MsIHdoaWNoIHJlcXVpcmVzIHRoZSBzdG9yZSB0byBiZSBvcmRlcmVkIG5v
dCBvbmx5IGFmdGVyDQo+ID4gdGhlDQo+ID4gbWVtb3J5IG9wZXJhdGlvbnMgdGhhdCBwcmVjZWRl
IGl0LCBidXQgYWxzbyBiZWZvcmUgYW55IHN1YnNlcXVlbnQNCj4gPiBsb2FkLWFjcXVpcmUgd2l0
aCBSQ3NjIHNlbWFudGljcy7CoCBUaGUgVENHIHRyYW5zbGF0b3JzLCBob3dldmVyLA0KPiA+IG9u
bHkNCj4gPiBlbWl0IHRoZSBsZWFkaW5nIGJhcnJpZXIgYmVmb3JlIHRoZSBzdG9yZSwgc28gdW5k
ZXIgTVRUQ0cgbm90aGluZw0KPiA+IHByZXZlbnRzIHRoZSBob3N0IENQVSBmcm9tIGV4ZWN1dGlu
ZyB0aGUgbG9hZC1hY3F1aXJlIHRoYXQgZm9sbG93cw0KPiA+IGENCj4gPiBzdG9yZS1yZWxlYXNl
IGJlZm9yZSB0aGUgc3RvcmUgaGFzIGxlZnQgaXRzIHN0b3JlIGJ1ZmZlci7CoCBPbiBhbg0KPiA+
IHg4Ng0KPiA+IGhvc3QgKFRTTyksIHN0b3JlLWxvYWQgaXMgdGhlIG9ubHkgcmVvcmRlcmluZyB0
aGUgaGFyZHdhcmUgbWF5DQo+ID4gcGVyZm9ybSwgYW5kIGl0IGlzIGV4YWN0bHkgdGhlIG9yZGVy
aW5nIHRoYXQgaXMgbWlzc2luZywgc28gdGhlDQo+ID4gYXJjaGl0ZWN0dXJhbGx5IGZvcmJpZGRl
biBbMCwwXSBvdXRjb21lIG9mIHRoZSBTdG9yZSBCdWZmZXJpbmcNCj4gPiBsaXRtdXMNCj4gPiB0
ZXN0IGlzIGVhc3kgdG8gb2JzZXJ2ZToNCj4gPiANCj4gPiDCoMKgwqAgQ1BVIDDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ1BVIDENCj4gPiDCoMKgwqAgc3RvcmUt
cmVsZWFzZSBYID0gMcKgwqDCoMKgwqDCoMKgIHN0b3JlLXJlbGVhc2UgWSA9IDENCj4gPiDCoMKg
wqAgbG9hZC1hY3F1aXJlwqAgcjAgPSBZwqDCoMKgwqDCoMKgIGxvYWQtYWNxdWlyZcKgIHIxID0g
WA0KPiA+IA0KPiA+IFRoZSBhZmZlY3RlZCBpbnN0cnVjdGlvbnMgYXJlIHRoZSBSSVNDLVYgWmFs
YXNyIHN0b3JlLXJlbGVhc2UNCj4gPiBpbnN0cnVjdGlvbnMgYW5kIHRoZSBBcm0gU1RMUiwgU1RM
UFVSIGFuZCBBMzIvVDMyIFNUTCBzdG9yZS1yZWxlYXNlDQo+ID4gaW5zdHJ1Y3Rpb25zLsKgIE5l
aXRoZXIgYXJjaGl0ZWN0dXJlIGRlZmluZXMgYW4gUkNwYyBzdG9yZSwgc28gZXZlcnkNCj4gPiBz
dG9yZS1yZWxlYXNlIGlzIFJDc2MgKFJWV01PIHByZXNlcnZlZCBwcm9ncmFtIG9yZGVyIFJ1bGUg
NzsgQXJtDQo+ID4gQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgRERJIDA0ODcsIHNlY3Rp
b24gQjIuMy44ICJBY3F1aXJlIGFuZA0KPiA+IHJlbGVhc2Ugc2VtYW50aWNzIikuDQo+ID4gDQo+
ID4gUGF0Y2ggMSBmaXhlcyB0aGUgUklTQy1WIHNpZGUgYW5kIHBhdGNoIDIgdGhlIEFybSBzaWRl
IGJ5IGVtaXR0aW5nDQo+ID4gYQ0KPiA+IGZ1bGwgYmFycmllciBhZnRlciB0aGUgc3RvcmUgYXMg
d2VsbC7CoCBQYXRjaCAzIGZpeGVzIGFuIGludmVydGVkDQo+ID4gYmFycmllciBwb2xhcml0eSBm
b3VuZCBpbiB0aGUgQTMyIExEQSBsb2FkLWFjcXVpcmUgdHJhbnNsYXRvciB3aGlsZQ0KPiA+IGF1
ZGl0aW5nIHRoZSBsb2FkLWFjcXVpcmUgc2lkZS4NCj4gDQo+ID4gTElVIFpoaXdlaSAoMyk6DQo+
ID4gwqAgdGFyZ2V0L3Jpc2N2OiBGaXggUkNzYyBvcmRlcmluZyBvZiBaYWxhc3Igc3RvcmUtcmVs
ZWFzZQ0KPiA+IMKgIHRhcmdldC9hcm06IEZpeCBSQ3NjIG9yZGVyaW5nIG9mIHN0b3JlLXJlbGVh
c2UgaW5zdHJ1Y3Rpb25zDQo+ID4gwqAgdGFyZ2V0L2FybTogRml4IGJhcnJpZXIgcG9sYXJpdHkg
b2YgQTMyIExEQSBsb2FkLWFjcXVpcmUNCj4gDQo+IFRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
YmVlbiBhY2NpZGVudGFsbHkgbWlzc2VkLCBwb3NzaWJseQ0KPiBiZWNhdXNlIGl0IGluY2x1ZGVk
IGJvdGggYXJtIGFuZCByaXNjdiBwYXRjaGVzIGluIHRoZSBzYW1lDQo+IHBhdGNoc2V0LiBSVEgg
dGVsbHMgbWUgdGhhdCB0aGUgQXJtIHBhdGNoZXMgYXJlIGNvcnJlY3QsIGFuZA0KPiBEYW5pZWwg
aGFzIHJldmlld2VkIHRoZSByaXNjdiBvbmUuDQo+IA0KPiByaXNjdiBtYWludGFpbmVyczogYXJl
IHlvdSBPSyB3aXRoIG1lIHF1ZXVpbmcgdGhlIHdob2xlIHNldA0KPiBpbmNsdWRpbmcgdGhlIHJp
c2N2IHBhdGNoIGluIHRhcmdldC1hcm0ubmV4dCwgb3Igd291bGQgeW91DQo+IHByZWZlciB0byB0
YWtlIHRoZSByaXNjdiBwYXRjaCB5b3Vyc2VsZiB0aHJvdWdoIHlvdXIgcXVldWU/DQoNClRoYW5r
cyBmb3IgY2hlY2tpbmcsIHRoaXMgaXMgZmluZSB0byBnbyB2aWEgdGFyZ2V0LWFybS5uZXh0DQoN
CkFsaXN0YWlyDQoNCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

