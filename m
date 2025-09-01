Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682FECA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 15:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut6Es-0004jt-Jp; Mon, 01 Sep 2025 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut6Er-0004jl-GW
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:14:33 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut6Eo-0004VW-Am
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756739670; x=1788275670;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=q4mdVFc4+oeCn6QWw/1QDF7ZYhUljZyCXNyMPT3ape0=;
 b=Ogd0XQQSfvW2sPC80l2faTNPpSpItP6T/oHoqZtFu2kJjwKK9VdpzkJC
 EDmGBolXwGDTEDqnDMeilHyhystJL0+qtsPyfZkizoeX2FWrqLKZ3WkoJ
 wkIE6tYYaQ41d41emf+Gmmy/Tit17C76+0Ommz2k83Vs8uVJ49mt2KIsN
 eTioFKlErj4PrloeYygNQt+Zw4r+MhxetdgxRu27fhXnWNH0QbqDhlMGD
 GNXtCVF3s3Jp0xwPmWB77c0Z8qY4nR/JWJjTdpO+PcObMt4GKK7iRFe/d
 62NQKOPL/PTuV4if1ToQa/Tg/7sCIsNaJUC/qRu4tOsftF3mQYjgC4uen Q==;
X-CSE-ConnectionGUID: eefKjytbROKC4CJiDHHcYw==
X-CSE-MsgGUID: pFWVw7BgQtagWswYFudB9g==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="42546323"
X-MGA-submission: =?us-ascii?q?MDEkHFIgQkS2GKr1DaKGAyKaUBnQtRtSNOVvar?=
 =?us-ascii?q?fmMWgxTN+Q8RfaPiQ+NkX0fYvqsENgIAy/7OsoAok95WgZn+DcpI05Sc?=
 =?us-ascii?q?Aqs7EczJxcuSTJC58zNeLfmxJHSbtCBWN0aIWsrlFU/vtGLg3E2tOAD7?=
 =?us-ascii?q?/WqwB8K+K0LPQobvX35oICSQ=3D=3D?=
