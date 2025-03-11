Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E863DC282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trpqK-00043e-Cr; Mon, 10 Mar 2025 22:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1trpqI-00043Q-10
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:59:42 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1trpqE-0003DT-Nd
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1741661979; x=1773197979;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GaYTGRLj8N5DX4K3WAUXYnJdcyaXIQzKiS9BCyRv10A=;
 b=qpL74SylGO12bC9A7eXWerVVRGBZbW6KaA+TngQPxfQNecVhr4zxvxRH
 4Gpn+M+uT0ZK9iFxZYZHvlN0CkrPe969jlldCu7jTto6HM3M5mxKuj7bj
 KLbCiZZ8VdQCrXEHPjskDtZI7YhUXBgSNDwyiPxtQkDWih7pfYWCDXKvI
 EQ/9gy3dS8PQAPnbIwwk1mDAnZeKLKotlX1FJrPRXo0n2Ojp8XoXifPH5
 5JaMX/7AYMStSpJdptFE6cCS87BMKV//Qo6JQ0sbSWXyoMnFGD3FLBTvi
 vYdWx2Mk+uQis7/9M9TFXqsLIYvK7Gna78w7V1JmEFxY56M4/9MFIqmU4 A==;
X-CSE-ConnectionGUID: HE6UCCUkTcepCRzidTijeQ==
X-CSE-MsgGUID: 1aWu/JnZQzusG7yDThBGdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="155329087"
X-IronPort-AV: E=Sophos;i="6.14,237,1736780400"; d="scan'208";a="155329087"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 11:59:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxTNXSQyZZDwNEAERi6nUUKDgDJqR2QYsC0xSCJknM26MdyTFmBqrKmeXazU/psWQZNTwsfAyAdt8Mj6Mk/PWkUjSKKGTqpc5RMcFsd1ocAM/c6D+QlQf8w7daYsI+qLXcKn0UybksuZ2lu7FI2EEld4qcVUbGhDpyVVrNzZdWg5dmnBKJ+IeOo84V5YI/qc9f7h5JZFr/8VeCX924veWC4/59tbvR+wPW2kJiC7w96OTf+wHG7Qsk0+x2hvm4b2yaftJHiI+7dX8SqarsbgPCz8/13fw1YABilzA/1FbJ+1VC+0ak6T+/W28FOP8pS/Tqhm6VUs3MakfHXrfWMwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaYTGRLj8N5DX4K3WAUXYnJdcyaXIQzKiS9BCyRv10A=;
 b=KPxIOPIkjDg/oZ56wfB4Rsjmd6v3FlW3L2Ljbl4uENmWuE5wP+QDyCT3s2vj5PRf7x24BeJAgh9Gf2Z8hmPTZqTsEvo2aVKwoqdKS1+iK4fuM40W5gA2X5kZ+vn8NB15gagSYol2StbER+Pc08VkSGAIwBN2xIZazz1ztjGXZl9GvSeFJvQfSTiok5p+m0pQu2dG5bv+D3BZDt5WZshAUJDXMWBz7Zo8ik2mHx4EJ1mgjSs2G+APHDY2zvZOlv3BZ2ry6m2UIXyXgpjg+sNWh4eAP92oszE8C+hISHe2lcmRvsL7hGEPRZVHsoyyny6AZNzY97arA60kbJVNBVL8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSOPR01MB12363.jpnprd01.prod.outlook.com (2603:1096:604:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 02:59:30 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:59:30 +0000
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Stefan
 Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v6] migration: Add qtest for migration over RDMA
