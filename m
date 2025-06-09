Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EA4C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOd19-0008SF-7Q; Mon, 09 Jun 2025 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uOd13-0008Rp-KK
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:58:23 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uOd11-0004gy-H7
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:58:21 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 803251801AC
 for <qemu-devel@nongnu.org>; Mon,  9 Jun 2025 15:58:07 +0200 (CEST)
Received: (qmail 13608 invoked by uid 990); 9 Jun 2025 13:58:07 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 09 Jun 2025 15:58:07 +0200
From: Julian Ganz <neither@nut.email>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: Julian Ganz <neither@nut.email>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
Date: Mon,  9 Jun 2025 15:56:26 +0200
Message-ID: <20250609135636.22368-1-neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-4-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
 <20250608230819.3382527-4-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.299493)
 MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 2.600506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=J1YRTkhMBlbFlWiqsNBJntGS5HH7XiG2HNH7gVW69ac=;
 b=EIDdkXQEvkfumEWKnalj9f/o3vbKvA0JhaMPo6XHPVpyQ7JKbssh8H3pNvhEl9K4mHBb7OLXE+
 /VQhEEPEIook3WXu3FWnRU/4/DapCCbvLXZy5GhT1jgHEKOEQTlNMu8MXJLN5HVkRXmEJxwI5NpJ
 iFXysvUVifvvybnGtQEd+AHe4awSc/6JjY+dcvbEl8GG4u+NRSBcOBBUsH2FGRNvmm4KcPr2gQ3d
 DUBw5ae4KPqbUJfNjKNAgTwwkEPi6b2Z8MRtkheFKeFqqx+GmswHMH2MDffJgjYWsFXn8ClaLn/X
 sN/ESaFPNNdwoC8XHhC6+LRQ5XjQgV9KAUTQWii3H6KD8x7CLGHS7FK6GpV25wcd3Jf6XbYcv/lj
 B1nJQ7rr84azEmeSq5S2WUdECZEiCLGw6IOpJkyFjpXgvaJ3TPYSn8zSwRyvbzOTUl711MtTyiV0
 wH2kxS3kHDZeNhdoS0itKoKkYxiCQQBxkccfMjIe4ihIpwyl3/XtDjz9uVu/zRFgOvoFRoYigFnR
 Dw1BpYl3OFN5LQLUz5s/rru8t7AnnBeXOKO5mnw9eVW3swsaBsmPIKbm0wHJgxlsTlnHDWumU8t9
 ecaZlBjSs+alnItRNKdHkzBKNkYJeQaG9F93ClLE95yh7G1PjWoGsX0NLLuDaU614Ltz9no55khR
 c=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Rowan,

> This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
> flags level passed when registering a callback function using the
> plugins API. Each time a callback is about to be invoked, a thread-local
> variable will be updated with the level that callback requested. Then,
> called API functions (in particular, the register read and write API)
> will call qemu_plugin_get_cb_flags() to check the level is at least the
> level they require.

IIUC this patch also forbids using qemu_plugin_read_register in several
callbacks that are not called from translated blocks, such as VCPU reset
and init. And you do remove one of those from a plugin in patch 8 of
this series, stating that this usage was not intended.

However, it should be safe at least for a subset of those callbacks and
I believe there are very valid use-cases for allowing such usage. For
example, we are currently working on a plugin API exposing traps. In
those callbacks, users may want to peek at some registers such as
"ecause" and "tval" (on RISC-V). We certainly will want to do so for the
use-case we are pushing that API for.

We could add a QEMU_PLUGIN_CB flag parameter to the respective
registration functions. But since they are not run from translated
blocks but _outside_ that context, I feel they would just clutter the
API without introducing any real benefit. That is, if there is no valid
safety or correctness concern that I'm not aware of.

Sorry for bringing this up this late.

Regards,
Julian

