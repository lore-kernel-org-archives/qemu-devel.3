Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F107C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYzC-0000j3-PF; Fri, 21 Mar 2025 05:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYyv-0000hb-UD; Fri, 21 Mar 2025 05:48:02 -0400
Received: from mail-tyzapc01on2070b.outbound.protection.outlook.com
 ([2a01:111:f403:2011::70b]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYyk-0006IV-TQ; Fri, 21 Mar 2025 05:47:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyGnk9Rlg0nZBcI2KkcdBeTG/+uPyHdlokQt1tlheYwpUI8lfGUa2HnDPhUaqi6C4FUOqJycDlkTmDS3b+Q6Eb6hgdtr6erLc7E8wIPL082tZIGHIYUysAZtc2ElXfi9FLWHt5JViC2l2JSYROlQttMo3xZ6zx73gIMSNtLOypRoZpUYA28tOhsWyQYUAc0zxuYhDGcB7yK/5zD0rIPRa5qIjEqtM57ehi6ulWqXOr8NKEegSHXEl4NzRYwM5gVabWbnxnIIkkoNT/XLPOzAWcJS8Pkl0G5fEHFDJf3jzp3B8OpPc0vZz/l6ionNPE07isi+YP9RfDI7pn2kGVezXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJaXnTueBkHTjjFjJ9om7VXtBH+cRw9vjsELLkou0y8=;
 b=s3PwMQCnQCJDyV7f8tBt5wiWFM9sOh+VN1VcE973jnbweRlUykBY9iRZp3G5JOSdT/7Sf7lm7wf7OwWDXRGcv784I42B/QfZaOCMFWKgJtdYQoSW+opiqAQqHGCIBCn/x+BrO3ocxOwzbQgLMHO9TzCE8rIjDd0/nG8BZUqbJQqFBmLhp7+iZtS8KeWzaTHDNLzodxMD3zpfikeAwRO0IZFuLU5DnrlKyw6gu+nSLaxm21RUHVR7Tx6sCu7IetgJ2Wz4Gp57u6teFm8ECvXIBjA0X48gKHC/1hndlXJ64qtIvskxQSfpE3QnnL2LMmmW98zxKkc+oUtfQ2vR4HkcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJaXnTueBkHTjjFjJ9om7VXtBH+cRw9vjsELLkou0y8=;
 b=Fdb3ZYJdBh8cxq5lARTx+YlhMOPDcuiCMB+HHWgR09odw5QaW7OMEUnCtzBBXrbb42qlFgs2vEZA1RYdFmjnSV7LDV3eBDU/6paqTV1Ry7IflgKNjmTiGttMSGaqalCtvmHmq+2HfSSWCyyOfht1nGJg+2P9zRUxTMtyri+nFCsFei+Lsj5/ZoZN9CZpjftbpOqi2X68f06P2AkT6ZX+hx3aeJgzSEuBkJ4iDFW5TONuU6lWQB+GkPpmzRI7Inq0mFPX3Lz/k9Yc0q7qsu8JUfNFi6LW7l3HV+ms+isHenaJYINRvFOW8bbCZ3faWsrNCbrbLufdp+5n95BUgWxdVw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5501.apcprd06.prod.outlook.com (2603:1096:101:a1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Fri, 21 Mar 2025 09:47:43 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 09:47:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 02/22] hw/misc/aspeed_hace: Fix buffer overflow in
 has_padding function
Thread-Topic: [PATCH v1 02/22] hw/misc/aspeed_hace: Fix buffer overflow in
 has_padding function
Thread-Index: AQHbmkNUcYpcCxrAtE+S0QJ0F2035rN9VqXw
Date: Fri, 21 Mar 2025 09:47:42 +0000
Message-ID: <SI2PR06MB5041FEAF9E22928FC807B639FCDB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-3-jamin_lin@aspeedtech.com>
In-Reply-To: <20250321092623.2097234-3-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5501:EE_
x-ms-office365-filtering-correlation-id: 96d57072-20ab-4d98-2e96-08dd685d6d28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gVOMjh4GXvoYxOoUKoqnbeiI4hpiTPDgvuGZmL5HiENf9nk3nU9BjHKJ2a?=
 =?iso-8859-1?Q?Mcu4yo8fn2BylKr322WOc6iTRH1ajXrg1MRnQ9tKDDuygRQQq+mnaBcV5f?=
 =?iso-8859-1?Q?hykeR6Dwh8gJoFpJwRtWrMT23IWKn2559pA+FDcxtuGIgXe+K/Fnv4r3fX?=
 =?iso-8859-1?Q?DSE3Hc9p+m/IH9EP7nx2yRmwd1osTPWwsj1Z+cMV39YLhCzJa7pVR3NSW1?=
 =?iso-8859-1?Q?VUzHG29wnIYL4PkjIXrnWmlUpTf/7IwlPIeMFCP3JlHXSWvx9fEU3e37AG?=
 =?iso-8859-1?Q?sOgud5lsdJbsmHb6be04ij1KYZRVQcBBCQsTXZhkbhFEuGJTQz+/ii30KK?=
 =?iso-8859-1?Q?wGDUFxBYUsOEhGKKJECAYtUWy4bbomrxLab0p0aQPRf/U3nsEOs9D+IycI?=
 =?iso-8859-1?Q?l2D6I7QRhCDu9Y6ZbgiaGxhPdU/Ki3PsmuRL1IELLf0PmGjqh6fxAN9NDE?=
 =?iso-8859-1?Q?RYLWdeMeo0hqtpqBr1ZNY1ic3Y1VSvT3NGWEkoMvKMJ8jvEj4EWWMqP/nx?=
 =?iso-8859-1?Q?ZZN7vHXDGnk+TEeH5RxtchvnTlTlH2GsQkIYVs6eRcay2noq+R2giERelF?=
 =?iso-8859-1?Q?tUHAAi6I5b1ohrH93lTCXmQUjdt1rXuzOt0LZYpXRl0NkcJGESv23m2Dra?=
 =?iso-8859-1?Q?8hS3auTKhBjdmv2V58n6+ftMy10+5CuhRen75BqRR1WvlzhnI7hzWnNDPd?=
 =?iso-8859-1?Q?dh0ifTfK4HwKVP7/6NxSNV9bJS/OeIJv3gc4sowAihFlxY1rhZLWjSDI+w?=
 =?iso-8859-1?Q?e4yEIL51qBjjJIvvhLc0Rd/Eg2rUrvg1cS4xLepRvhxVTk2Y8Ej7kUuw0e?=
 =?iso-8859-1?Q?SiA9F7qrzb68DfbDXuZCb9wMW+xjCXw9sKQoV9s79LwWsh1+AciGs++U6R?=
 =?iso-8859-1?Q?wL/rRlH80iODq9hibCO9ESiSkELOYz/1iGaQ6KTy1PHtX0JHPFsFxb0zDU?=
 =?iso-8859-1?Q?YT447Ln2BQWg739pnn2wzeTdUqqZ1oW8IWJp/e5DlT0w6ohKFX14siT7n0?=
 =?iso-8859-1?Q?qbygYVCJ/iqTatSQzHQP0ZYQ4KVbbXSZ1dfUPlL/Oyd/lVo0Ez5UglJVbw?=
 =?iso-8859-1?Q?Kc7w2ORWFncm9KxfWDZk5cEjmxUxAFoetieq1bwqi6fMKGMWnoc31FaZAw?=
 =?iso-8859-1?Q?TLBh0ClGl3eVXpmLqhaEfu+LJHQ15uut4Uk5EB4yhEyjjOs/vwSPCgxJjS?=
 =?iso-8859-1?Q?4CMR0T6EZ1YDd/FQXqGD2zRVOig4VhlHvLv3rSvW/eAXsO6Y3xH9xMdhLD?=
 =?iso-8859-1?Q?Fo33h0ZnB1q4uxRzcSsdl6ItIyTddKf2M+DBBNihSfjyRjjV3sHmhvezJP?=
 =?iso-8859-1?Q?ZMN+dBsWFivgheL9+4q+oyP143/CTgGa6A0NUvyB7Da51/8ueeswXaKFWj?=
 =?iso-8859-1?Q?ZznCWM5Rtnd5fqzzBZ1V3A9/HP37JHRpeB8yKeQjoMPC86LCbWxcNbDrlE?=
 =?iso-8859-1?Q?FSOIjEFoDnW9XShC16C1RhSM4Ab77JKtPCyHy/t92LtgYWwJm1vhVZhZFR?=
 =?iso-8859-1?Q?9s3RiTMD5NRv7LOcfKBHK+GcuXZ5oypaQb4t1sKoYGQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c41Jd00/L8jtbCbXTERLncs+t2fUMmwyRqfb0aQB+9G4biv35uqsdmqv2F?=
 =?iso-8859-1?Q?32a41qVGZXdXrZeOgDe6CCm2sGVH66vMUmCLjFx3JvfdV1s6vdeGUsU159?=
 =?iso-8859-1?Q?lgYRmeQJTYQNItx6uABWAjtaGUa0WMpGP2HtQzTxQaRLREWc9e+6ieRtp8?=
 =?iso-8859-1?Q?Fmm2Ckx9y8H7U5PZpfTagxEtHP3heNUHFEHWS/LYuSHZNFkHhvqfK5I9xr?=
 =?iso-8859-1?Q?4xpjMJxZI0mrgHXPLlC+KMpDA/RVLjB4K/yR1k87aSMEqUUmDEHtDlDyu5?=
 =?iso-8859-1?Q?ounqHfm3vjdXG31mx4CV6lzT7u2DusUdc4IX4b6b0lSGoWZO3ESrb3mKho?=
 =?iso-8859-1?Q?OfLrGpqZPN7Hm/q8BDdFtvDX66fFDAo63tDqeGIzlzhWIj63nqE+Oy68tA?=
 =?iso-8859-1?Q?5ANsE8CDw+NcpSq4pzqTSPVfRPIglXgkjTeih6NlC4nLHkTTFnvFngDVzR?=
 =?iso-8859-1?Q?v4eUTHoDNF08vS3d6vYWDtpbgNjpJee6g5qI4Vuw0vea4ifniJ0sjUomzJ?=
 =?iso-8859-1?Q?4KbvjAXp4z6v7Nx9kh9yNDOMdbw6qr+2AgGcSLeUiZeo1ly3Z9Ut5SYtcE?=
 =?iso-8859-1?Q?5qTwT5iiJdBrJcr3E6BAcHew+dJ0zCV5O+yPIaj7x8QEMMsPzJCBUmf4Mn?=
 =?iso-8859-1?Q?BlIenfqcWcE1tj//+RuEKBE4oZpD+wTNk9X2p7/UCkgVCwNCc0hXx2K4Tx?=
 =?iso-8859-1?Q?Kh6z3AnG3q9R02YQrShUNAGUmQ5P/AQAnQdwxDKZZM5rQ94phnhTPKyx9A?=
 =?iso-8859-1?Q?b5sTHtYjwH1JY61U/5N4jHdlt8HYStDlwr/fQMq6XEbhpnPh/b4ihGB4M2?=
 =?iso-8859-1?Q?LUhGufOeFQBvUH8FNfBKugP+4CQQrZN1yEybOEmlx9JmeiKXVHq07pHZ6l?=
 =?iso-8859-1?Q?toBOrqCmA0ZcQw/4N3PMPfs+ZrvBEJQSywZKmEymrtFvmcMwFm2+NyZmGe?=
 =?iso-8859-1?Q?O8A5bDvBYLWqQcq+f+Zm2YdEodTH4zPQ0ensuiJsSPLQr/caa1sVpBB3Oo?=
 =?iso-8859-1?Q?17lPIlt4/BQk3SCfyVLTWZrw18pMYNlm1M0MIPsNy8za9/STZf5knmYHoX?=
 =?iso-8859-1?Q?LS6tyisKRyYjkhRB2SZnC1smbgQSt5+nMIYuZSRSQTqVaIbhtZ1GMjP5Xs?=
 =?iso-8859-1?Q?wJeEqc3fBsMZfgDupGDKLIfjEDlQhd5kbhM3Bbvr0DsfvYS2bgqllCtGrm?=
 =?iso-8859-1?Q?IJYD7aKrA56qWABp/oYJXu7hOzw6aU/bjtD/hLsg4XbSUk7gBrnHSjQ8iL?=
 =?iso-8859-1?Q?C25k1om0vbwhNjAAMXYmAt0BhuDkuzsC76CDJqvL4OK0906NDntivqw060?=
 =?iso-8859-1?Q?Ag1EgjYYpsAT81T+MvqmLG4qk4kBilCDQwiN2p8Y+A0ANS08dpZIFlawM6?=
 =?iso-8859-1?Q?QtjXZvBlzAXyVDQalco5uFj3bjrzMOvue/k+xaWonaYYxE3wKN+Hkk+A7Z?=
 =?iso-8859-1?Q?7P4zdNEr7LhouvbOAmqcIZPTn0Yr5CxDQCCZYiOYOJf16ui8mKKeC+uP1R?=
 =?iso-8859-1?Q?8zJSrbHE5VfkPDaYFl4IZwwyCwHqUoj/p3C4AgNzVzh4huxiIkMKZJLtUp?=
 =?iso-8859-1?Q?RKgqWDdGAl+UxHDy7yvTRlg2GtDfi4z0cXq/sDlh1FkFZ6rSe5pizxv4Uy?=
 =?iso-8859-1?Q?/2LrhaKrlzlDVBWQuWswt4gVT4B02AswI/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d57072-20ab-4d98-2e96-08dd685d6d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:47:42.8499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdhhrvKrDaTSVjiWC31HAjlCN1StQ2uZ6a7FZqACWc/4pmN9qjd2MVPS/ePbemeILVe1ZG6yZZF8J0PbhjNcmG/IkHgbITHGOyPif0FpGSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5501
Received-SPF: pass client-ip=2a01:111:f403:2011::70b;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

Hi Cedric,

> Subject: [PATCH v1 02/22] hw/misc/aspeed_hace: Fix buffer overflow in
> has_padding function
>=20
> The maximum padding size is either 64 or 128 bytes and should always be
> smaller than "req_len". If "padding_size" exceeds "req_len", then "req_le=
n -
> padding_size" underflows due to "uint32_t" data type, leading to a large
> incorrect value (e.g., `0xFFXXXXXX`). This causes an out-of-bounds memory
> access, potentially leading to a buffer overflow.
>=20
> Added a check to ensure "padding_size" does not exceed "req_len" before
> computing "pad_offset". This prevents "req_len - padding_size" from
> underflowing and avoids accessing invalid memory.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> 8e7e8113a5..d8b5f048bb 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -128,6 +128,11 @@ static bool has_padding(AspeedHACEState *s, struct
> iovec *iov,
>      if (*total_msg_len <=3D s->total_req_len) {
>          uint32_t padding_size =3D s->total_req_len - *total_msg_len;
>          uint8_t *padding =3D iov->iov_base;
> +
> +        if (padding_size > req_len) {
> +            return false;
> +        }
> +
>          *pad_offset =3D req_len - padding_size;
>          if (padding[*pad_offset] =3D=3D 0x80) {
>              return true;
> --
> 2.43.0

Fixes: 5cd7d8564a8b563da724b9e6264c967f0a091afa ("aspeed/hace: Support AST2=
600 HACE ")

