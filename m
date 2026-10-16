Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C3BCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeEA-00084i-Ax; Fri, 16 Oct 2026 05:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHeE7-00084U-Od; Fri, 16 Oct 2026 05:27:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHeE2-0004vs-Uk; Fri, 16 Oct 2026 05:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cno1yDWQvkFUJwD5FYn2FD+YAoDOAtEu0B2Mtt0t1o9BhAlIggRU3qzjpNfYEIDCUSyq484ij4mchmcurrZP0SALtk3RZ0Vxuc+B5yKpqWXqNDVv56+bOB+ZykBTuv+lxzYQ8bY4qGOTmpMpGbJcDgp94U+PC7c2jqJTSfEUz5+PJE6XIry1zl3JZyY56+pyqgBktGovULWHf9TLZrPKz49Lw9iQJmbUX1gMvnqlM2Scm/l0c4O3AdjO/GVs8OXN2B92NnGyFogo+EFGp7SimyeEP15JR3uBitA6sJepIT94gkSCLYoihtaM2JTL37zP7VltX+zvTD9i6zMHujOOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAI4g2oLCNSQ28L2FdNO42MM3/lzhkUFBKivqmPPtQE=;
 b=WUke2QDM/3PBomI0zE55F0m2prNXLPV1+yRyjqmxas/16+gvoBYokXF/A2dfk83XAqQe1g/c/uaLo+RkaMZ8els+erSraF90tMhA3FwHYxLpb57ocW/r+SSjscsLdAfZHGidIpy7CILBb3Z5JvBwT/qinh85eQZ2Q4PSbFMv5ThpgHYtiReyL6F0ZIhFeFjpirDADaBZMB9b4rZEiSJYUeJfKf8gWnOvhP44dAaF9vKMwpBUlimED1PuCitLGSr9Z6bkpn0TYxhH0o0DnJuVb8iPNcIEnuWFPkMO07jUBzQWzj/R8tL2VNpsUoXJYFLN5LwUbrMFL1zNey4sjolWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAI4g2oLCNSQ28L2FdNO42MM3/lzhkUFBKivqmPPtQE=;
 b=WbanwDEQzDQbOwQ3+qdRxrHHPCFUzpEwXAIwz44oYlv6u4HvE+709B97lbKsD1lctzMzPfyVL73+Uf1RJ8hf7Px+xQnbOWSGjekpafyxBwD+ppoDP6JyiT+/zDfogiw0mL8Eu0CCSlIZemEXW82Om5rCfc5kr/x2Gu7Oo9ShKj3ZQF8cNDk+LPhVQniIw+CFLHKEzNtBRvtWbA3OJC/D2yU0stVgM4kIA74cDc1ECGdX4JSSnQ/CJEmCBldYdLCE7wJVu0Sc4z7LVNzg+F8Rrl6/a5G3tr0e1VonVlzjy1CQ+wiP3UJbNcFSzLfXhyegfYsp49rg3Ei575PzYOQ62A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB7996.apcprd06.prod.outlook.com (2603:1096:101:2d1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 09:27:33 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:27:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jaminlin1207@gmail.com>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 5/8] hw/usb/redirect-server: Implement control transfers
Thread-Topic: [PATCH v5 5/8] hw/usb/redirect-server: Implement control
 transfers
Thread-Index: AQHdXIhd2ZMTjYb6EEqIZVOzL6eLabb/56UAgAAAP/A=
Date: Fri, 16 Oct 2026 09:27:32 +0000
Message-ID: <SEZPR06MB7362131ACA6C9C2C3D44A218FC9B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-6-jamin_lin@aspeedtech.com>
 <atHtqNfqlFLPIMLA@JaminLin-PC.aspeed.com>
