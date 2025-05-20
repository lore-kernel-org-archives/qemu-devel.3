Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A99C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFh-00016u-6z; Tue, 20 May 2025 03:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFf-00016I-Ba
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:03 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFc-00026T-La
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725540; x=1779261540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5nDJVyaCW96jZKuDHE7F9IwKCF7Y2hfu7phC4MsvWPM=;
 b=tFs2CDYmDxmi3+suistIyJNNjaN/lO7tRaNNVY84A4iB8Drxa953Btnr
 udh4k6ms6fP3WSQgwldyHDVRMMgKhI/21PTMV/vtbKXZdqakjSsjwLtIB
 xcXdx+/5/CFzW3EGRenSCEOC+2eZN0G1ctIo2ZxOiRtD8qjTXZHShrmiU
 6huW53tS16lrrpBoQpCJLe0XPA6Hbu3S9ZQ0dHwvSjY32CuDk2H8fm9LR
 WeT7RpSGx1pQyHrFuP/E7zg59quNjpNfq7NwDRer6TzDCe9HMebu1iIer
 HHw1ozIqDdv3ZbcyBm/6VcFXE1/SP0vPuJXA7uJ2DpVnSnFfsnRi31p8n g==;
X-CSE-ConnectionGUID: gVSkK987R2e+0yM/OiwTbw==
X-CSE-MsgGUID: t1w39jPATfGdi/xrvfrcMQ==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37197188"
X-MGA-submission: =?us-ascii?q?MDG06x9kqChY6UVtZBg7E+1oIYGCCd/DbkBBbI?=
 =?us-ascii?q?0+dv/+ZwHIPhgPX9q8CKZ00+JSHfQuLmOhqVEY9/xiASZCiNF6Mngk/O?=
 =?us-ascii?q?O/ebbaTPXK9eRlT4c904HK56+o7JnjmIaKoMtikrb68C1TpugPcH3D7O?=
 =?us-ascii?q?Mx/mFHsInlPV4Tbaj+db+1jQ=3D=3D?=
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([40.107.21.44])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:18:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKiklCk6C4vs4Hkm3q43SQw1gmo4WxrFeLhA8tHSUhS70gRRGec+mf2rPxb13UpuSFC6A61QKeGpKabVpYpvjBrpHyzDZnTZwudZT+AG5+7f393onhSrpfRVK6d7Lwcgk11eAAuNNz1PjoFP0NlfaRc2C0swipiOk6LtkHvflZMKnHY5F038ZI17CbsmEmq63GMwc+ldJx53TwfC6FolTuIoHUFLltbONNpcsgEQmUuUE7SiVuGoyBa7JEB58wFa41e0sDYJdP2oEnhVlYTpKhkux4LIQxQkqsKB+df8BIiSE4pQzKl7IsejTcMo4dRJ2HffVc4GytlpIplM7c/G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDSKog/xlt1cnwqHaCfwX4JxYICgVUwy1huzv/FYz7s=;
 b=ZzIy+ZxQkQgf9qaYVzmyu4+zTmOLJvdJB9/iUgUSKQkkNCFBeZqzmNsi0WCGCzyi4Y1OdcASLO05rFeHuc7jayK9Ka4wkeQ4IGhcsfkX33IpZU277Jxt5y4ZTg2jFharMUWa0V1/Vdcli5lXncjIJ4wk4/K2ukLIIxWTfub8uAOVx0hEYEHotsiYfIdvqjiKCgk9hv0b7ShA8QMoO7k8mQwH5DCzX7BtTdlRKWGEt3VK0tat34tAu9jQKn2Et3eMKDnTsLV/ZgFroi4myfomTwSECbXfmpLcE48ZsNdtaOh2Cwmoc+Mo/6GsaP54r/sxMy9o1eqnEoXGVL7wWzbzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDSKog/xlt1cnwqHaCfwX4JxYICgVUwy1huzv/FYz7s=;
 b=GG+284RHDkp7KbIhsgk4XOXTM7H6JZrIWKz3blDHxqzHWI12iCDpnQVeyfrcZrId3kSgkh8KrmbuKrxae0bk3GHJC2g50c4P4kvkz8PdvrCATKqOFkF0Mzc04xOgm6gdBgKBsX/seCZ6/EjsQrOqaFFOufCxX+6PIRVgVtEj4MyipLbIlNXvA4N2xAffoApKtfJcMeHcBS6khy9jfYLGjtg7d3X/qZ0YxRKpbl99IVsakrSIb+p5ve9VymXVh3VLnMXQuvv01obmbygMAX9FErg6qJy/DaG2LoFupuaqyHXWKER6nN1waRe2hL9ufPN67wj3ob/3gvSfITnLePZgVQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 04/11] pcie: Add a helper to declare the PRI capability for a
 pcie device
