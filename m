Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6486E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNNz-0004cH-MX; Mon, 09 Feb 2026 04:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNv-0004Zn-JF; Mon, 09 Feb 2026 04:16:47 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNt-0007H3-Kn; Mon, 09 Feb 2026 04:16:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OloC0bxaYU0ODV3jTkgFrFFX+g8SLvkvqQ144dJqgJpMZbHW/dtlYFKuREmZZFLpc26opYgDx4yjwdB0Um310AVBMcHz0uXLzntHNJaMnKFPh2GcflRbF5eg+JIrR8RIEL+NlA6qRa6Rh9TtE3upr+eC5GozXZLl4nL30+DerL5iMkn+O6m3sEqaElbC2XYhnOM9cuOTN7k050Aq/P+jPtBTzZJ0eLtgjAEq8DhbrcPTaG0f6FTbXjTTfbbZd1zdgbYRRWLY1C0ZN+iurQLQwX35wjcZdE9SuUmUecaGcI0jZKU7s1INjB8uRrZeIveE/lqFjetXNN5iFFKoV+/Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waEbE4PHCzzCX+J5OYHEkWyErCSEkJUo1tXpQ40Tgvg=;
 b=mj9izyWr082UZbaUFKHYqMl2Fqsb8buz1gcKtmqraKTrVFigcXgSkj5vcgVMX+7HnOzmM0Z41GUF4bJwcvZJJq4teTqXlbj3rinYcr5+EpnSvQtsstH6E9MhezkHdflyx4gfDns00z8ziKz+RHeIYZwaCLVvNNrPiFxxulCY4j7vF3ckyrlgPLIFbKF8LgwUhQSDJZ+z45+p6JHtbbqAumRdzSBWWdIpumd5hzz5tByYnpfmtCMxWNMFgcibWRMi8t3eLtzkTUfhXKtlYeg/zn9H764RwG3ZaGP5E6fdsjpQA01XsXXsJNT0UdTeR2ZjhgBCOm+6VwCg3Q+b/FWpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waEbE4PHCzzCX+J5OYHEkWyErCSEkJUo1tXpQ40Tgvg=;
 b=gcGFkr1lY7w5UmLVkj4NgZ8CbvHrI9ZliDQp6fCQX0C4nUnyuQ6fyVt06IcFKGaUYMTJhp9hQxK2orD39gZPHqUtQLOywrVSt+wzzKSchvI5Fp+FKFRojQck4WfORMQFvqVjkQgjlbkVzWTN9vpz07RIiKePd/qPrwyuwnkgXfs5MzQG8N+5jB8LsdMogzslzHgqKs0CxAwqelWOLXdCnGAePg+x3QJJ5aD6ZTnpYe/P+SBvAQxMGL96xKSvQCv+jvqhSwXSdeFiXmdpQY25nW7YVwaJfzBkl3IpUYPXtdcxKSQTweNTHKzE1asIUbFpYZD8TunCFpKs089uKNf5LQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:36 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v4 04/20] hw/i3c/dw-i3c: Add more register fields
