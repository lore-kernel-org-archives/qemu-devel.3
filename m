Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82790CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMJR-0000Ou-8G; Fri, 08 May 2026 10:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLMJO-0000O3-WB; Fri, 08 May 2026 10:36:19 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLMJN-00070l-5w; Fri, 08 May 2026 10:36:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY9xf7KvU0KtEDEt9g0ZYIu6/hkpGqEnweeywClcyBugnzllSebx1hzC1NWp4XYS11DFiiAoQkEeT0NEWBUIjnH92vWUFOzXnU4kYdP3/hKKWIK7m42eMkc/GSlaqVFAeZNE59u4PXEaT8H/jCb99K/Hxbm6kzuvg6H2Tt11qtwNRsHJSIbMOYcLr5tXFbodWIqxLDujtZfBbnRHFFq7f57z7lsFNFvZUI8gYoiCvmUKuyZaFu7nttPCSMsvKvSOFyTKOuCBK9p1b0IVVWj8zORn1aZWFVSuVhp2Vdq2+q2yKMB+INtvIDS5rJj1/5ssVuV/jZS5dXzD/AQhfZxzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQweyYUpQoJo9aRlB7VOVmnfEJUcj9/eEAmkwUJflnM=;
 b=rnKnsmjIscn2rMDO3neHB3UEmqiWkyrBHeTV+5sQqWLGdo+Xm/iyTSwXMoDGphtIUmNk3XyseP7IY0lGo/CWYeyrN9mSNexx+dRZndQdRn1gdSiXX0MEc82ur6dvT0sgIFTX8l8kJc/qyqxgAOF2Tgsm3s6D6vHqvTBJURwwLdBZJ4Q46mHZkjfqojZ9cqiyAQoEMF6+Vm26X/QTrdZYAF7ZQUvLhiuEum+0ZKkMCi867Ik2CTn180jI1GKHXmNtA8U6km7m+Lg4BpNNSbNdvSyg7HluHGKqz9kJiwuHbIRyTbDmfIramdWgX4H7B04ghAHrzji7wEIbb6WjxCc5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQweyYUpQoJo9aRlB7VOVmnfEJUcj9/eEAmkwUJflnM=;
 b=JMP1jyKHiX3g4bTWhTFamWiMumDS9jzIQO5IMtaG62KhubJ/AH0Bn1lg7xjfrSpF2k6j05/zRrB7L5EQioTyXqeMwtaoYR+yYfVjQ4Hy0A+1wO+OvH8OSfliIEF+mxQruzvvQ70+tHEHV+4htrAdnhvlwSuPcc+VJjMSotoFhVxfv8VAiwXf+H8WxYyAJRQpoT8udwRA1sIoD61GPzWUYA8LpavDuU1QJ4dHkW0sLm/KP0fYOAx6rINj71F7fVfM35IyBGGqc1/d9TBJPD8jUsFOlO3pTy4RVZL3kbX8IeEsm2wWgAYsRBYugku8ZulrzfSjSjPZaLp6jb8B03Q4OQ==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 14:36:02 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:36:02 +0000
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
Subject: RE: [PATCH v4 30/31] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Thread-Topic: [PATCH v4 30/31] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Thread-Index: AQHczMbWt0Y6dveMWku/G3s5ldKrabYC9n8AgAFQkHA=
Date: Fri, 8 May 2026 14:36:01 +0000
Message-ID: <IA0PR12MB755515924AD70A273B7879A1AB3D2@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-31-skolothumtho@nvidia.com>
 <ff92645d-4501-4881-8ca2-47299968f0ca@redhat.com>
