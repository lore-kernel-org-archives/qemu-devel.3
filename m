Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D170CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTIX-0001fZ-FS; Mon, 11 May 2026 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wMTIJ-0001df-Lu
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:15:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wMTIC-0000FC-CK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:15:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BFtfCZ1614778; Mon, 11 May 2026 16:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=FvEZcmEMdCI5CmyiW0eD7QaL8wwipUa1bsFnSoiHVdM=; b=
 G04a54dzcSZ2tzV8hLrfdQpEoEvl9qg/tWCa/qCuBBNbOfxPXgJpH2tgvc9d9XYi
 aI3De4h+QgrMuhRutqVbrAeLLs8+gOAdFvB6/BviPAgeB2x3mw9UTeVegw4A0ET3
 exRxE8woMjnrXSGWdGxj58SaJ7t/30dDaWeabrZQjli9gIMIyD7g6tWI5HXoT+j2
 QROpwYFX3VNtP4IBLnhqPwUgioFRwlm7YUnt1yh83jJqnAf/Qz2GDkNZzJ5gMRbj
 WrY44eNYyBbCKL3S9CV9CvZoHf64Prprv+9z+VsTxwuY/pUPJxxj8JRb30NVKkpC
 FXXqaHWWTQhsJkVqQ2lo2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1ugy31ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 16:15:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64BGBjGs009820; Mon, 11 May 2026 16:15:21 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4e1uc8yeg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 16:15:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex6cA/yvVeSD3w8EO/lRrYuOMxGiHG0Rd/CMeJIjJcPjxfYWz2ban61XcoKk4Rq++FRq+VHzbVduNblQuMzroD7BHv76yNoF7t3azUDpxcqKxU6CJm1uDMEip7i9eXBhVhOrYhoPxNBsmBHAIuSjl2XgBN0Z+MorC7vBAerkw7P2ZfgGr735Wzg92qajvvNwzeUOtR5fokLdePSXuNEOVfENamlFL+jVNKj81bMjKTjch3p3mvKAeKoxCfIeXbH3q3yvRIj8Bq7TSbssGy1GlRerECiwBmcIb1sCLy/hismUA2AxRW8gWrfLrGqqL/90eNsul/awyyBMrzDAlFMohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvEZcmEMdCI5CmyiW0eD7QaL8wwipUa1bsFnSoiHVdM=;
 b=T2eoKyY+dAEj6ACXyR7j88Fw9/MDoC3f6KmfqgmY8Cwxn0DQ7XgdFuNnRebem0/NQPklMVKxREzRqn9UuL1065gACrqXvjpeUwSMZ0zflHb9wZLBfx5vvFRinBYKsOKcyF/QO4gJMUJi4T2H3hc497HnPHirYwt0GNdhiATdanfPLj/3Jmr7/QmVz8dlRc0LsVrbn9Xf4bVuSOTLn4pZZ3CnTwYBSzNuOrheVuGh197tqK+ES6ofFDEbQhtTpNoOq2x2XTxzSxsRrtlKR4AVcrZl0wYypfiC76TLY7V4GRhrIj3LMhFk4TD57MzYa1fvaL/ouqCBxcQnMf0aK3nEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvEZcmEMdCI5CmyiW0eD7QaL8wwipUa1bsFnSoiHVdM=;
 b=fxo5L2hjo6K8ldGCmWi01MyzJdP8Pz8Yf3ZFvFcdVFMS39/pEYU6jVGkC4Gh39U1HJ8CAlCJeUtYjVlr5+2xfpdgBGiUOfl8M2fI5OZ2sLsegmY/kw2aD2Uu5UfCoRSa+5uSOguZ7dJusk1VFTK8jQEoj4qiLvideDcnd9jEryY=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by CO1PR10MB4627.namprd10.prod.outlook.com (2603:10b6:303:9d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:15:15 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 16:15:14 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWmgAACZwCAAAE6WIAAAVgA///FPgCAAEZ0AIAExSIA
Date: Mon, 11 May 2026 16:15:14 +0000
Message-ID: <88BAE7FA-7DAB-4372-8710-C45E98178EBA@oracle.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent> <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent>
In-Reply-To: <af3_CqQf1wSSWYYY@lent>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|CO1PR10MB4627:EE_
x-ms-office365-filtering-correlation-id: 4df6481c-2383-4c0d-e799-08deaf787c00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003|3023799003;
x-microsoft-antispam-message-info: z25A9htp3izlpsgL5I71Vmq8FRaVl6uMqb1nNVnibgpcVbZcokp+nYVL5aOswHuFGc9ujRd4cl011fLgJyn0dv2Vs/J+RmIB/2jSlcxsR/RbOo5QaKuE3nDFbKrBw9xNardH44SSWXQ0aKvRb58Je/rno7+xvckiZxeEjvzSv2+0AkNArDbCsnS8ynu1v9n+2o4M2AIc5P1//dMjU3f+Ttbt9WVTjobmFn4pavlukB0lj9owqjBeZ32dEghDAc80y2U/vWVN9CbS3yXAWFrQxQEAW6zwBOgqq/MAWW3y8RxdncNkUkBhP4BgAod9DOFD0n02pNubdNXAleoXMTMZbNx/eRzUDTQqgDkfg0NeY9M4U+kV2zprFrvKatO7hqy/BZ+F+O4nbznEhwMIYQiXC58jPtwhOv3N6NsfzAF7nNGXs8TDbWYI8GbmTnaeAPGpmZV7v3/DPAni9T7jx0BFUn/wbrjtshz76Pl0RZFtyLges7u4vbbZPxNwQKHIW0WPbw/p7Y0YGzAyOQCWj7a9iulro8hWmYez39H8kyEmmc99N8BpRRehl9qXGADMtXinTv5to7zmuKR6dDeA9QtBm794dAim+QefPluoMDtfQSDg8Q/6qrpBKHqe+kRv/+jN168lGu4Frcp4/BtSCLehPe7DBJtBVNYq/F9blaUMF6nmHy+MUxgFYedzpqef7H1Em0uJWieUnid9ihjE70LzPiqvs99QaNhq20FQq9fbGmjlz9xNUiOLrJain/ekRuiz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CTtMi1gBh5LNp4SxbXluGypMbrepIhKFUjE2CwAG4MWP+N50U406GFc3Zgas?=
 =?us-ascii?Q?i6ajCl/6CavoP6jJWKwmvAByKNEWwcOlT/B9XAyVFDdmKmZhp7jOV2AuVVp3?=
 =?us-ascii?Q?5Vc2qjS0ln8Eh/VYdJFChDYX4q5ff5a4V+rLK7u9AfEHRGl1yg5XAEWLBKJn?=
 =?us-ascii?Q?cL7fQ7ba8jPwnkP3ZmDWy9BQzgsy1Qolnk8gPdPtyOYJ/5wPa8d9+/95aWpn?=
 =?us-ascii?Q?/RiTiALJtKQQ3bXuhJsOOKfPXH/40BP91WNlcE3S6eKkKduQPZRmhXQCIWwc?=
 =?us-ascii?Q?aOPHtOM9mH4XhBvd/sBiNjfmXvoupauCziIS+Xy47ifuNNW80bN57kg4NHmK?=
 =?us-ascii?Q?3IPeAAHV62NgTvV0XanFP9c1KT9NnUrNJ1pY4vrbUJ7ky25UAkEtp5I0kCCy?=
 =?us-ascii?Q?+EwRpsXakGRGIa/tWTo0mD4eHdYhtVsEH3cKpImEVAfxJRqaZsJlcbwjKgYD?=
 =?us-ascii?Q?b4TnnTL3nUpeQ3nKGzTHr9HDUWaZ45v9anNl+Wvg8cNMJSgnW2YcRHFuNNdv?=
 =?us-ascii?Q?/AmbVj+ZMUHizsBE5zeVqNCJfY2tdbUR69xSnUbGtx1CwDFhFx1tFgFXqiGg?=
 =?us-ascii?Q?f1zuiQUdSvvxzZEHmRBaypDDRMsK3KdZpp0bu0uZ3IbEcKKoeBmlKmfigmFQ?=
 =?us-ascii?Q?MbQzLOhHT7tV4UmM/3ikEKKonHizdZ1Jq2JohchMYvEnLTxs31MqfyQ02MfK?=
 =?us-ascii?Q?nX4/ofMvP+ygUhD5GYkZ+6RlQklKutwgbHbzOPk6kyT+DVhQt8RNBaRbOA9X?=
 =?us-ascii?Q?vCekj2n1OM4gNuSFNtQigybFon1nHLBI+HsJvbsIoW+dAQGSJJ/TOAwqPtSZ?=
 =?us-ascii?Q?lymHV9jeIuqU0MlHOc2WyzMLi+gfngKqg/JBdbrHcDMC2tddl4eEtQQCRCs0?=
 =?us-ascii?Q?IU4be3imwSgQile3U/hprCtxLOT/1j8cW2fS7GQRReRWWkQ4K273nfEM6/tF?=
 =?us-ascii?Q?t9wKhHTLVWQCeW4CBCQCMwN0w0pvMniTw7h6i7g0+FvFKl6At/1mo++PM5as?=
 =?us-ascii?Q?jwLHGN10JDIgMWagmRCHp0K4KegLKBg8gaj3hjonCzUsOPyssm5KeNBAG26Q?=
 =?us-ascii?Q?JdaPrCKFH0J/dNLIA6GQc+xxnP10n9pTuDALyPTw5cA9s6Gm55P/GBm4Xe0F?=
 =?us-ascii?Q?Wk1m716eqv5noOZ+ul+q/X7QdhSaj3SpiZ9RX1asrDLSee1YAK2stiqbTnxf?=
 =?us-ascii?Q?6/Iup4OGYg45xrYD+PxAUNWXQh3opcpV1ThRyljjadzVt9pZ0SHrm4BURdat?=
 =?us-ascii?Q?2FEF1iXBh6+QVeaAwYywWg9BfNmIzP0JPO5rUGlzRGHkEQy61/GO5aFBlHbq?=
 =?us-ascii?Q?1FXetKNfjV9xWxtm/Y6zVisVkFEg6D6BGNHzHZb8Jm9x/jqtCJOZXnS0W8m3?=
 =?us-ascii?Q?1gtW5NPdjKmVSRpVBe8tZYLadGW8QDnkoUs/hkdxzxKz+aJ0oWdXuw67m7Z1?=
 =?us-ascii?Q?aMAVWjbR3FO1Bkthqabx/fJUEIrVevAx9GuaQ/SdoVzlLaYXys8TUOVa0Y+E?=
 =?us-ascii?Q?BBG5ci/mD8L9DOmKNQ50Zlk7sUdu8TXBoBJH3W0QsgErrb3ifniA4F9R5xuK?=
 =?us-ascii?Q?NXvq5GSMgqvyhmWgupYd2/zKFBjYazklJrGTA2iDFMGizaL4TQVi869n6G3n?=
 =?us-ascii?Q?IxzxerqxWdijc1UMDiIhrkEA9eHpjwRGhG/lytmjZoRXZp1vLqCjTE7lTOFy?=
 =?us-ascii?Q?9fj1JTpaXJPhBQKy3cXV9aaQ8mdlpllXfS0nmwTiEJnNc807DpHBuArztf87?=
 =?us-ascii?Q?2sRkg0pUZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65B05FE2BB3A6A44803C4562E6F971EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lpih3LZ8snI9eV19f8Ir2YWf1KuNgU+LnDLR/uwsdwvnEfB9196Bk3Pn8ICZnPwbDxhWdAZzqGJUo65PZb5t10CCDQV0U2IwFEqyH7E6olPvmkZiGQKRuShB8iP41qRd38rfEMdEDBQfzhmKSYI3I6H+8At6cGHuZUsmZAo839PGCXXcIsq5Vkt7qXg/2QI/PstCYVPc6Ko0+8QoNIxq3RNUnDRbonUB6XmFGtdfS27wFkPeEEmp/0Xm4TP2tqoyOdQp1pvEylApWHpb5O2/o2ThnqzDo2Dij9ZD2Yswtd4ym1ekrzmMuPTloGBR8jLK/gGi6ABHTSfzQmHCjS5Ghw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l2AtNGvvvXgXdIyGEgHKZKiaO204z/GPZyMvWPsmUJOovZThaSAxJAZ1iXM7dVuMn0ClzMMhnuHXI2W6P45hPfcHWdydmIKTSGNfdJ/XY8mvt6NdO8+xEe9k4/Z0U8cRkeNA2noW+DADDc2WKrre/zQxOKNKdDqyoTKukCx70kN0zjHRiIdkTliVfdUMF2hIgFerdw5GG2PTSmoJakyddD6CD1dzs3X/DIQF3dwUUWWweoTn1Ee8rd3RZf8A/lKY4yeD+MhKF21f8EsfA+CaR3JxBH5szmDcCKp9rnVSd4xi7zxqb30n/AtIoEJHm6os98f8KeuLYecmC9Z6DVMYhrAW/gWmhVWa4i56BHcO9lI3EijX7C3umLFFULrc3JAmmHiJG1WwT2OdLclEpTmyEhqaB/vhcgz0m0H5jsxtj6Mzturv2dcfWyfOWaoAXzEZVeyB4S5avkgnzPnS+UnorFOn/Nco2mGky8Wh1DqnHDUa/LvbXFyXG+amDnyO4g1tII3Ct5nzsTbMMtomLcf+lgdj59b0/W1BSDrFQ/tmchc6SqvmCtiFbKHWWuBUAY7zW+DIYIe/iDI03Jde3PJzuTLOyl8GCR8lyIQVBQbsU1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df6481c-2383-4c0d-e799-08deaf787c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 16:15:14.3916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/DeYhq33Ckb76I08I5pq6BmKuNE2Os0svyN18cmfh2WOZ01ga7EYJEXXbTiwMrbYLf6acP3tFGfng5kzrC1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=873
 adultscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605110174
X-Proofpoint-GUID: 1My1lmacNqNpVb9897wdDse9AyS37z_8
X-Proofpoint-ORIG-GUID: 1My1lmacNqNpVb9897wdDse9AyS37z_8
X-Authority-Analysis: v=2.4 cv=VtMTxe2n c=1 sm=1 tr=0 ts=6a02009a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=6mCo0-iHXaOwN7Y_3IIA:9 a=CjuIK1q_8ugA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12298
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NCBTYWx0ZWRfX/ZN8SoV+klnq
 sHwqBaaFMOUD8RdUi9ugW02njkfUone+wTttIaBeEdBHw1r2Kxx2xKdibIlLLfIzlxuHJKETLDh
 gWQdQFsAe0zHtobAj67cgsSypGQ03hQb05fr0F+kMGye7D9xQGq+Wgr01JQGw/ciCZCsSAEb81j
 IFGAKjbzXIvebykOo287Nbp+ss3L2RUqLlu9Akf4bx1c9FD7YMzSLKgknJESCgDs8ufTMyCNcL7
 id5T166obnxy9uSkU4DCeiKz1hsVHgBbHM/wFmr6xvbv2j+wDWavAfsbDv5kqdknp/LEt0UJriG
 3UBeyRsv54vpI4vvI67jE12D1uAxQU926hNCw3TG82+icp0aN7nN9nQp0PR0ov5Gsk0hc++n9gW
 ztNIsXHl9/uov+lsEvKwQiKuXQxDCQJ9zXIvORgbfUz8zSRt91PaHswS8Nim99qoPrxbFGivFGa
 t3sBWzLh1hbLbbtpVq6kgIZ12pB/NDG4vI1w63eM=
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> Confused by this comment, as we've discussed before several times that yo=
u were
> going to migrate the testing across to vfio-user instead of the legacy pr=
otocol,
> then remove the legacy protocol altogether.

John, just to double-check, we want the functional test to use the vfio-use=
r client
and use the x-remote object as the remote server, is that correct?

Thanks,
Jag=

