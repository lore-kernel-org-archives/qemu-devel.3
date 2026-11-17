Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75B606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=JWfScf6m;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=o0DgrKc6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTHNm-0002bN-7v; Tue, 17 Nov 2026 06:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xTHNc-0002au-Px
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:29:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1xTHNa-0002Dd-L0
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:29:40 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHA4okD587190; Tue, 17 Nov 2026 03:29:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=QoCgNKlAkssTcCt
 gPV7QwEJexttsVxySpyzs0lIFqfw=; b=JWfScf6mcxVxiDyG2NeW8dVCAiUPnsR
 rB6jlOq08zHZ7MWJXrc4ypW26dENE4K/RvqlcxtcyRdKj1kcoS6rqJEOMaXUEUce
 VuDp97nM5+mwCHe+OVOgUn+1fDRGdFyl2E0NOZC2vRsruJ/cjCbL+2e4e6guBVJs
 WUtwVHTFDKl2KySghOUJaLvrUUXmfo1X2Gb2a8cStSjopKxZ99XjSY9LuQt9saRZ
 3yLmPEu63zA/bde3sfJfMkbLHgSq+ouF9fInhwt/N1GEN1+XgMoMp18V+z+xvfi6
 I4GuTXdQC+D2OKRFXFxszLr3fru3uQcshbcW1bdMfs4cZULmhCFaw0g==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022090.outbound.protection.outlook.com [52.101.53.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hxr206jmn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 03:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2QmWfD3gE6RYCjs+1svgyZ1vkO4V7L/30s9xR8WERs2yLJs/r8kj+EfyL5G2XDHVUdxfb256LgzR/kYsrHSV52sPYSu+yPqzATcDOY807UxlHdne+T6IeZ49Z1zHfVPbjN54GF0bu3caeh9RMYVcOFhZ4LIItNat/6I1sJRDaq93HrfAopS5sf20+l+1AL6jls/9HaNucIUwyUQ0GsNOyZyrPuNqwoSVy4rQtuMRgdKafoy/dyF4Ub65vev6HwQ/gt60Oc7mId9WHRNc2q9jRxET8U8TwCF+mldFypou4hxyoXe9Q/2U7VYh+sTvJm9KnP9fCkdCG9jxmwd5Uzp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoCgNKlAkssTcCtgPV7QwEJexttsVxySpyzs0lIFqfw=;
 b=gmC8IG8uhSANIOysfk2DGsfSYyip+qB5mhHoIRnNINI24kkCEWJtnRGLhNWQUB7gzAM/cALB6htfIojSx6cWoUs9Kt4SklHwD62aINjLuSaFrdh02TBYNWoG8nQZiK6iq4DUoapfiMkx1mBxX/uw/zhXHzHV4/fq7lpZRU+YKjq3jh7MazE4B7emxYXu6mNHMx8cTRAG4b7tP+torVHNjir0UXhrdqAyVMfe6QZBi7Qtp25kjXGYV3iRdArfExWn1GAH3YvYgrZVS8osnlr5K3JVXsaFJjfy2lQuzyeOSm5e0U7n8cRwf3qOef1hA7yNulnR4n1beNWLlHtO4ycT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoCgNKlAkssTcCtgPV7QwEJexttsVxySpyzs0lIFqfw=;
 b=o0DgrKc6I4iECsYRpeHEJONeT5V5ajVrIEuw6aX2Mxei5RqMmhYdNpPRqXQREZJI5EUbFS3hf/wHkQJy/9LaN6YD32MkHT5i4/NfvOlPxjxihBfkOetPEkt/qLK9HEqZsiA7exqSydEOeQqhFz369zXoQN7EGbtl7DxPrQ8IClF5DKS87qYEngE9oni6oDP6Bsaoav5cHS9vEccy2yC9Nq7EQgeBrSyY5R6Vsoomw0wqCX6LQk7ExXHL7tWoIKFecp0Psw9OnijqWfdMze/WIMxxIgSyDpxArWYXs6gYG52jo/DkPO5t89i5JIWr7fxMf1eJv+Zu3cngHOiV4lZysA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MN2PR02MB6750.namprd02.prod.outlook.com (2603:10b6:208:1d7::17)
 by SAWPR02MB11995.namprd02.prod.outlook.com (2603:10b6:806:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:29:33 +0000
Received: from MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2]) by MN2PR02MB6750.namprd02.prod.outlook.com
 ([fe80::18be:d1e6:326d:4dd2%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:29:32 +0000
Date: Tue, 17 Nov 2026 11:29:24 +0000
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 thanos.makatos@nutanix.com, clg@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio-user.rst: clarify handling of VFIO_USER_VERSION
 capabilities
Message-ID: <avw6lPe-Mx8alf8R@lent>
References: <20261116114947.3365480-1-mark.caveayland@nutanix.com>
 <d6dd9ec4-d3b6-41c7-a79d-e72161aeaf37@oss.qualcomm.com>
 <8f95f37e-eedb-4523-8b18-3e0466a4c282@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f95f37e-eedb-4523-8b18-3e0466a4c282@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To MN2PR02MB6750.namprd02.prod.outlook.com
 (2603:10b6:208:1d7::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR02MB6750:EE_|SAWPR02MB11995:EE_
X-MS-Office365-Filtering-Correlation-Id: 03192375-2be6-4469-ee13-08df449e0d0d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|56012099006|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: n4zySNQ56ifPqDZERn8eyY2nVIiYoPXP2tnSeRCR+y7tIlKCJgrU3Ss0VlmLz4YPnoPmKAd9oc1eudnspQZukl5ZaodwyQPRNlfuL69GSdc6tS4WkPcX5FmC4iqAg7YsKFHe9ynY9R512LJgBGoflkJ1o8ydfEuOed9sZ/ess3fijlAlYRUbvK2NkBt+Wits5FHtSRlnQo/R0vYSqwEpPJGFIzIEYP7KbDDPDdr6ONiPTSLju+WtH+VaYS31qOVOb3P3s0xQvvvIOjk4Xrd7Pe4M6gkAPoZJFyWXbMnmyVbcU1F3C9uGo+ODj0Kfqieo4A0sQasJ7NIre150kGO7G1F4LRC/ZPlIhh2xJyf9H8mdcmtRAg81KmEzicIheha5KKByOllixIjc+YiDn/TRFNI0OtbmRwDzYwc3lYQHWLgSQS/Dxbs1sx3QoBE7uYcfK8dF4i/+s0WnWSDVTl+iECcWZFnHf078ILHMeiERV1+Y74QyODzv5W/3R6vu6gqbBub3eXksPmSEEsbVETwpvJqOTTpPWMSkcBtbdHtykjvMXYhMz59QDD11+ksTyay5DmFqs6XA9q6HjEJO0ZFLE66F6/jsSgr3kr9jbJLYSkl2pbimRZL7nXMmwyNPEntIjbVYGwhGB0mndAD3vhxZqTe14nnFfUY1FnXixTSEPYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6750.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQwpvtVwANkoNQeM8q0nJ7t2PGBf6OhD7KlsuFXhuHyzyqMeuu4ramyCpAvr?=
 =?us-ascii?Q?IEUrCS/hb9qK6L+7i6ZFc8sMoYQthfnjOSzbHYOmSiCIxqcECZfebE1t1hha?=
 =?us-ascii?Q?xT/DMjTXzsY2TvhuIwMFmo1YnkLqXF7HJ5mx/WBg05MATUCbGALEOLDpGxWC?=
 =?us-ascii?Q?TV3xl6hIYBNYPcamlKOzr/heu4dsMzxBdo/lHCTFR7bkKZ91NrdMIIDbrU5Y?=
 =?us-ascii?Q?4oQBvfrJDPhjeXPLtoNd4YHBQK8tkqErQfXBVMP+VfBl/0HrNnrVzIIGwZrC?=
 =?us-ascii?Q?3hBqLerH7HRCxgSaESdjBJpIGxOQ3xLvvlNoLK0MqXf3xV8QYgrBqvair4xA?=
 =?us-ascii?Q?Icliz0YTAObmezg6ox1I8Jvu6ak7MRhyasQX00ahSE38BIReqXilOyuu03PP?=
 =?us-ascii?Q?SxykJ2VkC2AsXwaQIohGySNd6+0fPjzzFTTKTArEVhN+kBOPlRV1C142/+6A?=
 =?us-ascii?Q?IggdKWwrAh8MVC5OF+HKpizgODat0X1JYU8w6hN7vOHPAPr6ql9UY/HeMa2i?=
 =?us-ascii?Q?QkipEclSpnr3R7zpu0veq5hk3958t8fmLvkpn6yoSrYpLVB/vDGrKymUH9Mv?=
 =?us-ascii?Q?+LU3qI2uRUQXeW/FUFnooDBtPPkuGsEyKzfr+dyk6wH4jBI84VejY1eDqt9q?=
 =?us-ascii?Q?IXzRnvr3LB6RtBXXtpteVDHktz+nIFJ8AJ71GV+cRehqWi5k0h7HTDCjNjPK?=
 =?us-ascii?Q?ResbjcLoU5ts4dl8kuIr4jz6pJyTEP3cL/KF2/rtUo015nBt2yyhn21RQPNf?=
 =?us-ascii?Q?Tlqi1rn5qStn2Vwy0AaJ2Ie1rBjxZJ50f/pqFfj5QGqzLVqTZCcQwg5SzMS8?=
 =?us-ascii?Q?gL5f89iMIzomlNq63VWMyKMncD2mV5e1HQrLcW+qVyYv1w1tXpnQsB8UV8CT?=
 =?us-ascii?Q?vzOfVwfL7f6bd0+o6YgpbUroUuXpBR2j4ziTLg4w8BRyrM+B5jS4JiBeQ+Nd?=
 =?us-ascii?Q?ycIj99ATnFAJnC+KjlqNGcJC7M7fw7q6AZ6i8dBRWrLSPNqx4rIdW4SDFPeQ?=
 =?us-ascii?Q?ewZd+bt524f/ZUJgl2oNrKDDJABBpObqkSUpV2tmTM7hrWLZHtS5HvPP3zhn?=
 =?us-ascii?Q?ZtuENPce4azW+nNIgPKhypx25oAyN6thlBhzWjAHGPOcLRNhkVDwu75wPJP9?=
 =?us-ascii?Q?2f5uhcRWjLvW270DOzeRyE0KeMnhFEzagMK3n4GC59XGmOwffiqF896ncijq?=
 =?us-ascii?Q?UroORCjtgOrFzaB7ygizyavYVwkgBXNB+8egGSEMgUhxbaqH+WNego5KbkBG?=
 =?us-ascii?Q?xl/PNcNSgiEIBjlfmgYxrNAqmINkze0LZkvyXC2zvcmabe5zoHAnZnjaeO3m?=
 =?us-ascii?Q?1QXL3C/TfJ7AP9lnIgNd4+gEuDBNEJXfJ+OVXGeciwJFGepa4SDX2JlDWxV7?=
 =?us-ascii?Q?//ZCYLnpNvxJ7R18eh7twH3l8SK9dG9vm4m7eJhURtfwngc5WJ2JWPzXsUWg?=
 =?us-ascii?Q?ZKgJrUsYhuE553G937S74+22QC1zGV6C3wlam5tpt6ZAalR5Js8XhLAjjp4b?=
 =?us-ascii?Q?CVrikqXR6+gjp9qizbmzC0nkh90f3d076gmSTZnzcOUWVh/KfDQyJWRo8sBC?=
 =?us-ascii?Q?sVaK60Bh8Ue+oFl/uTbQ5Xds+aiUFhJRK1CSWg4X0bHquaneesEdmzUu/AUv?=
 =?us-ascii?Q?yN2jOjm9d1jEdpdxIA7OjbTbr13ARFt7FtQFp3KaIoBmuFnTWwfGZqWgZCb8?=
 =?us-ascii?Q?EqEHmqLZMRpHkiKn1kUVi9ZM9pGT3xHEJL9M5qqUvKKEv3dXoa8ZsrdRA77f?=
 =?us-ascii?Q?dS5Hvxd1sg=3D=3D?=
X-Exchange-RoutingPolicyChecked: XwqQFo8Ew3O8J6CKtEKJiK812KDXg9c3HjDyMJuhOKSrFnf3khOAJ+5HJ7UVd8dyg8CxDtD6e1eaf4C0QIJSdSUnGUoH3gwHID00By9cCWGwdKz1zz6r+5WhUel+dnKVqvaU2JjXg5RQehtUp8R36djH9GAam6ER7AIp2NgUyWF6uTLpUZZ5xJn9qS/GVEVmytn+1BQQa9HlPkRMO9t2XamXHFVii6jejB2+N1voV5ntoyguTEzP6YEytbmW3wVcsaeMV5jzRFaX9/1nUwcih7h4YpDGOc7CS+rlHjoDHZvGJ+eNUqBkp19PkgUMAyKLwFdv2R6iVhPhkmETAd/o4A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03192375-2be6-4469-ee13-08df449e0d0d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6750.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:29:32.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrUU+Ftd0a3pQ5/T/NanNMON+UjSrnh+pGBVNLD3GUkORLM5dD4h91GCVNPNhpeVJ0JW6z/CvL0A9aSVoTWJWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11995
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0NSBTYWx0ZWRfX2bXMXFz9+SAF
 Il9t/Flk5fKcSu6Y+u0IYN6MLVEPLInpc5E9mZ5fYBoHG5xO5wqWnLYxkhwMFtnk+CqXT8kBPLU
 FYAZbmWwm1U406D5tHUFiDp9msEj8iGowGxqlIueD0wKbUZ46ydgkl7Bf+l/fU9yNdhSw7ms9vV
 +NkwF98EOLhn+EkWJBBke/12GL2y4ZPK3AHr6ko5E9H1VtVdCiNd9snQhb7UANgoNLvGwFEa/1s
 g2E88n7aHDD6aZas1iyud1AwGGsfBjVuQ8mqPfpUbMC5oZgfalaHFHqzB4m0b5GinDCFECOWSOj
 sRF7ic+XfsBzCFnvYI7Bnhhjce5GJMSGYtYPkhgg+25s/P4Az7gKkfDcJ/9vKdscokesFIw6/c6
 LpK9cs0fa776V1H4XtcLdoUz11CuQ1pRLcjZDf+Ee7GAtYOcrNgPKE4gX7K+XvhoT5POG9/Tb+K
 Qc3Ut5e5HeOKIscxBpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0NSBTYWx0ZWRfX2D1WL0MQ1ODa
 lXw2kpxLGdEWhhQrhnwmcLYbuCjqdpLwq7mkTg8RXC7CmMmmg+DF5HHBLlJWN9P7UCPYB4Rzhj2
 N6g6XR5qDyhic9MYSGyvKgtfcixfUkw=
X-Proofpoint-GUID: YWGVrr_rQUYlaOgr-bXc_kj1Zo8XjHFx
X-Proofpoint-ORIG-GUID: YWGVrr_rQUYlaOgr-bXc_kj1Zo8XjHFx
X-Authority-Analysis: v=2.4 cv=dMEzC+Zb c=1 sm=1 tr=0 ts=6afc3a9e cx=c_pps
 a=qlOeM9M+GVnUADrBhXwn1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=LOXx0nSPSM6CBow_u5IA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:25:42AM +0000, Mark Cave-Ayland wrote:

> > Previous was optional, now default is always present. Can we clarify?
> 
> I'm fairly sure "Optional, with a value of 65535 (64k-1)" is intending to
> express the default value if none is supplied. John/Thanos - please confirm
> that I've got this correct.

Yes

regards
john

