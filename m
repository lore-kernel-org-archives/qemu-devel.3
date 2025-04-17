Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE3C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5PFc-0005BG-36; Thu, 17 Apr 2025 09:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1u5PFW-0005Ar-CI; Thu, 17 Apr 2025 09:25:50 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1u5PFU-0001kH-Gv; Thu, 17 Apr 2025 09:25:50 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2c6f27599abso177740fac.2; 
 Thu, 17 Apr 2025 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744896346; x=1745501146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TNoydAaQm6oikXDhvk8iRk4lbeTSWJO8cyaJecwLxRQ=;
 b=MbIQ0l1ConXeuNoQ32xZr26WSq1x+FaGdJCdv4uCosGq5Hw+stYEbxmdtLwhi4R1fZ
 bJkMN9AFvvcGiH1DTEHOCoKq3LzPhpb+LhDAJmcL3f2/9GRsRJDtkFpF650UbWYIiiwO
 X2WGG/8M4d3SzpfxdrkiRJHxWGcYaMFRHz9k7SSz8FGgQqqVYoRNDF9x34K9C8fTcKbS
 4FK0gkk20ZyrCi1lLX720qv0Skkb6MThbctx/+ZUj7Fxj0syoQtHPfmq7S/IjktF8pLO
 /XlmyO6zmtLw2x9AmqyvpNypDDjh+o9WRNVu1NWQfKF1uKt8sUaOegZgtZAhA3tbpCTI
 ZOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744896346; x=1745501146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNoydAaQm6oikXDhvk8iRk4lbeTSWJO8cyaJecwLxRQ=;
 b=Tyxr7vj7EErR4qe/ppfnoXK/m44gIPb9C2DQefsFJtYlD9fJAmKWJl3dT2yNwWZPjz
 vI5SeVMgGuUI1bsH0+AH89w5bRsadW8Ogp3K79tS0uU1JtLW4ShcO9stICZARKJ9JuO5
 jlDq+QVPUyZRvX9h9h9BN208xkha1FHoRfWDpE6otkTz8Ifgymrb0HbiIn/vN3kL72kL
 k/c2cyJfTENG0dGFrpNP089lBzu/btqhMfF5XqKA2RPOY+tudD8RRq1+yXTQUZmxkzPa
 PTVuwH6LFUtG3KMNy8Ifa5KPfNwzn0sP+TRItqwYMsnm+0isuzd5iX4BxIDPFlmXZXlG
 TGYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNdgHlNx4Bb6q4Qtgiz4StD34wjkXDY0zjTGceJbrEdtaEROJOFz2kFVB6IvqrBOMeXKZq2PACed+g@nongnu.org,
 AJvYcCV8jgQyXUeXC3zcyEX59q+ofLYzYr7vJxLkwOdnhjyrp7VvqWTo3RdSqYvzXveaaOJe0zecY8YdTP+w/Os=@nongnu.org
X-Gm-Message-State: AOJu0Yy82V2HhVKK9qNEAJjrgMwWsux9OkyYMXryIzJY1uwBc2O5tsyy
 MIz4j9l7Ys6tneekkZlKmSdVMwip7zyk2ZblwC8ykO5yfsxHgqzZ200efofW8Up6rkKa6rm93HM
 oFPxSsJBOamDg7j3al5i+2EcG3Ac=
X-Gm-Gg: ASbGncvQGObjn7s6+ui4Ag61qrkLZfhMRghmfEQzGcNeejsfWG+E7n0/gF88OAv9/fR
 QT7jX9AseRbHorCOEzmKSLjeS8I9NqHHXCzngtUdpk8ej1bNELHi+DG1KgdUZ+nYI6hoHvSVKHv
 v/KfORSGSGpHjN/evkyQsrhnkBods5ADYP6KQ9bPSa1uoKh6+TMI3A1t3h
X-Google-Smtp-Source: AGHT+IHba2S5ONUiYJQHskuFMY6jreqf536cS8fv5DM/oK/6seAXRwREu5KYiHaPegTQmUccu8HDmktWykf5l4K3axg=
X-Received: by 2002:a05:687c:200c:b0:2d4:d393:8e48 with SMTP id
 586e51a60fabf-2d4d39391cdmr3857678fac.6.1744896344049; Thu, 17 Apr 2025
 06:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250408185538.85538-1-philmd@linaro.org>
 <20250408185538.85538-2-philmd@linaro.org>
 <CAO8sHcnLO8L_iYhzaQ3UBvpm_NTPpKe-AyNijJkdf-X9zRo6GA@mail.gmail.com>
 <8cfd79b2-b3a7-4129-98f5-53e805e57c7e@tls.msk.ru>
In-Reply-To: <8cfd79b2-b3a7-4129-98f5-53e805e57c7e@tls.msk.ru>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 17 Apr 2025 15:25:31 +0200
X-Gm-Features: ATxdqUGpYgeRDlZnVwAFU70siooniYoeQD-_2T1liWQ8mX9iUYsAU1TTicRrMVE
Message-ID: <CAO8sHckx77bGBbzeLNL5c62eC0OdvWF_Yf88fZSiVvTu+F7qJQ@mail.gmail.com>
Subject: Re: [PULL 1/8] smbios: Fix buffer overrun when using path= option
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Valentin David <valentin.david@canonical.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Apologies, I was unsure whether I should expect a reply on the
original mail after the patch had been applied to stable or not.

Thanks for the confirmation,

Cheers,

Daan

On Thu, 17 Apr 2025 at 15:05, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 17.04.2025 13:11, Daan De Meyer wrote:
> > CC-ing qemu-stable again to hopefully get this backported to the
> > stable branches.
>
> Hmm.  I picked it up from the first time, see eg
> https://gitlab.com/qemu-project/qemu/-/commits/staging-9.2
> (in particular, commit d1960fafecbe1066).
>
> I'm curious, why do you think it has to be Cc'ed again?
>
> Thanks,
>
> /mjt

