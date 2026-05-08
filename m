Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFC4CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLJEr-0007aH-E7; Fri, 08 May 2026 07:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLJEp-0007Zh-IV; Fri, 08 May 2026 07:19:23 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLJEj-0003f0-Sj; Fri, 08 May 2026 07:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYDSYE1lJpkextMu7BbgyBeqrCQRid0cQ5KJt+e3Vuc2I+mmAb5MxsPJcz5DtQPcjzZOVHy/1I4mZvJ3hjR9rHHQGcBBZZceZeF4/oSg8aQw2fLyhMCVO6Aufb4v/SZXQcaMPqjOfpNTMiQ6yNAVpARIfyA9GzMcXvvAj5i4ZR0bCk+zJzY9OdgXY12CPfOIlnOJAwAyOiSAPX9O2hZV79PglP+IL+oPmpEVGY82zNvGG8qO0ow90IZeIXERkiZVsw5hRbSGFZ6nZYZfWXBpLupc1lSmKU3HQJzl/TTsGZSc3Kl2qPOvnffgVRHUBWQ25ubyDUxTpWF6B3PLN35ZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+jQmwk0lb+W/oyUbknjKsdGO+PKTHt6h4GfW2CFvRQ=;
 b=dU1WmiUGTa0A49Zg4DSOq2+RpqaokS22eKLeZ+4v3X/BgWUZPFL9hTXVL3rPuRvLdLcLIae5p68yLRA34S+HYs7IjuD1gq7lgfdpYQvN0IolVT9z5S1p/m9ut/95g7IXh9zwc2TAHNBWcwngRNT3Ik6tnlopcOOkyXvhAuRaRDiIx1IU+cCKV3J028mPVHI8yMrLS/aRPSaCFiLEvuRwzMomUKLnogTeWsIXIh8HROjnp0cosOt2NyEariiJFnRoY1e41z3E/6A3O5jbhFGttN4ZYKiB2+eL8xVrFcpnMFHI9sEwn39J4QcTtEiTKUlp4tjB817rSyE/EhgsDnaVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+jQmwk0lb+W/oyUbknjKsdGO+PKTHt6h4GfW2CFvRQ=;
 b=k0ap4av3r+zr/6eymMnaHLoY/+BmAuPNwy0xiY2Pt/q8rV6N0hcHIatQbZ1veepmhqQIG1hNMATrJrsTVgivhqE1tA2LNTCyJzoM2+js+d6FuXi9jtuZKfwqZ4MBNLYYvRmzzPGCEH1je5fsIRmGrU+E8UW8/148JlWnq0DeGQ6YBMxs+GubTWNK1G0wBr0VIoMngEo6bu8f3eD0vm5ylyd7ga0RqVRbq35MrKs6Ht6hdrHMTTeMGcq3y+4idUOyWxSSTCK3jGVnPesTuds7q+IiOPL/737dPLX0AflI2vnBHMcrafr5oYklkj+OaeJJj7ZwYxHjqqbeMRT9BlnkJg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 11:19:08 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 11:19:08 +0000
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
Subject: RE: [PATCH v4 25/31] hw/arm/tegra241-cmdqv: Add reset handler
Thread-Topic: [PATCH v4 25/31] hw/arm/tegra241-cmdqv: Add reset handler
Thread-Index: AQHczMbM+Dvk4IU9AkyeKvF2jnM+F7YC6fSAgAE0sAA=
Date: Fri, 8 May 2026 11:19:08 +0000
Message-ID: <CH3PR12MB7548B3CEB0292498F65837D1AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-26-skolothumtho@nvidia.com>
 <667dd47e-bb1a-47d7-bd19-194efade286a@redhat.com>
