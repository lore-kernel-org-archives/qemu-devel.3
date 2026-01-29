Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FE5D73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyY-0004xw-Mj; Thu, 29 Jan 2026 12:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyX-0004v9-7T
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:37 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyV-0000hM-Is
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:36 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso888459b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708314; x=1770313114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/5IKoHT64XA1F7ETwTeOkylihtCoRO0y3JBUjlvUeg=;
 b=huefIt3qmn10tPnZ/sXHgUfiRTjYm8SLlcMqeK3DALSJ17VWFrN+a7wO/r5xICdG12
 3unHBYii82GgfNzsApyBzKUA9UGSeWk2Uxh+5t04VIAQzxqu5bpQU41YUVeJQ+KosSg0
 jmWQ2EHs4VNB5yrZ1ieKPSxLCk4mHOaFvyUV8bA7E4OwPPYu25yo3TWYYp9MTi75qP82
 6KiiEcspxCzTwqzx2C0x73bZokGWhDElgMzAAtF24eENXBenrRFCR73saVKLdajQznNF
 1nIymteHrIh2Pn6697ez5Aa+Q/cqYg8sQFygeZ+8pRF56dIgwCWb6gFAvkJCEvs0v0ht
 EK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708314; x=1770313114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5/5IKoHT64XA1F7ETwTeOkylihtCoRO0y3JBUjlvUeg=;
 b=mo6eJKSJld1/NpAYhcOrK13GWlNfYRbyL7o4qOQhRSklAH9JoZXuuCIsyAw2nBYsjR
 8zY0/jRj5fFgca3a4JytWgY9eXwz77t3eV/LDZeV4Yl72X7d3/UR81Q5eU8ualBb+61X
 4iYVNEKhUQ1+4d84Rny5g2305PvqgVc2XiwtbN0VISh6id5EYhJ1zxFLlQtgb7ZQc+mc
 E/hMzOvnGtir6OvXYgpZH7db1hSL0Uv5EFgsZpKh8lsDAJ5yfOJwojcDsADn5xmVpEEq
 856tUhAW858OHVxjXlT0uLkTMDgKZVH5cwMSQGbq8XWhS0+bu7+1WMgu84erKJgjaOvf
 4opg==
X-Gm-Message-State: AOJu0Yz2S3yOcY41L7WiOBWXUw1IcHrdc1dhWzAV+4TgwHNTcZ6CNsT/
 wdL5IoVQDCiJTjEW0ow/Xtg/PaZ5bZ/DK9krabiWEosj9ikBYBy4068IfRywmQ09JwmSorYF7BC
 dy0RN
X-Gm-Gg: AZuq6aLORJo8qqbP7qs+LMEIjSRVO/VtCJP7SRlzisX902rxo2Wvp9mFyOgT3bOyLiw
 oZyLaqOTptNkfI2lPRLqp2JOqytwiDAiTyqgcr2JvTwv6IpNNFqKtS2Z9276DSHRs2rsNdFFd2a
 ng77yPBZO55RTtZeyrNYdmJLbXsR68THC4C8ILaf4c2YuKQ54OeZE3RmcJh0eiG9p3hWhlWmpLm
 KwEc6BzHXgjHRd5B5fSWG3kS3qxAOLEFbKeQEYGqqHCeXef76BPkXTFnrFVVkIbXBJg9/3Ym1OI
 70rAKJW96ZDmLVIpVeN1T2bs9lUJ++tSlrXwGtGuIJes/KlfMxXcx8msu42L335K4Q1fAmVHC/p
 NDT487BPRAd9VenAKNXyQPc8KZgTKVf1N0q62S0ykw3hFeP5O0LvIX95hSBfdd214HHrPI7psi5
 RwYSCxBBpQ8FKXJ8zUfOZ/Vh03vZa4+FmgR+4we15q53RQZjGe47hmtSJ+xzcs76fL
X-Received: by 2002:a05:6a00:1f03:b0:821:8ead:3706 with SMTP id
 d2e1a72fcca58-8239201d8edmr3586819b3a.4.1769708314012; 
 Thu, 29 Jan 2026 09:38:34 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/21] plugins: reduce source conflicts in plugins list
Date: Thu, 29 Jan 2026 09:38:07 -0800
Message-ID: <20260129173811.138036-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/87cy2uat5e.fsf@draig.linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 19 ++++++++++++++++---
 tests/tcg/plugins/meson.build | 13 +++++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 53d52c97967..099319e7a17 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,6 +1,19 @@
-contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
-                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
-                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
+contrib_plugins = [
+'bbv.c',
+'cache.c',
+'cflow.c',
+'drcov.c',
+'execlog.c',
+'hotblocks.c',
+'hotpages.c',
+'howvec.c',
+'hwprofile.c',
+'ips.c',
+'stoptrigger.c',
+'traps.c',
+'uftrace.c',
+]
+
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep.c'
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 303f97f9679..c5e49753fd9 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,5 +1,14 @@
-test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
-                'reset.c', 'syscall.c', 'patch.c']
+test_plugins = [
+'bb.c',
+'discons.c',
+'empty.c',
+'inline.c',
+'insn.c',
+'mem.c',
+'patch.c',
+'reset.c',
+'syscall.c',
+]
 
 t = []
 if get_option('plugins')
-- 
2.47.3


