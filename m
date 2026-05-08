Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A176CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIoy-0002ZS-SE; Fri, 08 May 2026 06:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLIox-0002ZC-ES; Fri, 08 May 2026 06:52:39 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLIov-0005SJ-FN; Fri, 08 May 2026 06:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYX+GxX6xZlIM6w+ff2gWqNhK1BMPN031cd2UVzRnqvHCi9+/PPR8z5XNXq44d5ePShVonEZqW+A+csItRBXh/o2fZHqIv+JYjsYbgk1GOgmC3oRiZPt7XIdP82/kQFln/VxiQ1qXZU40BtQWunHi3T0UR+/+qVBfeZX5EoLllVGSE2Xgu1/EK2a86riCcwbHdO1u1xaa6t22YJ1ESQKFZyMyc66afNpQ+32gaWLla7gfo4G2xL3Vw7EvoF86nbPr6a+AucWidl/2+rSMVjY8A1gCFNx1nA7+G2HVLLeuB6i0RDgdBFh1xhNXYAJKfntB44Be2k3keWXgDd5CyqVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioXNBAKMcDruS7v4689d+I8k6DIraxwohNUY6unVezU=;
 b=jjoJP71orLTZHgJZfbX8qcTu/E2yHE2ifCcUdyyx6c6km3lDZQt6IWVEC0lfq9d7fvZBRpO6ATVR8ZLgxm6g8Z/kXCukmAXKCBUwoliL6G7Lrq3VWa4kcUKIZrDHPWdk6QwQkhOUozEApFhHFPtdyKYFu30bhJPs2JlUhetm+mCSPHz+CTRZIYhEhcCYfVN8JIVvbeX4NE1axsrRz1KD2EzVCA6B+b/z9xdJGUVlHJq2G9n1g2kO2mmiLayNVF6pbx0xsimCGbGQ+lSJO1cBVn6GtkM47JpbNPAMEiYBe+bLZVPiM/GjN0y/DlgxwZ6/57HvDwceQfUSCdUCaf3X/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioXNBAKMcDruS7v4689d+I8k6DIraxwohNUY6unVezU=;
 b=PyFs5uGL93aysLT4Qq3NISJggAPrTOksKMMfbi48Hi17G+bYfKjNTqiA0TiaZ9rLc+BOCg38/MB391hlXzoVp/wCvRaS2ba6CGj13OnBCk9D3ZO/oTIQ2iG60D8vJi5A4JWD1qxibSpz5VfuD84HsqbDwLb1Vmt3dzJUika6yjeRACeKXis4RGlz44FoFLcMaDVi894wjRPeutMnrKs87pHyxKSahVrKzOuFcFKIDcgaTB+wuRG+MUb1LxXHpafsWXNB4Wb5Rx7BBjYVGdc+L+eJk7nK2J6vT0dUO+/SumhwZvPDmyiT7c9EqPZFQ0YNgei+wjcLoLc+zGyMf3aLNg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 10:52:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 10:52:30 +0000
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
Subject: RE: [PATCH v4 24/31] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Thread-Topic: [PATCH v4 24/31] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Thread-Index: AQHczMbIRzf6ijE/f0G2kIr8qVLGsLYC5wIAgAEsT8A=
Date: Fri, 8 May 2026 10:52:29 +0000
Message-ID: <CH3PR12MB75482DD881982B26893820A7AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-25-skolothumtho@nvidia.com>
 <188a2717-2f2f-486c-a559-a3dd3bba5ebc@redhat.com>
