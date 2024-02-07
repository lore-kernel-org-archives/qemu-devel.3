Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B66C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwP-0002wu-Sf; Wed, 07 Feb 2024 11:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwM-0002ty-EC
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwK-00068e-Br
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fdc63f4feso7868025e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323902; x=1707928702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWoGzkk5jlTntsP9Fp0ezGwzMskb1JgO0OTcfpG0rf4=;
 b=mCvzwygqxhve/FdYw7vM+UBP6w6qu/Tz7WK/foIeEyrQVW6k/i4Ydkb9gF9Qt+WT4W
 ZY+OwC1/9TBVMyJzGILuzy3eG6GdfU2obtNtfUgM3kJwqmCqO3QL+8Zi6G+Bt10t4MxO
 uhKQxhRJZZ+42XRpdAVF3IN43nBvmecRovbPNOlnS0yszWLs0PRHwsdndJLWfQK0Ol6E
 24x9UiLhmUgPe2vTpvwHQaXuBMbpzTcB37XU3qhkjF/Jg4k6xkFg4Fbh1RFFZGl1uqnG
 Bu/xlEid0XNNnp0iZAqf/10Il2gEJll+T6o1DKJrWjTGrKEV4IyVJHKuA7WW53cr25xq
 qZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323902; x=1707928702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWoGzkk5jlTntsP9Fp0ezGwzMskb1JgO0OTcfpG0rf4=;
 b=jFHwJqxov0MJTJ4i+/gXSMN15RNEWYUxOPJhcAkSbSybJ7BTKUygBwlJ7NBvjAWpWR
 mSaOvfvbIebxm278bBaJrJbJCNvUah+gHUcf+KbOH8GfnYbKAaitEFy3dOQEjF2YlIVn
 p3jRwv45AuXx55UDatYtIYpJGESsBckU4XgntcUZRzdVbva/XfbODJPoI2qkwd1+BQ2w
 I0L5GgM5TTvPpiJvD1U1Ofyd8JcR9cYZdhhiqDe/sFqt6bLpY+cPEEt0JFY28+ah6G/P
 4gGcfbOEc9Z3LISj8aK0JidzLmVrdN47XeUEr4uof6n1ZUmrXOnhpQI/jNOyFTA49r9u
 pM8Q==
X-Gm-Message-State: AOJu0YyubnYky8f/2AgyzTJDyFO/VDH7HpLXauQMdSjoyZlkZm3YmQXu
 Q5nXVmrs/Ao/mkFqNc6LTdMiRjcfYmz3kZ3qjOf9XQb7IFoigIgB/YVPuZCw628=
X-Google-Smtp-Source: AGHT+IFKZDWPp/Oeqr5xIx+FWTBf9UOkRI8o5K1IWgBIDljwhDfnmXTooMPXmAX57B0O5y42TgwpXA==
X-Received: by 2002:a05:600c:4691:b0:40e:f154:752 with SMTP id
 p17-20020a05600c469100b0040ef1540752mr5391678wmo.20.1707323902442; 
 Wed, 07 Feb 2024 08:38:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWOTJ4esVaJckcJFrE2pkVh9RazJTeGt3av8oiPaGyDUIvMc4VJ5oqaZ5tCa3BM8uZeFYMPxrQ1xyVLHqFEn6qa5SARefa9pJ5qL555GzP5dh9DKCE1zeJQ47UzXpPEYVLaFCDA/smQoWpD+GHLMZguXFhoZSXuPMsBW3j4JCQ3n8J0SbbSVTktdMHmWTRj9cyAtm/QpON5VaD7RYqy4AC8n0RrRqrxS4ux4is6eApPuPkuCIy3ucmZ1k6bHnLFbYoPFIIrp24fNRF4XjExn/s7eZRZAdiNl8fwLbV3VI34ry3MosOI5SmU8V14cGJaS2sL1voYPm8z4BQiod08YKblO37LwlInE+j+DIhiFInFmHe+cjT79vgauLX3H6DKPlkicMxuXIy6nvgOIl99r9I5kWsib7cLX7XXhm0itfdcnwmu4aNBh+YqVb0EvyAbsuzzw61/YN9POghP1NBE5l34ClIzTyoi5lZJ00p+Hf3xCk9CSjIIs5LOxmkrPD7gGZGYlF49qJRTL6XnBqoMvUbSaMlg8mn5OlcQK+Q1aUUKD9v81sfmcGM0tr69WnUKVkLHsYDTCfU373ZIsWDxVtcZf+0jP30FWAbHfHyH0bP/cLJsUqgjLjw1r8Wb1xPuTgHwi1LgbOHm8O4DOGxP1hvaNaTHGM6dG2EfOLgySUQo5vYtBXQvbNLNvN7TGqnvsLsH22U/WLGATVK7jNwQ4GQHQiCJ/4Wmbr3FK9dbwciDQL3bW+yVZa6GlmQeeYv8C2P0LDavkCzuNoGq/eq0hYwXk3c1uUExTvH5UNUAlUjbM5jlQSu+2hLinU/D75agOpn+Iy5geOmZJgCsqovJUhKt+juyNPkjOzKL922q
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fl16-20020a05600c0b9000b004101f27737asm1077895wmb.29.2024.02.07.08.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13B8A5F949;
 Wed,  7 Feb 2024 16:38:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 10/14] gdbstub: Expose TARGET_SIGTRAP in a target-agnostic
 way
Date: Wed,  7 Feb 2024 16:38:08 +0000
Message-Id: <20240207163812.3231697-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming syscall catchpoint support needs to send SIGTRAP stop
packets to GDB. Being able to compile this support only once for all
targets is a good thing, and it requires hiding TARGET_SIGTRAP behind
a function call.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-2-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h   | 1 +
 gdbstub/user-target.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 5c0c725e54c..aeb0d9b5377 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -136,6 +136,7 @@ void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
 bool gdb_can_reverse(void); /* softmmu, stub for user */
+int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
 
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index c4bba4c72c7..b7d4c37cd81 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -418,3 +418,8 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
                     ts->bprm->filename + offset);
     gdb_put_strbuf();
 }
+
+int gdb_target_sigtrap(void)
+{
+    return TARGET_SIGTRAP;
+}
-- 
2.39.2


