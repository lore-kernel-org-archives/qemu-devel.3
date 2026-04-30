Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C27FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIQjr-0000xg-Li; Thu, 30 Apr 2026 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wIQjp-0000x3-LA; Thu, 30 Apr 2026 08:43:29 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wIQjo-0000FB-1b; Thu, 30 Apr 2026 08:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8BFsWNNb5jPE/DnrBS0xcWWTGgk0eJPM1KyXDu8T0pO7f1NqcjjEszhbA460vsQHvQ9FVTiR5M4MuxFzv6mSV4RqdPX4OXYWYZ1wBgf5207f0gkHjKQQCWoXJ+nqsJoXPkWTi7FxSBnJ/2SVHRXl1+PTGUnY4oeoGynB7ZI7WSakeX+Ksb3Mfgl0GMK97z1yXFb7g4hgCsJJRGIdqUZ5Fi0ds+Fgy3qJY3xWc3/RXNPwFAeOZoPIusTVQOptQTmfH/E1MNLu9T6PqDThHD8uHKQtcA/Fsb+kw5a27QluVUonqJrFPNxPWzYLs9iuwd7xI4yI/Xdi04Iv78IAM/cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/ukDPJPz93PdqSwMg7hTiDn3yx83tFyrtOy90veu4Q=;
 b=ZDqN61TywKh6HyF1WEmSm0faYTQWlCFxgDVn30dLbqCTEotY4Bcv+zRB27ssG2Vhi3ihKPFyLYXZsISHOeuq8YYIi3pKScVHGYm7OeAMqZ1JV1V2QuPhWv3M1jdBkPZ0j5ZuBzt6gG5vBiHJrRtLbdUGApZedYJn0ObN6Fcr6cfApWrwaFx7liHX0++4MC2CMWwzPfgjkPNVKi6rm7FlRFFFVtuoHHSMG1IwuuaL8aTClH3hRDWwADa/CEHxrTnsIPuaGkLZtduKoMrbBDBWUQyGyhK/K21VA1e9p1jQCVZz+LimJk1jqpEoVclFGXJIwHjw9ozMpno/S8j+OrJZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/ukDPJPz93PdqSwMg7hTiDn3yx83tFyrtOy90veu4Q=;
 b=iYemM3Xrrc9z7ZZpt7SdNnEwwd7M4ucSZMdA0O3crtspxoH37JRKNHpfkOQxEcsu5nyB4iuAO40INExQ2ihy2C+5k1TBELP88TY1zClqAm3xqhYH1kIvfXPiBRmeNIbJ7zKD2tK41wbIEdiH7gPH8ldQO4j3NIwT+lgzFV2fhvXxgh3L/dzdxUyYQX6zJtGCoT2C8Gp+wvgN219qTjDe6q5GSxp+JvrMgPt7iAPgZuGYtA1b0zaesohCl1BeEDBUw41NABZIpBBgnhANRjw6LLm4vZsBnfvcejlMmJQZFTQFXGZFu3FlP++ZG+1zeRTMTPGma8oDNKQIviOpmKoG7g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:43:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 12:43:19 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v4 02/15] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Topic: [PATCH v4 02/15] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Index: AQHc2HDgggks7uUC80OPO+rRMvPygbX3i7LQ
