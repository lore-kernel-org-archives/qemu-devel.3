Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692D3C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26F2-0003GC-Mv; Thu, 03 Sep 2026 08:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x26Ey-000342-2B; Thu, 03 Sep 2026 08:08:24 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x26Ev-0005uu-Qx; Thu, 03 Sep 2026 08:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXnGaIGVIjSiPR8ICOP29clktBlGqDdfhmoK60n96m1fOhu+PZ7UZuhQqC23mbv8iGI3HWT6omJR1vJtXGG2DkhjlJaW9vjC1PK3450YUgSBBFkd0EoPEIxZofeMUomPuJgghNpqkoQ/emJKFJtbJm8Iux1SqEKKbhq/1GaJb7TFwiDkK1T/LyBnGchzxdOOrRfw1gNduXU5ni4AjkYwp8rMkvYdC7JZur2NraJlPjYxuwSiiO4Xg7xmE7JiNgMdipNsP0VG/dG4th/hMR7sErlB0p2TBU5nJGY9tM+5+PK+Gpat91zg3yzExqpKlSydKGfgnpAA11MGp0eI88j0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3TkaNbRw7Ki8OgZPAG/GGxR3GRCyOQEZmTqmo4qek0=;
 b=LAH62k+1epxENxJKSU/3uGLxNu3HUsIK7YD/ssP5UlQdgIz6OR46yfFOdiOA69GJ2o4cYeBtD7gbU9VqlmChOQZhe9lBcUfYakqcwUbwh27xXSRzYKe4nrhLxjyqxKd+eP+2hT6kpMzjXa1iE1FuH9FVE31NJqYewZmZbQlNAzFtrSwc5kWGkPTz/NgIIK/+GCgrznmPnCL2FrF68+SdXYs3Fpn5kPc2ffdLVXsKemIXnBgnWX+ZPWuUi7JO5k54dlPH3tobt3UEL7VYglj3V0oxJ1k08IsvvLzRg+Pv8dYY15iNk+OBOaFBI4lrstwo8sm6xbvHMyoevmxEdbatQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3TkaNbRw7Ki8OgZPAG/GGxR3GRCyOQEZmTqmo4qek0=;
 b=ZnQovsr9jg1nig0FVJ8BifzPHUIWtoWhlxNQoSTFLwpPnnURAliflJwiCRNoGVfN4NoGMW5mj1IKY3FJpWsK6RJGmzb1NHcWWFnIKnKiurQ3LswmpG/6TzUNJ87iYsq+s4b3eJDROQXi5XZc9sRJIK3nk2o2uB7KQXgle3opTyl3OL87DQka5tSTh7bjkuc4O7/XctsEZn+kzAyc+c3kgvI1Ofuv8zBOnGwKiDZsBJ/fI8rbx3ysI+YCe4j7V99EmtwTAo//e5b2Gu2hjXCFsjNN4QOPwySj5zhBcphyoKyvcTku+/x6TvIsXrxEKVJlPkEgaKNgwgdDEUWnIwbG+w==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:08:11 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:08:11 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Farhan Ali <alifm@linux.ibm.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
CC: "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>, "farman@linux.ibm.com"
 <farman@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "armbru@redhat.com"
 <armbru@redhat.com>
Subject: RE: [PATCH v4 2/4] vfio/pci: Add an error handler callback
Thread-Topic: [PATCH v4 2/4] vfio/pci: Add an error handler callback
Thread-Index: AQHdOXcv0gUaqc3nq0S/eQQmasGmmLa68WKAgACNiACAAUVboA==
Date: Thu, 3 Sep 2026 12:08:10 +0000
Message-ID: <SJ0PR12MB8614E80E4BAB0FC192BB224BABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
 <d32b992a-e4b2-494a-ad27-e38caaff7dc1@linux.ibm.com>
