Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7490AC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWBR-0007qX-50; Thu, 01 Feb 2024 07:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBO-0007oa-C3
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:42 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBM-0002B1-Mi
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:42 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51025cafb51so1315933e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706790519; x=1707395319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XrdlyPxX7fzqYNhg32fjbzatjpy7oOVQl+tyM0KqaA=;
 b=Be7QVy0OcsXBX1JPeM0ie50iabaVOI5Ci8al4DAkdGDMo8wWIIvs7GDvWXnuHwl9Oi
 Xuv+uQLz+QTkOD9H5fZOWlUPHVk/j74nk37WUWNIJoP4F1e88QLAPD8ilqz+DtbOnfFP
 EhJsSJ3Ip/5JXjJt1KfjZ9WBUHBzSuQauWMKhKIrgk3q9Z0jggx6THDscO/PVi7TVBYJ
 sxQ/DTmgPcn+tNhRbI0hc4bn9KtOp4HhwW3VBF+iZAoLaHF0RHHWWoYztBYI22iSlCVG
 6rMNIejYIfdsknIfIxuYaYlwpsxgZgFstHW82edp2rkkOITU6CgI8Vil3Bqr43oEgbtp
 +p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706790519; x=1707395319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XrdlyPxX7fzqYNhg32fjbzatjpy7oOVQl+tyM0KqaA=;
 b=EsrMJFE6gb6MDXOkNp7JfELyqcIdaYGUFpDQMVzgB8libgL9aUYnMBX9oBNDsz4L1l
 0bNEzRRFo9e8J+aW1WOEXmlkO7jAFJXd68P/7kU5Lb2VKAx1FSOvMCdR+ksbJUp1JbJx
 A6XYzJzeDEp5qeMZwD69gZDyx6tflY7+Qg4nCj40lNxc3XFUr6zdq8toiIch5u20BSBQ
 fcgllsqtrmfzFXdFMRFLWbcOHgH1rzJS/TE2qHtGW3uzkKImPSDlB4TeKb30PHj+cuc0
 Pyi9HgXFZ76wJ0LeObQGxDC1dcZMovsUgKN0q7Vm5NjCQxy9zMqTkRBYmPgdByOTV41M
 1W1Q==
X-Gm-Message-State: AOJu0YyI68gzANym5y0h++c6iZMUKDkl4QHib3z5Nv9OH9sq15w48UIy
 GfwBhMQj1QRk5060snQY14R2PtWsmwb8/0fs/kKMA2qQxuCxh+EFar4KhOvl7Xo=
X-Google-Smtp-Source: AGHT+IF4VcnBRVksAEaw+w29deD3wP0OybtEz/LnWIH0KI7WMl2EBZtalb8UQUF3rE+TntGNlHCZpw==
X-Received: by 2002:a2e:87da:0:b0:2cd:10be:cf14 with SMTP id
 v26-20020a2e87da000000b002cd10becf14mr2986281ljj.19.1706790519075; 
 Thu, 01 Feb 2024 04:28:39 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUGFVNVFdNJffY+qNu7kMHsI1cqvd+apCOb/5CIEuNPVG4EavFeHAk3NTyJHf5zaJNOfMrfgh4k7ZPJXgGfH4WrHl4hVB7GHGfmnuUlZnxeTfkdK9pW3LNcvwoxzk4ug/6biWTBAQYzZynRXXDTe0+8oFBXgwsftNgksnrkilkI1jih2IDR1Mi2AuJ5gct7o5l0aqWtpTGrm73maDTsMAU/UZwSZqtwHV1c39dFZUrsFGPC6K8F7kErwWetM7jlVqsJEYUJCV+E7mRTpGQ79btH0QZL6OybOxKvOvfZYxEfGdcsJIULa16xehR9T+BR1aPC2UCJaCU+BoqoThGbN6Y8DEDr7PSVtB66LvjqY1hrjS3FV2g1zM2kz1A2Nw6kJLCPGHuuiQV0AR+yPnROccX+mq67ySiWo3i7ZLHen2k7i6cFbXP0NQNhsbgdGapwYSZLWKbW/tk+1kkgCijNBatX6a3Z+Yz8ZrOeFJ4qMQ4fog+2NDg0UgrwFwm0ymWjKvPcHRuPlxluXz8BGYICB5pe7j+dXoZmxD+l3JUvyFV035phMHj1PpRkUYQgVZn2zig+j0MAResXhmQxoPKW20BqPnv8qIKvu4cWVmn1B0KXeZonvnfZ35NAdsIYbObWnAz/xOJnWBw=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h11-20020aa7c94b000000b00558a3268bbcsm6705553edt.53.2024.02.01.04.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:28:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E3D55F9DB;
 Thu,  1 Feb 2024 12:28:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>
Subject: [PATCH 3/5] configure: run plugin TCG tests again
Date: Thu,  1 Feb 2024 12:28:33 +0000
Message-Id: <20240201122835.1712347-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201122835.1712347-1-alex.bennee@linaro.org>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Commit 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
dropped the CONFIG_PLUGIN line from tests/tcg/config-host.mak, due to confusion
caused by the shadowing of $config_host_mak.  However, TCG tests were still
expecting it.  Oops.

Put it back, in the meanwhile the shadowing is gone so it's clear that it goes
in the tests/tcg configuration.

Cc:  <alex.bennee@linaro.org>
Fixes: 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240124115332.612162-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 3d8e24ae011..ff058d6c486 100755
--- a/configure
+++ b/configure
@@ -1644,6 +1644,9 @@ fi
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
 echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
+fi
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.39.2


