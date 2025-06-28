Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023FFC7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuT-0006HO-8D; Sat, 28 Jun 2025 14:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuP-0006GK-UW
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:14 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuO-0004BQ-1c
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133852; x=1782669852;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n7wXTuqsATBgCZgUhPyOwzkoAKBi7khsg298jtLHsEU=;
 b=P4QbRdVpgc4b7sEKmKRiar32rcwVlHjhbvjPhbqxq7tsS5O3J9ddXOpg
 r6rNhIX2q2t1WdM5OQpAeRW9DeUQC2oCpbKTJWojkYDYcSUanNHC/jXK0
 dse+e2Ror7YH6xYmWW5IFhIQJ5WO9eC3DHNbeFcHvZqsZJXIDBGWq10/c
 kZv/5fw+i3paWkrHKt3/GBGP34f4ndbogUNbuwE7a1G0GagQl5KvNtAUQ
 pDm2xDURyxkwKLFLS9zOVJNUH/fEyxsuMfJ1Vjive9e3Cve88Q5ROEgBz
 mi0CyL9Sm8sNG2FF7yQQ5fchF2hv4mT+17Rud3z++nIlFJRmE8vQcAvGE Q==;
X-CSE-ConnectionGUID: 6fIHXd0oTM2lIA/viKMENw==
X-CSE-MsgGUID: puWN1+jWSjuhQje7hJ1TSw==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39516355"
X-MGA-submission: =?us-ascii?q?MDGGDZ8qd/8IDss0/836DgCT4W1M1Rw1Rln2Nv?=
 =?us-ascii?q?vqBN0jAcNt0Hp4Pl4fk3vhxzKZsh975CFXyHYeh6FDx2Vfy8SIPaIMLN?=
 =?us-ascii?q?aYTIo5bllx8lhsKhLUlN8imqsWAiHP0SDpJ8w7dlsjMOuK5kFJdXYSuE?=
 =?us-ascii?q?hNW8oUbG6njgi2oKa/PYzE4g=3D=3D?=
Received: from mail-francesouthazon11011029.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.29])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCq1kiJyUeBiyiaHeMv0PzeA+ki/8SCoH7D9REwCGK8WB4UMrgu+UhOAJrMyMiBINA8N8ruuwwVYwAktAo1YvYNPD3cAZT+zk24xlRCNpNovKZQSSTKx1oRViD2BiG0btvkCpTIUtNq6trRccKQi6/6qZFCehrl0cARHQtYHPD6vLtj/+BIOGocO4rrJppd3uWtWFh+8Yx7yCpWoWOK175LvDsAYwrYL+1fM0/0dR1jrLXVvrAOuLU5dLudyyCPhgRL56Z1gdjnMqAYhV7IG8vqCddWNd3VlGngRPYbNyTpxcr/NstwjP1IRY/z/fQupruvc40XbC7JvgNy3Qrz/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeJCMyScSrGQN7x9hhEk1yqq/G7ZQBjZt+2Atop11OA=;
 b=bLC+ZPzMS0eG4CYGHEcx4HVsl0HLuGUWuNMVUmWRgBbGoRaNOgEXPaK/J84qkClVRJ4n8i6h3d1irclQ7kAuJ5pOtAmiWR8XYbXjEWVT/cxYCoogbGppy0oiDW3AhOzCK0Nn3tWto1EAH31D31qJM9f0Tvaj6z2WCNUiee5pe/B/6ioAdcPnbqLY1OGFBvpWTdrkwcBDwyjrTeSojIj+aJmM15yhmwtxl8yskGJSlc/5VaoIn0uK1zG5YYYjiu5FrEbBN2+FAJvn4x+F2M7wOzORMsQIDUmuckgU1/vPcTFFKDjhyRhUtsl83RJUc0eGzaW27PTCccNdBtzjoDc9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeJCMyScSrGQN7x9hhEk1yqq/G7ZQBjZt+2Atop11OA=;
 b=sMLbslkbOYWgcWLx4VyK7WhoJ7zWH2wet0WpYwx1GjFPr7yssQ/j6FSz0xx6L9Yuu5Wh6tIlYpBuFFYYufffneFPDzxMgihJkuGhQvjhpQhAZ72/gsRYfptWPBtI1cGqnyFa8PNWheAP9cEbvGJB3QiyyjKT7qHFSCECHs5iaLfMypAoEqcGuk9d3FYt1eScMNX17gcY1SfDGPM0P0iYH4eFxTjPfnDOCnGc9sI4NU7azk+x0Revx75HXqEF+sJ/Eemz6clu2NK0AOFhOXt8RFGmhvt/roS5fOCD/tOBY21NSxVU5bydETE4EdYXY+QBDf/irh+Co4Fj7V5oSF5Thg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:07 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:07 +0000
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
Subject: [PATCH 07/10] intel_iommu: Implement the PCIIOMMUOps callbacks
 related to invalidations of device-IOTLB
