Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE338E78D73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO3-0004g5-Vi; Mon, 09 Feb 2026 04:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO1-0004e3-Ar; Mon, 09 Feb 2026 04:16:53 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNz-0007IQ-TA; Mon, 09 Feb 2026 04:16:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO8EKG8bRhVytb6mxOErr7njiBdcDx2DzuVyv/m59NB0NwFky5SIHFpDwum4jUmci3HOHNwtVSNsMmb4sksH/PLtPsJ4f2oC+okj4+XsTK3huQ8CKp36SsyMFqULtwjcSmFDc1Tb9HqG3naz0/11SJi16KbxA7xMrX8++XlJVyOsMGlVLSv5pXY7l51QUytTo/68Unm45RcJdEdPWI9iJrD6lLK/Rb21O3U5meCGll6/YKZEOi+83pfMMS6KGZl7qZJk4jGJHtJrJcMoKvdk9Nsbke+X1ekq+XKdfEb/JHRkY3WgyG3jsBB7Vv4KN2DpGnZjTsouEDw3MqEvtjzG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8EyVF26JGcxCBZmSftvoi/p1Ne9x5TBTCuTOiW8dDg=;
 b=ypCKpQjItl35cFJXM9mUg6bdFLg3kTsFbjyLELDewzWcyzrIYKpnVFIa+yy2EzXYAj1zsDoOAFus5wlv/UAzXmwUqBPBCgkFh/jFv5cKBzAFyIX8V2vGX21ISp9F0TNYpI0Uozbr8oT1Qpzyy+2VqqNyedz/YhtPC6OcTAvfHLC+1CRCZda8AnaqLPa9y0jMbgRmShqS2oSGdN9yryhlE+YM1y5oprsr+6AKsywXLPAVgkpYwbcX8hkNokCrG7qhRqiN+9Y/RQYeGiNTfAw6AGUuuwBU91QnzfDz5atPiGekUokuxfbCYuT/pVqAUbNwNasMD+cCIrSXuREQ5faxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8EyVF26JGcxCBZmSftvoi/p1Ne9x5TBTCuTOiW8dDg=;
 b=ZeWJ/7oOrWNxNbBWHN2s6egm1GiLHOR8c6yVDXeJgLt2ieOYVn9CRQEkCo9nwRNqSCDEM8Sc0aPRN7gvLr4LbspxWRDFIYoPsOflVeWxXSzkgtN9jjgNoze1nEEbnB8hKpo3GGm9l6JhfnPYzZoz8fOmWq2Yqzq8yg/KRdBz3imT0tmljUDLi5QGYEEu21V1Ya7P1ObXgJ1dAQJdVapjaKzWpB2F0lsuMHxSdpLB49GxzFTmdRUw1sf61Asweh/pJA83JrQ0JI8CjCAv34QwUXyk5FdbZCQqoo3DFtviHt4XaJAyFcin8vhTWvvRtQKDxOp43AEoNiUgQhr0NqMLwA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:42 +0000
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
Subject: [PATCH v4 08/20] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH v4 08/20] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHcmaTNOFrHPIKG2kC2jQcdKOcekg==
Date: Mon, 9 Feb 2026 09:16:42 +0000
Message-ID: <20260209091629.823457-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a498b571-4d8e-4a2a-add5-08de67bbf059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2I1c2JH63A3l1ss+OEyHJHZmA1/Hj3262GD9KU0VhUaADZWuwC10Pb6aBW?=
 =?iso-8859-1?Q?CBzMoqz3Ezya7imtkW8lIo6JsZwPhZgIGb9A9LsecGyKyIC58on2wVwwOz?=
 =?iso-8859-1?Q?Rw1JhmuA6aBbkU5XN2DSegqQNDOzPDUv59h2F1d0e296vshZFlTFYd9iaC?=
 =?iso-8859-1?Q?WBsPRvYeN8t1cOLaPNcvoagnL2ojXby1kadGmLuZlvizALX+UAjnm25KKC?=
 =?iso-8859-1?Q?vYcFKfdK2JC0lrKNC91HcZtFwBYEoA2UjJpsZU+szb3T5SKygzicgolAkC?=
 =?iso-8859-1?Q?A+TgqC5T+MpAhT5anlLsG8oEW199TEz47y0ySJfOD16vptaOCiy/fPL1LZ?=
 =?iso-8859-1?Q?+AEDFU5qWREIwJ/NBqShBEURdfGN8inQYFB0LdinFAISO+acUkHfXKi9Tb?=
 =?iso-8859-1?Q?SR2/zTfNvvLOhVTYdfqNjzkZWtlKZ1kyUnuKsAYXpXXADLr3FDZaQokvRQ?=
 =?iso-8859-1?Q?qlVjYK4h826Kegx6iDJe7tH3YUw0UpU5XU5kpZVJC5vC4av/eZsOfYfcks?=
 =?iso-8859-1?Q?ndNiHjGr9sc45KHLTKJoHECsVnuXF9SvAkIlkXQue7YcoaTIgk1AtnDUhg?=
 =?iso-8859-1?Q?RH9C0rNvHSJfk/lQIeUl54bCrgPM6fgYbkxNmhi1Rg+GpJ8Xm5OesP7BRg?=
 =?iso-8859-1?Q?Y1Toewhv5RTWIsVQgj6AZrF5sUpqnwaRpg+uyXSRZnopPOJ9or8ZJS71fU?=
 =?iso-8859-1?Q?FKuxGi9x5mp3KgOt1heXFZOjvs2XDmGPobnM+y5euzW9vHirfzMuQBRTUC?=
 =?iso-8859-1?Q?NLHvzMMdXGEW6le920TUpTL/jRATV+27xTRxNLUZCMmy126oAstvQyPrTD?=
 =?iso-8859-1?Q?DS0YE5SsFbMrIn8B3mFXXUQpR8D9E2YJxvpgObHRRu3O8YwwxdZmTokAUz?=
 =?iso-8859-1?Q?KMfqo3/uss2elwCBzPryEWZl64YEuTn47OLeN4vNYsQxqtip4SaLyeLDwA?=
 =?iso-8859-1?Q?B3Ghzq9IUjtJTbWAsQx5b70bWCaIDpvwkZLm2zrgPiiNoc4IVxD2suv0/d?=
 =?iso-8859-1?Q?w8CX5u22Kzct8da9qvbFFjYVrhale+VV3l76uMP8a7EXaG3xYFCoLFNmCv?=
 =?iso-8859-1?Q?G98tNszGmZqt3ZrLVp0dOKwrPKTc8IEyWi241Ohes272n8GwUocx9EhjMu?=
 =?iso-8859-1?Q?F14ty69QxuH2QU0A0HLtIbdL3GqeeLlQoPPWRMViliDNHVRCfKi5PhS0Rc?=
 =?iso-8859-1?Q?GIZkYpvNaVSrcMtkdhZ1fot5N0R3Jwxp0fY3sHu3b/TksHp7mQW6hzmwOA?=
 =?iso-8859-1?Q?NHJYeM2xjYruBGKk2tQUUiJe+0VY628Hh2XhJ3w2xkws8NjwNMfP577qnP?=
 =?iso-8859-1?Q?7MWr23+RrmOUZSAlaGFj9jdASaikWBfDV8WA1DHNCagUcSpQHAZiXHEuie?=
 =?iso-8859-1?Q?poWfdPMRleG7xeFsV2Da5hLfRzUR/rqIYy29gS9SbJ6bnU04v5JFStWQOW?=
 =?iso-8859-1?Q?Am1BJv7hmOaf91ZupLrg/fwq3qbAZB78iHMHZE3KKJuEVRU0qjQQPBXfZo?=
 =?iso-8859-1?Q?rVTXlhdIqkLmADDYkCLwmA2nYxmMcvAKHzRyX2RAgmua6qiI9p185Oz+bD?=
 =?iso-8859-1?Q?c4bIPxQEiXeWmAjORF3rxm8/KhelQc7Bb9K78t42QSa0yYTn8gYtW/kwX7?=
 =?iso-8859-1?Q?7PXb09dde/hhHOcoStru8KzWrMRqnuH7T27jtP7qYQe/ggEDdimdiQQx61?=
 =?iso-8859-1?Q?lu4p1g9xIdxkesKHPvrC7wAhQcfSZnmfQruzdL+M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vLjQ3UnLZMyf3IIj8mtTNMhutLI6YA0NgCjq9+Llusuv0zJ4VzLJVxiOWz?=
 =?iso-8859-1?Q?iiCfU4QhzrLaTD0WKSp7EsuOAQsoHA0BG7gyODihtoX2/O59445/Q3v3bx?=
 =?iso-8859-1?Q?IeH0lnY71mFJFPThxqJIN1A3BuOm+WZL8u77NOWoNJFAvwemhSWbpK+4lj?=
 =?iso-8859-1?Q?Dy9IdtRkUZpkYA4v7H9ll8Z46ALVeHaEW2EF93YJuAVsTi7zibs06oFxKo?=
 =?iso-8859-1?Q?K2cBEgvxDkCndW8TZAmvW5FAxmd06e/h2wXa6kN264t7rPV1b6nKVnNhpo?=
 =?iso-8859-1?Q?TUWqSti0MxushwpLipg83gHTgKeDJJ7uFvmGA+b3PlS6RsiICBwEZ33ULj?=
 =?iso-8859-1?Q?7yweKbwUtbXnBUxEuVVm3GyzQHiSwUU83qm5njXusSf8JUI/XW1jWk2AGi?=
 =?iso-8859-1?Q?R98cm2a4ZJaUX74Al0GQSl9vJrRQ+WGDVRuLGVFyzWmDegH+6NWOU5btnM?=
 =?iso-8859-1?Q?98i8omv2JQnribBgJ+Gjkd1XNY28KGnlkZ+FfN7V30+fRCSXtep248qFXW?=
 =?iso-8859-1?Q?bPyKYsNFk2ErGxBTNU+r6/BxL/DrVj1pLd51HNj2RS3/by3H3/tTXVWTyQ?=
 =?iso-8859-1?Q?Tek+ZKcNklr0IOfN9+2F1l70AA1to6+rHXrdRUpf5SI6zMloxiulVPWITO?=
 =?iso-8859-1?Q?jp2pNi9ky2L930mL7Q1T+USw38z5ItZ0gEgGisFJoBrq3ScejcBOlllP5f?=
 =?iso-8859-1?Q?fMRNNTBTJ2h1NRzsB0n0ec2NJ/xVfZlwia6YsIvPnvp63jSa2CiWn95VDU?=
 =?iso-8859-1?Q?Vv22OpAMwCj4tLB1RrCVYAyvEdkNIArpfTWRZlSSMuXD0lURSfgqQxZ/Es?=
 =?iso-8859-1?Q?VfcB/xMrqjThWnXSvg28BzhyVfQ2iUzZ1QKrAzHkwMTzpwAArV5/ARy7HX?=
 =?iso-8859-1?Q?IIN/kkLxSEEfkrGQ6E8FbVmLoiTqIx0+H4oyEv4urOQB6rZFl2LYYrvcAP?=
 =?iso-8859-1?Q?GzH+TSYNjumn+ivFic7ZQwhZ9dsT3WA2aFNc2D3ctTtJ/rNqa+j+ihPWwn?=
 =?iso-8859-1?Q?mMi+yHEGsIoftZ15aKjWM6qHGgGIq9VcsWP9CldGyGaSgaK7FR7sfgnxOQ?=
 =?iso-8859-1?Q?iDpXo94+lkYnDWLJYq8FzFCmzMMxY9YUlQ0ReiOI/DNNeDwTpFvqNFg4qN?=
 =?iso-8859-1?Q?bHn5qV+ZQilw01aNPBe+JaN0yZH/3tJq2g3fF2ICTYOGtizP3jkFwV7em3?=
 =?iso-8859-1?Q?2lsyZ6Kge7mCwZEdZhMb0avO9wbnS+m4km76yrtlY4CLl8RSrMRVODaVrl?=
 =?iso-8859-1?Q?C3cjyFX2CMlBuYYeB2V8yIv/DGu+7zhdcJ+xge7jLQh+sUfaBSCxT1/XnV?=
 =?iso-8859-1?Q?2uqcU6m9ZciM3mjmyr128eGLacHEQQFWbRJQOE9vgniK7UXd0qIdb9GS5v?=
 =?iso-8859-1?Q?CxCHjqIJQTD3MNRwnnAK/fNPAQbmPnGB5WUjSKpYXM5X0R3PTAjMCTyLdo?=
 =?iso-8859-1?Q?osp3vMXZDFWo2nfbU58qahRHifYov4N2cji5K+QAZZqCocRCvc+HIEgoWW?=
 =?iso-8859-1?Q?tBHgNo7vBoe79Bbtm4UlEUxzmccrL52UyUPvFK4+Ib5V+9SSUvtKnlx9Za?=
 =?iso-8859-1?Q?rVTvFdTEQ6hKpJb4SKy7WKJCuo98qkTv1/U2VEIBX5Q1deZK4joHFIOCdU?=
 =?iso-8859-1?Q?2saTbQZOaWYeiM9xTwB55V8pBa42kjtHjwwfxU6aFIEtYxBIIvCtPCkUu/?=
 =?iso-8859-1?Q?pr2PWoMJClDARkGBuesYqD67S+sIQ38M/T+ujF3EALdxmhNt/07RiHe8by?=
 =?iso-8859-1?Q?70J5ksim3qdlPconaxYnWllbe5UAx4CRyl7Uz+oj2WyuswyxSNYYadhw63?=
 =?iso-8859-1?Q?eKURFKU3Ng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498b571-4d8e-4a2a-add5-08de67bbf059
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:42.1832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLcUwTbtbQB1wqajcsEqmaz7ZDNrGvm4qd8646FLVL8nhCCS//TkBInoaChFMVgkMcm08T+uer74DDeARK7fAEYLW6ASrbBotT90HoojGu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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

