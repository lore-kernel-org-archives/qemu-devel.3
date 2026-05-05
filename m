Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA8EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFbb-0005wP-O9; Tue, 05 May 2026 09:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKFbR-0005ua-7S
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:14:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKFbN-0003FO-Vj
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:14:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so50856165e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777986855; x=1778591655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iO64keNoGXPMR8N2hFUOYpnptCos90qV/Pz8QRujpxg=;
 b=s1e+VCCTQy+w675vD0vHhguuXRSVN3Ap+5xHpiJlFa6VYBJIdHO0M+s+Nx9VLrqFL+
 6FU+rzhl8/3MjtOvbH03KwYn7XaEaGqWl8yDIUAfiuPIS/hL8/D7oXo6bi1dqYTLmWTT
 YjyiYsKL0rZGnVYR4qh4+2Gp2f5Sr+RqshbGQhQ3nl0gNSceOSKpbuf3pTOHQA7Z7hha
 0Bg2eaF2p29HbQYQI68Nn50UDyskyBB3496ERWpx6GsZEzVZTuIMR7SLD0Ie3DrYFWW2
 PbtF85jgeawscywJv2F1C4EOzLBQNdIhtYDr8XWikPAMgLm1DxxEZZ5vs9K1ClxfVQvo
 imOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777986855; x=1778591655;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iO64keNoGXPMR8N2hFUOYpnptCos90qV/Pz8QRujpxg=;
 b=Lna7sAdNvI0bYiVP170LDH480770iZSOyBUbfXQgCQAFD/iDF+6MLPhCR052Gg5u4Q
 ZM23J5dOd+GhfiqO++hXz4bO2WGgN7TwRIHlnG2mdg6ONCqni9fzt0b6LoT7/ZcOOQ45
 l/RrGqy/P5ubUxcCY4XquAd+wP5FxX1a68zNBYF+vixH/BUgq2qA73h7YTisQEH/8ubS
 E3H4MizynxqdOTr5OyWr2JBfqoRSTfwuIRG2XvH98k8TxzmZ5fvLC3wumDAfBbOFrjPE
 qS1hIPg/BYc/F4ubE/Aov5kvgpVCAzYxxvq09LkixQASaIBYdAffii1FYNNjrkjKmtLh
 4lyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VUDK52i4ENjxrq2OB7XemvoWM6eIZTc+eQi/i6+vfSuxSbN6UbRU1IG4FxANmIiLIBCYZsiVH1g76@nongnu.org
X-Gm-Message-State: AOJu0YyXeigxeILO4IZYkPk4UtRcyeM2ltNEjwjcYmGam197ejeIPvft
 y8GIr6ES5RKae0Ai02X6iuyKAisyOFYHFD69Dt+lOmBS5gJeoQtN9+RclSqOyB+QU5g=
X-Gm-Gg: AeBDietD8cal65dCio51XMih9gIr6pY4XElNAAHWR3Ri1NEuTlnSv2AIMQVm9DNkxX5
 Exn99fe8QJeq4U4djGdRMvjmTarTvNLT4rxeHmQDe8QmfEW6g2LAVY6F8WazN9h/0O+VBsK6PJH
 zW/uQO4Zg38UFKBrClBgUByGsveO7Q52S/fnNgFRUVXXE1OXedk71wg+mu07xwUfKWpY7gAehbf
 RVTB0qJ8xgFy7QWg4ueV/KuW+iJ95OQXD8iVe8lpuXtoTsibqRlP79Aa4juET9NAUn+sCxtE2+a
 cY4Zp1/KMwnEn+Fz68CoW0xdaRUkr/gk3BU0YeyzzsPNDthf4eRnZJfLV6b+yt1mb53T908YcPJ
 Hncz1+gy+R21gvyRE6pKMhcLjWnhQ/OQstpHSTnEI/MnxpYwncqoLPF3TkMz6cXzwkQq1pJSU3z
 dOh5KREUehEDTx5jZ7BGsEVXehf7hh/MDL0g==
X-Received: by 2002:a05:600c:a08b:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-48d18be5a4dmr49268265e9.13.1777986854812; 
 Tue, 05 May 2026 06:14:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6ffb7sm354116345e9.5.2026.05.05.06.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:14:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 432AA5F8E7;
 Tue, 05 May 2026 14:14:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [RFC PATCH v2] .eca: add an issue triager agent skill
In-Reply-To: <CAFEAcA8OQ_h2ogT3=oDcbts-DL4VeDoitTH2or=_CH53xc6LoQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 5 May 2026 13:44:44 +0100")
References: <20260501165812.2212713-1-alex.bennee@linaro.org>
 <dc540970-bad4-4883-b4d1-9e206de8a73c@linaro.org>
 <CAFEAcA8OQ_h2ogT3=oDcbts-DL4VeDoitTH2or=_CH53xc6LoQ@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 05 May 2026 14:14:13 +0100
Message-ID: <87y0hym21m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> On Tue, 5 May 2026 at 13:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>>
>> On 1/5/26 18:58, Alex Benn=C3=A9e wrote:
>> > While triaging the issue tracker I wondered if this would be a
>> > suitable job for an AI agent. Unfortunately the OSS program doesn't
>> > give any credits to run agents in gitlab. However I do have access to
>> > models from my editor and ECA so I built one and tested it on a few
>> > issues.
>> >
>> > Obviously this can't apply as is because it probably encodes too much
>> > of my local setup (using pass for API keys) and uses the ECA as my
>> > preferred coding agent. I assume at some point there will be agreement
>> > between all the agents where skill live.
>> >
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>> > +workflow::Confirmed        Bugs that have been confirmed and reproduc=
ed.
>> > +workflow::In Progress      Someone is working on this issue.
>> > +workflow::Needs Info       Issue has insufficient information to veri=
fy.
>> > +workflow::Patch available  A patch is available
>> > +workflow::Triaged          Issue has been triaged and given a topic l=
abel.
>>
>> Some of these labels do not match the case of GitLab ones,
>> resulting in new (duplicated) labels being created there.
>
> Notably, the label listed here and used in gitlab is "workflow::Triaged"
> with a lowercase "w", but many of the references in the SKILL.md text
> get it wrong, e.g.
> " - Use `Workflow::Triaged` once categorization is complete."
>
> Similarly for "workflow::Needs Info" and "TestCase" vs "Testcase".

Interesting, it was a script that fetched the labels but I obviously
didn't look too closely. Will clean up the cases.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

