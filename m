Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBCCEA3F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1U-0003DV-JF; Tue, 10 Feb 2026 00:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1F-00035a-MN; Tue, 10 Feb 2026 00:10:39 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg16-0000GO-7j; Tue, 10 Feb 2026 00:10:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN9V+5i060n3t0UUMrcCYPZUNfkTUhDQEn4m0itRO6qnlO2rOFkJWWFTKhZgp/PZ+D3CXflRL3dh1JNUUdafmEeXERose22xTTbd9nZ2r/Zwokvn9c2s/sAkU3ruyn/eWx0Emr0xo8cuSuBR6j08yDhJXWytVe7KHZeed4VeYAGi454bCz68j38F7grPVsQpdhuwfH79F/z2it3ALhFAts8YUqRfCmgd1wFoXaQlounzOf7nWlKRMJbYnOtW+ZlIQEyWyT9i4Pd3jpQbssxbdoQHRTYK6P5EjQSMO7nQwQwu33jCTazGjusNRCOZHkKivT+djjTnqnK6Rz0GNnw0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYaIs4jhRaKwXnx7cA0ZK0f/mrGkv6rE3J3u0vv+gVY=;
 b=XkgYNlg74+dwSRwtsqUIpIH82wpAWJoU5Z4EMLUZgFwvtrgknmKLs71QgKH0QmlhGP8zY04KDPwaMNeAxwwl6wmjRJWsmsNhgnkHQl3jfDAUMFuaWlduHrj6mzhLT8V7RLAmwZdSAgcbjy68OtFYV0rSh+mDLLif9nuTpXIkSnclfpNzzQcgsGb57cdr/wuCwXTdD43MdLjh7ZlexYl4y4cKQRRe/IMLKHFbYpyP6VT+b1kk7TUOzHhIN1Y8BcL0N1FtANcfECljLB0vLdGXNqyOGMiVr8VSlAT3bivf1KiHiagaI+CQ/H4TX/wL8GqBJfkwPy4lT+57thQbZ0jobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYaIs4jhRaKwXnx7cA0ZK0f/mrGkv6rE3J3u0vv+gVY=;
 b=VDgIVXt+7Z2n9+bTYq+bikBXoBlzXJbf9alTp9e7eu670CLmKojqkOgEeZIMRzUaRXIM8LG0tz1i9sSZxyWFLIlb6il7ogLJk3wz/Ey278ABRsJUpwjMVEYb4TzaakJPENJl1MZVU72xubz3b8IxVlrVj9d1FRdzCl2G+gwD/pjT2/sh2BEO2O8JgqNtRtdZXqjVA4n7jFqMftrs8HQ2vqBEvwB+wwkA/KfcT/AkR1GyJib16A4Z6YTZh1E4DENUo/iQG3n4xLfhHAcunave5j+IpIwQ8FVax89t+bDEM4T2j9juSNmpfq6zpsUkZrTu3fkSXpWcKy9ay650hYIY0A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:10:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:10 +0000
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
Subject: [PATCH v2 01/11] hw/misc/aspeed_scu: Remove unused SoC silicon
 revision definitions
Thread-Topic: [PATCH v2 01/11] hw/misc/aspeed_scu: Remove unused SoC silicon
 revision definitions
