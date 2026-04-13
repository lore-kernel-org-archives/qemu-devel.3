Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F81EBFD0F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCBuB-0004Om-AR; Mon, 13 Apr 2026 03:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCBu6-0004EA-Fj; Mon, 13 Apr 2026 03:40:18 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCBu4-00077m-Bb; Mon, 13 Apr 2026 03:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFU1WMzmMwLYcljjzU0TvpSrx9X/ckvo2nvAJN1a04fhWjcvReI7sxENP6uLiXM5Q2Yr2+OmiN+IeSycdLbaTwhlgVTiiK7qdGeCGxTyuk2YEQhCqTOTTn1Rdpss9PDWtR3yC07kIWfdxsb/lCerAWVHhyplj/G9Rk0iBStc/9Fq+g1RnSCmIGbcSPq+qIzpbOTfUrP/Tg39BMLv0ulAYSXaXfmfzL3xSkO1IRQgOOGUeH44NKPcCZRrrcdeGXG0rQsfhUHa4O3sAHoMHWjXaVKWHjIaoZAlueDfplgK/NNR2gkp6SxCiE4xmD6pqH4psa4AHpNsQurxoiRqOcVAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qflZcZZlGjaN8m4lPnhCW3XqfZnjG5ZI3FGPmqRigAk=;
 b=Tkhy8pMIT+t+qKQ8uADOrIiG6wZ5VKrxPpN/uEbrtmewgPQ4s9fp1+Cr3WaMZ4tOW/8B/XHwZDZhDjG97YBJi0nFfyfadvs3X4gymp2DhpkTRLSdoDSED1KsO799e3fr9t0/OeEmIa+colXJX6dCavx0JGiipJFGO4kyCMtFwvy9l6/smNnJbpxnKJCfWoKIlemOaX7mDSztgYZqPz/SrDNhemInwGIiBh+iEhkVf+A/7MqKkmzLbJnieGIy63THy9l67LA/oIIQTivFsnn1q05ufTh5Ytamyj7iR/LUNRTpqIgZ3keij6gJ5KjIil76lv7kCSo6Ls/uSv0BsbCttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qflZcZZlGjaN8m4lPnhCW3XqfZnjG5ZI3FGPmqRigAk=;
 b=q+ec2jh4eH2ZG9FMB5HmdNUCt66q0maZniDhH1lzR1AW7Y/cB/2N8/5m9RcD0Gg/mrJ6T+IKymOIb1A85n0cvkB8WI950QPMVax2ys0D6UZMoGcJlytNG/OhLEJPfAt5uDeSRNrjWJTAT6PM3EMf0VG0lklfjEkiXt0+YS19W9bNWZQSp8VstZBP5FrDeslRSra1Re0Q6SpWLLX8XeFqi1ANXJ0RDwPn7C2p12HiYT5mXVOjND1J6Om7oEJYCcoS8KQIn+dkyMjRRqnUnINq9WTRtZaSbvKG8CDt6GWHRJEfpdhvaTkPoV9mO6sTRm3mIK6EmkTAR+aovoTfJ0zo+Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 13 Apr
 2026 07:40:09 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:40:09 +0000
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
Subject: RE: [PATCH v3 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Topic: [PATCH v3 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Index: AQHcpw4VGBh8coXz1kC9/DCludXWVLWpeg0AgDNoiqA=
Date: Mon, 13 Apr 2026 07:40:08 +0000
Message-ID: <CH3PR12MB7548C489238D665291D91A02AB242@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-20-skolothumtho@nvidia.com>
 <72dc05a6-3401-469b-8dd1-7dcabf79bb5a@redhat.com>
In-Reply-To: <72dc05a6-3401-469b-8dd1-7dcabf79bb5a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB6578:EE_
x-ms-office365-filtering-correlation-id: cad8fe6b-fdbd-4697-852f-08de992fe35c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: pZj2Lk/SbMT7Z/dQTO66spI53E2euGiQ2O6B/K7cSC79LUjNq8kou7ha+0NWJo0eQk8fUVIOWF1qCJfOymOFlgHcUmlPEFA4teDrXHsxoZaWwaepKiFa3XuYoLrN/Ayjzl4Fl+IUKHZnpOSAeI38pRYE2HTg8ZcxCCQOy+xFRbMTMvyMEp99Gul1mbAK3/4PYE4FLdVG3WJv3frNbBZpEMxyjWJMZJkG1D/RoRiAbCOPSCDSnnOy6HM+nkFQl44Hv1zVw1IOAWa4gu7eHverZkNkpi5NLSW+1ti5vyFVhr8ldHxNfxVHMOmuKCKJoku0B6GaNG/uD53UW+4RHOXcFFwe2652P4jvP9bdLL+YK/J0XawHGNOWkh4M5sB4yOW12ME8btfA0OhClDJWBVsHgWNiuEeZdi+fMdmDrdYY2HZZx8kqGKhBzim0zhLF4VQ8A/D5DhAxe2PLmR7J0axPX7cXYVzWOiWmppEeiIYiegiognJl9XBZMFVH/iKGNV6aISkkWKh9B9I5HS9LCAKQYMKDjTmU/IrZYVFzBn3it2F8jDzwUxmzPslrAcVHHdTjCTev0DZxn+CjbmBvSf0avN4thbYIdFExhy8zTGdK6J66sBQuAncLDXVrywk2ZEm7pi8uUgjlpBNG5QuQi3s4H7f+qcHA8qQzfbbfnjObmT1huRj+iU8TCQ89vWcydZQXjIuluMX66LQ5Wo+wca3xcqLXTyOAXTiSYV2y8qER0BfsP3oRASIlEvQdNDQBTb7+Pk/Ie2ZIhJFQPKmFnoYDXm06CGBsOcBHpNMWkzTzoVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkVBNlBsZXoyU1ZtaENwK2pxWGVaNDlrdnhsTERzeG9uTFdDa1dnR1J5RXgy?=
 =?utf-8?B?cGFmTkZBVzd1TUs4Mi9PRjdnalR5SVRxVzliOGpTSk1uTm5BZ0VtcXFqREV6?=
 =?utf-8?B?a2dpSklTejJGWm5YdkdXcU1MV25DMnQ2OGEydUJ0Y2hQWU1KdXl3YVh1KzJ0?=
 =?utf-8?B?a3cvWFRVd2Uxbm42VzlQd3kvVTVyOTYyRnZCV1FTMWxMRGcydWh2dFQ5TTFU?=
 =?utf-8?B?SEk0QytDOXpLNE04Y3VlWjJYWHJZWE5kclY4YWdjUGtRUWFrMDd5TVdDSk1K?=
 =?utf-8?B?Z3h0RHU2cjZCb2QxaWhVRVhrWHhhRU5TV2N4KzA5T0Rzei83RWJsL1BFZnRj?=
 =?utf-8?B?K2RrTjMvQ2tKTnJoOE0xc2Y0bnNxYUxXb0M3K0hWVmJsbkZkaDduaUlTWEd1?=
 =?utf-8?B?RXJsOTNLRUwvUHhZVEZWQzZ3WVppSENlMmUrK3Z1dll2S05jc0h5S2N3V2VT?=
 =?utf-8?B?RGhMNjk1MzM2K1hQam1GRm5FdlFYVEw5SWNMQU1xOFRlc2o3Q3JIeVJIZzFy?=
 =?utf-8?B?VWFGVW5Uc0tHb3N6WFBEcnNmR21lUzFGRmw4bDlBdWJRRGdibWhZVVhQU0lt?=
 =?utf-8?B?V0xtR0hsdlpoc1pFeFBhd1lxRnprT0llbGJXbTlTTTF3anRwdE43S3hWSFNZ?=
 =?utf-8?B?Q2YzREFZVTVFU1lhcGF2Umg2UGExYWNkdnJIK2FLSk5QZzVmdDh1Y29weEZk?=
 =?utf-8?B?R0kvUkhNdjliNEQ4OHZFTklZY3lQL0NpbGkvbGxDRHZqc0lGbjU0NWZhczVz?=
 =?utf-8?B?MVpmUGxweC9GMTVMTUNFWUpiZWd1eVV6N3NTc1MxQy9Fb3Z1Y29zMi9OMHZB?=
 =?utf-8?B?eEpIcjRMZ2hPeFh1bW1abjhxbkRmUzFyZHlKRFFtVXZ6OXBSRnY1OEo0QUNt?=
 =?utf-8?B?Y0pUZllLbzVnU3FrRkdrMGdreXUwK0VoSUtiS2s3MWNIb3poeDA5TEtYY1Fw?=
 =?utf-8?B?Z3QzSTBSQkNJMWFOTDBXU1RYOWtwbjRBUjdZZnJ5K2ZWcG5kWGk3WFptbVRQ?=
 =?utf-8?B?blJaZnkxWjFvL1RCd05lOGVhSkFJVDhHWFBDUkNvMG0xZElRaU1PbEM3bjlC?=
 =?utf-8?B?dFZ2V2xTdGIxSjlISnRsL2hPaVpZcStOUmxiVzhRdG1LZnJuMkNHaFVmNmlT?=
 =?utf-8?B?WCtTZWJTYU8vUm9GTGhoOWlOakVFRWNjeWE0MkFTdG8xbXBIRkw1VHNaaENP?=
 =?utf-8?B?bzEyWmJXQ0EvNWRsdGFld2h6T1pqWFFWZm1lMVZaYXJJaWhQT01pb005aXhF?=
 =?utf-8?B?d0I5V01zOFZRSytNc2VHZGkwT3J5MjVuL3luN3J3SjZWYkpDMEdjNjV0MmR2?=
 =?utf-8?B?MGJkODF4Rnk3SDFja1Z5VWd4L0RuV2U0MSt3QWJIOVJGWTQ1WHRiNG1QZkdr?=
 =?utf-8?B?RnpJWXJSSjNBc2ZYZEtQRWVweUZJREJheGlwT3kzcHVjdzJyeHQzNHdlNGEz?=
 =?utf-8?B?Q1JkWktXV1I0RWlLU1J5d2pxVW9iRFd2NWo5bWx6UTQzdHVBVGxNQzJXL0pY?=
 =?utf-8?B?U2FCTnY5N1hjMjJzR1VXSnNMb0Y0SjhmVjlHSjhsbkQ0R2RHU0pPOEhWOXhF?=
 =?utf-8?B?b3kxaStDblFNODcwd1ROV1ZWZjNQc2hQVU8yNVJHZ0lCWVVPdFpLaWNOQXNG?=
 =?utf-8?B?Rmo0NS9JMk1MdVhRMHlVcWNrblozWDF5N0FJR2MrUUY0cnk1czRiU0NmRjJC?=
 =?utf-8?B?NGFnZ2VWWEprNmg3ODhVdFNFMG15SzhqRlhDTlVOWGZHZDdtMXZxREtwR0Fy?=
 =?utf-8?B?M0xHSFpDaDZuamFxczN0UHZSMlhJSk5zQnlWNU5Za0JCZU1DZnluV21oMlRo?=
 =?utf-8?B?RWxsRFErQVQ2eUJpNHNyaEk1Q2NMSFNqRmNwMGZ4RXQ4eVh3ZnB0VFY2RkZ0?=
 =?utf-8?B?cUljd1d1cTVqK2RDbE5paXVEZExyQ2hlSStJQmxIeHMwMGJMeFdZWHh0M0JQ?=
 =?utf-8?B?eG5teUcwakVMMnNqZzlGRHdKbS9GdVdkbFBZT2t1RFowMk1iSVpXdUFaZklI?=
 =?utf-8?B?Skc5SzFvRzFuVXRtMzR4d2hLUENOckdTYVFpOVRvQXdWOFFMbmxVR3JHbWdo?=
 =?utf-8?B?NVJ4bnNMWTlRcVJydXFYUkkybkpBRStPc3ZkVjVCYjdYY213YzV5d2phb01K?=
 =?utf-8?B?RXJJc0hhTElYajU1TVZZRmNTcHZJd1QxdWlTUFFTMExzcmhaQXMvR1ExU3ZB?=
 =?utf-8?B?OGY5RGZqUzZlclBsQlBIQlo4V2hJMXg4L0xXaFlPSkVWbURXMGdGMloxSXJ1?=
 =?utf-8?B?WGFHNFNaYnc4ejhMQ0NJUW1SaHZoM3JrMVZVTXBpNS81MTlhQlNZVHNhMG5z?=
 =?utf-8?B?SGgrTWgzRzBKTUppUjVLRGpCRnQwRU5BaTYzc0prQktGM0c4V004dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad8fe6b-fdbd-4697-852f-08de992fe35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:40:08.9984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGhAAkWAmnvhW+hqAXTmqHz89Mxb653UmdJeoqpyFzdmiY257RIPsmOR1sDIYSUg9lXmDPtvpzEV50ZCpEFmaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMSBNYXJjaCAyMDI2IDE0OjM0DQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE5LzMyXSBody9h
cm0vdGVncmEyNDEtY21kcXY6IEFsbG9jYXRlIEhXDQo+IFZDTURRcyBvbiBiYXNlIHJlZ2lzdGVy
IHByb2dyYW1taW5nDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDIvMjYvMjYgMTE6NTAgQU0sIFNoYW1l
ZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Budmlk
aWEuY29tPg0KPiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGFsbG9jYXRpbmcgSU9NTVVGRCBoYXJk
d2FyZSBxdWV1ZXMgd2hlbiB0aGUgZ3Vlc3QNCj4gPiBwcm9ncmFtcyB0aGUgVkNNRFEgQkFTRSBy
ZWdpc3RlcnMuDQo+ID4NCj4gPiBWQ01EUV9FTiBpcyBwYXJ0IG9mIHRoZSBWQ01EUV9DT05GSUcg
cmVnaXN0ZXIsIHdoaWNoIGlzIGFjY2Vzc2VkDQo+ID4gdGhyb3VnaCB0aGUgVklOVEYgUGFnZTAg
cmVnaW9uLiBUaGlzIHJlZ2lvbiBpcyBtYXBwZWQgZGlyZWN0bHkgaW50bw0KPiA+IHRoZSBndWVz
dCBhZGRyZXNzIHNwYWNlIChpbnRyb2R1Y2VkIGluIGEgc3Vic2VxdWVudCBwYXRjaCksIHNvIFFF
TVUNCj4gPiBkb2VzIG5vdCB0cmFwIHdyaXRlcyB0byBWQ01EUV9DT05GSUcuDQo+ID4NCj4gPiBT
aW5jZSBWQ01EUV9FTiB3cml0ZXMgYXJlIG5vdCB0cmFwcGVkLCBRRU1VIGNhbm5vdCBhbGxvY2F0
ZSB0aGUNCj4gPiBoYXJkd2FyZSBxdWV1ZSBiYXNlZCBvbiB0aGF0IGJpdC4gSW5zdGVhZCwgYWxs
b2NhdGUgdGhlIElPTU1VRkQNCj4gPiBoYXJkd2FyZSBxdWV1ZSB3aGVuIHRoZSBndWVzdCB3cml0
ZXMgYSBWQ01EUSBCQVNFIHJlZ2lzdGVyIHdpdGggYQ0KPiA+IHZhbGlkIFJBTS1iYWNrZWQgYWRk
cmVzcyBhbmQgd2hlbiBDTURRViBhbmQgVklOVEYgYXJlIGVuYWJsZWQuDQo+ID4NCj4gPiBJZiBh
IGhhcmR3YXJlIHF1ZXVlIHdhcyBwcmV2aW91c2x5IGFsbG9jYXRlZCBmb3IgdGhlIHNhbWUgVkNN
RFEsDQo+ID4gZnJlZSBpdCBiZWZvcmUgcmVhbGxvY2F0aW9uLg0KPiA+DQo+ID4gV3JpdGVzIHdp
dGggaW52YWxpZCBhZGRyZXNzZXMgYXJlIGlnbm9yZWQuDQo+ID4NCj4gPiBBbGwgYWxsb2NhdGVk
IFZDTURRcyBhcmUgZnJlZWQgd2hlbiBDTURRViBvciBWSU5URiBpcyBkaXNhYmxlZC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNv
bT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmggfCAxMSArKysrKysrDQo+
ID4gIGh3L2FybS90ZWdyYTI0MS1jbWRxdi5jIHwgNzENCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS90ZWdyYTI0
MS1jbWRxdi5oIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmgNCj4gPiBpbmRleCAzY2U5ZjUzOWFl
Li4xMzllMTRiNjFiIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+
ID4gKysrIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmgNCj4gPiBAQCAtMzYsNiArMzYsNyBAQCB0
eXBlZGVmIHN0cnVjdCBUZWdyYTI0MUNNRFFWIHsNCj4gPiAgICAgIFNNTVV2M0FjY2VsU3RhdGUg
KnNfYWNjZWw7DQo+ID4gICAgICBNZW1vcnlSZWdpb24gbW1pb19jbWRxdjsNCj4gPiAgICAgIHFl
bXVfaXJxIGlycTsNCj4gPiArICAgIElPTU1VRkRIV3F1ZXVlICp2Y21kcVtURUdSQTI0MV9DTURR
Vl9NQVhfQ01EUV07DQo+ID4gICAgICB2b2lkICp2aW50Zl9wYWdlMDsNCj4gPg0KPiA+ICAgICAg
LyogUmVnaXN0ZXIgQ2FjaGUgKi8NCj4gPiBAQCAtMzIyLDYgKzMyMywxNiBAQCBBX1ZJX1ZDTURR
aV9DT05TX0lORFhfQkFTRV9EUkFNX0woMSkNCj4gPiAgQV9WSV9WQ01EUWlfQ09OU19JTkRYX0JB
U0VfRFJBTV9IKDApDQo+ID4gIEFfVklfVkNNRFFpX0NPTlNfSU5EWF9CQVNFX0RSQU1fSCgxKQ0K
PiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0ZWdyYTI0MV9jbWRxX2VuYWJsZWQoVGVncmEy
NDFDTURRViAqY21kcSkNCj4gPiArew0KPiA+ICsgICAgcmV0dXJuIGNtZHEtPnN0YXR1cyAmIFJf
U1RBVFVTX0NNRFFWX0VOQUJMRURfTUFTSzsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
bGluZSBib29sIHRlZ3JhMjQxX3ZpbnRmX2VuYWJsZWQoVGVncmEyNDFDTURRViAqY21kcSkNCj4g
PiArew0KPiA+ICsgICAgcmV0dXJuIGNtZHEtPnZpbnRmX3N0YXR1cyAmIFJfVklOVEYwX1NUQVRV
U19FTkFCTEVfT0tfTUFTSzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgY29uc3QgU01NVXYzQWNjZWxD
bWRxdk9wcyAqdGVncmEyNDFfY21kcXZfZ2V0X29wcyh2b2lkKTsNCj4gPg0KPiA+ICAjZW5kaWYg
LyogSFdfQVJNX1RFR1JBMjQxX0NNRFFWX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3Rl
Z3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IGluZGV4IGEzNzY3
YTg1YTMuLjAwMmRkZTUwZmMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC0xNTEsNiArMTUx
LDY3IEBAIHN0YXRpYyB1aW50NjRfdCB0ZWdyYTI0MV9jbWRxdl9yZWFkKHZvaWQNCj4gKm9wYXF1
ZSwgaHdhZGRyIG9mZnNldCwgdW5zaWduZWQgc2l6ZSkNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIHRlZ3JhMjQxX2NtZHF2X2ZyZWVfdmNtZHEoVGVncmEyNDFDTURR
ViAqY21kcXYsIGludA0KPiBpbmRleCkNCj4gPiArew0KPiA+ICsgICAgU01NVXYzQWNjZWxTdGF0
ZSAqYWNjZWwgPSBjbWRxdi0+c19hY2NlbDsNCj4gPiArICAgIElPTU1VRkRWaW9tbXUgKnZpb21t
dSA9IGFjY2VsLT52aW9tbXU7DQo+ID4gKyAgICBJT01NVUZESFdxdWV1ZSAqdmNtZHEgPSBjbWRx
di0+dmNtZHFbaW5kZXhdOw0KPiA+ICsNCj4gPiArICAgIGlmICghdmNtZHEpIHsNCj4gPiArICAg
ICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKyAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9p
ZCh2aW9tbXUtPmlvbW11ZmQsIHZjbWRxLT5od19xdWV1ZV9pZCk7DQo+ID4gKyAgICBnX2ZyZWUo
dmNtZHEpOw0KPiA+ICsgICAgY21kcXYtPnZjbWRxW2luZGV4XSA9IE5VTEw7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIHRlZ3JhMjQxX2NtZHF2X2ZyZWVfYWxsX3ZjbWRxKFRlZ3Jh
MjQxQ01EUVYgKmNtZHF2KQ0KPiA+ICt7DQo+ID4gKyAgICAvKiBGcmVlIGluIHRoZSByZXZlcnNl
IG9yZGVyIHRvIGF2b2lkICJyZXNvdXJjZSBidXN5IiBlcnJvciAqLw0KPiA+ICsgICAgZm9yIChp
bnQgaSA9IChURUdSQTI0MV9DTURRVl9NQVhfQ01EUSAtIDEpOyBpID49IDA7IGktLSkgew0KPiBJ
cyBpdCBmdXR1cmUgcHJvb2YgdG8gcmVzdHJpY3QgdGhlIG51bWJlciBvZiBxdWV1ZXMgdG8gMj8g
U2hvdWxkbid0IGl0DQo+IGJlIGNvbmZpZ3VyYWJsZT8NCg0KT24gY3VycmVudCBwbGF0Zm9ybXMg
dGhlIGhvc3QgcmVwb3J0cyBsb2cydmNtZHFzID0gMSAoMiBWQ01EUXMpLg0KSSB0aGluaywgZm9y
IHRoZSBpbml0aWFsIGltcGxlbWVudGF0aW9uIHdlIGNhbiBrZWVwIHRoZSBudW1iZXIgb2YgcXVl
dWVzDQp0byAyLiBXZSBjYW4gbWFrZSBpdCBjb25maWd1cmFibGUgaWYgdGhlIHJlcXVpcmVtZW50
IGNvbWVzIHVwIGluIHRoZSBmdXR1cmUuDQoNClRoYW5rcywNClNoYW1lZXINCg0K