In-Reply-To: <atHtqNfqlFLPIMLA@JaminLin-PC.aspeed.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB7996:EE_
x-ms-office365-filtering-correlation-id: f955dbd8-60eb-4302-124f-08df2b67b502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|5023799004|261009223027099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info: /nsezcRXAWl0FBcn/+LaV6yaom2H1H/aQuI+39y4BcWptuXfPiYUjUBZE0UMCkOwZORnIGXdjfeG9JIH63WG8d3fdx1PoQbgCCo7GL+r/xyx+8fKKyPBvRLqqthU4uepxVptrFNPrjEEcqQXgp0LCdKhEA3IC8NQw8MfBnW1VY0hInvZlimjG+zUOLbyQAIIhxyARopl4LjiQx6SnSj6ajj17oVFgeFZDZyu0QwtMaT7ZBh1xILXpwv8wUGtX39M+iQsTVj14FGG3wrTZB96Z7K+V/m9aNFVTkSy0HYOiUULsr6oPJgXXZdVLyHr4PuSd5IKtfmSz1q2/4iuUGYnUg9XAGT7pSKBh+azpxIQOaqgBf6icpDgSgWO7r2ONcwOIbjp2DSThqGmgWvy6k3wjPEd25KvezYqB5mDqu8rRM6SXt4ezMCyUSDRrXUKb2ZiB6c3HDMoGRYhPrSQoSuJwKnw5m51ZxjJkaF1etbdla4a/QPyXknY9KNDeUjlT1WXd9BfVyZ6LLmyukoi/sgnr3jwFT1z5jq7tHcy+mYK1JJRNnzz+vRVraCsS0hVRyTPLksrpLLxt/L/fe0izcIFiZp8R0vDMGjeY/0AYH0ksk0Z0+MYqxPkkSEthc+s8N+jM7paHhT3WP30kwxKDr5MykA60zS7CpIlO7GWQ0gIl5cfwjv6pZpVDpBglZKV5z4rYEXcfzJz4sCSTiitLZE7QzFWs1nSMV5MnGHKClolgFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(5023799004)(261009223027099003)(38070700021)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?diWtstsN3sichzuAnLB1KKsEhLbNNijjq6i5iCbjaUm1AdySRXgXrzZztf?=
 =?iso-8859-1?Q?eNS3VBHeiLRGvXP5mwJtA8wO9LtUbRpis3WRvU5HXX9n0VeIgYFeoq8xIy?=
 =?iso-8859-1?Q?dpl3JUJrBSl2gxbbmwB6beGnHzND54W03Ukx788fHUUpBXOdsiIMxwNsjL?=
 =?iso-8859-1?Q?2dNdbHU896ZbjUVJA03t8C1cMe7qAmBySOBS56VjVxrKsGL0wTcwXc988v?=
 =?iso-8859-1?Q?QZFsJZ2ZFHPdvvTqWQyISTysIJZbgDXzyyCLp+d6ON4+w+cFPvDXE9UCaB?=
 =?iso-8859-1?Q?UrhDEJUpVPKR1lkcfsMPeAkqJ7wo1DrRhVO5TOmAkluGU2JbGvH6BukBa9?=
 =?iso-8859-1?Q?7EjLmviKuzY59KStZN94MgTZm1SIom6CyvMdgLaSrI5DggtHXjNORGdMNS?=
 =?iso-8859-1?Q?oSYCNBQllDyQBHUBLTMF3GzgJdQpA6vTkp7c8Gi+z9JfTyBSeEHpuJfztV?=
 =?iso-8859-1?Q?/A1Nke9M9XMff/jAVjuYJ3d510mKM8w0gc5Pl23Pl8+G7hRh5oe0vGHrbq?=
 =?iso-8859-1?Q?yqAJUveC3GSiqP9crzSBIGfK7dA3j8ixkoI7IffvFZ5Rn196cMsCusD1mQ?=
 =?iso-8859-1?Q?93P0f7JmqQuVMlcTz5V3yBPy7V6WXz2KnbKSj06MS0AKbAP36/KyUjC9R0?=
 =?iso-8859-1?Q?L7tVI9lXuTISnWD64t3tl1iTZ9Ok+M+8jl4LhHdtxqCDfyWJybN7E/1avn?=
 =?iso-8859-1?Q?94A2q5jLdLDQ1P0iQcb4UV+WPXjUR4XOjH9ysVKPDNxqOxIuPNtbkbMNd5?=
 =?iso-8859-1?Q?h6A7Kzs6R8n9WE69sU6Ajj3cE1whMn4P5Q52A7wf7cS3kHRarLS2Clsy3A?=
 =?iso-8859-1?Q?MxxuWMtj1z0ha9GSllfHsUHtJHLyEwExOHamP0qt+CtPEdrsT0cz2Yfd6m?=
 =?iso-8859-1?Q?/XwerXMYTPTZzClnkA5TfoeZywti4a0wmTFNzL9PSOnJ3erOeKu/Lbs9OO?=
 =?iso-8859-1?Q?lpYFyVOU3M/oMgUorxKTKIRuBOwCg+tVI/hsRPsUp8dvpKgpM38tWVXM3x?=
 =?iso-8859-1?Q?b3Cq8ao6GagcKUDUrTJUzk8IvhoaoXWkF8CvVkh6191fjWXL5q/5aPTEyz?=
 =?iso-8859-1?Q?r07CxE9YAjt4OBtZM8hoe3rbAvoa+Tnfqc+/mqGwrBooC+a1qUDqi/KX2T?=
 =?iso-8859-1?Q?LZCVYXHMto1bmoKJXVuCQPjN1PgxYEo9UvFgnNL4J91mDdggOyvg4lk9/A?=
 =?iso-8859-1?Q?PfCm/cqbH1S7nOApT49ONy/ZZJONtxBsXhF1TDOS3WOuQ7jXV5BESbOZsp?=
 =?iso-8859-1?Q?m44OO+60WbdvDIZAxwPO3ChSvaRApK5V/n4O/wpoOcfJNEPZuEjMXNbgUY?=
 =?iso-8859-1?Q?zAuk6Rl5xETQW1eNakCdteBIjoCi4g+YBjs7C678tqPdoxsfuDQMKGFz3P?=
 =?iso-8859-1?Q?5m+WsdIVp4VxBgAUjmYXWoGKPMos51ZOezbjL/GHS6QPYH+MYA9hGS5rnG?=
 =?iso-8859-1?Q?Jbt+0XKCqa+CAtdsJKz0YJ3dnlMq1yEjZMTP8iGE2HWhyd1q7St1UfMkvh?=
 =?iso-8859-1?Q?Bs3yaAP8blMheVCYBaVFsEBvPqyA1eXvGZCxsywTHMFYIqTr3V5K1R6lsS?=
 =?iso-8859-1?Q?j3IzuhCttSHsbd1gz/okEHoixsBz9XD639Hj41te5K14mGuvo2fCtfCKoy?=
 =?iso-8859-1?Q?4KC/wTEssC3t2oh0EsKhKXVOX+MY/me0APa5Z0/ZKeOSfXsB5TxPkxBDd5?=
 =?iso-8859-1?Q?/WqlPC9qcTfxdng6HwDfP8CH+c8GWx28hqHdSmdcLGRoVeOt0r7lG331S5?=
 =?iso-8859-1?Q?0xCpuFzq/3dPmWoPlnk5xqI0SoL+FWw6vwTGomJovEW2JEOeikcWlXDgLS?=
 =?iso-8859-1?Q?nYtbjml8/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SouLgBk7c1QkgfOsZhpXFtJJveT2kYU63cnMghWeluiTyP9YIZZ3p1k8ty4Wr4JpY0NcDi0CfHXS6Jz3UDjAFmZaYIrXS6Z+49QGBfpvqwERZBuAS7gTbW4KfK3s4rvdBigMDSY8e2yRSaOqeK8w32hy02JcHWgu04utkRXsya7Wf/nTJkuDub2xO2s4AJqXuyCjyo3/KgThPOsMZhJWwR/hpJtBLnoRHFBMkPNOofcVShcWjfwRuuSv86TipYgGYxCkplBAtZRrxi0hosrWMwwNJjFz5CBigba20uYGcRdFG8/O0y1ORf+1G4tyDJuHatO9HEmVAXJPhDXyXm9T+g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f955dbd8-60eb-4302-124f-08df2b67b502
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 09:27:32.7838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsPGClmVECd9w0Lrz4AaZ/WRE6uZeeB0IkM1e+EQrCNCAapd0YII3Szb+Yc9/2fct5GEvzMgDEBoLVo4u4TitxkyufuF+i7wdIYlxq6vR+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7996
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

