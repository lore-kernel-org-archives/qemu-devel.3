Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365C3EB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuby-0000OM-SD; Tue, 10 Mar 2026 06:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubu-00008o-Eo
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzubr-0005vX-RB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso7195625f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139602; x=1773744402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BWL2mBfMVFAkbW/5SRGsHvOYhT2PfmKXcQZNTCwbcu8=;
 b=Y1mh2m3mIr03jDz7vB2WjXcpLdoPWiNPvBxgUCbXBoA9Rmo+GuImaWDVV0jb3QINSb
 oERA5wD9Mw8ikMHjXuAnspqGxwCNlNnpOZrFfRUljWXfaLVjrLM91yAnnCnquVtgrwDp
 8kaCgnQMOTjyWsio0DSWYW7k9Nid8CnUMu5ILQH1mfL+Kbth8kkwyAdHOLbrqfTVAHF4
 wWipBtmsMmREXynwezobtH+YTppAdr8UuiSIKwZnLAK6Pyd75mKhR1dT+FsKXpjkkac4
 /V2pxUNgtlF1sTrE3q36qs/OzT4hqICdtyigB+ZYByAJSJxAbnKFPqSEASJp5ecdY9fn
 kMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139602; x=1773744402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BWL2mBfMVFAkbW/5SRGsHvOYhT2PfmKXcQZNTCwbcu8=;
 b=i+lLmmCJHVg8M2xbMSdQkuzggS3rown2t+V46tv1MN81luU+GbxnaZJxdggn9jLaBO
 V/tz/n0Gor1TaO9UXAdl3CnY+/k43DssUirKAEjx0d+OnIyPkbFgNUPs/6j+Pt/MRK3w
 18rm+dsOeYV5n5NkXAPWE1DE/3StmZR/XHHWUpqYAKPLbPw9RrE51FRqc+Ym25z/bek4
 Huuxx7f5LEDZFtDAthfpd7rPqLsVLwyHIXIfl2HCpWElbhk3TT31ESujldfssaiSNroI
 AK/A7+LZHa59YiZqjQSHhyFmnI2J5mF/R8mfIc1btf6Qmz1i+lxK5VJmLl1GJIkRKeLN
 NoMQ==
X-Gm-Message-State: AOJu0Yyu78gheYYOlN8BtzZYtJdmVZKxQbZMJuJuoTv2Cd+Ogk5smcuQ
 If+putlEZLZb8Vlw92nx+Zpb/0jEbwEIkx5LZGqfb745Wnjo43+RkqA7gjlDos1AbJbTQCR/voa
 ocdHVwSY=
X-Gm-Gg: ATEYQzxGBxTvVlXMGXnEXdzjdwdaUWT3HpCplaLymlIuFA1d+kCpwDTPJr2Lie+ElLp
 T8fzFb2DaAF28HGhOnAJB1zscxm7yjqkgbyFM/NNw1bZqUsU6gYTJmJlH87MQaIqQUV6KPb9Joj
 6fhploGvPoEQ+QycjpC5BrPyrIRjAw5q+yb4dCtqEnXCeU4b8KKz4jHmy7olws0e1b1QyqQB4Lt
 UgLGBCYhUxh63REEt7j8fKdIE3m/CrE4Yl1yCgJdm3Zk0DkwwjU6xLyDnruvwHj/srgtY1rPpZu
 crioedI+oj74TrUiTD8rJlmk80OIQmhNJfdHGmxtMX8aWZSUCOIoqbEP4GSHw0COZbp7H5GApJd
 FcqxNHCLmzbzM+CCM6lBkjL94MPdZSDegM6nsoUmunDlUz+RqV3MqwFweNSdWmQRWL8YTs6Jhos
 qEURb9y5MLDtM58ZkRdPvGLt+dzvbdIVpGD030SvXn00keg2hwGbJmr22J0DiHiH5+MN3rQ/Gx
X-Received: by 2002:a05:6000:40dc:b0:439:afd8:622f with SMTP id
 ffacd0b85a97d-439da55536fmr27119066f8f.3.1773139601854; 
 Tue, 10 Mar 2026 03:46:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadac2a7sm35944679f8f.15.2026.03.10.03.46.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:46:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] accel/mshv: Build without target-specific knowledge
Date: Tue, 10 Mar 2026 11:45:08 +0100
Message-ID: <20260310104511.12670-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Code in accel/ aims to be target-agnostic. Enforce that
by moving the MSHV file units to system_ss[], which is
target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225051303.91614-4-philmd@linaro.org>
---
 accel/mshv/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index d3a2b325811..c1b1787c5e6 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,9 +1,6 @@
-mshv_ss = ss.source_set()
-mshv_ss.add(if_true: files(
+system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
   'msr.c',
   'mshv-all.c'
 ))
-
-specific_ss.add_all(when: 'CONFIG_MSHV', if_true: mshv_ss)
-- 
2.53.0


