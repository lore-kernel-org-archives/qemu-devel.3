Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D5CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIzrc-00017U-OG; Tue, 11 Nov 2025 20:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIzqB-0000dt-MB; Tue, 11 Nov 2025 20:40:11 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIzq8-0007pp-4V; Tue, 11 Nov 2025 20:40:07 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AC1cLiv031652
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 12 Nov 2025 10:38:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=e96jBZvCPmsI0AGoNOlpLRhUnoy6ZaWm4fn+nyTsf0A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762911501; v=1;
 b=psUfbhBXnND95kws/zoXioztbq/V/otMMTk5p0h7QpxAZP47L4u0M8aOJzkuXJK/
 K48ZQOLeCMRVN0ORQUwZPK5rzrvJHy5HaVFypa/mdCONExpQgt9Rjo10bU8Q6Aeu
 miTpH5rKqHTEuop5szVZ6GqWXGdFVC5LyhZC6Z8rQcV76huvuNRJwwoHxsAh79Oz
 IY4QfceM6XQudeRF1dIaJixAF24K15LN6Rrpxd2ObGkdUP4gsZjWZMFA5QI/BSn6
 K+BKr7k8JgLcFikK3OgCR/dIZGfQJeqFAIGNtV38F70ZNqSXeCOymA7GITUes6Z4
 fOFvud8Dz20kfIRnC2Bgyg==
Message-ID: <1166954d-d478-4cff-b1af-ba3246216707@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 12 Nov 2025 10:38:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] docs/about/emulation: update assets for uftrace
 plugin documentation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251111171724.78201-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/12 2:17, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Linaro is discontinuing its fileserver service by end of the year.
> Migrate assets to GitHub.

I wonder why they are moved to GitHub instead of share.linaro.org. They 
look like plain binary blobs like other files moved to share.linaro.org 
and don't need a version control.

If they are going to be on Git, why don't you put them on 
https://gitlab.com/qemu-project instead? I hope creating a repository 
there is straightforward.

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/about/emulation.rst | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 92c219119e8..4a7d1f41780 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -886,24 +886,24 @@ As an example, we can trace qemu itself running git::
>       $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
>   
>   For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
> -<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
> +<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.

I think it's better to point to a specific commit so that e.g., files 
can be renamed in the future. This URL will look like:
https://github.com/pbo-linaro/qemu-assets/blob/ec68ed241bb303128537ac662d97e38972ff7257/qemu-uftrace/aarch64_boot.json.gz

>   Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
>   using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
>   Some sequences taken from this trace:
>   
>   - Loading program and its interpreter
>   
> -.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
>      :height: 200px
>   
>   - open syscall
>   
> -.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
>      :height: 200px
>   
>   - TB creation
>   
> -.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
>      :height: 200px
>   
>   It's usually better to use ``uftrace record`` directly. However, tracing
> @@ -916,7 +916,7 @@ Example system trace
>   
>   A full trace example (chrome trace, from instructions below) generated from a
>   system boot can be found `here
> -<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
> +<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
>   Download it and open this trace on https://ui.perfetto.dev/. You can see code
>   executed for all privilege levels, and zoom in/out using
>   :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
> @@ -924,27 +924,27 @@ taken from this trace:
>   
>   - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
>   
> -.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
>      :height: 200px
>   
>   - U-boot initialization (until code relocation, after which we can't track it)
>   
> -.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
>      :height: 200px
>   
>   - Stat and open syscalls in kernel
>   
> -.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
>      :height: 200px
>   
>   - Timer interrupt
>   
> -.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
>      :height: 200px
>   
>   - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
>   
> -.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
>      :height: 200px
>   
>   Build and run system example


