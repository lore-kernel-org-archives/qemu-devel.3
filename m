Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA9C982DF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwY-0003FK-9I; Fri, 18 Sep 2026 09:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwW-0003Cm-0C
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:56 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwT-0003Ft-Ek
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fklD6UkcirQ0vdhBhF3kInt58W9VYltIOrhWTsoQyGa3yHYUTENj0CbPgF9M0TuzMFrRpdyDKGFAU4NATicHMGFgs7StGCF7eb75TGIj7hBa3qZaBg3b3W5rlcVkkzqkx7Cpf7Hn9zg162kT1yjpnh0yXo1crJPwsyCPVf33APU4wCBXNrsvLWQCE/mF5WPysjOHZbfwMf1xNj/nZkSp/oIuaPpeOX9DJo1jAkMkL093U/xAqH0PqiaHQkFlhWCsQLZbmrFSJlMh3Rl5h+RsP7khikRjP6jE8MXMQm8F45l9qScrf3uf0Aq5HrPzVbHv1TvwDkwMqm9HQaaC1FvKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUEUTWdelGQXMm1W2Kx5Tno95eXuT9Jplsc+CJhOvPk=;
 b=XrFBjB1YZYfqcoEgUTC+KA3JFZqkTFzgKtEotGu6tYsTOZeAAUyLf0rY3oLxQEP4hfSl7kXA0ddtsrkXVy9R3GO1cM76r4wVCrl73/SloLkERq7Lkwixre9G06KMe7FQAoFh1qlIaOUQvh0fAs+ZpBWIxB+GSTUBhhfMhw3tIDdQE/lYgSh6i/zV/WSbLYUL4JNiOMVgM3/uNTmDeKxnZmIBkwWCT95sXUN1W45ybJRI9qVZfjF9MpYVCcRWI+wqz73BduzhtDEu+yW2JkiKuH8KJDmCMLEvkG57ct9V57gN2ixMO7Gsb90MRcHqaolyH2DWQ5CBaF8IkvwHtEDKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUEUTWdelGQXMm1W2Kx5Tno95eXuT9Jplsc+CJhOvPk=;
 b=Wx2ufq/rScMo2Ciuz32Cm70dtMsBddb7v8sxmSsl7qSziOOp0KQ1EwJh/1BO8Jj+t2+qGZnQ5esugnjX9mHgBpnTzteCCdYaUu2MqDSlKOFF2Nt6hYHR/EqihUfmjEdCHEhOh51idWeHqDESLqWJdtIypVu1Mylfkm0t4vC4EKOOWBHppccKQJdUYL6GwTcRyzfeAwpcVXZiUvRSaRwvMmr5HuGNP25mGmg9JQZ2Na9LhTFv62mZbSQ7TfuSngEdIWWTcYHIY6iqlTY7w7cHyXonKzcVI+Sn+fPSoRfKmYMjhcT+QMdh4onqfm268tMNWacDZdow9eqQAIKkBwZW9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMBPR08MB825636.eurprd08.prod.outlook.com
 (2603:10a6:20b:7b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:17 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:17 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:52 +0300
Subject: [PATCH v7 01/16] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-1-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMBPR08MB825636:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7608ee-ae67-4711-c4fd-08df158b5a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: xS4xh2elI2yPb7/3lFhmeUnMICGl9sNnbkIf5HIt5RmGONk6RVCiMZaLy0MluoZbh3QnkjW6owHNTgKbr3EVfpPt2ZlGMvwooFRzQA9SjQ0L0oztz2lrK4XhchbqFvZKfUo32trG5BFkYB53DR1+qhPCpjP5woV0hPyN0PdqCwl/g1us3AtHZzgDuZkTxGIK4ijp5HdDm4VetL168D5QLMUyu2xXma1f8A+JcYV9aVbwZNKPE1yAwzAxv6fbLnsXH6hGr5lSQpUVQcdJImhlKj5ei+a5vyC8d4CzMhVFmRF98lZIuqEkM9wdHKmc/MpXalPE8rZFxqBTUCCWF6DTwpOnT+MgB9X09nWUqpiP/J1pEKyHbltR3DRpdF5qDJ9inbIjjUVdyJb1GLqhByKJeru/gASMGUoAfPmG8lhtF4Es3Ml2GNd+p3iENmKaMSTaiqwyvzDTgGQprJexgeKNsptm29kby9CYv9wQYLa7yD1cvX4lfOuIkVGQCBbIo+2a2z/by1YdauQADx1kO0YswEB8a1Xsl4guXxtkdRUVm59Zh6yIlk2q+WCi/NTnSgli3OE2tt5S3cDJRHi97C+2MMEytIN/aNVTpgDS/b7/9j2Kl4Hq8ipbOp5iOmd9c5dPL7sTDkX7tA0ad9PU5vHgfgQHMLj6MP/SX60hKK1Fus0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9obHpUdXluTHJWWHdXQloxcTlxMDJCakhKblIzK1M5Z0loMFBMNU1SRFd4?=
 =?utf-8?B?WXplRG9xQ0Yvd2Z1dDdUVTI5SkU0UENrN2pLWEcwOHRXQXM4RU1PZU8zNGVH?=
 =?utf-8?B?bWRvbDh2NVJYRi9qeUc0Skl0eDBKekRMWlprUmhZUTkxcTczaU9KOSs1SzZ1?=
 =?utf-8?B?VjgvYjlUeFozR2QzdVBGN3RZZlZKR0EyaXlNbFJKQ1pKbTROL3lyRVVNT0dq?=
 =?utf-8?B?Y2tJRXJabjMrWkRQZXdmSVUxK3pvNmhKQTVzQ2luNkR6TWtaRmdCdDJJUFI3?=
 =?utf-8?B?M290RWZyNDhNT3NKVXV2UDFYSWVzanBCbktuaU9DMmlqZGQ3TnNMUnR4d3Fh?=
 =?utf-8?B?d3UvMytISFNtdnRKNXBJOHRRYkMxb095NU0yOFcxNGtmSzQxTUp1OVdzVlh2?=
 =?utf-8?B?dGhRNGtEZlhvUGpRZmhvdXFyV1JLT2wrQzJkcnZaQ1h0SDM2YVVwaktmMVRu?=
 =?utf-8?B?VlduRmhQczRvTXh1UXBXdEdMOThJWFpJdm1MREtHSm9wcnpEQjhIOERKTkND?=
 =?utf-8?B?cXB0cDNTRGN2NzFzTThwamFXOVpTK2VEK2tCTGhoZnBaRHBXMkhiYytFOFR1?=
 =?utf-8?B?T1d5ZS9SWUxUY1k1WG9McUw5SjVsRlZrRkFsSUdnZ0o5dUdrRk9rY1FHRjhR?=
 =?utf-8?B?dU9LdmlHcDhjbnJSdTc5VlZsSkVEQ0g2bXRIaGlycWN3Z3UxRzRFMDFPOG1s?=
 =?utf-8?B?L0s0RlprWm5KZ2htNmxMcm9LSXZ5UzgzV1JFQXRoaWJhS3R5ZjVKMWVDMXRp?=
 =?utf-8?B?TVJuZEdSKzBHbWp4WGRkSDJaMlgyYlBnc0F0UFJYUkRkTk9DQU5MZHhiYnlM?=
 =?utf-8?B?K3lLc2tPYmxZU2swTTMxTHhCQk03aVM5YXlnYjdtK2RTeWdpYzZqQmgvUXVo?=
 =?utf-8?B?dXRaaUVmQ3dPOHlvRTFPYjhKK3lqZnhtTS9vSW5NK1BKUENCZkJrdHVkVllJ?=
 =?utf-8?B?VDFEMFlnbUI3SVl4VzU0TU5WSHB3S1hpczdOd3ZNLzdaeVRKQlNpOE5qb1A5?=
 =?utf-8?B?N2g0blVxUVNlZ3B3aGZQclNjVnV3dDArWjQrSnI0MVhSRjRxUWVOSWpIOGRN?=
 =?utf-8?B?d2duSkl3Y1dIb2dueWxyOTREU3h6SHordjFhbFdSS0JjbVdZd2Jaa2l4ZFhO?=
 =?utf-8?B?bEc2dEJsOGQrNGJLN2VVcUhIQUlaTTNFM0dqRThLTGZhbW44RHp2b3V0RUo4?=
 =?utf-8?B?YmF4dXJjZW1qYWc3M1Y0NHdETm15Tm5VL2dlaEk3UzJmdldJK0tHMHJJOUNu?=
 =?utf-8?B?b1pBM0hDVm9ZY2RxcjU3bHhYb21FeDNTU3V5M1R0OE5JV3VCT25GSjZBbTVF?=
 =?utf-8?B?N2wwMHk1cEpEaUtPeDZVcVBGRnJySzB1MTh5VGVoYll2b0ozUVhNc1NBZ3B0?=
 =?utf-8?B?RmVNa2xzVXBKVENLcFp5Vi9oMGV5dTNRUjFEU01IUnRtOFR2em5OMG9BZGcx?=
 =?utf-8?B?QzJvNjU1Rmgvem9tbnl6WUY5WTRKR0VuTjJvN2Jhb21vb2V4NTZ1Y3g0OFRw?=
 =?utf-8?B?YVFoTi8zRDdISHl0aFZYQnFVcjN5U0Q2dmxKZE1oRDNYR1FZR3dYQU9GbnFt?=
 =?utf-8?B?YXF3RmwwTE81ZGRZeTJqS1RvOU1KVzNhU3YvY1B1RkEyMy92eU4wVHV5eW8r?=
 =?utf-8?B?ckNiZ1lzT2hZdmJJb2h4RmRwaXk4dG9pQ1I4Y3lHTGo1ZWk3R2Q1ajB3MjNR?=
 =?utf-8?B?a0JJVnl4dWcyNlA0NVpxOFhpSWorVWpBbmlLbVJQTUNMdkpaMWxnaFpjMGpa?=
 =?utf-8?B?TXF5M3VRZHFsQU5CTzRaMUdPWGZkR2ltNTdjMURhNjh6WXg1NGtpZENNMDlO?=
 =?utf-8?B?Qjc1ZnU1b3BjSkRkTzRzeDRIU2x1TFhPQnViN01tU0ZxVHhnMWtyVkFsNEpv?=
 =?utf-8?B?TjRrdlNBRG5jSFgxQkoyZXlxVElpMktSb3BDNWFyTnRuN2xOdmlhV2NwYzRi?=
 =?utf-8?B?VTY1Z0RwakVNTHRiV0xLOHlNOXo5dTFHVHpWVXF0YWdZSnRxdGx6ZnJLU29z?=
 =?utf-8?B?MStyWWNRb2huYkFzMUVObU1ySWhtSC9uYTdLVGl2UUtsZlVaKzRUOUozVmxV?=
 =?utf-8?B?OEVOSzdBRGxSMnAvL2ptM1BnVGlCNm9MV0xjcUFmZXBNZU5ZSkRhc2pPSUlp?=
 =?utf-8?B?TVM3emQxbExzN1JML1o1OHRXNWpXMzRoYms3S3FxQzJkOXdvWFFZSFN3OEta?=
 =?utf-8?B?WnM1TkNlOGdadjBIYmpYZnNaeFlJakxKeXlxTzlhREFDdU5YM3pMWUp4cXh6?=
 =?utf-8?B?SUszSVBOTlNsTmxIUk96RnJvMFd3Vm90Y2czcExkQ1VUS3hvaDBsWHhmOG5q?=
 =?utf-8?B?b2M2bEYyOGdLSkNYWExBVm1iSWdKN25sMEJmd3JlTFdWZCtFRHdzZC80RUNY?=
 =?utf-8?Q?2mYQatn9SyK7TuJw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7608ee-ae67-4711-c4fd-08df158b5a01
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:16.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02Rh4TqFB3odQ1oK16kkNF4Q0wWik+vrkkcOeKMNWJ5vLRWK1trCnOotNA3jIEImsIvTEd+wN63EwF651wqVCTNC+c77J15ZAxP28OBFDqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB825636
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 backends/hostmem-memfd.c   |  5 ++++-
 backends/hostmem-shm.c     |  5 ++++-
 backends/iommufd.c         |  4 +++-
 hw/vfio/container-legacy.c | 17 +++++++++-----
 hw/vfio/cpr-legacy.c       | 10 +++++----
 hw/vfio/cpr.c              |  6 ++---
 hw/vfio/pci.c              |  5 ++++-
 include/hw/vfio/vfio-cpr.h |  6 ++---
 include/migration/cpr.h    |  2 +-
 migration/cpr.c            | 55 ++++++++++++++++++++++++++++++----------------
 system/physmem.c           |  5 +++--
 11 files changed, 78 insertions(+), 42 deletions(-)

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
index 7ac7b372145..1d2c8356189 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -844,16 +844,21 @@ static void vfio_group_put(VFIOGroup *group)
 static bool vfio_device_get(VFIOGroup *group, const char *name,
                             VFIODevice *vbasedev, Error **errp)
 {
+    ERRP_GUARD();
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
 
-    fd = vfio_cpr_group_get_device_fd(group->fd, name);
+    fd = vfio_cpr_group_get_device_fd(group->fd, name, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "error getting device from group %d",
-                         group->groupid);
-        error_append_hint(errp,
-                      "Verify all devices in group %d are bound to vfio-<bus> "
-                      "or pci-stub and not already in use\n", group->groupid);
+        if (!*errp) {
+            error_setg_errno(errp, errno,
+                             "error getting device from group %d",
+                             group->groupid);
+            error_append_hint(errp,
+                              "Verify all devices in group %d are bound to "
+                              "vfio-<bus> or pci-stub and not already in use\n",
+                              group->groupid);
+        }
         return false;
     }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2d40d8baeaf..14a06a1fa59 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -254,15 +254,16 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
                                                 &vrdl->listener) == 0;
 }
 