Thread-Index: AQHcmkuH8R2Pt4RYb0iEhNKaRhmZNw==
Date: Tue, 10 Feb 2026 05:10:10 +0000
Message-ID: <20260210051008.355149-2-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: 02792d0f-06d6-4a40-5f61-08de6862aa66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ggYWbg/4X9RujpuJ9vNh0GquWKolYZ6EjAWSc1OjOx6Sy+kTMl1YGt72IB?=
 =?iso-8859-1?Q?nh3JIva/vDTTjF/w22AHyuvf5BSswPHV1RSPoRcolH00/F3FQ9ccoa8S4U?=
 =?iso-8859-1?Q?cpm0ox7K8Eb5QgM7iUi7WE3+n/iMkuJzoAZu7DbGCZEwu/zpcWTM4Oox3Q?=
 =?iso-8859-1?Q?GgBKlls5cxnwuk6H4pO1nmo92Chw+WpfCIGTm3eu+73Uj+tP7qw/XEVeAb?=
 =?iso-8859-1?Q?JnrLf45Gm0MW04xo0l/H4nhbnUKn83b9Z74GXGJCTCclUZOYR12CpMQ8pJ?=
 =?iso-8859-1?Q?jCQBvQTqPSJq+ULh78qhYYHO+IdNcELitGjiFlld61N0yISEJ+T+pdqJVz?=
 =?iso-8859-1?Q?ZFlZbQc7c/rrQjggv+Mew0+y9vUn1+tX8w5bDOl0ws4tLs3CfNJytr26my?=
 =?iso-8859-1?Q?IWFoMwfxODay0D7ZUS83hwaUcBhJzDeYOCq076PvYCNhoXcdjLrHOjFMYl?=
 =?iso-8859-1?Q?7H49yOrSyZpmvMRO0RECZ03RwtH6V4je7mLyr/81ODEI7Gf6YUdnLmKzYF?=
 =?iso-8859-1?Q?nTAT+RzYKqM59W8ER1yDDVDIP8rE7z5NuH1wD15KiMdfb5qYM3XY6DyoO9?=
 =?iso-8859-1?Q?L2WZGUQaKzBKKTbKBPF2B6enXFnsI+55YhcFbFvGBvIYKSJnsPrPZUZxlP?=
 =?iso-8859-1?Q?nQ34I8/WadaGMkODGBqO+jYGx3WKmgj8UU8aFXoA0eoGMZMt+9ck8QLctB?=
 =?iso-8859-1?Q?wO+wm+YhvLMR+cFyzPXjilFhDrexjFoynkZ+QT5I+wETN+QFY/O8nqWg3Y?=
 =?iso-8859-1?Q?qNMHqkHK876wEgBa5fkaFeZkroIVIM8U6cfYWmhKJ9n4X6fCikC/S/MjYS?=
 =?iso-8859-1?Q?HrVFbt5f7YnuR5+TK9YBmBAzKhswSwxmo7r9wkowH2fPhsGfJIVrVKpYdP?=
 =?iso-8859-1?Q?l84nyosMvYtPZiXY2q903X+FVOvLmooEPELvgcHc5gonpz+2MEbc1AH6JK?=
 =?iso-8859-1?Q?65dNkw6VTunU2cZle8Ondv3mXGD2uctKNaP842Brhop/piO9D1Hv0ebwCG?=
 =?iso-8859-1?Q?nWEbL7uomwgdCoa8y8OlNdvc6uAqhyc81drOcHZmm8Q2n9IYMLe/HlmL39?=
 =?iso-8859-1?Q?1JGYZSYCKiW663DiWs0+DzOk3WlrareFppVqUg4m3cVitVnsEgqncuEZJ7?=
 =?iso-8859-1?Q?bgXe/Mk3UgzgMpHVwulhQsR5ApgdysJhgflz+olpkaQWo883xMejCWCiku?=
 =?iso-8859-1?Q?TJ/IepuyT78e8KjoQBuO3fLw4tRo3iBV6dHjDqZprg/gvR6OOT6ZKnyZkc?=
 =?iso-8859-1?Q?vqWWZLZkJ9D4quRDDNqIH2K0mmBTLD+fn8uqhKeMDGEMdzYAk5h8gQ62+c?=
 =?iso-8859-1?Q?bkFrCQb3lk3L5YMYCWueL3WdOe0ueDHmFHB+VXDp7xfwUDtLq0UFXa6uMp?=
 =?iso-8859-1?Q?wyHrG1UoW10iq2LY6n38rPYqO4U8KVCL6XpvdD4Hpy++2OPZzBbqX4Ziva?=
 =?iso-8859-1?Q?6BelUiHMxmmTRgiG2pfyeEg3U0kK5SholeVfkd+Z+6om9dV1edP4OXIVfl?=
 =?iso-8859-1?Q?5vV+V+zwEZB+HlftyhWcj89y1FSvEmGiW+5AFzx6X8l+EAZP2t4FcPtD6n?=
 =?iso-8859-1?Q?xwW+zYZbs5iS/zNtyGuAVBAy+PY8oHvRn1b8+v54NuAvkeGXEV13HVysri?=
 =?iso-8859-1?Q?oIL2JkOb/3fPLqk71FNJdJNQLy4QWZ+tgxMmpiG25PFaBhgJqxttANgIf0?=
 =?iso-8859-1?Q?YKbLaOU1dM4F6AquGc0/2uTlSBja+3CdPnm+0y4I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HGEjxmHvrHFXr3Uq3DYagZ8lSvAHg8BuqE6y0m4s+UIZx+14kwMTpc+Prp?=
 =?iso-8859-1?Q?DongVgukfk75sCiCcLOzPsAM+i/IzzpzLb0tcQi5A4cPUS08rj28sCm56b?=
 =?iso-8859-1?Q?sIwWD+DATwsd4s+O1w8VjNVf/jKY3r0Rh7G7/PiYmDXW8qhcOUbH/djLuN?=
 =?iso-8859-1?Q?PjwYxtuLz/8gurlMn0ENtFJh+V+ugWkAvbfem78LWrMyPxZWLryGqMA4uK?=
 =?iso-8859-1?Q?EY7wIGO3OU7Sx6sp6b0gFxC85iVv418JGazw+MiQkDAvyf3gabIQK0t3YC?=
 =?iso-8859-1?Q?hqtGdkcsNhzIVo1S/0Iq4eGvK4aaXif6cN36S7EA9rKgT+c7o7R2VkQo11?=
 =?iso-8859-1?Q?PgN5YU7wneKA+sIQv7hKFsWb/Fx/iD+agm42N1X0c3eQKIR60v1sAn3dw2?=
 =?iso-8859-1?Q?zVPwLjEenu5XXoMAgWTF7EbR1so0E81AAH8A9eUOvsLDk+nP1ukbj6DToJ?=
 =?iso-8859-1?Q?XUKW4NuBeTzXrUQ+50snm/Rva42/OEK1Ou67PSfeC/i+/obXCTzM8aksaL?=
 =?iso-8859-1?Q?0MhKJXTNcMwCF91oO0jmR29u/0pvthpnLjvuR+dn61Ljy5pOIgo0Bb7p2b?=
 =?iso-8859-1?Q?Xym+BT8m0tnwuNA+yNiMDvcIibaTbqv7U7u/jq6KfeBOZvJYhSx1NSig+W?=
 =?iso-8859-1?Q?5rdeARnTs5vhtkimjlbJ7d/TvzpU03qwNzunVnTfZwrbM0F6NBXZrrg/BB?=
 =?iso-8859-1?Q?zZVAL5VfLZUd6JF5r0mRXu40OCAmKutkUgyJ6QESI5xhU43K30nxljmK8S?=
 =?iso-8859-1?Q?HH/zoWoSUzWzo9ddzKABUDMC1Hbsy/jFHxbyhRChpR37nrrmx+f1U0eXve?=
 =?iso-8859-1?Q?hZa4Ck5hcuw3Ok4qTHYeoAtpC4KK3pbpnxQVaI0ymashSSAZVhzhkUCYXb?=
 =?iso-8859-1?Q?exGU6SpU0ziqkCoLW3mgLycGIXYJOA9ToqY+3xx54rNs3Y1BsTEnVRwkL/?=
 =?iso-8859-1?Q?EO3LqQrrBFVxrNQzTMhzzvKe308VTEClUgjWy1dNXCXVCEZF0LLyWfuLkt?=
 =?iso-8859-1?Q?EGzdQMtHCcPW/1O1gIhsoyZWWhQUGAT0dLXMu3tqRCZROxeqofYx+rhs95?=
 =?iso-8859-1?Q?AvhznbOq6dKgR3fLC1+I1hF0A0oJ9xE60nG9ApNbZYHnLOEF23LWp6ugpc?=
 =?iso-8859-1?Q?dbZ1KesJW9wh8rTuFdO60plVOWsJMLaWqK15gXIb6HW2QzVRzl2h/uLL27?=
 =?iso-8859-1?Q?zMY5BaypvKJXCB/gGy8hR7CqGtvRyLNYXEPFv+gl+vuZxDWQ8GzYQUI5Ft?=
 =?iso-8859-1?Q?YKd2p1ekdiW9bKETFcLAOlWQBbN90yB6zXbRF+KZWJjRe8zUcTU3cLj2of?=
 =?iso-8859-1?Q?NrcDSUYjP+uoiChzOqa1ezviJmp4lwy3xe8c7tfIdGt9wh3dzHBqtBKxsg?=
 =?iso-8859-1?Q?E8JT3G8Bjl9GXCnmaO0BI99cVgSydQQnfMuMXDxGnfCvHxxOefLn51QPJJ?=
 =?iso-8859-1?Q?52MIroehTLdNBIzPQKcUaUD1COCU5OZrWYR6KoPx80RXYfh1Ds12KJmMwh?=
 =?iso-8859-1?Q?z91/YSSrROfH2gtHT2Jbljr+cSc88FbdMbjA1kaPz+Aa/loYCT5n0SggRR?=
 =?iso-8859-1?Q?2qYPaI4j3GLcjIAfO9FGW8xtS2xO+06cifEc23DdjEq31Bd4SefqtbPpmp?=
 =?iso-8859-1?Q?O5r/f27ym6sPafQphtRRh0J/TJdulcgeG20mT5f1jq3hYkkAVJ/xo5EhGU?=
 =?iso-8859-1?Q?4100gdt9Ca9SmsJHv6rvmHlpaQOiPGTstdGAQ2p1PNuhCf43CzimK+NrZb?=
 =?iso-8859-1?Q?+4UUtak28OyiIuOwhvHQtH6+Ycr3B2LbPgg7Ewij7Q6PxxUiEw7o7RB8CK?=
 =?iso-8859-1?Q?nytBr7W/+w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02792d0f-06d6-4a40-5f61-08de6862aa66
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:10.7493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1irfq20WsZ3GW2Tibdmn0uKJRC5jO+6zwlNS8AxCeWCvhZ458oST+JmLBe5NnH9C4Vx8rst09P7kvPkY6lfB+C3twi6l7GTXOUAfnEZrbNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Several legacy Aspeed SoC silicon revision definitions are no longer=0A=
used by any machine models or runtime logic.=0A=
=0A=
Remove unused silicon revision macros and corresponding entries from=0A=
the silicon revision table to reduce dead code and improve=0A=
maintainability.=0A=
=0A=
No functional change intended.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 10 ----------=0A=
 hw/misc/aspeed_scu.c         | 10 ----------=0A=
 2 files changed, 20 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 9e28bd4d2e..313a79f2f7 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -41,22 +41,12 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
