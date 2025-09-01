Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDC3CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Lk-0008Hr-Gz; Mon, 01 Sep 2025 09:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XW-0004L5-1U
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:34 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XR-0004mE-Gn
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756725449; x=1788261449;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KIqTd4BDpZqW8AlX7vg8Fa+ZC/VyfVzFwSI9GunGrJE=;
 b=bSFwhYGGMRdywNZMDYpFDnt3Va8v2sx/Bup++KvGO//VIfAXuw6gYEv7
 h2ZxXWUTxdCnxhEJGQjJ4rnPtTWTEoVayxpMK4RcrytG2IZu5L+pY54Vp
 0U/zWA3c980swBF9FWhnoRgqjVPl98iuNa0J2I8xawAWYo8Z0CmkkgV+3
 ku/kaj7Q/YFe9Ht/pgkRGV83SjDK/LUgsQyBDcIlpEc5RcSfBihMOLXAC
 lrigSO92tZNhWTEQk+Er/vjEsQfht0uLweHRvfdFtPu2x4SMqnBOK3F79
 XPufQAM8bfAEafbSUdabYDPlisPMR1Xnt/pqwm2fDBXfSyoU2zhFFysiz Q==;
X-CSE-ConnectionGUID: ktwyUhSYT9aLuCFXQWMAew==
X-CSE-MsgGUID: xIQtLObmRcKbrAy9JZRSzg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="42540660"
X-MGA-submission: =?us-ascii?q?MDEE8Ys2vutt2Ap6kTe6B/REr57lxUM6jtLDgh?=
 =?us-ascii?q?5zhaXMUHEl4bpXJb5pZLAUGbUh7htr2RpLdpOZ+ZdUN2dMNPxLOeDRZ4?=
 =?us-ascii?q?K9rnDYla+ZZXxtEHtizS51byal4dvtt05PSECJwUt/bvwUYHefiFs4ft?=
 =?us-ascii?q?cM0z3pKOMtq1lymv2IsObR8Q=3D=3D?=
Received: from mail-francesouthazon11011018.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.18])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 13:17:24 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCLNUPk9PpmQsdSxbuHd4Cx8XyuTBqnTz6wykhtc69XkwWZIy+cbzaa50QSMzt24+SpdvYroMKOn5booUgCMQbXo/yG04ChbYJjbQRH6XJNFvVbj+xQI2zC0/GU9wwarNIIHI8TIyzyzlE0PpDk2HnUuD3R89D/3kyh041h9CTSD0Au8CneS38z57aHE0P4zE2rFQ+2/wWYn/ZYOyXNp5G2tuS726E1B5DWG5sUWjAzoZpe+3Kbne/HxBd+WcL1+bZxsnzsSVmuA38OEawqzasPr+KQYtdpkO0VR41jjjOsihZp9/P+BCFt8yh4vebtFAZ7yY53RIL4sv/8x6a0GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cMYJLTo5gIs/S05jUer3QTyCIUWoAS916WU6yM6crs=;
 b=kAKykhzIMRg6sHtD5wc9FG4Sf0a3PXLTBkAf0HeW+4rMZ/9L70XQR39bZB0mb2BGeHVLK6NIQD6sXBG2Zpr5qzjbyzMlmGmEX7/kJVvzGbNxFfKFYp8HAeyuHIIK//+YBQ/lauDU1phS1V97Pw4gSOIIBjXr5Rz+XgVeZk4W35HXUlzbtbk8L3aKRpIITXho7DHsAHXFSJ2IeTF3kujJGdSOX1OyoNY4EHYcfuDSkXHziK3RN71BD1KNQ4PddK/h5+2+iktf/sRsOUUdtG2+YHbB/eq7r6zpn9TUOkLl4FxLc2nHj/ukXZ6oGmlI1rbYw6DBNHc01YAJFfRpn7LYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cMYJLTo5gIs/S05jUer3QTyCIUWoAS916WU6yM6crs=;
 b=oRYc1EwSp3LDfoSfqmSKpzWqeou542Sh5zfSMla+MWupCaNYrbP+61LG9TBgE25miCC3Jdzsr/f8ByHmva1k0UrXl8b510OsQGyEj3ocjHZKdoz2FkwtSyxQSgbrWoFsIoblNy2iy9s4O6qkvtL4I5pMxGjF3mx0JpHh9TlDxkNnC5VQLpi4DbmGsN0D3y4mZ0h5Cm6ZsqLXMTiPZAtg7IJJROl4OmVN5xU6tT922JBSFnXoPEHoW6lBo4t26ZvaBQCN+jsF5Bu/aen7ySig48ALeu598Du54Bck+Ghtwr+1LmNF9lkAaT9eG1nLfb9WlCplKZ1QjZbcj2ypv4/DAg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAVPR07MB9215.eurprd07.prod.outlook.com (2603:10a6:102:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 1 Sep
 2025 11:17:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:17:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 2/5] intel_iommu: Bypass barrier wait descriptor
