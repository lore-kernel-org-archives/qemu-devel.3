Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9478BC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 07:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7VJX-0000rZ-Lq; Thu, 16 May 2024 03:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s7VJT-0000rC-JD
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:14:03 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s7VJF-0003SG-Oh
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715843630; x=1747379630;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+hevO8Htb43Udiy1MMAB9pDmJ109f09JFW6VQG1NBWk=;
 b=EUsau4fjMC0cwD9b4zGfvhs1BA8gDXdoBO0srp3MgKQAVUdxnfYdaGww
 UrGa0gWaoAoFM7yW9oo2FtbiLw7KQvJ+xvjiFybNa65aU2NLVOzYyeQO+
 KA43/5KR+9M05Mb3jpoqpDBELq70NcJbQOSFaHko71CYEk+aAy9R+/HNP
 +hLvx8a1KR9GgJZgY+AtUcg15U3bDFqPXC597tnEMo7axRrvi+FyO/QX7
 hhAaks0F/IP6ry+CJfpdlt8jvoPnEC/RbnTi8YJmsaMbKsb5FjRKb2Kiy
 DijSquh5xjwErbTUTAgP5jNZC4goV4vkEDr1HU42Kyr6Vlz14NfmROu11 g==;
X-IronPort-AV: E=Sophos;i="6.08,163,1712613600"; d="scan'208";a="12665531"
X-MGA-submission: =?us-ascii?q?MDHz1nNwZF73Fzfva/gLI+mE9o3bSNNzoeiY3h?=
 =?us-ascii?q?r7VDeUKexx2eH1toAXcHtFsESO/5/7HWPSyNw5x0gF4ahFXtKKB1csVj?=
 =?us-ascii?q?vIyJfO4dejAnCVy6mu6bIJFK7nPGI+bhUXEkoyqMPo/+uQaocHPV7AX+?=
 =?us-ascii?q?3FIhqsCsOkidjPF2fbQU62uQ=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 09:13:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJxLEOh05mu5fVKnv3Nrl4vhZJEg7/LcWmJMo1lOt17vKNawS0JzUNpX9jg4fSL4RySU9seIaKyAih+3qGQlJjsWWSS+biF56EgFEFR5jRDprf7ZJw64tBM13F2PIfhTCIUX04/MKIbQ97W8KnkHLvsfvarr+StPYge8Mb01+EsF9sircUd5a+bmzWkJat/jFuDP/hrzfZhDD/8+Db/u2HFDzDAihnI9b6fwcp4dymxNeWrpKehG7tvAsXf6pT6Wk7Gu3ZMEoA9scnPFEcmVsxurmchfTSaRVw2vJStTIGyYpl/gusC2yphrQD4TfUtzTBtffDj8Q3FoCHCh8ibOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hevO8Htb43Udiy1MMAB9pDmJ109f09JFW6VQG1NBWk=;
 b=KKF7Z4tLKJQoU3w2CedU2LtT9UPd88ysnbaiqIrW3DJvspNPX+si2dGEhvQhwljdeFShKFap6MlNYELcRB1zDsNqkHJfQsPzBSp9J3XPhaoIO1lxDYA9DKhqTxdwdzQCtGG0laCxXYpBjX4s8WeKJgheMArJhxM2evxUSX6PgLf4vHST5VUE2QH75FcgyNbAjRq3N//7wlsLcdv8Oj+lvYnqBTiz8PRypZUtC4IpZvIBQvObDlrTwWMy0k48qo5Bj9Iv1xF903dNbYKJgeybuMAikSRUCbDEOUMdAo32ngH6U1xExS+Cst8h8zyeAJuZbL0WzPEqQSCWM5Qs4kzcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB9653.eurprd07.prod.outlook.com (2603:10a6:102:270::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 07:13:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 07:13:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Topic: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Index: AQHanKV+UzSPoW8ik0CkQzcjTSZ5FrGWaO0AgAGIsQCAAY1SAIAACOMA
