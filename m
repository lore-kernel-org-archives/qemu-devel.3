Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B9BCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZV21-0002sl-CS; Tue, 16 Jun 2026 10:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZV20-0002sd-3p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:44:48 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wZV1y-0004Nn-HO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpiU2kvLOJ+EtiXPpaoo++JSGjIyP3MJOhTpouGE0BVESTEMKXTZ7bK/8MOHx7l/sByCsyb4U1WdOSVC22Dw5HIb7yVPQAzGmgKEVlYFO1AA6UqYJ+nUwEMNUus3kp+RY/YjKbFemMdl42xYgR0z9Nej0QDfmWgMisg3T1Waxr7OOLqZtMA432F+mmiNcO5FgJT6mTbLIpPOm4W+XaAPCvPklUq477smAPUiUlCOCpcmGZeGLjm6pNPn0Cuj1dofarGlIdIoHkGc/37+WiwGIh/bDfKnyyf1RauSWvQUvkf8n4CgN0nXe6i4A/zf6IMIKEXbReaLcgQxw62g9/ABnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qid8Po8+RqZx5+P4ozupqpbNRubV7TnSQk1XHU58tNk=;
 b=SxLTwqNrZLmfkjTyyFHZ5dTffFrDlBUro8y1MtUsaFKnIDbB4gzcKkh/VvMbqiqolu+L8AuRw/aUyMbcAKLzVpBjGgXG2eNXkNDL8JWFf4QbLv6yBQ0+6lLhPgjIY3A+U6m4VDlzCOz6BhRQflhm6lB/ONtfbt3ZcFv2Hjaj/q/RFy1DOmw5m0Vdn3Lj+u0dI1K0ujfas7KQrY7ZVukxNerBxosLJPQBLHbovan0H0X6VZUA8f7AXszIgkh5jdP6LHp2EvV2E6qab9+cRuhPM9VAJ1Bzq3XohRCH3bqMQsnL2ezWGF+nCNll8dgWxyyat0YufCtbSvcwXWRPqBKLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qid8Po8+RqZx5+P4ozupqpbNRubV7TnSQk1XHU58tNk=;
 b=O+2OuixmYhgGRaUThXKR+TLam/ICd6SJe+8ko6SgtixrSzUQsMDqoSNcsd3eHjQyCz4YoJkur0MqlXADDOXPYwDfrKTLjWnWEG5cljG371pjq94nYtk3qfBsNiDaQfmCYkOH61CBkDOBpHyeEUlGj+qbkg3NxGg76BHSMEgkD+LJIxQDQkCvJ794HsVSktwA2N4kynfbil2k66rK4g4W7YAs9TfV0W0uUuOl4XNMdIR6n+jgHCoYrn88ImXYc/3oYkazIyVhuzGksLPKMtwJ8qsvNwB3wurm1JTgwBWm81hSMu5Xwns3rY5IVMXvS3zmMftKUFua6Zjb/hWf+8Q/Aw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Tue, 16 Jun
 2026 14:44:35 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:44:35 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, Matt Ochs <mochs@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 2/3] vfio/pci: Add ats property
Thread-Topic: [PATCH v2 2/3] vfio/pci: Add ats property
Thread-Index: AQHc/QhnN+cnYAQHlE+SSyqSzw0zV7ZBIo4AgAAdsxA=
Date: Tue, 16 Jun 2026 14:44:35 +0000
Message-ID: <SJ0PR12MB8614E9B122ED101D0E99DF9BABE52@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-3-nathanc@nvidia.com>
 <363ad338-7ae3-4dd1-a5ed-c87d76abce52@redhat.com>
