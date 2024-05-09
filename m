Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A21DC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 04:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4vTV-00086T-S3; Thu, 09 May 2024 00:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s4vT2-000801-9u
 for qemu-devel@nongnu.org; Thu, 09 May 2024 00:33:17 -0400
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s4vSZ-0003vj-CF
 for qemu-devel@nongnu.org; Thu, 09 May 2024 00:33:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDBN7iW3EMAB/em11T/2XVxWSMQ8qKj1g/xmKOCz5tam4kGXdYBLJshEEeQag+bXr8+co92PH8fte7HjL7JPzdzZi4C8+IoP+WPX21dCbIP7+W4Ka8fTbLPDAhjgCAaRe9Fqj8QziR3mg+kkpJgCSx6lq1j1HbslgOh/xrV16SXWKpFyH4s61G7OBtKdpk9ufxiNxgc1kbZTIcjXTF6MHYdHCxKZZ9f74TRCIGuWwLlUpzakRGqDWP6S38KiCqTOL3GprlW84XElhvV9kyX5uc5mnz413yRHJki7Q+vWukutTckz2qSCHFcovZIVEI4FPbrlm7Mn5lP0v9n4+HTZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ogl1Jgc1iWCZS6F/UqfktDCKD01lnx3Yi6zvLNql12g=;
 b=Xke4tLkq6qQ0Mvi7DH4Dx+qt4OabR0+DOzxCFZ9DD7DcxRDcqdbfFUcnWNcQXpJ6UNliJvH3WGwSJwFylmBnRFNMqjPOSl2rzGtG4/qQo13TVgAVH4K+AH8QMr1cRsxNEpQCSYhER5sMeQZ5Cz0e4+kRyXJl/qFp4BRuoOtzC3oPITGELpgDETiTkqfSwi0G2prjqB3UDzoPe2YXBPIBTWDPj9motBp8RdZvUn68x8c1K09N/4Uc6Donmg6Yxi41NFvLatKnd9DW+Q3LAxei5S+XfTRbTVZsrB3hy0XErzflGl4RsS9VYvIbeRp95EtXWZlgp0tRe/HTMv/ou+tPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ogl1Jgc1iWCZS6F/UqfktDCKD01lnx3Yi6zvLNql12g=;
 b=AL4BSoFlSZUhGi1MC2owl3gIHSioWW9pGzGGg3shlktS5GT13w9LLqOI0f924wxsvT9Tm0r+m0XHAL3PRvOFUZnTsXPUm8XRkP+6jqIklY4oZsozjAFnTflDDPk+KWkja/+EpYSyQGOM+VlbF879LcsgJNOENPGchbdYVvgc65yhZc9zvXvSguXp0uMiXS4Grl/4BqlU6GGQiid8eznfZI6XPtQmg41nYXGmCNCYWguUJw5/mcjq/ZUbfHaS1X6LAoEzE6D1Ai5UA47z/XZxLg2B0mWJBm+ZEq547KtbGr4tgiUZqKRO/0wsuPbSpFJqg2Wzn1nyltuY+1/d7s6ELQ==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by PUZPR06MB5554.apcprd06.prod.outlook.com (2603:1096:301:ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 04:32:38 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 04:32:38 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "eperezma@redhat.com"
 <eperezma@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Angus
 Chen <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Thread-Topic: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Thread-Index: AQHalFY2N838jhUkKUe7MN2Lx45RabGMz/EAgAGZHRA=
Date: Thu, 9 May 2024 04:32:38 +0000
Message-ID: <PUZPR06MB4713007E9C50E8EA599C44F6A2E62@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
 <CACGkMEsx1TKnCwHWnPN0srv3Xvf_Ji1Kx=y6mxVZ0AW_Zg7hDA@mail.gmail.com>
In-Reply-To: <CACGkMEsx1TKnCwHWnPN0srv3Xvf_Ji1Kx=y6mxVZ0AW_Zg7hDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|PUZPR06MB5554:EE_
x-ms-office365-filtering-correlation-id: 1f20e2e8-e04c-4b9f-5eee-08dc6fe10e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RStDcXo2M0J5dHB4MzR6MUVPVzBvZWFWT214Zm82SXJ3c2xWNzlvTWh6WFBo?=
 =?utf-8?B?VzQwOTVrUWhjVkMrK1hSTU16a01hYVNjQ3FnR3dZcnc5S3h0YTdsamZqT0JH?=
 =?utf-8?B?OGE5VWZBd05YYk9PSVBHY0VkVjVXeGlFK1lDRXlzSis4K0VFVUF4V3Q0OEJV?=
 =?utf-8?B?OW11Zmh4VnNacjRRbGZYaG5KS0dPRERXbHdjby9TUjBYa2hmUndTVmtKTHZY?=
 =?utf-8?B?Mi9HbkJNTUhjMFlBY1hHSTRianhMbTMvd216dFhZOVh3bWREdmFrNEdLQkp2?=
 =?utf-8?B?eWhHMjlESWZjTG56UnIzdmd4ODhkWGZvbTB0Vm44OGdoQktNNjIwL2N1ME9F?=
 =?utf-8?B?N0hONW5DdTJETzZRK0Q4Q1RDZldUVG1MOEx2bW9XSG9jbko5Z1BDUDdaQ3la?=
 =?utf-8?B?Mm5Td1hjZXByWjEwODBjTHRUK3RveDNVNkVYNFE4a3dEMGFlUlAxMmNsM3Rj?=
 =?utf-8?B?M01jQzBFYlAyTDRnYUNhOFJUZE93TlNmU3V5NUMwMXdMWTNCaFpLVGF4UFZo?=
 =?utf-8?B?cGVQU1doYUNsYnhSWVV4c3lSQld1eFJmRU1kRVovVGczVWNIMENVTlpVMWdq?=
 =?utf-8?B?QUtkM2hBVlMrQ2RaYWh5Rk05OWdLQUZtejQraFBkQUdmdEhXUVhzOWhBUVY2?=
 =?utf-8?B?QVM4bUptY3VQbTdvQ2hYN0Jmd1kyNDBIZDdDRlRxVHYrblN6MnVqaFoydFM4?=
 =?utf-8?B?VU84Z2I0L3hPV01rblpreXZIOUdRdTZZNEIzN3ZYTDVlNHpNd1kwSm02ZWU4?=
 =?utf-8?B?dGFiTlNTNFBEMXNPQWpxVTFNMlNXTnYxRE9wSTNWbXdVZHNNdW92RktKT1JY?=
 =?utf-8?B?Y0lvdUw0YWtyRmxSdi93L1IxUG0xVWRJckZZLzdSYTM1OTlIbHdsMUVlSi9P?=
 =?utf-8?B?ZngzOXdwbWcxNkJlS1A4Wk5rVU96RWJGYzQzRFIyb2p4ZG1KaU83aktONFFU?=
 =?utf-8?B?NHMrdlhzNXRYR3NsZkppbHY3M2E0Uk1pWXlJbzZCZXB5VkFqdXJwWlBhVUVz?=
 =?utf-8?B?OGF0ZjZKWDA5ZElIdkorcTU1VWMzUlc1OFZiVFBWcnU5WkRRdGhRTUpNbnFM?=
 =?utf-8?B?NDNmbjFvbmVtM1AxbGNLQnpKZklOMjVPNkhMMElTK2tEcGlXNFRrM2l4VzFi?=
 =?utf-8?B?R0hBVGFLTUxMMUhDemZnWFpRYWZDVWV6NVpVZzk1aHdEbEVUdGJ6NmFjM3lG?=
 =?utf-8?B?QVAxQUpqa0hWa0ZBenUwLzRDQmNjOElhczFGdmd1am9Ha3IxRFR6bXJGUkll?=
 =?utf-8?B?TlZBdVFDUm10bkpDKzNHdWNIaXJCam4zajVZMjU4RW9zM2pGcWJwSDFMUlVx?=
 =?utf-8?B?aGg5R3UyWFRBdmNrSHI4SVlKRzJhMC9mdjJVclYxazdJTVJSYy9xOGczdzJ2?=
 =?utf-8?B?bXJydnhiZzRTc2MzNGNFNy92SFhQTUErVE9LZ0xDeWdSdDFXN1JPOFdGcWZ6?=
 =?utf-8?B?NGhua2hPTXlYVDVyNWNuY1ZPNHM2UnE3OXRSd3IyUTJKN2gvdWtPT29vR2Uv?=
 =?utf-8?B?Q3RUWVlRUUkwL2VPSGFHbTlDcVp2NXAyQXlHRUNyWlZTRDFLZHp3TEp5WmZu?=
 =?utf-8?B?NWZ0d28wcWlRaFc1eWZ2UXhBeFNvUXREZGJtV0pMMEE4emZ2TlU3QVpCaFVp?=
 =?utf-8?B?SkZEZHg2MC9BQVg0aFZ4UmdLR2xDamJmNHdMRGdndDF1Ni9tL1JXZVZJbXFv?=
 =?utf-8?B?V0JVUFZ5cGw1KzQ1ZmdWUWJXSUNEOUd4eTFpMzBFK3JKaE1VbUVySy9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDkzY05tdFlIbjNDemMxNFpDNGcvSlh1QmFrL1hZMnd1WmcyM0pFOFUzVVdx?=
 =?utf-8?B?a0pQS1ZmaTEyUVc2UDYwRXAzbERCR254NGZndmpKNEp3ZnFRVDNSWjgva0lr?=
 =?utf-8?B?V1VLMTgwcE1aelJLU2RldWRXb21jQjZPc3dTUklVN3VhQStXblZCMEo2UXZ0?=
 =?utf-8?B?M0NvTzRLNWtEVFV1RHJlVUc2OGRMNUQvaVhVakp4SzR5T25rSUt2K2c2MUpZ?=
 =?utf-8?B?TkE4cjJUQ3F3NksvNnhHaUhEbFlIRWwwRG1TKzl0cGp2K0duNlFWeTBUL0x6?=
 =?utf-8?B?Q0ZOMlB6V3JZTkh6VE4vM2xxMnR2cmpOU1dWMHRhVXZ4U0lGTlpUYUdWeEQw?=
 =?utf-8?B?ZnN2bDk4dVg0Y2NXNlB3WlRUZHZXanFGeldvR0VWeW55QVNYcUdVS2hXdUdv?=
 =?utf-8?B?YStBMUJFOUFWenhDMys3WE9HVzR0RkhpdzdGdVI3Slg1NTBvdVpXdEZoYk52?=
 =?utf-8?B?SG9UaUx1SmRRa0R6NGpGVFVtRjZzajNqZ0dsakxGWk04SEVvWk1XeUN5QmFi?=
 =?utf-8?B?UVZLK2hqZUpxb3BvdmVsUFFXNHFucFluK25iTWRRclJVNGtKaHFwTTFMSGhL?=
 =?utf-8?B?eDlNTE1naTArelZiRVMyT0hSYUtuUnpHekdRcnU4Z2VSYWtXbWhOTjBuYXhR?=
 =?utf-8?B?dDA5Q0lkd1B0eGxxckZyckVtVk9KRElPL3lZVXFPNmwwMkpiL0c2U0k1aDNF?=
 =?utf-8?B?eVVDSzhkMDZkZ09ITVNhUXN3eHNVRWFBa2NkdjJIWUxGb0hVNjNmOEd0eklH?=
 =?utf-8?B?WXYwWXNRZktoeTJoWGdHK05FcGtMOU15MHc1c2lDUkdLRmEvTCtleUUrQkI2?=
 =?utf-8?B?amo2eEVWUUlDSVV0Ymt0NU1MZEhTaWQzZTBUOGR0QVkyR09oU1VwcE41Qm4z?=
 =?utf-8?B?VklSSUVaZTNJRTI0Ly85M3FBci9SVFExN0pORkFRamNLTzBMRzdYM2FKT1hD?=
 =?utf-8?B?MHNlSHBXeVRSa2hNRXRnWEZGL1NnVXlBdG1VZzJqRXJrSFMrWXo1TmZkZkQ4?=
 =?utf-8?B?VUVZbTJueHdDUEg1S2lJUHZsMDByeFlWS0RGR2RaRW5mZ0NIcDdoSHZsM3NF?=
 =?utf-8?B?N01TQ2dSdTRyRFJzZTAwN0l1YXpMVjQ4K2xJMGtXdDZhd3I3K3VwWkVray8r?=
 =?utf-8?B?N3YvNDl6RG1YUDJwTTZxUll2bUFUTjZMRlBZbkxmRkMrSmZ4d3dWbW9uVlhj?=
 =?utf-8?B?MHRNVnRwOTVta0hzc0dObEkyeFVKUHFNaWs4TURaZ0UySE1aM0w1b1RIVmUy?=
 =?utf-8?B?VGhkeEsrTmI2ZnBIYTYyVFhqSmR6MWlGb01nelpQVHRBYXlYWEwrUjRMbVcx?=
 =?utf-8?B?aTBrZElRMHVLOUQzYTlkNk5GVDJFdDJvUVd0Y0J4cmJINzBHdmFFT0VJOEF5?=
 =?utf-8?B?aERBaTRPR1RhMEl5TTE3V2thaTBaS2lQaWNLVC8wMGhJZjdHZmNCU3NWNzRT?=
 =?utf-8?B?bDB5REc1MkVQbTNDQ1JRN0VXNXdPOEVKLzNJcUZsbEljTlkzOUpTUkpQNFZy?=
 =?utf-8?B?ajcweWdiM2xxZTh0VW5IeU85RFpjeHBQRFhXdVpGWUZDOWVSTFJ1ZllyVHpy?=
 =?utf-8?B?cnJVM0JjektvNXo4VXYvVlFMYTY3bXRkTE53NnRmazhxZys1anJ5eFY0N2Zi?=
 =?utf-8?B?eUQzM21sbGJ2dmpyR0dkYzMzYk9UdUNMZGdWRlVDUHdpYlEycmU3c3gvQzJM?=
 =?utf-8?B?TmdnVTA3RFA2Sk4rTUxzenE2RDVmaWdsUFZ1K0VyazJkUnhxeTBZMjBtMGti?=
 =?utf-8?B?aC9ZLzE2RHVYNjVRWVkzUnA0S0lCSkYwa0Z4Ukc4OW5Scy9qQ2MrbFp6anZq?=
 =?utf-8?B?UWFsL1htMGtjQVU0TzhUS1JqNkdvRHE0YytTUE52WWs3TkhNVzd2NnRNMzNv?=
 =?utf-8?B?Z1FLSXEwRnc3SmUwejlSQzFoc2pwWTBSaFhyazdtemZNMURHenpBTnJiZThG?=
 =?utf-8?B?eG4rMkFIY2RsLzZ5SksvRVFwU094MEx5RXdtL2t0TVJLRE9pcDhDR2hlSjNT?=
 =?utf-8?B?VDJYTjhNSEJaYjBIN25Pd3U2ZmQvbW1DK0xvdkJpQVdaeS9RMjg3VEZ4YXRt?=
 =?utf-8?B?MUtPZTVCd1VNOEVsNHZVZTIwdXJQdnh0ZXpwYTl1WC9lU3o3SllwdmRLQ2Jw?=
 =?utf-8?Q?7laKB/x3uBr+YyHpyfWZmnAhq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f20e2e8-e04c-4b9f-5eee-08dc6fe10e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 04:32:38.1410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYYd3hCwBfEGLnN7e6iWR3+rNwiDQDKeyIBGBRVyMjPANcptBsJEZG2cmktPK9PeFJpRR4iZ5ZNPo3I5TyzEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5554
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

DQoNCk9uIFdlZCwgTWF5IDA4LCAyMDI0IGF0IDEyOjAxIFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBBcHIgMjIsIDIwMjQgYXQgOTo0MeKA
r0FNIFdhZmVyIDx3YWZlckBqYWd1YXJtaWNyby5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIHZp
cnRpby0xLjMgc3BlY2lmaWNhdGlvbg0KPiA+IDxodHRwczovL2RvY3Mub2FzaXMtb3Blbi5vcmcv
dmlydGlvL3ZpcnRpby92MS4zL3ZpcnRpby12MS4zLmh0bWw+IHdyaXRlczoNCj4gPiAyLjguNiBO
ZXh0IEZsYWc6IERlc2NyaXB0b3IgQ2hhaW5pbmcNCj4gPiAgICAgICBCdWZmZXIgSUQgaXMgaW5j
bHVkZWQgaW4gdGhlIGxhc3QgZGVzY3JpcHRvciBpbiB0aGUgbGlzdC4NCj4gPg0KPiA+IElmIHRo
ZSBmZWF0dXJlIChfRl9JTkRJUkVDVF9ERVNDKSBoYXMgYmVlbiBuZWdvdGlhdGVkLCBpbnN0YWxs
IG9ubHkNCj4gPiBvbmUgZGVzY3JpcHRvciBpbiB0aGUgdmlydHF1ZXVlLg0KPiA+IFRoZXJlZm9y
IHRoZSBidWZmZXIgaWQgc2hvdWxkIGJlIG9idGFpbmVkIGZyb20gdGhlIGZpcnN0IGRlc2NyaXB0
b3IuDQo+ID4NCj4gPiBJbiBkZXNjcmlwdG9yIGNoYWluaW5nIHNjZW5hcmlvcywgdGhlIGJ1ZmZl
ciBpZCBzaG91bGQgYmUgb2J0YWluZWQNCj4gPiBmcm9tIHRoZSBsYXN0IGRlc2NyaXB0b3IuDQo+
ID4NCj4gPiBGaXhlczogODYwNDRiMjRlOCAoInZpcnRpbzogYmFzaWMgcGFja2VkIHZpcnRxdWV1
ZSBzdXBwb3J0IikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdhZmVyIDx3YWZlckBqYWd1YXJt
aWNyby5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L3ZpcnRpby92aXJ0aW8uYyB8IDUgKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L3ZpcnRpby92aXJ0aW8uYyBiL2h3L3ZpcnRpby92aXJ0aW8uYyBpbmRleA0KPiA+IDg3MTY3
NGY5YmUuLmY2NWQ0YjQxNjEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby5jDQo+
ID4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby5jDQo+ID4gQEAgLTE3MzksNiArMTczOSwxMSBAQCBz
dGF0aWMgdm9pZCAqdmlydHF1ZXVlX3BhY2tlZF9wb3AoVmlydFF1ZXVlDQo+ICp2cSwgc2l6ZV90
IHN6KQ0KPiA+ICAgICAgICAgICAgICBnb3RvIGVycl91bmRvX21hcDsNCj4gPiAgICAgICAgICB9
DQo+ID4NCj4gPiArICAgICAgICBpZiAoZGVzY19jYWNoZSAhPSAmaW5kaXJlY3RfZGVzY19jYWNo
ZSkgew0KPiA+ICsgICAgICAgICAgICAvKiBCdWZmZXIgSUQgaXMgaW5jbHVkZWQgaW4gdGhlIGxh
c3QgZGVzY3JpcHRvciBpbiB0aGUgbGlzdC4gKi8NCj4gPiArICAgICAgICAgICAgaWQgPSBkZXNj
LmlkOw0KPiA+ICsgICAgICAgIH0NCj4gDQo+IEl0IGxvb2tzIHRvIG1lIHdlIGNhbiBtb3ZlIHRo
aXMgb3V0IG9mIHRoZSBsb29wLg0KPiANCj4gT3RoZXJzIGxvb2sgZ29vZC4NCj4gDQo+IFRoYW5r
cw0KPiANCg0KVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24sIEknbGwgbW92ZSBvdXQuDQoN
Cj4gPiArDQo+ID4gICAgICAgICAgcmMgPSB2aXJ0cXVldWVfcGFja2VkX3JlYWRfbmV4dF9kZXNj
KHZxLCAmZGVzYywgZGVzY19jYWNoZSwgbWF4LA0KPiAmaSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVzY19jYWNoZSA9PQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5kaXJlY3RfZGVzY19jYWNo
ZSk7DQo+ID4gLS0NCj4gPiAyLjI3LjANCj4gPg0KDQo=