Thread-Topic: [PATCH 2/5] intel_iommu: Bypass barrier wait descriptor
Thread-Index: AQHcGzH7xjwx4oIeBEOKM02MAqBKSA==
Date: Mon, 1 Sep 2025 11:17:20 +0000
Message-ID: <20250901111630.1018573-3-clement.mathieu--drif@eviden.com>
References: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAVPR07MB9215:EE_
x-ms-office365-filtering-correlation-id: a6cc71d5-80c4-4cc2-e9d7-08dde9491ed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7A8E3j6oU17rgBRsxl5qo8dKdrdS+7x0o+pWUvB6f38c4J21Oy4/bV89TI?=
 =?iso-8859-1?Q?QJyQd65B+jUN/USIcnPTgZkKVudEyteL9AQ6PSigYLEs5rgykwJtAwbslq?=
 =?iso-8859-1?Q?windwrPMBzAjgEsGlo3O/BWPG0R11L0ZnkDZkLraK1R4aVd9FTtyePXOy4?=
 =?iso-8859-1?Q?dfbCVPDzqz0silOg5NvxPu9fc9M9jrBsmZWe+/zAYILFH7Si7kTIQfst1C?=
 =?iso-8859-1?Q?hXXmM0L1xb+WJMc2yot6RFlZwkqUmkpuz9OyOcEU8l8HU/V2sz954GnCy1?=
 =?iso-8859-1?Q?ggDLYbbQizubYQjIS/d4+s5v8aHYmXlMbLM6n8+uGwxzhUfJkH8MhOOPIW?=
 =?iso-8859-1?Q?v1ko8lLrUufOwI5pkYrFb7s2KhXOUIeG4hS022aDm/G/GqtE9pR4WXQy3k?=
 =?iso-8859-1?Q?oyqr3VH5jCvMY8u8SiM3CFB1bM6rGgTnKK0UhJ3Yob62ppIp2Wg6+LnpJ3?=
 =?iso-8859-1?Q?N+Lc3y+prwLVck+W5z7Ql03N4UK1IzdS11+acVRT4vgga0NNz0wGgnSSX4?=
 =?iso-8859-1?Q?xJ72N9eXJsNT721WkNIskMPRCHpH/0aiDMM+iCsSa1IhZyzYjXdgvne6KQ?=
 =?iso-8859-1?Q?AfO7TiFw2V9/7QX3t/JwLb8jgyVEWUTYvGSHsHfqYklfwjsWZbGcIzOupm?=
 =?iso-8859-1?Q?Ah8AXKOp5N+gI0ixv5dkyvj0P/PGjM3MiURm3Gz6LdsaL8jarfx0kJIRaG?=
 =?iso-8859-1?Q?yccxvEqmPoUh7bzppXuh9tqzzUkC5zni40KohFlZgIJode+srH5SGwMTjh?=
 =?iso-8859-1?Q?47JMlVrteFygMixdRdqMt9Pjuo/18KHheozgdkM0juJ9YBmEtnYpP1PKkN?=
 =?iso-8859-1?Q?4jglhjBy6XUofpPevcV6BPzyfpiNoKLCd1oDyeoMHP/iMnhBK0y+q+eSJy?=
 =?iso-8859-1?Q?Tes8uLzUyCum8vyl3eAAazwGu7dCiqnttpZn7vpwMdI1xklKzyfnDI3jCF?=
 =?iso-8859-1?Q?cs23WEz9cvcqQYaTsVvhV+5HMnY0zR0lZ/NnPdp690ohgOmZzfy9l3kg54?=
 =?iso-8859-1?Q?fuSIcS1QciUfOruiMcYz42H+rT0tQ92E8VC+BkaVC9URISLMp2WjseFA76?=
 =?iso-8859-1?Q?5mPgKQgg5I+rdIp4py+VkibdDB3gSkZSnPmypCl7qtCCXFLSuMiH5FSMqY?=
 =?iso-8859-1?Q?IeQMxbXYG7H/Ddkx360sWSCvXFRJNGd98mEGvMGlO8UNEDuEKe2AAPTG41?=
 =?iso-8859-1?Q?+zhIFNgpbPwBEWT1ov+3qS5iWXH/c4RZH0LGI8Q3LKsbYK0pxtugF0nGrg?=
 =?iso-8859-1?Q?jswT9KGJKsXw6jLerWpDdZ4hQTfoh7f+Foy6HYfwa6frrY1CKjkmtMXss8?=
 =?iso-8859-1?Q?MwdrdoVHAXBQ7/6vgOtEiWTLysmO8/3pWalUDlvJd7uxwOvuLZW47KkT8e?=
 =?iso-8859-1?Q?O3Vsgn32C6nsutVgMgR56gvWfJ7ciBweIQPbqx9HHD2b7SQLsf+u/DdkwL?=
 =?iso-8859-1?Q?2S1gv/+hKbdkI//2nrWAkoc/HnSKNG+1UDiJeTWdG38CbzN+jclGjcHqz2?=
 =?iso-8859-1?Q?76R1TGoEPkAF/hWjy8CpZ+0xvrgnz3gUQnXcOJRZWIVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xdIk602am2Mdczjf75JCreL84rK0U1vjKhbPUQ+9+D0T23iGSW44J3k8vo?=
 =?iso-8859-1?Q?dDaQZiYD8wJKtmwAo8MB/Qt+O7LPuCfgBH5cFeZIi9BxQtxysofze003tL?=
 =?iso-8859-1?Q?r9L3mnWc3T5XSVX0DoofoeZij8FFvCESzUpxAdLtCl6D+19GabrSBkaUIB?=
 =?iso-8859-1?Q?TslCPk/4VOSY64euDOvCD47ohTJMR7V+Cwafs2PzUlWfhoK2Kn4DmA397h?=
 =?iso-8859-1?Q?BGZfzq9K5W3xiNN7FKmEt8JrOtIWJTwDlfW5EPEecigCWB8IEL/kVcPoWj?=
 =?iso-8859-1?Q?9h0d+uGYyMIhMdD1271PEWLjXJouEnjIkTeMqK1LO4e202ZPf9P2BCE6QS?=
 =?iso-8859-1?Q?rbaBLH/hhMLGyChLBzKiozB55/1gOz9fGJU30v/CsciAbcT3FKZAEB20kH?=
 =?iso-8859-1?Q?oQxa5vwVlOZsW0CupV3ZcCOXSfhzBEx/W4efiRdW6m8xjzuwPX+UoOLjJn?=
 =?iso-8859-1?Q?0rvSUcBVlt35iYARNV6RWamKjRtVvy5qH8xbti60xHGkgkRYL7ud4Y9iAF?=
 =?iso-8859-1?Q?7KboZwWgaxZ+1t55jbHa+r+fuDx9hG99rJGgJirlKOAlqxe3KAUXc4PK3K?=
 =?iso-8859-1?Q?TqsKaJYDMrGvcZoN4yPJ3n50Ns8wyfwkoz7xECaficYiShwurpZuXam34H?=
 =?iso-8859-1?Q?W49Ah5/h47Fz2c053jbVGtGpqG5OqgtN9k/BI0Jebc1GczgmxPj11SfSwI?=
 =?iso-8859-1?Q?YYbkG8hDAf7B1NGLRU+JGtrVgSfBVMd5I3GvAttmXcbcgohHCgzSZCkBMy?=
 =?iso-8859-1?Q?RMONmLm+ixShrP1qVvYnyzYjDsHWwTeCJ6O8miea9AzPOfjoW3T5KiNJU+?=
 =?iso-8859-1?Q?5RUZhUzzzoJd32+FeBQt11Dl8SbOmf6CDrw7U8uJpifkiCCcEBL7hDnfUX?=
 =?iso-8859-1?Q?38Qj+/eVUXQVoKJWBDML10piBE2DAe3IZ6X5ko+bOjOXW7oTTLBTJTm4xQ?=
 =?iso-8859-1?Q?/Hi4DlPvy0+ubkFQC/0X8X7rx1YJCqOvQX2TsRSsaxy4dB9B4YS18Y/TSx?=
 =?iso-8859-1?Q?PGkWyLHWhG7VkBKjEW9VGcHT3TWDlQtHIiCye2TcpbQNIIxlQ+fBBuOPWE?=
 =?iso-8859-1?Q?+zEyl02BYH/7UtIsk22FgQhfcD6MaM3Cl9bGIMXfZANuxHBS72I9F9B9bE?=
 =?iso-8859-1?Q?vLc/Hzi0CSS55FBNwicG862SdQ+2ZNfLjNFQaX4x4/7DCnTpqWeCix4rEv?=
 =?iso-8859-1?Q?xZ88fx9mU/O+qODg3/bed6b27xFbptP3Nijv5PfKaRVvM3zGYFOcSmfPjr?=
 =?iso-8859-1?Q?g5gWzKbynaGBPx2UqrZoEMfkWq3b9rCGt6eo0IneXuxPOZbisRbaFWkTLD?=
 =?iso-8859-1?Q?mq1SraBndqHSYzOohk3gP8ktjJu5pAMUYYLCiCe/BHi6lXSjwEkCKX9GbM?=
 =?iso-8859-1?Q?YB+H9QfkCWmaqPjM/Ka5JVD3/DocvKN4Y5tItNTthcK6iWGL2QmT7+7tKn?=
 =?iso-8859-1?Q?2nCyeDd5bcApbgxS1gMDyHfWCLKwHPKsWAA6f4s8RJl4K7drmQ4b9nYF0G?=
 =?iso-8859-1?Q?Yg8jbdaRIwhNAbLz8t90vZS0ufFpe/1hNFe7qtOu3dpeMe+O74img7D8nh?=
 =?iso-8859-1?Q?cPud7wzRc4zNbuq8tBh46ZLaM4mtzUaJheDCUY3PetX6HgLeqN2bE3me6w?=
 =?iso-8859-1?Q?CcWwTFnpXEcY9H+FWU5vVa0YOsPyYYetdEdCuM6oVdqdq4YsQvvuAgdh2t?=
 =?iso-8859-1?Q?o7B4iPV3BSmvQGcrPxE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cc71d5-80c4-4cc2-e9d7-08dde9491ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:17:20.5583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udvoySqaJjfXokKoVm32XTjbelUnwanS/Z5t1GBfyn7AD3bwCyQgkDyn7PquxiSJFbK8L6DBTHq1XDGWG5qb0YGykxI0o1WXTye3/ZismsLYS3E0eqg4TakHh6SBaLd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9215
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Sep 2025 09:13:15 -0400
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

wait_desc with SW=3D0,IF=3D0,FN=3D1 must not be considered as an
invalid descriptor as it is used to implement section 7.10 of
the VT-d spec.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 83c5e44413..4e7ad3a290 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2857,7 +2857,13 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s=
, VTDInvDesc *inv_desc)
         vtd_generate_completion_event(s);
     }
=20
-    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW))) {
+    /*
+     * SW=3D0, IF=3D0, FN=3D1 is also a valid descriptor (VT-d 7.10)
+     * Nothing to do as we process the descriptors in order
+     */
+
+    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW |
+                                                 VTD_INV_DESC_WAIT_FN))) {
         error_report_once("%s: invalid wait desc: hi=3D%"PRIx64", lo=3D%"P=
RIx64
                           " (unknown type)", __func__, inv_desc->hi,
                           inv_desc->lo);
--=20
2.51.0

