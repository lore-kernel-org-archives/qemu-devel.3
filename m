Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FCDC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whALD-0004lz-DI; Tue, 07 Jul 2026 14:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1whALA-0004gg-8P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:16 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1whAL8-0006MM-31
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzxOKYc2ouiLsJE/hMzGYC9CBfAJrtOJNImCvZ7Zaha7rZzDey7QJuD4brEcFt7INXsq9A2jXx+BkOa/BXsIvz4LBflnec5rw4+sH1vFDigBTsfoi2wsFCwAuPJPm1zxPs3lkSy2P4FBUeHa3zIpTWPoJSJfGxJTeA7oGvjIQKlWotdmclc9Hzedtm138TzJQ6nCHRd+gh37rl7fdvq60Np1hO/VbQoJhfVVZtkl+esAgB9iQhF8nApMfCxFo3b3CcTkmbR64LFP4g2er0EGzD8Q6L+bMbLwY9lHPtdstFY4gp8L4JFcIZ1/ggDjvxqnWRGw0zHaDFAo6C40YTKKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5o55Cfke2fkwn0mOFlUIqpr6R0Slt3fcPhdt4K51nA=;
 b=oZKSAj7Swyt8Tzhr974EgX2ZU+N+oxqRmxQfZQWvfGH5L/vP3+V19pcz6TLr6Ssqhrn/mm8abeQl0FxmeOJICSRsKGhJuePusIW8UtYdvwRooRo/cAOmENcNjPu5P/AGVGMbPUCIkyYosi4b1dPLfejN1igOZJCIOAcWpX7fiwQu/IwJhQQqvqh5JajbwEsXY9rurC4KkgqTZ/OdlJUfjz4YnxLqND2hww4OjPkiouEJui1FwCjFz1WB3HjQu+M3UQWtnocHBAZOpFBsRTQ5d8PEVlIrsE1tvQa0Qc3hqDcnHOdDnxcDlfpzzcX/xtVZFdmIH2jAQRjwU/ElJMs2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB7048.apcprd06.prod.outlook.com (2603:1096:400:466::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 18:16:06 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 18:16:06 +0000
Message-ID: <cfdde0d6-77fa-4216-92ac-bdf9b9b26087@linumiz.com>
Date: Tue, 7 Jul 2026 20:16:01 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com, David Brenken <david.brenken@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Subject: Re: [PATCH 00/10] target/tricore: MPU, peripherals, tc39x SoC
To: qemu-devel@nongnu.org
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <9f3952f1-1794-414d-bf7b-db7a5094ed22@linumiz.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <9f3952f1-1794-414d-bf7b-db7a5094ed22@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::8) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e8f7cd-2547-4e49-2a41-08dedc53d00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: RWKoEhvnHZMD7sgw0E7Jd7R0Nx/KpBJ6KxLY4JnXm34Fa2KIuWVE4uzI4V0t9QbBJ9aprjIrRPaCwvE9Ku9zQwXwGwk3Xl+BAr7WIPgQR1srlIPvczK55uaExYAD5M+s/+cM5Nx3zhziQ3ibTjiuOST8BKWz/7oJGGNYyGpHdVGkQJJj/3bDaAkbQ2aGvnRmUuNBZ7SUL1XHKJPuy+VMm+2vFzUoxO2Ltxtz7EBTcvVgmV+z73ovQ41cPhs+pyXW6129Xy0Vhzvw8AY6BMifuF9HkG2wgVAd6aMY19xBvDgf6mDAiVhSTK2TcEN92RXRfTl2/aE42qYbNtS14zTqYLKU7mOV/nnvkhib8NW6jpRMrXx003yH08Wcazsh8EZmT+vve28j0bXa+NPXWn2U2UJuPR3iobEmtU4zJytbhQYcLXQ/pGCfLse2754ggGtmMQK3ZcfwhCg4osnqgdfIhjHJzrR7+oNlOz4isDQdX/Bs1pRK5yhxlzqgvVeoJyYTEFt1mF7O4/BzkFI+X7iNgRBPQvKbse/ggfxu4BJuWvTtZAKFUwvSmUOzsHHa4Pf5FWrcsMiCLFJKlwviWU060RV4A95h4Ky6yz+ht7R6BSPyK/DZLoPQDvuFm1Kz0bnwT8zQh93OKEriQmsid+WS8nKAJOWAIEeQ7OhQtT2ycdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVja3dmSnRpR0RaZFNNSk14OVdUWk5FUi9WdXlyKzZQa1JRMEhOUUpJZW4w?=
 =?utf-8?B?Uy9ZY0ZHV2VpOTdySHp1QlpjZFZDQm81UUd3N3BaNkNhOXhIRE9MYmlUbUZx?=
 =?utf-8?B?VTgyVlZuQ29kSUR5eUxjQnhDVlhBbmFNd1RGZERmOXFNTU0reHJpYU9IdXcz?=
 =?utf-8?B?K2ZSZnZyVWdzSFZSS0lOOVFlWmFDbUQrMXdwSHNBNno4OTMvbUR0UkdZQnIx?=
 =?utf-8?B?Umx4WGJUZndBT2ExZ0N4cElUL09FL0JjQjBFY1p5TS9yN3hZL0hOcnQyZDE1?=
 =?utf-8?B?YVI4ajVueHBVMXYwMU1TZWdxTlEyZisxdVZYQzhoenIrUTVPcFhWUWZibnZR?=
 =?utf-8?B?b3RzbmlhQ1RyaFA3bnN0SU1TaWNwSXlIVFlQTERpQkVlU3dDcGQvYm51MlJi?=
 =?utf-8?B?OUtxb1p0OXlRWjRMbXJNdGEveTZXQU1aNEN4cjlNazB0emFwNC9MU2JDT0Ur?=
 =?utf-8?B?MmF5aXFkVVQwQXZWNHdkNTZOenRRWWUxQVd4OHEvbXROT1RDdFVjbUpWcjZP?=
 =?utf-8?B?TzlkTUdsWlRBRmVLYVkzNEdPOUVzdGk0d1pzZExQcm1jQzNDWmN2TGdpZTgr?=
 =?utf-8?B?RjFLb0QvTkZTa25sTmRNbUxYdnpXQklyV3Z3Zmx4RHplekxjODdMQm1MTXFp?=
 =?utf-8?B?T3QwY01wYUd4c2U0aHFHNUJLR0dBZzVZTGR2S1RqdXNHNUtHNFkvSTdKOUlP?=
 =?utf-8?B?bVBNdXZ0elRXZlhPNFNuSVE3T1RVRWtWdzFqRkRoWGE5WjMvK2J1OEVxaDJo?=
 =?utf-8?B?SkpTeFFHODZ6VFlWQUJVemN4V045cytjN2ZkV3l0emlDb1FtNENXNzNmdEtC?=
 =?utf-8?B?bUlORlZDV2NKRXlQMXhDcmtrQVB1OFoxazhmQVFjUUsyb3pGTTBPTW5wZWV4?=
 =?utf-8?B?N3VIZUlOOGRaR2wxTXR4UE5KQlM0dUVlUWhwSHdmeXdEV01ZNDRZSjVBSC9W?=
 =?utf-8?B?MXk1OE9vSnZaUGtxZEpYY2Z4K1RQYUVjZmNYdVo5a2svK1c0OExKWERBaXFo?=
 =?utf-8?B?bGkyM2hxZThCelNYTk9tYURuWVVlL01HU3BBZjRHcVJSVHBvYlIwSHprZDVP?=
 =?utf-8?B?QnVhbE9xU3JYT0xHNUlyanVTcFZkSEFvN2pKdUpoU1BYenJ6WXlrNWZlTjlz?=
 =?utf-8?B?d1lQWjV3YktYazQxa1RSd0UzY1llQ2VIb1lsbnJRVjBLZUFXSlFSdTVrTHlN?=
 =?utf-8?B?NmplQ2ZWK3JhcnZ2QlQva1ozS1BMT3pvY0YxZG10NEUxMDNtSmhmb2hIUG5n?=
 =?utf-8?B?SmV1SzFFbHJxcHVzL0xoZkZLRi9zNlFuc0k2RHU1UmFCZ3RhVWl3eXNjSit0?=
 =?utf-8?B?azNOUUhncDdyMndFQUZhN0tKc0FOaHZTUDdFUnhkUDlXSHNjenp2MkR0TU0r?=
 =?utf-8?B?TmtmMmF6YkQ3TytQaDArelBYeTg0WXVJY01Ob3VBL0F0UG9lU3hVS3dNdG1G?=
 =?utf-8?B?allkdGR5cHZrTzFLTEliZndTOU5VUUJHV2pZbyt2eFdFTGVFR3F4TTI3TWR4?=
 =?utf-8?B?MURSWTZQQVBvR3ZhcXI5TUJHQlh2aUwvbnVGWVp5bnY2bDdFcUtaZkZKSUtY?=
 =?utf-8?B?emdsUHM5V1VrNlRlazRLRzFXTTVzVmxuZjU2ZUZrRXRLT3RTV0JWYVFSeGVP?=
 =?utf-8?B?K1VqUHNDN0hPUkJnZ0RFVjlVMWN3bzJOamhaRDM2Q0NvMjdtL1pnRWJjek5z?=
 =?utf-8?B?RWdFU01RdVNLeXVZNXlZczc2UE9renAxVTdmVU1peUtoek4rbTcwWUVIaDJ3?=
 =?utf-8?B?T1lvV2FlOTRSbFU5TW5iR1E1MjFuWFFlKzBDcGF3NFlDZ0xWbXh4eTNWZ2lo?=
 =?utf-8?B?aVU5MVJVVG5Wb3RTZ09na0JyU2V5WDVwME5GZlB5RmlLcVo3bjZJNmJoaGFx?=
 =?utf-8?B?blErN1hYM0ZubUdOK1J0TGwzTHR3Wlh0K3ZtNDBtY2wxdTdrV3FCMXh4VkZG?=
 =?utf-8?B?akFBQ3FtOXMyQ2JLTVYvMXZ5alBqNUpJQURpbXFpbFBiNXdOM1l6VStrdDEw?=
 =?utf-8?B?dStCNm9QSnFNZm5CcGZSMFhxOWpLWUY0SzBGSGNyUHNpVTFxaHAwdVRPWG5J?=
 =?utf-8?B?NHVJOGhCNmVTMXlTL1ZPR2d4dDFhVG5RNDQyYi9hcVZtSWQ4Y1h1ZytCL2Vp?=
 =?utf-8?B?Ny8ybDNuUUdtR2Q4QzNuUWlwajlyNC9ZVFF3dVM3UHg3N1BPL2tObDJwNG80?=
 =?utf-8?B?eExnakJCUk5OMkJJT2oxUUhUWEJ0dzh6RzVuYzVNZFpDZ1RNZU1Udlg0d013?=
 =?utf-8?B?cmMxWjZPTmk1YWIzWlF5UUtQM08xdGZxNlkwL0EwT2ZIQU1GOUlSWjNPbHpl?=
 =?utf-8?B?RE5ZaWNkb05PaXlqRnhKMGpjZ2RrZzh2RGd3SUJ2OXFWWXdjN3VTdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e8f7cd-2547-4e49-2a41-08dedc53d00d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:16:06.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FXdJ1RcB8gjgvHiDnv9bJpRdtgdip0kyDR7LYZYLitCsueg+65lPla5pJkl4Zs9EsqEXcbo0MUIMwale484uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7048
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=parthiban@linumiz.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

On 6/15/26 3:13 PM, Parthiban wrote:
> On 5/31/26 11:30 AM, Parthiban Nallathambi wrote:
>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>> ---
>> Parthiban Nallathambi (10):
>>       target/tricore: replace legacy DPM/CPM CSFRs with CPXE/DPRE/DPWE
>>       target/tricore: implement memory protection in get_physical_address
>>       target/tricore: add tc39x CPU model
>>       hw/intc: add TriCore interrupt router
>>       hw/char: add TriCore ASCLIN UART controller
>>       hw/timer: add TriCore System Timer Module (STM)
>>       hw/tricore: add System Control Unit (SCU) device
>>       hw/tricore: wire peripherals into tc27x SoC
>>       MAINTAINERS: take over TriCore and add peripheral file paths
>>       hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB machine
> 
> Good evening, Ping for review. I know TriCore lags active maintainers.
> Looking forward to know how to handle it. I have few follow-up patch series
> which handles additional models and also newer cores.

Ping and looking forward for initial reviews for TriCore. 

Thanks,
Parthiban
> 
> Thanks,
> Parthiban


