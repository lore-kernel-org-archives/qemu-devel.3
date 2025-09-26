Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C283DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27gl-0004p2-Gy; Fri, 26 Sep 2025 08:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v27gY-0004oJ-VL
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:36:29 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v27gQ-0004cE-6b
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1758890178; x=1790426178;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DkFKtPnzRpHpFwWMnLnj/lh7obo8dpe2aJwiveSHrPU=;
 b=s4YgJWG2IBzNRPLAa/sO3dIp0iNOvK/RX/LVsP//6r2rvd4/IPnmtdhu
 KmpsS5K12l2dx7ICtxqY2kVG8dpYNVRrTNBXIQVx5k6zf+m9q1/PK3bfB
 6rc+qmkF82DEDzFSdruq0Cnsm9dedC2xtVLvWvh4svBAKV3FPw+88QB0R
 vyHpKo6P6BpkF7ZhKdSxLB1JwZxGyvnUdlfKSvG0S2MARkuRB86/Ek1eg
 w8Gb9dTYLYVKfH2lt0BkPva46Jm4n4yG5a+Pi9haQvIxTcfo1WD1bcgjZ
 r7EkMwW3Bc/vPLdTxY299ssxvZaYbB6aVa8V/reb5yXku0Y9TwHpirVGR A==;
X-CSE-ConnectionGUID: KtT+sUEhTrye192pO4uLpw==
X-CSE-MsgGUID: Wo61Fw7ORrSYuEAxr3Dw9w==
X-IronPort-AV: E=Sophos;i="6.18,295,1751234400"; d="scan'208";a="43327280"
X-MGA-submission: =?us-ascii?q?MDG20115rpflmtLWmyzfBGsOCLqvfGuNnSwokA?=
 =?us-ascii?q?VU31Be6ybUx6FVKo1ndv3XrefQNjI/cCs74E9bZQyROQh13UvEB4pwV8?=
 =?us-ascii?q?nk2bKGtb9nUd/drbvTumrmZzGFW98ayd3Y2n77pBRjUN+59F8nQxdvDA?=
 =?us-ascii?q?PPSsm/bzqlu2p0xkO9TrK6cA=3D=3D?=
Received: from mail-swedencentralazon11013010.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.10])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Sep 2025 14:36:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk5Of1LoXLbMsQ659CQ2+FifbYveVeBnLgCUnUAzU7KOMCZpFicWC0nkUjYcptdB84VBJIRWFcQZvOHMmVdzqkA2F3iXq2KL1bi3Cb3rAKjR0obmvkg5TONn8yE/C+WnTviB3pBRcxjcJmzB1jOpGNOWlkftclBT/50NE4OZhD3q6ACVUa+qaGRIdut2HItwQL9gcB+4bsLSmaEaYYO7nm0SaX4SHQt36F00PW/fOm60TNqwYy+sAeFoV2tD+2sSqYpxZxETdmGWvV6TiFkSVOn0ZQ7hkFCUr/JqORFMNR2MQPeFkEwenlx8pfMvJEI5M+D3FEZ6W3MfHcUIeHLA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkFKtPnzRpHpFwWMnLnj/lh7obo8dpe2aJwiveSHrPU=;
 b=n46aZBnf4LUbaTAeushRZVmFkBI4DPGb12Lbu6uugaVwn9KhSKNDojYeY2GOXC0U+3VARUg0Dow8iBJJzB3ILEzXXUuBSJtWwFRoKUrpBcE6EJ7Su0wrTErPZ4Av9ekLuz2nkhWk2LLELty19+dxbXyScRVQzDH2Q95Nrl+kC1hVLvntQ8ZXGQZD6V+2zs8Xrb0x9C6VuN1f7f4aZXyy5xYWwjkp0qMuP/QFpt0UxtQ9ykKVYmaCeuqCkV/4KKvOLN0xT0HbYsxqrpY2MXOHbE4m3dM9N44Yaln+o2ULdZzUWwy35VW2YTuPr+XHVO8w+maoxXHvZYJXFUIyZerMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkFKtPnzRpHpFwWMnLnj/lh7obo8dpe2aJwiveSHrPU=;
 b=ExvQsxv0XNbSyC7nTJJoWgYraRTgZ56vc6m5Jg16vc/QaEAi3qKwQ+gvb/1WyeOt/7Kkl6Sx/MEu4DDZLk+5wYOtVsZAb+SiNnc68KDSp3SGkLv2pD5BJbIeMBwvDUCSvF2rGTG8jaPSNSk52gbz6lu29t20lH8r0XP+uopAIHZbrVeiEzYyzggjI82GoeWyJNKi0lPU3qBJiuagEtIk1ZFu2N+0rE93eH3ubRfcH0eAainT6F9WwC7fRNJzYxDLNesJZX58OmTAda0WtbvnTW3TwIOg7CUPUu3ZGWmotA9+zMjzxMJwA0Cq6KrkLDAtm0JggcMC2977puYickVOLg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7515.eurprd07.prod.outlook.com (2603:10a6:10:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 12:35:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 12:35:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/2] intel_iommu: Enable Enhanced Set Root Table Pointer
 Support (ESRTPS)