Received: from mail-northeuropeazon11012053.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.53])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 17:14:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgvr7ZyoBqplrN6IwI9WJcM1U1wvBZBQME/tFL+X7laHSGlwvzT0IxTu4PnrTfi/6iS4rqk9Dr8AntIUc+v1i2oZ4mv9Vfqw3cpYes407l2D9DjDNrTTpb2ti7TUAzqWxmdvWJmPXIkP72U9XxhOTPq8pCJt2iGdX7OGQB5A7WxCXzJwYyBrxIwsjTD4vMOvd1Vp8QbJDvomWIW/0IXKfelLrmLRmPgnozxLpeU3Di99P/EPjCX6Ymeu5aK8Yi1wod8md4Lwfl4iN7/8+NAvSS/8KZH83LQQAXUlkKDTEPsqH6Tkl+6H98JGfsFv4Reml+rGHmQj+GXjl0VeRMtjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnEn/N5/Au2XbY/8kl+1Hhy3a4WaXRwuZNJJO+E4dhg=;
 b=ts3R4+kLeVWtYg5ztFaA3JiCAQaOICimVrNa1IkgxVEKnCg8+5R3XiYbxzi/EfqxbGq6znk3S4Kncw4w4npKtOpzDsMC9Kvjra7tc0CbNu4CYctKvKTV3boAysktAvnFmJD081tebFsXQanF1OTQue3u2epAC5vBKkX6DyBYI9G+yc+nnjSZSUhWZbULBtpAwKxknQameTmy0OruQDRS7jPXSk7dQxPZX4SoShyFq04XKtS27CmZg/Twmn4OPLiCbbEWrzLpN78Wpw/I9tifeDpTJ9YcbifXXzCHrqfHtKxVSIUX1ADTnU7FIFlfr+Nn8PaZedWeGpGaRUwBhkkGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnEn/N5/Au2XbY/8kl+1Hhy3a4WaXRwuZNJJO+E4dhg=;
 b=c7JMTq2fE35noVrHFdmRT1E8z27hhqO+ojCycLxqlNEcVSwWXiX0Bv25jig2E1vjNsjKk2FwCmYr4sFu/3B6WTPVGW/w+LHl4Dv5T5AFzw5IaRPNUNVFhEk3159CNFNpsIizhqJ5q1/v9/EiWDIL71S1uJlJKlDr3zaoT9BUnBwNXp3q33+6p6n1l8Ym9PxtNBzsvniI1w0Wc625Kie5oh7tr+aJvan+asyIOgNrIWznbFvbQnosfAdrgBfSAnGYPX0oGTVA5vKqtxdX/OfeltGe2kgtBgOnRs4bJ968on3aroRlYDGECrDpZL5t1Oi29HcTEe+Xh7NaY6/MfwJ1Fg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA1PR07MB10438.eurprd07.prod.outlook.com (2603:10a6:102:4f5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 15:14:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 15:14:23 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "odaki@rsg.ci.i.u-tokyo.ac.jp"
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, "sriram.yagnaraman@ericsson.com"
 <sriram.yagnaraman@ericsson.com>, DAMIEN BERGAMINI
 <damien.bergamini@eviden.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Thread-Topic: [PATCH v2] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Thread-Index: AQHcG1MZ/8JFh+M5ek+ayOCychAhmg==
Date: Mon, 1 Sep 2025 15:14:23 +0000
Message-ID: <20250901151314.1038020-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA1PR07MB10438:EE_
x-ms-office365-filtering-correlation-id: 1b3064dd-a484-4f58-7f8a-08dde96a3bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fz93ESCvnVfRJj8jtgwvSu3Mz8i3xNyh/xfZABeYbfK8M/kjt8fAYonWfY?=
 =?iso-8859-1?Q?uvozX7nq9nlH/cEpR7Jor/pfViT/+Tkk3GUR7wWJi1uaKxEquO3VZEPtDY?=
 =?iso-8859-1?Q?Qp10irZRXfr3/gYUoyH8SDDX/ru0DiFq+V9e4pRHbB4Rcu93tZpvN/jvLR?=
 =?iso-8859-1?Q?XR/DAPlyvy9AQnMZLXKSU+4Jdi4ftQbKNolfSTzolPlhIL8i7F+FNmjC1i?=
 =?iso-8859-1?Q?W7X8vwwzP2NUBejn2lb2JoUINsxdXICiSPEdHPF0PJ6nSdp9K66AReGWDt?=
 =?iso-8859-1?Q?nSubpEKPZvTy8vQQs66Z8tMV0PmIg1WjcHoLz9p9qza+vnNIxk3es5VB5B?=
 =?iso-8859-1?Q?1VVNGmsqG1C7Pt3FcPjcn6YHLneWQPUsuG+YRIUQXvxDLSeRc4TR9z2obX?=
 =?iso-8859-1?Q?otudP35V6Z6z40ZOJHZC8HgkIRomnzAQOV/grDQnjXjw6f+oJ6dzI0KHBs?=
 =?iso-8859-1?Q?XyqdX/MS0wZnuXJ7U8Ect7GB6J9ft6c5LHvZZLEYHT69F37oIqTXdWMAhk?=
 =?iso-8859-1?Q?hfof7Dbc1KT1DMzAmUo3c81sTc1LXEwwRd1dMknjkF+KbYfOBThHiW83jE?=
 =?iso-8859-1?Q?vbgHwOHwM9PqR4syldFCHT+BTHBVib3nIFYZi7jlWHNzy4ejj5fClzySRW?=
 =?iso-8859-1?Q?rm6+1t9g2AYn6TidSIJpjvM/zmW3TEHUYURZT/aq930n0YcxGd8Rk72rme?=
 =?iso-8859-1?Q?2OHhbrowIECdAzdf4nyb6DtWGs9kWq/lsC89beMDHdW1m0nCuGPxWwulep?=
 =?iso-8859-1?Q?FuzxFf0JDMw0JvI+38giZWM06uXFq5IBERjS5cNXaDPgpobdqDt1SOjUkm?=
 =?iso-8859-1?Q?gLA7Fbtc8/wrVUv+3VLkFf1guJxkSLHcQVLpNJKUM9ijqcbYVA3dhkCYuw?=
 =?iso-8859-1?Q?zVTeIyUdMdz5+c97bv8py3algCt+Ww2ND+zprJ1hKkJ92TaWEm4WQYP2HN?=
 =?iso-8859-1?Q?XkFswWbY7s4FTWDJfsw3olEdpT947Pdlj/MU0AfUEQjQRwStp4GFCjyuEj?=
 =?iso-8859-1?Q?BzRDEqaw1vSDTv0h/m2B1YCnXf0KPuiogQ0w6EVL5iFnswUdCe2To+8cKr?=
 =?iso-8859-1?Q?s5x5JbG6468Il92Y5Eco+bcJLSGwgLar0o4kV5biOs4gZ/fUEd/6FbtKTo?=
 =?iso-8859-1?Q?hohNEHNlECqBez1eUWEkgMmJrjb3lyeb+/hYswE+O5QhS7LsVhHmkJT4sR?=
 =?iso-8859-1?Q?ETB/NgJYlt/OF6LTgAe6grA5INIjG1TEv94r+sdcXPeE2t/RK1yO4JxUyd?=
 =?iso-8859-1?Q?1DL0eadeS+4FQuE2o2Q2gwcAI0v/fylhAoi26uaZ9VBNPCKlMIUXqaciWs?=
 =?iso-8859-1?Q?Dxc5K7nrkyTkMyVT5si9pAw2QCcWw5xpMlTYf2tSyEvusNWk1CZWK4qrTA?=
 =?iso-8859-1?Q?vWDpIZeM44Chm09p9MdLGrTl7q7p/55EDS3/L+jpi6EEevt21PYXgH/NCe?=
 =?iso-8859-1?Q?INDh2viOVVBtFTOQDrtTYoQv0rWr3x0qWxlpSVBXFd1gu3SipD3sHFOPuw?=
 =?iso-8859-1?Q?5qCoTrWhgKmW+L6duUEHTTOzJS5yJwmFpIbvc7oytY6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DYU3EVhtxWQ/mjZmkwfmIJ2iqGX3aVSCcq4qPkoQVsEBtDXh3LiCYtr0RW?=
 =?iso-8859-1?Q?+4lyHpzC1hBd4rSQie7YwlhrDL2qcjM4vdXObAcM5rm3VoR5ICeWekMdI5?=
 =?iso-8859-1?Q?qsH6fY+eSI0jKit/U558viB1HXMfGEYGoTQROfYsoVI150RyIMwZ0c5A+P?=
 =?iso-8859-1?Q?0CpO9Gs+h5uz1emE5fUa2DL4EbIZ6CAnTxrKJTgx/g21Y2prKxdGjF+F0Q?=
 =?iso-8859-1?Q?JQ7TohmSyrN9861eByWId5m2ZszTpxnqkgH4Uz0nQ5+sRoQDr64DQmaYpx?=
 =?iso-8859-1?Q?hCupwbywr5YxWCMdGKfBmgsD9gXR0SX4iQkiuiE5uNRssSs3fRh/unS4OF?=
 =?iso-8859-1?Q?IXNMi3O0RxpXm2zeXfmd9Cowr1AKOG7/5woCrFtdZctDtlySgIaerBPQjA?=
 =?iso-8859-1?Q?C4/RcOIjeZi8wMQWvaQWMKd+BkG76AmxJKGGXTTUb+nMz5M8MbXlutf0FD?=
 =?iso-8859-1?Q?RSqTMi9y0knGQkhHz/VYw2DUVmsaL0Yf0OYnGshpqFUJUc+LF+g9p083ms?=
 =?iso-8859-1?Q?suEpxXpsKL6cVr6PgmL3MiiwnKMtz3Shqc/8dz2qpg/9rQ2uNOYw5gGjRy?=
 =?iso-8859-1?Q?ZdHMJ21otNABQApJmLx3bIdIbkRl8q0bC78duLYVPUVlkCTrZL/1cVqcp4?=
 =?iso-8859-1?Q?TWKSq9x0oBy1Q9p+9mLkA5dMXjK/jJqeo6b3ZoM24Oo5Zyn93bjIhxMqmr?=
 =?iso-8859-1?Q?ZnoK4NmwQeMF1P6GgRqMnTnpOoxOrMBRxdtofOV6XPnaHuFAbVLdZcHMso?=
 =?iso-8859-1?Q?nZIrlwGRLMRm2wFuas62oTVXeVL2GrLP0gwyE1OsqFg3KB0a5tsqgmo3zR?=
 =?iso-8859-1?Q?XPN30KHCvY+/dt9rZodSiNPPnr4vp12esk6e/eAZKih5nZ9Hl+P8WzY1Ft?=
 =?iso-8859-1?Q?IKxproo+A9aGLxk5J+J+7VkGd43Y/h7mJV1hS2R95R8VKqvXh8c7BIEmr2?=
 =?iso-8859-1?Q?q+tV7CT+KmhJaltmY3BQYJ1haiA98ULt3DWnPFGvw1NbnUKcCRmvRsHbR3?=
 =?iso-8859-1?Q?nbG0sjnH+2aR/jFZwV6e07QhfooEh8EzKJ2Shc58eohsX7x4+Zmks/7IkM?=
 =?iso-8859-1?Q?/mCXXlunxaSW1aiZPx4QeSS/30mC8c615FNp7bCPOll8nDK0RVpx/HQ1MA?=
 =?iso-8859-1?Q?15pulPSTCMdjF5CCX+JfniwkDikLYLxPDwFWzoHBfy6xOQwmyZLdBO3W+7?=
 =?iso-8859-1?Q?q7h1A5zP85vqRbRK/qxDunRCLgt7G3cPmwz6Si1RL6TWLP5tIgCAzmlH4I?=
 =?iso-8859-1?Q?jmZc24iRbRmyEaaWIIp17FHJfcf6la8i8s72ni/IGCYRDCVPklsOH8x4Oz?=
 =?iso-8859-1?Q?eeRPsBhRQK/z1f1WJeoYcTUZxDshTjH33FFl85NB9hJKtlriOsqKRgPiit?=
 =?iso-8859-1?Q?z4q0RZEOrn1qJAHzDozzwgG9A1VfY9oh82ZszS4mlwSV7MqCVkpWiL44d6?=
 =?iso-8859-1?Q?FLlLJfzu/SvGfDd9OzvXwUvR3TNXt6zr12YnCMpo4RL1BmiQjVUddYbHzh?=
 =?iso-8859-1?Q?wCQya+hpTUd4jMkDQ4Ce/7SM4eyytlRkWCc8B32NIoYq68v49yulilZ0pp?=
 =?iso-8859-1?Q?hm5hqas4MxmvjsSdgL6hmQiUokIfZ6Lkr/8ohGlDiGjTyyXQQF7sPO4qVV?=
 =?iso-8859-1?Q?ztt1TKxxMwMGhwRsS4MhshW8EMSkObuhILJG1LL2g6srdjwZwGW7hYzs3I?=
 =?iso-8859-1?Q?sRHLYzTQ5lwmFL4uryg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3064dd-a484-4f58-7f8a-08dde96a3bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 15:14:23.7575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tgeO5L25D9+rMldU73lOJgzVcfqzx/lUgX1NmHSGNJo9ZwjurREzQpPvB0Zdn6DVMRJ7WIwEgjsBpayD/N74VlktP21lDeOAM2q7A+dihg4ymt1riS7D7yVT/FO6nN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10438
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Damien Bergamini <damien.bergamini@eviden.com>

Starting with commit cab1398a60eb, SR-IOV VFs are realized as soon as
pcie_sriov_pf_init() is called.  Because pcie_sriov_pf_init() must be
called before pcie_sriov_pf_init_vf_bar(), the VF BARs types won't be
known when the VF realize function calls pcie_sriov_vf_register_bar().

This breaks the memory regions of the VFs (for instance with igbvf):

$ lspci
...
    Region 0: Memory at 281a00000 (64-bit, prefetchable) [virtual] [size=3D=
16K]
    Region 3: Memory at 281a20000 (64-bit, prefetchable) [virtual] [size=3D=
16K]

$ info mtree
...
address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    0000000081a00000-0000000081a03fff (prio 1, i/o): igbvf-mmio
    0000000081a20000-0000000081a23fff (prio 1, i/o): igbvf-msix

and causes MMIO accesses to fail:

    Invalid write at addr 0x281A01520, size 4, region '(null)', reason: rej=
ected
    Invalid read at addr 0x281A00C40, size 4, region '(null)', reason: reje=
cted

To fix this, VF BARs are now registered with pci_register_bar() which
has a type parameter and pcie_sriov_vf_register_bar() is removed.

Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
Signed-off-by: Damien Bergamini <damien.bergamini@eviden.com>
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 docs/pcie_sriov.txt         |  5 ++---
 hw/net/igbvf.c              |  6 ++++--
 hw/nvme/ctrl.c              |  8 ++------
 hw/pci/pci.c                |  3 ---
 hw/pci/pcie_sriov.c         | 11 -----------
 include/hw/pci/pcie_sriov.h |  4 ----
 6 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index ab2142807f..00d7bd93fd 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -72,8 +72,7 @@ setting up a BAR for a VF.
 2) Similarly in the implementation of the virtual function, you need to
    make it a PCI Express device and add a similar set of capabilities
    except for the SR/IOV capability. Then you need to set up the VF BARs a=
