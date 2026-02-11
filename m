Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6FEEB594C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlm-00059i-CO; Tue, 10 Feb 2026 21:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlU-00053c-QE; Tue, 10 Feb 2026 21:15:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlS-0001hz-Eo; Tue, 10 Feb 2026 21:15:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpvLaYCycoxsZ4QPhOBt8R0QkBe2XX3in9fHYPIKg/1oPB7Wv6agmsIgiQhIhETy56mb6w669OSnUcq9ZsRyzhOJZBVN6ZKxD+vj2E12Ep1ZbK7qm0K2zZSPDYbLYGpu2PZvOYZ6o5j82g6hvka/OVwbAtYSa+t+jMkk88tw728gDvwLfBqVu/pV1YB0h9KKC7bFYauNkJOMdEhVCPAVBOxgusHyvlVlDZw+W/qf+m0A6ItrPOr1EQzbAzL4DrmqmQbfQbycnCtHId52KRmlwm+MJIlphTf+s7iWjBXW8TSAGRoG2KWcEut2KDnsusw6+ZwsYnzAXGx1QqGaxc51Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIDOsneABS1qIC4+dgt2tahKihvh6IMDPkLj0BjtPJw=;
 b=frIxyh5LgC0x7Sg+VT4oeaTmQ93f30Tu08K/VZ0VG2NiJhgUA17zfOomMaVUjIQuAjhmUwj16dpkjtYGNGPHCLbg2cLLk31qMFng90hgnjBg6mxYA8+EpbjgXu1imvGiT0U80/DuGrX1Rv33SIVHZBDgLDhKSrLGJ5gMNjrV6tcaXBJ7i5vXLKr5jqW8siTYy3jaCVAlwKfUtISTqu+Y1FBuAPMzfJPpnmLVlXdHIZ5S2rwHnzS3LUyK3BhcNM9rj1DWW15tHFhkf9nw5gMuP55FaCCq7DzahoFvyQWILA1ENiaHT9fV61xvSCwgVdLPdcGlbLquBWUG3qHT7HjFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIDOsneABS1qIC4+dgt2tahKihvh6IMDPkLj0BjtPJw=;
 b=RYTyb4A6hdLY3XmfQkeqe+WFgQXJ5k7hRAz2r+5JOqL1G/iOsapyi+CWqXOjqS6CxhwTPrn5s8gvqtVTb9SRJQS7KmrnmhU4ZwOXIZn++XSeO4CRuyHkQaLQ2v6X1v5v4p6SIF9KLGjxMOUw0KEFATiAKaXNh1fabEAFIX0B5hGpPwZlqM37xr+3JsMVajnH8ThgG9rB8hfspIS+C5MoShxVN5l5kJo77yuwDM7UVso0l5DnTR2usVpCOcYa5Ec1/Q+9E2mJGJweQiYSxSUPppPEiEH/jh2rhmBbgv0yf8OKoiVppLGQ1NiuXdEdjwbfQmPH00MyarOiH971wybrEg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB6541.apcprd06.prod.outlook.com (2603:1096:400:47d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 02:15:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 05/11] hw/arm/aspeed_ast27x0_evb: Move ast2700-evb alias to
 AST2700 A2 EVB
Thread-Topic: [PATCH v3 05/11] hw/arm/aspeed_ast27x0_evb: Move ast2700-evb
 alias to AST2700 A2 EVB
