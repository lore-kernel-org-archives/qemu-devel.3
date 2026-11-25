Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04931606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qG4AIyt9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBWz-0000IC-FL; Wed, 25 Nov 2026 06:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWBWw-0000Hj-NK
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:51:18 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWBWt-00079b-RY
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:51:17 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e47347279so3409070f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795607472; x=1796212272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GwAtmDCe//Z2bLe2BjvW49FxQ4gH31Rh0S8RN5kLGIc=;
 b=qG4AIyt9H5X0mq+3O2Ss3LxtHOdSDbEWoW/R06SMRhb0guqE6Rvv/Jk/B55uId1Bxi
 gH4fthzM4Mi5E6lOle5Rwk29DU1iobowNI3nWFsfv4h26HnXnR7W13CCVSbgpMs/8MXA
 9D46QtTNvQ+OgwiPDt5i0mRB2CYWdCxQi9CfXaVTow0Zys7A6qyyC7lbAX7cpC+adBWH
 WhP9u6SM35C/RNnLE1ByhyA8aB6P0QSeNqbsE8EpxPXBFoYCERPmz6KL6Db/rrIfiH4s
 Z/KFb+JdJBbz/uwqZx/Esfs6Fda7D3Xzo+OBJtDwDuGPNo/jIMu2PrXPvH+0vMdQuRGJ
 FOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795607472; x=1796212272;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GwAtmDCe//Z2bLe2BjvW49FxQ4gH31Rh0S8RN5kLGIc=;
 b=E25WMlpkhMLSND5aygD7v42jhq+YWAvli4KBUIUkQSss9kQ07wRYh48KwmF7j2VBhP
 ZmSowzpgn079dLk5puKDyEnZLm2rLhO+e9Fyoc2jVEO3CKLhlUQQHkiizNKYrfBgxgI3
 zlVsEqD45pWW82TjrJLfI9O3eUfYkW1A/MbS+l+HcOsn141cTpkl/qVx1yv+lL6Z3tLm
 xqsItu40QJrpOdwUSYkRIyN+BX7U4+fsoVGBPmmfpuVewZaHNTibT2Mmme/NlbKOXnJn
 z7RQKZiSbvP11VgzaLz0EfY7eOr6ZhGJq4JPE5aCEOLD1wLZs8aCtZq1MgjPwc2LsGjM
 2pNw==
X-Gm-Message-State: APuU4Z88djPrXNc9BdI7GPg7sHIIEBfLCPZY3iNjdsV/TBwdvMKK0Vs2
 1aVQxKIoZARnh376iyHUvdiqQO+yXwE50B8MKoB+FYLc11+QDP0ixRlutlWfmnpoufg=
X-Gm-Gg: AZFdTZfpGVghaSMbL2VHqH90Jt30iw2q/XN6RkY/5AhItSI/7AqRyocVKC4bcH+d+ZZ
 +UQ5OaXONOl5WxeGQ2u/iRJEJ+R50df9IszYJ2aeyq+zS/XwCtAU6WpeNnLMOb0UfCdxxdp2GxI
 b+Szt9fDWiV8uPjAPGAMOOSXv7IqpPTaGeYxw66b5io6c1Zy7tC3ybF1XE23L04GlX7nuY6PXzN
 BaFnpnSf9XdhEMhS5HqFMFokW7yy7Zljh9G6Kxolyzn+yljzVUMlmgw0LCz33Rmmc8xdwblQbkY
 3w0RwcDERepqGNZjp5M/fj7V2xmB18a6zHtRGB9Emk2dPfYKpcMMIT3cOV0lmMm+PjOaJc1cFdp
 LRvb6RvE1fOAmuqto4bJ3AGvrXfPGRt0sQr6d9W9INoLs18mUwkiCpI5xSlqgCyedEHK7uzPWvi
 UP3FBoKbcanvH4YpITookUSRX+4Y2TMz3lOQrBPHej/rbdVixYn7mkp3tam20ojMJwNoK0406t+
 X6Xf/+w8nPnGyhdN/Ue79bdV2GcAyEnQodFy8Th1ZUBd3gsgFFZqIXlVjdsBUOMmAVbGk1EjhJD
 Stg1gOdof0AC8rTOK2vWCd2+nrdG
X-Received: by 2002:a05:6000:4310:b0:4a7:b365:19df with SMTP id
 ffacd0b85a97d-4abb5eabd28mr34240489f8f.35.1795607472120; 
 Wed, 25 Nov 2026 03:51:12 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm35587314f8f.59.2026.11.25.03.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:51:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 363C05F857;
 Wed, 25 Nov 2026 11:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [RFC PATCH] docs/virtio: add note about virtio-gpu acceleration
Date: Wed, 25 Nov 2026 11:51:04 +0000
Message-ID: <20261125115104.2002188-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

3d acceleration has a bunch of issues and is considered hard to secure
in our current setup. As we have dropped it from the virtualisation
use case lets call that out in the docs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/virtio/virtio-gpu.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index d05f8cb8e3f..06e60ec6782 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -29,6 +29,18 @@ host's GPU and for the best performance be able to reliably share GPU
 memory with the guest. Details of 3D acceleration requirements are
 described in a further sections.
 
+.. warning::
+
+   As 3D acceleration by its very nature involves giving the guest
+   fairly complete access to a bus master processing unit in the host
+   GPU we consider this outside the virtualisation use case with
+   respect to security. You should only ever enable 3D acceleration
+   with trusted guests. There is still the option of off-loading 3D
+   acceleration to a separate process via :ref:`vhost_user_proto`
+   depending on what guarantees that process can make and how well
+   confined it can be if things go wrong.
+
+
 QEMU virtio-gpu variants
 ------------------------
 
-- 
2.47.3


