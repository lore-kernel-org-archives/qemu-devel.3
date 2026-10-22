Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F0606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=TlO45KLS;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=b9aiOoaf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjpU-0008WP-3g; Wed, 21 Oct 2026 23:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJjpM-0008VN-Oa; Wed, 21 Oct 2026 23:50:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJjpJ-00037s-N0; Wed, 21 Oct 2026 23:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792641049; x=1824177049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=B1pkupotmSGP01h3rdQDecYEDC50PYMd2SrE+miP+fc=;
 b=TlO45KLS2tpiatL9GHct+zXEVu4ej2alofh6YM9v2Jq5tYQQNgm2vGkX
 aJx/1IV2Sbo0zUS3TGBtwBKhULltM3NhcFglLz+4aeSlRzfqFuXC91mQr
 pDG9dvUcSe45KSBS+/OiCIgGltTYJX5kUI5ZjOtoN01pOT9/6oD4cVe62
 U90mVkv3tq5e54bCGi/NbQH872wwtliytV0kH9D3Pwm2HonbNxkSprI6T
 mIeRRMlNVGyG36gkur4Ko62YpuYAmj2vq6ltNaPkFacrD/VSmq3qw3Im5
 1v6f1D17b3jCZk3rLw8uak9dblhqkl3RloY9/kzoNd5CHournkSkI1GJP A==;