> Subject: Re: [PATCH v5 5/8] hw/usb/redirect-server: Implement control
> transfers
>=20
> On Thu, Oct 15, 2026 at 09:34:23AM +0000, Jamin Lin wrote:
> > The host sends a control_packet. Turn it into the SETUP, DATA and
> > STATUS tokens the QEMU USB core wants, run them on the device, and
> > send the answer back.
> >
> > The device may answer later, so we have to remember the packets we
> > sent. Each one stays on a list until it comes back. We drop the whole
> > list on a bus reset or a chardev close. When the host asks us to
> > cancel a packet, we answer it and drop it.
> >
> > usbredir has its own messages for set_configuration,
> > get_configuration, set_alt_setting and get_alt_setting. Each one is a
> > control transfer, so run it like one and send back the status message.
> >
> > usbredir wants an ep_info message. It says what kind each endpoint is,
> > how big its packets are and which interface it belongs to. QEMU cannot
> > tell us. It only knows after it has read the device's descriptors, and
> > it never reads them for a device that just forwards transfers. So we
> > read them ourselves: the configuration descriptor passes through us on
> > its way to the host.
> >
> > A device can offer several configurations, and an interface several
> > alternate settings, each with its own endpoints. Keep every
> > configuration descriptor, build the table from the one the host
> > selected, and send a fresh ep_info when that selection changes, so
> > ep_info never describes an endpoint that is not there.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/usb/redirect-server.c | 752
> ++++++++++++++++++++++++++++++++++++++-
> >  hw/usb/trace-events      |   9 +
> >  2 files changed, 760 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c index
> > 05ee0f3873..a8647b5efc 100644
> > --- a/hw/usb/redirect-server.c
> > +++ b/hw/usb/redirect-server.c
> > @@ -63,9 +63,11 @@
> >  #include "qom/object.h"
> >
> >  #include <usbredirparser.h>
> > +#include <usbredirproto.h>
> >
> >  #include "hw/core/qdev-properties.h"
> >  #include "hw/core/qdev-properties-system.h"
> > +#include "desc.h"
> >  #include "trace.h"
> >
> >  #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"
> > @@ -73,6 +75,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer,
> > USB_REDIR_SERVER)
> >
> >  #define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER "
> "
> > QEMU_VERSION
> >
> > +/*
> > + * The usbredir ep_info message has one slot per endpoint and directio=
n.
> > + * Index 0-15 are the OUT endpoints, 16-31 the IN ones.
> > + */
> > +#define USBREDIR_SERVER_MAX_EP 32
> > +#define USBREDIR_SERVER_EP_IN_BASE 16
> > +
> > +#define USBREDIR_SERVER_CTRL_SETUP 0
> > +#define USBREDIR_SERVER_CTRL_STATUS 1
> > +
> > +/* Which message answers the host when a control transfer ends. */
> > +typedef enum {
> > +    USBREDIR_SERVER_REPLY_CONTROL,
> > +    USBREDIR_SERVER_REPLY_CONFIG,
> > +    USBREDIR_SERVER_REPLY_ALT,
> > +} USBRedirServerReply;
> > +
> > +typedef struct USBRedirServerPkt {
> > +    USBPacket pkt;
> > +
> > +    /* Saved headers for the usbredir response */
> > +    struct usb_redir_control_packet_header ctrl_hdr;
> > +
> > +    /*
> > +     * The IOV points here. IN data lands in it, OUT data is copied in=
.
> > +     * Allocated and freed with the packet; data_size is how big it is=
.
> > +     */
> > +    uint8_t *data;
> > +    int data_size;
> > +    QTAILQ_ENTRY(USBRedirServerPkt) next;
> > +    USBRedirServerReply reply;
> > +    uint64_t redir_id;
> > +    int type;
> > +} USBRedirServerPkt;
> > +
> >  struct USBRedirServer {
> >      SysBusDevice parent_obj;
> >
> > @@ -92,8 +129,27 @@ struct USBRedirServer {
> >      guint watch;
> >      bool host_connected;
> >      bool device_announced;
> > +
> > +    /* In-flight packet tracking */
> > +    QTAILQ_HEAD(, USBRedirServerPkt) inflight;
> > +    uint64_t next_id;
> > +
> > +    /* Endpoint tables for the usbredir ep_info message. */
> > +    uint8_t ep_type[USBREDIR_SERVER_MAX_EP];
> > +    uint16_t ep_max_packet[USBREDIR_SERVER_MAX_EP];
> > +    uint8_t ep_interval[USBREDIR_SERVER_MAX_EP];
> > +    uint8_t ep_iface[USBREDIR_SERVER_MAX_EP];
> > +
> > +    uint8_t alt_setting[USB_MAX_INTERFACES];
> > +    GHashTable *config_descs;
> > +    uint8_t config_value;
> >  };
> >
> > +static void usbredir_server_pkt_free(USBRedirServerPkt *rp); static
> > +void usbredir_server_stop_transfers(USBRedirServer *s); static void
> > +usbredir_server_send_cancelled(USBRedirServer *s,
> > +                                           USBRedirServerPkt
> *rp);
> > +
> >  /*
> >   * The device is whatever USBDevice the user plugged into our port wit=
h
> >   * "-device <device>,bus=3D<id>.0". NULL until then.
> > @@ -104,9 +160,171 @@ static USBDevice
> > *usbredir_server_device(USBRedirServer *s)  }
> >
> >  /*
> > - * Device announcement
> > + * Descriptor snooping and device announcement
> >   */
> >
> > +static void usbredir_server_record_endpoint(USBRedirServer *s,
> > +                                            const USBDescriptor
> *desc,
> > +                                            uint8_t iface) {
> > +    uint8_t addr;
> > +    int ep_nr;
> > +    int idx;
> > +
> > +    addr =3D desc->u.endpoint.bEndpointAddress;
> > +    ep_nr =3D addr & 0x0f;
> > +    idx =3D (addr & USB_DIR_IN) ? ep_nr + USBREDIR_SERVER_EP_IN_BASE :
> ep_nr;
> > +    if (ep_nr < 1 || idx >=3D USBREDIR_SERVER_MAX_EP) {
> > +        trace_usbredir_server_endpoint_dropped(addr);
> > +        return;
> > +    }
> > +
> > +    s->ep_type[idx] =3D desc->u.endpoint.bmAttributes & 0x03;
> > +    s->ep_max_packet[idx] =3D (desc->u.endpoint.wMaxPacketSize_hi << 8=
)
> |
> > +                            desc->u.endpoint.wMaxPacketSize_lo;
> > +    s->ep_interval[idx] =3D desc->u.endpoint.bInterval;
> > +    s->ep_iface[idx] =3D iface;
> > +
> > +    /*
> > +     * bInterval says how often to poll this endpoint. Pass on what th=
e
> > +     * descriptor said, but never 0 for an interrupt or isochronous
> > +     * endpoint: redirect.c throws the whole device away when it sees =
0,
> > +     * so store 1 instead.
> > +     */
> > +    if (s->ep_interval[idx] =3D=3D 0 &&
> > +        (s->ep_type[idx] =3D=3D USB_ENDPOINT_XFER_INT ||
> > +         s->ep_type[idx] =3D=3D USB_ENDPOINT_XFER_ISOC)) {
> > +        s->ep_interval[idx] =3D 1;
> > +    }
> > +}
> > +
> > +static void usbredir_server_save_config_desc(USBRedirServer *s,
> > +                                             const uint8_t *data,
> int
> > +len) {
> > +    const USBDescriptor *conf =3D (const USBDescriptor *)data;
> > +    uint16_t total;
> > +
> > +    if (len < 4) {
> > +        return;
> > +    }
> > +    total =3D lduw_le_p(data + 2);
> > +
> > +    /*
> > +     * The host reads this twice. The first read is a few bytes, just =
to
> > +     * learn the length from wTotalLength. The second read has the who=
le
> > +     * descriptor.
> > +     *
> > +     * A configuration descriptor is 9 bytes, so a shorter one is brok=
en.
> > +     */
> > +    if (total < 9 || len < total) {
> > +        return;
> > +    }
> > +
> > +    g_hash_table_insert(s->config_descs,
> > +
> GUINT_TO_POINTER(conf->u.config.bConfigurationValue),
> > +                        g_memdup2(data, total)); }
> > +
> > +/*
> > + * Some devices only forward transfers. They never read their own
> > + * descriptors, so the USB core leaves their endpoint types at
> > + * USB_ENDPOINT_XFER_INVALID. Sending that in ep_info does not work:
> > +the
> > + * host sees type 255 and will not move data. So read the
> > +configuration
> > + * descriptor and fill the tables here.
> > + *
> > + * Only what the host selected counts. A device can offer several
> > + * configurations, and an interface several alternate settings. The
> > + * endpoints of the ones not chosen are not there.
> > + */
> > +static void usbredir_server_build_ep_tables(USBRedirServer *s) {
> > +    const USBDescriptor *desc;
> > +    const uint8_t *config;
> > +    bool active =3D false;
> > +    uint8_t iface =3D 0;
> > +    uint8_t alt;
> > +    int i =3D 0;
> > +    int total;
> > +
> > +    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID,
> sizeof(s->ep_type));
> > +    memset(s->ep_max_packet, 0, sizeof(s->ep_max_packet));
> > +    memset(s->ep_interval, 0, sizeof(s->ep_interval));
> > +    memset(s->ep_iface, 0, sizeof(s->ep_iface));
> > +
> > +    config =3D g_hash_table_lookup(s->config_descs,
> > +
> GUINT_TO_POINTER(s->config_value));
> > +    if (!config) {
> > +        trace_usbredir_server_config_not_found(
> > +            s->config_value, g_hash_table_size(s->config_descs));
> > +        return;
> > +    }
> > +    total =3D lduw_le_p(config + 2);
> > +
> > +    while (i + 2 <=3D total) {
> > +        desc =3D (const USBDescriptor *)(config + i);
> > +
> > +        if (desc->bLength < 2) {
> > +            trace_usbredir_server_bad_descriptor(i, desc->bLength,
> > +
> desc->bDescriptorType);
> > +            break;
> > +        }
> > +        if (i + desc->bLength > total) {
> > +            trace_usbredir_server_descriptor_overrun(i, desc->bLength,
> total);
> > +            break;
> > +        }
> > +
> > +        switch (desc->bDescriptorType) {
> > +        case USB_DT_INTERFACE:
> > +            if (desc->bLength < 9) {
> > +                trace_usbredir_server_bad_descriptor(i, desc->bLength,
> > +
> desc->bDescriptorType);
> > +                break;
> > +            }
> > +            iface =3D desc->u.interface.bInterfaceNumber;
> > +            alt =3D desc->u.interface.bAlternateSetting;
> > +            active =3D iface < USB_MAX_INTERFACES &&
> > +                     alt =3D=3D s->alt_setting[iface];
> > +            break;
> > +        case USB_DT_ENDPOINT:
> > +            if (desc->bLength < 7) {
> > +                trace_usbredir_server_bad_descriptor(i, desc->bLength,
> > +
> desc->bDescriptorType);
> > +                break;
> > +            }
> > +            if (active) {
> > +                usbredir_server_record_endpoint(s, desc, iface);
> > +            }
> > +            break;
> > +        }
> > +
> > +        i +=3D desc->bLength;
> > +    }
> > +}
> > +
> > +static void usbredir_server_send_ep_info(USBRedirServer *s) {
> > +    struct usb_redir_ep_info_header ep_info =3D {};
> > +    int i;
> > +
> > +    usbredir_server_build_ep_tables(s);
> > +
> > +    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP; i++) {
> > +        ep_info.type[i] =3D s->ep_type[i];
> > +        ep_info.max_packet_size[i] =3D s->ep_max_packet[i];
> > +        ep_info.interface[i] =3D s->ep_iface[i];
> > +        ep_info.interval[i] =3D s->ep_interval[i];
> > +        if (s->ep_type[i] !=3D USB_ENDPOINT_XFER_INVALID) {
> > +            trace_usbredir_server_ep_info(i, ep_info.type[i],
> > +
> ep_info.max_packet_size[i],
> > +                                          ep_info.interval[i],
> > +                                          ep_info.interface[i]);
> > +        }
> > +    }
> > +
> > +    usbredirparser_send_ep_info(s->parser, &ep_info);
> > +    usbredirparser_do_write(s->parser);
> > +}
> > +
> >  static uint8_t usbredir_server_speed(USBDevice *device)  {
> >      switch (device->speed) {
> > @@ -145,6 +363,165 @@ static void
> usbredir_server_announce_device(USBRedirServer *s)
> >      trace_usbredir_server_announce(conn.speed);
> >      usbredirparser_send_device_connect(s->parser, &conn);
> >      usbredirparser_do_write(s->parser);
> > +
> > +    usbredir_server_send_ep_info(s);
> > +}
> > +
> > +/*
> > + * Packet completion
> > + */
> > +
> > +static uint8_t usbredir_server_status(int status) {
> > +    switch (status) {
> > +    case USB_RET_SUCCESS:
> > +        return usb_redir_success;
> > +    case USB_RET_STALL:
> > +        return usb_redir_stall;
> > +    case USB_RET_BABBLE:
> > +        return usb_redir_babble;
> > +    default:
> > +        return usb_redir_ioerror;
> > +    }
> > +}
> > +
> > +/*
> > + * The device answered the setup token of an IN control request. What
> > +it
> > + * wants to send is now in device->data_buf, so run the data and
> > +status
> > + * stages and pass the answer to the host.
> > + *
> > + * Each stage reuses rp->pkt, and usb_packet_setup() asserts iov->iov
> > +is
> > + * not NULL, so call qemu_iovec_init() before every stage.
> > + */
> > +static void usbredir_server_ctrl_setup_complete(USBRedirServer *s,
> > +
> USBRedirServerPkt
> > +*rp) {
> > +    struct usb_redir_control_packet_header resp =3D rp->ctrl_hdr;
> > +    struct usb_redir_configuration_status_header cfg =3D {};
> > +    struct usb_redir_alt_setting_status_header alt =3D {
> > +        .interface =3D rp->ctrl_hdr.index,
> > +    };
> > +    USBDevice *device =3D usbredir_server_device(s);
> > +    USBEndpoint *ep_out =3D usb_ep_get(device, USB_TOKEN_OUT, 0);
> > +    USBEndpoint *ep_in =3D usb_ep_get(device, USB_TOKEN_IN, 0);
> > +    uint8_t status =3D usbredir_server_status(rp->pkt.status);
> > +    int actual =3D 0;
> > +
> > +    if (rp->pkt.status =3D=3D USB_RET_SUCCESS) {
> > +        /* Data stage: the core copies device->data_buf into our buffe=
r. */
> > +        qemu_iovec_init(&rp->pkt.iov, 1);
> > +        usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep_in,
> > +                         0, s->next_id++, false, false);
> > +        usb_packet_addbuf(&rp->pkt, rp->data, rp->data_size);
> > +        usb_handle_packet(device, &rp->pkt);
> > +        actual =3D rp->pkt.actual_length;
> > +        usb_packet_cleanup(&rp->pkt);
> > +
> > +        /* Status stage: tell the device we got it. Its EP0 goes idle.=
 */
> > +        qemu_iovec_init(&rp->pkt.iov, 1);
> > +        usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep_out,
> > +                         0, s->next_id++, false, false);
> > +        usb_handle_packet(device, &rp->pkt);
> > +        usb_packet_cleanup(&rp->pkt);
> > +
> > +        if (rp->ctrl_hdr.request =3D=3D USB_REQ_GET_DESCRIPTOR &&
> > +            (rp->ctrl_hdr.value >> 8) =3D=3D USB_DT_CONFIG && actual >=
 0)
> {
> > +            usbredir_server_save_config_desc(s, rp->data, actual);
> > +        }
> > +    }
> > +
> > +    trace_usbredir_server_ctrl_setup_complete(rp->redir_id, status,
> > +                                              actual);
> > +
> > +    switch (rp->reply) {
> > +    case USBREDIR_SERVER_REPLY_CONTROL:
> > +        resp.status =3D status;
> > +        resp.length =3D actual;
> > +        usbredirparser_send_control_packet(s->parser, rp->redir_id,
> &resp,
> > +                                           actual > 0 ? rp->data :
> NULL,
> > +                                           actual);
> > +        break;
> > +    case USBREDIR_SERVER_REPLY_CONFIG:
> > +        cfg.status =3D status;
> > +        cfg.configuration =3D actual > 0 ? rp->data[0] : 0;
> > +        usbredirparser_send_configuration_status(s->parser, rp->redir_=
id,
> > +                                                 &cfg);
> > +        break;
> > +    case USBREDIR_SERVER_REPLY_ALT:
> > +        alt.status =3D status;
> > +        alt.alt =3D actual > 0 ? rp->data[0] : 0;
> > +        usbredirparser_send_alt_setting_status(s->parser, rp->redir_id=
,
> > +                                               &alt);
> > +        break;
> > +    }
> > +    usbredirparser_do_write(s->parser);
> > +}
> > +
> > +/*
> > + * The status stage of an OUT control request finished, so the device
> > +is
> > + * done. Tell the host how it went, with whichever message it is
> > +waiting
> > + * for.
> > + */
> > +static void usbredir_server_ctrl_status_complete(USBRedirServer *s,
> > +
> USBRedirServerPkt
> > +*rp) {
> > +    struct usb_redir_control_packet_header resp =3D rp->ctrl_hdr;
> > +    uint8_t status =3D usbredir_server_status(rp->pkt.status);
> > +    struct usb_redir_configuration_status_header cfg =3D {
> > +        .configuration =3D rp->ctrl_hdr.value,
> > +    };
> > +    struct usb_redir_alt_setting_status_header alt =3D {
> > +        .interface =3D rp->ctrl_hdr.index,
> > +        .alt =3D rp->ctrl_hdr.value,
> > +    };
> > +
> > +    trace_usbredir_server_ctrl_status_complete(rp->redir_id, status);
> > +
> > +    switch (rp->reply) {
> > +    case USBREDIR_SERVER_REPLY_CONTROL:
> > +        resp.status =3D status;
> > +        resp.length =3D 0;
> > +        usbredirparser_send_control_packet(s->parser, rp->redir_id,
> > +                                           &resp, NULL, 0);
> > +        break;
> > +    case USBREDIR_SERVER_REPLY_CONFIG:
> > +        cfg.status =3D status;
> > +        usbredirparser_send_configuration_status(s->parser, rp->redir_=
id,
> > +                                                 &cfg);
> > +        break;
> > +    case USBREDIR_SERVER_REPLY_ALT:
> > +        alt.status =3D status;
> > +        usbredirparser_send_alt_setting_status(s->parser, rp->redir_id=
,
> > +                                               &alt);
> > +        break;
> > +    }
> > +    usbredirparser_do_write(s->parser);
> > +
> > +    if (status !=3D usb_redir_success) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Two requests change which endpoints exist. SET_CONFIGURATION
> picks
> > +     * a configuration, SET_INTERFACE picks an alternate setting. Reco=
rd
> > +     * what the host chose, then send a fresh ep_info.
> > +     */
> > +    switch ((rp->ctrl_hdr.requesttype << 8) | rp->ctrl_hdr.request) {
> > +    case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
> > +        /* A new configuration puts every interface back on alternate =
0.
> */
> > +        s->config_value =3D rp->ctrl_hdr.value;
> > +        memset(s->alt_setting, 0, sizeof(s->alt_setting));
> > +        break;
> > +    case InterfaceOutRequest | USB_REQ_SET_INTERFACE:
> > +        if (rp->ctrl_hdr.index < USB_MAX_INTERFACES) {
> > +            s->alt_setting[rp->ctrl_hdr.index] =3D rp->ctrl_hdr.value;
> > +        }
> > +        break;
> > +    default:
> > +        return;
> > +    }
> > +
> > +    usbredir_server_send_ep_info(s);
> >  }
> >
> >  /*
> > @@ -165,12 +542,23 @@ static void usbredir_server_port_detach(USBPort
> > *port)
> >
> >      trace_usbredir_server_detach(s->device_announced);
> >
> > +    usbredir_server_stop_transfers(s);
> > +
> >      if (s->host_connected && s->parser && s->device_announced) {
> >          trace_usbredir_server_disconnect();
> >          usbredirparser_send_device_disconnect(s->parser);
> >          usbredirparser_do_write(s->parser);
> >      }
> >      s->device_announced =3D false;
> > +
> > +    /* Clear the endpoint tables: they belong to the device that is le=
aving.
> */
> > +    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID,
> sizeof(s->ep_type));
> > +    memset(s->ep_max_packet, 0, sizeof(s->ep_max_packet));
> > +    memset(s->ep_interval, 0, sizeof(s->ep_interval));
> > +    memset(s->ep_iface, 0, sizeof(s->ep_iface));
> > +    memset(s->alt_setting, 0, sizeof(s->alt_setting));
> > +    g_hash_table_remove_all(s->config_descs);
> > +    s->config_value =3D 0;
> >  }
> >
> >  static void usbredir_server_port_child_detach(USBPort *port,
> > USBDevice *child) @@ -183,11 +571,42 @@ static void
> usbredir_server_port_wakeup(USBPort *port)
> >      /* We do not pass remote wakeup to the host. Nothing to do. */  }
> >
> > +/*
> > + * The core calls this for a packet the device answered with
> > + * USB_RET_ASYNC. usbredir_server_submit_to_device() calls it for the
> rest.
> > + */
> > +static void usbredir_server_packet_complete(USBPort *port, USBPacket
> > +*p) {
> > +    USBRedirServer *s =3D port->opaque;
> > +    USBRedirServerPkt *rp =3D container_of(p, USBRedirServerPkt, pkt);
> > +    USBDevice *device =3D usbredir_server_device(s);
> > +
> > +    QTAILQ_REMOVE(&s->inflight, rp, next);
> > +    usb_packet_cleanup(&rp->pkt);
> > +
> > +    if (!s->parser || !device) {
> > +        usbredir_server_pkt_free(rp);
> > +        return;
> > +    }
> > +
> > +    switch (rp->type) {
> > +    case USBREDIR_SERVER_CTRL_SETUP:
> > +        usbredir_server_ctrl_setup_complete(s, rp);
> > +        break;
> > +    case USBREDIR_SERVER_CTRL_STATUS:
> > +        usbredir_server_ctrl_status_complete(s, rp);
> > +        break;
> > +    }
> > +
> > +    usbredir_server_pkt_free(rp);
> > +}
> > +
> >  static USBPortOps usbredir_server_port_ops =3D {
> >      .attach =3D usbredir_server_port_attach,
> >      .detach =3D usbredir_server_port_detach,
> >      .child_detach =3D usbredir_server_port_child_detach,
> >      .wakeup =3D usbredir_server_port_wakeup,
> > +    .complete =3D usbredir_server_packet_complete,
> >  };
> >
> >  /*
> > @@ -197,6 +616,54 @@ static USBPortOps usbredir_server_port_ops =3D {
> > static USBBusOps usbredir_server_bus_ops =3D {  };
> >
> > +/*
> > + * Submit a packet to the device. The core only calls our completion
> > + * callback when the device answers USB_RET_ASYNC, so call it here
> > +for
> > + * the rest.
> > + */
> > +static void usbredir_server_submit_to_device(USBRedirServer *s,
> > +                                             USBRedirServerPkt
> *rp) {
> > +    QTAILQ_INSERT_TAIL(&s->inflight, rp, next);
> > +    usb_handle_packet(usbredir_server_device(s), &rp->pkt);
> > +    if (rp->pkt.status !=3D USB_RET_ASYNC) {
> > +        usbredir_server_packet_complete(&s->port, &rp->pkt);
> > +    }
> > +}
> > +
> > +static USBRedirServerPkt *usbredir_server_pkt_alloc(int size) {
> > +    USBRedirServerPkt *rp =3D g_new0(USBRedirServerPkt, 1);
> > +
> > +    qemu_iovec_init(&rp->pkt.iov, 1);
> > +    rp->data =3D g_malloc0(size);
> > +    rp->data_size =3D size;
> > +    return rp;
> > +}
> > +
> > +static void usbredir_server_pkt_free(USBRedirServerPkt *rp) {
> > +    g_free(rp->data);
> > +    g_free(rp);
> > +}
> > +
> > +/*
> > + * Take @rp off the list and free it. Do not use usb_packet_complete()=
:
> > + * it calls back into usbredir_server_packet_complete(), which would
> > + * remove the entry a second time and free it. usb_cancel_packet()
> > +only
> > + * tells the device to let go.
> > + */
> > +static void usbredir_server_drop_pkt(USBRedirServer *s,
> > +                                     USBRedirServerPkt *rp) {
> > +    QTAILQ_REMOVE(&s->inflight, rp, next);
> > +    if (usb_packet_is_inflight(&rp->pkt)) {
> > +        usb_cancel_packet(&rp->pkt);
> > +    }
> > +    usb_packet_cleanup(&rp->pkt);
> > +    usbredir_server_pkt_free(rp);
> > +}
> > +
> >  /*
> >   * usbredirparser I/O and logging callbacks
> >   */
> > @@ -312,9 +779,199 @@ static void usbredir_server_reset(void *priv)
> >      USBDevice *device =3D usbredir_server_device(s);
> >
> >      trace_usbredir_server_bus_reset(device && device->attached);
> > +    if (!device || !device->attached) {
> > +        return;
> > +    }
> > +
> > +    usbredir_server_stop_transfers(s);
> >      usb_device_reset(device);
> >  }
> >
> > +/*
> > + * Run one control transfer on the device. @reply says which message
> > + * answers the host when the transfer finishes.
> > + */
> > +static void usbredir_server_do_control(USBRedirServer *s, uint64_t id,
> > +    struct usb_redir_control_packet_header *hdr,
> > +    uint8_t *data, int data_len, USBRedirServerReply reply) {
> > +    USBDevice *device =3D usbredir_server_device(s);
> > +    USBRedirServerPkt *rp;
> > +    USBEndpoint *ep_out;
> > +    USBEndpoint *ep_in;
> > +    USBEndpoint *ep0;
> > +    bool is_in;
> > +    int size;
> > +
> > +    if (!s->host_connected || !device || !device->attached) {
> > +        return;
> > +    }
> > +
> > +    trace_usbredir_server_control(id, hdr->requesttype, hdr->request,
> > +                                  hdr->value, hdr->index,
> > + hdr->length);
> > +
> > +    is_in =3D !!(hdr->requesttype & USB_DIR_IN);
> > +
> > +    ep0 =3D usb_ep_get(device, USB_TOKEN_SETUP, 0);
> > +
> > +    /* Room for the setup bytes and for the data of either direction. =
*/
> > +    size =3D MAX(hdr->length, data_len);
> > +    size =3D MAX(size, (int)sizeof(device->setup_buf));
> > +
> > +    rp =3D usbredir_server_pkt_alloc(size);
> > +    rp->redir_id =3D id;
> > +    rp->reply =3D reply;
> > +    rp->ctrl_hdr =3D *hdr;
> > +
> > +    /*
> > +     * Build the raw 8-byte SETUP packet in rp->data. The IN path
> > +     * overwrites it later with the answer from the device.
> > +     */
> > +    rp->data[0] =3D hdr->requesttype;
> > +    rp->data[1] =3D hdr->request;
> > +    rp->data[2] =3D hdr->value & 0xff;
> > +    rp->data[3] =3D (hdr->value >> 8) & 0xff;
> > +    rp->data[4] =3D hdr->index & 0xff;
> > +    rp->data[5] =3D (hdr->index >> 8) & 0xff;
> > +    rp->data[6] =3D hdr->length & 0xff;
> > +    rp->data[7] =3D (hdr->length >> 8) & 0xff;
> > +
> > +    if (is_in) {
> > +        /*
> > +         * An IN request. The device starts the work on the setup toke=
n
> > +         * and may take its time, so send the token and pick the rest =
up
> > +         * in usbredir_server_ctrl_setup_complete().
> > +         */
> > +        rp->type =3D USBREDIR_SERVER_CTRL_SETUP;
> > +        usb_packet_setup(&rp->pkt, USB_TOKEN_SETUP, ep0,
> > +                         0, s->next_id++, false, false);
> > +        usb_packet_addbuf(&rp->pkt, rp->data,
> sizeof(device->setup_buf));
> > +        usbredir_server_submit_to_device(s, rp);
> > +    } else {
> > +        /*
> > +         * An OUT request. The device only stores the setup bytes now
> and
> > +         * does the work on the status stage, so run the first two sta=
ges
> > +         * here and wait on the last one.
> > +         */
> > +        ep_in =3D usb_ep_get(device, USB_TOKEN_IN, 0);
> > +        ep_out =3D usb_ep_get(device, USB_TOKEN_OUT, 0);
> > +
> > +        /* Setup stage: hand the device the 8 setup bytes. */
> > +        usb_packet_setup(&rp->pkt, USB_TOKEN_SETUP, ep0,
> > +                         0, s->next_id++, false, false);
> > +        usb_packet_addbuf(&rp->pkt, rp->data,
> sizeof(device->setup_buf));
> > +        usb_handle_packet(device, &rp->pkt);
> > +        usb_packet_cleanup(&rp->pkt);
> > +
> > +        /* Data stage: send the bytes that came with the request. */
> > +        if (data_len > 0) {
> > +            memcpy(rp->data, data, data_len);
> > +            qemu_iovec_init(&rp->pkt.iov, 1);
> > +            usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep_out,
> > +                             0, s->next_id++, false, false);
> > +            usb_packet_addbuf(&rp->pkt, rp->data, data_len);
> > +            /* The core copies our bytes into device->data_buf. */
> > +            usb_handle_packet(device, &rp->pkt);
> > +            usb_packet_cleanup(&rp->pkt);
> > +        }
> > +
> > +        /* Status stage: the device does the work here, so wait for it=
. */
> > +        rp->type =3D USBREDIR_SERVER_CTRL_STATUS;
> > +        qemu_iovec_init(&rp->pkt.iov, 1);
> > +        usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep_in,
> > +                         0, s->next_id++, false, false);
> > +        /* async; the answer comes in
> usbredir_server_ctrl_status_complete() */
> > +        usbredir_server_submit_to_device(s, rp);
> > +    }
> > +}
> > +
> > +static void usbredir_server_control_packet(void *priv, uint64_t id,
> > +    struct usb_redir_control_packet_header *hdr,
> > +    uint8_t *data, int data_len)
> > +{
> > +    usbredir_server_do_control(priv, id, hdr, data, data_len,
> > +
> USBREDIR_SERVER_REPLY_CONTROL); }
> > +
> > +static void usbredir_server_set_configuration(void *priv, uint64_t id,
> > +    struct usb_redir_set_configuration_header *hdr) {
> > +    struct usb_redir_control_packet_header ctrl =3D {
> > +        .endpoint =3D 0,
> > +        .request =3D USB_REQ_SET_CONFIGURATION,
> > +        /* Host->Device, Standard, Device */
> > +        .requesttype =3D 0x00,
> > +        .status =3D 0,
> > +        .value =3D hdr->configuration,
> > +        .index =3D 0,
> > +        .length =3D 0,
> > +    };
> > +    USBRedirServer *s =3D priv;
> > +
> > +    /* The host gets a configuration_status when the device answers. *=
/
> > +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> > +                               USBREDIR_SERVER_REPLY_CONFIG); }
> > +
> > +static void usbredir_server_get_configuration(void *priv, uint64_t
> > +id) {
> > +    struct usb_redir_control_packet_header ctrl =3D {
> > +        .endpoint =3D 0,
> > +        .request =3D USB_REQ_GET_CONFIGURATION,
> > +        /* Device->Host, Standard, Device */
> > +        .requesttype =3D 0x80,
> > +        .status =3D 0,
> > +        .value =3D 0,
> > +        .index =3D 0,
> > +        .length =3D 1,
> > +    };
> > +    USBRedirServer *s =3D priv;
> > +
> > +    /* The host gets a configuration_status when the device answers. *=
/
> > +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> > +                               USBREDIR_SERVER_REPLY_CONFIG); }
> > +
> > +static void usbredir_server_set_alt_setting(void *priv, uint64_t id,
> > +    struct usb_redir_set_alt_setting_header *hdr) {
> > +    struct usb_redir_control_packet_header ctrl =3D {
> > +        .endpoint =3D 0,
> > +        .request =3D USB_REQ_SET_INTERFACE,
> > +        /* Host->Device, Standard, Interface */
> > +        .requesttype =3D 0x01,
> > +        .status =3D 0,
> > +        .value =3D hdr->alt,
> > +        .index =3D hdr->interface,
> > +        .length =3D 0,
> > +    };
> > +    USBRedirServer *s =3D priv;
> > +
> > +    /* The host gets an alt_setting_status when the device answers. */
> > +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> > +                               USBREDIR_SERVER_REPLY_ALT); }
> > +
> > +static void usbredir_server_get_alt_setting(void *priv, uint64_t id,
> > +    struct usb_redir_get_alt_setting_header *hdr) {
> > +    struct usb_redir_control_packet_header ctrl =3D {
> > +        .endpoint =3D 0,
> > +        .request =3D USB_REQ_GET_INTERFACE,
> > +        /* Device->Host, Standard, Interface */
> > +        .requesttype =3D 0x81,
> > +        .status =3D 0,
> > +        .value =3D 0,
> > +        .index =3D hdr->interface,
> > +        .length =3D 1,
> > +    };
> > +    USBRedirServer *s =3D priv;
> > +
> > +    /* The host gets an alt_setting_status when the device answers. */
> > +    usbredir_server_do_control(s, id, &ctrl, NULL, 0,
> > +                               USBREDIR_SERVER_REPLY_ALT); }
> > +
> >  static void usbredir_server_filter_reject(void *priv)  {
> >      trace_usbredir_server_filter_reject();
> > @@ -338,6 +995,84 @@ static void usbredir_server_interface_info(void
> *priv,
> >      /* The host should not send this to a device. Nothing to do. */
> > }
> >
> > +static void usbredir_server_cancel_data_packet(void *priv, uint64_t
> > +id) {
> > +    struct usb_redir_control_packet_header resp =3D {
> > +        .endpoint =3D 0,
> > +        .status =3D usb_redir_cancelled,
> > +        .length =3D 0,
> > +    };
> > +    USBRedirServer *s =3D priv;
> > +    USBRedirServerPkt *rp;
> > +
> > +    /*
> > +     * The host has put this id in its cancelled queue and waits for o=
ne
> > +     * answer carrying it. The device may have answered already, so th=
e
> > +     * request may no longer be on our list. Answer in both cases: the
> > +     * host reuses ids, and a leftover entry would eat a later answer.
> > +     */
> > +    QTAILQ_FOREACH(rp, &s->inflight, next) {
> > +        if (rp->redir_id =3D=3D id) {
> > +            trace_usbredir_server_cancel(id, true);
> > +            usbredir_server_send_cancelled(s, rp);
> > +            usbredir_server_drop_pkt(s, rp);
> > +            return;
> > +        }
> > +    }
> > +
> > +    /*
> > +     * Already finished, so we no longer know what kind of transfer it
> > +     * was. The host retires the entry on the id alone, and its contro=
l
> > +     * handler ignores the endpoint field, so a control packet always
> > +     * works.
> > +     */
> > +    trace_usbredir_server_cancel(id, false);
> > +    usbredirparser_send_control_packet(s->parser, id, &resp, NULL, 0);
> > +    usbredirparser_do_write(s->parser);
> > +}
> > +
> > +/*
> > + * Cancelled and in-flight packets
> > + */
> > +
> > +/*
> > + * Every request must get one answer carrying its id, even an aborted =
one.
> > + * A dropped id stays in the host's cancelled queue. The host reuses
> > +ids,
> > + * so a later answer would be thrown away as a stale one.
> > + */
> > +static void usbredir_server_send_cancelled(USBRedirServer *s,
> > +                                           USBRedirServerPkt *rp)
> {
> > +    struct usb_redir_control_packet_header ctrl;
> > +
> > +    switch (rp->type) {
> > +    case USBREDIR_SERVER_CTRL_SETUP:
> > +    case USBREDIR_SERVER_CTRL_STATUS:
> > +        ctrl =3D rp->ctrl_hdr;
> > +        ctrl.status =3D usb_redir_cancelled;
> > +        ctrl.length =3D 0;
> > +        usbredirparser_send_control_packet(s->parser, rp->redir_id,
> > +                                           &ctrl, NULL, 0);
> > +        break;
> > +    default:
> > +        return;
> > +    }
> > +    usbredirparser_do_write(s->parser);
> > +}
> > +
> > +static void usbredir_server_stop_transfers(USBRedirServer *s) {
> > +    USBRedirServerPkt *rp;
> > +
> > +    /*
> > +     * No "cancelled" response here. This runs on a bus reset, a detac=
h or
> > +     * a closed chardev, and the host has dropped its own queues alrea=
dy.
> > +     */
> > +    while ((rp =3D QTAILQ_FIRST(&s->inflight)) !=3D NULL) {
> > +        usbredir_server_drop_pkt(s, rp);
> > +    }
> > +}
> > +
> >  /*
> >   * Parser setup and teardown
> >   */
> > @@ -360,13 +1095,19 @@ static void
> usbredir_server_create_parser(USBRedirServer *s)
> >      /* Callbacks for messages the remote host sends to us */
> >      s->parser->hello_func =3D usbredir_server_hello;
> >      s->parser->reset_func =3D usbredir_server_reset;
> > +    s->parser->control_packet_func =3D usbredir_server_control_packet;
> > +    s->parser->set_configuration_func =3D
> > + usbredir_server_set_configuration;
> >
> >      /* The parser calls these directly, so they must not be NULL. */
> > +    s->parser->get_configuration_func =3D
> usbredir_server_get_configuration;
> > +    s->parser->set_alt_setting_func =3D usbredir_server_set_alt_settin=
g;
> > +    s->parser->get_alt_setting_func =3D
> > + usbredir_server_get_alt_setting;
> >      s->parser->filter_reject_func =3D usbredir_server_filter_reject;
> >      s->parser->filter_filter_func =3D usbredir_server_filter_filter;
> >      s->parser->device_disconnect_ack_func =3D
> >          usbredir_server_device_disconnect_ack;
> >      s->parser->interface_info_func =3D usbredir_server_interface_info;
> > +    s->parser->cancel_data_packet_func =3D
> > + usbredir_server_cancel_data_packet;
> >
> >      /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes=
 */
> >      usbredirparser_caps_set_cap(caps,
> > usb_redir_cap_connect_device_version);
> > @@ -398,6 +1139,8 @@ static void
> > usbredir_server_destroy_parser(USBRedirServer *s)
> >
> >      g_clear_handle_id(&s->watch, g_source_remove);
> >
> > +    usbredir_server_stop_transfers(s);
> > +
> >      if (s->parser) {
> >          usbredirparser_destroy(s->parser);
> >          s->parser =3D NULL;
> > @@ -486,6 +1229,11 @@ static void usbredir_server_realize(DeviceState
> *dev, Error **errp)
> >          return;
> >      }
> >
> > +    QTAILQ_INIT(&s->inflight);
> > +    s->config_descs =3D g_hash_table_new_full(g_direct_hash,
> g_direct_equal,
> > +                                            NULL, g_free);
> > +    memset(s->ep_type, USB_ENDPOINT_XFER_INVALID,
> > + sizeof(s->ep_type));
> > +
> >      /* One port: usbredir carries a single device. */
> >      usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops,
> dev);
> >      s->bus.no_auto_hub =3D true;
> > @@ -510,6 +1258,8 @@ static void usbredir_server_unrealize(DeviceState
> *dev)
> >      qemu_chr_fe_deinit(&s->cs, true);
> >      usbredir_server_destroy_parser(s);
> >
> > +    g_clear_pointer(&s->config_descs, g_hash_table_destroy);
> > +
> >      if (s->chardev_close_bh) {
> >          qemu_bh_delete(s->chardev_close_bh);
> >          s->chardev_close_bh =3D NULL;
> > diff --git a/hw/usb/trace-events b/hw/usb/trace-events index
> > 2cc6a244b9..0ed20838b2 100644
> > --- a/hw/usb/trace-events
> > +++ b/hw/usb/trace-events
> > @@ -406,3 +406,12 @@ usbredir_server_announce(uint8_t speed)
> "device_connect speed %u"
> >  usbredir_server_disconnect(void) "device_disconnect sent"
> >  usbredir_server_bus_reset(bool attached) "bus reset, attached %d"
> >  usbredir_server_filter_reject(void) "host rejected our device"
> > +usbredir_server_cancel(uint64_t id, bool found) "id %" PRIu64 " still =
in flight
> %d"
> > +usbredir_server_ep_info(unsigned idx, uint8_t type, uint16_t mps, uint=
8_t
> interval, uint8_t iface) "ep_info[%u] type %u mps %u interval %u iface %u=
"
> > +usbredir_server_config_not_found(uint8_t value, unsigned have) "no
> descriptor for configuration %u, we have %u"
> > +usbredir_server_bad_descriptor(int offset, uint8_t length, uint8_t typ=
e)
> "descriptor at byte %d is too short: bLength %u, type %u"
> > +usbredir_server_descriptor_overrun(int offset, uint8_t length, int tot=
al)
> "descriptor at byte %d runs past the end: bLength %u, total %d"
> > +usbredir_server_endpoint_dropped(uint8_t address) "endpoint 0x%02x doe=
s
> not fit our tables"
> > +usbredir_server_control(uint64_t id, uint8_t requesttype, uint8_t requ=
est,
> uint16_t value, uint16_t index, uint16_t length) "id %" PRIu64 " type 0x%=
02x
> request 0x%02x value 0x%04x index 0x%04x length %u"
> > +usbredir_server_ctrl_setup_complete(uint64_t id, int status, int actua=
l) "id
> %" PRIu64 " status %d actual %d"
> > +usbredir_server_ctrl_status_complete(uint64_t id, int status) "id %" P=
RIu64
> " status %d"
> > --
> > 2.43.0
> >

> Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>
Sorry I reply the wrong email
Jamin

