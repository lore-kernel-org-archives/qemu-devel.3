Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D017AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0Io-0000Zt-3V; Mon, 03 Jun 2024 01:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0Id-0000ZG-Oe
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:32:03 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0Ib-0002bG-CM
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717392721; x=1748928721;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=S7nbwAIxe29Kj2gk5a3FfNH3Rh6Yz+u/9jRgO23u864=;
 b=H5fvkUbF+YgFuUIeHge9AQ7cQjeiklhL1r+Rt01PH1ep67H5DiM7pHSY
 8pQnUg8B3RoUc1/620W2aGYCCLXsB8P7E6A9taQK9fgHtDmJVetbwL3IA
 fkDfKDq3IyxWNxGK7xRvQG+CvnciCvl5lMiBxxNPdQngCfN4SAKT1jMC7
 4kU42JbG0TxEFAyC8zFb3zHzBRUxRzktfZV/U2+SCzii75Et7DesD0jY+
 N9EpMIZfJuDbtWREmQdimNpcNoXL2RumSfazAbkwaxJDiUnT/jZRuh0AU
 nMx7PTmtgoeAYmSg9L0B1jlUVpfyZp7m8TChKsJL9Amf1/7thcBCHFPsA g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13754893"
X-MGA-submission: =?us-ascii?q?MDEyP95ILps0ugy5ZKszMvAvQKTgKh1EYv77i7?=
 =?us-ascii?q?YRjW+5TGYxFd21ZJh5VVeQ8U/CUJh4PdpvVb07v4+eSP77G02oATJMVu?=
 =?us-ascii?q?ygnQ+yBOVvFi7n5q1KcMxGo272iNkg0ZFMsNKnL/ajsV5FWrnU1hQ/Ww?=
 =?us-ascii?q?QIP3eYBlFziEP2CZlKkHWoVA=3D=3D?=
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.110])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:31:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIrFLGmgThHXphEEUOMvYo5i0dC2Q2hMOAv0h3337YQmCoEPxm8J0CFvNUAPxSqBmBXuA3hISbBwOE4fUkvCQhdbaDQu0UuGXJHi1eXWziXjKOCDYhF55Z6B7uAXFDZffqO3h2yjYvEM23rmxPOCA2zoxzv1rdflbv6eqYxGCn1NsPVp1bNL1mUV5LRZq6oamHD3aKpmEzHoKYp1R8aGHXg6RqN8PgvBWSDBx/ceNHpcrEZ4rDrBFGV3rkehzdEIhSX6aoJhvMwtqRb+p25ZZJGN1tEIJ2KWI858ayyt173VeEKNTwQ+r4YXKn2ioxZs1ZUIp5THAf5RHwpJeTy7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7nbwAIxe29Kj2gk5a3FfNH3Rh6Yz+u/9jRgO23u864=;
 b=T8690GAqRYbl0OmnsHrKRTBnOPjdTIOk5TB9+w5lwYRoxKH2O84R8zZaM+yv5k8wAl5syR39/itXBOHklye5vneAyXz6uCXeO/wbD+228bkxrwYo/k86DfeOHXuQdAFD5PyzQvmFe/hToGNBBj+s0344FJRUCG+7lzaBayIKlAdaTteHp3Tbu/yc/YM3pWlL8rqA1AgA+pcDqJNnhDp6oDG3/OrMKCRxLsDbcMjwx+kh5V9MPMm2lx7Yvp4j5KfKg0/zdonSVr8pmtjx7ouFQH3YfouyQimKsz/cdN4HYXo53HGOQr3QAIbABfYL1D+Jx6YsmwL0dhXcw2Emypdb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7nbwAIxe29Kj2gk5a3FfNH3Rh6Yz+u/9jRgO23u864=;
 b=QuCAmzAmQ/KPjovsVu+J/gn6VcQZkycYWabN+q3vCDMeY34ze5craVDhdq3KV9jKZeRF2hYAqlxM3lH8m6JXl4I88dyhfHWmddxaU9zpEi40XdkMhFOBDxkzgQ/ZLUOHwRE9q/oIEQMkdgAVPv6TR6zVzl3wwQZbAEb0vHEa5t0y6EUq3jD8HL4vIxYnEKrxGbJNVS8b3fP6YUUQTd4cAPu/gVw3XXzeIbAMlqYlHYA/ZU6kDh2sJSd9nrbSASbO+vGPMyFUFhzSv5+9vvG8+w+Kp5gu13QeeLo0OaAANBf7xM7M0kHSTDxWoOjdMblwLw7x3SDwFgj4iVyF4Xw/yA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB9030.eurprd07.prod.outlook.com (2603:10a6:10:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 05:31:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:31:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHalM0ix1VtZwm0bkmmtp6S6avLxLG0w6aAgAEBYQA=
Date: Mon, 3 Jun 2024 05:31:54 +0000
Message-ID: <cc6ff6ff-d8c7-407c-83d3-bda1d4428985@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240602100955-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240602100955-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB9030:EE_
x-ms-office365-filtering-correlation-id: 05d66f21-93de-4a87-029b-08dc838e7aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a2FQMmhNVlp2Tm9WZUdLdGw2UDNUbkJ5OFd0ZVhKcXNSeHBQenM4dWVmQno4?=
 =?utf-8?B?S0lNaExWOUFQRGVGeXJUc3MxNnYrM1ZlWjY0ZjVVclZzQ3dNUFZtazIxQ2dz?=
 =?utf-8?B?bnJMUFVGZVVLSEZqNTVDSm5jMHNCbGh2WWg5dTA4TG4yc2E0VUQ5ZDZTK2JD?=
 =?utf-8?B?L0Z2c09LUXczZzZSMTVmdjRqNGlkck9ia0EvUm0zRlpoVWFSZDRFRmp6SXlB?=
 =?utf-8?B?aDdzOEZhSzIwdHowMmxQdXN5OHFFT1pVQTJQVmxVTVp3bmNicFFUckEyMU5M?=
 =?utf-8?B?QTBJOHhzcEJOcVZrQVFUZFppV2FGWE1yQWNwVnBTbHZvVjJWdGNteGJaZzhz?=
 =?utf-8?B?VE5abzI2Y0JNSXB2aFpJY3RJb05nREdwcmdOdDVUMnl0T0VEWmE2MWw3QUo5?=
 =?utf-8?B?VlUyM2FoNGU2cFRoS05MNkd2K0xVUHQ0REw5eDJJOXVBRXRqRWxzL1hJdGRo?=
 =?utf-8?B?UEtlalp3RjYyWXkxSjYwTjAzWUtobDNYU0tGMlBQVUhUWXZhcDY0QzQxQzN4?=
 =?utf-8?B?cFJFS1dXazcyWXZRYnRjcUVxM09QQjRZdWVTVGZZeGIyRjZXQkFhaE4yTGh1?=
 =?utf-8?B?a0lrd01yb2k2L1hmKzZISnJDTDdrbE5kdDVOTS8rQU5iamNWV0pVaG1xKzhi?=
 =?utf-8?B?bzQ3RjhVU2ZOQXpaZmtBRmFvVlgyOVVpMEY3dkJ1NDNTWEhIOGM3anV6blF0?=
 =?utf-8?B?OHB3cGx4RHZDTlZ0ZzJTZk5UalVGUGNxM2dxWXp0VSt3WEJMS3hDdHczQzBU?=
 =?utf-8?B?R3cwMkRSeHZ6R1F3RDNXYnZnYnk3SG9wK0YrRk50TFoyQWhUeTdydlJkL3Zr?=
 =?utf-8?B?WEZHS3dMdi9BMTA2WGxyNnZYVGdpVWRNamNqK0JHcHFSU2VnZzhhY2lpYzNN?=
 =?utf-8?B?VjMwb2p5aGtMa2VMS1djT1lNOG1xenJ1QjF2cmlQaVU4M2VNR0w3bzhCYzE1?=
 =?utf-8?B?Rkl3bDJianlLVGExdFJzN1VXaklGaDF0MERuSXl1MzFmbnBRM25iMGhvM3BR?=
 =?utf-8?B?elkxbXRrN05QNDZUWEhiZTBvWTRUYWZQV1pKR0lvamI2dTdab25WN3BSR2hn?=
 =?utf-8?B?eC9pTVF3cEVORFZIdk1STFBMVGQwTnp2SnFvTzVtVmU5bFJDcGxyZ1MydmlM?=
 =?utf-8?B?eFlBckUxSkxmaEx5eHNKZkYwWnlYL3Z3TWdYZjVvbFY4SkpMbXBxR1BlSWxO?=
 =?utf-8?B?RmF3dHJ0bitXTmRPMERVeXZUWUlCb3EwK3VqbEc4V01YeHJPNmdEQUwrVXNL?=
 =?utf-8?B?SmpwYXJhazE1UzVLa1RJQytlQnFycG5IRVd1N1BDTURWUVVLUjBGdVJmMkZH?=
 =?utf-8?B?ZTM0T2JHYjNiZmtKTVNXWTZibWZ3SXdEOHhqRTRmZ0taSVpnZlNhNWhIMyt6?=
 =?utf-8?B?UFNMZzhtaGVPQmFJU2tGbU1EeFc1dXJDUHd6alNCVm5IMUZzaFFZU2x1eEpE?=
 =?utf-8?B?UjRiWVpwaVFnNFlBT0xBWk5SbU5ybGl5OEdNTmJjY0prOE8yMSswRkZZSE50?=
 =?utf-8?B?U2VBV1doK0xUV2VKeXRYTU9VQjA4L3JrODRMTTJWY3gyUmhxY3JxODRNVktF?=
 =?utf-8?B?ZVVSWGlKUHAwUWRtQW4xMTVPWTVZbTFSYmtyeSsvMk5PbmFHMHBIeTl1WDgw?=
 =?utf-8?B?M0JVRFpveS9DRnV3dFZZU2JidS9zWHNueUFrWVRZNDVYQ3V6VHZEdXJ5a0tJ?=
 =?utf-8?B?Ukw3NGVVVGEzdU9UUUlFanVoNGxLd1ZQOVJMZENGelRoY3hPSC90TSs2UDUr?=
 =?utf-8?B?ZS9UQjNQSFVzS0hYczFSeHJmeFk5OVBXcUYrdEVFdGpUUUt3c3psRlJheUlp?=
 =?utf-8?B?MEpzUW9tVGNDTCtkNXMwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVXa05kS0VkZjVpdmN3cnpRSm1YQmgvbUxBTUdVQVZ5bEVoVXdZS3ZoL2VB?=
 =?utf-8?B?Vmh4ZExQS0NXUDJpQmJ1WHIwWjM4UzA1UHZKWmRPNDJFYXJYSzd2MDZkSGMw?=
 =?utf-8?B?NnN6b05zdDRBSEh3TnE0ai9SNnlYbEwyakVrbWM1MSswQmVGQUlKenprV0ZK?=
 =?utf-8?B?czBHc21QTFVhVTNIREk1clFRRktXYlk1ejdYNEJIY1lvZGp6UU9ack5qY1kz?=
 =?utf-8?B?cW9KZWswYldNUytyYW1qaUtUbjBGQTNkdjVPSUg1eExMMHhTWXZaNll1M2tS?=
 =?utf-8?B?NlUyeXBwNzNhbmhMci84bG50MWlseTZQd05TcUpIKy93NVlVZ1dISXRWZVl1?=
 =?utf-8?B?MlUzeURtV0drTFlVdEhQVHd5bGpraWZ6UWhjc2lNVjJOT0NTekM4eS9FQXg4?=
 =?utf-8?B?RHJWQ3ZEb2k2SE1uakNwY09sK3dOVTZNbk9CVElQNjM2VTdDbnBpVVFNUXo0?=
 =?utf-8?B?RUN5c0ZsY1JCcFpkYmJwdDNnRVdvdkxxays2UFNvOVl0T2xGb29Sa2xDT0tX?=
 =?utf-8?B?b1ZZUDBBKzJsa1E3bW1aTDFjb1hoazRhTHMvaXBReUM4KzF0QWNGaU5NNnk2?=
 =?utf-8?B?a3N0TDR2L1gyeUFWdUxMZUo5MHZUOFpHc1E5ZmF2VDFtYWk5elVWeUNaUTFK?=
 =?utf-8?B?cGZwd2lxcGI3NXFBQTBxRHczbEtPdTVReFFjcXZqanZQWlhDYVRZN3hFdWZW?=
 =?utf-8?B?YW4zdjgvdkR6QTNTTm13aTRaRFRrV3hOVlJkTmNlZjJqZVBLWlFFdDdvU1g3?=
 =?utf-8?B?aUpOVFpTZTZiSzE1T3JyTURCSVpDK01QMEM1M0JJWS9menJqaFR4dGVnekU5?=
 =?utf-8?B?MWVVVkxyUGtpdUZoVkZ1cFd2Uk9jcnh5NXR5NmRQQmhXV005UlIrRkZYSDZh?=
 =?utf-8?B?YTI0ZGNpUnB2SlUremFFRS9rMCtRTWF0QnJmb0JYZ09tRzViMHZWRFJSdnJw?=
 =?utf-8?B?ZU9rM3ZrVzJmb3lBaFRaQklpMkJhNTU3NC93V1Bib0U3MkZ2bW5sNFltN3FF?=
 =?utf-8?B?cVZGQVJyOWZldHB2c1oxN1lhTEhFVk9yKzdNekMwVU9WTmxmTnIxanJkekR1?=
 =?utf-8?B?MmRIZGJtU2tnNHVaWk5kYnNkMVZ0bG85UWhJY0hGSXpsajhhZ0xYTy9rK044?=
 =?utf-8?B?QUdKaE9IYlUyejZieklDL3kzRHF3WldnWW5pMFA4RFB3SVprSmxjWmxDWmhV?=
 =?utf-8?B?bTl4dEVSbzdsYjdsMVNVZ1ZrQ0kxUmpLanNKdXRLa3dFUkZXM2xCdzVuWTNO?=
 =?utf-8?B?aVZCNGhjS09hcyt3Z0wrcWwzQ0c2WkV5dDB2L1VoMFljOTNZQlVUZTNwOTJt?=
 =?utf-8?B?WHdzTGVJZDlMMXV5bFI3ampxVVlhS09PQ0xBRFJDRDZkS1BJd2g0ZDFkUjFv?=
 =?utf-8?B?eENkeTNHMnhTRk1kMVh3ak5GV1d5QisvenVubnRBWE9ZcjZxT1p5OEZvTlRq?=
 =?utf-8?B?QStJT1NXN1h2bXMxTUhzMkwvRlZyb0JLbkhtcnhLNXRGMzZxaElSOTVFdndz?=
 =?utf-8?B?MnlTb1c4Y09TNVdOVmhmaTRmSExGNVpkV2c3OVBabVowdStWc3EzTnVscUZQ?=
 =?utf-8?B?SG8yTGxFNXZoMEVsZEs4bDY5a1hvQkJ0K09qK2swbWMrbXd5UjliZHdkbXBq?=
 =?utf-8?B?Y2k1VUlTZzY2MEFBOTJCZVgrc20xVUVYUEltZ09lZG5IT29kaU1nR3BFVGty?=
 =?utf-8?B?eCt3OXBCa1ZrQ1NUbFdSTGxUMWVOMnRjQkp4NWZZRUs5M3pXK1IvZzV3RnlL?=
 =?utf-8?B?WDJqdmpCTkR5ZUIzM2xWUWh3ODlXSytGYlJtSDBSS3lCZHB0dWJwRjMrUU92?=
 =?utf-8?B?Smk1Z0tBcnl3cjlvbkNjUUZWNDBrRitvRGhoZzdIc1M3eFpRbGlqVUVJalRW?=
 =?utf-8?B?Z25uRWFSbmt5dHBsVHZRK1ppbzJ0aGVKRlhhR3pKeTJTU01naXNGTkV4TlRq?=
 =?utf-8?B?eElLUXBxb2NKM0xmWlZEVXBneEZmV2cyUFdndVY5N2wrd21KRElQakQzNW1Y?=
 =?utf-8?B?QW9YVTR0NjZpSWh2Tm9aZ3F1ZEtlZ0pMYzNNTmdWMzlqZnRxMndoTGRzc3M3?=
 =?utf-8?B?YVViUlhnWFdQMzJSRmhoV3BYQy9BZ2tYTzRHL3VQRlgvSGxIU2QxRkQvK2Mr?=
 =?utf-8?B?dm9YUm5oQ2NRSUJjdVBsdVhjY2EyU2I5ZWF6cVl0bFlpalRDN2pCUEk4UEt3?=
 =?utf-8?Q?TFiGgc0RbUpj2VjWe+wYCbQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFEC11B0C99256449F258CF60DCCE5C1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d66f21-93de-4a87-029b-08dc838e7aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:31:54.5978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1dv7gewbSh0u0L1JrI5e+iovEJL/EscLjtL5oO6ucNZI1zDY3/di/LnW1dCmfWFa/BAabGUBbIV4WyM2zO8lw7lKtaF57r8mQtyZCLn3WUnXTs8J8zeEGivF42C0kYs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9030
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQpPbiAwMi8wNi8yMDI0IDE2OjEwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24gTW9uLCBBcHIgMjIsIDIwMjQgYXQg
MDM6NTI6NTJQTSArMDAwMCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4gVGhpcyBz
ZXJpZXMgaXMgdGhlIGZpcnN0IG9mIGEgbGlzdCB0aGF0IGFkZCBzdXBwb3J0IGZvciBTVk0gaW4g
dGhlIEludGVsIElPTU1VLg0KPj4NCj4+IEhlcmUsIHdlIGltcGxlbWVudCBzdXBwb3J0IGZvciBm
aXJzdC1zdGFnZSB0cmFuc2xhdGlvbiBpbiBWVC1kLg0KPj4gVGhlIFBBU0lELWJhc2VkIElPVExC
IGludmFsaWRhdGlvbiBpcyBhbHNvIGFkZGVkIGluIHRoaXMgc2VyaWVzIGFzIGl0IGlzIGENCj4+
IHJlcXVpcmVtZW50IG9mIEZMVFMuDQo+Pg0KPj4gVGhlIGxhc3QgcGF0Y2ggaW50cm9kdWNlcyB0
aGUgJ2ZsdHMnIG9wdGlvbiB0byBlbmFibGUgdGhlIGZlYXR1cmUgZnJvbQ0KPj4gdGhlIGNvbW1h
bmQgbGluZS4NCj4+IE9uY2UgZW5hYmxlZCwgc2V2ZXJhbCBkcml2ZXJzIG9mIHRoZSBMaW51eCBr
ZXJuZWwgdXNlIHRoaXMgZmVhdHVyZS4NCj4+DQo+PiBUaGlzIHdvcmsgaXMgYmFzZWQgb24gdGhl
IFZULWQgc3BlY2lmaWNhdGlvbiB2ZXJzaW9uIDQuMSAoTWFyY2ggMjAyMykNCj4+DQo+PiBIZXJl
IGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4gZmluZCB0aGUg
Zm9sbG93aW5nIGVsZW1lbnRzIDoNCj4+ICAgICAgLSBRZW11IHdpdGggYWxsIHRoZSBwYXRjaGVz
IGZvciBTVk0NCj4+ICAgICAgICAgIC0gQVRTDQo+PiAgICAgICAgICAtIFBSSQ0KPj4gICAgICAg
ICAgLSBQQVNJRCBiYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCj4+ICAgICAgICAgIC0gRGV2aWNl
IElPVExCIGludmFsaWRhdGlvbnMNCj4+ICAgICAgICAgIC0gRmlyc3Qtc3RhZ2UgdHJhbnNsYXRp
b25zDQo+PiAgICAgICAgICAtIFJlcXVlc3RzIHdpdGggYWxyZWFkeSB0cmFuc2xhdGVkIGFkZHJl
c3Nlcw0KPj4gICAgICAtIEEgZGVtbyBkZXZpY2UNCj4+ICAgICAgLSBBIHNpbXBsZSBkcml2ZXIg
Zm9yIHRoZSBkZW1vIGRldmljZQ0KPj4gICAgICAtIEEgdXNlcnNwYWNlIHByb2dyYW0gKGZvciB0
ZXN0aW5nIGFuZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KPj4NCj4+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9CdWxsU2VxdWFuYS9RZW11LWluLWd1ZXN0LVNWTS1kZW1vDQo+IFBscyBwb3N0IHYyIGFk
ZHJlc3NpbmcgbWlub3IgY29tbWVudHMgc28gZmFyLg0KDQpIaSBNaWNoYWVsLA0KDQpUaGUgY29t
bWVudHMgaGF2ZSBiZWVuIGFkZHJlc3NlZCBhbmQgSSByZWJhc2VkIG15IHdvcmsgZm9yIFNWTSBz
dXBwb3J0DQpvbiBaaGVuemhvbmcncyBGTFRTIGltcGxlbWVudGF0aW9uICh3aG8gY2hlcnJ5IHBp
Y2tlZCBwYXRjaGVzIGZyb20gdGhpcw0Kc2VyaWVzKQ0KDQpZb3UgY2FuIHNlZSBhbGwgdGhlIGNo
YW5nZXMgaW4gbXkgc2VyaWVzIGNhbGxlZCAnQVRTIHN1cHBvcnQgZm9yIFZULWQnDQoocG9zdGVk
IG9uIE1heSAyMXN0KS4gSSBhbHNvIHBvc3RlZCB0aGUgUFJJIHNlcmllcyBvbiBNYXkgMzB0aC4N
Cg0KSSdtIGdvaW5nIHRvIHBvc3QgYSBuZXcgdmVyc2lvbiBvZiBBVFMgdG9kYXkgdG8gYWRkcmVz
cyBQaGlsaXBwZSdzDQpjb21tZW50IG9uIHBhdGNoIGNhbGxlZCAnbWFrZSB0eXBlcyBtYXRjaCcN
Cg0KVGVsbCBtZSBpZiB5b3Ugd2FudCBtZSB0byBjaGFuZ2Ugc29tZXRoaW5nDQoNCiA+Y21kDQoN
Cj4NCj4+IENsw6ltZW50IE1hdGhpZXUtLURyaWYgKDcpOg0KPj4gICAgaW50ZWxfaW9tbXU6IGZp
eCBGUkNEIGNvbnN0cnVjdGlvbiBtYWNyby4NCj4+ICAgIGludGVsX2lvbW11OiByZW5hbWUgc2xw
dGUgdG8gcHRlIGJlZm9yZSBhZGRpbmcgRkxUUw0KPj4gICAgaW50ZWxfaW9tbXU6IG1ha2UgdHlw
ZXMgbWF0Y2gNCj4+ICAgIGludGVsX2lvbW11OiBhZGQgc3VwcG9ydCBmb3IgZmlyc3Qtc3RhZ2Ug
dHJhbnNsYXRpb24NCj4+ICAgIGludGVsX2lvbW11OiBleHRyYWN0IGRldmljZSBJT1RMQiBpbnZh
bGlkYXRpb24gbG9naWMNCj4+ICAgIGludGVsX2lvbW11OiBhZGQgUEFTSUQtYmFzZWQgSU9UTEIg
aW52YWxpZGF0aW9uDQo+PiAgICBpbnRlbF9pb21tdTogYWRkIGEgQ0xJIG9wdGlvbiB0byBlbmFi
bGUgRkxUUw0KPj4NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgNjU1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggfCAxMTQgKysrKy0tDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oICB8ICAgMyArLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDYwOSBpbnNlcnRpb25zKCspLCAx
NjMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gLS0NCj4+IDIuNDQuMA0K

