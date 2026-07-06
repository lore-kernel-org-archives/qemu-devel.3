Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC90C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfeh-00029M-N4; Mon, 06 Jul 2026 05:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wgfeZ-00026o-FZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:30:15 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wgfeW-0007w4-1Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:30:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzmQElcsD9D81Ehg8WiHF8OocxOHyqk8t50/so4Vkz/Lu7iRL/6Db8to88CidjRJ9csnRPK7//c/czZC1JynSqAwe+NuMmKykj8rn0PNBlclqYL0UtCf1txAYwJchKfQ5Z4ymABchC5uiCUP1462sGvF4BWxziUlln8Uy7UocipoHwNYyTfJVwtHx9xnnkNjdvg/o90TLVf5DXiya4x4ta9TvkLeZyfaS36BO5cTH6wZxrTqPv426XgxPK39WPUXnakRGPrdFnH2rdfq4XZevXh9IGO+k4U50fJsUjhjq19iXP9W6b4KKymvS5fX/1ubOezjObE1lR0KVAVpEStYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jdCQkRldD5jutvJHgu5zVQcMVeDP96Za4yj2yZrT/I=;
 b=iWqVTUdyLav9JoI842/t6K004lj5s/vi/XcVcF7q2mB7m/0Bj5uJp0cNhlVvhqUqll1LBGVxZd1C7gMhVEK9GHrw7njFTscE5vt9cWVzlrG38kM7TpUjKzpTzKOakbbS0eEUGAkeTEUuPkfpYm6TMP7X+DJ5Yx3aibtiZDEa3B0ls2W1qyaU72CY1ucf2+LV+Q0wC9/XTkLBLRL/27ZWFzuVOJRlP8+PBmEV8phTKzB9bbR5sIw7TS1QMdR6Y9aje/TklCoJSNcbcDrSkpVvJGdgdiTfVenRiiPmmoNr7jDL4+QwaPhxvjTFOWP1AHN+sd4zs97iQKDzxKtrXk0pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jdCQkRldD5jutvJHgu5zVQcMVeDP96Za4yj2yZrT/I=;
 b=iSE3SY6kVIDstheMRg8trSJUWPMZAaAFKlKmkclvy2vUs8ZIUrKzFOkEV5lMgNhgUDCtWn8i/2VpU180b12Gm9kP6cvgdT8IJH4Syr6t+sskB5xp49aYq8//O/1WeDs71/d8GvZ0mnliMvlIGf6Jtr33lFcG042NPpbGXINrwFVGKgRVAn7WlLAadTrp6j63No75OjncEUisFQilxmlCx6E2vdUW+ArchFHje6cDcOZrXZgHmlMmzxBfkFuBaNuiNNfpQqkfqFSjNEbV1Ti4azm+lHm2tIKJ5bptMUG34jr3JEZdtPcCbN5w1szaFkj6KAiTfn0G4yit9PMMJI0OSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SA6PR18MB6221.namprd18.prod.outlook.com (2603:10b6:806:411::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 09:30:07 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 09:30:07 +0000
