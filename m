Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C65ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOZ-0001C0-61; Thu, 05 Feb 2026 22:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNt-0000RB-1F; Thu, 05 Feb 2026 22:19:54 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNn-0008F6-UE; Thu, 05 Feb 2026 22:19:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8zxFVVfP0l58lAyPqgzP5DevokS399Ln71iPuDJGwVOJ6K3pWKjAjjEIQAxeLLoVsDMHC83vqdusvu74gfERk/hvDeW2ssDdk5jHPcCsIYg9uaeagH1okNWOStDR6nu7xXYg+mGD34CUZfPi8rjDouZj+6M6BpN1jvdrrWlzZBamXxQd1ppuSaLS1R12XbJ+PfxXWwO0S/ZTUw0jHOPBdO/jzkBdrHU9aDYbdJIYa2ziZCKU2NGmz8imNsca4RBX5yU7reRybu1K92g5OjDfazLTkk8wYWAzkNnjpjNuK+0tJdbN2F8NpKtqfVZYvsr+K4JZ7Bcw1+deFoyYM4CrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/MD1gHOCR7Q1j47JSQMbUBb+TNvYSt1dx9HRn59BQg=;
 b=m+X/uaXUBdf1FrnBljyuHtkAOaXUcDfAgLb+C+e9CqQpwLbrbuUf+1+QUV6hyuCKQzs+Ysbu9nyk7vfI6h4r5e/T8dBDEfblD4UhWDyBmN9fa4hDXXMQq78h7pw1h88QShQ1gqmB2yNomPlifCj7VO9RtlZ7OX+dFZmKEQj7LFzaaLEhP0iGd1Ije7JiUr/ZtSfj/Xy4LGxkmDReA5B5a3xdN48sqw3Q3lq6kd53UcVA249Y5GzcgQYcKJfQ2QBBFZlFcVPDEUsj0p5S9H1ZPfObFpTpteDBAUuvxNyQu88gjK6gB881BRpBV0m9tlLm+3axfbIXszHKePBfpGO5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/MD1gHOCR7Q1j47JSQMbUBb+TNvYSt1dx9HRn59BQg=;
 b=e+2d0LIl9p045D7g7PfXJ8JXyjzt+Tvls/PQgX4nsMgpcdaz/2M+3bQz4odS/K88ky68zXuy9tHJhqd3/+zkT35Ax7L+7yueKdEI05faihJT4icq5Cj/Jlue6/sLkxjc4nVd5CFeoKNu6n2iiYxkjnfWdBnggRvlDAGhYKk0tO+qJaiXWKxzTid5mZns8XQ/t1pupFj7w3xEvxl7/guKNIMYzpREw+8DSyswZlyjWg2T7/xWyak3pit1OjcMf1g5qNVx7JWXOxAjWI8GS2Z1EZhObbKJVlOitL6L7Qh0g/mYWLMvbxD0XZTN1mOOnBn90QV/U6DbB4igW+uTStO3Rg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 04/20] hw/i3c/dw-i3c: Add more register fields
