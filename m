Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0083FC52D6D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb77v-0003T4-N4; Mon, 05 Aug 2024 19:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb77u-0003Qz-5k; Mon, 05 Aug 2024 19:28:30 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb77r-0001NO-FH; Mon, 05 Aug 2024 19:28:28 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so28009a12.3; 
 Mon, 05 Aug 2024 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722900504; x=1723505304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zX611xNhJwGNque8kF8FVT+t2czRfZk5H6ijtB8fyTc=;
 b=c5vj+aU5i1Nqyudvpm89vR6qAZ3ifSAT3FzJ7UwvR5tQxvZ6/Zd8h8hE4986CbftSP
 QwZiuKO36jNu/tORxWf1opmG9hWtoIAWTtnxMQd3ruJ9yjc6UgrGoZ/KF/i4rqMhZ5oY
 /gtQBq9/ZMJe9DfNxrzd757guV/3ii/S4qTgZpLQZ0pZOpfYFZ5KayTXVtpmGTDUicsI
 LmvUTJrp07+qgEkED/+nF0Hktikjf/JqzOxnCDFXAdWsbUIbETcxucbN7xF1KDHE7ycZ
 5fInDkuEOpKNnvluyI9DJpkjTI5FM0c9F8ADFl6yaCpIa9T3O2wWa0SwPdHWi/UhSIGo
 ZQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722900504; x=1723505304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zX611xNhJwGNque8kF8FVT+t2czRfZk5H6ijtB8fyTc=;
 b=jnvx9MzssTispMEnSwFXNpCCY5UknPbfj1C720P/yLKhhg+XghQ9E3krZu8QKIh6dJ
 +eVYXBd8kOn2+vKJOKu+wFgx2S7dM+ZbZL56NvLOO+arHaTY+rUjR5fG1OGHWBke9yqK
 GiCONLlW61ZDXnf/ZouDA7w0cBIZANCU/RGFcMCGJlYm8UpSbgQ/nWP5C9B1fGn8WXOA
 tjEGBHMESrCbxhMTbG5kO6z1CqtHY9FqZlX59j2d8sM1gKgg0+F2VScZYExQl9ViSJT6
 4VseiQvUrHmDuGR3G9uwN6chxvK3l2VN7xbynBBkpkDjrWLPX4upAGpvvUxFxKza/bTB
 gsCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlvITKNRFDIJFzpeDwTEu3DQ/qd10j4R+IRuk9ebpV9VdB+0pSaqtyUnRrMIMJpOsxUorSugvzafFN9FphPXCKSOn9
X-Gm-Message-State: AOJu0Ywq7m0Q7+tlt9QKhNR/AWRXt2RhQZ5/VdqgFLb2j9WZB6QBS2dY
 hIyKb9H3Jc5akrdQF1Bj4hkrOUEFCqwYEi3byJwsgMe8kLQn68XLEEPgTQ==
X-Google-Smtp-Source: AGHT+IGuGVB5UY5Dee8cuMAI+vU7Zw6q6dx5xxqpkeh9m4PcanAk8rqM1zy0+YrkGdEF3BhQiFkatw==
X-Received: by 2002:a17:90a:9a82:b0:2c7:700e:e2b7 with SMTP id
 98e67ed59e1d1-2cff95829c6mr17488586a91.39.1722900504039; 
 Mon, 05 Aug 2024 16:28:24 -0700 (PDT)
Received: from wheely.local0.net ([1.145.206.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffb390be6sm7659100a91.51.2024.08.05.16.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 16:28:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/2] tests/avocado: Fix exec_command and enable ppc_hv_tests.py
Date: Tue,  6 Aug 2024 09:28:11 +1000
Message-ID: <20240805232814.267843-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This fixes an issue with exec_command eating console output and causing
the ppc_hv_tests.py to fail. A few other tests also use exec_command but
I didn't see any that subsequently checked console output.

Thanks,
Nick

Nicholas Piggin (2):
  tests/avocado: exec_command should not consume console output
  tests/avocado: Mark ppc_hv_tests.py as non-flaky after fixed console
    interaction

 tests/avocado/avocado_qemu/__init__.py | 7 +++++++
 tests/avocado/ppc_hv_tests.py          | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.45.2


