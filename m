Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D9D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBydK-0000jM-Ah; Fri, 15 Nov 2024 10:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1tBydH-0000ic-Vt
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:53:16 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1tBydG-0001zI-Fj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:53:15 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-718123ec383so962889a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731685993; x=1732290793; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VA/50loi5NjMTMFGo2HwYtM5oSTSYJOri70PVWBGp4=;
 b=G7nyEzJ31JGR64iw5PY5qnUrOpqHxW4Y/8KTR2kWEXXwRLx3m6ZbwP2pDuZF276dAW
 s9bGpUcuQj3ertOvhzwpZzYgrultdiVf2MV7YwURLFXKDfHczwlkRHFuBKryV6lj5NAK
 U8Bmc0Ur3ucK3ouKHpMak/4Fkq4o6VkGyOni+lH9p19WYVW1u8Y9m7Qu5M7A+LULOhdC
 kIAnGJvgoHTvfSZiRJUstULIeWM5/OCeYseNbOWcPVl2xD3N8ckXflI3H9ObGGMRH1NZ
 SxJwIM4lWwNPmMiSfwDRxZOQeae8MPf5TSQsLtonhJGMDCOsQ9BMF92opCesc0+YlQZD
 IdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685993; x=1732290793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VA/50loi5NjMTMFGo2HwYtM5oSTSYJOri70PVWBGp4=;
 b=lE4k7NNmLpTtV4Tb4KvY943FZYf18vX1FYADNNIQnY9ActxKvsIm3dbMLSsYWSWuEP
 Nrl2SnBOT5VZQTUeprkf3o95pkEtVDFlulpWcQzpMBDYc1uFC4IcfnzBYjOK2wATinYn
 5SNxApZo10M9YV4WK6NaCohr3CFP+bzsrzzTqpWy8pME3ZK1BapnmBCRYaKPL9xNTu50
 azsAu1TnxTn4cgvezcBaf9zBNXUiZbw2GufTLaUEK0JYYNnw5d3QBoB+COs8IuluqQKM
 J8BB+YQaRPSRXZlDkvmpsifMo7DjWmX5DUqlBWUxBeSj9Mfk7z00B+q+Wo6peOetEQ53
 LAwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/BHL2WCyyTdHLeYv8pFw4xLm+63TAUhiCySnkrMEtPiKkHr/2ITeQSdda1+TEeTOUGhvn76L8iXG7@nongnu.org
X-Gm-Message-State: AOJu0YyfVHKhd5uWsPCfa+MaCFLYhVUF2P01ykhHepbSPKELH8HpY/oW
 IBWStgXQxDl6Fb19bhwGrUFIqyZu5ErDRfBxxy9SpP02ACaLPTDXom3W/deTk8kTeUNvshwy2Wn
 PQ4WRr/mxj4lFu3qDG3IbGigJFwXxzXR+MF8x
X-Google-Smtp-Source: AGHT+IHCU9yraz6KGzXRkpnf5Z2tuRalU/5H9Nh3BdHU3fMJsGzc/EV2hrtR75EzBa5d7rHqhF6tJIi17guZHUku7V0=
X-Received: by 2002:a05:6830:600b:b0:715:3f20:bd47 with SMTP id
 46e09a7af769-71a778f800fmr3752797a34.6.1731685993126; Fri, 15 Nov 2024
 07:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
 <20241108191024.2931097-3-roqueh@google.com>
 <CAFEAcA8W2nfhmB8o3ECMwkj3_v7e0bz=Qxs=LCEui4LdBVHQNQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8W2nfhmB8o3ECMwkj3_v7e0bz=Qxs=LCEui4LdBVHQNQ@mail.gmail.com>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Fri, 15 Nov 2024 07:53:01 -0800
Message-ID: <CAKbPEtZdiOKC1B5RQiPJuOmkFUkE6cWxerhA7TQ9tTEtrqATng@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests/qtest/cmsdk-apb-watchdog-test: Parameterize
 tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=roqueh@google.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

I'll edit the g_test_set_nonfatal_assertions in a separate patch
explaining the reasoning behind it in version 2.

On Thu, Nov 14, 2024 at 4:55=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 8 Nov 2024 at 19:10, Roque Arcudia Hernandez <roqueh@google.com> =
wrote:
> >
> > Currently the CMSDK APB watchdog tests target an specialized version
> > of the device (luminaris using the lm3s811evb machine) that prevents
> > the development of tests for the more generic device documented in:
> >
> > https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-wa=
tchdog/programmers-model
> >
> > This patch allows the execution of the watchdog tests in an MPS2
> > machine (when applicable) which uses the generic version of the CMSDK
> > APB watchdog.
> >
> > Finally the rules for compiling the test have to change because it is
> > possible not to have CONFIG_STELLARIS (required for the lm3s811evb
> > machine) while still having CONFIG_CMSDK_APB_WATCHDOG and the test
> > will fail. Due to the addition of the MPS2 machine CONFIG_MPS2
> > becomes also a dependency for the test compilation.
> >
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > Reviewed-by: Stephen Longfield <slongfield@google.com>
>
>
> This refactoring mostly looks good.
>
> > @@ -116,16 +164,21 @@ int main(int argc, char **argv)
> >      int r;
> >
> >      g_test_init(&argc, &argv, NULL);
> > -
> > -    qtest_start("-machine lm3s811evb");
> > -
> > -    qtest_add_func("/cmsdk-apb-watchdog/watchdog", test_watchdog);
> > -    qtest_add_func("/cmsdk-apb-watchdog/watchdog_clock_change",
> > -                   test_clock_change);
> > +    g_test_set_nonfatal_assertions();
>
> But this addition of g_test_set_nonfatal_assertions() is
> not related to the refactoring and not mentioned in the
> commit message.
>
> thanks
> -- PMM

