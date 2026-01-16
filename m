Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81E0D4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeeh-0004i7-Fg; Fri, 16 Jan 2026 02:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeef-0004gD-2U
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:54:01 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeec-00039x-Hs
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:54:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzjKhken6B/4XPJOYWosNUFcCG2ndDEzmMaQ+VHoN36JEmsnheXLZcxRctdaLvDJKIqcv0bY7Wbf4C0TFbp5nduXhOY5rzQRUaz1xQBmMBU0K7xyHhzEMU/9EE7mrdLn1cgWeUOtM89HezNbBA1H3LmyBcC2xueU0ddBGZByfEYqxH6Qhli/uZwm5kDMvxoDssuWqbCuj1EDe5nXJnaaqd5E3vDiF3SxQrFp3bUjKFjADGylGnqpWUmIOjoVYI2WBWTo3UMFQMhh+UFVIq828IlvMXD6Wr4m+Q8Cz+Zk3KQaAy5nUl7lRz+04xOw1lk8rpDW4KmIapNN4G+mxFUOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/y028zx7aCjauujbs+vlYSN3U/2k4gblZxY27o8+cU=;
 b=JRj39oehHqAlDE4fZfA3IoM5zY7v7XXMullL10SCoyeLjJkQWzqPXQO7hs4NLcKbm7flK9G/EJFpeMXesUAsesqKcqHXSZ5o2Z1fiMfl3114FaZmMMCyogpHq+UTVg2bP2I0JNkgkqhLcnY2I26TnieT0KnB0MAGXyOg2kyoa+I7UzxAMkRoLKetMTme5ZEAjqDdKz3wSa3+2q+vxH2xVgM5jbGuyNG7AvyGPciGONhYNFPQ6PZW+iqBLgR7N+ksdLGa3TKzT8KcYG3oD52GMhMeILLgmx4I4AiC3cfP+jocbVkGmRfERM3KGYY4oLT//9Xgn/zlRR/Xv+uEDYuXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/y028zx7aCjauujbs+vlYSN3U/2k4gblZxY27o8+cU=;
 b=m6rHBdvQIBTJ3SJhG1Do2SPuDZZt1yy9pryKvmkLU6vmG2BB5gwZ5Hyqhbd1bROdpSedXDQDaApXPUK2cKl4rF2lxglXyEz1YkwfbDHdL/CF3YRO4rAXiymQJMTIciYxMYTzU06PbDVQW63kiTEsuyH15Wy3pUM8X892Isj97bwosVh1GQEZJh9m5Beq+Wxr17PW7SCpvSgVs3GnXMQMFJSDjbl2c0+rL6gJrgubcbU4XRIMeQlNnMw2+m+vVQjl/YK6M/f2Bi+bmRD1Zz8wOrz1xPfemWHnioIsdMM8u1GIhepIWEoB7yFnNYKdFJ9VbwLP+bzR+WJdD8crRNqhUg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSQPR06MB7112.apcprd06.prod.outlook.com (2603:1096:604:291::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:53:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 07:53:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Nabih Estefan
 <nabihestefan@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "komlodi@google.com" <komlodi@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
Thread-Topic: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
Thread-Index: AQHchcf4AeTU1f63gk6KDympXQdmeLVTadwAgAAAgQCAAJOH4IAAQriAgAAn6dCAAAWrgIAAAEvg
Date: Fri, 16 Jan 2026 07:53:47 +0000
Message-ID: <TYPPR06MB8206F62F6FD59B26D50BEDE2FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
 <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
 <TYPPR06MB820664D78B0B4F5A780822B8FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <14e4bfb8-9458-4f75-a479-878ef8d286c0@kaod.org>
 <TYPPR06MB8206370E45E78812598BB1D4FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <2ed6bde8-9a68-4eca-ad2d-12f7b2ee597e@kaod.org>
In-Reply-To: <2ed6bde8-9a68-4eca-ad2d-12f7b2ee597e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSQPR06MB7112:EE_
x-ms-office365-filtering-correlation-id: bc9da1c5-8b27-4d3e-b572-08de54d4614a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OGRFQnBxWUlrR2dyTE1JcnhCWXdpTUFuRzAyNDI0NjYzMkdHYWZLd1lJQkJL?=
 =?utf-8?B?cGdxZ0h5WHNvdXhYTGNVa3ZLUVdLaFkwOTFJQ3hTeFVTUGw5U3A1T1g3UE1W?=
 =?utf-8?B?azdpWlFOQ1ppdE9VaVVQZ0VERnZJUmlYb1N0RzNpTG9OMjY4eXVwS2YzaVBR?=
 =?utf-8?B?N1FScTErM2d0b3hGTnU5RXJVUXVsLzZZT1dWMHJpa3hCcTZId0l3NldYVkd0?=
 =?utf-8?B?eHNFaXRXQkk3VlpObWw2RDVMcTFkenl1RjQ0b0RpelJoN25RS2pic3BUZUpM?=
 =?utf-8?B?RFBxSHlNcWdGU0dBYjhGeTFyM2JpcG8zdG9rc3N6dEkwZUc5V2MxUGlYQTVa?=
 =?utf-8?B?VHZRSHlHQTZhYllIejNsTkY5cHY0Rkd4ZGxjRGxMaEtJb1FOdlh4eGNYNTNw?=
 =?utf-8?B?cGRhQ01xcWpEd3VMRlFjSGJ4ZkoyUGJnWFpML1grcGJoTjZVc1hnZWdiaFdy?=
 =?utf-8?B?WlZYckFCdlE3Q0RZeExDczhVK1krS1JvVnArZTU5YjZJN3V4SGZYTGZSbTl0?=
 =?utf-8?B?dDFpOUFZSWF2SFNiUHp2SE02MkdUK0RGN1BITEJzMDEva082WVJ2VlJFNGww?=
 =?utf-8?B?dVdyelczSUU4L1EyRW00eCt2WHhRaHhQWW11a1lhWVVQb0tCeFFsK1JLWXc5?=
 =?utf-8?B?Sm9mdkhFNDl3KzBPQU84cWU3YVdzVmI0d0ovS3FkWGlWb2h2cEFNeW8vaTNR?=
 =?utf-8?B?bE5JZmpoenRPcTZWdGhEUGJZTTZRbDBOelJzTU0wdUdDTnZha2M0MWpvYmpR?=
 =?utf-8?B?SXgwblpsa3dZMG94YXp0Yi9RcVFySjFBckc0UERKQ2g3M3EvaFJZbnZmaUZ2?=
 =?utf-8?B?M21IaTJaRTd3VCs4MjN1UW14b2ZOQXpkMVpja01qc2ZCSXJISGhXaHRqMHFH?=
 =?utf-8?B?aFdCMFdTK1psY1YxNk1CVzhtWjQzY0dEMzJBTkdiZEltZnJIV0ljS2dXRE5x?=
 =?utf-8?B?a1U2aDRUczhCdGNDeXBJbnplZ3h2ejgzZkRSOWhsaFN6N2dqT0ZaZUF6M3R6?=
 =?utf-8?B?WTRIQ2J5MDNtZGMxaWNXTGpVZk5jSCtTSjJ2LzVVR0dESGRlOW42QWtJamNk?=
 =?utf-8?B?cjVkOUY0eGE5NmU0UDVCVUhXS0Y4OGpLSWFIemR2N2xIQnUwZWdiUXB1RTEr?=
 =?utf-8?B?VjhuUGF2OTNYY01GMEw1V2NkY2tTY0FXaXZRbjJRZyswMWJIQ21HODh2WXNB?=
 =?utf-8?B?WUlDREJaMm9CdUZIMXdoa2hDQVQ2V1psS2NSTFBwWDRZd3RxRDUxSDZ5VEow?=
 =?utf-8?B?Q1EvWTlzT1V6MC8xa2I0Q0xPc281K1BoNmI2NnlmMFRKT0xZUDZPbnowelU0?=
 =?utf-8?B?MkM3TFUrZ1RZS3hJOWl3Z05lcWszYkk0K0xLenR6a0tKdlYrWEpmNm9XUzlE?=
 =?utf-8?B?V29MUHlodW5VQW81L2JJeHpKdkwxL1QwTGlVUGwzNDF0eU1wUkVRUjRjSHI4?=
 =?utf-8?B?SkVRaHREa1ZaYlRVWnVIMmNVaDRIRGJZbTRoRDdaL2ZRTDlHYzRtdGRKY2Zr?=
 =?utf-8?B?NCtUVnRVNG1kSXI0UU5DRFRNcXBPdUhJWUVEM2p1MXR1dzQzWTFKd25hVmZP?=
 =?utf-8?B?eTBFNnQwVTJEYXZwU0R2RXBDS3AyMVhJaEhiNmdLNzNtZGRub2Zjcm51VldN?=
 =?utf-8?B?MUNEOVREaFgvRXNTWWxuYkJCT1MwQ004dkEyY21wVk1nTDFWa2JBajJLN0My?=
 =?utf-8?B?dVRNTUhlcTIyY081dGZLRDl3NjZLYmM0anNhV1V0K3EvbE45Wkd2WEl4U2Zz?=
 =?utf-8?B?T0d2ZEQ4cVM2aHpMK2JRN2dTeTRtdWdhQ2ZRdEV4Q0Z6OUMyaHFZS3gxV20x?=
 =?utf-8?B?RjkvMTlGVVpDcTcxRHdycEhKV0VFWTJFZkg5KzgxNEVDUDJsWmVrSnl4UGVD?=
 =?utf-8?B?eC90cDIrcnRaUUJ3aU16UWkrUXpFUm1kckJmK1F2RC9GOVZBSW4xRE5zMC9x?=
 =?utf-8?B?L1RxRzVWbFVQOXFxTG96TGVWc0ZlamNCUUFYWVhZNFFZODhEOHoydlFJVVZ5?=
 =?utf-8?B?M09PYUZtd0tscHRPQkh6WlB6VnNweHZ5dll5UnNKTVkza0ErdUlrQUNPWVBp?=
 =?utf-8?B?a0hYbFl5SjEwaGtPYmJrb0ZFbDFhc3lZZ1dud0lRT2xRUWhMVDg2ODA2UXRY?=
 =?utf-8?B?WmNhRlQwZFpmN2tyeGdmeDE5TnpIUGJUSU5RNGZJS2FiUEdnSVhrdFdYbW8w?=
 =?utf-8?Q?BdfNUbsjJasHr5J3psBvBtU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3hWUW5TRC9IWXVwSGZJV3R6eUc3WlhvSDBMYjZwOGxSL3BXMHlIZGlZUDdo?=
 =?utf-8?B?M2JKTG5tdFNESW43WWJseDloM1BFOGtadmZiaTZkbjNoQUpxc3phSjRaVWZO?=
 =?utf-8?B?RDFkZHZlLzh3a2ZMeDN5RGRTSXUvT1JSbVpGZjVxU2JyTVo4Ri9nUDl5VFVl?=
 =?utf-8?B?ZnhhaTRMVXFNKzlTOVFDNkExcnJGUitBQi81akxuZXFkYklkOGluYjQ2R1VY?=
 =?utf-8?B?aGxvVFFva1lJUDhlZjNmRUV5S1BkekN5aXlxcE1OMlZzY0dBQnhVcUxQOVpY?=
 =?utf-8?B?R0hSZmE2VTZRSkhSbUxmQzJHR21NVnNhVTJGeU5GSE1QLzRRdWlyMkpwTjF1?=
 =?utf-8?B?TnllUU80d0xDSTVWL1Zsb2wzaWR5S1BxODlmQXFuWHI5RVpsY0Z0cXU5VjVl?=
 =?utf-8?B?aGdJUWRGY3Z1NlFIZ29NSUdxRE92QWRtZ3o1VVpBK2xrSGY0M2x6TmJ2TXVi?=
 =?utf-8?B?MElySGhwNng1aWloYlFoY3A0dERuS05jdUJib2pCcisvbFNvL3JhMW5Sc05T?=
 =?utf-8?B?S1lvZi96enZiS0FSZ0ZBT2ZjM2pZdXlvQXc5d0ZnOWQwV1NtZStPMEh5cVVK?=
 =?utf-8?B?WFozMTJ6T1Ayb3A1KzhwKzNEODhiZDdKenpMeGZHR05EY0l4YklKOHExRFlB?=
 =?utf-8?B?T3VSUXNqUHc0em43bVh4cnN0YUU2QzN6djhsU2Z1NmN0bVBWUHplNmZDKzRG?=
 =?utf-8?B?b21FbmVvemgzYnFGd2MvL2Mxcm1EbVhiYy9ZMDk2cnpYc1pmWTFPTXoreFNj?=
 =?utf-8?B?Y1RKamdkdU1ub01yODZtWUFXZkplUTk1OVZwZE4xVmtFYlFtR0puNzNRSUsy?=
 =?utf-8?B?YWFwanhKNmRocnNGR053MmRhZmwvb1hyS2M4WUVTbDdVaFRCaFRWMWowUXpG?=
 =?utf-8?B?T1Z1bExSSFdhRlk1dTZSQ1NicnhmQmpMalZmRklQcnA5bDcxYUdHNk96ZW40?=
 =?utf-8?B?cjRBNjl6YWJIZUVuaTFHSGQ5ZSsyMUZrYzZaZHZqMW54Q0xsS2UzaE8rWDhY?=
 =?utf-8?B?eGFzYTFWclBwNDVDa3YwdnJJSlJKdzhzR3hhKytSY3c1b2QzWjNJQnF2Nk5G?=
 =?utf-8?B?RURiYk9JSnBUak5JaDRSNFNjRkNHVndKczJTZ2p4T2JVbjlJVGlGdXpacFVw?=
 =?utf-8?B?c095L0tCNUNhNHRyTXQ1R3FCczJEODVFcHlXaExqTENlVjk5T1lsVlk1R09B?=
 =?utf-8?B?bkVEUklibHloL3NsUmZLeElxbVFGZDhpZUMrSVNZK2FrMzdIaEVURjQweEN3?=
 =?utf-8?B?OFBpSWk1WGV2d0dWa0ZFYzJsb25rbGNZdm5GZTFqRHBqR2lBaUNNcFVCRTRT?=
 =?utf-8?B?NGhmZm9qOWdFNUxHNnZlWkJQZS9PUjl6UzJ6aEFiaUJlS3JqV282aTYyQkdF?=
 =?utf-8?B?aHUzMDZycHBVWDJERVdITzlvc1VqcDNvQnl6clVSN0QrNGo4Vjg0eFVqcDJD?=
 =?utf-8?B?aVlqbFB6YXhDMWs5WVkwOXNCNmhIaWVXVWtBSFdUM2ZYeVR0cjJObm1ldkNN?=
 =?utf-8?B?ZmlBclpITSt0TkMzb0cyL0RCNU5CNUhDZ1NVeWhPMkxHMFl0eXRxSm1ML25T?=
 =?utf-8?B?VWt2cjA3QnlaSGRGeC9WZnBNMmVIVUxoblBNQ2VNakwzc1FoOCtVMGEyRk1H?=
 =?utf-8?B?YnB1WlVXWFYybjVDU3lsNWxmaUR1SWRQNklPVXd0ZVVVMVNycjRDZW00M0VV?=
 =?utf-8?B?R2FxclVaTmJZY3VQMHM3V3VaNjgwREFYLzQ0SXBSTjRLekRjckxJOWhMMXVE?=
 =?utf-8?B?RVJ1TERHeHVleGNmaGtRYVNtQXhIdFRKYk82MkxQeXdDTlRmZjNwR2F4WXRm?=
 =?utf-8?B?R2p2OVI4UCt4QnJkLzlZSTEycURPV1BjU3NteS9pSVg4d2F4YTRmSnI3QmJx?=
 =?utf-8?B?UkpGYjZPNVVheDZuRVhQdHhoandja0dsMVhaOVVKYVZFMTBIUk5oNFlPN3JX?=
 =?utf-8?B?Y0VrWk56WHk5RWpBaHc3ZzRqeUNEd3djVk9QQnlyNVZLWDE3K0VYanA0Uzlo?=
 =?utf-8?B?SmplTFhIWUY1UU1qUzAwcXFuZ1pubTVoK2NNVHJidTRtTFdrOTNpSSsxNWk4?=
 =?utf-8?B?S3hDU0xiNmNQWDJBcExRWkdwUnhIaVY0ZE5IL0dOUW1aU0dkQTFDSkhhRmlM?=
 =?utf-8?B?Y3NSMUNOY1hQUHpHMUZpS0M1SDY0OVJMWXFUOEpITzJFclJOWXVRV0QrLzdR?=
 =?utf-8?B?djEyQkdhT3V1ZkdhOTI4NGR3Q3BpcTMva0IyclJDVkcyTGVYWS9uMXA3bTZC?=
 =?utf-8?B?RmQ3Q0VpazMrRlM5OSszdmJoenhLZzRZN1VWcndWVGxzbWtROUxhSld2ckZi?=
 =?utf-8?B?QzdhYW10Z09McGVBZDlMY1RFMHpyTkVWZXljSUU5Q1hoZUVGdUNlZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9da1c5-8b27-4d3e-b572-08de54d4614a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 07:53:47.4298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cz4Fwlb60xacMuIEnOHFZ9NhvhrROCOOgwIDn80Vf3PEFq0EB+VF36eM9nvYuBTfQEnr0hYyxQY2aoB2MHjtVg7f0U78d2mJ4dFQP7SEYKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7112
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXks
IEphbnVhcnkgMTYsIDIwMjYgMzo1MSBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+OyBOYWJpaCBFc3RlZmFuDQo+IDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4N
Cj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBU
cm95IExlZQ0KPiA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyB3dWhhb3RzaEBnb29nbGUuY29t
OyBrb21sb2RpQGdvb2dsZS5jb207DQo+IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2gu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gcGMtYmlvczogVXBkYXRlIHZib290
cm9tIGltYWdlIHRvIGNvbW1pdA0KPiAxYzhlOTUxMGIyMmMNCj4gDQo+IE9uIDEvMTYvMjYgMDg6
NDAsIEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDw6lkcmljDQo+ID4NCj4gPj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MSAxLzFdIHBjLWJpb3M6IFVwZGF0ZSB2Ym9vdHJvbSBpbWFnZSB0byBjb21t
aXQNCj4gPj4gMWM4ZTk1MTBiMjJjDQo+ID4+DQo+ID4+IEhlbGxvIEphbWluLA0KPiA+Pg0KPiA+
PiBPbiAxLzE2LzI2IDAyOjIwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+Pj4gRnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPj4+PiBTZW50OiBGcmlkYXksIEphbnVhcnkg
MTYsIDIwMjYgMTI6MjEgQU0NCj4gPj4+PiBUbzogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFu
QGdvb2dsZS5jb20+OyBKYW1pbiBMaW4NCj4gPj4+PiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+Pj4+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZzsgVHJveSBMZWUNCj4gPj4+PiA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyB3dWhhb3Rz
aEBnb29nbGUuY29tOw0KPiA+PiBrb21sb2RpQGdvb2dsZS5jb20NCj4gPj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxIDEvMV0gcGMtYmlvczogVXBkYXRlIHZib290cm9tIGltYWdlIHRvDQo+ID4+
Pj4gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiA+Pj4+DQo+ID4+Pj4gaG1tLCBJIGRpZG4ndCByZWNl
aXZlIHRoZSBpbml0aWFsIGVtYWlsLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gQ8OpZHJpYywNCj4g
Pj4+DQo+ID4+PiBJIHVzZWQgdGhlIGZvbGxvd2luZyBjb21tYW5kIHRvIGdlbmVyYXRlIGEgcGF0
Y2ggdG8gdXBkYXRlIHRoZQ0KPiA+Pj4gcHJlLWJ1aWx0DQo+ID4+IHZib290cm9tIGltYWdlczoN
Cj4gPj4+DQo+ID4+PiBnaXQgZm9ybWF0LXBhdGNoIC1vIC4uL3YxLXBhdGNoIEhFQUR+MQ0KPiA+
Pj4NCj4gPj4+IEhvd2V2ZXIsIHdoZW4gSSByYW4gZ2V0X21haW50YWluZXIucGwsIGl0IGNvdWxk
IG5vdCBmaW5kIGFueQ0KPiA+Pj4gbWFpbnRhaW5lcnMgYW5kDQo+ID4+IHByaW50ZWQgdGhlIGZv
bGxvd2luZyBtZXNzYWdlOg0KPiA+Pj4NCj4gPj4+IC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5w
bCAtZg0KPiA+Pj4gLi4vdjEtcGF0Y2gvdjEtMDAwMS1wYy1iaW9zLVVwZGF0ZS12Ym9vdHJvbS1p
bWFnZS10by1jb21taXQtMWM4ZTk1MTANCj4gYi4NCj4gPj4+IHBhdGNoDQo+ID4+PiBnZXRfbWFp
bnRhaW5lci5wbDogTm8gbWFpbnRhaW5lcnMgZm91bmQsIHByaW50aW5nIHJlY2VudCBjb250cmli
dXRvcnMuDQo+ID4+PiBnZXRfbWFpbnRhaW5lci5wbDogRG8gbm90IGJsaW5kbHkgY2M6IHRoZW0g
b24gcGF0Y2hlcyEgIFVzZSBjb21tb24NCj4gc2Vuc2UuDQo+ID4+DQo+ID4+IFdlaXJkLiBNQUlO
VEFJTkVSUyBoYXMgOg0KPiA+Pg0KPiA+PiAgICAgTnV2b3RvbiBOUENNN3h4DQo+ID4+ICAgICAu
Li4NCj4gPj4gICAgIEY6IHBjLWJpb3MvbnBjbTd4eF9ib290cm9tLmJpbg0KPiA+PiAgICAgRjog
cGMtYmlvcy9ucGNtOHh4X2Jvb3Ryb20uYmluDQo+ID4+ICAgICBGOiByb21zL3Zib290cm9tDQo+
ID4+DQo+ID4+IFdlIGRvIGxhY2sgYSBNQUlOVEFJTkVSUyBlbnRyeSBmb3IgQXNwZWVkIDoNCj4g
Pj4NCj4gPj4gICAgIEY6IHBjLWJpb3MvYXN0Mjd4MF9ib290cm9tLmJpbg0KPiA+Pg0KPiA+PiBD
YW4geW91IHBsZWFzZSBzZW5kIGFuIHVwZGF0ZSA/DQo+ID4+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4N
Cj4gPj4gZmF0YWw6DQo+ID4+IC4uL3YxLXBhdGNoL3YxLTAwMDEtcGMtYmlvcy1VcGRhdGUtdmJv
b3Ryb20taW1hZ2UtdG8tY29tbWl0LTFjOGU5NQ0KPiA+PiAxMGIucGF0Y2g6DQo+ID4+ICcuLi92
MS1wYXRjaC92MS0wMDAxLXBjLWJpb3MtVXBkYXRlLXZib290cm9tLWltYWdlLXRvLWNvbW1pdC0x
YzhlOTUxMA0KPiA+PiBiLnANCj4gPj4gYXRjaCcgaXMgb3V0c2lkZSByZXBvc2l0b3J5IGF0DQo+
ID4+ICcvaG9tZS9qYW1pbl9saW4vdXBzdHJlYW0vcWVtdS92Ym9vdHJvbS9xZW11Jw0KPiA+Pj4g
cWVtdS1kZXZlbEBub25nbnUub3JnIChvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSkNCj4g
Pj4+DQo+ID4+PiBBcyBhIHJlc3VsdCwgb25seSB0aGUgbWFpbGluZyBsaXN0IHdhcyBzdWdnZXN0
ZWQ6DQo+ID4+PiBFdmVudHVhbGx5LCBJIHNlbnQgdGhlIHBhdGNoIHVzaW5nIHRoZSBmb2xsb3dp
bmcgY29tbWFuZA0KPiA+Pj4NCj4gPj4+IGdpdCBzZW5kLWVtYWlsIC1jYyBqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20gLWNjDQo+ID4+PiB0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbSAtY2MgLS10byBx
ZW11LWRldmVsQG5vbmdudS5vcmcgLS10bw0KPiA+Pj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
IC0tdG8gY2xnQGthb2Qub3JnIC4uL3YxLXBhdGNoLyoucGF0Y2gNCj4gPj4+IC0tbm8tc210cC1h
dXRoIC0tc210cC1kb21haW49bWFpbC5hc3BlZWR0ZWNoLmNvbQ0KPiA+Pg0KPiA+PiBMb29rcyBj
b3JyZWN0Lg0KPiA+Pg0KPiA+PiBJIGhvcGUgbXkgcHJvdmlkZXIgT1ZIIGlzIG5vdCBzaWxlbnRs
eSBkcm9wcGluZyBlbWFpbCA6LyBUaGUgc2FtZQ0KPiA+PiB0aGluZyBoYXBwZW5lZCB3aXRoIGFu
IGVtYWlsIGZyb20gS2FuZS4gV2FzIGFueSBlbWFpbCByZXR1cm5lZCB0byB5b3UgPw0KPiA+Pg0K
PiA+Pj4gSXQgc2VlbXMgdGhhdCBJIGluY2x1ZGVkIHlvdSBpbiB0aGUgLS10byBsaXN0LiBEbyBJ
IG5lZWQgdG8gcmVzZW5kIHRoZSBwYXRjaD8NCj4gPj4NCj4gPj4gWW91IGRvIG5lZWQgdG8gcmVz
ZW5kIGZvciBhbm90aGVyIHJlYXNvbiA6IHJvbXMvdmJvb3Ryb20gbmVlZHMgYW4NCj4gPj4gdXBk
YXRlIHRvby4NCj4gPj4NCj4gPj4gQWxzbywgZm9yIHVwZGF0ZXMgd2l0aCBsYXJnZSBiaW5hcmll
cywgZm9yIEZXIHVwZGF0ZXMgdHlwaWNhbGx5LCB3ZQ0KPiA+PiBwcmVmZXIgc3Vic3lzdGVtIFBS
cyA6DQo+ID4+DQo+ID4+IFNlZSBhbiBleGFtcGxlIGZvciBhIFNMT0YgdXBkYXRlIGZyb20gVGhv
bWFzIDoNCj4gPj4NCj4gPj4NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI1MTAyNzA3NDQwNC4yNTc1OC0xLXRodXRoQHJlZGhhDQo+ID4+IHQuYw0KPiA+PiBvbS8N
Cj4gPj4NCj4gPj4gU29tZSBkb2NzIGhlcmUgOg0KPiA+Pg0KPiA+Pg0KPiA+PiBodHRwczovL3d3
dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9zdWJtaXR0aW5nLWEtcHVsbC1yZXF1ZXN0Lmh0
bWwNCj4gPj4NCj4gPj4gUGluZyBtZSBpZiB5b3UgbmVlZCBoZWxwIHNldHRpbmcgdXAgeW91ciBl
bnZpcm9ubWVudCwNCj4gPj4NCj4gPg0KPiA+IFRoaXMgaXMgbXkgZmlyc3QgdGltZSBzdWJtaXR0
aW5nIGEgcHVsbCByZXF1ZXN0Lg0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBpcyBh
bnl0aGluZyBpbmNvcnJlY3QuDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNjAxMTYwNzMwMjQuMw0KPiA+IDQ4NTgxMi0xLWphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbS8NCj4gVGhlIHN1YmplY3Qgc2hvdWxkIGJlOg0KPiANCj4gICAg
W1BVTEwgU1VCU1lTVEVNIHZib290cm9tIDAveF0gLi4uDQo+IA0KT2theSwgd2lsbCByZXNlbmQN
Cg0KVGhhbmtzLUphbWluDQoNCj4gSSBkaWRuJ3QgZ2V0IHRoZSBlbWFpbCBhZ2FpbiA6Lw0KDQpJ
dCBpcyB2ZXJ5IHN0cmFuZ2UuIEkgZGlkIG5vdCByZWNlaXZlIHJldHVybiBvciByZWplY3QgaW5m
b3JtYXRpb24gZnJvbSB5b3VyIG1haWwgc2VydmVyLg0KDQo+IA0KPiBDLg0K

