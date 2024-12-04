Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38988E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIiev-0001wg-32; Wed, 04 Dec 2024 01:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tIier-0001nn-BR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:14:45 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tIien-000426-GX
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1733292881; x=1764828881;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9doHJ8jxUaXyEP1bcVoKEAGfXbF1WgllKjOpbx8V32A=;
 b=Sz+lqpLW+n77P+eEnfZaUHzX0ogA+G8ysC2329jOqZtT334gCIPbHhrv
 T24Xdz40VZkk0gfUbAmgvisAbyZPVuK9VMy6K36gKDpF4wJaXWy8ga/vm
 /Kb0ih+FRfKplOdnuz/MCTtHmgUwNMwuel01Ln8VPghvnT938QDyKy7UG
 xxZvH+RhmzO/arSgBpSX4678vWw6KEI2ckEzahmMcFpvcRTqugDU+zSua
 NQx9ESngrgP0xRXVEfeiywKRW19I0xZEJKzUvoQfZKU7YnpbfgnuA5+XM
 vFOC/ALY9K8rOXoQhuV+v22ttx0jPLGXe8c65FstJKBS+ISikMu5nNjrn g==;
X-IronPort-AV: E=Sophos;i="6.12,207,1728943200"; d="scan'208";a="26733910"
X-MGA-submission: =?us-ascii?q?MDGtN0dDlcF6u6gNwx5Xsc/Vkr7dnYr60lKp7+?=
 =?us-ascii?q?B7SHed9zgZ2+FCWO0RiA32gy8LJOogEzD2+SdK+Xdec4togs7ABDDGMC?=
 =?us-ascii?q?9qd+zKndU2td3ryri0WvvLK1t07wBQY4+x+5tDYfKPtvbGs9rGnKCzPv?=
 =?us-ascii?q?MBC+2PTZvQejb19kylkLSjsA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 07:14:11 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlcnP6zAQOcTHtTJfOB8HnGMXoMr4uZLtwNnjo1LVLL2rrJa0pqFJ2YdJasZDeatXTJHMSjcFTscM6REU/cyqrzI91cn4mCQkw4jQrf9mvkC5aMFX2iVfaQv3VvYn20iMgfrSaLxk1OAYeJQYiFETe6an7BxYoxl7u9YG6XfZDjr8wIB/nsqTf1ClLNcDOvzBCjr1xXx+kIQaaKCqmtJEoKMdFNbZf5SV+ZIJqanXNzxo8QJQimneVb8IFwKOu4IH+B2okRrwIXFLuof+oJT/UG+KhHRxS/+RRO9Fd3oy7JKrs8/jBNdC2l6mDWRitL48t3C8BrWZDxRU2vBWRQtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9doHJ8jxUaXyEP1bcVoKEAGfXbF1WgllKjOpbx8V32A=;
 b=T4zVxejfI/ZeMKlx9y2IwvUANNE/xwIClRVOP/a1ZmDVF/rWxWZwY1TRT3ergGXTjYKRlbMw21ZU8nc1s0gYjKP6unBI/1vRdyLFxS+/yo8NG32sDOOLJgov2cqTOsHXFKQp1k/MjU5B+B/jegY1QPKynlXumnHb8uDzLEWjS2V8i3O+fyR5P0o6zCP3er6Zzum1GeF2nCEbzuG71G+Cn5X0sGhftQJzz11HopWzas+NQSnzu7d5AJstgXCilJPF8x1HpDFh4mu5RmTD5vauwTcwJMXZh5uBind7pWx+HEkZmVR0RIIOr54tbkffsqcdvRhDGLRsEsfEebVMEfewSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9doHJ8jxUaXyEP1bcVoKEAGfXbF1WgllKjOpbx8V32A=;
 b=FQltvcJPiU3OXCWIdeHQThiY5Xn5UlZbJw6lvpQnpSaOSJ/Ru8Xd2qbu9/5hlYa7zA628LVdQ7ioZ4Qv1MLInOWQsbwobHqglWo8D8PnLJlZIHOVlEdkA9jxwhIz+C0iIEmc6HWjDXlTMUIsFflzaFcV6gD9qUl2h7YOLY7+B+rnpNVWH62Xqvw6f/JHVGhi5/Tj4UEJSHiBGjXHIn8NUcfCralVmDXS6wHBTlWZ/s4QdY3THf3ZU7SBCWLGygDVSZjVZ6VMc7p97BNZwQMnfEpAIa+S0Gu3UpHLsNXROi6YCaPsjOjn8Lk8PJRdPZO31Ur8Ghzjam+6kzwtIEsBKQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB8892.eurprd07.prod.outlook.com (2603:10a6:102:24b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 06:14:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 06:14:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Jason Wang <jasowang@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBU5r5oNBkqzVUqCcHjZN6/EL7LVkrqAgAAsh4A=
Date: Wed, 4 Dec 2024 06:14:10 +0000
Message-ID: <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
In-Reply-To: <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB8892:EE_
x-ms-office365-filtering-correlation-id: 5cdcb37e-6c3c-4968-b4cf-08dd142ade07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UTd3eHJqNGZrQlFLSzBEYk1JdXJFcitCa21IOXo5T01yalkzY0prQ25IMWdH?=
 =?utf-8?B?TTRNMEV0R0NISGI3M3BGM0wzMExTcGxOaWlnZDhieUlvWXVIckRCcUVwYnM1?=
 =?utf-8?B?QXZXZ21DZDJJTStiajFXZEFvVGw5ZUdIWTZjTVJLd1NxOTBobXRSTmxCM2JV?=
 =?utf-8?B?alB2OE8yTUd3S1RSaHc4VFR4bWVhRklpSEtqUFh1aU1pRVNXT0J6eTdITVpX?=
 =?utf-8?B?NHV5dE1MZDBkMTVCbkJLTHNCY0I3b2JMWm5qZm5mUVNDL1lLd3p4ektLcTND?=
 =?utf-8?B?cWhxR1NkZWhRVXNEV0xpYnRBK2wxdzUrcklUdUVoNk9sR2RXRUVuSHhMa2dZ?=
 =?utf-8?B?VUVOS0YrblpmOEhYTS9Pa09qRDl1Rm1PTnAvVHFqZWx3VlhUV29CbXJZMDVN?=
 =?utf-8?B?b2RwOXJEL1M3N2NaVVZNSGJSNTkzNUdNU3hDTmNCa1MyVUk1M1BJUEsrdU96?=
 =?utf-8?B?THdRenRVZTR3Y3lnaTlmNUc4WXdsV0RGTUNCQmJRREprV2dkeUxpL3BhMUJ3?=
 =?utf-8?B?WlRFVnhBWGE4MDFneFlKajJ2dnd4aFBuR3krQUs0enplZm4xV3pvNGtHU0lR?=
 =?utf-8?B?MkVMZWpUdE40RWgzUC8yZnhyTGkvTnNVTjUzUmduNSt0Mnpwd1FLMGkzZkNa?=
 =?utf-8?B?eE45RzN4VWUyS1FIMGZCTm9yOWdlUzJOTk16Zm0yaWRESVhoTW5kNmpmRVJ2?=
 =?utf-8?B?SkJyalpKdUtya00xOENiVllQK2dSeUxRZW5qNUJkdjIzU2FDNzdCWForaXVD?=
 =?utf-8?B?bjVEVHJFQWR3REI2RWJwcHhERS9IejlJcFR5Y1FyQjFROW5CMlFCZkloZFZC?=
 =?utf-8?B?T2JpSkV0dytuY2dvb1dENUlzR2ZFM2g3RzlmSzVQdjZsc3liTFV1eTk1YWp3?=
 =?utf-8?B?QUZFYm03VWZkQTR5VElaZnlXNUI4WmVTMUpUMjlZZ0NjeHU5S04yUkpwb0xs?=
 =?utf-8?B?eGFrT0d0Snl6cjN2VEJqNEtkY1RhVDdQeDgyMGNvY2pjVnUzdUlWa2w4OFZS?=
 =?utf-8?B?VnIxUUFlSzlKKy9nR1draXZsVFBrUWJXRHlaRVVnTjA2SGJPTElvMjR6Z3lO?=
 =?utf-8?B?b1JxRHRZOVVwNjBQOVNVN2I2Zm53cEUxMk9TL1YrZ0NEK0pEK3RnSjhIcVVm?=
 =?utf-8?B?Z3JYNFlLSjhLYkV0VXRYaU1QcnloWlhUWE9yTnhzRDRRNGh5L2hmQmhkWVhY?=
 =?utf-8?B?Z3VCWSt3K0tmVFVyVTE0WncvRld1cWtGb3hRVGJSOGlNYzRlNjN2Skh6S3o3?=
 =?utf-8?B?bG1Ldm8vRDJ3RzFCc1N5WGsxbm0zbC8wc2MxVE9RRDlQRGdPRnovVEQvUnlK?=
 =?utf-8?B?V0VadUdrTHdhcXY1amo3QU9naXcwRFlUTUdoRkk0MEQ3TVIrVE5URVN3am5S?=
 =?utf-8?B?TWtjVzh0U1lIY3luUkswdURtYXJtdVFmbmdCcFJ6WlI3V1hOcFJIcURyVDN4?=
 =?utf-8?B?MDY4NGVZSEoyUXh2cFRYdjVjRE5kYk9TamdvYy8rc0JGckJkSllzUVhFWXpv?=
 =?utf-8?B?cW05Mzk4M2xkU3dOSzVkM2NFMTVRcnlodG5NbEJZM1JkbVVVU1gydG5pcUZR?=
 =?utf-8?B?ZkxVMVp3Y09ML0lKaHBLOGRrV21IQnh5MGwrUW5mN0N4K3I3ZXphNG9nQzh2?=
 =?utf-8?B?OG5PeHdXVW5wdWtrY3ZFcXlEeTAraVRIYUdVMU5YL0VEMjZpVW1JVWlmdktE?=
 =?utf-8?B?M1R5VlFDOWdjMmhORU4xMUxNTzM2Mkx1c2d4TFBxS2F6VmlTc1E4bmhjMnJp?=
 =?utf-8?B?UjcxSmFJWklxenpISmk1eWkxczkxOExVOHlRQkdHY2dWL2Nzd21QWmcwbEM1?=
 =?utf-8?B?UitMVzFqODdrcURVQ1kyNERCRTN6YXJDR1lFOVNwdmszNmJjeThndFRvN09C?=
 =?utf-8?B?bk13REJMNDVIVDJFdTBNK1JCREFwYkdiNGJFMGo5NXNId2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUFReFd0TVJhWE9Ma2lIOTluME9uaGhxY3Z3N3BOZlVYbVZCRzUrOERSdm5w?=
 =?utf-8?B?bDIwNmtWL3c3bzNCYWg1RTZYNEFxQlVQN1pQcnVJUG5tWEdoWUMxNXkvTEll?=
 =?utf-8?B?aUtoRkFncjgvZDdlVDlaMEV4Q0grMGhDRnN5VDRVcURJYnY1Z09XOVlHWi9i?=
 =?utf-8?B?WHEyUklzL1BrWFNBalcyMGg0djRXejB0WGlUS0sraEp6TnBOMllyZnptNDd1?=
 =?utf-8?B?U0ZqbTRpK2hpclFFQUQvMWJhOGdVeXdzd1RvV3JuYm5iZXlhUEl6OFA0VnJH?=
 =?utf-8?B?UGRHNmhKWkNlRjBLQXNIdTlJc2YvRUdVSHE5cjBqNFFJOVM4anBkalJUTTMy?=
 =?utf-8?B?U2N5Q2h4MmY3M1pLQU43TlFlMnlneEl1MEhjcWJxYTErLzBPazBJNUJMNWVX?=
 =?utf-8?B?bHZEclhnZ09KSEsyUnRtLzF2YVNKemhMYW82c3d1aVFReDd2ODk5dTZscFd4?=
 =?utf-8?B?Vy8xWE9oZTkzUVcyYjBLSU9KNkJsYURRMGtlQlVZeTU1bkdMTHErWGlXNmtK?=
 =?utf-8?B?Vm5zbXVQZ3I4dUw2UWIwaGxIazNjZnMzZ3J0Rjd5aWNRUWxUVjA4OE5BeWRC?=
 =?utf-8?B?cVlFR2FsK2MxSnplUm1sV3YzSlg4YmhSQzA0emVhb2czYkY4NVdGbVlXNU9U?=
 =?utf-8?B?M3NVQUFiazExcldXRjBQZXNWaC82V0RrUFl0RnVOSE1hZCtGbmhuWWZlOG03?=
 =?utf-8?B?WTJxYXYvMEZ3WTcyU1hTN1Q3bDUvcWNpTk5QU3o1WkRSRk5RbDJwTGUzMThY?=
 =?utf-8?B?MTZnVEtiY1J1ZHpqZDkxaVZQT2RtZzZLcjMwQzZUWk9SKzdUMmhJbVBDNDhs?=
 =?utf-8?B?dCtoYjBzSDVxM1l6bE5tMWprOTdBcVcyZzJLWG10SUFaMmphUTdybVVOTXJM?=
 =?utf-8?B?NllwYWxWL201Szc1eWpWdEpEeHlSdjk5RHpzVVloK0tRVjdIQmkzR3VvM0tF?=
 =?utf-8?B?WUlzVlE0YVg3WENMcFIvd29nK05NSC9jZkkxVmhWTmh2YnFpSThBOEY5cUVN?=
 =?utf-8?B?eFFvSTVrZVM3aGFuS25Ra2tESnk1bWx4dGdoZDNmSTFhR0lYVFBBNnZka1Zz?=
 =?utf-8?B?M2g2MDhueHA5eHVlcmt3S2E0RmU0Y2o4T0hiTGp1TnFvWWFRVEo4Z2VtNlZI?=
 =?utf-8?B?aG9WeFhYWVlmVkRBaWJZK0tHKzh4MlZjOS9RN2xaYzhVbHBGMzdQNEtSOXV2?=
 =?utf-8?B?Ky9abG9xQlhoNWNMQWFpRUhNVEJlcGhxWS9EZTFVMGFVNzVFZ3JUaGZHajdT?=
 =?utf-8?B?VVpUT05xNkRIeFp3NVg4Y2ZSaU9rYnVyc3laUXk3cWhrMlA3N09WSnpIaSs0?=
 =?utf-8?B?VzVPYUJjQnNISFJ3RG44TFRQVGllSUtpUG8zQzdRZlRhbmZRQzlzMFE4THdD?=
 =?utf-8?B?MzUxeWFDUXhOcS8ycU4wRXhWd1J2SlI5VG15L0IwUjBwOXdCSmdaRDJ6S0Rs?=
 =?utf-8?B?bmNqeHJ5b21OL0traVIwVWZXbGZYWlJ5S0JZRXVNUHJBR1VCaDBuMytjbzdw?=
 =?utf-8?B?OXRxK3kwYUhnSmFsT0JndTB2TVFMK0dDVnc4MGQ0VmNhMEVVNFlNOW9zUXJj?=
 =?utf-8?B?NTRGMnhLdzNNRVZtSlJrMHQ0dWN2Vm5mUURncHZIME9teVVOa3ZKZnk5dzJI?=
 =?utf-8?B?dEV3QU5TYjdybHFqT3pFWEtLOXdnQUl6ZU9xZ3c0N3djY2VvbWJmRDBoYzZx?=
 =?utf-8?B?Y0N2OG5xSGxnSS9PMEVGelUvcmVGbjBJTW5PNHlnbEdNUlJQU3JEOGdkTEVJ?=
 =?utf-8?B?c0dNQllQN2w5bXZDMW5oVTB5TFBWR2lSbDU1M0dGUVBmUFE3cHBRNG9Pbytn?=
 =?utf-8?B?RWliMmViMkZYWmpkVzZQQmsrc2oxQzdCZ2Q2TWR5VDJkcTdZMTEyWXN6UVNU?=
 =?utf-8?B?b1VXa3h5TTNCSG9JQnVOU0VnVDlvT3N3c2gydm9oK09qeHNUOTBMRkV3VGN3?=
 =?utf-8?B?K2tzbWtZUzlRSXZzQklGUzJNUjFWWkM3a3dZVE5KeGVpL0wxRU1sbjlDQkZT?=
 =?utf-8?B?RGNlVGlsMWhSZVlVVTZibm5NZGoxZENMTURQV01nekdZTXVlRXZqRmdMallW?=
 =?utf-8?B?bEZVcng4R3RhV0lNaWh6bWYvRkxrKzdScXQrYU9GSzdxcVU5WnBGRVlDOHVt?=
 =?utf-8?B?UmpqYmtoZkVzd1l5RHZHd01GTHVoeXhpUFNXTDhIUFJ0QVJ6VkJiUGduU1FM?=
 =?utf-8?Q?IWFQxwNuVUxHC736UigZWBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AE86D3D05369C45BC61340C8A571961@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdcb37e-6c3c-4968-b4cf-08dd142ade07
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 06:14:10.2293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erfPxozqSRFNffPTdaQdeRJi90CpLtzs1PohnaOOwQAouax8C/vFRskJcAPM9VitbbwyPo3KKzRX/E7l3xBh8kSVL4xy0TGBRqUJGKIij9WRuVkw9r54IrFXGkDVn9mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8892
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCk9uIDA0LzEyLzIwMjQgMDQ6MzQsIEphc29uIFdhbmcgd3JvdGU6DQo+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBNb24sIE5vdiAxMSwgMjAyNCBhdCA0OjM5
4oCvUE0gWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+
Pg0KPj4gSW50ZWwgVlQtZCAzLjAgaW50cm9kdWNlcyBzY2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFz
IGEgYnVuY2ggb2YgY2FwYWJpbGl0aWVzDQo+PiByZWxhdGVkIHRvIHNjYWxhYmxlIG1vZGUgdHJh
bnNsYXRpb24sIHRodXMgdGhlcmUgYXJlIG11bHRpcGxlIGNvbWJpbmF0aW9ucy4NCj4+DQo+PiBU
aGlzIHZJT01NVSBpbXBsZW1lbnRhdGlvbiB3YW50cyB0byBzaW1wbGlmeSBpdCB3aXRoIGEgbmV3
IHByb3BlcnR5ICJ4LWZsdHMiLg0KPj4gV2hlbiBlbmFibGVkIGluIHNjYWxhYmxlIG1vZGUsIGZp
cnN0IHN0YWdlIHRyYW5zbGF0aW9uIGFsc28ga25vd24gYXMgc2NhbGFibGUNCj4+IG1vZGVybiBt
b2RlIGlzIHN1cHBvcnRlZC4gV2hlbiBlbmFibGVkIGluIGxlZ2FjeSBtb2RlLCB0aHJvdyBvdXQg
ZXJyb3IuDQo+Pg0KPj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBleHBvc2VkIHRvIHVzZXIs
IGFsc28gYWNjdXJhdGUgdGhlIHBhc2lkIGVudHJ5DQo+PiBjaGVjayBpbiB2dGRfcGVfdHlwZV9j
aGVjaygpLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4g
LS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+PiAgIGh3
L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IDJjOTc3YWE3ZGEuLmU4
YjIxMWU4YjAgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTE5NSw2ICsx
OTUsNyBAQA0KPj4gICAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8
PCA0MCkNCj4+ICAgI2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwg
NDMpDQo+PiAgICNkZWZpbmUgVlREX0VDQVBfU0xUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ2
KQ0KPj4gKyNkZWZpbmUgVlREX0VDQVBfRkxUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ3KQ0K
Pj4NCj4+ICAgLyogQ0FQX1JFRyAqLw0KPj4gICAvKiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+
PiBAQCAtMjExLDYgKzIxMiw3IEBADQo+PiAgICNkZWZpbmUgVlREX0NBUF9TTExQUyAgICAgICAg
ICAgICAgICgoMVVMTCA8PCAzNCkgfCAoMVVMTCA8PCAzNSkpDQo+PiAgICNkZWZpbmUgVlREX0NB
UF9EUkFJTl9XUklURSAgICAgICAgICgxVUxMIDw8IDU0KQ0KPj4gICAjZGVmaW5lIFZURF9DQVBf
RFJBSU5fUkVBRCAgICAgICAgICAoMVVMTCA8PCA1NSkNCj4+ICsjZGVmaW5lIFZURF9DQVBfRlMx
R1AgICAgICAgICAgICAgICAoMVVMTCA8PCA1NikNCj4+ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlO
ICAgICAgICAgICAgICAgKFZURF9DQVBfRFJBSU5fUkVBRCB8IFZURF9DQVBfRFJBSU5fV1JJVEUp
DQo+PiAgICNkZWZpbmUgVlREX0NBUF9DTSAgICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQo+
PiAgICNkZWZpbmUgVlREX1BBU0lEX0lEX1NISUZUICAgICAgICAgIDIwDQo+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRl
eCBiOTIxNzkzYzNhLi5hN2E4MWFlYmVlIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC04MDMsMTYgKzgw
MywxOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgdnRkX2lzX2ZsX2xldmVsX3N1cHBvcnRlZChJbnRl
bElPTU1VU3RhdGUgKnMsIHVpbnQzMl90IGxldmVsKQ0KPj4gICB9DQo+Pg0KPj4gICAvKiBSZXR1
cm4gdHJ1ZSBpZiBjaGVjayBwYXNzZWQsIG90aGVyd2lzZSBmYWxzZSAqLw0KPj4gLXN0YXRpYyBp
bmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRlICp4ODZfaW9tbXUsDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBl
KQ0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhJbnRlbElPTU1VU3Rh
dGUgKnMsIFZURFBBU0lERW50cnkgKnBlKQ0KPj4gICB7DQo+PiAgICAgICBzd2l0Y2ggKFZURF9Q
RV9HRVRfVFlQRShwZSkpIHsNCj4+IC0gICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0K
Pj4gLSAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAtICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X1BUOg0KPj4gLSAgICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRfc3VwcG9ydGVkOw0KPj4gICAg
ICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMt
PmVjYXAgJiBWVERfRUNBUF9GTFRTKTsNCj4+ICsgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllf
U0xUOg0KPj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRTKTsNCj4+
ICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+ICsgICAgICAgIC8qIE5v
dCBzdXBwb3J0IE5FU1RFRCBwYWdlIHRhYmxlIHR5cGUgeWV0ICovDQo+PiArICAgICAgICByZXR1
cm4gZmFsc2U7DQo+PiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BUOg0KPj4gKyAgICAg
ICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9QVCk7DQo+PiAgICAgICBkZWZhdWx0Og0K
Pj4gICAgICAgICAgIC8qIFVua25vd24gdHlwZSAqLw0KPj4gICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+IEBAIC04NjEsNyArODYzLDYgQEAgc3RhdGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lk
X2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAgdWludDhfdCBwZ3R0Ow0K
Pj4gICAgICAgdWludDMyX3QgaW5kZXg7DQo+PiAgICAgICBkbWFfYWRkcl90IGVudHJ5X3NpemU7
DQo+PiAtICAgIFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7
DQo+Pg0KPj4gICAgICAgaW5kZXggPSBWVERfUEFTSURfVEFCTEVfSU5ERVgocGFzaWQpOw0KPj4g
ICAgICAgZW50cnlfc2l6ZSA9IFZURF9QQVNJRF9FTlRSWV9TSVpFOw0KPj4gQEAgLTg3NSw3ICs4
NzYsNyBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElP
TU1VU3RhdGUgKnMsDQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgLyogRG8gdHJhbnNsYXRpb24g
dHlwZSBjaGVjayAqLw0KPj4gLSAgICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHg4Nl9pb21tdSwg
cGUpKSB7DQo+PiArICAgIGlmICghdnRkX3BlX3R5cGVfY2hlY2socywgcGUpKSB7DQo+PiAgICAg
ICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WOw0KPj4gICAgICAgfQ0K
Pj4NCj4+IEBAIC0zODI3LDYgKzM4MjgsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3BlcnRp
ZXNbXSA9IHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FERFJFU1NfV0lE
VEgpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01N
VVN0YXRlLCBjYWNoaW5nX21vZGUsIEZBTFNFKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0wo
Ingtc2NhbGFibGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVfbW9kZSwgRkFMU0Up
LA0KPj4gKyAgICBERUZJTkVfUFJPUF9CT09MKCJ4LWZsdHMiLCBJbnRlbElPTU1VU3RhdGUsIHNj
YWxhYmxlX21vZGVybiwgRkFMU0UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgic25vb3At
Y29udHJvbCIsIEludGVsSU9NTVVTdGF0ZSwgc25vb3BfY29udHJvbCwgZmFsc2UpLA0KPj4gICAg
ICAgREVGSU5FX1BST1BfQk9PTCgieC1wYXNpZC1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBwYXNp
ZCwgZmFsc2UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJ
T01NVVN0YXRlLCBkbWFfZHJhaW4sIHRydWUpLA0KPj4gQEAgLTQ1NTgsNyArNDU2MCwxMCBAQCBz
dGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPj4gICAgICAgfQ0K
Pj4NCj4+ICAgICAgIC8qIFRPRE86IHJlYWQgY2FwL2VjYXAgZnJvbSBob3N0IHRvIGRlY2lkZSB3
aGljaCBjYXAgdG8gYmUgZXhwb3NlZC4gKi8NCj4+IC0gICAgaWYgKHMtPnNjYWxhYmxlX21vZGUp
IHsNCj4+ICsgICAgaWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgcy0+ZWNh
cCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfRkxUUzsNCj4+ICsgICAgICAgIHMtPmNhcCB8
PSBWVERfQ0FQX0ZTMUdQOw0KPj4gKyAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsN
Cj4+ICAgICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBW
VERfRUNBUF9TTFRTOw0KPj4gICAgICAgfQ0KPj4NCj4+IEBAIC00NzM3LDYgKzQ3NDIsMTEgQEAg
c3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAq
KmVycnApDQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4NCj4+ICsgICAgaWYgKCFzLT5z
Y2FsYWJsZV9tb2RlICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgZXJyb3Jf
c2V0ZyhlcnJwLCAiTGVnYWN5IG1vZGU6IG5vdCBzdXBwb3J0IHgtZmx0cz1vbiIpOw0KPiANCj4g
VGhpcyBzZWVtcyB0byBiZSB3aXJlZCwgc2hvdWxkIHdlIHNheSAic2NhbGFibGUgbW9kZSBpcyBu
ZWVkZWQgZm9yDQo+IHNjYWxhYmxlIG1vZGVybiBtb2RlIj8NCg0KSGkgSmFzb24sDQoNCldlIGFn
cmVlZCB0byB1c2UgdGhlIGZvbGxvd2luZyBzZW50ZW5jZTogIngtZmx0cyBpcyBvbmx5IGF2YWls
YWJsZSBpbiANCnNjYWxhYmxlIG1vZGUiDQoNCkRvZXMgaXQgbG9vayBnb290IHRvIHlvdT8NCg0K
VGhhbmtzDQpjbWQNCg0KPiANCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4gJiYgcy0+YXdfYml0cyAhPSBW
VERfSE9TVF9BV18zOUJJVCAmJg0KPj4gICAgICAgICAgIHMtPmF3X2JpdHMgIT0gVlREX0hPU1Rf
QVdfNDhCSVQpIHsNCj4+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICIlcyBtb2RlOiBzdXBw
b3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTogJWQsICVkIiwNCj4+IC0tDQo+PiAyLjM0LjEN
Cj4+DQo+IA0KPiBUaGFua3MNCj4gDQo=

