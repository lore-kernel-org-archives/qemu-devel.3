Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F7C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmg-0004j5-Mz; Mon, 20 Jan 2025 12:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmc-0004c5-3k
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmY-0000Ze-GQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394911; x=1768930911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v2duwbg7QR28N2W4UNpyDMAV4hcBkv6EViHQREdJvHQ=;
 b=oJJM7MI4A7XlmQ8xk1LDsLcZ4NTbQcbRUiYdyQtJbb/voA8G/1611qyA
 swJLPzl64IOewcW27Nd9BBVey+shVqoAN/C9yowB8sCY2dZJSY4RBV/qI
 XoPqUYI60A7gCYmyltUfy5/U4aABgJ4ROmN4+UQKMD009T4Uyl1oZ2irs
 xh6PP4zS9o9rKCTDSSdKn0QFoBuAhLUWvzyF7G0oWPmKIAUsPCm3D9qPg
 oN3OSX+fdxxzwafw+NvVSGcepujPhzTWVXI8nxVqPLzNKv2HslUCSh6bo
 4U/l1Rc95219OwzU85eI4vZ0teyNmub9rkMr73v0fdn+IjmSizNNkgKqk A==;
X-CSE-ConnectionGUID: R2Sscq6dTPukvu9xIr7/Cg==
X-CSE-MsgGUID: vcfcOemLR9CIxhTTUvHRDg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291720"
X-MGA-submission: =?us-ascii?q?MDH/PuE3+IHgGnkr/orbSoNEJwueGtca4u5Khm?=
 =?us-ascii?q?RlVZtzg9z+EcdAiw7xYTC1EqR7IaE7W37oFP3y6ycpMSQ7YYIB4pVe4j?=
 =?us-ascii?q?qFOYx0Hh4Y0mtsccZPA2Ux7z8z8M3ESxe/1/a4hUfKo5ercm87DH2YIC?=
 =?us-ascii?q?VhG65rzzChP7SzqApHEFAn9g=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYmyIqhJx9aysfVcikT+kkjd2M9qrOQ1UXMUVMe+e762t9DqqHIUFxCrjzsSRt6uxXlz6fN72QpIU17x+RA5cT4GgnWHxQZZuMsHV1qqbwgollao37Ex7cJKvjBbl8JH2OWsJcIJQQAiWlr14mD3+sTWr7/4dklDhsm0E21zFhciGXXTiu25RmyYAnzQ6YuJul+Hk3sN/RqI9U4TA3VhU7vqDyLz0iSKNS7luQHuoFVnO6ex1Z0K64JKBiDyu+2mxO1nTrltaSsqRb+Uyh71EYryxYRbK1XViHfK/j60jb4hqFCgngYgL2RBsjCkINqbpoRSQPP1JMwyALWDlUohjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKQbMkjT4VGlff0Vr6hWS1E7CHdK47iwGetnD3ykSVs=;
 b=PzvoMfFkG6sLUJREDyYfqdgQSPvWGqe3q7b4zdIzX9pD/tQQv56TqXM7jxxQ4XC5hQg790IDYDrGqx7betF308y0tZRcLXdH21QkiicJGXZeY1YmrTEDsVK5vaeiwoylX3Be7PvCNXjygpAtOHF4e4zBqzMq2dJT1W6gE75enqWVEoHrQVYDQOA8fvgp7U5qbma9ZDmqsMR16Do/qlGSgFBc7grYUXzDPysFkLeW+XFh7FeXngKV+4OxTAPJsqG16E0nXtWJAn48/r018klM2EDX8SZnDs4W5jT9Jm3B8aiOK9Kqz+cJJjRx0Zog0O4Pu5yrXIY/ILcYQcnuc+Ddsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKQbMkjT4VGlff0Vr6hWS1E7CHdK47iwGetnD3ykSVs=;
 b=dBsm7JIXfFn7g6xSCy8sALntW+m7TyuOWGVRXHZN4/72IWJlKfKbToqf7h9vfFOIJFbaULFzpj0++QQB+D36v1p4R/wXsmXiyO+SWfaCzOzAqQob0O3dj9/bwxcwhrCjHoy8Q6e6478f4dm4gCIQi5QdbeXGGvLJ3Zov/6m+1E6ywaZJM3kfOLVgk8xClIZ5NYc9VHriGf6sknqDEYQXUoBgvUUE/WScksgiBsH8LMNpeBj2QztQcTu0xTFSQCOGv+vAyo4A7dQAck3VBdy+HhQB8YnxTg4BUNp2s5zuVxlAVzlTcLdNvkz51TNbIgw1dGDfYyCssnEJ7af4sK3vLQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 08/19] pci: Cache the bus mastering status in the device
