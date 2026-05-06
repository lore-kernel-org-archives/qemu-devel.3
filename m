Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5BCCD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSuZ-0007ow-Rd; Tue, 05 May 2026 23:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKSuW-0007nw-98; Tue, 05 May 2026 23:26:57 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKSuT-00052y-94; Tue, 05 May 2026 23:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxo/HdPHCyrsdhcGTroWM2hu8i5OzmfnAvGB8bXXnD+nZoYJ1UqvcvKswrcfFwUEntj07sabPKBLMrF5FJHRgXBR2W2SV8bUzlwZEo3Jyha7Vix+bM6JN8X2R1ZhEAhMsWYoEL6S93v2kNuIzsqyLxYZgi2Iu7J9fERyvjU0qvYcAxi6HA0B6+frO7E+fm1jr48Pe/DxEm8g15rwScGQIx88ZsJNXNLx36cSW0eGMTsQLv+e4qIIXYZtDLSirR9UEik03qCjZA3YhpMnEzfDM7Y/mESAhh572UfrHsK2LJLppCGnNRmpIuGJt9O1YY5LWg9n3fV+ueRyBZYN5cw18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOGXooWLzxCDZ+GqOIk1V+8Y/yHjhW/PIUN90IwsVzA=;
 b=f1EndKZZauPyUG8Iuw2aTkJcI8Cz4Briy+XUUJ4FbT1kZZTaQqRvTgnwO5DOa8G0xGWl/BNO+bqK8B+y/iQRx+xm51Fhafs2Kjj81Ef8ymBbFB+QFEtaa9WAcZlm9wFmJkkXLtgSyR9Bj0WuEfS6YN+nL5DBcTgkjQj2NLWT1GGY0tUEp2PEwCpGMKAMeozICbxQZgG6Az5m265KRaIw0sKrjsAWQRijyuZ6ptitKgQspEBW4hrWiRZbbDLVhSsRyLkclbfC++87Ad5IN3Hdk5CDNGtMjhRLeMju3s7ztKuctC4KtJwmGWi0dp7TRQ2hRoB1F2HmugEhW+sQN9Vv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOGXooWLzxCDZ+GqOIk1V+8Y/yHjhW/PIUN90IwsVzA=;
 b=iZMaYhL9kI0187a+N5TKCPRdlmJ84GU0yG4W2g9d+Uq7sA8N7ePLIv/6jcmoJR5wBk3PXh1HzJ/LeOD51SeK6p7gyxp7+fhBo6a82HEgNsTM45akgYk+W7LKXV2BUXM1ZtDJKkPqmxMIqUkcGHcWmYYxnnk9yTYMyzQhBiCTc/mAfYkhQS3fybc2dI1Fr4dWSZQHtNNN0Pw27RWhS21vipq32h2Xejk6SIyZU3NUDgHLoYuSyzEAo2U0FSIV93CxFfa5csDV/9j8x8UAPQG31RG6yKmZZVlgra3Tz/hfxChXHt1Bjis2HspzQF3pEPE/Bn0z5VKGWg3tfyorHqzhlw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7325.apcprd06.prod.outlook.com (2603:1096:990:a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:26:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 03:26:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 0/2] hw/usb/ehci: Improve migration helper and property
 naming
Thread-Topic: [PATCH v1 0/2] hw/usb/ehci: Improve migration helper and
 property naming
