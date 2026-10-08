Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A9DCA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJl-0003Cr-9I; Thu, 08 Oct 2026 06:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJi-0003Ci-MQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:39 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJf-0000sa-3z
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q09YbO0hP8i0tLxGNYfCTCJbuxzUb2xiJJKXFN2gQY7KxJoD3r3CD46qeyCaPX32qFWnT3kBQDVZmZ4d1cDZNbWH9zU0u5WZgLHXCUYNWLRjx66AIia8MZOOAUjJKhu8YUXUqjJyRhzZxNUPvoJxDC9LA58wGQ2Kg/0taEVVCUJj9oww5UDRxRY3d+tR9P5BcGX50YzqsfuX5yBtciEjJFlZaEKAGNAggvOqBUpsPfvuhjVyTVFOP/W7KgWMxKhTp1McJyTqx231dVsGb8057/CVGEBdVsN+5Y+mcu04ekJ7H3lsdURix3+/jRqUyGZvoxpcnsmTrCyb6abaJI/G8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=doxPrTZrRKjsXsMLWJepqlmRS5DdO48vOITOssmN0Hb3LksXU9bpNzyAtkqhSV9Vw6gGDG5A8nF5gZlhn+OEoXF//Mu4xhONmNVfzS4P7t+0P4J3wE4rGOYJcx2IZ93WKOhJbWoBcMOKv6oXJBSlNTtugBJo/eK3XtYW3g1uyDoRNEHlK4GUXqRg3cn+VZ16Bdzel5x8xL84D5EYCDE1KXLeh9KBDcldNWWW8AQIBtVu9d3YagMT9r842APSeAG10tsQUg+6VZrp9NXhOS+2JMqGQYlXqlkDKGe/f/9mI6sgoWe6d5we+wA8eDk3Ej0IqBxsLLZKKkhQ8wBJflLSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpeYjDkVXimj7vKcwL0s8nD/Fw3mIrHREQmIZwYVvdc=;
 b=W20HE+YPaVJBugNRHdbdT1EC9et9KcH6odA/C/iNu6tSjWUqk7AsFcdGXvH++pL83pImdN2R5utBOFjY/hRe3ERHXG/yHJgHigrvAu8theZWIpE6+rz3y0NMIIj0QFljtYrCPOUCh1L55GK3Oh2O61L4MCt+uhAqtGE82A9ZgQGJsGeF1r7jYVXyd7Ivt/w46Q65U3N4Pec9IhDaIAOwmX/kOnHC/nf4vHrgeH4UglKu+qtos+Q/DcXfH4egl1YVy0AyAz44SyNOovk0BARTpGjb2DWva0bo5Ta/HTcIkyNeyPWnONoZUAn7sMKm3h2EV5wneahyIo6HwLLRBKJY8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:25 +0300