Thread-Topic: [PATCH v4 04/20] hw/i3c/dw-i3c: Add more register fields
Thread-Index: AQHcmaTKwUPH8fDYTkqXFbAWJab25g==
Date: Mon, 9 Feb 2026 09:16:36 +0000
Message-ID: <20260209091629.823457-5-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: 7a56a901-8136-4f6c-9405-08de67bbecb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?R5A2iw7mau6vFxnaM4u8MoVsFeekzGG7K6tKvMkOGrUfBhOBmnItCXoltL?=
 =?iso-8859-1?Q?caHWuhf9OQ4q3KpHUQaXTeZ1+TM5jCRpkfH1JJ+hNxvpeK9dMQcoQmtq5q?=
 =?iso-8859-1?Q?K1FCZ9VNt2gDot0rZ3Dv/Cr+LZrC3TjPP/+TKkW7oje7W9TTslB74txmDE?=
 =?iso-8859-1?Q?sHAEXjI6XyAtr6MImCz1wgqmbkvxiGtFzO3ezEEzoGwVDbOa44go/v74xD?=
 =?iso-8859-1?Q?5I+N6MJ4CxdAJ3iMI+YstqYXLpjI/DonDmyZH3H0s6b+5j5gSMDo84WSKS?=
 =?iso-8859-1?Q?9YZXkRe9BdtV/nNK5hiU1lPCi/yahMXutuu+deC9IHv1mT9fsuvKoidF3H?=
 =?iso-8859-1?Q?W6u+2qY3WLLcxXBQXkrl2686SyEB4riqTXKKyQSW/lVFyRDdJiGYqJTLHR?=
 =?iso-8859-1?Q?Oqj/iMXbEW+olpbbtbtt7FBuhF0Hyqumaf4Ck3SsWi0HFcqad2wZ95mTrX?=
 =?iso-8859-1?Q?sIMs0I2Ve4lIoQ3N5I5oij8lgXi9I8NmQzED8zQiMj8/RWSQzQCoElUZAc?=
 =?iso-8859-1?Q?Tvbfb0TW60oiMtIneiQJApPajDRAUqShEZ2Zds2hxQCfePO4A1Sw1VK6Vl?=
 =?iso-8859-1?Q?sVpN1PZ60r5R75ZbSBvFlrJKMFm9vG58RLvc1RfrP+JU8/lwwLxKF/nPma?=
 =?iso-8859-1?Q?QKxHZq1w7py6+N9C1fU83hJt+C6riwMovipaNjryNjKbZTuNcQ/tiujkvB?=
 =?iso-8859-1?Q?sOg0m704sSueky3ZYouN7AyfFAzQ3muIFpOFrmjtQQa/DPsJ4TOpS8R1hU?=
 =?iso-8859-1?Q?vYmP/neonk2Xf7KSbm3SNTb+vHef/FlIgaZcVLU/rloLjKO4h4FILsmUZg?=
 =?iso-8859-1?Q?rgpHssNh0tA7UzBWcnWJlZATSoog3MPkhqQVfOwg0RLuIsU2Is0JAxbDry?=
 =?iso-8859-1?Q?QWPJT1eoF1COWdkT8iNWS4cgitfUrmsOvgQu6BSk1CHEql13JSxRYaneNF?=
 =?iso-8859-1?Q?+Thnlp/U6N9Vn0ltCRq8dy5wcf0OYtPKJOR0A1zKbxEaEr2Nq2t8q0SRbt?=
 =?iso-8859-1?Q?vAXtVkONJ1OiTK+3FCPUMNgyOkmUYf/nJwWyRKngFnqgFNYL0VIhg0BqO5?=
 =?iso-8859-1?Q?jGQ8k+yRht8KW37D7XvCE5Cx4MUxWe3sW2C9i1IJO/WHkdO92SFgiiic83?=
 =?iso-8859-1?Q?GTurJskjbWzUSIYG0jNZAiQfW17FnTkYvIEKeT4Hsyj5rPTBq+JuTs66IQ?=
 =?iso-8859-1?Q?iN6GeDUIjoj8srzRBFkWFB+Ai90C4attGhpZWhfIqm1MiOL8O82KKf+vr7?=
 =?iso-8859-1?Q?7Uix44LfBR8pZSlPGMBsnglI+yLOLwZCii4ADi6w21SXmkYxnHmySiROZk?=
 =?iso-8859-1?Q?B+D9FZmOpe8J1P77Jx4hcwqCPfo2S66DeTpGurb3O/EiqyH+ttJQ6o7Nai?=
 =?iso-8859-1?Q?+QSliIKgADKJQbz9U7MY2x3Zcqz3XrUPxZpVMHWRcHIuFsud+7neTJzqtE?=
 =?iso-8859-1?Q?ac6hKZIRozrjdgGoLJ5NrKk57Ik2cZBtwdLH0qwPNjucx9b9EccwbvJzwb?=
 =?iso-8859-1?Q?kf5UFeMJaUV9blslwWYOJTYO2U7xH8Uayu2K0Qe8Qo5caCHq3eAshGOYr0?=
 =?iso-8859-1?Q?TrbWtAHlJJ578Kmz46iBTrgsWECC6w9c0BXgVQcEcDXCPuraERtgFUAF7H?=
 =?iso-8859-1?Q?Um8A6oKtdAutUgnCfoZ/Q90L20eSH1wCLexyFLQWM6AHqNeOcc+KE7OsX+?=
 =?iso-8859-1?Q?Tnc6F0RkXl+RImedZJaDcnWcGKb+Qzcf05F/Df4v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4XXi+P8DhRmOit7kk/Bqz3Fy41QWOyHWImQW/kqrG6JHyjyKxt7OVRhrxB?=
 =?iso-8859-1?Q?G1YWukEp6VMW1aDiVJYKv0R8vtF03RR9Jula3VDPdh0qOy39exuxxjW+0r?=
 =?iso-8859-1?Q?X2942X/sqrp0xYa6KSa0dOacoiKSxt1lVCGCLPOpkFm5fH/qniyh8M7Ay5?=
 =?iso-8859-1?Q?TCYtbtZ3J4RNcNxUxwJ9KvSIZ8vi57i/vkhjU8jcKCxK+GPKOE+9SoUDMH?=
 =?iso-8859-1?Q?FgXG1PT3oVEMzkbNLXSBR/ujG9NKz+Je3+cWRn6XJccFZdSDOY7or3RBPA?=
 =?iso-8859-1?Q?GNBL7vYbhkl1oE5Hd65NnrQKB9KfRbVrIcbXIWrR4c5kiCZiYkuPRHW68U?=
 =?iso-8859-1?Q?34W5WCwcFuU8IF96vNVmhXwg92rc004L0ncRs5dfghF2Mvp+iCxWxWQb+x?=
 =?iso-8859-1?Q?OYCnRn3wJdsRIM3rSFlHnO9dKzJUYnKpvrjgNwzJTA3ss431LSMNSkgb0H?=
 =?iso-8859-1?Q?EYL7XTBVG3nNmlGWvezqTFp7MAVFvhlYANfD9wjuhFNp/9BmuZMaHEs+ZH?=
 =?iso-8859-1?Q?R3JznwuR3Z4nTO7wdGUiUmrvGd3KrIehaEemu5hgvLFsNxGsFnTfjpbLmr?=
 =?iso-8859-1?Q?I6Cn7ZWY2Zcj0M8AkyMzCE0PWrLispJjESifl01nXOwSmIIJiLrWG2Um9n?=
 =?iso-8859-1?Q?gznv5jHuTpy0eLCOp6PvV6BlSkLRivzP8hTBxggkEfDrrGN69znfFd4oJi?=
 =?iso-8859-1?Q?MZuCA4bxct3kQVEuugCPCbIfVoHitou6P4H7RoE1DjsLTUnFOMfkR+aNbt?=
 =?iso-8859-1?Q?A1J5dYwXOp2/RyYP7iuihE+6QUkVH0W1ijtrYqm3SqwllxZKaxVclyax2B?=
 =?iso-8859-1?Q?I0X1O4HFWemo/ipHn14HOfyiHflnDHNaHelud0BA3jMou/Uy50tU+w9Iuo?=
 =?iso-8859-1?Q?etwnnR7EKqKw+Bsg/ydU/FEYHILG1Qnx5vUJNez6gyz0IP2hR4btHprEw+?=
 =?iso-8859-1?Q?g/C9GKd0HzFRejV5AFCl4RLxc3dybmLcc+5wcssCwySSNAEV5qYIVT4dBP?=
 =?iso-8859-1?Q?TvewG+TxbZTtO3WY0LIJ8OXU23oO0AzOaRthIW2tnUSonZT3jJo7ddtA6O?=
 =?iso-8859-1?Q?S5xe06oMDRhT6rMfYGytjspScY0rUOLQBcpfIoT7QLm25mDZd1Q8cuXG63?=
 =?iso-8859-1?Q?Y8MKPLZ3AgI+u/Sh5PSYcNO8eIbR6ig6CqqWymSTZoCt/wsMNXtoM12EVU?=
 =?iso-8859-1?Q?mnnA25a2vSZvVDoIVSh0MsUAnjgwF23qQsCKUcvYl6CoFY9chdAD5ivlxl?=
 =?iso-8859-1?Q?BMUj1sASvyHf6SBha9PQw+6Q8nRSgWMnik10yxUz22Rmr4/kpOhM9h50IK?=
 =?iso-8859-1?Q?T7c9RQAJWBSlk7Kjq7qiuLCU+3b6Qab/cL5AggErdBoBqhOPe+WwnTdFwH?=
 =?iso-8859-1?Q?O6VqE6CL2nuDlf9slLhoTWOjZXGuOf/Dd0Do3MWIDlE2cU4vXBjbW0wGM2?=
 =?iso-8859-1?Q?lbYTrVZSfhQr44ORTSciOadOYuCjgpGivOWk8sd3rUYbqYURU1jEgyfHnZ?=
 =?iso-8859-1?Q?EXGHICXNhcubLhsfrsGB4ngk1zf+07h24R6rgvu/Va4mHnOqNdPPe4NNv7?=
 =?iso-8859-1?Q?W4ntVUJp0bjRtlIKLJLfOl/hVKHPDq1CRUu5sJtf/FrQE4W/Dg/Wo/NYPJ?=
 =?iso-8859-1?Q?GVNuBv6SJxIKs4d6U79YrNxr4uOyiXrfgAt7i2yTktwZA1aXhTfAV32XRr?=
 =?iso-8859-1?Q?+jLZqMj4G4ZwAQzlJbl2pikRNOBLlc3RabgDCxKI2ujbGChqAwANd5dV4p?=
 =?iso-8859-1?Q?t1OUjDUx+Wl9aUrvWLhICu5ed2qnJfEjFx4mKiZmoS2PmQzXkJi5z+5gZi?=
 =?iso-8859-1?Q?xv/d75H1Xg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a56a901-8136-4f6c-9405-08de67bbecb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:36.0851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/wBytHEfQSCnOwJWUDWKj7B+GHvtdOnF/kOcNAr3txRwu2H4Gwr7YV2Xg8ZQxdAfz7qu4G4OI+yysZ5rEalpWmC+/VvuNeuBEV/NfU60no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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

