Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F28C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrD3p-0006rB-1I; Tue, 04 Aug 2026 07:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wrD3n-0006qx-Ty
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:11:51 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wrD3P-0001hV-FV
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1785841887; x=1817377887;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=beUUFZtEPVeSnbdUS7ejEBzx4r0NIqyQb/Yqk5udh34=;
 b=sdsUBViYUkk83bqh6U03mcIfrWffhMBgh/olnawZtOKLd18GNME5ASd0
 hE/zLm4d8mvdzcoLbfTxNK3pNqn/D2jpGMqGN5hIFH8MmpBIaDbCW1Pe0
 cXCSXFyGy/pwxtpgUlO33VGRwmDPRQsVzi1L+A1lAm+Y/LKhxqqpV8fO3
 8AlHlWFP+j6KE064P8iS5AgC++1eeJcvjMpFXyoPVP1C0jVAMbyJhbVnY
 WRFUBDFahqToHj/sCl0ng5SIvFKfbRVEgE44HTHaznERTs6ncHfRkYE7C
 w6N6WbKu0X1RZiTAbE7LkRgxRKN/FiK+fjiGDo3t9QwNuqvt4qZPoNQGF Q==;
X-CSE-ConnectionGUID: vjt+TTdwTs2OtFIACIuBkg==
X-CSE-MsgGUID: bWG2za3hR8isW+0cdjrBPg==
IronPort-SDR: 6a71c8db_DvNFUOxYKBFbXdqJI1WqxwqXk/8gyOcANTeKkw1fSfROwCC
 U0h8uIGc2OKlRbauCk4Mp8DMa75LgCos6WBYJ+w==
X-IronPort-AV: E=Sophos;i="6.25,204,1779141600"; d="scan'208";a="48549314"
X-MGA-submission: =?us-ascii?q?MDGjuX+nNsf5Q6X1LD8u/c0GKgHF8nGlSEv3WB?=
 =?us-ascii?q?ruTFiLnARakWvo6P1LrMpqKt6xKZvTJoQmIMs4adTSs5ZQGlgwv6B+05?=
 =?us-ascii?q?cnUfSWyRU6BGyVYKCvA/+ZAkBSvmI6K1PFUkF2cNwSSroqPQyEXu6L56?=
 =?us-ascii?q?zeudPxnqYYjC9UoTVFbESPNw=3D=3D?=