Thread-Index: AQHc3Qgp0Xg1oE7Ou0GiZ41ShBuwzQ==
Date: Wed, 6 May 2026 03:26:43 +0000
Message-ID: <20260506032643.2510575-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7325:EE_
x-ms-office365-filtering-correlation-id: 920b16d0-18bf-4230-f15f-08deab1f4bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|13003099007|56012099003|18002099003;
x-microsoft-antispam-message-info: YJ3U7KyyA5yNaqbiv6vorpI4FsQOl9fGAzAFAozEtDL2jKyO913GyZg7WsJrDF6/3MZSpm8VMaaqRA8KLqLyn86tMNI4/PXsdw1GlhfaGi0jNbH3HaNixGXc9pyTSkt9JzSoipq5NTtGoLERQvf9PN0K9YY2bE62QI6lc9dPEC3FWkvO5swBbqXBGe216YjiA2ZwhPTB2FTt78OXSraHG1xSTJbXPUw6FBh5iF3xFqZGDcmMSIO5XUpuOCWzouf41ZM07yYmtHwZZCQZY4sjD1/GKVr4WTfnKuvhy7z4gZmotXfYG+aWPu5Jb0hsSFj8btEfuxx+ZN9mbTdNq6hDPM9b5gh8edSWYQVw6F94gAsY9JTTzYy3iKiiWfkRzW9snNjsA/9YIUX7eUgpqDxCcDyunXSwptYKrY362mXzq6dP5F/QqKk7XDqrrBd4ASPeqEcDaaDJ3NEu0ryYgQSWGcQiqsgd5tGPc5fkEOY4Y6A05bcQ7SRWAhGKBHTJVF6cIfU+RFc9j2bjUd2W1/Xa/XyJxJEEkLy5Cr8wqRHTZkVeuwZlppcZ6XCRCxAxwBmDBEBW6OgTJOS699F2DRYLw7XWiaRQ68LBDfUYzCM2YnaS0GKJKaY41XLM8tqlTpzKeWj1vxGZnlMLMVQTBj1+2hsHa6O7woNWp/PPxNC+7Cvhhxp/dY7AndwGS9LnhANeTEowFvzrVUhPRMLdieEFuL9sKbTfo+gOHVHDgpYk4qlBpJFyl3Nirr6NgGJtAbQeH+PCbZjJXwLIoEp2QJgHAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D/QLBfECo3IoNfgEyBN4MVIq4lLSkbweQhuewm7HC2sb72IQdQOORhQiMa?=
 =?iso-8859-1?Q?XzKHBRefpB4s7Qw/ln4UL01sZRvHusf4/2pLmdipmRG1p00aLQwiZc94Qp?=
 =?iso-8859-1?Q?J7wFRR/RXxFQqnEGYyNL60vQIegpsumXceMhnofeYIm5ulRd69m6uiJFo2?=
 =?iso-8859-1?Q?hLtldcLx4QZM9dPdDjanKNmaJ9CwYshmqLeJKL/vMs6+8P03oNMP8kHdkm?=
 =?iso-8859-1?Q?bVH4eI2t9C/Ms5RBUVynzIXGP3fsi1839I7wjKZrbxrZFS23qZKz43+R2M?=
 =?iso-8859-1?Q?9fhtJezS03QtaRQ2oaD/tSf9cLKBHrivv0gZmXT4GuhvNaKrTP9JPffImh?=
 =?iso-8859-1?Q?Ycy690xtqKYT1XPMzIEeLaVWrhUAH1FPLZAaJD+QwJcUGqboJxNgLpNRh7?=
 =?iso-8859-1?Q?pL69go8cJbgfnVs7wpxqrtLk7WSdyZu0fUYOsKXz8B/qxut6RsZzf8caAW?=
 =?iso-8859-1?Q?YcKe4aUGn+5v0uuPGnkUrTE5trLCJ4ahjn7uJL7mR6e4hpJPVSbUNg8vj5?=
 =?iso-8859-1?Q?H8J6IiuvS+ZqF2atNkbnkCP1WlXMNLCkjUtDKknebevM29JLfMTZh1kvXJ?=
 =?iso-8859-1?Q?jzFVpXsar7EPFOm2Ch5B4pSEMOYR63OPfGI2wiLNvVOCRGMZND0WJHZ32F?=
 =?iso-8859-1?Q?L0GJhTN1JVamsEcfLEOETGQ1slcP134pkoCZ/uGvIGYQrO7ltfmihlU1Y5?=
 =?iso-8859-1?Q?bdwd5p9DuIUiNb2YAUkcZ0nOivKzmE/MOSkctDqb9kgUWHzxoz7TQWEiTk?=
 =?iso-8859-1?Q?MExgU7bQj9vlcHNnm72apPeOTuXN8fStK93RMXzHVmmKlgNv00kAM+wEQC?=
 =?iso-8859-1?Q?xbmffoO6w2BdXy/ZpnK2qDmd+QVy7+bN8uVfL+ilhrTKBmI5rdq+As3xHo?=
 =?iso-8859-1?Q?fIS6EWFH2PZk+RVSKc9aFOes8Vvdie86YbD5jbDRuKHFmQtspVjSEDPb8b?=
 =?iso-8859-1?Q?GlT62TaDnp0pe6er5RONWtZ5rid5uWqBYgJ3xDNLETH6MiqV6cSdjx950u?=
 =?iso-8859-1?Q?aUgCEDqPi6XNEUOGfR4ZeUgAvcIajSYE5wYUzCdS/YUxgFBYkIQW1JJYxj?=
 =?iso-8859-1?Q?VcNi24HPVCErZDsqUYl159Zl9K5zxjuWjKV36/4uHH5nlfqX3HX2sLiAZy?=
 =?iso-8859-1?Q?rVuGQ3qyZE3mfFc+bU2m4S9vEAtrmqiOkYRPhyF6eihyWRTHm17MIRikey?=
 =?iso-8859-1?Q?4lVHZW2gMm605wAm9Y4IsoMrxn6XYLZF1lFYOuYdojCJ6Uz6gbhSx+Bslj?=
 =?iso-8859-1?Q?h9Ke/q0qjNC8Hw0qzNvoqIK4GLrZ1NrVUegjd/1LMmi/LqcoFKq8MuZ6tF?=
 =?iso-8859-1?Q?s9xTv89xg+GUVeOxfPOob3TjLnq0Zm3sEDb93kkkK3+rZHUX/4Y8AA2V4S?=
 =?iso-8859-1?Q?Rtk4ZmRre6bQ3QBbhyL387E8L7bD6QobPy9pUwp5UOgWaOJGH8R+oSoRl9?=
 =?iso-8859-1?Q?veZjJChQN7+HCsGgpYmlb9HSDRp1VPvWfxW+LRKlYOC89vtpt8bII6SOOZ?=
 =?iso-8859-1?Q?JqKRaAW7pJvM8Cqya7Ha9McKcTg9RBGk03VFDMuL5xAo61q59nt+WmY1+q?=
 =?iso-8859-1?Q?2AqHEZp4hzsbBBPD10BBWIPS9qo1K4T9Pc8i8zGkieToEvp7if0jcbB+mA?=
 =?iso-8859-1?Q?Kq0yMes6dwyqqeDgwxB6eWZ620wsHXfcLjGkFzQODicNBgj9bU5EewBsHg?=
 =?iso-8859-1?Q?QICrlsMKceh5ZWJwJmPP48lHxZvK63IbXSElqTHs7fKy66XHmR2FgM2fSO?=
 =?iso-8859-1?Q?pZxuN8FmzuiJkpW+toTcuoKINvocNXO8FU6ggy9fJNrqoGoWPGnZAwLffD?=
 =?iso-8859-1?Q?u7FxzRuD4w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yv78BEL8zeZxnGYWLgT1PVgUTzbeboqy8cCKSYxG32Myl/FA1F97huDKmRreXfPu84JJfAM8UDDUkvS1yJ1MH8UxQwa7YEZR/gM5os4erdrDz/iJeVb+2cVwAbncGxoIsd9LmRiKtiBfXj6Ms7zomJXbaurmAqH25l8tEI3WNhpRQ9+fjJgiR8C+4iIOC6QlzcxNm6r3Pljodmo9MaIi6fdrm0KDk8Yemw7hvLm/D+kRvdTzPAUdRl1yAVFaoxzw4EPH+kpg7U5wCM54S4y3L70XrHImRCJ0hncXeHmbCEEYUewWyCsSCEm9vvcNEp27jc4L6iTSIJhZjr6Q4p+wqw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920b16d0-18bf-4230-f15f-08deab1f4bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 03:26:43.9973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlI/+MUJFIRFR3ZMvgqbrfTikL0mIHw4c0p/usZ2G82//uuIWFalZcS7uOyoSgrDrsjXMAuz7QnCQEEcFFA1xnAAuTHqlqU4/k86XGJ2k/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7325
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

