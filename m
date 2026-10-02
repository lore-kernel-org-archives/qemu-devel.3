Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA4CA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcue-0000xZ-06; Fri, 02 Oct 2026 09:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuF-0000oc-RX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:33 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuC-0007RG-92
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRz1cUkphdgKhxaFrbmeA5FdciLmdoi5McWaDjxRsaVAurnGGFKV0EQ19SP/BRTMmCH8IfulXW+kwVHkIlxfnERsuTrIHtcHnWawYgz5hHErV8Vdw4XIrMAN1xW6SrHF+DOTXzZnrM/zP6XHo1zqMM6VT7kmm4h9dS1VWGI3pz9/eg+AHZ0u2DW8WN/oO8M2TZ0Piwj1LV3CdvjXQvy52LUHi+uWHdWb9m34ww2rEL1y9ix04u+M39ttjjg56F0ZeCoWL9q1ZfoFVlNNzvm8YzOH/V8oGAh/vNWJuQtzg1h4HquIoBVUiCsgRxwRNVZ+jiywyOR5UaAlCdwmveeFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=uH2nzQ7u0/I4KrLj1XE9M5OD5QAWXOsRATWMkpgRkyHwp24peaQBJoAql3nuPKVb1abiFlXZHhQso0ygQGzIFuuT4o5WdGrKx2c/EzFhb5GU90JfHa22FPu6kncRdoufYQasMXv4d0uUIcKyLsd6nGbVBF81028TzQr/sgMjadfTNXJ+oDszCY6WwniwXXqCTEK2xR+2mB5cQJu2GahybQBn5L59OPbpdWVFj5gbw31YGFh6VV7ZAGjsX5AUQg8QWlKDUM3412/lPTzpKDoqlSxhnwcDKlTcXb19zyjOQEbZdgOjNVqg3dD4nWJZLx9sGbFw5yB0DM8ZVwSdgeJi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=UPSG0aYUJOb056fb3FM2FLqbqt+ZnHDn2qm/fHVk7oz9vGL4/rZEc3M1rzxKGppSzxI19fASWJDnGwJTIdEAvIpZM/G8YtX3dUjWziEQ9TiK8ObFP8F5/YDkrpNkuwI5z2tNnhXZjsPW0m3TdQycWjgfqR5lWZlqJvqh8GzInKqFzoWTBpp4f3i1xogOYZnx3gEsF+4H//dn8PtEH1NQ3h7L1bo+MxsomaiEQY4BrWWq+REDAC9LA0VkfyleJW4MVTKK+7blSm3SecHoHEjX4aWIECOynaWAe8QgdW+1SGzW1hXDJFz/sxW6s3L+bupGuzIpbWObXiERmDFIEdBPTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:20 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:10 +0300
Subject: [PATCH v11 01/19] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-1-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: cb76669c-9f0f-465d-5d28-08df208564c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: saDvWlMszAReYk7T4IlkFKxTXlZZQSXHH/aKqV2Kqq9HrY1HZJZySyBsx17WihDE+dO1YJLTYwP+TEHSfQdk8/UJT5N2kT7K8KesdIjOdWI9XaT8/m8MuTRGQIDUj5W/r0FlcXnu6DBFstTv1ap8ptbYotP5bvXVV2iFFq0cd4EstMhUPrnxNgATCQP/spxFnM0JDlpFKHN3bfb/2OyYN4cyrI3R58tHRgesansbJVQ7b+0yRKeKgPJqLhpCpEY/0SyOBeoWcNQuTTnLTZGGQx4Hb2doR2KaXSy488SgGrfQEdsNVBbsp8kIUgMRRlHuqapibcCFJCmg8Nn2eYbjOKh3MYaCqomOqYeY7X0mRI/HvJkbJOguHU6FujltDp4b3GLzRtRjLBOAabXlFQrgDWnAyEL98C13sZvoRYnDIKMrpYVSShVgsYiP84z3IwhirGPGkqXETnu05uqLHsiLeuIFGkVeiIgUZK8yAJauGUBkJcMOHant8YBa/dM5YVUTqp3pSkEaz3bVR+ZAtXZUujOMUUXmm3FdujyP7L7gCed3QiRF+jCcBT7DDINQXrYxfQKxF55ag9hljPNbRQLDbB1Fz1bAbhVdeP10CO6Bx1qvGuN5EVpATdUfjOzFnRFYQbKoZGg74ie5wvo/eSAvmCpXw6JJoJPSwVGD5O66VVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpQTjBjNGd4MkZkeGhacTgzOFhxSGJBYzdIb1NQdklYYWNIQy9pYmduVXBt?=
 =?utf-8?B?MWdmYndFUGhYOVM0Q2psZG9ydE5xYnMyRTU5ZCtmMlQrOVRjc0Vzd05LY3JH?=
 =?utf-8?B?SVdqZDZ2Yi9wcFVuc2QwL0Rra2tqNGlqNDUyQWVWUHcxNXFJN1RSQWhRNFk5?=
 =?utf-8?B?T24rZDRTd2QxWHNWNVozd2JxNTlJaDRJb3ArYkVFdzFtWXBKZm9wcXI5RHcx?=
 =?utf-8?B?Q09VN1d1cEVhYVQxMFlxV3B0UVNOR0FlRDhTT243L3dDeTBSaGJjNW0zTlNR?=
 =?utf-8?B?bkc3T25FbVAxNmRoekI0ZmI4VHFVcDI3QVpmam5mMVJKaW9xQ1lWVXAwc09q?=
 =?utf-8?B?ZGVhNUZBTk9CdnFLU1NzWUQzdGJDZ0J4QWlta3FPUFhvc2Y5MGdiQnp4L1Zn?=
 =?utf-8?B?OEs2Y2N4YVVmSWgxeWpDYS9LY0FGSWlHTlNQYUxmWU0xMTlaS3VCZXdGLzU2?=
 =?utf-8?B?RjllaU80ZmRpTVZPbUs5V0hBbjVVTitzM1dqUWRIVE5JUnBXU0JWUnMrYjRL?=
 =?utf-8?B?NGRPemw1dER0VjdNd2dSb2plSVYzbzZibHV1UEJRaFZhQ1hrQUdWYnlNZEZ1?=
 =?utf-8?B?TS96Ry9QWVo1aEwvVC9Ua1czVFc0WVp4RUNGeDlwZ0VsYW1tNDBTNURUbXpZ?=
 =?utf-8?B?Wk9WdjYxeEp3SCtJZGZQeTVzRkZCZ3hEemtCQzFqTmtSVXUySjhRNVBlWlhY?=
 =?utf-8?B?N2JEWmplKytFR0g5R01ONlFScU5kTVlSTWJNUHBzbUxHUDBJVWhROW9XM1ZW?=
 =?utf-8?B?c3JzWUlUU091VWdwQVJycldmamZDN2gzV1h3VXFqUThIQ0taRzczMmc0NktE?=
 =?utf-8?B?eEJYMEtEODZkR0NSOWE2UEwweFN2Nmpjb0NCYlhVMVBmTy85Y2lEM053TFNH?=
 =?utf-8?B?UUNXSFZCT2VLV1BGelJ5dlE3RHpaaEhMZFYyUjVQRjlnYytNNHZUWGpQdEt2?=
 =?utf-8?B?cFF6ckp1bC9mWFlIZ28rMDg4c2Z0aDRZOUZWR3U0akFtbUVPSUVYWUdBaFBa?=
 =?utf-8?B?MGlHSDd6eVJkYU1OaU9iMUF1UlF2MFptMFdnU1VtMjFncDRsZXVXV0hRcEVU?=
 =?utf-8?B?RGtuZXF3YytNTWxGSW9uWUgvMENobmFKQXhxUWh4TXlFZ1AwenhZTFZvdFRy?=
 =?utf-8?B?amF1MlIwdG4yaUQ4YVFoTjNHRGJaajUzNUJpMjJMeGw2Tm42bWZQREFmM1NK?=
 =?utf-8?B?ZmlTSTFCRnZNZkEzQjBuaW9Uam5tMGxmWWxvMWFtWjN1MXhzekJUc1V0T2ph?=
 =?utf-8?B?RmJPZU95TlA3STVwaVZiakkvcS9sYzMzMTdrUnRJR3JCQ2RFa2RjM2FOUWpU?=
 =?utf-8?B?dVI2ZEZZYVM4ZEJoV2JkUXlHOGphb2lzSm45VnBpa1FYRU5aQWxLN1F2SkpB?=
 =?utf-8?B?WHJ5ZXFGNWNrTkM2eWFvVzJZTm0yS20vWFQ1K002RkpUL1ljNXliYXArUUZY?=
 =?utf-8?B?aDAwVU85dEtMVkZWbkRnampIV2VNaDdoOHE4N3ZiWUxJa1Ard0pRRUVpbUcr?=
 =?utf-8?B?UWFQSFlqQisvb1luNU1IQmp5dHZHNlpYNEIvRWNHTjF0ZTc1SERvcmc0OTBT?=
 =?utf-8?B?RFVOdnZydHFZcnd3b0ZFZi80OHdZeHgwc1lOdVNtU25pNlNLY2pXbnYzNUtK?=
 =?utf-8?B?a0gwRXVyUkRkQmZFZEJpUC93clJLRm5XTG9YMDZ4c1lBd2hQYWZ1Y1hiVEg4?=
 =?utf-8?B?TjRSRzlnaWYrT2RabFBWUDNFVktxNFRWQzRZRFpLWXVGeEhubmh0THB1UWJI?=
 =?utf-8?B?M1N3RVFWSk53ZmtyVGpBR2dSMzBEL3I0SGlOSmlvYVY4MzhQdGVHYURUL2h1?=
 =?utf-8?B?YzRRQmVTeGVsbjBCRTA1eHA1NERZYStXM0FqNTJyUFdGTEhMelpxblZOMzZs?=
 =?utf-8?B?bXNvZkZNbjVJdXVPZmxJdVBCd2JxVEw2VmlBcjd1SUsyNWg5R1BtNTFnRkN4?=
 =?utf-8?B?cDB0R2Y4VUpYSGJTZnU1Mlc5SGhyU0RBU0JISzRaVjFMRktyMDB5MXJVM1Ev?=
 =?utf-8?B?Z0JFcXhQaDZpRHJ6enhQSDZGZlJDR1dhdUtVWWR3bHR5QWVhQWdoMGIzNDBP?=
 =?utf-8?B?aitMWEx4cThhdGdiU3RLYlVFcEY1VHBhTmZOUHlkWEtwZlAveERYR3dDczd6?=
 =?utf-8?B?OGdmcHUrcnhKalZwQU5RVE0yOWFoUzZkdGtnamZVSVAzQjdpK2JiMFk3OFd6?=
 =?utf-8?B?TlREWFd5SS84anZ4WW9PU0ZUTThzdEtSa0xET01SUlFZR3JWUCttL3FBVXRj?=
 =?utf-8?B?Ti93NytiSk1La3IvWGIyUnV3end5RXE3eUVrbFRqdDdLR2R3cFlBTm1UOWp3?=
 =?utf-8?B?SGN1RnN2bHV3QWVTTjFNdlVncFFyOWErM0RxTUFsWmFZYzZvUndDUUpiQUU5?=
 =?utf-8?Q?XW/NePG43ENVPEZE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb76669c-9f0f-465d-5d28-08df208564c7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:20.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM7LDB+BiIP9XH3CnvPv5hCKYnZD8cUnerrSUrkY6pzqyxqUZdFVH8cuy74rFSkQ7IBQSZ/IyGZ9ItiknHsDxAgYdg8MGrtRw6kO1amKpDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
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
index 666593ff6c0..67f1924a369 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -84,7 +84,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd < 0) {
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
index 4766db6aad0..adf60957c3c 100644
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
index db3dda563d4..a7300bb9d97 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2456,8 +2456,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
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


