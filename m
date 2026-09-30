Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C2CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvbk-0007qG-SM; Wed, 30 Sep 2026 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBvbL-0007kY-Qh
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:48:13 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBvb8-00060d-9w
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfbDFxpwjQhOSelCyYqkH7DUtdzuYFLD6iDRqkSUhwvo/SgZ6amd6/PXnnaAMrfPpP+Y0CEQ1/gQSe8swwWVlSX2F1tBn47N5b8SjPZTzOEZMcYGdkKj7pt2pD6oYeBkt+SRJUU9vhevgZOku7xXQufrhUo+2BGdLxQUr2fzfxB6otpHRrEAaOnRjyEtLdHTQz4h+ni4fmdnMzB3Wk1sqkweh5+XD/JfQEvarP8J1UtjWA8sBSFtNunubkFYSW35dUvnRq5+mCaxEFXySuPCSA4t04H55UgMPwfRk0KKaN//NLvMnaKsvQYwM+YsoFle2odERnxbUtTGfi6Nyo9+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPY6el7bYu0FwL3eAGzntNqy4XDLfwDwwpBCPvELaJ0=;
 b=ytjHk4par99tX32u7fpEPOMrrnYK2+RDC+j36WoV1grKgpVaS4xncl5cYRiV8uwAjKme0NrZaezwGMuyV58NiDoof2XmENxuB2v98RvHEJ4f+SF7XoKeeSzF0m5kCFJI53tQr1Rg83Iq5Ju9KNmwVKL30AFjIWLBKlBT2hT8ooyYL6L6TcPjdNxLHE3+EBTXNoV3Bd1D/juqFsPttbH3QJe6JKuTOLp9YWhnh9RZCDbmkWNGGx67id88+H4RLbbm+3bJp/ooAfHkLEM6A34Ggl13kg8MKmBxs52f/cOfuTKZjd+MQPfpcyk4/g0K+uI0XE+2inKmk6YQu4bDQD31vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPY6el7bYu0FwL3eAGzntNqy4XDLfwDwwpBCPvELaJ0=;
 b=XYhYPGVIMDwmYJBwyeUnvNwC6q7r9arOmDM6hVHdoMAPogjzUUVsLA1EW1MSBrNy7TzHGH1q+c7mwpoFQDGuH0JdFvyz46IYt8L9Jc2dNvAgXmjprNEGBtjrKc4aBMDmk6pLAvCFuZaY84IDUAx7CNxh9lD2ctsNXN6eI3aJRJ+RoBjSs6jH8Cmh8KfkvMfXOGqg0kFJj4PjDzfEF3fheZvhdL43OOuLagO6mX4YcsvvGP+0d2OQJNrDt0mGG9oWbz2cSTPzQMIDD+eonFDl6jop6ocpklLhit2kJKvXaqVWgSFnCNNGlQ7ufBEz9Gnh6XUgyrHBWfJccd7xdhJMlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB384561.eurprd08.prod.outlook.com
 (2603:10a6:290:90::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 14:47:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 14:47:16 +0000
Message-ID: <afd80b90-9db6-4040-b187-e077b14143f2@virtuozzo.com>
Date: Wed, 30 Sep 2026 17:47:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/18] vhost-vsock: hand off device ownership across CPR
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: clg@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, bchaney@akamai.com,
 philmd@oss.qualcomm.com, farosas@suse.de, mark.kanda@oracle.com,
 dwmw2@infradead.org, peterx@redhat.com, vsementsov@yandex-team.ru,
 den@openvz.org
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
 <20260930-up-vsock-vhost-v5-v9-16-e9096f629770@virtuozzo.com>
 <f6aefd81-2c13-48cc-873f-26763c815639@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <f6aefd81-2c13-48cc-873f-26763c815639@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB384561:EE_
