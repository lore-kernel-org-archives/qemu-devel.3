Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528D5E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNDY-0001gc-0A; Thu, 02 Jan 2025 10:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTNDW-0001gD-GJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:34:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTNDU-0001pz-QH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:34:34 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so7141624f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735832071; x=1736436871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=coIXSLp8gqzvhCUev56EW9KCSUlDZNMOaLZ0xMS1sq4=;
 b=upp5dI+Ep68PfoYEx3wBvft8pOGxoJNOtyf5UFcvjAg3v6AVFIF7sN19x9FtJhhDVI
 qutzWxmjbukSZWuuOYbwMT/4i4fdjWQW6LdlKSrFQreT+0TSHzmZvv4Ffrrqv5MR7Aar
 vjPyrGObLwUZsjKtm+P2HOFVq2UGcqQ/QPxXAqp81U2Flh8lM3EIWi0h58jzHqLqFyWN
 nyrMHfzSryt8RgkGjntwkyfKwY+fYfOueib5ElPYnX6JsI3e5/B6HPMp9z2Xafe+0dSC
 tHLGTZ71aUeAMQVvSnPGQ7qt6DiwKy6Xni7Q7YKrxz1VOyOGBg1YIgn2gSzNe7y9jxAK
 oiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735832071; x=1736436871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=coIXSLp8gqzvhCUev56EW9KCSUlDZNMOaLZ0xMS1sq4=;
 b=RdVZdDfR8QqjFzALgvdNwB6g0gsOfGbKwpBJgLaz3dkP24c4EyFzwqCXoE4ESBP0Rm
 X2kLtGyJ/Zj+BO7r7mZDFFH25AiZWR8Isn6WwMIDRYuZJUJ53EGEMzwDDYUOy4TXtynJ
 dn0vDVtI/hbnucvM+GiKoZERoijWD+Zl4gqQFPh3rw6SeaVuNbllY8s3ftXenXSed7m0
 gV4KUCtIPN2xyHKyKKFLIW7YPo03KEPUOgA3sfibElTlbzFUM8k3tPYbL7MHoqSbcFTM
 H4+4ZNBwIS39711RflMQzG6da6W+cKrkDWsjPUx7XxN9f3+zO8WbSERYEvsP9iXBAov9
 IJOA==
X-Gm-Message-State: AOJu0YzKqxXbHJlM79bPr2ZgQIRhlUsi5Agx/WXZPhtg6eh2pqJi5huC
 iE0rkdSCmDLt5B895xtPKmf2vYQbmGSPw5nbnilNYzmytnEl+TmZjjCUX7NBATM=
X-Gm-Gg: ASbGnctVN9dIbSU/cNyTIHTTlNk47KUXUgf25/XgKNOYrnsLPf17tjc5WaDDdVvc6oM
 KpS2SaFsU1IrUbpPhJeq4aQlMR/zcl9JzIiI0j4HAzQpygL10PN1tP8oxWFw9vVE31Vn5S7GbKH
 xtjDLbT61FnyR21Fhx/HYK0NQnhkBWUUFxanHEg9JuTx+FvVzIS1OCe4MXeLwx7x2Qsf/LArqSt
 Pf3078wwqXYqcnrUNn8szh43/iiKGAqO/Vuyy0qylujwxFspVF5pW6oitUoHApTFB18ly16jZ+L
 lWVYc7b8gLJ8NVcBedMVw+y7
X-Google-Smtp-Source: AGHT+IFIZLM2ngbf1R0KHXwUBRmDhSpdA//ML/XUpOC9XVyAQVA0LCIRk8WWNHdqs0/F/33x5ovusA==
X-Received: by 2002:a05:6000:1faa:b0:386:3672:73e7 with SMTP id
 ffacd0b85a97d-38a1a1fdecfmr44987546f8f.9.1735832071037; 
 Thu, 02 Jan 2025 07:34:31 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a7csm452995575e9.24.2025.01.02.07.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 07:34:29 -0800 (PST)
