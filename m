Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D59ACCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kiY-0001Rl-8h; Thu, 09 Oct 2025 03:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiV-0001RH-DN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiL-000799-Pf
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so521172f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759993514; x=1760598314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zppFBoL3kl+E/Itv8sKUV2nh2hWK12KXmO+JPwf5PB8=;
 b=WBOw9Zmbcdu5qvWJC3B3U71JyMQz+ArFrovmx1mjUWzuBmUXJ0GTm5NTbdj0Io28/p
 PsX4ky0A6j7NeBw7yLlygc5Vkv4qnb88dH0PHnA9nvs+4k0+z7Of0DIvmqtmOGd9XI+G
 WB+2H6Lfd+QFJRYhzAs+CdZwhNOhCvrwV8CpxaGmK7HLBKFn5DddnUcJ6ajVrMrXjO2x
 1JbyyKy5dGn8UU/1jB2D9tZ4MmL7moOd4nIY8EhwCwrVMu5OuoFPleuemcMu48Zjt+3m
 wxKCInqJGwGpBF3qPf9uqgf3hdvqc7LLX4BMfIn/Vx7CMtDmnWVQDe6cMyuKPSw4VWrW
 UNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759993514; x=1760598314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zppFBoL3kl+E/Itv8sKUV2nh2hWK12KXmO+JPwf5PB8=;
 b=I+lO2jRZm4EdK5QPwCxoV7K3/yLkpyoHD3UkHhDapOIbcb6Ac96Zut3hhJ6uiqgfb2
 96Lcz10dBDvdfKnBCteic2og8cTUyemlgpn0lENjymk9PdIARtvqSfugzTIiwHlSBb6S
 hvQYN92zTcxndQDIIqG5TAO5tRvxzvUjFSW/ZgvQgjocdrMOZn2tcfshV7TBRhSEQLcG
 eOURYAkNMhFFsZq/4+DWQSuT7zuuNgCUph8LbcR+hkOW9Rx0muxrxyNTN6nACMQBwPOh
 Ejcmh14XLfpGCj0QeCC7QMHtgyfDgFsbWUwe3Z3tgLY5VEKo0MWvm812oaf5DSK07JLL
 LqPA==
X-Gm-Message-State: AOJu0YzuN+nfCju+dJQ03EJlwUTLlIozsbwR1Wjnc9TnnB47rmHXPE8f
 r82jpNX89XJb7Qm52RZe4lxOUzh7C5dHvRqNE7JQJBGmdQ76MS2tbZCWWKITOsh94+i0hNceb+R
 tmdenWWiNOg==
X-Gm-Gg: ASbGncuXY7l20AH0Wt3im09kSK01W9eEbBb7Uzj8Q4EKoD+8jJB4QAmV/s44l5qTvNB
 XItc0emEBSu90mHtodsX+j+aH3q1/vKrli+1dYZ5igzHFFywef+sUZ1tIPsQ0eHoGSfoDGwZHPA
 1qeie2Eec0Z5KvEsiOoOtk0o7Bg7+D+bAAzdWvhCrX52FBhjciLr4a2u7fGRRls/SJioI/26y8s
 7yIOskcaKnCuyDlDNWWcdmEgg3tCbJK9Tij8Z7O+JdXdNNLmbFqkpS8BiJwOoZZKRiWfrI5feau
 SUKuzA80VeM0v0G/4wrw0bRsEOn4DwIs/qoYRQikC5h3YOPUg6RQeRQrvt8RDnzT+PY81Xzwcoa
 ou4F1x7AGdwSx+3ql81yG/EDL5JBEpsSRCSN+To2rcTSUxr+8yMkbogXsu0FxIUrbWk5ukdupsL
 EkMJga6uUrBfGomis2uFoLMtDD
X-Google-Smtp-Source: AGHT+IFgY8s1JvAPZ8qiGoNgobClUzSkYVBvrC5qtZZHD/hznuwm/bJP8cRaM+AZ5WZFUIhOnXiqJA==
X-Received: by 2002:a05:6000:4305:b0:3ee:13ba:e138 with SMTP id
 ffacd0b85a97d-42666ab9934mr3692662f8f.26.1759993514513; 
 Thu, 09 Oct 2025 00:05:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f017esm33873337f8f.47.2025.10.09.00.05.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 00:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] mailmap: Minor fixes
Date: Thu,  9 Oct 2025 09:05:09 +0200
Message-ID: <20251009070512.8736-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Few fixes to help git-shortlog processing.

Philippe Mathieu-Daudé (3):
  mailmap: Fix Denis V. Lunev authorship
  mailmap: Unify Clément Mathieu--Drif emails
  mailmap: Unify Richard Henderson addresses

 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.51.0


