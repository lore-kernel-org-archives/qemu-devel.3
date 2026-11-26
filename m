Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PgvxOaVC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaaB-0007dM-RC; Thu, 26 Nov 2026 09:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa6-0007Yk-MF
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWaa3-0001f2-JS
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:36:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so67847545e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795703770; x=1796308570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iR1BSxwzUUC40vPPolihTYt7JyJYZPIAe4hYeiisekU=;
 b=PgvxOaVCwd3/eUEdEMqR1k7mDI9/XxqslsowWAbvDWY8SSWZUAjeyyZQ1SoyvoZxdB
 iCvoxDSoBVCNYNHGWXEFCVCAx4HR1SMZmbNlIoIhWE+t3ODw7opMUVptM9QjqRCmv626
 DybvinuCoSaCTIAnFrUlQht3323iNSkw1gYpa4ZvPVci3rKP+abCGBJr/ur4v1JC0mcf
 RZtejYslVRhYurkqhAQFYQCrBkPsFjCI5H2OaZlcbf/nAyVu+TrKHCk99H+aKJvM45GA
 XV4QHFWCC/2fC1a6Ezil6x8eJ2/fCUexQEHk9wzBuZZ3QsxzLmSF8YQBc2envPImIyaR
 saSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703770; x=1796308570;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iR1BSxwzUUC40vPPolihTYt7JyJYZPIAe4hYeiisekU=;
 b=SVFzukyFVCkSxQ3KkSgrX7lU0KfKodOAXTagsZKZYkCz8jOfVY9olnJ7J1eAUeXFsa
 0UHwDnLPYnpFQlLI88LwnY+VCrxKLY87oamUJqKhmOTiVqeUB9zXBe4/NVKK7sYQPcuh
 nwJvpZZpdxNnSO/U2jy548xI/IuZ7AHOWQGPWZ1JMnnUsoC3Jh7d+KOfzhP36yQ9IfI3
 w+Tx/33nofZy0g74Gb0K01ZYgQ2Gux6TDomLvLdTbmuHE5Gxlk23eDTVA97Ld/QsiOzp
 ia7Ess23IZUqlEMO4zcR1bLcER/seTFA6aVU1EJm5VrTqzq67vfbESu3lVeQ5yCb1bXJ
 3zAQ==
X-Gm-Message-State: APuU4Z+5yXd7Nam1xsusea6QzA+2GY66UomxADAVfn1IL541a5QOcPnf
 lpvyydytf/QcvHF37Xp2RHyQwbvK+/rPZHN41sgNt0DvbfTZoGUnpfA4Zefk60rHzhU=
X-Gm-Gg: AZFdTZfXHLMNxLF+Q7Tn6ADrVdhPyK0K8jTjcLqA806DkEBgTB+s1SwefPIBcPxaUeB
 786sbiWwAQnrWdndl1EI3tNrWDNVHKPSwvmiH0Wb8jZkPkjyIHcEqzSpeuyYDsxS2NJTL+2Lbp7
 bJ/OWEu95/bOGZiTvDpxGv77omlAWOHe1IleE49crFtsTZJ0GJe4AGT1tiLwzWlzeb4c2vU9qL5
 DCopkFyw6+XCl7wuIT9lqLGOcS8C1ryY0iSS37A9X1dp05QZq6eLMfXRtpdWlfhgHm0LKS1qSTp
 mdfzIGMPiiHyQmf6O3RkYfx1H7dnXkHN33O1L1x/JEiF85G/toa6RN4PVXb4nGZzh4dChwwRwty
 pyRMb9RoRg07lSiaGVSpPr0YKZwCbdtaHm5/uV82ddF6c1G5CwM0MkytJl/QZds+g/qcKjDgXwW
 cOOC4QzMz5QqH6xStPLnLfDuYmwFlnaqaEvbmtPfnSe5ZoxQaZxNvLt7mP3rsRrBaUQUvXGWApz
 gfPEeB1+3lXN35Kkt6+BAq5tMLW94eOM63765OY6c2dZVQ9JXePy+NyTEdjMKabuH+qDJsARFFU
 /ibPUrYZn3TGM8MEZienXiNSgEEK
X-Received: by 2002:a05:600c:5493:b0:4a2:8c5:5e5 with SMTP id
 5b1f17b1804b1-4bb8881c734mr456826815e9.7.1795703769705; 
 Thu, 26 Nov 2026 06:36:09 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c50sm40545967f8f.37.2026.11.26.06.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:36:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A4C1B5F9DF;
 Thu, 26 Nov 2026 14:36:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Chao Liu <chao.liu@processmission.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 2/8] MAINTAINERS: make LIU's entries consistent
Date: Thu, 26 Nov 2026 14:36:01 +0000
Message-ID: <20261126143607.2374676-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126143607.2374676-1-alex.bennee@linaro.org>
References: <20261126143607.2374676-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All the commits and s-o-b's use capitalised entries.

Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20261120200511.822573-21-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c5a40a6929..048ea6a5034 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -367,7 +367,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
-R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
+R: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
 R: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Supported
-- 
2.47.3


