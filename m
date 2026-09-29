Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AA5CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYe-00064u-0W; Tue, 29 Sep 2026 13:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYc-00064f-Q6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:58 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYa-0002l8-T1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTAoJI+MRY6eV9QLlTjQTGy5Wsu/4/yfbG4J1PUuNM1LmehlQ6AzUpBY6I7WdbiLP1JC21d54uJdVtDLJBo1LZPok8q+Q89tTfTNLpb3YfagfWtrSb3zrHg/C9BF9mCyXR0seBzpnT418rUno9wjVzFsUdC2OMa7ryej07SoVFlrrsVbYX1rH0ttUI4MFsaXaEhWHmpED01+WsrxXjgKrbs+M2fls3FiZsfGp3mwvdXWqYZGXkt8Dslzy7fkzitCYwmbSaiyHxzb7aXEVLpE6OAtLCuuAYHmSM/toQ4HqxfpMr1qL6ybuPv6ewfwAYzZgtWprzrArL/XK0OFv/bycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFSd27xVV0k0v9KaN75BAdsGcmvLs49vbx1y9WYj55A=;
 b=sjOWWuDn5SCX+NeZDVbGTl320uRLG9dubbYgHHje0GcApOqQebfmk1DBzAXYn4Dpx3CaxQk/ya9XRv2bzzMX1vWkz6FTemuUFg43zPfTBi+TsyVZfOTIDxx/c0pAfXA7nH1xmnQMTttt5YdMp1si8YwJQiT6rr4lLgBz/Hfbv2f+xL7c2HKxzr76Hv5dmAZ1yKB7gws9wLWdosOOFdHGea47ikEJLTWoCmQRdrSqaAm+kIf/awyT8zk/rj0H93+woL11rlRSOEncoSRaO7O70NynaUZIehUZ0UpDY4Bm2UML9rfSZoM0wkKsxV6lx+wG22p17KQI9qdWvoP2arFxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFSd27xVV0k0v9KaN75BAdsGcmvLs49vbx1y9WYj55A=;
 b=JGaBKVcuBq6eJX188M+1yoH8cukgkiEX8DJk+b9Yg4Q4tNNbVkyBvRXahaYXZVXoEnuCOo2rXlO9bzwkN5jpT883SD7dmlDnsr3QVzZBD/B+CBMmFxW6yF52G8lyprOsQpvLNgH1xVQ7MIYyJ6gAv5JwFfDuoUauFhKaPn2I0qs6psJp5wskosZ34rJQ1xRENSU+GaG9BmLGwKRrcCW0udhodeslxxdgPp1gSK8o6hWgv66UjZryZTSoP/u8iJnB53vx+KiM6AAahaUC87nvAtMGZQci+xbH+kGK1qOsiI58fLPGjcRLp8tDiPTvRDgs3wOg09LRBuRg9F/Zp6cftQ==
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
 17:23:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v8 00/17] migration/cpr: support vhost-vsock devices
