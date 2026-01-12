Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05B6C9EC93
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIXV-0004xH-Cy; Mon, 12 Jan 2026 09:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfIXT-0004wJ-Di; Mon, 12 Jan 2026 09:04:59 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfIXQ-0001ah-E4; Mon, 12 Jan 2026 09:04:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjuMPl4WMRWIGLXoxQk8i+Mv0rVqON4jkAy5luKWOdgp6sVwoRxdX4aob+1udcKjSOkTLv3mrfEQlO4prwaO1ISRjtIHFz0IJvnGF1U4V+jlSQyyECXmXXMa7Mkoyt42buRcnUuSfvKJq1r2GEWQgrLwiNnNjv1wsyj5d+2pifp8Bjcb2D6imhusdzMdmTRduWICMHs5sy+mQ4S0vdToap8CQ1gz1Fr0q3LJY01I9itHImyk/L9zLzcD2RBla4pDAEE8Xe5KmNh8mgZ2uPW7IXhNE0yE7BYN2bNPOo+gmnL16erAuMyEnv9IHQncuvkwVkzwrtoRl8I1maW4NU99DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MMRitG49QpsUZwJZn6v4Fjkii0FWUMQBrTPwl5GwsI=;
 b=A33zLBB5nyKQ3nv0qjUKcwcMBdbOz8C3fPz5o1FUhrnLK9ncANzpGSC7e46klq2M2ZjLu6uUWbFDfMEBg0U4GcA02SaO2T0Px/MLY13D3PFgeD4f9Pl4wsprYBTIH7RhEkF5bfm2g7fLanJNhAZ3gFmcAdqaQLMj4qoe98HkFvV+OBUn+Y3tjpHJo37wyGVUAFtnJ1PUQhQbvMfR+Og3pps2rLKFs7JIEaAQz2l05Kf3AquVggTeew75LqnoTTx9PWgB2nXzf/t1H7zxt4tSXsN0wDKGWApp6xyC1dPMVTd0xgMo/sUP+Rp5UYNQlFJFiOzaZfyLpb0Dvu7MKy+OvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MMRitG49QpsUZwJZn6v4Fjkii0FWUMQBrTPwl5GwsI=;
 b=sl8frrbLx5wU9AgjMlHLrfJ/nL678GErp3d4kHT/vcAhRIBRpF+nH0vS4Wokz1jdRi4EGcHhDTdQfej+VB9mHKLiCbCpNQVjHb85a/7SbzhRL4z2+W2hQ3bn74RjwfLs2Qw1zA7mXgXC8KnSFNvIat3tcyktPavOwo3qgilI4hDV3u26Q8j7bKN9DnTQVjpDhR0guUjoaUCCZj5u08LqjuQDeRldHkBEIe40qzbTmt+1aWoX7f3D+09sXKqKNi+xYTEbkoC3amiWoLR+CwCSHH3bzhZPegQWsmbCz2KHJNTQBYzaN/gAyk7TrKQ7RgDOUY+padNpMkBj5BCZF7xZ7w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:04:48 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:04:48 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v7 01/36] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Thread-Topic: [PATCH v7 01/36] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
Thread-Index: AQHcg7jpEFuwY56qnkGCm/xSpjT3M7VOkB/g
Date: Mon, 12 Jan 2026 14:04:47 +0000
Message-ID: <CH3PR12MB7548A50CE7CD0E8089879490AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-2-skolothumtho@nvidia.com>
 <30913bca-0c73-4448-82e2-02e1ea42cf09@redhat.com>
