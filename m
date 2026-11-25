Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A9606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=mieV8T39;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=p8vPqh2b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW5lA-0003yK-MB; Wed, 25 Nov 2026 00:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7821f5b77=Alistair.Francis@wdc.com>)
 id 1xW5l8-0003y6-Nv; Wed, 25 Nov 2026 00:41:34 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7821f5b77=Alistair.Francis@wdc.com>)
 id 1xW5l6-0002y1-Rb; Wed, 25 Nov 2026 00:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795585301; x=1827121301;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Xyk49Lqt8rtTzCQgkevqztBuCKT9zC18KalbkOtyd1E=;
 b=mieV8T39Vk+vtIQFQT/Q5dUtNBlWp7iNeInQD+wO1gEKGIinhliNGAbK
 BP/B1EoDtgL4beW6bLJR7yA1FN8S8Tfv1EBiTI7D4oyg0xMFQFI8AcdgR
 lNcAE4HRdu/s4xEn0Fk891P0l/b/mIT+6p1XC7sNRMSkOwn0vZE2z6gnQ
 9VQFbQSYFNZ9S1k5u+a/8ahyQUKa/+u30OwDGSnpkXNmGl/mpwm/x3Fnx
 9wLGTZAZLvsjsES3HrG/GezZR1ARkno+xms0xFtzztckkJXpt4xSNZx60
 GHu0cVdmLTBA3FPDIJXORta6wQMf0QalUZwKDt19o3l21HN7Sc3MpMJw3 Q==;
