Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6232CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8V-0005lX-HG; Thu, 01 Oct 2026 04:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC89-0005HX-OI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:05 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC88-0003QQ-5T
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC2g1JGAiUvfjYDfndYduGjoCXJVxY08usTgiTGinCivcs2A4YEz4CL7GKCUfFZZrnW5OrxmiLPqgntx+icjG6VkX22VwMsB8dh/C6hg5DUURpG9tGB4NVpGrX8MaArv4WzMbV4bEm5rqpb/X2PJXA7Vb04stXr9HmewcA9iEob9bGFsy+Q71EpQCllvROkn/Qf8jPm9bdaB07Io7Zqa47kTjvqBmwkshsYE6Onqb9RCrJRSCEFNmGmmcfclOeFtW7y3nc8dMP8vl4sxECOFKd8KtdRDD5DQRSR3Qlm0QhXvU7SVrx0CU7Z/ewpbVtcrnJE33VIq4Yyg6wH65qMFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcuGN9hpYxvaYCpdin9mbHCgP4Avfu9wY6q9yhDjwqM=;
 b=QeUCD//Knu1AK+4NHKqKb/+/ZGuHniSmZb15ALIy3lB9Ohm7PIHbVSPEfhMxNi0NjBtoPUv4YwzEdJ3jeniyDgpPk8HthMJ9tMN+JAjLuySiXPRIhx3pgSBzd6LHqjHnF8EdbWTuWmjJvk3x5I5XQlohPjLqnk7H0isB25b+K48tQj1UtKRTDUe4FQTdvJ9x5wSrLtB9VX8taoXlhGyCilW/pexA+7MrgBR4SeODDIzzig7r4PJwhsyO1z+qUJlfhVucXbQwS9m3mBr/J0H2qrlE5K2dWebWwvSdTMbKSGy71c/O/6tJwL9WH9eGph2MIp3tzZVzl0wdBv9hE5OXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcuGN9hpYxvaYCpdin9mbHCgP4Avfu9wY6q9yhDjwqM=;
 b=OO20qFPmmLbgj7oqf7zSZ6T5lxzQpTNAV6hPEEXLuZkGdCIUhAZH5mVcGHdY5v8gcPaFUqFsz/kuwHSe82xBgWeCbDVYXhi/CCiRodu1AC2NIRrMamxzTX7Y7LsAWgWVG22B99MnnvPZk43X+nDQowuFPWEFeojDDovHEU65oTxktYD52ukynXzOOgqkvcJ1kZhk5JpbssBv93hdl7/65kAVkLcwcfWe41r8zveZFRAYvbbmy8UiOY5wEGI336WAUoVEubZFHu4SRzrwwyO5qDGGSKUaAjSCRceQjzV1tLskNVOPcqBJc647KjaWmUn6R0R2zy0TYkLgWdr2rN74TA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:50 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:15 +0300
