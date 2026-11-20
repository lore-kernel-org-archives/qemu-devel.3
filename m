Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B4606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=xTFvF38a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURGO-0002PY-HM; Fri, 20 Nov 2026 11:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xURG7-0002On-5t
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:14:45 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xURG4-0008Rc-Js
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:14:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PocoScsSgpEsvlGkIZ446qpgMAWVFNKX0JynzVJkkXwiqFYrFsFPo97V2+PWQD46v/uolTtaekOjHeuTtfo/ECNa6S5XV6O96HFWKpz9YiyUqBvmZUG4jnYseRIztUVvDn5I27MpS1ox3S8X0DdBr2Rqga7z7xMusQFR9rpTjMz+yNFk9KMJy6txo1C8MWU/aXUio2bOHK5bofhKraA+lkw5ZeaP9vTP1J+4JDBdKyY4xL+kfMNOy2paslgUxvGg1jGy1xj0hMnNNEpMFoXzd4P9o515CrOmD2FydH3iWy51dLZ6dpLYWVcS52tyN7RYTIkpkxmacsBZb9sItkRbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nppYohK9H0y1yYfWYNcJ+kBWzJveUHvD1bGUK7WWuaM=;
 b=L0HlcUGFBUyJ48/YvzT5j/ErF23xVzTeeTZe6WzUjm8YF6Qov4ULqYNf0K3wTkLxHpTtVs3F8I8L/dcvUsWovKwTE3/ONwQzdJGOG03uvNEHfnNe3d63L4sAKe9EcKgTuZXsGvHQPczfJ2js0kh+2XUbcRCJ2rOqShiP+hbfEKfk9Lg60CgZN4pfIWrVs3Zbene5NsG/Mj75RzpwSZy7BWA21n4O9lrWxaHcddMflxu7V9EL6D056Bxig7d+nOrDdcGSYB2QZqrwIjH29Q3+Kj4g4Z0yB351na/K1jkPZb0EnZ9ZkuAQ4qAo/lFYq4YPNgALHiYFaBZJ7CbURDCLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nppYohK9H0y1yYfWYNcJ+kBWzJveUHvD1bGUK7WWuaM=;
 b=xTFvF38asS4PdX4ZLTFHhWVzzto4CAvihxz9+AfPm0F3/H+afnfKsQ4EwrMS5WDX1r/x+6DC/Wo3a1mkQnJPaFSQaJuWpz3oxepmuzuI3hIX8uFzCLYevIg/hIHwGapqh5JFc0LZ5nIJZyrtCnef0EsdtTEJdxwVxTwK02lHnpQO4CkXFemepCLaHRrWR9Mg2O6Eq/HDddl51YhZoFh4MFCzLbuMdkZILbiZsyIBxibo11Pjse7dMhuy1eF6Tt7ebvYMAKO4maEjyRQ7GR6YJhndUF3pbpIuEFR1cIUhSgO+GcsCO+iO4NW4kO+qNv9b+Suo0MC8vFyn20kA+itw9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU2PR08MB10230.eurprd08.prod.outlook.com (2603:10a6:10:46e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:14:37 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 16:14:37 +0000
Message-ID: <531ee1e9-eeb8-49d3-ad23-609c82d42ed3@virtuozzo.com>
Date: Fri, 20 Nov 2026 17:14:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] oslib: report kernel stacks in qemu_thread_states()
To: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-5-den@openvz.org> <87h5hfs4v1.fsf@suse.de>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87h5hfs4v1.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::14) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU2PR08MB10230:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c4ec4d-3a5e-40f5-d06e-08df47215fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10070799003|6133799003|22082099003|18002099003|4143699003|56012099006|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021135927099003|261021121427099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: RW/6ci9WyYpsXgfakxOJ9gwkqgLalfpjAcifje369xIs2OgtNSU3cpB8Efj4BAaJVUDnn2nqW0Pf9KQqc7ljJMWzz3QT78aDj/iHn6/WDG7zWNTcG+wIWGgqHJ3nL/ukW0MoEuHj1T+YsACA7ue2ydIIUep3dR178HxyDbFNXquMny+yl6qr7rO2b6LvhzVMhYtuLJ9Ch73T4ChP8CJFqeM3FdjIePLroxhkKugo9nBUV4HTpKrm1KpiLJjqtPE1dm0japK0e76DzHPyHy/mcsY7zPWo5WpNffvAk3j++SP81n2SYl0PKCsUWzP2UoOWv+/SVWcORb4Y4Ou5dOAk2ZwQlvw95PUYFjbMRq4GCawuDDbVULG27gt1k67qVtp6qNf9+vlNLJejXD8e6hqGMpHSO7GJ07hsEuXL42ybQJKlOBa8uCzPG2SuleujWk5zYRtNe3hrmlX0SpWQwG0/WJdSYJwtC6h0OkstAhdPjBbwtiBz1GmRmN6TwQEz4p0+163A2AmKJGT0nwJRmjAw6s04vSMyWN9+StKb8Vd9Jh6wlKRywmzY2gjl8HkyZkuwB3XHfHJzNiFO6uxR6jKxm1y0CF/dCyUL3H+dVfVxZhkUNjnYwiZ/sEmTIjaK1epRJ0y9g3IGae3FtCjPLDpu56bLzQLam5+EJ7bhm6zNwsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVNNWlvdW45bGFZT29wMUttNXU0QU9ZU0NITmxMK3dFdHIvSXhZWVFPVDMx?=
 =?utf-8?B?QWFIa1hkWGJHekY0eG44a0RkWkFOamR3YnNaZzBOQVVZb2RpaERhMWdxRFcv?=
 =?utf-8?B?S240M3preFlEU2V0b1grdTlzRTRmV2o0bktQQ3hHVTMwbDNXSXI1RDBqdkFF?=
 =?utf-8?B?L0dBb2N5dmZnaXQ2WUZCQ1R2UXZ6K1E4c0hYZXRGNUk1UzBmMDE2eUlzZ3Jr?=
 =?utf-8?B?eEhSWnQreWZGRU1VZW5yTkEzSFl1NTl4K3VDWmY2eERUZXVZMjY3TnJLa3BK?=
 =?utf-8?B?bGVmWVpDY01RNVU3THBLelpYNi9sZ0hTQ00wOTlVbGNueHdxenNJWEpTVURV?=
 =?utf-8?B?bm50REhoOGJOMldnL1FzSDUrQVY4bU4zR24rNVRXL1JTbHZteXJacXVlLzls?=
 =?utf-8?B?SEUvNTlGS0VMQzNob2V2UkFodW1NcHVzQ3l6TWpxMmUwem9pVTVqZnZKMEdN?=
 =?utf-8?B?K1RaUVdZTFJBRmM0Z2dHRFdzN1U5Y2ZPdDFJWHAyQUxkM3BtcWZUQ24yRTZ0?=
 =?utf-8?B?cS94MWdkbHRhL3BZaE1uZGFUQzlISXlkaWN3NndTa0Y2dWtKZDN1bjBVZ0h1?=
 =?utf-8?B?d1ZQVDNIeUU4V2o5U1dKanQ1UUJkdC9PT1FxeVdYdEF0ZHh6N25ncUtOdWZW?=
 =?utf-8?B?eXBkTTMyamc2M3dUNVVYRG5DS2ljVVZPZ21TcHhIaXhESVhZYWxhVUNTcGd1?=
 =?utf-8?B?MnpPNm1pTUIrMVQxQWc5eUkzdUpxSEZLdHFUMngreEdBdlpKeVkrVi9tZUYy?=
 =?utf-8?B?cEFXczg0L0ZGVXBoT0dwalZ2L2RmKy8xOFBPTmR3YTFsWFRHZk5iS0hQYXB0?=
 =?utf-8?B?dFMvQlZvTmtWVXVkNGtQSEhEVU45bjN0TjRLWlZSYzUxMmVuaXgxdlVQZ0Jv?=
 =?utf-8?B?Um1DZWVrMTRqUWNiUEQyM2YzNm9Gc3ordzE4bXdNaytyZVFCMW1sZzk0Uk5r?=
 =?utf-8?B?bnJLVnFlVVlFYm1GcHZ2ZUxXRy85RWh1NkhxaGZGcW1HYWdIejF6bFo3NWVp?=
 =?utf-8?B?WXdZdk5jQjlCNFJtL2N2L216VCtteUNVaHEzSm15S3hjcGdJOUkwS0VhNVVB?=
 =?utf-8?B?d2h5ekRrdTVlMTV0RFdHeW9pS01EZFlTU09zZU04TWFLTlNjUisycGtuVjJo?=
 =?utf-8?B?ZEFaWmUxRVhjSnlFbWNUM2lpNHEyYVROak1SQlhJTmZYL0xmVDQyNkRJbTRP?=
 =?utf-8?B?WXhqa080d2xtRk0weDZ1c0xORkViUmNQbEJhSWNDaHE5Y05LU0hRcEtsajNB?=
 =?utf-8?B?MCs4Rk5MMG1FckRIOW9vZkc2Uk02bnBSL1k1OGgrSW1VSjlZb3VmdHVlOWcw?=
 =?utf-8?B?cXlGVFNYaVFuYXVrUHJWNFVJNlZybTV4WTBCZDl5MUNDTE8wZjdMeWo0aWZO?=
 =?utf-8?B?Y1orOUFPVENPK1YwdGJHVXdiTElXaHJ4LzB0NG0waUNFMFpKK05NYWhXQ2xm?=
 =?utf-8?B?T3FidjYvTHZ0WERSdFFrL2ROdlJLajV3VTB3MzdGRGJGd1A3d2Ztck9UUXEz?=
 =?utf-8?B?aEV2My9FQ0NRa3c0STd0REdNOHN1MjA2WlViWHo0VGxxTkV4ZmRuSnlXeGNP?=
 =?utf-8?B?S1RteXM3blZsMU00WStISXdyeXUzYjlUWjJjZE1vaHJVMUp0Yk9GaDhCS1RQ?=
 =?utf-8?B?K25YOTVhMzhMbFB0YmxjWGJuOHJRMjAzVk5SQjFFb29vQUllYWRJWWszb0cz?=
 =?utf-8?B?SmU3K2JRWG1yTk02OTd4RWE0RVhRRUZoVW10MjBnZHpZQnI1V2dyT0p1RFpT?=
 =?utf-8?B?TERTUkxobjZ3UHI2dWxRYmEveXIxaGNrUWVqZjJsalFwUGhQOVduMnhXVjd4?=
 =?utf-8?B?cFNoeFh2QlU2bFYxa1VPUzhiN1pIUHdMNUdla04rR2hZQWlyN2dWeDRCMndQ?=
 =?utf-8?B?bDNVNkJyZENTdW9xUDhmTjRKZEhyWFdtclljMitOWm85SUlsalBpaGhCWEU0?=
 =?utf-8?B?RUNZa3VGa2xUNmxRLzR4Z2lLRFlsOEdRNWZjdG1FaUxoUmtMT3NrMU8rbkJU?=
 =?utf-8?B?aWx6ZUZJdmJlLzFFMWl3ODR4L3poVVQxQmFpOXJERk9VQVF0eFJqMzZPZkgv?=
 =?utf-8?B?dC8rajJ2aWE5aHBydkc3N3FCMXdPK1VWVmlwWE5Qc3AyeXA1RGRnMWlIbURG?=
 =?utf-8?B?dHNPNElBUXdWTG9aakhrYTNPQVc2UDlCY3lpZVVvZFJUM2Zmc25YaEk0SUNP?=
 =?utf-8?B?ZDVEam5UL1VUTldCZlhWUGptOG1Ib1hwanJsUkhaNDFhdWNUT3l0UDZ4SDJC?=
 =?utf-8?B?OVVoZWh2UDJNZFdGWDR5c1VBS1Y3RFVvWmZnU05zYzByNXFFQnZ2UkxrMjFs?=
 =?utf-8?B?Q1VJdXhsZUU1Qmt1Q2lWTFF4VExXcmVoZ21QY3RIQStWWEorM0NjczJidWxs?=
 =?utf-8?Q?+eLA3KDMefpdsE4SfxcOFDZetFvx0SSys02L5GH+Uzx1l?=
