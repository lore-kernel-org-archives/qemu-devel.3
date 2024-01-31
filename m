Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25654C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 16:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVDNo-0001y2-VW; Wed, 31 Jan 2024 11:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rVDNn-0001vl-Bh
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:24:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rVDNl-0007dn-Bm
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:24:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40faff092a2so13156385e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706718251; x=1707323051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bizJvZhJwR++xKNvzuLBPDoICKYyZ0K0xGgeSW8jv0s=;
 b=FgPTKZL37fiXpI7q78rCZ7WDXQNGrnAKotRH1K2twUsxKaSfTSETn7tIqCMIkgruUo
 vhayQinY3H7BHr7Xmb1ug/SoDFdZD+302fhZNZ38IbWc1t3bP6ft40/CG0Ld/9LgNBLu
 A+B/avlCxlEo3fmI73pBeDz+RUC5FEOZbPo65x8i6o/jmxMCRp4TCBcE8T1ewkAkCJ4x
 lVOalCeyNF7oIi9m8rTdyMZpyFY0wpzzG/iy2RSQzHatbmsTfrpYSbS5+lUppq1Uku/H
 Ijock8BV1yNgUwxwxyJrY87GgV7I18ys/xmhb3xhMgJwsDXve1HUaeRpfRkTwPFSKJIm
 yXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706718251; x=1707323051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bizJvZhJwR++xKNvzuLBPDoICKYyZ0K0xGgeSW8jv0s=;
 b=JEeu9/hmdWYn6tAyPXg2Li0vRcW2hmGXmC9v44rYRmtVrC9F2Glrkx0PYUTHBAaCF7
 6VqGhgXU4KqRLQzMVVI1kHClNC+/09yhkkXxqn2YBm1SgRi7V0zMmNFDmzTqxHf5xtOY
 6wjtSDaa+FhxOtSm1LHM7wuP/sKXDNhKLI2eVn2DZltRmOPumBh7Xc4QLqpvQL/yQh6V
 Kk1ngQvFmATrspgI8+8aT/PziMB1j0zhZuxWGnTJudhHZ0fLYOWWmy48/2nyUcuLNWSy
 oCxCqdn4TOkhDEeZ5Bt6sYlRK7zlOP7TOVzkSELejMXx/sfLvK2Glfhdw4YfrDRjYqG2
 DKUg==
X-Gm-Message-State: AOJu0YzPbWJIKPhtUjm0b2CIjxgQKYcQK2+ORUQ+hHqiNuL+s4HJl9GV
 8reSgyy0aArRF1MRUCMsIj8gkKW5V5XunH7Q5A1rCTGoJuhDjmBcbuc8Z/O7qIc=
X-Google-Smtp-Source: AGHT+IGFCDpvsW2H7OekYdK8Ll3PBMRGOYT9ZLm08sLWoC0EPvKH9McwnQhtbCxwOlf7mbb5GWjvCg==
X-Received: by 2002:a05:600c:314b:b0:40e:f3ee:562f with SMTP id
 h11-20020a05600c314b00b0040ef3ee562fmr1627846wmo.6.1706718251441; 
 Wed, 31 Jan 2024 08:24:11 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVM4UO4ltu/E9T/5AH2eqO8BIRlsW+unBunHONYJdDhsO6M7Th0JV7fd2DA/j2hFMXG680/aIIY9aYE8vP/fP1j8lJg2zhf3JpMc9Ine9Q+v93qR1kGKaXb1d4NmcWIVvAbP5MIYYR/0U0BSvbkELNSmsz9yaNVXIDyrLNsMQqZXWd2oGAxdtNuWkIGa0TfDJVJvkInGR6vrOVX3zYLGX3EqGVoWRGMLLEIkVeP2l59aitC8qTmgWS61olfdLm8+VPht0NjY6o2c0bPQ4tcFsAr9nRXEmeylFI4owU+DQc/+o6O7A5Sq7kjdJ7TKfH/62OnTjnElDhfDtwCVkdFMKQE14iVXwbR4nrzEucsy32ueoVSDPdj3AF/ZeBKsdckHbACNiw/pszExHkLIYOavAdq7h4S7bEqQlReqgAFBJJJsYOxtg==
Received: from [10.228.24.192] ([84.55.155.224])
 by smtp.gmail.com with ESMTPSA id
 r17-20020a05600c459100b0040e527602c8sm2027226wmo.9.2024.01.31.08.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 08:24:11 -0800 (PST)
Message-ID: <33c9ccef-fa8f-41e4-a7a1-17c3dffb9d9d@linaro.org>
Date: Wed, 31 Jan 2024 17:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] meson: Disable CONFIG_NOTIFY1 on FreeBSD
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <20240125194840.1564-4-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125194840.1564-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

Warner, do you remember what this is about?

(https://cgit.freebsd.org/ports/commit/emulators/qemu-devel/files/patch-util_meson.build?id=2ab482e2c8f51eae7ffd747685b7f181fe1b3809 
isn't very verbose).

On 25/1/24 20:48, Ilya Leoshkevich wrote:
> make vm-build-freebsd fails with:
> 
>      ld: error: undefined symbol: inotify_init1
>      >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
>      >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a
> 
> On FreeBSD inotify functions are defined in libinotify.so, so it might
> be tempting to add it to the dependencies. Doing so, however, reveals
> that this library handles rename events differently from Linux:
> 
>      $ FILEMONITOR_DEBUG=1 build/tests/unit/test-util-filemonitor
>      Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt -> /tmp/test-util-filemonitor-K13LI2/two.txt
>      Event id=200000000 event=2 file=one.txt
>      Queue event id 200000000 event 2 file one.txt
>      Queue event id 100000000 event 2 file two.txt
>      Queue event id 100000002 event 2 file two.txt
>      Queue event id 100000000 event 0 file two.txt
>      Queue event id 100000002 event 0 file two.txt
>      Event id=100000000 event=0 file=two.txt
>      Expected event 0 but got 2

Wouldn't it be better to use a runtime check in qemu_file_monitor_new()?

> FreeBSD itself disables this functionality in the respective port [1].
> So do it upstream too.
> 
> [1] https://cgit.freebsd.org/ports/tree/emulators/qemu-devel/files/patch-util_meson.build?id=984366c18f1bc54e38751afc29be08c596b83696
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index d0329966f1b..3d67d78b522 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2403,6 +2403,7 @@ config_host_data.set('CONFIG_GETRANDOM',
>   config_host_data.set('CONFIG_INOTIFY',
>                        cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
>   config_host_data.set('CONFIG_INOTIFY1',
> +                     host_os != 'freebsd' and
>                        cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
>   config_host_data.set('CONFIG_PRCTL_PR_SET_TIMERSLACK',
>                        cc.has_header_symbol('sys/prctl.h', 'PR_SET_TIMERSLACK'))


