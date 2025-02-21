Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE52C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4g-0004d4-CI; Fri, 21 Feb 2025 03:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4e-0004bk-6N
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:52 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4c-0005j1-Aa
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125270; x=1771661270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m5wBA/DKT2nuLCzYeyNMgxFYfXCnhkVt7sDapOAU8cc=;
 b=H4F+k/zQWaATeQ4/pzEwVLZQgE+rxHG6oWxj5NEUacOjn5tAHnT8uX4T
 tF4AA/ZfMxq9RbfkAH5Sh6QY68he76d4aujcwryl52/fhFxmkwWp59fR2
 5g0dCdg1mElEwZPntbtUEtLdmvjGVUb5nHdw0aYvih5vrkkdTl1ViDoHt
 U0KhxJ+I/DY1aWn04n1z0hrhjwQCHLkA7DQbiMg+1sIV91envqaTeU2z/
 f3hq0ikB8WAXtj2qQDZyBFrP7EZc3iY2+guCJXMX1ym+HvPB3eyPvCrRQ
 z2CtvCMkYJt9YMEbDIMYkj4pxR6WgB47zDujpYWJbns6JMuE5xjk3gS96 Q==;
X-CSE-ConnectionGUID: ovr82eYpRGK8hvIU7hFzQw==
X-CSE-MsgGUID: Uhil7dWUS9+m6ZoUv2DTRA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394147"
X-MGA-submission: =?us-ascii?q?MDFlxv8oBtL0NtsO3L41EpXZwsuPoLcqNltVUV?=
 =?us-ascii?q?+oaw2UwLmj/uVZby+HfMEBCxNCqC2mhZJFbq4IKokBGJvmjcH8YKQd+h?=
 =?us-ascii?q?pDHLovhY9mlb2FIiE8LBCn48oF0PSag5TGweA5JHSbaGtaYKUOlrTp/e?=
 =?us-ascii?q?XvwvmfHbFxLH+LHqDbnDxw6A=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M89eJZrvdsH+vowawWmolNMg0G5sAqOOHzz7pLpc5JIerD0Rt+SfCS4xKgIbpk5AXq60Nnh8EDsWWAf8FuTUQ57GBmFmhBP5ygZ2dJqOCmQnKB4Ctwc5BouzsJFOLYwWLC8Sv52wcOWqn3GdxZZrBYLsVYHHDcAhMpXihU/VU3uzRa9KpwkcD1P1UiBwEFVL+fhSwaW8StDAio2OAwz8/MqoZYnhllFzR3X3t9sUMeqiTW+vcAnI6E/XnQQ4G1wgOxtbnEYzjnu6SgEoQlCy3vc2n6tyzFRm5LBpfV79qbeWGoy5e01G7QeOrHOeGqwo1iCFRp9lVrtOhGBdWUQ4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptdj9NpRDTE1Jdjyv9AgOzOvidnvjV1MSr75mHV7AxY=;
 b=F926SWoQjAUaScOLn87V9XvUKqvGHMoACR1FJIQiTYFxgshPW2P1fYzvE/Nkyoh39Ogb9m1jb8wbLxlCjm51Frg0/fEXbigdBbrAbhlFQRGBn3Curcg67upIleUpKyufFwmP8XAkB4+6UquTP+17Ar29PXiTIC7EFNTE3voK0uv/GG2FlZMzdPSUmFBEZbNEt6q8kHUM7497w3PJPZJ1wZODUzjCxGBW0nTMrERVQ4RXjf4Sk2wNH+dpQ3H4Ed34K6TQWr+3Eqvf++Zd0if5OGIkzzM/yHmVyXGztzziNCEC5q/b40qRlx2VApWa8MieVf8E++8P/JcVrtTvt3Skiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptdj9NpRDTE1Jdjyv9AgOzOvidnvjV1MSr75mHV7AxY=;
 b=XAjZ1J/ZOrLt5LgPKEiHr1+rfUkZcjcgn9ZwhiWRl4uSfVuGMFoLyrsE/PQ6NRnRiY7hKnZ4Uthf8IpWYBwAHP87l7jCCW51xXT1BiMiozdXq9L9daRdlGi99UnscTbM+XYx03RZVHpCl5w4BAumXGl5GyFN6sze0ZvQuMbDmqxwTTV06LaQM2k3fII+q5ohV2SRFsQXrpd6u03pZ99RYWvudOdINrIaokuYVsCuPIGahqXPXWvanJWU+XmjU80FeW80hJMfp1rXNeHtolqGK4AVFxlomOrVoY4CP/tgiYuEljIlYZK9jrVb0HliizTEmTpPvLE7dB8s6V0+WLjh4Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 18/19] intel_iommu: Return page walk level even when the
 translation fails
