Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850961125863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OOT-0004Rx-QY; Wed, 11 Mar 2026 14:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0OOS-0004R1-LJ; Wed, 11 Mar 2026 14:34:52 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0OOP-0000W2-QC; Wed, 11 Mar 2026 14:34:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQhSb6muGvdCAJZ3t3OzK7whk0WZ5kep6alyw28yYtRj5aUhJUrNcXhkkmTvLp7EKKtt2vepdDTBexSV54XDRyS3h2J7ukV+aM+tC0r2RDPCamPHh23rRK8ZcyejEqvl4JBHbuiEaeVoL4j/5SUjBbLrvMA//4u4dxxMKQNbDqIYnSdapIxw2xYqN2JFVBSDqzMzG1d73/UMyMx6BT1sygf9ICi0cERIYnlA6v7nZGF/8HgzxPO2C3Rch09cbJo3w3P9Oi/K6d3Hgzc5i3hPvEkWGbfTHFPXfE4M6ddNeSDQvqN9JpZV2G38mfCsY/g5zbFT11QLM1TDhwwNKzcHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4arhF9bCQ4k3ZrWpAsmTiB1ken86azVMWu5ME1Rug0=;
 b=aaGMschKQjn0qW+bcfxVLvyLDJmr97Fovzui+vE8gaMFhGKPnHmsabDIaH8SuX0BJOkjWCij2jQrsp2YzdZuf4KakpWZ3l0XIT6b0KGxg2wrlPYoIKQ1tOSMnlCgxLiMFyyxua5+6j6tBgXoDFr7JTNUSsESft0P8WQq43C6qhMulf8DAXTJGuGHYvnzr7/v7hCiTrkoYW4YzJpWvdGnNXOj3nNjkb1iyBfKw98nHlG4vZi/EgV0sjtQyl9TU4Rj12qb2gk6xEfNzQQ10dFQiDb+Y7JgaKOh2tda3jethUx5lbvBM9srUormEQxpHbA/XCK7Xq2EPJLaSsmCHYc2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4arhF9bCQ4k3ZrWpAsmTiB1ken86azVMWu5ME1Rug0=;
 b=TfR8HaFiDFi9149pUIR/rcWNCiUPfPy9cPACOwFDZfDswJEtEy+jxmEKYh19RrDMaCCRtbW1IylUjpeZcT1WUN1KWWUlfmzvWJxXrXeqb+OVpNwSJ2ROjCiunYtA8EXMED287EtXhOqDuMkbX82V+F/PfVQTCG5AqVFqUF3IuCJOs8ALurNdehP5KWre3RcgB7cfbVUfceiuneVqgPDpdBDfrhpHLReHtiFZTujZXuxNze9DYkD2BMW4JFMiqejkXeRKMICqMYboO1hrb5tz7z3RwBXXvW4eBJr0YoeRxw+jJUavpIAp3PYlVO3lbbU0HzLe1c3Vdm8xfLgeXY5+EQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 18:34:38 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 18:34:38 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Thread-Topic: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Thread-Index: AQHcpw3oDG8WqWxWgUa8hhn9GSra0LWpupEAgAAAwzA=
