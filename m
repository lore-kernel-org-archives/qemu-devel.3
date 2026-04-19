Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AA2EA719A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 12:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERWT-0007BR-UP; Sun, 19 Apr 2026 08:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wER5A-0001NZ-Mj
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 08:17:00 -0400
Received: from mail-koreacentralazon11023121.outbound.protection.outlook.com
 ([40.107.44.121] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wER58-0004je-Dk
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 08:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3k6QoxrBLH80NrDEV1QrLF3Bw5kwJfnQRpalt0Hg51a4f+mrgZcr+7nW9czwP1uHPEOqKDHtlZbNgYXYhtgzSqf53VocdMcy6QQg7Q3yh1lcSR9+BW8AGQ2sJ8vmLwxJK9MrYV/Qhja0LmvJNY5ZdpwjR+vp4ng//IrJvzFjuJv3VI/er1QvVnWzcu82y6htiNAWGz9bFm9RDEIYcPkrh1xEqy0EVLBaJIHk4Dhy1Pa+v1mp2TukfoqUwEJGYR6wSP23FMlsi2fN3oqxJgBzRqQ25ym67ypn2F9bPiagvTTDyCeSiq4yj5vs6QBh1ZPeigvceftphEeNMUkHK8WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGKtfth9tjeYPY+So7ZpukU9ou3wgXBUMwheRbIh7cA=;
 b=bsc3Il46WHvUa7inhZJmyhf6xYKs/3ZMQYrCuReg8v+BuL80YsWOfDLiJXjwavO+eNloUDxT91ZOerz284wj78LUJLUdVaEDhICrUPifSCSzsS0/1wzZUFzESvdCxAZaPwbCU1F2WytlUCxGBJU+SWS3Lmam4uWpALUHSWXHjh+vP/n5t1xiPFzFNuHDWwmzVwjFcNjdN/l76D8ewzLNRmeMohhZJhP+TqCqHh4xkZ+Qc8LV+GzbAa7UFNsjaOBeDFTtz/A/XMEXT6yxdlgh5lfAoD2mqvMR5h99ELHFkyOcf2VjGdGZEZzH4JIGfdyjiCeCIKjIN0HiR530tIO5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE1PPFAAD10C5E4.apcprd06.prod.outlook.com (2603:1096:108:1::425) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 19 Apr
 2026 12:11:45 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%6]) with mapi id 15.20.9818.032; Sun, 19 Apr 2026
 12:11:45 +0000
Message-ID: <a4aecdbb-12b5-4a95-8a7e-6b38550e5716@linumiz.com>
Date: Sun, 19 Apr 2026 14:11:41 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Eitan Eliahu <eitan_eliahu@hotmail.com>,
 Anton Kochkov <anton.kochkov@proton.me>,
 "Christoph.Seitz@infineon.com" <Christoph.Seitz@infineon.com>,
 "saravanan@linumiz.com" <saravanan@linumiz.com>
