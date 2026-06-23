Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D366CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbyoI-00058Y-6k; Tue, 23 Jun 2026 06:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbyoH-00058C-15
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:56:53 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbyoF-0005L9-Al
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:56:52 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66077e90382so5612092d50.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782212209; cv=none;
 d=google.com; s=arc-20240605;
 b=kmNF6gaNeaUa5FDu00/vev23safsc1Fu18acca6/K6fNMp0ho/M7iXaSsFm+FkMHzH
 7cRmHTt6P/uX7ppfxLVPIa6ghW2XotlN9xGlllmNmrHNl8Zw0ybn2PiXmYB72ZYqbyNK
 zYOlqjJQUiCRDSAVua6J92tKCai+G+/VpsanS8De1445QW/hIfnJBzibCitT7i8vcTqM
 C6Ic69Badn1O+bMnWV3LrQB0/p/8q+jkuxYxLE/vo/SjzNmGi+j++qNtUlPynidXpm7l
 5ALbtJX3goG0qXPhFafi6yWaiZNrpCyYEiww5+4ZIOE75juFtnX3b1A0j8ppk5s2/ZRv
 b8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=T3CyUloVHV802dplj8dW9sl/urT2LaE1KZyHLHTjgUc=;
 fh=cfbs5FjUGBW3lG+bIBEoCd7gPmGa/KC0n1jnW4WAKzE=;
 b=ADaBFS813A5DBaQcroLkxVP3GpxfMJDrC8G9byTNCsYOlFFi0tj2xSTba+BOWR6OlX
 hIpoDswp2PebSiLnFmcXx7/53BcFWeJ6t/nLrj84tBMG2XLcNu95SgtHBlqehRT8eQMu
 HyCF+zTFAdiYDdkwd7lMaQg7Ky/oR3OSV5cnfG3hYz9J8Oys2k5DEtOf/MSWKS22Enoe
 lH1eDGh4DxKX3mw2EODQTtkpVJwrAj7tjOKEL0gDq+y/wVGDHUU1TPcFcWda3G413Y51
 Oqi2XZP0Pebua9GSwCD4EVPZ0zYWtMgpcTTZbKnc9JL6U+NK+xO2EAOMg6jaCWSxnrKw
 zQ4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782212209; x=1782817009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=T3CyUloVHV802dplj8dW9sl/urT2LaE1KZyHLHTjgUc=;
 b=ZXJ+ChtZueqG+LrQVaSqaoU8ziKk1Z6TcruW1SLTWoxJDfn6h6QwPrxj6lqAdGSxuX
 7IgOetVN2XIL3EPTFQwrHD6uism1naBpTiYNU2H0mtPEPWD+zkO2qjCQeCDF8Q0jvvvH
 0ls630xdDzTXuii+qnzleHDdDA+0gjMpbjOVvpF3SgxSOav2Z7/VEQIqQk/Je9IJfhZp
 fdfPlOUTNe6CD6pJWSSM+Rjro8lb1uX6JSt/oVKEzWl28V39nv8UZFJhtmo5SIeBQ4yy
 k/CIAXUae0kDkwNcPtiJBNOL3AvnKnWGy0YBWcILt6GXT8Jfwbcv5UegpE2rH4N5V1wm
 wInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212209; x=1782817009;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3CyUloVHV802dplj8dW9sl/urT2LaE1KZyHLHTjgUc=;
 b=PDmMEZFP+Tn5onQOKU16Oza3uLJV+dSDm9NRLRhF09G73FCLJNzSx1gxneFlwnRlmB
 py7VseMpfxztGjzFFJB0tr9uYeyU5Q+wMVU+nnBPG8I3Xa6Iyy3Qu21VeSyqppUKYfb9
 gavcpja0pLJ0wOHjixbkCLgOX5Eudptd1vLtR73GfbdY/NHAP+5wIPvO86LunIzapAX8
 00YLJrCmF5hpxRDMsWS10AMwxLG/APxvYtc8Q/sR0p+PvNuxRWJWA4IPjvov5tJWr/7D
 eXgHq7lUfKhXo9oRVsb0pWeu3O+HevvMfkk0uJsXWsZmAvYmX78vxJfPR4wz8lrWqR0S
 dP+g==
