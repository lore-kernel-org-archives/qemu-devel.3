Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA44C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXX-0004Us-9E; Thu, 27 Feb 2025 05:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXU-0004OJ-Sp
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:49 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXS-0005or-Sq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653687; x=1772189687;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gmC1JlYF6t5JaGSPliSMZn93aRINn/nUgSe42q/FwD0=;
 b=LFN1ffssY82oO8JiWrI5/1Tr14PkF4mjyn+TiJP+ROGk/FMMVDByyfFR
 390sTJ78R05Kj/dM5NWLFAhTZjn+AxB86BXEJrmc5m10/VP9E5SNVVF/P
 x6BYQ5QgDmordrp58Y6+hodm+UOZNEFuY3zEWLLriyuNtCOxKTksCsM5U
 hr+Wcm/d7m6Rr1LkvCXTiUezQgF/FcKRqWzUO7TMjTsb2T4QqtG15UrbT
 /vb/sdlcX9VFvCSXEQ33IHpqKlB81LDE99g47JH28G3bY3KukrDVPLWGK
 rFJPPrzKFYvS54ugZmpQdtDqDogGtNXqES1D5TUJQNevCrnDFoEFixS9v A==;
X-CSE-ConnectionGUID: ujDtuLv5S+e82kOQz7nFRA==
X-CSE-MsgGUID: RZfXyC+9SkesebpOyA3czg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="31822960"
X-MGA-submission: =?us-ascii?q?MDHh/2yR55RgxmtPk1nPqZrn8rwRQTSXhmIQhz?=
 =?us-ascii?q?TLlgbnfAUwjFOg+3T16wUoOigFz/sJUTtu41JMVhUQxpNY2QylegSdER?=
 =?us-ascii?q?slvfZSt6b0kfeNOxz0Sw5++mPGKfzoKIo1kBS9HHNzUwepPC/tLIHl41?=
 =?us-ascii?q?ojgjvev4k7NZyO4I2qb+pFkg=3D=3D?=
Received: from mail-db5eur02lp2106.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.106])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:43 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFzQs7rZw62T0C60Dr+LsHNYQODqRMCdG+SjXwpibteK71/HjOX1JotDEi81/z43M/lmUn8Q5EnyLMtbL0M8OOGYF0WhwP2b3kPW6jOX6nA9Y2Kr2XP5nqDzc5CEwXsJGXGQs6KrhGxmf0+WfGJCokmt9sLISt+FLiEPaqZmFlzXYM6OviB5PWo/tdIgNE/F5OEifn0QIw6+KAdOiP2Hjlh7WTbDDSS12QBR053ylKbhmBUCaKRxRKWo9pOUBiOyq1/Ag3gWg5wBXiuyWCTE7gzErDK1evXbtKXH2LCjdgKf7Aeg3N36OJso/2gVkcheB3OK5Z3ApQJQYRbmhzdm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC5gvyzHnNALcmu6oa0dIRG6EFpxKL5QQ5nZEiae0zI=;
 b=iaK6ThikcK87AoT6MDzxHqicIXx7e+BNMvt0O37yKkoV27Y1AeUVbLnbFglMrxfuQlkqBm+e9cogb7Js2nM7/HxOhUJeFF0L5YDonVws/n9RwAYazgiS04CiislfS242tr2rEiq/CzZ+X0b6M/AnjPw0Ep7idA11v0qto+Ga/YQ63I/6uoEiStsSYK1pO0ToyyAQ5XrI9JM8Z0tslI86gdroIFr3C9zmtlJ5rtdG9F+OpDLFU7j9hpvJGLne+uNJ2Dh+bNiRHTuEF7HQdQzFfPRoSrKI565AsQfoCOYVs75Bb/C3FvCPKZNx7Hl1ZMiZx+noWK4G2BDn+m08ZZawzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC5gvyzHnNALcmu6oa0dIRG6EFpxKL5QQ5nZEiae0zI=;
 b=RRiurOaaknXkVxSdb3gqwmWFr4NODKxD9KnUQLkLcQ5aoj5YAEeFifBxumjx5AXm/ZYYIQBRPdz4Fz0Gn3NpaLv6Tf1HPI6V88ZiTojvsN76MoWUMpoXlVgd0yYWB3Oyi5XBA02ms7ABkxpn9jCFb+qcHuojjPNFDviOIR40VltvhCkPtUDHTVQP5cnkxRXCRTFUb6RHuwIDDLfd+oqx7WoKxDe9ktfoaUxgOvA4GxTutZwoZ2prCuNYgV/CGr8Zn0tbHwAIylUl3mPjUZYS5Y47iaH5DSiJg7eBxoAfpKHjXirDLZ3beb/SMuPxEIwsz7eN+Oor3lF4u3nMe1V60w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9421.eurprd07.prod.outlook.com (2603:10a6:800:1c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 05/19] pcie: Add helper to declare PASID capability for a
 pcie device
