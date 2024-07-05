Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB08C3DA40
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfci-0003rF-8T; Fri, 05 Jul 2024 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPfcf-0003qa-MK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:52:57 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPfcc-0004wq-SP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720173174; x=1751709174;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=f+HK8G2RyQoYr3YsuBA4YBd4FNqN0ILCUL9pnsXGAbk=;
 b=D1FVUQhhdQ7/sP66cg3WgrRIWjMyd2Jku3KW7lBeeh/nK6FOeiOIUNEn
 SsYGwjdYsj826bdTOUlqLKMr6EDz74GllpFGXLirHKqvZGGzvb68/IMGU
 QVSSp1vQPhsFJ1n1umMvrAc68nLs2w6S5xNq6yGEhva0liIJSUmHcoWjA
 ME13QVv22SeVuFtmJmiQIMblUFPYHsjADDfmv13NTODJk4JK1oHA4mxM9
 47yUAJeCnvcZmcIzXAYoM1m7Ii7SD+0bb5cbYI6E66trMHXG8k0UF0Jl7
 kItho5ODVQJPdLwhnRve9G8vB4Mk83XGogiJvKest7fM37I11wfQ8Nv2G A==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208,217";a="15955100"
X-MGA-submission: =?us-ascii?q?MDGb/yw9Quv6LbLR99rgeHR0m7jM0ub6JPvu86?=
 =?us-ascii?q?IzHr92UpJNsXL27x+rXXR0S0c/q8VjeBx0dNUwJ9q6Nm3P8oziErmpCO?=
 =?us-ascii?q?xZjXOqGm2Z8MjzMa3RUI/3q7KVsooCYgLmoM0W0oRCWr+JtpD/k7N88O?=
 =?us-ascii?q?m0E8ZeoXqQn94rbeqqAkMAyg=3D=3D?=
Received: from mail-vi1eur03lp2105.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 11:52:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQxEWhEkqigOjxQg1Degm7mcZsQFlPyfezel4V7qkoqiLvu52pUaVWl+jIDYfp2Mhr0AmaDzFJZosFwPWq8WmI7a/yhXASzqovLH+euwmjO+pOTMD08pQN0hf3ctDB2oT7NIhIt8WHbQx9PQsv5kWchratnElPyhvoEue5T2ZvCn9LrcTtE9j2XmvcFzljdhhsSht84wObh6DvCUsPUf17oLbKCJQfH72SRmePqfIrl7cyjK0PWIVExKgms1hWPqxe9XIK7ZlGgpfM+ZWL2xVFE5lDsmjRD7cxSjV4aVcbfkQLxzB2vr4VTlhgztxVTqhqQkUnBRrEasjvQZ002fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+HK8G2RyQoYr3YsuBA4YBd4FNqN0ILCUL9pnsXGAbk=;
 b=GJuY62zCsxq0CGGt1RRZcPgI1KG3nAnkVBGljLQvu3wknjewrcjsey+gS+5MLX3u6IPI+0z1ZRKtAxvPdCjjJ5VdHJhoZLWDM2dMzM5rUAzroAd6tDA8uL0gyfMWw7OOZS2rhc4xF66050fOoU8l57Df05AwmA9UuxGV7+/rjCa7vtYNB3Cs3i6dfZtGmopk/sdzOeza5qeQWP0n6A4mGJkvTiktseb1NEqRGQDkVKAIvLio+oTsUd7/DFiEtq7n3bDbEYbJ8Uuotxu5H5k4ZMczWXZLEvcQiEy3BajpbHP9dSpyd0WtgD+fGQQLe+Z/sJL3LQ+cykJo9v/gfy7q3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+HK8G2RyQoYr3YsuBA4YBd4FNqN0ILCUL9pnsXGAbk=;
 b=NdmH1x7HBPRDtcPmoGKH52S5RU3FS1mdiX8Xmr0DTJebxYht3rQSuy0CDgNENNnmOtRu/GiSC4vGzPbxFyzIKPUk/SM7LYZXZN/KqVtnoD1LjSRk2G3UoVP0pkRtvu1gJeIzjld0CWR3hClCmXWLAvvrZpKX9X/5zRngvlGvxRvvBf45d+4Wvy8e1Lrvh7tdeM83brTHSNXIXt67Szejl9yobS1024XpNxlbZEzWoVrPlmnI0qS7Ig9zQGlEAZ0BtXvgYRg6LTa8rYoW3rVxS7cvnpjCY1hOrpADrS9SbmbRH1qbi9cF5mR9vezybcxzy/tsrxz7rJE53wgLJ31avg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8044.eurprd07.prod.outlook.com (2603:10a6:20b:3db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.13; Fri, 5 Jul
 2024 09:52:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 09:52:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH v3 2/3] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHazsEXcEKOWU4UEU2pdYjTrKlvUg==
