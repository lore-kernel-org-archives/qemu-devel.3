Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85B3C7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 05:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTZxh-0005ro-HW; Mon, 23 Jun 2025 01:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uTZxd-0005rV-AN
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 01:43:17 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uTZxa-0001b3-8E
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 01:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1750657394; x=1782193394;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VCPDAqSXJc62msuVa9JeOmZc65TSwiWKVcUZGko1oOQ=;
 b=PgsjScWaZLNlIu5mlE6kqfO/YOTsOKoHA3IExEv/CUd30EyDE6g6zz61
 AL/OaPWOKOeq8Zz1VQ5iFEp7KJhAFQQbm4QgMAA834AwNrwk7CTGqCJAJ
 Mta050X8WVuAEhBJjns6l4pppqdtF/RhlRn6/rssSzkQuLzSuMOWacFT7
 QwgbABbNe/+SQa+1Xp/EkCJisEB79vdVbIfSqeGmJtyUfeka8KWQ5Xd41
 ao8Y6I7oWuXDHB0WTg/WHNUQ3EYVNKStYwVzoqEPuEx6uj8TQ99ieojQW
 oCYzQ9L9s3bL9OQjA02/FPHnD5k/bUMEzgwPNUGb6RRQc7oiqdvYyfazk Q==;
X-CSE-ConnectionGUID: asJm6GLZRWSYjrZkdfX12Q==
X-CSE-MsgGUID: /x9OUz8WR1O5zos2M6lGsw==
X-IronPort-AV: E=Sophos;i="6.16,258,1744063200"; d="scan'208";a="39211115"
X-MGA-submission: =?us-ascii?q?MDGqucZuLRuFTmgxx8G+rpbnQxMTVIEj78MXEg?=
 =?us-ascii?q?QAF/m+/+4A6U71yJQiT/JXSEc/LEzKL1IXuSX+yxhb3xjHol1q6GIVr1?=
 =?us-ascii?q?OAQoERsrTFoNOP8z1baij/ZdycsAdy1Oz91tb28FruD3iE7q2crgZ6fg?=
 =?us-ascii?q?y0Zfz9BYKbE4asFllt+EtdZA=3D=3D?=