Thread-Topic: [PATCH v3 18/19] intel_iommu: Return page walk level even when
 the translation fails
Thread-Index: AQHbhDevAtMGTD3ASEiAbxvGiKR+qA==
Date: Fri, 21 Feb 2025 08:07:43 +0000
Message-ID: <20250221080331.186285-19-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: f6eff158-90ec-420a-cc39-08dd524ed1ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ICRsrooCIwhvUCxmuP67XxxculZyllc08NW1qvZGX2aSDJtZr81r+A+xWa?=
 =?iso-8859-1?Q?Chfdo2WEFq5ZatzyMfQ1RlGFVxQnjAW1nvUT7c6W994+jaV3VxpF8YWCMc?=
 =?iso-8859-1?Q?lEfTumwcuqM8Nq6oHOcoCPBsdSGkYeL4iHyhd7ZzHTx6w4FjvRxbHIPp09?=
 =?iso-8859-1?Q?vM2HNWzzrTdTaFDC5rmADwBkEpfz9FuYCoGZKGKwRNpFDvIcQcfCr/E8e+?=
 =?iso-8859-1?Q?CcIvuTLGdEBZVA7jkS7xB3gG48Jblu8pfwBsMCh44e0pjmlxUso4dB0LtH?=
 =?iso-8859-1?Q?nlF8hPJLoimUBCHqB21M6wEnKRFWyLaGSqc8uvto+sJO3ZTDo4/shxCAsJ?=
 =?iso-8859-1?Q?KPy04SqTKOQS7iXFuMwtcdd5UV28pyP6YpbEptzlpogqDhSQxAghNhp68x?=
 =?iso-8859-1?Q?fp0TGAE96fcGGLVdRTbdvfGfxQtqHYMcXtYW2sxG4Tf9vMsDxgVLViD4Ng?=
 =?iso-8859-1?Q?UiOvMHEIqE8R5NitHX+T55jFmCmbO+8/mZodX163EwsUGFlqSvd6a0Z+T1?=
 =?iso-8859-1?Q?k+i/iGUPTtmNb8Hih/cmuXBtUZN8DDvAD+tuaxgeDrFDP+/x8bokv8jb/d?=
 =?iso-8859-1?Q?Ipy72GoOUyxuTneCR4w72OA1ZAmz2Ek5THy+/lsFM/S1hKyJoYb1/WmarE?=
 =?iso-8859-1?Q?0o3031ZOFg8dxpJZEtYRtrEMckGss6HVwhjxRuqUgJbXtzi5lRxXHOCh/f?=
 =?iso-8859-1?Q?OBsYM67oBbJiHIuPrH00fQ4bFFD8NE4c7/7eCVpt0oexzRCRn2UJLrAE5h?=
 =?iso-8859-1?Q?PesctKf25Zd9SGTdThaswvQth+UZPjDEEKBOG7hV48KmDISPfV7kan0d4h?=
 =?iso-8859-1?Q?k/ACZZ599UTm3wlhVGXBiEm6HUoxfbuDyrEwGvELZPqS323DAiUt790Z5s?=
 =?iso-8859-1?Q?JImvJmD0DFfp09kzxC8EABHHDs6IfRyE24/XM1DZxj3cXb8qMbtON/vVsG?=
 =?iso-8859-1?Q?FGohY4oU+b64TZZN+/bphywKjP/r4bqJzE1fGVd4upxsn1ArpQ5OlzC3Nl?=
 =?iso-8859-1?Q?HLjVoaQ7zxnr8iPIhB5WBOLi9WS0nOBHX2G6SEvv4+kwMtUn9T5KwWbc9B?=
 =?iso-8859-1?Q?u7ojwKyi9KS6oAqPz45TqfFE56fva6X2ycWw0p2fqsxnsm4w20E6rqDLj4?=
 =?iso-8859-1?Q?8QV4QWSs5eASkcVpQdRRAAXeeIZKzuPY3qhpFY3WVoaIEsR5VSZeyy5maP?=
 =?iso-8859-1?Q?+nm/+HRleTocWU3rH7koDc1L8NYOFgOm6WyF9YO/kg4ZIAsMhj6ffaoTaz?=
 =?iso-8859-1?Q?yREMprOSMdKsYQxZYwA6E1Ci3KqmcII5ORUxFiUBt4wIogs4WjLj+/TmUD?=
 =?iso-8859-1?Q?Vcu5VFGB++YYAC3jb9+DdUMUQpuIAmPeubJfhGTYlVApUsBMdkesbOwXE4?=
 =?iso-8859-1?Q?oUA0hBn8XNOCp2831r4/FnU7D6lxqqD3bpPfTa0PjPBPDyCgCGdSkorIbm?=
 =?iso-8859-1?Q?gp2XtoUl3kagZO5nnTpr6N8rfdswfoTOg8Gqz/Ns6yOZOEylUyk++saNJi?=
 =?iso-8859-1?Q?PV0XP5B7B8nUtuRE+PcfB4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YbPiFVm65eTb9QKHUDPs2fb+NCCE8mHkgcoKkkhivQ0tWCEhQneqTAxXv9?=
 =?iso-8859-1?Q?3uzcp4cdXNfPqkEhSRzM6ECFyDfNw1gwtEYVPAva1VZrqt45GH3Uf7iCl3?=
 =?iso-8859-1?Q?YrobUGV3tM4GwED79fqT1tB/lT1AhINy39tJI+8uonsyXwyIaBcm+tI+vr?=
 =?iso-8859-1?Q?J8eMKcgn/IQTjLbHG4c+tSaxV2JU6lwCp+S+QMBJGgE8qvTSjq2UJrJ9Kx?=
 =?iso-8859-1?Q?KYl1p2OoIewvhbyTvO6iF1wuXvlSdIUs9cqQeFepvJrQBEphczAN+eag2k?=
 =?iso-8859-1?Q?O5/7Gre2VpJ/kWLV+Ow7Ux5gCZXZ/aePWgT+Fav0lmCxAA/ZuWF0bkFz7r?=
 =?iso-8859-1?Q?tHL3X+ECnMnE/ywzfkBH0KsbbaeUDDolLOu8VVawWgh7yrMIrEzu0Xptpd?=
 =?iso-8859-1?Q?DxWqzWiBk2omFYc7ZWAl+5F2A1f4/JIGlM14tqJv4ykyQsgQLHcnzM7/4i?=
 =?iso-8859-1?Q?dRAvm1p7FMlRSf/rhiAm8QN1Qz9dZiSOpZEQDWo/W8XXPaVcnkqZ3jl9VZ?=
 =?iso-8859-1?Q?WyNlGjRkh82jmi6DVS3ojWnJySWVq1TiQGR7oBaghde/VCo5b94haDg6vE?=
 =?iso-8859-1?Q?frRJ5n3ZmMalVtYlf6Fkdflp2d5SV9eOpVqYfT8onrO8ZvmLTBfKYAdMHw?=
 =?iso-8859-1?Q?/fLZ17gVjpkVmyJuEVGNHVD5/GAlwVsMMY6fbTernXI2uALtjcqyj8gTDW?=
 =?iso-8859-1?Q?FhLd0hG9OZlVzLtD1CQ0XTm02JKqoBA4xQy2vN3zX6DEh8dAhe2CCtRVWh?=
 =?iso-8859-1?Q?hSlczdMJuQHeWgBf/cR9hd21hS6m66/lzEMqOvgPAeBfXL0FLA1dvjYAIV?=
 =?iso-8859-1?Q?bSJuiA3iEKhJGU+0H42qeQWYYed3ul/o0jYo0BeFBplE++fxfEUXa9f32g?=
 =?iso-8859-1?Q?dJdN28a+n3cwhD0TeXKRhMNQ08jFCWu2ZaPTXUI/PQ5G+ikPe9ckNl71XP?=
 =?iso-8859-1?Q?BT0IcY1CWpfPlyaOaqWyDAFjg2SAFpiDDC2TLKEaza8ZTjlRXItrqBw+3a?=
 =?iso-8859-1?Q?/Vz5txOF7MVyiWQ4VixnEvhJcV/qXPZWHNC8QxnflUGYvidhOxAIhQjxDQ?=
 =?iso-8859-1?Q?oD14gb/AQ4Fy/JhnlSS3aw92bQtTr+8VRzIgHzJXEkSlcVdre2x+d0LBlj?=
 =?iso-8859-1?Q?wOHQesaiUV0OQ/qZATQByv0YOGZ1njLj1GxnDcC+gezXSYvYi6htmIA/6T?=
 =?iso-8859-1?Q?4eNaK4cjmtLouEDkVQEgfwOPCzt/1B8WdUc86BKko5+W2CIrmF1sIRNi8k?=
 =?iso-8859-1?Q?lGdbxA4qbeORR+IN+xRFvEiCaB5hdMlqJmpOof5GXO+Pze+BGslut3su+l?=
 =?iso-8859-1?Q?yNp2mQA/8Ry9h4d8d4nTf8a9c5J+t09D9m1m+OU6k9hB4AsweKf1Q2TBOf?=
 =?iso-8859-1?Q?95sevi4mbf5Q4w0kEOtNOtXCwmZrFX9+4vDlJpjBj+sTUQAbR48ntBZ1eE?=
 =?iso-8859-1?Q?XL3PplflWPtm/N1yvWHkfp2uquWhySj/39bWtQpRa4ws5a/5/MbFYNVi8t?=
 =?iso-8859-1?Q?aFqm+W4FeqE1tt/k2HjJwvPEFm3aL9qEBS6PgwNmx2PUTs3wSYJRYaLYA0?=
 =?iso-8859-1?Q?tYUwA4zlMxVFQHwAaZbjIUVpHAkTXhnFCULc8nTmvYmFNkT8tkBKNxlKTl?=
 =?iso-8859-1?Q?8QBvlcRW5grk2xoEK9bPXKImpR9aKaIrVIDSatvymg4RIMNgSojHSjP+Xy?=
 =?iso-8859-1?Q?tNWeSZtC9F9OPlzdsTs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eff158-90ec-420a-cc39-08dd524ed1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:43.7011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdraUOMs4pD1GxNBB6uqfL9ZkUCKpXEXBAfzN0S6nhJmKS/XP3vKfyOeOTcpv3LHePjud5rYmHyXEKfc3jI+9lqxZvEyziUTwC0PvpQbkRpoxY3vvZXy8UP2S5nzawmM
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

