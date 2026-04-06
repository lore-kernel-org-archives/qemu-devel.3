Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BABF46C54
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mDC-0005eE-P3; Mon, 06 Apr 2026 11:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mDB-0005dm-77; Mon, 06 Apr 2026 11:50:01 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD9-00021U-L8; Mon, 06 Apr 2026 11:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXYyIefMU5XMdWG4w3eOtCsYpwwrqPa/RAiqxeoJrUiA/HnjYeqV5/LPjab2woJpNaEsdANAM99OsSjDdOq3U4zk2Xe9+hbsFTfadwKCeHVVXhmVdKI63HNz/MbCKVwzrLq+VqBuyIUl5cY3bUyyJXdatsi7l9o1EbjA8rMt1hEEIm4qJXkj9ZRHuEA62QlKth1iInGcnk3R0SYv3BfbBrpdgU+9Lm9FMn/4/8jW2W8zBFhzRM0OEfjT1+ScfFEsLO6Qc5mxb50TLjWmJg+1oynMedtDF/l3ByTtdUK2hGweuF+iyPK4M40gpuFtWNmpZYpI/ND3+tKu88Md4YUKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=ADixOhDhJ9ExIMkg0VIcMqQEIIVmzu1hjdmJtvArH2cxT2gaNvAz+HKTXonWTtWMX5d6DnckgIRNwJPBG0lBwmR3U7sF2amiYDVusv51DMVpA3kkS8AJGIn9Fbq1XGglspWawL8rwRML/EPCBiq4tvFfZS2cPL01RMAQA0jsRJlLt27N+ENSM0vGOyCJFrJU3yL7nAisRxFCIc7Ek2xEu86Y8/q0X0Jhdsw8UPGhpEFZvy+Z2M/c96PEhSqzkn7Xc3aqCivoI38DV+9Cqy/nyDpD4ym4wtIUqu+8Mb0Gm6NINoZ3obqPL0Gl2pRZVi32micnE/na+r4kFPrX66VJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=njA1Q5AmDDSM528ByVtg3kiBYa6ZdUpXThvX6TXrNp/A3ID/Io8O+a5ed9DXAN95tC54gYhdFoDtXK6EQAqpNCINTsy4b5VjaUIgxydrlNa7UqMLnOUkcJxpGrGCTdBo6Hw3yTHCYwZDRs2/SMmILBh3BGbEtNzh5BWTMBWSIthEckxWRAS9tJ/GUI1jjGHwu+fUlOAVj07Al+ifPy+MzEkbkfh7ggetu24EiO366cxeNOawKwQb7l+D0oZNJe0M4TwHZ3yZQvblmnffZVIEK4O5RVVNdas9GZBmY1vm948zW38bRNIYbvcPTpze2tEwjFgiVE9br1EcNbSq/++vOg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:49:43 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:49:43 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 6/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v6 6/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHcxdz85GQ32f8AqkK1O7gP1A+/Sw==
Date: Mon, 6 Apr 2026 15:49:42 +0000
Message-ID: <20260406154935.144674-7-djordje.todorovic@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: c70ab610-5457-410e-69a2-08de93f41f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: XLzaSgEO+nPUcxDfMwmtYXfTNvLcL3uMUPnPib2IUboWrWQ+so4u4ELKRbg29UG6c9D02qwaKRjcp3mNbKgqOvRrM6SNeoJ8h45ygdqO00KKRci0bL0BdzLJ78rzSW/dYNEPxQ0Eqf8KaAOcBH29bN5DvaHS3w+chwG0OJbKsWAtUWPVNsA0EKKrpInOiIF58TrtW8tV/KE+TxqovRxOy55sMpuWSz9r92VDJl1GtljHnp2iK/8AMuzT3rVUe8C3/4V8wfeGFTITML24Q/i5X2X5MVa16LMrp9s+AaBIyPcvn/mxrLTPoCKkJ82etwoBlD1gdjVGTgLE0K5+Sfh7tM5PBPrDIWLWJO5RWtxQnCfCE4bWM996ah8bRPIESx/paDsZQN5pVJdrsHSALkbXcehfhtlUo+xHUF+cB+JjRORq6TGc9asz/Wn7XR2L8ZMpNq0GeGUiVOX8vjA88gmeRA7dHNr3JCPn7EqcFZGDkZn6pev7/+gcAlBRvYUbs8WcILec/2GewNDvmPDbrG7VFmh9xw9pssgcjFvut1aW4SKMbPEErHxHqJ9+DYLQjBUxzUPCRiq35zKXgFkRtx2RJKshTr+VceBXgXJrFKnmVGDw7tOmofGBe2dwiUfLT0H55z0n8QHZGSzr36e9yAsg14aou9GSs5tlPtmQaui8fNAMPG7YBEKrsedACj9kNFyPLiWYKZVKAOCAIYp4voMiKwsfVg8vai6WtE9lipRutIfEfEg0bGz7D2+K34y8K4sp0rGRCul33UKcFeqvaKzYxJJ1rZOObWGhIueDH+I15+E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHlNYU94ckpQb3hXTnlzMW4rS2ptbCtwVk9XaXMwVzZZSFNRQ1prQXFkemdj?=
 =?utf-8?B?RWxaVzBHZy9nMDZmUTZzU3BIaTNFeHJreXZRN0Yxd0Ixcmo0dE54TzYvVWlR?=
 =?utf-8?B?R012emhLZDcyd2RLajF2WTM2NzZQSDBBMGJTQnBrTW8wVHBOVDRNU3FKelBw?=
 =?utf-8?B?SHlBcUFMdUNFOUlDY24rWkNMWGJ4eVpnUmlra0s0eWNKWWczZ3ZBZzBOSEtG?=
 =?utf-8?B?d2ZyamVBWFpZOFUxQW5HMDB6NlZYbm5IYW1nbjFiSDVyZkV6NEk4Mml5aWdU?=
 =?utf-8?B?d2VXc2ZIbzVkZjUwL3F2SHk4b1lyaDNXZFFQanZob2hkTmNYVjR1QlA5TjF1?=
 =?utf-8?B?WTQ3R2lzRi9rUFFKd3l5WXJzQWFUTGZ4YkVqNlBQVTFCZEl2VHZ1N3poWTB3?=
 =?utf-8?B?dlBxS0VxSVNrRHlRVGdybFRXdzdLN2pDM0FsUWlQaXFEUDAwMHgrdzRvdVhU?=
 =?utf-8?B?d3E2L01WblpRY2xWbFk5bmVhN0x6cGFBWlFrWGZMOFo2MWNTaDdzYWVJRlpS?=
 =?utf-8?B?eUk4c09kR2FKd2hZVU9jSDFaL0Fad2hwUE9nK0gxQldISVhEMzdiOXcrVnNE?=
 =?utf-8?B?Y1JHNUpmeEgxVzVWdnJqOFpuYzVVMzU5bi9hMjJWR3lKaVVTd0lZeHp1MEN1?=
 =?utf-8?B?eWpMSXFabW9ERFE3Y2ZnQ2tVUFpIVmJzbmgyUFlEclg4Z09MZUw2NEF3SXFN?=
 =?utf-8?B?TzBRbWlNOC8vSVZPZCtXOXBKTFFBSmxMckhNMTFBOVZqNzNjTFVLWGpCa2Zi?=
 =?utf-8?B?RUxGMzlsQUEvbG9nRjh6SnVOcXpBWThsbDVMaW1ubGJKSU1DRmp5OXVodTZH?=
 =?utf-8?B?NG5QNnB2QTFoVWZkVHBjZzQwMFBoVlY5Nnk3YndPdlFyR3JOd0VHUnZNemN1?=
 =?utf-8?B?VkcvTW5pdXhEdUllUCs2N2tpeVVRZTlmZlAxUTFpZGZRM3MrRkl3OFB6clR1?=
 =?utf-8?B?dWFTditvY1JKRVJFZkJwaUVaUjhmN1BUVTRwZXRLcmY5TTQvUFVDcXlkWTE5?=
 =?utf-8?B?NWlzbVdSMUxJdERERXBTVnV3OEZkdjdsQzFwVWRCQnQ5dG5OWnQrdlhxWExu?=
 =?utf-8?B?UU9ia3ZBdDJJM0RkOTk5aUJSR2VkZW1xd2F0L1N2WHd0c2hBTEpTd2hkL2pT?=
 =?utf-8?B?UWNlSkhaeFdGMU1hbFlvZEdONEpFNC9YOUpzZmRtbGlkNE5CYlRrYmdCRG0w?=
 =?utf-8?B?dnpidERkSG5nc3B3ZWNQdmU4RmR4K3BtWWQ1cG5xZGFnbTAvakwrcnBzY3VZ?=
 =?utf-8?B?QmhNTnBXbnczKyt3dTcvUEtlWkJkZXgvOEE3TmlSL2Fsb3VCWS9BOFJLc2xa?=
 =?utf-8?B?NGxnR2h6endQVy9TKzhUdmhWc01lbXFFak1yK01KM2RrcUx5NWpzcHNMSWd3?=
 =?utf-8?B?dmQxb2VoTnRMWit1L0VFczRRdDdaUE9JcUZtNjlDaHFvWjJEWnEycFBVU1Vh?=
 =?utf-8?B?OWxtWUcxaDZaZ2dqWUJKNjlUS05UN2cwWlNSNmlPdUI3U3NEZmhpOVBPQVNE?=
 =?utf-8?B?WEJ1RDd6dWdOWTIza3M0a1VQU3h4b09ESTZvU05yc1d0clc4OWhLSkZVaEcw?=
 =?utf-8?B?ODVZOVFrY2dSNjA0MHBCU2lNTnlsQkt1V3IwWkswUUMrM0JVRmtSZjFYSHhB?=
 =?utf-8?B?NXc2eERPZ0ZDTlEyblhWZDVscStaNEFwZnd0L0hwTzY2cFQ1MzdCUWNIc1N3?=
 =?utf-8?B?Vno4bW1WY0w2RXl5U3duV1VSN0hwUnk1YWg4MkNIdTNOTkQvQkw0K2lVM2Nm?=
 =?utf-8?B?TXBwUlV3ZWFzZ3N6VGZkcTl1TkczdHF3NGxuYVlQbXlJTVZnKzZ5andJOVBv?=
 =?utf-8?B?dktvdk0wQk4zVnovTVNTU21zTkVPaGxyT0xaZUZwN2VzWXg0b2ZhTStQd3g1?=
 =?utf-8?B?Yzh4MHE2OUUxVzEzUWpWTGd3TDFhbVlrNXNQMCt6b3Z6Y2NZNmR6SEFhbThN?=
 =?utf-8?B?R21zVmNqSFVaSWlZcVNCZDZNS0Y1WTQrNnJnRkYxNHd1aW9CdjZwMFRIZUhQ?=
 =?utf-8?B?NDVPeEVjL1VvM3pRUiswNVNpMFZUWTg5TjNUbmNMSXpXM0ZPdWFMOFZ4cmZF?=
 =?utf-8?B?a3JWMnE0UTBjZHY2ZzZRMVNzeXZwdjRRTGdoZUxrQTdlL2ErcDRXTEhPN2h5?=
 =?utf-8?B?aUFxSXhTT295N0VDVVhOL2dxWXZNQ0M5RFMwWVNERWo1ZDRDOFJsT2tDbTBq?=
 =?utf-8?B?bkhnbXRZNjBtRVVOOFlxRU80Wno2UkozcGZ5dStiLzZEdHlUTWJ3VFZpZ2ZV?=
 =?utf-8?B?Yk5DbnBYOXhkQ0pUS3JuamxBUW5MSWNjSlE2eEd6NURmRU9SZUNFdmg1cjFP?=
 =?utf-8?B?Q3ZzVGw5S0xCc0NqVy9wQVVlaDBqRlBwaXZrUEI3SlFESEoyMC9jTzNoRDhy?=
 =?utf-8?Q?kpnMH7S1EKKhsrQnnDRv6sDmtN+1lZRlbzOaS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38ECEEB28EE1694497EBA60BAE2F0E3C@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70ab610-5457-410e-69a2-08de93f41f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:42.7849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKbsZGYypgozre9bIZUfcvQWuggvu7rF2w2Twl4WB4ZpV99YB3uieBLXQcfHHGRE5WHKKUVSrq5iTAPu0vTgIcSKHz6+yAszca6eqBpGSyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

