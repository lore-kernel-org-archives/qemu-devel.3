Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9B8CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwj-0002qU-Cs; Fri, 02 Oct 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuX-0000vy-Sc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:52 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuV-0007Rf-Ft
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2TCKFg2U7nVHfh3Nf39p4QkQvyt1O2Yfg/wzKnbNC38yPvijUyVSoPmMjehi6GA1qIzYL0XjoSQ+IG4/H6ySPtchejyoh5NUfnSamxDoFJFW0XRDgOd1hAQ4Qku11yaOSGWIG4EAAbxmAOEVufeYGVpZ5//P5LzscGWvKYxIaE+PSqBZvV9WD8D1fX8bJMrurX0Q9ijwJW7+Wbv6IsLml7sDd/XSQmGwwAJifsDc6g9iAc3hwPpQknyq6qEYGXFqM94g4b4etLdewpjNx825JEgWSkJFhg0Htae5Om40vdU63BI+vdUDAHD8iZHXoh9Gdn38bjybE8K567SWQ2zOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=EjvYb5VkcA3FwFD0qo9/Zx6t2V/T5rNbh87FfgCOPS35R4jTwXwesSBEVvk04uVksamheZOY/yz+tj+5en2D/3K3qn/t2htfQL4s4X80egqvjh2PRX7vk2nWizuqFTS+E8TrwUkQx3VUrdN9yoTWuhUzKStGr/Y9tqTMvBgQ4aAz4W/+duNmQYruuDB3iweRhry2KnmBlXJaa5yWoG0zIEpG2pxgXibmKQntBf9V3PrRUIXC7M7JfQDdmNK9XQh7v1QvHSwmA2DqclNgxjbF978WCMkMlnclWyyv5zjk857y3q64yR4Yqw3wev0ySFi0inCSsa95et9lxKWIA+zM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=t1p0101H1Kf5v/OoMRUu8gNGbbD8KNfUxHKCsktuRF4G0ebLOha9PJzI1h8vV2G3fgxq/WXoAH+zoPgAe6CuLSrwsow5hhEy55VuL+dgWwsxXkUA3QGggkXDtMTdNyqXbRGUWD3Tzn/EPto5H/GCvNtOeHRZPWYBNtokAIGWrH/l/5N0vBcDOaoZYr3BU79libsjQ0TmAlwxB4msvh4lYJMc9mqt4nC4gt4UnwNwa9kai3wf/Kf004vf9jVMOliCGuOEh1xQKz1MLa5NMRQYVhDV2wwV7cxW1jZO4hGOmDHmf7xCDKIoYTvBCmO8ioFS2SkDBKXSjgkV9hEEp4Y37g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMCPR08MB11995.eurprd08.prod.outlook.com
 (2603:10a6:20b:76f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 13:02:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:28 +0300
Subject: [PATCH v11 19/19] tests/functional: add vhost-vsock CPR test with
 a live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-19-18fa09d8273d@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMCPR08MB11995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4717ae-3b35-40d5-7ba9-08df20856ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|38350700014|3023799007|260925021311599003|10067099003|260925022911599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info: VFnFiIMUR/BJa0jG3BPUREaCHMtuxMxZzL03MOVgvZ0mL6acs0FadMZjuTewslNVR8S653EilaXiYjkTtsHWvEWVOKKjkMHyJCZXbB3OdtBgUp0Qw8fA6F+c5DBfCQDoOof2Oq2K/2CAtC41Pxq+Ip4LjUt5J1OS3yIqAN34GAIzWRSacBafC98d/IbBesYe3k6vs9njMQmpS9CksnW2OhDjrj5gq5MWsApSk7mnDP9c+3XizCuZ9rVceIJRwBzEewmPDxlZtdhit/E1OXsVcEnDe300KPxBxHXVwBP8UJ9VyJJcC5ibzyeJpL7lNY+HlQ0tELAejTg61Mt2AsZlWbvneHtqboD7BWppoMFWSjeoGmlAWnavendZdupOGaGwWaQuVglqmFJC6uDHclFwJQd6A/jN1531mqtMpQ8DPwcxURkloFJ+hJGOo+fIwEOh2WPI3sWiYY5pwd95v6aTyJyREUytNalBKVBCr6AFQyiOTC/0vslcuYXRxTElfKF3Ymw7eF0ln+ndGRz0mmLYMNtJdjvGAVD/51iBC3vrY03DgVgZHwED2yzFXnAk0a3tCtoO1zhufDLvEy+VwO0hoT53HdGK4mRTrAB5EH01gjxU62Pi1o+CRoRJlIR6ybpTqR6EU9qy9t3xIy2FUfWfWL0sPS0ohrQMc9RfIc1n5aiAixMV/iTpt6mlH2KrcG4dFiJCgXo88TJ8w9fEzbFWCa43tEky9WZcsMKCoKlZQyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(38350700014)(3023799007)(260925021311599003)(10067099003)(260925022911599003)(260925021911599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzMzNFgyWVNKK0NaVlFFb2QrNkZEeUpUcEpGWkFLRmlMY09nNGFQRkZIZHFs?=
 =?utf-8?B?VFh4R0k5YUlBT09yNzRiT1RrdWVDL3V5c2xkRjdub292N3IxcWxudDh2WnpX?=
 =?utf-8?B?MGYrK1QwTzV2UlFxVVhQWTFURmdaOU5kWmtzWm1BaC85MVcxZjZYclNETURv?=
 =?utf-8?B?ZWZmdHVWZTlUVU9XNzdDbEp5Y3JIb3oxSExNS3NBOEE5WDhVdlo0T2JnckUx?=
 =?utf-8?B?TjNITUQ5Y3BJUlg3NFE1Z29lZHMzQ0xwTDdpUnQ0Q3JTRlJ6Tks5SUk5cnJl?=
 =?utf-8?B?Mzd1VjFlM0cwelorclNuaGJwUUVjZUZvT2FjOXlKTy9lTzZtNkorNXdlMGdk?=
 =?utf-8?B?K2FCTzFhTmtEVFVzcVVDSEQ1T1hGdzBwMDdHRjRQWlhmVVNodmFjd2Y1cHNh?=
 =?utf-8?B?ampkTkR2dm4yWnhjZXcxbEhPVmQ0WlRsY0pUK2ZVVDduUmJad3BPVE5UTXBj?=
 =?utf-8?B?QjAxa25tb3dyWGFOZEs1dnJvbHlrajNYVzB6TVFiT3IvdHpQSVBKMEhBSVVW?=
 =?utf-8?B?QS9TWlJydGVMV1d1WXpiTEFYWkc4ZFE3K0poTTdaQVQ1S3J6alJYV21YUzRK?=
 =?utf-8?B?WU91SEEvbW1sUkgxcEU0MlBWNWlZUExFMkJNRnFaR0QwUmlzU1U0ZENqV3J6?=
 =?utf-8?B?UHFMOU8wa21UTU12U0o5SUtJWjA3V0k2bDRYY285MERMYlBtTzlXbDdSUWZi?=
 =?utf-8?B?NUZNLzU2VCtVUXRhUXRzVnByYlFPYjRjdjU1djVnM20venRmSC92Wml3T0J4?=
 =?utf-8?B?R1NmaW9zTjdJMHZrWWZkUGtFVVEySUNTa1NsZUEvbW8wa2tGb2V0ZU1kUXZo?=
 =?utf-8?B?NFhzN0ZjMkRxL05xTkVaRXZYMHR5OG1vYk01cnk3UExJWUNUdk9GMXRSTG1h?=
 =?utf-8?B?VDJFWjRNNVdjTkdtRnBNSFYxZkNJOThIVlhUZ3VNZUZRQ05xRWZYYWREMklR?=
 =?utf-8?B?anBGdk9FN0tSZmhlN29PN0tZazNhL3RTak1BMllRMkNDRjhVZWNJcThjNkR5?=
 =?utf-8?B?L2RGb2NUM29sTnZZVVdablZhNFlVR2prNFZSeExwRWV4RS9oZ3JKSnpQSFl0?=
 =?utf-8?B?citXUEhlZ0dxVXUxSDlNem4vTitCaGpDQTZzWm4vRDBobmxpcElsUThzQVM4?=
 =?utf-8?B?Z3VWR1JSV0wwUFAwaXNaUXRHU3kwSTBxRy9ZMXh3ekw3d2VRbytzU0RablZ2?=
 =?utf-8?B?cStVL3FETGsxNG9WVUZYWXpiKzR5N252SEZvYm1zNjBxbklFQkMwRmU0SENN?=
 =?utf-8?B?aUxBRjRYS3RVTDlvRXdOUUNGc1I0Qzl0OWtnU1h5eWNTdWViTC9PSVdoeFV1?=
 =?utf-8?B?UE9teDJzd2wxSGpUdjFkNWNBSDA1eDZJL3hZYUY5V1hBYVJkWEZhSnN5UnVJ?=
 =?utf-8?B?Y3NuK295MEdSS3ZGK3FkbEJxU3VDN0RUL2NCT3NQeEVPa2tvWEcrVTZlcndj?=
 =?utf-8?B?aXNOQkRnLzU2UFpLQzAyeENQM2N4MlpjVmE0QjROZkx4dVBGMTRTSGpkcjhR?=
 =?utf-8?B?UzlWaFZxMzkxMk5UbWNFbnRwOWJrQlRNS1h6cy84Y0F6MHh3bURoNkFmSDdN?=
 =?utf-8?B?c0NyRkZNQzhUNnJKcksrN0dsNjk0VXVpNnBDVlE0c2NDaUk0dTFzb2lGTTBO?=
 =?utf-8?B?SFFEc2V1YTZ3Nm5OWWJlSm8weDVSdkd3bEJFc20zNnVlanpUN1QzSC9NdzlP?=
 =?utf-8?B?STR0RW9LdTlCdUVhcDV0dlQ4LzlYY3BxUXdSbFNDTnRXWFhiSEFrVW92WnZB?=
 =?utf-8?B?dkxlcnA2RWdNdHVnU0x3Q05Sb1JYUG55OFREY0dkNHRBWnJ4aktMZWErTFkz?=
 =?utf-8?B?L1FNTHdlWUpTRU1rak1VZTMyVzhGc2Y0Rmt0RUIrcWFINlU2aGVSUkhFLyti?=
 =?utf-8?B?Qnkzd2pZOFFmaXhFRXNMQ0FrVk1LRVNwMEVNckw3RUx2MWd2RE40TVIyczB1?=
 =?utf-8?B?Mnk3RjUxcmFxTzM1b2tJSEVaRmZ5a0NxYms1L0dhdEY0bnJQMmhKM21wTnBy?=
 =?utf-8?B?V1ErSzQyamQzb3lwa0g0d091N2ljWUx1ZkRibkhjUCtFN0tBZU1BR2lZajZQ?=
 =?utf-8?B?Mjg3QWZpR090VVl0a3pQMGdoS1BoRlFBWCtZc2RjRlc2aFlMZnZPV0toYis1?=
 =?utf-8?B?eE0rSHVmcGF0MU5RMnRGUlpNTlk3bzd2VFI2SFFSUkZEMTAySXpuV1A0bk5v?=
 =?utf-8?B?U3VCdmRUa2NNN1FGbDVtcEt0VlUwdkVVYkw2UDVNL3NGVlBRcTlEYVJ6cHBD?=
 =?utf-8?B?dVFBU2xFc0pHTmE1ejBKanRBMFpJM1h6QWZOcUcvWkRzblZaMC85OGpzaHlX?=
 =?utf-8?B?aEJsTm9kL0cweHFWRlBEOXZ0a1JjM1lNOFBMa3lvaVZIK2hVb0VoR1RTRy9M?=
 =?utf-8?Q?SDXibp8YM6Gmy4YQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4717ae-3b35-40d5-7ba9-08df20856ceb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:34.2117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKbtN6NWzEdwC02ukTKoE+lKc8BiDpYlq6cYYwql+wmdPBdUaVXatrRMqgsAxm65/MiBKybYQ8JCtIByf31ydxGoKkiwSOnoIvST9zlR2X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB11995
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

The qtests only cover the QEMU side of the vhost-vsock handoff.  Add a
functional test which runs an actual host<->guest vsock transfer across
a series of CPR migrations, for both cpr-transfer and cpr-exec:

  - the guest is booted on top of a qcow2 overlay shared by all the QEMU
    instances it goes through;

  - the host sends a 512M file of random data to the guest with socat,
    where it's stored on disk, then gets it back the same way; a CPR
    migration is performed every 0.2s while a transfer is in progress;

  - with cpr-transfer each migration starts a fresh target QEMU and
    retires the source; with cpr-exec the same process is re-exec'ed
    over and over;

  - the file received back must be identical to the one sent, and both
    socat instances in the guest must exit cleanly.

The test needs KVM, socat and /dev/vhost-vsock on the host, and a kernel
supporting VHOST_RESET_OWNER for vhost-vsock.  If any of those
requirements are missing the test is skipped.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..718bdc5195c 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -7,6 +7,7 @@ test_x86_64_timeouts = {
   'netdev_ethtool' : 180,
   'replay' : 480,
   'virtio_balloon': 120,
+  'vhost_vsock_cpr': 300,
 }
 
 tests_x86_64_system_quick = [
@@ -51,4 +52,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'vhost_vsock_cpr',
 ]
diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
new file mode 100755
index 00000000000..035307fc82f
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+#
+# Functional test for vhost-vsock over CPR (cpr-transfer and cpr-exec):
+# a host<->guest vsock transfer must survive repeated CPR migrations, in
+# either direction.
+#
+# Copyright (c) 2026 Virtuozzo International GmbH.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import fcntl
+import filecmp
+import os
+import subprocess
+import time
+
+from qemu.qmp import ConnectError, ExecInterruptedError
+from qemu.qmp.legacy import QEMUMonitorProtocol
+from qemu_test import (Asset, LinuxKernelTest, exec_command,
+                       exec_command_and_wait_for_pattern, get_qemu_img,
+                       skipIfMissingCommands)
+
+GUEST_CID = 4000000010    # we expect this CID to be free on the host
+VSOCK_PORT = 5000
+
+TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CPR_INTERVAL = 0.2                   # interval between CPR ops
+
+VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
+VHOST_RESET_OWNER = 0xAF02    # _IO(VHOST_VIRTIO, 0x02)
+
+# What a QMP connection raises when its QEMU goes away underneath it
+QMP_GONE = (OSError, EOFError, ConnectError, ExecInterruptedError)
+
+
+@skipIfMissingCommands('socat')
+class VhostVsockCPR(LinuxKernelTest):
+    # This should have passwordless root login, vsock support + socat
+    ASSET_DISKIMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-nocloud-amd64-20231210-1590.qcow2'),
+        'b94e3f34db59988a815b33dffc24f5a58502540efece2cc1ed15e0ac8749bb2e')
+
+    def require_vhost_vsock_cpr(self):
+        try:
+            fd = os.open('/dev/vhost-vsock', os.O_RDWR)
+        except OSError:
+            self.skipTest('/dev/vhost-vsock is not available')
+        try:
+            for name, request in (('VHOST_SET_OWNER', VHOST_SET_OWNER),
+                                  ('VHOST_RESET_OWNER', VHOST_RESET_OWNER)):
+                try:
+                    fcntl.ioctl(fd, request)
+                except OSError:
+                    self.skipTest(f'{name} is not supported for vhost-vsock')
+        finally:
+            os.close(fd)
+
+    def setUp(self):
+        super().setUp()
+        self.require_accelerator('kvm')
+        self.require_device('vhost-vsock-pci')
+        self.require_vhost_vsock_cpr()
+        self.set_machine('q35')
+
+        # Use Debian cloud image as a backing.  During host<->guest
+        # transfer the guest will write data to its disk, so we start
+        # it with an overlay
+        self.disk = self.scratch_file('disk.qcow2')
+        subprocess.check_call([get_qemu_img(self), 'create', '-q', '-f',
+                               'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
+                               '-F', 'qcow2', self.disk])
+
+        self.payload = self.scratch_file('payload')
+        with open(self.payload, 'wb') as f:
+            for _ in range(TRANSFER_SIZE >> 20):
+                f.write(os.urandom(1 << 20))
+
+        self.sock_dir = self.socket_dir().name
+        self.cpr_count = 0
+
+        self.guest = None
+        self.qmp_path = None
+
+    def prepare_vm(self, vm, name, *extra_args):
+        # We don't want QEMUMachine.launch() set up QMP for us.  In this
+        # case launch() waits for greeting - which won't be sent cause
+        # CPR target is reading CPR migration channel before QMP
+        qmp_path = os.path.join(self.sock_dir, f'{name}-qmp.sock')
+        vm.set_qmp_monitor(False)
+        vm.set_console()
+        vm.add_args('-accel', 'kvm', '-m', '1G',
+                    '-object', 'memory-backend-memfd,id=ram,share=on,size=1G',
+                    '-machine', 'memory-backend=ram,aux-ram-share=on',
+                    '-drive', f'file={self.disk},if=none,id=disk,format=qcow2',
+                    '-device', 'virtio-blk-pci,drive=disk',
+                    '-device', f'vhost-vsock-pci,guest-cid={GUEST_CID}',
+                    '-qmp', f'unix:{qmp_path},server=on,wait=off',
+                    *extra_args)
+        return qmp_path
+
+    def wait_for(self, what, cond, timeout=60):
+        """Poll cond() until it returns something true, and return that"""
+        deadline = time.monotonic() + timeout
+        while True:
+            value = cond()
+            if value:
+                return value
+            self.assertLess(time.monotonic(), deadline,
+                            f'timed out waiting for {what}')
+            time.sleep(0.2)
+
+    def qmp_connect(self, qmp_path):
+        """Connect to a QEMU which may still be starting up"""
+        def attempt():
+            try:
+                qmp = QEMUMonitorProtocol(qmp_path)
+                qmp.connect()
+                return qmp
+            except (OSError, ConnectError):
+                return None
+        return self.wait_for('QMP to come up', attempt)
+
+    def wait_migration(self, qmp):
+        def completed():
+            status = qmp.cmd('query-migrate').get('status')
+            self.assertNotEqual(status, 'failed', 'migration failed')
+            return status == 'completed'
+        self.wait_for('migration completion', completed)
+
+    def wait_running(self, qmp_path):
+        # Make sure we're dealing with the new QEMU after CPR
+        while True:
+            try:
+                with self.qmp_connect(qmp_path) as qmp:
+                    self.wait_for('the VM to resume', lambda: qmp.cmd(
+                        'query-status')['status'] == 'running')
+                return
+            except QMP_GONE:
+                pass
+
+    def boot(self):
+        self.guest = self.vm
+        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.guest.launch()
+        self.wait_for_console_pattern('login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
+
+    def transfer(self, guest_cmd, host_cmd, cpr):
+        """
+        Run a socat transfer between the guest and the host, and keep
+        performing CPR migrations as long as it's in progress
+        """
+        exec_command(self, f'{guest_cmd} &', vm=self.guest)
+        with subprocess.Popen(host_cmd) as socat:
+            while socat.poll() is None:
+                time.sleep(CPR_INTERVAL)
+                cpr()
+        self.assertEqual(socat.returncode, 0, 'host socat failed')
+        exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
+                                          'RC_0', vm=self.guest)
+
+    def transfer_both_ways(self, cpr):
+        """
+        Send the payload to a file on the guest's disk, get it back into
+        another file on the host, then compare.
+        """
+        echo = self.scratch_file('echo')
+        connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
+
+        self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
+                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+        self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
+                      ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
+
+        self.log.info('%d CPR migrations performed', self.cpr_count)
+        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+                        'the data came back different')
+
+    def test_cpr_transfer(self):
+        """
+        Perform consecutive cpr-transfer migrations during vsock file
+        transfer, starting a new QEMU instance on each one, migrating into
+        it and shutting down the source
+        """
+        def cpr():
+            n = self.cpr_count
+            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
+            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
+            target = self.get_vm(name=f'target{n}')
+            target_qmp_path = self.prepare_vm(
+                target, f'target{n}',
+                '-incoming', f'unix:{mig_sock}',
+                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                             f'addr.path={cpr_sock}')
+
+            # The target listens on the CPR channel: wait for it to be there
+            target.launch()
+            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+
+            with self.qmp_connect(self.qmp_path) as qmp:
+                qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+                qmp.cmd('migrate', channels=[
+                    {'channel-type': 'main',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': mig_sock}},
+                    {'channel-type': 'cpr',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': cpr_sock}}])
+                self.wait_migration(qmp)
+            self.wait_running(target_qmp_path)
+
+            self.guest.shutdown()
+            self.guest, self.qmp_path = target, target_qmp_path
+            self.cpr_count += 1
+
+        self.boot()
+        self.transfer_both_ways(cpr)
+
+    def test_cpr_exec(self):
+        """
+        Perform consecutive cpr-exec migration during vsock file transfer,
+        saving devices' state to a file
+        """
+        state = self.scratch_file('cpr.state')
+
+        def cpr():
+            try:
+                with self.qmp_connect(self.qmp_path) as qmp:
+                    qmp.cmd('migrate-set-parameters', **{
+                        'mode': 'cpr-exec', 'cpr-exec-command': exec_cmd})
+                    qmp.cmd('migrate', uri=f'file:{state}')
+                    self.wait_migration(qmp)
+            except QMP_GONE:
+                pass
+            self.wait_running(self.qmp_path)
+            self.cpr_count += 1
+
+        self.boot()
+        exec_cmd = [*self.guest._qemu_full_args, '-incoming', f'file:{state}']
+        self.transfer_both_ways(cpr)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()

-- 
2.47.1


