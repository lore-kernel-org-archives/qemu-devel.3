Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A6C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raelZ-0002I3-MD; Thu, 15 Feb 2024 11:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raelY-0002Hv-DJ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:39:16 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raelW-00021b-LT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:39:16 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5639c8cc449so1429712a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 08:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708015153; x=1708619953; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rIX6r8WyzbgEUQEDEK0M/W77NMvKPGfg2MfrjWJ7KkY=;
 b=XV0h6vfvkzVQ1dmR34HBqau0yYuNsB7/5ptTLvuJl/YhqHwcI8vBTX/x4K3fqT+jKN
 e10rwsY8Cfq1LE6f3i4d9EYU7GDjHCAGe69YBIalUCzxzgdxC9C+GR47C/BPgzBNa8nb
 Q77cDiTT/ICqbcgBfrFrFVrwMCyAkeD8zJDTsdylcp/pZPkdnNmzFp//MNffCfxUYqpj
 pdv88vnuAm6JrpXwMqLwX4e0tK0CYzMGysaSFL86YhbJWWCcWWUkw/UCOZN1Wb0cMCi2
 TBTnbOkPJRresS/12sb3L5H6LUs1gP5HJjhZgAfsZG/OOaakp4WApg82pemg79MMrmps
 /4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708015153; x=1708619953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIX6r8WyzbgEUQEDEK0M/W77NMvKPGfg2MfrjWJ7KkY=;
 b=onzc+tuO9HUyVMTGz6HH5/lRCHR3qQCuXkWkwA8bIonclCrGJ86zA6100QCBMi/rWl
 c4Cz47mmwNDbeWE/WYhYgAkRdAd7oBGFskVbjGFzxsTsBWEkysvGQSRE6iaADdEh7vX5
 03EcStghsAekydTV3L4SYyRQFyI5PNzXR0pzebPO8pmi4BsDstEWew3thdCNQgM7iX5t
 ZnUlh8x/bUb/T7a4sLPf+FnHxDQ68RImY48EhE7BCXeiPQFx7aY20jbsVsNVZiUnf5jg
 3qPmvyxRJlnAAVHHl2NXMUfUZyeMoOm5elDQ6oAHfjpa5iUAr+uZIUmOCnIcndQZ9rgP
 3c9g==
X-Gm-Message-State: AOJu0YwqHl9JSdxwAz5q1o4TqqjlnX7tTQP0D7RL+s7KSnSiSZHVPRog
 7Xi0Okg15Z4TwrhORO9izv+1r87HTm0lSh/gIndtFFIO5uNfCO74pTNP8ybqdYPi0fXjUpF/Bng
 wUZ56vfY0TgDYgI8mWbGttNH5tlrHvEcq+m+hqw==
X-Google-Smtp-Source: AGHT+IEd0V36sKOcrSCfmM4iPWqIm/mNbu0ueUvCXZAtoRbZL25HHj0EH/6Q7oBWovPo4iRRtFXd0RLsyCKdLgOd7S4=
X-Received: by 2002:aa7:d4d9:0:b0:560:be95:aa64 with SMTP id
 t25-20020aa7d4d9000000b00560be95aa64mr1784852edr.37.1708015152889; Thu, 15
 Feb 2024 08:39:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCnKC7YE8DV8eCi4zA5LtqdiL5So+ceNV63udDXmRJxeFFw@mail.gmail.com>
In-Reply-To: <CAOpGCnKC7YE8DV8eCi4zA5LtqdiL5So+ceNV63udDXmRJxeFFw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 16:39:01 +0000
Message-ID: <CAFEAcA-OXC-z+ZAvfkVer0ZRSOz-tcuZiZFKihYVSE2DTODELw@mail.gmail.com>
Subject: Re: Qemu network connectivity issue
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 15 Feb 2024 at 16:32, Faiq Ali Sayed <faiqueali.109@gmail.com> wrote:
>
> Hi my name is Faiq Ali Sayed
> Currently, I am trading to create a Qemu VM with the command below and getting an error and the terminal hangs after that
>
> Command:
>
> qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display none
> -device loader,file=QNX-IFS,addr=0x00100000,cpu-num=0
> -net nic,model=cadence_gem -net nic,model=cadence_gem -net nic,model=cadence_gem -net nic,model=cadence_gem,netdev=xzynq0 -netdev user,id=xzynq0,tftp=/tftpboot
> -nographic -global xlnx,zynqmp-boot.cpu-num=0 -global 'xlnx,zynqmp-boot.use-pmufw=true'
>
>
> Error:
> qemu-system-aarch64: warning: hub 0 is not connected to host network
>
> any help in this regard is highly appreciated.

That message is not an error; it is only a warning. It is telling
you that you have some ethernet devices which aren't connected
anywhere. That is, you have one NIC which you've connected to your
user netdev backend (using the netdev=xzynq0 suboption), but the
other three NICs are not connected to anything (as if you hadn't
plugged a network cable into the back of them). If you're OK
with those network devices not being connected, you can ignore
the warning.

The warning is not going to be related to the reason why you
see no output. That is almost certainly going to be because
your guest binary has crashed before it sent any output to
the serial port. To find out the exact details, you should
debug what your guest is doing, either with QEMU's gdb stub
or with some of the logging available via the '-d' option.

A good first check is "is this guest binary built to run on
the machine type I'm using" (in your case xlnx-zcu102).
You can't in general run a guest that was built for one Arm
machine on a model of a different machine.

thanks
-- PMM

