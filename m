Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YRLhhu2b;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=jBgWtGYR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMAB-00037O-9N; Wed, 11 Nov 2026 23:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMA9-00035G-Qc; Wed, 11 Nov 2026 23:11:49 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMA7-0005zD-UG; Wed, 11 Nov 2026 23:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794456715; x=1825992715;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Qui25o72hp3RsQv9vMUKtX5fp3PcHcvoRJvCycbAIeM=;
 b=YRLhhu2bH/4kRtdDyD5oWgRz7uyoSD6k5q8d9E6kyFb5xWsZiybSWkoS
 S84kohrFzY3c5Y8PFKCFzpwZ7w3N22YedK3IvrfdsTp1GdIdpTy4iuheG
 Fg+7td2qC0KXmGyTIuzNmx7qdzS/80z0Y0+4/okX30n0k45c3ZlIxrUIq
 w0r1fNoDyUdWp0/xdb4/uliKNwHF4RzahxT4dDjQpdwNaoVN/LDpHP0y8
 Lzjxjg9z8vSljQeK9t7VxX+nrt23LvxAFPi42AS3jdepuUCpX3FXR5DNz
 k+rSqxBHFyL5gLn97XLEQaLvV3YecSe3JglI6pzcskLQMT6RL2o+Ze9L9 g==;
