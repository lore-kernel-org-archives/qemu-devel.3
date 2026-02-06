Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD1ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCNy-0000SM-Ni; Thu, 05 Feb 2026 22:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNm-0000Pu-Ew; Thu, 05 Feb 2026 22:19:49 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNi-0008F6-L1; Thu, 05 Feb 2026 22:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1/n9+SGBAi29lyWNSTisqLRzU0W/+ZBlugBClpp+9SVk2WjdRHrDNxWU9LlxA6bJuXwK5u0OoFZ3pwqB0NdLON0RtlMJkIFoiegvTAQXuql48B3l2JwQf7ajGf6sGcNPOMP2Z/ivQs1CLiTyNUTop+sEYqarhvxYgb0FeobgTP7LtHaMMx2wVGUHgh3Fhj5U9WTWEfwQGbxd/vvXrMVsEMmEQmxSwiyQ2EIDBO3wfPRpCykdvetCwkVM9XZolaLdqEXcTPx6s0zvpdZ8Bi5oWQBEoFfrZa2ZeSXkJoKrKE6KnWDV+Y/XCcZwQxJK3q5GjbtMqoEtfeFuRdtRtXwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq6lqDdsUDKT6H2KDYLpPMs8pjOFzpZprKW99LvIS9Q=;
 b=kmb4ZoojJG3bkzqHBHnjfWG2dArUqm3pTe+NnBZWWkNygOFUrpxr4DrhQEVFAOtoedlCp2bEoibQZ8F3Hsc204HQ8wuXC70O9u62Tbcr8d5ZSFh6/yoNuoxrCsJTUgHnM9YgIAVwDS03z11DioFeuQMBYlj7a6gQ/SzDck2ki5MSrV7Nq11dwSX8GYRHH4i7BK6N1/nVYZO8oMIfoZHfTpHaciJeMEHEledmK9Qs5ViySjA8i6QUHlPWYUWm86crO4PYnfCqmolB9koXxBjLqkGNJ/Zey7ZTzB1x/oHHPyxj31rSwYEZyNI6bZIooJpPeHj0LGf4iPmnNEF/N9cSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq6lqDdsUDKT6H2KDYLpPMs8pjOFzpZprKW99LvIS9Q=;
 b=PYgl8NJmoPMnM2gT6YkOAG2lsnJJm1pc02719yAMjvztfS0wq0ei5BGkYOmDwnsdXdplz7PuZl8AS0c45Eq0srl2m2XTs7SZV9HfpBi+dI7X/mnimkiP9PCbOR4LkpZ+yjobM6OLA4VrQQ17cqi1LcWZCVRXGnLtYSc5GT8IsnV3kAwH6giSGTIUT/WY/khN4WaVfTu0uOYcZu4Yx1C39BSyzkrMvAyrkTmx1oFHLuvX5Kr1hOfXFZPKtJ0tewJ5hOdO+CeDxeLp70MU2Mj3XMB21A1gkWX+fG+8VeByuo9ijeIeNJfPX194W3aYygi4dn8aa0QneD6GMPX17NduIA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:30 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>
