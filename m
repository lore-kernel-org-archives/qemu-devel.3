Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A9DFD376A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHpY-0007xV-KE; Wed, 25 Feb 2026 11:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvHpW-0007v5-IP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:33:42 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvHpU-0007qu-NP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:33:42 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4398e850783so802046f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772037219; x=1772642019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIEp8JHYghOOg0qqlNWcJoCn4tWkZuKJ/a2Gp+yH52w=;
 b=I1snrFc9hsVzir+ejbXDdXuV725gn0VwICkZgx12NJtiYW+Lu41aiix/kyxRzaRmzn
 rG/R8quHPnVB9RuH/dz6pniz5GEkQ1EOITt+8IqSi3zto5PUpHcttpy+VLZV0zyGxG/Z
 VscdjF8IVYxhj51ly5JxQzgMF6nJkvsCgW30JsgnzqAXhhJxN9AZ0qC4MYVmx6PAWv4c
 sTbMBzagGalRkCXEv0+WUCLgwbZfp8UgcoU4CzXK2Az0ihLdAJ3ZdizwZWQoUYiNKRY/
 72+HDQSHJLdapwDgwuJnO07NHPzhJowYxaKO0/RxWufMD1YATzRwKZt7v9m4xsNMdGah
 d0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772037219; x=1772642019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DIEp8JHYghOOg0qqlNWcJoCn4tWkZuKJ/a2Gp+yH52w=;
 b=lRjFjzAfLcPMWLr92ug0jtPeRYV4sqzQJxU+j0t7Seyhb0bF4Qf+QiXQnXDwzmgS82
 uIR2rxByB+V931woltQL+VfzDdBLG9PxBnLH1TquK56E6DqmIFb1xnm9qkJ3Wkd1A+eF
 I4YU9rob65yyygsBC1UWIT64MZWzT8ok5uGWpxJc9M6u+HsEEvH+lOojQpydak5t6HQR
 f/wf4rUbDH70SEoPN32KP5YcPuJIGuk8mf7EqjFzSDKxchc5qjYCpbny/7tJP5QGbVgt
 Cs6qlZCof9nlTaBIYZe709Weaad643qD9/8R09KbW6qrb84A6TrFjLyNNNuu3gLo/2J5
 2UGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcFJRG/VG7UcJriw+UXqa9O5+aLB5rZM2Tz25lcfS18AWEOICoJZl/aQi9eTP4A3jCIkSV0iygXB6t@nongnu.org
X-Gm-Message-State: AOJu0YxZsW89F4snUBbcBr+drkbI5yNpWlqhRwYX4qQCbSJPKaizf9P4
 +rjIePO/xZkiTA4p56+Tl8n04yl1IR0NSl5Adq0n2PGXuZWff/wihoS6Ib23/0U1Ovc=
X-Gm-Gg: ATEYQzzwJXYGkjcEswsSlniJ9SNrwLpfYvWxNxGKm0Zp0yZROkBZ77L85lFF+/PulRT
 /kzLB0j3i103WzZ4BgW7CwMzzfttCsn8OGCAbn6x/AUrTcwPASV6tQNybaild0zq8BbJhnb26gM
 7rztJ7EWGDYdeMHD2lV/SLvCWbYxxsKJsccSfE8uZ1iXSRTuOOPykNGrSEjxo3kexh8LFgvCdkr
 VMTpznvheMeFzwFEr3DyohU1aJEdk5AVeYlaRTJHuaN1hzaNelj0c/zsUyxtIhgKvKkmUooXdmK
 joA2oDvsrnegRTetPUiRfVUzoefn/Cxcv74sSYpJ4dxBFxOOL1EACz7uw8todGxQ2898yegeyGX
 vEFz0nCPQEYG6tO2rrszo9l+0FSjmzzihh5vL4IHVd8K4670duytLiPUbHonSz3jQWw7SOtluKv
 U5rnY+zqsRCyEYrZ7Q1AednmnHyskTzKvb4sORR1umTYCK83Up63kKPxJpbnoWUcYZtg==
X-Received: by 2002:a05:6000:2411:b0:439:9312:4b64 with SMTP id
 ffacd0b85a97d-43993124f06mr3257376f8f.59.1772037218816; 
 Wed, 25 Feb 2026 08:33:38 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43992ced321sm3043551f8f.35.2026.02.25.08.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 08:33:38 -0800 (PST)
Message-ID: <19b6002e-564f-4297-aad1-499a869c7d3f@linaro.org>
Date: Wed, 25 Feb 2026 17:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Remove the qemu-system-microblazeel target from the
 build
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
References: <20260225161823.1438850-1-thuth@redhat.com>
 <20260225161823.1438850-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225161823.1438850-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Thomas,

On 25/2/26 17:18, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> It's been deprecated since two releases, so it should be fine to
> remove this now. Users can use the qemu-system-microblaze binary
> instead that can handle both endiannesses now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                      |  4 ++--
>   docs/about/deprecated.rst                        | 13 -------------
>   docs/about/removed-features.rst                  | 14 ++++++++++++++
>   configs/devices/microblazeel-softmmu/default.mak |  6 ------
>   configs/targets/microblazeel-softmmu.mak         |  6 ------
>   qapi/machine.json                                |  2 +-
>   tests/tcg/plugins/syscall.c                      |  1 -
>   7 files changed, 17 insertions(+), 29 deletions(-)
>   delete mode 100644 configs/devices/microblazeel-softmmu/default.mak
>   delete mode 100644 configs/targets/microblazeel-softmmu.mak


> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 5658f830879..624836dec62 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -40,7 +40,6 @@ static const struct SyscallInfo arch_syscall_info[] = {
>       { "loongarch64", -1 },
>       { "m68k", 4 },
>       { "microblaze", 4 },
> -    { "microblazeel", 4 },
>       { "mips", 1 },
>       { "mips64", 1 },
>       { "mips64el", 1 },

Isn't this to test the qemu-microblazeel user-mode binary?