Date: Fri, 5 Jul 2024 09:52:48 +0000
Message-ID: <61d45a7e-adb2-4d45-9879-549e4a258d75@eviden.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-3-clement.mathieu--drif@eviden.com>
 <20240705045005-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240705045005-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8044:EE_
x-ms-office365-filtering-correlation-id: b0ed83a0-4c87-4586-fe79-08dc9cd83a42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlFaOTJLZURNK0sySE1nYjVneHlNODVDOFNWRXdEVnhJUlA2OXZkYi9Zemlj?=
 =?utf-8?B?SjFURVZaSkdwVHlKREdIUlRsNkxkbGVXTmxuYkM2dDJVbHRqeHlRbDR5UC9Z?=
 =?utf-8?B?b0M5R2JlWURXMkE1K2ZGV0VYeEswNFdGTE13UmNoVnluTXQrUTRabVBiT1pu?=
 =?utf-8?B?VmFITWhlUENkeFJNWjFldEZaZGthckJ5VmxTbmlOVFQ1R1RLdTNId1JpcHdD?=
 =?utf-8?B?NGFCWFZQYVlqUExFWC9WUEJiM3E3eTNLbFJaWUQ3endDTEJKWlRQS3lEOVln?=
 =?utf-8?B?aWZidkZMbFVyVGZGNVZKdmRTd29TZmVlWVp1SkMzWThZRklFOFZuQ1F6ZkE3?=
 =?utf-8?B?bVFNVTQ0aGdFUFp1ODBoNnJ2aUh0czJDQUUwYXFVWXY4eDRMTWFrNWEvZlRX?=
 =?utf-8?B?QTBZL2FiZXpwSWI4Q1Z6cTl3eXhEdWlJZVN4R1I1RDNoLzUrS3ZpMDBKZDBw?=
 =?utf-8?B?WGJLNjRtM1hqVlNrbXU4R0lXVlpRMHZERkRTeGZReUdOU1VicXVsdmlIRSs4?=
 =?utf-8?B?Umc4R24rTEhyNGJ5N0ZEUEgvSzJaei9tK0pKN2lXOCt5STgyNU5ZNFNKbWdJ?=
 =?utf-8?B?azduSXhJZG9NMkVSU1BkZDRpQ3VMbjRKelhMbDV1cDBLbjZvWUd5eFd4eVRD?=
 =?utf-8?B?dC9uYTUvTTRzbEVvYWhPSnJuTE5IdXMzSzdMY2hUNXJ4Q1dZNnBxZEh0SnR5?=
 =?utf-8?B?Y25DanNnR3ZTZDVmbFJKcmFWVEZ5NVA1YzJQN21VMHg3Z2pvNlQ5TG8xU21R?=
 =?utf-8?B?d1BqRHNsNnVOeTVSTWVYNzZwWmlDMDdGOWlPNEdZS0QwZXgxaWJ1bjFkY0c0?=
 =?utf-8?B?NHNQUjJyVDFHcHFSaXFpSE53blRxQmNNT05BZG13MmNuOExpcXViOHpNeXhw?=
 =?utf-8?B?V01mL3JVT0hIMGxhaGowYjkzWm9vSjNaSGI2OXFwN0VJeFlIV2pOMGsyTDVP?=
 =?utf-8?B?Z05vbnRWZkl4NkhFV2RaZU5GemdaTHhQSjFEaXgvN2dldHFUbllpUW83SDJ2?=
 =?utf-8?B?R2VSVWtZRW1GeG9xQzFvT2dqbmhnckZ5VEJQUU5xN0VBSTBxeFRUYWlpTzFq?=
 =?utf-8?B?cEJ2WHFMUEZrSHBUQzBKdEZUNXJaM21Cdys3MnYyTzNDd0VuQWtaYXNJNVlj?=
 =?utf-8?B?QWpJaTVsMlBBblRXQ2pFbXBrZm1FNUtGY2h6TEF5SjhmRHNocUZLOFluTTlm?=
 =?utf-8?B?YkVwUlU3ZW8zM3ExRXlyV1BLSHk0YWxtT1UxblpHMEYzdHRZTnFGMG5Ed3hM?=
 =?utf-8?B?N2RzZGs4Skt4WkFUcVQrcHh1cWlob3QvOUN1R0EvRXVHNWZFcWVMOGpwQi9T?=
 =?utf-8?B?UXVhMHZ5SVFldTN2S21sc3JFTGk0cmhYR3M2K3NVN09ieEx2aU5qaUV2OXNH?=
 =?utf-8?B?UnF4ODMwTGpBbWVTR2JsM2ZNWE9jTUcvL1YxRjltZDhVVVFtczF3S0M1am9a?=
 =?utf-8?B?cTVVN255VzNUR21CRW05MFFHdGtjNEhoUFRDNVNhMGpqNUNNTGpkMXYvbGRP?=
 =?utf-8?B?ZUIxSmtQUVdrYzIwVTRVeTFLeFgvUFFjblJGVjdFU3d0RGdPTjFjU0VtM3Nu?=
 =?utf-8?B?aWpudEZSeGk3V0REbEJvWk13SmdPVUErVmlOSW9Oc0djRTF1by9tTHpIQnph?=
 =?utf-8?B?VVRRbCtOTVJ5ZWxROHI0UUdnaENsdFN2OEVPenN1bzBTczMraWs5c1ByTFNK?=
 =?utf-8?B?c2R5OWc5VW5sNkFRRHYwYmo5ampvYkUwV3JITVljVy82TldmM0xEZFdORytG?=
 =?utf-8?B?bUJJaWdGdUlFTmlYVVBFdjRoRHd5ZXdXZkVZaG1BNEx2TjVoMHUvaW9BemFj?=
 =?utf-8?B?ODY0YlR4SjNJMTZYck93cithU25rakVDZkJYNUtqbnptcForUUdYblVMc1di?=
 =?utf-8?B?OWpQbE93aUY0c2I4YXZSUC8rdTVZbDY5NHcvZ3UzVFhDN1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnlyY054aW02WklFaW5jRUNJTnAweG8vRjlGVHRTakFpdldRNTg2aTFENmhW?=
 =?utf-8?B?MWE2akRpS3FMSGdXWVlkOTgyVDlxVnUycVdsdXNtUURQNmJjd2c4dFZpR3d1?=
 =?utf-8?B?K1RYVmQ2WERwaW4xU05RZFI5eTFEdVkwVUlTeWlwQXBucHlpWFBiRGFUai9F?=
 =?utf-8?B?SmMva0Y2KzdnbyttSU5XTDM5VnN5d3pXRjU0UmpQeUIydzVabXgzL2dILzM0?=
 =?utf-8?B?a0xmais0RG9sWWg4MVpKTWdwYm5Hekk5SnhTUkRHeisyKzUrems0WDhPcW84?=
 =?utf-8?B?ejN0WUJIWStvRG9EQ1V5NHgxR2hPQU9JNEo1ZTEydTBpckRlMUVFV3RVMisv?=
 =?utf-8?B?Mkl0QzA1MDFkVWpUcE1HYWVkNEdLckFXRkNHSndZamMyMnFXZnZqUHVNY25q?=
 =?utf-8?B?c1VyVTY4OUZFSzhHdXVBTFJ2Ry9tZk13T0s2ZnRtU3dpL2hFZWU5aFdxZndu?=
 =?utf-8?B?Q3cyNjlxM2hUaHlQUExaK2w2NERLTkh2WGphRkJwSzRtaWlzQjl2MFY0Nzlu?=
 =?utf-8?B?Vjh6ZkF6NVM2cUl2ckFTNDRtdzNPMGI3WkJYVmFjTG44T0JuaHdKVkdhRWU1?=
 =?utf-8?B?eVBZa1p6emFzeU5OTzMxYU1ncGVuZmhkZHRCRG9ZZ21admhOb2U4aFBhQzNK?=
 =?utf-8?B?WWVsTk5FOVFBdTBtZnAzYjIybXpCQzgrNjdBWGRaazlneHlaTGxMNTFzazlN?=
 =?utf-8?B?aWlCL05HaXE4OW1wMTJBTENiaEM4RmQ3a0ZuSUVTcVFIeVgzRHN5VEhqYTBl?=
 =?utf-8?B?d3NJSjFnTWFLZ2M0TC9SOXh6dkNOSEJFVjdMNEx4bnFIRG4vT0orQjZSN2FO?=
 =?utf-8?B?ZVg2dzJoOVRSaGlUTXJFWHVHd0gzanR5a1lHRGN5N1V5RlA3dWliMlZ2aEta?=
 =?utf-8?B?NWsvV3U2bEMzcWZ0WFVKcEt2QVRWV1Njby9sc1JNQXdxSjRIN2NISDI3WDdi?=
 =?utf-8?B?SzErRGNSWURaRWVLSWZ0U0FHcHJ6SmRhK3NxcVhBbzVGS0V3V2wycGY3eVI4?=
 =?utf-8?B?bUhSdW9mZHR3b0RlT0RSK2hTbU5QUkxDS2ZDY09GUHlRemdSSHVycUVMSjk4?=
 =?utf-8?B?QVFFcytxSnFNM2Q4UTAxNWQvTkNVano5c29MMjNtZHJaMHVlRXg1TkNkZlU5?=
 =?utf-8?B?c3JRVDJUS1pYQWZPVDMyLzNHSm94SDZmRjY5VXdhZDZMMEd3RkhSWHFVTllQ?=
 =?utf-8?B?NFRZOWl4ZVFtKzBpS3RRb2Zxc09vRk9udi9LU1FET1ZYT3pLOW5zUmdmT04v?=
 =?utf-8?B?ODhPdThvaXNib3hYZjNIdG11SnRqVk54N2dIY0lrOTlCQkJ1eXVQYldFYys1?=
 =?utf-8?B?SU0wbExCQXQvUlNTQ2JRTThDektuS0tNei9va1pyTWxpTlF2d21ZUFZSb2FB?=
 =?utf-8?B?VmlEcEZvT3hVazdzV1ZncVBTWDhtKzhxNkFrcWZPOXBSY0hCY2JnRkhoQjFn?=
 =?utf-8?B?MWhSNkVjS2FTQnFrOHFKcm8xRy81TlhpUnErbWxyU2RLRTRZSmF4bE4rNVRw?=
 =?utf-8?B?QXFYSUlOeVVTKzFEczlkaFF6RWJFMm9SN0g4bEhDeXF2QjFqekQ0UWYyMGVR?=
 =?utf-8?B?MmhTNmNzblZEeDBocUROeVNLcXFuWmRhZUdER0NDVUQ1aDJCbXJRNU82Rzla?=
 =?utf-8?B?T254a0tLZUpyNW02bVZqYUlpNnA2Rk9aQzU3TEh6bFZDRS8xZ09qRUxKd1Vo?=
 =?utf-8?B?RUdpbUdhQ1lxdE9aV2M0L29jMVZ6a3JDWVd5d3ZsM2IveTNjVUpzMkNzaEVo?=
 =?utf-8?B?ZWNsWHJOL212YlR5a2tRZzR5WG9tRTBRNVRpY2g4RnNqd2F1bmZRR2lLMzl6?=
 =?utf-8?B?NHJuNGkvQXFrTTF5UEVQcXNOZDlkS3pKMCttU2Ria21iek1JUE5wbFA5U2dH?=
 =?utf-8?B?eVB1MEUzNDJkMkx2MTc2Z0lWdXdTUUhFNW9TYWhhWksyNHVHa2xiMFdPRWZh?=
 =?utf-8?B?aGNyU2ZPc2hjVGNjZEk5OHQzYytTU2ZhYWVOeEZEczlUT3hNSXFvaGNHcnFx?=
 =?utf-8?B?alBtR3B2bk1vTGxTcDAyMVZla1VzTHY1cGNvbjB3Y002ZzRXT0VNRkZjdzI2?=
 =?utf-8?B?cjM4NVI3NDBJMTdXR0FZSEdrcHZ1cjJWbm5Gb3FMWWp3aE9JakJ5TGlCdjBv?=
 =?utf-8?B?dnpha0RhV3dQRjF1RkVQMDNiUFVsSk9sdGFsQ0h1dVI2R2trUDlRZEhpV05w?=
 =?utf-8?Q?i4DIAHqW3Ic4KLgMq5+L8qM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_61d45a7eadb24d459879549e4a258d75evidencom_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ed83a0-4c87-4586-fe79-08dc9cd83a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:52:48.4035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hK3goRqh/m710TY3RgdujyI1NiSc0vsRGAESR4cRgEdnHRZI6xrjXTl99Qw3wPLBojk95QAZE8e4F7NPlWLugUT/jPl5W/QBEpRwweVepykRHmkekt0qXHXjrEKGgGBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8044
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_61d45a7eadb24d459879549e4a258d75evidencom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk9uIDA1LzA3LzIwMjQgMTA6NTEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCg0KQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCk9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDA1
OjAzOjE3QU0gKzAwMDAsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCg0KDQpGcm9tOiBD
bMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT48
bWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KDQpWVERJT1RMQlBhZ2VJ
bnZJbmZvLm1hc2sgbWlnaHQgbm90IGZpdCBpbiBhbiB1aW50OF90Lg0KDQoNCg0KSSB0aGluayB3
aGF0IHlvdSBtZWFuIGlzIHRoYXQgaXMgYXNzaWduZWQgdmFsdWVzIHRoYXQgbWlnaHQgbm90DQpm
aXQgLi4uLiBpdCdzIHU4IEFUTSBzbyBvZiBjb3Vyc2UgaXQgZml0cy4NCg0KV2hhdCBhYm91dCA6
DQoiVGhlIG1hc2sgc3RvcmVkIGludG8gVlRESU9UTEJQYWdlSW52SW5mby5tYXNrIG1pZ2h0IG5v
dCBmaXQgaW4gYW4gdWludDhfdC4gVXNlIHVpbnQ2NF90IHRvIGF2b2lkIG92ZXJmbG93cyINCg0K
DQoNCg0KDQpNb3Jlb3ZlciwgdGhpcyBmaWVsZCBpcyB1c2VkIGluIGJpbmFyeSBvcGVyYXRpb25z
IHdpdGggNjQtYml0IGFkZHJlc3Nlcy4NCg0KDQoNClNvIHdoYXQ/DQoNCkkgdGhpbmcgdGhlIGZp
cnN0IHBhcnQgb2YgdGhlIG1lc3NhZ2UgaXMgZW5vdWdoLCB0aGUgaXNzdWUgY29tZXMgZnJvbSB0
aGUgZmFjdCB0aGF0IHRoZSBtYXNrIGRvZXMgbm90IGZpdCBpbnRvIHRoZSB0eXBlDQoNCg0KDQoN
Cg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLWRyaWZAZXZpZGVuLmNvbT48bWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQppbmRleCBjYmM0MDMwMDMxLi41ZmNiZTI3NDRmIDEwMDY0NA0KLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCkBAIC00MzYsNyArNDM2LDcgQEAgc3RydWN0IFZURElPVExCUGFnZUludkluZm8gew0K
ICAgICB1aW50MTZfdCBkb21haW5faWQ7DQogICAgIHVpbnQzMl90IHBhc2lkOw0KICAgICB1aW50
NjRfdCBhZGRyOw0KLSAgICB1aW50OF90IG1hc2s7DQorICAgIHVpbnQ2NF90IG1hc2s7DQogfTsN
CiB0eXBlZGVmIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIFZURElPVExCUGFnZUludkluZm87
DQoNCi0tDQoyLjQ1LjINCg0KDQoNCg0KDQo=