Thread-Topic: [PATCH 04/11] pcie: Add a helper to declare the PRI capability
 for a pcie device
Thread-Index: AQHbyVdxb3c7TpGNFEuuPH7UPO+EWg==
Date: Tue, 20 May 2025 07:18:54 +0000
Message-ID: <20250520071823.764266-5-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB10037:EE_
x-ms-office365-filtering-correlation-id: 76061e50-fe50-427b-bffb-08dd976e9448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aQTpIubgEzsJDjYpYVirHuPLYJwoju+Ln/ADDxdlCpAKqXkladSZYAthpB?=
 =?iso-8859-1?Q?SiA1OZgjSyJIR2RrXlehWj2GaGh0UbrROEHyOgNfStJS3V+DVXAB4f1osj?=
 =?iso-8859-1?Q?w1T12JaeiVrF/1QCMD8HYGVP1ZVBidU/7m/FQT2Gdc3DqSmVJvQtxhzm5m?=
 =?iso-8859-1?Q?IEFsi1EiMYRZAoVmmRy1K2fiLnRDfkkMSd4I74ozqfX+cjeojgRxHySYTu?=
 =?iso-8859-1?Q?y3D88Vfz5vMGbp9TRJh0/bfTxetuvnmHqrUbWduSKaao4W8zno0xLS8KHW?=
 =?iso-8859-1?Q?nSCv16RVX0tUcNnTfGX4Y6VtDVAi2lcMU5Kj+uSgm2U0V4bugGba8M9FTb?=
 =?iso-8859-1?Q?ffd2eQXjWrj4gVOgwSX+Mw+bpkdcMFwTSvNB7Sdidw5ghc7wvM945vxKil?=
 =?iso-8859-1?Q?Lz1rnb8tB1bYvRp55TorHlcnOLM/XT0GqYttdAGrPbnH4o/IcY0/rsFPpx?=
 =?iso-8859-1?Q?PplpvcH39gio/5gHUCDzAz0e/ok35RAn+2au8NqqSzXondnTGWYswi7nYc?=
 =?iso-8859-1?Q?lGPUpnCiuGbioB59dVrjAI38YLDhNFj2OYAmgQAKNCXVPpFtWGrvYAvG5n?=
 =?iso-8859-1?Q?rTl+hUxQ5gI3cgkI6zvGwoMZwdusnLd9fSbdi/qbMC9y5qPqc7q51Jmm0g?=
 =?iso-8859-1?Q?9XiA3d12Zg0qFuT6GbgZA+/nqQdoed63wA6Y5HgE9G/VOKvZ3DpPIWSVN0?=
 =?iso-8859-1?Q?9USv1D7igXshTMJOoHR7JS3eLIViCJ/Ou9i0bzPIWTw2lkoGzEnTzliiUl?=
 =?iso-8859-1?Q?aC1jCT1W/ujsAQgpC6SsnKzzOiqT8oXnBLToO+ZQql71OqVAvr3Mq/ZlCH?=
 =?iso-8859-1?Q?OoqXVsifJQIAE5DMQ5jT9o17HOY83qlhWNGevkdyRGCKe6BSV+RZjd7fY7?=
 =?iso-8859-1?Q?waYmm6KXvU2szZvUkQVnp1CWNXqk92vYmmF/zOiWonlWylk3y1ZJ+wmeMu?=
 =?iso-8859-1?Q?rhhGoLSG2AZPiIaY/RAGhnkojHqU+KpwQrJ5qu22CPgLtgNdLvxHyzsi2o?=
 =?iso-8859-1?Q?GbriSUyyrQh4vUrdu8fF87kn9OzKPTvtLBxXeyocR1Mn4Cse+xzEF2GNqG?=
 =?iso-8859-1?Q?uqGxn/K5roPcwTrgGCXaw4WuJlDb8+8fAcg9kBzcoOg2bbxoxwQbalR0KN?=
 =?iso-8859-1?Q?vujOpTPV4o54vXcs2ksCp6YhPq3yZN/cBrz1R4BNtIeGlpGTXrukC4jeRO?=
 =?iso-8859-1?Q?/piogGU7pGg/u4R1DAFWzGlnakT5WZQTJDY/egXQ5t4+9lbMoFbsV98k8O?=
 =?iso-8859-1?Q?q9+CJYi6kT/CU+xN3CnuCsvW+Skk61q+iE7lvbj22j5FXp+n8ndxiLlLcD?=
 =?iso-8859-1?Q?Ps1/T1p+NBH3E0QHUKLJ3SOam47ugbKo1YRM+EX4/tlodb4KHUDlisUVPx?=
 =?iso-8859-1?Q?AJUNkpFxmddggfsg/XSXZkO+NPC6Nv8677kiFd0GKk7o4B+bZJV5rfhgkF?=
 =?iso-8859-1?Q?bfzQ7xkCnel5s53KZO3S0bpAMZpsgSAHNLFWqKQq3k1CLH2tl8vxUmSDTn?=
 =?iso-8859-1?Q?pM4BF0vD4aVOi+o0OdU7UR8J8UxPvElrSCyllmM3borJls4BQ+TRJyZR/f?=
 =?iso-8859-1?Q?YjhRRgI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TqVx/WJoc3xdXyLUKcjgzHXmSZu5ChzfVqd0V8Ii8SPRUtQKzJsmMBOPll?=
 =?iso-8859-1?Q?KOotgwx7zd8ft4o65ml3swI1Pl8dD7QcyLXu60OPoVo5j9kLtyh9+yJOla?=
 =?iso-8859-1?Q?ezRwQqrvCxSswPQIuMVEySaDRmxplYIIooeqt+ahCmssu/C4RqseH/eIof?=
 =?iso-8859-1?Q?UwVhfZ+LPXA12fSVI15MUDfJQ1soLS2zdKtA+A8+SPSMvHGRLgPItMcEKE?=
 =?iso-8859-1?Q?mLnl9sedzAyxkfG3k6WCjDjJBE+FDwUz/5Xh6Pc2n1IJ6bkk3Sba8M23PF?=
 =?iso-8859-1?Q?elbOawuh3rjtiYuv+VfEcJ/fRMUcLg63mbnKBnuPvuzVD4YD86YIKnJh7l?=
 =?iso-8859-1?Q?m1vdvvEgIJUA4AZWWbcrD1FNWjzWDR+5OAdGY1uvaNyhd9EC69PrwZCVb1?=
 =?iso-8859-1?Q?ZlDogOuigb+tHKRpSC7bAiCSpS0D1JIyPXj4pXCCz/zBqUIXirTWAVnNFg?=
 =?iso-8859-1?Q?cPP2ycG7sSPMDgBklL3rkzf6xo+4q9kB+ShyMCD0eea/Xk8ymqpJETLI7t?=
 =?iso-8859-1?Q?kMUhDnjPae5Mb2Ly+p/4JibWcd6spHQS5ylgd7Q2xKgBF3WV5yFi3hQ0Mc?=
 =?iso-8859-1?Q?XA1PrFUqLdmnmq98JDv3sUHOTx/CfhDKmNAYJ1UQ+EF22H7f9/13SPqMCi?=
 =?iso-8859-1?Q?68fNAzMbc0o3rJQ4b/uFL62NkM+Z9diTpdw/07RBLYKuqRoKUXVXuIZSEC?=
 =?iso-8859-1?Q?iU+NgzevAWioxxBh8KUP8BqXIxHbFC8Q5uJQR1WeL+QjYJZHYZkxWzauXL?=
 =?iso-8859-1?Q?Q86qP9VkdQ2N327MEpWhUjLeZRy+19r1CoJml6/LBDVnm+0OrI740v3KGI?=
 =?iso-8859-1?Q?3EIplJimkO8Lk1yBzxcUy6s+w263EAmFR6gdOstLfJoLPe1fx0RCZ9n1z0?=
 =?iso-8859-1?Q?21hIdgOcfARXOgJJCwiabBRss1Skmb7jP+nVi8+OrHTJLslhxaBgcChtEK?=
 =?iso-8859-1?Q?nPabIZH11dBkIpBBB+2ioVRkBIjBIkFoy1JCcD+oboY3JWX7kgiXOjNGjc?=
 =?iso-8859-1?Q?GmbOzyhiUnj5TMiJUNQn5JsTkuXst9U+mVQJsvV1/1oaGYKgtlskzkvdzT?=
 =?iso-8859-1?Q?qeBVE2sz+2xXUS5EVgBMjta+UyCKMNFnskiE+EpJTeiB+2Zi+sp0TJCJfk?=
 =?iso-8859-1?Q?n+4kL7hqYYKpgbtE1Iyg5WTJJo+bL3TbpXH53j6/FJFdLml/1V4bi6GZDz?=
 =?iso-8859-1?Q?E42i5zMFE8Clk8rhHG6kWY2dFsPDTReDDrQHZ20rs3jbxMPgItlUEJHofN?=
 =?iso-8859-1?Q?4fpgFi+NaLutOkvBxLU+WeBQtD0et20UxSUHd6p+iZKGunmPDc0CFx4Lbi?=
 =?iso-8859-1?Q?+iK/lqqQ138EXPVOJa2fqqOq18wA5VeSYjDxeQQk4RzkRVfrgHD3LgQWKQ?=
 =?iso-8859-1?Q?BQHSL6u0VfKzOLV468uIIel9QmJYticBDkupdRiOewWdRlqLJez8Bn2Qhm?=
 =?iso-8859-1?Q?ous3rlT3aNN+W5RK4Yct9doKaSC7D0TF3VO/zXNwpFF6au/k7FGpcdyVjZ?=
 =?iso-8859-1?Q?GSyiwW5+g8UL61exRBHhc2GEff8BVdSeoWVRoHnHEvlAzzNgwuaxbubzm4?=
 =?iso-8859-1?Q?ESHxLsUO5NBH0qEZst3kAFmg6mEF+wb/8kom/KBcL4+nK5R9S82XK2A5RV?=
 =?iso-8859-1?Q?aWnbTapiHunLlozXAovRVNHj7BpquMEW04rEMUcfABQ/morzLjMT5FtyL/?=
 =?iso-8859-1?Q?653mvOKTuHM0ynJFhBE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76061e50-fe50-427b-bffb-08dd976e9448
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:54.4769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ar9Lw+CMCYNYUN2IY4qb09L+Wkq7sqWZQjZ0kmS3SPosRVoZ1QDGBpWAfpXx4aJYdMFYIMSW7yN/FlmVaSXJYRr/FEEjCIV8U52yYWiiMCZGw0r6UIhGGuDaQi+LoRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10037
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c              | 26 ++++++++++++++++++++++++++
 include/hw/pci/pcie.h      |  5 ++++-
 include/hw/pci/pcie_regs.h |  3 +++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 36de709801..542172b3fa 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1240,6 +1240,32 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset=
