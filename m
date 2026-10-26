Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413EF606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iLHhUbH4;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=a5p1rnfp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLA6Y-0007HK-7y; Sun, 25 Oct 2026 22:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLA6W-0007H6-Ko; Sun, 25 Oct 2026 22:06:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLA6U-0006yL-Hg; Sun, 25 Oct 2026 22:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792980387; x=1824516387;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GMfiXrYVjUhE472RVtJwwm+HjoC1yctJsdzJkzC2+Ng=;
 b=iLHhUbH4/rEdbLXU2eN7tJhbMsvQIhhvOhi0rDTrDju9K3Olj22r+9d4
 43weUhJKEFCTD6AdydqEvRWk6w20hEzuEwZE1CjwwSGqJbb7CjWKyVeMV
 KYORHdBOMYx4Oae29RLJSrKaOiitV+bscoFoZM5SiTH2GanYftEyG3kyp
 0LVuu/Z5WSEfApl6ckhAhju3zH3venYe+JiwmzjJ9T0497YB0mdkGS6Yd
 IVX+euTUlFP4qVk5V+FDbxKSERLRGTz1epOV5CtIZz8+wPLQy8tI5vH0p
 xNKOtJxc0S1C7DiOMnLRCOkVplTLCkdSeJpTLenP11oRG3fxvygo3+KIV w==;
