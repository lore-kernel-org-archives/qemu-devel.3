Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA33C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmZ-0004XW-T4; Mon, 20 Jan 2025 12:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmT-0004W9-SF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:45 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmQ-0000YO-99
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394902; x=1768930902;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OxUnyvW9zBQ9FfogOiHdNv0//4oqMEtExS+PO4DE7tc=;
 b=Wa7ZcoGlxP/fZXMO54F1r/FNmd2YQdGPeBxHWm/L6xxg9RPk43tgI5gI
 PRKzSojT80ZYs0jeBgx/Y1DaL3tCPPm0Jwdk6Xrap0TJ6pS9Lxn+UoRQT
 gvgt8m/yo4/nRdiMYWoMXn+A0Q8Tgc0SqnKqA+7I1rupbksHiObHH1k/E
 wmbhTA7os4u5ckfpoOjIB08lmUfAr7+NFMuvjqFgkPXCZYX20YHDahS/i
 8TIJvBpbFP1vGa/+yS55YB4Nl1xvIVQt21FEupYn+0AG+/J0RVGfaKJvp
 2KmmE0MeY/6OEPg01OIXM5oyDqJ5VdkeXWz+/tSMlndPc+Oj9I8jGygf8 g==;
X-CSE-ConnectionGUID: SMLwsgFFS3ewXGbJFeHmOw==
X-CSE-MsgGUID: gweK18bBT62IFV9YhHmfyQ==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291716"
X-MGA-submission: =?us-ascii?q?MDFDmnptiAhGjY5mq+shaQt69PUjRRYcC6pBDB?=
 =?us-ascii?q?MnrDi2jMNRa4pg9PU7LK88ndkBDtlgMFsazlcfacx3G9ZI2hcBL39D6F?=
 =?us-ascii?q?KLhbA4eYYbgFedlwvubXbIqRbH9aUwtGovpUOFxlKs/E3uz7WMNEDlcC?=
 =?us-ascii?q?jVpDtQIh/G901E4atgTnMNhw=3D=3D?=
