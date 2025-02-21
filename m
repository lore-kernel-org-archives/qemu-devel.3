Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91B7C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4V-0004YA-SV; Fri, 21 Feb 2025 03:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4T-0004Wa-MO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:41 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4R-0005ju-Ty
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125260; x=1771661260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fDuNj2e5Z+tVyKsZ9Vl/nMf+ohGdmNjrvRU9Wlq6dmM=;
 b=MUdOySWSyHF7i36a/9jkK6cNZfhp5w+5c2xwlNT8oCOKKnofyOxSUA/Q
 KplnkjV0rJgMbRyk/msurJtchEkc2w3Sir/kix47CS2NDZBE3iVLF0NJb
 MP80wGj1hikHWrTHlTkdnAvXDEDu49wQRm/JRqFqadPVt3Qd5hRBDcGYf
 XFnh+pMvTcvk9Woy4fXegfpDTXAO0zbqmPUT7uH1+ml/Np0z9qh7IXnXZ
 81tYlUJBiG0aoUbFEit73JOlhaFuQegepYCQB3z6xq8tnGDSoWQQ3YstW
 5t9NEq2SMSxV3zg7rAiUU11ilFiJxvrZi4xRdE3bFmoZGQgXQF7IiAeim w==;
X-CSE-ConnectionGUID: Z8Qj1T+YQ9iJvElmxhwyjw==
X-CSE-MsgGUID: 51dmisD7Q9WvvfrFcIdbZA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31382212"
X-MGA-submission: =?us-ascii?q?MDESfvArCfJuLcS5YjbSMALBgpmKcXgYwUZAPL?=
 =?us-ascii?q?TvkTWMO+ulqfYzio2dKLMwFseSN+3JJAnsTKQOSRel3b/crvalEr+I5c?=
 =?us-ascii?q?6sriaoS8l7t+/hd1NtW7AZriMKnpkpQ/Y9O0Hog/z8NRIAFcQmyMGExo?=
 =?us-ascii?q?PqaDKKgADJcIZJCDaMoT5j8A=3D=3D?=
Received: from mail-db8eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.107])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX4KEaPi6Sqr9NYrsHch4Tkc4u2FvpjSv3Jf94eT4DQmydW3SvUOuoCl4RZxQPBtl2GHEwB8qiy8HWhl0nLvQqdXuYpZ9hfsihLgCEaCg6k82hSY1jpUkFhxIBdrtl3wYazRI53QCTub7v8ZDL/sXddLqKs9IqCbswlLbsJYRxeHiRqVx7K6GH105IMf8Mvdf9GT/Zdy1qDLWslBjT+aC0ltmQ+HU3aOWea5W0iHrNQarLDibLtvt1Ekb6XJgwOzbuDJP1SGpsw/UB9UJUN+d2PO4y0r7555CyIS/96xUxOKtp6Zn9vKhCCRKMoxrv6lNy+NTnFlgUQQTBN1Zm2JYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdmPJO5RPn+KvHUqO9BHrSYOABK1AmuO2QQjcSjxo28=;
 b=gxygNHBnLTR3MGN4iFgYZQN82WDQg74oRV4NKKr59RN3iuRHD8a8QLXlRjkDMwoq7N61gthH3dZuOeeYfrr/bIH7ylyfA9Pt16ABiIgGETAhLPZBJ3zmPa0/a4ZuL5t0/wXaNQ8AqiW+KIHyOnCj+PFRlvn2Kbv4Di77CRO7LX5+15kT5hXSpfnqaC1wuhh/snyZ8bTuJgQyi7jvgqECvB8T3ULsiwt+ZMQCCm0zSxQG2MofJvkzGRYeoIBroM3YXQi7Kw6Wnw1UDM7LJdmX80HhMA8feoWmEome2ZL2eCnOYMPhBYkqOiF3r5jGEL/mJ8qNshL7K2rXdupnyCO7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdmPJO5RPn+KvHUqO9BHrSYOABK1AmuO2QQjcSjxo28=;
 b=PDgrDCAwbMGQlxPqMRzmeNkC0uxo4M+IMyz7IcM5ZGGoBHh8ZFhxSfuuFUqGU4br81sQGQMlvi6AjoNcPKi5OjIi0Qub9RikTNkHq2zJbdrpYZe/qyzpRTWVBJknIaOmF28olWJiE8GdVCSrmgahit27WLBh9He9ZUmo+Au/4mUPW6nSxFbTi7dRqcJDWQWlrD2JCdEFS90bnUwokAGxZbdkg0yDcKL7yIRHyzREd5WJansWxEnPO3RwaESTipCY4w474ftbl4FeX3tZlz/gCqcT7NJUUg8n8fiScA1Hegn5LHK+/PYvr8q6bcCqjKTjAhPCejdSOnz0jiA/hGrC5Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:35 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:35 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 07/19] pcie: Helper function to check if ATS is enabled
