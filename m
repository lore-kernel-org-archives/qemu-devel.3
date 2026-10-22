Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63615606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=D/cHtxj/;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=pEXBKn33
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJko7-0004V7-Nf; Thu, 22 Oct 2026 00:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJko5-0004UJ-KO; Thu, 22 Oct 2026 00:53:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJko3-0001ok-2y; Thu, 22 Oct 2026 00:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792644815; x=1824180815;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NgvkemfdJ6jMfkPPAlLgJaR+hAB6eYUmPuebz5HeXxo=;
 b=D/cHtxj/YcrLuAI5YpvOIVTOT+ViYJKYf91DRvbbXyCOPTkrSPDx01WS
 4VnSi6dtVxBvinq5co0okdjGldL1m6YV847AF7KPb7BkprTFo+33sdhG1
 kgcoacRv6+MWmDPC9vs3Yr3THCXC4+lWeEoXoqVAZYtxLJmJYmJp9JdNM
 sScwvbbbBM0CBX+0LVK+buh9vj5jWBp1NusnT7/8BJJpaCRSVPwn+Tp9C
 TpdTuqgCk2ql+hPbz3Acjj51p2SYi3hpgSBb690lBeCtlNq7or11QyO4G
 shh0Erb8H1qRl31fZtDvCVanv1Csi5WxsUrLQDDKJLBeYYlwkeH6Ytn2m g==;
