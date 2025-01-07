Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49244E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 09:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5xH-0005ON-IJ; Tue, 07 Jan 2025 04:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tV5xE-0005O4-Nw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:32:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tV5xC-0006JS-A2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:32:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436341f575fso157547835e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736242367; x=1736847167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hbNuAPn7hxayP40gKEn2Lsg7pTuI5gIuYSBkaIM8a3g=;
 b=cF0FMz4zlBu3J8ifH4jTypRr4yQDXUuKTP7/T05+FkAjd53LMWnRADJf7Mxqla7Mds
 byeznv0XtxGwiaMnbfUiYvFLZX9Q0AYRFSBhKJEQsRHb0ym3QHUprJ3uRqwxF6tV/Ado
 OQMT/ePT11W7+r/3YFHYZDZflrB/WsNWQWn0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736242367; x=1736847167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbNuAPn7hxayP40gKEn2Lsg7pTuI5gIuYSBkaIM8a3g=;
 b=if2H31ngyG0NP9AzRV5BonD0c5DZo67LU6sbNiZCdSFkmuqZeF2+9Jau6gZc4GoiTb
 uF0kpUSIYiqhiNJ5XImjzkKbdzyFBOP1WMWEUpkWRP8DoK9xRvo5gFD252dz/aEAFI06
 mS3VxBd9YPSSbkOIgv0HjIslANcy1/0T2K5CXmK5Zxgpt+0KgTjs21MEkx5vtPZIxWaD
 CX5VPQfvviPapm+lqFBAchAt/QrweTClQBv1E3WIc1hh5M9Gw7LqsrIpNvTPwpDjI7mh
 rGZJZH2LlyeA/VE6+eNOZZbAeInMjGMO4gGhXl1hVM9gKlWdI55EpgMnX+hOwG/bwG2G
 M8Tg==
X-Gm-Message-State: AOJu0YzWURhysRCs3tcZYvKFd2cx1kdQjiTZm9BQDAkzke6pdtkXvFpT
 tOQCv0eGwQ4ifFvHssBlGrhG5jdOQtetJlvDw8Q09MK92dXwKIsDYq0rsNXN6lYcu6d73mYccZm
 k
X-Gm-Gg: ASbGncuu7xTB3cEr8L6TvM+DxDMcqhB7R9VWSRLWbHKauh+bNukY9RWp00bpwAoV9wi
 7hncXMVQiMCgQeDIhP3UuiYiXa1YzJhQ7JdBhKL7F4NddW9uuK9ecZwl9x0SLSKJfi9prYK5jMG
 b0d98CKzKi/orPHZFGVqUoDMc4sOAiVRs0FrnF4+xxfw1fVqsty6RenP30okjbjb/8J9v7RXb/D
 zRjI6Hjf1vFRnFzhAY3U1gfcXdilCUQWsJwdrF/KweiTg9oe6Ymcfw13S5VUg==
X-Google-Smtp-Source: AGHT+IE77CLLM3YGCd/14pEq5ORK2y/OyiPHY51e0671sdQFMopdoXlRdP4mxzp7KExH+LVBRP3azQ==
X-Received: by 2002:a05:600c:1550:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-43668b5f892mr464048705e9.32.1736242367483; 
 Tue, 07 Jan 2025 01:32:47 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea423sm599220895e9.2.2025.01.07.01.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:32:47 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 0/2] xen: error handling and FreeBSD compatibility fixes
Date: Tue,  7 Jan 2025 10:31:38 +0100
Message-ID: <20250107093140.86180-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=roger.pau@cloud.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.179, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

First patch fixes some error handling paths that incorrectly used
error_prepend() in the Xen console driver.  Second patch removes usage
of the 'm' character in scanf directives, as it's not supported on
FreeBSD (see usages of "%ms").

Thanks, Roger.

Roger Pau Monné (2):
  xen/console: fix error handling in xen_console_device_create()
  xen: do not use '%ms' scanf specifier

 hw/char/xen_console.c | 15 +++++++++++----
 hw/xen/xen-bus.c      |  7 +++++--
 2 files changed, 16 insertions(+), 6 deletions(-)
-- 
2.46.0


