Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD1BCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Li-0008HK-PZ; Mon, 01 Sep 2025 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XZ-0004OD-Co
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:39 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XW-0004mE-Hu
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756725454; x=1788261454;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CZb4kYJxtZ2zWDoKemLVd7Db21AKbs12cKBSEVSMSEk=;
 b=Fi5cCetHpUL+pdLfmhDyr5vnF44itIQgNop4KPMsCt5IgxNC3QUfwaNT
 FwRevjvLIWL2N7n3VW4i1E7BY3pZQBvC9imeYx5l3Za8xNiNwW/Mci/1p
 sSBfzx48alqpo2FLNbnBee+MwLe3m/Fo+Qdhe3C6MdV8OfSW+DLaJCzhu
 NUwrTer3WWWmLnE6AGbB82NPp5tK4ronAa2Bkcna3kZpaYYXklN/GfTaE
 uhpiuFa72KINggoezTD6mS41ZyaXftx3TyFo0mMeBjKMWlux8DStYWL6r
 jfhszw2BC6skQKpqWQ/ZEh4mF+mgkGI6ioxnMDDbTEQWBlRWx/TOpRo71 A==;
X-CSE-ConnectionGUID: BOQq+m7kSQq/Fi6XV6kYLA==
X-CSE-MsgGUID: KRub8F8sT1WmZ921RhMoXg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="42540662"
X-MGA-submission: =?us-ascii?q?MDGgLp8f9nrm7nWP4bOj1mLmx77FnxFKjINpbG?=
 =?us-ascii?q?HP6wQmhSrGTrMw7HJetWlC1tclNGViC4EfqKM4qvnYq0ivE06occWA5A?=
 =?us-ascii?q?ja4c/UsyYvL5z6/gXmRwB+M0dXFZBtdAmJi4F+7D8SrnkodFQ+WbJllq?=
 =?us-ascii?q?x2a+drrj0sJx1cksRCUS9G+Q=3D=3D?=
Received: from mail-francesouthazon11011018.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.18])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 13:17:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWbC4jkPHwAyjcoW5zbNamN5lLmi2jHEdaEOIBSv+J0MQHQ09v53CpXwIw/hGEUu0uOiJY7iayZ0ArsYkVdCj81DyZyVUvo/x2rYmFUEqZUDY7/wjMVqc3LDX4uG0FjJCb6yGwW0fKJ/eK0RViNvfZSBPrQb/vnqOgQQq+K7rf99FJwhWMa67/Mxtjweq0uWiW8b8h5O4YkltRq/WS3m+1Zwng7zBqUQCwsIXulhf0L7zZzy8IiCqZX9sBhmZtSD5jsBD2O1I5j30GBHkMciVvgEQrfYHd1TRSKS/rl1WDkakhV9ybFbP06tcqXaXx8kda9CkvTkS+/IMALPGJOvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOxfCe/hA8QzhyIsOqBGV6vZsg78dsM14Wm3Sqw/g+U=;
 b=dRrihQi86UHZyPFJkcG/Ckyqr4Npvsc654fbwy1dJ0A8+gx7U5aS1WofOKE300KLLKfGUWokuuIJRPC7waqKyImts5M/tFP4Oue2worE1o+qO6zCYqX0Y+MchtmxkGdjH09g1WA+AC/nWXyZLUbQun6MaNfCv0o5YCpZ0bhkQuen5eVItcFKwuz0NE5jRXOX9T7a2M95d/JkJf5Yl/8VqHdJTMUbf2ldvuradk04Vt0Psu5g+BJw16gRZaqEsfwIhbpIH3s7qY9JlW3m7zjF2icG2rKPTYtxuOqwwhgrKhLjH9eyTSSfJB9yRW4GTuFkblIxhkhnZcZcMlN0BGy/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOxfCe/hA8QzhyIsOqBGV6vZsg78dsM14Wm3Sqw/g+U=;
 b=i4ryUOHJWlmKYdlQF9yvdis/Sj9eURDO8Xb65u5B7tzYon/ka+B4bEyL3oxmDt2DmpfGfKs4l1Mq6zSxp6RW4kMXMFHEwiYxifOuOWAGypXjvvHpYnWMwZ1d5MYDITIwcL5U1p49PYWBNeA9AchuCeSuxN1h27UPHijqrVFHX7WzrqONgVJeH6i+xDzWEHjd3q+C+npa3ftMhZ8RuD7727qVJwmOng9jFNDBta7CMJGYnciIOrr4KsGTvPpiO4VJfFvfqvy9NvGC9Cw+NCVxg/bsCWN6AzZUXc3C+O4uqfPPpg7vInDLPEaJ6BsRIwEJVIp8SKPfJJ5t0FVX1SpkzQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAVPR07MB9215.eurprd07.prod.outlook.com (2603:10a6:102:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 1 Sep
 2025 11:17:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:17:23 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 3/5] intel_iommu: Declare PRI constants and structures