X-MS-Exchange-AntiSpam-MessageData-1: MmfU481jh5Jntg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c4ec4d-3a5e-40f5-d06e-08df47215fb5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:14:37.6973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5bAkQSw/9wkIfr2opsIauVElELeC0EpjQ3l3XYmPKRsGzt6YFZ3dY39QqYeAzalE5HJQsFKfsDe21S8OAlNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10230
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 19:13, Fabiano Rosas wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> From: Denis V. Lunev <den@openvz.org>
>>
>> A wait channel names the primitive a thread is parked on but not the
>> path that got it there, and for a thread wedged in a syscall that path
>> is the answer.
>>
> Talking internally with other people that also deal with these kinds of
> issues I got the impression (and that's my opinion as well) that having
> the warning message and wchan is already very useful. I wonder if we
> should separate the other "secondary" sources of data somehow so the
> user can opt out of them.
>
> For instance, the stack information will most likely never be available
> in a production setup, so that could be behind a knob. Likewise, the PC
> addition in patch 6 is nice, but slightly invasive.
>
> One other passing thought is about large hosts with many CPUs. There's
> probably a sweet spot of workload vs. amount of cpus vs. watchdog_ms
> that would trigger a long sequence of processing and printing stacks
> that the admin might not even spot in the logs if the VM operation
> continues apparently unaffected.
>
> I wonder whether the above might lead to the feature just being off all
> the time.
>
> Maybe putting a precedence to the information we print and providing a
> bql-watchdog-level=[1-5] option so a more conservative environment could
> just enable the warning message, then wchan, and so on. Just a thought,
> I actually like the simplicity of having just _ms and _abort.
Charming!

>> Read /proc/tid/stack when the report is built, and keep the wait
>> channel for when it cannot be. The file is restricted to CAP_SYS_ADMIN
>> in the init namespace, so ask once rather than failing per thread, and
>> say why the report came back thinner. Skip a running thread, which has
>> no settled stack to unwind, and cap the frames, because the deep end of
> What this "settled stack" statement means in practice? I think having
> even a partial view of the stack up to a point would already be
> elucidative, even if the last few frames are bogus.
>
> For example, I see a few:
>
>   1822761 CPU 0/KVM        R
>       pc 0x7fb3bbcfae0f ioctl+0x41
>       wchan 0
>
> whereas something like this looks more interesting:
>
>   1821448 CPU 0/KVM        R
>       pc 0x7fbe91119e0f ioctl+0x41
>       [<0>] preempt_schedule_thunk+0x16/0x30
>       [<0>] srcu_gp_start_if_needed+0x38d/0x520
>       [<0>] __synchronize_srcu.part.0+0x7d/0xb0
>       [<0>] kvm_swap_active_memslots+0x133/0x180 [kvm]
>       [<0>] kvm_set_memslot+0x47f/0x600 [kvm]
>       [<0>] kvm_vm_ioctl+0x1113/0x16e0 [kvm]
>       [<0>] __x64_sys_ioctl+0x97/0xc0
>       [<0>] do_syscall_64+0x7d/0x160
>       [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
This seems reasonable.

Thanks