Thread-Topic: [PATCH v2 08/19] pci: Cache the bus mastering status in the
 device
Thread-Index: AQHba2KTcxDTuKZ/OEGVhSISWwoG/Q==
Date: Mon, 20 Jan 2025 17:41:46 +0000
Message-ID: <20250120174033.308518-9-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: 5f0f9445-41c6-4c63-d886-08dd3979b5f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?K039ILat+ZTw9aoUctqZj9cHwEX1jzXoImGCfbUL4otz4j8jehXk1RsdwF?=
 =?iso-8859-1?Q?jOwdiK1aXFxr8h1x/EDGXAqzGeoefFJ4bJr59qkXTjB3NWOlOVkaPrQO97?=
 =?iso-8859-1?Q?+t/Gdx533ReGoiykgnAFdfhNY14IldViu+YRSf+vDsuMMY+oENwtfh6k5H?=
 =?iso-8859-1?Q?9bzqWi07ggyejA/Ce8+dO7unBOZYOjWc6FjVOv6YQE77ousyyqzUvQxmxY?=
 =?iso-8859-1?Q?XQcLonTfR3IdpxbkQRHH2S/HZ/6UEHZclsEtKlkq1pDzEACfAj3JurLAM6?=
 =?iso-8859-1?Q?NhMfLoy3Eg9A3NIjA5/CU9r7VQFPRO6txrAKgH41bG0/w9vMZ8BEDNOGv3?=
 =?iso-8859-1?Q?PMt4UighgG3K0unJPgKWXd0Vt2BmbLEkgfmxISDLVdf/fI/Te7MqWqMU1S?=
 =?iso-8859-1?Q?atIJ7z3q4rBmUy3IP5/6SUx43OwCkR7Yl4X+BOxIBMgGvCxU49+RNwQTN0?=
 =?iso-8859-1?Q?HHNFOiB8yJzsFn3yEX/xxFUV370BHsYrWopHovvMebeEdWQok4lo/G8Fjs?=
 =?iso-8859-1?Q?sSP3F9uOdVix0arZJzwG7JryIp6am4IaMPGn9VhziHnMgjPM0e+HH+mesh?=
 =?iso-8859-1?Q?+WQHGlZJwv3Ut5QsIX43I1uPgAzZIpBabQkRFJzrvieo+NtEPOQg4CHzq3?=
 =?iso-8859-1?Q?th+mUACNtEKq8Ys7N6+ubFwHfdsjBQIm46fHs4dXdJ6K0B1hs1DYxoTSXz?=
 =?iso-8859-1?Q?o3owIpZysECvh2DPCAIZ14VqeLgt5/NZFIPF9sj9lSThZhOG+n6Dy9wfu8?=
 =?iso-8859-1?Q?zt7uvnKaA0e8Xs2Y3VLG6wk5OTZGw8bsMxIliDcJrd8GTQ7S6GYcLg7wd9?=
 =?iso-8859-1?Q?evXZVHcCIUrvgfxUu77KdsJUdbV4kMvHzxAC6qeKNMFFAthBkMnzvN+Gy5?=
 =?iso-8859-1?Q?dofJfI1WR3FIfsPA2cDGs9ckcf8l1T5W0HbvB+fpndduwZYsFFW0DhwR1s?=
 =?iso-8859-1?Q?t7ihTYUNQdHpX3Rm08jYOQtaW0/ek+OeiT2s2/nzB82qoaL24D4JbHw+EZ?=
 =?iso-8859-1?Q?CrZBVGTWro+AbkuPe6YYjKDeAZM16V43g8UXBcRiRHbrRWNpiPlgApYkJR?=
 =?iso-8859-1?Q?5MDcxJWWRj8ohkI+0pHmgtZN+r1peJXwvJJUT+X78Nrghj6Otncln3AdJE?=
 =?iso-8859-1?Q?wmY6Xreji1WFv0GFJVDX8EGEZJntufdwXOwAw2npFlwRlvjvt69pi/qiR9?=
 =?iso-8859-1?Q?/sI4Q8cplHcNMmDpOSXE0pIYfFAqZZ3ZLtscNVowycGn8aBSahylcHYE4D?=
 =?iso-8859-1?Q?s0D9/QvQMqcZ/FZddrn/HPkZwbUCIQLuH7D0LVuV1UO+3xBEY/bjao+r3u?=
 =?iso-8859-1?Q?jjIsnHfr8QhfmY6i6CFF01tz+wgtA1RG5M47jN2+YGD61TSB5fTAZNL9IS?=
 =?iso-8859-1?Q?5cUo+e4qq/tAhzUhbLK8kKYj76bGsOiKrAZqw7t5c/o0JKEznuhiu22Gil?=
 =?iso-8859-1?Q?JmHj2IpoqdAUYSTZeQOC+A9C/Edp/kKZmza+syNnVLVSnIzgWXFNnD090d?=
 =?iso-8859-1?Q?Oev4hHX0/xG+z4L5ktVzjT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?domHKLbMdylHvTYUYym0qxOX5gBbcI6lMV64n6QyelmbpdQdEM762TOaNr?=
 =?iso-8859-1?Q?0vOyVV2OpgvcMTqwvE7AdSjCQANxWJwTCNC3u/ooJCBctSzicVqbgeBfJA?=
 =?iso-8859-1?Q?iTbSOR+9LjBomzPaZVknxD5Q/irHOUgU6jQLog68kqE7rpU0xR/5WCmUTU?=
 =?iso-8859-1?Q?6a/Mqz0igrAZQBpp9j0l3UK8Lm4XI1Pe1jgOcOhftT2mdhy0jW5zFgugsm?=
 =?iso-8859-1?Q?wRigQL8iWXmOg30stu4G/UYAVO3z841iZ87/grdJXQNxgkqdi4JBssQCym?=
 =?iso-8859-1?Q?yN2RxXrHNjWkMXki+LnVy5rXxkR79r112Zan/U3L/ujGKcOpy/wpzldQsr?=
 =?iso-8859-1?Q?NcY+c+dAjjMkB/J+KEKrL+umlwzE/Pmr50OBGCt/+r2wSpW7bOnPewrFuB?=
 =?iso-8859-1?Q?cecHNk9Cziv6TGycHxkCSfxvNm+QNfQkBv2pncbru5nO4JdPjwWGjJDXuA?=
 =?iso-8859-1?Q?/BIjLbfi6pE8yR0vK9Ba3d/ruqc37dGl9Qqo/eEvRS9yIaVVOdSmYq9hkJ?=
 =?iso-8859-1?Q?YHGPZpPIL4c0doPZS06dD+Fa4J379RrCGkphgNLqgyWk1KqTs4dLV1vlks?=
 =?iso-8859-1?Q?pZA0qGuaf+6IjiDbn5S/7wCJK7wInUgmWaA5liMWeVEpbhiuVfG06SkzNL?=
 =?iso-8859-1?Q?QNkKITW6jrefcfEeKBhKSKLq+/LvBGQLI3aaRf769wGquTF8B43KTc7YSS?=
 =?iso-8859-1?Q?6edDWRo8+KlX955V+xrVAdljQFQbq+nmpnKEP//u7eOqeSmGrnLQWfFgjN?=
 =?iso-8859-1?Q?D2u+amvs5IeZ31ygdTNTS6yR1QcMVQ0DRUNHyWOjRU95BfnMkUss4SjvRm?=
 =?iso-8859-1?Q?j6yighzz7GLLDNscRxo0v2ZXnttCVHWJ1WvNJic82w+VHmZS84RqWhzDOs?=
 =?iso-8859-1?Q?tPqUN8gSAZcSc6v8ZuXoNlf0CMRNCsU54k2hyrxj07bg/tB0QNjFPyEmZz?=
 =?iso-8859-1?Q?hhfN04dG8D7m5qy6V/tgxREnJLGXwLfAshKXL4uqCbMjTUHQnljNfqrKt/?=
 =?iso-8859-1?Q?rpnYDkEwXe6W6kb+NCdA4NgvJf2ltVIqJiw4KC3/yT69FRtcpYJ6cKczEa?=
 =?iso-8859-1?Q?0UwjHJrNuEJjk7GWociUIdHQCbqtw+IPxwu/fMinzD5BGHRiIwYYSEuxaz?=
 =?iso-8859-1?Q?EkNiQZ+56uoOkYskFYQq9pzztK+0qbF/uduwgqpCTlMFA3rl9KUC3wbO78?=
 =?iso-8859-1?Q?eoEBbFGQvRNAVZzzXlk5HW7aTliohZ3eOm1EzYAAg3SJh/x/H73P+qgjWj?=
 =?iso-8859-1?Q?SGUhPCOUDS0GNczagcpLSm/UzzEbuW1vc0cAHQbR2x+WHtpqLl9A3QQMyJ?=
 =?iso-8859-1?Q?CH10UN7QZyOmdSf/y7W4VMnJydbpNUn9KnbOxe/Eoqk2fxqWAzOJRYUFfG?=
 =?iso-8859-1?Q?TJV9pqFVKzfmjNym1FAxKbtRHNrcovrV9/GTt3BTjabrFWNBoNPFyKOV3v?=
 =?iso-8859-1?Q?IxTNWkpYo1JgYypSxsNFP0p2nUlAEXsmIvuE99f2TALCHxj9JugDoVqMAZ?=
 =?iso-8859-1?Q?+IvxVWym0gwxI2xy4CrMabfjfk6q2xOmjnMYSKL9OOlAWDjYikoZj2Y0W3?=
 =?iso-8859-1?Q?4K90313BbX+xQaqR9ZgwnVOLNm2499g01Fu1H+hdAR28YQ9v+XhpVrsyZ6?=
 =?iso-8859-1?Q?O0bRAGOT78fs9oRLG88Ry4vKKTmCzKLU9z/JMko9nFta0cHiToZVwHjdwF?=
 =?iso-8859-1?Q?Frb1wZFRdN/iwl2vZs0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0f9445-41c6-4c63-d886-08dd3979b5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:46.2467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAJHuvmc9kw3cdW/Nl8VBa2Ef3y6K8N93fWfWspXhgJzAriQceZAnM/iEMGihYuZTOgkPmRRW2Y2yFRqeGDQNhfWhhuB1vXxHHz3iW3jcwwtfvLgxR6705ksToxSx5LP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