Subject: [PATCH v3 02/20] hw/i3c: Add bus support
Thread-Topic: [PATCH v3 02/20] hw/i3c: Add bus support
Thread-Index: AQHclxdoOb0K7ZnheE+yUjY8p7Dykw==
Date: Fri, 6 Feb 2026 03:19:30 +0000
Message-ID: <20260206031926.3227848-3-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: b47b0e0b-edd7-4066-6b7c-08de652e8aea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ho4cJkrX6Ebm+XUp9qvhTWWLLPSRcnK3yVtzUuBiNIoBJr3cn1SgNTg/tt?=
 =?iso-8859-1?Q?HdaNLWGg8sgt1w5IzlOMcEpn6pn56gSpwu4fbhAxnFfKmpKpKe+7yoS+4n?=
 =?iso-8859-1?Q?BrYvYBI7fPGQJri2hZBZoYA/itLKnENGnPGebZeTnatCrKHt6+FkVvg3sF?=
 =?iso-8859-1?Q?yBKuZ7wwqHEu6mpa/ZLHAvYOLadWLCJt533cslwuwKE5hSP/OdnX9AN5cq?=
 =?iso-8859-1?Q?Br7MQhRsHt4oSGCUBM3dggWmbho2ZcIN081LddCl8vrwDHdV/anlVG/7+h?=
 =?iso-8859-1?Q?kpU0WKAbWRHDZKQ053mPhgJjAbqUvYEy7yb+E80amQYYDxkEipLLHJVcx3?=
 =?iso-8859-1?Q?uR/+ekGlhNEDsZVdUwomYn2ZDGPi/vLf7eoph4MBrD8C9abBRziLvJOOkC?=
 =?iso-8859-1?Q?QgLpbfhTIOJ9FyuXxKlN0Uz9WQse3+5M/E9QAqf9YXhHSfHBnzcbN/kLw6?=
 =?iso-8859-1?Q?fqxQLOAHXz8SVcRuihjWfb6XxGGZHMXHyHDjIXFPIzrHsGnNExZv7Eonve?=
 =?iso-8859-1?Q?dicdN6zPjWMNlVXtwL6utETI6wj9CHtyg4QDZwscyxViestVFSPn7xCcHz?=
 =?iso-8859-1?Q?u3+IG1WOzSCV+VzR+c98hKRfhLhoaDhZQ5PWjDCa5QY8XqX5Ko462nyV2q?=
 =?iso-8859-1?Q?okBkncvg8M6BFfWtcUcZ8ZogarYMvUFtOwfedxITmT2fVKE4M3ri9d0C/V?=
 =?iso-8859-1?Q?xJFACVpQ04xZ8w775M/kuGZG9iO939eUCxFCkkYRnTPvUhblme1/WO2hN9?=
 =?iso-8859-1?Q?OkFs65JkUhrJSiU6sZz95yGAOZZ6+SjpJr4zzv6YjEU2IyN3N0N9CyKVcB?=
 =?iso-8859-1?Q?rYPM6hYwGSFp9N04YjzngQxBYK+n8/vClahOzJaaa935C1LkqdEN341lsR?=
 =?iso-8859-1?Q?60+KlF4U7ETmEhBNZ/U8ZBO2xYpO16Y9vwiPeqQEmNy8c1nZ8z8LJ9Z1uk?=
 =?iso-8859-1?Q?bBsKHghkafbyUBiOK18ETBVaOrbcObYRojtQrXnRCjXFocUgvZ0R9K+Pqk?=
 =?iso-8859-1?Q?e84LRscvj/+z7ajWnYQ6BNau9WwX6IgJk/42c+h8sp09uI3xdhoJES5QHs?=
 =?iso-8859-1?Q?dg2VO9UlimbteP2ImWoCN7mwdrRcTONkfYjyFNJQv0UrQgq2+RntHA5m6N?=
 =?iso-8859-1?Q?e5Rc5WKyRSkSqkzpa3wmZLxjmehTdG9KqgQNVKl/+eIHXrSL8mkjQXzSDP?=
 =?iso-8859-1?Q?ktZ6BYufMRiW7EiO20MPiyklvKPyem+BhApSh2vp9aXyZ6Jyaz5BiZ5V7+?=
 =?iso-8859-1?Q?2HvbB6APSE8054VKrL/1tAPengHeQOHaYTlwnMqJBwh36Q6pAZCftksc6w?=
 =?iso-8859-1?Q?H6t6/LZMrzBv1Lg7VpLfj5HAGh2V3VZQ/ybuerMcbq/8dCfM911Uz/FC9N?=
 =?iso-8859-1?Q?ar70D4tXHnITD0GU4DgpBfCpgLfvpNc02g88a/IaiObUUBpAY/YM5+f2J1?=
 =?iso-8859-1?Q?67CQyB0i6Qsw+KDvoZtfyRh+Yt2CnpJ7arcWnPtKqZpyTENvR4hiAAfM1m?=
 =?iso-8859-1?Q?139dltlBaABHO8pkKdLRPoZaiMO6Y8pjmvGQx0H3uVSIagtkTUsLSpZLZg?=
 =?iso-8859-1?Q?2LtU8Rmee09fkhhRqEJMXs8m7gfC8jHtwMdVmLDUi1wlhITyyfGxHUBuuH?=
 =?iso-8859-1?Q?dT/e4adOY/Q2L9KO/UrqB/q5GJ4qE18y+F3wAyqQ50TxUR59FQBRN7pu1K?=
 =?iso-8859-1?Q?qXWR5uIPowuMAzOgb3/0vE/f6VWL7TBJRnChbEnW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/V7CtAAqU/QHkLX7in8f55fj8VP9jD16pLMk4PrxlyPQbcEwFbTr+lg1zZ?=
 =?iso-8859-1?Q?Y65JlloiY+9OK5FCmZfhPa5ulQ5Qfd2xgZR9QTLVsNTqgrRkCr0S3URC2G?=
 =?iso-8859-1?Q?nZVFJGID18au23IDaexkh9ASfuhYG+6LuS3IWIWnO966jkhhQtLGNbA8NU?=
 =?iso-8859-1?Q?NIYacqm0j12g8okzF+IEseNwouvSbzv9mLyzE8U1kfL0jbLWWLfykaolqT?=
 =?iso-8859-1?Q?ixrMAPuYoby/2cNm3sW7svKjmXHGT1cfcU4M+K3QaSZqo5wJlVRtmjrX0v?=
 =?iso-8859-1?Q?lu5BSrRT6juUHP74Cc+sjqzpGx4iQBYSwfSCyKdPJu82NvU1tPemXiFhjp?=
 =?iso-8859-1?Q?n7WLqBaA4zXSYV8xFhTB216ggV5NOPuhvUR6g/65YQP9dcIFAsvH2rpGds?=
 =?iso-8859-1?Q?+EO8bnc9iGDLp5W2tCNlGXqY2BTCfJ4ixsRJJLhW1s47kwwB/QRfu5cACa?=
 =?iso-8859-1?Q?JT/CDWbQlL9UddNSzJX51ByhlgMK3LoSKlJfGhB/38Us8aPeCIWtotzSYt?=
 =?iso-8859-1?Q?g3CY14ZMrUwHpToSeKSU6Pg6TxTx0Aeer9FgZLiMtW7/uDMZpxFA95+pEM?=
 =?iso-8859-1?Q?K2LSZqPQobwNfO61+6vxlO9i7txys+LrrPFsc743i3R03sltvineZdEuiE?=
 =?iso-8859-1?Q?KMn0cc0GHISRg26zZvzRqHP/v4+laGJrVadH1bV8hbkXrVP2gY8ABqVIvC?=
 =?iso-8859-1?Q?RhrRSKyuYYjOLMK5bHXQ7MH1YSIT7Wxk2HB9Zq/o8RGZ/7gVLrh8DY16K8?=
 =?iso-8859-1?Q?DxNp22jKk2tv9RzH9O1BwJlASZo8/9/70cPo5N9GkxSXyFH0jSw0QbmVcd?=
 =?iso-8859-1?Q?NqSsTACGIcZLDOlzpHesQn4u09D60yI94xiJjfam5n2N0GhStVNiZC+lnN?=
 =?iso-8859-1?Q?YXIhJx+zlAzAzCpoM6UEQZiCwtIC2OiEgzQRKDrKJvFzEDNrtsDt8n7R+C?=
 =?iso-8859-1?Q?4Zetei1dTv20dUlA6nNca/GRUlvapLPgpQdBp6pBZKKmf927In0sCSTfko?=
 =?iso-8859-1?Q?uU383rQxfjZKeO9KP/qidBU4nTtbtPLsvNUOcUV499cXQJbAqQUz8EGZpY?=
 =?iso-8859-1?Q?89nLARDaHzLnDAkEib5X2hHcPYP6LTI+uvsrG+hD/gGnnJXvncz+zPK4bc?=
 =?iso-8859-1?Q?jR6DrEjb3b8qUVHmSXa8C90e0fIQ0AJV0cExqTlh1aSTdp/o5pVFsBgrDo?=
 =?iso-8859-1?Q?euKh6FxozN8uweUWx43HrIv3X99pj03g3hQLDU1y0Bghlj9bZPhXwdBr3u?=
 =?iso-8859-1?Q?FD9Pgm4ySN8DELkLV9NmnqL47tUhEGcUYAQkK8O00zG0YznbYac0P4wPU7?=
 =?iso-8859-1?Q?5DmlzdtwAmL+2Jyn1IjoCqHkJKZDeva0hNZFez42U8EC9C4yeybNTmr8YF?=
 =?iso-8859-1?Q?bYH6zZ82kkdtWtbIq97QWLOi1PbK7LJcFrEiLbXkyZ3eEShsqZfCRVrOgj?=
 =?iso-8859-1?Q?KIcb7OtZBOfd0/gPsa69aT5skFnrXMYmG+MJtc3ZfbHwxMZZnEp/HVoDkR?=
 =?iso-8859-1?Q?wAM/cmx6/FecjonP9UpV2NGclZIWn2Sp/hx0+JyMIRJp+7gppYYRGNK1Wj?=
 =?iso-8859-1?Q?i35vs+f5xugY4Ef9SNZnG9g7u6JExP0PhKggz2babXNziz+7ohWC2EPoK/?=
 =?iso-8859-1?Q?f+VTaX0xrmNWhlIkFVPFts2aVww4r8f3Pi+rNs2GnaEzdT0ALzB9UoZNjN?=
 =?iso-8859-1?Q?qZ6Lp3Yil5pfmB7Z5MIOGuOiEMhqQU3KKdFqvtZ24P6J8kx/dkotUJq4Hp?=
 =?iso-8859-1?Q?SqXtzomkrJJTp3gIOQkfLz4/8nz6V/gER50SejO4yzhg00Wajm9ax9i3o+?=
 =?iso-8859-1?Q?w/lTYRMNWQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47b0e0b-edd7-4066-6b7c-08de652e8aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:30.6691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAgdw95l6VFYiMTHCxRMM8hQH2BJmPD0LyOhXGK8Vb6jPfmT82Arf6StpFndTwkKJHJi5qfsL0K4pDwiB6+44tcPh7Q6rtLA7XncW7oo2V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