Thread-Topic: [PATCH v3 04/20] hw/i3c/dw-i3c: Add more register fields
Thread-Index: AQHclxdqzgTZBG1LmEeEOJrSiDZ8Rg==
Date: Fri, 6 Feb 2026 03:19:33 +0000
Message-ID: <20260206031926.3227848-5-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 1494c076-1032-4d66-46c9-08de652e8cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZZJbR/KyvdYWcPn/mJrvbKuasOf6A4GOkR9+VAd0SbAaO6s8gXX9DosZ9N?=
 =?iso-8859-1?Q?79eC5bCoA7466oAPHJ+UyY3hm+0ncc1h6NQAOwjPjIgHa+ZHq+ffeWjtBL?=
 =?iso-8859-1?Q?xotmz4LtFCmYZM4v9ZYFp4QLUhL7iqvahgWOmGQuvANuOx6QYAdV6QyTsJ?=
 =?iso-8859-1?Q?hYg7iG9AwS9GSlNZ2EMN58g2TThD+GjT5QxTTW1ACmxMdKR9EHBWdV6ayZ?=
 =?iso-8859-1?Q?h4Lqgdk0ccQ9ijUjAV6zk5EZsM53/7og/gzojvdtKSSJcH3HboGZGseyVh?=
 =?iso-8859-1?Q?B2iGxRcG7cAwrhXrMaLZZ5aEYU/okZrHKxgq3LlbarcDNO1qTgaj/IJslo?=
 =?iso-8859-1?Q?d9NTIjr5hqnYMXuXtxc9ct597G5yasp5Zzq6+XjkzBoDEXFkfxzvL8Nw14?=
 =?iso-8859-1?Q?bm09TlSd+SvAqziWglxSfAEBi6EswqtXTz63g7OSYMbXa1VF8e6Rv9Fthq?=
 =?iso-8859-1?Q?hsCi5i9Azcnb8iBToX/AWR2Awyw/k0ajVOVkfiTFTVtPVccPa8Vm5blJ6s?=
 =?iso-8859-1?Q?V/kZujj35X3EqXoQ3pzzklpD4+fTepiytwdwYHPqf4/ewlx1rMbQac38l9?=
 =?iso-8859-1?Q?HOLVcRic6kE40ZlXqur694dTFxaGD1NLirXEdrGL81zqps+Jm8o4eGyKbN?=
 =?iso-8859-1?Q?Trn+yfHBaItSG9+pelrTUhrdh6kLoJZcNz8nlidVic1TTgDOKNosTGRlAk?=
 =?iso-8859-1?Q?hykXgRe2GggTjrDc87HgWkAPbhtugl1xKs9OR7hrBUrRhRUvvlJPfiulhb?=
 =?iso-8859-1?Q?5fdSJFCB+H3HT0tFlwt2ufA14XeFioH+K0s6vMReGVS9qRCg9+jdJYKcyb?=
 =?iso-8859-1?Q?upDTe9YAwGyGThdFn9dxGwMM4XmorBZTm3YbCPFQZgqwgbCxcx9pFYABHG?=
 =?iso-8859-1?Q?0Iic1bVFxM4+YdqTsPWfkIOD3AlRyWkG9KL9dSnYB7oj67i9+RipQDYO1X?=
 =?iso-8859-1?Q?0pkVBdLW2EOkqwCWlzJ66IkNN1/r65SWQr9/QFSU0uSHBhC5JSFkT+yJI8?=
 =?iso-8859-1?Q?CIlWVxcWbQslXw1jvA2EFUhEIp+SCjAxmCXjFKvJK8vbbANC0a9UwsLndO?=
 =?iso-8859-1?Q?brNI6lLGyFcb9ppk49SXlpFQKWGIZC6gTP55wqzLnPJi5mmjfsEN4dcwz+?=
 =?iso-8859-1?Q?ZSY6hyZxtcJjnNlHGLWg5sIG8IVGFnQH/XYcx3khLjyU5LT2ESNSWbzg5S?=
 =?iso-8859-1?Q?vFk7rzK60my2WMgIcX0ZLLfsahQnUUscHXhRwsQv5hpZFWSYpL8419nLkA?=
 =?iso-8859-1?Q?GGPEAxJsbRS6CwDjV6XjnXM3g98wRx5gk/b465FFNr2+B4TkTDu6ptG1Dq?=
 =?iso-8859-1?Q?xRMX5/CbQ5Qx4SPvVDuzz5Lpep+mPJjp0IU8yPtkLN18aDYxFB4mIEd+ta?=
 =?iso-8859-1?Q?Y8rVJzrvk54lfHR8/3QPbc7vuMrxQnww5jK1LWAZf26HTKmI5jlWc5bSKr?=
 =?iso-8859-1?Q?5Z6Hxedl3a0/UU+PC4FpL/hQYc/dtZwhWG5jObOQWJMz6vfzTtqfaNivrd?=
 =?iso-8859-1?Q?cHqW3zpbyrpKcw4RfTu/+gFCtHdevl9vWWU50/EvbYNXtf7JczGGjNcIvr?=
 =?iso-8859-1?Q?xaF6OTHNuxmrCS51BdwzfCFe1fVwWaLVbZKTtByZhBvdqKJwU9Ni1OTw4W?=
 =?iso-8859-1?Q?t8r1OVw9LEjfRivru51P53LJUmsZ7WwhOQXYn0PCWkccf9n4SU/BrnEvsM?=
 =?iso-8859-1?Q?x90lScGJxGYLUwRmP5DNKUSo231JNMWs65Zjav1V?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NjtNVtyE83vdjDxW+kh5uvn+yqNl9vf6X97xjyMzDefgMukh3q7QQcyBnc?=
 =?iso-8859-1?Q?jzXo57iJ8IEzWfCIp9Qpdsl62Zr7YS1JYhFweM0kAd/vKfxv46kfsckhsn?=
 =?iso-8859-1?Q?h903OemCIPglzLlpCcDeH6gi7lvjg3SBN7nVAUhdEeetBhzR1izeftbSlH?=
 =?iso-8859-1?Q?J+NwCy9n3ljJrv7M/+PwZ0ZjXtneiaI6AzItu+T0/LUjQeskQnGOL+cyX/?=
 =?iso-8859-1?Q?Pilakv1MWuGqBGoLBNMvHOtDF7EWF1BEU5SOlsB6akVCwQNZS6/E0q+8RX?=
 =?iso-8859-1?Q?Os3Vt4mkD/GvXxlmNsnL6uTBhmZCFPS/rzEDFCEYEi7B6IBIi+qXnau2BE?=
 =?iso-8859-1?Q?nqHLK1bWjqulJOccc7HCkiQYxbyJgF4UiFhJt6Xo5YjspbnDvVeW3djkz2?=
 =?iso-8859-1?Q?hETd15sC15Q/s6MwmwdrSx/exr34yvGfEAD2PTRxy5E9tmGNMOub+wbJ5G?=
 =?iso-8859-1?Q?pewnSaf6UEx04zo7PkkwL5loc65DRkcG+uIR0wzXWmjeoZxYl36LnK4fxa?=
 =?iso-8859-1?Q?OOP5/0LMJP5FrYmsERjyIx1dqTCmHtXvWSmL5EUG1GP7ePmxLqOdhvtIQ0?=
 =?iso-8859-1?Q?hUxF8ak+OLuToq4L6V6fanYkXPDykTOdXeNR1W4c+ukCMHozjbsv09JdAM?=
 =?iso-8859-1?Q?NO48mpyct/zHEcCyn2h+hZHi+YJmpe3IOOgBRiLkYynvvT2DhaI68AJ3uC?=
 =?iso-8859-1?Q?TVDz53b0OB3Di6tPMYlnxWF93xCRD9JAxKnCCTwGJ6zOfMLeC3cSttNWz1?=
 =?iso-8859-1?Q?8U9M5/c9XWpgWsO+/tRVPIWHE8JnYVne9aq54XI1zolFjvsj3J+Wpkvo7R?=
 =?iso-8859-1?Q?p89ZQfQU8mPIXSqcoSUlb8QToEY6hZdTwcGeGswp4eHbboNwDg5AosePOb?=
 =?iso-8859-1?Q?iLUZlSdoWMXzXvhFB1upwytd2DYTCduJNz7KaLrRYjuU2p/1Fj6jLrAZKn?=
 =?iso-8859-1?Q?x6C8hJ73NiD+gQ/5zMD3CM19wtG7W7bsdLrRmWRensCCJKjlAymwiWCJmf?=
 =?iso-8859-1?Q?+nLyQdlzxoJWBSdgE8LRlYojsE0ZDXO8PEEg+7uvX1SumptmJoNhT7dr7j?=
 =?iso-8859-1?Q?0vgfjJIszQ5wvtiXFmXkz7l/BY5/Agh6yIPCUoL6CcfGfNkaBdvRIUbpqG?=
 =?iso-8859-1?Q?pWGTYNfcSH26A6AvIiYcQILH6gLG6ZxMtH4kCcdjYjg/nTTsyfwx6ZOWDV?=
 =?iso-8859-1?Q?CIjsXkUqcf/c3nuE5UhtiA5mO4lxlhJE+eekmgZpTcJeptKxHWf1i0Ar/I?=
 =?iso-8859-1?Q?c6bCqr9Np3QV4XzOIIPRPYzxhhBGC6SJed/MldIDHV5AxRR4BsBLTM5bB2?=
 =?iso-8859-1?Q?qVe/RrPt3GW7zMfqEHQmNX++zVIgXAWFAZyOA4b/QfeNRGiGskI2HjwaKm?=
 =?iso-8859-1?Q?eGLUJ7TIdDdAq/SBGetQ9pQPY4VnplU+51y2rLadNxL0FrQ6AbEEg9MtT8?=
 =?iso-8859-1?Q?9QD7pEM1bWvIWhl44+DMmDYtzbFxb+w2pzB+HQr+FtOW+OArKbFLjbJjiV?=
 =?iso-8859-1?Q?RGNF5MtxVdO4d96GYwv5Lh6ZNxyVIIjYVnFuVEYuaPPSmgQcJ9L78G6bNC?=
 =?iso-8859-1?Q?PDEtCnavmXsHpJILQ6WQvJT0iL7YBeYxf4/kIPo2cFO7XRaGuMMtvzl1dw?=
 =?iso-8859-1?Q?uKVL7QA78w335YMgNGp+FPR+D7EzhwTVieQCCIep0h63I8dRyUUuD3s/cw?=
 =?iso-8859-1?Q?nUaBpVKqVTe+OM1q5UbFTOyeDtDqyDvIwwKmakCa/uQAgzo87Ill081EnZ?=
 =?iso-8859-1?Q?uYDWM2G9s2Fh4BHN078cjdQlqpnpjedckI0q6EbQB2qfMmAzKPuJfec15V?=
 =?iso-8859-1?Q?6P0Aad/rrQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1494c076-1032-4d66-46c9-08de652e8cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:33.6256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1li9trQBqA87EfO+uUl4uXQA0hQWiuiCjWoZruucxgo4smMkJKKz6RcNAxdL8VvzJ/xTr56rXRPPoa1PBI16jeKyHlRq+AdD8U2iZL8zaOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds the rest of the Designware register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 199 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index c949579ea1..2f04c69320 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,54 +19,253 @@=0A=
 #include "trace.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
