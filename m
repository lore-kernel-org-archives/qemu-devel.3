Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01258C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBoM-0002zw-Gs; Tue, 09 Jul 2024 10:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBoC-0002K8-UR
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:27:08 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBoA-0002u1-M7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720535226; x=1752071226;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=x+c8mBRVwCY1iaiqyl6IK8OOj2l2sKPVp1tM8KW2IBQ=;
 b=isd9IT997CircDS4Sf9nLGlhdLMPQUErwopdPh9UVwq1D2SHu2xJA7+l
 6h0QZn3kcVz6E+TpE/JN3tE8ms2seO2U1b0tbrTIjdyAmRnDBzjBDZMJs
 IENTbo4yJnLFmyMZvcnUYMYc6abV8E/+hU0cXgWII0ACbhFFxf8nmdbhd
 YPqSj6dk5p1h5QRVC5TSYuGe0D5P9M42aTutd85+kWowL5Yyx3jICM3Cc
 CP/Boprq5PR/He/tg9NdSc9h+zrX3FIZmhm3f6Inp4gVas0U4WsqyNjqs
 8DMMdNRruN5mYTD8t/hvefLdfyHmrhBOkcq+RsejiXnYmGjZ5KmsypA5I A==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172728"
X-MGA-submission: =?us-ascii?q?MDFeCSf6Tq7MpPdUKmvpBS5Mhtb/Wdrj6kIiZE?=
 =?us-ascii?q?I/zrvfppFDoEs/fHuBiusi5jqzvpK2gGeIaXQ9L/3SSjpC+Ov2PxiqKM?=
 =?us-ascii?q?4o8xNZQHVLoIz5+38FaQT6raRepeYEe0ZRfuxRYOo1oxlFq8PUdDF9KU?=
 =?us-ascii?q?5BbW5B1mNy0I4oWBWRv2A+3Q=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:27:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVYBCpxWUvbgk07yDy1Y97JiGRtk68F1IRxb5HKv/2D1xR39HjWXpilqpGM9Ld/99Q+QxUTcvVaVxHLzv/qLnrFktU2elvAF3MXAlStBgE8xrK8mamLTD/vX4uj934E4WHyj9xnC6JbwdJY3Seo6uKwBGrPKVLY/e+cTD8q1SD8cN4PHTpZ3oYl8TdFsgA5aEDR6NUtLCW/+A7gqjdmcyPrX50kAZGTriZT9pwma0gj4zKtcP2+vwzHMtCixHi9aCfNS/KUYG1ZRdc4x+80Xj2VJBJBic4PN/zA5bycoIB6vrogrxBN3UJmQu7lj9fs8OhxEWHvRF6IHCezC00kz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+c8mBRVwCY1iaiqyl6IK8OOj2l2sKPVp1tM8KW2IBQ=;
 b=gZv4CWhHSzlXO6iGl+wCalqDBvXfwRqo+liCn3dVbUNz9EhYYcANxyTj8hLRs6PGqzNa+8m4d/uaO8k7U+2tDWVwG8psjwk8EHp9D4pjpCFTTTOLiob4vmq4NNCXdxQ4kSD7JUd3ozI049Pfnk8i6C/wMfiZgXMo8CbKmYDLM5WXsMXBqamRC6ih+6h/YudtabbVL2B0fpeJz/BbBkonGRIlPwFtYgxghv7P9G2tRaAW2R/zvHSlxUZcgJgR7m+kXnRDR2EPXVc1iq473/qn5FwMHhuSUXsBON21mb8G6VTDZA8dzTODrcvUQTOnsY1DeKLkjfw6u7iKcwYIjlmM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+c8mBRVwCY1iaiqyl6IK8OOj2l2sKPVp1tM8KW2IBQ=;
 b=aQnX9rvK0+va5oOGvsnZSP17kT91XzueRHJHeDn33wT33rA90HofZlOBIw2dg6vl5zHYoIyykedMNVuBWRo1A2V1hSgZ4HZ4kuPWoh99kUg86zXYltEr6se7r1l35DVCzPU9+NdB5htTvOOEsKIYkCfIUcUdjUxGt8KE+EEWisT+q2HB9DB8B7cpOSjvkleIlzHcGBs9PsVuvoYEDeO/ZC7m+VsTXwORh40lddsWtN/KrGnfv73Cs8qDMOY9zJi8HkSxH70Yax967+5WUihwTtx37/6UKh4ZSOfKGmhixnKD2fROZbMc8rGl8x4p5A+JmVRfSldNeTm8lqcBFPBLOQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:27:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:27:02 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Minwoo Im
 <minwoo.im@samsung.com>
