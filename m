Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC03FC7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYig-0007XE-VM; Tue, 17 Jun 2025 11:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uRYah-0003JQ-IH; Tue, 17 Jun 2025 11:51:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uRYaa-0007tU-37; Tue, 17 Jun 2025 11:51:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEXDaD013201;
 Tue, 17 Jun 2025 15:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Iw0FQmpDiAsJKAq3tV45Lh/c4hETAexviqz1Fb0Vq3U=; b=
 MrvG5ASLTtUt+PQUc/tRsXRI0bijFoFnA85JdfLCNa9hWI35pTC/AjdJxDT9pCGt
 i2R1qYhMKYc/RMJvknIFSLOe2KW8XpCV/mCDBeO1t6nvl9n/4nRrUNSjPyz/6JDX
 P1N+I4ScjsrvNhVPF9UShhw8U9PnODk+nu7u5g/B+ddy3B6P0bjvErznNPqcjac7
 MBkUDxIV4V9r+YLKE+2+GWn18cR7KlbjpKeOPkgLrx366D3G7IH+xa2wI7zi2tmG
 MG+Ty3Ts0H+oNhc2VK5PHrreIxeWdDNJdsebq1JCRfA0gl32wXiZNejA+JZf5rzB
 Icx99HVGhD8oTKsDEQxw5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd5mgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:50:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HEhjcB036299; Tue, 17 Jun 2025 15:50:54 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yhfwnq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRaXHVC3NRMm0/9QubIG7edEzEfxJOj2H6oZ59CznmbISHFN6wvI+amVHF6RrQPqoURlPLxXnKNzR1Lsj6WixAf1neg7OZ7gr/xGh5YtV/XWGst5ezVF8D9uKWrK06TFF8GaZhjScGHeBCwnyfAa6XZNvX67hndKZv2zGLS6xZ3dHR0PbQIOjboH1didsEUuzmsyrEmzS7AHSvatFJ7jIh1xt/Xp6PVn6/oPq8AryFEEAOQAMn45ognnwOmrIZW9GSgsuMjsbu6hAY+K7a160CNiCcOrsdgBPsempse59qDRO9Em9gbM9fr2i+iwvWo1/U4+cvaCLNVgFX4xKowkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw0FQmpDiAsJKAq3tV45Lh/c4hETAexviqz1Fb0Vq3U=;
 b=TazMrl0fG8ppGqwUYAphu2zlaKkMrkHTnRaEFPYmz4xLFLK0HUldtQBxzYc2RSo1fUklcBio8++i5lXsxa5KKQShXskRkIxZHNOZRuZ5Orhf4e5u6UXqT6wTzMuzNEZwdL5ENkWmnZzGNxb7vkcdJVu9Oi2UPDC5YGN/OrEykpxsmukVr/d7+lW/sMsdE8fmusIqobKhSJdptm2oJGAPar6LhEIabR1+zivnboCAwQdGulD1zL8pZyaGJVD3oI4FqEmnlGKd6jHsew+af/VhtL87g4jBRWkDe+yMnv5JWjavj/88hhdOCTx5nO9tJFUtAneA5TXl8xYBkXSx/kzomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw0FQmpDiAsJKAq3tV45Lh/c4hETAexviqz1Fb0Vq3U=;
 b=TbPceMPeLNqwh+J94YmC2Gb8gR/aBipJGZQ8IQQfehUY76cmqTkl5oJUQH2Jcj9gYbAcW6a5it1MdvbatI8J54y8H9F+6AE3hqjE/Q1DA1GQvwqskPQmCD9oHzSVyEBo/3mmUbYOXwwXj9xkCM1I84b+0V6Y6Z36aASGlDTzxXU=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 15:50:51 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:50:51 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>
