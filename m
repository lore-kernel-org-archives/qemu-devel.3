Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D61DC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXW-0004RM-E7; Thu, 27 Feb 2025 05:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXU-0004O3-PL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:48 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXS-0005oQ-Pz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653687; x=1772189687;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uJlqSs57TInsB3tqU25LwXRqfzPv1aIxe7YNYeKhHCg=;
 b=B4oo8sBve8WSXinmL55BQUwy9be168x6etuRkQNaSFvm0gBHsTLOKCOB
 j1xtMndbpJwFqgO7dg9liNxE5bnKWaJ/s88g77SobkPxrNk7/Yb35wJWh
 p0RnPJT/KtBgidwNGYIYfXq+Ag21DRXc9S64v8n1RwC8WhPlh22+e0Hqu
 8lVJnFXxDcLbJPhBaZcrURomxovsjDk9c0EnN3apYzoUsrw4lER2XgRFs
 FpGla6JUT1i0SmAhOje9q05gQBy755znMA0sxrWbE9+G4WZcAYGFtECO0
 oUItzP3wBkj7b7lkEiRywWkenNk96zqULgwik0dq2+5zNmYVJCPvqbjj+ g==;
X-CSE-ConnectionGUID: dOGnd4qaSTGoirVkyNPjgg==
X-CSE-MsgGUID: MMwO2DUwS9aZDOmhfAf7aQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331823"
X-MGA-submission: =?us-ascii?q?MDGG3lP86Eo77XeRQH4/ETnsNrpH9Z0rxNc+dd?=
 =?us-ascii?q?S1jFpTZMxPSiZopQCqLZZ1QIzqr1a8MaNKSHYWOPMQosYI39Y4r2HopJ?=
 =?us-ascii?q?vCF39FGwK9ROWfh6Q1Vagi+09OlWUP5fyNlA6wP3XC1tIPjlNNtU3unr?=
 =?us-ascii?q?fahgVmIi/MNTRwPiSYHG2/TQ=3D=3D?=
Received: from mail-db5eur02lp2107.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.107])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:41 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFrwRnfsbDMdbvbRSOB8e/TYC4ZIHZNztOkfRhLwMZkchucMDKxFsfvqMjn9RqhfqZuU9BGM6T7VbwBmRA6dhNdOzPoa1+TxGslTzrrEKQIvXqDjYEZxX6x1ZB1OeZqnfP0EpuNXQiQ+e1PThqefVrXYBM7CnFWwMDsTVNiS9C7PFVAEgzIhtm1kIH4wq8a1w2wOJmLW49FEx9fI8U4Q2oajqEgnuTilbORGIs03ZR+lK29Z4MNJvVtRLA4N2Osf9L+7xSwdnAjlmAbhx8NkSTGI6nqaMS1sL6Q5ys6U21y/xhIaXp2ghwd/zl3ekGFt5KDdFio2qIQaI92k9dU8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIT6AiwY3yFCcHWXpCPT56LF2YCfuC6fJtGxDNZQlvg=;
 b=WkatrCxwncU4gx9TXU7d9/6fR0cK4tT0quj6GZh2pKtfv0glsv//qkmbCE09SgfcGBYMGsctbtJy3sN4HHIFzj6Od7Qde54PRDyzVHxXQRxlIJkPEo2f9awa1dz4Ya0vfW5kw3lpfCDs4Lr5rdhYZONGbUY/Yay/vGmXaTj1T4+2qG1RUZ881F3VKd5WGmVBziAuUVYl+yLxvMCZLZJvS5ZLp9ECBAKOviwQO+ywCVvLA35lF5RmWu2AZtkMGaH311+Bbs9eNkL6wlzhhaU8n5EE71FZjZq7W5sf+izhXrCIwfNDSOi41+LiG4PT0fYGo+sTxV0w43sJngRlCsDLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIT6AiwY3yFCcHWXpCPT56LF2YCfuC6fJtGxDNZQlvg=;
 b=ruzA9U4MhlFoOSCOAaGsP8VZen+dHMC3ZyawV1SfBb36pysfGFwkoTD2uvfqZim8HoU3qvqL6YiFGxTsoR6ziFY5Zs058ad4Xe4IQMQ/4PEPObUq/+7MvA+K4mWLlTxY7dCSFdOLSNZsLty5LGh5x365qyHklC5Hh8La9cs6l2hTalqwhQ01MXu9YhKzk5R9JGDwJnrVLaXBbjAuW+24RinFHCNsrVwQeJaLTUkXBKgdM5/rBKO+xrCTZpmWRrx31K3xQlubzB+XieXDgzaBYH5arV2BOnN9+A9eK4L73Tm8ZQNe4UPAsd7IQ0roS0GeHEdrR0t3b3w/3SmAmC7Gxw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9421.eurprd07.prod.outlook.com (2603:10a6:800:1c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 02/19] intel_iommu: Declare supported PASID size