Adds an I3C bus and a target class.=0A=
The bus supports:=0A=
- I3C data transmission and reception=0A=
- CCCs (including ENTDAA)=0A=
- IBIs=0A=
- legacy I2C transactions=0A=
=0A=
General usage of the bus is similar to I2C. Users are expected to=0A=
initialize a bus via i3c_init_bus, and use the bus returned from the=0A=
init function to do transactions on the bus.=0A=
=0A=
In order to handle IBIs, the controller provides callbacks to handle=0A=
receiving an IBI from a target, receiving (optional) additional IBI=0A=
bytes from a target, and handling when a target is done with its IBI.=0A=
=0A=
Similarly, target creation is done via i3c_target_create_simple and=0A=
users use the provided I3CTarget to handle transactions.=0A=
The target has functions provided that it can use to invoke an IBI and=0A=
send additional bytes.=0A=
=0A=
Along with the send, recv, and event callbacks that are expected of an=0A=
I3C target, which are similar to I2C, there is a separate callback for=0A=
CCC handling.=0A=
This is to help encapsulate CCC handling and keep it separate from=0A=
target-specific read/write functionality.=0A=
=0A=
To avoid repition for required CCCs among I3C targets, there is some=0A=
class-level CCC handling added. The CCC is then passed to the target in=0A=
case it needs to handle it in some way.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/i3c.h | 277 ++++++++++++++++++=0A=
 hw/i3c/core.c        | 652 +++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/meson.build   |   1 +=0A=
 hw/i3c/trace-events  |  16 ++=0A=
 4 files changed, 946 insertions(+)=0A=
 create mode 100644 include/hw/i3c/i3c.h=0A=
 create mode 100644 hw/i3c/core.c=0A=
