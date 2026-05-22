Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF7CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWnD-0005kB-EN; Fri, 22 May 2026 16:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wQWn9-0005jo-Ud
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:48:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wQWn6-00028p-A8
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:48:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MD0Um93753046; Fri, 22 May 2026 20:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pefLqp3RXEFRxB957v3arNie5zcjhbecLF3/Lhvr310=; b=
 h6U7gMxOwvxGHb06jPI6nyLMuE9kyMcIUXXSqoWgdxRuuyiXp5QxrmwS4Q2FnoUR
 uSGeyCHEMuX5fhL75iTsT0XlaGPfsnKGELwxx8PAiVeWorj98pXSareWBZHSFycd
 yut2pJwEfI9qkSml+RBb3mRHPl4XdRcKuigrHv6tcKG81Z1hGDMZR/LdccVSBl97
 tqgPZ0KKPfdhwBlFRjsO5by4+y5sYoGrz7R15L6b5YIHeepEZ40k3biLYBnI39Ez
 oVRuAVBcEA2AqYax6Lhk0+SGao9L7POD2AeHMX1TRrz4uDsAnWyI55BJk4zNgGQr
 G8Gq8OG27SJgIqhbzfhMKA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t3jmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:48:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64MKe1pP033400; Fri, 22 May 2026 20:48:07 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4e6f1m90mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:48:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTkx8NKiyQDiDSVUGaPWxjB9gB3KN0hrw6WmvQnO/y5LgW26D+ywK/KqBHh6BegebwZ6BmyF/kGsITPFmKrg+kPnR69LdCkJcbH5WkMylg44SGj+d5iTol9g8zxqlPa6wNWkPR9AHWyaanO4TsOObh6+8DfqWC4NBJYgLkvK59k4/+kaCiIUT/6VbYTl7xNyU/6dJxL+sytiZGspc5ukTSisDat2PLU4wy6ioTad35Gy4WKdyskTJ1EwyCtxcVK4H7jyTXgET6ztVhRYRs9TZUZOG2Q/w+J4f0Rg+G1Rs5FUCmDkWndm1pcaJFkQL2d2us9CZkLNr//PS0m1/ZfsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pefLqp3RXEFRxB957v3arNie5zcjhbecLF3/Lhvr310=;
 b=KNn+zWeQ/caoQ98GKoY4d1IQwQuz4weSZKy8PUFOv3tp/eO9N3w7Cgmlmozv6X/wiyHWnQl0SCwq8NF7a6tfz1mPb14mD3EvmN7rGxQ6AXvz5zQr/oCdumm2ukksf7Kb46XiarVAoCTaRaC9rcKsK6GuOa1DtTxypnnanuMET/ILeTppgcvohYEuE17Xvm98731AjqggR4RNuzC9aw1l7IPOtJNWwP/lVywZ6u/mw3uBKa8PYh2xkKRJkfMHkKbZu5Sxxlvj/V4+674agq8zcgEDZ8n61OLG5vutrqbTI9hystCPXvDAJb9jlCLKyyOQhjbbZCYORiscMxWuLneb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pefLqp3RXEFRxB957v3arNie5zcjhbecLF3/Lhvr310=;
 b=LECzJTE+C6a8Qw33rco6Y5UrTHn3nMaRIZEFxKZjK5uZxBelJ/PiuPWFSOeVxs6PF9fym8OZe6ASerCORmO7U3d7ASGRNdKP3WNerHZh5mewMJEli3XwL2TFjJxkCMUjVkJpJTYFOvKivUBmP9DaRzQvM4CdHLWS0TIC1iHNsEI=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by MN6PR10MB8045.namprd10.prod.outlook.com (2603:10b6:208:4fb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 20:48:04 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 20:48:04 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWmgAACZwCAAAE6WIAAAVgA///FPgCAAEZ0AIAWXFkA
Date: Fri, 22 May 2026 20:48:03 +0000
Message-ID: <FFB3F5F9-4F32-4836-B71B-35899536E5A4@oracle.com>
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
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|MN6PR10MB8045:EE_
x-ms-office365-filtering-correlation-id: 1084ce65-7678-4c68-a8e2-08deb8436b91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|4143699003|56012099003;
x-microsoft-antispam-message-info: e8CzzZ4CH65mvRLFxsD18r8++DY64iHDZBBMUF+0naF+YVHBB0X/v+nuxqI1Z52gYyUOHH545nS0H/FidM82guODp9yHqUMyKImMuk5kLUllHzyvshxFzOoYYl9/2jW1gHtIcsv+Q7SvfYN9uWWXiRQBb+MsCQVhXs/eKAMcBl/4Vr1YjiKRmqStUbNMBMOzDnN8xxfw8abHKXbO97TYyKcWimlhQ1E8QWqT4kr+kIZPV7T7jqx7BpRATqAY4T49eiVTNwHq6u8eiX55SY8sSehtvb2wG7BS3/YODHDwHp5PjU1sxPg8he8/CEvFeMUKib/8Yy4Hqtd27piDZCBpDLuX9uqzHgwlNa5oT3MdV7cfy873su4tsvmbz57DoMUKHIeNzyIDOpXQEP2Fk0C2XBvKmLl5wUVJ2BeQAZcz+MKPMPEaCj5Q9z6EtOnC43v9pFey+dJERHr3v4ajrLDgY7ANVzMEarCDqKRlmQ/WOV3hNK8FmVfooBVjKKzLcTSNjPE6g8VTM+qJoI5yczgjA2z9SNKXera56ptH6Fx8wfdFlaNAz0UrcPZUBrEpJNw+2V7lNzGP0ctx/X1PVXklsSYzoHrkW6HWY/lB7kDLyi0aAAlVUpTx91Xb8qnDDP1mMRiBnHMXCBZENJzevs2u9dJZwKN/FhTvLvIJ8Wgx05VXIh+8KKdpwRPoCQauCqt10dSsoXuXpGhCCg/DhlXCDOtaYOyF5otrswN6pwhPbmGGVlDmmMG0xCpmAbzKt1KL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TJzVzqTOEz2gFjm5zx5hFJqvQPD8WwklpP7bY5x9nY+HVmh8kvJ7mciCOc+k?=
 =?us-ascii?Q?h6+MWddEXZeWtNZK2ttcpyPR5yssENx0A6zg5lAWIN+KuOAJi4pMdb51+pwa?=
 =?us-ascii?Q?uVryJ2lH58AJNwhElc2QooafK0Zp5XgfLdbNU+0wm7NNITLPWDIt/1VqOvvN?=
 =?us-ascii?Q?HPapsz8nCSPvZoIE1CgMKHBR/MBz/aYuwc8cI88wV4/dzVKobM5b3URRbU2v?=
 =?us-ascii?Q?cz68h4wzPklOF7DKH8tq+t0U3K1rjT0W7vKxHKHtN6DfIl+dqShGhP1yLQ9I?=
 =?us-ascii?Q?z9gYBL2bH9XJbKcWEBEwYxqD1ccbSBfIRg1555bUOcYJgKJHu7NzEcJB5pZ5?=
 =?us-ascii?Q?Ok2bubRA6XzU2059q31z6JcI/YQa13+WNri7Bp8ibhegXmiMZV5PZG/bzwIF?=
 =?us-ascii?Q?xkHUoevomOLSLRAIdZKPYmKNL6e+qob6yofyzN70j4viMVuOBCa3+FNHJVQ0?=
 =?us-ascii?Q?MRMA8vCVmMDMtPsAwe7xa6CfZoaCCn4Q6yxhpywJSMRu6humUDP5TQzS3i8A?=
 =?us-ascii?Q?C1qGS8EdVcL97Cc5C6NWOR/QPgcrqW+8X6KvX5MraJN0hZQKFc2SSiIiGrjg?=
 =?us-ascii?Q?8jX7jEJBKvCkkJI0xdaDnI2vfNaBptLBCleAeaCc7TIRcpzmmgWKFoeHAlcm?=
 =?us-ascii?Q?0VpkAAPVbpLZS0b9t5MtM70npiYPfIQBT2PsbxHxjlvqficm/DpLJ7rtFH+k?=
 =?us-ascii?Q?8GbI3KKxOdxqXlp/UeWfkGMzEEn7kydtSttepwLaWStoDRInAEP8OGL05K/B?=
 =?us-ascii?Q?8MO/yehzUklwkDNFnNMp28mBonbIzpcChwJDRMhQKcY7l3IXAjmGsBGd8Cqc?=
 =?us-ascii?Q?xe8IuRp70bhxYmRTnFyYbOb6f0yLqY1F/waqriGwPqOpCc0IcckaBsoI1bUP?=
 =?us-ascii?Q?XW0JbmhNbgl85Ud96rEz4oaV3DcIA+Uprn4HzEY7YOkLXGoUd37lnLQrvjU9?=
 =?us-ascii?Q?E8OflIeESjNKIBJndq98A9sywVF5sU6tPKoBnrTohv9zJJgWNEDsUtBJk5mH?=
 =?us-ascii?Q?nr7RA0albBZ1aGR1C2N8eFwD1wP/raVa6/9Sm10zOTY5q/syJAXyo1mCPw6F?=
 =?us-ascii?Q?X6uOAHYkLZTdMP6kWF+Vnt8fpgj2Hu35B8MJfoMlj2pRtmAKxeXCuLjjjHQ0?=
 =?us-ascii?Q?nAjjjRkkTlWbp4x/6jhUWks+D9NR3HHGJfZaMsmp4zxnDjsXIwxSiy7PsIgj?=
 =?us-ascii?Q?De44dylsx/TNfC/afUajb1OfUMmJ6b4hav4jkfNjFxsHUex8QHfbxXYgEran?=
 =?us-ascii?Q?EQcDoqjgc1JaNmLX1cA1rzyJLC62IMGtIzj5hAead7MiK7U0CoyeqlE7OAxy?=
 =?us-ascii?Q?QIvuBdzgsLHKH/h3txm5It6f4PdmMhsTgy7h0/avi6k5audfpz9q4DmkZUqk?=
 =?us-ascii?Q?4TZi7rh+qkgAPmIpEH5wEqHdCTbkJuE+PfpXUo0BqfBTdCXQ98LIM2xlJAyF?=
 =?us-ascii?Q?1SN6TJLYgiQyzMQjLPw6c2F35hfKAKmCGxcnEbPwprvzORW0yAjx9DPpXyvX?=
 =?us-ascii?Q?qZxLp+7zph+ORg/nz8SKthuk2tbvoDStR4JiMEH+rd450xY4vJ3nJ8SCFtxm?=
 =?us-ascii?Q?vhoxpvfjhUjB1WwZToHjNgHFp3R2zkCSf8AcmwiPI0S0WlVWW8oMj66dGSxf?=
 =?us-ascii?Q?U1qlgrwqmLDbvPllQVwZbHMl3OA8lNJw43WLtRLlz+ODNrORQ+PHh14z55RN?=
 =?us-ascii?Q?DC/yfKgSB1FXEbilbHw0R650GLOOps3w8ul8BS1lkwbI3acWz/c6QRrKORxB?=
 =?us-ascii?Q?LJGF8L822g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B438E88B28070241ACA5ACB05B1739BD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KaEJYnRLmU9dIHOevsbnoEst2LVARbA6zpBlUXKs04TDUsqtu66yrQ3RSLoInbqlc2gvJ+b2c1aUAUS7zjubLv8yAm/E3vgC/0A2qkYuLsaF/GWgnKVufOIl5bCSEYjlKbJMm4VhF7cWCc9K1IvTh6ZA806RLEoFDNnbcPA42Oc2i4IfhBUI+9RxxKXulpgoJjV4GlofYmsxrSIABLIfZJiMAyrAvzIaOUbl5n7zJiX6QDHKsKElhmZCXSC2EreHwSjan1RbA9GFS9oSjMNP8kCkDbS+sAblGogdgas76Em+jY0nYTTCMn8RG5sTQRLXHM+XIsi4ksNgEfsAGMp1YQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eawbEr2uPZT1UJ9IopHv90qKqJbXh9fr1GzHdyW+L2gLro7Fu+2k+7Q/zm5y8ZZJ7VYxtNhVMfjoHBcZ3QY+d4b4Rsu1fBY3XyFC8ZBmTpaKqO3MTG2cogBASsCbeq/5Tqb7A/YdiOnNycj5UHuobxTqHNZQbt4mz4vf3M/fU38bc8VxU65r/bU/oNWYJTdvQ4uK+gMgpGXTIcexPWCXcksN7qjaO1vUZViDh+HBXPUtPB+nq6R4N/eewcJAjDvwSIHtFiYk0NP5CSZQNc1ADFfq5wkfjM2u8TUEuY8kmtX2u4p0qUrK79CC28aMsqeS8cdWkyhKQvnTQQ3fQxLWlbl3AebFQm6jof6JSCP/DE5RgWkw+NcZxwAJysW2+rEm6lzX/IUrmAfTlHGrmxoo+tJCrMhNjf2Ilpf+S3KvEplxpV3AS68/yhod4WGEV7kR2pdLOp4qycBg86DIrP1b7CgFtAF7alt9tLqAljSP2pgpf2agWisP10SF70gmKAaQ+Ho8EFYEm2hw76PASRducyoynncqDSKa5QDnbJnyqhQWfV3mtbp/5bHTvPdaIXrgDPY8Zf64U3J7uFHVajqNgYylU9Wn1y1pWJ+NKi+CKg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1084ce65-7678-4c68-a8e2-08deb8436b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 20:48:04.0000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fq5MNB2uI/sFoXI076hS1l3vN5mgadq52Fo5i/c8+lV0Hhn/KqkwwG/2XvX5BeZDHMxKT/q0HBP0oAazt30lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=773
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605220206
X-Proofpoint-ORIG-GUID: j1sV41gitOkm35hk2U1c61dfXvfuqGdX
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a10c108 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=iQppIs3cMkGle3i62iUA:9 a=CjuIK1q_8ugA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12300
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwNiBTYWx0ZWRfX64/of0kuBlpT
 MQayw0tA4OaHTApTWc4i0OQTc7QfMXKj3BmjmvDITCqwbw2iR/8avLUrGzFD0Rg2DZBPg9FxC8F
 bpb00g8pTuQMgxkRVk4FM1AE69wScY6k7TYh4mOx8vyTc8deRgfS9iFjQZ8Y8GA1Ztg8SBnFfhh
 r8/D5nZFeNTN3ry/aauJGN1Pvo8zFvV2k8LuoZIN0kQFuGmKp/UCTH5u7OBSWKm2zhY0QyOoZIM
 jFmMHgRlWozzAB9/SuO91cHCz3hGVN4E3B9SRie44hM6Lbwl2kkrcxVTUmkuQQew5gFs4IUA0O3
 AURhdTfxaowswMQQnVai0rojJeGjWt+7dmQnhWrNffy+dGB1h25gXJDuC1+eLrNtiYimUlahTUo
 oMcq5f/W/A0tt9l/g4D1AUc+SznK3oSM8VZHpGHaVeEFoUAn1Jr68kVt7OxuZlT1cBW3DPsgMCG
 tEI2wcCs0gvsFX1X+3PQGYSzq/7tN4SRZ7/cdOXo=
X-Proofpoint-GUID: j1sV41gitOkm35hk2U1c61dfXvfuqGdX
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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


>=20
> 3) if we don't see any further work on converting mpqemu over to vfio-use=
r
> properly over, say, the next calendar year, then remove the whole feature=
.

To switch the functional test to use vfio-user, we need to enable the x-vfi=
o-user-server object by default using --enable-vfio-user-server. Is that OK=
?=