s
-   subregions of the PFs SR/IOV VF BARs by calling
-   pcie_sriov_vf_register_bar() instead of the normal pci_register_bar() c=
all:
+   subregions of the PFs SR/IOV VF BARs by calling pci_register_bar():
=20
    pci_your_vf_dev_realize( ... )
    {
@@ -83,7 +82,7 @@ setting up a BAR for a VF.
       pcie_ari_init(d, 0x100);
       ...
       memory_region_init(mr, ... )
-      pcie_sriov_vf_register_bar(d, bar_nr, mr);
+      pci_register_bar(d, bar_nr, bar_type, mr);
       ...
    }
=20
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 31d72c4977..9b0db8f841 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -251,10 +251,12 @@ static void igbvf_pci_realize(PCIDevice *dev, Error *=
*errp)
=20
     memory_region_init_io(&s->mmio, OBJECT(dev), &mmio_ops, s, "igbvf-mmio=
",
         IGBVF_MMIO_SIZE);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX, &s->mmio);
+    pci_register_bar(dev, IGBVF_MMIO_BAR_IDX, PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &s->mmio);
=20
     memory_region_init(&s->msix, OBJECT(dev), "igbvf-msix", IGBVF_MSIX_SIZ=
E);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX, &s->msix);
+    pci_register_bar(dev, IGBVF_MSIX_BAR_IDX, PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &s->msix);
=20
     ret =3D msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_ID=
