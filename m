Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD95C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 18:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLnAo-000201-Ei; Sun, 01 Jun 2025 14:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAm-0001zn-Oc
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAl-0002oF-3X
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c73f82dfso2851000b3a.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748801557; x=1749406357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oIlN2tt24vpImxMl+WQkZE+WQO/+mc93/aunqiU+sM4=;
 b=C3I+5aU4rBs55ChP/5bnOyoP0DTYv8b5rsj+WEuwlp+7KaMWzO+hX5jzJ/IDL694Cl
 RlEQIn8velgi6t68d7jUHbgs4QGua+StOWGiRQUIcpyJK/Ze2mypjVj09YN8Eg5WoE+E
 1lm/jL3tXkItbWPMjjc+341Aeox4i7z7x18b8tY1CyqF4mVemnW6UnBB/i8G6bDyOnHJ
 7mPV1+HEzPiWZmwiNdr+JeUuS6f9dQH8MITzVPntF+ShSV++eCKazrlCf8wlkFzr/JvM
 p9JadZKd+6iBYK0mcpFTVYbYz0W9VAKpAqBOdDwANuRT8SsGgWgJ0c3Fs+GhVChTrHW0
 12QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748801557; x=1749406357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oIlN2tt24vpImxMl+WQkZE+WQO/+mc93/aunqiU+sM4=;
 b=S2Ibbk9CBXVyTNRT43Uxry1Yh25r6fZY6s4SXv9O4lk89kUo12iLlL9e5TeQ3Rf0UC
 iFhVrr+EZJyHnPKN/zYhRcSn9h6jybt7X5Kb8QvmcxvkHFBLG+jvGXVf7rbvpLzg/8rk
 hVPiVWpYtghkbo3svnb3iMTuPqig4TTeckVL/Wk1R0HbZuhQmUhlC9NswXKfdK7MoxDj
 f+ZD6ZwI91RfDyZ8HMazGEbZR/GiLkl6Nq2MO9l1HAPa+Hq0u0KXwbKt8WUnNpeTwxgL
 Jet4rkQU+UewNTMIVNbnDITfblVwKQQFIEM+2vqxozp+cpiZpDGfp3MVISaknGgJlTJl
 kg6Q==
X-Gm-Message-State: AOJu0YyjyiBy41ip9kD0+5tfEKoIRo0+DvgSynFa0kZSzxjBXU7+5MM/
 Zf0ZOaH3Z2ETbwke/TK9KnSapXiw7huBd7V+NlHdrfV8FWJX1ty8AFHWgSyOki2/zfq92w==
X-Gm-Gg: ASbGncu25NwV96mltPjq58ePuQnMDjeKT/sHPI+wBUtuSMBFxp3fXLTRAczSAncqwoS
 4F/2jrGUI3+SOUbKu27jDO4db0E+pICTF2pBr25YwQUIn+deNdakwPL8ay+7OlEJXEvkyPW44Xm
 D6c0TqH5UAoFkR0XYMsqx+kik9jMaIW1Oat7bfWm4FgtfXQz/GLgGoV1TpA1LKCt9NpF+ekxT2P
 GUp60B5JrxUQs9c21WPlrJ9TbzuNSMZjYak/0UwEkf4O45vEUychzHJ8KjjttXSuu606WT7w13i
 j/BxMrRe3E1FDrGuc12pFhZeLZYOPrG0QR2s4vNN4MGM4WFNlrcDdZgm9tzNdHIg1DxFWzh0
X-Google-Smtp-Source: AGHT+IGeJ3mvGHXpOYjm8rD1lI5FQTniAQ4KN6xnkAHhzgeUeFH+N0t1nreLpOCYfRfokLOSTYqUNg==
X-Received: by 2002:a05:6a00:2e24:b0:747:b04e:941a with SMTP id
 d2e1a72fcca58-747d1ab0437mr7160759b3a.17.1748801556723; 
 Sun, 01 Jun 2025 11:12:36 -0700 (PDT)
Received: from ubuntu.. ([49.207.58.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afed4bafsm6189191b3a.79.2025.06.01.11.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 11:12:36 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Mads Ynddal <mads@ynddal.dk>, Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 0/3] trace: seperate cold path of trace
Date: Sun,  1 Jun 2025 18:12:28 +0000
Message-Id: <20250601181231.3461-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch continues the optimize fast trace paths started in previous patch (trace/simple: seperate hot paths of tracing fucntions), which optimized the simple backend by moving its hot path to the header. Here, we apply the same pattern to the log, ftrace, and syslog backends.
The fast path remains in the header with minimal inline checks, while the backend-specific logic is now handled in dedicated `_log_trace_vhost_commit()`, `_ftrace_trace_vhost_commit()`, and `_syslog_trace_vhost_commit()` functions in the .c file.
While this doesn’t yield the same level of optimization as the simple backend , it improves performance on compilers where inlining is less reliable and reduces header bloat.
This change also improves code organization:
- All trace event checks are now centralized in headers
- All backend logic is contained in clearly named functions in the .c file
This makes the tracing infrastructure cleaner, more maintainable, and better optimized for diverse compiler behaviors.

Tanish Desai (3):
  trace/syslog: seperate cold paths of tracing functions
  trace/ftrace: seperate cold paths of tracing functions
  trace/log: seperate cold path of tracing functions

 scripts/tracetool/backend/ftrace.py | 44 +++++++++++++++++++++--------
 scripts/tracetool/backend/log.py    | 26 +++++++++++++++--
 scripts/tracetool/backend/syslog.py | 36 ++++++++++++++++++-----
 3 files changed, 85 insertions(+), 21 deletions(-)

-- 
2.34.1


