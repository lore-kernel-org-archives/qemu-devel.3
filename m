Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ppIBHENw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMno7-0004zJ-5O; Fri, 30 Oct 2026 10:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMnnx-0004yE-CO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:42:06 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMnnt-0005BG-G0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:42:04 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0d63f60bcso6623717b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793371320; cv=none;
 d=google.com; s=arc-20260327;
 b=G9Zq91ef9HRhAHukwtdWOeXuX2DW9WM5Q8QRmajDMa4jmv0atibQWTm8XkqHSxC1kU
 qP6JG3+lVYDbjuaRAnU5PgqffjwPD7U0bNngpGuclT0uqebgoOnKrvuo4vBjRG4Kh83p
 QhWrUxftHUPkNuAzZZTllzAZRbccXDDSRzrwETPB/XFLAYeMFT/kiUaPp1FKMBwlyDx3
 PaYMjC0p4a+/Egqx18200sqIuUukgpaD77zOFSwq0375UkrFyIKRYOZ1yAX0s9WJKhMD
 tkvD2LHoQhyvl5STZ4+J96jR6zoFJTsoMpjtCIgtbclFO92WuQMBgprqRgO6xYGjXxyT
 mytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gapw+KcNZWU+ikQlgPzLdw+ct1Lqqn2Tg9Otb2s+/eI=;
 fh=5Pmahbx9qiuY0/ciWFYXo9MkH+eOx2AOyAapaCKQ3CA=;
 b=Y9/3oTBU2cCZ9TB+oJ61ylYRSx4cG0A9t/UZblDIbWopffEK/U200QN9CWceLPnJ8h
 Wx+b92U0J0a/68W4hxoEgFkqJ6N2R5XQUMYPmlsIgY4sqmbhVF34wpap/KccnwXl6h/0
 xtit7fsFXx+Elk/M8DUuVwclpILH5VDGwzoKeZ5I6jqBsIV9MS9EokuF3cHC/WG/LsKd
 OePYzXEdhtxg3aXqLGNUkDes5ofgjV9B4Ub+EciFPcC+MwFP0EWxjkinVAeKngLc/HD8
 pdI1XhaVAC9jY4ZhLOQKAcGS4rHJztSbwP2UypR9B2iiIdcHIWEjfuESaE7lyoP4RD/y
 v/xQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793371320; x=1793976120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gapw+KcNZWU+ikQlgPzLdw+ct1Lqqn2Tg9Otb2s+/eI=;
 b=ppIBHENwcVh9kILs5pSiLj62oQOzAKJ1AaD7F9X8weTB90uo9W5lGny6h6bimGnKGx
 H22L9iajm68XxJjXWNDgEt9+7SYq4LOdzKqNHdWsNy0x157Il8/DTDfZdMpitMIJo5Qu
 Nuj22yqKuLSd4D7XsG9OMr9WNlDdZBKCoSTLgZzo5o6ldyxngvIGuXBfRQANW4DLsqy0
 lJ/YgXz9CozVLAm17jAi/T2m15SttCVV7Mv/0rozFnN8gnTiX3oIrFnSs3H1PwPBJJyO
 O+k0C22Nq8cD7cIpRMGSAr/mqKKNbHrMZCttCBcv0DYxDEt9mQza1l+bLvIBk3C1bGWH
 +fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371320; x=1793976120;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gapw+KcNZWU+ikQlgPzLdw+ct1Lqqn2Tg9Otb2s+/eI=;
 b=OuoT5hjF8a/6BbLHhSOEcGL49S9ZIWHZW+ak1rWrYFsND2MzxTBZ1Ux51Qro1DfeVI
 p0NUoRAXJ8K7U2XT6/C10mkRkNHrUxu+1LZmohGFuYcjIiLxDPIXWoUe98aIAzEr0RnT
 hVEajuEjWJkko0LjVBtudAv3bmjfOK3R9yb/NVUlaBs9KFVoqukzNfN+bkUT6oUOo4+b
 tdcCMKUPiY8Rc5pQ+87Wh5T5yojIKjY/xA1GpDuSEYfrqh2bONlLN6zBy1ICs1/mWq5C
 SdlgM28lM3JLfoakuxvSaywlVFooVAGRwzxm/LWpxDMVW9mSxDrcuh29u0TrZ5UGQ4vs
 N8pg==
X-Gm-Message-State: AFq9FYKMVzOV+/T/2oN0tnEdxv6mwf7cDwXivRh+i5RTh/EOHO73xMbm
 pf/YKjSYiRz/6MnFnHIxRYItzu+e8wJRgj/tzRK+ObsXsHbCxfVaVtT2h4QeBoJJxCBcK1onfqO
 oX+ozLVyIEFHBzZr1BMvaUF9HsCiaKjDZguF2qV68kw==
X-Gm-Gg: AYBFou325Ot+nNax4pBvhstd0yvzQL6cY/10Asadtz6XB8/7gh/5n0PLeMFBfdbPQoa
 7zYRYyRyUtfDDqyZb4WmBoBp0LXlJ37v/JxJXuTU6rZLsZh/Xg04W7Mr+d8pHAdk8W6e4HPopjX
 L7uxYfecwC/ZUwFkto1dowNon4tEu7E2C/fGFj4xSWWpyDzigVA3KaLIYQ/V4EPv+1W6PyZ/uj3
 oMhr2kQ1HLSdgj2VmHRvNLFUXbhezUIQFu4x8tQX8NC5QKE7XANKMro24lJXmMVta8Ymgi1qw7L
 4eBHpBk2hWJkRs1b4/9OLOY0EScO15JMmLexJokcgcTbk7sxgIaopjaSaTo/2IVqpnKlw/tWIMG
 LQLHugoOWfgGZzWkqWL8FQx4I22D5XfeuvroDofmhInu5SgXArz8gJva4CRmx3aZe4Xp6gQpNof
 pxFjM2jmMyh0HkJ9KdiUoZ
X-Received: by 2002:a05:690c:660e:b0:8b0:ad5b:d487 with SMTP id
 00721157ae682-8b2b6594f19mr17597007b3.2.1793371319634; Fri, 30 Oct 2026
 07:41:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
 <20261030141046.2710206-4-alex.bennee@linaro.org>
In-Reply-To: <20261030141046.2710206-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 14:41:47 +0000
X-Gm-Features: AclHuK-EWDk5Qyojad4VZyhSRBazgVRsio9eRAAor9pxoAeC5bbyTe53sI-_unI
Message-ID: <CAFEAcA_vh2WhO8wAX8=6cmZx0Fe2UQYJBoRjaJb1YVAG-Lm8Jw@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/arm: simplify wfxt_timer_cb to only trigger
 cpu_interrupt
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 14:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> HALT_WFE will always be cleared when leaving halt via
> arm_cpu_leaving_halt so we don't need to worry about atomic games in
> the asynchronous timer callback. Furthermore, a WFET timeout or
> event-stream expiration is not an event that sets the event register;

No, this is still not true. WFET timeouts don't set the
event register, but event-stream expiration does.

-- PMM

