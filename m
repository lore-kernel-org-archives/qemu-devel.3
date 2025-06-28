Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11068C83013
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuX-0006Io-Gq; Sat, 28 Jun 2025 14:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuT-0006HP-1m
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:17 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuR-0004Bn-77
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133855; x=1782669855;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l4TgtKCVB0Ls2fTExhUGHquvdkt7C/ZPMNGRZaFBPuU=;
 b=NqvyX398T4Eaor+TJ6uhOAQv1N/nkYpMc+OU3TIeBJwLykXlAiRbv2qS
 0HZn+aFfBYhWOoeinyuMmSqthUkJKjOerGQYNSaRZpO4z7bxf+VuvJJTQ
 6dPATcjER4OItwsNOjY661I8209CoVuqEu4N1MsTFQlMPS1scJv3uCUZm
 v5My8lAV3iIa3mAS3aaAxbEcc02nDj0AvVFrEUne9zMyZYdm9ZxFqEF2e
 2hPutpDIlzpDLOjrDNzS4BAbFba9msLJTMpNS1dOHboTYyaegVmYJ1YaL
 i9jNr/PBK0FgvfyjqqntYyNYoJDmCeuxwv0FamRQ7rgCg/YspdhXvG+Jq Q==;
X-CSE-ConnectionGUID: gnBxSt1IRBGtbATXD2Pt/w==
X-CSE-MsgGUID: CfdOF+sVQ2qF1zjFnRvRsQ==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39505878"
X-MGA-submission: =?us-ascii?q?MDFGxAYcJV7TfOdm7RwGeQsdpjFHiqpdlBd2G1?=
 =?us-ascii?q?qHLep9uJD486S442qYCkQ7fYKR2QnY14pCisI+Fy4LX8R7abjoLxDmsC?=
 =?us-ascii?q?+z/wsWtcqBgvKix9QCQLJto1yWHRwxfVMCEPiM1SocOW0IzuShigbfRt?=
 =?us-ascii?q?WwNJfulgzqCKYxOjDwnGTHHw=3D=3D?=