Received: from mail-db5eur02lp2111.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.111])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:39 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsOSHTO+RV3YxHyM56NPltitaYoktj1YC0aClDDfQ5mKuEWjzCOln3282wyvj8x12/Y2x5YebTrAG6BmkCPK8pbl4N8fgBktG9LO0wuquNl5HlyZ2fwtbFpdqguNvsRkTH20KLy1JDP2LhIwr3KM2cYXLTdvIScj6A2NYp1OLIPznJrkBE2od0hl1tMsgMvFb1rsDHlqLw6F/Us7BtEz/8DvJC5rpeOgS+wjQAdI7pXGxcU1PLfcCFOKujOBIbrBjtQNpYydPvNNpyjCmf+2QN86y0GiIkos+gYareP99lapVjwZlvGjVD7G6pvzJyyzR23g4vK8WARoDYX13sF4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpX0VUIYzldTTRNfMbFoHs+MfYXfgrsOMotxAkNQZ+w=;
 b=Sfbtm55rk6RWw4w/KM1KEHH2hW7mSGvnYNaBxhq+BTCWE2XYmWaRkEZpeSuJ3/USXzqWkspiHYPqsdpv+C2lVxqIvQdxqMr2SpqSojKOE/PmVVikPZWKvfBaAL9ElLODYSecDOBR+xwFxDsrznc802cigYi8yqwf2SKBw45Ysqzz06+zhGmb4JNWpGkomEN86mBVF4pyA6vzGsiJXIbx6BcA1khGDC20hXAbGvdsqYWkhezFKexnW37/kW7IYb5aL8O2d3k+2rFR8tIreljvtLTz7efczY8YRLuPtFCRGz/8TCpSpW8JwBBKTWuzMCggyBtRa+TIKnE4rG11uXau9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpX0VUIYzldTTRNfMbFoHs+MfYXfgrsOMotxAkNQZ+w=;
 b=tBSP3yBuLI5/qON0XvbgvEKZGBnhgQwHXhCWF6NWJNZ/2FTYhmzzQ1iG2ybHF5w33hnOstPvA50SFqvJazbLuG7mu0D/4op1X6WaEJKDbBflsEEuIwZjpzo5jIF2h1jl/uwjgKZIze29B2mUTSOp71cgabOi672aRbIVEkiGBgjoQGJ1Z1kqO6sD6R0HmHSQJS2YcCvJvDBCzavsBn2spn+LTU77BONF8QFK23zDpecOxBU3ExD9XdxysV7b+WJfXq65Od4crAR2ssf7WQKo5h3AhrlYykKlAQ2Lq4WIxR17VnGv6Vj3mvaFopsjxv3FIdAxlNPZLARbkAFQoBZ+rw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9869.eurprd07.prod.outlook.com (2603:10a6:150:121::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 17:41:37 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:37 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH v2 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Index: AQHba2KOkVqnr+ry5kun121ROC5Drg==
Date: Mon, 20 Jan 2025 17:41:37 +0000
Message-ID: <20250120174033.308518-2-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9869:EE_
x-ms-office365-filtering-correlation-id: c7b13164-4008-45fd-1bb0-08dd3979b0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SE5YF2Uu0mPgiw0xKayTEAGDOHjQwBJrZZ0HJFHvgQL7HhPNeWgG2FsrCT?=
 =?iso-8859-1?Q?I6nFPBWjRpBdwCJuLLmh/pNXo18VY0bJa2+jT10+y5hZTEPeNP1eE+f/Ih?=
 =?iso-8859-1?Q?IB7RncBxl45WyFmPXC+7Qgsr/UIUG/DpUVsAS0Uig/3auzdBfea6a+2WQI?=
 =?iso-8859-1?Q?+4q8oa3Miasrq0T/sdZGiqWUsJnCjRuO1Q4jhCTZPcgqS2V74aHGWMipcL?=
 =?iso-8859-1?Q?ateePTcdVykpNYTlKwElj+/uUa6ephchCX/0xpurnttS0tS485c4UfR6cT?=
 =?iso-8859-1?Q?WZIfKMYr8fHkmFBgZZI7wah9z10xVJl/usgDq+2ONScWLdQVQlj1JNMmyG?=
 =?iso-8859-1?Q?BKhhev+wJd+2vhoJtLPQHfvbni2c4eVYKYQ6ku0MFf8GstyRWSHnm/q7gG?=
 =?iso-8859-1?Q?b7/JI9mRz/5nB1NFJR2Il02VycSGc+M5deSVVLzmP4CaHB2YE3yTQAE8u3?=
 =?iso-8859-1?Q?MfxvOzd8sKYy9j00q5CFZqoZb2kmz4Tk/cOrP5ek9GnvF+kjEEGX23EhFD?=
 =?iso-8859-1?Q?9sNzuWsOdd+v6frQ0sSkRkhhBb1BauteIICofdJznP75TU7YF3fUbSdOkt?=
 =?iso-8859-1?Q?K+zFhoqfum5+wyXwv98OIOd+DakxTz7H6tEWtBUuLTjdnl+ZmdZoTBgnda?=
 =?iso-8859-1?Q?enIuTz5YuB03GtmZN3p4geNw02lQayNWHlKPUUYT1PfLsZYc/4HT6SVUNI?=
 =?iso-8859-1?Q?KtLje/suf4GV8cyVlzihtjxnSNOlke8jZsI3fQQYzV+GQB+Hjxpt5rNwjc?=
 =?iso-8859-1?Q?ZfCZ+C1Db+1AerOJj2AeS7F4MybDlkMksVQ2yLllC8X139h3zzsxJo40Sf?=
 =?iso-8859-1?Q?cUxjPfeoxLW+ULTbOCJ/ThROgzDTbz2IFkDoU1JTUoJQWpgeuCUoIK5bdc?=
 =?iso-8859-1?Q?S9N0WJHWfp/pIyox0qz96TG9vvm4hAJu65hCGubMi+nHYcIyqSwpiQPwN3?=
 =?iso-8859-1?Q?eNoBA2zCEyQaUZwzDpy0fkhDRs7vAnHDcTDNlNOrna+C5cMWFV1v85Oz9r?=
 =?iso-8859-1?Q?DFVoKB3Q9zd4iwbWx2xT2HtCJIQUOzK6p1urm8GvWoWLJ+rL/6jITouWtQ?=
 =?iso-8859-1?Q?JwCYSQahR98vHrdaPYISdsq6H2hZwmWIvsnDZSdtrxp22rpKEg1BbZYQHo?=
 =?iso-8859-1?Q?C/xY7n+9fqBTGlN7zEiSIppnMv4HYOVH2Ib1/JjwzmCmRIbC65A0Wqi1uW?=
 =?iso-8859-1?Q?Yjcix3m4DZh2OlF3UAa8/CiKIIXq70GlXoD+F9BN6NCPM30l96peHhYetH?=
 =?iso-8859-1?Q?/8haDh7lWJK3A5YJCxXEMpbseD81vSYXEXOdaRdPyO4gb9wU0pACmBmZET?=
 =?iso-8859-1?Q?xqhJstGPYjriF9H0EqrVo3SUOGKTEJc/YBQaLUHdntFhQqGXxHQK1GkMTy?=
 =?iso-8859-1?Q?fxw11NDpsr3AYEo2AXbQztbUwKHsJjDqMOOIn0R6SU+v4OfmVlQ8UP/f3k?=
 =?iso-8859-1?Q?u82RHbe30pHTsofTucVMfo81wMIrTNvnHDLEfPQ4OS2t98ydgdKu8GjE9r?=
 =?iso-8859-1?Q?m0xJgUxZHmDiPEJsRyVCKR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fyIT4a2ORs+6lEgnPOUHIPYPa+hX6NlGZVaXSCsa+JDHEYwQdSDYXoRp9C?=
 =?iso-8859-1?Q?kI4rvNmpN9qF6A/InO1zOiruaqTFdxRkVicdof+v411cKcWUp64LTIefXv?=
 =?iso-8859-1?Q?mgzP5ez5zrqkCxrbv/QwHPiqbbM88fLtwnW7nGqhXgrWC6+io1faKblnAW?=
 =?iso-8859-1?Q?Q6c9EOgelcYMK6e/fii7C7kbx3MDr7dCxg5onIuHsdgMdo8G507md6m6WC?=
 =?iso-8859-1?Q?zHvtZZX/kSWgFRnQ/+ChkG98I9gSGjQjVSzuJnVo+OH1nNs5pK8BvGpAs/?=
 =?iso-8859-1?Q?/qD64eYvlgaChVjkUrfGdj9oikYSZeWgSEJcnLC9QLVocJPoI7HrpNe3ft?=
 =?iso-8859-1?Q?CA9ZtVOACR8KTy9O0z4MJoErajgO7X+QHojHYBn7yLp02ku3CG/6BUvr2g?=
 =?iso-8859-1?Q?pMjQBgntNP0kkb9aW93i0+DuKPAoSuaeYw33a/63ApEWL6vjdOne0lQaos?=
 =?iso-8859-1?Q?J33e3807/rWjjyJlvhfiC5eK7lHkwBeALrjzdTle+hrwOK/fJyczNE59Zj?=
 =?iso-8859-1?Q?HB9wbj81bakC1cpK+Wlp9iYwEfrcZO2C+Xrg5H+uttNovV8zHji38WInRl?=
 =?iso-8859-1?Q?mrY3yD323D4juJSVCXrVNOkc2CGE2c8kOJ8d9VuPhUFFcJG4Y8W6JkXaEe?=
 =?iso-8859-1?Q?B3aEn6ovTeAaGg3Y4CHLg7UWLLL2Eh+yhRq5jPoDzDlLIAUgBBm02zFLET?=
 =?iso-8859-1?Q?QL5JPGE+uF1iz+R+NbLLK38Ta9j0SyK4dp+nUjgM7kheOOAmMFqQ5PzCzG?=
 =?iso-8859-1?Q?9wwZVB4o7yt0BMn5jFnhTJ4A3ZtaUTy7/jf8C2rrsmZk47zf/Dxk0SeNQw?=
 =?iso-8859-1?Q?ja7amRVyDr5XwG7FXPBY1zyIV6wPfqtOFBvbZ2gLTYwu95RotopQE38nH4?=
 =?iso-8859-1?Q?E3RcX1q8bZ8W1eXAim3NWTe1UeB518eeNYNxw/ZHgRFLa05MiffXQHpIh3?=
 =?iso-8859-1?Q?Y42xZfA7m817V+xeeV/grj9iIL7ArX3ZRgo/9RMA1mLySgwucTM8baq1OU?=
 =?iso-8859-1?Q?2FNR+PCOthXEqezjRsrwyJH35al4EDSuUiiGLF6wK+uaiILg2bSL3RDphq?=
 =?iso-8859-1?Q?fORi/4wqig7D8XkZnS3IQgJ4GC5GDstqrFvDGVdyQSI3J0EYro/HAIpiH/?=
 =?iso-8859-1?Q?JxTv7I01O/DzqrkEYuA1rV+Vge/kfd3ad1/i4PPmHpjSc4cDOKDKEcQDK6?=
 =?iso-8859-1?Q?HdbW3KgVWnY7rF2GmQk1GA5RR3jrmu+orPT76NRvRRHn18+PXnGd3BTVsG?=
 =?iso-8859-1?Q?CymA2VLkWVLOpJ3rRuJX3HAPdUzMHIS2D+gEnLWS4eWKGty+H3wWfLR5Fn?=
 =?iso-8859-1?Q?T/Y32yBwk5h/DsJf/d1AeIlJ5PNe+K9S97ulnXT5WI0irIlsd/j/SB7BC5?=
 =?iso-8859-1?Q?B+isK1ATJCcl+B6T4pI2DGehDlb3nFEjla7HXopA9XRXZL3vHW5tfakDDH?=
 =?iso-8859-1?Q?D4gIkIZS1t8X/XCfLt+sqZVtDnh+kWjD2Y4pqyd7z9np9MhWytpcx8Ozhn?=
 =?iso-8859-1?Q?hzQB02wIIXG9k87JsEcaXjAv9Hm7TtmJEZm8ssEHnyqhXBTCZohms9rk7L?=
 =?iso-8859-1?Q?pvTGUR+yzp85hkNYsOpiIMfTai1HJEPKhIZpEHcWG/RPorJZAmcPyvweCk?=
 =?iso-8859-1?Q?b31CUIJslEjQhTwMDT+fsYA2pr7PAnJ5YesXStlmzuox+9zs15QQmn+duT?=
 =?iso-8859-1?Q?rtJ6ZKe6kzlQgJMNosI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b13164-4008-45fd-1bb0-08dd3979b0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:37.6014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snNOdc6ux6gGzjlyatD8H7Sp4wlgtJ8O1k62ZDZQqXwu8e47a4yUwNp6tU1YtBLJNuflZ+1rgtqpC/LMt4UKUYhZqAZ/gpV4QR7C7yVuvvyLJBEnQnJSemRjwN8wb7zx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9869
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will be necessary for devices implementing ATS.
We also define a new macro IOMMU_ACCESS_FLAG_FULL in addition to
IOMMU_ACCESS_FLAG to support more access flags.
IOMMU_ACCESS_FLAG is kept for convenience and backward compatibility.

Here are the flags added (defined by the PCIe 5 specification) :
    - Execute Requested
    - Privileged Mode Requested
    - Global
    - Untranslated Only

IOMMU_ACCESS_FLAG sets the additional flags to 0

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3ee1901b52..56c3a3515e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -110,15 +110,34 @@ struct MemoryRegionSection {
=20
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
=20
-/* See address_space_translate: bit 0 is read, bit 1 is write.  */
+/*
+ * See address_space_translate:
+ *      - bit 0 : read
+ *      - bit 1 : write
+ *      - bit 2 : exec
+ *      - bit 3 : priv
+ *      - bit 4 : global
+ *      - bit 5 : untranslated only
+ */
 typedef enum {
     IOMMU_NONE =3D 0,
     IOMMU_RO   =3D 1,
     IOMMU_WO   =3D 2,
     IOMMU_RW   =3D 3,
+    IOMMU_EXEC =3D 4,
+    IOMMU_PRIV =3D 8,
+    IOMMU_GLOBAL =3D 16,
+    IOMMU_UNTRANSLATED_ONLY =3D 32,
 } IOMMUAccessFlags;
=20
-#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : =
0))
+#define IOMMU_ACCESS_FLAG(r, w)     (((r) ? IOMMU_RO : 0) | \
+                                    ((w) ? IOMMU_WO : 0))
+#define IOMMU_ACCESS_FLAG_FULL(r, w, x, p, g, uo) \
+                                    (IOMMU_ACCESS_FLAG(r, w) | \
+                                    ((x) ? IOMMU_EXEC : 0) | \
+                                    ((p) ? IOMMU_PRIV : 0) | \
+                                    ((g) ? IOMMU_GLOBAL : 0) | \
+                                    ((uo) ? IOMMU_UNTRANSLATED_ONLY : 0))
=20
 struct IOMMUTLBEntry {
     AddressSpace    *target_as;
--=20
2.47.1

