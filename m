Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61CECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHB-0007cF-0y; Mon, 12 Oct 2026 06:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGu-0007Zl-CJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:44 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGr-0005Eh-IC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWIrkH+pwvB9KG2+W31bQxJTM6qtmdBGGI0U5HSEa0k0binAhZcoa9n/cZ8mit8CrUNpkXt/PFHE4OLYMcJNv6goEFATA8itBdH6nRVj0wHARQxbH/h6GEcMgimbbxBvUVhlTRI/11raLutMLNdk9HTehYqUuqpGaPNw/POw1FaMS2wtUydD+Ob0Ost24Rv2EVcgOzcFUZtuwHktS7N27f5BbExLivYgiPDcYqLsY+xogWTq0KPwJcoNAedLAA4xG5dkbQ8lolBjLrXleVzg9YkNmB6fLUJgSOVveIkMNv+wC4E/I+pNraIFDBpQtSrozBNkZ6X9xPq+GmhStXU/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=CAUnqNIm2oKREJhTq9fGiOF1aeHXzSfgyeir+hSXIXQIaXNZ4cDxukMtzL4xXfaU4Pz4HPuIelGK++3+JzsGseLn8klDVub0/yvPBJO5TohK8yC3dWcCOHl/j4+TmtMfeIvez5WRCUq+hBtFlc6tN909RnoGYT30PIupvrbil36fVkT9dxBYVSevFnQoRFrOmLXL9pzUko0d9cs+eBUHcFI/XokvehjqZ64ykzgtCl+qQA2LOmxqRE4HoEEXaS4bl6IYoBgecmCugnDvQ4GlDv7omLZgln3aJVePhElI+oUYky7onCPTF/5eHc+wqv5bmJ3wD5mfQhloTeJtynUWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=yQpoFtHFNiqe9OwgN5UUU0zp9ClluVqzswgGlXaOW+taCS6OBQIxe1ghi4oDzoONsNBv5EG6n3/XqoqEHBmwH7MJ8okD+qhWIB96e2io9Kdml25e5nDJmgtE4+lQn516l8aJ/Lb9T25DXH0dEjmTrzapfZYh6GeCYGiLY7vIKox+4kLrwWXEipU/hnhZ30aRnHTG+ks3q/h0STNVTsAQpk+yNAAAZZ+xRrYsO8hleXu6Yg389FHAQLVDpvxv0lI2JP8i3GQn9TfYj6RWQ8JPsyv2XcA1umruhNRWd5SyKujoXBspABv3uecZwA52xG9T5WjK8kVC4mfGKUMTxu6GsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:09 +0300
Subject: [PATCH v16 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-1-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6d6d8e-36d6-4ce5-7596-08df284b8ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: GpLvg5InLnHU4TM1Qy+ydljb6Hy0puoxQUjrBwQKmqkgq2hpOYS7dts4g8R/yz3luzxEuTPbFEw6ZYHuX7yZFQHSf5zH3X6hkQt61gcbzUWuOBdEagpx7w/lTzCvJP15+a6oO9P+478w4MRLPa6/4m1BOxhsLejmY4OCMGQvofpSb94C7Yl0cZXTa5Y/z4deDpzC1RKN323w8w82gkEwKz3wBS8IZD3bWLufM8DOsvqwq6TYSePdEYe4LrJEJ65JTdnOCRQsQ8rg4fq6xTKmPllpv41FfOrVgrICMB7xQbAwCe21N0SSfP8svttYXELBV5HEVTs7gGY/LEfrovNtXGUX53+FPHBBJ+2ZUfe9sOR2i4gzFx4IOVR33tDZkQlI8B3iHke8i1wChA/8pcM8KgCmx1BFrCQxY+rxeabWuL2jTUiPVnHc0Hdqolg2qYe98Bw24D/PvnHtMouSZiYvWbcuOydI9FPeP+8pmz6LePjmq2tMXIrZCz9aLRzs5dSL4Wg1hu1mb29QbG7E0YBjTj9Mxun9hOMQxJyBucuidHyHa74i2rqyhhe/k5uIS6G99eLeMcra1zAm0tcbCXZ9rZgEj1c+jbuaBeTCaj4WYsmDRKpL5TNbD2Vwk6ZPotBog90umuJWh33oQH6NWnYn1r8OkJR7qNr5qBfkVFizMX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdmR2gxWVV0ZkZ1SE12U29EV0d6T3ZaNFpENkx1ODBOWWRzNVo2ekl2Zm1l?=
 =?utf-8?B?Y3pDL0htK0dPZDJQd2x4MWpCelJQc0V4SDJzVDQ0bTl3emRrbEc4R0J1eW9R?=
 =?utf-8?B?ZDlFQVNpbFBldEtqcnNCWDVOa1JCc0hOV0pLWXoyUExIMi9WcGpiRFlOcTcr?=
 =?utf-8?B?d2Y0b0tDWElrbS9YenBZaTNESGtzMFBmalhKdEpVVEZDcTBHM1FCckJ2ZFgz?=
 =?utf-8?B?V0QwbExTejEzN1JkbGEyVDhESzE4S291VDFmUWJvUGt6dVBYaFEvUkFCR1Nj?=
 =?utf-8?B?TEgwR252WVRjNk1Ka1dsSjluanFFcTNLZmhReUtLL2RUSlcrK04xcTF6blVj?=
 =?utf-8?B?ckxKN2NoL3UwWkNJYy9LNGkrRjFCU2xkUk5vbzVMZHMvVWRNNEc2TTVReGxQ?=
 =?utf-8?B?NVlDNE9yOFJQWFYvemtndWhlVWJXSDcvUjJsZy9tMjgyTTVwS0JxMllRYkRv?=
 =?utf-8?B?Rms4M3hSY2txc3Z4bDJhNTNOalVuOEwvcFdwMkFwRXI2R1IyYm4wTjB1Y2lS?=
 =?utf-8?B?NUNEc21Gek5vRzNTdjZPdlRVVHZ1Y2J2N2hUaEM4VlBjZU1ZOFMyamhsd2JT?=
 =?utf-8?B?N0tNVmJwclRQcTdhYkd5emIxdzk4N0N2cVBpTVRqcU5SM0x5SVpnMXNGODNu?=
 =?utf-8?B?RTAvSFh3Rmtnd0pQRWQxc2FSZUJuSzB1R0xMZi9GcUhXM3dLcGR2UkRpNEVC?=
 =?utf-8?B?alBoZ202MEttaDMwQVVKVjEvVzdmakh2WVA5NjJGSnRpWVppZmo5YmJ6VXBD?=
 =?utf-8?B?N0pMMzQxbUxyZCtwZEJxWkwwRFNOa2luT3NWbG1vL1Z4L0xJWmJJR3g0YW9w?=
 =?utf-8?B?YzdwTHVxeGZkcG8yWi9TbTc0UTZCZXJMaEF6OXBYbmdEUllQSk1YaVN0MGVQ?=
 =?utf-8?B?WElyT2dCZW1QZW11ODArRktHZzl1aFBDdjhBUjQ1QktPcDFJR2ZUVE10NEhS?=
 =?utf-8?B?c0NSYzEwcmZ2Wm41TGUybm5WMk44OVBwZFJLZTlHQ2lEc0lNYnNHMGU3SjRC?=
 =?utf-8?B?RG1EZ1h4RlhUWGI1NU1DZ3ZST2dpSUJTaEk5YlliNlNOR0E4Zjdoa2hMQnVG?=
 =?utf-8?B?TzB4WUdiVW5UbFgrbkNuclFabUQ5eEdobk0wWjN0a25iOXJiYUs1Y3M5K1RH?=
 =?utf-8?B?NlIyOUpyT0pzQlprVHlLSXdmUys1YUh6cHNtaS9SVkVKd2ZCTFdXaWV5ZFM4?=
 =?utf-8?B?L0JUamZRd29JOVVSWUtlK29ad1JKWGlKbUczQlArOUY5dnNnY3BnUlFBcjNX?=
 =?utf-8?B?REdyc28zZHNtdlRqSDlqL1RVdXRBS2ZyWFVMcVVwcWFpQjlxTzl4V2ZLWGVI?=
 =?utf-8?B?cVhBN053S3l3LzV2dnFvNUtDMFNmYTAxWlRHdFZoMkhsQ1R6WS9QeVJrWldB?=
 =?utf-8?B?TUNMTlNPTzlyZnVicUJhRlprazBONTdFY2RKVXhNRnhwRER0ZG1uZEFkYkJO?=
 =?utf-8?B?STI4dXRqWnZoWlBRZjhjakljQUZpZUFOeC9lV1YxaVJPcXlJUXgxUVhrRFN4?=
 =?utf-8?B?YkllN3haSTlSdFl3N1phcWtmc0Y5WHBRTTljam5IazByc09rdTVwaFQ0R0cy?=
 =?utf-8?B?ZzlyQmJ1VTduaDdVeCtORWR1Y2xhckZvbVg5V0lDSFI4U2h3NmE3eE1ZaU1o?=
 =?utf-8?B?ZDZCWEJRYldVbllOeGdpbUIrbTVWR1N5c3NyUHRVT01SVjA4UjFTMElGOE96?=
 =?utf-8?B?NEtGR1c3cWZ3MFlzN2doNTIxQVFtYVdJUC9Dd2xLVVRrdS9TN3ZFMEtkQWtl?=
 =?utf-8?B?WXZ6eFZ6TWowYjdTcFBEaW1ITHRtY2FzdmFDTkZQN09oa3F0aEdmU3FwZ0t4?=
 =?utf-8?B?Y1BSRFdrZ0FwanlIblF4NmdOSDFMSytBZGlRZTE2M2dhU1UwWVZMbWh1MEVZ?=
 =?utf-8?B?SWlBZ0c0dGRMdGdEOXZkVFNDZFhuZThVenJWYVA2c3kzMC9LSDRLTFhmS0ho?=
 =?utf-8?B?VHBVRlA1MnQ0dFo2QmRNN0lWNzNZYjFCMjJXajNiWnUyM2wwSm5URGxWdk5m?=
 =?utf-8?B?U09veTROT3hkL1U2cHpxak1VUEJnY3RGcWFTQ3UrekJPc1FkeEtwRnAzK3Vi?=
 =?utf-8?B?cTAwTFFTdzVhc0RlakVvNGVaem55ZVEyTkpjWkMyM20yOERtd2Y4K0FRcmJV?=
 =?utf-8?B?MEp1endhOE80WUFWblNXTTRkZXBmM21MODdWcWlncVlZNk0wT24rNmVmZzh2?=
 =?utf-8?B?RmttN3FXVUtJbzA5akJCUlg1ZFhJUld5OGxEVlB0aGE3OVQ5M2IwM09FQ3pu?=
 =?utf-8?B?aGVJd1huL2trUzVwRHBBNk8yTFhlUngveDdaTUtwaXpwNDQ1WnlCeUlpNk5M?=
 =?utf-8?B?NnY2N2NBN1A0OGRQOXUxSDNUL1JxR0lFcUR1aE10azdhaHV3eCtlQWsrSTdQ?=
 =?utf-8?Q?Kp6IhK7yGoEmTzqw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6d6d8e-36d6-4ce5-7596-08df284b8ff8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:31.5407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eJvbgd/mX/iGx106xaz55XmJ6YfFeTBkBcMGcfCaCsuK2u+FOQE0rYEpwE8mCjiW+OoIX6HC5WjNCftJ2ODUg/PnmQRoWmcFyyZgM/IXSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