+    FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
+    FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
+    FIELD(DEVICE_CTRL, HOT_JOIN_ACK_NACK_CTRL,    8, 1)=0A=
+    FIELD(DEVICE_CTRL, IDLE_CNT_MULTIPLIER,       24, 2)=0A=
+    FIELD(DEVICE_CTRL, SLV_ADAPT_TO_I2C_I3C_MODE, 27, 1)=0A=
+    FIELD(DEVICE_CTRL, DMA_HANDSHAKE_EN,          28, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_ABORT,                 29, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_RESUME,                30, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_EN,                    31, 1)=0A=
 REG32(DEVICE_ADDR,                  0x04)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR,         0, 7)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR_VALID,   15, 1)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR,        16, 7)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR_VALID,  31, 1)=0A=
 REG32(HW_CAPABILITY,                0x08)=0A=
+    FIELD(HW_CAPABILITY, DEVICE_ROLE_CONFIG,  0, 3)=0A=
+    FIELD(HW_CAPABILITY, HDR_DDR, 3, 1)=0A=
+    FIELD(HW_CAPABILITY, HDR_TS,  4, 1)=0A=
 REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD_ATTR, 0, 3)=0A=
+    /* Transfer command structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, TID, 3, 4)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD, 7, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CP, 15, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_INDEX, 16, 5)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SPEED, 21, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, ROC, 26, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SDAP, 27, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, RNW, 28, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, TOC, 30, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, PEC, 31, 1)=0A=
+    /* Transfer argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DB, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DL, 16, 16)=0A=
+    /* Short data argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE_STRB, 3, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE0, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE1, 16, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE2, 24, 8)=0A=
+    /* Address assignment command structure */=0A=
+    /*=0A=
+     * bits 3..21 and 26..31 are the same as the transfer command structur=
e, or=0A=
+     * marked as reserved.=0A=
+     */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_COUNT, 21, 3)=0A=
 REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, DL, 0, 16)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, CCCT, 16, 8)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, TID, 24, 3)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, ERR_STATUS, 28, 4)=0A=
 REG32(RX_TX_DATA_PORT,              0x14)=0A=
 REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_DATA_LEN,   0, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_ID,         8, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, LAST_STATUS,    24, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, ERROR,          30, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_STATUS,     31, 1)=0A=
 REG32(IBI_QUEUE_DATA,               0x18)=0A=
 REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+    FIELD(QUEUE_THLD_CTRL, CMD_BUF_EMPTY_THLD,  0, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, RESP_BUF_THLD, 8, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_DATA_THLD, 16, 5);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_STATUS_THLD,     24, 8);=0A=
 REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_BUF_THLD,   0, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_BUF_THLD,   8, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_START_THLD, 16, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_START_THLD, 24, 3)=0A=
 REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN,   0, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ, 1, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ,  3, 1)=0A=
 REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
 REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
 REG32(RESET_CTRL,                   0x34)=0A=
