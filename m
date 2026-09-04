Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFEAC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Qla-0006oc-Qs; Fri, 04 Sep 2026 06:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2QlZ-0006oN-FA; Fri, 04 Sep 2026 06:03:25 -0400
Received: from mail-northcentralusazon11010009.outbound.protection.outlook.com
 ([52.101.193.9] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x2QlX-0007YC-LI; Fri, 04 Sep 2026 06:03:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKIFiFvpM38behzsVjunBk5Wp+0vqCMX3myZaPjnRAxXMxS2EzbhCUxNx/u++NmTd4ZLktgXdyyb5ZixUNA4D+90JIxiywJzq+I5eoLBNr/rsxVNKnkQhD/w7NZrx20B0qdpMJKk5dOHrzyeu8qW4XyIjvn06oVqxtBKWhOr0mzmeu1/lPZQunRFElz1q2lgdN9W1nXmlZFBE1tULmyNaxMLN/bTdPv9fSTqhpJMgBLhVgNEcn3jQaO0I69qiOyzKpQGq1pV7foO5soiyedz4A0rGdB6VZIBUG+nfytOaZSp84M8oTs1diRMDhDpD2ObBEHa8ZLb2m+9HkidFDnJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffWvv/U/vg0BzJmpMkW7W2xdkLbX+SvnMjSpbmVRfVo=;
 b=G4TZRJO/HxF8sk8EC03paT2l8MFb+bfTYHem+TQE7UuNC8GM1U/wwraI8T87QSnKiEFCPYd85fGszV84UZOPLl7P+kQxDgaWON6YPWaIwI0S6M5RC2CHgI+U9OEOevst8xtmXMFo1eD8ih9A9tjs/zhkh6Rsv10GpUyACUzZKYlQZBlbK3Si9W9oBf/ARb9Fo2Tp3XkK2aLpsHwTe8u2P20yj3IltEHfeY+NrwvZKCv763Jf74Zb2lMcHDFzIcZYiJ8P7oHx9FDiYAHONv3p8iwOso+8Kptb/qJZEHXRap6wmP0PHcFjv9YGcFHNR/ORjY+zxlj9LrlLkJ9VIfPDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffWvv/U/vg0BzJmpMkW7W2xdkLbX+SvnMjSpbmVRfVo=;
 b=pno190tvLumCvPsw8/Jp5rvSW40RgvhKz9LHUj1JeaNVIJHpeQIfDfQGOSm7R315+K+XPcQ91jyU9H83IlWyQxJ/fLSqJG1cuaH9qi6rVn5o1UjkUlXLU/HTC87jafcXQ+mVDlAHH/Fj4COvI51D5gyuHPfv1BedTiMtK4UN9Kb1zXEUPVJw6dXXqRdDJQzBqeXokYslc+HUDMqNrSTcbFP+fMwwMrlJo+tbCo4uDSkgSeUyycaTmkTB6aL4zZVonWuLOZv5o4Q+JgIUvfoW3OMhHWpIKloy3WbMv5KhwdQIe9n6u4qeBsqgWDMLoK5u48/cAwKvjH+vnSm+roq+Sg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:58:16 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:58:15 +0000
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
Thread-Index: AQHdOXcv0gUaqc3nq0S/eQQmasGmmLa68WKAgACNiACAAUVboIAAZuAAgAEHFWA=
Date: Fri, 4 Sep 2026 09:58:15 +0000
Message-ID: <SJ0PR12MB8614FF7B22FC06B6488FA200ABB52@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
 <d32b992a-e4b2-494a-ad27-e38caaff7dc1@linux.ibm.com>
 <SJ0PR12MB8614E80E4BAB0FC192BB224BABB62@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <c761f020-4970-497d-a460-01933371cf0c@linux.ibm.com>
In-Reply-To: <c761f020-4970-497d-a460-01933371cf0c@linux.ibm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|MN0PR12MB5714:EE_
x-ms-office365-filtering-correlation-id: 14574437-f0c1-4795-7280-08df0a6b09d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|56012099006|38070700021|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: TXAGoGlWaemWF8ju5guLmO8TjzQBxaqWpW3vbCs+ROA8sd0sYY4/xTKlJPsTeY7+OpMT01EEltLVCr95aiV4mIiUwhQeMSYq4coH3ol/EZRjRpxUHL/eiDSybGewwvlz17Zbzz7FCfLKRikYmimhrglpmeXKfwwkJeOppCBeeys9eg9US51MZbzz/AZHNua8VaYVAl9SOXZeFOkEBuYY4RceS5+QSfYSlH6XMHk6ArZ8OTt6BVBQszh93mKRwRsb0D5vkHqfLOYPg6OE0RkAOBXGjnlJyk13JbHXrLOoOI9sHFjRWsE5Ku+2Lo0mzVVJ01+pUTojYmGqF2eDu5dR2GeNG4F4yylSJH07q6po2vv34KLrWW0OOyg8a7/y2etxsRl/FzVneXJlWkKfFMPQm3Jnjv4kGwpUMjXnREuQd4xM51wykv1ijmzUN2vH+zB2cG1THKQ1eGbIos0mSNl+xOm0MbDRd+HAo3SLe0DBP2TWR5a88nYwlDIDr7H7e9AeoXIGbOIu/z6kiTFQQCXz/WmZ6KyRRnIspKWEKmBSVOWnvQzlqamVE6ZTLbYvJE39bL8+gmYAf0BUAKhjDKruQKGbDtJYCMY68eA1u4r21WqLYku03bFuCCy7lsoo0bbLkcSxya1tZren/mxgShwSwJqSawpf3QtR2Pv+QkiFPMHx9H1Omg2VCtr+d7IE7O9kUlocH0hie+8N/+W+258+u4RrcTj/0rSj5w/xetVYz8g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anZCVkpNcnBQdkcrbEdFOHZEYkhSOUZLR2hBL212WEljVHdvRUpta1dib3NF?=
 =?utf-8?B?ZGtuT0d5Vld1ZW9qblY5ZHlwRjJkcTBva081R1RjUWZmSUNFdFNCVGFqaW9k?=
 =?utf-8?B?QXE0TEtLNEh6LzFTOGMxQll4NjdzbGRTTlVaVzZXV1BOcjA3dkpNaHJLMEYx?=
 =?utf-8?B?eHR5MjFuditudCtzQXYzRVJNWVp1aXNVK2tvY3dKaUVuOS9yaG9vSFBHbHJY?=
 =?utf-8?B?b1dVa2R2VlBWZkRISmZ0TDRMcEdmMnJtNFkwUU51aUk5enpMS3l3Y0ZCZVJi?=
 =?utf-8?B?S1JzUTN4a2wreGowQ2JtcmlJcVQ0OEJ1M2NudjdjYXhJcWc2U1J4cjRkUytw?=
 =?utf-8?B?REE4QjB3OFYwQjFMOG1FK3UxRWtrclhaTU1yN24rYm1jREtiQ0NSK3M3TE44?=
 =?utf-8?B?c2pkOTg5WVFORHNzUzVYMDR2MEM3WGhGMDdmUWYyRlVzOFl3QjBuM1luTytz?=
 =?utf-8?B?VTVnMzVYcVBvUURwWXRUb1pxK2hMMUNPWHJOeXFRTUVHVUxPWlN1M3NDN3Nk?=
 =?utf-8?B?Rk5uZGVIUkMzVm9KR1dISVdWSmoxMTdtR2pROEhqQTBTdXdOMXVTNGFNdDda?=
 =?utf-8?B?Vk1iYzg5a0ZpbFl5Tm9vMElSNDJPeUEyYWJoMXJPTGY5a3c2NFdwc1M4cGVG?=
 =?utf-8?B?N3R5SWVXcEJpMjMxZWFBYUcwTkV4U3BkcDR5NDhuem5CWEkwcGV2TGp1WEhB?=
 =?utf-8?B?RS9YcXhSeVcwdGZQVGZBRlRxd284UWZqaDhKZGxMa3RQMi9xZXgzd2lPMk1E?=
 =?utf-8?B?L2lxMThHVDJNdDhNT0M4WlVjbFpFa0hCNmNxTnlCUStORXVMMk8rQ3YzaXpF?=
 =?utf-8?B?NjcyR0NDV2JsZW92K1N4M3J4bndBOFlKN0hwSWpSeENES2NXWnRWanB4dzNE?=
 =?utf-8?B?RFI4cFBFcVo0R0VZclZKektsMkduNHZHV0lHQ1pPcW44U2VRQkhBbmFickYw?=
 =?utf-8?B?MmlPcU1LYlRSQ2lGOGpVQVJHeS9NcjdiY2k5d3VaZHZjTkxReFlzVXIrMEtX?=
 =?utf-8?B?Wk1VWm9XWnZVVXRNMS9BZ0lFb1lRaWsvM3Q1L250OEliRndWUE1heUZpcFd2?=
 =?utf-8?B?dDk0QnY3UDlVRkJua3FJOCtHWEVDTzFIWjlneGYzaHBQOWlmOFFyNWlaKzhT?=
 =?utf-8?B?NzBTanhvaXQvQW5rTis4ckJFNkM5TklEMUZPUUc1RjZwYzd1M1gvaXBJMUIy?=
 =?utf-8?B?clJMSzI0Z3JUQ2VKaEVDMnFuOEFOdXRldllvNU4raHpKczdFblYrcGlpNXFv?=
 =?utf-8?B?N051KzZ4Y20wY3pTVGwzWnVuQUFZSXZIaWszYTJOZnY0ZjZ6SHAzYXc5elpY?=
 =?utf-8?B?Z3JzT0dDc1VjNVQ1SmliY1hOR0k5N0Q1UmFDTWlKZUFRdXZEVjEzdGpXTXBS?=
 =?utf-8?B?TkQ4M0NpLzFiY1UvcEk1YWVUSkdEQ1ZiWmo3bmRQUWZQd3M3YkcwOVdiYjdR?=
 =?utf-8?B?cUhUWWduQmlEU1d6QTBnRUpUOWhXcmg2MVlTaFpQMmVOQm9zdCtxdzBhcFYr?=
 =?utf-8?B?TmRYRVg3ajd5U0o3ZmYweUtEeDV0T2tRZWxhaG9wMGViWjZFanNzNUNmUnBJ?=
 =?utf-8?B?RkkydFV2SDN3ZldkdDhySmpYQ2tEOS9FZlAwMlZ0SXJwZlFnWXpETE43RGZn?=
 =?utf-8?B?ZTVKOFlOSENjZEFZK0RWYVlLVUNKLy9aT1A3KzIxS1BnM2lic3QwUEVnajRU?=
 =?utf-8?B?QWxvTXVVa3c2ZStKalkzRUVJaElveGlRallRbVlxMTZob1J0QzQ5bE5yZVY4?=
 =?utf-8?B?L0RFTmV5RFlkczRoc3NMdXozS2hCcmE0STBDVXVmdkpFMCtyK0Q4S245YlpG?=
 =?utf-8?B?SUkvTFhKd3IyT1F3SlNMVlRrb1g3TVNCR0tNb0ltcGJpN3RNOG9OYTFTdTIx?=
 =?utf-8?B?cnl0Q2M3eldINmRhV2NJaFNVeklOZnBiTXBXbW13SE40YVkwQ3A3QVViNUdW?=
 =?utf-8?B?WmFQbktuYWhOcmx5elp3NTF4MGgvYisxcys5a0NUYU93MXdUTVdKYnNLRHQ3?=
 =?utf-8?B?TXo5eDVqWkJNYWVRRWl1VkNtZk5pYzNOT3psM3BkdktYU2g4VEIrbGptRnZk?=
 =?utf-8?B?UFlvQ3hTN3IwT0hITUFoSCtkbHFRbHZTdEZzbGdrbFYyVE1QMmQzWkRrQzl0?=
 =?utf-8?B?UkJ1L1krb2QvZmJ2VUtVR2t0OTBHNWVnOUFsSERYRHE0YVRLZFFGWnQwV2di?=
 =?utf-8?B?OXdHMHFPdUdWR1FEUVh0UWs4TWlDZVY2L25wZmN4eDJvL0M4blExUFY3U2I3?=
 =?utf-8?B?aUZ0RkFrSzNxbGtZMU12WHMzOXBXMEV2bktSbXZUWGc3VlZKSVdwaEFMT25F?=
 =?utf-8?B?Z1RCQTFlaldpVFE5S0toN2tORjNTV295UG1OTlFBMzY5dFl4YUpvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14574437-f0c1-4795-7280-08df0a6b09d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 09:58:15.2005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz2UvQby5ddnmk5AxVd+f2tWmifqgh7rVCt+8lAJq65wHPXh0+mZo445+4YONfpSr5s7UwYzhaYynrxAN14Ecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
Received-SPF: permerror client-ip=52.101.193.9;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRmFyaGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhcmhh
biBBbGkgPGFsaWZtQGxpbnV4LmlibS5jb20+DQo+IFNlbnQ6IDAzIFNlcHRlbWJlciAyMDI2IDE5
OjA3DQo+IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNv
bT47IEPDqWRyaWMgTGUgR29hdGVyDQo+IDxjbGdAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgcWVtdS1zMzkweEBub25nbnUub3JnDQo+IENjOiBtanJvc2F0b0BsaW51eC5pYm0u
Y29tOyBmYXJtYW5AbGludXguaWJtLmNvbTsgY29odWNrQHJlZGhhdC5jb207DQo+IGFsZXhAc2hh
emJvdC5vcmc7IGFybWJydUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi80
XSB2ZmlvL3BjaTogQWRkIGFuIGVycm9yIGhhbmRsZXIgY2FsbGJhY2sNCj4gDQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gSGkgU2hhbWVlciwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXNwb25zZSENCj4gDQo+IE9u
IDkvMy8yMDI2IDU6MDggQU0sIFNoYW1lZXIgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4+PiBU
aGF0IHNhaWQsIEknZCBwcmVmZXIgdG8gc2VlIEFFUiBmb3J3YXJkaW5nIGZpcnN0Lg0KPiA+PiBJ
IGFtIGN1cmlvdXMgdG9vIHRvIHVuZGVyc3RhbmQgaG93IEFFUiBmb3J3YXJkaW5nIHdpbGwgd29y
ay4gQmFzZWQgb24NCj4gPj4gcWVtdSBwYXRjaGVzICh3aGljaCBtYXkgbm90IGJlIGNvbXBsZXRl
KSBbMV0sIEkgY2FuJ3QgdGVsbCBob3cgQUVSIG9yDQo+ID4+IGFuIGV2ZW50IHdpbGwgYmUgc2Vu
dCB0byBhIGd1ZXN0IHRvIG5vdGlmeSBvZiBhbiBlcnJvci4gQmFzZWQgb24gdGhlDQo+ID4+IGRp
c2N1c3Npb24gb24gdGhlIGxpbmsgeW91IHBvc3RlZCwgaXQgbG9va3MgbGlrZSBBUEVJL0dIRVMg
YmFzZWQNCj4gPj4gZXZlbnRzIHdvdWxkIGJlIHNlbnQgdG8gdGhlIGd1ZXN0Pw0KPiA+IFJpZ2h0
LCB0aGF0IFFFTVUgYnJhbmNoIGlzIGFuIGVhcmx5IHByb3RvdHlwZSB3aGljaCBvbmx5IG9ic2Vy
dmVzIGFuZA0KPiA+IGxvZ3MsIHNvIHRoZSBmb3J3YXJkaW5nIGlzIG5vdCBpbiBpdC4NCj4gPg0K
PiA+IEkgYW0gd29ya2luZyBvbiBhIFFFTVUgYnJhbmNoIHdoaWNoIGFkZHMgaXQsIGJhc2VkIG9u
IHRoZSBrZXJuZWwgUkZDLg0KPiA+IFRoZSBwbGFuIGlzIHRvIHVzZSBuYXRpdmUgQUVSIHJhdGhl
ciB0aGFuIEdIRVMsIHNvIFFFTVUgaW5qZWN0cyB3aXRoDQo+ID4gcGNpZV9hZXJfaW5qZWN0X2Vy
cm9yKCkgYW5kIGFuIGVtdWxhdGVkIHBjaWUtcm9vdC1wb3J0IHJhaXNlcyB0aGUNCj4gPiBpbnRl
cnJ1cHQgdG8gdGhlIGd1ZXN0LiBJIHdpbGwgcG9zdCBhIGxpbmsgb25jZSBpdCBpcyByZWFkeS4N
Cj4gDQo+IEkgYW0gdmVyeSBjdXJpb3VzIHRvIGtub3cgKGFuZCBsZWFybikgaG93IHdlIHdvdWxk
IGRvIHRoaXMuDQoNCkkgaGF2ZSBhIGJyYW5jaCB0aGF0IGRvZXMgdGhlIEFFUiBlcnJvciBpbmpl
Y3Rpb24gaW50byB0aGUgZ3Vlc3QgaGVyZToNCmh0dHBzOi8vZ2l0aHViLmNvbS9zaGFtaWFsaTIw
MDgvcWVtdS1tYXN0ZXIvY29tbWl0cy9wcml2YXRlLW1hc3Rlci12ZmlvLWFlci10ZXN0LXYyLw0K
DQpOb3RlOiBUaGlzIGlzIG9ubHkgZm9yIFJGQyB0ZXN0IHB1cnBvc2VzLg0KDQo+IA0KPiANCj4g
Pj4gQW5vdGhlciBxdWVzdGlvbiByZWdhcmRpbmcgQUVSIHJlY292ZXJ5IHNlcmllcywgZG8gd2Ug
bmVlZCBzb21lDQo+ID4+IG1lY2hhbmlzbSB0byBnZXQgdGhlIEFFUiBpbmZvcm1hdGlvbiBmcm9t
IHRoZSBrZXJuZWwgZm9yIHVzZXJzcGFjZT8NCj4gPiBOb3QgYXMgaXQgc3RhbmRzLiBUaGUgZmVh
dHVyZSByZXBvcnRzIGhvdyBzZXZlcmUgdGhlIGV2ZW50IHdhcyBhbmQNCj4gPiB3aGF0IHRoZSBo
b3N0IGRpZCwgbm90IHdoaWNoIGVycm9yIG9jY3VycmVkLCBzbyBRRU1VIGNhbm5vdCBmb3J3YXJk
DQo+ID4gdGhlIHJlYWwgc3RhdHVzIGJpdHMgdG9kYXkuIElmIGl0IGlzIHNvbWV0aGluZyB0aGF0
IGlzIHVzZWZ1bCB0aGVuIGl0DQo+ID4gcHJvYmFibHkgbmVlZHMgdG8gYmUgYWRkZWQNCj4gDQo+
IElNSE8gSSB0aGluayB0aGVyZSBtaWdodCBiZSB2YWx1ZSBpbiBwcm92aWRpbmcgbW9yZSBkZXRh
aWxlZCBpbmZvcm1hdGlvbiB0bw0KPiB0aGUgUUVNVS9ndWVzdC4NCg0KT2suIEkgd2lsbCBoYXZl
IGEgbG9vayBhbmQgc2VlIGhvdyB3ZSBjYW4gcHJvcGFnYXRlIHRoYXQgaW50byB1c2Vyc3BhY2Uu
DQoNCj4gDQo+IEJhc2VkIG9uIG15IGJyaWVmIGxvb2sgYXQgdGhlIGtlcm5lbC9RRU1VIHBhdGNo
IHNlcmllcywgaXQgbG9va3MgbGlrZSB0aGVyZSBpcw0KPiBub3QgbXVjaCBjb29yZGluYXRpb24g
YmV0d2VlbiB0aGUgZ3Vlc3QgYW5kIGhvc3QgcmVjb3ZlcnkuIFNvIHdoZW4gd2UNCj4gaW5qZWN0
IGFuIEFFUiBpbiB0aGUgZ3Vlc3QsIGlzIHRoZSBkZXZpY2UgYWNjZXNzIHN0aWxsIGJsb2NrZWQ/
DQo+IElzIHRoZSBkZXZpY2UgYWNjZXNzIGVuYWJsZWQgb25seSBhZnRlciBhIGd1ZXN0IGNvbXBs
ZXRlZCB0aGUgcmVjb3Zlcnk/DQoNCkFjY2VzcyBpcyBhbHJlYWR5IHVuYmxvY2tlZCB3aGVuIHRo
ZSBndWVzdCBzZWVzIHRoZSBlcnJvci4gUUVNVSBpbmplY3RzDQp0aGUgZXJyb3Igb25seSBhZnRl
ciBob3N0IHJlY292ZXJ5IGhhcyBmaW5pc2hlZCwgc28gdGhlIGd1ZXN0IGRyaXZlciBydW5zDQph
Z2FpbnN0IGEgZGV2aWNlIGl0IGNhbiByZWFkLg0KDQpZb3UgYXJlIHJpZ2h0IHRoYXQgdGhlcmUg
aXMgbm8gY29vcmRpbmF0aW9uIGJldHdlZW4gZ3Vlc3QgYW5kIGhvc3QgYW5kIHRoYXQNCmlzIGRl
bGliZXJhdGUuIFBsZWFzZSBzZWUgQWxleCdzIHJlcGx5IGhlcmUgb24gd2hpY2ggdGhlIFJGQyBk
ZXNpZ24gaXMgYmFzZWQ6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NjA3MDcxNjEyMzQuMjNlZDI4ZGJAbnZpZGlhLmNvbS8NCg0KVGhlIGNvc3QgaXMgdGhhdCB0aGUg
Z3Vlc3Qgb25seSByZWNvdmVycyBvbmNlIHRoZSBob3N0IGhhcyBmaW5pc2hlZCwgYW5kDQpjYW5u
b3QgaW5mbHVlbmNlIHdoYXQgdGhlIGhvc3QgZG9lcy4gSWYgdGhlIGd1ZXN0IGRyaXZlciB3YW50
cyBhIHJlc2V0DQppdCB3aWxsIGRvIG9uZSwgb24gYSBkZXZpY2UgdGhlIGhvc3QgaGFzIGFscmVh
ZHkgcmVzZXQuDQoNClRoYW5rcywNClNoYW1lZXINCg==

