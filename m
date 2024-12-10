Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302E8E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 21:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL7d6-0005Ir-QL; Tue, 10 Dec 2024 16:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tL7d4-0005IZ-AW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:18:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tL7d2-0005p7-B8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 16:18:50 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJJKpW019141;
 Tue, 10 Dec 2024 21:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=EVqXUKzUyMlpwvAraB/0+dfJcUWn/iZahXOUrIBJ3Vk=; b=
 GhVIibjxvn9iuNC2Oa02emA3AkW5ne0YBjB6/Q/vAbZhX6zWF0/kYYb18XHtfCHu
 M8B0XMuE0v7o2siEsxN9W+yjcrs9XVeqYVvDWLZR4HnX18Gc84/+SIcm4YbPID1H
 atdsuw6B5dN7xaOZev/mHVsjE32cLeffflUWsoq6DpkVSuIJDHVtprkdq1hPb+vR
 BvAdphOEKDaJu/FTrQ1NXR1gg7EE/yTkaupMn30+P7fhdvA9Y6+gvKDmTJALT4qF
 Y2f0hFI/3PLj1xG8kfBouIGEFYQw7DVo+NjJVJMOmnYL6tTVHTlyD3X8p4eK7D4j
 ofkM6KdlHHo5QVI1xuN4Mg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt70ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 21:18:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BAJo7rc020591; Tue, 10 Dec 2024 21:18:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cct8vemp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 21:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJtTCdwOaoaVOtHf0Ds/cnsVfuG7AiQnx9/joa3PjwsTwQ6xuctYMFHAdQdrgsUP/rOBYhQz1Dq4AQ3GVwfnQHXn5XR2cCPJiTL4G6mOvoo1SBJp8TJ+ylvylD9MLhPp5ZbKTfuhGbW8gEGuB6BRKt1Gx9Z4vTXHW0Z4DkM7vSfhvbV/hdcww+Sv3mMVl/YywSnmI0plMsWhPbBRD1fm4WqN1TB6U5IgUhTE03FLHZ1VS2gd/cVumAyMTRy0mR2GRQ0mk0cV6iuhUfElLYbO8qohqkZ/shWZtd974bO19LLgQBmqrf4NuxT2EAmUsltXQ0k1R+wjnHuKaiBFKzWjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVqXUKzUyMlpwvAraB/0+dfJcUWn/iZahXOUrIBJ3Vk=;
 b=tmipFGKeBr6QSKueiEWiWdkydoWCjR2cUKgCkc9m09kgvz/bZlJFnvoq1FcSjzX+nMAL0v3nLFnNG49mkLVV9SCGNPOsJghUGSXScQgFDm/xl+E8ybBVRoWnS/FNoVrhFZtX/u2LwiPKSj0LPRJnxF9H+dobd4ZNw81ScyfinzbA0kpEu3EJD2FZKhRAfb6fQwK2BC5FYBnOSrgYZfRIRtwYH10YKx2mc5jcRZdKkv3YzaYFXxXQCYSvoBV2AyER50ZXRQUtfw5pT7OF8ZQqoycDf4A3uG9hs7LkLEHqlZYE2u6mXbD8wzcwVDNaYZKEBZrLRWqBncTA8/HSaeOeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVqXUKzUyMlpwvAraB/0+dfJcUWn/iZahXOUrIBJ3Vk=;
 b=md2DL8wEVNmkFPgm9PZJLZx/mW9qyuifTvP1sCMdJM9cp6U5ELWFjkjFUvtsI5q6HEIhWfI+Z/z4gMKF8ojG1lF0KstIE9xKQ0q7yw82/u9vwE44Ep0UKdjbj5dRMPRzucy9O1gATis+CEsQn4ApEw21YKHM6l2g9ZhUrnn/2zY=
