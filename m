Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E2C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddCv-0000nO-E8; Mon, 12 Aug 2024 18:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sddCr-0000dD-N5
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:08:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sddCp-0002bt-IV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:08:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so35782145ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723500478; x=1724105278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lyw1osYPfrImHjSHGx1EYAl/8p7GV6yl9J17HooCH7w=;
 b=iPtKQl323QtANnytIDGiqU6dx/f8AOFuK5XDmk4bl3GGe5055V+rCE1oJiqLA/ptxT
 l3/EllCNGzMF+UfjBAN+6g37aspf5l59m0tACCMJn+1oxGqJTMxiWhbBXlIJVI7+o0Kl
 WrdbwVe4QAAXPkAR6CyxywbOV3zzcuUIcq0aBXx0qnQCkRY8me2L34S2If6rmnSh/QBw
 2boH1lz3Q5vXc5S5qmBemYK8BLcP3a7OTV9xXHiNWEwUEWEEKQMnk09zL7ufbVhusP0l
 NRScG3hpnwzDeOYgkvgmx+NrsDx4Qqn5d+EQ4l0LRfbLVO4ftehTs6dUr49yasKmFZ7l
 EgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723500478; x=1724105278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lyw1osYPfrImHjSHGx1EYAl/8p7GV6yl9J17HooCH7w=;
 b=l96m17C5vcjS1CQRTJvj5IXmjReVHFV4FjTvGGffZDb4N/MOK9fF7k2VF8jXP8jOXF
 2SbA0jffp09AVu7XHrpq0yeeWs5ZSI9psWQwzmEnnCGslp6xK02ZYxASCO0sqC3v/R4v
 OrTkvlwUzaEcrs8hkCiTQXglhUXwXidzt8VwQNX+gnC1oIm2a30a9csUuOR79+gUcPVf
 vP60lfifDlOQgNQzwobNBqQWg3amVT4TL3sgdUMjFzrUtkfBQHWEBVjKvRNV7CYjpHI0
 CXJGZK4rYIe279lf/k+huFP159sEDpLY3KaqlgLmz3Y5EWPoqITJQ6MUqgFZZx3Ek/Wn
 2mIw==
X-Gm-Message-State: AOJu0YzySSBOAp+S/HDhKhKg/xfxa6Fl1qcLiw1/ZZNrrYA+bauiWm3u
 q66JpJ1xPEUTC5l2ncz68Rwi/qAkmhCzPQgezunls8STQ2oxx8rZUxp8pehQyaGWgV79NvmAmkc
 wj3c=
X-Google-Smtp-Source: AGHT+IEdSSZnnApV1ExRtbi8OIud23Z6Y/4jxEOtWameuNPXegtvcIXVFb/PSWjiTwsFAkSZJM/2kA==
X-Received: by 2002:a17:902:ce87:b0:1fb:75b6:a40b with SMTP id
 d9443c01a7336-201ca129a24mr23206505ad.2.1723500477983; 
 Mon, 12 Aug 2024 15:07:57 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd13169esm1588355ad.24.2024.08.12.15.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 15:07:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 0/1] v2
Date: Mon, 12 Aug 2024 15:07:47 -0700
Message-Id: <20240812220748.95167-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Do not resize scoreboards if it was already done.

Pierrick Bouvier (1):
  plugins: fix race condition with scoreboards

 plugins/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

-- 
2.39.2


