Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5790C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPh5-0004yC-W9; Wed, 26 Mar 2025 08:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51802bb3d1=louis-vincent.derian@st.com>)
 id 1txMyA-0003fP-Cl
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:22:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51802bb3d1=louis-vincent.derian@st.com>)
 id 1txMy7-00029a-Vv
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:22:41 -0400
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q7YPbn019497
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 10:22:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 STMicroelectronics; bh=lo0pIADOxTObSjWOER6nPYTv8gC6fuIpTYAHiD98j
 TU=; b=yDPzxQdB6WBjUKHTaUCWBjpDgTstP2DsDDEIKT4J7bKC3YZRDF3jfzANJ
 fC5W1hb7w0MDtY44mWAho7sg+7SCfZ9BXjaMZwLCCyB1jxsM8xoiWM0v3G5Ltsba
 Gvz4yjY9Gjpsx3u//v2CwfSkqCVUg1tisyM171I8dYXcHgcaAXRj1qw3H8PNyM1h
 4xRNptxI2JIBtQQoakKQqNWc357YS6r2caJH9Xyb733PpBolCNhTiXzSYh2DtWUl
 paT1UQDGomDhDkD7jFclzBvtQNPVcp1wzQDruPkvQTsT8OEqs0s4AcpD3Dpn14tw
 eOFgqv5Jtaj7VMzKbCbax3lJl8Ryg==
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazlp17012026.outbound.protection.outlook.com [40.93.64.26])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45j91seeeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 10:22:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmuEp6hVoDOH2U57LmX9q5S3WHeqoCXgDvRdjpVRlmabkhVuCWhFBoDlLZWudE8qUAwRxHMbsKhjRb8zS5jwGRfShNCkU4bIPcua0EVTUmJKfTzkwH717JDVHiFdvcnjJnltnoNN76Ii6thsZyfJQmrVTWvSQeKgHPud8JS1sJuPef2xr13bef6fY0fydKr2NnLklgVtp4OpAscNWmNBdO6DKd51hwqxTMRaMRXQnNrhmm1+N1hUnlWjdbgaZNE/2ADRL72ZgwBrZn3nleuTc2hoLW1lQwF7+/MATh3e5bTLGCcZl1w15ptFc8pzhLOkVtbBmwZGWcr54jQjIeKXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo0pIADOxTObSjWOER6nPYTv8gC6fuIpTYAHiD98jTU=;
 b=uDrJT8HmYzBjlSbhgT5RYdBXiF1CK6BV1ApzsEEpeGCoSToJgAkvzOaR54YQfA0REKXvFv78/V+SfNWq0V0EiEs0r2a4HU2U5pwGElzX/mzcGEY39Cb7W+xCM8APokTVMK8IrgyhynxR3xwlxRZ7YRVseMxxsZvK4CB4PZIh/PKky7ACF9XYMuIAhhhlp8LEVzPCjh8QOFE8L5m8l8rm6jCYIFivvPQaIywh56jfc9+dl5Ajj+3rg7ebbKPgB7z3v1I0gED/oMhEyGKbFLQ1z0yXm75AmubepSV7HPJIp0zGwCG48b7/SlSpWrvXGGl+MBI4jTgNUo7Y4AcmBPjmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::11)
 by AS2PR10MB7903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 09:22:31 +0000
Received: from VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3490:f52e:112f:9dfc]) by VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3490:f52e:112f:9dfc%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 09:22:30 +0000
From: Louis-Vincent DERIAN <louis-vincent.derian@st.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Vincent BEUNARDEAU <vincent.beunardeau@st.com>, Nelson Petit TAMBA
 <nelsonpetit.tamba@st.com>, Francois PENALOSA <francois.penalosa@st.com>