X-CSE-ConnectionGUID: YkAwgN81ROGXZ9QnbyG6Mg==
X-CSE-MsgGUID: MNHIwQpTTO6wnNCi5hNrVg==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="154482123"
Received: from mail-westus2azon11010012.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 12:53:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyXEgwcpZp3Yc/W5cw1AHiK0fE96RsinDIuWrFS5DXCWxTeM7LjyAjH9lSgzdtJo2tykq0RRp9IZPOgyYFtRQ4KQs0oygLQ4yNjgOxupcneif+3FMJFJUZL8p4942OMTaNzvna48w6VeD60er+SuWxuKpXakTmn+zeNTRVAl7WnxZsAZuvlIg0iW4vuad9bnUIne0g9Zegy30st1LWKDwLEfclEtVH2mAkcoOekQaVCT+nuTR6/U9wDelKqjcg6nG7x+u/NcStKH3BNz8yqAEwqCbMovnllFnF6MuVzHom3EIIg5QYGpS3PKtzTzsZjVJV0cl72yShT9JE8AKDkX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgvkemfdJ6jMfkPPAlLgJaR+hAB6eYUmPuebz5HeXxo=;
 b=fUM4duz5DhGPjQyAYoa9kcA9b0sADK7laQpfJFOpAw/4iqMyqWrr0CHm/owCI8bFr5Yk1Fck65HNNsLkO9NZ+63u+eA1Xjepeyim01NAxB5eo171ptxBSkF0q6fzccGj1AtVWYLICGRcYYJSiAEvqcVHevh9lJw7/sv7vMGB/R5uCI2aMcHr2IFOw9femUtH/L2T7ksZ2Vk8asIeDfozvtNINQbORA25byHHWW447pIFayFZFxVIXgCkn5PiEOwyz8Z1wOJSEroWZJzKt9QDS+N8ywdOGW6clAWxePAkKzZr9tocDpB5jQBDJvRP/dEoS1seBmT6hDACe+Ja+9u4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgvkemfdJ6jMfkPPAlLgJaR+hAB6eYUmPuebz5HeXxo=;
 b=pEXBKn33GdpxTnfkhEmnC7SQrqjDgeZ32ep6HHbsRu9w3KlYUL6g/OILuVwEAsjj/pKtlGutz1ukDb/OEGQDgYe/Bx6pdkrqupIx6ClTH7KOCEFqEb8r7GIyr9Hurc1s1+AwnZb6jRvfZHBS8dDqc1A7pJQ2BmqjztQf1JSFFVU=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA0PR04MB7209.namprd04.prod.outlook.com (2603:10b6:806:e8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:53:29 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:53:29 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "sunilvl@oss.qualcomm.com"
 <sunilvl@oss.qualcomm.com>
CC: "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "shankar.c@oss.qualcomm.com"
 <shankar.c@oss.qualcomm.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "anisinha@redhat.com"
 <anisinha@redhat.com>, "prajwal.n@oss.qualcomm.com"
 <prajwal.n@oss.qualcomm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "fustini@kernel.org" <fustini@kernel.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Thread-Topic: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Thread-Index: AQHdXHGe0JoR77z4oE68l74n64s/PrcJCamA
Date: Thu, 22 Oct 2026 04:53:29 +0000
Message-ID: <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
In-Reply-To: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA0PR04MB7209:EE_
x-ms-office365-filtering-correlation-id: de2b71f1-7d2b-42f7-c0a6-08df2ff86a5e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|7416014|1800799024|23010399003|19092799006|261009223027099003|261021123027099003|38070700021|56012099006|11063799006|261021133027099003|10067099003|261021130227099003|22082099003|18002099003|6133799003|261021135927099003|3023799007|261021121427099003;
x-microsoft-antispam-message-info: p7/AoMbuAWm27zOk2a4hs5CQ3tEos/62GgF8CL1jWMKKHjzvAV/05mBulr1cq4M2HOIkCacbukOKlscFvc/mpHwm68LEheFLeuf9tr9kiyUc14J/GWT9OnXEP2hODLU8BuGo6DIHzYNWrAziil8zxItvkYFdwZgunNsI4GKoFT7roODUAIbkTFko2onKWcgztxb6ebshBClM2WjVdEECTPaQofqQUHvk1OAb+EsjnOQgIwHGNm4nbxTS7wTn25FPAGcNBsE6mA4jiU1cOhrCrmIkOZ/lMcuCCR7QBdQr+iKrjMsJyfvNW+reecDlm4N5R61g1/sjqM4uD40b3tjR9rxek0pW7YMO2vUYEH+m+iLxsEqpuklNclUznOWWU01YBHswEs5cNAQaAXiGFNRCWoTrmCj8IvFdMle/voI/M6iq0BDD7APr8Gwk36te6Jm77LM32aKT7ffFITG9FMK9e7dlquGi4rHUQbQse4L3z7elZQitAXYHhepsly3vs3WAgwjxTZndMS4gNiGXWpmx7qMni3+UnXemwHh3/TQx6uBHPARm84aX3ZeGkyDo4KJ3TlxAlJvXaDOHqowT7OBveTyjNmrP2ZwKTExz78pXAfyjf+gfzRide0wtkx9OQvzJODNOkUFn+0p81BGjrX5tqIwEGr3LBcpzyln+Bv6YXLJqY4oCH1Y4OKgylb0tTkN5Bc7pxeYq4x+vRsYlFm3GndF1JABL8LzyzgFVxuViwzA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(261009223027099003)(261021123027099003)(38070700021)(56012099006)(11063799006)(261021133027099003)(10067099003)(261021130227099003)(22082099003)(18002099003)(6133799003)(261021135927099003)(3023799007)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGQ5Tk5IaDNFbWtsR2tCNVZZR05mbW1tWHZuNEszSTc1aXJPbkZERjlybnNY?=
 =?utf-8?B?eWNtcHhBNE1UdnFra3grUHFkNFhvRGZBQ0ZJcWtEdUlIQ0M0ZmtTY2RsOUtz?=
 =?utf-8?B?UTYyTjR0WWFrZzFhbjRJZVVOanZUVWhEZTdKNE1pMVFNMFNZQXc4YTd6Qjlk?=
 =?utf-8?B?Tnp6SkZzZjhORzQ0bmpEUzl6dVFLVERlQ2ZjUTI0aE9VT1JjNmRVUjdaQVkx?=
 =?utf-8?B?RzhRbUdwQy9jYllUUk1vdGFnQ0I3ZmdZZkdXYXYxaXVLSnhnUWhaU2tTZSs0?=
 =?utf-8?B?cDU4c0JVZE9ISmtOaGdlcFE5WHBPUTVpSHh4Z2Yxd2ZtMk94MHFwc0JBZWRO?=
 =?utf-8?B?UE9EejhYL1RZdXI4a2lENzVWYXJnZmJHYVdEMDQ2N1NTakZlQWpYeXNMNnpt?=
 =?utf-8?B?d0lOR2JVaGFuQmtzUzhJUFRocEJKQk51M3FpdUpveHNsWkY5dFBLVndzNkJM?=
 =?utf-8?B?dlF2UE15WDB2Mm5BejZsU05NMUExSlJrK1IvblhvUmJSNDVzaWlrUW15Mno1?=
 =?utf-8?B?b0d0NER0Nks3anIzYlA4OEIwTG5uaHNtaFhlSXIzdmpueWlQS0lOYTc5VGEv?=
 =?utf-8?B?dW1iR3VOWXFiMVZ5VE50RVJiTEszV05ldG43NTlBS1NGUVNRRTZOVkJXMVIw?=
 =?utf-8?B?YldVSHdlWW9FbS8rUzNvOHRPTnp1TmZwTDRRRlBGZ3ZrQXlEeHYwNldkVjAv?=
 =?utf-8?B?RWREZm5sMFQ3c0ZGM3VhK3orTlkvZXJ1dzZ5TVpjeVpiaW5TMml2aFJZa3RW?=
 =?utf-8?B?c1AyN04zMWVscDE5QUJUc1dKMVJkMnBYYm1INGRZNllDZ01SSHJydjBsMXpT?=
 =?utf-8?B?MEltUkFJZUJ0WVZFUFNoTVRyTTZzUWhib0FJeTQ3KzExYVBSSllXZ2dLbjBl?=
 =?utf-8?B?RHJjMWNSUDJxQWxEc1o5V3F3UjM3T1Zoa0wwd0l1N3N0cUF2UmNCZk95c1Nk?=
 =?utf-8?B?dUl4NkI3dU9BbVZ5ZHJra005UDZxRWtrQnpwUERTdjljVnB6UUZLZy85b1da?=
 =?utf-8?B?ZGdFV215Q2w5OTVBUFd0YnBZVUJaeXBkZGVxZmV4aTRQaGUwdmN5RkcwVGVr?=
 =?utf-8?B?c21HQXErVzZQUDlpNmlCTXNFbU1BRlJTRG1rVGpCbHhlMEdFcUxFbFczaUxo?=
 =?utf-8?B?OEhQeFJ3ZFRoMlozR1BRaEhUOXhuV3BvVU95OEp1dDA0M1RTZ2RyTjd6d3Vt?=
 =?utf-8?B?cUMrOVNwTmVHTElKUVNWSVZ2UWp6blZUbGcveSsxUXh1YVpuSTdtWXh1UjMz?=
 =?utf-8?B?Z3pFVDh5bUJDalphRnR6Y2dUbTlvdWppN2lvdFNZcXcyRnRVdzJYellZRTRx?=
 =?utf-8?B?eDZ6Y004RitkNksyKzB1eU43ajVRa3B6bjZsdmVxNWxVaS9uUXc1YU4rdmxm?=
 =?utf-8?B?Y0VPZ1pVU3BmMjY2Vm16SE8vMHhkcFp3OFljR1M3am91UHEwV1BPQlhIMTA3?=
 =?utf-8?B?QlM1bGdBR3VzZDN3ODRlTkowWXJsYTJZaDNvQS9mbXhIZjlLa2JxY2tQcWk1?=
 =?utf-8?B?L2VsaCtJZysvc0IwNzl6TG1Vbk41dmdSQVUvUktBREduWGlIMXBQb3Q5RWF0?=
 =?utf-8?B?TzlQaEdrWCtmRkM3enVvOUE5SmUySGJnNXdxUGJ3YnFMbWsvNm1TM09aQ3I0?=
 =?utf-8?B?SGFmK3B3QkN5TXltZ0VpZXNtRHFxaFhxTmRhTWl6VWZITjNiYWV0NGtUR0Fr?=
 =?utf-8?B?U0FwQXpxa01MK1hjaUhsMVpqNloyZVV2b2tDY1NzVlpzdklWWlZVdFUrVlpN?=
 =?utf-8?B?dzF6V2dzN3daK3hQUVBkcWRkV3hacHBFUWUzODJnRUZxTGZUcEVkSFFKVngw?=
 =?utf-8?B?ZzNxMHpzMzhnWmZxdzdEc3Jjb3lweFhwdWdPWU5iRVVEcUlsb2I4enhkMzhv?=
 =?utf-8?B?R1R5MXZjaTJsWHZCUGI2VnVPT09YWVZvNG9ITGNNS2JTNS9WS1M5QW1NZnJz?=
 =?utf-8?B?ODlPenZ1Vy9qYlRJQk5ScU5ab0kwY2xBVFVOelNGT2pwOGZjN3NiQlpPais3?=
 =?utf-8?B?SXR1WVFwQUp3aURvSFQ2VHhJNWFwQWpIMWVSdCtjMjIzLzVacE5GaUdkUWRO?=
 =?utf-8?B?S3BqNkhtUGNMOXNCMUxxNFdnTEl3ZERFZWpQLzhjTGZnRXRpYUdQUWIxd2o1?=
 =?utf-8?B?S3ZjQlQxK3BaSmpoYVRpTWh1MjY0azJBb3IwZTFMMjh2Q3VxeE9mdW5RRndh?=
 =?utf-8?B?SjBkTWgrWFY1Nzc4Sm02S1RBS3FwTkVNWFJrNHBwUHNqMU1LL2ZpMWlpRUtD?=
 =?utf-8?B?L2ZwcUJIY2w4aHNCcTltekdVVWx2VkdZbUpNRGlLelNCakFVdEpvbG1iR0Yv?=
 =?utf-8?B?TW1JS2ZZOFVzSFN2a2hZQ1Azb04ySTR4aUc0UHhDSS9QNEV2Qnl5QVQzZWV2?=
 =?utf-8?Q?bwIGctiCQuvlr51iT3qmSvbcbCVa3jt3VYH/oRMJKk2s0?=
x-ms-exchange-antispam-messagedata-1: 6E0TQt4suswnwAT6auENrHsmwJzCMMyS/B4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73C7703A28F83041BA7325A633AB90E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gVcgncjOX33cqn6CbPglNllUM6/UxudO/po0RzHuZO0ArDt3N9RYSs+LYZZuZ7APPgtRGfCRdnQg2xK2VbKCjjQjpW4Zjw5iTugunmNvrn5AVNDTFnRoypJnMofYpjBzbdYpPBO7jGK4GApz1/3AeUkBfQA2fJFbAql/FJ751wAtggnyi7ysNshX5ChCzhScQ1PIh+cgzaJnrjYq8XDa2zUugEm7aZ/levG5mMudI8++b99Z/h/FX5zURN2tiZWQMyyHm5qVz3mmUHHW9XGQ1mxoRzfIFJiXYtC1c6OQn7v/IycgggpoAv8fTzUHx8D4y5Hl7zVCxjj4ocx2Qh3C9g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ifZLLGgOk5mwBMAZBioPjh/xzckZ9+hX3w3GtYoKibtNa3S4OhBYmG9KcQdCRfU3EdDXNAWPH5h370Qa+4sAtlvrbFy0tNqUpr/i+ol9QoQwB0tYWx8pVVzuqi86tVUXelZCthsT5Z3aNcKfINFsyV0QsIw+Ju/klvxuhOHiqPU0aJ5yNPe4ULVcHrnoj2VshbiU1NKCh+6u4LpFo0exLLRtSy5S8wg82Jyh6sI+ezGBBio8YmhDDujR125QQzhJveqUOfOcH87Fq6rrI5+fZWHbMI1HaH8EHdHQGc3Dnd2gJ8xzULhKUSvzLbCCAzB+XxChFIwOYfe6VU1jBhI14rPv8qUeYqv4+faA1W+Sk+eL6N9kRZncHhJ2KNp0m8Ea1QEzt4Wdh/1aAusmHXU1/JkxVIAGZivHwDTdGiIJnYYIL4rlsfCjVV5osaMCs4ZUCkjRp+xvLAueJ0j6Oa1Z3dcYNQIdm8EpN7Pv6141LjbfIdU1p6cHbfSYxoxzRxnJGzcpG2IWU59n2OghW4uCZ96inea4J7FE/n7dxmwGQRHq3om6DXIX8kZMUf/kayUTHRTlfFGqB3+Bp1cjbTTBSHmRzQ2h6qrXCIwWzW86LtFnkKn9P3EtS1FdpnFIoFbe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2b71f1-7d2b-42f7-c0a6-08df2ff86a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 04:53:29.2316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSHUfG+i22o3uDv/tTisAw4CmadMDr7klr5wI/X8Qe5s4h3lRB4XIo8PqqFwjRLQa3G3YOfAxgDbR76ELr4hyn1mKbjTCBy/l8zx0wAuTRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7209
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDEyOjE5ICswNTMwLCBTdW5pbCBWIEwgd3JvdGU6DQo+IEhp
IGFsbCwNCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMgQUNQSSBQcm9jZXNzb3IgUHJvcGVydGllcyBU
b3BvbG9neSBUYWJsZSAoUFBUVCkNCj4gc3VwcG9ydCB0bw0KPiB0aGUgUklTQy1WIHZpcnQgbWFj
aGluZS4gUFBUVCBhbGxvd3MgdGhlIGd1ZXN0IHRvIGRpc2NvdmVyIHRoZQ0KPiBwcm9jZXNzb3Ig
YW5kDQo+IGNhY2hlIHRvcG9sb2d5IGV4cG9zZWQgYnkgdGhlIG1hY2hpbmUsIHdoaWNoIGlzIHVz
ZWZ1bCBmb3IgbWFraW5nDQo+IGJldHRlcg0KPiBzY2hlZHVsaW5nIGFuZCBjYWNoZS1tYW5hZ2Vt
ZW50IGRlY2lzaW9ucy4NCj4gDQo+IFRoZSBpbXBsZW1lbnRhdGlvbiBkZXNjcmliZXMgdGhlIFJJ
U0MtViB2aXJ0IGNhY2hlIGhpZXJhcmNoeSB3aXRoDQo+IHNlcGFyYXRlDQo+IEwxIGluc3RydWN0
aW9uIGFuZCBkYXRhIGNhY2hlcywgZm9sbG93ZWQgYnkgdW5pZmllZCBMMiBhbmQgTDMgY2FjaGVz
Lg0KPiBJdCBhbHNvDQo+IGVuYWJsZXMgdGhlIGNvcnJlc3BvbmRpbmcgY2FjaGUgYW5kIGNsdXN0
ZXIgcHJvcGVydGllcyBpbiB0aGUgbWFjaGluZQ0KPiBTTVANCj4gZGVzY3JpcHRpb24gYW5kIHdp
cmVzIHRoZSBnZW5lcmF0ZWQgUFBUVCBpbnRvIHRoZSBleGlzdGluZyBBQ1BJIHRhYmxlDQo+IGJ1
aWxkLg0KPiANCj4gVW5saWtlIEFSTSwgUklTQy1WIGRvZXNuJ3QgaGF2ZSBhIHdheSB0byBkaXNj
b3ZlciB0aGUgQ2FjaGUNCj4gdG9wb2xvZ3kgZnJvbSByZWdpc3RlcnMuIEhlbmNlLCBJIGFtIGhh
cmRjb2RpbmcgZGVmYXVsdCB2YWx1ZXMgZm9yDQo+IHRoZQ0KPiBjYWNoZSB0b3BvbG9neSBzdHJ1
Y3R1cmVzLiBUaGVzZSBjYWNoZSB0b3BvbG9neSBzdHJ1Y3R1cmVzIGFyZSBhZGRlZA0KPiBpbg0K
PiB2aXJ0LmMgaXRzZWxmIHNvIHRoYXQgYSBmdXR1cmUgc2VyaWVzIGNhbiBhZGQgc3VwcG9ydCBm
b3IgRFQgYXMgd2VsbC4NCj4gSW4NCj4gZnV0dXJlLCBpdCBjYW4gYmUgZW5oYW5jZWQgdG8gc3Vw
cG9ydCB2ZW5kb3IgY3B1L3NvYyBzcGVjaWZpYyBjYWNoZQ0KPiBpbmZvcm1hdGlvbiB0byBvdmVy
cmlkZSB0aGlzIGRlZmF1bHQgaGFyZGNvZGVkIGNhY2hlIGRldGFpbHMuDQoNCldoeSBub3QgYWRk
IGEgdmVuZG9yIGNwdS9zb2Mgc3BlY2lmaWMgb25lIHRvIGEgdmVuZG9yIGJvYXJkPyBUaGF0IHdh
eQ0KaXQgYWN0dWFsbHkgbW9kZWwgaGFyZHdhcmUgaW5zdGVhZCBvZiBqdXN0IHByb3ZpZGluZyB0
aGUgZ3Vlc3Qgc29tZQ0KbWFkZSB1cCBpbmZvcm1hdGlvbi4NCg0KSSBmZWVsIGxpa2UgeW91IHNo
b3VsZCBkZXNjcmliZSB3aHkgd2Ugd2FudCB0aGlzIHNvbWV3aGVyZSBpbiB0aGUNCnNlcmllcw0K
DQo+IA0KPiBUaGUgc2VyaWVzIGFsc28gdXBkYXRlcyB0aGUgYmlvcy10YWJsZXMtdGVzdCBkYXRh
IGFuZCByZW1vdmVzIHRoZQ0KPiB0ZW1wb3JhcnkNCj4gUFBUVCBlbnRyeSBmcm9tIHRoZSBhbGxv
d2VkLWRpZmYgbGlzdC4gVGhlIGdlbmVyYXRlZCB0YWJsZSBpcyA5Ng0KPiBieXRlcyBhbmQNCj4g
ZGVzY3JpYmVzIHRoZSBwYWNrYWdlLCBjbHVzdGVyLCBhbmQgcHJvY2Vzc29yIGhpZXJhcmNoeSBm
b3IgdGhlIHZpcnQNCj4gbWFjaGluZS4NCj4gDQo+IFRoaXMgd29yayBmb2xsb3dzIHRoZSBkaXNj
dXNzaW9uIGFuZCBlYXJsaWVyIHdvcmsgc2hhcmVkIGhlcmU6DQo+IGh0dHBzOi8vbGlzdHMuZ251
Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1yaXNjdi8yMDI0LTAxL21zZzAwOTI4Lmh0bWwNCj4gDQo+
IEkgaGF2ZSByZXRhaW5lZCB0aGUgY29udHJpYnV0aW9uIGZyb20gU2lhIEplZSBIZW5nIGFuZCBh
ZGRlZCBoaXMNCj4gU2lnbmVkLW9mZi1ieSB0YWcgdG8gdGhlIHJlbGV2YW50IHBhdGNoLg0KPiAN
Cj4gVG8gZW5hYmxlIGNhY2hlIHN0cnVjdHVyZXMgaW4gdGhlIFBQVFQsIG9uZSBzaG91bGQgdXNl
IHNpbWlsYXIgdG8NCj4gYmVsb3cNCj4gY29tbWFuZCBsaW5lIG9wdGlvbi4NCj4gDQo+IC1NIHZp
cnQsc21wLWNhY2hlLjAuY2FjaGU9bDFkLHNtcC1jYWNoZS4wLnRvcG9sb2d5PWNvcmUsc21wLQ0K
PiBjYWNoZS4xLmNhY2hlPWwxaSxzbXAtY2FjaGUuMS50b3BvbG9neT1jb3JlLHNtcC1jYWNoZS4y
LmNhY2hlPWwyLHNtcC0NCj4gY2FjaGUuMi50b3BvbG9neT1jbHVzdGVyLHNtcC1jYWNoZS4zLmNh
Y2hlPWwzLHNtcC0NCj4gY2FjaGUuMy50b3BvbG9neT1zb2NrZXQNCg0KT2J2aW91c2x5IDpQDQoN
CkxldCdzIGF0IGxlYXN0IGFkZCB0aGlzIHRvIHRoZSB2aXJ0IG1hY2hpbmUgZG9jcyBzbyBpdCdz
IHVzZWZ1bCBmb3INCnNvbWVvbmUuDQoNCkFsaXN0YWlyDQoNCj4gDQo+IGxzY3B1IC1DIGluIGxp
bnV4IGNhbiBiZSB1c2VkIHRvIGRpc3BsYXkgdGhlc2UgY2FjaGUgc3RydWN0dXJlcy4NCj4gDQo+
IENoYW5nZXMgZnJvbSB2MToNCj4gCTEpIFJlcGxhY2VkIGxvb3Agd2l0aCBtZW1jcHkNCj4gCTIp
IE1hZGUgdmlydF9jYWNoZXMgc3RhdGljIGluIHZpcnQuYw0KPiAJMykgQWRkZWQgRGFuaWVsJ3Mg
UkIgdGFncw0KPiANCj4gU3VuaWwgViBMICg0KToNCj4gDQo+IFN1bmlsIFYgTCAoNCk6DQo+IMKg
IHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3Q6IEFsbG93IFBQVFQgZm9yIFJJU0MtVg0KPiDC
oCBody9yaXNjdi92aXJ0OiBBZGQgQUNQSSBQUFRUIHRhYmxlDQo+IMKgIHRlc3RzL3F0ZXN0L2Jp
b3MtdGFibGVzLXRlc3Q6IFVwZGF0ZSByaXNjdjY0IHZpcnQgUFBUVCBnb2xkZW4NCj4gwqDCoMKg
IHJlZmVyZW5jZQ0KPiDCoCBNQUlOVEFJTkVSUzogVXBkYXRlIFN1bmlsJ3MgZW1haWwgaWQNCj4g
DQo+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAyICstDQo+IMKgaHcvcmlzY3YvdmlydC1hY3BpLWJ1aWxkLmPCoMKgwqDCoMKg
wqDCoCB8wqDCoCA3ICsrKysNCj4gwqBody9yaXNjdi92aXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvdmlydC5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NCArKysNCj4gwqB0ZXN0cy9kYXRhL2FjcGkvcmlzY3Y2NC92aXJ0L1BQVFQgfCBCaW4gMCAtPiA5
NiBieXRlcw0KPiDCoDUgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9kYXRhL2FjcGkvcmlzY3Y2NC92aXJ0
L1BQVFQNCg==

