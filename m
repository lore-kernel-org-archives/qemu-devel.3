Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2DBCAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 02:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyLeE-0000VS-Li; Mon, 15 Sep 2025 22:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyLeB-0000Us-Dp; Mon, 15 Sep 2025 22:42:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyLe5-0000Jx-Bi; Mon, 15 Sep 2025 22:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEEGRIQ4CMwmR0inZsaaq/mYWVzC+JhZCjVKMBikLBGvBnpsLImn26dcKKsGpygq7V7unXzpi9ASlW1XX2wODoSTstT/ISuRYvHpAr5W6sjZYUS1stCzezR3ffo1r0bB+/GqX6ng1i1cdqIi+ofMt++okBHcdM+mwJ13fWBv9TaNbj8+lq54eHUd+RPyVcm7mrQc9Q5uwNOFEnYsB/Vr0+VD8CXbimikeMbOLZnCxxMDQnAq8xooUaw4Xle5FoOCmJVO2vZUl+jI1REmjlivC+0DlP5JDK8E7cGl6YttW3KfvCYKeofrEaHNJkhwvO50CZU51ozDqnfGbH/y1I+KdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgDGVB1GY6LMBjeRRwg1J1HI7gBTLQkGhLYE2q1BLCw=;
 b=xWU+F6VHVdKdB+/csEiFw54yj+JbtwHGkFkvHmPEE8eWe3b+8KTY6K7XrxGGMhXFgSmkSgrBJ06jSefjEAJZvmbgv1TiBj+Ysn9y3Xsiu7TJMlRh9+BLFaK5d8l/C9IqtJMsCr77xzjUW+guveYw9Pho4hWiQIZZeqQ2M5LVIF449Sitk25z+o5+qsDGLZ+WkMTR/Bcy/N7UZcUlTRdCUMS0Ve0UWa30F2s90Tebk9av7pEsqrTbN9cai2deMYZv2sJsySqmYCOkVXouVlqH1K0za0qLbznmC7Ln+/1bxXaGV6/PTkGEaehRbZst/UUriiMvAKLNkzPKJDY1Y+3YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgDGVB1GY6LMBjeRRwg1J1HI7gBTLQkGhLYE2q1BLCw=;
 b=BVrkaGnFSaU6JtGQmXjiNbjEPHXpdDknYq/MdR/exnSidO2M+rV5BoSvs58divKKqgsdXJzbhVF0vgjk+MotvzJSCbnOWsMrsbqkpfDttk7Q2WuZOWFOiieztvRbgXxalKZP3oIkS46W1u95Hnn1CaclZxU2Cta3pUkg/bnWMEfzGzM6U1zQ5lHg/aNMBnBlXr0s5DusgvbaHEFOtq0UGNMNS3nWiC8lrORBx9Sa4dfywx+gq2G69MtzY93FvgFcdxl27spi+K4OnXZCay4oUrSQHsYMfh/qZ6ObLy5gwPeXDHHs8ok5V8sB8VZEQyfJxB/EHvNOOCiyfyhD0sRe8A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6784.apcprd06.prod.outlook.com (2603:1096:101:18c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Tue, 16 Sep 2025 02:42:04 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 02:42:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: [SPAM] [PATCH v2 04/14] hw/pci-host/aspeed: Add AST2600 PCIe Root
 Device support
Thread-Topic: [SPAM] [PATCH v2 04/14] hw/pci-host/aspeed: Add AST2600 PCIe
 Root Device support
Thread-Index: AQHcIu0vf6HU7hTnRE6HH0JrcWN6cbSUfJWAgACkRxA=
Date: Tue, 16 Sep 2025 02:42:03 +0000
Message-ID: <SI2PR06MB5041F7F05930C57E1DCB8FFDFC14A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-5-jamin_lin@aspeedtech.com>
 <ef6b20f6-b030-4fc3-af86-b8ec01488585@kaod.org>
In-Reply-To: <ef6b20f6-b030-4fc3-af86-b8ec01488585@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6784:EE_
x-ms-office365-filtering-correlation-id: 0788dc81-8c39-47b2-06c3-08ddf4ca9ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?SU5lYzZnT3JnamdvNXZySkJHOWUxaVNOREJWQXcwZlJ1Z05zL1N1QS9qMmJz?=
 =?utf-8?B?NUJBd2M3cUlwY0lUY3AxaG0rVHpaSzZ0V2lFS2tULzUrY1ppeTdJNy9jdnJy?=
 =?utf-8?B?VjQxWHdBd213eGx1OVI5b3cwWFFWdFFpbGRzd1VFRHhkalZoT1Y0S0RleHFx?=
 =?utf-8?B?SFBTUjAxcURmQk5lRUh4K053emRENmFRcnJtdCtjRFR4OThhOXZwWEJpOCtZ?=
 =?utf-8?B?WGRSMmdqVXkvdWZ4Y0xGelNGM0dPcVZXdUJmYzlyK0pBZjRxamVBT3loU0JI?=
 =?utf-8?B?aDEzUDdqRTJOc0JqOWh6VVB5ZWhFeFFyTmVqcUg0RGZIQ3lLaFVBZDdoNGRI?=
 =?utf-8?B?bE9VTUZ5bzRJdndGLzZocGdLYWJPRmZ2WUs1WkJrc3hLWEVWdnU3eHFDbUFm?=
 =?utf-8?B?VW9zQ3NVRkJvTTJzd2Z3U3NqMEt0OVZFc1FhYjRGNERwNWI3RVQ2b1FMS0x5?=
 =?utf-8?B?VFY5M3ByN3czMno3Znk4VWpacXdKbXBpSG5yR290V0NJZ0hCUmVpdWlYeG9L?=
 =?utf-8?B?ekc3eml1QWs4QTZUMjhianNPV2JmTUFDL2dLMDF5Zy9Dd2VLSE1acEFGdW9w?=
 =?utf-8?B?QmoyT202eGJJSGYrMDYzakpIampMMnFNNkZDMFVFUVFmODhuYlc5RVlaQzZn?=
 =?utf-8?B?UDdtYU5qWHh4YzA2eE01QkI4Z1JSVzdBYjFsRTV6QW51UE5Fd090NW5zTjBm?=
 =?utf-8?B?QnZsVUplK1ZvWDdJSkcxTDlDYjQzS01Hcm1LbnVTTW5sWDc2NFlUQlRKYmRI?=
 =?utf-8?B?SHdYRTZJNmlDRnVncDdWK2FTeFRvVmp0TUNhUnZrZUxnQVh0a2VIWUFFakQr?=
 =?utf-8?B?N090bnUwbDN6Y3NjNkN4VG12dkdZYlBXVUdmNHFEQmRYN0hRWmkzeU53ZlZP?=
 =?utf-8?B?ckRVOFNCdUlpbk8wR09SV2J3Nm5BOTAzVnZING9hdmFMWjBya1B4ZS9iM1o0?=
 =?utf-8?B?cnAzWUxtaTlEVU04Q0xlUDYzbUowb25UTWhUVVZyMCtKS2pGR1QxeWoybk9N?=
 =?utf-8?B?bjZ6YlFOZnJFdGw5bWJJWmpxMVU5N0FvRVN3UzFzR1dsZEpPT1pXbEpTV2c4?=
 =?utf-8?B?Q2FqdGpSdVRYVkxFQnV6R2RxVUhENkFBZm43TU9yWUVkWXhiT2Z2Q29lVkoy?=
 =?utf-8?B?MVFnL2N0b1pWRktHMTR0ZDVCOGJKMHpPUHA1NnhJdUJUWHM2eUJHQW1aQUZF?=
 =?utf-8?B?a0JuNmxReWQvMTZrS0FJMHZDVkgyVllLbHl6RWRWZ1ZyQlZyd2FwUHFEN250?=
 =?utf-8?B?eWw2ZVp3TmtIWUh4YitnNStncGNkWHRDQ1gvM1Y0d21QQzFydGJOLzFlL05G?=
 =?utf-8?B?R0pjODlyV1d6TGhEaHQ5RUJGcTZMZmhzRDdNK2JseWZuV09hMEp2V20xKzkz?=
 =?utf-8?B?ZnphYkFXNWVOZkJ5QndVaVErdEIvYmpsVlNjVHFxenhzVFpjZnYyeEtvY2dT?=
 =?utf-8?B?MlNIMTNLd2YvL3lWWS9zQVlQWm1pbzZjUGtHWjBIVFRidkJkaEE3Ri9CSDV1?=
 =?utf-8?B?QUwrb0ZOelRvVW5qU04wcThsSlRVVit2T1JZYTRCQnlyWFA4RExua0dHQXFV?=
 =?utf-8?B?TElzOXdrWkhJaW9PWEJtOXFIYTBiM1lCNXVYUkVMdzc5ZVJ6bVlOa2RsY2FY?=
 =?utf-8?B?UmVBZUpvV0lOL3grZkVzYkhhcEV1SXlPL1N6MEJRbDAvQzBieVo3S2VYb0Fq?=
 =?utf-8?B?Um51dUorU1FjYTVCbTIzblFmNnJ3WXc4U0gvaXlSMnp0c3lpQTQ4WG1WTVBM?=
 =?utf-8?B?azEwdEpRWE5WK1YrWW1GRjQvMGlDemN5WTFnV0VsMHVoQmVmWTFuK3h1VmRY?=
 =?utf-8?B?KzlmK1R1Qks5cGxVbEpONTdVQmMyWFppZXRVRkJSZ3U4TnBjRnhpaGJ0dzdz?=
 =?utf-8?B?SnZNaytnNVd4OW9QanEvVnJ2RmlJUE5QVlBiOUt0L3dNU1VuVTlzS0Y5bTVj?=
 =?utf-8?B?blB0MFV2SFRxZkxxUUQwaXYyNWNNRnVVSEhTSXE3VDNjVSt0WGJqdDRFemNT?=
 =?utf-8?B?Mi8zbkJ1WndnMVYvRURjNWdIUXhOcjZzQmdpdDMwZTYydE5UdVJFMWRIV1JQ?=
 =?utf-8?B?RjVXcnplcHdZVmgyaWNvZE5hbm5uM09NeWtIUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhCSVdXYzd1b2NxYXZPVmhBWGdYbWdpR0V6N3hia0Q1czdWVURiOE9mNUwx?=
 =?utf-8?B?ai9zL3ZCRTkvMjVlY2lrTGwzejN3RElUOFJkT21wdHBhd0hWRzlnK0ZjZ2Rk?=
 =?utf-8?B?cWE2aXM2bHVLNU9Va2JqdnRTTXZjVVpRb0tOYjk1ZHY1dG5DN3Fjb2pRVXBL?=
 =?utf-8?B?RlB1ZGlrcDJqbkRySTZSbG1aTjlkbnY0L0RPelpCUWVtQWxBTGEwSFhlR0hT?=
 =?utf-8?B?cisxUWlGc2lsU2htR2NmZHduYkV0dDVyRlkwMnVTc1ljL2NUWkY1cHpkYTZX?=
 =?utf-8?B?WjFBL2lFTytGTEhiekpMdXI2b2w1M3dnTmpINE0wOURvT2hINUduK0Z0OEVq?=
 =?utf-8?B?TkxpdVRyVEpTcjFuM3B0TDd0ZmpZTlZFaTJJeG1rSnNlTXVnZy9XWDY5dnN6?=
 =?utf-8?B?MUZCNXRBNHlYSURPdE0zancvMks5aTYwQ3ZkT3RyOFl5OVdvbVVXWUxTSDBZ?=
 =?utf-8?B?TDdiUkJmSFJJY2hDZEdDTFlEQ0FlRFZyWnJXUjYvT05iNXJaM0RGazFsbVd3?=
 =?utf-8?B?ckptUXRiU3MyTlhPZTJtTGFONDd5U2M3YXRmYysyNzYzOXZla0xJMnBJb3RQ?=
 =?utf-8?B?UEduYzRlT0xieXBFVk9yMjFOZncyLzFyUjBtMTVIc3NwTlFsRk1lWjJpK254?=
 =?utf-8?B?c3ZrOWVKY3BiM0Roby9xQnVFc3ZBNFJkV0pJUStrc2JOZjFXanhhd2N2cDZ0?=
 =?utf-8?B?blEvRFU3a1VtNnQyK3NMTnFROHA2VjAxc3VRNDNmSDlPOXFhWGgzT3lhUXFk?=
 =?utf-8?B?blBsU1hLK3p3L2h0M1dPUWtkTHk4UkhKRWFhbldIRmlYZEdoc3BrR2Y1dUw0?=
 =?utf-8?B?OXVrT0g2S0lFN2hoci9XejFrUkxBdkw1NEo2c1l5RmR3QTJIdFhPcFlBai9q?=
 =?utf-8?B?WDg3MW1xTFJGUGtsL0RWWDdFL04rMFYxWEJoRXBMNnprSlpCUEJRL3lNU00v?=
 =?utf-8?B?TmNwTXdYMFhJb1d6dDNHS0hOMnhkb2J6aXdqVHZMb24rU2RERUtxbGR0Y21s?=
 =?utf-8?B?UVdaMWRqRlVEWm91eHJjbXM2aXVQNWo2WERxMWpKNjN4TitBTkJHeUhjZkxO?=
 =?utf-8?B?RUM2NVo1RUF0dHdwdGVmckNnMlFpVHViTjEzR0NEaUhlYTF3amVqSGtydDhx?=
 =?utf-8?B?clkwZkdBNE5ZbTFvMFdjNXlFelZacCtIOG9wZkJRKzNJS0hwSzhHN3ZHTGUr?=
 =?utf-8?B?WjhRNUdDV2JCUERpVTJoY2p0aFNsa0pYVXQzZ21KZ0RYSGhBU3hsSDlpbGtG?=
 =?utf-8?B?YXVlQm5LcVN1YjhFcGVPMUpORjh0dzlmQUJlcE9uM0UwVDhQaXFYa1p0VTB1?=
 =?utf-8?B?UGFyMitrS3oreXl2RFRpZWpnZXRBNEtDTUpIeFFhNHBEaE9wVlI2emQxdTM0?=
 =?utf-8?B?dEo2MklFWUs0NmtYT3R4bHVTdEhjOEpra09mUExodDh3Wkh1cXhKVWo4RXZh?=
 =?utf-8?B?OTQvYitWeWFrUU85UE9rc3JmcUhoQ21TWkdCNmFURzhjT2N5SmxGcy9DZ2dR?=
 =?utf-8?B?SkhpYThlUk9HaExtU1YzZ2xkaDhraUtpT3NTTDNQeW1VMDZvcm0vQzk5b3Jk?=
 =?utf-8?B?blJ6KzlSaDlVWUgzVWdmTytBdzV4N3ZJb3lJUnpXQ1N6alZsWmxtVzNBcjBQ?=
 =?utf-8?B?L0Q5eUxqNGIvMDNTU25KZHYrMGZJcUI3WGNlYmoxQ3RudlByLzR4T1VpOEJY?=
 =?utf-8?B?Rkdpb3dkU3cvcGpqRFRNQUtxSWZqRTJDOXNXSDFnVlJuMTRpSStpNkdhSHI5?=
 =?utf-8?B?RGhteDkwVGgzTU1rSEhCdzVwMVRFTUs5ZmNJS0l0NXFaSFQ0bU9RdThObmx6?=
 =?utf-8?B?VzFOekVocjRLMURoMWs2N3RLdElnLzM2RmtrSWhlTXVkOG96MUFsTWsvNGxj?=
 =?utf-8?B?VXNQTm5taGE1MkEyYTJBZThvdWQvTk41RXEwN3hoaDdSdVFqQ2NVLzBOd0RU?=
 =?utf-8?B?WGlRaWc1Mm9LaHdGWXFrSDdlYlM0eXI5Q2FsK3JUNWlNcmREdlZvL2I1Uk1v?=
 =?utf-8?B?TzdIdi9KL05vQkgwTXJjN0ZFTmRMNitNeEhMMGFReDh5c05VMXo1RlUxcisv?=
 =?utf-8?B?TG9VZU5udll4anliV0V2c0dCcnlKVFp2YmJxNXVpOVJqdTJkOVRpZGtVbHg0?=
 =?utf-8?Q?tlxUMrOyC9nHamfvMCqs5NWBq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0788dc81-8c39-47b2-06c3-08ddf4ca9ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 02:42:03.9838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zFBzJE+ZNb9wOMrD5V5XDIqfYuFr60qWAYI+TzjmIUrbVaOFbSDIIQDVquybU0EuaIEbsv+DxWEb2R9T89ibLRgrw8UvCi5+lbMHNGh6vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6784
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYyIDA0LzE0XSBody9w
Y2ktaG9zdC9hc3BlZWQ6IEFkZCBBU1QyNjAwIFBDSWUNCj4gUm9vdCBEZXZpY2Ugc3VwcG9ydA0K
PiANCj4gT24gOS8xMS8yNSAwOToyNCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEludHJvZHVjZSBh
IFBDSWUgUm9vdCBEZXZpY2UgZm9yIEFTVDI2MDAgcGxhdGZvcm0uDQo+ID4NCj4gPiBUaGUgQVNU
MjYwMCByb290IGNvbXBsZXggZXhwb3NlcyBhIFBDSWUgcm9vdCBkZXZpY2UgYXQgYnVzIDgwLCBk
ZXZmbiAwLg0KPiA+IFRoaXMgcm9vdCBkZXZpY2UgaXMgaW1wbGVtZW50ZWQgYXMgYSBjaGlsZCBv
ZiB0aGUgUENJZSBSQyBhbmQgbW9kZWxlZA0KPiA+IGFzIGEgaG9zdCBicmlkZ2UgUENJIGZ1bmN0
aW9uIChjbGFzc19pZCA9IFBDSV9DTEFTU19CUklER0VfSE9TVCkuDQo+ID4NCj4gPiBLZXkgY2hh
bmdlczoNCj4gPiAtIEFkZCBhIG5ldyBkZXZpY2UgdHlwZSAiYXNwZWVkLnBjaWUtcm9vdC1kZXZp
Y2UiLg0KPiA+IC0gSW5zdGFudGlhdGUgdGhlIHJvb3QgZGV2aWNlIGFzIHBhcnQgb2YgQXNwZWVk
UENJRVJjU3RhdGUuDQo+ID4gLSBJbml0aWFsaXplIGl0IGR1cmluZyBSQyByZWFsaXplKCkgYW5k
IGF0dGFjaCBpdCB0byB0aGUgcm9vdCBidXMuDQo+ID4gLSBNYXJrIHRoZSByb290IGRldmljZSBh
cyBub24tdXNlci1jcmVhdGFibGUuDQo+ID4gLSBBZGQgUkMgYm9vbGVhbiBwcm9wZXJ0eSAiaGFz
LXJkIiB0byBjb250cm9sIHdoZXRoZXIgdGhlIFJvb3QgRGV2aWNlIGlzDQo+ID4gICAgY3JlYXRl
ZCAocGxhdGZvcm1zIGNhbiBlbmFibGUvZGlzYWJsZSBpdCBhcyBuZWVkZWQpLg0KPiA+DQo+ID4g
Tm90ZTogT25seSBBU1QyNjAwIGltcGxlbWVudHMgdGhpcyBQQ0llIHJvb3QgZGV2aWNlLiBBU1Qy
NzAwIGRvZXMgbm90DQo+ID4gcHJvdmlkZSBvbmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1
ZGUvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuaCB8IDExICsrKysrKysNCj4gPiAgIGh3L3BjaS1o
b3N0L2FzcGVlZF9wY2llLmMgICAgICAgICB8IDU0DQo+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuaA0KPiA+IGIv
aW5jbHVkZS9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5oDQo+ID4gaW5kZXggZTJjNWRjNmY2Mi4u
ZTdjMjMxZTg0NyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L3BjaS1ob3N0L2FzcGVlZF9w
Y2llLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmgNCj4gPiBA
QCAtNDIsNiArNDIsMTMgQEAgdHlwZWRlZiBzdHJ1Y3QgQXNwZWVkUENJRVJlZ01hcCB7DQo+ID4g
ICAgICAgQXNwZWVkUENJRVJjUmVncyByYzsNCj4gPiAgIH0gQXNwZWVkUENJRVJlZ01hcDsNCj4g
Pg0KPiA+ICsjZGVmaW5lIFRZUEVfQVNQRUVEX1BDSUVfUk9PVF9ERVZJQ0UgImFzcGVlZC5wY2ll
LXJvb3QtZGV2aWNlIg0KPiA+ICtPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShBc3BlZWRQQ0lF
Um9vdERldmljZVN0YXRlLA0KPiA+ICtBU1BFRURfUENJRV9ST09UX0RFVklDRSk7DQo+ID4gKw0K
PiA+ICtzdHJ1Y3QgQXNwZWVkUENJRVJvb3REZXZpY2VTdGF0ZSB7DQo+ID4gKyAgICBQQ0lCcmlk
Z2UgcGFyZW50X29iajsNCj4gPiArfTsNCj4gPiArDQo+ID4gICAjZGVmaW5lIFRZUEVfQVNQRUVE
X1BDSUVfUkMgImFzcGVlZC5wY2llLXJjIg0KPiA+ICAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZ
UEUoQXNwZWVkUENJRVJjU3RhdGUsIEFTUEVFRF9QQ0lFX1JDKTsNCj4gPg0KPiA+IEBAIC01NSw3
ICs2MiwxMCBAQCBzdHJ1Y3QgQXNwZWVkUENJRVJjU3RhdGUgew0KPiA+DQo+ID4gICAgICAgdWlu
dDMyX3QgYnVzX25yOw0KPiA+ICAgICAgIGNoYXIgbmFtZVsxNl07DQo+ID4gKyAgICBib29sIGhh
c19yZDsNCj4gPiAgICAgICBxZW11X2lycSBpcnE7DQo+ID4gKw0KPiA+ICsgICAgQXNwZWVkUENJ
RVJvb3REZXZpY2VTdGF0ZSByb290X2RldmljZTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIC8qIEJy
aWRnZSBiZXR3ZWVuIEFIQiBidXMgYW5kIFBDSWUgUkMuICovIEBAIC04MCw2ICs5MCw3IEBAIHN0
cnVjdA0KPiA+IEFzcGVlZFBDSUVDZmdDbGFzcyB7DQo+ID4NCj4gPiAgICAgICB1aW50NjRfdCBy
Y19idXNfbnI7DQo+ID4gICAgICAgdWludDY0X3QgbnJfcmVnczsNCj4gPiArICAgIGJvb2wgcmNf
aGFzX3JkOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF9QQ0lFX1BI
WSAiYXNwZWVkLnBjaWUtcGh5Ig0KPiA+IGRpZmYgLS1naXQgYS9ody9wY2ktaG9zdC9hc3BlZWRf
cGNpZS5jIGIvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuYw0KPiA+IGluZGV4IDlmYjdjMWVmNjcu
LmZhODg1NGZlN2EgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvcGNpLWhvc3QvYXNwZWVkX3BjaWUuYw0K
PiA+ICsrKyBiL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmMNCj4gPiBAQCAtMjcsNiArMjcsNDQg
QEANCj4gPiAgICNpbmNsdWRlICJody9wY2kvbXNpLmgiDQo+ID4gICAjaW5jbHVkZSAidHJhY2Uu
aCINCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBQQ0llIFJvb3QgRGV2aWNlDQo+ID4gKyAqIFRoaXMg
ZGV2aWNlIGV4aXN0cyBvbmx5IG9uIEFTVDI2MDAuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArc3Rh
dGljIHZvaWQgYXNwZWVkX3BjaWVfcm9vdF9kZXZpY2VfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAq
a2xhc3MsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgdm9pZCAqZGF0YSkNCj4gew0KPiA+ICsgICAgUENJRGV2aWNlQ2xhc3MgKmsgPSBQ
Q0lfREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiArICAgIERldmljZUNsYXNzICpkYyA9IERFVklD
RV9DTEFTUyhrbGFzcyk7DQo+ID4gKw0KPiA+ICsgICAgc2V0X2JpdChERVZJQ0VfQ0FURUdPUllf
QlJJREdFLCBkYy0+Y2F0ZWdvcmllcyk7DQo+ID4gKyAgICBkYy0+ZGVzYyA9ICJBU1BFRUQgUENJ
ZSBSb290IERldmljZSI7DQo+ID4gKyAgICBrLT52ZW5kb3JfaWQgPSBQQ0lfVkVORE9SX0lEX0FT
UEVFRDsNCj4gPiArICAgIGstPmRldmljZV9pZCA9IDB4MjYwMDsNCj4gPiArICAgIGstPmNsYXNz
X2lkID0gUENJX0NMQVNTX0JSSURHRV9IT1NUOw0KPiA+ICsgICAgay0+c3Vic3lzdGVtX3ZlbmRv
cl9pZCA9IGstPnZlbmRvcl9pZDsNCj4gPiArICAgIGstPnN1YnN5c3RlbV9pZCA9IGstPmRldmlj
ZV9pZDsNCj4gPiArICAgIGstPnJldmlzaW9uID0gMDsNCj4gPiArDQo+ID4gKyAgICAvKg0KPiA+
ICsgICAgICogUENJLWZhY2luZyBwYXJ0IG9mIHRoZSBob3N0IGJyaWRnZSwNCj4gPiArICAgICAq
IG5vdCB1c2FibGUgd2l0aG91dCB0aGUgaG9zdC1mYWNpbmcgcGFydA0KPiA+ICsgICAgICovDQo+
ID4gKyAgICBkYy0+dXNlcl9jcmVhdGFibGUgPSBmYWxzZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9wY2llX3Jvb3RfZGV2aWNlX2luZm8gPSB7DQo+
ID4gKyAgICAubmFtZSA9IFRZUEVfQVNQRUVEX1BDSUVfUk9PVF9ERVZJQ0UsDQo+ID4gKyAgICAu
cGFyZW50ID0gVFlQRV9QQ0lfREVWSUNFLA0KPiA+ICsgICAgLmluc3RhbmNlX3NpemUgPSBzaXpl
b2YoQXNwZWVkUENJRVJvb3REZXZpY2VTdGF0ZSksDQo+ID4gKyAgICAuY2xhc3NfaW5pdCA9IGFz
cGVlZF9wY2llX3Jvb3RfZGV2aWNlX2NsYXNzX2luaXQsDQo+ID4gKyAgICAuaW50ZXJmYWNlcyA9
IChjb25zdCBJbnRlcmZhY2VJbmZvW10pIHsNCj4gPiArICAgICAgICB7IElOVEVSRkFDRV9DT05W
RU5USU9OQUxfUENJX0RFVklDRSB9LA0KPiA+ICsgICAgICAgIHsgfSwNCj4gPiArICAgIH0sDQo+
ID4gK307DQo+ID4gKw0KPiA+ICAgLyoNCj4gPiAgICAqIFBDSWUgUm9vdCBDb21wbGV4IChSQykN
Cj4gPiAgICAqLw0KPiA+IEBAIC05Niw2ICsxMzQsMTYgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3Bj
aWVfcmNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LA0KPiBFcnJvciAqKmVycnApDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXNwZWVkX3BjaWVfcmNfbWFwX2ly
cSwgcmMsDQo+ICZyYy0+bW1pbywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmcmMtPmlvLCAwLCA0LA0KPiBUWVBFX1BDSUVfQlVTKTsNCj4gPiAgICAgICBwY2kt
PmJ1cy0+ZmxhZ3MgfD0gUENJX0JVU19FWFRFTkRFRF9DT05GSUdfU1BBQ0U7DQo+ID4gKw0KPiA+
ICsgICAgLyogc2V0dXAgcm9vdCBkZXZpY2UgKi8NCj4gPiArICAgIGlmIChyYy0+aGFzX3JkKSB7
DQo+ID4gKyAgICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNUKHJjKSwgInJvb3Rf
ZGV2aWNlIiwNCj4gJnJjLT5yb290X2RldmljZSwNCj4gPiArDQo+IFRZUEVfQVNQRUVEX1BDSUVf
Uk9PVF9ERVZJQ0UpOw0KPiA+ICsgICAgICAgIHFkZXZfcHJvcF9zZXRfaW50MzIoREVWSUNFKCZy
Yy0+cm9vdF9kZXZpY2UpLCAiYWRkciIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBQQ0lfREVWRk4oMCwgMCkpOw0KPiA+ICsgICAgICAgIHFkZXZfcHJvcF9zZXRfYml0KERFVklD
RSgmcmMtPnJvb3RfZGV2aWNlKSwgIm11bHRpZnVuY3Rpb24iLA0KPiBmYWxzZSk7DQo+ID4gKyAg
ICAgICAgcWRldl9yZWFsaXplKERFVklDRSgmcmMtPnJvb3RfZGV2aWNlKSwgQlVTKHBjaS0+YnVz
KSwNCj4gPiArICZlcnJvcl9mYXRhbCk7DQo+IA0KPiANCj4gd2h5IG5vdCBwYXNzICdlcnJwJyBp
bnN0ZWFkID8NCj4gDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2ls
bCBmaXggaXQuDQoNCkphbWluDQo+IA0KPiA+ICsgICAgfQ0KPiA+ICAgfQ0KPiA+DQo+ID4gICBz
dGF0aWMgY29uc3QgY2hhciAqYXNwZWVkX3BjaWVfcmNfcm9vdF9idXNfcGF0aChQQ0lIb3N0U3Rh
dGUNCj4gPiAqaG9zdF9icmlkZ2UsIEBAIC0xMTIsNiArMTYwLDcgQEAgc3RhdGljIGNvbnN0IGNo
YXINCj4gPiAqYXNwZWVkX3BjaWVfcmNfcm9vdF9idXNfcGF0aChQQ0lIb3N0U3RhdGUgKmhvc3Rf
YnJpZGdlLA0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgUHJvcGVydHkgYXNwZWVkX3BjaWVfcmNf
cHJvcHNbXSA9IHsNCj4gPiAgICAgICBERUZJTkVfUFJPUF9VSU5UMzIoImJ1cy1uciIsIEFzcGVl
ZFBDSUVSY1N0YXRlLCBidXNfbnIsIDApLA0KPiA+ICsgICAgREVGSU5FX1BST1BfQk9PTCgiaGFz
LXJkIiwgQXNwZWVkUENJRVJjU3RhdGUsIGhhc19yZCwgMCksDQo+ID4gICB9Ow0KPiA+DQo+ID4g
ICBzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3Qgdm9pZA0KPiA+ICpkYXRhKSBAQCAtNDA0LDYgKzQ1Myw5IEBAIHN0YXRpYyB2b2lk
DQo+IGFzcGVlZF9wY2llX2NmZ19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJy
cCkNCj4gPiAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpFQ1QoJnMtPnJjKSwgImJ1
cy1uciIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXBjLT5yY19idXNfbnIs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gPiAr
ICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoJnMtPnJjKSwgImhhcy1yZCIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcGMtPnJjX2hhc19yZCwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gICAgICAgaWYgKCFz
eXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+cmMpLCBlcnJwKSkgew0KPiA+ICAgICAg
ICAgICByZXR1cm47DQo+ID4gICAgICAgfQ0KPiA+IEBAIC00MzYsNiArNDg4LDcgQEAgc3RhdGlj
IHZvaWQgYXNwZWVkX3BjaWVfY2ZnX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4gKmtsYXNzLCBj
b25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgICAgIGFwYy0+cmVnX21hcCA9ICZhc3BlZWRfcmVnbWFw
Ow0KPiA+ICAgICAgIGFwYy0+bnJfcmVncyA9IDB4MTAwID4+IDI7DQo+ID4gICAgICAgYXBjLT5y
Y19idXNfbnIgPSAweDgwOw0KPiA+ICsgICAgYXBjLT5yY19oYXNfcmQgPSB0cnVlOw0KPiA+ICAg
fQ0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX3BjaWVfY2ZnX2luZm8g
PSB7IEBAIC01NzMsNiArNjI2LDcgQEANCj4gPiBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVk
X3BjaWVfcGh5X2luZm8gPSB7DQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yZWdpc3Rl
cl90eXBlcyh2b2lkKQ0KPiA+ICAgew0KPiA+ICAgICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZh
c3BlZWRfcGNpZV9yY19pbmZvKTsNCj4gPiArICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGljKCZhc3Bl
ZWRfcGNpZV9yb290X2RldmljZV9pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVyX3N0YXRp
YygmYXNwZWVkX3BjaWVfY2ZnX2luZm8pOw0KPiA+ICAgICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGlj
KCZhc3BlZWRfcGNpZV9waHlfaW5mbyk7DQo+ID4gICB9DQoNCg==

