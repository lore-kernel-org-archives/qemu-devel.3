Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A27D68B28
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBae4-0000fy-1F; Thu, 14 Nov 2024 09:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBae1-0000fI-Qo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:16:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBae0-0005gx-0S
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:16:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43158625112so6467355e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731593781; x=1732198581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rQtG2DTe69xRGS5IpoB1b9+fEhQPKqrD0dUp2eVwI90=;
 b=fDLFl6cRgb0vnWle7PBluA8dbjo0rBKN8tWGNFZtj30mPzW5HV5qU57j8X5trssQ6g
 G9wkDRbSAsVzlV2K1AuPysMdqA/PxczskBl9CuM1QDYYbX5LBJkfpRitjsFGNLKm3lP3
 3N3R87BO/vVnRLMRlejzPTxpNl/pErSgTs8S0pmQ9x4zgLROeua4PzKHOWdRRo/s1jOU
 6Dj+iq3eipI8+easRXhWU/T7eISP6uGTfX4OW2h5TV65Pwezh3yo+ie2pX9efFaDHGjJ
 Ymv1zat35w3V67FpzSW8wCjWXp6DXbm/8DL2gRCUtGCL/iYVA0tl7JLnJ4B159bMwxp3
 BPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731593781; x=1732198581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rQtG2DTe69xRGS5IpoB1b9+fEhQPKqrD0dUp2eVwI90=;
 b=pdetolXyOM3oSPNJf0mWWkL5YtDPAlYaTiVJYAHy1X+Xma+QAs9eUohYj+dvqhqVBS
 2ghRM7y0N5xKCfiRImsEV1xqmG6npuzvbfZtd24mqRitjwsBYw3H/X4sRFCCXNd1Yngo
 heOcwoy9aTMaZT05s522DcrjiSKF+C4W9KDLpQGzQSxhZK/00Mmcjhy7JtWqQSljSlzA
 UgQA3KtflNXpsB+jy9nRtWQpZWUSe6s+hVjkg1ChDuWD7xy/IMpXQWGMuhdlNMRx8+7l
 YbcShBioJPzHtnyobUQSYeWRhqjHldQ9SCLklseE9319meHQRy6coekBo1y35mP+DOoN
 1ARg==
X-Gm-Message-State: AOJu0Yy2kWjtVKMqFa2EwCnKv1odyfdcpe7CMjMlBPbaMhmHBfTWyzdi
 HsZCd7khz+jqUK8LB/Kzg/bGe4nTYRPgDRRcu9NRghwm7L2FlynYDQv/xwzgSvycKUoN7Yj92Yb
 l
X-Google-Smtp-Source: AGHT+IHin9Op/H/aWyh4RFh+jxZTGHlHbxx0M3SUyteKkxd0AYGbdGyVGYrTPG7iTJc6QzmR1cRqcw==
X-Received: by 2002:a05:600c:4e08:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-432da7cb853mr18090585e9.23.1731593781203; 
 Thu, 14 Nov 2024 06:16:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244915sm24941655e9.3.2024.11.14.06.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:16:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <ybendito@redhat.com>
Subject: [PATCH v2 0/2] net: Make ip_header struct QEMU_PACKED
Date: Thu, 14 Nov 2024 14:16:17 +0000
Message-Id: <20241114141619.806652-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

This patchset aims to fix some clang undefined-behavior
sanitizer warnings that you see if you run the arm
functional-tests:

         Stopping network: ../../net/checksum.c:106:9: runtime error: member access within misaligned address 0x556aad9b502e for type 'struct ip_header', which requires 4 byte alignment
        0x556aad9b502e: note: pointer points here
         34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                     ^
        SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:106:9 in
        ../../net/checksum.c:106:9: runtime error: load of misaligned address 0x556aad9b502e for type 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
        0x556aad9b502e: note: pointer points here
         34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                     ^

These result from the net_checksum_calculate() function
creating a 'struct ip_header *' from an unaligned address.
We try to handle the non-alignment by using functions like
lduw_be_p(), but this is insufficient because even accessing
a byte member within an unaligned struct is UB.

This patchset fixes this by marking 'struct ip_header'
as QEMU_PACKED, which tells the compiler that it might
be at an unaligned address.

For that to work, we need to first fix the places in virtio-net.c
which take the address of a field within an ip_header:
the compiler will warn/error if we try to do that for a
field in a struct which is marked QEMU_PACKED.

Probably other structs in eth.h should be marked packed
too, but I am here only addressing the case that produces
warnings that I have seen.

v1->v2 changes:
 * patch 1 now uses the correct lduw_be_p/stw_be_p

thanks
-- PMM

Peter Maydell (2):
  hw/net/virtio-net.c: Don't assume IP length field is aligned
  net: mark struct ip_header as QEMU_PACKED

 include/hw/virtio/virtio-net.h |  2 +-
 include/net/eth.h              |  2 +-
 hw/net/virtio-net.c            | 23 +++++++++++++++++++----
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1


