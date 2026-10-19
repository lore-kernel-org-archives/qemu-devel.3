Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C247FCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIggy-0000iE-6z; Mon, 19 Oct 2026 02:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIggo-0000gI-BQ; Mon, 19 Oct 2026 02:17:43 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIggk-0003ME-Mg; Mon, 19 Oct 2026 02:17:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyYHTDm7bCKnIvQyJceltlxHR9IcQHKE9XXfwASCMuXd9bj+c0p+SRF0YHnnHDEYW+zVNo6C5Otns3/k5T4uunpp5tnByrjken3c78A841JN+4ud3z5FH+X6kzzVwm/3HagmNrcWF65ZiLRrsY1rc0HBE3R6WGdNFmqaagSJ47sht/c3C3Huje+kMxBI3oWSPnP42MSXZmyxsBrLW1D3TK8vTKDLLQweVM0nTVDLYbQ4P/6YCbtTlkSND6N9i8cghxHSeS62lLhNIdLkVyUB3I9vBTi6+EMyTIK8H9vn5dwgSGniS7/pN+xvyBaWgqcbW2sdehm6ChWZMDIaHnnscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE5oImui5jDXJJdN8XESmuQ5bz6jEMZ+F7lwuIJ4G8w=;
 b=JnOq6Ca9L9BZca6wduoU5Up3UGvS9RvocBCAHXitlrWMI6ZOyHk9jvtMOFEPZovu1Hqoe8T56WJUYq4UlknXFSUs8j4YQaPhEJQtWQBHezW8iRlk5YMjVZnYhqS6mle+9s8uTWLjkKd8EQ+YFbjQ8YTcjC7cySiegYBPkZBrPokWMNJkFSCP5i11pCJYCV7BcH7rSTPafQDfVL5DgPfdvxw4y/8vbBgSktVWHV4NNVpa5CLN6bfOkGwgOM3FgPcYGecoyt8f14q9V6ZfczHapiDS+H+t4+FiftvHMrCBnNA19MLvYKbEMZfS3juDVk4kDiYPraev1JkBPFLUHDmrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE5oImui5jDXJJdN8XESmuQ5bz6jEMZ+F7lwuIJ4G8w=;
 b=eXoZOc4OwiDhN+ZMXw+Mq6qzIIQFuYhCFgAFN6z7NFeFZhkie4seml8lwZfc97ETAUhDxzqb/+wAwjRWxy6VYxlNOeS88SKOsWhM+nQJAgIxEibqmVQpE4dAR72OU2s7BcoUEnr3uR4CPT71qB6WVzLF649voGSN82XuqnncuPhHJA2Shn60KCqGjw0MGHbTrXKghbmewD3C0rgv4I3r/RX/Kdl0oteynbed5iDWM8aN/RAHULdIo9u0tCE78KoYl7rGirVXTfSMlk7+n3vlPR+wxyRwSozE+u1gAmiWWOQn8hRvIVFhDq281+wiK8uAgcXu7UBzNLQ9SEZ/R0Kxhw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUXPR06MB8055.apcprd06.prod.outlook.com (2603:1096:d10:51::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:17:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 06:17:29 +0000
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
Subject: RE: [PATCH v5 5/8] hw/usb/redirect-server: Implement control transfers
Thread-Topic: [PATCH v5 5/8] hw/usb/redirect-server: Implement control
 transfers
Thread-Index: AQHdXIhd2ZMTjYb6EEqIZVOzL6eLabb/0AIAgASZsDA=
Date: Mon, 19 Oct 2026 06:17:28 +0000
Message-ID: <SEZPR06MB736251748E9F14BB2648D96EFC982@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-6-jamin_lin@aspeedtech.com>
 <20261016080125.418342-1-junjie.cao@linux.dev>
In-Reply-To: <20261016080125.418342-1-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUXPR06MB8055:EE_
x-ms-office365-filtering-correlation-id: 794ec039-e108-4c56-3e9d-08df2da8a6f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|261009221227099003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: TmzDV5pa2aTuj93BUjblD8vFjktFR+VzYhcJ66cC8Rq7XKY8C2BJ+y2OhiV6HiDgHH+T31sKAF6UwyQsui2i+H/jbk/8iMAPvYaPV1xPYgnjOPtRQuWFQB+feh8C2CB+Jl7ObvrK9r0REdJj6/pmsdkS/zN+WI0uBbmn5SkHMSZWpIqGUxgCL67RO5R/0J3Mw47hdpl0suKd1Sq7hCGavEG2SyPPDrmpZ5SMz7f/XsP7dccQDPHlEqknCEv4GwQXShRod+6hxhhQOKUQfCPMOxhoVOihFkDgPq3uKiqJeMoQA4Gm27c7FvufR9P0sOdUY11B6uq4dL4MGubasmuijG1ORoRW+YgUGUMnvACNvw4WfiwimpZ+Fjj15au9rOrcuSMnttJ2c98MXy/jw0j+DG5SAtpCkwscP8AR6zBtbvkyk8rUcYmlNcB/KbecWYw8gpw3LheIGXdKeSiYLq5hmBu3iUwixHOjzERBYaFo6xkEGnHE+sJ0oxawXEf+YZT/5gD49wJwz905LZxsf1rpwwS/eSmQGy6mkuuCKHVFzyB9/p0MIUfpygJp6i/s51LZOsd4Q2CZMy8+rHHZty07BJ2rkCj3U4ZCAQsKrNb6JNoQuH5wGy/75m/+jhyHykDYXrTXpHxSTbVy8M+1alqHO62Q99aWUD201QnuWnaN4FVmvaX7tO+fWEL/+bb4WWfPTZyapLgq1UjjyMLE64idMf8/vqvcGfibhfdx7CJIKy0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(261009221227099003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u6IwF7zJcR7AUYt0VtJabjrt6KAwIaQlkhvG5bzpGEvXMREnQBgRMNAy8+wW?=
 =?us-ascii?Q?L2NfPE+gBP31JtavUCXevi8/CGqTacx3lWQPpS5yUwk1TtszR1XMG7icEBU7?=
 =?us-ascii?Q?v2FRg6THMQnXoyq82WkrIc64pJq3Qais3v840k+YNCqxpcwWlq/VkqA61Ydf?=
 =?us-ascii?Q?k2HNkGHBWQ14dD9VtLbOK8JK1EFfj8XThqQWrhuPygXD5QOaDzM+rp+S0AO9?=
 =?us-ascii?Q?yxdooknsexA7O3lylslpVJClsiKb/QaMv1g/wb75AGGZ5Brj/0D9hR34rUWv?=
 =?us-ascii?Q?HehgrmihGMtIpmdj8SpFb+9SSrtciThywL5wkIMu99V0y8AQ7cXn9UBOJ/Vs?=
 =?us-ascii?Q?VmsMvWC2IQfNBZ5JHus9waQNTy14/bV7H6M2Uzp/KWM+Hmj1wAEWWI0vuqet?=
 =?us-ascii?Q?QsmEK1miFEAaTiQidNFSBcoO+wDE15H2uKJwZc7jR2DKXih9TfHAWnc+R/DC?=
 =?us-ascii?Q?RdDGLauUEX4BukgFvzKYMDpTSIyoEYrdbAL/mBc1lrxamWUP/+yFBTwVehN3?=
 =?us-ascii?Q?+809FP4gDPjWCxjZYRPriDDVX9SubnmcSPS5LxiGrIvMAFkOfwQoUrUrzAQi?=
 =?us-ascii?Q?pOScPnp0wZZcc0h9p9z3ljlxVwI8dqTdunC97pGEnfg85Rqmjl5lcjXviA79?=
 =?us-ascii?Q?YoisCpZdJ4eR7HxZiFvTlhZn1KkZFTPUflpeUNzYEVky9KTX1caisdA2DGMq?=
 =?us-ascii?Q?U37JGi4wFgDPhIciRa5s2AQmk+0bghRbH0+irvsXSJ9roouL//3ztECAFOP0?=
 =?us-ascii?Q?Rm8Xf2UQKCXQPSisahM4Vq+S67yoAeSlq/svxO917b49XTfDWykHoaCUAdoa?=
 =?us-ascii?Q?Ht9gR5EZHnTKia4Dxc1U+pYjBlDaG5S4R3MhM4PI/CFmhmkpzXv4Z/YkUNcy?=
 =?us-ascii?Q?JeL0fVTu1JUkgWzdbd1QkDTFBu7WYy7rVYA69HZTSrYL9cwYbZ49H/0pLGjm?=
 =?us-ascii?Q?tKUjK2Vw3zKJvxQcgZt8rwAfPBPTGKl+w2tPXPV/IfDNRFMkIXL1BHB09R3A?=
 =?us-ascii?Q?nGY245336tkEM5wZOMl7vrvbjbAMtjPJq1egAuUrUyvts9SBLaa438Z9JE04?=
 =?us-ascii?Q?H12iYq14LsqRDeV6VLKt8Lv9IPYeV+n7eOouqx0ZL5ACb3Qn/3AQlNkVO5nN?=
 =?us-ascii?Q?UyzXCql1sgJvCHVbJEGZmXYKgec/giPfyqyI22y1vhAiaZhkathNIbde/bA8?=
 =?us-ascii?Q?WU0XxGFnv8BUtkdLNbMwsfD4BkOyq8YTxSRpGz7tqs2gKl53jrG9YLiTBSSY?=
 =?us-ascii?Q?rBSBBXpds1ukRBiWP8i/LSexlmEmNkM1Wz8gFEhNq9uoq52qWUGv4WJaUA5D?=
 =?us-ascii?Q?CohvVTXCHu4w7GAaLPdetVgVLw/Veym/dn7lOvVJjaPb4s9ZFSHwCQNAuMHP?=
 =?us-ascii?Q?ABgUtKio0gFW7C6SgVoQUoxXTMR6vGHgzayhsF8hzqagScoyayWOo3/0zL+8?=
 =?us-ascii?Q?uz7oNHZdcFXtv+XBdbe1GokC5ewrE2SsbxZmzpx2jubpR1tXSinVoMWhjPgk?=
 =?us-ascii?Q?b+ZfQgtPm0/UQ+LTZvu6tmRRgB84PXZwm3x0yfse55hNxi019VwJSLaAeGL5?=
 =?us-ascii?Q?bpyXdpQCDYs5NO9VxBbexPO9I+RZifTb3kObB/wQIdbAMbkYviAR7lF1tVr1?=
 =?us-ascii?Q?iAHqp6tdt4DhJj7d2A+XFv5QIJQVoaV+ypxhPugvMVyPJY+SV5T7syDEpYhC?=
 =?us-ascii?Q?6H7KJ1VxFPQTbLK38BdkwLlnh+znf5+NDnpkyKUzezU5kSPtq2Qjv57RlaJw?=
 =?us-ascii?Q?R9k1rVb4Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UXWjP+Lzwj3GTSveTji4ccPw0RjjX7pC2H/GKnrE5Hfzy/WAaRuuR48WM7GgVeI8L45m+baCBprL2IbC/+rcg9y/tGU67tEkf3DvruAi+eVC/eefihliM4BPGipAi0Wm+IrMFcn2ATk+ZjwbTU9lADLNMeMcJDb/d8bFHagcM2dhGWFzYoV8k8YGlt5sUau3MsXK+KdIMFsuRvEjbO1mSAG6BhcWstPdz8d0Vsst6963So2Zg7KiWg858XRcf2WEq+G9X00L5cAl/9rVEouT42D8TzbQ9o3gGmgsVU/78tyLPYwWOJ1UgSK6oeDzeI9S56nM08v/Ng8VZ6osfIiEsg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794ec039-e108-4c56-3e9d-08df2da8a6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 06:17:28.8501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svA0ptRpnpjAyOSvoT5+4cH58izUTzt1b/5Xqc/qvcLTpkTfeQ/6VJM532WqfsVCAIGWF7Kk4d4NYm65wbME9o1aT8Eyf9DQq54dy7EX47s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8055
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Hi Junjie

> Subject: Re: [PATCH v5 5/8] hw/usb/redirect-server: Implement control
> transfers
>=20
> From: Junjie Cao <junjie.cao@intel.com>
>=20
> Hi Jamin,
>=20
> The tests below were run on v4; patches 5 and 6 are unchanged in v5.
>=20
> > +    usbredir_server_do_control(priv, id, hdr, data, data_len,
> > +
> USBREDIR_SERVER_REPLY_CONTROL);
>=20
> The callback owns data, but do_control() copies it without freeing the or=
iginal
> buffer. In a test with usb-storage, 100 vendor control OUT requests carry=
ing 64
> bytes each complete with STALL, but LSan reports
> 6,400 bytes leaked in 100 parser allocations.
>=20
> Could we call usbredirparser_free_packet_data() after do_control() return=
s,
> and free data on every exit from the bulk and interrupt callbacks in patc=
h 6?
>=20
Thanks for the review and suggestion.
Will fix it.
> > +    QTAILQ_REMOVE(&s->inflight, rp, next);
> > +    usb_packet_cleanup(&rp->pkt);
>=20
> A test device returning async IOERROR for the first of two bulk OUT reque=
sts
> reproduces an assertion here. The core calls back for the second packet w=
ith
> USB_RET_REMOVE_FROM_QUEUE, but leaves it QUEUED on
> ep->queue. usb_packet_cleanup() then hits its
> !usb_packet_is_inflight() assertion.
>=20
> Could we call usb_cancel_packet() for that status before cleanup?
> For a QUEUED packet it removes the core queue entry without calling the
> device's cancel callback.
>=20
Will fix it.

> In the not-found case of usbredir_server_cancel_data_packet():
>=20
> > +    usbredirparser_send_control_packet(s->parser, id, &resp, NULL,
> > + 0);
>=20
> If the original reply is already queued when the cancel arrives, the QEMU
> client consumes its cancelled-ID entry when it receives that reply. The e=
xtra
> control packet then sends a second reply for the same ID.
>=20
> Could we omit this reply when the transfer is not found?
> usbredirhost_cancel_data_packet() also sends no additional reply in that =
case.

Will do.

Jamin

