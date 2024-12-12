Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC053E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLndx-0003A5-DD; Thu, 12 Dec 2024 13:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLndo-00037V-7p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:10:25 -0500
Received: from mail-mw2nam12on20610.outbound.protection.outlook.com
 ([2a01:111:f403:200a::610]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLndl-0003Bo-FJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spQFAuta4sZPUXFIJqYtvd0icWD9SkJZkkSHB/vBhNKTOkULX7WOntpxT6I7KFmjlIaRvANKjNgNyXQJC5AlsvT3yxVTiVUAXV6uvDzS2wms9tn173VEy3AHvI3K113ECYFAtJawm7HCmCZbbG4ZoEPaoQIE7OxSDEhIIRA6qHdj9IlI2pzMqnW+hU8ZmvFp0qJ4hk2m7kKyaxeMqpkA8b1q9dLeZtkkRqfFpDSQF5IrH/21k61xfnVLO4Qgt7VUXWCp7l77up3si8QmRbCzBaMctvxeitLjBWKt40LSjFANLXn/k4+kD0nWyRVNHZitCfUIDHuJMplJDivIvey9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTQQvB1MFn9/q3er7C1p6gboCNeIn7x73nec5Lboqzg=;
 b=tWjWTugnF6CEg5iopkbHgmvCU08cNVzq2fqwPuEJLQCyQhSayls1xYopJEt3lnPXs2irIkyjERNlCTvaTo5D1N5I/PnRUad+Wd8EeDQw7CAgr1o9nu1khMAJPty1gJcvKzl84lox2PnIq8cgQqtT2YAsUXFLfoq9CNyOCEZp/W7GlC4xg5u2bFBhxIF8sdLiR5pX+v5jb6h/m0TWW+p/p4e+3sNWgsOyp3jU3NKV8KBZp3U689AU+5L953EBgibD6Ju4y104f/Vrn6bw1ar1aVylURvAKZyGUR0Ur8X02Qz/gqGqgH3Dqniss17gaEP33FN1DTn/tj/+LaFQSbOzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTQQvB1MFn9/q3er7C1p6gboCNeIn7x73nec5Lboqzg=;
 b=QLDVJ/ELiHVUgDrS0NCtYjSc2J2FuKHVkeFc8f2JqheUu/N3VdBprnaMD+pIlpVtKyxbhmX1C/zXPdyf9DRe3crRVqtPboeCuD78GM7xH6GA0SPQ7xS18FyE2olDt30DWkFrbKz/tyCW3eLjpHq0agflX6sBe8sYMzcLXjf7C0MVKuKANcrJQbFapvNbLJncgmkD3jghnSYzc6ZQ9g35tPsaWvF5gsQvtwltUhtWQLWVqDpmPktjE4pB3cPuzmF+jHtfzu3Ge58sJUsMY6rY1s5HrXmPQeJPDn/3QaIdLjlTNyMJnk2BMVEygjvB90w0Jcak8E5tUkiEdvpNEtHRPA==
Received: from PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 18:10:13 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 12 Dec
 2024 18:10:10 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%4]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 18:10:10 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>, Andy Currid
 <ACurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, Surath Mitra
 <smitra@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH 0/3] Introduce CXL type-2 device emulation
