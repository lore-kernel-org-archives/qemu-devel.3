Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A4AC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRb-0007y7-Br; Tue, 02 Jul 2024 01:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRZ-0007wF-Ho
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:45 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRW-0006W6-VD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899564; x=1751435564;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gndVGnQ0yhI7Q6zNslmfKh73Db8IPGJBxr+71XFsimc=;
 b=flHO/P4GhcdGYbrDtgII5OxTIjMlxP1lm4/Zn8NExTWu3k/f9gDbwcSv
 FKBQJM0nn25nwhZDt3/rIPpaSZVaAdgaNvFueHpAIVuGYUhUB/39O+Gn5
 EQXAXEmydioAt7MvUrs4mLTCyppasvgDsVcNWWTYUHoFI2IIlnzE/Uo5q
 dofCIv8WNmvxhQs94W8+/rSgJvFoxksoiNTmGBCFQRyKgp1GudQO7plfz
 EhqHW2JBnHLPr7uQ4g/x18OLVvN2zl9HJ2zjOIWlZ07z3uWOGb1nDgLyp
 flPUT7AijTXNwlOc64lC81KN0oJMEw8UCd3A5aE+3LqiCMSs+yGLTspZH w==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15715677"
X-MGA-submission: =?us-ascii?q?MDHup0X8tWdU1qT9C+wqgxCh8K+jzmetLyw+LI?=
 =?us-ascii?q?iuawvrTde+WxcMDv1367XYaB70knAaUiyMAnMCKZC6CYDiNkimt7ru9x?=
 =?us-ascii?q?oPtaVjB5Duyw6Ol2cCsnaZfjYFqMr0P2VLTOgzBAP1Jy6juyiW1lGje9?=
 =?us-ascii?q?Mhx8XPeN/zsiLtlMWCqHZNzA=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asq0WtvkEMsA/989SPjszR68rB0COqx+26HVQkUvAzq33A+3785G7BaRqPppCZJKex9T9tWluAT+U0thgMFBYUo47AHanhTHf0DO+cCC8J22HNH/QCXqcJg4QVpE2hzD0qlt1fbm8z3PsHLEOqwonKKLoO2wOEU/IQpImm00R0izhJrAVXG7SOWJ3b5h8OWbwUYYYJjJN/X8P4VDE2ijjAzZuN4PwvmKQ/5VXI+n2W+HjpkUUf8W/frqenJwfa3ZomTpiNv8qNcPO0jIcEVyOCRSkTbTQye5tvczkuehlExFvBTvl7KPOqSjdGxFWpEH5rwAEsv27gKy6WJVrp36Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gndVGnQ0yhI7Q6zNslmfKh73Db8IPGJBxr+71XFsimc=;
 b=asaXQYDa+NXMZ0W/0sXxKkWdB0c+Eu7HVHtyDc1MBFmYk8iDlgkKE/tvw4EL18xEZt/OSqEfsK1w8YkqOTrMsYuiX3SVCnYnJco7+PWHmJ9xWqu/pzWaILy8NMsEVOV2Ryeb5atDZp/TzZneTdKzKh0nM+z9+7uIekabEpIb4bGzBJuACwjO9yOFB5qfl7qB72n+mxqLRKhK3AoJrdXQtKeYY51Jt95pUFWjKkfWVpqfGtwSihehQiLoHCUjc6C29OTqUbIOFN1qm3AX8KQCevbRoOHM+qQBQzgVdSrXN2IddIdgnH7XnlvmdG6G3Vay35FUw4hxJShZCjLlUrGYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gndVGnQ0yhI7Q6zNslmfKh73Db8IPGJBxr+71XFsimc=;
 b=PB3FrS0BmEcsvNKZbYb9rsl/YhOlqUQ8ZilsSqnrjqlLrP2+fK8WfPmy0yJLN0jLOrkU/hBqeN3BTdv9w8oLw8pmcgK0ZdiSQouBEq4XCbNFS5vSOIUAVqGgV80HmQfiAjlmbTCFlZOQ5rpPEgiLpf/iBADegYBk8d77XXKz3sJ1E+17hyY3A6UJbKefgHZiRH2IYCS4qE7dvWSL7ZE7eb6M9BYTaidSU1bE3PNWcyHQixmkqVCPUTXQFdxyOI1AnbOmfPZE6NjZCJSBxt/rs7H15306F4TdPk8zoKGosurehjNDH8acGr5y9gInnIgcvQC53iBSIKS9m0Jk0bZPog==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 13/22] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v5 13/22] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Index: AQHazEQMtbnEG0JMpEOyFP0rSHT39A==
