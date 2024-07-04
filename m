Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53281C3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPO8m-0005Wo-CL; Thu, 04 Jul 2024 11:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8j-0005WC-PM
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:12:53 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8h-0002sV-MN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720105971; x=1751641971;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=8WAHgPd4K0C0myyBl1FU6IKE7U1LIPQnk8KbC9Ip/sE=;
 b=UEFLaQM4RoKnbGmi12VxZDkaokmox7mN/C8CEo73B6vfwMvsB7b93MlD
 TZ+pbLxUDLPCjnDvJM3YXllsHjPEaY+uO0SGsFhw76QyUUJ+sMmz2lr0e
 2IXGMn/KYiWxLJa07injR02hGS/P+YyPg0YhyLF9fBqWIm3LbWZiRf4Bi
 wNgyCZbYVbqTcrdUhmURxeg+xGOO2K+n0NSQMdr3pg97oEugmkNsTI3Xu
 XIGJK0+jJCRbmFrX8CN0h15PTI9JMFFCmgEIGqw3k5qOda/yU0JZiLvxD
 6dFLwOH2DGk3bBFNmD3Fza6/GDkQB5zPDKUGvvfLgpdZy17dy7ryUAe2K A==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15910924"
X-MGA-submission: =?us-ascii?q?MDGlQGXZfBj8m2Vpy02m4MlnZGFBzjmf1Ex+lB?=
 =?us-ascii?q?Oz3jxKoWMI9hH3eN1yU/Q9KhXqTcLRBHA83kvQ863D88Yi/IJJLX4pzK?=
 =?us-ascii?q?Nton++XyJyBeU54p4+gyd0OaKCHH2t+/keysiTuD4dk0td3iSMgq286f?=
 =?us-ascii?q?qHcs3MMPcGJYk2r12ClQfUmA=3D=3D?=
Received: from mail-db5eur02lp2104.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 17:12:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeVHItMOo3VOzptFxOwG8tOYZfzNsLYjtbDAMEcvCdMonujIZttqeGA/iTyooPuaivRP/cGuSx2VeTaQF69aCd+v2PgOBOBgGwyPSCcq9aXGyDoCkgKZnJnMcMUK5Q/+kLLCd38OtlI0ECTvmZG5ZG1kDiy54pwV3a90z3GNES2sdN9xz9psvl1eCa9N3sH+h7IlflL2MvIHmWUmG4Owsi41AB2keNt2fI1OsT6tBUtSHicRL+hM6Xl7wTME9+QjvH9XL+dOp5f4DwBuarCBsgFfT6dwrmIuTdhSQV6q4s0WxDf7dcx3WxqDo9tDmUa2Boc4XxcIceVHdslkf1m/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WAHgPd4K0C0myyBl1FU6IKE7U1LIPQnk8KbC9Ip/sE=;
 b=YgA9YSwZKOzZrFapQtzAhWgveZM7zSCzJR0CRo+nHw5GaJAe8AHu4ZN2TR3AJSTJnB8b1vUt6pf15UAwJ+fA3oJnKLhjwp9TtIepQTNoYq/jIrJs2IdKb7VBPPLYAwDmwgX+USyW89kxS2uF45VHRXKakN5hrwDIPUlhvaBSnGH4xalnwbBaHU8u2plAlm66QGYSDp0r5mEPEEBj54s78bMnxUYAw/qezT+JH70J0a0d9ddIvc5gETqcXHkHWy1NbDWaIngx7tya8yEVUDbOwswI1Otl/SeqM0BFS03bNkylFkHxZ5tyRj+XDu59oAgc1SKDlwZ/abD6qeMRV/87bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WAHgPd4K0C0myyBl1FU6IKE7U1LIPQnk8KbC9Ip/sE=;
 b=OrwIG1UzW2b/K2rIC2wkxwVYu9ejEixGyPuItL8452oGynhxsfigOjXCVj19FirkuXu6NHYYnXugKaBiVnuu1RuFXkLOEEqO1x+s8g0W6uMwVQGhTZ/EmtNHvDIUMXfkSqdTqAP87OpI/ebcvaSLzZ/a9/5eU5tjz1oVRoaMcc23kjfNI+PrumE+dATs8L6qSK2BxoCI1GXfipp5d+0WtP9j+byQuMbvQVOoVErEJwZdWwKbuzfSTmmNlgcN8qXYpeYMzjhG9XJTd1/pHiYi0h88T5AMCRuFSYtYG4zQ0XjLV5v7yr48q7D612+radvb1eaYcfIEanciuEYH1OIFpw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6455.eurprd07.prod.outlook.com (2603:10a6:20b:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8; Thu, 4 Jul
 2024 15:12:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:12:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v2 0/3] VT-d minor fixes
