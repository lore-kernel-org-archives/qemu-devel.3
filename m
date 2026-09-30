Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06038CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJU-0000et-WD; Wed, 30 Sep 2026 06:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJT-0000ej-MN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:23 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJQ-00045T-UL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJEldsbE1QlyMMsi8hpXQ3Mb0XYT9D8yW8CSfwxVZxfmCozPp5ScamIEXUH4XPIhImgOnLZe9mv3sysj04KhlvnK3/G6SSoxONzDZNJkgngu3apgy5Dl6vgLMzrHAvCaO809kvop78HiXpp2OU+2FAcaLKZZKWML2pIxH2RY8snckwXdj2Zf4H+pQ5o8U90MPWJ8CSdwXaJcifInlPcHHL0gQxf4ginKsrgv/zDh344Lj7xI575vm4xdRQXr8LCgtM7/ruhByuRgxSVCbAZcAa+oBdZuBbYsYFaT96jgoNS0BKtM8OFXUStWjTxD74+NX2hjurG2kJSF4uf5+JvGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx9awxMhMB2A9zDewAD7duOTTce88aBzJDXdNbYa4Z0=;
 b=uLSTjLiM957Uqbo0vUEW0sck68QwhLyGTWPBGyfTM1qjF0lS2V2UsDwTNbrgqzo+sUykY1sw0cOFXdtCNVY7bKPhLAujHEyLROiMBNF8uvq6XIt1P+m2xa+7dKqFrjvblJA1reWjMBt1XFORDZNYuWkhOKsfPlO0F21XeFiYZoEzhdLO68xGQUMb3wbKlePYQ7tdipDICZfCxpAhKG4BWfmMDzxaL7QoAUL7hxKJwKuRCsaFMBVxLVr79cmu06zc51N+0YjFpEZ6nUgYI2PbGnM66N0FZjczWGUCLEnB3iS9TqGs34s6Eu0OlpgrZYHHiEOaS+zCynYJDsXZKZxWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx9awxMhMB2A9zDewAD7duOTTce88aBzJDXdNbYa4Z0=;
 b=i8vDWlQZ62T0jVQiYN9IyWkwRqqFKCAVChbtLTq83aOwfvxV6JKksqhN9AI7JgdolIK1z5yk7akJofxUOAWDn4khk7wU1Pai628HA+Ix5uZxAS15ZL6fbjsBGrE3M1RHCi/YU6g5w3/thuafISmv23nYXQSAs83Q44eRbqg/DBE27UUc14A8ZVOYLsYnrIYhDEBtUcmff01GCe5J8F+Io7vhvxFYODj6KGLuLuwROAkHalHIbtxmQ+47oXco2Zdai57suYTQDhmAypr8pGEnjzErvlPZZka99DZdKKZI923xVKhOjgM+5lBpZXorx1XO11HlZhNQVmwxS6jyyVn3GA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:17 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:17 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:00 +0300
