Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C319DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNE-0003cv-8v; Thu, 02 May 2024 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YND-0003cA-Cn
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:27 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNA-0005yz-B6
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663764; x=1746199764;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mkr4mAHYujE/VwywrBm3WrIt+MSQrhOwUyjOaK0g24I=;
 b=vVU5wqjE/kA+b0w+GLGx2rmnLRgWsyjkq89sUazkZyDXbTlDsB+i2/cY
 XGulaXlI1JGiqbAyUh9UMEIV3RqKVQX0bhNGIi0XOmEU0r/NIzsWdOKsw
 HdJkWmqY2ZXe31bFGFsgOJDrMA+6QrZthul1NQtsGoZVczoHQHCsqyngk
 2D4aWFAkqqRI6iCEPV8A1X5YVtiokYhYqT8Kk/Z/qQ1EvpRgBc8wSe+95
 xGXVpgJXU8oo5D0JoPCbraUJezv3S7hAZjdQJYDu01C6s+2+2w5cjJZls
 Tsw2V+lKy03g0cLJprxT+imucr3bG/teulHoDBP5YyyuFZ9nywAKN6ZIu w==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730664"
X-MGA-submission: =?us-ascii?q?MDGmGmUp/L1b7zUqzQsNQsjhFjIy7Q13EyTvgU?=
 =?us-ascii?q?CBKvNiVBUjvSiNo1OYm0OAgydn8LGXh4aww3v3TYaWQUelt+2O7vgq92?=
 =?us-ascii?q?Xhy2QCC3LJytPREwhksmVzp2JxbWQ6/gI405Jyh3D4UWVQ3JC/nhSGoc?=
 =?us-ascii?q?IasmGlu6jD2oxuwWXOoNf1fQ=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux7jYakCEKLmjBecYrf88QrLFXGHSFtu/VCtZPOJSt/tc9P3qP1nNyg55/tf8LGGmW0G1tR+TFucO5xxa7pimLHLHviYN1vagRAz173Dl9oCaEsuZPNK+OFWCEBJckyVTHdUxcUFrqOWUIO5v6LC6Tg2/DC3tGLAu44KMLPn3atv49p+bph6EUadANWnhjS/WJ38oWYDoX0BYzlbA3ZqCT5gY4ITp8NOA7DuIT1vgWhxsVjukNq/wwOVYCJtZsi9X/b0oLcwgdRHPSmgRxA29Mj/4SPn3V+1Gl8qKclJNEYUbf2FAub/ryUijx1ouPxoz7vLkCIqofPv235HERTC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkr4mAHYujE/VwywrBm3WrIt+MSQrhOwUyjOaK0g24I=;
 b=ccR8W/5lz6fGrksP/zR2sayf5E8A6a27FCLy8itYfFcMtQPVQjaiedMwAJC6WPcpckvHUYXg7SAXrCwbywCGspuKB/JvsK98V4wHfQgnasGkA56prSL5fB5LQqBdJbr9bShRBqfRvq//9Y+8K5SvIIun+2meWEuHz9+FMRstnjUIMksPqIopA65bGoURYxgeAaSWpckBJZf58JjLl4pcKLeThQSGQwe5KU5wC4p7rLuxk780kvG/0gcQX/6oBYo+xPHyCpZ3aV08z5r8zp+aCHyt3w/Dvw6uniG3ew1wnCmS9lkAMGx8j80sWApBGBAz17tHx5RyFHZVpehZviM9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 15/24] pci: add a pci-level initialization function
 for iommu notifiers
Thread-Topic: [PATCH ats_vtd v1 15/24] pci: add a pci-level initialization
 function for iommu notifiers
