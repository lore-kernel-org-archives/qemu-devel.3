Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C06C7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuL-0006EG-Ub; Sat, 28 Jun 2025 14:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuK-0006DB-0E
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:08 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuH-0004AO-Bi
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133845; x=1782669845;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=fKZzKQhYDzfhzhI0SKnPMNOWnhWi7Tk1+XdGhhoMCwc=;
 b=pAhyGm+tqxqt1ufQTregS7xbTm7+JZFXumVm5bgd234zxqDgx3WB9DKG
 6cPm3k7YeRerpTMKZUPez/3roRkDgBDjEpUlHpBNpwtyavSUTtTeLXaU1
 p1CuGR7E89rjEJj9fxq8orDSfiO9MyS+/qo9CRe1/IDEqhVktzxt+dLux
 Jo2jHXGrZjPb0/sQdjo2PGEe9jqJHjFucb1kY3rPd29PEslyNOsQv6WDj
 0LqNgYPBbkTL9EbMDyuQROGK2MNiAOh1YwioZd6f5QtawPHW0z1antIwF
 MJf0ewgfm0kDxxiLro5GZROOXzfgk+T2QjH9dZ97KrHAbQJicvSeA0LBp A==;
X-CSE-ConnectionGUID: bwrTi9UWRCileyPMButcjg==
X-CSE-MsgGUID: bWYstknDTcqIWTYhqTuEkQ==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="41619950"
X-MGA-submission: =?us-ascii?q?MDE8JRVEXBXaSw+UNo6ei42Ln4L3BWf4lK97Go?=
 =?us-ascii?q?dPSLNwhUbtb6G/rBpazXAge+gZMGn68gZzUhJw4AJ4Qo9gAjGgm0+QhF?=
 =?us-ascii?q?x9VWTYIKe9icAnMDsDK0Os5XKk+/vlQzlkTXBGncOltOZF81oEmpMEZi?=
 =?us-ascii?q?uxb5xaLELNziQqIkwKq1bMEg=3D=3D?=