CC: Alyssa Ross <hi@alyssa.is>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Thread-Topic: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Thread-Index: AQHbztBANNalBs/OM0mEgKpxsV1Eb7QHh2YAgAASmQCAAAUTAIAAAnMA
Date: Tue, 17 Jun 2025 15:50:51 +0000
Message-ID: <0EA149E9-D637-4BC0-A10F-7B896581A914@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
 <D3582F3A-B07A-4F05-827C-B030617B77EA@oracle.com>
 <efd4cb44-3d63-43b5-9568-1263ccf7566a@redhat.com>
In-Reply-To: <efd4cb44-3d63-43b5-9568-1263ccf7566a@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH7PR10MB7056:EE_
x-ms-office365-filtering-correlation-id: 529a82af-7f2a-44a0-9746-08ddadb6bc76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OThOdkFrWHFpdE9WQUJJTzMySFZoSS9weUNoenVVZHY0RTAyVEoycm1DOWNu?=
 =?utf-8?B?R2hicjFrYkhhQ3NIQkhXTm9QRUkrdm9wbHhwaStPaWVaNGhKMUR1bE4rUTA5?=
 =?utf-8?B?TXRuYmhKVm0wclZGTG1rZEVjdTdKZTU0Z0RkWUhRUk8wakp6ckd3Y1ROYXpv?=
 =?utf-8?B?SjBOMGxiYVJzSVhGTEVQUEI5aVpkeHV1NWJvTHQ5enFKVnBOSlRCbllYL0hn?=
 =?utf-8?B?ZzJETjBUN0hhVWdiRzIwUm5RSXFNd0tMb1VWK0hlQ1l3T01DRHdlYnNORVRF?=
 =?utf-8?B?OW1JMWhXU3o0Tkg4dDF0bkpYMHNlbDVRUTQzeHAvcDFkbjRzdTl2bmhjclJN?=
 =?utf-8?B?eGo5RXdvOUd5eVRNNEkwaUNOZzZxTVgzakQveDBqSFFTREVTVFE4RGdXLzV4?=
 =?utf-8?B?cUxWdDhmVCszSzh0Y25kYkU3cThDcXFaT1dhQnJJQ3JRa1FEV2NOTTBSdDhw?=
 =?utf-8?B?eXRvTFhNdVo4MjFnWi9YOFdEMEkvbFI4My9UekZRU2pWU2JNOW54ZFkyekNs?=
 =?utf-8?B?bXVlM3lhWW5nM2VzNWFvWUhNSUNmOG1JREsyd1V4cXp5aGNjelh1b0diT1g3?=
 =?utf-8?B?dWZvR1JYbmE1VTY5ZDlpeXI2eFh2Q1A1d2tCUC8yVTNrYnc5eTllUTU3T3c3?=
 =?utf-8?B?Z0I1V0FsS3Y1S1A1Rlp5VHhYZXBNRmpVc0JpUHZ1QzYrMm5ramEwMzZOcUdR?=
 =?utf-8?B?NHQ4Y0E0V0o1N1JacDBRMXhkQXBhb25qd0JJWU0wZUptSlB3Y0ZsWldkRVMr?=
 =?utf-8?B?U2xnNldLK2NaN1pSZXJBYWRmNDdxaUd3Y1VFbTh2ajZRL0p0eDRPaU4yYzZ6?=
 =?utf-8?B?UFdZaHpIYkdHWC9MVC85elBLMmk1cDh0Ty9LdWV2U3lnTVR0V0JpelVRRm5m?=
 =?utf-8?B?RzM4NTNEQkhRalRrbFZKbkJhZWx4NjNMVFdWOEhZL0JObGN4aWJVejl2NXdh?=
 =?utf-8?B?SWQ5c2hFejNBYVJLT1hFN01sa0lDT0hjL05USGZqVWhFbjkvMFJydGN6cU16?=
 =?utf-8?B?NjhhZUV2dkpuTi9pZWJRN3M2Uk5LTkNDUFFoTU5uMkNKZ0JEbkpiRXlpY1lH?=
 =?utf-8?B?bUVHeUtmUTZON2hMS1RvbFJOMmdvTENoN2s1VEhZZ2pVVmY0d0xydDU4NllW?=
 =?utf-8?B?b2QwZVJXUHJKRml5aG5VRnhLZ3dzYnpsMTcxOG1SL3VVWTVmMzFYcmxuOEhR?=
 =?utf-8?B?KzJEMGtYbVgrb0FtbSs1RkJUcmNhZkduOTVUMkNxQWxaamc0Q0RxVXFRNG5S?=
 =?utf-8?B?WmdBbVhoQ3hZN0NvcWFUVldvYzlIU1VBaFdQanV6blF2TEVSQU1ZeWQyZG1k?=
 =?utf-8?B?Y3hweXpaMXdrVjJGM2Jla1BGdWRLV2l4WGtDTHdqZnRQcDRaRUxSck8vOVkw?=
 =?utf-8?B?NHpwRzArRllFeElBUEJ0SVJjQWJ6NllQOFJTVFU1N0dwTDVzcUlFYjlMTHAr?=
 =?utf-8?B?OHUyMy9aNXRUdzNOMVlkZnlmN2xxODdrSStlWlJZRUJJQjRHVFUzenVOMXYy?=
 =?utf-8?B?YjhQSlpYMWx3WXlGYnZQRWtzV0FKK0ZVQmd0T0g5WG15eGliN0hxS2Fjclhm?=
 =?utf-8?B?UDdVNkk5dmFGaHViVmhRcXBUK0daRWtmMUExV21MRVRaUkxjSXpMSlQzOUps?=
 =?utf-8?B?RGtvOEpsL282NURPSjE0MDBlTFVaaXFhYSt1bjBCRXk2ekRVUkRUOEtCdXBW?=
 =?utf-8?B?OVB4SGlUc25Ydm5ieEhEcEJQVHp1TVFvRDhzeEREVUJaYy8zMFh4TGZtUFJa?=
 =?utf-8?B?Vks2YmRoK24wNmozem92NlllTnhFOCtnVUgrMUI5SUQ0a0Y1ZE9ZRDBkTUlh?=
 =?utf-8?B?bGd2Nk1ybUZZYnZoRXliajQ1cGhKUGNnN3hPcitqUGRoekhMNXBhMWNTcmxU?=
 =?utf-8?B?ZjZ5SVAwOHpmcndxTTYxdjFraURDelFnRlU0c0svc3hjUjM4alBtcVZ1KzVT?=
 =?utf-8?B?RE1pbkZyWUNaZGNhdWNRTGt4VlVoQTNJU3BJcFJvd1JEN1p2cWE2Rjk3T3Bh?=
 =?utf-8?B?dngwODFoTUxRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXVGRlFNNUd5OUNZd0lzME9LTzRSbzJpWXQ5U09WeXZXNkJISVZETkk1bDBm?=
 =?utf-8?B?c05Vd3owMHVxdTJ2V2lneFhLeWZHdER6SEd2TVdtc1V6MVNwR3dJVWNTMDJk?=
 =?utf-8?B?WElYdDJHZGl2aCtVSkpHbFdHRzR4SDM0aUZCQnVudU9laHROSHQyUXhDOFRv?=
 =?utf-8?B?QTFyOTMzMktQK2h2cTFma3Ryc3lwM0YxcXdlTFVxNVdQTUJXWHJ6NnRaWDMz?=
 =?utf-8?B?cHk3VzVpaFpsVis4eStKWVEzeURmRjhQZFV3YXJZQk14OWtHWEZFMHl5WEFw?=
 =?utf-8?B?ZTdmQzZxVUdqWnpRMjM0b0ZseVl0MkVOV25meGRQSy93S2Y2TkpHNFhXZTRH?=
 =?utf-8?B?dkNwZFdoTUg0T1JWZTg2d1A2WVZkM09wQ0t3NzlINDl4NmZ5YmRlY0tvTUg4?=
 =?utf-8?B?N0pFdm5SaWVnb0xIM2xXK0FIR1pJNDB4VWlGN2VjYXZmcFpjZVYwNFBmYmNI?=
 =?utf-8?B?b2xJV3E2bkpDa25KRW43STlXZWRMQWM4SklXMlAyb2RMZW1iQmVJWFhZQnJ4?=
 =?utf-8?B?azVCWEJyUXZGUU0rQUVhQ3dGa2JmUDI3aDJ6R0tjYnA4dFlvc3BodEVXWVdu?=
 =?utf-8?B?c3ovU3JjRStSRlNseEwyWHYyUGVOazhEelVhOUNWNnJ3aEJCbm5hNVN2UUJS?=
 =?utf-8?B?b25XWEdCWk1TNWk2dW80WUlIdUE0QjVtYkhOcnphSE9SVUZGMSt4VG1PNzFB?=
 =?utf-8?B?T1FWV3RlWloxS0Q0dUltSW55THVRVFZrUmg5em5tanJvYU4zM0RtdjRDcE9i?=
 =?utf-8?B?aUY0OVNzbFNMRWlZM3JrWjN0OXYxRFFnQzVScERoMUZqVHJrT2NHODltQWMz?=
 =?utf-8?B?TjFlWCs3Y0Z0ZG5NTk1yTGp3Lyt5UXdWMldBckhFRkdNQTkzZFl4N1pNSFBM?=
 =?utf-8?B?WEJQaVBEREhlQ2JGcGw2a2VqUjVjNmp4NWM5OStPb2d6RFcyUHVONklseWNt?=
 =?utf-8?B?N2FpVVE2cFVNMW9taW1VOHJWN0lWMkxqQms4THR1emd2Q1pTWTkxL2tmRzU0?=
 =?utf-8?B?akNhelhzdkRHOTN0Y2JGOFJyNUtDdS84UXkvajNyNk5rN1RDZ1RWNUMrUE9o?=
 =?utf-8?B?MVZLeTN0ZG4xK21peStBRlIrRUZjTmo1bGdSOThjKzF1U1JmVy9YckNaM0l4?=
 =?utf-8?B?Y3V4QWhLRFNHNGlMbjl3YytKM3VCRjV2QU9PMkdrT0NNRmN3aFVTbTduaGZH?=
 =?utf-8?B?WllRNzhmRmFhSUhWLzRlQmwwZ3ZsN1pVNWR2VHFhMENjWk0rT2RVQnFLQmlD?=
 =?utf-8?B?K3FCMC9WZUJTRGIrVjZlOCswRmdpbVhWNWkxYW55U2ZpSVdBdUFRQW16NHRl?=
 =?utf-8?B?dkxzd1pHK0xOOWJnMk5lY3VRYWRYRnpYcWVjbG9MM1laWWZVOHJDU1hhUWJQ?=
 =?utf-8?B?VmVhUG9kdlJrbFBkbjRvZHFOa2JDUDhkUWIvb1djcjBmK2VJRi9VZVlUR0xs?=
 =?utf-8?B?dHA3T1pLK2xTa3h4UzlqNjBpR1Q5OHQ1ZTdYV2RhbWNRTzNpczRXR2xpK2Mv?=
 =?utf-8?B?VkhkbjYyYXYwak9IcWRwYlE1ZnVVM005bEMrOE9YclRFems2c0RZalo2VGxQ?=
 =?utf-8?B?UmZOenRMNERBTTc5UmlEU001VDc2RmRnY2NGMkZLeU10aHRYeWNyamN6TkJR?=
 =?utf-8?B?ZE1PTUhOSlZ1ZnFidkRvL3c1TkNGZElpVTJOeFBhcFcrYjNBakYwTzUrYTdq?=
 =?utf-8?B?cmFDbmVwa1l6bklab3lCbzNlTWRSRm0yV1dnbFBsemNyWVBvWEd4YVZRTUIw?=
 =?utf-8?B?UXVmdDlvQ0pZWjFSNTdJRlp1T0U5K29CRUdsWlJnMTlScGhCTWlDeHB4c0xp?=
 =?utf-8?B?bzlnc3hYU1BzM0Zxa0hYYU1kQk5sSHlQMncxVmNXMFdrbG9RYmsvb1QxbTRP?=
 =?utf-8?B?dlJGMHhDSjU1TU8vaHdRRWtnS25Gc3ZHU3RyelpPMmxDelFML0s4TEhDbVJN?=
 =?utf-8?B?SklWQWtHNFh2OVNNcytWZk9saGNhQ3d5ZXRSdkdiRzlLekRJZjZjUWlZTitW?=
 =?utf-8?B?Y0puby9ycDdlWnIwVUZDalRpZlhnUWo5OGVIUy8rVlN4U1E0NUdOT3ZqOFJm?=
 =?utf-8?B?OEJqcy9qVENiMjc1QVJ6YUVxbnR4NnVMbGVlYzZ3T1k4eUlEeHpFeHlKZzky?=
 =?utf-8?B?SWNYK3Z2VjBLa1JOSHdteVA5WHU3ZkFMWnVVeERPYnhxZWRIZkZ5NENPZngz?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA031E85C94C45498960CADF141AFD71@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hhm1qoiHlyjj4NsUhPJD+KqNA8MgnlbtwywUlyaL2PpKXXEpYp9Z0ixpl6I8C/zKRNDnbOuVGYyCg29ICTxQxVhZNeVJypXAmRauJXw7R+uptHPOtYQcykcxt6IqtTD4jrGpTi5yT6lJAryA1pe8i2U1Jm9WI9AoKfyHMbA6v5BF0tzKCNX7dlpaZMD32uQO/L9WFyHFpxOLFcBFTaV3arj86HzggVmUYTFozYIt5uEx0SvtZCbw79gR5gUUj1So4cnIdxv4eW9xVNBjAuTwgP3YmXKSQU5flOgSkesfKza8WlG+6AXmfLLXBmudg6GeX6K8FnEO9suzLa5LeQJfMDDPzNns+eVRAuF/Ns/TOgkneD9My7gfQMocmpL9WOGFaGjErtH+lotA68/O917NlRk7l4ZPqnJROgBOUSQRtwCXw54LMnAl/scts8oUV8I2MJGUUlWAbWTiG1Omv+b4qFo7TyM0KRKNLJ7/8Ki1dXjPJQoroTwWSbjVf4DpvfY1hP8COMoVHaQ8/+DHRmMvenN6jmfNH7z8Pn9oNP34nQf4hf+qE8zGD0lPnnHNrbT/PDzPzSx+DkhMtLZDP+3c68BtATo4rBqEWjgDWUgZG1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529a82af-7f2a-44a0-9746-08ddadb6bc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:50:51.3897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEAauNZCOU3uwHNJmS5kJGy74SFQWmawongoGPChuRwONcrEuDT7H9F0ak2kXZuTfQzkHpjTfWcMiJVE08ZYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170124