X-MS-Office365-Filtering-Correlation-Id: eea80d1a-780b-46fa-1fe1-08df1f01b8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BHVK9M+Euf9LpBTK8/vHtj0sjCZdGTogOIls+3iKpWghjzhCp/NDWDXKdFDR0u3nMqANZHvoOKcln9mvdD+VNyUm2r0lQ9i30efTFt9ICwKqQRQTeVJgxz6KmYC5UU2XNYJexC2wsxc4LWdSqEjb90kSlsKq+ppfoAjRYg4fb9gE0dgxzSeLazW7dYjls/goidZiUEdMpsssLmV9GfC8mhxtnd7hLl4//9/JcT636FyW9bduueUqzNj77YZ8nAnBfB+uI/6/ef3+uzs3yjabO+zIx4ANfgrbR3Dr8Jv8EbkRX3uMBw9g0LCONnvx2MjtSulYDrgnfziXEJL6z12KQuSgcbSreWYQvHP5Lsnc4UdsOpwIR7IJVPEVzYpx0xCpgm1dpfy0Kdt0lTWdzKtw+9rZ4HXUSHsT8hS/YAnTMcr+fFEWX2ZGg5LzN7BwblULBNrLUKKibmTod3x8h9kpjS5ByAyGNfZUmqAwpUDB7Bg/46Qv3PcRpU3/p4VCcMIA9zfKwRuwRvbPogIHvX4ik2Bleze0tf0og6LIjnQJk8Ct3/0cVyzwGb1cOG7dj/AplPYBiiXxTDCXgXL5OLtWuXi2Prebeax+85qQwDDTIFbVTNHenclEh+h0CtmQJcAvtx8rU3EUY8VfhE+3eS7sPHkM5ow+iuwLYFxs3Ma/HPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDBjcUIyUzJCNXN5WTAvYjVENmUxT21DU0NxTVY2UXV3SkU5ekowSExoVUJI?=
 =?utf-8?B?bHhYb0o1TkwyRlUvM2ZpTlIzRjVoMFVsd3VTTFJINUMxS0NyUnljNElrWUIz?=
 =?utf-8?B?a05TMHkxY29Hb2tzNkJSWC9OMGdUVUMvbDdoTEJwTmJRK0pRRll0UUxIVE56?=
 =?utf-8?B?ZVEyUEVCN0RYNDAvNzA1TVdxSUxYV1NOK25UZzNGRW14dHR6eVNnWHNqdU1U?=
 =?utf-8?B?dU1RUi96M2sxUjEvMEVmRjQ1Ukpjc3RzK2pWUS84SHFjWVIxb3puQ1hmRWFZ?=
 =?utf-8?B?Wk1YZEp3eHFoNDNLc1NFSHlmdFB6RHJwSjRHUVVVY0s5Njl1OGlVa3RwaDNu?=
 =?utf-8?B?MkZ5K3FKSnNHdEFGMTZVaSs5dHNCWTJERlVWWjFSWjc5Rk94bjNtL1RpMzVH?=
 =?utf-8?B?VTdrMjYyZEQvWGhHQW1nejJ6Sm5sQmFBeGRYOWN1cFBFWFFsd2ZvWDRnK2cx?=
 =?utf-8?B?RW1mbDkvcFovRlBNWVlmbEMxOHJNaURCQm5MVXk2cHMrN0NieDAyOWR3NFBy?=
 =?utf-8?B?RHMrL1hGMUo2eTM5Slo3TXZsUG9LYnMyUXVLcTF2OUxFZU1ZOWdPZm92Uy8r?=
 =?utf-8?B?VUo3RndkV0FuVjFDSmVBVmhkcS85Ukx5ekRwemNYM3BXSmwxaHdTNXJSbVV5?=
 =?utf-8?B?ZW4xOXMreE1XZVN1RzUwV2FKVUk2dERhZGxRaThBVytoYmJGZ09qYkkrTXhU?=
 =?utf-8?B?b2FnV3hsSktFOHFZd2xGZDQyZDRoUGNWR0RIMEJWRDFjRU9meVRWUXlGUTdq?=
 =?utf-8?B?WEV1TEV0cmM2andUVkhOUlk2c2M1VHRNMm9zdkdzWTk4ZWZ2aTlQYU1YdXdk?=
 =?utf-8?B?REtnQTJPOEh4L0FSd3hlRHJTVFN2bldMSWw5SzgvRU1ZYmgydjhVbzFIVzVI?=
 =?utf-8?B?OEsyN0d6NXEwUEE5SkFrT0liZDcreXI5c3Z5VHdqZm52QVI0OExTMGN1V2Ja?=
 =?utf-8?B?TzlYOTRycUhPdlJHZDZwbTFyN0VTK1ZIdkVsOHRETk16bXhXbmdIczNnVXdl?=
 =?utf-8?B?TGNucE5EdmMyNktSZHh2djlKNmg1NkNhZGlRclYvQjVaYUlHUnVKMVJLak04?=
 =?utf-8?B?NDRhcTNJTllTWFUzbVJJaHE1M0pVckpKTlpoOHAvV01NZE50b1JkdWxPVDM1?=
 =?utf-8?B?ajlYNDJZS1FmbUtHcUpCVStGYk1GUmE1MzBqbGZ1T3FPY00xK0FTQTczOFV4?=
 =?utf-8?B?UDRrNTNVSVNZb0s0LytlT3BTQW02c1FUdVRyYy9RZmVTUjVMZVZhTTZRNkkz?=
 =?utf-8?B?ZXpoREl5V0d2eGEwWktia2JsOWpveklIcDNlWjR4ZXdXLzR4WjhyVkV5VWs0?=
 =?utf-8?B?RmhJMWpFMU5ibjE3Zk1LdVh6ZXYxcDliK2hpck1HNUR2cDIzWllKMFY1QVpM?=
 =?utf-8?B?WWFiU2JCYi92MlcwZlhXdjlySUk5bHhuSzgyNzFPWW1mMzNKMDVqNmx1NWVV?=
 =?utf-8?B?QThXZnZtWVhXZ2w3a2t6aVdLTTYxa2NSSVEwSEVXd3FSTjJ4V1krcXdGcFNQ?=
 =?utf-8?B?TjQzbWxiY0hQdFhTZUNvSGNlV1VIN2ZobFdlWEJZQ1o2NDMxcFVic1oyVE5y?=
 =?utf-8?B?Qm5HbjRwcExzSXBlVTZpZ3BVdWgyVjg3TFJxbFRhanZzbU52dVd4SGV5RTBk?=
 =?utf-8?B?MUVFZnVibERMYmRRQU1QYWxkWWNta2VQRXJmVTJab2VXV1NRT1pkNnZIeTZ0?=
 =?utf-8?B?ejZkRUthQjFMMzEzcXN5UVVwRGR1NCsrR0lxSWJXZC8xcDUxOWxZZXdjRVZL?=
 =?utf-8?B?THZBL1Q1VGoxSkRjSW5XREtOTTkwWVlaUFI1MnF0VXdVdU1SN0EzSlc5RFRB?=
 =?utf-8?B?eVBkZFdVdnlwRWwvOXlxRmhqZEpuRkI4M1MxU3RTdVlDTVpVL1JqTjNsbEJI?=
 =?utf-8?B?akc2Wm5VNEhWSit6Nk1hdVIyd3NIZTdYZXRZMkhrdGFxWDN5YmxQcnpMVUVk?=
 =?utf-8?B?YXhsbkFqZS9XN0dDVjlkcWlUVVJ5MlVKeTRST1AydENoOWw5NktUemN2TjVj?=
 =?utf-8?B?alRXT3loRXJQM2wreVdQSW11bXhTTG9rb3VWeEc0a2JFWVdyODFlL0VHT0Js?=
 =?utf-8?B?cm5mYzVURHBucmhUSUJLQVhTc1dWeksyQWhXOWFrV2ZpeDcvUVBBZUNGM1dx?=
 =?utf-8?B?K0huaWdLVGJvMTU2aVJ5ZUlzalRuTDNZa0Z3YmRGcCtpR0FCWkZLWXpKclZN?=
 =?utf-8?B?KzZwdTZGLzdUWUZKSUNrV1RFeDhyVzVzSjU4MnE5ZlUrWGxDWlFObjRVZ1dh?=
 =?utf-8?B?RlFXalk1T1BGUW9EaEZqV2IySVFTQ0pVMXpEMHRLR0xGbCtSeDFnUXJha0h2?=
 =?utf-8?B?bjlSOTR5SERsdytzZWtPbEdwbGVabDJHcWxUcm5QR2lteXdwMHpmd095bzlK?=
 =?utf-8?Q?WLYMbuv9hB8V0Ddk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea80d1a-780b-46fa-1fe1-08df1f01b8aa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:47:16.4513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WM57dR8rirULVCcUx11DP5n0yaIMW5afGNTMM18baFCT6dOyouMSX+I6ySTtdWvrU8kG1IlYEQPHuaYhnitQa7G2vlwQ8eKJ7RSoLfaXq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB384561
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

