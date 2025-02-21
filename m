Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C08C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4f-0004ci-NR; Fri, 21 Feb 2025 03:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4c-0004az-NY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:50 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4a-0005lK-Oi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125269; x=1771661269;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=thx/EhaMFSpCXXIfgOfxU1JCplMe9WF6IcJG11lYnsQ=;
 b=gsTtIgggJFjiI/rBm+UEhbttgznTjKf7451CEZfe8124GBwPr0UbAY1C
 XxrfvswFVEe9+b0szlfoHSfffaX2CD7Rpo6207HXDGGj1LslPxsqkrBFu
 nBxw3gwqv3Eby/McmdflQZvfIqWuirM/khH8ByQi0h0z6ZJKNvTu/Ijlq
 wwJlSpzZUfrvpUN9Edeut8zWI6iV28HoRO+iVZCBfGK67p6fp8qF9hJOe
 5vAh5x3kADMbSDI8bQWmXn5y1XAT62l2gQyQOxxdSe8JwvKpH70W7izLO
 MDuQmzk62mtjXH7pPquPbZO8cv12OaLxkfNPzqnUYi4RYGh/oYX5GDveI g==;
X-CSE-ConnectionGUID: g2VXE75BSGCFejAUCrrseQ==
X-CSE-MsgGUID: UHnVoGz5R0OIdYV30DUUMw==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394143"
X-MGA-submission: =?us-ascii?q?MDHFzkmhD1qEen6Y+FK5uN/UpVldkOd5F7iswr?=
 =?us-ascii?q?OL0whmDti5rQ+3TXkCeqWS2UFOQwi4SAsp+7O/syKEoX4acCEnbt+V7w?=
 =?us-ascii?q?sPzI16rT3auAwR08JaCD4aGKkvytX3qIWuavSYukjHzRTlW22bjFj8xH?=
 =?us-ascii?q?P3sfoKjEQA4Xt3zHHsy8woKg=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjX6e+A1Sc/8tOOqvl3vrX/vVGXfHhsvmuQU3NptiAWXpu7f4TnGQ0gmO3pXnJordKQKl1zYF6t19WazUGaNU35UNYqtut3JsXJtt+esxlrrhoTBQcFgN0d2ixKob2LY5UnnvQQ0EISsR3lTMHicFjgQql4PvEmfZZyqP2Rc3W0gwBKLm4qQaSLTmOlBDvS81cx3J/NciNUCEJ/6sMuZr/08ufoZcV+NTtCsWE8oe9STCVLzp+UB4v5GULy3xKo0f/+B99xZE6JzS4RKbv7KJ8c3Jp9lwtlAJngsOIQ51qKILDutL2yc5RpJ9aE0CrCK05DxArXvavn2X6DAaVCOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfhltBH6apxt4PKk/fiqX0GKuSvhqsHT/xupMPVyhFk=;
 b=E22Y3dYCl5AlkILbfo85TzWNFR8RzV75AOnZsKHZM7EFy/rrl57QGO3Kn8xwYm2W3gmB3r6h9pHvLUB5Ypj8VXgxN6peHZfakY7iFLDWAf4rPUtR2vKMp/T27sgxHCKeueFbXN1xTTNw11BLYqBE0ODv04PnnmNJy6SNpy7Itq5MApA6bwEtQ8H4hIkZVvaP20dQpWX2DlmvLlvc/LPz2imgN3iH9jvvjWikHQWtBLnYVav/9SgOChTcreqVCx9BmBpfny+x04/NGQRoDibxDrEeC9mBs92wgLBryIaFbcr3FuN1DQ9wAuy05zbe4KN1DgSKp0xYNytb3uNYylgs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfhltBH6apxt4PKk/fiqX0GKuSvhqsHT/xupMPVyhFk=;
 b=P6zMvFqOkrbAWyDOZaGbZS3b1KOe1fLs24SjZUCs38fhzVWa9jN/hMKFBEYboCzKNc6C65mJwCJB9dVOOvt/FvJLcKu26TJbYhdeNrHO+92Er5xr7wf3xV6DL1PgdEY01Jr3nQa0hSCiI+5wmIJtXoeAYqNwelLHktLuKn3vekLdVci0v/Kxen27NBw46lfz0q4zPzmRNjznoGESdKyZXIsdkPcqBUPOA5YGfPShRJZrlnTE9DQaN7UJBov8sEPDFzOuuQYkz+J5mkqdis0nhHGsih257PzlrUaCEArHd03+Vty8FYgEDPi/ErsM3f41AHQepvFUpY+w/XIgr7TdPg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 16/19] pci: Add a pci-level API for ATS
