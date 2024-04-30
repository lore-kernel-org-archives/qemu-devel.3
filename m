Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F713C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jDc-0000jG-Lg; Tue, 30 Apr 2024 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1s1jDT-0000gB-9u; Tue, 30 Apr 2024 04:51:59 -0400
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1s1jDO-0007qm-Ea; Tue, 30 Apr 2024 04:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPfgVv6zLHGEstTv08abjkOx9wVql2TAX87DjWY5C9k9+5Wq9gY/LRAc/rVHaNIG6c6F8640W/XOUxFfrkpWj8hgVTrlQ4YH/Fg9Zz4TK2sy5np/S8ibIOI9ey7uRlDpl86f10uRNF6dUTTjAPH3EEmjUJoaoHwMZvrcq4v9lbFRUXGqBFSsTxfYAh/wQridBYOikB5jynEJ4qBZ2o7SjJf3zPtaV6kIEc+8i0jzHYgXgC1Q0u8/kj0ziF8FDjO3HKvdW7McjdySNiIclfmAVBtvQOI+m8a6ZP9Kv0SuOOUt+TYXbrqr4a54kOiDXyb+xflje6AWpC4EKZVa4aynWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoXjJJlS3YNulANyJriJzSd8/IsevDstwzDUv/Pudes=;
 b=CKFW3jBBCi9tUwGRjQxkG+7TKLf6NmVoiBRwqmIAmBIfnH1ZZVnm7d8s8TI0QDpZ6KQahXgpDnomji1vLfSgd13Xq9zf+2aIkM3JLYgndmc8XNPHITcJETt2wTW+WzGH2ITAy8OEHM0Tu8IMuc7hQ6dQm4OLsmEjR0wMuJ8sR1eXelJICHktOHPF1oZUQzN7ngsG/Ac/Nnhf84IparpasvTenXpWX4GWNVk6TjLVRAqehdP18qJO4Z9St6DicComMC/JuKRSRYubCkRsefw1kcJe6wC867TWootD6rYWbtN//BA3HCn8EtdgGJgk3W0sKmy28AwYFaiW19L+TPArrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoXjJJlS3YNulANyJriJzSd8/IsevDstwzDUv/Pudes=;
 b=iYzghs1lmAWQX5S4aIbPEtpGXDsypXnJGdsZOHKL5m3E4rPWmIqAC3yYY+I9fakyQDD8+jCKH20rB5AsX9ykcIZdkH4FjnVHaPQhvGOtblr82FoTirPIyuqOU7gmGeiWnd/uaFgsHl1LXNJ2hbDr8Tlwav0mOucQOUCgQJANYLu9N0CtzZo1ov3Qx/QuEwdE6c3LVVfSiuOtEF0yuv6XPPFOan6LT1PSbPvPqYW+CJ5fWvKHcNElfSl2b3tX8vNm/RqQBjOdCmjYEHnuc2MxYX5Uj3UsNNUCcgxv5piUD9+XXr8znl5rzRiaMRcc4XIN+eX8o9cZKZhq1tgWqVtHZA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6157.apcprd06.prod.outlook.com (2603:1096:101:eb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 30 Apr 2024 08:51:44 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 08:51:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data length
 issue
Thread-Topic: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data
 length issue
Thread-Index: AQHaj98nZO6QOpl6ikiVeDaw5PJCfbFvnuKAgBDflQCAAA0ZkA==
Date: Tue, 30 Apr 2024 08:51:43 +0000
Message-ID: <SI2PR06MB504122AE11599095D521AA4AFC1A2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-8-jamin_lin@aspeedtech.com>
 <90a930b9-ec7f-47fc-bfc9-f4ac0958ef83@kaod.org>
 <cd94d997-8989-4518-ac9f-ab6a544ba77e@kaod.org>
In-Reply-To: <cd94d997-8989-4518-ac9f-ab6a544ba77e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6157:EE_
x-ms-office365-filtering-correlation-id: 06b46c58-f2ac-432b-3fd8-08dc68f2c2cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?Rm9GbkhwaXBhYUJWRS9WbzlETVI0ZFVmYjlLRlVtd2cwd1lqcVhsTW9FSkt2?=
 =?utf-8?B?MFp6bHcycXBtMDcyY0RDdVI3S1dKSUNHY0s3L1kwbTdSMzNHbFA4cnloTHRK?=
 =?utf-8?B?QlB0UnFBUDhxNGdvb0QzYkVsY2tQUlloS1VoZC9NdW5rRHQ5S3h4NCtvdXNQ?=
 =?utf-8?B?TXk3QmUzSGwxc2g5QjBVenUrV1A4OWVTSGc0dGQzZXNvUFNVYWNobVpuMHgv?=
 =?utf-8?B?SmhCeThUSXV1d0tlU1BGejhVN1NsdTh2R3RCbUVCaUtlVTlMNzVhQ3RaaTVK?=
 =?utf-8?B?UW5SNGVxRGpXQzRIaEY2NkF1dTNjcU44S0luZm5UNXFkUHRqaTI2RDRRb0wy?=
 =?utf-8?B?VXAvWCtiSjVmN2k3b3ZicWR3aEpuU1F2MmVIbng5K1AvV1FHOHVHMTNYcWpv?=
 =?utf-8?B?eGVlU0RtR1dJb3JoQVNWeW5ScnpGbHdBWHFJaHExUzEvc2VObGthZE5PTVIx?=
 =?utf-8?B?azZob2lWSjlRMW13VHZiS28yaEN1cXVuYWg1R2N0NVkrdG1UbWx3UzNubDNh?=
 =?utf-8?B?bnA2NjlVaHlGenJ2L2RsTUIwVnQrekd2L2dsalVoTjExUGpjOWozTWVrOGM5?=
 =?utf-8?B?SVNqTGdyQWxYTVEyNGtQUTNjakZvdlVRYmpIcGluTHlZVEgxRzNHbUc1dzFw?=
 =?utf-8?B?ZGZWRURENDRlL2tNTU1nMG9UUGJhWUhYMG1qeGk3cG1ldzF6NEZUUDJXMFhH?=
 =?utf-8?B?alNqRVN5K3phVzRMcFhwbmV6cUx2QUlwUTlvUVhOck1mWXlzODUxWSt3T2tQ?=
 =?utf-8?B?eGJNWHg1bE1vbThzdGluLzB4N1BUTTE2N25VcUpSaHU4T1pjTHcwWjc1VDlu?=
 =?utf-8?B?NVJwTk1WOVJJYm00Y0l6aDJuVnV4VHBxbmtwQ3NMVkhiOUN2Ym1wbXpYdzBa?=
 =?utf-8?B?M0svc29XR2xwZC9YU04vYWRidGl5NEprb0xMSCtxYzhHR2hmMGdDLzNNbHV6?=
 =?utf-8?B?a216dUFZZkUxeW8xdlovS01RWW5FbzdLR3FaTzRxRUhnSTZCcytBSS9rL0Uv?=
 =?utf-8?B?dWdCVmdVcGwvOGhTbkY0aHROZVBRWVNtTi85YndwRUZpdE5HNWVoVWhGK0Zk?=
 =?utf-8?B?M1J0MmRieFdmYmMyL0ZWWit1cW9NeGVsaGtSZTR4L1ZlWlpabGdISC8vaFRn?=
 =?utf-8?B?YnV0SFBNZTN5RDNWZFpwcEFpS3RuUWlpL1ZoZDNTcDlpdVpLT0pwU3JNT2t5?=
 =?utf-8?B?ZGcrZDJrRmoyUFpSTzNRT2dKNVBwTVh0WFIwaHh1TFZOYllyd0UrZzZPYjQ3?=
 =?utf-8?B?Q1BIUldDUmNZZm1xZ0FvK05ZdHZTVXlmZlU3N3QzdzZpRkFDY1VyblJMWjFx?=
 =?utf-8?B?MmUvM1c3WlpLK3hLdElKWFJzditOR1daZzg2cFdhZC85ajVMNHlLMjdsLzBN?=
 =?utf-8?B?OHlnUk1nWUVnWEJxSDZnSXlqZ2NOSUY1bUo0ZnVpQkF1OFRMRjFDUVJ5SlJK?=
 =?utf-8?B?WkpOTmp2V2RmYUQxUUtEazZMdWNNbWUrako3ZlJ6N0l0QjlId2lKeDlac3RG?=
 =?utf-8?B?R084UmZDYjYvakdzeGRJL3ZyVGhmYVFYcUd0WDllLzlFYldiMnlPakVSdloz?=
 =?utf-8?B?aVlYTTgzWDNwckNDSFdKckhvZSsvVTU3SXM0UllxL3IzbU5xTVdNdDZkbEV0?=
 =?utf-8?B?Qk55TnJ6L0tqZyt5WVlFa2gwckowbkd0V2ZWUEN5blJXSXJZb3RrVTQ0S010?=
 =?utf-8?B?Nit4TG9yUk94NlVrQnNnZmdJNmhoTUJ2SXM1dGxBdkszUWRBN2lZem9YMytH?=
 =?utf-8?Q?zkdCVnZxj0ybwbeg3Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym85SVlNOVdFRkZRWGdoSTBkMVE1Qlk3bjdBb3pDMTlUK3hqL0VqbE01MmRN?=
 =?utf-8?B?dVNaLzJZTDhSSXM5bk9YSVdmYVVTZEI2M3hjempGYTFiZmVwMXlJbDVNTitu?=
 =?utf-8?B?czRick9GNGUydXloK3ZHSVFRTldWeE1ZTTZISFdJMTZqa2pYVWRWWFNzeVIz?=
 =?utf-8?B?QzNleWduYmJvZlhxbFpteURtWUtHSFpDcWIvcWZWVGZyU3hvRkhGRkNnTE9o?=
 =?utf-8?B?L3QycXdHMWFrcVZ3Q3hPbStyS3V3OHlYUm1PVlgvY0xTQittVnhFZ2dCNWdS?=
 =?utf-8?B?dFNHZXduU0N6S1B3UVFINENUNUszdzBIMmZleFhlOUdKSTBLdVpOY0VNSkV5?=
 =?utf-8?B?eW9FUnc4QzFLamJQT3Zpc29zeGFXSzM2UDk3VHhubGhHWjZ6ZzZ5K1BNUUVL?=
 =?utf-8?B?N3ovRXJKblczNVFiQ0ljSWl3OGgyVCtWekFXQnVnNUdJS2htM3VrandRNEJu?=
 =?utf-8?B?ZFBRdTdmOFFEbGVVaC9DNWNVNmszMXdxZjh2RDVQQ1N5WWpBN0lhUzcxZzNj?=
 =?utf-8?B?bTNYcjYvVERLak0vL09pbUVldjJpRUhnYW5XYzRzSyt6dzd6ZnREVjU1QXZG?=
 =?utf-8?B?aUhMMzFVQTNYUjdBWTNHcUxxSW5ZdmtUWjVXRmlISjg2Q3JCd1QwRGJ4aCsv?=
 =?utf-8?B?WWRETE05NXpneHZYM0IzbWgzL25ZTituQUplZUk1MHZTTHRVQ0FvSlcrZjE4?=
 =?utf-8?B?VDJ3Y2JmWmJGejIzTUVDaVBOUDZqMkJpSVZpZTlaSllta1RUYXpLWFZVK3NC?=
 =?utf-8?B?U2k2eUNzb2l6UkovTitVUExjK1JlNU1pSm5mRWd4UUVieldoZHh1cUU2djBY?=
 =?utf-8?B?bDc1Yk16Mjd0bTFNbFFTNm5VT1FISmpTemthTzh3R2t0MWlQcjhXVmtSYmxS?=
 =?utf-8?B?RjJLNXVjWFg4NmFHUnZSWk9GaWIzNlBhQ3oyYmpxbnhESU50YloxY09iV1Q1?=
 =?utf-8?B?allBTmFTd2FHVVZmcFlpU3hrWXdIRGdPV1gwNzZyZWxNNGVXa01ONGRxUzRt?=
 =?utf-8?B?TENTYzdxbzFMV3kySGdXQ1YrWk15L0h1V0lnY3J3cUIvWFozRk12WER2MS9m?=
 =?utf-8?B?MzJuMUJ3MndWR0FFdzBjNDJ3MGZwVUJVUm12WmwzcVNYV3Ixc3NQeG1PaFdC?=
 =?utf-8?B?dmlDRkc4cEF4c25RS2U0bDFPSUxRS2I0bWJOaU9VMCtucnlld1phYmxPSXA1?=
 =?utf-8?B?WG9WYnE1cFN4R0pFdTg5Mm1XZWtMNzFxaG9lajgyNDR0MTd1dys0ZXF1bWFH?=
 =?utf-8?B?UEhNODJvWmtNVWJDU2hnQklHaHVQd0NUL29vRUlJZzdEc3c1NkJ4OFJKK3VZ?=
 =?utf-8?B?aDU4M00zTmw5TCt1dDFwNk9YMWxrL2ZxdytobmYwaU9HMTdudi9ZSGYrNmNO?=
 =?utf-8?B?UzR5ZFdZZWlTSk9FZDlXVXhTU0UyVm9RYmNXWEcrWXV6RVVQU2d0YmIwRk5W?=
 =?utf-8?B?MUZHamp6YVYrWks4ZmxKSWRzSlZzeGcvY0tSaDVDbkhYRWNkMkdQU1p3VjV4?=
 =?utf-8?B?d2pVNFNhZFJTdkh3U2srMWI0RnVzSWV4SEN4cGtzM1NWaTREZVlMa2E0bjdZ?=
 =?utf-8?B?bnhzcTR5Zmw1V1VSYVlMUGFOb2JJRjliMUlKWW1UR1YxQUlzU0g1TlRmV1Qr?=
 =?utf-8?B?V3JNRzhSeUJnanh0dTZMSkdsakcrbWFJWXF3NFVOVUFzOVFiSUJmQlVYVFpl?=
 =?utf-8?B?UE1UN0RlUXJCb3gwVW1DNkhORForeE5ta3BzSzA3KzM0bi9EKy9seXY0dEJu?=
 =?utf-8?B?S2xjQXRBWE5kV0EyVjhHMmY5MmtZMFVqTDlKeC8wR05wNGl3cHBacTJTdGVC?=
 =?utf-8?B?RXNpVUVzT2ovMnZ3Yjl0bGpQMTQ3SzJDcHdSWVNpTUhFcmhVS2xGT1g0Wlh1?=
 =?utf-8?B?MGNaQm95VHBDd05aYU94ZElIaDhBRndpMTFVSUhYZUd6VmpRSW4weFo1dkpS?=
 =?utf-8?B?Uy9vMk0zUFpyRDdyZ0ljNEU0d05QWjV2akFNVlhHaG95REU4U2pHb2dhRVVR?=
 =?utf-8?B?QmR1SzBKWlZFU3JvNGwyNE4zbHlBOE0rQ0tSS2FoL2RVSDRTTmU5RnR6aEdY?=
 =?utf-8?B?emFzZ25PdzV3M2V6SzdERlloV0VsR3A1RDhVY0VEeEVCVk5ZVG15MkhLem9O?=
 =?utf-8?Q?pmkxqgPAKZ+uoIhI9nL+kBC7O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b46c58-f2ac-432b-3fd8-08dc68f2c2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 08:51:43.9201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtNAL5yKELUwKcsslIrb576y+ssakXSrBvVyPHWWudMkHuVeDxkxzvE1EGTvfdLhHdS+25yJpVeEpyF+zfS19eBjjc7XGbYHCTH3dH59l3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6157
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ2VkcmljLA0KPiBPbiA0LzE5LzI0IDE1OjQxLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToN
Cj4gPiBPbiA0LzE2LzI0IDExOjE4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+IERNQSBsZW5ndGgg
aXMgZnJvbSAxIGJ5dGUgdG8gMzJNQiBmb3IgQVNUMjYwMCBhbmQgQVNUMTB4MCBhbmQgRE1BDQo+
ID4+IGxlbmd0aCBpcyBmcm9tIDQgYnl0ZXMgdG8gMzJNQiBmb3IgQVNUMjUwMC4NCj4gPj4NCj4g
Pj4gSW4gb3RoZXIgd29yZHMsIGlmICJSX0RNQV9MRU4iIGlzIDAsIGl0IHNob3VsZCBtb3ZlIGF0
IGxlYXN0IDEgYnl0ZQ0KPiA+PiBkYXRhIGZvciBBU1QyNjAwIGFuZCBBU1QxMHgwIGFuZCA0IGJ5
dGVzIGRhdGEgZm9yIEFTVDI1MDAuDQo+ID4+PiBUbyBzdXBwb3J0IGFsbCBBU1BFRUQgU09Dcywg
YWRkcyBkbWFfc3RhcnRfbGVuZ3RoIHBhcmFtZXRlciB0byBzdG9yZQ0KPiA+PiB0aGUgc3RhcnQg
bGVuZ3RoLCBhZGQgaGVscGVyIHJvdXRpbmVzIGZ1bmN0aW9uIHRvIGNvbXB1dGUgdGhlIGRtYQ0K
PiA+PiBsZW5ndGggYW5kIHVwZGF0ZSBETUFfTEVOR1RIIG1hc2sgdG8gIjFGRkZGRkYiIHRvIGZp
eCBkbWEgbW92aW5nDQo+ID4+IGluY29ycmVjdCBkYXRhIGxlbmd0aCBpc3N1ZS4NCj4gPg0KPiA+
IE9LLiBUaGVyZSBhcmUgdHdvIHByb2JsZW1zIHRvIGFkZHJlc3MsIHRoZSAiemVybyIgbGVuZ3Ro
IHRyYW5zZmVyIGFuZA0KPiA+IHRoZSBETUEgbGVuZ3RoIHVuaXQsIHdoaWNoIGlzIG1pc3Npbmcg
dG9kYXkuIE5ld2VyIFNvQyB1c2UgYSAxIGJpdCAvDQo+ID4gYnl0ZSBhbmQgb2xkZXIgb25lcywg
QVNUMjQwMCBhbmQgQVNUMjUwMCwgdXNlIDEgYml0IC8gNCBieXRlcy4NCj4gPg0KPiA+IFdlIGNh
biBpbnRyb2R1Y2UgYSBBc3BlZWRTTUNDbGFzczo6ZG1hX2xlbl91bml0IGFuZCByZXdvcmsgdGhl
IGxvb3AgdG8gOg0KPiA+DQo+ID4gIMKgwqDCoCBkbyB7DQo+ID4NCj4gPiAgwqDCoMKgwqDCoCAu
Li4uDQo+ID4NCj4gPiAgwqDCoMKgwqDCoMKgIGlmIChzLT5yZWdzW1JfRE1BX0xFTl0pIHsNCj4g
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5yZWdzW1JfRE1BX0xFTl0gLT0gNCAvIGFzYy0+
ZG1hX2xlbl91bml0Ow0KPiA+ICDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gIMKgwqDCoCB9IHdoaWxl
IChzLT5yZWdzW1JfRE1BX0xFTl0pOw0KPiA+DQo+ID4gSXQgc2hvdWxkIGZpeCB0aGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IA0KPiBJIGNoZWNrZWQgd2hhdCBGVyBpcyBkb2luZyBv
biBhIFFFTVUgYXN0MjUwMC1ldmIgbWFjaGluZSA6DQo+IA0KPiAgICAgIFUtQm9vdCAyMDE5LjA0
LXYwMC4wNC4xMiAoU2VwIDI5IDIwMjIgLSAxMDo0MDozNyArMDAwMCkNCj4gICAgICAuLi4NCj4g
DQo+ICAgICAgICAgTG9hZGluZyBLZXJuZWwgSW1hZ2UgLi4uIGFzcGVlZF9zbWNfd3JpdGUgQDB4
ODggc2l6ZSA0Og0KPiAweDgwMDAxMDAwDQo+ICAgICAgYXNwZWVkX3NtY193cml0ZSBAMHg4NCBz
aXplIDQ6IDB4MjAxMDAxMzANCj4gICAgICBhc3BlZWRfc21jX3dyaXRlIEAweDhjIHNpemUgNDog
MHgzYzY3NzANCj4gICAgICBhc3BlZWRfc21jX3dyaXRlIEAweDgwIHNpemUgNDogMHgxDQo+ICAg
ICAgYXNwZWVkX3NtY19kbWFfcncgcmVhZCBmbGFzaDpAMHgwMDEwMDEzMCBkcmFtOkAweDEwMDAN
Cj4gc2l6ZToweDAwM2M2Nzc0DQo+ICAgICAgYXNwZWVkX3NtY19yZWFkIEAweDggc2l6ZSA0OiAw
eDgwMA0KPiAgICAgIGFzcGVlZF9zbWNfd3JpdGUgQDB4ODAgc2l6ZSA0OiAweDANCj4gICAgICBP
Sw0KPiAgICAgICAgIExvYWRpbmcgUmFtZGlzayB0byA4ZmVmMjAwMCwgZW5kIDhmZmZmNjA0IC4u
LiBhc3BlZWRfc21jX3dyaXRlDQo+IEAweDg4IHNpemUgNDogMHg4ZmVmMjAwMA0KPiAgICAgIGFz
cGVlZF9zbWNfd3JpdGUgQDB4ODQgc2l6ZSA0OiAweDIwNGNkZGUwDQo+ICAgICAgYXNwZWVkX3Nt
Y193cml0ZSBAMHg4YyBzaXplIDQ6IDB4MTBkNjA0DQo+ICAgICAgYXNwZWVkX3NtY193cml0ZSBA
MHg4MCBzaXplIDQ6IDB4MQ0KPiAgICAgIGFzcGVlZF9zbWNfZG1hX3J3IHJlYWQgZmxhc2g6QDB4
MDA0Y2RkZTAgZHJhbTpAMHhmZWYyMDAwDQo+IHNpemU6MHgwMDEwZDYwOA0KPiAgICAgIGFzcGVl
ZF9zbWNfcmVhZCBAMHg4IHNpemUgNDogMHg4MDANCj4gICAgICBhc3BlZWRfc21jX3dyaXRlIEAw
eDgwIHNpemUgNDogMHgwDQo+ICAgICAgT0sNCj4gICAgICAgICBMb2FkaW5nIERldmljZSBUcmVl
IHRvIDhmZWU3MDAwLCBlbmQgOGZlZjEzNWUgLi4uIGFzcGVlZF9zbWNfd3JpdGUNCj4gQDB4ODgg
c2l6ZSA0OiAweDhmZWU3MDAwDQo+ICAgICAgYXNwZWVkX3NtY193cml0ZSBAMHg4NCBzaXplIDQ6
IDB4MjA0YzY5YjQNCj4gICAgICBhc3BlZWRfc21jX3dyaXRlIEAweDhjIHNpemUgNDogMHg3MzYw
DQo+ICAgICAgYXNwZWVkX3NtY193cml0ZSBAMHg4MCBzaXplIDQ6IDB4MQ0KPiAgICAgIGFzcGVl
ZF9zbWNfZG1hX3J3IHJlYWQgZmxhc2g6QDB4MDA0YzY5YjQgZHJhbTpAMHhmZWU3MDAwDQo+IHNp
emU6MHgwMDAwNzM2NA0KPiAgICAgIGFzcGVlZF9zbWNfcmVhZCBAMHg4IHNpemUgNDogMHg4MDAN
Cj4gICAgICBhc3BlZWRfc21jX3dyaXRlIEAweDgwIHNpemUgNDogMHgwDQo+ICAgICAgT0sNCj4g
DQo+ICAgICAgU3RhcnRpbmcga2VybmVsIC4uLg0KPiANCj4gSXQgc2VlbXMgdGhhdCB0aGUgUl9E
TUFfTEVOIHJlZ2lzdGVyIGlzIHNldCBieSBGVyB3aXRob3V0IHRha2luZyBpbnRvIGFjY291bnQN
Cj4gdGhlIGxlbmd0aCB1bml0ICggYml0IC8gNCBieXRlcykuIFdvdWxkIHlvdSBrbm93IHdoeSA/
DQo+IA0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL3UtYm9vdC9ibG9iL2FzcGVl
ZC1tYXN0ZXItdjIwMTkuMDQvbGliL3N0cmluZy5jI0w1NTkNClRoaXMgbGluZSBtYWtlIHVzZXIg
aW5wdXQgZGF0YSBsZW5ndGggNCBieXRlcyBhbGlnbm1lbnQuDQpodHRwczovL2dpdGh1Yi5jb20v
QXNwZWVkVGVjaC1CTUMvdS1ib290L2Jsb2IvYXNwZWVkLW1hc3Rlci12MjAxOS4wNC9hcmNoL2Fy
bS9tYWNoLWFzcGVlZC9hc3QyNTAwL3V0aWxzLlMjTDM1DQpUaGlzIGxpbmUgc2V0IHRoZSB2YWx1
ZSBvZiBjb3VudCBwYXJhbWV0ZXIgdG8gQVNUX0ZNQ19ETkFfTEVOR1RILg0KQVNUX0ZNQ19ETUFf
TEVOR1RIIGlzIDQgYnl0ZXMgYWxpZ25tZW50IHZhbHVlLg0KRXhhbXBsZTogaW5wdXQgNA0KKCg0
KzMpLzQpICogNCAtLT4gKDcvNCkgKjQgLS0tPiA0DQpJZiBBU1RfRk1DX0RNQV9MRU5HVEggaXMg
MCwgaXQgbWVhbnMgaXQgc2hvdWxkIG1vdmUgNCBieXRlcyBkYXRhIGFuZCBBU1RfRk1DX0RNQV9M
RU5HVEggZG8gbm90IG5lZWQgdG8gYmUgZGl2aWRlZCBieSA0LiANCg0KPiBJZiBJIGNoYW5nZSB0
aGUgbW9kZWwgdG8gbWF0Y2ggMSBiaXQgLyA0IGJ5dGVzIHVuaXQgb2YgdGhlIFJfRE1BX0xFTiBy
ZWdpc3Rlci4NCj4gTGludXggZmFpbHMgdG8gYm9vdC4gSSBkaWRuJ3QgZGlnIGZ1cnRoZXIgYW5k
IHRoaXMgaXMgc29tZXRoaW5nIHdlIG5lZWQgdG8NCj4gdW5kZXJzdGFuZCBiZWZvcmUgY29tbWl0
dGluZy4NCj4gDQo+ID4gSSBkb24ndCB0aGluayB0aGlzIGlzIG5lY2Vzc2FyeSB0byBhZGQgYSBG
aXhlcyB0YWcgYmVjYXVzZSB0aGUgcHJvYmxlbQ0KPiA+IGhhcyBiZWVuIHRoZXJlIGZvciBhZ2Vz
IGFuZCBubyBvbmUgcmVwb3J0ZWQgaXQuIFByb2JhYmx5IGJlY2F1c2UgdGhlDQo+ID4gb25seSBw
bGFjZSBETUEgdHJhbnNmZXJzIGFyZSB1c2VkIGlzIGluIFUtQm9vdCBhbmQgdHJhbnNmZXJzIGhh
dmUgYQ0KPiA+IG5vbi16ZXJvIGxlbmd0aC4NCj4gPg0KPiA+PiBDdXJyZW50bHksIG9ubHkgc3Vw
cG9ydHMgZG1hIGxlbmd0aCA0IGJ5dGVzIGFsaWduZWQuDQo+IA0KPiBJcyB0aGlzIDQgYnl0ZXMg
YWxpZ25tZW50IG5ldyBmb3IgdGhlIEFTVDI3MDAgb3IgaXMgdGhpcyBzb21ldGhpbmcgeW91IGFk
ZGVkDQo+IGJlY2F1c2UgdGhlIG1hc2sgb2YgRE1BX0xFTkdUSCBpcyBub3cgcmVsYXhlZCB0byBt
YXRjaCBhbGwgYWRkcmVzc2VzID8NCj4gDQo+ICNkZWZpbmUgRE1BX0xFTkdUSCh2YWwpICAgICAg
ICAgKCh2YWwpICYgMHgwMUZGRkZGRikNCkFTVDI3MDAsIEFTVDI2MDAgYW5kIEFTVDEwMzAgaXMg
ZnJvbSAxIGJ5dGUgdG8gMUZGRkZGRiwgc28gSSBjaGFuZ2UgdGhpcyBNaWNybyB0byBmaXggZGF0
YSBsb3N0Lg0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL3UtYm9vdC9ibG9iL2Fz
cGVlZC1tYXN0ZXItdjIwMjMuMTAvYXJjaC9hcm0vbWFjaC1hc3BlZWQvYXN0MjcwMC9zcGkuYyNM
MTg2DQpQbGVhc2Ugc2VlIHRoaXMgbGluZSwgaXQgZGVjcmVhc2UgZG1hX2xlbiAxIGJ5dGUgZmly
c3QgdGhlbiwgc2V0IHRvIERNQV9MRU4gcmVnaXN0ZXIgYmVjYXVzZSBETUFfTEVOIGlzIDAgd2hp
Y2ggbWVhbnMgc2hvdWxkIG1vdmUgMSBieXRlIGRhdGEgaWYgRE1BIGVuYWJsZXMgZm9yIEFTVDI2
MDAsIEFTVDEwMzAgYW5kIEFTVDI3MDAuIA0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCg0KT25s
eSBBU1QyNTAwIG5lZWQgNCBieXRlcyBhbGlnbm1lbnQgZm9yIERNQSBMZW5ndGguIEhvd2V2ZXIs
IGFjY29yZGluZyB0byB0aGUgZGVzaWduIG9mIHNhcHBlZF9zbWNfZG1hX3J3IGZ1bmN0aW9uLA0K
aXQgdXRpbGl6ZXMgYWRkcmVzc19zcGFjZV9zdGxfbGUgQVBJIGFuZCBpdCBvbmx5IHdvcmtzIGRh
dGEgNCBieXRlcyBhbGlnbm1lbnQuIGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvYmxvYi9t
YXN0ZXIvaHcvc3NpL2FzcGVlZF9zbWMuYyNMODg5IA0KRm9yIGV4YW1wbGUsDQpJZiB1c2VycyB3
YW50IHRvIG1vdmUgMHgxMDEgZGF0YV9sZW5ndGgsIGFmdGVyIDB4MTAwIGRhdGEgaGFzIGJlZW4g
bW92ZWQgYW5kIHJlbWFpbnMgMSBieXRlIGRhdGEgbmVlZCB0byBiZSBtb3ZlZC4NClBsZWFzZSBz
ZWUgdGhpcyBsaW5lIHByb2dyYW0sIGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvYmxvYi9t
YXN0ZXIvaHcvc3NpL2FzcGVlZF9zbWMuYyNMOTQwDQpgYGANCnMtPnJlZ3NbUl9ETUFfTEVOXSAt
PSA0Ow0KYGBgDQpUaGUgdmFsdWUgb2Ygcy0+cmVnc1tSX0RNQV9MRU5dIGJlY29tZXMgMHhmZmZm
ZmZmZlhYIGJlY2F1c2UgaXQgaXMgdWludDMyX3QgZGF0YSB0eXBlIGFuZCB0aGlzIHdoaWxlIGxv
b3AgcnVuIGluIHRoZSB1bmV4cGVjdGVkIGJlaGF2aW9yLCBodHRwczovL2dpdGh1Yi5jb20vcWVt
dS9xZW11L2Jsb2IvbWFzdGVyL2h3L3NzaS9hc3BlZWRfc21jLmMjTDg2NA0KVGhhdCB3YXMsIHdo
eSBJIHNldCA0Ynl0ZXMgYWxpZ25tZW50IGZvciBhbGwgbW9kZWxzLg0KDQoNCg==

