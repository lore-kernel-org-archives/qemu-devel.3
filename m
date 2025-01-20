Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27DBC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvn7-0005P1-Nj; Mon, 20 Jan 2025 12:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmi-0004n6-BE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:00 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmg-0000aZ-L4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394918; x=1768930918;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5x886T3s2t0SJOfZjFtnvyt81lof+n12kWsM8oHoRLo=;
 b=Mf1xky4WVrFEQZ4KhDiXlmFS/YlNk88ohNrMBdTJkM66iffSgrb1gBhq
 0DRCQwX+beUwXkg/ekDL2EtiVpcRZNHYt6N77EZmzQHcbe7ZjNlLKj5k6
 wRIkP8+MQFHUoX5qBtNq2PPAItCRBclJ4H4p8UixUlDSqE0J+lhL2eG6J
 2QFVSjdgr9Hi9KwoPHlUFewE801edu5mTnV9Z8txyynYRGYTIzjGz85A0
 pes1er/ERC7/A6KvvZrEQl5b/Hfq1SkT+v3PPDExhMb4ZR6nEP1v74XFJ
 Jur11+zLZmLeItIo9kBZZf57MgA73AmoQjcPZmH/xfpRIEzLaY4vktOBQ A==;
X-CSE-ConnectionGUID: 5V8nMTQVTDeiRYny7q9QNg==
X-CSE-MsgGUID: bq+3+fYsRCml9xsIiC5Fqw==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29133406"
X-MGA-submission: =?us-ascii?q?MDGKnAO0RElry2rBfSfDCDFDmDHYrk+dO1AEFa?=
 =?us-ascii?q?FtvMC6rcKPS94LRtu4Us075ROGM8LjOASbibjE4HrKDoYaU/kMTk1ANn?=
 =?us-ascii?q?vg/v47B1GNyWUWUoyMEemQvMaHS4dk9L8ebF5cyWMnuZe3ILmgySq/Mb?=
 =?us-ascii?q?41IXlrQSsAj4r2RMVxQOqyfw=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TixZPlByYgaEkRRtw2y5iHNdqcGuRSP3EFvOQwgOQaT0OxIXlrknYxLJjPnoJvwr2FWLZtVr+YkIv0CuC6A6S/CkKg3rjnT74VY/bsCG7vTfpWUmEbJuVTC8p0pzAi8qUNKOPM3CnPRGejrG4fvwmyfBgwn1TmN30lEewHwazoZDnqp3XV+oR5fKOIGHG5lwlEd3jJRy6+q3DMBMSYVx4FTCeqgkBo513q233bai4byTp9xYdF5kM7c3XqRTPhvAfNCbPnSGFiSRT5IUQh7aEdQrar3T6ReZLoOyQaza722Ux63QvmCTC2KOpWVSpjRx2h6+TiMWiELKL28j7Sxg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEm+kcr1XmCknek/aj1wwABq0rrHY6adgLyODzgqi/k=;
 b=d9NbuQ1nWKr52n+nXREwORPwfaonybJzYOE+uboIoAaQ1WCB/NoXE4oVagxx4W91LsI62H4XQPxwnqLtffp//0Q1ZxHwhPjn/NuJ7D45VI8d4xKs6Nw9ZRPWTUrGAEiBXAFgCLDctyVDB5uNBW/irg+/XHQxHY7OfEmNg+H3z177ae8tSA390/QxH9JJHM/nnswue2p/lATFSvAdKLrQXcB8/5JdtRzRr7t18EmTqGPuwzQ7/+w1aIsabaOClSyZr6z9O952jtAAdCN3W8siNpSwwHJQi+ByvXQiYAkj+ugzPYUZt7niojxxgIzktZnA7J2daktFw8ZhkRAOfq5dUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEm+kcr1XmCknek/aj1wwABq0rrHY6adgLyODzgqi/k=;
 b=s3e5J3WbB54wo7ivFZsrBhJ6EwEiwa4B3JCw9Jt/l1BPY8EjGLL54nxe3IgIoBecDbVTGF+IRiapjRMu/vlGpAbH7uNI8INwlnSDbGOMa/d24alyHfh2M0u2/UF8uKUO4MNoVxNE9zrsHqhgHWX8nu7l2hk27tR/9wySiq9UaHcAXf3p8WsXMTZAV6c8lv619W7mfRjTT4bDvxlcU70esVlfEMX2JZs3pZE4YC7DLLxuF0qAmrfmYmt/h09+0o0yqKcjeHlRuWc3UEldY1jGIRQRjmGp2hv/hn9Vq5X8WRlE4FYtwkEsN7jExtoYpL4yrKKSDxzp807AztcHMhqLpg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 17/19] intel_iommu: Set address mask when a translation
 fails and adjust W permission