Subject: Re: [PATCH 11/28] MAINTAINERS: Remove Bastian Koppelmann
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-12-peter.maydell@linaro.org>
 <41813663-757c-4022-92b2-0c285f63d553@linaro.org>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <41813663-757c-4022-92b2-0c285f63d553@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0099.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::10) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE1PPFAAD10C5E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 47314cde-8b09-4d5e-841d-08de9e0cd2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Zr/2hL2JjEOHxteE0wYPMbSUyte0kNyEM2shvM3nqI2okYNmGKgeJDzj2GMiyWbxncFQKtqZNdVPngoio14VpYIqhfzxItFOJGLUSpXd0ruDek4q/+yvdOFG1dud+yuE3PltgRjR6bNRwIvkbM0bVIXm4rRUpulRHMB3RJGA5LD36WkozGhn81Ey3/aulmY5smcDXODzsugTGKrOIIHGFNskEeJ++oOiv3HtXlb9eP/wG0DTIP5GEmEV7L/yaeaCsil0AQkVWGOv3pxWAs1ZrIgXWLeBOMcbP1aJ8tdyEgOTN/4P0NBvLyGIOeuDJ1X1Cr4YUJ3mqLfXNqVWAZTbzo/THRwnTfDCa+OpGTjCw3hs/EYGpP825l3q0VVVTo2NpBmAV4yv7nyX4SopZ2a7Y6/BGHElq7XW2brNirHnDEJFRWD5Zn2aRRmjVxlOQYdWQwc3FcDfbU44ipSjauutv4AH+1tNiMi4dIRGz3m+p5EWHHKRDRSSMBhVCI82J8PY9M6lYhHZm5gNhY/mZ05rQCe24g+ActWvaSMutXkdZPlKwyXiytMbHugJBcDT4NAQKlJtUfTzfS/vjFERn/PdfHCDTtHJhRZlfsKckEHIoRnGseMJEYFn1n3rtjC/tmD/pnrv+S/mq5sWUjaRWa/buTAwgLK1PH39rgowHj7QIp0D6YoyRqziMpbRZWxjC/zm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE82SnplTHRoSFV4eTBBN2Qvd1o2N2RaK0JnTWdGZGNwVGxFcXIxUGkxK1E5?=
 =?utf-8?B?eXR2Y1g4UnQ1RmtVZjVHODVlbWpzTDFiUktEaEt2c1ZGalVTbXhKRUlob3R5?=
 =?utf-8?B?YWVDb0U5aVNZZFNtaExLMlRIcm84RE92dlB0Vmxxdm12SXFBMHQvYlEvVjkx?=
 =?utf-8?B?Qy9jTHdBYVdZeFduSkt0M3Y3VFVETXpIamZwY3hmMXZrbk4reU9LRkJjKy9U?=
 =?utf-8?B?alNyUHI5QnpOeFBmcWFLRktGV1FUdXVNMEo1dklWUjVsY0d2M0tnanFSRDlP?=
 =?utf-8?B?QTlHVVAwV3gyaS9tTWlXZzVqRWRWL3Zjc09vbE9uNnAyMGFhcHNtdmZta2xm?=
 =?utf-8?B?U3FySzJrRm5aOVZ2eTFYVUx0OTM2MXBSdUNpbytwcnUvZWE1K3N3ZXAxZFls?=
 =?utf-8?B?VytEbUVTWU83NFlEUlVMUGtCbXZvNVAxYytpTDU5K2ZicStiK0lObE1QZzZU?=
 =?utf-8?B?NnZvbXpDYlJXVno0L0h3WWhNNkowWDRCUUlBSTlkU0RNSlo2YXRKcXJld1Bt?=
 =?utf-8?B?c0NoSmJQdUIvNTJOalh5dFB3MDdMbzBOcVdvMnBuSFdkNTB0VEY0L2hvS05r?=
 =?utf-8?B?ZWRtUTUvNVNBaXFMTEZKdENhU2F3bEVGanUyT21yUVVsNitjc0F0UEtyQnVR?=
 =?utf-8?B?RmZiTGVSSzYzeHlQN2xkeUpZSG9kdGZNZHcvWFB0NzI2VHdQb1RKOC85VUdl?=
 =?utf-8?B?VHU4YTVOUm5nMi9sOW9sdk1KYXAvU2cwQldUVHlLeVl3d3UySzJ6ZnBaT3Vs?=
 =?utf-8?B?NWM5WmhtUkZ2RE8rWiszNlNyWTlJbHppZG9FWVNKZ0ZPTGhna09nVnNteXRF?=
 =?utf-8?B?V0QzMXJrS0NNNHJjODhtMk41U0k0bmdVYmlWZmVXOTltTEhKRUd5Qm53cjV5?=
 =?utf-8?B?R2Z6b0NjTG9nVzZOVDJqSll1aEwvNFJDM2xMWXJPdFlNem5PZmxiUWEyOUww?=
 =?utf-8?B?UGZMSjYwc3FEbXA1SGMxcWgxSk5mcVE0NWtVK3AwdUZnNXNEQm1qRkUwRkt5?=
 =?utf-8?B?cWpNSWZCeHFJWXZ4MFBZZ2VQV0xrK20yeDRVTFJ6dkVEL3BUWHNaTDhTTGJq?=
 =?utf-8?B?L3g3NUdMbXBrbEx5ZTE2ckEzQU9KeVVHSmtaS2RqMnpRTUJBVnBpR3VxWG5F?=
 =?utf-8?B?Q0FRSUFRRGcvcldvMmd3RlJ3blNzaEsrZ2pYSXpoQm9HMmxiMURqdVBVM2VV?=
 =?utf-8?B?SWxsVlRtT3p4Y0hPMENkbkJYbWtLVmgrUWx6ZklwVFpuTk5Bb3E2MS9VdjBV?=
 =?utf-8?B?V3BKbStzSTI3TEhObGJicjhvR1RrbGlMUjdBUXpTRlFFamkxb1FOMWdzOHBu?=
 =?utf-8?B?TmV2cG0rU0xncDA4LzdUaW1DYXZLS2NrTDdzbDdwSXQrYVlua0cyMjY2QmpO?=
 =?utf-8?B?dnpGUk9yQlkvYm9kTHVSUkF6RWd4UU9TU21EVGNCRm11VXgxeS94Vmc3c2NL?=
 =?utf-8?B?em9raGdOMmJodVluaEE0MHV6VVVDTDlJVStzQ2ZqNHJXSUZZYmJFZHUwWnMv?=
 =?utf-8?B?MW1BRklqOU5jR0JVeGRmZUVSZFF3NWdmSTQrY0JqSDA2MjhJQ2NBaUx2cWRU?=
 =?utf-8?B?YWNGS3N5R2ZjbnZCQ0ZIWUU5bVYzSThnWnB5enhKaGtDWkNlMjRlRnRSa1d3?=
 =?utf-8?B?REs4WTdwaWFJbUozZXUzYXdZN2lvalFCSEh4ZU84SWF2aVdHMkhWOW5qdEhP?=
 =?utf-8?B?TXNrN2cyNDZyREtaSE96bWlWVWczbW1wbDlHczJTQmFnVVNLL3EwbU9rSU8y?=
 =?utf-8?B?UDVMRkRBQUFSYjQzeW1ySE9SL1BNekpDMzgxZG02elFWcU82d2RycmZDcFd5?=
 =?utf-8?B?VjZjN1c1RTNGdFJhcjlZOXNXNWVQYnk5ZE5nUWNFa3JWdERLbDZmK1ZzSE02?=
 =?utf-8?B?RlhFZy9VMU9ad0ZOTmZnVFRrdjM3eEt0L1krLzdNTFF6SytLanV5UE5wVGph?=
 =?utf-8?B?TWU3c2Rqb2N4RUZnNFRsNTJad3pWSlV1TFRJd09aZW5WTTBrVkZtSmorbmIz?=
 =?utf-8?B?NS8rc3lzb1hiWnRYL0thdnl5OUJKRW41L3dzNmN4V1dMTjd6TURMWUY0WDBp?=
 =?utf-8?B?emMzc0FLK3ArVzFPWWtNZmRJSFVWUi9sL1ZtTWp2bloxc0VObzZpamJCclBP?=
 =?utf-8?B?L3lYUllOMmY0VzJwVjVMRnNaSGV0Tk5EWERlZlVsTXlqVlhYT0pQZFg2Wnh6?=
 =?utf-8?B?MU9WSWFxK2dvd05RSlFmTDczMXdzclkwaWpmNFd3Si9zc3hrUGdxR3QxU1Z6?=
 =?utf-8?B?SVNiS0ZWaVhMMGNyUXZUT29iTWxpMU03Y0hzQlptUitndnY4NFF4Nk9TS1E5?=
 =?utf-8?B?aGo5VjU2VkFkemg3M1hDL3pUVTBZQ2pEZjFBZ0JPNU9wdyszeU91Zz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47314cde-8b09-4d5e-841d-08de9e0cd2fd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 12:11:45.1687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEhD9pCodmT9iXGrERJ2FKKlRNyGM+EGWF9tXKqATnnhwyKGA4Af6CBnlOq8NG7OizB09TZacy7HodkboYmsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFAAD10C5E4
