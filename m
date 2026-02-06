Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163CBEB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIfW-00047R-Fg; Fri, 06 Feb 2026 05:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1voIfT-00046v-T2
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:02:28 -0500
Received: from mail-japaneastazon11011034.outbound.protection.outlook.com
 ([52.101.125.34] helo=TYVP286CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1voIfR-0003Qj-Dq
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:02:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0zP5WDFbnd1nBNyixdtAe4Pj3ToxerMfx5WatOtkulF919TOUJgcCR1MfIoclF++cck9PJYzdvXEAwpydZCBi29OE5f1g8tNTNUFVsJTvsDKIOw8MMVIjZjSFAU0fJZgg1KRG8JiwbwjLwiZ3PtrRracZsH1nY5f/CbRYWGM1V+amdn/g1iQmnl9KYI7SgIV9VKOX1nSHueAQtODZylSwsrEFSvBASl1M+LW80MqsjlmWt/o345RzCTgffSSj5x2d2+72JOBhzozmleTh6YEuHIK1BaNdBAciwdj1hmB3i0mRhiS5zEaY2icICRvwg0wOApQWhgtLNKYlmnaTqJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw4JgSBHGRPThVsiRVZmY64zHPe3wWAUMXguf3INfcU=;
 b=LJR8zIsIDS+u/LMGKfeNHGOtsbmfmxHi1zAu49nS6eIS7Jv/+WBoEF+OLfNDcKXGDhj+YnA4OZgujjuCkyAt8olxe1ct+hO5DBXp+IabhsiEC+xx4tUVBvA9+Ptzy2bAjNZb3eIWxdIBP2JJtnuxVtrXmYoms13Uu38s9SDTWX54CEEBs1Es+MX3429vitgpEc3DPrMqc2MzbOjCiyCIugCVoq6JW7mipw0kjVs7pBrcAbSyKaXeqvwNUvkBnx8FVLBOcQIbTFTL/Ev+oS0eVb3PTEwVI8Yw1gjeSRSxE5gNNpqULAej6WzwRt3dzPpMIkTcCA/fXw2T2a867/na9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw4JgSBHGRPThVsiRVZmY64zHPe3wWAUMXguf3INfcU=;
 b=qQK7RSqnqA6PvTMLQ6HQjbjWbVpnhcSHWDRxgTZjMxzDXFIeuoFho/+tZ3dcvpdJ+7elXZLKlQkIwKkvacMypie6MHqf/Opty/9os7uhi4qkaMbYn263jPdJlf5B+xFgEq0qMTGaWeImwR/rypolILmFFQEKb0ftqSwnMd5y7FLwM6vT4LK5S2iww9rHiDlZo3Kk5MC9YR8ynb0OtR1hI/asT8qL0bIkQKN1xzaYlKz8gQ4iMDdR4pRqve9XjuGyGu3CbwnD9olOKhR7Zc4G9CbeJbjWw1JMQxPkePloqJzJOtwtlQmiFbim3q/xkVbQbiP2q6fbMfoTXEY4amCLWg==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by OS7PR01MB16883.jpnprd01.prod.outlook.com
 (2603:1096:604:420::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 09:57:15 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 09:57:15 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "mst@redhat.com"
 <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "ppbonzini@redhat.com" <ppbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@kernel.org" <david@kernel.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "venkataravis@micron.com"
 <venkataravis@micron.com>, "gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH v2 1/2] hw/cxl: Use HPA in cxl_cfmws_find_device() rather
 than offset in window.
Thread-Topic: [PATCH v2 1/2] hw/cxl: Use HPA in cxl_cfmws_find_device() rather
 than offset in window.
Thread-Index: AQHclecJWatVtoQBAU2ctWN2bK/V17V1ciIA
Date: Fri, 6 Feb 2026 09:57:15 +0000
Message-ID: <0829feee-2bae-4557-8c0f-9ec329a17b2d@fujitsu.com>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
 <20260204150002.669-2-alireza.sanaee@huawei.com>
In-Reply-To: <20260204150002.669-2-alireza.sanaee@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|OS7PR01MB16883:EE_
x-ms-office365-filtering-correlation-id: 897a97bc-fde6-4675-70a2-08de65661b58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZXc4VERDUzJhU0YxSnJqOWJjYkRFam50a1EyQmNaWWh0NlFGOUIxU3h2di9V?=
 =?utf-8?B?aFozU2krVzFuTHNlY2xYdmlUYlprZVlBOGdLYi84OVk5VlQwdnhXRGNqUzdz?=
 =?utf-8?B?NzRiT1ZPMVoxWTRnR0NnZTM1LzZEbHgvYXo0OXFnRkhwYXJlQ1FQSXRQSEFF?=
 =?utf-8?B?UCtNNnlBVnllQVJyUzQwaEhqNm1aNnZZZDQ4N2N3UElnTEFuZGFiWWtqVW53?=
 =?utf-8?B?SEJPOWd3TThCeWVSdS8vQjhrMzJYM0lHTlNYQ2NGbVd4LzVOK0Uvd1BzMmNU?=
 =?utf-8?B?dzFOWVBXOU1QZWtEVjRwZUtZV29DL3ByQ2ZFakNYdEkrNG9lQWNYdWlPRGFr?=
 =?utf-8?B?TUtsNTV5WWgzWUtVMmZiTUxpbkEyZFBnRk5PelRraStjZWlla0hGTGVWQUN0?=
 =?utf-8?B?aVFPNTVROGdtaXdTSDZQUkZORVRtcGlYczFTMjVncHRlUkRTUk4wR1pHOFdY?=
 =?utf-8?B?OC9vK2hwTjc5cldHd0xSbWR6eUhOV3dnVlg4bmtCNzd0SjVCdnd2TFYvS3lD?=
 =?utf-8?B?Nkp2elhhTnE3d1k3dGdrM3NlbDBURWhGRzdqQ1FJWHY4aTNPVkRQNFc1TndI?=
 =?utf-8?B?T0h5dHBacGwvZUg5SXZlSzg4RzZEazdHZ0EwS0ZtT0xVQ0NGclZyWUx4R3A2?=
 =?utf-8?B?M01FSGpkYkdVRGw1Vmk3eXhOVXpuQ3F5SjMrKzhCUVFreGlWOHVKamRSMjdG?=
 =?utf-8?B?K0RUWk02N3loSnVMSjYwVksydkRiaVUxbFgwdFVtaUpvUnBxTEFzeFNvS0Nl?=
 =?utf-8?B?L2lydlJXVlZxakxSU2VrM0llQ3F6WmN0OE1leGJKaE9IN0hmNldWK0xlUWNv?=
 =?utf-8?B?cVZlVUdOeHVQVUM5MlNsU1JxRFBGNkVjRjMxb3g2Zy82UEttS09BR1k0WFVp?=
 =?utf-8?B?aWpQZXlvc1ZkRjVwejlheHBXOXJpN1ZPV25yR0xSZjRlTEtDNEJwdlF3SWxF?=
 =?utf-8?B?WWRqMWxtdEoySkMzVmlGMTQwWnlBOWM2UGdrTG1sdjBoaG1VN1h5ZmJaWUoy?=
 =?utf-8?B?QUZTaHp1WXBSb1lURndZUGFZLy9DRFZIcHlzM2E3THA5Z1VCaUt5aUdDTWY2?=
 =?utf-8?B?bGM0S050ZGdlTlI5K1kzZWdNOGdDUEdwU3JsSi9VN3RNNVRsT3laREFIQytW?=
 =?utf-8?B?M0tRRWJ4NnQ5QitVR1VUaGdSSXdVZzhpZjdMQkd3dG8rY2NvSmlJckRZUzF1?=
 =?utf-8?B?NzdRNzBMMnFxVURIRXU3NVZRYkhtb1Q4b2V3WWQ5VUh3bThlQmovdStwNUxm?=
 =?utf-8?B?QkpTWlFvS05nM0cwY0EwYWc1RXRiNzdGeUZzTHZHMlk4czZWbHowRzJTaStO?=
 =?utf-8?B?bUdXSVMyYnI4K001aUtEWkgzU2NnTGU0eE1kN2hXaEJJdk9HZkRFY1ErZ25R?=
 =?utf-8?B?QkhEVDV0VVp0cEpvWEd3VE5yVmZGRTJxZ1F3TnVTaXJGUG1FMGVwY3ltcENv?=
 =?utf-8?B?elF3NFVGbC9QQXQzOVN0UnQ4MEFiS0xvWWF6MHJwNTkyazdJcFNrb1l2VklH?=
 =?utf-8?B?WGcvL3FhR3Nhd3Mwell5QkRrTDJXTEdOWUpPa0liSlJsWHFjc2lWSzEvQUph?=
 =?utf-8?B?eklBRWhmM3YrNWZkMWJZNDFYdUdrNjJMUExHMHFsQXFSVTJ3R1E2UXJmbGkw?=
 =?utf-8?B?eTNVeE1KVk51T1hKeWtjMUpvdE9CcjZWU3FaL2RRekJ2ZW93MWw4TnJGRkFE?=
 =?utf-8?B?RHo3eXZydmtqYzJ4ZWRqMEpSUnBpT2I3c09qRUxXZzZzQVpTaHRFc29pbDdz?=
 =?utf-8?B?ekpNM1RRZmxZdDQvTGkxQTI3RHNWVmYrNzU3VGFyK2ptQ255Y0ppNk9oTlRi?=
 =?utf-8?B?NUozdXNTTjUxUDNTU2VyZzNpV0U3OVNDdGY2UFhMN2p5TUJNUU5iS1l1WW5k?=
 =?utf-8?B?M1ZMUWhHVmh3TUlldXRsMkladjBJUW4xb3pEREdpWEZyNjdrWFVQZUF1bWl4?=
 =?utf-8?B?U0hwdEhMOFBUTDBROUtNNlBsaks2NTdVcXdnc0x5eGg5SzdBMjgzejV4a1l5?=
 =?utf-8?B?Z09ZVkNmZU02ZmVBOG96amEyVGowbXJmYjByUGI2TXZZamtObXRpNm1MeEp0?=
 =?utf-8?B?L0lnd0dDOUUrcERmR1g4RzlrRU5FSGk2VDhIR3o0djFVd2p4NEMyTi8zVGRz?=
 =?utf-8?B?QmFxSWI3b2MwM0NqRE5CZ1ora0JaYU1pM1o0cUJHd0h3NEhtK0JkUm51d095?=
 =?utf-8?Q?VTpxfXnmLzo8ZOa2FCazhbA0zwDEbWtQqQFfRvTulhrb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3lkeEVFWnR0UEJxa0NxczVtd3k2VlRjQjNkUmNSOUdHcElwajBoRXpZb0tl?=
 =?utf-8?B?WHlVLzVNcmVqc1Z3N2l1bXUvSXBObW5OQnlwRFgySFB4WVFQSm8rWWdqWkx1?=
 =?utf-8?B?UEwvcjJqQjJYeUIrV1ljS0M2UGErTDlxbCszcFJMb0lURHlkS3ZzRndTdlpX?=
 =?utf-8?B?aHRuVTExWldQaWJXcHEyRmRrdnhlRFZrakpQeE92M2t1aDZKc09Nbk5RYlIz?=
 =?utf-8?B?M0xkTGxBY0lkT0dOaUYybEVnajBxb1phUnJ4cldha0tvTUw3R0hkd0gyVHl0?=
 =?utf-8?B?ZDc4VFF3YU8ySjgzTnY2amkxMFNTWTFic1ZwdE00cmwrYlBoektiZjBkK0xt?=
 =?utf-8?B?NktDNEJrRW55RTZSeDBkM0pvUXJHY3NiZFJZbXpHMUtqSEhrVjVHVHNRZ29n?=
 =?utf-8?B?V2wybGk1K1JuQ09CdmF2R0hyZXMrMW1vMzZ3VEM2ZkdxM0Z6MnNUTE41ZDZh?=
 =?utf-8?B?ZE5US3FGNlR6U2ZkSmhEQk9YdDYzQW5rTnlNZVJ0RHpQY1B6T1dUMjFLZk5D?=
 =?utf-8?B?aVRlMnRtb3FDeTBBaEVYVzhlREx2N0tGekpKRU1mb2VwczNFVU9JQ3ZJdnJC?=
 =?utf-8?B?RUhPNy9veWlERjJOWG03YWNkM2JtNXFwQlZLVXpHbzJyb2l1VlppWnExS2Ru?=
 =?utf-8?B?VS9BMjdJejVIR1pnSVFoazc4TDRaWUZ6cjc4THZHTU9naVNxSVNIWmxjZ1dB?=
 =?utf-8?B?RzhXdStlSlZyeFFmY25CQlc0L2lZUjhIQnp5OForaFJKbldpMVpxcmtscWxU?=
 =?utf-8?B?d2FyK3FHMFVOY0FVb1JTMzY2WGFHdnA2djFuaFlwb3hkUXZrQUVHaGlQZElx?=
 =?utf-8?B?VDMzNXRmRTZzTG5KTzFmenpTc2FxM29YdG5JRzBhcGswdnRvVUc5VEM2MmFh?=
 =?utf-8?B?WFNKZzZUZkRiczE5U2c0TWY3YXI1QzJXWS9kRnhSblByQW04cHFNMmlrL2xR?=
 =?utf-8?B?NDEyS3d5cmZ0ZndyMGdQOWFPUDNoV21kTGNoaWJPOGFxTVZZUVE0Tzhhd2NS?=
 =?utf-8?B?OUdZczJBUXVRdk5ieWlGZllPVi8wT3R2aStpeUhZLzh2UnkxTE1hd3FGRVho?=
 =?utf-8?B?Y1l4R01kUTNENG1CNmhqVkYvN0dpcTRxUGFGWnhXWm5BU2FVZW5SL21VeHcv?=
 =?utf-8?B?WU0xd1IvUU5zTmFsV0NYV2NzVjhQMXdTOVJTcUplZFJMT2xkSnVCVnEzNzU0?=
 =?utf-8?B?OEFqUDhqRnJEVEUvL0FTVXpSQ2VKV0VtRE90UmlwajB4Ry9WWGRGRTJ0dEhp?=
 =?utf-8?B?QVFQd0RIc3ZpZXpneEloWWptMjRXSWxCMTc0QzAwZ214QkkwRzdzNHF6UFZU?=
 =?utf-8?B?OVJ3UWtYbVZNV284WXh0czF2RVJHVTRIWmZUTDRjMnpXQ2VQOFg4RkJyUmxl?=
 =?utf-8?B?UmQwVUoxeFdDbXA0U3NaYllkcVJTb1UzZUwrZWVTWVhXaFcrTEMrWHBxcTRy?=
 =?utf-8?B?L2VzWmRTMFNMVFBxTFVESWFRNkJTMnY2ZndwV2EzNjNzNUJFbzN0cDJITmkr?=
 =?utf-8?B?Q0ROYUhpa3g2L3VxMWU1QVR2VDFaTVJjUWpJV0RXcUNjaHBPbkFkVVp6NGFz?=
 =?utf-8?B?YXVmRlhsR0h6VXdlU0xlM3dmd1BxZ3JaZ3N4NHZCc1VSckRtL2tOaHpYT1RU?=
 =?utf-8?B?VndTWjFDL01uOTAya09kcDk2QzVDOHVGekpoVTE0WHNlU2ZCZk9BR2VhdWVS?=
 =?utf-8?B?bGIxOUFlSWQ1VDQ5NjNmUXZON1hwY2ZBb1ZFUm45WHBYZ2FSZWh6WSsvVFlm?=
 =?utf-8?B?VkxZUnVsTFVvekszdjVZdU84a0RtM3V0NkVTTHk2cURIUHNERDJBUDdlZlE1?=
 =?utf-8?B?TVgra01STjhGRHowN3FONkd6VytDYmhBZDV5U1BPMFg2bDMvRnhWcEpTdjdU?=
 =?utf-8?B?cEsva2RtUXNSZkc4R0NUWUVwM1VXcWZZK2JBU0paY29qbURqcUtUUGFOdVZI?=
 =?utf-8?B?a0RqR21panFrNnA2VzNiS2JKUndob2dPOXBZSlY4a21PMkpoWWVZTWhzaS82?=
 =?utf-8?B?OWxxMUNxRm1mUjFCVU5tVEhRdUVac0g4RjhTKzMybHV5eEZoOFM5dHI1cENT?=
 =?utf-8?B?U3c4Nm1XOVNVYkdVaFRjUWN1SitxdWNnelhvVjdwbU5ReXYzWFl4cnN2eTRP?=
 =?utf-8?B?T3R6ZHhFT3k1VThSZWtZWDYwUU96VTVHQkRHR2FPNi9EMloveENMOHJkU3BT?=
 =?utf-8?B?ckpwZmt2T0RtSFp2RE5NM0RObDNuOExmK253WnJKKzMwcTVkVEhQWno3Z1pG?=
 =?utf-8?B?ay9EalBnekFsR1VXc1BtZmZPUzJCTG01cy9wRXl6MTJtQlJGQ0dSamQxdTI2?=
 =?utf-8?B?WjFBajhJeGVVdXI1SEJqVDhNaW9kbTNhL0M3ODJoWGpHTFZ1MFVNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5412FECF818BAF4F8615F488FEFCBB0F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897a97bc-fde6-4675-70a2-08de65661b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 09:57:15.2561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dipVL0ih3ivu2CTNY8eROInAq/GjKR+pXGI5TuKez4I/kQiBjE6LTgkIi7+LZhMgimJ4ZXh1T6CEh6h3WmjiQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB16883
Received-SPF: pass client-ip=52.101.125.34; envelope-from=lizhijian@fujitsu.com;
 helo=TYVP286CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

DQoNCk9uIDA0LzAyLzIwMjYgMjM6MDAsIEFsaXJlemEgU2FuYWVlIHdyb3RlOg0KPiBUaGlzIGZ1
bmN0aW9uIHdpbGwgc2hvcnRseSBiZSB1c2VkIHRvIGhlbHAgZmluZCBpZiB0aGVyZSBpcyBhIHJv
dXRlIHRvIGENCj4gZGV2aWNlLCBzZXJ2aW5nIGFuIEhQQSwgdW5kZXIgYSBwYXJ0aWN1bGFyIGZp
eGVkIG1lbW9yeSB3aW5kb3cuIFJhdGhlcg0KPiB0aGFuIGhhdmluZyB0aGF0IG5ldyB1c2UgY2Fz
ZSBzdWJ0cmFjdCB0aGUgYmFzZSBhZGRyZXNzIGluIHRoZSBjYWxsZXIsDQo+IG9ubHkgdG8gYWRk
IGl0IGFnYWluIGluIGN4bF9jZm13c19maW5kX2RldmljZSgpLCBwdXNoIHRoZSByZXNwb25zaWJp
bGl0eQ0KPiBmb3IgY2FsY3VsYXRpbmcgdGhlIEhQQSB0byB0aGUgY2FsbGVyLg0KPiANCj4gVGhp
cyBhbHNvIHJlZHVjZXMgdGhlIGluY29uc2lzdGVuY3kgaW4gdGhlIG1lYW5pbmcgb2YgdGhlIGh3
YWRkcg0KPiBhZGRyIHBhcmFtZXRlciBiZXR3ZWVuIHRoaXMgZnVuY3Rpb24gYW5kIHRoZSBjYWxs
cyBtYWRlIHdpdGhpbiBpdA0KPiB0aGF0IGFjY2VzcyB0aGUgSERNIGRlY29kZXJzIHRoYXQgb3Bl
cmF0aW5nIG9uIEhQQS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsaXJlemEgU2FuYWVlIDxhbGly
ZXphLnNhbmFlZUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBody9jeGwvY3hsLWhvc3QuYyB8IDYg
KystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9jeGwvY3hsLWhvc3QuYyBiL2h3L2N4bC9jeGwtaG9z
dC5jDQo+IGluZGV4IGYzNDc5YjE5OTEuLjk2MzNiMDFhYmYgMTAwNjQ0DQo+IC0tLSBhL2h3L2N4
bC9jeGwtaG9zdC5jDQo+ICsrKyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+IEBAIC0xNjgsOCArMTY4
LDYgQEAgc3RhdGljIFBDSURldmljZSAqY3hsX2NmbXdzX2ZpbmRfZGV2aWNlKENYTEZpeGVkV2lu
ZG93ICpmdywgaHdhZGRyIGFkZHIpDQo+ICAgICAgIGJvb2wgdGFyZ2V0X2ZvdW5kOw0KPiAgICAg
ICBQQ0lEZXZpY2UgKnJwLCAqZDsNCj4gICANCj4gLSAgICAvKiBBZGRyZXNzIGlzIHJlbGF0aXZl
IHRvIG1lbW9yeSByZWdpb24uIENvbnZlcnQgdG8gSFBBICovDQo+IC0gICAgYWRkciArPSBmdy0+
YmFzZTsNCj4gICANCj4gICAgICAgcmJfaW5kZXggPSAoYWRkciAvIGN4bF9kZWNvZGVfaWcoZnct
PmVuY19pbnRfZ3JhbikpICUgZnctPm51bV90YXJnZXRzOw0KPiAgICAgICBoYiA9IFBDSV9IT1NU
X0JSSURHRShmdy0+dGFyZ2V0X2hic1tyYl9pbmRleF0tPmN4bF9ob3N0X2JyaWRnZSk7DQo+IEBA
IC0yNTQsNyArMjUyLDcgQEAgc3RhdGljIE1lbVR4UmVzdWx0IGN4bF9yZWFkX2NmbXdzKHZvaWQg
Km9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90ICpkYXRhLA0KPiAgICAgICBDWExGaXhlZFdp
bmRvdyAqZncgPSBvcGFxdWU7DQo+ICAgICAgIFBDSURldmljZSAqZDsNCj4gICANCj4gLSAgICBk
ID0gY3hsX2NmbXdzX2ZpbmRfZGV2aWNlKGZ3LCBhZGRyKTsNCj4gKyAgICBkID0gY3hsX2NmbXdz
X2ZpbmRfZGV2aWNlKGZ3LCBhZGRyICsgZnctPmJhc2UsIHRydWUpOw0KDQoNCkl0IHNlZW1zIHlv
dSd2ZSBhZGRlZCBhbiBleHRyYSBwYXJhbWV0ZXIgdG8gdGhlIGNhbGxzIHRvIGN4bF9jZm13c19m
aW5kX2RldmljZSgpLCBidXQgaXRzIGZ1bmN0aW9uIHNpZ25hdHVyZSB3YXNuJ3QgdXBkYXRlZC4N
Cg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KPiAgICAgICBpZiAoZCA9PSBOVUxMKSB7DQo+
ICAgICAgICAgICAqZGF0YSA9IDA7DQo+ICAgICAgICAgICAvKiBSZWFkcyB0byBpbnZhbGlkIGFk
ZHJlc3MgcmV0dXJuIHBvaXNvbiAqLw0KPiBAQCAtMjcxLDcgKzI2OSw3IEBAIHN0YXRpYyBNZW1U
eFJlc3VsdCBjeGxfd3JpdGVfY2Ztd3Modm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwNCj4gICAg
ICAgQ1hMRml4ZWRXaW5kb3cgKmZ3ID0gb3BhcXVlOw0KPiAgICAgICBQQ0lEZXZpY2UgKmQ7DQo+
ICAgDQo+IC0gICAgZCA9IGN4bF9jZm13c19maW5kX2RldmljZShmdywgYWRkcik7DQo+ICsgICAg
ZCA9IGN4bF9jZm13c19maW5kX2RldmljZShmdywgYWRkciArIGZ3LT5iYXNlLCB0cnVlKTsNCj4g
ICAgICAgaWYgKGQgPT0gTlVMTCkgew0KPiAgICAgICAgICAgLyogV3JpdGVzIHRvIGludmFsaWQg
YWRkcmVzcyBhcmUgc2lsZW50ICovDQo+ICAgICAgICAgICByZXR1cm4gTUVNVFhfT0s7DQo=

