Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAAFC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4U-0004XI-N7; Fri, 21 Feb 2025 03:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Q-0004UJ-PZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:38 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4O-0005iz-JQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125256; x=1771661256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w64iDFlh2Vz60cutAFr32ZTAug7hSDs8iVKBYK9r9f4=;
 b=Coi1J5jjc+IvrcZFd2hasl+e5t0I/HIs0Jwu+bkjZpqwju+FPFS9mMfh
 N+atWC0NUrmz+ttNQF+TuVtrYihf2BdyihBlwqB7Pg8lR42Or7mQ0jDag
 uBlGvPe1pVwKqLs17GJk65qR0QTTwgu/Z1snJLl1K4bDB7gqul6iP6VEC
 exZWQ8HF3DEsH/3H80HwVRkpg/AfWgK6KXDOm52A/zHQH1oSrpHIcNMBx
 PRvxvMXQpVj1qVXgYLaH24Ih6fBtB4Y5KVAenZ0s6SyFAjk9xW+pqOw5m
 k2p1qpfXofqj0CAPUiGZkHv+gBtFRZAhAdnGa6dXHs6fr0oKiCWdLJ2Ca w==;
X-CSE-ConnectionGUID: /f5uTNVYQ8u1gQVeQ6uffQ==
X-CSE-MsgGUID: /BxQbDuFRPaXGQv3fE3pJg==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836639"
X-MGA-submission: =?us-ascii?q?MDHNXY1GDZoRGV+OnAXq83qWQnJxCzDlguRgPG?=
 =?us-ascii?q?23ITnU5BM/lVB2ENHQrcL6pnCwMH2xyBDbtr6MZo9+685+zbmq4jcCTT?=
 =?us-ascii?q?WYjEAvvkIaqaRL+aCy/waHsic5TYBip9yyEwCKoKMiVCqobLDj/hTGlw?=
 =?us-ascii?q?uWVtTmpJM8IEK+81uzuv9RhA=3D=3D?=
Received: from mail-db8eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.107])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:34 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXXKVCqU56Ma12JfXxj9qCc2pW0KBJ4aDFZBy+MIdZxAUnR+fau58xuskMQj4bcCwoFeoUQFZJN0IPzePBscShVlQZ/PpMQNgRRnB7wOpJa9UxEPD5G9PHHuUn8i7E8sn6wY3U0YUVeCPXs47SOWb7M0BGOznBeLHVfe5B5VLB1MWzFgbZ6OBddScayOJqcUFkmdZ+W62VwPRZCTNC1wsz+W/L7H4tWXKu6Fa8pXAy6ae1GSp632vSGej//9LY8BUVfROeryIC+ZBWNowIp/gVwG6HWmAId/yVRNQhkGB7XLJb1dg8rSx0obE4vzTAGTGARylaGa/SdryHHP1ZR5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyEO3euh9AoZSwkw7yqOQrDjpjZ5hlUtxnMlEg/EquM=;
 b=aIt/JKbNzzYoM3Kh01ajyde4GLuhwfsd0pzECgQMhEzSQ1NUo4KmBTmPupV+AIgRkQcO5F9KksuC1LqmxRkEzghnNtCTZEgLo1nXVPBvn7iLgT7QD/tgHTW/EqIfs/h0dJ6OO4sNTn2VafD2XNYBFjTzkd9kAa9C9CrfhJ5b7gghxl8KlkCkpSsrjGCB364/uYEtxic9rtGOqIYYtLf8VRopD8stTVqx/A4BekmIedz9z81ttxasIjfbd2XhrfLBKNFaas2BtvinjFsRp0DUmGGZSz+PR3NM0eok4n0hAZUmyEer0x3FYjT1fpOzQgORAXbmzRKUJR0Nr36buyWQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyEO3euh9AoZSwkw7yqOQrDjpjZ5hlUtxnMlEg/EquM=;
 b=HSr3vQC3kMM7OGesbMkRGzD+x7D1ok9WffYPsPIJbFmlp7ZhkwzmwL3Y1Chssh6RHRe1v1i58pv6mraeQtS4MC1L7FeAFklH1+UqCsTTatleiUCveDBF3sp50AKklAqvr6fjiv8aTq3rdhgFWob//XAIVYNjBsym/4U0OotnlDLVXqEHzVzFZnxrn5Rzw+NlChhpb4sUt/IEPgzXRWkKPSs6e6Ee/TmeCFunuAuY8Xwp8wfLLI6eeKgltpX2IhCEArmEEzQ/SOBJ040HYezJJP9QDMkwomAmwf3ltnTjEjb8XPib4aO3sUHYK4i+LjIWu+cnftWGt6p7YsvwMAlIeQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:32 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:32 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 03/19] memory: Allow to store the PASID in IOMMUTLBEntry