, uint8_t pasid_width,
     dev->exp.pasid_cap =3D offset;
 }
=20
+/* PRI */
+void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_p=
r_cap,
+                   bool prg_response_pasid_req)
+{
+    static const uint16_t control_reg_rw_mask =3D 0x3;
+    static const uint16_t status_reg_rw1_mask =3D 0x3;
+    static const uint32_t pr_alloc_reg_rw_mask =3D 0xffffffff;
+    uint16_t status_reg;
+
+    status_reg =3D prg_response_pasid_req ? PCI_PRI_STATUS_PASID : 0;
+    status_reg |=3D PCI_PRI_STATUS_STOPPED; /* Stopped by default */
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PRI, PCI_PRI_VER, offset,
+                        PCI_EXT_CAP_PRI_SIZEOF);
+    /* Disabled by default */
+
+    pci_set_word(dev->config + offset + PCI_PRI_STATUS, status_reg);
+    pci_set_long(dev->config + offset + PCI_PRI_MAX_REQ, outstanding_pr_ca=
p);
+
+    pci_set_word(dev->wmask + offset + PCI_PRI_CTRL, control_reg_rw_mask);
+    pci_set_word(dev->w1cmask + offset + PCI_PRI_STATUS, status_reg_rw1_ma=
sk);
+    pci_set_long(dev->wmask + offset + PCI_PRI_ALLOC_REQ, pr_alloc_reg_rw_=
mask);
+
+    dev->exp.pri_cap =3D offset;
+}
+
 bool pcie_pasid_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 497d0bc2d2..17f06cd5d6 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -70,9 +70,10 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
=20
-    /* Offset of ATS and PASID capabilities in config space */
+    /* Offset of ATS, PRI and PASID capabilities in config space */
     uint16_t ats_cap;
     uint16_t pasid_cap;
+    uint16_t pri_cap;
=20
     /* ACS */
     uint16_t acs_cap;
@@ -154,6 +155,8 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
=20
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_p=
r_cap,
+                   bool prg_response_pasid_req);
=20
 bool pcie_pasid_enabled(const PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 4d9cf4a29c..33a22229fe 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -91,6 +91,9 @@ typedef enum PCIExpLinkWidth {
 #define PCI_EXT_CAP_PASID_MAX_WIDTH     20
 #define PCI_PASID_CAP_WIDTH_SHIFT       8
=20
+/* PRI */
+#define PCI_PRI_VER                     1
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
--=20
2.49.0