Date: Wed, 11 Mar 2026 18:34:38 +0000
Message-ID: <CH3PR12MB7548B7D18FA56E6F8EA657C0AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <254dceca-7864-4dbc-b25c-928add5a78e3@redhat.com>
In-Reply-To: <254dceca-7864-4dbc-b25c-928add5a78e3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB6439:EE_
x-ms-office365-filtering-correlation-id: d5b04edc-eca1-4741-9819-08de7f9cda46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: HvhRSSONK0GlakGbMei2nw26ikJnxgV3Xd65J4hGf75cROd3R4JAQ9TNvORTe9ZA5UFCBO1tDfamX4UomlzF9OxLdJSFEnw0/IiNW3edJS/mJ8fm5tVIlSTeVmVgwdvStCpwnqUtX7p6vMuydd4Dr/HgsY6GndVjzc8wksUYEAIjbAIvTSY0X+C5rEK4JFoZ8/wnegxh7IiRJnz9cnDllF5p8/PYY6Fm3YP4bRyCf6B6ggJb9drWXIoGSUVthP+wujUL+Q9MvoJIDBRoexC9Kf3lBe+3A2MRcHYMBuIS4TfmwxfEcdSGrLs7o7NjsvibEzfh7sKBxxKBPvBtZezd5/gh5DiqcD5tn1zmQZWl8NUBLr3LaY6I1sXFu7vsBRWGBwHyyGHZmyGazA9PQyBl3sSI2KUxExVF6unCPRP4FIrRtMTE5OJHD/MvYjNtgW/OeSlFkG3ek9tLfz+XbQBtio06b1A6mZqMsznUtLM9mQWrVFbB0k6tC/Mh+l4A6sT5oJyGWV/tvRKVW+SR38uFXa3y5JbPdm2vrgjM9/NgwD55Ul6To7TyPihCBxnfm0WGqD44A4bi14ZUT9S3pk8TSZg55MD2r6e/VXO3/rruFH4jndqPKUaFlr5DQKNpvn771JyfIOvFG2moU4c2Cb8+iz1lpf/3ZGHmKtqb2FFOiC1WZw1vlUsLRvBEFiWELf/g1AI2oLsVSbukDodXN//HVuMOSG05NYrCo+wCs2hF3swQ3ij4dwFy9Tt45TmrSLl/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEVlTzRTVXo5OVVWa0k1MjZZbjIrWkRnZzJ0eWpFclZ1SzNDeTU4SUZ6QnE1?=
 =?utf-8?B?Yk5tSHhTNVRNWForYnJGUmhGb092K2Z5SHFhOHlWUFpGVEsxcVdnU3dqa1pB?=
 =?utf-8?B?N3FucWV2S25ldVVLaUtTS25YRU1JRUJxU0NzQTlwQ011cVpkc0g1N3lNdExC?=
 =?utf-8?B?N1lKaTdpRjV0SW5mY2l1amo5cFZkUEIrOXBMVGZSeGV4Y3FEcWxjWVN0VzRY?=
 =?utf-8?B?TzBHTjhoQmFJY01PWWprV1gvQWZ3L2xpVnpTeXBDTVRzaXVvMVNrOXRKMHhj?=
 =?utf-8?B?dER4Zng1b0l2U1NFTHowdGNOYnI1M2IwVTJGVkxwb3JZeUpLaklrSHI0UlhI?=
 =?utf-8?B?SkpYemZGWTg0bWdsWFdEeWFacEVVQ2VOd2NGUGNoRkNsVTduN1VBMTRoS3Bo?=
 =?utf-8?B?MU5PcjYyZlVZWVZIZ2M2WUZNbEx1MWUwZDF3bzFzeStsSTRpa0ZtOGpocHFx?=
 =?utf-8?B?ZGFKejhjbTYyaUNrL2QzRTh4Wmw4VUEyajU1SE1zeXZQaW1QMnRQc1hNVnlV?=
 =?utf-8?B?Wmg5NUN6Q3N2TUJNYmUrQWRxZjRTNElFLzJnNm1uMUVrZkVPZEloQ1B5dU9w?=
 =?utf-8?B?eEprQnp1akFWRlFjdTlQNkxmdzV1WDdpdXljQUJEU1M1UXNya1MvT3dMS2tM?=
 =?utf-8?B?bDVna0xNZGFOZ2xvNk1RYVpzMTlYajRLdVp6YzVNMG9vV0FLc2lleEdKTk9s?=
 =?utf-8?B?eTBSNldNYzRtaUNnZURtelJSOEtKa2dVSmpwazhQYi9DaVV1NlFLRUNOcWgz?=
 =?utf-8?B?SWgyZGc4dmRiVDdqMFp2dDkyWHVub2hZaDJLODVTUkdVSVJnL1BVZEp1YzV3?=
 =?utf-8?B?ZjNtVFAveUtaaHl4WjBLVmtZMG4vVWFKKzFicGwxM0lLMTJaK1MxTlFsTGFy?=
 =?utf-8?B?aHlra0cyd0IyQThjdC9rQittaFF6cU1QRDg5c08vM01OTDkrdm9aQ1h5ZmVr?=
 =?utf-8?B?SVJFQUl2QXM3YmVXemcrb2E2Wk1sM2hKZHFQUUhPTkloSUdjY2praFNTQTBH?=
 =?utf-8?B?R2hTT3drVVVrU3dab0p1NVFVanYrQzhhTGFRNk9XRTNlUGNCazh3eDZEVHJK?=
 =?utf-8?B?bkVQZ0l3RENvUVpSMGV6SzZVTExpcVIwYmp4NlNuKzdqbEpFclY0QUdhOEli?=
 =?utf-8?B?UG54OERkcFF5MUloOWlrZEdRakNuVFVwMmlLT09ta0dyU0wxeHdtWURBTXdu?=
 =?utf-8?B?aDRnd2xjS2NEZ3JkeTBiZWZHcVdVTlp4TmdkWnhUUW9DL2Vmb2xWYnZCbkVl?=
 =?utf-8?B?aU9pcE5XVlJySzhLSUNSTDJkNGl0WGlKSGdaR2lMcERDb3ZLejZTL21xV25z?=
 =?utf-8?B?Qm9BbW55b3k1Z29ra1NaazFPa1I2RW0vWnlaa2RqeHdZdmsyT3l3YnlhL0xj?=
 =?utf-8?B?b0l5a2U2eWdJMUtRcGZ5YXo3WmRBZlI2eGFKeDM2VzJlTFdUMWJhdm5HQnJB?=
 =?utf-8?B?cktNY3JmVVZuN0RjUmk5bG9xRUR2UzY1Z0d0T1hFUDZUYmx1UWtMOEZ3d2dL?=
 =?utf-8?B?S2IvTlV5QmdkSkZOeTNYWmd5ZVUxMlA5RkpMdlJZZEpNSFV4VEY4a3FTVTZI?=
 =?utf-8?B?aEs1VkIxZ2tPbzZtVG13QjRjYWxtcXhTQkxaYmptZC83OE04UHpZeS9YNWw5?=
 =?utf-8?B?UFBaQmQ3NGJ6TDdUOUZ2ckRIendFUDNpUnFTRnMyaStlS3doMi9kRXZCNTNT?=
 =?utf-8?B?MkUxdU1VcGh3MGZpbGhtWDlUMmt3L0FYMEwxbGVJeWF2QVVWTzR3SndtRnJV?=
 =?utf-8?B?bWEzRmRPbGxFNXRsc3lWdlRuVUpraitKV1dJK1A0em1iaFZtM3hGM2RPczJJ?=
 =?utf-8?B?ZUFYbFVoRjluZlJSMTduTUVFTnV4UWdvUXYvVkY3czd6bkVzMVpOcWdHelBH?=
 =?utf-8?B?OEZiV3hlUGsyMjk4bGQyU05CUEVJTUxQZjBhdHJNbHhKK0FmRzNUZWtoVDQ0?=
 =?utf-8?B?dHB0NnRMRzFJODVBQWdTQjJCc0RkMmt0V1J4UmJaekd6NUpEcDZHa1U2WGMr?=
 =?utf-8?B?U3lFRld3dEhId24xSkhta3I0TkY1eHk0dGVESzh2TWFPT2U5Q1YxMmtsSktB?=
 =?utf-8?B?dDVzTDJKT2NpQzhpaFppb1QwbFRnREErVHhIUEhVakFsWVU5VUMwY1QvNVpl?=
 =?utf-8?B?ME1YQUg3RUw3MTdZclJvNjRick1EcFg5N1ZYcEVsL1hrUWtuV1JsWnFWbmRw?=
 =?utf-8?B?N25ubnVJTlVWNm00azRCUThUUmIvanlhODNNSmo3bGhTWkViaytydk1pSVo3?=
 =?utf-8?B?aHo1SWdVMW5tR29VT1VrWWlUblJhTkpTOWhMaFZ1WjQva0FjUmYvQWZlNEVX?=
 =?utf-8?B?WkN6M3NiekNXQXlpa3pOU1dEUHcwb05WVThNV3FDSDlHeW5TcEd2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b04edc-eca1-4741-9819-08de7f9cda46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 18:34:38.5958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZwzOgI5sTNZ1/JtL0+W/i4ligQL9pjZqIFhVejHKZbzQRopRX73g0pHbiRI5XpLD/YJmYoSRaIptkaXQpXbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMSBNYXJjaCAyMDI2IDE4OjI1DQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAwLzMyXSBody9h
