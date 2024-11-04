Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CADD111B6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rta-0004Rf-1V; Mon, 04 Nov 2024 02:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t7rtV-0004QN-Hf
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:53:01 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t7rtS-0000Ls-9O
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730706778; x=1762242778;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=HbNVQe2FfRS1gOXpfkpafK9OhCl1c8S6ldlVPjedQQo=;
 b=h4tpAQFmNFhZT4IJaOGnQ23ayL7s9MoaCiHofG5vGYkDrwq2h0tuaadP
 do3IX2FR0c4ykvX2uAb2U6dwH8exPi7n0rMypGCxBeQsh0yE1TyY0p/dN
 Y7/t4VN2wt7Zyp+l1FPTOdAEshffdyymzjd2g/gXdT3Huep94j6nMQZrG
 KOXsu6owg52bPellwsCK1N1lx5AJmv9USQknxl+cKwxjQb1IJKQPpjlEs
 mdjTpyd3tuKV5qz+9H4H882ZK92NbSgSW2N7useuOTedt+zo3/H2VSrKd
 qhm8/31ca36/WAbo0FXjO3E09EblHoS8n4zsqWSss1Gqln0fuE2NKpRAr Q==;
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; d="scan'208,217";a="23748166"
X-MGA-submission: =?us-ascii?q?MDES5jAQPED8EjsrPc3t2hrvGTceQ8S2n+jJwK?=
 =?us-ascii?q?e30zUyFMwifT0NomxW+KsnNRRrmdEu2VJVKDFr2Ko+F+8zzB+lKI/czP?=
 =?us-ascii?q?PavG1zen1mHY4gIb5SwUXe6hpZvoEUVjUUCkYe+DXvFPDJhJ8dO5iRP0?=
 =?us-ascii?q?LokkmL155gI8M7e3sIYcaKkw=3D=3D?=
Received: from mail-vi1eur03lp2109.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.109])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 08:52:55 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRMIsN9PrMTbs3JU7DPexSfFk4ds+IJE2l/fhormvgsd0lj59+YXGdNJLDRCCf8qXt4bgB4zLaydbprzZFbexQPKWbkgxwYTFcK0464eABabtGzV6G85mOaCbfoKxP6sdWUZ9eJJuPQSr/qLm4vxdtZmLzkGRHl4mIgDelyoF118L2HCj74JgDQCXmu0lgluddYpADIPjWOKalps3qU1pL4Wcld/mkzfYgvKzkIr4cRAYoU1PC0bGsiSu46RMmiB3mKyOIi1X6pNvGjgdjG+1lweI0ShFepmTaUP/o7tdkd8mMIG+glkp2XE2ul+UXsKcKAL5ZaFVoBb4kWXBu3uSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbNVQe2FfRS1gOXpfkpafK9OhCl1c8S6ldlVPjedQQo=;
 b=lvXOOzfKrt3aXPIRcu6mnKXZSfGhj4amGRrJLSmEd7wDb7DK1KGHYcda+4cfBbEogAaWLwTL8MNb7eNprsKR+GeekL8ry4uRfHOWOjTpL83YO66hOUK0hTXEQhhxLrnXJqQCMyavnBAV4uiLibyeHUJSWe30eKnOnmvvnsVW9gtQp512IOElgZMKAYwIEcKv55RFi4d2vcq7xrUwyuEduk3e/BOFaatBNEcsljM7tqwSK/f92IokKuV05XYm84wgSV1K5nTOGooP9cQNp/jbmjfJ33hSRd/7MnFooE1LnVF69CVWBwd+M8zJO4E3f80S8dEug1s1z6oxhIVu5IDy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbNVQe2FfRS1gOXpfkpafK9OhCl1c8S6ldlVPjedQQo=;
 b=bcMza6aTfyXj+plLWNBn/ODv7GwmGdTywrd0Z/ovNiq2ljyYiS+Se4WNVHTYeaA4QaO1F0hwE0lZne5mKb+B7SP6FZmjBAXagAFV8Qk+kTs2uqDXgUG470fK2nNIHHEX6C8P/RQ2N7cbdHYLsyxxpv1eVkofM1MSjhCKWS005ELtu9ALGefYHcZj68G1atNjtYOMHmxNzcVuXKzdXrH9Y25ApYhaEX5dlJC2MUp3cx1WfbbCS72sql9B8523xKHIMGAjRcc8Wp7j7dto0CwFgPkEE8Sip3yJPFOXXw8BBffWmHx2Aonsh17ZSmxe6gUkN0xDyXA6xP0HpPya9Ma3Og==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB7758.eurprd07.prod.outlook.com (2603:10a6:102:135::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:52:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:52:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Roman Penyaev <r.peniaev@gmail.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/2] chardev/char-mux: tweak mux bitset operations
