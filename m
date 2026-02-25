Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73605EFB7F0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv8Wv-0006jK-2V; Wed, 25 Feb 2026 01:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv8Wq-0006hC-UN
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:37:49 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv8Wn-00060f-CH
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1772001465; x=1803537465;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=FIfatgWmpyW2Y8WgI+0wWdxVg9eQ144VuzqgAkof4v8=;
 b=woeKFU2sS0I02rUwGj//XvVX8PSx4llfdQwVxxE5apGyYPLHZBKI6P6e
 9M7Df12H1UTZfsLKEr/d14qiAJE0NnYBNcAqQPek7ffKZDVaSMzukPkgM
 tds7R4LUNu0DJOY/0dXeQa/D4preqYE2NwFbvPNWC8b2KUsUiGvX+ifle
 oI7d6/LBp0nunW4mIEjMeh0d4U9NHFUogyOpM0cP2wvsne5CsaMSoVyfB
 f3MIly1Xpkcq+5YZ0mdLliSa1R4Oo+M2SvqqkXLT1psjELWcieetSXjfk
 RT3gwzr2X3Ptgl+xch+nTbuvDsD9+6DNoaZXHmlMsSfrPCQuDD3y53HFk A==;
X-CSE-ConnectionGUID: 7B1o6CoeSGGpGAKJYCCUJA==
X-CSE-MsgGUID: msjvFR8cRJaQxUsxiEmHIA==
X-IronPort-AV: E=Sophos;i="6.21,310,1763420400"; d="scan'208,217";a="48759357"
X-MGA-submission: =?us-ascii?q?MDE6fwXHUHBToq4pwzMc5gepREU0zHbaMFF/bc?=
 =?us-ascii?q?bPfAv4Ky1E9EXZgqNuDmXSNIrSbi4PeuYlFXFlHS1vIl7Q9Z7JIs+kFC?=
 =?us-ascii?q?jkVMrHXPWUa16oGuXHB7mElKZdzzvO1wPoyqPPNulJJMndJFlWq/BAMu?=
 =?us-ascii?q?JpGjeagaZdlkxeveM0udlI5Q=3D=3D?=
