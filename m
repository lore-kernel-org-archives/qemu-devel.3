Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBE6C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuK-0006De-UM; Sat, 28 Jun 2025 14:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuJ-0006Cp-GP
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:07 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuH-0004AS-IZ
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133845; x=1782669845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5/MT+neAUc0xTZFXHxlgB4fXoFZd90t1JxNGuAOUID4=;
 b=MOFTVY3xnDH3pcfFM98pcxTKdZGldZ2RIc0sXD8fhQRZRQKpz4J9iLTk
 8HO4iZp222DNgtD3a2RO8XvqOkdnTd61BNr5HYZW2v9R3CtbMPl2Y1WDN
 e49pTDqGEKI6Bsh7tYn88P2uy9c7s3CAsRfkLjHmddE5DUds2R7bBZPd7
 QQ2DjnmWddXA35txflO4e0OX3j1gTeQUyLQBg9sJ51ypkvhl5IMoUWJMf
 8epgl1j6cfqbKnjRpGmzeYNporwjPK4kiorNhqiwKJHPWNX4QF0LcKr6o
 COUzU4HN85ILEYtND8TaNKHynrrm8Zxcde7/66ayG1r0SUwUnDapztua0 w==;
X-CSE-ConnectionGUID: DEJmKSU0TRmj2iia030RbA==
X-CSE-MsgGUID: a0T3MIdIR7aPYp9ToXDG5A==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39512593"
X-MGA-submission: =?us-ascii?q?MDHOyo4FuqEm6awTuUbCffeM4jG0n68xviywgV?=
 =?us-ascii?q?nmcGZu+HzpLWMl/hz+1qZUODjLWgOeVGTApYxtFiv0p5ShvlRdQpv8Wk?=
 =?us-ascii?q?Rb8RFrUncnV0W/9nEQgpxxh/C4Gv5X5k7/Tb891WzYd1oY4On3Qit0ZI?=
 =?us-ascii?q?9Ml0BY4TjsfbXPYmkcPVn/zg=3D=3D?=
Received: from mail-francesouthazon11011037.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.37])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdk7iqGbVuVXAP1g1weN2Yj+4i4RIw6MfB6RJMfoS4JNGDUADsMEU1PPW9uVyjJSExEufHB1M8YnlfbEadMZ9WpOLMcohJ/I+WkKnH/c+NUiu2G/A7SBtvR2MDaW89iq4aMqqcTOdFu99ztYuXNoFSYijPnZ7PXZOw+zm5ardVTaK9AkNy5weVc9+2ITZ0AR1E9NlJHvlTl5gVC6wy+DJ3x4zbbXVK9cxaaGfL0v1atw2gpPbTR0aSP0icoGzYvozK9dxleQ/cDqkAibPx75Z9EAvBn7OHhvcPdh7nq8zHOd3qLSkcENYasX3O9/7sutAP9TxJwlB0B+br4T5DV0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEa2JaTFrk/1LfxxUtXOk9PpwYCNtDylNNgg5AA137M=;
 b=TjpphQCUvn3sqy/yg/PPgq55ecExwTViEwjV3LWjZJCH3CfgiKX00uptEMc4qUjfVw+HVHJ3gnn0dMjr5ktH/4CWFv9A8Kh5Cw81skTYe6ouIP/+rkmxZ0pnVfUlQ0IYdF4nILeJ1jtNOmnzy86L+uWvNavwWe5p7f7hAMUEjUQ35PgQHDUshgjQXglRQt+MmEGqkwWyM5etE1xSuGoU9WwnekRakj3LdxQemvnxckr44I6ut/EfDZ/V97rjX027Nih/SXEN0sWO+EIYVTPZXdN2kLLIy2T/p5pqzx0dvz3WNQr3XlCK+behIb2oRtMgVNKK/M9J1upo8XP3IX9P/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEa2JaTFrk/1LfxxUtXOk9PpwYCNtDylNNgg5AA137M=;
 b=aynNfRWlHusdMWnL9TfCzEKvOgsB3lLCYV2uWLu1g4B3MtwPvFTBFNu4tEDidIWDWcgk9enUeqze6EJIJsDWqDKXPbYoqjUmClrs2LMbU2y/7EOZ1hD0zyuZdUKNx/ZkemA5yuSHkamPnq3qgQCXdfkPMjGHH+x/XqPXKUmWxwz0cU/AkfisJ3bcqzysVKuKiltl+UZ+mrf6yZ30ndb+Z+hiniQY6n8/cjrsUR4X3acq5Kc/fzMKI/hMxY2y2bRGDlmG+m1NDG0VbEfJhzvajmnkA3rhZUt52MYeFQRVuWnkWv1ZCo/W+qxiSPw/4f5jCUJvBOiYoSg6SRXhqIJeaQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 03/10] memory: Allow to store the PASID in IOMMUTLBEntry