Thread-Topic: [PATCH  v2 0/3] VT-d minor fixes
Thread-Index: AQHaziSggzEkYQkwAUCS1lecRxxC7g==
Date: Thu, 4 Jul 2024 15:12:46 +0000
Message-ID: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6455:EE_
x-ms-office365-filtering-correlation-id: 8a7af9aa-f4d7-475d-ead3-08dc9c3bc2a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MnZoRkFpTEg1cWpJb0pZTDl6UTNnNU9zZnljZm5sMHVjZU55T0FzRUZvTUhu?=
 =?utf-8?B?dG8wVUtQU3p1VmlOTE1MamUxTkU2VCtWRVlTK2M3MU1sbktza201SzNxQXBR?=
 =?utf-8?B?Z1JENzNvU2VvTmtTREdLbTVnejYxckFnSUFzanc2ZU8zdm51OE5Xbm11MHlu?=
 =?utf-8?B?UWNKVDJnWEdubi9wN05WNVFwLzVIUVVXeUNJakd2Y0h3Y0VBZE5aQjN6OFFn?=
 =?utf-8?B?SUpzV0M4V3FNeUg2eW5iWStCWTR0WjNLdEloUFdGTUZkdGVZTFNZNzdFV2xx?=
 =?utf-8?B?THk1VTFIS0hoVW9RckplWXBHYVFFTG52TEZ3QnJtc09zZFBtWGRlM0xxWERt?=
 =?utf-8?B?R1BUQUN3bWl2NkFuNVpScW4yWmxnajRJY0Q3akNSTnZBWUJ4MUZIRHpOM25u?=
 =?utf-8?B?UE41Y2U5VUQ2V2Vrb1Q2Q3pIREtVQVlRV3hBWWtmSTIrRGVYdCtkUXU3UWkr?=
 =?utf-8?B?Z1QzV1ZzaktVdmF5VlU0RmJXMFZvbGJveGZacGgvd3lkSSt1Q01NVzdLaUhw?=
 =?utf-8?B?Rkd1TVRlYUdDeExLMTZEWUlFV1dmQ0Jrc3J1dlpsMkNMODFsSndLNzdZV0lN?=
 =?utf-8?B?MjkrenRlSUhvS3hhbEhCQWo1K3N4M0RZU0JuRGN5YmVhSEhFRHBsd21uRVBE?=
 =?utf-8?B?K2hDODRlUGovLzB3dGdyc1o0TzBtTHNxcWxBYktsQ0JuUjhEeDFFOVZqblhY?=
 =?utf-8?B?MFNUSGxESW5xWVJYQitIYWF0V2JEMWhJUTB1M0FoZ2U2Q1lRU1dydGxkVkRD?=
 =?utf-8?B?dDUrWFFlWGtEVU14TzJlcGhxdWxSVjJRKzc5UUZZeDdhenFpWm9PL1ZIRjlo?=
 =?utf-8?B?ZUtEaythUWI2QUg5dUJHOUtIVFd6eXh6SklWN3ArVFNOSkt4TDl3YnQrQ0hh?=
 =?utf-8?B?YlAzSmFHVXc2d1kxZ3V4OWxwMUQ2WEtaekN3emtVdDdkcks3Y2xmaUIrZEJV?=
 =?utf-8?B?L0E5ZTg5eEN5amNlMHRvdjY5d2RNR0s1N3I3UEY5UXBOV1JDdUtzNDMwbkM0?=
 =?utf-8?B?UXBOU0loRDduYUlWb1Y3YW5JMG55ZHhoaDIwdWdXb0o3Q3k4UzBnMys3NFZ6?=
 =?utf-8?B?cERDbzRZb3ZuV2JEYWdYSGJBTXNUQ3daUnJ0WEZRY0FUYzltOURMTEd3aEZi?=
 =?utf-8?B?WVB5UlhuUW1sc2I4OUFScDlkQjA0Nk5tNmJDQU4rVzUyL2kySGp2eDNuMWhh?=
 =?utf-8?B?UkdHdXhtVUViUERlQzA2TmJCQ3FnZDNDRzM3eEsxS3l0Z2QzcDZDUmJ1ZTJ2?=
 =?utf-8?B?R2pvcE1SQVhGa2NHZXhZTHRoakZuQU5XSzFpcDEzM3pWQ0F3cCtBNWR2SGdJ?=
 =?utf-8?B?cm9pT1lXWkZGQkp0YU83Z1kzbVVrUHJ6b3d4SVY5ZjJWUzNaOHhFK3JZZ3pi?=
 =?utf-8?B?TkhZam1Mc0puMmovYnNYZTBrNm1uZVowNkp6akF3d3FmOFltVFBFMkdOeE12?=
 =?utf-8?B?QndaRzVFN25NbEplOXkvdU52Z0dkYnBxMVp4K25tR1BUc3pPckltNlp6dk8x?=
 =?utf-8?B?SWRBYllmMmJaR1RrcUIxS1RmbmVBa0ljbllCOVQ0dmVseFpFWXMwMWM3TCtK?=
 =?utf-8?B?b0JzbUlCbklsQ09NbngzUlg4VlJXN2xYUVpDVDA2UUVueDJ5NThGSjREdlZx?=
 =?utf-8?B?b0ZaMUZReEdOMkJSQTZGdjBkMXVibi93OTJUcXE1RXJFdjM1U3dpMU5SWlpu?=
 =?utf-8?B?QzJDWkg4N2dSWlVTMjgyZW9vckoxYkVPRjV6VzlhYjV0WjRHWloyaW1la3l6?=
 =?utf-8?B?d0R3T29XVXFEQUlsa0pNZkFtSXkyT2RpaDBUWjB1NVZDZTJnZFlKVVpINE5x?=
 =?utf-8?B?bmhkM1FUSDA0QkZjQXhZWFJCOWpFVGd1cjZrWDc3c3pYa3pxSGFCTGN6Z015?=
 =?utf-8?B?R3g4SmJTbkc2MWM5d2doUkdJUjRjTTFVazFrTm8yNmd1ZHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXB1bkt6V01Vc0t2VG1jOG1sWUtRSkdlcTVMdXZSdzJpS2FhS0VlYWVRMjFV?=
 =?utf-8?B?dDA2OG1EZkVRcHBrZUZyRUV1K1c4OXZqSkxGbE9rdnlUUkZjVnhwa0ltcWdM?=
 =?utf-8?B?bXlaTGg2allWZUs5ZERFVG1hdlhMR2hOS3N6d3Jad0R2OVh2eGdiSS90UmtX?=
 =?utf-8?B?L0lFRUhQVk1zOGVhaDZ3V1M4OXk5WllUQ2xTRnVoc2g2dlFVRXVLYzVXeXZz?=
 =?utf-8?B?VkgwQjNnVU8zOWE3UzIyL1J2OGQ3eUFTYmRsWlpZUXFjWktSV0hYKzcvQURC?=
 =?utf-8?B?NnhqdEtzcTJudk50WE14VUdxWnRmcGptZ1NnTDA3YTZGREV4VjVoRUg1Rzg3?=
 =?utf-8?B?dG4yMjBvZEdleUFBVy9lNmdhL2wreVVPUytaVVZsUURFSlVlQmF5OXhrTkdk?=
 =?utf-8?B?cEJsczJTTXhSUXlyQytKWldvcEU1VHJrbFptSTI5QmQ4d3VsR2Z0czdwVHd6?=
 =?utf-8?B?YnlSUU1XK2JLUUhPMktrTGltZ05DRG1DbFdFK2pBamxKV25zcXpTMHFrMTRm?=
 =?utf-8?B?ZjN0dHJXVkVIUHFRQzB3c2Y0Vm1yZkkwVk9nTGpScW1pWHFyTHdlcDhWSkhQ?=
 =?utf-8?B?eFc2Vy81b3lLNXQxSFIzSXArTDBTUTFwWnZ4QWlkcFJ4aklMS2JQUXNRbTMv?=
 =?utf-8?B?U1EramFLSG1YTW92ZEhJeU9nY0phdVB1bVJmcWZ3R2hEZ09YZW1SQU9QT0lw?=
 =?utf-8?B?eHNZVTNCNFlYbTB3akRKYWhKanFpbXJVRUZwRW9MeU5VbUlCLzRIV2tUcWxy?=
 =?utf-8?B?QTBiUEV4eEhSSWJyRzRSQmFEa0tmS3RQZEVhK0gyRGFEdXd5T08vczZsVm1x?=
 =?utf-8?B?NWltelJwT0RLMktMenNFMVN2cFNrYU0wUGZkVjBsR2FxUUNVRHhJZ1lBbkZX?=
 =?utf-8?B?Z2IwemlmQ05WK1JidUVCbTJiQkRtM1FBOW5FMUdNVmx2WGprTTJxME5NVW93?=
 =?utf-8?B?VWk4VVJiTUpqbzdteDkyaStxemNSakxCWVFVajcrb2dMenpiYXhLT3pNNkFO?=
 =?utf-8?B?SC9mMkw0Vk1zT082b2FVWWEzZ1FpbUlzM0Zva2JTZEtlOEpDSDl4bzVTdk1z?=
 =?utf-8?B?bXZXdGJ1WFUxMDZiYmlyeFlxOEIyM1hLRk9NN1o0WkhNN0wxd0hzSyt5Z2pp?=
 =?utf-8?B?VGFnWUkyY1p6b3JCTWJ2UThIY2ljMVZ2T20yRHJvNHBUeitaa2NpRHR4ZzRC?=
 =?utf-8?B?eUpZVkJIR1FIKysrZWFaSXIrL0JqRmYya3BQTnZQdXZ6djJTN1Jld2xRaWEw?=
 =?utf-8?B?WE5CQllMczdsT3pEeEZjUmZRZ3dlQUlBYURPUEdiQjN0SjNkZDVVeWVoU3Av?=
 =?utf-8?B?dW1pUjdSdVhaMWNTUzIyc2JFQVZxMmgxWHJ2VWVqZVQ2ZWl6K3oyV1JUbEJv?=
 =?utf-8?B?Wlp0VE9BNCtOSGFJUzFrQXEyOVhhKzZNdjFoU2E4Q29maGhoSjdFOUYyQnFn?=
 =?utf-8?B?YkN5R3ptNTRwN0ZZekFzei9TUFp6aExhMnJBYSs3OHJtK0pEZ08ydW9OOGVo?=
 =?utf-8?B?M3A0UHI1cFllN1JCdDBzTFlOUXpFSGZNbUdwazNWc1JYT0lBMFN6V1dDeUlt?=
 =?utf-8?B?cDF2ampxMEo1OWIxZ1pkSStBNVV5SkZMMFhzMFd0Q2ltM1BJSU5WSXZzdGJ2?=
 =?utf-8?B?VFZYZ1pZN2F3bkdVUGdISVZqb1VCWU00T3ZKVVN0OWVUbFlNR0VSQU9Rd3BM?=
 =?utf-8?B?WTZYYWhCMU9NdkJwTmZlcFNISXhBOXJFbHdzYithV3JHSktBVUxmbUVGOEZG?=
 =?utf-8?B?RmEyYlhIOVFUTGIrV2E3YzdlOGJ1YUV6WDBJa3BJMm00Q0hBNVBqazNrS0gz?=
 =?utf-8?B?MzRmZFhIOU84eHowbDJPNDI1NVlZVXBjSFg3RmxpSDFNdEFtYXJ0SjA1SHBV?=
 =?utf-8?B?bjBvWEVWNnozdjZEeVV1djMwNGtyL1llUlk5TjhLcm9ncVVlZHhwYkl0VTdW?=
 =?utf-8?B?aG1nUzU5anJpd0k4SUZOVVhMd0hHWHluWmx2QkV6WjFkNGpQTmhpY2toaFor?=
 =?utf-8?B?ZE9IY1B0YXNmNDNkeGZ6dmQxenRhTGg3Q1gwVHYyLzBLbW1aZ1VnaXZmeG5N?=
 =?utf-8?B?Y1IreWNMQlFsSENpeU96U2hZY1FUK3Z6VDVITGFEaHlkZnpLWmVIWEZZNkYw?=
 =?utf-8?B?aithV2VRWXp4YVlmSlIxdFBCS1VDWDJpTlYwYk5sbnREY3NFWXNFZEE5dWRU?=
 =?utf-8?Q?1Ktyf/lh8cbxvKZ36I15R0E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9A23A742E89BC45BECC478F0ABE20E7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7af9aa-f4d7-475d-ead3-08dc9c3bc2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 15:12:46.1755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3+7tp2dlsJhtgI4AOUjs+DblsZ7zvwmQVgdTVjfC47IzhWcEKWWa019QTxmh4GMWhozvf58dObbIxGfbB/a//hJxDG2EdqEublwbknfCaR54q4+Rwj6uOq5eH+vu3zt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6455
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClZhcmlvdXMgZml4ZXMgZm9yIFZULWQNCg0KVGhpcyBzZXJpZXMgY29udGFpbnMg
Zml4ZXMgdGhhdCB3aWxsIGJlIG5lY2Vzc2FyeQ0Kd2hlbiBhZGRpbmcgaW4tZ3Vlc3QgKGZ1bGx5
IGVtdWxhdGVkKSBTVk0gc3VwcG9ydC4NCg0KdjINCiAgICBNYWtlIGNvbW1pdCBhdXRob3IgY29u
c2lzdGVudA0KDQoNCg0KQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAoMyk6DQogIGludGVsX2lvbW11
OiBmaXggRlJDRCBjb25zdHJ1Y3Rpb24gbWFjcm8uDQogIGludGVsX2lvbW11OiBtYWtlIHR5cGVz
IG1hdGNoDQogIGludGVsX2lvbW11OiBCeXBhc3MgYmFycmllciB3YWl0IGRlc2NyaXB0b3INCg0K
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDggKysrKysrKy0NCiBody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggfCA0ICsrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjQ1LjINCg==

