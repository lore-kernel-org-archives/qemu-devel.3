Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E19C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welCe-00055T-PZ; Tue, 30 Jun 2026 23:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1welCV-00054O-Py
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:01:26 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1welCT-0001AN-Ho
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:01:23 -0400
X-ASG-Debug-ID: 1782874866-1eb14e680f115420001-jgbH7p
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by
 mx2.zhaoxin.com with ESMTP id 2HiUClAmQnjriQ8q;
 Wed, 01 Jul 2026 11:01:06 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server (ewan-server [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTPd12beea067640ce10cef9508f72d509b
 Wed, 01 Jul 2026 11:01:05 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.24.2
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Wed, 1 Jul 2026 11:01:04 +0800
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH] target/i386/cpu: don't assert on out-of-range CPUID 0x1f
 subleaf
Message-ID: <20260701030104.x53ffvfpibzm6sen@ewan-server>
X-ASG-Orig-Subj: Re: [PATCH] target/i386/cpu: don't assert on out-of-range
 CPUID 0x1f subleaf
References: <20260609090046.2376016-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609090046.2376016-1-ewanhai-oc@zhaoxin.com>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1782874866
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 48
X-Barracuda-Bayes: INNOCENT GLOBAL 0.2259 1.0000 -0.6942
X-Barracuda-Spam-Score: 0.57
X-Barracuda-Spam-Status: No, SCORE=0.57 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64,
 FROM_EXCESS_BASE64_2, PR0N_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.160841
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.20 PR0N_SUBJECT Subject has letters around special characters (pr0n)
 0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily
 1.05 FROM_EXCESS_BASE64_2   From: base64 encoded unnecessarily
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=ewanhai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gentle ping. Any feedback on this fix?

Ewan

