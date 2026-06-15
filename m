Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B264ECD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7DJ-0001qO-4y; Mon, 15 Jun 2026 09:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wZ7DG-0001pz-Ow
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:18:50 -0400
Received: from mail-japanwestazon11022102.outbound.protection.outlook.com
 ([40.107.75.102] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wZ7DE-0003EB-Pt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSUmAQCbSH5B+DUYxzHgcfIZyGRRtVWBY+kVR6oKaKIM93IXSs682Zkyo5U+Zls0tJJq2WrGw6mQTQ56fNvzqsEFfQ20xyYI0VH/KjOsK7hD6IPSMMP3+q54FMp2jW8wTVwGYTd7Ks0ev4/RKzOOXTj6StvCLYHpFjMr8quJB+n7oLph0suDIx9Q4uUx6H46agZhD1CcPpos1ncHvd0KhoTh8DXiIQeVg/iRNOUs18tvMfzXA1Iqxv1XPWoVQ4YX4rheXBtbIgwhboQkO9K+qU0SCVGTh2rrGmb8lRdYNk6ay5d5pN2ZiJicbTFoKgzjbP7zFdloCSjUTo+R/t7FRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8tRYOXw2o7FUpna7wzG7uWFEqQ9Vhg57CVN1Jggrzc=;
 b=OUiPKXHY8zugwfwIqiHqhSHVrcccE4cx7urcAr/cNkZse6JGvmR/b7NZth7hB3fSoFTPZeIFRqdJvpTWvEl+Fn3gMRTcB4ZWOFrPIGsS7WK92O2jMoBoHg0sOl05LouHvAjruE/WkP82w6M6rQOlkt2KiZ7E539F6/qIMVlF0yrcW+esxOp21tLF1+u/65Gng27Xg9XUd53b9lrI4OB13AcDytmPGZOE2q02rUIeu17zMrdlkW6n7vBjE2a7ZGyRCmleAt1ifWP7mPo+aTz2LM3pUm1qFs2i+vuCpsxhkJGua/Wqx9jJjyvmqSPq2DUc+nN2Zx/AqOUVK+ISIOzXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by KUYPR06MB8530.apcprd06.prod.outlook.com (2603:1096:d10:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 13:13:39 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0092.016; Mon, 15 Jun 2026
 13:13:38 +0000
Message-ID: <9f3952f1-1794-414d-bf7b-db7a5094ed22@linumiz.com>
Date: Mon, 15 Jun 2026 15:13:33 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com, David Brenken <david.brenken@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Subject: Re: [PATCH 00/10] target/tricore: MPU, peripherals, tc39x SoC
To: qemu-devel@nongnu.org
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::13) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|KUYPR06MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 267909d5-b44e-4679-1a2e-08decadfe9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Aq204fDD28dcnyQ+R4HSl4/egNLXGlRkCuS8UoWIGSn1T5TgtIiJvD8zKEBgz2iCogfEHZozNI/duMoLcfmWfCMjzRAHzPiPN7QSVvMzKz/MhYrmOpiFoKa9Z06WtaqAkSaHayWz1dJ4kcvwuDGjAhh/sBJWLWC7a4U7TWsRZV/cvMO+b8dsa96muBs1ZjHLatL0okpMJZTD1KYEJnP95rJUgD9FoWI33RGeWlRlmfjospbY6evuSXzIZTvIM8kHVxiy579NNKDLQtwiHGBDTA3VphumxjuwWoaNVDtZaqwxaPA7Qd48V65E4EHSSNMSJNG03q2tngfgmykxsqH+wX7rF/aEF4EzPuPW5LzoOS/Gb8JXqX4GH2apqfwY2GE4fKJlyH++aHOIJGRijPCfN6c3TgAq4PlJoYbW/mK9yxHoheJdJoXUSu7f9VpeBhGHxJXoH+agYeXmzbJL6vufPIdF7xJY2TvI5AHJcQ2wqcU4Hq02dwEMA9Cx4Ogi2c5i11cEbZ90WAR4DP/5Mt0QXjZmEwdUcYprIt5SulIRnTyjPBTKFvF5SQFi6uMxrQ0SqM/3/WqsqfXCmLRKWC0ryHuyzFH5p2hW0NIMBbG3Ln/mHxfpZdh7fFt/Tph/66FXYHcm3wfjy1UqzTvYS6rKoSGCc4N/oTCmNl3gAzrr7sQODcEzhl9+7ZxXKiEe+RtB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBoc2Y2WDZVUEVhV0lxbDR5QU5YanFTY1FGNEtiMHhCaUdUdkJDcTdJZmVJ?=
 =?utf-8?B?R0hndTE1dmp3Y1lIMFFMNU1KYVRUWDFqck5JcnRlSHVsYldNbndvQ3lNNThI?=
 =?utf-8?B?Ri9SakgvR1IxUmtxS0NvL25qVndZb2JYYWpHb3ZvMnhqOVpsOVZOdGkxcnBz?=
 =?utf-8?B?KzcxKzIrc2gvYlpEc3ZUSTM5WFVydkRVenc1TzB4Smpvd1FLdmxDbXRnTWs5?=
 =?utf-8?B?UUlnV0tyaDNieWcwK3FaZzY3dUJjcnhuQzFrcmFnRU9jaEltUkVucEt6THlL?=
 =?utf-8?B?dEZpdUlKNjd1ZUZSajRYSmtheFVmTVJ1RUdrSmFIcVJISHl2NXRxdlkrQkFI?=
 =?utf-8?B?VGt0dDlJVW04d3EwUXRZMnJ1a1ZzRXkycVpqSzRsK0h5UVFEZ0d4Sm01QU10?=
 =?utf-8?B?QkhYRXE4MkFVbG52MzJSKytaZFZ0a3VHRG1PTjBjMzBaWEhmTFdSTzdUTVBq?=
 =?utf-8?B?elMvQmhVMjJ2TjUrMUtCTUN2dGU1R0VRNmVSVDVxdHJ1YVVJa1VvNFVjZzFT?=
 =?utf-8?B?UTJhTWcremUzSm1FRjF3UkJUY01ObWVjejNzcmJsM0pkWEN4S1l3aEFUbXgr?=
 =?utf-8?B?dFhyV0FZWWhOcnRCUnVsZ3doSWkrWllWRTFvTjN1ZGFuZTFQQzR3TzFDZWJw?=
 =?utf-8?B?RWwrTnRka2p4UmVZRXc5VGlBcW5wQ0hqOVZydVg0aTBjN3VWSzVUejd4SGRv?=
 =?utf-8?B?WUh4N0JCVXk3ei80Q2ZLSVVyWG8xWG40VmFaN1VVSUpHQ3cwTnNieDJCSE9H?=
 =?utf-8?B?WWNUSTIyVm16MEkvd1dLKzZZOFpOSXYyeWpwYS9HNFpGUWVHdS9QcklybEtq?=
 =?utf-8?B?dkJxSWdmOFE2VUpJL09LUitBVWZQSEpPQjBBWlJwOGVXVlRTRW9Wc3dodTZm?=
 =?utf-8?B?MDBDUGJWQkk0UlVzQVJHNmp5bFFha1pXbmloekJLbVBNbVpyT0V3VnBJSmJQ?=
 =?utf-8?B?ZVZuR1U3VzhvWCtWaGN5SUdNditHUkQ1WUM1OTdMVHpRdU1WM2pwSEZwQ0hQ?=
 =?utf-8?B?VVJwYzdEZXNHUGhQcE9SK2VUVm15SzkrZHQ3RzMzMVdKS3hyUStxU1dua0xQ?=
 =?utf-8?B?M0VuVDR3L2VkNEsvN0RqaU5oUVhPMXJlUjdXbTdGdGdRcTAzWWJ4K0hNeGpa?=
 =?utf-8?B?YVRRL0R2N2FVZklZSDF6dWFNbXoxS0R4Um40b0dMRmEyUGR1cXd6aHh6S3N4?=
 =?utf-8?B?NU8xaUZjY1B5TW9XNFFPY29MUmc5VVpQL0xLbnlQRGNzTVVkbUVjMUpESVFR?=
 =?utf-8?B?djlReUdQZHFnTUtoUTNha29tdWpJeWMvUEZVSTRqenZhUVNyZ0VmSmttZWtK?=
 =?utf-8?B?ZHFraG1neWw0Y29rc1VCQmdrNmFPU2MxeitwM3VVK1J0Wk9WMUlLcytLd3Zi?=
 =?utf-8?B?em8rOXA4a2lyYXc1RUJ4M1paVlMyeld3UUkxcmNCNmVsc0NWQUJWWHBrdWRX?=
 =?utf-8?B?SlZXM2J5endXeGRuSWdFdVY3UmtRYm5ENUhaN2xpek1JVm9GWmUzVkRWUk5V?=
 =?utf-8?B?a201aHV0Rkg3SUY1aTVneXF5VlVjN20wVzVSUkRIMkJkUlZXZTZubU40TEtV?=
 =?utf-8?B?OVltZFNML0FGSmdDSmF4Vnd2UnE0K3VNVlRyOEJPZlc3T3pRL3dFajhKS0xa?=
 =?utf-8?B?SERkNjBRckxyV3JKUWZORzJTSER3YWFpOUIxazhmczJJRWw1dENURmpZMWY1?=
 =?utf-8?B?VkZwRjJWUml3Z1FmVlkvMjl5WnpTZkw1YzRocUx5UklkSEF2UkwzRlFCMGNr?=
 =?utf-8?B?MENEY3BacG5VU2dRa2ZCY3FTeDFET0xkbmFxbUdHa2xJaitjK0I4YVBhUnlJ?=
 =?utf-8?B?c05kY2M3MlQxSTNPMVk2TGJzTTkybXovWE5HUU5rKytIM1NiTUFqWTZQemUr?=
 =?utf-8?B?alIyRWNWRzROdGVXK0N4a3ZEYWVGOGNJM056M1BYYVpmY2I1MzhIWnpHUG1k?=
 =?utf-8?B?dkduaGthYnZGVVRhcjBjSFh3WlhuTGFFa21GMVVpaGdUSXIyVUxwMmhLdjVP?=
 =?utf-8?B?OGl3THJjUVM4OE5jUnkrOTdXV0trM01NcXlYaCtqSHpIMmNKY25ncitVaWRa?=
 =?utf-8?B?NGJvZ2F2cGtLYndZaE5WQzFvWjlMeHg0MGNtcXUvTnAzMVpzYzNVLzZ0U1ZT?=
 =?utf-8?B?UDNJUzNCcitvUGR6V0laM3JnYjFhd1NVb3dkazI4YzJNVy83VDlucDJQN1k3?=
 =?utf-8?B?a1krUUFhdy9FTWt5cDFkT3JiRE5vb3FxbUI2cG14a0srQ05ReXpjbExxUlFl?=
 =?utf-8?B?ditjdHJjQWo2bGNqdFdQSW9JN3dEclc2TU40ZG00N1Z1RzMrZTN3V3FBdmtZ?=
 =?utf-8?B?ZTBLang5UmI3Tyt5akRLZFRyRlhpVHNLRzdYbVZxSUZRcURwano2QT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267909d5-b44e-4679-1a2e-08decadfe9d6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:13:38.7716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luIwScEhvQzxNtxeiC2UHOdpDMPDrZVvpn8t4I6d5AiuOp4SKMZBOB3nSTeg/8paBr7WgSAGeL+BwPfGSl6Wug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8530
Received-SPF: pass client-ip=40.107.75.102; envelope-from=parthiban@linumiz.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/31/26 11:30 AM, Parthiban Nallathambi wrote:
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
> Parthiban Nallathambi (10):
>       target/tricore: replace legacy DPM/CPM CSFRs with CPXE/DPRE/DPWE
>       target/tricore: implement memory protection in get_physical_address
>       target/tricore: add tc39x CPU model
>       hw/intc: add TriCore interrupt router
>       hw/char: add TriCore ASCLIN UART controller
>       hw/timer: add TriCore System Timer Module (STM)
>       hw/tricore: add System Control Unit (SCU) device
>       hw/tricore: wire peripherals into tc27x SoC
>       MAINTAINERS: take over TriCore and add peripheral file paths
>       hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB machine

Good evening, Ping for review. I know TriCore lags active maintainers.
Looking forward to know how to handle it. I have few follow-up patch series
which handles additional models and also newer cores.

Thanks,
Parthiban

