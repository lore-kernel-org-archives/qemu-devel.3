Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6891C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9xH-00044V-AC; Tue, 09 Apr 2024 07:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru9xF-00044G-LZ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:47:57 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru9xD-0004Zn-Vq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:47:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so2002527a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712663274; x=1713268074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GbC3rrgpJc0Sn3by3trh+q6pYI0eXERbUUdEG57UqxY=;
 b=faiiqPCTp/IlMYzFA6AF65LMdIeqDVimP13QirNp0n+8kqa5tH+lhbFZwYeiOkOyfj
 l+gkn9+CbvaRqnsiJXRIgsN8+l1ZZYFyetkkSV6czbzSgBuypBVPJHPzcHemUgVFDYTe
 TCORdp1RQNPDQ97Coqj3iSgV9tU5od5s5z+wk9CSWv0JtbuDzwigUWzFKPMs3OP6UsI6
 wPUfrZKVdIgv4nB720Pi/7Q7g1uKvpTG2lYVkp2vZ7jAdFS5DRkVkGucBN9Ljtqz4mxO
 o09OhtONUT2t1RO4QRereH5HSTTv/QTYH7CccrYzwAO80TygdcUJXurFQMZo79zDU4YK
 mFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712663274; x=1713268074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbC3rrgpJc0Sn3by3trh+q6pYI0eXERbUUdEG57UqxY=;
 b=AqXoUw4K9GitSWXl9BKa3KV9pPX6fbA0TLfFnmXW8Tv8EUmKsxc29UlVn3/Pk/FyTT
 RtCv6qbZQSv6mixmKfx1aXMA+ziINs4t+BLgaWenlkSg8RN2PHAd8PvkgUJPWtnAChjr
 YnPthgVjUF01h0qtgWg3GLMT2TelOcokb6hax1/2xEX3eukrw25FeoY62N7iTOHfbs05
 Au8Badv4CmMUag+I3kCWunHNF97kZQGpLFodw7ASJb3Af4s41nSTjWmfJmaoVhw+PpwB
 /9ayCNmukLPd4/3E4bg+GVHv5tSA0+vvkXfQqpZN3OligOtx0sZ1PahqqBcrq/gFwOh4
 JjaA==
X-Gm-Message-State: AOJu0YwTS3WYcsbuY3rtR5iiUdByTuWKmyXkWssN0AYtltXPApitp4Gv
 AEISn/PEv/bs87VZAq8VSYnlSOTDpFyOQIWgKqGyIFAJCPnpglnMzXf9E7LSTxFXEyFcJAJvPnN
 dQ49gp3q6pL4kUcYW8UpO773l960crY5uiTrEFw==
X-Google-Smtp-Source: AGHT+IH4Ql2Lmc3T++6/KMAOfNM0FYBpvnF5K3O0w+olSbJrOAGraDyUwsENfn5k/2cDWLB02aJFcLdli+dyzeupZJk=
X-Received: by 2002:a50:9e24:0:b0:56e:6aa:c7c4 with SMTP id
 z33-20020a509e24000000b0056e06aac7c4mr7363448ede.42.1712663273801; Tue, 09
 Apr 2024 04:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1712647890.git.mst@redhat.com>
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 12:47:41 +0100
Message-ID: <CAFEAcA_PMkyG6TWspMRn87L2FE67ev3nr0nJoR=+NRxBXUHToA@mail.gmail.com>
Subject: Re: [PULL 0/7] virtio,pc,pci: bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 9 Apr 2024 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:
>
>   Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to e1999904a960c33b68fedf26dfb7b8e00abab8f2:
>
>   qdev-monitor: fix error message in find_device_state() (2024-04-09 02:31:33 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,pci: bugfixes
>
> Tiny fixes: important but mostly obvious ones.  Revert VDPA network sim
> for this release as there are questions around it's maintainatiblity.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