Received: from mail-francesouthazon11011034.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.34])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:13 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyrYHeiFZvASTtMFxFufnmMwQ3hLdlqD1NxbggeJff/l7GJbn9vBUX7M40LK/oURQTZECAk/3u/JXWdaTn+qrFwDb6zcvLkiywcqXwL1/MPibxBD7teBe7t1nDCrMG9gceAuzPcmBYNNVxg6Gh7tsYeWWB2BcemqZmQhbRx3qj7c+1E7BZFLTgiyqNy8gpmty5PepbEkLIGqW1/PTeFrzC1FkWwiRyXBSwTGrUlIkFpp9+r9cv5WWFj74aX0PiP6GNhU1H/MpTkZ2mHmcJgamllqeeBbrp/ayU0uKJcWlNov24kAw0GucRF+WuQr6ujJQ5gksTN1jdOq2AtKlBCwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIVzMbU8yKdebWbBOLkNkxzHo1qT+dRnO6h+vvxqrWg=;
 b=c8M5HqUPG2bxO+0uPAEoX+d2cp+Nwq19NPzxmnlTNpYhRUz5bKSTE0jKGH/NMKoqHTtrKxtopcJBXdhiZDEtzsqFiV+fNBBi9IbeTBPWfrvTW7lgIAvK6MuE8q8Gx7x3hPoyvrSXu0WjP1RfDww2fd+h8nnvXiuKDzjMj8FtjHD7+/asNWo99vXmys333CRxj063U+DaCcIXPI3/oxRu2LPxEFMuLE1BObFxMb7pNxyjhB26ycwBo6Afc25kTN35xPfFmgWI+Db01pWU0mjY1yzn7r5xIP+fplYzZ7nIi2kLq8MSaTuS771PdzglEgZJ7IddsRCmqcQFacTuuRy9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIVzMbU8yKdebWbBOLkNkxzHo1qT+dRnO6h+vvxqrWg=;
 b=Aty8I67e0R/N2TSI06Bn+Q8kaBkade+G7xfjX8QKbSyni6s0BIhjuakttUQg5ZzsmgDo1sS8NAXG6pMP0nFxhF8xHOQZOcgfu7SPmashzI+hxJm9kqgfWO2tlQgAJwcHNWx/jv/6F02KfA2mZCDhdvphoN+CD2vgdvKIxaCy68FCwPHVN7OKvft84OlPtS0YpkLmd3NpUf+Jyym4ftGty0HSgof3anDbrrmUDB8FYsRTetBUiqlcWag7QJSby0ApoH+mFNAiv3kGAoGSYBINorazNRbPIt1OIF8p0wbMUt/yGUUFXrOze/qF8chD9qdKguflxaWiAx3oJPfFALpknw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:11 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:10 +0000
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
Subject: [PATCH 10/10] intel_iommu: Add support for ATS
Thread-Topic: [PATCH 10/10] intel_iommu: Add support for ATS
Thread-Index: AQHb6FcMgyxp4F4SRkicCdxtTSx/mw==
Date: Sat, 28 Jun 2025 18:04:10 +0000
Message-ID: <20250628180226.133285-11-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 4dd7ac41-9066-4261-70a4-08ddb66e2f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IiiYGoQtbjG0oh4yIi+YByJINpLOh7nxrPrtzopc2dEHdcprGqcYFkkyjg?=
 =?iso-8859-1?Q?DcOFaAwgoUt0mIp8qWllAEALMSZ2nGUuAqUk5NTUV5MvHAeEKGpL8rr+TR?=
 =?iso-8859-1?Q?7/Z+o0WG+25iIXTOAi16Kb0SX/K8X4Osijyyy99ow1KtXHFnn1NAm036ZG?=
 =?iso-8859-1?Q?oVByI4xVSPlYPhOVnt4qBRdMeg4q1/EX06BLxCfu9SOeqv5vSYe32NiaQl?=
 =?iso-8859-1?Q?GZvO2v6HctQVMggb0GbYht0zAmPPlPRstL6XUz9tXzebwCK4QMK5Z8na2+?=
 =?iso-8859-1?Q?Z+/o49sI080COv16kIrjntDDbpjgKCtEuKnDTmvPgHZ7S7s8I+7Sp5ShIC?=
 =?iso-8859-1?Q?vOL1xz7iCTdBX1GoYBLcuf74G6r0hNu0wADECEbDV81U0DGr9gEPbL40aq?=
 =?iso-8859-1?Q?SrUAIZG58v9qwAi9ZBPHdAcKc7GRsIQlp8HMTgRRQ6na6D0/8aFvkJBJJ1?=
 =?iso-8859-1?Q?rzRUd+7HYbW/tt6ZVW2Ifd5R22k9x3N4PB4z9E6XLsKfY+hDP9f4DOm+TF?=
 =?iso-8859-1?Q?gANu/9D6YLGynzHseZL7koMg+6kwK9w4c+uoZ+nj1bHJRsQAfN8277eNGC?=
 =?iso-8859-1?Q?MadTXZBQBuDXWhjjPD+0c0uFoR22mFenlqSp3+BQOTjKmN2oO6jZQyeV9g?=
 =?iso-8859-1?Q?wmIua9NJUDowWbr4zrnE3dHcbbtXc8kQyI8bkzobk5p4LZ8W0tKdpnLDj9?=
 =?iso-8859-1?Q?2Gr+bW9Y+EVdP+MtRkMHUI5SQBVBA6ve1j/uw/Km/P5p2JapkBhl/tNKIL?=
 =?iso-8859-1?Q?fs+gEJ6EFzTSo/GV387MD7GaQavP85FSmejvViNUfOjpgTtVqFwVAC91D4?=
 =?iso-8859-1?Q?nSq6tJNh+Cm+VS3ex90llXATnj5T82RdKRAyp11vLnQorwyx7PIUEOISAc?=
 =?iso-8859-1?Q?79C4glUCjpdXE5ZQHDbGRLHi/M/EpHMH+1ORRlbd/8bVTGaDKVYqwRjNef?=
 =?iso-8859-1?Q?cV/FgsFr8b0Zk6DqjBrS9VXh5P2yk/ltfntc4J1viF/BewBvMJAvrvPMbw?=
 =?iso-8859-1?Q?//FoR3lO/YcgcXaWo77dVLezuH5cNqPrDMQlezApE1nydlRHdn9+QPwUoW?=
 =?iso-8859-1?Q?0eOjAHgGNKxfeeTaE4sI3JoaBdiGYAbMuIC2g3QRnrJMb/kWBo47RlZBPu?=
 =?iso-8859-1?Q?8NwbmSX6tviBhPXOmor6z+nEvWYM+mkVmsJJPFEpqQ8lNZhYP01Y2HW8HI?=
 =?iso-8859-1?Q?djVcUulMz41IRvBVGm43hFJt4uwiazQkslSWhH3Bcpfl39Z5eBt4Wl5JDm?=
 =?iso-8859-1?Q?1ZUp+JU/5dyU8A2m1uKZmJcv6/dFgMDNVvXkxRkCc3dhNjdUt4X1wLjAnR?=
 =?iso-8859-1?Q?nQABzYNDCPzUb3M5Mo7xCibv5YSD8030dLXr1x+AG9eiyroacDKxFc89al?=
 =?iso-8859-1?Q?/dCfEyEfYcOz3cmJFp4JW7DBf+GV+z3qWfsJTq4aP+29CXKwrsFN/T6wuO?=
 =?iso-8859-1?Q?TeJDDnq0m0YqjdMbSg/ZczdfXPVRCKctHwhSWY/fh5qlHkmumn8aF7K6L+?=
 =?iso-8859-1?Q?OkKlRCJe16tnhMnHXYgom7dx+/XQhD3rqXNFWhP3GUAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a/QoZGp+E3JmiUpRBEuXU2mEwzF3swqCwU8q9ErxM8qB3GEujybTwlS/vA?=
 =?iso-8859-1?Q?ch1VvXiRRRFONKueAOfagvxOUmN2yH5OZwcomuXFH+E1tY5qZNYL0w3wlU?=
 =?iso-8859-1?Q?hsT9p7McYcVavaFF6o8AmLx00oVz0C4JFuJrInlKN07qieRvKN/P+r1Fsp?=
 =?iso-8859-1?Q?TeL6YjsHikB/1QRrGjvZCBsyYTlrV+5FU+sxsuv0FIy+73YTTmtyRuFVww?=
 =?iso-8859-1?Q?Nu/kgIf3KD54FI3RNg0LCKSHf34nAPs8KP0zuoGh9kM/p0hLvlBlA7ESMd?=
 =?iso-8859-1?Q?XK9Y0CbbnxBYIz6rx0E6Z75XQFj5ZqNUPOQlVpPcLmRzdVNeVRUhr4vwHP?=
 =?iso-8859-1?Q?EfLp30FuW51y2uSsulJMT9MPouTon2pXVRbf0SfYMESIqL99NHSAiubJxL?=
 =?iso-8859-1?Q?C627O8isNJk8oP3lc7Si/MZgCLmDDNQC01393SNTm+NWzt3J/xJLwkJZlg?=
 =?iso-8859-1?Q?UJpcbNSrwN/7wWCN7VUMp0Ve9YkURU+olS1EhfxslCfPf8FKycJRSrfSQk?=
 =?iso-8859-1?Q?KGnsIgYtBRuspshT5P+qlbBLQpxRK1ELvIIqh6mZPP2qPkift0KeMehoCR?=
 =?iso-8859-1?Q?7wJtxH6KuBpbCkez/y5Yzt9oGmeyTuOGrXdMmtS/C6cyRK0eRJ561GM+UB?=
 =?iso-8859-1?Q?lGzUq65Xj2bNaWPLi1euplYKPcKeOhPjGrdkud6yS3D1qnxCWEDO+L/qi5?=
 =?iso-8859-1?Q?GdLsYs5h3hoZ0GdXUJ72Qb3YsPzzFVoXVR92aLQM46OUg6LdFuxEQS9hLa?=
 =?iso-8859-1?Q?yLP5qg+cLX4axJABaOofsZ9m2446/PplzNnT0qR/7JOTdmA4PXThxeRqS0?=
 =?iso-8859-1?Q?sMowSLsae7NNJV3AWQzQB4IQqUWFS7fAS9lR7PLfTmqRYlLlK09PIMsYe8?=
 =?iso-8859-1?Q?eSBFnHX/OBd3WcHdjpWt80/XBcrafFb/ajdP3Ct3geevnqyOBdrY9zed1R?=
 =?iso-8859-1?Q?LIxfbPe1DSZ7SEFdDTpPRGbY7ta5LxJE4Jhk5J97+Fi/JDvfD5RSSOR3zn?=
 =?iso-8859-1?Q?UKeW4AKsXGzkJswrvO1S7jK95iRDLQXCmtzjG2fLRq5lOP7si7c0NOSglx?=
 =?iso-8859-1?Q?IVILexNDrFNiKrabZ1lkXg1j2JbPwVWOhaLVhdyP42qzhRzLLkiP34KgBo?=
 =?iso-8859-1?Q?xEs2dLz4TpwZVlrx0qHjtd9FnzEiGP/SpsI1ufPRN/4xz2YwlgfbVkIJvg?=
 =?iso-8859-1?Q?sE5LmQlCbdZcypBlTzx25YTqMJObM2JO1Z0hbGD9+VdD6Ry43TtiYvG/1Y?=
 =?iso-8859-1?Q?+cQW+/unMjBxGAiZrxi6zRCOW8SgWhHPtmMVF7KrkrXYNQUU5Wh76r8wPr?=
 =?iso-8859-1?Q?v4tnloDB4T364L2ZIicEPo/Z+GcvensNLQVQOczWnG4bJkbFW8OmNhKNmn?=
 =?iso-8859-1?Q?glmeQDNaUXWlruRfFo/ZIPWyGIcpuklnZUu31EX0yrlyTgAW3gtrQJcvbc?=
 =?iso-8859-1?Q?8/uBrbeatFKbDK1JoyjhSmMRtELlYzNi8uKRQYLzvwPytgKCCBdiKo3Jx4?=
 =?iso-8859-1?Q?rAgisW8zwFfPIdDFQEatDUBTsmZhrongyBah2HYhcFqsSO0R+meL4Muvo6?=
 =?iso-8859-1?Q?UbGQO6rFNI8/QtKniJk8kIc8WdzzRtaLwK00vRCWNuX9LXCnIbxZKryTRL?=
 =?iso-8859-1?Q?036zTaS/rKuF6SclCJuN2Gqewr+7oTPviRcngg76C3ORXrQJzZHm77tq7N?=
 =?iso-8859-1?Q?VIJe7iPxzXy1pSOUwMM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd7ac41-9066-4261-70a4-08ddb66e2f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:10.7469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FK7NSkBbLBbTxvjHSYIeMM98TubSz6+mEGSSGADty0G1tug2ZuRzYoRtLpDiJs60El5uO1J80G6JlLdxFx9kPpBs9flI4Y5LiyQIbf2+lYHN7wwdK+1gtVEGUZXiMcF3
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
 hw/i386/intel_iommu.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1b1b0b5632..fe9a5f2872 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4738,6 +4738,68 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus,=
 void *opaque, int devfn)
     return &vtd_as->as;
 }
