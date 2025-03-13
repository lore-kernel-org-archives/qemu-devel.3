Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E0C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 02:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsYDm-0002nK-CK; Wed, 12 Mar 2025 22:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsYDi-0002n6-Hj
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 22:22:50 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsYDg-0001DI-DC
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 22:22:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so653450a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 19:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741832564; x=1742437364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gKGNkXyccZ/Qb/O6eecrVtSfppVu0aGqLf92YulUfAs=;
 b=TANdTPEMaSL5R4rkiPMAgZqa/SVD/dm8q+qc6MEIhXf6irttQSwwuWq+H7AqCWvVjj
 d4QHovMbtc7cjZJsIaguzzE4KLhXMcpuLn+0+oMeCN6j6HBs1NyCiw+/Lv3Ro6+I95dO
 llREr92EpZCIHsMEtzOkyCa5CqGJadVi7OAOxUXxjU6ZSUv/5hvNP+Mnny5fvldZn9iF
 0eSe3I6twZ8Urqjc273U7P5DQJ7/hOOQoqcrrH39oXDgLur/C9SLTi5DtPRqTwXrB0Ma
 gKzGbhpcEkv6wDqz9vGuIoUtttd/iXJZgA2KdsN2OBYKTPzYqJ0K6pvmYLTNwwYe4q+J
 f8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741832564; x=1742437364;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gKGNkXyccZ/Qb/O6eecrVtSfppVu0aGqLf92YulUfAs=;
 b=pMqWQU7ZfhxrPkDUFX1zKqiSKvq0Y84x8myg5yQ+TFkUNumG9Y0vswnm0T+lOfEsOE
 B20S0CflbR1kGY+n9eXlSlcZAZR6BvMpxpcrQCur+xagQqOOfSD8R5JrcZvJdH4tPY6G
 FTylx2eWJ+jxlj3kemNou1cyzULzCdLjpHHdmd7a35BBLksyzAJlsSZDP15ZZt0lhEi1
 IXtLmAigBTvtTXh1ThUTxUiLZb77APh5dFdH7X26cgtF71cXxTapvrJnUC/agLX0bT9T
 msNVyGBa6fFKdJnPBNa1VGjA5QnczV43H4fEhckSP+mPqPASm1Pp1ga/bcKyYpQ8dAAI
 JRMw==
X-Gm-Message-State: AOJu0YyqNyg7vOnD6uYgGsBYjxSzVr8kVYrDtpWmNi+x8FeMu/bS0yBc
 Rxk5s0EyOZ8Nj+Namk+etmwxTmhsP5rOSrgf57kU8e5otb1PdPEA2XnPCpRSj2XEQ2HhKFyOfb8
 dXa23PnqD67q3GXBPAk4kM3WLCnA=
X-Gm-Gg: ASbGncvMwD0Fd4VZdrjcGZgcJZCrMvVpHRrqTwu12OnPLT4BtAbzbaT3A1eHKQ4HEIx
 TQz1LI/6RRKUxPbnMSpueFDRKh88UH0tlbZdYmrQ9X/0QEtN8WDbtKvkO0gAF7DrXbHGYX6oB0Q
 sikhsnU0D/mrkSrlFSGu0FljrB1G7A8PnGX+2p
X-Google-Smtp-Source: AGHT+IEis12wkv/8WboSfBWJuD4y9vUPXXTnHaqMsL3mK+3/EXcbDhLKbPLdtlz4ZVGx0NgrsryhThuxb5jGEFQB+Nk=
X-Received: by 2002:a05:6402:1e93:b0:5e7:b02b:1eb8 with SMTP id
 4fb4d7f45d1cf-5e7b02b1f18mr6862755a12.14.1741832564455; Wed, 12 Mar 2025
 19:22:44 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Mar 2025 10:22:32 +0800
X-Gm-Features: AQ5f1JrG8J2h4HfIFOrhPComkcxNXSc8sY5P4OoiW7vzpHY9ZzcbuuYJKjrFGAk
Message-ID: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
Subject: Broken NetBSD Orange Pi image URL in QEMU tests
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,
CI jobs that run test_arm_orangepi.py are failing:
https://gitlab.com/qemu-project/qemu/-/jobs/9390048284#L1138

Please consider how to resolve this so the CI job passes again. If you
are in contact with the archive.netbsd.org administrators, maybe
contacting them will lead to a fix. Otherwise please update the QEMU
test to use a URL that works or remove the test.

The NetBSD Orange Pi image fails to download cleanly:

$ curl -O 'https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz'
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0  303M    0 2048k    0     0  1098k      0  0:04:42  0:00:01  0:04:41 1098k
curl: (18) end of response with 315646186 bytes missing

Thanks,
Stefan