Subject: [PATCH v15 01/22] migration/cpr: forbid saving duplicate CprFds
 into hash table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-1-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdb6c61-b0a2-4308-bbe9-08df25267ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7kvLQZkfvLbtkGHMHhRYHQgd1dgIsds7dvcFJ/OSXI/SvB2WVv0oOgOlxcOhHYW2BMa1ORMCI+NvU7DwaLo5ipuV/SYjr92NMWIOMi/wMPGIWNTtLxhP4fxof6AkfWXdTjMKYaIsWE5Mo5b9BT+GmXYU118U421Wt2cH4KvCgmXYxuAzpwLS1V2Jgf1UMqQERChQ/dWpYr1cLsc72xiR1Aupo7gxaNnoHrgGEEa54mz3txaHiv3eVPt5O7Xuo8kyXC2Fnsu5h0cUEohxuXVRfTXQGpyksmAMxhQ4JIDZL7WkqaL6St5nPS/CPrMB6ubdaz7xV+ndWfIz4s+adi4qNzBORfyeHwWK4W+idEAbBs2EWonBADe1GJjMEdoXfSbh23nOxa6IVPCDXcbESyKRP2yFJ8SQp0b5e0s/Vk8mh96m6OrBvegjT4dCt/NJ+yzSf+CiSGyT/UA8kWvd1224EFRzSD+pGSCHSSyvFu7R4GPT6/8abAmNI5LtsSdmCNaF3h7BAhwM1Oq2lQvUnizhWP9pxG8OUIzg7/4fLwJTEOiCXmE5rhYZXTLyhGSenJaDjW+lrbU7Vk6k/tkaN/Fjqlsf5xq/qXKch36BS/K0T40mz7Mzb6jAMkdJw3wOX17CcGzYVkFOpgN46gzhzLaiwFGVW51VB7yNnuhyp6ZLe20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VStLRGhEV3FvRmk2N2N6ZmNSY2FSSUxWOUxRbXNvblFQTXhuQ3ZUTVEySUFI?=
 =?utf-8?B?WXdlbFh5d1J5aWxYeG1EcjBnODJpUEU3Vk9NSlNxMEpKTW8vcnBpbkVyRjcz?=
 =?utf-8?B?OGVTNkliakpHR3diQ3l4REY1bDh5RFczQldWcEM1VlRiOVlKTnNXMnFMMjl6?=
 =?utf-8?B?cVB5dnRUY2oyUlB5cVA3TzZHRlJ2akFXbnZ2MGlwQ2xyaHVhYmlHQ2QvK1cv?=
 =?utf-8?B?dU1OcHlqZGZ0bFVEYSs0NytGVmd6NHZDZjh0UnZLcW5LVDFQcnA4RDdpUmdr?=
 =?utf-8?B?STNua0JNUk1HamNvWU5ERktOTklxbXlhTDlVSU9PS0hZbjBNUFczb2hzZUtJ?=
 =?utf-8?B?Q2RzT0VBVndVQWUyMGVoVitWRm1sVUUrbVY4bWdURU1XNzk5NjVIa1ZEaGxk?=
 =?utf-8?B?bXFXL3lMb3h6U0ZwRkxzSVZXbGdValhDSzR0UUh4VEhoMXQyNmN1MEpHSW9k?=
 =?utf-8?B?RWwrS2Y2OVowVDhtYlZpU0wvVEJsdlU4amJ0cU1LQ25iYVB0WHZSSjYvQVBC?=
 =?utf-8?B?Nkl2NVkyMFVZV253ZHJrcE4wR1hGNzRkcGIwU045TTBMaEFDUHZjcFFsSHIw?=
 =?utf-8?B?TGhCd2czeWtoK256bkgzNDFkV1VUZFd6UEVFNFQ0TEIyYnl6MVE4OTV0Y0Zk?=
 =?utf-8?B?eDBiTHpUVHN1cTVXd0ZrL0QrbVZCano2RVRCSTY4dTc5ZVhHN2pqUWVoOVhi?=
 =?utf-8?B?ck5JZ2Jpdmt2MkxrU1VPSjRsamI1ejFiVi85dURLZ3lERllUcXg1VzVBaGVM?=
 =?utf-8?B?ZWROUFpKeU5kRFo5eit5WC9CeGx4VkVJMkRPWTJHSnNJK3JkZEV3VHJDVzFC?=
 =?utf-8?B?eGNmSTlVdnBqWjN4d3M0ZDhmMnNWOHNldXUrdjVkV1JpV1UyYjZVK1o3bXM3?=
 =?utf-8?B?STdzNnVtSENTRERCeXBrdWwwclZDMml3WVNOZ0RTRTk4c3kxMkFmdmwveDRM?=
 =?utf-8?B?VksrWG95RHlwNGtpanl3MCtoN2dHOHZGdnpYeGdReHVqUUdVODJhSE40M0ty?=
 =?utf-8?B?NFZpb0JSaWNTWXlRdjA4bHJvTVRvRkJDMktzRExlZklOOHljbFJIbVlGdnl1?=
 =?utf-8?B?N2ZVd2k1T3lOdkN6eXVYbVFTZm9XKzFqZzVFNndHQysvbTBraHlSWkpMRlly?=
 =?utf-8?B?cUdnd3g5VDZsaEViTkxKWmdzVnFsVVRnT0hlZjdmRXJHL2FXazhiUmJsd1BZ?=
 =?utf-8?B?MGRXZ0tjb09iYWhrdlc1WU5JUVRPMjNjTndxZERzMWhjT25ldG45U0czU21y?=
 =?utf-8?B?NUxWdE1abUxBcG4rMFJzYndPZ1l2QjdReXFqa0ZqaXFkUEgyMlBRZ0R1Q2FI?=
 =?utf-8?B?RlV1NmtRRTdRRFVrcHd2MnBtRndlODcvK2tES0MxRm5SRTlEbms4V2U1U2Ru?=
 =?utf-8?B?bHBwVHUzMTBPS09KY0xpaERJNmpsWnVFVGlqUTEwa2Y3Vk9jekpERmVDb3Mr?=
 =?utf-8?B?ZUxldTl5MlBZZHF2eFdXNkN6MFhnd1dVSjNuZ1RvMzJCS3JwYTNmM256ZE1C?=
 =?utf-8?B?VVdDMzhUbnd0cWJ4Z1haOGVqTUQ2RUx0c2ZpWldDazBWRGtOZUpDMTlNZ2NR?=
 =?utf-8?B?VmtTWFlnTzBvNTlrV1JvemNDUzgrbTRiSWNVM1pBTE5Tbk9TVUhMM2hiZnBU?=
 =?utf-8?B?ZFNFeCtXd2pFazFhYWR5MVVxVzQwYi9YZW1QSnQvOVN2dU9QaCtYNjVrZVZV?=
 =?utf-8?B?R2kwa3Zqb2JLODdIQzFad25oMUVnUm1FUVlTblF0b0FyUDhrVHRITGUzbXFY?=
 =?utf-8?B?Zk9FS0orbGxIV3JpK0pIMG9VNFBDVzNlT0lpTTlKT3RMNFJRNW1HZXgwS09s?=
 =?utf-8?B?RWxuNkxhM1FKdnBOL0pXNkh5N2hJUDV0elBrVWt2M1FLeGkzRUpSZGo2S2xH?=
 =?utf-8?B?ZXJmMEJkWDRLcXRjTDZSUTlMWVE0NmRucVRFeXNDSllCcHlCMDdlTUJuNVRy?=
 =?utf-8?B?YndvaVdZeGkzY282VTl4SHl3ZklPVG50RzNoWGFyV1VzMURkNlRXellRWDlp?=
 =?utf-8?B?Z2ZRMzBKVVZqT0NUSXdGcXJrSGNLMlpHanZ5QnVmdDZMTkNSTTFwdnlqR09R?=
 =?utf-8?B?R0puYktDeGF4WVNFOW5IUGZGaW5udzg3Y0JBQW85eit4WnNrQU9wcythVVNV?=
 =?utf-8?B?a1NYMjBYNXNBcUVFWmEyMUVjMUV3TU9zUWE4QzFXMnVJUjlLbjBvNFJpVXYr?=
 =?utf-8?B?djhXQ0F0cXd2Q0FpcjZYd1VaYUd0cElVd2hjODdCMURULzdZVW5rVDgzY3p5?=
 =?utf-8?B?QkplbjB6eHZtQjlGWDlvQSt4SzdwRWZVL29IbWlSdnhiYmJGWldwaGc3MHFB?=
 =?utf-8?B?dzUrSnNZNVNBcThJaGxJbThsWU9iV04wSVZrRytGNlR6ZlFvOE5NTzg4TkNR?=
 =?utf-8?Q?bR298ZXN6WgbbIqI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdb6c61-b0a2-4308-bbe9-08df25267ab7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:31.0859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWiO6U10anxuoqHJm2UI43DId6whJRncNg4KpSY+PXrgxwEVDauDg5Snd0PPpB9RCrlbp/b8V3dUr/LJwtyrwRqF0bKSRADzNyVp08qqRSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
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


