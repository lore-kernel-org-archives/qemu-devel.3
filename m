Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE449D58CBE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 02:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Uhp-0002Qs-M8; Sun, 22 Mar 2026 22:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4Uhn-0002QS-Ao
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 22:07:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w4Uhk-0008Fp-Cr
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 22:07:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82c20b9fb15so842930b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2026 19:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774231662; x=1774836462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xl8sc9Qsd/jHW0lKORW1FuULmhfA7/cOI5Ytq7rOBfw=;
 b=AoCjH2tX9FqD8zwclKv2ein73udayPKOLV4Zl7JNCrtHaRVdP84+Yi0n9/mqvFxwOx
 xjcOu3yQ0uRRZKDermzyZ5LI7EPsJH1nUpeXgBorYi/5fUSaJ4nVb4U6gcTZf1V+DYXN
 0hb87jj9p73m3pcQjkpx7CD3KD2mowI5YDEZ3+yX1174xZStVIQbCraqXtzxSY/wLO9C
 W3Ib6Dh+58Myj4uQheVkTTgZmVG0bQ0rrhUTdtAYwflq2ZucoyWJTpQKPTKxA3S+a+RD
 htro79fvyTT/wLyO/sgblUKf4CBOu0AwHi3Pu4ZB8tMx09wGVdm7ej0Ne31D/O7O5EXK
 NiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774231662; x=1774836462;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xl8sc9Qsd/jHW0lKORW1FuULmhfA7/cOI5Ytq7rOBfw=;
 b=V5vlumPCNi2gTMJoyl8k7J9kTRS1qVvG4l7gHT3ilv+urfo5kVlTwxiCrmb5vvHhPL
 d4VaLEHjqsUI+Kyp40PvGM+udqViy3C1zm3SDF7fOHAZ0DApdpITssI3Y1Gi5X8rhg+K
 YQ5hAuU+BwgNQs+QlBGxrvEqvaPWFJuHjiMFyNsPEF/sCYrDpYMpXYwVqwiX0Refa/Yn
 41CgEGfQVVGRvN9gzI5Kz4y1JidMBtHI6B++Fa7ysnTOGTgLiB2Fu69TtA3//x+F+Lkr
 qst8nK2dPJULxOxqlzW1BITcFUngMR6eH1CASzucI0ERUv9MUUgoTAc9KkXFYG6Rsf4q
 Vv/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpIElwSReCqZwkI7rSfeQXxZ/5qGCOjSfBAa35Rvl3HYf/M7xvqB8GBpTYlF/zoI9xSJo03jZKGDXg@nongnu.org
X-Gm-Message-State: AOJu0Yw0lSu4FAYKH+qF/fqaVHluJ9SdNgWvyFQDbp1KULwRqk2m8JOb
 x1EBhvHJ69949ixYQceNX88UHFh77WoYkZpq1I0BHmGwUCmUjcQ+iCoGmMOUbLD+LXc=
X-Gm-Gg: ATEYQzyXUqGhf2SzZTbGIDJEfV+YE5fBxOMqmMIPfTi4TgdzsdlR0sZUcEy37FVGfPZ
 FrISZHm4GC7txL991OJj8tNLyxlpcGJJYFCpjLLn+Z/uXssEQTCR8Cv2sALCefFdsMcekiBYgRJ
 u6SMSc9Yx9+odgnK+xyhn7RUNbMNSnWGeFEyxrtOF+WmFC72EyOHAFqhjp4gwvonenwaNym8+IR
 RxXVebxRKRR2SD2go9a1WYXdZ7KAOd54heYILCvjfxMkvV7VWGGYPyyns+ooeUwA3gPnzIOOusg
 S1FQec59XDE8USrbSptLprU5eJTzyfqHAyEIBhrGPAqfkLMQ54YA3ENirWRjEz2hhhx115WXN9m
 078dlK9DPhkR/R2KOa943GbaiGncA17paURKeCR49u0211jtIc8+wI5BALavsf9L5mB3gTEmNju
 nuLjZS0L01EduK6OJOKB2K8i1WIAa0+tgsLaAlK0BmjpkrSpQbY+Rjc4WEl7Jaqhrr1aC4
X-Received: by 2002:a05:6a20:7f9f:b0:398:7357:bb91 with SMTP id
 adf61e73a8af0-39bceb46c0emr9086912637.33.1774231662146; 
 Sun, 22 Mar 2026 19:07:42 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c744aa0bbdcsm5860451a12.32.2026.03.22.19.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2026 19:07:41 -0700 (PDT)
Message-ID: <e1add462-55a6-4aab-b469-b7db7eedafcb@linaro.org>
Date: Sun, 22 Mar 2026 19:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Monitor address printing
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 3/22/26 4:38 PM, BALATON Zoltan wrote:
> Hello,
> 
> Noticed that now addresses are printed with a lot of leading zeros in
> monitor:
> 
> $ qemu-system-ppc -monitor stdio -S
> QEMU 10.2.90 monitor - type 'help' for more information
> (qemu) x/x 0
> 0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
> (qemu) x/x 0xfff00000
> 00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000
> 
> I suspected maybe the recent changes around 42cc2028a43 might have
> something to do with that so I tried to find a point to bisect but looks
> like some build system changes also broke that:
> 
> $ git checkout 42cc2028a43^
> $ configure...
> [...]
> mkvenv: installing meson==1.10.0, pycotap==1.3.1, qemu.qmp==0.0.5, setuptools>=44.1.1, wheel>=0.34.2, pip>=20.3.4
> ERROR: Could not find a version that satisfies the requirement wheel>=0.34.2 (from versions: none)
> ERROR: No matching distribution found for wheel>=0.34.2
> 
> *** Ouch! ***
> 
> Could not provide build dependency 'meson==1.10.0':
> 
> master still builds and I get the above error with earlier version even
> with a new empty build dir so looks like some build system problem. Could
> you please check and fix these?
>

Build system has been broken upstream for a few commits, and I'm afraid 
there is no proper fix for concerned revisions.
You should skip them in your bisect run (git bisect skip or run script 
should return 125).

> Regards,
> BALATON Zoltan
> 

Regards,
Pierrick

