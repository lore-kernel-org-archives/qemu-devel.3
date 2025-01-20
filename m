Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87AFC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmd-0004eK-6H; Mon, 20 Jan 2025 12:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmc-0004c2-3f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmX-0000ZN-O0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394909; x=1768930909;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kX2S2fq6b8D1k6opTFdMUw64SYd+sruvzT3Q+IJnIUc=;
 b=ImoQRL6ArGGNg9oBVcfI/8rusnlpyHrup3pP9zxEYiyNHeXXw3cuMGvm
 GAKIPRXEdzxyPOUsFYrNoUXhclKXHqOryQ+7gBhv2iOIQ8ShJxsruxFVo
 pb9luDshSmJAJVaonK/jFvdGsYm+RmFV+pnbTOVF5eyuBjlQOP8uCBM8T
 kEo2EyR87Z9j/MQEhe2YWjSemTcYtXn44wTqrKYCJrOv5+rJAdHJHHFWO
 2xMN2RVx75VmExQhGKSEwzGVezieiBbHAG34ftdR01zxp+8sBVwoXcDwn
 +EdlPWYZBU9P0ED/KVr+9y1MWfy2NmRBatIS/IncnvujdIA8nPplrEtXn A==;
X-CSE-ConnectionGUID: L/KexgJvQNyo7sgych1f7g==
X-CSE-MsgGUID: I4Jr+GR9QYGKqou3y8PdSA==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29133395"
X-MGA-submission: =?us-ascii?q?MDFpzbeiaUZhiNazcwuLI3kO2akcxy7lRnst2o?=
 =?us-ascii?q?85N3lAhz64BtBl4rvRz8Nwv+iwJRFxzx8a5D2RsH9i9d6lszY2pDxwz/?=
 =?us-ascii?q?pFxt/fZ813swOD6KTvJE0FqladSvm7xEuTB8luUVx1/W0egNGrLsFnhi?=
 =?us-ascii?q?5C620eVMaWP/hYxNx4R5379w=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQo9+Xt+BSfjOXP66x7xNQYInX6dHTMctrbild9vsMCMoYRXeD7JH0v0qCdTqERjNLBmh+YkZj8BU1oJkPSyutXdKXKwOx1YUlOPBpVyVsNlDGl9n6WV8XGVYOg2+E01kP68g17rv3Cp2PBAFYXrtYxzzuAFs0SfO9xhzip3tPcd33rdj4RsOm83WpU/eiIm5lwLSlU5RxuG2jcgC0nQBbwRPdo0zm/BaxIP1msSC20hv0kIlmW7uP+WPBIrIhhQBEHy++L8KhIYRJyoZ2ypiLAAJgC/JDYE0eqeFiEjOF2gIpsIoMHYxNakpDtZmjK6pdt/NLkrOXhUitHS14ijjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iflbwMKRHPu/81SZW+ngwd/GXI6yY0hn/LYJYOaw8bI=;
 b=FPoewcIsKYLgxBllCZ0acXxIxM/tMs82EvDNAFBj+qBe7XQOscEtgxrklk2I/sIZMhhC3rx8H4hucL9+SexAbQJC0kfZ2dKMjrZuQ0kKnTYTWW+2kV6PiDbm4oayI1LDeJqWr5bEARe9Ny37OTathm+0qJitP3IgrCeO5eAmDkU9OPN9JSzj7FNUV2d5u1KhB2CCUXYokobhkod1D5wEZslfJazk9feupaIpi3wlPX+QpTSpKs2rKvUJmI7Ql6hFM1RzHfpy07upBfdbJx4RW4z5pPZnBJofywhFUqyieJpEb4baJpSMa8eF75L8AeGHektVp7pZQtZ6WJaEAS+mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iflbwMKRHPu/81SZW+ngwd/GXI6yY0hn/LYJYOaw8bI=;
 b=sk8a+oeoBFAamxRmMCgZitambQNTvVEO1lB+bqYc0kvsJ+nnFKWNzAfw1TbeuZutAjGptYKdEpub3mk+szgs7qyz5LmYaNXxP1nPDIoIgjDFu6tC9g8B7Cw4C9Zdx6FfyWlOfO8WxuGJmlFGi3H/ko7Lhuka6Fpe6aF6XM2pjiXKdB7IpFP4PJxl2soQZLqQqdAin05g9Z/bh5yy5s958bz3n9dkWgGDdf/L9cbPCo+Caq5VcvDc0boSdLidUEYN41fS2kTqK6T/gV9bdbaCOUK1WYF76V5vc2tIQ+loVSokV0UbrJQmJFdozlTvJS75P2gLIQkRMHTDNfpbwhwP0w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 06/19] pcie: Helper functions to check if PASID is enabled
