Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D15D3517E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vf0-00053b-T8; Wed, 01 Apr 2026 09:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vey-00052z-Aw
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:31:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vew-0006Rg-Lc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:31:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso91495495e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050260; x=1775655060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cU35ifuyhioS5msCx/vXGdg6aWgi6On+0WohFEZJvPY=;
 b=NvwUu00aw4E5nqUZS7Ueg15PfbhRgOcq7u3UEJ/zKpT4uAlnuCSryuGLDbyBUnRduP
 7UK4WRPpDTe/rKvw675rmpR80Ab5xLNHN/8VcrGYt/aZ2VbCG8NvKzWLdqS3uXgSFTT+
 S29gOCrt/Pnm28sSweDb1Qu8tamFxVjEFY4AGpj/fkBk2j2gheSH/TsFCGRX9jBYupwm
 68uxgoFgYXfVQ62GkVK6o5zrxiTW2sqc0DZBXsMk90SIE2Kq4SCII9rjFZ4CTUrvNGKl
 ji483OfIQPaXRwt3pmIxOMM4lDmeDn4N5eqqvu8yRFvv1XpjTVrSvPWzBABO4QgPbS4Z
 OGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050260; x=1775655060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cU35ifuyhioS5msCx/vXGdg6aWgi6On+0WohFEZJvPY=;
 b=dymtYAB26hY37wcZRTF7m45G8x3k/SKB2f6dAENis17QtSt1Dm1rqWim+9QLr64SAM
 fGCSO78SeA9e1dAJlG6I6D/d6izYGkFSKT5MWmAX0E3R5ZnznUXGkij9/dFthYepzPyp
 mhZIuSGvVoVp90G5aB2oCrtVulYAQDKTQfcA6MKxkecvvn5BZ5P42NRdKoad5Tn0VCXZ
 Bl2c7nP73ppxRrDa6NiNU56hQDF7SMd4rndDF6ODM0UNQ8OGhIVaU5l6bbi2VwcFNCpC
 YeWCjfe2SzRUvyOSlu0RWbKxcY3UZ1KlYgNS50K/yjgGDcGRvPABRT209LogU4zHmvqJ
 ZbVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIqK+opOsnpkC6ibcCbVGykp+mw48tND5OHgS0jZcpcGY86nz1wTqeb0w0vVc38P3RWhWEY20eoeQ/@nongnu.org
X-Gm-Message-State: AOJu0YxfZovFfYxhh5zs5bsbVAhQwnf0zc+vhtuudFmm8ooBM2KZlaWP
 V++dvzkeYqhLc5NSRnXaGyZI6kt9KXGd4UzE6nOLlL2bi55z0hdkdeBQHYyJr1+ePsk=
X-Gm-Gg: ATEYQzyBoHoWwVv54ekzHxVAAoDPad9rh5+fkkX6/wvrdmZYS+F5cSHs3YNC0zuORRX
 l7N7JjT4n82BegKCQJaIO9V3ZlgrAFWNe2pl6i9e+9OcTKToJi/OIFxF+pex0QcSBsE9JHZI9mH
 Vg32MQRc86/0jBwh6I3hOEiCB0dNMncHJGrjCuY6hcbalO2x2JvNBFzEOYXUjKNOwxE05HVUR7E
 +kJmHoeR9z5MIaeWDX3KEH+hyhHci7khUayr5iFoyjqUjc1wFCJxQRPu6vgpMOX3mzBkcRrp3lh
 D1gHS6lqmJQ2cfh7rBXGXLYs1xy/VJShcU79T/Vo+hjTT6QKp5xbmivbmTH9x8E9Cdt3SnLSX2z
 r/P0qw7jQat4wTW36YOzdg2wVt6NTj1A1B4LKz8eB0LkqgGU6wdK5Q5ToIsAJUvL0ESuqdwVYEc
 457vs9QVqx4ysFDg90jB+HyfIxYnQGJoZ7/JkY/d3MxngyoheeMmXywkf4Si4kzupqnQ==
X-Received: by 2002:a05:600c:1e02:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-48883575cc9mr70700645e9.9.1775050260257; 
 Wed, 01 Apr 2026 06:31:00 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a6ebsm142410225e9.6.2026.04.01.06.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:30:59 -0700 (PDT)
Message-ID: <bde79cb4-8738-49db-9374-f67e85c1f658@linaro.org>
Date: Wed, 1 Apr 2026 15:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/11] vmstate: Rename VMS_NULLPTR_MARKER to
 VMS_MARKER_PTR_NULL
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-6-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260326210532.379027-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/3/26 22:05, Peter Xu wrote:
> Prepare for a new MARKER for non-NULL pointer.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>   include/migration/vmstate.h | 2 +-
>   migration/vmstate-types.c   | 4 ++--
>   tests/unit/test-vmstate.c   | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

