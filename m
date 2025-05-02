Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0273AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 07:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAl8C-0003t9-PU; Fri, 02 May 2025 03:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAl82-0003sb-2t
 for qemu-devel@nongnu.org; Fri, 02 May 2025 03:48:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAl80-0002tk-EL
 for qemu-devel@nongnu.org; Fri, 02 May 2025 03:48:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso8982575e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746172090; x=1746776890; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CNt2gXGmzF4Q8Nkee53erYjQZK/S5DrMJQ0Jwevlp/s=;
 b=XQevJNqO4JIlfxXQ7wlcUh8DvZ+E0srpRNXfFiHbDzTJxsTS6q7C6XT48BJUR7arI4
 RCggRXFeIt8Yu6Lc1y7hkw06CFogQ9VnSY9Hf0rsd8n5EApLn+Xmpn2bII3QRxqul6sb
 eCT9So5w1OLKvL9WSh0BD3Zuscf2UYw2HyFnKvEPfG8vaDoQuunTDcRHE6zTtxiAIj3x
 sMMo0WDvUW0lsS+YF9tbha9HlmdzBqCGj3TjdJ+Qv05sQbLebDWXgyECtfiKvaWFaghH
 lz0lZapSacAjigsnx6rTD2zT5USFoz6/8kvjOM55EySroeZKk/cylWqT04VnBzx+015Y
 kRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746172090; x=1746776890;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNt2gXGmzF4Q8Nkee53erYjQZK/S5DrMJQ0Jwevlp/s=;
 b=cK6bEQtQbGPjCZwHfamS57r8nEcbP2c6B9YXg89U9xSdjZWVNG3EIpUeaUxHnk9n3I
 52m9TIFbIXS6HkRTbAUhIXK8VoPY844PjVCa+sXrr46YDlVpnyQsufyVbDqqQR+EwS94
 SxGDTy1AeTxIlbE//+M0tTqKx8xNTYY+ccSxl9T+5WBDIEZIyhXno76f6CPY6vQ+zkn+
 Rwgv4FA9U+t3xfL055ASdGni+GTpTn9EnIzxDURc2oWAe/nhL9qLa3CH/0zDUBayg4iO
 Tl1/veETzqrEg80fXaj6rsLgLknQJ515JclklaKliHblJW/NPCuM/hYWBRpTiod/sgzG
 V3Qg==
X-Gm-Message-State: AOJu0Yx9vfRjfUJoHoahJ1x860N2KR7YJ5ArfViAxndhkS6Yd0UUqn88
 JwIan6VHSc5fx2bvUtP6HpI2xlRB53gb/IY20x9xV7SOkvgnl2lWa0QCpU6O3oiE0wJPsHp92JM
 klTI=
X-Gm-Gg: ASbGncsQwxtjlW9/13Fzfbh7Xf2/NmzXcMVvVyHyC0cuGf61yqe7LG13jSv4IEqTe60
 McsXlueBnScQUX9VUQ85URSCMYNMcAF3jY26r0e+4qaq8Sk4keD+fNEkQYCkvAtDEWY0/2Xxo5P
 qqW6Vzg/1r70rWvHjTf7xwtvhDnaF1bmr1kJVdukuKaZ4PO5rSMQXGIQl0KaOFo+uGNQMkQDTJ/
 5x6/XvmMKobZczBTVJemJyKp0bGRTqEdqBKX7qd47KIowk4icD4A+Y0dJ/8aJm8HCq9ED4mJJhO
 gq+HAYBV4Tb4JS0Gjr9l+SzNPbct6jtY5936QIQ27Zi1nAjiS991k0stRZr5fN2ZMXnIaZwgK6i
 zCUi2Cg==
X-Google-Smtp-Source: AGHT+IEQlLcWEUeoKL5ED9JIrfs0gFYpRKmwgykIWhfu9BuTg67/nLmrWekgx1YLzoSf52lbtUHRvg==
X-Received: by 2002:a05:600c:8284:b0:440:68db:9fef with SMTP id
 5b1f17b1804b1-441bbf34546mr11454695e9.20.1746172089982; 
 Fri, 02 May 2025 00:48:09 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a31695sm35946815e9.40.2025.05.02.00.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 00:48:09 -0700 (PDT)
Date: Fri, 02 May 2025 10:45:52 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Michael S. Tsirkin <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH 2/9] gitlab: disable debug info on CI builds
User-Agent: meli/0.8.12
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-3-alex.bennee@linaro.org>
 <294fd9b9-6880-477f-a2b4-773f1e5274c8@redhat.com>
 <CAFEAcA9=YaBw=X+6NUw1D3RPgcSJn0OdmGC2=N=195jjJ7ijRw@mail.gmail.com>
In-Reply-To: <CAFEAcA9=YaBw=X+6NUw1D3RPgcSJn0OdmGC2=N=195jjJ7ijRw@mail.gmail.com>
Message-ID: <svmj08.329a1ofve5fwo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 28 Apr 2025 17:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>On Mon, 28 Apr 2025 at 15:02, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 28/04/2025 14.59, Alex Bennée wrote:
>> > Our default build enables debug info which adds hugely to the size of
>> > the builds as well as the size of cached objects. Disable debug info
>> > across the board to save space and reduce pressure on the CI system.
>> > We still have a number of builds which explicitly enable debug and
>> > related extra asserts like --enable-debug-tcg.
>> >
>> > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> > ---
>> >   .gitlab-ci.d/buildtest-template.yml | 1 +
>> >   1 file changed, 1 insertion(+)
>> >
>> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
>> > index d4f145fdb5..d9e69c3237 100644
>> > --- a/.gitlab-ci.d/buildtest-template.yml
>> > +++ b/.gitlab-ci.d/buildtest-template.yml
>> > @@ -24,6 +24,7 @@
>> >       - ccache --zero-stats
>> >       - section_start configure "Running configure"
>> >       - ../configure --enable-werror --disable-docs --enable-fdt=system
>> > +          --disable-debug-info
>>
>> Do we have any jobs that might show stack traces in the console output ?
>> build-oss-fuzz comes to my mind, but that uses a separate script, so we
>> should be fine there?
>
>If you build with Rust enabled, and the Rust code panics,
>then you get a Rust backtrace. But I don't know if that
>cares about debug info to get its backtraces: quite
>possibly it's an entirely different mechanism.

It will show addresses and <unknown> instead of symbols if they are 
stripped.

