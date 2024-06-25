Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17DEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0hW-0004SM-Ru; Tue, 25 Jun 2024 03:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hU-0004Qu-TB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:34:48 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hS-0003jv-H6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:34:48 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec3f875e68so58191931fa.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300884; x=1719905684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mj2lrJZSjuoKCRsd0DcOprRH20buaxQi8Vi1OUasQrY=;
 b=vnfYd78QwxfBh7jtc94tL5imn2WBj60FDFAj+JtmfEzzfKvHuj+ORYmCiec/6t3Cg0
 R3zZvD4Clxj2HBU0JvvDGSthZN9HQ8l+dEZfa7fR31lcd0AViQEd8SpkMB6JyqDn3xgK
 r9uKX3kNOd/wvWsVcvpBHQEjU7OtFATAYzwWADfy7N33TNT/HK2ORZ6ScoojSUtK8YnQ
 uCF3KsUiIjlutsaihwVxRbMeQkisqsU8VxiI/cTIRkv/DCQ4cINUlDCPd8Ri67uvakw7
 vYfwUQjUTFGt4SfazfUPKtIaKRU8YYSuJyYmhasfjNLUXjGQ5VOF8Na4iPUM0bLWUbrp
 71jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300884; x=1719905684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mj2lrJZSjuoKCRsd0DcOprRH20buaxQi8Vi1OUasQrY=;
 b=Y32NakeEIy4RMy7YhgLZfTlzWW7APAhYmOl5sdgvxuLl2mxvOtAb36g70eQms1HDbj
 tErhl9KDXfUTvcX3L39G3fHtdF95ytE8UC854SlELXwdtXjbkjTUZMDiB7rYbrLdQqdB
 LKzqO08kFabIP30QV00VZMkJnUmBFJHqBVBuo5DLyWq//TXO3fgHnW5Difpe8Gt8id5t
 QFSiUY3bnwk0WkfYOAkgxbZGllqGe8cFLNBftXAJhZSpDwNzRh4XIiNIBke66S6H91Aw
 EO81Nms+SBdsCCNZTZc5cRAwrtxf+YdyatBkGCNmKjPA2zUGAES7DJQ+iLBaRj333aSx
 8j9A==
X-Gm-Message-State: AOJu0YztJnQGK+wxw7XfblA9R3dfGaLcpLgHgYOaA47q+1VBlcud9Yva
 FTkVcFhMLDprcW4Maowjx4tqenWEmt7gb33yZi63BHu9TOUfTqq+fTkvlhmZo9Tyx35vNGgVTKk
 E
X-Google-Smtp-Source: AGHT+IEUQnFZFJ6VNAhIkjM1fYnY3GSGe/x8vxJBGzDAwJpk+6SLJXq7VazuHpoRt8imLt1dV5ytpw==
X-Received: by 2002:a05:6512:78e:b0:52c:caa6:13b4 with SMTP id
 2adb3069b0e04-52ce1832de1mr3774252e87.3.1719300884226; 
 Tue, 25 Jun 2024 00:34:44 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366389b8922sm12087410f8f.28.2024.06.25.00.34.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:34:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/7] hw/sd/sd: Introduce sd_cmd_to_receivingdata() /
 sd_generic_write_byte()
Date: Tue, 25 Jun 2024 09:34:34 +0200
Message-ID: <20240625073441.34203-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Consolitate writing bytes on the DAT lines by introducing
a pair of helpers to reuse in all commands receiving data.

Based-on: <20240625061015.24095-1-philmd@linaro.org>

Philippe Mathieu-Daudé (7):
  hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
    sd_generic_write_byte
  hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK / WRITE_MULTIPLE_BLOCK
    cases
  hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to generic_write_byte (CMD24)
  hw/sd/sdcard: Convert PROGRAM_CID to generic_write_byte (CMD26)
  hw/sd/sdcard: Convert PROGRAM_CSD to generic_write_byte (CMD27)
  hw/sd/sdcard: Convert LOCK_UNLOCK to generic_write_byte (CMD42)
  hw/sd/sdcard: Convert GEN_CMD to generic_write_byte (CMD56)

 hw/sd/sd.c | 108 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

-- 
2.41.0