Thread-Topic: [PATCH 1/2] intel_iommu: Enable Enhanced Set Root Table Pointer
 Support (ESRTPS)
Thread-Index: AQHcKTQANSovvgbCfk+JFzFvhTuoK7SlcaAA
Date: Fri, 26 Sep 2025 12:35:58 +0000
Message-ID: <0e4c453d8dd6696caf3c143247410931bebf4095.camel@eviden.com>
References: <20250919070638.983549-1-zhenzhong.duan@intel.com>
 <20250919070638.983549-2-zhenzhong.duan@intel.com>
In-Reply-To: <20250919070638.983549-2-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7515:EE_
x-ms-office365-filtering-correlation-id: a4bd9955-5504-4b0b-7e0e-08ddfcf93ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dzR5eWVQZ2h2Z1NlcnNxRnFob2ZwdWV1WStEVUFvNzBJU0tUazhaM1JTRUxU?=
 =?utf-8?B?dlRXUm9sNTVhbjdCNlI5cjhZRzBwSVphbnl5MjVRaXRheU1mU204Mkt5Z093?=
 =?utf-8?B?dUlsdjl5MXJRZ1Zzam5Ca09vWGFFWDYwcGxJSkw0NWVjK3hwVHlVcEhzZUlw?=
 =?utf-8?B?S0lFc1N1RnhweUpsYUV2dU9SNXo5OWNKNms5RjZZS1dIK0tDRmZmQ2tpNkwv?=
 =?utf-8?B?WkV6d1BQVWxUeVNoaTdRai9FL0JIVEovdTQ2bExxNkVRVUJNQ3ZxVFdsVXlr?=
 =?utf-8?B?alBnbW5YbWtnekJtNG1jeVJ6dmhBNEJWZ09lbzlZb3pRNkh5ZU5tMTVEM0xH?=
 =?utf-8?B?NXdtK2tkbzVnZ1lEU3hteEVVckJaYVkwUzNCeUZBMGtvNGJsaXFncmczZ3RK?=
 =?utf-8?B?L1A2TFQ3MnEzZThTbzk2U2ZsQ0NraEh5NnR3OFNINytCUUpDbDZJZkpUUHNy?=
 =?utf-8?B?VThCSlFTYy80Y0NGaHdONkxuTm85eWRtekFsMUNBU1k5Uk11WTRmVmVhQ2FQ?=
 =?utf-8?B?SWJCYnY0TlU0SGFFaUlVSHVMcXlyWmh3VGZ4Wk8yUGJRSW9Rc0Z1ZFowVm9h?=
 =?utf-8?B?ZTNBMEtzRmxWUTdWelFGL0hyZG1YVWJ2ZjhTdS9PaFJnK2ZMcHoxRU1MSmtu?=
 =?utf-8?B?OWJUb08xaEhEb2Q1emVUMFhTeDVoT2RaR28yYmphMDhPTTAwQitZazd2RW95?=
 =?utf-8?B?Um5KVmVBRW55V1pPakYyTkZCSDJTY2ovNGVYWjAyQ0l6V1VhOWJKNEQ0LzJ5?=
 =?utf-8?B?YTJSSjVhNXkzZXNOcEp2R0gwK25DdHhwZWpBRkxEQTNSOU1oNDNLV0NYNzNi?=
 =?utf-8?B?ZnNNVXovYWhvVWxDd0t6cHRZZDMrRlNMcEZEUXhrYU44K3Q1eE41WkNsbFUx?=
 =?utf-8?B?Vzc2ZXQ1ckZRSmJHZ2QrMGRCUGxOZnEyaDZPNk1rM2tiU2x0UlhJL2RPTThT?=
 =?utf-8?B?WmFWZFlKdkFyWHh2UXFweDBwNVZwSllaZVJ5T1grUFFIY01KRTlyMm5DQXlo?=
 =?utf-8?B?SlNpOE4rY045Z2xyRWppWDgvV2daQ1F0VkI0cW8yNnRQVEE2alFFT0xkb2sx?=
 =?utf-8?B?cEpGOCtoWVpQaGhqbmpqUGsvMTh0Nnh3MytUaGlJaUZwMXNjR2NnMy9PWFhh?=
 =?utf-8?B?OUlxUDkzMk5RdkNqVUowR1R1eDhmbTVYNXdaZ1BsYXBIT3B2TThnbEcrd1pj?=
 =?utf-8?B?ZzVFMzN2MVZFWWdBbnJFNlAwWmQ3bVJRL2xVaFRaMlJFVTUyd1RzTjFvUUVw?=
 =?utf-8?B?WlkxaG5ST1pHTEJwblFSU0g2NC9mZ0NlQTBPZUp6NWtVWTU2eU1tb00veXVH?=
 =?utf-8?B?TEZnaGxUdzdlY29ZS0Q5QitpQjB0dFZvYk5KZ3YwNlB4OUFqdzV0L3pIc2c0?=
 =?utf-8?B?U2lvTEJ6RGZCRmNZWmxYQlNnaWFjeXZldUtjcGk0K1NNOG1XSHB4K2p3bnI5?=
 =?utf-8?B?dW9SbnZ5NFkvL1dtbWVtSi9CYjN0UzBhMEJYUE8xY2RrWkpDbWc3R2E2U28y?=
 =?utf-8?B?czVRTjh6K2JVNkxqVm5qaHorZlFDY3lHelNXNzMxd2JWM0EyNVJaOU9McUNh?=
 =?utf-8?B?czFnaXhadDVRTmE1aGhqZDlVNWxYUHZ3UUdERU85Z2pONmJRcG93Q2QzbVV5?=
 =?utf-8?B?WDNET05URnFZc0RxdURKZlppWGg1OVNpbDZYYzZpcHlWQ2V6Si9IYzV0UFdI?=
 =?utf-8?B?VjY4blArZHlWbWo2M2ZKRFB6M0I2N1pMbFlyQ09HcUpmUUV2WlEvS2tCVUZE?=
 =?utf-8?B?MGU0enBSOUJ5MWh5NzhBaDhDUzRKWUhrRzhhTGw4MXljZW5UbmZ6TnlmbVVV?=
 =?utf-8?B?MnlBZStPTkgrMUk3bUZzUVVGYXFpRzc3M1NZWmZkUEFYZVczdTU3NlVYYm9a?=
 =?utf-8?B?dXE0WERHMHVjTnp2TlppOWRtdkRhWVBCdlc3cGRRenNpbERCVzZmUC9rZlNC?=
 =?utf-8?B?UTdWTmhJMEpxUDM4Y08wYXNMQlU2NGFINGVvQTdScUd5WmN6aktYNkU3S1pF?=
 =?utf-8?B?bUFYZ0wyS0R6LzVGR1FNVmVicFJ5Lzc3Uy9NQWhBL3RranMxYUhzWmNXalZt?=
 =?utf-8?Q?XPpW8i?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SndQYnZ1cUl3bmpxdHM5YkdTdE9wc3lVaVRoZk1XT2MyVSt5Qm4zMGxEdHB3?=
 =?utf-8?B?TlpBTmxHblFsRmJGbXhBWGJ3Rk81TEEyNmludEJFMjdGaVBCWFRVWWxQMUkw?=
 =?utf-8?B?TVpxRXhwK3YyWHl0OG92QU9INFdVUWtpVGxDajQzV3Y3MUZwTTN0bHdRM05H?=
 =?utf-8?B?RjVXVVBaclJxL1U1UkJRNk5HKzc3My91VjZXRklyeTk5SElEd2JIcEJxUVZG?=
 =?utf-8?B?dlFqWmFudFc5NGVXekNIQ0poMW1ORk1LRm1tU25oYmJUL1l3ZlVNa0gxbzIy?=
 =?utf-8?B?a2tBdFFpR2c2RGtJSEVjREt1dHdydWFhNXlta3Z2UW80NElGdkxjVWdhTTV2?=
 =?utf-8?B?dEdzWDk3eWswa0RWVURTWkZLWFhyd3doYndSZEczWXZma1Q1K1ltbjZEd1Q3?=
 =?utf-8?B?eTVkRnczakpld2pZTlhLcjJ0NmtCOTZ6K21rUVZ6Sms5eHJXOVV1aVNDM0Zs?=
 =?utf-8?B?UEd6MG5hSGRSOXRZZ0RCN29nTkgyWkJ0Tnk4L0p5YXptL1A5VXNhdEp6dEFr?=
 =?utf-8?B?V0tvZVBuZHZVRWx6a1FpY1czQ0hPREI3RWpzUndVcXhXUC92N3lLNC95cVZt?=
 =?utf-8?B?L1grR2hTbjlxOGlTYjRMNG1lZmFzbTkrTGNSRGVtZUIwcWQ5bnlHSzZka0Z5?=
 =?utf-8?B?ZnRMdllIVTZaaUQvVnU1ekNRRjdGMzRzbGJtWHVjcEwrRzQ0WWY1NFNSZmxt?=
 =?utf-8?B?RmMyYmdFUDdQbk14Y0VLa0dDenFpUStjOFVwWDh1Q2FlN3Z2eW5uSFU1VENU?=
 =?utf-8?B?U1ZVMlFzMW05Z2RGc3pheWNPWGdESDBUNVJUdndVMmEvZlBQNERiWng1OTFC?=
 =?utf-8?B?bER5RFpybXkxamg3dk5LcTNKTkhoVFJaZzBvVVk3M05RM0QvdHN3ak1CVHo4?=
 =?utf-8?B?U3hYMUVJNkdPaXJaZS90SlFJZ3UySlMxUmJBR1c1bTJUbGpVRUlCOTNqbENU?=
 =?utf-8?B?VWVpZjJQQ21uY0c1SW5XK2ZMRDVSU25QbmVWYkI0K01INUhRVzF3RHBqdzdW?=
 =?utf-8?B?cWcxZUQvTzYrTTRzY1FiTnROelRhQUxqVmhsYStjRXkrcUdJcmtKM2VQaXVv?=
 =?utf-8?B?R01McVUrWHhXMWE4SE81L2RSMEcraDU4SFFxaTZSR1ZoVEFUOTBkVWRjVUlO?=
 =?utf-8?B?L1FxVEF1SkcwcXByWDhKeENLZUx1aC9DS2o3dWNtK01rcWd1ekpObGxrVlNW?=
 =?utf-8?B?azl0clZqdVdUU0l1aU0vaVZwZXFzTzEraU9iZXZxaHN3Q1BuLzVLNVdJcFlC?=
 =?utf-8?B?anpBVUN3K2lzamozSmhiS09zU09ZZWZqTzQ2OFpsY3NKajgxQ2tPODhDZmtZ?=
 =?utf-8?B?cy9pMUNpL1pGdGkrUGV6ZEFpL3JRdlQxbTZNRDB1UU5oWjNhRytMVjUyMjhj?=
 =?utf-8?B?ejJiS1Z2ZTFlbmsyWGI1cTgreERrK0o3OTdLcjRPdGZIeHE5dUJpRnpqRHBu?=
 =?utf-8?B?V1pjL2ZjUHlkQVFjSUZnU2hHeWtaUDlpaDNJcnc3YW9VSmhMcGVHejQyZW9u?=
 =?utf-8?B?M3k5dDI5V0FWT1l0YkNHNGRNOXRSd2g2QWZ4TlBwMkphR21YSngxVjBHZlNN?=
 =?utf-8?B?b1lSWnJKelFvOHo0WFZlTzRRdUhmdGdCTFcyd2VlRFprWlBCeDhrKysrMHp6?=
 =?utf-8?B?cFQyQUR1RkdUSE1acGtzYkRJbzZCTkFUNi9yU2huRUhBUndRYnU0RHduRXRU?=
 =?utf-8?B?K2lTbnh4cFdESktJZ1JVV09lSndsNDdTZXowWUYzZ2lMU3pHRGxrOWZQYlIz?=
 =?utf-8?B?UmlZSXpXa1ltcEg1anY3dDdjNHV0cElaZ29KMVBydnRPa1p2ZTN0am91S01p?=
 =?utf-8?B?a3VLRzlwSTJURmtiV1Y0cmh3V2w1eStaM0QyVCtqTi9OY21ZWk5RbUMwa21Y?=
 =?utf-8?B?TzNJU0E3eGZKTUFRVlJTY1BsRXRRTnVIbi9ROWhWL3ZoQm5mWkNUK1Q3T3ph?=
 =?utf-8?B?c2QwdmFacVR5eGRWM1pQd2VHVVVmK01Sektncy82QVYzSE9QZllCeitZNHo1?=
 =?utf-8?B?c3pVaG1qbHd3UkJRYzdVdTltSlFxaEFNUm5QQzBDaFhZWG5USEVGOEtZMDFF?=
 =?utf-8?B?RUdpbTc3eHJoNXE0TDhHMW1HR0Zad3B5eTlPT3p4L1VTNmxJbWtmdjh6d0ps?=
 =?utf-8?B?Z0h6eEtuWTdEUDVibytwa2pSSjQyUERUenc3NkxqMElicjg4SnFpL0pXdkZ4?=
 =?utf-8?Q?cKnyTAgBcVUs/RPemHbRu3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AD047F2A524BD41892F0C1A67EB53CE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bd9955-5504-4b0b-7e0e-08ddfcf93ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 12:35:58.6235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KGvErECPqtEzwJT+wt5uUkOuVH1lYFpM89wEGxQz8TCB3TbZSfwyeQlVUTR8jJ8X7Du50rCFWWZdRHLkW2LwhX21wdqan7rFfbZw2mtgpjDtpr11Nt/V/RiknifG+JW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7515
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgWmhlbnpobm9nDQoNClJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCg0KVGhhbmtzDQoNCk9uIEZyaSwgMjAyNS0w
OS0xOSBhdCAwMzowNiAtMDQwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBBY2NvcmRpbmcgdG8gVlREIHNwZWMgcmV2IDQu
MSBzZWN0aW9uIDYuNjogIA0KPiAiRm9yIGltcGxlbWVudGF0aW9ucyByZXBvcnRpbmcgdGhlIEVu
aGFuY2VkIFNldCBSb290IFRhYmxlIFBvaW50ZXIgU3VwcG9ydCAgDQo+IChFU1JUUFMpIGZpZWxk
IGFzIENsZWFyLCBvbiBhICdTZXQgUm9vdCBUYWJsZSBQb2ludGVyJyBvcGVyYXRpb24sIHNvZnR3
YXJlICANCj4gbXVzdCBwZXJmb3JtIGEgZ2xvYmFsIGludmFsaWRhdGUgb2YgdGhlIGNvbnRleHQg
Y2FjaGUsIFBBU0lELWNhY2hlIChpZiAgDQo+IGFwcGxpY2FibGUpLCBhbmQgSU9UTEIsIGluIHRo
YXQgb3JkZXIuIFRoaXMgaXMgcmVxdWlyZWQgdG8gZW5zdXJlIGhhcmR3YXJlICANCj4gcmVmZXJl
bmNlcyBvbmx5IHRoZSByZW1hcHBpbmcgc3RydWN0dXJlcyByZWZlcmVuY2VkIGJ5IHRoZSBuZXcg
cm9vdCB0YWJsZSAgDQo+IHBvaW50ZXIgYW5kIG5vdCBzdGFsZSBjYWNoZWQgZW50cmllcy4NCj4g
DQo+IEZvciBpbXBsZW1lbnRhdGlvbnMgcmVwb3J0aW5nIHRoZSBFbmhhbmNlZCBTZXQgUm9vdCBU
YWJsZSBQb2ludGVyIFN1cHBvcnQgIA0KPiAoRVNSVFBTKSBmaWVsZCBhcyBTZXQsIGFzIHBhcnQg
b2YgJ1NldCBSb290IFRhYmxlIFBvaW50ZXInIG9wZXJhdGlvbiwgIA0KPiBoYXJkd2FyZSBwZXJm
b3JtcyBnbG9iYWwgaW52YWxpZGF0aW9uIG9uIGFsbCBETUEgcmVtYXBwaW5nIHRyYW5zbGF0aW9u
ICANCj4gY2FjaGVzIGFuZCBoZW5jZSBzb2Z0d2FyZSBpcyBub3QgcmVxdWlyZWQgdG8gcGVyZm9y
bSBhZGRpdGlvbmFsICANCj4gaW52YWxpZGF0aW9ucyINCj4gDQo+IFdlIGFscmVhZHkgaW1wbGVt
ZW50ZWQgRVNSVFBTIGNhcGFiaWxpdHkgaW4gdnRkX2hhbmRsZV9nY21kX3NydHAoKSBieSAgDQo+
IGNhbGxpbmcgdnRkX3Jlc2V0X2NhY2hlcygpLCBqdXN0IHNldCBFU1JUUFMgaW4gRE1BUl9DQVBf
UkVHIHRvIGF2b2lkICANCj4gdW5uZWNlc3NhcnkgZ2xvYmFsIGludmFsaWRhdGlvbiByZXF1ZXN0
cyBvZiBjb250ZXh0LCBQQVNJRC1jYWNoZSBhbmQgIA0KPiBJT1RMQiBmcm9tIGd1ZXN0Lg0KPiAN
Cj4gVGhpcyBjaGFuZ2UgZG9lc24ndCBpbXBhY3QgbWlncmF0aW9uIGFzIHRoZSBjb250ZW50IG9m
IERNQVJfQ0FQX1JFRyBpcyAgDQo+IG1pZ3JhdGVkIHRvby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFpoZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tKT4gIA0KPiAtLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCB8IDEgKyAgDQo+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMiArLSAgDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggIA0KPiBpbmRleCAzNjBlOTM3
OTg5Li41ZGQ5MmQzODhkIDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaCAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgDQo+IEBA
IC0yMTQsNiArMjE0LDcgQEAgIA0KPiDCoCNkZWZpbmUgVlREX0NBUF9EUkFJTl9XUklURcKgwqDC
oMKgwqDCoMKgwqAgKDFVTEwgPDwgNTQpICANCj4gwqAjZGVmaW5lIFZURF9DQVBfRFJBSU5fUkVB
RMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA1NSkgIA0KPiDCoCNkZWZpbmUgVlREX0NBUF9G
UzFHUMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNTYpICANCj4gKyNkZWZp
bmUgVlREX0NBUF9FU1JUUFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA2Mykg
IA0KPiDCoCNkZWZpbmUgVlREX0NBUF9EUkFJTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KFZURF9DQVBfRFJBSU5fUkVBRCB8IFZURF9DQVBfRFJBSU5fV1JJVEUpICANCj4gwqAjZGVmaW5l
IFZURF9DQVBfQ03CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDcp
ICANCj4gwqAjZGVmaW5lIFZURF9QQVNJRF9JRF9TSElGVMKgwqDCoMKgwqDCoMKgwqDCoCAyMCAg
DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMgIA0KPiBpbmRleCA4M2M1ZTQ0NDEzLi5mMDQzMDAwMjJlIDEwMDY0NCAgDQo+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAg
DQo+IEBAIC00NTQ5LDcgKzQ1NDksNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJ
T01NVVN0YXRlICpzKQ0KPiANCj4gwqDCoMKgwqAgcy0+Y2FwID0gVlREX0NBUF9GUk8gfCBWVERf
Q0FQX05GUiB8IFZURF9DQVBfTkQgfCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZU
RF9DQVBfTUFNViB8IFZURF9DQVBfUFNJIHwgVlREX0NBUF9TTExQUyB8ICANCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBWVERfQ0FQX01HQVcocy0+YXdfYml0cyk7ICANCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBWVERfQ0FQX0VTUlRQUyB8IFZURF9DQVBfTUdBVyhzLT5hd19iaXRz
KTsgIA0KPiDCoMKgwqDCoCBpZiAocy0+ZG1hX2RyYWluKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDC
oCBzLT5jYXAgfD0gVlREX0NBUF9EUkFJTjsgIA0KPiDCoMKgwqDCoCB9ICANCj4gLS0gIA0KPiAy
LjQ3LjENCj4g

