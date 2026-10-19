Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B1BCCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIhKX-0006rB-Iv; Mon, 19 Oct 2026 02:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIhKV-0006qt-ST; Mon, 19 Oct 2026 02:58:43 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIhKU-0006kg-DS; Mon, 19 Oct 2026 02:58:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etVNAPLJ6OLMR/c3oWr4IkcHXyFmCTKZu14RC//p5UXnimPxrSY7whUS2qjMaxDQZe318KfhtDBLyVXYLBRy5vF/JB3u7eXwAUVoMlqIv8rNjajxFsXQWqZMnj9BvnRTUqirLHwG1Wzak4A+y9EDNw2gBrQhm4bL7uHz7I27UeeUlTl6+nK5c/2h+hjd6uxrNdAzssfAvKb1W4nvsOXgxlfW4Xn7Arb+tyandUrfH+makQ4XIyf+xsCtWWMZpQ4EwmPGasgekJ2/qhtgyfIZP2c98KtX9NKgsKJlzYdkLOE3ac0UAur2QisTvajcZKBPZfEq0SuILungvW+YKVcq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGXwHLaAK98yeVP/mQXZXxJTuUwKHBFti99kpDlHp2w=;
 b=aiEr7p6/XXg6je4kBdcmwzz4B8Ubs3SDqOfXLRhUDm+kMZGeC4KMSfQyiu9TTiFBvzZQcbN6EYj0eDgnmTHGQrApNb62xq2aPhSuSqIiSsznhvUvQdpMdhedHFCGJgN7GqcyybGiVoUS4CZDN7deRYwZ7I1B+azom9MQ77F7aAvhSj7jyRg3/2gZCJbY98aZsMRR++FzsJrcg96KfHAd+bxPCb/COVUBwepMMhyfi3C2BxjFOwyXmfzS3qc4hRZVVLT3V97RQoCkx40bSvnH/fWGZmDBemFFIVfKkpiThOs2URxGdmiZvOIuS5pJq5mfjJc0cGq/Aucqkzue4AhiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGXwHLaAK98yeVP/mQXZXxJTuUwKHBFti99kpDlHp2w=;
 b=NuPENQQN2b7clpyZeWvcWTY2XgMGwbEFyG9Hwi7QzrQzRXvwib6kyvwp+sQCVvHoHwIWDMjmS9PSVRBXQpoCOWpOLSeJd8lLvZ29qscVDUya/KEP9ZAnxbp9y8jNVBP5etprVRbz+XQRnl2kpZJqo8fbCFN0AaVpwtGQg4LN0gq+ZAsQApaangnWLUwR2nyss8IoOSD1FAUJfB1FpTd2yO70czyibB/CDMih+zTI22uB78tYZ+JxcNZ+OC4YKmMG2lGjePF0OZj+jdrc93n69QHkNm1oFRJucVtD68MMZLDEi82RLtMfwTIYn/P1wSllX5FcTmP0A2k7M8In2XhTew==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYNPR06MB8401.apcprd06.prod.outlook.com (2603:1096:405:3b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:58:35 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 06:58:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 "junjie.cao@intel.com" <junjie.cao@intel.com>
Subject: RE: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Topic: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdXIheF+g4tx6iR0eeRzFm9OWXN7b/0AOAgASlMnA=
Date: Mon, 19 Oct 2026 06:58:35 +0000
Message-ID: <SEZPR06MB7362CF890E2A5E28C05CF1B2FC982@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-8-jamin_lin@aspeedtech.com>
 <20261016080125.418342-2-junjie.cao@linux.dev>
In-Reply-To: <20261016080125.418342-2-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYNPR06MB8401:EE_
x-ms-office365-filtering-correlation-id: 9122c40f-fcdd-4175-414c-08df2dae64f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: qqEcZBd9FBsqjss32Idj6nDDFZP1QXmkqzQ3XGkswB5SkfKp/AN7z48oCDlvuLWn6oStKJrfAHvnwvYKkRJslv06fDllrfCDU68BHi2nhk0HzAt4rPPPlUgsraVrxuFTPfVY+RMljoq27uegRLXod9vKYMCRsyT0N75QsIHx41/CTs2lv9lktkbobc23bt7vGmFgRTWQWrTeQqgiCSEDJTj6c8xBvvaddcRY/J5/coyUlX7y+5VEU15B0MoE02H0LQ3jevUxQqLp8J5T2G8mpWBVvEJN5Z08cwR/2oVhaKCjR20sJXtYIca92rLe69kpkvMRaO1upHoW/VOZuWK1+8frN05xB90YE8xEyn/zEwPEvIwtosFmv3a6egs2RtY4GidzTKhuD2qlTJOdw1Ppu1s6OYDhlFn4oTqUOtejl/aLAU9k4UvI1PaflwZS/FMbdNB2kR/NtwYPSLbdSe5T0mDaSY0nHj0m+nO2EHIrnviIPR85A+uvuQlSD981Grg3LmKnpGIm7VbursAWviyDbDbW6IkabnSVDr55lyXpsbFgbkB37xsoTf2rbJdV9PFAl+KHHDxXqoMTAjEJBbLMjvFSUFA99pF9/shW/DBbzuz+z3rXtuaJDLblZ0+jNAzVQlWO1KxkTUY24BNxL85/HA52GgYzw7Zc1I+gyAOXXMgSigwDkFi6pkXYCFwXTd1+KP8x3aBZhoPPw5C/uOE5XYvT/eJcb0EdcwW1QlhEQPo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3Wv/yEyos/xaKZQ6yCjeQvqZiAwaFDgg8WYIZWC8LFcmFBTfjQFAExcRcZ?=
 =?iso-8859-1?Q?PTJLU9jB7c/oAYtZDAUE3/hM9oAZp3BXzorEMjO1XLQJ5gzblcnMmQbvEt?=
 =?iso-8859-1?Q?2U4oKE2JEe9YghEy0J7SDPM7bAYZsdQq0v6mmuQ+jf2DZWiuOeMkPhqVP1?=
 =?iso-8859-1?Q?/HE6pXYwaDMneImH3ysm4HhbEFxwkAXGViRfeOgyaYEzTwJP2pbtj9bdlr?=
 =?iso-8859-1?Q?sAIq5IXKBCH7pjSSri0/wlCr/WaEpOLmh5sDDUrOKP2G9wpfmcD5E2GMfa?=
 =?iso-8859-1?Q?kz+FzWtefiBjt22BnhF0gfwGC/JOo01IiGPLQo/v8kB+taDxOz4Xys4XPS?=
 =?iso-8859-1?Q?1ucinkv6lEWkti4K7wjnQLC+blErqsnEcWHyPC7pmTTre+R0nRoIu10s1a?=
 =?iso-8859-1?Q?JW+vf9qtU+8FS9BXnorEMm7yOXERbMUzjoRRMSxT1uL/XCeuhG1tnN4PXT?=
 =?iso-8859-1?Q?StqjFf77FpncA2fxMdDO/PhW/9eN54qEnJVDSl8NbgCt9SoIRlgPnv8JnM?=
 =?iso-8859-1?Q?kRmkqScJ/mYFX45QQ4/GSruuLa8C/mMFiDKPDD9zXmyxwVtlzCr8Gv5ahT?=
 =?iso-8859-1?Q?OcziqhX/8gA3hFE0MKOPfUutl9NiPQ5wTug1T64LSWkM1mTGV3Cjt3jWZj?=
 =?iso-8859-1?Q?2l7lNrtbSYRoy+NzKIH/F6Iw9+BYNT/2oZ13g49ve0nmMMfAn9xX16/rEQ?=
 =?iso-8859-1?Q?3EiahvuILGdgg6hMOQdYb+0Eg9hrP9XXeckFWkgL6CEG08s1cAsu8A0AjT?=
 =?iso-8859-1?Q?R1uozWS551n1OrHwh2X7q3EYiJt9qMMPWxsjp4ePcRqGcNkx4Sw892M/HV?=
 =?iso-8859-1?Q?0UrlubJf13xl3COPc0Eouz4y179nFE7Rq986OvdqAzhXlhco8o/N2Yptz0?=
 =?iso-8859-1?Q?B1fJxxKyH/XYDVqRKEj21aHuVCXUak5oqrS2x2inQFvE4bi2s/VnqGCk/8?=
 =?iso-8859-1?Q?tqDQgQAMDys9v6iugg11+pCKqzCL5c1HFFNtlXeA3UMFbYQeFG5ucYAQde?=
 =?iso-8859-1?Q?bBscv3VgHseb/pK7rzBRMfzdSAgpOeIsciRbz6Ck4ZFXEzCoQ3K0A9RstU?=
 =?iso-8859-1?Q?eUjB+iBaeAsM9fesdQ5hqr15G7tpe5DXVIgdWVLR9RK/tXbm3jjY312z4I?=
 =?iso-8859-1?Q?/puUH90iNYrVBXcT/6/TvsPENqT7Q5CIz0pmAj0KWCgjaTwmNYnz8ahA7Z?=
 =?iso-8859-1?Q?n/r7ib77/BcIexzpX9WnhZklxGRAnDLtJJQ3fca8Q/wCnsJmcdFZ2zzGok?=
 =?iso-8859-1?Q?FJvitUdS+RLL6sOoCpPACzzawMP8azAzwDI0287WXxTfmiui6oWO82upgb?=
 =?iso-8859-1?Q?SShrEoPEj0iqsj/P1AJk271Y21jF4z8/HR6Yz4LOEn2cjsCjR7Qr3zlcRL?=
 =?iso-8859-1?Q?BN0LYaqoCArt0Q0JXyi1nT1D0emyn5JTnzWD1Q7RinjwkgmYcXabLtyORi?=
 =?iso-8859-1?Q?yrQV+mFiumFypXt9rP6dCzQiU0bUGf8sf10JTMmFr87al/UEAG6jofH8Xj?=
 =?iso-8859-1?Q?oZr/38sKC90aEfaj3cpHp6b2oesT8GOuCnmzmz74ZFDR7G1qys2TYkSnNC?=
 =?iso-8859-1?Q?/bX/o3dseRfTwzOmPi5PgLcD4HVUfuntiMLEAgzU+fSs1Rd1/BjJZ3wTHR?=
 =?iso-8859-1?Q?hlAdDH+/IroouL5ujC0NpckBVBtj5WdmM3MGogeczi/4IEndrWpLeaCYeI?=
 =?iso-8859-1?Q?shTRfzdNLcW10p8x+oJJPg3Jxw85KBRXDDDweNnkeYWmltRWgXKuUo76o7?=
 =?iso-8859-1?Q?NuJL9/ePe6lxJXSmAhJdHOviV6JKTL2cG0Xq1Viel6Iu8mih32LjG8E1lt?=
 =?iso-8859-1?Q?6mrDXRayLg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AQVzXxPsl03jPSn6rBvPU3CQOIghKaPHCPLXQFn5EIpMGAoaakiDIojoDr1v0OEhwLb9f0D9MmyUURxosxnMveLTr4/6oempFgrfXDLvXq+Ky2jRQLxTQbHWINI0uASaUZIibejlWBpzmccsei6cDbbUdi4FIQw4cYvOtjA5AFOTppKd64+2vgB32B2WS1C15L4RaBI/+1OfVDS6ZjcWh5v0lYzvH5Nys8ifCU70szioFHFOnqyCgyfCcxhYLgXMjVf6WXC2Hnmodo37Bu+4rvL9rcI9/zkv+x1cuEeOAvbU94tamgXxnzj94cF2//oZnnbxUcKtN28hEYSYQaU20A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9122c40f-fcdd-4175-414c-08df2dae64f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 06:58:35.0979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndytU7PejegTm1kjA9cymt2+jINjQvDlZWHoEiPcDMyjbokJ1KOtgygkS4tdCU5WuHglOXGM5MeaOCdzxkZnjfT6T0Qjk8dOk8EAdDyvPi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8401
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Junjie,

> Subject: Re: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN
> endpoints
>=20
> From: Junjie Cao <junjie.cao@intel.com>
>=20
> Hi Jamin,
>=20
> > +        st.status =3D usbredir_server_status(p->status);
> > +        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &=
st);
> > +        usbredirparser_do_write(s->parser);
> > +        s->intr_stream[ep_nr].started =3D false;
>=20
> Could we report usb_redir_stall when stopping the stream here? The
> usb_redir_interrupt_receiving_status section of the protocol requires tha=
t
> status when a stream stops without an explicit stop request.
>=20
> In the QEMU client's status callback, only STALL clears interrupt_started=
. Other
> errors leave it set, so restarting the stream then depends on another pat=
h, such
> as endpoint stop or reconfiguration.

Thanks for the review and suggestion.

Marc-Andr=E9 also raised this issue and suggested stopping the stream only =
on USB_RET_STALL.
For other errors, I will keep the stream active and retry after the endpoin=
t's interval.
I will update this in the next version.

Thanks,
Jamin

