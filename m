Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ACCC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 15:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKewE-0004vF-HX; Thu, 29 May 2025 11:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKewC-0004v6-NM
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:12:56 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKewB-00045d-6D
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:12:56 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e7d9d480e6cso787866276.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748531574; x=1749136374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZi+a/UqL2cyPqD4HwVlxxBx8LrwmdG57B+sbwJ6l3M=;
 b=LBQYKuY2tQrwGupVnoYDHNCIgHB1wZFXoCXGos9/ln0z5VezWZD98gLCUxeuCcTqJD
 CccY0YGsKZ746sFQE0B8cL46w6s28e4HsFeRZLX4z6u3pQUfVWtv9KSXClr04rt+1yRV
 zwkbzVhPDEdQrijsW5opTtJKu2OgqImYI1fjPKRBYzU9hJQZ6qDY6vRVntvTPlWXEJcZ
 ApmrauypDbr16IQBGiOMx4glfu1aw+yhC3e5AH7ADbNG2uVc32MAtheiAOqTcykt9XfO
 h9YdCXQZc6kN0nLXecpxs+FzJ196jnkCgqs+QvmaP2x34Uj1fjWKIdC36z4pWpkodpA6
 QzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748531574; x=1749136374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZi+a/UqL2cyPqD4HwVlxxBx8LrwmdG57B+sbwJ6l3M=;
 b=rMJkuaX2hYKHBfnC0B6jv+Ic3TdAunXnauRS/yU8Xw4U5FLkX/P7MsFMfZfJCyeiLc
 jazhMLZjiec/mJXSaP4sQEgej87stQkJJiRNaac3FNshSfP4VV8x7iiqLajsK9dVw+gp
 95k5rjWE9ZK30g4QldnG5kQb4rAT4lGW1P8ZprHLXsjQ8jFV0dlZyn31/mGgIJNxeq4S
 pTWc/UEjpvVuQfPqgWYzfFNqzMQzxlcejfcHjVQZPoPjNoGe+By5iKAfD44gGMSPc0xd
 9r/lDyIPb0fsrJ/fIFOk2lOU/f+L1v6DecLQRnnV/bQ7NWNBuhGucpsYh+rs6p/F/03q
 LAlQ==
X-Gm-Message-State: AOJu0YzqLfHh/aNN732Urthd3g2BSZgoEaBxLOOjY6Ja2w12zObVzQhN
 DbuoVrupS/qh8m6Ijlc2tYs9zC6nFPL0FaB95qA9PYhwWP27Br/zJZTWDja38lg8s7ISUyT3H0M
 /P+qUmHNk2ymksdrX5MugZxganVTAvhG1QmjhHa0yCQ==
X-Gm-Gg: ASbGncuXZWLJFeVPUZA1YeKZw3QObrFYEBQSoYzwN4ioRmYumVQUl/T1LzTaEcgsbw3
 +Gwx0XhxMW4bCc62M6dDeBfJmvWH7cApUobb1OqVNn8iUUWN/4I110kzsPFbZ03pjoFTk1gl7no
 quNzagbhdw27tAn0v0p3P1AUKylc5xon4gZw==
X-Google-Smtp-Source: AGHT+IHL21pjrFYgIooVqwgkfJYqOTDkhIfJHamzS/57Zl7m9Ef5chSUkJXTU5cGoqu8IJPhiX5Uz6CQMU8ZTtkrnuo=
X-Received: by 2002:a05:690c:7405:b0:70c:965b:4700 with SMTP id
 00721157ae682-70e2db1597amr278612737b3.31.1748531573590; Thu, 29 May 2025
 08:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250522092622.40869-1-conte.souleymane@gmail.com>
In-Reply-To: <20250522092622.40869-1-conte.souleymane@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 May 2025 16:12:41 +0100
X-Gm-Features: AX0GCFutxqpC7tC2th3W9jNAt809B7uBPluEtujZpU-dc86A5X06ZUlxzm5NFIk
Message-ID: <CAFEAcA-QQXg-EbeUNZEWUFkgA_zcDxWRPv9u8nOpVOsO1Bd=uQ@mail.gmail.com>
Subject: Re: [PATCH v3] docs/interop: convert text files to restructuredText
To: conte.souleymane@gmail.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Thu, 22 May 2025 at 10:27, <conte.souleymane@gmail.com> wrote:
>
> From: Souleymane Conte <conte.souleymane@gmail.com>
>
> buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
>
> Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; I have applied this to target-arm.next and it should
appear upstream in due course. (I switched a handful more
words to monospace that I thought better that way, and
updated references to qcow2.txt in MAINTAINERS and some
other parts of the docs to point at the new file.)

-- PMM

