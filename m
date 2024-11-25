Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F44CD58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFats-00040o-F3; Mon, 25 Nov 2024 10:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatl-0003vj-Fx
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatj-0001kH-Mn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:13 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so3214875e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548070; x=1733152870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aC/VsGSzvY9jjiY0UK+gHwAgON+jU91JMadHvfV8yi4=;
 b=Hr8rdluRTnx1CnVR50ZV8A/xvZPrDwH4LEh9pQSyTKJziNgq4uFAp5zoRtR6H1gjCV
 7ZsSmkADmTAGDkdka406w6xmS6M0mWU9eTjJ2L4VtthHEHAHYltR1kHHL/MKpNVAWTbu
 owpfH9jMEzryV77/ld3CzT8h7S8CucqXY93mUP1VC9w51EWGPENzxehFs5MLEItn6utC
 UJb89stJLaV97NE4ocNM07BWFKmIy01aiXNBp3PCIV6RRDEsIFrQUu5igOoqk2ol3iaY
 zjbZG8LRdsEB5RuDxr4d5EnEvOjlNOn5s+ZTtdWhJKGTFivPipBNiR9uuPBnKZyTwmSV
 Msiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548070; x=1733152870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aC/VsGSzvY9jjiY0UK+gHwAgON+jU91JMadHvfV8yi4=;
 b=A4LjNo+Ird6IwYHWy1aQ2fhgrzLf8E6N6B+kdlxfag0qulMS4FuNOnJ805nxAEh7p0
 M/d01JIGci53bVL3+1Kktw9rfY0cVf4CVApkyA6lOcTmmg3xZ0g9ItLO4332nJsAoa3n
 Wfhzwsw1xeejLEOqZsaxrKvpGkCv3JYPOldRhMg21AiwQNRk3BPESj3BxpHgPXqKDUTx
 TX03jvnfPkn9D/zgaKgQpMMyi4k+SLqj10v7mVfNgzeLhV8FaJXqe1z3agMUe90of4Bt
 MhJLUsz+cYQ+YsS5ecB8NABwquHgCbNke9quiFQEXFmMh8GelaLWlqGqu/S1emn4i0Vn
 rh1A==
X-Gm-Message-State: AOJu0YwNIifxkDbkuDCIUi9eD+YUqLP/CJrhuAPTkD7544SLK1axN91z
 +fbWnsx9Wn5INJMHbccFHfsSDJnqOpD6/6QfN7+DxX1zU2NgSb3QpLn9cCw8skw=
X-Gm-Gg: ASbGncvAPH/4c1S/HuhkY7eYU4H65Vm6A+tkv15gKP/v85fLLmzRARZvfyqFqMektDP
 ntZE1xlQV7DvxSV7b9EgHfI0KwUnV7059vhnlBBqyRWMJuR/31PJEPgzM0Qm73XQ52GPxZapMMF
 0RA24qQ6m2NOZN6yDXmzZB24Wmkyp81f5LlUVd79ned8R6UJWC8lmxsB+svfA/rnTXAmLt8uD/T
 KCHstYSneWQCBpAf2/dl4HG1RqF0VXPKYIQPLUqQLSV6bez
X-Google-Smtp-Source: AGHT+IHJrmQ5QF4bYexo9G2WUBUBTr3hQ3zcZQBADafvkAjFeVTdQIqOPckPsgDHClayM9zjrZD8EA==
X-Received: by 2002:a05:600c:3514:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-433ce4250dbmr123903565e9.13.1732548070132; 
 Mon, 25 Nov 2024 07:21:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd7d7sm199298425e9.13.2024.11.25.07.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C8435F9D1;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/28] tests/functional: remove obsolete reference to avocado
 bug
Date: Mon, 25 Nov 2024 15:20:43 +0000
Message-Id: <20241125152105.2100395-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

Historical bugs in avocado related to zstd support are not relevant to
the code now that it uses QEMU's native test harness.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-7-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-7-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index f05aa96ad7..ed2b238c92 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -39,7 +39,6 @@ def setUp(self):
         super().setUp()
 
         # We need zstd for all the tuxrun tests
-        # See https://github.com/avocado-framework/avocado/issues/5609
         (has_zstd, msg) = has_cmd('zstd')
         if has_zstd is False:
             self.skipTest(msg)
-- 
2.39.5


