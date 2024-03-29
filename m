Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382EAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqF2N-0001wb-Ir; Fri, 29 Mar 2024 12:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rqDn2-0001kA-5P
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:05:08 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rqDmy-00035q-3x
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:05:07 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-696719f8dfcso11886936d6.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1711724701; x=1712329501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XPEZYgQqoG4kHoPBVrEhwNCRwDMPHIt67XAaAsYYg5s=;
 b=WYvnQTpfvfBP4OUWGXUM9vqFla0t3E1sfc/qA7pOOs1bEJmO5npOyspYUOd7e/okMc
 uxiTP6dntrSUqRWNhGoDO4MgqDo8+1b9DXhshGu50qPJJBWErQQIwdtLMqoaLKrRyv4z
 j1YlTsI6hUSMSd9wViQs7nLMIKCkcSCsKkHNlX4FDSz0B9v3mEBcLAZfLcSmTJeKxEzf
 z+AMpPxpnarPmWBxPt1I0ae7UcuJ2Q9YqT3KHu1iklKLapLzPjykBVbsfhWWFGFzcreS
 5d3R6eQngyyvtEHkS8/M2p8Vg2n/5frewpIp6fA54sOTwzp20M9YGmj7LtSj56+G2nA+
 VXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711724701; x=1712329501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XPEZYgQqoG4kHoPBVrEhwNCRwDMPHIt67XAaAsYYg5s=;
 b=dunaD4X3M/kSvD6/1LvMwAICLh1znCaneU46YbuCImoXKacVrVAaKtrqhbFLCse4g+
 KW4SrXiBG8etiFxiWwK5q4yf+vB6v4bypTgo0eGoJg7FQp+eRp9b1RICT+ZRW1kbecKA
 1FzALq4QrkqkHh2f94onnwyP9/GWDGckUpXtcqagA7DKo5pB1KHh0BsRUbUs5Ab6FcGl
 WgeTu2scHVW44yBjMMflNYMAoHtcPBr219gTCvu1DLGDgZ3G3qVXFoxiQRk9r6ox6xnE
 Z9wSry5hEOSihsVKkfeuVsSxh0dshyllFOMGX7DN9J617R4egPVsoTkbnSm7RgON2jaI
 kkZg==
X-Gm-Message-State: AOJu0Yz1QQIx8EaC2oNNrrYDQCjAg2mDoVBcRuJJQ76955xBQKGLUiX2
 XzojMulcUyGQ0R6/Stovkal59HdI2GUNQtJy0DAIcsNTE7dDTtQBbEUzgShMAfFYDVnRjQi+BDk
 kDYM5H6i8jipoyrd71lIYsLqgy12nPpIW1IYevTRSZ9dv43QfGPGvB2HjJihcVWII5rfb0t1x7q
 WBUH6gQ+L2EGqlYHMOmM9lglsA0HGx
X-Google-Smtp-Source: AGHT+IE4xs+t8z5hXo9DIub6HCk3oQOIG0qCv5GlGmzcSBhTPNkqBJrJb/R7GdRieYbFi9GV+gjJVA==
X-Received: by 2002:ad4:4e63:0:b0:698:f227:c5cf with SMTP id
 ec3-20020ad44e63000000b00698f227c5cfmr1698997qvb.8.1711724701516; 
 Fri, 29 Mar 2024 08:05:01 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a0562140c6500b006986c65f3d2sm1704418qvj.137.2024.03.29.08.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 08:05:01 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: Don Porter <porter@cs.unc.edu>
Subject: [PATCH 0/1] Upstreaming Course Debugging Changes
Date: Fri, 29 Mar 2024 11:04:49 -0400
Message-Id: <20240329150450.2843758-1-porter@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=porter@cs.unc.edu; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Mar 2024 12:25:01 -0400
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

Hi all,

I am a CS professor (and first time contributor) and have been using
qemu in my courses for over a decade, especially a course that asks
students to write major pieces of an OS kernel from starter code.

I have some patches, originally from Austin Clements at MIT, that I
have found useful over the years and that may be useful to others.  It
would also be nice not to have to build a custom qemu each semester.  I
have cleared upstreaming these with Austin, the original author.

In order to learn the process and community, I thought I would start
with one patch.  As the description says, it enables e1000 debugging
without recompilation.  One project in the course is to write an e1000
driver, and these logs are quite helpful to students.

Thank you in advance for your time,
Don Porter

Austin Clements (1):
  e1000: Get debug flags from an environment variable

 hw/net/e1000.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

--
2.25.1

