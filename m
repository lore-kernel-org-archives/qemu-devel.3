Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED55BD2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTG-0000qg-DZ; Tue, 27 Jan 2026 06:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTE-0000oU-Kh
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wB-RX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so1123685e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514162; x=1770118962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktF7qY0EG+o2E7e6Scvg19CE/fKNc1sVDTBDTuoSyBw=;
 b=YebG75tN9jWRMTjMUsPLJrUJsDMuEFfUMUDgqOMAfdSDKNQfEigCwNV1c/Ue43emjS
 E1beVDRw3YMgy253yd3Kni4vfA/Q4Kc5yEWe/bJr+82Zu6a06g5j9/z4KiqpUKi5WDbN
 kc+lRjVE8A0A3eq3XrRzYY+dneusaB93ma7xFwziSyeDG7vnvUDoKT5imo5cKh3iyjub
 WVelDRinLrngUT7voKFp7DKTL19290uBi4eR5QPzPPLpkW74exHM2RvJtIZyU2EWGasx
 O/mFMkSgvdT7RzOAvae2N0l/FtlSql1sOlbDqJ67zENH/TC0BNprFONGlGqlCgXkGCBQ
 H74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514162; x=1770118962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ktF7qY0EG+o2E7e6Scvg19CE/fKNc1sVDTBDTuoSyBw=;
 b=mHPfbycrcQJcz0n0kZGijMaHSuQZajBehnhn+KCQCGe4azgzfZ6Eu3YnnMgEbKEOcp
 svmBJ0/58WKCYU5bgvj+xshKzmm7SJOHgm4x4zzJhczV2Psfv4I6PrduRfqsPYWTzqor
 Ii9JrjtGMci8vhRqJjZIlpTnxCjb825XDVnLy81DjnVDrfrcVUgdHkhcIBqC+8iRK+Fi
 fGtlK4I8aHK9CWkGyqJZjY/YukAtiD48q0mwoZeiOwsO5Rhsob+PpdWHrgB0lQI4bqKp
 qMvxAkbYUEspZjI2Ah9bQKeme+6ip21TM9xPvvaJKCnk38qrrnyab9Rl1/qxnfDON9o5
 4Zpg==
X-Gm-Message-State: AOJu0YzGY0CeTG0s0Oax3BmvEoEY+R3JDkYuLDKtWSP1+k8JXn8p8yVz
 TPOtS20P0AreB7BOI1SG77TgHg6IIiVrsuKUdLgjsIP11Ov3xyZvevXMiZsrQRErW10=
X-Gm-Gg: AZuq6aL8AKTRoAabSbrQM1CHpa4DtPmV3l2uaVhItBE+GJ0I2NJqDSExTQEDKaIbDco
 q9FOA8FA4h3/2ibc8cIWIVn49jmPIhjgfenXqGz/Yz1/PTiw6sA2WF5UHPXeL/OOpqnve2vn9Gp
 0n5N4vfLUnobzc+Cyut1mEq/5/1xuenAr5RIMjF/JL4Y91qquKsyBnUKDwDU8TA2kyV4etrRFkw
 73V/EWZuutoxUq8rM+qk6N7CtoEmWPGuIpjw607cxmYUBhXfznUd7y0aUyQP57irrAefZTTW+T6
 PcMi3JWVR5fFdVRqgbP3e3jFSUMnla107ZXN561Ys/XY3Cde+9fP0rCXnnre6MXOhuTxOBwYFK8
 l+8oG7nYw2pab6hSjxyB5IxWCwVrIcsSdi3Q9nniLVCUTTtTeA7vgFT/Gwpb3IBjdCC3szrxD2O
 SD2vdmLZFdZEU=
X-Received: by 2002:a05:600c:4e4f:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-48069e70621mr17717695e9.11.1769514162281; 
 Tue, 27 Jan 2026 03:42:42 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c37433sm54788355e9.10.2026.01.27.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 93C125F8C1;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>
Subject: [PULL 2/9] MAINTAINERS: fix libvirt entry
Date: Tue, 27 Jan 2026 11:42:32 +0000
Message-ID: <20260127114240.3009791-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

We have a particular tag for lists so lets use it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Message-Id: <20180716073226.21127-3-armbru@redhat.com>
Message-ID: <20260123145750.1200879-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 376fd2811a8..faa3286fdd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4512,7 +4512,7 @@ F: gitdm.config
 F: contrib/gitdm/*
 
 Incompatible changes
-R: devel@lists.libvirt.org
+L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 Build System
-- 
2.47.3


