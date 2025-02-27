Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CEAC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXX-0004Wy-To; Thu, 27 Feb 2025 05:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXW-0004TD-S0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:50 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXV-0005oQ-3a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653689; x=1772189689;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XhwWxkxj+r+rx/BdxYfbt+I91UI6Lq8eWKoAUnza1aI=;
 b=VmFSfnXvoAkHEs8qctvne1y8DfYDcBh7z9KszMgweYvSoBfeutSjkx/u
 dQlokYOlX8sgy7ezAs7iVrYrK5Gex9/D7V1sfnmeD/j0CjJUIbpIDtCFw
 j0IevLqdPROkD0cFhpR6HfVhUJzD3Oy30a/STmDuNcSr4HocHWm+bmdzT
 8EmG+DLz35EXCHAyqQp8gC0dY6IBnDmi1Qjx45jMTYO2ZvI9XKv55KAV8
 T5lSCsFuy2KNJlfFtVAG9scO7i0ryOqPn+XhbxOvP3ndEcmhg70Obx8U8
 5a7BwLfKHz7ro3r0smKxvQk7TTX/5wkAaor4HLK1FuT//AzC8ZQ2xTDGe Q==;
X-CSE-ConnectionGUID: AipoGuUsQM23ZODy2HoA7g==
X-CSE-MsgGUID: 5Kmz0VzkT3qKSPTa1+U0jA==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331836"
X-MGA-submission: =?us-ascii?q?MDFMn7zxU2kL7e00rol4JjG11BwMjOpq2uVE7l?=
 =?us-ascii?q?YzIrWn+F6HVkvWs3nDsg0TxCrqG0FvyxMxOpGXDzVa05gA/eQInCrFbi?=
 =?us-ascii?q?2iXzzWKjzk7S+HNk8bp+LuQNc1dqfse2mroB1/RptcrhCtFF070pbod8?=
 =?us-ascii?q?YD40WpRBnaRCAc6VURIpQeJA=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:46 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar4JRn89qkDkRlL+rTf1LccD891Z07DFpgFWVH1gp0idyNKcV8dckmR3iLcSJmX0H0ENxwQeUhcYlYSQXvm+mTRedMB4d1ooG/Fxx4pHsvC6MDBaTsqAgncXSHUoWFBv4QEci+lqzTL6EQ1I4PEKMv0QzTOjxCnheeKXlfGX0Uo2Op+3rmrEazC6lCak0XjavirY+i7wkYuGncJmHY2qhm6S4VFG2XTwDMahaH0HiXG646bVUxpcHMKkuhVPadlbmw8UaMrooFiId0WSrLeVaBHFPgdb1PuLp7M6ZqWcJcfG9FxsAAqRukw9s0zm/eeOfig9iKfoiAdtkRbZduo05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6V3J9Voz0NXho2p4lgx9KAMBt+ze0a2/WvfE+49IGI=;
 b=MtudFh5ZWSSsESxs5RqyEm7Wx/8XUT8eW+vzRJ0jAy5BTYoUVM39I6uvk7XA7x0y+tFo71WqeINqu9PlAzXesh7qoQQEjGmlkfM50fUfRDYAK8WFMFMIqD3YrPZqnLcFfvjqbG33TjEdRPrhYqekhdRjUXXPcw1Ef03uLl+K8LzxV6wuJNz1ORMoKobJuDty/Xm2viLo5Qgx1IAqRN6qJzS2qHp3QbMIA1yN4OaCrp9U4qfto7wTjaso4vkS/y+r+oby7pX/+3zg454TymlZXMBbPegjyuyINY9h17CiBG4PPZf+yqVhacxwbFYBJMe9sH7bAfzTM9aj1qgYPQ4DLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6V3J9Voz0NXho2p4lgx9KAMBt+ze0a2/WvfE+49IGI=;
 b=TUKKBGNZOnYA4obMLykxkp0J1dTalVdDkFJGtr9T14Fv/jA0/spjDHwTNyKd11GVdlhLHlQzNz8KXxusHLuhe/DVau6eLl8egJuNs2RoqvwJDg8wyFKdYUeMGq80eHnltt4HbHzexWtydIxQ8UEjz/PeJU7gntyUklrJjRqFu3NpSC0YgJtmGil1nBVlwX7NSijtUTU8zDo6lQ7bXhuZHvPgvcvUiHuzPbapaP220I/0JjhDMgBeYYQOBu2yEx7Nv9TJM7GQ4RKH/d9/FZP36ksKxUhHORcwTg9YqxIQOUL2s44B4OW5zuEkoGecK0KqGEH7+MUfGlqgX9q0hYcyOg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 09/19] pci: Add IOMMU operations to get memory regions with
 PASID
