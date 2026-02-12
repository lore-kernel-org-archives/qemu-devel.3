Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E5EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQS8-0006EU-0d; Thu, 12 Feb 2026 01:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqQS3-0006E0-Gq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:45:25 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqQRz-0000bn-5L
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770878719; x=1802414719;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=ldpleQ3hg4W5vsxwABdolrEq8dliWhKjIkvwn7/iUzY=;
 b=fDG9hEBoU52HXnec4ajCApOI2RnElQRtLZlcQV0+NtMOnBCyKiIRZZoj
 kYNZMaFF6AfAxhn00Vsphj+UdTEXoJrt1quUZX1TZLVQ3MWUMFW7cdkNb
 I3KFyWCa9Vy2MSrvodFmNB90JzzLxWye1tqQRDiI5qt+F13DaBHppxezu
 nqnLc0yQHPWjFT/tOTKXrg/0GBwiwNPgE7fy8WDMrlH20QguMtGAMRpeO
 k/638rscdF32oe6eS04+RI2vQ1Og5N54Qc17sYXsCds9NDU4vWesu+WJC
 +2UrJj70AW7dgEQ2l36Wr0cuMPk4hZbbclPGIgZG+RWow99KBvIufNKEO A==;
X-CSE-ConnectionGUID: TSJ+aulqSuOfxvA9k09++w==
X-CSE-MsgGUID: J2luSwE3R+KvpWKbeyfALA==
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; d="scan'208,217";a="46389269"
X-MGA-submission: =?us-ascii?q?MDE8EwqinxJCaDw1cpHtGkfH9AFo5GXMBUK5vs?=
 =?us-ascii?q?YSoewUhtVeZdOUy+R2wRohL/eP0GCWcrMWgCp7cUm+UsFiyIPP5IuLZ4?=
 =?us-ascii?q?kUDpPwr84SWaZQ6vgD8UKcz1EHP6oUEfUAe4LOf79UST6al2kFdV+H+I?=
 =?us-ascii?q?U/2lPFbJ4eRBUHmxCABJ5A6A=3D=3D?=
Received: from mail-francesouthazon11011019.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.19])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Feb 2026 07:45:12 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1C/jzKdjey5ggtYMSMobZicob0Sr8hoFSJ4SMeWhYnXIfUlivu/csKBx07t+59IT5f1gH16swi0ecKJTEjH4tz9QMIdr/rIlMk0pY1xeXgdST/coSSoeB1X/f/xe/L8b7KNAgkAw2B2drLn3xTYGy6Kb/ryHqEvoUHrJpgsUYCtZsLVY2oyFwP8R+pQ82ZT6oALLJWH4DpNaLgyI/iXgEQOGryqFySPeD5Axg2yksQCAAMk63siJwZVaGu8+2e9yFPj4eQ6+HO+TuftgSY384eq4/BU/rJVElplj6rLfL0DcLQhm9heRnabyrH9xuelmybVM7yfuvnkdxgJLHUSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/vmA79wxI8Ix9rnNyyHmJCWQ3RLcr4cRX1EhD2C9gU=;
 b=EiH25TivnLnjMhAlhF0tKPXvd5eTNGDx3Wpro0e1UM0F+pWG976/rPNJMdP84K4L6sLJyuelknDhAnsEetoG+cNS/Lvr9qOOZK3UUqKXststCuxayWnsmW2OPY8jNSwU68XYQqPmc3M2rWzD6Lnd0jkwRssAsMEgWtglCsrWtJkRSuVaskWjkve0BG77IHyoUTbrVPHyXybA3dvqamKTetESzjupMbLCjhbzcnDWrmoO81AWSPiSR/7vSz9DUi7X2XRV9BXKkwqEIdNMRcRUKQ7BJT+WEcmunDWF2VAmBUZ17QsZayBKy+Jl0gnGv65YpuoL03f5oKtXxkUsCo5i/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/vmA79wxI8Ix9rnNyyHmJCWQ3RLcr4cRX1EhD2C9gU=;
 b=ivSjGN7PRbGnba5btuwZo7urYUjGKUooloJQy/hYkRfMmAfxC+jBlL3f/kMTeLO3ahJ8IXYx8eJduhhQgy03oxEvEj1mMRiMy1+p7ObE/2CRpAmar4rGFYtCbhPSxA9CTaB+scaJNOfAOlQUtG38PPSE89NLFhK/OPu2yJCFWrAQK26PwakdTMMvDeREZ2CE7IrYRibiIyfHjbwap85bC39CbHaEIT5skxeYvEx8ubrDN3MZrfPLE0WBIpBzGKkVmMc2gA5aqKyrVAbOz6IQ6JLx+sTtrCT6THh/u/VxX6v1cUgbVCOGEvDecY2uQJ9gNRnrVSKLLtsaZPPgQmKx1A==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by GV4PR07MB11617.eurprd07.prod.outlook.com (2603:10a6:150:2e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 06:45:07 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::5df5:6816:4d46:4648]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::5df5:6816:4d46:4648%3]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 06:45:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Topic: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Index: AQHclk1A0jbRvwQcXUyYvASyugR2rrV9OhEggAAecgCAAG5A0IAABmgAgACZG4CAAEMx7g==