Date: Thu, 30 Apr 2026 12:43:19 +0000
Message-ID: <CH3PR12MB7548C598AEDB8C2367E2C123AB352@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-3-zhenzhong.duan@intel.com>
In-Reply-To: <20260430071315.354333-3-zhenzhong.duan@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS7PR12MB8420:EE_
x-ms-office365-filtering-correlation-id: 51ccc8ff-a615-4bdf-bf9a-08dea6b60ed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: KgfDdxC9GGcNBfEHDhTqE57c1imx019uy+86DbZWVFXBtyNWwp6d0lBA/MBeKYgostkMudL07k0HrnRqfLIfKRjeOXw8Ea55mvPCv7ZdGPuB0Aw8SoZQpVBkly+Af8eRY1nhvhtXCIQ+yLnwu6tkX3mbZecE5+BAzTnGHCKB/62jky4LPNT6C69bBdAENy4IKNNcl2SRCTLlammnaLQOTNKxa92lPy0hyr/DDRhyj8sHcIUWJawwnrG2IvhwYHE/evKEWJ0f53pkOc7vZoZbbXfNBEuP2hGk5/lNJGPV6C1CnBeeYMUQlA+u4Wu+x2x2//jprNZbfhQ7J/o+jpqgDO6Uhzs+/cuFygtxsAaAIeCig69GdaLtjod2mw0qF4vtHacu4wxWlJ3WdkZSBh9uFa6FzGSS/YH0Y+dwjlD2K3/8/q5tZjaxpniJgisyZLAwl/tFZ8a3fAngCd75fhTdfJjXkj4RHxR0xLeYH+3qEpD9IXI3D3Wh0cahsMuStg7UrV23+6frixGQ/e1dgwONN2uf4tMdSS8sc9ytDKA+XmYw+TshQ/UpPWgznhVfXMGvcAqFGrfXyJcbX5q6UDcEYWK8REeZ4nJK0nBieDSwP/cCl/BLLDkECLtlYjeIWubZP7iTASSs9LcAYybgYVmPkpgGibbYt1KnJE56jQRiMdDvB/gv7iEpR7kfLaICZuJa282cHBJyhZ7gsDevk2ojAa6DTWGyzzwAXn9DI/CIE9T3/uFZMprdfMFR7/d+pg9tmthrL7uIm3ZySYx9gsuh3MwoQRXOXKhKuE9FjuVoaV8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmpZUUdwRzhTcCtmenlXKzg0V01iYmhWUCsxOGo5QjVCMGlwRHVtUWVITkdN?=
 =?utf-8?B?dmlJeVMxejNuM25MaUdvSXlsRDNRUzhQZFVZa1dOUDN0eE0yTkVNRnpxQmxK?=
 =?utf-8?B?a1FBME5OTitqalNJM01xRG9UQmM5ODQ1REUzbTlFdDgzMmZaanRSdmR0NVp0?=
 =?utf-8?B?MlBybGRPcGMxUXBRV2h6L0xKV0szSUl4SWxldXpjYTdHUm5lK0NXWjdTMWJw?=
 =?utf-8?B?U0U2UGVvbGVnRk1wS1pKZ0N2NnlNV3kwdFZqVjVTbHhhMm15UDlRVlVBdk9w?=
 =?utf-8?B?bFplYTl5QzJYZVJTKzhvMlBSK0c1cjV2L25VSUlsR0M3dnJ0ZDE3NTEvVzZy?=
 =?utf-8?B?OFR1UHRNZlZ4VFZKejFhcWtCZ2psRS9FVy9mWVYrZ2JDSmlUNk1mNC9SY2g4?=
 =?utf-8?B?czNCSmJFcnJnb2g3REYxNEd4dUNGY3RTVnZyWk9qemtsNjY4cjd4T3YyZTZ2?=
 =?utf-8?B?cWJZMWVycHc2Y2ZvdjhpRFFKaXpZZXcyYXhIUTdhY1NXNmRyOTRVMEc5MFVx?=
 =?utf-8?B?dERaN2hOcTdYSXBWYnVUUDhpTHYyRldFSUNVT2dwcjkwSWJqS25yL2o2VWlY?=
 =?utf-8?B?N283RkhJY3N0aWdKTXEvVG9mYmZKS3ZEMGNNVXRzMzNGNUhQVytLRU9YeEFE?=
 =?utf-8?B?NFJrZ0N6Rk92MEoybzJxZlFwUnFCeEF1SEg2d3lZMlBZYVNCT3JaSHRXYW9r?=
 =?utf-8?B?Y1QwSzlyVHBKTTd2Q1ZLOTBuNWFaeVIyK3JTT2ZBMGRsRXVtYjhVQUs3UW9q?=
 =?utf-8?B?VVhLUFE5ZDBablFPQ1lneUhnVERMWkpNQVN4TU1wUEo4K3dTY0lRUC9Qc2VC?=
 =?utf-8?B?SllYN2E0NjZrdmNHcURvYzJqTm5vdDhkQnNpZFRNOU9mK2tIRjZvSFpyZnRl?=
 =?utf-8?B?S0t6eFl4TzJkZnc0RU91MUVNV0tnVnJTdkdPeU1FZHA2WS80VUllRmtFTkcw?=
 =?utf-8?B?cVlXTTB4c0lVTFBJQWRQVnBJcm1KeXZ3anBWd1VxTm9UYTdJc2t6K21zb1Z4?=
 =?utf-8?B?bGQwcThOb1pPeWZsWHNPRU5yaVJ2WWNITmowVmRnb1pub0NjNm8xYnBySWpj?=
 =?utf-8?B?RFBpNVc1ZklUYzhOcUxzQ1BmaWFMN2l0RUl2dEw0cXNsVEdOTVBsclhUZjgx?=
 =?utf-8?B?cHo3MHI0YnIzTThxMmY3WlZzK2ErZS9QQmNlZldJdVd4N1lQMHByWXNXNEY3?=
 =?utf-8?B?UC92dFZEYkVYeWJEeHhDQTZpS2lEOUpKU1l6YTFENTRUMGc4a0V5Q2cwY3Mr?=
 =?utf-8?B?WXRIVnF0TTh5RG9hUWR2K3pnYU55Rm52THBqWkVtanBFWHpKSndKdVMwVmNE?=
 =?utf-8?B?bS85TzNzVXRUNVRwUFVmYU0rdHN6b1JXMTQyRDVneXlLeFVWT1I1N1huR3hX?=
 =?utf-8?B?WkNpbzhOY1EyYnQ1cVFQMEowMUNEYTdSTFYza0UvaU51NU5LQ3AwL0tBTjVo?=
 =?utf-8?B?WmVQODFhL1N2Q3Jhd29NczdBRGtoNzNzdGYzUGdrV1VLdnJMLzFZcHJMOGNF?=
 =?utf-8?B?cnBPR0crei9Qc0Nyc244NGRkUVAzRXE4OGxmUEFiTXBSOWc1STRiU0M5L2xC?=
 =?utf-8?B?VzBOTjBHcGc1MmlDYVVabWZWTnVOdE5XZTlZaEw3RVpSanZacW9UYTFJUnln?=
 =?utf-8?B?dHpISXNxRTlmNEw3SnhldHNVdDBOMytLa0dVU3pjUTZMN1hlY2pMaGtyMWxj?=
 =?utf-8?B?ekxWdVZ6SE5ETGhtMCt0OU5Za1k4WjFPWDFPTWNnZ0t5MWdjb29pMmdLMVJj?=
 =?utf-8?B?VWRmQlBvcXo2TDJUSFExZmo3Ry9VVkRkL0E5Z2ZHWUNPLzFYVnRSbnNERCtx?=
 =?utf-8?B?NU1rRFBrcjUwMW4yRDVDekRjbTVhRXBkUHNHWnNJdmhOT2RMcCtEZTlKQWFl?=
 =?utf-8?B?azlsOXFaLzdxVHNvdFlEYkJiSjd1ZmdEcmJxUVpmV0NYYmpzREYrRTZqVC9q?=
 =?utf-8?B?MWFOMG1PcHZtem12SFRpSU0rK3hGLy9td3ZlaE1EdGo0S3JacGo4NVZiTVpJ?=
 =?utf-8?B?R2VLa2QreDNOU1NKNTc2MEZkWXdlRlJMOEw2NXB3dmF0U3pmck9KQUxjT2JR?=
 =?utf-8?B?Skl3S0Q4UnFlb1pIZ0VxNVVqMFZnS2pWektQcG1qSnhiSUdiaW94a1FyTm5p?=
 =?utf-8?B?OEZaU1d5em04TmM0SWtKWXVZUlJZd2pKWklKQ1hVbEtEeUNhZkV5NUJMU2FX?=
 =?utf-8?B?c0x1cjFqNGd2eGtxblJYejF0a0Y1SFErUmFhNlcycXlFendkbmNvV2dRL3FZ?=
 =?utf-8?B?WWxCS3JtOHBLdURVUHdFSGo5U3Q1YWRsS2tXQURyaU56RzlMbkhDRnpmOW9P?=
 =?utf-8?B?eWE5VUFuc0twLzVIWkZMRjIzZE14bFVZWGVYRlZkVmRQY0c2NE8rUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ccc8ff-a615-4bdf-bf9a-08dea6b60ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 12:43:19.5768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTFJspW18rRtLU6efKpZ+NK1UVQkJI4/a+8MzuwBTwP22mYrJpWr3Xi1YueQDvauVA1qu9GLQ6AF+i+Y4KshJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gU2VudDogMzAgQXByaWwgMjAyNiAwODoxMw0K
PiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBhbGV4QHNoYXpib3Qub3JnOyBjbGdA
cmVkaGF0LmNvbTsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgamFz
b3dhbmdAcmVkaGF0LmNvbTsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IE5p
Y29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29sb3RodW0NCj4gVGhv
ZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgam9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbTsN
Cj4gY2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tOyBrZXZpbi50aWFuQGludGVsLmNvbTsg
eWkubC5saXVAaW50ZWwuY29tOw0KPiB4dWRvbmcuaGFvQGludGVsLmNvbTsgWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47DQo+IHFlbXUtYXJtQG5vbmdudS5vcmcNCj4g
U3ViamVjdDogW1BBVENIIHY0IDAyLzE1XSBpb21tdWZkOiBFeHRlbmQgYXR0YWNoL2RldGFjaF9o
d3B0IGNhbGxiYWNrcyB0bw0KPiBzdXBwb3J0IHBhc2lkDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IFNhbWUg
Zm9yIHRoZSB0d28gd3JhcHBlcnMgYW5kIHRoZWlyIGNhbGwgc2l0ZXMuDQo+IA0KPiBTdWdnZXN0
ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0K
PiBTdWdnZXN0ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTog
Tmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBSZXZpZXdlZC1ieTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8gPHh1
ZG9uZy5oYW9AaW50ZWwuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCAg
ICB8IDE2ICsrKysrKysrKysrLS0tLS0NCj4gIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICAgICB8
ICA5ICsrKysrLS0tLQ0KPiAgaHcvYXJtL3NtbXV2My1hY2NlbC5jICAgICAgIHwgMTIgKysrKysr
KystLS0tDQo+ICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgfCAxOSArKysrKysrKysrLS0t
LS0tLS0tDQo+ICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgfCAxMCArKysrKy0tLS0tDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVt
L2lvbW11ZmQuaA0KPiBpbmRleCAyOTI1ZDExNmFjLi5kYTk4ZTc5NDM5IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVm
ZC5oDQo+IEBAIC0xMzgsMTQgKzEzOCwxNiBAQCBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlSU9NTVVG
RENsYXNzIHsNCj4gICAgICAgKg0KPiAgICAgICAqIEBoaW9kaTogaG9zdCBJT01NVSBkZXZpY2Ug
YmFja2VkIGJ5IElPTU1VRkQgYmFja2VuZC4NCj4gICAgICAgKg0KPiArICAgICAqIEBwYXNpZDog
dGFyZ2V0IHBhc2lkIG9mIHRoZSBkZXZpY2UgdG8gYmUgYXR0YWNoZWQuDQo+ICsgICAgICoNCj4g
ICAgICAgKiBAaHdwdF9pZDogSUQgb2YgSU9NTVVGRCBoYXJkd2FyZSBwYWdlIHRhYmxlLg0KPiAg
ICAgICAqDQo+ICAgICAgICogQGVycnA6IHBhc3MgYW4gRXJyb3Igb3V0IHdoZW4gYXR0YWNobWVu
dCBmYWlscy4NCj4gICAgICAgKg0KPiAgICAgICAqIFJldHVybnM6IHRydWUgb24gc3VjY2Vzcywg
ZmFsc2Ugb24gZmFpbHVyZS4NCj4gICAgICAgKi8NCj4gLSAgICBib29sICgqYXR0YWNoX2h3cHQp
KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmhpb2RpLCB1aW50MzJfdA0KPiBod3B0X2lkLA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gKyAgICBib29sICgqYXR0
YWNoX2h3cHQpKEhvc3RJT01NVURldmljZUlPTU1VRkQgKmhpb2RpLCB1aW50MzJfdCBwYXNpZCwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGh3cHRfaWQsIEVycm9yICoqZXJy
cCk7DQo+ICAgICAgLyoqDQo+ICAgICAgICogQGRldGFjaF9od3B0OiBkZXRhY2ggaG9zdCBJT01N
VSBkZXZpY2UgZnJvbSBJT01NVUZEIGhhcmR3YXJlDQo+IHBhZ2UgdGFibGUuDQo+ICAgICAgICog
VkZJTyBhbmQgVkRQQSBkZXZpY2UgY2FuIGhhdmUgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uLg0K
PiBAQCAtMTU0LDE1ICsxNTYsMTkgQEAgc3RydWN0IEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFz
cyB7DQo+ICAgICAgICoNCj4gICAgICAgKiBAaGlvZGk6IGhvc3QgSU9NTVUgZGV2aWNlIGJhY2tl
ZCBieSBJT01NVUZEIGJhY2tlbmQuDQo+ICAgICAgICoNCj4gKyAgICAgKiBAcGFzaWQ6IHRhcmdl
dCBwYXNpZCBvZiB0aGUgZGV2aWNlIHRvIGJlIGRldGFjaGVkLg0KPiArICAgICAqDQo+ICAgICAg
ICogQGVycnA6IHBhc3MgYW4gRXJyb3Igb3V0IHdoZW4gYXR0YWNobWVudCBmYWlscy4NCj4gICAg
ICAgKg0KDQpXZSBzaG91bGQgY29ycmVjdCBhYm92ZSB0byAid2hlbiBkZXRhY2htZW50IGZhaWxz
Ig0KDQpSZXZpZXdlZC1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5j
b20+DQoNClRoYW5rcywNClNoYW1lZXINCg0K

