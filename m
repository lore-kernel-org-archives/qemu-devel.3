Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C816C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 04:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR2hW-0001bk-12; Tue, 09 Jul 2024 00:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR2hT-0001ag-OA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 00:43:35 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR2hQ-0006kE-Lw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 00:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720500212; x=1752036212;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8KKWaL/lXx2F+Qs5jQSKnPIeWde5v1ZjDr56jtWo+Js=;
 b=DQsMgsbrUCMZJEVl5Ye4ULJw77o6JWaqH+UxsLhTxD8QW4J4Lq3N+eP4
 4iNohHlBpNY2Gi4zDGWcuRErN/S37UrOptSnV7vNKsQCDQRD8PuvZPymI
 G4JxMyNiuHSKhaRIaWgkw5+NpGW3QQ2T3LHRqSGTPFS1V2RljdKLxgXO4
 6wo9sSOb4uanvWZLezi4vXVMSFJs8tlReRaoFbaKDoUYOxy4Qgtjeuz+d
 zIetw8gPuICDnWIB3Vtfk9xZWBWKVT63Ylz1knJ/2ttF9MnEv7P8UlP+H
 HUeEJBfqJvvgTKSQ+g0fyBvWIKbNSszFc4gJ/wP7dLdhiVL2iBNw7SecZ A==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16116868"