Thread-Topic: [PATCH v4 05/19] pcie: Add helper to declare PASID capability
 for a pcie device
Thread-Index: AQHbiQYApMsalteVY0KUnADHFo/SOw==
Date: Thu, 27 Feb 2025 10:54:41 +0000
Message-ID: <20250227105339.388598-6-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9421:EE_
x-ms-office365-filtering-correlation-id: 19beba93-488a-43d6-1279-08dd571d2339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?s0OeSESZ5j9uz7IP+Joc31/1IgPmRkkvVndADfFtWnskV3jiXTXj5l5Ot1?=
 =?iso-8859-1?Q?qW3XZLU101pAYS+9R7HzaSfHgAeNpgwSKGTxTMVmCZmcoGiZUGo7HdVNdi?=
 =?iso-8859-1?Q?W8HRzP1+W7Odyyg51YRzC8k9tl32bDbgIanc9Kl2jEB784cvgpmV9019b5?=
 =?iso-8859-1?Q?cbraTTeMyez54fpywwXu4eCFJ/JXA468wDUGBnbqFpIxRNal8WvLMepZm6?=
 =?iso-8859-1?Q?DWdQJP0uOWWAeLXlgvvnthq208BIPbf7FqJTL1eIsLbU4tsG8SuQ+kkJ1v?=
 =?iso-8859-1?Q?sbYEd4qjAAzKd2KggEoES9PJdKeTj916DXmIwhoo0eYXCnCFp4OzXf5oAc?=
 =?iso-8859-1?Q?U4YZ+LFrQHrJ0ZK6Za6HqNrAG7dToLirqF0bfD9LeXJV6ugn+YqLX159NZ?=
 =?iso-8859-1?Q?9MZDgMk+Y3vqEta227xHKJ+8meFPlUSD4mdWXigV4ZfnQkuW3RkEWNJIvF?=
 =?iso-8859-1?Q?DETDC101Y2B884l3mMrOMeiUGpIianLlVPzq1pJew3/Pis+jxjQxwwLFqg?=
 =?iso-8859-1?Q?oisyzUmtDFB5jW1X+ottEev/U2CN8aK4knct4VmGqPWOKcl/vWYykdZJsS?=
 =?iso-8859-1?Q?D54qBPGGAxQgfrRIWNPuBkv+Fd9fq3gTqnV76dN2//zjeGQPYWbbUjkf8T?=
 =?iso-8859-1?Q?migWQh4V8sVJWJPOPNhVGgxzt0XPxOhy+dXCIWSxTzQBi4Nh5BrFH1+pLj?=
 =?iso-8859-1?Q?9AeCUM3MDmipTHlKl4lRjGYXYbBUnMugPrsierDi9fvwFzFzYh15/6NMeB?=
 =?iso-8859-1?Q?cFc9Y4mpru7fw21XLd8XnWK0Z+tlb5N/pzoDEpdJCagA9JpNUXpunKgAWG?=
 =?iso-8859-1?Q?o6K37hgtj9Ny0WxXktH8BR6O4SBhD++YdHso928QD3PBnlD5UQDHrtwbm1?=
 =?iso-8859-1?Q?I4n9Mdj/y2Ue6ReDVYNlxm8Urm3miBCYmXcjLek9k08eCI+Y0bzqmFNlIO?=
 =?iso-8859-1?Q?UinAA5M3UDBM+4DWf0gS/+wZxi/NmXhjinzS+Et9eEgPm1lO6cI/Y3Cu4x?=
 =?iso-8859-1?Q?zltpz2EuC7ntC+Bymqi6r/XMZ/22C/Ex776XnDNB4G/t5YvNOFmqTEau4a?=
 =?iso-8859-1?Q?7zbspFh1vFMfFdwBONQKPIFmeLkQ5f9H4ItfpkHXUqLHZH3zntL095KOAQ?=
 =?iso-8859-1?Q?kjLMrfjHiPN3wPSRfgPA2BVwXP4ukSyOVWK32/fgZiXjSufJLJs5X7xTRO?=
 =?iso-8859-1?Q?+4BArUbs1v5Mr5wPkbXyXTQGz8CHFxSiXU5g5xorVsTQsRaq8/fNGgt/e3?=
 =?iso-8859-1?Q?vZcD4VLZ4gvftsPKcCaudco8eL1UppVUY4q8MJsN+Zpn9FuKDoero5NQe3?=
 =?iso-8859-1?Q?selqETF3yCF2eyGCXE7S2BNeZhuHk1Rcoy3zUZQQrCcPQqaL8YGOJE7CL4?=
 =?iso-8859-1?Q?MVGfddBye5KkHYUnpE0+EqEVAOswzl/xzQ8pfwoP63UxQucSNOVq1USmf3?=
 =?iso-8859-1?Q?sfGJrEGWpfFhIHfuf4U+GtK4WvAUK5tlviEOOYsfRSjTe1lxkkOuiWS5ju?=
 =?iso-8859-1?Q?Kq0CPvNkOR8SV1Y/iH8DGD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+4Paw3cGTR7IbScW4nrTykjqRD2Ar45CycXJm/HOpWTuBIAVIA0hZY7+no?=
 =?iso-8859-1?Q?DdLyNs6TDyFDD5BfXtJqH57M4ZSZvVDZIM1C4I+rhwlI2jigQxqka4kDey?=
 =?iso-8859-1?Q?HOocY5UDTAPmJXWX/e1UIXLbH+kTBhEgfUzpARN65akVkbAAxCg6YdDPcB?=
 =?iso-8859-1?Q?TPcomQrP30SQWIH7bAOzTps04WUq7FafiFFEa8E6I8bVgOmPghMQMPaC9Q?=
 =?iso-8859-1?Q?9fL7uwupCU4JcBAM9zQJRbPqZiZgulkjf7VoHj+6HJnulDYeLxdFaPp93x?=
 =?iso-8859-1?Q?/yHPtpunLnln5kmuk0DJMGboCJcmm/DdaU4mrLbdziERT/qLdMBog+WR78?=
 =?iso-8859-1?Q?Y4Ul9EOMSkA/PRnmrPhIWU/Krcmbz3SmuiOv6jRUpq8my00f9kMgikDpD0?=
 =?iso-8859-1?Q?7bcGzOCMKjkTylI9jZTnlpHvvhk3yJ+NRpNb168w1SNfeLPMm4nNMSH82a?=
 =?iso-8859-1?Q?RvyfWNqXvor0/SmxOIfkDWXX8exxVIrFXRs9qenrrBI6uD9yR53f402MLz?=
 =?iso-8859-1?Q?gRBIQ4AUH9uJbzV0EnQbvg9wQf22blKSe73uR7A7XUZJs6Yg+de3X0UZid?=
 =?iso-8859-1?Q?3E/yCoMV3F7BZTSSgxI/wKGlrjhmSEIbFDWOOqQ5AxkIp587uCHY29zXhD?=
 =?iso-8859-1?Q?9ewBCFPrsd31a1PgHNwKfvsBcR+na+RMpXd8O1wmnEzhr+IEZmuK+hDBCk?=
 =?iso-8859-1?Q?mxFBTMtQRYUs7qpyYV871GUuC8zyEzHBH0ae9uRKBxpf/5SDX/YOueo9yE?=
 =?iso-8859-1?Q?Uj/8VxRaiXN2g/af29MYFhDooWXE5QQB1BCVGoBRpdw4HMBAqlhTTTVaVZ?=
 =?iso-8859-1?Q?JwAjRlk0YA2wTR1aqLS/9ZMn2yo1NVFlD08piqr5KxjUrbKrkL0C6wu2dm?=
 =?iso-8859-1?Q?p4MTa9vVE+9UZm0Cf1zmX2uCoMvfnytgY9owwCRJlOzXC3cLKxqsuy2CZl?=
 =?iso-8859-1?Q?oqe031nw5Td50v3MlcdNs2hxt+jhbMCxrMWy4FhouTiO2q92ZyGBo0RQyR?=
 =?iso-8859-1?Q?SklhHaZNnXyhyaQiCUWac0d2m4UP8p278gZMUpiy1T9SWdEdi1p1+trAvX?=
 =?iso-8859-1?Q?dXTW45GQUAYnYeRIBWAgWakBfRxLI6sSpege6boi9hwUDnRQI/A6jIut7O?=
 =?iso-8859-1?Q?GOe9KWu+3ET6CvG2PKmbCTud4abO0DSj2YkOh04S8PEqiauGA8uRfF91Rv?=
 =?iso-8859-1?Q?FxHyviaDFzI/dU+HfQ64P/8vZZlJ0RuQeWauyCbZAO7HUvHhijLFCkm7FK?=
 =?iso-8859-1?Q?gTACr3AevR21e74mfaYMnesrsy2gffB6JiX6YqJ0HNj3c+crz88pGJLOBu?=
 =?iso-8859-1?Q?MaMbW9+w6iH0yjAAFJrIe89tV7/2XujGZ6+iBpHMHst6l+WVdVXItlLRjz?=
 =?iso-8859-1?Q?XPvlm71mLEnc0y9F3RMCvtkfgL1DCjLrWTXEiIA+mqr2euiNM9i/XOeA9/?=
 =?iso-8859-1?Q?8SMHahbv9kZiIZPQODSnjdgi4eEBMSDFs0M0ILgJUDsUKaTLk8a+0KkLqU?=
 =?iso-8859-1?Q?1YVexeyb9n5V+ZR6TZ0BR+0XocsAS1O5lYBew/GN9kwJ86Rlezn8mZMLy2?=
 =?iso-8859-1?Q?22sfUOpJtSUsCxOkQag0pd9FugaVNG7CUBCzN/xMvKyPjnz90i1/CdOqut?=
 =?iso-8859-1?Q?stpiVLJdljngnPjGWtTxQkNhQUFMy8hMBvX2E5J+HUw6a96uGutd2koyCe?=
 =?iso-8859-1?Q?UkvZi2TPhYWlRVnU/Ww=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19beba93-488a-43d6-1279-08dd571d2339
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:41.2423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTgKpD+PW6by/Qq1ZnNWKXsNgylE3xFOFDV/e0g78lyblAmAr5DnsCyNeFpOu8bQxBGZxYyGcqNxijrfIOldKEJuNyGjq25sbc7nhmAJINzH2fPtMt9117xof+B477zh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c              | 24 ++++++++++++++++++++++++
 include/hw/pci/pcie.h      |  6 +++++-
 include/hw/pci/pcie_regs.h |  5 +++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1b12db6fa2..f42a256f15 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1214,3 +1214,27 @@ void pcie_acs_reset(PCIDevice *dev)
         pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
     }
 }
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    assert(pasid_width <=3D PCI_EXT_CAP_PASID_MAX_WIDTH);
+    static const uint16_t control_reg_rw_mask =3D 0x07;
+    uint16_t capability_reg =3D pasid_width;
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+
+    capability_reg <<=3D PCI_PASID_CAP_WIDTH_SHIFT;
+    capability_reg |=3D exec_perm ? PCI_PASID_CAP_EXEC : 0;
+    capability_reg |=3D priv_mod  ? PCI_PASID_CAP_PRIV : 0;
+    pci_set_word(dev->config + offset + PCI_PASID_CAP, capability_reg);
+
+    /* Everything is disabled by default */
+    pci_set_word(dev->config + offset + PCI_PASID_CTRL, 0);
+
+    pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask=
);
+
+    dev->exp.pasid_cap =3D offset;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b8d59732bc..aa040c3e97 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -72,8 +72,9 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
=20
-    /* Offset of ATS capability in config space */
+    /* Offset of ATS and PASID capabilities in config space */
     uint16_t ats_cap;
+    uint16_t pasid_cap;
=20
     /* ACS */
     uint16_t acs_cap;
@@ -152,4 +153,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_de=
v, DeviceState *dev,
                              Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
+
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod);
 #endif /* QEMU_PCIE_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 9d3b6868dc..4d9cf4a29c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -86,6 +86,11 @@ typedef enum PCIExpLinkWidth {
 #define PCI_ARI_VER                     1
 #define PCI_ARI_SIZEOF                  8
=20
+/* PASID */
+#define PCI_PASID_VER                   1
+#define PCI_EXT_CAP_PASID_MAX_WIDTH     20
+#define PCI_PASID_CAP_WIDTH_SHIFT       8
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
--=20
2.48.1

