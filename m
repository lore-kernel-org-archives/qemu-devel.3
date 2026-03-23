Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FFFEC01CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cyW-0006gg-Dt; Mon, 23 Mar 2026 06:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1w4cyU-0006fX-Ll
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:57:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1w4cyS-0006jo-GC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:57:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so25556595e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1774263450; x=1774868250; darn=nongnu.org;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWhzDWh9v2nIAU1Uj0OiaI1wEkgJp1+Jo83RbIjcyqA=;
 b=PsILQ9ivrNELaV+G4dqCwWffy1TnrpiqYVaBMxtRCec/wkHKj3PQhltTRgoMeBPfjA
 SXVp0Efmp9Ae9iCL8zkGbN7fhXJzuhoVbKkct6tOg8IFqfWhjbsgpbBg938fxSDvtljh
 vZjpbIwdHExGymBweKKIL8voW4iIMFXNhMBm14olgZ9z2Om8qZm9MjbSGYoGZCzRVyxU
 LSXG+DFL33nrtXFmuL8ywtj3rd9JuZcx3v0/jbIhQYsnef2wq3WbGPrm1YbEqa7kpmzz
 ozwN8W8syglICVDmVzvAURYe4UYQAgosEGYogb0tBtJ/FD2kKQ/akUtMAPP1YtKyfhxG
 GIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263450; x=1774868250;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWhzDWh9v2nIAU1Uj0OiaI1wEkgJp1+Jo83RbIjcyqA=;
 b=qntmcs8PnPz+J0MhD0Lge8IcWyuYdBqy0vD2NMGz8osq8xH89X5QQDjfrePwfxM8yt
 UVsQo757AhrTpMTvkG4mp3bffDfbs4dGllxC/G+K07qtzTxzdOROedQpAIQJMYK7Ispi
 4Vdk+QcjqYOLk3uPzlXKdLDK9FTB8/ADeElVLiFZ7VwHMGkUhETO6uixpiD+Xljp213B
 iquQMYb+UP24hpnnVvLcZxkkMTGUzVP+gzms9ce5J9TY7LUxPfRQn/AUu4Jfloqgce8Z
 9XPayNvNeTxFG2sM6NVCEhgkE9LzLiRpadqZUlvG8bGMcFwNcUk6PixZdr5cht9ylshB
 2Uig==
X-Gm-Message-State: AOJu0YzM4DhbkGuqpqVtftEryhKhQNHlieKnrKSAAINFXh2VieoqWRDp
 cXNtYS102wCiFOkVB4dkdbynoPUNN+JaJ6UiRFDrNmWAN3SOZsmVA7PeDoMty3Ph/tYSnVMYKJW
 qXjiBkjlbaw==
X-Gm-Gg: ATEYQzyBRZhKH+OwiLo6J9jh9IfL1TZu/hGZ1FS7UMg/fPOhs4R8zCR7MG9ndXa+BUl
 14RQwLEgDaYRTsQVmKgP/ykjw4bQhcksKgXraMJo2VSug+DguswWoGGPSzzUh/fTN6dCzNEZyvN
 uB4AFzH4WTEyz8wbzvn9JBIph0r8A/RL7WrSfdv5WgYc/yr3JNMZa1USMHHJQ0g3wQyr7DD2BP3
 YqSUL7SZPGArd6Cg7LYq3PRs7HaD5nanO1sBwQmumeRuDfSzsj148yQV91AKklzIUvnlwJc8TWo
 RWVEoiYDCzttMv3i2ic9CsLrrY6DxxgTGATnE9KVSlfxC47JZdjjDQ0abXe8agK9kWL60VykxG4
 nPyY5v9SiNhGO8of0HzHj8AqsDmtWGagSNdzrBeANj3fwbPEQTWH9hOjOvMZ/2x7jpCSzJqdo6P
 EEpb9KHTwmw+Nz+j4Wz2QA8ANg4pRaiXbmEQ==
X-Received: by 2002:a05:600c:3b27:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-486fedf8e95mr163227635e9.9.1774263450267; 
 Mon, 23 Mar 2026 03:57:30 -0700 (PDT)
