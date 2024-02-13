Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8F0C48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrTP-0002QC-Rg; Tue, 13 Feb 2024 07:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTN-0002N0-CE
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:13 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTJ-0000si-0H
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:11 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e0a608a36bso1756553b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707825667; x=1708430467;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8jQxR7K97R6LngnUG8bs1kowV4iKJWFO0PSS/0Vr5uM=;
 b=bURGLQM/kdn/cOuCpTy6yziFDo/HJHrixg5FUeUGkDichM5NSiIfwSM/m1PIuQ/Srs
 rA7q86KUPrUrzJxLnhtqhMyNUmotPNktn/mjkmrN24I1YpDZ374GCq3cHuTVNuM41dkM
 XtmiwDi1vlT0TTZj8ceYjjv0AKrPoDv57jsBkUkagm7Q4Xet4qFInx84b+tfBGNn+7eA
 26YlzqoRdUmaO+s7X27Qqf3FRPx43qom6T4dS5DWmmwXDxnOTHBU1TuJi0StPHaGovYH
 6trgj5pfHTIqniQmgQE65IKgsuSxvdwfdkRE0NRzk5P+mSoh2O7rOO+KKLAuuB7NGiba
 CyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825667; x=1708430467;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jQxR7K97R6LngnUG8bs1kowV4iKJWFO0PSS/0Vr5uM=;
 b=KPIWzomiyTWJBngeP80k5DPRVuD7ektoEG8pI72VK2xunex9WGfiJdytCZym5jynKi
 Ka1KE63f6PO4zeiJTG4QDaBgRCSSLBVhH/nEQai1o1FU7GQA2mo/RXToy/CS5btzD5id
 hi5Ym9hxmB9awfqcvTwxi35rxrbMjKd3lWpOuXcXmK/4xZ4T5d0sQ6vXUMmiLBiMP581
 wtbJVWmgeBZFdGWRxgws0k3SuotMfLTem3E6bIJUTchOhcuIIRenbyrfq2y9vB5Sxoxl
 TaLDLSqymMo6POQd/gi53UCJp3AuSZGpTu3ydDKydlPj8xCzmTMHBI4KtJoYxptu2S+h
 3ZHg==
X-Gm-Message-State: AOJu0Yy+NMNm+XmPQ1vm1MiYqMXDOIVfIoDB8XnU1W9uw8LhD0mdHMTq
 Fh4BIJwTP7vZrD9LlBLAku3Q52Fk38swp8D7KEhLghzcK+B50vFWAS2kAMoYO1X19Q6EDZS5TgR
 w
X-Google-Smtp-Source: AGHT+IFWPUmvrAxoikLOVaKVoZgLtDE2tK5bYT9lH1TLfiJdtFBbigb9Qc4YmNCMjlUaPtdlchopzA==
X-Received: by 2002:a05:6a00:b4e:b0:6e0:4717:7a0d with SMTP id
 p14-20020a056a000b4e00b006e047177a0dmr12566718pfo.5.1707825665416; 
 Tue, 13 Feb 2024 04:01:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWG3VcipnpAzJOUYxpmQrotKN1wTb35gYDTOF3W047bN1cK55S+i7A6cF0H4cUGscdbpm9ITvI345ojoEIkAKCjguq98o+FyRNxTt6TmovFHtO4I8sNCLUzAAHfD3eLWYCGqPqkB+2uHRz7odGCIrz9dqAskunuetxO3O58L7ZlydkNjr2PBeLaQuC6ckaKQt9VOsbRn67abKU1S2Qqj2aZQbjDFTV8MioLvbZblY+R8hkUg1sm4fIgbX6zbeLi4nTreSuUsYmtLav0
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 fd11-20020a056a002e8b00b006dde35245d8sm7170723pfb.58.2024.02.13.04.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:01:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 0/6] ui/cocoa: Use NSWindow's ability to resize
Date: Tue, 13 Feb 2024 21:00:54 +0900
Message-Id: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZZy2UC/2XMTQ6DIBCG4asY1qUBrPx01Xs0XSAMlUXFQEM0x
 rsXTUxsu/wm87wzShA9JHStZhQh++RDX4Y6Vch0un8C9rZsxAirKaMUm2CCxo3greS1AtVaVH6
 HCM6PW+f+KLvz6R3itGUzX6+/hcwxxRfl6hYIVdSxm9VT78ezCS+0JrI4MrEzURjXjlFwouGS/
 DF5ZHJnEhNshdNWEiPA8S+2LMsHwptLwQkBAAA=
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

V5 -> V6:
  Rebased.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v9:
- Split patch "ui/cocoa: Use NSWindow's ability to resize" into patches
  "ui/cocoa: Let the platform toggle fullscreen", "ui/cocoa: Make window
  resizable", "ui/cocoa: Call console_select() with the BQL".
- Added patch "ui/cocoa: Scale with NSView instead of Core Graphics".
- Rebased.
- Dropped Tested-by: from patch "ui/cocoa: Use NSWindow's ability to
  resize".
- Link to v8: https://lore.kernel.org/r/20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com

Changes in v8:
- Split into three patches. (BALATON Zoltan)
- Removed negative full-screen conditions. (BALATON Zoltan)
- Converted a C++-style comment to C style.
- Link to v7: https://lore.kernel.org/r/20231217-cocoa-v7-1-6af21ef75680@daynix.com

Changes in v7:
- Fixed zoom-to-fit option. (Marek Glogowski)
- Link to v6: https://lore.kernel.org/r/20231211-cocoa-v6-1-49f3be0191f2@daynix.com

---
Akihiko Odaki (6):
      ui/cocoa: Release specific mouse buttons
      ui/cocoa: Scale with NSView instead of Core Graphics
      ui/cocoa: Let the platform toggle fullscreen
      ui/cocoa: Make window resizable
      ui/cocoa: Call console_select() with the BQL
      ui/cocoa: Remove stretch_video flag

 ui/cocoa.m | 533 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 250 insertions(+), 283 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231211-cocoa-576b8639e9bd

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


