Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F98CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLML1-0000wt-JK; Fri, 08 May 2026 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLMKx-0000wX-5v; Fri, 08 May 2026 10:37:55 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLMKv-0007H8-EB; Fri, 08 May 2026 10:37:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YghEJeaVmfnwnGI7xz2etoVsOydTg355euV2QxhxGof8gSykoDWYOdYdOsX/VnHiTQX8nHPjLucX49EziYD7pWpkBLRjp2tuI+YHHnFo1CF+VtFl5TrK6LqyIhddCnw48syfOnHuLhhpzYQiG9lnidW11wOQhim5sJQyrWIjogXt8or7nL017ce9c8OF/qWURwUsBgszdeiSgdaq+g8vPb7kV3eT8+riLu7f+Q3tTeLRCjSoy11cgJeLEeAI/b1RTo6wXXZLeiWCmG0cEESbxciTIxnjIzh/KVCjd2ITSNB1f4na3eLd1HzZlU3+GoKGtw1kCAYtr7V51b6EzlDlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7MrJTO+tMNSolQ/RgcorT7bFmpUYVmwR7TkVrueygI=;
 b=jrL1vnBwRLIHcqfT5IVd/ihxS5SoPPilqmXqqGa9xtwjIds0mY484cRdpDjR0uZXRS70fwQX9tBbUDwOPBxfNscFH+4yPSL+vgyukUp9ksT2oNHsMZxtVPRuKWaPYY3qt53ak24QSi0wNMXadm/xifsC7cLKZ/6T1Qf0IEbDPo8Jxmh8QGbdB1cK6+XfeHOXra3r+njymSCFXNuqXwwqVt9tz2P5UvIxCAUIJv+AuK8j+0k1/NMdfDcYXWoyWbtEbC26FxS60FrPp2p5qEZBq9m1QNiQ7JlKoVvcvSWLJNXdzOu90MZHtaLyoI4JpgvrMU9QwnIGtIOIapTdC2LpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7MrJTO+tMNSolQ/RgcorT7bFmpUYVmwR7TkVrueygI=;
 b=TKMgAxKuJ+TYAK3iM2GW+IpnCkU8MVlm0zu10BOBTFSFJBCeb1WpPLMvO0CMy64BW/pv72ihViLKecJ4wOdy5UkolEeoVQ4z2CElAFbYpkY4WnrRIhwuKRvYgHlmcVtKQ9C6DTpTsLFSQhs3/Bw59nhoHjZDQPsUePQh8ix1OUAVv2kF3iqp/SL+k2o6gSCtRuN2w1rTqkLIUXbUzl7MClOYPSK9IjOpYGKa/PIotxxbMK+Wh2ctSc9Q6A+0CGaLB+EK7fxCaBY9of4txdxf577ruGhXfjBXx2s9RZm2xxAmoZIEaAt06pzt5CAmbWCVEhhfMQ2XZVgVOroUs/5YWg==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 14:37:45 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:37:45 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Topic: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Index: AQHczMbEqU/zgTI+9ka08AG/nQw53LYBErsAgAAZPMCAAbZdgIABEU5ggABijwCAAACbYA==
Date: Fri, 8 May 2026 14:37:45 +0000
Message-ID: <IA0PR12MB7555F2FD828FEA41D92377FEAB3D2@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-23-skolothumtho@nvidia.com>
 <4918654a-7c79-474b-9ede-5418460a5a76@redhat.com>
 <CH3PR12MB75486E45A43C6CD5A203D03BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <73730082-679d-4cee-afee-659684e420c2@redhat.com>
 <CH3PR12MB75488E10D03A85E9F0C0D622AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <c5fa0f1c-70b5-4ba3-b141-f903f3e93c56@redhat.com>