Thread-Topic: [PATCH v3 16/19] pci: Add a pci-level API for ATS
Thread-Index: AQHbhDeulsmv/QVTtU2P/5dyiWdZPw==
Date: Fri, 21 Feb 2025 08:07:42 +0000
Message-ID: <20250221080331.186285-17-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6459:EE_
x-ms-office365-filtering-correlation-id: 3beef041-818f-406c-5925-08dd524ed0ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|4022899009|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wZ2YKdQ+05YWjJaHwUsSALDfBDVfjo9it+nAaFFeQOtfAmVHL8jxUe48Zl?=
 =?iso-8859-1?Q?gFAFUZNgjog36x001kqIImRImuycLCEhUyCln2kduYumUzoWkM8GrDU5M9?=
 =?iso-8859-1?Q?jf3piR3ZqnlT8OVzv8nFi2aK57K15QZvKX1FAKMTylQPSpALJ1rX2mutg1?=
 =?iso-8859-1?Q?zWOew7p0HNJQ7Qmqz7PjasZiYlk8t4h0Lx8j0kZnAksP/WEI7wWEaPXFiB?=
 =?iso-8859-1?Q?moX8Ca1TqtVz11jLvonXWgw6fGa2LxrVf9BjCPpnlzsHw4yQxcm46LqGHU?=
 =?iso-8859-1?Q?cab7qo5DEroCGpuZLtrbai7PR6jPl9shanTCEkocekGO45DmzbwC3ZJJqI?=
 =?iso-8859-1?Q?G+h4+FICrnkyCgelBLijB1iQlWnd9UPhRXOUhHZesgpwXcXU7McPUqWuym?=
 =?iso-8859-1?Q?L3kiLwPquWefZXC0Fwg5rkfgAn2M5+kwUJ2pjDpP9uQnwd1VQKjaRZ+Voq?=
 =?iso-8859-1?Q?JFzeB7LPDP8fYPKK3mdcVhxfBZbCh/Vo2S8L6TEvXiNMxFpS4gnpmCNWoQ?=
 =?iso-8859-1?Q?6TkoUKSklbp7f+Rn9wEpE9SJK5GeOz2ukMib2Ne4qAREiC/Qfq30pDV8Pl?=
 =?iso-8859-1?Q?oQoirLPFKMr9j0wJYih3d/pcoFqol7vpgGXnuAULFWMyl76vppYBvN3CgQ?=
 =?iso-8859-1?Q?RCKjxw1rC5fiT2vWZI+tORojrDOvx4MvQIMHcqpWAlF5L6+JyufKR9Uc5s?=
 =?iso-8859-1?Q?9y67mGxC60+2QbAek3urPL+wMeFAHYS99D1SeubfrWwYQSy30ABZNJ3hue?=
 =?iso-8859-1?Q?a9Ci6L98zF35t746xCKhQsHA16IDjPzuxbtwFZ+5KaxmTCW/BOVUJvHsoJ?=
 =?iso-8859-1?Q?U1PJWv9rPSPnerkpka5IphbrvKwbcGTyIQSAlmHVF3JBlOD7l8dbjj9Dj3?=
 =?iso-8859-1?Q?BsYyDQKz2RBYVr9ZU3gX5Xx1NNovFsG0Gq3Y/E3RdNHf8/IlFL3ILZSW9f?=
 =?iso-8859-1?Q?BcFbJIB+6cNvBfPvaIvGvfIMULzSs6/uun7LSwzyA5vLa6biIaW6DAPoEO?=
 =?iso-8859-1?Q?H3sDmk23VqW4FtE87oW9gWkh9dmozj5FM3aExS875ZxI/N4eLoCLKFY6sh?=
 =?iso-8859-1?Q?zDQ04mOTZBA+oP512agbIO/8CuVAE0KRkH7I7JkhCooBmhFFgbN1SqHtk8?=
 =?iso-8859-1?Q?165Aqxu2gRzhZEpP1XuiY2n8ENhlqTkAKsTJOCJ0osCdHmjMrKTzUXrul8?=
 =?iso-8859-1?Q?I26OS3y0r9R22s+AzcA0QP+eMZlbIn+uDYobX5ClZL1n7T4XdQ4NJNR+DA?=
 =?iso-8859-1?Q?O8LShjt5df6tDtknMdPUpL0l5he00RBaZGScEmDRiOQHz0eZgi/U8ZM5q0?=
 =?iso-8859-1?Q?0JROtKbQuOo4JRCRil9g6UTiKeiYy2zG7zbKEXvQ5HNQRsNLcUV41IrFBm?=
 =?iso-8859-1?Q?5ssmZWeIwUKMe/Tur3t6L0ooaceTJC7xZsEXkalZUO5SuiTP910IkGaSwB?=
 =?iso-8859-1?Q?hiqSLlRY5xRyjM8/n9rQ9RkTqwtx9tzLLIhRdVppTTQtsHwaWU+pmh8uis?=
 =?iso-8859-1?Q?EB16OdF6RxIwLiDTjbPPwz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7DDyYPBzeIC1A3DBFrS4iKKhMqXGYdR9AKfrp42Jr226miCqOkaoJLnw2X?=
 =?iso-8859-1?Q?I598I25NF7i1T3Njplhdtqc4pfin9ujQvjymACzxEOKNIzajJNeTrveeXX?=
 =?iso-8859-1?Q?AmKSmylHNEGoE1SsQUjzTpRb2dUOaJbGlBuqUhra5z4eM9AZMS0mBaAj0a?=
 =?iso-8859-1?Q?lVh5GMahNhqPNoNtU0KI6ejVL7E1QGNkJ0bTjfZZKRQbBFUzKB7G5yKBHr?=
 =?iso-8859-1?Q?V/cMDlJbEHXriq0ZwkX0UmaJG2Y+g8FpVYCMHvmn5tCBdWXMH/SyIonr9E?=
 =?iso-8859-1?Q?kmr8KVbRBe0T6kxwqCFeRMrcn7zlU3S7w8yL8Y8UnFc+hi42NkPfCX+L8O?=
 =?iso-8859-1?Q?+bmKrwQbCZf85s+nIidmeY5vcHZNx6rEkon3rzt1QkjBY94lonqzaztGhk?=
 =?iso-8859-1?Q?nYK2f6iFH2zV6ldBiuRxiVZXgyHg9PqJ/fOBaUfgwOm41TIcvRR/fhp1w0?=
 =?iso-8859-1?Q?HOCrRUnn4xyGuSbqqbpt6tDfHrF37MulSE6jSNL81ysoKj8byDK5+lcB+2?=
 =?iso-8859-1?Q?KUIul75/aECBqXvCLxDwAUVY5xtSew2qLRE9nBCjOLJuwiibHqLrlh2SoX?=
 =?iso-8859-1?Q?P8vBJLy2ssa/aHRpxszuUnCXO1GVKtQPdTYs8+DMZhOpDoehk/CoJbpWxN?=
 =?iso-8859-1?Q?Fo8O3vnFhysW6DulnkMHV/Q+W3T6zK5yaN7xTsaGaUmq9zhCWcYlI6QWh/?=
 =?iso-8859-1?Q?z3Es8tD8gksfYE1oHxaIcD1bTVziv5gxZ5LcvwNpSGXDjRdR95Uj8Be9eG?=
 =?iso-8859-1?Q?b+qePK+UndL+GwEfeYNTzqpPmyDBjE3xyOBHKeWWa/aM1l1I1TP6dnGcum?=
 =?iso-8859-1?Q?z7/Cif1gXxav00LnRx7gmBQOCRpbllIxfOHPy0tzWeIcRtcoOCh9gBB8/6?=
 =?iso-8859-1?Q?OK1+LD3q5q9MM9cQIvROqFUNN9Eqiu/l+Vlj1ei+FMkZOqD2ESG0jUko48?=
 =?iso-8859-1?Q?Sh/PfyUw+9xbfuJJD8Y9fEokPbnIBOikkqqt3EaV0+MRD6Dwy1ewWctdSr?=
 =?iso-8859-1?Q?nxl73uFVgRiEslL3ZcJSCo+HOJj2E9sW2cTjAdsJjHWwTeFGCHnAZyiDvB?=
 =?iso-8859-1?Q?CTS9G36KymJ/zeTIsoUXBdz199s+gBPLFSOGOKIkYPqabLBAQz16Zemi4M?=
 =?iso-8859-1?Q?XevefozUqPExT1t/WFUjtUTveI93NvcvMS/AP/BYUX30ErN5RcEG9SUtQw?=
 =?iso-8859-1?Q?LcfeOtQHas+mtsZpOdpJ/FrHyKSO725pLWEM8stPouhJ3mr8UDnpaaJTEk?=
 =?iso-8859-1?Q?2VdtSSDyg3yqKoA/YFekganHVjn9Sclx89o0yKZg8yrUMwIbYjZMDRRDGt?=
 =?iso-8859-1?Q?98CeJLNfMmMKmNpropXqnKIkaEMP29zAOExoA1olcA2slKcrcRtsrB+P2W?=
 =?iso-8859-1?Q?DmGBYqXmgToI7dXbSZfk2+52JhLXMCRTWVntceooycUk6hfyb8U8IJf0Ug?=
 =?iso-8859-1?Q?wmg9CVhwcXlgoc6AwwYyh9fGkb5gzHuJeCRudOf22n/xHDizo73OdGZY+M?=
 =?iso-8859-1?Q?GnU7HWq0QUCxnPMWEfBRM5+gKaXt0BNislUcimjntc29sUlxezfhXiCAJp?=
 =?iso-8859-1?Q?A6SJDW6E6CfpMWvag0LawlmrAOcel65TxSRe0PECWlvWr40JrDsXc8WRYH?=
 =?iso-8859-1?Q?MPlPef6wHIwrUupGIQMkCkdrxZuMoKx5TgEdCMe71lOH6UMN6SCrk+VsjS?=
 =?iso-8859-1?Q?2nZu3LGiWCURXQHSQQk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beef041-818f-406c-5925-08dd524ed0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:42.2146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcgMZxudSS5ZBq/r/2RBWKIA8Y/KIR0vNAtyin837ys9cXWnOAu9xopCaYtbeZjCd39BjijrpYEPg9r/crnIiOZ4aaS379FuFNg3i7cZry7+r71vPcaAtl3mhiXIeUUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6459
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

