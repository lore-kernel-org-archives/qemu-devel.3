Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08373CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENII-0005wz-Ew; Wed, 07 Oct 2026 04:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xEJSh-00059p-Vj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:41:07 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xEJSc-0002fE-P6
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:41:02 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5ba37877490so1181178e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791348054; x=1791952854; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ik/hojUtRmfVooae/SPDnjYNa1bQB8bp9dQu9aYtayA=;
 b=aSlG401onQfiUzR6//EWADZ8Djjh8qbnkU9fdyUuXVmWZDMZH6Zkr7OMPnqUTB3+Zi
 g3CHdjJQqaJFeOy9Sx/tZIr8+1rtknVZ3n6Y72kWScX66IoNu7MkNO7jtArvUMSlC4da
 Gj6lkl35dVqg1tOsdwzZzjsqSXtEArksP5SE5Zgu1f7Hm29XWQzQ66MdUsPP32P2l/Rg
 ji55JR54u0Gwv9vqkfS5gmosP7kimgawbbtjKLm++gMxKl3v+6UAIFkohFV+qs9DQ9HK
 uifn46ExnRHODdGsAetxT3R/ZQY9EXUb+64jR4F6nSP8DF3AW+36R2o+6qGMCuGIQ44W
 3zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791348054; x=1791952854;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ik/hojUtRmfVooae/SPDnjYNa1bQB8bp9dQu9aYtayA=;
 b=snjev8arECURCp5l4fq0YQkAWmpaEvQ/IQjksg5cqCgG9e0qiQ5qWs5o2mfN1o3bt6
 3k0wYfsXZQuiL1SQ3H1fvH97Qhy7QEf/4ruQ6j8Cca4LuFsOjSf0PbwabLwdwbncx2yw
 OfwzC1vgDDHn++vupFFpiEMJy8ujvgXvOy28HkbRWikn7+zihKdL3Liaocz1alXvOyF7
 XNDFf9NSLoXz3py4bKqmxjT/iQzpA7+Wy61eZnvJvle+AaC3GBBokSnCuguRhWIXq0qG
 /m6UfaN+gdgpEBaB+cvRLHBda7s7TNnoI9K6lkp6MbXpUU67TPC7sYa3z4M5dSTE1gvF
 Xpmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCO+5CBKHNk7LWrJQsoLSuu00ujEDPZdc8YwwqGF5g0kJpcjhgZCcRLf0z+/lUkT7rn/XTPG4EAKJc@nongnu.org
X-Gm-Message-State: AFq9FYI1s5qJjo6IEsEUkmArIMR3zJoyUS1YBaXV8K4j9zRH5d+C1MRg
 gTxCr8QFG8UV10z6iyXg19RPp/RDJQOd6+ErKxaIzaw5y+vmloK7/YJIWKBLpn56HQDKoI+45D/
 52935YRE=
X-Gm-Gg: AYBFou1ix9vHycxaB8ZQzQzJU+C82hiiq6Dxud8H1xN5pdJfvVCS7JWlj6ybBfkBjzA
 ZGaxO2hhzbuOC9goBeds9IATuD/vlSFqdDn3zz4CNoWUY2VxTdR8GFFOnS8Eg6HDscqodqM3Mj6
 udj4WXpbPEurkqhzTcS6YLP9ENQwoJMGSkisYCePxDlLkk7fzgXN6orPaY4XStWAQR+/Gc8gokO
 oAhylnPmCk8d6AdhhjWfRFGZZecN8DWk+eLSldfYLv0I/rj7HllcEN2jgE/5SRhCZhPocTb5Pft
 AY8rwDMdXmEbdc0S1jdUI/jXnwlqGmTe5TtwETUNMAOdnc4yX8ZYBWZYKs99rl+p7Q8Zdpg5/aa
 JJSCAhx77VC3qslRZh7i2SjjLkxdEjaGU4D867xONMC6uhwPEj5lsveCb2egnDySRwXMSKbqj+O
 uIccKjgr4wNKrRsc4/XxFD5x3zqg6yV00EnHKDGe6J0CDAlhXaHLyyu3JjrD4IBhItvsMJog==
X-Received: by 2002:a05:600c:8b54:b0:49f:ff7b:f056 with SMTP id
 5b1f17b1804b1-4a17b5266b6mr14641355e9.9.1791279879743; 
 Tue, 06 Oct 2026 02:44:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178daa115sm60319325e9.9.2026.10.06.02.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:44:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0458F5F861;
 Tue, 06 Oct 2026 10:44:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Warner Losh
 <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <asS0HLYRmZhB3Ban@redhat.com> (Kevin Wolf's message of "Tue, 6
 Oct 2026 10:41:00 +0200")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <69164823-7271-4d59-9684-637bec454a1d@redhat.com>
 <293cb972-35e1-1922-0834-601e2491a7a6@eik.bme.hu>
 <asS0HLYRmZhB3Ban@redhat.com>
User-Agent: mu4e 1.14.4-pre5; emacs 30.1
Date: Tue, 06 Oct 2026 10:44:37 +0100
Message-ID: <87mrsrjh8a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 05.10.2026 um 23:09 hat BALATON Zoltan geschrieben:
>> On Fri, 2 Oct 2026, Paolo Bonzini wrote:
>> > I agree completely with how you phrased the first and third.  I agree
>> > that the second bullet is a risk too, but it's mitigated by "LLM-creat=
ed
>> > contributions will be held to a higher standard than human-created one=
s,
>> > because LLMs make it easier to write tests" (and by maintainers being
>> > able to
>>=20
>> Tests need to be reviewed too to be able to trust them so that does not =
help
>> against overloading reviewers with generated patches but burdens them ev=
en
>> more: they will also have to review the tests before the code.
>
> The required level of trust for tests is comparatively low, so it's much
> easier to review tests to a sufficient level than say device emulation
> code.
>
> If a new test looks plausible, fails before the fix and passes
> afterwards, it's more useful that what we had before, even if it's
> technically buggy in some corner case.

And also easier to rip out in the unlikely event it infringes anything.

But broadly having a test* is better than having no test.

>
> Kevin

* modulo the effects on our coverage.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