Thread-Index: AQHcmvxNOOLpXR6OJkCBGp8BA/vdRA==
Date: Wed, 11 Feb 2026 02:15:33 +0000
Message-ID: <20260211021527.119674-6-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB6541:EE_
x-ms-office365-filtering-correlation-id: 5b216d40-43f4-47b3-0d8f-08de69136ff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hR54gESSbnQFW7rC/ovAj9GOpRknue6pU4JBM+Irs+6qdQzXirWwTS6E2O?=
 =?iso-8859-1?Q?HtMxMdcemj4jubwQhsdpVlrO+50NW0atA61sLO8Kp4kpPF5JqETpPgN6BQ?=
 =?iso-8859-1?Q?/KgOhEfB4XRG8/ZTO1t4SZqciUCDwDYQax5rrMuyzBJSVaHGgHx6IvK1FB?=
 =?iso-8859-1?Q?GP+tPMA8KavfeAqUdfS9Nj6Br99bWBgbxBdjOTahnJ69MEjFceJm2AnMbg?=
 =?iso-8859-1?Q?7PUqxFwHUfee8u5ANBTyVsA6KzitfYC2i67FDCuj88Sunj350r0IiincZY?=
 =?iso-8859-1?Q?aoVsqYpfW4J6/PS/VuLmx03BsW8up+RuX09nmLBDt/6TV8OctojilbD8Np?=
 =?iso-8859-1?Q?5AUYagZLf5yLwCytel7nBP5aNfT4+mEOjvWyLSGSjzP2osSMv/7DgXwCBR?=
 =?iso-8859-1?Q?+wmCNQErURvMnU+w42t7QxJAK1r2WGg2WBVcvg8oXSKMAuGgk6iAhQvQbu?=
 =?iso-8859-1?Q?P6JOY2cXoZMzSfcD9mYEYuVK8qdPfAO3GlQy6shVncjqGBFmiQSdSBjXMf?=
 =?iso-8859-1?Q?fhTM/rV4irMX8c2q0VLdW4B7zD+DJHSt6GB8rKXzeH8bBRhfnCByUUm8+0?=
 =?iso-8859-1?Q?EIsGiafYXauGBzd6KZ5Jg9ObDCe7TNIH8N9J6SR0EfGAF0+TW73xPPxgwP?=
 =?iso-8859-1?Q?R3KuYhdPTKnKq9RBagrC+tN24KCZYczQssYW8hhjieZVJVb4tZ732UyR5i?=
 =?iso-8859-1?Q?GQ/bLKU+wGFUEcUs4jrqrGRewpjtUCq0u9SwztM+6OPax87dzjuJWSUKAW?=
 =?iso-8859-1?Q?uH1nMGAuoTbkeEwMtJXy8YVH5MADA7Nz5suynAlD+X3B7Jcunot+197is6?=
 =?iso-8859-1?Q?9XRI9Wz+zx7PYIqkSnibx7lgLoKthHWHBaV6FUIq8KDWjbY3yseIksjRl4?=
 =?iso-8859-1?Q?7OXP8rVTua7bqwDcbf9Q8hP7Nm/6EOePoLQdHITrh1rgICLVvlJOO88c8b?=
 =?iso-8859-1?Q?X2ABmGyf7U5y5X3djGF/k0EIDp7k8Bv4VwPlTBSue6tWxnQab8G66oyg/R?=
 =?iso-8859-1?Q?6Oa+LrvTVihA2ZjM2Cn4eMBflqeNoa7YIDKHrwq9Lq5NIpN8ioghaPsJbi?=
 =?iso-8859-1?Q?mjlVPY2TZqaiyo8WvAdCAEYqTkK0SjjOhj/TQ0KKnKvQmTbcN1nwQtiBBb?=
 =?iso-8859-1?Q?CwBgkmEhrZ+ikN5cj0EXLFOjR8A52VNfNDx+EdvY+4h69bwYPrnvL8aqIC?=
 =?iso-8859-1?Q?vYZwCBBHGh6hBA6EMxgkDcUW+jQx8ztdd4i08ZM5WFrU18gl5Z3nI/D+U8?=
 =?iso-8859-1?Q?sjox7VFHjplwbAqe1xUyrrdoGsE4QSr/L9+KSjIRars3LkpNksYB/kgkWj?=
 =?iso-8859-1?Q?Veak5pVOZEl1r+uMt23DPN/2xyscDFzGacmZt/HcDMDL5NlnBG05DE/KAN?=
 =?iso-8859-1?Q?Nuzhl3CoAJWvSUK52J22BFL0mJGzu9pM6xulgchxhn+nXC/buIBfaGomSC?=
 =?iso-8859-1?Q?b/iD+x4AGaWiR+CKPO3c6v3cxFWrzx5sMHSdyTQGERYuNjcpOU8fknUAnQ?=
 =?iso-8859-1?Q?3oSZq6T76TjqOdPxB1AfM1TEUsqbDT0ZaroqlK6KcrwQFEjOD/76nxnO+A?=
 =?iso-8859-1?Q?08sOrEMxdE8VQ6lOraVUxENu66X9Xa34IdCvnTp66g903Divv4c2TkjbRe?=
 =?iso-8859-1?Q?NS8RC4ZkeW3e9PYDKEyCgOXpOa7FwxWI7IhTVHK55QFHy0Bb7/nc2sMdAt?=
 =?iso-8859-1?Q?LkybNWKjNvWEZ7cDvfUWWkXR2QXcLSpyHw6CCBAW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mBTXuGDCTutcmTENd+7dPRJL2IetG3WplYWsJOgnPaThWioLNHf4fEJqEx?=
 =?iso-8859-1?Q?wPx10X20FVhabeP6j0Z91A/2YpF58gE1TJe0jl0oygoAhNGHY1yMqJne9U?=
 =?iso-8859-1?Q?hR0D/HN4M/8PEauPyzBG/PzAo7bl/v6vFyf2q4ZqN4tItiNXtWeg7Re1Yt?=
 =?iso-8859-1?Q?rhdHPRk1dT0BxA6a8bMrMWE4k7ZRTgnZvihChKvth4iEzbhgztLXiqjrk+?=
 =?iso-8859-1?Q?s5aigoRTptqSaiwcc4GvBD3rR8ZeOSlrIXqctqAJKIXNYIxPI/nooOn2tj?=
 =?iso-8859-1?Q?p4N/hPHpl8q+UU1AVdHbpWv3pbhkiv5th0xizgSfqK+hiE64miMkN3KQh2?=
 =?iso-8859-1?Q?EN1ZLPwyay+E4tAeCUWk3uoDhc5e7wHU4R0UnDICT8aiyZgFwZxTbjktiZ?=
 =?iso-8859-1?Q?Gp6vCrNAc2+KisKGzMHG/K7ijCgoJe6lBe3fPCV4LxlWx7gmYu0nEleOCd?=
 =?iso-8859-1?Q?JF3YabEBg/yoN8beBYSV9JnHTwT08b1HrcTmNahoXMByfIPmlVTy9KquEE?=
 =?iso-8859-1?Q?Qsjy8IfUxAs9MwARItsnJmPTkNYWFZ6GIAzeHD+UFHQ12kqFaCdG5h4XT7?=
 =?iso-8859-1?Q?cUmCMk9k4bseAnH5w3il/aQkKniYudBRVklLOtcLL6Be2B0HtTxAi21O27?=
 =?iso-8859-1?Q?IqammFSbNwePztlQJ/xOzDOc/JclfcpvGq/RWiYnVTWRSXeiwQIh7OIHJK?=
 =?iso-8859-1?Q?RhhVihxyKLp5ombMH+fM3vwDqAJ5mVM0zSZonxH5w83sLht0910rZaKGpA?=
 =?iso-8859-1?Q?tlcr3bg3Pn0s2scDv1NJEmUqhp2ukwK2L4mksTAyyDNladt5FvJiHV7S2H?=
 =?iso-8859-1?Q?Slsailp7qCKNlvC9WN0NkJKvmdHdloQC6hsrpoXV/WuhhCbx2tg0MAUz7l?=
 =?iso-8859-1?Q?JJCsCtL6E6lA/M519PrAtjGMr9xUI3elxaNc0PbREBwEBS3m5FIR5qMQxs?=
 =?iso-8859-1?Q?rAYvY8zcAgXanDaMk+08VxNkF4eQ+lrTVKiWoUni6Ms1hC9NgmxEXYhf5I?=
 =?iso-8859-1?Q?862znZUhHOaffL7w1wJ7ZROJpH1mchzMW3isxpJW3AKI3Z+5w2KaNQ+bxn?=
 =?iso-8859-1?Q?/xfpC2f0vuAnDdJ/elbU+r2rLmhkkwrARlGAemLFeoaufelDgHMYZo+VqF?=
 =?iso-8859-1?Q?QSmfCRVobwi8BWAwR1T9XEczieiuEV6YcXo7mGb6FXWwwbKqA5fcJ5Db+L?=
 =?iso-8859-1?Q?3Dm+n1pMmywMMcezeP5O7ISCVYzsDN8pjjjfv3wDovfNpyLKHYdoVp8mI+?=
 =?iso-8859-1?Q?EMAj3rmYLcg3J0xTbZw4dTc99YTetb5BBlE7nLYGzmZxA7uQthNM8YQSt6?=
 =?iso-8859-1?Q?Pa5Bqe6vw4/isGjRPuNIJSBk2NodcchLQbt/i0Iv9iLrSpKNJKJD/X2B8t?=
 =?iso-8859-1?Q?SJaiSawnLwRMQA1l/VXT0UHeH0o8TdmEIfToMMBc+q+yj+L9UAej5gMJPf?=
 =?iso-8859-1?Q?0t/4lfLR3d3zBQHqvoJgEPRbwL8ySQJgiHsbAyEy6ZgDj9jrK4DGPJCvrJ?=
 =?iso-8859-1?Q?ROblJF3AdCUiy+KmXQieuSNlxvtIA4aI5PCiPE+5zFJnWDRPYxqLheQrRK?=
 =?iso-8859-1?Q?2PPIUHCUQiaQh2Dd+AScWRNevPuDV8M1Wm0PXt3gs92muTrVxyqjuNJKLK?=
 =?iso-8859-1?Q?MinQShRZSxSppFiRFJ/c96Wvz+2v2JkGNPTACAmriXa38Bk6xQzVoxZwF6?=
 =?iso-8859-1?Q?Kt+qvek1w4RlbiShzoBG7S7+z/8pFgwdWxzwiJbEGBOCOu8xOD2Fm/E712?=
 =?iso-8859-1?Q?3dP1Pj/8Q9YYg83Mz+4ubJhbpYiUXJvNOSJUhMTWf0zmcdrh32nXmvfOMm?=
 =?iso-8859-1?Q?DbF83K6wgA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b216d40-43f4-47b3-0d8f-08de69136ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:33.5980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qvxlV1gEKGmAUgpxktL8dvyz6GSXIYXd+gyiGrr+/1A5k6SvWxsUPmJJxKHihU4cKU6GKKNP+LGvpTEIyQNwGOoZi9xlK78QV/GJvCSyoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6541
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Make AST2700 A2 EVB the default ast2700-evb machine.=0A=
=0A=
The "ast2700-evb" machine alias is moved from the AST2700 A1 EVB=0A=
to the AST2700 A2 EVB, making A2 the default evaluation board=0A=
for AST2700.=0A=
=0A=
This ensures that users selecting "ast2700-evb" will run on the=0A=
latest AST2700 silicon revision. The AST2700 A1 EVB machine=0A=
remains available explicitly as "ast2700a1-evb".=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0_evb.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c=0A=
index 32d944848e..0ff1bebeb0 100644=0A=
--- a/hw/arm/aspeed_ast27x0_evb.c=0A=
+++ b/hw/arm/aspeed_ast27x0_evb.c=0A=
@@ -34,7 +34,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(Objec=
tClass *oc,=0A=
     MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
     AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
 =0A=
-    mc->alias =3D "ast2700-evb";=0A=
     mc->desc =3D "Aspeed AST2700 A1 EVB (Cortex-A35)";=0A=
     amc->soc_name  =3D "ast2700-a1";=0A=
     amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
@@ -56,6 +55,7 @@ static void aspeed_machine_ast2700a2_evb_class_init(Objec=
tClass *oc,=0A=
     MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
     AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
 =0A=
+    mc->alias =3D "ast2700-evb";=0A=
     mc->desc =3D "Aspeed AST2700 A2 EVB (Cortex-A35)";=0A=
     amc->soc_name  =3D "ast2700-a2";=0A=
     amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
-- =0A=
2.43.0=0A=