Devices implementing ATS can send translation requests using
pci_ats_request_translation_pasid.

The invalidation events are sent back to the device using the iommu
notifier managed with pci_register_iommu_tlb_event_notifier and
pci_unregister_iommu_tlb_event_notifier

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 46 +++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index be29c0375f..0ccd0656b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2896,6 +2896,52 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
=20
+ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
+                                          bool priv_req, bool exec_req,
+                                          hwaddr addr, size_t length,
+                                          bool no_write, IOMMUTLBEntry *re=
sult,
+                                          size_t result_length,
+                                          uint32_t *err_count)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+
+    assert(result_length);
+
+    if (!iommu_mr || !pcie_ats_enabled(dev)) {
+        return -EPERM;
+    }
+    return memory_region_iommu_ats_request_translation(iommu_mr, priv_req,
+                                                       exec_req, addr, len=
gth,
+                                                       no_write, result,
+                                                       result_length,
+                                                       err_count);
+}
+
+int pci_register_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
+                                          IOMMUNotifier *n)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return -EPERM;
+    }
+    return memory_region_register_iommu_notifier(MEMORY_REGION(iommu_mr), =
n,
+                                                 &error_fatal);
+}
+
+int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid=
,
+                                             IOMMUNotifier *n)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return -EPERM;
+    }
+    memory_region_unregister_iommu_notifier(MEMORY_REGION(iommu_mr), n);
+    return 0;
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a11366e08d..592e72aee9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -461,6 +461,58 @@ bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uin=
t32_t pasid,
                                    IOMMUNotifier *n, IOMMUNotify fn,
                                    void *opaque);
