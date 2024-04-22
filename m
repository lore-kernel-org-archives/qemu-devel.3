Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C30C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvye-0007FW-Bm; Mon, 22 Apr 2024 11:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyZ-0007EJ-V9
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:03 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyX-0007bi-3q
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713801181; x=1745337181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fNY3Ia8OsIWRUUDly0kC7nl47E5WuYX0I5f9Ly0Fijw=;
 b=GEeDt+JzpEPh0eqkvaKAc8yx7CG9SGGp5GsDzPSjTRRYyRKTQhqGxSOu
 jZckAneg28qtL01zOYtdIW/Ti+Wb2mpxmrozrJ38Ki8QSbQjagrg+a/b6
 WGY19Ex1xoE29rcPNDywn+7pn2bTybr5oHrZ0Tx4kwtUrWAxekmu7pRmY
 Dja52SPcGjSEkdNw3nig310t6QNdSDb8tXwTceIjKIprxBTgR1bchaoEr
 RCP4pOljP1q5Siw1IdL7wFKmefPgiAriow3SBbGl2E8+PmMttm5twd4rh
 YUcPXaHJqrJREaiRAhp+7iluuB6VC9GmnU6Wdbgx0moIJotcVjjDKvZym w==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; d="scan'208";a="11027671"
X-MGA-submission: =?us-ascii?q?MDEyVJbVEVGLSCMCQN1xJzQf8LahFlZ5Ssgp8K?=
 =?us-ascii?q?Sl6XPAJzXvLLTZ1Newm9/1ywHMhrJhwYUXZyi11EPBKArxjtGrkAkZPQ?=
 =?us-ascii?q?6RI7arHU2bWUJcoY2294jWG4xleCEmeGRcwr0ApRytwodaZtqYXIe3jB?=
 =?us-ascii?q?IfagaM8Vg6gM8yUDeeSnJpbg=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 17:52:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuXyHfCJay5w4U9Qb7d1bM7IGgeo9gzP+N9JX5CS/vwCPKE5dD+CgoxAvvvczmsTWIJaoYtOsY8ElknZwD4DV5Jv8qHPmgwRWEqbLcwr0BQZoeRarhxBd9KNBMv5itpyj5VzJu9HkrOHDIufzAwnSGRYXB9vzvBXONUP+GVQx5pYpTQoPLJnyD3k0P2euS/tYB5GFMbNJJKorZmK4umCOcpPx+kbu8U+08sjXNBHca+t2bXPorHT0rVfLRioRqr7svP6ZKHaFTnteNUHwr8dDLSDfmrv4uDDumfswJ3AZZW2jQxjfrENsVs7YUKcQAKFS2uqzhUV/AUAwEUC2kIfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNY3Ia8OsIWRUUDly0kC7nl47E5WuYX0I5f9Ly0Fijw=;
 b=ZORMXz2EwxozIRujVj1qq6cxFQyCOh9XPFjMre4EzDUVfDFTk+NJQX94OaHnGP4DUq/3NoNnfU6TsM9DUAAFHURx9kWW4tnIwkgALHcSZrfwO9EcZIkupddGuQBfmT14P27wlo18eR9nsAZgB4+FV+9q75hyLi2OwGTYs2gZp+5QYf89DX7/ArOgsofS5CDMPIMq7WEJuF+6ESWt4EGo3EwybaFc4jQdaxj5HtbBPzq2PbDZigMO1udlS1gU5N9a0IiGCM6RL0bRiUHe4/GqpPMwMz+LPvIQYn64eVJvqlCe3j1k6+eWUCH/2Er8MAKAR+k+38LqpC+bmwl8lu23HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9626.eurprd07.prod.outlook.com (2603:10a6:10:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:52:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:52:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH intel_iommu 5/7] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Topic: [PATCH intel_iommu 5/7] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Index: AQHalM0ih2akMhZuME+ObdSEe3SmSg==
