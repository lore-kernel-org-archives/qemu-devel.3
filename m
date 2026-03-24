Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30974F54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54nw-0003k2-CL; Tue, 24 Mar 2026 12:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54no-0003ik-EK; Tue, 24 Mar 2026 12:40:24 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nm-0005Lv-OQ; Tue, 24 Mar 2026 12:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EziZwoC3xkGhuNQ4BCO96lM/1J2zsKTB03OEW8iI3FEUg9q6SkBMV3qoQ8AbiArKuFQhW5IO7GxeA8vcuWSYdTe21ufuNGvRBevtByLDM4bF9r7RBbFRVDv9RyiKPuZpT+U2NutlV6W/dZsRTIjRuytmBvkeM2/GrJ2yRjCb7He6pE26duKt2EiTm4GSe3bE9H6gmC9M0H6UnlsjhKfqfTQNFsat7WrLj2LQbPDG1s7mT6mnAfPCygubuPYX8f2ZjEACYr8JaW7EjS4rbZOXODvJJfiBHwU6wkTRgRxMOwd6QJM8zB3lECen06SgRZPCRGVJHUAmgGsu/RkwY18Pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=sYFER1XeKulTl3CgYr3hOiWHmUzuv0UtIxU13aR4iMuzY081U2vTzs5C+h9NeJnjhPn1ey/eF37XHIMbkMER8ycXROW6NgDT/r1Fmlb0UtACWBq0TuKFrhClfXk38SOfqZD0pK1DkQuIm7JcaCtLSzzxzrPiRZ/PVCQlRFbq4ZW9S0bAvdSvvAVCZ/C7k8jam44NgHElnuvVJ6Am1uGB9W85p2JUTVH89F6gqLfcOIZuBQRrl/zaAHzAQlwUg50tIuPcze1ReR4ceP59rr/9LPuFzH2MFZ0l17ZLZz/ncNqZr7Zqt4rjAqQ7xE92jkcDvy7+I1s//Uj2cqCC43LOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=f8t9cZ8rz2zvqRmzB1A6bTQBLtolswypGC30HUgSHQ5jF+YAzTOtc7C4194+QYzugJeBptwluKyWA3SPkQVcyXmfyFFEb8ZBUyE4bSXD9iT68z5ridl0Xon3U7CzlGqvZpApkUXfpYkz7spUU606KXwhJrepz/LfEtPZbZKsC8yM/NN8hQ/daBPfpCOVb5E0pUR4Cc3INpxuy26BMIKYCZrX3TWjYnbOjl6TNJRgWozDb+HeQgk1zyeGrTaH04vgf5Ilap2G2YL1v/06nfYqweHoFSDkrDzPs8ANVtXG6F7bbIiukTkfJGDdwOCRHgjfMjtdnvfwdNHe/EOvB9f0sQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI0PR09MB7005.eurprd09.prod.outlook.com (2603:10a6:800:243::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 16:40:17 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v5 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHcu6zlZ3gA0iKA9ESQSdn1zP3ymg==
Date: Tue, 24 Mar 2026 16:40:16 +0000
Message-ID: <20260324164007.549397-6-djordje.todorovic@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI0PR09MB7005:EE_
x-ms-office365-filtering-correlation-id: 4952dbfb-f2c3-4459-cee8-08de89c407fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: P8XkwW7/7vx3mnUvgFdzxUm2MicFnM9/qGFbXZfx4doL6H2Q2GRw0mmnxSOOJFGZSlK7iHHWLAWH2CYPLAaCb65mmvUCCJHs2f1/XjOb3322cu4vU9L1kYJ7sekLIAkMlUBp9l5exFFAGc9Ekdgrm4JjSDaRyfsRI8y1ppfZ8Ebv6C3rLqyHrxOJcpmdlKc8qrOG1ZM03pOEMpIALviYH6To4fXN+ub6r9YmPzjFRRMQfsCd4u6q6CXZrfzoShZhRcLNQU+jy0ENQ/5UCYPlFZqu2oTYoQ6cZhoYLqUfjbuQSJymkn3PD0oqqfjjz2s5d442tVhMYLC9Pb3z7Tzaa1+527+kkkBILC/SgosRFv8Gc+Fyv6aQ3k+uoyQc+R0ssi+XKlptl4zUK+RH2q/hKxknDrdRxfpyjWrmSYZD89OdX72AE4jrzs8eF0GPyTwbRSSDhvg+FD5FHVxTKVQa/qNtS0e4xl5/+gdRDMB2BzFkFvHwauVpnAAJP2/S1Zmx5iOpkSLTS0phu3LClsyvW3RV1ZpYvt8u8KdqOfWfDGb79gboO5X4ULr473T+xcn303EEUfpU9qbIK1y+yxV3qMfjtMn/pk3oX51uR8fwZ33WjmNR+HqscD9UwsD42JTJ/Yq0jDLs3s5VVV8uXw6xeI9+MDfo3DKBi7B72i6FkpkUx7eOyA+jIebPv4JGoS5/NnQp/dGaR6wQ7LuqKfuwAD7Jp9zXJFrSLrrGMnUaEB8IGQENrehS6KvynTMNp1MHjOfg74cfKUyEND4mIgXrPPMldbq1VHDz8Zt7EV/ZT/4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnBkLzM0VC8rNXVadGVFODUrVlJ3TTZUQndib080RWZyQkVBek1CZS8vM1Rk?=
 =?utf-8?B?NnJKQ3p5NlBFNitmR0ZMWkQ2TUpKakEyMDhyZDVPZVlaT0NCNUlOOTlYZDlx?=
 =?utf-8?B?cUVDWWVJUXdCZjBPcTIvRWhsTG9zbU1nZ2F3UURBdG9YN2hhT2xWcXJvRlZI?=
 =?utf-8?B?aTRPRFlBZWwxMDZvR1pmR3FOejdsK3lxd29Cckx0bkhxbEIvaTlZYnBVSnhH?=
 =?utf-8?B?SEhRc1BPMmVoS0pPWUJYNm9SZlFTZFJTL2ExU1k3QmJLTWlTbzI3OS8yY3da?=
 =?utf-8?B?OUw2c2hrSkREc3pVSmhzaktWMUl2eTQ0Tk44UWJLRmRIK2QvVHd5aEMwdGlZ?=
 =?utf-8?B?TWRPZUFwOEdwQk9yRVVmdXNOVTZxUGlnMVkyUTltWENIZVY2SXlwbm4yVjJk?=
 =?utf-8?B?WHBQd05jbU9nSlFCUzVKRm1mQU1BY0J3RzBSK3JZcWJRT05kbXBrNmkzWnVl?=
 =?utf-8?B?R0ZSSmYxZHB3RTh0UE1lUlFKK1BOQmZwWVJwSzdhRWZWcUJiK1RaTERCOUFl?=
 =?utf-8?B?MXhLVTJRb1gvT01VQ2luM1I1aTF6eW9tYTE1Tm5YWGY0SUVxZHJyajhlbkJ5?=
 =?utf-8?B?bmpUMXFhelk4RjlmWnY0bjJQT0l3RTZDYUFMVmNwVXR4MVNWRDcwV1ptWEhs?=
 =?utf-8?B?c2dIU1dCSUdteUFiZWwwM0g2bDU5Mmpid0EwTTg1YUpuSCt2a3B2bGxjclN4?=
 =?utf-8?B?QkxSQnV5bTd6SmlvRTVpYmlRWGJKMkF3WkdYS0NSSGVjZGpDSDNLRURZY2tq?=
 =?utf-8?B?OHBvUWhrQ1J5RGxHYWtSTjZqM0tzb2Q3ZHVHbFBueE1PU01LRkVlWWVmMHBD?=
 =?utf-8?B?eTZiZEVIeFQ4a3BHbk5uN2pJUUg5S01nSXU1YUdjUThRekV4OTRIeUFZc2Ru?=
 =?utf-8?B?MTY0N2p2ajk2VjltWWNTRzJqOWZNMzVaZVVIaVFZd0xFTjBxZHlHREk3YTR2?=
 =?utf-8?B?N1YyeFIyYjQ5a3dOMEhBalNYZEpML1ZiUXJHM25hQnNMd09paHNvU3VON0J1?=
 =?utf-8?B?UG1XMjJyWFJJbzV6VkE5Q3YxdE1HNUxILzhWbXBKNWV6VFlzY0c2eWVnR2ZL?=
 =?utf-8?B?dGhIU0wyZkdQN1FrcGdyOHcvOGZxa2FPVDN1Um8xMjljYmt1OVU4QlFzVDlG?=
 =?utf-8?B?cGhBa1dlakpncUJlQ1ZBU2M1dzVsNDkwTlZROUh3N1RVQUZDNUVWaFVyanBJ?=
 =?utf-8?B?c2hQcjByaXVGSHJFbXRjSm8zcnFhOGs3N3Y0UjgyajdVK1M2ajVQMVlrUytz?=
 =?utf-8?B?cWFQV3BhTTArUis2WWdmWjExcnpIdm9KSTFHaE5XNDJPRVdlK1o1eklqWkFI?=
 =?utf-8?B?Mzk0RkRJU3R6ZHh1d3NFWkRhQW4ySzAxMVJzTy9oRlpMdXNWcjE0S3NVdFJ1?=
 =?utf-8?B?NE55YTQ3NE51ektBeHZ4VlRiYnlDTG9jZHhFUHV1MDgwTGxpNVhjMG53eEFX?=
 =?utf-8?B?eTNPSHRKa0t2TitmelNtM1RUMzF5MGpaY3B6b1l6ZkdhdCtybDJhUCtXTGpl?=
 =?utf-8?B?T29ZdmF3em1xR1d3ek1KZTRmNzJUbC8xUEpoaXNpZGlCQzZEQm44VnExckJW?=
 =?utf-8?B?SWdhbkNmVUxBYkxuS1ZTNERNVDBZUXdqbjVVeHo0aVZ5NnpLY0hSeW5CR09k?=
 =?utf-8?B?QUZoWlk3VlZsNUVpbE85RkZMSFFrM0p1VTNtbnNMNmZVcDdBcjFsNkwzWGxs?=
 =?utf-8?B?RFd2eFJLQUxxdnl0VmQxaGJrWTlTK1ZEbFFNMFY5ZldsRlNKMXdROTJDc1JC?=
 =?utf-8?B?aXI4OFJTZ0xiSVlPSXp6M3FsMEdMaTNFTDNHTXJCVzVkME94UklsV1k2cmgx?=
 =?utf-8?B?TzA1V0NXYmxEdlFZU3FEVTl3VG1Ed2poL1pMelRSdzJGRXdCcWtoYTFnTlln?=
 =?utf-8?B?NlF3UGZ6THhOLzROZitKUTFjd2M3VzVQbXdOdStSQjdwdVhNS3ZSOGRpbjJo?=
 =?utf-8?B?b2pwclBGc2JUeks1UnV4VkNQMlRYQmdoR3FtSHZQemJsMXI0TGVRNW5KQmhC?=
 =?utf-8?B?MUV4R1JaTktvekpxV3F0aGtCaDhuaGFEMVJSQkhYaEV6bUlvQkNNMngxYnZY?=
 =?utf-8?B?QkxQNmJPQ0ZOeFRiUDRmdXJJTUpVczNJaC9BU3JEZGJ2SVkrOFRFaEczODBX?=
 =?utf-8?B?Q0N3N0tVM3dGVlFoY2k2NmNOZFF1QWE0MGhPSmRwcDFDaFN3aDVLc1lnVmRN?=
 =?utf-8?B?bGtNQ0oyQ01ZNlNrQ0xxZ1dhUTlZbUhxbktKa1dzTUdtSWZ1UE5BVEdQTkgx?=
 =?utf-8?B?UTN6NWJxNU5YWEp4dElpVUJTd1NrdFNzTnhzcmVTdVUvaXhuckhGNDM4TC9X?=
 =?utf-8?B?Q1BGa3QzMWFTTUtYY0FPbnk2S0ZsSXplQlBMUGsxblJGMWNGZWZkVkJWTk84?=
 =?utf-8?Q?alZPfriWPlifSFeKuHbFVHRLqzyFRYNSlANSB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFB65B46A052744895E97DE2FE3AA6AC@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4952dbfb-f2c3-4459-cee8-08de89c407fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:16.7726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECF3ls8deg3gWNX4zoXFRw7uZDlxYxATcBI1Md2KcFAtLui0reVq3ktsDRjwvFJA8aj6wNjODKC4n6ZbKuj6byDOXNdLaBV1JSO54tTaOdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7005
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

