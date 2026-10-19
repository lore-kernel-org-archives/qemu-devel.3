Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14A606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vvajsxPW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt1Q-0000hc-JI; Mon, 19 Oct 2026 15:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt0x-0000Se-Sq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:22 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt0q-000342-Ok
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so1606571f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438031; x=1793042831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KAs40TV+PDaQglwa6v2de1/yb9nyml5tfy5LFR8T1zU=;
 b=vvajsxPWwTyZyp++ABj+oabCuVASf+/t/AFW4eieesDblqsqKVniRF3scGpexxi+96
 t4Ri3CKxYobysDCHUSy5T3BbTFDugKVmpe12Ug0cBVu/mmEYlZxxSOjpcSm3klUqgq5K
 EKBH/TH7ZJc7o4NGyjSm+bBcTP6I8rsHZJSWRA0YU2Sy0NnM/Vfsai7zU7cb0GY5Fg7O
 QxeBL1sUIf3ltP/WnGjnk2iEfdhd61dieHmU8K+my4JvFPD+iodvvJw5qrGXGotrJfSM
 8duReNFe8G6H0+qJ5OUmYsmqOHTw80ZGAKqWJid8qwoqnzGaxNn3V2DMyZCGVwKX2ete
 laqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438031; x=1793042831;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KAs40TV+PDaQglwa6v2de1/yb9nyml5tfy5LFR8T1zU=;
 b=fcxJ0x0LX9bhlGh4Oa15+Der4hLPHvxf5dc4yznJDuZ2my7uHX+x7zaoR6S7vPGicZ
 74VPqkrHZQ+DegtL5IK1nd41Lw63NS7olWl/Csxyzq9gxEJO2QPVNwUn0dBLQZ3p31z4
 ODlIaTKZgHHhCB1hBP9MA1GT6DiSoG2FoMikM/zaQqEY+qp9o9CQv2vWQuy2K27dRGbS
 r4nunqceN7ykc8gJsnLtSrirt7a3OcbJjlSgty1Vrt/Nh06W7y+mKRObBgrTLo+Cpn0r
 Z4pUQIP275eQUXaXJ8xsUmhXLztTfCVlGbmocDlingXt+ZpN71fyBqbZQLU9OvJgka5n
 zalA==
X-Gm-Message-State: AFq9FYLxDboeFNyJb/aEi+hcHQYq3PIZecBZcSOQBD6ln2p+sq38Q8R/
 3yaGeuq8U5lzp66DH7NxVk8aGMdSfuneWo3in+/JyTy93QWCJbbRUPWTBWOYBMxpAaI=
X-Gm-Gg: AYBFou3iTrFgSLko/i3+5lxQ/sMg5GYdcAsgX7ZeYPKhoQvw5mwc6dawMBpWyrUC04R
 VnfdgUko58GJI5ykgUsEQxt3tW2hl/MknfTcEaV0DNEYgt+H/AG/RVi+MwoS8+nDar/dHjDb+Ld
 x32b+wc8igyJIYCHRP9uqc/R+f8n+VK7oqJDY1WfQ5ecmXrndG9HNofteWOohe7hrfDXvl1gG8F
 H96Cmm4PtATmg1234cRnA3jyBNZGw58dFGLp5v7Bctcy8XDQCRPUMpi8naXza2BUyeIeU6uo/R2
 cgWrROdQQGkCrQyinLydz2nq2NylXP7+638kU+oo9spX2+8o+2/z7N4tHPbzw/lYa+Ww1t1EnW4
 yr+g4d5B2vyyJ7Gm6qghaJOeCGf7xPPpkZATpHH1fxugKg4Gvk4NssbG22HhbeGXAZYZqVmSUzz
 kWuxns5jRD1/I6XaB0nnWlDVwy7w1I+nSfVgxYlN/ZTmsfbANUGsWC53Fe+4Ub0CHm1vQ5Jw==
X-Received: by 2002:a5d:674a:0:b0:488:8850:50ec with SMTP id
 ffacd0b85a97d-48e07fa9800mr12906407f8f.46.1792438031204; 
 Mon, 19 Oct 2026 12:27:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d830e91sm818569f8f.54.2026.10.19.12.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A7C65F9E2;
 Mon, 19 Oct 2026 20:27:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 03/19] .dir-locals: include QEMU code in PYTHONPATH
Date: Mon, 19 Oct 2026 20:26:48 +0100
Message-ID: <20261019192704.3220373-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

When editing python code the linters tools have a hard time with our
imports as they can't be found. To ease this we can expand a
PYTHONPATH in .dir-locals so at least Emacs users can have less
warnings in their editor.

I still get complaints from python-mypy about missing library stubs
that mean it can't do proper type analysis though.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260930163050.426737-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .dir-locals.el | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index 3ac0cfc6f0d..51871619422 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,2 +1,8 @@
 ((c-mode . ((c-file-style . "stroustrup")
-	    (indent-tabs-mode . nil))))
+	    (indent-tabs-mode . nil)))
+ (python-mode .
+              ((eval . (when-let* ((root (locate-dominating-file default-directory ".dir-locals.el")))
+                         (setq-local process-environment (copy-sequence process-environment))
+                         (setenv "PYTHONPATH"
+                                 (concat (expand-file-name "python" root) ":"
+                                         (expand-file-name "tests/functional" root))))))))
-- 
2.47.3