Received: from MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8)
 by CYYPR10MB7607.namprd10.prod.outlook.com (2603:10b6:930:bf::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 21:18:42 +0000
Received: from MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9]) by MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 21:18:41 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 0/3] cpuhp: ensure that cpu hotremove works the 1st time
Thread-Topic: [PATCH 0/3] cpuhp: ensure that cpu hotremove works the 1st time
Thread-Index: AQHbS0kW1rScowda9E6LXPBRR5xyvw==
Date: Tue, 10 Dec 2024 21:18:41 +0000
Message-ID: <MN2PR10MB42695BDC3BF1DE5E62FDFA448C3D2@MN2PR10MB4269.namprd10.prod.outlook.com>
References: <20241210163945.3422623-1-imammedo@redhat.com>
In-Reply-To: <20241210163945.3422623-1-imammedo@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4269:EE_|CYYPR10MB7607:EE_
x-ms-office365-filtering-correlation-id: 90a17d73-7f29-497f-1dd0-08dd196038ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hpEwJ6YpP+UdQI1kSuFXasgm0PlSC+VqhwFdfyEyyLYTcd+vU07NjRMqCe?=
 =?iso-8859-1?Q?oVeKMgcjQCM8EztL02wQRmLrZQh0SafB4GWNsx6YWTerUZp+ovPLPIMOh8?=
 =?iso-8859-1?Q?W7Nwtka885a1qJBIOhxXea08Ac4phwtrOqym/VAKeLmSlK3SdMS8rO6Txo?=
 =?iso-8859-1?Q?eqtv5kSVQv8uw6ym/vaYwvK+mpu2F0fsexqRfVxNDp9IEDvxl/jaPGYrxD?=
 =?iso-8859-1?Q?wehdx1MxQl/dgkVy3ER4gLq8VqoMdpYbTXx5yg+tuYzegmkjq5ftq9ORw5?=
 =?iso-8859-1?Q?w7hM2+wyqeE24hlqhxiowJ+WUK7zmSHHL7BMRrU7MdF6aXqt4jd0kuktTh?=
 =?iso-8859-1?Q?MDulNLE9M0I1ICMImUN4ByDKVjDdtaS4oBI0P7wwwGTVo/SxdL6m9x2b/L?=
 =?iso-8859-1?Q?R8OgPWm+WzKsLJ39B2ALoZeLofdrfT2iEcig8DHcRGX/YhPjQ3OMmO9tUt?=
 =?iso-8859-1?Q?jTtsUUUswBL6/s4ADsE8GbWivHgm6XduqTFANXxv1fy0QpZ5GrKxfqb99I?=
 =?iso-8859-1?Q?Xb8WRBWPn72K2BTfWbrG6k6RoLXbRKvfT2jFme4TxDz1ejCtLp6z3gdPBW?=
 =?iso-8859-1?Q?/rGwVc8ZKs+vLAMdFqzfbrz6aj887bf4+wnOVeWD4I/LTPvARODB7TmRTI?=
 =?iso-8859-1?Q?kX3JbFp0xXFTy5yJjSuX+/PT+GZIBF16kfYBFvoR9+WjRaU7u05uftQvpQ?=
 =?iso-8859-1?Q?vdUrc7a7GxsESEJKcFuIWRcTlVa+aIQ/Rfmub3GGayN+b3ERAsSd7mef1k?=
 =?iso-8859-1?Q?5ZxsZfMlGw/4IbiQzL33ar1lpAClVPIYz4uUaS3mkoDLfKjknsYxD1MOFy?=
 =?iso-8859-1?Q?seMEmY8yjl6b8PqrcwP+comWoV/O5P6adcL4wdj96WOPvKSwzaaUvvAEqc?=
 =?iso-8859-1?Q?9dlwEBfdRYErY7q0y1BRfniH2vDixd0xneo2MUL5gbKPy7EOT/E+jt2fJQ?=
 =?iso-8859-1?Q?FabfOxEN+wLrWlWWVO/3ChuiCUr0qGCLfxBcfCBHygtKJVtTGnPOPlZbhL?=
 =?iso-8859-1?Q?+HJ+pw63+j/mCHAMGWuHp2keLBYQYPb8lqwZLsQv78dLWnNstNSj+myvJ3?=
 =?iso-8859-1?Q?dZ/jFoDxrw9hWu/vKxZXDOwAUDyPvb3TNeJEFgwByZoeDsw/ewTkGZUpFP?=
 =?iso-8859-1?Q?O9sXm10SpKQr3rUhj+KmLd6XAYFedG8kideFJZkaaFcDShCAEN6iZq9UCv?=
 =?iso-8859-1?Q?CUbQIiDEWKMEkRrTrWVAnwdOpeesJfvlzbPgQdIxQi7fLlc7RtLTqDx+WA?=
 =?iso-8859-1?Q?eqI2WL+Zmck1mv0E/3hLzuVRNOhp9q/std3TnBxJThHmUV6K6E99qhXgFe?=
 =?iso-8859-1?Q?ZjZliygxPxMiWjeNPjS9zQlrGLp8UuQvje9Acz4pHPuAyTBNZlmsoV63vM?=
 =?iso-8859-1?Q?lf289CbqRMvcdOWZsABms3TdIJxyDQ7+jnN5bJV4RTDSI3sDco0ZbPr2iK?=
 =?iso-8859-1?Q?TZx5je00hD962ZMCyo5D+Nszp7yxnSZm1maGIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4269.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DsN8mU8VVofYqhWySl1obQvyB3HEJHR2lY3JMGsF5893cA37gKKvfV4rgs?=
 =?iso-8859-1?Q?OGFxm+3Zh0YaI3vG3qy48HuNggbWGxJR4cXYicbMTWAbVaFyBKh+AENmcr?=
 =?iso-8859-1?Q?Vqf99/smUpz8gHwnwrXbqa3mhghgBnFUGtbd3sVOvKHDhZZKbRxp+TkmnT?=
 =?iso-8859-1?Q?KXIEQXuYYtQ4m5J4OdWmjVh+jcqy71E7VF6gg1JKN8PYV4Vp10buYagbgK?=
 =?iso-8859-1?Q?abBeWWnXQTlibGLrn2vrF7s4buLtFXsjm/ChL81XcUrPf4w2OCyQZmS/Zp?=
 =?iso-8859-1?Q?KWyQbdBAGgKWs8sSCNGRFz+uWn8gDhkYdYCCMSnQf0LoKx/YrF2/7eujsY?=
 =?iso-8859-1?Q?fkLYCzSSRyrPhD7BQYEiuadRaljWP5Qyr0cUvc5eLJx3lT2clkiMGdo38y?=
 =?iso-8859-1?Q?4SIRYgrKDNAdfxFzXJpdtmuJjCLlpv074ic1QBqOznUKo2X78vjxCUtlRS?=
 =?iso-8859-1?Q?5sT6ZBR46ExKUQSvZaUUuDJiqW1kShCPJTmPsN0cN7hEuXa8dTOApiqhiv?=
 =?iso-8859-1?Q?jrniaqD6Nwao3U2hlOTzu4AfqmqMoxffcXuF97q2vQBbmleecEyZAlm31D?=
 =?iso-8859-1?Q?ixRTxEkikiB1kquiOV6N0iFsdgH/qCzxr7Ga2f/LpN5xFdcIdkVfBrxbuI?=
 =?iso-8859-1?Q?1sZ1cdfoJRio8uMn1Ohxdd8Odj8ahb/s5sKqEFByMoApr+G5lqpsI8e4Qg?=
 =?iso-8859-1?Q?WXhOhx3qLEKr9T4BbKr2n2VrW0k3Ik802qHIMondpalxcTq8sS6PNselrn?=
 =?iso-8859-1?Q?OIrv46uYfcaDuzBuhEE5My2flgKM00qx4WYfLxuoOkjdUNFgMMkTqOs95s?=
 =?iso-8859-1?Q?4eqHXpGaIBLh5dvR/+ZfiCcL2BGJOWvBH9xf36JchyGqflxL554itXSNtb?=
 =?iso-8859-1?Q?bZo2+7VysA6ukhzyPJSBxNyPCiCrqt1IzCVOFslnMeQrEfUvmwLmAdoeGQ?=
 =?iso-8859-1?Q?Yg7MSJDorBvJ8zHQnPsgyu2IugJcA32RTJKnrHzfOgX7NILDcXrQ92twk7?=
 =?iso-8859-1?Q?+P8rXeGzKTgfpFe4eo8z7UAzmMR7vWhDlve+ur+dkzrlnYXAmYtdUpNjgJ?=
 =?iso-8859-1?Q?kIm4+0dlnFL6lpvjSIeeNWvGF0kYeQAQD5lEuZ336HFxxkbdpCOXsfd6ls?=
 =?iso-8859-1?Q?OJ/IbR2K0xqYE1gy4zuR/N4z1wwaNC6Ggcv/qhL6DmZjYe3NCFC0r4JL/D?=
 =?iso-8859-1?Q?9ZTi4YN65w4eONjGNnbjLxaOsEF7krvB31dXbz/m/Cxet6rinYZZI6rtZA?=
 =?iso-8859-1?Q?q9NRxErIaEH7ZAEYjwjK0r5s0Op46t+AF9JTGNr75Fseh1ok1YPWktPQVh?=
 =?iso-8859-1?Q?R/mDS/m1zeZG6INKjWQ8Ec4F0vnqma7++wEfqEgwJJCf3MgJmFaUm+H6MS?=
 =?iso-8859-1?Q?KfJ99hWgcAP+4Gw4bx9Az0YHZ/g4MWXJNGiftE5LpciT4yfa1pbGHgHnYM?=
 =?iso-8859-1?Q?zKPA0LLJYnUvwLZgI58juANNhi5/zqIVHfnYQUQS+V6LBpdJ5sTscX5DVU?=
 =?iso-8859-1?Q?XgPePVA8jMuYgTb3h4VYgaJDZgnRR4X/pZj6AFjOeREo6XRr4AjTtcX87M?=
 =?iso-8859-1?Q?wc58o6yPsYxB6EMras0NTgaTBjnpPsMzWI8HCzqvpYwlH3JCjrFdXHRNCb?=
 =?iso-8859-1?Q?h/x51MR4q7NjnbopC0PanNOo0Fnjy21UY2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BqTsCktnuxInQuKXuau8hHIvRs9a33Hlqrcl5+5q4PCNCGFL5JGb7W0Pt4POwzU/dsptk1pHHFR26cj9u38r5C4YpddrXCJAiAK2cfKUbBsR1GDHK2xO4WeTQmQxDOwoXePSLT+PZkki8eUHA5szkpr9tXZdnYnbgHgHSQnoVQhxgvFgf0ytazfoGs5fYeh6eX1iKJD0y9HwEtNN5FVLv2/nw/UmpFZT3gqQqaW3LMBPuWTuFPjrIw1owmwYEqF54ehMFppilQpgdMNRe2BD9xFtuVCFhRAJ82At2T5w1Z04mbPBl8k1YknPq1wbS42NANDcFeHW9JEBFQ/ppkewvGa9Wbg2bS4ZkfQElTnhYuRXryxNx9/XRuI7TTwT+w9YJCpB7etvaeHBr/X+3lQVhNJTCFb3hmnvvEFEZdom5bsyJ04cQVL9Koo/4VMoIemKAkeUMFhb53K0Fwxh1kkXhMPGxvZKHLNV5s9PS8IHME4umG9K7k4gz3GB027KB83zZ/iSjRU572q5iOXPCspzsu/Yzp4qaZXXoIUakmWvRjz92Wm5C0GvevZQMUcli4yAw5hYgGpkD1mJJkHZWIzmzpx6qe+lO3VvOGjEuPke7/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4269.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a17d73-7f29-497f-1dd0-08dd196038ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 21:18:41.9149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7XwzqySZMGe+jCajVslVZrridublgHQtA5fNM+Uz57WJmTvk+kiCZ3boWj/atPJ2TL1mC9I4zKFRP3ND3qjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_12,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100154