Subject: Inquiry About ISO 26262 Certification for QEMU Software
Thread-Topic: Inquiry About ISO 26262 Certification for QEMU Software
Thread-Index: AdueMEZFExG0o3iwT5q7XsZuAqdk9Q==
Date: Wed, 26 Mar 2025 09:22:30 +0000
Message-ID: <VI1PR10MB367772124137F1672AA1F58DA5A62@VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=19de7918-fbcf-49ab-818c-6be77f206ea0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Privileged;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2025-03-26T09:22:29Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Tag=10, 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR10MB3677:EE_|AS2PR10MB7903:EE_
x-ms-office365-filtering-correlation-id: b52c08e1-4985-4771-aeeb-08dd6c47bbe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|3613699012|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?U5tCumqP5AzVS0nF8aSw6VcFHLsmDzN6vssyYZHDlHhpu4FWSM2AngfOWCE7?=
 =?us-ascii?Q?vSYCwLrrkwtA2eamRkLzdzZVcv+Rnv+q+2hYLgae6vUaV8x4yCHa3TexbAJs?=
 =?us-ascii?Q?6hBqtGSFiiGHj6To+EdfQaJ+YvA+JjYqQ87Q0VvhHYUfUg1HaoUo8BM15UEV?=
 =?us-ascii?Q?zXuvPvmKG+5UvlvG2gWjY+wqqEz8bSqaojSY+BvYVtWiKEjWISJWACLVjZwy?=
 =?us-ascii?Q?v6fMWVJ2Lns5KASliMkdtuBjAeN8SBybetBSv+OwjtPcYmcn8LHb9vZMFNuD?=
 =?us-ascii?Q?AxZdXWHAZ/lmZlj42x5i+U3GNIo6b80QiAhRi8PXMFghUuZ+sn40yjvTZ8Ed?=
 =?us-ascii?Q?h3DtQg/Lp0euLnKM2EtVduMXDKqSR0dLcYpY7mqf9xuiinu1tjJIw7ODt/bX?=
 =?us-ascii?Q?kh6Rovk43gRqZY0tBZUcQu8jTviCTX/24HCJLAo3uox79nAOp22/ivIi0ngU?=
 =?us-ascii?Q?zDyFGpeuiK/aQ6Xk6VDGdLe9fJXKr79/rbLgQDcWUXryWIE/E5yTcO0rhj/0?=
 =?us-ascii?Q?+8RBq6tOnPfrKhLPqMJX05LvJtTRSNdlldgzfSVBr0Ky6FsYuGiYlkKeSRsT?=
 =?us-ascii?Q?HooXNBEOHRt5xRE13+33FLumanqKiiyKnFpIIER/7Li4WcfNklv6CrPChhY8?=
 =?us-ascii?Q?rIHJbN5KEnHlz+R3+YmStipnau3FdTdEPs77woGpz1ipArkISn3p6btI4Lx1?=
 =?us-ascii?Q?l6syY5hzepwjVBnNWXE2a+Qb4z+YIIDFdJWeNH5UED61ywhG/o6olmLnWul/?=
 =?us-ascii?Q?fkEblFlJCQGmvm+DyfY/5J0Gm5hshfUnswcu4pe4H6Vou6oOwMcGo8aVrIhu?=
 =?us-ascii?Q?7krs3u9PIKQk8M0ri2nDgGp4qY11NzxEr2ZNUrEba6y9tzPzvk1+gS2+ql95?=
 =?us-ascii?Q?1TXJWv27GYz50m8A7qWhI4OwckWxJ/a+QTs7gmsVGlLiNRwyAJW8iOCauNwF?=
 =?us-ascii?Q?jJ4+PqH1jdnifXi5+urgoi4LcM3LdpeL8uCpIanorr3KCl9keEtRIYqs3dEP?=
 =?us-ascii?Q?UHWlp0XmUvYzjxBBABrpyt7cH/K2yulbsOxi/JgsT/vdHwAXR5M3CW/RGjVf?=
 =?us-ascii?Q?X+iuJTdpYNIKepJg92PHmn8IAAGN5rgg4JD/nd0eHvnH0mBINg9dUlTaH0us?=
 =?us-ascii?Q?OdqxR8ydX/h61lWiAXFGKAoWVir9Pl+hFoBWnsJNz73nZAxzXOjxywdtkiTu?=
 =?us-ascii?Q?GrsBiYakxeJHBMLhjbWsjyjTtR5Xjw9Y188CiWtyeWL/xXrJlo6zB8GEGoNG?=
 =?us-ascii?Q?aZLJIsK2rLrCGot9YxiFJLs5HSoUvvpSZkB08OucRAvRyf3IaGn8t3dVdwgW?=
 =?us-ascii?Q?7I1mqBtulQ5ev+9liI+UjUudxNQzkgDxG2lL2i/Uupkj+nFxqh15y9VpYpS8?=
 =?us-ascii?Q?fBzAkFXlVT52e3cdYR9MzvcGrUIWHReVu+MP+QQ8p/WK0FRL6EX8sa3Cwgwn?=
 =?us-ascii?Q?NIOeHYemuwivGkQU2kTd5F/QS2LvdBsHO/nYknQ1U1vbAtT+SYOu7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(3613699012)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/rsQH/u1qmf26v+oBTot3Zudrpq80YDED0F8Niq8EwctULg+PccWt881UI1?=
 =?us-ascii?Q?H/VEjWJszEj0lOYltY6TYoCOvmVqBpsQEkcUUzkyH1AoxERMsLAIh2VlBGAN?=
 =?us-ascii?Q?K86m4gfMuKPIeo21RZWhoMRz4vfDFKzAaX/UtV4M1GLqwPHcjAxZhn6RVsw2?=
 =?us-ascii?Q?caTC8enCqFuCw892aSuSd7mxiKdOq59ZE+1N0O6G9jqQaKftGwulyX0yfkSv?=
 =?us-ascii?Q?RAUGdnjTJIrShUfKa9zQSnHJRKxV9/jb/c/9rNEMwXDryXcjg9db1EKSNJxo?=
 =?us-ascii?Q?iNOnX/dyn7dfRIDZXbpor8mSfjZwwMYggs4WHxKArX+E0obOKwTF41mMW5v9?=
 =?us-ascii?Q?zRMkPLbmtuADq64qPuihdFgEFvNQyR9pt37unviaowOStVFnRyk/8uabno/o?=
 =?us-ascii?Q?omijDeLp9isq7JRdWGbEUziNASZkbxI1RctGO+LpAj1r+TFOm0NgEMTQ5E8V?=
 =?us-ascii?Q?xjl1Doeu3llntvXNf8xagfw2KXIAwdl+9BTwTTu5vZ7+EU7QdAaZguysRgXZ?=
 =?us-ascii?Q?7WJYJTH7FLzchXKdvsbWr9sbGBTjuW/I+cMXA0/jWZVz9EKhDCWkz84YhMyJ?=
 =?us-ascii?Q?XFbRyziJJ4pUO8fXgBQix02eDHpPDJnJvmGupic4aumWHfBAhy0nUGeesogQ?=
 =?us-ascii?Q?tw3C+ZOa+3uDz5o6VwM+PvEACMa+tkxSVqPcnlS7snCTCkPHzrR0Bvk+qVA0?=
 =?us-ascii?Q?2A712INaYuot7qjVnsrA2hMsLw0+JmznchkcxnwxQ13syHS9xEllQdesesmM?=
 =?us-ascii?Q?Amvf+gX4P3OWHzu+bngC/lXf56lmaIddvQQTDGriuke1bumqsdYbAZBvmsko?=
 =?us-ascii?Q?qd8CjGzs4UeyWIQDxFcMykAKgCsMI7JGvgpRZnaQtvHlC8j6MM+98wylLZU6?=
 =?us-ascii?Q?HdW4TUQ4R9wJ2W2Em39kKXsZXeSJnfthik1OO8d/p1lkfPp77hJ/A8W/9ff8?=
 =?us-ascii?Q?nDFWOpmwN5EqaUt1kCcKcGpwHBKYfWqQDAJ6ybo7KOJoNvtXQkBKCQF3Z76P?=
 =?us-ascii?Q?KsW2pnkuEoLV3D6+6riBi0f1hcXKYMdolB6CbmW9+7iTIyJ1wGH7EHabNxUN?=
 =?us-ascii?Q?1k4Qe/rwBltlrIvJqbQc97489AbVODelVk8G2LPJv8HHG9w+IODEPSosmB/u?=
 =?us-ascii?Q?T42N+0TNHFXwHenljUoZ4PvCxZDASCZXUGP+AsqnHztZfJqJtdiHNfqfc5lr?=
 =?us-ascii?Q?Fb9/hlOz4huU0YXTHF1YI4kQiq9Ud7y9Bwg6yq3WLW+UXzWEXhqs55x5CXAz?=
 =?us-ascii?Q?IhzbvB/xO9xo5DEbrvkTgNri5PC8FQdySXv6ISuQVMXfPTsISoGbHOsOnRSi?=
 =?us-ascii?Q?1OncHjrEfU5JqHoRvYbas1ifio6dLBZ+kDQ+rssaDhW6/yKH0uZWQYgkggBX?=
 =?us-ascii?Q?Dul5e31QWfbqDm360nMLadRZ+zeWKkLGQ2uMZOGXyynUfEu48Uq53r6MR+u3?=
 =?us-ascii?Q?5jpxXmChBKb6TRe0+qzvoaxW9T4fVPiz957D0nS/mK0g04ZTZrciTkoqz/Xf?=
 =?us-ascii?Q?94bd74pPQD8IR+NTgijB5vt7KiBqWAheg7bqGjut0mUdxWFz9F6pNGNcfqMt?=
 =?us-ascii?Q?Vnm7aVFXplqGuzhRdZ9RRhAbm2kPZ2EER1gd94paocKBCb6Wj84Rv2bOcKuK?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_VI1PR10MB367772124137F1672AA1F58DA5A62VI1PR10MB3677EURP_"
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b52c08e1-4985-4771-aeeb-08dd6c47bbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 09:22:30.7453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coTs/IgA+Ds+rV/O06ckeV0OwaWTgT/yzS6etbdJtL7GJhGHBU188+VJzIqUJbo01n88HDazRncOO5V+IFmB3T24ME5vMcRiHZtObtCJoIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7903
X-Proofpoint-ORIG-GUID: g8URS935eoASJg5URmcgB09pKzBI6gWQ
X-Proofpoint-GUID: g8URS935eoASJg5URmcgB09pKzBI6gWQ
X-Authority-Analysis: v=2.4 cv=IooecK/g c=1 sm=1 tr=0 ts=67e3c75a cx=c_pps
 a=719hTBcD+nui0Lrnfyw6ng==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=FUbXzq8tPBIA:10 a=NaPKodZWmO3TErddyr0A:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=SnzeEgHfTsCzNEyqBrkA:9
 a=dic6gvCqUgM7a1Zz:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_02,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=642 phishscore=0 mlxscore=0
 impostorscore=0 suspectscore=0 clxscore=1031 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260056