+    FIELD(RESET_CTRL, CORE_RESET,       0, 1)=0A=
+    FIELD(RESET_CTRL, CMD_QUEUE_RESET,  1, 1)=0A=
+    FIELD(RESET_CTRL, RESP_QUEUE_RESET, 2, 1)=0A=
+    FIELD(RESET_CTRL, TX_BUF_RESET,     3, 1)=0A=
+    FIELD(RESET_CTRL, RX_BUF_RESET,     4, 1)=0A=
+    FIELD(RESET_CTRL, IBI_QUEUE_RESET,  5, 1)=0A=
 REG32(SLV_EVENT_CTRL,               0x38)=0A=
+    FIELD(SLV_EVENT_CTRL, SLV_INTERRUPT,      0, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MASTER_INTERRUPT,   1, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, HOT_JOIN_INTERRUPT, 3, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, ACTIVITY_STATE,     4, 2)=0A=
+    FIELD(SLV_EVENT_CTRL, MRL_UPDATED,        6, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MWL_UPDATED,        7, 1)=0A=
 REG32(INTR_STATUS,                  0x3c)=0A=
+    FIELD(INTR_STATUS, TX_THLD,           0, 1)=0A=
+    FIELD(INTR_STATUS, RX_THLD,           1, 1)=0A=
+    FIELD(INTR_STATUS, IBI_THLD,          2, 1)=0A=
+    FIELD(INTR_STATUS, CMD_QUEUE_RDY,     3, 1)=0A=
+    FIELD(INTR_STATUS, RESP_RDY,          4, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ABORT,    5, 1)=0A=
+    FIELD(INTR_STATUS, CCC_UPDATED,       6, 1)=0A=
+    FIELD(INTR_STATUS, DYN_ADDR_ASSGN,    8, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ERR,      9, 1)=0A=
+    FIELD(INTR_STATUS, DEFSLV,            10, 1)=0A=
+    FIELD(INTR_STATUS, READ_REQ_RECV,     11, 1)=0A=
+    FIELD(INTR_STATUS, IBI_UPDATED,       12, 1)=0A=
+    FIELD(INTR_STATUS, BUSOWNER_UPDATED,  13, 1)=0A=
 REG32(INTR_STATUS_EN,               0x40)=0A=
