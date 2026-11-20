Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8D60A2636
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kXZ5obvt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUtS-00032d-97; Fri, 20 Nov 2026 15:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrM-00018k-MK
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:25 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrJ-0001sc-TQ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so13431675e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205119; x=1795809919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=USJT1S6huxMumyzeidJeA7o4HykBr8LNJSWIEzw9oZc=;
 b=kXZ5obvtROsL8usmRglsQc2qze+mrCymtWXAw+Nc4Bevy17/gOkAx2UvFdh2nOQJxt
 OJI48NacQmJCezYlO4ceGb4iVOxCzdalVoRKeWLMH7NgQNJrsLjWyI45xJzf049g8iqw
 CelZd4QLwiPVFQ+4kRFpXqwSd47qEQpLXTaB/ly4mLxEeUc5+5sqsbavWpjYOedrNHnm
 hDmzg8owCR3n18V89M4+MWt714BsQWvSMEwWhXTq9PP0/wpsHPzeHet6Tk4RHeq2wejI
 IV74mnYAcxbDWJjDkGaZ8exFbtwnOK7mGlpQ/xWVk6ikhY3nnrQSpHmpq9GIXx+GXHxz
 8jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205119; x=1795809919;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=USJT1S6huxMumyzeidJeA7o4HykBr8LNJSWIEzw9oZc=;
 b=1U7M+keHWXxYgeBq6NBfMISQs8lEx9qlpHxkjqiCGatbSnXGJhXl0RcsmM9UqdI3oq
 ldmeg6h3AM4P4Xgi3UNla0lshy1QVC2lhLbHH4kKDiyr34eU1dj11uM572uJLbxkoUdF
 xmZRUiI0uaBRaqnLFgn+s/gU3CcCNU8yjD4gldyUdvP8gv+QPSFpGIBUiTt59itKhQEl
 uwYQWdMN5qgyscnRXntR5rTTdWudfToqAwIHg4AbkANv+4rVtHLt7i6rw+hADqJ0kuFH
 whTMI9QrD5WjDIjQatGvAFN1qYAt8JFKgfwLA0wBjfBi2WpYm/lGq9DK68AeSpN1CoBV
 5f7Q==
X-Gm-Message-State: APuU4Z+jpMj5cQa1/thjUWNgD8DUX8S5meIwvwNYOHsZ3YwV3y/M5ZsK
 AjE3dU4XnJEggoJ6hczTKidTBEzWvI8tRvOCH4TO1jpiVPnEyYv30tCUuej1uvjnrbSBOO+e/Vi
 gBTbD
X-Gm-Gg: AYBFou0vPyKBckf4nPQewocNfWkPjvk+2H7tFNI4ABRhHR8fIUNc+NIK5XrTxopJ9QZ
 3rf6kgKDsBbj9zPfbCPWyBGgk19PaKKvSJ4+Zpx+kyRIdq1hljZTOo03OIlofSMoUl7ppzhJqYP
 xvpLSCh4KLob6abvunSpzWsxHcrWlFH1oV4Js/T4xdblUowHmeaqXLUS3zRAq2a08JYjw72vG7E
 08UVd0E73qS66mtet9PugcN9oTyEPWveea8BW2gGhCBoS8yIzAbI3rkeT4Kh3LXzP9cJAicJIdh
 T3UujN7lGfUfuHifmaOw5hRFojIkvOWFn0hPIrPuK2/fmkn4wrWDobVjl90hk1CUhX7hPy+iTXp
 fjZvgRt1W3dy05MQh9JS+eXcXE7/VUx3HEwHnSVdzd2umuUQubEMrFpSbXFEd7ugtinhqnhgLGq
 VaDZWzDBCOlrnaM0xtL47D9kxsDW4gtiJG30wBkcy3+ySEW0jGfWZE5I0ETr4MWEoDfu88SwQg1
 ZlTNW8zm4nflWVw5jyyKbo+fJMJaGyK41ju8q6V1YliC9SRasHYWdm2nplTw/2bhiPZ40Z2L6Nx
 GGOGqo5iP0pFaFtkMiXiQ2vXWgwc
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4bb88804d4dmr105570885e9.7.1795205119466; 
 Fri, 20 Nov 2026 12:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm115192725e9.3.2026.11.20.12.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2ED35FB87;
 Fri, 20 Nov 2026 20:05:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 13/22] scripts/get_maintainer.py: expand --validate output to
 CSV summary
Date: Fri, 20 Nov 2026 20:05:01 +0000
Message-ID: <20261120200511.822573-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Instead of merely printing the count of parsed maintainer sections,
have --validate dump a CSV table of all sections including their
maintenance status, maintainer/reviewer/list counts, and counts of
matching file patterns, keywords, and trees.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index a3f64a4b2a0..154f2650f72 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -546,7 +546,14 @@ def main():
         sys.exit(-1)
 
     if args.validate:
-        print(f"loaded {len(maint_sections)} from MAINTAINERS")
+        writer = csv_writer(sys.stdout)
+        writer.writerow(["Section", "Status",
+                         "Num Maintainers", "Num Reviewers", "Num Lists",
+                         "Num Matches", "Num Keywords", "Num Trees"])
+        for ms in maint_sections:
+            writer.writerow([ms.section, str(ms.status),
+                             len(ms.maintainers), len(ms.reviewers), len(ms.lists),
+                             len(ms.files), len(ms.keywords), len(ms.trees)])
         sys.exit(0)
 
     # Build array of Path objects representing the files
-- 
2.47.3