Received: from [192.168.0.172] ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c7fsm28557909f8f.23.2026.03.23.03.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 03:57:29 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------MBmUj0G208YVuSQ5ohjF7981"
Message-ID: <816078a9-b270-430b-bf5c-10ee37fffa1b@embecosm.com>
Date: Mon, 23 Mar 2026 10:57:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Max Chou <max.chou@sifive.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20260318013805.1920377-1-max.chou@sifive.com>
 <9843f984-b58b-422c-a823-11a497510709@tls.msk.ru>
 <acDljtkBJTxOMqfk@sifive.com>
 <20a922d2-cfdf-4ce2-b230-675e33266d42@tls.msk.ru>
 <acD2qZvU-TQTa_e9@sifive.com>
Content-Language: en-US
From: Paolo Savini <paolo.savini@embecosm.com>
Autocrypt: addr=paolo.savini@embecosm.com; keydata=
 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
 WO+4yYga5w4c1oauMgX/IccT3awBnCU=
Subject: Re: [PATCH 0/2] Fix probe_pages and vext_ldff issues
In-Reply-To: <acD2qZvU-TQTa_e9@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------MBmUj0G208YVuSQ5ohjF7981
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

Thanks for this. I agree commitd887736225 is needed and adding it looks

legitimate to me.

Best wishes

Paolo Savini

On 3/23/26 08:19, Max Chou wrote:
> On 2026-03-23 10:26, Michael Tokarev wrote:
>> This makes sense.
>>
>> However, 10.0 lacks d887736225 "Expand the probe_pages helper function
>> to handle probe flags", which makes the first change in this series
>> (5568177738 "target/riscv: rvv: Fix missing flags merge in probe_pages
>> for cross-page accesses") non-applicable.
>>
>> Is it okay to pick d887736225 for 10.0.x too?  (Adding Paolo Savini to
>> the Cc list).
>>
>> The result works and passes tests but since it's not my area it'd be
>> nice if someone can confirm/deny.  Or maybe some other fixes should be
>> picked up for 10.0.x too.  The current result is at
>> https://gitlab.com/mjt0k/qemu/-/commits/staging-10.0
>>
>> Thanks!
>>
>> /mjt
> Hi Michael,
>
> Regarding commit d887736225, I agree with you that it should be picked
> up for the 10.0.x series. It includes the necessary modifications for
> probe_pages that enable the first patch of this patchset to apply
> correctly, so I think that is okay to include.
>
> I've checked the cherry-picks (3b3e6682/2f4335d7/ba624f3f) in the
> stable-10.0, and they LGTM. It appears to include the related commits of
> this patchset.
>
> Thanks,
>
> rnax
--------------MBmUj0G208YVuSQ5ohjF7981
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Hi Michael,</pre>
    <pre>Thanks for this. I agree commit <span
    style="white-space: pre-wrap">d887736225 is needed and adding it looks</span></pre>
    <pre><span style="white-space: pre-wrap">legitimate to me.

</span></pre>
    <pre><span style="white-space: pre-wrap">Best wishes</span></pre>
    <pre><span style="white-space: pre-wrap">Paolo Savini</span></pre>
    <div class="moz-cite-prefix">On 3/23/26 08:19, Max Chou wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:acD2qZvU-TQTa_e9@sifive.com">
      <pre wrap="" class="moz-quote-pre">On 2026-03-23 10:26, Michael Tokarev wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This makes sense.

However, 10.0 lacks d887736225 "Expand the probe_pages helper function
to handle probe flags", which makes the first change in this series
(5568177738 "target/riscv: rvv: Fix missing flags merge in probe_pages
for cross-page accesses") non-applicable.

Is it okay to pick d887736225 for 10.0.x too?  (Adding Paolo Savini to
the Cc list).

The result works and passes tests but since it's not my area it'd be
nice if someone can confirm/deny.  Or maybe some other fixes should be
picked up for 10.0.x too.  The current result is at
<a class="moz-txt-link-freetext" href="https://gitlab.com/mjt0k/qemu/-/commits/staging-10.0">https://gitlab.com/mjt0k/qemu/-/commits/staging-10.0</a>

Thanks!

/mjt
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hi Michael,

Regarding commit d887736225, I agree with you that it should be picked
up for the 10.0.x series. It includes the necessary modifications for
probe_pages that enable the first patch of this patchset to apply
correctly, so I think that is okay to include.

I've checked the cherry-picks (3b3e6682/2f4335d7/ba624f3f) in the
stable-10.0, and they LGTM. It appears to include the related commits of
this patchset.

Thanks,

rnax
</pre>
    </blockquote>
  </body>
</html>

--------------MBmUj0G208YVuSQ5ohjF7981--

