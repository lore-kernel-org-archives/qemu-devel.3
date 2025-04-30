Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A3CC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA71e-00052n-7u; Wed, 30 Apr 2025 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA71b-00052X-Id
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:58:55 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA71Y-0003nN-Mm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1746017932; x=1777553932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=aZ2z00B5OBh1MhDXL7/RcpFxwdjCyIZmAb0sabQl/og=;
 b=DlA+y3W6acZfQ4eTvm8dlQx4YVOGTflqLxKktPD7JJNodHNtvraFrttD
 /9h06jxgFb9W/3b9M7FHnvfZ5snO4HZmhaWPbCmpiMWIjsn9v/UbLP19P
 xjNYN6g0hzsMSCBNlOu3S+LQUdhfFi+xg2gfx1VxOYeul4y70k6Hyd0NA
 AOLf9T+GhAectjL8Be4mJ4bGxL8aI6Q09xIw85ouSLKXbI5stfKKN6qQq
 KF/Tzgu3+723GTs1f6PungdioGhDRNrC5wRNz3OjMk3MM2EXu3ULSWfuC
 x60UGs00/m5sytePzjnfFE0rd8u5TxqXH441Al+Qj55Sy0VyTVdcVNj2c g==;
X-CSE-ConnectionGUID: XxfaSAmlQ0WE3fnqdqG+eQ==
X-CSE-MsgGUID: RXVz+/gjQ0eRmMYBI0bCJg==
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; d="scan'208";a="36008517"
X-MGA-submission: =?us-ascii?q?MDELaBwha8pbh3boLxLahdSzPK9nKkh5tBq134?=
 =?us-ascii?q?pWCiHEWFP66eX6kY/MW0ZvtPZZUjUdbonw+NMWPkN6FfHqwqtmFeYKjW?=
 =?us-ascii?q?+vDsI6AcQlMI+/u7RdNIGwQjOFX8QU9YtLAw6W0fjuiojg/jhEOShRjK?=
 =?us-ascii?q?6xUsT2V8HSKvbmUeeHchA+gQ=3D=3D?=
