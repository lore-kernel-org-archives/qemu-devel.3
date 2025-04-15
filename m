Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAD4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 15:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4iHp-0006uk-VA; Tue, 15 Apr 2025 11:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4iHH-0006t3-Mv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:32:48 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4iHD-0006Ih-Ka
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744731163; x=1776267163;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=MmBRl9IhOFwBWqLUtNc15M1qNrJQ0F5D1O+X8W1cY6U=;
 b=NHrZd73sLLo7XMr3VPo+yCsVGOgRS4T8OznCWkxJZbf7e97QM4l309lW
 SG6M+SZyf+eBzRU1Ku81BdMm7PpNhoxCo6Bcx/qCt+T8MqxDk+gMqVKWt
 6vk5zKm9Wu1TEOuTYA0qdvPN039Ry6P0gc60yoJwOSFX5/3Ll8amy92kf
 5fvrto+mHyXzCewFwDkfDO2ONU177/GnN4Oad+vkbeNAZjhkOFB6cT5v+
 vfcbn5dZ7lyLqNjpawCk30SWWjrKaTGiN/ER/8UVCyHdda3Rs+BreU0OF
 T6ySxgtpwPIWzWme2C8T/H724lHwskFCRgHbj6Xuec2Tviz+kdeSY/Kj2 g==;
X-CSE-ConnectionGUID: D6aYQdHKQKe1tenxCRyo3g==
X-CSE-MsgGUID: 38hIqqUqTXKjDCyzMOifhg==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; d="scan'208";a="35106545"
X-MGA-submission: =?us-ascii?q?MDGQoirFux/e8MMC0r8GdPxkLrQe4ZILaaFRpj?=
 =?us-ascii?q?vSY0btbZCBiKqGWva+pMIwCDNUxXUvBZ9Tcg4Zh2Ra3S0UMv45bNg7su?=
 =?us-ascii?q?FILKiHujd4q4rOYiaL5dmYj8qO3rSyYNOYEEmpolQnn+le0eHgvIRoS+?=
 =?us-ascii?q?iQHulACg7QOuYT9YcY70UVpg=3D=3D?=
Received: from mail-vi1eur03lp2112.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.112])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2025 17:32:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIc18G9hPE3qYDky5u0Ps5V9VX/jan6ody49pABWVstxeL7lzrVtiXloHQdfeiEjpRx9bU7uCyWNxGySkcAsHy2A6bvchheMEMZZMPRxrTxIp7HThuG7mfU+/lG0m4MugErIWke94duSCvA53sY5VMkLj3yfX9hRq0XCt+UaFqDXXpoW4rLlTi0FE3xdCOh8YJzIU/Nf70lPw0egTLtCHS7JMvCtZlOBGJALkP5BOC1YUINDOPdkSTX3VVGLxLN/2nUMonjUlInXjYB5hy8bgP5aXkW8NEY3PKusAiw6Ia0PMTeJR7GHhALk/DgL8IeDawUF489xh0VX+Pw6XE8xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV7UAKoC49LewDcJ08OiBZKSvgmnL8cEtgOlBodFCEQ=;
 b=vQhPzGQRgEqR9fiGXJqP5RHR4mPcITHfpTnaiXQNECzykDsTgm2LpTKxrhce3oN0FyuuwYuc2rUEg30TV+ydXGEYQD7k3sRTCQN7jEsrSh8xhp2xajKjYgYgsGl26XWcJrM2PYUpVS3l/ZLX+kJqgasAz1CYZgVnQCiMPYwgm4+1SL9SChmpk/GDx0IAPiBv7nFQRBsuRtbTZq+XdEbEEEGUz6kNsblF5R/erxuIZrBAE7Q+eO8Nf7Rg2csHoth8uET73mrD8K1UD3phmwIYYWIg3m4+pVAQfcuFQP2fH2Q5gg2zRsR9j78q4Iz0CFZ2uc3gkb9QHhbxpTYo7pL88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV7UAKoC49LewDcJ08OiBZKSvgmnL8cEtgOlBodFCEQ=;
 b=aKm1aQrsnLbOpec/EKDI4a/KXVa7WtevNW25Bj10+DIDZrcbBMb+3oM+i332b5cbCM4SV8RziUl1U/wSGcAToRq6lPARQ2cDG5s5hCscGlqXWTquIMPdhq6c45nTlj4dVUI2NZuHEFrMKUfrmeWsA8NYEw76RbHoQXB8rkA/lp7htMpb5Il/SxjVt0iwVT275eFuCbqd0szpzibb9do4DFiwA2uPhTw5bFJJlZfnpqX9k0RU5sA3LjMYXtFVvlHBwpL9UMbCeOOQmaIe9ydN4kARLpEVJGrLmkWoZ4jlSfg0PGAw/WSBNTOaJI6eoLRVCos9wO9mWp/kb67PDX9mbw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9749.eurprd07.prod.outlook.com (2603:10a6:150:113::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 15:32:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 15:32:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2] intel_iommu: Take the bql before registering a new address
 space
