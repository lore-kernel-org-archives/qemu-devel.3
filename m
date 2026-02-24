Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBEFEFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6F-0001gi-MY; Tue, 24 Feb 2026 00:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6C-0001eX-1F; Tue, 24 Feb 2026 00:36:44 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6A-0001J8-15; Tue, 24 Feb 2026 00:36:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1rddaL3xBfyEQrBVuytXSpDXWtugdTBtrx1mee1/wXJdCGETh3LNN0dexC/AJkQOEf7Gmww4ByW7CpRDXsRusx6x+WvrELMuROfyQzSRX3FzKtJzkdhxGuqtEZ3QFlaWcvWc/Q9FzSTk9c++UfX4QRKJXjJtsaPjjG2O4jbO9ndqsqHFLXybt5uMGLox4NWWFgIwov1PfrWPt8f2QjVx+Mu9MiOuY4bBpmOv5Xr98FbKjk3dantRNL9CRUlaHbZRnXw5zNAfx89rVss+MghHhcN/DIRpGTb56Irdji9KmjSYx0/R9DjCoL2KHKVpLQlnVEp5MlhnbSrW7HiItyJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tptWmcjjG0th2rGgP0TRbzpP7B1VjMK9fwenPJhZXuU=;
 b=BpNorIxk1ddNyN+FvBpJ+pmwyeiec21Q3AxwIZi9JUcoLymbR8NpzkkE8j4WXSSem8dSczpu/lhfGyn9tqbtgpL3vQzWQdN9tKJCtDE7KguQgJCPmmTeL/pS1Qk0JWEc6lN0XN+pVmWQ59oqpTAHB8uQj1u9cbDPyOht+Z1UzQ6L3mhaGQ4hAWAp/0MsXsHu4bLiNDH/ZK7L3Qa8trINo+aMJ4iI9QaUTl5vELDqS2Eej0P45nemKQtDtxIZoFdIkzuJpjp1xIz4/QQeStpO6ytflj/LmxZJ6b3xQ98g9dd7xXWB7wbM/T2uCfTHJqUpJ6iJMtPk9e43b6IKlFcHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tptWmcjjG0th2rGgP0TRbzpP7B1VjMK9fwenPJhZXuU=;
 b=eG9CiS0uyGKCd6EtuH6inqCXr/hjJU++mK2vLetmbkGo1FjEg3UiXgoOpcih1qARwxx6/jEan/nJyJEOYh748RevGX2cXeWUcwrKORYqxQ3eOpjX4VA0TkpKXPNrVjJUop4AnTQ34kulFyDuB28OpyBNBw/0iLGKdI51oY6PjQ8UVsbxTQLeinBW0KaEyVXhVjB1xJ2FVv8xhy/yUEct3ZCck9YI+GbIhlgsLZsdfxuq2zVPcFhczto5AT+ARhIdjEDnztlBHmUu6uDZL17FJlJNF/jzqQfsXWTIThsXvdxSTzWDlKZyHDJMiF4xxS4x0UF6gZIXJcSYNmDV+NQoCA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v6 10/22] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Topic: [PATCH v6 10/22] hw/i3c/dw-i3c: Treat more registers as
 read-as-zero