Thread-Topic: [PATCH 3/5] intel_iommu: Declare PRI constants and structures
Thread-Index: AQHcGzH8xgD0OzvsFke2lY4gWNXHWw==
Date: Mon, 1 Sep 2025 11:17:21 +0000
Message-ID: <20250901111630.1018573-4-clement.mathieu--drif@eviden.com>
References: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAVPR07MB9215:EE_
x-ms-office365-filtering-correlation-id: d5355aeb-301a-464b-ebab-08dde9491fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zyfeER0b+4R8KL0S6bGjMP3c1+nRvKs3g+pPAOD8hD9JvIkdBNWbloxpfE?=
 =?iso-8859-1?Q?j6Kq571HCnFOxPnOloMWfRz0G1kUozpBsK+rdMgyO+7SskiQmZxOapLOrD?=
 =?iso-8859-1?Q?MyiKuy2wZbQOFNmx4i5Q/Y//mNCAC0oEyVwAi0HZ+Hp/A8Q6fEMTotAiHq?=
 =?iso-8859-1?Q?NTmGwGZuOrwD/iEY75An8/PznuxF5rh0W40nyQTN2D204j6Edm56FhCmoF?=
 =?iso-8859-1?Q?72zTgO6tSnUqrbjR2XNYzUgoEBgD6jk21/KFZo+9MGihP/GC5VTL8VQOWK?=
 =?iso-8859-1?Q?e62VWYx00J2vBh4EI0yWKrZulHM/mAUkl1Y55k4Y4gQi/ZlK/Yu3zel0XK?=
 =?iso-8859-1?Q?rf39r5tSzUg23QhwXRjIXj6F5qTtVSSxjyFBesPYLw9l7wCjIh63npy56O?=
 =?iso-8859-1?Q?crFYxpEzicrDMvmCW/qS2GqpXgS06g53lrDYdwVI6eb+71GeI8YX+c7aU+?=
 =?iso-8859-1?Q?PEkH9WTZnRC2GKpHflcLiP6uR5dfSA3/tpVRRrTfKAyqn7Fu4OI2RB7ycQ?=
 =?iso-8859-1?Q?ii/QrJikbZsDuVgkMbGak5GzgFQDoPeUbkBHryDeM/VCbprKj49kyXBwV0?=
 =?iso-8859-1?Q?MVbUA5qJ4Ydx3QDetbc0kWqbGFUF3WSeAWD/Gcm0FCj8fGzwL0sPML+qA7?=
 =?iso-8859-1?Q?uRYZt3vm/JAZY5yPi+KCmeLeh3T0DQuBIDeDh2gtu8E0G6wJnFsQKZ/XQx?=
 =?iso-8859-1?Q?N0nF9pS4QxYuOcyn3xdPqPHMhriGu8S+ECQz4jbmkbgLj9fyBLnpso6HXv?=
 =?iso-8859-1?Q?M2RPfpUj15L76quu/G8Ee6dG5R+0rJ9qGDYeigOYeGG9lDXFsqNHskArZU?=
 =?iso-8859-1?Q?1d0jVQRBLLdNQvY3GgLel97DmEOEQkPhtzg3AbFFwoVUG2ZDWTsfevoixF?=
 =?iso-8859-1?Q?RqAPUm/dM1hLT14IaQsP8yWTuHYMplnquecHzAur1OlXpbhL5uxw3yJLvY?=
 =?iso-8859-1?Q?zxYNobgLSXTtrK5m+tJzxm9JYDCBRxiZeIR6tVe7x6LEkYdSv6SxqQNv30?=
 =?iso-8859-1?Q?SdhlurqA0CrsIhzXBltX7QtUlQTHdq5GMJ69nWURFtf3F4SmcVxR6DTtUu?=
 =?iso-8859-1?Q?8/P99u1lu50g9LHpaIRr2QVDlUx9NGt8RLSrXAz7n1toTTWfCkHBaLPwzy?=
 =?iso-8859-1?Q?QOLiG/U33yqMagO3nszKJRqhkrSewLTYNMZfBgB63jLtvb3Q+nk54ShKGi?=
 =?iso-8859-1?Q?0AvXnqKoqX74ZI+smpkmi/Etg+bV3F0mIOKMvKzUGwuw0bXjvnDD0UGjT5?=
 =?iso-8859-1?Q?nEY7rNXRC5jBx3JByz0BVxXPWjjdewqT9kJXbSma4rJcsU+auBzsLQmrnv?=
 =?iso-8859-1?Q?bttQbIJVGlOK3VYIyWNXSrt1MB/bd+zq130C4bCpqvWqR9oVVoCGI4/C8T?=
 =?iso-8859-1?Q?b7faWsSGCOi8qTgZmB2Jm0gebh8dHzFG+ZLPBtNieOD/DlpyYwsotxod6g?=
 =?iso-8859-1?Q?s9GkwHHIfsNpgyUnC68rHHpcu9bOUhnIntEpWOiMSKboHweaj2Yq4RoJvP?=
 =?iso-8859-1?Q?/4I/tzELaCJ82mF9cn5FYZUA7Xt/qPYXdCl2+gTDoRYA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmElUe0uGCRfQr1Q0SouXs6QrGpTGqXzJuNz0c+yvEGPk3B1gw8zZJdZ37?=
 =?iso-8859-1?Q?biThOVAphbx7lQOElne4n+hn54NeDJEO1038bHzTUJqXtR3BUdqVeQmClO?=
 =?iso-8859-1?Q?Sm6EcMbCroLcjDdoeccZfhG85VvZk+CXwkxvKvy+h2L1dAN9wo/F8MNFWc?=
 =?iso-8859-1?Q?cy8i7f1nKffpgTDay9sAjnON7S/Fn7bue8j3jJiScpARA9qu53jHuC5aBi?=
 =?iso-8859-1?Q?oorHNLH6X8TnU7VGcme8pqMI8lPXqN5CAsxD9xIVdysbI0h6hcIvtor9nw?=
 =?iso-8859-1?Q?fovdH0PaRWSTK8bRcaE/0BoHn550HfkJzO0X19OQ6Dou9cFZPqCrqf3Nyo?=
 =?iso-8859-1?Q?NpnDG4Wa4WWs54MgDbiaec8TuSkezT4raDdKpojJ+4jF8qapOwYeb4vR31?=
 =?iso-8859-1?Q?QPub7DmvxhDd6OKuCOH8kjTOKT+9HfJpoqzTpk/Fj/dC8Ky5UFh/U+FiGM?=
 =?iso-8859-1?Q?gtVrIGITrL8718ORr2u9aSQj/BrgK33gSc/ynUHF1rWPHKSNmyaOHt9ASc?=
 =?iso-8859-1?Q?Va57Df35g6EsqGcyNuHxnHcYQa8mbcr+0C8RWiVoihaqABruSqYuDQDObq?=
 =?iso-8859-1?Q?0lGa+plJxzmBMfZEkxhF4ahkDBzYwMEbu5K7D9lpTH272JWtOntyb0cfaS?=
 =?iso-8859-1?Q?UKnY2oo7vJxG4551UdZfpa50lEgpyCtnouAQTPVEAXvPf3d3jJS7OAo//c?=
 =?iso-8859-1?Q?+QSV0JN6+0Apv02Um0JjLD7ubY4BeV74lJ1UJdnuFk2F7UJDJXurKNqg+Z?=
 =?iso-8859-1?Q?BLm6YH+qNscFcK3fJIhk2M5yOgTPqrA5LNb3A80vMxpt3JBlElqURCVUB3?=
 =?iso-8859-1?Q?i5oeAj7i3aW2XB4gNtOH3Oq2WUkRf0dDIIiwxblkSjleSR0MksnJM+hI1x?=
 =?iso-8859-1?Q?12wVDHZh99G5GoSRHN/DSpHGkmDEWAJIEBfyzJ/4dcMLO+mytDf5H52xKw?=
 =?iso-8859-1?Q?tQqR/MW/26KxZ9pT94ptWUobUTS7YLRRMVLXDmlm/SGzpgaL53jZ30l22Q?=
 =?iso-8859-1?Q?NK3ecYN43L3sd3hful/uz/6gB0MsJ43OYlFPdEGjw6JW7u4EJESBj3Doxj?=
 =?iso-8859-1?Q?139CpbBXf8ydHE79l9oVajNWUXTDO37KgF+Pp8yg6r07qZ+Ak9gZV59s2B?=
 =?iso-8859-1?Q?0takY01tyyuOJSeyUhbAGvxdRuYPDNmaLPcR7fVc+VGHueFuy1z3spoLHd?=
 =?iso-8859-1?Q?iPhEQk0ujPN23xk6o/GiuLHEOmZI8cSjWPC+R+dwvVXZG8LUps0WCH1FFA?=
 =?iso-8859-1?Q?E8n/GOq5VOMFN8QLCyuYWU6jysFH1XqqpkQpKTZgSjgqsKzL3lM3wiq+b6?=
 =?iso-8859-1?Q?rcks9RbWqnIGWZnKVY3DwNXX/bQNLcnZbO3/OIz7Qye8P399AuqXv8AHpr?=
 =?iso-8859-1?Q?BHZArw/xcnJ3kWb6iATNuRKNs0Q6DHC9XDmK4MD8t6P9k++n21mYe8jN7O?=
 =?iso-8859-1?Q?vySGG1qMQ4R7++sMX5gslx6yjPEBnTpAN9sBwALG5Nz4pXa6/J2ZYUsGGO?=
 =?iso-8859-1?Q?WB/h/5Ivhf1DQ5hos4fOIfGjoDbetsBcmgr6ztq7JYxc3mzYaM9HoQtt6b?=
 =?iso-8859-1?Q?vo+cF1MTAAmmzamQAJikAAafv7Oq+p7EpESHlGMuy2CSeARaXbH/uafCEn?=
 =?iso-8859-1?Q?PvlyRp8wQnQbLjP5L37IkX1zz4tdsqRd7RumgfENTZ+iZfv8I81/k7Vd8M?=
 =?iso-8859-1?Q?+Kuc++wKJNV5/3AE67k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5355aeb-301a-464b-ebab-08dde9491fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:17:21.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IJWqhf8T//Z0kx0lJoZO5rpYFa7tGR2+cKbQnzFb3YKnEITnv+1hdxIpoGnoVP/enkLCMpTJWxwUt9lEvtM18tUN91FT137yNxLWWI+7HYwB7FSei8dKNDnSzZnrUF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9215
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
X-Mailman-Approved-At: Mon, 01 Sep 2025 09:13:15 -0400
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
 hw/i386/intel_iommu_internal.h | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 360e937989..04a8d4c769 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,6 +190,7 @@
 #define VTD_ECAP_EIM                (1ULL << 4)
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
+#define VTD_ECAP_PRS                (1ULL << 29)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid=
 */