X, 0,
         &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..cd81f73997 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8708,12 +8708,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pc=
i_dev, Error **errp)
                               msix_table_offset);
         memory_region_add_subregion(&n->bar0, 0, &n->iomem);
=20
-        if (pci_is_vf(pci_dev)) {
-            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
-        } else {
-            pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                             PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
-        }
+        pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
=20
         ret =3D msix_init(pci_dev, nr_vectors,
                         &n->bar0, 0, msix_table_offset,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..4fe2626f9e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1490,9 +1490,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_=
num,
                         : pci_get_bus(pci_dev)->address_space_mem;
=20
     if (pci_is_vf(pci_dev)) {
-        PCIDevice *pf =3D pci_dev->exp.sriov_vf.pf;
-        assert(!pf || type =3D=3D pf->exp.sriov_pf.vf_bar_type[region_num]=
);
-
         r->addr =3D pci_bar_address(pci_dev, region_num, r->type, r->size)=
;
         if (r->addr !=3D PCI_BAR_UNMAPPED) {
             memory_region_add_subregion_overlap(r->address_space,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 8a4bf0d6f7..29474d749a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -242,17 +242,6 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int reg=
ion_num,
     dev->exp.sriov_pf.vf_bar_type[region_num] =3D type;
 }
=20
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory)
-{
-    uint8_t type;
-
-    assert(dev->exp.sriov_vf.pf);
-    type =3D dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
-
-    return pci_register_bar(dev, region_num, type, memory);
-}
-
 static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
 {
     return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aeaa38cf34..b0ea6a62c7 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -37,10 +37,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev);
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
                                uint8_t type, dma_addr_t size);
=20
-/* Instantiate a bar for a VF */
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory);
-
 /**
  * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-cr=
eated
  *                                              VFs, adding ARI to PF
--=20
2.51.0