X-CSE-ConnectionGUID: 4rOT1dpzRLmDss2wK1BXDA==
X-CSE-MsgGUID: K8ZPHW2+TWa/einq258ivA==
X-IronPort-AV: E=Sophos;i="6.27,178,1786982400"; d="scan'208";a="158982938"
Received: from mail-westus3azon11010053.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.53])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 10:06:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koPR3ubrP15sL2qeJwWMeV7atTaSf3n2ZHm9i7HDxluRUwhEKqv6YBPnl+ZID2oejg7aX3MaCPq7WXGm4bWCRXVl7JM/x2m7p4TXM1vQlTujlWx8ZPrtMS3NWWdga0YPzOALLLNRnnvFXHXrg9NskfM3JyXJzO9OpuMYtBmlER6NDFyZZoCjk8uxjKC1BXPZHjIzQ2oodtd3FB0340LNoYaINDKeP/+Vn6X60yQ6DyrNqBHIvhVbgRHY0ZlAmuxGDbfXIyv1jRU9byNzvxKZSTFILz3iavyR+EbTKxA5qLB1T5MEmqy0++rpQ9N7rhWRqBiZo6lmRFomFZA8ZZYrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMfiXrYVjUhE472RVtJwwm+HjoC1yctJsdzJkzC2+Ng=;
 b=EiIcNu3S1zrU3ThiL7RYtKKhodJ5K4PvxOWS1pLBN0kIIhagXtgEqRtY4RvyascOySU+9qdfwR0RqOEtRedg/aVMXWDdauyBzv4wp+selijJ6TlLCuUmUPITeRDyc4JWavKbN5nSJ0400meHLmvxrBR+rl+de3DPYhcWSbBXY8mvFUnY0Ez2Jk/wTZK4QvfJEpGxe4EyhvHrw041VeTidsSHm/q3yL93kbWv++CsqeT+SDAANKXwFQmowtGaTAtAxL0KiX5Ze0QxgFmnyB0zaAWaGhLvyD91lAJxsZff/sFn63PhMdVPO0xXqNTTparWLBsMwvzpMzSSjn6GHhbYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMfiXrYVjUhE472RVtJwwm+HjoC1yctJsdzJkzC2+Ng=;
 b=a5p1rnfpmACkx/WZrbrkUM6JK6Bmduq9ASUDxp2uLQi7Xue1xZAcA2fR2MXQ4l1nY/syS9Zbgo2D2lMy4I5RUsnR/iZQS1LfzyKtoUktmzLMyH/1+tXSvII4zFVYTd2H6VSggDdsYQ4UkVXoOQWhDpt07nMpTF46zgQlgHHQbOc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SAWPR04MB997320.namprd04.prod.outlook.com (2603:10b6:806:54e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Mon, 26 Oct
 2026 02:06:23 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:06:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "fangyu.yu@linux.alibaba.com" <fangyu.yu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/csr.c: allow regular mstatus MPV/GVA writes
 again
Thread-Topic: [PATCH] target/riscv/csr.c: allow regular mstatus MPV/GVA writes
 again
Thread-Index: AQHdY4U+XvKz2NUqZEKDOxNmpmirnLcPFiQA
Date: Mon, 26 Oct 2026 02:06:22 +0000
Message-ID: <3c5a583078cfb404e7c080c9c4a484f382189935.camel@wdc.com>
References: <20261024065930.26750-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261024065930.26750-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SAWPR04MB997320:EE_
x-ms-office365-filtering-correlation-id: 1714a77f-d3c3-4117-63b1-08df3305bbdf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|366016|1800799024|10070799003|38070700021|11063799006|56012099006|261022105027099003|261021123027099003|261009223027099003|10067099003|261021121427099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 6gKngri40ytMKWbcBOyq+jXzPwo7SI+3YjUwBgqsJeftoq8TLogF6d9Z+0pCm1lSodKuIm7eAvQyr/ZrDRZQwQBEbWxhPTzoKHjT5//OU+Ga8jOLSQN4W9KVTAMyObomy+fVNFuDFiInfw4BWld8u3BpW4DmJU0VMak+sMX2irCX+fBsvKWmynErGfKu9nX/P/IhmXwTtFbFQw2CwcGZNjY3HEVgcZHnpWGf82SvgwzUp2f5XZ4G95WO79A83ewxqCgSEbdoT6LKOLGDBs5t1Tk61QHzhn3gdbmQNYLhpsJwgtalr/OYuXi7YHfYT7UUUsYs7CDBMk3e+zAC0j4WDQje86ygGzaQglorXT+ruHVJ3SdGeGjKwWjczESvVCUAoTWrKWWd+WpoFFA8OXmFVvSp6w3mRwg5RJGef9oQHqLtwyxeUjL4yvhBKbWIYQaZCnzUkB1Be9R/fc3kAvRI+Iss5K85OXBpdD8GsYRyu6xEtwt9CJFFbpbwAGfAfufLAmcLG4G5JYvl5z4fkUMcZ4NRl0ESyIRUlJCImBqpbOY0rBBr5axzs4hKu2owOdgpD3zlttP8s1kgLkAiw/Prmpahp0ssl++N4wJOujf1lE0h1pe+I5+WYrsv+i491uqEEMZRxpC+gpiuqP0ZWj2gy7MedsWfqleD2pgqwrUsYUA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(10070799003)(38070700021)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(10067099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzNmcE9IRkh4UWE1U3F6OGNOeG5HeURrVU9sQTBYa1pnaVp6SFJ1SVRtcWFB?=
 =?utf-8?B?TUxUUUNiVlRrMXFldkRHV2c4Y3h1Q0t0SGZGc1FrUzNFT0FuMmZLdWQxZmJy?=
 =?utf-8?B?UjlaU010cUlKV2RtODRYbm9NTlZHYkdKeXNHRUxOdTB5cDk4WFVWd1o0OXls?=
 =?utf-8?B?VWhTZnY4enlObTdUK2ozWVVTZDRIMSs4WjJQejdkNHZiOWRTRHlvcHVCb1h6?=
 =?utf-8?B?cndEek81TWFkUHBGZW9kMXZtWnREb2FlRzdXekFJRzNCQ0h0ZG1vaTNDWEc4?=
 =?utf-8?B?RXlSQVFhYy9LZytEeEthaUlxME40bTFXUmt0V0txSlJVOTJldEhjcHAzVE0z?=
 =?utf-8?B?UGtRUmdpZHNxVnpxTk1GbmJGY21PWXNLQisxaFRrL2NsNzJPRTB1Rm9yZWl4?=
 =?utf-8?B?TkMzUVZ1ay9hYXZnQys4TlJISlJVMDYwbis0dGhWOTJLYVRKM01FRnhaODRU?=
 =?utf-8?B?K2pNb2ZiSHFSdFNCOTZXVkhCQzN3MWJRMUhsTnN6OUJnbmk2bGZGZkg0NUxH?=
 =?utf-8?B?MEQ1OERUbEdhdG9rMkFENGlYNmMxdjJNS3JGUS9uaThYbCs2OWdiNjBZdDNa?=
 =?utf-8?B?Mm82TWFHR0locGJPMU9SZWpiU2xWNTVDU1poSHNCMXBDNzVJK1k3TEozeVRS?=
 =?utf-8?B?NDMyMHNaUHlUS2tFcEJrZU9QeG5GcjllZ04zTVBPMDB5RmYrU24waEphODJE?=
 =?utf-8?B?dWwyRmVnQXFWeEhIeE1SMHNMQkRnblhLSDBlQXZPZnBXTmlXUlJSdDVsUDdp?=
 =?utf-8?B?M0N5dGhyR05VYnFzVlR6TCs3WmwrU3N0WFdISzA2eVpBdkhpd3A1d2VIT0Js?=
 =?utf-8?B?cm80Z0FMdU41MWdwaDNraXo0emQxR1ZTaGxQdEFrTjI3Yi9yeFJobjNCMkFv?=
 =?utf-8?B?QkdjVDRMV3NvNldyUStlb0NYZ3E5VU9CTVRzdkJMdnNaaHlKcW8vT3RtTzJv?=
 =?utf-8?B?MjlibmQvMmxhOTFTYmRxUlRPeWdBNmVndkJTOVNJdlRoVUkxbnV1VUlCemhj?=
 =?utf-8?B?SDljRkRUMVp5ckZGYlZEblRwKzNOQmNoUEUxMXF1MG5EOTlFRE9uRjkyVkZN?=
 =?utf-8?B?TVV2TUNKdTEwRnp5aDJHN2xqdjVRZWNtaE1wUmFjdllGYzZjZUd0bTd6aUpx?=
 =?utf-8?B?Z1luL2ZSYUhKSnJ2VXNibGY2blRHTFc2aFJ0a1czN1pKVmZhamlrSlJ6c3Rx?=
 =?utf-8?B?dmRrMkFqQjFCT2J4Z2FUZ2dyY3pWRUVDYy9WWUZSczk0YUp0bnkzZGZNOTdx?=
 =?utf-8?B?ZWdrUlFNTU5DYys2clQvUHVYbTh2bUcrWVU3WEVLbU9Md3FIMVgyYVh4NHVk?=
 =?utf-8?B?VTErcW5SUy93SUs4Qi9jM2wzWjBpN3JaMkNwdkFtUUczbi9iNW02eEhweTkv?=
 =?utf-8?B?T2hrcUlPVGg2cmtvVitRQXZNcE9pcXNoN1gvclRRUVNrcUl6NFo2VjRJWnVM?=
 =?utf-8?B?c21EdzhVUEVIUjlaYXhYTW1GYzY4c2lQcnRHalFGcGlMUlBNVGxIZnIxamdm?=
 =?utf-8?B?Lzc4Y3dTZTVLTVJ4NTV1VndESDRyRk9tQ0tBbHE3M0V1YVJLOGEzNm9oOVdZ?=
 =?utf-8?B?SGp6VTJaMlM2dUxoeGtFNEYyRnpjR3NPeGhOUXY5bUkzUUh3dDZIWlhNblBF?=
 =?utf-8?B?TXg1bkxpLys5dHNFSThRYm5Zc29KN1h0cGhTTmNvbFRaWnZRMWpkME9UakVD?=
 =?utf-8?B?bWYzUUUyTUM0L1E1U0xyNUtzdXF5MGp1U2J4OCswNW9RdUJ3a3BVZTF3VVcr?=
 =?utf-8?B?ZkNtSVN6T0E4OFMrbmFVMGF5a1lwaGJCZTVoTDNGSURJeVV6ZElxMXR2WHY1?=
 =?utf-8?B?UmZrV0RTcE1zUkZYdDhKSWc2UGNJWkJHUW1OdXhTeDJiUktoK0FPTkNMMUEr?=
 =?utf-8?B?QXBPUjFYVHlZUXFjb05leTRpM1VoemNrTEl1MlY0UlhlYi94NkI2K1FlVEo4?=
 =?utf-8?B?eTVOekNJbmRRZ3IrNUovcTlmWE1iU1FVZXdVK2VuUTliUDU2RmdhaldFdEEv?=
 =?utf-8?B?Mk54SmM0bXo1d2Yva0p5RDFSYTNhZnU4MUZMTkJQUSsxZCsrRUU4QUxwamdp?=
 =?utf-8?B?WGdPdWo0S3ppeEpoeVA3L3I3dmdxRnFWQkRGMDMwQ3hPczQwWlQ5SzlHRU5C?=
 =?utf-8?B?cG1jK2FSMWlPaGNxZDc1a1puL095Z25QaU5welRUZGFkOTNPa1Y4alUvb1VU?=
 =?utf-8?B?VnExMW5Rbkg2dW1wNzN0UEFGZkh6b25sSkRuYjhaa0sxMmhWZFNDV09TR3Ev?=
 =?utf-8?B?NDhhNGJtTkcwRSs1QTl1ZzV2QkVoN1NsSFlvMS8wYkpNTkNpSkNsQWR3QWhW?=
 =?utf-8?B?azJqMjU0TVFKM3FQalhQaklyM1RVL1QxdkZmNGlRbGJhRENyWlBjWHdPL1BN?=
 =?utf-8?Q?uVtsQnRdTuOqbWtNLlCPsgJ+OvlkeVOC6d0OAgBn4b+zK?=
x-ms-exchange-antispam-messagedata-1: 7jbNQF5gg4dmda+Dezi5+QMBTa1EuiQNJno=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6CE5C45D7AF649B01973206E365739@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: poG3l9Vy9YeMgMTJ3BAio1bLCZGY+d9DLmuESDNN3O4ySJe0jPMsC3DgxMXbbz4gkH9oTwW4HiJ2hgmEqMpChXI7bitOJNkKczIeKcVY5VVW68ntB/mzyZgv0Ait1/EuxpRmgkkJ91eB+eVTd5y3VaySa7+GGoCXJ7x8jSNB8iFd5WHtY/nNaqrVN0+W/VauQsz4PzsU2V1rbW1zxDaQ9oh7ZW5pqsYfHswuSLWX6erwm4Mv47O+t/+VLhK7lfN0GKNjP0tmaWzanv1hrYd3sMoN25qOuCHADqJBegi8pp4iPQ6ABpIm0xktDRQU3jcMgT6oau0mPsOdIu9kXxhy4w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s1e6DEQOIpUT/PFUo+BfdpLq9x6ylmD1HfCg/disD1hMQbmxDQydnQnLIyrt9h1OcaKu/IpiAIw08r5a604A3N3gYW2YlPrIkDUFgYY+cEG0/KVKfyptx9/OkJKONc3U71guznCpJfFyuDKecTQGhdtrZIZcEZj/ZJIm0FV7gB6K5UZahPPzROxq7Q7qOSD0cc0PdBL+2L7C5X1QzmPtLK4Ap3S6mYobr66j2Z724QPZ1NAJsOKpVjPAso6tN6Xl7pP2FGhh0HxK43s7MBIDVHHJKBG/d9snoZ5mC51x2YinuSaRwg/1ro468fuIIMzACoFBggZrG1IK9LjZqle/8prdcQIh4A8826nvWUozwoSseoDLdi8rXFMqykg4hbaE8dkp0h3d51VrbfnEVxuePFBSg8u8AhR2gj8DIVIQWm4gild5zIy2OXfxapqPonU9OzdIr2ZrsoqHqaa0ULa0rwC6yIYdNFEh8p/OJWUvgSMK/cTmdQforsi1ARM/lj59X2cA+K0T9F6slkWZVA3fBl8mb8j0JrqFE6fdZgmtEIpfoYLkiB8VTwZ+/2vFhPGLZVb9CHeOuJ6ulRekQqWzNwgLsTJ5mAgddfJ7wjhHUWQ22gv2y9r+lVYPedAq5ZMu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1714a77f-d3c3-4117-63b1-08df3305bbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 02:06:22.9318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY4dnLdid72imNDSUsmQ/ayKkXO3GAgtheJvX6BHR+xYnaQSvKqCYJqjRLO2fxqnH2AOB3ZXPkKOR2cl7rTYk5LLZqWdyVm+yfhh6G/b71Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR04MB997320
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
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

T24gU2F0LCAyMDI2LTEwLTI0IGF0IDAzOjU5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSW4gY29tbWl0IDE4NjQ1ZjE5NTc4OSB3ZSByZW1vdmVkIHRoZSBjYXBhYmls
aXR5IG9mIE1QVi9HVkEgd3JpdGVzIGJ5DQo+IHNvZnR3YXJlLCBjbGFpbWluZyB0aGF0IHRoZSBJ
U0Egc2F5cyB0aGF0IHRoZXNlIGJpdHMgYXJlIGNoYW5nZWQgYnkNCj4gdGhlDQo+IGltcGxlbWVu
dGF0aW9uIChpLmUuIGhhcmR3YXJlKS4NCj4gDQo+IFRoaXMgZmFjdCBhbG9uZSBjYW4ndCBiZSBp
bnRlcnByZXQgYXMgInNvIHNvZnR3YXJlIGNhbid0IGNoYW5nZQ0KPiB0aGVtIi4NCj4gVGhlIElT
QSBuZXZlciBtZW50aW9ucyB0aGF0LCBhbmQgd2Ugc2hvdWxkbid0IGp1c3QgYXNzdW1lIHJlYWQv
d3JpdGUNCj4gYWNjZXNzZXMgYmFzZWQgb24gd2hldGhlciBoYXJkd2FyZSB1cGRhdGVzIGl0IG9y
IG5vdC7CoCBNLW1vZGUNCj4gc29mdHdhcmUNCj4gY2FuIGRvIHdoYXRldmVyIHRoZXkgd2FudCwg
dW5sZXNzIGNsZWFybHkgc3RhdGVkIGluIHRoZSBJU0EsIGFuZCB0aGF0DQo+IGluY2x1ZGVzIG1z
dGF0dXMgTVBWIGFuZCBHVkEgdXBkYXRlcy4NCj4gDQo+IEFuZCBpbiBmYWN0IGV4aXN0aW5nIHNv
ZnR3YXJlIGlzIHdyaXRpbmcgdG8gdGhlc2UgYml0cywgYXMgcmVwb3J0ZWQNCj4gYnkNCj4gRmFu
Z3l1IGluIFsxXSwgYW5kIHRoYXQgY2hhbmdlIGVuZGVkIHVwIGNhdXNpbmcgcmVhbCBwcm9ibGVt
cyBpbiB0aGUNCj4gZW5kLg0KPiANCj4gUmV2ZXJ0ICJ0YXJnZXQvcmlzY3YvY3NyLmM6IGRvIG5v
dCBhbGxvdyBtc3RhdHVzIE1QVi9HVkEgd3JpdGVzIi4NCj4gDQo+IFRoaXMgcmV2ZXJ0cyBjb21t
aXQgMTg2NDVmMTk1Nzg5NTVlYzVmZjJjNDBjZDJjODc1M2Q2YmM0NjBjMi4NCj4gDQo+IFsxXQ0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMDIyMTIwMTExLjI0Mjk4
LTEtZmFuZ3l1Lnl1QGxpbnV4LmFsaWJhYmEuY29tLw0KPiANCj4gUmVwb3J0ZWQtYnk6IEZhbmd5
dSBZdSA8ZmFuZ3l1Lnl1QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jIHwgNSAr
KysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0L3Jpc2N2
L3RjZy9jc3IuYw0KPiBpbmRleCAxMzY3NWI0YTg0Li5hZjQ0NGUzZTZmIDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMN
Cj4gQEAgLTIxMDgsNiArMjEwOCw5IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbg0KPiB3cml0ZV9t
c3RhdHVzKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoMKgwqDCoCB9DQo+IMKg
DQo+IMKgwqDCoMKgIGlmICh4bCAhPSBNWExfUlYzMiB8fCBlbnYtPmRlYnVnZ2VyKSB7DQo+ICvC
oMKgwqDCoMKgwqDCoCBpZiAocmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkpIHsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVTX01QViB8IE1TVEFUVVNfR1ZBOw0KPiArwqDC
oMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgIGlmICgodmFsICYgTVNUQVRVUzY0X1NY
TCkgIT0gMCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNU1RBVFVTNjRf
U1hMOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsID0gcmlzY3Zfd3JpdGVfdXhsKGVu
diwgdmFsLCBNU1RBVFVTNjRfU1hMKTsNCj4gQEAgLTIxNTAsNyArMjE1Myw3IEBAIHN0YXRpYyBS
SVNDVkV4Y2VwdGlvbg0KPiB3cml0ZV9tc3RhdHVzaChDUFVSSVNDVlN0YXRlICplbnYsIGludCBj
c3JubywNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIHZhbCwgdWludHB0cl90IHJh
KQ0KPiDCoHsNCj4gwqDCoMKgwqAgdWludDY0X3QgdmFsaCA9ICh1aW50NjRfdCl2YWwgPDwgMzI7
DQo+IC3CoMKgwqAgdWludDY0X3QgbWFzayA9IDA7DQo+ICvCoMKgwqAgdWludDY0X3QgbWFzayA9
IHJpc2N2X2hhc19leHQoZW52LCBSVkgpID8gTVNUQVRVU19NUFYgfA0KPiBNU1RBVFVTX0dWQSA6
IDA7DQo+IMKgDQo+IMKgwqDCoMKgIGlmIChyaXNjdl9jcHVfY2ZnKGVudiktPmV4dF9zbWRibHRy
cCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIG1hc2sgfD0gTVNUQVRVU19NRFQ7DQo=

