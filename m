Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C482EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snezC-0004NF-Jd; Mon, 09 Sep 2024 10:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snez5-0004MQ-Ca
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:03:15 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snez2-0001fs-Ni
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:03:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso269903666b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725890589; x=1726495389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oUWHWjeE49bASqtMhhBxOkeGk5kL72q7nBCqqH563I4=;
 b=tyatIVj4FV0U4PlapNBCfJdUuCFdgpQKmXlV9+gIrl3F/9D89k4W0EUWxrAgcnrNeW
 PN+gECzXBfYUoVkbtCbSRCOKZCR0bqhoG9fHF5x3RSq1Izwx+RINJBNxQlBqfPRMwvGS
 nCiPJGW8MtEl4SKfqbEPes54Qa8YjwSbShCZsBDSZucaK5rLL+k8IJrx4V+McCBP6Z9G
 XKkvzgyQ5nlfd+hDoJM92kq5nTB77EjjEKYhrn/kmJYrzdOoRa+uMN0PUkuEcc0Frb3k
 yLpcW5/E0OkG55EShg4KOxFEMdMAC0JM670oSOevnj1rOYm62OaVyLf2841zNg+rR2TJ
 yvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725890589; x=1726495389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUWHWjeE49bASqtMhhBxOkeGk5kL72q7nBCqqH563I4=;
 b=VPbGXLTScWHRWVXDLToH9f994AZNymGRtjmESfKALf//tVy1PHIrgLoIOnYoGJjYXV
 QwX7mkONkNWN2VZAi5AE4GQgSmDmemNKnga6Ntbl+6sF5F9n3U0Ecgt9pQpwn3f6vtwP
 T8BnVf3ckYc/UvVDeBW3CXQaWVEoBUDI9eWC8dfH9auHiahOU+yY1AY3sQs912wVdqxs
 9A4JyfqKnkndsLE0llqVy4KS9myqOGNpByxIRdq/zJH1ErzXiOqSSlN/zl4xa7AKwqcV
 cKZXsJycHxKk9oSKAf/UMzdbR/XyhkcIVrHYFUpOmgVGjG9IPOICJmJNWbNT1vGYAPXL
 8syg==
X-Gm-Message-State: AOJu0Yz2QNS1tRHJTHRNGExk3+lKYCNsQ3hI4oPHovtxAJq9Vb/0/w7S
 W08grTYse84Omx9bilx2Elx01MPR+rkHbekB5RRGcZZcsRoUo1MSst9f9oT0ourAM04asj4xSRE
 eSuz9JuVEZvLcMgkpJ+rEQfRLbT+PPfhujIrm3w==
X-Google-Smtp-Source: AGHT+IHJNxB7cKGWfVDUKj75TOe08Hp5p25oywmEgAsJfBpZfzyyVLvLFQPyb/+w3TqQExwkiEGfWYzlbEQWAuPRxGk=
X-Received: by 2002:a17:907:60c8:b0:a8a:822e:44c6 with SMTP id
 a640c23a62f3a-a8d1bf75d39mr987771666b.4.1725890588862; Mon, 09 Sep 2024
 07:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
In-Reply-To: <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 15:02:57 +0100
Message-ID: <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
>
> Despite the fact that the responsive CPU throttle is enabled,
> the dirty sync count may not always increase because this is
> an optimization that might not happen in any situation.
>
> This test case just making sure it doesn't interfere with any
> current functionality.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

tests/qtest/migration-test already runs 75 different
subtests, takes up a massive chunk of our "make check"
time, and is very commonly a "times out" test on some
of our CI jobs. It runs on five different guest CPU
architectures, each one of which takes between 2 and
5 minutes to complete the full migration-test.

Do we really need to make it even bigger?

thanks
-- PMM