Date: Mon, 22 Apr 2024 15:52:53 +0000
Message-ID: <20240422155236.129179-6-clement.mathieu--drif@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9626:EE_
x-ms-office365-filtering-correlation-id: 13074d7d-bbc4-4444-d600-08dc62e44656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?QVViamlYdW05YUpBOFB2emM1S0FiOVI0cE5rUy9mZ0pqRCs0c1UycFVzbzIz?=
 =?utf-8?B?dTNpSTJsVmFMUzNJRnFQZWllNVMrT0hwZ0RGZEJobE9VZGZoTUR2ZFNhTlJJ?=
 =?utf-8?B?QVdpTXMzNVFmcWVZSDZ3R1J3MFN0Q1VVN0JOdndBWGxseVRvSnhudUNtL2xm?=
 =?utf-8?B?MkJmRjdOWXpYVlVBK1VWM0xtdjhvbTF4SGEyMmllKzhQdkJtTDhHclR0dHVX?=
 =?utf-8?B?RzNOaXBaUGw3TGkxQWVvNkxlejNNOUw3UXVsOVhPR2wzdGhFRW1wT0JLYUxF?=
 =?utf-8?B?UTNwTGo4NFRkdGZqQjd3V2QxVHpwbitrREY5TzRrWlNwanROUFgvcWdYTU9v?=
 =?utf-8?B?ZmVSZUMyNThUU3U0MUJOOHN3WHpwRjFwcHR6OE9oUUllQVJZT3NlS3NvM2RR?=
 =?utf-8?B?aDR3Q2xLeFNRbTl1ZjM2UHVObWd1N1pzQWxKNmd4dlZmL1pXQXV1a0ppRUVy?=
 =?utf-8?B?bFNMQmlkUTkrbzNtOWlwNmtOOHVOcWdPSXZiUEgwODk0Unl3cW9SMGVDQWZt?=
 =?utf-8?B?V3pjUEZKYkJyV21PQjVJREZXZEpVRGtodmpLbmV4SXBiMnQ1NGdMV2xSUHFz?=
 =?utf-8?B?VnVlY2VVaWlhVDBFanBQNDVKYlMzRFNwSFBEeDFuSTdtMFlDeFl4aXJCYmll?=
 =?utf-8?B?V3BHZk84dER1Zm15SUtjWVlwd2tKSE9VN240ZEpiMmthS0xvbUNlN2d5ZVNq?=
 =?utf-8?B?djJ2OHh5NzNkNVR5aitYbzFYSTVOUm8vT21pTWprekNKSkcwRkRSSkNLZG9v?=
 =?utf-8?B?eWpRNUQwYXVzNXo5RlpFSnRubGdXY2JrZjdBbkFIS0Z4c2I5OHJYNkJnbUdL?=
 =?utf-8?B?VmJmRkZjNjlSNkZ2YThmMDMxb3AzN2d6N3Y4Nm8vUGQ0TmQ1MUtzWTNXRWdG?=
 =?utf-8?B?Ui8rL1VyVUpVVXdUUHl6YkVwem5XVy95MG1QK3lDT3JSbkVqK1M0S3FEQTdM?=
 =?utf-8?B?ZVIxNW95RWVjQktENUVib0FBTFRIRkttTWpzR0Y3T3UxcDVwZWNKWlpFRmRq?=
 =?utf-8?B?d1AxUXRLWXluN09VTWgwdlZUaDFJQ1FaME1PcVRUcnBRK0hUZ3ZHdWhwanps?=
 =?utf-8?B?UVJEa21ncENnZTZ2NS9XYkdtdWpsVU13bFVEYy8wTnhOeHF0dkFYTFFhL1pm?=
 =?utf-8?B?LzUwVmF0UHV1eHRWUmt1ZUNDbW5DZ20zUWhPRFBCRm9KaDk5RkVaVXlvVDBu?=
 =?utf-8?B?ckxybkdFRHRlTGVFNzlUd29NMXA5VEFSL3RQNzBXSXg2WkR4RFpWOVI2UEdJ?=
 =?utf-8?B?ckhiWHlsUGhjSEJZT0srblIxTm1DbXZybnp5cldjOUR2Qk1wc09MQTJBT1FK?=
 =?utf-8?B?L0VXM1o5ZGxsNndYTkQxUFBZS3JrU3ZaaEtVcU9mT3Z1TldlNXlZNStGTmhk?=
 =?utf-8?B?VXpqejFrOXh0eHdHVGNvSURkZWZTQ3Jpd3laQjJQRWZoRzNXNUx0OFBvZ0VW?=
 =?utf-8?B?a2JmbTFUV1ZrdEtRK09kMWhtVmdvc0ExOTNNc3M4aFdGYzlCc3ZVQXFPbGpI?=
 =?utf-8?B?VmxCNzBZZlVSQXVGM005ck5hQTNCbEV1TlhkOGdUUWVnRUpHa2Z5alliMnA2?=
 =?utf-8?B?MFlmSi9GSEluMlNQT3BFUG9zWlZyaFRXOXJhU2JYclZRZTdzSnFKZ1p3eUJL?=
 =?utf-8?B?blJsV0pBQzNHU29IdTRiZE5JOFN1WXlLbllndDFEOFluOFJBbm82dHRvUVlG?=
 =?utf-8?B?M1UzaDR1UDlTa3ExT0Y1ZUIyWDlHWkpkS3NyTWtwYUdvZ2NBSW02dGpzVHRS?=
 =?utf-8?B?UHNaZ3VIQjdCMzJjN0lma1BWSm9BdDN2Y3RHbTNlK29XRlprL2JCdi9GYVdM?=
 =?utf-8?B?L2RHbVQrTnBmb0xQQnZSdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFPRmRtS2ttaEJiYXM3aDdjblJoa0RseVlUOXRHbVl1bXJrcGJ5c1VhT1pE?=
 =?utf-8?B?V2gyOFJ6cUI5dkJJdUwwNkJMRk02VkVZMVJtcGFyd0NtMzJtamVWV3hIMzJV?=
 =?utf-8?B?RVF5ZUE3bEZrZjdqSDRHZ2orT2lEVjdJZWlYVXhmTEVNMTUveTJkWlVDK1Vq?=
 =?utf-8?B?dmFhRmt6L0kyNWl3V0tWaXFKVmM1RTRsVGJVWFlIdWg2cWZveHpEVENYb2xO?=
 =?utf-8?B?alEzSlJzUFVkUWNGQ3BmRU9PMTI3NjBmdWREWnZNdmxpQkxXVkhTd3RjVndn?=
 =?utf-8?B?cXduZktrSDhkVkw3UXg0UHg3aXU1byszZlorbTd0QzQ3MVl0VHpmb3o0d0cr?=
 =?utf-8?B?REIvMmU1aDZxeWQ2YWVrcXdZdGxpSDVGRkI5WGkvMTU3aUZTTDd1aE1BNnFq?=
 =?utf-8?B?TWFiSUNQTUdWMlF6amhCRDF2eGJZL2k0Q2dDaXVmMXByeGgzdUQvK1F1ME1Z?=
 =?utf-8?B?ZXZUb0duQ2ZVSjNMZm1CSW9xbVFtT3VNdmQyV25TQUI2Vjk0TldPdUdCMURN?=
 =?utf-8?B?ejErcHI3a3ZUdnlJZ0FLTEZqcjdyNGFKNXlOQlJOampYaVV6N1JwTUNTK3pQ?=
 =?utf-8?B?Qk9HZlFvbVNYZmFJR0VmYjhUOXJ5eVUrMktzbXFKZGtLSVp2b0dYSzhFbjR3?=
 =?utf-8?B?Y04vbHhUam9Ud25YRnIzTFMzWkJYUVpaVDBwYmE2TGJyQWVZaG4rYlNwbnJV?=
 =?utf-8?B?aFJvQm0vN1pjRDAzTWVUOUxuaERnbndKOEZ5YWhZakNNMWllZk1IMnU3Ly9R?=
 =?utf-8?B?WW1RWS9wMzZsRERGRkJBYnJ2TW9jbzhUTW5FbUJURXpNeXRQV2NpZmJ3M0tK?=
 =?utf-8?B?VEZtc21IMnluVTltdjVZVnF2M3VwVW1wb0VoNks5Ty9xcDVFTzhxWjMvZ0p0?=
 =?utf-8?B?cVlmdTduYmhlbUN1Q3cxektxRHNqQys5QVowaWdwTXhzTnkrVWoxWWVVMFhU?=
 =?utf-8?B?ZDdSa0xINWNDVkY1YUZaWWhDdDFhWCtFclc4K1dhYzZzVjZIaXZaejIzSUl4?=
 =?utf-8?B?MzZWTHZwMGlDK1N1REdzWDc0Skt3aTBTa2FsMzJJbTRsWFZ2MHJFNHdlSXRw?=
 =?utf-8?B?c29BN0NVM0pEUHRycXk5end0alNTK3ZXR3hJN2ZBWXZFdURsSng3bGxTVG9W?=
 =?utf-8?B?MVBiYTVYQTdrclZFRjQ4dVJ6ZXV3QW8yc2lRaGM2TTRFcUl0RUZrOUxSdXhp?=
 =?utf-8?B?MHhlRUhSdWFDallUdzhsMHd6QkxPM3R5WVJNOXBGNVd4OVdZQlM1ZWlLaUI4?=
 =?utf-8?B?MEc3YURGOU9EaFd3NkNjdzNtNi9VWHcwVW5vclR4QStjSDBQcEdYTXg3b2I0?=
 =?utf-8?B?ODMwdWlJSVlSQ013cVNQLzlnR3daS2RCZDNhL1NEZXhWaXltRmt2aGZ6K09P?=
 =?utf-8?B?U3U4MjlqdHpOTzE4T3pzaEV5L3RaZ0UyVE50aE01dE02eERqUzNvQnlWNWdp?=
 =?utf-8?B?NGFHRFVxRW1nRlpnWm1yWDVnVENqVXVtYldBZVp0K3dudTQ2ZnBLN25XZjFj?=
 =?utf-8?B?cUROYys3RDhWVFVncTVzR25HR2FUbmluVHZHNUtHTlEyTGJrRnJVZFYrT1k2?=
 =?utf-8?B?SzdZQlZoZkVRRldCRUJxR0Q5MjcwTE0xRElsODQrRjJUVG5zTkNoYXFERlVK?=
 =?utf-8?B?R082T2c1NCtpa3dCTkRJZ2ZRUzFJVC9ZeWRtNHE2YjFPM0k2QU4reEU4azNV?=
 =?utf-8?B?RjkzNmlHTDFvWEZHQVJzNVRQUk9BUnZiRUUrTGZPM002NEQ1VHVwdTJoYzNM?=
 =?utf-8?B?cWd5T1JncUI0cDgrNDk4bzZ0S0NpZTVFK29tb0p2NEM3VC9iTURsbVc1aVRS?=
 =?utf-8?B?M0VGTlZ4RjJEV1BDUk1VdkJTNy9DeGVwUzJUeDhEZU1wNUxxaFhZNjVwc1o1?=
 =?utf-8?B?a1VEUUg1Z1pPN2t3S0xZZllBbncyREhzaUpnMWVvY0l5eW9OdHlSbVJqZjM0?=
 =?utf-8?B?WmgxZUNTSzE1cHNlT000MzRiZWVFckEvN2grTFA5VXZUNHZMQjlja2JST3Y1?=
 =?utf-8?B?VGVYRStWNzRPRmRZYmhhbGZjaVlESlVEWHVHV3I2QzVCMC9CbW9iTnV6UkJP?=
 =?utf-8?B?akIvYU9xWlJGTk9QeXJUcStGNHJHRUlSbW93dEdVdm0zNFc3L2svRjdYbUpX?=
 =?utf-8?B?b2M4UmdBNmR2azdSQUxFcVMxdGF4T3dORm82WWt6clp6Z3VLVnJteWp6a1lU?=
 =?utf-8?Q?OiKh2oWX1SHCb2JRW6PoAFE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C9CF632458ECB47AE4B78F9EBB91465@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13074d7d-bbc4-4444-d600-08dc62e44656
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 15:52:53.5768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpAhdEf799w8Mvfayu0mFSMeLpxS/Tu1sqa4WK0nTjUmSnTQ+/6e2vwOqdiSWKnFadLai1ZfvInv5Z4THlYasMalZX/wSMu7D7tB7GV/wv1AWe24/BkGHuTezl5HWHKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9626
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

