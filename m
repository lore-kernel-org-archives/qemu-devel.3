Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93814D7496D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWX5V-0006IR-Eh; Fri, 19 Dec 2025 04:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vWX5P-0006I6-VJ; Fri, 19 Dec 2025 04:47:48 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vWX5N-0005mH-8x; Fri, 19 Dec 2025 04:47:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQQOKr3TOr3ftl6Fo0XOW05w7cj6LR8WnlCmuMNcMO8il5TBjw2H07VOp3FI8RdAD1a84WgYryS1nAfzOw/HrQ4Km9U4nCd35+xMkmRn/Ux88dkq3w8kwg1nfET7OrLs914nN6H9jFumHS+vETdCrIB9fTRfH0fFFnV6AH5FsjWSZhF1vm5OeV1DUROqRxTCXOtfXfPEjAbHXwXo5SdCZ8MjlIKotNoCgaChBVDoG2SEPAOEMCJJwXo+GvWL3KsS1hOUnlc+5SV/ww9UqyzUpALE4DgVTybnkvvt6NO8aH8u5L6fMDneiEWpNJ2mAUzRdHdtrAvzQLMGLuQxJFfbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL485ezey4OQ+opz5CP53lDF91u3Ws7fTmmk+BQuJCc=;
 b=lrypk2IhuuJ2ocKjcJMgCxphN2BtabX6c7/NFq3ViT1BlEGGLZkQHs/E4qw4P30C71vckQvWlZ9rsr0rUi5e58qjqwUzFgS8s5BDJ04376uEEFgXI+Qs2rUjU2s3mZkJzwuUhtGU3hz0vSMWp3UOppA4X/kVnk/puWbtpXkTmcSahcT3m0Pgmog9gKOf0LjLqS/OzrRnC395Fqbrt1g6y+83KZLdnaaWhCKoKmZeNzHjXFb4+KCGitqxnPhRASWA9FHQN9NIi+XRVtP9rG5KlWeoQQITduYHvfhYCRDCcgnbbLy+RDjeGpe26bpLgt6+bqyEiNAX2HSVELSgR4pE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL485ezey4OQ+opz5CP53lDF91u3Ws7fTmmk+BQuJCc=;
 b=bkG1upDLVX/soNr6OEvSWwpoIOBA780+N3N1m9ljmE9/ZrbzmzIJ+v6AZZfDOv9N6OgErGZO6uaTfvReJkUAqXhF7JvFja3LDf9HwAv1m0/koA0zW7XNszKVI6mx60fk/2rSXQtyB7+uxILLxJ27El5sOx0FqVHzo2SlCTpAdE3cwzNHWGqIjdIwSLRVxskZd6Vr8BCTWk1pyUBo0Syyw3aUJWOVEQ49DvriRFfGVk3IuQqv7cZUG7/l9ckJxQmWX466tlJNzDAb8ExIL7nM5RfVQKy+fIuiN8S+Ijzgj43yh2+TPts7IyR2Hgc4O7lgYTERs2ELgC/RlqxVJ3/S9Q==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by SE1PPFC725B22F5.apcprd03.prod.outlook.com (2603:1096:108:1::863)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 09:47:38 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%4]) with mapi id 15.20.9412.011; Fri, 19 Dec 2025
 09:47:38 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "vivahavey@gmail.com" <vivahavey@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
Thread-Topic: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
Thread-Index: AQHcYmPYsNbBGMo23UKXImQqaC0+/LUouJyAgAAOabCAAAaEgIAABanw
Date: Fri, 19 Dec 2025 09:47:38 +0000
Message-ID: <SEYPR03MB6700400BAC8C4BE3C80241B1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20251201014255.230069-1-alvinga@andestech.com>
 <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
 <SEYPR03MB670057426CD1F169681C54C1A8A9A@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