Thread-Topic: [PATCH 03/10] memory: Allow to store the PASID in IOMMUTLBEntry
Thread-Index: AQHb6FcGxot7ThSEDEqBR9/2xYcZPQ==
Date: Sat, 28 Jun 2025 18:04:00 +0000
Message-ID: <20250628180226.133285-4-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: ccf7026e-63e2-4040-b076-08ddb66e2929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5CwJmTyIo+RazaAeWFt5Ors9qKvoMdMWXx00Xn6//QWEVFUcndAsG2f/c0?=
 =?iso-8859-1?Q?sAQoCJ30n8RqztWRumnqiRy1N0rWsFc0TdNV5iJbEFZvRKoq/TVKwXWv3X?=
 =?iso-8859-1?Q?o7FmFJcj4HR8Me2MJEnClSUSnbz4YtLoEFzw0L5govKgbPr4cssUfMdifM?=
 =?iso-8859-1?Q?jxgpRMRbTZVJkfoROyigyepxfCjvKqlFmo2VtCLjxuWtfqBTZ0smqNqhPP?=
 =?iso-8859-1?Q?wjufvq5Yo3meMB+jyTyVzv6/9vqgRAcSGCH9tZU9eh3OAbz15S9Koj/M4R?=
 =?iso-8859-1?Q?cp4BwGxHGrfj7b0b7RCrnx637aUplGHvavlEdOYOpSdAtvumpeWnocu+KS?=
 =?iso-8859-1?Q?HMlEOJtj0PZ8PIQ3pUaI9eVqe50uuVUdqhrU2Ug0xq3vaa3hBql8lSe/Vt?=
 =?iso-8859-1?Q?7E1qHXZ5oqr66/L+LEcVDqBxgLg2aWuGRhWtHRqRnkeqNeTzuLlweIzYNN?=
 =?iso-8859-1?Q?pZDgq0h2kSMLp59P9ginJMx4QIAA0cWx6n2SDoMeelrWwnPRAaMzP+IGJ/?=
 =?iso-8859-1?Q?tHnVtbamiZ+OLue1g+sd7CdZdJphXGtU0EH3/SXfoQjq3dPKj5FeHfBYtH?=
 =?iso-8859-1?Q?JHU8IDFYznWhWdrbcOSXMXlbeqCfPCS4XBXLPKvF5iGdMs1Bn7D1HmDGd6?=
 =?iso-8859-1?Q?1CtC9G86Obly4s9KL1ylaQsStJxAXftwDODZAxPsCpgY4tuqRHeJPmoCOD?=
 =?iso-8859-1?Q?hg71FYGurYrwNNDGJthiW+iKdJotEFCVE3SDjymHWSvlrzp0z0bx1tQZcM?=
 =?iso-8859-1?Q?WSDnc0Y1OUtb2ILEEHzAt5DnTTYKdpbW83eqMkqV1mVdiklinnl5siAefo?=
 =?iso-8859-1?Q?B5ISJzV9anbrJpESFY1Oyrxa2gTnJOV4uIM5wojbNeYOFEV8s0yMBithNS?=
 =?iso-8859-1?Q?H3r4pDmS1Cc4GpqS3pdst1Fb9KtTOCdMMEq6jw0cn1H242YuEdwScYsOib?=
 =?iso-8859-1?Q?u9FYgKYyNjtwJpWpfXu57TnEP3Ep16twZzBJCbDDDdzn83H5CTqxYHgSbc?=
 =?iso-8859-1?Q?c1XPuMRpGbo3hWfqp08mcVa+sQdG/XMuas/9dxPdaMPugogcK3W1GXYW75?=
 =?iso-8859-1?Q?fjB7lDr2S8wVYy0IUwGZ9Dey5/WgwlkpllVJJv1dWC20wj4eoDW21cVLPB?=
 =?iso-8859-1?Q?nqddt0jVcThOjXrXlRr9e9IOZNbmkIIzdSXaujHPAjj0/iduQGTsn5ZgTH?=
 =?iso-8859-1?Q?BES5GZuayE8RMXp6ANshbTlPUvzORzUF3CT5d6oSdA07S0KjpIMGL5+EZs?=
 =?iso-8859-1?Q?3aJToTHzuJpEk7LQEy+x+/NxuZDN69SEpsL1iJy5GY/t7+ThjgrXpYBo01?=
 =?iso-8859-1?Q?cJA6yDWGw4V7xyZBXyq2qm2xWfwuKAF42cZwgjj4MqWTifdOj6BF3vfBdH?=
 =?iso-8859-1?Q?Gr7Su4HhLLF8BlqjaslFiJBrycmFHyhb/wuEraho1wPDG3ooJjS2pQHbjQ?=
 =?iso-8859-1?Q?usVHlEHvrzDocLfvmhZDfB3v83a9DHD7euxh9I5ivi4aXtQ4/SbIm4w9uV?=
 =?iso-8859-1?Q?OPawLuPDXuKJUFHRBZTNu9XunCBHwc7R4UJmj8bg62fQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L76tk/+c4WiVbkjKVyxfOjuPqKH7/Vgs07C/bqmtYt/fGPvQGxz6Et3E3h?=
 =?iso-8859-1?Q?IIMkEe2BOKZA+75f3IfAna7yvGbHlA1LWi01SM+R8V9yNYi7gr6yZ/6H4/?=
 =?iso-8859-1?Q?7J7ks1BEjhWneq8PXWibS/yBGarSYN3+tIFNZkGIUJHrieZByIXqeDmQ9z?=
 =?iso-8859-1?Q?xvH9+iJsRWb6Jy8Sw/+bj5jWMurd75yfGX43GkpANIxxbBO1ISk1M76k/0?=
 =?iso-8859-1?Q?Lmmtgsz4zqPLmB3yYdxZCyfGzVQFE7uZELv8Q4h7Yn4B4/7ecBpensDCUx?=
 =?iso-8859-1?Q?Bt5aE36idMjssP0/0xBX97e+I/Lniku4AAtuBpH2fGou1s7tfcrLvhfqIf?=
 =?iso-8859-1?Q?VPQz3gQcz1d4/4tnfER3W50qCWEr1MgJC8be6sZy4VBGgOkiKxdScALfAm?=
 =?iso-8859-1?Q?IkJmfhlAHHQhLj0ZytjVU6x/4kQH8MDXX2anFRJqbmFpO3jvnt9ndy9iN/?=
 =?iso-8859-1?Q?OpxSeklkL++7vScL2BBTHwyd4+i7TIidb62zE5lJxY1XUDZFtO9BoJxfgR?=
 =?iso-8859-1?Q?jHuz0MsO2dAnHcFoWzOkdaaTxc8dPKhP6+lorVYckxfUMFprEX6jEiH+F5?=
 =?iso-8859-1?Q?WXXuqGHfDfN8whjjE5SUnHMZKN+jLQsF0vHdaegc8xTWhcKnWb0FzL0QkJ?=
 =?iso-8859-1?Q?wLw8awe5L/w5zRg1f2bp/YHVwIs7fjonY0FnBlKJFEANzuXiXIOUyU3go4?=
 =?iso-8859-1?Q?w8+OdCdiK6/8v7r7WND3qgCDc7h22588+qRMPD4wUAPZYs8frxVuDz2GDZ?=
 =?iso-8859-1?Q?ixce5nOynWkEVzxdI1TXtR22WOJLnJzRhnvwi9GnwA5hUN+BOwnXIO4Knp?=
 =?iso-8859-1?Q?7Ph5PwRCEise0jzCXGLMNdoTVsI8k1uDwdohz6H4ykfti1UkmHEZOtn4GQ?=
 =?iso-8859-1?Q?VJVzmPBkXDUcTsscPKl5I43xS+dd05cdUU8ForNnL6LMvCHFv0bPGxAvWD?=
 =?iso-8859-1?Q?VMb0KS0o+TWKLuS15xZ3DYcwe0dTVYzOfNCIa7KaKolZe69dBLJ2WfkL9v?=
 =?iso-8859-1?Q?RYblP6OWms2cKb1dva30V4jZuUnZLMKv1P27AZ4ZP0/ZMwITxwCPGZztP8?=
 =?iso-8859-1?Q?SMNmLZ0qcg0re/zTMieEb8nstY9YVYCWAXZ0WFSO0V7pUR5Oc2xYitQKcR?=
 =?iso-8859-1?Q?VdslmQMZp6FtN/j9ta60+JEQQ++VmHF/xzlAgYg4+1j//YR3/gB3puKCqc?=
 =?iso-8859-1?Q?trFIIcc5cS7VLz2hjo3h7YaVAacV8BTGtQN8M84nREQND+Jf6YPSE8zUyj?=
 =?iso-8859-1?Q?ngNOHX07ozeXbq4+BPdbIMLx4sj5mWJB/wUF1qvBoZKltSYFuyzzthrYHG?=
 =?iso-8859-1?Q?T7iEHpq1IfRBkLuEy/f/MNtRKIdbH74kaCFuLfjmfLemul2DhhFunNlUcy?=
 =?iso-8859-1?Q?XpTEqag8o0epZaA47tSWou9cYA2v/ooMvNcfXmzCMVnGiuMdAho/Hklv1P?=
 =?iso-8859-1?Q?aATCV545W4SYy2HKW/ocRj6xOPGQDTr2SkKNgcy6zOC9jwjhMRDVzv059C?=
 =?iso-8859-1?Q?GJbqfZn2N1UhjsMi3ygFQsMdTvr0du7K2dLSRVELmgsC1UEwfeqY/XL/+a?=
 =?iso-8859-1?Q?ft9Bqr5oO+EQgTIP1phLcguBduZv8mSRw8JngSVFSalCULw/7K+/Hdpj27?=
 =?iso-8859-1?Q?DmXW1MryJpzGQMrqx5hf0xS8r0+7dNb2D6r7Ll5fuEBHlN9+zw0SR3+BoA?=
 =?iso-8859-1?Q?5gG/h9q07LBehQGoqcU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf7026e-63e2-4040-b076-08ddb66e2929
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:00.9709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEVT9XrdXUosySGLCbJxEKg9OZk8vRIVGHyZEUqyO+iOC6wDz2SuwYekz+pKZUQaF2nTFOxRkAflC9Msh0cPfI4meSfIo97T0Z900/wOfXyTL3ymDWyt//Bejs9eiF11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

This will be useful for devices that support ATS
and need to store entries in an ATC (device IOTLB).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/system/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1672622d70..d6d069fd50 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -144,6 +144,7 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
     IOMMUAccessFlags perm;
+    uint32_t         pasid;
 };
=20
 /*
--=20
2.49.0

