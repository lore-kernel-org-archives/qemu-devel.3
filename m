Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5B606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=hVuZ6YMS;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=g26XBuBa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBso-0005hG-7y; Tue, 20 Oct 2026 11:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBsj-0005gv-Ol
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:36:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xJBsh-00076T-At
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:36:05 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDAPr31190508; Tue, 20 Oct 2026 08:35:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=rkjQXzQFzUr4+tm
 ltNx6L0vDc54e7i6oPZqrZfNW+68=; b=hVuZ6YMSJjjm5DK6Dnyk77dczksKA0m
 smYwkknOlv9GetiZucM4WxYhZkpp+RSm8VLqrffflzixkHzxbayOEngdJvbSnoTj
 +N3DOCt6rqOrZY1zHraDuLOWzeaq1LlP3/r7I0nJlt0rJXxUSMT6Kt4nEumlmrum
 J4QAqqgTi4strSmWIDuy14fIK1nv24VdK3hDWOaRzUqeSXjqh+YU9Yj8XhkjF5Ph
 W09wIAadggV8taimLSW3VoAbn8V1gUXgglUQA96aB0k0d5PgIyzZzObuHAiB0fup
 O0lzhWJrekI5r73nBd03U1luw8wEoA6xt5kM/uttFcCKkhvkDvW+n5A==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020087.outbound.protection.outlook.com [52.101.56.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdw5qhuq8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 08:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4tMF3H0g4ozRXRt0i/GPTvubmIvAHR1ArijmSlyCzp3EfcOUxm45TucemmiNDroEI1onGjzbGqzjbLBHFV34gawzn24pSSkWRCmSbP/OmW1NmIaWx/Nq4jKRnIzhm5e8gDzfRSR2NhESEBDHd3SoPh4dF5d+LQUkKc1sfiFXiQDbg6I+w+D1vqLwcCmVeVd/zWPoUkmzKNOYi4rmovKhmZieTkHG4uNDkw7iSGcHofCPxl6oaHQx5MKPkp049hQ/q46X/sRFx8mkzE78W4T3Pdb8oCkJJ5B4HFfASoP6wfcnmfBzbaq3v1ihYhsUJqxRjU/katwzHLa0gCgh9GMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkjQXzQFzUr4+tmltNx6L0vDc54e7i6oPZqrZfNW+68=;
 b=l5Lrr+gD/GE6IqSmWNo0tBuVniN9m3wG2a/PfaB/ucxdEr5vEFv7yAtV1AkUxiCvJSLeaer4qJ4KVZY64ROzRuK+mTw9tX97WgNAuNZtVW0qlEluW064SiEkA5gRiM6H+YnRzo/MMamUfc/Ot3iVgYvh8sjovXkWgVvY4KgXlK+Jtd6KCbPOx8FIj1/9J3y6Ti+BtVz4Bxk4scPHq32BDfzfKR9920ATkPSSOzmAW0lH+eJg5LtKxEL/kv9OB4tptg0fYry5yMTBQL5HYjTuDKhW842KhWO917XGSwgxhekpLWw+N5Q3mwFoFzQ/uDq24KF8DlfTZ+mMf+FP4SDjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkjQXzQFzUr4+tmltNx6L0vDc54e7i6oPZqrZfNW+68=;
 b=g26XBuBaCdtKqBEvs02hls6FGOaoa/VfTAv6GJFXId5kQPWR8JNyA4TpeUwF7VulliYgH2BPiVY/+zPueDYTExZumRcT6DO0Hd7ZA7D5hyUo6apxaFIGvGvhd4yBTlWVxcdGPLZy78NyRsF4LNWoofEsxtuheAP1bk7yx7kh3tH6RSnyhy2Gkg0gy7HHy3f/Q6OEY8NKgPkHfisuuR9WY/Lnf/fl8O3f9cIgmNoMxXVtL15SgzWPtPunyn1g8rC0A3vS4XSEcVCH/yy2AWI+SwbIonEcogQda290GzZvjHrtuCo0opcwgF/dx9y+oOWyiWzz2TvhHhJex0hRU9eZ1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MN2PR02MB6750.namprd02.prod.outlook.com (2603:10b6:208:1d7::17)
 by CH4PR02MB10756.namprd02.prod.outlook.com (2603:10b6:610:23b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 15:35:56 +0000
Received: from MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2]) by MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:35:56 +0000
Date: Tue, 20 Oct 2026 16:35:52 +0100
From: John Levon <john.levon@nutanix.com>
To: Naman Gulati <namangulati@google.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v5 4/4] vfio-user: support multiple FDs for sparse mmap
 regions
