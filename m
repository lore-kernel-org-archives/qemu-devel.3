Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1769606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Qvrc6Ldr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhj3-0004p5-Gq; Fri, 30 Oct 2026 04:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMhiy-0004iR-T5; Fri, 30 Oct 2026 04:12:32 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMhiw-0001AH-Mc; Fri, 30 Oct 2026 04:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T93rePdigCYKcBNBeVdeJV8iweKFmUDz0Ta0+JrHIqQF7GlNV5oVIhEAlmYL0McHUs+vj1fdRRBPSyXCCndS6lbhXdUw5QIZ2M0DPKqOAscuVVim13pEQvPnqKzniyVIBd0Kg0lHMZNpTnB8nJazFXNsWBSjwJFKPcceNTi+FGpH+3d7whI7bCVCOsyHvlFRQLKayc87wCQ37ybRz4ybck5L7Wjb0o8VjHNZpP9w76oJxqTt98GNzq/oQ7aOPfHew18724pVlfVCSs9vYR7Me4zwWGc0tHXwNSl8dRb/UzThSz7Nouy74P8VzmSeND3rjMlPzCIVJBexUAPbcq5WNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4+Q1iT0BdzT+svdfKGs1elzld7uMy39nme0ELJyhJ8=;
 b=O6S4h8AqX4e6qtFX/Iy2abTRPQGjKY9DWX/Zxhlr5/FK6/lfUdgxzomhoI9xPIKpxQ3PDIQE/WGjAbwc5geBSLBMWrlwj7IPDdsaUF2Xc43504nZz8bkWnr8VqCxscHqwdGr+d8nIq+jvecY4BTeJ2EoubLZdP+CpGCW/zWLOA9K5GNGeWJWVNU9tbiJOMsleaYgh4UjdLw4oYI28Ot3kQ/URFS6WwJZwfFcOgqCXaLb0Cwd8imT5DEZjmaDHfWFLtIS+YPM+Tr1nWS58gdzXSOqJhi2p++pgWnQC+eZ1fZFW8SWAxyOvIAquagct5vUZI00MGKteHZ3OGDs12+sSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4+Q1iT0BdzT+svdfKGs1elzld7uMy39nme0ELJyhJ8=;
 b=Qvrc6LdrgJJ1Alb731nYkM/HUbWYMPx/hd4+qXZX7EsMRUgTu9SRCOtPQRiRVfUcT2Gb5FF1WpeUJNNQv+U+VDAER+eeOZp5Er2lJFhyuQY41Led7dPwswi0ZA/+iWkWXrFxrzWCr7u/iCrr9A7RT/IRF5Kr4D84XyryRqOMCmsn61W/t+q7Rf18PlQq9HWi2jqrAQ6fkLy1RCrmxe/LEE4/2j1LM9Kd7MSfK519XJCba4Ifdej2yZ0rMW/c1N1Y+3SMnW1lUtkuqgTpfZevJacwvrL/j9g+BzPZd1xgYiLVBiWvEcvw5ltrOKDS5EHu4IomnEgp675mtdGPjbIaSw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEZPR06MB7137.apcprd06.prod.outlook.com (2603:1096:101:232::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 08:12:22 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 08:12:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>
CC: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Troy Lee
 <troy_lee@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>
Subject: RE: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Topic: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdZo5BumtgaWGS+Eqi0U9La8Z+a7cUTh2AgAFw+dA=
Date: Fri, 30 Oct 2026 08:12:21 +0000
Message-ID: <SEZPR06MB7362B3F56016BDAA27D089C6FC6D2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-5-jamin_lin@aspeedtech.com>
 <20261029100942.894066-2-junjie.cao@linux.dev>
In-Reply-To: <20261029100942.894066-2-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEZPR06MB7137:EE_
x-ms-office365-filtering-correlation-id: 1d6ba493-fc08-4699-915d-08df365d85f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|56012099006|261009223027099003|261026121527099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zivGO0FqM6ZMaqNAFWTghRpeDFt6i+8tj8Xaw/TDkd4fmMHY0JLAMGgmC3tLwOFuiFxilJeN3AVY2lBnnWVj0j826/nhY98T5dQajWe/T6g1TLm6nGnedGVEKMV3bqHzQfQyMgGBCbiZZp8JkS7gUm5Sj2IP9PCQcCSp4ilBtVwhy4f4+zPZT7UZg+9gyp0JLE8NxCusKr6gpMPQea8EwPkXIKj+0p0Zz/IwSuRqVx8sXBUPCOoklX2JzBpofQVy/G53cMqv8cTalslxDmdFLXFYEKasPvVRgwDAeInjq+VjFMETZmR2CjBn9hdtfptsBcrw8EVAADjXnOQwo6cneLct5WfESn/li8iuqkqao27JQhlUlN00/D8NYwrMVPE11KeVYFuV8sdNDJZH+BdfK+AwTdkj/7qsWF+SnGYgozvVTqOpXZCl0BmXhj2Zy3RNVfcCviZAKrD6AfthiHkGJTYoQ8WeTvnTSJTYfNk/hioFFROD8BKHwQKP5bYdD1YTqvr4uuWZtC3QhsWCVHlg7nOSV0P9zgkdU6WH67ORsf2zUoBriQuVclopZLBx071Bpm6IgAHfwSFH24TDYDYljTLg15TeE/s1kzjiCH75RVngbwT5NGQFo50OpyTlweLxog1iHCqLQt1hlTCngGIY5sx8uWPGYj8eE+BdV1kXmb/mfAP4R7IqdBcNg+m/WY04EnKYWrfH3IUsuAT0LBLS2l3BVJ55a1ePEy7bFVW8XVU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?opphy+GVrpPM/A8ZhDQIiwZYO7CHBUjhWRwr8zj1UxvlBlWokjREHi/geyR+?=
 =?us-ascii?Q?RxJ0g1LTmQLck3gjbTD8lZSFvU+5U2iM8MU7HgRG3g23mKqof9kTjmguFUrP?=
 =?us-ascii?Q?aQcFz/97I2Lh8+AzPPliL9MTpbJ22t2mhdM9JiKv4IDxcaYI/KANhV1W33yp?=
 =?us-ascii?Q?bJjgoO7n8sQphun8ZkXoYYprzXEa3p5hzN8Ht5uE7ypIt3yhA23diGR1LnAA?=
 =?us-ascii?Q?WiE2Z2xc6QuXv0p69NkVK6F2QOb17yoBU3De5cbySTvXSCAaFY9qdnx2V2rN?=
 =?us-ascii?Q?MseYQthCeI+JUpFQyPEz4RX2hZlZ7/xx4kfRpZq4ZuMdbXra1+tWLwKcgIAD?=
 =?us-ascii?Q?zgvG6/jEgowUJHVjD+S3ffiaWSvahNWJef85mUsihjlitfEh4P3xAGW+kpk7?=
 =?us-ascii?Q?0tP5+WeW1X/iZsmkXXBT2C0m4iLB9xglLum9MTPGXLzPZtHPUVOXc3HNsQpK?=
 =?us-ascii?Q?bMx78GQ3Ab6RhD3EOBK0cS1IUkqXfwESqKJyCfvg+JjVQ6MCzJGjL+dicC1E?=
 =?us-ascii?Q?y+hom6MiIjdbsW+RbpkOAMXZnKJKNkvqfhwCiIBCFzEj0OvTlr4Q+jeVlo1k?=
 =?us-ascii?Q?wlOFtU6swi6GZgnT7UmbJoqonEM9f1sQu5TL680LK2tOYF1KxBXPYKLuR2+w?=
 =?us-ascii?Q?PczdUvfsYTysdx6TD1dhNBO/BDxsBd3o/ezkjujom8ThZNxpL1bo8iKvk9lr?=
 =?us-ascii?Q?j7BET6m9GuCd5JN8cjNXCdoNLLz4nCwFVMKj4bB48gU6bS0n606TWMU8rF8K?=
 =?us-ascii?Q?+TLbUM4dRSUvMeJZzuZ2iavxNSlo1UVecn01l9Gli2OpUsUnv1SLKhMN6g+d?=
 =?us-ascii?Q?ejX/YwvE1knF0QvMdOhZf1gKfmSGS6d9BYbkF5JgZwLQYuzG/335QuQayWRp?=
 =?us-ascii?Q?ST0oeQvUE+ohkTdyIS0tFeKgr4zjNOvGUec3HfYGurmIo/L71YrR8dUjL4Yq?=
 =?us-ascii?Q?fEA4XXOlMypztRsawJq6MvgfdJ0NbTpvxleO3cptsb0huFP0LChiY+/t6qVl?=
 =?us-ascii?Q?JFEanMkbx0+II1aYoq89LL9WJZFzMO898MLl4LYtRnCWdACjOB9uHkFAmktF?=
 =?us-ascii?Q?IA+KFyD5PdnW8UhQHXJI1kXl2WbacZ4mktJrG4uQIS9os6+1BqfEnS8AwrKu?=
 =?us-ascii?Q?iaXDEv9wyh5Wz9+1dibiPEabDB6qghy7HFLYPvVxSv8tpOmjyrgI9FtRy6mG?=
 =?us-ascii?Q?isIaxlqAXu3FV+/jOfC33ayzoLSqxzBBZ5dhpncD8/E9knIwnEjw8H0i/ERi?=
 =?us-ascii?Q?9/3ouYu9r8aiF7pdyMx8TBmG+K3QNUV9Z0U/yDwcCscQAXX/B85+mRdI/Ffk?=
 =?us-ascii?Q?J1V80imtg3Lrb53tbxNL+/+0dHnljYy5xVvqxJHOXCfYbiSVS2vOhbXCDBt+?=
 =?us-ascii?Q?+Sp8+VcJ7VUUDpYcuhV72ApOp8vlSTCkzaWF3MhzttHnUDNsr6naY19dSvXI?=
 =?us-ascii?Q?gER/RGVqddHVHt0KsnlM8T7puIMz7oXQm60agdjgOdmEM2VwMUN+s6E/+2+K?=
 =?us-ascii?Q?KT8dBLcJ+bbN+QE4JjlL+QHnrJptE9Q9kW5vKIvA9PfZ4pB+vu1rtsTR3UhK?=
 =?us-ascii?Q?DB7KG+q90fv9co3r+4WMd4GqdV2WfnBU6RYT9vHlBxNxHgP5ROzzRS+BSHyl?=
 =?us-ascii?Q?EI5RJZ0hNBcy6E6Pp2cIMylkCDF0SCQVhvbuey7qb2qm+zfxRtML0mWJ7QBE?=
 =?us-ascii?Q?NroGiFuAPO7HhUYE+ZfBrXGax+2XRntRlR+10xnQOCeyHNJ2MqpyTdgn99wN?=
 =?us-ascii?Q?uKKktl0hxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6ba493-fc08-4699-915d-08df365d85f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 08:12:21.6867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BOxWqAf7kCh5nkU+wkR8hO6s24dhAEDWf9x9Ikxa+wTEo2moWbGnDTETo5Wl4/FwSatYvIU4ZmksCPb3bxVcmlSesHqfZFAzv/7h6cdIcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7137
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

Hi Junjie

> Subject: Re: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
> device
>=20
> Hi Jamin,
>=20
> On Wed, Oct 28, 2026 at 03:41:45AM +0000, Jamin Lin wrote:
> > +    /* The parser calls these directly, so they must not be NULL. */
> > +    s->parser->filter_reject_func =3D usbredir_server_filter_reject;
>=20
> start_iso_stream_func, stop_iso_stream_func and iso_packet_func are still
> NULL at the end of the series, and the parser accepts those messages with=
out
> any capability.
>=20
> I exported usb-audio to a client QEMU (qemu-xhci, Debian guest) and ran
> aplay there. Once the guest picks the streaming alt setting, ep_info list=
s the
> isochronous endpoint, redirect.c sends start_iso_stream, and the exportin=
g
> QEMU segfaults on a NULL call in usbredirparser_do_read().
>=20
> Could the server install these and refuse the stream until it supports
> isochronous transfers?
>=20
> Thanks,
> Junjie

Thanks for the review and suggestion.
I will implement isochronous transfers and add a separate patch to support =
it.

Jamin