Thread-Topic: [PATCH v6] migration: Add qtest for migration over RDMA
Thread-Index: AQHbki9DDuStFgFbeUqBRN2OWN54rrNtPteA
Date: Tue, 11 Mar 2025 02:59:30 +0000
Message-ID: <41b6d687-926a-4b66-bbec-2b03cd55fa8d@fujitsu.com>
References: <20250311024221.363421-1-lizhijian@fujitsu.com>
In-Reply-To: <20250311024221.363421-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSOPR01MB12363:EE_
x-ms-office365-filtering-correlation-id: c75e8d8f-3723-4693-6e0e-08dd6048be5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?S0N4OTZXN0czamtmbCt3Z1pKQmVPSmlaK2xyckdKUS91cDhBcVc4K2pIWUJ2?=
 =?utf-8?B?aGdsaEROYkpycHVwazFGeFFEdlIveithZDNjT09NbFlZMnBrWGdEVkFIM3FE?=
 =?utf-8?B?c2lPczl2Q3FoODJkY3Zjc2hBQzViS28xejJHbjNGbU5qb0IrVVA2UHlQVkJE?=
 =?utf-8?B?eFFGRzNxU21SQnIwMS8rTTV3dG5GWjYrSGJpcmJLdk1ndFhNRTZWb0ZXRk93?=
 =?utf-8?B?bGdmTTN1c29IVDZCWnpFNHNtb2V4d1AyVm5IYlBjYUJ2ZzdXcDF2WEJMUzZZ?=
 =?utf-8?B?cHgxS2lqOVNNUkxEWUc4V0hFUmFGMG1hYXFQN0NFMDc4K0FuazNIZFNVTWtD?=
 =?utf-8?B?ejRGaENjb24relB4dTl4K09wekpGbjdZOUVGdG9tcWZOelBsY0swM1pMWGVt?=
 =?utf-8?B?K3U3M2xFWXBnZ2VlazErZW5pZTM2SU80QnJoVndNRzUvWDBnUXQzSE1KNFZO?=
 =?utf-8?B?NTlMV3pLY2M3VGVDSjlYUEN3Mm1FZ0RSelJCcGRDMGNkSE4yQlBmS0lCekZL?=
 =?utf-8?B?Q2RzVzVERGVESzNZTmZ3UDJjcC9GamlBK205UlZpcEdlOXR6WXZja1c0RGg2?=
 =?utf-8?B?ZThtQWdIU1RCRStSdUF0WkcxKy9oOVJyZEFEN1Nsb0ZScHRjWmxuNGFWSWtN?=
 =?utf-8?B?bWZMelZVZFJVRktReEFWUkxKTXRaeVkwQjlLWmZJM2k4bkc5akFlYm9Yb3hD?=
 =?utf-8?B?OVE1Wng4c0ZpUEwwZGpsN1VGeVhOaS95TzhSS05kek8vdW5sa25pNWdYWFdQ?=
 =?utf-8?B?NEhIRXR3ZnBmRW9hdmRnNnlqTFVXUit0eE4zNk10SENGTmRKRjMvRXB6SGZK?=
 =?utf-8?B?L0JkVXd5K2FJR2hJdFdnZDI3clgyTFgwR2gwWGU0V2lRb1ZhOWliYW9yeHcx?=
 =?utf-8?B?TnprbVlYMFlrNk9HTTJ5blhWYzJua2w5S1ViNkNZK1pLWDRxNlFkdWxraUxF?=
 =?utf-8?B?TTh6bHRIbFh1QklpTndNT2ppYk5PdmFNMlVzaTZiMnVNRU1kZjhxaW0xb1Z5?=
 =?utf-8?B?azRibXRoTzgydERsUm1PdmJWT2ljZjZOQkJjRUk4NHEvU2xhazN3ZDdMeDBK?=
 =?utf-8?B?b1lWMzFWR3lwYm1JZWNXYWt0SUdLZncvdVVtUGZKWGN2bnc2UGlPYTErOVhm?=
 =?utf-8?B?ZEExc05wRFpiS1lPMHJOMWYrWGI4cWxXc3lvOWVocXF6OFY1MFIyZ2VaV29n?=
 =?utf-8?B?dzVvUktiY3VzRUdFS25vWUQvcFFteHZMSUFWRVlDRmpHcmIwMnVXTnR3STRO?=
 =?utf-8?B?d1hVbTRTOCtKdWwydGdFd2tFemhWKzJieWZ6VWdpU1VTNWZ0THUwU2tjL2Ev?=
 =?utf-8?B?TU5yYmNxcFRIRVMyRm5hYmltOG8xNXdHc0htNHl0eFFNYjE2U0cvcjhPbzFu?=
 =?utf-8?B?SisrWXJDSWtsVi9yQ2htR1RpUWZTWVk4S21YU3J0dFNocUk3UWh5M3NDRVdz?=
 =?utf-8?B?aTlmZ3VTeG1VYkttK1JOYTJIRmZjb0Y5QUlsc1hEQS9VN2ZiVE9oRXp4UERQ?=
 =?utf-8?B?L29Bc1dOM1FmY3NIK1ZGSUt3WGEwazdoU1NoWTE5MVZwMWUwQnhXK05DRitu?=
 =?utf-8?B?U1lYMkJ6cGJZVEZzcnE3NFdTbzEraXY0a2xRUU9hbkF6UFVBdktxd1BhcFJq?=
 =?utf-8?B?THdtZ1RidzduMERuQ1gxYk1JQ0hCbWZ6L29yeldDY3BiN3d2MHpJaWlwSmxD?=
 =?utf-8?B?QWRoaW1vNjhabzRJTUJuT0FrNnczUktjWE55OFU1QmMrYVFRTEY3cEs2ZEx6?=
 =?utf-8?B?cS9kYml3a1V2Z3BIa2Z4bk1CZVJPWStwTW9DQkNTUWJpWXNuNG1XQkV0Qzl2?=
 =?utf-8?B?d2xDa2trWksxUUoyNWJiVU9TVXgyZTdnVjNVN1k2eGUxNG4rSVNtRHN4ZGVz?=
 =?utf-8?B?UnJUT0srcThLeTdWOVl0OG5zbHRNYzZWY2UxcExRYi8vb20vQXU1Q0FrYTYv?=
 =?utf-8?B?VmVGdE5oam4zWTlTNGk5eFVHYnpjUDROeHdLdXh0SnJ5eHJYZ0Q2V2ZCenZH?=
 =?utf-8?B?dnl3ZTF3WjdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzhtQ3U5SGU5c2F4V3hjS2tTblpBQmZsWkdHd1hKTWhGRVMwSHZrTmM2b0Z4?=
 =?utf-8?B?S2tvcXBvZVNtb0FiRFB0YXJrV1lHZXRZWGtwbmEvazRhZXJtTHRFcGJXd00v?=
 =?utf-8?B?azNsKzFnWU9TWmlRTHgzclpPMHNTZm93TGRWL1Y0NzJGNm9ZQ3BsMGVkOEpz?=
 =?utf-8?B?MEZBSGc2Z2w5OHE2eUw3QTVQVTJUVlQ3MGdGaW5ydkJVdGROU0pBMURuTkhR?=
 =?utf-8?B?aktnZjJkMHBiT1ZwWDVoSEE5dEJiWGI4bUNQNVIraW5VMkRHMVZwbXdIUzZz?=
 =?utf-8?B?bHRUOHNIVjBBSTFZN1lmYWRtRCtUdTVzY085SUEvbUl2VW9lcXhuald0VkFi?=
 =?utf-8?B?ZFAvVnRDd29rOXI3NnhpQmRIZkxVbU1PVm0zMWQ3c3VPbGE5WmRWbHV0Q09G?=
 =?utf-8?B?ZFYxcmQwZDNZUkNUS25tUTFaVnRmTi9EQ0prbkNPYjZGZG9veURMK05UQzRh?=
 =?utf-8?B?Y0p4VGZ5b3Qya3loQU9URXo3SHZxTjNEQWRQOUk3YnZYUlhsZU5pNDUrcVd1?=
 =?utf-8?B?TEoyUWJhVHdsNHBIZzhpNzIvSE5WS0RuUFllclVobmRxYnpLcnNJckpvUEto?=
 =?utf-8?B?OXZOMWFTS3JQYW1zcHZ3SDRHME1yemtrZmhaZVg4V3R6VXFWaGVzd29rbERB?=
 =?utf-8?B?LzkzeStJbzMvRHAvNWdrckI5SmgwWlUyaTF0MndHdTJvc015N0FWMHMrTkdS?=
 =?utf-8?B?dDJiMnJzaVZsSzNYVitubHZucEZzeGVSdEMyQU8rd0RNSExIK3RlODdORGRE?=
 =?utf-8?B?MVBlSWF4dU9vU0pITVJSb0tSYzlQYjFpdXR5bThhUzNkckJqQnNmL3ROdFZM?=
 =?utf-8?B?bTFyc1ozR0lEaVJXakI4ei9WOCtTNWhPV0xHRk02YWl2aGZWWHJFSG9acVNr?=
 =?utf-8?B?Z1kxc0pPcFFYbGlKbHBVRGhkYTJRTGFUajlMdVc0QWNaWTlWTWxndmIvYU5r?=
 =?utf-8?B?cTVDbEszcHhPODloQ3dGTFpLWVlRYmVmZFBhYXpOUkl4VTlBckxnekpabkJ4?=
 =?utf-8?B?TmRxVGtMdnpudmpLUy93cnNDN3dQUTBEY1VDTHZUMWluOTAzZE83dEFrYkta?=
 =?utf-8?B?S0pNbzczRDNIZ0lTenRuRklzNVg0OGpMcHorQjAxbTFHVHkwR0hLejVVYWdL?=
 =?utf-8?B?TEpHMENoampqVEV3ZWN6ZEsrTmlpNk9iaTNvcTZFNHdtYUlYY0FIN2N0bUF5?=
 =?utf-8?B?K1JVOUlMTUJsL0ZFZ1FGWWRKeDJUUWcrOXB6QkFRZ1U2aGE2K2p3SkJEdW9h?=
 =?utf-8?B?QmxRZkg0K2kxVU9UaVlTMTNyQVNrcmI2bWdFNjRUdDY2U29zeGhTN2lna2lS?=
 =?utf-8?B?dkVlV1ErRWpEMDdGWGVVK0VDb3RML1dSV3BrUEpoaFNGb1B0TEM5dmZZUk05?=
 =?utf-8?B?bXBqb1VSRk1KK0VlMzNucXFyelNwL1RpbDJWWEVjVW9UMzBreUpjS1RrMEhE?=
 =?utf-8?B?cE9yRk5YbVJmNjBqN2ovc0EyR3VCMWZwbG9pdXhHMXByMzVVUHo1R2svdnNK?=
 =?utf-8?B?UDg1MlVENlJLR29nUmVpb0w3bjRKU1N2ZnFORzlsdWtIbFBMaisrU1RnS21N?=
 =?utf-8?B?ZXNNOXFYTWpXeHY1Z3NzalFCMGF6R2xRaXJXNHRDMHNMU29mcWZnZ01sSkZy?=
 =?utf-8?B?NHpGOWcvWC90MGdxTlFvTzdKMlRwWnZkQXRHTi8xcEhhZUhVblZxb0UzQTJv?=
 =?utf-8?B?T0t5OGpKQytacmx5Nks2b0IrVk9pbFh1RzUyT3BtM3hjNUZBeG1wYTFQN3Fr?=
 =?utf-8?B?WXdpeE5TZ01MUFh2TjliMlFFMEhYbDJjaUZVa2x4YmpNQldhUlk4SUQybVNQ?=
 =?utf-8?B?NnJPSG1iK0d5c2g1aGttVElwamd6d3pXQ3F3ZTlJSjI1WEtrcnpBczlwcXps?=
 =?utf-8?B?c2drOENKVFkxbWxJeUI5RXorSXIwSzlCMHQrYTB2Z2RmUDcvWitUUWx4UHZs?=
 =?utf-8?B?bzl4VUlrS0Jyc2Q5L1J3NXBTbndpODRYcjY2cTdnWGR3TDNKQjhvdkNGZW9R?=
 =?utf-8?B?SnhoSDdHcXRBdEJTRlc5QTRxNGk2eStjZzFIRDg3U0FNWHRmd29NZXhLMkd1?=
 =?utf-8?B?cHVYYXpmMXFxei94TnFPQlhkcTV2Z0V4K09Zam8wN0FsRFJpc3REdWY3NTF4?=
 =?utf-8?B?Y0xjTnRwK04vQlU5TDBaUThQdWNTVGdNY3VxdVdzWmlSS2FONDgxdjNiMElI?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23EBF8BF722B94D83E271D03E08CA6A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: neCpl52XAy5MCvR3h2P1xrKozp5Hn0eHsyp3R15aZwusFdWyZQo06wyHXTAUE4HX2AnSpnbXVwWtT7MQ94uTZ5gZaA0u9EsrsnHk1vuzbJPdKXDxyKatmgC2Py/pCOMyFT7oHxwpBOiIYA3rdCeFZXXGF1R/NrP1l8YCsAGiQO5ZD0lN92lnK4f1g1GfXiZCyl8mel9h/T38ru+iUy0kM3IPqFcPtMKlmiztaev4cpiSv4E7RtM1v2rEJHshmKh0L6SITi9HCexqd+3/3vcj0Z1ftj9SMciLB2NzlC8e/G/YgLR0o1yRpG+WoqYCwzoWBmi52GDvvpOE+qzvcFnss53a8uoQzhNjSc1ZX3VrmpUoUDQPEnidyjGE/uy3pDBjounaftqPxFqCgUOBP2qEmFURuHPp+gFGNwLYoJaNfMwG9FSSWfQt8Xnf3NCwbIoTCXyD2eogK2LU4g4k9ErWtIOMcOPoKjdk362viJLg50niElc+C51OM02sJl+9SYnimd0+qzqE9F4pkzmVVJpKfwTSARMliCr58TWJHEA+cSVJFBo+eo7d//i7huoudfR0RWpaQwMilqB7oiCCbCTDyN25PZwbte7itHb+nrFMaQE9HgPrCt9nSqLXX+gLmv/z
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75e8d8f-3723-4693-6e0e-08dd6048be5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 02:59:30.3669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSwNQs6yIxYjCNEZV+e5s+uBSU5n376eL2L6c93sKlxZCEaHIwpQkEeG/rJZA5JHbc9IRD+eVSIfEtPmMilJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12363
Received-SPF: pass client-ip=216.71.158.38; envelope-from=lizhijian@fujitsu.com;
 helo=esa18.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgRmFiaWFubywNCg0KDQpBIG1pbm9yIGltcHJvdmVtZW50IGlubGluZSBiZWxvdywNCg0KDQpP