Message-ID: <ateKWPIYOCnnDpp6@lent>
References: <20261014211041.1087331-1-namangulati@google.com>
 <20261014211041.1087331-5-namangulati@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014211041.1087331-5-namangulati@google.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::19) To MN2PR02MB6750.namprd02.prod.outlook.com
 (2603:10b6:208:1d7::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6750:EE_|CH4PR02MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e5cb03-4da3-4e36-cf2c-08df2ebfd4e3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: mBSkLdU2y70oTdvqWlY0OQo0kq/P79ixV658NR+bl4BSbVivIedNZ/OXXFfQPoTr0mGRHB54dlfCzAy99vGoERzwH5Fl18QRap0FBpnuOvwQQalJa0IOKtxTft1VC2EGdXnAxTeP4K1IAT+k6yQJMObJtbRIuKoFKl3GzSKLnbW/QcAAa3yR29d1XizHPoCfCQNDqGOMsybS5fvmHUfykzMc2LtPTVle3nhsZFlYxIvOGHyRAid28PplvnVqZ55TcG8et5DBJqUsB8obB5g556tKu8KFf0vMuk3WXMgJdv1Jn6RvyvrrptkZH+XL3hVPd7beBLup05mO0vEUM+jzBxwsWj9sUJ4LaECgd6xWSAJHCWlQhplN0dXJuIDWa9N6JIGusxRuTeK1Tth7y28/VO8d37x37fjZVui+TkVRmB1G/DB2VVxbixCz95dZJO2TsiPdlGIcTsVQBKk3voNFwi+n4zDdZnYysC+YkQPcXZB0lXIPYf/Wlxzs102dMzzSuE/idklnFtnuoJu5+d0kquraC42PRoP2+0g/Ta048LRBEP4FuMeYJeVP0ZT8yXboJ61wLXql7RaYeDYBpzgdfitji9TqT2gJiXOEf+NdZmp+XHAPzO6+RypZdSzorSS7Y4TvHmh5hfub6dv3kRNxZmooHx2eDAoeAEjujWyYloo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6750.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MOA/xouVNyEPFLJq76owscA7lPTzqXASoYLSziYvLdw2YHQGq1Kq5aUYQ0SJ?=
 =?us-ascii?Q?VacW/n+3Qm2uQjdFvvP2vaKr2A8JIzAeNMWHItDdP1mfRYYtiyLvUeDrnVcL?=
 =?us-ascii?Q?u8vvVT1/xEosTfzNeObUaeqhdoir/gI25asqzcHuZb259asH+cIhH8055Tfd?=
 =?us-ascii?Q?7T77UhU5vMFtXXAYVe/S9FEe/r2Vjd8qnFj4o2z8pvkxFIQ0NxOjehu+8ANF?=
 =?us-ascii?Q?LiaHMUtzPLztQOsoOy+zFwh5+9kIMi5o1ZAqkej83vaRRdzyq4ob+zE4uWcH?=
 =?us-ascii?Q?mme075xpYokRz7S3B+5XYnxtYhc+cR1hcyn7j3Eb9PI28sPk0lLHPAs/q2+w?=
 =?us-ascii?Q?VtgtHSso6PWPYVxyZd4lrIUyzmK03QTkpQ2xAdU8HBOyjqQyHMvAOsyclJuI?=
 =?us-ascii?Q?0w7EyXpzyqRFmvvrc12qi3JYOY7VcSy3flTkwcB0ZJwmUwBN/NC+GMjkvX0w?=
 =?us-ascii?Q?DvJojr4bY5dgecW/YBFuEabaRkfpG46NeHPgT7L3iRFxdq+NCjYUB3pEGkTJ?=
 =?us-ascii?Q?v1jFvLXezsgSS3ZpL/45eZf45M/i+1S8+qIGTeaJT9rF784Iz1b50falbEwg?=
 =?us-ascii?Q?uqMAL7w4PlPwWzYQFoj8tjyuwLm0wzbygfZwpyGDaPVWHZSgncGdHvi8FlWb?=
 =?us-ascii?Q?sCAe08pwyiPUxJHY8k2RM3LScuYi/t14wq+dZiQKEJXeaBxuw3MmtYKRUeZw?=
 =?us-ascii?Q?M1layOdviFehcNkgdNfmXzubzHPEQ/r3FuXqwfiz1UumznyG/QV/UZZ37+ne?=
 =?us-ascii?Q?R0J145yuXQEFooU7cx64C3tNU5NoAYuwuWAL+4obwfp4T63KHCmdCJ/EbH+W?=
 =?us-ascii?Q?6FDg4lMKBiRvefu8p0yjzn6mtlVOb40DlGKYoQTn9idn7fHlQLPc/P9riSm9?=
 =?us-ascii?Q?r/h4P0hvw1KXp2QieELgGo30JnaTjd77cXdMZHVA2rV+CgZ7ZdAQakEcvHAW?=
 =?us-ascii?Q?gjUApXdjr2LAd0/w4mZlL9863hYUQ7TcJ6J/oG4+vegLwRUqdf+6b2WRpW73?=
 =?us-ascii?Q?hU+r1I1GsP5LHTsTmHvCVOo1Z0WRP8YXrJxAHr7WK756HYa8+OrQLVT34bc5?=
 =?us-ascii?Q?s4jefwYA3vghChL7XwPavKrPgyTcN3/b7JDdfrx27KH0BuM9mx+7hT+5RM+Y?=
 =?us-ascii?Q?RSeUf+oRLfu5e0AWDSvRoz9z+UYCGxucT6JNkYKduoLQ0MG2oLvnPwdfqXBN?=
 =?us-ascii?Q?zzF2OfbHUDGR1+L4wR9mRkkIiMFDLxaFMHc++a/bkQ+BzVY+fpx4yutlB4Fe?=
 =?us-ascii?Q?g1dl6exMClMx8SVmNWHp+UnOFgBBYIDd7MOqHWsYI+QBKKk7FTAzn4bpwI4z?=
 =?us-ascii?Q?CSPy2CeG1LUL/c31AWqda9VcAQc53XTyCZirBgcchf98MqhHUNr4A0stl4C1?=
 =?us-ascii?Q?1FT4DxGIQ4dhkVrLQq9qgZe2CmQKIAqr9RmNmGGDPjjtZAwYJIcs63B16IXg?=
 =?us-ascii?Q?TbwNKl1dehLE9u87PwWLt5EbwxK1tpjKaCyKqjrZtET7KZjDvZKNPucNGNsC?=
 =?us-ascii?Q?z0cp6TPwm3mFBW5Mzc8k67SYScf621fJUOIJfg8lIR1dvT97QdyldfZl+/a0?=
 =?us-ascii?Q?xg1ZW7+FwQ5IjqpBK84lwixMkVlgEegaAylVXr2CcDqYjfcCWjtg8esKEDrX?=
 =?us-ascii?Q?zGQsZm1hrfQcTvn/S7LzuwLtDdW1Xjbe1hnCaXUDXRzMg7xCvYNvnXTM00aS?=
 =?us-ascii?Q?X8fU20PVrpJUcHez7ERiXpF0EAN1QrVofkJFqH5WHd1cfW+w5seurt5tonNI?=
 =?us-ascii?Q?y8y19UdnTQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ocJ2SZIGufVUrMb7WCPWFO3734XsPUzQj8d6/TAKt5nVb3j3zSak9/e+TGArnuZrKrWEKjVMN+kXPEPsw0d2eTDEFNVbWVXOHXGxVQ7CUe0dVfbkzxlBdlbOgVXRdT75lZAmvdWEZxGCuvzLZi7OEdjXVSsGOrrN/223OPGe57GgUWnxPlHfDH8wX7AOZeAzG12nZexY93xCzz6R4foUgSKMO0BcBigXRjdLi8agNHLSaZBNXavMU2zpA/865qnXVCaFS0/bZO06M6uC84dcyLJsg4oMO54poxRrkurHvH+gR6xdmyI+mLnjGySCFJAK9bCk+7D7HuziZbNIqaycVw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e5cb03-4da3-4e36-cf2c-08df2ebfd4e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6750.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:35:55.9758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w2RZAYfjywO9tVZaJOSvptBVZ84iSs3AbqVxan7FfXkO0C17vqakUTg1H/r1BtUPkV6AUcdgaInicNdf+SEWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10756
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXxAS7jH7q86Yz
 75nL8az9RHLhbgpJ9ds6cl9cEK1nU+7NShPycSlrfpM3tQeEMT9dvk6+ibB4MZsB9BbOmHOrseJ
 08GLyPsZpWx+0nmi8OIEVMblwjTVQGu9v9wKAMj+cvocZn7WcoLdnGHVrvdM/PORX872zCDayUR
 sEWFuL27xbZG8iR4ZqyvdQXnc3+MZ83pZti1UK4QwQGd5hsBaT8ed6z+ya55UdVJ1DqmsCypuJc
 8LGDoSP26j8NJKs1eVzbhSQNfoWMNTtnIPazsoBe1BitEosHme+ngfoZeaHgj6HtiBX/k5W1rqe
 WcqkeshLtb4MzWnXCqng9mugp7lhOx1PA+4xF8iUJtcFyhkg1SDP7fH/55fsb9uKVKSJZfkAtBB
 oN/EmV8roMoUpVgQpAB0Ynk/WtNyansGt1nTQsJ9AQCpGooDJHjL3aNltS9mZZ4oq2NAhLh1vvy
 yMv7lP6Db41IZKCXDPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX/9v6T+XzJNqG
 dLO9bYk4x7pHDVPnzNNKn1AWV/4osgyCK1QyeD4My8oXs1AuxTZf5YyqNRv23iPYbrWcz3rmEs0
 6xNOhGcnF18LeQyBYB0Q8fse/8e5tIw=
X-Proofpoint-ORIG-GUID: OG49z4oKVohn8NRMjJbJ7iVO1hjFVaek
X-Proofpoint-GUID: OG49z4oKVohn8NRMjJbJ7iVO1hjFVaek
X-Authority-Analysis: v=2.4 cv=CZedd7rl c=1 sm=1 tr=0 ts=6ad78a5e cx=c_pps
 a=cKIMjK1n37+EkXSgp0vfNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=6kBPs1uHOoMy2cGEgsMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 09:10:41PM +0000, Naman Gulati wrote:

> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> index c478d1353f..b823689254 100644
> --- a/hw/vfio-user/protocol.h
> +++ b/hw/vfio-user/protocol.h
> @@ -15,6 +15,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#define VFIO_USER_MAX_REGIONS 100
> +
>  typedef struct {
>      uint16_t id;
>      uint16_t command;
> @@ -69,12 +71,13 @@ typedef struct {
>  #define VFIO_USER_CAP           "capabilities"
>  
>  /* "capabilities" members */
> -#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
> -#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
> -#define VFIO_USER_CAP_PGSIZES   "pgsizes"
> -#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
> -#define VFIO_USER_CAP_MIGR      "migration"
> -#define VFIO_USER_CAP_MULTI     "write_multiple"
> +#define VFIO_USER_CAP_MAX_FDS           "max_msg_fds"
> +#define VFIO_USER_CAP_MAX_XFER          "max_data_xfer_size"
> +#define VFIO_USER_CAP_PGSIZES           "pgsizes"
> +#define VFIO_USER_CAP_MAP_MAX           "max_dma_maps"
> +#define VFIO_USER_CAP_MIGR              "migration"
> +#define VFIO_USER_CAP_MULTI             "write_multiple"
> +#define VFIO_USER_CAP_SPARSE_MMAP_FDS   "sparse_mmap_fds"
>  
>  /* "migration" members */
>  #define VFIO_USER_CAP_PGSIZE            "pgsize"
> @@ -166,6 +169,26 @@ typedef struct {
>      uint64_t offset;
>  } VFIOUserRegionInfo;
>  
> +/*
> + * VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> + */
> +#define VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS 0x8001

I think a brief note on the "0x8000..." space WRT kernel vfio is worthwhile
here.

Otherwise seems good modulo the other comments.

Please do send out your libvfio-user PR for review as well.

thanks
john

