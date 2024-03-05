Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298C7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVBP-0007p9-Hi; Tue, 05 Mar 2024 08:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVBM-0007n4-L1
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:50:12 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVBI-0005Hu-2M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:50:12 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d382a78c38so35309411fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646606; x=1710251406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vvh3BOErpTIPFZcQtZlvU5mr9taejQuOII5lztLj1yc=;
 b=BW8e1lHirUf0fNEYfG+nGqKgIV8tew2CfFs1Vg/Q2K4OdBIqwqMOmsgLSkv+zn6DBQ
 dwkNTf+QmgimzvkH7ASFKbTjpUQiCQRYYG8fSnybo5OTG+I5OoGOr19BVDmXxo0nLfQy
 hmWf6fGEGRLFKTT32woP0l1m/IA0UZvLl50SMX+gIH0CtEAiU55umLVYC2V1gf2pVh/+
 wu8nE2R59dGdVEjTy8z6Wl461fvVyb9eqOYh33VSTcDVTMARBqGKqgxmODxDrFS34VP+
 z9YGo8zi0QbsRWHJCbAjNVGpGm3dA3dz8CuPBgKc6Dhw25AUlhJgkBzvg/puxnYF6j78
 4Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646606; x=1710251406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vvh3BOErpTIPFZcQtZlvU5mr9taejQuOII5lztLj1yc=;
 b=NdBINFHSJSMP45Z2+guhz/GgFlLKswYZhv+XVBWDeBUpLA2dfIDTXcw0M3/rPhm8kf
 J3jPXw0tiJ9FhVGPqJkXFDPXmlNTZsvQ6LzBMZ0FSBgn6OUd5jvj7IcCPejHBlFyTMwX
 Eh1om+3yV8jJcl11i9GkJuN5PH8jy7DPc+0mIRxEppB06kM6wivV/tt5kNskioKCOkKW
 Te+WN4iJiffU71DR8W0K73wQRqe1KTkhOOvwsRoAMFftvVg+cnsLj/UjV0sfaTJuSRSG
 MXDZNOaomwfnXwRz5SrnX11kVerEjnl1toHhpjtzJreOHfIiZy0HWZpCFGulEv1Jpn+c
 jbew==
X-Gm-Message-State: AOJu0YzSMGdxySB2HStLxaedTIHL7ghEaGc6pJ7fZtAJYvHKD6mltiFw
 IR94YKbaotj7NLHqyaCKPNYxMnwdmswea2MEcp8GnlF3piIbo2Lr0BoNIH8SRcX9sSpeoARbIzV
 SGvw9ClexetfoMkPFuswkF7OaZItnJvPJCHggpA==
X-Google-Smtp-Source: AGHT+IHwjmYVSTGbAcJuAh37esNUv9aS1BeOK4v07ibni67hE+VoGMwZGe9aLrqMSaHsQEPF2vwSgW5+Su4HgT6Zm9Y=
X-Received: by 2002:a2e:95c7:0:b0:2d2:dd4b:4beb with SMTP id
 y7-20020a2e95c7000000b002d2dd4b4bebmr1343598ljh.1.1709646605822; Tue, 05 Mar
 2024 05:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
In-Reply-To: <20240304135145.154860-1-davydov-max@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:49:55 +0000
Message-ID: <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
Subject: Re: [PULL 0/4] machine development tool
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com, 
 philmd@linaro.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 13:52, Maksim Davydov <davydov-max@yandex-team.ru> wrote:
>
> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
>
>   Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-04
>
> for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
>
>   scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
>
> ----------------------------------------------------------------
> Please note. This is the first pull request from me.
> My public GPG key is available here
> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
>
> ----------------------------------------------------------------
> scripts: add a new script for machine development
>
> ----------------------------------------------------------------

Hi; I would prefer this to go through some existing submaintainer
tree if possible, please.

thanks
-- PMM

