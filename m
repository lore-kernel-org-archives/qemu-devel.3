Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D3606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=J8gsk3fU;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Ek3lZsci
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj2q-0007Qy-UB; Thu, 26 Nov 2026 18:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xWj2K-0005xW-5i
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:00 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xWj2H-0000SQ-MO
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:55 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwshQ3961747; Thu, 26 Nov 2026 15:37:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=lIsUdRhA24qHZwQ
 tNSm4ET4WfbV/w7pusuGQv4Bc968=; b=J8gsk3fUDuOVLVgyAoDUW6b1DgiZhVW
 4HFOPmHpLZDhb0bmgKeMCuI+pPH3VNhseqyGTa9ZyakvK867x91wbrAm0Vb0Edwr
 3RriUuL7hXYKCX8wMy+dHPh6j9TT77N0NW0ipymLwctXLzdWnrlWbQNnmXIWV9BW
 HKq0kTPTqeeIdHg22dnmCjRFc/r0tE3HIU37fGkX8PoHCjieT7SyGoaYpYKcLR23
 PgeB2lZYQh1U/0m/tE4o5kEHSSuN7pJoqEYKaowl4CSu7zrp0zKuGTvPmXRLsy34
 m0NQmqLmQccC8eqGUCLH6EnZWvHUJKgQI5dXb+tA1YRH2Y20bENtstg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4j6ftbhkhd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 15:37:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPEejGDF4gLha0bYDK8nhoedwRojyUe/SYVZTnkSBCGU4m1JqgPa1eQhVQPCDdoEkdRjjILqNMirkN+DoQAEbCpe+KymBE6m2WtOEOv2R0RzBHZCMGOt9IUpRBfXAhAUUmZp93SxauOmftRLQOFU4H11jikfGitTlsKsY0i+xy/wiNxvS1luDP32zR5tZAqzMYLV+gtRMfZCkD2KyAP5bBhhl+gew8PMvpdaQokksSO3k3wLrxzVUa7OAdhK08p+zqN6M9/7KFxu6g72WEC07emlOYPR4HGSDR91Ng4dtcmkYw7pidFmXCSwf1WkABKxJiNxu8X0SjBvwmgKdfPn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIsUdRhA24qHZwQtNSm4ET4WfbV/w7pusuGQv4Bc968=;
 b=Xg2jl8Oa7HCPNHqsjANtOGe5ZWgd8qW4p5y8xYf68WTnlmUIQ/ZWvmppSebTrmyxdOgxXXldT50kQmsL5EMKHOhaAMK3QkLmd/J1q3vONsZufbLGErrW6s+Jksu+1f01ZcYhV0j9lpXa9wrSgGpHCwLj27xmNoYJHpmeEkuhRcpoWHVRtNNeDcXv9m31+aQs8uPG5DA23LMpxcEh/Z+ZHXaMniomDNK5Ot0BP2awMzagaCRTOgpNr4LCls2IjE4uhrDTvGjcQP3BhGi6l0VUGrdWPBUHQ6PFKcE1eFmdpu6OgCiOtuhdvHfjmtpPQVII/l3Bnf+rpGp1gn+UduufuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIsUdRhA24qHZwQtNSm4ET4WfbV/w7pusuGQv4Bc968=;
 b=Ek3lZscivjx7G9MoVmy8XIE1RDK1soSCN1JVwrtT3ODtZpEXuXJRVDKsJBo/3t7vcy0DIG86tBOejm7VNQh83qONqUWa5rXjhCTxususHsAxrMR+Cia74HyvWbkGrmEgbh6aUwWTecGcyu9E9qnPyOeClfy0RpdVWFJbxy3A7p9IZvw2CkCTa5lkXHP0xIgEeFoui+gBXIjeeKHGgVTRvFLChThPbnJKcc8zoL+HKtmEFxKwKZoNJjiKof8T0lSXD7kDC2TkhIVKN8iG96Auk2kBKJjm9SrGWPAlU4G2DKEPwmy8r0Whjds94vKiRp2WF6T3F0yE4FizYY6fmgMV8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MN2PR02MB6750.namprd02.prod.outlook.com (2603:10b6:208:1d7::17)
 by DSSPR02MB11347.namprd02.prod.outlook.com (2603:10b6:8:378::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 23:37:46 +0000
Received: from MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2]) by MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 23:37:46 +0000
Date: Thu, 26 Nov 2026 23:37:42 +0000
From: John Levon <john.levon@nutanix.com>
To: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
Cc: Hugo Komatsu <hugo.komatsu@nutanix.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v2 0/8] vfio-user: live migration support
Message-ID: <awjCxgCwvDR0vViz@lent>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
 <20261126181021.116571-1-kaynak.oguzhan0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126181021.116571-1-kaynak.oguzhan0@gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM9P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::18) To MN2PR02MB6750.namprd02.prod.outlook.com
 (2603:10b6:208:1d7::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6750:EE_|DSSPR02MB11347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c78ddc1-adb1-46ca-7ceb-08df4c164646
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: WqHfeIn9jk8z8msQyTbfEs/U7BnWNfV7di8PX35OgcrVbxxVqV8gQ/nklWBjAdFaZ3I11HnyMwEKYxQHbB1lc3WqkrWwun2qXVO6inUcPsySfy+yQJQHeAwisajTElRabnzADZuClxeHhpExiDOTg1ofH+bRBc8jSTfTznL0Y/PV+iA8V9YlQ98p4FjM1HPqfeyg4PBKrTgv6OQOfu+cpQjr1Y2nZU86EjBU6fsFMQ4IO+K2AWZ9rql7FSVEIlacOXnB+rkLo9YJ+O/fk3ETXZII8oWj8Bfc1NUW/FrWIw3HD3zz7L9jnlFCqYurqrcXSg6KDV4K9UvYO055Pel3RQ1gz/+P6ZFzTw4ocl6ZnctEZd/anjvcOYOsL813Z7UofktFjkNnYIWZr0NEafK9/DwcgJWCLY66y0akQUGfseqQAsU6in9w/fi0R+KfYIorZXWHHYV6b9AkKx4Dz+NMrggPtTknbvbcnFhW8xjwHCDlofhFpLPBw625LsDdH3ziI70cDsOR5IYgiaZa/9gr3ikjH6GonJn6qWazELObWeXRiPHamcsZ9Wi/B+062wCDYE5lKlAj3u0g6H4XTh3+fOexbw2CJbL/37WtFc7tOjDr82MVlQh3nzwbb7ekCtstbZhrYiYkVmB+PrrdL0QkSxxJkDVXUEhJLQq6roldP78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6750.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02SV73XhT8y3qYr6j4MaU5fagdu3gIwz1nE7qQ+otANjWOgPEAey3GK4md+W?=
 =?us-ascii?Q?J3XVY3x4AOMnhz2GkZPs36D8d74L5CrWli73+wDz4MB4eAaF6o9l4qjaCG2d?=
 =?us-ascii?Q?Fb45364oY8PhG0NvjeTMg1tn6cy0nmrSHv/+AA2Wk36GpA4SDusdg9pow8MV?=
 =?us-ascii?Q?dsr10m9pv94KcU3eYLRHm40O36VNr0ZN3VbFdkDoh7aSSo7viRYbhO4A3yl0?=
 =?us-ascii?Q?XBaBbDDxShdTVciK9C9IeDRMZHnzvT0ztSBly2KApjSZHeaVBCHvFA9TG65M?=
 =?us-ascii?Q?WYehjZFD+rSuzssEsAny1/e/U3DUfZTcp96N62XqLfJUcGrEFKo3FgrcTQyi?=
 =?us-ascii?Q?41sB0AnpiwMjXopkHFow4GidZZTwE3Rs22SAoH/oWbAwtHizordYnVBlSan0?=
 =?us-ascii?Q?9q2S74QeFoURy6pPjG0d0WlFVZ95VhXSGfmOsPmu9BHx8/fP2txEcZW4HmMw?=
 =?us-ascii?Q?YR8yMCG70Z1KOYj9bw+vXpIzjLYqc+vwYcvo6d0gvFM6HVqe/0GSvykaHoRY?=
 =?us-ascii?Q?8o7H7OURY6TTUmlp4UaY5XDmeSY774cAwXrR/X+oBO/yaFH1f1Hki6HfsKlh?=
 =?us-ascii?Q?tO9Mv+Pgk+XXdcMsYimNWSIazT2JERVFNpd7RHRHWOc3Nw1uWk2IP1ZpvXe8?=
 =?us-ascii?Q?9xwImdSzS/eoHqAfWvaBRJIE7iQIWjaUV33wXFS37SK54LmfmzQPh7kC/Vgl?=
 =?us-ascii?Q?JWHb4d9KfAcqYiX1kDG2lev7HbNVFnpeu7jIFIJcJt4WQqNKO1n6pqomnfnS?=
 =?us-ascii?Q?SmrMqWiuV/lyVbntolBZqHpqjqBJC2tiPN3NIDvzbj7UcFjfgctPbWTHpkXp?=
 =?us-ascii?Q?joM1m9+V1eXbGuL67buzVAyf2ba4ryx7DWZjM0rkBl/doo7HxkuoYgf7goFU?=
 =?us-ascii?Q?zYQ5XI76te03Eppp6lrx3wyk1WfHyF4aN+WVCZcchzqYoBgGTCnsEzwKykQq?=
 =?us-ascii?Q?T5aeyqVkdkyMh9u3dhbHMzOPP4p0H41AIT1US4n7sCziGFPTfNR1joC1FyLl?=
 =?us-ascii?Q?9bHa6ikV+IhQbaZLaLRZ26uWR8CT3LfiT88sVprkZFlZgt1BvPUM32TYg2sV?=
 =?us-ascii?Q?chmEylN+lxczrr3OIQFQx36bRqZ6vPdvNVGnSLMccIWo/4/QyGMRCacSD9ED?=
 =?us-ascii?Q?nIZnS7o2pemzTL4wR33N4Qi3tli/EMbZ9nL9Ksh6D4944odou2U1fw5K36bP?=
 =?us-ascii?Q?ldnuyEQbHgTZwtnHc68wYj0bx+pT071Fg5mnaZEJdyBWiMMg3h3OJNH1vzi+?=
 =?us-ascii?Q?yi7juMY82ojEnV0eDpj/jA+siceSsbypcspfqeDXmZFApnRuQLxyUnRlgmfR?=
 =?us-ascii?Q?FMTgYcYjeeX3iXcjR3qwMFSC5hKNIE9dyAIGgXVww7AkvqgO7pfjZHNJs1Yp?=
 =?us-ascii?Q?aBBGoLBjyMeTd9gradXLlynoVZHM71MZLjh+oFSLyK8EC23NJuTWuGWdb50m?=
 =?us-ascii?Q?dal7HhC7WA/M4gLwcOd4pJDs2TlmztQXt8/OgNYrmGAnFhYpyJ5oIFPy9JGZ?=
 =?us-ascii?Q?lOcfThRLl05kym/2JgvQYL/5whioKVpJ+YBBgXNI60Va8gMfO9PHnGQlWxdM?=
 =?us-ascii?Q?E+xc6DvhnGUlOdIovHjMof2iAgPZJdu6Sp6si46xmxWr1Phjn/EElx2c9EqQ?=
 =?us-ascii?Q?P28DNtOmTc0Q+Dr9zZ3k4pBz0TRYRIIxTxBSl980pYrSnk1+BnBlwvq7R2ZY?=
 =?us-ascii?Q?UkEq1KzghfU8XIn2k5Qh40Ol8Zntpi9W24P8qM2xnbnNb9pLzqtQAiHcNwiZ?=
 =?us-ascii?Q?ZVgiShY8HQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: PWwTrMT5wUTUWFWAYYQHt17N9/YSu2ruubwXLVgs+gOEDlj+Yyg8CwtZAY264+6Ps9CPVPooAY9lnLTXEjVZELu3VHfoYO08SaaWEFIkZxRvGI3jE5w5e2c9IdnmVzek6Q631hnHKzhbatDwK9kup9rVeuyjsLxuwjf6/JCdyieuTjVeQM7v5bmefbGwoZCmxZW23etiMj5KO6eF++rWVZWgA2HAiIngEvbzA66H8/64G5fZcurTP3p+lfZS1bUEisJ4HIONMellx5aRSy81cE1Z7ozW3XflhXPox7L54DuOUuoaW0SBOaWmd4nnR5Dy+nkV3T0L+LYJLBLnIZ2LKg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c78ddc1-adb1-46ca-7ceb-08df4c164646
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6750.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 23:37:46.4788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WupI6NdGKTohXyebRho8bsvqW24KjXZ12SfsDqCqiSCiBuYhgzyKgdK9wEIWT6P4dBFRIGffCwUEg38Ev4IgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR02MB11347
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX0XOGmZ8MwU1V
 RTC2Mx5t+2VnhQxa6Ike0qRN3aKx1jovmQi5AL//6f3jffEbAAMVYqHkJpjj6ZpQGYk4Y172gp0
 Ub0DJjPjDSLbZ9Y6NX3A6L3E32oCg57g3k2rqf/f/oPKGZCYMw/QbLtjcO5j/NcxxyO/rPkS/ba
 E85T4pqnp2bBvCjR2rpLD9xDOERjejMDmFXWdrdjaAqEU434VeDqnvwoWukDb3PM0ft1kIsYrQe
 2thvUFwVu2ZGNygPGrzRTCYvoDheMOSH/LW+RyzgQaa9APqTYkMNqp7nGXkbu51gIFCyzW7OyC/
 annaOL+q6AW7oaEz3zfRMdZA2cYLEu/adD4IHW5ABMiS8XkhFW9pu3IDFUBKT01TE47Zau38Q5o
 dCGVRChce5aq0a+SAUgClTKEhyCoon0SlwtBIjypFK5XfpP2L0PbfhE2+QN/HxxMghJbiEDbob9
 5+/PgDY6MF+kCXFjxlg==
X-Proofpoint-ORIG-GUID: 6SgH0Q4cQ44V8GvJKwzMkYYIo2wm7VQ_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX+dVmrIbhkP/V
 +IN8a5w7r0Iv6uJYhDIHfIKiJOT9H1ByvXRvbpchk2MRbf5PX4il8V0GxOIUVacj5Hs4MbetVga
 ll7GyBncS1gRhmE4D8wnwVwYJZNc0f0=
X-Proofpoint-GUID: 6SgH0Q4cQ44V8GvJKwzMkYYIo2wm7VQ_
X-Authority-Analysis: v=2.4 cv=eMSGH3p1 c=1 sm=1 tr=0 ts=6b08c2cd cx=c_pps
 a=Q5kcJUpSFGSGPQA8zxlsBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=5ag5xDX-t-eqsgjEkYMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 09:10:21PM +0300, Oguzhan KAYNAK wrote:

> Since the series is not merged yet: would an explicit blocker in
> vfio_user_pci_realize() (vbasedev->migration_blocker plus
> migrate_add_blocker()) be acceptable in the meantime, possibly for
> stable, so that current releases don't silently lose device state?

Yes, thanks. We are planning to return to the migration series, but it might
take us a little while.

regards
john