Subject: [PATCH v9 01/18] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-1-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da3445f-9fc8-4671-90b0-08df1edb71ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: htJ8uhf7OlPYvD85UQ7hI0022I0rfcJ5Vv8BsfV/ZIQfJEmywKqndOXKnRPoi8Udjz2uqVWrkqfcujNWp1w1Q9KLJMMeK9Ek150EJJzdEVofpGz32TI/jZOcAbH+prRVFkTr47QrOvLYUYimfAMdb7rP584Ljkam7PyCPDKZIGJQfQ+zCOM9Kd49bTbdEHRUeM+ppKVbh7GK7NIyEwmziLMNJS7NeSfEx9WwYm1gfOnmoYsig2Nii7wzNzBJ228+ZFeUHS28GBnNXl+nDrTm2i6r433WQLohzorkRieOjJGAFdUkQGJTeZCaIzZBfOUE4cdVXAk01hJF9pMp9NfKxdtgWuJm4AZw3WBzcCVihO1jdIOwHi74gyzn4vH826EFa7LsYgASI8WJGZhOi24cllX1hIRABEKca92S+YwSIy83tNmBEa4jICyUBzhsl3/zuV700RFxWCW6IwuFMjmPqr2+ckUr00YHABGDiKBgQ2zwruT9rFEOWR0hUicX6HnP7WU9tB7DLCgdCKt1UkSutZNhgst3nuXfNo+XpqhclztXrPJn6i1WGk6YU4viuwrcJrEQ1PD278LcCU4SQs3RGN8fMH5Pwujf25bZqbYCVGle60c+22qa91GgDEUZGuPdDxMgpAs5m2St2z+bwk0KdNz2V+R6nvWQqeCRn4r0P7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW81WDlKbGxjd2dsWnVXYmNsYW9LaGJ1cEtNVHN6UThmcjNJd0JRcG9LUmFB?=
 =?utf-8?B?K2JJdWlmR3hEbFp4QnR0cXJlQ3k1UVlEbm5LVnQ0WXJsYTlKSTJJK1k2RkpO?=
 =?utf-8?B?UWsxZi9PZXdJd2w4TUFYL24veTRoL0FrMHVMemFPSG9NN21wSkhNM05Ea3By?=
 =?utf-8?B?WTVFMHN1QkRwR2doSFN5dkFJVStiOWkvSWlhR01qbkhObHZXblJwMU9Ya2FZ?=
 =?utf-8?B?Q2RwS0xhZjNVYmN5ODNPK2lSSm55MEN4Vkg4d0NBMk1BaS9ZNWJuM2ZjTVBn?=
 =?utf-8?B?YUcvYTgwV1RwVnJObXhxVERINzhweWp4NWRYUG0rdGxYcEFKdHZZV2s3Yllx?=
 =?utf-8?B?RmQvTys3eVh3bnh4OGxWU3Q0S09LK1h4dGV2MEhVYy9QSWxzZTBrRmlINjNQ?=
 =?utf-8?B?UGZrOEpUdnN0TUQ5SFRmcXNGV0ovNVNvY2Q0dnp5MDFjTWNVcnhKWldpQUZu?=
 =?utf-8?B?YXB1UVVwNnFxMVJKU1dXSWdIT2dabG15M3BINFZRcTM4WGo0c0x0OERMQWh5?=
 =?utf-8?B?OTQyREFtMzVTVEt4c000Q1BIL1d6Nm5hSXNMaGpzekNyOVgwT29KT3NGK3pX?=
 =?utf-8?B?ZElsQmVpS29VbStRVmN1eEtsNExwSGU3NkswUUYvTXU1S252M291bm4vRnE2?=
 =?utf-8?B?NWFGQmtvR3phYXh3WTdEQlVCU1BZTjJQSW1yNFZYM2pzYklGTmxVemJHM3Z2?=
 =?utf-8?B?MC9Va1V3TUJhTzd4LzA5bWdTU3lkdUk0akJVYlcxTFhXQkk4UlZHcC9mRnN3?=
 =?utf-8?B?VEhBdGdXZEdSTXkvbk1abktPeTFCQk5UQjNFaFAwQlN0aXBOVEtlQkxzdzNk?=
 =?utf-8?B?VWhOVzdyRHRxK1VlNjBDNlVGdnAvWXNlaTZqdVJnbm1MRVJaYTVacVlYWDFs?=
 =?utf-8?B?U09CSzloWmg3NHgrQnJ1Z0xtTnpKUHJDZjRCdm1WWkhlci9YMkpSWXJmOXYy?=
 =?utf-8?B?UXgwTEd0dzBJa0tiR2k3U2RodHlTUGdrb1A5bjdtL1FmdkpULzI3dnJUL29y?=
 =?utf-8?B?cmtXbFVQTXd4MjVvZnllVGpOaEZPWEM1dDFmUUoyRTN1Mmh6WlpCaVJKaHRY?=
 =?utf-8?B?Qi8weXpIWXdRc3ZYRmxOdHJRWWlUeFN3UEZ2N3hwWjlwcE1pS2dpeG1OUzZx?=
 =?utf-8?B?VlM2bWJadWJsNWZWTm5EeHFTK3BwcHYvWERuN1AyU0FsL2NsdFI1WU9pU1c4?=
 =?utf-8?B?RFpRbXd5bjFleW1iYXpaTHZwTlpXU2dJTDN6SkJyN3NFQWRudThHZFh2cUYx?=
 =?utf-8?B?a2x3czMyV2h0cFZDSktWZ21nS0d2S1JvRkVtV01KdzZOeWxsK0lQRTBnVzVV?=
 =?utf-8?B?MXFmQ2dXRk10VG5CUkJVNzBwRnRSSldFZjBpMHpkMlRIRmVPWDZISkM1RWVY?=
 =?utf-8?B?bXRZUTU5YkRYNkJMOUZUUGdmSW80cVkySDV2NlFHYmpZbW5aN1ZkNGxkNFE1?=
 =?utf-8?B?UGIxMU1OcDBoZVhZNlQreXJVbXVVK0k1a1RWeDFoUld1Y3VibUdKMjZhVU05?=
 =?utf-8?B?UjF6RlZ0YkJYMXBLWGdkRjFCdExENFUxVWNOS1dpN1Z4VDdnTjZlM2J3dStk?=
 =?utf-8?B?NUpGU25YUGhuYW1rM2F5bTVHWXlRRTFOU1JQUGNWUTcrMjhRUjlNa1NVQUVY?=
 =?utf-8?B?aE1kUmlwc3NwZktLR3BzbWQzdzdRUnF4cWJHR2ZjVmlqMEtBTjBOb0ZKcTZu?=
 =?utf-8?B?R1VUYVlMZkV5eWtsTWQ3VlpNYVVBakNyQURQMmVsUk9SSkVtcEhqWThoNjhE?=
 =?utf-8?B?bVBOTCt0dXNWODhGVytZSTkxOFVCY2NONVJPRnVIbENkc2VBaEVaRlZyUkJ0?=
 =?utf-8?B?YUMvVWtkMVd0a3pJYjFCdWxEaXR0QnBoT1RMMlBsVTdsTVVoMy96RVNNbzcy?=
 =?utf-8?B?TmI2cXR0TWlZZHJXeHRtbm1xWE42c2dQbVZzaXlPdWVCZElMd3d3anN0Q0Vq?=
 =?utf-8?B?QTk1RUF3bnpEbW9QSjV6UmgvTS9YTXBKenJocnNZaXJldlpIN0hPcjVHNk1z?=
 =?utf-8?B?MFRDaTFKRTFiVkNFbGwyQi85ek5wS0VRcFNWMktGRVc2YktZL2p2a2lVSmRQ?=
 =?utf-8?B?M3NnRkMzcjNnV3dEaDJCZjd2TUlmTFZpU2Y5TmRGU0UzVzE1NWxRZkJxS3d2?=
 =?utf-8?B?NElBejZ2TnplM3BDSHFHOUpmdTBHK2FUODlpS2RFenRERDhpUlNob0k0ckV3?=
 =?utf-8?B?b3A1cldhbkhnVXc0US9yUW5LcGpQckVDZUIvYzhpemxYd0Z4MThCQUUrZ0o0?=
 =?utf-8?B?R2RYRFB5czV2dW9aTVNTY1lIZk9yL0N5Y0tpcXNHd1ZNYjRYMm1JanVHT2V3?=
 =?utf-8?B?ejQzTjlkM3lhYVlFWGVkRloyZlNEK1dJSlRiNWc4YjBPSStBZWlBV1N5bzlu?=
 =?utf-8?Q?SaeX9gpDfROJvbhA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da3445f-9fc8-4671-90b0-08df1edb71ef
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:16.9728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiHzIASwCbXU6fyYXYkALJ1i2NeTKH1JB2Qnfl9oS/sfimwoSVHFotoPtwrMgs4Y+BoJf3yENJezvRjEpkeh2SlJf6W8lvN3IWtnxfB7o58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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

