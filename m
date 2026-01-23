Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5460CD778A6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 18:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjLWZ-0003Lb-Om; Fri, 23 Jan 2026 13:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjLWV-0003IX-Jx
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 13:04:44 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjLWT-0005gV-St
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 13:04:43 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso1483796b3a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769191480; x=1769796280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bEkbWNFTT/mC/mUmnOtHTrIoWsxPK9+cmqVighCAy3A=;
 b=F1WvYuJWZTB97MB1/ixddSlQ2guz0iiVx8DNgPvejkmMzbQZJC/Yd/EoFGhS+a2BbL
 5KG6oFplaFnSrKWZ8GlClKhae0C8B/bkC3uWPIiwc/IGBvNwJis/QhbiVy4IIJArb9c3
 CABwxU0I1OYHAqkPAdYVCt036QMbfXH4rGm9UHQo0uklj6RKVujScP+8KS/DJaDZ7E3l
 HqcyX/bCFaYQ/hdnWcn5FdV2AqFXt50858pLWzuffI+3wvHjpMK35sFg+2hSlJMY4LCy
 aTVNiGfhwKBrPvstOYDMKM3F3aEfRRrZ+y3pcHMdTwPhvfQNqPIjEMMYWWND8GxdQNo5
 yv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769191480; x=1769796280;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEkbWNFTT/mC/mUmnOtHTrIoWsxPK9+cmqVighCAy3A=;
 b=wAIKJCL0XP0zjljyuT81joDwqNcAlT0EEXhDi7OTFriP8G96MO/W/FOAog4z9Eg1/P
 b0pYGwRMMQRu22NvUTfYRDEzdDsDqF7eycZcEyKu9KM3eX3BPEoUto0EwSliltuE94OI
 r5gkidKDT0GgnBN9gLaOrUOTn/h9Nttd06VD643UTtKkm4jN+ArkW6t0q26y/bu2++QU
 UWTrFSQ3QE9Yol6gQT3qPJ2ZCo/cmwLbbP+PrLswLtkHsn7fnuLsd/DRh7bP5oby8o1Q
 dneQP4m9/l5TruzKoxASLIBNjeqNZmE/kU7VfyI4/SLUABNiTJ5afC79wtew9+XtgvF5
 a2FQ==
X-Gm-Message-State: AOJu0YwrFojYA6o8YUsW2ZAk6KTp5JC2SSUJnfhKen2v24ggKEazOwg4
 oC9lsovKbl/0+ytOMxhTbvAtmKDZYF4vaC5/qolKJWyVrSGZitb+tqOvArGN67Cgejc=
X-Gm-Gg: AZuq6aJnvUy5qWB0ZomUXNEMLPu7NJR7zoa6zCTYTxBv8owZP8ZYDzhrSZOMjg/Bryd
 1cdYbk41iwqs4TKz46Ecf13HttNiHdxTCMPilRTrv5Jdf89mICrfqnGsTfMZyAlp/g/7uG7txOc
 NKndTuyIF37QUApsp/0/mtBenDZdL84aHtJC9YePhmMV23EzWqoIy4ZpfttuUCqLhn9S+clZhYV
 n2DaBkVB2y8pBKS/Tvvnh++7MtooE1TTDKnuYOCvEWzD/BJc7TPC9xY6ea/dgYI7bORANnwzx4I
 psMxTc8rpeANjWPocOSk7TdSzibg+4agwwimzTLBc3dy/8D2DJORFZGDrWwfCt0C3fY6kjntBL7
 Vn8pgZQBv3Qz2ZsQsCUVgZADFQ+J+SG5Pj9h0/wq9MdwxNgke1ftv2NuHSAulF3U5t7k8adFWHb
 CGbozgSDyeC0eTrkc02CB07RWK/eOQHyQRCICy6B11PJ2Qqkm63I07jwsM
X-Received: by 2002:a05:6a21:69b:b0:364:13ab:d4c5 with SMTP id
 adf61e73a8af0-38e6f721c5dmr4227237637.26.1769191479857; 
 Fri, 23 Jan 2026 10:04:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c635a1307a1sm2546050a12.5.2026.01.23.10.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 10:04:39 -0800 (PST)
Message-ID: <94902ed1-9083-47a6-acd3-6fe9769b00d5@linaro.org>
Date: Fri, 23 Jan 2026 10:04:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/16] MAINTAINER updates plus conversion of
 get_maintainers.pl to python
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <7b42bd50-937d-4a67-8438-777be9ce3764@linaro.org>
 <87qzrgl2v9.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87qzrgl2v9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x444.google.com
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

On 1/23/26 8:18 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 1/23/26 6:57 AM, Alex Bennée wrote:
>>> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
>>> slightly at figuring out what I would need to change in the perl
>>> script to cleanly handle it.
>>> While we imported the perl script from the kernel I'm fairly sure we
>>> don't use half the features it has and as us grey beards age out less
>>> people will be willing to tweak it. Consider this a proof-of-concept
>>> for discussion about if it is worth perusing this path.
>>> For v2:
>>>     - added the missing K: keyword support
>>>     - added basic --git fallback support
>>>     - picked up a few more MAINTAINER updates from list
>>>     - updated entries for Arm and *-user
>>> I've CC'd the kernel maintainers for the script to see if they are
>>> interested in this work.
>>> While the python script is still cooking I will send a PR on Monday
>>> with just the MAINTAINER updates which are reviewed/acked.
>>> Alex.
>>> Alex Bennée (13):
>>>     MAINTAINERS: fix missing names
>>>     MAINTAINERS: fix libvirt entry
>>>     MAINTAINERS: regularise the status fields
>>>     MAINTAINERS: update Arm to Supported status
>>>     MAINTAINERS: be realistic about *-user
>>>     scripts/get_maintainer.py: minimal argument parsing
>>>     scripts/get_maintainer.py: resolve the source path
>>>     scripts/get_maintainer.py: initial parsing of MAINTAINERS
>>>     scripts/get_maintainer.py: add support for -f
>>>     scripts/get_maintainer.py: add support reading patch files
>>>     scripts/get_maintainer.py: add keyword (K:) support
>>>     scripts/get_maintainer.py: implement basic git fallback support
>>>     gitlab: add a check-maintainers task
>>> Mads Ynddal (1):
>>>     MAINTAINERS: remove myself as reviewer
>>> Pierrick Bouvier (2):
>>>     MAINTAINERS: add maintainer for docs/
>>>     MAINTAINERS: add reviewer for linux-user
>>>    MAINTAINERS                    |  31 +-
>>>    .gitlab-ci.d/static_checks.yml |   9 +
>>>    scripts/get_maintainer.py      | 499 +++++++++++++++++++++++++++++++++
>>>    3 files changed, 525 insertions(+), 14 deletions(-)
>>>    create mode 100755 scripts/get_maintainer.py
>>>
>>
>> Hi Alex,
>>
>> it seems like you forgot to pull this patch also:
>> https://lore.kernel.org/qemu-devel/20260115202511.2709767-1-pierrick.bouvier@linaro.org/
>>
>> Could you please include it in the current series to avoid an
>> additional month of round trip?
> 
> Hmm I did so a sweep and I didn't catch it, pulled now.
>>

Thanks.

>> Thanks,
>> Pierrick
> 


