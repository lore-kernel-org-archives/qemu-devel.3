Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB2BC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmj-0004s0-Qa; Mon, 20 Jan 2025 12:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmd-0004eY-BW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:55 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmb-0000Yo-H2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394914; x=1768930914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZIOT9iQhluPDbIqbho90pINJD7KjmJBOhC3aAEtEqFI=;
 b=u83ksaAdHKGSO8j+rL58NNq0p5YGZFMaYxY/tWGcxEwdJNqwANJcWpPi
 vEcREfkX9EQZv5ySv+fH/o2vHfZfuVsCq2b4JmvPfdWj+geEW9XIiF8qv
 8HCU6fUcaGu2s6u/IZD5reTZAp5DyIWmzhB45F4KhQdwN2UCUDyusI1sN
 GVCzr1l8aqwlFbu5cukis4W48aYzVDG3awnPyK/kb0QDyLfj2fXLEiIl7
 9u4xCy9N5W/l56XSiqaRjI4ddwtaikQxl7SkZKMFAUdJd99IbHlCvPswC
 0TNnskv6qtD5JyQ90NuSfLAaFCSduYIGky5U8yf7i2RBQ5K3u5cmwNLEp w==;
X-CSE-ConnectionGUID: K3jlmBP/S2CO6pBWs3j6Fg==
X-CSE-MsgGUID: GQmBHHyxSRWai9LvsQC1Ug==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29125317"
X-MGA-submission: =?us-ascii?q?MDG3E9SiOOAubCfPZA3XNhr4iuV/tOU12pFzDF?=
 =?us-ascii?q?1aYJswel0i5nTynKiLeOPyPiiUbokWfycUnXacXMQ975zg+pArpZUCHH?=
 =?us-ascii?q?yA7tRzGwdSlkmBYM8c4gBi8HYNMPfQ12Ev49gUcp5q376+A4Nyn6Bb8x?=
 =?us-ascii?q?AC9s4rG6Uxt5Rs3FEcZQpkwg=3D=3D?=
Received: from mail-am6eur05lp2112.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.112])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:53 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA1zfjxAZZIT/RxW/kibn0+lUznTYSG20XewMNMAWvmmug6zwhY2r8SKw0JqqsLZ2eAZphU35vY8eUug6jni9oTeCQOFxtb2CY+kH5l7IIz+FKRYS7WmgslUzT2qanADsLrxNmDzK+a9YYmGOogbyGNTTx3wITPiHdudZVNk2at+avhLjcQnWoEpgkrzAmxXkWGvULVrakQk2/HYZNAG1JfCkl1l9J+r5gKSc1ymYmisXiPekHTTRk0GaJs6Nxk7RCUOFa0/+YPEdmaimZyLLB4mXth8QNRxeXTQkY3OXtoh9G3bkPbSWxPu11KMiUxZnVU26kqTzFGdB66IpNburw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8VdlQWnhpXy0HtPJRFkjFTGAckun8aBFJlSx79Q7CI=;
 b=V8yqhQPY+1+bCfePytQVdBlKiumN6hg2Np+jBXW8vBIo9R/B3bO38q/7tXOz7MOP6OvzWM/NFvaT8mFWsrQuZp/K9GJ0Xf32Uq+ypdL9dNQXNWr4po+/KGco4g3j72V8Jl4qS3sngZ/VL20uMLK9krZWZEDQZmpm8eBsgQDtxwN5KIPuJffcDrHMVsKWkz5YlrATjwBlJ6bfXwoi/jIRUYx+OyWM2nSmQYpfNBSq1gILo9/A1xgMvBMzJ6mbwLbFXeLk8oGSkOHWkJLyQzsXavv9xRwVfF6DPM9s8tHEifgEJOmmx+vEyQQJkhgQ181ZZdfFNTe1fgkSbsoQ2akBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8VdlQWnhpXy0HtPJRFkjFTGAckun8aBFJlSx79Q7CI=;
 b=aeHW6zNk8lyxSIOqEwqzhOqkYV1tSpa+Qn1sJUv0Ti7YdLmDnY+LQ3bARzi4HOFX7XBYmq4Bs8QOafdyNvao+lizJrJJVxOoxUZmKK96EQnclaQI8WZCU6KaR1bxS1+UwOhKpgwQrOo94Vw9MMY/YmnF29dgtDOyWUo1sdHipwk5VazhewgP8YxqEYshfgQoQ86BQezIRYO0f6Y7kP1BjCtDNK0NDhJGI6J88LjPsM7KRAea2KXPbYJVT58e+3ZBo7CFhH0ER0sAqqj2QVQUbZm//AQI/xPTWaPWfmyxixd3Xc2Pv25ByrnSoefhLGPVr6oIBBCjjf74p2/IrSs86w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 12/19] pci: Add a pci-level initialization function for
 iommu notifiers