The cached is_master value is necessary to know if a device is
allowed to issue ATS requests or not.
This behavior is implemented in an upcoming patch.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c                | 25 +++++++++++++++----------
 include/hw/pci/pci_device.h |  1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2afa423925..164bb22e05 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -134,6 +134,12 @@ static GSequence *pci_acpi_index_list(void)
     return used_acpi_index_list;
 }
=20
+static void pci_set_master(PCIDevice *d, bool enable)
+{
+    memory_region_set_enabled(&d->bus_master_enable_region, enable);
+    d->is_master =3D enable; /* cache the status */
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_dev);
@@ -141,7 +147,7 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
     memory_region_init_alias(&pci_dev->bus_master_enable_region,
                              OBJECT(pci_dev), "bus master",
                              dma_as->root, 0, memory_region_size(dma_as->r=
oot));
-    memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
+    pci_set_master(pci_dev, false);
     memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
                                 &pci_dev->bus_master_enable_region);
 }
@@ -727,9 +733,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv,=
 size_t size,
         pci_bridge_update_mappings(PCI_BRIDGE(s));
     }
=20
-    memory_region_set_enabled(&s->bus_master_enable_region,
-                              pci_get_word(s->config + PCI_COMMAND)
-                              & PCI_COMMAND_MASTER);
+    pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER);
=20
     g_free(config);
     return 0;
@@ -1684,9 +1689,10 @@ void pci_default_write_config(PCIDevice *d, uint32_t=
 addr, uint32_t val_in, int
=20
     if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
         pci_update_irq_disabled(d, was_irq_disabled);
-        memory_region_set_enabled(&d->bus_master_enable_region,
-                                  (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->enabled);
+        pci_set_master(d,
+                       (pci_get_word(d->config + PCI_COMMAND) &
+                        PCI_COMMAND_MASTER) &&
+                           d->enabled);
     }
=20
     msi_write_config(d, addr, val_in, l);
@@ -2974,9 +2980,8 @@ void pci_set_enabled(PCIDevice *d, bool state)
=20
     d->enabled =3D state;
     pci_update_mappings(d);
-    memory_region_set_enabled(&d->bus_master_enable_region,
-                              (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->enabled);
+    pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER) && d->enabled);
     if (!d->enabled) {
         pci_device_reset(d);
     }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index add208edfa..40606baa5d 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -88,6 +88,7 @@ struct PCIDevice {
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
+    bool is_master;
     MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
=20
--=20
2.47.1

