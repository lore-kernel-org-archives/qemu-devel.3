Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF302FEE4F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwOVc-0007gs-Ft; Sat, 28 Feb 2026 12:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vwOVa-0007gC-0M
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:53:42 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vwOVY-0007Kd-6J
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:53:41 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b936331787bso474785466b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772301218; x=1772906018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGsN5XkGqvId5gNDtCGpTR8ZARuO5Xb+l3BWWNmHaWc=;
 b=VoYux7Nzf/sl/svVVQm9BAiL/UM3ceSAXTiMvCa9uKqfJg3DhMNdEk1JzmGgqWYEFb
 +ZXlI/CQLC3rkj7FZgLMkE6tkA+3HU01S9aCokhyK8JgAeonl10RqTUQmlqtCHvInisT
 VzP8Vz2EgFveqPjH91lOn4gdsOhMTsxwfEIkasVSwePVIUa1WpJtUj86QXAD7vHNu3ek
 BsDorbY9T0PXP3XIYYE7c9fYceeiOnZZifqo4l0a/b79B6e1V2qw6ROXILjcSRbT6VTX
 BuU/YOggz4ndeVxy7Ufk3Q6raatTGDD4A0dJezM93TDHzaKcBZQJCFByMyWNoJN18hlh
 iSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301218; x=1772906018;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGsN5XkGqvId5gNDtCGpTR8ZARuO5Xb+l3BWWNmHaWc=;
 b=n1/pW+e4xlnI4GE5ADCmyZBTkL9lJcv9Dcj495Dv7wsYrwafhn0sfrRZFyZ/4eog5e
 zNGCZ+D0FWyHWs/mUe43WTyV5GmjM2bT2K0TiLzs/A4JjDiMl+gLKf5ZS92mOX9Xjd9f
 +PwPESGsa2gv6ahlA4HCGu0I5SrUFu7Gq/pzS/pFXKuB2TtpKhq937Xc7AXrbxaRkGHB
 QlImE98p0cyum1GTRmb1KjDNcJn1s2PdBMYNKDZufXWg7ZQl/ZX6ILe2AbLJEpHT46EM
 GR8/5wom4pIEh2CDI6h5oagFD2NIuDAVsImw4lYa7rCnNTlK2YbsjphsCM3QXOL1/qgf
 RRcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuyT1KjA+D2kovHBAfmB9uj6475DNoWiVg775UtbYa4i2TCXn7a5lHoTJXCTys+XXcTneTxu3OTUdW@nongnu.org
X-Gm-Message-State: AOJu0YzGBbtP3OxjjPiRAcnmrY5EBZ9D/QPAPxm+jmjsD09AM8+fhWPg
 rUvKdnxh6BiaL+8lkHA1nJUF+iEA67QKb+kgNwHK+J9zmhABWhc/VyUzBmF4ccfT1wCd57VcKt8
 pDzLr
X-Gm-Gg: ATEYQzyDWu5N6PTfFgmsiLpq8UZ8tc1f2vv273bAEvrsNCEsmb7ivR1yVErqXaQQcan
 DJp5gOMjG4QL/VWAdVsrMFnsaAV7G4Or0Q5FhftHpPD7+UXshpkmwYVQxpw3D7qaqBEVWRV2JT1
 vw78+cu9lraOw/WF9+CNFrU69q8/+CpM9KXnRjB1irINuZCPO2O8dLrx//RVVhkFMP33jbrcFCR
 VA5eKAxTZGhSe0WaQTzoVCOzram3TGYxeUJgIWlZHk5fpgp6rDBeJIq7r/w0pp8q38dSXmT/jIz
 Xop7Idv0AL++/d8LjX1fpeFqbbueykvYAAtV/JKXJQLVNY8ENnxv1XM7xDMN//IacyOcrO9tKfp
 T+PeJaw9kdXCRvAMdIbyNui4MuJJwTTMS87S1QN/t66xPtG+Ynrp+FFiCl+lIGfUcPsHhwKRDDe
 wDLOXbk0pEuRLU5Tzs8idW254=
X-Received: by 2002:a17:906:ef0d:b0:b8f:a449:e362 with SMTP id
 a640c23a62f3a-b93763cbe55mr537510566b.25.1772301217687; 
 Sat, 28 Feb 2026 09:53:37 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aeaff4csm258892066b.52.2026.02.28.09.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:53:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00D615F818;
 Sat, 28 Feb 2026 17:53:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Florian
 Hofhammer <florian.hofhammer@fhofhammer.de>,  qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: ppc-linux-user GDB stub broken
In-Reply-To: <f331c8ab-e99a-410f-a1a8-1cd28250d516@linaro.org> (Pierrick
 Bouvier's message of "Fri, 27 Feb 2026 13:24:12 -0800")
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <5e99783f-6e0b-46f5-80e0-ca5036544a63@linaro.org>
 <f331c8ab-e99a-410f-a1a8-1cd28250d516@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Sat, 28 Feb 2026 17:53:35 +0000
Message-ID: <878qccpxeo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

> On 2/27/26 9:21 AM, Pierrick Bouvier wrote:
>> On 2/27/26 1:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The error message is as follows:
>>>>         TEST    basic gdbstub support on ppc
>>>>       Python Exception <class 'gdb.error'>: Could not fetch register "=
fpscr"; remote failure reply '14'
>>>>       Error occurred in Python: Could not fetch register "fpscr"; remo=
te failure reply '14'
>>>>       qemu-ppc: QEMU: Terminated via GDBstub
>>>> I've tested from a clean checkout with the following commands:
>>>>       ./configure --target-list=3Dppc-linux-user
>>>>       make -j$(nproc) all
>>>>       make check-tcg
>>>
>>> It's odd this config isn't caught by our CI.
>>>
>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/multiarch/M=
akefile.target#L153
>> ```
>> ifneq ($(GDB),)
>> ...
>> # gdbstub tests
>> ...
>> else
>> run-gdbstub-%:
>> 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst
>> -%,,$(TARGET_NAME)) support")
>> ```
>> Unfortunately, gdb is not installed in any container.
>> At least we caught something with this bug, which is great :).
>> Regards,
>> Pierrick
>
> Alex, is it something you could see to add to existing Dockerfiles?

I think we need to work out the equivalent of gdb-multiarch and add
mappings to the libvirt-ci project. But for linux-all-test-cross we can
add it manually.

>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