Date: Tue, 2 Jul 2024 05:52:40 +0000
Message-ID: <20240702055221.1337035-14-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 4fb6b0d6-efec-4c19-8692-08dc9a5b2f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1dEa0l1SFZpaW9vLzFuSS9Eem9JUEU1blZQQjlpc2dzR3R5ekpOYkoxUURq?=
 =?utf-8?B?SzhUVWN3dy9NWnZScXFXYlE5TWRpQ1M5eWlJVitreTc0YmZFVzZiUVRrMHEr?=
 =?utf-8?B?b0Jna2dBZWN1L0ZnQzN5VjV4TnV6MHQ5WTdEdHU2Y0NyZzdJc2g4RTdTVThy?=
 =?utf-8?B?OXJheDZ1ME0rdnJ4enpRNjA1ai8vUnVHaEU4S2RHTUxKWHlyeG5PYWJyaGow?=
 =?utf-8?B?WE41RCsxRTc2MFp4S3ZQTW1LT1Zibmk2NlFSclJ2eFpWblRUaHptTnhpSzU0?=
 =?utf-8?B?TGN6aWI1NzRKc1dXUWo4c2RRWjR3WFdqd0NXNW45MC9ZRmFrS1lRWjc1VGVv?=
 =?utf-8?B?aGJzemE1WVhxZk14TDJEK2dSZUs4VFJRN3RNT3BuWTJrenZZM1FnRGRMNVBG?=
 =?utf-8?B?d1JsN2MzUms0TFREclBuUzFEYzF3RmIzdFRlSUZzS1Z0SHFMYjJlRkxlZjZs?=
 =?utf-8?B?YTlPUW8zZVhucUxJaUxvakVDUDBTVS9ld0xxSHgwZFNrQ2VpZ0w4RDlvcHhT?=
 =?utf-8?B?ZVZKVDVEWi9wSHpxSElXVnByd3BWQkF6N2FWQkgyS1gyTUFORWlBaHFBeDhG?=
 =?utf-8?B?Z2JSeTJNYnM5STVIMVpkSEZvV3FwUDM4MnAyWnNaVE9FREh3YW9GUWp0aDJ0?=
 =?utf-8?B?bENXS2hiV3hFQmhUWTNlZ1JYck1LTnFxUUxVOThGNFRFcE01bWxzVGZXalcy?=
 =?utf-8?B?d1JoNjFGeTV1MmlHRHpMa2JDSFVyeUI5RUpabnhBYXhkVkEzcWNkbWlzSzV4?=
 =?utf-8?B?UExscm5YVkNRdDZLQ1Zsb2ZSakNrb2wvVU43RFdaZXRPL0JxU0RqdTZtM29V?=
 =?utf-8?B?amREM0haL0pjSWtkNlhNajF4ZTRjcUxtZTlybENBaU80THoxR2N4WGZpaFBI?=
 =?utf-8?B?MkM4UzFSVk1JcFpMZG1Hc1R0Y3JRQjJ2RkZkRWJGWTYvQ0h5TEllZzcxQjk1?=
 =?utf-8?B?NDNoVUdkTEpsRHhIMnNsditUcmRtZHdlQ0l3VXkzcEUrZU44NHNZbVpSeGtZ?=
 =?utf-8?B?WkRBL21rbEh3eHlZUUx1RHVhYlNNbmFoT1ltVG0rcUpUcnN4dG9LWmdHOXJJ?=
 =?utf-8?B?UERZWW9QMnhZdzlsamh1SDYwVFNhcXprNkZnM2t6OEZsVWE5Mm1EODJ6MGEz?=
 =?utf-8?B?Yzc1WDkvd2NSeGRwaEdqVGQ1TVlUV3ZmYWxXWU1BRmlmK1hFUVhNT3c1ZTVT?=
 =?utf-8?B?b0YzcDVNRGViZFVCc0llOEl5V0ZIcU54SHZudDIvUFNTbW94ZEQrMzY0eVpG?=
 =?utf-8?B?eHAyTlRNaU1Kck5PWjUvUmwrRmwzT0F5NXU5T0RuZ0kzUVlaSXY2SG1VZ2x4?=
 =?utf-8?B?emw5eFJNZlJML3M0TEF4alNHR01wTXhVT0U4L0NDRTZjV05wazg0UDZnTFdG?=
 =?utf-8?B?RS9SUHppU1l0QkVrYlUyQlBOSmloTmdZUy8xVk1pcS96bGVGMUJoS2ZnVHlP?=
 =?utf-8?B?eENPbHgwK0o3dUc5QkllZk4wYUFCVVc5Yi9ya29EZWRwV0F4Kzhud3dvdGRS?=
 =?utf-8?B?c3JDTTFGWG5Hb2NtQmhKQ0RYMHgrUm9EZHIwZUFkaGZja1d5YlpqUzhsSU5R?=
 =?utf-8?B?MTROZVBSRnh6b2cwNHlkNVdib2d3a1BpbVJ6dkUvUHBrMTNpL3BkU2lLdHli?=
 =?utf-8?B?OFgyN1FjeHh2ZkdJSGV1cGpvOE1EOEliUUloMHpTVHh4S29NTDFqUFRXblRK?=
 =?utf-8?B?T0MvSmlRaVQwb0dFcmFwMUtvalVrUkR1dVpadjVkQVdGSVJNN3NtWS9CN3F6?=
 =?utf-8?B?czBseHFoK0syTU4rZ3dZZUtFRzJHckVxY2lEOC95cDV2NlR6QlkwZmcrcFRN?=
 =?utf-8?B?ZlYzQ3dkUWJnbE55ditNVDNmN1NqdW96TlFmRENJdnlrWjE3aC9zaFlIbEVs?=
 =?utf-8?B?dG9LN2xYVGlJTVZFTXk3RDNDdStlc3FkU1RHN3UyeUxYdnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M203ZXpUWXJyaEJ2M0U5bmpUbzFwaUk0UE1YdkM1VTFMeDRRYkpnUUhtbUNw?=
 =?utf-8?B?QzgzVVNzWlBuU3IxbXd1WVdEMC9uT2JLUTFaNWdicG44ZDZhaGpIdXpPTm5F?=
 =?utf-8?B?cW9EUG1namMrUEZLWTloWjI5YzFGK01OQTRuUUVJczFCd2pjM2x6UWpTb09T?=
 =?utf-8?B?V1ZnR3BHcTVKLzVkdU8xSnVyYzV6a201MkxPQTNKZFRtVVplUzhSS1hxeFRk?=
 =?utf-8?B?VEZQQVNsVzlZTEw1Z1p1RS82dUJRSUZCaTZZNk1HZmZweXN6eGoyb3FUSlVF?=
 =?utf-8?B?bUJWaE83WmJ1dVdudUliUnAza3JVekkvb0Z6OEk2dGdzbHBSelU3Z2krNzZv?=
 =?utf-8?B?L2RJMkJjN1IyOVJ0VUp0OUJlMkRwU0V6TFNHYVZnRUdycG5iVldSc1FNMFV1?=
 =?utf-8?B?SFphYm5DWU43YVlJREljTmtWOGJZUnNSaUZPSEoxdGI1eVd5bHFYZHR4SWRi?=
 =?utf-8?B?RktLcnYzWHhjU1Y4NzVMZ21FZG8vSmR5WVE0dUQzSDQ0RmlKWjVMK29OMnhj?=
 =?utf-8?B?bXhjcnVSTHR4a29zTERIcFBBSUJWVzJUUzRBL2RQU0oxZEhRZ291bUtnd0xJ?=
 =?utf-8?B?aGZzY1NTNmU1UEVNek4ycmVwd1NCWk1pd1VUMkJlQ1hqT0FPVW1RV2ZwV21G?=
 =?utf-8?B?YXlmbjMvOXBxZ1pLOHRoWE9wUmtJM2l3c2dHZmdPb1BuR0VDODhsa3Nmc291?=
 =?utf-8?B?R3E3OGY3dmIxR29xRkxFL3BmbkZXM0V1Vm9lMHg3QnUzMVh3Yms1bUhoS2di?=
 =?utf-8?B?S1BZdzBMakVGMTZIbjFmUURVb3JRUTJocGlJcWkwNVpCYUxMREhPNUtOamk5?=
 =?utf-8?B?WHEyblIxR1hDeksxZEVoOTlad0hrT2xKYzQ3Z3h5LzlneUtaSG93OWxPV0NR?=
 =?utf-8?B?T1hnZ2JSWGdsdVBjckluOWtGNUpwM3d0Q21zM0FZS0tuV3dtbm4xZXpNNVlm?=
 =?utf-8?B?WTlPYnZvUU9ybC9oOS9KZW5zT0FMSkdiK0UrWE5ETWxBTXk3dVE2Wk1KazI1?=
 =?utf-8?B?RGhMOGdTM3BkRnlxcW5zWHdyZEtrN3BXNUZRSmJ3a1BkMzFaTmp2a3pObjFG?=
 =?utf-8?B?alN6ek1MYzNPbW9SS1VvRXhyM0pyUVZ1OWNpQTg0VVNRK0txQkNDQ21seWls?=
 =?utf-8?B?eWpTLytVRXFxcEJ0dnFLekZqZmVOSVhTZVc1RlNja1haY1RIekdncVNISktO?=
 =?utf-8?B?c2NVaWZBQ1dUNzUxT1RJUjB6V1pNZGpORVFPbHJ2L1RaYW1TMVNpbThUdVR5?=
 =?utf-8?B?SWMvdXI2dlhmVWx3bG1VcW1XSFhyREdGa2V1Zm1aQmdxeWZmV2RQcTFMZDJV?=
 =?utf-8?B?ZTRVbURQU2hpN1Arbk5XNkxPUTJqbmppV1A2c1gxams0cyt0K2EvU1ZEMS8x?=
 =?utf-8?B?R1RHZHZoL1MrSGpOQW9nSXhJT2tmRTFpeU0wVEgrbUJTZStNQkc2ejVZejla?=
 =?utf-8?B?THdhdWF4MXFncVRRaGQvT1h0aG1IYVRkMmc0UFdseTZjaHBuOTJvNjNtWDVu?=
 =?utf-8?B?a2ZhdURjRGxiU3dMWm0xeFlNY1hLcFFSY0VOU0RrVExrc1dXenFRVEtheTNj?=
 =?utf-8?B?aHcyV01WVlYrKzdCbWpSak1uOW8xNlRBQmxvalZxdXI3YkFGY1M1U0RTU0FQ?=
 =?utf-8?B?Tk5ZS1daSnFxSjk5ejlidGo4bG1MSTNlYXNFay93Q1JUcnB5UWtpMmFmWmhj?=
 =?utf-8?B?Z0RLL2t2bjhQWVFIU3Jva0kzbCttRDZIN1ljVmF5WWpXclR0VjdMR2ZrbkYr?=
 =?utf-8?B?U0VTRGFmNE5UZXVBc1pMa2xNWTNETTIyaEE5M0llMldnd3NObC9nUmZWQjRx?=
 =?utf-8?B?MzlhNGtTNTFRcUx3RFNSdVN5OUx2akJ6ck1XU296aEVLYjVqRnBFVld3M0Rt?=
 =?utf-8?B?eXVQVHlwM3BoZDVrY1ZqZ01uSkRwOWFjWEE1NTFrVUhxR1FJWmdhTXBSRWZo?=
 =?utf-8?B?SDcwbnMzVTRaUmJVNjdxYXNIb0ZMd1F3aVhzUXpLWEZraHZpMExIeFVaV21a?=
 =?utf-8?B?L3llSUtqZVpGdzZ3ZS92TGhRcS9JeFM5Q1IzcjRhWWpoTW5rWHcwcEJveTAx?=
 =?utf-8?B?bVAzRWUvSmo2Zk5odjNkSVVkTTNxSGl6Z1VVdWEvSGt3NFdDK2RTNlN3M3Nq?=
 =?utf-8?B?ZGJrdjgrMk5HR1VBRFZERUtlMk1jMnJlYlJDZlNZdlFMZmY4VnArTkZFa0I0?=
 =?utf-8?Q?SrutrhulPcPNF5xPo5VPTAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CEE5A1D32E9BB4AA6BB177C4E8FD4B8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb6b0d6-efec-4c19-8692-08dc9a5b2f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:40.3276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQAyR47ixP0QIGn1Ki/ThVxipmk9RHFCSdv5JcapuyNroH0JdHNMFMWh9oQ5hcstDHVg/joDwx3PI68/IjPMV1IsvTgsUS0VbeZkYxeLqQgFzGgT00RnZbsU+Q1OvQqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgfCAxMyArKysrKysrKysrLS0tDQogaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
fCAgMiArLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KaW5kZXggMmE3OGZjODIzZi4uZTA0N2QyY2E4MyAxMDA2NDQNCi0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNTQzOCw3
ICs1NDM4LDcgQEAgc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyB2dGRfbWVtX2lyX2ZhdWx0
X29wcyA9IHsNCiB9Ow0KIA0KIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVs
SU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IGRldmZuLCB1bnNpZ25lZCBpbnQgcGFzaWQpDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCkNCiB7DQogICAgIC8qDQog
ICAgICAqIFdlIGNhbid0IHNpbXBseSB1c2Ugc2lkIGhlcmUgc2luY2UgdGhlIGJ1cyBudW1iZXIg
bWlnaHQgbm90IGJlDQpAQCAtNTk5NSwxOSArNTk5NSwyNiBAQCBzdGF0aWMgdm9pZCB2dGRfcmVz
ZXQoRGV2aWNlU3RhdGUgKmRldikNCiAgICAgdnRkX3JlZnJlc2hfcGFzaWRfYmluZChzKTsNCiB9
DQogDQotc3RhdGljIEFkZHJlc3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVz
LCB2b2lkICpvcGFxdWUsIGludCBkZXZmbikNCitzdGF0aWMgQWRkcmVzc1NwYWNlICp2dGRfaG9z
dF9kbWFfaW9tbXVfcGFzaWQoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBw
YXNpZCkNCiB7DQogICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCiAgICAgVlREQWRk
cmVzc1NwYWNlICp2dGRfYXM7DQogDQogICAgIGFzc2VydCgwIDw9IGRldmZuICYmIGRldmZuIDwg
UENJX0RFVkZOX01BWCk7DQogDQotICAgIHZ0ZF9hcyA9IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMs
IGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KKyAgICB2dGRfYXMgPSB2dGRfZmluZF9hZGRfYXMocywg
YnVzLCBkZXZmbiwgcGFzaWQpOw0KICAgICByZXR1cm4gJnZ0ZF9hcy0+YXM7DQogfQ0KIA0KK3N0
YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21tdShQQ0lCdXMgKmJ1cywgdm9pZCAq
b3BhcXVlLCBpbnQgZGV2Zm4pDQorew0KKyAgICByZXR1cm4gdnRkX2hvc3RfZG1hX2lvbW11X3Bh
c2lkKGJ1cywgb3BhcXVlLCBkZXZmbiwgUENJX05PX1BBU0lEKTsNCit9DQorDQogc3RhdGljIFBD
SUlPTU1VT3BzIHZ0ZF9pb21tdV9vcHMgPSB7DQogICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0
ZF9ob3N0X2RtYV9pb21tdSwNCisgICAgLmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkID0gdnRkX2hv
c3RfZG1hX2lvbW11X3Bhc2lkLA0KICAgICAuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfc2V0
X2lvbW11X2RldmljZSwNCiAgICAgLnVuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfdW5zZXRf
aW9tbXVfZGV2aWNlLA0KIH07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KaW5kZXggYjMyZDcxMTgwMi4u
ZTMzNGEzZGU2ZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQor
KysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KQEAgLTMyNSw2ICszMjUsNiBAQCBz
dHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCiAgKiBjcmVhdGUgYSBuZXcgb25lIGlmIG5vbmUgZXhp
c3RzDQogICovDQogVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0
YXRlICpzLCBQQ0lCdXMgKmJ1cywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZGV2Zm4sIHVuc2lnbmVkIGludCBwYXNpZCk7DQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCk7DQogDQogI2VuZGlmDQotLSANCjIu
NDUuMg==

