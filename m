Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C959C4829A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 17:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8HE-0000CT-Pk; Thu, 08 Feb 2024 12:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1rY8HD-0000CG-QX; Thu, 08 Feb 2024 12:33:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1rY8HB-0007dG-Df; Thu, 08 Feb 2024 12:33:31 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418F6j4B022114; Thu, 8 Feb 2024 17:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pBOk7WMAwUvvzzkjZfAUGtxAStY57HJ2y3u7v/agyyY=;
 b=MzduQucAx6nUnkw0tkDTkl2WP9EV6bmZGfPcdQokc77vi7QHXo2R9TVdoJbi3svMDDI5
 pdzepMD9Nk6Yh/69Pw8D3kNS9AqWsUcIJ9oW3y46HyVfrtD8X9l4VFM6rBFU8j/JSK0E
 zPq9lSPsR9m4LDW11ZCAbUgsyEeDPvnIIsDRw8xS0D1RF0uq0N3wd/4vH6wg9yQeL84l
 Wp77wIiBKuiyyHQ/7ONlExeQiclMcQzyEWbPFkBzvVsejk6pNPuvWg6jENIn06GNnqiW
 f2sioFprDVFMcXvoCEFcXO1nvNNQVK/bXfmuhSvsV9V9qzjZSoCLcYjl3Rl7gehPVH/L Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwew7ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 17:33:21 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418Gigxl036762; Thu, 8 Feb 2024 17:33:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxb0x9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 17:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od+CSKGQvGQgI4U7nwNNCkiyj1QX9yNct90tW7rwjhPUlm52+E3kMJavsmd4uHTxQxR7Be4uLO4d1rd14d+UuW/60NCqk0BQFpquzTieHOa1bVvF0TWdux4SvXaWzmGJxmUTw/kXMNUgtFi5ppIkf/q3XVTnK1BG6+xyA3xNaRSOCU1/iXA1+eemKVRiyL714V/BVED0jI3tHH7ZOdYNLdbIDFRHnSElGMOswM8Mq4xFITntTpVM6FFRTmcEPL8TIUt/RJo5b/njb3npo1unXgxL0/5R/kT+Ke4D6giKq0iGEHEYz/llzy3PhEpOapWI6OlgFPncWZkBybO8Erg+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBOk7WMAwUvvzzkjZfAUGtxAStY57HJ2y3u7v/agyyY=;
 b=DSgicMEc1fyWllv3zschpMCmJ5YXfv4x1YTqfFtJfzp0pscOYNcNKtaaL9pZWehp/Eiw7gULyTDgMICMQ66VGDFgP1cJotUcTpDtHWtzrmLwZVI/HoF766IcPKdQxzkWzlVGRi86KWVv5gCLnJzQu3lo7oTK53Ir5U1ESO/kqr7HV8I3vaOouvYhP80bSb0EtxQb4NVOVshGj6q6Q0mu63QU5Q0xIXWENSFEn1HoWgHrfDRKI9vDhljPrFAcx9sAMu3o4zaa+kmAm8lAv3HgcBLFuuP1RbC8ELkaev13EbZVWDJmiImVYEOVL5K9pd5092jGMEchEztkNxgrHQKeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBOk7WMAwUvvzzkjZfAUGtxAStY57HJ2y3u7v/agyyY=;
 b=nbKGs7rCLlvaWTQUxs5G8ZYIvFFt+rSADJhv9+JeNaNsforw9x0Y2BH9h5kqSOmEBp5fdae2MbdPIu7ixTiqbCNfEZcWH1H3eR6e9NghaWqBnACmVJB6dVJJt0YwBx43WQ0d+jLjdH4IWSfRpYi8w3/tk8bNnjwExR1yxTUxqd0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA0PR10MB7208.namprd10.prod.outlook.com (2603:10b6:208:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:33:18 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 17:33:18 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Eric Auger <eauger@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Haibo Xu
 <haibo.xu@linaro.org>, Andrew Jones <drjones@redhat.com>, Marc Zyngier
 <maz@kernel.org>
Subject: Re: [RFC PATCH 0/5] QEMU v7.2.0 aarch64 Nested Virtualization Support
Thread-Topic: [RFC PATCH 0/5] QEMU v7.2.0 aarch64 Nested Virtualization Support
Thread-Index: AQHZSsnF2AE6fYpZnkaYUs3ECSjtArECyaKAgAAKi4A=
Date: Thu, 8 Feb 2024 17:33:18 +0000
Message-ID: <69C2ABCA-577B-419D-A0B4-52923BE59842@oracle.com>
References: <20230227163718.62003-1-miguel.luis@oracle.com>
 <5ede0197-4587-43e8-976f-d3001f42b8b9@redhat.com>
In-Reply-To: <5ede0197-4587-43e8-976f-d3001f42b8b9@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA0PR10MB7208:EE_
x-ms-office365-filtering-correlation-id: 23121454-e5c9-4b0f-6cb3-08dc28cc0a02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7I6MmKe3zxlpS9Bb+sFVF9lUhnT/DhEzbnkh+0CMdo9fWKf2BzYZKzFsV3Xorrj4UlaR5LJUUvGyNVgEe281lu0Ae52GlO5avTAbdIsCXyrunkOvqAY5vATEM8eQWlfBCt8+UOlt9vjqzieJx4Oz0+7jOTYdkrmU5yeB0moYRr2y95/A/BbqZFsrOuB/qYT60J8uHTllGv6S3dX/rGNwyyQtyX0kd5a4XNQ49KEATzUfaKMKvRpKuwZBBFC9JvviVKU6iUNjnMNWRF063e2aJPKSvJbVcD/1/y2oqM5k0RPlYLwVxh4k306qALN4ZAqe0JSeDa5wgIidWrqglVCEV2y59iRcdfNFyBNGIBN2hDhbhNGVXlVRtwdpj4+QwsJiUCWvffKOp7snZiGnwFCV5nvx5BoKxclfrrGqYG9doiki/WXuGuRm5+xPJyno78IW1ONGmOvNk5gFxYlNaX/CNtS4J5tK51KlfNujz6tLrCVqmqTHmNJEgJYE1AueT5b/0XJvM8S8383fwhfNBSvkQxfq+USI8frKlL5RQIrEVy1XHtky8Yw3KSSFbRq3+BoEs4kqg5aoC5e8kPIzSN1dxDHDvTQeboiBAzL6jp8YPrXTXMGMQUcu3X14VvoaRN8M9BuScFDx/Hfod9kveFOsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(122000001)(83380400001)(66446008)(66556008)(44832011)(41300700001)(6512007)(6486002)(76116006)(71200400001)(6506007)(53546011)(66946007)(26005)(2616005)(478600001)(966005)(86362001)(33656002)(38070700009)(36756003)(8676002)(316002)(4326008)(7416002)(8936002)(66476007)(6916009)(64756008)(5660300002)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xbKtrqr2Z/AWb/vfYLH84lAIYtTdwKgYFkZBHI/xGEhHmQ0nn2JTcVHig92A?=
 =?us-ascii?Q?4exGIjYT5i+LrWxMXPB5/sl/qstQMW7P3j5Ylub0pX+ArXPZzEBNZdr4OpMz?=
 =?us-ascii?Q?xN1MvtBAbzCazSyTuN3/IKDoSLXnQFIFtblnnCBRpph0UV0EtcEoEf1LAh+l?=
 =?us-ascii?Q?B9kRVuIhbIioHZTXHEhpzM1DQs6CO9YcHmywD0Si0/6fedB4n6IDDynNVU8C?=
 =?us-ascii?Q?uMhCL6aDtV1qHxmQYJaGECPD0Z/pGAifQ1POW+47g/gkF7qiwBggFDNEhw+8?=
 =?us-ascii?Q?eDGhHcYyfrmfUEIkpmYeZBEwt/52wbwzmg/+eFfWQp+ftEGzdMOEQ7NCehzt?=
 =?us-ascii?Q?kko6E1uthpnBiX5LGn/61d4F1iDWGRTU2HDwk5UJxpIQd+qUG7iIOI1Z1rZP?=
 =?us-ascii?Q?oFGOm1703UVlC9ryfBA/fTfkM6zkc+RsX6QDY3jFiTbA8fwTXTP4Mojwgmmx?=
 =?us-ascii?Q?K6P1kDtm4GmhMFD5wc/HqK4l/NDYRHdyCu3hh1pdUzIi7tmJ7XoCgTMdvWNS?=
 =?us-ascii?Q?aijxhxMWUg40J1VU9cygTT0HLKJWn/U+yET6HYYFAxxE1sWJUg0bmbofASXL?=
 =?us-ascii?Q?BRLrhAfylAhGhchukAnr9BmOyw6IlgQbQqO2ThvOp91It6xW19bOXtTySHcq?=
 =?us-ascii?Q?+3OgDc24DczLWN068nCdLypKH+4ayXqcnbRGrXzvo+Hj5WpsPMmUECaFT6SP?=
 =?us-ascii?Q?9s1WaeVxV/aPqvop0siqg/dJwv775L4LIiwlqUbg91NBpWlU+3zl5Tz59MTW?=
 =?us-ascii?Q?TSlXnGQhFjVvR2TLNHi9MufaEpNXGrV70gvVdW/YTCQ3CZ1qrEUudzOFOGnO?=
 =?us-ascii?Q?cdkED8cygeQREwimAFuos+fgfFEwODFPhOxBS1xMH6UGImoVp8TfmtXSLObv?=
 =?us-ascii?Q?WDcKvwy4XbrWGTXfcwisqnU5iwcU8lpKrI5cK2Fp5PpNSczH7mSlUeB2DMwy?=
 =?us-ascii?Q?GePXHe0r4hdFhIVpRA86vVhOjPCQ7NS5ICrHhiXlpU/6o/R0biuTIRpPK+Yc?=
 =?us-ascii?Q?YqkG/G0SK1+YzbUZb46nbe/EsNAQS3Uz+g3ttXJbLCTMYPhW8CafjSHbvPKx?=
 =?us-ascii?Q?KLRQgUaU5Ok3F0SH4c89o1BCA1BFWeG2A8Q7tsdMp95qQU81CTLaQ5XvG+IG?=
 =?us-ascii?Q?jmQdpq0H3dCZ25+DzvGvxPxcWR0zoRpVnoalrEm2fBNg4XWxAUmhdka7UjzR?=
 =?us-ascii?Q?PEXzrvYFArRVYcbriZ52omDV7G7jbVQAOklUT96+v5vHy/SRnFEIGrOE9DdG?=
 =?us-ascii?Q?qaff5NOI0d9r+3bVWjB0DAhPZ5Gulsdz+4GiJ86TqxmHxtNRwU/qpH1m7ASV?=
 =?us-ascii?Q?UKv0gZQ2EuIjYB4jTEreG8SmZoWFQsaSyZq1kfndGlxG0o4r8kLYLDyVDZ9T?=
 =?us-ascii?Q?NDkEd6Te9OgVVBYyACDpDe5nrGRpSzgPTy7Hyn2kq5V0Lq+2uvkNwII0f567?=
 =?us-ascii?Q?8iJA4X4sxpkCn0fGEnFLDS3yBqLpF9x7dV6u9sLKPxpYJmrCvSTjgIPXqy4V?=
 =?us-ascii?Q?dHrHLE5Nw7Mdco2wdwiQUFpCgAy8E9f6nK2ZS/y5Jl/T1D83HZAwqGL8NF3p?=
 =?us-ascii?Q?nGYsLRg5mqRLeaEKmdk5i2FmJWQshohyAqbg7+xSiRdh8+zrV5Kpg+B2FNMn?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F73214729DD27F4384E494FA836F433A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Prmzo267LKM+kJRrGBZj53+CTekYK2V3bJE+JhEVLCgDGhg94tRS7jOAZ87S0ekg8CP4mv3lN1Jtc/p9NcN0hlDn/fkppnuu7ZSQZKKYlrFHAr5T/eKUtH+YIpIDP2M2tVopHLq4RkzgEyNHk4iFjqefg5PzClq2kqID+NxwLdEuD90Z6y7SkWPLFsZh4uCl3L+9xaMKjfhvXLcVP69qGi1qSzXlyzE7JGi7P6glI4YlB9fNO/16c8nkGMt66Uticfgk+O+gndWL+bH2J+zx4flbsgp8RT1fpnit4AvCEdc0FVKnXSshICc2B8rVbIPOUvXG4WoPkky1/Yx5jKJe43BAn2rz239H+jw9JRtt0mWzf5Msr2bP6CEFHvvL1cS8A8cYLla2jujryxBd+fSxqiHpqqZNinsoBt5vB5CRHtUhkZ1/bz3maNO0j3hJ5nxTIvVub5fo13mRDpBx8atkVd02r98dImnzczwSHKjOMSWY2JIvF7Lycf0UAaCKptGSzXChKsWCq+PO+ny2yANKDzQfRngXR/LjMWEcBXwA+5seRFfoqvGcz1yY4s++3bveRPpP0rMin6hZP+z/Bwf/u8BDxiZhVzD2Ij0q7rPgyaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23121454-e5c9-4b0f-6cb3-08dc28cc0a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 17:33:18.5641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0TG+aPxoFAseh6UQaCZIRRkqdd1tA9vpVE8XZJC7zw956FYEXZj8oBEJ/4G3eahsFR/mutcWX7pJwn5ap6BXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080093
X-Proofpoint-ORIG-GUID: xG_u7fnPgv531tA1_b7Kpi84CoL9TnHn
X-Proofpoint-GUID: xG_u7fnPgv531tA1_b7Kpi84CoL9TnHn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Eric,

> On 8 Feb 2024, at 15:55, Eric Auger <eauger@redhat.com> wrote:
>=20
> Hi Miguel,
>=20
> On 2/27/23 17:37, Miguel Luis wrote:
>> This series adds ARMv8.3/8.4 nested virtualization support in KVM mode.
>>=20
>> To enable nested virtualization for a guest, the host must expose EL2
>> support via QEMU command line switches:
>>=20
>> -machine virt,accel=3Dkvm,virtualization=3Don
>>=20
>> Inspired on Haibo Xu's previous work [0][1], Marc Zyngier's kvmtool bran=
ch [2]
>> and kernel patches [3] on nested virtualization for aarch64, this has be=
en
>> tested on an Ampere implementation.
>>=20
>> This series adapts previous work on top of v7.2.0, it considers comments=
 given
>> at the time and preserves authorship of the original patches.
>>=20
>> [0]: https://lore.kernel.org/qemu-devel/cover.1616052889.git.haibo.xu@li=
naro.org/
>> [1]: https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@li=
naro.org/
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvmtool.git/log=
/?h=3Darm64/nv-5.16
>> [3]: https://lore.kernel.org/linux-arm-kernel/20230131092504.2880505-1-m=
az@kernel.org/
>=20
> I rebased the series on top of v8.2. I was able to boot some L2 guests
> with it, although it still does not work with guests featuring edk2.
>=20
> Do you plan to send a respin or may I do?
>=20

I do not have a short-term respin planned.
Please, feel free to do.

Thanks

Miguel

> Thanks
>=20
> Eric
>>=20
>> Miguel Luis (5):
>>  linux-headers: [kvm,arm64] add the necessary definitions to match host
>>    kernel
>>  hw/intc/gicv3: add support for setting KVM vGIC maintenance IRQ
>>  target/arm/kvm: add helper to detect EL2 when using KVM
>>  target/arm: enable feature ARM_FEATURE_EL2 if EL2 is supported
>>  arm/virt: provide virtualization extensions to the guest
>>=20
>> hw/arm/virt.c                      |  8 +++++++-
>> hw/intc/arm_gicv3_common.c         |  1 +
>> hw/intc/arm_gicv3_kvm.c            | 25 +++++++++++++++++++++++++
>> include/hw/intc/arm_gicv3_common.h |  1 +
>> linux-headers/asm-arm64/kvm.h      |  2 ++
>> linux-headers/linux/kvm.h          |  1 +
>> target/arm/cpu.h                   |  2 +-
>> target/arm/kvm64.c                 | 21 +++++++++++++++++++++
>> target/arm/kvm_arm.h               | 12 ++++++++++++
>> 9 files changed, 71 insertions(+), 2 deletions(-)



