Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9DECD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfXd-0001FJ-1K; Mon, 22 Jun 2026 10:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wbfXV-0001D6-EJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:22:20 -0400
Received: from mail-northeuropeazon11021131.outbound.protection.outlook.com
 ([52.101.65.131] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wbfXT-0006q4-9Q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZb/n5ZxQvToT2+cC/uXqtN2lxFZBVdCFLcuNLIVKPBC7E/0cfMFwt/et5+59cEafPZf/XKTXs9mQfc2HNvpta5Ih91wpGHLVqvpvmvIVvnsv0h880qh1Pn3eRTKywBVpNsS6MzAFAqR26fPpvqlfWjuzS2w/YwTIkVsWsbimNyc7uwU/F5HTM/4DGh849QSjDKVMiD2ITK5MAke3P4kYf/pWpoUzpG3CS9G3HTbfRTuPLteyjDqYlQ9o5N/kRVPQ83QlGGC35NDHq44aLmgPMsRt3O1jv+VjhtaJb6t2bS2zQK7tT/Pr/GzUCqYSXZTvul0Tw2ST6nP91uWio1jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HV3V4qyp4YS+Bm4AUM6r8AlOuMHJBRKU5v5D/LXhZw=;
 b=Zm+pAMO1cl1x9Hbw4O4teubxZOXm892xQAXoXJW3ageB26xGqDOHxTwOeSNDHcIHdoFK2y+PpKzoD6FecMVO4s07akxBKAVOOgR53vChuhWDWevyusXG2tkLJt06+LhJDSU9u67Lsvn5MDogD10yzWPAKTaqiZJlZPDQx2RA8VpAbzoHOAO6qoIM+EcJzip/BlJ8KMo2tFxG6dvUoA+icc6z2KlWOnmECaN+ODx3As45CxmAf4zdVIGDxepnFiBclXCnoYc0WX8TTg8LlFIDQP7Kbm3myATyHQuwQ3mDPUJ5RyzH1GWCTaybgGwzlxmLnmQIT+RlT3GyliplbsPqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HV3V4qyp4YS+Bm4AUM6r8AlOuMHJBRKU5v5D/LXhZw=;
 b=I07vaXDr2j0fPT9hCDzQclK9FSUDjK06GJVHxI1a8VeEZZ1ktjSgmU5nBixN90VIDYp/5bGVhU7AAnfZrMOjdb/8qj+HiZkdkwsogUKaIHJl/z0Y8Hq7Wabs5AdUhnW8NFl9TST3lTLWRMPBReqpyh0YBZY714T3hk6+UaUxwGLq5QrE/CncHMFGvB5cCF3tsLt6tVjOFEjQrz9In6080SrrWWIbYCQ9P8BDAcsd6zhzLhXHdE9przer8m1Ykn6+QA/b0ONUJHR0cc0gaF/TzZptFbccVu2wzY+L5jMd7gUXqoF0QbJCq60aBkse2ZKRDAnQVVkgw6oOdG8NjroobA==
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20) by GV2PR08MB9328.eurprd08.prod.outlook.com
 (2603:10a6:150:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 14:17:04 +0000
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774]) by VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 14:17:04 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "kkostiuk@redhat.com" <kkostiuk@redhat.com>
CC: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Andrey Drobyshev
 <andrey.drobyshev@virtuozzo.com>, Den Lunev <den@virtuozzo.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@mailo.com"
 <philmd@mailo.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>
Subject: Re: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
Thread-Topic: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
Thread-Index: AQHdABacCxErlGxqWEGOmRzs08qGLbZKSxmAgABYUYA=
Date: Mon, 22 Jun 2026 14:17:03 +0000
Message-ID: <3fc4bc652795f349d0f82bd30c7aaac9323fd14f.camel@virtuozzo.com>
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
 <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
 <CAPMcbCphbipUTQm5d+A3hPJMLXVo3jBVxxzCii8axjTyQtBGSQ@mail.gmail.com>
