Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C20D3C92B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMuP-0007zw-42; Wed, 10 Dec 2025 11:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTMuN-0007zO-Gc; Wed, 10 Dec 2025 11:19:19 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTMuK-0006x2-UL; Wed, 10 Dec 2025 11:19:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFlOxLMBqZo3dizSFlCKB2TAwkAXF3mjvBghs67Xm2lQPZCrZi7GT8pmnQUjDW+bSuTVhcFu1p4Lj43/ZKU8kI5FfedHLClCiedia/dUyQ4FM+OLuEae8f5YlXDM0n/5gcHhUJESyGjWLyM4KPQ0N+BY2sRkRUIgVcrJl0ufLuMKdd9izGEXmxzPSObbeSuan0EjenYlYm8nQpVabjQafiXHkITfDHNSpFDh9qID5E6NPpdnLGxLPsoX8mNPZspkOnquTC07FCLciKEtt+pZ4sUdZlqTkfrR1AbFNAwHAL97zFiTgvPodtl3KR+FQRfEN8R9c72uDLrNMPYqrPAOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5RIKH78xWGy0qxCXVSw2yzt/T21mwvG5mOluu5+xkQ=;
 b=h0EeVjnNnYXi9HcIc8hFEepan5YyWRasq8uNdj2LyIQfktuaQvGLiY9EJlKbd1PgAdlSG1Y9oQx/acCcXagRWLvJ7U4cCmoFuTT5D9RCd951rPRSfNJ/tQgqrX90ltXq5yDrbNkmptpfQuGaBkz5PwEx6aUP/wEY/JlALuZdNY3Ulk0phrvcHq/NEVbDyu5VOYEk/nDFgNPL0FnRcFVz1b7//8eMn6wceH5SJAfkwzRv1iQHdMj8QQXX5mGx2GJuWfMO9ggYWXEfC2jnlYKkpIHKY+rS6U/l3R23rU5sUYWCVcs3wvhBNTh6Go7VbvMuVfis+sBZ/pgEgKpplG/uSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5RIKH78xWGy0qxCXVSw2yzt/T21mwvG5mOluu5+xkQ=;
 b=j34p+pgbncgG8b0aZnVJgcGGFznH5XtAgIzt/Ulz8JjYLcdwFoQHVW9UFXfojr2ZRgQS1W9B2yrD7q7ghRLLgFU06PFE7AWvePjm/IvQjg/LTM8iuEwGlWxfZzHCJoX5+F/HNGbWXb4s8vOt8NAJclSk5QpU8TYycZDPXyNdhOvmGavY11xtKYpxWN0fypjR2cxgLxnq/ANYLk8KJsD6TwdPL8WdSKrYVQ8k55SdeSHOmB5Tv6kch1HeROiKcyOSK59NMOxS7OaaX+uQ4+PvebQMsqwargNsnL7MkkSC/BSrMS7CKjR1551Z938Q5fwM3St5dC662MMW9CBNAAh4JQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 16:19:10 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 16:19:09 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v2 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcZP/Xkbal+29oU0+d9XwvdstAmLUakUmAgACDCTA=
Date: Wed, 10 Dec 2025 16:19:08 +0000
Message-ID: <CH3PR12MB75483BE7F59B43A2755AD370ABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
 <20251204092245.5157-5-skolothumtho@nvidia.com>
 <0bdf282e-97b7-4942-966e-c8d8a394012b@redhat.com>