Thread-Topic: [PATCH v2 17/19] intel_iommu: Set address mask when a
 translation fails and adjust W permission
Thread-Index: AQHba2KZ83QXp1EEake+3IoV4qOa7A==
Date: Mon, 20 Jan 2025 17:41:56 +0000
Message-ID: <20250120174033.308518-18-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: f4b0278e-48c8-4d9e-0db5-08dd3979bbe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HCZ5BuUGlUvcA/9b7lUUZs3U35WnTn8TeEMwfwM0Mh4heXGfKVAbfHVAI/?=
 =?iso-8859-1?Q?p+I/zObTGN0L9kHP8xoEso9XsWrR5s2CiTrKjfbMtBa0g47CBvEhQx933v?=
 =?iso-8859-1?Q?b+9OQ+lr36FnZLOwWjhsyzlQsWxRjWq/dMEbdq1sXaQw1apqDKVfGiDE67?=
 =?iso-8859-1?Q?uD2rMd+PFzfJvDqN3aTXS5azu691iyqSxzf7tysak+G9FJULBV1VGpOxQ5?=
 =?iso-8859-1?Q?LMpDCAdp3QWTy320jQXEFCWl4BnQshZyGGX1Q1+CbQ4bZod+3cc3xl7yba?=
 =?iso-8859-1?Q?l822u1GY1JsBfeKjVDwLZgXUDm39SffoYsyeZrZo08tvwPAmBONEBOUqKb?=
 =?iso-8859-1?Q?kd/LUA2FWNI4x1QuRpItIz/TLdZWWMzrZNsbE89RtXOVniWp9h0gucYNe/?=
 =?iso-8859-1?Q?vM29j8UAu+/fR95V5qkJC8j8GYbee7POIhfPllYOLVo40iC6Ts5/Oa4Pfs?=
 =?iso-8859-1?Q?i1ZM3wRRzzfF7L/5BH01FOPOAkfJ1h1Gk4Zr7/WpdbBdU3xSu8ZjDeSbX7?=
 =?iso-8859-1?Q?a7YELNUhZONcpjYi5RKh81xZq0FslA5m7wbTXF15dHN6G/zLGfn0MwlgI2?=
 =?iso-8859-1?Q?WZfNOC6/X9H7IMYJG+Xic0MPxfPgYh6hgy6d1tNKMINFXZCDp45JysvjTU?=
 =?iso-8859-1?Q?answESXRvPXTWqElxrOTDpP3lsZotWKT8+jrVI4KvbJ1NDIGSeN9ZC4BBV?=
 =?iso-8859-1?Q?Z5WZ3CEeNw5bxgDnNvUSITL83lRkPLmkEJw0ufArDJUM5ygTsvObp35iSq?=
 =?iso-8859-1?Q?x2YTMIYP9jC3oAryUzFYQZ1Yx3wW7rwG9ItT+f81clPC6As4qXVETZ6/ui?=
 =?iso-8859-1?Q?aJ8YjZgAULi3W8jn7Tm57iEeb3r+QtD0zRBcyVqQJFopRXhal9pI+ScBn5?=
 =?iso-8859-1?Q?4gcXjcV8ijXNT1ZC1ktIHuFft1yg/xMXTyuzhkkyAMyQ4geVaFekG1Ko2/?=
 =?iso-8859-1?Q?JjadFwSroA90gU1Ejvqp9Gn5KRfxdMsKx7YK7gfo5sAr15pZ28o2x4kWWC?=
 =?iso-8859-1?Q?P7Ih3Dj9ngrvOcAh1jVttvsdY0s842hvB9roYnlSyOOGkl58n1IspHDABe?=
 =?iso-8859-1?Q?nLZQkZwl3xDE9o22uVnRuyrixjqMj19msRS2WeuJGWzfNnfHxhzWgNZfiH?=
 =?iso-8859-1?Q?MWX+RRztRIomy19k1Y8x37dYN0WmcwaHxjmv+11CglH79ww1RGLjAaz2dI?=
 =?iso-8859-1?Q?6UXqoplV+8xgpdA7/Edkkc4BjVk0ylLzoWSXz1BV0PAjDpshcHXdmt6/P9?=
 =?iso-8859-1?Q?xNXWodOYEOjorsWmAQ1HsNGfRYKMPUwA8wSAJW7A7v42O8zPvRvbZPvzKI?=
 =?iso-8859-1?Q?AHLPyy+PVndIhPe58CfN0Gv30M4kRaQ5aSnQhlto08Pi9fPfvQrq+2KgGo?=
 =?iso-8859-1?Q?FitAoGhKMCC6Kg1jncHExB6n29QuHMHH+dn1TOvlxAhis5vm9ztgKYMz9N?=
 =?iso-8859-1?Q?Aajn9olKlJqMt4PcHqoriqzEaO8qxQtMwxAzskMFptIAJKWczQZwlNoTtM?=
 =?iso-8859-1?Q?VimShSjF+o0uK3h7YGHmCZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pJP+cjzXYwTbKTj2eif5uDRhpXvrSApGlG8MfcXPG617m5lcDUmpu7ctOt?=
 =?iso-8859-1?Q?H1nrFqwglDAST4qD6qNAo+FDLRz4+GzdtbVTxYywcfmgIFS0lhVddgjmiN?=
 =?iso-8859-1?Q?RvfWFLewcpd7mie1xxSu9kZPkI6NJ1b7LezoFauhpECYfNTYTMl+xCYXEe?=
 =?iso-8859-1?Q?82BzhtaIxvq/0xsAmnveMA78NVH1CFcJDPKfz6EChX+mZVyyR0O7tYnUT8?=
 =?iso-8859-1?Q?FFffo4PN4RiLeCscYf4rceMHk8x9faRw/DP1piLiEIwUWshAfSHRWUzsiE?=
 =?iso-8859-1?Q?u4RFtA5CrRifrZ5pvGvrP5/WywGc+sAHC5v0x/rlJeJoigQYh3FqRowehE?=
 =?iso-8859-1?Q?oVv4nwmHH3gpQIpm6wyup7vAKiuaNatuuLuAnoEKQe9LnL6ZLJiPPkZ6+0?=
 =?iso-8859-1?Q?jSTCd7NMRjDpbMOkiQQ8ZJA1FMOEjIh52Uqt5CGJi7QvU2u0nMCkC5QSug?=
 =?iso-8859-1?Q?zDAsQYQZg/hV8gDY+XbaL7EDThXqmLIIogUg3xOQRZEkovSJKtLLFU5LOn?=
 =?iso-8859-1?Q?13bUl5g+R4GC+/n6D+KqipnqVhpGzBUqP4nuk39hh6hq1fdtjB/2MXv/HK?=
 =?iso-8859-1?Q?F4QlnLDNUIL/olrZOQl2lRwKHpYNCEu14DqiAmcP5PIfu8kXweLxLWQkCm?=
 =?iso-8859-1?Q?/24HVyOTFT1lp1qjLXOsXGGAuy2Z6YA+3uN9kLyNV5I4S7v7QUKukI6Hig?=
 =?iso-8859-1?Q?/kYOHYMrDYLLhKme9MhOpIUrKuLbxee2WtybzjodGxXY0BJWSqJK3M1Gj9?=
 =?iso-8859-1?Q?Ej0y1jRw31NbT4wDgHzVLMrgnBvpld1d7i57nXOb96sLRqMWe2dgUhd6zZ?=
 =?iso-8859-1?Q?nO/Lf/aPBVVORe64T/XEkLR3oR7eGYG6vRmji+giTXWzDR6/fsOamG/esS?=
 =?iso-8859-1?Q?QLHq2rp99OBJluUvIwqUQm7dlmPFJ+c0wp1J2LjUCTIaYRQtv4YJnkS0OI?=
 =?iso-8859-1?Q?c5FL5NWOheSor/5Pe/tvn7TGfD3W/4cRYIRe+7kY5WZuYBrdBgm6C6y1/y?=
 =?iso-8859-1?Q?sHrJdtKtmG3/yZp78OZdKSE9vGqixaMl2mCPPuDeBke76UtEB+MZZR9qvn?=
 =?iso-8859-1?Q?2jHOrGuMryZkaqdz9/cUhGarKLIwQ3DkZMyY0Fgn/AVS1+cy98Na/kB93J?=
 =?iso-8859-1?Q?Qyt9WZLi9Rm/W/6Pwr/b9EsewCymPWtFGDIOyEJKmMO+oYFYCAnOqqYaJN?=
 =?iso-8859-1?Q?mMqU9/2k1QEF0JEQUqVX1jtc9pg5T4dWXFgsPYzScFgcd7Xp3QXU7m3HNr?=
 =?iso-8859-1?Q?P03T4223bthuELz4F9SMWBuOfYo9nvKJpWQJNV8fcokPihwVd9MXG5jCqj?=
 =?iso-8859-1?Q?RdjneaVbHPtfrG29Dwe0hvHYACxT614dOqe2PFWJX9luPTSF6HOTYuEGRE?=
 =?iso-8859-1?Q?ZO+eDY5zcmKSfnJnEH+9AdoH8u+rT95vJUVmYqmMuR2zjxzzlT8tqsglw4?=
 =?iso-8859-1?Q?TnhD0RlOoYN6+J9dpz143ro9kK/xZqoBZmIjn+R5WPIka34wuBsXN6NZZX?=
 =?iso-8859-1?Q?KVN2lQjO+NGWhmK/ZZ5Hor+Il4+vXGMYSfZW2RFrinD3u2l3D1yMxdRu/m?=
 =?iso-8859-1?Q?rA3jUo0coLy5Sqg4wvPZa2C8O/0b/BI3U3AjQX9YAG8BxCTRWzrS4b0wJQ?=
 =?iso-8859-1?Q?2k3SzaT4GHAitQ677oO0RAVUhuBhOx1kWwlVvuuaQXbP31CSpnxZB/DIYC?=
 =?iso-8859-1?Q?4StOQ0DSP8rzUOopww4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b0278e-48c8-4d9e-0db5-08dd3979bbe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:56.2209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCGtV56eV0QeGxZSGWA0VMJ4iBHD/ztWCMEU7AikzqaAJLMofjIOw2nnVdH4P7muCb7MUxu9SKCpxv7ER+rxYN/cLCxDryydbK4+aKxFpXw95s7fff0cFEJDzHLzG02D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.036, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Implements the behavior defined in section 10.2.3.5 of PCIe spec rev 5.