In-Reply-To: <CAPMcbCphbipUTQm5d+A3hPJMLXVo3jBVxxzCii8axjTyQtBGSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR08MB10828:EE_|GV2PR08MB9328:EE_
x-ms-office365-filtering-correlation-id: a69cc97c-e1b7-4185-8fd7-08ded068ef1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: VJwmYgoACUSgHBGXncXj8hHivy0lb80kQ00U8Q2nSL2TGbuLYo2d4ysw/Em3Hh3At8KOSFxYFPvRvRwuF+eayrBIaRaagJBS8R0f4VbHtsjkMgrrMNQS+/O/HmGvyyIl9qjmY3raEJDZugv77iMGbbtg7emfIlIy/P3zu+CLl2J9fDw2rbU6u1fWKgbhsixMcyh6FTY+WdKA6x9Ikh0kfmS/5p4J36ji+SOuIBq40sCtdoYuA+RvrCZUaNLZQxFArRwbmADNHW4BYOcQrDGqi8kGAAOf1UM4jo/lJ1O1UkzGVvJAy7y/wa5iigt3cahNSdBFK587HVWiryC0hZxOt1PCo74SWVd/2lXxJG0MnoLSqzMwHXuMnGEXSVCSntXLmMvaAw0AqTs+4x4CcsY2nAL3W0i8RlutSlgrxtWuNfnN5pKmaKbqKmU3MbDN97s+XzdqyRqYl4ZZqrIMYidh6jfiZtzcG6/Bqm9e6FqAlSUPBpwTKrO5W5bFHPL2HJErmBeqD0fM1JofYFvzTb20GGfxoPGwXVI2LqDh2QkTEvTs9ECOpoq1IODjmz2yRk50GqvuMKnyGTJG4QoFSyXdabIaNN22yIh95vLWxFwkRYbYMwM/JLzOv6FBFfdXoBPptjScEwKj9X17Tz6UT4ciBxqnwXhElIJfR6xdD+rRj5Y8DVk04hfM2FcrBDSVLAuXECR+gk9k+N601K8RlCZ4PiJB5Tp9qedqst+kHEnFnXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10828.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amlJMXpreUxucnltMDQ1RTVnQmpteTRVU0tKSnJ2MlZMZWFHVGMyWFJtMVU1?=
 =?utf-8?B?NzNqb3BLZzlPalcwQ2FHMmsvSlpjcHFKbVhsUlkyczdvbTA2cHpoKzNWeWpu?=
 =?utf-8?B?MnJWWFd2VXlaV0cydlltOUJNNVNWVitmcXF2NDh0YXBJZGhYUFpJcFpaaDZ6?=
 =?utf-8?B?SDBoay93ZUZjNURlYWhUNXY0QVphcUZjYVdmaWN3a3UzeTdSdUhPRFpyWmcz?=
 =?utf-8?B?OThwQ0JYV3U3WjcxenBacUJTZFhQNHBMcGJ2RCtjYVBXd0txK1JKdTU3UkVY?=
 =?utf-8?B?U0daYjZ3YWR3Y2h6VG5ZV2x5d2JLM1JreHNlcnduNVBzTlhRWWxUN0w4VFM2?=
 =?utf-8?B?cmNnVERFeVYyc3BLRE41WFE3WWNwR1FEQndNZU9UdndTMGQ5VUJnYy91K254?=
 =?utf-8?B?Vnh0eGd0QjJwMXV1OEtpRU5Kc1Rmb2NvbHNJbDY0RzFsUmRDV1UwZ1B4bXEy?=
 =?utf-8?B?SVBCRWt6UXd6QzhldC83WXRjQ2xBU1NWTE8vTWVza1JrRFNxUjlXdWwvS0Jt?=
 =?utf-8?B?RnVkWGtqcGxKREsxWmE5dmlXcW1tSVlEcHlCQjBBOUtaTzAvL1pGbWt1QzdX?=
 =?utf-8?B?cE9MVzhPZE8vWGlnK0E2eEx3U0t1cmhNYllRNi9nV0tEQUx1SGVmeThDbUJu?=
 =?utf-8?B?ejNoMXNyOHdxc3MrRDZPeVNQZlRNNGhXNElmSkd1cFk5Uk1ET3FCOU9wUkNj?=
 =?utf-8?B?bEpJSVdyeDdxNkRURkw3R1dPaDg4STNsL1YrbVIzWnNuOVFKRzBIV0hzc2Na?=
 =?utf-8?B?VXpqa1k5SDRtejBqdEx1T2c3bkZzVlN0Sjczay9kdlBYRnFPeVBSWDV6MXcr?=
 =?utf-8?B?VnJndVdDejh1c29GQ3VLbk9rbGR2YkhLZUhOTEtpWk8vV1pGV25oSi8rNi9K?=
 =?utf-8?B?WEtDNGR0K1BQVmQxYW4wdmY2UFYydVNxcWhoRDhya3FNR2h6NmtIQWQ3OVdM?=
 =?utf-8?B?U0Z3RXRvK1ZFM0ZGZkRPait5ckZ0OHdrMnVnNGM0NWl3cVhlaDVZMyt4L0FI?=
 =?utf-8?B?QytGMk5QcUVzNWFTMW5PZWFINmJEaVNSUU0vdTIzZkdicVpoYVJjQ1lWSkxh?=
 =?utf-8?B?a20zY3NlalpYTTIzdWlZYUdwWGRWeUxjdHRyYkNWRVNMbjQ3UVVWRWlhUGtH?=
 =?utf-8?B?SjdSdFR3cGRMQXRnaitSS2ZUQzYyVUZITmJWYnB0Z1ZUL0JSd0NLY0lPUVBS?=
 =?utf-8?B?VHJkQnpHcDBOSXdiRlIwcS8xTjlaRlNrUm0rYnc5eGt2YU9BMGI5TXhCREla?=
 =?utf-8?B?eU5HQmNtM2JmdWtXMmlsRUhGbDl1L2VCa3Z3VmlHeUFTUDdNRElzeG1BVUhx?=
 =?utf-8?B?WUQ4QXZUTSt3Rm5ZL3BpR0hoeXN3MzlyaVFUTENpazA4WWdHWGR2N0llaFdT?=
 =?utf-8?B?dGFmTi95bFJYUTJoTXRMTkhZVHk5bmhZYzN0MUZBSVI0c1NrNEtqZmExRXQv?=
 =?utf-8?B?cWdnc3ZFb1RPQXRqSnZvNlZLY1kxbjN5UFVUdXBiUGlHQlBkNjczbFYrTnJV?=
 =?utf-8?B?UlBGRmQ5TVY3U3BWanhDT3I0aDE1bGlvaEkvQ0VlNTdvdUpGTlFqeklWQ1Iz?=
 =?utf-8?B?dk0ya0JDV1RJUjAvZHJKSC9rNXlDejFvaXZkTGlKSndQWUFnS2tLRm0vNkVk?=
 =?utf-8?B?YTg4S3ZVVUVac3k2U01PWXZ3S0VZdmNYK0ZvbFg3Y2FoRkJmT2tTRWtoZEVK?=
 =?utf-8?B?Q3F3QjVNb3ZJVXBJczRwTXI5WEEwVUw3SHNXTVQ1NDlnS2JiOCtaT1lwMS9y?=
 =?utf-8?B?MlJaa1B1RXR2MGF6V3JERXp3Q0pOQ1d4aHhCN2xNZW11eUI3NmJHUGRnSlJW?=
 =?utf-8?B?aXZBeTZxMkpFSitwVWRuZmN0UEZyVkRvMGF5WXJyMGxoRm4wUG1zYU9xWncr?=
 =?utf-8?B?dTJQN0E5SlRSOW5malg2d0NDQm9rd2NLYlNtenVldUJLTmlKdXN4VmNuVGFt?=
 =?utf-8?B?WEEvWndGRkR2cmdrNEF0S2dPWHZvZ3FvSDU5c0x3OWtVeEtoL2NWUmovaXlQ?=
 =?utf-8?B?enFuQ3lLSUJSNURHRzc3eHp2VzhQWDhmYTdSaW1Jam1JaUMyVWdHVFpNTzhm?=
 =?utf-8?B?SkpDTG83WkE3SnNPdzhUdHlGVU5vQUZPeHg1QzlkMTZ5Zi94L3doRG15Kzd3?=
 =?utf-8?B?V2VuWXRhdWxQRytBRUNTU1o5ajBMMmdCU2FpVmc0cW45ZkVYS2ljdU54TE0w?=
 =?utf-8?B?bytLZFFnekFVUmVpb3gwWnczcndWVUk2Wmd5bkUzdEJQNzJXS2ZPU1ZlZE9E?=
 =?utf-8?B?bEVWT1NYbjZyOGFZZE1wbUJvVzlzY3lhaHdXenNFM3NxY1RjRFBuRW1yL2xD?=
 =?utf-8?B?T0dkT2VPblQ5YWxtU0phTlNoUTd2OWVmWEg2aW1yNnhqUGZMSEdjTzNmNlpV?=
 =?utf-8?Q?ADtMj2mEVcfKTOJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C0B46441CFF9E4EBCBC491F4484B6A6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10828.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69cc97c-e1b7-4185-8fd7-08ded068ef1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 14:17:03.9629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxVTTF0WrK7UrBCzX+Z8VnThYPCGmknuXJudl+7xu5/ekGhiaKeh3wriQ3IdAwqS6FWu/UIRk4KdtbPbbSOAhmXCI7zFhEEc9k5BS3/Awew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9328