X-Gm-Message-State: AOJu0Yxke0f5LYOyQ9ERPf5Ft+3Zjqw5xwp3oS9j+O9w1bGpj7f2JziK
 r1beD6+4uEGYHQiFTydCt+5g4vgiLp6h3Gx7vUxLc+6cSrQqA3+DQ+b6gzV+XoUYff2aAFhEpqZ
 05n8fUteqLz++wtGMFpKn1B7xlw5/VI214qgBZcW8j6pHqnwPE8hyTBU=
X-Gm-Gg: AfdE7clBJvUfA/XKmX+IcR3Cvk2l4WTq+0yCSYi7jcoQwCSSY3ke9DTj7q41lTXEhJM
 ZMFb4Kf7+fIOlDJJmO/1qv16dPc6hDp5zbAq0Twb6JqgsL3cfw9Gm3+AIJvxjGwAirqi3iBuKHb
 47NmF+Sysco/rhDEolU7S4oJ+v8gRqvDjNvAiOAIR+qrJHF0PSVArWyYZlCDY7sC+ufHKFdxwk2
 xPUwuGZWqrIk62mX6TlAhsHES1pie7gp5MymYs+8/Y7bF5jwqunywxqp2LR9VpnNlKDZJwY6eWe
 FcsA/bNibj88zHpm5EEhHCXa9NvQgBxet08USf4beBbF0cfwFllJHVJL
X-Received: by 2002:a05:690e:130c:b0:660:6a0c:c734 with SMTP id
 956f58d0204a3-66312db92d3mr12781327d50.17.1782212208937; Tue, 23 Jun 2026
 03:56:48 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 11:56:37 +0100
X-Gm-Features: AVVi8CfUzf98UbKmE-B6BfL20_6RyL2bhLyAQKTFwXAwyxrvjX3j4oU3ruYbt50
Message-ID: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
Subject: QEMU net code and padding of short packets
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

What is the general design principle for QEMU's handling of "short"
packets, which are less than the 60 byte ethernet frame minimum?

In commit 969e50b61a285b0 ("net: Pad short frames to minimum size
before sending from SLiRP/TAP") we made the slirp and tap backends
add padding to short packets before feeding them into the net
code via qemu_send_packet() and friends, with the idea that we could
then remove (often buggy) code from network device emulation that
tried to handle the short-packet in its receive path.

In commit 79b6a985 we realized we also needed to do this for the vmnet
backend. The issue https://gitlab.com/qemu-project/qemu/-/work_items/2362
reports that we also need to do this for socket and dgram and similar
backends.

I'm trying to identify what the underlying logic here is. My current
best guess is:
 - we should always pad before feeding in a packet which is going
   to be sent to an ethernet device model (unless that device model
   has explicitly opted in via do_not_pad, e.g. because it really does
   want to faithfully model the card's handling of short packets
   and it's gone to the trouble of getting it right)
 - we should not pad before feeding in a packet which is going to
   be sent to a network backend (i.e. where the guest is sending out
   to slirp/tap/etc)

Could we do this by having qemu_send_packet() etc always pad, and
have the slirp/tap/etc backends set the do_not_pad flag on their
NetClientState structs to suppress this? Would that be better than
having all the backends do "and pad this" for their sending code?

At the moment the only user of do_not_pad is the virtio-net device.
commit d4c6293041 just says "there is no need to pad" and doesn't
give rationale. Why is this particular network device a special case?

Are there any special cases where code calls qemu_send_packet
or qemu_sendv_packet which aren't either "a network device"
or "a backend"? There's net/hub.c -- I guess that should set
do_not_pad for its inputs, so it faithfully passes through
short packets and lets the destinations decide whether they want
them padded or not. Anything else?

-- PMM