In-Reply-To: <c5fa0f1c-70b5-4ba3-b141-f903f3e93c56@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DS0PR12MB6582:EE_
x-ms-office365-filtering-correlation-id: b81619e3-e9d6-4b22-756d-08dead0f5ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: FVHq9DvpTMmtZlAW1IB9qam4XZaYmBCwVZ+ZCPGLONFguRtqdzyHMD4rVKlhoogtTFMANhqYB1rncQiKHBET2AHEID/xSOdBzq7OLBFRyBd5l4yzJlvfhDQ77S9Tt6UbDClCM49CaxyQtOtxLi/XxhDBOI+rX9hIEs2mjy1Vjjag5Xobz3Kas3rzI3wCemTWqF+zBbb4/nU2OCEWZZ7pkbAYIccuoNxrkjeQT8yFfwkSFT7VAahsyz+z1zmbXJYOb4N4YRgcg0pbrqDDWkklby1Q/V2fAdWS/2RZDEvYp64CJJkRXBKBDPyJUtyLWhBNtnroKUqkGCLk8rrONfoYGfbuz7TEjeH2g3mHviS7C+mxlT/FNQh4AffJ/MZapYDRCgKXg4YlwC2NLDB1azsvcXXbV7/pvvbv8kxPkn/ECicIS0KeZROUVzlQtOdyQhvCjUXtMv0V6hEcWvp+3safEoNu5GsY6GlLrVzGBXPHE4X/5cMHtB0Jpe5k+xsbRVkuzip2CULT/qquEYm5GtMDMNyosod5K2YmApNi+mqAurJtJN8r+vknZxxz4fBqbG/IQ6EA5ffxbQOmYBgNwMAFnnCfzBEP9FR0eM3gl9YPpyseUlI7q3ANhhuDeKxTzSYIzfrhlak6N0nd1uVGVPFjBDrhdR1P1G+sJafUrleZfOjR5pMeNehCWvB5srHBrvOf3YgGUVWvgTGpRy6Ph9aR8w6fQ3dTOEKCHNyds8ZEq3pAm7ZoZgQPO56aBIplXkgK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzdFNnNZNnNDdDFSeTRIYlNVT3grZnhCL2V1aGhOR1F4OER3VFU1Vy9ucHc2?=
 =?utf-8?B?WFVaUFNNOFBLZGNFWnZnUzl4am5NeFpmK2Vubnplazl0S3N0THZZRlpBdnIv?=
 =?utf-8?B?QXAya1ZGWTNFWXEvRlduTkw4WWxDMDVuTDJuanhPYVAxeVlxT0VKNzlBSkdl?=
 =?utf-8?B?cHNxaTF0YkhaSy9EcW52TXNMT3Jlb1ZlYkNhSk42QTJsa1g5d1lNTnR6YWRt?=
 =?utf-8?B?K3BsWSs2ek1wWExJcHFGNkx4TVdxWkVYc2hFZm1hMk1JMk9HZHVad2dLMjAw?=
 =?utf-8?B?dndrcjVOUkI4UHlnNmxwWmpXQUE4ZUIzSTV6WmNENC81SkpzN25mYzhTMnpL?=
 =?utf-8?B?T2tjd1JLT2RkbDYzMDZwT3IwNEQ5b1RiWFYyREpFUjFsM0tKbTFTSWQwRjFw?=
 =?utf-8?B?eTA4Y1lDczNiNS9pckdFd3hkNWc0V3l6THFnanZXdjMycjhjNEJDVTNYQnpo?=
 =?utf-8?B?ZWJuV3Q4OG5XT2JZbmJKSTl6b3FYcy81T2VDOFFPSEgvNlAxV25mcUJqTFZl?=
 =?utf-8?B?SFEyTHp4MkJmZ1hxcHpyK0xlbVYxZWxaM3RjYlpyaEdINFltQVRjKzNYeUxY?=
 =?utf-8?B?VEloQ0ZNNEhIUFF3V1ZYT2ZxRWVDRmdZUS82RjcyYTVqTEQzbjMxSkVKU2h6?=
 =?utf-8?B?clBKc3RTQnVMeVZpWXc3MjM0UThMQjAwWmRZeFJ5YXBWTUtHTWRRMlJHMFly?=
 =?utf-8?B?bmc2RUhUMTRyNmVjSnBqeXFzQjh5OU1mSUZVUWNNN0xuVmthNDI3TkFOa0ls?=
 =?utf-8?B?NkR5WlpWcVFtc2xvRFplK1pzdXdtMjFBYitWSWpNOU9yNVc3OGpvZG5zUzhM?=
 =?utf-8?B?YjhmRzVIWFRCNmVKQnFGVks5SEswcE5SMGw5aHBvNW1PdEdjVmxHakdxUDVx?=
 =?utf-8?B?UzQwWXpVWTVHZ0VrZXlHK1FMV3JvcGtYNTdNa1F5akFPcFRBeWRqc0hhSURs?=
 =?utf-8?B?eEdnendWV1VEN08wd3BBSDA4QXIyNjNCRGRGTmtNRStnWXlBNWdVMW1wcXVF?=
 =?utf-8?B?NHZyaHduWEdGWXJlYzFpbnVrMWh0YTQ2aXF0eXNGS2h4dWtPVkk4UTZwSTE4?=
 =?utf-8?B?OGpmb2tZVzlEa2tZK2g1YTd0emVpbXR2NUk0ZGNEOHk1VEJYNG1Sck9NYXNW?=
 =?utf-8?B?d1RHbXloSU5hUktzRDl2Ulk3Tk5VWU1YVHpvMDZielMrYVlYTk5yV042VEYy?=
 =?utf-8?B?ejhROHhzT2tmMXhqT0NtUnd6VVdHTnlhb0tRa2hXOVUxN0VkdXdxTDUwbnds?=
 =?utf-8?B?YlNMZkZlaTVUVlhYQkt3Tnl3TTBHZlRRZXluN3RoUDBhT0dYNzRwWFlCWnk3?=
 =?utf-8?B?ajFyUVRIa3Q2OWdId0JEM2liQUtpY0I2UTZoYzU5V1FLeWtMQU5UcHRnTEVo?=
 =?utf-8?B?MzJvQ1M2Ui90U1dzRDl6a0VhQU52bllBc1VEU3BFZzk0aGtqQUtmVkVISXpn?=
 =?utf-8?B?M1k0aXpLYitDcWZoSGsydDFnTHE0RGo2UFdhMlk5ZlExeVpkR3VCQmlTRkQv?=
 =?utf-8?B?aUpFcmxOSjFFUmkzdnhJQysyWlEvcjJWbzUyVGhPYzJLTnY3Z2Y4b2NUVmNu?=
 =?utf-8?B?MjAyK0RuZlRaR0ZRZHIxUnA1STdGV0tlQlpUOXgrNmp3cjJJVWFVOTh6UG5l?=
 =?utf-8?B?SUNiTE5UcHN3dDdHR0MydllTa2FmUE9kQzFOVmx2bkx3NExRcXU4b2Fabi96?=
 =?utf-8?B?YzI4bWZBbG12cGNyRmw4OFFob2dGcGt0Z08wVjJORitWeEp0RmFBOFltQnZj?=
 =?utf-8?B?WEFYaXl2U3JIQlNGVm5zY0dPWGFiakVYN1FYd2REZmpwMGFZcnFxRVpCdjZj?=
 =?utf-8?B?cktwbjdLY1FLLzAzZGxlUjdmTFpIRGZMUEtrRldiVHQ2WmtwT3RDOWVmbC9h?=
 =?utf-8?B?b1pXanNHTjRRUm1LRWlmcG11YiswYWJLWmJRcFpVa2w5S21EMklSTFRlQXZw?=
 =?utf-8?B?eUpqNFQxK0tRckFzL1RVTURJS3lwb1dVVFdYN1phaWFzNzdkbUU4YTZORDhk?=
 =?utf-8?B?ZEtqdm4wL3B5UnJjRkFMOW1XRCtaVGFsWWxSUys0MlBObXZYTENyUi9BbmIr?=
 =?utf-8?B?TTNBY2Rwd0dHODNJMEpBZ0tON0JlaC9VaCtwR0FoeUtydVJrWDF2ME1Od2Nt?=
 =?utf-8?B?a3kzRVIwTkNWcmxwRUNVNUVmck1WWHF4Y1JSMzcyL0NNNWhsUHk3THd6ZzNz?=
 =?utf-8?B?YkV2VGk3aGtnY2dycHpBT1FGeCs0R3VTZ2xIWmJqbGlwV2hodXdPRHlwZG1C?=
 =?utf-8?B?bzdwU3doNFhOWlJJY2pMOEwzSXdHNHV1TExLeTVycjMzYWJqYmIwem5XZEhL?=
 =?utf-8?B?RUVNZmpSRXhKdHBWQThyRDRiZExBTG43aTJZbnNSQVR5QStYTmNLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81619e3-e9d6-4b22-756d-08dead0f5ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 14:37:45.7093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXcXjC2hOTAa343MzbRm+zcESwkNB1pw5rCW7m+h+YpXTq6k/m+lkbmRQTVXHZ1eqoTuV8JUVTQPVY2ilClwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwOCBNYXkgMjAyNiAxNTozNQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDIyLzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IE1hcCBWSU5U
