Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554A606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=AldzPYJ+;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Ld4s4z9j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4h3-0000wz-83; Thu, 22 Oct 2026 22:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK4h2-0000wg-3F; Thu, 22 Oct 2026 22:07:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK4h0-00084f-2V; Thu, 22 Oct 2026 22:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792721258; x=1824257258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=l655Un/HYgZx/KWBomsti7fxZmuL1h1JcOAedHqsBRY=;
 b=AldzPYJ+V7W7Wf5HtkZFHkd8trlgNpFS3nDnX4TxlRPhOpzQfn6BmOGE
 aaQBfCK9sq4J/cVnAHR01KT5C1xdPbTq5x5YA/HuiuO63Kwxc51N7bwuj
 wOpYUritztHDUF4+Md+cxvQ9XUfmVzZjrfPS+bTF+TX2k3NpdzXaXp/7Y
 3hvFqVu5zS1ae9i9PcJ0XZ9IOZvXJ8mocV1nzyG0xjO1lPL4BrecPJCCE
 gp/SMBpCFWFnm69w11UpiU17v+kBMo/GoJZ4Z+BKVjzVN5DfzVE/70EGX
 eHcEnKixmc6YumQPnd8zgSuiNNMiLQkBT0/8dsKNeTwvPszOqEuUrSxai Q==;
X-CSE-ConnectionGUID: lQY/dz54RFeQv6uPPKdGxQ==
X-CSE-MsgGUID: /JT21w1mRJ+IdoTv7nnHiQ==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="158800011"
Received: from mail-westcentralusazon11010047.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.47])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 10:07:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+qGwYzJPu6Y7f5d8maisxCIvNzNPjeXHO3bnjAKqJ0KVOuirvu9LVf7vFvQ3DqB0ZVkynDAHZb3kR5gW8vk55RnZfoZ+sGDbqCaFewz5ZD36sRMCzC4HWfv27beLV3ubo3DwKs1vlseVQlM9t32/PNu+0+Kbd+8WseICEbUV1PQGtGHl9Kc8ABpijO5tRpEmGe1FWPm+V0NGy2kgxxr7jdctYRoRoH8nQFMbfVhtObhHr3EcmH0cQFEldd3RK4DzVJofdZkk8ykvrNa6Cm2x0Dyto+Ry1Frbo6Bq/FOhhmL7InClKL/WXE9qYkXTkwUR4h+cqhAxH+uknq2VruwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l655Un/HYgZx/KWBomsti7fxZmuL1h1JcOAedHqsBRY=;
 b=UVVZP4kERdki4F1pkS+IpSEf5NOm+/RctDeGB6lt8g5CSftx0+5FFR1g1VPI2Fk+HUFqVLZFtNR1VLBXF+VTdF6O7c/u8HntLGqKNPXGbNUlrYHR4RR4/y/nVz1j8HZ69knVvoZeS4ISbvI8C7+1SGqSJ1lnr3eZp2f6wDsflFDvTJhc/s4Mo2nb6tJFtaemqjtXKwIZk4KTCt8rvADm9oJVPJV6ZbMOr6zs+1vdOuhskNsrpSd7zSHvTLqPoSvq0xdsayGPjAgFDMsFwL5R1NEJQn/YlIrvtlPW0GGvn0LdiSqLcVmW7TtoSCAPG4PppxlZCrTuJeTNbbNqgBmtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l655Un/HYgZx/KWBomsti7fxZmuL1h1JcOAedHqsBRY=;
 b=Ld4s4z9jiM2OvTlM7Edq/VXkU8XihVVtomp5y6x18CYRq8fA2l+SjX+jg+4RNUJYFRp4i5Txrsj0nRbg48olUmH43KBUSY3+XEHKZHn8D7BGohqAn7PCUTPgMikbE++P47NU6gCEPSRad8/doRQTl4HCcJ9hc90o19t8aLGDq2k=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ2PR04MB8847.namprd04.prod.outlook.com (2603:10b6:a03:541::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 02:07:33 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:07:31 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] hw/intc/riscv_aplic: Check config value bounds in realize
