Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB5606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=d0IjeMV+;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=KcrZaqZ5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVIuP-00077M-K3; Sun, 22 Nov 2026 20:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVIuO-000778-0X; Sun, 22 Nov 2026 20:31:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVIuL-0000st-TD; Sun, 22 Nov 2026 20:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795397517; x=1826933517;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kxp3MEKO4QL7GlBwq0NgljeSaK4ynSIoadT5ybHszqg=;
 b=d0IjeMV+J1nzh3oJifYD1A7Zh1B3uvvrYhL6DLtWyiK13H+9kfHDxTO/
 2xLqhMfqppE8YGTUdZ5dYFqGCC6gLb8SXoy/W2YPv+uVbYs2DsbEwghe0
 4iXbRWOWeNak2k6ZQYNDyn9HxUBJhrb+a9UaEZQW6cIuaBbFEh1vEcIpZ
 kpduoewy/QTEL41M7+Hpo+mIELz8HtIjSuaZYbiGtZMoVj/g8s7IS7JSR
 DBcu3Hvmzwm+wZ+S16/I8aIUYHhbxZB/6ZRde7lq0wN78+l9Dz533uCIX
 nKKMNx47RxXnYXeFq/RbholyiS/GbZulu285omQHuwQyt2y1hZ6Zw6JQD Q==;