=20
+static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flags)
+{
+    IOMMUTLBEntry entry;
+    VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iommu=
);
+
+    if (vtd_is_interrupt_addr(addr)) {
+        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        entry.target_as =3D &address_space_memory;
+        entry.iova =3D 0;
+        entry.translated_addr =3D 0;
+        entry.addr_mask =3D ~VTD_PAGE_MASK_4K;
+        entry.perm =3D IOMMU_NONE;
+        entry.pasid =3D PCI_NO_PASID;
+    } else {
+        entry =3D vtd_iommu_translate(iommu, addr, flags, 0);
+    }
+
+    return entry;
+}
+
+static ssize_t vtd_ats_request_translation(PCIBus *bus, void *opaque,
+                                           int devfn, uint32_t pasid,
+                                           bool priv_req, bool exec_req,
+                                           hwaddr addr, size_t length,
+                                           bool no_write, IOMMUTLBEntry *r=
esult,
+                                           size_t result_length,
+                                           uint32_t *err_count)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+    IOMMUAccessFlags flags =3D IOMMU_ACCESS_FLAG_FULL(true, !no_write, exe=
c_req,
+                                                    priv_req, false, false=
);
+    ssize_t res_index =3D 0;
+    hwaddr target_address =3D addr + length;
+    IOMMUTLBEntry entry;
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    *err_count =3D 0;
+
+    while ((addr < target_address) && (res_index < result_length)) {
+        entry =3D vtd_iommu_ats_do_translate(&vtd_as->iommu, addr, flags);
+        entry.perm &=3D ~IOMMU_GLOBAL; /* Spec 4.1.2: Global Mapping never=
 set */
+
+        if ((entry.perm & flags) !=3D flags) {
+            *err_count +=3D 1; /* Less than expected */
+        }
+
+        result[res_index] =3D entry;
+        res_index +=3D 1;
+        addr =3D (addr & (~entry.addr_mask)) + (entry.addr_mask + 1);
+    }
+
+    /* Buffer too small */
+    if (addr < target_address) {
+        return -ENOMEM;
+    }
+
+    return res_index;
+}
+
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
                                     IOMMUNotifier *n, IOMMUNotify fn,
                                     void *user_opaque)
@@ -4787,6 +4849,7 @@ static PCIIOMMUOps vtd_iommu_ops =3D {
     .init_iotlb_notifier =3D vtd_init_iotlb_notifier,
     .register_iotlb_notifier =3D vtd_register_iotlb_notifier,
     .unregister_iotlb_notifier =3D vtd_unregister_iotlb_notifier,
+    .ats_request_translation =3D vtd_ats_request_translation,
 };
=20
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
--=20
2.49.0

