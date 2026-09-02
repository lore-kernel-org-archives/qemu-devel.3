Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7BEC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gDv-0001TM-IC; Wed, 02 Sep 2026 04:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x1gDt-0001Sb-CW; Wed, 02 Sep 2026 04:21:33 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x1gDr-0003fR-AP; Wed, 02 Sep 2026 04:21:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyLt27LbtTqjZSKNeXgBUqDDEYzhoRuvgLHAJMay4L3gJmYU1AX7F5ZQgWYGmKw0ka/WA+gWhcUJLyfnQp1AhESANqybXgCi+bEwY8W8mX1794JBj41RWIkFuTifpGkvmnQV7XJjHgAL9FiGV7Ag4XpB6zkeW+V5hA6O3kfGezrmywTm5wtzEXZgRK81lLXSbx/9MjDOWXgWI/ephk6KguCtHasngcu4uvLD/LwnjvcVvXheUqP2ZlCyeOeeUgPh10GNTDFI5v+lq5tyI5Ayz7SXKl3X8nVEsRXnWyQ0vcQHHEF2/j1FCWKVnCxKBk6bioDufl1iN+fv7T5yLzHBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiq3jxLy713AZqZnsGb4nTD/Z3YGVTMKCRCqAFopSnE=;
 b=K982mUCKFh1DjLhqCzH+u4Wjh5ix8g/RYb75k/JMSVVFSOVKTh0oyVVS/3BaOTi5QaxczxZEC7mtrIiXE6z8OckGDL35olFtsoR7I1nBwerdWaQgMRfug67qCZRyaqGmXbXs+i9Y8Usg3sNCd4FUC3QN5WG97VnZN/kc61pEzC/EF83qS66gppFRkGJbg0HKNEBP6RowCQ5vpNfbNv4qSzoMp77nnE8WsEYVER3cQwVAe9S3vQfRDoML+xPKB8xDbTuGZxYlCkUjHEctaECYt87iT8qFa+Unff3d8YU8/y5u/QqWmlrdYv9ljRmYLVv5wpJCf937gTOCbfuhwm7TaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiq3jxLy713AZqZnsGb4nTD/Z3YGVTMKCRCqAFopSnE=;
 b=FqQmLGc9o/Bpnvnb4+oqWe61Z6g8TugZQquO2dQobcl1srq/dlXSHRj3mWXC0X38Gd3oVt9YkpBbr4RDHjXC2H5drNfQnWT4YWiHq/Px5CHXQVe7/3NAu+Q5hq/vi6SfnJEhvu7UuzRNmYaoUJz/LZTziK/uq4SivMwHyTzcmZW0gFOMFByhyX3wi6WNXZg7nBtbMAFNTUM9X4UvSdzBFF0XNbajqxLb++vv3SEle4Ar9kcQpJ7K/ZQ1i6kYfKYIyT3eKeBXnqp7CHdBol7wt2nLUSc1PTm2dKFdeMbobouqu+QgDbB27HxH/1PDAfDgbAAHuF3mLbVVVe8LQy21LA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:21:24 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:21:24 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Farhan Ali
 <alifm@linux.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
CC: "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>, "farman@linux.ibm.com"
 <farman@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "armbru@redhat.com"
 <armbru@redhat.com>