Thread-Topic: [PATCH v4 02/19] intel_iommu: Declare supported PASID size
Thread-Index: AQHbiQX/o8yYX3jsPkeXKn52+RonVw==
Date: Thu, 27 Feb 2025 10:54:39 +0000
Message-ID: <20250227105339.388598-3-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 45df9744-c6ff-479b-6e98-08dd571d21e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QjmrrSOvdyCi/IHLqelhwvlQ+NiN8P1bOwTS8EZso1VzHcPJEbcdSq6Al3?=
 =?iso-8859-1?Q?xxzSY+bzXB9jV0BwfjpQ2w7s/trFWfINUb2txlJLvSQqrp24h4kQW5CpWm?=
 =?iso-8859-1?Q?8nZ0WnBSwmOspRPpmY4Tnb2m8GPyeuYPVh/EaMwxPZKd9+ltvAc0LasgjM?=
 =?iso-8859-1?Q?FU4wFCkaG5hHej5JoOKc4DMHj7Ekh3y1Wo9HUh8jtwFRJJicnpME0X4mhe?=
 =?iso-8859-1?Q?L1cFlIzx57XB+cdWorxzBKWSz41aa5+ScgzFtbQ4i7jZp6/McexabSN5Ys?=
 =?iso-8859-1?Q?Uqtj6De8rx2H0f2MZqdChtFNO3rC9c/keCSaxDrHd4MksZOsJvGdJpdA2o?=
 =?iso-8859-1?Q?dGBKAfa9eHtonXX8nS+S7oJqSmZ7IRaFQ7no3ClCiWZi0+u87hOowv7Uc2?=
 =?iso-8859-1?Q?Efb6PtmSTs8ktNqciUfaW6FKORqDikqSlKze688X/t+1PPgE8dTstMBg0i?=
 =?iso-8859-1?Q?VL0WooBNaXSy7e2DQ1ZWqE/fi+3TT036qD/OLsR7oDXG6+F44JoQoFS8BX?=
 =?iso-8859-1?Q?T1A4D1KaAgYPzEqOF3B3IOzMs48pOjptoblmANwnZk3t2fObNx9fPKb3Cq?=
 =?iso-8859-1?Q?AmqkoHavSMZ/xIlym/K9wWnTKnXi+QYjBVcTy3sKiEnWcgLPqQ7C5sMzkX?=
 =?iso-8859-1?Q?FJBWCwj3CFxyGg3HJH7MaNGHGuBNTqNzGAU9tMY0WzlJfpLp/fJz6EQ67u?=
 =?iso-8859-1?Q?+VJJfLNnFba5UbHMXAab7mBqU6fI4/i1gBHyrlskQZA8PSW6CjE/EQ4Hzb?=
 =?iso-8859-1?Q?2tPIe9MFZ3h5rs7XHr/fJBgVeQkyrylM4pGX0Tys7wu6r7+SWCrFQQJvf7?=
 =?iso-8859-1?Q?n1vJKjEtsrTGtIwAeTTP/pobsXbXpGVdjQVXNeTlYw8kGxFMR8PdqQR4E2?=
 =?iso-8859-1?Q?gxmy5zuhxkczty+noPguEcNzqkPySrwP2wEZznt1WTF9dilsjgWdeFVJ7M?=
 =?iso-8859-1?Q?K4CG0oyYypBlLhdEZpLv3VHKPotm9Bf+CT+16BzNt9H6i1Ymv0iUz6gGTA?=
 =?iso-8859-1?Q?mTxWhQhYClVwKapIivWzb6MgTg3eLm107aNF2QdupjmoGmZTnruUlxMzrh?=
 =?iso-8859-1?Q?ownOS5AaWg/NngrwXfxsAXFzXbB8FgV5hWxnandyUXVsKXMnk9iTc8rQwU?=
 =?iso-8859-1?Q?ublTsIU8DkpyCl5wMQwX8CzgEz9NI+C9w7tM9DdQGaHQRy4F2xToIkOoPj?=
 =?iso-8859-1?Q?3CD7n2lPePFzLMVPA/80Ry8NN+Z0VvV0O8mc/81Ep2lMqyu0O8Ske+JnJA?=
 =?iso-8859-1?Q?VJsp7K2JisvaPcz9+p6K+XlbOXIm8fenS6xMjfZns/8AkyaXW+47fhezOK?=
 =?iso-8859-1?Q?h7JgLiaKmLSdq5e6pmPDJE48kHl7N2pk7GIp0uPyMUcW7WxKfblxZbE8Pz?=
 =?iso-8859-1?Q?y87iP7aemg9w/nOWQYzAG20gcJzTRTqX1pa9BxkkSBL7shST9YPNhe0qAF?=
 =?iso-8859-1?Q?4u6BTwTKhSRDxbhIG+2RHGpk21G8EJHjSRVCngNgOMQ30IEIkmw1kwtyhw?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r+CYblrJtol3Iu3mVDrj7pBHOYwkeMm5U7io8VPAXk6T5RGh8hpbC4XTMv?=
 =?iso-8859-1?Q?Ro+5NTg2Vk14FPeR3ey++ZwGVI43AsjlkkxFiNhO+Hqnq2LImSIvndOAnT?=
 =?iso-8859-1?Q?fnTkNry1E+zGB3sp99EHzzzzz/Ppa4B2gGwCHAmRDDYN5v3xgRWCYbuMDI?=
 =?iso-8859-1?Q?Eey9cCbxeG9wZ2KnFEDeMGgn9Fs1nZtYlLNVRDjubi9Ug2tEjdZeMkMMZP?=
 =?iso-8859-1?Q?WYriJEtzwD3cnAyoeuAVGc7bo+n286DJnI9IPOzWjluRjDw4J5Wu5Q5Zsk?=
 =?iso-8859-1?Q?sY+3Ot4cz3ZvLtjI0YeUDA3cEnNOjFSRVxNgszENniGu5NHU4vm4q3QWqo?=
 =?iso-8859-1?Q?pZSNByMlhFf0Wk8nxIDX8JbEZWr+lfOmEliuZpdm/Q+jWHy7AvaPlwg+TT?=
 =?iso-8859-1?Q?h88ZsRsNHd8Pn5MyT7fNDNvOC6527KwGY0W9WZ7XpCLGxW4aoXcG39tPsN?=
 =?iso-8859-1?Q?P9TT2Yz/XEuphkqXDiOLlWayj5qfxXIUuPAjLij/QFaxxp4DSIGnoYT+Cj?=
 =?iso-8859-1?Q?vDqLg8/ftJ1niR0fc03TsB6ygvigTtfHT2dqeoC49djv4/cr/J4KJNkjeX?=
 =?iso-8859-1?Q?nrqtwBhaZZv+gGaX+m899LzA8HQxlZZdTaFDbxfCXRgkzNhiTLYtvoSpOL?=
 =?iso-8859-1?Q?dFbrAOu7pDnRi0og0aMimtcOhgSCfARbGOhKCApmCQoEnFR6PG4nlDi5Xy?=
 =?iso-8859-1?Q?lAD/lEbt5vMHPpo5euRop6j7NiX+4eXfWIwnN3RP3tx2p5NZSUCApRNLuX?=
 =?iso-8859-1?Q?S907IiJXOkBtbMT1PlDwZ1hHfdqhkIk/49wSKcCIPehzD3W9Xc3Qq8gM8H?=
 =?iso-8859-1?Q?rzJPemMcR2dnmKQauu03mKfYPR04TUneuUh+xRIbSaZZrBhr39dmYeHf2Y?=
 =?iso-8859-1?Q?dbGsq9mOiE0BJvGGBO/TeEhSS2OVHbN/M7Z6TyQPOIigPH55Jqp4bbUKWv?=
 =?iso-8859-1?Q?/Sd3B/3tK+xvKg2G2xTnRMitC1fjqlzEKgEBJKOCK4LnH7obNwQlw6ZgzG?=
 =?iso-8859-1?Q?4D0SEI6do1NA9+CKjv6N7VStSEbKS1bbHrGAOfEJeJ0P8j2h/IZ2l4Dq1j?=
 =?iso-8859-1?Q?W2q/2wd8Bhv70ouRgH783cBuxsXudTQNg3wltrtPhk+sTn27JPRlvfpgHJ?=
 =?iso-8859-1?Q?uGqO+Su+6YAQI5BANvGn/pkt7YyqFsqX6bfNK4qHSf982zieXEWG+XesRs?=
 =?iso-8859-1?Q?jjTZWhIv26dypwkH9QTUGoByxiMCVne5VIPDa4U+8Ac9WApU/+d6BsJ+HK?=
 =?iso-8859-1?Q?P/o0vDoIvjacRNdxF2mXgpeNCjsysPCzsOhDjDGVtGAvVvR9adKINE33Ru?=
 =?iso-8859-1?Q?YCV3jXdbgXYyIHtenzKrAuLmdKAatLbyK+RAaY6ZOru/JmyzIdeUKjVB+h?=
 =?iso-8859-1?Q?/w2WG8oAzwBTcCW62c+YH1gxvvY6XkNS6pvSuit5yM8zhSn0RE0c0qp1l7?=
 =?iso-8859-1?Q?hrOhNDkxDH77Rbro+f7FevChK16zolj+yFX5rvHo1mFbns0nj+4IthPxM1?=
 =?iso-8859-1?Q?Nu6zLAttSb8VE2xmS18xJlJgd5jYclNG0jynLilRCaXwEU1/fKJzWSevHi?=
 =?iso-8859-1?Q?h1JoudYjwwQVG5BwWgjPTm1qhboLZno8R2uqq8QHDa38Hew4wIx6ffLg6d?=
 =?iso-8859-1?Q?FvTgmwA/7/zQIemlmZV0XyAxSiBiAjsaX/L0G0gyv7ctuyLSJfbbVAwZlQ?=
 =?iso-8859-1?Q?+zYJTZzblVls4VUcsa8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45df9744-c6ff-479b-6e98-08dd571d21e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:39.0547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9T3B68asy/jpmCdamHkSuwePzHraTfP5+u55f4dmsEnsczZESUzxPBjMufm1SLPLNLLMFfXO0EWV//4JbEWHo942GmGKZAY68YPS7FrQR2vfjOEdGqtVFl2rg1+GD+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421
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

PSS field of the ecap register stores the supported PASID size minus 1.
Thus, this commit adds support for 20bits PASIDs.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 2 +-
 hw/i386/intel_iommu_internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7fde0603bf..1b4aaffedc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4574,7 +4574,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
=20
     if (s->pasid) {
-        s->ecap |=3D VTD_ECAP_PASID;
+        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
     }
 }
=20
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e8b211e8b0..238f1f443f 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_PSS                (19ULL << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
--=20
2.48.1