This is needed by devices that support ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 021834c41f..530b75a9a3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2100,7 +2100,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
     uint8_t bus_num =3D pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
     uint64_t pte, page_mask;
-    uint32_t level, pasid =3D vtd_as->pasid;
+    uint32_t level =3D UINT32_MAX;
+    uint32_t pasid =3D vtd_as->pasid;
     uint16_t source_id =3D PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
     bool is_fpd_set =3D false;
@@ -2259,14 +2260,19 @@ out:
     entry->iova =3D addr & page_mask;
     entry->translated_addr =3D vtd_get_pte_addr(pte, s->aw_bits) & page_ma=
sk;
     entry->addr_mask =3D ~page_mask;
-    entry->perm =3D access_flags;
+    entry->perm =3D (is_write ? access_flags : (access_flags & (~IOMMU_WO)=
));
     return true;
=20
 error:
     vtd_iommu_unlock(s);
     entry->iova =3D 0;
     entry->translated_addr =3D 0;
-    entry->addr_mask =3D 0;
+    /*
+     * Set the mask for ATS (the range must be present even when the
+     * translation fails : PCIe rev 5 10.2.3.5)
+     */
+    entry->addr_mask =3D (level !=3D UINT32_MAX) ?
+                       (~vtd_pt_level_page_mask(level)) : (~VTD_PAGE_MASK_=
4K);
     entry->perm =3D IOMMU_NONE;
     return false;
 }
--=20
2.47.1