In-Reply-To: <188a2717-2f2f-486c-a559-a3dd3bba5ebc@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB8842:EE_
x-ms-office365-filtering-correlation-id: ea257bf3-dde3-4ae2-2af7-08deacefe69c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 0YKHEmf2JP2VWAGiWAO71jHiv5YcIyCPRrHoSAhYW6+gvrT9lrFRrBBeENhmWOEDCcNODxu2e4FqRlJde+EZzU+WKTNJio0tBTwG+UzVe9KsaX5dk52SLAYfkBNd9IJ6B1Y/q2XwPeqiTW7gIiZH3SS7KrPJsEWFGgEbVIwSEY7HYP1Z++tXgZowBTJRNa6nWAOsgBNHiQcuYazGvWijDl++uvOmfASjjPJK+cJaOr9MkN953D7ZV0dWYXnLvXfhCJd1JjlghPf/VNqNTvCgNejrunFbXMUbgl5hEBXNI89K61o46xFqe02joLLtOVrutnIs/Pyo2IW11/GLQGFVuf44R79GzB09+CgK5VST0Mw8CxM5NNux+yC2yyaf7odQI2JqAmGyQ0hOxt2Ck5IBF8+E2mPK50kbF/Sofqp91gKyRvCfRU/f5+pPVXAgFI5+Xnm3StviSs4UCL6rkYkqCC6ScDqi0UHT9ZmMQUIvhnQQAwZfAO1N9eac+N8zd4ZKXNPnsF7Z1rE8JFxeNRf0zhKHD76bjexL8QM7ZG7qU0IH2xRJwvMvMAen5sZKWqh15jSlmMcFn1nrmbRtvzqSuXnX3TakbzdpLC/7rFa1MafUQX1EOFWuG3vDs/6Kr44QGxf8BQWvh/yh6Xq5Y0kjqWZD5QlfevalvWq1ma2OCEtsjgEshrWzrrvTOug66i0zN0JKiG3BDL03qbEbZP7SdMTGMcu0mrmRBlnx+3lYm4QFNVAYqFUW5WrL8rPnoEvu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG5xeW92cFU2dUFsSWFHeHR4NWNZK0hjQW9KOFdpK2lLMDFIR0FCdFZqL2ZG?=
 =?utf-8?B?Sm9jUUl4SDJNSlpwQ3BZcFUwQ1lucUUrQXp5a1YrMVVpNHVuUWtuS01PQkZr?=
 =?utf-8?B?Zit0cVZheGd5SUVDM3I4R25KU3ZPZy8ySkdCT0xwTkxjVHVGdnNWMzFBZ3BW?=
 =?utf-8?B?Q24rV3NRVExIOWlldW4rZ3VlKzIrd042K3pCYitzcEdSNmRhRFhkcUUwb0VQ?=
 =?utf-8?B?S3RrbFNtVDdmR1R2UFdPZHcxWHpQMWZwQXU1azhGUGtZdXdHU2o2N2pDYWs3?=
 =?utf-8?B?R0ZJcDJDeXNFSFAvQTNSaGg2WWVNeG53aGVFWGVDN2NhS3BPN21VTHR5MUZW?=
 =?utf-8?B?UFdTTStWS0FZSDV3djhIdDUyNjg4UmpKTkVCRUZjZDc0VE1FazNKWU42UUpy?=
 =?utf-8?B?byt2WU9wWjZ5UVBUSVpoRmVDbEg1YjVtMElObElYTzM4cjVEU05TdXgzWkxw?=
 =?utf-8?B?YjFBK1h5UWxLWE9Pa3hrTGJSZkpxMzZocXVkRHByQytmTHJFWHUzcVlIdVVs?=
 =?utf-8?B?S0pLUlNWNTI1dlZZRjBXSW0yNWsvT0JldXAzZnE1OUJ0eTF4ZzlpbzA1emo0?=
 =?utf-8?B?eDhwenpPZkJrNFBOM2F5V1ViU2NDSjlWTklIeUxGQnBJRDMzVndBS1hrNDJa?=
 =?utf-8?B?clpYOVJKMjg1T2MweFR2Y01pWHZyZFJLdzhVZDFHUTRyZEM5bnZPbTJXUmNu?=
 =?utf-8?B?eU5LMnk4c1dzcTlwZTdDa0MrZnpDVkFJUzVPZDI4bDdBVnhNem5hTHdhSjJB?=
 =?utf-8?B?blVwTHhNMFZSWlV1MGpkVUpmZUVnM2xqYVFTaVgzUUpkdjl5YUQ3K1FFWm9D?=
 =?utf-8?B?dTNQUEF5K2RvanJVZVV3bnhUbU43VHVVeDdvZjEyZ1pxdlpETXY0NjdOWGdy?=
 =?utf-8?B?R0VPc09LZUtKaVdkVWZCQS84MGk2Y3FVUHJhUHRrMlNvdjB1YnNDYkUraG9M?=
 =?utf-8?B?OWFydS94VFVNMkdPYVV3a2FIL1FZRVhuNWhlWW5TaVVYOWlNV2c4R1k2Y0ow?=
 =?utf-8?B?ejhaalhBMHl6dW9DNE1hckR0Sk9HaVgzcVk5YUpoU0M2dFZQeVhVSjVsZ3JD?=
 =?utf-8?B?L2x1UVIwOWVENVE5V05iMEVaS3N5emtneFcyNEpISkErL2xiaWtjMzBWTE9l?=
 =?utf-8?B?ellVaW1vS1NJQmdyUnF4bEVseTU0bFYvdWxCSm5TZG41cTV3eVdybHRUM1dl?=
 =?utf-8?B?dk9OekE1d1VUNWZvblg4VkxhaDVxWWRpWHlmTGtOd2RVdTVzU1BkOVpwd0V1?=
 =?utf-8?B?dG83UTlSYlRNVDdwWHlaMk14QUFPcm9YTit6eS9FcFlvRlhwQnNpNkVLS0hQ?=
 =?utf-8?B?ZU9XQW5QZDBUTkt5Zks0endhTTBUOHQwSXFCUThBRDAyaFV6R3BjS2tPcWgz?=
 =?utf-8?B?blJEVlpWMVR1WWxMakJxelV1S0dhdHBuaHVRaVlvQWw5d1dOYXRoeHVtYmEy?=
 =?utf-8?B?ZW52Uk02dEMzRXpWUURrUzNLRUlaVmNaTEhkZ2p5Mk93dkl5cWRFTlVsNGFC?=
 =?utf-8?B?V2U0V0QyVlFlT2lQS1lCbTZnNTU3Y3JVR0pZQnJOM0ZsbjZoSThJNkVXRDhK?=
 =?utf-8?B?NGo2L05TZEhhR29Zd0RqT1RkUnF6bVhwOWJGdUZXaXZSMFcyY0NkU3ArSkh1?=
 =?utf-8?B?T3QwZE4vbzhBWC85ZlU2em9mWmZNcW5Nb3gwN0J6SmZ2ajU2RHd3MkMyV0FN?=
 =?utf-8?B?YjhZQ1ZTWXZkVDVIOG11VHZoWHFucEVwNTh6ZVF2KzBOK1MxTC9pWGk0WnJi?=
 =?utf-8?B?Y25SSk9OVExGUldwUG1HcGZCR3ZoVG9rdXJtc2dEbFo2R3J3YTRud1Brbndp?=
 =?utf-8?B?ZXpZcFBCeVpxZnZEbEo1TlJQSHZYYmw5aWVQQUV5V0xmSGlPTCsyZHc1dWhP?=
 =?utf-8?B?NDJpemFqbXlHNUVrbkNVNmNuU1RGRk0xL2M0bUtVZGFlZnkxRHlJcWlObXBl?=
 =?utf-8?B?SGZBTmVsWEROYmZONDZIV0NreWZYQmhHODNwY1N1T2xJYk1Sb0JJTE4vNndm?=
 =?utf-8?B?bkRSVHFNQzBqK2dRdXN0Ulg0Sjd4T0FuTWgyQk03OWF2Rm5CbzFQd3I4WFNS?=
 =?utf-8?B?UWFMaVIwMHE4MVRSRHExa2Jmd1R2NjFmS2VYWkJnT2djVWUwQkplUlkzdUFk?=
 =?utf-8?B?UktxMUhRbk43S01xU2lvd2FzVUZXdGVQM1lVSk9VZXBRaGwrcEJqNExqSlRP?=
 =?utf-8?B?N3REdmo2RDhMYTk0clYwN1kwK1N6MDhldGd3QWtrVGczdmxvWDNQVTFxdnpN?=
 =?utf-8?B?LzdNWUZjaFVTU2wxUkEvRXBoME95a3JacG0raXB6U2JmdjRoeGFlQURFT1c4?=
 =?utf-8?B?SG1RQ3VsbTU5Z3I3ZVRxaVA0ejRNVnpvc29uRDNTc0xxb2oxMTA5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea257bf3-dde3-4ae2-2af7-08deacefe69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 10:52:29.8841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuNp+3r42DMsIaz12oKe7Y4yLJxI3SPsV4+3DbE4APS4X1SHWhYaGPz8G+mJPbo3RgMqWfuyKQjF3jA8n7YGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNyBNYXkgMjAyNiAxNzo0MQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDI0LzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IFJlYWQgYW5k
