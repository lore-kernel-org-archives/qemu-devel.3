Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F642F436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVi-000520-IU; Fri, 17 Apr 2026 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVg-00050j-M4; Fri, 17 Apr 2026 10:49:32 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVe-0007DI-10; Fri, 17 Apr 2026 10:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErR4rOmAGKke0glebuOiHDPovvHaZRd9G/h89GzNpYw5qH6p/kpPIbRYkeWD4xGtBHHnVnyahqD3z5cNmJmEolSR2gt+IX/JxZgPeuNY9YbPs3B9LZzsD2yHuKa0n/H4oTFROangYBEzxlSHl6137mTnALxFiOFBj5cNgRN7kuqhoCG746iRE4dPwq7KWashSSJjKQCL6wLQjdL3UR63hT8F84y+iATR8KvIYTPOn01DWlkMAT1+NQUzH9h7Rm+jd3QX68ASF7iJ/o0GeSrClI7QU6r0ue+UzWUoMSpI4CmnTnyPbjI+Rb6aVIa1lu6jwovwAoyNp0+TtceQpPGlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSWTPWYOxHTX6l0cvhAcLKInV7KidfAXnh/bEmyHL94=;
 b=eHFfjYWvJMOq7M8pN6UFOPdRaehmO0g1/a0ZHFJ2uqUtTdGJL10k4Gq35MdwS19b5u+JnHzl7LPJbLzbsrAtkvwX5EDXdGqjzERP0Miaup0/7AHMlbMYyw0p0jowwhl7n9hSkv7eNuEAC4Kpr+9Gpq0ozmoaG9DkWqL19WFwE1jXacmg2ikRKNLEM27rHG08rgNP5TLbCwDve8ajeAb2xOM2A7UFvFT4tN/eM5l7kMqEQPGCFyX1Xz7FEHDI78AXvgFnf6e9isIbso2eCA/0xXJEWKwffcsBltaNxOs4EHzLkvZW+zPaJDwowvZDKHw9VcAMy7a65T/P5x8X3yzrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSWTPWYOxHTX6l0cvhAcLKInV7KidfAXnh/bEmyHL94=;
 b=DUcWvsn32uj4JNRoeP1zsQ4lLdnQbY/z8412PkD+vb4NrCXp8FfHcW5ixHK5WGB5OInnf+MxR63OMMBb28SKhtVqEvz7FjdMCBPiqlP6f8/jyBsVd46HaafroJv8/AsPmi8KNr50EgEIfSIK3cGjdg+tODLt6pigh5c/4mA7nLvLxLgHuPOE38mkIg+Aee3HvR7zWPcjnVUJD0N9DZwQGy325VkB+54TZYOO5iD0OX2EF0VCryFJX+nsfUxdq13dEGE/jBxg/dSjchuGMblfI2pg2vL/dedgcvfX7JMXjbSCpMCZL+Zy8cfKRhxKkhi33oUK6MYfm0Ck+sAcsUEeEw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:15 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 7/7] target/riscv: Add endianness test for RISC-V BE
