Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA235CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 02:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOndd-0005SS-OI; Sun, 17 May 2026 22:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wOndQ-0005Ra-7y
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:23:13 -0400
Received: from mail-japanwestazon11011064.outbound.protection.outlook.com
 ([40.107.74.64] helo=OS0P286CU010.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wOndL-0008Lf-C7
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWeQ1EnxsgYvK4BdCXTQ+r7IwFmhOn5k1A6Tov1qpZNVrRdwM6WfYbKpmQs70kthYnRv+3SlteWaOkwpntN1/vMszsuLzx3+skrZMpIaz8CBFFTO3byLrJWlT2SO1CBqDxf1eAUowGdTRwcLbA8ir8QvJjQ6a5OIXsFPTtlQmVNdvGE2Q2/iwRl/XzKsVTaIEyqAkNKu0hsc0kbuY0DQsFzkLLAYzq3g1nUbL044FhIfS+LONaHhS4LMiyDQPqdEbppr/zS/eReRZ3G8qYFBOykS3H1kQKJTpT8i/PI0Qk9F6S3fWhJJPjDsEmwk0GKHNy5KAid+jOlAapv1hkrdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwh9w6v8xB5QRIbArfJfbIP0jNQXbdKs+mAaw7lBkKg=;
 b=QTvBy8NLZLIQvm33Vm28TUGHj3E5pbbU/mULU4fvqU8x3j0R0uB9VJAX5vRMCsTcEZTw5rwwMxzTmzwV0Yb1Yt2RoOLo3CKzMXvq2lwOM0gfibDHHMzCDi3pAtpHoSHaDbjkwmVXKsYvofdbHgnX2RFLhNUWwYr0JZOM6Q3caXtmusrlPMIoQN5itvXkLk2/2/KApidQoH+FNvjeukf8E4Dyzxd6Ua0G3UEtD8fkgol/1TxWs4j+rpRR0l7O3av+bZPElSLQnafkJeQC8rka/i5m8ZfmHp2PWYB7/0mu4xohswzT4VCcj4dG2BSdny9DrnP5efxwbdjGd+J/2CHCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwh9w6v8xB5QRIbArfJfbIP0jNQXbdKs+mAaw7lBkKg=;
 b=HcmUpdoFflkPypMuWa7kXQp/2HCz80DSNwDWyFPV9JcWYkTFWEeiJvC3xs9U2+TqBWM5Mgt9lQ51hEmqqcC3zyHK5UdgzSDwff+PLW6wkCgpT44tvKK/WO2zl5eSPPbZa1xNMeQHX3Qu4+x6i1yM31K3P4O/2C+ZwpOxE75zN7/gUazXy9UFP0q1K35unMJcz+K2oV5DzxEXJlxl0QGuZreWzOfi/m92uwTMDxJIqBCTgoGAFBt3FoIan5z13vs4860zklSrCTTK1oqFCUCvf1FU4wk6LVPiRFXUSW5Jfvd7gqtLT9cxRkBHwlTTrh6xC42J5sg91RTIwI2+5fAliQ==
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com (2603:1096:604:2e6::7)
 by TYVPR01MB10878.jpnprd01.prod.outlook.com (2603:1096:400:2ac::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 02:17:58 +0000
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131]) by OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 02:17:58 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Samuel Zhang <guoqing.zhang@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "berrange@redhat.com" <berrange@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "Emily.Deng@amd.com" <Emily.Deng@amd.com>, "Victor.Zhao@amd.com"
 <Victor.Zhao@amd.com>, "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>,
 "Qing.Ma@amd.com" <Qing.Ma@amd.com>