X-CSE-ConnectionGUID: zT0DjyQrRUqCn4ymf7Yi8w==
X-CSE-MsgGUID: DgQeEy7HSZm3TWKdMV9Azg==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="157275948"
Received: from mail-eastusazon11011000.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.0])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 09:31:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ21/dEZ7H4+jVnhjLXyKIfYN4kgXzyiTDDYhzundQ2XVVrtQ812Ul2598B8zGV6XP32BUS8zIse1Es01t3+JBlp3sRrku+ZVg09Zf1EJIfGAu3U35ASqCwRDVxJRKNNzyw7QfLfoqQ19l6kUGx0yfEtYylVLcCzaDZzZTtamVI3TSMRnehjfTF75+j+A3cnKiy2ate00TS036/SShnkxvz19Xv6Phsz80gpTRNFPEKsrr6lazB2aQX+/SWCAT6TUb4TsWilFvsKoz73PQEQZX10EVfhXNq8db/LaQnJFTH5qk3huTr7KdGDj8+IenQzxVLVj1UN4TQ18vAgba57kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxp3MEKO4QL7GlBwq0NgljeSaK4ynSIoadT5ybHszqg=;
 b=PYEZrWVltOIF38zVP0Ap45FO8zuAMym4/QPwNrlrtgxpuzKPy0J0bOZvLrC/CctlbFa7rBjVp0Ocdt3/Fkid+xW9SK3bWyRtj+BRfo6Dfxq9iTvBYY2A8Ed2iXVwk7dD8GdHFdstQCBj4nKulBrNBdn8oSi9uNpsWn6zo2yaEGfUNuBZo49HRUyyBb1lfOMOZHMXL7g9WDU2LDgYZp58hgL602JU3NPjWbIjFcvTm0YQSLNCJkobnLYA4dEyANH70bRPAe6u1rqAZhVl7UmRQU9Ze8K/bBfS+KlBivxQkiJUoAnkaB11Sdg0jdhA77a9jyPWQ8LjeG5R2+a5OL3X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxp3MEKO4QL7GlBwq0NgljeSaK4ynSIoadT5ybHszqg=;
 b=KcrZaqZ55oVxy0uMD/a8GV3Osb/0Dx6Za6gWXI+NwjNXx+o1KI7YsDb4vDHgDbU8kK7eIBE22+BtLEFET/ySMi2lWrI9Zg25E/uKigP7zYmfUvbB/X/Ops8nd9Rzv1f3GQm7YQisj1ucqs7wCVIVoGTFKvvD1+kb7phn3e0+PV4=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8270.namprd04.prod.outlook.com (2603:10b6:806:1f1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 01:31:43 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 01:31:43 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: make mstatush.MPELP writable [GL4220]
Thread-Topic: [PATCH] target/riscv: make mstatush.MPELP writable [GL4220]
Thread-Index: AQHdcxL72OYEkNd8xkS9TVAjEswgl7c67qMA
Date: Mon, 23 Nov 2026 01:31:43 +0000
Message-ID: <9d0f34d05d0371861c25bec7cbb78852adbcfd3b.camel@wdc.com>
References: <20261112200635.549520-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261112200635.549520-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8270:EE_
x-ms-office365-filtering-correlation-id: bfad26c7-3949-4b65-86f4-08df490187cb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|19092799006|376014|260925022911599003|38070700021|10067099003|56012099006|11063799006|260925021911599003|260925021311599003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DskKNM4iqZuMZ+zGTXHbluhquOGWLfo+dKm+gz0znoNHa6CNKUwenN4D3tUv5qWayYWYbmgCCNv82fL9lJhKUuwE/Jk0Ogz/b5Y6MfPxPdLZ9HpcSf6DSmJWD9wEMmvt4ECfTpuPG8SIiVGyzgESb6wCFO7PIbUCSXWpHqoJTShP8WV9tnp/jpJsSh79jF3kVqqSSIuLY9W+6B2c5eIn1Aaa7lYBRFSW6gSFtHRDi3l78gQPAz8Gp0RJe2lghwwbMR1A8yHZyKeTOTlOjuPPRh4VDG59bPvmMYqMMJ0yCyQleDw2v5W8MBx1GqsVJ6E1ALK7fLiH/dftsvNoLKG8pTWXA0H6OJpjmsdm/3oLD+msn5fNT0LjV485JPu0CREuXSEAyZ1Iik0TkwlqSG1qR7UE0G1NEvixZPTEvBoTHxsx7RWoFpb46KJDwaLCa/AQsUxLdNxhEcm1gkNVm8mmuaB/aaqlhXOVkb/H40sZF2dP/8vtEEMxtGzaDLKHYr/EJT0V8yukBb0z1VM59Yt5rinXThiFVhxv5bn9OXNqls1EqaYY7KlE0Mi/giHZJtcblrZntuEy9QKh7MZ29ShcXWle2HH4w0NGBXL/9n0905T8hXE7itbsTpQP2yxFxVxAkfwjceRdx7pVLm8NGsBHHdYiPygcJddTapHCkEO+6cfwZqmVFJIn9KJCHtL9qLdipYZZyut/5RTZl1mN6MeuYPIMCsxxdS6VpNgiP3xMu4M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(19092799006)(376014)(260925022911599003)(38070700021)(10067099003)(56012099006)(11063799006)(260925021911599003)(260925021311599003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3ZuaVVxNmVBVXBUYmU3cDMwYllCK3p2ZFlSNm9USFYwd2F3c3VlTmJSQ1k4?=
 =?utf-8?B?bTRBeVZqQlg4enE2ZEs3eEw4eW9TVjdwdmtRUmtRSkZDOFhuc0toZ0hGZ1Np?=
 =?utf-8?B?R0QyemlGbnJwU1VzT0VuejhFMzY4eUlvUURFa1d4V0Y3U0Njb1RlbktqOGt0?=
 =?utf-8?B?YTFOckhFOERheXpNNEZRbjh2eXF6VHk0N3prenJaOVRFZnNBYzR5LzRqY1c2?=
 =?utf-8?B?MlVoMWRVcFUvTHNtWU4rMC90UW5TMjlhNjNaemNlSHllZ1VJdDJPampKMDYy?=
 =?utf-8?B?NXp2dHE3OUw0UC9UWHVqak1FT3F4UVgzZWNHTTVMNVV1TG5WQkxoVzVPZ0Fn?=
 =?utf-8?B?bUhKMWNDMTdzdm1hbnQwNUgvdDVvd2RMaUFjKy9zMi96VWswL05OQ2JqZ0xF?=
 =?utf-8?B?T1dzVnFhN01DT0dMQWRsSVlUcG1lb293Z2d3OUVFcTBoekFwWE1MZnVjbW5V?=
 =?utf-8?B?UnJiQzdaM2VWZEgwK24yMk9ocnFDWXVPNDh5UGgxK0djRmhxdnFsMGNTQ2ZV?=
 =?utf-8?B?akVWMUhkeFA4bHByRnY2TFFzRlVHVDhuV2FIUnM2YmJ6Q01rRjg4bkIwQVNx?=
 =?utf-8?B?VEVpTFRVVWNlUDJZUUNKODV4c1RpcmRpY3dlYnkrNWtraFlUak1GdHMxNlVq?=
 =?utf-8?B?Y1dNZldnb09SaEc1MXBGNmhSbTdrZ3BXMGlhb09yc3RtcE81ZTd2TE9mUFNP?=
 =?utf-8?B?cTYzOFVlcTJXeklrTjFjem1GcWhoRGVQd2E3QytlQmZML1R0b1hDaHBGendO?=
 =?utf-8?B?eFNhRVRXQW1Va1VQcGZ5bHRydlo5TXAxZ3BWa2ZrdTl2VUxOSTJqMFFXZ254?=
 =?utf-8?B?b2hMbHk0Yy9aejBXeWVrOWNNbmpkdXp1M0h6OWx4WXJSTEJnWkxsT1hLNDBU?=
 =?utf-8?B?RW5sR05PRVlOTy9Td0NXK1RnM1hJd1hacFRwcEluUnZkRitCdHhvbisyc1Rt?=
 =?utf-8?B?dGRsRHMvQ3FMTEI5UW5uSU9uZG1UQ2tyc2RmRGM0QzFqb2F1TWRodk9OWElO?=
 =?utf-8?B?UnNKNDZYZ0FqSk1WTDlYakJMOGIzdExxQlZIL3JRSjBhdGxFcWp6Y2dBVTFx?=
 =?utf-8?B?eElJU2Rhc3pSRDE4TVppbC9qQjBSK1lXdGpWeERrUkg4akFxaER0TkpSUC8y?=
 =?utf-8?B?eWlHN3Bpa1pVK2JnT1ZrK0VaUWNBNWVGQ1RsZnpHZmttbW9XRkd2WGtsdzN2?=
 =?utf-8?B?Q2hUai8vKzNOSW5nbStTamVXbVB5MXlNdjlZRTF5RHlwL21pTFB2dnQwNlZG?=
 =?utf-8?B?TmZwV0hrWVpJL1FYdk52aWxsRjNSQUx2SnFjNVZsWFE0NFJIS3J5dkZPSWpJ?=
 =?utf-8?B?dUVLaUhXalR1K01jbTdjanVFUFFJSDlyRVluUk1TYVFFVUZMQzAyUFpNSFEr?=
 =?utf-8?B?Q1JKK3owVjdKdHgyL3h6Q0FTb29ZOU5kVjdENUkwVWVRYzZOVWJBa3lrSjlt?=
 =?utf-8?B?dzVVczNkTm1aK1AwME1kNlRWd0ZoeklZOFhiMGZSK01TRlpxMHZybjFLWVdZ?=
 =?utf-8?B?K0VHUVJmb1hEVU55dTFvbzJveld4Vi9Nc08zYzU2RjJzYXdVSC9qK1lsT3gv?=
 =?utf-8?B?T01NTU5pNFBsYk51QkFpVks5RWdMSGJ0d3RmWUlzN1MwOVhsVlpvcUVDazNh?=
 =?utf-8?B?R2x5cUZ5Qk9IVVB6Wm1zZVd1cHpCcGdFdFRKVFJJR3F1NlRPYVNQWWlrKzBQ?=
 =?utf-8?B?Z3lSdHNjYkE2eUJ5RzA0d0pnL3V6Y3lLMEQ0VFg0Vno4dnFLNVVIa3VFVVRk?=
 =?utf-8?B?WkZ6VGxYcUxySUl4YXVJK1FYSm1BTldVaWFzNDlnaW5LakdnSkJiUVFnTENo?=
 =?utf-8?B?MkF5UU0vQnJaSEt5clpibzBLVHFlL2I1N3NiVVF5VVJieU9TbmVhcG5kbWdS?=
 =?utf-8?B?czJ4cFNJR3lnc2NWZjBjQzI0UWhiaU5XNjIxNGU5RnEyckxIZlA3MlV4cnh0?=
 =?utf-8?B?TEJKcDhnbTc2MzR2aUVmaDZOdVdkWlVqeTZWMDgyMUFBc1l3NDhHb1cwYnJ5?=
 =?utf-8?B?OUJuY2cvVnluckVhdzVhMFhEL0dXMVlGZTNuYy9DUGh1NXZ3MUE1bjM0ZkNm?=
 =?utf-8?B?WmwrcTZVZjlHdTZhQ1Z3TUNEMEFHeEhNVjZ4dll0SVlrYnpWNGhSOUlYTERR?=
 =?utf-8?B?VTlLUWR6aUNwblV4dWhpQW1FMFNhSnNUME9yUStrakFUeC9iWHkwUVh3aTZI?=
 =?utf-8?B?dEZ0c1FyWExxR2laQWhhQjNhSnpaZ3FkcDJRelhWdWQwNDB4MGhYRUpTVG5C?=
 =?utf-8?B?dWFmQ1hWRWJxelBmSE5nODVsSDBvbFB0OHY3RWdsalpMMXFOcUFGYlhBQUhW?=
 =?utf-8?B?cUMwc1piWUNnOHZWR2hDZkJVZ25VNzJCemVZU0JuUHJHL3hGM0xDOENqMTE0?=
 =?utf-8?Q?mFUX4flR6rQ2Ffhg18ZiWYQIplEfPcS2u0rA/trHeOJ+h?=
x-ms-exchange-antispam-messagedata-1: h87djrpUnaK9wjUePFWDSVSOxaXYZyGl5p0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC6AAE4C72DC9408D1F66877C1040F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lZIZv0/t50PggZsXUr1OKPrNTvQtEH20fiR3AmyU0Aeo5Eeih3ZodqSCNn6qz1zx/uYXT+aEkKaGkLrmKD6tRucB3XX0qQGk0vdegp/xwE8xwxu6L9HwLtjrUMGVc5m4vLyMHKb9fwyO5JGu4ZxNBLyePTKJrDhL7vmgaPJSnR9weENZYdxA6ydPbJHcnmQVY2DqsTa/KL055cK/aHRpT6VbLItS+jfOvACZ5LtabtTa0pj6uRxKwERX8OtxcRIFAV16pd2pF687H3i/adllTttfv5JP+cPngBzpyfpwRxVzZn6vqa8lpJ1AHHFEEH8xxST1Bj5gZeBzo1L5Vfhp7g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ez7RjHf6tZlyucyfFMTP6qHisDVZgY0Z5xPsha16d6H9BmwId5KTNlpjyTCxgcm63dkCC2NI8GjLHKrKrH+kVvHUZRlLiyeZtepiENJXwcCtmPuopt0xewjDbWXhMYRxVLMRqIVYjVapz9vAA/pHrPDVqqanSFr3Pa8n/9vqlnViUCjlntgb7YTyaw+mlvMjLn4S74HWbS8NQh5Q2Hs3btXE9EA2Srpw9kpT6xCcml/Le+XaMUO8TF2a6eVGtu/im+wpcUkh528H4eM6CXgT4MhphbyAsT5RQKbA3mEacEb4BrslSbXQsr73bUxzzrl/UTvkahy1L0t37kMtnH7NgpT1aEyIXFCUrhzE9uwZEMXfHAU85nJpwv5053sl04T8YnLnZ1bG22EtI5ow94JlSnZUwAcw+DXl4EwKBODI6ugWLD70qgBifqj6UJQlQjtEMiEeOIstXk02hoMZcaqlJ+Up26RWZV9tUW9M7cNY5vakDxb+uuOvJrHNU26LrLAqgP8043RdK0ApgzPCLZafXZFxhLcgV1os6M1cSHcWpqpjbD/JDSvBW4K9e2SPOxoFBAQTlrSU7tIDCxFm4/UdoI1UJH7iYn1Sc9TPgJ3TV/RDV8AGXDKHBjInb7CS5iLu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfad26c7-3949-4b65-86f4-08df490187cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 01:31:43.1212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x04dqSxNn5gjwGyBcfNRzNWyaZzhYGjlSPItK4VeVEE0PGkaLYVoimqz3sVz36HJqvdK8zKBxZZ9eTk3GnpZlAVKVhU41xDdBsj6co4e4LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8270
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTEyIGF0IDE3OjA2IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQWRkIE1TVEFUVVNfTVBFTFAgaW4gdGhlIHdyaXRlIG1hc2sgaW5zaWRlIHdy
aXRlX21zdGF0dXNoKCkuDQo+IA0KPiBGaXhlczogNDkyM2Y2NzJlM2Q3ICgidGFyZ2V0L3Jpc2N2
OiBJbnRyb2R1Y2UgZWxwIHN0YXRlIGFuZCBlbmFibGluZw0KPiBjb250cm9scyBmb3IgemljZmls
cCIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93
b3JrX2l0ZW1zLzQyMjANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEN
Cj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4g
LS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDUgKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2MzIvc3lzdGVtL21lc29uLmJ1
aWxkwqDCoMKgIHzCoCA3ICsrKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2MzIvdGVzdC1tc3RhdHVz
aC1tcGVscC5TIHwgNDINCj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90
Y2cvcmlzY3YzMi90ZXN0LW1zdGF0dXNoLW1wZWxwLlMNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBpbmRleCBhZjQ0
NGUzZTZmLi5lNzM0NTVkMDIxIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5j
DQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gQEAgLTIxNTUsNiArMjE1NSwxMSBA
QCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24NCj4gd3JpdGVfbXN0YXR1c2goQ1BVUklTQ1ZTdGF0ZSAq
ZW52LCBpbnQgY3Nybm8sDQo+IMKgwqDCoMKgIHVpbnQ2NF90IHZhbGggPSAodWludDY0X3QpdmFs
IDw8IDMyOw0KPiDCoMKgwqDCoCB1aW50NjRfdCBtYXNrID0gcmlzY3ZfaGFzX2V4dChlbnYsIFJW
SCkgPyBNU1RBVFVTX01QViB8DQo+IE1TVEFUVVNfR1ZBIDogMDsNCj4gwqANCj4gK8KgwqDCoCAv
KiBJZiBjZmkgbHAgZXh0ZW5zaW9uIGlzIGF2YWlsYWJsZSwgdGhlbiBhcHBseSBjZmkgbHAgbWFz
ayAqLw0KPiArwqDCoMKgIGlmIChlbnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0X3ppY2ZpbHApIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIG1hc2sgfD0gTVNUQVRVU19NUEVMUDsNCj4gK8KgwqDCoCB9DQo+
ICsNCj4gwqDCoMKgwqAgaWYgKHJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0X3NtZGJsdHJwKSB7DQo+
IMKgwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVTX01EVDsNCj4gwqDCoMKgwqDCoMKgwqDC
oCBpZiAoKHZhbGggJiBNU1RBVFVTX01EVCkgIT0gMCkgew0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMv
dGNnL3Jpc2N2MzIvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGIvdGVzdHMvdGNnL3Jpc2N2MzIvc3lz
dGVtL21lc29uLmJ1aWxkDQo+IGluZGV4IDExN2FlNmZiY2UuLjQxNWExYzIxMmQgMTAwNjQ0DQo+
IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjMyL3N5c3RlbS9tZXNvbi5idWlsZA0KPiArKysgYi90ZXN0
cy90Y2cvcmlzY3YzMi9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gQEAgLTIyLDYgKzIyLDEzIEBAIHRl
c3RzICs9IHsNCj4gwqDCoCB9LA0KPiDCoH0NCj4gwqANCj4gK3Rlc3RzICs9IHsNCj4gK8KgICd0
ZXN0LW1zdGF0dXNoLW1wZWxwLlMnOiB7DQo+ICvCoMKgwqAgJ2NmbGFncyc6IGNmbGFncywNCj4g
K8KgwqDCoCAncWVtdV9hcmdzJzogWyctY3B1JywgJ21heCcsIHFlbXVfYXJnc10sDQo+ICvCoCB9
LA0KPiArfQ0KPiArDQo+IMKgaWYgJ3FlbXUtc3lzdGVtLXJpc2N2MzInIGluIGVtdWxhdG9ycw0K
PiDCoMKgIHRjZ190ZXN0cyArPSB7DQo+IMKgwqDCoMKgICdyaXNjdjMyLXNvZnRtbXUnOiB7DQo+
IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3YzMi90ZXN0LW1zdGF0dXNoLW1wZWxwLlMNCj4g
Yi90ZXN0cy90Y2cvcmlzY3YzMi90ZXN0LW1zdGF0dXNoLW1wZWxwLlMNCj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMC4uZjcwYjRkZmMzMg0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjMyL3Rlc3QtbXN0YXR1c2gtbXBlbHAuUw0KPiBAQCAt
MCwwICsxLDQyIEBADQo+ICsvKg0KPiArICogVGVzdCB0aGF0IG1zdGF0dXNoLk1QRUxQIGlzIHdy
aXRhYmxlIChHaXRsYWIgNDIyMCkuDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChjKSBRdWFsY29t
bSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cw0KPiBzdWJzaWRpYXJpZXMuDQo+ICsgKiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4g
KyNkZWZpbmUgTVNUQVRVU0hfTVBFTFAgMHgyMDANCj4gKw0KPiArLm9wdGlvbiBub3J2Yw0KPiAr
CS50ZXh0DQo+ICsJLmdsb2JhbCBfc3RhcnQNCj4gKw0KPiArX3N0YXJ0Og0KPiArCWxsYQl0MCwg
dHJhcA0KPiArCWNzcncJbXR2ZWMsIHQwDQo+ICsNCj4gKwljc3JyCXMwLCBtc3RhdHVzaA0KPiAr
CWxpCXQwLCBNU1RBVFVTSF9NUEVMUA0KPiArCW9yCXQxLCBzMCwgdDANCj4gKwljc3J3CW1zdGF0
dXNoLCB0MQ0KPiArDQo+ICsJY3NycglzMCwgbXN0YXR1c2gNCj4gKwlhbmQJdDEsIHMwLCB0MA0K
PiArCWJuZQl0MCwgdDEsIF9mYWlsDQo+ICsNCj4gKwlqCV9wYXNzDQo+ICsNCj4gK3RyYXA6DQo+
ICsJaglfZmFpbA0KPiArDQo+ICtfcGFzczoNCj4gKwlsaQl0MCwgMHgxMDAwMDANCj4gKwlsaQl0
MSwgMHg1NTU1CS8qIEZJTklTSEVSX1BBU1MgKi8NCj4gKwlzdwl0MSwgMCh0MCkNCj4gKwlqCS4N
Cj4gKw0KPiArX2ZhaWw6DQo+ICsJbGkJdDAsIDB4MTAwMDAwDQo+ICsJbGkJdDEsIDB4MTMzMzMJ
Lyogc3RhdHVzID0gRklOSVNIRVJfRkFJTCwgY29kZSA9IDENCj4gKi8NCj4gKwlzdwl0MSwgMCh0
MCkNCj4gKwlqCS4NCg==

