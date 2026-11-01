Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2321606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0/2O/DU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNZoj-00057Q-0f; Sun, 01 Nov 2026 12:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNZMl-0006oV-2A
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:29:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNZMh-0000gs-AS
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:29:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso22171085e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793554145; x=1794158945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VzDJP5bF+ZfkTM6l/82UKIRdcr9quHo5sFyNRYRV49Y=;
 b=P0/2O/DUP7Y39ywHg2kS9r377mT4O3ZWGcwcTl1ZQqerBFgTPKnJZ61dw/+xSdEiTv
 HxQ6pbhwMivRfxcbxllMbM4+oV9RG3GBy3tddMWDqngQ0mZ+643rIW//AnxxaLUr8GdI
 KPv1P3999Jcv6QaVC3hwJZqO2+wUJNt1Z3HneNvOtgCkSzMvzHH26Ngb2IeHTvdWLI7C
 IFfkx7wLysHI3+21hgUqvLm1qyW+uckF41sNGYsVikbZCp9CUhKzZuJQY4E3wWEEqduS
 r1DYm/7Yoh/KdLgNWAcw4QBT1Vv55M7W7KQ3UQGhLvjTLgl0ptwagQfkMcpqTsdHDN6C
 c+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793554145; x=1794158945;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VzDJP5bF+ZfkTM6l/82UKIRdcr9quHo5sFyNRYRV49Y=;
 b=haQRxr9KzuT5GNa3WMbW7MFDuKl/vNDq6fY+8yv/i7eobTg4CQnRxkXhR3JzwYDsMx
 HInJ5qmvrrNFnNpIzxyb2ik60yTg1IDYlAm35X9G/KcF71yH/xsfSniJkCyKbXWyOGuP
 7pbDgJMCMRV92dnNbKKhEfvfscv9cRpqrBekrKACJxW/IZZf2RaZhNhJz9SxLXoEAr00
 HIxXeGmyuhEEaacuNTa5tGdw88Vlgcb4Wb9JLCL55DIp1RA409V05ybs+k+7deSe3uVo
 AaSS5z58WV0K6207vFW6Qbs43L87lQke+9WzXi5sGREOO/Es0WNQfNRQClPcpCDKnVzn
 gYhA==
X-Gm-Message-State: AFq9FYKgZMX6GxV/19qWpH9ndrae8Bu8B9C2wadl47xYJnz0TTx7KQRG
 TcD9eBHkKucVJJ30izrFkf3lgphFZozTRwy4IKU/QYTiTgHO9P0s8lZT
X-Gm-Gg: AYBFou3rnBspLLklFUyvAx3RiESxci/L5t7whrNY5dtu6GazZ05AK9J+IWlzn1krZsv
 ggztq+BUfxDPgetx8gk0zwX3AZtnBp/0HBqKyx0phsLP4Iz0oCiIeMm4He6TH/7vzlPfty0aeEv
 FwOAQ8zFPxjGL+oFYBj46Tp58SH6CfaQkLrcq1Pr8wvrfIoAkPMbstor5wGsr3qckCk9Nshcw0j
 PIfw5khTJmab9qFsrk/Tp3jz4T23DkasPsGCLjDN7F2lwtKmUJK76Zd4KbLGSf0FDY7sPjhyZ2h
 xULawsNuYwPiVE0MeO/7QdoSCEn7jjtq9uHG0aqMNzbFShF1+wt+z4nU0KsvH2B05qx9nvucQjW
 UuFGmsU51XfNgmLlfufEzUErmII9lSlyk6dyOerjkEmDd/tV7qQGwhyvuDiNQu4PfrYYWwrlf1Y
 o9YD8leN1HpFbZwA+KdzD6qE1XfkU55+jcqrZps5H1I5WDbOqIGP+vcpbMJf25J6YyxgZZHvTjS
 qblt2y89U843koEFx7Iz41I7fR8nVk7ZCgXwJpTsmvA+YJYYFFvB39imOHeBmKr8macgnVYzF1T
 Ios2lYn3PAUjhS1ScMn0EE15TlAdUBoe0GUAsMDp8W63eiT/fAA=
X-Received: by 2002:a05:600c:4454:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ac1794032cmr185740865e9.16.1793554145086; 
 Sun, 01 Nov 2026 09:29:05 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:8c1a:8d00:4ed:aeed:5810:610b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm254261355e9.12.2026.11.01.09.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:29:04 -0800 (PST)
From: Lorand Marton <lorandmarton.dev@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/4] target/arm: hold bql when SEV sets the event_register
Date: Sun,  1 Nov 2026 18:29:01 +0100
Message-ID: <20261101172901.873975-1-lorandmarton.dev@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030141046.2710206-2-alex.bennee@linaro.org>
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
 <20261030141046.2710206-2-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=lorandmarton.dev@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Nov 2026 12:57:54 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 14:10, Alex Bennée <alex.bennee@linaro.org> wrote:
> There is a race in qemu_process_cpu_events and sleeping on halt_cond
> where we can miss the setting of the event_register which would cause
> arm_cpu_has_work to report we shouldn't sleep. As by definition the
> bql has to be held when we go to sleep against halt_cond guard the
> kicking of the cpus by the SEV helper with the BQL to ensure things
> are properly serialised.

I hit this race with a bare-metal test in which two CPUs pass a turn
back and forth 500000 times with WFE and SEV (virt, -smp 2,
semihosting).

On master (af1179b406) it hangs in 10 of 10 runs with -cpu max and in
10 of 10 with cortex-a72 (no result after 20 s; a passing run takes
2 s). A second test, in which a CPU waits in WFE for a broadcast TLBI
and an SEV, hangs in 23 of 100 runs with cortex-a53.

With this series applied on the same master, the first test passes
150 of 150 runs (50 each with max, cortex-a72 and cortex-a53) and the
second 600 of 600 (200 each).

Tested-by: Lorand Marton <lorandmarton.dev@gmail.com>

The series has no test case now; I can post these two as
tests/tcg/aarch64/system tests if that helps.

Thanks,
Lorand