Message-ID: <ee859860-1eb8-4da5-bf26-f5218508f940@axiado.com>
Date: Mon, 6 Jul 2026 17:30:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Add Axiado SoC AX3000 and EVK board
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com
References: <20260622060507.83195-1-kchiu@axiado.com>
 <CAFEAcA9aPwGf9acMvBMON+mNU+uyvMs33wrmAXxoTFR80vi-rQ@mail.gmail.com>
 <ae7c1ca5-2268-4b19-8ca8-188974497955@axiado.com>
 <CAFEAcA_4zrzjZq0EzsiRudBkwjM9bTai992QyDhzULnSOv2=pQ@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA_4zrzjZq0EzsiRudBkwjM9bTai992QyDhzULnSOv2=pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SA6PR18MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 89171dcf-e7c5-4ba8-e683-08dedb412adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y/BvMYkQJ1K9jRMINeIfd3BPyShVXwkcPUTrrW8a2kp2fmNsnJu49NoAmpRldYl8CUcHnxqC8aHjCE0vhW5vCRBfPbPSFRdeWfSJ06LBSJUK0pDFtP0wGzQquMvlOck3/IN94ZpIFkJMseTmhrAYaijeQX1t4qT+Q7N4A92dbg00Fh7luutEmC8u9kcZ4Dw4Q3aj45SAopJRNfGtbIPJX0qOtBemtxoX4zJFNZQYWZBjoB25Dbz/0/4ujRnTMd9ykMKrBDjXyrf6CexgIPS69Rnc+yS/IeNoNkuzFry3fMvUNA0W7SBlov1jUOAOfBA9oKYzIbs9jJiP2PdavxO18LLSMwY7qyvDcV3hNIohc00GVgMaGMkWghmvQ4uL/lNPmUavi6SMAuHT1h5gDl0aOLz0Y6WCY3FuzCQsxC5+pfpiNtHVVCYS8PFIlES6mPeVrFSsDpUZ8YOJbnKOht7M/3UpZLj0p0G7DlAkpPvjWMjiHs7K1NhHE3KXiDKrUD39bzKCxCur+H6vs/pMDGA7pDPP6CBUenOdgaUzBs2bwwGezQEHEHRDzT/RyR/pVHwPf2AyhYtB83XfOsQp3aIGcOvnHgrzkpPrJ4wlIIfxBkbCPoLvHUOeBKDHGRY/bs6lt6ZOYn7IO2cwZZh+0xVMTKQFUEHRXZv3qoxscdELiKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWJMTnZ5Umx3MGxsQmZqby8yODd6S3U2VmllYnUvQlJGUnBpaU9TM1dJTXRQ?=
 =?utf-8?B?THg5ZGJRWkUyamNxR1BvU3NqVE1XOHlrbmR1L0JJSHZKR0ZweDU5b3FOZHVJ?=
 =?utf-8?B?bXF4OWIwQUtKVFJjSjg1eVRtNG1Dai9uRGxDa0lIVmRZalVEb3pMZzF2RmNR?=
 =?utf-8?B?Sjhxb3BIOXBVbkVMRnZZbzc2STBkd2hGUHF6L1JiOWJsWSs5bllkcTR5ZFhT?=
 =?utf-8?B?RGxpckQvYldpVXFMTzRDKzRtZ3o5QzZnekl6UGMrbnlEclFaMk80aVNSSGh6?=
 =?utf-8?B?a1VUQlRTbHlEVVFwWlkrNEo4NDc0WTk4RjhMOVE1bGRwVTRyMkJ3UUJnN1o0?=
 =?utf-8?B?RTk0R0c2Q1BET3kwWjM1K29rTkcxQSthS2U4YUV2TDN1Qzljb01OWGtUdWc3?=
 =?utf-8?B?eVJXQlNhRGZmanIxbTBDRUwwblNqYW41Qk9nRlcwL3RnenltY3NWUnlIQW91?=
 =?utf-8?B?akZkVGJ5ZGs3YzBOTm9UZEI2VjFFOHhvd01SYkZpSDRndUx5QmRTNDZBN2NG?=
 =?utf-8?B?WXl2V09oditSc2VTWDlrdEhZc056QVU2eFJOdEZwV3pub09LZXFhMXZMNklk?=
 =?utf-8?B?MG83Q1JXRytQanp3MVBUdDJzaHRTM0EyckEzWGFlMmo3dFlCRjFxM21oYkFC?=
 =?utf-8?B?QWc0d1hFSmwwVXNZeWJhSlNaWHU5K0VOeTV4SjlVampoU3MwVS80eXIyRHVG?=
 =?utf-8?B?ZXAveUF1OEFKVkVYa1ZQdWR0OUNIczIrbG1wNUN0NXVGd1VQTmpZZTVLdng4?=
 =?utf-8?B?azJTREdYUnBIRXFvc1BMQUZna2U3bUtuZWVIRFkvSHladzN6TldUcXB1SXVU?=
 =?utf-8?B?TWhpRnJ0ZlRNaGNvQ0hYT3pNMnpHUDV3YTZsQTZmUXMvK21Pc25zR3JxMEE3?=
 =?utf-8?B?bGNSa3Bha1dIVStnTmF0ZExZSDFmNDkvbnFWZUlSbTFCTDZlNDlZYStUY3B1?=
 =?utf-8?B?TTBVRnZqVFk2dWJwYzNNbkxyc1hJTXRiWDJSeVlvK1RrTTh2UWxLVXhOZTgv?=
 =?utf-8?B?MWpIOElFazhseWMxcXpTeXpVTE9HUGlGMEV1ODI4UThSNi8vTjdYZnFYOUt6?=
 =?utf-8?B?ckY0L2tuQ0daU1R0RzlvVXE0WE5aZHFLcEM4bDdTdUNoRHNOTlFsQnVPWEc2?=
 =?utf-8?B?OVFyWGRDbEZHSCtmTW5hSTBDdkZMZWdXVzdNWjZGV1BkdXB6VnVIb3ExemJk?=
 =?utf-8?B?S3QyRUZiTmt3Tklya01nckRnRTc5Mk9ZbEFMSXVPbWFBTFU5elRYYkdPUnBV?=
 =?utf-8?B?QVhGSnpaTjFaUjBWQTM2T0xPTnZybE1Ia2hWaHJUYXdGa0E1YTFzMzNoQ3BR?=
 =?utf-8?B?WlhZRjI2eGNBYldZZ1RZcDVQTzc1anRkSWNuR0x5cHovME04VFF6TFRaK2Yx?=
 =?utf-8?B?bXNUTjQwcVBjZTc3cUZoVk55SXV0bS8vTk1TVzZoQkhqV3VDRWlIUm1ycXVO?=
 =?utf-8?B?b0ljeDZWRHVqMjJvZkpuRWh2dHcySW84Q3U0ejQzYWlKbjZMcnRZMUJ3eXRI?=
 =?utf-8?B?VXBhVENEVnVXMHczNG8yVWY0Zm5wTFZ0aU1BME9HaDFMYVBsVUJ5eklidklE?=
 =?utf-8?B?NE1RTFRyMStLZ3FETzJiaDRESC8zSFliSXBxczlRM3BCMFpUTVVmeU5tYlo4?=
 =?utf-8?B?WVJ4OWlvaFUrdWJEMUpLYy9qOE4vZTVzL2pXQmJCRWhoYnhjcGtJUHFodlc2?=
 =?utf-8?B?Ni9DbExlTWtCcE13TlhDeWRIWStBQklJa3dPZEEyelQ3U1pLaEtveTE4Qm93?=
 =?utf-8?B?UXljbnJSTTUxMEdrQ1hUOGxQcmlDa21WSFArQ29Hc1RIK0ZPdzN4aHcrdVRy?=
 =?utf-8?B?VFliWldHL0VjeW04K3dNWWJWR25vMzFYSkszd01PRjlGMjI3VHp5WXdVOEJF?=
 =?utf-8?B?U3RhVXRsZFVqSllUYjZ1K05Ka2dXaUQ1N0I3ZmJqK3hic0NzNDdmTWswZ1RH?=
 =?utf-8?B?TmdxeXUvOXhVaTh3MlA3dHdNSE1hVUxaTXg3Tm1obnU2c0puL1hralBTdmRi?=
 =?utf-8?B?a0dUdUluczZGdWcrN3hUZmhpanhqcTFSM0phTldpNjF4YW0zM0syaFhzRk5G?=
 =?utf-8?B?cTltZ1puZzRiblJ3eWlyeUJ3b0lDaFBpcm5hOEQxbjJHdWprYmpGQ3h0VVNF?=
 =?utf-8?B?NEg3Z2JsYno2eUhwbjRoRWd5Q1czZnhhSTlFelNLcXVKSDVEZE15emNESU8r?=
 =?utf-8?B?YXd5bHkzK1R4WW1lQnpsblpuNHBrdTlCOXVXc2tOQjBsem5rTWVHSXFEL0Vv?=
 =?utf-8?B?a3dCdElzNXZvbkF4b3J2YzNIeU5wcWZTUWczNkc0YWFGSEYrRlJKYU9pWW44?=
 =?utf-8?B?ZnBSNVVucjJUTlN0anFUZXlBS3JzQXNveHN0S0YvWEhNWnFOVlU5QT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89171dcf-e7c5-4ba8-e683-08dedb412adc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:30:07.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0S+cJYb9Hsc3CniCpx9o9o26zi2WN+B8UqIrE3UBVi2ny94i/wFyihDmQajL+YkuR0wNHeKgk1arM8OntvmuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6221
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=kchiu@axiado.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


