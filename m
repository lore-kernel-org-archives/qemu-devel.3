Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FA6C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjze-0006VJ-FP; Tue, 13 Aug 2024 01:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdjzU-0006UW-Ds
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:22:41 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdjzR-0001So-O1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723526557; x=1755062557;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z0f84b/Qeua5t1T4foRQ6K3FLL83HuLBVXjNRk9uwBw=;
 b=eq4g3ik3PPFYisIa92anXuP6NqCxciv7C5HHTsl8SL+IUaPWEPvDPpCS
 xs2SfWo3Z8NJ2NYse2b363LcA3FeSG7BBCZjmkT+NqNEthqqC89k1Yo+1
 qJ0qoUDUb0ZpfB/MiBbdExZ/Zc4o9T6gsSpb8GoitmoiBZkkSWA6srepd
 KCuh7VFVlHHWTJshd2MbOhjT3N7nQHN2fXQM4sClL9X7KZ+fZRULTsyFR
 xQ5WncK/qug68zLaOTpWdDvIA4I3IXlg1gk8DDglIZZXszopG9xRpACv3
 QIXROkejaUR8D1vdXlzfnoC54+t3R6LjaAp3uX0AKtc+9ncpWg6WwAWt0 w==;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; d="scan'208";a="18261360"
X-MGA-submission: =?us-ascii?q?MDFPmMZLvhov28wNI3mW9A8DsAFx/7BZY5uGyE?=
 =?us-ascii?q?9yuunItFHstOr8COEZ1yNVo8MIkLaEYz6xi/m24LXzpoCb7GkSnSSFnp?=
 =?us-ascii?q?X2qLDU/RQDsIdRjMFdn1E6Idc4TKqSkUKbARI0OYt+kp0P0yo2MsQVAM?=
 =?us-ascii?q?3EHGE/LrJrp9tcAh8LcgJyWA=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 07:22:31 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp8ooxAtJ3iaupdvIuZCA40mOW3g+URuMet5o2kRr3/HByf7uvJgK7kS5G+kNaJw/V+2lWlBI5lWFdWAS6JBNw21sGTHvEt2DA1VXI5haMf4ztzTtp1zZLtqGYdPPZnBK+9VBvW0POIoj872zoVisexqLwTKr0n3gOmZu/N2L6vjBMssLTgpBuosM5P8Tm0xGno/LO1HhQbicsAwX6lVejSovs3gjfFbJ5JvfpUGB82yDKfvtUcc5p+5sUb288/T5aIznMxTO3ngsfEdcHk/XOc15NBToVBInNqGPGZt0zKFZJGVPCSl683xK/KD5q1xMh8158aCry02cOHAL8CPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0f84b/Qeua5t1T4foRQ6K3FLL83HuLBVXjNRk9uwBw=;
 b=Sz8qu3A3l6t1SmP2BkM9y9OR6N7scXdZjVhpmbBkP2a7fivNlczW7uyjr6OqvGPmP7xVhJ1+I9r0nM+NH/1z4fAjCpvGsNB3ayOmiNCpkZRxjYZif9u/wTHlzE1ItP0kcN5YXa/scG8sNxYJVYtZIJrCr3ck0wdNUqquCSY3FBOfpsbVDRcv+t2hbillpnoyij8kChmWnxRIHCUE4UZYiqold74Nr04rxzuEvnHueCDJIIbwh/ginNIUDSpKzJyEZW7veckfhQWuVEdSLBB+6haCq4FG41nMvpLuDcLJ+nEIV9t1JTJbkQ3MfXMkDfxnSiotpKExPk/fbvjVlNo+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0f84b/Qeua5t1T4foRQ6K3FLL83HuLBVXjNRk9uwBw=;
 b=d9RcCUWfCyw654tHVHsQ/9cJov/8OkzI2kVK9JNF+3WuYUPZg0kBfYNREcW7e4NBi6wywqLtmWjGfHopMgYpuaVv0WeDTdHUjGnPs/0SUyZpO54lxvsUhRljbvFXdMLTvKuRRP7pwoLV3DLeusCOUEQ+mwKpfHVFqwpQRJ7CyN5P2Hf/U+tDDfe9KUmCKZ9S4xZ+Uw3VlWH5xtMg54eMPncsVQyWv5JlOlOuYxFwa7QZBd+WgXVz0IpPNw/VjjhEDkp76vOW/VFeQEyay7R5ypMN3oSmIuss3M67kZYSdEDwS8SSLBieODcBscgadmd/FwiecFH8mGWWnbmMf75wOw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB10147.eurprd07.prod.outlook.com (2603:10a6:150:21b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 05:22:28 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 05:22:27 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa5wDz+IzscR3Wh02h51iysT4RrLIZx5WAgAOIVYCAACpsgIAHBlKAgAAy14A=
Date: Tue, 13 Aug 2024 05:22:27 +0000
Message-ID: <f1bc5d24-06fb-4b4e-b17c-9d21e57f9931@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
 <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
 <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
 <7043464a-7085-4ae1-a07c-06785626b640@eviden.com>
 <SJ0PR11MB674466B036500FF8875889AF92862@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB674466B036500FF8875889AF92862@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB10147:EE_
x-ms-office365-filtering-correlation-id: 8a774842-19a7-461e-80dd-08dcbb57ec1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dHY1MWJGVFlCa1R4ZzZ0dWFGN1RObWhwZ2tydGIram96Um9VaGh6Q01FeWZo?=
 =?utf-8?B?cTAwc1JxeGUyZnVJK21iUjUzeEcxTTh2LzRGeXp4d1loZGRhWDlKZXdrOFZN?=
 =?utf-8?B?ZzlKQVc0eGFvMmlFak54T0xybWFURzFNU2lRMjVNdklYN1hTSFRGVHBOVTFm?=
 =?utf-8?B?aW9waTQ1RHNRT3hubEVuNFRwcloyZUhPV29PamNJUnZEMkJCRWYxcFRPM1RG?=
 =?utf-8?B?MGtJNkI2NEx1eEtWcEwrVkQxSXV2WHlyM3lHbzdscVdHb2NCeGZtUVdzbjV6?=
 =?utf-8?B?RlpuNlQxV0dvdlliSlV3bDZ4WDJmNDJXZ3kveHdyUXdraUIzZFdleU5VcFpZ?=
 =?utf-8?B?V2hIU3M1U0hFWXlTUTMzMjVhYUw1MVFZRHhzYUhrN2hjTVVhSUtXVXk2TU91?=
 =?utf-8?B?RGFPS09TKzIxdmdkMW14TXNkektlWmMyYk9LWCs3SjA0eGVBUCt6TTVKRFFG?=
 =?utf-8?B?UzhVaWl6S0dDdHFFM2VianFScFRMSUUwaTRub2xHa1RYMER6SWR2K0x3NWJq?=
 =?utf-8?B?dUc2NFFQd0VLZnlUZ2dpSXNrdkwyUzlzMlpZajNkZGJ2MmNzdHM5aWFxVW9w?=
 =?utf-8?B?Ry8rbGFKekd3U2srMUJlVUlibXpIS25Hd2ZqNkgxVGY2ZVY5N3dlbGZuaXpY?=
 =?utf-8?B?QTJ1MEJQeDBHREdTWW9MT2ZCSE0xTWdVWS9PZzNBenN4Wko4QUNHT01FaU15?=
 =?utf-8?B?bGtWMUZ4SGRJTllKWnIyc3J0SWNkdUFxRjQwV3RWc1lDRFJBTTRQR0lGejlN?=
 =?utf-8?B?OGRvQzFTT25CRlNtcER2SDhwUzFSdWJwOVpwSHdWQ01ITllGck1HcllCTloy?=
 =?utf-8?B?cmV6bDRIUUhhZGZtYUJlWGpSYkpOaGdMeDQyR2xYeEVCcGI4MlFUNW5ieFdl?=
 =?utf-8?B?MytWWGUwT1JHNlZFYzlKTkVieW1VVzdCZm9jRlJ3SkU5aGxHdC9zc3dRem5G?=
 =?utf-8?B?MXUvTzRFSHErVjJoRUYrYmR6WXhGM0hMRWpuTFdaYkFNTWpUcWxmenFKcE1s?=
 =?utf-8?B?K3gvcEFnWDltRVZBNFcrNkhZdEttVm9leFZZUnlSQ2VyTUViQUlQNllCUkMr?=
 =?utf-8?B?RGVyNEh6RmEyT3p0d2VCaDJmaHRYSS83Z3haYmdRR3pqSWRyeTF1SC9TOWJo?=
 =?utf-8?B?WE9rNDJYSVhpZG1GRU1pNUFydWZVM2ZrNnBSMElFMHFnUDYyWEpTZlhndGtF?=
 =?utf-8?B?aDdxbVNDWThidGlncFdPRU1HRXlPL1NwelN6bkI3MHFmei9PMTcrRXJpWkk1?=
 =?utf-8?B?UTMrQnAvT1VvVlJ4Sm9hYWJDMC9TYzBORHl2bGpUL2dPNVBDazdjTVViT0Nk?=
 =?utf-8?B?aDNWeW5tNzIrYktycHUxdVhvVkpESHhhZC94UkFnNm83dnExdHRHWXdGN3M4?=
 =?utf-8?B?YUN6dG1PZEVEY1d6djQ3d252dUY5clFuTkZkT2xnRGN3T2ZBaTNuRmxZQUlB?=
 =?utf-8?B?QjI4N3FPekNwcitGUnplamdVN0lvQ1JxMi8xYW4rQ1psNnp0TU1kMHhvZTZH?=
 =?utf-8?B?RTNFSmNQY0h2aHFVL3FPU0EyVW50Q0RsdEVsY0l1citrWUNuUkxYS1pUQUNN?=
 =?utf-8?B?Q3R0THJKTGNsSFFFamVOWmthV3dUOW5Vak1IeXdsdEtZZVdFWndxZjYrb3Jm?=
 =?utf-8?B?cEtTY2pFL094R0ViWVJBUVk1R3Zhb2JSS2dNaGxOSVhZQlJjc0ZWaVNSU01j?=
 =?utf-8?B?czRlSlZsdzlTYVpXRmp1OXpDc3M4VnQ1NGQ1ZjR6eWE1OVpsaThpVEJSU0dM?=
 =?utf-8?B?dEFsNmlNVXhKNXhoK25ham1sN25zeWRtVWlFQ0pJTnhtUG0wNTJkVzhIVWs5?=
 =?utf-8?Q?vFRuLfnIhoWgtGyY5IKzRJzFsexyYZYG7ICjs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHY5VkFRRTAxQTBRN1R2U3FvMXp5dUdrTm8rK2xYTFBGQU5Ld1FEdnAza0pS?=
 =?utf-8?B?UjhwWlVpbjZmQ05RMU9GVkJXRHJvMm55VDRBa2dKZCt6MjhyK3cyVThLS0lE?=
 =?utf-8?B?bVJ5ZDhRRHNEQjFzaytzR3U3bmo1Yk1JRWY5a1VDODExZkk2TG54QzdxQ2V3?=
 =?utf-8?B?cHROU3Fpc2JUQ0d2NDR1WEhMNENDTlp6b25xSXVLbVZ5Z1FwWWlOUmFxVnZU?=
 =?utf-8?B?aWtldWg1bStVV3BNenJERFAvOS9scVJJRnZmUFpJL3lkU0hIbzU3Wk02bWZK?=
 =?utf-8?B?S21DZDJmMjdNN1JCNU1WTWVmZXd0NUF4bFhidjk2QmY5QXlsVHBBaTV1REFW?=
 =?utf-8?B?SlZhQ1VaWG4vY0lrZXNtaUtEZWhlTHAwc1h4dEh3WkhnTFBIVDNnN2gveXd1?=
 =?utf-8?B?aGFLcEUxdUlHT3RaUVhYZldzTGlqWmUvRmp1ZURyNC9WUnVYTEFZN2w1N1hl?=
 =?utf-8?B?REhHV1pseTE5S21GTG1yRzBpTElsNGEybmdrZWJwZFpKUnJ6UHYzbTk0NElY?=
 =?utf-8?B?NEtoblZXamVkeFBaMDYxUmVLSUxCcWZrTjMxbmtGa1htSHVKWjhLa3FQQXhw?=
 =?utf-8?B?ekZNMzRCaHRUcHhMMldZMktYNDVZaHpyL3NEeHR3ajdOWWQ1STcxZExRV1o4?=
 =?utf-8?B?cHpLMGlsUWhFZ2JuVjhOeVhOaDMyRzRSL1N0b1RnaW1YMnJwMkpjNnlYZ2FR?=
 =?utf-8?B?OVAzOTdac1NtRGhXTDg4cFg2NjdFSDVjUHRpK3pYM0FiWHFOZUt6cUt2U1h6?=
 =?utf-8?B?VXVBYitFa3hFWlVBMjIwNVM3QVNSS20rVkR4TkwrVkJiTnFpd1FnUWJQdks5?=
 =?utf-8?B?ZDhUQ29OcmJrWjN4c1dweVNmNWxnRTVyZ0F3TjVVOVlTUFdWMGRWaStkS2pI?=
 =?utf-8?B?Umh0Nkl2SWxHRWY1bFllWS96YWRkRXQ5cVZWY2VEcStkRHl0dXpER1pNSmFP?=
 =?utf-8?B?djV1Tkh6YzRBdUVLVWdNZDhiZlhUVm96SWJORFhTcnhuM0FkaHl6NVViSDBp?=
 =?utf-8?B?K2dITWo1Z1RrempRUW5kb1pvWEwwOW9NcHFLUEM3TFA4MENyL29VL1dCelpp?=
 =?utf-8?B?eVJlcHRQbGR0am9TZ2pUSDA5QXNVSFAyTFBKeEZuRWJPaXJPb1JQOS9VWEl5?=
 =?utf-8?B?WDlMdUt5V1YxbVRyekFiMWtGOHhQTE90LzdpVWNLWUNBYU9Xb0ZhQnIzUUlt?=
 =?utf-8?B?bnFVb3J3SFVYaCs5ZHYwY0IxeVZtVlhFQVFCa1ozM1FCMlF1OTI1cE9uUTJV?=
 =?utf-8?B?dVFPRUZrY0R2VDVaYlhGOWoyZG9nRDVzV3VMZmdObHQzT3JGdHBrVnRsWHJr?=
 =?utf-8?B?OTM2U25WM3lhOXZET1lwSE1GSnlTZUthVm9WUHUxQ1o0VWkvR2hNSHJYQmVS?=
 =?utf-8?B?TzRuaEVGQXE1K2trVFFIeEY2N1RqQXBaQk9tek42dENaYmF6UDUycU5LQk1K?=
 =?utf-8?B?eWRubE1pMnUzVHlvMnFNTjdmRlJoSW1NS1FwZ04zOEltSEU3SER1dSt2Q3d0?=
 =?utf-8?B?L3BkSElwUEROaVdzNGdDc0ZaWGZhR0tlWVh6RjFuWXhUdGZPUk5wUU10Yzl4?=
 =?utf-8?B?SUdvMFZGcE40UTUwYm5kRDdBck1jYUJQUUNzWk0zNXRCYVBFZTlDTHgrVTRU?=
 =?utf-8?B?a1ZLMWVuOXAyemgvRFBkTklhTGVZUWlXNXN1ODVScXZhem91R0ZWeG9BRERr?=
 =?utf-8?B?U2RsNnBsUlNPWnZieVBLeklzWEEwaEJLVVFSTG5IU08yYzliN3EyNm1ZeTM2?=
 =?utf-8?B?ZzhqaXh1WVc0V1pXUkpuZ1VWSnhVRU9ZWjdVS1ZJUm5aM2UvRTVPZmY2ZUFv?=
 =?utf-8?B?U25EdUk0SzBxQXJNMERVL2g4aUtLZlJzU2xqMnovRHRaRWhVYTQxaitzeXdN?=
 =?utf-8?B?TmdlL2IvV01LbU82bFRYNlBjcGVFV3BTcnEwdnZ2eURGOW1wTVJ2MnZKOWNY?=
 =?utf-8?B?T1pPT0hpaTRzempVWU5yVldtSmwwS3RxZGdHd0xuMkV6dzhocm1pR0oxOVdh?=
 =?utf-8?B?TSthVk8xRkJiSk9rKzh0Q20ySERhbkpsZ2NyaWZNWUJZRmJvL2F0SnlxM0F4?=
 =?utf-8?B?VTJsZW5xRWR6OXJtNWI0NW9NcEZrbS9FNFVVYVhlZXNmMklBNGVYaVVTbCtr?=
 =?utf-8?B?MGhOYVpTclRYYnlXeVl6UFlEM2M5UnV5TFZNZUYvYTVGUmR3OU53UENZNk1G?=
 =?utf-8?Q?HRDSVUt1rZ5dy/XpkQ0rjTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02CCA6EE9035824683394ACE3F8FE525@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a774842-19a7-461e-80dd-08dcbb57ec1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 05:22:27.7270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kbYWEky4SGjPTmIgnaWFTsWTjNGNahqP0totv9eO4dlc86xfWYIXUizCATfhUnS83tmJVmv3KZt88SmGlJw6T8J+FH2hTt4RJzbOVYn2oUzXsKU8XMsiJqhYZ4YJYZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10147
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEzLzA4LzIwMjQgMDQ6MjAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzE3XSBpbnRlbF9pb21t
dTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUgZm9yDQo+PiBzY2FsYWJsZSBtb2Rlcm4gbW9k
ZQ0KPj4NCj4+DQo+Pg0KPj4gT24gMDgvMDgvMjAyNCAxNDozMSwgRHVhbiwgWmhlbnpob25nIHdy
b3RlOg0KPj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50
cyBvciBjbGljayBsaW5rcywNCj4+PiB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25v
d24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudA0KPj4+IGlzIHNhZmUuDQo+Pj4NCj4+
Pg0KPj4+IE9uIDgvNi8yMDI0IDI6MzUgUE0sIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToN
Cj4+Pj4gT24gMDUvMDgvMjAyNCAwODoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+PiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsDQo+Pj4+PiB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudA0KPj4+Pj4gaXMgc2FmZS4NCj4+Pj4+DQo+Pj4+Pg0K
Pj4+Pj4gQWRkIGFuIG5ldyBlbGVtZW50IHNjYWxhYmxlX21vZGUgaW4gSW50ZWxJT01NVVN0YXRl
IHRvIG1hcmsNCj4+IHNjYWxhYmxlDQo+Pj4+PiBtb2Rlcm4gbW9kZSwgdGhpcyBlbGVtZW50IHdp
bGwgYmUgZXhwb3NlZCBhcyBhbiBpbnRlbF9pb21tdSBwcm9wZXJ0eQ0KPj4+Pj4gZmluYWxseS4N
Cj4+Pj4+DQo+Pj4+PiBGb3Igbm93LCBpdCdzIG9ubHkgYSBwbGFjZWhob2xkZXIgYW5kIHVzZWQg
Zm9yIGFkZHJlc3Mgd2lkdGgNCj4+Pj4+IGNvbXBhdGliaWxpdHkgY2hlY2sgYW5kIGJsb2NrIGhv
c3QgZGV2aWNlIHBhc3N0aHJvdWdoIHVudGlsIG5lc3RpbmcNCj4+Pj4+IGlzIHN1cHBvcnRlZC4N
Cj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aCB8wqAgMSArDQo+Pj4+PiAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgfCAxMiAr
KysrKysrKystLS0NCj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4
Ni9pbnRlbF9pb21tdS5oDQo+Pj4+PiBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
Pj4+PiBpbmRleCAxZWIwNWMyOWZjLi43ODhlZDQyNDc3IDEwMDY0NA0KPj4+Pj4gLS0tIGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oDQo+Pj4+PiBAQCAtMjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1V
U3RhdGUgew0KPj4+Pj4NCj4+Pj4+ICAgICAgICAgYm9vbCBjYWNoaW5nX21vZGU7ICAgICAgICAg
ICAgICAvKiBSTyAtIGlzIGNhcCBDTSBlbmFibGVkPyAqLw0KPj4+Pj4gICAgICAgICBib29sIHNj
YWxhYmxlX21vZGU7ICAgICAgICAgICAgIC8qIFJPIC0gaXMgU2NhbGFibGUgTW9kZQ0KPj4+Pj4g
c3VwcG9ydGVkPyAqLw0KPj4+Pj4gKyAgICBib29sIHNjYWxhYmxlX21vZGVybjsgICAgICAgICAg
IC8qIFJPIC0gaXMgbW9kZXJuIFNNIHN1cHBvcnRlZD8gKi8NCj4+Pj4+ICAgICAgICAgYm9vbCBz
bm9vcF9jb250cm9sOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNOUCBmaWxlZA0KPj4+Pj4gc3Vw
cG9ydGVkPyAqLw0KPj4+Pj4NCj4+Pj4+ICAgICAgICAgZG1hX2FkZHJfdCByb290OyAgICAgICAg
ICAgICAgICAvKiBDdXJyZW50IHJvb3QgdGFibGUgcG9pbnRlciAqLw0KPj4+Pj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4g
aW5kZXggZTM0NjVmYzI3ZC4uYzEzODJhNTY1MSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+PiBA
QCAtMzg3Miw3ICszODcyLDEzIEBAIHN0YXRpYyBib29sDQo+PiB2dGRfY2hlY2tfaGlvZChJbnRl
bElPTU1VU3RhdGUNCj4+Pj4+ICpzLCBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+Pj4+PiAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+PiAgICAgICAgIH0NCj4+Pj4+DQo+Pj4+PiAtICAg
IHJldHVybiB0cnVlOw0KPj4+Pj4gKyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+
Pj4gKyAgICAgICAgLyogQWxsIGNoZWNrcyByZXF1ZXN0ZWQgYnkgVlREIG5vbi1tb2Rlcm4gbW9k
ZSBwYXNzICovDQo+Pj4+PiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+Pj4+ICsgICAgfQ0KPj4+
Pj4gKw0KPj4+Pj4gKyAgICBlcnJvcl9zZXRnKGVycnAsICJob3N0IGRldmljZSBpcyB1bnN1cHBv
cnRlZCBpbiBzY2FsYWJsZSBtb2Rlcm4NCj4+Pj4+IG1vZGUgeWV0Iik7DQo+Pj4+PiArICAgIHJl
dHVybiBmYWxzZTsNCj4+Pj4+ICAgICB9DQo+Pj4+Pg0KPj4+Pj4gICAgIHN0YXRpYyBib29sIHZ0
ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KPj4+Pj4g
aW50IGRldmZuLA0KPj4+Pj4gQEAgLTQyNjIsOSArNDI2OCw5IEBAIHN0YXRpYyBib29sDQo+PiB2
dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUNCj4+Pj4+ICpzLCBFcnJvciAqKmVycnAp
DQo+Pj4+PiAgICAgICAgICAgICB9DQo+Pj4+PiAgICAgICAgIH0NCj4+Pj4+DQo+Pj4+PiAtICAg
IC8qIEN1cnJlbnRseSBvbmx5IGFkZHJlc3Mgd2lkdGhzIHN1cHBvcnRlZCBhcmUgMzkgYW5kIDQ4
IGJpdHMgKi8NCj4+Pj4+ICAgICAgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzM5
QklUKSAmJg0KPj4+Pj4gLSAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQp
KSB7DQo+Pj4+PiArICAgICAgICAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYN
Cj4+Pj4+ICsgICAgICAgICFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+Pj4gV2h5IGRvZXMgc2Nh
bGFibGVfbW9kZXJuIGFsbG93IHRvIHVzZSBhIHZhbHVlIG90aGVyIHRoYW4gMzkgb3IgNDg/DQo+
Pj4+IElzIGl0IHNhZmU/DQo+Pj4gVGhlIGNoZWNrIGZvciBzY2FsYWJsZV9tb2Rlcm4gaXMgaW4g
cGF0Y2gxNDoNCj4+Pg0KPj4+IGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkg
JiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+Pj4NCj4+PiBlcnJvcl9zZXRnKGVycnAsICJTdXBw
b3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTogJWQiLA0KPj4+IFZURF9IT1NUX0FXXzQ4QklU
KTsNCj4+Pg0KPj4+IHJldHVybiBmYWxzZTsNCj4+Pg0KPj4+IH0NCj4+Pg0KPj4+IExldCBtZSBr
bm93IGlmIHlvdSBwcmVmZXIgdG8gbW92ZSBpdCBpbiB0aGlzIHBhdGNoLg0KPj4gWWVzLCB5b3Ug
YXJlIHJpZ2h0LCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUgY2hlY2sgaGVyZS4NCj4+
DQo+PiBCdXQgSSB0aGluayB0aGUgZmlyc3QgY2hlY2sgc2hvdWxkIGFsc28gZmFpbCBldmVuIHdo
ZW4gc2NhbGFibGVfbW9kZXJuDQo+PiBpcyBlbmFibGVkIGJlY2F1c2UgdmFsdWVzIG90aGVyIHRo
YW4gMzkgYW5kIDQ4IGFyZSBub3Qgc3VwcG9ydGVkIGF0IGFsbCwNCj4+IHdoYXRldmVyIHRoZSBt
b2RlLg0KPj4gVGhlbiwgd2Ugc2hvdWxkIGNoZWNrIGlmIHRoZSB2YWx1ZSBpcyB2YWxpZCBmb3Ig
c2NhbGFibGVfbW9kZXJuIG1vZGUuDQo+IFJpZ2h0LCBJIHdyb3RlIHRoYXQgd2F5IHdpdGggYSBw
b3NzaWJsZSBwbGFuIHRvIHN1cHBvcnQgVlREX0hPU1RfQVdfNTJCSVQuDQo1MiBvciA1Nz8NCj4g
V2hhdCBhYm91dCB0aGlzOg0KPg0KVGhpcyBjb25kaXRpb24gdHJhcHMgKG5vbi1zY2FsYWJsZSkg
bGVnYWN5IG1vZGUgYXMgd2VsbC4gSSB0aGluayB3ZSANCnNob3VsZCBjaGFuZ2UgdGhlIGVycm9y
IG1lc3NhZ2UgdG8gbWFrZSBpdCBjbGVhcg0KU29tZXRoaW5nIGxpa2UgdGhpczogIkxlZ2FjeSBh
bmQgbm9uLW1vZGVybiBzY2FsYWJsZSBtb2Rlczogc3VwcG9ydGVkIA0KdmFsdWVzIGZvciBhdy1i
aXQgYXJlIC4uLiINCk9yIHdlIGNvdWxkIG1ha2UgdGhlIGVycm9yIG1lc3NhZ2UgY29uZGl0aW9u
YWwuDQo+ICAgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzM5QklUKSAmJg0KPiAg
ICAgICAgICAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYNCj4gICAgICAgICAg
IXMtPnNjYWxhYmxlX21vZGVybikgew0KPiAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTY2Fs
YWJsZSBsZWdhY3kgbW9kZTogc3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkLCAl
ZCIsDQo+ICAgICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQVdfMzlCSVQsIFZURF9IT1NUX0FX
XzQ4QklUKTsNCj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgIH0NCj4NCj4gICAgICBp
ZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVy
bikgew0KPiAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTY2FsYWJsZSBtb2Rlcm4gbW9kZTog
c3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBpczogJWQiLA0KPiAgICAgICAgICAgICAgICAg
ICAgIFZURF9IT1NUX0FXXzQ4QklUKTsNCj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAg
IH0NCg0KDQo+DQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCg==