Received: from mail-francesouthazon11011056.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.56])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:03:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaKoxoI/3VcpEfK6JFsSkLm5k35ow2zSEPcjceVvy/MNY69tlqYA3S4ef3Hw6K1HglQjB4QMGrcky3GjDUEqE9vnaYRW0w9rQ2liQEVAJuWtVu1dberebqFc5SsdyhQBJUXaClaatTxDTGmuHUWjvQOU4dBgYZ3VjQ6Frocwl8jNIGvJMCR7arJq6yDBbTsnqPs7FkWv//57j4550euR+anokk0CLc/HdEKsjzfY9TM6CUZozooqA9UlNkgPngMttKVR3gg1xa542bkC9MV6pqK5RbUz0hvgE99U26BtuFW1TK0FRm9LFHeDM13LrHGp21kxjA2qKwlukAwMGJ0yVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXtHNE5We0G3FHsD3bQIm38J5CzoxJTNlFDMLcASncg=;
 b=P/zp6IPwBJf+7vE2Ziur5PN/R0kXN6/YgKw+5dpl6MaSzQCX95S4OXLTh6b7ya6bcib1m4iT+j635gcMUQNzZ0TlHEPAy/wK+zrTEaYCg/HDHfi8n4ueyVm55LiVugXKhjocVF7JUmxFJ8bI9nKQ5xCXDP0a3ar7f9EK/McdBFIyiT9OsTqZVKnuqk4xtcdmYVAQe6CXBLIHEG4Gu7dULpEPMnqK66wZHGxIJxqWC2rbjci1rP/tW7isTWyTgubRcF7RVR9TFFzn5C1Jd/r7/V3qU9POup1DdZekBZUAVLRuWvw391Lq91y8VrsxrCNJ6+kDNnpSQsFgn2HmiM8l6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXtHNE5We0G3FHsD3bQIm38J5CzoxJTNlFDMLcASncg=;
 b=kK+nH0F4z+H/zZzK9tZn/UvvSyxJSfMWD5Wrl7TVDXYU3ex1Xh6PVMSR1HzmXkxznRJvwglEIIgQFMN5Q8U1i+mW8+9aWBs+8KoMYjNa7GPsRWGmR07mWXDWhuSOXGJCxagLqK+ZJFwwKOiXUdc57aYtkFqAMbq/Yc47mEC+ZA4A6cBCsL1MkqGjHzuS19iUQmC0rDt06V8f+aTxlSYpMJ7kHVg9GBhbc1gKN9ifXjqqqlocrACffmbeVplEwwo6+hBiON2O+hZL0qLhrIzVLln55zMeGd+mcslzKqQKnfU5CbhDkenDhsRKsMPnh2LUhKiLZiDfOtCwUQfv6nZyHw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:03:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:03:57 +0000
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
Subject: [PATCH v5 00/10] intel_iommu: Add ATS support
Thread-Topic: [PATCH v5 00/10] intel_iommu: Add ATS support
Thread-Index: AQHb6FcEipxgYBr1yESrpIWJwxiZSQ==
Date: Sat, 28 Jun 2025 18:03:57 +0000
Message-ID: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: bd976b20-53f5-4663-0dc6-08ddb66e26eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4pNm+WGmVMw+/GAblcecoo09ZKIzOxYwEO1/F9lNEgYxXgcFGpfduhusZO?=
 =?iso-8859-1?Q?Su2a81KJAGf3C9BExYU61OOCh2z5fiESfvAJw23DuHcJ02GIDxZRvxd1yO?=
 =?iso-8859-1?Q?UH/3oF9A9cZed/GK+uKmZtaMUxlT01B6eU37QpeWfJD8SPkoni3uU+VHUh?=
 =?iso-8859-1?Q?dTeau40XRXqnfrvemCfna195ZY1pObpSPwWJhVpABg94FL7Yt1YDI9+i9L?=
 =?iso-8859-1?Q?KNPTV8l8gU9Q0qTwutOqNKz4zB+RyPiq1pWP8dnsCVhRXjkiEbccJuFT7p?=
 =?iso-8859-1?Q?UEues019wLyu8W1OECKcMmXbWXk7o0Mjsw07FxuXs5Q264p1ACMfyl3yW+?=
 =?iso-8859-1?Q?3dy6gsQnHomOnYbyBnUVEc8FH7CTY/5HgdpRnCQfWQYdwQ5q/onbdoQdQM?=
 =?iso-8859-1?Q?oC9eIZvqhDgFTWz3zT0hnppJ4gxrqB/J+Y4bsr17Dzgb+HI5TRMBlo5COc?=
 =?iso-8859-1?Q?hKIjzyIh6LH3fqFaI7K/5bQ5ZM+/WC7ICofKkCep6q0+NWeRJ/mopSDz1u?=
 =?iso-8859-1?Q?U4W2lj3QaSHjbb+MgBDUmHxftKgjniv711JGGf9xL1lVoagBnXG9ztXnK0?=
 =?iso-8859-1?Q?4KxO1UCmjV3BX5papcWznAkv2Qs5ICDfSmQWccy0mdPsVT266BHYzV42lB?=
 =?iso-8859-1?Q?sn7ZEa9T5ZRy3Jh75oKb+ru7AKKS4ajorbzOU927CPogupIeZOneefZXvx?=
 =?iso-8859-1?Q?PQSWiOomqLkCTJHqHE2HGVk99bWrf0u5ky0Aqlq3NuQ4kjpYIXqNEStMv2?=
 =?iso-8859-1?Q?okPJaTb8SoXT1YXja4DZEbM5K8Csus+n6Nk+eJTzavL2+7NCD1csMJhKUM?=
 =?iso-8859-1?Q?enSMnNSvdjRvFq1aD7vJ0qRU+bWF1IUKGpUa39ncnrmR4jtCLp9wxuk1Jn?=
 =?iso-8859-1?Q?paIfVUiqk5nyhNSyrDwzRHOtX/ExPHtxxfoJtj4Ng1cvk0rZovm+N547IF?=
 =?iso-8859-1?Q?38bKR2ilPf7riEhZZ/tGWYRgOQOwVkOlRLjnZcgIx/WQxdKmF+hDEvFC++?=
 =?iso-8859-1?Q?ZLpj5FkADEyNPfPArOJysE3zj9WtkXdX1NvT05zqUfYcvt3V4bETO8YJs3?=
 =?iso-8859-1?Q?NAMszUpEDRLJx35fW3taBPujbtdPmG1tlenzENXKmeZ5IPd2O2ckpF6P9b?=
 =?iso-8859-1?Q?NQlVoAnR3XX5yuuRcjAgiT4LYAuiqAypnTYRPmHSxPlPHhW3ux3d0h7qBs?=
 =?iso-8859-1?Q?Pyf/IBWyQ7pnTW0VZdH/DQqPJM4Ef/f38oe6UVnND7SBFLwNB1lfJmgolL?=
 =?iso-8859-1?Q?n3xZYgDxCzFT4iVZzLbt+Pl/uCMcRpbOf4xT7D+paiLTWAgNFdTOGAbVmZ?=
 =?iso-8859-1?Q?+3FlvIVxqRBUf8fEJiqj8ed+Ct/kFCn0H9w7FPracqT5bU3gWQXlf5NiQ4?=
 =?iso-8859-1?Q?q9iDKOLLvpoBvKdBnBGec7ul9qtyhnKhqbe2ooEp8QgdZPJV8NWL2Z99Yw?=
 =?iso-8859-1?Q?p/APZblj0cfWeA9BHYwRJ0huu0Jwd+IfAloeFPq2gd9d7uW18BncjZkpbl?=
 =?iso-8859-1?Q?/vqaZUtjc/uELd2kdEgSRmwLe/BH4C/nJiv3k99dcsweBFAvNRO3OSxdJ/?=
 =?iso-8859-1?Q?7FPiYFQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GE81fS6Vb3dGtTmcK1EIlKfeEcPPsYre/aFPGwSmUUAUt084gC10VqRVm4?=
 =?iso-8859-1?Q?M0+ijLyKSROMTmTC8JvIiYDUCTR/qoOmZWx7K2YhRKi3RWAtW41Aw4PCjx?=
 =?iso-8859-1?Q?bgdgbUcImjHbLSPBAybLEEzOia4RhdrnTPwK472U2W40G9MY+LxnMoWgHT?=
 =?iso-8859-1?Q?CB4Hc5n/vFXIzGsBtq/iW4BEGdMDc1D4krqtHS2alD6l7jw3qmdPaulFvk?=
 =?iso-8859-1?Q?1gGF32j7cyJz5mMipVC7pmCDdy3d3BiBvgP2KqDyLlM3Jyqr2rb3r5AwV9?=
 =?iso-8859-1?Q?zS25NaC/ZlmM3Nnbybo089OfjjVzlnWWcqk7TB+TBuem37MTj2KFKFEQgf?=
 =?iso-8859-1?Q?gGUijiqrP/kjQS5OReK0lZceQqgCrqttiZR86Tstp/obKk2EP6bCJgdnA9?=
 =?iso-8859-1?Q?eDc8m+n/TPZ2E3Os5G/bNzQI7iNk8wmXrgDgHVRiH9/PWd8qDTMkfL+/q5?=
 =?iso-8859-1?Q?B4+r92dDu/Rjt6km3+ul41NSSqSwPxYJZ5tawYS+EPSopl1s9WVy8fGVT/?=
 =?iso-8859-1?Q?sBQeUPoSLYnqvTmeFAY0N771oojoYu0q/7vBZAfnsiemXGpc3kgzFNb4VS?=
 =?iso-8859-1?Q?G79Hrl9hjhphKcgDoGdCXL6YfP3IfvXzvqeM0BFJtBbKSbwIATZIfO9aH7?=
 =?iso-8859-1?Q?lCFhnNmp6/cmqJ50bK1fdxU61GT0MQWLItCj3SJA6ceCjUqb0kSJCKjmTI?=
 =?iso-8859-1?Q?UwNt5l1hlZzEFwXCJcGRNGds2uqaTm6FhHyyuHfzTU6Ga6U85RnoOBfJum?=
 =?iso-8859-1?Q?yT1u3XHd5CnJhZQ626kU3XxrbqjEf5fiRs2FAbr4m3PTLGBq+fwAvrI4aD?=
 =?iso-8859-1?Q?UkOlEhVucdo/59avefj5XzsDF38Xlw5e1m8BdPdbKYCG/A7dAxvnSP4oiA?=
 =?iso-8859-1?Q?NqZio0Vlhf/PtqhguuqHbEsZN/eHT80LOvjDSq/dZXXljtYz8Z27Q948vs?=
 =?iso-8859-1?Q?4trTa1lRz+TEoDWQyT9xpz9MdHnBDrQ4loqFSswqs3SMxZBxGlhDyZINDX?=
 =?iso-8859-1?Q?LFNlbyME9hW+vODudhiCWAb/2rfsN+tM/rYpUlfwz3TH6A7pv9l4nY1tT/?=
 =?iso-8859-1?Q?WbW2KImM/+4DGGSSQAs0x+XsyYhOsm6BKmWc4MppDZEfRr20yFDHLfHOaj?=
 =?iso-8859-1?Q?ETcyRQnHMTb359Vx1JcC2Siq8I9kQTlb0DpnnPMKuJMGFrTC4Affbanocw?=
 =?iso-8859-1?Q?1SRfzIn9o1zF/XLxQ6Z1eUStuMYuzPDS4r+nWprITI7dfdnhPeZs8G6rz0?=
 =?iso-8859-1?Q?dIeVb8bvteLzZNRCvyMVMyVT2PbNOzJN2vOsfnHXF3OtjxMSdOdDEMmLJW?=
 =?iso-8859-1?Q?cw0uTd4RJ6JATCDXWjv4aBqc/7pUQ/GKiOMCa2YixCGVBHx6nViPSH6lDE?=
 =?iso-8859-1?Q?6J6vZWb6na5aycMXyGV/VXsgJdyAmPvqOUmX1qU+Dkp1q7z4jUOEG54+yM?=
 =?iso-8859-1?Q?e1EqS/2ACv9WgW4ORwSOybMHBUSipDJHK95pAuPyBeXgKUdNekfDErYPQ6?=
 =?iso-8859-1?Q?rY4Z291SSeYjV58Af1o4ZVhOIBN1HNuJHcJfaBdzdIOXqbfnGZ0KRRcaUv?=
 =?iso-8859-1?Q?gFa+A7JCjWgqV9zgSD5Gdc8qEaROAf7KOF/xP0v4Ttl9NpUSN80F9b6b4Q?=
 =?iso-8859-1?Q?qI7GEEhLmMHjFOkQTUiAblzJA7RUjx66bbTN0Am5jWbWAbSvOacMjYhmLm?=
 =?iso-8859-1?Q?lKT4K92T7XZrDvmD+18=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd976b20-53f5-4663-0dc6-08ddb66e26eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:03:57.1635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyT/3+0m5Kx7orx4LZxzKXF0RJZaNDvz4WDKLQ2Qo2iLTFTmlJxUGHvTPh9BQNob1DYbhkezUUT7Fgvf6ip5D2t7gO7dHJvR9uKfztOE8Ltc1p/HKDbyMZN+crJ+22nl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
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

