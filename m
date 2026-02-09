Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE02CE78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNNv-0004Yb-9W; Mon, 09 Feb 2026 04:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNr-0004Y9-0E; Mon, 09 Feb 2026 04:16:43 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNo-0007Gs-81; Mon, 09 Feb 2026 04:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAYKKE3T9xVfYm7/YwBScIBEC7YBSlv1eajW5JH6Qcvrm11pzgck6CQnAuIGkjvliQtX+mRsO4K0iMDN4UJ81fbnGrXJVDL5K/iFp1eOZMAtQme0lnA8kDvrfi2ruT0s1iv5lnUaWPXClVpqg1AXtRGoBbdcgCQ1ktxvZhOLTM6+0ysn8RXYTpvTbCLjf6blaXyiwyOD0fbNik+o8xMfv/dqqPbFfb5+taDMwAYnsiS+LfxV3U/m6fshK5Hnrh19vYnzNgwAlsBUt4HqUvFN4s9N24UeEQpbeVLJl4vst9GQoiAE2LCYEBtZaqwigpY4cdfXtflMe3jlNmyV2+jvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+5keS5v8lYDwRxtEZDYZuulvMcJQockFMVxwrf8pzk=;
 b=xRHqeAXPBtRu5iAbZ0T4vaTXKerpnJ1qsSNUBc6U7uJdvWN24bQke/VlH6HHnIT+cR5YkjnDpZfhOnxrwZma3A+MnD0B9elN+otyHFdOVL4vTrW8e0ctVaHe+nUi3VBEpyJg652QszZquMlyzuMM2vx7HLUNZ/YoZiHIwjZpF3U9RJbJQjfZQmk3cOqZ5diGuh0tM5l5tQrUGXzFO8GHo2sPtN2s03g4J1SWdtPwJd49g18X8TPrUKbuQZEToMKAcIzztYWWpNTB2CFX/4aFtFW4Qhj9JrQbCP79gHWgA5dxPcbh4BZDTUbWh9keE4wtapzHrPgATae1RdMO1k9B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+5keS5v8lYDwRxtEZDYZuulvMcJQockFMVxwrf8pzk=;
 b=dkQUnYnsIw3kIlkBcr0S/2h9DFQYS36xdmCMg4e3pHznmPbdwawNzMqYeH4x8DpIaHzDn9AOy9LegBsvzSXAtDhyLNmYdrDNpPUFAmj4nzVPYf3X3cMtWds7IvMJ8QL+u0fkjWpD3qXQb/X3m8uBN1CE0fNgVvt/VDL7Q/ZAOUVgDYE3dzxxWC38+q2MLRFzIn2qBH2DX0Bx97lCri+Fe2s+bK2RSWQORkBvxujmtx9IKabKV6qj16sw/6a/wU73Jv51jGCv3BVDN24haO6uEy8a617l4wB9rY9uuVufUX7j0nzZarGzUE4StVyVAfFPhWZUIMzP/5HqSHWQYn6TZA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5250.apcprd06.prod.outlook.com (2603:1096:400:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:30 +0000
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
 <nabihestefan@google.com>
Subject: [PATCH v4 00/20] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v4 00/20] i3c: aspeed: Add I3C support
Thread-Index: AQHcmaTGAK3P8i6Cj0uBkKFBvVTvPw==
Date: Mon, 9 Feb 2026 09:16:30 +0000
Message-ID: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5250:EE_
x-ms-office365-filtering-correlation-id: 877405db-989e-49f2-00a9-08de67bbe943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZlrmULTjdumskh+MJTLP4BdjAshnOeOF9J4dRzZTLL5Ms88eWnxLmmVHz4?=
 =?iso-8859-1?Q?aw2BAmwnxdNqT0TFLIB/Y15yuoHF1Iy4AVFr3mch8SSWH5P8Mlzg6BhukA?=
 =?iso-8859-1?Q?ipHzukLgyJmEKRCK/PPsjU0q4MXgCA1LaoYunR/6yrHoj2/bBPudmRa8Tk?=
 =?iso-8859-1?Q?3NMlWEuZ5WNnr1iSokvCAL5THJXIcFO9GNYH7b5cPc01+oDU8E3betAi2f?=
 =?iso-8859-1?Q?Qkg2qJHx2Trf3NvCAGfdTPUz8q14bMsfFeK1QymJspw2uflWBeFuC5b9T8?=
 =?iso-8859-1?Q?BPo2jzk5caXe0RrJfejFFWkrY7DG4/hMq6ebIM8cLbdqovl/qgcSlR/msL?=
 =?iso-8859-1?Q?gETSKXsQvUOYahnR/Ljk1VA0cVUQGutIsEHdrNib5GOEmsGHhVfD8Nn1ZN?=
 =?iso-8859-1?Q?I3prBjXqEQbqo+ceWEvMEEzGOWof12+ujrJo+ct5vBD/fxGVi4SVTaq7ji?=
 =?iso-8859-1?Q?YfKLsmlSSdDcGYwCtkpiMu5tNWxLH+4PGfVsizyvGVvyMsh6o0N22oZZMp?=
 =?iso-8859-1?Q?/3G/xZgn2YdRVNH46CnY9jNYVhSEDStpN67YQVGLbMPfIPITe4F0jfEYf/?=
 =?iso-8859-1?Q?Jbg/upd2qYQ4J+dn1JT/1r/3ewvzBo3aS1yyRld3QZl7/sV7RgCjZ+3UPK?=
 =?iso-8859-1?Q?MOVkqbsNAFE+TdtV86JNLJkJC8B42gejyk3dMDyKohCJXkb0IrCmgyZtbk?=
 =?iso-8859-1?Q?CHetdQdx/6rxXsPNoXnu/Qw02G0CtiXhWvLiPhUnSkNUbpCziay10ZO+u0?=
 =?iso-8859-1?Q?qzKpyETQKZJX9ggT5UuPWe+wEz5O7sEjebIH/7EI6iOHYkvUoWnmywMTFf?=
 =?iso-8859-1?Q?/bR4X6TKAGWN/o/SIPnp3WFTE2xTGRBvPnFtR2dhM5SYBixitTZiHJVSod?=
 =?iso-8859-1?Q?y2RaB17cXaQ4rXc0iNOVYHwYdfMOF43bVXWxvYQCKUAYpus+LEYVRTP1Vj?=
 =?iso-8859-1?Q?/sXdMTauZtuOZPvspEAluko/xJ+qmNYRbXsgRMS7L+slhEyyWJlCm86ZAF?=
 =?iso-8859-1?Q?2miJFEKln8h3xol0qknFm67m+vko3m8x7Ic0g+FcMlYX0WXUMtitzcHPnK?=
 =?iso-8859-1?Q?ZoKkLaiouN9D4/mD9dZu1dp+vMqMqDW2eHgXPUe4N3CtnV+6q32v9HLN47?=
 =?iso-8859-1?Q?dtnrZsITwVO7ghBJ/xg1ZNFYIf5FWk9Q4e1xKE20RENKtGc6WNOUn008oo?=
 =?iso-8859-1?Q?l1fpZgjugpmPW5m/g8fXttGpGQMO0elS+wnpI6DGGI7LPj1u1DdZutYyo/?=
 =?iso-8859-1?Q?EKxAqQ4KHmK1cmQne2+DFwhaaFz6ht75V4e3QLda82T/bUPyfNo0itvMef?=
 =?iso-8859-1?Q?b/M7DpIs+RegQEYD/Yih/0JPK3HYt97LYkWd91wLJlDwx6itaTMJAFc2ND?=
 =?iso-8859-1?Q?gbUW2PkbQZW6Dfx1X0QzS5skwcozDFgvcjMGhBL+TtYGDNrw0fHpxEN+Gx?=
 =?iso-8859-1?Q?nhJUNMD0Y3SzVArw+IOC//Tf3uep9Gn30rMirJBntk6A4RVnpdB8rSlH12?=
 =?iso-8859-1?Q?XjjGgdCduHS26hcz7RILFENKymGiECuJ2MgdRSqYxWcAP9CTG0S1qkN85b?=
 =?iso-8859-1?Q?S+F2mSMBOyjidSLY+c7dfikJ/vHe9vrBp4/vZXf4XpCvJ9DZ2JOCHWOxff?=
 =?iso-8859-1?Q?qIAln474E/2YiLMv4muFPJ/GU6pU8sqKKB8c9FgJQtzATfHLk9esHdCfEe?=
 =?iso-8859-1?Q?SA/7k0EirbWumh+G4h6jez+nZOZEutYbJhPwuhHf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PpspHePWl227i6o7YslO5ZOJ5uMPTnSPjmbBERxEy+qrErbOyR+GCcP6af?=
 =?iso-8859-1?Q?ijS7jwdKVZ4GFaq8oTvGrNesSM3bizepGe1fQERma4typsCDX7brpyq2zW?=
 =?iso-8859-1?Q?6/Kwj5tgNkUmyXTpsy+kEt0kakC7AnZEQ/1jNWx5Cdvsn3Ihuo8GYNx34q?=
 =?iso-8859-1?Q?19DdiVTuz5whefiZC4t3CgC0zZCVyVqVuQTTdGtSLHbpMqfsIgT1LEsoXP?=
 =?iso-8859-1?Q?/kdktaa4kQtu2gSfsxJ2bcFABav+1E8+DQUyRa0dZ5cOUmwsfjDlS+KtoX?=
 =?iso-8859-1?Q?ZdAgQSYhIQEIqIdbqP1y4Or2OFJ+A9mHb7XIEIPjUQ9+Wqzn3VjTPOt5EV?=
 =?iso-8859-1?Q?dhLZWNCV67PPGq/ZDH8Q+qfoWNNZ0kE1aFqR0DAxOEeY7vboH71OBnudqj?=
 =?iso-8859-1?Q?5qXv3QjUv+z23ASBNTflLllZBMDSm97Sn5dNviJKN0xbZPLrAM8df9iE7g?=
 =?iso-8859-1?Q?BA6phmeLeZG8rO/rGGxqGSdcmi0utkbfzLZ8rffJMCBb5c21DrYqfigfSW?=
 =?iso-8859-1?Q?zBzBtKUlUlG1HAoWFfeIsDFUEm2QhU28bZ7wDQykFZScpA7MFLi3HLB3q7?=
 =?iso-8859-1?Q?UVHn8+4AS8/0T1HByP1AsPNrWJfY/Bkn9xwLWTvLzWLBtswAmsM2yAoXa8?=
 =?iso-8859-1?Q?S8gjJEkqqF30S1Y/mVir8Zpdig3RtfMEzpr3f0/WCjSGf5ou8nrc/cIMzR?=
 =?iso-8859-1?Q?EqY503nyfRwVZgGlgHHb3XG8dVl6qqUHPVLq7WKV8rDiBKHkpxkMkuhlwD?=
 =?iso-8859-1?Q?yrHS+xywMbYBCfcPztDw3I+SLWoP3DRQIdY/s+HtpFQ/5xRHeYV2IwGOrb?=
 =?iso-8859-1?Q?yKYSzoNrsF38iIGHqvpKgNAa0CQb/zK9l3yf8NLrZqOjhznDb5TBJl5Ze4?=
 =?iso-8859-1?Q?NtSjL/9oPNkN5NP6xsnXsV6JxJWRfE0bySCQ4AC5Cv4LwycfVEuRHwiywJ?=
 =?iso-8859-1?Q?zYAEFZ/Tk5ZCm5JwVK367H+ShwaVg/oBl50dWEDjs3kxoKBdMbGmHQyE5q?=
 =?iso-8859-1?Q?AHOLk9uzESrxFvpDSlezB/NGwEc+0OjNBGeZGAmjuKVjGD6oTze1luz7Z5?=
 =?iso-8859-1?Q?pyLbKhPNxDxagTgT7fN/BW7ez/FpI0naCjRUoAPAQ8VsIiHp3kgv4++6Ww?=
 =?iso-8859-1?Q?OkQPw7n6HajE5QHttFVIdmQkb0UtIFJizwDpK85G1PRdB/S1IDpnz8xTis?=
 =?iso-8859-1?Q?7JrGfYpKdv91lFb+yi55J/zEysyBrd6qJHl9QivZi8LAKSvAfEcAkqSZ1p?=
 =?iso-8859-1?Q?36S3NIXh/pkp3SBafdoL8ODLPbD1nzSO4CHxhlnzWkw4aDVpiz3rS987PK?=
 =?iso-8859-1?Q?3He+5VP1AS9TvECCD8MXJjohH9oOquTNiS2+NysJwVqdwngscgMnY2Thfj?=
 =?iso-8859-1?Q?Di/mK8hPkEoENyRNsMvhmcafL0iph6MNq1vN4o3+rH3Sj0ZYy2BEFz87dm?=
 =?iso-8859-1?Q?O4h8lgrCp5pXBugphVlFk53ymGk5ylE8rZJ+WfoRE90NHgngJ2TomVvpmY?=
 =?iso-8859-1?Q?Dvk7WQGMqx5+TfXJxpgelIxBjK/wm8n9N29+tCC9gEOQzmoZ1wJ+9UUcVo?=
 =?iso-8859-1?Q?mgZMoL9FuupjrcQjIrrN6Im2wCSy69advrrALw+TkvPtXksMgL+vyMENSU?=
 =?iso-8859-1?Q?ArlfqWBbz0CVnIJCVWmKScPDF4qdkX2UXsiQRgzYysPpB7afDKxDuewRMv?=
 =?iso-8859-1?Q?sn3zrcZclq99MhHJN/vXtnlMykD6xYpC+BXvWg3006PqFEy0xLzYI5thpy?=
 =?iso-8859-1?Q?YorWi8WaBlTc1VGqfUMnpF8IAoAObkIGebItLeAaF9zWcplCYeynTz/3xL?=
 =?iso-8859-1?Q?z4VTjrdpZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877405db-989e-49f2-00a9-08de67bbe943
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:30.3115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMauiBEVC7ORfHu2jcfY0Q/8NXxU1s2FIbTUlSEzRGMgLWtXyVCLB0iKAmHQ9bhujYVNRoLvmvTTlGyZ6n12/SEg2zJOo9UR7t/RuLgF1k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5250
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
Jamin Lin (1):=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test=0A=
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
 meson.build                                   |    1 +=0A=
 hw/i3c/trace.h                                |    2 +=0A=
 include/hw/arm/aspeed_soc.h                   |    2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h         |   22 +-=0A=
 include/hw/i3c/dw-i3c.h                       |  201 ++=0A=
 include/hw/i3c/i3c.h                          |  277 +++=0A=
 include/hw/i3c/mock-i3c-target.h              |   52 +=0A=
 hw/i3c/aspeed_i3c.c                           |  261 +++=0A=
 hw/i3c/core.c                                 |  669 ++++++=0A=
 hw/i3c/dw-i3c.c                               | 1864 +++++++++++++++++=0A=
 hw/i3c/mock-i3c-target.c                      |  311 +++=0A=
 hw/misc/aspeed_i3c.c                          |  383 ----=0A=
 hw/Kconfig                                    |    1 +=0A=
 hw/arm/Kconfig                                |    3 +=0A=
 hw/i3c/Kconfig                                |   15 +=0A=
 hw/i3c/meson.build                            |    6 +=0A=
 hw/i3c/trace-events                           |   47 +=0A=
 hw/meson.build                                |    1 +=0A=
 hw/misc/meson.build                           |    1 -=0A=
 hw/misc/trace-events                          |    6 -=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +=0A=
 21 files changed, 3730 insertions(+), 407 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (63%)=0A=
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