IHByb3BhZ2F0ZQ0KPiBUZWdyYTI0MSBDTURRViBlcnJvcnMNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkg
U2hhbWVlciwNCj4gDQo+IE9uIDQvMTUvMjYgMTI6NTUgUE0sIFNoYW1lZXIgS29sb3RodW0gd3Jv
dGU6DQo+ID4gSW5zdGFsbCBhbiBldmVudCBoYW5kbGVyIG9uIHRoZSBDTURRViB2RVZFTlRRIGZk
IHRvIHJlYWQgYW5kIHByb3BhZ2F0ZQ0KPiA+IGhvc3QgcmVjZWl2ZWQgQ01EUVYgZXJyb3JzIHRv
IHRoZSBndWVzdC4NCj4gPg0KPiA+IFRoZSBoYW5kbGVyIHJ1bnMgaW4gUUVNVeKAmXMgbWFpbiBs
b29wLCB1c2luZyBhIG5vbi1ibG9ja2luZyBmZA0KPiA+IHJlZ2lzdGVyZWQgdmlhIHFlbXVfc2V0
X2ZkX2hhbmRsZXIoKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0g
PHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9hcm0vdGVncmEyNDEt
Y21kcXYuYyB8IDU1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIGh3L2FybS90cmFjZS1ldmVudHMgICAgIHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDU2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEy
NDEtY21kcXYuYyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jIGluZGV4DQo+ID4gYmY5ODlkZDUx
Zi4uOWMyZmMwMmI5MiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0K
PiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gQEAgLTExLDYgKzExLDcgQEAN
Cj4gPiAgI2luY2x1ZGUgInFlbXUvbG9nLmgiDQo+ID4NCj4gPiAgI2luY2x1ZGUgImh3L2FybS9z
bW11djMuaCINCj4gPiArI2luY2x1ZGUgImh3L2NvcmUvaXJxLmgiDQo+ID4gICNpbmNsdWRlICJz
bW11djMtYWNjZWwuaCINCj4gPiAgI2luY2x1ZGUgInRlZ3JhMjQxLWNtZHF2LmgiDQo+ID4gICNp
bmNsdWRlICJ0cmFjZS5oIg0KPiA+IEBAIC01MzQsNiArNTM1LDQzIEBAIG91dDoNCj4gPiAgICAg
IHRyYWNlX3RlZ3JhMjQxX2NtZHF2X3dyaXRlX21taW8ob2Zmc2V0LCB2YWx1ZSwgc2l6ZSk7ICB9
DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZfZXZlbnRfcmVhZCh2b2lkICpv
cGFxdWUpIHsNCj4gPiArICAgIFRlZ3JhMjQxQ01EUVYgKmNtZHF2ID0gb3BhcXVlOw0KPiA+ICsg
ICAgSU9NTVVGRFZldmVudHEgKnZldmVudHEgPSBjbWRxdi0+dmV2ZW50cTsNCj4gPiArICAgIHN0
cnVjdCB7DQo+ID4gKyAgICAgICAgc3RydWN0IGlvbW11ZmRfdmV2ZW50X2hlYWRlciBoZHI7DQo+
ID4gKyAgICAgICAgc3RydWN0IGlvbW11X3ZldmVudF90ZWdyYTI0MV9jbWRxdiB2ZXZlbnQ7DQo+
ID4gKyAgICB9IGJ1ZjsNCj4gPiArICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+ICsN
Cj4gPiArICAgIGlmICghc21tdXYzX2FjY2VsX2V2ZW50X3JlYWRfdmFsaWRhdGUodmV2ZW50cSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfVkVW
RU5UUV9UWVBFX1RFR1JBMjQxX0NNRFFWLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmYnVmLCBzaXplb2YoYnVmKSwgJmxvY2FsX2VycikpIHsNCj4gPiAr
ICAgICAgICB3YXJuX3JlcG9ydF9lcnJfb25jZShsb2NhbF9lcnIpOw0KPiA+ICsgICAgICAgIHJl
dHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBpZiAoYnVmLnZldmVudC5sdmNtZHFf
ZXJyX21hcFswXSB8fCBidWYudmV2ZW50Lmx2Y21kcV9lcnJfbWFwWzFdKSB7DQo+ID4gKyAgICAg
ICAgY21kcXYtPnZpbnRmX2NtZHFfZXJyX21hcFswXSA9DQo+ID4gKyAgICAgICAgICAgIGJ1Zi52
ZXZlbnQubHZjbWRxX2Vycl9tYXBbMF0gJiAweGZmZmZmZmZmOw0KPiBjYW4ndCB5b3UgdXNlIGV4
dHJhY3Q2NCgpIGhlcmUgYW5kIGJlbG93Pw0KDQpZZXMuIHRoYXTigJlzIGJldHRlci4NCg0KPiA+
ICsgICAgICAgIGNtZHF2LT52aW50Zl9jbWRxX2Vycl9tYXBbMV0gPQ0KPiA+ICsgICAgICAgICAg
ICAoYnVmLnZldmVudC5sdmNtZHFfZXJyX21hcFswXSA+PiAzMikgJiAweGZmZmZmZmZmOw0KPiA+
ICsgICAgICAgIGNtZHF2LT52aW50Zl9jbWRxX2Vycl9tYXBbMl0gPQ0KPiA+ICsgICAgICAgICAg
ICBidWYudmV2ZW50Lmx2Y21kcV9lcnJfbWFwWzFdICYgMHhmZmZmZmZmZjsNCj4gPiArICAgICAg
ICBjbWRxdi0+dmludGZfY21kcV9lcnJfbWFwWzNdID0NCj4gPiArICAgICAgICAgICAgKGJ1Zi52
ZXZlbnQubHZjbWRxX2Vycl9tYXBbMV0gPj4gMzIpICYgMHhmZmZmZmZmZjsNCj4gPiArICAgICAg
ICBmb3IgKGludCBpID0gMDsgaSA8IDQ7IGkrKykgew0KPiA+ICsgICAgICAgICAgICBjbWRxdi0+
Y21kcV9lcnJfbWFwW2ldID0gY21kcXYtPnZpbnRmX2NtZHFfZXJyX21hcFtpXTsNCj4gaWYgdGhl
IGNhY2hlZCByZWdzIGFyZSBzYW1lIHRvIHdlIG5lZWQgdG8gaGF2ZSBib3RoPw0KDQpUaGV5IGFy
ZSBzYW1lIGZvciBub3cgYmVjYXVzZSB3ZSBvbmx5IHN1cHBvcnQgb25lIFZJTlRGMC4gIEkgdGhp
bmsNCmJldHRlciB0byBrZWVwIHRoZW0gc2VwYXJhdGUgYXMgcGVyIHNwZWMuIEkgd2lsbCBhZGQg
YSBjb21tZW50Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg==

