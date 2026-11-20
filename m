Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6B606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=Xzj2qvw5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURR8-0005B7-Ed; Fri, 20 Nov 2026 11:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xURQz-0005Ag-MW
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:25:58 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xURQx-0001Lz-F4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:25:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZLL3wCtV8A8AhJfWcIAsFkl9/BhlO15dHfvNI/Jxxea8bpzH/23SibKSN8suag4Zy5plQ/YtexHrV9AZMfIfQjl3gmQpTgoeX5jCg2ASBmK1EPpKROmGbT/RZTiryqRoqHJX4HwVgfYaTkxSp8/6/TNKHkdlntYBnKFPoYhvWYCbvz2ZCfse5KEzX8909wkKd7XIkkt1Aztp154BdtZ8D0lqFeQqyHnj6EPRy31Aav+4mR752m81tS/MIqAU9eGWoUDaOG8+C6l9HKao/Skh72qCxrvswPBXFP7a/1+N87Y401X34Nz4+AgiSl0XYe7zjJsZ1CHUtm2ozpxt4M1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+KXDVCU+K9+AYipgJglzCyrXAw6cV27FXhza79ysxU=;
 b=bpZodgLDDERYJP8CP2yblALCAjNiGDFND8xXz2xeMegvo0zLCeNr2V9qGsZftL5qPKyn8GA0vNpv2pGNF9X6Y4HlP+x3hZorWj0riUQ4Oa17ykNMNPY65C9PkpWp8xKTGkbxIw71BKituqBBQvuh5fXdy9YY/+1QMOo4utRgB3b4zVlghzNE/abJhmBOkv9EL+fXbxr8MuhaOHskKz+OoWZ7XqcGK+hSoh3+J4DuzrKoPwv3Oilb+CvizQblQtzpLOdAKK6b3VBnOmL832l0IZB4Fi/bhc3iZLIMxNGi/aKtgFVIfOKnxN6ymTaw6c9uyCYoiVyOhJUdftZ1UYiWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+KXDVCU+K9+AYipgJglzCyrXAw6cV27FXhza79ysxU=;
 b=Xzj2qvw5SO31XPad/a6aNdEImuoXpJQrLSBdoGvZVDwInMtPJrwNyOMxNjpZYCxiZfyvLyzSue0FiMLCgPeW5N/o7Ue2HfFA6rWvaVe4CRk/J1/VBhgr7hFHtPxAz5CrD8cU2o2zE4jYj19sNj8xwiFLJS33fDcfJGOs8NRuOGFYw/bJJjziXH5EgQY5lq0DYPpVw849K50wNYsua6bBvftV2mac4acwxwOOxDFiXlRpxIccf1yaVLZOrl0zzIsFxKfCjS6C+W1kdwDTDsezMOz/KsEtWmgBBKWvE1SbwNX/7xhXuKDIhzIOP4Zo+aO1ZMt4JV2uQm2WMPn4zMPGdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB8350.eurprd08.prod.outlook.com (2603:10a6:20b:56c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 16:25:49 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 16:25:49 +0000
Message-ID: <6202967f-8bbb-45eb-9e97-b296f772d1a1@virtuozzo.com>
Date: Fri, 20 Nov 2026 17:25:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/10] system: add a watchdog for the Big QEMU Lock
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260915203455.580999-1-den@openvz.org>
 <awBz2AP3W6-XNQ9U@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <awBz2AP3W6-XNQ9U@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0053.eurprd09.prod.outlook.com
 (2603:10a6:802:1::42) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc514a4-0bcb-4990-5443-08df4722f006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|376014|366016|18002099003|6133799003|22082099003|261009223027099003|56012099006|261021121427099003|4143699003|261102124527099003|261102123227099003|261022113327099003|261021135927099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: 7veIG4KMAmtpQnpi/yl3qNhsLL6S2I5iRmnyk3m4WhoIjP4CtNzw8Ymo0Irp8p79n6GZWoTf5P9vq06QGhLcsUvdsca/MJVj3zhgnwZD9AdlZzKQ1qcm/oqSK91gJ2ZrPHCl8jUfkbvqVkt3tyN7a9z2BYAIMnbV9pgVM+Ys8e6sfDhP60dnL0spfcjwUVxKSmN4I5eJ/FCuifBV36jARV/1tdJ6BcDWpc3eTbQp/lYDMWmohrAErR4KXA/aUegWc1+lDWgq9MpjvrNnzaJY2z3pDnH6TD4qtQjzRX9clldrUE4MmWzkiFyRrbbcL5W7JTc51TQFyL6VMUKZ+hJ4IO/H3IykQZVu9E6sauKXDr3MA3bLmx3mZQSNKCazL9YDDTdN+E5NKt/M1DkW7FU4olI/WjPeVgkemvfqaec2MPNe+JdHmU7ktAPQopKfr0vpWHD22+7taQu0qPkBcMdkSvLQqhko3jzUMnwi7geeZyqBwR1rl74jTvmV4HemrtlR/r7pFxkA98e9wgaFwqwhV5V2a/MKNfw4An8a0zsIsM72rYVZaixuJ3CsEUckLgYfR30TecrI6D+a6we7lcB2ktF4zP2IU5gn1I9OOd+p0IsWqHiF5Ln6LBhG4pCMzKLzjHSfuCuT4MK9ykrsk2W8/2Sd1uNPzTnA3LUpf9mv4nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(56012099006)(261021121427099003)(4143699003)(261102124527099003)(261102123227099003)(261022113327099003)(261021135927099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJxZnVFSWlBSEExOTd1VUxFUUZEWUxWOW5DckdTT25ZRHZxenM4eE1mZUNT?=
 =?utf-8?B?RnU2alJJV2xFMkhndDRCTkl6bzZUQ1VRakNycVpXZ3FrN2YxclVWZm1xTC9m?=
 =?utf-8?B?U3dlS1dNY3hBZHlpMFdOMHpIQ2wxaXg4bjN4c1JCSmlYak1BL2VaRWVWUmNV?=
 =?utf-8?B?clptVXBJa2xCNzMxMjFqSnRqa3ZiYzZkUnVmeHdTUGoyK1NJZG1UMWNVTDU0?=
 =?utf-8?B?cnlHdFEzTnVTM0dQdU5XOFhrbFQ0TUl0RzEyZit6OHFndys4SUl6b0ZaR2ph?=
 =?utf-8?B?RkRkS3JjSWp2dDEyTUxQNWIyTTJjeFAwVVlUc1NQWVlkZHA2clA3N3hWbTRB?=
 =?utf-8?B?dEg4VU1mSzE1enU4cDNtZ2dna2ozdFZSdXR1WkIzZjlVcXdiNlg1ZnFFc0Zp?=
 =?utf-8?B?ZEFTekxnd2JVZEV6Q05YK3orbWRnTmhuQjVHU0xNWkFid2tRSGJMRlQ0eDQr?=
 =?utf-8?B?OVpwL0FyRW1IS01lbHNNMTgvNVMvNTZtMER6Tjg1R2pzOXhPUVdabndqekFw?=
 =?utf-8?B?bmZ4dFN3d1JQVjVaSEpDVE1teFRJYzJrRzRxTnZuYnN5c0U4d0EzVkpoalU4?=
 =?utf-8?B?LzV1R2ZlWnV1M0dKRUVVYTB5UU5ta3cyZGk1Tkp5dTQ0anhQY2phWmRyMG82?=
 =?utf-8?B?ZzhSQUNxKytLRkNYdXhSRmdXYWIrLzRjM21QMUhGcWQ4bDhHZmp0bnVUME1D?=
 =?utf-8?B?R2RqUUVuSnpOd0N4VWpaOXhrVVVLaVRZRWtlL25ETnR4RE8wanJHcmo5TDBw?=
 =?utf-8?B?SjJuc040ZWdKNmVxN29xUEZ4OWhMQXB0aFVleWdPcDV0bGhSZ1J4bnRsOFRT?=
 =?utf-8?B?SnI3OTRuQi9LdHR3dC9hdUF4K0NFeUM4QVRGSUhUZUkzWnFKOStFSU9wNDlQ?=
 =?utf-8?B?MFNCbnBxTTZIbkRtQmtwMENObExNbDNucVdjSnVTeUlQbXBCOWk2ZHpneWsw?=
 =?utf-8?B?bXFyei9kQTJ5NjBOc2xSVm0xOTljbmNMb0NvZVN0ZUJLNnJ4THg5WFRQKzJI?=
 =?utf-8?B?MjNKTUlXWVgyMHZlVkhBR3ZOdXJpK09oc3VpbEtxcWpJOHZpRmh1VzNZQ0Q0?=
 =?utf-8?B?MW5wU0NVNEI0eFNNcDl2bmV2NWwzRWpzME9jeEJPWHY5aUpoczd6blArVE90?=
 =?utf-8?B?WUVNaExBK3NzNzB5bjZCa3JCcnArbkp2b1BQSW5PUm8yQnU3cUZoSHE0d0Y4?=
 =?utf-8?B?b0NHQlU5WUdiaHUxaGY5VnFiazFQa093VWM1ZWRIdnFBbmFwdkMwU2t3bTNE?=
 =?utf-8?B?dHl5cHZuY3d5M0tkTDQ0UXE0WDh4NmxVNnpUZjlBOXRaZHZnSExhK1Q2aU9R?=
 =?utf-8?B?dlRFcXB4Znh4N25IbTRXMWxTQ1JMMk41RmJaTk5HSHhQOS9PMWNBUGw1UzJ0?=
 =?utf-8?B?Ungzb0NWampmck5GenZVNm5rblVWdXVEYm9PeFlhNFBiNDZPN1dQSncvRHZI?=
 =?utf-8?B?OGlpajN4MXhXVy9UTGIwNG1ncFJ6czh5SjFCZ1NxVkJsdXBuUDl5K3NEZmZq?=
 =?utf-8?B?YU1mYXhvSGliUHNOYXROUThqUS9zRlhVMks3c1RSV0VGeFBBNi9XeFhtbEI5?=
 =?utf-8?B?VWNuUlNZbnpidGZVYWJmbXAzenRmbFROTlZhd0NhOU8rUVJoSmtmVkZDRFhx?=
 =?utf-8?B?ckp2dUJkUmxBd3RWNWhSRmhZcEttTERIZWlJelBFZGtZVytJYmNFaWZtYnd4?=
 =?utf-8?B?N3VhNGF5dEZQNWNTbDBUdHFzSHNpTDA0amJZVkdUSWZzdm5qckI3NTFWNkFv?=
 =?utf-8?B?eDY3aVEyM012NXV4TTEzYmpOTEYvY3hTTnorbnFMUW1tWGRwUmhwbDhTdk5D?=
 =?utf-8?B?Z05UNHNZU1ZPVnhFcTVQS2E5MGNyMzdSWlFKcWxCcjVOcS9SY0FOb2JoR01Z?=
 =?utf-8?B?N3NGTUthV3pCS1g1dnp5OURGbzVseEV0Q0wxNitOckJEaXdTcU05K2lIME5L?=
 =?utf-8?B?TXg1WUhsZEtFS2p4dm16SFkxK3BkdzM3RDhmTEhzYTZ2YWJQRE1kRm5Sd2Ey?=
 =?utf-8?B?dDZMMjYyaDRpZzdmbGwvMUJ5TE1zTEtnR3Q3VlZRZDZaY1Exc0JlbkN3OE1t?=
 =?utf-8?B?NUEwa0ZsNEtnS0V1S0xMa1lZdWluM0o2RkJiTHNQQzZIRXh3RHdXVE9zQVhZ?=
 =?utf-8?B?K2ZXL2ZORWo4RmNOOWRTZ1huQmNUT21oZDY1Z09kLzVqQXJiT1AxRExmVThH?=
 =?utf-8?B?WmVCUDZ3MW5TQkM5eXJGSmpjQ1pOWTcwQUp1NVVmVXM0N0VaMDNtTUJiYkFp?=
 =?utf-8?B?c1FSMUc3TjFzdzFyRjJMV2gyeFRNL1BYaW52R1BXNDZFUUYxeXZMM2ZBOFhl?=
 =?utf-8?B?WFgxOTU3UU5zS1pFQTZTb3VMVGFPQkVJS3NLRVkxZHNDUURiTG1YbTU5akR4?=
 =?utf-8?Q?g5es/AaUBNHZk6P3e/pSIBBG4APVS4c9C+irm8u82b5Os?=
X-MS-Exchange-AntiSpam-MessageData-1: gP2PGj1lk2z4Bg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc514a4-0bcb-4990-5443-08df4722f006
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:25:49.2016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UITN8uQcQkjM9tunwg5YTpK/x9cTC72fwEp7h1YWrP6B9+CIqx/syOVGFR29TUtwTDweXiKrniRlst/tnXmWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8350
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 17:22, Daniel P. Berrangé wrote:
> On Tue, Sep 15, 2026 at 10:34:44PM +0200, Denis V. Lunev wrote:
>> A vCPU thread reacquires the BQL on every exit that needs userspace. A
>> holder that keeps it for tens of seconds stops every vCPU, the guest
>> reports a soft lockup or panics, and qemu itself records nothing. The
>> guest log is the only evidence, and it cannot say whether the hypervisor
>> held the lock or the guest wedged on its own.
>>
>> This series adds a BQL watchdog. A sampler thread watches a sequence
>> counter that bql_update_status() advances on every acquire and release.
>> One odd value across the whole window means one owner held the lock for
>> the whole window. On expiry the watchdog names the holder and prints the
>> state of every other thread:
>>
>>   qemu-system-x86_64: 2026-09-15T15:53:57Z BQL held for more than 100 ms by thread 168146
>>     168146  qemu-system-x86  S
>>         pc 0x785a4dbcb884 liburing.so.2+0x2884
>>         wchan io_cqring_wait
>>     168147  call_rcu         S
>>         pc 0x785a4d534acb syscall+0x1b
>>         wchan futex_do_wait
>>     168148  IO mon_iothread  S
>>         pc 0x785a4d4ac802 libc.so.6+0xac802
>>         wchan poll_schedule_timeout.constprop.0
>>
>> With CAP_SYS_ADMIN the wchan line becomes the kernel stack. The pc line
>> comes from signalling each thread and reading the program counter out of
>> its signal frame, which is what tells a thread spinning in userspace
>> from one asleep in a syscall.
>>
>> The watchdog is off by default and stays quiet under a debugger. Two
>> machine properties drive it: bql-watchdog-ms sets the deadline, on the
>> command line or over qom-set at any time, and bql-watchdog-abort turns
>> the report into a core dump for hosts where the answer is worth more
>> than the guest.
>>
>> Patches 1 to 6 are the pieces: a fix for bql_locked across the timed
>> condvar wait, a debugger check, the per-thread state reader and its
>> kernel stack and program counter extensions, and the signal reserved for
>> the latter. Patches 7 to 9 are the watchdog itself. Patch 10 is a
>> functional test that holds the BQL through an HMP qemu-io write to a
>> null-co node with a latency longer than the deadline.
>>
>> The program counter lives at a host specific offset in the signal frame,
>> so patch 6 reads it through a host/include header. The Linux headers for
>> aarch64, ppc64, riscv64, s390x and loongarch64 repeat what linux-user's
>> host-signal.h already knows about those frames, but only the x86_64 one
>> has been compiled here, and the Windows half of patch 1 has not been
>> compiled either.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Cc: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>
>> Denis V. Lunev (10):
>>   util/qemu-thread: track bql_locked across the timed condvar wait
>>   oslib: add qemu_debugger_attached()
>>   oslib: add qemu_thread_states()
>>   oslib: report kernel stacks in qemu_thread_states()
>>   util/qemu-thread: reserve a signal for thread introspection
>>   oslib: report each thread's program counter
>>   system/cpus: report a BQL held past a deadline
>>   system/cpus: hold off the BQL watchdog under a debugger
>>   system/cpus: add bql-watchdog-abort
>>   tests/functional: cover the BQL watchdog
>>
>>  host/include/aarch64/host/signal-pc.h         |  20 ++
>>  host/include/generic/host/signal-pc.h         |  11 +
>>  host/include/loongarch64/host/signal-pc.h     |  20 ++
>>  host/include/ppc64/host/signal-pc.h           |  22 ++
>>  host/include/riscv64/host/signal-pc.h         |  20 ++
>>  host/include/s390x/host/signal-pc.h           |  20 ++
>>  host/include/x86_64/host/signal-pc.h          |  20 ++
>>  hw/core/machine.c                             |  44 +++
>>  include/qemu/osdep.h                          |  29 ++
>>  include/system/cpus.h                         |   8 +
>>  meson.build                                   |   2 +
>>  qemu-options.hx                               |  11 +
>>  system/cpus.c                                 | 143 ++++++++
>>  tests/functional/generic/meson.build          |   1 +
>>  tests/functional/generic/test_bql_watchdog.py |  60 ++++
>>  util/oslib-posix.c                            | 316 ++++++++++++++++++
> As a general point that doesn't fit any single patch, IMHO
> it is undesirable to be putting all this logic into the
> oslib-posix.c file.
>
> It likely justifies being put into a standalone file eg a
> new 'debug.c'
Good point. Thanks

