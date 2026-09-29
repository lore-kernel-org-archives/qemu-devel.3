Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9568BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXtJ-0000xp-NQ; Tue, 29 Sep 2026 09:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBXtI-0000xN-58
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:29:04 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBXtG-0003j4-HA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGnBtewNCrAaahm8cqUVu+t0f+TDuYZGr1YfVzXEERSIQVTBo99bJWmGGGCNHiTGP22wDYh4Jvx3LQ+VtMQyiG7ZV8G9GLRcc92DxMGBVKGhHjWsTro6BzMdTsuizamB6ICaq6rD11UUs1PM/NcYuOvzLwQX+Ql6JRqpOaxvs02ReascxUzvwkSqXJcM9SbUF2I0SX6Wyg/0ojgS6RDy9I2DNYKs8WrvpQ5fCXvl21P+R57hyD5QM/QHIdMeDFXvJE6v6HBFsTzv59Y1rLn5kK17g7whZVc4ju1rBAXcBo1Pnq6c7exaENUznk8jnEGE0v+vMDyA9OAKUN3izGn8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+TjfqAR7WA5EAaVepQWkN+l0WaJljHZ0GJlRFzSCpE=;
 b=kkVLILH+eqt3GQVHKHCnSCx6GF+PsHs9w+/4Zh6xdF1/St6vPnBh7lDYh9S9js1ZRBJ7br39HloV6vuD41OS0t5hGrjpljy99tpznOfi4pjWYr0KVONM5RdXk7QXU905VGp/0YZXm91DO5vk1LtDSMLIIewXpYoeHL40QCjLOBYQI8dBdTlL9lNLCLTNp7pvbMdcFxWDE/ygzt3nRDJtvzGc0nSfwf4rcmyVrP8y+XH4y58dTPvi0FrufIQGnup/Rc8tTlGaP/DSxPRCjXhNXhls2sCgGPCL1DkPn0iABqZraQy5EArwzyuilsmn+21OGHc6rfE6KTVv1ifmvbuhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+TjfqAR7WA5EAaVepQWkN+l0WaJljHZ0GJlRFzSCpE=;
 b=XQ4/5uIAlKUNhiMJuFpa25vknaSI/BYdh6p9+F43pzFLMIg1MKFwvJotxHmE6+fp4v3jo5R8T1HTzbPus1j9mG6iBZrV+CCTl7fXMBfStLv6phxt4poIBM+fI6d4hn7QbZP9RBOexpJBoe9xOUeShXQZw2MIlu3WuT0oFtnjWxFbnNXrFUkKaFLjcwVDxmr9HAFzSoyZZKyDmK0LLPRAjYJq8guBMzHt8///8rl0W4GseYOtmScn+fftc3TGufQxqRAcpTWgRcXxrovXoA/6dSB9pZlOK/fVIFph8/SRrr70vfhWRz0y0CQnjae4cl6fp4cyDkhGGOmYmGaXrst9yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8280.eurprd08.prod.outlook.com
 (2603:10a6:10:40c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 13:28:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 13:28:32 +0000
Message-ID: <a2d1f6c9-cda7-4bcf-9ba2-0fcf8af3332e@virtuozzo.com>
Date: Tue, 29 Sep 2026 16:28:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/16] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, den@openvz.org, sgarzare@redhat.com
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-4-6ef9ef033c35@virtuozzo.com>
 <arp6uJrL_XnWofFW@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arp6uJrL_XnWofFW@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: bffe5757-809c-4c48-e132-08df1e2d8e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|260925021311599003|260925021911599003|260925022911599003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0EsKCZLBmFrH2mz3MtcqVJZ8JrolebLhRnRtKPtzrttjVE0Yul9A97Lb4hPGBnGrwQX9mdNrp2u6UaPE62NqsXNVlOszDTTP5MBR5y2nqsO58DCRVWqRu1jvRyauMXhSmhOJhAk2aJDRwzunocT8ddSz9pPla2g62HWt8RrZPXnN4RIblCksRisRcO0SnzEfqshDjTGLBXG1RRstMQi5B4RNvJyp6QKmD31WVPplSm9EYJOzfMn7Hr8W61zJJyrCsojYnrF66RmzTr6sSqMhXga1GkCwsUzEFNnHGSm3T94G8eHPWpHKS0yrNR3017a661DqAuBFAhXrchF/o6YbPR+sBReAahsku4tLcIn+uHurrao8rKf4kw2RM/ydk+qrklQQCiNG2eE5GIFEP5D8Z3DO/eWJKP/MXPmnzEjtUVxhUa0Wl4gSm1LilEZSeyQqQG4xwvyNSy7hyBSMud6DSbF3ymacet4E7OFvQ5wk3XTpzitEAaiZgIJpailQn6qMGgkLfOfIbLBEsgfUfMEQTQ8x173M8UJ6k6iXeX/krNYtSMoCbDa7YRVgA0atQsb8bmdapDyivOfMLgreU8OcOMO21ExoeZd502UoB/sU+s+vpvMXdYat8LBEKnuZ6xjBDW/YaQ9jAtFybpPh7HHDvTmuJ/Z9H+lCbssj/mmOwtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkkrTHdaMFdMTHlJL3NFN3JSNEVnN3E3MUVKbFdrZmR6cCt2QzFic3JYTExi?=
 =?utf-8?B?eE9sZmt3Wm1VbkZUbEE1eDU5SUdKTEJrR2hOK3dnYUlvWmxoUlJKRFgyQk9z?=
 =?utf-8?B?NTBmVnhObGxqejF5NDNTcDlFOVlYZ0NRZVFwV29pSVJZWDFzUFlxSHpML2J6?=
 =?utf-8?B?Vkg4NklMZklIMVIrSWpxNmw1VnZLQzJTdHVoem5zUWwvUGx6RFBDWFQxVy9u?=
 =?utf-8?B?bW1HYWoxNDB2TFgzZldRKyt3RTBZdVdYbEQrQ2pFOVlpWFR5ODRKa0VVNXhq?=
 =?utf-8?B?K3lvNXF0Z01rQjZrL0ZoaUhVazZMSHNWV2syazNqNjE2QkJ0VS8xemdkZjFU?=
 =?utf-8?B?ZHlUWkdkLzBid3BnL1BNYmNQZXdPTnl3elg4YkI4Sy9BNzFqMWdUcXZGT2JG?=
 =?utf-8?B?dmZsREVMb255Rm9sMDR0K1UyaGtMS0JOY2NOYlROZHA5R05GU29Sdk5vV1Bj?=
 =?utf-8?B?K3hPdjhkUU9taFgrOWQveVMyRHg4SzdWTjhFNW93S09oZUNxQXJjZEIrdnhm?=
 =?utf-8?B?byt0VWMwczlza3NXUEF0Y3dtSkFjNm43N2x4a3czaXZ6MVlpK001Z2JZY1BP?=
 =?utf-8?B?M3JLKzdYQVA5aW0zeEl3eUlhaHdPUnZ5akx6dWJQTk1LUEc3U1h5SmtwQkR6?=
 =?utf-8?B?WkdaRXhwTStHZVR1eTk1R1oyb0sxb3pEYXZJNi9uOWJWczRqTjR6R2xWZmZU?=
 =?utf-8?B?c2hCUWdrUE1BZXhWeUNKbkdjT2JZa1g1cE55V2ZjNlRQbisrU05mcGtEMnVX?=
 =?utf-8?B?V0x1aktaSEd5b3ZjaUxBOUFyazUxMWphMkR0SGc2bm9MczArY29XR21INkEw?=
 =?utf-8?B?b1dCVXJEZmFxUE1zM0JJVmZKaElPK1pUY1B0WHVVSnZSMCtndVRhalpmYWNZ?=
 =?utf-8?B?U1NYVlZ5cDMzMzRTQ2JGemxTNGd5MGFQRU5VTDM1VG44UHhBNTdYVmFTS25l?=
 =?utf-8?B?RDVUVzJzc0ZaR0huNUtxdXJSM25vTElCYkZtV2VxQmtta3F5VWkvclcvMmdx?=
 =?utf-8?B?R3NhSXZNejd6Rkh2TEVpckVSS1ZDOGtkQXpqV0dvNm5jVlkzd0dXdWdsRlJL?=
 =?utf-8?B?Q2ZEbGwwci94YkpaMFdnWXZwZXRLcytyejduZUthK2tjWXlHd3lYMTJrcllj?=
 =?utf-8?B?TlVWcVhnYm44eGlFUGdSQTBETUhnckNRZTJxNThySmk2ZjI2STRjUXFNN2pa?=
 =?utf-8?B?L3FUZnFURElpU25sblNvOVdSbHVHcTJPNUoxaGJGSjNSMG9Da0tybFdQVjhO?=
 =?utf-8?B?WnVuZ1VJck9leFduWDEzcGRrV3h6THRsbVA0Vm1Ta1JzbGlBQ0FjYTZYeURN?=
 =?utf-8?B?c3cvVXJWdVU5b1U0RnphbUZmQkdtbEVNL3Q2ZDI0OEM2WTNKNmg3SXhETnJV?=
 =?utf-8?B?SzA5ODJEOVB3c2FXNlg5bHJDaXpIMUpvL1pNYTFybTBNTmlrRi9qbW1IQlpz?=
 =?utf-8?B?R2RZU0xxZE93ZVRra0xuZWF2eTJveUIyNVZGSSs1M2hmVzJvM2YrN1JHblJS?=
 =?utf-8?B?aUZwTXNnM2JyaWVDVGkyL1JMMFo4L3owb3ZiUURKSWxiM0gyYmVEQzBwd1pI?=
 =?utf-8?B?b0xmOExDWVJHZG1xa0xSUUVZZ01CdDFYQ0hzenVBbG44Smg0QW0wQm8yd2ti?=
 =?utf-8?B?ZGpkWU5DL2N2MjJ6TUkxMWpITVZBbHVWdEQ4QVBrYXdOdkJsVWRqMmltb3d2?=
 =?utf-8?B?Yzd4cFU2T1hZNVh3YTlaLzlVRWFWS25WTzducGhHTWYyYnQ4QTA5YWlBcmVC?=
 =?utf-8?B?SW5CWWlnM2R4cUdVem5DNWE1WEVjYWNUb095b01pZEtGK1RoL2o4QzdWeHBT?=
 =?utf-8?B?a0tWY0sySHI3cjZGZ1BONTZtNXhyZmxUZGRCaGRUMFJ3b05SaHk1SlZsWU5T?=
 =?utf-8?B?VndLQk1zZW5tMWl6WW9xQU5HczR0a1kwNmRSY2lGMG5id0EyNnUyV2xZVStk?=
 =?utf-8?B?V3NVOUVEOU9XRkZqVWRmWkcvbk5DMldZczM0SjdTKytyeDJGNmE3MHZhc0Vh?=
 =?utf-8?B?MC9rMGxSOENpdE9iQWxMaE5jOHlzUm8wVVhkcXhPREY2R0ZEV0VhcXBjRkdJ?=
 =?utf-8?B?WFhZeFQ0YklzN2Rwc1ZBdTA3bFVsY2hXMTVpVEl1dzFIbDZ0US9FaVdqZjN2?=
 =?utf-8?B?VXk2YlBwZldweHlieWdyd0Y4WUpKbXhDbVdrNjBKVnlZNEhCZFJwRWdLb0NT?=
 =?utf-8?B?bUNtUkxreW9Sdy9abHBmNnpBYk5VOVR3Zzl5NDJnWGpsblM4Qnd6M1draFRB?=
 =?utf-8?B?b09EVXFwOTJRcklJbEVOUVhRaStMakZQVFBFeTgrRUUvc2VaTTRCckEzc1dj?=
 =?utf-8?B?bTFiZ1hkekMvQmVXRm1rQXQ5UGMrbGNXdkFoaG5xb3NGWC9kRmRtZ2FXZjBE?=
 =?utf-8?Q?/o6P+4zr4ki0xkuI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffe5757-809c-4c48-e132-08df1e2d8e94
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:28:32.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bg1UbDxwql7ISbTmppuaRLj/FMpIPqqVZWbmEX0UcCnn4rKlUzmVFWyHUGJ5MgQN22XweAIaqPsQ+uF2eBIOjUPltLh2yXOmV4eDPEgV+J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8280
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 9/28/26 5:33 PM, Peter Xu wrote:
> On Fri, Sep 18, 2026 at 04:46:55PM +0300, Andrey Drobyshev wrote:
>> Snapshots are refused whenever a CPR migration mode is set.  Add a test
>> which sets each of the CPR modes in turn and checks that 'savevm' and
>> 'loadvm' fail with the corresponding error, then switches back to
>> 'normal' mode and checks that the error is gone.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  tests/qtest/migration/cpr-tests.c | 36 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 0bec753b4ab..a5255193101 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -290,11 +290,45 @@ static void test_mode_exec(char *name, MigrateCommon *args)
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
>> +    g_free(out);
>> +
>> +    qtest_quit(vm);
>> +}
>> +
>>  void migration_test_add_cpr(MigrationTestEnv *env)
>>  {
>>      tmpfs = env->tmpfs;
>>  
>> -    /* no tests in the smoke set for now */
>> +    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
> 
> We should justify each test to be added into default set because it bloats
> the test matrix.
> 
> This is a negative test, I think it should be only for --full.  Note that
> this will be covered by each PULL as long as when KVM enabled (IIUC when
> top maintainers collect PRs these will be covered), and we also run --full
> at least when preparing migration pulls.

Sounds reasonable to me.  I'll move it under the --full category.

Thanks,
Andrey


