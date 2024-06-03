Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583FEC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jf-0006ht-B5; Mon, 03 Jun 2024 01:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-0006gD-7i
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jc-00072k-6W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394396; x=1748930396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gWVNYX/MpMFgcCoU385Nd8NDwrCYBKIzBBh30rldG68=;
 b=HV9Ce0wRqyk/QlNU/z2+IZAtnnrhs8x8v6LeEcpDEKc2uCGG1LXv4Nir
 +C+imaVyurRjN0NIFApx0yQ1Dzhm7YG/Rx4/N16SUbI3G/6x/1NQTTUTj
 c/ikKSlQWkz01z428rV29imbF9RfhrCPpoCeJ70Mfu5kWU6iCb5iVfwQt
 dDX9vE3b/Q4VhBDhANhswH7mgNS37wVMAr/LbmnAzQJh5/05Vd/0dvUi3
 8YA9xn4ejg4eJmdDlowzJcy+zlNRaTA1FN59/tm5oqJx1KZB3o1TWWkPZ
 A59r8qr9sxcDa1QTegNqOxOf/nv9yD+kOcrh9gKi2ZYpi7CUqqztBve8y Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13756561"
X-MGA-submission: =?us-ascii?q?MDHdZn81XFxEB4PHTkmR8O6trXDhmpg6IAkfid?=
 =?us-ascii?q?2zXxRW30/C57i3cLr3E0F0xZzpT6A4Qt01dtewCnQtV4VcJM5kVugWud?=
 =?us-ascii?q?tVLDVepg8fBdPykGLdoyLdf9uYFhJgGITdpiDwhneNrcEyn18OyOZUTR?=
 =?us-ascii?q?nB6juzvyIv+NReFYlIh6YaNA=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a69q8C8ImR+mM2QXFYDzd4WIO4h6gXXteBZnUw0g8Q1X1RJAv9PBPO+XcjfUBuNvvVk5GK2vcDNcW7QJPNyJYfwfbLNynpE4yBcvyTSgtSpoUmtjF3xGesDW3gmLqWuhWI7HRU86fFdImpsdP7LDHJlLTtDKZDX9lEK8NqcBstVSNwdBKvWyNvmNRrnTKTy9zu2RNY1U5Tt26O8XsCD0VWPcm3XGduN2L6m9ApDRBDuWwNe6sDU1X/+yKVUyr6ByikTDjntXPFKZtpAxmR5Ko/PQEhCxvIoFv9SYryEut6l9DUIsK8fcQbMYQ35xhgua4+z9Fd7WR9BwAe0W70I4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWVNYX/MpMFgcCoU385Nd8NDwrCYBKIzBBh30rldG68=;
 b=aLio07bovCobLuY4ZJYtF6qB0TrtA5SdSCt6cXQyfaqS8nCghttpI5BMTqtL8xXi27X4Vdd6HmqN2/1IAZcC7yKoA16iekVIN7WQCiDJP+49XKRtT19Gn9/OH5Dy3azgsccU67dboSgpLgI+l07Na6eexnjxXdhaRePn5u7G+khEAz7wSaxoMtVUeR0+KiF8oY2yt8KJIkxNf5ZjfQWYmUsCnfQqCcAAsD2FwZXi6W9SrXTHCMR/EleKOvJ2U2lXuV/yHWxlfiuEXljZEOcukzKz/MdDIsDTMQ9lyMVImyLfaGpnz61Jgj3y7nxvNF7j5AyQ/ZqWsl13ceYoLf9TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWVNYX/MpMFgcCoU385Nd8NDwrCYBKIzBBh30rldG68=;
 b=jI1sAC1TANdRbgslxjxiQsvV4DQmoFAu1ByAG1SM9iqv6dHPsMhQPqet+D13YW8HZD2Ed8rctbr1BBUtGsL6gqlpm03lJcnzs2sFwIyiBK4xVA9dpyvygQS9/ue/JUsObpl/dN1qf8HWFiya7iHBR8gB8Dq+DjOhk0Vu/AdLDYUnwG5MSh7etkaPQCm3Ahk7NO8pXE4xF3cQoJQmHhT99Dy2Wk61QyEvHlL/q2kINvqz5pbzDR8z2PzbU6Uq0YqgXBOMKcAuFuPvPu/nuWwoanZ564uj1Xuao0qXDBh49AdO6ILoh2yV6coonDrP3ILINeNEJXIl5u+u8OYj9jiNmg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 13/22] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v5 13/22] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Index: AQHatXs+h3ISnltAY0KL22WmbHxAlA==