=0A=
diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h=0A=
new file mode 100644=0A=
index 0000000000..455c2a4a4f=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/i3c.h=0A=
@@ -0,0 +1,277 @@=0A=
+/*=0A=
+ * QEMU I3C bus interface.=0A=
+ *=0A=
+ * Copyright 2025 Google LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef QEMU_INCLUDE_HW_I3C_I3C_H_=0A=
+#define QEMU_INCLUDE_HW_I3C_I3C_H_=0A=
+=0A=
+#include "hw/core/qdev.h"=0A=
+#include "qom/object.h"=0A=
+#include "hw/i2c/i2c.h"=0A=
+=0A=
+#define TYPE_I3C_TARGET "i3c-target"=0A=
+OBJECT_DECLARE_TYPE(I3CTarget, I3CTargetClass, I3C_TARGET)=0A=
+=0A=
+typedef enum I3CEvent {=0A=
+    I3C_START_RECV,=0A=
+    I3C_START_SEND,=0A=
+    I3C_STOP,=0A=
+    I3C_NACK,=0A=
+} I3CEvent;=0A=
+=0A=
+typedef enum I3CCCC {=0A=
+    /* Broadcast CCCs */=0A=
+    I3C_CCC_ENEC      =3D 0x00,=0A=
+    I3C_CCC_DISEC     =3D 0x01,=0A=
+    I3C_CCC_ENTAS0    =3D 0x02,=0A=
+    I3C_CCC_ENTAS1    =3D 0x03,=0A=
+    I3C_CCC_ENTAS2    =3D 0x04,=0A=
+    I3C_CCC_ENTAS3    =3D 0x05,=0A=
+    I3C_CCC_RSTDAA    =3D 0x06,=0A=
+    I3C_CCC_ENTDAA    =3D 0x07,=0A=
+    I3C_CCC_DEFTGTS   =3D 0x08,=0A=
+    I3C_CCC_SETMWL    =3D 0x09,=0A=
+    I3C_CCC_SETMRL    =3D 0x0a,=0A=
+    I3C_CCC_ENTTM     =3D 0x0b,=0A=
+    I3C_CCC_SETBUSCON =3D 0x0c,=0A=
+    I3C_CCC_ENDXFER   =3D 0x12,=0A=
+    I3C_CCC_ENTHDR0   =3D 0x20,=0A=
+    I3C_CCC_ENTHDR1   =3D 0x21,=0A=
+    I3C_CCC_ENTHDR2   =3D 0x22,=0A=
+    I3C_CCC_ENTHDR3   =3D 0x23,=0A=
+    I3C_CCC_ENTHDR4   =3D 0x24,=0A=
+    I3C_CCC_ENTHDR5   =3D 0x25,=0A=
+    I3C_CCC_ENTHDR6   =3D 0x26,=0A=
+    I3C_CCC_ENTHDR7   =3D 0x27,=0A=
+    I3C_CCC_SETXTIME  =3D 0x28,=0A=
+    I3C_CCC_SETAASA   =3D 0x29,=0A=
+    I3C_CCC_RSTACT    =3D 0x2a,=0A=
+    I3C_CCC_DEFGRPA   =3D 0x2b,=0A=
+    I3C_CCC_RSTGRPA   =3D 0x2c,=0A=
+    I3C_CCC_MLANE     =3D 0x2d,=0A=
+    /* Direct CCCs */=0A=
+    I3C_CCCD_ENEC       =3D 0x80,=0A=
+    I3C_CCCD_DISEC      =3D 0x81,=0A=
+    I3C_CCCD_ENTAS0     =3D 0x82,=0A=
+    I3C_CCCD_ENTAS1     =3D 0x83,=0A=
+    I3C_CCCD_ENTAS2     =3D 0x84,=0A=
+    I3C_CCCD_ENTAS3     =3D 0x85,=0A=
+    I3C_CCCD_SETDASA    =3D 0x87,=0A=
+    I3C_CCCD_SETNEWDA   =3D 0x88,=0A=
+    I3C_CCCD_SETMWL     =3D 0x89,=0A=
+    I3C_CCCD_SETMRL     =3D 0x8a,=0A=
+    I3C_CCCD_GETMWL     =3D 0x8b,=0A=
+    I3C_CCCD_GETMRL     =3D 0x8c,=0A=
+    I3C_CCCD_GETPID     =3D 0x8d,=0A=
+    I3C_CCCD_GETBCR     =3D 0x8e,=0A=
+    I3C_CCCD_GETDCR     =3D 0x8f,=0A=
+    I3C_CCCD_GETSTATUS  =3D 0x90,=0A=
+    I3C_CCCD_GETACCCR   =3D 0x91,=0A=
+    I3C_CCCD_ENDXFER    =3D 0x92,=0A=
+    I3C_CCCD_SETBRGTGT  =3D 0x93,=0A=
+    I3C_CCCD_GETMXDS    =3D 0x94,=0A=
+    I3C_CCCD_GETCAPS    =3D 0x95,=0A=
+    I3C_CCCD_SETROUTE   =3D 0x96,=0A=
+    I3C_CCCD_SETXTIME   =3D 0x98,=0A=
+    I3C_CCCD_GETXTIME   =3D 0x99,=0A=
+    I3C_CCCD_RSTACT     =3D 0x9a,=0A=
+    I3C_CCCD_SETGRPA    =3D 0x9b,=0A=
+    I3C_CCCD_RSTGRPA    =3D 0x9c,=0A=
+    I3C_CCCD_MLANE      =3D 0x9d,=0A=
+} I3CCCC;=0A=
+=0A=
+#define CCC_IS_DIRECT(_ccc) (_ccc & 0x80)=0A=
+=0A=
+#define I3C_BROADCAST 0x7e=0A=
+#define I3C_HJ_ADDR 0x02=0A=
+#define I3C_ENTDAA_SIZE 8=0A=
+=0A=
+struct I3CTargetClass {=0A=
+    DeviceClass parent;=0A=
+=0A=
+    /*=0A=
+     * Controller to target. Returns 0 for success, non-zero for NAK or ot=
her=0A=
+     * error.=0A=
+     */=0A=
+    int (*send)(I3CTarget *s, const uint8_t *data, uint32_t num_to_send,=
=0A=
+                uint32_t *num_sent);=0A=
+    /*=0A=
+     * Target to controller. I3C targets are able to terminate reads early=
, so=0A=
+     * this returns the number of bytes read from the target.=0A=
+     */=0A=
+    uint32_t (*recv)(I3CTarget *s, uint8_t *data, uint32_t num_to_read);=
=0A=
+    /* Notify the target of a bus state change. */=0A=
+    int (*event)(I3CTarget *s, enum I3CEvent event);=0A=
+    /*=0A=
+     * Handle a read CCC transmitted from a controller.=0A=
+     * CCCs are I3C commands that I3C targets support.=0A=
+     * The target can NACK the CCC if it does not support it.=0A=
+     */=0A=
+    int (*handle_ccc_read)(I3CTarget *s, uint8_t *data, uint32_t num_to_re=
ad,=0A=
+                           uint32_t *num_read);=0A=
+    /*=0A=
+     * Handle a write CCC transmitted from a controller.=0A=
+     * CCCs are I3C commands that I3C targets support.=0A=
+     * The target can NACK the CCC if it does not support it.=0A=
+     */=0A=
+    int (*handle_ccc_write)(I3CTarget *s, const uint8_t *data,=0A=
+                            uint32_t num_to_send, uint32_t *num_sent);=0A=
+=0A=
+    /*=0A=
+     * Matches and adds the candidate if the address matches the candidate=
's=0A=
+     * address.=0A=
+     * Returns true if the address matched, or if this was a broadcast, an=
d=0A=
+     * updates the device list. Otherwise returns false.=0A=
+     */=0A=
+    bool (*target_match)(I3CTarget *candidate, uint8_t address, bool is_re=
ad,=0A=
+                         bool broadcast, bool in_entdaa);=0A=
+};=0A=
+=0A=
+struct I3CTarget {=0A=
+    DeviceState qdev;=0A=
+=0A=
+    uint8_t address;=0A=
+    uint8_t static_address;=0A=
+    uint8_t dcr;=0A=
+    uint8_t bcr;=0A=
+    uint64_t pid;=0A=
+=0A=
+    /* CCC State tracking. */=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+    bool in_ccc;=0A=
+    bool in_test_mode;=0A=
+};=0A=
+=0A=
+struct I3CNode {=0A=
+    I3CTarget *target;=0A=
+    QLIST_ENTRY(I3CNode) next;=0A=
+};=0A=
+=0A=
+typedef struct I3CNode I3CNode;=0A=
+=0A=
+typedef QLIST_HEAD(I3CNodeList, I3CNode) I3CNodeList;=0A=
+=0A=
+#define TYPE_I3C_BUS "i3c-bus"=0A=
+OBJECT_DECLARE_TYPE(I3CBus, I3CBusClass, I3C_BUS)=0A=
+=0A=
+struct I3CBus {=0A=
+    BusState qbus;=0A=
+=0A=
+    /* Legacy I2C. */=0A=
+    I2CBus *i2c_bus;=0A=
+=0A=
+    I3CNodeList current_devs;=0A=
+    bool broadcast;=0A=
+    uint8_t ccc;=0A=
+    bool in_ccc;=0A=
+    bool in_entdaa;=0A=
+    uint8_t saved_address;=0A=
+};=0A=
+=0A=
+struct I3CBusClass {=0A=
+    DeviceClass parent;=0A=
+=0A=
+    /* Handle an incoming IBI request from a target */=0A=
+    int (*ibi_handle) (I3CBus *bus, uint8_t addr, bool is_recv);=0A=
+    /* Receive data from an IBI request */=0A=
+    int (*ibi_recv) (I3CBus *bus, uint8_t data);=0A=
+    /* Do anything that needs to be done, since the IBI is finished. */=0A=
+    int (*ibi_finish) (I3CBus *bus);=0A=
+};=0A=
+=0A=
+I3CBus *i3c_init_bus(DeviceState *parent, const char *name);=0A=
+I3CBus *i3c_init_bus_type(const char *type, DeviceState *parent,=0A=
+                          const char *name);=0A=
+void i3c_set_target_address(I3CTarget *dev, uint8_t address);=0A=
+bool i3c_bus_busy(I3CBus *bus);=0A=
+=0A=
+/*=0A=
+ * Start a transfer on an I3C bus.=0A=
+ * If is_recv is known at compile-time (i.e. a device will always be sendi=
ng or=0A=
+ * will always be receiving at a certain point), prefer to use i3c_start_r=
ecv or=0A=
+ * i3c_start_send instead.=0A=
+ *=0A=
+ * Returns 0 on success, non-zero on an error.=0A=
+ */=0A=
+int i3c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv);=0A=
+=0A=
+/*=0A=
+ * Start a receive transfer on an I3C bus.=0A=
+ *=0A=
+ * Returns 0 on success, non-zero on an error=0A=
+ */=0A=
+int i3c_start_recv(I3CBus *bus, uint8_t address);=0A=
+=0A=
+/*=0A=
+ * Start a send transfer on an I3C bus.=0A=
+ *=0A=
+ * Returns 0 on success, non-zero on an error=0A=
+ */=0A=
+int i3c_start_send(I3CBus *bus, uint8_t address);=0A=
+=0A=
+void i3c_end_transfer(I3CBus *bus);=0A=
+void i3c_nack(I3CBus *bus);=0A=
+int i3c_send_byte(I3CBus *bus, uint8_t data);=0A=
+int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,=0A=
+             uint32_t *num_sent);=0A=
+/*=0A=
+ * I3C receives can only NACK on a CCC. The target should NACK a CCC it do=
es not=0A=
+ * support.=0A=
+ */=0A=
+int i3c_recv_byte(I3CBus *bus, uint8_t *data);=0A=
+int i3c_recv(I3CBus *bus, uint8_t *data, uint32_t num_to_read,=0A=
+             uint32_t *num_read);=0A=
+bool i3c_scan_bus(I3CBus *bus, uint8_t address, enum I3CEvent event);=0A=
+int i3c_do_entdaa(I3CBus *bus, uint8_t address, uint64_t *pid, uint8_t *bc=
r,=0A=
+                  uint8_t *dcr);=0A=
+int i3c_start_device_transfer(I3CTarget *dev, int send_length);=0A=
+bool i3c_target_match_and_add(I3CBus *bus, I3CTarget *target, uint8_t addr=
ess,=0A=
+                             enum I3CEvent event);=0A=
+int i3c_target_send_ibi(I3CTarget *t, uint8_t addr, bool is_recv);=0A=
+int i3c_target_send_ibi_bytes(I3CTarget *t, uint8_t data);=0A=
+int i3c_target_ibi_finish(I3CTarget *t, uint8_t data);=0A=
+=0A=
+/*=0A=
+ * Legacy I2C functions.=0A=
+ *=0A=
+ * These are wrapper for I2C functions that take in an I3C bus instead of =
an I2C=0A=
+ * bus. Internally they use the I2C bus (and devices attached to it) that'=
s a=0A=
+ * part of the I3C bus=0A=
+ */=0A=
+void legacy_i2c_nack(I3CBus *bus);=0A=
+uint8_t legacy_i2c_recv(I3CBus *bus);=0A=
+int legacy_i2c_send(I3CBus *bus, uint8_t data);=0A=
+int legacy_i2c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv);=
=0A=
+int legacy_i2c_start_recv(I3CBus *bus, uint8_t address);=0A=
+int legacy_i2c_start_send(I3CBus *bus, uint8_t address);=0A=
+void legacy_i2c_end_transfer(I3CBus *bus);=0A=
+I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,=
=0A=
+                                          uint8_t addr);=0A=
+=0A=
+/**=0A=
+ * Create an I3C Target.=0A=
+ *=0A=
+ * The target returned from this function still needs to be realized.=0A=
+ */=0A=
+I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,=0A=
+                          uint8_t bcr, uint64_t pid);=0A=
+=0A=
+/**=0A=
+ * Create and realize an I3C target.=0A=
+ *=0A=
+ * Create the target, initialize it, put it on the specified I3C bus, and=
=0A=
+ * realize it.=0A=
+ */=0A=
+I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name,=0A=
+                                    uint8_t addr, uint8_t dcr, uint8_t bcr=
,=0A=
+                                    uint64_t pid);=0A=
+=0A=
+/* Realize and drop the reference count on an I3C target. */=0A=
+bool i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error **err=
p);=0A=
+=0A=
+#endif  /* QEMU_INCLUDE_HW_I3C_I3C_H_ */=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
new file mode 100644=0A=
index 0000000000..fb4bfe5aec=0A=
--- /dev/null=0A=
+++ b/hw/i3c/core.c=0A=
@@ -0,0 +1,652 @@=0A=
+/*=0A=
+ * QEMU I3C bus interface.=0A=
+ *=0A=
+ * Copyright 2025 Google LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qapi/error.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+=0A=
+/*=0A=
+ * In test mode (enabled by ENTTM CCC) we're supposed to send a random PID=
=0A=
+ * during ENTDAA, so we'll just send "QEMU".=0A=
+ */=0A=
+#define TEST_MODE_PROVISIONED_ID 0x0000554d4551ULL=0A=
+=0A=
+static const Property i3c_props[] =3D {=0A=
+    DEFINE_PROP_UINT8("static-address", struct I3CTarget, static_address, =
0),=0A=
+    DEFINE_PROP_UINT8("dcr", struct I3CTarget, dcr, 0),=0A=
+    DEFINE_PROP_UINT8("bcr", struct I3CTarget, bcr, 0),=0A=
+    DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
+};=0A=
+=0A=
+static const TypeInfo i3c_bus_info =3D {=0A=
+    .name =3D TYPE_I3C_BUS,=0A=
+    .parent =3D TYPE_BUS,=0A=
+    .instance_size =3D sizeof(I3CBus),=0A=
+    .class_size =3D sizeof(I3CBusClass),=0A=
+};=0A=
+=0A=
+I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
+{=0A=
+    return i3c_init_bus_type(TYPE_I3C_BUS, parent, name);=0A=
+}=0A=
+=0A=
+I3CBus *i3c_init_bus_type(const char *type, DeviceState *parent,=0A=
+                          const char *name)=0A=
+{=0A=
+    I3CBus *bus;=0A=
+=0A=
+    bus =3D I3C_BUS(qbus_new(type, parent, name));=0A=
+    QLIST_INIT(&bus->current_devs);=0A=
+    bus->broadcast =3D false;=0A=
+    bus->in_entdaa =3D false;=0A=
+    bus->in_ccc =3D false;=0A=
+=0A=
+    /* I2C init. */=0A=
+    g_autofree gchar *i2c_bus_name =3D g_strdup_printf("%s-legacy-i2c", na=
me);=0A=
+    bus->i2c_bus =3D i2c_init_bus(parent, i2c_bus_name);=0A=
+=0A=
+    return bus;=0A=
+}=0A=
+=0A=
+bool i3c_bus_busy(I3CBus *bus)=0A=
+{=0A=
+    return !QLIST_EMPTY(&bus->current_devs);=0A=
+}=0A=
+=0A=
+static bool i3c_target_match(I3CTarget *candidate, uint8_t address,=0A=
+                             bool is_recv, bool broadcast, bool in_entdaa)=
=0A=
+{=0A=
+    /* Once a target has a dynamic address, it only responds to that. */=
=0A=
+    uint8_t targ_addr =3D candidate->address ? candidate->address :=0A=
+                                             candidate->static_address;=0A=
+=0A=
+    if (in_entdaa) {=0A=
+        if (address !=3D I3C_BROADCAST) {=0A=
+            g_autofree char *path =3D=0A=
+                object_get_canonical_path(OBJECT(candidate));=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: I3C Address 0x%.2x sent du=
ring "=0A=
+                          "ENTDAA instead of a broadcast address\n",=0A=
+                          path, address);=0A=
+            return false;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * Targets should only ACK ENTDAA broadcasts if they have no dynam=
ic=0A=
+         * address.=0A=
+         */=0A=
+        return candidate->address =3D=3D 0;=0A=
+    }=0A=
+=0A=
+    /* Return if our addresses match, or if it's a broadcast. */=0A=
+    return targ_addr =3D=3D address || broadcast;=0A=
+}=0A=
+=0A=
+bool i3c_target_match_and_add(I3CBus *bus, I3CTarget *target, uint8_t addr=
ess,=0A=
+                              enum I3CEvent event)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(target);=0A=
+    bool matched =3D tc->target_match(target, address, event =3D=3D I3C_ST=
ART_RECV,=0A=
+                                    bus->broadcast, bus->in_entdaa);=0A=
+=0A=
+    if (matched) {=0A=
+        I3CNode *node =3D g_new(struct I3CNode, 1);=0A=
+        node->target =3D target;=0A=
+        QLIST_INSERT_HEAD(&bus->current_devs, node, next);=0A=
+    }=0A=
+    return matched;=0A=
+}=0A=
+=0A=
+bool i3c_scan_bus(I3CBus *bus, uint8_t address, enum I3CEvent event)=0A=
+{=0A=
+    BusChild *child;=0A=
+    I3CNode *node, *next;=0A=
+=0A=
+    /* Clear out any devices from a previous (re-)START. */=0A=
+    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {=0A=
+        QLIST_REMOVE(node, next);=0A=
+        g_free(node);=0A=
+    }=0A=
+=0A=
+    QTAILQ_FOREACH(child, &bus->qbus.children, sibling) {=0A=
+        DeviceState *qdev =3D child->child;=0A=
+        I3CTarget *target =3D I3C_TARGET(qdev);=0A=
+=0A=
+        if (i3c_target_match_and_add(bus, target, address, event)) {=0A=
+            return true;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* No one on the bus could respond. */=0A=
+    return false;=0A=
+}=0A=
+=0A=
+/* Class-level event handling, since we do some CCCs at the class level. *=
/=0A=
+static int i3c_target_event(I3CTarget *t, enum I3CEvent event)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+    trace_i3c_target_event(t->address, event);=0A=
+=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        t->curr_ccc =3D 0;=0A=
+        t->ccc_byte_offset =3D 0;=0A=
+        t->in_ccc =3D false;=0A=
+    }=0A=
+    return tc->event(t, event);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Sends a START or repeated START and the address for an I3C transaction.=
=0A=
+ *=0A=
+ * This function returns 0 if a device on the bus was able to respond to t=
he=0A=
+ * address, and non-zero otherwise.=0A=
+ * A non-zero return represents a NACK.=0A=
+ */=0A=
+static int i3c_do_start_transfer(I3CBus *bus, uint8_t address,=0A=
+                                 enum I3CEvent event)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CNode *node;=0A=
+=0A=
+    if (address =3D=3D I3C_BROADCAST) {=0A=
+        bus->broadcast =3D true;=0A=
+        /* If we're not in ENTDAA, a broadcast is the start of a new CCC. =
*/=0A=
+        if (!bus->in_entdaa) {=0A=
+            bus->in_ccc =3D false;=0A=
+        }=0A=
+    } else {=0A=
+        bus->broadcast =3D false;=0A=
+    }=0A=
+=0A=
+    /* No one responded to the address, NACK it. */=0A=
+    if (!i3c_scan_bus(bus, address, event)) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    QLIST_FOREACH(node, &bus->current_devs, next) {=0A=
+        I3CTarget *t =3D node->target;=0A=
+=0A=
+        tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+        if (tc->event) {=0A=
+            int rv =3D i3c_target_event(t, event);=0A=
+            if (rv && !bus->broadcast) {=0A=
+                return rv;=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+int i3c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv)=0A=
+{=0A=
+    trace_i3c_start_transfer(address, is_recv);=0A=
+    return i3c_do_start_transfer(bus, address, is_recv=0A=
+                                               ? I3C_START_RECV=0A=
+                                               : I3C_START_SEND);=0A=
+}=0A=
+=0A=
+int i3c_start_recv(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_i3c_start_transfer(address, true);=0A=
+    return i3c_do_start_transfer(bus, address, I3C_START_RECV);=0A=
+}=0A=
+=0A=
+int i3c_start_send(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_i3c_start_transfer(address, false);=0A=
+    return i3c_do_start_transfer(bus, address, I3C_START_SEND);=0A=
+}=0A=
+=0A=
+void i3c_end_transfer(I3CBus *bus)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CNode *node, *next;=0A=
+=0A=
+    trace_i3c_end_transfer();=0A=
+=0A=
+    /*=0A=
+     * If we're in ENTDAA, we need to notify all devices when ENTDAA is do=
ne.=0A=
+     * This is because everyone initially participates due to the broadcas=
t,=0A=
+     * but gradually drops out as they get assigned addresses.=0A=
+     * Since the current_devs list only stores who's currently participati=
ng,=0A=
+     * and not everyone who previously participated, we send the STOP to a=
ll=0A=
+     * children.=0A=
+     */=0A=
+    if (bus->in_entdaa) {=0A=
+        BusChild *child;=0A=
+=0A=
+        QTAILQ_FOREACH(child, &bus->qbus.children, sibling) {=0A=
+            DeviceState *qdev =3D child->child;=0A=
+            I3CTarget *t =3D I3C_TARGET(qdev);=0A=
+            tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+            if (tc->event) {=0A=
+                i3c_target_event(t, I3C_STOP);=0A=
+            }=0A=
+        }=0A=
+    } else {=0A=
+        QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {=0A=
+            I3CTarget *t =3D node->target;=0A=
+            tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+            if (tc->event) {=0A=
+                i3c_target_event(t, I3C_STOP);=0A=
+            }=0A=
+            QLIST_REMOVE(node, next);=0A=
+            g_free(node);=0A=
+        }=0A=
+    }=0A=
+    bus->broadcast =3D false;=0A=
+    bus->in_entdaa =3D false;=0A=
+    bus->in_ccc =3D false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Any CCCs that are universal across all I3C devices should be handled he=
re.=0A=
+ * Once they're handled, we pass the CCC up to the I3C target to do anythi=
ng=0A=
+ * else it may want with the bytes.=0A=
+ */=0A=
+static int i3c_target_handle_ccc_write(I3CTarget *t, const uint8_t *data,=
=0A=
+                                       uint32_t num_to_send, uint32_t *num=
_sent)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+    *num_sent =3D 0;=0A=
+=0A=
+    /* Is this the start of a new CCC? */=0A=
+    if (!t->in_ccc) {=0A=
+        t->curr_ccc =3D *data;=0A=
+        t->in_ccc =3D true;=0A=
+        *num_sent =3D 1;=0A=
+        trace_i3c_target_handle_ccc(t->address, t->curr_ccc);=0A=
+    }=0A=
+=0A=
+    switch (t->curr_ccc) {=0A=
+    case I3C_CCC_ENTDAA:=0A=
+        /*=0A=
+         * This is the last byte of ENTDAA, the controller is assigning us=
 an=0A=
+         * address.=0A=
+         */=0A=
+        if (t->ccc_byte_offset =3D=3D 8) {=0A=
+            t->address =3D *data;=0A=
+            t->in_ccc =3D false;=0A=
+            t->curr_ccc =3D 0;=0A=
+            t->ccc_byte_offset =3D 0;=0A=
+            *num_sent =3D 1;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_SETDASA:=0A=
+        t->address =3D t->static_address;=0A=
+        break;=0A=
+    case I3C_CCC_SETAASA:=0A=
+        t->address =3D t->static_address;=0A=
+        break;=0A=
+    case I3C_CCC_RSTDAA:=0A=
+        t->address =3D 0;=0A=
+        break;=0A=
+    case I3C_CCCD_SETNEWDA:=0A=
+        /* If this isn't the CCC byte, it's our new address. */=0A=
+        if (*num_sent =3D=3D 0) {=0A=
+            t->address =3D *data;=0A=
+            *num_sent =3D 1;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTTM:=0A=
+        /*=0A=
+         * If there are still more to look at, the next byte is the test m=
ode=0A=
+         * byte.=0A=
+         */=0A=
+        if (*num_sent !=3D num_to_send) {=0A=
+            /* Enter test mode if the byte is non-zero. Otherwise exit. */=
=0A=
+            t->in_test_mode =3D !!data[*num_sent];=0A=
+            ++*num_sent;=0A=
+        }=0A=
+        break;=0A=
+    /* Ignore other CCCs it's better to handle on a device-by-device basis=
. */=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
+    return tc->handle_ccc_write(t, data, num_to_send, num_sent);=0A=
+}=0A=
+=0A=
+int i3c_send_byte(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    /*=0A=
+     * Ignored, the caller can determine how many were sent based on if th=
is was=0A=
+     * ACKed/NACKed.=0A=
+     */=0A=
+    uint32_t num_sent;=0A=
+    return i3c_send(bus, &data, 1, &num_sent);=0A=
+}=0A=
+=0A=
+int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,=0A=
+             uint32_t *num_sent)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CTarget *t;=0A=
+    I3CNode *node;=0A=
+    int ret =3D 0;=0A=
+=0A=
+    /* If this message is a broadcast and no CCC has been found, grab it. =
*/=0A=
+    if (bus->broadcast && !bus->in_ccc) {=0A=
+        bus->ccc =3D *data;=0A=
+        bus->in_ccc =3D true;=0A=
+        /*=0A=
+         * We need to keep track if we're currently in ENTDAA.=0A=
+         * On any other CCC, the CCC is over on a RESTART or STOP, but ENT=
DAA=0A=
+         * is only over on a STOP.=0A=
+         */=0A=
+        if (bus->ccc =3D=3D I3C_CCC_ENTDAA) {=0A=
+            bus->in_entdaa =3D true;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    QLIST_FOREACH(node, &bus->current_devs, next) {=0A=
+        t =3D node->target;=0A=
+        tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+        if (bus->in_ccc) {=0A=
+            if (!tc->handle_ccc_write) {=0A=
+                ret =3D -1;=0A=
+                continue;=0A=
+            }=0A=
+            ret =3D i3c_target_handle_ccc_write(t, data, num_to_send, num_=
sent);=0A=
+            /* Targets should only NACK on a direct CCC. */=0A=
+            if (ret && !CCC_IS_DIRECT(bus->ccc)) {=0A=
+                ret =3D 0;=0A=
+            }=0A=
+        } else {=0A=
+            if (tc->send) {=0A=
+                ret =3D ret || tc->send(t, data, num_to_send, num_sent);=
=0A=
+            } else {=0A=
+                ret =3D -1;=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    trace_i3c_send(*num_sent, num_to_send, ret =3D=3D 0);=0A=
+=0A=
+    return ret ? -1 : 0;=0A=
+}=0A=
+=0A=
+static int i3c_target_handle_ccc_read(I3CTarget *t, uint8_t *data,=0A=
+                                      uint32_t num_to_read, uint32_t *num_=
read)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+    uint8_t read_count =3D 0;=0A=
+    uint64_t pid;=0A=
+=0A=
+    switch (t->curr_ccc) {=0A=
+    case I3C_CCC_ENTDAA:=0A=
+        if (t->in_test_mode) {=0A=
+            pid =3D TEST_MODE_PROVISIONED_ID;=0A=
+        } else {=0A=
+            pid =3D t->pid;=0A=
+        }=0A=
+        /* Return the 6-byte PID, followed by BCR then DCR. */=0A=
+        while (t->ccc_byte_offset < 6) {=0A=
+            if (read_count >=3D num_to_read) {=0A=
+                break;=0A=
+            }=0A=
+            data[read_count] =3D (pid >> (t->ccc_byte_offset * 8)) & 0xff;=
=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        if (read_count < num_to_read) {=0A=
+            data[read_count] =3D t->bcr;=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        if (read_count < num_to_read) {=0A=
+            data[read_count] =3D t->dcr;=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        *num_read =3D read_count;=0A=
+        break;=0A=
+    case I3C_CCCD_GETPID:=0A=
+        while (t->ccc_byte_offset < 6) {=0A=
+            if (read_count >=3D num_to_read) {=0A=
+                break;=0A=
+            }=0A=
+            data[read_count] =3D (t->pid >> (t->ccc_byte_offset * 8)) & 0x=
ff;=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        *num_read =3D read_count;=0A=
+        break;=0A=
+    case I3C_CCCD_GETBCR:=0A=
+        *data =3D t->bcr;=0A=
+        *num_read =3D 1;=0A=
+        break;=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        *data =3D t->dcr;=0A=
+        *num_read =3D 1;=0A=
+        break;=0A=
+    default:=0A=
+        /* Unhandled on the I3CTarget class level. */=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    return tc->handle_ccc_read(t, data, num_to_read, num_read);=0A=
+}=0A=
+=0A=
+int i3c_recv_byte(I3CBus *bus, uint8_t *data)=0A=
+{=0A=
+     /*=0A=
+      * Ignored, the caller can determine how many bytes were read based o=
n if=0A=
+      * this is ACKed/NACKed.=0A=
+      */=0A=
+    uint32_t num_read;=0A=
+    return i3c_recv(bus, data, 1, &num_read);=0A=
+}=0A=
+=0A=
+int i3c_recv(I3CBus *bus, uint8_t *data, uint32_t num_to_read,=0A=
+             uint32_t *num_read)=0A=
+{=0A=
+    int ret =3D 0;=0A=
+    I3CTargetClass *tc;=0A=
+    I3CTarget *t;=0A=
+=0A=
+    *data =3D 0xff;=0A=
+    if (!QLIST_EMPTY(&bus->current_devs)) {=0A=
+        tc =3D I3C_TARGET_GET_CLASS(QLIST_FIRST(&bus->current_devs)->targe=
t);=0A=
+        t =3D QLIST_FIRST(&bus->current_devs)->target;=0A=
+        if (bus->in_ccc) {=0A=
+            if (!tc->handle_ccc_read) {=0A=
+                return -1;=0A=
+            }=0A=
+            ret =3D i3c_target_handle_ccc_read(t, data, num_to_read, num_r=
ead);=0A=
+        } else {=0A=
+            if (tc->recv) {=0A=
+                /*=0A=
+                 * Targets cannot NACK on a direct transfer, so the data=
=0A=
+                 * is returned directly.=0A=
+                 */=0A=
+                *num_read =3D tc->recv(t, data, num_to_read);=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    trace_i3c_recv(*num_read, num_to_read, ret =3D=3D 0);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+void i3c_nack(I3CBus *bus)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CNode *node;=0A=
+=0A=
+    if (QLIST_EMPTY(&bus->current_devs)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    QLIST_FOREACH(node, &bus->current_devs, next) {=0A=
+        tc =3D I3C_TARGET_GET_CLASS(node->target);=0A=
+        if (tc->event) {=0A=
+            i3c_target_event(node->target, I3C_NACK);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+int i3c_target_send_ibi(I3CTarget *t, uint8_t addr, bool is_recv)=0A=
+{=0A=
+    I3CBus *bus =3D I3C_BUS(t->qdev.parent_bus);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(bus);=0A=
+    trace_i3c_target_send_ibi(addr, is_recv);=0A=
+    return bc->ibi_handle(bus, addr, is_recv);=0A=
+}=0A=
+=0A=
+int i3c_target_send_ibi_bytes(I3CTarget *t, uint8_t data)=0A=
+{=0A=
+    I3CBus *bus =3D I3C_BUS(t->qdev.parent_bus);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(bus);=0A=
+    trace_i3c_target_send_ibi_bytes(data);=0A=
+    return bc->ibi_recv(bus, data);=0A=
+}=0A=
+=0A=
+int i3c_target_ibi_finish(I3CTarget *t, uint8_t data)=0A=
+{=0A=
+    I3CBus *bus =3D I3C_BUS(t->qdev.parent_bus);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(bus);=0A=
+    trace_i3c_target_ibi_finish();=0A=
+    return bc->ibi_finish(bus);=0A=
+}=0A=
+=0A=
+static bool i3c_addr_is_rsvd(uint8_t addr)=0A=
+{=0A=
+    const bool is_rsvd[255] =3D {=0A=
+        [0x00] =3D true,=0A=
+        [0x01] =3D true,=0A=
+        [0x02] =3D true,=0A=
+        [0x3e] =3D true,=0A=
+        [0x5e] =3D true,=0A=
+        [0x6e] =3D true,=0A=
+        [0x76] =3D true,=0A=
+        [0x7a] =3D true,=0A=
+        [0x7c] =3D true,=0A=
+        [0x7e] =3D true,=0A=
+        [0x7f] =3D true,=0A=
+    };=0A=
+=0A=
+    return is_rsvd[addr];=0A=
+}=0A=
+=0A=
+I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,=0A=
+                          uint8_t bcr, uint64_t pid)=0A=
+{=0A=
+    DeviceState *dev;=0A=
+=0A=
+    dev =3D qdev_new(name);=0A=
+    qdev_prop_set_uint8(dev, "static-address", addr);=0A=
+    qdev_prop_set_uint8(dev, "dcr", dcr);=0A=
+    qdev_prop_set_uint8(dev, "bcr", bcr);=0A=
+    qdev_prop_set_uint64(dev, "pid", pid);=0A=
+=0A=
+    if (i3c_addr_is_rsvd(addr)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(dev));=
=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: I3C target created with reserv=
ed "=0A=
+                      "address 0x%.2x\n", path, addr);=0A=
+    }=0A=
+    return I3C_TARGET(dev);=0A=
+}=0A=
+=0A=
+bool i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error **err=
p)=0A=
+{=0A=
+    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);=0A=
+}=0A=
+=0A=
+I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name, uint8_t=
 addr,=0A=
+                                    uint8_t dcr, uint8_t bcr, uint64_t pid=
)=0A=
+{=0A=
+    I3CTarget *dev =3D i3c_target_new(name, addr, dcr, bcr, pid);=0A=
+    dev->address =3D 0;=0A=
+    i3c_target_realize_and_unref(dev, bus, &error_abort);=0A=
+=0A=
+    return dev;=0A=
+}=0A=
+=0A=
+/* Legacy I2C functions. */=0A=
+void legacy_i2c_nack(I3CBus *bus)=0A=
+{=0A=
+    trace_legacy_i2c_nack();=0A=
+    i2c_nack(bus->i2c_bus);=0A=
+}=0A=
+=0A=
+uint8_t legacy_i2c_recv(I3CBus *bus)=0A=
+{=0A=
+    uint8_t byte =3D i2c_recv(bus->i2c_bus);=0A=
+    trace_legacy_i2c_recv(byte);=0A=
+    return byte;=0A=
+}=0A=
+=0A=
+int legacy_i2c_send(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    trace_legacy_i2c_send(data);=0A=
+    return i2c_send(bus->i2c_bus, data);=0A=
+}=0A=
+=0A=
+int legacy_i2c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv)=
=0A=
+{=0A=
+    trace_legacy_i2c_start_transfer(address, is_recv);=0A=
+    return i2c_start_transfer(bus->i2c_bus, address, is_recv);=0A=
+}=0A=
+=0A=
+int legacy_i2c_start_recv(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_legacy_i2c_start_transfer(address, true);=0A=
+    return i2c_start_transfer(bus->i2c_bus, address, /*is_recv=3D*/true);=
=0A=
+}=0A=
+=0A=
+int legacy_i2c_start_send(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_legacy_i2c_start_transfer(address, false);=0A=
+    return i2c_start_transfer(bus->i2c_bus, address, /*is_recv=3D*/false);=
=0A=
+}=0A=
+=0A=
+void legacy_i2c_end_transfer(I3CBus *bus)=0A=
+{=0A=
+    trace_legacy_i2c_end_transfer();=0A=
+    i2c_end_transfer(bus->i2c_bus);=0A=
+}=0A=
+=0A=
+I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,=
=0A=
+                                          uint8_t addr)=0A=
+{=0A=
+    I2CSlave *dev =3D i2c_slave_new(name, addr);=0A=
+=0A=
+    i2c_slave_realize_and_unref(dev, bus->i2c_bus, &error_abort);=0A=
+    return dev;=0A=
+}=0A=
+=0A=
+static void i3c_target_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *k =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *sc =3D I3C_TARGET_CLASS(klass);=0A=
+    set_bit(DEVICE_CATEGORY_MISC, k->categories);=0A=
+    k->bus_type =3D TYPE_I3C_BUS;=0A=
+    device_class_set_props(k, i3c_props);=0A=
+    sc->target_match =3D i3c_target_match;=0A=
+}=0A=
+=0A=
+static const TypeInfo i3c_target_type_info =3D {=0A=
+    .name =3D TYPE_I3C_TARGET,=0A=
+    .parent =3D TYPE_DEVICE,=0A=
+    .instance_size =3D sizeof(I3CTarget),=0A=
+    .abstract =3D true,=0A=
+    .class_size =3D sizeof(I3CTargetClass),=0A=
+    .class_init =3D i3c_target_class_init,=0A=
+};=0A=
+=0A=
+static void i3c_register_types(void)=0A=
+{=0A=
+    type_register_static(&i3c_bus_info);=0A=
+    type_register_static(&i3c_target_type_info);=0A=
+}=0A=
+=0A=
+type_init(i3c_register_types)=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index ebf20325cb..fb127613fe 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -1,3 +1,4 @@=0A=
 i3c_ss =3D ss.source_set()=0A=
+i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 3ead84eb45..cdf7cb07f6 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -5,3 +5,19 @@ aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read:=
 offset 0x%" PRIx64 "=0A=
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
 aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+=0A=
+# core.c=0A=
+i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
+i3c_target_handle_ccc(uint8_t address, uint8_t ccc) "I3C target 0x%" PRIx8=
 " handling CCC 0x%" PRIx8=0A=
+i3c_target_send_ibi(uint8_t address, bool is_recv) "I3C target IBI address=
 0x%" PRIx8 " RnW=3D%d"=0A=
+i3c_target_send_ibi_bytes(uint8_t byte) "I3C target IBI byte 0x%" PRIx8=0A=
+i3c_target_ibi_finish(void) "I3C target IBI finish"=0A=
+i3c_start_transfer(uint8_t address, bool is_recv) "I3C START with address =
0x%" PRIx8 " is_recv=3D%d"=0A=
+i3c_end_transfer(void) "I3C transfer done"=0A=
+i3c_send(uint32_t num_sent, uint32_t num_to_send, bool ack) "I3C send %" P=
RId32 "/%" PRId32 " bytes, ack=3D%d"=0A=
+i3c_recv(uint32_t num_read, uint32_t num_to_read, bool ack) "I3C recv %" P=
RId32 "/%" PRId32 " bytes, ack=3D%d"=0A=
+legacy_i2c_nack(void) "Legacy I2C NACK"=0A=
+legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8=0A=
+legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
+legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
+legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
-- =0A=
2.43.0=0A=

