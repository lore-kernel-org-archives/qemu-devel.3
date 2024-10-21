Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D31D0E6E0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pT6-0006TN-9S; Mon, 21 Oct 2024 06:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t2pSx-0006Sx-Ku
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:16:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t2pSu-0008J6-TS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:16:47 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso668704766b.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1729505801; x=1730110601; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VojtCDA3h+elD+VdZY6wIx7KFVIdLLDtaeDO6xJsKNQ=;
 b=YofmIEz5QOGwxgMiaSGEuS0OApObrNnyDRnlqM3IAQu7/o85nQEaRAQOTVt/bmc0V6
 LkjmAbocb8xa/9/odWoO1MXg92vI5UBYg3ECE2vpkmgOWGBQZdKyteDOjS6F/GAhnWhH
 ut/7r9/2F8yR2Nt2pHiQcQE0z6BdsiDN/yS+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729505801; x=1730110601;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VojtCDA3h+elD+VdZY6wIx7KFVIdLLDtaeDO6xJsKNQ=;
 b=ongNSV3HBLJzr9/ZH064kT9ZVMDxN2W+7x6bfSc5Rhb515HgGqgPMZnTohaMLR69WA
 tI0OYVYk4eJ+su77hKxcWmuv7QD+TgcrfuYXITlTrVqbHJ2jjzM8SDX5u2ptUyDWI7wS
 sI+Y8GjM4IQoE6SfWVSSw5Flw1vrZ8TRwzk3MOLwlqVY99iUt5/OqFcEYfxZ3bzNc1Ob
 vMwE4URqSL4hh43KMLnPAQqlkCLC+qclcMrNFT++D51eibOy6S6mPFCt0TcktZOrO0kx
 S5ZAxU2HQ43VFWpDzAJjrMWosDYpIlFMIs5EESHgla9nk4JAG+nGm1oTmITVT6+Gmkkk
 aSoQ==
X-Gm-Message-State: AOJu0YxlwXw2mr3JQDvWUOHTowM7oYnxM2hW3cq+B3t0XoSukL6rx59j
 guF+QLoipwUFmY96NRb1VBfBQ0JPWk4MAynx36ProAHIDfDGPDcs98ssi+lv0a1Z6y4Pl+Ae1wJ
 oMzUfi5Dd/v7NdtEYRMKYLVtVJuu4Jpg/
X-Google-Smtp-Source: AGHT+IHSSUhTQhRxRVmTtE8qGnGIwEofQZZYMr15asqqkKDU8ELKfKAcw3hzZ97rSflwicpuo7hEy8+VXaEA8W0kDdw=
X-Received: by 2002:a17:906:c10b:b0:a9a:1792:f05 with SMTP id
 a640c23a62f3a-a9a69ba907cmr1213288466b.31.1729505801275; Mon, 21 Oct 2024
 03:16:41 -0700 (PDT)
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Oct 2024 20:46:01 +1030
Message-ID: <CACPK8Xc=jsz5iT_WR7s-rcu1cRzryiK+-0o=6vUK_D_qMMrP3A@mail.gmail.com>
Subject: Missing image on storage.kernelci.org
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.17,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I was attempting to run some boot tests today and saw this:

 (11/39) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_bpim2u_gmac:
CANCEL: Missing asset
http://storage.kernelci.org/images/rootfs/buildroot/buildroot-baseline/20221116.0/armel/rootfs.ext2.xz
(5.21 s)

Cheers,

Joel

