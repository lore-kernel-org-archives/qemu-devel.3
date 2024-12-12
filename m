Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190DAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLj29-00035x-Cj; Thu, 12 Dec 2024 08:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tLj20-00031C-VR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:15:05 -0500
Received: from mail-sg2apc01on2127.outbound.protection.outlook.com
 ([40.107.215.127] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tLj1x-0001Lu-1D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:15:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKi1MqmRDQJoHmONeOiA27Ceag6dYk1o89RHIq95skXXnOoZERWOEj4vbu9bWR0RcvOrS6d7ymc0gaerCw7eIwXruIstd1GBjGOl5j9kvrJvll4LzeWf2g60Dj9Jpj9kJa6eRW4smS3fQ8DaYkHw0RpAQdEUfvnAPdjnwrRkNpSgkdCW81j2VVLhmmhfas7k83gv7n3KLum7b2n4SJENDeu7DTitgbfwbJAih0NcrH+o4D5h6RLfH8aP82Nx17jvcrhLsDqzmPyg3bTSyv8oIidpqfOU7wIVMyEu50M1C+TIn7f5pICXPLkg6xNlkeDVgBhqppqtW3f1NqwnAXycWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYW3gAE+c06O7yLeDn5wwvZNH0D2jfCgINyNU6WRqrM=;
 b=KLrY4JThNfJIsv0bvnvIT3xX3o8nhyGxNDtBmtxKvjuqsMcvhGSEyrj2wtDIMZiEtbB9WttTtKzVFwnr49n6OoX/N5fjUI5KCLMLvrkp7Jm/z+vibFEpgnmaR/IU3iTlCpRweBcCmMfMhgknXWX8cPHytVzRtcvCFdPoTbMrF+FF6cwCDZLFGIriXOgYwNmBpp/0vgYzl1B+4YswgzjLl7pRtWaIgNWLFIEhRqP5AntN+QFLRWcCNz1jUoJP0pD1ADLh6IqCk3XZOT4+cIFHZ85FQ0ifvHdx83izdpbxk6ntcQ0OjQOTMZH+742UrX2PYL17/7mr+qmfbhCiMzUsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYW3gAE+c06O7yLeDn5wwvZNH0D2jfCgINyNU6WRqrM=;
 b=qIeX3RBZKMxhYZRx3FpNF5f/C/CMINN4ysul6jQ4CPOXyVlPnqrCp0jJGnAuaiUXzVPN++w6QTs4uIrtDaZDF1vu0sJn9du4OPRJJS595FMU3uv7xBuT0SBncKy4XrfQvqdnAMXZoCzoox/1aEc1XaHn2Qj4lwohqz17Ug1i/7Os4V8EeC4B1S2E++EJa+tAFbHqFUGintOUN8qOcdqan8RreWL3Glb0UxE3FOPm+z8JLI+hTr0Sc/409+AhZMTDxRlYCanWWZbmkKe+oY57kZRlaF1AS00sTKLT77oqurU6d0WH3flKBuF2GPUVxS6z0VzTgNm5clkCWYLwWC+NZw==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYZPR06MB5225.apcprd06.prod.outlook.com (2603:1096:400:1fa::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.7; Thu, 12 Dec
 2024 13:09:50 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 13:09:50 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Angus
 Chen <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH v2] hw/virtio: Fix check available index on virtio loading
Thread-Topic: [PATCH v2] hw/virtio: Fix check available index on virtio loading
Thread-Index: AQHbS8j+0VtDyUqQlk6TIf56vZEBXLLg/YUAgADld+CAAFWpAIAAXbJg
Date: Thu, 12 Dec 2024 13:09:50 +0000
Message-ID: <PUZPR06MB4713FDC92A0A8C505B73C109A23F2@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20241211123349.904-1-Wafer@jaguarmicro.com>
 <CAJaqyWcU8fN1ewYyZ1qDSdxWmr7SVbw8s+VKzO4_b63F8MS=Rg@mail.gmail.com>
 <PUZPR06MB47130AC6F169C17D9B833B74A23F2@PUZPR06MB4713.apcprd06.prod.outlook.com>
 <CAJaqyWecTOOrdZ8_XOj2ztx4mCKnx1Hmj_P-tKbVn-939Wyaqw@mail.gmail.com>
In-Reply-To: <CAJaqyWecTOOrdZ8_XOj2ztx4mCKnx1Hmj_P-tKbVn-939Wyaqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|TYZPR06MB5225:EE_
x-ms-office365-filtering-correlation-id: 3540b2d8-f29d-4c1d-22a3-08dd1aae42df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkRvMUlEMGZmdVZwOFo5dzdMcUJMMVUzWlVaSk8yU2p6TjlPdFZUb1NxK0Fm?=
 =?utf-8?B?d1JNckowKzU2R2xSTkFQQUNNa3BxRVBPMmx5aS9pWHc2cnJIcDFabms5c1Vj?=
 =?utf-8?B?eFdlYWZyWFlQZjBOYTBvYjV3SGVVU2p0cHdxQ1V0STY4Umx6dm10bjlnS2h2?=
 =?utf-8?B?Qkx0NGkvbzRkemIreU4yUmIrMEJ2TWVLVk04M0hFOHRMU2VnTUZ0S0pNMHFV?=
 =?utf-8?B?cGVMa2ZvUVVGc0oySGN4T1dtVUh0anZLc0dHY3VjczBQU1hrQk9iT0pEZDhZ?=
 =?utf-8?B?WWV3MU5NYXJiZ3N0ZDMvQUk4UlQ4Ni9PMjhCdDhhUFlOTXF0UWNRRk1aYmRl?=
 =?utf-8?B?U052R2tWNU1xZ3JGb1JOdW1sVU9DZ0dEVGltRnZEL1pMYnZMaGc3MU5IaGlE?=
 =?utf-8?B?MTFZSnVlT2Q4OVcxS2VjMXhhWHVXMFZjSGo3bHphOGhhZWovM0pWZnF0bUJy?=
 =?utf-8?B?V2haR0dXWVN5bVlvdHJNK2FCOENpYlJCRXVXdHFHR29yNmZoUmdKTEtoZVd5?=
 =?utf-8?B?Y1pabEFYdk9jK3BqdU00TVROclNxYTJQWXFJT0M5Z1kvVnRDUmp6a2dBdmFO?=
 =?utf-8?B?a04yUHBtK0xPVFFxSEgwV3oxWG9USlluNVViMG1oSVlNZTR5S3ZoVmNFbVFK?=
 =?utf-8?B?ZFovL1BRRUplR1VaTUVCMWZuc0luMWJKMHB3NHk5cU9kdVdGLzdBSGI2MFk0?=
 =?utf-8?B?ekFqWmFpdzdYRktaUUU5YUo2cm1adjNQc1g4ZnRuUUZqWE1xSjRXOVhXU2Mz?=
 =?utf-8?B?cVF0S0NSRE44cUNHcXE2am1aZ1BIbFVlQ1owR01VZ0pKYW9GQTVQSTlVR2ow?=
 =?utf-8?B?MkYza1VUTmNTbThXQ21vNmVzekxSdUNxejRsbFZqTUd2WjkzcjQwc0hGK0wr?=
 =?utf-8?B?c09ud0JQdjRtVmRYc1l4anJvNndzcXFERHhIdFl4Q0U4dkNRajVVL1pEWE8w?=
 =?utf-8?B?U0FBMVErSm5VS05tR3drVWhSNm0zNFFZbWR1OVNNRklJK1hlZzRYK0d6T3cx?=
 =?utf-8?B?YVAwWWU3dy9DeERCb2xSOFE4WFNSZ092WWluc2tQWnhSTGdYbzRCZWdMWUt3?=
 =?utf-8?B?Qng0dmpRdUNjMlMxbG8xeHRsREsvUU5EWXdxN1FQZHVrQjJOa2Y3SHBXVXl6?=
 =?utf-8?B?d2xNejhyVW1TcU8yanBwRERNdkdpSWFLajJzRUU5dEd4MUJKaHJwRlNPeUxU?=
 =?utf-8?B?QzRteG1wYW5qczlTVzNmNUlFNzMwTERDWlZhak9hdnpwU1RSeG9VUmo3RGtv?=
 =?utf-8?B?MWRjcXBVbCtlNEJOMURDenBoZ2VhbXp3WFR6MUQyOUtCT3lxOVdCNVByUmtN?=
 =?utf-8?B?Q1RTTEJ5dmhNOGV4U0NVT0ZIUFVEVzRLYkhhelYrZUJIckUzZGhiNUw3Zmoy?=
 =?utf-8?B?SDVndW5oMFlWL3dJc1NBK1pPc0NLL2JzSGNxSlNnZ0Q0YzlPUUVvc0VTRVZ4?=
 =?utf-8?B?VmNqSGlLS3ZHeFlXZFFNSHlzeDJGOGl0c0ZBZHlPSUFNLzRRVms3a2FrYWZ6?=
 =?utf-8?B?VW5mQWM4TXZkTmFkMVpVZC9za2tkS3c4d000Q2FBZU1NMC9pbHlJdHdCQ09U?=
 =?utf-8?B?WWFSa1lUdXZwSjlpamZlNjhqTStuRURwRmE5OUZmcTdCeXZkdk13c2tKdXFM?=
 =?utf-8?B?VTBkWmNwY0RaS0tVY1Zld2xaSFN3bGdnR29icWVkUlN3eFZ4enkyRUlSTnFZ?=
 =?utf-8?B?bnNLQ1hDTnEvVlg5Mm9zaktmTUNGVzc3eFl0ZU5ZN0tpWUlsUWE3U2tnU3ZE?=
 =?utf-8?B?d1dOaWtaMnJHRm53aTNSTkx0THRYSnVVSmtXUkhVTWc4NmRkRUpIdFJHSllj?=
 =?utf-8?B?MGIwaDZQV3VYaWt5bnpVeXV6TjQzZW5uSTZMM05DTHN1YlRkWmFLazZ6Syta?=
 =?utf-8?B?ODBCTXJIOUQ0bXQ2dHN5MUw5cEg0TGwwTVIwVWVGcFdhZWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFZaNVZIUFlBWEtqU3BGY0xTSnZXVzU5ckhqY2hvVlhqYXNIV2k5UEZuaW9P?=
 =?utf-8?B?bkVUZ3hEdDkwcUMwSTBSa2c4WDBjR2NSVjAxazF6VUN5N1B0M2NBVG5wTS82?=
 =?utf-8?B?bENBb2pSYVRNMTFuZ3VUUTMyZkpHSmRKbjJDWUhoVTVaeWFqeU91NGI2WGNY?=
 =?utf-8?B?N1lCblRKSERVbTFMelNCeGNLMFcxeVNSem5qbkRVOENqd0dQd3dzZEEvelZ3?=
 =?utf-8?B?aSthc01wdjIweE9nVWd2cUhCY3lTTkV1WDhIdGFXbHFsdnM4UWl5WGlRYnFK?=
 =?utf-8?B?UEFuaEtwcWNKYmNET3NwcVFmUHdPdXNVWVZWaG5rTVM1VGlDRTBPUnBMVlBJ?=
 =?utf-8?B?a0pWMEdyRWoxZ0o1Ti8weFFwL0NMUTZJV0RCNk9QenI3K1dYcVVBT0tIMkNL?=
 =?utf-8?B?Mk5GemI3bUp1TlpMUG5yQVlZbkF2RzdwZTNRUThZdWNBaWY2R3dIZXhNZ2JS?=
 =?utf-8?B?dEFVVEFHSXMvaUtWNGVnQmFRc1MvM2JLMEFUQjlxRDNCZ3FtcDFLeVVITU0y?=
 =?utf-8?B?TnJHVURXRmsrT1ErWVgxSkc3WXFUek1kK3BWUUo3ZWdkVHZ0MzRkOVpWeHBU?=
 =?utf-8?B?WUV1TGNCM1JaZHp1QTIzRGtzNlNJM3JCWk1vdHE1ZW1ZZ3A1bE1IbEtHb2h0?=
 =?utf-8?B?MjNYQVhnenlHcitFV1dxa0huTUFwb0o2dFAxZ2pzM1pENFI2dWg3aHQxRFM5?=
 =?utf-8?B?TG9DOFBOVGhSajdkNW9ST0VoZHE1N0tMeVA2WFNxRmsvaHo1OHZvNXZqUS9t?=
 =?utf-8?B?N3NrMzNGMitMQ3EweTl2Y0lzV2JVSmRHaWtReGZuV08xTFpLVk9XNnRRNEtK?=
 =?utf-8?B?QmVTMnBUSHBlNk5UVnNjZ3NJQm53RVJKNFpkSkFXYWdHK2xIMWV4d1dTdllX?=
 =?utf-8?B?WWdYK0MwTWpVSWtjTHlzdkR5eUhQNUFqcHlvcTA1OUZEcmxxOVZmOGFmeUZj?=
 =?utf-8?B?azdHdVkrYkdyclp5Q3ladk5kSFRWMjRpYUlhdnhyMyszMlBQd0pBQmhXdFcr?=
 =?utf-8?B?REUxYzVaNEI2bWZsalRNc2JFV2diL1BjOUxPYTFPTkQzQi9nUTAwSEpBcWdw?=
 =?utf-8?B?dnNWNHJUTDdIWkpZK2dDbHZMVUgwNHBEV0kvb1Ezd0kvOUd5dTJYVk1tSzAv?=
 =?utf-8?B?bU4xbnp1WW5ySnljaEFXcjZ0QzhBaEVkQkExWnpKSUQxUHlHbDJia0g2enlS?=
 =?utf-8?B?bWZHQ1FNNW5WdFUrVEYrM2NVR1k1OHhudURHZG1KSmZYRmYzNWIzSmNaZVNV?=
 =?utf-8?B?WnhNandsY2d5ejN6SlhRY3pGWGp2eTdyNVA0RGZmUTIxT2kzNlYyZzVZWitY?=
 =?utf-8?B?MVk5N1gxS2MrTldtUDIzbVBXRElxN1N2OExUcXhJNnd1MkJGYkgrZk9qMGpY?=
 =?utf-8?B?WDR5Y3E3UmxSTS9JU0FrSXdJM1FRMVlGTHhQQllyYjM3Y0ViRi9rNTRxQU9S?=
 =?utf-8?B?dWNMMFQ4emxHRlcxMjJScDM0QnV1R3l4cTNrbGpEbWpXNGJqWnZ1VE1yVWo0?=
 =?utf-8?B?cEdGYjhIMTIzK1lyWGxxZWpMZVhoS1BVUlVFQmIzSTFxVThhakNvVVIzSzc5?=
 =?utf-8?B?TWpQRDVFekl6WThxS0VxZnlYV1hHKzNXVzZTQ0dCZGRGR1hpM1pwRmRqelVR?=
 =?utf-8?B?dERLVDN6cHhiNEVIWloxTE5OZmdKdnIxYytiTmtZS2xqVzk1bGozUThNdHVG?=
 =?utf-8?B?QkNHeXN2aEZtdENWTHp3a1BVUG1QY2licklDRmRUM0FNclE5REt5QkpuOTRU?=
 =?utf-8?B?L04xNzVFQ0krQnZuYkxzazBhYi9BcFlZR284S1pQT1BjZ282V2JwNnJwSkFQ?=
 =?utf-8?B?ZkJtWlk2Q28xTXM2bmQydXhHM2ZVZTUvRS94bGFWODgvSUQ2V2kwVkRodVph?=
 =?utf-8?B?RCtUN056V2o1ZG05bXhFclZRZkdnWjlwUThzQ1U1NnVORDVwWlRlenZoaFNj?=
 =?utf-8?B?MGFLZGtFcEN4TVR6aVI4UEp1amR0eUpmRXliSXU3ZlhvZVZ2cCtDRm4xbEs1?=
 =?utf-8?B?MlZpVXMzd0xoeThYb3JRUUpsb0lMUXkxcm01L3QvQzEva2dvc3JLbi9aVjFH?=
 =?utf-8?B?ZnltZGQ0RE5vT3h2azFCdW1ESEpwTFpLZU1xM2pPenVrcmIwYnFsa2x2bE15?=
 =?utf-8?Q?R6Q+nlRzPDxn2wO5c3NmZdFuT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3540b2d8-f29d-4c1d-22a3-08dd1aae42df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 13:09:50.4638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QftvWXp3BPenM+56Ivh47yGpw0OytixqwMusIiB550VTTrXSXSXrQ6JjX/2nmwdmgpFIxT/GZxiNFXFgSCVAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5225
Received-SPF: pass client-ip=40.107.215.127;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXVnZW5pbyBQZXJleiBN
YXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwMjTlubQxMuaciDEy5pelIDE1
OjMzDQo+IFRvOiBXYWZlciA8d2FmZXJAamFndWFybWljcm8uY29tPg0KPiBDYzogbXN0QHJlZGhh
dC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gQW5n
dXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGh3L3ZpcnRpbzogRml4IGNoZWNrIGF2YWlsYWJsZSBpbmRleCBvbiB2aXJ0aW8gbG9h
ZGluZw0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VU
U0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0
YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25p
emUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9u
IFRodSwgRGVjIDEyLCAyMDI0IGF0IDM6MzDigK9BTSBXYWZlciA8d2FmZXJAamFndWFybWljcm8u
Y29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBFdWdlbmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4NCj4gPiA+IFNlbnQ6IDIwMjTlubQxMuaciDEx5pelIDIwOjQ1DQo+ID4gPiBUbzogV2FmZXIg
PHdhZmVyQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENjOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dh
bmdAcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiA+ID4gQW5ndXMgQ2hlbiA8
YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBody92aXJ0aW86IEZpeCBjaGVjayBhdmFpbGFibGUgaW5kZXggb24NCj4gPiA+IHZpcnRpbyBs
b2FkaW5nDQo+ID4gPg0KPiA+ID4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiA+ID4gRG8gbm90IGNsaWNrIGxp
bmtzLCBvcGVuIGF0dGFjaG1lbnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9uDQo+ID4gPiB1
bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRGVjIDExLCAyMDI0IGF0IDE6MzTigK9Q
TSBXYWZlciA8V2FmZXJAamFndWFybWljcm8uY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4gRnJvbTogV2FmZXIgWGllIDx3YWZlckBqYWd1YXJtaWNyby5jb20+DQo+ID4gPiA+DQo+ID4g
PiA+IFRoZSB2aXJ0aW8tMS4yIHNwZWNpZmljYXRpb24gd3JpdGVzOg0KPiA+ID4gPg0KPiA+ID4g
PiAyLjcuNiBUaGUgVmlydHF1ZXVlIEF2YWlsYWJsZSBSaW5nOg0KPiA+ID4gPiAiaWR4IGZpZWxk
IGluZGljYXRlcyB3aGVyZSB0aGUgZHJpdmVyIHdvdWxkIHB1dCB0aGUgbmV4dA0KPiA+ID4gPiBk
ZXNjcmlwdG9yIGVudHJ5IGluIHRoZSByaW5nIChtb2R1bG8gdGhlIHF1ZXVlIHNpemUpLiBUaGlz
IHN0YXJ0cyBhdCAwLA0KPiBhbmQgaW5jcmVhc2VzIg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgaWR4
IHdpbGwgaW5jcmVhc2UgZnJvbSAwIHRvIDB4RkZGRiBhbmQgcmVwZWF0LCBTbyBpZHggbWF5IGJl
DQo+ID4gPiA+IGxlc3MgdGhhbiBsYXN0X2F2YWlsX2lkeC4NCj4gPiA+ID4NCj4gPiA+DQo+ID4g
PiBJIGRvbid0IGdldCB0aGlzIGNoYW5nZS4gSWYgdGhhdCBoYXBwZW5zIHRoZSBkcml2ZXIgd2Vu
dCBidWdneSBvcg0KPiA+ID4gbWFsaWNpb3VzIGFuZCB0aGUgbmV4dCBjaGVjayBuaGVhZHMgPiB2
cmluZy5udW0gc2hvdWxkIG1hcmsgdGhlIHZxIGFzDQo+IGJ1Z2d5LCBpc24ndCBpdD8NCj4gPiA+
DQo+ID4NCj4gPiBEdXJpbmcgdGhlIG1pZ3JhdGlvbiBwcm9jZXNzLCBsZXQncyBhc3N1bWUgYSBz
Y2VuYXJpbyB3aGVyZToNCj4gPiBUaGUgZGVwdGggb2YgdGhlIGF2YWlsIHJpbmcgaXMgMHgxMDAw
MCwgbGFzdF9hdmFpbF9pbmRleCBpcyAweEZGRjAsIGFuZCBhdmFpbC0NCj4gPmlkeCBpcyAweEZG
RkZGLg0KPiA+IEF0IHRoaXMgcG9pbnQsIHRoZSBndWVzdCBWTSBkcml2ZXIgc2VuZHMgYSB2aXJ0
aW8gZGF0YSBwYWNrZXQsIGFuZCBhdmFpbC0+aWR4DQo+IGlzIHVwZGF0ZWQgdG8gMHgwLg0KPiA+
IFRoZSBtaWdyYXRpb24gb2NjdXJzLCBhbmQgbGFzdF9hdmFpbF9pbmRleCBpcyBzZW50IHRvIHRo
ZSB0YXJnZXQgUUVNVS4NCj4gPiBEdXJpbmcgdGhlIGxvYWRpbmcgcHJvY2VzcyBvZiB0aGUgdGFy
Z2V0IFFFTVUsIGl0IHdpbGwgY2hlY2sgYm90aA0KPiBsYXN0X2F2YWlsX2luZGV4IGFuZCBhdmFp
bC0+aWR4Lg0KPiA+IEluIHRoaXMgY2FzZSwgbGFzdF9hdmFpbF9pbmRleCBpcyBncmVhdGVyIHRo
YW4gYXZhaWwtPmlkeC4NCj4gPg0KPiANCj4gQnV0ICh1aW50MTZfdCkweDAgLSAodWludDE2X3Qp
MHhGRkYwIGlzIHdlbGwgZGVmaW5lZCB0byAweDEwLiBTbyBuaGVhZHMgdmFsdWUNCj4gaXMgY29y
cmVjdCwgaXNuJ3QgaXQ/DQo+IA0KDQpUaGFua3MsIHUgYXJlIHJpZ2h0Lg0KDQo+ID4gPiA+IEZp
eGVzOiAyNThkYzdjOTZiICgidmlydGlvOiBzYW5pdHktY2hlY2sgYXZhaWxhYmxlIGluZGV4IikN
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogV2FmZXIgWGllIDx3YWZlckBqYWd1YXJt
aWNyby5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IC0tDQo+ID4gPiA+IENoYW5nZXMgaW4gdjI6DQo+
ID4gPiA+ICAtTW9kaWZ5IHRoZSBjb21taXQgaWQgb2YgdGhlIGZpeC4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+ICBody92aXJ0aW8vdmlydGlvLmMgfCA4ICsrKysrKystDQo+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLmMgYi9ody92aXJ0aW8vdmlydGlvLmMgaW5k
ZXgNCj4gPiA+ID4gYTI2ZjE4OTA4ZS4uYWU3ZDQwNzExMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
aHcvdmlydGlvL3ZpcnRpby5jDQo+ID4gPiA+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8uYw0KPiA+
ID4gPiBAQCAtMzM2Miw3ICszMzYyLDEzIEBAIHZpcnRpb19sb2FkKFZpcnRJT0RldmljZSAqdmRl
diwgUUVNVUZpbGUNCj4gPiA+ID4gKmYsIGludA0KPiA+ID4gdmVyc2lvbl9pZCkNCj4gPiA+ID4g
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ID4gICAgICAgICAgICAgIH0NCj4gPiA+
ID4NCj4gPiA+ID4gLSAgICAgICAgICAgIG5oZWFkcyA9IHZyaW5nX2F2YWlsX2lkeCgmdmRldi0+
dnFbaV0pIC0gdmRldi0NCj4gPnZxW2ldLmxhc3RfYXZhaWxfaWR4Ow0KPiA+ID4gPiArICAgICAg
ICAgICAgaWYgKHZyaW5nX2F2YWlsX2lkeCgmdmRldi0+dnFbaV0pID49IHZkZXYtPnZxW2ldLmxh
c3RfYXZhaWxfaWR4KSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgbmhlYWRzID0gdnJpbmdf
YXZhaWxfaWR4KCZ2ZGV2LT52cVtpXSkgLQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgIHZkZXYtPnZxW2ldLmxhc3RfYXZhaWxfaWR4Ow0KPiA+ID4gPiArICAgICAgICAgICAgfSBl
bHNlIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICBuaGVhZHMgPSBVSU5UMTZfTUFYIC0gdmRl
di0+dnFbaV0ubGFzdF9hdmFpbF9pZHggKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgIHZyaW5nX2F2YWlsX2lkeCgmdmRldi0+dnFbaV0pICsgMTsNCj4gPiA+ID4gKyAgICAgICAg
ICAgIH0NCj4gPiA+ID4gICAgICAgICAgICAgIC8qIENoZWNrIGl0IGlzbid0IGRvaW5nIHN0cmFu
Z2UgdGhpbmdzIHdpdGggZGVzY3JpcHRvciBudW1iZXJzLiAqLw0KPiA+ID4gPiAgICAgICAgICAg
ICAgaWYgKG5oZWFkcyA+IHZkZXYtPnZxW2ldLnZyaW5nLm51bSkgew0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgIHZpcnRpb19lcnJvcih2ZGV2LCAiVlEgJWQgc2l6ZSAweCV4IEd1ZXN0IGluZGV4
IDB4JXggIg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjI3LjANCj4gPiA+ID4NCj4gPg0KDQo=

