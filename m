Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E719CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYc-00064H-BO; Tue, 29 Sep 2026 13:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYa-00063e-5q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:56 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYX-0002kz-GX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBFfqGGNAzZRFKQus1QAxNah93ttuUkIsNs2pGpSoGDuKcMMLljeomMx/88xBy0rgFI7Tt5rXdCjDP+4+c6yWGAWBY9XNVzZRWae/TaGuT5RgGDBTNIazs/XzKTLay2TdXZvcgoKwPv7hDErTKXFmUJZaaeuY7y4jpk4njPG/e5r2bF9x2Fr3TPNeXcdv2m95aL+s4+oM32UhVTfYGVp6JuistmNYxFwCuupRW09SyRv8uGoyX4ZdyZPS4XpaRRtEQFEFqvJnonOCYUfirdbjzP5WHPHUQdUZtvxR8vwRXR+iTMY16PnnzSqO/SqjUQ9jOvU8vw5zT86guOgCFYTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOJJ5FLiIJbH7JVc/XuIwxeVnyLn7QwjyOB9uZ8um3I=;
 b=ZT5kGZemjiIA1NcqygxyCU8NZeQ2nYQPvFNnCTc0FvZzcHp3hzEQjmidBVPI7HYtNO2f640JR1VN4tFyLqJJkwWJAe8MAWi+hxQ8sEK9XOpJoaweiMJg2cLTuu+XI/xrdtBXY6eFhagr7IrlJk1ehVSZ9877HB2cFrAkta2/cmPaf0dmNDWuSwhUEqyVAvSrCnsmh9fvKYDWlnyQSGEBFCD4vdybfQH1bmETlkHYlYMJ99wO11j96pMI9xnWLRIYzSNLki59MNtxH7voXRLtvJ1p3U3nOjBhkNj6WqErqxtU3MesZW8an+zJrtnct0f40cK/n3FFtG64Mm+n5Fj5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOJJ5FLiIJbH7JVc/XuIwxeVnyLn7QwjyOB9uZ8um3I=;
 b=S8o0Ipun1ApZi8KCBQaQSxyibvoAQjZWcCjwmOVpBwI4U2iPN/bs6jOi93yHr2+vI1ZgPWp6g1YaUv/E1nDCh+CfJP1PI8HnqR4ALckPy3HrIhJxeVcNDyr5nEFNA+Pg1GN0ECozTKawrbpi26Rm9jGeFmSPQ+pU5EshRLa4NjR0S2g+IvbRJ/x2eZXn3iARRLWc3b1wFGacPYI0vpi4eG8AMwsQKxQPsBY+VwerT1Omm8E/nl8km3P+FVyAf0LFfmIJsvX5eYjLC/Y5pxl+PYjQI7782fpZCA0UBcEuDH1Topyp+C3CmO2I1a0yWcZ5zZv7sWutWL3AnO41hbMThw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7910.eurprd08.prod.outlook.com
 (2603:10a6:20b:50b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 17:23:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:20 +0300
Subject: [PATCH v8 01/17] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-1-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 0590f36b-686a-4301-3965-08df1e4e6b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rkmhpJfwRkmumwWXKKLodADzQvdl1oLzvDDuyOPonW8rO4/dAFqHRTSzB0DjcImQaFubxpqS1eBFeaD2siZc20mMpdgu44uH1jgymfQ5LGRNPasAvW7nXCu14KyJmZRNjvGFXmLLtLVA+APA5dWpJBFh26725vB1/vio9Pq+rM/BQSyRYkJWZBh3JrUOe+Zs63t3N+ZZC4ry+Ww56BYjyCa2s/yYQZ6YiMjFTQqKaC1n88fYKlay7Ic3xOo685jWtS6z0Bo/irbDxSRmQkSusQp9CaGbkakf8RIecVN0sAwJ+A6TX0mZNpfbKu5C2Kg4fw1CVgvJxEnslU8AS/917PYwATvmxAMB4t2xIb17raXOc1bjnmgJsrwZvfe8uYDYqHSOXKrjqbgtDn3e0ijotdTboSo7m4WD1kxmmAPnnBzdLDzY7C/yxUueyIZaRPnlUiZIKlLtctAl1FfrlazN5jc+s9GKVwwykl+uNkBYeKaasgGrPHy4QPGBMkvWYOQ51LXOpay1bhKoXD3++FvqdILmNevKqGn5wNNNBQj0Ja714q4RM2vdDmu0ssLw49EjpasI53Dudf7r28oKQV6biTI8WC+1lVlP/XN2NxEwyWNH2JVh3WVDZpIybmpms7cnCeZ1Waz2zfmBjuwJey/Xmu1qQf72s26FmDsPe/M/Xh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhoWGoveFpYOGNRZktDVG1LM0pMZ0ZEZWdOL1hLNVdaTnpBYXhINVN5Z3Za?=
 =?utf-8?B?ZVErVmxyblNEc1BGMGlNT1dKclZQQjBpTFdsOEFZWWZ0M3RjbGZWdFVMUUpH?=
 =?utf-8?B?d1BYdlR6eCtJdU9nb0VqVnlBRkY3eEZzRDVOb0NTVFZock9OZkRVWitMbVI0?=
 =?utf-8?B?RUZramtDNVZGZ2JhTEZZU0hkL2xnUmdwWVFOSVJubHFYekFUcVFuS3dhMXBp?=
 =?utf-8?B?NnpQWG96OGxxNXB1NW9wNTBQTjFRY0FNbmJqcXJ5YmVkRldiU0J0b2QvZ0ND?=
 =?utf-8?B?RFlDSjhSUGtGN3duUS82OGc3eC9CYnpCQlFIQ3R1OG9oSEk5Mno5U1VvUThk?=
 =?utf-8?B?dFBZSXhuWkFVZThObEg4emxURTRoRVQ1eWgxQVRtZ3pYM0VLVVc2YnFOVnpB?=
 =?utf-8?B?N05vVnRWekpvMXBkRmc3QTdEUXlNbnMrUGgrcDEwbEhhOGxmMkg2QjRKSTlF?=
 =?utf-8?B?ZHNRVzNVd0hKdHZWYU1PSk9vZ09jSk1yMXVSQWFZaU9nd1VldVFqd1NRbDIw?=
 =?utf-8?B?N25Pd2VIQzVsWDlic3d2bFRIcTRjaXZGRFMyLzZCSi9MOWZlVTNwN2lxTVVa?=
 =?utf-8?B?TmREZ1R0NCs1UnNwdHplbVI5NURTL2tWSEtlRTFIOTVOZ0hEeVFubGU3aGZ3?=
 =?utf-8?B?aVNtM1dJQ0lJRFNvR1lCMXBoMmREbFM5dHFIOVVUbVdyd1BETkdUNVVraHRp?=
 =?utf-8?B?L1ZkUkJDL2NONTArMGovRVBLRTVlMlhYZGZEQWZYOC9ZdFNXMURHaXBKQmR4?=
 =?utf-8?B?M3dXcUk0aWlJSGZoRDJQaDRDMW5PZnphZ3JjSytFVDNrT2liV05UR0QyaXhK?=
 =?utf-8?B?ejRCekUxYlZjTVJ4OUZ0RDNQVUhWcWZNQ3h2Q1VnZm1sWEI1TGdJTFFWYzlL?=
 =?utf-8?B?T0xDdUx5V2w2Y2xhcmd5OEgzYUNxY3FLVXdWNGd3RVJRV3YwcnVwTnBRWVJN?=
 =?utf-8?B?eHRPbkRVS041MDlxUWJBN3RSMHlkQjU0VDlGY01yelE5bVJFQ1QxS3ozYS9u?=
 =?utf-8?B?L0xzYUJWRE1ZTnhSMG5peEZXTzNlS3E4VjMvM1RMTFBLZUVMa3VicHd3QVUz?=
 =?utf-8?B?T1dZOERlbUFvK0wzc1ErRmtvNG9MSS9vVjlMR08ya0dzaDBHcFRXaTcxQW1W?=
 =?utf-8?B?Z3A4MGs5dkZVOXNmS0l4cnFKMXZFNkNVdGlRUU9SZ203RjY3dzFEanF6dlBH?=
 =?utf-8?B?RjE2b2RXTXV6ck9vLysxQit2c1dKelB2aVpYMndvbUhZbVlXdlhaTk5zZWQr?=
 =?utf-8?B?MWlIYlJFWEg1SUc4Zk1rOUpqSTBNMFlER0pZMFNML2NKV2NtS2JRWlViS2tO?=
 =?utf-8?B?cEdsMHJEbGk1dkpDaUpyVmhaZXk1QVlod0JhanpXNE9ZakRZZ1JMeGJqY0tn?=
 =?utf-8?B?S3ZFV1BMcEo4OXNSUDFmbXVSUFd0ZzlFYThmNTc3Szc3eUQ1ZERYTGtJRlNO?=
 =?utf-8?B?NnpPV1lxcytkZHhTVTNvd0ZqMTI2VVRkcUFqWEYzUnowU2ZHYTVvWHJRRnl0?=
 =?utf-8?B?M3h3Z0tSV2pHWEJMNmNzYXpTWGJGZWZIWVpjdVM3TU1NTytyekxML3hwNkRo?=
 =?utf-8?B?V3NHZjVoSDlsVGxBQ2FjSTE1b2VIY1VyczBzeTlBY1R1TzFlcmI2djFUR1lM?=
 =?utf-8?B?U2d3OFFIdHc5Qk1GYlBNWm1iZ2ZkWWNoWnRqTkdkWGZJYnFndDFTS1R2SUNm?=
 =?utf-8?B?alE4aHpHQkJnYURaOFF3ZlU3dFE3TllCS2FCSktlNzh1Ri9iaDE4cWFnQ2tL?=
 =?utf-8?B?T0FHcUZMNXZyR3pWWkVJV0J5elhsNkplQjU5L1ExZVk3SlB6eDVLMTZTKzdr?=
 =?utf-8?B?bU9UbG5CaXUrOU1rTlppU3J3MmozS3lZMmRrSUlMQ1ducktoeHNUSENuS3dm?=
 =?utf-8?B?c1NhMnhicE5MeUtRQ1VFenE1bGVvSEw5N09YdG1ESG9mOUhOdlREUGxwNS9H?=
 =?utf-8?B?ZkRWYnpxMDF6MXFaSlZQY1FBeXRjZHFpdW5iRFVtWDdTZ0EyUFRGRUl2bjlC?=
 =?utf-8?B?R1h1YzBDTkxuQ3Mzc1p6b0xHZWdmQnJGelBSSlIrZGwvTHlKa2l4bTlRUWtr?=
 =?utf-8?B?aWRXNE5YZkRoQ0pUcEVhREdqaWlmYTFNT0JIc0JlL2NqcGhIQUQzUzVsTVNJ?=
 =?utf-8?B?Vk00QW1Ncm5qY1ZKVkFnZktqQnlwM09Lb0dLenRvMS8rajNmTHVwWmp1Zita?=
 =?utf-8?B?NXlldi9vMWNoOTNpVzZraGtqTG1TU0wrbnBLcGVxWlcxSVM4blZnN0V1VWZE?=
 =?utf-8?B?dG01NG1MdVRCVDZ0SUJJMzR1a0NwaUNMdnAxMjArZzRyYXdJdlhlbG5VdGNS?=
 =?utf-8?B?L1dhdDlIcVJKeG5XMm5ORGtadWNtSEtTOVpFZkRTMk9idVUxalkxM1JXSVVw?=
 =?utf-8?Q?6StgdMWB04/ZhtZA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0590f36b-686a-4301-3965-08df1e4e6b1f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:46.4330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmtVPVo2PIxh4OQkDLZDOFMrJa3BmBJBtVBIQAqaeWMrFpXodBdmd5ph34Pb6ZAyUJLNJTkWZj3BgyOCaQRv76V9fDACbryIoe0apdxqB/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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