Message-ID: <6306eea2-fe54-4725-856e-9d5b058e99e9@linaro.org>
Date: Thu, 2 Jan 2025 16:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] scripts: validate SPDX license choices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241119112903.1010350-1-berrange@redhat.com>
 <20241119112903.1010350-3-berrange@redhat.com>
 <CAFEAcA9osyiBuFNz6i=WwbJqgg_Gby3OALCvXdhoG1tJJnZLLw@mail.gmail.com>
 <Z03mTZVxCrYVXKDy@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z03mTZVxCrYVXKDy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Daniel, Peter,

On 2/12/24 17:54, Daniel P. Berrangé wrote:
> On Mon, Dec 02, 2024 at 04:41:48PM +0000, Peter Maydell wrote:
>> On Tue, 19 Nov 2024 at 11:29, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> We expect all new code to be contributed with the "GPL-2.0-or-later"
>>> license tag. Divergance is permitted if the new file is derived from
>>
>> "divergence"
>>
>>> pre-existing code under a different license, whether from elsewhere
>>> in QEMU codebase, or outside.
>>>
>>> Issue a warning if the declared license is not "GPL-2.0-or-later",
>>> and an error if the license is not one of the handful of the
>>> expected licenses to prevent unintended proliferation. The warning
>>> asks users to explain their unusual choice of license in the commit
>>> message.
>>
>> Should we update LICENSE (or something under docs/devel ?) to
>> state our policy ?
> 
> Yeah, we really ought to, i'll have a look at it.

Could we merge the previous (reviewed) patch (1/3) without having to
wait for a v3?

> 
>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>   scripts/checkpatch.pl | 68 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 68 insertions(+)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index d946121b8e..b507da8e2b 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -1353,6 +1353,69 @@ sub checkfilename {
>>>          }
>>>   }
>>>
>>> +sub checkspdx {
>>> +    my ($file, $expr) = @_;
>>> +
>>> +    # Imported Linux headers probably have SPDX tags, but if they
>>> +    # don't we're not requiring contributors to fix this, as these
>>> +    # files are not expected to be modified locally in QEMU
>>> +    if ($file =~ m,include/standard-headers, ||
>>> +       $file =~ m,linux-headers,) {
>>> +       return;
>>> +    }
>>> +
>>> +    my $origexpr = $expr;
>>> +
>>> +    # Flatten sub-expressions
>>> +    $expr =~ s/\(|\)/ /g;
>>> +    $expr =~ s/OR|AND/ /g;
>>> +
>>> +    # Merge WITH exceptions to the license
>>> +    $expr =~ s/\s+WITH\s+/-WITH-/g;
>>> +
>>> +    # Cull more leading/trailing whitespace
>>> +    $expr =~ s/^\s*//g;
>>> +    $expr =~ s/\s*$//g;
>>> +
>>> +    my @bits = split / +/, $expr;
>>> +
>>> +    my $prefer = "GPL-2.0-or-later";
>>> +    my @valid = qw(
>>> +       LGPL-2.0-or-later
>>> +       LGPL-2.1-or-later
>>> +       GPL-2.0-only
>>> +       LGPL-2.0-only
>>> +       LGPL-2.0-only
>>
>> Lists LGPL-2.0-only twice ? I'm guessing the second should be 2.1.
> 
> Opps, indeed 2.1
> 
>> I'm not sure we really want to allow more LGPL-2.0-only
>> code...we don't have a reason like we do with GPL-2.0-only
>> where the reason is "code from the kernel", and I feel like
>> LGPL-2.0-only is quite rare anyway, and at least sometimes
>> a mistake where the author meant LGPL-2.1-only or GPL-2.0-only.
>> But maybe this list should be generous enough to only warn,
>> not error, for code copied within QEMU.
> 
> Reliably identifying that a patch is merely "copying code within
> QEMU" is a non-trivial task. I'm not sure its worth the effort,
> given that we always have the option of ignoring the script's
> advice if a human knows better.
> 
>> AFAICT the only code we have that is LGPL-2.0-only is
>> util/error.c. But that also refers to our COPYING.LIB,
>> which is LGPL2.1. In 2011, 12 years after the publication
>> of LGPL2.1, did Anthony Liguori *really* mean to use
>> LGPL2.0 only? Answers on a postcard :-)
> 
> I'm fine dropping LGPL2.0-or-later and LGPL2.0-only,
> for the very reasons you state.
> 
> 
> With regards,
> Daniel