Thread-Topic: [PATCH v3 07/19] pcie: Helper function to check if ATS is enabled
Thread-Index: AQHbhDeqYRRb4SwEMEG8rwue64flsw==
Date: Fri, 21 Feb 2025 08:07:35 +0000
Message-ID: <20250221080331.186285-8-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 41e9f999-4b7e-49ed-910e-08dd524eccf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iXh2YjoDGgVoVG06UNu8TYz6LyHMTry0sELl3YdoaKijhG11qnMcUQV34P?=
 =?iso-8859-1?Q?mbn3en7HT/iyCw74F3U8McyLyqta+y7s0//GF4h9hl96S/2+0Zgfyi9dsG?=
 =?iso-8859-1?Q?jTE3ATv7eV7fxuVQKl3WgXW7ep9SReeYD13S2/vq6LgCmzGqoYf+breYgg?=
 =?iso-8859-1?Q?VR3CuqIfVTxVBqgxwtRXX1cuG9NqvlwShRT4SGpa087875VI9Rj90ckp9I?=
 =?iso-8859-1?Q?lfj7qp1ghH3o0pRr6HT3Qu5HCvkWzodzZMG9rJnT4/KXkDgbGMBgEq+pnv?=
 =?iso-8859-1?Q?pcV+pGbnleIVhYxZHuyw0wItcy6NpX/vnU609eauPln5YqSCjhwjbsgu8/?=
 =?iso-8859-1?Q?9s0+ScG9YccFrkK+tIaFnGAcD1AzgqBYA05At71Avf1M+BHWf/oyrr169y?=
 =?iso-8859-1?Q?37vrGsoxTDg3pc9avKRLVJFefyn+qzV4IMV6fJxo7yg2h8N0Zkg9Kh3G2y?=
 =?iso-8859-1?Q?+c3pZb7Z1KgkZQd3FebjAf0RfMSiIy/PugNGL+qnTjCut0aRmnGH3cloqT?=
 =?iso-8859-1?Q?niH8HDdJJLJb8c6wlW44vMNsge1fdH3ZZYPk9TnHI+ASvdumJmgquqnEfz?=
 =?iso-8859-1?Q?CH+hxDJQ4cXea4DL8KQJA67lQnItfJ8dMWwrXgPBorj7HjgZ4agqvW0NdW?=
 =?iso-8859-1?Q?cQyQYRH3WQjhFMRPgp7CIuddRaIk3x7LRlMpGC8Bhe0LXo2PgSQSp4qULO?=
 =?iso-8859-1?Q?ujg7d8P6mSGbImUfXyoje3oRKD4j2mfxeDuvntJhfYO+41FYBLdmCqSiN3?=
 =?iso-8859-1?Q?AJqTWAWQ0gQM20/Tlo/kU7QKbWTFhXsoZH0ys0amzk9p0S0aXNq4OtEyKu?=
 =?iso-8859-1?Q?OU3rxlpj6NU3sUQ2OnJv2W0P8Vg9T5PMxysl6m1KnL2gqLFC6dK3CK4XkU?=
 =?iso-8859-1?Q?6hjGqgNIK0T6w6R4enIhg8l2S9wnK4jORPSpnoWLQCjZUpI4aKcOUiHUhj?=
 =?iso-8859-1?Q?VTexK5pkCmrBnxeO+Kht9Z/hWaaYoz73Or7k5PeCDA+U5YJCYAoVrsbxcp?=
 =?iso-8859-1?Q?/TMrC/ZxvU8SmVSqQsHrN8f4OXi3cpIzLkK3bPPbv2u8WUDS4fCZgGb+Pn?=
 =?iso-8859-1?Q?bazqt1vc/euZPXSqQwJlItvDcRNCRuZUAUOAHCV8E6Dm6KcvLG57qafIHO?=
 =?iso-8859-1?Q?RYYNoUGdDqGl0yJq0sKHIKApO6yR1SstZ0YOXm57SyAiD+SmmIUf0RX8EZ?=
 =?iso-8859-1?Q?MkzsAAxicSM95RjEab7hRS9xcWTws/gX7h5GAl0Ikk3DCSZOknV+1+JEh8?=
 =?iso-8859-1?Q?AVkNmY3ChzZ8fNxuRhb90+K03uTfDkWwCE1cF30oSc9x2Mq1UemdR6vCga?=
 =?iso-8859-1?Q?GbFinFxSjzJMy8jygfyLvB/0pvnkU6IazLfX29cSuvO46wYhxV/yXImgXU?=
 =?iso-8859-1?Q?yvyYGXAWRX13CkQa3nubbEvMLil3Me4JDEZMNB85QYDUMiQsXaAr3bfGpa?=
 =?iso-8859-1?Q?zeRBkxP7hEaAlFUuww2V8lt7Fk5gBezKaYpkWyS/KUcfJbL40r0XMb5EV0?=
 =?iso-8859-1?Q?eB4UtjaWXEDkaCImf5iHDN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JWhfaLsDpXrte3uPh1ryXg35NYjEBoe4CGG9ImWvs25RSKbLM4CcTADfXO?=
 =?iso-8859-1?Q?0DQtYeNlW8IDo9IGrUZhzASR3JPxqEtxuOPHvb8TGki0TbiSn62PyQ6QuU?=
 =?iso-8859-1?Q?9KNkpPt++7HRe7Yzmjl3cf5lux3LymB2hLusiDx3WLiFXta/ofE8IGjH/O?=
 =?iso-8859-1?Q?ZvW9PTxiVG1wnig2HTakBYqVkkKQgZEjxzqQT6FOX7hkSti3PkMmNI5ZZF?=
 =?iso-8859-1?Q?fFLv0bobU6zp5poUVr7U6PZMSLsQE27+hm9i3zURNG9YLYOjJXiv2ctWON?=
 =?iso-8859-1?Q?i0jpFsOIWhoULbZt8OqXwyOON8ak0BjahXEVVup5eQXnYYBDMlAS6lIujk?=
 =?iso-8859-1?Q?N2yFIzLYPi0y8GKbvADHv6KzlAWWGZTXfl2laDqhqNDUUiobwStQ+xbhXm?=
 =?iso-8859-1?Q?bmurqaM1dw6mFWrAC3oy5px0fQHwVe8VqFhylyiCmIFDTOnV2UVnuiwuNw?=
 =?iso-8859-1?Q?IT3E4yTfPI2rOaMYgBFQoDr9iasYxQ5HoY8U/e51V0MU/tCK0GcKkkTyOO?=
 =?iso-8859-1?Q?XlD9x68uD4sI9gsb5+YH3hzHa8u7E4WlBC8q7yF5xjEfVtFWCCfb9CaZBr?=
 =?iso-8859-1?Q?JFYg/zrDe+jXL5IDutVMrk0G5Hmywql1q5XAgsvRPOfk0Ta/hjeMvPjfR3?=
 =?iso-8859-1?Q?FT0qpWs1flKtz4D78M+sz189GMi/+O0Ub9tWaaGwJbbP3T9hwGY7bHD3Ex?=
 =?iso-8859-1?Q?t0pC4zx2ULaBbbEtD9weP0v5/IE0WWuKiVDmkFUe8I6fkfIjPsXGpnz/cU?=
 =?iso-8859-1?Q?ajknJkyD9lrvb6qAG7qierKGLh+cfkNSWHudvr/iIgrJfLJSVhusV3F1/J?=
 =?iso-8859-1?Q?AWG3s4WUn/OrJk74LeWPlyYiem2V4pyxr4vt9SEasax+fASNtusSGdCpIA?=
 =?iso-8859-1?Q?ph500K6HlmAj3zqyaA2tiOjjHw6oh0kksUv/kNbUPQEFZff90YVrAqcn2F?=
 =?iso-8859-1?Q?ooFeT2CmwNvQlYwGreDtCoa9hB2zsDeh7hy+VKHRo153Jc8rSesPCXONj5?=
 =?iso-8859-1?Q?7R9X0a2XvT260N2EjdRKaIXQJb9uhqB1Pc+UZ/8fMoxvzCStxFhABwpgbc?=
 =?iso-8859-1?Q?ELDqputEozZrfMTRERakQleRwGV2bo0wcvJeNjSG62sVrpSeNcjpFJLszc?=
 =?iso-8859-1?Q?vNv+WUWT/nU02pXWygszblBSjwlBLAMZdEmu5lvysF3b5KAtQYktRA6wEV?=
 =?iso-8859-1?Q?FlcuVhVeQXw9Bm4W30J6HK0SI0LhZ1n+8TkTCjIONJw0uM728Pe+yW9Mtg?=
 =?iso-8859-1?Q?yz7Atfhed5kgvN2ND97mets9u4zRXp+Hi2ezRZc1M1LJBo0GkEVTgu6Z95?=
 =?iso-8859-1?Q?DlHITvhD9gJDsw13k8Gqv7VGCzfOZY1GC7DPzzol4Eaq9UT84W1fJOGf7b?=
 =?iso-8859-1?Q?LVKIoiAMngVDJ3GBiWMhjJ7tJdLxtpTcvqO6xCbl7MGZVXJgwAtCXF7ka2?=
 =?iso-8859-1?Q?CqinRx92iQ/z0yVaZDztPW9xHKX7Wm4/Cz9RPo5L5XQQRLmp0K3Ult8How?=
 =?iso-8859-1?Q?7efGcHaMOqnk/cFNwkBddVQzCQYLrQyish6A/lQLZ9GcMqiyO51frS4cmU?=
 =?iso-8859-1?Q?6SmXNODuzf6I7cokL7pbPmvf6iZUCxH8JZPt/1p1dF5dRuC43gvmkeJbCL?=
 =?iso-8859-1?Q?Y6CLDlgxgVTdcMJeFN+Int3/AG3EUXIOqAwRFW/Q8kPMF1d3QqkORI+dgr?=
 =?iso-8859-1?Q?yzMQ6Q2mmjT51wrUtcY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e9f999-4b7e-49ed-910e-08dd524eccf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:35.5902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNzzyro3TasEnNdrjEOwtCazW7vPoR9goIMjONCqHrPOn1CKyA86E1rfA8JcLp26kYmHvaCdiIygVLf0SD030RdQVZw9z7nTHW2w1uwlk++1yZq/vG71/uRt04/mrE+x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

ats_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 8186d64234..3b8fd6f33c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1247,3 +1247,12 @@ bool pcie_pasid_enabled(const PCIDevice *dev)
     return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
                 PCI_PASID_CTRL_ENABLE) !=3D 0;
 }
+
+bool pcie_ats_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.ats_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.ats_cap + PCI_ATS_CTRL) &
+                PCI_ATS_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 63604ccc6e..7e7b8baa6e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,4 +158,5 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, u=
int8_t pasid_width,
                      bool exec_perm, bool priv_mod);
=20
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.48.1