@@ -376,6 +377,18 @@ union VTDInvDesc {
 };
 typedef union VTDInvDesc VTDInvDesc;
=20
+/* Page Request Descriptor */
+union VTDPRDesc {
+    struct {
+        uint64_t lo;
+        uint64_t hi;
+    };
+    struct {
+        uint64_t val[4];
+    };
+};
+typedef union VTDPRDesc VTDPRDesc;
+
 /* Masks for struct VTDInvDesc */
 #define VTD_INV_DESC_ALL_ONE            -1ULL
 #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
@@ -389,6 +402,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc=
 */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc=
 */
 #define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc=
*/
+#define VTD_INV_DESC_PGRESP             0x9 /* Page Group Response Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descripto=
r */
=20
 /* Masks for Invalidation Wait Descriptor*/
@@ -440,6 +454,15 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL0 0xfff000000000f000ULL
 #define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL1 0x7feULL
=20
+/* Mask for Page Group Response Descriptor */
+#define VTD_INV_DESC_PGRESP_RSVD_HI             0xfffffffffffff003ULL
+#define VTD_INV_DESC_PGRESP_RSVD_LO             0xfff00000000001e0ULL
+#define VTD_INV_DESC_PGRESP_PP(val)             (((val) >> 4) & 0x1ULL)
+#define VTD_INV_DESC_PGRESP_RC(val)             (((val) >> 12) & 0xfULL)
+#define VTD_INV_DESC_PGRESP_RID(val)            (((val) >> 16) & 0xffffULL=
)
+#define VTD_INV_DESC_PGRESP_PASID(val)          (((val) >> 32) & 0xfffffUL=
L)
+#define VTD_INV_DESC_PGRESP_PRGI(val)           (((val) >> 3) & 0x1ffULL)
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
=20
@@ -491,6 +514,31 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
=20
+/* Page Request Descriptor */
+/* For the low 64-bit of 128-bit */
+#define VTD_PRD_TYPE            (1ULL)
+#define VTD_PRD_PP(val)         (((val) & 1ULL) << 8)
+#define VTD_PRD_RID(val)        (((val) & 0xffffULL) << 16)
+#define VTD_PRD_PASID(val)      (((val) & 0xfffffULL) << 32)
+#define VTD_PRD_EXR(val)        (((val) & 1ULL) << 52)
+#define VTD_PRD_PMR(val)        (((val) & 1ULL) << 53)
+/* For the high 64-bit of 128-bit */
+#define VTD_PRD_RDR(val)        ((val) & 1ULL)
+#define VTD_PRD_WRR(val)        (((val) & 1ULL) << 1)
+#define VTD_PRD_LPIG(val)       (((val) & 1ULL) << 2)
+#define VTD_PRD_PRGI(val)       (((val) & 0x1ffULL) << 3)
+#define VTD_PRD_ADDR(val)       ((val) & 0xfffffffffffff000ULL)
+
+/* Page Request Queue constants */
+#define VTD_PQA_ENTRY_SIZE      32 /* Size of an entry in bytes */
+/* Page Request Queue masks */
+#define VTD_PQA_ADDR            0xfffffffffffff000ULL /* PR queue address =
*/
+#define VTD_PQA_SIZE            0x7ULL /* PR queue size */
+#define VTD_PR_STATUS_PPR       1UL /* Pending page request */
+#define VTD_PR_STATUS_PRO       2UL /* Page request overflow */
+#define VTD_PR_PECTL_IP         0x40000000UL /* PR control interrup pendin=
g */
+#define VTD_PR_PECTL_IM         0x80000000UL /* PR control interrup mask *=
/
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -550,6 +598,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
+#define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
=20
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
--=20
2.51.0