Received-SPF: pass client-ip=91.207.212.93;
 envelope-from=prvs=51802bb3d1=louis-vincent.derian@st.com;
 helo=mx08-00178001.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Mar 2025 08:17:14 -0400
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

--_000_VI1PR10MB367772124137F1672AA1F58DA5A62VI1PR10MB3677EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is Louis-Vincent DERIAN, and I work for STMicroelectronics. We are =
interested in using your software to facilitate our development and testing=
 processes. However, we need to know if QEMU has ISO 26262 certification.
Could you please provide us with information about the ISO 26262 certificat=
ion of your software? If it is not certified, could you explain the reason?=
 Is it because certification is not required for this type of tool?

Thank you for your assistance. We look forward to your response.

Best regards,

Louis-Vincent DERIAN



ST Restricted

--_000_VI1PR10MB367772124137F1672AA1F58DA5A62VI1PR10MB3677EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#002052;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052">Hello,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052">My name is Louis-Vincent DERIAN, and I =
work for STMicroelectronics. We are interested in using your software to fa=
cilitate our development and testing processes.
 However, we need to know if QEMU has ISO 26262 certification.<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052">Could you please provide us with inform=
ation about the ISO 26262 certification of your software? If it is not cert=
ified, could you explain the reason? Is it because
 certification is not required for this type of tool?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052">Thank you for your assistance. We look =
forward to your response.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052">Louis-Vincent DERIAN<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#002052"><o:p>&nbsp;</o:p></span></p>
</div>
<br>
<p style=3D"font-family:Arial;font-size:12pt;color:#FF0000;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Right">
ST Restricted<br>
</p>
</body>
</html>

--_000_VI1PR10MB367772124137F1672AA1F58DA5A62VI1PR10MB3677EURP_--

