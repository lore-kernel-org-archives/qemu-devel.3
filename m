Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD0F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv625-0003yW-SP; Tue, 24 Feb 2026 22:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv625-0003yO-0N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:57:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv623-0001hk-4h
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:57:52 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483a233819aso60573065e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991869; x=1772596669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/9SkafDQ7ZtmnOiSLZrHFDCEI0mCaP1Z+TZ4BeyaOk=;
 b=QXk4wB9FU0j4wOWzg2GcazAoqnSKm9AUQSxNgT5e5FaP46Z9XXHCR53WwLik48KLQU
 Q0rhA/iFFCmnfIpdAorQvXmLuC8W9BpkTN2n2CoIwuGbXWU8VtuPJZBLQ8RXDxb2ucLn
 mBFF2ZCz2Xn7xRCoO3NKf1ewC/0v7DrOU8fiQ/qlvklCkWIUqS3FuKk+NHAb65ZQvfvs
 Oo5iCmstMf0pje4nYAuboBizM01UuUo8EkTGrkI2jFdhAQVsjNHwl/gUaW2+I1DRL/om
 rJ6zhZQf9RdoFa9eB6BrE0FsCfINIuW81xkxPjkB4yv2UBUXv8JoZR9uYOEGDRzONd4G
 x/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991869; x=1772596669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/9SkafDQ7ZtmnOiSLZrHFDCEI0mCaP1Z+TZ4BeyaOk=;
 b=Q3hISZceTj3EvWRWKZ6YwQaUMzUf3Bvc2CpfaX6FM6wb7kRcu0eAeDx+8UrrgyjRlk
 f7nIyXnaw7vX1biqYWc3PPn3Clu8LePap7eesZWSvhXAy7g9q01+t3fJDvI0+3UAsnCp
 nirghAK2vJJ8E/395MNf9xEU/Jejxn7hLhamtNVQHVhW7vRjyG01n4sKI9Wf7bBTAcsG
 4OXYSUazQ68dRvWmfzIZX/Or8rQiEgehLSjPfgDqgsO9kIQHeBv7jZ3xLIcPzVOELDFF
 Xz66Drf+44ymhKFNNrx6suf4spivdGScsgzQNNKbbLAFhz0L0iz4/wt0fWaPALH/tLbe
 oH9Q==
X-Gm-Message-State: AOJu0YyGMVP5i7UbNel6UvhFbAgsfbwAzMizp+46fTGcNi4E1X2Gvikf
 TT38aodJXS0Pp7JYrrCl7aKEMWZkXBDYwZf8UYx0xGPyc4sV5RrmLBtTfn2qTYr/N/x+LUtUrOd
 AlEM3ui4=
X-Gm-Gg: ATEYQzztTT3TEQ/QyPD4pU8uxCLjr0x/nEeEnD9Vk+JbmpZP77pE6PCLWfgy6ufWFiX
 UCCXVsB/jjTrwG3j6HZdYRktt5Vybskvu50GAXtoB8+NLZC4pVI2qDxr9RNa7e93n2afsbjZcXU
 WW9Rbk3un6pSv2QJMjFUAldw6akKksf892w3lY8PEfu40ZC3mUoYaGPwC7PeGCjpkjTTHdZrTVB
 yz1AxXQ6Qt89CZp+wKjIOu84YxqMsI5E/HfGEGSmVi4/McoWlJMcakO0A5djknWiEk6MiPsYbzV
 VCTbinLoc9m6O6wzxdkbJ/cnd4E7DJp7LxY/9kOIkPbozUyrSbawbZtMoy1w41JmED36iofgD4q
 U/fOFhsPeyDSjOFT5TOg88sMzqw8WjGJ7goKeYKApIFqKDjGDy2j4/XDKfrMaqZGJrC/GH/EOF2
 6E9s4RdniDFGVJSmvacz4W+cMlHo+SaT3U3kbyW98hvff/wDWjMLDPogUhC+kZL1gxAaTglibN
X-Received: by 2002:a05:600c:4e8a:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-483a962e37emr230339405e9.19.1771991868608; 
 Tue, 24 Feb 2026 19:57:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm98226335e9.1.2026.02.24.19.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:57:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/11] meson: Include various directories providing stubs
 before libqemuutil
Date: Wed, 25 Feb 2026 04:57:29 +0100
Message-ID: <20260225035739.42848-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Stubs are provided by libqemuutil. We want to use the generic meson
machinery to provide stubs once, instead of per sub-directories. Move
the 'subdir' calls earlier so when these directories are processed
they can add units to the global stub_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 4ffbb96fe49..db051a1b87b 100644
--- a/meson.build
+++ b/meson.build
@@ -3725,6 +3725,13 @@ subdir('authz')
 subdir('crypto')
 subdir('ui')
 subdir('gdbstub')
+subdir('semihosting')
+subdir('audio')
+subdir('io')
+subdir('chardev')
+subdir('fsdev')
+subdir('dump')
+
 if have_system
   subdir('hw')
 else
@@ -3770,12 +3777,6 @@ if have_system or have_user
   subdir('target')
 endif
 
-subdir('audio')
-subdir('io')
-subdir('chardev')
-subdir('fsdev')
-subdir('dump')
-
 if have_block
   block_ss.add(files(
     'block.c',
@@ -3845,7 +3846,6 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
-subdir('semihosting')
 subdir('stats')
 subdir('tcg')
 subdir('fpu')
-- 
2.52.0