Subject: RE: [PATCH v4 2/4] vfio/pci: Add an error handler callback
Thread-Topic: [PATCH v4 2/4] vfio/pci: Add an error handler callback
Thread-Index: AQHdOXcv0gUaqc3nq0S/eQQmasGmmLa68WKAgAABzXA=
Date: Wed, 2 Sep 2026 08:21:24 +0000
Message-ID: <SJ0PR12MB8614C382D6696B05D9AD6C5AABB72@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
In-Reply-To: <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DS7PR12MB8418:EE_
x-ms-office365-filtering-correlation-id: ccb7fdd4-7736-49ec-ed1d-08df08cb2d75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|10067099003|6133799003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: /YKw7e5pmsoxaj5t9mHbD2NwY8VJKk9B5lyRlWe5/E4N5OBNzTVwCBu5tExnDKCX6HyKS2Gc6UbdC85ncztF9MoZO6N6eBeqk/wvmeleCEwougBfJwzPq1NanJ33sZ0jsjThvwiVSfQxLI/cWjmn2fcyaMrB3pBA07zvpRsl5nS2+Yj38buM9FDHXUFJVBHhczwJ7YMw0BdCy+pPojCDZvq9yZ0OXqkOfr6Hhne3zKfA2tWB7/Gd7DO4+qrV7E7OCu+nqVd5v8RfqoHqeI0YBmwDMMTnGPrVo3SR2NNQj9eSEsgAVDXll9CxCxxO0+gSFPF3EJY/ultdaxw/AyNJ5GEDofCoIur3wNRsjJJ+UK0N5HC49ctfCM38+JML26AmKwDkTSAzBQzTyVSwj+A3JWS16yWwXSj8IpYy45LLHQmqMVP0EVs0GmTU5ytq6tyKh9t9SQuhfclRJSZzw5l4C0q/hmYDUk3seUkpQykTPIpfwAtOBrZ7dFwVWmY0Wvgh0qdwkGcJqfB6+J9pZeMggPonCXOj2F+yCAZKp1xS7z4VvRJdSxrBRzMUl1iG5ufckWDgl57h/0fbkWn2i6w8D+QWholXbmMRo2OdVB3JkFaQicARVrnH943K7WSCQcrh1gAQcUxhPc1flUFKpqaz95IMMJXEaNWeKjbP5doLDWFHuvw5ky9KNi6z5AUCjSZKFQo39CSrCBFYqES3wRbP/zA00BJKx8G7YbcJzQedrog=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUkwQkw0L3BDUVlrdjNWOE9TQ3JWa1RpcE84MUd0VXd5K1h5RkcxY0hrT2VL?=
 =?utf-8?B?QXA5d1FBczZ3WG5nY3NkWjY3VlFRdmpuenlWUlhISXo2UXVoMWJTM2RGbHU4?=
 =?utf-8?B?NG1nQTdrbDNVQk1lZVNXQ2s5NnlDMDVlc0FpYzlNc2t2Q05VT3FrZGRHdC9a?=
 =?utf-8?B?N3BGVWFaVlgrSmhadjNUNXZrUHZQMVkxOEhSOGx5NkJJL2JpcTdMa3dmREds?=
 =?utf-8?B?MXkvSVpCUG81SUFSVFFueWhLalZpMGJxMWxKNTJzTXIzTy9iaDl0VENVR2xH?=
 =?utf-8?B?UXRNbXNzQm9FSUdzbTFLZHpnTFkxSmFSdlFuMmM5a1UyOEFWdGhOc0lWNkFM?=
 =?utf-8?B?dHk4MUNES0lWbkxsSDVNd3YzNjZHSTl1Z3A4Ti9hZkpxUElPcHVvVGU1bS9r?=
 =?utf-8?B?SEVJNlRUcWJpZnZSSXROUUNjbmZGY2t6WndVNitoSGM4QWt2UzRmMjB1RnVv?=
 =?utf-8?B?VjF0b0YzZnBOVFk3N0ZLRmJkbUJsbU1KMmJTZjVKYmlZdmFvc2ZrMlhBVGJw?=
 =?utf-8?B?SVNVSXc3c2FYRllIT1pXRGY2NlNnRjNTSDk4OVBCUk5kVmxrcmw1dWZnTTBs?=
 =?utf-8?B?OHhkKzZyN0t2SFhTM0JlNjQ4V2VjV1c2UStpOXNUaDVTMFVmN2xxYXdyQlYv?=
 =?utf-8?B?VVNHaCtudGtYN29yZFJWOHVXWEZMSnpPQk4wa0xvMTFlMjJLQTRXWFVuMkV1?=
 =?utf-8?B?Y1Z6NTFRUm92TFVTakVzV0gvRWFRWXJkM21sczZXMDNFZE9VWjcvVnNrSkIw?=
 =?utf-8?B?NEp6S25lak0vQlF1bTlLNTZuYnBwUEE4U0pENjNHODVjSE0zYVRJOWdVamRy?=
 =?utf-8?B?c2ZoN1NMbC82ZWVhR2JFd2YydFNFMGU1Uno5SGFxcnR0QW9ROVR5Wm0vcjRC?=
 =?utf-8?B?eU03S09pckY3N2ZsUURWazFxYy9xNGE1b2s0ZW1HenVvMWZpajJhaXdoU0Fa?=
 =?utf-8?B?NHNiSVp4WnZHamZPT1JaenlETnR0ZHFNcmJHRysxNHp1QVVXWTNLTDl6cXNF?=
 =?utf-8?B?ckNkSVV0ZlNHdzlpb1dyTlp1cmo1NHRMNHB6cTA1am9lTFRpSHlZS3Q4R3kv?=
 =?utf-8?B?RnNqT0pkTDZYMEF5dDFXK0tpWnY1aDRvSVE4U29aM0kzUHB1VmNZTjJJd0po?=
 =?utf-8?B?ZlNoTXJ6MlR1QUZFNlhmalhKS1dDUFVlVmZDbWtvREM1TVArSlh2azlOb2xP?=
 =?utf-8?B?WDFDN0ZpRGljc3JEY2VxYnRqUUcxT2hWSVBobDNtZTh6M2ozZEdRT3Mxb0Qx?=
 =?utf-8?B?clBxWVRKUU1BcHZSMXVyM29kUXh2MzJnOGd1UHg3UDIzcVE3TjFrSXI0TWRi?=
 =?utf-8?B?UzZqNW9wMVpTYWNrSGRBc1hkMEhIRDNKOUZZMWlmb2tEUXFhSHQ2cnRRQTNT?=
 =?utf-8?B?blFvbWFQMVJlUnFFU29ENnhsV2Y5ZzhRRHl4b3ZEelJMOEI0MDFVMHFpSHZL?=
 =?utf-8?B?cDhvQWRPcG9QZVk2ZHNNZXQwN1RPKys3dTcrQ041WUk0U1dsQkdINHhpYjll?=
 =?utf-8?B?RkFzVlBtdHRiandra2VXWEFXWFNvbzR4cGJQWHREZjZnNk8vWWh3MW56VDYr?=
 =?utf-8?B?bTJFaWJOTmdVWkNtUC83UXg2ZnFlK1JEd1I5L2IwRHVhZ3AzK2VhTy9xSElV?=
 =?utf-8?B?b1Z0K2hNcFBRRzZJMWx2U0hkWE1iTEVHWGpaYkNDZXBLSk9DK0N2ekFKSlcy?=
 =?utf-8?B?Y1lRMmhYaEpyeWR3aXc5K1RHd0lpWERnZmJ0MjdYVFVaSlp5bmZwWEsrZita?=
 =?utf-8?B?czd6a3hwOXpKRnRiYmo0dTdjcmttVE41UU5UYmdTMHhSaFNzZEp6YVB3cjhH?=
 =?utf-8?B?L3VzZUhkRFhEcEhnaUlhTzV1YVdya1A3Q1Rxd1U2WWNSb3AyWVA5MFdQbXFl?=
 =?utf-8?B?VTFaaTBBVmhuOWJqc28rQVhRdUxPa2NVSDhsT3dCZ0g1REd5bi9lTmtoakZV?=
 =?utf-8?B?dmxFSkpTK2ZEMExKSTIyYWthQXI5R2lIVXM1RXBHelJJVll6SGZWSWgvZ1RP?=
 =?utf-8?B?NkUrNXp6dSttcFVTYWFTUm15S2pvUDRqV0t2UDZIekpvRHJLa09MZnhINTNM?=
 =?utf-8?B?eXlQMkFNbUhQbUMzcTRFYTluUlViYmd6VnhoZUNFWW45M2JlQnNqSisyeUdw?=
 =?utf-8?B?bFVpZlRXN1dhaGpDdHhsUGFFbUtBUENOSmRRTEhSaGp1M09pQUJTbVdxY1Zi?=
 =?utf-8?B?UWM4ZWlxSHArQ092c0g2QmZvd0x4N3RGR0NtNXFCR3ZWMHN5TTQrdWpDRlhK?=
 =?utf-8?B?N2R5K0dKNnVKVHg1Unl6MWxJcFNTZTZreUV5dDB0aTVvZ0NyM0pOclk1bG5k?=
 =?utf-8?B?SDh5RzlPYmh3aWk4c0VTY2xTTDRDRVlycmdDRTJDWEZIWVJjMXpCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb7fdd4-7736-49ec-ed1d-08df08cb2d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 08:21:24.3492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYumALlNnZqoYGTEANW5EVZZTlkTwHIqEaqwVE1pQ7ZKVNXvP3ihx2v6GgCu/HCwzTzQY72hIbpTLOQLb/MjUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAwMiBTZXB0ZW1iZXIgMjAyNiAwOTowOA0KPiBU
