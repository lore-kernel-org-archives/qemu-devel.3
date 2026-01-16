Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6D7D48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgi9D-00020c-MV; Fri, 16 Jan 2026 06:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgi8q-0001xq-KK
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:37:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgi8p-00011x-7Q
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:37:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so993728f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768563440; x=1769168240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/9FO1UO8KL8VpofMlm6RsNWYo0B2Gy8oMuLBOYMRLA=;
 b=WJcXbxK4EQqpcukC9SMAPxWUOf+UWJ6yXr5avgVCatnmWGIdXsjvju5IJMM525wMgp
 k7dEtqcnD00/6vegzZtCcY9aeUDbAayzAbZK+eyMBXQ4aLOf0B1bu+zmLBFzJup4I71a
 iHoil50Bug4KsEMWWli8UMjCS4kRsBtVUrV/Au7l+tmsTi05GjB6yNPj27t+4Z/HxjnE
 KJt83IXCZa+ZNzKztlBi+R2jtnIfbXfsKMeICgqahIn2AluNvPQPDNICTmfJx7iMjWb6
 rRRP8L9+uCi/h+ZHgSpgQ/bpOg6uhDYxpAEg3a58azEVqGBJ6W2RJHhxMU93irnWl0PP
 qkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768563440; x=1769168240;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/9FO1UO8KL8VpofMlm6RsNWYo0B2Gy8oMuLBOYMRLA=;
 b=Pw2MvEQbZZmh7WFQRuGVCsk9RCLv/28R55K5ePh3prtjcflqcmyUNv/M35bjpPzuXs
 hDDJZtW3az0CarEtyvneH6h82zYgTF95wwnX5n5HEAdVxhVEdaCqEwNirNCL/Y2j8OXJ
 4hVnLIEDrH29jM7jwIeUGDTBgk+c+4Lz4Xzq5pq79LluWW30tgWxlyv6qe9EmiJuTWzF
 gnz6z9LjMzERn4YEm9ButEgqn63YCPSE8nlHpeiRy4I+h8x16nFO1epyDvd6qFJPEoX9
 tz3iNKL/VUx8cllnwKMot2xhiMJqiqRPfmyE6/oC3s3u1d8XUvMl0r6niDkL5j7jXfE4
 pKpA==
X-Gm-Message-State: AOJu0YysUVb93OKPQMBDc6KW1MdL+xuqi0Ud8aJmqZjJY9dxx1bptkRr
 jvKfZ4E9rOGhAPhciu6/d2oZJnBqcQ2SL0qQNBNTINIpZZNH28Rj8fwVbsOXGSqaknM=
X-Gm-Gg: AY/fxX6lD3qQ7ICngOsXrGnrVXHTDWLdRPaYsNbDV4z8KlkSKRJn1t3e5z2obhFHKmP
 Mb4GPxPlPx68IfJdJKqtuzipi7duAlS6JjUMUb9i2R0PlyjA+VraasM3lsIw9xWwNEV1TEQKB/c
 tAKwYnGui9c68ro3wmea98yPMtENdUN9aVabbKVWhGE1dZBly3UZI+d+BV0hKhlsd5uWace5Xkf
 hFqPXOIX+/NdNC+vSs+iaEH+FDiaJyHNKnGJqm+X9af2hLhZbNHylBtqcx3kBMxvWpkfk+nc5e3
 NNbJmirD2n4Kun/2chw7piUSJaXLuVab0rgChx3eWym7YWVAvvwReOo++8nQ2QVIK1l9kpfatGp
 lSCbPBwrngyRV1ocQgNORCY3ZMJlc2nlv8wJCQ2ayO8S39GneWFnztiRMJKe7GQyH12J1dcWjCV
 TdLCPu2wwoJtVSw4GZXBp0Tw==
X-Received: by 2002:a05:6000:4304:b0:432:8504:b8a9 with SMTP id
 ffacd0b85a97d-4356a06769cmr3425031f8f.62.1768563440395; 
 Fri, 16 Jan 2026 03:37:20 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm4907193f8f.6.2026.01.16.03.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 03:37:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9C0D5F898;
 Fri, 16 Jan 2026 11:37:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Markus
 Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  John Snow <jsnow@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
In-Reply-To: <20260115203529.2713193-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 Jan 2026 12:35:29 -0800")
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Fri, 16 Jan 2026 11:37:18 +0000
Message-ID: <87ms2dhjpt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> I would like to help maintaining qemu documentation and I've been
> invited by Alex to apply as maintainer.
>
> Files in docs/ that are already maintained will continue to be under
> their respective maintainer. The goal here is to have someone that can
> help on all other files that don't have an official maintainer.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