Adds read-only register masks for the DwC I3C controller.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 40 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7bb33c7a9e..02fa9b3c00 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -296,6 +296,45 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =
=3D {=0A=
     [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
+static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=0A=
+    [R_DEVICE_CTRL]                 =3D 0x04fffe00,=0A=
+    [R_DEVICE_ADDR]                 =3D 0x7f807f80,=0A=
+    [R_HW_CAPABILITY]               =3D 0xffffffff,=0A=
+    [R_IBI_QUEUE_STATUS]            =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0xf8f8f8f8,=0A=
+    [R_IBI_QUEUE_CTRL]              =3D 0xfffffff0,=0A=
+    [R_RESET_CTRL]                  =3D 0xffffffc0,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0xffffff3f,=0A=
+    [R_INTR_STATUS]                 =3D 0xffff809f,=0A=
+    [R_INTR_STATUS_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_SIGNAL_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_FORCE]                  =3D 0xffff8000,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0xffffffff,=0A=
+    [R_PRESENT_STATE]               =3D 0xffffffff,=0A=
+    [R_CCC_DEVICE_STATUS]           =3D 0xffffffff,=0A=
+    [R_I3C_VER_ID]                  =3D 0xffffffff,=0A=
+    [R_I3C_VER_TYPE]                =3D 0xffffffff,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0xffffffff,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0xffcbffff,=0A=
+    [R_SLV_PID_VALUE]               =3D 0xffff0fff,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0xffffffff,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0xffffffff,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0xffffffff,=0A=
+    [R_MAX_READ_TURNAROUND]         =3D 0xffffffff,=0A=
+    [R_MAX_DATA_SPEED]              =3D 0xffffffff,=0A=
+    [R_SLV_INTR_REQ]                =3D 0xfffffff0,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0xffffffc0,=0A=
+    [R_DEVICE_CTRL_EXTENDED]        =3D 0xfffffff8,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0xff000000,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x0000fff0,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0xfff00000,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0xffffffff,=0A=
+    [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
+};=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -324,6 +363,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
+    value &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
-- =0A=
2.43.0=0A=

