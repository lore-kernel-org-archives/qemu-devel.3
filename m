Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF0C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmc-0004cj-9j; Mon, 20 Jan 2025 12:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmT-0004WA-Sl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:45 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmR-0000Ya-G2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394903; x=1768930903;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6MckZQwCYjffMS2jXtjONQ/OHOr/zGtMmZperPRxHuY=;
 b=nqCzTsdlSXdKqdOoOVY1vwnFCCae9+fwwO2jWOIVtSLG62ht19GqgcIN
 2jXM5PW6+//NhlOAeD1f7BRwwM4mvFQa5qpbApx6ujadYl/qlfl3xUwMJ
 7AmfaKPWp+4qhYWymPxjU6OYDE+QjcRyLnVgG4DlbdzCRcnu2Z1OzcbOV
 Ju4t0pr1mw4Vo8kzdVRlO9XyyvkBURmRvE4QikxZrInKOmQTv3rCGIbA+
 hCrViBO1jWz4k7cjJI6tBF0DaP3yUdQq23U6FZ77wH8rPW1Yd+qyKJQ9g
 FND3IuctKC3kZFY4tDhcWibCNy4hWUjY82xNl/J3o4IelTsr7ZIY17INU g==;
X-CSE-ConnectionGUID: OUkLtZ1BSRaGyuj0IQ8qIg==
X-CSE-MsgGUID: M+zK+41hRnGSrnJKa9jl1g==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291717"
X-MGA-submission: =?us-ascii?q?MDGmXsEpqMchtTU4s8IrzGa/htVpLuB4mdB84w?=
 =?us-ascii?q?OjS9VMP+18vl/kxw9al2XtHJU7VztPhdES5deZePi0Q8Yi3PGqPOlpCB?=
 =?us-ascii?q?tblcV/A5HvC2gESVd3y4SRGzP3C/4eQfjkouY0NKCAf+xvWM/4fDGzCE?=
 =?us-ascii?q?MCRvNq1K8jzzD15Et+WfKnnA=3D=3D?=
Received: from mail-db8eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.111])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:41 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va47eTGCG4AMKfiUyOoaTFtUuYMCh0e3P6pfQZmWSt4edoXojhTyllrUN41Vg43DRAbptaKtC2+Mzyb7EazSvbn5Up55ZFz7jTU+S1VMyBDLqw+iHc7dDADQf5oIO6/MWbv+YEn1x3pPhMHsDKQofXyt7+JD6AGiS56jU5aWqkBrb0TG+XEXgr8lkZd6s9prK1ck1Aqv2J+6XxzYf5GMAp63DF2jcsCVNlpLsUm/6oWEewtmsV3zGV1WvKAf5f1PxucVejaH7oIiRr4/0uCU41SXW2kD6j4mNGbzXSPXodDmXbRduCv3SoGH+YUKLC35A31ScrzRCfvdYcD88jJ4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVkhoKa+zWw25OWncBd6cKrfwqHMKy/axZuf3JScfE8=;
 b=m93EJjYZq64YEEKGqUbWU326tThqctFXY5BAaXHGzL/pLMSBO1qd8Y7/W7JG6ibVQdD4CHHjBnz9dTpEZhvE5teIPvouEyFsXsnJrGWrOKMsaQArwpKoQWve0TNjXXNp3HjJ0/q6ro8fZupzLb93FNJOvSAW73nkkLGd4mWQI4sPZjB4Om1TPO11U7c5or0oY2bATJnkj4JucFAxF24Dod91Xyc8AaU34cmAJxaEcrsKT2pqV2LrQN7m7O9ZJMwNkQPd3O5+bVjRG2VEC327aeUBpdJuHVaymG3aLGdupfRitOWcv1+brRr/PwlHhWsCoFoFzOT3sgU9mJC/nOAbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVkhoKa+zWw25OWncBd6cKrfwqHMKy/axZuf3JScfE8=;
 b=UqKy0TWCkFg+NCdgFcbg17/3mhY5uVQbsTbo8L4XXZP02xcm83+dlDMM3id2a6Od8E9XZ/CiFGPlS/HZsNzEfAkNsdSw3f93Qp423+D8/s03FZFYInBNWiLWS5xOrXVIC02mFZ4jHI3iiSTmXu+V/P5TCIJXoUhucHM1tyCuS5Tp1LV0Ga+2cVz11WYoc9nSbR7G+S5+2l+jq7Lk0+SNnnhc6JaQl1OXDDsHw0xoZl13TCWAP2XKVkMSbaAoIAfXMkzgtGZ/o6D7hrqlsG9iXzN1ZeyOD7YUkmYQPK+j71A8bih15UIAx93gwwr7CQlv0Q+yAA0M/2I9TH+GqCx3HQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 02/19] intel_iommu: Declare supported PASID size