=20
+/**
+ * pci_ats_request_translation_pasid: perform an ATS request
+ *
+ * Return the number of translations stored in @result in case of success,
+ * a negative error code otherwise.
+ * -ENOMEM is returned when the result buffer is not large enough to store
+ * all the translations
+ *
+ * @dev: the ATS-capable PCI device
+ * @pasid: the pasid of the address space in which the translation will be=
 made
+ * @priv_req: privileged mode bit (PASID TLP)
+ * @exec_req: execute request bit (PASID TLP)
+ * @addr: start address of the memory range to be translated
+ * @length: length of the memory range in bytes
+ * @no_write: request a read-only access translation (if supported by the =
IOMMU)
+ * @result: buffer in which the TLB entries will be stored
+ * @result_length: result buffer length
+ * @err_count: number of untranslated subregions
+ */
+ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
+                                          bool priv_req, bool exec_req,
+                                          hwaddr addr, size_t length,
+                                          bool no_write, IOMMUTLBEntry *re=
sult,
+                                          size_t result_length,
+                                          uint32_t *err_count);
+
+/**
+ * pci_register_iommu_tlb_event_notifier: register a notifier for changes =
to
+ * IOMMU translation entries in a specific address space.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get notified
+ * @pasid: the pasid of the address space to track
+ * @n: the notifier to register
+ */
+int pci_register_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
+                                          IOMMUNotifier *n);
+
+/**
+ * pci_unregister_iommu_tlb_event_notifier: unregister a notifier that has=
 been
+ * registerd with pci_register_iommu_tlb_event_notifier
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to unsubscribe
+ * @pasid: the pasid of the address space to be untracked
+ * @n: the notifier to unregister
+ */
+int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid=
,
+                                            IOMMUNotifier *n);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.48.1

