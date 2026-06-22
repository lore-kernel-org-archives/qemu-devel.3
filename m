Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73232CD98F0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbT5G-0004k0-4w; Sun, 21 Jun 2026 21:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wbT5E-0004jg-8l; Sun, 21 Jun 2026 21:04:16 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wbT5B-0004Ez-Fa; Sun, 21 Jun 2026 21:04:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9Q54hA/3Yj6/t0sUCNl+4ryXiBMuQXz8YzlRuwfqakBjRBCAiap/kNc30DJyzSlzDgr+tspAP7woJofwjWYWVixgAgzaKLhg/iG+K1Wcy1MXWDlRe6ULZuzKnUrFekLuTvXoQSeY1JaxGUNjIZf7JOWvIlksxRq/XFnSloJz9t0RZKgaBFqVWETFU4vjaArQ8hbWO3czRbYY6vT2RETqTIv2ylnFckdnHWXXwl4/bcqtGuK2n2PRkyk3vWzF2RLj9HTWPk6ywOu4WUNPcdenG36FExRdTFfNvRnzTSZoBhk3wjmOiTJc/EhGTmISMKnVH113PdJkrwRsdxpWEN1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7ZVAP50tV8WB24v09fLbkz1HWfjNnjS6LPn6Ms+xSI=;
 b=SF0HXv1JkSKLNlLQKB7MvC7H8kHaftkB88LaavWlTX4aSorNnxK5OAZcgNCrVIQmvDo2MbPP73rbK35HA1TSdJBONFWDZB1lGxH5JsoYxtPP4nJ5E8n9L/uvg+Ks/aATnXviCWA0m2QzN8NM5Y1CLFDK8mVxXeDxbipZcc4qzRGnLZUiNbT25VYz1yl91hvpbY7anboDYOpPrIeW6D9zLoipTI0P1dswdV8+DDKkgR7gQsQTCon5ME9QPvH7EaBm08pPQUCH7Y+fP8H9B/f6FMn/a9jMht7PQ3lyKxKT7zPahPchPc9Ubv0R7EdPDgmGfGwgKyUCqUbsx0ayX57u0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7ZVAP50tV8WB24v09fLbkz1HWfjNnjS6LPn6Ms+xSI=;
 b=dXdzuhk9ER7X910WCRpWCF1rLWrMuf31xCYkaR48jehRRO/js9ptx1m4Y0vTzYddAQXou3RxC44LCtDEO0RSwYDT+4LGCf3oMibgKYoXzqJz1duqimt0chRsVIoYXy4uAsDkHR4FIoST9UeE7A9G+YuaAbQowCq/vgflY0Zn2PUQ9WwNB+r7M6ybyu0u1coNkv+Yx3nrXMeRjaKlcj+lUXaEGwt+vtNZVl/E5VwOdoNg/VznF9sHpycERuYWZl/adcO5rWH7lhrMJoLgrztUGPLOf13fY/6beWn4omppQca5GRS1ClPI9tOet/tXy7Yd3gc3O/nlSxjntc4qjCB5jg==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by OSQPR06MB7974.apcprd06.prod.outlook.com (2603:1096:604:429::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 01:04:02 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 01:04:02 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [RESEND PATCH 0/6] aspeed: Add AST1040 Caliptra mailbox support
Thread-Topic: [RESEND PATCH 0/6] aspeed: Add AST1040 Caliptra mailbox support
Thread-Index: AQHc8yOEmK7Dv8IMYUO/twMijNXIgbZJ3phg
Date: Mon, 22 Jun 2026 01:04:02 +0000
Message-ID: <TYZPR06MB47461EA2F01984CE79D78CEE85EF2@TYZPR06MB4746.apcprd06.prod.outlook.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|OSQPR06MB7974:EE_
x-ms-office365-filtering-correlation-id: b71484e1-49f8-43e9-d841-08decffa266f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|38070700021|18002099003|22082099003|3023799007|56012099006|6133799003;
x-microsoft-antispam-message-info: Hau8iFNvb7JtGhJo6s/oROYhdgelO0DXMYKwy+h1q8GRcGs9Q7LPFjZh1B80U6zFJxP5FTl62atjlg9r/coDnGLEAUGH5EzJ6k6yYos3tZFliToD2Fm5xJ038zh0a/nc2g1AhovuKGvhWQ4VsKYlYewH2ruC5ljVPB1HtMJ85agc52GC88mJQ8Z35btxsQHR0yQd+edNg0hfrErppbE2ojM71fkYsmUwwQc91zdKhfcCxlqkj165WcESeL5ZwBsqIEQ0txqU6rTK2aEhW0qGL66oKI8LGEuNEqONpHO7w/IcQGBxaSIMxtBxcJQGzeeZMA9EzAG29Jg6knLvXzK7tdkyHFDANe5/+Fk2eSl0itmJ6LXG7qH/vFt6WheNs3dvK1AL4U3xJvCOo4dk0c31q7HxUNadBJKZookvuRPun+bo3XM4xpdqWxO/qOpZEs3Nmrc81WPXk0lFG0n/D338Mgt1OUVncQe09+m5hyxSInX7nK4zYKUI1aB8KwwtZNvFlcLVcaOeUzZr+05jcu/GFgikg9T58H6QXYd7E0X3ClB25x8+UCCy5hzU8YAAK3XapTwzZZPpfydN6D3hiMZWkgEznUZi6viggUouTRD9V/tracARP46SJxdQRtzDTdoXT54A9mT+TSeoZizpZiKF9AoBicZWYgfp4VmJXioiKUd9AZAEXxIdbX1hLk6QXfrHbOxHc5XYf2DmoqthnLcocQKdk3yzcWCa4ublcihCjmNNyRelxeArMEFYauEcEnfH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wy78W1LIeIfh47cKnBHpSAqfEbip6k9FnHc/b+vRn8h+2mBjsu4kT1ZUaC?=
 =?iso-8859-1?Q?QmAuQ7rZCmq2kAsJhtXamKIw51vcnHSLEfPY4NIwtionswTn4RCp7hStsf?=
 =?iso-8859-1?Q?7/jZO64HSJGuPRIhLEaOYRlOZOHhJUoC1XG5HQW/jCYNzJnU0pIRsqxbio?=
 =?iso-8859-1?Q?c64URtES2pijvwL3pjeQe4nQvwojj0ZcZjus6J4ymG+KMLUF93/xIryUXI?=
 =?iso-8859-1?Q?EF+X3gtKB7aEGltn1h+/rLf6kPx2qLRk1gWTQ9O4ULd/ksdzJP2kafUhMI?=
 =?iso-8859-1?Q?HJaLX2Id3WqvcLQneZs+Rx6iTHmCvjejS8a0eu4wibQ3qKS8d00vvGpo9I?=
 =?iso-8859-1?Q?3OKLeoWiFruOR5y4Ax6pvJDbtA6b4p85H7wIrh/6INptjUvHO6FyR+XFYs?=
 =?iso-8859-1?Q?EgqW0C+q6ZHwBjxHKZkO81gMjvIGSjI0tGN3qN0Jb/6HV/ki6bR+zJTFoW?=
 =?iso-8859-1?Q?/A4Xti45dYJB9M8WkhOlm0gfEbCk0dtkdPLa2YvWT4425j/X0/hoO5uPmH?=
 =?iso-8859-1?Q?wB3VIExIFyL1OSdzuL5csQgcbMQGDwUoGDeVKDwX1A/pZdQQd/w3X+MEXE?=
 =?iso-8859-1?Q?TxE/nf7ic8QUrhZOZLNK78aRNbs4N0N41D55bXrHmy07onLnG5R/kyWEyU?=
 =?iso-8859-1?Q?h0z6yAE5D+5HJqE4ZxXafEU1ty6J2IPyX0eUVznOJmiThnP29Mj9BT1Lr5?=
 =?iso-8859-1?Q?o0YLJ6ivlBYCWZTd1Ec1fWFZsYPwXZVZHEebnUG6TbgrC5YfaPHt1vqP39?=
 =?iso-8859-1?Q?KLVgBQLREk+8d+cOptcETNQgv+or8dExa1dhNbjbqLvPaXTc2DriPEC4/X?=
 =?iso-8859-1?Q?iZsPpFSfstyR2KheQeGByjXmE5u2pfg93BzIBgT0cq9MzbVKZVXLK8D+3Y?=
 =?iso-8859-1?Q?0g9ODZE02SE6r3fZop4HieTVx4dsnGYyWt5Ut+yx7EIoIaMLm18iHlon8U?=
 =?iso-8859-1?Q?t0L/3EXgcUX6U/5fWawxTE4RIcZ3JqPxo4mwvFy0DLzGmRPvfOwCEHtw0K?=
 =?iso-8859-1?Q?Qbn588PZW1yMAFdndkWjtZxLvkWWpz5vbr/ob++mt5OYeXijDxO4QWjcam?=
 =?iso-8859-1?Q?WjpRVgy5EG3oDMoGWsI8J2OHszP+Z/XJe8gevkWid2GRz/bp8cuTlG5L9l?=
 =?iso-8859-1?Q?kOV0T+gapvYeFxEMTTpRX4auO2VaQZ+MdZTFVNUJ9c5mhL3cE7R0o+2fNv?=
 =?iso-8859-1?Q?RYYCKMUwZANsztfol/0iyaYXEtXAtI8pjG9GpAKWgySaQhvV3zqTUNqIov?=
 =?iso-8859-1?Q?Oh9vDb9xsqjvqCZ9ekU2fyv1ljjQkgogUxXvqx0Nj4CJTlw53UJWPAE5Mw?=
 =?iso-8859-1?Q?rrWi9dc0jUFZVhW29q2f5CGKuMHn+8+M/FEsAT1ESjPk6Q8FFWMQyzpjvm?=
 =?iso-8859-1?Q?/pFLzwH5Dnwyz8bnlEcSxKbkRzb4docQO+dZ+FfV7MPQrqWeWWwDbQovhB?=
 =?iso-8859-1?Q?8dt6trwM9bn8fSMIypqZIfkDvUxBwUMy6jZWnh9kCU6A0Ojsz7FjFqeXWP?=
 =?iso-8859-1?Q?jU9riJewT9iYVRBu74NPe53yCnxaPHJTGrsqeJTOAlmFFlp6DcDKKkfrO4?=
 =?iso-8859-1?Q?6VeoP6Z/HrRXuJGcfPcsZ1o71md3dN3dh5l4CWLAucNesBSahM0WDuddTA?=
 =?iso-8859-1?Q?++r4YAnMtOu9RuXYovGbK81ZMJhN/nMCT/LYXRyxuOhbLkwOfC2ERvS4g2?=
 =?iso-8859-1?Q?HRMgLRmmYh3ehxrlf9KEo8CzamuGbL2GGPKYzICLKz458VS11eNDOBZiUp?=
 =?iso-8859-1?Q?txQSTxum7vdc4Yd5RISFR8daGg/jQTHLs6xPq3JW74auMogMtF0budO4r+?=
 =?iso-8859-1?Q?6tKgLl4lkA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mowk/GhELnYsdroE9DmOv3NODcnC1b5B4nFcvh4EEFVDvGQxW9ytBC0Y+1d2ugDMp+93/+ewaFY9fBBeIxRmJKlAp4YfpF1hegP4f9Gzuw8uEGa0WOp2KdzgEDOrPxoirj8jKaOlrJ8hMQ8lyfv3I6ePg2csztNU+DXWFiB67j4Fyv4lH+CyW3KAnnV7cY8MJ0cKRAPNV1lowmUHFYv0QFtLkT+c/g8yL4Ci8W6mtNygnkx1IgLI1NJQ2gX3gHlwSYcSv5LT5fXqtBm0e5UksWVHrWjnVVUKJn75o2aJgXfrI5ofqybhC47JNqQ2eEPGUhoPY57+w2nZys2kZtDFvA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71484e1-49f8-43e9-d841-08decffa266f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 01:04:02.6651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgxrw66jouohJewMfFfKwSiuLqPUUnhGuLi9tuD1SiUoGD8qmGCjGOl2iYMzgsadMprGJY/2aUrixjIhT0Cw3T74/z36+Sl1OWCLBYJBYH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7974
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=steven_lee@aspeedtech.com;
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

Hi,

Gentle ping for this patch series.
Any feedback would be appreciated.

Thanks,
Steven

> -----Original Message-----
> From: Steven Lee <steven_lee@aspeedtech.com>
> Sent: Wednesday, June 3, 2026 2:38 PM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Kane
> Chen <kane_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Pierrick
> Bouvier <pierrick.bouvier@oss.qualcomm.com>; Fabiano Rosas
> <farosas@suse.de>; Laurent Vivier <lvivier@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; open list:All patches CC here
> <qemu-devel@nongnu.org>; open list:ASPEED BMCs
> <qemu-arm@nongnu.org>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; longzl2@lenovo.com; Yunlin Tang
> <yunlin.tang@aspeedtech.com>
> Subject: [RESEND PATCH 0/6] aspeed: Add AST1040 Caliptra mailbox support
>=20
> This series adds AST1040 Caliptra MCI mailbox support for the ast1040-evb
> machine.
>=20
> AST1040 firmware accesses Caliptra through an MCI page aperture. This
> series adds an AST1040 SCU model with the CPTRA page-select registers, a
> mailbox frontend that exposes the Caliptra SRAM and CSR windows, and an
> optional external chardev peer so a Caliptra simulator can service EXECUT=
E
> requests.
>=20
> The SoC wiring maps the mailbox SRAM, CSR window and 4 KiB remap
> aperture. The EVB machine also gets a cptra-peer option for linking the
> external peer after the machine is initialized.
>=20
> The external peer backend is intended for co-simulation with an external
> Caliptra model. The current bring-up backend used for manual testing is
> caliptra-server:
>=20
>=20
> https://github.com/stevenlee7189/caliptra-server/blob/main-2.x/README.m
> d
>=20
> That README includes the server command line, the matching QEMU
> command line, and the guest-side MFWV smoke test sequence used to
> validate the MCI aperture, LOCK/CMD/DLEN/EXECUTE flow, and
> FirmwareVersion response.
> The qtest added by this series does not depend on that repository; it use=
s a
> socket-backed test peer to validate the QEMU-side protocol and mailbox
> flow.
>=20
> Resending because some reviewers did not receive the previous email.
> No changes since the prior posting.
>=20
> Patch layout:
> - patches 1-2 add the AST1040 SCU model and mailbox frontend
> - patch 3 adds the external chardev peer backend
> - patch 4 wires the mailbox into the AST1040 SoC and EVB machine
> - patches 5-6 add qtest coverage and documentation
>=20
> The qtest covers mailbox lock, execute and completion flow through a
> socket-backed peer, and verifies that SCU CPTRA_PAGE_REG0 remaps the
> MCI aperture between CSR and SRAM pages.
>=20
> Validation:
> - scripts/checkpatch.pl --branch origin/master..HEAD
> - qtest coverage for the AST1040 mailbox execute path with a
>   socket-backed external peer
> - manual co-simulation bring-up with caliptra-server through
>   cptra-mbox-peer-extern
>=20
> Steven Lee (6):
>   hw/misc/aspeed_scu: Add AST1040 SCU model
>   hw/misc: Add ASPEED Caliptra mailbox frontend
>   hw/misc: Add external Caliptra mailbox peer
>   hw/arm/aspeed_ast1040: Wire Caliptra mailbox
>   tests/qtest: Add ASPEED Caliptra mailbox test
>   docs/system/arm: Document AST1040 Caliptra mailbox
>=20
>  MAINTAINERS                          |   1 +
>  docs/system/arm/aspeed.rst           |  32 +++
>  include/hw/arm/aspeed_soc.h          |  11 +
>  include/hw/misc/aspeed_cptra_mbox.h  | 133 ++++++++++
>  include/hw/misc/aspeed_scu.h         |  10 +
>  hw/arm/aspeed_ast1040.c              |  60 ++++-
>  hw/arm/aspeed_ast1040_evb.c          |  74 +++++-
>  hw/misc/aspeed_cptra_mbox.c          | 380
> +++++++++++++++++++++++++++
>  hw/misc/aspeed_scu.c                 | 251 ++++++++++++++++++
>  hw/misc/cptra_mbox_peer_extern.c     | 318 ++++++++++++++++++++++
>  tests/qtest/aspeed_cptra_mbox-test.c | 223 ++++++++++++++++
>  hw/misc/meson.build                  |   2 +
>  hw/misc/trace-events                 |   6 +
>  tests/qtest/meson.build              |   3 +-
>  14 files changed, 1498 insertions(+), 6 deletions(-)  create mode 100644
> include/hw/misc/aspeed_cptra_mbox.h
>  create mode 100644 hw/misc/aspeed_cptra_mbox.c  create mode 100644
> hw/misc/cptra_mbox_peer_extern.c  create mode 100644
> tests/qtest/aspeed_cptra_mbox-test.c
>=20
> --
> 2.43.0

