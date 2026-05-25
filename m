Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF1CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 17:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRZ7d-0001zG-Dd; Mon, 25 May 2026 13:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRZ7a-0001yU-Qn; Mon, 25 May 2026 13:29:46 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRZ7X-0004km-Rv; Mon, 25 May 2026 13:29:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTusgKGBWLzmJv5zk1vsSk2cHIRhD4ztLMo2623Sz8e3tfNCkkTiQHUK0oZ1wQKVmebu5r+OL0LYamE6z9a1rnpf+RZMBJiQdxfFyekhiRWeAhlt+9fgI65P84KvmeVyAJikgYJ44myRVn+fSRWM9Yqyxi4U18H0PO3NCl9VH7BmMe5iFWA4c1TUP3TlJFjYTsRJodRjO5ylqK7CY2aB6davqkm0cI/ZSzGCJ5nyVgnc2ctwjpjyMekqSme4lTamOR9hssL5AVq0jHUE09Cm3rWlp/OD6n3z09/IDnHSYasq6VkcRLFD85tYqCOzTYMlWpFUo3Z40jWOxQZOtk9PfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqMVrLGsfDEDGcpTeCX7DgrywI5exbYCfcbK1p3NtR8=;
 b=VJCgTuZGw56AQTpV/gSe+dzwSmOiXnyhHKLgw9HISeScCfR3IpGLeanOc1HVzpF6PJhV9+B6wIwc64YisQsS+k6YRfsvI+jnTIzgEJdX4ylcjwrG9QWvH8kfgj9XRRPBgXXyDJ5aC06T9MauPVXyT19090sC26o9ZFSgaDBJlkObpM+kwLE5Cpht5/cbJrpew6uhENa2JHIGK4vgfPWgFom0JQ+BWtMCp4e85634VrojJAAEWDukGFiZziCNiAdjMnnK9MD1RzdaMfWYJhY/zIN/0Gulh+g6d6A7cycQojgu63CBDSDIa8BB3wJCyVKJYvr/PjPttPNJ1fWQ2R7Aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqMVrLGsfDEDGcpTeCX7DgrywI5exbYCfcbK1p3NtR8=;
 b=UsKLCiyAaooovOJj7hBhBCJOx2sbXl+fvLKx8dEcDiWYfnyjImM6H6NXQG4qzASDrwIV3VYWiYRQ4afcNG5+hrw4Idqb+uKz6Ep0kimT3gznL9FNx3HJxFJexd7DXjdpHFtaVUjcRreBUwAywNjrbzCmTI+haeJ5RBT1FG1BjB2VDA2AXAm9qzaW0O/08aCjY0zkJOL5jYxs5494pjv9LX5tZqom/wCN3iKL1NjoYNGiScJLwvtc8QsbB0BYn1qoypQZqdlK4xSXCp+Yz0SoNEaKvQQ9LV328pqP0ft1AmbRJntrl8USVIOGeW1MHwwmOzpGfCchj2PXiscY0KTlhQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 17:29:36 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 17:29:36 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Thread-Topic: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Thread-Index: AQHc53vNIJgS7n+sDkKqpewZRLBJ9bYWjJMAgAARkyCAADViAIAILF2g
Date: Mon, 25 May 2026 17:29:36 +0000
Message-ID: <CH3PR12MB75488280F37BAC8F152671E7AB0A2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-17-skolothumtho@nvidia.com>
 <73b4f204-41d5-4997-8d02-5fc9ba3d0c67@redhat.com>
 <CH3PR12MB7548A230C9165D12CDD2EEF2AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
 <2d49ceda-4416-4044-8323-18104cc52e1d@redhat.com>
