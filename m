Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D953C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvme-0004fZ-Nb; Mon, 20 Jan 2025 12:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmX-0004Wt-KA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:51 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmT-0000Yo-8l
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394905; x=1768930905;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1IHq78BYelvBVFqSgj8wg7Wu+RzQhCjG5QqwwNWlpJE=;
 b=JMilGOXjA9O0FZcGk9I+yFP2c9ssNezxOqRjOkD3hPwc8IS/f6BpnDNK
 g2DcgGpplpGiPEHEDQbAO9N4+sjwlOFGMbaSCyXtrI/4OLHyBjKX1Oh79
 3LwzqymR5oTwAFsKdha8Rqql+0hCQc8r3ToTFF5MZ/EmDIR8GSb1nb7jC
 K/+mIVAvc5RBQKEC8KDwWe5rb26GRavZVhqxFt7r3kWCKONyVIipR/2Aq
 gZrZ+f9hkYNVNL0cVck651QygkqHvKpckI2/5fpPe8fvpOSYys9ND0e6d
 m4mtvDMwbMnCHvr8OVy64pj55ZNRgrxznouxFYPKKuySQnqbb8zoPbxIm w==;
X-CSE-ConnectionGUID: pok4FplYQVKzdHomUs3pCg==
X-CSE-MsgGUID: U58BKR2YRl+Wxv9EklmCXg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29125306"
X-MGA-submission: =?us-ascii?q?MDG2GIIuwTDLWn64efUFBUnYq5O6WeeW7k8zbZ?=
 =?us-ascii?q?noo5h1BUGzkRxksP5+TU9g5EIpFIQlJMNf+1o/DC0G94xStiMMJMUt4w?=
 =?us-ascii?q?cK4lhZxD8+BVNtFxB7XXlpv+LESJETnrtcEgsxRxTOKZ5BY8aJVWdAbx?=
 =?us-ascii?q?cjzoqKqgK4iFxC5Rhehb0s4A=3D=3D?=
Received: from mail-db8eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.106])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkjhhY+2+07zRne3zWdwa+Gg+5F9GZK49k0jrFk9yakEca/VSP02+rJKaK9Ofgfz0imF/hBta54XziHAayD58FeeQpcXmLLeEkrSt0V27WAjg505czyH6Hz1rIYzdRxv3hCK33QY5xVBPe0E8MrnKTqcfJLp7cPRwdGWzaXy4isHa3goYpYxLMGEoufcL5Fi+3zYuANGrhZTuVAAiPlxUOr0h/JOF6JkynW4N9c0A9sDjI/U9R1WQ+uRrO9veyMARFq6rvlje2/3lSU0GFEfRw9X7ae9lzXLkViAjJW94tnyiQHv2pOqyvIaEq/VOxTm+Zd4k8DVth+DCscQ3cDzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBCPTnyGGbWndBc2Xd/ytVLloQX3gIb+PHViU7P1S0w=;
 b=gJP6Z/v/SQ4J2dl2fanbRvI3OZBOBpop+K1dutRXzvBsdAVB3MNXTTWUXLtyAx3WdNtekmu89tADkBIzfbarbluL5+IMbx9rRGlgtzx7S0lxpGA74sQyGjEcfZdFKIxHzR3g2liOeDPb1LFEJPsIxNAjbgFDW9uyjqj4E0ztxwNTjFpEpq13trKyDZC6vVb+/Zmuj5lnCZYD53Ez2eGXUXOb2qiUP/ifbSXmhQzp6SjMYoEAMJA3zUZB0lnk6DKWuwbv4hT+O4dHL6lHO61/Moia9Pq8xi/PFCYr8IAENwx3a09Iz1Sd7CIWiUgQvTclgyD/fQRRraK4t6dw2jxM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBCPTnyGGbWndBc2Xd/ytVLloQX3gIb+PHViU7P1S0w=;
 b=TcnDB3KtF/Ciy8Ff5LHQn3tmv930Dr/9bv2ZM6JdCVUYvAdicn4ovDpIM+cAX9IHsfISKa74M3MwGkyOfrbUG58X1kfzsuMhZPH1KY7zOQt/BnF8jiwmIRj36Cc/m40fGJiOM2hyFVIGIW2Urgie1CUyt2cEcPkrCbDs1nDf1imuolsfLsyklctZuYidZ4Xx3eBQFLNZDzeF+XaxaEmIlRsUq0ASSHPvc/DXB0ZtX3wu5eEJLoQtW6lkCx9jsNFDwg+JPE3OxEgsNu7XYQuIJonDQ29uDPhVIJRxT8FSTZYYbDUNGZJi8tjy9zWKNiRu/25swKRwdt2pTdqG6HpiQw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 03/19] memory: Allow to store the PASID in IOMMUTLBEntry
