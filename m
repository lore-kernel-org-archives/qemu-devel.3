Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B900BCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7G1-0001RD-4Y; Mon, 01 Sep 2025 12:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Fz-0001PA-3T
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:19:47 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Fx-00068R-Gr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:19:46 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e970acf352fso3793954276.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756743583; x=1757348383; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FXLr7kyljCCq8Ak4TIu9hyLJj09lg6Gt5VxUZ07ohDs=;
 b=vSssX5XboCPr5jod6HwAX3mrglRFYsiX79R+DvNHC8wKdujwi0+lrd43oFrBSzIh4J
 kUaXebsXS5RAojZyjpAk6UdA+ZcOdNHUeuGMyUdSDaix2bJkmDccwwqUmkzI6wn4G59K
 JEV0OUi+NOiRJIOsldbFW9StBxyVVVE+w+2F0V2/OMfRVJ80aQLBEABVxPEq0iIRu/XI
 3eDTvlKfKymMdwfz1GDGVhJpKxtQZUirg3iXmzLBRIJ/mYpqEdA22ShaZbgUZaXPW5MR
 kymTD2UZcp5iAD2HzIDH1UzixCGR1BzPHqrjMKJ2kqfNdKe0Pnx9GcJ3OinAXXF+5JwX
 rXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756743583; x=1757348383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXLr7kyljCCq8Ak4TIu9hyLJj09lg6Gt5VxUZ07ohDs=;
 b=Q/ceyEVP8DSnoArzCLJxIdMNd04qWGbWwjQvdAJunPgBukg3zDn1kt4/oo2bu2RYQM
 ZpLD8f20z1oSiKK+23PVhrRbof5MoSIcRlz3aXciTegy2vZYAnUk/DHhymckpEZOsmPn
 9uUmRI4nJYC2YWMzFbrijN66X4Gy/2V4LjT6oxT0GbXfP1rYBz5NRPCVOs29kaD5/JGY
 iNOEZwp13Cd15HFdINg9wUKkIcOP21QJZMruGkji20MqomPzmelOrdq87SqjE8tyFjZz
 NfYiYPYq+bG6wKM0LvWC+K1luePrlmZcQ2UJYv3N2M5sHEt069BZmOgTVoD01uYoQBb1
 uiGw==
X-Gm-Message-State: AOJu0YyuM1WTRMiMrqWHS+BjGfdMt29i2tzk9QoHkmCZsfYn20sVMF8h
 TAYJAAQ2qljJOdfFzQhGCKmIe7WaIeUDNuKyLw+yNkojeQjpf82wTFmZMmHyFqM09rTq6bpXYr/
 UdgwsahKvL3aMXLdCWsE1Qb31dhNtaqHH3K2UJfLqNA==
X-Gm-Gg: ASbGnctiJxJikl/RsjMXGUGelMCW1GaUI1PWdivI/o5LWy+Z2J5K1fCF/AEssJXvDiH
 a3udN4fB8fbplwJuDKMPH99oNr7Nifvc4Kd78G0eA+2Ls/5sXiayrtpBZCYO6e/YdM/3edeop3W
 CG24495x3pu7aSrCHVFYDNkrJCeLU76WoVI45hvkSgVm5B68rSu+cmr0rneUbnjBmUdCIyHYdtm
 D1qBURqwn1gHB452lc=
X-Google-Smtp-Source: AGHT+IFbohj1uzUd8XqQkOoTMLHvzrDqq1WTybqpsQN7wt/WMgrmfLZQCkUy/X6Za8kKqLQfBhfypg2Fnf1FpwK2qfc=
X-Received: by 2002:a05:690c:4d05:b0:71f:95ce:ac82 with SMTP id
 00721157ae682-72276333524mr94471967b3.9.1756743575020; Mon, 01 Sep 2025
 09:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250710144543.1187715-1-peter.maydell@linaro.org>
 <f6c75047-d074-4200-a33a-c864e7beadf1@linaro.org>
In-Reply-To: <f6c75047-d074-4200-a33a-c864e7beadf1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 17:19:23 +0100
X-Gm-Features: Ac12FXyXa5isM4OjB-Qt9NG72B2Tav8Rb1MM8_10YqZYZkAdOdBR9cO9eicVKtI
Message-ID: <CAFEAcA8Dz5eic1MfKYjQjtMXzjrM50DmGefABYjKNendicHOSw@mail.gmail.com>
Subject: Re: [PATCH] contrib/plugins/execlog: Explicitly check for
 qemu_plugin_read_register() failure
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

Hi Alex -- this patch was reviewed back in July but didn't
make it into git before 10.1 freeze; would you like to
pick it up now we've reopened for 10.2 ?

thanks
-- PMM

On Thu, 10 Jul 2025 at 16:21, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 7/10/25 7:45 AM, Peter Maydell wrote:
> > In insn_check_regs() we don't explicitly check whether
> > qemu_plugin_read_register() failed, which confuses Coverity into
> > thinking that sz can be -1 in the memcmp().  In fact the assertion
> > that sz == reg->last->len means this can't happen, but it's clearer
> > to both humans and Coverity if we explicitly assert that sz > 0, as
> > we already do in init_vcpu_register().
> >
> > Coverity: CID 1611901, 1611902
> > Fixes: af6e4e0a22c1 ("contrib/plugins: extend execlog to track register changes")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   contrib/plugins/execlog.c | 1 +
> >   1 file changed, 1 insertion(+)
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