biAxMS8wMy8yMDI1IDEwOjQyLCBMaSBaaGlqaWFuIHdyb3RlOg0KPiBUaGlzIHF0ZXN0IHJlcXVp
cmVzIHRoZXJlIGlzIGEgUkRNQShSb0NFKSBsaW5rIGluIHRoZSBob3N0Lg0KPiBJbiBvcmRlciB0
byBtYWtlIHRoZSB0ZXN0IHdvcmsgc21vb3RobHksIGludHJvZHVjZSBhDQo+IHNjcmlwdHMvcmRt
YS1taWdyYXRpb24taGVscGVyLnNoIHRvIGRldGVjdCBleGlzdGluZyBSb0NFIGxpbmsgYmVmb3Jl
DQo+IHJ1bm5pbmcgdGhlIHRlc3QuDQo+IA0KPiBUZXN0IHdpbGwgYmUgc2tpcHBlZCBpZiB0aGVy
ZSBpcyBubyBhdmFpbGFibGUgUm9DRSBsaW5rLg0KPiAgICMgU3RhcnQgb2YgcmRtYSB0ZXN0cw0K
PiAgICMgUnVubmluZyAveDg2XzY0L21pZ3JhdGlvbi9wcmVjb3B5L3JkbWEvcGxhaW4NCj4gICBv
ayAxIC94ODZfNjQvbWlncmF0aW9uL3ByZWNvcHkvcmRtYS9wbGFpbiAjIFNLSVAgTm8gcmRtYSBs
aW5rIGF2YWlsYWJsZQ0KPiAgICMgVG8gZW5hYmxlIHRoZSB0ZXN0Og0KPiAgICMgUnVuICdzY3Jp
cHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaCBzZXR1cCcgd2l0aCByb290IHRvIHNldHVwIGEg
bmV3IHJkbWEvcnhlIGxpbmsgYW5kIHJlcnVuIHRoZSB0ZXN0DQo+ICAgIyBPcHRpb25hbDogcnVu
ICdzY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaCBjbGVhbicgdG8gcmV2ZXJ0IHRoZSAn
c2V0dXAnDQo+IA0KPiAgICMgRW5kIG9mIHJkbWEgdGVzdHMNCj4gDQo+IENjOiBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IENjOiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVk
aGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPiAtLS0NCj4gDQo+IEhpIEZhYmlhbm8sDQo+IA0KPiBQbGVhc2UgcmVwbGFjZSB0aGlz
IHBhdGNoIGluIHlvdXIgbmV3IFBSLg0KPiAtLS0NCj4gVjY6DQo+ICAgIC0gbWFrZSBzY3JpcHRz
L3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaCBydWJvc3QsIGluY2x1ZGluZw0KPiAgICAgIDEpIG9u
bHkgc2V0dXAgcmRtYS9yeGUgb24gYSB2YWxpZCBpcHY0IGludGVyZmFjZSAjIHJlc29sdmUgZ2l0
bGFiLWNpIGFhcmNoNjQgcnVubmVyDQo+ICAgICAgMikgc3BsaXQgc2V0dXAgYW5kIGRldGVjdCBv
cGVyYXRpb24NCj4gICAgICAzKSBjaGVjayByb290IGZvciBzZXR1cC9jbGVhbiBvcGVyYXRpb24N
Cj4gICAgLSByZG1hIG1pZ3JhdGlvbiB0ZXN0IG9ubHkgZGV0ZWN0IHJkbWEgbGluaywgbG9jYWwg
dXNlcnMgc2hvdWxkICdzZXR1cCcgcmRtYSBleHBsaWNpdGx5ICMgZG9uJ3QgZGlydHkgdGhlIHN5
c3RlbSBxdWlldGx5DQo+ICAgIC0gcHJpbnQgc2tpcCBtZXNzYWdlIGluIFRBUCBmb3JtYXQsIHN0
YXJ0aW5nIHdpdGggIw0KPiAtLS0NCj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEgKw0KPiAgIHNjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoICAgICAg
fCA3MCArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICB0ZXN0cy9xdGVzdC9taWdyYXRp
b24vcHJlY29weS10ZXN0cy5jIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMTM3IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUg
c2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2gNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlO
VEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDM4NDhkMzdhMzguLjE1MzYwZmNkYzQgMTAw
NjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0zNDgw
LDYgKzM0ODAsNyBAQCBSOiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+ICAg
UjogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiAgIFM6IE9kZCBGaXhlcw0KPiAgIEY6
IG1pZ3JhdGlvbi9yZG1hKg0KPiArRjogc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2gN
Cj4gICANCj4gICBNaWdyYXRpb24gZGlydHkgbGltaXQgYW5kIGRpcnR5IHBhZ2UgcmF0ZQ0KPiAg
IE06IEh5bWFuIEh1YW5nIDx5b25nLmh1YW5nQHNtYXJ0eC5jb20+DQo+IGRpZmYgLS1naXQgYS9z
Y3JpcHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaCBiL3NjcmlwdHMvcmRtYS1taWdyYXRpb24t
aGVscGVyLnNoDQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAwMDAuLmM0
MzgyMTM0Y2QNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9zY3JpcHRzL3JkbWEtbWlncmF0aW9u
LWhlbHBlci5zaA0KPiBAQCAtMCwwICsxLDcwIEBADQo+ICsjIS9iaW4vYmFzaA0KPiArDQo+ICsj
IENvcGllZCBmcm9tIGJsa3Rlc3RzDQo+ICtnZXRfaXB2NF9hZGRyKCkNCj4gK3sNCj4gKyAgICBp
cCAtNCAtbyBhZGRyIHNob3cgZGV2ICIkMSIgfA0KPiArICAgICAgICBzZWQgLW4gJ3MvLipbWzpi
bGFuazpdXWluZXRbWzpibGFuazpdXSpcKFteWzpibGFuazpdL10qXCkuKi9cMS9wJyB8DQo+ICsg
ICAgICAgIHRyIC1kICdcbicNCg0KDQp0aGlzIGxpbmUgY2FuIGJlIGltcHJvdmVkIHRvOg0KDQpo
ZWFkIC0xIHwgdHIgLWQgJ1xuJw0KDQp3aGljaCBhZGFwdHMgdG8gdGhlIGludGVyZmFjZSB3aXRo
IG11bHRpcGxlIGlwdjQgYWRkcmVzc2VzDQoNClBsZWFzZSBsZXQgbWUgaWYgeW91IHdhbnQgYSBu
ZXcgdmVyc2lvbi4NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+ICt9DQo+ICsNCj4gKyMgZXhp
c3RpbmcgcmRtYSBpbnRlcmZhY2VzDQo+ICtyZG1hX2ludGVyZmFjZXMoKQ0KPiArew0KPiArICAg
IHJkbWEgbGluayBzaG93IHwgc2VkIC1uRSAncy9ebGluayAuKiBuZXRkZXYgKFteIF0rKS4qJC9c
MSAvcCcNCj4gK30NCj4gKw0KPiArIyBleGlzdGluZyB2YWxpZCBpcHY0IGludGVyZmFjZXMNCj4g
K2lwdjRfaW50ZXJmYWNlcygpDQo+ICt7DQo+ICsgICAgaXAgLW8gYWRkciBzaG93IHwgYXdrICcv
aW5ldCAvIHtwcmludCAkMn0nIHwgZ3JlcCAtdiAtdyBsbw0KPiArfQ0KPiArDQo+ICtyZG1hX3J4
ZV9kZXRlY3QoKQ0KPiArew0KPiArICAgIGZvciByIGluICQocmRtYV9pbnRlcmZhY2VzKQ0KPiAr
ICAgIGRvDQo+ICsgICAgICAgIGlwdjRfaW50ZXJmYWNlcyB8IGdyZXAgLXF3ICRyICYmIGdldF9p
cHY0X2FkZHIgJHIgJiYgcmV0dXJuDQo+ICsgICAgZG9uZQ0KPiArDQo+ICsgICAgcmV0dXJuIDEN
Cj4gK30NCj4gKw0KPiArcmRtYV9yeGVfc2V0dXAoKQ0KPiArew0KPiArICAgIGZvciBpIGluICQo
aXB2NF9pbnRlcmZhY2VzKQ0KPiArICAgIGRvDQo+ICsgICAgICAgIHJkbWFfaW50ZXJmYWNlcyB8
IGdyZXAgLXF3ICRpICYmIGNvbnRpbnVlDQo+ICsgICAgICAgIHJkbWEgbGluayBhZGQgIiR7aX1f
cnhlIiB0eXBlIHJ4ZSBuZXRkZXYgIiRpIiAmJiB7DQo+ICsgICAgICAgICAgICBlY2hvICJTZXR1
cCBuZXcgcmRtYS9yeGUgJHtpfV9yeGUgZm9yICRpIHdpdGggJChnZXRfaXB2NF9hZGRyICRpKSIN
Cj4gKyAgICAgICAgICAgIHJldHVybg0KPiArICAgICAgICB9DQo+ICsgICAgZG9uZQ0KPiArDQo+
ICsgICAgZWNobyAiRmFpbGVkIHRvIHNldHVwIGFueSBuZXcgcmRtYS9yeGUgbGluayIgPiYyDQo+
ICsgICAgcmV0dXJuIDENCj4gK30NCj4gKw0KPiArcmRtYV9yeGVfY2xlYW4oKQ0KPiArew0KPiAr
ICAgIG1vZHByb2JlIC1yIHJkbWFfcnhlDQo+ICt9DQo+ICsNCj4gK29wZXJhdGlvbj0kezE6LWRl
dGVjdH0NCj4gKw0KPiArY29tbWFuZCAtdiByZG1hID4vZGV2L251bGwgfHwgew0KPiArICAgIGVj
aG8gIkNvbW1hbmQgJ3JkbWEnIGlzIG5vdCBhdmFpbGFibGUsIHBsZWFzZSBpbnN0YWxsIGl0IGZp
cnN0LiIgPiYyDQo+ICsgICAgZXhpdCAxDQo+ICt9DQo+ICsNCj4gK2lmIFsgIiRvcGVyYXRpb24i
ID09ICJzZXR1cCIgXSB8fCBbICIkb3BlcmF0aW9uIiA9PSAiY2xlYW4iIF07IHRoZW4NCj4gKyAg
ICBbICIkVUlEIiA9PSAwIF0gfHwgew0KPiArICAgICAgICBlY2hvICJSb290IHByaXZpbGVnZSBp
cyByZXF1aXJlZCB0byBzZXR1cC9jbGVhbiBhIHJkbWEvcnhlIGxpbmsiID4mMg0KPiArICAgICAg
ICBleGl0IDENCj4gKyAgICB9DQo+ICsgICAgcmRtYV9yeGVfIiRvcGVyYXRpb24iDQo+ICtlbGlm
IFsgIiRvcGVyYXRpb24iID09ICJkZXRlY3QiIF07IHRoZW4NCj4gKyAgICByZG1hX3J4ZV9kZXRl
Y3QNCj4gK2Vsc2UNCj4gKyAgICBlY2hvICJVc2FnZTogJDAgW3NldHVwIHwgZGV0ZWN0IHwgY2xl
YW5dIg0KPiArZmkNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9wcmVjb3B5
LXRlc3RzLmMgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jDQo+IGluZGV4
IGJhMjczZDEwYjkuLjU1N2I3ZjNhYTcgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3F0ZXN0L21pZ3Jh
dGlvbi9wcmVjb3B5LXRlc3RzLmMNCj4gKysrIGIvdGVzdHMvcXRlc3QvbWlncmF0aW9uL3ByZWNv
cHktdGVzdHMuYw0KPiBAQCAtOTksNiArOTksNjggQEAgc3RhdGljIHZvaWQgdGVzdF9wcmVjb3B5
X3VuaXhfZGlydHlfcmluZyh2b2lkKQ0KPiAgICAgICB0ZXN0X3ByZWNvcHlfY29tbW9uKCZhcmdz
KTsNCj4gICB9DQo+ICAgDQo+ICsjaWZkZWYgQ09ORklHX1JETUENCj4gKw0KPiArI2RlZmluZSBS
RE1BX01JR1JBVElPTl9IRUxQRVIgInNjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoIg0K
PiArc3RhdGljIGludCBuZXdfcmRtYV9saW5rKGNoYXIgKmJ1ZmZlcikNCj4gK3sNCj4gKyAgICBj
aGFyIGNtZFsyNTZdOw0KPiArICAgIGJvb2wgdmVyYm9zZSA9IGdfZ2V0ZW52KCJRVEVTVF9MT0ci
KTsNCj4gKw0KPiArICAgIHNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCksICIlcyBkZXRlY3QgJXMi
LCBSRE1BX01JR1JBVElPTl9IRUxQRVIsDQo+ICsgICAgICAgICAgICAgdmVyYm9zZSA/ICIiIDog
IjI+L2Rldi9udWxsIik7DQo+ICsNCj4gKyAgICBGSUxFICpwaXBlID0gcG9wZW4oY21kLCAiciIp
Ow0KPiArICAgIGlmIChwaXBlID09IE5VTEwpIHsNCj4gKyAgICAgICAgcGVycm9yKCJGYWlsZWQg
dG8gcnVuIHNjcmlwdCIpOw0KPiArICAgICAgICByZXR1cm4gLTE7DQo+ICsgICAgfQ0KPiArDQo+
ICsgICAgaW50IGlkeCA9IDA7DQo+ICsgICAgd2hpbGUgKGZnZXRzKGJ1ZmZlciArIGlkeCwgMTI4
IC0gaWR4LCBwaXBlKSAhPSBOVUxMKSB7DQo+ICsgICAgICAgIGlkeCArPSBzdHJsZW4oYnVmZmVy
KTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBpbnQgc3RhdHVzID0gcGNsb3NlKHBpcGUpOw0KPiAr
ICAgIGlmIChzdGF0dXMgPT0gLTEpIHsNCj4gKyAgICAgICAgcGVycm9yKCJFcnJvciByZXBvcnRl
ZCBieSBwY2xvc2UoKSIpOw0KPiArICAgICAgICByZXR1cm4gLTE7DQo+ICsgICAgfSBlbHNlIGlm
IChXSUZFWElURUQoc3RhdHVzKSkgew0KPiArICAgICAgICByZXR1cm4gV0VYSVRTVEFUVVMoc3Rh
dHVzKTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICByZXR1cm4gLTE7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyB2b2lkIHRlc3RfcHJlY29weV9yZG1hX3BsYWluKHZvaWQpDQo+ICt7DQo+ICsgICAgY2hh
ciBidWZmZXJbMTI4XSA9IHt9Ow0KPiArDQo+ICsgICAgaWYgKG5ld19yZG1hX2xpbmsoYnVmZmVy
KSkgew0KPiArICAgICAgICBnX3Rlc3Rfc2tpcCgiTm8gcmRtYSBsaW5rIGF2YWlsYWJsZVxuIg0K
PiArICAgICAgICAgICAgICAgICAgICAiIyBUbyBlbmFibGUgdGhlIHRlc3Q6XG4iDQo+ICsgICAg
ICAgICAgICAgICAgICAgICIjIFJ1biBcJyIgUkRNQV9NSUdSQVRJT05fSEVMUEVSICIgc2V0dXBc
JyB3aXRoIHJvb3QgdG8gc2V0dXAiDQo+ICsgICAgICAgICAgICAgICAgICAgICIgYSBuZXcgcmRt
YS9yeGUgbGluayBhbmQgcmVydW4gdGhlIHRlc3RcbiINCj4gKyAgICAgICAgICAgICAgICAgICAg
IiMgT3B0aW9uYWw6IHJ1biAnc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2ggY2xlYW4n
IHRvIg0KPiArICAgICAgICAgICAgICAgICAgICAiIHJldmVydCB0aGUgJ3NldHVwJ1xuIik7DQo+
ICsgICAgICAgIHJldHVybjsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIFRP
RE86IHF1ZXJ5IGEgZnJlZSBwb3J0IGluc3RlYWQgb2YgaGFyZCBjb2RlLg0KPiArICAgICAqIDI5
MjAwPSgnUicrJ0QnKydNJysnQScpKjEwMA0KPiArICAgICAqKi8NCj4gKyAgICBnX2F1dG9mcmVl
IGNoYXIgKnVyaSA9IGdfc3RyZHVwX3ByaW50ZigicmRtYTolczoyOTIwMCIsIGJ1ZmZlcik7DQo+
ICsNCj4gKyAgICBNaWdyYXRlQ29tbW9uIGFyZ3MgPSB7DQo+ICsgICAgICAgIC5saXN0ZW5fdXJp
ID0gdXJpLA0KPiArICAgICAgICAuY29ubmVjdF91cmkgPSB1cmksDQo+ICsgICAgfTsNCj4gKw0K
PiArICAgIHRlc3RfcHJlY29weV9jb21tb24oJmFyZ3MpOw0KPiArfQ0KPiArI2VuZGlmDQo+ICsN
Cj4gICBzdGF0aWMgdm9pZCB0ZXN0X3ByZWNvcHlfdGNwX3BsYWluKHZvaWQpDQo+ICAgew0KPiAg
ICAgICBNaWdyYXRlQ29tbW9uIGFyZ3MgPSB7DQo+IEBAIC0xMTI0LDYgKzExODYsMTAgQEAgc3Rh
dGljIHZvaWQgbWlncmF0aW9uX3Rlc3RfYWRkX3ByZWNvcHlfc21va2UoTWlncmF0aW9uVGVzdEVu
diAqZW52KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9tdWx0aWZkX3RjcF91cmlf
bm9uZSk7DQo+ICAgICAgIG1pZ3JhdGlvbl90ZXN0X2FkZCgiL21pZ3JhdGlvbi9tdWx0aWZkL3Rj
cC9wbGFpbi9jYW5jZWwiLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9tdWx0aWZk
X3RjcF9jYW5jZWwpOw0KPiArI2lmZGVmIENPTkZJR19SRE1BDQo+ICsgICAgbWlncmF0aW9uX3Rl
c3RfYWRkKCIvbWlncmF0aW9uL3ByZWNvcHkvcmRtYS9wbGFpbiIsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHRlc3RfcHJlY29weV9yZG1hX3BsYWluKTsNCj4gKyNlbmRpZg0KPiAgIH0NCj4g
ICANCj4gICB2b2lkIG1pZ3JhdGlvbl90ZXN0X2FkZF9wcmVjb3B5KE1pZ3JhdGlvblRlc3RFbnYg
KmVudik=