Subject: Re: [PATCH] migration/rdma: change default rdma chunk size to 64MiB
Thread-Topic: [PATCH] migration/rdma: change default rdma chunk size to 64MiB
Thread-Index: AQHc41BzGOoGn8frsUu4bxaIXDOjirYTEm2A
Date: Mon, 18 May 2026 02:17:58 +0000
Message-ID: <eadfa566-9f75-408b-971f-986315b49476@fujitsu.com>
References: <20260514031848.2422203-1-guoqing.zhang@amd.com>
In-Reply-To: <20260514031848.2422203-1-guoqing.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12148:EE_|TYVPR01MB10878:EE_
x-ms-office365-filtering-correlation-id: 6b3ccc11-c76c-4ba9-60d9-08deb483adb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|11063799003|1580799027|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: UP47D+rT9FTUoYhbrTOvq6ZsNHUj6WzFB6gmvxUiPDMTMDbmYI5bKzF17PPvSMW6fAyxzRiViGK+7F5wMCYIvZcTu4g4ZGVY2HMVA1gqRMc92LwGl8nvKzCy0OxIeP6lrHWMxXnaRPkAN+ywRv9p5o3fcMPlvsYBcQ2oLdR3KUHiymPxRffcHqao8LBapW0dHDCgLKGNTNCKkvq5QcrPCZR1NhppVcTGyh5q51tjX8k/4d05Mksi+l7W+VQB2lKQ7/dpOX7EcpDDYiYES3a6itoiUajHJS5WK6QxWd3z5S/zThnXGBCD7sJXacjV6rrTRAzQw27j2+PfKhM4WBjXONxQkTHkDX+Lc6zNz5sHN5CW633WCjxpBnClGHvvkkJNU9AmBLgNAkcHmm24QmHB7r5GQVAXamB9+pX5HSwDxrTUAYQbFcIXbuMHJVzXkzWFlmvYcc+/Z4n3blz1SJiOyvGpPKpCo33DLnoVreCWTKmTmFYVBCvcML1lqmkuCww8SlIW7BRuDaSICKVxwLWIXGUnD1Mty2MrJ4RcchfNgfSemMYDBahWL7QEIOBeLUvlhcxeOcWc1ZOxVD1UWydhFyVrhUxn5nK4NUYFfSTWZ622LDU5B2kM2kobwgAgvFBmHSdHCEflJhA7Qun+5pLTylNfoeidq6pc6Sve7UB2cc5cKvoI3YWTZTpPnaAVpNPZVjXZunlRQeDQg2zWyzMmOEaSCf+tW32sYj83vFJx0mP9VlMeO1tU+502bfhTVv5oIL+xV2A/AfyY2DOIgnBy6lRrXW9ncGNBbFt6zy1KTPQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS9PR01MB12148.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(11063799003)(1580799027)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUJPdzlBYnYxdjBVcURzUzhFQlBCWXh2NkFwS1IweUJjZFFPVHUvODlNY3hm?=
 =?utf-8?B?RGdsZU1ncmgydkErQVdDSThrbndWNWUvcE5FWUh5NmdOdndwdWEvbURYdHFz?=
 =?utf-8?B?T0xWTS80UlhRUmdoaHYzMmVvWVVhMko3dFVndlN4RTlpbWR0SHRtUENRbjVU?=
 =?utf-8?B?M0xZSkdhRVVvWWp1MlZyelFlZWw3SnBrOTZZc1lpZnJiL2VBbGluQzlVQW5E?=
 =?utf-8?B?KzM0MzJSaHV1VE5zSm1YMmFJYkVUMUNheEw4RzEzb0g2VHhRTVRjaStMcE1S?=
 =?utf-8?B?UlMzYVUyL2s0UWllUXMxbjdWRUJaaG9vaVg2Y2RITExuRmVERVEyZHdUK0Y4?=
 =?utf-8?B?N0lHcys5VmJOcVpPaGdXYWlhbDJ6NUlPRDFrbU9OdzFoQy82NFNPQ1FXQ1Vs?=
 =?utf-8?B?cCtPZlltMjJjeVJCeGFMaWNPZ2l1RmsxaEp1SGhiMEhJQ1lnZUwvYXEvajJK?=
 =?utf-8?B?azVUTnZ4K0N5bEFxallnNGY0K2pKUXpBcnNJKzQrRlR3RmhMN0hMeFJ5VTIz?=
 =?utf-8?B?NDRsNUxwVnlTakJ6VVNMMjNLTG95K2lFL2wrdGIxQVNKZDFpS1JvaVdhNUxo?=
 =?utf-8?B?YmpSV2JibDgrejN4SElQMlZxQ1Nvb2JhZWp2b05GR2NXUTlQUFFySEZsZmEz?=
 =?utf-8?B?Yy9RdG1oSTR5OGJBQWJhenE1WWpib0E2UVJPNThkaVRpN2wzSFVPcVJDS2o4?=
 =?utf-8?B?UXFsbnhMeWFmTzEwMjRGRC9ZaUpxeGozQVBTeDkyVUc5d1lJTDlRNE83dDlm?=
 =?utf-8?B?bDhnZ0VQNjNWZ2xreUIxUTZMRTFPaTBOUzB3YnZvRUlULzR5TEIyeVRzSDNo?=
 =?utf-8?B?Z0R4NEFaMWRhSVkxM0wwNHExUEFDaHlrMnRyMkhld2dZQVdleWlscXZkVzJQ?=
 =?utf-8?B?b29sbDVjVlA2VTRmM2hld3gxQmFSUzJCKys0N3NWa3pDT2tQekRSWmRvamtE?=
 =?utf-8?B?UWYwVkNyUitPL0k1ampkUTQ1cnZDNE8vQkxCVnc4azZNTFZMRWhjd2tPUGRF?=
 =?utf-8?B?c1Z5bU0zRHozY0JhZXRhQlVpS08rNkRUUkd0MWZKRGhsSUlzNktSQzF3NEVJ?=
 =?utf-8?B?b3plbm5wME9FQWNMU05oUFY1OTBndEdMTllnQVpHTWx4OFRsMStjc0FBYkhw?=
 =?utf-8?B?M0RFVnRnSHlSRTFXV3FmS1ZnMzdWTHBWNDZ2Z1ZPeEhENitBeS9pVkpVeFR0?=
 =?utf-8?B?ZHdhNTR4VHJxT3B5ZWNYKzBHMWx0MnZ0NjhlbGJhTmJrdnhFSExkUWNpVm4z?=
 =?utf-8?B?QmJoN0x1UkRZOWJKaG16ZWY5Mm9CSzdkVXNULytwaWJ0R1F3Ti9LQytjZE5O?=
 =?utf-8?B?eW5SdWl5M0h5TUphWjlBdDY4NnJEai9JdkZkL1ROc1NhZjZrb3d4VFdLRDh5?=
 =?utf-8?B?dmR2cjdLaUxhb2R4empPYUlERngzTkJRcTYxS2p6d0l6RThOMHJDREZ6cmJB?=
 =?utf-8?B?ek5aZEVoT21TbHdtM3JVaGNzTzdlUHZmMlRjblEvSGp1cjBaQ25PZUZPMTFN?=
 =?utf-8?B?bjdlUEljb3dBeUQ1SVhKVmZ3U1RIbVNObXBrR254WTgwblVzNkszZ2YxM3ZI?=
 =?utf-8?B?MmNFbGt0UUpheVRQQUU3SElrSW5KNk1LZ0ExTEUyb0pYTXo0ekdpeFpuK2R3?=
 =?utf-8?B?enZJRytOWDFOUlloSmRlTFZTamJ0WFVrSENFOUpTdWZQNmt5RHg2ejFKVE82?=
 =?utf-8?B?RUlWaHk4bWRwYVlOR2FNbnlpclBiL1p3MFMrNEJrUjlRNW00MlpxV1o3dVNm?=
 =?utf-8?B?NEJ4ZmtsNEFWRmpaMVkrWXhUblp6SUlid094clpJSG92M2l1bUsyTTQzM3V0?=
 =?utf-8?B?RFNOSldJdjBwSW11NUVkbmVIY3ZCSEcrbGcwVkVNQitLT2xPOGQwQjBxQmpS?=
 =?utf-8?B?K2FjdWU2WElmSXB4Nnc0NzV0OUd1aDVUMEk3SnEwZWorVE8xemdzQkVMdTJz?=
 =?utf-8?B?cVEydVg0ZVBHNVdTNXFTTGl2RURuNmhVQzNwVDgxTFdMdjRJTzFGVGRhL2Ry?=
 =?utf-8?B?UFY0WkV5QkhBWmVWTGpVRFBaQmJQTS9tbU9tU2kxTi9YNm0rYnBIZE5MZ0s4?=
 =?utf-8?B?QldtZUNnRkIyZXA4anNMZ002MnZLRDVyZTREZGNnT2taYVhicG5idGIweGU1?=
 =?utf-8?B?VFBGTk4wVkV5V2xsQjZUNkNJL2lrV1YvZ2xHNGJFRDZUN0pSdjkwWllRM1NO?=
 =?utf-8?B?VHAwYkdoOU15aXZ5UlhtellEdStlVGNsTytiYUYvdjMydW1VTHozN1E4NEtr?=
 =?utf-8?B?Qld3Mmt0ZlpDdDZ5RW43WTJFRXVXUlYzMlpDUHgyTzZiS3o0TURzdmc2Rytq?=
 =?utf-8?B?QVBQSEt2MUFzdUVRdGJlTGdETk1KNWlsZFd3dWtBaFpqV1JobUhPSk0yZit2?=
 =?utf-8?Q?9aYKlZuciw51C3xE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E173BCF290713347A6822142DCFA3FDF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RqPHzCxPPFy5TV6+EuJEiTqWoO5urhl7oPj3CZu4yhtnO65HjQvB756GORDJz+MiTNIuuth9gDusAZ6O0wKzxtoTuCxreF/zgFx+BGnYWhW9xs/FYfslbsDqAp8c7e8Qp/nlt7nTGKsOYpH473JOuG5t/FKOFycTqPUrxeghZkDz3giVZxFt5gvDBQ7AgUnQYdBD+cevqjgVqdLTslKU9WjtkfAHtrAif/mUTfmVo50sZIiQC2oIJODNKkPQF3xAeb2C0tsyJc6JcFiCWfP635tn1PpLZhwo7C4INYf0bpgB8BUQNRBLydS32g8jgdcbe12tdMb5uwLgCS9IGj2cRw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12148.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3ccc11-c76c-4ba9-60d9-08deb483adb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 02:17:58.0863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocXILMqEioXWt22IzCndRnZZ3bWbIXkWO4l+JPz44AtiP1Gqi753gMdNp4Pso/vPn+jowTr7qemekoYhE8brIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10878
