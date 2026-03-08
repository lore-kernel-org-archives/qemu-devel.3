Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE61EA854A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 23:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzNm6-0004Wt-HJ; Sun, 08 Mar 2026 19:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzNlw-0004WN-Rm
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:42:57 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzNlu-0003m4-6H
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:42:56 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-899d6b7b073so121561446d6.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773013373; x=1773618173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3tKHNjL2n1BxBzTUeRfd6YG5gjX4fDA9dvjztNHe61M=;
 b=mmRbJ8d2nEcwbzOk57bDy+mzdbeg0kNGNrzQ3xRB61P6r4RpK44d8Ae015lR7hyWfO
 vuBA2z7ef04AC6z9UnOZLnNY1wPYHYdCTjx2vmsdg+9VYBshl3jt88Ud68gqY+72bllw
 XkMF40hd4d1yl22qVcDIxo2KDg9XBEY00tBieDfLZKfHUm3FIcKB5Slxep1EN02X9pOI
 W8glT9QOoS7aiNlvli7aaysStC9V79K/B0/CnUHPvWCqruqfTdu6i7Y6qv+Q2V2vRS4n
 v3qhuEUQF6ZsXNgFt9IzsCqZRomkxaOuvZD8Mci2g4JI2A1j+akjciZKtCZijfFPoYJb
 WP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773013373; x=1773618173;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3tKHNjL2n1BxBzTUeRfd6YG5gjX4fDA9dvjztNHe61M=;
 b=qWnxG77EqRMhdPPBpf1lsAOdTkQiG2DKUhL0QzCXrILbTKg2dR1OAbD7eAsS3lb8rH
 EaEKVfiBzRyDGHL7M9g6320YJeCsfe+Pc76YW/a64sK0652KspSuHf0BcspcSFgfM8VT
 3hMXIJeabqOgR0qf0gn+YGIiMN0IAIOWk7dvJGGq3x+bJIRP2l5W8/6k4s+vavodOtvd
 44eppq6P9bwJs8rgSk932n1sqiXIt/ZkVMfa9AW+KC42lXt5G2VbTWCRy4SPTiGqfcva
 OOrrm5aVAYlQpfmL0Rjx2t/rctImcqsTvA8JoPggoIuOnCqE1Rv1Bmun7qHvM11X/NRa
 tLNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSkHvCH+vfQCvI4lYGCYvHMeNxVHltPiIhImstQTavb5IMjmZqWpdAMa4is9+0NigIvipWw7a5tOMG@nongnu.org
X-Gm-Message-State: AOJu0Yw5TRO/9LJ95FIMOTTEodulH4gUUPESaEijtO1oOjkAtk4z/DOk
 1jATuVxZ0FS1tF+MU5rH1a+3+n90iUZ7pKYQ4xTieRDFO42KBP2jGwEaMBn58U1JrPg=
X-Gm-Gg: ATEYQzyOC3ta355k4VCpaB7e5UDDXVQsixqWT1lcWLieiglMIHuron46GAkJx1iNLjg
 xav0d1aTPkQ16F1K4mZlK+i5hPHfZ5HZ2i1fkRmgj9D/RLXjq7xCNm6m1EnuUpg2Mee1mUVdEcP
 iKVW1xhwuBJenBUAdrsCE94zIc49LfSYURKiSD7Z2hsrN2SH94mQyOw348mwxaJ0RQertByeDIY
 hDeO0cY7Y8TBhCViZsv0ogGW+ooO2gp0o52nukTR1equuHeCcaNJ8rsh66FeEnJiS8iEsxcNTVn
 dlWuj3IHfQQcq5313xPmF0Hbb8nLpApZQh5Yi9Klel8UgsF304LQI1GOMO9Xh6hweRtxlF5WgMU
 lsL8I4ylEi8MIZc5vkPAvvnlplZoo3xGrXiSgCiEluLIeCK2WOdqGekVmKHX1OWd3IKNp2IAUOr
 gOmV35Cx07CYVzT2drwbsHtZJGdiFRhKgyPrIaBzyzreb398kHSWyJHP99hZAHoUsRtlgs
X-Received: by 2002:a05:6214:2524:b0:89a:b0c:7264 with SMTP id
 6a1803df08f44-89a30ad17b6mr146479646d6.49.1773013372794; 
 Sun, 08 Mar 2026 16:42:52 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a3140da14sm70983646d6.9.2026.03.08.16.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 16:42:52 -0700 (PDT)
Message-ID: <321e8b29-7879-4778-8734-0c2a6a2dadf3@linaro.org>
Date: Sun, 8 Mar 2026 16:42:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: leaks in migration-test
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2c.google.com
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

On 3/8/26 12:22 PM, Peter Maydell wrote:
> I'm continuing to work through leaks reported during "make check".
> Some of them come from the migration-test. (For these to actually
> appear in the log you need to run with QTEST_LOG=1, otherwise the
> migration test framework will send stderr to /dev/null and the
> tests will fail without printing the leak report.)
> 
> I did find this comment in qmp_migrate_incoming():
> 
>       * NOTE: QEMU _might_ leak this refcount in some failure paths, but
>       * that's OK.  This is the minimum change we need to at least making
>       * sure success case is clean on the refcount.  We can try harder to
>       * make it accurate for any kind of failures, but it might be an
>       * overkill and doesn't bring us much benefit.
> 
> The issue with this is that it means we need to suppress leak
> reports in the whole migration-test binary, which means the
> migration code will get no leak-detection coverage at all.
> (Not all the leak paths have qmp_migrate_incoming() in their backtrace,
> as you can see below.)
> 
> We're getting pretty close to being able to get a complete "make check"
> run with the leak sanitizer enabled, so it would be nice to not have
> to suppress leak reports for this test at some point.
>

That's a nice thing in itself.

Is the end goal is to enable that in CI? If not, I doubt there is a 
strong value in reaching that state today. You'll run out of steam and 
motivation to fix that yourself in the end.
Same goes for all other sanitizer errors.