Thread-Topic: [PATCH 07/10] intel_iommu: Implement the PCIIOMMUOps callbacks
 related to invalidations of device-IOTLB
Thread-Index: AQHb6FcKMM15w6W8OE29QLB78/vS6A==
Date: Sat, 28 Jun 2025 18:04:07 +0000
Message-ID: <20250628180226.133285-8-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 8b893c83-b1b8-4108-0fb5-08ddb66e2d00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kuChE9nZzNhrnniBaBH+kTuNCWPuyNqXgemVuXvvHyjuU3vJMQJ9Q0tlNz?=
 =?iso-8859-1?Q?HF6YeUfo0qMZhFec48Xxi0rE1OXjkCNzE/OjAzjHI0UajCyCEZ2o0Ov3jD?=
 =?iso-8859-1?Q?pRgbIm0nBwwO4RjXKm5QVr0WOT1DZPGkvCii47+5XB3eVEMKIMTMCo0n78?=
 =?iso-8859-1?Q?ehH0tDLsmxBlQ+UuqZbJisYO6q1g8ySZBdAlL5hsi4as9ixw8n+3YYukyM?=
 =?iso-8859-1?Q?6mtQPD2t2WNgiijt1iZ0tI1gtxvj8NpVTxDn6g7sNoPLAvZ15bDHWf1QPJ?=
 =?iso-8859-1?Q?I/nIkJFC2IKexlik8npILcjbT4AMtqDkVJVb4lYq5JHUDiPEPhqnQepOOr?=
 =?iso-8859-1?Q?El7gPGSWcAHkAXhe6J44DYTXXnFnPRtvazlibDdUSr4dFR+xWx0K55UCHA?=
 =?iso-8859-1?Q?V+EHGYYsH5rUlPNpbX27rG9LKdKZX72L1+qwGlfwrmDA6PFLFx/NX+M0jF?=
 =?iso-8859-1?Q?etXpj8ycbzOcqruAn6bU+NGXciaQk6pHV1UXSX3dlssrruptnXLJaWrRT0?=
 =?iso-8859-1?Q?TyZQJPum2lIWS9ufeXeiyxNPBxQ4O2C7Ej9vb+tMr2xCiDFqspT/4jy9Pz?=
 =?iso-8859-1?Q?hLfTsx5BY3mOvfETaEhQNeMVWRsQL9ZGJY19LIVh4Oedov8KQImZj+o+8F?=
 =?iso-8859-1?Q?+MsdAmj28TqXpGh83E7PbvKpTKpbu24jk5QObtXnLng0f8PrPC3664fgYW?=
 =?iso-8859-1?Q?v+dmQrGfZjsaRfQexdskWEzLKs4sgKW3sKqA/27hxMhyAfghEPDi/kguzH?=
 =?iso-8859-1?Q?KbR5r7gYE6ZqxG7+lJqFLtnOBaSW404nlQUYxig8qVqPQvvULZvcGZMWs6?=
 =?iso-8859-1?Q?QJwj/oCOsfZQJYM6HK53cY7TpNHW8XlXwf1vj+KPeDnmvYXTTgxgpUvka2?=
 =?iso-8859-1?Q?5GkYVUrvs7fqZX/Bd37Cd6Zj2e/GXh6RLRvRc+M3y89BJ6j9CDo6tXOoma?=
 =?iso-8859-1?Q?vRFOH2yVzXEnp1l88jl8D5/puzlv0hTXWrYpy1r+r8m2yuusf9wbJzb3UJ?=
 =?iso-8859-1?Q?vzYk9mcVUI5IlqQOwxChVcwhX6Yn2FeyMQOv+ElaxnOvg3f7atGHbEJkQ+?=
 =?iso-8859-1?Q?gGK8dYJTJ15TCQspshHrdmNYnbKbbOmJKWIX4FlxK/hlF7YdzNcMzrNnVW?=
 =?iso-8859-1?Q?l1JKvyy9KD0OA5D3IKDXZI1QPEo3t028sw1votBYaBrRymPimz4xA6pl/u?=
 =?iso-8859-1?Q?VofByfX71tp7CNb/PyBPQt4EFiBgdpWeqWZQEqMEkiQwww+rdMygY6WQ94?=
 =?iso-8859-1?Q?K82SoNYOZKY2apyz7FN2b9wyRTPYygWfizFm9vfKbCAI/R6wVnD/l3kPHs?=
 =?iso-8859-1?Q?G9J5MmUMs0ABsECI53KSNpFT5MapVyn3h6hNRZ+wfHOkLBThfUiRpumnEi?=
 =?iso-8859-1?Q?IFg5i/WV6ir1S4qJ6191qMbHgP3wlV0FXr5lJsT5qRv6Z6OC7d7g01hqna?=
 =?iso-8859-1?Q?qwNTN4unxodDw1FBrYLGT2sVIzrNxxwo01l6Y7yfvdS0SF4kWUEle99qCm?=
 =?iso-8859-1?Q?rhcGejjwx4oD6hD8sVGMIE4yit5X+Li9vaYNBff8oLUQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iTbIEZH9+VBEi6TIuejjEfFx1uVPT/QMx18wwFxQoDYFO4F8MO6UZcG2rG?=
 =?iso-8859-1?Q?7ZhPuEao+HuOTfh1juY+MUR71LbbKoCVV/nXFmjAy0nJp+LNKUtozMCfmA?=
 =?iso-8859-1?Q?BF+FEx1x2jYf6kVARut+b0/U07+Thwzv7WJJGt5nQ7X5j68+TOtziUqrll?=
 =?iso-8859-1?Q?YfYmMn9kCoYECdt2dWvQ7zHNSdBqOTfCLB0MLoIa4HKJbi23N+TW1BJ/pJ?=
 =?iso-8859-1?Q?o2cKBsLZNNk2CcxfF85UXYqpPZOP/+scqxcE/SKRamf5vwo5JqRk/bA5Wm?=
 =?iso-8859-1?Q?x2pLBaLsJsI9n0xC0J88Tg0YWUuW0C1S+JrVCNHZxklGcNIYnv/2bUkHGX?=
 =?iso-8859-1?Q?85haGVNt5cjBoZHmRBIWThYEyrRgHb7PEn+c1GVOdf6GFL5kqojQN5HP7r?=
 =?iso-8859-1?Q?gf+HcPgGrO+rsgEIhr97R8BebkaRFHKN5drD6hyLny8f4rJ3Qh12q4shKM?=
 =?iso-8859-1?Q?V//+nh1S/82cwkIexkXQi3iRZQJhwTbawen84HBXdRZOxCp+ejcGB93djw?=
 =?iso-8859-1?Q?ePXI0zW+7Zj1RvvuaDGb7OO7sm5xFig/5mzegz/i+F2Q3/lVKLV/7cORf6?=
 =?iso-8859-1?Q?PCmggAQJuSVSqFG4E0apfrg2xgkeytw4nl+rP+z6AUx6v+U8QG9OvVtG+w?=
 =?iso-8859-1?Q?iPj246hALnh9zPgwbcR5C3VcgyNxlmLrbw+rioRQv5xnCkmBxkztdeDg4Y?=
 =?iso-8859-1?Q?T/FhC9f15FytK0WHDk9+TpmrLWaA3qJkkc7bNK74FU9fmjGF9TPbeH2DfW?=
 =?iso-8859-1?Q?almd8XMBErKPobVsB0ZtghNhBn8o/rWIC9mee9okujVKKJzrZEG2D6Amge?=
 =?iso-8859-1?Q?99AtK/LO4AgkYLLC9Nb/20IQK8FtqLE9rVzM95dRgTuy3RixBjOGPWZsFy?=
 =?iso-8859-1?Q?qEb6wHfWJeJNAfY/xLBTVes/b4Udcsn4U862bj13SHLgcEwdgIV7kDyOur?=
 =?iso-8859-1?Q?dGZaN2vBmudMvHUTuYDE1v82BWTWhQQTzW+sQ9GaX5HObNI/i/YYEU0/oH?=
 =?iso-8859-1?Q?EJK/Q0mvFbg6BXjW5QS4W2g+POG/MRh9KWD0OVNvzuCvoWcPk6a7VkZyTE?=
 =?iso-8859-1?Q?Yu0230fxRJTYnK4CmAa+ly1400oYjB6NnxiJXs5snlAtCSMybk0yhLNArN?=
 =?iso-8859-1?Q?3xASlEStF1EJlccVzjh/jeso/2QWz04RE4H+nssOXapCE7Wx+lput8wSmn?=
 =?iso-8859-1?Q?3x1A7sh3esd2Hmmk/gP1iBvkjMKak1xcq+NtDCri0GPONio0CXN49goFRk?=
 =?iso-8859-1?Q?7G1zEKnHisFuRPUf3zgSdAIjHnRJx8r+ezrQuKYXlkFMmRkIMtc5N1z9XN?=
 =?iso-8859-1?Q?cpJC/WYU3dmIonA0OfEv0C1wuxtfR2YHqBkwsJ6jEQeaCyNEf9EE0QBHz5?=
 =?iso-8859-1?Q?MwG1FEYqOhllZKr9QnLviZ3BvaOSg3UwVK85npIvPJ+sEsUA3tjGP2IHPQ?=
 =?iso-8859-1?Q?QfYclrUiKLj7jTrzzLX/KZ1WUssLpRgB7lPr6wHU9Noow8mJbbxl10/smS?=
 =?iso-8859-1?Q?eY/t8ZWUVF/jNCG7U5rMv+CU4TK3yuyAo95H16GSvcrtTyBr1hhTxViZS+?=
 =?iso-8859-1?Q?AFwIF7T0kOxO9HsHIpVNxPlRNrxZ1WxFWEegV0muSWR87zELBV3xL41nyO?=
 =?iso-8859-1?Q?7JOzH9tUF20jbpJtiCGB5/++eaEvw8pyzA7oU5Oloqn+WHqQzLR+TaNUqy?=
 =?iso-8859-1?Q?8tSB7D3BwXlwoTYEbX4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b893c83-b1b8-4108-0fb5-08ddb66e2d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:07.3754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFKqOv/QT5bYnmNfXv7dDPv7NTYmHiT5sDnow6TbBbaLyQuRkHIA5zV7OJKfDubAcwvk+nXNU00/Nny3LaAdooV66acCB1oxHwX2vL7dsViVZTUMdHo7meqbhRXeYp+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index affa7768e6..234c452849 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4733,6 +4733,15 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus,=
 void *opaque, int devfn)
     return &vtd_as->as;
 }
