Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019B3CD128D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcMc-0004SQ-GO; Tue, 02 Apr 2024 07:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcME-0004Ns-L8
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:31:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcLV-0002U6-S6
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:31:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso3636519f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712057426; x=1712662226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQYebzAm0/Zs/gN1IFmg+B2akTqJN/e5dKp9cuddpsI=;
 b=S3MPFu2tKIe59vxT54ufgjNuEIsviX+HkgRQTvLM/Mw1vwNXfY3/+aU4/ug3/PylUl
 MVd1HDeb2bb38jAomRKDVE2YgUNRy8MSSUPl6wkrv5HzRo71R3alv09NPDPruBvwqsiR
 RSmvg2ScSXLoxwLa27nTLzfSbfFj8gAZaWUbDJU/jJaPjG28N2sAgIZTnYr5IeAkb7rY
 xzuxJ94eVs1dNjbn/9CSEjH6t/mzDw0WyBomrJ+Q+4Ufu7SCPfDKWvdMp9NbGyJNXoT/
 7o+VFR+NlTP6B8Pm4FeCUrj4Az7Em0r7kAIK4BIKalxdiKWj8x+1hrEYtjPd6sJc9u/o
 oORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057426; x=1712662226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQYebzAm0/Zs/gN1IFmg+B2akTqJN/e5dKp9cuddpsI=;
 b=QiCj5/7cZllR4bmGmpNA1yU0qQA9+6Y7jyPimdV0gGurGqVa+SVkHh7S+Tw2k5N2CL
 4LBHPUfhB0WrcVV6jIf9///mDFa9H/KbldP+J1TdTG/emR9PAzdW1un7fxS4jOXr0CaT
 qSy+3KBqID6c+A5yH4aKjro2U8KM84b1HMHRmZVbpSVG6iyGF0cImeA3ogAomNWCB6BY
 VBUqDemfS4Vjbe/xMb0bI3K4b9XoD4mS0wBgeWJFAhWl7P24QalxHZ6mOdn5Jeg8jc+i
 WIVmHsVrAm9W++WA7VH4WgogFvL/yfbRHBiOgPpkDe1HNtteYKDggOTQav/Jqkcj+gxD
 yt5Q==
X-Gm-Message-State: AOJu0Yz3z9wf3gBSFAGnRso1Rbcy900oX+37ZQqa0YnyboUtRuZxG95d
 mGqNFGSLxKH1/nTI2Vs8nFswWTbn5ryx8zUBbDX7OQc2Z/kELXlNUQcrgp65WZMr94mbHytsQBu
 J/YY=
X-Google-Smtp-Source: AGHT+IEzmReR+ra1bXu6snaYDjNDTjHAARdLL+IEnPSTkmiKm2/mPmn/Pc0xbl6wGTUxltO5emP0JQ==
X-Received: by 2002:adf:e50a:0:b0:33e:7f51:c2f8 with SMTP id
 j10-20020adfe50a000000b0033e7f51c2f8mr6864591wrm.36.1712057425827; 
 Tue, 02 Apr 2024 04:30:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a056000109100b00341de3abb0esm13909947wrw.20.2024.04.02.04.30.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 04:30:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] scripts/checkpatch: Avoid author email mangled by
 qemu-trivial@
Date: Tue,  2 Apr 2024 13:30:13 +0200
Message-ID: <20240402113015.66280-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402113015.66280-1-philmd@linaro.org>
References: <20240402113015.66280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Commit f5177798d8 ("scripts: report on author emails
that are mangled by the mailing list") added a check
for qemu-devel@ list, complete with qemu-trivial@.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7026895074..4fe4cfd631 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1573,7 +1573,7 @@ sub process {
 			$is_patch = 1;
 		}
 
-		if ($line =~ /^(Author|From): .* via .*<qemu-devel\@nongnu.org>/) {
+		if ($line =~ /^(Author|From): .* via .*<qemu-(devel|trivial)\@nongnu\.org>/) {
 		    ERROR("Author email address is mangled by the mailing list\n" . $herecurr);
 		}
 
-- 
2.41.0