+    FIELD(INTR_STATUS_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_STATUS_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_STATUS_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_STATUS_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_STATUS_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_STATUS_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_STATUS_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_STATUS_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_STATUS_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_SIGNAL_EN,               0x44)=0A=
+    FIELD(INTR_SIGNAL_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_FORCE,                   0x48)=0A=
+    FIELD(INTR_FORCE, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_FORCE, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_FORCE, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_FORCE, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_FORCE, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_FORCE, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_FORCE, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_FORCE, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_FORCE, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_FORCE, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_FORCE, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,  0, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, RESP_BUF_BLR,         8, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_BUF_BLR,          16, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,       24, 5)=0A=
 REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC, 0, 8)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,       16, 8)=0A=
 REG32(PRESENT_STATE,                0x54)=0A=
+    FIELD(PRESENT_STATE, SCL_LINE_SIGNAL_LEVEL, 0, 1)=0A=
+    FIELD(PRESENT_STATE, SDA_LINE_SIGNAL_LEVEL, 1, 1)=0A=
+    FIELD(PRESENT_STATE, CURRENT_MASTER,        2, 1)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_STATUS,         8, 6)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_ST_STATUS,      16, 6)=0A=
+    FIELD(PRESENT_STATE, CMD_TID,               24, 4)=0A=
 REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+    FIELD(CCC_DEVICE_STATUS, PENDING_INTR,      0, 4)=0A=