In-Reply-To: <667dd47e-bb1a-47d7-bd19-194efade286a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH8PR12MB6676:EE_
x-ms-office365-filtering-correlation-id: d8e5e916-3bc0-44eb-8274-08deacf39f7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: +tUXJz1cbS91PPGypu9itSz3RcVRFcU4ewmvlAeSD0+eVJu2MBxEk9FQ1febO36xC59nfL/ivd48Ob92Ku5bGggJPbs+XuC1wt3uL63niMT4GxE1x3UCzuf/cW3+sQIIueWhHj9orM0kFevfuzZFd8+hGhvAjA9DPxjJo8mMgmdUnuH0T5xEfJHgntuz2lH/Iks131LSbPg1Q2I8ytlp8O3zzVygsp5/7TFBPRYmdwZlFq9cb1qXYmX+uRRdQo487UDKBnhwLHnzKFpZVP7EXg+wHOWrk9YrOtiX3Dx+CDkloPWKiOb6lSaVSfPMWNn1EFntxVquLrjRWq7tlBcnr3wacdxOn0b0dQvunLnUQ48nBaGUZUB7H6lrre51jBYSjwGJUNB5HX4VhvXnpRJ1fO1iKTXThJF6+j3EoqCcLL9n+TbvOts5ck8nI/rZd93F/oTgAIG/4RzqwHF+TNae5GIY2v+Irr8O9LMNKNbeFO8FTLYqMmMeWDMgIE7QLgh++2o6+6rq/qUx4Fs3tGzqy/o+cOCkXp7FSgSbB6ogldqaxNisFQd8y8V78dF2DCP8v4jKdfxZiGxqPR9aIKg1WKlZAWkG1r1c5eMF4nqsn89j61ZqvaZBgUKhSqSPPB/ywNldCMd6sUZL5UA7cjxDIHqIIqJeRwS4x5o06pv0qY0jGj+9n98zqmqH2cU0z6ikSrZ0I737AVAZ+QgD1KNOrJnkBXEBnIBIqlbg242tFbHwYR5DIf9XLtetLVhgkw5Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE8wK2Q2dkdPOXFpZXhaZ1kxbEZXWkJCOVhoeFdFYnk3OWluY1hpSk5odDRX?=
 =?utf-8?B?TGJOWFowUzlTa1l3SWlBdjc0T2JuQlY5Wjh4bkVocDRvVGgxNXprdm9kRW1P?=
 =?utf-8?B?UzJGbmRXbG5RTzNIMzRJUVZHaU1DcTFlL2hLTFQxQWNqNkNxZ09mSGQxTUhh?=
 =?utf-8?B?cDB6UHNNWnlMLytMeDFRdkNQWThGM0JPSzc1NVR5RW5OS20vS0srNFkxTERX?=
 =?utf-8?B?QmpJMnVXTVJoaUFmTHI3ZmUxTkRkT01SMStJV2ZUS3RVeUVMcUpLSkUxcTBs?=
 =?utf-8?B?VGIzM083YjF1RHRQREpnRjNEbmZLajNDdlZDdlhJVFRHTlF3N0YwV1BmeWJm?=
 =?utf-8?B?TlZxSE4zZ0duNnNTK1pDOGdBNXltZUV2b3ZVdkRSbi9uNlhVSUhMY3cxbUJL?=
 =?utf-8?B?TTJ2eVZ1L3lPSElGMEFYMEJ1bzZpM0RpcUdXNUVPb25reTVMR1Y5OVFFMmtV?=
 =?utf-8?B?NEpDbzlhNnA5VWNvQVBwNmE1R1BDVXdpQjBpUDZJN2hqeVlwZk15SVROOUNy?=
 =?utf-8?B?SHhNYXFreW5wVFJuOGpPYUg3ZzVZUmVoRmNGb2x0eEx1dWczaCtXU2VsQUZq?=
 =?utf-8?B?RWkzdHpwc3FFaVgwWEVqNmJhanJRS1daQjVISUFmUUdQMTFhbG8yQ3RBUkRa?=
 =?utf-8?B?L0JoeHZXc0M5WnlZUUdFb2gwajkvbnRRYWlhQktUS1FlUGx3d25iWU5ySjFt?=
 =?utf-8?B?S05mY0ZOakQwYlFKOVRJeVFCV3NSdW5MQWg5NnkrTlY3eGpTb2kvTUZpa25L?=
 =?utf-8?B?MGRZSk9rbVk4ZFQ2cXpPMXYzcXB1TVNIWmlGTDhybjZLeG9EK1ZJdVRrekFR?=
 =?utf-8?B?KzZKbzduSXNwVGt6WENqYkxyU2xkZWVva0phQ2N5bEVxTHQ1cmlBc2NCd1ZD?=
 =?utf-8?B?c3crZml4blp1aVpFdTVTOWR1OFhnV1lQQ09JUkdIVFhXVzhna1pkUVBkZDVR?=
 =?utf-8?B?WHBVYzFQZ0dDZTFjMHNOYW55bFdiQzVjQlRBQ1c2MjUydUxoUUIvVy9oUTNE?=
 =?utf-8?B?QzNQaG1KNENCWW5wUVY2SjV5alpQL1ltS21oTXMvc2taT1RsWEJVbmQ2dDBv?=
 =?utf-8?B?SVdqcGZSb20xL3BxR3B4c0hYTi9URFZuUzRRQyswQnNKKzIzN0t1U0JoY0xu?=
 =?utf-8?B?MVBTRGNVS1dXUkt4eTk0RXNqektyRlBUU081MUZ6T1NqZm8vekY1SjBEK0Va?=
 =?utf-8?B?a1hVK2hzYno4UnBDMmM0M1lXN1RZem1EL0U1dy94RVZWVEtiVUZRVG84L2U4?=
 =?utf-8?B?MCtCai9kK3BGRzI1a1lmOHVuS2wwcEtsOUUwUC8xZGN2dG80M1N6Vi9GNXRW?=
 =?utf-8?B?VExpMVkxMkpGTGhQUDFiMU1yQ1VkVnFqZkJ3bEt4OHFwamJmU3ZYZnpGelE5?=
 =?utf-8?B?THRwRm9jSTdxWmh4ZXZXeVY5cGdmN0wzNThyYWR3Q0hka2ZrRDNwR0pwMmxE?=
 =?utf-8?B?QTVqSkJ3eER6a0RuLzBoUXg3aFRkbkpTcis3cGN1SUd0dlhPVFVnRGJWekIx?=
 =?utf-8?B?NkNkakR4cTRrWHEwUXR5TlBhSmxmemxuSlJzL1lvYUFCQW9WV0FBVXhiWnJ0?=
 =?utf-8?B?LzBWaE5FWVZITW1sdVE5UGY4bllkdUJLK1hMUXJpU1dyWjFJWXNhS040U3Bl?=
 =?utf-8?B?TFhaeDJGcHlxYWk2NHBNZE5EN3psOUhvekdyN3ozd2ZMSVZhY2tFWTNlc05Q?=
 =?utf-8?B?UThGWlJVVTVneG9NQVA2NjUySGhoUm56c3UrcjBWWFlranF5ajRqWSs3QWtS?=
 =?utf-8?B?MWJEMzVVZEtaWFdLRGM0ZlZkNS9tbHVvN2VITUxPTGRseWJQL0UxYlRRMWNF?=
 =?utf-8?B?L1YyYUNXRmhjK0RUdzI5YkdXdUJrdU5yT1pjbXp1TTVjcitiMWUremdQOFpM?=
 =?utf-8?B?cUNCd3U2VmF0QjNnYXN3SUxtQzhERFRFZkVxSTl5Vk45SUFkZ1J6VnVXZ2pa?=
 =?utf-8?B?NXFWOFVGU2ZybDZNR1ZlU1F5Rkc3QnluWVRoQ0NDbUEwV1hsa3p3ZE5RZS8w?=
 =?utf-8?B?WStNajZ1TzJjREhjTS9zbW8reWZMdkNJWC8rSFNTNjl4dmV0ZzUydVV0VmhH?=
 =?utf-8?B?ZmtRV242NXA5MXA5Sk4xQzg3UGVHZkxrSGZTRVA0TGwzeGJ5dCsrOENXRnpq?=
 =?utf-8?B?dXR5Uzk4V3dIYWJMaHdXVG5LUi9rWVdKUm51R0Q2V1cyUm1pZGVhU0I1cU1z?=
 =?utf-8?B?MEowRGdhL0JEeVdMMDVrVllNdzlzYzdJVlhJRHh6NzRXYUtTMWZyOHExNWty?=
 =?utf-8?B?ZXM2YUI3WGtmMkJEa0s2U1MwUk1YY2FnTFBuaDNnVkVNWk1mMTF2eXhiNGxN?=
 =?utf-8?B?SU9OT3ZtOUxPTHdMc2wzbE5oUHAyWUx1SGRzYUJNM2JXbEhDbC9KUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e5e916-3bc0-44eb-8274-08deacf39f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 11:19:08.5891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnQN5kgDpla22neXx+Ir4dmu5qsPmwZcqlCSJUKG1kuMQkpdC96z/v32sZhJQGDzo6GqLbXgxPCTVNNOXqctRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNyBNYXkgMjAyNiAxNzo1Mg0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDI1LzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IEFkZCByZXNl