In-Reply-To: <363ad338-7ae3-4dd1-a5ed-c87d76abce52@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DS2PR12MB9637:EE_
x-ms-office365-filtering-correlation-id: 6b708a13-92fa-482c-e239-08decbb5c8f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|56012099006|22082099003|38070700021|18002099003|6133799003;
x-microsoft-antispam-message-info: n3c33v/e6n5q5caUqizGm+lT2Cfyz5QAvxbG4ErBp7LmrK43ln/8bT5KTkz13glPT4Q7wK+m/9hIIN6T/X7l1YKKTnjjq0BKPXL5U1vTkj9OuEsUykgky0TocfA8OBsuApGOiiDgh9BIcQUqCUuEoQhE2ifFdz9jzU4RROQ22f37FPHGP8Pzc1ulIHY2HqrZMqFV2LVrGcmIt3h3aDSc8vpZArD+NUWOE7G0BA8iyUK7XjDzjIcCRHNQBqgRHx9Lz+BTIqdyrM5AzyHV2OGOX3flah3VUB8ThXsQuaXbMimp19NppIEAED+QS/tmMEG0SfcKfgvrNZCb5lxVuYpjOm12Ir71l6OmjbVGeIMzdU/jByw3qs5U1a3xVfT/Vz9tHGBgQIbG19qKkY/073ByBF/KQ6sFX0tSlkLF5pVSBOkduljO3OAzxpAvQ+E2NaMNOM0T6TDgBJMaGGhCZcuxMcATWL/AD9GRXVfhGmMnkJUtOuePkgJXs2urM7xxg1sZDOGi9ogxOcGvcHyrwVBgPLmoWw9NNpfqu45C2A4Y+IZPH/qjF0ve1at7qkFkV8Y+/+qPtxTnMQ4nj/FboR1fHMXDlue1DoddTchzowfK8x/E9oUZQgJs7n5kRccyPOuRrOUCduj57f5Z9PLpZDRSRgy8ZX5xpaiZGk6aAc1KkSiHnl2oYk9U2SDYNYR6XJS0w7L40r+x99wRJ4CFIEI64tnfKSgMtGP4XQsX7y/wZ/BrCkNRRGPqDFAEgwSHVQf+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(38070700021)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0t5UUtPTWppZGxHM2RNWXhGNHlqZ0ZqK2l2ZjJxeVM0a2Nybk1TejNoMlBZ?=
 =?utf-8?B?UHVtOEs4UUJJbFZaSCtBTHFVNVdWbWt6MWo4UFNZTUZ4YnloWnBDU2R1V3M0?=
 =?utf-8?B?Uk9rckdnS2pOUE9xa3FISmdQZmpxcHBpbXFPR2JDY1NGdzMxVUx5aEJDYkQ4?=
 =?utf-8?B?QmIyUXd0bS83RnZKbVB5Q2FaaE5vZS9zSHdURUttUGxLS1VRQTJxNFdDTExR?=
 =?utf-8?B?YWRFUUlZZVJEUFBpNDdROW5oRkJPN0YxVE5EbjU5ZDRtam1ZZEFua0d0MVo5?=
 =?utf-8?B?UGxKVjU1emdNajZNS2s1OVdrYmt1RWtVV0hPOXAxTVBxR2YrdkhRTzlCQkJL?=
 =?utf-8?B?N3JiZldPR2w5THVGRjJVQmxUS2FqWW42RVdJZFFHdWhQeWFJUlRWTm85Q1Jn?=
 =?utf-8?B?bG5IU2ZyVzZEbTBDRXNkSXlGekt3Mm1DaXdvM0F3NGJmT05wdXRNLyt6dXg1?=
 =?utf-8?B?Y0JzU2dnd24zQzdSYlVySnBOaS9sYUozdFVqc0xsMEFZMHBQM2tMS2ZZdTBO?=
 =?utf-8?B?b3pLbW9yZGVSSVZZaDJEYUJKZXAxZ1U2S3NnSTFSOGRMRXhzbWdyUFRZYlpX?=
 =?utf-8?B?QXQrMjdPR2ZOZXRtdVcvV1F3TkpwSnhOdjlmSTlvZG1mNEJaTnR6MzdwOVlt?=
 =?utf-8?B?cGZpK1B2NGFkSmtncjBrMWpOeG1wUlMreGxuWWt6emgyc3RXeWVWZEdQaWxQ?=
 =?utf-8?B?N205TWhKelIvV2xDRXFLZHljV3Z0TWs1Mk9JQ0dTZ25RSWd6WDhvRC9YMm5a?=
 =?utf-8?B?Tkc4cTJqZTMrano2YlkzQzkrQUxRajhaSzJFWkppZURoc3JuWU8vMllKWTVr?=
 =?utf-8?B?SzhFT1lIWEptekl5L000eTBRdHFxTDF6SEtSQ2tQenNaendlR0ZoVHdZdCtT?=
 =?utf-8?B?eXd3YzFnUDNid0FNVXlvd2p0MDJ0cFYyMmtMOWRKeDZFcCtBQXFOUVh5OXlS?=
 =?utf-8?B?ckNRd3IzczFLZm96c2NzSEJEWXE2R0RYU2NXSHdhc3hlYmNXcGY4Mmp3eXFB?=
 =?utf-8?B?bmh0L1NHZEU5L0ZhVUp5NENwVS9DeEZZeURZM3N2UDFwTGtSbmRWaFdRZkVT?=
 =?utf-8?B?WE9vaUxsUkt6cmZ3T1pUbjM1TWcxd3pBcEE1V1hCR096T2ljdy9rdkQ3Wm9m?=
 =?utf-8?B?Z0p3bHQ2UTQvdmZtek41OWNpL1d2Qk5LOXBPLzZjdFR2cEUxc3pmQURJdVZQ?=
 =?utf-8?B?RG1WaVJ6ZVRHS2lleStRbWdpNFU5TFNnbWZuZWhrZnlYZDQyQU4waWZ0dUFB?=
 =?utf-8?B?OFYyWFo2WlQzeWE4dXlSN3RBMFBmVERqenYvQU1UVjdsVDFzaGxldG5zVnRM?=
 =?utf-8?B?dDJIRTZIejdxczdzai8wUDU2ZmVTV0xkUWltODJyckFrb2hJRUhVY3BhZ0wv?=
 =?utf-8?B?MUlNRTNwSms4N29hSlU3V2RNTEpkRjEzc2F5aHV3UTcwUVlYSldTWUordmgz?=
 =?utf-8?B?NGFFa2ZYa0RnMWdSS0hRT3p3VXNaemVxTDNZVlN3UDNxYVQ5K244NklSelFs?=
 =?utf-8?B?SVdGbkNCR2U2emtKcTN3VExZR1ZOR2p3YkFuQVhJaEZia1FwVHdyTCt4cUhD?=
 =?utf-8?B?MmhGb0NkWHJ0WU52OUFRUjYwOXVSVy9ManFIT1l4VG5YSGl6YWp3S3VCWWxC?=
 =?utf-8?B?NTM5S2g3THcyMS83QytHS1FlMDhidW9yTkVLcXRNeXFzNWhnd0d2aWV5Q2ZE?=
 =?utf-8?B?YUdhMFROTm4yTUF4MFJ0RUJ5alNPVkRXbDRJRzhxOWpBSElBNFlBSHgveFhR?=
 =?utf-8?B?MXVGZk1scWgvVk1TdmJvUmFmZm1pRXNZNkx2d2U3cGs3a0V0NW9taElOVlJX?=
 =?utf-8?B?WmFXOFpBdGZQeVFtbGlpODRCejB5TWVlbEk2ZGR6SllPWkxwa2wvOVUwdHh1?=
 =?utf-8?B?ODVpSnNIRXUybEhpVnFWUU1PYnNoS3JMc3BFeUxsYlBiWXJDZXM0cFBUaWxN?=
 =?utf-8?B?VG9DY2NUL0Jpd3VrMGRaUmRxWklwSllXK2FmUmJGR0lyTW1aa09rbSsvRmxw?=
 =?utf-8?B?YzJRRHIwOVVXdi9SM25CbDhEeVRYa2FsNDhnNEZ0cHJDNlNMUFp4MkV6RkxT?=
 =?utf-8?B?ODZTbVlKUXRZMURiQlBtSjcyR0tHNTdTd0tpYjhaUncyQmtBOWxxeFJFQTk4?=
 =?utf-8?B?bEJOT3NPSjR0WlNvVWU2ZGljUFJwM3NCRmNKR3NrbWZENUkrVjJQU0lzQVZG?=
 =?utf-8?B?U1hmMUh1ZmsrcHN0d21vOW10b2F4TGs2MVRFZHFTT0ZNeE8xdUk1OElVMGdo?=
 =?utf-8?B?N21ocWMxZ0lFYitJb2lMT1lFaGxzL3F6Yk1Xcms0VjlQLzBNU3dEVnJQUjBH?=
 =?utf-8?B?VW0yRFQ1WjZZek5teTc1SjlGVnhsSmJQRUxhQjk1ZWlTWmJqK29SZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b708a13-92fa-482c-e239-08decbb5c8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 14:44:35.3877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6t4YDF2UnKZdPjiiPhxvHw5m/V6ao4BuBFieN9SDfoEPAIZSnAuMt8QPGWWJb7sB9J/y/b3KSussMTb7BHFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxNiBKdW5lIDIwMjYgMTM6NDgNCj4gVG86IE5h
dGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
Q2M6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPjsgRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPjsNCj4gWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGlsbWRAbWFpbG8uY29tPjsgWmhhbyBMaXUg
PHpoYW8xLmxpdUBpbnRlbC5jb20+OyBBbGV4IFdpbGxpYW1zb24NCj4gPGFsZXhAc2hhemJvdC5v
cmc+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4NCj4gPG5pY29s
aW5jQG52aWRpYS5jb20+OyBTaGFtZWVyIEtvbG90aHVtIFRob2RpDQo+IDxza29sb3RodW10aG9A
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNdIHZmaW8vcGNpOiBBZGQg
YXRzIHByb3BlcnR5DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDYvMTUvMjYgMjI6NDgsIE5hdGhhbiBD
aGVuIHdyb3RlOg0KPiA+IEZyb206IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+DQo+
ID4NCj4gPiBBZGQgYW4gImF0cyIgT25PZmZBdXRvIHByb3BlcnR5IHRvIHZmaW8tcGNpLiBXaGVu
IHRoZSBkZXZpY2UgaGFzIGFuIEFUUw0KPiA+IGV4dGVuZGVkIGNhcGFiaWxpdHkgaW4gY29uZmln
IHNwYWNlIGJ1dCB3ZSBzaG91bGQgbm90IGV4cG9zZSBpdCAoYXRzPW9mZiwNCj4gPiBvciBhdHM9
YXV0byBhbmQga2VybmVsIHJlcG9ydHMNCj4gSU9NTVVfSFdfQ0FQX1BDSV9BVFNfTk9UX1NVUFBP
UlRFRCksIG1hc2sNCj4gPiB0aGUgY2FwYWJpbGl0eSBzbyB0aGUgZ3Vlc3QgZG9lcyBub3Qgc2Vl
IGl0Lg0KPiA+DQo+ID4gSWYgQVRTIGlzIGV4cGxpY2l0bHkgcmVxdWVzdGVkIGJ1dCBub3Qgc3Vw
cG9ydGVkIGJ5IHRoZSBrZXJuZWwsIGZhaWwNCj4gPiBkZXZpY2UgcmVhbGl6ZS4NCj4gPg0KPiA+
IFRoaXMgYWxpZ25zIHdpdGggdGhlIGtlcm5lbCdzIHBlci1kZXZpY2UgZWZmZWN0aXZlIEFUUyBy
ZXBvcnRpbmcgYW5kIGFsbG93cw0KPiA+IHZmaW8tcGNpIHRvIG1hc2sgQVRTIHdoZW4gdGhlIGhv
c3Qga2VybmVsIHJlcG9ydHMgQVRTIGFzIHVuc3VwcG9ydGVkLg0KPiA+DQo+ID4gSW50cm9kdWNl
IGEgbmV3IGNvbXBhdCBmb3IgdGhlIGNoYW5nZWQgZGVmYXVsdCBmb3IgdmZpby1wY2kgZGV2aWNl
IEFUUw0KPiA+IHByb3BlcnR5LCBmcm9tICJvbiIgdG8gImF1dG8iLg0KPiA+DQo+ID4gU3VnZ2Vz
dGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgaHcvdmZpby9wY2kuaCAgICAgfCAgMSArDQo+ID4gICBody9jb3JlL21hY2hpbmUuYyB8
ICAxICsNCj4gPiAgIGh3L3ZmaW8vcGNpLmMgICAgIHwgNzQNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92
ZmlvL3BjaS5oIGIvaHcvdmZpby9wY2kuaA0KPiA+IGluZGV4IGMzYTFmNTNkMzUuLmYyOTM0ZjJk
ODQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9wY2kuaA0KPiA+ICsrKyBiL2h3L3ZmaW8vcGNp
LmgNCj4gPiBAQCAtMTg4LDYgKzE4OCw3IEBAIHN0cnVjdCBWRklPUENJRGV2aWNlIHsNCj4gPiAg
ICAgICBib29sIGNsZWFyX3BhcmVudF9hdG9taWNzX29uX2V4aXQ7DQo+ID4gICAgICAgYm9vbCBz
a2lwX3ZzY19jaGVjazsNCj4gPiAgICAgICB1aW50MTZfdCB2cGFzaWRfY2FwX29mZnNldDsNCj4g
PiArICAgIE9uT2ZmQXV0byBhdHM7DQo+ID4gICAgICAgVkZJT0Rpc3BsYXkgKmRweTsNCj4gPiAg
ICAgICBOb3RpZmllciBpcnFjaGlwX2NoYW5nZV9ub3RpZmllcjsNCj4gPiAgICAgICBWRklPUENJ
Q1BSIGNwcjsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNoaW5lLmMgYi9ody9jb3JlL21h
Y2hpbmUuYw0KPiA+IGluZGV4IDRkOGIxNWQ5OWUuLmMwY2RmN2M5ZGEgMTAwNjQ0DQo+ID4gLS0t
IGEvaHcvY29yZS9tYWNoaW5lLmMNCj4gPiArKysgYi9ody9jb3JlL21hY2hpbmUuYw0KPiA+IEBA
IC00Myw2ICs0Myw3IEBAIEdsb2JhbFByb3BlcnR5IGh3X2NvbXBhdF8xMV8wW10gPSB7DQo+ID4g
ICAgICAgeyAiY2hhcmRldi12YyIsICJlbmNvZGluZyIsICJjcDQzNyIgfSwNCj4gPiAgICAgICB7
ICJ0cG0tY3JiIiwgImNhcC1jaHVuayIsICJvZmYiIH0sDQo+ID4gICAgICAgeyAidHBtLWNyYiIs
ICJ4LWFsbG93LWNodW5rLW1pZ3JhdGlvbiIsICJvZmYiIH0sDQo+ID4gKyAgICB7ICJ2ZmlvLXBj
aSIsICJhdHMiLCAib24iIH0sDQo+IA0KPiANCj4gVGhpcyBjb21wYXQgImF0cz1vbiIgZm9yIG9s
ZCBtYWNoaW5lIHR5cGVzICgxMS4wIGFuZCBiZWxvdykgc2hvdWxkDQo+IHByZXNlcnZlDQo+IHRo
ZSBvbGQgZ3Vlc3QtdmlzaWJsZSBiZWhhdmlvciA6IEFUUyBpcyBhbHdheXMgYWR2ZXJ0aXNlZCBy
ZWdhcmRsZXNzIG9mDQo+IGtlcm5lbCBjYXBhYmlsaXR5Lg0KPiANCj4gTm93LCBpZiB0aGUga2Vy
bmVsIGlzIHVwZ3JhZGVkIGFuZCByZXBvcnRzDQo+IElPTU1VX0hXX0NBUF9QQ0lfQVRTX05PVF9T
VVBQT1JURUQsDQo+IHRoZSBWTSB3aWxsIG5vdyBmYWlsIHRvIHJlYWxpemUgdGhlIHZmaW8tcGNp
IGRldmljZSwgZmFpbCB0byBib290IGFuZCB0aGUNCj4gYmFja3dhcmQgY29tcGF0aWJpbGl0eSBh
Y3Jvc3MgbWFjaGluZSB0eXBlcyBpcyBicm9rZW4gLi4uIFRvdWdoLg0KPiANCj4gV2UgY291bGQg
YXJndWUgdGhhdCB0aGUgcHJldmlvdXMgYmVoYXZpb3Igd2FzIHdyb25nIGJ1dCBzaG91bGQgYmUg
ImJ1ZyINCj4gY29tcGF0aWJsZSB0b28uDQo+IA0KPiANCj4gU28sIHdlIGNvdWxkICA6DQo+IA0K
PiAxLiBpZ25vcmUsDQo+IDIuIHVzZSBhIGNvbXBhdCAiYXRzPWF1dG8iLCB3aGljaCB3b3VsZCBo
aWRlIEFUUyByZXBvcnRlZCB1bnN1cHBvcnRlZA0KPiAgICAgaW4gbmV3IGtlcm5lbHMsDQo+IDMu
IGFkZCBhIGxlZ2FjeSBjb21wYXQgIngtYXRzLXN0cmljdD1vZmYiIHByb3BlcnR5IHRvIHdhcm4g
YnV0IG5vdCBmYWlsDQo+ICAgICByZWFsaXplLCBhbmQga2VlcCBBVFMgZW5hYmxlZC4NCg0KSSB3
b3VsZCBnbyB3aXRoIG9wdGlvbiAyIGFzIGZhaWxpbmcgdG8gYm9vdCBpcyB0b28gaGFyc2guIElm
IGhvc3Qga2VybmVsIGFscmVhZHkNCnJlcG9ydHMgQVRTIE5PVF9TVVBQT1JURUQsIGd1ZXN0IHVz
ZSBvZiBBVFMgaXMgYWxyZWFkeSBicm9rZW4oc28gaXQNCmRvZXNuJ3QgbWF0dGVyIGV2ZW4gaWYg
d2UgaGlkZSBpdCBhZnRlciB1cGdyYWRlICkuDQoNClRoYW5rcywNClNoYW1lZXINCg==