X-CSE-ConnectionGUID: Wqj5uC3mT3STnkMlrWuflw==
X-CSE-MsgGUID: In6h4fn0RBmWclKqhG0S7Q==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="160628657"
Received: from mail-eastusazon11012067.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:11:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE1J46MZzsgUdrmKuD6I8UTyXdeWF9dsWJpXmDCmvCTJrXOljNH9qFX3VpJ3ocw9POccJjAIhyRxn5rWSPLjm0RPkx/GaETMrBgECyTWK4KMawuT3Vzqc97uOHS/6MaVU81kGwh5cezu0EKmph8oFRntiHjuggzdZXkZ695pPpQK9PvBRwk6nF/ElDYAND8lp+KVbHIyGe8G17K6QN4QxyLF0T+RjFWDma2XYJPY2mQ3C700B9winsW4/5Ol9CMmQbbqj4TMB9J7FF2DpnO4S6cOx0YDS881yugs4roJTedVmJ6hEM++Yh0XeE4CZTtdMPwz5RgmMUlmGi1tDtHpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qui25o72hp3RsQv9vMUKtX5fp3PcHcvoRJvCycbAIeM=;
 b=FGeWabvI80xUSFdr78F9HYFEt33+xGG5eADbPEKsHkwEdbxSK9/BixAkjn2igtRtWXCYEHILY6VlzN8C/IzvQv7OAHO+yS1JF9iLHzx6Fv/Ukkb8gzWkW1b4r4iSWtX8foj6UiMkK3KCWZc9j9Ra3+AJinDPBnc4FtRocYXzlI/SApD3u70ZSeCosuFx8rsu9d4uoZ6ZRkqEMtxMzkFKsqjVc1qH0Gb+4uieuKsTN6yK/Es+JsWxg07J33M2ztxQDa4NKOHhSPiQqMIV4U6gAeteY3LUO9Igcyv3j0esCuIxSiAKsT1DTuUkowHa9kZDewKn3RtJFxsb1qPPwxdWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qui25o72hp3RsQv9vMUKtX5fp3PcHcvoRJvCycbAIeM=;
 b=jBgWtGYR9dbBVqgcHcMF2+4Jwi+TXsAA3V/Unl+dydJBt2wo4QhipIFVpCyb1EUFvDh8uKlWs/6CQI4H5+DB57gaAjYc+rm3QftGviu4zcM9gKwGLGmGhPksVLsv+UEgwrHbFKYMh0l0TypNu1YpJKpdHWhrHnMEaPd4L6OlaN4=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH0PR04MB7606.namprd04.prod.outlook.com (2603:10b6:510:5b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:11:43 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:11:43 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Thread-Topic: [PATCH v2 0/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Thread-Index: AQHdcashAplu9hWcVE2v/VXdLxryCbcp1ICA
Date: Thu, 12 Nov 2026 04:11:42 +0000
Message-ID: <ce161e71d8ab95c2a6ec77f9f0d239e07b132ae1.camel@wdc.com>
References: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH0PR04MB7606:EE_
x-ms-office365-filtering-correlation-id: 16de1021-de36-48ff-a8af-08df40730f3c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: S9O+gJZEx1x9qX/qNyQURY+jAtUwZIvCtWbiWhPCBGvFu1J15uyIbG9IYQrygRqS2hucCgU03bLU/7OYpBPrDQ2ypLpNuemfITG27H1TpkLCJG77zC6NSuFu9c4ws9NA3v9EFT1eQEhoIOp49XhecBmzeG+5IwKcKoZKzm1Y6sC8vQqg5nieQRmo1cB+YyiYiA11A0Mv5dOZ8qWt1O74FWCq91nYlMnaKcLhUbvZ7xBb2U9BMGVYz0tsGI9siEg/vwdYAlmM/RTqZvgx8w6KcMCL/QMCWUf6x+ydFHFmRpJJMEwVd4QWIEB7KSINsUmX67FcQ9/nzK+OUgvnVxFjNSlcqBbmnvXD8XoC2P168H2w8NawnSWAEjMkl+1sCsU+qeZ+4Oa0dHwf3DQuWnD/w8omEIzDuKX0i3tHPfSqzee1AIZEAcTXZ9KZgrLQsXauqKW2+bmCgteJsfuVCe3l7ywF6yxTxkJQRsDwQKcKObdw8/RVMnLCYXWdGLLrjgerBppCBfe945JuD+7fZbfm254t1H3uQpeTiQZOyCHjE3TOSvNgO1YQkemD8dojXxPpRMIQ7m/HqhwVUzUm9R4U/rYmJ17LzV8LfHnzR5TFxE3FHHm3hFxLgzJhB+MpIzI6fU/S2buwnVNJ+Eg2geGZ55JlyGv7BEBRmgA1GC9jUq0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWd1Vk9mWmI0ZS9VMldJSG95TEJEb2I0aHdMd1hBWTFrU3k1am5JOWRtWUxu?=
 =?utf-8?B?VlZKaVJmWGRDTU5SR2ZhNkRmQ3VGV1RMU3I1MUxHWnM4MDQ5ZEpyTzB4aXpi?=
 =?utf-8?B?K2tkdWV5RldwRGJMby9QMFdBWG5jMjIzcFZwdStDOElPTktjbnd0d0hQU1F1?=
 =?utf-8?B?UTlmRHl3cXpCYmZGY0NCZnFyUnBBNkhZc2ZCdmNYQm5GNUpINnNXVUd2UGZQ?=
 =?utf-8?B?MjRWSit1NE9qRjRFd2RQRk9IKzRnVmJFOS84QW5sMEhQTForQ0FSMnFZblhH?=
 =?utf-8?B?cG9lcDZCQjV0NzVTRFpEVDRjSmpqRWdxWDFsd1ArdjYrVHB0Q3NFOG14d3Fw?=
 =?utf-8?B?eUZHZEp4enlRUXZYRW1EYWVCQmpKeHVhbEtQdHljd1pWaDY5enNvcTZ4OVVt?=
 =?utf-8?B?VUw0aUtRaUVUZnA0SXBjVW1MWXRKVHNMa2lCS2J0QVIrallZS3VXT1VaU0Zi?=
 =?utf-8?B?YlBNMVMvdCtuZGZObVBDWVFtalNnakNsbzdLNVBpRWtLbXh6MlNWb3hXenQw?=
 =?utf-8?B?QWNpMXlPUlI1eDcrU3ZxbDRBKzJSeDlZQUF0VXZESU41ZldyQnY3NGhjc2h1?=
 =?utf-8?B?N3d5ME9MMGQxRjJWbk5DeGZPK2F5aXh3bi9nek5GMEVCNmRueHJIUzZOQThB?=
 =?utf-8?B?Q3dVeFQrMTRab3RtTVRyWUErYVEvVGs1U3lxTFV1UDNXa3JWaWhZOWlzNzZq?=
 =?utf-8?B?cnY5eGJnbkdKa1J2cGpBenJvYTJZTXcyN2RHcWN4YjhVb1pZYi9ycm1pdVpR?=
 =?utf-8?B?SEFDV25ZWlBvaS9pNlpUK3Fra0dGc3VFenFVRXZZeDZCbVRwdE4zNXAyOTVT?=
 =?utf-8?B?UURSUkI0bG1lZUNtSWZqZjZRZ0g3WTA4OEpzM0ZBWkMzdXMwMVNiV3pzRnVB?=
 =?utf-8?B?VTQ4S0g3OVVodDY1dWl0Q1B2UGRBSnJHNDR4RzB3ck9lOG9IekZ2bHhHMW9t?=
 =?utf-8?B?aEdXV1hPMDkwS09ReGxZMHo4RkF4YUg4YjZFNXpHdFBuajlPWksreGQ2RUo3?=
 =?utf-8?B?QUtqTEdkZXpMSWZGbEttQ29ib3dDUzg4NHIxV1IzU2pZbjVKRkF5NEtYa3NG?=
 =?utf-8?B?emJDbklPaFBOOFZhUWIxMURVSms0eEIxVDlrcVhqdnFDUzZtWGNzVVhiUmI5?=
 =?utf-8?B?bjU1WkJ5RHhwSjArWm1nMU9zOUV0cnhkVldyY2ZlRXZSSmtSb29Pa1BVVWJ1?=
 =?utf-8?B?OWgzRGwyWFNrY2l4bDFWcENaZW9nQjRRSW5lb2F1K3NzVFpwZEQxRTJ0b2Q1?=
 =?utf-8?B?Mjk1QkNMWHgwSkJybC9RSkxSUGtyQW9DL1BEZk1zL0RwTkl4cXJGUXlmcVhP?=
 =?utf-8?B?MWxBTWlyaEZGREpYSEVQVCtVcUFsWTEwWkJhcFlMVm1BMVcrMjJRbzBTTjV5?=
 =?utf-8?B?T0ZmK0psaFJCVGpWUHc3ZHlVVjU5QytGRkJDQkh5VXRTK2ZoQ0I3QUxSMWF6?=
 =?utf-8?B?cGQyS0lVbGhHeGd1bWx3cDBDenNybnVaVnZIdWxoVGlBZWw1U3BFSmdWSFVi?=
 =?utf-8?B?blFSQ3JCOVlkOWlhc0lrSTFhRkF5REo1UHdERmV4TnYraGJkNFM0THFsNlRZ?=
 =?utf-8?B?UjR2d1grVkJQS1pCNVRRelNhWWgzSk9KNFRjSmlLbGtrOVZtRXViL1NzWk9N?=
 =?utf-8?B?YmRlOWhQZjN5TFVSYkx0Y09FeVVtNExUNVljZU5NdkJxaXVtZmVMakwxaGNF?=
 =?utf-8?B?c01GK0FHU2RvL0NUUVRiWlNET2Fyc1NBVGhaZmxkTjlCY3NZY3BSczg5M0dQ?=
 =?utf-8?B?SFkramdsVXQ2Z09EZERZVlpIZXEydWxFd3hLQXVxZHdBUGZZSzFrOWlySGJr?=
 =?utf-8?B?SjRQRXdKTHR5a0IzQnF2bUhDQXdYVWQxVVBzdjRoelhTd01yODZJTXpnWHl3?=
 =?utf-8?B?Z3RwNjl1NTRZT2NOL09Jbm5HbElpTHJVcU5Hc3VIRjdIbE0wN3JBUFo4bVJi?=
 =?utf-8?B?TDlmVEZCQ1RLWHZTWnJzUDFvdzJVVWxzeDV4YU02K0VHS2Z1YVc4UklsQklw?=
 =?utf-8?B?cmE2b2NtUnA1dkV6MTRPVTJMWFloNlIycXg1MTFjemdrK05MeWhaMnV6bDEx?=
 =?utf-8?B?OGsrdFhVVVY2ZkRKNnBpZHg0QnU1dERSV1RYRDRjbEVES1NJLzFvbllGbDRq?=
 =?utf-8?B?WHdhNFE2YllJRWdrOGRnYUdTMkFjTlJWbVRvSFFBWWZuaEFUbUZCUE13L1V6?=
 =?utf-8?B?MFJjL0w3UHdVM2VJK2VLYUcySjgrb3lDTzdSSnBIU1JCYUtrcTJ3cnB6MSt0?=
 =?utf-8?B?YlhtbzgzOTd1SnQwYnp1WnZVUWVORktTemtxd3VabExsQ1ZhVnZ5bmdiQXB6?=
 =?utf-8?B?YWY1WlRCSjAxRFlqeG43Q3ZPTTdraEF1VWdMQk52L2FqQndrdXQ3OWhpTUVY?=
 =?utf-8?Q?24YO6EFLjvkTpiDw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E1B2737C2A27642BEA2DEFCA26827A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NJVpDz4nn4zQB0QOkWv4zBng21oqwUiG/Hy6GbVpWtGzx53Kdd8RGsIGzhQ6NRS3eqBDSGXMfpcAhpHgDbDgW3toDUnv+LnQucxZYRGpJHdcOiGbRXAJQWi0TJkX50/bu+lq+anL4Z2VmidWWWhN9f32b6h3afeUKhko604RkUZJ2i3Dvhb30xDq4UTea7dqH9ZE5xqCIgvEX5OYo+uJXPjm6t7dysK+93NNT812BwdIvDr9ZywCGPB4KURla2vUKVQ6gXBezl5PXO04PJRRavYhRSAUTxlRt/lrJ4nTrbM5gN3yp4blk9Owubg03pyiJalWDQxWpDHNZMQejW+V6g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nGgtTc14jTZaF3SM5XJQflv6OwfDg/FbWbr78XMd0YD8LZlxd8fHhKZOz9y2/KpHCE02e+eCk/uc1bc1pHaJnxnSNrp33nLaJQf05C860NfMJ1Qe6OX0N2drlvE8QLUB5nAGjIzhG9ABUI69ZEV3Pm+RIwAAG8aLepZADqAYCqWnmr56YznvvPdc/6/p7SyampqTh8KR15VNwu3vJD9fJy8DjNPvqL5ERdzL5o7w2btqXdHEOx2j2nTRSwS1aH6OMol6d736cpoCbuJox9tRe7k0z+YTMPvnbWL3weUT1sGO3rlqNfkUqSx9xZHkz6Nh6Cq7P6suPphm1iOfyrF+GqoDcXhXsJuj9S+OgDqbgvyC9rzuVXIzuDYEhBeCn7qSSVh9f54iVDkv0hWJ0lsDkSWuQKJbWQMgl9FITV0sAJg03lkAyw3J9uMJ6ahJuyhGsUvxisrug2Il/Sw1TUEhPhgj2IVrFYGUnQGrT/xvQnAGb/fonsueWwA5sEbBmM1LGGBC9OnFYPRo1M+XEP3F92cWF4Ufatez7w1Q96EHWyp7l58HTCNNId7mZwtPC7mVyTALT+4ylvBxmXdYa81ydJ0AAa9orChF3tqy0352Ts8MnSSlzr9UmvwU+IvZDpFQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16de1021-de36-48ff-a8af-08df40730f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:11:43.0350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhqKeY/WF5RlyZTm3VUwt/U8WT6ifVl12/DLvHP9WT2gkskaQZQEDXl7SGbBrsShIu+vnHDgBuqH9MJoXJRqIS9tU+qVUSbe9kZ6ZmY56Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7606
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTExLTExIGF0IDA0OjA1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSGksDQo+IA0KPiBUaGlzIHZlcnNpb24ganVzdCBjaGFuZ2VzIHRoZSAiRml4
ZXMiIHRhZyBpbiB0aGUgY29tbWl0IG1zZy7CoCBTYXNoaWtvDQo+IHBvaW50ZWQgb3V0DQo+IHRo
YXQgaXQgcG9pbnRlZCBvdXQgdGhlIHdyb25nIGNvbW1pdCBpbiB2MS4NCj4gDQo+IE5vIG90aGVy
IGNoYW5nZXMgbWFkZS4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gY2hhbmdlZCAiRml4ZXMi
IHRhZyBpbiBjb21taXQgbXNnDQo+IC0gdjEgbGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI2MTExMDE5NTAyMy4yMDkyNy0xLWRhbmllbC5iYXJib3phQG9zcy5x
dWFsY29tbS5jb20vDQo+IA0KPiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSAoMSk6DQo+IMKgIHRh
cmdldC9yaXNjdi90Y2c6IGNsZWFyIGl0cmlnZ2VyX2VuYWJsZWQgZHVyaW5nDQo+IHRyaWdnZXJf
cmVzZXRfaG9sZCgpDQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0
DQoNCkFsaXN0YWlyDQoNCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jIHwgMSArDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo=

