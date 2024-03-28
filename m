Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC81C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmnk-0007Kw-NU; Thu, 28 Mar 2024 06:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpmnj-0007Ke-2H; Thu, 28 Mar 2024 06:16:03 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rpmng-0006Ku-K0; Thu, 28 Mar 2024 06:16:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so448687a12.1; 
 Thu, 28 Mar 2024 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711620958; x=1712225758; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nO5Pc3Yk7iDjfNtha9rPonDB4ZZjGgeVMzoVAH/cY54=;
 b=ad/lRGg8gBqTShNSHWS+opYtB1DFwrDJ/0zFDiAG+DBHrltzIUG46HGYn/11AZKe7V
 mvFuAnw57eUWRq7qSRIfa6wbG5VNG/uahW56tdbEWvQopOwWFFYk/SxmxKseu4QmTF+1
 rPhT+VEB0eTNhrL1oeyRibIm0IABRn5RTS+Nh4d7EJCCZT/z9u6XWRxUFW2GeoPLi4Sb
 rlUJunjcBp4cDcSVujjDt397UrN39CDQTFz6Hh0BbpTDKWDwnr1bphjXJK7YIyLX6qNb
 TQ6RExATtoT8HQVW8wOwGGLgHhDyn/VmwWrv0I9ARTuDYBxqvHjMAoeR4Wj3sJRTcn00
 asHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711620958; x=1712225758;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nO5Pc3Yk7iDjfNtha9rPonDB4ZZjGgeVMzoVAH/cY54=;
 b=wy38DlOVCDT9Cl9JQLiBvkEVaTkV+5RTF5mTbJ4k+49OlJgVs8BR0DucJH6SVqNfWS
 47Aa2PEKnkUFE+339oBr4QXxR4CDotkudrFBJh99e4FxoL0/y5BUmptwdOHpXyAnJxEF
 BahXbE65A/EVCtiKpVvc6oizSYGL9CJ4XxPgtAf+Ceb5/5v3yPgmH9W81UQKgqTKFGqn
 S+ti3XVenCi1xmYK3lLN4u0Cwa5ehFfpHCSU0kzjv417ZJFk1hVc+7qojhSuT/XFqOf8
 dx/QES2bTsLJxITYkWT4gCrP8AlAl/a8Ti6w7veHa2gGZ/2FuSu6Lm0eRv3nRvQoQt50
 Xo1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhshe1oZnMGLqkFsXzrIS1geUGOKLKKVA2zDol9hOtDzLRHgm+ZP7q59jZRtpnneQBUgN4xYigiO52p6KPksJVHcmXP59RJGqhmV8QM/0ZwB2i94bWvOD05CA=
X-Gm-Message-State: AOJu0YyTo3cem3nvLmo1+QfwmzSfUgHC2nVFs6qpuFPt1pWxSyvzx6Da
 S8Fsryp09d9QFW2AG3POngEy5Vy2Kc7sKs7pkzSJ80uvfY0qIuGx
X-Google-Smtp-Source: AGHT+IHApG7452zB262NnsIP3aAydg7hfYuto8iXXyO8EyEvzZrxQy9ExoK19WJxOz4ONGb/HIlxQA==
X-Received: by 2002:a05:6a20:7f92:b0:1a5:6cc4:6aad with SMTP id
 d18-20020a056a207f9200b001a56cc46aadmr1576568pzj.6.1711620958151; 
 Thu, 28 Mar 2024 03:15:58 -0700 (PDT)
Received: from localhost ([118.210.97.62]) by smtp.gmail.com with ESMTPSA id
 lm14-20020a17090b334e00b0029bc319f7c9sm3145437pjb.39.2024.03.28.03.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 03:15:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 20:15:52 +1000
Message-Id: <D05AZMB7725S.27E3ZJNW7GJAF@wheely>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/3] target/ppc: fix tlb flushing race
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240328053131.2604454-1-npiggin@gmail.com>
 <D058D0G7Z2DX.L8OBHHBGWGU4@wheely>
In-Reply-To: <D058D0G7Z2DX.L8OBHHBGWGU4@wheely>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Thu Mar 28, 2024 at 6:12 PM AEST, Nicholas Piggin wrote:
> On Thu Mar 28, 2024 at 3:31 PM AEST, Nicholas Piggin wrote:
> > ppc broadcast tlb flushes should be synchronised with other vCPUs,
> > like all other architectures that support such operations seem to
> > be doing.
> >
> > Fixing ppc removes the last caller of the non-synced TLB flush
> > variants, we can remove some dead code. I'd like to merge patch 1
> > for 9.0, and hold patches 2 and 3 until 9.1 to avoid churn (unless
> > someone prefers to remove the dead code asap).
>
> Hmm, turns out to not be so simple, this in parts reverts
> the fix in commit 4ddc104689b. Do other architectures
> that use the _synced TLB flush variants have that same problem
> with the TLB flush not actually flushing until the TB ends,
> I wonder?

Huh, I can reproduce that original problem with a little test
case (which I will upstream into kvm-unit-tests).

async_run_on_cpu(this_cpu) seems to flush before the next TB, but
async_safe_run_on_cpu(this_cpu) does not? How does it execute it
without exiting from the TB?

In any case, patch 1 to make it _synced, plus the following,
seems to close both races.

Thanks,
Nick

---

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..c44e0ce687 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3495,6 +3495,7 @@ static inline void gen_check_tlb_flush(DisasContext *=
ctx, bool global)
         gen_helper_check_tlb_flush_local(tcg_env);
     }
     gen_set_label(l);
+    ctx->base.is_jmp =3D DISAS_EXIT_UPDATE;
 }
 #else
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/tran=
slate/storage-ctrl-impl.c.inc
index 74c23a4191..673e754404 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -224,6 +224,9 @@ static bool do_tlbie(DisasContext *ctx, arg_X_tlbie *a,=
 bool local)
                                  a->prs << TLBIE_F_PRS_SHIFT |
                                  a->r << TLBIE_F_R_SHIFT |
                                  local << TLBIE_F_LOCAL_SHIFT));
+        if (!local) {
+            ctx->base.is_jmp =3D DISAS_EXIT_UPDATE;
+        }
         return true;
 #endif

