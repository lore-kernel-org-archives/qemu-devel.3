Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DD4CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArNc-00065t-Sh; Mon, 20 Oct 2025 11:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vAnZd-0006v6-GD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:57:09 -0400
Received: from sg-1-244.ptr.blmpb.com ([118.26.132.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vAnZX-0002iG-Ab
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1760957795;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=imTz6YPfqLKwEiSi/9l87KLIRg+AtWmIedUdwb1xCqk=;
 b=UoNn7Ma+AGaFv5EcHcDHD4ezxmrmdhfwHQgkEJ9x3glFtKSTlGVtfMZnmGWl4FddLKWKKg
 vvhz66vRWsXyWwZnuU1I1ZUeL26EK7nwo6AyopZ5QqcheGPrbOe7j8n/lFLCKiGu2sOrHK
 hXZjduW1snS/+ACVbH797a+XaCYUnrgYxI3p+nvx2SGJPTfZJxgGgg3pEb+yPjr1DRYSVj
 bmmeQGUpJAf8xBPW5RN4fSKf7eaVLbwX+tF8BVnuDXtOcRMhBLwIpc2YKuCWIErsOE9U7l
 r+HiS6b2x7hffNqvqiQ30YegziDegWbEH6T5oAi9ZYR96C0OHtpNVF2ohq+Q+Q==
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: "Chao Liu(openatom.club)" <chao.liu@openatom.club>
Content-Transfer-Encoding: 7bit
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, 
 <manos.pitsidianakis@linaro.org>, <marcandre.lureau@redhat.com>, 
 <philmd@linaro.org>
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, <dzm91@openatom.club>, 
 <luojia@openatom.club>
Message-Id: <822f8543-10d0-4669-b484-cbd9837e324c@openatom.club>
Subject: From HUST OpenAtom Club: Inquiry & Contribution Plan for Rust In QEMU
Date: Mon, 20 Oct 2025 18:56:28 +0800
From: "Chao Liu(openatom.club)" <chao.liu@openatom.club>
Received: from [192.168.71.4] ([114.88.97.170]) by smtp.feishu.cn with ESMTPS;
 Mon, 20 Oct 2025 18:56:32 +0800
X-Lms-Return-Path: <lba+268f61561+440237+nongnu.org+chao.liu@openatom.club>
Received-SPF: pass client-ip=118.26.132.244;
 envelope-from=chao.liu@openatom.club; helo=sg-1-244.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Oct 2025 11:00:43 -0400
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

Hi,

We are the OpenAtom Open Source Club[1] of Huazhong University of Science
and Technology(HUST). Recently, we have established a new group focusing
on the Rust In QEMU, aiming to make some contributions to the upstream.

Prior to this, we have already achieved some results in the field of
open-source basic software and education using Rust. For example, we
lead the development of RustSBI[2], an open-source firmware written in
Rust, that has been adopted as a reference implementation by the
RISC-V SBI Specification.

We also hosted a QEMU open-source learning training camp[3] in China,
with the number of registrants currently approaching 1,000. In the
training camp's curriculum system, we included contents related to
Rust for QEMU and continuously shared the latest progress of the
QEMU upstream.

We have reviewed the progress of Rust in the recent QEMU versions,
and the results are very encouraging. Rust is basically in a usable
state for QEMU peripheral modeling.

Our initial plan is to add Rust versions of peripheral models for some
simple peripherals, such as block devices or I2C devices.

In addition, we hope to get some other suggestions on what other suitable
work we can do regarding Rust In QEMU.

We look forward to your reply and hope to contribute to the Rust In QEMU~


Link:

[1] HUST OpenAtom Open Source Club:
     https://hust.openatom.club/news/20250812_intro_to_club/
[2] RustSBI Github Repo:
     https://github.com/rustsbi/rustsbi
[3] Learning QEMU Camp:
     https://opencamp.cn/qemu/camp/2025


Thanks,
Chao