bzogRmFyaGFuIEFsaSA8YWxpZm1AbGludXguaWJtLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgcWVtdS0NCj4gczM5MHhAbm9uZ251Lm9yZw0KPiBDYzogbWpyb3NhdG9AbGludXguaWJtLmNv
bTsgZmFybWFuQGxpbnV4LmlibS5jb207IGNvaHVja0ByZWRoYXQuY29tOw0KPiBhbGV4QHNoYXpi
b3Qub3JnOyBhcm1icnVAcmVkaGF0LmNvbTsgU2hhbWVlciBLb2xvdGh1bSBUaG9kaQ0KPiA8c2tv
bG90aHVtdGhvQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi80XSB2Zmlv
L3BjaTogQWRkIGFuIGVycm9yIGhhbmRsZXIgY2FsbGJhY2sNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gK1No
YW1lZXIsIHdobyBpcyBsb29raW5nIGF0IGZvcndhcmRpbmcgQUVSIGVycm9ycyB0byBndWVzdCA6
DQoNClRoYW5rcyBDw6lkcmljLg0KDQpJIGhhdmUgc2VudCBvdXQgYSBrZXJuZWwgUkZDIHNlcmll
cyB5ZXN0ZXJkYXk6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA5MDEwOTMyMTcu
ODUzOS0xLXNrb2xvdGh1bXRob0BudmlkaWEuY29tLw0KDQpQbGVhc2UgdGFrZSBhIGxvb2suIFBy
b2JhYmx5IHRoaXMgc2VyaWVzIGNhbiBiZSBleHRlbmRlZCBsYXRlciB0byBjb21lIHdpdGggYSBn
ZW5lcmljDQpBRVIgZXJyb3IgaGFuZGxpbmcgaW5jb3Jwb3JhdGluZyB0aGUgbmV3IGV2ZW50ZmQg
cHJvcG9zZWQgaW4gdGhhdCBSRkMuIEkgd2lsbA0KZ28gdGhyb3VnaCB0aGlzIG9uZS4NCg0KVGhh
bmtzLA0KU2hhbWVlcg0KDQo+IA0KPiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LQ0K
PiBkZXZlbC9TSjBQUjEyTUI4NjE0RERGRUUzQTk1NzU1NjRFREVGOTlBQkZGMkBTSjBQUjEyTUI4
NjE0Lm4NCj4gYW1wcmQxMi5wcm9kLm91dGxvb2suY29tLw0KPiANCj4gT24gOC8zMS8yNiAyMDoz
MSwgRmFyaGFuIEFsaSB3cm90ZToNCj4gPiBQcm92aWRlIGEgdmZpbyBlcnJvciBoYW5kbGluZyBj
YWxsYmFjaywgdGhhdCBjYW4gYmUgdXNlZCBieSBkZXZpY2VzIHRvDQo+ID4gaGFuZGxlIFBDSSBl
cnJvcnMgZm9yIHBhc3N0aHJvdWdoIGRldmljZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBG
YXJoYW4gQWxpIDxhbGlmbUBsaW51eC5pYm0uY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvdmZpby9w
Y2kuYyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAgaHcvdmZpby9wY2ku
aCB8ICAxICsNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9w
Y2kuYyBpbmRleA0KPiA+IDQyOGFiMmYwNjkuLmEyZjQ4OWIzNGQgMTAwNjQ0DQo+ID4gLS0tIGEv
aHcvdmZpby9wY2kuYw0KPiA+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4gPiBAQCAtMzI0NCwyMSAr
MzI0NCwzNiBAQCB2b2lkIHZmaW9fcGNpX3B1dF9kZXZpY2UoVkZJT1BDSURldmljZQ0KPiAqdmRl
dikNCj4gPiAgIHN0YXRpYyB2b2lkIHZmaW9fZXJyX25vdGlmaWVyX2hhbmRsZXIodm9pZCAqb3Bh
cXVlKQ0KPiA+ICAgew0KPiA+ICAgICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSBvcGFxdWU7DQo+
ID4gKyAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4gPg0KPiA+ICAgICAgIGlmICghZXZlbnRfbm90
aWZpZXJfdGVzdF9hbmRfY2xlYXIoJnZkZXYtPmVycl9ub3RpZmllcikpIHsNCj4gPiAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIC8qDQo+ID4gLSAgICAgKiBU
QkQuIFJldHJpZXZlIHRoZSBlcnJvciBkZXRhaWxzIGFuZCBkZWNpZGUgd2hhdCBhY3Rpb24NCj4g
PiAtICAgICAqIG5lZWRzIHRvIGJlIHRha2VuLiBPbmUgb2YgdGhlIGFjdGlvbnMgY291bGQgYmUg
dG8gcGFzcw0KPiA+IC0gICAgICogdGhlIGVycm9yIHRvIHRoZSBndWVzdCBhbmQgaGF2ZSB0aGUg
Z3Vlc3QgZHJpdmVyIHJlY292ZXINCj4gPiAtICAgICAqIGZyb20gdGhlIGVycm9yLiBUaGlzIHJl
cXVpcmVzIHRoYXQgUENJZSBjYXBhYmlsaXRpZXMgYmUNCj4gPiAtICAgICAqIGV4cG9zZWQgdG8g
dGhlIGd1ZXN0LiBGb3Igbm93LCB3ZSBqdXN0IHRlcm1pbmF0ZSB0aGUNCj4gPiArICAgICAqIFdl
IGNhbiByZXRyaWV2ZSB0aGUgZXJyb3IgZGV0YWlscyBhbmQgZGVjaWRlIHdoYXQgYWN0aW9uDQo+
ID4gKyAgICAgKiBuZWVkcyB0byBiZSB0YWtlbiBpbiBlcnJfaGFuZGxlcigpLiBPbmUgb2YgdGhl
IGFjdGlvbnMgY291bGQNCj4gPiArICAgICAqIGJlIHRvIHBhc3MgdGhlIGVycm9yIHRvIHRoZSBn
dWVzdCBhbmQgaGF2ZSB0aGUgZ3Vlc3QgZHJpdmVyDQo+ID4gKyAgICAgKiByZWNvdmVyIGZyb20g
dGhlIGVycm9yLiBUaGlzIHJlcXVpcmVzIHRoYXQgUENJZSBjYXBhYmlsaXRpZXMgYmUNCj4gPiAr
ICAgICAqIGV4cG9zZWQgdG8gdGhlIGd1ZXN0Lg0KPiA+ICsgICAgICoNCj4gPiArICAgICAqIElm
IGVycl9oYW5kbGVyKCkgaXMgbm90IGltcGxlbWVudGVkL2ZhaWxzLCB3ZSBqdXN0IHRlcm1pbmF0
ZQ0KPiA+ICsgdGhlDQo+ID4gICAgICAgICogZ3Vlc3QgdG8gY29udGFpbiB0aGUgZXJyb3IuDQo+
ID4gICAgICAgICovDQo+ID4NCj4gPiAtICAgIGVycm9yX3JlcG9ydCgiJXMoJXMpIFVucmVjb3Zl
cmFibGUgZXJyb3IgZGV0ZWN0ZWQuIFBsZWFzZSBjb2xsZWN0IGFueQ0KPiBkYXRhIHBvc3NpYmxl
IGFuZCB0aGVuIGtpbGwgdGhlIGd1ZXN0IiwgX19mdW5jX18sIHZkZXYtPnZiYXNlZGV2Lm5hbWUp
Ow0KPiA+ICsgICAgaWYgKHZkZXYtPmVycl9oYW5kbGVyICYmIHZkZXYtPmVycl9oYW5kbGVyKHZk
ZXYsICZlcnIpKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4g
PiArICAgIGlmIChlcnIpIHsNCj4gPiArICAgICAgICBlcnJvcl9wcmVwZW5kKCZlcnIsICJVbnJl
Y292ZXJhYmxlIFBDSWUgZXJyb3IgZGV0ZWN0ZWQgZm9yIGRldmljZQ0KPiAlcyIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICB2ZGV2LT52YmFzZWRldi5uYW1lKTsNCj4gPiArICAgICAgICBl
cnJvcl9yZXBvcnRfZXJyKGVycik7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgIGVy
cm9yX3ByaW50ZigiVW5yZWNvdmVyYWJsZSBQQ0llIGVycm9yIGRldGVjdGVkIGZvciBkZXZpY2Ug
JXMiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB2ZGV2LT52YmFzZWRldi5uYW1lKTsNCj4g
PiArICAgIH0NCj4gPiArICAgIGVycm9yX3ByaW50ZigiUGxlYXNlIGNvbGxlY3QgYW55IGRhdGEg
cG9zc2libGUgYW5kIHRoZW4ga2lsbCB0aGUNCj4gPiArIGd1ZXN0Iik7DQo+IA0KPiBob3cgYWJv
dXQgdGhhdCBpbnN0ZWFkIDoNCj4gDQo+ICAgIGlmIChlcnIpIHsNCj4gICAgICAgIGVycm9yX3Jl
cG9ydCgiVW5yZWNvdmVyYWJsZSBQQ0llIGVycm9yIGRldGVjdGVkIGZvciBkZXZpY2UgJXM6ICVz
IiwNCj4gICAgICAgICAgICAgICAgICAgICB2ZGV2LT52YmFzZWRldi5uYW1lLCBlcnJvcl9nZXRf
cHJldHR5KGVycikpOw0KPiAgICAgICAgZXJyb3JfZnJlZShlcnIpOw0KPiAgICB9IGVsc2Ugew0K
PiAgICAgICAgZXJyb3JfcmVwb3J0KCJVbnJlY292ZXJhYmxlIFBDSWUgZXJyb3IgZGV0ZWN0ZWQg
Zm9yIGRldmljZSAlcyIsDQo+ICAgICAgICAgICAgICAgICAgICAgdmRldi0+dmJhc2VkZXYubmFt
ZSk7DQo+ICAgIH0NCj4gICAgZXJyb3JfcHJpbnRmKCJQbGVhc2UgY29sbGVjdCBhbnkgZGF0YSBw
b3NzaWJsZSBhbmQgdGhlbiBraWxsIHRoZSBndWVzdFxuIik7DQo+IA0KPiA+DQo+ID4gICAgICAg
dm1fc3RvcChSVU5fU1RBVEVfSU5URVJOQUxfRVJST1IpOw0KPiA+ICAgfQ0KPiA+IGRpZmYgLS1n
aXQgYS9ody92ZmlvL3BjaS5oIGIvaHcvdmZpby9wY2kuaCBpbmRleA0KPiA+IGM5YWI5NDk4NzAu
LmMwNjdiYmJlYmMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9wY2kuaA0KPiA+ICsrKyBiL2h3
L3ZmaW8vcGNpLmgNCj4gPiBAQCAtMTQ2LDYgKzE0Niw3IEBAIHN0cnVjdCBWRklPUENJRGV2aWNl
IHsNCj4gPiAgICAgICBFdmVudE5vdGlmaWVyIGVycl9ub3RpZmllcjsNCj4gPiAgICAgICBFdmVu
dE5vdGlmaWVyIHJlcV9ub3RpZmllcjsNCj4gPiAgICAgICBpbnQgKCpyZXNldGZuKShzdHJ1Y3Qg
VkZJT1BDSURldmljZSAqKTsNCj4gPiArICAgIGJvb2wgKCplcnJfaGFuZGxlcikoc3RydWN0IFZG
SU9QQ0lEZXZpY2UgKiwgRXJyb3IgKiopOw0KPiANCj4gUGxlYXNlIGFkZCBkb2N1bWVudGF0aW9u
LCBzb21ldGhpbmcgbGlrZSA6DQo+IA0KPiAgICAvKg0KPiAgICAgKiBQbGF0Zm9ybS1zcGVjaWZp
YyBlcnJvciByZWNvdmVyeSBoYW5kbGVyLg0KPiAgICAgKg0KPiAgICAgKiBDYWxsZWQgd2hlbiB0
aGUgaG9zdCByZXBvcnRzIGEgUENJIGVycm9yIHZpYSB0aGUgVkZJTyBlcnJvciBub3RpZmllci4N
Cj4gICAgICogVGhlIGhhbmRsZXIgc2hvdWxkIGF0dGVtcHQgdG8gcmVjb3ZlciB0aGUgZGV2aWNl
IGFuZCBmb3J3YXJkIHRoZQ0KPiAgICAgKiBlcnJvciB0byB0aGUgZ3Vlc3QgaWYgdGhlIHBsYXRm
b3JtIHN1cHBvcnRzIGl0Lg0KPiAgICAgKg0KPiAgICAgKiBAdmRldjogdGhlIFZGSU8gUENJIGRl
dmljZSB0aGF0IHRyaWdnZXJlZCB0aGUgZXJyb3INCj4gICAgICogQGVycnA6IHNldCB3aXRoIHRo
ZSBmYWlsdXJlIHJlYXNvbiBvbiBmYWxzZSByZXR1cm4NCj4gICAgICoNCj4gICAgICogUmV0dXJu
IHRydWUgb24gc3VjY2VzcywgdGhlIFZNIGNvbnRpbnVlcyBydW5uaW5nLg0KPiAgICAgKiBSZXR1
cm4gZmFsc2Ugb24gZmFpbHVyZSBhbmQgc2V0IEBlcnJwLCB0aGUgVk0gd2lsbCBiZSBzdG9wcGVk
Lg0KPiAgICAgKi8NCj4gICAgYm9vbCAoKmVycl9oYW5kbGVyKShzdHJ1Y3QgVkZJT1BDSURldmlj
ZSAqdmRldiwgRXJyb3IgKiplcnJwKTsNCj4gDQo+IA0KPiBUaGF0IHNhaWQsIEknZCBwcmVmZXIg
dG8gc2VlIEFFUiBmb3J3YXJkaW5nIGZpcnN0Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4g
DQo+IA0KPiA+ICAgICAgIHVpbnQzMl90IHZlbmRvcl9pZDsNCj4gPiAgICAgICB1aW50MzJfdCBk
ZXZpY2VfaWQ7DQo+ID4gICAgICAgdWludDMyX3Qgc3ViX3ZlbmRvcl9pZDsNCg0K

