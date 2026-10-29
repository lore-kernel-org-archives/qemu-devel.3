Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=S7sTXHwK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMFWC-0007e1-4a; Wed, 28 Oct 2026 22:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMFW8-0007dG-GV; Wed, 28 Oct 2026 22:05:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMFW6-0004bB-9m; Wed, 28 Oct 2026 22:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqt00ASuEd49QMKvWjU5p+SjLJq+/kTZmszjZ7YAjnYYJgak+iC/IDvQi6qkHHcdn0RJqkBZT8TUqyWJ/dxEKdyX4bTd8LwnK3ggZhGGqaH3bzDsytRBCH6LrC/rWMGz/BDXwAxCuNHh3fTQJbLnv+eQyS/XzLt6ubQ6GP1HhF08PNM5Y4XzAPMoNoBWgFTinZ72XNyEg60GJ4G1bsz5KFhwLTIY6Xbs2HLip+AATTA062HZwGwKKDgjiwo2Tgw+RtfutIjAq4kIKoPRbR4z8Uo/v1Sy9Z/oxyNFlW0q6hQuBaWSKotzDyY4X7u5wG/TJNp/Hgul4J/oXiDJEEzvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6Wk1aDb/hiLKk8G7LurSieqN4zFXzqms7v0vt2ZqpI=;
 b=oScd1mC7W3vcS1XSJOEAjIDdI/b72Fsk2U0HGvu6utWd4GmxL7HFTrevkQwHpBI+XFt0Jo3OTIe05Fq2Z1hxT/csUuIcDxuRNK5axfHE6+ySuHhSy9oyGl8ydRIXTg8iOEdX908u83Aiqrah1PSQHNXLKsxI1aRF140Vt/ga+spY/yMN+Tgglk/Bm9mocruOA9Ln898fP7DDlGmaEpnwjnvB8ZwtOLjx0zs+Ty+I1Y5IEL8+VQ2W2PndAobNfTttARlPX0Eu9hG3qzcinpw1RRcPEmDWhJSToGZ3q64CDEdwPy2CbtGB/Fl2pEdXKl9CaxstD2aozem5Y2HRDcNG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6Wk1aDb/hiLKk8G7LurSieqN4zFXzqms7v0vt2ZqpI=;
 b=S7sTXHwK/ka2DOQrUaJlC3AdJAGZVCEKbLiO/PSHHdNAFRaMLcT19wxJn106RbRbDiAQlDsSynQ790ag8BVWslANymr/jbDDFmDLSH+iqrqxxECBzIOfDgvtEcpcm/8V1kAwo1gmMqRsGu24D1KQKlq7mUgTzJ106RMzvof0uSx3KOjhXUV3c2nUnU7OtTEmZHz2wgwIECk6cYMPRyqdeXnqXXNZHWIE6E3sTQNUegJSpFf4k3EhkyObWk9ryM8laJxBruo3L7E5lJIYwZO8xW28zfmpIFB1sonAZTLXLMlROsuMETA+g7MvfRlL4HG/rjeCPWFsmu+ZyqeiLv1ddw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SE2PPF5849BD80D.apcprd06.prod.outlook.com (2603:1096:108:1::7d2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.5; Thu, 29 Oct
 2026 02:05:13 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 02:05:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdX6uxp6OpQ9yqq0CEeDiwsS34zbcEqZMAgAxB77CAAfWigIAA8rLw
Date: Thu, 29 Oct 2026 02:05:13 +0000
Message-ID: <SEZPR06MB7362D19357678C57AEE48D2FFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-2-jamin_lin@aspeedtech.com>
 <atXr2J5oxn3BBgb-@nucbdw.ghoffman.csb.home.kraxel.org>
 <TYZPR06MB7373C4DABEAE16D546241853FC602@TYZPR06MB7373.apcprd06.prod.outlook.com>
 <auHbnlQQ7KZecdYE@nucbdw.ghoffman.csb.home.kraxel.org>
In-Reply-To: <auHbnlQQ7KZecdYE@nucbdw.ghoffman.csb.home.kraxel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SE2PPF5849BD80D:EE_
x-ms-office365-filtering-correlation-id: 70051e59-37bb-4803-ad0c-08df356111c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|4143699003|56012099006|261021121427099003|261009223027099003|38070700021|261026121527099003;
x-microsoft-antispam-message-info: ALZJdKSW3ySk6E21KD6IAHQcYMAfZ39Zj3GEpNqQ98OkAGTzOSzRFXpJ+2J4FTqYmc4lbISn9Q4LEsqbHKhTelJN6bKyH54gmrVwnFYoDPWcReaSgm/3mn1AwVmDiwyYjmOhEMHeYKFqyllADm1iV0lVODOxSVLqvwYQJJO4EJQK7F96GMrKave7+Y711N7c2J0UHI3qbbq/3TXdnjTiV4S6HSQzmfhbDDiqYhy6lw7DKYzndxuF+0rGZwX9avjvQ3tFAPpwHuRGuPWb/RN2z3/yzZKEdjgRoDI/ViMjQO6+KS5mEafZAvfLCHWXNCQ0RlZ32drY+k7nrORDzOaVKQkk7NdY8D3BSB99I3Lms5HZoHM4DIbbut8TwySKNh9cZV4/xJAHSYucqjejpTyFJeHALgWVWKCd+RU+y3UAaAKWNeGSzYzfKbvJuGJwdLah7W41Yq/DnzBUsg/sZZYLLwyir8gi4yKnFEN3+zBZBrcx8Y6HZGp8sNKrO7zDrqxSkuJ40opeRvBhn/vo/A9qZeVi/wQrwyjOH8y4dbE89blb2XRT1Q0EF0Yqanr8TByjeID2hbbCZsCupCYBvxfaoL8zfGgtvweeRou81Slc7QQIV8UOOVYu8d7CQBozZr1aS0rQQvPdLlYH6UPMStjX4P3yMtXCJjKRAzC2HCstsMo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(38070700021)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?am8DXslOvTcxFGAOGDLvMZZsFq8tjXHs8nYHUElV8QXvzCV173W8hHDavT?=
 =?iso-8859-1?Q?OTwugaKc7fuGsraLu2hJIvtNRr5ney4nB6WCMZDGNtPcFjPEUz1A4iKXhB?=
 =?iso-8859-1?Q?WEyd39N8sZQFrSh3YMC3s+Snt9s/IgSwy0GjV8BdOCTPETLg42VIGjNA0U?=
 =?iso-8859-1?Q?8AFSkzWQgmSw2f2oLGphyd9N2/c91sBcU3gUEFICscJbXQwedXGfrYNc1Q?=
 =?iso-8859-1?Q?JfjdtNgFVsTbVN277Tf7mMdKXHG+PMvbNxBAxE4AfVeetLAY1wHsk2PHlV?=
 =?iso-8859-1?Q?WTQ3lElRxSpVi3e8oBYkb9j9InKPITpsdF7uDpeQdCS99z68NGtJJpQXjU?=
 =?iso-8859-1?Q?Nm7sm9ZAnYA2vPmGUb4Kqm1TnpggqWpesgGc8H1jxfHRKxyRf4VexXAL+R?=
 =?iso-8859-1?Q?P77rNweUTq5P/kWgg4mBLYN7gtoJOAs/m38sdPtZXZfqXDkid27flqp2+M?=
 =?iso-8859-1?Q?a+uNdv+VBVk0IojUjQqU/AthAhHN/o/FxH89mTUGKbQp0NEc2neFCANLVZ?=
 =?iso-8859-1?Q?09IMyl9Ich6lgDPFZSw00zKG6UGc63WI94MjymuEaf0CHskqO8UkG816K9?=
 =?iso-8859-1?Q?x0S3ZPBqjzmvAVdozeYAAk2L0oW7LlGpen6R12Y8vvXH6wm8afz4umkqs5?=
 =?iso-8859-1?Q?zzlgl1UuUSuibpoljbwDNWH7ap4gfshQ2Ax89bwLkI000AYKlf+q8dI4pn?=
 =?iso-8859-1?Q?uY//NjzmyvuQ42uDw+FieWcKO6yPEo3RUgRjf5j1lfJYOPfqk0a4wK6knm?=
 =?iso-8859-1?Q?kSCfWct1RifNjN1sbeJgOpPBiekt5+dRpk4SYiXHmtrS32J4lQVlT74Dkm?=
 =?iso-8859-1?Q?laDg9spFMEhLdHAggn9h8cE6D3t77G8s5w1F2FqPT10uZNoRlMH871TvqL?=
 =?iso-8859-1?Q?sIMU3PkMl4/TpHsmJiTAMAkI/ALx+zrSSJc9JSho+vmgFB/IMpSZXb9Noe?=
 =?iso-8859-1?Q?L62dbUib530/9OSl8y1Q+ZQ5wKPKyiuyfxIMCyJxrDYwaR4GsmUZk05XvH?=
 =?iso-8859-1?Q?FVTETFelJC4X4Qgd6QlopxeUWLRVlg2LvZpgqWecWKLAjg+2Uezjqqi2w+?=
 =?iso-8859-1?Q?v2v0m9v1qX4efq00BnrO1lP4OBTgz7BTc/JWlP4qCVC35UfxiywWatKQD1?=
 =?iso-8859-1?Q?6TNXwuwCzclKFY7e7wcle5N2oTJ0aHYhj6RoOmaf76mWRyXKU2nGM1vykg?=
 =?iso-8859-1?Q?KjrF1zKtm5Va8qCeuiPV3L6sxiZvDCWKtOYYN9/o72116a6VYBVA5OGmgr?=
 =?iso-8859-1?Q?HB7oUQyrUCj/thdGZTRbdLal4QkjxPV6slpF+w6nRETisMDZJwl/5R2/pR?=
 =?iso-8859-1?Q?z2axFg/gZg7piwpt/FKZLuLzuHt4gy1s5ZbyLGzzbeugEsbEpZcqxyWzGi?=
 =?iso-8859-1?Q?m4kRrExry4pZGec/VtqGX0uw3LIJVEM7evwwOTRIUAnAur6Uv+KzLmgTs+?=
 =?iso-8859-1?Q?32R6/eI8vtWacWwziPyKRs8XSMvr2bhUcWnLwubQ34c9yJvpBx1p2pzAad?=
 =?iso-8859-1?Q?Uz5cEBCZXndaLguIVVU5GkR+wkkg603fGZL+g7vgGk2Rxw+If8oiao3p3I?=
 =?iso-8859-1?Q?H+fUJ6nMj5CHl0EYMdwV7fVw9Fml7NCXlrfZRrZuG14DHlh83Ym6+jhmLD?=
 =?iso-8859-1?Q?/Gog6PG4gApSU8r2yNkLrOebEP8xW2pa/RazTOIfXdH34sE78XOZhh+1Ux?=
 =?iso-8859-1?Q?Uu+1lY6WjUOBdj+N+PJD7Uzom24PKL1bU4H0z08kCQYsGqT9Kbxo9JfgFf?=
 =?iso-8859-1?Q?N1bU5n1uf29hbArqDKSdBM+Ryfs2cwgiA4x6/nUPWR8c3bxWSTiVLsI97A?=
 =?iso-8859-1?Q?Johyf4gAXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70051e59-37bb-4803-ad0c-08df356111c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 02:05:13.5445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvKrUyAIfH60wllwY6BjwMg8CsTW40iWJsjU+ktD9whL/bCtfwAmVPnesq2IWoXAP5vqf7XpsV9bCf7Qq9uCVoZI4y6dActNovBkzxd+lHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF5849BD80D
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gerd,

> Subject: Re: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hu=
b
> insertion
>=20
>   Hi,
>=20
> > > Alternative idea would be to add the config option, but only enable
> > > the automatic hub logic for actual usb 1.1 controllers (ohci /
> > > uhci), where it does not matter much for devices whenever they are
> > > plugged into an root port or hub port.
> >
> > Sorry for the late reply.
> >
> > Yes, it gets in the way. usbredir carries one device per connection,
> > so our bus has one port. Plugging that device in adds a hub, and the
> > device ends up behind it. That is why I added the flag.
> >
> > If you would rather do one of these, tell me and I will send it:
> >
> >  1. Remove the automatic hub.
> >  2. Keep it, but only for the USB 1.1 controllers, ohci and uhci.
>=20
> I think it is better to keep the logic for now and add an config option f=
or it.
> This way we can tweak things easily if needed.  Set the option to "no
> automatic hub" for your controller and also ehci + xhci, best as separate=
 patch
> for each controller.
>=20
> take care,
>   Gerd

Thanks for the suggestion. I sent v7 yesterday, before I read this.
https://patchwork.kernel.org/project/qemu-devel/cover/20261028034140.367393=
-1-jamin_lin@aspeedtech.com/

I will send v8 with your suggested after Marc-Andr=E9 Lureau and Junjie hav=
e commented.

Thanks,
Jamin