+    FIELD(CCC_DEVICE_STATUS, PROTOCOL_ERR,      5, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, ACTIVITY_MODE,     6, 2)=0A=
+    FIELD(CCC_DEVICE_STATUS, UNDER_ERR,         8, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, SLV_BUSY,          9, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, OVERFLOW_ERR,      10, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, DATA_NOT_READY,    11, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, BUFFER_NOT_AVAIL,  12, 1)=0A=
 REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
 REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, P_DEV_CHAR_TABLE_START_ADDR,  0, 12)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,         12, 7)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, PRESENT_DEV_CHAR_TABLE_INDEX, 19, 3)=0A=
 REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+    FIELD(VENDOR_SPECIFIC_REG_POINTER, P_VENDOR_REG_START_ADDR, 0, 16)=0A=
 REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
 REG32(SLV_PID_VALUE,                0x74)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PID_DCR, 0, 12)=0A=
+    FIELD(SLV_PID_VALUE, SLV_INST_ID, 12, 4)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PART_ID, 16, 16)=0A=
 REG32(SLV_CHAR_CTRL,                0x78)=0A=
+    FIELD(SLV_CHAR_CTRL, BCR,     0, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, DCR,     8, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, HDR_CAP, 16, 8)=0A=
 REG32(SLV_MAX_LEN,                  0x7c)=0A=
+    FIELD(SLV_MAX_LEN, MWL, 0, 16)=0A=
+    FIELD(SLV_MAX_LEN, MRL, 16, 16)=0A=
 REG32(MAX_READ_TURNAROUND,          0x80)=0A=
 REG32(MAX_DATA_SPEED,               0x84)=0A=
 REG32(SLV_DEBUG_STATUS,             0x88)=0A=
 REG32(SLV_INTR_REQ,                 0x8c)=0A=
+    FIELD(SLV_INTR_REQ, SIR,          0, 1)=0A=
+    FIELD(SLV_INTR_REQ, SIR_CTRL,     1, 2)=0A=
+    FIELD(SLV_INTR_REQ, MIR,          3, 1)=0A=
+    FIELD(SLV_INTR_REQ, TS,           4, 1)=0A=
+    FIELD(SLV_INTR_REQ, IBI_STS,      8, 2)=0A=
+REG32(SLV_TSX_SYMBL_TIMING,         0x90)=0A=
+    FIELD(SLV_TSX_SYMBL_TIMING, SLV_TSX_SYMBL_CNT, 0, 6)=0A=
 REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, MODE, 0, 2)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, REQMST_ACK_CTRL, 3, 1)=0A=
 REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_HCNT, 16, 8)=0A=
 REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_HCNT, 16, 8)=0A=
 REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
 REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_LCNT, 0, 16)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_HCNT, 16, 8)=0A=
 REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
 REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
 REG32(BUS_FREE_TIMING,              0xd4)=0A=
 REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+    FIELD(BUS_IDLE_TIMING, BUS_IDLE_TIME, 0, 20)=0A=
 REG32(I3C_VER_ID,                   0xe0)=0A=
 REG32(I3C_VER_TYPE,                 0xe4)=0A=
 REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
 REG32(SLAVE_CONFIG,                 0xec)=0A=
+/* Device characteristic table fields */=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC1, 0x200)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, 0x200)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DYNAMIC_ADDR, 0, 8)=
=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DCR, 8, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, BCR, 16, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, STATIC_ADDR, 24, 8)=
=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC2, 0x204)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC2, MSB_PID, 0, 16)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC3, 0x208)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR, 0, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR, 8, 8)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC4, 0x20c)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC4, DEV_DYNAMIC_ADDR, 0, 8)=0A=
+/* Dev addr table fields */=0A=
+REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_STATIC_ADDR, 0, 7)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_PEC_EN, 11, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_WITH_DATA, 12, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, SIR_REJECT, 13, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, MR_REJECT, 14, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_DYNAMIC_ADDR, 16, 8)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_ADDR_MASK, 24, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_NACK_RETRY_CNT, 29, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
     [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-- =0A=
2.43.0=0A=

