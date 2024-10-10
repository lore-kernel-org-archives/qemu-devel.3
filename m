Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F4CF11E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 12:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sysWH-0001IE-MU; Thu, 10 Oct 2024 08:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1sysW8-0001He-65; Thu, 10 Oct 2024 08:43:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1sysW5-0004dK-QM; Thu, 10 Oct 2024 08:43:43 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMZSJ024952;
 Thu, 10 Oct 2024 12:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=M7GGDPeZ0xyyKb5tuT8qYX+dyGIHjXsd/S94K4A8Rxc=; b=
 REcm7zR34syY38smFC3ZMtxDy2i0MBwButxyVCTLCtIzLvhOTGDsvfNha83fhq8Q
 74rHvjzZ5o0tJH4FT0EnNQuhqOFfQs31LyFZtR1XHjusEJRr2Zi+DmTWdb2ws3Hm
 XsfZy1XZrXbO821BD91h4G14/n/KGFq0J6fVpehn+4Xx7naDPf5YtlUoXubI5aYD
 Zpu9YjEm7S6xTjORmsNcN315AAnYUFxYLCDLYmXUHOO1xwNhLPPR/lotFXrPwzho
 synodUyD0vYKd+84/cnMgy7v5/0w0+2ZVWS7dNwOp6PXYkESSdZcufCKrpK/w6jg
 kjIRPQLaWXBtEAdOk+jNiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034u0gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 12:43:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49ABPYK9015249; Thu, 10 Oct 2024 12:43:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw9y46q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 12:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9HwTW1q3yTdleTEgR+5QaFiNU8SDfiOhHMmxcQsfSQYDg9kZ9IQTcS+wPPezB2ZeLs2LAoqB3HQqP4An1kEH0uqFkqJN3IPEF4wNv5ICW9A1mMTXtH7+hszbdDOcXG5NaT7+DCyHz0SeApqjGc7BODs3Ijd8NmmOGNfOANoWaXoXXuwXElw+8PyGmxQwFw3pNq+Dubz99J8Hyr/0mhmQyvU+hHaHuOi5EfCgHuJvVXUZiM1b1tXMyRHjh3xj1DsDNs/b4wN0cvCwI/LNWCi0Dkwx+E1n5UZ2rJW/K0iKpfRRlR1cAIcvjAg+qdhMCfm7YzdB8UKzeDETUuhsM95oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7GGDPeZ0xyyKb5tuT8qYX+dyGIHjXsd/S94K4A8Rxc=;
 b=vAbG+4qaYCHTTb8bDx2PVlxB6X5DgGlkWWiLpq7g0LjbZLp0fYrz71T4fH9+g015veKNkqowXHFlh9jWQDgxZ6i14qBByib/Mnj+9g9PVhHEroYg0eDMgZEDh7HotHIe2RN2uXRv9a7RF0piAXwncry4+fSuOw4g0GsNJKteNomRDJ7Emj/2nBa6mUTc0rT/7ahtLu19lfMJvkiBg6ydRY1uA9gaZZ+TkngO9OT7dnBJOjCpKaVbgs3u3W94+Awd6R2XAhC2T6nsjaeHRReZ1AfWtBSdUDoU53C3UBCSdYxT7x5TvDdKn3tn6QSvR60GzNXPipgPT2AWhFo/n0QX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7GGDPeZ0xyyKb5tuT8qYX+dyGIHjXsd/S94K4A8Rxc=;
 b=basfsqlFQseoniwLRA+N5QIhBwXPPtpwz0Kwq56tTBDhhY1QDjXQztjHXe8BTFIaKZ9AXbjut41nhuvFKv0pSgESsN4osVpxL9zmYh380LD3qYamTCTIL0pSiYS1E+QkGqIxJUJEtq4V30HPsxLJXOOYE0A+CxJO2zRKZAD1f70=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA0PR10MB7133.namprd10.prod.outlook.com (2603:10b6:208:400::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 12:43:23 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 12:43:23 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 "dave@treblig.org" <dave@treblig.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, Annie Li <annie.li@oracle.com>
Subject: Re: [RFC V2 PATCH 11/11] arm/virt: enable sleep support
Thread-Topic: [RFC V2 PATCH 11/11] arm/virt: enable sleep support
Thread-Index: AQHbEQzAGzfFNFXX0EWUL1WRNf6hM7J8zz0AgAMymAA=
Date: Thu, 10 Oct 2024 12:43:23 +0000
Message-ID: <5A3324A3-666C-435D-B8BA-ACDF770DA66A@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-12-annie.li@oracle.com>
 <CAFEAcA_Hnc84gKDnJgq6jbjNegJVcJUUAqTuSp99fvqoekBJSA@mail.gmail.com>
In-Reply-To: <CAFEAcA_Hnc84gKDnJgq6jbjNegJVcJUUAqTuSp99fvqoekBJSA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA0PR10MB7133:EE_
x-ms-office365-filtering-correlation-id: 17e2064e-1147-43f3-0b2a-08dce92920ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cy9NVmFpUDBmZW5ORFBkNmZRaGpzQ3pZK0F0cVRzcXBSMTk3aUlEL2NQLytP?=
 =?utf-8?B?L1FlU3JHRVNTVmd1aWdQQWorbW1oV1RUeWNyblFpRC9GTHE2TXBKZllvU3BK?=
 =?utf-8?B?TWRrNTB0ME02RWRNbjROS0FoVTRqMElRL2ZNOEU4TCs1QVlxY3pYTEpzQzRv?=
 =?utf-8?B?MlBqcDdiRXR6RU96QXNncTZCS1V4ems5QUZNSzIxa1JBQ3ZEeFk3b2VsN3Rh?=
 =?utf-8?B?OXcxc0FEdm5mMTlrV2Y2VFErQ2JxN3BzU1l2QnhENVh4MTBkUGtWTFlPbzJI?=
 =?utf-8?B?U0EvdlZpcWJsRGx5dE1Nd2VRUTNiajJJeTlYTjZzQUlheGUzdzM5MXRYdStG?=
 =?utf-8?B?NnNPeW1tVzUwS0ZWRnh3UC9SWTcxUStIMlFaTC9FYmhUck85TmZaRzdFYkVz?=
 =?utf-8?B?NUt2dzBzTFM3cUczYzVtaW5zVXI2SGNVam5DZkY3RlNHeXdBcGJzOE9ScDk5?=
 =?utf-8?B?VmpYd3k0b3hVUWQ1SHVyOGcxQzMvV2I3N0JMMmpsOUR2WjVDZk1Ma1MveWE4?=
 =?utf-8?B?bEJzeFBmVTFHZzc5cnE1UVdZMVk0b0JSK0lQM2lha1o3Q1MzcFJMZzE0ZHRh?=
 =?utf-8?B?YjlDWm5FVUFVRm53NFFpNmpnSFpMUDVlS3ZvWHBTanZiUk1xb2x3SFQ0TmpE?=
 =?utf-8?B?VFJ3VVROT1pZWG5QaTdaZEtUek53VU1IRlREZy8vNGE1Y1V6d1BpTXdvNExu?=
 =?utf-8?B?YzVmbFVxZ1g5Qmt3TVFxSVFldmFkTFF0aWFzYzZlNkduaytGUTJGUXlWaVVX?=
 =?utf-8?B?UjBrSzcwcWMyeEZVTVRrSjBiS1MzWmJhenpFZEdEZGFERFVwa1hzaXBidDJp?=
 =?utf-8?B?djRmaSt2TEM4RHF0eS85K3h6ZHZqNUVRRU44Rm9SZDRuaG9hek5SRm9aaDZk?=
 =?utf-8?B?MHdCakNNLy81TTJQTE5wd0xlN3JKVUE0QUR0Nm9Ka0Y0VEllSEdidSt5U2Mr?=
 =?utf-8?B?VFdIMU14YlBSTVNyYy9NS1BSNXhxaUd1Q1lmMGF0MW9MdlpIOEdrN3NQeTFp?=
 =?utf-8?B?L1lFcTBZdjJ0RElRQXZjcThSZDNjcjZpQkVnWXdqSEFGL3JhSnRtdWZFYUkv?=
 =?utf-8?B?R2dXbnByeGx4NFduM3djR2liMWFnT2JyazdGdkdCYW1HMmViUVUvV3NsS0h5?=
 =?utf-8?B?YmVCWm1uMS9jWE9TT2VYVGdxejR3SlhDV1p4MldENlpiNllZVk9sdktjaCtJ?=
 =?utf-8?B?SFNUaFQzbDJYOG9NKzZtSjJTb0M3bTUvV0hOZDFRb0tKaW4xTUMyVXM2NGcr?=
 =?utf-8?B?empVRUpTOFR0L0xHWlJycngzOS8vVTBKMlU1ZHlFb3Y4dzZMaTY0YXpoaGZr?=
 =?utf-8?B?bDQ2YWdVemUrb2pJaEVvc3NHQkhYcHhBMFJpMDZMZWo2NmNWK0ZrcDdMSFJ1?=
 =?utf-8?B?UFc2WVgwUXcxUkh6TG5EWmlXME4yT21HcnRHa29OajFNTllWaGdDeHltQktz?=
 =?utf-8?B?QUtCdzB0cVQ3cWhKRi8rc3liTkltWXNUNWlLYWs5QTQzeHlNc3lTYVJpOWJs?=
 =?utf-8?B?N2IyUHlnV3UxYWF0MzZQMTBlS1U4SFdmYWR5UEFUcTFKcXBuV3lUUVhjbVF0?=
 =?utf-8?B?NHJJdTJGVVpFQThrZHFxNDkyOGdlQkJPakZ3QWdpbXdxRkE3RUYzck9zMlR0?=
 =?utf-8?B?eVNldWQwdUg3ejcrNzNkN3B3Q1lrVW40RjFZZ0xoTG15WjdrUXFIMXk2UUlv?=
 =?utf-8?B?bzNQby9Db3AyZjVKa0FwWkI1L2ZDZlJDdWRrelVJbHowMEcvczhRTEpiSTZa?=
 =?utf-8?B?WUNlYTJ5RGIrRVBlVDgxRTVvNGxBTHkwVXhzSURsOFNQcFNQdnlHMmtnVjd2?=
 =?utf-8?B?Sy9xNTgvdHJEWlBveFFOQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGZTR1Nvc1hTeEJ6NGpZL3FiK2hiTlFUSGVwMzRpRE9jUG1Ha3dKWGdrZkhj?=
 =?utf-8?B?M0xyVW5ZQ3dQZXJaRmJzYXFCd0VtSG1ZRFZOMjBJbTdISkhybXRQWXJOVzY0?=
 =?utf-8?B?UjZWWGtXOVYrc2haakpwQjJiaEJNVmZ2NzcxUnZET2x3ODhLZ2s4WHFhYzNZ?=
 =?utf-8?B?RWNFU2pjL09SODFtRFhLTHA1SFRUQy9pUFpodFdqbm9FRWN1dnh5Uzl2bTlk?=
 =?utf-8?B?dVNSREpRbmhwdWdnWkdHekg5dEt3OHpvN05xYXlRMlVDbzUwOStUeWNSVkJ0?=
 =?utf-8?B?b1JNRGREZ2k0THI0SG40VEhQWGxYZFJab2IxbU5mR1JMZndyV2RzeEVldGRI?=
 =?utf-8?B?aGQxQmk5SExoVUlHMWFOM3NBUU9yUjdPU1RGSFo5c0hRR0tTMCtuTy9xeGtR?=
 =?utf-8?B?cGswQldDTGFmMEhORWxDWWJ4SUFabnMxL0JLRlpqOTN0RVdteHFZbjlDaW4v?=
 =?utf-8?B?bGIrRHRPbUYxODJpSWpzL0VjaFFWcVA5UlEwVVRXMG43aGRLWlNYMExFaXgw?=
 =?utf-8?B?YkpGMldoWFJJVzhpejE2bzRjRUZlNXNpb3RJOHdQMWF6b3JOR01PTXhUa0tQ?=
 =?utf-8?B?UjlrMEU2aWl5b3VKNXNyTVVJVGdUSWZsdVpJNEVnV2szc21DbTNzTGxKSmNw?=
 =?utf-8?B?S1ZIUHo0YU1tQytMRHppSzhGMFN0aGJXRFpncTF5YlFzbGtvN1U2bE9zdkp4?=
 =?utf-8?B?WGNMbW9VNTBIem41azg5R0VjSmhINWdxNVovRC9QMlZJYXFIREl6UURBVjNz?=
 =?utf-8?B?SWVpQ2NzNU1uUmdaNmFROE1zalloT05PZEpZbUh4YWZIZjVpVUk1RGNZODg0?=
 =?utf-8?B?bGF5dG9XSTYrMVZhcVlkNzNYYXkyME1CVTRaZW1FaWp3cENDQVF6TGN0WThz?=
 =?utf-8?B?MENQS3FueWdwcGRhOHdveTdUdkdKakt0WURBQ2hSaENoOW9TNUxFL2cyM2sz?=
 =?utf-8?B?VmVraWcrWTZRc2xxU2R2OEJHd0p2dllwOFowN1dhbkRLVW1qMno3MFJIbmpI?=
 =?utf-8?B?RGtjK2JQZ1Z4blgweEVXWSsrbEkzdUNtd2hwRXVrcW8vakNlTkJ4b1lQNUFN?=
 =?utf-8?B?MFNJN2pJc0dhbHIrWjlMY1ZuMHNRTHo1TVlERFFJQ1Nyc2EwdTkrbVpybE5D?=
 =?utf-8?B?MnY2SjllWFZWNmwvMlhNa1FZZldnaEJYYng2NEY4RDZmRG9tOUhPUGwxQlVV?=
 =?utf-8?B?cjJUN0pSVXhGRmZ0b0xGNlRpdkgzZlJUc1NFaUNraXJJc1R3aUdlSHNIdUN5?=
 =?utf-8?B?UUpKb2dVWjlWVDFHQUxKNWVPb2hEWUkvT2lrV09Wc09ucHU0WS81bHVRczcx?=
 =?utf-8?B?S2VCYmlweEtnSHFEczM2RG9NQU90bXVRc1pZdWxrODcwTlVBL2w4RnhGc1Zq?=
 =?utf-8?B?YXR4ZHZhRXovWCs1V0UxN2RRLzREaDF2c1d3cW5ueU1SM0pBcG5uVVhmUng0?=
 =?utf-8?B?bys5VDVFQ0NDTnp5aTJDT3FVNUF6VUV4bkxEODZYdDJQSGZNMUovNXNUUkhN?=
 =?utf-8?B?ZHBOdVdyMDhNZDFJY0Z3aW5wamJUMXVFNWF2QUtMeEhXZUplOTRIU1plM1JP?=
 =?utf-8?B?dWFGenJmOFIvOGFTVURoZWs3ZzJBY1FzZGN2Y2wwd0padTF0bVBwd0Jid0R4?=
 =?utf-8?B?eE9FY29zNW1FbkpHcmNUNkJMOEgvWk9tVk5WSGM5UTNqTzhabW1FdmlFWFds?=
 =?utf-8?B?aUU3OFNqMGtvTkp6ZGNOandFL2htVmhIanF2bTNiWW9BYTFvM25vWm5XVjNK?=
 =?utf-8?B?L1hjQlgwdjZZdStGNlVGTEFiWERyTHZCVDB5RGJOTjhLSE1hdEhWVUdOUWdi?=
 =?utf-8?B?S2NpM2tocjUvdUEwRHprb0xaMmpKYWJPMWlMdG44NEVaZWtvRXhzd1VTVFZP?=
 =?utf-8?B?S0VsQnFWTW80cWxLN2lpbW1DMVdwVUlldzQyTjVUa3ljTmc4c3RST0NWOEFH?=
 =?utf-8?B?STg4MWdCemE5bmczOFJkWHAyT2FDc3gwSXY4UTlTek1GTDJldWxUMXJBV1M4?=
 =?utf-8?B?MWxaVkpab0E0ZndiYzE3MHM3N2lURDFmUURQNTg0WDArclpnWkRtcVpZbDd1?=
 =?utf-8?B?eUNBcHJQNWlqa1hwTitWdGY1cnhGSFo3M3JyV0dXUlVQcVVIQTJVeHR0di9m?=
 =?utf-8?B?Q3RrdTBod00raUZ4bnpsa0orbVQ4Q3NXUzhXWHRyWllkSnVyZGtlbmJadHZ1?=
 =?utf-8?Q?3Biu+W7kMB1vTuD+HvvXpWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <339CB52FD43F814AAF9891B18E8312A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ra3aOMha8DwSTxw6FqmT8lyjgsf+PTnsPqzaB60Z9SIynagW9eZ//RwPhf1gMGLDsG8KcgVGnuoS60+iqvmLqeY1ByWKFy2bXY/x2nagivxN1GBlp5WX51zf624wCcKQcVc08PUlO4E1KzqWheRk1jOmuqw7t/NCNVCRfK4ZQoquatupILTzKnzAU7etgOYd3SeBEbUVZ4zakQ/fGUiTqqKlaVHTMD49au34UYbEnHVSGZL4Hv7tOOxz8j0XQsxDrHUKXiD4dkGIrS9oc1W/A8p0JFxsAadrLd/GN9VrgTA7OVTCoYD/Tabm5F6zpw18Ojav0No+eXUIfEjwFlwbp7nS+5EaFml+p0xC3o1Ozh4YS6rLFeUNQut0gVGg/CqkFNIUKfGGDvTaxcHaKXss7tHzqqa8s7vJeAc80htIIJG24FKk/icHjUXLQlSRtK+nlW98f4BgUI2TQ2R2m/x7lHtXNrdaFHFcHAjSgYXMo7n5oikxpI+msKfDkdQZB8tWxHDtK7tlyZl6t6SgszmOPMCrNEzn1wyX/NLcFFN94IOy2SNdEZAdhkgNKgeaL2I2b4lYqZfj7ab99224FK+hC4/w3o91zXAWOLwlyg84Nvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e2064e-1147-43f3-0b2a-08dce92920ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 12:43:23.4698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuoE/DtWwHk/kPnXqkzLyAyCSE8xGx4ND+sfL0je6ZkkNp3a3LqDiq42KI+AFgQ5q1UhSdqiIdP1ENf56ZyeSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_08,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100085
X-Proofpoint-GUID: 0WfzhdvQdccyrO2xIJBSdZtQ-Y4fhhP8
X-Proofpoint-ORIG-GUID: 0WfzhdvQdccyrO2xIJBSdZtQ-Y4fhhP8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgUGV0ZXIsDQoNCj4gT24gOCBPY3QgMjAyNCwgYXQgMTE6NTMsIFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIDI3IFNlcHQgMjAy
NCBhdCAxOTo0MCwgQW5uaWUgTGkgPGFubmllLmxpQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+
PiBGcm9tOiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCj4+IA0KPj4gRm9y
IHJlZmVyZW5jZTogcW1wX3N5c3RlbV9zbGVlcCByZWxpZXMgb24gd2FrZXVwIHN1cHBvcnQgZGVs
ZWdhdGVkDQo+PiBieSBxZW11X3dha2V1cF9zdXNwZW5kX2VuYWJsZWQoKSBoZW5jZSB0aGUgbmVl
ZCBmb3IgY2FsbGluZw0KPj4gcWVtdV9yZWdpc3Rlcl93YWtldXBfc3VwcG9ydCgpLiBXaXRoIHRo
aXMsIHdlIHNob3VsZCBiZSBhYmxlIHRvDQo+PiBpc3N1ZSBRTVAgc3lzdGVtX3NsZWVwIGNvbW1h
bmQgbm93Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNA
b3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gaHcvYXJtL3ZpcnQuYyB8IDEgKw0KPj4gMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC5j
IGIvaHcvYXJtL3ZpcnQuYw0KPj4gaW5kZXggNmJlODBmMDQyZi4uMzcwZWU0ZmU3ZiAxMDA2NDQN
Cj4+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4+ICsrKyBiL2h3L2FybS92aXJ0LmMNCj4+IEBAIC0y
NDAzLDYgKzI0MDMsNyBAQCBzdGF0aWMgdm9pZCBtYWNodmlydF9pbml0KE1hY2hpbmVTdGF0ZSAq
bWFjaGluZSkNCj4+IA0KPj4gICAgICAvKiBjb25uZWN0IHNsZWVwIHJlcXVlc3QgKi8NCj4+ICAg
ICAgdm1zLT5zbGVlcF9ub3RpZmllci5ub3RpZnkgPSB2aXJ0X3NsZWVwX3JlcTsNCj4+ICsgICAg
IHFlbXVfcmVnaXN0ZXJfd2FrZXVwX3N1cHBvcnQoKTsNCj4gDQo+IE9uIGkzODYgdGhlIG1hY2hp
bmUgaGFzIGEgTWFjaGluZUNsYXNzOjp3YWtldXAgbWV0aG9kDQo+IChwY19tYWNoaW5lX3dha2V1
cCkgdGhhdCBkb2VzIHRoaW5ncyBvbiB3YWtldXAuDQo+IA0KPiBPbiBwcGMvc3BhcHIgdGhlcmUg
aXMgdGhpcyBjb21tZW50IGJlZm9yZSB0aGUgY2FsbA0KPiB0byBxZW11X3JlZ2lzdGVyX3dha2V1
cF9zdXBwb3J0KCk6DQo+ICAgIC8qDQo+ICAgICAqIE5vdGhpbmcgbmVlZHMgdG8gYmUgZG9uZSB0
byByZXN1bWUgYSBzdXNwZW5kZWQgZ3Vlc3QgYmVjYXVzZQ0KPiAgICAgKiBzdXNwZW5kaW5nIGRv
ZXMgbm90IGNoYW5nZSB0aGUgbWFjaGluZSBzdGF0ZSwgc28gbm8gbmVlZCBmb3INCj4gICAgICog
YSAtPndha2V1cCBtZXRob2QuDQo+ICAgICAqLw0KPiANCj4gSSB0aGluayB0aGF0IGZvciBBcm0g
d2UgbmVlZCB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgdmlydA0KPiBib2FyZCBpcyBsaWtlIGkz
ODYvcGMgKG5lZWQgdG8gZG8gc29tZXRoaW5nIG9uIHdha2V1cCkgb3INCj4gbGlrZSBwcGMvc3Bh
cHIgKGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgb24gd2FrZXVwKS4gSWYgdGhlDQo+IGZvcm1l
ciwgd2Ugb2J2aW91c2x5IHdvdWxkIG5lZWQgdG8gaW1wbGVtZW50IHRoZQ0KPiBNYWNoaW5lQ2xh
c3M6Ondha2V1cCBtZXRob2Q7IGlmIHRoZSBsYXR0ZXIsIHRoZW4gd2UNCj4gc2hvdWxkIGhhdmUg
YSBjb21tZW50IGV4cGxhaW5pbmcgd2h5IHRoZXJlIGRvZXNuJ3QgbmVlZA0KPiB0byBiZSBhbnkg
YWN0aW9uIHRha2VuIG9uIHJlc3VtZSBhbmQgdGhlcmVmb3JlIHRoZSBtYWNoaW5lDQo+IGhhcyBu
byB3YWtldXAgbWV0aG9kLg0KPiANCg0KSSBiZWxpZXZlIGl0IHdpbGwgYmUgbmVlZGVkIHRvIHJl
c2V0IHRoZSBjcHVzIGFuZCByZXN0b3JlIGNvbnRleHQgYWZ0ZXJ3YXJkcyBidXQNCmJlZm9yZSB0
aGF0IEnigJltIHlldCBzdGlsbCB0byBmaW5kIGEgcmVsaWFibGUgd2FrZXVwIHNvdXJjZSBmb3Ig
dGhlDQpleHBlcmltZW50cy4NCg0KU28gZmFyIEnigJl2ZSB0cmllZCB0aGUgcnRjLWVmaSB3YWtl
dXAgc291cmNlIGJ1dCBpdCBzZWVtcyBub3Qgc3VwcG9ydGluZyB0aW1lIGluDQp0aGUgZnV0dXJl
IGluIHdha2VhbGFybSBzbyB0aGVyZeKAmXMgc3RpbGwgcGVuZGluZyByZXNlYXJjaCBvbiB0aGlz
LiANCg0KRGlyZWN0aW9uIGhpbnRzIGZvciBhY2NlcHRhYmxlIHdheXMgZm9yd2FyZCBhcmUgYWx3
YXlzIHdlbGNvbWUsIG9mIGNvdXJzZS4NCk1hbnkgdGhhbmtzIGZvciB0aGF0Lg0KDQpNaWd1ZWwN
Cg0KPiB0aGFua3MNCj4gLS0gUE1NDQoNCg0K

