Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD898CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8iq4-0004Zo-CJ; Tue, 14 Oct 2025 13:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8iq2-0004Z8-Af
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:29:30 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8ipz-0000UC-Vm
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:29:30 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b50206773adso22615566b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760462962; x=1761067762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cDlCTMlkSKTqP9Yi/cWsxZcU+AELcaJhI3cOf1BkoQ=;
 b=tMfMyhcNGxQ0nGerA9WiyPaI/GwXetRfnc6ykCoIsOFll5cYmHUAVp7skQwSeQANWF
 IOQzWfDRBHbQahX3T+qzQExm7mEphGH8PKRpXm5tapFZd0mmj2MfgZ11BwJr0hNuSRXK
 n6GiJv+XFPZ56IDmPQt3pBR1+sJ7GH7kZY0/zrOrB9jTtgLApgcGUQVcIdQqWsWSRwX6
 BY7XHm2v3F1vS5pUTlK9JN7hf4ZxzW3QoY/fshDrfT7CD78tRZb0jFm3a8brpVN/c8MJ
 iqMnK70paKYPWzikLw6ta0hwFUHj81fTG3rEMStQ1W8QgDzjVKL4w3L+4xXoXHzD+QoC
 BRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760462962; x=1761067762;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2cDlCTMlkSKTqP9Yi/cWsxZcU+AELcaJhI3cOf1BkoQ=;
 b=fd2/tStlOsmZILVfPiyx8QCpRrvd62fu0cp6R3oRMIq7k5cuMX3x8ztnCsBXPYUCc/
 6x/m/1IE+o5DdXIDyG/Nv9MU8qbEU5pu9FjL6DXw/UspkbmfPu47xnxKL9xduxisLxLV
 v2CRBMs8P45WibW8XsjqBUZpaPkz/SgAqgHf1vXxhYW0/UekbC8/s2LdT60ETaOuMq74
 ULYAzUdxDRxPIPMWGug4XaPANqRd7A2DoVrzDXq3BVFPtLBaTCg4AbfL4mfntO7LbS1V
 MIWQdDKzxw6EjzIzEiJlyCpVs2WvRdotT01NthEA5CHlrENMWuLMXK7kMpKoo04uRLX1
 SUPQ==
X-Gm-Message-State: AOJu0Yxin549GMBLO0IiU0PxguruQSE8Kxf2ZOhk2DtVJFJwKlXe8GkD
 6InW1ChuaIfvRXGgkZO4FTbnOxhnxM0vUMUPyOYTLQ2JWBy/ORzPf9eOjc8Od2R2aWU=
X-Gm-Gg: ASbGncsFBVE94Jy4sdGUZt0LP5w7q6R6SoQs9uJ78qqRKSTyNN9FQmYf1BYdCTk8qSh
 kcYLxPlF+igT92Ct6B6KXsgGWoidgC3wBmap/x1eydo/XXfCZ4vVHownZhhUy3HKw6xMqnTPODF
 3QJMyDvYV9dDAUxt7pI1CC0BZ1CERx+DcDiPDO0E+TOyGeJPw04BGvpOfSEFWokqjHEA4JWANY/
 2L1teGKSpfC3sEzjf/l039FkzDmJLiUCAeEHWP2odJd7nLmxPKYhse7ZMPEtCQzO3e2HY2ZImgF
 ReDy6YjFvABLj+wCLI4vQll5Hz9/NztqDUCjNgWCWsHuze5Vy2EveTmeH+AeQ5ONUIYZy4J1ccY
 +CBaIQc0r+KOdczgLGLnt8m4aBELVZmk74rafFRdJNr7m1Q==
X-Google-Smtp-Source: AGHT+IEhot8C6ArcF/aUW2PW+HByz4/sSmvWg7O1f1gNWOhsoq24dg36oW/1RBHD76akBbH8tlKdIg==
X-Received: by 2002:a17:906:114f:b0:b5c:6e0b:3706 with SMTP id
 a640c23a62f3a-b5c6e0b3754mr111011166b.13.1760462962107; 
 Tue, 14 Oct 2025 10:29:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5ccd6b03f3sm23425066b.74.2025.10.14.10.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 10:29:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 724865F812;
 Tue, 14 Oct 2025 18:29:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  Gustavo Romero <gustavo.romero@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  BALATON
 Zoltan <balaton@eik.bme.hu>,  qemu-s390x@nongnu.org
Subject: Re: [PATCH 0/5] testing/next - arm custom runner tweaks
In-Reply-To: <c5003498-7914-4d94-bb79-0851c49c47a1@redhat.com> (Thomas Huth's
 message of "Tue, 14 Oct 2025 12:47:01 +0200")
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
 <c5003498-7914-4d94-bb79-0851c49c47a1@redhat.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 18:29:20 +0100
Message-ID: <874is1l7db.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 14/10/2025 12.43, Alex Benn=C3=A9e wrote:
>> This isn't quite ready yet as there is an in-flight MR for libvirt-ci
>> and the final patch has to manually drop a couple of packages which
>> don't cleanly install. I don't know if we should deal with that
>> upstream or in the lcitool metadata. For reference the two packages
>> are:
>>    libcurl4-gnutls-dev:armhf
>>    libglusterfs-dev:armhf
>
> FYI, glusterfs is deprecated in QEMU since a while:
>
>  https://gitlab.com/qemu-project/qemu/-/commit/b873463821343c6f702c4195f2=
168790b09cf44e
>
> ... so you could also add a patch that removes it from QEMU now, I
> guess.

I can do that.


Richard and Phillipe reminded me that we are due to drop 32 bit hosts
real soon now so maybe I should just remove the runner and the hacks
needed to get it working?

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