In-Reply-To: <ff92645d-4501-4881-8ca2-47299968f0ca@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|LV8PR12MB9154:EE_
x-ms-office365-filtering-correlation-id: 7636627a-9e0e-44e9-ac63-08dead0f20da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799003|56012099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: IHywu2dGrF6B8htG4+WC3A7ELdizEpblkSuxRwR4pWHvNfhhYgIbsvg5YeNip7jC3ibGsBj5+nrbiyiUdovsmxgBxeWBziurkawsN60al479UrZxN7en4yVIGPWIHfZSUtfESL6c9z4F2uLbsWMr+IHeP0LzXDPCDSqV51nBfVS4HIVKRK2gmuU88kPsQFpx84cGTyO2VuwcNvl1Xcwf1f6e11z5o4vVKwPyxQfUfRfBCzkjFHUJEcIsSySH7ADiZOcoQCfNsm/9PJT6vNFSqGX5EMR/n/UmfDhL2xjVc3Jv/ktYJuEhcgpTdkm1j6xbX13RHkybrNjzepiKRnMOK/Sz3GEpOlLyhC3l6/IQRz5SuEM7A67PFAHsdEBGq1iE7iD7wVkBnbS+nzTMFh2bWgel3qvIBohRNitYunJvY81CZ8tcNVmultGYNkUiBHA+gTE5niqPWJ6P3AydUSv15rPuoAsLsLLPOGMjb8nN+F7D1TUg/2142tRs/gMCP6ql0RT+CW3xmTcZGNuQST9PMjdVZVEvcItVVrjTFZP0GOjvPwPJ+Do//hKSF6JrxOso51AZFbBD9ZdT1IDxxp/jwpp7GuumqCJQ5+yHpJx8oxi4KIGuBZi5izjpgv7uip2VtHW4eaXo824qQ4E1P8CLgMSvK2OrtmzmOqxR00lNHgOv8dK6b75zgc07J03ze2RfoDH1vyWoQZDEA3KfESH6cWMLZjcZT4Ut7dMyf6aJ7oJgESVxAL48YpXsQA0wxE24
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799003)(56012099003)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWN1d0x5YmQ2TXd6K3NrOTBRWkZ3SzhCRmRqR1pBQnBqUi91YVcxc2JYUUds?=
 =?utf-8?B?b0tBclljaElmM0NiQzBzd1Q3NzBhYnJsR2JnanVHM1UwV3dUZUkwZFZmVFpR?=
 =?utf-8?B?NVZZNFhvZStrRytQTThDY2haY25wN2pkd3MxdHM2QUovWW5Pb3FzKzA5RjFi?=
 =?utf-8?B?dVVsTEFTQXE5VzN4ZFZRTm9PN0JiM3VqN05oVjBxcENmOE9pWEtqWVU4cUNl?=
 =?utf-8?B?WG51ek5ZM3pFNHYzdEJ4YUh4cWFuZ3A5U0lXb2VUeGRHdTlWVDNjRmttZXNU?=
 =?utf-8?B?dTlkV2NVSXpNM0VXMlp6VHR6OEZpTUhwd21JUGNpKzErN201YTkxSGFsYzdw?=
 =?utf-8?B?bllUa21lQ0xGR1IrSWU0RGF5SFVEZ1Q1MDMvMkZ6WFM0bFdHSnJlV3hQeEM2?=
 =?utf-8?B?TUY1N2JNMmpFbU1QOTJjSnJENHEyK0NSSTdZbENNd2QwVGQ0Y1BBdnlGY0Jz?=
 =?utf-8?B?SU1IOWpnU3N2MXhUOXMxbzdJb3kvb1I1YWY5dWdSdnd3QTBpMEtRRVByRWF4?=
 =?utf-8?B?a2hjeTZaZ0tKTVVRYVdpd0lCVG12OVlETS9SVG15MG1YN0Nab2dxVnNjaER5?=
 =?utf-8?B?eCt5aEJIN2tVT3ZvOGRSRTNXSjMzaFF6N3JyUWhMa2RZZG1kQnhCa1gyWndW?=
 =?utf-8?B?VUpVK0hjVmdlNFdtYTdHcndzOXZFekxlanB2d0ZtWExJeHVtOXV6QmVOREY5?=
 =?utf-8?B?cEF5c0xrend1OUN6U1pMeDc2K2I0eTB0ZTZwRk1hdzlXL096Um5HZFZuRFpr?=
 =?utf-8?B?Q1BTdDRIRDlYazdLOTVsTjl6ZDcybFhXbXdMYTk2MlVTOC96TDBNbFU1TndE?=
 =?utf-8?B?cm9TeXk0akJsMGJ2WXlqMDNCT2ZZQXRJOUZ6U3lvTksxd28yR0V4SGlWbXda?=
 =?utf-8?B?bno2QzVoVjR6Qy9NWE5XZDBlSFpPdlZXaDFQOWFFbktWVjNzYXhpZ0ZJVW9V?=
 =?utf-8?B?UW1mUWw5Rm9jb0NERFZKTk9hUXNxZkxPMUttTDErOUY0OWkyckkvNlZrK2Y0?=
 =?utf-8?B?V0ZKWWJBU2FTZ1ovTXpnOTFWSWZvK1JsS1I5UmREOE9ScFlnODFoSC9PUzVW?=
 =?utf-8?B?ajN0N3FRNEZHUFZia0ZWMkhNTlVMRHdLaDFIMVJ1TVlmcWhnZXRpYlRBQkR3?=
 =?utf-8?B?Nlo3K2lac0tCSUlTbmZjc04yZG9acFp0UWw5bldwQmxxei9rSUtBb0ZUbHov?=
 =?utf-8?B?b1JNTjkxNEd0TDJON01RU3ZidUF4YTZBVXBWUGV5VTlvSzFqOTVQMWxxZjRB?=
 =?utf-8?B?QS9hZ3hod1RHbFZreHgxcmJvUW1hZi85VHBmeFI2MVMralpscUY0VFRKZnNP?=
 =?utf-8?B?WE9qc2hJNHJ5NW42VDZpNXFIQ3Z6N0J6Z3VRakQ5M3dUcThzL2w3cVFJU2RG?=
 =?utf-8?B?dUV0bFh2N25qRmNlNklhcnJyaHZsS0s0c3o5R3Z2Q0NvTXYzVGF2YTBHdHor?=
 =?utf-8?B?aGorWDk1NnpMYTRjSnQrYmFzVHgzT28rTFYxTldic0Y3ZE9IRmNoZXBlbEg5?=
 =?utf-8?B?RnMyQXllWXpyaFZNMzlUZ08xQ0VwcERWTnJSdmR0WWROTjM4MEJ1OWExK1Rx?=
 =?utf-8?B?ek1xM1hHMEhhQ3h5a01uOTBSUjdGZjJycWQxUHNWVlZZVTlDL013RWVFV0Rv?=
 =?utf-8?B?aGhiZHZZbG5OTHd4RjJuU1dUbC8waTRQM2NTcmpveEJhbVIzK0dtckFBR3hL?=
 =?utf-8?B?Y2xHWEozRGNUV1JFMzk3Ly9CUDFBdjVoMVl5bSt4MjJSODJxMEl4aXRQZGlE?=
 =?utf-8?B?VkZtWHNKMGRxZ1VLbUlVZmdGeDdYR0dTWE1uNHFQWE5zZ2gxWXcybWI3QkM3?=
 =?utf-8?B?ZFZ0VVllTCtMTXFSY3A3NGgrMS9TUVYwSVhtazRIM3pNTTVnV29YTFRBbnhV?=
 =?utf-8?B?N3lsekJ0cUtYQlFWQWhETlhMZi92WE5sNTJqejY3WXhPRUMwUzVWMDh1aEFw?=
 =?utf-8?B?V0JwVEZOa2FkTTRSb3hLUnhPdHYxMTF6NHl2dVM0UkRxaGpKYkd3OStrazNu?=
 =?utf-8?B?aWJZR2lwdTEvQkRURDBDTUFOMTlqdnR0dkZtVG9hQWZCY3dWbWkzRTZ4cHFL?=
 =?utf-8?B?WG1oZytubGcwZmhFdjV3cENzeGsvZUpOSFo4YlMzbEJQTlNPeHViZkNmVFpI?=
 =?utf-8?B?Y3g1SzBUUk9udHFqYjJxdWxsOUdvSHVUMnFHL21VZXBpU25jQTlZZWRPRVd2?=
 =?utf-8?B?VTJWeHlPOU5kTGQxUkplK3gzTUVQb0ovSFJsMDNiWDBCUDM4Z05ZSHNrMWVm?=
 =?utf-8?B?RkRzN3dDK0JnQ2hpTHliY2p4SWtIWG1WdGc3YXlxMGFqQ3pwdm91OTgxN25R?=
 =?utf-8?B?NlVLOFZYa2h0ajhrVm9vTUpKaXJhZkNrSDJheTJqNDE2ODd6NXNpQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7636627a-9e0e-44e9-ac63-08dead0f20da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 14:36:01.9923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPlIcWuOvmB401coLthAvDWjP3konoaLnRnXZeP+N4SfwTCMN1QHSdZoM9QREl0CsntiljGSOA+DUYLpbBOH2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNyBNYXkgMjAyNiAxODozNg0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDMwLzMxXSBody9hcm0vc21tdXYzLWFjY2VsOiBFbmZvcmNlIHZp
