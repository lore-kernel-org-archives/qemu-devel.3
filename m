Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE515C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 01:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBlh4-00011p-Nn; Mon, 27 May 2024 21:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBlh2-00010q-HU; Mon, 27 May 2024 21:32:00 -0400
Received: from mail-sgaapc01on2071e.outbound.protection.outlook.com
 ([2a01:111:f400:feab::71e]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBlgz-000115-Ud; Mon, 27 May 2024 21:31:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG+2dfXbr1qK8iuALfLdBFwY5khmcVnknYLtN9L7LDmfp/a2ikYmVQRyUXF7Cw0r98UuesgasOrXTQlW10K6pO3VaJzo36hJvLBimnLd5PCLv3oONgNDacv5lTrLBlv8M4xS+tRzdmw5VaobRgncDIXEbZNns3yiB5V7D8VmS156Eb4O4f1T6FGM64Cpi90kx4Lo+vIBpeFkaoS/vdYfPgCmNoucS9uI3/zKSzfBlOJILE/E9VHOd6TVpUCtC+vswcBJJDqsd465MFZyxaGnMJhjo7OrATR5DwLPGcrEGUnCE2+LHVoxmFFIB7RL6QeZtpktJF84OF2LlaEJPrBmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9inyiGC08ZJJB784eL38XZAwo5UsWTHVG+zUozoobww=;
 b=AVL8Oe3MUeRvG7ejkBTUDt+CLJPwrC6ts4nSDIemr11Q0DKOq70bX1OgqK0Jp0huBu7OLNYQjw4oEJMH8vGg7fZtBp2JQCxevQQuAFOcOdRvJQtYeWjeI/t2AEJ+Rp2GrYG8ndwFZkcntREmDluSovMHJOhdGEZtVzoYnQoYTQQzuWogzo913c9RBUyCKqWKqIDxzDbY05RPPpMvT4wgWMdW3UssT+K6BcjR7Iq8e2HFObAnK0F5kaJJheG/N8XT3YhgS+3xZ6AN8dH2RwwGFiPxSpN2l7H9vUx76FEqx/IAAl/E9DznQVD0BeRyDFvVysOcjjVyQM4CDHuSauEJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9inyiGC08ZJJB784eL38XZAwo5UsWTHVG+zUozoobww=;
 b=N5MMbxltmvNnFylF6zpGK/Zeh2s4szaQ8EXFdX/PD0KAwOXFUhW+ab39KuDmEEKQF1IJhSSGLdyQWbzagf9NLqnpyijflEe7n0EHnySwdBstPURsiKglj7dAFj8HZt1Z3pBHwF8/jWW//EZicDK7lMg7g19NvnnqgnOb1eaAA4QGQ2Q2YF1GV3rSYPFQmm735R3i159veFG3jZJdZEAqMaNFxz3q28lFxPVE1gj4FkcPJFr6iMLB6Lo+A61qvXf+M0t5U6KHHw2HauIRyvnbz2Uxm4Gqiyjm/f4yuiaJ+4yH2z+PlgmgSuH2YV0sC7+yc9wpwFxwB7w3L2MX806+cQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6643.apcprd06.prod.outlook.com (2603:1096:101:17d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Tue, 28 May 2024 01:31:46 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 01:31:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: RE: [PATCH] aspeed/smc: Reintroduce "dram-base" property for AST2700
Thread-Topic: [PATCH] aspeed/smc: Reintroduce "dram-base" property for AST2700
Thread-Index: AQHasDN/L02Anh+9ekWZj5QV0BUb3LGr3KEQ
Date: Tue, 28 May 2024 01:31:46 +0000
Message-ID: <SI2PR06MB5041D3F4B9678C3A4B51250CFCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527124315.35356-1-clg@redhat.com>
In-Reply-To: <20240527124315.35356-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6643:EE_
x-ms-office365-filtering-correlation-id: 38228929-b758-439d-5008-08dc7eb5f03a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MGpValpLZU9JTitzZU5lN3o2a3A2bnZNQmNxVWlybGl3UnhwbkY0QTc5NUZi?=
 =?utf-8?B?UDFuT1pvSFhoVjRjSTBCVWNTc2pFMTR1ZHRid0NJa0tjYm5lQ25VakZkN1cw?=
 =?utf-8?B?WktuTmQvOFlqaWlUYXNNNTg5ZmdQOWhNRkFzalZKb2g0UTFmL0ZKWWdzczNv?=
 =?utf-8?B?bTQ1WnNHWkJjWTk0eTBPTk9JVkxoczZkdE5ldDFrU1Z0RmM4VFB6WG5kQUJx?=
 =?utf-8?B?d0ROK3RxK09kTjlmWGpmYktxV1lzTFpXVUVFWGxvd2xqc1p0K1RQNjhMMDB2?=
 =?utf-8?B?eVI5b0h0KzF0Rnpwb3E3dGIxS3JLd3M2dmVOalozbEw4eGZLaFZxdmZ5NTdl?=
 =?utf-8?B?dThuck1lWWgyTEM0a2V5RVlIdTZpTitvOW5vSmNqNG1jVXNvRTg3VHpkZTN6?=
 =?utf-8?B?YnBFdVFONkdnZTdKbXF3RnUwYWxLVWozeFU4eFdIMjJCNzEzLzk4V0ZOV3lJ?=
 =?utf-8?B?U0Y2bWpvd3UvSy9uMnJMcFp1Q0doOFNQRnU1REZoM1dpRmFvYWkxbDlxNFlB?=
 =?utf-8?B?M1lhSDUwVkcxektIWDMvcnkrUGFkWTdHZytubHgrOHhDVDdqK2RwVnpuYnMv?=
 =?utf-8?B?b0xnQWRLTjNQSUN4b3h3disxeWw5K0p6d3RaWVY5bkF5UC93UXBWN0R4MmNt?=
 =?utf-8?B?NjhQMmhsMmlpazdRK3VxR1crbmcyaStqRklEd1ZpdXFBUWliMWZVeGNHekd2?=
 =?utf-8?B?NDV0WVRsUnVTZDNEVFhZM3ZvdG5YeHBQcEpIT1cvSW9PYjhJRmFjNU00VDdO?=
 =?utf-8?B?QTFxSXFpaEI3Y0kyZXFxMTZjVmtabFlwemZVbmcyTEdLWFdOTHhHYTNsNHI2?=
 =?utf-8?B?dTY3WVB6Y3c5NzZrbkFwRjcwaU1JQjhhWlJyTW9MMTR6anBTZTVPZlRkSWdn?=
 =?utf-8?B?TWpMbFdDbkdGeW83QWVzaVdvdC9KMHlFREliU0c2OWZYNjA4UnZRdGFpSEV3?=
 =?utf-8?B?OTdIdEdTbk02U2JqRUFkTWxVcGtUZE9iZHNRQXJuSGxGT2M1d2Jrd2FwbU9X?=
 =?utf-8?B?WWlkNE9PckJJQXJEM3lTcFEySTBxSGVtVjE3dEZCbTBFbGtudnZRanlIVlUz?=
 =?utf-8?B?eXRMakFMNjRiMHQrWjRIV3ZsYWt5eXNKalhMZXpSR01UaWZVM2h6QkpTT1Za?=
 =?utf-8?B?cG5RSzMxTnZabWhCRkwwRXZCenVVdFQ1WHNUM3hoMzVmS2s3Um0yNmUxUGRJ?=
 =?utf-8?B?Wnl6U2F2VmUxSlRHSUpUTmoyVnBmYzhuOVpxVlFSa21yaGkzZDNCczdPVklJ?=
 =?utf-8?B?aEh1Zmd4N1grR3JKN2FlY1ZWcFVObXlKbVI0VmJtdHg0TkNmOHltdXJ1U1hX?=
 =?utf-8?B?akl4WENOWlgwaFV1dnNvb2w3am5mQUtBZ1IwWU9iaS9EWXBGYVpBUGtsVmlJ?=
 =?utf-8?B?MHAwOFhTSmJsaHhrRWQrSXo1M0k0Q053a2hteUhHVHNyZDBwQ3htOHJZSHkz?=
 =?utf-8?B?d1NLSHJNSlkrSlVYdmt4VkgvdHd5ZW9ja0xtSWlmYzR2UitTbzlUc0R6L0Ew?=
 =?utf-8?B?S0EyK0xTTE5sdjA4Q0RBNVdsNHRtMDdxRi9laGpmaXMwOEZqemgvbWV0Q2J6?=
 =?utf-8?B?VWNvWWZ0SGZaQmc1UG5QVFZvZkZiNnVhYjB0OGF3ckN4dy9xbms0Q29EeXBT?=
 =?utf-8?B?TXVQMENpcDFjWWFSZ1FzZi9pV0FVSUlrTFA2RkxuRnk0cXNUcTRFcXNEVVlQ?=
 =?utf-8?B?bTdRSjg4QUZWN0xTbTJVV3Q1QUVsOE9ZQ05iRG5FMGZNdWtkaCt0VmlOVHRI?=
 =?utf-8?B?U2hKNVVZUElXSndIRHJmVXVKSStBNUlwN2JNOGNaR043SjAzOG81OTEyemc1?=
 =?utf-8?B?YzNMa0hId0xDV1Bpc2VCQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBOeWlWblRpVmEvYjhIMjRjdGFTcFJTbUN2VWd1QklWNFNPd2hrbE5MejZ0?=
 =?utf-8?B?NkdiNzlBMkhBTkpuWUNXZUtSKzFhSnNxQ2VhZzdmQlh3TFN4aXd2RUxmL3pN?=
 =?utf-8?B?ZWZBdFNWcmIxQVJDMW9DWnhDa2pLZlZhMmhnTCtpTEk1eEhRN0JTcmVkTVhQ?=
 =?utf-8?B?L3NObDBJek1RSmNUaHM4VHArTnpJNGVTcklMNmRqU09WYURSZGR4cVphODdh?=
 =?utf-8?B?aldGc3ZWVWVDeXl0dkVRazJVQmdSaW5rZGF5ZDZpVDFneGlOdnZ5Tk1SQXIv?=
 =?utf-8?B?ZVZQY0YwZnNuK2JuZVZwTTdDNnI0eElGUG1BTFU0dGNrZjVha1V3Y2pKdExC?=
 =?utf-8?B?REZ0ZE50ZXFSbGRXU25mWGlYaDl2SnhuTEx2NFZOM0ZXRHpqU0tnam5SNlQ5?=
 =?utf-8?B?RFY3aTY3RktKZG8rOWwzSVFNZHprRzBRVDBjam1PeXhHUkJBMnV3M2VaS3N5?=
 =?utf-8?B?NHdZWkxYN0hCTG1HWkRUTmt6L0J4dGk1QlpXb2VKUTg5Zy9tRmxlTHZYdUlm?=
 =?utf-8?B?ZzVhdWMxWEgzcDhyaHRWbnJrelA5VGNqeEFtVkxseFhFeXFwcnF4bDcrWnIx?=
 =?utf-8?B?WnNSUG1obm5sVVdib01YSU9Ha21vTE8vVWREV0dSTStWN1lBaXVuUXp4WEpa?=
 =?utf-8?B?UkNWUTNBVU9hZ3BNazZnZENPdGthaVZWcTFWekcvSGpvcDdjTnlSOUdIcHRN?=
 =?utf-8?B?eEpnaUUveUdEZjdDemVxZHFxZ3czQkdCWEQyUkxQY2hZeUIwRTdXRUs4ZTEx?=
 =?utf-8?B?MFB5eGxuTzltQUJlS1ppT0RyQW16UlJLZE9adE9MSFFaUnl5MC9MSEhQbnN2?=
 =?utf-8?B?NmxoN3Zwb2xTeFJXMk9DbEg2VC80ZEhwVUQyZGpDcDlwTTdPTXhPMk12bGht?=
 =?utf-8?B?VnQ4cHczVlB1SzZ2czR4UnJrUDVjYnBneHlvM21UZUhubDJvYmsrWFl4M09O?=
 =?utf-8?B?bEdGRm1jalo5UDFnNEtlTEI2Z0pURXF0Rmt4OVRpSnNZN0xBc1BabHNTYngr?=
 =?utf-8?B?bzRSb0VjSXZyNjZaV2hTWDRvT2ZGejRwdzRCS3NUbjBVbzg0UGI3SEdidlNK?=
 =?utf-8?B?Vy91LzFWUEZrdHBZSTQvR0ZyWmJVa0s0K3pOVVJVbVhNeDFUWjdGTHRUc2Jm?=
 =?utf-8?B?M0V3TEJFU1ZFcXlEbnhSTTNxZjYzaWVpcFU3N0dUZFphc3dDa0dwNkNrUEl5?=
 =?utf-8?B?djFKZUZkTGRQK1hGNnFIclAwVzJMSnV4RXRVOXBieDNjWXZranFSbXJwejZr?=
 =?utf-8?B?ZktvYTVhKzF1bisxS2twSCtaam00Wmc5bzFhd3Frcmx4VnhGOXVQZjV5Q2p2?=
 =?utf-8?B?MGRKMzFsU2d2TldXZ201R0NONjNnVVI1djd3cE9jU2FUTEJOWTVvcG5sZHEr?=
 =?utf-8?B?NGUwa3lZWkVnZDhqamJSUGE4WFc0eXVoU0I1cUpaYXI3dFNZQ0JhaHNYWnNv?=
 =?utf-8?B?Ui9FMzIxbk5GVldQTVFORHFUY0Z1WWZVOG1LYzhLK05UZlBIZkFVVHlYSmxj?=
 =?utf-8?B?YTFiMHZoNEVqUWlhbDdtejRZZk9US3Y4a3B6d0pFNUo3dWhoc3J3NVV5eGVx?=
 =?utf-8?B?UDNmeXZTVU41NUxQT2RWaTJEQWY0dU0vZEJWSzBVSlhpSVl6d2FpdldNQzlR?=
 =?utf-8?B?L3lmYm9UVExDUUxnZXlndXhjZXlGTUxRWGRBQUI1VUJFcHc3Y3MzSkYyaXJ3?=
 =?utf-8?B?MDhmakhpbGc3aFFMb0xNM2VPZEtHTUYva1Izckx5RFVsN2JyVzlUa2FZbFdM?=
 =?utf-8?B?MUlmRDVMSUt5bzNYZ2FXR0VFSVhvSmR6KzFSNnR2LzV2bTNTWXdiUVBMWnpv?=
 =?utf-8?B?T2FnS1Rmb255aVR5aElHdVhCcDYyem1McFNSZXJxRDJrcW9TTUU5VE5QV1ZN?=
 =?utf-8?B?OHY5eU5kTERsdGZGNTdzYXF4L0xoaWlmZnNRTmpZY2JJR2VZWXZwajNzYkhS?=
 =?utf-8?B?bG9yK1k3SFZncmFkQW5LNGhQNEFnVk0xTkdTV3ZnMWpxOHNoUHh5RHhLaStP?=
 =?utf-8?B?WHVlVXZOa0ozSlJqYTk1aVJGZnV6MGhHVUJaanYxVXRzRWRTV1hiZlEwMkwz?=
 =?utf-8?B?YWFWM2czbVNEUHE2aUtEdTRXbjg5ZlBaQWhNSGwyb3ljTTMwcElybC9POTFE?=
 =?utf-8?Q?KUhhwT2Nce6eJgvk3jl1FQ4tY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38228929-b758-439d-5008-08dc7eb5f03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 01:31:46.4023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOITpqQuM0dM1Iznss739aEUETieo9U81AuGE6ctqKGTfz18dxJukekKc1f3+EwiysFuS93I3oxVKbmdYnUM9dIGviz8W/trxKHX3d8IVCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6643
Received-SPF: pass client-ip=2a01:111:f400:feab::71e;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiANCj4gVGhlIEFzcGVlZCBTTUMgZGV2aWNlIG1vZGVsIHVzZSB0byBoYXZlIGEgJ3NkcmFtX2Jh
c2UnIHByb3BlcnR5LiBJdCB3YXMNCj4gcmVtb3ZlZCBieSBjb21taXQgZDE3Nzg5MmQ0YTQ4ICgi
YXNwZWVkL3NtYzogUmVtb3ZlIHVudXNlZA0KPiAic2RyYW0tYmFzZSIgcHJvcGVydHkiKSBiZWNh
dXNlIHByZXZpb3VzIGNoYW5nZXMgc2ltcGxpZmllZCB0aGUgRE1BDQo+IHRyYW5zYWN0aW9uIG1v
ZGVsIHRvIHVzZSBhbiBvZmZzZXQgaW4gUkFNIGFuZCBub3QgdGhlIHBoeXNpY2FsIGFkZHJlc3Mu
DQo+IA0KPiBUaGUgQVNUMjcwMCBTb0MgaGFzIGxhcmdlciBhZGRyZXNzIHNwYWNlICg2NC1iaXQp
IGFuZCBhIG5ldyByZWdpc3RlciBETUENCj4gRFJBTSBTaWRlIEFkZHJlc3MgSGlnaCBQYXJ0ICgw
eDdDKSBpcyBpbnRyb2R1Y2VkIHRvIGRlYWwgd2l0aCB0aGUgaGlnaCBiaXRzIG9mDQo+IHRoZSBE
TUEgYWRkcmVzcy4gVG8gYmUgYWJsZSB0byBjb21wdXRlIHRoZSBvZmZzZXQgb2YgdGhlIERNQSB0
cmFuc2FjdGlvbiwgYXMNCj4gZG9uZSBvbiB0aGUgb3RoZXIgU29Dcywgd2Ugd2lsbCBuZWVkIHRv
IGtub3cgd2hlcmUgdGhlIERSQU0gaXMgbWFwcGVkIGluDQo+IHRoZSBhZGRyZXNzIHNwYWNlLiBS
ZS1pbnRyb2R1Y2UgYSAiZHJhbS1iYXNlIg0KPiBwcm9wZXJ0eSB0byBob2xkIHRoaXMgdmFsdWUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
DQo+IC0tLQ0KPiAgaW5jbHVkZS9ody9zc2kvYXNwZWVkX3NtYy5oIHwgMSArDQo+ICBody9zc2kv
YXNwZWVkX3NtYy5jICAgICAgICAgfCAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9zc2kvYXNwZWVkX3NtYy5oIGIv
aW5jbHVkZS9ody9zc2kvYXNwZWVkX3NtYy5oIGluZGV4DQo+IDhlMWRkYTU1NmI5MS4uODc5MWNj
MGVjYjExIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L3NzaS9hc3BlZWRfc21jLmgNCj4gKysr
IGIvaW5jbHVkZS9ody9zc2kvYXNwZWVkX3NtYy5oDQo+IEBAIC03Niw2ICs3Niw3IEBAIHN0cnVj
dCBBc3BlZWRTTUNTdGF0ZSB7DQo+ICAgICAgQWRkcmVzc1NwYWNlIGZsYXNoX2FzOw0KPiAgICAg
IE1lbW9yeVJlZ2lvbiAqZHJhbV9tcjsNCj4gICAgICBBZGRyZXNzU3BhY2UgZHJhbV9hczsNCj4g
KyAgICB1aW50NjRfdCAgICAgZHJhbV9iYXNlOw0KPiANCj4gICAgICBBc3BlZWRTTUNGbGFzaCBm
bGFzaGVzW0FTUEVFRF9TTUNfQ1NfTUFYXTsNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9zc2kvYXNw
ZWVkX3NtYy5jIGIvaHcvc3NpL2FzcGVlZF9zbWMuYyBpbmRleA0KPiA2ZTFhODRjMTk3MTMuLjcw
NzViYzlkNjFiMCAxMDA2NDQNCj4gLS0tIGEvaHcvc3NpL2FzcGVlZF9zbWMuYw0KPiArKysgYi9o
dy9zc2kvYXNwZWVkX3NtYy5jDQo+IEBAIC0xMjIwLDYgKzEyMjAsNyBAQCBzdGF0aWMgY29uc3Qg
Vk1TdGF0ZURlc2NyaXB0aW9uDQo+IHZtc3RhdGVfYXNwZWVkX3NtYyA9IHsNCj4gDQo+ICBzdGF0
aWMgUHJvcGVydHkgYXNwZWVkX3NtY19wcm9wZXJ0aWVzW10gPSB7DQo+ICAgICAgREVGSU5FX1BS
T1BfQk9PTCgiaW5qZWN0LWZhaWx1cmUiLCBBc3BlZWRTTUNTdGF0ZSwgaW5qZWN0X2ZhaWx1cmUs
DQo+IGZhbHNlKSwNCj4gKyAgICBERUZJTkVfUFJPUF9VSU5UNjQoImRyYW0tYmFzZSIsIEFzcGVl
ZFNNQ1N0YXRlLCBkcmFtX2Jhc2UsIDApLA0KPiAgICAgIERFRklORV9QUk9QX0xJTksoImRyYW0i
LCBBc3BlZWRTTUNTdGF0ZSwgZHJhbV9tciwNCj4gICAgICAgICAgICAgICAgICAgICAgIFRZUEVf
TUVNT1JZX1JFR0lPTiwgTWVtb3J5UmVnaW9uICopLA0KPiAgICAgIERFRklORV9QUk9QX0VORF9P
Rl9MSVNUKCksDQo+IC0tDQo+IDIuNDUuMQ0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcy1KYW1pbg0KDQoNCg==

