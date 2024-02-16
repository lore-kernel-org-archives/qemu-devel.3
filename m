Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C27C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawdZ-0007Fr-Ar; Fri, 16 Feb 2024 06:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawdW-0007FJ-SA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:44:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawdV-0000Ys-6y
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:44:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411e5f21c0bso15994335e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708083847; x=1708688647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSe13cLFay3rRa0xWmqrBdET14HK6QYRldc4fFV/fLE=;
 b=JFGoerNPcr7Ho4g5AwQ6nKwGdkTBlcY45DimjUOpfF4UO5T/nm24mkF2HuQ4MH+Zw5
 WceSboMqxHk76XvTJvHriK8Q6tAFachZGLU7WjLq4wfPMWUs9/pYldduRQKHJ4oPoqqM
 ZyOrR10pRGWR5erGEtdMMK0JQB9/VK77ueKJElow/CKcUZYh14lfRR95fd3uqQbsi9iH
 Q4Guqrx12xdgAohcdT6da8YGraDSDkTrAOBazjmjwqcujH6Y46OkrtYCayZiSIWhaLEY
 flZnhO6Fg1EkqmCT1vIzp0FjoADcHitbIPVbn5rZXWmWNXaPQlzgRkwNbfRRMEeWR1Jp
 hZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708083847; x=1708688647;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RSe13cLFay3rRa0xWmqrBdET14HK6QYRldc4fFV/fLE=;
 b=gll79TvPXNK0u3kizfNMyE0d/oTDlyhHhwxGqC4pntNSoaAy+HTHNSPWgWxezuFyHp
 38qBje1AhNXwAnu7Yyl2zB+Gh+u9jIcZG4KpOnYVQ8IDvbhC/hs0/KfEm2gz13mnx1UK
 eCcNZVbkTD0kgPvowwFwK+DLRm6hh2JethLXh/uvBDAnYOjTBzRH6ld8Dmct9x+1OHuz
 E4xmWNTV5D7Xewv7u5fmqjvxRhRwFyllTtKHm+dLhC8tuM9I8WYmqBhQLffL5j7KIu1a
 7xzzYx5MP8A06jlXkV1X8iaV2QRy4627Ut7BHZJRL6Vs+ATezIt36DMWirJwG1ad5Kt3
 QTiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsxAWPE511iMg8yytzAVeZC7+VWIP0bz/jF0ZxY30ayElsNKl2WZjNmy6hxO51c0awN92bEVcZtXR9S/fF4reoXmevIm8=
X-Gm-Message-State: AOJu0YzUHkwD/ryI00/SWhHKmOTXAZYBjcDNdMkm1Gya8swhWGaHRKlN
 qSGPwkly7i68ngb3eo1BejLcIT5iV/e6OPRdCX9yf/EkOdla5TmPplL3F9KEh0w=
X-Google-Smtp-Source: AGHT+IF6dKf717WoAHBSQiPlwNaSG60OvM7z1Gahn+lzaC24ODoc1rSuriUqNjZEhijO0tLbtk3KIA==
X-Received: by 2002:a05:600c:1ca2:b0:410:ec61:5e90 with SMTP id
 k34-20020a05600c1ca200b00410ec615e90mr3630517wms.10.1708083847243; 
 Fri, 16 Feb 2024 03:44:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m5-20020a05600c4f4500b0041253d0acd6sm150381wmq.47.2024.02.16.03.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:44:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5ADD65F83F;
 Fri, 16 Feb 2024 11:44:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v5 0/3] linux-user: Allow gdbstub to ignore page protection
In-Reply-To: <20240131114817.288027-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 31 Jan 2024 12:46:28 +0100")
References: <20240131114817.288027-1-iii@linux.ibm.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 11:44:06 +0000
Message-ID: <87h6i84os9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> v4: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05857.html
> v4 -> v5: Fix the probe_proc_self_mem vs probe_proc_self_mem() typo.
>           Add Alex's R-b and A-b.

I was going to pull this and realised it already went in via Richard's
tcg-next. Did this fix get merged?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

