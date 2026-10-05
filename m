Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A239CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC2-0008FF-Sl; Mon, 05 Oct 2026 11:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBq-0008Dr-MR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:19 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBn-00056Z-Ua
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPISRHdjLdZsLyMg8VaaYylsEXSbp8LVXrEa4WebGd2ydXX4DwWz8FFfZB6Wnt+suduhS9gLvXDQ3vY2fE7RVFMNQg68dRVXqL7ElMTQRTu8eu+5eKJ51WbLopj4D3h8R/rwvnpoiH9/a8R3yNBpNRJ8ZrA9QSKAO46appT7jJsmC1dVnb9vkRq/hn3kussccp0ROCUtBUmXrSeuaqM5EE7nDk0lnY/rXYeB4XwkxFy/Vo1XdUVXlW/uJOQFvLZDTljGZI1VdFop+IvaHXRSz8t9WQ7tCNzW7WQ1dwkGFgcjxfyXQB+1SZfiKP1YDvKjPSZD/1ooBAFSeMftBe0ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=c2zI1VOZt8AtHUP6BNzBDrxHJhGZYYLrR9ep3C1tsmBbN00QGdvmIZO1bdTCfbbS1OY3/BXDc93f6dmYg0FaZfhIywCFKLrt1K7InfcaDG5ofe9aod0dNx/RcNPsHiaqlICUEeztUw5zXoCoTEYbZg4Hv91XD/OzFSedWZZrraLP7PEp79tV5xO4eIDRiKYmM1LXQBibMFj1CoLT7Rd9VNga9PjRX0O4Gjv1yhKt3ZHDpM4eGYR4SOwb16EygvPC7mt3RsU/6NYUIZnPNWnlDMrF1u0q93M7SgOwi0/jGJgmRHBNtZjOGydeY98oo7/lN8Jgtz0xTllIqjfMAGW2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=jVcPyRPmzjilChQp5Xk0guV047w/Ew0lNl5XOj8PmKuRXldQma8T7L0Jm6Lm5wLT3h8PW6KRRtWPO6fQQtztF7aWIIimQog0mlF+xIaaCQGZA/SHnjaH1Ovadr48Q6GF911M0cGXE/nnag0+JC76z70IsLEXa/gSksAscfJGaXauMxLKYMmRD/xXVrk01lboRHUPc9kgGAg+SmohLUcBvw8+lHX/Od2EDq0lp0HiNou/3gVzTbrJYhKhnU7kpbfu61vRHG7Iz8SH2bDsf/gRBEhUeWne+C39AxxVF/hnUP6dxUCIMhBXDCiEW1B9Rcr5RjfY+L0ZtrZehD/asOSI8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7452.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 15:01:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:08 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:40 +0300
Subject: [PATCH v12 01/21] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-1-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: ae694648-1429-426a-1f07-08df22f17cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: qr/+pGlCRRCGGIoqeeGvW5BDubpzaxA8uDOY30PosFI83k1qzNnjY9i0jyDH89cNxMpgTTiC3csGRa7ABHO2LTmks5M4wS+uKPexY/nilCEXPs3kKqqkIcC4koDqYgj+SS2+L/PmlCoSlcUZihb63PQJbbgcxY6LYs74AeQ95kCwBKFclh0mM2/z/TubKElu6XxeeaIBfsdzUAbAUA2VvZOiONEyhOYMTFeIroQX0qb9zKUhDjgSZb5z0adI5tvl9VlUDWIJDUMyPJMXlvix1G8hh4LQfG/3xW0kn/ghIDegs7/WKZ3NSjiGCv2t22Ad5Xp9lZLesqXcipwENt28gc3d1si7tsAkZVybHSecEhdKHGjZetgnNMlKOimOLYu8urDUIDh36LlGFcw6ugrXr5DvY8m/UgBHcJ1rBAATtyjn+UqmHl8sUTaXiyr+sjnp1pzHQUSiT2XVi1fHIY+2JaGNZjvZ91CVZnAnwz40dVjOXNPQ2U03MpaMC/yf9OKsxW7/KW+SzjtQ5EIspsXjT7DbjipfyAux8erYueluyZdkwVEszEZ1AxV7jKKfwgJuUWmO+TSpPefmYLnlARFcr4H4WKiH0OdPM06F+gjGCYCKuRBEsC+KvVKosnZoKQv+GBkjzoqZvJqHzrYOCFEKdMibDcgfWtaxiV+icToSdyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2I1R3Y5Mjhtcm01dm53S1Q0dXFOeHdBSkdLeHBhbU05T0VxenBraDdBMkVk?=
 =?utf-8?B?T1ZNdGVOUWVhN3dsaDFwZzlUa0VuMW02WFpFd21CaFJvRTFsTmZxR2tkZWE3?=
 =?utf-8?B?RTlDd3E0VjhabGpoZXBja2pyY284TmRiRWs5Si9CWDgxYjhFZ1dIdEhsOEdh?=
 =?utf-8?B?c0xtOUExWnV1REg1UHhpNGtKaTVGRXZxSlpLRzNUMFpyZVBGUWVpNGZlNTc1?=
 =?utf-8?B?UnI2cGlrZjFNTlhMVlRrb3BSelhoQnpHNlptcXptT0hmSE5ndmJWaEtUdzcw?=
 =?utf-8?B?aG1URURHNlpsK2xST1g4MDQyM21zUDhDb2IyUFM5anRROGxjWlhNVjhOSXlJ?=
 =?utf-8?B?WmNDNVVOaXZ1QS9BeXZ2Y1lZNkdFYjVzSndoWjIvck5pNzg2YzVNOU1yYi9Z?=
 =?utf-8?B?QU82OXBFdllCdkVzVkNRRkJER2JaSDlLa28yZEZ2WW5nY3k5YXVxTi8zT3I5?=
 =?utf-8?B?S25JeDZaVVdLdFhyT2tidSttTE5lUDh6UzcyNDFheXZvRGhPM01TUmVTdnU1?=
 =?utf-8?B?WmRJWnBNMlc5ZUZnSzFjZHprRzV1Y0dybDlpbXp6bnNoQzdaS0pidmJuSnVr?=
 =?utf-8?B?UGpPeG9heVlnclpETElNQ0RnWm5wU0QvUjBDVjM5dTB4bzZkZkNJM0dLc3VS?=
 =?utf-8?B?TFR6WDEvcitmRkNrdEZ6TWs0NExIMmJ5eHE5azRtMUxaQndMQmRENVNZWTdE?=
 =?utf-8?B?VEcyR2NSdmQwTTk4bC9sL2xVWklWSE9lcTltaXN0ejFGTmplQkVSMHhERHJ3?=
 =?utf-8?B?RDBxY2tGZ0dHOXhkZ1FhSkRGVkw0a1FGRkxoSWJJVGlTS0dremY1WGkrTTgr?=
 =?utf-8?B?WFBYWTlodVU5SVVSMDBYcFMwS3R6UnNWN2o3MzEyb3hmY1dGTW5yVXpBcElL?=
 =?utf-8?B?OTV0VHBldkNEYm9GZ2hjNEhVR2F4a1NkYmZRdXNhUFQrRXJiYmcxZlFMTU9v?=
 =?utf-8?B?OHJFMm5MYlZDeCtXT1g3VWVTTFN6eHp1c2pOZWFhWU54SXVwYUk0RmJIcC85?=
 =?utf-8?B?TWdQQ0t3bSsvMVVmOEwySGh6QmVxdFk1VTVXZUVnVDJzYmZHdlpvRU5qeDFC?=
 =?utf-8?B?azVrZlk1RXZlNTZJUU91K29qTFhXQ1JpUDhFMlUzOXQ5cG5PR05NZjVYMFNK?=
 =?utf-8?B?QXloNVp4Nmw5RG9mMk1vZWwzd2ZuQ05GKzhlc08ycVRqb3hqY2FoZ1hhbXNZ?=
 =?utf-8?B?MkNhS3JteFhORWhqcTQyc2J4MzZhL2puOGR2ZG1XYnlEZ2E2anZYQ2Zab1dV?=
 =?utf-8?B?TjRGK1FMYkxDcmpFamhLd0FpTWdLTWQzaUJDVU1CSitLN0lia0RhazlQM3Z2?=
 =?utf-8?B?YlB2bERWdUtUQXpTZHdzUkxGT0NzWGpEUmJTa25sYm16T0FZWnppdlJrL1o5?=
 =?utf-8?B?d3NyV0hTeFUzRHI4UmNtNmhOSy9xRS9RajhJTnJwa3hxUERCT040NWNZeHdS?=
 =?utf-8?B?ZVR4Nmk0SDNlSFcyak11UlQ5Q29CYVAzVEFtL3NGOXk0ZkMyWk03OCs5SVhK?=
 =?utf-8?B?ektwb2l1a0UxV24yZDVES0xna0FKZldnYlF0Y1lFK3JuQWE2dXhIZm5CTCs3?=
 =?utf-8?B?bWZQS2t4ZkJiam5pWlFsWjBMUi80SU1KM1NHVWo4MVRQalhYWE1uS3pjcklY?=
 =?utf-8?B?VU9jcDZpUTE5TEx3U0NXY2tGL0RFeUtCMUFNRzhRblAzT0tFV1E2cnNtVmFP?=
 =?utf-8?B?b1dHZnB6anJZZ0xSeEltQTExV1BRdWJ2WWNWeitia1M0TGFCRnV6bk5wbVU1?=
 =?utf-8?B?bWRTbDR3MFpWaHlEZnRyVU91NUlpdVBncDNPdTBvQWVTamljV1p0WndnTEl0?=
 =?utf-8?B?VDAxWER2RVpoRElQUHNvNkt1cXVoSmJiRVNzVi9HbFR1RzF3dThQcXBMbHpY?=
 =?utf-8?B?L09HZnVXRjh4TXlzeFpjWWc5VHlRT2kzWEo4L1pJSC9mMHkrN2ViaUcvUlpM?=
 =?utf-8?B?eGt3Z2VzRnpPUDBMN2tLMHlMQ3dUeXNHam1PQzZBSm85K0pQVEF3Q05lcmN6?=
 =?utf-8?B?UytjbitPWkdCSXlORWJYdGJIWkVvUG5YTjY3U3VXalBUcDVLK1hyUGF4SFpE?=
 =?utf-8?B?dHlaMkg5QlpwRUJFb0ZWMnNLUkhQRGFqcWNHYndDazAwaVUzaVloaDZtdHRV?=
 =?utf-8?B?bXBUUUN0TFlGTFA1QVc2UndHbEVzMEovZFZvUnZoeXMwVmdUN0t3clQ0Y1Ew?=
 =?utf-8?B?TkVtd0FoRDZ1TUd3M1cxTzdmRXEvSnFBRWV2cHhQT3B3blRZdWpOYnQ4Vm52?=
 =?utf-8?B?NkhFOFBySFpRQjN4cmZXSG5scFVoUDNyN0gzNXBCdThRRmdJclFPbFVOSTJY?=
 =?utf-8?B?dFc5RTFXWlRBYTJVa3hOSEYwUnl4QjVEY21JZllhWGsyMGkzYmd5TWtqcWJ2?=
 =?utf-8?Q?pVoz6uGTcizKRZ9g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae694648-1429-426a-1f07-08df22f17cc5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:08.6706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCorT2QLwAGrEwDb3F9a8igsPEU+cle6HdGYyJcFC7E7Rxv9C7XhDvaX8WfOznU8FvV05HRLEdldMvTDGTDiB4NkPkNyShztOozDawHd1t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7452
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