This patch series is based on the following patch series:=0A=
=0A=
https://patchwork.kernel.org/project/qemu-devel/list/?series=3D1089061=0A=
=0A=
hw/usb/ehci: Add 64-bit descriptor addressing support=0A=
=0A=
The above patch series has already been applied to the aspeed-next=0A=
branch of:=0A=
https://github.com/legoater/qemu=0A=
=0A=
This series only contains naming and comment improvements based on=0A=
reviewer suggestions.=0A=
=0A=
This patch series depends on the aspeed-next branch of:=0A=
https://github.com/legoater/qemu=0A=
=0A=
v1:=0A=
 1. Rename migration compatibility fetch address fields=0A=
 2. Rename CTRLDSSEGMENT default property=0A=
=0A=
Jamin Lin (2):=0A=
  hw/usb/hcd-ehci: Rename migration compatibility fetch address fields=0A=
  hw/usb/hcd-ehci: Rename CTRLDSSEGMENT default property=0A=
=0A=
 hw/usb/hcd-ehci.h       | 23 +++++++++++++++++------=0A=
 hw/arm/aspeed_ast27x0.c |  2 +-=0A=
 hw/usb/hcd-ehci.c       | 14 +++++++-------=0A=
 3 files changed, 25 insertions(+), 14 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

