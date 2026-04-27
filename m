Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56B0FF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFHT-0004rk-Ge; Mon, 27 Apr 2026 02:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHFHR-0004rD-V8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:17:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHFHQ-0002ge-76
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:17:17 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so9970310f8f.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777270634; x=1777875434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRTA1Of/sTNluNpVHaDxntK1zm9V+9M+JYMifJrzq7M=;
 b=TgSQmQOKWIurMQBsqrgA1kkrk22wH4Nq4zNlrgzL3JTQUfuo66QlundyNzKFghcAON
 x/erfwkJ41QkHgBjQU55N1CY1pfDqjksv1CuNkgkwHXDfM5pEbJLLbagt1Db89kJeMVh
 JUuOzOClDe2nlrmdLjnlWqm4bXgTzlw4hbtdUGUTq0QPlCYcA7nXs784pnsRaJ1YzPPm
 WooGU+iSAyJyUWO+rxbEfEdtvrNsQFw95QdmN8hOK2kRVe8I7KmJAjZ35N5xt+KJ1mCE
 V5OZB4W8eHhNEo3yTRE6wJTj2ShMZ1cYU3BjWz6QrwmSel7fvg6jnXW7Bod01TcYItTQ
 +WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270634; x=1777875434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nRTA1Of/sTNluNpVHaDxntK1zm9V+9M+JYMifJrzq7M=;
 b=XXUN98vYSkV/3CydNQqbRG8tbNxNbcJg1/Q6HmNyUdK5NKJkLXE6WasMznCU+e9A4m
 t5EVIDgF7uIIatm0q57Hl4hsG9k38yYuXXnIelEzJUpz1xMP/cyJLZIaaSgkwzgLy2Bc
 qecK3LLAI2jB+wjtKLE1Sjji2Dck1cxJbDKMt01EsnxzFuazLl7YVk6Qm7vDg1Lraa0m
 lBfUGl3jcS5gR455eGFu4BEVIsbipSGX8aWzaoXW2V/Q/P0Z911WLS1h6igEuXVffwOc
 w9D7CH0WnhYJ/ea1aqcFroUUgkJaXWpHowzw55BHdm+oyYpSACb1uN7IhD1ZqPv4sx88
 l4AQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qItCIpbbFkR9iSrvlDxyGzLy+fhCB3+6xGva04+YbQMIzxiE3jLiJuKNMHqjcvgKO9sKf5mFBVqD9@nongnu.org
X-Gm-Message-State: AOJu0Yyuy89cck7b94puxve95oouMQ4GNKW36xHdpBTm3+3gj+rwBfgS
 fvEvr4YuV7r9yTq1NMiNEZkmZyaUJW01vgqlctFXmawovosEUx2spoCtJuEE83//GMc=
X-Gm-Gg: AeBDieuIZxd6XIsxY6GHPf4cCmufwxvijoPqlkukv4BHYs3KntK8HSxZmRsfzOvkc9c
 HXHQwm7IS0zTEtfN3PqArRg685OruHhYWcvJDLlJiB80RcoW3dnTD1JS+tpImWTsdey2VBMc5xg
 bGMZ3vlHVDXqWVnfqjWQ1x0zUXi4F43/Qk/51M5aBdeGkoDk6Sb7jhsW1fehv3e2o4ZXUXYmxIr
 39MYZmPK0iLfs3QJa5ZZ1aWqSDcSxWU1bLtYXNsVNsE/tolIsQlsPE4MMvss50wXQYWKlCZoKHf
 gTfvsY38XO6U7OXPle2UP0QpEwNoVqD7rOgkpw7hfn440CN79DMQm5M+i3dJgIEjJe7lp6CN/Wk
 lnpN+P/C9dxQZFN4uIkxTE7WTQYE0Ssapqf22LjrMYu6iRvv3tktZ7a0Rq/Rf44IYSJLoeJcoHq
 EfDeiWezWFh2lkGaW5T2bQTArcoVA/PuKdAIDhgA+8ddpOWQ7Z9/cQ5iOtI0tQRBK6XdW0uIoNY
 VchTBoW3p8xUIQ=
X-Received: by 2002:a5d:5850:0:b0:43e:a69b:d803 with SMTP id
 ffacd0b85a97d-43fe3e23f23mr65130622f8f.47.1777270634341; 
 Sun, 26 Apr 2026 23:17:14 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm69327550f8f.14.2026.04.26.23.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Apr 2026 23:17:13 -0700 (PDT)
Message-ID: <7ff93d90-bbcb-480f-9e46-adf996d149a1@linaro.org>
Date: Mon, 27 Apr 2026 08:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio-gpu: Run reset cleanup in the same BH
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
 <20260424-gpu-v2-1-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260424-gpu-v2-1-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 24/4/26 16:06, Akihiko Odaki wrote:
> Commit a41e2d97f92b ("virtio-gpu: reset gfx resources in main thread")
> made resource destruction run in the main thread, but left command and
> fence queue cleanup in virtio_gpu_reset(). When reset is initiated from
> a vCPU thread, virtio_gpu_reset() schedules reset_bh and then waits with
> qemu_cond_wait_bql(), which releases the BQL while the BH is running.
> 
> That split leaves a window after reset_bh has destroyed resources and
> before virtio_gpu_reset() drains cmdq/fenceq. Other virtio-gpu BHs can
> run in that window, so commands may be observed on the wrong side of the
> reset boundary:
> 
> 1.  vCPU thread A: Enter virtio_gpu_reset()
> 2.  vCPU thread A: Schedule reset_bh
> 3.  vCPU thread A: Wait in qemu_cond_wait_bql(&g->reset_cond)
> 4.  vCPU thread A: Drop the BQL while waiting
> 5.  vCPU thread B: Take the BQL
> 6.  vCPU thread B: Queue a command
> 7.  vCPU thread B: Drop the BQL
> 8.  Main thread:   Take the BQL
> 9.  Main thread:   Run virtio_gpu_reset_bh()
> 10. Main thread:   Destroy resources
> 11. Main thread:   Signal g->reset_cond
> 12. Main thread:   Process the queued command
> 13. Main thread:   Drop the BQL
> 14. vCPU thread B: Take the BQL
> 15. vCPU thread B: Queue another command
> 16. vCPU thread B: Drop the BQL
> 17. vCPU thread A: Take the BQL
> 18. vCPU thread A: Leave qemu_cond_wait_bql(&g->reset_cond)
> 19. vCPU thread A: Delete the second command from cmdq
> 
> The first command is processed as if it happened after reset, while the
> second command is discarded as if it happened before reset.
> 
> Move cmdq/fenceq cleanup and virtio_gpu_base_reset() into reset_bh so
> all virtio-gpu reset state is updated in the same main-thread callback.
> This keeps command processing from interleaving with a partially
> completed reset.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/display/virtio-gpu.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