Received-SPF: pass client-ip=40.107.44.121; envelope-from=parthiban@linumiz.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 19 Apr 2026 08:45:08 -0400
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

On 4/16/26 1:35 PM, Philippe Mathieu-Daudé wrote:
> On 16/4/26 11:16, Peter Maydell wrote:
>> Bastian Koppelmann has not posted to qemu-devel in some years and did not
>> respond to a query about whether they still wished to be listed in
>> our MAINTAINERS file.  Remove them, on the assumption that they are
>> no longer active in QEMU.
>>
>> This makes the Tricore TCG CPUs orphan.
> 
> Cc'ing TriCore users.

Dear Peter, Philippe,

I am actively working on TriCore and plan to submit a patch series
that adds TC3x (TC397B) and TC4x (TC4D7) SoC emulation along with
a MAINTAINERS entry for myself.

The series is being cleaned up for upstream submission. In the
meantime, the working tree [1] and a v1.0.0 release [2] are available.

[1]: https://github.com/linumiz/qemu-tricore/tree/release/ifx/tricore-1.0
[2]: https://github.com/linumiz/qemu-tricore/releases/tag/v1.0.0

Thanks,
Parthiban
https://linumiz.com
https://www.linkedin.com/company/linumiz

> 
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bc7c9b61da..7817a1c97d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -446,8 +446,7 @@ F: include/hw/xtensa/xtensa-isa.h
>>   F: configs/devices/xtensa*/default.mak
>>     TriCore TCG CPUs
>> -M: Bastian Koppelmann <kbastian@rumtueddeln.de>
>> -S: Odd Fixes
>> +S: Orphan
>>   F: target/tricore/
>>   F: hw/tricore/
>>   F: include/hw/tricore/
> 
> 
> 


