Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA93CA5FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpvR-0002n1-Oq; Wed, 30 Sep 2026 04:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBpvQ-0002lQ-6x
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:44:28 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBpvO-0001kh-Gz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urEgdY6DWrKfCK1LyVAXqdDWTeKnwXxDsTn5Xrk9vTdgc+GPZMN7D+Clu3XNoqeBAPhv6NH4m1R/QZP1Uk2X6Wpi3L9cS3LkwVlTzhjOGJPmT5AkXnQMM0VcUejJ/BlV34ZPnBuBecKPVMELj/7S5UhRAhJvzyA74xwn5e52sAh/pjyzIok59tMUKa3D/+fpnrV9R4XdxKEfifCeIRIh7Oh0zOmuzks+AHjSBcvadR17x/yWWAhuB74m4Iqlub1kncAlaq3iA9oN+qWoaBjihFkxo19pRhvkdrCLPn0j8ET0kVT5x2KOuNC+HaeMgQVhESsL4vXeC0W1ZnKK+E/k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcu37UWZdP2mLXfFo7vi4JgTlBAwPwFay7ptodLY+AA=;
 b=giKkTIYeImKsaxJGOm2Kd/3AsFYPqd9CLgv4XFQcrDHTIF5tTAMCqclfWS/yy/MvfeUvy8I2alXLHQiD2L6L2mzFAyDNPDnOofNpBJ1NrX/w2mSdotBY51QNZX/i5Zp+uzAPur0qXdlf6KO8C6HhPx5P4LYsMw+nzNFbhJsI3Q/tBr5OwQckpyzls3A6NcJy6Y+1VaitSkJm4zDu0BdqJcGXBjUMiGpltlNw2renBqXijz3x4s8VGmdPqVkM/TxehcDbtd0gCFSZJkQ5wsHUxi35UQmsOfldsSdM85GOlIxkptqltYRgaj7KvvBk7r0FkbBODV+8OuXuXi9UE1olVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcu37UWZdP2mLXfFo7vi4JgTlBAwPwFay7ptodLY+AA=;
 b=AdLmbegRaUPBfpqwWPJPG6w1PMFmLAUfdtvoV1bFYqUQvYw1Jzgrsq8lMug00uFzcQj2YIskTXIbOwHA4EHXyCOXLMcXIwcQW1+uZlp+CJVT9DJDBH+9DOvn2JTiMrDv+oMNA8cwPr7kPhDuZw+ZGHEomCSCp0vYoiwLMoHzgkC2yQoK9UpPwNl96O0RA1wApq62FxAb7D45aw8nlouH1obITxvtJM/fqcqj0ifo4bw9JCAVx52LGFVyirJTfk7e4lO+tEuh3CYqgZCHt2o5vKzI9ZBD5OIMaCtfY3gQ+8Dz/nYmkt+Y8P18EvP2qO2Qh/61tvDvNULo+QYZKxwmJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB8258.eurprd08.prod.outlook.com
 (2603:10a6:150:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 08:44:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 08:44:16 +0000
Message-ID: <29e8235e-24e0-4424-bbb3-d23b7cda91ad@virtuozzo.com>
Date: Wed, 30 Sep 2026 11:44:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/17] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com,
 den@openvz.org, mark.kanda@oracle.com, vsementsov@yandex-team.ru,
 farosas@suse.de, sgarzare@redhat.com, bchaney@akamai.com,
 dongli.zhang@oracle.com
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
 <arwIKeh92voz6Bhw@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arwIKeh92voz6Bhw@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd393d5-fabf-4391-71d6-08df1ecf0271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|7416014|366016|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q1PcgrllFaA70/OAV6+yDiar0xPhDihjJJgx7VGVI5rT9u9HSQ+L/dZyLAqBg7X/IwyxNMYYmp3jFxVQ1nj2Vqn9G6gFDi5RgG/jYSx99kEPQ/WjCaTe0Uuu/UXOsinMA47w9U6NUfl8nnBxRtFaxwIFOT6RGCagoknn8ZEplO+fvVvoeEb2JP8irYG4X5S+6JHveH2N9GdGyaDRhxSO5VColcD/OZvP5JZCW9Cu2nOKuDssI0FCYAwE6V8mo06SorSvQnImeQJOShpucGGWQfJXTpV09EDsN36H3xPLlHpDuakk9OVs6UUwL9vsjFBmT9Lft72BM+oWuIJogyslx9JPkHFUeasSqsiG6g2bkoWWZPm1Sr2Sh1+Y+HiA6n/XIuVmoy/8UMNDPkih88meJQEZ6hkwKqzjSwoo4BO9Czc1Su9Os/e1k5CadCNAfJ/gH/uzsURDhNuqBgDfdyACmOBHY7UwN6l4ZIugmcESPw3wQino8i2eLozQge1C2KLp714qhoUU9uTD4Et/h15gmdGdk0ZS+Unv5WteEnFeqMxOdLih3b8mxMpgsXhaKIoOqIvf9r1h02DHnkBGQovfHUL/OsPo80nZ2KWv/Jgdag0zS4gWigodO0DbT85oxngYlKwoFG+RaXekNOoCwB7t/Gjaj/Dizg7dY2uFGXYP4HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M01iOUJlK1ppQ2ZNZURMK2lmbXVrMjdjZWRNVEVKcERtUkFZRmJyOTVwQkIr?=
 =?utf-8?B?MGEzSTY0T1N2NXZvWmE4cnlNN0tpcTVxdlZ4RStmSTBlUkI2Z0dJNnZ6Tk9D?=
 =?utf-8?B?SnhZZS82QnJ4cWhhRzlGbVNod2U5RWQ3UFpvd3lpcG1LOWloYW9rRmZvR2Fu?=
 =?utf-8?B?RXhhMTdXM1FuN2QycjQ0eXovcU91SHEwK29wdFNONHh6UHRYL2VWQTRvaFNx?=
 =?utf-8?B?MWtmb3FINnRtRkQxWkhPUGIzQmJlSVBxRDlzeWRUd3VESGtZY3NzSXJEQ0FT?=
 =?utf-8?B?cTZJd1Z5OWIzUGsza2FoQ3ZtK3l6OXNjR2NoZDFPd3ZITWJXZ01VbGc5MVlG?=
 =?utf-8?B?NlNvZlgvVENqMXF4ZkJ2NkIyT0VPNWNpVXNrMjZ1RGVESUdGWFJRbFFVSDFV?=
 =?utf-8?B?RjZ5cW9XNEpPaDAwb2dNU1JSQkdFcWFqYkh2ZTVrNmlZOU51SzlOWHRtSDl5?=
 =?utf-8?B?OW5oRHFaZi9FSjNlMlBZMmZEYjZLNC9hUUhNc1d6VjVDc2RwTmtGZjRkQldR?=
 =?utf-8?B?cUtnRWVDWStBQUMyRDZqRXQ3SjMvaWNnZ3ZaNjJnV3U5VzJ1TUdCd2tHZFFX?=
 =?utf-8?B?R1NNbll1a0hCdXdoVVljUnpaM2NuSDlYbmdPdWxnQmJQV0poalRtUC91d2Nh?=
 =?utf-8?B?OGNrZStkNDZoQWFnWWFvckJYS0xJdHI1SWU4dnRNK3duOHpUak5aQnhnVm8v?=
 =?utf-8?B?OHptTEFTQVBFRjF2M285SUt6Sm8ybTErR0VQblVKSXF2L3VLeDVESUR1QVNC?=
 =?utf-8?B?RlNrbHBUWVcxeFFreUpFakVGTTFBYzRDd1RFbWpwSmg0TUNNRjRmbU01Qzg0?=
 =?utf-8?B?aGw5aWNzRUZOQXdRNkFRZ0Vvb2d0RloyT002bFhySnpzVXBJZlRNMFRuZGlS?=
 =?utf-8?B?N2g1eXlQUExjc0JRelJ5ZTRISEw1UmJieldDK1pjMVlYL1JHbjFHdXgxL2Fa?=
 =?utf-8?B?am14MHd1eUk5aXpXNWw1YnNtU1lzKzdlYW5qbEVaOExxTHF2WEdsTEtXdDZk?=
 =?utf-8?B?TlVoM1BKVzNiTVhDNUM1MFlpZGpyaEYweWdQcm10UVdtQWRDeERlQVBCdVJ4?=
 =?utf-8?B?Z2NFcEpkN0o3andQTWE3QklmdnhZbVB4Rll0d3ZqcE1Wbk1jUzBacXg4bjhO?=
 =?utf-8?B?NGhCME1BOUdvVFlWV2JpbWMwOHVmODhWbVN3bGVVVXBBZy9iM0hVbnV0akc5?=
 =?utf-8?B?QTFyYmRpWXEzSXhqakgzUVhSYVRpV0Y5M000S0FYbHFFbTNibVFMSC9lWHgx?=
 =?utf-8?B?REFTczVwMlRLaXh5ZVRCWnYzZ21GSTYzUXVDU0g4T3pDYU1ObEhmYlBtV09J?=
 =?utf-8?B?U3owRDVPdzJMZHdwcklnQlZ5ODlXa0VwWkY0NDNINy8wcEExTlZTQS9YYWZK?=
 =?utf-8?B?Sk9CWHR2dTVVVGI4TmlFc3lERERIQ2hROHd4SU1VNG03R3ZoZG1VYVpXM0pO?=
 =?utf-8?B?OTB3d3pwSG9HWXVsenIyZFd4bUt3MXp3R1RyenVpSm5vcnlVZUw3VmRZRVph?=
 =?utf-8?B?RU9CNU1rK0hVWWlrTGIwRVdNSlZjcktmYS8yWTlOME1zVnNDb21aZ2tSaGVV?=
 =?utf-8?B?SDJQZWw1TmpiZnY2MEVka0NTVFlvcTBRMUlqV2t6cG5lRTRxNzRIa0ZjUXRk?=
 =?utf-8?B?ZCt0UTRadStZUGNhRzFLR1FNcm5xTmZKS1RPdUpPRDF4cXlsQ21GWmk0M1kr?=
 =?utf-8?B?WlVxbUF2K2NBQWkzOWx4RUVzV1dVN0RMdzExWE9YejdoekxHdUFxZ0ZsdFZN?=
 =?utf-8?B?clN4NU8xMWVjNXNsSVdPQ0RoSEhFM1dINHBvcUQrRzhnK3JiWXBjVitHWWpY?=
 =?utf-8?B?NnRkcWpZQU9XM1kzRklyT21aaFp6SDRTbENZdmRLYlhVMjE0MWZ5QkJJbVRE?=
 =?utf-8?B?eXdJbzZGUzZ3QUNtektHQjNkZHErUUNrbXBKZmxmVmw0eWozalkvdVloaEox?=
 =?utf-8?B?TnZDRkxyVm4wV2pKaS85QlIzL25jQ1Jqb2QyWkQ5RDRDeUhMcWlsSGRFVXU4?=
 =?utf-8?B?WkRtQ2tBSWoySjV0dFVSSThsTVQrUG1mTGtybm1sd2dqWjJkb3IxY3VMYXlJ?=
 =?utf-8?B?dTd3ZUJyRmpMVUlmRTVrUmpoMzVuVGJaZ0h2WmMreVZ5cWczQjFpQkZ5Y2Uz?=
 =?utf-8?B?YzFpS0dOYU1PM09vRzZnei9XeWZPb2tIMVk2S29kUWZ0cGU3bzNaaGk3VTNL?=
 =?utf-8?B?ZnlRVlhKY0kzaUtrbmZPaDRtSFVLRnhQZG9sRndTcVQ0YmMxd29nSzZBclli?=
 =?utf-8?B?Z05Jc2dhYXpoSEZ1azVLTklEbCsyNDU2SjYwOUMxMWdXSlA3MnZiVzg1aGVL?=
 =?utf-8?B?U3pLTzNzdGpjcjFqSDNLVnM0MHg3MmhqTXBjamZXYTF2NENLNVBXQ3hKeFlZ?=
 =?utf-8?Q?mbWcG/iSXxxcx4N8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd393d5-fabf-4391-71d6-08df1ecf0271
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:44:15.9483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ama+0V6Qjavi3PaZbxyFwst13VSuLVJKtpcLjubl3gO6qqev91wD59Tnk9Bf3Zlw4J2YdGPPmS5jECUZjpT1t8QjVqDJWQG2vftZ+gFXdeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8258
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/29/26 9:49 PM, Peter Xu wrote:
> On Tue, Sep 29, 2026 at 08:23:24PM +0300, Andrey Drobyshev wrote:
>> Snapshots are refused whenever a CPR migration mode is set.  Add a test
>> which sets each of the CPR modes in turn and checks that 'savevm' and
>> 'loadvm' fail with the corresponding error, then switches back to
>> 'normal' mode and checks that the error is gone.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One thing to mention below..
> 
>> ---
>>  tests/qtest/migration/cpr-tests.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 0bec753b4ab..2be0fc8c07e 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -290,6 +290,40 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>>      test_cpr_exec(args);
>>  }
>>  
>> +/* Snapshots must be refused while a CPR migration mode is set */
>> +static void test_mode_no_snapshot(char *name, MigrateCommon *args)
>> +{
>> +    static const char *const modes[] = {
>> +        "cpr-reboot", "cpr-transfer", "cpr-exec",
>> +    };
>> +    QTestState *vm = qtest_init("-nodefaults");
>> +    char *out;
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(modes); i++) {
>> +        g_autofree char *expected = g_strdup_printf(
>> +            "Snapshots are not compatible with migration mode %s", modes[i]);
>> +
>> +        migrate_set_parameter_str(vm, "mode", modes[i]);
>> +
>> +        out = qtest_hmp(vm, "savevm snap");
>> +        g_assert_nonnull(strstr(out, expected));
>> +        g_free(out);
>> +
>> +        out = qtest_hmp(vm, "loadvm snap");
>> +        g_assert_nonnull(strstr(out, expected));
>> +        g_free(out);
>> +    }
>> +
>> +    /* Back in normal mode the mode check no longer fires */
>> +    migrate_set_parameter_str(vm, "mode", "normal");
>> +    out = qtest_hmp(vm, "savevm snap");
>> +    g_assert_null(strstr(out, "not compatible with migration mode"));
> 
> What it looks like is it tries one more time with normal mode then a
> snapshot should be correctly taken.  In reality, behavior with current
> qtest_init():
> 
> {"return": "Error: no block device can store vmstate for snapshot\r\n"}
> 
> So yes, the check is working, but slightly obscure on what is expected to
> happen.  Maybe worth a comment if there's a repost.  It also answers why
> there's no "snap" snapshot leftover not cleaned up.
Agreed, it's indeed slightly obscure.  I'll add the comment explaining
we only check that the mode failure no longer happens.

Thanks,
Andrey