Received-SPF: pass client-ip=52.101.65.131;
 envelope-from=polina.vishneva@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

T24gTW9uLCAyMDI2LTA2LTIyIGF0IDEyOjAwICswMzAwLCBLb3N0aWFudHluIEtvc3RpdWsgd3Jv
dGU6DQo+IEhpIFBvbGluYSwNCj4gDQo+IEZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciB5b3VyIHBh
dGNoZXMuDQo+IA0KPiBCZWZvcmUgcmV2aWV3aW5nIHRoaXMgcGF0Y2gsIEkgd2FudCB0byBhc2s6
IHdoeSBpcyBpdCBuZWVkZWQ/DQo+IA0KPiBJIHVuZGVyc3RhbmQgdGhlIHBhdGNoICJxZW11LXNv
Y2tldHM6IEVuYWJsZSBBRl9WU09DSyBvbiBXaW5kb3dzIiwNCj4gYnV0IEFGX1ZTT0NLIGhhcyB0
aGUgc2FtZSBiZWhhdmlvciBvbiBMaW51eCBhbmQgV2luZG93cy4NCj4gSSBleHBlY3RlZCB0aGF0
IHdlIGNvdWxkIHRvdGFsbHkgcmV1c2UgdGhlIFBPU0lYIHBhcnQsIHNvIGp1c3QgbW92ZSBpdCB0
bw0KPiBjb21tb24gd2l0aA0KPiBzb21lIGRlZmluZXMgbGlrZToNCj4gYGBgDQo+ICNpZmRlZiBH
X09TX1dJTjMyDQo+ICAgICAgICAgaW5fY2ggPSBnX2lvX2NoYW5uZWxfd2luMzJfbmV3X2ZkKGlu
X2ZkKTsNCj4gI2Vsc2UNCj4gICAgICAgICBpbl9jaCA9IGdfaW9fY2hhbm5lbF91bml4X25ldyhp
bl9mZCk7DQo+ICNlbmRpZg0KPiBgYGANCj4gDQo+IFdlIHRlc3RlZCBvdXIgZHJpdmVyIHdpdGgg
U1NIIG92ZXIgVlNPQ0ssIGFuZCBzdGFuZGFyZCBMaW51eCBTU0ggd29ya3MNCj4gd2VsbC4NCj4g
U28sIHdoYXQgaXMgdGhlIGRpZmZlcmVuY2UgaW4gdGhpcyBjYXNlIHRoYXQgeW91IGFkZCB3aW4z
Mi1zcGVjaWZpYyBjb2RlDQo+IGZvciBWU09DSz8NCg0KMS4gVGhlcmUncyBubyBzaGFyZWQgR0lP
Q2hhbm5lbCBwYXRoIG9uIFdpbmRvd3MgdG8gI2lmZGVmIGludG8uDQpjaGFubmVsLXBvc2l4LmMg
aXMgYnVpbHQgb24gR0lPQ2hhbm5lbHMgKyBnX2lvX2FkZF93YXRjaCgpOw0KY2hhbm5lbC13aW4z
Mi5jIGlzIGJ1aWx0IG9uIG92ZXJsYXBwZWQgSS9PIG92ZXIgYSBXaW4zMiBIQU5ETEUgd2l0aCBh
DQpyZWFkZXIgdGhyZWFkIGFuZCBhIGN1c3RvbSBHU291cmNlLiBUaGVyZSdzIG5vIGluX2NoID0g
Z19pb19jaGFubmVsXyooKQ0KbGluZSB0byB3cmFwLiB2c29jayBpcyB0aGUgZmlyc3QgR0lPQ2hh
bm5lbC1iYXNlZCBjaGFubmVsIG9uIFdpbmRvd3MuDQoNCjIuIGdfaW9fY2hhbm5lbF93aW4zMl9u
ZXdfZmQoKSBpcyB0aGUgd3JvbmcgY29uc3RydWN0b3IsIGFzIGl0J3MgZm9yIENSVA0KZmRzLCBu
b3Qgc29ja2V0cy4gR0xpYiB3YW50cyBnX2lvX2NoYW5uZWxfd2luMzJfbmV3X3NvY2tldCgpIChp
dCBzZXRzIHVwDQpXU0FFdmVudFNlbGVjdCkuIEFuZCBxZW11X2FjY2VwdCgpL3NvY2tldF9saXN0
ZW4oKSByZXR1cm4gYSBDUlQgZmQNCndyYXBwaW5nIGEgU09DS0VUIHZpYSBfb3Blbl9vc2ZoYW5k
bGUoKSwgc28gd2UgcmVjb3ZlciBpdCB3aXRoDQpfZ2V0X29zZmhhbmRsZSgpLCB3aGljaCBpcyBh
bHNvIHdoeSB0ZWFyZG93biBuZWVkcyB0aGUgZXhwbGljaXQNCnFlbXVfY2xvc2Vfc29ja2V0X29z
ZmhhbmRsZSgpIG9yZGVyaW5nLCB0byBhdm9pZCBhIGRvdWJsZSBjbG9zZXNvY2tldCgpLg0KDQoz
LiBXaW5zb2NrIGRpc2Nvbm5lY3QgZGV0ZWN0aW9uIGRpZmZlcnM6IEdMaWIgcGFzc2VzIEZEX1JF
QUR8RkRfQ0xPU0UgYXMNCm9uZSBHX0lPX0lOIGFuZCBXaW5zb2NrIHJlcG9ydHMgRkRfQ0xPU0Ug
b25seSBvbmNlLCBzbyBhIHBlZXIgdGhhdA0Kd3JpdGVzLXRoZW4tY2xvc2VzIG5ldmVyIHlpZWxk
cyBHX0lPX0hVUCBhbmQgdGhlIGxpc3RlbmVyIGhhbmdzDQpoYWxmLW9wZW4uIFRoYXQncyB3aHkg
dGhlIE1TR19QRUVLIHByb2JlIGxvZ2ljIGlzIHJlcXVpcmVkIG9uIFdpbmRvd3MsDQp3aGlsZSBv
biBQT1NJWCBwb2xsKCkvZXBvbGwoKSByZXBvcnRzIFBPTExIVVAgcmVsaWFibHkgYW5kIGRvZXNu
J3QgbmVlZA0KaXQuDQoNCkJlc3QgcmVnYXJkcywNClBvbGluYS4NCg0KPiANCj4gQmVzdCBSZWdh
cmRzLA0KPiBLb3N0aWFudHluIEtvc3RpdWsuDQo+IA0KPiANCj4gT24gRnJpLCBKdW4gMTksIDIw
MjYgYXQgOTowM+KAr1BNIFBvbGluYSBWaXNobmV2YSA8DQo+IHBvbGluYS52aXNobmV2YUB2aXJ0
dW96em8uY29tPiB3cm90ZToNCj4gDQo+ID4gQWRkIHZzb2NrLWxpc3RlbiBjaGFubmVsIG1vZGUg
dG8gdGhlIFdpbmRvd3MgZ3Vlc3QgYWdlbnQuDQo+ID4gDQo+ID4gVGhlIGxpc3Rlbi9hY2NlcHQg
cGF0aCB1c2VzIHRoZSBzdGFuZGFyZCBRRU1VIHNvY2tldCBoZWxwZXJzDQo+ID4gKHNvY2tldF9w
YXJzZSgpLCBzb2NrZXRfbGlzdGVuKCksIHFlbXVfYWNjZXB0KCkpIGFuZCBwbHVncyB0aGUgcmVz
dWx0aW5nDQo+ID4gU09DS0VUIGludG8gdGhlIEdNYWluTG9vcCB2aWEgZ19pb19jaGFubmVsX3dp
bjMyX25ld19zb2NrZXQoKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQb2xpbmEgVmlzaG5l
dmEgPHBvbGluYS52aXNobmV2YUB2aXJ0dW96em8uY29tPg0KPiA+IC0tLQ0KPiA+ICBkb2NzL2lu
dGVyb3AvcWVtdS1nYS5yc3QgfCAgIDQgKw0KPiA+ICBxZ2EvY2hhbm5lbC13aW4zMi5jICAgICAg
fCAyNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gIHFnYS9t
YWluLmMgICAgICAgICAgICAgICB8ICAgNiArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjIyIGlu
c2VydGlvbnMoKyksIDQ1IGRlbGV0aW9ucygtKQ0KPiA+IA0K

