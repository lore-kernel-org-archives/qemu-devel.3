Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16FBD2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTD-0000nK-TJ; Tue, 27 Jan 2026 06:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTC-0000l6-83
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:54 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhT7-0003wA-Kn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:54 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d2670932so5103714f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514162; x=1770118962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJ+XedUjTNqIHmY/VIKx0z/K7OXC89wrp4Wrc1CGPBA=;
 b=c4LqN/zQcXaje1x9EVQtOvu+khDlfxCZpZeH4GGX9ySp30r+VOFHM+eJDUAqmhADNr
 05rTel5iajXhZMrisUTwvAUyp/8rmt+VS3OKhrxWAUa5eaPJaKxSZdGZ9Ph5qsONxaRQ
 uTdlZiPagddbreVo6d2p5pF1qVqW5govdHzoz6+8hJi5k7kiZqsYLeJ6X09kwu5uX05S
 suGEJzBFHZdqaTpswsLUFUoT/bTNTGC3fMepS8A0vo9zWM4sVwbaNS0ILTK80aTy2vnW
 23fK2tZyB3i0rXhK5U78BxCRHACb+Yr2XEjtFReMs0nG291aVKuXsL419YxEyel5HUbD
 ukug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514162; x=1770118962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yJ+XedUjTNqIHmY/VIKx0z/K7OXC89wrp4Wrc1CGPBA=;
 b=pimO+OhHkHWLwrl3LBRhV2ci/DaNPMr0PPEX92ishPBLwGoZCjwEHq8lAt3021QR9P
 kdYwIsnyAETcrQNX3+8rffygJW1KNgi6YnQOWKaY7wjH7fnOBIRJGNw124Y0YXV6/aTm
 BG/KX5jrL4JKq53i9HNvS3iE1CylQ3MH5kPQNypCjcgXhWUoLtqnXHkjze87GvcSXmqa
 1bQRYVSEpI0zbHCWUgd47PcF4AisImezuGjYJDIt0V9ZH2js5wEeW4kaPvOVJHxTM95Y
 5TXpxMmHIQTgDVjT2DpBaBNMpHBWc3QbsBJUteZBRmKVUleavO/DRDv68aT+ivyopFhA
 T2BQ==
X-Gm-Message-State: AOJu0YwJhAC0hgdBoTehPYMoMeoDkPoAVpgaw3vE6swmXZCeutnTu7Ph
 VIHWs0F+XHmH0J1OKnkX42N2xHdXPd2dLpGD5x8bbU8rfyUxQmQ+piVEo3BnnfhLSZ0=
X-Gm-Gg: AZuq6aJwahis4muzWqXK4uUm2t0qfRVj7ZunxAAZBc2nIKw5LsVBPCkmdPnr8NRVAvd
 NP1Vmxp/C4WcRNK4pZ7ZGjRD2PLPf4MRX4hIX+zCyggGgtczw2IFOIVSx3ez4VPH7e4HV4sAAwd
 KSY2xL4Bcw45MamZd64SIDJ97EVOXV0QngqY+WHILFw4UzbReE6uzuehtVPMGWk0ZFQtCOZFsQd
 Yd+Tas95zXusZIO4yKaYn8TNIiVANr78xX9yY/tyx84mo82gpGOVXrKjUJcg9KApYdDtyeXn/s1
 or4BNhwerp3CROEsFiVVSa22O0uwHpl6wBbObnuoXJ/5ik8eESRZZQXMswlrBHWmnB9fcTXdXac
 ffqGDmYs380qlgqYi8nrowfwsflphVX30b71803SmAYpPyzTnnsrd6Ggvu1Ak2N4m+CQSjBhtMc
 f4qRxyjPAVvsM=
X-Received: by 2002:a5d:5849:0:b0:435:afa5:c27 with SMTP id
 ffacd0b85a97d-435dd1c7c39mr1954649f8f.52.1769514161932; 
 Tue, 27 Jan 2026 03:42:41 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f73855sm36616301f8f.29.2026.01.27.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B2805F8BA;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 1/9] MAINTAINERS: fix missing names
Date: Tue, 27 Jan 2026 11:42:31 +0000
Message-ID: <20260127114240.3009791-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

The form is Name <email> so lets fix that up before we enforce it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260123145750.1200879-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index e23354235dc..376fd2811a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2551,7 +2551,7 @@ F: hw/virtio/vhost-user-snd*
 F: include/hw/virtio/vhost-user-snd.h
 
 vhost-user-scmi
-R: mzamazal@redhat.com
+R: Milan Zamazal <mzamazal@redhat.com>
 S: Supported
 F: hw/virtio/vhost-user-scmi*
 F: include/hw/virtio/vhost-user-scmi.h
-- 
2.47.3