Thread-Topic: [PATCH 0/2] chardev/char-mux: tweak mux bitset operations
Thread-Index: AQHbLRe8tfShKf4C5E2J+gtzLQZ++bKmwuoA
Date: Mon, 4 Nov 2024 07:52:53 +0000
Message-ID: <3ae95064-802a-41c7-bc99-faee079771d9@eviden.com>
References: <20241102110719.682399-1-r.peniaev@gmail.com>
In-Reply-To: <20241102110719.682399-1-r.peniaev@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB7758:EE_
x-ms-office365-filtering-correlation-id: 46790f21-cae3-4221-e15e-08dcfca5afed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SmN5VmFiQlY1VHZpdUY1MXZvTEdqaGpkWW1PZGppNzkzZlUyVlkrTjRoREl2?=
 =?utf-8?B?WS9EWmxTYTBabkNrbFZLMmNkQUlyUjc1cUV3S3BFYWIyZUlzMzk5cUgrUGR5?=
 =?utf-8?B?d3puZU02VnIzVWdkQkVyQk5jSmVKYXZldDJlaG1WcW9OVW1KOW9oWXd4OFlk?=
 =?utf-8?B?UCtXU3Ird3k0REVqdEovTk9xTThVbVN0cTFIRU1SRzltOTk4RFc1a1ppMEpl?=
 =?utf-8?B?b0FnUURDUUdQdnM1QTgzS0paN2VjN2RTUUVLMVV2WXovbVpLU3JFbjlVak53?=
 =?utf-8?B?azRrUnpDZTQ4MVphVXFjbEpoa01reWZmTVg4cStCUHc4RVJVZHhNZjVlQ1k2?=
 =?utf-8?B?M2tEMVR1elh0R3VzK2dVUXJZUy9nVXNpYkNOQzlUSTdpYVRpTW1nR0lIM3pk?=
 =?utf-8?B?U05vdDlIMitPU2RMSUo2MGlhRU1WaGxhMGlRalRoV0RhNlZoWlNTcVFaSUpm?=
 =?utf-8?B?M0xLQytSWFZlaXNINTJEb0ZtdnFmYjl0OVZPeENnUTFvNW1ZR1M4akVkZEJS?=
 =?utf-8?B?RGx3ek5Jc2NMTWZKZVEyZ3ZxR281Mm94U3g4Yi8zQnM5eTRhTkhJMFNsLzJr?=
 =?utf-8?B?YjdySXZ0S0tGN3Q0RmU3YTI1TUpJTHhCVE5QK0JIWlZ5NVNNMWdVZ2N0S24v?=
 =?utf-8?B?WEIyRUFkZUd4MndlSzl3ZXMxSjRNMnBOb3AyMmRiQlMvaklCbW1qR1B3NzJE?=
 =?utf-8?B?OExEZExtMW8xTFU2bGxKWFpmKzVoQVB4TzEyd3FqUHUvSUZuK1lkNFRndEhh?=
 =?utf-8?B?Tkxhd0dyK2h3akdydXdPWFVoaTg5eUFPdGZuTmF1QitLTUxqSXlidXUrV3BW?=
 =?utf-8?B?b2tzUFlscHdvWUhBTnRZci90RzRtS2N3TzY1d1EyWmUzQjB1bWhueUhNUzNB?=
 =?utf-8?B?RW8xRDhId2ZKUmphazNSaVdiMmhpYWZBaUdBWFBoMHJNeVNXa0lrMFNCUHRs?=
 =?utf-8?B?UFZERXdZWEV4alRoU2JnOHZUV1VCdmpTL1VVc0FBK2JtajRsb0grdHJzQWhK?=
 =?utf-8?B?OHFJR2NlMkxFRG9QVWhuZWZSS0ZRQzVxUnlVaGZLMTNaSWNvUFd0amduSWhH?=
 =?utf-8?B?NkttbXF2MzBHbFdkVzhVT3YyamRrOGhOWXZYbERyZXJ2cC82TGtYQTFWbm9M?=
 =?utf-8?B?V1JVZ1JsU1prMy9HcmhQL093eVU4ckZ4ZGJ0NURoM0FVazFCcmN6cWpTMzBQ?=
 =?utf-8?B?VHQ1THVxeWRtMzlCYW16ZDV5SjVESVdmY1NQVGp0WTQrb25ITDFxNjNIUS9n?=
 =?utf-8?B?b2k2ZytMVGt4d3VEMUVmUkpWcnFiMGZETlFwenZhWGhuRXA5d1c1SGJIY1RZ?=
 =?utf-8?B?VytGWW91M2poM3ExRGhLRzJjbXM3am1IZ0s4bDBHQlZaMlZyZWxVQ0Q0Q2oz?=
 =?utf-8?B?ZFRYemh2NWZjSjVQME1qYlIwN04yUUw3V1NQZTNOendLN1J3cmhSdGE3ekNp?=
 =?utf-8?B?R0N2aWI5TmNPTFpmNTB1aGNSN0k0NFkvWHhvY2lvSnZMUFlvTmV6Q3gxalZm?=
 =?utf-8?B?NEV5dHR4L2t2ckZxWUliKzZnTlgrQUw0TG5DWjV0UFBSUWI2QXZpZEhESWxi?=
 =?utf-8?B?N3ZOZFZYRXg3TnVacFluQjBrV3dncjhjSWJXL1o2WENUQUZUVEdLUDVMY3p2?=
 =?utf-8?B?ck92OHdyczRsUDE5UWpNNG1IWHkxc0xEeGVQYmRQVUc4SC9RdUFKWmVOWE5B?=
 =?utf-8?B?Nmt1WFUyYVN4b0NDbll6ZXZVU3pYWjNpam5NRncrSkgzZHlXT29HYWZ4Um1a?=
 =?utf-8?B?SU5mYVY0VWd2NG9iME9ET2g2a0N5ZHVSdktMcDk4KzJhdHIvY2N3N3RSeXZU?=
 =?utf-8?Q?3DajgSd+TBaGZV/GHlV7eL6vMnEnGLRs17FjY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TndpVk9VY2g2ZEgxWHFUeUpPVndEWTZTRitKVGZsSE1lV0l6TDg1dkhWU3hE?=
 =?utf-8?B?R29EWTh4SVh3WlVBZ3RqcklkRzVCZE1jZXQ0L0lVRDFhOEdLZWF1bnlKVUt2?=
 =?utf-8?B?UklyZmVGMEw5VVB6ZTRiVHYrQ0pnRlFHNmhYNDhoMENMYjVjY0J4ZHNLWXdr?=
 =?utf-8?B?ellnczZQSmEzd2NQVVU0K2VvYXdWZnRheSsxbGJvYWRtM3Z2S3ZqUHRReHN5?=
 =?utf-8?B?Wk5ndFp1cDFncFJUVktPdWNtODluZGRYYzYvZEZyeWFSQjJHWmlYa3BDdGVR?=
 =?utf-8?B?OERZZlNtb0VXd3N4KzJiMUtWZU5XazlPcHZhRWMyQ05hVmtQS2V5U0RjRlRG?=
 =?utf-8?B?Nm8vSVJWN09id1M3a0hoamtYdW8za3FsOWwyZUlZOHByQVFlNGhVOGNQVTZR?=
 =?utf-8?B?UnJVaU1LT3R6N3hQUk44Tkg1dGpvVVZ2U2pVM0w4QklaTDVMVmsydURnVXZT?=
 =?utf-8?B?Q1JhYXhNdlE0dEVIWXkxdUl3NVZpU1hBNTBZdWZPMFFRQU10V05kRytZdVVz?=
 =?utf-8?B?ZXBzUDBhRTJYOWFrZXlFU0pxL2FiN0VTZ0N1cFdLWE1qMFZlZ0Jmbm9XV1dD?=
 =?utf-8?B?bjZOb3pPV25VaThRcnVwblZ2QkZtRjE5WGtrWWNVZ24rbElycnZETmpsM242?=
 =?utf-8?B?dTJSQzZiN3JSREJHUEpqQllMWC9weHlZT3dJSm50ME9TdEpvRlJ3UER3ZE1X?=
 =?utf-8?B?WlBXSlFoUVJ1NzJBa3cxWkVGanFtN1JoeU1MY29RN0NrMkFKU3hNSC9hdUhH?=
 =?utf-8?B?eFV6MkZSck9wUTlWTzVkaFlvV0VhQS9CWFZSNHZMcHpZS2Y3aTh5a05QdXVJ?=
 =?utf-8?B?TTJlTlRHMjNBdC8yVXdYYmNWS2M3U0JESFlKbUtRQnJ0ZCsrV2lVY2h0UTZ0?=
 =?utf-8?B?U0tKWXVOZytrSzdTS1hyaFB2am85TEdoRlNjTEwydW5rWlBFSmorc3FwTkZC?=
 =?utf-8?B?VmpKVG9jNXRobjFZYllPVGc1RjN1cFFkUFc4cSt5WmczQ3NUQmwzMFNFRzZL?=
 =?utf-8?B?SmV5aHNHWnJleWJZbTdyNWVucjd6UytyVUJWTlU4OXl6NWdvUVhValBKVG5V?=
 =?utf-8?B?elUwSmZrc0NTM0RGMmpEc0ZvTTdaczZ3dGVFMi9CTEdzZEhjM3BYSTMybTM0?=
 =?utf-8?B?K1RjcXhXWHJmb2RlbUJGQ3NzR1hEdzc2Q2YyeC9ZVndjTmJmR2VKNWtZN3ZS?=
 =?utf-8?B?Y2JFYUdjTEw5WXMwMjlIWk9uRVMzcGRaRnZuQkpCa1V6cGdHcTNQVHFwam9r?=
 =?utf-8?B?ZGx2VzgrL3FBRHdEYytzSkZ4cmRscXBtaHNpWlhZc1VPR29lQU5yeGIzQng3?=
 =?utf-8?B?UDU0bzk2U2ZJUElyb1BRMlF0T0lVUDlaK1JDcU56VUIwZTQvMWt4QzlGZlB4?=
 =?utf-8?B?eEo0TithQy96YnJ4NzFaWEIrc0x1V05jYklNVWhpaC8wSnN5Rllnay9NeGht?=
 =?utf-8?B?OXRDN1NmQUdtYU1TRUFJNHBHYm9DUVFlMzk0RUFpS3dlY3RNT0dtcUxYZmsr?=
 =?utf-8?B?MXRaY0dqNmV2cXQ4UjFTTytKbXhoYzBhZUV3NkhxSkhEUm9BRWNMUDJ0K0cz?=
 =?utf-8?B?S1dhSi9PaWlDOWRvUUQ1TzdNNUdZdW5DUG53azRKcjJkOVdmQ2ViQkFxd2dh?=
 =?utf-8?B?WDJGZlJkTGZ5NTZwODY0cHF3Tm5KQ3A2R2ZiM0xVSkUrQitjK3g1RklOakNP?=
 =?utf-8?B?WWJWVExUNUl6eE5ZRUhHUFg1Wk9PSDEreFJjTmhIallMNmpkVCtOYXRJQW01?=
 =?utf-8?B?d0FiS2k4VXMzcGlhOGQ4R3AvNXF3L1lIRUZRL1RneFZzVjRwY1NuTnhaZ2xL?=
 =?utf-8?B?OEdsMzZsQVVLSHNicVRLRmV0YTlFK01nbXlxeEJkcXlLNFhmR1ZJWEFabTQv?=
 =?utf-8?B?VnBsTHVHRzRCU1F2VUUwcWltNG9sNDl3Mjl6S2VMZlBDV2Rpd1FjdUFFcHpv?=
 =?utf-8?B?TEVkWHprQ3hhZVFHeDZvVCttMC9aMFg2VW5aTWxQc3FqZUd0WlloNU9Zbkda?=
 =?utf-8?B?T0RqenFicGRUSW41UHgyZHJ5MU1qTUF5d0xVcm5Xb2lTckJkUXRIaTBadE1M?=
 =?utf-8?B?N2ZCZzNlTFpJKzlTRUw1RENSWmtFVWhkbzQvNk5kU29lcEFCZi9UWDU2Mncw?=
 =?utf-8?B?aWZ0dE5zYXVQaWxyQi9YLzlsRlR4R3ZlVnZJb0FWd3Y2NWhOZzBtY0JTSFFJ?=
 =?utf-8?Q?xOOcrhIO4jlYr+ykztxMMGQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_3ae95064802a41c7bc99faee079771d9evidencom_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46790f21-cae3-4221-e15e-08dcfca5afed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:52:53.0640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIE7cgx6oYWx8D1oa8wgN/bet3yTcUN1FMg3wJojHm62T5HaN3OxPFQqxkg1gIs9d3Yj70O77l5ohcW7/e9xGOJxgxUEsmDfeOjdOoRL68RETjU0obSekLo8RdgOnupf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7758
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_3ae95064802a41c7bc99faee079771d9evidencom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUm9tYW4sDQoNClJldmlld2VkLWJ5IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPjxtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2
aWRlbi5jb20+IFRoYW5rcyENCg0KT24gMDIvMTEvMjAyNCAxMjowNywgUm9tYW4gUGVueWFldiB3
cm90ZToNCg0KQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNClBhdGNoc2V0IHR3ZWFr
cyBiaXRzZXQgb3BlcmF0aW9ucyBieSBjaGFuZ2luZyBhIGNvbnN0YW50IHRvIHVuc2lnbmVkDQps
b25nLCBpbnRyb2R1Y2VzIGEgc3RhdGljIGNvbXBpbGUgY2hlY2sgYW5kIHNpbXBsaWZpZXMgYml0
c2V0IG9wZXJhdGlvbnMuDQoNClJvbWFuIFBlbnlhZXYgKDIpOg0KICBjaGFyZGV2L2NoYXItbXV4
OiBzaGlmdCB1bnNpZ25lZCBsb25nIHRvIGF2b2lkIDMyLWJpdCBvdmVyZmxvdw0KICBjaGFyZGV2
L2NoYXItbXV4OiBtYWtlIGJvb2xlYW4gYml0IGNoZWNrIGluc3RlYWQgb2YgZmluZF9uZXh0X2Jp
dCgpDQoNCiBjaGFyZGV2L2NoYXItbXV4LmMgfCAxNSArKysrKysrLS0tLS0tLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpTaWduZWQtb2ZmLWJ5
OiBSb21hbiBQZW55YWV2IDxyLnBlbmlhZXZAZ21haWwuY29tPjxtYWlsdG86ci5wZW5pYWV2QGdt
YWlsLmNvbT4NCkNjOiAiTWFyYy1BbmRyw6kgTHVyZWF1IiA8bWFyY2FuZHJlLmx1cmVhdUByZWRo
YXQuY29tPjxtYWlsdG86bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KQ2M6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz48bWFpbHRvOnBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz4NCkNjOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT48bWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0K
Q2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzxtYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnPg0K
DQotLQ0KMi4zNC4xDQoNCg0KDQo=

