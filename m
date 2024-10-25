Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FFBD149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OVS-0000ir-3Y; Fri, 25 Oct 2024 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OVO-0000ho-I1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:53:46 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OVN-0001fk-6I
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:53:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ed67cfc1fcso1480464a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729878822; x=1730483622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eRc6bJn8Cgf6Xv6cxP4tjLk2MH+WVOQ9Tip117N8RcA=;
 b=xxdTa9vvqOAeJx+cn2pf1KjyUL/pQdHRMWmfvMHrpGwDgaWKkZNX6gYeausdi8Bui9
 VaOgwUy9LauveMIHKhzL1dLnXNNLUgWc11zAz1mduK/H+vkT/Q3wo3h0QKXlMfHnly3r
 cco6Y1v8hLyCfhN3DQZJByKqZLOYn31ghp9agOW/93lH4TrnpO5v91tYhXw+3pes1QmG
 wQ5pSpuu//8ec3QabYmoi98NbXMvDDjbwETHJpjrtduTvEcgOULrVhZ47ujcZlwon10s
 hspNgbHDzAhkuhCrEGlpjoPt9tB67EreHgWDANDbPlCb7sFAh7hMVakHtnPlk/NggJ5q
 LpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729878822; x=1730483622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eRc6bJn8Cgf6Xv6cxP4tjLk2MH+WVOQ9Tip117N8RcA=;
 b=Nw8uXfW8vQm5vvitkmAE5/0E2sfL902pIbqRs7CSr6HwaVxAvdb727ufBebk7Ej60L
 s4KhmzCKq3DtcZhOyTT4DxApnUaWzSp471JhFFe/etth/XAupfEJgn4lMd7REGkBoGss
 /qoVuTF8J8QTuC1EvT5VnizsB0iguWqCyNQLvQV6ZIad24K+KNqt7Y6gt7+xqT6dGBZ5
 G4U+q4hStwGS3XxksWp5t2JoIlNIZbDOEXmObBxvyuLWNHyp8UXms789GzQNGZfG+t09
 L+D58BqLMA3P98zzM206RpNhDd7HjRNiIVjm7uEpDu1C49Rvjn9MA6W3eo+SYJF01VAL
 xkSQ==
X-Gm-Message-State: AOJu0YwgxcbxgAWq0RA3u/PAzqyMUyuCRyke+1dabC8nNgy07OBrJ7fT
 IypuX7i6xDgw8FhKmEvC0fiVW8UVCJrcmAbSgA/XFy+BI/S0xu8udyv+BAKCAzUaxfC6yLnRkd4
 gqVnm/w==
X-Google-Smtp-Source: AGHT+IHgosH2FMooDrI1orAKNXwdXtHu4nwySJDZYdTRLczm0VdOaE0GMWCdiRGJQRmPZGeOpND+Wg==
X-Received: by 2002:a05:6a21:3992:b0:1d9:83cd:3d88 with SMTP id
 adf61e73a8af0-1d9a842ce9bmr50673637.14.1729878821942; 
 Fri, 25 Oct 2024 10:53:41 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a3cf5asm1329416b3a.201.2024.10.25.10.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:53:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/2] target/i386: fix hang when using slow path for ptw_setl
Date: Fri, 25 Oct 2024 10:53:32 -0700
Message-Id: <20241025175334.2549425-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

Most of the details are available in first patch. Second one is there to ensure
we'll have a useful error message if start_exclusive is called from cpu_exec
again.

I'm a bit puzzled that we never triggered this hang before. Is there something
wrong with the potential slow path for ptw_setl, or is it simply very uncommon?

v2:
- get current cpu from local variable instead of current_cpu global var.
- change condition to check cpu is running as current_cpu will never be NULL.

Pierrick Bouvier (2):
  target/i386: fix hang when using slow path for ptw_setl
  cpu: ensure we don't call start_exclusive from cpu_exec

 cpu-common.c                         | 3 +++
 target/i386/tcg/sysemu/excp_helper.c | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.39.5