Thread-Topic: [PATCH v2 03/19] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHba2KQqGWs+S0pR0S0AsCg/ViXhQ==
Date: Mon, 20 Jan 2025 17:41:41 +0000
Message-ID: <20250120174033.308518-4-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 859260f2-8915-4b60-5e94-08dd3979b315
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xtx/5E6NbW+2CnukQbag9JFe8917vNBjyV6BZsvVuObZhmVfthIqX0g7mx?=
 =?iso-8859-1?Q?3Cl1cfYRn6Q25pUcLpLq1F+KHsaalkoTIFG0ImR5p8auYQSJwDHLIlSrX/?=
 =?iso-8859-1?Q?gWXOnCakYWR3r9mYMXMKREpA7tjKXDdq9E9EqnsfeBYbCs3qOFaa6aN0do?=
 =?iso-8859-1?Q?F+pF4gvahXpRu5ilfjj25Zz13FtZPDBkjT81n71Ocqdk/UTJfUtqrIrarj?=
 =?iso-8859-1?Q?Smd/d0WNgK28gc4PTLEzqWTgur7eBs/av2mNLY9juO06wE9jtdidCFFXUp?=
 =?iso-8859-1?Q?WAsloGJlPmFfjdLmQCyXKNzdy8aM4iDwl/vbgzqUagcSW7QVCyCvbgr7Fz?=
 =?iso-8859-1?Q?4jn670cobjCSUR4yd6TElaUMIFSpgenvR6nW4mnkBK+nuQRhtoURyFVoo2?=
 =?iso-8859-1?Q?wDw7/q1jrZB+hxhfF0PMVU/fbzG59xXJiGPf9HLQ9cCuV/HqI5wErKRd3d?=
 =?iso-8859-1?Q?VCP/Z3eNkfT2T8v1Jpqv7OOZBwcKsJ6E1WjH3EMh6yTShL+g6b5IJeoDmC?=
 =?iso-8859-1?Q?UDHKE086lsQKsdoKPwbildIi+u/S9Az6ZLCvPBCLJrxbBxe1VjTaYxJ3Yd?=
 =?iso-8859-1?Q?403UWBf7k0qyDUHde9T5gcGGONFIRBe2lPBCFXrgwheCzicdeFMSmKGVOv?=
 =?iso-8859-1?Q?4/iMR9IJvZx6xQMJH+bCyAzscN2E8/pCDBFmYnMOmiD6Cik5IAWKskUG9B?=
 =?iso-8859-1?Q?4YBfZnCwDgBOFYyYD+5GhGUn8+76/MtjnrROVIpj+Gkbr+OlQpPpCiF6YC?=
 =?iso-8859-1?Q?fn/op54E156udbTqEAtTgdtIigvIVNaDVDDz3FIgEAocaZ7M/HGWFfjUEr?=
 =?iso-8859-1?Q?wucfPP/T/zAwYgs7X1zHgau4Iuq3Rlp53tadQN7U4Vik9eXlrcYEY0tJH4?=
 =?iso-8859-1?Q?OODRxFUkEMxe3mVPKlcFNTAQmnG70ai5pgrKQEJRdGgzYBfvUt1zPWM2X7?=
 =?iso-8859-1?Q?IQmUzsTcSYBVHAj7c0xsbAm3KkbFULmw7iovQgehMpaNGEZGbrjwldCAM7?=
 =?iso-8859-1?Q?0cuuLRq8TTUqjHqlbjLOWW8/7idMSzJnRRwCGX37duA9dIV/C3t7S7W48t?=
 =?iso-8859-1?Q?liXnjXwzSkQ0nQR1dzvkLTjLcnlYVsFfQd+4WnfUZKlzgN/etQLxCAxWUw?=
 =?iso-8859-1?Q?jHArYLAIbnJOr6OyPSXi8ref6sYR3+a+1V1Ja+9Pp9SkpTyCBszQVxAg6n?=
 =?iso-8859-1?Q?iQePzAlAsAAQTudFBN0y0knrAKQoFM9flSbe7KvTBwziA+GX2wJYtZSa0n?=
 =?iso-8859-1?Q?kDqjVDnyO458ujMCuzuuCJYJ/+NciJ+nJrE0AFQPHu1VoazGPPOkxfbekH?=
 =?iso-8859-1?Q?bAXOdfLyyeqvvXzl79W07sfmGDVrh6PxM8zb0PXtOP5Z9NkmpXuwWOpFNb?=
 =?iso-8859-1?Q?ijdKcJrte5bZcoHK9pzyQsOhC2GA43b6ggZuvn0BXGMnAox7BX3BF7qtIZ?=
 =?iso-8859-1?Q?BcN7nfX5BeRILQaNNUq2Hb/yIPquMGTMZr5scuamb+fpDQ6opLlFQj2JO3?=
 =?iso-8859-1?Q?2Lxbua/YM/WnyagwZdPCKy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?81Jbk9arfr6BxLPTrKuyDEv4UVcpkABC8XIMUxe5ZgEBZ1zuRpTUM65NMH?=
 =?iso-8859-1?Q?BrbC1N1K3DYy8bCNtxi4D65dp615yf9Z2RxvkoTtfvJFjP5PlQsuOsucKN?=
 =?iso-8859-1?Q?6f/y8TeKeWD0YSW3D/GlwEZ/yD2QFphiYnR1jBRcxVFXtAcrPIa6T0dPcG?=
 =?iso-8859-1?Q?YHvPeY6rgXUeJdB3gHl3WPRs5+KBUrL08o7kpK2VncF/B0jg73VmLmigIy?=
 =?iso-8859-1?Q?tiFNeq8v/hk6J9NHs64R99TDFSndw/gfkgqURtymxhMaWOlsl8rOq6O9Nz?=
 =?iso-8859-1?Q?PsPZ+eHLJFe3BLqK6CM46NglxiJ7UbOrX8b0KNJrtb81gBBoLB6y9EdXeJ?=
 =?iso-8859-1?Q?OdZSHKqJqZOvC8gcYgLKlnFfhjYn5fNuyNmbY77J3H9NGIHqANc9jSdAYg?=
 =?iso-8859-1?Q?1Ug8CHvwjL3EIgU3ZhQ7szpaS8neTDFvPy3/OE6zpaOJjXsN4l797O6TTl?=
 =?iso-8859-1?Q?jDq8ow48fHYz1rELU1RP3O8ueHEqn4hVzpfF7eyx3G+VPh+Wqk5D9obHuY?=
 =?iso-8859-1?Q?xZZ4rYN4AD/2mKbeHABIa7f0D7nwYH+6QaLLmredeQdlt3SJOubb5mb1P2?=
 =?iso-8859-1?Q?OZkrAnsT2U72r6UPLqq+RjE04AFNPn1hquYh2fEZQQz5a/PYw826Ep4Eb3?=
 =?iso-8859-1?Q?FKHvH90rC4pSpMtOMcHSU1FANop7sZpGkP1AIPOhxd6Qg1p5lNcf+cM0fw?=
 =?iso-8859-1?Q?vfkidDh1OJnVr2i/jPJQxGYyRGsh5xpaax2zS7jGRVLSCPF8QwZqTtWcA8?=
 =?iso-8859-1?Q?NxFSrZjozM+295KyI7lrVUu4Sl7RNH5+y/HvuSv9gF9Q+D2mFIO/jNVEu6?=
 =?iso-8859-1?Q?vqy/eJWGj2CPcO04gXHTBu6PmYf7qk993IFhKW2QxGxSSZJjCVY8SrHYxt?=
 =?iso-8859-1?Q?9d89Q0XVfn1hHfMAWL7BKdAyESyVruZmLMnaLbX4H6HRcvVGeyK8o2KYb+?=
 =?iso-8859-1?Q?by6NaOAJMKQwbTFEmfvFYqh2m3cih/X9ozJ2KBwv0R5dF6cj1mEkyjbZph?=
 =?iso-8859-1?Q?HRhMNwfKEA0Lo+EiNGLu+c56cT028Bt2JtaIBRhYvLXItZ4T+kMFUwbHrg?=
 =?iso-8859-1?Q?4S/Os/D3x6im4r8q2HGbp/Z34aGZqUn9URBKqZsjARq9QhxIu68GkVqjS8?=
 =?iso-8859-1?Q?osXrZ2xB4+5d5p0fASy70PLJdX8AmvePIMZhM0Ppw6+CJ6e8NbR308kJ/u?=
 =?iso-8859-1?Q?5Jv75hssXHHh8dJkeX6yz9STzPO2sDJrnA3IjMIkUcn86vr/ECAcxWlPME?=
 =?iso-8859-1?Q?4SJtAvgopQtoOK/HOALvzJG7vWfcV/8MV6RwzE4DPsBdyplaReNah4VC6a?=
 =?iso-8859-1?Q?SeUYbL4a7eYG+dhfCd0OWHEjqHH6+OF+9x0iH5I3cxCPVmOjR7zBZh4DRx?=
 =?iso-8859-1?Q?3aD6JP/wc0l4I0ny5bXYM5SuTWhOIIgzoDN24nUPxrDuQcZ66q56hkWFuq?=
 =?iso-8859-1?Q?rS9UQ2crkUahx/a1OBI34t/J/dVEqCjud6epWBlE5H/YcaYI5D1LCKjzae?=
 =?iso-8859-1?Q?bMKcyZmfuEQk+WLooeJrBybwK+B4Jwn6d6GPsKsHJGue9WbWxWTGpan+7+?=
 =?iso-8859-1?Q?FEkoNCfe8hGcUS8Sjtz4cu7iDJdE4tcr5xnxkc0Muih3Obu9l9kbyuTInp?=
 =?iso-8859-1?Q?FO4njY+gghKYNELCWMkjeIbAw1XjHkH+Nc05HfbQS0I8oFa2FOT3640Ywg?=
 =?iso-8859-1?Q?iV/o4dERv+R15krtdB0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859260f2-8915-4b60-5e94-08dd3979b315
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:41.4423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjjAvXkCjdljKC6bRZO5Ngl3pIPb/5+YKzWXS341Z3ZwPGh3xyl4460Z4xoD/hA2WrkgqYzjVctIGEu+ED2XG3ynaCzxPWgmbw9OcIVnyCWVWqfKMLibSPuIfOxkSO9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

This will be useful for devices that support ATS
and need to store entries in an ATC (device IOTLB).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 56c3a3515e..9889b97abb 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -145,6 +145,7 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
     IOMMUAccessFlags perm;
+    uint32_t         pasid;
 };
=20
 /*
--=20
2.47.1