In its current form, the mechanism for saving CPR FDs into hash table
has flaws.

The CPR fd hash table uses the same CprFd for both key and value, and
is created with a key destroy function.  Inserting a second element
with the same (name, id) key leads to a use after free.  According to
GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
value with the new element, and destroys the new key.  Thus when
inserting 2 CprFd elements fd1 and fd2 with equal keys we get:

  g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
  g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */

Any subsequent cpr_find_fd() for that key then returns freed memory.

This is reachable whenever two CPR-aware objects register fds under the
same name, and it happens long before an actual CPR, since cpr_save_fd()
is typically called from .realize(), i.e. at boot time.

Apart from the UAF itself, when the user decides to perform CPR migration,
on CPR target we'd get corrupted FD from the hash table and fail somewhere
in .realize() for affected devices.

As a solution, let's altogether prohibit adding CprFds with duplicate
keys.  Since FDs are being registered for a subsequent CPR right at the
startup in .realize(), that'll allow us to error out and exit QEMU (or
fail a device hotplug op) gracefully instead of delaying potential
problems for later.  To do so, let's make cpr_save_fd() return 'bool'
instead of 'void' and provide an 'errp' argument to it.  That way caller
becomes responsible for checking the return value and propagating the
error.

Also update all the callers to use the adjusted interface to keep things
compilable and bisectable.