--_000_3ae95064802a41c7bc99faee079771d9evidencom_
Content-Type: text/html; charset="utf-8"
Content-ID: <775B8FD554BF8A4B868CBF33ACB8B98B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+DQo8aHRtbD4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVu
dC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPC9oZWFkPg0KPGJv
ZHk+DQo8Zm9udCBmYWNlPSJtb25vc3BhY2UiPkhpIFJvbWFuLDxicj4NCjxicj4NClJldmlld2Vk
LWJ5IEM8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6IHByZS13cmFwIj5sw6ltZW50IE1hdGhpZXUt
LURyaWYgPGEgY2xhc3M9Im1vei10eHQtbGluay1yZmMyMzk2RSIgaHJlZj0ibWFpbHRvOmNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tIj4NCiZsdDtjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbSZndDs8L2E+IFRoYW5rcyE8L3NwYW4+PC9mb250PiA8YnI+DQo8YnI+DQo8ZGl2
IGNsYXNzPSJtb3otY2l0ZS1wcmVmaXgiPk9uIDAyLzExLzIwMjQgMTI6MDcsIFJvbWFuIFBlbnlh
ZXYgd3JvdGU6PGJyPg0KPC9kaXY+DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6
MjAyNDExMDIxMTA3MTkuNjgyMzk5LTEtci5wZW5pYWV2QGdtYWlsLmNvbSI+DQo8cHJlIHdyYXA9
IiIgY2xhc3M9Im1vei1xdW90ZS1wcmUiPkNhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qg
b3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMg
ZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0K
DQpQYXRjaHNldCB0d2Vha3MgYml0c2V0IG9wZXJhdGlvbnMgYnkgY2hhbmdpbmcgYSBjb25zdGFu
dCB0byB1bnNpZ25lZA0KbG9uZywgaW50cm9kdWNlcyBhIHN0YXRpYyBjb21waWxlIGNoZWNrIGFu
ZCBzaW1wbGlmaWVzIGJpdHNldCBvcGVyYXRpb25zLg0KDQpSb21hbiBQZW55YWV2ICgyKToNCiAg
Y2hhcmRldi9jaGFyLW11eDogc2hpZnQgdW5zaWduZWQgbG9uZyB0byBhdm9pZCAzMi1iaXQgb3Zl
cmZsb3cNCiAgY2hhcmRldi9jaGFyLW11eDogbWFrZSBib29sZWFuIGJpdCBjaGVjayBpbnN0ZWFk
IG9mIGZpbmRfbmV4dF9iaXQoKQ0KDQogY2hhcmRldi9jaGFyLW11eC5jIHwgMTUgKysrKysrKy0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cg0KU2lnbmVkLW9mZi1ieTogUm9tYW4gUGVueWFldiA8YSBjbGFzcz0ibW96LXR4dC1saW5rLXJm
YzIzOTZFIiBocmVmPSJtYWlsdG86ci5wZW5pYWV2QGdtYWlsLmNvbSI+Jmx0O3IucGVuaWFldkBn
bWFpbC5jb20mZ3Q7PC9hPg0KQ2M6ICZxdW90O01hcmMtQW5kcsOpIEx1cmVhdSZxdW90OyA8YSBj
bGFzcz0ibW96LXR4dC1saW5rLXJmYzIzOTZFIiBocmVmPSJtYWlsdG86bWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tIj4mbHQ7bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tJmd0OzwvYT4NCkNj
OiBQZXRlciBNYXlkZWxsIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstcmZjMjM5NkUiIGhyZWY9Im1h
aWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmciPiZsdDtwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmcmZ3Q7PC9hPg0KQ2M6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGEgY2xhc3M9Im1vei10eHQt
bGluay1yZmMyMzk2RSIgaHJlZj0ibWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tIj4mbHQ7Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20mZ3Q7PC9hPg0KQ2M6IDxh
IGNsYXNzPSJtb3otdHh0LWxpbmstYWJicmV2aWF0ZWQiIGhyZWY9Im1haWx0bzpxZW11LWRldmVs
QG5vbmdudS5vcmciPnFlbXUtZGV2ZWxAbm9uZ251Lm9yZzwvYT4NCg0KLS0NCjIuMzQuMQ0KDQo8
L3ByZT4NCjwvYmxvY2txdW90ZT4NCjxicj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_3ae95064802a41c7bc99faee079771d9evidencom_--

