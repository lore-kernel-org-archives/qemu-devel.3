Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00760C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuQ-0006GG-77; Sat, 28 Jun 2025 14:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuN-0006F5-Ae
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:11 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuL-0004Ao-GT
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133849; x=1782669849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u86Gi6VFztQTKEeTc2ie/yWhk8zfNpL6dJxs7YmdiA8=;
 b=fBzEiaGN5bcOJG2UI9oTqbYGPQlAQQnQ1VNyIkp9SRIOgq+nldFGMsRP
 h4ofIctLY3sVjdhMfv74hW9UjOlU5ohBlgVgZLDkFZ+fDWA67blC3eLD6
 wUxNTNSkvS7oUDP1+vnRQx+gTvV4TJevXMXkelGC4T5BEqqr58BArBRbo
 vwc5uAwMoqca18JZX3/ks8tgeXqTKYd/zgEiCXS7LFvqMduYeVbNPiktE
 NRgc4Zu4sBCkd0VEBmETQGecym2EZCZtI/t9hH2lceHgmXJVkFsSPjT4U
 xRqLFwXgDoYFXNxpU55WUxmyfjLB2LdxC4EmKm+sEvVpb13kB9jIZUJks A==;
X-CSE-ConnectionGUID: uVR/Wa4RTlWBp4enDAc/yQ==
X-CSE-MsgGUID: sXkWeJxgTFW5KQW+U90GZQ==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39505874"
X-MGA-submission: =?us-ascii?q?MDE1R8LMa7LCiIpDVX7JU6NXUbfSKDTgj0a4z3?=
 =?us-ascii?q?92nFMGmEuMiVNmKFQ7eOhnDqLHm01C97LQ3JZYWlUI1K4oapY7YIWhwS?=
 =?us-ascii?q?WgVwJQGJ3xB0qHb+JG7FpU6qczfokFCjXM1xBrlcq9MIrqmr7ZW2Xu5R?=
 =?us-ascii?q?xwVYpgnlLLL2Hc5ehAnbZkLw=3D=3D?=
Received: from mail-francesouthazon11011054.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.54])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3n6VmX2baRdGH88tmI13wdoCK84YkYtHQDdDO3GTwo2uaX3kcml895W7YSb7e+ljjd8Qc/VlCGDx7MTmWMSaKHYbZ187nolJ+PbXyoPqemxO4HfEO2NqmtnkbzTIa/2oB0cjXgAv/qv1wKWWrSG5/X8zFOhbjYKKHi6qBxx/uRkhlaZUTWY6hKOCFz0HViUBxPEUHTQnhA+eTK7NUFHhQV1e9+hV30pBv1xe4pKFWntDeT2g0cx0VxtIRE+m6gzkvvbSgN44Lhr4Potu9b/E5WcuycArFMmCRC1q/SYdOhfuxtddPMYu40OAzx3x/VZtlZdi/Z6vpqS2UedLOfw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg+QECOFlm77ioetKAhH8y/zq/VW7iN6t6E27Z4IOl8=;
 b=YdZgxN0FIz+ENg80V2wkIK0HCp8qrEP7dNhkFPnFkX3Cmg/KS21pfGk1FZh1ZrOzJOSpLrRKYZVsMXSLKk0AServ45PwMFerVk14JvZP6TlBHndcuMYoRF6t1R4Va87tZWxdpkYK8RdQxmMf7bVu3AN40e9aeWum6mw11xX+SZINyM5gvP5ZCW76H7jV2fMGxczdVkhT6S+AYFJYRDANvPgTzyi/IchstIL+MoslNlVxWXiZiPEerlOKqcobGXs/muDrM1GAi57Ovn7juuMAuuUTA+tt1e0sYFAn1ITBIcC1uheXh0+QaHITPGyYnX6lkBOTjopOANxtsXf7C7mxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg+QECOFlm77ioetKAhH8y/zq/VW7iN6t6E27Z4IOl8=;
 b=RrE0hxs6Kjb3iYuecRIz6SFF3U1tV4/u+mQMqGNEpy5ei6JLIMcZUWygmbQ5sjIY+GqT1B3URHs2E6UK+p//dnOmdFVXfmPjdRkEI4gMdnBkYqNcxzNIow2QJ3E6WzqUd2jfJPgOB1+48nJqoG8GNsNQNBzgVOAJgokqOebHqGZBiNZK5p0n9LxUUdKx+uaOeqNNKpzClawarBkCXfQQYXQGcGNUh/PDkzmFXOhvuC+W0zQVesLnB1IANmUbc1t2+aXztg+B7+eDByqLq0fYdOeJR85X4hvJLquqd3Iu/QY5AVDGXBO3dvHvZ3dHl653I/XIfjCrsA1m+pNYuAlVlw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 06/10] intel_iommu: Implement vtd_get_iotlb_info from
 PCIIOMMUOps