On 9/30/26 3:13 PM, Akihiko Odaki wrote:
> On 2026/09/30 19:13, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>
>>    - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>      the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>      cpr-exec).
>>
>>    - .realize(), for an incoming CPR, only sets up the virtio device and
>>      queries the backend features by calling vhost_dev_init_backend().
>>      It doesn't take device ownership and doesn't touch the VQs which
>>      still-running source might use.  The full init is deferred to
>>      .post_load().
>>
>>    - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>      (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>      the device is started at vm_start.
>>
>>    - .set_status() refuses to start a device whose init hasn't completed
>>      yet (incoming CPR before post_load).
>>
>>    - .set_status() re-acquires ownership before starting the device if
>>      pre_save released it and this QEMU is about to run the guest again:
>>      the migration failed, or it completed and the management resumed the
>>      source (e.g. cpr-transfer target died).
>>
>> With the handoff in place, lift the CPR blocker.
>>
>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
>>   include/hw/virtio/vhost-vsock.h |   2 +-
>>   2 files changed, 128 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 6e89007b2ce..65ba573da4d 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -21,7 +21,6 @@
>>   #include "hw/virtio/vhost-vsock.h"
>>   #include "monitor/monitor.h"
>>   #include "migration/cpr.h"
>> -#include "migration/blocker.h"
>>   #include "migration/misc.h"
>>   
>>   static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>> @@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
>>   static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>   {
>>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>       bool should_start = virtio_device_should_start(vdev, status);
>>       int ret;
>>   
>> +    /*
>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>> +     * post_load.  Refuse to start a half-initialised device rather than
>> +     * issue vhost ioctls on it.
>> +     */
>> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
>> +    }
>> +
>>       if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>           return 0;
>>       }
>>   
>>       if (should_start) {
>> +        /*
>> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
>> +         * source, after a successful RESET_OWNER op.  If we end up here
>> +         * with this flag set - that means that either CPR migration failed,
>> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>> +         * target died).  In either case, we need to re-acquire device
>> +         * ownership.
>> +         *
>> +         * On failure leave the device stopped.  The next start attempt
>> +         * (guest driver reset, VM stop/cont) retries.
>> +         */
>> +        if (vsock->owner_reset) {
>> +            ret = vhost_dev_set_owner(&vvc->vhost_dev);
>> +            if (ret < 0) {
>> +                error_report("vhost-vsock: cannot re-acquire device "
>> +                             "ownership: %s", strerror(-ret));
>> +                return 0;
>> +            }
>> +            vsock->owner_reset = false;
>> +        }
>> +
>>           ret = vhost_vsock_common_start(vdev);
>>           if (ret < 0) {
>>               return 0;
>> @@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>       return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>   }
>>   
>> +static int vhost_vsock_pre_save(void *opaque)
>> +{
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>> +    int ret;
>> +
>> +    ret = vhost_vsock_common_pre_save(opaque);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Release the device ownership now for CPR migration.  The device is
>> +     * already stopped at pre_save, and destination reclaims it by calling
>> +     * VHOST_SET_OWNER in post_load.
>> +     */
>> +    if (cpr_incoming_needed(NULL) && migration_is_running() &&
>> +        !vsock->owner_reset) {
>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>> +                         strerror(-ret));
>> +            return ret;
>> +        }
>> +        vsock->owner_reset = true;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_vsock_post_load(void *opaque, int version_id)
>>   {
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
>> +    Error *local_err = NULL;
>> +    int vhostfd, ret;
>> +
>>       /*
>>        * Only reset vsock connections for non-CPR migration.  For CPR the
>>        * guest cid is unchanged, and the cid-change reset would otherwise
>> @@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>           return vhost_vsock_common_post_load(opaque, version_id);
>>       }
>>   
>> +    /*
>> +     * CPR restore case.  The source released device ownership in its
>> +     * pre_save.  Complete the handoff here, before the device is started
>> +     * at vm_start.  Init vhost device on preserved FD, issue
>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>> +     */
>> +    vhostfd = cpr_find_fd(cpr_name, 0);
>> +    if (vhostfd < 0) {
>> +        error_report("vhost-vsock: could not find restored vhost FD");
>> +        return -1;
>> +    }
>> +
>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        cpr_delete_fd(cpr_name, 0);
>> +        return ret;
>> +    }
>> +
>> +    ret = vhost_vsock_set_guest_cid(vdev);
>> +    if (ret < 0) {
>> +        error_report("vhost-vsock: unable to set guest cid: %s",
>> +                     strerror(-ret));
>> +        vhost_dev_cleanup(&vvc->vhost_dev);
> 
> The previous patch does fix error handling inside vhost_dev_init(), but 
> this branch still closes the shared FD after ownership has already been 
> acquired without resetting it.

You're right, I missed it.  But I think Stefano's suggestion under the
previous patch is the proper solution for that issue as well.  I.e. if
we issue RESET_OWNER directly from vhost_dev_cleanup() this hole will be
closed as well.

Thanks,
Andrey
> Regards,
> Akihiko Odaki
> 
>> +        cpr_delete_fd(cpr_name, 0);
>> +        return ret;
>> +    }
>> +
>>       return 0;
>>   }
>>   
>> @@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>           VMSTATE_VIRTIO_DEVICE,
>>           VMSTATE_END_OF_LIST()
>>       },
>> -    .pre_save = vhost_vsock_common_pre_save,
>> +    .pre_save = vhost_vsock_pre_save,
>>       .post_load = vhost_vsock_post_load,
>>   };
>>   
>> @@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   
>> -    /*
>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>> -     * device ownership is not handed over, so the target fails to set
>> -     * up its device.  Fail the migration early and gracefully instead.
>> -     */
>> -    error_setg(&vsock->migration_blocker,
>> -               "vhost-vsock: CPR migration is not supported");
>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>> -        return;
>> -    }
>> -
>>       if (cpr_incoming) {
>>           /* Reuse the fd handed over from the source QEMU */
>>           vhostfd = cpr_find_fd(cpr_name, 0);
>>           if (vhostfd < 0) {
>>               error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>> -            goto err_blocker;
>> +            return;
>>           }
>>       } else if (vsock->conf.vhostfd) {
>>           vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>>           if (vhostfd == -1) {
>>               error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>> -            goto err_blocker;
>> +            return;
>>           }
>>       } else {
>>           vhostfd = open("/dev/vhost-vsock", O_RDWR);
>>           if (vhostfd < 0) {
>>               error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>> -            goto err_blocker;
>> +            return;
>>           }
>>       }
>>   
>> @@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>           if (cpr_incoming) {
>>               cpr_delete_fd(cpr_name, 0);
>>           }
>> -        goto err_blocker;
>> +        return;
>>       }
>>   
>>       vhost_vsock_common_realize(vdev);
>>   
>> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>> -    if (ret < 0) {
>> +    if (!cpr_incoming) {
>> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>> +        if (ret < 0) {
>> +            /*
>> +             * vhostfd is closed by vhost_dev_cleanup, which is called
>> +             * by vhost_dev_init on initialization error.
>> +             */
>> +            goto err_virtio;
>> +        }
>> +    } else {
>>           /*
>> -         * vhostfd is closed by vhost_dev_cleanup, which is called
>> -         * by vhost_dev_init on initialization error.
>> +         * CPR restore case: only learn the backend feature set now, but
>> +         * defer taking ownership or touching VQs (the still-running source
>> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>> +         * is done later in post_load.
>>            */
>> -        goto err_virtio;
>> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>> +                                     (void *)(uintptr_t)vhostfd,
>> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>> +        if (ret < 0) {
>> +            /* vhost_dev_init_backend() does not close the fd on error */
>> +            goto err_vhost_dev;
>> +        }
>> +
>> +        return;
>>       }
>>   
>>       ret = vhost_vsock_set_guest_cid(vdev);
>> @@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>       }
>>   
>>       /* Register the fd for a future CPR after a fully successful realize */
>> -    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
>> +    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
>>           goto err_vhost_dev;
>>       }
>>   
>> @@ -247,22 +348,18 @@ err_vhost_dev:
>>       }
>>   err_virtio:
>>       vhost_vsock_common_unrealize(vdev);
>> -err_blocker:
>> -    migrate_del_blocker(&vsock->migration_blocker);
>>   }
>>   
>>   static void vhost_vsock_device_unrealize(DeviceState *dev)
>>   {
>>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> -    VHostVSock *vsock = VHOST_VSOCK(dev);
>>       g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
>>   
>>       /* This will stop vhost backend if appropriate. */
>>       vhost_vsock_set_status(vdev, 0);
>>   
>>       cpr_delete_fd(cpr_name, 0);
>> -    migrate_del_blocker(&vsock->migration_blocker);
>>       vhost_dev_cleanup(&vvc->vhost_dev);
>>       vhost_vsock_common_unrealize(vdev);
>>   }
>> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>> index a964d57e1bc..6e1c39383ef 100644
>> --- a/include/hw/virtio/vhost-vsock.h
>> +++ b/include/hw/virtio/vhost-vsock.h
>> @@ -29,7 +29,7 @@ struct VHostVSock {
>>       /*< private >*/
>>       VHostVSockCommon parent;
>>       VHostVSockConf conf;
>> -    Error *migration_blocker;   /* CPR migration is not supported */
>> +    bool owner_reset;           /* CPR released ownership; needs re-acquire */
>>   
>>       /*< public >*/
>>   };
>>
> 