RiBwYWdlMA0KPiBpbnRvIGd1ZXN0IE1NSU8gc3BhY2UNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gNS84
LzI2IDExOjAzIEFNLCBTaGFtZWVyIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+IEhpIEVyaWMs
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRXJpYyBB
dWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+PiBTZW50OiAwNyBNYXkgMjAyNiAxNzoy
NA0KPiA+PiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5j
b20+OyBxZW11LQ0KPiA+PiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+
ID4+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNo
YXpib3Qub3JnOyBOaWNvbGluDQo+ID4+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRo
YW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dA0KPiA+PiBPY2hzIDxtb2Noc0Budmlk
aWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA+
PiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+ID4+IHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNv
bT47DQo+ID4+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0
IDIyLzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IE1hcCBWSU5URg0KPiBwYWdlMA0KPiA+PiBp
bnRvIGd1ZXN0IE1NSU8gc3BhY2UNCj4gPj4NCj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4NCj4gPj4NCj4gPj4gT24gNS82
LzI2IDQ6MjQgUE0sIFNoYW1lZXIgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4+PiBIaSBFcmlj
LA0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPj4+PiBTZW50OiAwNiBNYXkg
MjAyNiAxMzo0NQ0KPiA+Pj4+IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10
aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+ID4+Pj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KPiA+Pj4+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGNsZ0ByZWRo
YXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOw0KPiBOaWNvbGluDQo+ID4+Pj4gQ2hlbiA8bmljb2xp
bmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+Ow0KPiBNYXR0
DQo+ID4+Pj4gT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEppYW5kaSBBbiA8amFuQG52aWRpYS5j
b20+OyBKYXNvbg0KPiA+PiBHdW50aG9ycGUNCj4gPj4+PiA8amdnQG52aWRpYS5jb20+OyBqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+ID4+Pj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29t
OyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPjsNCj4gPj4+PiBwaHJkaW5hQHJl
ZGhhdC5jb20NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIyLzMxXSBody9hcm0vdGVn
cmEyNDEtY21kcXY6IE1hcCBWSU5URg0KPiBwYWdlMA0KPiA+Pj4+IGludG8gZ3Vlc3QgTU1JTyBz
cGFjZQ0KPiA+Pj4+DQo+ID4+Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSGkgU2hhbWVlciwN
Cj4gPj4+Pg0KPiA+Pj4+IE9uIDQvMTUvMjYgMTI6NTUgUE0sIFNoYW1lZXIgS29sb3RodW0gd3Jv
dGU6DQo+ID4+Pj4+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gT25jZSBhIFZDTURRIGlzIGFsbG9jYXRlZCwgbWFwIHRoZSBtbWFwJ2Qg
dmludGZfcGFnZTAgcmVnaW9uDQo+IGRpcmVjdGx5DQo+ID4+Pj4+IGludG8gdGhlIGd1ZXN0LXZp
c2libGUgTU1JTyBzcGFjZSBhdCBvZmZzZXQgMHgzMDAwMCBhcyBhIFJBTS1iYWNrZWQNCj4gPj4+
Pj4gTWVtb3J5UmVnaW9uLiBUaGlzIGVsaW1pbmF0ZXMgUUVNVSB0cmFwcGluZyBmb3IgaG90LXBh
dGgNCj4gQ09OUy9QUk9EDQo+ID4+Pj4+IGluZGV4IHVwZGF0ZXMuDQo+ID4+Pj4+DQo+ID4+Pj4+
IEFmdGVyIHRoaXMgcGF0Y2gsIHRoZSB0d28gVkNNRFEgYXBlcnR1cmVzIHVzZSBkaWZmZXJlbnQg
YWNjZXNzIHBhdGhzOg0KPiA+Pj4+PiB0aGUgZGlyZWN0IGFwZXJ0dXJlICgweDEwMDAwKSByZW1h
aW5zIFFFTVUtdHJhcHBlZCBhbmQgd3JpdGVzIHZpYQ0KPiA+Pj4+PiB2aW50Zl9wdHIsIHdoaWxl
IHRoZSBWSSBhcGVydHVyZSAoMHgzMDAwMCkgaXMgYSBkaXJlY3QgZ3Vlc3QgUkFNDQo+ID4+Pj4+
IG1hcHBpbmcuIEJvdGggcGF0aHMgd3JpdGUgdG8gdGhlIHNhbWUgdW5kZXJseWluZyB2aW50Zl9w
YWdlMCBtZW1vcnksDQo+ID4+Pj4+IHNvIG5vIHN5bmNocm9uaXNhdGlvbiBiZXR3ZWVuIHRoZSBh
cGVydHVyZXMgaXMgbmVlZGVkLg0KPiA+Pj4+IEkgZmFpbCB0byB1bmRlcnN0YW5kIHdoZW4gdGhl
IHByZXZpb3VzIHRyYXBwZWQgcGF0aCB1c2luZyBwdHIgaW4NCj4gPj4+PiB0ZWdyYTI0MV9jbWRx
dl9yZWFkL3dyaXRlX3ZjbWRxIGdldHMgdXNlZCB2ZXJzdXMgdGhhdCBwYXRoLiBJcyBpdA0KPiA+
Pj4+IGV2ZW50dWFsbHkgdXNlZD8NCj4gPj4+IFRoZSBzcGVjIGRvZXMgbm90IHByZXZlbnQgYSBn
dWVzdCBmcm9tIHVzaW5nIHRoZSAweDEwMDAwIHBhdGggZm9yDQo+ID4+IGFsbG9jYXRlZA0KPiA+
Pj4gVkNNRFFzLCBzbyB0aGUgdHJhcCBwYXRoIHJlbWFpbnMgdmFsaWQgYW5kIFFFTVUgZm9yd2Fy
ZHMgdGhvc2UNCj4gYWNjZXNzZXMNCj4gPj4gdG8NCj4gPj4+IHRoZSBtbWFwJ2QgdmludGZfcGFn
ZTAgdmlhIHZpbnRmX3B0ci4NCj4gPj4+DQo+ID4+PiBXZSBjYW5ub3QgbWFwIDB4MTAwMDAgZGly
ZWN0bHkgdG8gdGhlIGd1ZXN0IGFzIFJBTSBiZWNhdXNlIHRoZSBrZXJuZWwNCj4gPj4+IG1tYXAg
b25seSBiYWNrcyBWQ01EUXMgYWN0dWFsbHkgYWxsb2NhdGVkIHZpYSBIV19RVUVVRSBpb2N0bC4g
SWYgdGhlDQo+ID4+PiBndWVzdCBhbGxvY2F0ZXMgb25seSAxIG9mIDIgVkNNRFFzLCBleHBvc2lu
ZyB0aGUgZnVsbCBkaXJlY3QgYXBlcnR1cmUNCj4gcGFnZTANCj4gPj4+IGFzIFJBTSB3b3VsZCBn
aXZlIHRoZSBndWVzdCBhY2Nlc3MgdG8gdW5hbGxvY2F0ZWQgVkNNRFEgc2xvdHMuIEhlbmNlLCBp
dA0KPiA+Pj4gcmVtYWlucyB0cmFwcGVkIGFuZCBRRU1VIG9ubHkgZndkcyB0byB2aW50ZiBwYWdl
MCBmb3IgYWxsb2NhdGVkIHF1ZXVlcy4NCj4gPj4gQWN0dWFsbHkgbXkgcXVlc3Rpb24gcmF0aGVy
IHdhcyB3aHkgZG9uJ3Qgd2UgdXNlIGEgc3VicmVnaW9uX292ZXJsYXAgZm9yDQo+ID4+IGdsb2Jh
bCB2Y21kcSBwYWdlMCwgbWFwcGluZyB0byB2aW50Zl9wYWdlMCBvbmNlIGNtZHF2LT52aW50Zl9w
YWdlMCBpcw0KPiA+PiBzZXQsIGp1c3QgYXMgd2UgZG8gZm9yIFZJTlRGMCBwYWdlMD8gSSB1bmRl
cnN0YW5kDQo+ID4+IHRlZ3JhMjQxX2NtZHF2X3JlYWQvd3JpdGVfdmNtZHEgd291bGQgcmV0dXJu
IHRoZSBzYW1lIGNvbnRlbnQNCj4gYW55d2F5Lg0KPiA+IFRoaXMgaXMgbXkgdW5kZXJzdGFuZGlu
ZyB3aHkgd2UgY2Fubm90IG1hcCBkaXJlY3QgVkNNRFENCj4gYXBlcnR1cmUoMHgxMDAwMCkNCj4g
PiB0byB2aW50Zl9wYWdlMDoNCj4gPg0KPiA+ICAtIFVuYWxsb2NhdGVkIFZDTURRcyBhY2Nlc3Nl
ZCB2aWEgdmludGZfcGFnZTAgZ2V0ICJhY2Nlc3MgZHJvcHBlZCB3aXRoDQo+IG5vDQo+ID4gICAg
IEZhdWx0L0ludGVycnVwdCIgYmVoYXZpb3VyIHBlciBzcGVjKChwLjE3MikNCj4gPg0KPiA+ICAt
IE1hcHBpbmcgdGhlIGRpcmVjdCBWQ01EUSBhcGVydHVyZSAoMHgxMDAwMCkgdG8gdmludGZfcGFn
ZTAgd291bGQNCj4gcmVwbGljYXRlDQo+ID4gICAgdGhpcyBiZWhhdmlvdXIgZm9yIHVuYWxsb2Nh
dGVkIFZDTURRIGFjY2Vzc2VzIHZpYSB0aGUgZGlyZWN0IGFwZXJ0dXJlIHRvby4NCj4gPg0KPiA+
ICAtIEhvd2V2ZXIsIHBlciBzcGVjIHAuMTc2LCBzb2Z0d2FyZSBjYW4gcHJvZ3JhbSBWQ01EUXMg
dmlhIHRoZSBkaXJlY3QNCj4gPiAgICBWQ01EUSBhcGVydHVyZSB3aXRob3V0IGdvaW5nIHRocm91
Z2ggdGhlIFZJTlRGLiBNYXBwaW5nIHZpbnRmX3BhZ2UwDQo+ID4gICAgYXQgMHgxMDAwMCB2aW9s
YXRlcyB0aGlzLg0KPiA+DQo+ID4gICAtIFBhcnRpYWwgYWxsb2NhdGlvbiBjYXNlIChWQ01EUTAg
YWxsb2NhdGVkLCBWQ01EUTEgbm90KTogdGhlIHRyYXANCj4gY29ycmVjdGx5DQo+ID4gICAgIHNl
cnZlcyBWQ01EUTEgYWNjZXNzZXMgZnJvbSBRRU1VIGNhY2hlIHdoaWxlIGZvcndhcmRpbmcgVkNN
RFEwDQo+IGFjY2Vzc2VzDQo+ID4gICAgIHRvIHZpbnRmX3BhZ2UwLiBBIGRpcmVjdCBSQU0gbWFw
cGluZyBjYW5ub3QgbWFrZSB0aGlzIGRpc3RpbmN0aW9uLg0KPiANCj4gSSBhZ3JlZSB0aGF0IG5v
cm1hbGx5IHdlIHNob3VsZG4ndCB1c2UgVklOVEYgdmlldyBmb3IgdGhlIGdsb2JhbCB2aWV3Lg0K
PiANCj4gV2hlbiB5b3Ugc2F5ICJ0aGUgdHJhcCBjb3JyZWN0bHkgc2VydmVzIFZDTURRMSBhY2Nl
c3NlcyBmcm9tIFFFTVUgY2FjaGUNCj4gd2hpbGUgZm9yd2FyZGluZyBWQ01EUTAgYWNjZXNzZXMg
dG8gdmludGZfcGFnZTAiLCB0aGUgZmlsdGVyaW5nIGlzIGRvbmUgYnkNCj4gdGVncmEyNDFfY21k
cXZfdmludGZfcHRyLiBXaGF0ZXZlciB0aGUgcXVldWUgYmVpbmcgZW5hYmxlZCwNCj4gY21kcXYt
PnZpbnRmX3BhZ2UwIGlzIGFsbG9jYXRlZC4gU28gb25seSB0aGUgdGVzdCBvbiBjbWRxdi0+dmNt
ZHFbaW5kZXhdDQo+IGRvZXMgdGhlIGZpbHRlcmluZyBpbiB0aGF0IGNhc2UsIGNvcnJlY3Q/DQoN
Clllcy4gVGhhdCBpcyBjb3JyZWN0Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