Thread-Topic: [PATCH v4 09/19] pci: Add IOMMU operations to get memory regions
 with PASID
Thread-Index: AQHbiQYCyRbkJwmwD0ajNXH4GYw/sw==
Date: Thu, 27 Feb 2025 10:54:44 +0000
Message-ID: <20250227105339.388598-10-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: 47d85f34-f083-408c-c9fd-08dd571d24e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?U3YlacnYl/ip60bHjxeP1BgH7h19w2s3yr5PQ+JuOIJU5fljpIZB13bXCI?=
 =?iso-8859-1?Q?95BCVBV7pLklQgu9BhC6moOtuCVxlnZxyYJxv+xrycIL6a5pph8nQv6nQm?=
 =?iso-8859-1?Q?oEtGNHTGhGCx9dYIe3bo3tb7RsBIeaHwmH770QYSADTE2IlZowj/2b3mht?=
 =?iso-8859-1?Q?ucXoesQgASp83yrxcQ95U6jMB+AVKMeHP84OHABKSfuiGw0WAE3Lz6q+/c?=
 =?iso-8859-1?Q?Se2aoUrRQeM1HTPCwa18h3tTapnqnCCfCXvgf2P5l2ma+DNa9nIjD9vUdF?=
 =?iso-8859-1?Q?M3IKReqVlBrxcw3x4pWbNTh//2FH71CIAxOVkxfznWUFTCKsjbMFo/9lKq?=
 =?iso-8859-1?Q?l3WqBLG4q3DxK9iWD7uNTFGEowMBZRq5sGceGuOOMk6sha/goDFaff14/D?=
 =?iso-8859-1?Q?9vO42kKsSUXfiWT7LOmm+ySX7kbJsvnB7sRst6wxDVOEUfVqylvmqIOvEg?=
 =?iso-8859-1?Q?xEO7XLZVurz5ui5hAkp0HfxHNweJXE798eZm5vUniHQRAxlNQE+qMCdySd?=
 =?iso-8859-1?Q?2xCT4Mn7RpCxmqpcaNQhlvqp0II1jiiFa9Y3ci0zktz2q0TBjvQKmShC1k?=
 =?iso-8859-1?Q?Ubx9Y6+Ozt1VLQld22GwBZntOLbS69ocAFxW73KSx0o5D2ZZ6Ex6yRWu9i?=
 =?iso-8859-1?Q?VI3drPkqF3pgTgj7k3tElOz02A+SNk06JgVGSNdkHae97RM1gacrAf2Xey?=
 =?iso-8859-1?Q?wJE69rAu2MOEAwxuKlZlDvkdaiUHy4B1ZefMiolaT3omf79MIk8tG0OpGm?=
 =?iso-8859-1?Q?7o0QZE2g7/Cu15+rx9QWfaqgc5/hKDTi97NPHHfR120thgg7NIbI9MvOkx?=
 =?iso-8859-1?Q?Fi01lknCr99Zz3a4TqYIdntq6lLFJZQieHI/4mh1fP5YDVgSu7m8ZTjHqR?=
 =?iso-8859-1?Q?ll/ysZEwW1dAqN4fCo8XdDoYK0VhKz778BehUyfJ93sDVh4neA6jTra0b1?=
 =?iso-8859-1?Q?h7FSrZ6gSO9Cz1emSquThkYoRm8xIzFpclFofvbZ/Gm8eCSmp/l5GNd51M?=
 =?iso-8859-1?Q?QOjwbRpwZA0sQWt+TTwzijWNCXRlDGypN+Rtijrn0tTlqLFX2lChKFd46/?=
 =?iso-8859-1?Q?ozOnd5OrIIUSHHsvQ6vNoRL+ovrt9qdCYPUJzRjoXJXlAPQMJxF7u3YalS?=
 =?iso-8859-1?Q?+VUj2Rvuosc4DgvKFC7H5M7U9B6oJiQrH7pVcNbMQO0QLE9G40mZitbSl9?=
 =?iso-8859-1?Q?nmjGm38/xT4St6wPVabdzCkRGjhXCekuXwDVgFBnqVdixGD/zrbyrYIRe0?=
 =?iso-8859-1?Q?cwqmQz4pU8QtHpCt49AitPgZkdZTQAbzkNG0nzgm663tpFHmCepRMg4kbc?=
 =?iso-8859-1?Q?YhQUneSGE3aTfK72hGt2ZZM+4S6tJXT+f0i+74mOKniXNuwT3eE/JJecHf?=
 =?iso-8859-1?Q?W7WtpOl76l6sPTCAn4A6Bv1Lh0C1AIAYacXu/p8aKHWBNtRiukRoCUDpmx?=
 =?iso-8859-1?Q?pkUeqZUCb4ua6CREuIOdEEbfzou1T+D+rygyvouvHltuWl6w+HtBPXwn1G?=
 =?iso-8859-1?Q?KqGpnK9+ydVfn3pXU/ISru?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mRqa4+GGXqqXXHZQ1+kXqnxmOq9hyU85J9IQySruPSSsIXrAE3hlgEPSZ8?=
 =?iso-8859-1?Q?iMHmWTzcFCEn04LIqxs3UsJI19x93BKWHnYUWAeJMSFjlmkIOjA4lVN8LC?=
 =?iso-8859-1?Q?EQnr7tj/hcG/7ZilRcQf6xw7ltCmbPN5Z794VpPkE8x2KxH9TEBR+UxO3X?=
 =?iso-8859-1?Q?E7PazV/KewIt8xEJVH1+FyORELUSDOINqoIb2JLGF1PupnRPiUBlqlB1JE?=
 =?iso-8859-1?Q?GW6G261Is2i4yuhnLrfB1GalNPdMpuD03tx5Sa6WMBnVvDNmgetr1NROm9?=
 =?iso-8859-1?Q?Y7QClwb7H75Uq+N8FdPlfDrlvYqGLwvIs5GlP3Cm1ihpfzTPWmXiob8SRD?=
 =?iso-8859-1?Q?v8vnQJbRoVe0mC0fcCaIfe8w3TA6x+TTjZ68NtSK+sRcwmLwJtFMgWxIag?=
 =?iso-8859-1?Q?EUOok6tchbS1gGYAdrfVAAn4ww/FXrfopGx9B4XZogRebtNsXXAwDYnW40?=
 =?iso-8859-1?Q?4qJIbrH0vudrBVErPxJcaRKcl+8re90qIiUUvroBhSMhuXk9UVc5TZdEQY?=
 =?iso-8859-1?Q?it8XEfjTuua75fHZgJSXLH+PcsW+0nVhctJEFjPYGn0CT8wMzijpnhApzC?=
 =?iso-8859-1?Q?Qslggi293vsKvxFaZorOWPLBVp2EgykUFlNKKPYobyEaYsXHhd+NOFanq0?=
 =?iso-8859-1?Q?3KJ2UyMfqk0UyknuR6L+/O2bjznX3eE/I4f4RbOtLSC8K+/YXdnE/L4AZs?=
 =?iso-8859-1?Q?Bnd8NrG1DRfdE3ov60HQmB6TNOtXw1FgcafbWhJBk4OXVo+tfBSEktmKAt?=
 =?iso-8859-1?Q?97iGx+3KaPlCYcAaRWXq2kBEdCd3dS72Jn90FF5x6nZoSNVkt0O8A5/zBr?=
 =?iso-8859-1?Q?Tctoan5RkMm560W3pb4JsjdIaY5ys3sXkleiIjDaJ6+GF37fm67Taxefzh?=
 =?iso-8859-1?Q?yXsuNZcnZpH2wL0UTmTW881XUi9bgjbtVTlz+peub+BgAiNuLJYOwmoUBN?=
 =?iso-8859-1?Q?U4ItCypePcR2vRyBZT298n8Y8h1fmtlQqRIBDE8otuV5yegym+bZbs1Hi5?=
 =?iso-8859-1?Q?4LI5YmCkx/Gr0CUtjsCToUOC2fuKFfLkPMxoZLPHhHTJaXwo/IWFAZzI9U?=
 =?iso-8859-1?Q?U4NA6mdnFr4PwcpTPC3DUZK7A0c6hZBEaQNIme/f/Chk8GebdJqN6DBW/A?=
 =?iso-8859-1?Q?jDLIAUIglwl92XlAseY1Ce4kytoY0fQa2egFPqr6fvJH4Oi3myUbrkyI2k?=
 =?iso-8859-1?Q?hrvmN96XA8HScsG533V/moPclRtoL8DYjhZ8QvmNQr52fsKJdIDMrrN6Qa?=
 =?iso-8859-1?Q?ltVWVILTSH2l2R+fc1k7NIpT4cRUAOTN0O06NJBTdLnEJDM1OpQ62Yf/5r?=
 =?iso-8859-1?Q?+2yZzFnNGRzgQ1ukg7Is7zkV7u5H0fDewiflks0iBsKbMfqi9eshl5WfqV?=
 =?iso-8859-1?Q?iYDonlmtFnCO16lUgGmHtpokjw7ycmShiofxVvPp04r9WbjtxvJfwg96rt?=
 =?iso-8859-1?Q?So0jd3uLE/NVR0/LR9Ge3YPbKQcmAVxxKmbepbG6BzXz7wotrvQFn00QP/?=
 =?iso-8859-1?Q?PneAjPnWbFUctbn65FbXT8WdJVyEdGNOEX9rxALmt4RkmwS9xC/0UZox96?=
 =?iso-8859-1?Q?RPPkmmrAXSfigHGmMlioQXy41qRoJci3pQS7Kqcb37P17hvb7RDciBrGLO?=
 =?iso-8859-1?Q?Ma2+V24LDu8Axj6LU02+PvWFzCg3KHowQ3jzc+COOehPcyfTD+3d2FCYMH?=
 =?iso-8859-1?Q?fXWz32Ofs2hsRjDCCI4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d85f34-f083-408c-c9fd-08dd571d24e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:44.0526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vozy7G07VnV72BrU5Gwm6gc34geFhbF4DiIqVtM40xcN3s8EFP1XwULnEMMdKMqxM/2AMTJuWEdYgDEPNuxY3ZMKlpycnIumgzpjLNZ0NPpMnlHVi/4dFYuzJdw059Eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
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

The region returned by this operation will be used as the input region
for ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 4002bbeebd..644551550b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -391,6 +391,22 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number
      */
     AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int dev=
fn);
+    /**
+     * @get_memory_region_pasid: get the iommu memory region for a given
+     * device and pasid
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     *
+     * @pasid: the pasid associated with the requested memory region
+     */
+    IOMMUMemoryRegion * (*get_memory_region_pasid)(PCIBus *bus,
+                                                   void *opaque,
+                                                   int devfn,
+                                                   uint32_t pasid);
     /**
      * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
      *
--=20
2.48.1