In-Reply-To: <2d49ceda-4416-4044-8323-18104cc52e1d@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6011:EE_
x-ms-office365-filtering-correlation-id: 21b8c296-9f6a-4d10-2ad5-08deba833181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: oKR/LVoqo4T1/Ty0epZwX1v1QqACdwne5chn3ax8chXfbt2CTvThBdbN0aYKXoKZnYm59fzl5B9UjxRVKWa5FK6ASwi+4cheAFkwv5vDMef4EaTFnpOIDQzp9qAgjFE1XJtm96DW0m2iP51isTb0cp2to6yrpb9jlSec64lWNqZM7mdhsMIFyUpmbUEbEtWqGkN3TYhQ6qvLRUzvG+H52fYUwcUiEye0nT/OhlPXDR3PM/sE5fc3ze21MoiOf8k4YNYgvLOATxbXaKYTGVUnVzPCAb9VAo050AqRaKt8HZvbz+15fvnFBFD3MAMMIrd2rCGl0C4Ky+EV8b3DR4JD79v497KNuJ0PdcZwK1KIKlKqZo1EsRHq6GfyUv+JDyyAhh0+Sa1/t258KBWjDe79fjtrh4Xq//zXTUm+Ohide9LBW367IRYwA0qHP1UlYF+OYI6OlyQdRYKc/Qu7OKSeFJqNcsx4OS0Zw62kPqtEUPpmhpmtQJM93doZIGUsdYgqyBkcIvjKEUmL89MWEFuycLXTU1SuuA5PI3qwlOzeUSGLd5k1hez8+0kjmVyM+gDh8ksF6EaOIsskTh+WiZ1lmE5Eigb6UIrrQuMh8Wd6XQ0uutKJsi3ZPJm5nvXIHk4IL7DpezMVPQEGMqxkXoaPmIpj2CZ8d+nt5rV5p6HISzR57QmeZ0bEC8M9rto4Om+geOOVH2NNnBIgnoCVb9ZwFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnFhb2ZVUlM1WHZJTjhPWDlDTXhVWFhiM1FqMzEzSm5qTEs4UWd5Z1ZMZVlv?=
 =?utf-8?B?ODNiUkR0SHVGWkdxZ25nNHBPL3Jtc2lmOGo0YnYvWkJLTU9MUTdSbVI5NVFl?=
 =?utf-8?B?WUZGMHJQZzd2UE82cmxSSDM5dUZja2hQM0JUOTZyejk4eDBWY1BKVTJPcElW?=
 =?utf-8?B?ekJJSXJvSWFlU3JsVVZ4aWhzenJaSXpNSmp1d3BtdFNONjd3UTBxdFp4a1Js?=
 =?utf-8?B?S3dRTXpNQW9nWDN6bGlobDFaWElvaXdFNzVhMjl2QjRpLzdMV1htaGYvVkFq?=
 =?utf-8?B?cDl3eFYwdTlyV3lySUp2YjNoT0l1am9QZk1nWFpsTXg2eUZMSU1HYndSTXU2?=
 =?utf-8?B?RTFRcVpoSnE3YWd5VHNNNEdwNzMyRlNST21FQzQ5ZktQdVhHQXBDeGROZVhy?=
 =?utf-8?B?SUlDYVBGUkJ3c0U5RVU0TGZGcFFpMXh5RE16dDI2V0t5UXk2ZVhhWWpLb0xl?=
 =?utf-8?B?YWFEMkdCVW9YUEVwL0NJNEpCRFpuQkwxTGc4aE9XRXdqeXR2R05peFNlTWpX?=
 =?utf-8?B?SW1JOVA4RmZzZCt0MzZlak5Ub1czbHIwYjcvd1pSckFJNUgwSXlDOFFHbWVa?=
 =?utf-8?B?SUFSRFc3SGZORzl4WUtKSlJ3VFBmb04rd0Q2L2JYWlNyeUpLMmgvYVRZNkwz?=
 =?utf-8?B?WTJTK1c3UGx5S2hERDdrYTJpUy83MVRTUElHWnZ1Q1hUaUxkckRmY3JmM05L?=
 =?utf-8?B?VVJXVXVuZjNlZ1h0Z1pXWUE4dVNRaHVIeTloRkZDWFpseEtPVnRKblJpSEUz?=
 =?utf-8?B?TzA4SGNKcmhwb3BpNTlEdi9WUEhKNmZadC9Yd2xNUUFhSC9PU3JxRFdYQ1FK?=
 =?utf-8?B?N3VUU0g4SHh4U2x0TG92VlJaUUptZkRUMURjdFM4cUFWZWFTK1VTdWJyT3dM?=
 =?utf-8?B?OEowbnVGdmhXSjhtVXMzVURJZGtZVXQxNFl1a21zUmNuN3o3UERIbnk2bTBz?=
 =?utf-8?B?a0N2UjRCVFlrSmZnUHdvaHJrdU9mSGJqUVc3YjBJSnV5Y1pYNnF4aW9OUVor?=
 =?utf-8?B?NVNhdmRzZWFwRFBVclRPYWhDeFNnaFdUVzZCamN5WjdPOWJrQzFFTGlzYVM3?=
 =?utf-8?B?cnpKR1BLUFFGTHJlam13STJUMWh3SWNvelNVWWo3bUNqMDV2Y2g2aEZCeUVx?=
 =?utf-8?B?RlNOU0lpTEJXbENLZk42UWR3UEVkTlRwdXRSelE2ODZYV0IvYmFLNTh4L2Vl?=
 =?utf-8?B?czB2UDhBQ3BRNzBVZGNUMnA3M09OOUpDQzFGd3UrVkVjUE93SEhsSkJSZC9N?=
 =?utf-8?B?Z0dqRDJGQTM0RThOM3VkWHFqVW0xVU9QNHd2bDZYYlpmcTJieGI3ZU9mbjJs?=
 =?utf-8?B?WVp3elZFYW9IUUZxV0pBOXhXd0ltTVQ0ZVkxOHJwOHN6U0FjRjhxODVsdEpv?=
 =?utf-8?B?bm5ITUNjdkhId20xSkJmRDZEaXZKVXE4czFaQ0Y4TjZydWxQQXlHL3dhMlhh?=
 =?utf-8?B?cWhoeFk2aU9HUmFrNXRxbmN0ckdaMmVDRForMzRjblZVSUJnQkVJK3BGUE9q?=
 =?utf-8?B?eHVNRVRpZmpkRENKTFgvMUxBL3pPUGtZOXJsZ0lwbnBleUFJbENPdmorSlF4?=
 =?utf-8?B?WFVyRis2MVF3TStWdkZNVXlmQk5ZWTl3Zlo2VG91enRTcm1kVDdreDNRRk1a?=
 =?utf-8?B?Y2VTblNiQ1FGN2hrTEpoRmk5L3Q2bzhoem0xZmxHbGNJRG1XR0ZpRjFwZDlL?=
 =?utf-8?B?cU54c24xRElzUUwxckpia25mOG1ZVWZhcVFRZW9rWlNoaTc1bnd4MkdxT3RC?=
 =?utf-8?B?eFFzT0RBTktjZEtiNmlDTkJLUG1YRXRQRFdpMDBidnJtU25HUnhUdnVYSnJy?=
 =?utf-8?B?ZDFBdzVNTDNMZlR3ZVFTaXNHN21wOGhWRk03VW5xNG1TYXpYUFJPVkdFaFBW?=
 =?utf-8?B?OG5oQWxCVzBEY3ZQU2NvWnR6aWtFREpQcGZVRWtJZVpsVnk5eDZhTmkyM29X?=
 =?utf-8?B?SEpvNHdUSEcvNS9LS1hoQVNqVDUyT1p3cjNVanRKWlZGckZucGhpN1EvK2tW?=
 =?utf-8?B?dGJNdUJCM1lkdnBnSHUyZmtKaXhKWkFaYTBzalB3VmhHQUdiUnBnVytqZVMw?=
 =?utf-8?B?ODFkNG1kb0FMY2wxWk5OTllsSnh2U3NxeHNkK2tOTEc3dFI5SVRoWmJ2eDd0?=
 =?utf-8?B?Yld3K3ZSRk1mY1RISDlGaXlrTVYvejFDa2F1dFpyeU5kMHpORGRXMnZKZ2xk?=
 =?utf-8?B?NlN1RFd3TlRFKzYrYk9ScVBDM1JWcFlZN24vK3NQU1gwWjd5dTFibWx2N2ZO?=
 =?utf-8?B?Yi8rQkJHZGxNc3ZxaE12U05XaDN3VFNZRER2ZWticUt5WDh4NForemxEZVdJ?=
 =?utf-8?B?eWNTZWpRY2hYdWhodjN1K3FxSTBNTWtEaWVsM3I0NkdhQmRMOEw0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b8c296-9f6a-4d10-2ad5-08deba833181
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 17:29:36.6591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWFbT++02jbCFTnm/8c1fsnmE4tS/k4xZMda8et3X2iw4O3QXZdX8MTTqWjOLFMUjepOxba7+CmtrxgyMObTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAxMzowOA0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNi8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBFbXVsYXRlIFZDTURRDQo+IHJlZ2lzdGVyIHdyaXRlcw0KDQpbLi4u
XQ0KDQo+ID4+PiArICAgIGNhc2UgQV9WQ01EUTBfQkFTRV9IOg0KPiA+Pj4gKyAgICAgICAgaWYg
KHRlZ3JhMjQxX3ZjbWRxX2VuYWJsZWQoY21kcXYsIGluZGV4KSkgew0KPiA+PiB3aGVyZSBpcyBp
dCBkb2N1bWVudGVkIGluIHRoZSBzcGVjPyBJIGRvbid0IHNlZSB0aGlzIHJlc3RyaWN0aW9uIGlu
DQo+ID4+IHRoZSByZWcgZG9jLiBUaGVuICJFbmFibGluZyB0aGUgdmlydHVhbCBDTURRIiBwYXJh
Z3JhcGggZGVzY3JpYmVzIGENCj4gPj4gc3RkIHNldHVwIGJ1dCBkb2VzIG5vdCBzYXkgLSBhZmFp
Y3MtIHRoYXQgaXQgc2hvdWxkIGJlIGlnbm9yZWQgLQ0KPiA+PiB3b3J0aCBjb21tZW50aW5nDQo+
ID4gUmlnaHQuIEkgZG9u4oCZdCB0aGluayBpdCBpcyBleHBsaWNpdGx5IHRoZXJlIGluIHRoZSBz
cGVjLg0KPiA+DQo+ID4gSG93ZXZlciwgTmljb2xpbiBtZW50aW9uZWQgYWJvdXQgc3VjaCBhIHJl
c3RyaWN0aW9uIGR1cmluZyB2NCBkaXNjdXNzaW9uOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvYWZ1RitzSnRFQXBXaXNwK0BudmlkaWEuY29tLw0KPiA+DQo+ID4gQUZB
SUNTLCBpdCBsb29rcyBsaWtlIGFuIGltcGxpZWQgYXNzdW1wdGlvbiBiYXNlZCBvbiB0aGUgIkVu
YWJsaW5nIHRoZQ0KPiA+IHZpcnR1YWwgQ01EUSIgc2VxdWVuY2Ugb3IgSSBtaXNzZWQgaXQuDQo+
ID4NCj4gPiBJIHdpbGwgZG91YmxlIGNoZWNrLg0KPiBPSw0KDQpJIGRpZCBhIGhhY2sgdG8gdGhl
IGhvc3Qga2VybmVsIGRyaXZlciB0byBzZWUgaG93IHRoZSBIVyBiZWhhdmVzIGlmIHdlDQpyZXBy
b2dyYW0gdGhlIEJBU0UgYWZ0ZXIgdGhlIFZDTURRIGlzIGVuYWJsZWQ6DQoNCisgICAgICAgLyog
SEFDSzogcmUtd3JpdGUgQkFTRSBhZnRlciBWQ01EUV9FTiAqLw0KKyAgICAgICB7DQorICAgICAg
ICAgICAgICAgdTY0IG9yaWcgPSB2Y21kcS0+Y21kcS5xLnFfYmFzZTsNCisNCisgICAgICAgICAg
ICAgICBwcmludGsoIiVzOiBTaGFtZWVyOiByZSB3cml0aW5nIGJhc2UgYWZ0ZXIgdmNtZHEgZW5h
YmxlLi5cbiIsIF9fZnVuY19fKTsNCisgICAgICAgICAgICAgICB3cml0ZXFfcmVsYXhlZCgwLCBS
RUdfVkNNRFFfUEFHRTEodmNtZHEsIEJBU0UpKTsNCisgICAgICAgICAgICAgICBwcl9pbmZvKCJC
YXNlIDogd3JvdGUgMCwgcmVhZGJhY2s9MHglbGx4IEdFUlJPUj0weCV4IFNUQVRVUz0weCV4XG4i
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgcmVhZHFfcmVsYXhlZChSRUdfVkNNRFFfUEFHRTEo
dmNtZHEsIEJBU0UpKSwNCisgICAgICAgICAgICAgICAgICAgICAgIHJlYWRsX3JlbGF4ZWQoUkVH
X1ZDTURRX1BBR0UwKHZjbWRxLCBHRVJST1IpKSwNCisgICAgICAgICAgICAgICAgICAgICAgIHJl
YWRsX3JlbGF4ZWQoUkVHX1ZDTURRX1BBR0UwKHZjbWRxLCBTVEFUVVMpKSk7DQorDQorICAgICAg
ICAgICAgICAgLyogUHV0IGl0IGJhY2sgYmVmb3JlIHNvbWV0aGluZyB0cmllcyB0byB1c2UgaXQg
Ki8NCisgICAgICAgICAgICAgICB3cml0ZXFfcmVsYXhlZChvcmlnLCBSRUdfVkNNRFFfUEFHRTEo
dmNtZHEsIEJBU0UpKTsNCisgICAgICAgICAgICAgICBwcl9pbmZvKCJiYXNlOiByZXN0b3JlZCwg
cmVhZGJhY2s9MHglbGx4XG4iLA0KKyAgICAgICAgICAgICAgICAgICAgICAgcmVhZHFfcmVsYXhl
ZChSRUdfVkNNRFFfUEFHRTEodmNtZHEsIEJBU0UpKSk7DQorICAgICAgIH0NCisNCg0KRnJvbSB0
aGUgYm9vdCBsb2dzLCB0aGUgSFcgYWNjZXB0ZWQgdGhlIEJBU0UgcmV3cml0ZToNCg0KICBbICAg
IDEuNTA0NzM1XSB0ZWdyYTI0MV92Y21kcV9od19pbml0OiBTaGFtZWVyOiByZSB3cml0aW5nIGJh
c2UgYWZ0ZXIgdmNtZHEgZW5hYmxlLi4NCiAgWyAgICAxLjUwNDczN10gQmFzZSA6IHdyb3RlIDAs
IHJlYWRiYWNrPTB4MCBHRVJST1I9MHgwIFNUQVRVUz0weDENCiAgWyAgICAxLjUwNDczOV0gYmFz
ZTogcmVzdG9yZWQsIHJlYWRiYWNrPTB4ZmEwMDAwMTMNCg0KU28gd3JpdGVzIHRvIEJBU0UgYWZ0
ZXIgZW5hYmxlIGFyZSBub3QgaWdub3JlZCBhdCB0aGUgcmVnaXN0ZXIgbGV2ZWwuDQpCdXQgSSBk
b24ndCB0aGluayBjb21tYW5kIHByb2Nlc3Npbmcgd2lsbCB3b3JrIGlmIHdlIGNoYW5nZQ0KQkFT
RSBvbiBhIGxpdmUgcXVldWUuDQoNCkZyb20gdGhlIFFFTVUgc2lkZSwgdGhlIGN1cnJlbnQgc2V0
dXBfdmNtZHEoKSBmcmVlcyB0aGUgZXhpc3RpbmcNCmh3X3F1ZXVlIGJlZm9yZSBjYWxsaW5nIElP
TU1VX0hXX1FVRVVFX0FMTE9DIGFnYWluLCBvdGhlcndpc2UgdGhlDQprZXJuZWwgcmV0dXJucyAt
RUVYSVNULiBTbyBpZiB3ZSBhbGxvdyBCQVNFIHJld3JpdGUgd2hpbGUgdGhlIFZDTURRDQppcyBl
bmFibGVkLCBpdCB3aWxsIHRyaWdnZXIgYSBkZXN0cm95K2FsbG9jIGN5Y2xlIGluIHRoZSBob3N0
IGRyaXZlci4NCg0KSSB0cmllZCByZW1vdmluZyB0aGUgdGVncmEyNDFfdmNtZHFfZW5hYmxlZChj
bWRxdiwgaW5kZXgpIHJlc3RyaWN0aW9uDQphbmQgcmV3cml0aW5nIEJBU0UgdHJpZ2dlcmluZyBh
IHNldHVwX3ZjbWRxKCkgYWdhaW4sIGFuZCB0aGUgZ3Vlc3QNCmVuZGVkIHVwIHdpdGg6DQoNCiAg
YXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5hdXRvOiBDTURfU1lOQyB0aW1lb3V0IGF0IDB4MDAw
MDAwMjMgW2h3cHJvZCAweDAwMDAwMDIzLCBod2NvbnMgMHgwMDAwMDAwMF0NCiAgYXJtLXNtbXUt
djMgYXJtLXNtbXUtdjMuMC5hdXRvOiBDTURfU1lOQyB0aW1lb3V0IGF0IDB4MDAwMDAwMjUgW2h3
cHJvZCAweDAwMDAwMDI1LCBod2NvbnMgMHgwMDAwMDAwMF0NCg0KSSB0aGluayBpdCBpcyBwcm9i
YWJseSBiZXR0ZXIgdG8ga2VlcCB0aGlzIGJlaGF2aW91ciAobGV0IHRoZSByZXdyaXRlDQpnbyB0
aHJvdWdoIGFuZCBzdXJmYWNlIGFzIGEgQ01EX1NZTkMgdGltZW91dCkgdGhhbiB0byBzaWxlbnRs
eSBpZ25vcmUNCnRoZSBCQVNFIHJlcHJvZ3JhbS4NCg0KQE5pY29saW4sIHRob3VnaHRzPw0KICAN
ClRoYW5rcywNClNoYW1lZXINCg0KDQo=

