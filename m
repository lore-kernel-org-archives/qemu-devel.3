Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2102FCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJRi-0005Hh-TR; Mon, 12 Oct 2026 13:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRL-0005CQ-8v
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:03:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRH-000758-TU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:03:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1222329f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824624; x=1792429424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EL0Vj3lE1wOMC+825DlATKPDfWDFpznI37+dufm74XU=;
 b=axhKCqM6I0QLBPKTK9HAau1yOEKl4adaHrC+cRrwtTRxs2biOfmqfqwZ5THwwY7Zbk
 doCKiave+rs3Q4METt+rWFgayGmMzvijZnsmk8KCbmkARHIse65t1hvSB5jt6P3kulhw
 w9o9zEh/znGj+dUn2gdhGhQAsXLV3KoVv5yUr18jMH7FEJn/JUCt8nlOTnVU0ZA5FEgw
 yEDbc/GiJcx6sjGQcN/L6QlwGcczTHENo/oskBolPUig9zHI5WF/gptjNFmJ/uQ85hi/
 WVjgZRTO67pd5g9Z5i97X5sJwv3dCA0PGS9+suswgjyRC75JxL2pzyah0xXGV6eZP2cG
 zcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824624; x=1792429424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EL0Vj3lE1wOMC+825DlATKPDfWDFpznI37+dufm74XU=;
 b=bFSoKaWMq1yIBSNP2kKzdpZzJqOBLSJWGOi2Jdy/1zfOMYh2pYHuo14CuoXE6fzQGH
 2Eja6+U8QQfOd0gYTmpRuWHvA8GDvzD09GOLHs/ZJFLNfYa+ukc6eTS3VwiaR7PLgAZe
 xSP9p3HtRGtA4aAgPjRLU8CuFAMNamcjA/OfhMiB7P+TASUmSMlcX2NnMW0+rGY8Cz+q
 +hPRXo0zTF1ko5fBBzcYo/iu0yjL9zSNOlHIaOPiJPZwTo16mN9FL/AP+kogkzt8H7TB
 JRaG5MdjwB4UqFyOdE6+PCgOZSn9QE69zQiJKg9pwi1Tn4CjIHRuR/WmdVUgkS2ADCdy
 J5cg==
X-Gm-Message-State: AFq9FYK7F/rb9sAqNTuMmuE/ua43c60lzfoubbAXmDPQ3It5UjCEbW4T
 xHkvlD3bh4Im8kQuarT6vobsNmlBy5JwQoqPrTJFiF556EmyITcwEfxPlnS/cbh40Vs=
X-Gm-Gg: AYBFou28UN6xHQmKCWKkzWQ8OqVTy1fBPjIYfhbG2aqSKv1gB1XkN9hfLSq5IVEXB0j
 xmjeoHIAPAVGfudlZ6ygFuQpRhaZxmwLKeoX+S29Bs04nfQ5N+dbib1LztDUfkWvQ4MR0atXHTP
 rRrtu6Nd4VlK4Si6MCDcQSKcSWhP8AfOdNN+KeZ9T2ArlLyne5O9D3Sk+QXO/10amrQFONbbLq6
 VoLEGcm3xfGV3HHG9rY7rE7cDYlVuIIRAV9BvAYH2+3WXT7lGkWGxgQMLWgpT4HXUmFndnYXMun
 4f3Z2edjBAPUwG3NoXSMpY+2cExBMYH0L58utLzC0zyRUPnYm3JmzfSjzqM+VNMCKLvKZ+WgxyD
 w1fUpC4bx0dOGcTc+AVbqDDjx1N5ntTdaQH1bhoKhJi1prf2VR8dPVg+LAu64ZYC2vExhCCDfMR
 tbeSm1ntJWvGAcz6mXXyprObwmNis06Y5Mym8q7KzHRYZsNghF80senaiyJVrbm8z7q/o/5w==
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id
 5b1f17b1804b1-4a18e47aa9amr208081735e9.6.1791824624010; 
 Mon, 12 Oct 2026 10:03:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm456786f8f.14.2026.10.12.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21E9A5F8D4;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 01/16] tests/functional: test_acpi_bits requires TCG
Date: Mon, 12 Oct 2026 18:03:15 +0100
Message-ID: <20261012170330.1144446-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Running a full thorough test suite on a KVM-only build fails due to
acpi bits needing icount, therefor tcg. Declare the restriction so the
test harness can skip it.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260930164649.433573-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add comment
---
 tests/functional/x86_64/test_acpi_bits.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
index ec716d643bf..d445660f0ed 100755
--- a/tests/functional/x86_64/test_acpi_bits.py
+++ b/tests/functional/x86_64/test_acpi_bits.py
@@ -303,6 +303,9 @@ def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
         self.set_machine('pc')
+        # see icount comment below
+        self.require_accelerator('tcg')
+
         iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
-- 
2.47.3