X-Proofpoint-GUID: Ca1XG7Bcl1mBTGj0haDM3jaRSoZ8saZi
X-Proofpoint-ORIG-GUID: Ca1XG7Bcl1mBTGj0haDM3jaRSoZ8saZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEyNCBTYWx0ZWRfX7ZMWRUqpdG/d
 Ny5Hjv93mBCzxOObRMynzFF9ZY8QvtE7zXgs5heUESu1THE8jKMuKiB9EaJ8joE+7EIG8txmoYc
 ZjbZFAHilRu9gV1tOFL+Ol/SmWxZVgQMU7OFjacGQn5aHuvvMc0bkNRusw20mWtdlzRn2YhyXkv
 7elOJLMigO72qPWQBsUn/mCv5iFL4qwZQ+7+xxW4a4OlJC6cfCeL/bs+a4w2p1tgYsWEUf6bY2v
 +pQxoDOLHm2iRXz/aQ0XB3OmbzutiVUFAP8J4rxXPnd1t43YLUYoJTjSc4GcL+EpE59K6rXq405
 c6Tq+yPhg4H7aXa8nukncnmTmuoXbC/yIcbyHCemTMRTp7PWCuljulKwT7SYaNQS/c7k+/E+yDa
 dLkBxbfUQ1kj4i1+SOi7G4ngFWOA+yRP0Uc3fUyRZL82Si18OVobxNOaO1gmY/5Ml2zb639k
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=68518ee0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=8QYH4JqWqz5au_5320MA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:14714
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SGkgRXJpYywNCg0KPiBPbiAxNyBKdW4gMjAyNSwgYXQgMTU6NDEsIEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDYvMTcvMjUgNToyMyBQ
TSwgTWlndWVsIEx1aXMgd3JvdGU6DQo+PiBIaSBBbHlzc2EsDQo+PiANCj4+PiBPbiAxNyBKdW4g
MjAyNSwgYXQgMTQ6MTcsIEFseXNzYSBSb3NzIDxoaUBhbHlzc2EuaXM+IHdyb3RlOg0KPj4+IA0K
Pj4+IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4gd3JpdGVzOg0KPj4+IA0KPj4+
PiBGcm9tOiBIYWlibyBYdSA8aGFpYm8ueHVAbGluYXJvLm9yZz4NCj4+Pj4gDQo+Pj4+IFVwIHRv
IG5vdyB2aXJ0IHN1cHBvcnQgb24gZ3Vlc3QgaGFzIGJlZW4gb25seSBzdXBwb3J0ZWQgd2l0aCBU
Q0cuDQo+Pj4+IE5vdyBpdCBiZWNvbWVzIGZlYXNpYmxlIHRvIHVzZSBpdCB3aXRoIEtWTSBhY2Nl
bGVyYXRpb24uDQo+Pj4+IA0KPj4+PiBBbHNvIGNoZWNrIG9ubHkgaW4ta2VybmVsIEdJQ3YzIGlz
IHVzZWQgYWxvbmcgd2l0aCBLVk0gRUwyLg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogSGFp
Ym8gWHUgPGhhaWJvLnh1QGxpbmFyby5vcmc+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBM
dWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBSaWNoYXJkIEhl
bmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+PiBIaSEgIEZyb20gd2hh
dCBJIGNhbiB0ZWxsLCB0aGlzIHdpbGwgcHJvZHVjZSBhbiBlcnJvciBvbiBob3N0cyB0aGF0DQo+
Pj4gZG9uJ3Qgc3VwcG9ydCBuZXN0ZWQgdmlydHVhbGl6YXRpb24gd2hlbiBRRU1VIGlzIGludm9r
ZWQgd2l0aCAtYWNjZWwNCj4+PiBrdm06dGNnDQo+PiBJIGRpZG7igJl0IGtub3cgJy1hY2VsbCBr
dm06dGNn4oCZIGNvdWxkIGJlIHVzZWQgYXMgYSBmYWxsYmFjayBtZWNoYW5pc20gYmV0d2Vlbg0K
Pj4gYWNjZWxlcmF0aW9uIG1vZGVzLiBNYXkgSSBhc2sgd2hldGhlciBkbyB5b3UgbWFuYWdlIHRo
ZSDigJgtY3B14oCZIHR5cGUgZm9yIOKAmC1hY2NlbA0KPj4ga3ZtOnRjZ+KAmSB3aXRoIGNwdSDi
gJhtYXjigJkgPw0KPiBEb2VzIGl0IGV4aXN0Pw0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNj
ZWwga3ZtOnRjZzogaW52YWxpZCBhY2NlbGVyYXRvciBrdm06dGNnDQoNCk1heWJlIEFseXNzYSBp
cyByZWZlcnJpbmcgdG8g4oCYLU0gdmlydCxhY2NlbD1rdm06dGNnLHZpcnR1YWxpemF0aW9uPW9u
LGdpYy12ZXJzaW9uPTPigJkgPw0KDQpUaGUgYWJvdmUgZGlkbuKAmXQgdHJpZ2dlcmVkIGFueSBl
cnJvci4gQW55aG93IGlmIHRoZSBhYm92ZSBkb2VzIHdoYXQgQWx5c3Nh4oCZcyBzYXlpbmcgDQp3
ZSB3b3VsZCBqdXN0IGJlIG1pc3NpbmcgdGhlIGNoZWNrIGZvciB8fCAhdGNnX2VuYWJsZWQoKSBp
biB0aGlzIHBhdGNoLCBJIGJlbGlldmUuDQoNCk1pZ3VlbA0KDQo+IA0KPiBBbHlzc2EsIGRpZG4n
dCB5b3UgbWVhbiAtYWNjZWwga3ZtIG9yIC0tYWNjZWwgdGNnDQo+PiANCj4+IEJ1dCBtb3JlIGlt
cG9ydGFudGx5LCBpcyB0aGlzIHdoYXQgeW914oCZcmUgcmVmZXJyaW5nIHRvPw0KPj4gDQo+PiBB
bHRob3VnaCwNCj4+IA0KPj4+IC1tYWNoaW5lIHZpcnR1YWxpemF0aW9uPW9uLA0KPj4gc2hvdWxk
IHdvcmsgZm9yIGJvdGggJy1hY2NlbCBrdm3igJkgYW5kIOKAmC1hY2NlbCB0Y2figJkuDQo+PiAN
Cj4+PiBidXQgSSBkb24ndCB0aGluayB0aGF0J3MgdGhlIGlkZWFsDQo+Pj4gYmVoYXZpb3VyLiAg
SXQgd291bGQgbWFrZSBtb3JlIHNlbnNlIGZvciBpdCB0byBmYWxsIGJhY2sgdG8gdGhlIGZpcnN0
DQo+Pj4gcGVybWl0dGVkIGFjY2VsIG9wdGlvbiB0aGF0IGRvZXMgc3VwcG9ydCBydW5uaW5nIHRo
ZSBtYWNoaW5lIGFzDQo+Pj4gY29uZmlndXJlZCwgc28gaWYgaGFyZHdhcmUgbmVzdGVkIHZpcnR1
YWxpemF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQsIGl0DQo+Pj4gc2hvdWxkIGZhbGwgYmFjayB0byBU
Q0cuDQo+Pj4gDQo+Pj4gSSBtYWludGFpbiBhbiBPUyBkZXZlbG9wbWVudCBlbnZpcm9ubWVudCB0
aGF0IGluY2x1ZGVzIHNjcmlwdHMgZm9yDQo+Pj4gcnVubmluZyBpbWFnZXMgaW4gUUVNVSwgd2hl
cmUgcnVubmluZyBLVk0gb24gdGhvc2UgaW1hZ2VzIGlzIGENCj4+PiByZXF1aXJlbWVudC4gIEN1
cnJlbnRseSwgdGhvc2Ugc2NyaXB0cyBzaW1wbHkgZm9yY2UgVENHIG9uIGFhcmNoNjQuDQo+Pj4g
V2l0aCB0aGlzIGNoYW5nZSwgdG8gdGFrZSBhZHZhbnRhZ2Ugb2YgS1ZNIE5WIHN1cHBvcnQsIEkn
ZCBoYXZlIHRvIHRyeQ0KPj4+IHRvIGlkZW50aWZ5IGluIHRoZSBzY3JpcHQgd2hldGhlciBOViB3
b3VsZCBiZSBzdXBwb3J0ZWQuICBRRU1VIHdvdWxkIGJlDQo+Pj4gaW4gYSBtdWNoIGJldHRlciBw
b3NpdGlvbiB0byBkZXRlcm1pbmUgdGhpcyBhbmQgZmFsbCBiYWNrIHRvIFRDRyBpZiBpdCdzDQo+
Pj4gdW5zdXBwb3J0ZWQsIGxpa2UgaG93IHRoZSAtYWNjZWwgb3B0aW9uIHdpdGggbXVsdGlwbGUg
dmFsdWVzIHVzdWFsbHkNCj4+PiB3b3Jrcy4NCj4+IFRoYW5rcywNCj4+IE1pZ3VlbA0KDQoNCg==