Thread-Topic: [PATCH 0/3] Introduce CXL type-2 device emulation
Thread-Index: AQHbTJZ0G41BzI2+Dkac88XSNwFEobLi0mWAgAAWlwA=
Date: Thu, 12 Dec 2024 18:10:10 +0000
Message-ID: <7c8c7dd1-2e57-4a65-94f3-46ef6482474e@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <eb417797-04aa-3572-02cf-5b858866edc7@amd.com>
In-Reply-To: <eb417797-04aa-3572-02cf-5b858866edc7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|PH7PR12MB6739:EE_|IA0PR12MB8837:EE_
x-ms-office365-filtering-correlation-id: b3a369d6-b9e2-434b-7ce5-08dd1ad837c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZUxFSDdEb2Z3YmhEVit4UVIwTmVWK0h5a0pONCszK2dtR21TTzBpT01INW5J?=
 =?utf-8?B?ZFE3R2o5ak5iSnpUbkxWZTBUYm1MeDdValY0dC9FbFZlakZZekw0Wk5FVkhC?=
 =?utf-8?B?NmhTbkxPSkg5YVV0Ylc0THNUb0RxdGlpeEVIL0RvaU9TYW1TUHVJalNoMVVk?=
 =?utf-8?B?Y240R1JHdGpSY2VGTFQ3M2tERVN5MzFXbGo4TDVISnpSYmU1cEVWUW5KNmNV?=
 =?utf-8?B?Q015M2h1N1VSWTc3THo5OVhOenVhMi8wQXlYQUdVNWxHS3g0YUlFWml1d2Mz?=
 =?utf-8?B?SWlrTVBqTzR4Y2pDZ1FsZTdxUlA3MVM4YURqbzhkMkRzd2s4MXhiVTZoLzF2?=
 =?utf-8?B?cndwREVjM1NkVUdwemhIbUpvWUo0akFlTG9zOWJ5Z1haZmdCVVJUbytSOWZq?=
 =?utf-8?B?N2ZmY3VpWWdkMjNZL0Uxbm1aOUxrcEt5MEpGSzhtamMzVEluaFg1d1pBZDI1?=
 =?utf-8?B?elRyZTN0dUdybU5SUUp0VXpDeGRwN2prOWFJUUZYWUtIWDBPNE5jNUNIYVhP?=
 =?utf-8?B?TmtBSllDWCs2RGdYWDJleU95akw4SnQwN1M3dEdFc0R4aFdUOExtRHk5blNQ?=
 =?utf-8?B?S1VNYnVTYy9iRmZ3VVZDaFlkRDJscE5JQTV0V0JHNDd3UTlpK3I3MjVVYXoz?=
 =?utf-8?B?cVVRZi9MeTNlSE1HQmlaRmZLRk51U0cyUXF3a0NQQ0hWVm0ybkFONG95bVNB?=
 =?utf-8?B?V095RFo0VTQ3UDhKblRReWNsRTVVbWQzUUN5MUx0TXlvTWpmd2IyL1NnZXlF?=
 =?utf-8?B?cEV4b0QyTE1pdW5PNGU1UXN4WTltMWUwQndBdFA4SC96b3ZGeUtRWDJxTkNL?=
 =?utf-8?B?WXVhQk81N3BBaHplL21sNkFnUUMwWHpvN2Q3eGlWeG9XZFU5M051SFh6TnE5?=
 =?utf-8?B?NGs3SXd3WUZhaVJOUHVEQzMvcHVBTUIxQ3dnS09aYVZvN3dNdFkwNmp6OHJi?=
 =?utf-8?B?ZmxOcmt6MXRPN0dDNFQxWjVXazNrYVJsbXVuUU1CRGd5ODM5RVlhbGxLenVx?=
 =?utf-8?B?OWRXQllaZ09mWnZiWVNpUVZEaWhxdktNVnRnOWdmdElsVDRFcXVGblRxUXh4?=
 =?utf-8?B?VEtFbWpoeWh3QU15cWs3UVJoNnEwbUFsVmh6QTFMTnpQd3RyTFJTeUI4Tm9j?=
 =?utf-8?B?K2dHY0p5MGZ5SHpnYjZ4TkYrSWVIMGFUSjkyeWs1MXNtTFA5S0Z1VUtHTnQx?=
 =?utf-8?B?M2FockZ0NUpKZkt5ajRhM29qbWp1Z1Q0OVkxUDhmN0c2Mi9jc3JFMk1VYnZv?=
 =?utf-8?B?ZWMwMHEwNjlCVURHUFQ2MzlyZ1R2KzY0a2JKQWorb2NDWEsvV2dtbmU3TEEz?=
 =?utf-8?B?WEJ5NkZHRlNyRmUraTJRbEhrUEt3cm56elpFMitiRTJqREgzaitHUlZtalZo?=
 =?utf-8?B?Y0h5K2kzT3AvQ1ROeC9zQ3hPNnNNSWN3VEc2cmI5dStJYXJPMjdmMlJkM3dP?=
 =?utf-8?B?UkhEemEvVGJYN3JQOCtRdGlqUElROHVwQVhyTHhKMDJ6ajJ1N0IvQmg4REF3?=
 =?utf-8?B?cjJFakN4N0R0M1lxNkwyVHlmZUhWUFBMcENtbXgwYzZQRzh6ZnZBeGZpMFRj?=
 =?utf-8?B?VDhZencrRmtFRHBtaWsrbSsvZnFpelI3djFFTktaTzRIa0d5SktVdjY5bWlG?=
 =?utf-8?B?Q0FRZDdtQ0VtZ1p5cXI1c1VqQUhSMytTdTJUbEttTlY1WmErTUZzbjZqQTEv?=
 =?utf-8?B?K0d5K2hrZEM3bWp1UkpQZWhJY1FVOVZlVml3UDN5c0FvSlVwWm5IQzJrVlJl?=
 =?utf-8?B?a3pxMk9kZWJKa09IT0U0NXdIci85WkJXN2xWdFdGK1V3dzhEb0pMemRzT0NR?=
 =?utf-8?Q?pXbF1J5wjpiEWb+MOgKfBKZD26jFhkdnhLSFA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3RpZ3R3RlBhSlVhVHBqQllXZDdEeEg1dXlXT3I1dGhDMDk1VHhOc25qTnBp?=
 =?utf-8?B?N28reUZTRTZUSHo3bVBmMERCVGh2REtsNjRzdno5SVdRZzQ4NVZlU3VtNDFx?=
 =?utf-8?B?RzBiU1pPOU85aEhDam1PWE5tNFMzOXdWU3pxTERnQmM5TVUrNGhmdDB1VllQ?=
 =?utf-8?B?ZlpYcU1HVGtoWUNjcUFmTnFHelBnMlJYdVlZVFI3WXJSbXJyWlRwVEwvSTdD?=
 =?utf-8?B?MS9GNVlmdHRDaFljRlBZVkdlaGpCY2FaY1NTeFdIa2k5Y0t6MzJhbEFLV3pi?=
 =?utf-8?B?VnVjM0lDRVVNWG94elFiQkNrZWFNWmYxdTlTT2FOKzFRNWpkWFFTZW5oTkZC?=
 =?utf-8?B?Rkk4Rm9VdlhYMEdKOHBrVDJzR0hYaDAvdnEwTmZJNzRCMXJjT2JDSHIzVXFE?=
 =?utf-8?B?UTRVZmd5MW4ydjRkck1vMjRaRXhlNnZJZW03WSt1RDBWV3VIeTBjc3F2aHVD?=
 =?utf-8?B?b1M4NDJjSGpQSktqN000U2p3UEJ4ak55SHl6dzV6RVl6d1NPOE90SjJhTUlw?=
 =?utf-8?B?czI1VjlDNmM3dWw2RGpNWk5JN0hYWHN0SUQ3WkptdTBZVzZ2NDZEalVTcllG?=
 =?utf-8?B?NXFRRUhocG5YdFpvM1o0cS9yeEFZRnJIa2JWbmpmMzA3VmFWWlBVZDZpWkxE?=
 =?utf-8?B?VFc4NHNSc28xRjFQSzBYR25rMU9vVVNHVElpTnlqSXhOVmdVVUUrbDdsNjJa?=
 =?utf-8?B?ZFlQbnQwLzNLVlF0MjhlUU5hWHo0d0NLUVF5cHk0a2FTa3grMTM3eHBxMHFj?=
 =?utf-8?B?aGFzb2kwOTBHQ01PVzg4R1pFblB6b3A3Qm1VZmpBbThuZFdJcUprdVRva2Vx?=
 =?utf-8?B?ejUrWnVaekticTM0WCtEWW01SnV2WFl0NldsU3U0dFBqaS91WHgyZ1NaTzVQ?=
 =?utf-8?B?NmpoUytJcmc5N3FsWFFTbHdTdUlZU0NMalVteW52Y3R4VjV6cmNLdTJHZ1l1?=
 =?utf-8?B?T1NVNDRJdXRWSVZ4OUdXTmVJdzlyRldvMXR1aGJoTGp1SXJ4TzRqcWFLdzRD?=
 =?utf-8?B?aCt2a1UvUWxwbFBmSHJwSXFjZUVuZ3Q5RVRITmFJUHhvSFAwejZXK2k2MFdM?=
 =?utf-8?B?YTVVakRMSW4zaHFXVWFWdktkeEJhdUFXRkRBWEc0YU41Qi9qSFBwSFdBR09E?=
 =?utf-8?B?ak5RS1RKV01YbE1hby83Ky9POThMN21IMytqVGRVZVFod0FLK1BPU3ZhdldG?=
 =?utf-8?B?Rkk3NDJxVUhRdnEyY0ZVRTMvTmlDVFlXZVRIaG1ZMTEramJKOXp4UkNXM1dR?=
 =?utf-8?B?VnljUHlaVFJSemJESVZ6VTVaSkwxUC90NHZzQWtKZVRRbHR1SkoyM2Mvak1O?=
 =?utf-8?B?c3psdDhaZk5UQTg2WTdRbVV4SmJTN3YzT01JanJiZzBoL1dxQlhValBDR2RE?=
 =?utf-8?B?Ynp5VWpnNnZzR0FSdVgraXlkbHc5Y2ZNVTdMSGdHTWVsN3IvUm91bWdDNWhC?=
 =?utf-8?B?MHBEMFRvNnRWSDUxUjJyVWlLYmVWRm5sT2t6QnpRTXVxYTRXaTJIVnNrWHho?=
 =?utf-8?B?WjZjSUZJYVNpUTBHbDJ5bklvYmdSZnI3VnFGTXFTMVdRQzB5YWp1QUxFeDlx?=
 =?utf-8?B?c1JrL0ZobnJDR0htOWcxVDVTdVpzVVBTcVFqZDFGQkJXSzZwNjRrUVF4NCt2?=
 =?utf-8?B?S3lpTkpyM0xvOGdwTkNGLzJHcXJ4TXQza2ttR1pqK0MvSElJRW8yeEpOT2gx?=
 =?utf-8?B?ZlBQT3NCa01RRldoZE5tNUFWVmFPOU0vbjEvTVR6VG1EbzMxNFFsZEpyMElh?=
 =?utf-8?B?d3Jra1R4aVgrZ3dKd01qT0I4dmZELzlGd3BzTzdydWVkdlA1WTJ5K0EzWXVB?=
 =?utf-8?B?L3crTXpibzBHRWh6Ri8yZnVpQk1RNnY3OWVLa3gzQjdPcFJGYVRWa0xIUytP?=
 =?utf-8?B?T0VaV3RNRjNuRFNXTXVLeHVUVjZrSXJyWHo0ZTdWUWVDaFZ4K0MyT0I1RnRK?=
 =?utf-8?B?TkhEL1UwWmRMaU55emg5TG1yTDJQVEF6UEtzRjZkZGJEd2QxYXRZRzJXc0FW?=
 =?utf-8?B?ZzZtL01nZWN3QUtwb2NHaDJHblJhSDhZdUIrVDdNY050WjZCNFcxQlNUbUNu?=
 =?utf-8?B?NTBucW4wKzBjelh3R1liNWI4RzVqUElWT1BDREZTbm9wWGdqU1htcXlxTlFi?=
 =?utf-8?Q?Dx68=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA08B534D55FAA478CB9D90FC9554248@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a369d6-b9e2-434b-7ce5-08dd1ad837c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 18:10:10.6646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLzRg/+W+0NLodRarZQWy0Jsrwue40P4I4b7IJJbVc9lPqAOz3sRtqKn2PMkgH8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