Thread-Topic: [PATCH] hw/intc/riscv_aplic: Check config value bounds in realize
Thread-Index: AQHdYmXdiPLfr9TGh0WwJQqU0gJNKrcKYbeA
Date: Fri, 23 Oct 2026 02:07:31 +0000
Message-ID: <97a6d73ce1cca97a8de68bd7bc58b575e4026345.camel@wdc.com>
References: <20261022204223.854640-1-peter.maydell@linaro.org>
In-Reply-To: <20261022204223.854640-1-peter.maydell@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ2PR04MB8847:EE_
x-ms-office365-filtering-correlation-id: 04e58cff-540e-4041-6061-08df30aa6564
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10070799003|19092799006|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006|261022105027099003|3023799007|18002099003|22082099003|38070700021|11063799006;
x-microsoft-antispam-message-info: AcwTT2MutiL7HCBDRfT2M0R72hIhtTVKJsAyHImi1tuvJefM0w+uzofgYv9lOlVCEMz46tXBcNc9XXKFe78QPYmr5FaxzE5c+4PU/Ct6i71PXxi/oTX5+M26at6X8Lluj13v/08+NZloDNtVyzaSql/4yCTSf79FSpXWW0HDc9NH/aquQTGLhWEN9o8H277u1BFJZCvlmLiGxm6/eXjde47pghH8MwBy60k4WjhcNNbj4hUJM/rWI002Aj5DtpM7QTS0tkgS7JobzPBVJbSrYtLbZ//1JIO7Koq7jrM0BZHbSqKQeAJZMBFs9SLaNDGmLQYm2rlYl6psko0w1LxQPONEX6xaBas8ubKSlNp1Jz0taoXHRGm1+JxFE735ycoZoRrgUqLgNzFWbia7eKGaL8JQiZtdZ2msE8lhXtmT/Pl/F73jwQ6+5PRIgJOYZjk6TsPBynvQvdvaxVEA75bi4yM1DnyXqqh3sbx7N6pIdJbUJNq2weiJjhEk6gbcsMmqlEict8o72s0abNrDRk4r2GBhHMt690ormZXpx1XcDAWcafz9L3V5CUUrfGgjVUIOGMHUVWnPXi3zXcZcOoZcsMgGKARD7wy9toxsYgahHC7LGY5xHqACcekh4vVHGi8qSOR6lyZiPk/lFflFgsPubGvR3AY5KFCzkslCf3GH7PAAicyAjc7zBhz0ynykrQiUIN29BHARFh/NgifrVOWO7jyal+4LEfj0Z8yM3eGYy3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(19092799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(261022105027099003)(3023799007)(18002099003)(22082099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEhaRC9ML1pWMzQxeXhBWHZUSERscE9GaDN5MG1WMjg5bk9FdjRmKzF4d3cw?=
 =?utf-8?B?ZzM5SGx4VFRDUUFLUThualhqWGFjSWgzNTRra1NVYml2RlVHai9xWmpyaXJU?=
 =?utf-8?B?YVRVaURIdzYybjlJYkF4Tms0R0JRK3pyWEVPanVNb0hnb2JjQVZPd29MYjgr?=
 =?utf-8?B?dkFxb3BxVnJ6MXo4QzdWaWVpL1MwQkVsdjJkd3RqdGtYSFk2YXU1bGNjblRu?=
 =?utf-8?B?VnpWTWM1QkdWU2UxUHYxVTIrK1ZKZXFsNHhDTTB0alE2N2szYVp2UFZSdVpT?=
 =?utf-8?B?V0ZETG5NbW5EMG9CMVRIdythM21ady9GUkcxWTNjcDRybTdib0V3K1k3RUky?=
 =?utf-8?B?RjBvYmxxeXU0Qy9IWHZwZUsyRVV6MVF5eExwNmJBc3k5MFhKbUNKQ0orTVFz?=
 =?utf-8?B?LzJPK2k5ZWZzNVhxRkpTUkp5TVAzV2sxM3pXZHZMRXZZTDVjb3djRUg2eXpy?=
 =?utf-8?B?YUZ5YXlXTHRvdXc2MnNrM2dYWlh0dXhQOFFOMXh4YTQ0M2wwc2JsTUtiRmpt?=
 =?utf-8?B?ODNTMDdSSTYyVGhadldwOFBESW1uekFpa1I3SDNUQUxQaS93eGpzdVFtbm1V?=
 =?utf-8?B?OHBMbTM5UEwxejZBdmZ1YnVTK3RPT1Vuem94UTdOdTR0OWNWNm9GTTlQVmR4?=
 =?utf-8?B?ZXJiS1o2WkxzWWdRbzRLWC9LM01naUw2SFhBRVQ2WHZlQWU4SkplRFpOZHNt?=
 =?utf-8?B?dUZBelNMTGdLQkVYQlFHaGFIOGJFMkdsNDNrK0ZSbzFONnJwV3I0aGVFbnBp?=
 =?utf-8?B?U0luc1FsOVJtSmJyWSt0SHpIMk1yUnlTTVFTMjM1OEg5OU8rLzB5TVpxL3Bi?=
 =?utf-8?B?NWFvc2o0clhoZ2dzYWpLajZPcTNURzJSK2U4SkxTOHBBS3V1VnZ0ZE9ndG9v?=
 =?utf-8?B?YXFEWnhwVXdmR3N6ZzM5anBiUkRNUXpBVXdwS3V3Y0JoczYyYkxoMnBvQnMr?=
 =?utf-8?B?cUJrQlFzbkE1K2ZIa1ZiNXR2Y251RlZTWEozRWdrTkNCb2tGWnBVUi9POVBZ?=
 =?utf-8?B?Qm8vY1I0dDJncU93K2g5dXhLMDVwekhPdFYxcnloWFVGUEJNc0VLaW1xbVdj?=
 =?utf-8?B?ckgwdW42SG80SWNvS0JYYVpYaVpIVkREOEN0dXZ6YnowcUpiTGZGSmp2ZXdH?=
 =?utf-8?B?bC9VU1JHU3pIRm1FQUgybVFQUGZzNjV4MzBLaHp2ZGZyOXRXSldSdndnUVZL?=
 =?utf-8?B?WU0xRXFPVUV5SElzQ2NtanFPMDhHa3g1aS96QWw0ZG9heStGN09JZGRZS3lB?=
 =?utf-8?B?TGtWdktDZy90UTFmdUg2SnM4ajhXVFVEQlpaTUFYZUdqM2R2eDJPRHJhTzFJ?=
 =?utf-8?B?cWRYeUYzT2dkRHovRHhsdy9Ibi8wZ3RDbml1dCtMK2FNNzhNWVNUY3k1YUls?=
 =?utf-8?B?OHVsempqV2tRalk4Z2xxZHFCUTFOVE1QbTZrTHNmWXlCNFdCdWdyUGx0SWhM?=
 =?utf-8?B?QTdyREZLWUtEN0xCWE85SGVDdVJqNXZnaDkyeUp0bUJoRXhRNlpsUDJEdGhi?=
 =?utf-8?B?L3BHSGxxa0lWblpUWEhLdnIvYk00WC9DTWhDUmtWa1VDcGdid3RrZUFLUnl1?=
 =?utf-8?B?Rnd5Tk8zb1RNQlNqOThKempUbDBncnY2SmducmxwNytxcFd2VDBQUXcrTUdX?=
 =?utf-8?B?cjFidkFaY0d0VUhlamszUE1pSnltaXZzdDk5Y3JRclV6MkFzYnpVaXFDSVpI?=
 =?utf-8?B?OFZUVlk4Zi84UEVGdnVjUXV3dVV5UStFVDNVK2IzMDhkdFF2cmtHYjRCd3RP?=
 =?utf-8?B?dmlRaWt0bGlLdmtFaTJ6Y3lIVVBMY25teDlaUEpZTmRMb3BzQXM3YjFEL2kv?=
 =?utf-8?B?OGRsTUZmbjN4UW9jcjlpOTd0UkpOMjhIUXRuaGlEYVhwNHF0V295T2tzb2w1?=
 =?utf-8?B?WDQ4U2d3QVQrWHFoYnp0OHhIK0VhYzVEczdUYTl4NVh5WW5Ybm5sdm5zTXFh?=
 =?utf-8?B?b1NaVS9wdzNRbDBQdUNCRVNOOWtRbUVYWUY1RFpHTzZsSnN3VlJHVUQ3YjBu?=
 =?utf-8?B?ZTFBNzE5SVFEQ2tyQ3BPUnlwbnV3d0tlVFdnSVJVRldvc0RFMnl3NmJxR1JO?=
 =?utf-8?B?VU1sQlIyL2k5VmtDSStnbE5wQkpHQzNYKzg4ZG1ZQTlZVFRsT2VnZFVFVFp2?=
 =?utf-8?B?VE9XZXRzZmVqSk8yR2FOekc5NDRqOFBPSFNhK0p4YWF5bHNPZUVMSm8xTFhv?=
 =?utf-8?B?OFFBZGkzYjBZTlhpTnBHbGlFODJsSHlWVzdjWkY0WGZndGg3QThIUWxRVHh0?=
 =?utf-8?B?eVh2QW9yTm5DREF4MFZ0MW1Mb0VhR21mQlVTNFlRWDA5ZUJtdER1Z2puNmZo?=
 =?utf-8?B?SzV3Q2NTbjdnOUdzVjVJTnlmdmVFRVB1Y01iWFl2MDZ1ZGt4eFlXaVl0bmlq?=
 =?utf-8?Q?+CI4BLv/ssM+WbBN0caPu93jBg/l/cKvRaFsgC1BCUO19?=