-int vfio_cpr_group_get_device_fd(int d, const char *name)
+int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp)
 {
     const int id = 0;
     int fd = cpr_find_fd(name, id);
 
     if (fd < 0) {
         fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
-        if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
+        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
+            close(fd);
+            fd = -1;
         }
     }
     return fd;
@@ -291,6 +292,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
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
index ecabe0c747d..e57766e7e2b 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -60,7 +60,7 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
 void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
 void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
-int vfio_cpr_group_get_device_fd(int d, const char *name);
+int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp);
 
 bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
@@ -71,8 +71,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
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
index bca43e9bf35..aeb9ad12392 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -82,10 +82,27 @@ static GHashTable *get_cpr_fds_hash(void)
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
+     * The same CprFd is used as key and value, and the table owns the key.
+     * Inserting a duplicate would destroy the new element while keeping it
+     * as the value, so a duplicate key is a bug in the caller.
+     */
+    g_assert(!g_hash_table_contains(hash, elem));
+    g_hash_table_insert(hash, elem, elem);
 }
 
 static int cpr_fd_pre_save(void *opaque)
@@ -127,26 +144,24 @@ static int cpr_fd_post_load(void *opaque, int version_id)
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
@@ -176,7 +191,7 @@ void cpr_resave_fd(const char *name, int id, int fd)
     int old_fd = elem ? elem->fd : -1;
 
     if (old_fd < 0) {
-        cpr_save_fd(name, id, fd);
+        cpr_save_fd(name, id, fd, &error_abort);
     } else if (old_fd != fd) {
         error_report("internal error: cpr fd '%s' id %d value %d "
                      "already saved with a different value %d",
@@ -192,8 +207,9 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 
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
@@ -400,10 +416,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
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
index a4a6a4710c6..e94fe5d4a4a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2445,8 +2445,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
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