cm0vdmlydDogSW50cm9kdWNlIFRlZ3JhMjQxIENNRFFWDQo+IHN1cHBvcnQgZm9yIGFjY2VsZXJh
dGVkIFNNTVV2Mw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlu
a3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gMi8yNi8y
NiAxMTo1MCBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IENo
YW5nZXMgZnJvbSB2MjoNCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjAyMDYxNDQ4MjMuODA2NTUtMS0NCj4gc2tvbG90aHVtdGhvDQo+ID4gQG52aWRpYS5j
b20vDQo+ID4NCj4gPiAgIC0gQWRkcmVzc2VkIGZlZWRiYWNrIG9uIHYyIGFuZCBwaWNrZWQgdXAg
Ui1ieSB0YWdzLiBUaGFua3MhDQo+ID4gICAtIFJlbmFtZWQgdGhlIHByb3BlcnR5IGZyb20gInRl
Z3JhMjQxLWNtZHF2IiB0byBhIGdlbmVyaWMgT25PZmZBdXRvDQo+ID4gICAgICJjbWRxdiIuDQo+
ID4gICAtIEludHJvZHVjZWQgYSBwcm9iZSgpIGNhbGxiYWNrIHRvIGRldGVjdCBhbmQgaW5pdGlh
bGl6ZSBDTURRVg0KPiA+ICAgICBzdXBwb3J0IGR1cmluZyBkZXZpY2UgYXR0YWNoIChwYXRjaCAj
NykuDQo+ID4gICAtIFNpbmNlIENNRFFWIGluaXRpYWxpemF0aW9uIGlzIG5vdyBkZWZlcnJlZCB0
byBkZXZpY2UgYXR0YWNoIHRpbWUsDQo+ID4gICAgIGFkZGVkIGEgaGVscGVyIHRvIGxpbmsgYW55
IHVubWFwcGVkIE1NSU8vSVJRIHJlc291cmNlcyAocGF0Y2ggIzEyKS4NCj4gPiAgIC0gTW92ZWQg
VklOVEYgZW5hYmxlIGhhbmRsaW5nIHRvIHRoZSBDT05GSUcgRU5BQkxFIGJpdCB3cml0ZSBwYXRo
DQo+ID4gICAgIGluc3RlYWQgb2YgYW55IHJlYWQvd3JpdGUgYWNjZXNzIHBhdGggKHBhdGNoICMx
NykuIEhvcGVmdWxseSB0aGlzDQo+ID4gICAgIHdvbid0IGJyZWFrIGFueSBjb3JuZXIgY2FzZXMu
DQo+ID4gICAtIEFkZGVkIGNoZWNrcyBmb3IgVklOVEYgYW5kIENNRFFWIEVOQUJMRSBiaXRzIGJl
Zm9yZSBhbGxvY2F0aW5nDQo+ID4gICAgIHZDTURRIEhXIHF1ZXVlcywgYW5kIGZyZWUgYW55IGFs
bG9jYXRlZCByZXNvdXJjZXMgaWYgZGlzYWJsZWQNCj4gPiAgICAgKHBhdGNoICMxOSkuDQo+ID4g
ICAtIEludHJvZHVjZWQgYSBjb21tb24gaGVscGVyIGZvciB2RVZFTlRRIHJlYWQgYW5kIHZhbGlk
YXRpb24NCj4gPiAgICAgKHBhdGNoICMyMykuDQo+ID4gICAtIFVwZGF0ZWQgYmlvcy10YWJsZXMg
dGVzdCBJT1JUIGJsb2JzIGZvciBTTU1VdjMgZGV2aWNlIGlkZW50aWZpZXINCj4gPiAgICAgY2hh
bmdlcyAocGF0Y2ggIzI5KS4NCj4gPiAgIC0gUmViYXNpbmcgb24gdG9wIG9mIFBoaWxpcHBlJ3Mg
Q09ORklHX0RFVklDRVMgY2xlYW51cCBzZXJpZXMgWzBdLA0KPiA+ICAgICB1c2luZyB0ZWdyYTI0
MS1jbWRxdi1zdHVicy5jIChwYXRjaCAjNikuDQo+ID4NCj4gPiBQbGVhc2UgZmluZCB0aGUgY29t
cGxldGUgYnJhbmNoIGhlcmU6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3NoYW1pYWxpMjAwOC9x
ZW11LW1hc3Rlci90cmVlL21hc3Rlci12ZXZlbnRxLXY4LQ0KPiB2Y20NCj4gPiBkcS12Mw0KPiAN
Cj4gd2l0aCB0aGlzIHZlcnNpb24gSSBzdGlsbCBnZXQgdGhvc2UgdHJhY2VzOg0KPiANCj4gaW9t
bXVmZF9iYWNrZW5kX21hcF9kbWEgIGlvbW11ZmQ9MjggaW9hcz0yIGlvdmE9MHhjMGIwMDAwDQo+
IHNpemU9MHgxMDAwMA0KPiBhZGRyPTB4ZmZmZjBiZDMwMDAwIHJlYWRvbmx5PTAgKC0xKQ0KPiBx
ZW11LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiBJT01NVV9JT0FTX01BUCBmYWlsZWQ6IEJhZCBh
ZGRyZXNzLCBQQ0kNCj4gQkFSPw0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiB2Zmlv
X2NvbnRhaW5lcl9kbWFfbWFwKDB4YWFhZWExMWUyODcwLA0KPiAweGMwYjAwMDAsIDB4MTAwMDAs
IDB4ZmZmZjBiZDMwMDAwKSA9IC0xNCAoQmFkIGFkZHJlc3MpDQoNClllcy4gUGxlYXNlIHNlZSBt
eSByZXBseSB0byBOaWNvbGluIG9uIHYyOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC9DSDNQUjEyTUI3NTQ4QzJEQ0E0RDMyMUQ3RkRFMjM3NTRBQjZDQUBDSDNQUjEyTUI3NTQ4
Lm5hbXByZDEyLnByb2Qub3V0bG9vay5jb20vDQoNCkkgZG8gbm90IGhhdmUgYSB3YXkgdG8gc3Vw
cHJlc3MgdGhhdCB3YXJuaW5nIGN1cnJlbnRseS4gSXQgc2hvdWxkIGJlDQpzYWZlIHRvIGlnbm9y
ZSwgc2ltaWxhciB0byB0aGUgYmVoYXZpb3VyIGJlZm9yZSB0aGUgZG1hLWJ1ZiBzdXBwb3J0DQpz
ZXJpZXMgZm9yIHZmaW8tcGNpIFBDSSBCQVIgbWFwcGluZ3MuDQoNClRoYW5rcywNClNoYW1lZXIN
Cg0KDQo=