Thread-Topic: [PATCH v3 03/19] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHbhDeoL7xim+sjokSBg2RXG5LmDA==
Date: Fri, 21 Feb 2025 08:07:32 +0000
Message-ID: <20250221080331.186285-4-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 18eec6d8-e1ff-4788-36d1-08dd524ecb06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0lBnrwvGk6nVpmsaOEzCZbyAQALREc90pkhh3L8MnkMBJ0Fl44w/RLCKTV?=
 =?iso-8859-1?Q?z0i8jJ9SRpIVXnhZtO25RneCw6ucn0fyWThwFbhMaXGtJLndQaNvpLzUPa?=
 =?iso-8859-1?Q?jtV96g3Lh8CkldV5irjXaVkC7IwexF8aPoe03DKPx6OoOKq5Y2ImOkZEFC?=
 =?iso-8859-1?Q?DySe0OfP8yGDQA0iqH2mFZ4h1SgmbHc8oKbGk1rEOJJ3TtQkBKOKRreWLn?=
 =?iso-8859-1?Q?ccIcvMdGbo/cgqTUH19qJUKTmmEsPOa3IMZND6jPQ20HfMPfHu4LCzSKO/?=
 =?iso-8859-1?Q?rHnokKEMHyNLLg9no96QAr5NIdMVs9kTTqf6nIdbd38FuWf8yzgBAM9000?=
 =?iso-8859-1?Q?85L3sZler3Wvu8O50WdNmuLyy8akO3/BQEz1e11qA++LWeCO78N1YR0/YN?=
 =?iso-8859-1?Q?7YBTyrKuuB6MEIIU2HP8cbuXB1K9bn/kRHQ25vHWdV4SUpi4N+fw64S+pG?=
 =?iso-8859-1?Q?Z8lL1eSxxXa45bwwW8vZK3ZVHUYutnLsR7qImaDOh/QQtAW/SXUIJQlY/l?=
 =?iso-8859-1?Q?pdGEdSRSTI9lLDTsUE8/i0dX6KWb8h/BlIoIgsoN2AmwUQkC5sAuj0C9Bt?=
 =?iso-8859-1?Q?AS9eeej4bXSsSee86rP8zus3Cjbok8OzCLULXm3lGjo/6VlfQd//dPHft1?=
 =?iso-8859-1?Q?VwhqcqVaRy1QVvPBPlaCMd/I80CwjQb6oVXiJhkF1NlXgZ5AdkAP58vvFy?=
 =?iso-8859-1?Q?U3aXjlPVz3Q6smdz4xrgCAqLsjGLPC7NVjEz6Kc5YAYrILO5L/yFrPyBwx?=
 =?iso-8859-1?Q?qyF3lbeqOkjJohHz78tHqTW0ZhIt5qoJ4YlrZVbMwJXNh4oOOlKSV7duGc?=
 =?iso-8859-1?Q?rxlwow6fYEUSbXzEQpZftMZTENR7dMJIjRJYJB0iBS8V0F0HLuLjlaN2FI?=
 =?iso-8859-1?Q?uI2JFn7st5r6wVCJt63+mLPwyIuPYJR2qHC1GORLYuqBoVmuVrbl22Hlun?=
 =?iso-8859-1?Q?Bve5ztXb0Y01C14+s6RZl5c3Zszw4goPnKnxC5qwfkgkFpkvC6E/C8TmfR?=
 =?iso-8859-1?Q?TzvdX0EmXKhYuIbIRYGtl+Pbb6gDcvldoSpo4i0msNy4ChtMGg2fjg1VBq?=
 =?iso-8859-1?Q?fixWwBrvVh+r9jnPpdbRsJxWpD5yNpN5R7+2BuTpirGapLeauC4i72K3Tk?=
 =?iso-8859-1?Q?5pfPIOPBBxEUlDh+kl8HguhBSg7u/qe6yYliyGzruBpPELC/4sR0sP7Zgj?=
 =?iso-8859-1?Q?PMv0bGdIG5gWt746m9YTpKuzVGGsTOuMXWUUNIvHRBqqKxRLsRgxMoCQ9s?=
 =?iso-8859-1?Q?+RxCS3sTrpgom+o4ufs4/XD9FyNvnjHFQbSIFGoLdY4h7QorZw1X5mXjg7?=
 =?iso-8859-1?Q?tOLt8BY/hY3qpqgCQTHELwedUqw9yivGUeaog/LyZv/zW3BuMq68Nygy1a?=
 =?iso-8859-1?Q?0XEe8c5vIo5lu9bi+rdkN03FJIWd9WAmBxzxcYgLoCTxH30WUjU3StqmEJ?=
 =?iso-8859-1?Q?FfHTRcAPf+X6PcQ9bKyUnIoEAUX0D1eby/26slOmG1e3Dt/VDxrC5cDVrQ?=
 =?iso-8859-1?Q?4QHDo6NR9SNBfsy1uDC2NZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rb8NIDKaYok070ygsXIibTIqpbaWi0G4kN/pH2hGhmFG/Dt3PfPvWOIYdW?=
 =?iso-8859-1?Q?KATrM+wzdm3KYb+/xDvXTxwjvbyhr4pWRPG50O7YSGfFDa7e6rtHOvfx0D?=
 =?iso-8859-1?Q?lICuFYxKjbCvG8nPkGlb6DE2VbLfK/QcIF2c0cgNJmpT+OQVSS5yxjfTY0?=
 =?iso-8859-1?Q?ZataGqQdbvHq5FcgO508b3nV7LHTay1XVUWNo3m2qW54jUjU+7eidjkQAN?=
 =?iso-8859-1?Q?f/OQ/Fr7Rp0jbtNYl+pe6vEhdLk53qsVpeaPNBDyg9GjC3MumHGfv5Pot1?=
 =?iso-8859-1?Q?lA/JZq5l/SLeR7RhVRqmihd70+i788J53xxd1YHjgw6HrNuVRDGTt7VOeI?=
 =?iso-8859-1?Q?X4OZ+wBd5aVItCDFzV4YvNaPZeVm+zkG1Prxto0ahWFyrflNwZqAR1/3rh?=
 =?iso-8859-1?Q?5LVBQGTBx0KLHxUduLrcvWfIHZaX3AdMniH2vhjxxfx591asx9YTkxpsn3?=
 =?iso-8859-1?Q?2mNwWfFpFfXE47sjzU5sjkkxpA3xR3Vxd7am84e+6muaV3lgjosGMJYPcs?=
 =?iso-8859-1?Q?rfkQbXfXglZ/D+AbhE7kALne+YmpAh4UbCRQ244TKGsasb+4RkMrB8PJn4?=
 =?iso-8859-1?Q?xXNO2DCLcKP0Qz0/NrJVEKZ7BEzUS7Fic0gfoXB8xSMJZF4KQHueJJAXzp?=
 =?iso-8859-1?Q?1WyazjmJBZIdTXZIZYIfPYww5bSGuEjrxVR270qSzVAwM+Jw5ADPXnRPs2?=
 =?iso-8859-1?Q?s+LqI+0aTA8gCcPyfkb0qXcqDNKijkbrrUiZ9gol0s9+54oqSfe2pFQIpG?=
 =?iso-8859-1?Q?Kzu/rDgIGIAf7zwUZU1KG8tD8S+zJYwk541oUSix1cJL658JkdgVrLyLTA?=
 =?iso-8859-1?Q?RvxsNZ/1HLiJybwtXo0B6VGL/gJ+OQS2vLIABWH85lpjiBK91hnBoj11p8?=
 =?iso-8859-1?Q?XFMZDvIhd5K6h9ahB+dxVYnKLY9W5gnEmjAmM0Kyh7C21R9bD8HvVwi/9z?=
 =?iso-8859-1?Q?ffKsHMpCqtNMlluPbiHc/MYf/xWXEoKXKniHvkE2LbCyAJ/cQ/VzISWGEF?=
 =?iso-8859-1?Q?3YXG7++tMOyikdRRYvlWak5V27lw5gp7S5bFzw/deiBkHyk1EJWBy3w9q+?=
 =?iso-8859-1?Q?N3iVh7RcUb7B4GXRtYsPadc0335nWOoumSiZQUvyqXPVz1hOYMqHGR5lsl?=
 =?iso-8859-1?Q?siiO4wmPoQNjuszfIOxjV82bkwB1AI5f+/Ny8jUWmLK+jOAvIlfh3sXH+7?=
 =?iso-8859-1?Q?GSSGuTkpvhONG7JlGHmpe3g2i6e465oQeadwzZ6MKe29j7AkApMjLhVaPQ?=
 =?iso-8859-1?Q?Tqv/jITTrWIEDh+0X504hjnJWEaas/4LJB71QsmZyjg9/JvqGXuEajcF75?=
 =?iso-8859-1?Q?RzCGDFwUbLqYjooJNLpA4riooZmfLxvXFqrY4bnNE3RxsgU9q4zjEG4W0T?=
 =?iso-8859-1?Q?ahhnkZGuVaG1hGB432hyUusFiWwFpuq6pUe4dV6MK8ZEJbdnz2bvgMtdwI?=
 =?iso-8859-1?Q?IUkSHSNw+vfwlZAc+3VAI6BlPMoIGKJcTOH1zJEyVSxyE7nCAAR4QrpYXo?=
 =?iso-8859-1?Q?SovYy1fIHNHN4cfALWT5zr5Em+VQ1rQd/qzGIzHMGooZoTXcKYbtAojBVx?=
 =?iso-8859-1?Q?gdCh/T+9do0wJfHLNFvsLtzb+Dm3LDesw+v65Jfj6MJ3M1UVS5FgB7eRxo?=
 =?iso-8859-1?Q?/hxLJQY8YfcsaGP3r6Hclyz82kcoagPKyjMQzEvWFMDBVBkrIP8K2IH7qM?=
 =?iso-8859-1?Q?QLQkk1j8z9MrnO/bDtE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eec6d8-e1ff-4788-36d1-08dd524ecb06
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:32.3566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYCgSKcYs+8ObTbOqffyaW9bbYsBYb5cMDNjOe9NbG33aGvkBYAjzd7xt9/OSB0rgqIEfTnBho/SGzRVIyurU+9NcWjGIMo/q+JnCj541fXKSA1/Kp0rSCRzs+suvpZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will be useful for devices that support ATS
and need to store entries in an ATC (device IOTLB).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 29f5d31eef..eee625a9c6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -145,6 +145,7 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
     IOMMUAccessFlags perm;
+    uint32_t         pasid;
 };
=20
 /*
--=20
2.48.1