X-CSE-ConnectionGUID: 1bGLNRo1QJWJtytgFV6osA==
X-CSE-MsgGUID: +OTGJK30T3qs0HXA7vjcMw==
X-IronPort-AV: E=Sophos;i="6.27,232,1786982400"; d="scan'208";a="161712728"
Received: from mail-westusazon11012034.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.34])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Nov 2026 13:41:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEao4nwvGmigtkKnUUOX9sFFvCB4TTNSPtVSd18Wqv0zxS8beDLRzRev8KlZvJYMwRXdByCBfe0lYhzC2d7qo49h9XkBS8f0b/y7eP9NPZMPlD7DSHBNsLyTNRPz8JS4S08dkAydN05yTzdvBBnRWkEI1tjC1qH6t1VjfRX6FBnTMVvXTVgKY1ZUvhPI2bSFqcFPe5/E09VKuQi0YvvitlqLJkw6aoomgbM7ciNphfVvTjnizFqNogiiMAgYF2WPDT2EWILCIQQ/Il94Kh+D6z22brPR+yIaX3MNQsViX/NFhpJMzXMOZCU+YBHbu8yVwM+B/HGA771Sb5ssZqvJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyk49Lqt8rtTzCQgkevqztBuCKT9zC18KalbkOtyd1E=;
 b=Gl6DfABHdYI6e+oaw64WtP52B1sDG/ssFQYLhSE4qk41QkP7fKbGdKihvXuGrw5z+71jYkkMnrHxX8yrBgurmz4iHeaR49a/IuKqiH18z+ILeFfFVCygPmat9OqmrdfnY4Nhsu0LK3OU+9YBhDcg1JknOSvcyn6T/ya1XHts6K5896Gb0HuF8srbD3F5KHjGDm/hCGH/9jJCKaSgsNohIXkHpiwIR3GiEisYJmtoiB64R4XCVWpmWHRXz+tJ5ij7kPPkjUf568EnIxOH7njYLS4XRmrUCYDbdhaJ6FvpLiAFIvU7DehXnG1sEJFmiOmM8NwLzNM/zcfYX4pfkh+tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyk49Lqt8rtTzCQgkevqztBuCKT9zC18KalbkOtyd1E=;
 b=p8vPqh2bchbuPMf+3oEzavIqSvr33/AmPhfQbXWbOsFEK04jkN5xRhbt5WFp3u5Q+Fco2RZzSJwupp9tbb2NfR5DjePniDJMr+LCy8SSN/pqQqWm/awhELoB7cUtBujpA2UaeGDGciVBiDXrhsta6HS3AiwPDPDg7vU3qHthX/w=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ2PR04MB8511.namprd04.prod.outlook.com (2603:10b6:a03:4ff::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 05:41:28 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 05:41:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "lyndra@linux.alibaba.com" <lyndra@linux.alibaba.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
Thread-Topic: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
Thread-Index: AQHdeHQ4jIISyLoXQ0eJhazphV17nbc+TlAA
Date: Wed, 25 Nov 2026 05:41:27 +0000
Message-ID: <30cab26388210f6739daa16645b7c27c7d97d59b.camel@wdc.com>
References: <20261119222036.71913-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261119222036.71913-1-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ2PR04MB8511:EE_
x-ms-office365-filtering-correlation-id: c6c90e18-f714-476a-2577-08df4ab6bfec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|38070700021|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: vzHEI92LhNYT972YQaMMC2skISLx8EQd+Sf/z7W6RQvrxRYlfDm5cl9rPMoix91/1puVcdNnLjGlb+mKHzN2TESbc2osJgRbR8Wct6Ssa8I92f5C6Cte47X3/mVTUET8KHV/WMmbrRFmTODn5oFlSDqxWWylRQ4FbSbU/lY5FAepURTQlHa6AIJ2LIm1h4AKqmHb4rUFH999rb8JLL2D+GLWWo65XNNSL6kx7MOQJNLF5Jgf9ZpDEHqb1dupJ8DRw+uyBnm83G7mDr09vEVKM732MRrlDgjkKrX+9dCgE4I9TynQvB+fFrpEEfwzNGdGw6b1fQSPye9GYWjBfeZgxrofoPA8/BJAeGeJ4cONFo7AAxrBl9o4g7FS+rjC45acQBY4rJaqw3rSfoNmon1FEdjySEhv7bJYDhDKes9C0B6fMV4Oij/O/7sCzpgi7saNn4qB4qAfwIFFFjAqBK8zzS8azhbMJJCYp1R6bPr1oc8BVAUpJN+x1uAjyyAC+BlS00Szhq3mwyMwU3HYFUL0pUVUc1f4fG/bKC5MUuJTJXahyJSvkIxfgbTdjxG/magJ7zcIUvJ9zBRWzZntp/Ja1nvT78d/Uzc3pkZafQz6ttpChKwd1T09ij95zZukJOYmXAlhZGHYSOaT53UJRmwxOK1hjooxcJJ2pJP5UF46K+lBM1rA9ney06xtlhWhspCXlTzz7z+J+xHPRFgFG1YccSHuXJlt0jXNNs+KvOOWG+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(38070700021)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTA2eXlldVZKS0NNbW9mc1VTdnpUYlRoSG9CRlgvUzQ2NWN1QUhqcFdpTGlP?=
 =?utf-8?B?MWhzcHBwU0QvVWFmZGNFS1RYcVZhRzNXNlEwa015NmtCY0IyZmovTEl1ZU5t?=
 =?utf-8?B?ZGgraWVCcHFLRFp1K2I4MEhBdS9iLzZXWk8xeU9hRFhKMUs1TDdPZGxUeEtp?=
 =?utf-8?B?VzFvTWRoc0dZZ04zeEFnTGdrVW1kVWJaclU3aXhHOTJGM3ZlcW5iWWFaSWM4?=
 =?utf-8?B?eDdNamp2UEJuMEhud1VVSHJmaHlZV1A0MTVpbE9ETkdlZ0NEbDhVM0YzYlRu?=
 =?utf-8?B?OFo0WnVQcmtYR2VVNWFDODUrbW5PdFVrejZ6RzBWazVpc0gwc01mM29CZTlK?=
 =?utf-8?B?aDVpZ3J4bzFJa3BQampWNnN5NVBwSjBpMmxqMFkvUmYwZXZNWjhKOEFsaVpt?=
 =?utf-8?B?WDloOTZBRVdHZngxSlV2eWtuTGdHOHBoVHBISHNhOHVKanIweEdLeXNvbXd4?=
 =?utf-8?B?MTE4Y0tMaWRiSmRNeW5kK0VycTFYSEg2T0NYYlptaklidC9NQmNJZGVKVmZr?=
 =?utf-8?B?SnRiRjlxdnBmNTc5RTNjU0NZUjY2eDdqT3BtWStWMXpuOHZXS3QrWWtlRndo?=
 =?utf-8?B?YjY0dHpaUlk1c2J1YUc3WTBhNlF6REFjbjByQ1hZZlg4eXI5YlBOQWR0Umtz?=
 =?utf-8?B?SGxJK3p3aDVGSlJyVWwxemIzQXJieVBIcEw5dVNJVnl6Wk43cG9SVXpJZ0lu?=
 =?utf-8?B?bnd4SDhLbjFROU9sYjNJRGpmNERYcDN4dkxhNUpRVkoyY3dpTElvNGVEV2ZF?=
 =?utf-8?B?WHhlcmtQTWYrY0NEMlZlQk5YQ3p6dFh0UXczb1ZwYW92M0FjazZmL0pSdW5p?=
 =?utf-8?B?R2FUSTROYnhXRWE3TnRDek5nZFkzSGxyMnNBTGtROHE0eXhkWTcxTlNZYkJD?=
 =?utf-8?B?dWgvNWp4TytuUFA0Rm5hYWV0dzNCODNnMG8yRko2TGZsOFZnRkQ5Mis3R1V1?=
 =?utf-8?B?RFlBK2RhSExMSUd5VU1MU3Frc0RQYnhsYmlzT0xlRXNNRUdhUHRVdHVCdGk5?=
 =?utf-8?B?OVZYY24zdlRSZDM5WnlQNG1CQnFwaEE0VVZJRnJGNm5MazVEK3dMaDF3dGRB?=
 =?utf-8?B?VnhqQWtRQmROTDdpektVQSt4c3d2OEE3bUlXMlNubTc5TlJFcGhRZ0RtbGQ2?=
 =?utf-8?B?akRWU2JEUnZ0SE5kNmNoUHhXNUNDUjYraXNGUlR6RUxzK1ZleUtCY1lQbnQ2?=
 =?utf-8?B?TnhBb1R2UWFPc1VaaUFpRHNrczhKOXdyVHVJSVU2Y2c5dTZVNXEwakV2UnRr?=
 =?utf-8?B?WG9yMjIxbVlOcGJ0cTYra29RZ3daYUs4bTB6NUI2Z1BCaGxWd0NOU0ludTdR?=
 =?utf-8?B?ZkpwUUlNS2YwWjcveGYvRzhDVmVJVVpVdGwxbDN3NU9LZE1QOXRqK2VUNVVY?=
 =?utf-8?B?NkN5OVJwQ2w3MmFqOHQxeUovdnFnaW5FQkhwMHcwNFJPTmVYOG12d3IrSStG?=
 =?utf-8?B?RmhWdFNaSXZyTlZFTzJYYldDTi9xcG9TdlVocnkwZmhLeVF4Z3F3NGR5U3pk?=
 =?utf-8?B?bVArcS9saHlXdmtJaDhESGN1Q3hITkQ4UFhXcmFhd2JIVUE5bFZjOHR6YStD?=
 =?utf-8?B?R0k5dFB2bHhuZWd1T2lHMHhiRU1xM1piZEFnSllzdUxvL1FhNE9zZ2dFNElZ?=
 =?utf-8?B?clU4RkIxem9uU3kyaUlVaVdVY29ic3dGL0hVNDV1RndScGRPeHB4VWhMVTdT?=
 =?utf-8?B?bkVCRUhtdnR6K2N6aHdTa3dLc3VockJtRmprbjlLckZWd1FEY284WjIxdFJy?=
 =?utf-8?B?OVlxWmxqSVFzeG9EVTFVQlNnQjFCdXVsbTc4elZ5WHRrYUREN1MwZ1krRTVX?=
 =?utf-8?B?ekZydmZHaGRSMGJxTG5ZL0RiOVBSa2J6TjJvd21IY2x4QlRtbE1USUhvOG9B?=
 =?utf-8?B?OVdwZEpxY0lQMEZOTDVBanllaDJTT21lVER2M3ZDa3d3VzdpTlJHK0RId0x1?=
 =?utf-8?B?MHJEWGRVYjFzYkhEdCt2QkRwYkhQOFVqZVJDVXZXUEw2NmR4bnZubHluMjhw?=
 =?utf-8?B?ZmwxVENyVG1QRm5YdnRTOHlZQzB2QTdWWWxzWkg2ZkJDdHpkbHY5aEhpVVpq?=
 =?utf-8?B?d1lKbnZiOU4zYlZNaHY4RjRUYUlLaDFIWGJKYlVpOCtzcENEWDdUQXM0ckg4?=
 =?utf-8?B?Sks2U0FxSUZnZHNSbXRvZkxNZkd1dEk3RmVmc0xobFZGeTJHRG1iekxrVzh4?=
 =?utf-8?B?dHBVYjljMldYWFdnaTJ3cHBocFNXQ1NZa0hEc2x6NDRXcUQ5TlUxNEx1VHg4?=
 =?utf-8?B?RG83ajBLUTJvbDIzcFc3RWxvRDV0RHJ1cUFZWmZKVlI2YUxiL0lNeTBUU281?=
 =?utf-8?B?YnVYcHAyOFNDWjBHNEtra0hPTEd6aVBPM3NFbVNNUVQycE05YjB1OTcwK2lS?=
 =?utf-8?Q?cAL+OFgC0+asRMH5qvfhSDphZGuAePGbnEjFSgY4tpKZg?=
x-ms-exchange-antispam-messagedata-1: dwiR8SHnryKrpgZ09ZrIR1IqBwWNWuYnY0c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA72A59EC255D4E822B9ACD441EE2A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: chfWp19OHqBdVYimzP3VQYedSPB1G2VJoyv8iMn8Q9du7zn5gqiQpPxLC2Jtr00eleZ7Z0zGQDFEuCE8y6AlEcybahI3dYq0kSnTI0dYDekT6h3bhpHatUcX9Blv4cvENnTIdtcWKLrS9f5jYSnbqLtIivXa5mo/G9c+ufgY3aGF7HNp8u0wFO0sbtwtwjBcl8/3k883iZvqwL423kjK02pzQQRPPqJixAi3chCFto3/1scWz42mvGu4t+zZcN/I6HqpbN6L9mnqrklJTzsgqm4Lq6gCiLhm7fQRyZqKPtLMdB5Xqivxd+Ylm1v/jysVz4ykkTM7c0QerjaTdLgTaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ulf6THSpTlWYDUupAW88ipds5ouB1iYTw8Q4Zdy+OKy0hGbcVd+R06cq/GAkMj8Y/Cb1FHz4mAG2UW0WMVylPuZKP1RM9gnt2Ihd14/baHfkHln7wT+oPKSfQzPbj1kEK8ykuUCrp4QpvS7RiKLmCBlm3uuw4lgLqbNbnsJor3PkZlhy4OrlYc7CGTEelDAq7N+t2j5Dt45fDb4EK7jVUF1pHWtEdlbm1VwDwTFU5Fe5Zvmympek1q4IkTPwckeM1v2cL50bRTPEh5SFIYg20sEMkTrgYmFtla0cti+ttFFmmpsgRY/dUqahqTqAtl/1QiELuTTxt8S+vMqnD9t277pzZUlqMQ7sKP4PESO2UIKTP3vQtwyrR681kDAJxa/bq3xrYn/pXs6Qkht9YPo4XWDNELC4jmUPDeQ/rl3Wn3C80tSmy6C9Jvw+hZ2kqoJf+V0jewdF+pQgsEj/MVldcmMNnBVOzH6FeZ0CsUoa1D0T9IpgQ4adsMQ2/2khChD46iOcPFND+BHg8BwSymTrT18/i6fzfusFVDY7NjbtqZeqF0M7GsaZWbkdVNJJCAGzTNebzX4aoFvOFxtzS/OshhBI4lw7EfcZSedrQwZhW0prJkXGT0S6mZehWndi/3po
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c90e18-f714-476a-2577-08df4ab6bfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 05:41:27.3423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7auScYyKLMr0uwexq7JGsOASrofrY8mmNB4ehnB9QH36NKoc56Scp8ekLCawTGtnej8ucUB8jUVgQBpKmNmzJK9pHeWeZgJkyS3E2U2Tok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8511
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7821f5b77=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTE5IGF0IDIzOjIwICswMTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gVGhlIGN5Y2xlIGNvdW50ZXIgdXNlcyBpY291bnRfZ2V0KCksIHdoaWNoIGFs
cmVhZHkgcmV0dXJucyB2aXJ0dWFsDQo+IHRpbWUgaW4gbmFub3NlY29uZHMuIFRoZSBQTVUgb3Zl
cmZsb3cgaGVscGVyIGFwcGxpZXMgaWNvdW50X3RvX25zKCkNCj4gdG8gYm90aCBjeWNsZSBhbmQg
aW5zdHJ1Y3Rpb24gY291bnRlcnMsIHNvIGN5Y2xlIG92ZXJmbG93IHRpbWVycw0KPiBhcmUgZGVs
YXllZCBieSB0aGUgaWNvdW50IHNoaWZ0Lg0KPiANCj4gUGFzcyB0aGUgY291bnRlciBjb250ZXh0
IHRvIHRoZSBoZWxwZXIgYW5kIHNjYWxlIG9ubHkgaW5zdHJ1Y3Rpb24NCj4gY291bnRzLg0KPiAN
Cj4gRml4ZXM6IGIyZDdhN2M3ZTRlMzAgKCJ0YXJnZXQvcmlzY3Y6IEltcGxlbWVudCBwcml2aWxl
Z2UgbW9kZQ0KPiBmaWx0ZXJpbmcgZm9yIGN5Y2xlL2luc3RyZXQiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+DQoNClJl
dmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoN
CkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYyB8IDEyICsrKysr
KysrLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYyBiL3RhcmdldC9y
aXNjdi90Y2cvcG11LmMNCj4gaW5kZXggMDE2NWZhZjA2Yjg2Li5jZDRkZTljZGUwYWIgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvcG11LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3Rj
Zy9wbXUuYw0KPiBAQCAtMjgxLDEyICsyODEsMTUgQEAgc3RhdGljIGdib29sZWFuIHBtdV9yZW1v
dmVfZXZlbnRfbWFwKGdwb2ludGVyDQo+IGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+IMKgwqDCoMKg
IHJldHVybiAoR1BPSU5URVJfVE9fVUlOVCh2YWx1ZSkgPT0gR1BPSU5URVJfVE9fVUlOVCh1ZGF0
YSkpID8NCj4gdHJ1ZSA6IGZhbHNlOw0KPiDCoH0NCj4gwqANCj4gLXN0YXRpYyBpbnQ2NF90IHBt
dV9pY291bnRfdGlja3NfdG9fbnMoaW50NjRfdCB2YWx1ZSkNCj4gK3N0YXRpYyBpbnQ2NF90IHBt
dV9pY291bnRfdGlja3NfdG9fbnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJfdA0KPiBjdHJf
aWR4LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50NjRfdCB2YWx1ZSkNCj4gwqB7DQo+IMKgwqDC
oMKgIGludDY0X3QgcmV0ID0gMDsNCj4gwqANCj4gwqDCoMKgwqAgaWYgKGljb3VudF9lbmFibGVk
KCkpIHsNCj4gLcKgwqDCoMKgwqDCoMKgIHJldCA9IGljb3VudF90b19ucyh2YWx1ZSk7DQo+ICvC
oMKgwqDCoMKgwqDCoCAvKiBUaGUgY3ljbGUgY291bnRlciBjb3VudHMgbnMgb2YgdmlydHVhbCB0
aW1lLCBzZWUNCj4gaWNvdW50X2dldCgpICovDQo+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSByaXNj
dl9wbXVfY3RyX21vbml0b3JfaW5zdHJ1Y3Rpb25zKGVudiwgY3RyX2lkeCkgPw0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWNvdW50X3RvX25zKHZhbHVlKSA6IHZhbHVlOw0KPiDCoMKg
wqDCoCB9IGVsc2Ugew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IChOQU5PU0VDT05EU19QRVJf
U0VDT05EIC8gUklTQ1ZfVElNRUJBU0VfRlJFUSkgKg0KPiB2YWx1ZTsNCj4gwqDCoMKgwqAgfQ0K
PiBAQCAtNDU2LDggKzQ1OSw5IEBAIGludCByaXNjdl9wbXVfc2V0dXBfdGltZXIoQ1BVUklTQ1ZT
dGF0ZSAqZW52LA0KPiB1aW50NjRfdCB2YWx1ZSwgdWludDMyX3QgY3RyX2lkeCkNCj4gwqANCj4g
wqDCoMKgwqAgaWYgKHJpc2N2X3BtdV9jdHJfbW9uaXRvcl9jeWNsZXMoZW52LCBjdHJfaWR4KSB8
fA0KPiDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2X3BtdV9jdHJfbW9uaXRvcl9pbnN0cnVjdGlvbnMo
ZW52LCBjdHJfaWR4KSkgew0KPiAtwqDCoMKgwqDCoMKgwqAgb3ZlcmZsb3dfbnMgPQ0KPiBwbXVf
aWNvdW50X3RpY2tzX3RvX25zKChpbnQ2NF90KW92ZXJmbG93X2RlbHRhKTsNCj4gLcKgwqDCoMKg
wqDCoMKgIG92ZXJmbG93X2xlZnQgPSBwbXVfaWNvdW50X3RpY2tzX3RvX25zKG92ZXJmbG93X2xl
ZnQpIDsNCj4gK8KgwqDCoMKgwqDCoMKgIG92ZXJmbG93X25zID0gcG11X2ljb3VudF90aWNrc190
b19ucyhlbnYsIGN0cl9pZHgsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+
IChpbnQ2NF90KW92ZXJmbG93X2RlbHRhKTsNCj4gK8KgwqDCoMKgwqDCoMKgIG92ZXJmbG93X2xl
ZnQgPSBwbXVfaWNvdW50X3RpY2tzX3RvX25zKGVudiwgY3RyX2lkeCwNCj4gb3ZlcmZsb3dfbGVm
dCk7DQo+IMKgwqDCoMKgIH0gZWxzZSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC0xOw0K
PiDCoMKgwqDCoCB9DQo=

