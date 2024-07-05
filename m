Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A801EC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPght-0006Ti-5x; Fri, 05 Jul 2024 07:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghm-0006RA-7t
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:19 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghk-0001UB-KA
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720177337; x=1751713337;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xQVM7ylMlGKzxRaBVpQZpqXD9KGA8oCWP93OVr5usyQ=;
 b=Ylc+pk5dOAcknYdpnlMcdjV51s0/TfRAWaWnaoaHVIQXbfPSPlFJqVZM
 j4rw4TTo616tDsFreE24LXOR0mQC3V9NtUbwT+fgz2W93wxiZldbEbeP3
 nufrOtJLcA0GPDUgRPtOxngpIRDh2a/nHILWbAC5bpb6qkN8OyHeznQHT
 8Axy4W2pSwiary5HM0v2KPstx5NNSMjBVP1osty7FlCjHRu0/POLxc4ht
 eLRItNd3AyHUEOFKADTcg4nTT/xeC43c5vwAJAdKDdAjggjk8hz35pCZU
 bMMtaMD2Nm/F4qEI2Twzrz1FCFoes9dMPS5zofqzy6We/sAdZZXu07OjD w==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="16056521"
X-MGA-submission: =?us-ascii?q?MDHlrUuxReAWgnVhkPvP+ginv1tq7w0+HKx/d9?=
 =?us-ascii?q?wOC2RId3eKO87B3D/ZT50WoMlXuTXWOWUh7g1uY2FpDU01swOk+OJHP9?=
 =?us-ascii?q?ZHCSl1BwJ/K50vGdop8Tia6D677mU0pD2mIhwwQiVj5C5nDK2Cp/x9yP?=
 =?us-ascii?q?jgfChnsq51GZrtlRoBiZsFfw=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 13:01:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BueE5yn6X9gtbCo4d4d1Cmup23JSQuS3M7iiGT0opbra2vBFOjzXP0qw3U2G7lhxiI8nwRbGyAPP8rXHiLvL4TT3GtHBCVQfDB6IOBzpmY/3sFsgWwanKQ0gf8eLvNPa2OKDllI3rnBV7qriLyEX9kKuXxNuJ3UC3f+I6WZ2ufwL+6+4XpirMMEFxYECnsvKJCgKyi7KcDYF3GknikmqFah9bjmMzd9UBsKz7QPAxohnE6GJvZcWNMcuHl756HmPbREfzRg0BzBr4cIRyt4Bg4wi9eijof+WVmrnhaYFhF1jDOVTkWuszP4LVg/oMyTEI1Nlm6g/42IJ5mT8SgX5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQVM7ylMlGKzxRaBVpQZpqXD9KGA8oCWP93OVr5usyQ=;
 b=XOLQeHVhwp2wqY9m6u8xj+KXN47hqJKdKHmnghDtlmqHJ3MFXpfffZzbWlWfaPftmihwydrS3rDbpBnaGt4Wqu6Yui4tUD3ydrsiV4WqDj/3mSToMolfz7UbU6gemBQfX7NgoqXYx9C62YnDXQgtt/nJItjuQ8T8OpWzZGv9sO3t9lYKg7qWFj8KU5i8CRkBGUcMFkezvnGuO8fgFw8p1mUGoooac08LuVq7jq6LTv1+MurujDhmaIw3NWEBCiWe3hfMutB/S/wLWusGPxfE3qU7sHjlXraMX/DrXjw1KrdZhZ2tMmS7R5drP0LnH6afyqh9gAJybDRlctrfueI/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQVM7ylMlGKzxRaBVpQZpqXD9KGA8oCWP93OVr5usyQ=;
 b=B8e5swG8jr5djHO7BIa5BTfiKYF5b44tWFN3LDJkaw/ZzfnVoqvqxGbQITGOoLMwbrP6MoJ90eO5ku+MKkCFyEXicdnvcCUmARxT4oX33OpoGp0jF2l2IJEgWm/IEJgFFc8ZOfO1pvEOSwK8+oxA4Q6Wtj2FFauzIGu9dBqf2f6rwf/JAeOMgPg30njmTm7XPZnFBh7ORf0ZHXqHm8r5T93eguDXzhwpdKKTw7vy9E0OxM2LKZ9nZThI3hg6b1lFUM17Ppf8ncX7FM81PXlwOlM8/utzhERFWybWFhddAJxihXH/k8IdhRFrcplDk4LWGKlyCKk6nCAJtFBtjPkqNQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7303.eurprd07.prod.outlook.com (2603:10a6:20b:259::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 11:01:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 11:01:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v4 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Topic: [PATCH  v4 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Index: AQHazsrAAk6W8c6+BUWyia/w+c4s6w==
Date: Fri, 5 Jul 2024 11:01:57 +0000
Message-ID: <20240705105937.1630829-3-clement.mathieu--drif@eviden.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7303:EE_
x-ms-office365-filtering-correlation-id: 7ffd236b-be85-403e-0444-08dc9ce1e373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0tiL2d3L3NEVlM0MUwvYWtldUltRkswRE8rQTBHaDRIa00vNXh0aDBIanNp?=
 =?utf-8?B?dWx2UEN5MlBhc2RNRURtcXp5UzhtcjFMZmVqeDdDK1VGQmxUbi9rdEQwVUJX?=
 =?utf-8?B?UmhNcjZzK0RoMzhldjh1Q1FGbG5FMWgzd1FtejdmcHRXQnJUZTVBYWFraUNu?=
 =?utf-8?B?Wkl3cDZEUHFvV3l3L2MvMk1sam41ZXJ4bWpDZjUvN3JObWZIZDhTaHZtcys4?=
 =?utf-8?B?WHlBSi9uZkFiNEd1SnVkQlBGeWxiNkNaRVJJTnBBNWI0NjhpeFNHSmNmWHJN?=
 =?utf-8?B?VEdjM2lLeVM2UU5iaDRONnRRWk8xYk5ubU95aStGbHpzeWFhN0xxc1lrQ3pv?=
 =?utf-8?B?Qnh3eHdDTlR3YmpsZUJQYlRZVkp1OVlwOTRIMlJkelNQTHV2RUxLWE1veS8w?=
 =?utf-8?B?RUlSL1VhNUxPWUJFdzJheHdFZC9PRzVXenIzOFVueVBZVEQ1US9GamkwUm4v?=
 =?utf-8?B?cUxOeUpTc3RCSS92eGNTZnZvTG9vQXBoamdHT2Fnd3dBZkpsRTV0QmFjWXVx?=
 =?utf-8?B?cHE0OWJDOWhLUTdJZ245eXdSeEoyem14dlRhZzVRYUJoaTdFUTVIbi9WbENW?=
 =?utf-8?B?cEc2ekJ4VHY1TXIreXRMRHBZcGNJenJPWVhyeW5ZV0JURERZdGxDRkJBd3Vp?=
 =?utf-8?B?TUhZNUNmQWEvWHR1SXBLWlU2UFUrbllOcVRNMzc5YS9xUEFvV3FCVGJzV1Yw?=
 =?utf-8?B?VDJBZGJzS3EwdXNtTDRDVDFpMXEzOXBpc01nd1M3NlBBcnRoT3JtMVQ3UE1U?=
 =?utf-8?B?dldtR3dkaGhoL0FUbS9MRUxhclJyazRNMGtaNGNUeTJRL0NiaFhIS0owVy9u?=
 =?utf-8?B?dSs3Z3VkQ1MySEc5VGtPOXRzUUtNUCtTWWpLZkc4UllRQkVVcloyTWlMZkFj?=
 =?utf-8?B?Vjl6SlVUd3ZtYjVtakxseVhDK0Z2UzhLTlpZTHNTT2JqS3ZvL1ZJSk1yREhl?=
 =?utf-8?B?VUtNREhxVjQ4dTl0YzZEL01tc3YyUEdnNTIzcUlNQ0Q3WDluaGorRTQyckMx?=
 =?utf-8?B?aDdiUFJTcHVZTWlXQ1JDZDRkTjVoZHNaQm05bWwvV0NFalVQdlVycS9talFE?=
 =?utf-8?B?bldjQ0dDODJjMFVZUmZQMWM3d21CUVRuNTlSRkVydWIyWHBwSy9waHNnWU1v?=
 =?utf-8?B?RVV2dzEwRkpzamdQVnZEdnFDS0pqYlg4MTAzOFhCYjBIRXJFUTFRcWVGQTJy?=
 =?utf-8?B?cGRuSlZOcmdHTnJqQlQ1cXFkSzhXaFpCK3lRQnlibm1zR1FBQndXYjFFaDht?=
 =?utf-8?B?N1lwZEZPR2M1TTlyeWF5VlI4NFBDd1VqYUJEV2xydVRNaVo2bXZrVkhjaldM?=
 =?utf-8?B?cE1sRjVoUkQveG1ubkkzZ1Z4WWY0aytpRTFvdnphWmozMkdUaVpPa3k0N1Ru?=
 =?utf-8?B?NkRVRG1GejB4c2cyemlMN2hPTzRDb0ZzdlVTRUJ2Vy8yRlVta0RQdEFOYU13?=
 =?utf-8?B?WS9TNVdTcWNta2c2ZjNHNDJQMGF3ZlVxdUZGa2lMNTE5Smg5dHdNQXA5U1c5?=
 =?utf-8?B?NGRoRUpYSmlZb3pnOHNmb3pEa1VxTFlsVlBERThDc2ZjSEF2WGNhRGdzL01W?=
 =?utf-8?B?YUtJQ1J2bU9wUXJQWllrclhlaUFUbW1MTWZPSGtWMXcvOHdMYWlNSC9MTHNK?=
 =?utf-8?B?UUVSaE5OT2orTkp0c0h2ajVkYlRzNyt1MTJDU2xKSXBROTN6Y2JoYzFVZGxx?=
 =?utf-8?B?Tk5jcnBJRW5yLzlEdG5RbUdOSFhpVzBxUXBRS1JYR2dEcGE1QldQRDBtd3JS?=
 =?utf-8?B?MXJaZ1Z1NkE0dzZab1Bpbm95Y3h5SzhhajFxS1BLa3NUK1VtV1M5TEZqR0pQ?=
 =?utf-8?B?WjRweXdpZzRULzdFcVFJMWtiaENOdm1aVGlrbTNjWnRVUTQwREwxZ0VZb3Qv?=
 =?utf-8?B?eXlnUU96RGZjWG4yNUdkM3FSZEZFUEJVK0NPT0hwSEVaWnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUM5LzRYOFdUTTU5WERDWDR3M3o2WE5tbUNMcnY3bzUxSjRNOVNjRi9GTXdK?=
 =?utf-8?B?UDFVSzhMTktTdXBjK3BMV1RzQlQ2NlVGNmVjTjVPQ1d6L1d6clhueDFoQkd4?=
 =?utf-8?B?cFYrVTJLekNYcmhJRzFLK3hPemRtaG1TRm5CQWxaSklGK2MvNi9IUmJIZENC?=
 =?utf-8?B?RGJTaWw0dVNCaVA1YXRRUkxiZ0hoenp6aEl3b0duSm5PREU0UTlsVDB0K0Z0?=
 =?utf-8?B?aE16eWU1VFMwNC9JeWkwN1lMclZCMDhvc3NiVnhRYXlSejN0ck5kWWFnWFZE?=
 =?utf-8?B?alVZNlV2SmxxUkFpQ2tTcVBHOFZSN3ppMDRNSGY1cXhQNzRGQWZyWWk0YUMx?=
 =?utf-8?B?dkY4RGFNbk41UFNaRC9IeTkyeGRUZnIvcmd1Z3V3ZE80aU5PRUlNQ0VOSzV3?=
 =?utf-8?B?TDVEK1dHWEFndG50N0hacW5pTVN5cy9XNWwxckw5cDlTVXFsWDZ2VnUxVnpV?=
 =?utf-8?B?VTJpWDBpV2FwTjgveGkxZVpkb0ZxQVd4bGRzYXlzT0pNaFpnSGNxeDZNSDFM?=
 =?utf-8?B?ZWJtMWZWaTlJdnhEbmU0QWFmc0dEelc1VlQrZFVBQWVIa2NkRktRVVQvR2E5?=
 =?utf-8?B?aHdkMm1MN3Y2aFEwcVY4TWhBTy9ueWZaM3JYRmxhdENDUGtkc1dBTlZXUzlw?=
 =?utf-8?B?ajZpVGxXK3FXUmlFaEd5TDN1L2VOTGpHUm5ObnNRTXRjcnByYXdGUWo3bFRN?=
 =?utf-8?B?WnNpK2lQV1lCMGQvcys0VnBIRHAwSEMyTS8zUVBBODJmazREWnlQTVFmUWdW?=
 =?utf-8?B?ckNlZ1BPMTZoWFVUMGZtdllyUzExWStJUlB3R1orR0dEa0ZpVTFzWThLNERF?=
 =?utf-8?B?blFqMXVkZlRFRmZLMHhTb1BsS0FYRnlZc2Vkc2daeC9EcjZBanpsdW5QbVMw?=
 =?utf-8?B?QytiNDRHekQ5T0tSZGsxYUJTbXRhSFp6WW5DdEVWZmZTamFHMVFxZTZzN1pU?=
 =?utf-8?B?c1duZFBDb3kyS3U0TzJKcWJiK1B0ZWFJdXFQVjg1M2krYVo0RWFuRnY0WUhP?=
 =?utf-8?B?VVljeUJMaFV0N3dvZTVEekRrVGNpWm4weXY3czVsVm4wbmxDcHJ1bHhXeWxO?=
 =?utf-8?B?QUY5SkJuMU1YMHN1WHVHN2N4bmJ0VWxjMEhiYUxaU21UN1NSVUZ4dm94SjJ6?=
 =?utf-8?B?M1p5K3ZPeTdOemF2d1F4Q2JUblZXVWNVNXdSRFZqbFVoUllnalFIbW10cHR4?=
 =?utf-8?B?bUJMQzhpNXlmMUhETEtSZHphdys1ejY3TzFRZU9nVStyRHNnRS80SzFneG5U?=
 =?utf-8?B?R2hZdnZjZ1ZpaE1lUUV3SGhCQTVpVzltUmoxNzJ4SWx1cmtuS0tUYjZDTXYw?=
 =?utf-8?B?WVpsUW1TNms0SnlIVW1qK1lMUmI0Y29PVmVpNnFER2U4WHFFdXNvNlRJdkxm?=
 =?utf-8?B?aUFrdUVzQTRHSXo5M1padklxOFJWc2NsTU9ML3FDMmx3aC8yRTdHWjJ1TlBk?=
 =?utf-8?B?aGJ6TGRQcDZ2WktGV1d3QXdYYmMvdzhjY1htUkRScUhTZk1KLzQwYkF3SllM?=
 =?utf-8?B?RUdnS2xpQVFIaU9wOEhrVCt3bTh3bU9jRzY1TU84VWtPamx6MmxwRTV6QVRQ?=
 =?utf-8?B?dmVkdjQ1RmcxYW9mV056UWlTUXFRcE5RTlVXL1k4cER4SzZuL3BtbFNIaDZR?=
 =?utf-8?B?cTRMckxwbjFUcjlzeUQvY29FdkVLdno4MGRmVC9lbUYvL1R4dzY0d3RpQ0hP?=
 =?utf-8?B?OTMrRHEvTnp0V3ZoK2ZXRkdQSGlEWGZSL2hJQXV2Zyt5dDBpYUJ3LzRCbW9M?=
 =?utf-8?B?bmVzUGNhZUlra1hCOUZBbldzSSt4YkNPY2xCSFp5MFZPSlZKQWNxcWZITU95?=
 =?utf-8?B?Vkp4QXJOSmJLcVByYmVMWFl5M3VoMklSc0xhcUY5YTBEY3JQTGRlcEMyUGw4?=
 =?utf-8?B?KzVoWExMcGJhYSs2aitwZHNSQkpjTTNPemRiNkRJQ0FQM0JSNmFQSytTQzBT?=
 =?utf-8?B?M3pDY3pLU0pZaFZtS0p5eVFsendBaGRLMkNhVGFmV3hZQkJ3YWxCOGZrUnRt?=
 =?utf-8?B?MDNBWVUvL2dwVENNOGFyaU1JYXg2UWl5aEdaYzEvTnBCNGVpaitXT3U3cEl1?=
 =?utf-8?B?bkV4S1EwK2ljY3M0MERYZEpObWdTMGFkVWowT3QrbWEwZG4vMnVyR2pFd3c3?=
 =?utf-8?B?SEd2b0dLdjhHZkdoNy9lS3YxNzlObFBZTnE3OXNIa0lPRlZyQzdvazdtZXBo?=
 =?utf-8?Q?ffgF5SHXgnH6Csr+0LMc/mA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E566B84CB6005747A2EC684CE0052449@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd236b-be85-403e-0444-08dc9ce1e373
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 11:01:57.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzUm602UVUBTmvyUp10C3K0hlNFdBsqDT28lWisudSIqxhEDTe0F5rcRYY4ch5YlJOPeF8nL49mJGJ/v3AaVJrdpPvQ2tt5cZe+J5RDCFG/WcaeTHQlr+iJfsX9hPcMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7303
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZXNlIDIgbWFjcm9zIGFyZSBmb3IgaGlnaCA2NC1iaXQgb2YgdGhlIEZSQ0Qg
cmVnaXN0ZXJzLg0KRGVjbGFyYXRpb25zIGhhdmUgdG8gYmUgbW92ZWQgYWNjb3JkaW5nbHkuDQoN
ClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwg
NCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggY2JjNDAzMDAzMS4uZmFlYTIzZThkNiAxMDA2
NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtMjY0LDEwICsyNjQsMTAgQEANCiAjZGVmaW5lIFZU
RF9GUkNEX0ZSKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZmVUxMKSA8PCAzMikNCiAjZGVmaW5l
IFZURF9GUkNEX1NJRF9NQVNLICAgICAgIDB4ZmZmZlVMTA0KICNkZWZpbmUgVlREX0ZSQ0RfU0lE
KHZhbCkgICAgICAgKCh2YWwpICYgVlREX0ZSQ0RfU0lEX01BU0spDQotLyogRm9yIHRoZSBsb3cg
NjQtYml0IG9mIDEyOC1iaXQgKi8NCi0jZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgo
dmFsKSAmIH4weGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZh
bCkgJiAweGZmZmZVTEwpIDw8IDQwKQ0KICNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAg
KCgodmFsKSAmIDB4MVVMTCkgPDwgMzEpDQorLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1i
aXQgKi8NCisjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVM
TCkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkgJiAweGZmZmZVTEwp
IDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KLS0gDQoy
LjQ1LjINCg==