X-MGA-submission: =?us-ascii?q?MDE6C3fWVirVxze+KJkzWBSdJbU/Rsx4IsYWTH?=
 =?us-ascii?q?9ZmAxmLw1dSn1vICeioM7bnWN74uOziWd266OiIGYHw98fFabnZGfEMX?=
 =?us-ascii?q?/U/uqvSAG5+rKLXcqqBrsCLlM64ycsYBfpOvyn7IyOwieDEwc6bjPODn?=
 =?us-ascii?q?b+fIJZK+xq62wnk8BuxUl0qA=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 06:43:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+xCg0xSCAInb7p/bLarpkuK/ARHI/bc1vgIIu2QB1BjR2+AahyBCpiQLSN6dAAjobrYvv2JgKSr+LNXWbJMjLV8r82z7SXBZaSttuvkI3igbvOXFY1hpf4v5n/Nqh6ON2dJSY7PxzPAfYOA8NxctZwbqoLGS4sFQFUUFpR2ToTTMuQ+u3Pe1k2MoPxAgHuAjX2jPDEdYzL23lNkA8wBQ37DzdlNaZpVb6W3nnnXGNGL8S0vLh8Jl35bAr8PodS69zR/h4fOmfh7ODWOHwVHaUVPykKZnMmaeBnOASJ/9q+kgKjgUkFnwExOsFO13ruROg0I+4VGd+Xhnzjoq5HQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KKWaL/lXx2F+Qs5jQSKnPIeWde5v1ZjDr56jtWo+Js=;
 b=AkycHgH+sOJmvzOlzEnF2R82erD+kHycNnMj5+AYCgJfIQRVQ5MfdC9Q90ZPPm84JeAcjXrQRlDnLFM/084yF1On30UILYVuQ69P0nL8MDOgFAc2wn1HyWBWuuU49vAEUZORSVbrf70Oiux/ev6eOSNlk0GLEzLNZ7mvLZRp9ujTbINa4HT16Ns1o23rhEPSJh+CO6yNTUZajAY+EChDkKFXHA88kKsCI0eXoXxx5spam0L+h5QC1x4Ppz3UctUF55+WTgwTWCmL2MbGLf85vP77mltun2f37ucvUPThK58BaGXgj5WA3kLMtb5Gp4PO3Et6Y6piRlEpaDOsyCewEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KKWaL/lXx2F+Qs5jQSKnPIeWde5v1ZjDr56jtWo+Js=;
 b=LPYfuYY8R/9gdSqby43oZq3Man6XwZ01cOVBUstOYeCwRKAuRe6nb+U6XNiNGdZdQB+ywdCLrdJEU/moCRS6kBhyFrGuzcD7Am3UQCElQ85DR7J5RUg3t5/HBpFgS9iJwfKYch/zu5kCE+iTG80BkqWIAXTDQKByQG/XF3lqK9wOmM/oReX6nGO9l+dwFkFrsT+zXAq5aoVU0gCm0JYJH+Vcy2JmT4sNLjgQ644CJFM/DfX8hAhB63ZrZKN7+lRt70V9grqJ1voh5+BaNj+GGMwNijcF36ru9Jl4v3ERvoWLANaKlKQ+og06+tJ+0Bn281NslwKowYnN7V5LlZG73w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9734.eurprd07.prod.outlook.com (2603:10a6:102:391::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Tue, 9 Jul
 2024 04:43:26 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 04:43:25 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yuke Peng <pykfirst@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Block CFI when necessary
Thread-Topic: [PATCH v2] hw/i386/intel_iommu: Block CFI when necessary
Thread-Index: AQHa0R7hIKWDFTXnl0ClpzklvXdHEbHt0tOA
Date: Tue, 9 Jul 2024 04:43:25 +0000
Message-ID: <468ed4a0-14b1-4d0b-9537-9a550b14f0da@eviden.com>
References: <20240708100816.1916346-1-pykfirst@gmail.com>
In-Reply-To: <20240708100816.1916346-1-pykfirst@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9734:EE_
x-ms-office365-filtering-correlation-id: fb87d793-a71f-46a9-c37f-08dc9fd1abc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SC9QbEowZkt1ZFpUQzYvNEJFSldNd1N6UGVPUW15NUcyNjkwVU02bkIvaFhZ?=
 =?utf-8?B?UzlZUEdIWUFBTUJuN3VpSHpKVlNCdVBhUzFFU0JvREZLVnp5TUNtMkJ1U1M4?=
 =?utf-8?B?K2N3LzZ3ZVltWkxwSWt3QjFXVWNVVkNXU1MxU2w2cFc1amdua0ZXdS9XUWRF?=
 =?utf-8?B?OFNzWVZjNVh0bUYxT2NQblR5L01xWkNUdlFpT0NVSHFvOWpnTmZzVTNDOThK?=
 =?utf-8?B?RW1ReTdZb2RadTZhNUhxTDlLL3pXcEFrWm5DVkVJTmk4MkVnVSt0U0FINkZF?=
 =?utf-8?B?dkhMSlR2MXNnSzFxZVE0dlJEd25pTzZGTkZSMW9yRzdSY29XVGJheVRKTmRu?=
 =?utf-8?B?Umc4SFp6SnZvOERQQU5IVDBLYlRqOHp0bE92WGNXSGp3anZhSEJzN1poSXVH?=
 =?utf-8?B?OUxITlZzVmFPVXR0LzBRenBoNFY1TXJvV09oRjVzUlh1U0l1bVRRcHhsY1VY?=
 =?utf-8?B?c0c1dGJKRXZ4dEsxRG1lRUpqcFBzbWN4aWlUZmtUNTkyTk5RalI1V1VHa0RH?=
 =?utf-8?B?b2NvRURJT3YxaXl0ak1Hd0R0NHZKUFdqdGZCdXRRY1ZXMXd3eU1Ic0NFelpY?=
 =?utf-8?B?dFJaZjcvSDZXQUpzbklBMy9GRXUvdTd0Y05aR1YvaUdqR1hNQUdmZ2t6NXMr?=
 =?utf-8?B?bWJhM0c0RVF4ZUJEYVFtNVF2RXp6SHFVa1ZiNTBJNXVmT1czSVNWYVVSb3di?=
 =?utf-8?B?YStlZ0VSUnM2Y0RxWDM1clNTbnhJQVluZ0FMczE4U1YwbjVyOUdJVmpBSE8y?=
 =?utf-8?B?dXBmcCtPK090eDdleEVTY1FXeFE1bytaTERDVThhS2FNNzI3SWsxUHp6OUFC?=
 =?utf-8?B?S294ckdleG1iTlBITVRidTl4K1BHT05tWEhkcUsrNGJXb3NKSDZtTFkyZWlR?=
 =?utf-8?B?clJDTTI1QlNVeXhZZmduekEzRytndnE5NEl6K2tuSDJoTyt6RGpydG1PQ0Ev?=
 =?utf-8?B?RldGRG83UnVxeW1KZHcxT0tmMmx6d2R4SmhFMGduMFZYU3p0dytnWGJwQnBa?=
 =?utf-8?B?LzFjT2p0bjhCcjh5QzJKbkVoSjdVQmVQWGMwM2MvanNoRS9JL0FITFBvYzl0?=
 =?utf-8?B?Qnptck5HcWd1UDIyR09YZTFEVUNLVEVvbXlXOXlWd1BTZ0dFenJ1SEpHUEtT?=
 =?utf-8?B?RXlGYS8vU3E4Y0lSWnlGYSszUU0rRmhHeUJWOGtyNUJHaGE1WE5tUjZTV1JU?=
 =?utf-8?B?ZHNrVmxkaGtlTnBocVpDY3BpTzJPWHFTa0JGV2haODdzU3Z4S0hjdWVteDBD?=
 =?utf-8?B?cXVya2JMV2dxMlhpK0VKZSs1elloQ3ovSHYxd0NJVXA0WUVBYjlIcVlJZ21E?=
 =?utf-8?B?THR1OU9zVjM1eGRKUVhrNm5CajZHZmg3RVpHOU15WlZFdlNPeFpkN2dkQjUx?=
 =?utf-8?B?Y2wwY0RiVGtFTk5FRWowcU1heGV4Zk5tSXRYZnR4WWhJU2E2TDMwMlUzOGtz?=
 =?utf-8?B?NXV6a2R4ZjFpSVQvT0RDZ2E2aHViY2ZIZHZtdHF2Y01yU2hDa3drQnZIbjlh?=
 =?utf-8?B?MXZ4azNRTy92U2x2QWFQeVpWZWhSLzBtYUNtQmIwNXFNbmRRRWl6R2U5YVMx?=
 =?utf-8?B?cTBLZ2JMRGpBM0VjeFFOODBnSFpHSEJkTWFEd1lUem5wWVZPcGhrd0svVkhE?=
 =?utf-8?B?YkpiZy9mR2M0UWYyVGhMbEgwZ0xLYXIwQXp6TGJ3dGlFcEI5TzdiY0xFci8z?=
 =?utf-8?B?amNhSUtyY2MxN1ZnZ2kzUGZUb3JHaUp0RnFUOGhjQTNPUHc5VHdSMDlIdm9h?=
 =?utf-8?B?TFZWNi9ra0dsWHlBMmp5RlRVTmlyQm5hUytaY1VIQ1JUbEk0WFpDUmVtbzNo?=
 =?utf-8?Q?+Eo1DZN2kfyLni8k0AKrzsDTOLF30jSXXZufs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEt3eEJvbXg0SnBvcHQwamtRVjVsdjlETUJNOC9zdUdKMUI0d2NmVDdjN3A2?=
 =?utf-8?B?Q2szMzVkcGEwcU5PazM0Z05rVnZxb0I0REE5cGNWdDg5Q1c1SWw5N0ZDRWJW?=
 =?utf-8?B?K0U5Yy9tSGlUdjBYOWdZbDhmeWJXVGhtdkVEemp4U1ZrTms1TWlNS0RXRjRj?=
 =?utf-8?B?c1BiQjE1dlplYjRhT2kxYVI3ZlJGVXZDVmE3a0dnNjM4cWRuNFZJTWxJRzFx?=
 =?utf-8?B?VUk4TTVpL2xOd1diMjdsQTloZlZEeUNBTHNkTUxjL3dOOStGd2p0RXpJN05T?=
 =?utf-8?B?bEIzTDVST216UWJ4cjkyRTdWS1oraGFIZXpweXZMbXlLQVNiaEhSUkRvL0lV?=
 =?utf-8?B?SlkwNDcramNRdnBqWmFkRUFsblV0aW1KWTQvdm9zenlIY1orMVd3VUsweE9T?=
 =?utf-8?B?UGNrNzhVMzhrSktla0F0YU0wbldrTmFBaHJvc3o2TkZvTFBEajNwRk9aMjgr?=
 =?utf-8?B?VTlzWnVwaEhaR3pORk50NHNDSTA5Z2ljQUtVYkZEMlVqcXU5VzRTV2VPVElE?=
 =?utf-8?B?QXF3eDlEVitPYkFWaGRuZDBaUERudVRiTlc3TnF6b0xBcHcxWENPVkZxREoy?=
 =?utf-8?B?dFFvUUxRZk16NUdjc0tsQnQ1Nkd6cDF2VExTOVdFVGxCNkQ3eWpQOTRsTU9R?=
 =?utf-8?B?SE9rTGxEZXJ2czEydWFrMDZ1eUZ1WWdmWVcra25GNno4U0lNRWlNaXBtSFdN?=
 =?utf-8?B?aGUwTmZxMmtQSU1maWFyOUoyOXpKY3Z4YXlYL3VZVTM5UmZqSEROK0tQQ1Jv?=
 =?utf-8?B?WW10Y20wcytYUDBwVitYbVM3QUZGNWh6ZmtEYWNLWDRHYWVQNWRzaGRNTUNl?=
 =?utf-8?B?OGRLckNXc01XVFVCSEJMU0ZJRVlLeFB1ZnVPV3Njb1l2RTFUWVZaRExSYTBI?=
 =?utf-8?B?UUF1M2RLeFBaMHNIOGFIK0MxajNyUFViR0Z0ejdzTTEySEZyWHkxaHpodm1r?=
 =?utf-8?B?NWlVc3JjbzZzWk1FR0ROK2tDclB0VHdOTUJ5SGxVM3VQQU0xM3haYXdBRGxP?=
 =?utf-8?B?SGxSaHZ3RjIzK0FLaStjcXppRmsxMHdKUDZGWXEzUzVGZS9IVlVqZnNLTVN1?=
 =?utf-8?B?aWp0WW1BUjVIbWpQUkJ2UWxUSTB2NlpmWjRXdlhZYWM0VXNGdklJMWIvcmdm?=
 =?utf-8?B?ZnBqRnhSaEtvVmo5RklHNlk2aFBVWCt0Y1dBZjRYNjJvRTFGRXd2azdTdW9O?=
 =?utf-8?B?bXdZQXd6L0lsTmxzeTdXTWQrL0lpMFI2OU15R2hBSEtmWXdXdHdSNEc3V0hu?=
 =?utf-8?B?emZNRUhETVpHVVowYmRVaEx0VjM2Q1lqTndIZDdRVEErUUFFRG4xZHBuV2VX?=
 =?utf-8?B?K2k1NEFYQlVpbUFJazdSbVRMejVGMktBa3RyL2NDMjJSbGU5czhEWTdlbm5Y?=
 =?utf-8?B?YmlvajAwbmdxNUdHRUdDajRPNWxRdUdmekZMK3BsQ2NQL0JlcmtEcmczOHFV?=
 =?utf-8?B?a2FVK2x0QVZoVkFaRU5TWHk3S1psU0swRnhGcnlFNWFzTW0veGF1UkxZdno5?=
 =?utf-8?B?NjNUTzB3aks2R1R2QWN4MFZQcTVhV1RDQi9FckJIaTY0eWdxcUozY2J5S0xU?=
 =?utf-8?B?anpibWpWcDFWWXh6L3hoL0ZOcitkeTBQWkJxUlhzak82UkhLRU1ScHVoL2Y5?=
 =?utf-8?B?ZWpjaGVpQ1ZSb1RKT3kraUFqRi8rZTJaSldOWE8zdzNjMWRnMFNSRnRnU0lx?=
 =?utf-8?B?eS90dEhUWngzeGVScE1ua3pKNTdDdTdSWkJHeEFrRVdGMnlPU3lEUDhYZGJS?=
 =?utf-8?B?dno1T2o4Ung5VUJCbmQ1V1RwNXd1MXgybWs3WHd2UXdWUXIrbnlkVTRlSlQx?=
 =?utf-8?B?K2wvMFdNdnVVTkdDbkNkcC9iUkVMREdFWjNiY3pLZTEyLzg3QnlaOVhiR2Rm?=
 =?utf-8?B?VjFEWVR6ZkMyWlE2RkRRZzhpRkVqS29UT3RSa25GZzVMMlgxNFNmZnVhRDZl?=
 =?utf-8?B?S0w1Ni82T2ppb0FnRGRHbm8xUmVHV2R0VE95Y01ZNUVJblZ5KzBCZDdBNDNF?=
 =?utf-8?B?ei9salFybnRSYnNHcjYyaHA4SC9uNUh6Y0RIVmdOLzlaUzczU0JoblQ0Y1pX?=
 =?utf-8?B?YytBNDg0Yk1hT21NanNaL29iZk51eFZQZjNTaXBHa09qNnR6TUlYMHFGSGVF?=
 =?utf-8?B?TzdpdVBTbXRCa2xrMHlRRlArNGZjRXIrUXVUVkhYVTRVSi9jRERBVTVaU1Vv?=
 =?utf-8?Q?iQaMiCbYrJ1n7ziQ5qm4bTA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A6B1547B1F1142B870574DB3896A1B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb87d793-a71f-46a9-c37f-08dc9fd1abc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 04:43:25.8102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8pK/Us6k9mIJSeQjoaRjmuHL6huEodRpYDyQMjhGkIaFHMKKFHJwt3f7x+H1mTiWYmUlychJYbQlowxahRpdQyZQT3ihCeYvkYRrO7oePqcB8DdyRVuNZoo6NkKTai3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9734
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkNCg0KT24gMDgvMDcvMjAyNCAxMjowOCwgWXVrZSBQZW5nIHdyb3RlOg0KPiBDYXV0aW9uOiBF
eHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVu
bGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFjY29yZGluZyB0byBJbnRlbCBWVC1kIHNwZWNp
ZmljYXRpb24gNS4xLjQsIENGSSBtdXN0IGJlIGJsb2NrZWQgd2hlbg0KPiBFeHRlbmRlZCBJbnRl
cnJ1cHQgTW9kZSBpcyBlbmFibGVkIG9yIENvbXBhdGliaWxpdHkgZm9ybWF0IGludGVycnVwdHMN
Cj4gYXJlIGRpc2FibGVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdWtlIFBlbmcgPHB5a2ZpcnN0
QGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gVXNlIHN1YnNlY3Rpb25z
IGZvciB0aGUgY2ZpX2VuYWJsZWQgZmllbGQuDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDYyNTExMjgxOS44NjIyODItMS1weWtmaXJzdEBn
bWFpbC5jb20vDQo+DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwg
NTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gICBody9pMzg2L3RyYWNl
LWV2ZW50cyAgICAgICAgICB8ICAxICsNCj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aCB8ICAxICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4gaW5kZXggNTA4NWE2ZmVlMy4uYWY5Yzg2NGJkZSAxMDA2NDQNCj4g
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPiBAQCAtMjQxMCw2ICsyNDEwLDIyIEBAIHN0YXRpYyB2b2lkIHZ0ZF9oYW5kbGVfZ2NtZF9p
cmUoSW50ZWxJT01NVVN0YXRlICpzLCBib29sIGVuKQ0KPiAgICAgICB9DQo+ICAgfQ0KPg0KPiAr
LyogSGFuZGxlIENvbXBhdGliaWxpdHkgRm9ybWF0IEludGVycnVwdHMgRW5hYmxlL0Rpc2FibGUg
Ki8NCj4gK3N0YXRpYyB2b2lkIHZ0ZF9oYW5kbGVfZ2NtZF9jZmkoSW50ZWxJT01NVVN0YXRlICpz
LCBib29sIGVuKQ0KPiArew0KPiArICAgIHRyYWNlX3Z0ZF9jZmlfZW5hYmxlKGVuKTsNCj4gKw0K
PiArICAgIGlmIChlbikgew0KPiArICAgICAgICBzLT5jZmlfZW5hYmxlZCA9IHRydWU7DQo+ICsg
ICAgICAgIC8qIE9rIC0gcmVwb3J0IGJhY2sgdG8gZHJpdmVyICovDQo+ICsgICAgICAgIHZ0ZF9z
ZXRfY2xlYXJfbWFza19sb25nKHMsIERNQVJfR1NUU19SRUcsIDAsIFZURF9HU1RTX0NGSVMpOw0K
PiArICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIHMtPmNmaV9lbmFibGVkID0gZmFsc2U7DQo+ICsg
ICAgICAgIC8qIE9rIC0gcmVwb3J0IGJhY2sgdG8gZHJpdmVyICovDQo+ICsgICAgICAgIHZ0ZF9z
ZXRfY2xlYXJfbWFza19sb25nKHMsIERNQVJfR1NUU19SRUcsIFZURF9HU1RTX0NGSVMsIDApOw0K
PiArICAgIH0NCj4gK30NCj4gKw0KPiAgIC8qIEhhbmRsZSB3cml0ZSB0byBHbG9iYWwgQ29tbWFu
ZCBSZWdpc3RlciAqLw0KPiAgIHN0YXRpYyB2b2lkIHZ0ZF9oYW5kbGVfZ2NtZF93cml0ZShJbnRl
bElPTU1VU3RhdGUgKnMpDQo+ICAgew0KPiBAQCAtMjQ0MCw2ICsyNDU2LDEwIEBAIHN0YXRpYyB2
b2lkIHZ0ZF9oYW5kbGVfZ2NtZF93cml0ZShJbnRlbElPTU1VU3RhdGUgKnMpDQo+ICAgICAgICAg
ICAvKiBJbnRlcnJ1cHQgcmVtYXAgZW5hYmxlL2Rpc2FibGUgKi8NCj4gICAgICAgICAgIHZ0ZF9o
YW5kbGVfZ2NtZF9pcmUocywgdmFsICYgVlREX0dDTURfSVJFKTsNCj4gICAgICAgfQ0KPiArICAg
IGlmIChjaGFuZ2VkICYgVlREX0dDTURfQ0ZJKSB7DQo+ICsgICAgICAgIC8qIENvbXBhdGliaWxp
dHkgZm9ybWF0IGludGVycnVwdHMgZW5hYmxlL2Rpc2FibGUgKi8NCj4gKyAgICAgICAgdnRkX2hh
bmRsZV9nY21kX2NmaShzLCB2YWwgJiBWVERfR0NNRF9DRkkpOw0KPiArICAgIH0NCj4gICB9DQo+
DQo+ICAgLyogSGFuZGxlIHdyaXRlIHRvIENvbnRleHQgQ29tbWFuZCBSZWdpc3RlciAqLw0KPiBA
QCAtMzI4Myw3ICszMzAzLDI1IEBAIHN0YXRpYyBpbnQgdnRkX3Bvc3RfbG9hZCh2b2lkICpvcGFx
dWUsIGludCB2ZXJzaW9uX2lkKQ0KPiAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+DQo+IC1zdGF0
aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZ0ZF92bXN0YXRlID0gew0KPiArc3RhdGljIGJv
b2wgdnRkX2NmaV9uZWVkZWQodm9pZCAqb3BhcXVlKQ0KPiArew0KPiArICAgIEludGVsSU9NTVVT
dGF0ZSAqaW9tbXUgPSBvcGFxdWU7DQo+ICsNCj4gKyAgICByZXR1cm4gaW9tbXUtPmludHJfZW5h
YmxlZCAmJiAhaW9tbXUtPmludHJfZWltZTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IFZN
U3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Z0ZF9jZmkgPSB7DQo+ICsgICAgLm5hbWUgPSAiaW9t
bXUtaW50ZWwvY2ZpIiwNCj4gKyAgICAudmVyc2lvbl9pZCA9IDEsDQo+ICsgICAgLm1pbmltdW1f
dmVyc2lvbl9pZCA9IDEsDQo+ICsgICAgLm5lZWRlZCA9IHZ0ZF9jZmlfbmVlZGVkLA0KPiArICAg
IC5maWVsZHMgPSAoVk1TdGF0ZUZpZWxkW10pIHsNCj4gKyAgICAgICAgVk1TVEFURV9CT09MKGNm
aV9lbmFibGVkLCBJbnRlbElPTU1VU3RhdGUpLA0KPiArICAgICAgICBWTVNUQVRFX0VORF9PRl9M
SVNUKCkNCj4gKyAgICB9DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2Ny
aXB0aW9uIHZtc3RhdGVfdnRkID0gew0KV2h5IGlzIHZ0ZF92bXN0YXRlIHJlbmFtZWQgdG8gdm1z
dGF0ZV92dGQ/IGlzIGl0IG5lY2Vzc2FyeT8NCj4gICAgICAgLm5hbWUgPSAiaW9tbXUtaW50ZWwi
LA0KPiAgICAgICAudmVyc2lvbl9pZCA9IDEsDQo+ICAgICAgIC5taW5pbXVtX3ZlcnNpb25faWQg
PSAxLA0KPiBAQCAtMzMwNiw2ICszMzQ0LDEwIEBAIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3Jp
cHRpb24gdnRkX3Ztc3RhdGUgPSB7DQo+ICAgICAgICAgICBWTVNUQVRFX0JPT0woaW50cl9lbmFi
bGVkLCBJbnRlbElPTU1VU3RhdGUpLA0KPiAgICAgICAgICAgVk1TVEFURV9CT09MKGludHJfZWlt
ZSwgSW50ZWxJT01NVVN0YXRlKSwNCj4gICAgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQ0K
PiArICAgIH0sDQo+ICsgICAgLnN1YnNlY3Rpb25zID0gKGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlv
biAqIFtdKSB7DQo+ICsgICAgICAgICZ2bXN0YXRlX3Z0ZF9jZmksDQo+ICsgICAgICAgIE5VTEwN
Cj4gICAgICAgfQ0KPiAgIH07DQo+DQo+IEBAIC0zNTI1LDYgKzM1NjcsMTIgQEAgc3RhdGljIGlu
dCB2dGRfaW50ZXJydXB0X3JlbWFwX21zaShJbnRlbElPTU1VU3RhdGUgKmlvbW11LA0KPg0KPiAg
ICAgICAvKiBUaGlzIGlzIGNvbXBhdGlibGUgbW9kZS4gKi8NCj4gICAgICAgaWYgKGFkZHIuYWRk
ci5pbnRfbW9kZSAhPSBWVERfSVJfSU5UX0ZPUk1BVF9SRU1BUCkgew0KPiArICAgICAgICBpZiAo
aW9tbXUtPmludHJfZWltZSB8fCAhaW9tbXUtPmNmaV9lbmFibGVkKSB7DQo+ICsgICAgICAgICAg
ICBpZiAoZG9fZmF1bHQpIHsNCj4gKyAgICAgICAgICAgICAgICB2dGRfcmVwb3J0X2lyX2ZhdWx0
KGlvbW11LCBzaWQsIFZURF9GUl9JUl9SRVFfQ09NUEFULCAwKTsNCj4gKyAgICAgICAgICAgIH0N
Cj4gKyAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgICB9DQo+ICAgICAgICAg
ICBtZW1jcHkodHJhbnNsYXRlZCwgb3JpZ2luLCBzaXplb2YoKm9yaWdpbikpOw0KPiAgICAgICAg
ICAgZ290byBvdXQ7DQo+ICAgICAgIH0NCj4gQEAgLTM5NTAsNiArMzk5OCw3IEBAIHN0YXRpYyB2
b2lkIHZ0ZF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCj4gICAgICAgcy0+cm9vdF9zY2FsYWJs
ZSA9IGZhbHNlOw0KPiAgICAgICBzLT5kbWFyX2VuYWJsZWQgPSBmYWxzZTsNCj4gICAgICAgcy0+
aW50cl9lbmFibGVkID0gZmFsc2U7DQo+ICsgICAgcy0+Y2ZpX2VuYWJsZWQgPSBmYWxzZTsNCj4g
ICAgICAgcy0+aXFfaGVhZCA9IDA7DQo+ICAgICAgIHMtPmlxX3RhaWwgPSAwOw0KPiAgICAgICBz
LT5pcSA9IDA7DQo+IEBAIC00MjQzLDcgKzQyOTIsNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIFg4NklPTU1VQ2xh
c3MgKng4Nl9jbGFzcyA9IFg4Nl9JT01NVV9ERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KPg0KPiAgICAg
ICBkYy0+cmVzZXQgPSB2dGRfcmVzZXQ7DQo+IC0gICAgZGMtPnZtc2QgPSAmdnRkX3Ztc3RhdGU7
DQo+ICsgICAgZGMtPnZtc2QgPSAmdm1zdGF0ZV92dGQ7DQo+ICAgICAgIGRldmljZV9jbGFzc19z
ZXRfcHJvcHMoZGMsIHZ0ZF9wcm9wZXJ0aWVzKTsNCj4gICAgICAgZGMtPmhvdHBsdWdnYWJsZSA9
IGZhbHNlOw0KPiAgICAgICB4ODZfY2xhc3MtPnJlYWxpemUgPSB2dGRfcmVhbGl6ZTsNCj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvdHJhY2UtZXZlbnRzIGIvaHcvaTM4Ni90cmFjZS1ldmVudHMNCj4g
aW5kZXggNTNjMDJkN2FjOC4uZmZkODdkYjY1ZiAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni90cmFj
ZS1ldmVudHMNCj4gKysrIGIvaHcvaTM4Ni90cmFjZS1ldmVudHMNCj4gQEAgLTU3LDYgKzU3LDcg
QEAgdnRkX2RtYXJfdHJhbnNsYXRlKHVpbnQ4X3QgYnVzLCB1aW50OF90IHNsb3QsIHVpbnQ4X3Qg
ZnVuYywgdWludDY0X3QgaW92YSwgdWludDYNCj4gICB2dGRfZG1hcl9lbmFibGUoYm9vbCBlbikg
ImVuYWJsZSAlZCINCj4gICB2dGRfZG1hcl9mYXVsdCh1aW50MTZfdCBzaWQsIGludCBmYXVsdCwg
dWludDY0X3QgYWRkciwgYm9vbCBpc193cml0ZSkgInNpZCAweCUiUFJJeDE2IiBmYXVsdCAlZCBh
ZGRyIDB4JSJQUkl4NjQiIHdyaXRlICVkIg0KPiAgIHZ0ZF9pcl9lbmFibGUoYm9vbCBlbikgImVu
YWJsZSAlZCINCj4gK3Z0ZF9jZmlfZW5hYmxlKGJvb2wgZW4pICJlbmFibGUgJWQiDQo+ICAgdnRk
X2lyX2lydGVfZ2V0KGludCBpbmRleCwgdWludDY0X3QgbG8sIHVpbnQ2NF90IGhpKSAiaW5kZXgg
JWQgbG93IDB4JSJQUkl4NjQiIGhpZ2ggMHglIlBSSXg2NA0KPiAgIHZ0ZF9pcl9yZW1hcChpbnQg
aW5kZXgsIGludCB0cmksIGludCB2ZWMsIGludCBkZWxpdmVyLCB1aW50MzJfdCBkZXN0LCBpbnQg
ZGVzdF9tb2RlKSAiaW5kZXggJWQgdHJpZ2dlciAlZCB2ZWN0b3IgJWQgZGVsaXZlciAlZCBkZXN0
IDB4JSJQUkl4MzIiIG1vZGUgJWQiDQo+ICAgdnRkX2lyX3JlbWFwX3R5cGUoY29uc3QgY2hhciAq
dHlwZSkgIiVzIg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiBpbmRleCA3ZmEwYTY5NWM4Li4zOGUy
MGQwZjJjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiAr
KysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiBAQCAtMjk0LDYgKzI5NCw3IEBA
IHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPg0KPiAgICAgICAvKiBpbnRlcnJ1cHQgcmVtYXBw
aW5nICovDQo+ICAgICAgIGJvb2wgaW50cl9lbmFibGVkOyAgICAgICAgICAgICAgLyogV2hldGhl
ciBndWVzdCBlbmFibGVkIElSICovDQo+ICsgICAgYm9vbCBjZmlfZW5hYmxlZDsgICAgICAgICAg
ICAgICAvKiBXaGV0aGVyIENGSSBpcyBlbmFibGVkICovDQo+ICAgICAgIGRtYV9hZGRyX3QgaW50
cl9yb290OyAgICAgICAgICAgLyogSW50ZXJydXB0IHJlbWFwcGluZyB0YWJsZSBwb2ludGVyICov
DQo+ICAgICAgIHVpbnQzMl90IGludHJfc2l6ZTsgICAgICAgICAgICAgLyogTnVtYmVyIG9mIElS
IHRhYmxlIGVudHJpZXMgKi8NCj4gICAgICAgYm9vbCBpbnRyX2VpbWU7ICAgICAgICAgICAgICAg
ICAvKiBFeHRlbmRlZCBpbnRlcnJ1cHQgbW9kZSBlbmFibGVkICovDQo+IC0tDQo+IDIuMzQuMQ0K
Pg0KPg0K