Received-SPF: pass client-ip=40.107.74.64; envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU010.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U2FtdWVsLA0KDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQpPbiAxNC8wNS8yMDI2IDExOjE4
LCBTYW11ZWwgWmhhbmcgd3JvdGU6DQo+IFRoZSAxTWlCIGRlZmF1bHQgZGF0ZXMgYmFjayB0byB0
aGUgb3JpZ2luYWwgUkRNQSBpbXBsZW1lbnRhdGlvbiBpbg0KPiAyMDEzIChjb21taXQgMmRhNzc2
ZGI0OCksIGFuZCBpcyB0b28gY29uc2VydmF0aXZlIGZvciBtb2Rlcm4gaGFyZHdhcmUuDQo+IA0K
PiA2NE1pQiBjYXB0dXJlcyBtb3N0IG9mIHRoZSB0aHJvdWdocHV0IGdhaW4gKH4xMHggb3ZlciAx
TWlCKSB3aGlsZQ0KPiBrZWVwaW5nIHRyYW5zZmVycmVkIGRhdGEgbG93LiAgTGFyZ2VyIGNodW5r
cyBjYXVzZSBtb3JlIGRhdGEgdG8gYmUNCj4gcmV0cmFuc2ZlcnJlZCBwZXIgZGlydHkgcGFnZSwg
c28gdGhlIGxhcmdlc3QgY2h1bmsgc2l6ZSBpcyBub3QNCj4gbmVjZXNzYXJpbHkgb3B0aW1hbCAo
c2VlIDEwMjRNaUIgcm93KS4gIFRoZSB4LXJkbWEtY2h1bmstc2l6ZQ0KPiBwYXJhbWV0ZXIgcmVt
YWlucyBhdmFpbGFibGUgZm9yIHVzZXIgdHVuaW5nLg0KPiANCj4gVGVzdCBjb25maWc6IEJsdWVG
aWVsZC0zIENvbm5lY3RYLTcsIDhHQiBWTSBSQU0sIHBpbi1hbGwgb2ZmLA0KPiAgICBgc3RyZXNz
LW5nIC0tdm0gNCAtLXZtLWJ5dGVzIDFHIC0tdm0tbWV0aG9kIHJhbmQtc2V0YA0KPiANCj4gY2h1
bmtfc2l6ZSAgdG90YWwobXMpICBkb3duKG1zKSAgVGhyb3VnaHB1dChNYnBzKSAgdHJhbnNmZXJy
ZWQNCj4gMW0gICAgICAgICAgICA0NSwxNTYgICAgMSwxNjYgICAgICAgICAgMSwyNTIuNTAgICAg
IDYuNDYgR2lCDQo+IDMybSAgICAgICAgICAgMTUsMDM0ICAgIDEsODY0ICAgICAgICAgIDMsNDAx
LjI2ICAgICA1LjU3IEdpQg0KPiA2NG0gICAgICAgICAgICA0LDQ5MiAgICAxLDU1NCAgICAgICAg
IDEzLDYzNy40NiAgICAgNS43NSBHaUINCj4gMTI4bSAgICAgICAgICAgMyw5NDAgICAgMSw2NjIg
ICAgICAgICAxNiw4NjAuNTkgICAgIDYuMDYgR2lCDQo+IDEwMjRtICAgICAgICAgIDMsNjY1ICAg
IDIsMjM4ICAgICAgICAgMjQsNjc2LjU5ICAgICA4LjA0IEdpQg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2FtdWVsIFpoYW5nIDxndW9xaW5nLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3Jh
dGlvbi9vcHRpb25zLmMgfCAyICstDQo+ICAgcWFwaS9taWdyYXRpb24uanNvbiB8IDIgKy0NCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9taWdyYXRpb24vb3B0aW9ucy5jIGIvbWlncmF0aW9uL29wdGlvbnMuYw0K
PiBpbmRleCA1Y2JmZDI5MDk5Li5lYTIxMzczNzJjIDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24v
b3B0aW9ucy5jDQo+ICsrKyBiL21pZ3JhdGlvbi9vcHRpb25zLmMNCj4gQEAgLTkxLDcgKzkxLDcg
QEAgY29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJvcF9TdHJPck51bGw7DQo+ICAgDQo+ICAgI2Rl
ZmluZSBERUZBVUxUX01JR1JBVEVfVkNQVV9ESVJUWV9MSU1JVF9QRVJJT0QgICAgIDEwMDAgICAg
LyogbWlsbGlzZWNvbmRzICovDQo+ICAgI2RlZmluZSBERUZBVUxUX01JR1JBVEVfVkNQVV9ESVJU
WV9MSU1JVCAgICAgICAgICAgIDEgICAgICAgLyogTUIvcyAqLw0KPiAtI2RlZmluZSBERUZBVUxU
X01JR1JBVEVfWF9SRE1BX0NIVU5LX1NJWkUgICAgICAgICAgIE1pQg0KPiArI2RlZmluZSBERUZB
VUxUX01JR1JBVEVfWF9SRE1BX0NIVU5LX1NJWkUgICAgICAgICAgICg2NCAqIE1pQikNCg0KDQpJ
IGhhdmUgYSBjb25jZXJuIGFib3V0IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuDQoNCkFGQUlLLCBj
aGFuZ2luZyB0aGUgZGVmYXVsdCBjaHVuayBzaXplIGNvdWxkIGJyZWFrIFJETUEgbWlncmF0aW9u
IGJldHdlZW4gaG9zdHMgcnVubmluZyBkaWZmZXJlbnQgUUVNVSB2ZXJzaW9ucy4NCklmIHRoaXMg
aGFwcGVucywgdGhlIGVycm9yIG1lc3NhZ2UgaXMgbm90IGNsZWFyIGVub3VnaCBmb3IgYSB1c2Vy
IHRvIHVuZGVyc3RhbmQgdGhhdCB0aGUgZmFpbHVyZQ0KaXMgZHVlIHRvIGEgbWlzbWF0Y2ggaW4g
J3gtcmRtYS1jaHVuay1zaXplJz8NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvNmYxZGY3MzItNWMyYy00ZjFiLWE1OWEtYWE2YWY1NTY2NTA1QGZ1aml0c3UuY29tLw0K
DQpUaGFua3MNClpoaWppYW4NCg0KDQo+ICAgDQo+ICAgY29uc3QgUHJvcGVydHkgbWlncmF0aW9u
X3Byb3BlcnRpZXNbXSA9IHsNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgic3RvcmUtZ2xvYmFs
LXN0YXRlIiwgTWlncmF0aW9uU3RhdGUsDQo+IGRpZmYgLS1naXQgYS9xYXBpL21pZ3JhdGlvbi5q
c29uIGIvcWFwaS9taWdyYXRpb24uanNvbg0KPiBpbmRleCAwZGIxMTVlYzVlLi5iMzgxNWYwNTk0
IDEwMDY0NA0KPiAtLS0gYS9xYXBpL21pZ3JhdGlvbi5qc29uDQo+ICsrKyBiL3FhcGkvbWlncmF0
aW9uLmpzb24NCj4gQEAgLTEwMDksNyArMTAwOSw3IEBADQo+ICAgIyAgICAgdGhlIHJlbWFpbmRl
ciBpdHMgYXJndW1lbnRzLiAgKFNpbmNlIDEwLjIpDQo+ICAgIw0KPiAgICMgQHgtcmRtYS1jaHVu
ay1zaXplOiBSRE1BIG1lbW9yeSByZWdpc3RyYXRpb24gY2h1bmsgc2l6ZSBpbiBieXRlcy4NCj4g
LSMgICAgIERlZmF1bHQgaXMgMU1pQi4gIE11c3QgYmUgYSBwb3dlciBvZiAyIGluIHRoZSByYW5n
ZQ0KPiArIyAgICAgRGVmYXVsdCBpcyA2NE1pQi4gIE11c3QgYmUgYSBwb3dlciBvZiAyIGluIHRo
ZSByYW5nZQ0KPiAgICMgICAgIFsxTWlCLCAxMDI0TWlCXS4gIE9ubHkgYXBwbGllcyB3aGVuIG1p
Z3JhdGluZyB2aWEgUkRNQS4NCj4gICAjICAgICBNdXN0IGJlIHNldCB0byB0aGUgc2FtZSB2YWx1
ZSBvbiBib3RoIHNvdXJjZSBhbmQgZGVzdGluYXRpb24NCj4gICAjICAgICBiZWZvcmUgbWlncmF0
aW9uIHN0YXJ0cy4gIChTaW5jZSAxMS4xKQ0K