We use this information in vtd_do_iommu_translate to populate the
IOMMUTLBEntry and indicate the correct page mask. This prevents ATS
devices from sending many useless translation requests when a megapage
or gigapage iova is not mapped to a physical address.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b9b5d492f5..9daf8025cc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1995,9 +1995,9 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
                              uint32_t pasid)
 {
     dma_addr_t addr =3D vtd_get_iova_pgtbl_base(s, ce, pasid);
-    uint32_t level =3D vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
     uint64_t flpte, flag_ad =3D VTD_FL_A;
+    *flpte_level =3D vtd_get_iova_level(s, ce, pasid);
=20
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=3D0x%" PR=
Ix64 ","
@@ -2006,11 +2006,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
     }
=20
     while (true) {
-        offset =3D vtd_iova_level_offset(iova, level);
+        offset =3D vtd_iova_level_offset(iova, *flpte_level);
         flpte =3D vtd_get_pte(addr, offset);
=20
         if (flpte =3D=3D (uint64_t)-1) {
-            if (level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
+            if (*flpte_level =3D=3D vtd_get_iova_level(s, ce, pasid)) {
                 /* Invalid programming of pasid-entry */
                 return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
             } else {
@@ -2036,15 +2036,15 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
         if (is_write && !(flpte & VTD_FL_RW)) {
             return -VTD_FR_SM_WRITE;
         }
-        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
             error_report_once("%s: detected flpte reserved non-zero "
                               "iova=3D0x%" PRIx64 ", level=3D0x%" PRIx32
                               "flpte=3D0x%" PRIx64 ", pasid=3D0x%" PRIX32 =
")",
-                              __func__, iova, level, flpte, pasid);
+                              __func__, iova, *flpte_level, flpte, pasid);
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
=20
-        if (vtd_is_last_pte(flpte, level) && is_write) {
+        if (vtd_is_last_pte(flpte, *flpte_level) && is_write) {
             flag_ad |=3D VTD_FL_D;
         }
=20
@@ -2052,14 +2052,13 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
-        if (vtd_is_last_pte(flpte, level)) {
+        if (vtd_is_last_pte(flpte, *flpte_level)) {
             *flptep =3D flpte;
-            *flpte_level =3D level;
             return 0;
         }
=20
         addr =3D vtd_get_pte_addr(flpte, aw_bits);
-        level--;
+        (*flpte_level)--;
     }
 }
=20
--=20
2.48.1

