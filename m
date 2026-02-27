Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F3B103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5ZA-0007FI-51; Fri, 27 Feb 2026 16:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5Z8-0007D9-6M
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5Z6-0001Se-HK
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso19942745e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228402; x=1772833202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TwgtaQgEJDu9Pbm3cfLvPLRZhttS8vh7t3TVVcGzyO0=;
 b=ZM795YtWma5DBrRpIl5SgdUdJp9FaxLkK/hyST6DhKg3BuWDVCMl7uYlRrDm00GGyL
 92vlUUdZ9FRkPYiwILjLT1Aoath3JNzNPL+5qqS/d0UE0OYLCJfc28YGgqKEhP4DEU/1
 /nidzmfWc38l7wUTDsmZmvgqbpqq9f6gIM8WImK4/QM8LfyjsoaIZgNXS+ZfJsLBGv93
 hjS0GbkW3Etyq4hRdAzgqVYN0T+QbMNYf+IYSy4MX2aUBvTYNcZMAOYsbioBO7EtsRnP
 CC4LfJmsKfQwVjvqjTiyruwJbmci7hBpDpTiFkMOFrtJD06w+h3Js0QiClYRP0kbV9vC
 PGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228402; x=1772833202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwgtaQgEJDu9Pbm3cfLvPLRZhttS8vh7t3TVVcGzyO0=;
 b=SDCe/VYFt8NsjxBFY/N72ZhznOWxig9vp2fw4uCerU59gUFESabAvnclW5N4Td2/Ze
 wxa00x16kVSitPcE+dTFXMBZxvoOOiuL6YUAYYGzI+T6uH9UHdRj4j39xasRgSFDkTor
 l41v8C/8c2XMqc/rRLL24PU0oX6Qkvwg7gUJj82AlJb4y0cUDFNeBXxDcuxP1byOoA3g
 CoREGUdlFJtygV9E0fFuUhT01JatrqXkTUo2+DmRrDil1DLcHmkrhtA+pXfSyOq4ONTm
 NjfWxVyuPHQqfBa6Szr5SgsglStbDvLIEN0VcSy6dcc5Jqml5ygcDcJ2oPtmrNQ1r9XK
 SvFQ==
X-Gm-Message-State: AOJu0Yzx2P+YB2zse3VieqRCAGwl59J4vxueyHgPYXmaCO+sK5h1ZyY3
 rRUK3faj3qmDOXzXjpatw/Y+KIcKXOZ7aK5h1cXkDLYp8qh4o+W0WjQPbL6I4vpLiTrf+4hToWE
 CbW5EJIc=
X-Gm-Gg: ATEYQzzV+JlQZVNxwsz+6+kcG72gh1LXkfr7fN+clkIUT0RAZsbVy+4r7QS0njYyag9
 nXYMyY9ITccuwwcZ8kFkYGUk2nfAz9aQl7RQIxOLmONm8sjRoJ+LQ1+tmNFPpIs5LRaD86lSI0B
 E89fGQQJWqGEa3QCoAq0Mc4W3rwvtPoL0K5V9RD047xN0Oz91YWZ6+LMlpHatN1ggxptmCSzUMF
 bP3NNu8D8U+x41WvoOVMm1wtONDP79w+Lj01B880IeHZK7NgJNeZz5xNMko7dPorZBKNT/6LdbD
 i0bimDx8N30P0vjHgxw3Dk6LsgnrMcJySD7kt9OLbpm3HoFXVhkOOcr57Q1kk+2boWiq853jibr
 bBEj1ETi/bJ3jt5Ffp+s62BL+dbV4s7QIxWp5cmzh4j0G7pl0rdN/2L7MAp62v8VqTYe/nuJlcZ
 X6wGWEBFfa/vuzFXh3yTUeAIUOHKPWo5n+Tra1ZUOMj1Er4iHk53mQBz5m2iFEM7570R4mjAho
X-Received: by 2002:a05:600c:6095:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-483c9b7ac8bmr79019145e9.0.1772228402138; 
 Fri, 27 Feb 2026 13:40:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df9fsm266795825e9.13.2026.02.27.13.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 13:40:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH 0/4] gdbstub: Always infer base register index from GDB XML
Date: Fri, 27 Feb 2026 22:39:54 +0100
Message-ID: <20260227213958.21170-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Generic fix for a latent bug reported by Florian:
https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Use the 'regnum' XML tag for feature base register index
(after fixing the incorrect m68k FPU ones).

Philippe Mathieu-Daudé (4):
  gdbstub: Have scripts/feature_to_c.py generate more verbose output
  gdbstub: Make base register explicit in m68k GDB XML files
  gdbstub: Emit base_register index in GDBFeature entries
  gdbstub: Remove @g_pos argument in gdb_register_coprocessor()

 include/exec/gdbstub.h     |  4 ++--
 gdbstub/gdbstub.c          | 16 ++++++----------
 target/arm/gdbstub.c       | 21 ++++++++-------------
 target/arm/gdbstub64.c     | 19 +++++++------------
 target/hexagon/cpu.c       |  2 +-
 target/i386/gdbstub.c      |  8 +++-----
 target/loongarch/gdbstub.c |  6 +++---
 target/m68k/helper.c       |  4 ++--
 target/microblaze/cpu.c    |  3 +--
 target/ppc/gdbstub.c       | 11 +++++------
 target/riscv/gdbstub.c     | 18 ++++++------------
 target/s390x/gdbstub.c     | 15 +++++++--------
 target/sparc/gdbstub.c     | 12 ++++--------
 gdb-xml/cf-fp.xml          |  2 +-
 gdb-xml/m68k-fp.xml        |  2 +-
 scripts/feature_to_c.py    | 14 +++++++++-----
 16 files changed, 66 insertions(+), 91 deletions(-)

-- 
2.52.0