[1] https://docs.gtk.org/glib/type_func.HashTable.insert.html

Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 backends/hostmem-memfd.c   |  5 +++-
 backends/hostmem-shm.c     |  5 +++-
 backends/iommufd.c         |  4 ++-
 hw/vfio/container-legacy.c |  7 +----
 hw/vfio/cpr-legacy.c       | 29 ++++++++++++++++-----
 hw/vfio/cpr.c              |  6 ++---
 hw/vfio/pci.c              |  5 +++-
 include/hw/vfio/vfio-cpr.h |  7 ++---
 include/migration/cpr.h    |  2 +-
 migration/cpr.c            | 64 +++++++++++++++++++++++++++++-----------------
 system/physmem.c           |  5 ++--
 11 files changed, 91 insertions(+), 48 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index e21c5a3f2e2..a95a4368a9e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -54,7 +54,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd == -1) {
         return false;
     }
-    cpr_save_fd(name, 0, fd);
+    if (!cpr_save_fd(name, 0, fd, errp)) {
+        close(fd);
+        return false;
+    }
 
 have_fd:
     backend->aligned = true;
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 806e2670e03..2fa7b823a62 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -48,7 +48,10 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd < 0) {
         return false;
     }
-    cpr_save_fd(backend_name, 0, fd);
+    if (!cpr_save_fd(backend_name, 0, fd, errp)) {
+        close(fd);
+        return false;
+    }
 
 have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 15f2a513501..45fd2e44c7f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -85,7 +85,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
         if (cpr_is_incoming()) {
             be->fd = cpr_find_fd(name, 0);
         } else {
-            cpr_save_fd(name, 0, be->fd);
+            if (!cpr_save_fd(name, 0, be->fd, errp)) {
+                return;
+            }
         }
     } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
         error_setg(errp, "/dev/iommu does not exist"
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 7ac7b372145..50ca5a3a7ea 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -847,13 +847,8 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
 
-    fd = vfio_cpr_group_get_device_fd(group->fd, name);
+    fd = vfio_cpr_group_get_device_fd(group, name, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "error getting device from group %d",
-                         group->groupid);
-        error_append_hint(errp,
-                      "Verify all devices in group %d are bound to vfio-<bus> "
-                      "or pci-stub and not already in use\n", group->groupid);
         return false;
     }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2d40d8baeaf..807ffacdbc9 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -254,17 +254,33 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
                                                 &vrdl->listener) == 0;
 }
 
-int vfio_cpr_group_get_device_fd(int d, const char *name)
+int vfio_cpr_group_get_device_fd(VFIOGroup *group, const char *name,
+                                 Error **errp)
 {
+    ERRP_GUARD();
     const int id = 0;
     int fd = cpr_find_fd(name, id);
 
+    if (fd >= 0) {
+        return fd;
+    }
+
+    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
-        fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
-        if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
-        }
+        error_setg_errno(errp, errno, "error getting device from group %d",
+                         group->groupid);
+        error_append_hint(errp,
+                          "Verify all devices in group %d are bound to "
+                          "vfio-<bus> or pci-stub and not already in use\n",
+                          group->groupid);
+        return -1;
     }
+
+    if (!cpr_save_fd(name, id, fd, errp)) {
+        close(fd);
+        return -1;
+    }
+
     return fd;
 }
 
@@ -291,6 +307,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
      */
     cpr_delete_fd("vfio_container_for_group", group->groupid);
     close(fd);
-    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
+    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd,
+                &error_abort);
     return true;
 }
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index ffa4f8e099d..6e1659dcddc 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -32,11 +32,11 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
 #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
     g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
 
-void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
-                             int fd)
+bool vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
+                             int fd, Error **errp)
 {
     g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
-    cpr_save_fd(fdname, nr, fd);
+    return cpr_save_fd(fdname, nr, fd, errp);
 }
 
 int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f0698..ad13f2306f1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
     }
 
     fd = event_notifier_get_fd(e);
-    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
+    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
+        event_notifier_cleanup(e);
+        return false;
+    }
     return true;
 }
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index ecabe0c747d..9157a4ac649 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -60,7 +60,8 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
 void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
 void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
-int vfio_cpr_group_get_device_fd(int d, const char *name);
+int vfio_cpr_group_get_device_fd(struct VFIOGroup *group, const char *name,
+                                 Error **errp);
 
 bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