Thread-Topic: [PATCH v2 12/19] pci: Add a pci-level initialization function
 for iommu notifiers
Thread-Index: AQHba2KWf94PTyJm8UuanHrURjYpuA==
Date: Mon, 20 Jan 2025 17:41:51 +0000
Message-ID: <20250120174033.308518-13-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 793d97d7-4f0d-4787-1d12-08dd3979b8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?C50UJbo7WRU7MzUuWUvNFF/fmg3KNph+j4z0OZO1ZQQ2P+qewrxYiIC6qp?=
 =?iso-8859-1?Q?444WdN4gGupdWkt4oFWljEa6IdepzGC0um8otgoz+PZ5m96EgLCf9IicDE?=
 =?iso-8859-1?Q?dupIKnj4updGeyKUA40oDsQx7j71i0AlLMAfM2Fhdosn6+encuUNGFaIfW?=
 =?iso-8859-1?Q?Fg05JdJPocOMTCFkCsTefks3pZwbosntNaih+sATO31Q7PPBUsVl1uxDq8?=
 =?iso-8859-1?Q?CHyfxuocs9NUViTa2bEGdccIpDMTfwQOWPTYAEvQ9sbv3RpXq+NeSrnGXl?=
 =?iso-8859-1?Q?nKGA7t7uoARXnqIy/E3J1JbfbLTy0H4lhL4prMJfUENsguP/CmiEV3FaNG?=
 =?iso-8859-1?Q?tfoAKj+8hnZteMpqOkkYI/KZSeQeiSLwo5FFScYSgcxUu/YBH+jycQE1Uw?=
 =?iso-8859-1?Q?mWbc0iMT5ZGKoLXO/lJNmFRCiJXQfqnwQCHWmQigMDdEdhk/enmiH6nF0v?=
 =?iso-8859-1?Q?OG8Iag/faY7lD0xtGVaKG7+SL8/KGbR2ijFNUUbBevTzy3Spo67sGJ5i18?=
 =?iso-8859-1?Q?jBLN0xNSEt5FH1mu0/Ru7d/To+cjI5Rj82HxRx/B9h8y2X1ZDAZPzpN13v?=
 =?iso-8859-1?Q?wIO91izxKrdjDiyBZr1zOn2o5VUAL0EBTfQVAxeCdgUFQ5STkYuR44iT5Q?=
 =?iso-8859-1?Q?Lr4scmXARIpHrguwBtgmrD5JkZf6VqmaJeTP7QkW8r94TFJThQUaY5K6Nx?=
 =?iso-8859-1?Q?0/m4tv6VeJ0Dln7+90Zrmxr5WNtLzhwK3nItiQjBpapWPRmenGQPmeJkEE?=
 =?iso-8859-1?Q?slPIemWfsQp4/n3QKPG1dpfI/voNybWVa4fSvBuP2nncul1UzW9E0NgKRJ?=
 =?iso-8859-1?Q?/s2Ha0sn/yMPb+IE89RWT+FBOkMy9mZRqUeb7dMECpkjJbEMNJd/R5EQ7/?=
 =?iso-8859-1?Q?V/J8PUsz5FN0csD+MwHe5I/vUDvCWL/YH+au9fvwFMn7AEKa2HCMZFtIKa?=
 =?iso-8859-1?Q?TA9s7pXJBmLl3n/6MTMD8DXlIDLRxZps4+3MlcryUKIcLY0OVp+akN+Ep7?=
 =?iso-8859-1?Q?O53cTm6q77Dia1o5rRCx9y4eD8rcsE3lr9vv3IDDzv/JQ7rN6VQ6Lx4a6D?=
 =?iso-8859-1?Q?i990ywEWHzJwu8/bfGBnmHaVl7+K9eL2aZMgG/2djkY+IvNuUn9wm4Oqte?=
 =?iso-8859-1?Q?//sBcL0iDgl5Cp5eLmko5r2W9tQemJomuMD2Nynh0LLhFuwwjRKi/MCp3d?=
 =?iso-8859-1?Q?DKOlkk9kzTOfV5s3CyYicrMr+K76DXlzA6DmMkM+HRAuthURuoccGUw2q8?=
 =?iso-8859-1?Q?1bKj0baxk3hNqi89VLvThkEKBTbNgxpL7rgLJjdy9UYLwSAZ3/JyFe9yrK?=
 =?iso-8859-1?Q?QwqvtuitN3Z0ooVqoZrBhBu7jwyznPFwDQDLbRjmNgow9cGBU84MNEIeMO?=
 =?iso-8859-1?Q?lDvmXUctkRHWk2yMTEiN2DbnonpSFrXfKkRnRqFnur4EtMs9gslx38pz+d?=
 =?iso-8859-1?Q?eX0UmRbwOH9/5wO2Wol1UTIXgvPsKDvJY6UNcVuUUtbQmP3/V6UcAHo0Y5?=
 =?iso-8859-1?Q?HfkqaV6M3LjOWyVgDfVeMi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WaUaBSDpSjB4pchA9MYLV2sVVE2r1eIAFbStgYUTLP+sJ5DbT8UXn1P8En?=
 =?iso-8859-1?Q?qmh6UxbtRAEchIdcGuAHf7pl/hY1/gtL6V5q/IJv+8Ifzyn3bfk3sdouit?=
 =?iso-8859-1?Q?wJD/14iBIJEC/cnVlDy1CdtMlNT5Y4lPs09/GWzvub40K3dQyt1wdE3l8S?=
 =?iso-8859-1?Q?i/3iwt7P0TqB8WtDVGUFBfyce+gIYjUTQUUJjjk4udqPngH3BEZXK0cUfC?=
 =?iso-8859-1?Q?R+c8PK99A0015xKToc3k+MrBMf/f04mQg7AIQA58S1ueq7VJCUxU44ff6S?=
 =?iso-8859-1?Q?3V++cmRiuKmgIhZumQ7tHL4pPATPikPBoGSnv15DQ/43wUp7RonJiSTaOP?=
 =?iso-8859-1?Q?deROZvcwOgE2xS9z27LJUbcnXmbqDcTny28NOIhnTIXzG9N+43O31oz28H?=
 =?iso-8859-1?Q?QShHRjVWPe8IOtsc+gtubgS5iw79YX+KXlECSENODPcRiwwSimAeTtS3h/?=
 =?iso-8859-1?Q?wUTxA7JIP2FekQbTHl7JZaCIfknh0aWSWvXwZFsKe3f4rZYUQ9JGjHYU6k?=
 =?iso-8859-1?Q?U/LjEseXxSQ94BjGU0fxl98H/mGLlaR13ZtD73dpS/dOR0RcmvjMHd9g4k?=
 =?iso-8859-1?Q?XbkmAJfE1F72A89L1RhT8npEYBKPmEWqqcuM3jzFtR98njZOl5JL3/Rk3U?=
 =?iso-8859-1?Q?466k1c/p54ztuw3+f7Ymzd1wcpbHKY/NQYJxtk9RDhKgDmtO+Lo2vNdCHn?=
 =?iso-8859-1?Q?9/bRHd69K+ttQGpRmSG6bn5ze1VlkunoG+cmec3ggf/HUojXIzjKGDpnkV?=
 =?iso-8859-1?Q?IjG8ugMpUoxd9NJceil41g5RF6HYFUBvtIUP6oufLV9BhqV2mE9eeVS4jy?=
 =?iso-8859-1?Q?RNlxyfFJiJqhOFHKSlGqb+/rGkERIjcg0g2YZggZ79b9caDELQVDFTXM8v?=
 =?iso-8859-1?Q?psv4fn9SwbsoKfutG4/7PHYOMVZ3k6s+ERcsJw8BKMVMnMvy9whI4rag9L?=
 =?iso-8859-1?Q?R8ylf9trTOSLjrEh4jlbKQUf6FMQZE8ndbkpZxC5hUhU40OF9mjCBywZHA?=
 =?iso-8859-1?Q?2y5VqtMvs5HIlu4wdoFZwD9FzONGDstZffznqVk1i2T9qSsmBVfmnoXOxj?=
 =?iso-8859-1?Q?WSjnfRmzOBx8LsEIyryAAHBA7IamqxRNmymAE5HM0cCCqsgihIChmPWWQW?=
 =?iso-8859-1?Q?apfULI6t6WJDZKLoXL2JrsuQlv91JvSGlsX043gDukl+AsnTFWphtSaHtV?=
 =?iso-8859-1?Q?P3sPHcAXsJSWO3lWY/CK9Wj30XoyZwhSkikAUKyvwzkhwmHVH95du06rJv?=
 =?iso-8859-1?Q?ov1ROpe9cc3EyEAy1mWuNp8Nd2zpaKPP0/KNJT569ewKfQJcjMoxtfO+hi?=
 =?iso-8859-1?Q?spZRao4AtZ321V1mrTFnSKZksDFb9f8vR0M34uQ6vUuroCs+FTsB4BtsvF?=
 =?iso-8859-1?Q?OjucZkZU3KWbdNLCFoKRRrm4YHjRvW5WkGcD4ovl4o/xiyxq+5Z7kVXJW9?=
 =?iso-8859-1?Q?nv7bLdt4/rKIVybp3WuwmU3lSLj8U7XO1FZmBuktbyNSFSyNAEaC20i+2F?=
 =?iso-8859-1?Q?4m2KBg7YJu+eM4azQi2lajJTYwPH5hZJe/zujJe1OdV6ior3n1PD8/r2zK?=
 =?iso-8859-1?Q?/mp4CMODVvq1ayypVY5GBEbaJ2UZ2iEnfCXRm+jtFl2QhFkuBUFIImDmu4?=
 =?iso-8859-1?Q?/C754UH8cwezygHk3EeKQuYx6QS8ZUu6uzSPro2xmWsRji2UiLG08knzav?=
 =?iso-8859-1?Q?6qCokP5ZodiLA4RmP6c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793d97d7-4f0d-4787-1d12-08dd3979b8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:51.1525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERO4NnITtWXkli3U4IvTwdqg2A8nYHu1J+mP2SMI7snsRWpJH6xdRaRuuaPIj2CQ+HhK/wtvn3P7CiXQW5E0bc8KpNhC4nS/zbGL0yr0SNHRg+m3vPZP0mO6eqeO9tmC
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

