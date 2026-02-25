Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC41F5543C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4Nr-0003A7-7h; Tue, 24 Feb 2026 21:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4No-00036a-U6; Tue, 24 Feb 2026 21:12:12 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Nl-0008Tw-9j; Tue, 24 Feb 2026 21:12:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKnGqua477rPhQip1BFltsGmEZpTNuuhzZ7zLlovJtx2MtUk9HzNDiBLeV3Jte/u4B3vzQTwmopIGX9i8vLUqztDu2EGDxz0AOsHm8d1gqjSc1cxqDEE1V45Fr4MTUIRfhXnXbj9EaIlwe7PhzY/Q3RMw0GDmeozOE/LOOnBaQINRY1SJlisSOy15a/9eJwcKeOIMlqrSleHr4W5LC0rNmfRr9dMFj9VIHsxGHYsvT6RyM2xFmA0VDPIIKR7vYJIN3PcdSUnX523GtGEWKh2ToApOJMCJbAK3jHD6BAR6OO67wIkjhuKPQjlrfwyxIUSvSXgT/AmLILgiTUJu/xM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWglK6l7Tj52CxkZZeE9TcDawPBYc5xyCWce2/t9ksg=;
 b=SdocBFHXRObWem3B9yWSkx5LQWdlw7NVwaaMSZW98majWdqyvvc2xHkyFasAqLIqPrKwqTidZVTKyjTPbRAQ2qxPKUaoXMClp+I4SiofyUdYs9IJfpF0xDBPvXMdrkE87zP8t8zO5kiA08d3R8HHpcvO6VC+j5arbaoBSNxzPiU5pTpdkj7O6MIn/YTEUINl8aAs8SGx4ovSEztn5s4/5Stl7CkQ7YOqpEjjFmfq86zyignCkiipydDMoGk4mFbyU589nPuU92PAzOkLLdAue4zAcKzVZO1Nyp1JLSWIV092sh4v2g+3QKXf52f9COxhB8vaizn02PbBHx8yWfwzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWglK6l7Tj52CxkZZeE9TcDawPBYc5xyCWce2/t9ksg=;
 b=Jr3AvIHapoRzI3iJySKYB0X8iKkoiNj/D51BYQ71iZBk778t/QC5mYSCeyN/WqLkK0ItbVgrX3CO4BbFQ6ZL3h4gnWITLDe8Zg8pEQy37KuU1d+h0MxzIGo5WivTuk4Io+w0Siqn/vfWKa70h7YaiSLXe312uNPRbuPoc9NhPitswiF/6f7yl+BZrZB2NIf1IF6u0jbrgqPfChpWhTXtP9+zsWh2eNwzUcy9ZG8z/fyA3TofK+gxquPsraxyT8n3XVbx9S1uhtuOy91ZZJISahEIqjlWo0EG+lpG5rDO3PycIYGgrUsKMia43aoOkhCSxCNfqDxhvuF8EpCguJGiWQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:11:59 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:11:59 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v7 00/22] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v7 00/22] i3c: aspeed: Add I3C support
