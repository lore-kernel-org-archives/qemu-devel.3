Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45F5E6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0T7-0006gt-Rq; Fri, 30 Jan 2026 21:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0Sn-0006NM-OG
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:11:53 -0500
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vm0Sk-00024S-Qd
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769825506; x=1770084706;
 bh=H7BxVVVz14DeXJQA6wUU6itvmXHb9wk97Svl1g1rr1s=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dQ31Sz5EHpyC6d2FfGbkxZR7Z4OqvEZQ32SFywz18vxyOII3bDJqmTx79yRnQnqUR
 +ywUvwAASDnU7FCEIi2/69tSknpaY1aezPaP5riEFszmmu5cFArAlwCn38S/vQUzdb
 DsFfwB9OwdInKTnzjMm3wS/yXYOHpccNSNG4bsxtfpKpAgBP96PI7fN2UBTktoLmDJ
 2E+ARQfUbI12tpunM/9/N3IkM2u6UTxpg4C4BqNNo96hEeWEaZ4HER0fNc0h13luJv
 SOruKdM+Sjeb5XCguwPHlSdWjvQ+0Uq4cWfUTGXLVjy2HOrcIF4j+SNEaPkEf3T9BG
 yLAGiCJPx5JOA==
Date: Sat, 31 Jan 2026 02:11:40 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v4 0/5 qemu] GNU/Hurd support
Message-ID: <20260131021116.1717230-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: c27105af602f4f1d3895832a3161e66efe57e7cc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.18; envelope-from=damien@zamaudio.com;
 helo=mail-4318.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Hi all,

Thank you for quick review.  I have addressed the comments and am
sending you v4 in this thread.

TESTED: Compiles and runs qemu-system-{i386,x86_64} on GNU/Hurd x86_64
(TPM compiled in)

Thanks,
Damien