Thread-Topic: [PATCH v8 7/7] target/riscv: Add endianness test for RISC-V BE
Thread-Index: AQHcznlcdt5giNjZf0uhN8EWD1k0ug==
Date: Fri, 17 Apr 2026 14:49:14 +0000
Message-ID: <20260417144905.178056-8-djordje.todorovic@htecgroup.com>
References: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: c2fd5727-65f2-42f8-3b44-08de9c907f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: fzZnzw/lBJCmnELMiz1GpyXJcgpvDv34YkcJiHK7WCGC5buZhfospEl1weBxrqoWKvWSBQJ34NVUICKE00PbVD1L4itqsx94FZvNIzAbJj4vBa47zMF8CYLI5t4cpdsSAfLiTReniAb2L+z+K51raH3CIceXxnG5j3CnhzV7+v9D9OcgfpCoPmjyCCUW+ytZizzoN1ZMKCNkd8M/mCleuZIX7Esr3625iv7o5bNtoOpfgsvkCWkMynECCvR7crJzz4D3GoU6qeuczjaVCWtvLb8urtPNt/jc8b1g43iQBAQTkSHm4N6NzUK7LdSy7lUAkMUdGa5XzBfxamIp/25OK+t9ZuuPuHffEpDQcqdolA2KYPXL44r9bA4byBAiN6gdJzzkDecv1o0di+TkOFBzdJwkDiv3a2QXNtk6jXZgXBIkeQ0+eToN25vOfEEMfZ8UJMMmPin7MfGyj47hAas8/aaD6gE1M8OmeLBiF9hs89jBAiqaCvNIiPWYZQ6zfvH877NyG/Pv/JZS9AxIoHMpFcve1sjEqHPozBqIlL7xmiDW74FlZRihc/8p38wLd/KAA8t0VZYEQYXQ6tu11LGDoI3Ccg+W4W0bkRF2MHbsE3bCidNGrfrl+kVyGgEG/LqK1bUsRZtpAKmka5fCGZEPuFavF6YjiClcuKk3ALPIWBmqx8sMyzQoswq/j0YtXWOpJSY2Y6hCj0/9+JKxvyoctVnkQPJNfGBq20fjuKTjTov0pNy1UKV3rXr/MN6EgVUv4zq39GcCUmjVvg8aO0d5E8vbVA/9+jkRZ2zJ2n6O2uU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0pjNEZXTzEyYU5UcUVsTmVhVnIvdFlIYkJ5djhDR016NW5KZzMyMUYrRGxC?=
 =?utf-8?B?SjIzTUJxWk5Od3NrUUppMk5XSmcrOVJMVmh5Z2t0QWlRU0ZQcFczZ3lKQWEx?=
 =?utf-8?B?NW8zWFpCNGRncHE0bXgxTUNvN3hLRGxWQThXR2RBclJSdlV0cHhpaURQNnpn?=
 =?utf-8?B?blJIZTdrbkRTNCs5TTA4d0txc2ZFUnNBZ0xBK01ubHp3MjdrTXBRdFN4NVJB?=
 =?utf-8?B?a1dZcndVUUQzdmNtYWRqbHpjQ0JDOWlzRjFPQkdUc1g3UVdSWkw1Nm1HNnN1?=
 =?utf-8?B?d3IrWVlTN2xLczlPcXo4QUtsdXduakJTd3pRd2FJU2M0NW1jWWc2L1NaT2E1?=
 =?utf-8?B?cUF4ZVpzSnNYUmc0Vjl1NGJFSWNaL2RyREFMV0Mrby9Xc3p3YjdjcFpLRGJV?=
 =?utf-8?B?T3d5YXhzTzhRNjZla1N6K1JvMkJNMEdnZFhYL1RVOWlzcHU1bXUxSk1HcGdn?=
 =?utf-8?B?WnpMckJoT3g0czRUUFRzRWIzeVo2YmVRWXRZNGpodXAwSlVkZlFWSkNDUy94?=
 =?utf-8?B?Vmlna3BrdmdnbDI4VW90UmtwdEF5dG5haUd6YTJEQnpwM3Vsand3ayszdFZR?=
 =?utf-8?B?K0dMYXRWMTBZbjdTYWt6bUkrdm94aER1Z1NrY2pGbU1PeFRmbjdsSllqMG05?=
 =?utf-8?B?NVEwbnYrLytOTkdYUGtLMW50eFBocSt1NVRmNERUSzRYdGRrbjVkb3p6emh3?=
 =?utf-8?B?RkE5L0VlYmFoSU43b3pZejB3MERWTjBhS2FldHFnamZzdzAwVm91YmFWcDgw?=
 =?utf-8?B?MXd0ZnpMUVNieWtnQXFSMjlYaHUzZUhnMURuYnBYZ2k1VkluMi9ZWll3NXhJ?=
 =?utf-8?B?V0krMjJzeU1FOGZBSENReFNNTXl1L2NiSEx0N1Ayd3daOE14bForajd4WmpY?=
 =?utf-8?B?K3NuRXhLUVJzbzdxcFVUK1ZjOG1UdE1tUzBUWnQwemw2dTRURTFveUNhK0Jk?=
 =?utf-8?B?Q3NybXFINERwQ0FhYnppZHBJWlF5OU90ZXZTcXkrWDNTellCMG45LzdNQnIy?=
 =?utf-8?B?bDRHdWUzRjFiNVlTVCtLTXBBaWtjeEtXMVBxajhEYXRwSGRYL2tDMnFFZ0tZ?=
 =?utf-8?B?eEp5QWJYN0FtYmw0UVNaRzBnUFRUUXNQV2dmN0JBaFVNYWcvdWhwVm53bWNj?=
 =?utf-8?B?dzZwc25Cd3ZrZGJvbXg3d1RxWE1NS3VHS1J3djk4cGJjYzNBbE5DallIWXZ4?=
 =?utf-8?B?S2lQOHNJKzMzeitLWGlvSEtSWk5MVDVGeUc1STQvSjV4THc1MEd4M1Y0d2k3?=
 =?utf-8?B?NlNpMWljMjFzZXVuRWRKaUhFK3Y2MkZpWEpEMnU1T0RlWExYRUs0cHpQQVJp?=
 =?utf-8?B?TlEvUmd5YkVITTNyTTAzRi9OdzczRHV2b0NJSG9kcnV1MC80ZkFJVHFlRFFl?=
 =?utf-8?B?M3B2djltaTJheHZsWjA2dmsyZjdiV3gxeWJ5a3JoN3BkOCt6emU3TlVhc3l3?=
 =?utf-8?B?MG9TUzlVVFFpRTlSL2hxV0xMRDZkSWwxb2lWQi96WUxrN25qbnFSdnNwM3Ba?=
 =?utf-8?B?WEs2UWJwOGxPR2NyTzZ6R1VvTGRST21LeHVneEg2R3o0UU1WVUFvd2IwQ3Av?=
 =?utf-8?B?a1dvRE9ETWRZaUtOQmhSYS9IUWtGVy9hRlM3ZmVXZTdPRkE1M2w1eGFoTHRY?=
 =?utf-8?B?R1Q5bi91S0ExSlZqbXNha3JLRmRHNFJ1U3RaWVc4YWRYMFkwUFVkMlZHazVM?=
 =?utf-8?B?MnhzQzA2bkZZNWpXSzBtdTVSeUttLzFEUEllTlhyY3NCdnJDVFlTUVh5U2pm?=
 =?utf-8?B?dkJIQ25iQU9rbUNGSUxEM1RTOEhXUXhwOEc1b1pDWUVoQWtyOUZXemovYzdZ?=
 =?utf-8?B?Y3BVQ1ljTnQ0RWF1UUFCK2U5SWwrdEc2dDhBN1Y4SEtEMU9kZzVPNWI1dnpR?=
 =?utf-8?B?Qm9pTVhTVEE1T1NKeUNJUnR3cEZRZFRKbXZzMUpFWDVabW1EQjFTSCtlbVhN?=
 =?utf-8?B?cTdxQW9TdU5OY01odlJrbHZ2ZTZTMzNEZnhKUlF4YlZ2RC80T1FEYmk5bTVl?=
 =?utf-8?B?MnBMYTJvOUk2RlArZjNNNnR3RmlkV1lML3NxTm8zeWhsSS8xNlZLRCt3VmZX?=
 =?utf-8?B?aGpSZEVZYnVMM01FLzJzSmM1YzM3QkxKdjM0bVM0MjBzVmlUTlA5Qy9aUFRy?=
 =?utf-8?B?cklIME13aHp1VnFrRStHUFJIVmlmcEd2b0xBbDQxVmVhdFhGMVhENHRtNEti?=
 =?utf-8?B?K083WW9FRFNaVS81cmd4Ry9mZ1RDWmY2T2Z4ZlhCUWt4ZVVoZGZ1cURRT0xN?=
 =?utf-8?B?R2EzRmkyTC9QQmVuTS9Ua1gzZmFEM2xwcC9uaXBLRy9UL0pVbFcxMTZEVmxY?=
 =?utf-8?B?aUQ2SVUxMGl4S21Zd3ZkZndjcDFqUkl2WGpxSGlVbXVjMDBTOUFmRDluY1d1?=
 =?utf-8?Q?PF370GMhN4vIjozYU/wxcHcbr10CJ+vSsqIWT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E23656B2A4B24A48841E67720522C1C9@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd5727-65f2-42f8-3b44-08de9c907f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:14.4832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIihmBuRomdL+FY2wipZ4JT+Yp/nAP6ZZxiAHXt3EgsIkA7CCMjarUb6GWSsNVyzbnk5AkwqRSGrQNQZYfnuRGF5ZnJtuXVExv5EVHnbtMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
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