Date: Thu, 12 Feb 2026 06:45:07 +0000
Message-ID: <PA4PR07MB761339215913CDD1C65547718660A@PA4PR07MB7613.eurprd07.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
 <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75482AF23DD73B2D37742AFDAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYy+AENRSGdWh0Ij@Asurada-Nvidia>
 <IA3PR11MB91362AA3967AD60A6B27F95A9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91362AA3967AD60A6B27F95A9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-12T06:44:46.296Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|GV4PR07MB11617:EE_
x-ms-office365-filtering-correlation-id: 9726e263-3085-494e-87c8-08de6a024285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7RYiBWTH3FlG5IzcpxF05ECmaGM4biC5eEkdtsrMkCwKwfnHvPDqeuejnK?=
 =?iso-8859-1?Q?ZZEKAyM+Z0Js2Hr91njAjkf5R3DDLHjglZ/KVIobh9FV06r9Pcgu0Rms1t?=
 =?iso-8859-1?Q?zRYxPhcSMPhAp8AyHKYi80Q+3vw3szfeaioZsSRu7SzRG5RRXBa0O1omx0?=
 =?iso-8859-1?Q?mtiZNIwZUn1Yx9Ae54z6q3yS8f3QqxBRfrf1iMHqxmKtRdsdiEIKrzsFbT?=
 =?iso-8859-1?Q?sk14cJITEzEaQ3SQ9TcBrbGQKzGq7e1t581pl2Qmnq15vvZXorq9HnxvDp?=
 =?iso-8859-1?Q?8FbxFnuccIIBOpbkD1VuF/glBuiWdCflmuXcbDQOlwGztknEcRhAMjgC1S?=
 =?iso-8859-1?Q?VAzH12yh8HtoVRR+bMrlGCt0AqS2KlkDyHUXpuCfx89CziuAHNIcauS8mn?=
 =?iso-8859-1?Q?i5epz7SfONh0VzUZo51Q6YMfKj3n00NoOxfUfNTEgPAM2+Fp+Bjbrg4DyM?=
 =?iso-8859-1?Q?VueoGXia8v09zxY7OiCZRHrgBxagtvXMMTJgkZXrzAPt4yYRmEYE/PGp1r?=
 =?iso-8859-1?Q?5HqjyQcUqRG7K9U0dfwE+qWiE2FJOS3QaQMZnWIIddqwKj5WlDItXixEKi?=
 =?iso-8859-1?Q?hDu3KkkF4GZkaXf38pHMCGxzRNjXqVg7SxvX9XcZsreeXVP8+xc8WoVkvU?=
 =?iso-8859-1?Q?2cbZKKSv10QV3UZOQ/eT3ZGAPZVmNAbwEN5Mx7IlFhu7kwwbUpDj2N4cDP?=
 =?iso-8859-1?Q?DfovxvnAuthezN3GOjKHBoN0upAhZb4admC/aydF0CAlVtYJ53UpZ5p6Tn?=
 =?iso-8859-1?Q?lA17jpyI61z+O04xcHp/XLXqBOq+WMZ4uDXpKn5uUX24wqg7ORypPRa+CU?=
 =?iso-8859-1?Q?QcjYMGZtfhCY3xbZNmTCHwGNG1WoMxPHjB3cNHCGnQ+InvqA4H0bwr2ThM?=
 =?iso-8859-1?Q?hvS7kXL1TKcpTBykw+cSHnqQ2FPGYdwFhEqAoFrRrSYYA+yDsHFORFNkrd?=
 =?iso-8859-1?Q?2flhK3SqruKN4IFzNWHX2qHDPcPhbCiBcfUVKotbt3FarkHuJd7jEWyV1l?=
 =?iso-8859-1?Q?fuDxiczRFzP4JV7ylQNGlW07GC5UvBNDp3nj4cjB3m1SipNXEjl44WNNum?=
 =?iso-8859-1?Q?BgDHYp+j+kOpAgYUEzc/HZ7KH1hFfDWdlHP1x+Bvi3TocQHwnGlolrLduy?=
 =?iso-8859-1?Q?OqWW4JZfPF0AUQgKOJ7P1BUPCSInsfgM2n5cMtdKhHudsRssp4C4G574fi?=
 =?iso-8859-1?Q?QB3mHd7RbX7fV+prwVMh9DivcrII0W+JEerMYoyGtCvfgUnzCMrstIV+s2?=
 =?iso-8859-1?Q?fdLQJ2v6/yVg5ydTca2LBdFnxq7rLgnT8iMlE9OYrRvaHMELuJF/OS0gJT?=
 =?iso-8859-1?Q?8nS82BMoUs7mTBmfMVXxK0zjj49zNr5o1DtWSb0k6xTlVjbZ5iNn4dKByf?=
 =?iso-8859-1?Q?GTAqmvCYikSUqKRngZDORcNhpiCCmQpACC81f3PU1Oii/++lIfQ2JDvOr8?=
 =?iso-8859-1?Q?5RpQJbhWunXWjUyfn7uxcOYDHzSSL47oNS5IFN1HM1mRPAdjkmWKDt0/Tw?=
 =?iso-8859-1?Q?2qFqL4a4d4Klj+Al+nmzojP5Aljg7tL2LmMq9K9ZWkMzlZROPkdpsYrZGE?=
 =?iso-8859-1?Q?BCwhYdl3bDbCCBRBhfoS7g4oSRM4u9BPSbt8V1z249spwgwtVcoV3qqkdm?=
 =?iso-8859-1?Q?dzW0P4/TjUwAKD2dM5qLBheiUJiQk/GzRsgkcL7uLTJMTHzAGdjR1+XaOV?=
 =?iso-8859-1?Q?DjJ0ozOfYenWUEGXS5c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mUh/u6edfD+obC1IMjQn3P62YwD+OfcM/SdWtRlGXG6C5PDBTwf2HQnDzm?=
 =?iso-8859-1?Q?xRd9SKJ1Km8eFWOxo9+kaBYIoFrWjpI8Oak3ecJr46Y3q2xTpTln/3rCsI?=
 =?iso-8859-1?Q?d4Vuq8d852htGYo84HKu6osgq6ioUv2oSKYPqoyX0YUJRv2hBFGzrjzA03?=
 =?iso-8859-1?Q?A6Ecr724vl02pB40cRnAmgnzJKHBKju8Mc6vrP1AhDxZzAbhXZZWS9If3o?=
 =?iso-8859-1?Q?AMChaWvWD4je9RXsrWKggwBHK8pvuadsVsNWktlSYer40E0wOZyeQit7fJ?=
 =?iso-8859-1?Q?bQl/6owCW9vcjnz5tuHUuZHJwB738GNWQP3QGvM+mzgcQZMnFh1u/GUaWB?=
 =?iso-8859-1?Q?RSUAPwGttRd5apkl6Mc3VSNqSyO4djUpkHwocBAqOnkFjarhnJYPGMQicP?=
 =?iso-8859-1?Q?vV2SvqwBkQBAfjbQGbcfc2wr+qDWPF9xxM1BwBDZh/jPiY9g7jQT+CbXba?=
 =?iso-8859-1?Q?KmQhratCWrjc+7bAh2tlXiea+e3WUzdrIFCQd5kYo9mUQTWSE+JUWvECiI?=
 =?iso-8859-1?Q?QPfLXQZkYePgi5qSgHCSD8duv+gdyjqPYbGGJ6Esu7vM1/JJi/MKhQfUDt?=
 =?iso-8859-1?Q?kyc/vTBQwnI0qPRcZJnNZh16mpIHSMRMiLUOfGqBbpDCECLYR+LB0UOAK5?=
 =?iso-8859-1?Q?nfb2TKhUcq8lcx+NXxKcD/Mk80Wsu51mJnjVVnKTUA4IODZ2tyoVbjxrvt?=
 =?iso-8859-1?Q?sFGraT+L7yYXw0zgMoyOsdmIJe3PEfFtQaaeS2zIgoNZHOr5e0ayFNNnTI?=
 =?iso-8859-1?Q?BTc22iwKMOrK5vWD2DTKa2+GjwsM4+6FzpzZs1VvZuweBJViefVk3G28A9?=
 =?iso-8859-1?Q?79lwsm5ZfMkBp2QPYNiAmGCaCzXVv9JNpEIsEEqjAIxRJJJN81WiSajuBp?=
 =?iso-8859-1?Q?ah9mHK0hV1tPqv7f9My5ID9YPd/YqfztTIC0eL9QmOlVk5pudSTtmcG55Y?=
 =?iso-8859-1?Q?ODPncxyLFT/li8Cui0+8aRbtluZt9tSUTDHKGqPNBaAHsxM29/YYSoCwM6?=
 =?iso-8859-1?Q?TtnxVm3Vj28WU8eyvkffyxqgW07cgTbqcuZrppEPFzRc+Rx4Wy6XhKrsoN?=
 =?iso-8859-1?Q?OlQWO8ftfi2kSe6Jxl7Hsm+pewYwYDjgLqTnkkmcm95+H5osCYep+jFz05?=
 =?iso-8859-1?Q?srqmQLg9+y2jioeGVZaaHVBC87MpyfMCoEXrwbBelQevt+vYEmPgcYCVLN?=
 =?iso-8859-1?Q?oA7tMNTrL0hJvVUStJo9PABcGUWZ/JJSQjLt+WcZFNNetQldz38YTJqSgU?=
 =?iso-8859-1?Q?AClIGCu3To4pWFiAASxdfO0VtOd+LClckC8YsNGoDbUYbhq6vsdMB6lP7k?=
 =?iso-8859-1?Q?P4PJVwIISWvKMPLfADz9stK2T+LQn53zifGIjRYP/1+jNt55745ysGhbSs?=
 =?iso-8859-1?Q?dW7x++VVt/luxX1lhA1xGcn2ZDqU44tPoM1URka19dWudo++FmNgST6yVT?=
 =?iso-8859-1?Q?s3ExswMo9y3hL81o5bdqRb4IiLkuJViNa9ZHXNQ23D3h6W8K6KJ2YmG8Vv?=
 =?iso-8859-1?Q?bIhhRqfvlFqDLngzN4E/rIdUO24qimn3kDacT86EAvcxp0sf1gYjHsYwGP?=
 =?iso-8859-1?Q?QpWht0UhOAL8WJjWiY95CW1NOxxBgXL3RxSFdBOJmN3ODFNgk9VPwjRv6D?=
 =?iso-8859-1?Q?MeTWC4EO5xE44wKpNZPuT8zilsG7dR6RCI4I6fOiTBw8F3+6iy6LWJzI1M?=
 =?iso-8859-1?Q?ExtqtSdb8GapIfjNloGGYT4SN0KuAJYJs7+jmZf9LphJFQ4ZMZ1p1t/9Nf?=
 =?iso-8859-1?Q?GYABTDSHg/nlgsbu2A0J4bOxsjDTvXiHOGFHV5l2qfMn1/vn+qLaETDi58?=
 =?iso-8859-1?Q?8ttAN8+dKQnNCC5g5xFMlvitljT3ui0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PA4PR07MB761339215913CDD1C65547718660APA4PR07MB7613eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9726e263-3085-494e-87c8-08de6a024285
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 06:45:07.1699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsIU9bNnZwrdDBKNvgIZNfTLyWFOV8+VLGwAei3oJ5phhekUHgUF/yWpDg9TplX3TO3ySSajwoZPEo5i9gANhLGNmP0/ve1JmRkhXn8QiCv/h2bNRZ3wGNZkFUExL46H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11617
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_PA4PR07MB761339215913CDD1C65547718660APA4PR07MB7613eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