-#define AST2400_A0_SILICON_REV   0x02000303U=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
-#define AST2500_A0_SILICON_REV   0x04000303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
-#define AST2600_A0_SILICON_REV   0x05000303U=0A=
-#define AST2600_A1_SILICON_REV   0x05010303U=0A=
-#define AST2600_A2_SILICON_REV   0x05020303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
-#define AST1030_A0_SILICON_REV   0x80000000U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
-#define AST2700_A0_SILICON_REV   0x06000103U=0A=
-#define AST2720_A0_SILICON_REV   0x06000203U=0A=
-#define AST2750_A0_SILICON_REV   0x06000003U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
-#define AST2750_A1_SILICON_REV   0x06010003U=0A=
 =0A=
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D 0x=
04)=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 6829efa2dc..0edf9c1b16 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -555,22 +555,12 @@ static void aspeed_scu_reset(DeviceState *dev)=0A=
 }=0A=
 =0A=
 static uint32_t aspeed_silicon_revs[] =3D {=0A=
-    AST2400_A0_SILICON_REV,=0A=
     AST2400_A1_SILICON_REV,=0A=
-    AST2500_A0_SILICON_REV,=0A=
     AST2500_A1_SILICON_REV,=0A=
-    AST2600_A0_SILICON_REV,=0A=
-    AST2600_A1_SILICON_REV,=0A=
-    AST2600_A2_SILICON_REV,=0A=
     AST2600_A3_SILICON_REV,=0A=
-    AST1030_A0_SILICON_REV,=0A=
     AST1030_A1_SILICON_REV,=0A=
     AST1060_A2_SILICON_REV,=0A=
-    AST2700_A0_SILICON_REV,=0A=
-    AST2720_A0_SILICON_REV,=0A=
-    AST2750_A0_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
-    AST2750_A1_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