QWRkIGZ1bmN0aW9uYWwgdGVzdCBmb3IgUklTQy1WIGJpZy1lbmRpYW4uDQoNClNpZ25lZC1vZmYt
Ynk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0K
UmV2aWV3ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCi0tLQ0KIHRlc3Rz
L2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZCAgICAgICAgfCAgMSArDQogdGVzdHMvZnVu
Y3Rpb25hbC9yaXNjdjY0L3Rlc3RfZW5kaWFubmVzcy5weSB8IDU3ICsrKysrKysrKysrKysrKysr
KysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQoNCmRpZmYg
LS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQgYi90ZXN0cy9mdW5j
dGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCmluZGV4IGI5OTZjODlkN2QuLjU4NzEyMTFlODkg
MTAwNjQ0DQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCisrKyBi
L3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KQEAgLTExLDYgKzExLDcgQEAg
dGVzdHNfcmlzY3Y2NF9zeXN0ZW1fcXVpY2sgPSBbDQogXQ0KIA0KIHRlc3RzX3Jpc2N2NjRfc3lz
dGVtX3Rob3JvdWdoID0gWw0KKyAgJ2VuZGlhbm5lc3MnLA0KICAgJ2Jvc3RvbicsDQogICAnc2lm
aXZlX3UnLA0KICAgJ3R1eHJ1bicsDQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9yaXNj
djY0L3Rlc3RfZW5kaWFubmVzcy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2Vu
ZGlhbm5lc3MucHkNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwLi45ZTBi
M2I3ZGI1DQotLS0gL2Rldi9udWxsDQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVz
dF9lbmRpYW5uZXNzLnB5DQpAQCAtMCwwICsxLDU3IEBADQorIyEvdXNyL2Jpbi9lbnYgcHl0aG9u
Mw0KKyMNCisjIEZ1bmN0aW9uYWwgdGVzdHMgZm9yIFJJU0MtViBiaWctZW5kaWFuIHN1cHBvcnQN
CisjDQorIyBDb3B5cmlnaHQgKGMpIDIwMjYgTUlQUw0KKyMNCisjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQorDQorZnJvbSBxZW11X3Rlc3QgaW1wb3J0IFFlbXVT
eXN0ZW1UZXN0LCBBc3NldA0KK2Zyb20gcWVtdV90ZXN0IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xl
X3BhdHRlcm4NCisNCisNCitjbGFzcyBSaXNjdkJpZ0VuZGlhbihRZW11U3lzdGVtVGVzdCk6DQor
ICAgICIiIg0KKyAgICBUZXN0cyBmb3IgUklTQy1WIHJ1bnRpbWUgYmlnLWVuZGlhbiBkYXRhIHN1
cHBvcnQuDQorDQorICAgIFVzZXMgYSBiYXJlLW1ldGFsIFJWNjQgRUxGIHRoYXQgZGV0ZWN0cyBk
YXRhIGVuZGlhbm5lc3MgYXQgcnVudGltZQ0KKyAgICBieSBzdG9yaW5nIGEgMzItYml0IHdvcmQg
YW5kIHJlYWRpbmcgYmFjayBieXRlIDAuIFByaW50cyAiRU5ESUFOOiBCRSINCisgICAgb3IgIkVO
RElBTjogTEUiIHRvIHRoZSBOUzE2NTUwQSBVQVJUIG9uIHRoZSB2aXJ0IG1hY2hpbmUuDQorICAg
ICIiIg0KKw0KKyAgICB0aW1lb3V0ID0gMTANCisNCisgICAgQVNTRVRfQkVfVEVTVCA9IEFzc2V0
KA0KKyAgICAgICAgJ2h0dHBzOi8vZ2l0aHViLmNvbS9NSVBTL2xpbnV4LXRlc3QtZG93bmxvYWRz
L3Jhdy9tYWluLycNCisgICAgICAgICdyaXNjdmJlLWJhcmVtZXRhbC9iZS10ZXN0LWJhcmUtbWV0
YWwuZWxmJywNCisgICAgICAgICc5YWQ1MWI2NzVlMTAxZGU2NTkwOGZhZGJhYzA2NGVkMWQwNTY0
YzE3NDYzNzE1ZDA5ZGQ3MzRkYjg2ZWEwZjU4JykNCisNCisgICAgZGVmIF9ydW5fYmFyZV9tZXRh
bChzZWxmLCBiaWdfZW5kaWFuPUZhbHNlKToNCisgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ3Zp
cnQnKQ0KKyAgICAgICAga2VybmVsID0gc2VsZi5BU1NFVF9CRV9URVNULmZldGNoKCkNCisgICAg
ICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1iaW9zJywgJ25vbmUnKQ0KKyAgICAgICAgc2VsZi52bS5h
ZGRfYXJncygnLWtlcm5lbCcsIGtlcm5lbCkNCisgICAgICAgIGlmIGJpZ19lbmRpYW46DQorICAg
ICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWNwdScsICdydjY0LGJpZy1lbmRpYW49b24nKQ0K
KyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZSgpDQorICAgICAgICBzZWxmLnZtLmxhdW5jaCgp
DQorICAgICAgICBleHBlY3RlZCA9ICdFTkRJQU46IEJFJyBpZiBiaWdfZW5kaWFuIGVsc2UgJ0VO
RElBTjogTEUnDQorICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgZXhwZWN0
ZWQpDQorDQorICAgIGRlZiB0ZXN0X2JhcmVfbWV0YWxfbGl0dGxlZW5kaWFuKHNlbGYpOg0KKyAg
ICAgICAgIiIiDQorICAgICAgICBCb290IGJhcmUtbWV0YWwgRUxGIG9uIHZpcnQgd2l0aCBkZWZh
dWx0IGxpdHRsZS1lbmRpYW4gQ1BVLg0KKyAgICAgICAgRXhwZWN0cyAiRU5ESUFOOiBMRSIgb24g
VUFSVC4NCisgICAgICAgICIiIg0KKyAgICAgICAgc2VsZi5fcnVuX2JhcmVfbWV0YWwoYmlnX2Vu
ZGlhbj1GYWxzZSkNCisNCisgICAgZGVmIHRlc3RfYmFyZV9tZXRhbF9iaWdlbmRpYW4oc2VsZik6
DQorICAgICAgICAiIiINCisgICAgICAgIEJvb3QgYmFyZS1tZXRhbCBFTEYgb24gdmlydCB3aXRo
IGJpZy1lbmRpYW49b24gQ1BVIHByb3BlcnR5Lg0KKyAgICAgICAgRXhwZWN0cyAiRU5ESUFOOiBC
RSIgb24gVUFSVC4NCisgICAgICAgICIiIg0KKyAgICAgICAgc2VsZi5fcnVuX2JhcmVfbWV0YWwo
YmlnX2VuZGlhbj1UcnVlKQ0KKw0KKw0KK2lmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQorICAg
IFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQ0KLS0gDQoyLjM0LjENCg==