What about PCI_NO_PASID?

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
Sent: 12 February 2026 03:43
To: Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi <skolothumth=
o@nvidia.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; alex@shazbot.org <alex@s=
hazbot.org>; clg@redhat.com <clg@redhat.com>; eric.auger@redhat.com <eric.a=
uger@redhat.com>; mst@redhat.com <mst@redhat.com>; jasowang@redhat.com <jas=
owang@redhat.com>; Jason Gunthorpe <jgg@nvidia.com>; joao.m.martins@oracle.=
com <joao.m.martins@oracle.com>; CLEMENT MATHIEU--DRIF <clement.mathieu--dr=
if@eviden.com>; Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@int=
el.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach ca=
llbacks

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
>callbacks
>
>On Wed, Feb 11, 2026 at 09:14:33AM -0800, Shameer Kolothum Thodi wrote:
>> > > Have you considered extending attach_hwpt() to
>> > >take a PASID instead of introducing a separate callback?
>> >
>> > Yes, I did. To extending attach/detach_hwpt(), we need to add two
>> > parameters, "bool has_pasid, uint32_t pasid". E.g.,
>> >
>> >     bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev,
>> >                                          bool has_pasid, uint32_t pasi=
d,
>> >                                          uint32_t hwpt_id, Error **err=
p);
>
>The RID attach/detach could be just pasid=3DIOMMU_NO_PASID without
>that "has_pasid"?

