Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8720AC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4e-0004bg-4u; Fri, 21 Feb 2025 03:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4a-0004a7-JX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:48 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4X-0005ko-O1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125266; x=1771661266;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oA3KYmbSWy/K+XMLDvDgQtpvoImsgYm3m1tPp4EH2n0=;
 b=QZHvsRpUfW1ZNbCSIRY5tL8xWQu7tOrQQHNv6DIg8VYofmjlo17kQ88V
 YeNGSoNfLPhPZ7OIpWASPr9Ia+VpNBpylPZtvCeDEuoV4IIgR/n+4kHQj
 86pP6hVZhLyZ08d+PkjQne0DsV6CEh+y1a2e09JUx7DGsyq4jr/r1Ww0Z
 g49BFpCVoHZ8VuTH+TKy7UeUq8F4PctgXvvt4q17arMnrGQJb4mo+KVUS
 FHBUQENN/qioRv4kGfTLg941LO21NRJsRQY9jAnNlH/AMIGPRtcNnmKTK
 KsyAOUMbKd0ELkKmAJv3oVi48hb47ijyK3sWv1C8jeKpdEUG95WtT995V Q==;
X-CSE-ConnectionGUID: 55hloPUSTQClcBjDWfJ82g==
X-CSE-MsgGUID: ZIT6NtYhScadPcP9j11jzA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394139"
X-MGA-submission: =?us-ascii?q?MDFW4O0aDTiL9gxNcaIHmRyeclc9yMOUbYDmii?=
 =?us-ascii?q?sDvvNH39AiPYSgU7yF9euH5lAJAa1FAAHKplK2coB626ygvSkQyArnyR?=
 =?us-ascii?q?uhSMb128ym2n3rOkrXLOKE70Wz2iIYrqZn0QfY/wCyh46P11r97Borc9?=
 =?us-ascii?q?Hd3UWKwjzDMVF1DZ2JSOn38Q=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJhbVb8//KwnVB6Ktp6IAthOetYTNW1aYIZWnaWogqVZ6g9cyx9QW0gQF0LvO6LCtSpcSG4qOtbku6lbqKsX4hieZNL6tD1Phd1N9KGn8tTcgYjQH++qbbKtWujC/Y48P3VoHp7s4M7QKRhZHGzZ9Hs9mLCBlrs/BrMdAIpIIUv1ILwnOQ6zZRkGfUqTA/zSaAP69imLuqZRPGCi+vA8nlRFfPtE9YJWySKimMhwoklbH42Ux6i8fwDzvU3PBUyc8KmJC3L2vso1Tx8r5hHMGxCMF+W+gaESmH5FPNcyHnRTn0Ky27npyDPynaodiuR4S1ulroxTfRdR1s37S1Jq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/agh/ytGu+2jrSulAJnbz0Adp579Lwlc/FfbJbH4Qww=;
 b=fGCUwNoyJthXpD4y1MafWKcz1vCA/9Ru/tjsk8Uz2X6ltGLHEuAUAOv7e4Fa8qS0K6lbWA55YfXRFLfqszpVurnFBG2mIN5XZ/egmyu6JhqMQXcoOFP0RLdDq4+MEyKTtS92B1xc5/It3PiTkJeYevym6YZ6NMfXSH54kRQ9BLRdu68M/CNqkHk2oxGlmphzlLVoEvrbeFHEnY3Rn8NzgjyTSbATaouQaZZcnnLCQWPK1OEn8BO52Pebw7F7j4U9RBWItUx+YF83p+FmAeOFtUvY/0hR4ZDlzZGyz12huDHCsYC8fsbK8tz0lt44H/3V/wGVhs9N8J8oRpm6gwPpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/agh/ytGu+2jrSulAJnbz0Adp579Lwlc/FfbJbH4Qww=;
 b=mwPLx1R1q7etjoYeUgckrqSsI9Ow+9qYVkhl7aX39zSB+n/vz12Nye07mnwyo6n4QS+3N4bPGW0dhiBNCptYKCcfdc2jpVKlT/keBoEIViVH+TzvbRPagfZdNH85dN4/m+sS+Qc2Mait8asEHvHKkfESeCfcNXUTewOygfmgyxc1NltvcSy7dTPcP1gymkG0MRKX00JqkGg8YApCIUQK7/mUK8g4OcpZUpo6v+mDRzdDEJOvsn3DBxjLTdkXZrOtEv5x0sGqvm9p+rW5LGFwfzkey6bZx4t+wPs8beT6nC3COeryLqk8JG57H7oTPfjDRo10C3CTp09xZFy7j9rprA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 14/19] atc: Add unit tests