Thread-Index: AQHcpU+GqXZNMBDML0+dDNxA3DKVuQ==
Date: Tue, 24 Feb 2026 05:36:28 +0000
Message-ID: <20260224053613.589102-11-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 84c120f2-e396-4d32-2310-08de7366a8df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Xfbmv5/PSPUdjRJDUPRVZXtzDdZuUelcm1geeyOwXnY5GNsOXksNT1aVXU?=
 =?iso-8859-1?Q?4BkknuWSKZw7ZPYe5cyRsLMz02Z3Z4WKVyNlgc3TPUJHzrr8gFct5PB6co?=
 =?iso-8859-1?Q?9XWRAUvR9w5jzn9Ug++B8V7IFYAVIfS6vxjojVqUwT7CFx05uZovd2vjv0?=
 =?iso-8859-1?Q?2caBTOPIk3gAWDRI+3uY2EveLHx2SCHDe9eVA2cLSbo6F6mx5ZqwzcKmEM?=
 =?iso-8859-1?Q?TJahNC5CvIWv+hVOET7NyCcVPLahX35j8TctQWBqid+9CaW6dkqcZQPuLq?=
 =?iso-8859-1?Q?Kz3yttLYqeVJSsEkg9LsBoS+UkM696R9qgZJFd/jWX/HtvWJS26qf/9wjp?=
 =?iso-8859-1?Q?nmooqLzNarf290fkACGO8MxLOs/MFJK5KAcs40A8040w5xqLG5i5q8tdAM?=
 =?iso-8859-1?Q?oVNPrMBNIn8ExyO2sYtdRIC3K9xRFaruIT2lyL9qRCrvmSNsYlUFS6jUdR?=
 =?iso-8859-1?Q?P5Mxm3uV2WI5gPUONx1eKodbJt1VOt5nY7JDNyd0SjGfeL9diEt4qOYOWb?=
 =?iso-8859-1?Q?Ecipf1U0MkNI/KEv5MiwcjyJWHI1cjiSfjHmd0g1rZohlREuJDQSY8JEx9?=
 =?iso-8859-1?Q?sPXEq5NLgC85hqnn5DmBxoR/ImKCVR3xLxgA5ZULURFYbtap+1Oc6Wegql?=
 =?iso-8859-1?Q?E2tLWPzyTWrTPbl46PRBzqcXle9q/A75Z/oR4RJAJSk8gUFYPj4/lLQBMs?=
 =?iso-8859-1?Q?K6mUY1ihKqszXx7kXiNZFz1aa5H+wxrVc9SmYOrbjYl3Qic6xn0PTe4Nv5?=
 =?iso-8859-1?Q?XxX9Ec4WtiJXE6H/97dIu0pYnN78ZVEfJozHu+qt0F+NJELCGdt9IBz3W2?=
 =?iso-8859-1?Q?T5x2/JhcsOCiTIAvoQlxrwYVY+dZlNbIldFacz3zR1DKRXhgTZn1pMP3dd?=
 =?iso-8859-1?Q?ZN0swJncghsD5fdtfvnzAt5Drp/34jVVbc6OCtfbML7fI6GvFD0DmZ1RBi?=
 =?iso-8859-1?Q?r5CWHs5v4u38cHYVYTPpPWx2+41/FCIPyq+6oC8jBbSEA2rPrSVqm4VH7k?=
 =?iso-8859-1?Q?tF3+xP38PP7esipIhJ7StwtgjfwdE0O+FVwF6Gfz92UiaQLstZyW8jqnMN?=
 =?iso-8859-1?Q?TIRqXllfOFqzWtHU0j6WMkCmmJqwgUT9xdfwAxE284cBmqrCYNjCcMM4R/?=
 =?iso-8859-1?Q?Mb2FSjKbSVEdHE+kencEn45BGM3jWdOyn0Jp07t98L90vTr5UvwOa/QKpT?=
 =?iso-8859-1?Q?T3/WUdGRWO04pmCC35XpztsH9RBdY30Ot4zvrCR7rNgKPPusjpdOij11lI?=
 =?iso-8859-1?Q?Ddc6h+aeCEAgmIxIB0nKFkKzgL4YftmtaD2wQmPhDZGg2IhSNKG6c9W1lP?=
 =?iso-8859-1?Q?AUOY39RmYkzHYKbEX37AV1exnq/ko0zGsa4bZk1X8124ALhXibHsVjMVRB?=
 =?iso-8859-1?Q?5Uxv3nRzaD4ZhK+9E73AOu1gjx/50TJw68W0K92nc8LHI+2SkQPtZxiOKc?=
 =?iso-8859-1?Q?hD4VgWZjbLr/V8yYsPDrf78hwkRQ0F7EB7pSOwjx3WdFZJS/h5s3p0EHiR?=
 =?iso-8859-1?Q?8IP3MRQ6YdSOm7P0LIH6A0dRR0UIVsSqCHpUx0FexOcRYXq9T2Kh4ZA+nz?=
 =?iso-8859-1?Q?o5Z/MFh0OyoLCIFtnhv6efMiO5b4aWU2gN2GzdT8htWRlxOEh9eAwQDjI3?=
 =?iso-8859-1?Q?77p7b4IEGEzeZYs1UeP/Mp4/e4RKTPXna8ISG2BgAR+Tq+sV4ogR4ysGAB?=
 =?iso-8859-1?Q?9i7SAxa/egyN7LsV/AdLZ5SwoCJK1xmRsYkrg7PH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b+eXcEVBNdzZLBtjI9sbz0nJkeX8AxZuebjAoRi0/jNvHkDhQDqvQTtdUS?=
 =?iso-8859-1?Q?zf/Ce5k+N/bU4tNyxz0dLNR07xgdlXMZsqL1SDXL8EK6HfEQgsz8Vkzf/E?=
 =?iso-8859-1?Q?bH4xeBOVR/h9bk8IsjZqYoFmHrEVeukJ0A5dEB9r9ETU4gQtdpI8ySGXLF?=
 =?iso-8859-1?Q?PZCc95LnASrFGInVtV1AanphysrVXXvhnKlbdQo3Aw3lNHsxNYCz/JKpfp?=
 =?iso-8859-1?Q?zMI+Uo8KytNqal2IwIVRchs1uW4d/Z2j8ZM/RmkQ8PDV8j0hmnII52sijQ?=
 =?iso-8859-1?Q?7GiEZNXqanpcENL0euGJ1ko4AB8I+uoEsgsmVq9aeZwUQpAi8AFZ3i+Bry?=
 =?iso-8859-1?Q?iy4LJBsSokxZXVVcbHUUdqi7rSisypRXnpGuiJJWIvke75RyHyNLC35xzf?=
 =?iso-8859-1?Q?gZTB2D9pWK7SFMX2Q3EeATexSuop2N478jn1tV/FeDOvO6d+IzauTboYjX?=
 =?iso-8859-1?Q?dhghEmb9SOegrFe/5zUbY2Z/AatbIxwUgMoykaUts7W+SKqhpzS8APu5sj?=
 =?iso-8859-1?Q?juqqN+DRTOjxcRhhCiYCKaKHz4LBiqK/4m+16pfaLnYyvfiIttXjwhCG3+?=
 =?iso-8859-1?Q?JQCKoeDGxd1zsmV2iIfHKZr/aWcYRrDtX2MHc1Bzu8sHHjAxf5EtThFYTb?=
 =?iso-8859-1?Q?kGbdE0SCWsm0ycZZ+tvvOcKarQLUFo0WSNWxbfQBTDktVYoP+OuQvJxFQm?=
 =?iso-8859-1?Q?N98bNN9u1R3HMsxBF0Xz56vr70WyJaotHDVD7oE1keMSPbrA8weaatE8PE?=
 =?iso-8859-1?Q?vIAxfMDLkwlU+QxATDht27BBiSjUXecoCnsjEU9R4NqetlenUIXuoQlHUW?=
 =?iso-8859-1?Q?TN6W2xSZ1/fEyblixO9hq5rgn146NyVLO4aqYXH0fFi3dtpDcVwZ6d1NL2?=
 =?iso-8859-1?Q?D1q+ZyXCP+0sZ48vDjmr7t5XyynKXGuM5sAy9TI7OkeZ9AfVWKWY+S/324?=
 =?iso-8859-1?Q?Q2eu2vRHKlCcVsB2RrxKIv1vSK+xRJmw5BDknhhpPQDye4NUvIwOw+PdW6?=
 =?iso-8859-1?Q?TyDUfJ3+VDd7khlnV2YpPJaYcNV4U7pwpvj1+NhQrrIznf6o+lr0ZJ0REw?=
 =?iso-8859-1?Q?9kH8k5x9fiJlgGNFJ+0OcwuI0VntoMW8bNC1R254Rs+udnPTg1iU5hd1P9?=
 =?iso-8859-1?Q?lfGt2zFq3ulHgNGgBztMKyPOYnnw/fmf4wbdLnM522V+4CgZZXmTTV65A3?=
 =?iso-8859-1?Q?AOH12Gdkeu1PB3UkHISnj/mjAv4WARfitkkUvItjMLX2FUNV/go+N69ImI?=
 =?iso-8859-1?Q?lpBVfWrjuGSDsCp97KSfl8xQu3dULuaDiFNLhjtaAv2hNSm5EP2XEO2NL2?=
 =?iso-8859-1?Q?hIXolIwJyLKlc+26MBly3TWBGslOPkkWfIJC88h/nmoCmMkGt1AdsJAxxz?=
 =?iso-8859-1?Q?CDbThrvttgd+5H59PhH/m2BGj58GN0GjO+jz309dknHfxwhB4oQW3XX4xj?=
 =?iso-8859-1?Q?dQjshT5Z8iH3RnMEvV4amLXeDi91qZTVe3CnrvEd3D9e+9f60H4TuYgPt7?=
 =?iso-8859-1?Q?pAd8acci+iDYT6UeB0jrzDpu3z6fXKwLGRMstQskjpE/9DixXGwlWIe9JH?=
 =?iso-8859-1?Q?5RlIvjcwI9TMS42eGzaSgqkdBSaDXsYTwnHWHt2xcBgBL6/fdAsBQhBMYT?=
 =?iso-8859-1?Q?SZvXbs/tf4HYscMYSsGd8bpfE/DQqzBZrPfpiHAdRhmoX3L2adQNXSQNBm?=
 =?iso-8859-1?Q?hvrd/ACjnjZ8SDNKPWZ1noErMKreeVaU8mesScvomhd1oUr0BFoSVsmeF6?=
 =?iso-8859-1?Q?TprfpItUMHrIl4BcEvVQ6aDqNdumdKFS2JCYAPZWFS7Rj2oRA9mFV8dgR5?=
 =?iso-8859-1?Q?L3i2xAEJZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c120f2-e396-4d32-2310-08de7366a8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:28.9760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWB0omNiQ0osLw4d1ilCO3mwivK1xGRQOu1D4FqRoaDuOJ6qI1JdI6zBtoqRQhbyXBbot7/XiKY45PuSGd/qkJsAPfSJzSW7O9j93F9aTQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RESET_CTRL and INTR_FORCE are write-only.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 87c8f63da9..eeaf1125e4 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -342,7 +342,10 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offse=
t, unsigned size)=0A=
     uint64_t value;=0A=
 =0A=
     switch (addr) {=0A=
+    /* RAZ */=0A=
     case R_COMMAND_QUEUE_PORT:=0A=
+    case R_RESET_CTRL:=0A=
+    case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.43.0=0A=

