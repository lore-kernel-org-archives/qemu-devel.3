Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EBDC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI0-0008A2-D7; Tue, 21 May 2024 09:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0007iC-Rm
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHP-0001a9-MQ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297107; x=1747833107;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CKam7zb8e546M/TrGYyCxbXf0VqOaiRtn7XcC+gjZ+8=;
 b=EzrNN85aeRGupVcuLLnKfvyeaj0oQLeU70WJ5cnuUzD7chRfnwQRFrA4
 ywSGWpiiIM5nvp2dKsKPR+F3hzjQFND70u1o8GxVViST4XW19ynpBCpOB
 Cc4jYO9/XGv9poxBZxYdDNHDiaSFO4fameqewJAWGycq0fboJboTSc2E3
 aALhp3vaAkUmI4I40s6iCJ4O+9Oltu4JaGSnHj1hWjsNWEAfiJxdzvemM
 mNCTGat9uTTpoRcBfvujhDbqLLokX/Hnk0mq0v4wDM75RzcTw7srRyHvv
 BT6C/vbjk/VRFbTFGgS37HLnY82SCi4nVG9D50pOdCe/HddKpc2I9BvMd g==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13011524"
X-MGA-submission: =?us-ascii?q?MDELFSXt+lGXbIMvEN48Gstb8L213TGh6Coiko?=
 =?us-ascii?q?J5zmPAbRet9PT+6o23E+sIy9Q1/zmYQrksGWHw8/CzOkMsSEaATDNskn?=
 =?us-ascii?q?m2wpE8IxsUKnAZlgHZ/JU2gzLAjT2Z/iMHNgF+Uu7xoaBZEFTmGE0BgF?=
 =?us-ascii?q?35XnxV6NUnwYuTkiPcaX7FDQ=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:44 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDGyB2jmbBR0ouRLgSESkwTx5HXL04ZtS1xfrGLmZM4hXSLOdSSXaVnasQ+5d2hMzrzVph71eiCkZJfJwJ37Kfv4vUV9OYPeNiyvPfccoify2cjqvj4x0/Q8jgdEat48BxXN4u/63A0lSJwN7Q6QQiY8rcc9leXJCPbKqjB/7uWgI0eUaNQZtXjA0WOaima9GdSzfM4Tb1KP+FXYAffCyAtDGgerLWnwZCOa57YDdoDguPxBwHhzxbPgNi/1eCHFGrSX6Cb0ZQ9sddvStheuuglFsrXKq4NUrAaLgHdKemmiENupRItY2NzUH0idgWOvwz1V1shWw61vHbDnybJzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKam7zb8e546M/TrGYyCxbXf0VqOaiRtn7XcC+gjZ+8=;
 b=noXeSnSmDI4zd8ymeN07HdRPFqbLhdaXC6sbgB9PxHGz/89PdBr7hDQpyKWsFNUAgEbKzaHxEWS0FsFS0f1DUhuWMxN3OUGeCZfdLj//wzObikui6MdRQdcSJ6Nf3z4iD8eAI2xFfnsG29WB+epFc5GbE1nFF/7PUY4+FUTLQXlc4SueyHuCRzj4FJ66jswni8YyONiHOynChTA6ASkpcnoLnc6bJoZ0mINhMi+MWtQf28pImQ/Bj5uGalZE0EekKSCZ9He4pHBUJ8/SCfOYIsvbxcXfYlqNYwNE0DXEPO+KqqHjZDU4IMiIBKuhHiJpGKhkEWmHsQhY0Qk5/gKw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 09/22] pci: cache the bus mastering status in the
 device
Thread-Topic: [PATCH ats_vtd 09/22] pci: cache the bus mastering status in the
 device