Thread-Topic: [PATCH v3 14/19] atc: Add unit tests
Thread-Index: AQHbhDet8wAXEtvxo0evRDLt6giiLg==
Date: Fri, 21 Feb 2025 08:07:40 +0000
Message-ID: <20250221080331.186285-15-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 59c5efbe-d102-40d6-1233-08dd524ed08b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gfq5nWvLWhLOdEt9IIqpsUS7g/1MCybXdTDnZo9Rys05A571xRkWkCtaXq?=
 =?iso-8859-1?Q?RfOO/fRX5er65P0qBFxxyg/yiJUk+qQmjzqLIkLtO/HXDFoB+7E1kGQVoK?=
 =?iso-8859-1?Q?h2UO1bCEjb6sBuN+n37OBWm5tlSt+g+vWFeWRcZI1KeT3Rlk0qcym+ZoxQ?=
 =?iso-8859-1?Q?JphZX9RLpAQoYNdmzyhNskmFf+Bsg4QP051XNLWIzSyBdej/gFdGt2jMOv?=
 =?iso-8859-1?Q?Wi6vLHPd/uNFoBVR0Ms9pWS5wan3Anes6eaCFAcZwsjDzg7eLhV2+GFi8s?=
 =?iso-8859-1?Q?S9Yd/L08g/69bX4uaWQVkPeAf1ee7QKPHCnn39Ep8OgpQ32W+MbzoBqL/r?=
 =?iso-8859-1?Q?bH3G4GlVNmGv+f8qTEOFOhLesdTWPyTVrBQysN5cIBHeWBUu5Xj4zAlkh6?=
 =?iso-8859-1?Q?khhthJimnR7XiQEfPNwKhoalH30rzZ866KIqeu/4NtrOsy4c9jRDFJxUFO?=
 =?iso-8859-1?Q?2hZ2YLafmemZqXX1MHQOcHtBfilas5Of6bT1EW6X9qxO8dl2V+AxNMeEfN?=
 =?iso-8859-1?Q?jwdbMBHXHPthe3qQieKffhhs0PY5tncaeAF9hbykWTfzqtknitNJbT/aeZ?=
 =?iso-8859-1?Q?M5roil2T3g3uB9DUb/lPeuK3f9Dy8GCagUZOUQ1viOn8fIW5Ur0v4+BSMV?=
 =?iso-8859-1?Q?lTMCgW7Dxr3d4nPJ/av0S0ZWbjJ7xRYNJsDU7F18E8ZxeOx/MqGLxj/pdc?=
 =?iso-8859-1?Q?pN4ejonSWk67+ImNTHIPKNwsXrM3de+1x0TKb3D35BtD/NzvsP+dQNRgw6?=
 =?iso-8859-1?Q?FW3RbDfG4GTaoIdQakL66UxavpSsqI4W3UtPVbieNhoJy+zV0YC8mtfMtD?=
 =?iso-8859-1?Q?M27IuGfaM8iOG49qfzP0pNusqSg506lNII+fdg0gTahCgsBeP5UnZc6qIj?=
 =?iso-8859-1?Q?rdIXc/EVH/xX5IPYpAN2RSAX+0aHY8wF2TWn29ALaTdqZrxWO0wE0avtHq?=
 =?iso-8859-1?Q?FkMNxS8AyJHlBjHheDo8f2VO4yYcQGb24abZibgJ1kuAvG4mZhJDAMhnLi?=
 =?iso-8859-1?Q?SdrK5UgiI6icnmBOAgUDHa2PGNshd7drIo2emxHxGnjer0MuNSLyD8VKnj?=
 =?iso-8859-1?Q?4pgMHGLCt2WlYob0PqOIkHlRUxR8jtny/IqTa/n7FhGkuvOxeuBhe6EaMI?=
 =?iso-8859-1?Q?PVisb60Ndxq7E4XXA90in85yOloMVxIAvDkcZxfjg+QvcVSnw7mT6WBTzD?=
 =?iso-8859-1?Q?T2AnhAANG9VSm1W7pNs32QRx1EOu+mXnxvghcAbPLR/q6CeQ5TmSYgUpiV?=
 =?iso-8859-1?Q?8xG+ERgrzjQGZkxcP7LGpNoq9ztvBEM0iW06j670wV1Gxrnz3JJovOXlzN?=
 =?iso-8859-1?Q?9Lc7RhmD2QwL/du7nwsnhx6q70diYKQSIzEoX3Lx4NFKhgEGUpQQGD7XtA?=
 =?iso-8859-1?Q?8rnxsk15oL6j57pGrnAufZR0pHuVp8kO+4tQ0XNrNShEIFeJGxmWVkFy2O?=
 =?iso-8859-1?Q?STK+7rXzCi3O5towq8Q/xuclkyK80MzLD/to+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6jy66aruHy4BjGl/5UzIX/hst9ZdNkTx+8bAcuzEDoVOJ8MAKPW1R6EJoj?=
 =?iso-8859-1?Q?6mOHUa8e/zTPpER6awgHaS8oKxjZBuV4NNozx/HvkIZxJHSuo2zcjuvMfm?=
 =?iso-8859-1?Q?IfJigZ1aTqajUabYHaouKq2qsSNUEd3sQuWrbsAQaHhxcOc5rnNB+G4FVL?=
 =?iso-8859-1?Q?NaZX4Kfvc2Ei9lm/saFbiv8h9JC8ip7hMWfA704mpGPcvJTNVWWguX+E+P?=
 =?iso-8859-1?Q?8YLYJ7nRjdgZ1ySErs0k+wm6RmCztiRsWbVC7TE/Qf9/1JQHTG8x4d/D2M?=
 =?iso-8859-1?Q?kX+Q1lcmCliKXLTAZq2QSZxewXJ+rhe0dUhNBXgf/mg7KSIlolNRVRFmSf?=
 =?iso-8859-1?Q?0mDctGCUyjH85vSxnScD/j5CU4Sq+pDYkl/2Uf37Gt0Yw5+ZNL0PKyYA19?=
 =?iso-8859-1?Q?4wyDJENQ0pQtMQQKFytpZ4GDgkCVzj9bIU7CpExTIcGwZq5UtaScFFGh6M?=
 =?iso-8859-1?Q?VF/NFehXQtafz88kQ8czPtwMLyIk4xktuShGCfXU6QD0wV3Koib4Y/DFAq?=
 =?iso-8859-1?Q?/sNSq51kKa6v/15hdKaOg2/RT5ryqcw7wkB3Ob7M5ItaT2T50wS5OyJiKj?=
 =?iso-8859-1?Q?R7cai3/xODERpP+XyYPYRKTQdUl5OKJ3IGyo1KtJOlN6byUu6+8VHhSBmV?=
 =?iso-8859-1?Q?WRCUjZfiHV2NqjVG0G3t6cmUnxNcVs5GEcS7Nfj9Je7zwuoEryLT1mf6s+?=
 =?iso-8859-1?Q?uUgGXWKiQ2wFEgHRJpyyOllNs43an27uzcXkcj34jSGgRrlzO1m3Tge6lz?=
 =?iso-8859-1?Q?Up8T/zqkPXYGRy5Uh9zD4AYJNJnrOga7+G+wHqtTLpYqDtiSXftO2gFjYx?=
 =?iso-8859-1?Q?/wfyNAAQbipbWdfpetNSt0nhIdK931lRIEG3Uf/eOYLghX1jhy1cdE68En?=
 =?iso-8859-1?Q?qw0Jsa2t09ogdqn112QID3eWGoVJs2qH8cuYRTLm0Mt0R3xt2N2UB7WRdy?=
 =?iso-8859-1?Q?6Lmy/yQ5gVel9OAGQZWD+cIWRgCzgnQflBOMxoEVeimGkGpfFP54NbJVxs?=
 =?iso-8859-1?Q?mMSX6A33rJD7JfpLn9HK03KQnB2vl5K1ymVUaiUxi9SKuhQVcXs3E9uEZS?=
 =?iso-8859-1?Q?6DZur9RopnwlzlFbv0vWdTGOyCeQyNlIkVmmymx9ugiIXAT175YGdv/KQz?=
 =?iso-8859-1?Q?AS5jibriDs+HcL8LavaFgYaQDSwu4R9qLJag1W0IT0aBECITy2wsOFRFAz?=
 =?iso-8859-1?Q?H4y067uNnWWUbqKYrjd5oGf2sNBrA+6vUJu2+2gOewofOr6IHiBfJH8yTJ?=
 =?iso-8859-1?Q?xe+0JY61xRRk6Vdm9TLrsv6XJsX6yBpiN+FZzPPlxJIaRLSreluBwV2UrV?=
 =?iso-8859-1?Q?/b/L9Cuu2XAqFV+2F1irJBdKKR10jZdeCXbPfj62azqw8Dce+DgIBvXajr?=
 =?iso-8859-1?Q?6iUlNnRXh0yLVomqDZ627sMX/GHCrHtrDUJNQfn8rb6hpE+0uoxZ82N36j?=
 =?iso-8859-1?Q?g8fbX4LYYCLHQBkoMtUyQt3y+H8nrrjQVoQTMbDaOcEO430YFuTYgZ/DV2?=
 =?iso-8859-1?Q?ys34QDg1naoNh7XWUsa6cGE0k7FrOUdtIlWoOt9itfbiJAjgUqpb1d0WHx?=
 =?iso-8859-1?Q?uHrcmryyEwHZ81tdliQFSDzaMRi4dkm12Cq271WAYiGLRz4qaS0sQoXDay?=
 =?iso-8859-1?Q?swc5WcjG+hqTQOEEUDTliSt+yH/L9PXJ2WT9u4bVWaCJmaMZJoTtnLSSd9?=
 =?iso-8859-1?Q?0DfOYP1rFScozyOheLY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c5efbe-d102-40d6-1233-08dd524ed08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:40.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gYI4TXqDTIR/BeKHssnE5Fm58s6BVJqxg0W5gkJ9ysO5UxkCRocXA7n6ANp23XHogY7WHS36fhPl6CamkOYFpojWPMLf5+XtpZUmJZQHuWl7+0uI63/tJeZbpPb8I3h
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 tests/unit/meson.build |   1 +
 tests/unit/test-atc.c  | 527 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 528 insertions(+)
 create mode 100644 tests/unit/test-atc.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..810197d5e1 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -48,6 +48,7 @@ tests =3D {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-fifo': [],
+  'test-atc': [],
 }