dCBoYW5kbGVyDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDQvMTUvMjYgMTI6NTUgUE0sIFNoYW1lZXIg
S29sb3RodW0gd3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEu
Y29tPg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgcmVzZXQgaGFuZGxlciBmb3IgdGhlIFRlZ3JhMjQx
IENNRFFWIGFuZCBpbml0aWFsaXplIGl0cw0KPiA+IHJlZ2lzdGVyIHN0YXRlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0K
PiA+IC0tLQ0KPiA+ICBody9hcm0vdGVncmEyNDEtY21kcXYuaCB8ICAyICsrDQo+ID4gIGh3L2Fy
bS90ZWdyYTI0MS1jbWRxdi5jIHwgNTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgaHcvYXJtL3RyYWNlLWV2ZW50cyAgICAgfCAgMSArDQo+ID4gIDMg
ZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L2FybS90ZWdyYTI0MS1jbWRxdi5oIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmgNCj4gPiBpbmRl
eCAyYmVmYTYyMDVlLi5iMmE0NDRkYWVmIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS90ZWdyYTI0
MS1jbWRxdi5oDQo+ID4gKysrIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmgNCj4gPiBAQCAtNzks
NiArNzksOCBAQCBGSUVMRChDT05GSUcsIENNRFFfTUFYX0NMS19CQVRDSCwgNCwgOCkNCj4gPiAg
RklFTEQoQ09ORklHLCBDTURRX01BWF9DTURfQkFUQ0gsIDEyLCA4KQ0KPiA+ICBGSUVMRChDT05G
SUcsIENPTlNfRFJBTV9FTiwgMjAsIDEpDQo+ID4NCj4gPiArI2RlZmluZSBWX0NPTkZJR19SRVNF
VCAweDAwMDIwNDAzDQo+ID4gKw0KPiA+ICBSRUczMihQQVJBTSwgMHg0KQ0KPiA+ICBGSUVMRChQ
QVJBTSwgQ01EUVZfVkVSLCAwLCA0KQ0KPiA+ICBGSUVMRChQQVJBTSwgQ01EUVZfTlVNX0NNRFFf
TE9HMiwgNCwgNCkNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9o
dy9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IGluZGV4IDljMmZjMDJiOTIuLmFmNjhhZGQyZjAg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9h
cm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC04LDYgKzgsNyBAQA0KPiA+ICAgKi8NCj4gPg0K
PiA+ICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9lcnJvci1y
ZXBvcnQuaCINCj4gPiAgI2luY2x1ZGUgInFlbXUvbG9nLmgiDQo+ID4NCj4gPiAgI2luY2x1ZGUg
Imh3L2FybS9zbW11djMuaCINCj4gPiBAQCAtNjQ1LDggKzY0Niw1NyBAQCBmcmVlX3Zpb21tdToN
Cj4gPiAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIHRl
Z3JhMjQxX2NtZHF2X2luaXRfcmVncyhTTU1VdjNTdGF0ZSAqcywgVGVncmEyNDFDTURRVg0KPiAq
Y21kcXYpDQo+ID4gK3sNCj4gPiArICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgIGNtZHF2LT5j
b25maWcgPSBWX0NPTkZJR19SRVNFVDsNCj4gPiArICAgIGNtZHF2LT5wYXJhbSA9IEZJRUxEX0RQ
MzIoMCwgUEFSQU0sIENNRFFWX1ZFUiwgQ01EUVZfVkVSKTsNCj4gaHcvY29yZS9yZWdpc3RlcmZp
ZWxkcy5oOiNkZWZpbmUgRklFTERfRFAzMihzdG9yYWdlLCByZWcsIGZpZWxkLCB2YWwpDQo+IHdo
YXQgZG9lcyB0aGlzIDA/DQoNCkkgdGhpbmsgaXQgaXMgdG8gbWFrZSBzdXJlIHdlIGhhdmUgbm8g
Z2FyYmFnZSBzZXQgZm9yIG5vbi1maWVsZCBiaXRzLg0KU3RhcnRpbmcgZnJvbSAwIGd1YXJhbnRl
ZXMgbm9uLWZpZWxkIGJpdHMgYXJlIGNsZWFuLg0KDQo+ID4gKyAgICBjbWRxdi0+cGFyYW0gPSBG
SUVMRF9EUDMyKGNtZHF2LT5wYXJhbSwgUEFSQU0sDQo+IENNRFFWX05VTV9DTURRX0xPRzIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENNRFFWX05VTV9DTURRX0xPRzIpOw0K
PiBJIHdhcyBhIGJpdCBwdXp6bGVkIGJ5IHRoZSBGSUVMRCBuYW1lIGJlaW5nIHRoZSB2YWx1ZSBu
YW1lIGJ1dCB3ZWxsLg0KPiA+ICsgICAgY21kcXYtPnBhcmFtID0gRklFTERfRFAzMihjbWRxdi0+
cGFyYW0sIFBBUkFNLA0KPiBDTURRVl9OVU1fU0lEX1BFUl9WSV9MT0cyLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBDTURRVl9OVU1fU0lEX1BFUl9WSV9MT0cyKTsNCj4gPiAr
ICAgIHRyYWNlX3RlZ3JhMjQxX2NtZHF2X2luaXRfcmVncyhjbWRxdi0+cGFyYW0pOw0KPiA+ICsg
ICAgY21kcXYtPnN0YXR1cyA9IFJfU1RBVFVTX0NNRFFWX0VOQUJMRURfTUFTSzsNCj4gPiArICAg
IGZvciAoaSA9IDA7IGkgPCAyOyBpKyspIHsNCj4gPiArICAgICAgICBjbWRxdi0+dmlfZXJyX21h
cFtpXSA9IDA7DQo+ID4gKyAgICAgICAgY21kcXYtPnZpX2ludF9tYXNrW2ldID0gMDsNCj4gPiAr
ICAgICAgICBjbWRxdi0+Y21kcV9lcnJfbWFwW2ldID0gMDsNCj4gPiArICAgIH0NCj4gPiArICAg
IGNtZHF2LT5jbWRxX2Vycl9tYXBbMl0gPSAwOw0KPiA+ICsgICAgY21kcXYtPmNtZHFfZXJyX21h
cFszXSA9IDA7DQo+IHRoZSBzcGxpdCBsb29rcyBwcmV0dHkgc3RyYW5nZSwgaWUuIGxvb3Agb2Yg
MiArIGNvbnRpbnVlIHdpdGggaW5kaXZpZHVhbA0KPiBzZXR0aW5nLiB3aHkgZG9uJ3QgeW91IGRv
IHRoZSBpbml0IG9mDQo+IA0KPiBjbWRxdi0+Y21kcV9lcnJfbWFwIGluIHRoZSB4NCBsb29wIGJl
bG93DQoNCvCfmIouIFRydWUsIHRoYXQgZG9lcyBsb29rIHN0cmFuZ2UuIEkgd2lsbCBjaGFuZ2Uu
DQoNClRoYW5rcywNClNoYW1lZXINCg==