Thread-Index: AQHcpfwfgTVH01SKLUaJKnjdch9weQ==
Date: Wed, 25 Feb 2026 02:11:59 +0000
Message-ID: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: 87880747-1c09-4363-4bfb-08de741341e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?T40FowPx0qKurV11xQVMR7L80nyRiXqEaSkakn9rvBstC3knKC1HRY1jmL?=
 =?iso-8859-1?Q?xld8n+n92ZTnqxCOKDy7f1AyxuZCTGe5Ka8g5z556d4sH3HIEaBRUbsjyO?=
 =?iso-8859-1?Q?PxBPi13gj0FjuMmF5LpCQqSG4/Msqodc4ZUKwHrOe7W6RjSvFvPGhjrSHP?=
 =?iso-8859-1?Q?V/CCX4XK04Z//3+W8+FadHiMy3hUuprNvSRH7RCFQpDnsMpr4HQPjoQnfO?=
 =?iso-8859-1?Q?0A2FS+RJ6ClzkZ58Xf7Ic1VadsCQ0x8WeKrEj4TfltIYRU7wvKa68NDBdO?=
 =?iso-8859-1?Q?mxYMsLWkupwRUXkpZ1/yuF2KDkXFTCsZl4Y+DXuvq23c4TC3IZN72qTdQ1?=
 =?iso-8859-1?Q?E+jFHoU2ZbwE8JYQFfwH8kPBtQ+NFKQShHb+707BbqCCAKHfBfUCILaYh/?=
 =?iso-8859-1?Q?CRR3OO0M70QAx895Tr4UDeZ2KAc3JGMn8jvyjO0bFnZMXigLloNKzcqaaQ?=
 =?iso-8859-1?Q?svDVD8FRdG9nTxuzvi20O1SOMbT4KxsfEkZ8zZ9n7lltvz8iefmd1IzXZn?=
 =?iso-8859-1?Q?ygARKh7L79+LQQ7XQsEeUE9eGMtRPpOjaslCvSxpoXrDxfYEqa0GVTYVX9?=
 =?iso-8859-1?Q?wQsNqR29CJupCaPWWIYZs8Uds7bVS1BEK76IqwZIk8tPKLZz8VS8QtKqPK?=
 =?iso-8859-1?Q?r8B7tMpLnkXE0CNLhp0K0u7tqL26vp94U5uwF7xZvsv0bdvQ9PqhUu2lX2?=
 =?iso-8859-1?Q?XKoIe1dTdUzAYqkFOpwG0s5ptOTIo2Ig9oC+uqYD7wu3E803SPwVWcLboB?=
 =?iso-8859-1?Q?QsO3yTf1Aw0onojnU8yiSmsV1iDGHdvfidfWS8hy5MK7gHS870qT7AhfqS?=
 =?iso-8859-1?Q?6cUMKmd1Fj34TQyNsv1jU+Q/G8fUv62qAYE7WozvVQMKXAFbAND4ZX15WM?=
 =?iso-8859-1?Q?yqW9gZEXUDxOqu+YQiAdNl514AdPAcN/nJAIMpY4+mKMKgVXFXMCIEX9vX?=
 =?iso-8859-1?Q?rVVY8067AfSq31tvupdJBgEAbXJM9IjpNq8AWtNwSXEqZXbn0HNoqjHlby?=
 =?iso-8859-1?Q?9o2lL9YIDU8iV9TXf8BzRxKvN08AeSnn/S4m6DyPORMePhz+aJx4B/vpaa?=
 =?iso-8859-1?Q?bA3s8NF2NMxukfuN1661K+NUokn1rOT3Jy+jwQSeSvgQ20oioxWBBpWgSm?=
 =?iso-8859-1?Q?ENenYCiNBz77yph31csTiDXDR8s2tt771fTPFAGJkAYVVc9OfqgcJGvv8F?=
 =?iso-8859-1?Q?XWILB/BxximFNPRNN1nctknIKp7xeenyI+es9qZx9e6JjkPwL0KiLYFlcV?=
 =?iso-8859-1?Q?45ilArw3dqusZ4pJuLlSMGkspf+A9KM+Fy6nGux8bT/AtRZLnRTWDZCQZb?=
 =?iso-8859-1?Q?PkMnNYHrmmWxD/FkjL25trKmsnPWDaLKc4JcvgQbq0PxqAxfzgXCWKUv0K?=
 =?iso-8859-1?Q?loQ8CHQUczrilBdIrUd9cZRaCkAO9PcN9TlykPp9Yuo6TfemgZ4McF6McI?=
 =?iso-8859-1?Q?C7F5dp0BeOVAdg4KJhX3yk4QY1kLuOoT1sYvLsyB8lBMz2D7CzdhJdFWSE?=
 =?iso-8859-1?Q?wDHDY2rqx21yJ89Fg0ik3ux63tHJd7sAUgTiilbdO+m3JLUBEyBoJBG+xO?=
 =?iso-8859-1?Q?DcvX+orh2X5WFKdBWbz/7RpopiwJgFDn4K0N/RUlSXyc7kJinKtrFe9xFA?=
 =?iso-8859-1?Q?nSyGKxKnRJFpvULywgZLq220/WyQtXHUXiLhphAiZRg4hLb/f/HzhKnXeT?=
 =?iso-8859-1?Q?UXJWmSnE803DIFrictqZ2tlFfNmf0rCNF5BZoQh7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f7zrfKo+cHx8GSORErt/lq6ho472P2egXDqna6+o4Yla0nbaUjcE64rhde?=
 =?iso-8859-1?Q?6bcynVaP6j8vQOJNfGKLro2ubPtC9g/ENw/kjbET8K6EupGLwv8DPXbeBm?=
 =?iso-8859-1?Q?8ALD2kHjkfNVsiScNCqOZBp7ABUFEZ+HoViSA7Hy2zXhCz5ovq1hnBG3au?=
 =?iso-8859-1?Q?jSKaxm+gylCzcz+4aegSoD/SFfPxD90Ri7VoJrLYJQWqM+KA00uCOs4yL5?=
 =?iso-8859-1?Q?xtidA4H1IeKVgq8khF8YqW+qLamSE3Gf586EieOtNSrrF2/6qgWChrEOo8?=
 =?iso-8859-1?Q?FGSsR0za0+QCTZlOy1fRJF86Ivh5TVxTeaxdqQQlM5gX+HSZVT+fNzjLkk?=
 =?iso-8859-1?Q?7aRGAxFONw7RHInVyCdlvwQhNISji8K8n6B0QBBZPDeK5ZNcmX3RtElfuW?=
 =?iso-8859-1?Q?fduVS9RgAwYT2V3GZTjNCQNij3UoKN+mAiIYReilYs0CyogTLP7fwsw7BN?=
 =?iso-8859-1?Q?M7nDTrYfDhp6f8Ct9QNmZtuHSGrKTG9IK+99qzNCAXZLJ4rtZSRotTtCMZ?=
 =?iso-8859-1?Q?GMnLquyISdxFAUjbsAb7RqhyB6kLgsNRbXMq/xMYG+aVpyUCGKAGeZkW1M?=
 =?iso-8859-1?Q?Bq0/daY9xCxBG9WReAoWYDVuJQbdb710rV8MFUxeJCQ71AcYbGuj3rxQMV?=
 =?iso-8859-1?Q?CU/Vyuw5O3OLO82n71L3NxOgw3PZvySQ203uO94Rkfq0Pw7E5crY+egpLv?=
 =?iso-8859-1?Q?YqAlYC4JgMeQWsCGx3ivKYkG1x7tbQpbwpQ/F1zxexe1gEdxXdLNSV+rpC?=
 =?iso-8859-1?Q?PhBW+XCL1+0ugGmDLiqwWE4fAUbuye5T8gOWVmBXLEXesyfum+DBWQzI71?=
 =?iso-8859-1?Q?1nWt/RaE2AbZjCgFLDaJo2GG/sltjXZSyFTGPUDO7b9HsQry7eVdnxCtzH?=
 =?iso-8859-1?Q?y9iWDvxgcxFeRNm0QJWw/ziO8CimxKFgYtDzxKethlILpUEdd31fHVMLwQ?=
 =?iso-8859-1?Q?sHWXY4A4f6r8dDNvoF+lGB2V76MWXUGlbiZSzcbC6OKa+1us4gEv7B8SfC?=
 =?iso-8859-1?Q?0OHIwRpkg4Hjuw9JeHZz0d2SxympXlY6Lge/YDY9bw7wKACXyWlF6Kuyeh?=
 =?iso-8859-1?Q?VOtkSWlbrfta49LbrAdFn4nOzhAVFNGav61JH4zwcBgvwmzgOpNgYSoJpI?=
 =?iso-8859-1?Q?e7LWCNqDVNx/FZLMZpMpdpNN/HgCTCX+T/WCk+4ggLMhIpY8ctWH7/SAvq?=
 =?iso-8859-1?Q?5JifwG97mlMd7oa+MQAhvvYZnCQr7x2CEqMf/ZJtY/TbGWlEf8fWTlKNwi?=
 =?iso-8859-1?Q?UNb/fmnnSj5V1GsnRQtU4Y3QlUlZ8GxX7/jBfg2hl+2bijL25ye6KGFTsR?=
 =?iso-8859-1?Q?uN4u/FUkuZH44L+h4fddeKzDp5kVs/sV7EIxHDwF58YRzevU3D+wfXAQaZ?=
 =?iso-8859-1?Q?Rx96NXZarPx3S4qwYQBEWcjYGQyKVZQMu+Cdv6cstfy2rr3mvYI8NE62DT?=
 =?iso-8859-1?Q?EaigR37cUjxayIuhQJ2du6atGuV/KjUJz4UjWuKudGfhrEOGz3LJDkVFMY?=
 =?iso-8859-1?Q?TOajIydkeKRJYeVJiSY46V+Szyvvzrqd84i4vrARU1eX56gP6bzziOWERh?=
 =?iso-8859-1?Q?hLXMdbgLgTbm8ntu2xMrMBPirX78vLFIsOUaVIV7NVcdgjrU0wr0YhJHVk?=
 =?iso-8859-1?Q?bXg7lh2Bht2/EJuI0Wu9X9sIY5reBBi6oGanEzr+NtLiAsiq1s8a4NJsGm?=
 =?iso-8859-1?Q?jPp52AGuduxHA/HGzJKtXKGeaDnu0YWMXfzDGGbp099j6vBA+Ctsh4zaCn?=
 =?iso-8859-1?Q?FbHDkrOvoooZ+aJ0kIqWnhxe7jNYy6FWF/vMjQ7cXXRYh9sB9CZYtn/dOa?=
 =?iso-8859-1?Q?lNHHTE8X8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87880747-1c09-4363-4bfb-08de741341e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:11:59.2099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRnOkb40K7QAy+iqN5+v4icHmmbzUnCY60ciGJVm/LB6mNbUOCRCYthm7mrZVghbrV8LkIQEWVEgMQON7Ga4jSNmt7KwbESzhVeUuI047sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012
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