Thread-Topic: [PATCH v2] intel_iommu: Take the bql before registering a new
 address space
Thread-Index: AQHbrhue2kcg2h0OzUC/Qxqx0fdZlw==
Date: Tue, 15 Apr 2025 15:32:38 +0000
Message-ID: <20250415153207.372427-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9749:EE_
x-ms-office365-filtering-correlation-id: 16986efd-3544-4c84-6a11-08dd7c32c0f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rNxrkVBa3kedGtrM4rQpFKLDJo1W7IPLY7NlAA5zFiZZRImK8dMm0geIo7?=
 =?iso-8859-1?Q?HMC/fbHYiXkNx5XmmhQqsjJXXDM8nHmcc7s1KyhnSyA0kYUbyG4PIrF8fh?=
 =?iso-8859-1?Q?3rvfPlMG0uNSEkiP4yVZLlFpj6ItXSpDqvhMSCzXaJwdrU4U0GLPsSbuu8?=
 =?iso-8859-1?Q?1YsoL4r7mwEPOS32EIJT6qWYKUKH9dZo+Zr4Anlx0IMFmFPacbNaN7WYrh?=
 =?iso-8859-1?Q?G47TqLZi3C5FF2Fzh+M1w9nj7i5+57qpZKwuHFcHB/vUU44ch2uOiKjjnJ?=
 =?iso-8859-1?Q?RLpaXKb9/2yu8zqVaML5wE/D4sD+aNnCFngIMXVdScR5beW/hYfWesO7bx?=
 =?iso-8859-1?Q?3rMbcuY4kYhIbCcedQPCHcOOLkah9aCu0EYQ/WSH28cNWrZWdMcOcqVIjx?=
 =?iso-8859-1?Q?VDn5dnKXlKRSy8C+1vkyZkx56h1l1bLLpA7grsqpDTMHBcMuefTBeCa4WD?=
 =?iso-8859-1?Q?BZ+FO5ZVSSNLBCBdBSbDuoVpl1H4JSWEm3hbqfBkoJVMFhw245Al8/VVda?=
 =?iso-8859-1?Q?Fl+2Uizgq4gRH9+MDKdhLhtDf5uEvZOrBAJZvYnt0mk3kpKXeCgAD92W7p?=
 =?iso-8859-1?Q?BogpNSyyMVaa8Tl6wprqqgaFOOT1xCc44+X73uDYuGDt01dZ8yWArCNkm+?=
 =?iso-8859-1?Q?yPAyclRYdYAbo52QKu1hq24ONdA1SAPRaDX6RMqsSBK1ozrasdZWHOwFyl?=
 =?iso-8859-1?Q?P/b/HHW+lFSzmxrE4/ZFcenSMvGcIL02VW5oxzSKoYTyBy0z3NMY1ogt7e?=
 =?iso-8859-1?Q?rogEPj8O/lTtB69U10mt/7uDijQPObPFVMBzPBgTXs7iqCipj51xjknJR1?=
 =?iso-8859-1?Q?ONhFXx/5sPCga1cnF/f3qLWjZ+utaZ6l6O6dFkC6rERLeGoi/9ZrDyzNiP?=
 =?iso-8859-1?Q?mc96OhvbOzCdUqQ38tC05a7al62DrDC0i/rW0RKVDVfqOMobq9ZbL7mpcv?=
 =?iso-8859-1?Q?GwknroeomMxJlWfYEBkaB9CQF1ZHlyXJR2EIbcCy88PsQjWHuO+990qHR/?=
 =?iso-8859-1?Q?WlFTbDrddaj/rf6wyS157kg9YXWsbEbCC3m18NWLQgjx8TFM23JURtRjng?=
 =?iso-8859-1?Q?gCuoyqUIBvjcBdTPXGtsASrmtpP2iEi3T2dppgkfbLEYCoAoZqqS6lcti2?=
 =?iso-8859-1?Q?1YZUg+xik/rs0pVj0sGAuveyqy5ORxvKrGQ6rY0O+/2t7CtPNuCDC9eu77?=
 =?iso-8859-1?Q?5NTsWYOev8S4/IEX21WTdEGvfHidNip3f/N7NHOKsbm/l85WYLQdQOqKGY?=
 =?iso-8859-1?Q?3oVo5cUaaHbvLfNSK/CGq2lo1NUD6AehtqEdlz8v7gvxtgIy9wTFtZxYwf?=
 =?iso-8859-1?Q?Edzp7bJcC17FYzHW5sVeC8bhDNi8K3pd0y3PKlbKD2lcK7sIYMB6uNoUmr?=
 =?iso-8859-1?Q?qwIR7Jbrao9ckpdizCv1m6SHhA2HrAlKEL8bi54/Y9AVGskc1Vn6UA3a6h?=
 =?iso-8859-1?Q?Kdd1+9Fwnc0vdyZCYxxEEHZFdSHE7NXFMf2F4nSTg1pDyIsV1eHQfjHfHC?=
 =?iso-8859-1?Q?g0NPdCdIu8NvYIPF6zaM9/eXY2pU6mPBnLvBw94uqdQw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FtT64vWMZwDuPHfOwF/4l9w5SDVSU6+Sk1NZW9tto6vH2STTrnRPP7ObDi?=
 =?iso-8859-1?Q?dX2kpzKeG57+92xzZL9ZeBmiL4jYanok1KSe/cgMsusHx+TqajLeQfoW9P?=
 =?iso-8859-1?Q?PDJvnXa438hC/8munW/H7+nVj/0Eg29L9j+kDYJgEzLH4tpKv8nI65stoN?=
 =?iso-8859-1?Q?1w80mtpGQABHUQzLtPN+pzNbMHXr3aR2CQqdBRK2FTtXArDOrSBf6QGwDf?=
 =?iso-8859-1?Q?exHSTa1g7rLZvANl0nEmioeQp+HfqHapisZiJjGOciSFvxG2Ytu46FQITy?=
 =?iso-8859-1?Q?ff3Cq+6Y+OeI6Os/C467ffxLme55NAYX2MNvXNYiyGPlXkah+DKkqO2YYz?=
 =?iso-8859-1?Q?MblLi9ycnBoF6OzoekkfYdzd5TeIgL/8ihTGE2uiaArjJyUrTJcEMNyefx?=
 =?iso-8859-1?Q?c/piTGuExftuRvsHKcACC6mXux42FhzSg0fJO+8ILw+44q2hUarJxNqeP+?=
 =?iso-8859-1?Q?Udu1TD9XVIisandIJSUnPWGpl7KD5MILxxc7jl0tSjEEypiJTMPJlaJ2Kv?=
 =?iso-8859-1?Q?j54UWceEcKFwqS6C4c6SKWps8zT5vFJZk7mhF9bjJ6QFqf+Oz+6g8mQtY1?=
 =?iso-8859-1?Q?ggDmaQvUjHuPUNgq9OBJ2c8yrD3e9kpGbj+01F8OxvC0iZMQvNrohKwnDp?=
 =?iso-8859-1?Q?s1ntstJ1jBE3mHHtr7c8PNcu84xrkmCvc1pxHFASiAW+BkAxGxOpZxgEgU?=
 =?iso-8859-1?Q?GRdNO8CKU1LZcLK2Ez/dUMgYcRYqJzzC2cQt1QFKA6gZe58pjGwPoiWy0Y?=
 =?iso-8859-1?Q?q1UI+UthzIdtVHNGUTO+S/o4ALxW62cvtcDcjZjXXUVo14fjXYIT/X6rTU?=
 =?iso-8859-1?Q?K/nuionuZK4sG+f86tUAVmfsgQi1xZlENcZ4kpqF3TuEhx1s1P2XKtCkQr?=
 =?iso-8859-1?Q?znIEct+936TnP0f80uch99Vk0bGKburzOZ/vX20Ag6MZKOxuGBJVKYl8OJ?=
 =?iso-8859-1?Q?YMOFR5fUhaHCJnGNv3olvbS5PF2LJ9rCc/15uxQnJ1JfwrVmnc7X9Qrbwn?=
 =?iso-8859-1?Q?3ufa568APFPJFiv+w1BXs2clFeadqkmhzPzpd6MSe15aIYgWZRCQPBWwKa?=
 =?iso-8859-1?Q?9E6YpydPr0nGw7R97ElS19UY4ot87dUKkoCLDN6DYoGJHPkGXoH3aefx5C?=
 =?iso-8859-1?Q?bzvMpgK/k1+8pgVxfCGPDLlWbVtp0ZlQjn0aYW6I4jyn+rP/KDU+k4+T8a?=
 =?iso-8859-1?Q?BxB7vetGdDEgXjK3/5Pv8VS/9oYr4HhrbEJCwapnKopAgDBbTw3sHcJ71f?=
 =?iso-8859-1?Q?MgOjb4cCqkzG/7MveSR/jXSjgvkrA9uEulmXMNVMgZ0wx3b/vBx9w9YUmy?=
 =?iso-8859-1?Q?ZflVryKUbi0oqUC2951jpfsw72sbBQFw5ANBxb6g86/O75egYLqXJEi5pi?=
 =?iso-8859-1?Q?crnGwCrlAe1ZXC+tmSPa4hWKGXIFHErlmE3fnzi6x/XEqNVqi41yez781u?=
 =?iso-8859-1?Q?t5xPgnzhR1PhyNJkEdwfXtLS9onahWOT0CWER5KzkfnyDUHX7CIlEoaNbW?=
 =?iso-8859-1?Q?Z0Gev6oNT7fC6zmDj5+JJm/L35WsEKVlAeyYQ2Cssefa5dTIcz8V5dJPs2?=
 =?iso-8859-1?Q?qYzp1P3QmjpMb7xSXbpmKcW1Bd7M3K175lytpEs2pQR4gJ5o8rTFoavMPA?=
 =?iso-8859-1?Q?kQSXBVVeAA9PO0HTKMbpl+MObjXpMYYmd8sxIy+knzLy2kgpQtI8ABw1wv?=
 =?iso-8859-1?Q?TwOep32Mam7pGDMBrG0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16986efd-3544-4c84-6a11-08dd7c32c0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 15:32:38.3683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/F/YTZD2A+EaCLpY2olL5n88Sr2/rb7vEWhWJM+q6v5cu64zrQDm6GTxiedZbQK0nNEU1fULP8Gw6xop4FOEH7x6wypLP+OfF7A7/p+AilATVAFXIzGgM/n6M1fFnAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9749
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

Address space creation might end up being called without holding the
bql as it is exposed through the IOMMU ops.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..3df7a7489b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, =
PCIBus *bus,
     vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
     if (!vtd_dev_as) {
         struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
+        bool take_bql =3D !bql_locked();
=20
         new_key->bus =3D bus;
         new_key->devfn =3D devfn;
@@ -4238,6 +4239,14 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
         vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
         vtd_dev_as->iova_tree =3D iova_tree_new();
=20
+        /*
+         * memory_region_add_subregion_overlap requires the bql,
+         * make sure we own it.
+         */
+        if (take_bql) {
+            bql_lock();
+        }
+
         memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX)=
;
         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root")=
;
=20
@@ -4305,6 +4314,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
=20
         vtd_switch_address_space(vtd_dev_as);
=20
+        if (take_bql) {
+            bql_unlock();
+        }
+
         g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
     }
     return vtd_dev_as;
--=20
2.49.0