x-ms-exchange-antispam-messagedata-1: Mxg31bAKMOVipzqstt6oPTSJFfQtvifQbhg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D09C54FAF97E924D85687786568FFE29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E/rewhgGllbNDr2DgJEPpqZlLWLeXGUiIW1m7XgS3M2dX52sI3keCGm7U029JKtdt2hdvAf3VIC0vsPtuVWDe/ROOhCWFk3ne5LC7hCPFCny8unJseHWCHmJLoPRGxpV8zDODcZcMipnClwbq/hnv6LMGJQsmjxbyqYtv4luw/ptw8aYc2KjSv/hhZhWLYlLjREeo3DocAzg8+xbMfQ7u9NiB62zamc13yIuUJdd060r/+drRvsETEEIh/m63TyzZh0g+Ks/fCH5vz7XI26C06JERCZNe+Uk3SPLuL/CItTnGf0rDDcPYpcRy7oJnQf3UUklTTEoCT7sjFCk+GOjXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EC7M7GVDC+/6CMa7SzeP8y83I1WRQYfyfmJ9lqEHU40N42do1x9MJKkKDk1fVWKTRs/puwq2H3VF+dvY+TrpM+xiSHJFipYBOaUijuij2iYZeUdFF5U/1A2KxLn0KgsIuxRM1V6anin4hB7+0zK/CeWA2nqy5iTb0WA0Vw00Kwb3/Oip7K4OzC/rjyrU4kAHjjquvFLmCd64DTwQS+n9PmQM4FYsYEUuwfdqx4CjQTuWHShGdjG9zT7/KNGwtrZSHW4KY0qnmeEGXCVJ/hYGSkKsc5XQyEW5tJPbW1s9YN2VdlFOCwF/igxaR5vNm6nf3Eav9zZLmDA8SFFh3cJauw4bxvEy32L7dp+q4yyucGEozfNVwLoZseP1ijKTCXIOp964jUHWbnPhS41agjznVzvCcQ3WhPnCn7HAbZOYTCjX0tvAucDHbMpd5mIlybN+cPDHyV8fGkiEgF4krNbragyDAsYLx5/+sAk+b0KpV2cly0dWqbqObSaruoaoeAzlX3cj58BvELC2ZOgoxOa/SqmvZbtJs7K8vcdWrX/EdIjdUEeoSRrL/ycjj3LN6aXLw/uZsMYH/4RcRqnd82EOQUoKXPXJdKDiHl5wHtLHWOlxM1UpvQBsVX0fu1eIcpfZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e58cff-540e-4041-6061-08df30aa6564
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:07:31.2771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1Gof43jGMw5gCKXfq8C6ayyEAoCagAFq/m/riTseVoumZibLN3W/Ik90mB5N5wg5Vs/0+JViatqEXjwelbIQaaBzFn0uPOkCFjjOr3ZO18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8847
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIxOjQyICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBUaGUgcmlzY3YgYXBsaWMgaW50ZXJydXB0IGNvbnRyb2xsZXIgaGFzIHZhcmlvdXMgY29uZmln
dXJhYmxlDQo+IHByb3BlcnRpZXMgZm9yIHRoaW5ncyBsaWtlIG51bS1oYXJ0cyBhbmQgbnVtLWly
cXMsIHdoaWNoIGhhdmUNCj4gYXJjaGl0ZWN0dXJhbCB1cHBlciBsaW1pdHMuDQo+IA0KPiBDdXJy
ZW50bHkgdGhlc2UgYXJlIGNoZWNrZWQgaW4gcmlzY3ZfYXBsaWNfY3JlYXRlKCksIGJ5IGFzc2Vy
dCgpLg0KPiBRT00gZGV2aWNlcyBzaG91bGQgY2hlY2sgdGhpcyBraW5kIG9mIHRoaW5nIGluIHRo
ZWlyIHJlYWxpemUgbWV0aG9kLA0KPiBhbmQgZmFpbCByZWFsaXplIGZvciBvdXQgb2YgcmFuZ2Ug
dmFsdWVzICh3aGljaCBpbiB0aGlzIGNhc2Ugd2lsbA0KPiBjYXVzZSByaXNjdl9hcGxpY19jcmVh
dGUoKSB0byBtYWtlIFFFTVUgZXhpdCB3aXRoIGFuIGVycm9yLCBzaW5jZSBpdA0KPiB1c2VzICZl
cnJvcl9mYXRhbCkuwqAgVGhpcyBpc24ndCBhIHByb2JsZW0gY3VycmVudGx5IGFzIG5vIFNvQyBj
cmVhdGVzDQo+IGFuZCBjb25maWd1cmVzIHRoZSBUWVBFX1JJU0NWX0FQTElDIGRldmljZSBpdHNl
bGYsIGJ1dCBpdCBhdm9pZHMgb25lDQo+IGZvciB0aGUgZnV0dXJlLg0KPiANCj4gTW92ZSB0aGUg
Y2hlY2tzIHRvIHRoZSByZWFsaXplIG1ldGhvZC4gVGhpcyByZXF1aXJlcyBzbGlnaHQNCj4gYWRq
dXN0bWVudHMgaW4gc29tZSBjYXNlcyBiZWNhdXNlOg0KPiDCoCogcHJvcGVydHkgbnVtLWlycXMg
aXMgc2V0IHRvIG51bV9zb3VyY2VzICsgMQ0KPiDCoCogcHJvcGVydHkgaXByaW8tbWFzayBpcyBz
ZXQgdG8gKDFVIDw8IGlwcmlvX2JpdHMpIC0gMQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0t
LQ0KPiBJIG5vdGljZWQgdGhpcyBiZWNhdXNlIENvdmVyaXR5IGNvbXBsYWlucyBhYm91dCBwb3Nz
aWJsZSBvdmVyZmxvdyBpbg0KPiB2YXJpb3VzIHBsYWNlcyB0aGF0IGUuZy7CoCBtdWx0aXBseQ0K
PiDCoCBhcGxpYy0+bnVtX2hhcnRzICogQVBMSUNfSURDX1NJWkUNCj4gVGhhdCBjYW4ndCBvdmVy
ZmxvdyB0aGUgMzJ4MzIgbXVsdGlwbHkgYmVjYXVzZSBvZiB0aGUgbGltaXQgb24NCj4gbnVtX2hh
cnRzLiBNb3ZpbmcgdGhlIGVycm9yIGNoZWNrcyB3b24ndCBtYWtlIENvdmVyaXR5IGFueQ0KPiBi
ZXR0ZXIgYWJsZSB0byBmaWd1cmUgb3V0IHRoZSBtYXhpbXVtIHJhbmdlIG9uIG51bV9oYXJ0cyBl
dGMsDQo+IHRob3VnaCwgc28gSSBoYXZlIG1hcmtlZCBDSUQgMTQ4NzEwNSwgMTQ4NzExMywgMTQ4
NzE4NSwgMTQ4NzIwOA0KPiBhcyBmYWxzZSBwb3NpdGl2ZXMuDQo+IA0KPiBOQiB0aGF0IEkgaGF2
ZSBhc3N1bWVkIHRoYXQgdGhlIGV4aXN0aW5nIGNvZGUgaXMgY29ycmVjdCBpbg0KPiBhc3NlcnRp
bmcgIm11c3QgYmUgPCBBUExJQ19NQVhfU09VUkNFIiBiZWZvcmUgYWRkaW5nIDEsIHdoaWNoIGlz
DQo+IHdoeSB0aGUgImFzc2VydChudW1fc291cmNlcyA8IEFQTElDX01BWF9TT1VSQ0UpIiBiZWNv
bWVzIGEgY2hlY2sNCj4gb24gbnVtX2lycXMgPiBBUExJQ19NQVhfU09VUkNFIGFuZCBsb29rcyBv
ZGRseSBkaWZmZXJlbnQNCj4gZnJvbSB0aGUgbnVtX2hhcnRzIGNoZWNrLg0KPiANCj4gQ2F2ZWF0
OiB0ZXN0ZWQgd2l0aCAnbWFrZSBjaGVjaycgYW5kICdtYWtlIGNoZWNrLWZ1bmN0aW9uYWwnIG9u
bHkuDQo+IC0tLQ0KPiDCoGh3L2ludGMvcmlzY3ZfYXBsaWMuYyB8IDMyICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9yaXNjdl9hcGxpYy5j
IGIvaHcvaW50Yy9yaXNjdl9hcGxpYy5jDQo+IGluZGV4IDAzYTA4NTJiOGI4Li5iMjlhMjJhNDU1
YSAxMDA2NDQNCj4gLS0tIGEvaHcvaW50Yy9yaXNjdl9hcGxpYy5jDQo+ICsrKyBiL2h3L2ludGMv
cmlzY3ZfYXBsaWMuYw0KPiBAQCAtOTU0LDYgKzk1NCwzMiBAQCBzdGF0aWMgdm9pZCByaXNjdl9h
cGxpY19yZWFsaXplKERldmljZVN0YXRlDQo+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gwqDCoMKg
wqAgdWludDMyX3QgaTsNCj4gwqDCoMKgwqAgUklTQ1ZBUExJQ1N0YXRlICphcGxpYyA9IFJJU0NW
X0FQTElDKGRldik7DQo+IMKgDQo+ICvCoMKgwqAgaWYgKGFwbGljLT5udW1faGFydHMgPj0gQVBM
SUNfTUFYX0lEQykgew0KPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAibnVtLWhh
cnRzIG11c3QgYmUgbGVzcyB0aGFuICVkIiwNCj4gKGludClBUExJQ19NQVhfSURDKTsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybjsNCj4gK8KgwqDCoCB9DQo+ICvCoMKgwqAgaWYgKChBUExJQ19J
RENfQkFTRSArIChhcGxpYy0+bnVtX2hhcnRzICogQVBMSUNfSURDX1NJWkUpKSA+DQo+ICvCoMKg
wqDCoMKgwqDCoCBhcGxpYy0+YXBlcnR1cmVfc2l6ZSkgew0KPiArwqDCoMKgwqDCoMKgwqAgZXJy
b3Jfc2V0ZyhlcnJwLCAiYXBlcnR1cmUtc2l6ZSAweCV4IHRvbyBzbWFsbCBmb3IgbnVtLWhhcnRz
DQo+ICVkIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcGxpYy0+
YXBlcnR1cmVfc2l6ZSwgYXBsaWMtPm51bV9oYXJ0cyk7DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm47DQo+ICvCoMKgwqAgfQ0KPiArwqDCoMKgIGlmIChhcGxpYy0+bnVtX2lycXMgPiBBUExJQ19N
QVhfU09VUkNFKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJudW0taXJx
cyBtdXN0IGJlIGxlc3MgdGhhbiBvciBlcXVhbCB0bw0KPiAlZCIsDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVBMSUNfTUFYX1NPVVJDRSk7DQo+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm47DQo+ICvCoMKgwqAgfQ0KPiArwqDCoMKgIGlmICghaXNfcG93ZXJfb2ZfMihh
cGxpYy0+aXByaW9fbWFzayArIDEpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVy
cnAsICJpcHJpby1tYXNrIG11c3QgaGF2ZSBhbGwgbG93ZXIgYml0cyBzZXQiKTsNCj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4gK8KgwqDCoCB9DQo+ICvCoMKgwqAgaWYgKGFwbGljLT5pcHJp
b19tYXNrIDwgKCgxVSA8PCBBUExJQ19NSU5fSVBSSU9fQklUUykgLSAxKSB8fA0KPiArwqDCoMKg
wqDCoMKgwqAgYXBsaWMtPmlwcmlvX21hc2sgPiAoKDFVIDw8IEFQTElDX01BWF9JUFJJT19CSVRT
KSAtIDEpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJpcHJpby1tYXNr
IG11c3Qgc3BlY2lmeSBiZXR3ZWVuICVkIGFuZCAlZA0KPiBiaXRzIG9mICINCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicHJpb3JpdHkiLCBBUExJQ19NSU5fSVBSSU9f
QklUUywNCj4gQVBMSUNfTUFYX0lQUklPX0JJVFMpOw0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
Ow0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCBpZiAocmlzY3ZfdXNlX2VtdWxhdGVkX2Fw
bGljKGFwbGljLT5tc2ltb2RlKSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIC8qIENyZWF0ZSBvdXRw
dXQgSVJRIGxpbmVzIGZvciBub24tTVNJIG1vZGUgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IWFwbGljLT5tc2ltb2RlKSB7DQo+IEBAIC0xMTE5LDEyICsxMTQ1LDYgQEAgRGV2aWNlU3RhdGUg
KnJpc2N2X2FwbGljX2NyZWF0ZShNZW1vcnlSZWdpb24NCj4gKmNvbnRhaW5lciwNCj4gwqDCoMKg
wqAgRGV2aWNlU3RhdGUgKmRldiA9IHFkZXZfbmV3KFRZUEVfUklTQ1ZfQVBMSUMpOw0KPiDCoMKg
wqDCoCB1aW50MzJfdCBpOw0KPiDCoA0KPiAtwqDCoMKgIGFzc2VydChudW1faGFydHMgPCBBUExJ
Q19NQVhfSURDKTsNCj4gLcKgwqDCoCBhc3NlcnQoKEFQTElDX0lEQ19CQVNFICsgKG51bV9oYXJ0
cyAqIEFQTElDX0lEQ19TSVpFKSkgPD0gc2l6ZSk7DQo+IC3CoMKgwqAgYXNzZXJ0KG51bV9zb3Vy
Y2VzIDwgQVBMSUNfTUFYX1NPVVJDRSk7DQo+IC3CoMKgwqAgYXNzZXJ0KEFQTElDX01JTl9JUFJJ
T19CSVRTIDw9IGlwcmlvX2JpdHMpOw0KPiAtwqDCoMKgIGFzc2VydChpcHJpb19iaXRzIDw9IEFQ
TElDX01BWF9JUFJJT19CSVRTKTsNCj4gLQ0KPiDCoMKgwqDCoCBxZGV2X3Byb3Bfc2V0X3VpbnQz
MihkZXYsICJhcGVydHVyZS1zaXplIiwgc2l6ZSk7DQo+IMKgwqDCoMKgIHFkZXZfcHJvcF9zZXRf
dWludDMyKGRldiwgImhhcnRpZC1iYXNlIiwgaGFydGlkX2Jhc2UpOw0KPiDCoMKgwqDCoCBxZGV2
X3Byb3Bfc2V0X3VpbnQzMihkZXYsICJudW0taGFydHMiLCBudW1faGFydHMpOw0K