=20
 if have_system or have_tools
diff --git a/tests/unit/test-atc.c b/tests/unit/test-atc.c
new file mode 100644
index 0000000000..0d1c1b7ca7
--- /dev/null
+++ b/tests/unit/test-atc.c
@@ -0,0 +1,527 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "util/atc.h"
+
+static inline bool tlb_entry_equal(IOMMUTLBEntry *e1, IOMMUTLBEntry *e2)
+{
+    if (!e1 || !e2) {
+        return !e1 && !e2;
+    }
+    return e1->iova =3D=3D e2->iova &&
+            e1->addr_mask =3D=3D e2->addr_mask &&
+            e1->pasid =3D=3D e2->pasid &&
+            e1->perm =3D=3D e2->perm &&
+            e1->target_as =3D=3D e2->target_as &&
+            e1->translated_addr =3D=3D e2->translated_addr;
+}
+
+static void assert_lookup_equals(ATC *atc, IOMMUTLBEntry *target,
+                                 uint32_t pasid, hwaddr iova)
+{
+    IOMMUTLBEntry *result;
+    result =3D atc_lookup(atc, pasid, iova);
+    g_assert(tlb_entry_equal(result, target));
+}
+
+static void check_creation(uint64_t page_size, uint8_t address_width,
+                           uint8_t levels, uint8_t level_offset,
+                           bool should_work) {
+    ATC *atc =3D atc_new(page_size, address_width);
+    if (atc) {
+        g_assert(atc->levels =3D=3D levels);
+        g_assert(atc->level_offset =3D=3D level_offset);
+
+        atc_destroy(atc);
+        g_assert(should_work);
+    } else {
+        g_assert(!should_work);
+    }
+}
+
+static void test_creation_parameters(void)
+{
+    check_creation(8, 39, 3, 9, false);
+    check_creation(4095, 39, 3, 9, false);
+    check_creation(4097, 39, 3, 9, false);
+    check_creation(8192, 48, 0, 0, false);
+
+    check_creation(4096, 38, 0, 0, false);
+    check_creation(4096, 39, 3, 9, true);
+    check_creation(4096, 40, 0, 0, false);
+    check_creation(4096, 47, 0, 0, false);
+    check_creation(4096, 48, 4, 9, true);
+    check_creation(4096, 49, 0, 0, false);
+    check_creation(4096, 56, 0, 0, false);
+    check_creation(4096, 57, 5, 9, true);
+    check_creation(4096, 58, 0, 0, false);
+
+    check_creation(16384, 35, 0, 0, false);
+    check_creation(16384, 36, 2, 11, true);
+    check_creation(16384, 37, 0, 0, false);
+    check_creation(16384, 46, 0, 0, false);
+    check_creation(16384, 47, 3, 11, true);
+    check_creation(16384, 48, 0, 0, false);
+    check_creation(16384, 57, 0, 0, false);
+    check_creation(16384, 58, 4, 11, true);
+    check_creation(16384, 59, 0, 0, false);
+}
+
+static void test_single_entry(void)
+{
+    IOMMUTLBEntry entry =3D {
+        .iova =3D 0x123456789000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 5,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 48);
+    g_assert(atc);
+
+    assert_lookup_equals(atc, NULL, entry.pasid,
+                         entry.iova + (entry.addr_mask / 2));
+
+    atc_create_address_space_cache(atc, entry.pasid);
+    g_assert(atc_update(atc, &entry) =3D=3D 0);
+
+    assert_lookup_equals(atc, NULL, entry.pasid + 1,
+                         entry.iova + (entry.addr_mask / 2));
+    assert_lookup_equals(atc, &entry, entry.pasid,
+                         entry.iova + (entry.addr_mask / 2));
+
+    atc_destroy(atc);
+}
+
+static void test_single_entry_2(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xabcdef200000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, 0xabcdef201000ULL);
+
+    atc_destroy(atc);
+}
+
+static void test_page_boundaries(void)
+{
+    static const uint32_t pasid =3D 5;
+    static const hwaddr page_size =3D 4096;
+
+    /* 2 consecutive entries */
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x123456789000ULL,
+        .addr_mask =3D page_size - 1,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D e1.iova + page_size,
+        .addr_mask =3D page_size - 1,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x900df00dULL,
+    };
+
+    ATC *atc =3D atc_new(page_size, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    /* creating the address space twice should not be a problem */
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova - 1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova + e1.addr_mask);
+    g_assert((e1.iova + e1.addr_mask + 1) =3D=3D e2.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova + e2.addr_mask);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova + e2.addr_mask + 1);
+
+    assert_lookup_equals(atc, NULL, e1.pasid + 10, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid + 10, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_huge_page(void)
+{
+    static const uint32_t pasid =3D 5;
+    static const hwaddr page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x123456600000ULL,
+        .addr_mask =3D 0x1fffffULL,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    hwaddr addr;
+
+    ATC *atc =3D atc_new(page_size, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    for (addr =3D e1.iova; addr <=3D e1.iova + e1.addr_mask; addr +=3D pag=
e_size) {
+        assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    }
+    /* addr is now out of the huge page */
+    assert_lookup_equals(atc, NULL, e1.pasid, addr);
+    atc_destroy(atc);
+}
+
+static void test_pasid(void)
+{
+    hwaddr addr =3D 0xaaaaaaaaa000ULL;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D addr,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 8,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D addr,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xb001ULL,
+    };
+    uint16_t i;
+
+    ATC *atc =3D atc_new(4096, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    for (i =3D 0; i <=3D MAX(e1.pasid, e2.pasid) + 1; ++i) {
+        if (i =3D=3D e1.pasid || i =3D=3D e2.pasid) {
+            continue;
+        }
+        assert_lookup_equals(atc, NULL, i, addr);
+    }
+    assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    atc_destroy(atc);
+}
+
+static void test_large_address(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaaaaaaaaa000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 8,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0x1f00baaaaabf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D e1.pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 57);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_bigger_page(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccdde000ULL,
+        .addr_mask =3D 0x1fffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    hwaddr i;
+
+    ATC *atc =3D atc_new(8192, 43);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    i =3D e1.iova & (~e1.addr_mask);
+    assert_lookup_equals(atc, NULL, e1.pasid, i - 1);
+    while (i <=3D e1.iova + e1.addr_mask) {
+        assert_lookup_equals(atc, &e1, e1.pasid, i);
+        ++i;
+    }
+    assert_lookup_equals(atc, NULL, e1.pasid, i);
+    atc_destroy(atc);
+}
+
+static void test_unknown_pasid(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccfff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 48);
+    g_assert(atc_update(atc, &e1) !=3D 0);
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    atc_destroy(atc);
+}
+
+static void test_invalidation(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccddf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xffe00000ULL,
+        .addr_mask =3D 0x1fffffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xb000001ULL,
+    };
+    IOMMUTLBEntry e3;
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    atc_invalidate(atc, &e1);
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+
+    /* invalidate a huge page by invalidating a small region */
+    for (hwaddr addr =3D e2.iova; addr <=3D (e2.iova + e2.addr_mask);
+         addr +=3D page_size) {
+        atc_update(atc, &e2);
+        assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+        e3 =3D (IOMMUTLBEntry){
+            .iova =3D addr,
+            .addr_mask =3D page_size - 1,
+            .pasid =3D e2.pasid,
+            .perm =3D IOMMU_RW,
+            .translated_addr =3D 0,
+        };
+        atc_invalidate(atc, &e3);
+        assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    }
+    atc_destroy(atc);
+}
+
+static void test_delete_address_space_cache(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccddf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D e1.iova,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    atc_invalidate(atc, &e2); /* unkown pasid : is a nop*/
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e1);
+    /* e1 has been removed but e2 is still there */
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_delete_address_space_cache(atc, e2.pasid);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_invalidate_entire_address_space(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x1000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xfffffffff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xbeefULL,
+    };
+    IOMMUTLBEntry e3 =3D {
+        .iova =3D 0,
+        .addr_mask =3D 0xffffffffffffffffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e3);
+    /* e1 has been removed but e2 is still there */
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+
+    atc_destroy(atc);
+}
+
+static void test_reset(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x1000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xfffffffff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xbeefULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_reset(atc);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_get_max_number_of_pages(void)
+{
+    static uint64_t page_size =3D 4096;
+    hwaddr base =3D 0xc0fee000; /* aligned */
+    ATC *atc =3D atc_new(page_size , 48);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size / 2) =3D=3D =
1);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size) =3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size + 1) =3D=3D =
2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, 1) =3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size - 10) =
=3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         page_size - 10 + 1) =3D=3D 2);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         page_size - 10 + 2) =3D=3D 2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 1) =3D=
=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 2) =3D=
=3D 2);
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 3) =3D=
=3D 2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size * 20) =
=3D=3D 21);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         (page_size * 20) + (page_size - 1=
0))
+                                          =3D=3D 21);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         (page_size * 20) +
+                                         (page_size - 10 + 1)) =3D=3D 22);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/atc/test_creation_parameters", test_creation_paramet=
ers);
+    g_test_add_func("/atc/test_single_entry", test_single_entry);
+    g_test_add_func("/atc/test_single_entry_2", test_single_entry_2);
+    g_test_add_func("/atc/test_page_boundaries", test_page_boundaries);
+    g_test_add_func("/atc/test_huge_page", test_huge_page);
+    g_test_add_func("/atc/test_pasid", test_pasid);
+    g_test_add_func("/atc/test_large_address", test_large_address);
+    g_test_add_func("/atc/test_bigger_page", test_bigger_page);
+    g_test_add_func("/atc/test_unknown_pasid", test_unknown_pasid);
+    g_test_add_func("/atc/test_invalidation", test_invalidation);
+    g_test_add_func("/atc/test_delete_address_space_cache",
+                    test_delete_address_space_cache);
+    g_test_add_func("/atc/test_invalidate_entire_address_space",
+                    test_invalidate_entire_address_space);
+    g_test_add_func("/atc/test_reset", test_reset);
+    g_test_add_func("/atc/test_get_max_number_of_pages",
+                    test_get_max_number_of_pages);
+    return g_test_run();
+}
--=20
2.48.1

