Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0980FC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4LfH-0000fc-Vd; Wed, 09 Sep 2026 13:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Lf3-0000eL-BK
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:00:37 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Lf1-0002mq-BW
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqOtAqmFjTxEF7Zzac3/xel/2dYWw5GSc6wEIIzpVmWP7Zxxr8bzCkyjJHHZL8ocmYsdJQCDIPno60ni4mH5inxp5TCp0pWmo0OQI+BFhjuVA5Jvd0Y02BJEZRRU13GBmInE8tuCFyt7Nur6jeelkKAMCHtfa1bmSZgXkkq05Azz9H42m5/B/XKiELXJBWFVca25ABjUcOi/N0u4+Xle15oDtl2U1U/6WxO3Z28wQgbVGzg7yeZsTCaIBnlFY7jsxW8l0BQpaIiCiVAn5xvFpem3zpyH5L5C2R0ljnhbGuf/Yiz6jh82WNp64FYYX/y3qiPGKuGbCKNhrBgjL8lgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGJExRegVLifwbLM3YCjPI4B6+iFU4MEvh7em1LTqkw=;
 b=Q8EPS8mBluXzCru7undYi5PZP9Uy3zQd6X7+8FyEIF4KpWQYqcRrtKpcA0WiWwDC8x6fZ1HDqnOMasU+JtYRxQD8wqunF+/OzJM2+VuVlLpiwpLCDrxOSGsk2EzNUsC2ZMrc0jAXOhxRd3NRre4dszUOnpzriPucye1jtsCWywp3T5uwsE2ta31Qs8oUBYIerC7A+7egDSubWyQnnh8vu5S6C/pmVNEEhdlIdD8St7cVWVrfbsBb5fE0r99Mj4bUJ6ze6jnCs7o9takav7kGmqa1vQtMiT2pUg6DL0EGR6oKG2f6a9ZJ5yg0lU9uEHhMa9XWdRdr/IqhgOQ8wnUKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGJExRegVLifwbLM3YCjPI4B6+iFU4MEvh7em1LTqkw=;
 b=wyc1F5WEzMlGL56nns6lkH8uUWx9WoQsUIr4i3FqFiSpCiMSft0fbmzrZfo+2+VXjY3RulY/GfrUUaa3ebWdoIHzgMHwjjhjIfxLX3gpZ5/LdiUGcg7EnnSla4mpg8Bvo1FwAoFY67RqexeU2Ih44514Z36bxcS39Jmbi8Kx3WkpA+s8hqM3vmqdSeOII8e6t3dsie1PePW2sRw7vsGJPpdg6OXxsmusPw2uAQmpae+QSnXG2nOzecEpeFc7Ea9YSY0usbzBLEQf/Zjhvw9I4CGsSAgq9bIQysmIzwU68LpxrOSyZMzBy5Jc0176OcUp7q0Zr7WGag3Kap0va6Ee7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5976.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:59:56 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:59:55 +0000