Thread-Topic: [PATCH 06/10] intel_iommu: Implement vtd_get_iotlb_info from
 PCIIOMMUOps
Thread-Index: AQHb6FcJsOvGYcyirEWU0/6eoaBIYg==
Date: Sat, 28 Jun 2025 18:04:05 +0000
Message-ID: <20250628180226.133285-7-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: cda21c4e-7eb2-4da2-3c97-08ddb66e2bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/SezEt5raq81y22df/5uIuUNOM61kvl5l2iifYftrxf2TZWwfRLdctlTvP?=
 =?iso-8859-1?Q?J4bGADKnvMfYw28fIaZqHo6pjoHqEKSTRm0DggYzjDB3wf/ZiMl5yzZ0Hj?=
 =?iso-8859-1?Q?W6vd3UG7OqetkGAEmoQ6TTrq6F5iEm4/VSfkpOcOnFyBOxayah9rHnBtOq?=
 =?iso-8859-1?Q?Uwytid+Q9xTMRwqeFVHMBfqVefoWmuxQ9TvM0GH5JvtdMpyrRcbN9Pm0fW?=
 =?iso-8859-1?Q?p+WNSFs7GZBoWzckv9hQZjhBYws/JwEBu2hLgQLrass7/8AFDNUiypVp6h?=
 =?iso-8859-1?Q?3pH7D1/gi4Zawaof0I/AvAghdIoFz7AEC8AmEwsdSuMmaxPbA/TAUMlC0/?=
 =?iso-8859-1?Q?y6uyaYhsB3LxHDYih6H+zaQDnO8ojEAwb9H5L8djJRhiIj56IIOI4FHnY5?=
 =?iso-8859-1?Q?nBhmBGA5OziJf209WvJWG2xvLVmEonkF4GiJ4XuABJc/KoPjOzIkieZPGj?=
 =?iso-8859-1?Q?EC5l3k2JYqkRq0gIu6VRtWA9HlXo8nYw9tfbl/PaN6PgnLvLjgP68tvqfP?=
 =?iso-8859-1?Q?Fh7b3+VNCWatUvdLCHFqFA2mTZMnjQ1CE7rCV1z08gX1w++ZW0qDsoE1+p?=
 =?iso-8859-1?Q?1b2LF1wq0yfF7xomB3zPoPqbGzxoC95J/NWcRshAg2EquZ4xaiNpZqVOjY?=
 =?iso-8859-1?Q?vsmHQB5cmeDN/QgmStZ3DREcYaopVSTRkZD0NFoWV6anJ8gb0i8N5jTE2L?=
 =?iso-8859-1?Q?YEkTqTxUdEwvr44al/04HE/HapKTy7mOfhyqlugL99MDpzNJ1v+tpUxrM7?=
 =?iso-8859-1?Q?5tM5SbU/3aSNob8iKx9kbFplpJvVVp/2UNIbOQBGDwf3VSszgi2ts6JNbv?=
 =?iso-8859-1?Q?BsWXFj87Rq44BFj4XrNC023clkG96LEn1bf1qKb7CdZJhHyXIomCw7e8ej?=
 =?iso-8859-1?Q?gYmODleUIz4gWnyP/oBz3G5fcu+3jjF46frMjs7HOIEsIsY0XsSCRas23W?=
 =?iso-8859-1?Q?RVAbEfxiRhpl/n/LlaDP8OuMaXd0d/spqa/lhkwkrttpJ/XYtxgE35nQpv?=
 =?iso-8859-1?Q?7/02XSlw7YvJyXKXyhlJKhNNVgZdqCAU1A5fFMYbkNMvPb31LaLqSBqJRk?=
 =?iso-8859-1?Q?AoU9Ys/Re/t94tHE9s/0SywpBL7VUGSW3AtN/Tq+P8FrdL3l41jXvhUI1I?=
 =?iso-8859-1?Q?h7bLMe+EI+h4BMQtzIV0/Yw4L8Y/NXTs56i4ZlYIPxsove6aTFDHLoBop9?=
 =?iso-8859-1?Q?LLcqJbxAPJHDmk7NtEmXhmj4rKKw6XWU30YzHzQu0sdMfkHbRQ+702/tz/?=
 =?iso-8859-1?Q?CFLBIyKMvgMD/MM08I846MBm0/JlFSkMe3P+0drmT9LMW9cePeY8M1BgpT?=
 =?iso-8859-1?Q?y0HB61Q866um6NlZaIYy9+eBEA5XTXMC2eI1jlgpDiWtVOw9ENW3glw5Ox?=
 =?iso-8859-1?Q?Z29FRi+MiTDR5Tlzo8k3xRLxl7ED7VlSVrjT1VD/5drMZ8I4+u/VZ/GfhQ?=
 =?iso-8859-1?Q?KzIvlMUsfFfCoT6/ebFlMIUX8vKTyYxbAZGzGzJj0atAIxLl7CEAUermNY?=
 =?iso-8859-1?Q?EtNFz5oYnZbYm6E+IxGWJ6xUl9K3nbiNDQWTgVCGvlDA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GPrh8or+Qpni78JPuVeR9B/rHH7Ke9euXNgKX+2DYd14NM2ov4Vv/xHk+L?=
 =?iso-8859-1?Q?rXG1T6nJW804RjRy6liBSTrayge0oukWju+kVtQG0csOOAWIvp8kkyLKDC?=
 =?iso-8859-1?Q?HIWFiWXESORjA0mlBJgp6UpBl7obsrEik8zBie4SC1Eri3uHGIGYpsgT3W?=
 =?iso-8859-1?Q?xGKmwBO9+WnJTv1tYLoxxuRT/DNrmQXyAyEqHXPVATMRix8hLW+O6OYukv?=
 =?iso-8859-1?Q?SyXSRYku4en5lsBAGibinRDVeXm1SYBDW0ucjunXbszl+S90WE/fZJw+cR?=
 =?iso-8859-1?Q?zEXyKnOQwYjOseKOP2Ywe+DINelvwQkJFEDF6RRt4+RuJGfw0Rfb2EcBdF?=
 =?iso-8859-1?Q?mR7vc4uctVyXO5Y9xje3EcTNXBvd0isMwmxXVy4BLAn2ntTIkSNhBhh9G7?=
 =?iso-8859-1?Q?7v83dqBxqpmRIewLTDh4uRFvSCQgwqdyHKiO6T23FGljR5NMZ8Ls5cXPcd?=
 =?iso-8859-1?Q?C1BcRn+AVnsSu6J9h00XfCDSUuvizA0b3ppGCY5PstcEROQHTgg9uzp3X3?=
 =?iso-8859-1?Q?sHsLECQ8BkEW6DyEWEKsmwZ6eg5zWxYO5BDJPUPZpnT9iecCxfZpdPdCCE?=
 =?iso-8859-1?Q?YIBLQFI5vr1YZqaXbR/+8uQMohnT+DeYrKTiEoAU+JFDMuL9NdHrpNax8m?=
 =?iso-8859-1?Q?0qf/rJJ35c12pdHP3XvuucBruywfmk6f5LtAzNvIqerEnJKvtVpmY+MEKh?=
 =?iso-8859-1?Q?MbudIX/5jhCWPa0NuoH6961vkGoMbFN6JApvPFUQRbJ8qpNvKwbylFgdjl?=
 =?iso-8859-1?Q?Y7l2XIe4PThPfjqtGHOvXDu7ZFW+gXFG65AwWtWthlRxRDn0oNbguzzj7/?=
 =?iso-8859-1?Q?+so3HF8ozJwtyFybk9ktZTlDESmD4SWO1MTkGX+BDrkfAEV8PyRx8r/WES?=
 =?iso-8859-1?Q?VWMOF5CLL14kmkuzqIGDnuwFSgPAnAJSqBY6vCNcFvrXLTb5ai1pmTV0CH?=
 =?iso-8859-1?Q?kXDGWHlQHAhr4A5c6huU90y0aSjzXVe84ZzeKpiz4BquN1DvNOzNf6C8OE?=
 =?iso-8859-1?Q?Pc+dqbasSFYRVjnDMqHD0lzEupjiZfWyQo0K6NzbNyUjHjrapGMM8kL1rq?=
 =?iso-8859-1?Q?QfTTb+zShSXSlSdOWmzM7uAGyX8J/LQR5jziUrcHezerHEolDcESZlJZhz?=
 =?iso-8859-1?Q?lCKQtJxe+pJYye2M4DX6OH0pl4fZQstNp3dZm1dzkuHGwC7nODfEqAZCTg?=
 =?iso-8859-1?Q?5ExDRNyeUSL/cTaFAFQ58wRKD3Q/w6WQDsWkkOG3AIs8nOS3s8jaQMRHWO?=
 =?iso-8859-1?Q?yRPwPWUo759L/boPnHZcJxPj9Vc9AduRXOl8d/cymVqAdNzVSHOgh8tUCP?=
 =?iso-8859-1?Q?bZkCGJM741CSE1N3vONATWs3QvO8eR8YmRHItcUbRqfwjT32FcOnBkOfU4?=
 =?iso-8859-1?Q?8d5MFItK4xwWVOgqsFCpf85f3P987INIcnQUUNQ7GHqMDnS38OfaFq32iR?=
 =?iso-8859-1?Q?5qlO53Mb56fKSlh+wQE4dtryIG8CoQILNsE8DBwhzao1dPl34rtg5ThnTO?=
 =?iso-8859-1?Q?4bopEFekf+gGE6cPfazZzXjCSSBpOLDw7dA2VnrxIyi5KsnTIF40Zb9HOH?=
 =?iso-8859-1?Q?1pOepxASTLON2K0huuO76trIhHNxfokf1bjY4DHCplRgxoKL0x55OhOm/d?=
 =?iso-8859-1?Q?E6UH2IGoOaO4VDW0swl3gLHFoPF19D25k4CJ7Nre9EhjDr7s1vYYXo+F9V?=
 =?iso-8859-1?Q?FZQe5mzohpPmqv80fVI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda21c4e-7eb2-4da2-3c97-08ddb66e2bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:05.2217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGQmzLTjHPzoa54RY91JDwCQrwyFej/gFj47j4eG1KcohYYN9Be0HtuG5CBFvtTzX11XXGqVb8pzLBj5mbqhE81fhFrQF3YBeyRWYhVds6OKdub1OXQgrUmEHkmjsedT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 71497f1936..affa7768e6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4733,10 +4733,20 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus=
, void *opaque, int devfn)
     return &vtd_as->as;
 }
=20
+static void vtd_get_iotlb_info(void *opaque, uint8_t *addr_width,
+                               uint32_t *min_page_size)
+{
+    IntelIOMMUState *s =3D opaque;
+
+    *addr_width =3D s->aw_bits;
+    *min_page_size =3D VTD_PAGE_SIZE;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
     .set_iommu_device =3D vtd_dev_set_iommu_device,
     .unset_iommu_device =3D vtd_dev_unset_iommu_device,
+    .get_iotlb_info =3D vtd_get_iotlb_info,
 };
=20
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
--=20
2.49.0