In-Reply-To: <30913bca-0c73-4448-82e2-02e1ea42cf09@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB8122:EE_
x-ms-office365-filtering-correlation-id: 35ba45b8-89d1-4eb1-3bcf-08de51e38bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UTVYNGl2SkZKZVlrbGlRemluZ1NXMExrcUZKMW5iSExtYUJVaG5RRUVXcUdN?=
 =?utf-8?B?MVdhVEtpYkR0cmtZL3Y0MlBkUDAweGY4b2h0NXNGNnZKS3grSTBXUU5sWlJS?=
 =?utf-8?B?TlRZSDl0eHo5NDBITkl2REhHRDRUTHEvNlY1a1ZCNkhjcXp4MFFYN0pVSFVN?=
 =?utf-8?B?RHNSQ0huWi9GRmxIOVBOVmZVZnRBUTlvODdac2FyeXF6eStLK1hRMDQyQ2ti?=
 =?utf-8?B?R1dMbTFPODZ5SjlPbit6cGZ0US9TSlpDMGVtMHpXTVFDSUV4Mk0yNzREQnN4?=
 =?utf-8?B?UDE4eG5mMURpYVFnbzNjM0tUY2RUaG1Oakxod0laenE0S1ZiRGNWdjBjRGRj?=
 =?utf-8?B?ZjB1ZS9kalNod2kveHVnbE5hRk5xTlRYUFduS2RCcWZZTzJKQnJaQ0Y2NGFz?=
 =?utf-8?B?amdjTngvMkpCTzl4bXIwNkNRVlVkNlZoWFBTcmEydnRzbGFWVVRlcEt3bXdi?=
 =?utf-8?B?L0dhYThrU1VhT2NNeUNySHhzZFJGa1YzNHRkeUlFazJJaEJUaTBxYy8xdkF3?=
 =?utf-8?B?aVJxSWRTVExFTW5maWVlRm5vWmx5WncrY2pVL0duMGJWNmVZSW1yVXgwR1Fo?=
 =?utf-8?B?WEFTeFBsaFpUVkdyanorRThYclF6L1piK1h2bkg0WUluTUdKU1UzT21JWTAw?=
 =?utf-8?B?Ukxza2wxUnJmQmRKWWx1MjU2WHRMZkU0UUhZWXF5dC9WZEJGQk1ZTWJIcklk?=
 =?utf-8?B?R0VrN1NiblBteHBBcW9XbXhzeHphNHdOaVdMd2xoMnd4RkRSRDRNbnBjeHQr?=
 =?utf-8?B?bXN3SmI0RVhwcGNDRm1CTXNOV2Foc3dJOGFtWlJMalI2TnNTMi9uekhJNlM3?=
 =?utf-8?B?eE1VZDMycWtBQ3Q1UVZwcGxsaVpjQmhBVnRLOUVzRnBmaUpIVDFDVUZ0aDVK?=
 =?utf-8?B?QnoyeFJmdm80VXBUK3djUDl2Z3luYklSVW5Sbm03TXE5ZXltVlh5WXZQcGtz?=
 =?utf-8?B?Q3RwWlJVUXh0V29HUlFTT2lQT2FCbkFmQ3NXeDdkQkxFTmRFNGNLbkc3cGVn?=
 =?utf-8?B?dmhHMWFhbUp5cWxEeDNHUTZDNjVNTnI4N05mM3BLaHUrR09xTEVWVWZPRjBV?=
 =?utf-8?B?TWM2VkhKdW9JZVg0WUcrZ2tOem5nV1B2VUxPbDV5UVB3TGFwbWlEZHJJOXA2?=
 =?utf-8?B?Z1gvNVB0YzVxK1ZVMUFGQ2xzaE51ZlBGMzNpVTM5RVhJUk1ROStnM3VHaFg4?=
 =?utf-8?B?a21ZY2FKN1VQeVlkVFdiZVVpMHhramIyL3NleTVqVUMzaFA1b1JXaDh3eUl4?=
 =?utf-8?B?UDJCRTJhcnBmTy9VT3NMcEd5MzdRVkJjKzNUU3lHdFY1UVhlcmZxYldIRmsx?=
 =?utf-8?B?T2tDT1VuOG1zM2JxZ3E2VE1nYTRuZTNtcFF5KzI3MHJLRGIrYVFtZG9qWWdU?=
 =?utf-8?B?Ukl6dlBGQW5SMW1hNmRGVm1tSW1oYmtXaTFIVlk2VnJnUW1La0dQV0h0a2lq?=
 =?utf-8?B?YkZJbXdiSjF4a1o1Kzh3aFliUnNGdmptZmpwR2NERVBuOTdRUTZhQWE4OE0v?=
 =?utf-8?B?Z2VwTnRUR2YyeVBVYXFZQVpEbFpTbS9KWmdlbHVaemJYWDRlOTNRWnpBYjV4?=
 =?utf-8?B?ZC91OVpMYlBoU1lnZXI1Q1QwS01TTERtUXYxYWdrcXJRcHIxZEVvMEs3d0RW?=
 =?utf-8?B?NGFIQnBYRGpDOTllbjZrSm0rS3AvQ3ZJN1NQMWlCUnlqYjcyT0YrdTR1RnAw?=
 =?utf-8?B?ZmkrNTZqKzEyQnJ5RGNMSEFBaGltd1RRNVRyNm9hbENaR1lFMTRzdDVDR094?=
 =?utf-8?B?NjBJMnpQNUpZQ0FlTUZDWG56c2lRQ0lkekRMckMwTlEvV1FWR0UwWEZWOHdU?=
 =?utf-8?B?VnB2dFlXVGFPTlRoTmZqMGhrYjBxaktlYU9jWVUvWFRub0s4QXpFSThJMVpQ?=
 =?utf-8?B?M1pLcFlmYW1Xb2RaOHMzKzBwb3pTaDk4cW5USmJJa2VPbjMwRStGSkxuUVpT?=
 =?utf-8?B?STF1eXlFZXE1Um5LT3kydStvazZFTTRYS2lOQm9PNU0vWWNPVXNWOUtYamdF?=
 =?utf-8?B?dEZJNkZxMVd2V2w5TW9Gd2o4eUFHblZXaGdNYTZRVG56MEhBSmRkM2xtN0x0?=
 =?utf-8?Q?xIw3Jv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K01Od0wxdW5aRmliT1RFbWJVV1U2OS9Rak44b1J2VVdjNjZqN2dsN2VVUkE5?=
 =?utf-8?B?MUFjK3ZScjZLKzdYTmlLd1d0TGVoY21DLzFBdDkrKzkxTm9UNGs5REJkenpZ?=
 =?utf-8?B?OG1ld3FSK1lMQWxrOGg0d3RBYmYvY1ZSYUZvTkFQb3dRdnNiY2pWd0Q0Vi91?=
 =?utf-8?B?bVpNYjlMTmUyTzVDUlVFNHVqcnREYWc4c1N5a1pvOTlOMHlHL2I1Q2x6UEpl?=
 =?utf-8?B?eHVtMFpuM3hpak96K0wxQVhkcVNYTktRVCsxNEFZUjgrUUIyRENUWmhhT0RS?=
 =?utf-8?B?a1o1N1pLZkdyeXN0VmhxRTBFYi95UXRTd0tUMU9rSUJFUG80NWJMV0NqZzZI?=
 =?utf-8?B?alNKS3VzYkZneFJFbGhYMmljOHYyUURpczd2RDMxYk1uV1dScXlETGtOMFFu?=
 =?utf-8?B?dkFSS2hOM01FZkU0b0ZLZ1NPVDBPWUJ5R0Z3VTB1U1VDQ1M1M3kwNEhEQnZN?=
 =?utf-8?B?QTJxMlVSUUh3MHhnMXZvcVBaNjBLQ0RZOHYvTFZPemVFaDVydnlGRGZzUElL?=
 =?utf-8?B?akt2NStVYnZJN3A4TUllZVd3YVJSMmE3QlRsVFBlZjRzZ210NzNpem40WGl5?=
 =?utf-8?B?cWVVTGNDWWIybEVST0JJbUVjWXVUenFrOWdzTnhXU1pmcHM1eEoycC83bjVC?=
 =?utf-8?B?NnV0SlZOdkRuYWk0Vm9Wa1ZINHBUaW03T2hJbFZSdU50YWE0ZFJzMFJ2QkNp?=
 =?utf-8?B?T0FIUFRiSitsYSs4OHFSSVd3ZEtmWEhoeVhOZXB1aFZWeXBCQkNCb1EzRHBj?=
 =?utf-8?B?enF6d1kxbjI2cEtvb0ZGcWl6VGJjbUhMWHM4R3dtck1RNkJzYm95QjFEVmNz?=
 =?utf-8?B?SG1aaUdnN3ljTWduTGZPMDRqdjdnOWJDZUFqSkxKM09yNUZCc1hzNWJOd2JI?=
 =?utf-8?B?cXgwWlVtVndHQmdJUzhoOVVXRDZxUjBLd0FEQ20rZUxKa2huSTJHY3BzRHNN?=
 =?utf-8?B?cmZFcGY3dENhZTlXNjZTbVJpL1ZZZThhRkFTdjZPUUZsR0V3Yk5mOWdHRTRw?=
 =?utf-8?B?eXlGaUJZTG90MHdVcTBhSzlLUkZwVnlwSW03NzhHMnVPVW5qOXR2dCtnNTE5?=
 =?utf-8?B?OXA4S3hJTDlkMTBoTVdoUENkSnFla083RUhJcDEvc0lDWWNZd2Vadmp3dnpn?=
 =?utf-8?B?TENTUVAzcjZ3dEdhV3ZyUXV5MEMrYU5SeGkrR0dJRlhOZVdXNGZiMkYrWWhD?=
 =?utf-8?B?c1hTWGtZU0FOQ0huZGo5bVEzeUpRSHdMN2oxamNza2dsa1RKM01Md281Yldj?=
 =?utf-8?B?cVJIMWM1UWFONXFmVmIzbFIvYURRVU1wbDRkYVlOOHVuRisvRHdEOXlKaVF0?=
 =?utf-8?B?QktyVFdqcSt4a2JuWjlkMW9EVURBVGFTdFpKclZvVG9BeTBTalVIbFRDOTF1?=
 =?utf-8?B?RGRDWVQ3cXBjNDhQTjh3NUYwUUZtMHdlNW9wWmM3clBxNTZLMCtsampBSWFG?=
 =?utf-8?B?U2VSejkzL2NXaElrYjZvTDVjN28rNXVBYkFtY3lLenhEeDVzMWJnK0ptbTQ3?=
 =?utf-8?B?c3VLR0pGb2REZzlmY3lzbXVERXc2RzFFVmE4UTZBZDVxU3lwd1VuRDBRWWM1?=
 =?utf-8?B?TXFjVDhaam5Pa1RRZkpWUUl0akVNamxiendIZ2JybkwvRExtc3FvS0VCN0Zl?=
 =?utf-8?B?THJTUmxiMVNCcExVbG12dzhEQzJBTHBhUWhGKzQwYjlmMGxRNXI5OUNXNzFt?=
 =?utf-8?B?aHBRSktkOW5ISGtyRHJiSGg0VWF3ek44dnVxMXI2MVRLakVWc29PeE9Gc1JS?=
 =?utf-8?B?RVlCZk9wVUZTblVvb0VjUGFkV0tnWFkvZkRkVC9IcmI2Ym1id3g4K2p2UWFE?=
 =?utf-8?B?UEZuN1FONDlFaVRSZXlPeUF4bnF4eDZYNU9sRjlCSFVvOE9jWENlZFpOSUMw?=
 =?utf-8?B?aWRuRHNvaEFmdGh0MXREQ1AzYTJSUE9xSjMrVTRreFUyQ011R3VGdFg2UGZ2?=
 =?utf-8?B?WWFuUjhRWTkrbHhqWTN6WlpEQ2FxZVk0L1BLMU1sN3ZKNFBHSTBONTI0SWow?=
 =?utf-8?B?aklaUUd0WUhmWkxVc0xtR21xcGY4RGlGV24yeUdhVytLbUR5dzk3THpqYkxO?=
 =?utf-8?B?Zk5kREQ4VGRNYjVQSjZucWxXRTF6VFFZLzgyenBpM3Y1Y0kvMDNCTVRtR3A2?=
 =?utf-8?B?VWtWN0QrVnMvRnlYSDRaOEtwajBwRzdhV2ZPWm91K2xFd3FVWCtBSXFTem5v?=
 =?utf-8?B?QU52S2J5ZmZoendCQk0wMGFyQ1lEeVNsMnJnczY4RDF4QjJMTDdhTXFydjV4?=
 =?utf-8?B?UjFYbnBFR0FKWkhBMnRjT3VrcitqR2RVS0w4RUJhaUxIYmFNa1YwemdxL2Nt?=
 =?utf-8?B?ZnZNNXhMSTBVWmcybkV2M2hxdEF5ZlRnSVVSN0FNbXk5dXI4bUxBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba45b8-89d1-4eb1-3bcf-08de51e38bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 14:04:47.6129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glTH/cufP94x/R4uqKc1KSeGdKoWh/emJad6sJqNKQMn1DlDD4aWfp9+oMOYFV8e7GtPvN04zETio1td4xCTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBKYW51YXJ5IDIwMjYgMTE6NDUNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJpYy5hdWdlckByZWRo
YXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZQ0KPiA8amdn
QG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxl
QHJlZGhhdC5jb207DQo+IGJlcnJhbmdlQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5h
dGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsN
Cj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0K
PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5s
LmxpdUBpbnRlbC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDEvMzZdIGJhY2tlbmRzL2lvbW11ZmQ6IEludHJvZHVj
ZQ0KPiBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmRldg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQpbLi5dIA0KPiBJdCBs
b29rcyBsaWtlIHdlIGFyZSBtaXNzaW5nIHBhdGNoIDoNCj4gDQo+ICAgImJhY2tlbmRzL2lvbW11
ZmQ6IEludHJvZHVjZSBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmlvbW11Ig0KPiANCj4gSSB0b29r
IHRoZSBvbmUgZnJvbSB2Ni4NCg0KT29wcyEuIEluZGVlZCwgdGhpcyBzZXJpZXMgaXMgbWlzc2lu
ZyB0aGF0IGFuZCB0aGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuDQpZZXMsIHRoYXQgb25lIGhhcyBu
b3QgY2hhbmdlZCBzaW5jZSB2Ni4gDQoNClRoYW5rcywNClNoYW1lZXINCi4NCg0K