Subject: [PATCH v10 15/18] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-15-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: a69ddb3f-b1cc-49e7-ae2d-08df1f95bc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ffHEURSxH1+kOl7XV53JZTaaCmKSEosqZZ5ueo9wLrCVQ7eZZlsZAi4uqEson3rY0LExghLij8MsoVs1qTdjRBnDurCZNUL+PouP3CwILjqeDLZnwSJ2Cdu4+da1Y44e41c3DpY4XiiCo57jCj9sbPerZAlXBqwjCWi73amZoqNCLtmGTgxoV+qIdKMS3Udtz6F0ZtD5tf8Yz0NCoJogAcXoaNCHdB4DUDBbmR8lXXQXcf/BUIR8wDD8cupYrzbkbpjXcTloye58lOuBKLkUCjKa6u1hN0Mp52Eksd/525ySpFjS6e0ZweicF6IlKVrnJKRlhUgwA5RqeFTk/fRX/JWEHvyMEuZDksCQwgGLtAjO936LKMczZbo4An4AmAMaYLfTn/vWNhrmvvj6grQVYPivYzO98iyMS0gvq1cqRFMeq6rxqwtIaOtLkXkHJSlLwrasuPt95uPwjGf1pO0tpak+ReGUm5bYdiX/gO3ZDpfAnieMVcIDde9gh8RyiuShIgEGza9rFRnKjZK7TjiOY0DIdmdKeDwMl6wZzHYswKPMi/h8JZc6MC/VyW9w//sDDVxWWhj5iLMVndI9xrhsmC0rezet2xep87dWT60EwvjSqLmGhpLD9gFVAUlgWMTMoqOWHJ+8wvnsGGGlUBtAErVWEaWz3NXp07CMlGLDeicz2ioCoqqB/S+cs+K3wqfc/f/s95bvFE7Jtuj5nOvZpdmIVuKipO3XTqudBvi7HBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpjTDlrMjM2NlpZcXVkbG8rTE9pM05mVlpQVVdsSEQwa09pNEE4UDk3Umg0?=
 =?utf-8?B?V01GZTBjUEUxNFpFMzk1akphU0ZyazRuZGgyTWcrRDhJZGNXeVc3bHliOWth?=
 =?utf-8?B?SVp0MUJkaXpTMmI1a2RDU0toQTY3ejduSThpODFVYjE2clg0L3d4U2hTUFVx?=
 =?utf-8?B?a2ZLKzJkRkJEc3BIU3oxQTFWK0ozcXExYjZwVDYyWjFNREw2cnhhSGVhbDRI?=
 =?utf-8?B?ODZORms3YWdZQzNvUVgxbW1BN1VsbkdPSWRsM0c2WXlNS1JEVDFMUEM1blRB?=
 =?utf-8?B?ZE81VU4wWDRWc3dyTVBYTk0xRCsvOWdrMjBsc2xTdUszbTFPTGF1dTZTQ3RU?=
 =?utf-8?B?bGdpZXVadDFrdno1dmZWU09wQ3VMRWRvQjBZQkthWG1sMGV4OTJ3amNBa0Zi?=
 =?utf-8?B?eldsOFY5Nyt2ODI3eFdUa081dTREOU1kc1hpVjhRQUlPL21QOXBJTWI1UFky?=
 =?utf-8?B?dHkydzJnZVpzckZkQ0EzWVRvYWV5YXh3bm1KN2hFU0F0ZHZFd0JBL0V0Wis3?=
 =?utf-8?B?MTAyQ3FDY0VOOEZMSkJvbjJmZ0hsMWRRVHlmUERJeFVQYi8wcGpiaEMvSm1M?=
 =?utf-8?B?azUreXRneFVwRm5mOHAralpJdzVLT3JTVnM3dlFJZGVEcFY0d3dhdjNJYVFP?=
 =?utf-8?B?aXY4cC9jSncvTUlRWFdzelNWWkNsbXpiUHpsWUNnT3hGOWVlRDVrRGdMcGsy?=
 =?utf-8?B?Z1J0eHBQM3NNUXFMOXBIZTYzVlh6RE82UkM0a0hvRXo5dVhBUUtFUTE2WkJP?=
 =?utf-8?B?QnBRV0RadWJiOHNkbms2OGpQYlh0UFBmTEp1N0FhTWJPQm0yWnJ3VWtzSmNn?=
 =?utf-8?B?ZnJuNVZoaGdvNnhIR2RaR1k0VGJKbld2cXBGMWJUK2V5M09ObFFuaVI5STFV?=
 =?utf-8?B?NTNUeXZjTGVIQWJUM2RZUE1VSC84Wjc0RUpHdXlaNGV2ODhKZEhWWW1DSDNU?=
 =?utf-8?B?dWpub0pqdXgzYklVbE4wdDVXQnkwZ0tsUUxIYjdzU09CMG9yWWwrV092RjBx?=
 =?utf-8?B?T2pOb1pyc3dXNWlHb1NzZW52SHE2UEREbGRvYklNNnpBV0ZzUStmMFNHVmNJ?=
 =?utf-8?B?a1VvOUQ5Y1E5VnFIbk1FUytJVys2N0tTUUY0ODN1dWVLZHdjdllOWUhoSUJX?=
 =?utf-8?B?Myt1d1NyUExMYzZZZ2UyUUYxQWZGcVlHeHAyR05BUnJucEZZNldrVllwOGF4?=
 =?utf-8?B?aTFnQzhHeEJMdWtBUkVXZ3dpeElRK3pwNFFtclJGaURjMGtEUXNwR0VIWjBG?=
 =?utf-8?B?ZzZRVFBSTEMzNFU3TmlKVE95WkFkZkpXWEtwM0pmT0VDTVZLNmllNE90bXh5?=
 =?utf-8?B?bnFvczhHUkJiUDBhZnd6MzdpSGtkMlZvRFR2aHF1UnlkUmM0MUQrQUtZbk4x?=
 =?utf-8?B?anFwVjdjWXRnRjBUUE1pRjRyYVI0c1hRRi9wWlYzRmg2T1F6cjB4VDFmYWxN?=
 =?utf-8?B?d1hNQk1OVXhEMjdTemgwRkJ2YjhFQ3VHSVBucHFsdWNhS2hnUVhlclRoMWlz?=
 =?utf-8?B?d1FCVVJTWldUblIrWW0vYkJTOGx2b2ZGcGIzVFo0YUFFeUo2RkxRdWhHOVBt?=
 =?utf-8?B?eDUreFQzTUV0eEJtMXdBSkg3TTN2Q1hLUTYrLzFlbkZuTTIyY1FEN0Q3bGta?=
 =?utf-8?B?bXlwMllsK3pOVk00RHNVSnF0N3c3Z0c1ZTZTdDVBeGpvTU1GUDNSYW5iSjZS?=
 =?utf-8?B?QmVib3FKNW10NWtWc1VmM0h1WkxSTVk2dG4zZGFuUWtMblVLTG5zMERFakp5?=
 =?utf-8?B?L213SERuTDBNS2tjd09QeFlNczFhdlYzQWJtOUdKQ3A4dmlzOXFpY3FGMTRw?=
 =?utf-8?B?N3NsODJNLzIrcitQNGhGVWY1dFlJakJldGtjNXBUWjduYjBneHdiR1BBN3Rv?=
 =?utf-8?B?M1ErKzNtbXhCWGlzQzkwRERlTnBXcUFBL1BQK0xvYVA5czlVcnlhOXE2Tk96?=
 =?utf-8?B?NnNFd0JNc2lQa1RtS0JYVHZ6elV6LzNhU1ZsTFhPbFlaQThOcGV6MW9XSHBt?=
 =?utf-8?B?YjZnUFBiN3d6aURET1Q0eEZyUldsK3VQZFd5WlhvNG9YQWpaVWVnTWR2SkhT?=
 =?utf-8?B?UEJYNXlCa3IxSHM5RFpwQ1gwR1ZWTkUzd0VXNlcxd24yYjd2czRUZVhqamVw?=
 =?utf-8?B?aDBTYVVUdmNVVC9UZXloNnA2Z0hJTEJTdXZ5cks5MTdkYUh5WTFHUGRiOUJB?=
 =?utf-8?B?NTFVYnFGSnhyZmZ4QUptbUJNQWw5QUtrKzM1aFFVdCtLYy9yWExKNUhmbWlB?=
 =?utf-8?B?QzdSL1dJenREeFkyazBXYWx5MmlFaVowd0VlbFdWM2w5R3JUZWVTQXdvOEFQ?=
 =?utf-8?B?UEY4MHFyRGFvRitpM2NEMlM5S0E4aSs4NGQydkhLa3BENWNlVWlVRkFra0h5?=
 =?utf-8?Q?cS8LJaIkyIMQt7Xc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ddb3f-b1cc-49e7-ae2d-08df1f95bc38
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:47.9365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwrNtECS8n/X3ZFhbHlwqsDjpaOxLLky7FU57GEgCEwswdDcxeMMbYt+GyXp9lvUAn/6aXVwCn2dN3PhyNSNE23o2YZXZX81NBaNtV4mJVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Issue VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown
for all those paths.  That's safe in any case: the kernel refuses it
from a non-owner, and an owner is about to close the FD anyway.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..0bc6a0b6b00 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1864,6 +1864,13 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Issue RESET_OWNER to drop device ownership.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         * Should be a no-op for non-owner, and harmless for an owner who's
+         * about to close the device backend.
+         */
+        vhost_dev_reset_owner(hdev);
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);

-- 
2.47.1