Received-SPF: softfail client-ip=2a01:111:f403:200a::610;
 envelope-from=zhiw@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMTIvMTIvMjAyNCAxOC40OSwgQWxlamFuZHJvIEx1Y2VybyBQYWxhdSB3cm90ZToNCj4gDQo+
IE9uIDEyLzEyLzI0IDEzOjA0LCBaaGkgV2FuZyB3cm90ZToNCj4+IEhpIGZvbGtzOg0KPj4NCj4+
IFBlciB0aGUgZGlzY3Vzc2lvbiB3aXRoIElyYS9Kb25hdGhhbiBpbiB0aGUgTFBDIDIwMjQgYW5k
IGluIHRoZSBDWEwNCj4+IGRpc2NvcmQgY2hhbm5lbCwgd2UgYXJlIHRyeWluZyB0byBpbnRyb2R1
Y2UgYSBDWEwgdHlwZS0yIGRldmljZSBlbXVsYXRpb24NCj4+IGluIFFFTVUsIGFzIHRoZXJlIGFy
ZSB3b3JrIGN1cnJlbnRseSBvbiBzdXBwb3J0aW5nIENYTCB0eXBlLTIgZGV2aWNlIFsxXQ0KPj4g
aW4gTGludXgga2VybmVsIGFuZCBDWEwgdHlwZS0yIGRldmljZSB2aXJ0dWFsaXphdGlvbiBbMl0u
DQo+Pg0KPj4gSXQgcHJvdmlkZXMgYSBiYXJlIG1pbmltdW0gYmFzZSBmb3IgZm9sa3Mgd2hvIHdv
dWxkIGxpa2UgdG86DQo+Pg0KPj4gLSBDb250cmlidXRlIGFuZCB0ZXN0IHRoZSBDWEwgdHlwZS0y
IGRldmljZSBzdXBwb3J0IGluIHRoZSBsaW51eCBrZXJuZWwNCj4+IMKgwqAgYW5kIENYTCB0eXBl
LTIgdmlydHVhbGl6YXRpb24gd2l0aG91dCBoYXZpbmcgYW4gYWN0dWFsIEhXLg0KPj4gLSBJbnRy
b2R1Y2UgbW9yZSBlbXVsYXRlZCBmZWF0dXJlcyB0byBwcm90b3R5cGUgdGhlIGtlcm5lbCBDWEwg
dHlwZS0yDQo+PiDCoMKgIGRldmljZSBmZWF0dXJlcyBhbmQgQ1hMIHR5cGUtMiB2aXJ0dWFsaXph
dGlvbi4NCj4+DQo+PiBUbyB0ZXN0IHRoaXMgcGF0Y2hzZXQsIHBsZWFzZSByZWZlciB0byBzdGVw
cyBpbiBbM10uIFVzZSB0aGlzIHBhdGNoZXNldA0KPj4gd2l0aCB0aGUgbGF0ZXN0IFFFTVUgcmVw
byB0byBiZSB0aGUgUUVNVSBob3N0LiBJdCBhY2hpZXZlcyB0aGUgc2FtZSANCj4+IG91dHB1dA0K
Pj4gYXMgaW4gdGhlIGRlbW8gdmlkZW8gWzRdOiBUaGUgVkZJTyBDWEwgY29yZSBhbmQgVkZJTyBD
WEwgc2FtcGxlIHZhcmlhbnQNCj4+IGRyaXZlciBjYW4gYmUgYXR0YWNoZWQgdG8gdGhlIGVtdWxh
dGVkIGRldmljZSBpbiB0aGUgTDEgZ3Vlc3QgYW5kIA0KPj4gYXNzaWduZWQNCj4+IHRvIHRoZSBM
MiBndWVzdC4gVGhlIHNhbXBsZSBkcml2ZXIgaW4gdGhlIEwyIGd1ZXN0IGNhbiBhdHRhY2ggdG8g
dGhlDQo+PiBwYXNzLXRocnVlZCBkZXZpY2UgYW5kIGNyZWF0ZSB0aGUgQ1hMIHJlZ2lvbi4NCj4+
DQo+PiBUZXN0ZWQgb24gdGhlIENYTCB0eXBlLTIgdmlydHVhbGl6YXRpb24gUkZDIHBhdGNoZXMg
WzNdIHdpdGggYW4gZXh0cmENCj4+IGZpeCBbNV0uDQo+Pg0KPj4gWzFdIGh0dHBzOi8vbmFtMTEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vPyANCj4+IHVybD1odHRwcyUzQSUyRiUy
RmxvcmUua2VybmVsLm9yZyUyRmxpbnV4LSANCj4+IGN4bCUyRjIwMjQxMjA5MTg1NDI5LjU0MDU0
LTEtYWxlamFuZHJvLmx1Y2Vyby0gDQo+PiBwYWxhdSU0MGFtZC5jb20lMkZUJTJGJTIzdCZkYXRh
PTA1JTdDMDIlN0N6aGl3JTQwbnZpZGlhLmNvbSU3QzNhNjExMzliZjM1NTRmNGYzOGY0MDhkZDFh
Y2NmMWI5JTdDNDMwODNkMTU3MjczNDBjMWI3ZGIzOWVmZDljY2MxN2ElN0MwJTdDMCU3QzYzODY5
NjE4OTc2MTM5MDkxOSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25S
eWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lz
SWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9Nld6aUtud01sWkpRNHl4VDJqTG43
VzFTbzBPZnFZc3M3OGZPb3N1TGl3QSUzRCZyZXNlcnZlZD0wDQo+PiBbMl0gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/IA0KPj4gdXJsPWh0dHBzJTNBJTJG
JTJGd3d3LnlvdXR1YmUuY29tJTJGd2F0Y2glM0Z2JTNEZTVPVzFwUjg0WnMmZGF0YT0wNSU3QzAy
JTdDemhpdyU0MG52aWRpYS5jb20lN0MzYTYxMTM5YmYzNTU0ZjRmMzhmNDA4ZGQxYWNjZjFiOSU3
QzQzMDgzZDE1NzI3MzQwYzFiN2RiMzllZmQ5Y2NjMTdhJTdDMCU3QzAlN0M2Mzg2OTYxODk3NjE0
MTMwMzklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZ
aU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95
ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWhURiUyRjFJJTJCNGZZUFFlQ3o3TmhNMHV2V2Ql
MkZyV2ZJemFLZGN0ZUQ1JTJCcmNaMCUzRCZyZXNlcnZlZD0wDQo+PiBbM10gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/IA0KPj4gdXJsPWh0dHBzJTNBJTJG
JTJGbG9yZS5rZXJuZWwub3JnJTJGa3ZtJTJGMjAyNDA5MjAyMjM0NDYuMTkwODY3My0zLSANCj4+
IHpoaXclNDBudmlkaWEuY29tJTJGVCUyRiZkYXRhPTA1JTdDMDIlN0N6aGl3JTQwbnZpZGlhLmNv
bSU3QzNhNjExMzliZjM1NTRmNGYzOGY0MDhkZDFhY2NmMWI5JTdDNDMwODNkMTU3MjczNDBjMWI3
ZGIzOWVmZDljY2MxN2ElN0MwJTdDMCU3QzYzODY5NjE4OTc2MTQyNTY0NiU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0ls
QWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0Ml
N0Mmc2RhdGE9V3EzbXIwbVhaQ2JHM2NYUktsaWJxJTJCa3NUdXdMOFJHcWlVUzlqQkZEZkRZJTNE
JnJlc2VydmVkPTANCj4+IFs0XSBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz8gDQo+PiB1cmw9aHR0cHMlM0ElMkYlMkZ5b3V0dS5iZSUyRnpsa19lY1g5Ynhz
JTNGc2klM0RwZjlDdHRjR1Q1S3dVZ2lIJmRhdGE9MDUlN0MwMiU3Q3poaXclNDBudmlkaWEuY29t
JTdDM2E2MTEzOWJmMzU1NGY0ZjM4ZjQwOGRkMWFjY2YxYjklN0M0MzA4M2QxNTcyNzM0MGMxYjdk
YjM5ZWZkOWNjYzE3YSU3QzAlN0MwJTdDNjM4Njk2MTg5NzYxNDM3NzgwJTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxB
aU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3
QyZzZGF0YT1TUmVUbkJVQzFiSWhCd0MlMkJ2QVNDWFglMkYwbHRJWWNmV0FrSFhNbWklMkZUUlJn
JTNEJnJlc2VydmVkPTANCj4+IFs1XSBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz8gDQo+PiB1cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZs
aW51eC0gDQo+PiBjeGwlMkYyMDI0MTIxMjEyMzk1OS42ODUxNC0xLSANCj4+IHpoaXclNDBudmlk
aWEuY29tJTJGVCUyRiUyM3UmZGF0YT0wNSU3QzAyJTdDemhpdyU0MG52aWRpYS5jb20lN0MzYTYx
MTM5YmYzNTU0ZjRmMzhmNDA4ZGQxYWNjZjFiOSU3QzQzMDgzZDE1NzI3MzQwYzFiN2RiMzllZmQ5
Y2NjMTdhJTdDMCU3QzAlN0M2Mzg2OTYxODk3NjE0NDk1ODklN0NVbmtub3duJTdDVFdGcGJHWnNi
M2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFX
NHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRh
PXBtWjhKTmN0VWxjTEZ3UUxpdk5Na0hqN2ZNdDJQUjI0ZSUyQnVIWSUyQms3Yk5BJTNEJnJlc2Vy
dmVkPTANCj4+DQo+PiBaaGkgV2FuZyAoMyk6DQo+PiDCoMKgIGh3L2N4bDogZmFjdG9yIG91dCBj
eGxfaG9zdF9hZGRyX3RvX2RwYSgpDQo+PiDCoMKgIGh3L2N4bDogaW50cm9kdWNlIGN4bF9jb21w
b25lbnRfdXBkYXRlX2R2c2VjKCkNCj4+IMKgwqAgaHcvY3hsOiBpbnRyb2R1Y2UgQ1hMIHR5cGUt
MiBkZXZpY2UgZW11bGF0aW9uDQo+Pg0KPj4gwqAgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4+IMKgIGRvY3Mvc3lzdGVtL2Rldmlj
ZXMvY3hsLnJzdMKgwqDCoCB8wqAgMTEgKysNCj4+IMKgIGh3L2N4bC9jeGwtY29tcG9uZW50LXV0
aWxzLmPCoMKgIHwgMTAzICsrKysrKysrKystDQo+PiDCoCBody9jeGwvY3hsLWhvc3QuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxOSArLQ0KPj4gwqAgaHcvbWVtL0tjb25maWfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICsNCj4+IMKgIGh3L21lbS9jeGxf
YWNjZWwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMxOSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+IMKgIGh3L21lbS9jeGxfdHlwZTMuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNjEgKy0tLS0tLQ0KPj4gwqAgaHcvbWVtL21lc29uLmJ1aWxkwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gwqAgaW5jbHVkZS9ody9jeGwvY3hsX2NvbXBv
bmVudC5oIHzCoMKgIDcgKw0KPj4gwqAgaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5owqDCoMKg
IHzCoCAyNSArKysNCj4+IMKgIGluY2x1ZGUvaHcvcGNpL3BjaV9pZHMuaMKgwqDCoMKgwqDCoCB8
wqDCoCAxICsNCj4+IMKgIDExIGZpbGVzIGNoYW5nZWQsIDQ4NCBpbnNlcnRpb25zKCspLCA2OSBk
ZWxldGlvbnMoLSkNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9tZW0vY3hsX2FjY2VsLmMN
Cj4+DQo+IA0KPiBIaSBaaGksDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGlzIHBhdGNoc2V0
Lg0KPiANCj4gDQo+IEnCoCBoYXZlIGEgc2ltaWxhciB3b3JrIGRvbmUgZm9yIGhlbHBpbmcgaW4g
dGhlIFR5cGUyIHN1cHBvcnQgd29yaywgYnV0IA0KPiBpdCBpcyBhbGwgcXVpY2stYW5kLWRpcnR5
IGNoYW5nZXMuDQo+IA0KPiANCj4gTXkgbWFpbiBjb25jZXJuIGhlcmUgaXMgd2l0aCB0aGUgb3B0
aW9uYWwgZmVhdHVyZXMgZm9yIFR5cGUyOiBob3cgdG8gDQo+IGNyZWF0ZSBhbiBlYXN5IHdheSBm
b3IgY29uZmlndXJpbmcgVHlwZTIgZGV2aWNlcyB1c2luZyBzb21lIHFlbXUgY3hsIA0KPiBwYXJh
bS4gSSdtIGFmcmFpZCBJIGRpZCBub3Qgd29yayBvbiB0aGF0IHNvIG5vIHN1Z2dlc3Rpb25zIGF0
IGFsbCENCj4gDQoNCkhpIEFsZWphbmRybzoNCg0KTm8gd29ycmllcy4gVGhlIHdvcmsgaXMgdG8g
cHJvdmlkZSBhIG1pbmltdW0gYmFzZSBmb3IgQ1hMIGZvbGtzIGFuZCBDWEwgDQp0eXBlLTIgZm9s
a3MgdG8gc3RhcnQgd2l0aCwgZS5nLiBpbnRyb2R1Y2luZyBtb3JlIGVtdWxhdGVkIGZlYXR1cmVz
LiBBcyANCnRoZSB0eXBlLTMgZW11bGF0aW9uIGhhcyBiZWVuIHF1aXRlIGNvbXBsaWNhdGVkIGFu
ZCBJIHdhcyB0aGlua2luZyBtYXliZSANCmhhdmluZyBhIGNsZWFuIHN0YXJ0IHdvdWxkIGhlbHAu
IEZvciByZS1mYWN0b3JpbmcsIEkgd2FzIG1vc3RseSB0aGlua2luZyANCm9mIGEgc3RlcCBieSBz
dGVwIHN0eWxlOiBFLmcuIHdoZW4gYm90aCBlbXVsYXRpb24gb2YgZGV2aWNlcyBhcmUgDQpyZWFj
aGluZyBhIHBvaW50IHRvIGhhdmUgdGhlIGNvbW1vbiByb3V0aW5lcywgdGhlbiB3ZSByZS1mYWN0
b3IgdGhlbSBvciANCmRyYXcgYSBnbHVlIGxheWVyLg0KDQpBbHNvLCB0aGUgcGF0Y2hzZXQgaXMg
Z29vZCBlbm91Z2ggZm9yIHBlb3BsZSB0byB0ZXN0IG91ciB3b3Jrcy4NCg0KSWYgZm9sa3MgYXJl
IE9LIG9uIHRoaXMgbWluaW11bSBlbXVsYXRpb24sIEkgdGhpbmsgdGhlIG5leHQgdGhpbmcgd291
bGQgDQpiZSBtZWFuaW5nZnVsIGZvciB1cyBpcyBhbGlnbmluZyB0aGUgcGxhbiBmb3Igd2hhdCBm
ZWF0dXJlcyB0aGF0IHdlIHdhbnQgDQp0byBwbHVnIGludG8gdGhpcywgc28gdGhhdCB3ZSBjYW4g
c2hhcmUgdGhlIGVmZm9ydHMuDQoNClRoZSBpdGVtcyBvbiBteSBsaXN0IGFyZToNCg0KLSBMb2Nr
ZWQgSERNIGRlY29kZXINCi0gQ0RBVCBhbmQgRE9FDQoNCkkgcmVtZW1iZXJlZCB5b3Ugd2VyZSB0
YWxraW5nIGFib3V0IHRoZSBjb25maWd1cmF0aW9uIHBhcmFtcywgSSB0aGluayBpdCANCmNhbiBi
ZSB2ZXJ5IGhlbHBmdWwgb24gcHJvdG90eXBpbmcgZGlmZmVyZW50IGZlYXR1cmVzIGluIHRoZSBr
ZXJuZWwgYXMgDQp3ZWxsLiBGZWVsIGZyZWUgdG8gcmVhY2ggb3V0IGZvciBkaXNjdXNzaW9ucy4N
Cg0KWi4NCg0KPiANCj4gVGhhbmsgeW91DQo+IA0KDQo=