--_000_61d45a7eadb24d459879549e4a258d75evidencom_
Content-Type: text/html; charset="utf-8"
Content-ID: <70E0CC38635ABE4B8CEBB23CEFAE3686@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+DQo8aHRtbD4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVu
dC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPC9oZWFkPg0KPGJv
ZHk+DQo8YnI+DQo8YnI+DQo8ZGl2IGNsYXNzPSJtb3otY2l0ZS1wcmVmaXgiPk9uIDA1LzA3LzIw
MjQgMTA6NTEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTo8YnI+DQo8L2Rpdj4NCjxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiIGNpdGU9Im1pZDoyMDI0MDcwNTA0NTAwNS1tdXR0LXNlbmQtZW1haWwt
bXN0QGtlcm5lbC5vcmciPg0KPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj5DYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KT24gRnJpLCBKdWwgMDUsIDIwMjQgYXQgMDU6
MDM6MTdBTSArMDAwMCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPC9wcmU+DQo8Ymxv
Y2txdW90ZSB0eXBlPSJjaXRlIj4NCjxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+
RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8YSBjbGFzcz0ibW96LXR4dC1saW5rLXJmYzIz
OTZFIiBocmVmPSJtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20iPiZsdDtj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbSZndDs8L2E+DQoNClZURElPVExCUGFnZUlu
dkluZm8ubWFzayBtaWdodCBub3QgZml0IGluIGFuIHVpbnQ4X3QuDQo8L3ByZT4NCjwvYmxvY2tx
dW90ZT4NCjxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdyYXA9IiI+DQpJIHRoaW5rIHdoYXQg
eW91IG1lYW4gaXMgdGhhdCBpcyBhc3NpZ25lZCB2YWx1ZXMgdGhhdCBtaWdodCBub3QNCmZpdCAu
Li4uIGl0J3MgdTggQVRNIHNvIG9mIGNvdXJzZSBpdCBmaXRzLjwvcHJlPg0KPC9ibG9ja3F1b3Rl
Pg0KPGZvbnQgZmFjZT0ibW9ub3NwYWNlIj5XaGF0IGFib3V0IDo8YnI+DQomcXVvdDtUaGUgbWFz
ayBzdG9yZWQgaW50byA8L2ZvbnQ+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBwcmUtd3JhcCI+
PGZvbnQgZmFjZT0ibW9ub3NwYWNlIj5WVERJT1RMQlBhZ2VJbnZJbmZvLm1hc2sgbWlnaHQgbm90
IGZpdCBpbiBhbiB1aW50OF90LiBVc2UgdWludDY0X3QgdG8gYXZvaWQgb3ZlcmZsb3dzJnF1b3Q7
PC9mb250Pg0KPC9zcGFuPg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2l0ZT0ibWlkOjIwMjQw
NzA1MDQ1MDA1LW11dHQtc2VuZC1lbWFpbC1tc3RAa2VybmVsLm9yZyI+DQo8cHJlIGNsYXNzPSJt
b3otcXVvdGUtcHJlIiB3cmFwPSIiPg0KDQo8L3ByZT4NCjxibG9ja3F1b3RlIHR5cGU9ImNpdGUi
Pg0KPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj5Nb3Jlb3ZlciwgdGhpcyBmaWVs
ZCBpcyB1c2VkIGluIGJpbmFyeSBvcGVyYXRpb25zIHdpdGggNjQtYml0IGFkZHJlc3Nlcy4NCjwv
cHJlPg0KPC9ibG9ja3F1b3RlPg0KPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj4N
ClNvIHdoYXQ/PC9wcmU+DQo8L2Jsb2NrcXVvdGU+DQpJIHRoaW5nIHRoZSBmaXJzdCBwYXJ0IG9m
IHRoZSBtZXNzYWdlIGlzIGVub3VnaCwgdGhlIGlzc3VlIGNvbWVzIGZyb20gdGhlIGZhY3QgdGhh
dCB0aGUgbWFzayBkb2VzIG5vdCBmaXQgaW50byB0aGUgdHlwZTxicj4NCjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIGNpdGU9Im1pZDoyMDI0MDcwNTA0NTAwNS1tdXR0LXNlbmQtZW1haWwtbXN0QGtl
cm5lbC5vcmciPg0KPHByZSBjbGFzcz0ibW96LXF1b3RlLXByZSIgd3JhcD0iIj4NCg0KPC9wcmU+
DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4NCjxwcmUgY2xhc3M9Im1vei1xdW90ZS1wcmUiIHdy
YXA9IiI+DQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxhIGNsYXNzPSJt
b3otdHh0LWxpbmstcmZjMjM5NkUiIGhyZWY9Im1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbSI+Jmx0O2NsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tJmd0OzwvYT4N
Ci0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KaW5kZXggY2JjNDAzMDAzMS4uNWZjYmUyNzQ0ZiAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
DQpAQCAtNDM2LDcgKzQzNiw3IEBAIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCiAgICAg
dWludDE2X3QgZG9tYWluX2lkOw0KICAgICB1aW50MzJfdCBwYXNpZDsNCiAgICAgdWludDY0X3Qg
YWRkcjsNCi0gICAgdWludDhfdCBtYXNrOw0KKyAgICB1aW50NjRfdCBtYXNrOw0KIH07DQogdHlw
ZWRlZiBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyBWVERJT1RMQlBhZ2VJbnZJbmZvOw0KDQot
LQ0KMi40NS4yDQo8L3ByZT4NCjwvYmxvY2txdW90ZT4NCjxwcmUgY2xhc3M9Im1vei1xdW90ZS1w
cmUiIHdyYXA9IiI+DQo8L3ByZT4NCjwvYmxvY2txdW90ZT4NCjxicj4NCjwvYm9keT4NCjwvaHRt
bD4NCg==

--_000_61d45a7eadb24d459879549e4a258d75evidencom_--

