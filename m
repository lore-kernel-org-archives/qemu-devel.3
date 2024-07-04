Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA1BC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPO8n-0005Wv-GB; Thu, 04 Jul 2024 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8l-0005Wb-1q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:12:55 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8i-0002sf-8P
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720105972; x=1751641972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iBpkynY43mL8XVpRQnuzbD1QM2hvJ56uVWjBhaZKJG8=;
 b=aEwev2yvboMjsxfSW5hhl730nUtVyF+l2TNQN+ww0Sj9fHS1igIgN4vz
 sgyp7uN9jIURU/G9GACVNeBjdv0FlOdZp+1EaqsjtWqHddoBVcw8i3AcO
 +9Yzb9WqV7y9r5zGRgzseyKYl9eJVcW5TLNUVsxRmZhgAg/mDiJFm9jCR
 ys+EgFJYgho0uS2RXbFPma19jNZg7Uf/1qkCLDV0PJq/nWQp6IS9w6Qca
 TxmLepd7tVDUpb3YcZbzbhgQl9TYRU2nn1fzrb6GcuBjM+X8LKnqWJjEd
 FljrehuMFco8kmXlujQLKuGyUAhA4WFQm4NJJ9gsy1JGFMKFYAMaJ+OYO A==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="16007273"
X-MGA-submission: =?us-ascii?q?MDE+f+j2sBrgrESUPvTtDkOgbPpwntNHhiTMWU?=
 =?us-ascii?q?vzFvhOiSnoHeB0c1JPs/WDJjDHNgvernO0cjMgJmaQLYeCVG/GPIeOXj?=
 =?us-ascii?q?4G5O1+V0fRSkv9u+u2lyjhP1OOKR87njb8yLQJFWwheIfL2FwgVQm7j0?=
 =?us-ascii?q?Tv4uqRk78xRtn7rr3nXebhKA=3D=3D?=
Received: from mail-db5eur02lp2104.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 17:12:50 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjwmznCH+oubcacRiQwB3iD9vmFBrCdnDpZ2fSjtoRnFXSL5DUSdrwblOdraY0wNtdmSe/aCRk5R6nb5SJenIF1glZUQWGW+kpK0U7vm4xd5B0m0XxH6M60R3okBF4V014q8f0p/A+jwloBakyEKlzy+Y7aGXDgG0j7tXy5qgLHTTtGdqNwmK4M6I8739+inD/IXgWzVcU3IvJM4d+vIufoQxJ2XDt9u7xs3YCxTMQAA/K+xr+YqGfgTTxetTpvPZELF/4XzJljBSKb4E1pX8FAl+L36/fC3mGtoDxhwfyBxJg+IekVC1FVH0IXxWmu/twWPqG+eBl54dI+A8w7eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBpkynY43mL8XVpRQnuzbD1QM2hvJ56uVWjBhaZKJG8=;
 b=BFlJKNYpyDxct7f1WFuMjvH+g7YsFuVEObisZ3ii3XSxaC+pPvrPjfC039E+jzFmfLcVTrPw+jx6o5mVEfvBOl3R0za+7By9vBpStJUwGmORzP9/BqPBIJEejXeEGV2a9OQUxYDjyCgYlrB2VJOhODmIVfdDQmIJ7b5XAiG3U8ET4HXKJNIJD58lTHdxJXvLH4ttUevONxHJ2WkwaazbNNSPZRMjVL/M5+kp2cdBldXzYq8hDHgBRws7tb5XSu73SA0vGcJtr1GauyOlk8m3yJAYTKNLlOvEqEufgorBLZ1i17kf7nAgsukdNi+/GSiDzLqG95HeC8Qmu7hLSva2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBpkynY43mL8XVpRQnuzbD1QM2hvJ56uVWjBhaZKJG8=;
 b=obEaaGD3llEmidi9L/0z97O0k6qITqUquppDJdYB3Mz32/kU73+zB6iew3LDofLNCEIj4s1dltlKpeAOCHMiXfmIjy9GFr/2k22kpvb9lMTrKBKYkUYIr1osqL9frIDMD+foEW0DiCEFAdaNpSAAvcXRLfryfhAercdjhNF50X27KzGmAqpLU07UacCAMHrEOCsxpDnmtht8ZBKWdQUbRR2M9FWP3uyXhxiEQABkCXBUaAZ/lBsJH4v4oOgF9KrnaIQ3uCwh1dbN1AhaNy9tRnfQDeqN2mxg1nrORw90Ky/WY4FgK2FXsXkHS87wiZQ1EYFimxPP/C+462onDiJ5DA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6455.eurprd07.prod.outlook.com (2603:10a6:20b:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8; Thu, 4 Jul
 2024 15:12:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:12:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v2 3/3] intel_iommu: Bypass barrier wait descriptor