Received: from mail-northeuropeazon11011037.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.37])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 25 Feb 2026 07:37:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHx2tic6i37P81I6V5aGC2GbKkNrFdiINOu2iHPUAYnW9D+fo2VaZ+xVsmKxFK7aUGSHY+biAKbIgwjBjHGPrHqxU3Zi0HwEa9yFi65Hm2aMGxjOTyYJvPjcwh6mU3Rd5uvZ0jvz+DJ5Sd/y62KjWInKBW13xZdfmxP5dw56yW7ndlydemHEgDtueOpre9Xp4plv4jjYULv0Q7K/1YgiT9sCmUfMhJusdVGmKReRVs/XNCkZnXyq4wg5+PSwJFwt7/BsZpPZXDPFDX0zxcNoXDkbkRlP3YylBUCOiwxoiuZC2J3aQLSyLczxwLpzN2nZegZkgFSFQxlHxsHqLiUx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXexzqxFjjLLoFr8sg1BNFq3bcxHB7iEIsxWmBbbnUc=;
 b=NEfplkizwikChWFNJE1KkhEn/yUS/EhnSAtxnAwYFuSrjM/93+u3QzA5y/H7P81MR9IiS8y5qtHLAwsc23qyjcDEYULCqg0MA18Vy+OX9ctuLXgBHGRNU/kr/X1wuKVwt9CWtVYGvaUBr7EHh4T+/fT8/DFpAQGh1Lxy3CR2du6t/eIr7AlCtrMS2EXRUaONk5nfG7EqCKWZs35vd73UgIKPaEVJtHM6Y3MzrScrsfrVmw4Nti65S2nev2PAqQ5gEJLzfZz3K1MWuhnAYCGJMY74mOEtxyr0jPTJU9iSFByNR7o7T7yDXoKv+lgpinOQgiai4EhLh3CpU1jhjV6eeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXexzqxFjjLLoFr8sg1BNFq3bcxHB7iEIsxWmBbbnUc=;
 b=ph6njtFai9GDR+8t6PfLNlX3Q8NowzUiCOWF8UUHDllfsv7a2KQ8pu7T0dFtQYvGRR/27uIYUSfqHGxcq+nBhCavC+471SeaZyrX6uBOc9/aS+w3kMdpR1dTZo9Ll02smIddBrhe8TLl/ZHfWM6YaCyoe9QbaBr/BspS5YWTs6wP8EO0PIagQsxH/qGJ0cCKTbf4nsQQe7CFtiokJfprqvqr84ug3bY20sxwpKAlOiAIEjprsLLNxDpxX4EekeiTj79M1COHbYezAQVLa7TZrjzOF1VX1yD3ZJ37KdR3C75O+hMpIkkX1APy8IM4PXRQx+KEvK3cOThH3pvFAcVD9A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AMBPR07MB11885.eurprd07.prod.outlook.com (2603:10a6:20b:759::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:37:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:37:38 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcnWP20QrD5iQNmEWrT+7sB8IeqrWTBqiX
Date: Wed, 25 Feb 2026 06:37:38 +0000
Message-ID: <AM8PR07MB760213E1A9BBE02E443F9CD28675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
In-Reply-To: <20260214034135.220413-13-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:37:14.117Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AMBPR07MB11885:EE_
x-ms-office365-filtering-correlation-id: 256b5981-0ce9-4d23-d6f3-08de74385e4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007|18082099003|38070700021|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Fe1tGXzwe1KaxK6sh8Qk6rUz56xKdgCSsTGGW0k7KJ3eoLNAmt3E9ZMN3s?=
 =?iso-8859-1?Q?dQYZt0/UVlLztjOsDppyqF2G0K2mGJ7REiDvr0zezwee3409eURoEpTjxl?=
 =?iso-8859-1?Q?1fkX7cogje00JfYpGHD37F+rePMRVqsopBi8W9Y7A5MZ8GRHm2uAowp0Rf?=
 =?iso-8859-1?Q?ium92RBKpsnIG1w4ONyMnKuQbYH2f/dLE7prxVkQ/+oimI18YtERQMegvS?=
 =?iso-8859-1?Q?Q+dikAXGlHoY/HGTN6DVNZ21pSvptRXzuUI4KVXrHs/jYotAmOfAVyN4Fe?=
 =?iso-8859-1?Q?ZxgA90zp8AQd+uWhd/lSAokG9jcgcVpM2K/qWWyNrpMLVQoRjdSKhNY3Mv?=
 =?iso-8859-1?Q?9CcAqHw3/PAAk4vO0MpYmXlHZ8Y0xJuZ14z6JHBTaX5zu7ft7CmBJlJgqi?=
 =?iso-8859-1?Q?dICs43+BN8MWAHdy6FAYeOS0lbGxa9kq+1xc05zY9PtjTOD9rj587GdlCd?=
 =?iso-8859-1?Q?yd3GEap+5D98QQW1j/UTCcNMCFBVtZ4a60gHmBwFJoYxbKYaCqtPgUSau5?=
 =?iso-8859-1?Q?wSSJh5WZJU80vB2WRpUKvlNLjtdE1r+uWuMgRk7hftG7wBQBJGGtMnBRar?=
 =?iso-8859-1?Q?P9M2k8yaW1uXlZHCRb0pYcOj22ptvAR/oA8XQ7lKBIfjfMjJ6ORZLdOIkY?=
 =?iso-8859-1?Q?X5OZsW6NwPkTqJ9y9EMKR0RkD6Ne0rcrdwDoLZJSxCMiDC3jfRlUXUbgP+?=
 =?iso-8859-1?Q?arpbz1kveVBrpffItyi1Ua8xmwgXF7WPg4xtllIV0Z1C4JvaXHSj4b/aG4?=
 =?iso-8859-1?Q?Img+bpRhIJa7dSNhC7dOC+wVwif7xHt98+MPVa7tab6tXKmXe7ltmxtlgg?=
 =?iso-8859-1?Q?y2St2trtnDg8RPXNBMf48dAqKdaG/f+4iuqV/ZKBznsm+2kIolXsdCxu+u?=
 =?iso-8859-1?Q?kgyu/WVtbJdQclDOg0/Seo+hF4iqMv5+JXhURpJjut2KOkGbpJJ+/IHwtK?=
 =?iso-8859-1?Q?LYOHRaQoqbebeVa2+PVwuld++f8KSBYQ/uFtw5eKbE/U+JWRED98iBJjUi?=
 =?iso-8859-1?Q?zLcOuqPgG1qolDAJ3tkZAbz0nacIHDFgzwIukkRZXrjrrnMZB8UTw1L4ZK?=
 =?iso-8859-1?Q?olbIc5ln7hOZAPy6gN2u8qKvGNOfluYtJTdSAhA7lTgEC5oC2zi9Cp/wAc?=
 =?iso-8859-1?Q?ImMLxOZeimH7Src8uqPdW+hpU+xZuqo3JdS/4LinE1LasMZVe2Uta7n3AV?=
 =?iso-8859-1?Q?qWcinX5JRbiXumrFbpoTwmlE8sUhbxV2i1cq4rz4wxhHnRsYL3mdax2EL8?=
 =?iso-8859-1?Q?s9S7RsGkftLZSxq2T8ss0VwxfUQF5bY77QPWAn0gSvSaRNmOiZPPkiYoP+?=
 =?iso-8859-1?Q?jvNfn//hP2Z5FU4hemYaRf6xSa7bzWZe+fO2D0KREA+ybIfrwnnUYPGnIL?=
 =?iso-8859-1?Q?B/nJWkpJoORYkJJ1bT96StPd1bmgy97slk2XA7Z6ZU05ujLyDmxj6eveu6?=
 =?iso-8859-1?Q?ue9Symh7RQVf/S9DM+uyCFkBYs0imzFJ/NowyfFF+y75puFqdxIRZqu9k1?=
 =?iso-8859-1?Q?yB9hmmHu/hdfhFP8EGonl0Dw5aj7R8sFouVF0xUylZ/FyQ0nNMUvWMYqfr?=
 =?iso-8859-1?Q?elQjXji8w/W+wEnGTmhQ//c+ZifHnQHDCNyBLBRbjn/6r9fddMf7D4P7I+?=
 =?iso-8859-1?Q?cUVSzH1OK/NyKUihVsAQSOTUr1cvA30wM7JkFQR9wVcb6ET8U4iDv7S4J/?=
 =?iso-8859-1?Q?24zcD950GMapC5tgXe8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(18082099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dmLY1HNvUa5JCuodk80IM8NjhAdn2gPqH9K16uLOpT6VO9Dfu2ZOltywz5?=
 =?iso-8859-1?Q?23MGMIFAMaNuZi5u4QkhLL4p/dYbFYYbLwCjumLVwsB5Y94GNLGlbtE+Vm?=
 =?iso-8859-1?Q?s3Vww6MQnrCWv6Mjt+csPTA7yWk2Ftiab7ExySr4DnsV5+FBL9u0Ws+UU0?=
 =?iso-8859-1?Q?65qwp1jxz97s7P6GLlxk9jLHTIKPXW3EgicRM5MCQcyHT30+zbGpOivpP1?=
 =?iso-8859-1?Q?YXUEW15bo7ocuJiMGhiYxbrrxx0gZA2pleWtY6xB7WdcYPbo+h/sZMktMr?=
 =?iso-8859-1?Q?iQuoOwtXUeprDs6VeTuh1BCBpr1SNobRyAAXhWEVl19aaZCkRGzdn09hMa?=
 =?iso-8859-1?Q?csr7juAnZmjPur7GDzlgmRthmmPhe+pSV13Av2qbWwe1g+inEf1HVcDhin?=
 =?iso-8859-1?Q?SKF+78hDL/A3Dn+M7hX7kzYBq7ToNGe6ZHbjGXGwS2n4Lc5PWqyG0MJTPK?=
 =?iso-8859-1?Q?1RknyRgPj+eo6guRdP4Lcsd68Dkp8G72ejNMjMhbFunZGGSsdYyvtBSmY0?=
 =?iso-8859-1?Q?NJfR9p83RoObTqK50WRsRoxdOfSiZCw740fA/Y1VfVi1lB8l/pLVIH5K7I?=
 =?iso-8859-1?Q?lLJsZuwYhph0uMs06eVzCZhpw/D1IhBRkVsR8tBQ/+uR1Ul0llwn2zFz03?=
 =?iso-8859-1?Q?4JP5Ij9opopJvT0J/lntcnQH3s96AzppF7K+4Mro7qV70rTXyP2Q4OFMBK?=
 =?iso-8859-1?Q?dZ/RwWlon7fuSIuEz03jm0QX6HTtSRUEeHEKVRnLMoSFnB9obRYxDWWvIr?=
 =?iso-8859-1?Q?fA7wxwJmEwW06xBLoQYiBYRaGEad4+S2Goxmdtiz6qVxa9dtuN/0ZWmuVc?=
 =?iso-8859-1?Q?yPsR2snOcmF0311yf31M5F5V7k2Ux/ad3j8f/H3Cj4+a2fnYHCqoWeUiDn?=
 =?iso-8859-1?Q?fPk3zKlWgjSiePG/CBY7cBRd7VZPvxHyYlck4f6Pe2jbCu6ONw8uikivsA?=
 =?iso-8859-1?Q?hU99IcUv9w7e1YpsGPmNkmu+niBz40gQ1c/Xqd+0O6HzSiQRRWyy4frOqX?=
 =?iso-8859-1?Q?G1IpELBv/fdTAzDuP2+8/Wju2IHTVK70nns0CQTdjsGguNLSX89WXnDMAs?=
 =?iso-8859-1?Q?ruRbPsSUcd4ZGVbYFWLKvMU6NhhMnP6z3lwV37NyhqRJUDjah2RlmZqmym?=
 =?iso-8859-1?Q?q07bZgpN8SfElyDIFuzVTh3dEPsoJa8pIvOm+CB9zMWFmFWrApZpgPyWPG?=
 =?iso-8859-1?Q?BmUt6ptrmgV6+JAKZxS/bDdvzgL4z9dZVRlAVDNJO5Nr2meQWpMFAxDXEh?=
 =?iso-8859-1?Q?07QW5DC5Ei4osYsdVpDEw01C820MADMKU2JNy/FD2l2meTYtccFw6/7/65?=
 =?iso-8859-1?Q?GzcgqQdqGuJtiCRD1//3U0DH+02CYnnxiJRZ1tw1qYxePZbBLdQ/WIr0nJ?=
 =?iso-8859-1?Q?qpE92s+RS++vqN1kmUVQESKFD6VK9lFaaDdxNW+zFuzJeGYZDAqG/hOFpO?=
 =?iso-8859-1?Q?RYgQFEyVorJcj0944KtAL/qa0n/aF/5QOKIjr+u7+ux5QdozSLEmK6m+xu?=
 =?iso-8859-1?Q?8YRdtmqJGESzNo3rm0WKAL58gnx+KdFHH1IylHnO+zy2wRrdmZcjnpdrao?=
 =?iso-8859-1?Q?XIuOfIt4lVhGGfEgwseu9gHLMrlurGokcPKo2g696qu8VaedQXxYPYUdyy?=
 =?iso-8859-1?Q?GZ0lSBiNxPo+N8w50W6mOERxL6BWqNzGcFf9qqQnZ2ETISpuEInwcpwBAb?=
 =?iso-8859-1?Q?Dfx1ZgSEXx9EEc8k+q0mSAcKa3xiNVBrMCqlrQJuFVbZSvCAYQaBK3bfVK?=
 =?iso-8859-1?Q?MvOmYTP6D6r+riZVp0z36CkOZbyCOguTFVifOE/U7hXSHKukl5mjfDi30U?=
 =?iso-8859-1?Q?GUQhQypkqHl8+8Gur8yx1tckTmWnJI8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB760213E1A9BBE02E443F9CD28675AAM8PR07MB7602eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AYCnuh97Jgio5u9J+5pPhXfPKcj9o89GpeZdnR+OISI38pfjmgxkWSVROpHtqqJPmOBsOlmzQeUOAT1jHzfCUZa/gKPZQagAe0+cYVwz2gh4MvKGSOsutr5Af35Dlr872J9QXX3u6jbIfReiEwN8Q3JZNFJ0zpRelOsIArg9L8MvaMoarYdY9Mtujr8CApCinkn1SAth06+y9QTn1x4RZbHIVceLMBhFtZyE+hKjv8InoxV9L+Q2VnFACsi8/osvgxGqaNy59OHoq2CjZ+uuJxBGsBs1NQ4TTU0hbUgSO4O6GjGeMKjpdSWdLtfchlq6WNaU07ecuIjqCmX/nb7JMA==
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256b5981-0ce9-4d23-d6f3-08de74385e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:37:38.2218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHkygXe7BpcPIA8sf0oe8TpMW0ZaXUHVJW87t4H0NG80gSw4Wt5NjGwOTsgCSvYugvNDuB0hl2RjE37OGnRh9zWyRZ+cDrEgNjQ1RkcPXXSZAec5WS+3sj1P1YkZBiqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11885
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_AM8PR07MB760213E1A9BBE02E443F9CD28675AAM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Zhenzhong,

I'm a bit confused about this patch.

All the other VTD_ECAP_* are masks for the ecap qword.
The purpose of this new definition of ECAP_PSS differs a bit as it extracts=
 the field itself :/

cmd

________________________________
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: alex@shazbot.org <alex@shazbot.org>; clg@redhat.com <clg@redhat.com>; e=
ric.auger@redhat.com <eric.auger@redhat.com>; mst@redhat.com <mst@redhat.co=
m>; jasowang@redhat.com <jasowang@redhat.com>; jgg@nvidia.com <jgg@nvidia.c=
om>; nicolinc@nvidia.com <nicolinc@nvidia.com>; skolothumtho@nvidia.com <sk=
olothumtho@nvidia.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.co=
m>; CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>; kevin.tian@in=
tel.com <kevin.tian@intel.com>; yi.l.liu@intel.com <yi.l.liu@intel.com>; xu=
dong.hao@intel.com <xudong.hao@intel.com>; Zhenzhong Duan <zhenzhong.duan@i=
ntel.com>
Subject: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e4bcc884b0..e5518a94ea 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
+#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6483cb3d85..c1b31b17de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowe=
d "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }

     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
+    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=3Don");
--
2.47.3


--_000_AM8PR07MB760213E1A9BBE02E443F9CD28675AAM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Zhenzhong,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I'm a bit confused about this patch.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
All the other VTD_ECAP_* are masks for the ecap qword.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
The purpose of this new definition of ECAP_PSS differs a bit as it extracts=
 the field itself :/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;alex@shazbot.org &lt;alex@shazbot.org&gt;; clg@redhat.com &=
lt;clg@redhat.com&gt;; eric.auger@redhat.com &lt;eric.auger@redhat.com&gt;;=
 mst@redhat.com &lt;mst@redhat.com&gt;; jasowang@redhat.com &lt;jasowang@re=
dhat.com&gt;; jgg@nvidia.com &lt;jgg@nvidia.com&gt;; nicolinc@nvidia.com
 &lt;nicolinc@nvidia.com&gt;; skolothumtho@nvidia.com &lt;skolothumtho@nvid=
ia.com&gt;; joao.m.martins@oracle.com &lt;joao.m.martins@oracle.com&gt;; CL=
EMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&gt;; kevin.tian@in=
tel.com &lt;kevin.tian@intel.com&gt;; yi.l.liu@intel.com &lt;yi.l.liu@intel=
.com&gt;;
 xudong.hao@intel.com &lt;xudong.hao@intel.com&gt;; Zhenzhong Duan &lt;zhen=
zhong.duan@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits =
size check</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Caution: External email. Do not open attach=
ments or click links, unless this email comes from a known sender and you k=
now the content is safe.<br>
<br>
<br>
If pasid bits size is bigger than host side, host could fail to emulate<br>
all bindings in guest. Add a check to fail device plug early.<br>
<br>
Pasid bits size should also be no more than 20 bits according to PCI spec.<=
br>
<br>
Signed-off-by: Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 +<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 5 +++++<br>
&nbsp;hw/i386/intel_iommu_accel.c&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index e4bcc884b0..e5518a94ea 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,6 +195,7 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
+#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 6483cb3d85..c1b31b17de 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Nee=
d to set scalable mode for PASID&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID wi=
dth %d, exceed Max PASID Width %d allowed &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;in PCI spec&quot;, s-&gt;pasid, PC=
I_EXT_CAP_PASID_MAX_WIDTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;svm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_iommu-&gt;dt_supp=
orted) {<br>
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c<br>
index acb1b1e238..15412123d5 100644<br>
--- a/hw/i386/intel_iommu_accel.c<br>
+++ b/hw/i386/intel_iommu_accel.c<br>
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D vtd_hiod-&gt;hiod;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps *caps =3D &amp;hiod-&gt=
;caps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *vtd =3D &amp;caps-&gt;ve=
ndor_caps.vtd;<br>
+&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(vtd-&gt;ecap_reg) + 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&gt;bus;<br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt;devices[vtd_hiod-&gt;d=
evfn];<br>
<br>
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Only do the check when host device support PASIDs */=
<br>
+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp;&amp; s-&gt;pasid &gt;=
 hpasid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID bi=
ts size %d &gt; host IOMMU PASID bits size %d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pci_device_get_iommu_bus_devfn(pdev, &amp;bus,=
 NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Hos=
t device downstream to a PCI bridge is &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unsupported when x-flts=3Don&=
quot;);<br>
--<br>
2.47.3<br>
<br>
</div>
</body>
</html>

--_000_AM8PR07MB760213E1A9BBE02E443F9CD28675AAM8PR07MB7602eurp_--

