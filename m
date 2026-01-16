Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C674D4899A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj8p-0002g0-Iz; Fri, 16 Jan 2026 07:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7f-00024v-6j
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:17 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7d-0004gi-0O
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so989915f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567211; x=1769172011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siylqvvbraELN/5iy0HoOLso7sahmO7uGAPRzEtYdYc=;
 b=NOPJ1rIZyAQJSWctahH9B4nWwyXZs0jxxlUVcebxos98C9sEfMJnpexLJV/55pbUng
 dmk9sdS8u2PAgMgVVlIQ4DBqXAHrJN3j9+IAolWH9+gYPBHqWKIN9LnvbpsDI4ymZNYm
 QRUwm986oaZo8Hp4ucsdGnavCqOZnipaii09qeY4mAqQl5cGwklJMZW+PIEjD5m9a0w6
 V8FBgmkz+MZWfzj2FewYcs1MJ8FMPQGxoF9VOWoQ9m6bxCNX2TLLKJ2O9zi8pfWgLD9t
 p1iMLZDXerZIvdf4nsu6sIWyagSnRXIKrYcav1nX12sdl/mNRtMcObx+Vv2M6b4X1vHD
 ImDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567211; x=1769172011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=siylqvvbraELN/5iy0HoOLso7sahmO7uGAPRzEtYdYc=;
 b=H9lMhQVGa2I31LfEljS7ZCKEph29yBOVr6KzTd8Gf5bhLZUhaQ1NzfT36bWJLFuix3
 uMvMgW8VkHK/XSjJ9yT9J8hVBvihT+YPfaJqq/+8KFO8Zc2Ks6+8toILV+rM8IZUTBx4
 b3yQEI2ujUoic1LldErbALzyJxWf+/UJskiGthN28B9hqGJ8fTbLDhNltMToxVjsRPlb
 0MHjv+Gsq1g6PPtyk6IA2eTHfPz6BYQuJX8XX6JRaAneQ7f8lTa3Ykrm/Am9ymOtzIga
 Oa4bU048U391aJHCpnIWSH8+9vOQ8q/oy7sWKTqYowD7PX+kXfzfbMe+B78TDYUhGv1I
 ukOQ==
X-Gm-Message-State: AOJu0Yx48wTstGRxdSHxksGRAndaoME+fs2nd7tsezrXr3zllhBlPgMI
 FNyaFGmXXGaWMs2gyrCi2G8pC2aobhoFTJEvmi9+RQIcA8C58KnfrmDuW7gYtikqX3GtjuWzbyr
 OZMsg
X-Gm-Gg: AY/fxX6gNkAf9jxF5Q/jz29xH+D16RkZWX75jxDUWxe/5ueot8/RjWtl+CF0o4wTp0F
 +ZJmScTEUXLlOPZuuDNgyEIyqXlIZat/4TRliWS94Np3TzcQp7cfcHG91OMOuKAOUXeCoCQrRny
 LuoB1CtnljAZhIPoMsLU3izkEdeoQXGdEyTeeexm4Mk6q5DeRTl2fmlmvBySGHgnqs2EylEu8TD
 8FvCStuEmmn0djE4M6veuLOt+bnCMZGqZ1fS0tJywfNCmRTFqf0ucO3txXbqRItm2frtG67kkTd
 jQNSwnR9LSiKjX3AElmYq3iOuwG3CKIECwwBT/r8Ds4QnS0PDB0gAackQfZ6cfM5bPEGlMJZquo
 8A06OxeKgNTRgoSMd3zYa4XRjT7js4iXw+p0HT1jU9QhfoS0neaeQeJnvf7sva7iEBVG6JywNE9
 89YXb2u4hFRKl7etD1UjwORYybbN4Gtgk92tsuc5pQTJ6atHc4FM42VwrEVJnsbKcDywECzCT0l
 r3QKbrCtKUYeEa1pfHr7ltnViNaX+38BvgqZpPfkSt4ig==
X-Received: by 2002:a05:6000:2505:b0:42f:f627:3aa7 with SMTP id
 ffacd0b85a97d-4356a0298d8mr3229604f8f.16.1768567211519; 
 Fri, 16 Jan 2026 04:40:11 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 4/6] scripts/clean-includes: Do all our exclusions with
 REGEXFILE
Date: Fri, 16 Jan 2026 12:40:03 +0000
Message-ID: <20260116124005.925382-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116124005.925382-1-peter.maydell@linaro.org>
References: <20260116124005.925382-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

We currently have two mechanisms for excluding files:
 * the REGEXFILE which excludes by regex
 * special cases in the "loop over each file" which make
   us skip the file

Roll all the "skip this" cases into REGEXFILE, so we use
a single mechanism for identifying which files to exclude.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/clean-includes | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 5ab3b07196..a45421d2ff 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -104,6 +104,15 @@ grep -v '^#' >"$REGEXFILE" <<EOT
 ^ebpf/rss.bpf.skeleton.h
 # These files just include some other .c file and have no content themselves
 ^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+# These are autogenerated headers
+^include/standard-headers/
+# osdep.h itself and its friends are expected to include system headers
+^include/qemu/osdep.h
+^include/qemu/compiler.h
+^include/glib-compat.h
+^include/system/os-(posix|win32).h
+# This is for use by plugins, which are standalone binaries
+^include/qemu/qemu-plugin.h
 EOT
 
 # We assume there are no files in the tree with spaces in their name
@@ -137,21 +146,6 @@ for f in "$@"; do
     *.c)
       MODE=c
       ;;
-    *include/qemu/osdep.h | \
-    *include/qemu/compiler.h | \
-    *include/qemu/qemu-plugin.h | \
-    *include/glib-compat.h | \
-    *include/system/os-posix.h | \
-    *include/system/os-win32.h | \
-    *include/standard-headers/ )
-      # Removing include lines from osdep.h itself would be counterproductive.
-      echo "SKIPPING $f (special case header)"
-      continue
-      ;;
-    *include/standard-headers/*)
-      echo "SKIPPING $f (autogenerated header)"
-      continue
-      ;;
     *.h)
       MODE=h
       ;;
-- 
2.47.3