b21tdQ0KPiBhc3NvY2lhdGlvbiB3aGVuIENNRFFWIGlzIGFjdGl2ZQ0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBPbiA0LzE1LzI2IDEyOjU1IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFdoZW4g
Q01EUVYgaXMgYWN0aXZlLCB0aGUgZmlyc3QgY29sZC1wbHVnZ2VkIFZGSU8gZGV2aWNlIGVzdGFi
bGlzaGVzDQo+ID4gdGhlIHZpb21tdSB0byBob3N0IFNNTVV2MyBhc3NvY2lhdGlvbi4gQmxvY2sg
aXRzIGhvdC11bnBsdWcgdG8NCj4gPiBwcmVzZXJ2ZSB0aGlzIGFzc29jaWF0aW9uIGFuZCB0aGUg
Z3Vlc3QncyBib290IHRpbWUgQ01EUVYgY29uZmlndXJhdGlvbi4NCj4gPg0KPiA+IEFsc28gYWJv
cnQgYXQgbWFjaGluZV9kb25lIGlmIGNtZHF2PW9uIGlzIHJlcXVlc3RlZCBidXQgbm8NCj4gPiBj
b2xkLXBsdWdnZWQgVkZJTyBkZXZpY2Ugd2FzIHByZXNlbnQgdG8gaW5pdGlhbGl6ZSBpdC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0Budmlk
aWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmggfCAgMSArDQo+ID4g
IGh3L2FybS9zbW11djMtYWNjZWwuYyB8IDEyICsrKysrKysrKysrKw0KPiA+ICBody9hcm0vc21t
dXYzLmMgICAgICAgfCAgNiArKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1hY2NlbC5oIGIvaHcv
YXJtL3NtbXV2My1hY2NlbC5oIGluZGV4DQo+ID4gM2VkOTRlZDA1Yy4uYzQ0NDFkNWIzZiAxMDA2
NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmgNCj4gPiArKysgYi9ody9hcm0vc21t
dXYzLWFjY2VsLmgNCj4gPiBAQCAtNjUsNiArNjUsNyBAQCB0eXBlZGVmIHN0cnVjdCBTTU1VdjNB
Y2NlbERldmljZSB7DQo+ID4gICAgICBJT01NVUZEVmRldiAqdmRldjsNCj4gPiAgICAgIFFMSVNU
X0VOVFJZKFNNTVV2M0FjY2VsRGV2aWNlKSBuZXh0Ow0KPiA+ICAgICAgU01NVXYzQWNjZWxTdGF0
ZSAqc19hY2NlbDsNCj4gPiArICAgIEVycm9yICp1bnBsdWdfYmxvY2tlcjsgLyogc2V0IHdoZW4g
Q01EUVYgaXMgYWN0aXZlIHRvIGJsb2NrDQo+ID4gKyBob3QtdW5wbHVnICovDQo+ID4gIH0gU01N
VXYzQWNjZWxEZXZpY2U7DQo+ID4NCj4gPiAgYm9vbCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNT
dGF0ZSAqcywgRXJyb3IgKiplcnJwKTsgZGlmZiAtLWdpdA0KPiA+IGEvaHcvYXJtL3NtbXV2My1h
Y2NlbC5jIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jIGluZGV4DQo+ID4gYTU4ODE1ZGVkMi4uZjM4
MTcwMmEwOCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiArKysg
Yi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBAQCAtNzU0LDYgKzc1NCwxOCBAQCBzdGF0aWMg
Ym9vbA0KPiBzbW11djNfYWNjZWxfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAq
b3BhcXVlLCBpbnQgZGV2Zm4sDQo+ID4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICAgICAg
fQ0KPiA+DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogQ01EUVYgaXMgYWN0aXZlOiBibG9jayBo
b3QtdW5wbHVnIG9mIHRoZSBkZXZpY2UgdGhhdCBlc3RhYmxpc2hlZCB0aGUNCj4gPiArICAgICAq
IHZpb21tdSBhc3NvY2lhdGlvbi4gUmVtb3ZpbmcgaXQgd291bGQgY2F1c2UgdGhlIHZJT01NVSB0
byBob3N0DQo+IFNNTVV2Mw0KPiA+ICsgICAgICogYXNzb2NpYXRpb24gYmUgY2hhbmdlZCB2aWEg
ZGV2aWNlIGhvdC1wbHVnLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBpZiAocy0+c19hY2NlbC0+
Y21kcXZfb3BzKSB7DQo+ID4gKyAgICAgICAgUENJRGV2aWNlICpwZGV2ID0gcGNpX2ZpbmRfZGV2
aWNlKGJ1cywgcGNpX2J1c19udW0oYnVzKSwgZGV2Zm4pOw0KPiA+ICsgICAgICAgIGVycm9yX3Nl
dGcoJmFjY2VsX2Rldi0+dW5wbHVnX2Jsb2NrZXIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAi
Q01EUVYgaXMgYWN0aXZlOiByZW1vdmluZyB0aGUgZGV2aWNlIHRoYXQgZXN0YWJsaXNoZWQgdGhl
ICINCj4gPiArICAgICAgICAgICAgICAgICAgICJ2aW9tbXUgYXNzb2NpYXRpb24gd291bGQgYnJl
YWsgdGhlIGd1ZXN0IENNRFFWIik7DQo+IEl0IGlzIHNvbWV0aGluZyB0aGF0IGlzIHBsYW5uZWQg
dG8gYmUgZml4ZWQgbGF0ZXIgb24/DQoNCk5vdCByZWFsbHkuIEl0IGlzIG5vdCBzdHJhaWdodGZv
cndhcmQgdG8gc3VwcG9ydCBob3QgdW5wbHVnIG9mIHRoZSBkZXZpY2UgdGhhdA0KZW5hYmxlZCB0
aGUgVkNNRFEgb24gdGhlIGFzc29jaWF0ZWQgU01NVXYzLg0KDQo+IGNhbiB5b3UgcHJvdmlkZSBt
b3JlIGRldGFpbHMgYWJvdXQgdGhlIG5hdHVyZSBvZiB0aGUgYnJlYWthZ2UNCg0KT25lIHNjZW5h
cmlvIGNvdWxkIGJlOg0KLSBDb25zaWRlciB0d28gU01NVXYzK0NNRFFWIGluc3RhbmNlcywgZWFj
aCB3aXRoIGEgcGFzc3Rocm91Z2ggZGV2aWNlOg0KICAgLSBkZXZfQSDihpIgU01NVXYzX0EgKyBD
TURRVl9BDQogICAtIGRldl9CIOKGkiBTTU1VdjNfQiArIENNRFFWX0INCi0gR3Vlc3QgYm9vdHMg
d2l0aCBkZXZfQSBjb2xkLXBsdWdnZWQ7IENNRFFWX0EgaXMgcHJvYmVkLCB2aW9tbXUgYWxsb2Nh
dGVkDQogIGFnYWluc3QgU01NVXYzX0EvQ01EUVZfQSwgYW5kIGR1cmluZyBndWVzdCBib290IHRp
bWUgQ01EUVYgY29uZmlndXJhdGlvbg0KICBpcyBlc3RhYmxpc2hlZA0KLSBJZiBkZXZfQSBpcyBo
b3QtdW5wbHVnZ2VkLCBRRU1VIHdvdWxkIGhhdmUgdG8gcmVsZWFzZSB0aGUgdmlvbW11IGFuZCB0
ZWFycw0KICBkb3duIGFsbCBhc3NvY2lhdGVkIENNRFFWIHN0YXRlIChWSU5URnMsIFZDTURRcykN
Ci0gSWYgZGV2X0IgaXMgc3Vic2VxdWVudGx5IGhvdC1wbHVnZ2VkLCBRRU1VIGFsbG9jYXRlcyBh
IG5ldyB2aW9tbXUgYWdhaW5zdA0KICBTTU1VdjNfQi9DTURRVl9CLg0KLSBUaGUgZ3Vlc3QsIGhv
d2V2ZXIsIHN0aWxsIGhvbGRzIHRoZSBib290IHRpbWUgU01NVXYzX0EvQ01EUVZfQSBjb25maWd1
cmF0aW9uDQogKFZJTlRGcywgVkNNRFFzKSBhbmQgd2lsbCBjb250aW51ZSBpc3N1aW5nIGNvbW1h
bmRzIGFnYWluc3QgaXQuIA0KDQpCbG9ja2luZyBob3QtdW5wbHVnIG9mIHRoZSBlc3RhYmxpc2hp
bmcgZGV2aWNlIHByZXZlbnRzIHRoaXMgdmlvbW11L0NNRFFWDQp0ZWFyZG93biBmcm9tIGhhcHBl
bmluZyB3aGlsZSB0aGUgZ3Vlc3QgaXMgYWN0aXZlbHkgdXNpbmcgaXQuDQoNClN1cHBvcnRpbmcg
aG90LXVucGx1ZyBtYXkgYmUgcG9zc2libGUgaWYgd2UgcmV0YWluIHRoZSBTTU1VdjMtdG8tdmlv
bW11DQphc3NvY2lhdGlvbiBldmVuIGFmdGVyIHRoZSBkZXZpY2UgaXMgdW5wbHVnZ2VkLiBIb3dl
dmVyLCB0aGF0IHdvdWxkDQpyZXF1aXJlIGRpZmZlcmVudCBsaWZldGltZSBtYW5hZ2VtZW50IGlu
IHRoZSBTTU1VdjMgYWNjZWwgYW5kIFZGSU8gY29kZQ0KcGF0aHMsIHdoaWNoIHdvdWxkIGJlIG5v
bi10cml2aWFsLg0KDQpUaGVyZSBpcyBubyBzdHJvbmcgdXNlciByZXF1aXJlbWVudCBmb3Igc3Vw
cG9ydGluZyBob3QgdW5wbHVnIG9mIHRoZSBkZXZpY2UNCmxpa2UgaW4gdGhlIGFib3ZlIHNjZW5h
cmlvIG9uIHRoZXNlIHBsYXRmb3JtcyBlaXRoZXIuDQoNClRoYW5rcywNClNoYW1lZXINCg==

