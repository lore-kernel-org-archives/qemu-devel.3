Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A6BC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 03:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7oH3-0000P9-J4; Thu, 16 May 2024 23:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s7oGz-0000Os-RU
 for qemu-devel@nongnu.org; Thu, 16 May 2024 23:28:45 -0400
Received: from mail-psaapc01on2092.outbound.protection.outlook.com
 ([40.107.255.92] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s7oGx-0008Rq-8P
 for qemu-devel@nongnu.org; Thu, 16 May 2024 23:28:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvcUX8aGYkbHwy9dcaN7I/3Y6IjJD2aT8UauWLGOtjK+5e7D851SOj8dGI2+F0zrRyMZIytRQ3Y6+dG3zl/MG5ifgxtpOd5m7xGo+dgUo9ySDDZsBenDKVAw7PxBLNnKLbRVx+UbLAITEM58mktzNL1NZms2Wi7OBwJNO8G2zwlSERkOjkZ9b1MelEHu1STzCLFHjkmtDPv0C5CjHX93PizegnM9gk3VeietlX+aBnZjW/uPW1JGtEy8MFUp2h85eyU2KSrdWDxcbudkCRiYYSJYooBttKNerXIRG4EOF9oHhrWQ11JwraiQw0uGMLg78AGTiWJ9eaFtBnML9gf6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id83DelS6aoiFP5OEG+pLorWd6rXU35aTFiCqsFy5Zs=;
 b=CvoBarHKG/+Yz/jfn7M6TVBJn8ARZ2qOw62BO6xLOf5/a3ytLz02vvocwV2URMpnw9ItkvJ1F4sk+VVbUaUgZZsa0uya9qiwrTQq8NN3UThEHO2gFHiKkmpqmQQL81B7+AsmC6Gwbcs9umkgo9VYaLOdF92kaBgUfer1d2UjFVuWp1u3KjA0jkWV2E90qUPzICyX0NWkd/Ejz/os/NFP9D/XmfUCSS3FGXz73oA0cwghurhwzlVC7feQE4cAoA/HtOmsytSpQtzfkzLN+n15hyZ+US8F3tsJuGG5XjC1yPAnC3a1ZFeXjRB6OhWKicnMQKOg3Bt2dHZowjKQaYsW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id83DelS6aoiFP5OEG+pLorWd6rXU35aTFiCqsFy5Zs=;
 b=YDV+yp1wX+it4POC/wUYC+Qb9nhV+UBmwYaVw8UPaUbPayvzGoaO7gBcs93hUC5nc1y1Dad+BDZd50EdfsQYGohbuU6da7RSBD7A/ftsveA0nbqUt2IkWcHwNiiEm5zkZaIepX5eRqRzIWQQ4G9DEp+HE6nAFs102b3D9vAWQa99G8WUtlo53MLcmWW7G51xp1GsldT2e5t5DRimSc8XT6OlAeatXs9MhAo1H9zozITgIX/I2N2uRYERs/Kzw7eE/1RtY6DPiU+h7GREPee9MSnYs3sCVN9EQhz9WqdNPdT+s9BwYqZ/aTldY5a3J1ggU/swuTCaXuPnUtCg0W16gA==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB6850.apcprd06.prod.outlook.com (2603:1096:990:4d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 03:23:34 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 03:23:32 +0000
From: Wafer <wafer@jaguarmicro.com>
To: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Angus Chen
 <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH v3] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Thread-Topic: [PATCH v3] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Thread-Index: AQHaoqu3MS9GBq0MHEqCeL8xrMCrm7GazSGQ
Date: Fri, 17 May 2024 03:23:31 +0000
Message-ID: <PUZPR06MB4713D1D989F5040D3920CBCAA2EE2@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20240510072753.26158-2-wafer@jaguarmicro.com>
In-Reply-To: <20240510072753.26158-2-wafer@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|JH0PR06MB6850:EE_
x-ms-office365-filtering-correlation-id: 3ec45f9d-c4e8-4e70-490f-08dc7620ba9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T1JwbXdJUW9UakwzenlHQkI0RlplVndWRkRjbG50WXNZVy94bHczdEVCWHJu?=
 =?utf-8?B?VDdVMzUvdWVGTTJuOXBaZE15OU11Tzd1enZMVTZwWGMwU3ExekJIcUhESmxF?=
 =?utf-8?B?eFVjWUd1SW1MdGl5d0RpN0hWL2VEN25FeEpYaDE5SExORWJsdVVPZ1l2Tjdp?=
 =?utf-8?B?ZXhhbjAxbHcrMUNCSElmc1MvZHd5TEtDREExZjg2em5jK1VmOHJNOUluSHkr?=
 =?utf-8?B?RWRvWTJxZHF2WTYwQXlMK3BLYlYvekQ1ckt5bFdKWnVhR2NOL2pqTFg0L0RT?=
 =?utf-8?B?c09aSmJzc0FVSXd1VTduVFk3WFRrZ1V2TWl4K05xVTJoV2FpME5LMkh0L0pJ?=
 =?utf-8?B?N3Z5VGhFeVY0NnAyalBuazVYNnpEa0ZQbnd3anhxa3FHcDhaZnRkb3RzeTJ6?=
 =?utf-8?B?c3BSNFp2NmxhK1BhYlpuUWE0YmxGRjBHNEROUWZOam9NeHZqVHdyMmtBV2t3?=
 =?utf-8?B?SUFVVHV5NFhZaDltQWxhRjhOekticUlDWlpGQjZ5ZXBGRklKZ2lCY0UxYTBO?=
 =?utf-8?B?YWdvb2xTd0VSblpTd1VUWVR5RUg3WGNMVEVkdFUveTdXUitEZm1wMHZJaTMr?=
 =?utf-8?B?bFFVSjVEaVVJdlRZNEN3NW40U3grV2ZNaFpsdnF1TW91NWFlTE5VSy95RDlI?=
 =?utf-8?B?UnMzZGZTTVpiRWd4cnBWNFZ2eXNsUXJabXVOR2R3cyt4MVd1cWRaRW5YYVFl?=
 =?utf-8?B?eDBCVlNRYW9WRnNxTlRTdVJCZHRsRHhoa2JvYjFDd0h6N3pNWUdzdmQ4eDhi?=
 =?utf-8?B?ZkFUVWZ0Z2c4Vm1IQVIvUmQvY1AxSjJ0Yzd4ZlVoS2R3TGdvdkdjSDNQODAz?=
 =?utf-8?B?WUNLTXNWdHB6bjNaaDZoaDAzbWx3QTBua1M4ZFZ6K0w4dEtMOUNOVENjbDdy?=
 =?utf-8?B?NkdHN3NXYzIyeEJzN0xVa1ZoeUR3anVhUXJvSnlQazEvYUdhaHY1T2haS0pa?=
 =?utf-8?B?amtvaUMxZ212azVDbk9nTTFBZ0FUNzBWTXhmRG5Qd3RXMGpwUkhFQ2hmL1lZ?=
 =?utf-8?B?ZGkzd0ZiOWdZZXZBTzc2R1JNRkZIVGhkNmw3VFR6UG8zZWJzQWJYb3dvbVBk?=
 =?utf-8?B?Zko1b1c1OFl5R0x5bzNXWFowaU1rVjRlMkdtY1pSN2d5TFJtTUxjdzZrWDFQ?=
 =?utf-8?B?RDQwU0ZFUk1rck04eEpjNHZMbSt5bUx5RndFVEFnTnFiN1VuM0FtcWZxcXZn?=
 =?utf-8?B?T3dTRDJKSHlGUjJNbHVqSUtZOVEvb2loRFU2VC8xMkU3RVJMS3lsYThUY0pZ?=
 =?utf-8?B?bXV2RytzeTBvV0hmQ1IzbXFnVkNETlArK0l2SlEzZ2pUVk5FRWozdWJvT1dr?=
 =?utf-8?B?K1NZK3ErTWI0TnhmaVo5V1hsY3RWaW9oanVaL1F3OXYyTHN2VU42T2lrY2ZQ?=
 =?utf-8?B?NFo5VUwyaitMVkZoMk9yc0RwZXZ2ZUgza1NGTkpRTkpxenBIOURwZjU2d3Uw?=
 =?utf-8?B?L3RWS0cwOTNzYko4NXNQZkREb3pGOHVsQ1RLQThTb0pxSHRXdkZIV3lkOWpN?=
 =?utf-8?B?RVAzRklhWVR6ZXRDY2dkUVVTMlZxOFhuTnI5UythK3Rvd3Z4QlVkZTJjTzV0?=
 =?utf-8?B?UHFoZVVjVzI0eFVxbUlvc05lQlRkeXNqaTkvL28zVlZ6aDhIZkthZXdMdG5B?=
 =?utf-8?B?NUp4M3N1SXRyV0pRVTdEUEpMWWYwWUQxUE1Ld0hTWlVNK1p5MS9FYTVzai9B?=
 =?utf-8?B?VmcxSGVHTW5xL1AyZDJ0bHVzaU9OWjNNcUFrQ0FXNnptYTFkcFdxeTlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGd3dXIya2NIZ2RaZFJ2SUVpbEREeVQ4ZG5DSjh0TUJvOFBuS2FxSmJsZ05y?=
 =?utf-8?B?YWQ0b1J1VjFhVk4wR0RKdURYa3JmSHROVHJvNFFwWFYrU0ZseWVpR1JVdTZu?=
 =?utf-8?B?OGl1MmZ2QlU1MjVQNjEzYUZseGU3NHcySjFJRjhMVDFvQjM2c1l3L0FNeWpU?=
 =?utf-8?B?L1JmKzF0MTU3bmFVc2RWK0V2MmZqbHE3MDVLejZiU09zV1ljdU5nZ0o4QzBH?=
 =?utf-8?B?aWFLYU9xMisxMW1aQUhEQXpzVWV1TDdIZjJmS0s1STEwc1l2TUwzOHBVaVJ4?=
 =?utf-8?B?SXJvdHVMZ0JXQUc1RVFUU21SdVROMTVKZ01jR212QWJwMWQyNjdWL01RdUVk?=
 =?utf-8?B?Y1pNSCs0VDd3ZFRGU1JkeHR3MU12Z3M1TW1nZE4rRUtqb0FXMUhQdFNvRXRC?=
 =?utf-8?B?S3ZHUUlWUU9Ha3BWdmFzZlExZzVPcHNZVENWd2tQVXRKa3pUNnUxckExTmdx?=
 =?utf-8?B?N2FaaXhZZVhucnNKL20wSFNKWmRwS01tWGx2OGdrRk90ejQxNUZSZkYxMEtB?=
 =?utf-8?B?UFBYWFpDakI5UGEzWEpFNlMvSkk3N3g1aXRrZVhHMXdWVVU0cTNLZnc3dy9x?=
 =?utf-8?B?eGZXM1RpWVNZR21wdVNPZGxNYnRDL1ZlTHJwRURJbTZlQ1RGOWFKdFJqeTVm?=
 =?utf-8?B?Z3VxSmZJRS9tbDBjSFhzZFBLUFRJNWxuNGhyUnY1M3QrNGNGL1BFWGhKTUtT?=
 =?utf-8?B?NkxoNXBFaURFNkIwa1FaMEkyN1lHQ2hpcDI4Z2tLVG1LZ0JKQis3TzVPQ3FZ?=
 =?utf-8?B?YTJFVFl6REJhd2FKVVlyS1phSjl6NG5XSHVjU2pHZHozOW1LeGs3TlBZMmRX?=
 =?utf-8?B?bXQrSnlLdnRKbkVidEtmT0lTSnNjNFduZ1BuYnNlNzFEWEh2ODZDTnlKeDQ5?=
 =?utf-8?B?eHo2WFk5anV3YmgwaU9MVWlWYmg4d29sYml6Q29KcDZENHg4bUU0YWQ0b2Zl?=
 =?utf-8?B?YkN1ZnNOcHJ0SzBiYkt1ci9FWDhEWnA5bW84Rko3Um9nUEp2aVMzZ0Y2aGdx?=
 =?utf-8?B?T01jUElMWTZnbXpDcCtrRUJIY09CdHRQZ284TDZEeUJGc2d4ZndkRXNxVEN3?=
 =?utf-8?B?ai9nRG9zVmUrQmxqM0NzYWNUM2xKTGQxdnlPRFU0WjM0M2t5SkwrSHBaaThT?=
 =?utf-8?B?TXhtMWpEcmV4bEVrSWRjL05CVkNUViszSVE0QVl4SmtHU2JETFNIa05BZElX?=
 =?utf-8?B?SjdKb1c1MXd2YkZlNEpGY04weUc3dGg3Qkd4OEdmaXR1Yk9RZ3ZnV2hXQlUy?=
 =?utf-8?B?ZlBpVjJuTDVnS29QQ2ZGYUxmb3E2ZE5GNFpJZTEycUdxcFkyV3c5NnlwWFc5?=
 =?utf-8?B?NmE2TjRFOVJ6bmkyVEZjelZKT2dwb3FsNHpLblRhZVhjZzZxZ3ZEK3ZFNzFm?=
 =?utf-8?B?b09OWmxJdXlWWTcxaEpHdmhzRGJScHhJMGRpdTUrQVlSNlJzazB3SnI4N3l0?=
 =?utf-8?B?MjV0enBHdzg1WXRNVlIyZmV6bUQ3VzdOSTZsUmRPREVEZjVhMlRCNDZXdGQ5?=
 =?utf-8?B?cXk2TVd3Skh2U1RvbWJLZTRCREhQOG9lWFd3UFFsMzZPRWViY3J5M1NDRVhL?=
 =?utf-8?B?VXFocDUxSHo1MEpwTWlBRjF4SnExMjQzUDhBcjBsQ2ovc1orcUl2ZVRvT0FV?=
 =?utf-8?B?bVFMNlNMekE0cE1PSkJVL1g5R2tEdHNjV2p6V0xza0tIVXBWYlBJdDlldnBC?=
 =?utf-8?B?bk1qTFBxVEZwUGtZT1JhYVhuNnFwZTFhRitmdWxRaXlXQ1dSZmg3cGRDWjBV?=
 =?utf-8?B?MTZjbFpOeXlUaVdRZXF1M1p6Q25PeGlMeDVWbm5oN2FWMVlrbHkwM2Q5TFJm?=
 =?utf-8?B?QUVhUzByVUFXU3R1VENObm9Tc0w3T3JoMDFCc0thZ1cyRkJ6ODUzeVlLSUtN?=
 =?utf-8?B?YVFXcFBNVllDK1l6SnUwK3hSaldML1U5czZNcjczMXRYWFBqOVI3emdMUTkx?=
 =?utf-8?B?ZlA0SmNKa3pjUVdjWWd5U3RjZ0dpVEVkaDdBaDY0bUowb0FPVUR3NVdyVXN2?=
 =?utf-8?B?dzAwVkhveTlhYkFMT2p6SkpNOUhlQ3hyQUlXYmdYRlBtMDB5TVBtQ3ZWZ2Mz?=
 =?utf-8?B?ZWlybjg0YWJKS0ZvREx3N3JJRXY0T2t6SDJaYWE2SkZKWFk4T01LT2dqcHVu?=
 =?utf-8?Q?tIkNrvxxNvS3n1yDQ7twpVTln?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec45f9d-c4e8-4e70-490f-08dc7620ba9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 03:23:32.1474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xyBgGkGG5/gp7OjeubGgN60qeluZjB0qe/GIl+T9RejH4p/E6IgqR9AVA+6lr7AcjEmcuhtMYTfMRWYbc272g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6850
Received-SPF: pass client-ip=40.107.255.92; envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

UGluZyA6KQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdhZmVyDQo+
IFNlbnQ6IDIwMjQvMDUvMTAgIDE1OjI5DQo+IFRvOiBlcGVyZXptYUByZWRoYXQuY29tOyBtc3RA
cmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbQ0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUu
b3JnOyBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT47DQo+IFdhZmVyIDx3
YWZlckBqYWd1YXJtaWNyby5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2M10gaHcvdmlydGlvOiBG
aXggb2J0YWluIHRoZSBidWZmZXIgaWQgZnJvbSB0aGUgbGFzdA0KPiBkZXNjcmlwdG9yDQo+IA0K
PiBUaGUgdmlydGlvLTEuMyBzcGVjaWZpY2F0aW9uDQo+IDxodHRwczovL2RvY3Mub2FzaXMtb3Bl
bi5vcmcvdmlydGlvL3ZpcnRpby92MS4zL3ZpcnRpby12MS4zLmh0bWw+IHdyaXRlczoNCj4gMi44
LjYgTmV4dCBGbGFnOiBEZXNjcmlwdG9yIENoYWluaW5nDQo+ICAgICAgIEJ1ZmZlciBJRCBpcyBp
bmNsdWRlZCBpbiB0aGUgbGFzdCBkZXNjcmlwdG9yIGluIHRoZSBsaXN0Lg0KPiANCj4gSWYgdGhl
IGZlYXR1cmUgKF9GX0lORElSRUNUX0RFU0MpIGhhcyBiZWVuIG5lZ290aWF0ZWQsIGluc3RhbGwg
b25seSBvbmUNCj4gZGVzY3JpcHRvciBpbiB0aGUgdmlydHF1ZXVlLg0KPiBUaGVyZWZvciB0aGUg
YnVmZmVyIGlkIHNob3VsZCBiZSBvYnRhaW5lZCBmcm9tIHRoZSBmaXJzdCBkZXNjcmlwdG9yLg0K
PiANCj4gSW4gZGVzY3JpcHRvciBjaGFpbmluZyBzY2VuYXJpb3MsIHRoZSBidWZmZXIgaWQgc2hv
dWxkIGJlIG9idGFpbmVkIGZyb20gdGhlDQo+IGxhc3QgZGVzY3JpcHRvci4NCj4gDQo+IEZpeGVz
OiA4NjA0NGIyNGU4ICgidmlydGlvOiBiYXNpYyBwYWNrZWQgdmlydHF1ZXVlIHN1cHBvcnQiKQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogV2FmZXIgPHdhZmVyQGphZ3Vhcm1pY3JvLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4NCj4gQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IA0KPiAtLQ0KPiBDaGFuZ2VzIGluIHYzOg0K
PiAgLSBBZGQgQWNrZWQtYnkgSmFzb24gV2FuZw0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gIC0g
VXNlIEphc29uIHN1Z2dlc3Rpb246IE1vdmUgdGhlIGNvZGUgb3V0IG9mIHRoZSBsb29wLg0KPiAt
LS0NCj4gIGh3L3ZpcnRpby92aXJ0aW8uYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLmMgYi9o
dy92aXJ0aW8vdmlydGlvLmMgaW5kZXgNCj4gODcxNjc0ZjliZS4uZTllODQ0Nzg3OCAxMDA2NDQN
Cj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby5jDQo+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8uYw0K
PiBAQCAtMTc0NCw2ICsxNzQ0LDExIEBAIHN0YXRpYyB2b2lkICp2aXJ0cXVldWVfcGFja2VkX3Bv
cChWaXJ0UXVldWUNCj4gKnZxLCBzaXplX3Qgc3opDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmaW5kaXJlY3RfZGVzY19jYWNoZSk7DQo+ICAgICAgfSB3
aGlsZSAocmMgPT0gVklSVFFVRVVFX1JFQURfREVTQ19NT1JFKTsNCj4gDQo+ICsgICAgaWYgKGRl
c2NfY2FjaGUgIT0gJmluZGlyZWN0X2Rlc2NfY2FjaGUpIHsNCj4gKyAgICAgICAgLyogQnVmZmVy
IElEIGlzIGluY2x1ZGVkIGluIHRoZSBsYXN0IGRlc2NyaXB0b3IgaW4gdGhlIGxpc3QuICovDQo+
ICsgICAgICAgIGlkID0gZGVzYy5pZDsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAvKiBOb3cgY29w
eSB3aGF0IHdlIGhhdmUgY29sbGVjdGVkIGFuZCBtYXBwZWQgKi8NCj4gICAgICBlbGVtID0gdmly
dHF1ZXVlX2FsbG9jX2VsZW1lbnQoc3osIG91dF9udW0sIGluX251bSk7DQo+ICAgICAgZm9yIChp
ID0gMDsgaSA8IG91dF9udW07IGkrKykgew0KPiAtLQ0KPiAyLjI3LjANCg0K