Received: from mail-northeuropeazon11011000.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.0])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 23 Jun 2025 07:43:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKpnqD0li/ungM1udHIU+9DQ3FCHuNcMrC7XZtEGeh/ruvC6zVCyvF4AELKmJUSVJHRtuRrc2btEkankz6KAzjoKedaS8soqiuxYGsWpUZB90poXZMKamJYVASISYk+pcvWLzB+adZjRF0IUIe/zMFC95M5vxCFPhIgM1ylBAiFKw4Sk6OB1JwdmxDTgk8FUdhld7j92adzpfBTO8xJCo0gAq0wFtOScLruK54LzK1zPivG7UbyeN1Cje0EM3+vnWfCKgTdJthnvqg0qBL1dLR11GEuQosRtvDJGa3i4Oif+O+x4j80Pb7M2rYVB9hRSYvu2I8M8anUtP9/uoo11Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCPDAqSXJc62msuVa9JeOmZc65TSwiWKVcUZGko1oOQ=;
 b=Z6N+l3vKjMghwVGfNnXT40NrecL+ZsAzZySynhGkZWfgT2TPylr+pGacAUbvRJ1sDKBAJbTQY9bLAugmQcV8xuO32L93isJEXINV4t2q98sIW4r9OEuu6iCw8GWhqSj0rDZvoRkCMWIJyL4x1XiEzYk7QYrIRMPs7bFZgGEHDlMVLRB8+ZLMBrcfLHEY6rzBKFWazESqfAmgfjI1CvmnVzQLw9Uw0IrMvFs1IMoF7P8wgl+jG+mMQXvWGoKmtim01VV8iIol4ZQlC3VbSyeYyH5hSYIIHB2eMj2LE980gCiB+nuHhGPLQM5AEM/rCUyVBJDpVGjQY9+W5JXNKfrBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCPDAqSXJc62msuVa9JeOmZc65TSwiWKVcUZGko1oOQ=;
 b=rrV8pbihbiU81IdRtkeaBETsuHV/J0r8yYv6XZ72Bdv1WXT9DIuL3ME7+yu5hBZCZPyZM4VIZg6ZyJigsq/5dQJdTGTxqetzZDwBu81Z0PA1ZOxKm78qfoHNoiakpYn+kSCO5oG42V5JMfMyynhASvonJlxL+iLKYN6p0/U3zUwEHousZB4vkXhcuQ/vVtj9Od6wQQbU13nnfjsxnxjM3Jg9U+aBTA+MuIWYp8QNZfB2AUr68aJIy85afKQ8EhxulSZ/b2E1KlhS9q1t37jh0LvR3Vg0M1ZYcvICLBzcCN7MGvv0AwMOjqzf55kuwRT0PY88RfRsYXjWNgwRD1wsQw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB7983.eurprd07.prod.outlook.com (2603:10a6:102:13f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 05:43:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:43:06 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Ethan MILON
 <ethan.milon@eviden.com>
Subject: Re: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Thread-Topic: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Thread-Index: AQHb4agdcjvbOfmLQ0WiEyuqDfW1lLQMHeUAgAQiGAA=
Date: Mon, 23 Jun 2025 05:43:06 +0000
Message-ID: <7ba298b6-13d3-44b4-bc67-5516893a6cb4@eviden.com>
References: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
 <aFVxwG_O2QkryM6P@x1.local>
In-Reply-To: <aFVxwG_O2QkryM6P@x1.local>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB7983:EE_
x-ms-office365-filtering-correlation-id: 7e1ff588-8185-4381-1465-08ddb218d3e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUZjdS8zYWUvQitTSWhYZ2tkNFRmTk1XUEZSTTR5UEZMdXVhWC9uVDVZUnJW?=
 =?utf-8?B?SjhZc0NkakJ4N3FpZjJ6MGFiZit2dkZxdlBFN1loSGVpci9tZTNwZlVJaUdL?=
 =?utf-8?B?S21LcEFXdHB5OEozMG9NN2NyZmIvVXdWb1pkUVYwZ21SRW5EdmlKRXd6MHpM?=
 =?utf-8?B?am5jclRWRmVTWFhFLzkwWDY0VS9uSkdISWE1TGN1TWZ4YTJ5Z2ZJeVp0Z2ls?=
 =?utf-8?B?MUZtVjJkMkdueVMxNjB5Y1IvQXI3MEwvOUNJTlpaZlYzZldWMWJac2V4NGRk?=
 =?utf-8?B?ZFc2aWQ2dWd6amJXaUVTWGNiMTRYTkJWR2p0WFdZRU4vOGFHMUtnYWhsRUNX?=
 =?utf-8?B?MElVbW9zSFJ2Y3dSZkI0NU5xZXJEUkg4VU5rbjJRYW96OWZYS3I0MlhYaVZh?=
 =?utf-8?B?M2xTcGM2RFpUQldONDNpZDNreGpyNnhuUHhlWHptWmIxR2pORm9iVUtjQndX?=
 =?utf-8?B?dXFmUzZwSmtYOWVzbHkyOE9DU2EyTHppMk1SUTRPNkZkMS9IZHB1VUFLZHU1?=
 =?utf-8?B?aXpMTEgxaFZpZ1RDbVlwTENodkNFSWFCQVF2aGpIODJaMHUzQmtUSVZkVGRQ?=
 =?utf-8?B?Vmg0RWR3Rm1DRHJjUHRaTno2SW54aFYrK1RyVnBqb0dPdkVJKzRZWUtLZFFG?=
 =?utf-8?B?ZG1iSWJmKzlqSHlqci9HY3dvOEViUDl0MnB4dUc4VTBnSGhDVC9wdDYvdU96?=
 =?utf-8?B?UmROd0w1a3hod3FlMDR3MGoxZUZiUGtzNWMrZkJYRzJNWjh1cTFwR3RZaTky?=
 =?utf-8?B?MVRZZll2akpvV29yOUlMMGc2L2V0SkNvMDRCSnhHOWlWdzM2TWpPcmRlL0F3?=
 =?utf-8?B?cjgwZlZPcEgwSldvR1ltYmEwc1htTGJGVTduK1daUW8zRVBPU2RiZ2pOa1Ri?=
 =?utf-8?B?cjBwOTl4M20zdFh0T0JUZGVlenhrWXpwZnJDNUFEQXB6cWdVdGRWRStUVmhV?=
 =?utf-8?B?MTRVT1QvTm91ZEQ4NGtYNEVNTUdySG1VMUxOUk5DSysveWxGYzFMT0FKNDhn?=
 =?utf-8?B?NVEwRXRzc0kxaGJ2WWV2NytvUmJHVWxjV0NpVm50cnA0NWdTRzI3Q0VPYlRM?=
 =?utf-8?B?UDBxMlNCZ0s5RlZ0Q1VWMXV2aXJKT2JiT2JLRXRHOHhuc0M4bXNZMGgwMDRz?=
 =?utf-8?B?NUJzdVNCTm5YUVZYakhnb3huVnlEMitiSmpybDROemFKR0R4M0t4NGpsTE9N?=
 =?utf-8?B?UVlYUGRoNEJJV0xCbnoxUit0QnpBbk04ZjdlQll5RFIrTWxZK0RhQUFERzZB?=
 =?utf-8?B?OG94MVpLMkZNYkcwbkdyZldFWXFMMjNRM3ZGd2ZwQkpNekZZRXUwUzRaVHJn?=
 =?utf-8?B?WjBqL3JxSWp5ZVF3eDhnVDZFdnIzazdWYUYyem1pQWlmU1dLaWtEUy9nZVFt?=
 =?utf-8?B?UVNzU3hXTXVyT0pJWEtaRW83VHFQSXg1OEFmR1pKdFZVdTlFazZQeXdXekRx?=
 =?utf-8?B?MU5NbkE0Nll0VHZ1VU0wYjEwTVRqN3hkcGRpWXl2WWtuOUY2enJ4bzVhRUNG?=
 =?utf-8?B?Z08yc1dXTUhEYjhEdFZuc2VEV2RLdDZTcDRydGt0aWp5NE9PME82ZzhvUzV6?=
 =?utf-8?B?M1NtZllXZWNvZWV5R1VVUituRGZnTjhHMkt0RXB4WHo1aklXaUVhZWxVc1pp?=
 =?utf-8?B?alZQMzRpZGgxT1dVOVY3dHlZZ3RzdUE3WGdFbzhEOHQrR0o4M3ExbWJ4bXFM?=
 =?utf-8?B?NXRXVUFMenhYNWRMdGdTR3hsVG1Lc1E5R21GNGRsM1VTbVZCaU8zL09LT2pK?=
 =?utf-8?B?cURxSHhxbmFwZFpoWXlta1hFTXFvb0RSdU9Oa3V1MEE0MWVuOFV3RDRmU2pO?=
 =?utf-8?B?V21DS2pTdmQyM1dHNE41U2JZL1A2UEV5eUN5QjdhdlpFMFhNVGNIQ1IrVjBQ?=
 =?utf-8?B?UVUveHRjNHpmRTh5Z3ZBNW5OaWxXejZKSWo2cCtmNEhKOFk4NnU2MkR2eFdo?=
 =?utf-8?B?UGo0dGhqSzkvVWdFSEZEZmRsbDlsUDNhaTNLT29BR1VGeVdmV1FWalIvU1dv?=
 =?utf-8?B?eHM2REhJTWdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHVRN29oRjZZUUZPeTN4NzNRRUVaL1JUTThnVlR1elVHcVpYQklsRkpLOEZ1?=
 =?utf-8?B?bDJUMi82cEZ0MHZzVFRseE1YTDRkYXRYMHd3V2NBUXlTd2xWOVJUU1h5aUE3?=
 =?utf-8?B?Uk1VUEJPTUxFZmNDSnd1VFYyVHpyLzZVWWg0NVNwUlpEZjRBRWkzbE9pRTUz?=
 =?utf-8?B?aDlFYzhMcVZkTnY4cE1UcEx5Q3FCOWI5RWdCTk95dXpGT3F2VXI1bmlwUk5C?=
 =?utf-8?B?cHdvNWhxN2Q3b2NYWWJpdHdhK01oU294NmtUK05YVTJZRkN5UTBtZDdBTXZj?=
 =?utf-8?B?KzVzTHB5aDRvMFlBejV6aWQ4Y1F1WWlFS2htYk9TZ0lBTE11TXkrN0Y4Qk9B?=
 =?utf-8?B?bFo5T0x2cE8rYkRUelE4YnhVaVNwZzB2aTJUUmlsWGNCVjlnMFFPc0VTYit5?=
 =?utf-8?B?Q1QzamJxcFNKNENpL1N1MG9XaVdsUnFvam90ZUx5Z1FwZWFMdXYzdTN1UVVR?=
 =?utf-8?B?TDAvdkpiM1FBTFRIZWpYaVhIVXVyQ2lHc0p1UUZvWWRvUFJBbEVKT0U4LzZu?=
 =?utf-8?B?c0lKaCt2Skd3d0ZIZU1oa3ZiQm1sd0VjNVcrZUtCR09PMUcwVmgrZUcrVWtt?=
 =?utf-8?B?UDB1WmZQbUtWZmFyb1FLRnZEWUl6Ym9yM3BBbDBDSkpjM3crUkVwMjNQQS9O?=
 =?utf-8?B?RDI3TWorTmNleVM5RmZjMURXbFhLcmZ3bmJnSVlnYlB2dVhRenpLY3h1Uk5i?=
 =?utf-8?B?dnZxeExIUFpFL0tTVHFLMU9PWW1zNGxyZ2dFeWovaTNHOVJLSXNncVZlZG90?=
 =?utf-8?B?U0FIU1VrYjhTUEh4N3ljUkFVWC9EOGt2VkxHdXRkVkR6VXp6YXdRNlN4VEl4?=
 =?utf-8?B?ZW51MzNiT0lLSVhGYjg2emhDd3dON3FKRHk5cmNUSHpiRnBsUWEwNTI2cUpw?=
 =?utf-8?B?Nk5FOFVEbTFPVEsvV0FSMDAvQTVCcG9yNGI0Y0JEVjdqeXBSWFJEQ28vWG5W?=
 =?utf-8?B?ZDB2VUEyWlU0RFYyL0o4cFFic3JvRTYzcHVRa0RhZFBKU3F1TDdnL2o3WnhC?=
 =?utf-8?B?c3NSOENVMU9aOWlWMlhkY1BDSWFFOU95T296R05md2hSckxCM1d4ZUFiUncv?=
 =?utf-8?B?VC9OTW5lSFUrYXJxWm1CRmFJNStjL1VDbHU3a25sd0JtR2VvcWFwUzhCeUxU?=
 =?utf-8?B?ZjducTdYRTJ3N0xRTDFGYWMxWVpvQk1UVUxiTVE3UnltTWdjaDh3RTFvQnhF?=
 =?utf-8?B?Vml6ZElJUG9YVXhQME9tclhyNi80RnNUSUM4QXFPRVB1SG9naDY5aWl3c0dr?=
 =?utf-8?B?dzRYRFlieDlGZG45cG03ZmE2QmY3VFpLQlpXSEVFcHFhUlJQTmpJbEN2ZzVq?=
 =?utf-8?B?ejlFL1YzK1lBanUwRk41SWo5N1lpMDdBZ2VuTHZZUnlCY1FEWW9sZXJWT3hE?=
 =?utf-8?B?c29YTXlGazZsajBVVWpQeUdYZDkxNjVIWTNKNi9OUXljRFp3RUdPaXRGZkhu?=
 =?utf-8?B?b2U5V1ZramIxcXorOHdrSWVZWm9XTU1NMGkvbE1iNW9RZVRZMXYvTEZQa3k0?=
 =?utf-8?B?bWpuUUwwVUdzMjNWZFZZd2VKZEJ2ZXkweTUvYmthNWRNOHRUZUh5b2U4Y3Vw?=
 =?utf-8?B?NWJ3dW9zZVprbUU4V0orWkgyVmd2OWFJVnBMUzZ5WXo3eFNUajR4ZnF1akRH?=
 =?utf-8?B?dzhLTlVpOEp1bWNXLy9XSWh4TURhUUFGQjMra0tkTmp6WEZNcjkxNTVZMkx1?=
 =?utf-8?B?dzF0R1lVVS9xOWxsQWwxdGU1aE85Z05iNkhSZGtvaU9TOWwwNndsc1lSM1Jk?=
 =?utf-8?B?SlhYdnBrMHF5SXVhSVdBa0hhUGttb0QxTmM4UlBUa0duNkxoNVozaVRVOEJz?=
 =?utf-8?B?dFk1c3djL0ZYS3VMa29CajVmMXhvQXpBcVgwRGt4bzRoVUtXTTFGUis0MTRB?=
 =?utf-8?B?ZlFjSjJ2Q2xvbVlXMkxiUWl2Rk1WNjJ5WXNMenNiaGNnZGgzWTZZT3dIYUVX?=
 =?utf-8?B?SU5tZXE5bDc2aGs4TTg4cWtra1B6d0dYRUhaM0dyQ3RBZEluTFZmMEhEVzRL?=
 =?utf-8?B?SDBxbUNDZGMwelFWaWFzL3YvQXYrU250cjM2SU1TRFpWN2tRak5HSWRIcFc3?=
 =?utf-8?B?UkRPSUtUcFBVL25OS0RzdGRhcHlONCthUmJLRDFORE1CMGt4S0k0ZmVZdWkx?=
 =?utf-8?B?WDVIQTVBdzlweW1nYXhjanR5Z0tCNjJIaGEyZ2twVGZhdUl1VEdRMFZuYU5u?=
 =?utf-8?Q?zLoAc+soS87QYvRtEActYIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6625DE48F1278438001C9C3EA83A1A2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1ff588-8185-4381-1465-08ddb218d3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 05:43:06.0305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSc9yBUEbw6E3FXQwY91hJEhyyjKlhZoG9uamMAgNQPjmuN0CHq5+VRclLOac1CNvA7WI42SoWPK9riczqN7LVXQYcbBjImTlBj3SVIDgaOk55d2/xBigaQiV9LZxb0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7983
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SGkgUGV0ZXINCg0KT24gMjAvMDYvMjAyNSA0OjM1IHBtLCBQZXRlciBYdSB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIEZyaSwgSnVuIDIwLCAyMDI1
IGF0IDA1OjU2OjQ5QU0gKzAwMDAsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+IFRo
aXMgc2hvcnQgc2VyaWVzIGFkZHMgdGhlICdhZGRyZXNzIHR5cGUnIGJpdCAoY29uY2VwdCBmcm9t
IFBDSWUpIHRvIHRoZQ0KPj4gbWVtb3J5IGF0dHJpYnV0ZXMgYW5kIGV4dGVuZHMgdGhlIElPTU1V
QWNjZXNzRmxhZ3MgZW51bS4gVGhpcw0KPj4gd2lsbCBiZSByZXF1aXJlZCB0byBpbXBsZW1lbnQg
QVRTIHN1cHBvcnQgZm9yIHRoZSB2aXJ0dWFsIElPTU1Vcy4NCj4+DQo+PiBBZGRyZXNzIHR5cGU6
IEZpZWxkIHByZXNlbnQgaW4gdGhlIFBDSWUgUi9XIHJlcXVlc3RzLCBpdCBhbGxvd3MgZGV2aWNl
cyB0bw0KPj4gdGVsbCB0aGUgSU9NTVUgaWYgdGhlIGFkZHJlc3MgcHJvdmlkZWQgaW4gdGhlIHJl
cXVlc3QgaXMgcGh5c2ljYWwgb3Igbm90Lg0KPj4gSW4gb3RoZXIgd29yZHMsIGl0IGFsbG93cyB0
aGUgZGV2aWNlcyB0byB1c2UgYSBwaHlzaWNhbCBhZGRyZXNzIG9idGFpbmVkDQo+PiB2aWEgQVRT
IGFuZCB0byBwcmV2ZW50IHRoZSBJT01NVSBmcm9tIHRyeWluZyB0byByZW1hcCBpdCBvbiB0aGUg
Zmx5Lg0KPiANCj4gVHdvIHB1cmUgcXVlc3Rpb25zIG9uIHRoZSBmbGFncywgY291bGQgYmUgcmVs
ZXZhbnQgdG8gc3BlYzoNCj4gDQo+Pg0KPj4gQWRkaXRpb25hbCBJT01NVSBhY2Nlc3MgZmxhZ3M6
DQo+PiAgICAgIC0gRXhlY3V0ZSBSZXF1ZXN0ZWQNCj4gDQo+IERvZXMgdGhpcyBtZWFuIHRoYXQg
d2UgY2FuIHN0YXJ0IHRvIHB1dCBjb2RlIGludG8gRE1BIHJlZ2lvbnMgc28gdGhhdA0KPiBkZXZp
Y2UgY2FuIHJ1biBzb21lIGRheSAoZXZlbiBpZiB0aGUgZGV2aWNlIG1heSBoYXZlIGEgY29yZSB0
aGF0IGlzIHRvdGFsbHkNCj4gZGlmZmVyZW50IGFyY2ggdi5zLiB0aGUgaG9zdCdzIA0KQUZBSVUs
IHRoZSBzcGVjIGlzIHNvIG5vbnJlc3RyaWN0aXZlIGFib3V0IHRoaXMgZmxhZyB0aGF0IGhldGVy
b2dlbmVvdXMgDQphcmNoIHNob3VsZCBub3QgYmUgYW4gaXNzdWUuDQoNCiJUaGUgZGVmaW5pdGlv
biBvZiB3aGF0IGl0IG1lYW5zIGZvciBhIEZ1bmN0aW9uIHRvIGV4ZWN1dGUgY29kZSBpcyANCm91
dHNpZGUgdGhlIHNjb3BlIG9mIHRoaXMgc3BlY2lmaWNhdGlvbiINCg0KPiANCj4+ICAgICAgLSBQ
cml2aWxlZ2VkIE1vZGUgUmVxdWVzdGVkDQo+PiAgICAgIC0gR2xvYmFsDQo+PiAgICAgIC0gVW50
cmFuc2xhdGVkIE9ubHkgKGNhbm5vdCBiZSB1c2VkIHdpdGggJ0FkZHJlc3MgdHlwZSA9IHRyYW5z
bGF0ZWQnKQ0KPiANCj4gSSBjYW4gdW5kZXJzdGFuZCB0aGlzIHdpdGggcGF0Y2ggMSwgYnV0IG5v
dCB5ZXQgd2l0aCBwYXRjaCAyLg0KPiANCj4gUGF0Y2ggMSBtYWtlcyBzZW5zZSB0byBtZSwgSUlV
QyBpdCBtZWFucyB0aGUgYWRkcmVzc2VzIHRvIGJlIHVzZWQgaW4gYSBwY2llDQo+IHJlcXVlc3Qg
d2lsbCBiZSB0cmFuc2xhdGVkIGFkZHJlc3NlcyB3aGljaCBzaG91bGQgYnlwYXNzIElPTU1VIERN
QVIuDQo+IA0KPiBPVE9ILCBwYXRjaCAyIGFkZGVkIGl0IGludG8gaW90bGIgYWNjZXNzIHBlcm1p
c3Npb25zLCB3aGljaCBJJ20gbm90IHN1cmUNCj4gd2hhdCBkb2VzIGl0IG1lYW4uICBQZXJoYXBz
IHRob3NlIGFkZHJlc3NlcyBjYW4gb25seSBiZSB0cmFuc2xhdGVkIGJ5IEFUUw0KPiBwcmUtdHJh
bnNsYXRpb24gcmVxdWVzdHMsIHNvIHRoYXQgRE1BIG9uIHRvcCBvZiB0aGVtIChpbiBJT1ZBIGFk
ZHJlc3MNCj4gc3BhY2UpIHdpbGwgZGlyZWN0bHkgZmFpbD8NCg0KSSBwdXQgdGhpcyBoZXJlIGJl
Y2F1c2UgdGhlIEFUUyBBUEkgcmV0dXJucyBJT01NVVRMQkVudHJ5IHN0cnVjdHVyZXMsIA0Kd2hp
Y2ggY29udGFpbiB0aGVzZSBmbGFncy4NCg0KVGhlIHVudHJhbnNsYXRlZC1vbmx5IGJpdCBpcyBz
ZXQgaW4gQVRTIHJlc3BvbnNlcyB0byBpbmZvcm0gdGhlIGRldmljZSANCnRoYXQgdGhlIHJlcXVl
c3RlZCBhZGRyZXNzIGNhbm5vdCBiZSBwcmUtdHJhbnNsYXRlZCBhbmQgc2hvdWxkIGJlIA0KdHJh
bnNsYXRlZCBvbiB0aGUgZmx5IGJ5IHRoZSBETUEgcmVtYXBwaW5nIGVuZ2luZS4gVGhlIGludGVy
cnVwdCByYW5nZSANCmNvbW1vbmx5IGZhbGxzIGludG8gdGhpcyBjYXRlZ29yeS4NCg0KPiANCj4g
U2lkZSBub3RlLCBpdCBtaWdodCBzdGlsbCBiZSBtb3JlIHJlYXNvbmFibGUgdG8gcHV0IHRoZXNl
IGNoYW5nZXMgaW50byB0aGUNCj4gQVRTIHNlcmllcyBhcyB0aGUgZmlyc3QgdXNlciBvZiBmbGFn
cy4NCg0KWWVzLCBJIGNhbiBkbyB0aGF0Lg0KSG93ZXZlciwgdGhlIEFUUyBzZXJpZXMgd2lsbCBj
b250YWluIH4xMC9+MTIgcGF0Y2hlcywgaXMgaXQgYSBjb25jZXJuPw0KDQpUaGFua3MNCiA+Y21k
DQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+Pg0KPj4gQ2xlbWVudCBNYXRoaWV1LS1EcmlmICgyKToN
Cj4+ICAgIHBjaTogQWRkIGEgbWVtb3J5IGF0dHJpYnV0ZSBmb3IgcHJlLXRyYW5zbGF0ZWQgRE1B
IG9wZXJhdGlvbnMNCj4+ICAgIG1lbW9yeTogQWRkIHBlcm1pc3Npb25zIGluIElPTU1VQWNjZXNz
RmxhZ3MNCj4+DQo+PiAgIGluY2x1ZGUvZXhlYy9tZW1hdHRycy5oIHwgIDMgKysrDQo+PiAgIGlu
Y2x1ZGUvaHcvcGNpL3BjaS5oICAgIHwgIDkgKysrKysrKysrDQo+PiAgIGluY2x1ZGUvc3lzdGVt
L21lbW9yeS5oIHwgMjMgKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAzMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IC0tDQo+PiAyLjQ5
LjANCj4+DQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0KPiANCg==