Date: Mon, 3 Jun 2024 05:59:49 +0000
Message-ID: <20240603055917.18735-14-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 37e77897-2726-47bb-3e8e-08dc839260bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TnNUdzZWcFh1RXNxUTNGWThxOXREeFlVNGthajQvdEJsSHZ1c3Q1V3VLU01i?=
 =?utf-8?B?QjZIdnFzTXRTYmdNTEw3d05nOW04RkxSNHpGQ3JaeWFlRFo4aUdFTnJSL0Vh?=
 =?utf-8?B?Y09OOXVGMUlzK0RGRDlUYjA3WU9CV3ZjTWRBRk5lMmM3TWtFUFZRUi9aSmZs?=
 =?utf-8?B?ckk0M042WXlEckVaTWsvU2l5Nkh4UjZqMzMzMzhIZWhUTEJtMUVSelBqRkJD?=
 =?utf-8?B?N0g0VXpmaWd4NnZRMFZIVjdSZjRhSG1Xa2FuUnRtUnNNRHdlZFg4VGs4eW9u?=
 =?utf-8?B?dnAyOXE0MGUzUGhRazZiUmxBSjhQTVFwRXNCYkdGVmZEQkNOOHVaeFFISi9Y?=
 =?utf-8?B?RzRsaVlrMmo2N0UxNEpwUDFuMGpVR0M3RmNxMWxRZW1WVVMrcE12VXhMaDdD?=
 =?utf-8?B?OXVqODIxangxUkZZZ05DM0QvSVZiZ0dNQkY5OU1DRWlUb0t1TXllL2tncm5N?=
 =?utf-8?B?Z1BYYmRIQnB0UGx5K3FNZ2t0YkxIR0swcnBrbmN4Y3ZQVHdvSnB0SnVIYnhy?=
 =?utf-8?B?Ykc3T3lSeko5ZHg2VDFTWTV2ZWtHZXB3VlNNK2tkQU1sRjJFZW14elBkdU83?=
 =?utf-8?B?K2wyeklGM012TjJGVERNWHR4anJ6bDE5c2RBV0VSL1U5VFE4WEoxZUo3czZ6?=
 =?utf-8?B?WmdDenRVZGVMUWFLcm1JbHZQUzRjOXJuWXRIUUtDbXdrRnFRZ05lWUk0ZE1w?=
 =?utf-8?B?eUVWOGN6QlJEeEQ5bEJCd0lESVpSYjFadEh2MUdDQVpqclIrWGRBTWNmZ3Fp?=
 =?utf-8?B?cmJpYWQvYTNZbjNZZVJpeE1WYTd1SFVzYkprcC9QblpqWDl5SkRxNTgzdTAy?=
 =?utf-8?B?YVJqWGlTUGEzaU03b21OV2h0TFUzRDBvckIyd1pqZTJjZzBCcEk2bnVpUzF1?=
 =?utf-8?B?Vit4ZTlJckJkV0wybTlCeUJLK081V2dwWmpFVHdjWFFKVmVKemtPTE8wdzB0?=
 =?utf-8?B?dVc0YjBIRVJzd05ubXNmaVlSVDZzN21ZcVhkOEJidVhlYlhNZUJveWxNclVN?=
 =?utf-8?B?ajZUaFl2WTB1cXl0TVNtRU4xKy9xVVZGNmdXVk9JL1NoT0NHeEFTS3laWHdu?=
 =?utf-8?B?REVxVTFybEQrVUpNVmZ2Vkd5TDM3NFF1TTl1Rkw4L29tRmdlSmlkVnJDdHg3?=
 =?utf-8?B?Q0JTNytMM0VKWWluZE5hUi9nRTRDdWs2YkY1eDlUclNXZWM0SDZtSFdGRHJL?=
 =?utf-8?B?dTYvVk52ZWhxV2RsRTY4eEFRZHMva3FZVjR1d2dtSGpSVUEwNVpoenF5R2dv?=
 =?utf-8?B?OGc0aUVYeXJqSVJvRXd0VjVrV21HcjkzQU5ZaEZ3Q1VTTFRmNUVacE9weERW?=
 =?utf-8?B?djZ0VVBTMFVCd0FqazZIS3RhaHVsQXJnelNTNzJqS3hPQTQ5QUkyZmM5VUVR?=
 =?utf-8?B?NTk3QlNZeHRNMW52M01ZVldGd2dXOForRCszMUc3MzE5WEJ4cDVHb05yOGtr?=
 =?utf-8?B?SFl2WHlXU3hFOERaQ3hhdS8xS1lhbmE2cXdpLzVtVzlENnV0OHZnYm1QeTl2?=
 =?utf-8?B?NkNkR2ZIK2NsTkFiR2d3eVB2K0VNMHpWOFNlM1dQNUhKSHhIVjM4THRvV0xm?=
 =?utf-8?B?S2VRSFpmWER6WTVqb0ZsOHp5cmZTNFgvb0EwQTU3WlRoZ2I0c3dVeWtrckNv?=
 =?utf-8?B?OFFHT3pjU2M5elZjN1o2cUNYT2hNTnN6eU5NWXFlZ2JlN3hYaVlONTlhNm1y?=
 =?utf-8?B?SDNGSkJNR255ZFJpWGlIYUp0YnhPTWNML1hEd2dnZ0Z0cXZUTkNjZmlqSHg0?=
 =?utf-8?B?anVFWGFjTHpkZnVWSlZVMC9BUEp1a29tRE83d2ZhbW5MYkpVR25HUTNHcUdv?=
 =?utf-8?B?Q0FmRFZDbjlQTnQzNzJxUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3hpZDJkOHQ5OE5jdUFac2xhZGdGKzdLUW82a3BOU1pvSllEaG5BMHVZVi8w?=
 =?utf-8?B?Z3RFUXBTMnNPVk1YcUpvWEJ2Y3gwOXBQekhneXVTK1ZqaUJQdUVIN1ZHZEVU?=
 =?utf-8?B?N2tUd1ljVWJYSVBMaG85KzdOdWpkWGJzQkx3a2FkakYvbFhtUk9odzMvZnYv?=
 =?utf-8?B?RE54WFp5YkxXb25RdmMraXl3T1lMVFdvdEFDTEc2eTBrVnlmY3lVU3FIeDNs?=
 =?utf-8?B?V0RFQzNabDY4YXY3eHEzblZldWJLcmw3MjltWVhEb1JUYmRJdGZyZHBMMnR2?=
 =?utf-8?B?dTZuQ1h6YlVCTjNOQUJ0M0hoUnM3eUREcHV0TktDbFNBQkRabU80bmc1VlNT?=
 =?utf-8?B?T1BLUWJtd3YveGUyQlcwU2k2NzNxZllxaFYyeXEwaGxXYlVJMnNBaHdYaWdk?=
 =?utf-8?B?QzBQbXc3dUxlcnBqeXRseDNzSjBUWUV4MFMyeERCZ1ZnUlhlcHZmTGx3cDJS?=
 =?utf-8?B?ZzdhUWxlRVRZMnp0WW9CYWlnREpxWVlLc2dmZms1K3BpTUZEMGFjRS9LWVFD?=
 =?utf-8?B?UEM2Q1Boc3VTYVh4WndMTFE2cEE1NXpuVzdKUGZRWTQ1Z2RMbFozSmlqYnUv?=
 =?utf-8?B?ZkRqdEg0c0JjSHVSWHZ3RmhaL283aS9YLzNoa2FCQmFSeWo2R3pCdTI1TjJQ?=
 =?utf-8?B?R09kQ0hLSkxaVjIzUnZzeW1iRjRDUTlMdzkwWHJPeExhbjl3Z2lUaUxVaVhR?=
 =?utf-8?B?aXFJT2VlR084SXlCbXVUQWkyODYrd1hwMGFiK1BHeUlxRnR5WXZIZE90Qnp1?=
 =?utf-8?B?WUtzR3R1Zkh3dWpEbzBieHJlS1RSU3ZnYWR3aCtCNWZHQ1ZCVUhkbDZRVDM3?=
 =?utf-8?B?Tjk2bVpHL0t4RTQ5T2xzUHY2T3dNM3pqUmp5ODVMaUNsb0tOSFlSblQ3bTF6?=
 =?utf-8?B?Wk5hZWtLRStHU09pdENZU0p3Qnk2OUVSNlNRYkJNdW0yNzEzcGZBMzBhQlBN?=
 =?utf-8?B?NHJIK2Z0KzZnTzNaUHA4MXBmOFlhQkhCSGw2VGJIRGpxZ045NEpuOXJuVWor?=
 =?utf-8?B?MW9aWit5V0dFbHlONE0rcWdqdE5XdnE0cEIxYTZwOW9lVkx5VUQwK0l4T1lH?=
 =?utf-8?B?dDBGVDdIQnNFNFR1bzVwakRvZnJuQ2Qwc2V2ZzZjY0xJTWFKMXRzSERJaTNw?=
 =?utf-8?B?YkVMTUpNSjFjY3dSWCtWV0NiOGtZcU13MWU3VnhTczlEZEtDR3djdG5yM1Ar?=
 =?utf-8?B?NXdoQW1OMVgvV3VjejVlaHVLZ0RCMi8zZDByT3NCWkhrZ2EzamJldHNOWDNv?=
 =?utf-8?B?ZnN5M1plK0NvL2x2YnNFSjVidGlkREVVMVJzSW92MkVWRzFFYXYvMCtRZ0pO?=
 =?utf-8?B?WEVRYkhqbmR1VnFLVitHUVQ0ZWkxa0dxVmlNVWpYbmVXcndhZGNWUWdYWWJW?=
 =?utf-8?B?R1dlK1M1ZGREQnlNMjVxNk9KNDh1blJmSjFFK3BvaXFNZUR0eWNHL2o2dlRr?=
 =?utf-8?B?cVFjSGptL0lQeWpLTFNzRjFXdmxpQTRWSzJYRHNCTTVNOEd5RXdycldZWmhY?=
 =?utf-8?B?SG5ZcnNGdFk5Ym1qZ04yZmM2K1pPRUNOd3orZnJaWmZnMXA1NTVhMUh1ZXVX?=
 =?utf-8?B?WVNWWmxMYTlkRXhIVTJ6MkFWL1kzMFpjcmErWWZ5SXFNcmNKOExlMzZ1WEZq?=
 =?utf-8?B?bGwyWFlPMlBNb3o2VmxXQnlCbzF5Nm9YT1hJVXVjejAyM1lXUFVkSGgrMUdE?=
 =?utf-8?B?RXl1M1JwaDdpUENLTEtXcmlETEJnYUFTZ1lEdzZ2KytUY0lRRTJFMlpUWTZq?=
 =?utf-8?B?N0ZPT09yS3dnaEhTYi9XbnJCVFNxNmo3N1RhZDJGYSs0V2VlRXR1cURaR3NB?=
 =?utf-8?B?aExDbkhFeWVlRW9rc3RpNXhnZVpHWlBwZmJwUVJEaWZpMnRGWndvd3UrRWwz?=
 =?utf-8?B?dmZyTFAyenRNNHN2cFh6Z2JtZmZpWmM2UG9ldlpmRDNlZzJGRVZIV1lCcGZk?=
 =?utf-8?B?bEMzbk01ellhSEdlSTduc0RRSG9FOWpXbkRBU2MycDFPTVYxL2g4WXo1bldr?=
 =?utf-8?B?T09xd28yMnpvV1hHVkJLbTQxRGloaTh0YS9nUzdLTlo5dGdLZjl1eTZ0b0Yv?=
 =?utf-8?B?OGNLUjhJaGNoR29TdDU5SE5PQnkySkxkV1dBazI1djJLMzkzSGI1dlpnNVpL?=
 =?utf-8?B?bDhhQ0pRRVFpNnhjNHhHNEZSTnlaN1VpaE1wMGhiZ3pqVTN1WXk3WXVPQjVL?=
 =?utf-8?Q?ljihmO0VQejxV6SZBWiFyTA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6601134DB7C8C4594A3574B92339356@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e77897-2726-47bb-3e8e-08dc839260bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:49.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtgX0c1li+6eRkbZNJM7ZyMA6KpI26GmuzcNXNgzj34+otCbJAWnuxotZhglIUIngIykGY9gdwc+5TuTPyEehTqiJufcHMpSng6EW7/3HECisAHoV7ZajL/YVXAGVtNz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgfCAxMyArKysrKysrKysrLS0tDQogaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
fCAgMiArLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KaW5kZXggZmI2YzdkMWUzMy4uNmE2OGRmMDE1NCAxMDA2NDQNCi0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNTQxNCw3
ICs1NDE0LDcgQEAgc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyB2dGRfbWVtX2lyX2ZhdWx0
X29wcyA9IHsNCiB9Ow0KIA0KIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVs
SU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IGRldmZuLCB1bnNpZ25lZCBpbnQgcGFzaWQpDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCkNCiB7DQogICAgIC8qDQog
ICAgICAqIFdlIGNhbid0IHNpbXBseSB1c2Ugc2lkIGhlcmUgc2luY2UgdGhlIGJ1cyBudW1iZXIg
bWlnaHQgbm90IGJlDQpAQCAtNTk1OCwxOSArNTk1OCwyNiBAQCBzdGF0aWMgdm9pZCB2dGRfcmVz
ZXQoRGV2aWNlU3RhdGUgKmRldikNCiAgICAgdnRkX3JlZnJlc2hfcGFzaWRfYmluZChzKTsNCiB9
DQogDQotc3RhdGljIEFkZHJlc3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVz
LCB2b2lkICpvcGFxdWUsIGludCBkZXZmbikNCitzdGF0aWMgQWRkcmVzc1NwYWNlICp2dGRfaG9z
dF9kbWFfaW9tbXVfcGFzaWQoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBw
YXNpZCkNCiB7DQogICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCiAgICAgVlREQWRk
cmVzc1NwYWNlICp2dGRfYXM7DQogDQogICAgIGFzc2VydCgwIDw9IGRldmZuICYmIGRldmZuIDwg
UENJX0RFVkZOX01BWCk7DQogDQotICAgIHZ0ZF9hcyA9IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMs
IGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KKyAgICB2dGRfYXMgPSB2dGRfZmluZF9hZGRfYXMocywg
YnVzLCBkZXZmbiwgcGFzaWQpOw0KICAgICByZXR1cm4gJnZ0ZF9hcy0+YXM7DQogfQ0KIA0KK3N0
YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21tdShQQ0lCdXMgKmJ1cywgdm9pZCAq
b3BhcXVlLCBpbnQgZGV2Zm4pDQorew0KKyAgICByZXR1cm4gdnRkX2hvc3RfZG1hX2lvbW11X3Bh
c2lkKGJ1cywgb3BhcXVlLCBkZXZmbiwgUENJX05PX1BBU0lEKTsNCit9DQorDQogc3RhdGljIFBD
SUlPTU1VT3BzIHZ0ZF9pb21tdV9vcHMgPSB7DQogICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0
ZF9ob3N0X2RtYV9pb21tdSwNCisgICAgLmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkID0gdnRkX2hv
c3RfZG1hX2lvbW11X3Bhc2lkLA0KICAgICAuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfc2V0
X2lvbW11X2RldmljZSwNCiAgICAgLnVuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfdW5zZXRf
aW9tbXVfZGV2aWNlLA0KIH07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KaW5kZXggMGQ1YjkzMzE1OS4u
YmFjNDBlNGQ0MCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQor
KysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KQEAgLTMyNSw2ICszMjUsNiBAQCBz
dHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCiAgKiBjcmVhdGUgYSBuZXcgb25lIGlmIG5vbmUgZXhp
c3RzDQogICovDQogVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0
YXRlICpzLCBQQ0lCdXMgKmJ1cywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZGV2Zm4sIHVuc2lnbmVkIGludCBwYXNpZCk7DQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCk7DQogDQogI2VuZGlmDQotLSANCjIu
NDUuMQ0K