@@ -71,8 +72,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
 bool vfio_cpr_ram_discard_replay_populated(
     struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
 
-void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
-                             int nr, int fd);
+bool vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                             int nr, int fd, Error **errp);
 int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                             int nr);
 void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 56fb67e6b4d..3ad084d5bab 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -28,7 +28,7 @@ typedef struct CprState {
 
 extern CprState cpr_state;
 
-void cpr_save_fd(const char *name, int id, int fd);
+bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
 void cpr_resave_fd(const char *name, int id, int fd);
diff --git a/migration/cpr.c b/migration/cpr.c
index bca43e9bf35..cb027bba504 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -82,10 +82,29 @@ static GHashTable *get_cpr_fds_hash(void)
     return cpr_fds_hash;
 }
 
+static CprFd *find_fd(const char *name, int id)
+{
+    CprFd key = {
+        .name = (char *)name,
+        .id = id,
+    };
+
+    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
+}
+
 static void cpr_fd_hash_insert(CprFd *elem)
 {
-    /* Use the same CprFd as key and value. */
-    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
+    GHashTable *hash = get_cpr_fds_hash();
+
+    /*
+     * We prohibit inserting duplicate keys into the hash table.  All callers
+     * are responsible for checking that each added key is unique.
+     *
+     * 'elem' serves as both key and value, and a replacing insert would
+     * silently free it.  Therefore we assert, not overwrite.
+     */
+    g_assert(!g_hash_table_contains(hash, elem));
+    g_hash_table_insert(hash, elem, elem);
 }
 
 static int cpr_fd_pre_save(void *opaque)
@@ -127,26 +146,24 @@ static int cpr_fd_post_load(void *opaque, int version_id)
     return 0;
 }
 
-void cpr_save_fd(const char *name, int id, int fd)
+bool cpr_save_fd(const char *name, int id, int fd, Error **errp)
 {
-    CprFd *elem = g_new0(CprFd, 1);
+    CprFd *elem;
 
+    if (find_fd(name, id)) {
+        error_setg(errp, "cpr fd '%s' id %d is already registered", name, id);
+        return false;
+    }
+
+    elem = g_new0(CprFd, 1);
     trace_cpr_save_fd(name, id, fd);
     elem->name = g_strdup(name);
     elem->namelen = strlen(name) + 1;
     elem->id = id;
     elem->fd = fd;
     cpr_fd_hash_insert(elem);
-}
-
-static CprFd *find_fd(const char *name, int id)
-{
-    CprFd key = {
-        .name = (char *)name,
-        .id = id,
-    };
 
-    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
+    return true;
 }
 
 void cpr_delete_fd(const char *name, int id)
@@ -173,14 +190,13 @@ int cpr_find_fd(const char *name, int id)
 void cpr_resave_fd(const char *name, int id, int fd)
 {
     CprFd *elem = find_fd(name, id);
-    int old_fd = elem ? elem->fd : -1;
 
-    if (old_fd < 0) {
-        cpr_save_fd(name, id, fd);
-    } else if (old_fd != fd) {
+    if (!elem) {
+        cpr_save_fd(name, id, fd, &error_abort);
+    } else if (elem->fd != fd) {
         error_report("internal error: cpr fd '%s' id %d value %d "
                      "already saved with a different value %d",
-                     name, id, fd, old_fd);
+                     name, id, fd, elem->fd);
         g_assert_not_reached();
     }
 }
@@ -192,8 +208,9 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 
     if (fd < 0) {
         fd = qemu_open(path, flags, errp);
-        if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
+        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
+            close(fd);
+            fd = -1;
         }
     }
     return fd;
@@ -400,10 +417,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
         }
     } else {
         fd = monitor_fd_param(monitor_cur(), fdname, errp);
-        if (fd >= 0) {
-            cpr_save_fd(name, index, fd);
-        } else {
+        if (fd < 0) {
             error_prepend(errp, "Could not parse object fd %s:", fdname);
+        } else if (!cpr_save_fd(name, index, fd, errp)) {
+            close(fd);
+            fd = -1;
         }
     }
     return fd;
diff --git a/system/physmem.c b/system/physmem.c
index bd5f41cb020..d54eb21fc01 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2447,8 +2447,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
         fd = qemu_shm_alloc(0, errp);
     }
 
-    if (fd >= 0) {
-        cpr_save_fd(name, 0, fd);
+    if (fd >= 0 && !cpr_save_fd(name, 0, fd, errp)) {
+        close(fd);
+        fd = -1;
     }
     *reused = false;
     return fd;

-- 
2.47.1


