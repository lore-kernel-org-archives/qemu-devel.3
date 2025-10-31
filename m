Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE372CCFA03
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwe9-0006YL-N6; Fri, 31 Oct 2025 17:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vEwTA-0000HP-6k
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:36 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vEwT3-0001x3-2L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-340a5c58bf1so630142a91.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761945324; x=1762550124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7FFCf+VKLHfRwLfcbcxSchu4tcSMleD+5kqb5OSSjC8=;
 b=FvNg+unIbEF9LUom3UEJ/5RprPR+Efou1BQRyUHzVqPosgDvE5TWgftwHW+dp/yhNm
 zbcSAG09h+swwMtHEmUfR+FBui/qkgDrpc1mvUtb0VD2y1AULx+qHRLcrVizC2+mhG60
 IpSAM3clqhxteLOAbSzJ9cgqXPNuGrcNJJ0V6nDWpn8UXFf+6hlx0a+bXHR3UnODeCml
 nX0AyJ+M4zqZ+A9/HladGDAGb2IIChaxM8vplCwm8oeEnE/xQ4/J8WVejQ4cxwFDyE5Q
 8X47uvHT1dGz1I9yrUyUv+fsdYmACTigk+ttwqpVwL7kPVhXFrh61ERHHhShezoJMjlu
 pKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945324; x=1762550124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FFCf+VKLHfRwLfcbcxSchu4tcSMleD+5kqb5OSSjC8=;
 b=PHw+sgCyEJAO8SZzEz+z3PsTnOJ93KIVgx7T8GW0V7ezmo2t29Awbp5l8VmLfrZVVC
 HvBjW7QrBV4EMabl3V7ewV0g39Humj/xXe4y70IXs33mmLRKhmDFUJh2BnRqsqjxnKfo
 ykUYE7NSknu+SFaMetS2LfCzMWBkksWeJid9iRpXye6xfeOWpiz5FYnhbk8gY2xCCPpt
 KjMUjxViFXhaiLMd3+Dx3/Q3TqGP0Zj/4u0ppLTi782vyeVD2X/4d599Jeq/pTjdkltN
 MwaORYYpnPlfr+EqB6nmsX53IjD30DUxPDS3RKNCvwYNQXIBjCDQKyjba67WSxz5TSFn
 biLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvR6y6WVlDsSR0zhLleI39SqnxacbkHByVZhiLDRuaYJGEFSRh6UPzdEhQcc6Jg7p0qtdhVxMA3pO6@nongnu.org
X-Gm-Message-State: AOJu0YwemZa+bvxrxDwekINU1pXWKAEp/EE7wh0UMH+HGOrLUHjL3l34
 Dk48P6UgP1Nrxwc0SfWz+PTSRR2Cg9/2t86myZuQC0fNkM6+l9SICZob
X-Gm-Gg: ASbGnctS2WU3RF7GHggrlE7Y2esVL5V8Tdj7fvvpPe9XmGvzh3lXygz9b5Cf/vltXyd
 X84EH6iUtlj+gJNkzWgXzSrxiwEyaJs3870j0z5IZWJ+4CmnKqfxokA9aUf6n2bFGStMkJj02wp
 0PwGVcZpY5Qk/smyeZplnkeUmyZrfhRk0E3r/8f3jOHdhOfoMGUVFocxlm5IRb3qLxJ7ni00gUS
 0tU1ywkS12oGBgFaYxaycoamW5vVIGiRxYMuR3BmZbzAXypux/f5dKosQYfqneYGvoqScYUigPC
 vRAVjhPeOvw+plNculEvXdsM559PCQCn9gHPyArd+m7J52Q5O4R/nFip1h58mK/g3DJiJuhm4y0
 ZM5KFkYUWtHwaBIOjrff3WMstQARfsinPs3arwQLGo8SBKBFkTNrYwmyJ3EzCz6eUtj7JBdWoHX
 IkzD1KdNcIyTQyQ0FlDQy7uMWWzo9kpR1WzNSR73uexEtHdeg+MA==
X-Google-Smtp-Source: AGHT+IEYHngyZDX/D/9u16h2PzJ8SSC+ElNyf9K878O8gMO+V5XlrY1dOtEAOSNliiRGt4EXJaIiGQ==
X-Received: by 2002:a17:90b:3947:b0:340:6fae:1a0c with SMTP id
 98e67ed59e1d1-34083070e80mr6001204a91.21.1761945323538; 
 Fri, 31 Oct 2025 14:15:23 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b93b8aa3ff1sm3023320a12.14.2025.10.31.14.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 14:15:23 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de,
	qemu-devel@nongnu.org
Cc: sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 0/3] HP-PARISC 82596 Network Interface Card
Date: Sat,  1 Nov 2025 02:45:13 +0530
Message-ID: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pj1-x1044.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Oct 2025 17:26:56 -0400
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

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

As part of the Google Summer of Code 2025 program "Implementing LASI
Network Card and NCR 710 SCSI Controller Device Models" I fixed various
bugs and enhanced the existing Qemu i82596 network card implementation.

Specifically I added the following functionality:
- Monitor Mode
- Promiscuous Mode
- Support for linear mode, segmented mode, and flexible memory models
- RX Timer
- Bus Throttle Timers
- Support for Little Endian mode
- Accurate CU and RU transition State
- HP-UX Specific Behavior Support
    - Support for Loopback mode
    - Self test
- Statistical counters
- VMstate descriptors
- Polling mechanism
- Transmit and Receive functions

Please review this series, as I'd prefer to get them included
for QEMU v10.2

Thank you,
Soumyajyotii & Helge

RemZapCypher (3):
  hw/hppa: Enable LASI i82596 network on 715 machine
  i82596: Added core infrastructure and helper functions
  i82596: Implement enhanced TX/RX with packet queuing and filtering

 hw/hppa/hppa_hardware.h |   20 +-
 hw/hppa/machine.c       |   25 +-
 hw/net/i82596.c         | 2468 +++++++++++++++++++++++++++++++--------
 hw/net/i82596.h         |   74 +-
 hw/net/lasi_i82596.c    |    6 +
 hw/net/trace-events     |    8 +-
 6 files changed, 2089 insertions(+), 512 deletions(-)

-- 
2.49.0