Peter Maydell 於 2026/7/6 下午 05:23 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Mon, 6 Jul 2026 at 03:38, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>>
>> Peter Maydell 於 2026/7/3 下午 07:38 寫道:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Mon, 22 Jun 2026 at 07:05, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>>>> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
>>>> The model for Axiado SoC AX3000 supports
>>>>     4 Cortex-A53 CPUs
>>>>     Arm Generic Interrupt Controller v3
>>>>     4 Cadence UARTs
>>>>     1 SDHCI controller with PHY
>>>>     8 Cadence GPIOs
>>> This causes 'make check' to fail. Please test this kind of
>>> thing before submission.
>>>
>>> Hint: running QEMU without any other arguments crashes:
>>>    qemu-system-aarch64 -machine axiado-scm3003
>> Hi PMM
>>
>> Does you mean this patch set is not buildable or it must be passed
>> without any other arguments?
> I mean that the code you add must not cause our standard
> test suite (which you can run with "make check" and
> "make check-functional") to fail. One of the things it does
> involves running every board model with no extra arguments.
>
> More generally, regardless of what command line arguments the
> user gives, QEMU should not crash. If the arguments don't
> make sense, report an error message.
>
> -- PMM
Got it.
I will run the "make check" and "make check-functional" then fix all of 
the problems in v7 to pass the test