X-CSE-ConnectionGUID: ooVXkxjsSBqm4N6UfJWt3g==
X-CSE-MsgGUID: ITvUP/Y6RdW3FWrod+ez+Q==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158597600"
Received: from mail-northcentralusazon11012010.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.10])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 11:50:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSuDxv3F//G4nIM7L9e3HAAxxpfcG54pBCo53MURG+xGX4Y/0ThaH8eQ59YmqzJXlGSrxK3oN2h7eEO2Igsc6HZVlSXDEI7Kq6UDs6EpvEwTN/jbY9Q315jUEfYanyullO5xI9JoPDWGeBNM49Lr8PUQHfmmSdjgD3Q7XcKH/8F+G7ffIrlL9HEEWc9B3aondpfJgE7rO7rlBrjkwFPBX/W7/nqRfwgMPRjUzShEBsrK5JHYcRV7+pcJm2jYx2IRmSfReDmcVU3bX0C/oZvJkfiXt9lF5UccQuiH3MtmJg9+hC1G++RnqaORQ1VjxIzGrt0xYWNuTTIRn5any1S1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1pkupotmSGP01h3rdQDecYEDC50PYMd2SrE+miP+fc=;
 b=bpixCLjRoIrtf/fWDY6e+KAZRJJEYZx8miS6sgKHriym+GPZRqr8FeV/IfbUQXqk+PAvlDq8Y++IQXZL6j4UGh9BbJ8pMsPVo5KF+RVRrGB4v2BCZfXZQcM3r2Qg9TorFbUMFXjrQm971W3U0nn1+WJSquCZrfFK4KujN3OoAMvoZx6yIzAf1WLwnLjU850tPnqldUpI9ByTbD29jOSDUOjyBcDsdiSwpaDsBTceyUArAebq7QcL0y3v5jPxMkNLpb90f39xLWtn4mPrWorY9M5weL4VYtxwQrvw7QFaszSBHwepJdrz/i1cAg+R7nDcPHzzyWf4M7GuzfuK7ShAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1pkupotmSGP01h3rdQDecYEDC50PYMd2SrE+miP+fc=;
 b=b9aiOoafwCVq1QaGBWt04dILdLNxcoLsKvdowsWeIvxJTl3B06eUu2dgMuiY4Dge0D19z1gyWZXQi29mSf7ohMkzDDE+j1aTn2aPnmQJNAiLNeoXoapSVZdcrtC5MghFE89+BmjI2VbJbrxnQJdVW1MVHN5A2Xuv1wgCnXgtq3s=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB8359.namprd04.prod.outlook.com (2603:10b6:a03:3d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:50:42 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:50:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "harshit007k@gmail.com" <harshit007k@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: make sstateen1-3 reserved bits read-only
 zero
Thread-Topic: [PATCH] target/riscv: make sstateen1-3 reserved bits read-only
 zero
Thread-Index: AQHdYZN3cIp/Atl0p06zyLNdzFAIRbcI7dOA
Date: Thu, 22 Oct 2026 03:50:34 +0000
Message-ID: <c54b9f7387058281cad1599dc739ab03be84e95b.camel@wdc.com>
References: <20261021193538.80383-1-harshit007k@gmail.com>
In-Reply-To: <20261021193538.80383-1-harshit007k@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB8359:EE_
x-ms-office365-filtering-correlation-id: f84e1308-9247-4139-8e7a-08df2fefa062
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|19092799006|366016|261021123027099003|56012099006|38070700021|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: BZaogKbIYyqRpwm6SWhVT72kbqJ1K6nCCPImOYzCJUZ2SEvyD6Msksq4FCJNvpVyelqmzEYl80HCZjM/bxE+0oWzNl5WuRrXgMtajlAkQwcnrDZnKEwrKeB/e3wtu2iTPLyhIophilEurMDqxCNN26XiJerDP8sX1CDZSIb4JcXq9e1Q91HFOKV4mZfQp5Ke/cvr5b1+ip3aqNeaTUW+DaFZe2EvM6yOFFXG+kYSJEYdXg0ykiCIqycfAP0L5iag0cb4OYZlKi4AQUhN9ScV4vkjC50uBKVIN7iXoj3ox3aqp3fD4WLB4+xHKICFjB25lgPseP4/eHhnHjeQtEcmp1Kinzru2JJExJysFgjEo7wmSE1msNvcgTZGl2OZxdJ5YxoaFO0sy4uNSWGxg8ApTpBOvGf4f9lc6Er6NPwUgshi7VA/n++5xGEdZCyRpDbLvqqaV80F0s7dlQoK5uPppaDOJzrH0fibNuENkdyry8GtldGhLGZ2cAgSXXKeps6jrRo3ji62WiAVU+cWGRFdxIPeIHXzNCQuZJogc06bbnVHqaygpLTJi0YcLelHbJGwf0lRS//cyUUaEd1SzxzqoQZPMihzvaWSjJ6pfaX1RsX91TGyogT9yP+wpMQe9NNp6NGh25zbboyBV3O29oyzbIsw/exApfyMx3V0oVUq3IXZJVzCadmndVUlaImBvrPSYhO/9PyCA18vcwv5e/9nclhBeJxzwHM8TBQkBr2NzfQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(19092799006)(366016)(261021123027099003)(56012099006)(38070700021)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1FzNmJBMVAxTlR3NklWRjJIQjhxVEtiNk1yZGR6bUVQdTJLSFV1elZRNXc5?=
 =?utf-8?B?THh0cEFRa1F0a1RyUUFSeHhNSUh6NTYvdE5remI2NlhKdXpiaHFyQmF1TVZU?=
 =?utf-8?B?dlJSVTdqbFRhZERlbGVPRmk0QnZUMkM0YUZ3eVk4Z3I4cGdJTW5wVjk4Y2l0?=
 =?utf-8?B?bHdTRTBRTVdYQXZTVjVMR3lyMUh0M216dmNDZDgwRTZhd05qZGxJbUh0NEpT?=
 =?utf-8?B?aWVtSk1tcUViVzFQc3MvdzRleVY5L3M4QmIxMnp0Q0xxSE8vNGNXelE5Q3BF?=
 =?utf-8?B?Vkh0bW40Tk1Ta0ZRUTM1Uk5vZmtUU2F4MGFYMHE4RTFvNm1IQloxNmhRN1la?=
 =?utf-8?B?bGJ3WnVQbEdzcnRCVGQ1bVZWWG1zQnB6NmlEbXFobHlnK0lrZjBRZUVOejVZ?=
 =?utf-8?B?b1QvUjZDbTIza2lLa2NnUTljVmxFZmpVRkx0Q2dYOWxRSE5RbHAzL2o5MXZ1?=
 =?utf-8?B?MzExZy9zNXowdkJzUDVBOU9aZzZxbC94dUJ1OUZoUXFEcHJwaVhYZzBTS1ZH?=
 =?utf-8?B?RnJNWWVkZExJdWxXbTdhaEZ5elVpWHVTVW5HclExcU44c0Frcmtja1RsVWJn?=
 =?utf-8?B?SGVOYlI3bkYvMEF6YVdDY3pTOXBqRmM3SEVXdDMzcFptOWd5NHdDalRKYk5P?=
 =?utf-8?B?OTdzR3Q4UytxMXZPQmY4UndJaXhVZlVxYnNmc01XQVpHcFlzMzZNc3lZOHBu?=
 =?utf-8?B?czZjSlVhVFlBTlNqb09jRUFFYSs0Njg5amFGTnp6SEYwNnQwZVNZcENQTk1V?=
 =?utf-8?B?dkdVTmQwdmF3YzhKTHg4NkhWdjc5dEw3OFZYaWZKTWxWZDQ1MTJtTEZKT1RS?=
 =?utf-8?B?UXZNR2daTFBBdGNvVFdJNzl3WU9GZnlsYm9WSzFuc1ZXdmZNb0dPZTVnVGp2?=
 =?utf-8?B?YTdhYUVLZXY1ZGVkalo3dTF5K3BpTitRNnFZZWplUmhpNjJ3K1RJcmUyUngx?=
 =?utf-8?B?SmUrd1I2NS82QmllcnNKc2xnc1lKQ1c0VEhJbHdFdlA3emMzQXh3dGloRThx?=
 =?utf-8?B?YUdTd2l2TTV1QUJndHlvS2pXbTZSNWp0dzFFVUdTb01udmhsZjE2TmdYRnNB?=
 =?utf-8?B?cTkwYUVHWXp2dFcxSjM3RjhRblFZTVRXVTQ0cUFJRjRTYXJkNDJNcVNjN1F1?=
 =?utf-8?B?MElNZ2VDZENpa21JR0pNQnpGWWZBZGNKaHJZOXpTeFNKdWtRVDhQSlM1MjVX?=
 =?utf-8?B?ZXJYT0RITmptNk14WlgrdHZIb0JaOUV0aTRBR0tVRWF5UHhuOUFsalRwY3Qw?=
 =?utf-8?B?U1ZEcFA5eHZteXA2ejdaRVQ3OVJEOFd2S2FQYVFOMzAzWFlmdnIycUdVWDdQ?=
 =?utf-8?B?SW1jUWJ1ZURINkxkS0h6aUlpRUNScTkyQTA2RDA4T0daaEpOTEhER21sL3l5?=
 =?utf-8?B?SS91V1pCTWd3R0FyN0pUV1pBejk2SUtJM1FnUFdkS2dSRlpoc0Jta2w5YXdJ?=
 =?utf-8?B?M2JWZkxWZ1ZTQjAvTUUraXZuT3plcnF0Mzdac3VzMTVNSy8vRndEVVk3WEdr?=
 =?utf-8?B?c2JVYmNQZFdtNGNFakF3WDVzb043SE5OLzZ5b0NDejQ5YnJaUWtsWXNNRnhK?=
 =?utf-8?B?TnJ2NklpakZCK3Evb1Bla1BoTE9TNUF0V2xOQTVDRVp5R0FBcTFXMU4yQ3hB?=
 =?utf-8?B?TlNOUTNmUjk5dmJuYmltZzVOVXFEVWk3RFgyOTdxTFlWbnZFREg3MkQreDMx?=
 =?utf-8?B?elNYTGk3dXNhMHNwWW5ETS81bEJETkJZNkdzRGYwc3RTWUxTT1BhcER0clNn?=
 =?utf-8?B?Z1hwOFVQcnpGdEMybG10K0czZ3RTaU5PL0tTNE9XbTd0L1pXQlVvNXI3aHd0?=
 =?utf-8?B?SEVLK21LbDhuTUVEWUxmQ0lYdjZSdUxrUzVDdUJBZm01WFIxaHNKTFZMVWdy?=
 =?utf-8?B?ekZZckVSVWo3YUFScFlXcndZUy94ak9jcWgzdWtmZm8zRy83L1Q2T29NYTBh?=
 =?utf-8?B?N2QzS1BOclNHVHBpQmJ2OU1WWkdOOTNkdCtrR1I5QnhiZEtYRFRFRFJPNVFH?=
 =?utf-8?B?enNhK0plTjNJQjZaemljSnRxbjlNOVlFKzlQSUo2RG5EMytTR0VhRUM3MXkv?=
 =?utf-8?B?WUdiWVR4anJOU000M1NWS3FaRkduV2M1cG4wUnQ4ZGxyQjAxcHM3NnhBNHJW?=
 =?utf-8?B?ajd1bDFzTXBKMEtpTFBPR21JLzRrWXJVYkpWZkJSc2JRR29BWFEvdkZWdTV2?=
 =?utf-8?B?d0x1NG0zQVE5Q3gvL2cwOGJFS2tzZ0NqQysvMGV5T2tFaW1hZ1cxK1FxK2RE?=
 =?utf-8?B?REZHQ3BqcHJVUy9qM1dMeGxlVFByVi92bGVNQjdzMXp6OG51UlpPUUtZc0dO?=
 =?utf-8?B?aTJuZnc5ZHdmSzJPMVhYemdXblg5UjZQWUd1bWtGdXZxVU9RcEJGRWdzV3hE?=
 =?utf-8?Q?8mEr2rz//UWO9K93UVzV8ghZlqSROxX0FTzd3ui0gl/bM?=
x-ms-exchange-antispam-messagedata-1: cV/lS/oR3JhypmNEyamfRA/1p/Y21T6LMmQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C353836E8E25D409BF4FE0195528AA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DMOV5xg92jCUEYTnX+YfiaO9nMhuoHyr4Bq8tCtxMj8dmcQs6DfuAbf/RWrPg17cADcUnFUjZsdd7BkCQwUjxAgY9KEL6dI0jd+BECINrPBC1kCQsvu69hg9rPCE024sEZ5AcCgW77FwknQwwAgde/7YYNFvVlRwjHXShSB6DkGEYrXK/waK6Aunh2eLWu5t1moegZa1jiQCafNkwco04FaqmWckBUPA2PwKVhfzU93XEGhFZ3s4Zt4DQI3IfPpSproEbKY+Yd7yvn7LukoosGZe3/vN9Z9ZxK0KNEaPNkmXpGpE2prUVHMsYGSmkJZlasPnxRicR0tr3kOsZ88jyQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TGn5Oi2u7HKiSTvqoL2cmTEwBC8sEGiEn6o1wCd/JDglKYqhAEucbVbVHDbBjTCCAcd7tTVUFd8L8nf4t3yJ+yh1sZtr9xt9u4T6SFQMCPdTqslZnm39MOMoV9XPEPO4FJOeeLEN25pjGV/2lk/HWW4mJju3eSTWLoljYMSxgEqkpuzDSzt0sJy/zwHkik9FB0quKHRBI+ban3XCW62R9NCugOszohVmzb0gUEFwUP5vzmrpyCYLL4hLV7E+zcqL9b2NeLqj+QbjeX79cRW9BdyJYoeFvlz4mwLfRNMuTrBOTyZrU22kdZe83L0tm6r8735ENZvTdk54SRCunGMtx5mx7MHGSAsDPy8oL6/HsXEDFw7ioHvh/BFx6iHDj9A60VB0zHNkz5hAg3wfDInj6nyFZ3bK/c91wiDQRIKVWFt8u4OOzJRcu284+92E//mLOrpGHkoAvaaKWhFyfDYWwI1AA+jmeGj3VnMNuLtAqDLRy9z27yL34VKdgsjtGmxcpnDzXyfnhPBuKeQCDNqJ18LFaoI9Qli+hDJnl//HDv9AX6rwfoXgTjk99Z/PKTS0J6Um8QbpxJbiKKxUzD2hwH6PjQalXOMinkT8adF8ZfxUc8eWcymb+VX87VGiyeFj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84e1308-9247-4139-8e7a-08df2fefa062
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 03:50:34.4357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPI/MENKU3vZRVNMPRKAKWs6n4hMII4ZkF50cfUlyXhEi5rQoC1Zb2KR5+VX4QyWu7Q19POflPxQH1dGG2NX2zZz6Amradb8OVVngSdwfWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8359
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDAxOjA1ICswNTMwLCBIYXJzaGl0IE11a2hlZGthciB3cm90
ZToNCj4gd3JpdGVfc3N0YXRlZW5fMV8zKCkgcGFzc2VzIFNNU1RBVEVFTl9TVEFURUVOIChiaXQg
NjMpIGFzIHRoZSB3cml0ZQ0KPiBtYXNrIHRvIHdyaXRlX3NzdGF0ZWVuKCkuIFRoYXQgYml0IGlz
IHRoZSBTRSBjb250cm9sIGJpdCBvbmx5IGluDQo+IG1zdGF0ZWVuTi9oc3RhdGVlbk4sIHdoZXJl
IGl0IGdhdGVzIGFjY2VzcyB0byBzc3RhdGVlbk4uIFRoZQ0KPiBzc3RhdGVlbjEtMw0KPiBDU1Jz
IGhhdmUgbm8gZGVmaW5lZCBiaXRzLCBhbmQgcmVzZXJ2ZWQgYml0cyBtdXN0IGJlIHJlYWQtb25s
eSB6ZXJvLA0KPiBzbw0KPiBiaXQgNjMgbXVzdCBub3QgYmUgd3JpdGFibGUgb24gUlY2NC4NCj4g
DQo+IFVzZSBhIHdyaXRlIG1hc2sgb2YgMCBmb3Igc3N0YXRlZW4xLTMgdW50aWwgYml0cyBhcmUg
ZGVmaW5lZCB0aGVyZS4NCj4gDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1w
cm9qZWN0L3FlbXUvLS9pc3N1ZXMvNDcyNg0KPiBGaXhlczogM2JlZTBlNDAxMDZkICgidGFyZ2V0
L3Jpc2N2OiBBZGQgc21zdGF0ZWVuIHN1cHBvcnQiKQ0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251
Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJzaGl0IE11a2hlZGthciA8aGFyc2hpdDAwN2tAZ21h
aWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3Ny
LmMgfCA3ICsrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyBiL3Rh
cmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gaW5kZXggMDYzNTkwZjU2YS4uZDk3MzE0MjFhZiAxMDA2
NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiArKysgYi90YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jDQo+IEBAIC0zOTQxLDcgKzM5NDEsMTIgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9u
DQo+IHdyaXRlX3NzdGF0ZWVuMChDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqBz
dGF0aWMgUklTQ1ZFeGNlcHRpb24gd3JpdGVfc3N0YXRlZW5fMV8zKENQVVJJU0NWU3RhdGUgKmVu
diwgaW50DQo+IGNzcm5vLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9u
ZyBuZXdfdmFsLA0KPiB1aW50cHRyX3QgcmEpDQo+IMKgew0KPiAtwqDCoMKgIHJldHVybiB3cml0
ZV9zc3RhdGVlbihlbnYsIGNzcm5vLCBTTVNUQVRFRU5fU1RBVEVFTiwgbmV3X3ZhbCk7DQo+ICvC
oMKgwqAgLyoNCj4gK8KgwqDCoMKgICogc3N0YXRlZW4xLTMgaGF2ZSBubyBkZWZpbmVkIGJpdHMg
eWV0LCBzbyB0aGV5IGFyZSByZWFkIG9ubHkNCj4gemVyby4NCj4gK8KgwqDCoMKgICogQml0IDYz
IGlzIHRoZSBTRSBiaXQgb25seSBpbiBtc3RhdGVlbk4vaHN0YXRlZW5OLCB3aGVyZSBpdA0KPiBn
YXRlcw0KPiArwqDCoMKgwqAgKiBhY2Nlc3MgdG8gc3N0YXRlZW5OLg0KPiArwqDCoMKgwqAgKi8N
Cj4gK8KgwqDCoCByZXR1cm4gd3JpdGVfc3N0YXRlZW4oZW52LCBjc3JubywgMCwgbmV3X3ZhbCk7
DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBSSVNDVkV4Y2VwdGlvbiBybXdfbWlwNjQoQ1BVUklT
Q1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8sDQo=