Thread-Index: AQHanKWAjSp/SteTZkWYOxoa9suFmw==
Date: Thu, 2 May 2024 15:29:20 +0000
Message-ID: <20240502152810.187492-16-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: f9ca77ec-438d-4017-67f0-08dc6abca307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cndlK1Q1S2JXOENEbG4xNWN0K2hxYzZzbmZsVlloSGNNejBtakdaZzhHdUd4?=
 =?utf-8?B?SmdSTXZVd0lsaWU3SlRFK3FPWEJJc0RnMm5ZTnB4MGYreFpLUXFhN3FQT0pQ?=
 =?utf-8?B?S21rdGtJbkhqMHovTGFPeGkzay81aWZnSU1PMDJqZ29sS1A5b1cxWGRtWjll?=
 =?utf-8?B?cVk4YkdhNi9vaDNwclJ0UnNmbUlOclBaWUFCa0lPQ0gzbjk5NFFBQjhaOWVR?=
 =?utf-8?B?bG8xc0ZmUFdlV3dmL0RhVmpyK0ZqMWMzcktDNlZneEd6RFo4OXhLNmdoYmV5?=
 =?utf-8?B?RHZXRkJpWUpJZVF6bGVKUkVRMnBHQS9zL1FzMFV1QTB3VnBaL0FDZWcvY0Zr?=
 =?utf-8?B?V25uSlJXdFl3MUhRTzRLMEdCZmlBM1F2cjZac2ZYcjFIb2JGLzdLMyswVXlx?=
 =?utf-8?B?dXNpVld6WktIN2RmbWkvdXNQOXFYbnhkelI4UUltTXc5TXJJeW9hR0FTRGhN?=
 =?utf-8?B?RWE0eUliY2o2YjNDTy96N2prenlMYUVEckZTVXVITTd4STdDOW1NbWUxSjND?=
 =?utf-8?B?TGdnT3IrVXA2Y1g0YXRVOVlxZXJwaHZ4RThBVndCRk80K294Q1ZFSWVDbEF1?=
 =?utf-8?B?T0lBVE1tQ1R0QlowV0FKdFBpNGM2L3N2NllVVExGc0NXSDhhaC9TVkxTQ2Iv?=
 =?utf-8?B?bU5ldVA0OHdTa3ovb3NmWmJmbXgwVUU2NzN1eDR1WndTekRqTk93OXJOeXFP?=
 =?utf-8?B?TFBRYkhNaHgwY0REelEzY0x6NTN0azBQS1VKcEcxYVIveVVqQ0Z6MlhxWDVV?=
 =?utf-8?B?RnNucDZyZEljMEdib21UWmFocjhjRUJXODJwMmFWR0JrVG5MZ2dNdUFFcEpN?=
 =?utf-8?B?MUExMU90YUpJSGl0YmNUalAwUy96QVRvcytKOUpMVm81QWpESlRDanZ5ay9i?=
 =?utf-8?B?Y2d0dk1Cb2RQVU9BSW9nTzRSUC9FTEUxMHZaK2t4L0F2RlNwbFg4RkdPbmVX?=
 =?utf-8?B?WHBGd2NYd0ZPemY5VjM4QThOcDljdDVLRTlvbzlkbEluazRYWnVOZ3F1Mnc5?=
 =?utf-8?B?ZE10YVNPZ2ozZmxLd2orc1pNek03L29XTnNGS25mWkJMWUFuQVJ1bHdsZjNi?=
 =?utf-8?B?TkVqQWNoZFhaNlg1bWlhMzc0NDJhcGd4aUNBWXUyRS9rSEJOZGxESWgzT3BF?=
 =?utf-8?B?SGRUd3JRdmFmOE9oWHZDU0JZYytHTVNZeVV5eE1SUzRPTlNEU1ZOR2Eya2Vm?=
 =?utf-8?B?anRJUkpyMDZBRTd3NFhzZFJqdWF2M29VQTZvd1ZzVmRJUzY3M0gzcWhDbTY4?=
 =?utf-8?B?Tzk2a2Y0K0xNTVhwMnpQZkp1d2s4c2ZxMGdkTS9CdjdnYUhHZjNoakxldDlj?=
 =?utf-8?B?WGRQU29JMENKUDNTY1JreVpxODE2WmlLejRDK3pUUnMzcEZ1MmpUeWtKTGJu?=
 =?utf-8?B?bjdFcm4xVlhIMXpRS2draDBnTlJReXhGUlJBdEdyS3BwV2QxRHZPUkVQcTVk?=
 =?utf-8?B?Vlc4RGNMQ2J6VW1PcG5YMk5sWG01RVJTT1c2UTV5Ky9tSSs1R2tjTUZ4REZm?=
 =?utf-8?B?cHdFV1JTd1p2KzRHcDV0dWJnRXEzSXhKbm9KeWRvSWtQUlRSVnVwNHUrdFNJ?=
 =?utf-8?B?RUc0WDVsbEFvZDM1YzRjVVFyZkdWNmhKa2JZcW43UnVPajA0eGN4SS9hZ09I?=
 =?utf-8?B?TmJnaUc0b3o3K1gzWC9IU2RKSjlhdDlNNWVTRGt6MmswYmNBU1AwclZIbVlz?=
 =?utf-8?B?QWo4bHgzNGkzNkJkbGF0QVhheFZtOVh3N0NRek1rY0ZMblJUQkY0Vi9CMFBY?=
 =?utf-8?B?SmNPODR1TnZrQm5NQWkwcDQwS3cvaGQ0T1BBQ21OMnFvN2NrWXE0YWd3TmRm?=
 =?utf-8?B?SVFRc2MvSXBEOGpXL1dIZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHM1eTNZbXc4NTJMNTMwSVVLVXgyVDUxVGcwNVRnaGNFRWJLUS8xQlF5T2Nz?=
 =?utf-8?B?bDNUYjRnd1YrQ2pDMml3UzAzM2RURlEvZlBEY2dCTytwWDNhTzR5UW43QmRS?=
 =?utf-8?B?QXFER2JiU2pVaDAydGtwdzNHS3JXb29mOGVwNGQ2RnNIQlNIdUVBZ0xwQnkv?=
 =?utf-8?B?UW9JbkxFVmtsc0dtRTZib1JJWGVDVlNKa2llYXZCdDBqejI3d0Z2MDd1Z0Fi?=
 =?utf-8?B?SUUrQlJqbHZON05BZEVPV2VlQ1l3VmIrS3B6ZVpDRGtCTlRMT1UwS0g2MGNP?=
 =?utf-8?B?RUo3WTVmVkRyY3FnZmE5Q3pvVHcxY2I5dGtlSGxIT2Q0NGovMjltdGRFSmJI?=
 =?utf-8?B?Z3ZqTEdPS2JKMmtWUm1EQm90RkxWeTk5MVBCQ00wZXpHSk14TjdzMEZFZW90?=
 =?utf-8?B?L1orckhlbzVKVkU2VC9PMHFJNzc0Sm5McnJ0TTJUNVl6M1VzVVZucFc2Y3d1?=
 =?utf-8?B?d0NlQ2JBQVM4Znc5ZW0wTmIvTFYzMUdUdDFxaExDM2lLeHhTTXRxUXIwMkFE?=
 =?utf-8?B?VHQvY2ZQc3JKWXhYSDNxVzAxS1h6ZzByR09FZW9jN0MwQUxadWtFc0NWaHZL?=
 =?utf-8?B?ZWVxSzh3Zm1tUFRrdjZhUGxDdENaRnFYV3lPV2NvMlRWSTRNOWc5V2RRKzhr?=
 =?utf-8?B?MXNhZVFEZXZ5YXlSSGpqUzBuazlMbTRkbzRKNzVQOVV2a01PM2Rndlc0bmdn?=
 =?utf-8?B?VG9rUlpvTnduN0FkSktsZGZQZ1pIUWlZRGxqVlVaS0VQYmZQVHp0ekt5RVFw?=
 =?utf-8?B?WEh6STkxRVNGaThvcmZ2VHVPVnpJY1RvQWRzQkpiNzlQa2FKK0tDd1JvRVRu?=
 =?utf-8?B?dFhYRnhmWkhqaG40dTFYWnJvMXg1bVRlendzS1R3NUprUTBFVGdCbFljb21r?=
 =?utf-8?B?eEhZajFiazkxTUE2T2ZKTHY5bWpESy9CSHFwU3hFUEF0U0FoMEI3WjZ6b3Nv?=
 =?utf-8?B?aThMV0d2aTNRV1kzVWpNcUp1ano0UmVmKzJ2Z3FsTS9xSG1ObUtXb1J1K1cy?=
 =?utf-8?B?ellxWTduUHFUZlY2YUl5eGZyYzVaTDBvcTlRTTJua0RtcUV3b3drWmc4V1lz?=
 =?utf-8?B?L2hGNE91czNoODVIQVJISWVNd05keG42SlV3RjRhZmE1NGE2QTJhQitjcDVp?=
 =?utf-8?B?QmlqeGRjOHYzTHA5VGNqNnRqYllINElWWjlJREtZWHNId291ZXdBc0J1VmY5?=
 =?utf-8?B?aGJ3TXlsR3Z2SHZ0VjBPdEZPaURYSzFEN3FiRnIvaDZ0SnFkQlo1ZmJJSyt4?=
 =?utf-8?B?TlQ4aXR2Z0I5QW1kSUVZWTl5K2Q3dXBwWEoyaGtCMFdCeHBqWGxZNnFyRTFI?=
 =?utf-8?B?OWQzTTZCTW4wZ21HS2tNWU5oMXFrVUdmWTJldjJkWW9vMm05SjFUdjlzTk1R?=
 =?utf-8?B?RkZKYmYySTFyMmtndExkd2ppcGt5Q1pZdVpVSEZMSHloa3J1NU5oK0htVThU?=
 =?utf-8?B?c3BybVgyVWVxalFrQnp3M28vV21GbWs2ak5IMGhzakx0SWdMcmc3cFd3VTlP?=
 =?utf-8?B?cjUySXhUVGlyM0QxTnp2blZvUWxaN05LWldQYTNPRjQyTTVtVmRFc0RFZFcz?=
 =?utf-8?B?N1pXZFhDRmNtU2pMelhpWkU1czVVMFoyaWRpR1dSSjZvNG9XUzdyd280T3l2?=
 =?utf-8?B?ejhRYkZlRDRwZmtIWmZWcllEcW1XRDI2dUdvS2h0dE8rdURUYmF6M2ZBV1pN?=
 =?utf-8?B?ZWU1TWdnTFdieEpBRks2QlR5VzlJMCs2MjdwZGNOT2diRjI0d3FTSXRsaE5i?=
 =?utf-8?B?UTFNZVR5MFZvcGxCZWt0MTBzaVdVRXIrZUFPUW5SQWxndXNCV3RpSExISzV3?=
 =?utf-8?B?VHFyVnl3ZTU5bmFMUDBDR091eWZ2S241LzNFUklVcXBRVmN6ZXQwbWljQ2ND?=
 =?utf-8?B?bVZWTUVRV1dYUW1takpMbDBpMU1ZaU53RTJTdUI2OURyQjRac3NxTGpJbnl3?=
 =?utf-8?B?MDljU1dOK0lMc1hLLzV5VnZxZzBsZy8xNWxSSE1ZZzhSOFlWZmQ4NVVSZDd4?=
 =?utf-8?B?a0I2UUxvUkxEN2JmYjhMcW9RME8xYXVZQkI5OEkzNjI3TkFuTVUxWWNQTjg4?=
 =?utf-8?B?cFYzU2N3UURsME1mRm9DT3NVUXFOZ3FBNFpHVHZFT2Raam9LUHRqcU9DdVJy?=
 =?utf-8?B?Zi9UZmVGd0FrQyt6MXp2ckhId2lJNTQ1Z1AzZTVCU3ZvN1JLbHArOTJXRzd3?=
 =?utf-8?Q?OmdYFKh80LISuHWBYH2+lSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38FFA72164AA024BBB0D83A6B9C35348@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ca77ec-438d-4017-67f0-08dc6abca307
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:20.1081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1D/5j90V/BTBQmg9tqnGZPy6GMw2LgB1qg/DRsYEUIMxWiAZyM/mGMT5PIr6olNMtm5w5sKe3/D8d3sG7giAUH3vv19bpV28Yx4pyF3KWWkrYJN4LmyrCsyRH2DrODkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