Thread-Index: AQHaq4BtCDCpPNoyckSYkgx7CPioGA==
Date: Tue, 21 May 2024 13:11:43 +0000
Message-ID: <20240521130946.117849-10-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: e15cc6da-fcda-428e-acfb-08dc79978fa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Nm1EQW1WNlZmVWRRVys1NnF2TVBON29PSnZvdlZTdFJwK0NZY0gva2xycnRR?=
 =?utf-8?B?emlIc2IxQk1OQnU5TFVRZGZMd0tsVyt1L3EvTTk4Q0NVY2s1QTdFNUVUb3dy?=
 =?utf-8?B?ZTBJL3lsVVRqSjhpZFZtdk9vQm1KYVNBNkN4d1BpN20wNzdqbElEQS90MHFY?=
 =?utf-8?B?eE1naERjL3dxZU1GYm5Zb0w3TGpWdSs2enIvaXVobFRCM3JCOC81cS9BTVZm?=
 =?utf-8?B?SjhUSW4xaGxCdmhhNGtaTlhvOTlkTGU4ckF3WmtFUEJZZlY2YjdXRFk0KzVi?=
 =?utf-8?B?NnErbVJWZzBLclF2dXNUaEk2bS9kWUZ5aU5yTG5Va2YxVFM2N0NwZjBZZ3Zz?=
 =?utf-8?B?QlJ2QXdtMUY2VlJmSkNWV1NUSmxCN2ZYVW5hT1Jnd0VuajZVSFdZazdVbzlH?=
 =?utf-8?B?QTlidnAwMTZOeFhKUHA5L2xyZHJFQlNNQ1hXdWFOWnFnWjhNSjBRMkFET1o5?=
 =?utf-8?B?T3JBT1N4K2JZL2dQcTRrbm1Lck9FZjFqSnA1dzRsYmxUVGNBQXhwUng1YTgw?=
 =?utf-8?B?L2EyUUJIczE2MG4ySEpUSHJuUndwcTFHbDV4dzZOZm9NYkNvSkJVcGlVcW5l?=
 =?utf-8?B?c0d5UTAwVmszMTJjTDMyRnBRL2tKZURwZExrWHdGd003a1RjYlN4TC9TK1Jy?=
 =?utf-8?B?WG1XVHdKdVEwb1N5NHJ6bnBBbW5yMFdOcStmaXRCMjZ4eUQ5ZEFlcnZ0Qmo2?=
 =?utf-8?B?WENMRkJEbk8vZVlhTDRMTkVabDU2aXZVc2txNjd5Z1hUbVhlTGFydlpaOGds?=
 =?utf-8?B?UkdaaURwNEtTb3FjUGpaeFBGRmFYZ1NYckVOZG5jVE4ydkV1ZkZuaFJEVW5Q?=
 =?utf-8?B?UHRBaGxzQzRVUXZCcUJKdWpuVEsySDgrQTRKREpyZVN5TzJiM0xTWFpLcmJj?=
 =?utf-8?B?KytjdFgySkhhOEpDWnJaMFZkUUZFVjRjdWE5Y2tjV0R5SGhFazNlcXlsZUhs?=
 =?utf-8?B?ZTFXcGpIWk1tREdOWXNiNkpDVmJtLzYrdE9ZMFhxcFlyTFdyQ2FvRFBwbEUw?=
 =?utf-8?B?UFYvYy82ZmZrb1FYa2ZOZWUxbjl2RUM1REwxNmNUb3RrazVZcFBZUEp5ZFJC?=
 =?utf-8?B?b1FKWEEvSGkrNWRZalNHRE9tc2kyaHRMbXJOazNObVFqU1RON1oxYUZMU1F5?=
 =?utf-8?B?VVhEbEJ4TS9MZWFXNmt4b2lvaGpvSmFkVzZjN2N6d1ZnWkZPKzMwZGEzdGxx?=
 =?utf-8?B?eHZDNWg5aG1DRmdlUmlMRk1ERkRsZnB0YlhTUkphcjUrZ25LS21BN2RmR1la?=
 =?utf-8?B?ZjMwcEhqY3o0WWpSUHNVZmc5ck80bGpkaTVVN3g5UVZON0xiWVNyNDF5clFv?=
 =?utf-8?B?V0lJdmZ0dk5ZL3kySWRQQmlaU1ZQVFd6OUgwR0U1a2pRVTY2ZjVoaVM3R2FE?=
 =?utf-8?B?dnAyQ21sa0ZlT0llaTZOL1lYU0cwZlJBV0VWME5OUkMvSENFczdZd3l2SEpP?=
 =?utf-8?B?aDVuYW5IbjlvellZM2VXdWFJSHk3UmVrTWc5V2h0VmM4ckRBU0tFVUFkaTg2?=
 =?utf-8?B?a1N1N2FlMUpiQmVUOThoWEFCRHpya3JuQ0h3Z3hoclNyUmFzLzBVVlhkSjZt?=
 =?utf-8?B?c2QzdFFjUkp0MzlDUVU3RC9DcVdKT0R1anNPS092TkxUdElhYk1lUm1Eem5p?=
 =?utf-8?B?ZFVlOHpER1pHYWdtZjJzSk5abTVydFBtaS9VSXdZdEt5OVRuR0FuU0FpaXJh?=
 =?utf-8?B?eWRUaEM5ZjU4WWc1OGpRV1ROWjloYWpNYjAxWGs1WVhlRE1OREJobE5WaXYx?=
 =?utf-8?B?SlNoTGtQMXhSUnQ1eXJFZ21sbHdJWWF4TGxtQUpWQzBXTDIxWmNUZ1BlUTdp?=
 =?utf-8?B?SGxoaGxTc2dZMzdNQ1lMZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJRUE5rbDV4cHE0VDhzMnpQNkx1SjF1TjRJY0hsWjlDTnVUZkhQQTVWYWVh?=
 =?utf-8?B?aXNDK3Qwd3RKMStkYjYvQ3QxemFKV3pvL3JwRUJ5dUlsYS84RExoVE9pbTNQ?=
 =?utf-8?B?U0xQQ0t5N0svdmFHZnBFbXhteWl4UnBkeDVFdTZ2cXZkLzVZMzhiN2NzUm9O?=
 =?utf-8?B?SHBreDgxWmtEOGtNaE50aFdCak1oc1RMV0h6NDIxdXNVQjluTWVZVDdzY0hZ?=
 =?utf-8?B?d05mbHN1ZWZrZ2NSNGRhK3Y2dXQxSnRkem9yV2VpQVNzdUs3QVc4MVRqN3lK?=
 =?utf-8?B?aGtGNHE1TkVLdXdLNURXaDFQYjR0c2RnVU8ybDN4QzVsYWM0WkRmTWdQaXlt?=
 =?utf-8?B?Vnk3VGl3RTFXQ0hNc29TWUFHWDJBSTRlMUFWZDV3TFN3MUNybG92bWMremw5?=
 =?utf-8?B?aGN6eGlGWEh0RVhoR2tJQzlaU08yMkdjOTczeTRicEdRaytNb2lJQnBCMzE2?=
 =?utf-8?B?KzJuMXcrVE12L1NNRTQvQTlGWXE0YWd4eE1ablFIT1VUUExKWmhUVFpLb2Vm?=
 =?utf-8?B?ZUVydGV2NjNBb250OFhwV292a2p6YTFYYkI5Y1AxZFNiZ3VUekpHcUNxak9r?=
 =?utf-8?B?RGNmWXJZNjVTQStjaXgwRFpvaE13Qjh1OEM0ZUREZitSbWFObXhlVURwRjRC?=
 =?utf-8?B?RUNZc3Rhamw0L2cyYW95OWlTM0NDNXNVcnE4dGw2Q3RwWEsxcGMvVDh5RnVN?=
 =?utf-8?B?RlhWOUxzUG1hWnlIa1kxNE5GcmdYa1UxejlRaGQxQ0xzRC9aRFl0V0lPVW42?=
 =?utf-8?B?OEtKbTJMKys2RmpKak5qdVN1VU9qTlJka25GaEhiNXI5QlByV0RsQ3lrOTZ3?=
 =?utf-8?B?SzBYZkFCc3FFRDdqdFo1UXgxMldQWjJ0YmNIZ3RLa09JWHVnWGUxYzlibEFi?=
 =?utf-8?B?a1lwaDhUZ3BUdGJNdW01cmdQaWIxRGp4QzJJUnIyVmtsQmNkZVpHcWZMbW9W?=
 =?utf-8?B?OUw1anIwU1JDNENYYlhaeGxsUXFhQ0FmYXQwOHhnZjNSOElSTElGeU05V294?=
 =?utf-8?B?UHZnVWcxbTRSTGpiSVJndUFBcmpRdENZVDZ4ZEFndkc5SHQ1K1Z1aDZhb0F6?=
 =?utf-8?B?NWpkV01TcVU2RU4zSmJ5L3BmbGh0T0REYWY2RkpUeFp0dWxQYkRTay9NU0dZ?=
 =?utf-8?B?V2J1THVoQ1RrNndVVHRYaHRURWRkTjQ3Z3hNdG5McnBUeXZvbTkvK2RkeW5B?=
 =?utf-8?B?cG8xcnFTM0ViUE55dXp6V1JGV1JzRHpJdU9WK0lyRDkxVWVJTlJHaTVQOGh4?=
 =?utf-8?B?UEJIMi9nMEZjaS9wRVI2cGozMkpkVUNRdm1lQzhFQ2VvKzZkeVh0NEs5Q21G?=
 =?utf-8?B?UWo5TnJOL2cyckJhWFB1ZzJveHlCNllqamJWQU1GdmlzSmtmYkx4dVk2dnJk?=
 =?utf-8?B?cjJ0Q21SVVhSTDV2d1llRktDZEJNMkNEZjl4b2tRaW5oZ2E4Q05oYk44azBs?=
 =?utf-8?B?OGN6STgyOHFFYkZnWlRubUMvSkN4Z2hpd1pTNHpJLzVBVXUxS1VETnFKekls?=
 =?utf-8?B?OTAzTXkyNHVvc2tEcitURGQ4dnpJWGk5a2IzTUpKQWczbXJZOHRrcTBBTVBF?=
 =?utf-8?B?a2FwV0N2WVFoVE45VXNRcm1vRTVhMW41OXNpWkE4RDdUaTJmcEVHZWwyRml4?=
 =?utf-8?B?Q29mUU1FamtyWXZWbDZQRVROZno0d0lONEllbW04L3I5N3dPc0tFRW5mWTVo?=
 =?utf-8?B?bnVDL3pPQkpzcUx2VVpueElWL2ZLbGRTUm85Mk84NmVJbFRZRE1mU3UrWStz?=
 =?utf-8?B?S08zM2ZLeVhkT2pMZEF1MldTTVhPRzlKMjhDOFpsTnZGd0VJb3dnVExiSzl4?=
 =?utf-8?B?TVAvUDVianpxQmhsSnpxazJlMnRsMzg2VlhqV01iT01BV00rTGdVQlFvTW9N?=
 =?utf-8?B?bU5uc1FUN1Nxdy8rMDlaL2tjTmxYME8xbm1CeXVnSHRPM3MzdDZ3bUFjWS9E?=
 =?utf-8?B?OU1FSWppRmllcGdpOW5WSElBWnZ6VUluWWxvUDVmMmM0WmMxUmpOTjByTW9I?=
 =?utf-8?B?Mm9wMmNwZzFsMG1HUlpBQ1FDT0licFlkWDRhQjUwYzFldUtzK0M5OWhPcTBm?=
 =?utf-8?B?K2V3M2ZoUDZQL3Bob0RvcXh0eXZMbkJBQlNZbE5teTAzRWpxL1JEVTAza2FE?=
 =?utf-8?B?SllLNlhVQkdHN0oySjQ2c2hRdzZDd0k4Zmw0bXl0Y3FpakxETzRqZE9RZFE0?=
 =?utf-8?Q?3dMYzBerh1A44USs1G7gn6c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7561F19B2814E945AC1BC4EE055D1EA6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15cc6da-fcda-428e-acfb-08dc79978fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:43.6658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pa5f9pQXLZzOmnYmtjZ1hHolt0tGDHz303oxSHNYbeQcEG+OqW+aJRsgU2cTp9Jwds008HYqbUSQxvfPUMkjov0OXX9s4pWANMtVq2qV00DFckNRlMftMAXLA0y/GIRj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAgfCAyNCAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0NCiBpbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmggfCAg
MSArDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggYzhhOGFh
YjMwNi4uNTFmZWVkZTNjZiAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNp
L3BjaS5jDQpAQCAtMTE2LDYgKzExNiwxMiBAQCBzdGF0aWMgR1NlcXVlbmNlICpwY2lfYWNwaV9p
bmRleF9saXN0KHZvaWQpDQogICAgIHJldHVybiB1c2VkX2FjcGlfaW5kZXhfbGlzdDsNCiB9DQog
DQorc3RhdGljIHZvaWQgcGNpX3NldF9tYXN0ZXIoUENJRGV2aWNlICpkLCBib29sIGVuYWJsZSkN
Cit7DQorICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxl
X3JlZ2lvbiwgZW5hYmxlKTsNCisgICAgZC0+aXNfbWFzdGVyID0gZW5hYmxlOyAvKiBjYWNoZSB0
aGUgc3RhdHVzICovDQorfQ0KKw0KIHN0YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJ
RGV2aWNlICpwY2lfZGV2KQ0KIHsNCiAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSBwY2lfZGV2
aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGNpX2Rldik7DQpAQCAtMTIzLDcgKzEyOSw3IEBAIHN0
YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJRGV2aWNlICpwY2lfZGV2KQ0KICAgICBt
ZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lv
biwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChwY2lfZGV2KSwgImJ1cyBt
YXN0ZXIiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FzLT5yb290LCAwLCBt
ZW1vcnlfcmVnaW9uX3NpemUoZG1hX2FzLT5yb290KSk7DQotICAgIG1lbW9yeV9yZWdpb25fc2V0
X2VuYWJsZWQoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwgZmFsc2UpOw0KKyAg
ICBwY2lfc2V0X21hc3RlcihwY2lfZGV2LCBmYWxzZSk7DQogICAgIG1lbW9yeV9yZWdpb25fYWRk
X3N1YnJlZ2lvbigmcGNpX2Rldi0+YnVzX21hc3Rlcl9jb250YWluZXJfcmVnaW9uLCAwLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxl
X3JlZ2lvbik7DQogfQ0KQEAgLTY1Nyw5ICs2NjMsOCBAQCBzdGF0aWMgaW50IGdldF9wY2lfY29u
ZmlnX2RldmljZShRRU1VRmlsZSAqZiwgdm9pZCAqcHYsIHNpemVfdCBzaXplLA0KICAgICAgICAg
cGNpX2JyaWRnZV91cGRhdGVfbWFwcGluZ3MoUENJX0JSSURHRShzKSk7DQogICAgIH0NCiANCi0g
ICAgbWVtb3J5X3JlZ2lvbl9zZXRfZW5hYmxlZCgmcy0+YnVzX21hc3Rlcl9lbmFibGVfcmVnaW9u
LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaV9nZXRfd29yZChzLT5jb25maWcg
KyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9DT01N
QU5EX01BU1RFUik7DQorICAgIHBjaV9zZXRfbWFzdGVyKHMsDQorICAgICAgICAgICAgICAgICAg
IHBjaV9nZXRfd29yZChzLT5jb25maWcgKyBQQ0lfQ09NTUFORCkgJiBQQ0lfQ09NTUFORF9NQVNU
RVIpOw0KIA0KICAgICBnX2ZyZWUoY29uZmlnKTsNCiAgICAgcmV0dXJuIDA7DQpAQCAtMTYxMSw5
ICsxNjE2LDkgQEAgdm9pZCBwY2lfZGVmYXVsdF93cml0ZV9jb25maWcoUENJRGV2aWNlICpkLCB1
aW50MzJfdCBhZGRyLCB1aW50MzJfdCB2YWxfaW4sIGludA0KIA0KICAgICBpZiAocmFuZ2VzX292
ZXJsYXAoYWRkciwgbCwgUENJX0NPTU1BTkQsIDIpKSB7DQogICAgICAgICBwY2lfdXBkYXRlX2ly
cV9kaXNhYmxlZChkLCB3YXNfaXJxX2Rpc2FibGVkKTsNCi0gICAgICAgIG1lbW9yeV9yZWdpb25f
c2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwNCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFO
RCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1BTkRfTUFT
VEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KKyAgICAgICAgcGNpX3NldF9tYXN0ZXIoZCwNCisgICAg
ICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFORCkg
Jg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfQ09NTUFORF9NQVNURVIpICYmIGQt
Pmhhc19wb3dlcik7DQogICAgIH0NCiANCiAgICAgbXNpX3dyaXRlX2NvbmZpZyhkLCBhZGRyLCB2
YWxfaW4sIGwpOw0KQEAgLTI4ODgsOSArMjg5Myw4IEBAIHZvaWQgcGNpX3NldF9wb3dlcihQQ0lE
ZXZpY2UgKmQsIGJvb2wgc3RhdGUpDQogDQogICAgIGQtPmhhc19wb3dlciA9IHN0YXRlOw0KICAg
ICBwY2lfdXBkYXRlX21hcHBpbmdzKGQpOw0KLSAgICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVk
KCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNURVIpICYmIGQtPmhhc19wb3dl
cik7DQorICAgIHBjaV9zZXRfbWFzdGVyKGQsIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJ
X0NPTU1BTkQpDQorICAgICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNURVIp
ICYmIGQtPmhhc19wb3dlcik7DQogICAgIGlmICghZC0+aGFzX3Bvd2VyKSB7DQogICAgICAgICBw
Y2lfZGV2aWNlX3Jlc2V0KGQpOw0KICAgICB9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kv
cGNpX2RldmljZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oDQppbmRleCBkM2RkMGY2
NGIyLi43ZmE1MDE1NjlhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5o
DQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmgNCkBAIC04Nyw2ICs4Nyw3IEBAIHN0
cnVjdCBQQ0lEZXZpY2Ugew0KICAgICBjaGFyIG5hbWVbNjRdOw0KICAgICBQQ0lJT1JlZ2lvbiBp
b19yZWdpb25zW1BDSV9OVU1fUkVHSU9OU107DQogICAgIEFkZHJlc3NTcGFjZSBidXNfbWFzdGVy
X2FzOw0KKyAgICBib29sIGlzX21hc3RlcjsNCiAgICAgTWVtb3J5UmVnaW9uIGJ1c19tYXN0ZXJf
Y29udGFpbmVyX3JlZ2lvbjsNCiAgICAgTWVtb3J5UmVnaW9uIGJ1c19tYXN0ZXJfZW5hYmxlX3Jl
Z2lvbjsNCiANCi0tIA0KMi40NC4wDQo=

