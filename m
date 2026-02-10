Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD71BEA3F18
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 22:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvxG-0001Kc-7V; Tue, 10 Feb 2026 17:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpvxE-0001JR-0j
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:11:32 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpvxC-0007Ry-B3
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 17:11:31 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso199394b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770761488; x=1771366288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yz7kdnMp8aiJTNY4ncnD65u59YmpPbLhrZvbXKugugs=;
 b=u8/FzYi/HOpCt4GjlGA0JGnbaJi7BtCNajL11hg9+bHaMf7S5Yj6uFVoKM12aECW/O
 rDtQ+PAeNCIvl48kcSsFryUsGGnof0kd/NBku4Po0EnA+wcLl5zS7zJxTVOP8a+KnsLV
 t4ibyW2F72U0sWwShosfMMES0lqm1t/DnCl8I9A178uzmCoW+oEuCC5h+wCopA3lli0M
 LBSnpcjxsWziZLHaSk91QRQOWfft4dylSI9I4HrMT6ryjzMp4o27EisXBJd1Nxi0EMki
 TBLneDF72an1hoCap7SMxFlm7o+kOu11j1AUt5M2pJ05AgxU/iliS/GhQQN9SlXkTOGP
 ro9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770761488; x=1771366288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yz7kdnMp8aiJTNY4ncnD65u59YmpPbLhrZvbXKugugs=;
 b=uDcULy1j5KQHjTWiu+DNxk+Ao3o5NVE/RR+3Wn8cyWIF4hmDhh6bHSqAhUS3w+dt9t
 rlHEDJKssYausG1xyKQk3GIOz+ttmA8u8l8R/DbdASnCDyHj7iucPr/AFqdJBEktbEaq
 7Bd5RYKURuOmv+zMOvs4e+N/Y7XubMyvo2S7fdh0C/MBllaQDtBF8eLqiUqfCMaVlNk7
 d9El5bMK1IP/jfpk6lJXTnqPjX5JKfKQeoco5UAegcIkGafvDrpcDlN/Ln6ftZQm0Tka
 qamDKI+vn6JnBRnn0lAECTcuF197oYOeIJOtQjZmeY0VgPqzXDLIQvgkBZiSH7dZ9X7B
 etUg==
X-Gm-Message-State: AOJu0Yw2Ms88Zle5j5HLXHyIJZiYmSt1qcf82HOuYGjJ9hDdVg7+rNKV
 nKfzglv1i88l6Y0sBCvhXv5vnwcBRdYYcjDU7iCD3n4NuAeDa/+qRdOX2WCWZouHhBzuaQ2+t4l
 lIn0v
X-Gm-Gg: AZuq6aLCDALygx6zDSH6pnx06vkzB3oVlN7fpnvcvWArJ810LlhYepsEQSFf8bLG71n
 FJmar3dR+6t9YeEVqruEa7aHx9ixJCTExOXtFul4bSrb/1pDdSKNp/WIBwVVi0EKe6DHKW00aft
 0ihHY3mBKBQ72j83evtu08XuDpZ9FNe9kbm+uXU4dU461fyzlKZRYBYQDS9Rd6Ydy+hv5WnIGHj
 jEtolzQWfKT97XwDCxj9UiSNp1wBkt3M8xowBrVwFyOKvCaPBW2bXcXd05kwoAVFlx+PHfJGO4+
 C/P4PDVYTOgiDlYlhVUvCw9OrYJ2kdKZuKcRB5AiK2ae0ng2yCINWUQypYbNjJqbJCvPCjHGRZZ
 w7Yufuvjjashk7vyYjGmEfiSG6d2dpi+tyMgbUgxFP9SU6NDMzAyVhShmzutD5LmERcFNDnuGZy
 EpEechbfV/gGu8394ZDVYBPd8wE+UC+dgwaTs2hbnuwscJr4TxCEc7lZoy3n1Ea/v1ptq3zVJC0
 oKBdXKlXzv4u1I=
X-Received: by 2002:a05:6a00:2411:b0:81d:a508:f056 with SMTP id
 d2e1a72fcca58-824874dac43mr3873342b3a.18.1770761488077; 
 Tue, 10 Feb 2026 14:11:28 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e36809esm19382b3a.7.2026.02.10.14.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 14:11:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Plugins: fix windows cross compilation
Date: Tue, 10 Feb 2026 14:11:21 -0800
Message-ID: <20260210221122.1494473-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:

  Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins_llvm_dlltool-20260210

for you to fetch changes up to b0353beebb0c4fa4059c88362561a8362ada8b4c:

  plugins: fix cross-build using LLVM for Windows targets (2026-02-10 12:58:31 -0800)

----------------------------------------------------------------
plugins: fix cross-build using LLVM for Windows targets Mohamed Mediouni <mohamed@unpredictable.fr>

----------------------------------------------------------------
Mohamed Mediouni (1):
      plugins: fix cross-build using LLVM for Windows targets

 plugins/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

