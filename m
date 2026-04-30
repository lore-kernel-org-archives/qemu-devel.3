Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8554FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIQwx-0002mD-EF; Thu, 30 Apr 2026 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wIQwt-0002jr-WC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 08:57:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wIQwn-0001zI-42
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 08:56:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82f1bfc9b8fso440188b3a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777553567; x=1778158367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVS0MeFCUiyUGYnEcKm5B8L9PIznlGDL86tmGFdeXPE=;
 b=hx0Y/RAbPAwIzkG20glPuZT4p9dhGBK1xRu38CPSs2xoVzAIeqMzbE8qYuWuJZkIXs
 XxAe6BdpJEOeOyZQ3ljrQCZZfvNpyC5rifNafOPsQbe/pFuwga9OZLdUU32a3a7+BnAc
 /xnv+8oRLryQeZRTDXRitjotO6AulbcakE2K1SLS/JaIwYCROXshRpixNGmmOKIW6S0g
 LC2vfvHxDV6QKPZTKzLjqut+mdAFzBKzVim/KVkk/R9ybdpby3hSSqHhWOrivlAyYCc+
 kar/7Wyg0lV1inHVoNJVcIfHTJQ4VwK2tKw7dyyQ2eb8HziaIkHk4Q70zOIMBV5xoyVi
 eYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777553567; x=1778158367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AVS0MeFCUiyUGYnEcKm5B8L9PIznlGDL86tmGFdeXPE=;
 b=cDFStFtSESOedarv/xduJ37tzelDNuJoXdG+bLuLHCxpLfEcKvGENMtSoMLE2prVJV
 bgJP7a9U0kjm0Vj49GJd84amn2zmw4zWmgoLb5zC7YvpcXjFSHMwCCgSDuViazD3Y/At
 MV/gTZ6ZtQqzNDES21g9HYqBX6OVnW1FdJsP0CnHyLFS+z3JGTvpoTHJAkn5ITlJA+eT
 C4S+1W/LgLeOEwNLJyUE88SJNtJDM51CjqMCG/jLp+hrSBGDsvLvDfDgzAu15FtM51PR
 aQ6fJuFEQhVK18d5o3yDpETSLVU0TkgITg8qtht4Q715KcFvUeqJUFj2FM9FUPc0da48
 0mUg==
X-Gm-Message-State: AOJu0Yy0sTLQ7OYTLpel0+5YKjDLyH7JuVHg/FCA/la4E63f5oeBFS7O
 IxOgjbQPvhl6OBNWkfdmgTCsQCNPM+nxYLUOcfWQpcVTYJRnFDjZW73I
X-Gm-Gg: AeBDiev7zGPPi5FH/FALt1R3MtK84K2swVRABhHKjn7o0KHh8HFXB3HcircodDgm9Gn
 2UyRI/QiklzUSUQT9vH6ka3KdH7l/0JZUnEAxM66/oXALJxXGFvvnku6ZSAiN8OKev6bbjX1maR
 LQqU/zWN4idTT2wVPgJh5Y6ZZV5TmeaX6ARkyyzwMRZLI/F6AuKmIHPadAoEvc2v8kO0Z0J5JAp
 4/OfJHy3bzlbkC4EQ6EAk59jykVnGGGL6ZBxWJhSqJoopjk0dhJbFiukKNZUsYzpqxDmlw1ePKB
 m9I+Cv0ogW2Tdqz42KdvDI0M/QjRVYmNZZPzcPYoJvOYNuwH/XZs2sTa43MuIRMI7Pu9fgaW0Vd
 lLIqTjZjI6X32OE4/u2wmZnK5JCjmF25bc+wU9LWGLTyL+8AvbptsowqxIvGVT8/OXWrsoaVAIg
 ysXQAVcdc2LVUXjNmYy46I6+WPA3RykA==
X-Received: by 2002:a05:6a00:4487:b0:82f:cfd2:6ca0 with SMTP id
 d2e1a72fcca58-834fdc40c77mr3040495b3a.40.1777553566767; 
 Thu, 30 Apr 2026 05:52:46 -0700 (PDT)
Received: from jia.. ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed6debc3sm5167382b3a.39.2026.04.30.05.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 05:52:46 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH] 9pfs: fix deep path truncation in V9fsPath
Date: Thu, 30 Apr 2026 20:52:41 +0800
Message-Id: <20260430125241.3212990-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1954333.tdWV9SEqCh@weasel>
References: <20260428074614.3169999-1-physicalmtea@gmail.com>
 <1954333.tdWV9SEqCh@weasel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=physicalmtea@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Christian,

I agree. Just widening V9fsPath.size is not a real fix; given that
g_vasprintf() returns a signed value and v9fs_path_sprintf() can return -1,
my change could indeed make the failure case worse by turning that into a
huge unsigned size.

I also realized afterwards that this issue had already been reported and that
my patch was essentially repeating the same incomplete direction. That is why
I sent the follow-up asking people to ignore it:
https://lore.kernel.org/all/20260428082151.3234483-1-physicalmtea@gmail.com/

If I understood your suggestion correctly, the short-term mitigation would be
roughly:

  - make v9fs_path_sprintf() fail on both g_vasprintf() failure and overlong
    results;
  - propagate that error through callers such as local_name_to_path();
  - make v9fs_fix_path() return an error as well;
  - and if a live fid path cannot be rebuilt during rename/fixup, clunk or
    otherwise invalidate that fid immediately instead of leaving it reachable
    with invalid path state.

So this is not just a local check in v9fs_path_sprintf(), but also error
propagation plus fid invalidation on fixup failure.

Sorry for the noise, and thanks for the clarification.

Thanks,
Jia Jia