After further thinking, yes, we could.

IOMMU_NO_PASID isn't export as UAPI, we need to define it in QEMU.

>
>> > and refactor iommufd_cdev_attach/detach_ioas_hwpt() a bit.
>> >
>> > I'm fine either way, two separate callbacks just look cleaner for me.
>> > Let me know if extending is preferred.
>>
>> Since PASID attach/detach is essentially an extension of the existing
>> attach/detach flow, I would prefer extending the current callbacks.
>> I think that keeps the interface simpler and avoids code duplication.
>
>+1

Ok, wll extend attach/detach_hwpt(). Thanks all.

--_000_PA4PR07MB761339215913CDD1C65547718660APA4PR07MB7613eurp_
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
What about PCI_NO_PASID?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;12 February 2026 03:43<br>
<b>To:</b>&nbsp;Nicolin Chen &lt;nicolinc@nvidia.com&gt;; Shameer Kolothum =
Thodi &lt;skolothumtho@nvidia.com&gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; alex@s=
hazbot.org &lt;alex@shazbot.org&gt;; clg@redhat.com &lt;clg@redhat.com&gt;;=
 eric.auger@redhat.com &lt;eric.auger@redhat.com&gt;; mst@redhat.com &lt;ms=
t@redhat.com&gt;; jasowang@redhat.com &lt;jasowang@redhat.com&gt;; Jason
 Gunthorpe &lt;jgg@nvidia.com&gt;; joao.m.martins@oracle.com &lt;joao.m.mar=
