Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16EECD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMW1t-0005VA-Fi; Mon, 11 May 2026 15:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMW1g-0005U8-4V
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:10:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMW1d-0000nm-QP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:10:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso44563675e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526644; x=1779131444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4D6erpN4DeWX2fdEYJ1e2AWnvaOfG+j9wQBAlkBW9vY=;
 b=zO+J6o+Kqs35f+y1JUaSy/naRPvQ7Hy8c/FEFsR1IuAI0gec4jO++Htr0PeiRIs67D
 jCx/j4Qv8T4Rg9Erp4eCBo6+mLVwSZxIrMvrBGgR3kqnScVnGsGPWvsBAak4TsXHkX8B
 pL64XZKZP705UPeP82lHQw91kQ5qch3W0AUmVd6lPPvlFBtIidXNAJ301O32VBrXU3vM
 aqLYX+cHSgvjLFLf8FJS0qJkONSgd9wlkR88peW/MOcHA7flPUrGTnUD40UZhaTTjMeB
 ETMCmxJQ1JRnw5od5V+1ZGTnp5GkluvkbqJ8r18YKIrqxcM+Me1V0kzOSsHgptcIhbVo
 RlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526644; x=1779131444;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4D6erpN4DeWX2fdEYJ1e2AWnvaOfG+j9wQBAlkBW9vY=;
 b=XpGmq9vUyPzY8Jx0CR/C0rFHtMElf0fPBKOLcI+rgyXAKkO2lqzUf+bF4NxjFivbFB
 vWAmLlRNPgk/SKw0bWnUqNpHt2ZbT2kX6wV8PCH+H63bv39+wPts/+1g/b2CzNpuNlEP
 yIo+fZXD+lLEfERYSgRV3O7TC47aYbk83+mXnn3UMM9euSiVo1/vOqxPuxLncQRQliLg
 GiHfQrgZN1zL3U+MGFvvhXAq+YHhO3UWgQdR3hgnn2Q4/3J8lv3+gKW6xXjMLvZ/Azvy
 GnF8rNFIxP/HhDoXt9inMDrESYYZ6R05DMuxMUm9yA0PNh8d60jkCEhXDjEPdtQ5paAV
 jyqA==
X-Gm-Message-State: AOJu0Yyl4SLL9q6UCGH2monH6tT1I2SoMoUKtrRnHBSA4MJmneTftteD
 egvfoKavdTYVzTUhd5f0Q6qdYitThm9N8JFmvqOl5hI690L9arB8ECAM398HbvT4sfs=
X-Gm-Gg: Acq92OFQ+QhDAhU72ovT27cYQKOAFLTgsxTVc1Slpjx1kkhIlp+zDQmCvDy7c7CnD/z
 so/wzU+RZg9mav/IhU5nfnAFBevOMXf+b3aLvswf7n4qu//+KxGSN8qk2AJJZoelcQXx03QQzCi
 mWesHakYPzuKTMRKpit7MFvZV18TzUoEZEQ1p4iC/tmFARUCf1bwnJb8OIBTP6lnvWsm4Syu+Wx
 fCmZ2EdVwn7khDB2CJqrQcTwHwwz4X7Pfe9iDD5inocl8p8R0O+BoQm7rEabQljquer5BFODvhb
 CULIhx3hHOphK9sCI1qEG/Wwu0GW30CfgGkN4hVXklorPcbndgB0MxO9AqLG5u2hAuM0EGirdpR
 FtFxd5E7RmSzP1XfaMD041uKpiciNS4Tjc2RXdygBJoFo36rkqOkvcmebVXWI0zLH8Fxu8vUCHz
 TiIkD1qH9MGmXYhS/sknpKn6kWruBKgpGQ5w==
X-Received: by 2002:a05:600c:859b:b0:48e:7f1c:8778 with SMTP id
 5b1f17b1804b1-48e7f1c88b4mr111124445e9.17.1778526643782; 
 Mon, 11 May 2026 12:10:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702ec51fsm181671245e9.12.2026.05.11.12.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:10:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 121B05F7C1;
 Mon, 11 May 2026 20:10:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] AGENTS.md: add basic AGENTS.md for QEMU
In-Reply-To: <CAFEAcA_tTR0dXKGp2y3YanS3wASrMSgcNQAiET3ff-c7HfBLBw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 11 May 2026 18:58:43 +0100")
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-2-alex.bennee@linaro.org>
 <CAFEAcA_tTR0dXKGp2y3YanS3wASrMSgcNQAiET3ff-c7HfBLBw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 11 May 2026 20:10:42 +0100
Message-ID: <87mry5daod.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 11 May 2026 at 18:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This was written initially written by ECA based on its understanding of =
the
>> code base. I then expanded it with links to the various documents and
>> the general coding style.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>> +## Security Policy
>> +You MUST NOT report potential security vulnerabilities in public tracke=
rs
>> +(like GitLab issues). Refer to `docs/system/security.rst` for the proje=
ct's
>> +security stance. In brief:
>> +- **Virtualization Use Case**: (with KVM/HVF and specific machine types=
) is
>> +  the focus of security support.
>> +- **Non-virtualization Use Case**: (TCG) does not currently provide gue=
st
>> +  isolation guarantees.
>> +- **Reporting**: Report vulnerabilities privately to `qemu-security@non=
gnu.org`.
>
> I feel like the important thing we want to point out to agents is
> that not all "this crashes / asserts / overruns a buffer" bugs
> are security issues. As it stands I feel like this text is
> going to steer them pretty strongly towards throwing anything
> and everything at qemu-security@, including bugs which we
> don't consider security issues. What we want ideally is to
> give instructions that will make the LLM itself do the
> initial "is this covered by the security policy" triage.

I think for that we should augment the triage skill itself.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