Thread-Topic: [PATCH v2 02/19] intel_iommu: Declare supported PASID size
Thread-Index: AQHba2KP0vNGn4J+iEKQX3X8t9NAGQ==
Date: Mon, 20 Jan 2025 17:41:40 +0000
Message-ID: <20250120174033.308518-3-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 21a7d2dc-1d7e-454f-b55d-08dd3979b256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EW3I13h6KBwVYyMrQt3FOs4DilTQnio1K2ltyythBps4Gmg4oOsLdBqfVP?=
 =?iso-8859-1?Q?mvZsOv5+cJ/sDWssJNbJd8L6cUfOFj2PM2xe5OZQIMIP4u28/piR4ipe9U?=
 =?iso-8859-1?Q?69ryjwPqpbmWrNKq/VKfuv/fG9LxXIxkNYHm0mfTC8hKeLXeIDrdnxPe1Z?=
 =?iso-8859-1?Q?zoblZfmh2GyIdEst5rxSIUnFq7Tw9ppKu8CnnNXC6CFfSRyLQ71DB9/253?=
 =?iso-8859-1?Q?isicUeSy70pTjMEM8EeEH0plKwAEalIcXeMbcEhcZV6u4henUxpvpBxNBe?=
 =?iso-8859-1?Q?FCLrKKZ7O9TrOGrsnMqVIAxJrht17NWc3rQpe8HcrE5Zey3TxJiKE6TacM?=
 =?iso-8859-1?Q?Zr4oJD2nJlRgQD/PPh7R53l+EsOMT24lPkE+zmvq5Hz3ZmgSAzsSwQUQMd?=
 =?iso-8859-1?Q?FGZp6DIEm4qprg7Vgxmj4wng6zf/LxAOkRRB+EgqScdVbiMHcL7NbHz6hN?=
 =?iso-8859-1?Q?plMaZlhhIhC4JZSCJpp6q2h5LgWKK9J43CzDhs4F4qVpbIs173XLxoNXD9?=
 =?iso-8859-1?Q?Vg9czx8Bs1dV6me5tDIvkMabhi+b39jN+c1lCn0+ryu/EuyPjgldr5plUa?=
 =?iso-8859-1?Q?aBOhHgwZkqiy2jLCc9Jnrv+mU2IeXGbHQ9xfI9RZYmrrUIpf05xafQPU2y?=
 =?iso-8859-1?Q?ULEjmBS8Q3Q3gchFzkSHUyxFawAUoOOmQla8cwighzt2nchHTPl8rHpbEj?=
 =?iso-8859-1?Q?oY0xf6bf70fd5OQKftIlrmsjQO3gUASUsQxjSlSGJQXzdn8n7O3LHN6g4F?=
 =?iso-8859-1?Q?dBUo0/+MJTVzBfN/98CJL/5k9oknQ3Hg2ZmSflZS40mfakg/4P4ANxCoNo?=
 =?iso-8859-1?Q?1GWcpwRe1SVgXE33Vb3OXXwyTvqKs3jG6J2YP/tTjxEQer3OqXWiuF4Bl+?=
 =?iso-8859-1?Q?Qp+xmUfLqQJpDDupP91Yv6hyHsWCwxNPXndeWjpbXE01bjdWibSVEWEHkB?=
 =?iso-8859-1?Q?pG8qLakRJBmdikHmbYD0cPUf8/WpF2nWY82/4jG+ff7K3kOiOCVV2CXhBG?=
 =?iso-8859-1?Q?SOVzmgLhRj3r5xljVablz9JjoDyYwH3u+TJV1CK4+Fd39R/1mvTYC/dLaj?=
 =?iso-8859-1?Q?rPxcg9KTYB1pXgfvZNUAFPS8tx/Hw7f6huTqsih2Zge9ByVO39tITpAHHI?=
 =?iso-8859-1?Q?LCPq9eqYapNhSdt199Jyw3jOuz4qAtZW2sosMEP2IakPpHIxwp+WSxSjPv?=
 =?iso-8859-1?Q?c+xVNWI9A3sFUuz2oQuunquvmlzQtW5vahH3O7Iz4b/ASNgtJrV54OrNMK?=
 =?iso-8859-1?Q?NB6oWuxr9fPs6dXOua023i2Zl2jO75EjBAgnDNOcCLGdz8IV5e0++gzN0/?=
 =?iso-8859-1?Q?gksuciCyjKe0/81RM1meyrSJg2JK0YiFaOUkdvP3ftboLBX/17PUj+HIvU?=
 =?iso-8859-1?Q?n43KDu6RbWbgRGUNwkQq2QxhUpD/pbr61leU90NEYbL0wiJjD96mq0nFaa?=
 =?iso-8859-1?Q?rXnydLorPA8MCW7zL4HPQSa5trgSqDOngZ/PcKcva/5TWvGsppcz5meUH0?=
 =?iso-8859-1?Q?N2zXlCEYBJjmtOpnB57VTk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EFZeSo4jskUct96z19TCQE80dEK4pRB2Kcb3ipUJYGRDgAYlYvBofebOb/?=
 =?iso-8859-1?Q?rxDvI0lGxqGj0Sc6vZRxDaSN1A1c73/2z4dWTmup1hNQj5e1Lu5zQ/qMvD?=
 =?iso-8859-1?Q?RkO7KoxQyW+x/AKhZnMWWho1lsRxytVrDUcq/gxHs7yTHutm3Q3VSTqmo4?=
 =?iso-8859-1?Q?fnAa/UMuTZPhzf37dUYtQtORutghO9zTmNmE15J2vJpb6EtJVQP91o9nRZ?=
 =?iso-8859-1?Q?4KBeGqavDr7zHWyBDZxrD1dgf99+UxGLd/ZG1jaYtv8UW6cOVNXNqcRzKF?=
 =?iso-8859-1?Q?6yDpbC+kxkeAhwJRinxaJhOoZ9lhDqXsPPEjsHKTIFT4pTwRJdy2Tt1/nd?=
 =?iso-8859-1?Q?9lOrCX2Qgmj50jhEb9g4UKOV13TQJXURUlzIgDOPhAhuvNWsVmbeC+qsKF?=
 =?iso-8859-1?Q?g9rC79wzvI9odQx4qfGSEMCngrdsA1OYVPEdZe6XlverTNSVpDVh6JGxCr?=
 =?iso-8859-1?Q?Bnla+l+aDZ6A5N8cXTAmnejt1mTi9r8dYNrH+mrdL210YaQHvYlo/+eOB2?=
 =?iso-8859-1?Q?OfCGb7Cm3Tt77OAGG2d9dCxC6BwzUSIhe1KOL0+5xYISbHZbK5beSnl5J4?=
 =?iso-8859-1?Q?Os1LwxVLspOptw0sOqEb0x9teZzLp5qAXzknNVIPIfsa8fkOqFOsoX/cLc?=
 =?iso-8859-1?Q?HW4VySSdX5uCqdOCS8/SBc95afU0oVoI9y04LbuZvnmePtccaU+UKVwboo?=
 =?iso-8859-1?Q?BDcUw06/zcZNBhQEU8F7VPBWf+D9nd3YKqauyeeHba7aPLluriJdtgKAa/?=
 =?iso-8859-1?Q?sxxat0u/Av7VEG+df+wHswpavCDuOsxVQHwYqmgvgC6KiTCQnN8i7Pe4P2?=
 =?iso-8859-1?Q?3bY9JcX9w+4b1j0RFCdBkuE81+FKS1tjxxU+S/NTmDIw6Qs9XYcQHTtQzF?=
 =?iso-8859-1?Q?wr8KujNb4Y/mOzKqT6Nh3+k9CBDRQbxdKy/l76oH4yHYYkLYZ+q4HVup0Q?=
 =?iso-8859-1?Q?EWZJ3jQbmVT0GnbWB1Zfgi7w/wEAKABYqgMAN0pgOG275i38RugGdQ2DxI?=
 =?iso-8859-1?Q?xnm74pUYk7iP4dUxAG4MBvzWfJcHh2l/eUt3YKF4XMtmFArYgCBKndQJIR?=
 =?iso-8859-1?Q?kcoYcU5cNG8uyF5PxohbCR0gsT2ePmAimtjy0tqM/+e0/955iGtoIfAr9O?=
 =?iso-8859-1?Q?9hqunTwS8+d52c/pDyN0ks6y5AFoAIkRcb2BmWsw7AJDx66+nijCuEJTP5?=
 =?iso-8859-1?Q?Jieeye/wzYNArx47nftuDXG0TwatbWvqQlHuv1XjSrze0p2wMVt9D9Iiat?=
 =?iso-8859-1?Q?2WrtjtZdKM/gPc9mTonAhH1gHRNGUtPCHFRbhFxvI4VLUctWcudzzu6Vvb?=
 =?iso-8859-1?Q?ZqM2lf3VXFKxCo+eGSGm/aJWrKwYEoUOb83bvA1b9bxurCtzXakah6k+lV?=
 =?iso-8859-1?Q?UujrWc7J/ejOqNc5HHkU2QLpSrV6iLyIA/eez58nh5PwGIEozoFKNS2KHL?=
 =?iso-8859-1?Q?ojf2C+721k4MYlaAtHLBmTLxMX2z12J15sz1C04tbZtnHRYVvJoKHwRkcI?=
 =?iso-8859-1?Q?c3DRNxbpPS+teMB98sZwiunoOtTwEEj5HzXo2GuHjz0XRLFqIfdfKY1kPV?=
 =?iso-8859-1?Q?crU9G62LdQpf1T4GOCEc5ihvudg/YEfywZQsHF/a6pj4Kk+BEpEOHg9EqW?=
 =?iso-8859-1?Q?9EmfWW6n/5KR3xoJRtX9DE0EWU++piT0dAVb1I1gO85Md2q3qtdFTX7cil?=
 =?iso-8859-1?Q?yvfzJoyXwEBzD7JBT6g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a7d2dc-1d7e-454f-b55d-08dd3979b256
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:40.2156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aciZ3rhAAGPCSiQEBjmcJIsg3iSddjlJLmv6wNM4SRviUd9hwLO+4A3QIsN13RQ/9zcCZ2AAUCNWsl2Nupc8HS7JfRdkXCXsokE+W2/nsjYHQUILuI1OCaP7S8WALL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

PSS field of the ecap register stores the supported PASID size minus 1.
Thus, this commit adds support for 20bits PASIDs.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 2 +-
 hw/i386/intel_iommu_internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f366c223d0..1d5ff8f4f6 100644
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
2.47.1