X-Proofpoint-ORIG-GUID: K9Ed1YT7sthJiZy_M9bDc4Wbtyjb0RKs
X-Proofpoint-GUID: K9Ed1YT7sthJiZy_M9bDc4Wbtyjb0RKs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=eric.mackay@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I tested your patch series, and I can confirm it fixes our bug repro case (=
not involving the guest kernel).=0A=
Thank you=0A=
=0A=
On Tue, 10 Dec 2024 17:39:42 +0100=0A=
Igor Mammedov <imammedo@redhat.com> wrote:=0A=
=0A=
> CPU hotremove event is not delivered to OSPM if the CPU=0A=
> has been hotplugged before OS has booted.=0A=
> For details see [2/3].=0A=
> =0A=
> Igor Mammedov (3):=0A=
>   tests: acpi: whitelist expected blobs=0A=
>   cpuhp: make sure that remove events are handled within the same SCI=0A=
>   tests: acpi: update expected blobs=0A=
> =0A=
>  hw/acpi/cpu.c                                 |  43 ++++++++++++++----=
=0A=
>  tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8593 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8504 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9918 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15464 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9057 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10247 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8544 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5033 -> 5100 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8665 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9952 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8451 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8599 bytes=
=0A=
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12386 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8422 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8439 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9747 bytes=
=0A=
>  .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12632 bytes=
=0A=
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8701 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8468 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12035 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12980 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33837 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8886 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13213 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10076 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8497 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8510 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8439 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9781 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9552 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13275 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8302 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8280 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8428 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8523 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12980 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33837 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9028 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9054 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18656 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14679 bytes=
=0A=
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35785 bytes=
=0A=
>  43 files changed, 34 insertions(+), 9 deletions(-)=0A=
> =0A=
> -- =0A=
> 2.43.0=