In-Reply-To: <625299d1-b04e-4c8e-8e96-8f353510ad3c@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|SE1PPFC725B22F5:EE_
x-ms-office365-filtering-correlation-id: c0057bc7-18de-421f-3581-08de3ee3a551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bUF6ZE5ITzRQUldLbi9XcEZzcDBSV1lPcXNuUy8wT1pWUFNpMWpXSllTcUEy?=
 =?utf-8?B?dm5MalZoWEtKNkVPbldDRG4rTU91dnNZZExMRXlQMnJpMUdPbjRsOGt2VUwv?=
 =?utf-8?B?dW1kd0gxdytWcmpFcWg0SkU0dHNhOWJxM0RUWmtZb1l3ei9wRTYzNVFjVHFE?=
 =?utf-8?B?NVNidHhQNkV5eEtYdFR6cjlnUDlxT1MwNGxwWmJtZlRpM291bWc3bDNpZTQ5?=
 =?utf-8?B?M0Erc2svMWNZUzlWbitzNDFSRnNtd2FGME9lcUtXZjhRUHVnbkxETmlEczRW?=
 =?utf-8?B?WDk0dk1hRUdhbDZsZGNXODM3Z0V5MU1CZmU3QnEvdWh4T3UyOUZ5N0kyNzVF?=
 =?utf-8?B?aFJxcjZ1WnF6WU5UU2VLYS84aS9DNGJMV083b1VaeWtyWDU2R0lxcnBJUU92?=
 =?utf-8?B?VFZza2I4cEVVTkN0c3FlWkErQ1B0YzZmSU0ydDRHclhkZEZFRDR6RTV6REFN?=
 =?utf-8?B?Nmd4ZS9zZE8zUnhReG1KeFZ3UGNWNDhNSHFaQ0VYcm0rOEpjOVlFMGpyR1ps?=
 =?utf-8?B?UUtNVWZ2WExZMDRyNDUxRllCVWxqcHAxcURORWdTSzkycG9ESjZ4Wm5lcGhw?=
 =?utf-8?B?NFJMb0JlMkhzQ08yR3pERU8zbkFHTmJtUXRjWXpUSG1nNnk5YzlmYmJrdnNx?=
 =?utf-8?B?S0RKWkZUdkhHZVJKTWd4YXY3U1dDVGtQNTZZU3NjYU1YUlNSYWM5Z0QyckN4?=
 =?utf-8?B?L2hsN3RNZlhNcE1KbkdKSHNubWxKOE1lQTljaHBIYWdELzN2THBhdmZGNUx6?=
 =?utf-8?B?bzRhajVLQ0dTZ3haMlZKR2dxVGZtdFFtY3hkRFNubUJRZVlIKzh4L0planFo?=
 =?utf-8?B?am9ON0djeGR1UzVTOVMyODVqV0NyQ0xOcE91RnlGWm9zdS9jRVNwTlExU0VZ?=
 =?utf-8?B?YjJtZHNJN1p3aURJRHFBbmhtZE5GeCtpMW43UUJtSU9GZEwxQXlXU0g3ei9Z?=
 =?utf-8?B?aEgxV05rclEyd1l6NHNkQ0RnbEhiWnVsbzhzbWEyTmJ2SzNSY2p3b2ZtRUxY?=
 =?utf-8?B?elRXdzhVNGlLYlZsU0tmR1NoS3I5M1ZlT09NUXR3a0VSU3gvMytCcEJUeG5E?=
 =?utf-8?B?NzYyanVRcStMc2tBNERpVURHZWpPK25MUEEwblRqV0FENnFmSjkwZFE2VTdy?=
 =?utf-8?B?dGZOaUNiY3Zvb1NwUTBkZEpYdmUrYVFZTWVLMFRjdTVJbHIxMjFlSzRPU3g2?=
 =?utf-8?B?cTF6TDBNcnVtNjBvdDFZZVRKemlVaFFGWWtSTHVYSWFuNVlJNXZOVDFJU2xH?=
 =?utf-8?B?WnM4bE9DTW1ubzJrMEFBQmhwK0JQcUo0WXFBTjN4bnRXQXVpS1Y4MWQycnVO?=
 =?utf-8?B?WkdhWWNRbHkrTEJmZUQvbGtRMVZ6M3BJQ1lTNDlsNWxROEhCU0FKcEM3N0d5?=
 =?utf-8?B?WjZJcUxKVlVlU3NmcC9FaHFjcm5Dc3BsRXFUZEVUZ3NrbENoYThGbU92a20v?=
 =?utf-8?B?dy9RN2I0NnFJL29DN2lIdkwrekhyMFR1Z2dRNGJiRm5TUjVyZjYwU0R0OGxY?=
 =?utf-8?B?cHNmQnViYXVaQkx6bVRuaWtYWGQvc3JNT1o3L3VYRnZ1RjlyWFJyVzhQSlg1?=
 =?utf-8?B?bnkrc09XRTlnQ3J0QUxxdU9GajlXT1l6QzFvWlB0YlB2bVc0MkRzbXRzT3lT?=
 =?utf-8?B?Q0dOR2tPQlMxRFAyUWJlT0VwOUhJREpXOHhyOHdHM3JFdnVNYWxDZzZBQlRT?=
 =?utf-8?B?TGNzNStUOWJaRTJxbGY1NGVHR1ZyWkM4clgybEo2eGIwTVpVRThMRkRaNVps?=
 =?utf-8?B?YnBFVDRmNTJJZHdwNlpnbVJnWU1RTjhQRjBDeU5yLy9aS3BlSkZKV3dzd0dp?=
 =?utf-8?B?cklzWm9EUUdZTWlPTXJCeTRTa0VRTy81bGgvbURmRk5RaG0yL2oxRnFnQ2Fl?=
 =?utf-8?B?ZHBMdTRiczgvTGF1NWFPaU5PZjRkd3RySGR2SEIyZktEZmgvUXBxbCtqUHVj?=
 =?utf-8?B?eFJtZ1VIT2xHaXZTYTlVZ3NKUHBSaXNXbkZNQVd6UDRxTTd6MlQ3VktWRmlz?=
 =?utf-8?B?OVlYSVVsWUx0MjJkbGJMSGNtNFRrdHdUbnFmMFhLaXJ4RTVqZ0lYaktYMWVo?=
 =?utf-8?Q?9je0p5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2xhWUZ3R1NyTkFSMHc2Sm1oaVBNMldQN21nT1E5NWFCcmxSemdpYmtBd0tY?=
 =?utf-8?B?bHo5ZHFyb2dyR0phR0drZUpCZFQ0S29ETDI1Z1JmQVloVFJUalhCUXljZTBO?=
 =?utf-8?B?SSs5QVNWMC9WZWhkMlRMNmZ6NVQyZHdFMlpEdkRnVXZNVUpScm9aMzcwVndS?=
 =?utf-8?B?dlBjV1ZQOHhqRGR1UlRQeW5uTmwwdDAwQXd5cGhQWUFhUXdCMmVSNHN5ak8x?=
 =?utf-8?B?ODQ1TWdtMlFtU1Z4U2xBR3VlOTljVjNtMTdLbFhjZEpLZzRGczgzSTRYZFl2?=
 =?utf-8?B?NERQRlJ3VUZZT1FrSDgxNmlja0dqVytBYW04SDdhTEJUaFRFOUk5UmVTbGZt?=
 =?utf-8?B?UmlFVkdMM2NFM2dkY1htNXpiRlNlS0kwTDZUaXFTMTV6d1g5VTUzZ0NXTXZD?=
 =?utf-8?B?bjltbzBpZGdTUERVTm5kT1N2MVBhOUZSZHEyYlhVWkdxUEhCQVdJdDh0MDFw?=
 =?utf-8?B?M24zK0Znb040UmVCbVhQSTdNUTU3L3pURDNNbmtmeTVKWGJ2RnBObWRRSXBI?=
 =?utf-8?B?Yy9oRWkyODJyUE96aGlrK011Z25MRG9jL3F3TVk5WTE5R3BLY1RlZmVOb3di?=
 =?utf-8?B?czZZNEtYaGVyQkFiRDZydzIwb3pxZTV4djhIZG9yYXZVdXMzYnZUdm50MGlm?=
 =?utf-8?B?dDBFWFZqZSt2N3ZSMVliTnZObUVLUFNQZnhsdXlZMHFLaERDNzdaWU1MRk1q?=
 =?utf-8?B?WjIvVFM1aEJmaGhZdmZjdkR6SkR0YUpSVjAzRy9rK1VxVXVOY0lMb3ZiQUZP?=
 =?utf-8?B?cS9YRUEzeFR6Z0NIVk12ZHJSa2RLR1JNcDJ5QjdMeUhuNmlVY2ovdXljalFw?=
 =?utf-8?B?Sit1dWhXemJZTWlnSlgrVFI2WWdkVjlxYWt5M2l0SjhaaHdDSmpkRmFjcG9Q?=
 =?utf-8?B?T3Y4ZlBXaUNXQVM4SWIzVUJHa3VTMUVFbHRWSlZrTlgwcWkvK3RZNkNEbEo3?=
 =?utf-8?B?VHpRNHZ4c2lYbmRnNW0xZ29yeFp2Y1l6SytXMXBiKzhiajUrNGVES1prRG9U?=
 =?utf-8?B?cEVoWXBuR2MrUW5TUE5uZlVVK21hMGwyMkwzMHRGcXZpeW1NNjF1YW9zdG9G?=
 =?utf-8?B?VVFZSVZlMlVKNkdjMWZsbmZQYkRYb3FzU3E4WUsra0FmNGV2ZExLNHJqOHpw?=
 =?utf-8?B?V2UxUlFjSjdqRTFKeFlWaHRqWVBwTTVHdzZJMzBaTlZxZW1QR29xQndEaVR1?=
 =?utf-8?B?R0tzakxwVlBpNkxsZE9qY096RDByM3JwM0JFSVZ0T2JUcWJ2OXhpNDUzMzhl?=
 =?utf-8?B?bzMyVE0xSmtxa2RBVk1Pdnd1aW5Ec2VJMzJ3a2RCa3ppU1M2NzY2RzBnRUFh?=
 =?utf-8?B?aXRrVUFURXcvYlNqTkJYTXJ0bEV5bVlvNEpvU0gxRGRZL3FCY1NaNFRha2RJ?=
 =?utf-8?B?ZURGWkxSajl0T21pSDNwUFo2TFVaWS90QW00SnpaQ2xCQzJsSi9Hb1huODdv?=
 =?utf-8?B?WTdMZnlpUXdWVXRneVZWTHF4SnJzVlQ3elhFT21EOFVrRDdqRVYyejhsaTB2?=
 =?utf-8?B?NnNyQ24zOTd5Nmt6N3BXN2pFY0VteVdjdVBDc1ZYRU91QlpUYzdJMzFMMm13?=
 =?utf-8?B?WXZzeEZyY1JJc1pLZjVuL3MzTmxoZ1N4aTArNW03eG5BS3pUTEQwN3hCVXZN?=
 =?utf-8?B?T1pIV1ZzTlRwQThjMTExN096RE5iZUhBZk1JVG1CK3I5N2crbUZ5OXdFS2xy?=
 =?utf-8?B?NlZ2K002a2kvdlByM3VPYlhlaVFkQm0weWRCdGNteTliTUFjV0cvTWQ2eDBJ?=
 =?utf-8?B?UGpPckFaekMxUzFPSGpCRzYrTlI5OG11ZDdWRGg4YiszVkcwZW1DekpRVDV2?=
 =?utf-8?B?WDRKNzhINjRTQ1FMZFdLM05CNUs1elBnYkNoTVB5SDNTYU1RbzZIZjZGSE5m?=
 =?utf-8?B?VnNBODd6ckNQNm1mQS9pRkltcVR4MURybUsrTnhTcUhlRkdjSXVoQW1XQlgw?=
 =?utf-8?B?ckdyMisvMHZ1ZjlHN1hmZktyUG5EL0hLc0VUYlZxWWFTb2dyNEpqZ3czV2NF?=
 =?utf-8?B?NUcvaHVoanZHY1g3Q29sQXBFTjhvQ2RqSVFBaWQyVHczby9oYXZxbzBoL2FO?=
 =?utf-8?B?Y01lTkV3ekk5ZW1VeURtd1ZMb0YvYzRmdHhtS09STDkybXY3NkNGQ2FoK0ox?=
 =?utf-8?B?NzdvSStYS1hYa0lCbU5hNnpyVkZXSWdJb2gvUkJJSHVjQ2ozZ1cyMjdqb29E?=
 =?utf-8?B?ZnFHR0huZmhWTXJJRmZ0VWthUEhFY0dlazlIWG9pQlBINmlhUlpUSmRjZlpx?=
 =?utf-8?B?RHV6a1IxUDVrMnhJN3BTZlgreldocWJmcm4wcEhLaDF5MHFLYXFnT1p2d0pU?=
 =?utf-8?Q?xaNHXy9MR//ZDY/npD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0057bc7-18de-421f-3581-08de3ee3a551
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 09:47:38.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkE1Utef9b4Tb1rK3PLJ9hnHEgzArGeUqYDGrpnRAM5ScGdVjskxdzdm/LA51gtJ8oMy/hMy2Y4vlPxSmUqr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFC725B22F5
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=alvinga@andestech.com;
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhbyBMaXUgPGNoYW8u
bGl1Lnpldm9ybkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTksIDIwMjUg
NToyNCBQTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKSA8YWx2aW5nYUBh
bmRlc3RlY2guY29tPjsNCj4gcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb207IGJpbi5tZW5nQHdpbmRyaXZlci5jb207DQo+IGRiYXJib3phQHZlbnRh
bmFtaWNyby5jb207IGxpd2VpMTUxOEBnbWFpbC5jb207DQo+IHFlbXUtcmlzY3ZAbm9uZ251Lm9y
Zzsgdml2YWhhdmV5QGdtYWlsLmNvbTsNCj4gemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvMl0gUklTQy1WOiBJbml0aWFsIHN1cHBvcnQgdmVy
c2lvbmluZyBvZiBkZWJ1Zw0KPiBzcGVjaWZpY2F0aW9uDQo+DQo+IFtFWFRFUk5BTCBNQUlMXQ0K
Pg0KPiBPbiAxMi8xOS8yMDI1IDU6MTAgUE0sIEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWY
iSkgd3JvdGU6DQo+ID4gSGkgQ2hhbywNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBDaGFvIExpdSA8Y2hhby5saXVAemV2b3JuLmNuPg0KPiA+PiBTZW50
OiBGcmlkYXksIERlY2VtYmVyIDE5LCAyMDI1IDQ6MDkgUE0NCj4gPj4gVG86IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KPiA+PiBDYzogYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tOyBBbHZpbiBDaGUt
Q2hpYSBDaGFuZyjlvLXlk7LlmIkpDQo+ID4+IDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+OyBiaW4u
bWVuZ0B3aW5kcml2ZXIuY29tOw0KPiA+PiBkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tOyBsaXdl
aTE1MThAZ21haWwuY29tOw0KPiA+PiBxZW11LXJpc2N2QG5vbmdudS5vcmc7IHZpdmFoYXZleUBn
bWFpbC5jb207DQo+ID4+IHpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCj4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyAwLzJdIFJJU0MtVjogSW5pdGlhbCBzdXBwb3J0IHZlcnNpb25pbmcg
b2YNCj4gPj4gZGVidWcgc3BlY2lmaWNhdGlvbg0KPiA+Pg0KPiA+PiBbRVhURVJOQUwgTUFJTF0N
Cj4gPj4NCj4gPj4gT24gTW9uLCAxIERlYyAyMDI1IDA5OjQyOjUzICswODAwLCBBbHZpbiBDaGFu
ZyB2aWEgd3JvdGU6DQo+ID4+PiBUaGlzIHNlcmllcyB0cnkgdG8gc3VwcG9ydCB2ZXJzaW9uaW5n
IG9mIGRlYnVnIHNwZWNpZmljYXRpb24uIFRoZQ0KPiA+Pj4gZWFybHkgZGVidWcgaW1wbGVtZW50
YXRpb24gc3VwcG9ydHMgZGVidWcgc3BlY2lmaWNhdGlvbiB2MC4xMywgYW5kDQo+ID4+PiBsYXRl
ciBuZXcgdHJpZ2dlciB0eXBlcyB3ZXJlIGFkZGVkIHdoaWNoIGFyZSBkZWZpbmVkIGluIGRlYnVn
DQo+ID4+PiBzcGVjaWZpY2F0aW9uIHYxLjAgdmVyc2lvbi4gVG8gc3VwcG9ydCBib3RoIHYwLjEz
IGFuZCB2MS4wLCB3ZSBhZGQNCj4gPj4+ICdkZWJ1Zy0xLjAnIGFzIENQVSBwcm9wZXJ0eSB0byBs
ZXQgdXNlciBjaG9vc2UgZGVidWcgc3BlY2lmaWNhdGlvbg0KPiA+Pj4gdjEuMCBieSBzcGVjaWZ5
aW5nICJkZWJ1Zy0xLjA9dHJ1ZSIuIFRoZSBkZWZhdWx0IHZlcnNpb24gaXMgc3RpbGwNCj4gPj4+
IHYwLjEzIGlmDQo+ID4+ICdkZWJ1Zy0xLjAnIGlzIG5vdCBwcm92aWRlZCBhbmQgc2V0Lg0KPiA+
Pj4NCj4gPj4+IEZvciBleGFtcGxlLCB0byBlbmFibGUgZGVidWcgc3BlY2lmaWNhdGlvbiB2MS4w
IG9uIG1heCBDUFU6DQo+ID4+PiAqIC1jcHUgbWF4LGRlYnVnLTEuMD10cnVlDQo+ID4+Pg0KPiA+
Pj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gPj4+ICogSW1wcm92ZSBjb21taXQgbWVzc2FnZSBhbmQg
Zml4IHR5cG8NCj4gPj4+ICogQXBwbHkgIlJldmlld2VkLWJ5IiB0YWdzDQo+ID4+Pg0KPiA+Pj4g
Q2hhbmdlcyBzaW5jZSB2MToNCj4gPj4+ICogQXBwbHkgc3VnZ2VzdGlvbnMgZnJvbSBEYW5pZWwu
IFVzaW5nIGJvb2xlYW4gcHJvcGVydHkgaW5zdGVhZCBvZiBzdHJpbmcuDQo+ID4+DQo+ID4+IFRo
aXMgaXMgZ3JlYXQgd29yayEgVGhhbmtzIHRvIEFsdmluIENoYW5nIGZvciByZWZpbmluZyB0aGUg
c2RleHQuIEl0DQo+ID4+IHNlZW1zIHdlIGFyZSBvbmUgc3RlcCBjbG9zZXIgdG8gbWVyZ2luZyBy
dnNwLXJlZiBpbnRvIHRoZSBtYWlubGluZS4NCj4gPg0KPiA+IFRoYW5rIHlvdSwgQ2hhby4NCj4g
PiBQbGVhc2Ugbm90ZSB0aGF0IHRoaXMgc2VyaWVzIGRvZXNuJ3QgaW1wbGVtZW50IFNkZXh0IGlu
ZnJhc3RydWN0dXJlLg0KPiA+IFdlIGhhdmUgc29tZSBwYXRjaGVzIGZvciBTZHRyaWcgYmFzZWQg
b24gRGVidWcgc3BlYyB2MS4wIGFuZCB3ZSB3YW50IHRvDQo+IHVwc3RyZWFtIHRob3NlIHBhdGNo
ZXMuDQo+ID4gV2UgZXZlciBzdWJtaXR0ZWQgdGhlIHBhdGNoZXMsIGJ1dCB1bmZvcnR1bmF0ZWx5
IHRoZSBwYXRjaGVzIHdlcmUgYmxvY2tlZC4NCj4gPiBUaGUgbWFpbnRhaW5lciB0b2xkIG1lIHRo
YXQgUUVNVSBzaG91bGQgc3VwcG9ydCBib3RoIHYwLjEzIGFuZCB2MS4wIGZvcg0KPiBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5LCByYXRoZXIgdGhhbiBlbGltaW5hdGluZyB2MC4xMy4NCj4gPiBUaGF0
IHdoeSBJIHN1Ym1pdHRlZCB0aGlzIHNlcmllcywgdHJ5aW5nIHRvIHJlc29sdmUgdGhlIHZlcnNp
b24gaXNzdWUuDQo+ID4NCj4gPg0KPiA+IFNpbmNlcmVseSwNCj4gPiBBbHZpbiBDaGFuZw0KPiA+
DQo+ID4NCj4gT2gsIHRoYW5rIHlvdSBmb3IgeW91ciBjbGFyaWZpY2F0aW9uLiBJIGFsc28gbm90
aWNlZCB0aGlzIHdoZW4gcmV2aWV3aW5nIHRoZQ0KPiBtYWluIHBhdGNoIHNlcmllcyDigJQgaXQg
d2FzIG15IG1pc3VuZGVyc3RhbmRpbmcuIFN0aWxsLCB0aGFuayB5b3UgZm9yIHlvdXINCj4gY29u
dHJpYnV0aW9uIQ0KPg0KPiBJIGhhdmUgZG9uZSBzb21lIGRldmVsb3BtZW50IHdvcmsgb24gU2Rl
eHQgYmVmb3JlLCBidXQgSSBub3RpY2VkIHRoYXQNCj4gaW1wbGVtZW50YXRpb25zIG9mIHRoZSBE
TSBtb2R1bGUgdmFyeSBhbW9uZyBkaWZmZXJlbnQgdmVuZG9ycy4gSW4gYWRkaXRpb24sDQo+IGhv
dyB0byBhY2hpZXZlIGNvbXBhdGliaWxpdHkgd2l0aCBnZGJzdHViIGlzIGFsc28gYSBjaGFsbGVu
Z2UuIEkgd2lsbCBzZW5kIG91dA0KPiB0aGUgUkZDIHBhdGNoZXMgYXQgYW4gYXBwcm9wcmlhdGUg
dGltZSBpbiB0aGUgZnV0dXJlLg0KDQpOaWNlIHdvcmshIEkgcmVtZW1iZXIgdGhhdCBTcGlrZSBo
YXMgRE0gbW9kdWxlLCBzbyBJIHRoaW5rIHZlbmRvciBjb21wYXRpYmlsaXR5IGlzIG5vdCBhIGNy
aXRpY2FsIGlzc3VlLg0KSXQncyBiZXR0ZXIgdGhhbiBub3RoaW5nLiBMb29raW5nIGZvcndhcmQg
dG8geW91ciBwYXRjaGVzIGZvciBETSBtb2R1bGUuDQoNClNpbmNlcmVseSwNCkFsdmluDQoNCj4N
Cj4gVGhhbmtzLA0KPiBDaGFvDQpDT05GSURFTlRJQUxJVFkgTk9USUNFOg0KDQpUaGlzIGUtbWFp
bCAoYW5kIGl0cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdh
bGx5IHByaXZpbGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZyb20g
ZGlzY2xvc3VyZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFy
ZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0
aW9uLCBvciB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaXMgc3RyaWN0
bHkgcHJvaGliaXRlZC4gSW4gdGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRo
ZSBzZW5kZXIgYnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdlIChhbmQgYW55IGFj
Y29tcGFueWluZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVkIGhhcmQgY29waWVz
LiBUaGFuayB5b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQoNCkNvcHlyaWdodCBBTkRFUyBURUNI
Tk9MT0dZIENPUlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg==