Subject: Re: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHa0cfEukGxrC/dLUmtiYAPj/jVW7HubVIAgAAHPoA=
Date: Tue, 9 Jul 2024 14:27:02 +0000
Message-ID: <6ca0acbd-0258-44ef-834f-029660d29168@eviden.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
 <20240709061756.56347-4-clement.mathieu--drif@eviden.com>
 <1d7c0f11-7aef-49fb-88ad-337df3081162@intel.com>
In-Reply-To: <1d7c0f11-7aef-49fb-88ad-337df3081162@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: e7fcdc3e-239e-4921-0b28-08dca0233343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWtjZ1lrWkE1UXd2UDdyWGVWclZGVjlRSjNIUTRwRWxLL252WVZYQVNTZTJ1?=
 =?utf-8?B?OUVpQ09oWHB6MkUrUy9lZXdZV3RYNDJPK3BpblRiN1NaenJFWWwrbDR4QUlw?=
 =?utf-8?B?TTFHdE1kQ0xLejJseTVvZWpxWnoxRGhHRnlRVWV2K1BDOUFmd0JZVnVBbm5h?=
 =?utf-8?B?ZlRMeW4rRjZ0ZlFLdXlSVjNaWldpR3RVZEprUGVNWGRrWVlMVndUY2FJOWY3?=
 =?utf-8?B?T283dFJseVFWeDhsMzhsa3JxTURMU1A2Wnd6SGd0RjRVUExpTnp2TElERjJG?=
 =?utf-8?B?ZEZxU2V6M2VaU1hwRGxJblJtWGZDVVd3NkROaUJaY2lIdzlvTmFBSXU3UGpX?=
 =?utf-8?B?MVBDWWdKM2tTblhUMW9TSndKQnRBbDFMb09ycGJHNTc3MGhOMTR3RFJDTHpo?=
 =?utf-8?B?dzhxRkE1SHQwVTRiWDhjNERyTHFXcHpYd3IyNzBsbFpTSHdDcFFtZ0NOOW5F?=
 =?utf-8?B?QUVSSk9SVTFtR0JYWG9UVlZ4RXRWejJNc2o4cHNuZUNvSVlwczRBSEhPekFm?=
 =?utf-8?B?WE1EeWNBNStadkZlZi9vTzhWQ29QMHpLSW1MS2lhSCtCM28vQldpSDZSUkRp?=
 =?utf-8?B?MER3eTllVWE1N0d6aWt1akg3Tmg1d1Blc2UyOXpxUERWa20zWWFhb2VKMWZo?=
 =?utf-8?B?Y0JZRjBtTUlwVEp5YmpmSEZSZ1hNUGV3dVQ2eVdYRU1IYXBlM1UrVFIvZW90?=
 =?utf-8?B?QmtIcEFhVFZDRlpuQ2NmQ3RNdDFWS3dWOHdsU2hieWZmQmoxOTFmNGlWMzZX?=
 =?utf-8?B?ODhZeWpPRlJiMGRxMkovRDhNeXlsOTVXSFA1QjJlSFdyNUtJQ1k3Z3Nwd3ho?=
 =?utf-8?B?akdpSytlN3JlYmxTdXRwOU8rR1J4VE8vbC8raUV2S1RLUlN6Y2RMaERTLzd2?=
 =?utf-8?B?blVoYWpHVjBZWmtOSU9hQjVWMHZMTDhtUllZZnFVdkNhSnBsMVVhdDA0MFVs?=
 =?utf-8?B?TXUzbXpTWituTnhNRTNxb1JSMWlicTVaQzZ1a1RoakdrU1o5M3RCZ241MmxJ?=
 =?utf-8?B?TlArRGJjYllHcXJ0eEVVSnRWejZPTk9CbmlWR0djS2ZqN3h4SlROdkpEai9j?=
 =?utf-8?B?WVF5Z24xdTduMkZTRENtYnJHQWFDZlBpWmtSZDF1bTArWXN6blFZNHJhbGxj?=
 =?utf-8?B?UTE3OWpRTVJZdlM1UUR0bmJTWFpZa05tL1VwU1ZOMnp2L0ZyOFhEM1F6ZFV2?=
 =?utf-8?B?Y3B0UjVRUjFHaEdLNnBZRUtPQVZGVVIxQm81UW5hK3JEU3JkZ2wxRlZ0TlN4?=
 =?utf-8?B?TFRsUy9kME5Qa1NMSnJDeGFjdnhzRVhsdGRXUStkVXJPdFRCQ3pCcTFib2pt?=
 =?utf-8?B?RlhGZm40Yzd0WEw1aFYzb1BaOERJbERMVEtxNEs1N211dGl1YmlncENRTWV4?=
 =?utf-8?B?YmV5RDhsdUFzdTNGbG1XMTl2V1lTbE1tL2puWTdjMlJQVHBlZUpvL1l4RWpu?=
 =?utf-8?B?SnZHdDNON2hpYXdvUlAxZndNSG5iZ0tiYUxmSUZNYlA4RXM0WlFJRFpnWHFp?=
 =?utf-8?B?bFh6TVhKZVVYTWhYSjZ3V0grbVJDcDkyZXVBMXduejl5UDF3L1YrQmlmNlp2?=
 =?utf-8?B?ekVKclh3UmU1T1NMRWVXZHlnVXVnSTZqU2Exdk50WEpUVktJQnR6OWhad3Nk?=
 =?utf-8?B?L1F6eEFqZHBzVG11Z3pWR2N0c3QyT1lyVTRibnFCRS9PSjdJNERORDgwRnZq?=
 =?utf-8?B?WlFHR28zWDZQM2s5OFpoVUxEOXl4NEhQQXZTU3haVFZucXdZdGZKemwzUmRG?=
 =?utf-8?B?TjRxN1JKNEM5QmVZektBMlB2MGwyTGFFS1ZFU29ZZmFieFhWOVBEVE9Icm1H?=
 =?utf-8?B?Z2NpUEQ1dUxjczZSb1N5d1h1emxxelB0cjNHUGtzaC9jcjRLdnNyUnNyakhj?=
 =?utf-8?B?eTh4UG1hOWhDd2kyK0RyZUJySVBkREw2bEd1Tnh1bFFET0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1paVQyU0tXQ1VaMngzOE1PSnZLOTZlWTh5cWVIME1BbjBuOEJ1SEdkUHdx?=
 =?utf-8?B?V2N4SFRXZHhiZGhJOVBOa2hrckxIMjVZM1VlNWdvTGI3cmhGMllsRlZGVUZ1?=
 =?utf-8?B?NUZMR3VTNUN5VjBjakhMUGpXZnlPcDk5TkUxMzd5REhSaUUxaFNmMDBJZ3dB?=
 =?utf-8?B?bzl1UHRZMnVCY3JQZnhmRnRhZExLc1pSaVo2NHBjZmNQWEl4d1lLUGZsaVNU?=
 =?utf-8?B?c0lHa0R2YXRpaEt1YkVLZHFzWDhZMVNxN0dUYzV4YlVvb21qbEp0UE5BQXpI?=
 =?utf-8?B?amQ4Y0MyVkxLRHlZeU83bXJJUEpGTHVRZS9ybGY2dXA5L2hDdG9CZjR6Uk1W?=
 =?utf-8?B?SzZ4WCtOT3pFWmdMUXBRcnRMeS9JUmRaWDVMcm42UUE0VkZqcFNwWStQQ3hr?=
 =?utf-8?B?c3RXUFBrTDJGem9NMHlqV3FvSVpPa3dXcEk4SzR5bFY4azB0Z21FYkZTdlhy?=
 =?utf-8?B?M3lzWS9vVmsvd3RZeUErY283U2RwVURRU28rcGxySTNVVUpGaThackVGcmcy?=
 =?utf-8?B?VTNHaGYzWlNzYVJRTldEZVJlQ2F4ZUNvNzNaS2xiUll2aW9sNU01eTFxQmVk?=
 =?utf-8?B?M09iZnllNTRCSlBKelM4dE9JZjFLNzIyRVc2a01WMlg2ZDU4NWFUZ0IwY2E4?=
 =?utf-8?B?alRKTSs4ZDB4VnVqMzNCYTRIYWdNT2lZY21pQTd6WGVtQTNsdGNUNjI2UFBW?=
 =?utf-8?B?ajJaMy9pQTQ0V1Z2TzgvLytXSXNFRUZmVFoxQTZRVTZyM3FDSVZYc3JqaFlQ?=
 =?utf-8?B?djVjdWV4UFBKOFBOMmhEU3VlaU1CV05SWlJ0QkR1QmJGRjFNVEJtRXhNTUdx?=
 =?utf-8?B?OWZCSmNmRzByblJTUVFxeVdsMmU0RGpqK0NXVXFqcmdxL0QzT3k0a0pNVTJp?=
 =?utf-8?B?aTJVenljR08vUURlZ05JV25DZlF4MXB3Z2ZreDhPWkNOM2doUk1idVhEaHBB?=
 =?utf-8?B?cHNURXIyMTFMcDBLbHEzdmxjOGtoR0c5bTZVZEdFMHlaNG56Y2d5cWpSdGxL?=
 =?utf-8?B?a3VWY3U1N0lOeDFZQldsV1FiNFlkeTFRTE9tenJSekhsUlA1S2dEeFVjSEF2?=
 =?utf-8?B?bm5RaDVjeDNFYUFRdzNJbDBFbVQxSTVlU2JSVUJnSDgyd0llYkxiSWhDRjc5?=
 =?utf-8?B?c2ZTWXBxOTl0ZXBLSFlmVkpEZmtHeHk3TlVLUVFNemVrWWtWTmpqcGtxVDlM?=
 =?utf-8?B?QklQRVIzdVJWTld5VWtsaU9KdnZLY09CYThVMUlkc28vSHo1ZVhnKzNibVZw?=
 =?utf-8?B?OE5iVE9wSkJXb1JicnJrak1USUhlajdFeGNRajdjTXlrdmtTRC8wREJaeDdn?=
 =?utf-8?B?YkcwMWZtS2V1ODFUUmFJdmFKS1Q1azlZb0hhLzBSSGg2WldDb2lvcUNwTWxQ?=
 =?utf-8?B?NU8rSEJ5ekNwazBweU1mOHNXclNoV01YWmlXS3poNjR6VjYxekxOanB6L3Za?=
 =?utf-8?B?K0NoT3pFYzRualdGQkpYRDY0OVlCQitxOU5CdE9CZytBdHo4QitOeHpwTlY2?=
 =?utf-8?B?dFQ1dVJsNVdzZFN6VkhORStXNk5BQ3cwWnJGYmd6Y3E1cUk4eUhUcDJScFEy?=
 =?utf-8?B?SkVnZjdCdEtaVjdTYlZNQUkxeW5CZ3JZQ2E3M1FTRWliWEw3cncrVk9GRkZ6?=
 =?utf-8?B?MkxQZFN1eWdqazVjV0h5dUU1TUdHam5OTmx4YzVpc1VibS95Z1c0V0xDYk9i?=
 =?utf-8?B?WUppcW4xbzF2NTdINTJoT3BSRTlEdWpMQWNSR25lQ3VjdndGaUE4VHp2cjhV?=
 =?utf-8?B?YUxZU2QxeS9vMUNUMStwVkhzd0JIUVlQSWtsVG1uVnNQN1B6eCtKWHV0a0R3?=
 =?utf-8?B?azFPbkhFY3NqRUFDVEc4aXVGVkdNUUxlOWhNZ2xFa3hlOXBGSkZYWWxRN0d4?=
 =?utf-8?B?M0NOSXFwUEg1Um9RT1ZsNkY4WDZPYXhiYkk2bVg0K3RmYzBISkg2SDBmQUhn?=
 =?utf-8?B?VWwwYVRCT2Y5N1NDYjlZRHI1cDN5L0d0NUpUeWU5cy9nQ0JVdUZpejYwNldG?=
 =?utf-8?B?RVRVZVhMOVR2d0Q3Q1NSYXhlNVNXQkRNVWhoeWU1OUFzSGdYRlozWkxWRWNS?=
 =?utf-8?B?MUhoWStUQmdzbEZUT3I0VDJHVWxaYVh1SFpMemIyWFJ6UHJmN0M5UmNOeno3?=
 =?utf-8?B?enVYcEpHYkRZN1R1TjIzT1ZrWHlSQzlyZUVkMVdTUFZLK2NGSmZQNUpXWWty?=
 =?utf-8?Q?qj5LFPh39Dzz3UDzcEsFT/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5264D915252BFD4F92A14D248F62CEDF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fcdc3e-239e-4921-0b28-08dca0233343
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:27:02.3863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vREG0LSi5joviJpkvhJXxdjj8ahp3Y+ZNCB6mM2lqctAz5qMV3O3mzK05jwS8fIilDrS9UdZ/XQGMkKuKh2DOTdDiLV9t9t+bGLkfxKZBgbMNm34f+Bo08PP/I/XczlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