In-Reply-To: <d32b992a-e4b2-494a-ad27-e38caaff7dc1@linux.ibm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|CH3PR12MB8909:EE_
x-ms-office365-filtering-correlation-id: 8e3621a9-b3b5-4ef9-f1ce-08df09b405fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: y+HS5L3nojGYgKlh2ytjLctG7MKyS4zC9bdje062JMC3NFaZcxV66zPQbuOPKzt14WRkgQ0YdD5o/57HszErwhOTr9V773Z9Nx8Iy1bMolUvFUmSH1QoDWFP1C72B4gZ8oGrKJ7OWSCk2IfcczyijUnjYBC0DFsTgq3dXsGxANf/JPa7dCGV66NiKwBCSaD7SIEjho7CwC+xn848sWV6Qqv2SjuZRmU+NVc9pZIJ5JvOUdjSWdQWsZntXlrpSAX5mb8wwlH7em6P5dpvMIIKKmF4PXbWHQL2x1NYvdWEBViEzKuhpovlO7UGq8+CigGUb9Eqq5b/OSTNNpsYtyJP5TJ+0vqNN76PSuh+s9qdNswyyx1TMwrDVXcEWAoKYNvS7HqfV1dKZsP+RLGJSLUvwACIBFtYqu8/5rfFjCVcSV6G/RjSya/IS5cjQmDENG17n9GvRatXoBT2Hru67BUlQtxKIl7O8CIX2A3NeBzLCxqemsPRLuNOGUMcjgsadFCY75LOnoQRIAQpDZMJX00olXQR8dmYlHDczrdGaxRPQSJa9ChdygkhzgZpLmqeTsyjb0UVETskS6iP+gax1Qb4+QHQWZnlGrlCqIjVZURdZE6IZwki8m3yaZVp/SDVaNhEpDgJwj5O3e0hkbVJ7VEk58D7Mr2QNLjKaC9yXnLhucIqv7yFicY39q/5SxvtawcGWo7cetzfu6K2TyLkP/x0hvzG6Tc3U4cQU47LWvWF8h8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzBST21hR3dWZkEybVlvV21aRCtpVHlPbU9KenZ6M3hkTXJtLzkvNmZKZzRL?=
 =?utf-8?B?dk05Vk1KT1puOVdPTnFzbG1xa2kvcFFoRVViajF1UlUyRlI1L2FLOVZybnJs?=
 =?utf-8?B?cFBmY2JuTWRBQmpIVjdqcXMzaHJIVUR5VVN6aU5sRDV0dXltaGtibkgwSHN6?=
 =?utf-8?B?bzd5OUhvUkEwL2NUTmpNOFoxWVgrUmtEbWpCU1hmcHE0KzB0ZEZ1RmIreGFs?=
 =?utf-8?B?VEVFd2pDZXlmMEJRTHZDNTBBeHBSZ2JSeEd6VkloeUlpOXVibGh1MXlhZXZ6?=
 =?utf-8?B?ekFMMVJTbllzL2E0RWFZNTZFSTdoSzNub044QlIzRGhnd1B3M0ZuU3NWZllR?=
 =?utf-8?B?VHprcVVTWDlkaS9yVkVjS1psYmE3MlpjQ2UvUXA3SUxDeC81dXBhK0haWmdn?=
 =?utf-8?B?NVJCS1pYL1p1OWZLbXdRTVdCZEhzckhBbVQ2WEJDMlBQM2pWLzRjaklZaFpO?=
 =?utf-8?B?ZUhjSCtSUDRWQUo0cjEyY3NhcjFOaEgwdTlYQVRib3hOekhUVFBmeFd0WXA3?=
 =?utf-8?B?WUxCL1lYMlk2dUQzTTlKZWo3Q3grMExwcWZlQzNnYVBleG92b0oxSVg4Y0hX?=
 =?utf-8?B?T0RkRDhudGpld0dJOE1kcFR6RkVpZ0hodzh5cG44UHg0eHBpS2M0MHZEdGxU?=
 =?utf-8?B?ajZXR0xXTmdLV0lZK1ZxUE5hWjZmdmdHSzR2ekZ5Qk5yTnJzMFNkYkhBR3p1?=
 =?utf-8?B?V09vZmxsSGtzOEdvb2FqNlMveFVURG0zTm4xSG1GQUVQUStmUjF5N3lwUVR3?=
 =?utf-8?B?cGNLNTdoZUtpVmJWMEtnVDh6UDRnSU1lVkhGRHpmWkhIWnhPa3h5MGtqOTdG?=
 =?utf-8?B?andxN2VVZkV1bHl3YVlPcWQ4Y3NmUU1scmIrZDI1cmZzSDNoUHNKUTE4bGd5?=
 =?utf-8?B?cjI3THVrZ0llcTYyUHRYOUI2ZVd4bVA1SkxBU2xpTnMwTmZyNjNiZW9rMW1n?=
 =?utf-8?B?RU02WjNRYXZrYWRJblh1L3FMaG5pUFZVNHJ6Zmg1YTQwOXNiU1R6UFJmZTR0?=
 =?utf-8?B?TDlaMi82QWo4aWZsOVZvY2VrcVZFajJuNlVMNUJJY3NKMkp4K2xTS0ZTNTBw?=
 =?utf-8?B?Z1RkWTBUdXNSUmY4YW0wblJ0NWlBWkZVSEhXV085b1laaE83OUZpMjNCTjAz?=
 =?utf-8?B?QmdnTmluSWdlS05LZ0o3L0dTRlhtZVNzTHN5QlZNSWlwOERETGxnSFF5dnkw?=
 =?utf-8?B?N0VPaFk3REwrRnlQR1ovT2F6MWd5QStvc0Fsak1UNHMvcnNPYWhBWUs2MTNs?=
 =?utf-8?B?enQ1R0NJa1p5VzZ5Wm41Q1NaNGRlM3M5WSs4TkkyWkFZeFZmbHhXTG55RUlT?=
 =?utf-8?B?YSs3ZUcxUm83b1hCTGdyYmloQ0wxVGtUWjVlNDVsbTNxWitTZ1NUelNNbGtS?=
 =?utf-8?B?akplb091NTBGY0RhYW5TR3IyN0g1Q0gycFdvQWpjSkNVVjBDNEw0dW1pZjR1?=
 =?utf-8?B?Nm45UVNqcjkrNENEVlBoTEozRFlTNUg0Yks5VkxQa0d1SmhHblRSWUgzeVNn?=
 =?utf-8?B?bWY4V0huTHlVajdsSWw0RS80TU53c0FXcWcvTXViZTVmQmdjNWE3VEVFRXBD?=
 =?utf-8?B?NEp4RFpkM0pEZXRRdmgwR1pGWkxRZFRtdnJ1NXBOTjFBTkUzWDUrM0h1b2h2?=
 =?utf-8?B?TE5xckVMQkVicEFOOXBGLzJ6V0VKaVlVZ0h6cy90d000RXQ1ejNRcWVYMUpO?=
 =?utf-8?B?Y01jeDJ4elR4dk51TFVLRytZc3F6ZXZkb0ZJdFJraFk0TFdMeEpMNjh4dG9o?=
 =?utf-8?B?Ri9NZCtUZXg3UUZ3a2g1a2VIWmxJNWN0MytKWCtkSzBTNEQrZzlaSXNYYWxD?=
 =?utf-8?B?eUNxWXBZSEx3QkFpajY0MkJKbXNCWVgxVWxwU3FybFc3ckxlS1oreUFCRDFt?=
 =?utf-8?B?NXF1S1FCK2RvaWhJN3pJOFpVRk5Yc25TUTUyYk1xeEt0TGV0YWlTcEg0K2lv?=
 =?utf-8?B?YkVTSndoZ1h6cFBoV1dVaTRvd3UwRHpNRmc5N1oxb2hLVXFCalkvN1lBcGRy?=
 =?utf-8?B?M1VDVk1CUWZFbnNlUzJabHM4WmJ6SEF3OUUxZC9KTUVmQmVrZVplQU1oRzNu?=
 =?utf-8?B?TTBxb0hKQnNsNTBRYVpjU1ZoNCs3TGxzMndSSXJ3c2d1bjRFSFdvUHNvRGVL?=
 =?utf-8?B?bWNjN2RtelM2NTVHOXVzZmFBOVJ5MWlOeWJpVnNEWGE0ZFBwT3lMZDNzbE55?=
 =?utf-8?B?d09YaHNHMHl1V1h5emszNFJzR3V2c09zSUtPc1dDSHZsZ2o4S0F6bisyMjF3?=
 =?utf-8?B?R01OOEhTUE1NUEJ6SGhaWGI0anEvckRUclNsRUJFRk1lZUdjdmZlNzBnSzN2?=
 =?utf-8?B?ajhYaVNHeVVzeG81eXE0bEZjRzRGT3hUNTZFajhJSmRnbFRHZjNQUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3621a9-b3b5-4ef9-f1ce-08df09b405fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 12:08:10.8940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFHliE/p2dpLfhIaU9hcfxsFrchK7Fv7hCtW14dSDwetDE1ERQKWH2mLir5S4Jboe+dxJZ2uqKKDWmJ1LedEng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFyaGFuIEFsaSA8YWxp
Zm1AbGludXguaWJtLmNvbT4NCj4gU2VudDogMDIgU2VwdGVtYmVyIDIwMjYgMTc6MzQNCj4gVG86
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgcWVtdS0NCj4gczM5MHhAbm9uZ251Lm9yZw0KPiBDYzogbWpyb3NhdG9AbGludXguaWJtLmNv
bTsgZmFybWFuQGxpbnV4LmlibS5jb207IGNvaHVja0ByZWRoYXQuY29tOw0KPiBhbGV4QHNoYXpi
b3Qub3JnOyBhcm1icnVAcmVkaGF0LmNvbTsgU2hhbWVlciBLb2xvdGh1bSBUaG9kaQ0KPiA8c2tv
bG90aHVtdGhvQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi80XSB2Zmlv
L3BjaTogQWRkIGFuIGVycm9yIGhhbmRsZXIgY2FsbGJhY2sNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24g
OS8yLzIwMjYgMTowNyBBTSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4gK1NoYW1lZXIs
IHdobyBpcyBsb29raW5nIGF0IGZvcndhcmRpbmcgQUVSIGVycm9ycyB0byBndWVzdCA6DQo+ID4N
Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LQ0KPiBkZXZlbC9TSjBQUjEyTUI4NjE0
RERGRUUzQTk1NzU1NjRFREVGOTlBQkZGMkBTSjBQUjEyTUI4NjE0Lm4NCj4gYW1wcmQxMi5wcm9k
Lm91dGxvb2suY29tLw0KPiA+DQo+ID4gT24gOC8zMS8yNiAyMDozMSwgRmFyaGFuIEFsaSB3cm90
ZToNCj4gPj4gUHJvdmlkZSBhIHZmaW8gZXJyb3IgaGFuZGxpbmcgY2FsbGJhY2ssIHRoYXQgY2Fu
IGJlIHVzZWQgYnkgZGV2aWNlcyB0bw0KPiA+PiBoYW5kbGUgUENJIGVycm9ycyBmb3IgcGFzc3Ro
cm91Z2ggZGV2aWNlcy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRmFyaGFuIEFsaSA8YWxp
Zm1AbGludXguaWJtLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgaHcvdmZpby9wY2kuYyB8IDI3ICsr
KysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+PiAgIGh3L3ZmaW8vcGNpLmggfMKgIDEgKw0K
PiA+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+
ID4+IGluZGV4IDQyOGFiMmYwNjkuLmEyZjQ4OWIzNGQgMTAwNjQ0DQo+ID4+IC0tLSBhL2h3L3Zm
aW8vcGNpLmMNCj4gPj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPiA+PiBAQCAtMzI0NCwyMSArMzI0
NCwzNiBAQCB2b2lkIHZmaW9fcGNpX3B1dF9kZXZpY2UoVkZJT1BDSURldmljZQ0KPiAqdmRldikN
Cj4gPj4gICBzdGF0aWMgdm9pZCB2ZmlvX2Vycl9ub3RpZmllcl9oYW5kbGVyKHZvaWQgKm9wYXF1
ZSkNCj4gPj4gICB7DQo+ID4+ICAgICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSBvcGFxdWU7DQo+
ID4+ICsgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+ID4+ICAgICAgICAgaWYgKCFldmVudF9ub3Rp
Zmllcl90ZXN0X2FuZF9jbGVhcigmdmRldi0+ZXJyX25vdGlmaWVyKSkgew0KPiA+PiAgICAgICAg
ICAgcmV0dXJuOw0KPiA+PiAgICAgICB9DQo+ID4+ICAgICAgICAgLyoNCj4gPj4gLSAgICAgKiBU
QkQuIFJldHJpZXZlIHRoZSBlcnJvciBkZXRhaWxzIGFuZCBkZWNpZGUgd2hhdCBhY3Rpb24NCj4g
Pj4gLSAgICAgKiBuZWVkcyB0byBiZSB0YWtlbi4gT25lIG9mIHRoZSBhY3Rpb25zIGNvdWxkIGJl
IHRvIHBhc3MNCj4gPj4gLSAgICAgKiB0aGUgZXJyb3IgdG8gdGhlIGd1ZXN0IGFuZCBoYXZlIHRo
ZSBndWVzdCBkcml2ZXIgcmVjb3Zlcg0KPiA+PiAtICAgICAqIGZyb20gdGhlIGVycm9yLiBUaGlz
IHJlcXVpcmVzIHRoYXQgUENJZSBjYXBhYmlsaXRpZXMgYmUNCj4gPj4gLSAgICAgKiBleHBvc2Vk
IHRvIHRoZSBndWVzdC4gRm9yIG5vdywgd2UganVzdCB0ZXJtaW5hdGUgdGhlDQo+ID4+ICsgICAg
ICogV2UgY2FuIHJldHJpZXZlIHRoZSBlcnJvciBkZXRhaWxzIGFuZCBkZWNpZGUgd2hhdCBhY3Rp
b24NCj4gPj4gKyAgICAgKiBuZWVkcyB0byBiZSB0YWtlbiBpbiBlcnJfaGFuZGxlcigpLiBPbmUg
b2YgdGhlIGFjdGlvbnMgY291bGQNCj4gPj4gKyAgICAgKiBiZSB0byBwYXNzIHRoZSBlcnJvciB0
byB0aGUgZ3Vlc3QgYW5kIGhhdmUgdGhlIGd1ZXN0IGRyaXZlcg0KPiA+PiArICAgICAqIHJlY292
ZXIgZnJvbSB0aGUgZXJyb3IuIFRoaXMgcmVxdWlyZXMgdGhhdCBQQ0llIGNhcGFiaWxpdGllcyBi
ZQ0KPiA+PiArICAgICAqIGV4cG9zZWQgdG8gdGhlIGd1ZXN0Lg0KPiA+PiArICAgICAqDQo+ID4+
ICsgICAgICogSWYgZXJyX2hhbmRsZXIoKSBpcyBub3QgaW1wbGVtZW50ZWQvZmFpbHMsIHdlIGp1
c3QgdGVybWluYXRlIHRoZQ0KPiA+PiAgICAgICAgKiBndWVzdCB0byBjb250YWluIHRoZSBlcnJv
ci4NCj4gPj4gICAgICAgICovDQo+ID4+ICAgLSAgICBlcnJvcl9yZXBvcnQoIiVzKCVzKSBVbnJl
Y292ZXJhYmxlIGVycm9yIGRldGVjdGVkLiBQbGVhc2UNCj4gPj4gY29sbGVjdCBhbnkgZGF0YSBw
b3NzaWJsZSBhbmQgdGhlbiBraWxsIHRoZSBndWVzdCIsIF9fZnVuY19fLA0KPiA+PiB2ZGV2LT52
YmFzZWRldi5uYW1lKTsNCj4gPj4gKyAgICBpZiAodmRldi0+ZXJyX2hhbmRsZXIgJiYgdmRldi0+
ZXJyX2hhbmRsZXIodmRldiwgJmVycikpIHsNCj4gPj4gKyAgICAgICAgcmV0dXJuOw0KPiA+PiAr
ICAgIH0NCj4gPj4gKw0KPiA+PiArICAgIGlmIChlcnIpIHsNCj4gPj4gKyAgICAgICAgZXJyb3Jf
cHJlcGVuZCgmZXJyLCAiVW5yZWNvdmVyYWJsZSBQQ0llIGVycm9yIGRldGVjdGVkIGZvcg0KPiA+
PiBkZXZpY2UgJXMiLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgIHZkZXYtPnZiYXNlZGV2
Lm5hbWUpOw0KPiA+PiArICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGVycik7DQo+ID4+ICsgICAg
fSBlbHNlIHsNCj4gPj4gKyAgICAgICAgZXJyb3JfcHJpbnRmKCJVbnJlY292ZXJhYmxlIFBDSWUg
ZXJyb3IgZGV0ZWN0ZWQgZm9yIGRldmljZSAlcyIsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICB2ZGV2LT52YmFzZWRldi5uYW1lKTsNCj4gPj4gKyAgICB9DQo+ID4+ICsgICAgZXJyb3JfcHJp
bnRmKCJQbGVhc2UgY29sbGVjdCBhbnkgZGF0YSBwb3NzaWJsZSBhbmQgdGhlbiBraWxsIHRoZQ0K
PiA+PiBndWVzdCIpOw0KPiA+DQo+ID4gaG93IGFib3V0IHRoYXQgaW5zdGVhZCA6DQo+ID4NCj4g
PiAgIGlmIChlcnIpIHsNCj4gPiAgICAgICBlcnJvcl9yZXBvcnQoIlVucmVjb3ZlcmFibGUgUENJ
ZSBlcnJvciBkZXRlY3RlZCBmb3IgZGV2aWNlICVzOiAlcyIsDQo+ID4gICAgICAgICAgICAgICAg
ICAgIHZkZXYtPnZiYXNlZGV2Lm5hbWUsIGVycm9yX2dldF9wcmV0dHkoZXJyKSk7DQo+ID4gICAg
ICAgZXJyb3JfZnJlZShlcnIpOw0KPiA+ICAgfSBlbHNlIHsNCj4gPiAgICAgICBlcnJvcl9yZXBv
cnQoIlVucmVjb3ZlcmFibGUgUENJZSBlcnJvciBkZXRlY3RlZCBmb3IgZGV2aWNlICVzIiwNCj4g
PiAgICAgICAgICAgICAgICAgICAgdmRldi0+dmJhc2VkZXYubmFtZSk7DQo+ID4gICB9DQo+ID4g
ICBlcnJvcl9wcmludGYoIlBsZWFzZSBjb2xsZWN0IGFueSBkYXRhIHBvc3NpYmxlIGFuZCB0aGVu
IGtpbGwgdGhlDQo+ID4gZ3Vlc3RcbiIpOw0KPiA+DQo+ID4+ICAgICAgICAgdm1fc3RvcChSVU5f
U1RBVEVfSU5URVJOQUxfRVJST1IpOw0KPiA+PiAgIH0NCj4gPj4gZGlmZiAtLWdpdCBhL2h3L3Zm
aW8vcGNpLmggYi9ody92ZmlvL3BjaS5oDQo+ID4+IGluZGV4IGM5YWI5NDk4NzAuLmMwNjdiYmJl
YmMgMTAwNjQ0DQo+ID4+IC0tLSBhL2h3L3ZmaW8vcGNpLmgNCj4gPj4gKysrIGIvaHcvdmZpby9w
Y2kuaA0KPiA+PiBAQCAtMTQ2LDYgKzE0Niw3IEBAIHN0cnVjdCBWRklPUENJRGV2aWNlIHsNCj4g
Pj4gICAgICAgRXZlbnROb3RpZmllciBlcnJfbm90aWZpZXI7DQo+ID4+ICAgICAgIEV2ZW50Tm90
aWZpZXIgcmVxX25vdGlmaWVyOw0KPiA+PiAgICAgICBpbnQgKCpyZXNldGZuKShzdHJ1Y3QgVkZJ
T1BDSURldmljZSAqKTsNCj4gPj4gKyAgICBib29sICgqZXJyX2hhbmRsZXIpKHN0cnVjdCBWRklP
UENJRGV2aWNlICosIEVycm9yICoqKTsNCj4gPg0KPiA+IFBsZWFzZSBhZGQgZG9jdW1lbnRhdGlv
biwgc29tZXRoaW5nIGxpa2UgOg0KPiA+DQo+ID4gICAvKg0KPiA+ICAgICogUGxhdGZvcm0tc3Bl
Y2lmaWMgZXJyb3IgcmVjb3ZlcnkgaGFuZGxlci4NCj4gPiAgICAqDQo+ID4gICAgKiBDYWxsZWQg
d2hlbiB0aGUgaG9zdCByZXBvcnRzIGEgUENJIGVycm9yIHZpYSB0aGUgVkZJTyBlcnJvcg0KPiA+
IG5vdGlmaWVyLg0KPiA+ICAgICogVGhlIGhhbmRsZXIgc2hvdWxkIGF0dGVtcHQgdG8gcmVjb3Zl
ciB0aGUgZGV2aWNlIGFuZCBmb3J3YXJkIHRoZQ0KPiA+ICAgICogZXJyb3IgdG8gdGhlIGd1ZXN0
IGlmIHRoZSBwbGF0Zm9ybSBzdXBwb3J0cyBpdC4NCj4gPiAgICAqDQo+ID4gICAgKiBAdmRldjog
dGhlIFZGSU8gUENJIGRldmljZSB0aGF0IHRyaWdnZXJlZCB0aGUgZXJyb3INCj4gPiAgICAqIEBl
cnJwOiBzZXQgd2l0aCB0aGUgZmFpbHVyZSByZWFzb24gb24gZmFsc2UgcmV0dXJuDQo+ID4gICAg
Kg0KPiA+ICAgICogUmV0dXJuIHRydWUgb24gc3VjY2VzcywgdGhlIFZNIGNvbnRpbnVlcyBydW5u
aW5nLg0KPiA+ICAgICogUmV0dXJuIGZhbHNlIG9uIGZhaWx1cmUgYW5kIHNldCBAZXJycCwgdGhl
IFZNIHdpbGwgYmUgc3RvcHBlZC4NCj4gPiAgICAqLw0KPiA+ICAgYm9vbCAoKmVycl9oYW5kbGVy
KShzdHJ1Y3QgVkZJT1BDSURldmljZSAqdmRldiwgRXJyb3IgKiplcnJwKTsNCj4gPg0KPiBZdXAs
IEkgY2FuIGFkZCB0aGF0Lg0KPiANCj4gDQo+ID4NCj4gPiBUaGF0IHNhaWQsIEknZCBwcmVmZXIg
dG8gc2VlIEFFUiBmb3J3YXJkaW5nIGZpcnN0Lg0KPiANCj4gSSBhbSBjdXJpb3VzIHRvbyB0byB1
bmRlcnN0YW5kIGhvdyBBRVIgZm9yd2FyZGluZyB3aWxsIHdvcmsuIEJhc2VkIG9uDQo+IHFlbXUg
cGF0Y2hlcyAod2hpY2ggbWF5IG5vdCBiZSBjb21wbGV0ZSkgWzFdLCBJIGNhbid0IHRlbGwgaG93
IEFFUiBvciBhbg0KPiBldmVudCB3aWxsIGJlIHNlbnQgdG8gYSBndWVzdCB0byBub3RpZnkgb2Yg
YW4gZXJyb3IuIEJhc2VkIG9uIHRoZQ0KPiBkaXNjdXNzaW9uIG9uIHRoZSBsaW5rIHlvdSBwb3N0
ZWQsIGl0IGxvb2tzIGxpa2UgQVBFSS9HSEVTIGJhc2VkIGV2ZW50cw0KPiB3b3VsZCBiZSBzZW50
IHRvIHRoZSBndWVzdD8NCg0KUmlnaHQsIHRoYXQgUUVNVSBicmFuY2ggaXMgYW4gZWFybHkgcHJv
dG90eXBlIHdoaWNoIG9ubHkgb2JzZXJ2ZXMgYW5kDQpsb2dzLCBzbyB0aGUgZm9yd2FyZGluZyBp
cyBub3QgaW4gaXQuIA0KDQpJIGFtIHdvcmtpbmcgb24gYSBRRU1VIGJyYW5jaCB3aGljaCBhZGRz
IGl0LCBiYXNlZCBvbiB0aGUga2VybmVsIFJGQy4NClRoZSBwbGFuIGlzIHRvIHVzZSBuYXRpdmUg
QUVSIHJhdGhlciB0aGFuIEdIRVMsIHNvIFFFTVUgaW5qZWN0cyB3aXRoIA0KcGNpZV9hZXJfaW5q
ZWN0X2Vycm9yKCkgYW5kIGFuIGVtdWxhdGVkIHBjaWUtcm9vdC1wb3J0IHJhaXNlcyB0aGUNCmlu
dGVycnVwdCB0byB0aGUgZ3Vlc3QuIEkgd2lsbCBwb3N0IGEgbGluayBvbmNlIGl0IGlzIHJlYWR5
Lg0KDQo+IEFub3RoZXIgcXVlc3Rpb24gcmVnYXJkaW5nIEFFUiByZWNvdmVyeSBzZXJpZXMsIGRv
IHdlIG5lZWQgc29tZQ0KPiBtZWNoYW5pc20gdG8gZ2V0IHRoZSBBRVIgaW5mb3JtYXRpb24gZnJv
bSB0aGUga2VybmVsIGZvciB1c2Vyc3BhY2U/DQoNCk5vdCBhcyBpdCBzdGFuZHMuIFRoZSBmZWF0
dXJlIHJlcG9ydHMgaG93IHNldmVyZSB0aGUgZXZlbnQgd2FzIGFuZCB3aGF0DQp0aGUgaG9zdCBk
aWQsIG5vdCB3aGljaCBlcnJvciBvY2N1cnJlZCwgc28gUUVNVSBjYW5ub3QgZm9yd2FyZCB0aGUg
cmVhbA0Kc3RhdHVzIGJpdHMgdG9kYXkuIElmIGl0IGlzIHNvbWV0aGluZyB0aGF0IGlzIHVzZWZ1
bCB0aGVuIGl0IHByb2JhYmx5DQpuZWVkcyB0byBiZSBhZGRlZA0KDQpUaGFua3MsDQpTaGFtZWVy
DQo=