v1:=0A=
  The initial patch series was based on work by Joe Komlodi <komlodi@google=
.com>.=0A=
=0A=
  This series adds I3C bus support to QEMU and adds more functionality to t=
he=0A=
  Aspeed I3C controller.=0A=
=0A=
  This implementation is a basic implementation that introduces IBIs=0A=
  (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't supp=
ort=0A=
  multi-controller buses or HDR transfers.=0A=
=0A=
  First we add the I3C bus and controller model. With that added we extend=
=0A=
  the functionality of the Aspeed I3C controller so it can do transfers=0A=
  and handle IBIs.=0A=
=0A=
  Next, we add a mock I3C target. It's intended to be a very simple target=
=0A=
  just to verify that I3C is working on the guest. Internally, we've used i=
t=0A=
  on Linux to verify that i3C devices can be probed and can send/receive da=
ta=0A=
  and IBIs.=0A=
  This target is sort of like an EEPROM, and it can also send IBIs upon=0A=
  reception of a user-defined magic number.=0A=
=0A=
  Lastly we add  hotplugging support. The hotplugging doesn't do anything t=
oo=0A=
  complicated, it just adds the device attempting to hotplug to the bus. It=
=0A=
  is the device's responsibility to hot-join and go through the DAA process=
=0A=
  to participate on the bus.=0A=
=0A=
v2:=0A=
  Jamin Lin <jamin_lin@aspeedtech.com> has taken ownership of the I3C patch=
=0A=
  series for upstream submission.=0A=
=0A=
  Changes in this version include:=0A=
=0A=
  1. Added I3C functional tests.=0A=
  2. Updated patch 4 to refine register field definitions.=0A=
  3. Updated patch 7 to correct read-only register field masks.=0A=
=0A=
v3:=0A=
  1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
  2. Fix a typo=0A=
  3. Fix ASPEED mail server issue=0A=
=0A=
v4:=0A=
  1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com> at the end of =
each patch.=0A=
=0A=
v5:=0A=
  1. Address review feedback by updating the I3C bus and device to use the=
=0A=
   DEFINE_TYPES() macro instead of an explicit type registration function.=
=0A=
  2. Rename variables to `parent_obj` for the parent object and `parent_cla=
ss`=0A=
   for the parent class to comply with QEMU QOM coding style guidelines.=0A=
=0A=
v6:=0A=
  1. Add I3C maintainers and reviewer=0A=
=0A=
v7:=0A=
  1.  Add I3C maintainers and reviewer=0A=
=0A=
Jamin Lin (3):=0A=
  hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and align parent_obj=0A=
    naming=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test=0A=
  MAINTAINERS: Add I3C maintainers and reviewer=0A=
=0A=
Joe Komlodi (19):=0A=
  hw/misc/aspeed_i3c: Move to i3c directory=0A=
  hw/i3c: Add bus support=0A=
  hw/i3c: Split DesignWare I3C out of Aspeed I3C=0A=
  hw/i3c/dw-i3c: Add more register fields=0A=
  hw/i3c/aspeed_i3c: Add more register fields=0A=
  hw/i3c/dw-i3c: Add more reset values=0A=
  hw/i3c/aspeed_i3c: Add register RO field masks=0A=
  hw/i3c/dw-i3c: Add register RO field masks=0A=
  hw/i3c/dw-i3c: Treat more registers as read-as-zero=0A=
  hw/i3c/dw-i3c: Use 32 bits on MMIO writes=0A=
  hw/i3c/dw-i3c: Add IRQ MMIO behavior=0A=
  hw/i3c/dw-i3c: Add data TX and RX=0A=
  hw/i3c/dw-i3c: Add IBI handling=0A=
  hw/i3c/dw-i3c: Add ctrl MMIO handling=0A=
  hw/i3c/dw-i3c: Add controller resets=0A=
  hw/i3c/aspeed: Add I3C bus get function=0A=
  hw/i3c: Add Mock target=0A=
  hw/arm/aspeed: Build with I3C_DEVICES=0A=
  hw/i3c: Add hotplug support=0A=
=0A=
 MAINTAINERS                                   |   13 +=0A=
 meson.build                                   |    1 +=0A=
 hw/i3c/trace.h                                |    2 +=0A=
 include/hw/arm/aspeed_soc.h                   |    2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h         |   31 +-=0A=
 include/hw/i3c/dw-i3c.h                       |  199 ++=0A=
 include/hw/i3c/i3c.h                          |  277 +++=0A=
 include/hw/i3c/mock-i3c-target.h              |   52 +=0A=
 hw/i3c/aspeed_i3c.c                           |  258 +++=0A=
 hw/i3c/core.c                                 |  664 ++++++=0A=
 hw/i3c/dw-i3c.c                               | 1862 +++++++++++++++++=0A=
 hw/i3c/mock-i3c-target.c                      |  298 +++=0A=
 hw/misc/aspeed_i3c.c                          |  383 ----=0A=
 hw/Kconfig                                    |    1 +=0A=
 hw/arm/Kconfig                                |    3 +=0A=
 hw/i3c/Kconfig                                |   15 +=0A=
 hw/i3c/meson.build                            |    6 +=0A=
 hw/i3c/trace-events                           |   48 +=0A=
 hw/meson.build                                |    1 +=0A=
 hw/misc/meson.build                           |    1 -=0A=
 hw/misc/trace-events                          |    6 -=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +=0A=
 22 files changed, 3723 insertions(+), 412 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (53%)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 include/hw/i3c/i3c.h=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/aspeed_i3c.c=0A=
 create mode 100644 hw/i3c/core.c=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
 delete mode 100644 hw/misc/aspeed_i3c.c=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
-- =0A=
2.43.0=0A=