tins@oracle.com&gt;; CLEMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden=
.com&gt;; Tian, Kevin &lt;kevin.tian@intel.com&gt;; Liu, Yi L &lt;yi.l.liu@=
intel.com&gt;; Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [RFC PATCH 01/14] backends/iommufd: Add pasid atta=
ch/detach callbacks</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Caution: External email. Do not open attach=
ments or click links, unless this email comes from a known sender and you k=
now the content is safe.<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Nicolin Chen &lt;nicolinc@nvidia.com&gt;<br>
&gt;Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detac=
h<br>
&gt;callbacks<br>
&gt;<br>
&gt;On Wed, Feb 11, 2026 at 09:14:33AM -0800, Shameer Kolothum Thodi wrote:=
<br>
&gt;&gt; &gt; &gt; Have you considered extending attach_hwpt() to<br>
&gt;&gt; &gt; &gt;take a PASID instead of introducing a separate callback?<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yes, I did. To extending attach/detach_hwpt(), we need to add=
 two<br>
&gt;&gt; &gt; parameters, &quot;bool has_pasid, uint32_t pasid&quot;. E.g.,=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bool (*attach_hwpt)(HostIOMMUDeviceIO=
MMUFD *idev,<br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_pasid, uint32_t pasid,<br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hwpt_id, Error **errp);<br>
&gt;<br>
&gt;The RID attach/detach could be just pasid=3DIOMMU_NO_PASID without<br>
&gt;that &quot;has_pasid&quot;?<br>
<br>
After further thinking, yes, we could.<br>
<br>
IOMMU_NO_PASID isn't export as UAPI, we need to define it in QEMU.<br>
<br>
&gt;<br>
&gt;&gt; &gt; and refactor iommufd_cdev_attach/detach_ioas_hwpt() a bit.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I'm fine either way, two separate callbacks just look cleaner=
 for me.<br>
&gt;&gt; &gt; Let me know if extending is preferred.<br>
&gt;&gt;<br>
&gt;&gt; Since PASID attach/detach is essentially an extension of the exist=
ing<br>
&gt;&gt; attach/detach flow, I would prefer extending the current callbacks=
.<br>
&gt;&gt; I think that keeps the interface simpler and avoids code duplicati=
on.<br>
&gt;<br>
&gt;+1<br>
<br>
Ok, wll extend attach/detach_hwpt(). Thanks all.</div>
</body>
</html>

--_000_PA4PR07MB761339215913CDD1C65547718660APA4PR07MB7613eurp_--