This patch set belongs to a list of series that add SVM support for VT-d.
Here we focus on implementing the ATS API exposed through the PCIIOMMUOps
callbacks.

This work is based on the VT-d specification version 4.1 (March 2023).

Here is a link to our GitHub repository where you can find:
    - Qemu with all the patches for SVM
        - ATS
        - PRI
        - Device IOTLB invalidations
        - Requests with already pre-translated addresses
    - A demo device
    - A simple driver for the demo device
    - A userspace program (for testing and demonstration purposes)

https://github.com/BullSequana/Qemu-in-guest-SVM-demo

What is ATS?
''''''''''''

ATS (Address Translation Service) is a PCIe-level protocol that
enables PCIe devices to query an IOMMU for virtual to physical
address translations in a specific address space (potentially identified by
a PASID). When a device receives a translation response from an IOMMU, it
may decide to store it in an internal cache, often known as "ATC"
(Address Translation Cache) or "Device IOTLB". When triggering a memory
operation using a physical address obtained via ATS, the device must set
the AT field of the PCIe message to "translated" to prevent the IOMMU
from translating the address again. To keep page tables and caches
consistent, the host system can ask the IOMMU to send invalidation requests
to the devices.

Changelog:

v5
    - Migrate to the PCIIOMMUOps API

v4
    - Fix compilation issue on 32bit hosts