Received: from mail-vi1eur02lp2047.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.47])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Apr 2025 14:58:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcfkBn8LTAKZ7QYdcdYa2U8O4pG+vuHFd9QzM/O2qopuogR8Zs6s9fe5vEA1NEbGY72OX2knPjV/7yoC36AkD/KY+uVM4oVjFRekBsHKNsISqUvuknuQ3P6vOHLD/393pLnugnxF5JRRsWnBs+n+x8uZnqWsaU2W3sc2htA+0A8H/hLvUMtIfDccTg+bCSqMjeqx2DvhwaV9esMsUh/gRXe6WNQ/L+5znHLhBYggN5s1glQT5mRHnP1zrisWZ20yqZcJA8W+/33eB+R+5daf85ol0TFgN8WZ9N8ijyKfdvE0VyQPKjNsdts3DO7X1Urlf0UNncRQrcxPNm11yxQK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ2z00B5OBh1MhDXL7/RcpFxwdjCyIZmAb0sabQl/og=;
 b=I6LG1KjIdD3+6ebavAf/3YWkZkxbAQO35abqE3XDWyh354xSYIbyAuj3wtdwYdI2eWKtn8Bxp9yx67g1ndPcC0tldopaz78UYsZdE6JmsrXao811oUz4Yt4E60t2xBKdB4QSIsKS5Z/uEjpbaSry2HGVVfN9nhbjRCTCUnHXM6fdKsWdsLk0ltFYejbccgckOOXdV0ZwhAYZqnYnicgWY5gYy44VQ/TkQOg8B2Xp2xsXZPa7VUiDsAxeNx/0/7xzmAioTKnLGqQDKnvgO+n+BXPf6oFkc0eaR99NHEhSnr/+hobbx3/l4csCw9szyEY5SgxlPSAynHZ8dOCzScB/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ2z00B5OBh1MhDXL7/RcpFxwdjCyIZmAb0sabQl/og=;
 b=WcH3ZpQFAD7EoLekkVa1see+URemUffh1reLzU/scW+agSDi20gS3VftX+oIuQhynwJ2aoEkzgwPIe1iaOD1InkWDYi76kiehEi+4zy0VF+JGRtao6xyQTKp9oWGDW7kYbA213jeVoOPl+/8OGs8ddt0Mm2MWfCwxixVqtSdQpx5ssMK6N8kDlUt+R9iRvNwfxO2dh1bgExk6FW3CyHHYC2QgImzTdrfgoL+iHU6BLDxHakaOGVrIAxY/5RaB1FKbhx1dk4ElhEFwi1adYIqUobkYypPBAKrzOoyODJSH3zIBWzCAOY4QPytWMwcEf8jHhnQ8dJkFXHg/vAFmazFng==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7135.eurprd07.prod.outlook.com (2603:10a6:102:fb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 12:58:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 12:58:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Topic: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Index: AQHbt/wzwrZhvPrcvUqcZsB0k76GeLO4xrmAgABd6QCAAQOqgIACBuqA
Date: Wed, 30 Apr 2025 12:58:48 +0000
Message-ID: <26ea2d1d-8038-47bc-a68c-842ccf687f99@eviden.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
 <20250428051235.10767-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB67441EF218A7D9B3D9860A1892812@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <3972adb2-fc9b-42cc-bc9c-a1c578577c1b@eviden.com>
 <SJ0PR11MB67444C4BCD3A61A5D4F9A45A92802@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67444C4BCD3A61A5D4F9A45A92802@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7135:EE_
x-ms-office365-filtering-correlation-id: dc093bfe-bdc7-45ba-af7a-08dd87e6bf74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NjNCWkQvb1BUbWNsdUd2REJzc1BCQzNlVzlnV24rNm1mRDkxbzY4T2dFT3pL?=
 =?utf-8?B?clZBRjJWdlNHZnprbERkbklMbk12Nk5lazNqNHZBcmQ1RUs5QkZNK3pjT1Bs?=
 =?utf-8?B?RGI3YlpKQTdiei82VzN5VkFmbjVGN2pWYVEyK3ozNkozYVloenpQTGZhQjNM?=
 =?utf-8?B?Z043U01xY0VBZXNscUZFcFlyRGZVTmVtdEpSZ1c3MTgya25nYVJOemVEZWll?=
 =?utf-8?B?S0xIbndVRHJPSkRGQlJ2VzNoTm9teG9aRklWNXdHU2xla2lQNE1wZk85bUVt?=
 =?utf-8?B?d3RDaXlXeWtDaERiemRqZjRIRTdUc1VuQ2d4LzRLZmlVSmlhcWp1dG5zOUJK?=
 =?utf-8?B?V3Z1NXVXZm4yU1pPUXpUeEhSeUJUc2tkeS9zT0c5Qi9sZzJVMFQwSTgwWndQ?=
 =?utf-8?B?MGh3MlNEcENjQzFhSFBudk5ReTNVTmJVc2FlYW9IdkVNZ0c0VmoxRVNIQkR6?=
 =?utf-8?B?ZFp1NVI4ckxTWmJGOWZPbThRdHBNMkN3OGRQNEl2NS9nWkNTdEZwUFFzbDNT?=
 =?utf-8?B?NDh0QWFMc0E2WjJReDdCYnVMUmlWSjFLWjVHSmZ6eWhhNVhsSFBJS1NIYVJx?=
 =?utf-8?B?Z2R5T2thKzArWnBNY3JuTUl6cVpMMUlvaWszNmwxU2NlYUFWbEVaVmpLcHAv?=
 =?utf-8?B?S2dVNHhFYUhaMTVEeTViTVE2VEV6eXhyRE9RU1dWdm9FeERKS2U3K200ZzhK?=
 =?utf-8?B?d2EvTERVTFNHMnJWbnNORVg3bzc2dGJmWXc3a2VrYThYeHNIbXlTNnlERmlL?=
 =?utf-8?B?WFVvNDVmNHZCcEhsSzhJSE85cXVmNngvbmFyT0tJSkJ4SUdHVEUrTHBUQ0Zu?=
 =?utf-8?B?OE1HekFqSDdtQVhidzFUREdSRlZNK2cxVXlNRkYrZTZ5dVllUlFoUnBjL0Z6?=
 =?utf-8?B?RXQ0Z0h2NEZ0dS9rZDZDamJ0eU4zenNWQVVWTDlqOC9iMUlTbzhXKzI5Um1O?=
 =?utf-8?B?Q0JYL0R1OEVObFhKTHFpMGRZMi9jdVdTekVURDN6UVI5djJneTBtVm9UaW82?=
 =?utf-8?B?QndtZDhZYlhGV2o1cFFpL2xQb2g5NDRsYzU2T0JuYkJYcUJvQmovcUp1T0RQ?=
 =?utf-8?B?Zml3RVpsOVl5RlprKzhyYXRNdXRJMU9DWTN5OUc5UWdZWWdTUTk3UzN3RXJK?=
 =?utf-8?B?bzNOY3AvS3RTR1lsU1Z0WFdld1NjM2FlRHZVSzBOaUZqLzZzOUhmM3BmQzVx?=
 =?utf-8?B?OGIveFF3Y3gyQWlmYmlCMXRIQjJ2YWJONUxza1loWU5uTStrc1dWaVF1N0NU?=
 =?utf-8?B?UGpNc1M2ZUlRdS9lSS9xR0ovcHMrbWlNa0p5V1R5Zmg1aWhrd0hlU3VSZXIy?=
 =?utf-8?B?WHNISGM5ZTF1ZEp2TCtmSGYzemhEOEdXSytuanhYN2JhbDR1aC93NDJyQjMz?=
 =?utf-8?B?THZsT2NNUmlkYzRQOUZRS1QyNHFmQXVxVUIzamFkcW56N3dxRDhOY1NybFRX?=
 =?utf-8?B?TG1tYm92RFg5TTFhdHorYURuSmNPMlEycmdIWGZDcHNOOC9MNnRCZXduaENZ?=
 =?utf-8?B?WS9tSkJjYUFOYzFEQWpSZVhzTjA0bm9xTjNUbmNGRS9CcGt5N2p5S2lDL2dq?=
 =?utf-8?B?a2ZqZkhUQ0V0LzBTbkNmaDRIMUlZb0JTenRLZ2UxMjNHaGhXVTB4NkZiSEto?=
 =?utf-8?B?b01zR3hMOFBrc3V0ZjdQL2FXdldidUQ3c0FsQi9NS2pvSGpVcTFJdjhQdEZi?=
 =?utf-8?B?eGluS2U1aWllWFZMVVU0SmlxUnRJSzIxdmhLOE9OK2pLbTJIb1FsQ3JJOXow?=
 =?utf-8?B?c0FLMXhNNFd4MkpGZldNc3MrN2pYbGxvWStWcmh0dUQyQkQ1U29DaG5zcktp?=
 =?utf-8?B?d1lWM2Mrc0JoU2hjbHdWNjNuUExkeThreTV2NUN0dkNaSHJoYVI0blYxSlVZ?=
 =?utf-8?B?OThITXZ4bEs4MmljL0lEWkxyMys3eS9oR0p6dXpQcVc2TnpzZWN1ajlBcE9k?=
 =?utf-8?B?UjNNVDJPM0FzTjJMZ2htWXJJb0VhREhPWHkzQ2xTd2I2Z1BJRWY3S0Q1MkNL?=
 =?utf-8?B?R2ZjblJPTm5BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVdmSWF6eWJWVEhXRUtrSnFqZjh6NHlPdy9wVElPNXV3Um1nK09ReVBlS3VI?=
 =?utf-8?B?UVlXMXpNaE9qTXU1WURSdkNUcXJtTU52bHBWbGYvQzRhK3ZZazhSQ1pSZkRo?=
 =?utf-8?B?SkNlb29lVUdEU2tTR0hEUzZjOXlGT09EMFdjU3NoNVJibGZmME9taEw0Yisy?=
 =?utf-8?B?NHU3NFhZbnNySnNBQjh2V0l2cGRLelZMNUxpWk5SaG5ZZGRhNzROS1dMVUZ0?=
 =?utf-8?B?dWtJRzV5clNjWEgzVnMwYjdQd0drbm0raXpxc1NLaHpuZEVLazJMN1ZIUG5m?=
 =?utf-8?B?S1oreFVjVmVERXFDZzVmL2RRUE1NaUdLL2s0RFhQKzZhQ0RBbk1YdlNvVkJo?=
 =?utf-8?B?WWx1OWNpZURUWERvc2tFV2JQUzdvUWdOY0QyN1RKT3NncElHT2lyejFpcW1W?=
 =?utf-8?B?UjBYWVJZUzU5Zm1WbkwrR01Xa05WOFlGUktkcDM1OHpTYTBMYTR1VFQ1ZHl2?=
 =?utf-8?B?alNSZXh1S2RkUXlXT0tWMVZBRWJKRkVsdlFJS2FjVkFHS2ZLdDJJZThxYWxW?=
 =?utf-8?B?TzNqTmxKdUQ1Zk9VbDJwQkpjVzNFY2hNVVRmQmI3L1lKOHQ4WUxzYXRBNndI?=
 =?utf-8?B?KzAwMS9EQXhnaUNaNUVFTzBNZzExMS9kazFGb0VGd0tra0RhTmpyVlordUVh?=
 =?utf-8?B?c3FSeElER1hNZTBuZVdnOStOTTlyZ3U1OTR4cWNyblNtREdzVFZIU1dKTTJZ?=
 =?utf-8?B?M09NdDkwalAvcStKdUxSdEd3NTlZeVJMUnViRm1uWk82bXFoT2JyS0YwZ3Js?=
 =?utf-8?B?R3BFaDd1UG1oMUM0dHYyK1pCZld5NjBhbU80a2FOTGhHSlY0TmRlV0xWK3dy?=
 =?utf-8?B?aFNadndxOEs4MnY4a0FGZGR2NFArN2RHZzh1TXVUdlFsUXYvOTJZaW1YZXpw?=
 =?utf-8?B?TmdVR2ZrK0hPVVFCUURLM0dWdEF0Tm5LcXFtODFvZkZHZ3o1a21BSEdWcENv?=
 =?utf-8?B?dzZpUlh4WVBPdDk0Rnc0RUtUeWFRck1mZGE3SWloYWx3UnZzcEo5aHdDS2x1?=
 =?utf-8?B?NnpFc3hsKzhrdGpPaURRV25TK0NwZjJ0UUF6UENRMDR6V3hDZ3RoaGRVWk42?=
 =?utf-8?B?TlA3bTd5UVp1TzRPVGRzYWFNRWJpNnVncUc2RlNwVFRyUzlwaGZDckVJNnln?=
 =?utf-8?B?TmF5aStlbnBNelRLWW4vU2NaTWUwektPazdwbmgzQmROcWluSnB2anVsc1NZ?=
 =?utf-8?B?eFkrS3RtMFhNTUttRnMrVDVqZjBTM2l4TUNCNGR0R3MvcERPRmNaTjQyYjNE?=
 =?utf-8?B?T3IycHVxZHZLZGIwRWZZV3Q5dUUzRlA3T1JYSTV3Q1FrSkNSd1ozNnAza21T?=
 =?utf-8?B?K1JFK1A5MGtJUUZMNXRuRXNWNDRKb0tYSUVZVVpsd1MvVFlWcjE5bStaWjM0?=
 =?utf-8?B?Uzk3TkF2MmhrMnljUHRSMmE0SW5lSWhVQ3RraVZEME9RMlVtcVpxQVFzbDdS?=
 =?utf-8?B?OGkvUEIyMmVDS1k4UHF1cFArWE1RV3REUmt3TkVLQkpiSURrMmdlS2NFRUE5?=
 =?utf-8?B?c01maGE3dDc3c0dyeEp0Tyt6WUhYYytoSXZqZzFEUkdhMm1QbEEzOGQ5NFFT?=
 =?utf-8?B?TERLam1ZNnRCa2xEYUhUQW1sTHN1QzRJSy95dHE5OE43UmYyUGR1d2hLYTRM?=
 =?utf-8?B?RDMxbXNZZDJHcXdqM2xHYkhJdGwwZENWb050MitZdTV2RFJJWTA3OHB5YTY2?=
 =?utf-8?B?YkZlMEJpQUFZMG9zNkVwWmI1TDhXWnE5V2F0ZGFRZFU5RUtKRmFoaWllR3lX?=
 =?utf-8?B?TkUwNnR1VVBZbGJFekhqQVVJMThpN0xtMVhWS0piYjBzVTF6UWlEWWR5K1ZN?=
 =?utf-8?B?N0tVNFlubk5vNnFWTm9XYThIS3BiNEhxRlRwUVNhVnFYM3BLR1R6L1JSWTFT?=
 =?utf-8?B?akwzU3lNTG5ZVUlrZml4RjdMeGtHaTFBaUp5RXNoQ2dlRFhTWFFJNWtoK0Zk?=
 =?utf-8?B?WEFhV3pudDF4aFZ0TlhZR1pwYXMzbHFmNERiaVdGNmlPbkhkbTFrWFMrWTA1?=
 =?utf-8?B?WThqZnpuWXdaR3RkUVMvcGI0YWgzanRHQXlJVzA2akZvZTM3YUhwUjI1enJH?=
 =?utf-8?B?bnYwdXc3TUlFbTdIOVNyUENDd2YyMXBuVXZmM0ZFUi9mKzhLSktpbmxGMXY2?=
 =?utf-8?B?TzlCVW1NOWk1SE1NbGtsK0lubTNXVEpUZG5FL1FqaHFGWW4yaThHQjJXcUgy?=
 =?utf-8?Q?fmKlIpZNIJHx+w1KfD7v9WU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B0CB28740B6D74BB2142C5E0981B842@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc093bfe-bdc7-45ba-af7a-08dd87e6bf74
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:58:48.0594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGWMwWfJNmMHURfh1G0A79z6KWdBbHoNDX44ELkWljdoiT+X1iTS2eh5O4f6hlpI2o3CQbJqYEASvkKnF6Ry3063FvR6Ff3UjyPl67q3VmDxjaG7tQ2mUMxXbClokBv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7135
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

DQoNCk9uIDI5LzA0LzIwMjUgODowMSBhbSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiBDYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy8zXSBpbnRlbF9pb21t
dTogVGFrZSB0aGUgVlREIGxvY2sgd2hlbiBsb29raW5nIGZvciBhbmQNCj4+IGNyZWF0aW5nIGFk
ZHJlc3Mgc3BhY2VzDQo+Pg0KPj4gSGkgWmhlbnpob25nLA0KPj4NCj4+IE9uIDI4LzA0LzIwMjUg
MTA6NTUgYW0sIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBl
bWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlz
DQo+PiBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPj4+DQo+Pj4gSGkgQ2xlbWVudCwNCj4+Pg0KPj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjQgMy8z
XSBpbnRlbF9pb21tdTogVGFrZSB0aGUgVlREIGxvY2sgd2hlbiBsb29raW5nIGZvciBhbmQNCj4+
Pj4gY3JlYXRpbmcgYWRkcmVzcyBzcGFjZXMNCj4+Pj4NCj4+Pj4gdnRkX2ZpbmRfYWRkX2FzIGNh
biBiZSBjYWxsZWQgYnkgbXVsdGlwbGUgdGhyZWFkcyB3aGljaCBsZWFkcyB0byBhIHJhY2UNCj4+
Pj4gY29uZGl0aW9uIG9uIGFkZHJlc3Mgc3BhY2UgY3JlYXRpb24uIFRoZSBJT01NVSBsb2NrIG11
c3QgYmUgdGFrZW4gdG8NCj4+Pj4gYXZvaWQgc3VjaCBhIHJhY2UuDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2
aWRlbi5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAyOCArKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IGluZGV4IGI3ODU1ZjRi
ODcuLjkzMWFjMDFlZjAgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gQEAgLTQyMDMsMTEgKzQyMDMs
MTUgQEAgVlREQWRkcmVzc1NwYWNlDQo+Pj4+ICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0
YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+Pj4gICAgICAgICAgIC5wYXNpZCA9IHBhc2lkLA0KPj4+
PiAgICAgICB9Ow0KPj4+PiAgICAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXM7DQo+Pj4+
ICsgICAgc3RydWN0IHZ0ZF9hc19rZXkgKm5ld19rZXkgPSBOVUxMOw0KPj4+PiAgICAgICBjaGFy
IG5hbWVbMTI4XTsNCj4+Pj4NCj4+Pj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pj4gICAg
ICAgdnRkX2Rldl9hcyA9IGdfaGFzaF90YWJsZV9sb29rdXAocy0+dnRkX2FkZHJlc3Nfc3BhY2Vz
LCAma2V5KTsNCj4+Pj4gKyAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4+PiArDQo+Pj4+ICAg
ICAgIGlmICghdnRkX2Rldl9hcykgew0KPj4+PiAtICAgICAgICBzdHJ1Y3QgdnRkX2FzX2tleSAq
bmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4+PiArICAgICAgICBuZXdf
a2V5ID0gZ19tYWxsb2Moc2l6ZW9mKCpuZXdfa2V5KSk7DQo+Pj4+DQo+Pj4+ICAgICAgICAgICBu
ZXdfa2V5LT5idXMgPSBidXM7DQo+Pj4+ICAgICAgICAgICBuZXdfa2V5LT5kZXZmbiA9IGRldmZu
Ow0KPj4+PiBAQCAtNDMwMiw5ICs0MzA2LDI5IEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4+PiAqdnRk
X2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdnRkX2Rldl9hcy0+bm9k
bWFyLCAwKTsNCj4+Pj4NCj4+Pj4gICAgICAgICAgIHZ0ZF9zd2l0Y2hfYWRkcmVzc19zcGFjZSh2
dGRfZGV2X2FzKTsNCj4+Pj4gKyAgICB9DQo+Pj4+DQo+Pj4+IC0gICAgICAgIGdfaGFzaF90YWJs
ZV9pbnNlcnQocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCBuZXdfa2V5LCB2dGRfZGV2X2FzKTsNCj4+
Pj4gKyAgICBpZiAobmV3X2tleSAhPSBOVUxMKSB7DQo+Pj4+ICsgICAgICAgIFZUREFkZHJlc3NT
cGFjZSAqc2Vjb25kX3Z0ZF9kZXZfYXM7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgLyoNCj4+Pj4g
KyAgICAgICAgICogVGFrZSB0aGUgbG9jayBhZ2FpbiBhbmQgcmVjaGVjayBhcyB0aGUgQVMgbWln
aHQgaGF2ZQ0KPj4+PiArICAgICAgICAgKiBiZWVuIGNyZWF0ZWQgaW4gdGhlIG1lYW50aW1lLg0K
Pj4+PiArICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgdnRkX2lvbW11X2xvY2socyk7DQo+Pj4+
ICsNCj4+Pj4gKyAgICAgICAgc2Vjb25kX3Z0ZF9kZXZfYXMgPSBnX2hhc2hfdGFibGVfbG9va3Vw
KHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywNCj4+ICZrZXkpOw0KPj4+PiArICAgICAgICBpZiAoIXNl
Y29uZF92dGRfZGV2X2FzKSB7DQo+Pj4+ICsgICAgICAgICAgICBnX2hhc2hfdGFibGVfaW5zZXJ0
KHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywgbmV3X2tleSwgdnRkX2Rldl9hcyk7DQo+Pj4+ICsgICAg
ICAgIH0gZWxzZSB7DQo+Pj4+ICsgICAgICAgICAgICB2dGRfZGV2X2FzID0gc2Vjb25kX3Z0ZF9k
ZXZfYXM7DQo+Pj4+ICsgICAgICAgICAgICBnX2ZyZWUodnRkX2Rldl9hcyk7DQo+Pj4+ICsgICAg
ICAgICAgICBnX2ZyZWUobmV3X2tleSk7DQo+Pj4gV2UgbmVlZCB0byByZWxlYXNlIG1lbW9yeSBy
ZWdpb25zIHVuZGVyIHRoaXMgdnRkX2Rldl9hcyB0byBhdm9pZCBsZWFrLg0KPj4NCj4+IEluZGVl
ZCwgSSdsbCBoYXZlIHRvIHRha2UgdGhlIEJRTCBhZ2Fpbi4NCj4+DQo+PiBJcyBpdCBvayBmb3Ig
eW91IGlmIGl0IGxvb2sgbGlrZSB0aGlzOg0KPj4NCj4+IHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4N
Cj4+IHNlY29uZF92dGRfZGV2X2FzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfYWRkcmVz
c19zcGFjZXMsICZrZXkpOw0KPj4gaWYgKCFzZWNvbmRfdnRkX2Rldl9hcykgew0KPj4gICAgICBn
X2hhc2hfdGFibGVfaW5zZXJ0KHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywgbmV3X2tleSwgdnRkX2Rl
dl9hcyk7DQo+PiAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiB9IGVsc2Ugew0KPj4gICAg
ICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4gICAgICBCUUxfTE9DS19HVUFSRCgpOw0KPj4NCj4+
ICAgICAgbWVtb3J5X3JlZ2lvbl9kZWxfc3VicmVnaW9uKCZ2dGRfZGV2X2FzLT5yb290LCAmdnRk
X2Rldl9hcy0+bm9kbWFyKTsNCj4+ICAgICAgbWVtb3J5X3JlZ2lvbl9kZWxfc3VicmVnaW9uKCZ2
dGRfZGV2X2FzLT5yb290LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVN
T1JZX1JFR0lPTigmdnRkX2Rldl9hcy0+aW9tbXUpKTsNCj4+ICAgICAgbWVtb3J5X3JlZ2lvbl9k
ZWxfc3VicmVnaW9uKCZ2dGRfZGV2X2FzLT5yb290LA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnZ0ZF9kZXZfYXMtPmlvbW11X2lyX2ZhdWx0KTsNCj4+ICAgICAgbWVtb3J5
X3JlZ2lvbl9kZWxfc3VicmVnaW9uKCZ2dGRfZGV2X2FzLT5yb290LA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnZ0ZF9kZXZfYXMtPmlvbW11X2lyKTsNCj4+DQo+PiAgICAg
IG1lbW9yeV9yZWdpb25fdW5yZWYoTUVNT1JZX1JFR0lPTigmdnRkX2Rldl9hcy0+aW9tbXUpKTsN
Cj4+ICAgICAgbWVtb3J5X3JlZ2lvbl91bnJlZigmdnRkX2Rldl9hcy0+aW9tbXVfaXJfZmF1bHQp
Ow0KPj4gICAgICBtZW1vcnlfcmVnaW9uX3VucmVmKCZ2dGRfZGV2X2FzLT5pb21tdV9pcik7DQo+
PiAgICAgIG1lbW9yeV9yZWdpb25fdW5yZWYoJnZ0ZF9kZXZfYXMtPm5vZG1hcik7DQo+IHMvbWVt
b3J5X3JlZ2lvbl91bnJlZi9vYmplY3RfdW5wYXJlbnQ/DQo+DQo+PiAgICAgIGFkZHJlc3Nfc3Bh
Y2VfZGVzdHJveSgmdnRkX2Rldl9hcy0+YXMpOw0KPiBvYmplY3RfdW5wYXJlbnQodnRkX2Rldl9h
cy0+cm9vdCk7DQoNCkhpIFpoZW56aG9uZywNCg0KSSB0aGluayB0aGUgaXNzdWUgY2FuIGJlIGZp
eGVkIGRpZmZlcmVudGx5IGluIGEgY2xlYW5lciB3YXkuDQpJIHNlbnQgYSB2NSBmb3IgdGhhdC4N
Cg0KVGhhbmtzDQoNCj4NCj4gVGhhbmtzDQo+IFpoZW56aG9uZw0K