Date: Thu, 16 May 2024 07:13:43 +0000
Message-ID: <465ef073-b257-4846-96de-20f409e02942@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB67440FA8BFCC383E6606866B92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7418b16d-c380-4006-b3d5-26c70e2db515@eviden.com>
 <SJ0PR11MB674436B8BD9BB87C0BCC0CC692ED2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB674436B8BD9BB87C0BCC0CC692ED2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB9653:EE_
x-ms-office365-filtering-correlation-id: dfd721fc-a98f-41cb-3e0c-08dc7577b861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q3YxN1NYZzFEQTduMmtpK2tPWkJzSE9ieXRodTVlVzZlR3N4d05iZEJjRlV5?=
 =?utf-8?B?b3RyRzZxYzBDLzdqcys2cDhiTWlOR0VsRDE1dmYwUDRZbHg2b3dmSFVoZndx?=
 =?utf-8?B?L0tNRzZCdmtST1FNWXdjV21MNkVjQXFkaDRSaGlibEhUb1ZCdGRES0JiaWVJ?=
 =?utf-8?B?dVZzTGNXZjI0RWlhd1k3QkM4dVJhVDhhOTQzM2kzSkVEVWhNVjN3dVkwT3Ns?=
 =?utf-8?B?TkwrN0xjSVRlUUp5Q0dINXBuRm9DNXdpUEVZWlRRVDdLeVlYT1pQMHovaVNw?=
 =?utf-8?B?VUpZR000SFpmOVYvTHg2T1Y5UXhnMnBpQk1EY1UzNTdUMEp4RkJKRy9nWW5x?=
 =?utf-8?B?N2hJanhvZFBiU2RMTmo1Z2oxK2JZSEN6RTA5R1FKR1BVbjErZjZFMXNvMHBx?=
 =?utf-8?B?UVM4K0hmMVJQdU9KRnI3clkvMHZxcXgzTHpJMTY0eitaQjloaSsrdVc0ekxS?=
 =?utf-8?B?OHZBZWhqOVJxTXN4WWdHUS91aCtFVk1jWlNRKzNITmtiV1dLRnlZOTVOSVlX?=
 =?utf-8?B?ZUc5bTlzdC9aekp1MndQSXdBTVdrSFBkam9ES0ZhOW5QS0QvRHFuRXgrZ3R5?=
 =?utf-8?B?bHZxUlBYUTJmVG13QnZlTzF5MFFrb0J4WFRkb3JiOCt6Q2hBUGFEblNDbjB5?=
 =?utf-8?B?QzlqNnA1d3BmL2pMb1lyR3VmS09ZN1dCakVXL0tHalNSd09LaVRmdG9GRmV2?=
 =?utf-8?B?enphVTlIZWtDUEZsM0IvVEwybUtrUDZRWUVDRy9OUm9XZU1FOW0yQ0lBZ3ND?=
 =?utf-8?B?TUM2aWtaQ0x0U2VoWExFaytFYWxaMUdhdERPeTA0N042NUQzSjJSR0pvUmVo?=
 =?utf-8?B?RFlmRzAxZFY0cVBoMEdSY0pHOCtra2grR3N2YlI0c0d3SFhyNjM3VEZDMlFD?=
 =?utf-8?B?OHJPNEJUNkdsOU1XRFlOREhLQkNkUnhualRFVWJPcW5iYzhVZndkZWkyNUVX?=
 =?utf-8?B?WDRFMHB2cVhOa2Z0eUdSaGcvdU5VQkQrVVNSRndoMHNCSmNIWVNSTXpxZXM0?=
 =?utf-8?B?RE1zME1oVGwyRkFrOUM0NWtUY1k0S0srbGFXQzQrZlRYeWtCMFNrZ25NeUJR?=
 =?utf-8?B?ZXgvam5CdkVFdnBwbEpPNTFabnpDUUtvNUxnemZpendaSGg2R0Q2SFlOZGk2?=
 =?utf-8?B?OWV1NW95RjQ5ZjBXd3RVa0VjK2xmQzcvSk1FV2Q2bEZGc3NiMUxQR09RMnZk?=
 =?utf-8?B?TTg5R1hvU1FmMytBeWZZVEhWRElXY0VFRVJhUXQ3Q0ZtZ3ZralhHZmkrbEVK?=
 =?utf-8?B?ek5sci9sUmxjUzJ6TFEybHA0OUR4bllvV0EyVDZ5aWUxcklpU1AvdVNpWnEy?=
 =?utf-8?B?Z0pRZG9vTEV5UCtZSXVSbC94ZlNMdy9uc1Z6Y2c1SGo0ZmFwOFRtWlFVUkVH?=
 =?utf-8?B?Vmd0TUp4aFNsTldPNFVZZDhqOTVGMDdzaFQ2aWV4bklGd1Q4d1d6dHQ5QzVS?=
 =?utf-8?B?VkJDaFpIRGZKaXpLMGtLd3VpcTVBRWZCZU55a1kvbHhHK2ZQWm5tQjExOWsz?=
 =?utf-8?B?QlFFNUNrZlFGazFoL2xKUE9TUUEydWJoT3pYWmpkSWVQL0NYSkphNUZreFF0?=
 =?utf-8?B?YWlxYmxRdjFNemhQMk5OYVVqamRxeGY3SHltTmo0YnFnQ2VQdXplcmZYb1JJ?=
 =?utf-8?B?UEl6NWZ6NXBFL1NwaDBBdnRpMFR6ZFJ4c29rWHZwanUvK3lpektwNU4yRGJh?=
 =?utf-8?B?VGpOSnVHVHRFVno4V0ZzSjk5dlZ0UlRkRnBMRjFINzg0R0x5aGtSRlh4aGFp?=
 =?utf-8?B?Uk9uM3JnQURURmF6UjdVUkhhM3dQeG9tUmQwbVNTa3FvbUkvYXkvRGdJWVRP?=
 =?utf-8?B?akdKWnpYazhFOWRjRW5MQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3M4NHZKOTczYzVqMm1zKzVoVzB3czZvN0F3SWlNRlJjTlB0U1BvV0FpRDd1?=
 =?utf-8?B?azd1Zi8rNElYSU5STjdoUXY2WFB2TDh4ZnBPYU1hN0R2NGNiLzhUTWJ6NlhY?=
 =?utf-8?B?aUgvYnpIa2l6SXNBM2tZYWNFcGl1YlB5TVVIWW5LVzhBR2Nha0h3d1F2eVU4?=
 =?utf-8?B?a3dVTzlxSFlyTEJaS3ZzcnBRT3Jacjg2cDZOeThTdTFjWFA5cGdnVHl4Lyty?=
 =?utf-8?B?SE1LYSsvdVlLY0pobkUxMUxwaVErRUw4M21UY0I2c3lrQm1KcXZLZzBoOEd1?=
 =?utf-8?B?ZVRLbUQ5V0ZQTXJleEdvdFczY2x1Z1dYZ1hpeUZydTJReDJLWExpY0ttYmxj?=
 =?utf-8?B?TTZ0V1ZGdkg2Y3FnSHArUExsc3k2NUZwUDdkWDVwa2c3amgyQ1UzTXQxVkov?=
 =?utf-8?B?dVZUaTJVK0N4Z2tQaU9WRDdweFNTdklXL28za0ZRRG1oRFg2YUxLMC94U2lh?=
 =?utf-8?B?bGNTWGczZHUvKytsTmtmNFlHMXJLNDlEYUNaNFE0WjhuN0NobGMyZi9Vdm9t?=
 =?utf-8?B?MERnTlEycElWMGVqMUJybWZNNDZpWGFYV0gyQnlnMEF2Q05vWlBoeWJWSjBi?=
 =?utf-8?B?RUNCT1RPMGRVRVdRS1NibjM5eDIrblVwem91OXNLNEo5aTd1RzNPR0gycTRo?=
 =?utf-8?B?ZDhYTmNIMnZwSnVqOWpzWmUxc25ERmlTbVVrQkhvTWxVYjF0TG00VDlQVzhV?=
 =?utf-8?B?cU5iMGQwMGxsVEVIdmNmdmNyRVJWQjh5VXh3UmNsTU5JQXNjdVJvOEdvelNt?=
 =?utf-8?B?YXFVb2FDcEN4WnpDMDVSM3lla3ZKUzFUNzg3cHhlTUNqdlYybzhtU1M5VGMv?=
 =?utf-8?B?L2t2NHYwcG11R0wwOFFUNHNhYVBvcEdGQ0lLbHdFMCtLaHZOYnppZHNnWTNY?=
 =?utf-8?B?QUVIQzN4UHJFVjdPKzZMQWwwUXVDTld1V2lNU0tsaFdxQStYVTFwb0c0YjhT?=
 =?utf-8?B?U1FDNG5nTzJ6K0tERVVBSHB1d2JMbGl5N1JYR2JNOVpoMEFKamlyeUdVM3NP?=
 =?utf-8?B?WHpKeVA2VTFCb2xTZm53TGR4QS9zcm9iTHM5RE82cVozRFNuM2VxTDN6cnRJ?=
 =?utf-8?B?RVhucEZLNTA4RUNQWWc0V05LYUtKMnc2MUNlY0VhR3YxU2RwR2RNeTMrOTQ4?=
 =?utf-8?B?UWVmVUFVWE4ya2NOMFkwNCt1ZXRkZENMckpPZWxha2ZsbkxJZXAwbS9QQjFn?=
 =?utf-8?B?bG81QXd2TzJTUURsY21SQ1U4Um4xeHBoVEpBTGhYSUZPSnI0bTBCbUN0SEpX?=
 =?utf-8?B?ZUR1bklMODZ2U3ZpT2p3VDZSZkpnSCtUT2tyVUNZVTJVTGpTeWdPTVVvdnJO?=
 =?utf-8?B?dEl2RFB5OGF3c21pQjFHbjdKWUVpdS9YelR3WWxNNGtRb3k1K2RncmJaSGh5?=
 =?utf-8?B?cnJ3ZExGMGw1WmFJeFkxM2IyWTZVNzNibHZPL2tVZ0tnVXZRaTg0OThhZHhM?=
 =?utf-8?B?Y0dDck00WCtmcGtmamRQWXlEMEI1TGRielBZcWNDTHFkVTZTRG9NdTl5bVov?=
 =?utf-8?B?U2R2R3VjMldzV3B4RnpOTS9CamZUSFBDMmFPR2tGSmVvcWw4WVVkQ0dFM1Jp?=
 =?utf-8?B?dkZLajdWYkZZZW85ZlRFUlJHamZwRUdQTU80NFJBUDJCRExHbVNRQkYwczhJ?=
 =?utf-8?B?OG56dVU0REl6TFlDck5SY3JNUzdGZlJPajFvNlhzY3ZVN1RBRE91VkYrNFlK?=
 =?utf-8?B?eDBCckhQZXN3MTFIanNBQ2JIVldnMnpaaW44bzh0c1RhNGZ6YmRncjBTdWhN?=
 =?utf-8?B?T1VEVWw3OFhETVE5QjF4aEtRUEF6b2ROdTBONDA4dk0yTmUwV0VoT1FpL05I?=
 =?utf-8?B?S0Y1ajFQYklJU1FUL0YzOWQ2Rnh1RU82UFFNdXZFZ1craFJIek1HeHFXOTkx?=
 =?utf-8?B?ai9TL3VPcnp6ZFYrbll4SzVxYjVMMFcxQmF5WVNvUDh3ZXdMdE9xMTR2cU91?=
 =?utf-8?B?K0Nzaks2dE43ODltSzlsblJNZ3l1MTBQOU5SOVZvK2NkT0dpTTE0b0pWTDJu?=
 =?utf-8?B?YlB6YTdXeGpHbnhFWnVpY2g4aHBYdFBuZFp2T2tpWldVbUJ3RGRVSEFpZmdh?=
 =?utf-8?B?UU9UYmlmUG9tRis2dUdHMCtWbFF4am0za2FrcG4rZDNxTUhpM0dDNWZpcGxU?=
 =?utf-8?B?bXA1d1duQTl3a0JscmQvZGJWN1A4b2V0cnB3SzBWb1hXaUxVanBiRGh5TU1s?=
 =?utf-8?Q?o1UnIEye3AG+rPY0PGbctNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68415FFB2AE2241A80A5F159E3BF6FB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd721fc-a98f-41cb-3e0c-08dc7577b861
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 07:13:43.4183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8otCXV61NemUnvoa3ViMhcmU/I9p/gZgSJQUKqKwjUXc+MLax17jWNha9cQVyKgUP6KPV3VL9hAWnZKsYNhzW81oCCEO6JNAx5aECbk0nNN0p/pLFjQuXsfJtFD893Wy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB9653
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksDQoNCk9uIDE2LzA1LzIwMjQgMDg6NDEsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIGF0c192dGQgdjEgMDMvMjRd
IGludGVsX2lvbW11OiBjaGVjayBpZiB0aGUgaW5wdXQNCj4+IGFkZHJlc3MgaXMgY2Fub25pY2Fs
DQo+Pg0KPj4gSGkgemhlbnpob25nLA0KPj4NCj4+IE9uIDE0LzA1LzIwMjQgMDk6MzQsIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9w
ZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+PiBlbWFpbCBjb21l
cyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
Pj4+DQo+Pj4gSGkgQ2xlbWVudCwNCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tPg0KPj4+PiBTdWJqZWN0OiBbUEFUQ0ggYXRzX3Z0ZCB2MSAwMy8yNF0gaW50
ZWxfaW9tbXU6IGNoZWNrIGlmIHRoZSBpbnB1dA0KPj4gYWRkcmVzcw0KPj4+PiBpcyBjYW5vbmlj
YWwNCj4+Pj4NCj4+Pj4gRmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gbXVzdCBmYWlsIGlmIHRoZSBh
ZGRyZXNzIHRvIHRyYW5zbGF0ZSBpcw0KPj4+PiBub3QgY2Fub25pY2FsLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLQ0K
Pj4gZHJpZkBldmlkZW4uY29tPg0KPj4+PiAtLS0NCj4+Pj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAgMiArKw0KPj4+PiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBpbmRleCA4MGNkZjM3ODcwLi4yNDBlY2I4Zjcy
IDEwMDY0NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IEBAIC0xOTEyLDYgKzE5MTIsNyBAQCBzdGF0aWMgY29u
c3QgYm9vbCB2dGRfcXVhbGlmaWVkX2ZhdWx0c1tdID0gew0KPj4+PiAgICAgICBbVlREX0ZSX1BB
U0lEX0VOVFJZX1BdID0gdHJ1ZSwNCj4+Pj4gICAgICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9FTlRS
WV9JTlZdID0gdHJ1ZSwNCj4+Pj4gICAgICAgW1ZURF9GUl9TTV9JTlRFUlJVUFRfQUREUl0gPSB0
cnVlLA0KPj4+PiArICAgIFtWVERfRlJfRlNfTk9OX0NBTk9OSUNBTF0gPSB0cnVlLA0KPj4+PiAg
ICAgICBbVlREX0ZSX01BWF0gPSBmYWxzZSwNCj4+Pj4gfTsNCj4+Pj4NCj4+Pj4gQEAgLTIwMjMs
NiArMjAyNCwyMSBAQCBzdGF0aWMgaW5saW5lIHVpbnQ2NF90DQo+Pj4+IHZ0ZF9nZXRfZmxwdGVf
YWRkcih1aW50NjRfdCBmbHB0ZSwgdWludDhfdCBhdykNCj4+Pj4gICAgICAgcmV0dXJuIGZscHRl
ICYgVlREX0ZMX1BUX0JBU0VfQUREUl9NQVNLKGF3KTsNCj4+Pj4gfQ0KPj4+Pg0KPj4+PiArLyog
UmV0dXJuIHRydWUgaWYgSU9WQSBpcyBjYW5vbmljYWwsIG90aGVyd2lzZSBmYWxzZS4gKi8NCj4+
Pj4gK3N0YXRpYyBib29sIHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbChJbnRlbElPTU1VU3Rh
dGUgKnMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDY0X3QgaW92YSwgVlREQ29udGV4dEVudHJ5ICpjZSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90IGF3LCB1aW50MzJfdCBwYXNpZCkNCj4+Pj4g
K3sNCj4+Pj4gKyAgICB1aW50NjRfdCBpb3ZhX2xpbWl0ID0gdnRkX2lvdmFfbGltaXQocywgY2Us
IGF3LCBwYXNpZCk7DQo+Pj4gQWNjb3JkaW5nIHRvIHNwZWM6DQo+Pj4NCj4+PiAiSW5wdXQtYWRk
cmVzcyBpbiB0aGUgcmVxdWVzdCBzdWJqZWN0ZWQgdG8gZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24g
aXMgbm90DQo+Pj4gY2Fub25pY2FsIChpLmUuLCBhZGRyZXNzIGJpdHMgNjM6TiBhcmUgbm90IHNh
bWUgdmFsdWUgYXMgYWRkcmVzcyBiaXRzIFtOLQ0KPj4+IDFdLCB3aGVyZSBOIGlzIDQ4IGJpdHMg
d2l0aCA0LWxldmVsIHBhZ2luZyBhbmQgNTcgYml0cyB3aXRoIDUtbGV2ZWwgcGFnaW5nKS4iDQo+
Pj4NCj4+PiBTbyBpdCBsb29rcyBub3QgY29ycmVjdCB0byB1c2UgYXcgZmlsZWQgaW4gcGFzaWQg
ZW50cnkgdG8gY2FsY3VsYXRlIGlvdmFfbGltaXQuDQo+Pj4gQXcgY2FuIGJlIGEgdmFsdWUgY29u
ZmlndXJlZCBieSBndWVzdCBhbmQgaXQncyB1c2VkIGZvciBzdGFnZS0yIHRhYmxlLiBTZWUNCj4+
IHNwZWM6DQo+Pj4gIiBUaGlzIGZpZWxkIGlzIHRyZWF0ZWQgYXMgUmVzZXJ2ZWQoMCkgZm9yIGlt
cGxlbWVudGF0aW9ucyBub3Qgc3VwcG9ydGluZw0KPj4gU2Vjb25kLXN0YWdlDQo+Pj4gVHJhbnNs
YXRpb24gKFNTVFM9MCBpbiB0aGUgRXh0ZW5kZWQgQ2FwYWJpbGl0eSBSZWdpc3RlcikuDQo+Pj4g
VGhpcyBmaWVsZCBpbmRpY2F0ZXMgdGhlIGFkanVzdGVkIGd1ZXN0LWFkZHJlc3Mtd2lkdGggKEFH
QVcpIHRvIGJlIHVzZWQgYnkNCj4+IGhhcmR3YXJlDQo+Pj4gZm9yIHNlY29uZC1zdGFnZSB0cmFu
c2xhdGlvbiB0aHJvdWdoIHBhZ2luZyBzdHJ1Y3R1cmVzIHJlZmVyZW5jZWQgdGhyb3VnaA0KPj4g
dGhlDQo+Pj4gU1NQVFBUUiBmaWVsZC4NCj4+PiDigKIgVGhlIGZvbGxvd2luZyBlbmNvZGluZ3Mg
YXJlIGRlZmluZWQgZm9yIHRoaXMgZmllbGQ6DQo+Pj4g4oCiIDAwMWI6IDM5LWJpdCBBR0FXICgz
LWxldmVsIHBhZ2UgdGFibGUpDQo+Pj4g4oCiIDAxMGI6IDQ4LWJpdCBBR0FXICg0LWxldmVsIHBh
Z2UgdGFibGUpDQo+Pj4g4oCiIDAxMWI6IDU3LWJpdCBBR0FXICg1LWxldmVsIHBhZ2UgdGFibGUp
DQo+Pj4g4oCiIDAwMGIsMTAwYi0xMTFiOiBSZXNlcnZlZA0KPj4+IFdoZW4gbm90IHRyZWF0ZWQg
YXMgUmVzZXJ2ZWQoMCksIGhhcmR3YXJlIGlnbm9yZXMgdGhpcyBmaWVsZCBmb3IgZmlyc3QtDQo+
PiBzdGFnZS1vbmx5DQo+Pj4gKFBHVFQ9MDAxYikgYW5kIHBhc3MtdGhyb3VnaCAoUEdUVD0xMDBi
KSB0cmFuc2xhdGlvbnMuIg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4gWmhlbnpob25nDQo+Pj4NCj4+
IE5vdCBzdXJlIHRvIHVuZGVyc3RhbmQuDQo+PiBBcmUgeW91IHRhbGtpbmcgYWJvdXQgdGhlIGF3
IGZpZWxkIG9mIFNjYWxhYmxlLU1vZGUgUEFTSUQgVGFibGUgRW50cnk/DQo+IFllcy4NCj4NCj4+
IFRoZSBhdyBwYXJhbWV0ZXIgaXMgc2V0IHRvIHMtPmF3X2JpdHMgaW4gdnRkX2RvX2lvbW11X3Ry
YW5zbGF0ZSBzbyBJDQo+PiB0aGluayBpdCdzIHNhZmUgdG8gdXNlIGl0IGZvciBjYW5vbmljYWwg
YWRkcmVzcyBjaGVjay4NCj4+IE1heWJlIHdlIGNhbiBqdXN0IHVzZSBzLT5hd19iaXRzIGRpcmVj
dGx5IGZyb20NCj4+IHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbCB0byBhdm9pZCBhbnkgbWlz
dGFrZT8NCj4gQWdhdyBjYW4gYmUgZGlmZmVyZW50IGZyb20gcy0+YXdfYml0cy4NCj4gWWVzLCBJ
IHRoaW5rIHVzaW5nIHMtPmF3X2JpdHMgaXMgc2FmZS4NCj4NCj4gVGhhbmtzDQo+IFpoZW56aG9u
Zw0KDQpPayBmaW5lLg0KDQpJIGRpZCB0aGUgY2hhbmdlIGluIHRoZSB2MiBJIHNlbnQgeWVzdGVy
ZGF5Lg0KDQpUaGFua3MNCg0KPg0KPj4+PiArICAgIHVpbnQ2NF90IHVwcGVyX2JpdHNfbWFzayA9
IH4oaW92YV9saW1pdCAtIDEpOw0KPj4+PiArICAgIHVpbnQ2NF90IHVwcGVyX2JpdHMgPSBpb3Zh
ICYgdXBwZXJfYml0c19tYXNrOw0KPj4+PiArICAgIGJvb2wgbXNiID0gKChpb3ZhICYgKGlvdmFf
bGltaXQgPj4gMSkpICE9IDApOw0KPj4+PiArICAgIHJldHVybiAhKA0KPj4+PiArICAgICAgICAg
ICAgICghbXNiICYmICh1cHBlcl9iaXRzICE9IDApKSB8fA0KPj4+PiArICAgICAgICAgICAgICht
c2IgJiYgKHVwcGVyX2JpdHMgIT0gdXBwZXJfYml0c19tYXNrKSkNCj4+Pj4gKyAgICAgICAgICAg
ICk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gLyoNCj4+Pj4gICAgKiBHaXZlbiB0aGUgQGlvdmEs
IGdldCByZWxldmFudCBAZmxwdGVwLiBAZmxwdGVfbGV2ZWwgd2lsbCBiZSB0aGUgbGFzdA0KPj4g
bGV2ZWwNCj4+Pj4gICAgKiBvZiB0aGUgdHJhbnNsYXRpb24sIGNhbiBiZSB1c2VkIGZvciBkZWNp
ZGluZyB0aGUgc2l6ZSBvZiBsYXJnZSBwYWdlLg0KPj4+PiBAQCAtMjAzOCw2ICsyMDU0LDEyIEBA
IHN0YXRpYyBpbnQNCj4+IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+
Pj4gVlREQ29udGV4dEVudHJ5ICpjZSwNCj4+Pj4gICAgICAgdWludDMyX3Qgb2Zmc2V0Ow0KPj4+
PiAgICAgICB1aW50NjRfdCBmbHB0ZTsNCj4+Pj4NCj4+Pj4gKyAgICBpZiAoIXZ0ZF9pb3ZhX2Zs
X2NoZWNrX2Nhbm9uaWNhbChzLCBpb3ZhLCBjZSwgYXdfYml0cywgcGFzaWQpKSB7DQo+Pj4+ICsg
ICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0ZWN0ZWQgbm9uIGNhbm9uaWNhbCBJT1ZB
IChpb3ZhPTB4JSINCj4+Pj4gUFJJeDY0ICIsIg0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAicGFzaWQ9MHglIiBQUkl4MzIgIikiLCBfX2Z1bmNfXywgaW92YSwgcGFzaWQpOw0KPj4+
PiArICAgICAgICByZXR1cm4gLVZURF9GUl9GU19OT05fQ0FOT05JQ0FMOw0KPj4+PiArICAgIH0N
Cj4+Pj4gKw0KPj4+PiAgICAgICB3aGlsZSAodHJ1ZSkgew0KPj4+PiAgICAgICAgICAgb2Zmc2V0
ID0gdnRkX2lvdmFfZmxfbGV2ZWxfb2Zmc2V0KGlvdmEsIGxldmVsKTsNCj4+Pj4gICAgICAgICAg
IGZscHRlID0gdnRkX2dldF9mbHB0ZShhZGRyLCBvZmZzZXQpOw0KPj4+PiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+IGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4+IGluZGV4IDkwMTY5MWFmYjkuLmU5NDQ4MjkxYTQgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+PiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gQEAgLTMyNCw2ICszMjQsOCBAQCB0eXBl
ZGVmIGVudW0gVlRERmF1bHRSZWFzb24gew0KPj4+PiAgICAgICBWVERfRlJfUEFTSURfRU5UUllf
UCA9IDB4NTksIC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9mIHBhc2lkdC0NCj4+IGVudHJ5IGlz
DQo+Pj4+IDAgKi8NCj4+Pj4gICAgICAgVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4
NWIsICAvKkludmFsaWQgUEFTSUQgdGFibGUgZW50cnkNCj4+ICovDQo+Pj4+ICsgICAgVlREX0ZS
X0ZTX05PTl9DQU5PTklDQUwgPSAweDgwLCAvKiBTTkcuMSA6IEFkZHJlc3MgZm9yIEZTIG5vdA0K
Pj4+PiBjYW5vbmljYWwuKi8NCj4+Pj4gKw0KPj4+PiAgICAgICAvKiBPdXRwdXQgYWRkcmVzcyBp
biB0aGUgaW50ZXJydXB0IGFkZHJlc3MgcmFuZ2UgZm9yIHNjYWxhYmxlIG1vZGUgKi8NCj4+Pj4g
ICAgICAgVlREX0ZSX1NNX0lOVEVSUlVQVF9BRERSID0gMHg4NywNCj4+Pj4gICAgICAgVlREX0ZS
X01BWCwgICAgICAgICAgICAgICAgIC8qIEd1YXJkICovDQo+Pj4+IC0tDQo+Pj4+IDIuNDQuMA==

