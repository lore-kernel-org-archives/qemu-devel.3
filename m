Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AB4E8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZB2R-0001sF-4h; Fri, 26 Dec 2025 11:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2P-0001rb-AL
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:37 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2N-0007zH-TT
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:37 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso9897972b3a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766767894; x=1767372694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyJJWd6nsb3vVIjG03I94qXcyJYQTcJxW7rtNSSWG4c=;
 b=TKwJDxM5QywlemHZYyK7rsZ1afHbICdYH6wZumoS/Az3PhiQy4l/JvGcsX4XbvHw/s
 xRO2bZadl0NWCtpgCqmJF7hxaJdQWocYS6G/eYAxxwg/kNvnX25IIxpsBYxAdAa6mseY
 wiD7oRB+NsKo9MQs7c7qFcbdHEXyM06ul5pZnkBraVJJMpq+l89H1Iu8716BqK+4XUnG
 GVURsOgpX0ADMuqXd5WYFMNB09/ULoySY/c3SNelwO5IPxzoan2GI5f4A9uFqS+9cNqw
 fo1eAO/TlFaULuVWqtXGNSk5WvvxVCMH3bf8yNNX9BmJF++WEBzVbVmukYeZISm9Jw2j
 ulrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766767894; x=1767372694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyJJWd6nsb3vVIjG03I94qXcyJYQTcJxW7rtNSSWG4c=;
 b=T9NF+jSbpaseeSDSoxW2y4+eJ4DWHWDX5ZC1M1P1+PCBdQ3sEFHI2/V3ByYcHhXziF
 m6kyyZW9JKxWsNTxewbs04TFGIxZtG78S+612LelCKmVCCirpFRMXFkLUHxwHj533X68
 73LUPcJ9HLwGFYbXgk1iWiGFI+U4/q9wHDnZ48Lwp8RWqnLNC83PugC+7xGKXRTwlS/M
 AOTM8sYBTsKXeDK5By+bXDrEAu1h9mMc25BwEscH/tS+FTVb3/QQOcqzdgDa3BB1pXEg
 HR1AmkfZGe0ujFNsPBv48hplC4f+77Hpr2aPo+Sk79HXAn6DIr1MCShYIrOCGFJG0Dm2
 k/aA==
X-Gm-Message-State: AOJu0YwoI34RbiBil8SMIvRu50r4AbOlQwVXXzMEftwsEXBF74JJ3NmS
 FCjpGWSFeRJQdlqEF9LilWFDlGW2ohfgBk+8sIKtB6i9MEiS6LnAEa9u
X-Gm-Gg: AY/fxX4RR8y4RkanpGdqsadkW/zDf+mS03BFYmGIwpc+CE1RcneCZKZi9YRy7xX8Uul
 3VFtP0lF61cQ8mdqVon+mskTlYK8oLU2porulwQKw3yhm6Q0RvfKe09CPnQm8BCKOyenAV9LVHF
 PRrETIvARg+ffEfvTKB66dPkSFVbmbp1ts117oSu+AWtKxpdx4qgks5opwAd2SN9uooQCXpc3IX
 u9jC34AnTasdm7FNrZKVFFT52XD9jaJaRr7NcFXRQVtm4KWwnhwbEmhMomhHK5O0eZ/lz4ItF4D
 eMWfJwVqOOa/V0LLt+rC8XRFJTg+C0/jwVacnlrvfr3OvIN/PtaLaWzgYkan4mP9x080vX3mo0x
 W03/vPtAXNPN4V5268fLXi2ru2GsRJLCKQWwux0A58eo+qKuFfBevtU8oBL2RTYxCYj38D8CyNB
 1GQnbRU5uxmAwi5NkUWqWD7epHkBlTKg==
X-Google-Smtp-Source: AGHT+IGc040HSPQ36mABuPz+HV6AHS+V8VCEo3J0j1KloHTL3yGeT7ekBdfW7lWujK5yci4C1vIxYg==
X-Received: by 2002:a05:6a00:ac08:b0:7e8:450c:618c with SMTP id
 d2e1a72fcca58-7ff664814e0mr22900961b3a.35.1766767894336; 
 Fri, 26 Dec 2025 08:51:34 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f300sm22522225b3a.54.2025.12.26.08.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 08:51:34 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: richard.henderson@linaro.org,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 2/3] scripts: warn on tcg_gen_print usage to the
 checkpatch.pl
Date: Sat, 27 Dec 2025 00:51:20 +0800
Message-ID: <759a2f0f5e046d7767738ebc190c0cd817f6b2c0.1766767299.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
References: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3a9557417f..43d3db9f38 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1985,6 +1985,11 @@ sub process {
 			ERROR("adding a line without newline at end of file\n" . $herecurr);
 		}
 
+# check for tcg_gen_print is present in submitted patches
+		if ($rawline =~ /^\+.*\btcg_gen_print\s*\(/) {
+			WARN("tcg_gen_print(): debug-only, remove all calls before patch submission.\n" . $herecurr);
+		}
+
 # check for RCS/CVS revision markers
 		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|\b)/) {
 			ERROR("CVS style keyword markers, these will _not_ be updated\n". $herecurr);
-- 
2.52.0