V2UgYWRkIGEgY29udmVuaWVudCB3YXkgdG8gaW5pdGlhbGl6ZSBhbiBkZXZpY2UtaW90bGIgbm90
aWZpZXIuDQpUaGlzIGlzIG1lYW50IHRvIGJlIHVzZWQgYnkgQVRTLWNhcGFibGUgZGV2aWNlcy4N
Cg0KcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkIGlzIGludHJvZHVjZXMgaW4g
dGhpcyBjb21taXQgYW5kDQp3aWxsIGJlIHVzZWQgaW4gc2V2ZXJhbCBvdGhlciBTVk0tcmVsYXRl
ZCBmdW5jdGlvbnMgZXhwb3NlZCBpbg0KdGhlIFBDSSBBUEkuDQoNClNpZ25lZC1vZmYtYnk6IENs
w6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0K
LS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8IDEzICsrKysrKysrKysrKysN
CiAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L3Bj
aS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggOWVkNzg4Yzk1ZC4uZDEwY2RiM2Q3NSAxMDA2
NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3BjaS5jDQpAQCAtMjc0Nyw2ICsy
NzQ3LDQ1IEBAIEFkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBD
SURldmljZSAqZGV2KQ0KICAgICByZXR1cm4gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KIH0NCiAN
CitzdGF0aWMgSU9NTVVNZW1vcnlSZWdpb24gKnBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lv
bl9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCkNCit7DQorICAg
IFBDSUJ1cyAqYnVzOw0KKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCisgICAgaW50IGRldmZuOw0K
Kw0KKyAgICAvKg0KKyAgICAgKiBUaGlzIGZ1bmN0aW9uIGlzIGZvciBpbnRlcm5hbCB1c2UgaW4g
dGhlIG1vZHVsZSwNCisgICAgICogd2UgY2FuIGNhbGwgaXQgd2l0aCBQQ0lfTk9fUEFTSUQNCisg
ICAgICovDQorICAgIGlmICghZGV2LT5pc19tYXN0ZXIgfHwNCisgICAgICAgICAgICAoKHBhc2lk
ICE9IFBDSV9OT19QQVNJRCkgJiYgIXBjaWVfcGFzaWRfZW5hYmxlZChkZXYpKSkgew0KKyAgICAg
ICAgcmV0dXJuIE5VTEw7DQorICAgIH0NCisNCisgICAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVz
X2RldmZuKGRldiwgJmJ1cywgJmlvbW11X2J1cywgJmRldmZuKTsNCisgICAgaWYgKCFwY2lfYnVz
X2J5cGFzc19pb21tdShidXMpICYmIGlvbW11X2J1cy0+aW9tbXVfb3BzICYmDQorICAgICAgICAg
ICAgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKSB7DQorICAg
ICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lk
KGJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdV9idXMtPmlvbW11
X29wYXF1ZSwgZGV2Zm4sIHBhc2lkKTsNCisgICAgfQ0KKyAgICByZXR1cm4gTlVMTDsNCit9DQor
DQorYm9vbCBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWlu
dDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5v
dGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbikNCit7DQorICAgIElPTU1VTWVtb3J5UmVnaW9uICpp
b21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZChkZXYsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yKSB7DQorICAgICAgICByZXR1
cm4gZmFsc2U7DQorICAgIH0NCisgICAgaW9tbXVfbm90aWZpZXJfaW5pdChuLCBmbiwgSU9NTVVf
Tk9USUZJRVJfREVWSU9UTEJfRVZFTlRTLCAwLCBIV0FERFJfTUFYLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgIG1lbW9yeV9yZWdpb25faW9tbXVfYXR0cnNfdG9faW5kZXgoaW9tbXVfbXIsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1F
TVRYQVRUUlNfVU5TUEVDSUZJRUQpKTsNCisgICAgcmV0dXJuIHRydWU7DQorfQ0KKw0KIEFkZHJl
c3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlX3Bhc2lkKFBDSURldmljZSAq
ZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IHBhc2lkKQ0KIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBi
L2luY2x1ZGUvaHcvcGNpL3BjaS5oDQppbmRleCAwYzUzMmM1NjNjLi4xNTg3YzE4Y2Q5IDEwMDY0
NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaS5o
DQpAQCAtNDU4LDYgKzQ1OCwxOSBAQCBpbnQgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKFBD
SURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KIHZvaWQgcGNpX2RldmljZV91bnNldF9pb21t
dV9kZXZpY2UoUENJRGV2aWNlICpkZXYpOw0KIA0KKy8qKg0KKyAqIHBjaV9pb21tdV9pbml0X2lv
dGxiX25vdGlmaWVyOiBpbml0aWFsaXplIGFuIElPTU1VIG5vdGlmaWVyDQorICoNCisgKiBUaGlz
IGZ1bmN0aW9uIGlzIHVzZWQgYnkgZGV2aWNlcyBiZWZvcmUgcmVnaXN0ZXJpbmcgYW4gSU9UTEIg
bm90aWZpZXINCisgKg0KKyAqIEBkZXY6IHRoZSBkZXZpY2UNCisgKiBAcGFzaWQ6IHRoZSBwYXNp
ZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSB0byB3YXRjaA0KKyAqIEBuOiB0aGUgbm90aWZpZXIgdG8g
aW5pdGlhbGl6ZQ0KKyAqIEBmbjogdGhlIGNhbGxiYWNrIHRvIGJlIGluc3RhbGxlZA0KKyAqLw0K
K2Jvb2wgcGNpX2lvbW11X2luaXRfaW90bGJfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQz
Ml90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3Rp
ZmllciAqbiwgSU9NTVVOb3RpZnkgZm4pOw0KKw0KIC8qKg0KICAqIHBjaV9zZXR1cF9pb21tdTog
SW5pdGlhbGl6ZSBzcGVjaWZpYyBJT01NVSBoYW5kbGVycyBmb3IgYSBQQ0lCdXMNCiAgKg0KLS0g
DQoyLjQ0LjANCg==