Thread-Topic: [PATCH v2 06/19] pcie: Helper functions to check if PASID is
 enabled
Thread-Index: AQHba2KSYJRjLgZTYkGGJ4ezUhqhcA==
Date: Mon, 20 Jan 2025 17:41:44 +0000
Message-ID: <20250120174033.308518-7-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: c8589477-c3f2-4c7e-c212-08dd3979b4e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ciJLkcap7W4WB9tsxT+OwsRU8lmmotqSXFQjo6h4m0lLwaJ1Ha3/Efp/g+?=
 =?iso-8859-1?Q?iS9cyKe6fT4WxABbOP7RIVHcvk3TGl2bLo6IEAqfLvBUuXm7Apd69xCYmM?=
 =?iso-8859-1?Q?UOsyhdQNrd8EBAYa6kf4c/ecN9Ez4hxd7ofSCRUy2xJqA2am/rQkWip41w?=
 =?iso-8859-1?Q?owJV64giNFsNX/1LYLQnDKKgFaTw9W+tUOU4QtqJNrw14cKNYS7gcEDzV+?=
 =?iso-8859-1?Q?oMC2nXo2oP95BP6YdXwsiKecjcwpkdiza4hHF80d8fnJBL5lK3Sdq+G8eu?=
 =?iso-8859-1?Q?ZKJUxQ4J+NkcBIL63Mvt9nAexEIbE65eyb2SrXLeiFhE7pqSt8ddcbnufa?=
 =?iso-8859-1?Q?Nh5JBgaO0u9MD4Tr/QGVnWVue5C/d9dPTDpCVacGniqxmeZ1mPXh2WDcma?=
 =?iso-8859-1?Q?zv6xb7OjElhkj7pyxnAxJa1X7IF8p4Mg7Ml7qtcmstSefGHe+arkJ4XhXS?=
 =?iso-8859-1?Q?oOM+5zcV0EQpCd7+Whh3+Gw1kTTztdkNXrhoTfT8k0YP/K8g1p788X+n30?=
 =?iso-8859-1?Q?G7/wivXl+iNtvS5v2kiiNWBVQQUltU4XX1Glw/zArWANT0n4NCUBPp6vYK?=
 =?iso-8859-1?Q?WpEtnUAexOoMnkyx5EReDeeb0BWv+NYRLVJHZDNniCWHnCjHmrcP1tvXBk?=
 =?iso-8859-1?Q?IoWK8ttsNBG3NLRvndtdUtWlEQmtAuxJBgG9P3wkKyE2CzOKq3EsPBPj17?=
 =?iso-8859-1?Q?rH165Lf36Lb4k26CnsM+FLQMetXA0rUjrh9jb6+LL1guH1ZemVO+kl8Xht?=
 =?iso-8859-1?Q?tcG81AvmfmVfiSxaiiOkZ7p3ealKsWDlByAalE29KOaqISQmvp3gmVJ4Vv?=
 =?iso-8859-1?Q?O3Ubzn3wNuRWRWCCg6zuT9St3oNNwdeQ1UrG7lh3glb1c1UgxSKjCvSwRr?=
 =?iso-8859-1?Q?jVHyDZc9mu0KAgCYgT3Ot8BQAYkylvOFFWYLf2Mw0JrU0PjzaLfjocOobV?=
 =?iso-8859-1?Q?Rx8V831EtSkM4XY+4Z+S3SokCdBA6eNhCWp2mcvnhmlFRe33h9Gatr+Zda?=
 =?iso-8859-1?Q?smLPsRTOIiVSjwK4QHuOb7Q5EQkCs+LKtVO7E8N9rEFc41sLNUfMQ0Vkry?=
 =?iso-8859-1?Q?q+OMncHAAv0YcGKgqa6DV5wHm/TVXR0jjv2cp1ThrxQwgYPpxiBikdfSC0?=
 =?iso-8859-1?Q?6buF2cw4hJPRPJGZ48Owdd9UOnns10zuNtcPQqdMucvn8ZB1G3THgEHbQf?=
 =?iso-8859-1?Q?n5v5D3XOAtOtN1jHGlWtEPnkmmQjru3dkgS9w+np6YSTv0jIlkqhzTo+Y6?=
 =?iso-8859-1?Q?EvADIjd6t8Dy3dqOzjbVKnQ/6ykQzpHthrsiqQeSa9L/DkqkiflTHvVj9B?=
 =?iso-8859-1?Q?aqxuCYGOey+3X8G0bENTO2qD1ulV7qJP+qk8rVwDVUz5/npra1/Rnpkqux?=
 =?iso-8859-1?Q?aHEewD7RTdjUglUWQanicVEXPVhMPvVbYG6oIqChy5Qvpv6R1EZ5+FjiyR?=
 =?iso-8859-1?Q?7CmjYZ1n5XOb8LUrTNYZ3zAhuu0hVo2h1qMCW6ttVzXapVxyiR2oXDBJpS?=
 =?iso-8859-1?Q?/sEYr5LUuSAqsc+ZKmrl92?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xTGv2G+mzmekMvvQ+F4HG+C/I5/bRIp7XcdcTygvRYVdyVEL+8OTWUTafb?=
 =?iso-8859-1?Q?Bm+KH/BpsZ/7KrtJ/iVNujz0uPm7Hm4pIH7OGAZYRw9G8gtpy1mXtyqHlI?=
 =?iso-8859-1?Q?QZGsB4GEBKI/a4GENc8Tt3/RS0jp5Pfqs8bSIi2frM2y1l9gsMnXKUk5E0?=
 =?iso-8859-1?Q?syn+J/4c+OS36FuFywUCXTEaPA9kV3bzc7XBAbfomv9c0K/BmHElhg0xp4?=
 =?iso-8859-1?Q?3yDttwb5keALWPOlGQeKSGFkn3HZwNuZ9T4bwk5qtAZXVn2dwdNCYJzuVP?=
 =?iso-8859-1?Q?RaiOGEQz+OdPIDDcZUazFfT/FXDhnPXRYTIjFxqlaOVoSvNwzpAvrTtRnD?=
 =?iso-8859-1?Q?n8kSAoup1ppawFiz+7KoJU3zdX6DIIaYcddm7AQuMYIISiiR0I4ldjU4Oe?=
 =?iso-8859-1?Q?6C42VsCS9R6owImFd4hJChTUlndGkvS2OaU1BlL8Bi7DUtWtuRxs+S6m0h?=
 =?iso-8859-1?Q?SDFiBWm9uQK2wJgRzkxLu67fHouItfNfhFqgayV3ZYqSvLxEDN78KGlSjb?=
 =?iso-8859-1?Q?w3No3IVv0rBMF4Ltk/IORxqVXiB+wBw/sLD42v7KycfOSgUMltibTgwY6k?=
 =?iso-8859-1?Q?210nOaWNw/wZGyuN8NtK2gIaYnNI7VMlohT5tVOI5qAhZjguUy3FBfU2Yt?=
 =?iso-8859-1?Q?hy25UuKE5MEgACdkLIw/VdPPfS7aN8PVZJ3D+FabMQaLmQ8XKPLhfj0D8G?=
 =?iso-8859-1?Q?VWGdUQR2FzjsvS7yphvXiecx+DN8H+NZfAvdhF7iFJzkIgbNVTkDZZLl4x?=
 =?iso-8859-1?Q?94HcFD9CtSIAff7pXMkXsKWpXpTh/3I42MRDgOl3gcDgxEECHsuEdEzwtq?=
 =?iso-8859-1?Q?HfeJu0+YsEzlZF96x3TB56e5Eb7fq1CygBL5sxwPdzcEwKGsO0oekGXG0J?=
 =?iso-8859-1?Q?TeVsIpOcTSotEOlhzVktbqMWGqRnztdBeFshqqht9EVwTGBs+ML4ushnPv?=
 =?iso-8859-1?Q?mZx2PyM9LnLYZSSnF3EDgbyJULQ84SLSM7U7jChl+L30cxL5Ik6gW2xeq/?=
 =?iso-8859-1?Q?TlSJ7bkP5Rbfr3TF0O1aGS/JcU7ZQu06PXFKZoGjMqUiI2ikmwHdg9U5ak?=
 =?iso-8859-1?Q?kyxpTsV1TV6MQoq196LKd8HG6OR+BRU97BmL5RgIt5SVBpPrfuxa7a0Uqb?=
 =?iso-8859-1?Q?Vy2gDTHIFVe6ldy/w928VMISdjUDi1XnIZTRwZG8Boyschq1pK8uGxVLpi?=
 =?iso-8859-1?Q?fBVdeVXS2t0iPliM+SdUrcTrwlJfrtq/TzZ4HhEXISV+sLHLlppRtOay28?=
 =?iso-8859-1?Q?6IrtX8WfWqEj+YTxOwl9KfNpIwarmk+jZPHf7cRKUsjYLuh1D2sbvvRWmx?=
 =?iso-8859-1?Q?uTYxoXaMTUvNMIdz6wGvP+dT9DEhBR8K+WRxxoKLTZt7R1kl7eYe4EYFLb?=
 =?iso-8859-1?Q?0WnUGiAToED+BEKzlth9LxDtsryN8DXOWz6yhYmeQZLuRS+HTi90z2rb9M?=
 =?iso-8859-1?Q?nqwF4eVIh463avlrssp6O4I5Mw6dVBrJ1kU6sHXo9CwkYv9WsmM+Qm3PjD?=
 =?iso-8859-1?Q?9B9QuIagnZSQRBmYnwXVZ5fwfwQINKxj25Z/dyjRyFbVj35R8TU/FSu97W?=
 =?iso-8859-1?Q?hjft82m39iJcq/TmQ7K/GmmX/KSWXE/fwBmuLIOWXUftlX0v7QpAQTC3HQ?=
 =?iso-8859-1?Q?BvZ/cGKQLTPerM/scwbES9rqdyN4EPZOME1yZzKfn3cAqvK13OJNEiGvO7?=
 =?iso-8859-1?Q?Mgjd+n1qvt8FmEvbYk8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8589477-c3f2-4c7e-c212-08dd3979b4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:44.5235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82rOd/sXJMYWmz3c3tYeiXc1dM9mZk0AIySSbdiL1uKQIpGtLxS5R3iGG4ZD7UZjgVr4BwO7YnP6Rk6Y1Q2U93/tfy/iw0kVVYwRBYdSH+uyhwl8SW16+TaYOuU/T6gd
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

pasid_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f42a256f15..8186d64234 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1238,3 +1238,12 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset=
, uint8_t pasid_width,
=20
     dev->exp.pasid_cap =3D offset;
 }
+
+bool pcie_pasid_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
+                PCI_PASID_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index aa040c3e97..63604ccc6e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -156,4 +156,6 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
=20
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+
+bool pcie_pasid_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.47.1