DQoNCk9uIDA5LzA3LzIwMjQgMTY6MDEsIFlpIExpdSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJu
YWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCANCj4gdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgDQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDIwMjQvNy85IDE0OjE4LCBDTEVNRU5U
IE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+PiBGcm9tOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+DQo+PiBUaGUgbWFzayB3ZSBhcmUg
dHJ5aW5nIHRvIHN0b3JlIGludG8gVlRESU9UTEJQYWdlSW52SW5mby5tYXNrIG1pZ2h0IG5vdA0K
Pj4gZml0IGluIGFuIHVpbnQ4X3QuIFVzZSB1aW50NjRfdCB0byBhdm9pZCBvdmVyZmxvd3MuDQo+
Pg0KPj4gUGVyIHRoZSBiZWxvdyBjb2RlLCBpdCBjYW4gb3ZlcmZsb3cgYXMgYW0gY2FuIGJlIGxh
cmdlciB0aGFuIDggYWNjb3JkaW5nDQo+PiB0byB0aGUgQ0ggNi41LjIuMyBJT1RMQiBJbnZhbGlk
YXRlLiBBbmQgeW91IG1heSB3YW50IGEgZml4IHRhZyBhcyB3ZWxsLg0KPg0KPiBubyBuZWVkIHRv
IHBhc3RlIHRoZSBjb21tZW50IGhlcmUuIEVzcGVjaWFsbHkgdGhlIGxhc3Qgc2VudGVuY2UuIDop
IEp1c3QNCj4gaGlnaGxpZ2h0IHRoYXQgb3ZlcmZsb3cgaXMgcG9zc2libGUuDQpPb3BzLCBzb3Jy
eSwgd2lsbCBzZW5kIHY3DQo+DQo+Pg0KPj4gaW5mby5tYXNrID0gfigoMSA8PCBhbSkgLSAxKTsN
Cj4+DQo+PiBDSCA2LjUuMi4zIElPVExCIEludmFsaWRhdGUNCj4+DQo+PiBBZGRyZXNzIE1hc2sg
KEFNKTogRm9yIHBhZ2Utc2VsZWN0aXZlLXdpdGhpbi1kb21haW4gaW52YWxpZGF0aW9ucywNCj4+
IHRoZSBBZGRyZXNzIE1hc2sgc3BlY2lmaWVzIHRoZSBudW1iZXIgb2YgbG93IG9yZGVyIGJpdHMg
b2YgdGhlIEFERFINCj4+IGZpZWxkIHRoYXQgbXVzdCBiZSBtYXNrZWQgZm9yIHRoZSBpbnZhbGlk
YXRpb24gb3BlcmF0aW9uLiBUaGlzIGZpZWxkDQo+PiBlbmFibGVzIHNvZnR3YXJlIHRvIHJlcXVl
c3QgaW52YWxpZGF0aW9uIG9mIGNvbnRpZ3VvdXMgbWFwcGluZ3MgZm9yDQo+PiBzaXplLWFsaWdu
ZWQgcmVnaW9ucy4gUmVmZXIgdG8gVGFibGUgMTkgZm9yIGVuY29kaW5ncyBvZiB0aGlzIGZpZWxk
Lg0KPj4gV2hlbiBpbnZhbGlkYXRpbmcgYSBsYXJnZS1wYWdlIHRyYW5zbGF0aW9uLCBzb2Z0d2Fy
ZSBtdXN0IHVzZSB0aGUNCj4+IGFwcHJvcHJpYXRlIEFkZHJlc3MgTWFzayB2YWx1ZSAoMCBmb3Ig
NEtCeXRlIHBhZ2UsIDkgZm9yIDItTUJ5dGUgcGFnZSwNCj4+IGFuZCAxOCBmb3IgMS1HQnl0ZSBw
YWdlKS4gSGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIHJlcG9ydCB0aGUgbWF4aW11bQ0KPj4gc3Vw
cG9ydGVkIGFkZHJlc3MgbWFzayB2YWx1ZSB0aHJvdWdoIHRoZSBDYXBhYmlsaXR5IHJlZ2lzdGVy
Lg0KPj4NCj4+IEZpeGVzOiBiNWEyODBjMDA4NDAgKCJpbnRlbC1pb21tdTogYWRkIElPVExCIHVz
aW5nIGhhc2ggdGFibGUiKQ0KPg0KPiBsb29rcyBsaWtlIHRoaXMgaXMgYSB2ZXJ5IG9sZCBjb21t
aXQuIFRoZSBWVERfTUFNViBpcyBzZXQgYXMgOSBhdCB0aGF0DQo+IHRpbWUuIElmIGd1ZXN0IHNl
dHMgYW09OSBpbiB0aGUgUFNJIGlvdGxiIGludmFsaWRhdGlvbiwgdGhlcmUgaXMgDQo+IG92ZXJm
bG93Lg0KPiBKdXN0IGN1cmlvdXMgd2h5IHRoZXJlIGlzIG5vIGJ1ZyByZXBvcnRlZCBoZXJlLiBI
YXZlIHlvdSBlbmNvdW50ZXJlZCBhbnkNCj4gaXNzdWUgYmVmb3JlIHRoaXMgY29tbWl0PyBBbnlo
b3csIGxvb2tzIGdvb2QgdG8gbWUuIFJlbWVtYmVyIHRvIHJlZmluZQ0KPiB0aGUgY29tbWl0IG1l
c3NhZ2UgYSBiaXQuDQo+DQo+IFJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IE1pbndvbyBJbSA8bWlu
d29vLmltQHNhbXN1bmcuY29tPg0KPj4gLS0tDQo+PiDCoCBody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggfCAyICstDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oIA0KPj4gYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGZh
ZWEyM2U4ZDYuLjVmMzJjMzY5NDMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4g
QEAgLTQzNiw3ICs0MzYsNyBAQCBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQo+PiDCoMKg
wqDCoMKgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+IMKgwqDCoMKgwqAgdWludDMyX3QgcGFzaWQ7
DQo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHI7DQo+PiAtwqDCoMKgIHVpbnQ4X3QgbWFzazsN
Cj4+ICvCoMKgwqAgdWludDY0X3QgbWFzazsNCj4+IMKgIH07DQo+PiDCoCB0eXBlZGVmIHN0cnVj
dCBWVERJT1RMQlBhZ2VJbnZJbmZvIFZURElPVExCUGFnZUludkluZm87DQo+Pg0KPg0KPiAtLSAN
Cj4gUmVnYXJkcywNCj4gWWkgTGl1DQo=