=20
+static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
+                                    IOMMUNotifier *n, IOMMUNotify fn,
+                                    void *user_opaque)
+{
+    n->opaque =3D user_opaque;
+    iommu_notifier_init(n, fn, IOMMU_NOTIFIER_DEVIOTLB_EVENTS, 0,
+                        HWADDR_MAX, 0);
+}
+
 static void vtd_get_iotlb_info(void *opaque, uint8_t *addr_width,
                                uint32_t *min_page_size)
 {
@@ -4742,11 +4751,37 @@ static void vtd_get_iotlb_info(void *opaque, uint8_=
t *addr_width,
     *min_page_size =3D VTD_PAGE_SIZE;
 }
=20
+static void vtd_register_iotlb_notifier(PCIBus *bus, void *opaque,
+                                        int devfn, uint32_t pasid,
+                                        IOMMUNotifier *n)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    memory_region_register_iommu_notifier(MEMORY_REGION(&vtd_as->iommu), n=
,
+                                          &error_fatal);
+}
+
+static void vtd_unregister_iotlb_notifier(PCIBus *bus, void *opaque,
+                                          int devfn, uint32_t pasid,
+                                          IOMMUNotifier *n)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    memory_region_unregister_iommu_notifier(MEMORY_REGION(&vtd_as->iommu),=
 n);
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
     .set_iommu_device =3D vtd_dev_set_iommu_device,
     .unset_iommu_device =3D vtd_dev_unset_iommu_device,
     .get_iotlb_info =3D vtd_get_iotlb_info,
+    .init_iotlb_notifier =3D vtd_init_iotlb_notifier,
+    .register_iotlb_notifier =3D vtd_register_iotlb_notifier,
+    .unregister_iotlb_notifier =3D vtd_unregister_iotlb_notifier,
 };
=20
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
--=20
2.49.0