We add a convenient way to initialize an device-iotlb notifier.
This is meant to be used by ATS-capable devices.

pci_device_iommu_memory_region_pasid is introduces in this commit and
will be used in several other SVM-related functions exposed in
the PCI API.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 15 +++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 164bb22e05..be29c0375f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2825,6 +2825,46 @@ AddressSpace *pci_device_iommu_address_space(PCIDevi=
ce *dev)
     return &address_space_memory;
 }
=20
+static IOMMUMemoryRegion *pci_device_iommu_memory_region_pasid(PCIDevice *=
dev,
+                                                               uint32_t pa=
sid)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    /*
+     * This function is for internal use in the module,
+     * we can call it with PCI_NO_PASID
+     */
+    if (!dev->is_master ||
+            ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev))) {
+        return NULL;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->get_memory_region_pasid) {
+        return iommu_bus->iommu_ops->get_memory_region_pasid(bus,
+                                 iommu_bus->iommu_opaque, devfn, pasid);
+    }
+    return NULL;
+}
+
+bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                   IOMMUNotifier *n, IOMMUNotify fn,
+                                   void *opaque)
+{
+    IOMMUMemoryRegion *iommu_mr =3D pci_device_iommu_memory_region_pasid(d=
ev,
+                                                                        pa=
sid);
+    if (!iommu_mr) {
+        return false;
+    }
+    iommu_notifier_init(n, fn, IOMMU_NOTIFIER_DEVIOTLB_EVENTS, 0, HWADDR_M=
AX,
+                        memory_region_iommu_attrs_to_index(iommu_mr,
+                                                       MEMTXATTRS_UNSPECIF=
IED));
+    n->opaque =3D opaque;
+    return true;
+}
+
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 644551550b..a11366e08d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -446,6 +446,21 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostI=
OMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
=20
+/**
+ * pci_iommu_init_iotlb_notifier: initialize an IOMMU notifier
+ *
+ * This function is used by devices before registering an IOTLB notifier
+ *
+ * @dev: the device
+ * @pasid: the pasid of the address space to watch
+ * @n: the notifier to initialize
+ * @fn: the callback to be installed
+ * @opaque: user pointer that can be used to store a state
+ */
+bool pci_iommu_init_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                   IOMMUNotifier *n, IOMMUNotify fn,
+                                   void *opaque);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.47.1