VGhpcyBwaWVjZSBvZiBjb2RlIGNhbiBiZSBzaGFyZWQgYnkgYm90aCBJT1RMQiBpbnZhbGlkYXRp
b24gYW5kDQpQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCg0KU2lnbmVkLW9mZi1ieTog
Q2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+
DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyks
IDI0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCAzYjlmMTIwZGVjLi5hYWFjNjFiZjZhIDEwMDY0
NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCkBAIC0yODkwLDEzICsyODkwLDQyIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2ludl9p
ZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgIHJldHVybiB0cnVlOw0KIH0NCiANCitz
dGF0aWMgdm9pZCBkb19pbnZhbGlkYXRlX2RldmljZV90bGIoVlREQWRkcmVzc1NwYWNlICp2dGRf
ZGV2X2FzLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHNpemUs
IGh3YWRkciBhZGRyKQ0KK3sNCisgICAgLyoNCisgICAgICogQWNjb3JkaW5nIHRvIEFUUyBzcGVj
IHRhYmxlIDIuNDoNCisgICAgICogUyA9IDAsIGJpdHMgMTU6MTIgPSB4eHh4ICAgICByYW5nZSBz
aXplOiA0Sw0KKyAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHh4eDAgICAgIHJhbmdlIHNpemU6
IDhLDQorICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geHgwMSAgICAgcmFuZ2Ugc2l6ZTogMTZL
DQorICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQor
ICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0gMDExMSAgICAgcmFuZ2Ugc2l6ZTogNjRLDQorICAg
ICAqIC4uLg0KKyAgICAgKi8NCisNCisgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCisgICAgdWlu
dDY0X3Qgc3o7DQorDQorICAgIGlmIChzaXplKSB7DQorICAgICAgICBzeiA9IChWVERfUEFHRV9T
SVpFICogMikgPDwgY3RvNjQoYWRkciA+PiBWVERfUEFHRV9TSElGVCk7DQorICAgICAgICBhZGRy
ICY9IH4oc3ogLSAxKTsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIHN6ID0gVlREX1BBR0VfU0la
RTsNCisgICAgfQ0KKw0KKyAgICBldmVudC50eXBlID0gSU9NTVVfTk9USUZJRVJfREVWSU9UTEJf
VU5NQVA7DQorICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZ2dGRfZGV2X2FzLT5hczsNCisg
ICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gc3ogLSAxOw0KKyAgICBldmVudC5lbnRyeS5pb3Zh
ID0gYWRkcjsNCisgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgIGV2ZW50
LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQorICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lv
bW11KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KK30NCiBzdGF0aWMgYm9vbCB2dGRf
cHJvY2Vzc19kZXZpY2VfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVzYyAqaW52X2Rlc2MpDQog
ew0KICAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXM7DQotICAgIElPTU1VVExCRXZlbnQg
ZXZlbnQ7DQogICAgIGh3YWRkciBhZGRyOw0KLSAgICB1aW50NjRfdCBzejsNCiAgICAgdWludDE2
X3Qgc2lkOw0KICAgICBib29sIHNpemU7DQogDQpAQCAtMjkxMiw2ICsyOTQxLDcgQEAgc3RhdGlj
IGJvb2wgdnRkX3Byb2Nlc3NfZGV2aWNlX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0K
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICB9DQogDQorDQogICAgIC8qDQogICAgICAqIFVz
aW5nIHNpZCBpcyBPSyBzaW5jZSB0aGUgZ3Vlc3Qgc2hvdWxkIGhhdmUgZmluaXNoZWQgdGhlDQog
ICAgICAqIGluaXRpYWxpemF0aW9uIG9mIGJvdGggdGhlIGJ1cyBhbmQgZGV2aWNlLg0KQEAgLTI5
MjEsMjggKzI5NTEsNyBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19kZXZpY2VfaW90bGJfZGVz
YyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgICAgICBnb3RvIGRvbmU7DQogICAgIH0NCiANCi0g
ICAgLyogQWNjb3JkaW5nIHRvIEFUUyBzcGVjIHRhYmxlIDIuNDoNCi0gICAgICogUyA9IDAsIGJp
dHMgMTU6MTIgPSB4eHh4ICAgICByYW5nZSBzaXplOiA0Sw0KLSAgICAgKiBTID0gMSwgYml0cyAx
NToxMiA9IHh4eDAgICAgIHJhbmdlIHNpemU6IDhLDQotICAgICAqIFMgPSAxLCBiaXRzIDE1OjEy
ID0geHgwMSAgICAgcmFuZ2Ugc2l6ZTogMTZLDQotICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0g
eDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQotICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0gMDEx
MSAgICAgcmFuZ2Ugc2l6ZTogNjRLDQotICAgICAqIC4uLg0KLSAgICAgKi8NCi0gICAgaWYgKHNp
emUpIHsNCi0gICAgICAgIHN6ID0gKFZURF9QQUdFX1NJWkUgKiAyKSA8PCBjdG82NChhZGRyID4+
IFZURF9QQUdFX1NISUZUKTsNCi0gICAgICAgIGFkZHIgJj0gfihzeiAtIDEpOw0KLSAgICB9IGVs
c2Ugew0KLSAgICAgICAgc3ogPSBWVERfUEFHRV9TSVpFOw0KLSAgICB9DQotDQotICAgIGV2ZW50
LnR5cGUgPSBJT01NVV9OT1RJRklFUl9ERVZJT1RMQl9VTk1BUDsNCi0gICAgZXZlbnQuZW50cnku
dGFyZ2V0X2FzID0gJnZ0ZF9kZXZfYXMtPmFzOw0KLSAgICBldmVudC5lbnRyeS5hZGRyX21hc2sg
PSBzeiAtIDE7DQotICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KLSAgICBldmVudC5lbnRy
eS5wZXJtID0gSU9NTVVfTk9ORTsNCi0gICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0g
MDsNCi0gICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAw
LCBldmVudCk7DQorICAgIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYih2dGRfZGV2X2FzLCBzaXpl
LCBhZGRyKTsNCiANCiBkb25lOg0KICAgICByZXR1cm4gdHJ1ZTsNCi0tIA0KMi40NC4wDQo=