Received: from mail-francecentralazon11013033.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.33])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 04 Aug 2026 13:11:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSpmV4C16NMWKIkXUaNzemqqnUnA6QtQraUw9aMCCTb9LP9PrL5kYItQBMmfcQjofLhpai24sxentFJ9n8keCaIWYYxDpSljACenMipccvi0iW/b9qf+ELRwC1JndA2F5dOncsQrzxuqktv43uGvpnahzvc6+pBlKTG+hnWCbNROWmdEDglDf2duJksYpwBGfzxZqJoRp1Wa38QxfWg500eC3BxxOtYxLDmksDj3usW46MDHh5aJrJvpKbwf3UB48vZ75Qa3Lw0uZk2c/GtWKoBlMsxLM+kswPM3N4os5e7Jf21Jps29TxayWxOqk9fdZeyaNtwuWqLDDQ7YXBoIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beUUFZtEPVeSnbdUS7ejEBzx4r0NIqyQb/Yqk5udh34=;
 b=mQ/i24RO0vq982ARizj5Sb5Y0gQSpmDlNG1RocsjLlfsqSJl1WAJObSDeLhfoqj+NJll5Gns5No6eFSL/yK5y5DckkXMqPE0LyopUAfNumTJy0tLh6otfwcohnzutarQQ8Gv2Sel6LTv2GTx71TpohUgOpzUj/sJU0p+QDA8IBH1r3MIKit4KikOxrLO3WEHChiLbZa5P5yPv8YrD4t+4bcXzXv0PX0GYW1VLq9cp7vYWE9f5jxIAYFpGySocGiw9WOt9H+KmF/lBQL8f5kMWRtOK9ggTHVoEcVMa65SsYd1HaUzgxYCPjL+JWolzy/1xdI61tj2zhG8U6ukRr/v2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6568.eurprd07.prod.outlook.com (2603:10a6:10:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:11:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 11:11:21 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdIpiwj2+asGS6SESECAGeCbz3Y7aNlsGAgAAoAoA=
Date: Tue, 4 Aug 2026 11:11:21 +0000
Message-ID: <ee8a2f029d56c8d6afed4a96e0ca6630b5bce079.camel@bull.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <d6d2a51b-7209-448d-a2b3-deafb320cab5@intel.com>
In-Reply-To: <d6d2a51b-7209-448d-a2b3-deafb320cab5@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6568:EE_
x-ms-office365-filtering-correlation-id: ea64645c-eb61-4ec5-af88-08def2191d82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: NeSvU4RNzVWy5f5dHs9m4YPcc85GvSaaYRuv3MFOlXsoJqmY6yizWSwPz6OZMOH5GOAvZK1b8tqa2677feLbRbYofUE2mEQHUqNWUN7zQJz6awlScYUWZy7y2dRTfrJXmd7IPI4JfCPFackPAzb8iiWXzZjOL6CjFJr/KNtr/yaoInUNyKV0S7zEqTzjHG9uyYpW1ahEO4AGPCb4RmURVPcVOf1hmxkZLppjGX3N2Ah+8rU42UmZXWQwYHcUWGwfUp6x9mcPLHyr6NICLe77w4t5Qc3iARGnoFWFfvdslfp3ZZ1pLkfUWMmcmGp5Hgvgu4RLl/2pIOXmHfTDye6Wcy6Iw0dH3FPIDqLa/a5KIZuNeSAH3s+D6HLfx5vusWOwMh+jCa3ygu98LhxHcnHdeIle4FrSox9uoiJfOZ4cjEhX289TqnwGbo925sdHwhRGneZYG1aoFfR5rfsTUa3glP33Tg5w6yCJ4uTqYR/KZN76Zk4RPY+SRMXzQLfCWLg+NDjSDa/IbTx5DZ4maZs2JanYuooAdkXa3u9IhosTAAzxkG9wRdLydU1hw/md1iswhIH1z5CIygYUkAJygZkCpMfoI95vi2/tFOfEUFX9nuB/LL+oHu0K9VPBBX1YJeR/89DbDa2YA9TXEJcvJLR86w7ZvhCZ+UEf0uLn97Cngcg9LdyPDltWNMZfj+kBKC0D+s8SV0HGqPn6O/rrzZSx1AXNjrQ8q41roh9RvpDmg9w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWwwbEJEOFMwTkVoNTd4cWxTc2x4c1hsQnlTd3pLVUYxWnErc2liTEE0WUVE?=
 =?utf-8?B?NjEvN1ZEKzJQdWZ1clI2cFQ4NnFZSXFEc1pTNnlySFdxR1liSFRWNnVXUmZR?=
 =?utf-8?B?MnM0WW9VL0hjd3EvbzVWYkgzU2NCRUhpai92TFlFaHE0dDVVbFcvTmRneFIz?=
 =?utf-8?B?ZEJFVDRXVkRrYUNSQWtnZVp6eEZ2UkI5TndlSmpyVWJqeWIvMHdOWHd5L01M?=
 =?utf-8?B?cW9NUHg2SjVDWUZacFU0WE9OR3R3NVVRVU1qMjJqWTMrbzJZaGJ6d1N0WCtF?=
 =?utf-8?B?SmFZU0prcUFlbXJ3YmlOQ05LNVVLTGlqenN0ejZQaGVub2llckNUYm9sL0xi?=
 =?utf-8?B?SkNZdmFCK0ZlRDhNVDRIYUgvL2FLT2ExdkE0Y2RzWkI4WXVwNlI3N2laVUIx?=
 =?utf-8?B?R2VhMS9Gcm1DVGZ3S2F3b3kzYnEydVFGYkpQQ1QrSlVjOVFoQkRlNzJhbjEw?=
 =?utf-8?B?Z1RDUFQwelluREZaMnpRbWE5ODRFTnVNRVp2UEJFZEF3bm1EcFlreXF3aVpB?=
 =?utf-8?B?L1craEwxUG8zRVQzS2pIN2tiV0ltengwS3ViVTFhSEl3ZmV0WVBQZlRqMERz?=
 =?utf-8?B?L1BXcDZERW1adTZCdHEwMEZKbERDQWF1Z2tNVjVpZmozQWs0SXFuL0hiZVR0?=
 =?utf-8?B?L0dUTU1hWnlWOXY2bEJMZVc4ZGRUSXBZSFpHNkFxVDJ0Z3FJdlNtMW5paDNm?=
 =?utf-8?B?bFZ1U0s4OU9DZjFsZ290dmtRbUk0WEs0NlZJNUdtOVFtZGRBeER2U2Vxa3RF?=
 =?utf-8?B?Q2k2QXpFNzZlWmowZ2E5a2xxSlNXZHlmVnhPdHB4b2J3TXAzSEFVSW03czRF?=
 =?utf-8?B?cDhIbFZGcHlxZ3JOM3E4Wll4RnpvRW5EaHVKWXpDcHNJY0IrQ3oyYUhqYytJ?=
 =?utf-8?B?RjRPNkkrblA3L1RDR0FSZnczS21kMjdmQmtKcTFCZUFITGhxTXVIbmRxSi9q?=
 =?utf-8?B?aXRNQjJ1UFZhUTBTMjJtbkJ4anVGN2xuaCtWQjNOWVZJQmVuQll1Mkt4aXUw?=
 =?utf-8?B?N01sMEkyV2dWTURGdUNXcElxKzNuQmwzQnRLTWVGSmx2R3V2VWNWc1BFcGxY?=
 =?utf-8?B?N2UvMGg1a0VXd0RGU2RFdW94TFZKZ0hoVVdqSXp6R1E1UU9XdFBYYWhRWHRW?=
 =?utf-8?B?dUQyRTdwNFhLSFNybS81UEdaZitDaFhLVXFxeFJ0N0hWUVFQS1p1WWpBbzZl?=
 =?utf-8?B?NGEzWVo1aTljcU9leEoyVWFOMmVvT3hwM29ZZ05sNE80MHoxRm15NjNwanJV?=
 =?utf-8?B?TmZ1SFpDRUszOXlYRmE1SFp5MHoyRzBTTnVWaWY5NlhZNStYYVJWc1RsR2hP?=
 =?utf-8?B?REp5WWtKakZNZ25pZHpEby80SXkya2lsZklVTlNqNElMRnB3TFpVTmpFN08w?=
 =?utf-8?B?ZGEwZE0vTXlOck8vcHc0dHNZS0oxd2h0dHFQOWZMbmZxL2MwdHVjdTRrTmps?=
 =?utf-8?B?WmU5aDhua3FsSEV5Ry9KY2NqeVczVlREMlIrVlN6bVNTVlkyaDVvck9lT1Rl?=
 =?utf-8?B?VkVHSk9qUVdyWFBObUM3Szg5VUQ5aEN1ZDFOeVZnajJFbXJ3Rlc2TTFQYVVM?=
 =?utf-8?B?UDlHTlZPQUFNSzVHRmR0dThUdlU4ZC9ZM3R0SEFsa1BOQjNtMmQzODFqa1J6?=
 =?utf-8?B?TU1FWkpVa2pPZTJJQnU2NjFoWi9oSWYzeGRmRk1hRmdlVkl6QjBqWExiWFlu?=
 =?utf-8?B?cGhocjAwODBYTHNNWHpkekZCY2krZ2tUS1NkeWFmT3VNWlNhWjNtcElyU1ZN?=
 =?utf-8?B?NGdzZFZCeUFORlUzN1VSYVVpZ0Z4WVhtcTBaaFRwUjdlYUQybVVPTitoTDdM?=
 =?utf-8?B?UzhHOU4xeHI1S0p2RkhEdldJS1dvNXoyZG9FUXVnUUJldW5vWTlaUGM1WTRN?=
 =?utf-8?B?SlZvZXpOYjc5TURsK2djRXZ5Wk1TUlEwWnBCZWZmK1N2UjdPM1JxMVBFUXBK?=
 =?utf-8?B?UGxJQmlEZmwzOExhVmdSeWlBbGJBZHEweHk4RXVPTFZvaFJsN1JXSFBTZ2ZX?=
 =?utf-8?B?VmhmOCtERU14VlJJdWQxcHJJQjRkNzBiVStTY0NRY3Y0TE4xbG9kZERkdldC?=
 =?utf-8?B?NWMvblpXV2d1T2EwOUsyL05OUE1nNFBqQ2hOckxJZklkQ0FyR3FVYTNSMDVj?=
 =?utf-8?B?ZGdNaXhLekIrazRmV2ZuTVN3bWRwdDNzWitTbFBKS2ZCci9JRlNSdTQzQnBm?=
 =?utf-8?B?Mnk5M0dLNHNrdGt0S3FkR1NJOHlqcHpFM3FMZnRhQlRoT0ZFcVhCb0lsZWMr?=
 =?utf-8?B?Wlp4REJjM0tSVmR6VzlBZnNvR0syRzZPTEQvaDFIOGJEd2hPQ1RhS0x6M092?=
 =?utf-8?B?TEJkQkVwQkkreW52NXcwd29lZ1ZLRDhFdk56eERKYS9wY2JiYzBHeGVpbVFs?=
 =?utf-8?Q?yjNW684Z+8/oZcHdN5/yRBiwjotqFVyYuCJYM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6B05363F5A424A8F390F13B4E8000B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HyNgmsWBzkr0FmWwH/2u2JX1VFUx3fpuYjjaxlORovH3Hwv441/nh8/DBwrjrhAfvCXTpsYNklNaSV+ZmrCajnYzkRHWdU5YrXheh8WYmKUnfUIpF88/8cV4QYy/6CGCQTRmWeWKiXdtx0WMFlBcBuIDRii0CTZqFzQm5K0k+dqPtlw4LqIgUVHdDQn9dcuyUJTPXB1wcNhC0emmZILIDxE/qjQ2Q5eEQvHPWIBwaCx9hVqxu5ONLHJ1V3xnkqGPaTFd/SNzpBiFad+q5gNgFKtkVUoUQ2tP/RKJkoHcdA4CZ3o5Z3aJmQqRwnz2ElJSbVouuva7YaRe3LYCvFY2Dg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea64645c-eb61-4ec5-af88-08def2191d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 11:11:21.6180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVWu4QDC3i7yrYs2BbdC7eggo7xuLm63dgBcNKkQtZ6cAzHZ0BuaN1V4DTtucxx9FUjL/kxxOygB9QaSdvsFTczv88lQCo0281x5cQLXmQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6568
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
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

DQpPbiBUdWUsIDIwMjYtMDgtMDQgYXQgMTY6NDggKzA4MDAsIFlpIExpdSB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIDgvMy8yNiAwMDowNSwgQ2zD
qW1lbnQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4gDQo+ID4gU1ZNIGluIExpbnV4IHJlcXVpcmVz
IFNNUFdDIGFzIG9mIDc4MGRmZWQ2ODg2Mi4gVGhpcyBpcyBmcmVlIGluIHRoZQ0KPiA+IGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gYXMgaXQgaXMgYWxyZWFkeSBpbiBsaW5lIHdpdGggdGhlIGV4cGVj
dGVkDQo+ID4gYmVoYXZpb3VyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENsZW1lbnQgTWF0
aGlldS0tRHJpZiA8W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1l
bnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSk+DQo+ID4gLS0tDQo+ID4gwqAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0NCj4gPiDCoCBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAxICsNCj4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gDQo+IElzIGl0IGEgZml4IHRhZyBuZWVkZWQ/
DQoNCk5vdCBzdXJlLCBidXQgd2UgY2FuIGFkZCBvbmUgaW4gb3JkZXIgdG8gYmUgY29uc2lzdGVu
dCB3aXRoIHRoZSBrZXJuZWwgY29tbWl0Lg0KDQo+IA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gaW5kZXggODI0
NTQ1MmQ4OS4uOWYyMTYyMmE0ZiAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4gPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiBAQCAtNTEwOCw3ICs1MTA4
LDggQEAgc3RhdGljIHZvaWQgdnRkX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiA+IMKgwqDC
oMKgwqAgfQ0KPiA+IA0KPiA+IMKgwqDCoMKgwqAgaWYgKHMtPnN2bSkgew0KPiA+IC3CoMKgwqDC
oMKgwqDCoCBzLT5lY2FwIHw9IFZURF9FQ0FQX1BSUyB8IFZURF9FQ0FQX1BEUyB8IFZURF9FQ0FQ
X05XRlM7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHMtPmVjYXAgfD0gVlREX0VDQVBfUFJTIHwgVlRE
X0VDQVBfUERTIHwgVlREX0VDQVBfTldGUyB8DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBWVERfRUNBUF9TTVBXQ1M7DQo+ID4gwqDCoMKgwqDCoCB9DQo+ID4gDQo+
ID4gwqDCoMKgwqDCoCB2dGRfcmVzZXRfY2FjaGVzKHMpOw0KPiA+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4gPiBpbmRleCA5MjRlOTFjYjhhLi5kZjdhMGVmYTZlIDEwMDY0NA0KPiA+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPiA+IEBAIC0yMDIsNiArMjAyLDcgQEANCj4gPiDCoCAjZGVmaW5lIFZU
RF9FQ0FQX1NNVFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDQzKQ0KPiA+
IMKgICNkZWZpbmUgVlREX0VDQVBfU1NUU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFV
TEwgPDwgNDYpDQo+ID4gwqAgI2RlZmluZSBWVERfRUNBUF9GU1RTwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoMVVMTCA8PCA0NykNCj4gPiArI2RlZmluZSBWVERfRUNBUF9TTVBXQ1PCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDgpDQo+ID4gDQo+ID4gwqAgLyogQ0FQX1JF
RyAqLw0KPiA+IMKgIC8qIChvZmZzZXQgPj4gNCkgPDwgMjQgKi8NCj4gDQo+IA==

