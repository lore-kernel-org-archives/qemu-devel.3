Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDE606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mgH48vLY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU73z-0003Fs-5P; Thu, 19 Nov 2026 13:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU73y-0003Fj-3K
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:40:50 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU73w-0002sc-Ig
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:40:49 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b4d543b6b6so208687b3.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:40:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795113647; cv=none;
 d=google.com; s=arc-20260327;
 b=R0odcmC+E0kJMMFApa+ulFnNwxXonf6vExskj2aP26wTFlgzpegd+jMfRKVoMziv0h
 /ndASUTOYSULDnZQUqsEq7JSRiB23p+Z+CHxo1lZHfj6JEk00qPwGlC++7cqwa4sckb3
 sFpYJeF0nrn7Nq9N5H++7fz+T+StEeYunAs+dmAOvvy69V8+c9JwraPV+cen84pUwweV
 uhsBT5O2gF4MxteIPF7RRyZVjd33X6gkrPQsJCAAU6zeMJLqxQl7V3hDVncpHNb++ur3
 WoDIT2QbK+6HMzdIVsSKANDJItRkicIv6RJq70XwjBuHGeA+WaBeb+VlQVAb9+xkvmfY
 rJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
 fh=7PEWrgUoPHQZPJvXVWqRedtGRdJuCQUNch8SP6Cgpy0=;
 b=h4Asytip1u+iEcBQ48eAdz5Qb9P0ZAF0D8N9cwHWwzsTTUCmmaXpPoVOS6smAXyjNg
 7qp46loa7VLXqYyYGoVk4pxItybMOvMR8UiU3XTGvuPVdTY0GbpZGmpcpM9Sy5Jofi1w
 aTJC3EsL6ScvUwU8bSIG4Hm/EMSa53lLHuNFnYiDwK80fKYC9S2rE8iRPnVrHrlWUhr+
 c8VR4LAbkoKPcp+Cqok9SpSWN486BA8HeGOwTQp1hd5L+mII0+DSDp3ArPNeOtz6QdnR
 k4wXub+YJzhBtA863q3Kvi276kSnKb91kreRWa3Ng04OicE5gOclNF/CmFckPUkkSvPi
 I9Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795113647; x=1795718447; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
 b=mgH48vLYfgElozllkeWt/4xQT/GBo6B6iqwLOwjTMTsFyeLpF5BQ5cTgVr5BwcH/Iq
 kbLOFPC14xg620ChZrGO7BXGK6eL+BTOAVuWw0V8rI7x27vQoVS6YyZnwrM1ufv1e8Xa
 yxJOy1mArxodmX17aSzaT5xvUT+zFxH4VIDCaBwlRpm/p5XQ98CyfjdguXpiB1S7X3EJ
 lPA4sWqi9mYhzT6V7w9T6WSNdn6lWIkYzmHjI1ruk/o++HIWNcTTptsHbU2ctXsN0jxF
 i485KAsZWjg38Yp1LfrpHCnP94lOhrc07tvB6rX/BBEPp9I6OZLkeeOacnZi2wIc+det
 neZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113647; x=1795718447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VUKmU6ux5qe2cB1QI0hVfimzBmhReRvzt/J4PcrvDws=;
 b=cnwtL576ZNBfBWaC2UYe2nW61tM39W6aEyhtR3jFmtDjfUk4291mBI6O6hnUaR6f+p
 Dz1SbjYE/KVTM95CWA97Knfed7NkntC7+OYTA6KpmL4kzCY8V0qUlKGRBN/JNvHKXBjf
 GAKoCVxcms3l3VeyXwDUfMhm/NcTy2xwGyziZ+Cl5qM6ITUExUqqH1XRtXjDl+8h7w7L
 Dfv19fbJVfPs3qFtYyCrUxQMDmTzPf4ZtoF7PgepBm0QqYSPtNcaF+w51sgjIEqjfLES
 vzzIeEDEf6iu3B1NCn8/HcHtJ6IT++VirO8LFnbTlhWTJo/UWhf3dAK6+ctTkhr5zw6+
 JORA==
X-Gm-Message-State: APuU4Z+wAu2jCydNosPPmSomAzL08VmS9DtgGObqurkDG8+Wxr7efNq/
 9jaOp7YiZRImFDKAUYPwakS4SlqjR0j/pwtIZhLeJpU+CankAWIwCk1BmzSjCGz5l0785/TsSm9
 XyoniFL5VNH0a/A3dWheQYaHcrJF7TQVMenAwSjRX7g==
X-Gm-Gg: AZFdTZfOTQ1RG+81eW88rgo/YGIp2sRTD5Fwg+PIJ2q/QgTU1CwMcx4q/QePxzycN9x
 8+MAflDr6qXW/eqPWtBqlgKKQCtCUVNyhKEvDJsp7S8KEWGgjzHV2BN8Az644Rnv4iKOv9WZrrz
 kn5TjIo3byyiM/EkEWWYYs56jSm5qy0bAZ1I8j6NsH3+Zh2ui8xByyzhVl69Xa60/tYm5SFD8T6
 6y6Oy0YmeAl4sh3ZO802UJv0g2C7OOQJbNM8C2RrsrDSQHwQG7AwTH4fH3Oq2mnLuyVpHhfkzyE
 ++3f9AuFlDISIBkqWT7Ywgmlluae2H+EMJ4UNRqjR6ldG2IrFW0TGxP+5HAXzL4e0uqkdx+9g7N
 rOqKFpXQf+AuHJF6yolXQTBgFjTGOjjJIPQLWL1l+EasRM7MXvRuQ0Ix7KHlgh7ay2tyJvz9/9b
 qbjD2ASccxrTH9CZ1SDugk
X-Received: by 2002:a05:690c:dd3:b0:8b3:8d8:e997 with SMTP id
 00721157ae682-8b5204e2330mr2924437b3.81.1795113647105; Thu, 19 Nov 2026
 10:40:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119180859.1044425-1-jsnow@redhat.com>
In-Reply-To: <20261119180859.1044425-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 18:40:35 +0000
X-Gm-Features: AclHuK-RqLZ0_vbXu1GNXtzHg8OBsUVF1GTw2kG-sw8IhGr_ntzvM6dj-NIZxYw
Message-ID: <CAFEAcA8JRxANnfUcUhy7qoKaoCY0e9qJk4UKtoC7FVx3RD_OJw@mail.gmail.com>
Subject: Re: [PATCH] i386/cpu: mark CPU properties as const
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 18:09, John Snow <jsnow@redhat.com> wrote:
>
> Currently, these large property tables are loaded in the read-write
> `.data` segment; by marking them as const they can be loaded as part
> of `.rodata` instead, where these tables can be shared between multiple
> instances of QEMU as RssFile memory instead of RssAnon memory.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  target/i386/cpu-internal.h |  2 +-
>  target/i386/cpu-system.c   |  2 +-
>  target/i386/cpu.c          | 30 +++++++++++++++---------------
>  target/i386/kvm/tdx.c      |  2 +-
>  4 files changed, 18 insertions(+), 18 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