VGhlIHBhZ2UgdGFibGUgd2Fsa2VyIHJlYWRzIFBURXMgdXNpbmcgYWRkcmVzc19zcGFjZV9sZGwv
bGRxIHdoaWNoIHVzZQ0KY29tcGlsZS10aW1lIG5hdGl2ZSBlbmRpYW5uZXNzIChhbHdheXMgTEUg
Zm9yIFJJU0MtVikuIEhvd2V2ZXIsIHdoZW4gYQ0KYmlnLWVuZGlhbiBrZXJuZWwgd3JpdGVzIFBU
RXMgdmlhIG5vcm1hbCBzdG9yZSBpbnN0cnVjdGlvbnMsIHRoZXkgYXJlDQpzdG9yZWQgaW4gYmln
LWVuZGlhbiBieXRlIG9yZGVyLiBUaGUgd2Fsa2VyIHRoZW4gbWlzaW50ZXJwcmV0cyB0aGUgUFRF
DQp2YWx1ZXMsIGNhdXNpbmcgcGFnZSBmYXVsdHMgYW5kIGEgaGFuZyB3aGVuIHRoZSBrZXJuZWwg
ZW5hYmxlcyB0aGUgTU1VLg0KDQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiBz
dGF0ZXMgdGhhdCBpbXBsaWNpdCBkYXRhIG1lbW9yeQ0KYWNjZXNzZXMgdG8gc3VwZXJ2aXNvci1s
ZXZlbCBtZW1vcnkgbWFuYWdlbWVudCBkYXRhIHN0cnVjdHVyZXMgZm9sbG93DQp0aGUgaGFydCdz
IGVuZGlhbm5lc3Mgc2V0dGluZyAoTVNUQVRVUyBTQkUvTUJFIGJpdHMpLg0KDQpGaXggYm90aCBQ
VEUgcmVhZHMgYW5kIGF0b21pYyBBL0QgYml0IHVwZGF0ZXMgdG8gdXNlIHRoZSBleHBsaWNpdCBf
bGUNCm9yIF9iZSBtZW1vcnkgYWNjZXNzIHZhcmlhbnRzIGJhc2VkIG9uIHRoZSBoYXJ0J3MgcnVu
dGltZSBlbmRpYW5uZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpv
cmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IGMy
ODgzMmUwZTMuLmIzZDMzZGExM2UgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtMTM2NSw5ICsxMzY1LDEz
IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBo
d2FkZHIgKnBoeXNpY2FsLA0KICAgICAgICAgfQ0KIA0KICAgICAgICAgaWYgKHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAgICBwdGUg
PSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAgICAgPyBh
ZGRyZXNzX3NwYWNlX2xkbF9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykNCisgICAg
ICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkbF9sZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRy
cywgJnJlcyk7DQogICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nf
c3BhY2VfbGRxX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAg
ICBwdGUgPSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAg
ICAgPyBhZGRyZXNzX3NwYWNlX2xkcV9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykN
CisgICAgICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkcV9sZShjcy0+YXMsIHB0ZV9hZGRy
LCBhdHRycywgJnJlcyk7DQogICAgICAgICB9DQogDQogICAgICAgICBpZiAocmVzICE9IE1FTVRY
X09LKSB7DQpAQCAtMTU2NiwxMiArMTU3MCwyNCBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyICpwaHlzaWNhbCwNCiAgICAgICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpIHsNCiAgICAgICAgICAgICB0YXJnZXRfdWxvbmcg
KnB0ZV9wYSA9IHFlbXVfbWFwX3JhbV9wdHIobXItPnJhbV9ibG9jaywgYWRkcjEpOw0KICAgICAg
ICAgICAgIHRhcmdldF91bG9uZyBvbGRfcHRlOw0KKyAgICAgICAgICAgIGJvb2wgYmUgPSByaXNj
dl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudik7DQogICAgICAgICAgICAgaWYgKHJpc2N2X2Nw
dV9zeGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgICAgICBvbGRfcHRlID0gcWF0
b21pY19jbXB4Y2hnKCh1aW50MzJfdCAqKXB0ZV9wYSwgY3B1X3RvX2xlMzIocHRlKSwgY3B1X3Rv
X2xlMzIodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9IGxlMzJfdG9f
Y3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCBjbXAgPSBiZSA/IGNwdV90
b19iZTMyKHB0ZSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9f
bGUzMihwdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSBiZSA/IGNwdV90b19i
ZTMyKHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNw
dV90b19sZTMyKHVwZGF0ZWRfcHRlKTsNCisgICAgICAgICAgICAgICAgb2xkX3B0ZSA9IHFhdG9t
aWNfY21weGNoZygodWludDMyX3QgKilwdGVfcGEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY21wLCB2YWwpOw0KKyAgICAgICAgICAgICAgICBvbGRfcHRlID0g
YmUgPyBiZTMyX3RvX2NwdShvbGRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OiBsZTMyX3RvX2NwdShvbGRfcHRlKTsNCiAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgICAgICBvbGRfcHRlID0gcWF0b21pY19jbXB4Y2hnKHB0ZV9wYSwgY3B1X3RvX2xlNjQocHRl
KSwgY3B1X3RvX2xlNjQodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9
IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcgY21w
ID0gYmUgPyBjcHVfdG9fYmU2NChwdGUpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IGNwdV90b19sZTY0KHB0ZSk7DQorICAgICAgICAgICAgICAgIHRhcmdldF91bG9u
ZyB2YWwgPSBiZSA/IGNwdV90b19iZTY0KHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9fbGU2NCh1cGRhdGVkX3B0ZSk7DQorICAgICAg
ICAgICAgICAgIG9sZF9wdGUgPSBxYXRvbWljX2NtcHhjaGcocHRlX3BhLCBjbXAsIHZhbCk7DQor
ICAgICAgICAgICAgICAgIG9sZF9wdGUgPSBiZSA/IGJlNjRfdG9fY3B1KG9sZF9wdGUpDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICBpZiAob2xkX3B0ZSAhPSBwdGUpIHsNCiAgICAgICAgICAg
ICAgICAgZ290byByZXN0YXJ0Ow0KLS0gDQoyLjM0LjENCg==