Message-ID: <fc5bf943-68d3-4768-bf9e-cef14c81a0e4@virtuozzo.com>
Date: Wed, 9 Sep 2026 19:59:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] vhost-vsock: preserve vhost FD during CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
 <ap7Gc_L0gYkAaZiV@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ap7Gc_L0gYkAaZiV@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d5acd0-4368-4fdf-59b1-08df0e93c635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pVgeW6keIxinpJTkVjpW1+Ftk3mjZjCajq3nfF6yXQJgic+stF8ZBpCOXlXoZW0AChr+kw+G9Xx4Nr3cItRg8NrNY9nA/Ki+ogJ0StDUHjMrwPQEeUqsJzI2cUJ1HwZjUAISp6CYlaemK/cO0vHUINF1MBu+imu7k7Pvnz0yVtYWoE598HKKO3ye76P/fMBz4CtYuxrMRikvvepqEVVNMtR6s257UZXg9w3yVNPGYLuK/X9oxvEZRZPwjppqlo/N/Hn311mnJJ4aEBnOrXfe9mBu6saIZQxC/TSPHC3iisHWhLD/ze1Sek/xOfnszfE4xm6RNj74c/y8rV/w8Qp7r3pWExAsYRb1AQ4+5VjPkg9pFMY5dBIFgpDiv8D5gUNhQ/LDaMtXZEyUozQ0z6AsVWVij7DvCXlr09dscD4MUNRsq2rDf2RI5C409R+1DZSt1+Ft972wwKuvXjxi2HVZqfbCgbX2fK6hOZrtmnhMfxFr0f7fA7xFaMzEo4CvOa6bwWFI1OY9QnlgZodZihPTikENbtBvVM2HP0uR/kkQvwUjy5p681LEFBEgtAzbqo39u5v9fTMSiM7m1lCEfM9yJE32N6pOxwEpmHxc9R+z6WGJ5ca2SvHHw1tPLKzRLB+/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUV0T3l1bmFWVllhNUUwdHZza3VyUmgxR2lWTCtjMHNEZllKWUVIdzk2ZmJX?=
 =?utf-8?B?ZVV5WHQ2MHp1MlkrYnVrUkhjNHNETDUzT3JZV085bFNZVEVaMis2T1VlN21C?=
 =?utf-8?B?SUxTbGFUcTR4MCsydlFCcjlVL1FsTG9aMUdLVlBBbEVCUGQ4dCtpeUJZZFJN?=
 =?utf-8?B?cTd4YmdMNnFRNUNtTkk2N3hnVWZYQVhBS0FNMk41c1ZQWnQ2Wk5oN1g3RlhZ?=
 =?utf-8?B?bWFFekhXaUhldDJmeTdDSDdFTkdlcDBMak1FcUZnZWFFK1NYVmJOeVoxVmRO?=
 =?utf-8?B?c2I0N1o2dXJPNFB0R0gyMTFZNVR4WXo2N050THNqanFTYk1GY0lOQmJoWHNa?=
 =?utf-8?B?ZWdhb1pjUnRJWlJFMVB1VU5aRU9OK0dEL3dwc2k5K2c4Um9WRnh2N3ZsYUxu?=
 =?utf-8?B?MnI1QUVRT1VqYy9mQzVWb3g2WmN1SFJDOEJEa2tqSVUwK094UXFRTDEzSkhn?=
 =?utf-8?B?MVQ3bGlJaVg0MHNRdm1qaVRndHRldldEUXdkYytNNUo5QkYzUXFEcXhIY2hX?=
 =?utf-8?B?QmRmMkRSZ0hqR25zRWkra0U1NUpPSWYzQzJXVVN5Q0lLUGFxUTZQOUk0Ky9s?=
 =?utf-8?B?amtXZC80Um9UcFgreWE4MU5OVGVCOUJrZ0VaUUVnWmN4ZVZMQWdjalpYeGVN?=
 =?utf-8?B?aGt2RTh6a0h6K1BKaUc3WmtHZkZWWVArZjl3UitNNXU4am9rblVzUkNJaUxV?=
 =?utf-8?B?UlBDWUZMeVlxS0xPTU5PWEsvQ2V3TGdqblJyV3dCVU1oYU1mYVp4QXl3bkEy?=
 =?utf-8?B?dCt6Q2wyekhrdUhsSHM3MDFsN0QreVU5b205cTZiVEF3MHVJSHZrS1M4T0FV?=
 =?utf-8?B?Z0xCTTU5dFUxYXpqQUF4WmM5b0tTNmdTREpiYU1WY3hDTzh4d1c2emltQVU5?=
 =?utf-8?B?d1F4eTQzZXB6a0RwTER6MU9XelpaTHBRNXRPQU9iN3RlSkRnQkFZdEkveVlW?=
 =?utf-8?B?K3FJM3dNWHkvUkJQUjdYUjVhNEVBT3lGUE50SW8zNGFBckhRWXM4SmNKMkh6?=
 =?utf-8?B?aEVtV2wyQUZLemoxT0JFN3p2cW5EZkRGck4zZk40RkpvdXlsV0MxK3hhQjFW?=
 =?utf-8?B?RGhoUlExWFZJbGJBTC84Y1Z5SFp2ZnpYbUtWeDFwVE5ZRUlDWlZPUDRzY2h1?=
 =?utf-8?B?N1piaEpvcHlXOHpvelk5dnpFRTBWVUtjeVFWMjdISi9qZ1dnbXlMK1RHUkZK?=
 =?utf-8?B?RFhZa1BWRTlhSUJHWTN3NHZOME9jSzNYWWVvOWlXTUdJZmw5a1ZESDh1b1Rv?=
 =?utf-8?B?T1k3bmRpY2wxbVI5dk9uaUVEUVZDcHZYWDFaeGQ5Q25pLy95Q2IwYmZmZ1U5?=
 =?utf-8?B?OEUrL3kzWmgyZm9Ld2JQK2dUeTBYa3Jzd21XUWFFa3QrbFNsczFNaUNQSkR6?=
 =?utf-8?B?V01mSU1Sck94dnIrUVBkU0NLUUFKNlZrNUdzMG5iVFc5U203bXBOS3Nnb1gy?=
 =?utf-8?B?QzdyM2h0QlBTNlN1a0RPaUU5enRSQ3VhYnRWWkJBK0hvMElIV0J4ODN1YjFZ?=
 =?utf-8?B?NS95Q1JuZnB5MEZKTFZLMDFBUFFLdlpBaWltU1ZrT09LZk1XQzlCSHk5ODZH?=
 =?utf-8?B?L1BMeUQzZ2JWTEIxTnZRV1MvaVJneExNS3R1MnovWHJoSFg1Ry9RUVN0bjZj?=
 =?utf-8?B?VGhiS0VwSmVERXVrMTFRcTNHc0V4QTltblovdTRCOGoydVd2NXJQRC9kN3Yr?=
 =?utf-8?B?M2Y2UjhOSlU0NGNVOENDYk9NdHNtMlFnNDVlQkl2WVF3ZkFiQTVRaFp4NC9u?=
 =?utf-8?B?MXYxU3J1aWJjeFExYVEvTnhIVFhvd0o5eU55dmd4MXc3NGtIdGJDZ1RoNmxD?=
 =?utf-8?B?ZytBVzdobU04M3VJdTJBcmQzNFhWekVVSzNSMytmWWlGWlZXNWNsRnJ0NFMr?=
 =?utf-8?B?cndSNTFsNWMxdTNqVWtqNmRLTCtLdXBRYWwxRjVZVjJhdk8zWjV2UWpVdlJp?=
 =?utf-8?B?NlRQT3NYdTl6SzlGN0FDbW81emZSb2JhSEUxb3VvSm1tdHFvSW8veUYwQTlQ?=
 =?utf-8?B?dUh5Nm1vbXY3emhxNVlvQUNXU1ZHcUM3K0tSMTlURVdHR3hLdkhtd3NZY3Zm?=
 =?utf-8?B?OUo4MWRqN3RIemhLK1FUNDhZTEJLNlRRcTNJZlhVbzhoQ092M0dvbzgwMjlJ?=
 =?utf-8?B?VVVUb0FicWk1SUU5emFNOWgyOGlrbzFwVzQwOTkrc3JuOVpzZ2g5OW8vdy9B?=
 =?utf-8?B?WWY2czI4a0JYazJyK3dlVFcwU0NsbUtIaHdqZm1mcTNkSXYxNlNpZ09oSytm?=
 =?utf-8?B?RU9MWlJ1ZG96dGZqbE9iSlBzSFJybDZKcXRPcHdSaFhhcjJEbHNRZllMdWZY?=
 =?utf-8?B?UWdxYkZYcmh6TnIxTWZBZTYwQ1FIVjF5K2FYVnlrVU5BT2wwZTYzK3NHT0Ft?=
 =?utf-8?Q?xWOSPaTJA+atias4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d5acd0-4368-4fdf-59b1-08df0e93c635
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:59:55.9096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5242AQpoXd0hIr2E3q4WVYVfoiFNFHpkgWWw/CO3NuMfDgJuV3nK0XzReRHGeiabx7DOjXTKkayTe0dkbI4VcAni3VK42DkiQ2qqkWSxYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 9/7/26 5:55 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2026 at 02:39:50PM +0300, Andrey Drobyshev wrote:
>> During CPR (checkpoint-restore) migration the guest keeps running on the
>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>> we should reuse the FD from the source.  The FD is saved in the CPR
>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>> target via cpr_find_fd().
>>
>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
> 
> mm, are we sure the device ID is unique?
> 
> I just tried this whitout receiving any error:
> qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=vsock0 \
>      -object memory-backend-memfd,id=vsock0,size=512M \
>      -device vhost-vsock-pci,id=vsock0,guest-cid=3
> 
> Stefano 
You're right, that seems to be the a real issue.  In fact there's even a
UAF bug IIUC, stemming from the fact that we: 1) provide key destroy
function when creating the CPR hash table; 2) use same CprFd for both
key and value.

That means that when we have several devices supporting CPR with
repeating IDs, we do:

  g_hash_table_insert(table, fd1, fd1);    // table has fd1 -> fd1
  g_hash_table_insert(table, fd2, fd2);    // table has fd1 -> fd2

Here fd1 and fd2 have same hash of course. According to GLib docs [1],
value is renewed in this case, but the new key is destroyed and the old
one is used.  As a result, fd2 is freed.

And, mind you, this all happens long before actual CPR, cause the
devices with CPR support usually call cpr_save_fd() somewhere in
.realize().  Thus we get memory corruption right at boot time, plus
subsequent CPR will likely crash.

In these circumstances I'd personally prefer just asserting on repeating
key somewhere in cpr_fd_hash_insert().  The only downside is that it'll
crash when booting 2 CPR supporting devices having identical IDs, even
if the user isn't going to perform CPR.  I'd say it's acceptable, what
do you think?

[1] https://docs.gtk.org/glib/type_func.HashTable.insert.html


Andrey


