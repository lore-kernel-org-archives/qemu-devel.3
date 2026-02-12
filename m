Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3587EE369C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYzc-0004Zh-L5; Thu, 12 Feb 2026 10:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYzY-0004Yc-00
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:52:32 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYzW-0006ss-B9
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:52:31 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso1625343f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770911548; x=1771516348; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGhkGI8Vl59Dy+KK4a/9B8/ZMFaZxjQ08Mnnjpu6cOk=;
 b=czDRNsnVj658GKgAVNY9QaeIM+WsLxsRfcxo2Yyf7iDnN0gdt/fLf+/VU1/RAG0u3J
 zWfRzwAkDy635SiUJHRRcGyuTLkvCejUC9z+3eLfji/kImfknNyWymS2rPXYvIWMZUls
 tE/0RacSkLwN75a3Bd/2LfA9L8BMtxRuLwY/nGjmiCeov1ritviAbCmsnqLnIppIfCDd
 GfSaDKJOrGBSyUV8Qs3SQaoyrUs54h1QsDGQXkvUKEP75t0UUDQPhDolaJe9ybQv343G
 efWCt67Y3YMlLZpL6WRkyX/rPan4mh51McVP9pRYvH4RfDnPeIthVBlYsJ5XqY1ueMWo
 BIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770911548; x=1771516348;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGhkGI8Vl59Dy+KK4a/9B8/ZMFaZxjQ08Mnnjpu6cOk=;
 b=ngsV3iaqljo84asqelTi0TTMRCtwUwC+0rbrtsdj7HFB7PgPvT8Y2XH7N3VhGq+0oe
 mieIp2gNyzkj8YZgBt9OUf/rEprypx3t4gozzauAxNXJ1tm6UfOqWw0YjIIm8+pQK8Ke
 3xL/NXyvAPdzucjmkug8fnD8zcaIGY/WJLMXy4giL/hr2iVmYTDzFWBjvTxOYZz/8Yvy
 qlmXAOB6xbWYzgDkTsOWUBPJ2dsFmcgbSN1hBC46J0QJIHUGVDullXebJ/XZkleP5G9X
 h30WcnxFXGY8lNh+hfE3R/FWYK8fcjNbwZnA0wKyNB4O/mGU2bmr/v4tJ7xQJqlWHjpW
 P1/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZGpyHtT5DBdwVkSx9VQqA2IaNqfXbQ2ISmryBZR9+v+dOCw4USBEY3zRALxYNrJCKnOwAY7ZQ6uCv@nongnu.org
X-Gm-Message-State: AOJu0YyYONiyEO70gy8ygw9csS6oWxJoCpWMMcPg7+GlfZAL1Y4f1h9/
 1a54ZO7aBZ64rRwrlGFoAUaeMVT6+dKf4ESnAY9OP9FYSznn+SMiceDUTHB+MkOVpUg=
X-Gm-Gg: AZuq6aIrBYvIpYJL5GPiAT0PBGXk5PGv3pO1xpQash8LkHljCp/i1NQqNZnCgrenUzG
 /taDkZtg9BYWsaAEpiZi/Q0R9DVwbtPix6OI37O+qmx8RS0lQGDJiUFE1kKYbslyAlWEDbxJLfI
 QnRCq6Kw5mI7IhFhYCDavrS/QWouPq5DGUqtTvKoHePpYNBDCEsCApdrlwSSlyM6L0Q2u2AhMCZ
 eFbbtee9Kwbn0YXFxj+1x0QSigI5iXGQA3XDZBmhWsvqSq9+yARrAiFVnJD8ovrS5TGwYTuDG+V
 Y1jW4cZzVUf5eD7rbYEM+jP+PRTWtENFVV3SUCEOu0+sKiXKn7fzjZiEIydNSdx9W4plQWaoats
 gP71irAyluP0IL3PE0WBGT4v1SPlpW6wHuj2sghfomJj93r/ux/pUg+J16SGhXAalrWXHHl7yxO
 YzfwGrXQHCOjXQh4UUqAw/KRoqDeLwah1tYuXDi7LdlZCX3InqpUy5xTJmrS88nGG/Ew==
X-Received: by 2002:a5d:5f84:0:b0:437:6b6e:d108 with SMTP id
 ffacd0b85a97d-4378e6d48edmr5002570f8f.8.1770911548251; 
 Thu, 12 Feb 2026 07:52:28 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d325f7sm13139161f8f.8.2026.02.12.07.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:52:27 -0800 (PST)
Message-ID: <7f6a6958-b72a-41fb-923d-09ed4ab3ab1c@linaro.org>
Date: Thu, 12 Feb 2026 16:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: exec: On migration_legacy_page_bits() & TARGET_PAGE_BITS_LEGACY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi,

TARGET_PAGE_BITS_LEGACY (previously named TARGET_PAGE_BITS_MIN)
was introduced in commit 59811a320d6 ("migration/savevm.c: migrate
non-default page size"), released for v2.8.0.

Consequent commit e97da98f117 ("target-arm: Make page size a runtime
setting"), also released for v2.8.0, enabled TARGET_PAGE_BITS_VARY
for ARM system targets.

Last up-to-v2.8.0 versioned ARM machine has been removed in commit
f54854f9841 ("hw/arm/virt: Remove deprecated virt-2.8 machine").

As of today (v10.2.0), only ARM system targets:
- define TARGET_PAGE_BITS_VARY
- define TARGET_PAGE_BITS_LEGACY
- have vmstate_target_page_bits_needed() return %true

(See migration/savevm.c:)

   static bool vmstate_target_page_bits_needed(void *opaque)
   {
       return qemu_target_page_bits() > migration_legacy_page_bits();
   }

Thus as of today (for migration, which is system emulation) ARM
targets have a target-page-bits subsection, and all other targets don't.

So IIUC we can remove the configuration_pre_load() hook:

   static int configuration_pre_load(void *opaque)
   {
       SaveState *state = opaque;

       /* If there is no target-page-bits subsection it means the source
        * predates the variable-target-page-bits support and is using the
        * minimum possible value for this CPU.
        */
       state->target_page_bits = migration_legacy_page_bits();
       return 0;
   }

Then remove migration_legacy_page_bits(), having
vmstate_target_page_bits_needed() simply call target_page_bits_vary().

Does that sound right (or in the correct path)?

Thanks,

Phil.

