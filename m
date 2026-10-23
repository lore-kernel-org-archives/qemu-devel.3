Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xhtUPgaC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeJ-0006eL-IR; Fri, 23 Oct 2026 14:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeE-0006Zn-Ga
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeB-0004WF-He
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so10747835e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778741; x=1793383541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aqn/Zq2HgMSoaR6v0Q4qbOkazxeZCh5H3+1qMsNnhRY=;
 b=xhtUPgaCmO38w0okJNQ7fhKBKB3Bfhk11g2WIP/DLrc6Siol/y5s6adkc2QbAnKWqX
 iMlcRuzoFsQTqRkcf9zZYtTsoJVMSV8FvsWYL3nH+11Q07RC4tuWAP1hqnowH44IB6Sv
 OnQf/ftAVmv1ACqZ8P9mfJOdUFJTObiKmkBF4c9AR1OPcz6kRlvXGfYqOQvBetVsaLTU
 nwHZwz6llzsiJp2hdCOOtkEie9R5fWWA/Dvg+irg6Q6I1EavxeajfdJcCiii0XAKCGep
 /4N42LZH6FFhIcsOpdHfHUQa5K62vwZsEG4p3bWXe4/fo5MPmJ/q11dg3XKgdNFwNMnB
 yoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778741; x=1793383541;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aqn/Zq2HgMSoaR6v0Q4qbOkazxeZCh5H3+1qMsNnhRY=;
 b=NlSdGnT4/nalTbWQXxTh4tNWfrs08Qq8GYijC/MN7JTntj38iYpSlBvwBIro/INMT+
 UIAu/VAQIL0hGbne/q5YVDbqeA20hp3cITMNMu/Zpdhsyt9YUoJ2lb4Eq622ZBTo1YVZ
 DdNDcfCmfD/jq9lURWcXo7se2zsqNMWDxWBx0K97BwRrwrTicwp+R77ss9fGPfBLdpAk
 +EzDDw20P6XgbKw7EfIbDwxJRaNHdLUP7BA45X2hyOl/itYuwgDowtBiNc2fSve71qHC
 1Px13ZSY4rrhVEk0R0YLLh4WMlh6T6XtIzlDhefIZBA730ukh3cEwlW3ZclB1zRj8qAQ
 bKIg==
X-Gm-Message-State: AFq9FYIZVNMyrUTcMrd+S1eeaMH3YNVfxu9nE2PydJ/5U7UBbw8Z9ojp
 6WDXCaDSUEWa+07Q2wzUzZpVodVC+6I2EKiwhcDTg+rdf8ayUzK0/ih9jM3ggONCxJU=
X-Gm-Gg: AYBFou2fusQsgGIkAB7MPgRhkFUwesoR3O7nquI93qvgwzSTO/0X/wtcQPG4HEr2+hh
 dLvz8WrDpndjB5Gs2xEo/4ydRLExOjCriDiFX21ECmSegzSWdhw0NigFbV2NpPawyQka9fBkTn3
 rtT+1eZssV3RQOSUbWy2pS3xL5N9OvVbWGZkN/wscx/ue8/YdGQlGwTZbb/nb/6FIDToKf2SI/S
 4zUUkxh/D1NdGgC/r/vE2GJ4/VYgTAD39NI8QPdWuPCYbhVa3Zpvo0rCiRg5mpQGk9bPYMhU7Ba
 xot62V+k/8kKB8INyCO93OIAonP6hCMIF5lPWMqNmZwX9yyFk9hWx3l+LXU15VIz9M+EZDPhf7p
 uLJNv4qCypKeXO7OlqZ/YZCMxy9LZ0OVz5QW4FeUANERXc4PjmkE6JQuxoD9hyUchKmdWhzw3Q7
 jFLbQRYGAKpNctB3q8qoeRklZY/Ze584jDuKN19v6FoYGWfaSDY28Law1N9Ju6kaW24V1BLm5HS
 udNORAGZzQMBC8QIiHYzZjkpVVYkKyp74fhJNCRMPdy7Z/5AusDXNc=
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4a211ed7602mr48816185e9.26.1792778740872; 
 Fri, 23 Oct 2026 11:05:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312eafc80sm30542755e9.3.2026.10.23.11.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 732665FD93;
 Fri, 23 Oct 2026 19:05:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/19] tests/functional: test_acpi_bits requires TCG
Date: Fri, 23 Oct 2026 19:05:19 +0100
Message-ID: <20261023180539.1574134-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running a full thorough test suite on a KVM-only build fails due to
acpi bits needing icount, therefore tcg. Declare the restriction so
the test harness can skip it.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


