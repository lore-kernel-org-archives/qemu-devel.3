Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CA7CF45AE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLLO-00075k-GQ; Mon, 12 Jan 2026 12:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLIs-0006Cz-89
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:02:13 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLIq-0006Ap-Px
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:02:06 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78f89501423so59069007b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768237323; x=1768842123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5U+EmH1NHUyJCyVLYQH3bGY+ISVEX/Nc+x144y3zxMM=;
 b=n2DtXxa143RhJJ2icEwBA1j7R2VasobonGkE3sVFndQlXXnx0CMMnEAk+loRSVBNuP
 UGpR+8kEzm7Celrw1Kf5GKRFo4370bxqLeR4AmzX5gwnzDYWI2HD75oRXsiYzYGQ8MNj
 9k/rvGJbQymQuecgnBxxGYgor+fb9LgpUppLDEHJMTzRDvZ1s9y7HZqggcY0fKxq0AEl
 G3TV/G7KMWXUovfS5pk2JHcMKGN/sV0PEUCTcpUkrabq8BIvbGYi88V/lAHgqwrfDvsN
 y+0DerSpy8+yfoq/aHPd3gbzwr2R32h92ODFBuPmlzec3G1pwehdDQcDmUOxZ/WuuRZR
 EgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237323; x=1768842123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U+EmH1NHUyJCyVLYQH3bGY+ISVEX/Nc+x144y3zxMM=;
 b=cO/5G4F3mbTPj4DD6Filt2WBkpfpL2TWvGZt1x3R3kMCTElsXA125YMdID94Wg9lNR
 fL6S1duYRDKxOPf3YN/Gvf5rqU31LTkvN30kIRVMx06+fPaZllOanVSsYd301ZMsiT1G
 3fGfc6isc1HRog0Xx2NbauWs7otvVgFbyeC76TH9CJ7BS0Quib5mTwSUlXz8iDdyd2eD
 bBWz54qX4Lut10zOjxh1lM7zgTfxSGTRywdasfrTGkh8Da1n9GhTjflnRQ1TBKtV2poq
 lssQZ2VYCVuef911U5M1SwAQPcZPIO2E5I258QdWvzscYtqUmtT+jezH7dxrvwN74w23
 Jrsg==
X-Gm-Message-State: AOJu0Yy8dgwDaXvnI4xL4mZGOhX0khaJpylAS1+cFrjkc/R0TRK8o/HC
 xQTpLGe55FsJ+FXz7Na3WlLAVBBHEWWw5Hxr1FYLXdMZkbEqTiQLYvFe+NHNLF9nV44CfrZpsfS
 2c2/PdehD6AsFwiBnyCGrne2j4lpsJR1yJv8Dh3AclcVcjNHFxOvidxA=
X-Gm-Gg: AY/fxX4KyKxu8NTmNtbQq2ypfJfE2KsGQp84flA/PnlMCfcpszEOBA7b0bzIzh+lrZE
 rtHMvABsyiBeMngaS4vgpYjoDEVt70/1SO7Ld4OcQjffgsfpy07MhdhaZ2br4QwkFUiwoTAqFDl
 VbHcDqsdO5VVmK78CWeGT05pG5iH90xSktKM/l32caPodP/VjU/j4DoUfe4uW0I7Yg90L6rpo7b
 otEm5Ny8RKTtuhxKEVk7Ch3URNOzF52khrjhlVSUUnmnvr27MWVHQ+9QjY5zyBpOI7PhC18ENvT
 Zrg3bfW3tzyeQavgSXdPGZg=
X-Google-Smtp-Source: AGHT+IHo95rgvdbUh+BH4AS6xEmnr3edzqzOvJ1ZbWYebkXySFPY7L7qX0DhE0d1WA38j9vGTL9voEUd27P1/0IMxb8=
X-Received: by 2002:a05:690e:4004:b0:648:187d:83e with SMTP id
 956f58d0204a3-648f62e04b8mr42313d50.37.1768237322905; Mon, 12 Jan 2026
 09:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
 <c8e80923-d837-4874-a072-d5ae579576a4@linaro.org>
In-Reply-To: <c8e80923-d837-4874-a072-d5ae579576a4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 17:01:51 +0000
X-Gm-Features: AZwV_QhRDv73PJ_orOaeMCzp7vAQRNiAOrxIUWNa-XrXwGx7bFmVuILttmqIoGY
Message-ID: <CAFEAcA_iXHEFTJ0mS+kRC=rNxxhyCHyw5R=nQNMXYE03qkBTZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/arm: make granule_protection_check usable
 from SMMU
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Tao Tang <tangtao1634@phytium.com.cn>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 12 Jan 2026 at 16:29, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 12/15/25 4:01 PM, Pierrick Bouvier wrote:
> > This series prepare granule_protection_check to be usable from SMMU, for
> > implementing RME feature.
> > It's based on Tao's commit [1] extracting ARMSecuritySpace from cpu.h header for
> > convenience.


> Another gentle ping.
> This series has been reviewed and should be ready to be pulled.

Applied to target-arm.next, thanks. I folded in this minor change
which avoids the "local variables not declared at beginning of block"
style issue:

--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3785,9 +3785,7 @@ static bool get_phys_addr_gpc(CPUARMState *env,
S1Translate *ptw,
         return true;
     }

-    const uint64_t gpccr = env->cp15.gpccr_el3;
-    const bool gpc_enabled = FIELD_EX64(gpccr, GPCCR, GPC);
-    if (gpc_enabled) {
+    if (FIELD_EX64(env->cp15.gpccr_el3, GPCCR, GPC)) {
         ARMCPU *cpu = env_archcpu(env);
         MemTxAttrs attrs = {
             .secure = true,

-- PMM