Date: Tue, 29 Sep 2026 20:23:19 +0300
Message-Id: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAf0u2oC/23Pyw6CMBAF0F8hXVvT0gfFlf9hXEAfUo2UtNAoh
 H+3oAtiSGZzkztnMhMI2lsdwCmbgNfRBuvaFMQhA7Kp2puGVqUMcpRzVCIBhw7G4OQDxsaFHkY
 GZSFwTUqDJa5A2uu8Nva1mpfrN4ehvmvZL9DSaGzonX+vRyNbej8f0x0/DYIKFzQnTJSGinO0v
 h/cOLqjdE+w3Ih8q7A9hSeFKoLrXEleGbWnFFtl79dYJIVrU2qDCJGE/SvzPH8AZPpJSFQBAAA
 =
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
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
X-MS-Office365-Filtering-Correlation-Id: e1a7035d-ce1d-4914-0ef6-08df1e4e6abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|10067099003|56012099006|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: Hm3fbsbO0fa9C4Jz20KCdsNNE5/97fZH39f5NFuki5UIdb2VlTvcXsM6iZxCIhJhl+N7P5hU2agRB+Q8Z0U7x8lmln76bjnb9Inmog2JgALGu7dEb4cUootrZ274ROJTzWOi836abHOEllZCiPJhQJWe3LsUijcLXZRKHcGUhPqyFY94E1bMDI8ZH/RZ9+1c4+D87cO9EGEZO/ANwJFp2oI6HbSzLgIXYEhYN1yNePIQZv1D8sGvw7g7ODP2+nvvx8t5hUut0HhGb6Tf7Y8F1jo0wPT44UZdjN4D2LjfAYz5xHhgCQIMWJPuAPN/0AODa7GFoNkRhIUDblyW1y1OgWlFY8EbVQQFXwYtSeIftuxJrmRFXblluTl9Znz5fb0zCmG2X+TULZ/mQYKPHGT0t/se57j5jSWhoX4+JuuNVEGAzE9MuPnjPVxhcpYm7E1Mr11IsHs8SU7/g7KNQg9jHGm+nIlgTmFCJ6syXg/c1mMrFz+DzCJE4VqvNd5AWmqC9aB43i/FLlUekXn4d69x/4+RZKumSvZe/Wug8e1i+5SLwgbz6+l2RIP+Ww8v2vfV/iDEioHKNb8AB8J/zNzMaA6i9ugxBd4EmvrjYmUi4M3x3b7DwdR8JPvDGlBaiVEgUkna/l1wSdmy8Ic8nu8EhaONR3HknbP8yQ+JdsgOrHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(38350700014)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVRsazBXYXdNZjZvVmtHZlIwYkNKeUw2dzFEQk5wM0VjUDdMUVQ0SUlSWEtw?=
 =?utf-8?B?MXZTekxtZGQrRlVTdlRyZ2RlR05RQnV0VGsrQXNDU1hya1BGblZmeE1mdElU?=
 =?utf-8?B?dVFJeGdLVXF0bUNwekZxWVhtNWZIcGNFUG95N2YweUhQQzgwd3RrYjF5K1J3?=
 =?utf-8?B?Tlh3aFRsRnQvN0c2WVNvT1F2UnVnOG1ra2haU05oR0JialUyS0ZnKzlhbGhh?=
 =?utf-8?B?azF3R1BBYy84Tk9UZHBuVDlVV3Q1d2NLUFUxQk43c1U0YkRHMDNhSGdBaStQ?=
 =?utf-8?B?bm9sL3ltenVQZEFUU0VaV1pGcmlKWFZ2bFNhdWkrYVNmQnl1RHpJOU1rZExv?=
 =?utf-8?B?SU1QWWd2QmdZQWtObXQzeExhNndXNlQ3SXRVRitVekpwcjBlWDNhb1FYeFRy?=
 =?utf-8?B?Ym1tZFpqNSs1T2hXSm5IUzJ3SURwV3F0N2pJMmozbkF5SDFOc29IRzlLaU5x?=
 =?utf-8?B?TzQxRjJIZ1h0akNvTldTNGNIWEVuWFpUUXp5dkhQcGUxUlVGdkZzSGRVajBN?=
 =?utf-8?B?OFp3M09HaGpmZTRuMHlvOUZzMWlMb3FuNWVHemdhZmRtUkc5Z3dqaXZIaDBI?=
 =?utf-8?B?SmpsdDR3S24rZTFnWDZGZjZNbVJnZlNPMjRYQVVIZUViRTRwVTR2VmdoZ081?=
 =?utf-8?B?dlZSVGhrc1VXdGN3RG9JWHpDUFAzKzJ5R2V5bS9nc3lBbml2QzBKdEVKL0xM?=
 =?utf-8?B?Q1NJekVnOGhYVXRnZEJhZ254bDRPZGlPVVhYVDZPemtRQkhqNFF4OTQ0Z21p?=
 =?utf-8?B?R0I3K1ZFdlVvYmVtNDd3Y1FrQ25sNHhqNjE5VlVkQVErOW1pR1JrTzVIR3NY?=
 =?utf-8?B?UFUxbElEVjJmM1ZsSXRvSDFwUXA3NWxqcFZ4S3BWL3lOTjBpZEZZK3h4amtK?=
 =?utf-8?B?R3VKdEVmMldKb1phR0t1QnBMWnNHS0E5c3pLOU5vUFZzbU56bHpTa0grWkRD?=
 =?utf-8?B?S1loRGthcXVndDVVL0hqSUNaTWs4ODFPTnVmUEpYa3padDk3ejFmVTNERW1r?=
 =?utf-8?B?cmpzWmlRc0wvZXlZem4rcHFXQ0JRT1RsakRxcFpBZ0Y1ZVFQZXFpSEU5dEdZ?=
 =?utf-8?B?a1pxd3BLd1l6TVJ3WCtvVnBtMmpaTVdSanNXTUl4ZnlnQUVIdm1pN3g3dHkx?=
 =?utf-8?B?VzVodzFlVXVYMXBPV0RMTjNjWjdGK0ZEOWVLN0t3dmdFTkhsdWphMGRSZk0z?=
 =?utf-8?B?VDVYYVIrVFp6OU54YmphanJ6UmE3eFlubkZXZFEyaHJHalhSNGJSbVp1aUkw?=
 =?utf-8?B?ZWRPcFF6MkFxeWZNbjdIK242WmRJZzB2Ny9NMTdUWklmSFl4NENpZTFrM1Vo?=
 =?utf-8?B?dnBCTlR5MTNDcnlzL2tmY3pkRVNFUzc1dzNOcHczNzdYTWdUMWR3cFgrRS9U?=
 =?utf-8?B?TTIzUWVpRlZCQi93QzQzNFNOVG5VWHVjaWREMHFWSnhwRS80Z0ZTdkhKaXZp?=
 =?utf-8?B?b3pwVDN5eXJNWGREZGJWbHNBSGZrU2ROblB1ZkMvZ2tHaTBuTmduVTFKWENi?=
 =?utf-8?B?ZU1mSU1yQm02SVlOZVh1VzVSRE5OU0F4K2NvWGYvZ2dqKzZCK3RNa3NJM0o0?=
 =?utf-8?B?VFQ2S3BqN1RVdi9OTGVKc0lVb0VvQVVFSmVxRnRPMHFxNkl0UndFU01Sdm1N?=
 =?utf-8?B?ZUtmdzBBdHBPT0w4VXQxNWpCd1VyV3kvdHFtbEs5TFFvdWRYejNvNHlnTVhU?=
 =?utf-8?B?SllwdUQwYWxvWjloTXROeFlYd2NOd0dXVThOYTRBdFlmeGdQdzlkMllVRXFG?=
 =?utf-8?B?cjlGZCtyb1QyMUtXUmFzM0FYWU40Y2dwNGc2ekswMHBaU0ZybVhtenQ1Ymx2?=
 =?utf-8?B?eTVIZmF3cEJWcnNTTnZQOHdOeHJMRXdCcnRHb0hOOWJtQ1RsM3JPK0NyUldk?=
 =?utf-8?B?Zk91VERSbDE4ajMydEZsSHNMUndVS0MrZytEamNwVFdHQm0rODN3SUgvTUd4?=
 =?utf-8?B?OVhLNjNUV2hvV3NzZ3lZdzJzOXNsTE9wMWVwOTlPVTVKOU5nN1pOSmxvNEEw?=
 =?utf-8?B?aHJQbHA1d0lpb1puYkRZb3VReng4OThIVHRycG00TEFXUUhiK3llUXFMaWRR?=
 =?utf-8?B?akxnbUlyVG50RWhrQ25KcitDdUlMRnZnTC9vQXo5WHMxMEthcTZ6VGhLRFpF?=
 =?utf-8?B?VWVDK3U2S2o5TloxU1RYb2twcXF5Yld4c0RyeTIxVEZBeDhWVXMxdUlrWVBY?=
 =?utf-8?B?Rnk3aG9PK1RGSEErR0NRTUJ6MSt3eUIvQ2syWVhzdEVPZHdHS0xkNFlJNTFJ?=
 =?utf-8?B?NytVbi9PSGdlNThHMHcrVkVTem5NT3dDbk1MME9JaUMra2FZR1dheHhnZXlL?=
 =?utf-8?B?M1Fqb2FrSE9XUWZyZXBWdDRFMDU4VDNVQjUxRm51WUVHeXkzYlIrNzZmVHBW?=
 =?utf-8?Q?+9hydS+PQOj0SqWk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7035d-ce1d-4914-0ef6-08df1e4e6abb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:45.8141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1rhXARffQrE2LVeJ0IIQ4TLUus7E9mPa3t4y3F46PPkNqZr5vXO2C7l/hCC3ex/TUjifSwFA+dR8mODBQX1Qv+nxxX7r0/Mz49dc4wF2EU=
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

v7 -> v8:

  * Patch 1:
    - move the error handling into vfio_cpr_group_get_device_fd() so that
      it always sets errp on failure;
    - reword the comment in cpr_fd_hash_insert();
    - make cpr_resave_fd() check for a missing entry instead of fd < 0;
    - drop Cédric's R-b because of the rework.

  * Patch 4 (NEW):
    - forbid snapshots under Xen.

  * Patch 4->5:
    - move the snapshot rejection test into the --full set.

v7: https://lore.kernel.org/qemu-devel/20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (17):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 ++-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 +++++++++++++++++--
 hw/virtio/vhost.c                               |  57 ++++--
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  61 ++++++
 include/migration/cpr.h                         |   2 +-
 migration/cpr.c                                 |  64 ++++---
 migration/options.c                             |  13 ++
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 129 ++++++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 ++++++++++
 23 files changed, 866 insertions(+), 81 deletions(-)
---
base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