Thread-Topic: [PATCH  v2 3/3] intel_iommu: Bypass barrier wait descriptor
Thread-Index: AQHaziSiPOur2dIIN0e52ufwAoMAAg==
Date: Thu, 4 Jul 2024 15:12:49 +0000
Message-ID: <20240704151220.1018104-4-clement.mathieu--drif@eviden.com>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6455:EE_
x-ms-office365-filtering-correlation-id: 862794dd-7376-489d-9a9b-08dc9c3bc482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGNLWE1RSTA2UGRZYUFaeVpCTWZBaElwTmxUZGFNVGR4cVhMU2hBSiswa0tT?=
 =?utf-8?B?bWljanQ5Mi9GSUVUY3hDZGJTYVhEVGFXbXVMQmtQMGhpcGd4SEd5MDVkZ0Rr?=
 =?utf-8?B?QkdUcVJKam95TUdQSzVaZjZmbjByZG5INTNxT0pUOXNBeEQ3K3FNb2FRQUpI?=
 =?utf-8?B?T3h3UENjSkR2aWNRWHRQVitBNTJBYXBCUHR2STJ1SFIrcXFlcktIRFRDamN2?=
 =?utf-8?B?VVpoWktUZkR3ajQ3QzdtdTFTcFVGTGxkTkpQVFpkWjlZSk13a1huRSthTHBw?=
 =?utf-8?B?SFJ3aDNNZy9rYVhwbEQ5SmMxWkZvVldKeVRvMllDclZsQnBreXF2UGxraGJl?=
 =?utf-8?B?aHpKVnpZc2JNTmp6b3BMYTV2WjRiN3RPTE5FRFFYR1FuZm9WSjF6dlc2RmQ0?=
 =?utf-8?B?K2tyb0gyNVRVejNHY2M5YTJGOFJ1aFNYYWEzNmVnY21zUkFVajM1QmZUaDFE?=
 =?utf-8?B?RlVtVWkvcmprZWE0SkpWZUNpcEtJTGxqaUFWSDRGOUE1TFlPNW9kK21WVkJi?=
 =?utf-8?B?bDZpWWJ1ODh0YUZSVnZtaW04bmprVmlLZHRQbTJhQXhQVVJGL3h5TUtYS3Nt?=
 =?utf-8?B?OWEwRklWYWk4eVlQbEN6QWZ4SFQ0QVVmdmZvT3E3Q3Y3VmN3Ni8ycFRjN2lE?=
 =?utf-8?B?dDMvaUd3a3AwNzRsZGFPSzdrWVlkaEJyQ1dyc1pLVFNvWWVIUnowUjBUY3dM?=
 =?utf-8?B?ZkYreFc4bWNzRUQzNzhwaTFmSDcwQzV1RWJGM21aRUV0YTRYblB1Mm9jeUFa?=
 =?utf-8?B?RnFaRHhBWkV5Vmt4WmsvL25Fa2pjME9UVG5rZlA5V1ViRlA0U3B4M3JILzFT?=
 =?utf-8?B?NHNxb0gyWlZBRi9WLzBtb2Z4TGZlN05ub0pmakZqRzJRbzdqL0U4S1dNbTRo?=
 =?utf-8?B?UElEdmNkVmlkSTRVV0txNkhycnltN3o5Rjh3SFRZNkNWR3ZpR1hRVmRhazFY?=
 =?utf-8?B?SWxIZFBISHVWdFFGQzJ4YVdrOXBoazJvVWpONE1zQmlqbVpSSXhwS0dXcUta?=
 =?utf-8?B?dUkwWHVjZjFaL3JISEU1NFRwSjBnNWRyNW1BaUR3cFV1a3A1RDNEYk4wYkJL?=
 =?utf-8?B?cmQ0TUJ1ZTJPdFFWRjdia0V2S2ZPdFNpUU9LWlZjQ0V4WFpIKzg3RHJxZTVO?=
 =?utf-8?B?SDBETUNZTkNKVllMUEQxVTBDaGtKd1BRTUpRYVRNQXNOME8wM2RMUTA0c2xk?=
 =?utf-8?B?ZDRKalM4VlV2Ymp3VVFyQlJsY1NVU2M2RzJuYmhrUlhBN1lkVEtqTVo4L2tv?=
 =?utf-8?B?STdUaHlpZyt2VXZLNXFKZlJ6OXJ3Y09YRmRla3BpVGRKd3I0Y1VuWmxmQXV3?=
 =?utf-8?B?dlg5WE9rNTVjZUFQTVJCN1dLeHVqWDBackVIWjZFNUVnNGNZQlpwVnlDTjNK?=
 =?utf-8?B?VEI0b0NGQnZpTEcyTEVjL2lrZUg0Y1hLREkyVWl6RGppOUJYODd2RlJpMTlJ?=
 =?utf-8?B?WVMzcWMvT1J4Z3grR0xpOHdrT0loMVZ1YTV6NUdkTWxMa3BvS2ZJSzZEWEFC?=
 =?utf-8?B?MklWdXR3dnZhaC9RRmJpUC9USjlPc1lUYlUxQXA5U2VzbW1OVEZLR25IYTJo?=
 =?utf-8?B?REtEL2U1YVdJRnh3Slh2UUp5NnNoeENqQkJ2KzNGNzdPMkdlTjd2SWRzMVhz?=
 =?utf-8?B?Y1RXZk1WWStXaUtZWlJTSG1OUkh5RXBKbnRsWmpFUDhPYTFNbEpGMXBJWjI5?=
 =?utf-8?B?ZXFyelpvZ0tXVFpMcFVCd2hsc2FQSVVNS3V0REdQK2FUWnQxbnIzT2swanoz?=
 =?utf-8?B?OWpFUnE1cXRucHYyT0JPakI1cDNsWVZrRVM4cllydXFhM0xUS2MyR1NwbHNL?=
 =?utf-8?B?VWtKS2h1VWJSNVc5N2toUkIxRENnL2hDRlJsaGhPbTI4emdKZi9FS1U0ZVUy?=
 =?utf-8?B?eDhaVVdvL0dnUkVXN3F2cm5YakduTFJoKzA1cXFTUlV1VWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1FaaXhFUFM2VFNMSyt4SDRhSzhDRStzTjNZbE5Uc2NjRFFBVkwxR0dUdmpn?=
 =?utf-8?B?M2JYZGxGNGVNMnZtckRUaHZlU3pPMjZNT1pwczVud1lzaXlhZkFYdGdxWVFz?=
 =?utf-8?B?WmZsYy8rQkhMczZOQ0xVQnRTc3pJNlM1eUVycHdCbUVNVFdhVlJadTJ5SUJT?=
 =?utf-8?B?MkNOcmRXYkI1S3VSYUZlcFJtaXVSdFR2WU8zbHg1Qm9VN0J3c1loY2N6Qzdv?=
 =?utf-8?B?SldiaVlXUm1pS004cFh1ZzA0Y0lKWXdvSityaUtQc1krcGpKckE2WXpqTFly?=
 =?utf-8?B?MTl1TXlzS3Fpb2pjVHQxV1Vrc0NncTFKR0lHaWxqTDF4UEY2WFlrV2EvTWx1?=
 =?utf-8?B?Mm12RFAzV1RwZ09FUk0zY3p2YWN1K1d3eFh6a1FwMURPTVhML1MvdWJYQ0dV?=
 =?utf-8?B?VERWR21nVVFGYTQ4RHhMaTNMR0NIeFhqWjFveDR2d3hiczA5YWxSSTNKLzhq?=
 =?utf-8?B?RUNjWUhDckNlaldBV290OHZUV3hoRjhhZDVGSlZ4L2wweEJ4VDdQaktvNEdK?=
 =?utf-8?B?T1l1eWdkUXdERjhaSlNUZHVRcVZLbUh6OFQ4RHF6TTRSRTNNMExZRUowTEUx?=
 =?utf-8?B?am1jbWZXNGoyZ01jUmE1ZjkvaWY5NDc3azlYUnI0M2lJVDZhYnhDUGpMU2Ft?=
 =?utf-8?B?MFhqS1ExS2pPQk9YU0VpRHVsWlRCZnRWNXExeHBzMjE0QUhsL2NSRFhHbVZh?=
 =?utf-8?B?cUV2KzVsRmFCSUZ4ZUZXREVQSjVEWkE5WDJ6T2hrMUszNjdYVU1oN2VHQ1h3?=
 =?utf-8?B?Q282NW5UZzd2eGwyYmhyaHJjRXh5Q3FqU1drVUdYN1V4Y3M4N09LMWYxa2lR?=
 =?utf-8?B?STRZRW1scU5wVUI3NGlFSk5qZkY3WFpaeCtqRk1HblJraFRuL1Y2RGFUMXJo?=
 =?utf-8?B?b1AvSkR4SGFkQ2F4VHBWcUxqdjhGZDY3bDlHUVdwQmpvOWVHdDk1aFR0cVhI?=
 =?utf-8?B?K2d6WGkxWUdXVHJXVlJoWHlNRGlKWlBRRC8wWlYrRGxCVkpMU0w0WC9mOGg1?=
 =?utf-8?B?SW5SQk5CUU5oSzJSMlBmTDVSVTFPbUJrRVlINU5VNHVQckEzdEUzOTF5L1Ri?=
 =?utf-8?B?OWFhTHoxZ09FS2tPbW5YTitnRkZPOG9sREE5VjB3dTJpVWhiYlBDMFFUMmhh?=
 =?utf-8?B?SXhFT3ZZK1U4bDRWbUJYdms4Z2FZVFpsQkZXQ1hVQS9xSkJyQXlxNmRJN2Q5?=
 =?utf-8?B?SlFJa0JxMnVoOERoS2FIRzVUTnczbDZWVlRFemFWckFPRS9vb2dJNkxIdUlt?=
 =?utf-8?B?bmRSckdNdi9aN3hmUjJUVVd4cHJhRGkrMm5zMlcycHIzeUo4bThxZ2l4bm8v?=
 =?utf-8?B?dGEwdzQzV09PK21CTUVqNXNBVUlrWWhhT08zVGgrK01pUG1IUlJLUE41eGFK?=
 =?utf-8?B?QXdyQ0pCMStZRDdzR0o1U0doN3hnejQyWEkyZExIN3pEWkFQRUg5bWFyd3Fq?=
 =?utf-8?B?NHVJZkM4dHNBMUJHYmhlZlBlM0luSlAzVGIreG9ZamxkSVBVcGJ1NmNOYUVS?=
 =?utf-8?B?RjlHQlQreGNieWpNckV1OEVNSVZOSzhnUGlDK21BZkd6eGRTSUFuckpFVmg3?=
 =?utf-8?B?M3UzY3cxOEdwK3FERWdWL0VHMFdxWVBmUzJkSTBLREYxZ2p2eW1xQWdiOHpy?=
 =?utf-8?B?QU51S1NEUGxFcHFyQVhpdjBCc0ZDemQ2bHB4UGlBQU9SRnBDSFlQN01NSEFJ?=
 =?utf-8?B?QlplT3J0Q21PYmdrbHB5TDhCSS9yMllMbnhwTFptQjVsLzlsSHJ4dHFUZXNX?=
 =?utf-8?B?a0RYcFdoM3hxTnBTazRkMDFXeXFoQXVrWnJTZWViUWhGYlFTNVovaVNZWWhV?=
 =?utf-8?B?bCtyZXlSaGkzWWQ3RzRnYStuMXJWNUZlRndNNXVzV3dXdkQwOHB0U1R5STVv?=
 =?utf-8?B?U2RYbmxXbzgrNE9ya0xsZzBVeUxHYW5zZ0E2NHVIVkhNTXdPSTdvTmZkRXNw?=
 =?utf-8?B?SEVoSEd6OVJ0Y2RSSnRmSVpHTWpvdVN2UzVYbHpHcUx5anhxSFUrbDFBbFkz?=
 =?utf-8?B?cC9XMkFEb25GNG5YMDdObVcyQ0hEcitNd0NxWURYNFlIcHFKOHZQN0hLZTZh?=
 =?utf-8?B?bjhleDRDaTR3QXYyT2RrdUJTd0xMOWhQQkJibWRDVUJKYVR2WjFVMkk3d2lK?=
 =?utf-8?B?Q3NsRnNRT1FVM2dzL01wN0lPemVWdUF5b0dHaXd4YmpTYmFTNGtnN3Fncmdi?=
 =?utf-8?Q?VLZGaXG5M5lFH5y8eoTauqM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CA8D6BD41C829419E7823F8B02CA48E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862794dd-7376-489d-9a9b-08dc9c3bc482
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 15:12:49.3463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2T2A0UDX+hx+lVNyijoBAK70/4UIDM8j/soRFrGZNQZorUKSMbCpfO5Zepxj/iDyMIX5ncluERX9JnGjySuhwr0iAOy1t2i0SXNfHmsU7wbsiPhaHE245pni6EoGAHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6455
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCndhaXRfZGVzYyB3aXRoIFNXPTAsSUY9MCxGTj0xIG11c3Qgbm90IGJlIGNvbnNp
ZGVyZWQgYXMgYW4NCmludmFsaWQgZGVzY3JpcHRvciBhcyBpdCBpcyB1c2VkIHRvIGltcGxlbWVu
dCBzZWN0aW9uIDcuMTAgb2YNCnRoZSBWVC1kIHNwZWMNCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0N
CiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA2ICsrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggYmUwY2IzOWI1Yy4uMTJlYTNhOWFhMCAxMDA2NDQNCi0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpA
QCAtMjU2MSw2ICsyNTYxLDEyIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3dhaXRfZGVzYyhJ
bnRlbElPTU1VU3RhdGUgKnMsIFZUREludkRlc2MgKmludl9kZXNjKQ0KICAgICB9IGVsc2UgaWYg
KGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19XQUlUX0lGKSB7DQogICAgICAgICAvKiBJbnRl
cnJ1cHQgZmxhZyAqLw0KICAgICAgICAgdnRkX2dlbmVyYXRlX2NvbXBsZXRpb25fZXZlbnQocyk7
DQorICAgIH0gZWxzZSBpZiAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVNDX1dBSVRfRk4pIHsN
CisgICAgICAgIC8qDQorICAgICAgICAgKiBTVyA9IDAsIElGID0gMCwgRk4gPSAxDQorICAgICAg
ICAgKiBUaGlzIGtpbmQgb2YgZGVzY3JpcHRvciBpcyBkZWZpbmVkIGluIHNlY3Rpb24gNy4xMCBv
ZiBWVC1kDQorICAgICAgICAgKiBOb3RoaW5nIHRvIGRvIGFzIHdlIHByb2Nlc3MgdGhlIGV2ZW50
cyBzZXF1ZW50aWFsbHkNCisgICAgICAgICAqLw0KICAgICB9IGVsc2Ugew0KICAgICAgICAgZXJy
b3JfcmVwb3J0X29uY2UoIiVzOiBpbnZhbGlkIHdhaXQgZGVzYzogaGk9JSJQUkl4NjQiLCBsbz0l
IlBSSXg2NA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIiAodW5rbm93biB0eXBlKSIsIF9f
ZnVuY19fLCBpbnZfZGVzYy0+aGksDQotLSANCjIuNDUuMg0K