v3
    - Fix compilation issue in non-debug mode (Michael)

v2
    - Rebase on master after merge of Zhenzhong's FLTS series
    - Rename the series as it is now based on master.
   =20
    - Changes after review by Michael:
    	- Split long lines in memory.h
    	- Change patch encoding (no UTF-8)
   =20
    - Changes after review by Zhenzhong:
    	- Rework "Fill the PASID field when creating an IOMMUTLBEntry"

Clement Mathieu--Drif (10):
  pci: Add a memory attribute for pre-translated DMA operations
  memory: Add permissions in IOMMUAccessFlags
  memory: Allow to store the PASID in IOMMUTLBEntry
  intel_iommu: Fill the PASID field when creating an IOMMUTLBEntry
  intel_iommu: Declare supported PASID size
  intel_iommu: Implement vtd_get_iotlb_info from PCIIOMMUOps
  intel_iommu: Implement the PCIIOMMUOps callbacks related to
    invalidations of device-IOTLB
  intel_iommu: Return page walk level even when the translation fails
  intel_iommu: Set address mask when a translation fails and adjust W
    permission
  intel_iommu: Add support for ATS

 hw/i386/intel_iommu.c          | 142 ++++++++++++++++++++++++++++++---
 hw/i386/intel_iommu_internal.h |   1 +
 include/exec/memattrs.h        |   3 +
 include/hw/pci/pci.h           |   9 +++
 include/system/memory.h        |  24 +++++-
 5 files changed, 164 insertions(+), 15 deletions(-)

--=20
2.49.0