In-Reply-To: <0bdf282e-97b7-4942-966e-c8d8a394012b@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BY5PR12MB4098:EE_
x-ms-office365-filtering-correlation-id: a8174d44-ab8c-44da-579d-08de3807d900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?clZVNzlQOXkzV0Q2VG5kR1FJejU2VWNRL1Vad2NsdWxJZTFtR210bEs1RXFh?=
 =?utf-8?B?ZXVkVHJJRVRCZzNqazVSQUhtelBIN3VhY2ErNVgxcmtRakp3U29IWjhpOGpR?=
 =?utf-8?B?clAxKzVOUEc3TFd6SlY2dFlOVGZTWjgzSENET2s4LzNpdk5LSVRiY2lhS1lX?=
 =?utf-8?B?Z3k5TG1HSmVnbG1md0xkLzJHVXVCcWtJR08vZ1JsSnBmRjZHVmFza1ZVcGNm?=
 =?utf-8?B?cWFLR1M4aTZmZXdCQlUxOXpjT0hheDRoZ1ExN3Z1YzA4bGxKb3VxNUVYNTRu?=
 =?utf-8?B?UmtDcWVMZTBOM0tCMlNxdjlJbFFTNGFNR0ttM0pYYzR1RHhEVVQ1MmtSTWVS?=
 =?utf-8?B?V3l3TVJrb0l0ZlRDOWFUdnRSVXcwa0RlTHUwTGR3eFdocjJaUjA4c291U05l?=
 =?utf-8?B?SThCMWdrZ2hHK0hMRWNkSnpINnZ6Y2xEdms4MnQ0NndRQ3BGSWl3azNQditZ?=
 =?utf-8?B?RVNTVkJJWGNoSW10QThSaXREaEFCRXhEbzQxeGZVbTBubXh4Y2F1a0k0b1Nt?=
 =?utf-8?B?ZlZ0dEljUUdaWTRReldmYkZWR2hBWlc2RkJpL0syaU9vQTkxN2k0WXRmOGti?=
 =?utf-8?B?elU3WTBlUDdKRFVMZTNrNHc5VGZkT3RPSDYzcExFNS90SFhXL0JpNnB4bWxR?=
 =?utf-8?B?WjVlamVQS3ZEN24vQUdVZmd0UmhmZE0xS2ZvNUU1RzZNRjg4dGdBczI1Ymds?=
 =?utf-8?B?TTZjenpGYzNydFN1VDZKUEFsVnF2QnpEelN1bXVZS254SWJSbEpGQ3dnU0Fn?=
 =?utf-8?B?dDhZYytZbWxLTkkxd0xqSzluME5KRDBHbFBXMXBLZ2pzV0EvcmtaZGFaREVY?=
 =?utf-8?B?VkU2a0s1U1U5eEthem9Oay83bFltUTAxUk50Vjkwa3pqUG1SMnhZQ29VSmtU?=
 =?utf-8?B?bGlvU1Q1VXNsL1RzUzdwWFR2a0dLVDltUklqQllFd3gvRy9KUXBHK3ZZMC94?=
 =?utf-8?B?cXZ5ek50R3NqT2dDaTFtVHdadFhweUV2b0RxWTJHNnczeGRqZzcybzMzbS9v?=
 =?utf-8?B?T2JiUmIyVU12NE10cU9hODFSOTBPTEZUb1o3VkJHVE8zV0FFUmEvR2xkNS92?=
 =?utf-8?B?SnFOb2kyaUVqcVQ2L0VBd1BxN2p4dUEwUjJXNWVaTlc1aG5DM1E0dmJXb1NX?=
 =?utf-8?B?aXg5aVBrZVdQd1BZcm1raXVSQUlwQXdLa28wT3pmNU5acWZmT1FKZW4rbTBm?=
 =?utf-8?B?SElIYm16NEVtT2s0NHdBVERRSUZnOVdEUG9HdmNkdVpnNElPUHo0ZkI5dHFY?=
 =?utf-8?B?Lyt1enhuZld0UXpRdHBGT2xhUlJXRlR4NzBlWUw1UFEwK2JmRjJuMW15UzBC?=
 =?utf-8?B?QWc5Ly9pUGdaS1RVdDN2WDZWOHNoUW43bys2L3lBcGJVNmRuMTVJd2ZrODQ1?=
 =?utf-8?B?ZnMxNVFqb2FhbFpXNHdqZndFN3lRUW0rcG5rTmRNYzdneGY5dk9iaWU4dm54?=
 =?utf-8?B?T2dhcG5LRU5yWTFvM0xHaE9NMW9yR2hhMllOKzlhQlQxQlpya3ZLQjBESFpq?=
 =?utf-8?B?ZW5HYy9hcHEwTXJLMHBsMEdIZUNXc1AzbllJb1BRUFlVOTdEcjUxZ3V6dGJj?=
 =?utf-8?B?cTNnYUxPdW1sUUpObCs4OTZmRmJES21zSHlESkNLOHdzdC9WNTcwellXWXVE?=
 =?utf-8?B?QVRDbTVtZlVzcjVld0oyQ25EWW5CTzlJUXRJWmdGR3VSSjdNY0JhYmZPN282?=
 =?utf-8?B?eWJtdFJLajJHdHp4VFk0M25WWThLNjBHUUlydDVncUF2QVgxWlZsMmxzVE5L?=
 =?utf-8?B?RS9rK1ZMSEtTS29ySVdsVkJZWjZCZmtkcXF5WUFaVVAvVDFwcnFDT3JWQnFG?=
 =?utf-8?B?ZThTZnczd29XTnBZWUx6NkxLZm5OZUxNOUxJRC9CSWsvSGZpR05DRnFBbTV2?=
 =?utf-8?B?cVBFODI5Ukd3MVpzS0dMNm9LSnd5bThnOWs5VjNIWk1INm0rTkMya2kyVjhJ?=
 =?utf-8?B?YnlZUE5uemVqM0x6Sy9KUXRmUXJrbkJYVGVtZlNVdVh5NUVzQmU5M1pCbTFl?=
 =?utf-8?B?Z1lQY2N4SUdmOXJSUXE1NDZ4U2RRU294SHE4R0J6UnQvRjAybXh6c0liUkQ1?=
 =?utf-8?Q?cbkEid?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXU2T3AwdS9OMjk1NEtwN0Z1MFh0VjNUSTkvYStDbnFNMVBJTGpHM2tPa1ly?=
 =?utf-8?B?Vlhld0xqVnlXQWF5dkdSWHFJbW5sb2ZmZWVqZmFMSDVuTTNCTmg3SzJhM09E?=
 =?utf-8?B?OGU2ZlFNL3A5TXRQMDRaQXZjam1VZ1M1bklrNTV3Q2pyMUJlOWZTTmcwTG9q?=
 =?utf-8?B?ZEtVYlhRa0w1TVB6RnRyRXY2bzlGeVFGWHdyZnIrZmRPdFllK1pIWldxQ25R?=
 =?utf-8?B?MUFIeEhSSS9FMWRNRnpHWEY3UDEyUmJqcEo2Z3l4anZTRG9ia3U5U0tyanVB?=
 =?utf-8?B?WGNkd0Y0TW9xenFkbFYwK1FadEVNb2ZrY0RaTmNjUWpsK1ZtRkJNbE9iM2pT?=
 =?utf-8?B?ZksxZUVoTHZGTTByWDFRSUdtZDIyOEJQSU1WZGNrWVhiN0h3UkYxTHE0bDBk?=
 =?utf-8?B?YzZEWG9vR2k2Wm1na1NsbUpwNXFqYjRxcDRLM3BQejZvT1ZLclo3eDRWSnlV?=
 =?utf-8?B?VnRXY2FGL29XTlg5UEhYWmZLNDVvNnh0T2pNL2ZMQ2g0Q3ErWU9JZjNPZjhp?=
 =?utf-8?B?S2NNbHpEWVQrUnQrTmIybmMwNTBOR1hRYm53Mk9ib3hmQytQV0RWelltRlhN?=
 =?utf-8?B?dXVZTnNsM1Vvck9sRXo4VDZHekpidGx6ZithTHM3YVNuR09YdC81alBIQnJJ?=
 =?utf-8?B?VzBYRzhNNWVaUkVpMWJhNVZSQ1Y0VDNPYWdWaXRBTGZaeXlVbTUycmZCaW42?=
 =?utf-8?B?bjFXRkZSY0R2UzdmUnNuamxoemRBbXpyQkp4YStsRHNFaDkvaXl2Z0FEcFdV?=
 =?utf-8?B?NW55RWNTSmRIcVlDSUlIKzZCblRSZ1MycHppNkliSm5UbUh1ei8wZ3pXWVJQ?=
 =?utf-8?B?THFWTGo4d051M0hEY0dkUzNnN0k5UzNtSFpIYS80cHRxd0RDbzJ3WHo3Um4y?=
 =?utf-8?B?a2ZEaDVpcTdPNFh3SXFIL0JEK3pVd2hlY2gyY1hWRllGKzN4dHpIWmI3dVNw?=
 =?utf-8?B?YnpPclVKQXhuOG1raEdGMW1PSFFsd2V2VWJTOWpqSDlGSFIrNHpBeWI3aG1s?=
 =?utf-8?B?N3ZObi83OFpjK3AycUVUTk9nSk1uZzU4WFQyeG94bGtQWHZwMXF5TnFHeldh?=
 =?utf-8?B?aUZxc0htOC9CTnpsMG9ZWWcwUk9NYk5qZ015dGlKZUI4VmkvN0JrZGJiZTZX?=
 =?utf-8?B?dU03RGdINmNuV0JwaHFuNC9Md052Yk9pUHExTlNBOVVkb2RGQmtnT2paMm1Z?=
 =?utf-8?B?NWdFNHp5L3NqZE5pUWVxcDlZcno5Ynh3Y0s3R25WbS8yQmdTVC9wenY1NTl5?=
 =?utf-8?B?dEd2TjE0MDJYRlZacXdDSmhmd1prRnpoWVpxU0ZpemR6NjV1MlhCcng3dmth?=
 =?utf-8?B?RjFlbUdlNE5sV0NvTitsNHAwTFBtNGw5VFJnU201Y2dTbUFVQVNmTnNYK201?=
 =?utf-8?B?SDVyUUxzVW9RZkVWZTdQVGp3cEtwZVFyODdSM2VlRW96QWxESWRSOWc0S0NG?=
 =?utf-8?B?cGRPcmJLNy9EMTlhY0tjbmRtejhBZ3FhRUprTHRKcG5sMHFwS0EvU0Y5cXpL?=
 =?utf-8?B?b0pPMHZGWlFJT3lpR3ZEUDgraDJRaGtKdHlHN2Zwb1dBMGt4M2xleDZrYUpB?=
 =?utf-8?B?dGRvdUZoYjIyMW1jUTkvcU5jN3RtbFIxbTZUb081VW5qLzhFanZhaWZvMm5R?=
 =?utf-8?B?T1kzUXNPY0oxdmowWE5zVVVXQUpEVWhqYUVWaC9ud0RqQkhWWTA4M3NkMW9B?=
 =?utf-8?B?S0lpdElPYTNVZ2Jwc20vQ2RKYUs2Ky9MQndVamtHRnhURTh0V2xyOFNHTm8z?=
 =?utf-8?B?NzlwZ2tocVZEMmhqaGFuUjk2b1QvVEVvYUFDTXEvS2xFT3huUzlNZFFwOHdR?=
 =?utf-8?B?UnIxcDFLWnVQcnVlVDFQYmE2aDlkZ1FMUnEwUU1kNkhVdjl3OXpidDBlUmhM?=
 =?utf-8?B?TTNKY3RiQ0JZd2pjMWRRcldCZmhoV01mRW5jcmkvYUg3ai9PSWZYZU83UVdR?=
 =?utf-8?B?QWgzUnJOcnhUajY1RnhRWXEvZGkzMTFzNjVuSWtiZWhPOVhxbU9MWGE4dHpo?=
 =?utf-8?B?YU5kL2Jzem5HcFBtc0JVWVR6eXNZRDZRb01FUWdwZ2VFRzdHRjNmUWk5emtN?=
 =?utf-8?B?UXZPZU42RE9iSmtpVXpPVUZiNFFiMG1nWGpuNlFyb1FDSDVLc0QvZFh4QVo3?=
 =?utf-8?Q?M9m+ehsMW/fU0s5FvHFi/+9ML?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8174d44-ab8c-44da-579d-08de3807d900
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 16:19:08.9654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIB60m/UrLOaD8GsdYcZppQWkp3ne0Wu5j6rq77ljl/fsqktwl5Ts4K1SvLfg3nea1ll1xkN4FXJdc5LcDmJ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
Received-SPF: softfail client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMCBEZWNlbWJlciAyMDI1IDA4OjE5DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuDQo+
IENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47
IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgNC80XSBody9hcm0vc21tdXYzLWFjY2VsOiBSZWFkIGFuZCBwcm9wYWdh
dGUgaG9zdA0KPiB2SU9NTVUgZXZlbnRzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRp
b24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhpIFNoYW1lZXIsDQo+
IA0KPiBPbiAxMi80LzI1IDEwOjIyIEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IElu
c3RhbGwgYW4gZXZlbnQgaGFuZGxlciBvbiB0aGUgdkVWRU5UUSBmZCB0byByZWFkIGFuZCBwcm9w
YWdhdGUgaG9zdA0KPiA+IGdlbmVyYXRlZCB2SU9NTVUgZXZlbnRzIHRvIHRoZSBndWVzdC4NCj4g
Pg0KPiA+IFRoZSBoYW5kbGVyIHJ1bnMgaW4gUUVNVeKAmXMgbWFpbiBsb29wLCB1c2luZyBhIG5v
bi1ibG9ja2luZyBmZCByZWdpc3RlcmVkDQo+ID4gdmlhIHFlbXVfc2V0X2ZkX2hhbmRsZXIoKS4N
Cj4gaXMgaXQgZnV0dXJlIHByb29mIHRvIGRvIHRoYXQgaW4gdGhlIG1haW4gbG9vcD8NCg0KVGhl
IHJlYXNvbiBJIG9wdCBmb3IgdGhlIG1haW4gbG9vcCBpcywgdkVWRU5UUSBvYmplY3QgaXMganVz
dCBmb3IgZXZlbnQgcmVjb3Jkcw0Kb3RoZXIgdGhhbiBwYWdlIGZhdWx0cyBhbmQgd2UgYXJlIG5v
dCBleHBlY3RpbmcgYSBsYXJnZSBudW1iZXIgb2YgdGhlbSBpbiBhDQpub3JtYWwgR3Vlc3Qgc2Nl
bmFyaW8uIEFuZCBpZiB0aGVyZSBhcmUgYSBsb3Qgb2YgdGhlbSwgdGhlIHRoZXJlIGlzIHNvbWV0
aGluZw0Kb2J2aW91c2x5IGdvaW5nIHdyb25nLg0KDQpQYWdlIGZhdWx0IGV2ZW50cyBhcmUgaGFu
ZGxlcyBpbiBhIHNlcGFyYXRlIEZBVUxUX1FVRVVFIG9iamVjdC4gU2VlIHRoZQ0KZGlzY3Vzc2lv
biBoZXJlLA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUJRZ2g5SHpCOXlD
RF9yWWpHRlg1WkM3UlgyZTJpVnVfRlpQVTJWbS1rdWYzamZtK3dAbWFpbC5nbWFpbC5jb20vDQpU
aGUgcGFnZSBmYXVsdCBoYW5kbGluZyBtaWdodCByZXF1aXJlIGEgZGVkaWNhdGVkIHRocmVhZCB0
byBzcGVlZCB1cA0KdGhpbmdzLCBJIGd1ZXNzLg0KDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAg
aHcvYXJtL3NtbXV2My1hY2NlbC5jIHwgNTgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmggfCAgMiArKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBpbmRl
eCA3NGYwYmUzNzMxLi5kMzIwYzYyYjA0IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMt
YWNjZWwuYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IEBAIC0zNzgsNiAr
Mzc4LDU4IEBAIGJvb2wgc21tdXYzX2FjY2VsX2lzc3VlX2ludl9jbWQoU01NVXYzU3RhdGUNCj4g
KmJzLCB2b2lkICpjbWQsIFNNTVVEZXZpY2UgKnNkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICBzaXplb2YoQ21kKSwgJmVudHJ5X251bSwgY21kLCBlcnJwKTsNCj4gPiAgfQ0KPiA+DQo+ID4g
K3N0YXRpYyB2b2lkIHNtbXV2M19hY2NlbF9ldmVudF9yZWFkKHZvaWQgKm9wYXF1ZSkNCj4gU28g
aWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGlzIGhhbmRsZXIgaXMgY2FsbGVkIGZvciBldmVy
eQ0KPiBoZWFkZXIvZGF0YS4gVGhlcmUgY2Fubm90IGJlIHNldmVyYWwgb2YgdGhlbSB0byBiZSBj
b25zdW1lZCBpbiB0aGUgcXVldWU/DQoNClRoYXQgaXMgbXkgdW5kZXJzdGFuZGluZyBob3cgYWlv
X2Rpc3BhdGNoX2hhbmRsZXIoKSB3b3Jrcy4gSSB3aWxsIGRvdWJsZQ0KY2hlY2suIA0KDQo+ID4g
K3sNCj4gPiArICAgIFNNTVV2M1N0YXRlICpzID0gb3BhcXVlOw0KPiA+ICsgICAgU01NVXYzQWNj
ZWxTdGF0ZSAqYWNjZWwgPSBzLT5zX2FjY2VsOw0KPiA+ICsgICAgc3RydWN0IHsNCj4gPiArICAg
ICAgICBzdHJ1Y3QgaW9tbXVmZF92ZXZlbnRfaGVhZGVyIGhkcjsNCj4gPiArICAgICAgICBzdHJ1
Y3QgaW9tbXVfdmV2ZW50X2FybV9zbW11djMgdmV2ZW50Ow0KPiA+ICsgICAgfSBidWY7DQo+ID4g
KyAgICBzc2l6ZV90IHJlYWRzeiA9IHNpemVvZihidWYpOw0KPiA+ICsgICAgdWludDMyX3QgbGFz
dF9zZXEgPSBhY2NlbC0+bGFzdF9ldmVudF9zZXE7DQo+ID4gKyAgICBzc2l6ZV90IGJ5dGVzOw0K
PiA+ICsNCj4gPiArICAgIGJ5dGVzID0gcmVhZChhY2NlbC0+dmV2ZW50cS0+dmV2ZW50cV9mZCwg
JmJ1ZiwgcmVhZHN6KTsNCj4gPiArICAgIGlmIChieXRlcyA8PSAwKSB7DQo+ID4gKyAgICAgICAg
aWYgKGVycm5vID09IEVBR0FJTiB8fCBlcnJubyA9PSBFSU5UUikgew0KPiA+ICsgICAgICAgICAg
ICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGVycm9yX3JlcG9ydCgidkVW
RU5UUTogcmVhZCBmYWlsZWQgKCVzKSIsIHN0cmVycm9yKGVycm5vKSk7DQo+IG5pdCB5b3UgY2Fu
IHVzZSAlbSBkaXJlY3RseQ0KT2suDQoNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICsgICAgaWYgKGJ5dGVzIDwgcmVhZHN6KSB7DQo+ID4gKyAgICAgICAgZXJy
b3JfcmVwb3J0KCJ2RVZFTlRROiBpbmNvbXBsZXRlIHJlYWQgKCV6ZC8lemQgYnl0ZXMpIiwgYnl0
ZXMsDQo+IHJlYWRzeik7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiArICAgIGlmIChidWYuaGRyLmZsYWdzICYgSU9NTVVfVkVWRU5UUV9GTEFHX0xPU1RfRVZF
TlRTKSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJ2RVZFTlRRIGhhcyBsb3N0IGV2ZW50
cyIpOw0KPiBvbmNlIHlvdSBnZXQgYSBsb3N0X2V2ZW50LCBkb24ndCB5b3UgbmVlZCB0byByZXNl
dCB0aGUgbGFzdF9ldmVudF9zZXEsDQo+IGV2ZW50X3N0YXJ0IHRvIGJlIGFibGUgdG8gY29uc3Vt
ZSBhZ2Fpbj8NCg0KWWVzLiBJIHRoaW5rIHdlIG5lZWQgdG8gZG8gdGhhdC4NCg0KPiA+ICsgICAg
ICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICAvKiBDaGVjayBzZXF1ZW5j
ZSBpbiBoZHIgZm9yIGxvc3QgZXZlbnRzIGlmIGFueSAqLw0KPiA+ICsgICAgaWYgKGFjY2VsLT5l
dmVudF9zdGFydCkgew0KPiA+ICsgICAgICAgIHVpbnQzMl90IGV4cGVjdGVkID0gKGxhc3Rfc2Vx
ID09IElOVF9NQVgpID8gMCA6IGxhc3Rfc2VxICsgMTsNCj4gPiArDQo+ID4gKyAgICAgICAgaWYg
KGJ1Zi5oZHIuc2VxdWVuY2UgIT0gZXhwZWN0ZWQpIHsNCj4gPiArICAgICAgICAgICAgdWludDMy
X3QgZGVsdGE7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICBpZiAoYnVmLmhkci5zZXF1ZW5jZSA+
PSBsYXN0X3NlcSkgew0KPiA+ICsgICAgICAgICAgICAgICAgZGVsdGEgPSBidWYuaGRyLnNlcXVl
bmNlIC0gbGFzdF9zZXE7DQo+ID4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAvKiBIYW5kbGUgd3JhcGFyb3VuZCBmcm9tIElOVF9NQVggKi8NCj4gPiArICAgICAg
ICAgICAgICAgIGRlbHRhID0gKElOVF9NQVggLSBsYXN0X3NlcSkgKyBidWYuaGRyLnNlcXVlbmNl
ICsgMTsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQo
InZFVkVOVFE6IGRldGVjdGVkIGxvc3QgJXUgZXZlbnQocykiLCBkZWx0YSAtIDEpOw0KPiBkbyB3
ZSB3YW50IHRvIHJlcG9ydCBhbGwgbG9zc2VzIG9yIGp1c3Qgd2FybiBvbmNlPw0KDQpXaWxsIGNo
YW5nZSB0byB3YXJuIG9uY2UuDQoNClRoYW5rcywNClNoYW1lZXINCg==

