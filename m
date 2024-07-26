Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD7DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHDs-00008q-OS; Fri, 26 Jul 2024 05:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sXHDp-00007L-MS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:26:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sXHDo-0001oL-4s
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:26:45 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso1781087a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721986002; x=1722590802; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OSEcz2ACliVVbGmXCVjjvqPJV5rpwspX1Czk+L+rQHg=;
 b=IkD5z+w9oczFb2Mt8lowhZTEVvHvMJZgxsF4xZRb+Ptl31wyYpNYI1qEZJAfBtmNCF
 SPdaQwj5JJT4T/Y+M3hz8LJ5W98cGSUw9hj0MSjFYQRYL+GRE+55SqrCN0Naxona3gU/
 kOGqM44+j+muk+ASs67ygWEQeLjLG9s3rqnc9nxY8nhkTtvmuxxS7yXDNl3gpKdqqlXR
 WYr0W38NjUzel1MgegedP13XY30joKrwCChk7JbfaNCVAQA+25ODMQzmtOvbFX/1GDPF
 pvfK4nUtX2beI/qqDhdquKleOnYBnFO+hPePmXEmoOycvhXq+O9YasL+obTr1KIeMZ3L
 JMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721986002; x=1722590802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OSEcz2ACliVVbGmXCVjjvqPJV5rpwspX1Czk+L+rQHg=;
 b=Yet+WI17ws+K9Ipzod6exuv6ShiwtN2DSnszNhU6N4dvGadXPPyuv7V5gu++yc7Ga4
 6hEYJlUw806FlwjAep0ecufxdjRc2NhTu3R8t98qbHfAQjbzkV/4RodSsOni2ulNn34E
 SNbTWX+tTGcIjrqDcDyyJ/NePGGtbZr40nLrd3EH02hBkQXaAAKakahItNt9gDMVlEZw
 R/8hpLzwvv4rotoxCcbtg42KVoFT/P3p28R89ZPb8LqgP9gSd3jO9QHzIbcsWpHcosPQ
 YsT6sAkUoClvGDHHXLmGLqvhhdNnk0PqQWSSz6R/QwY6zcrs9S53i1LwS11TvjTDk+q2
 7KRA==
X-Gm-Message-State: AOJu0YwkPeCNUN+Tl0sIx44DMAGIA3/FiObQSz/mcp30uWWg7DPji1pk
 FakElLR+szqy7a0jdTXMZw3XogkpcXlgA7zlLh7Gb3RtfXmY90vjuC7huHAzhbCvon1DyTZS9vq
 4cWdVJ65GBnYKAvaUE9icvnUiTPNcF0TM0a5Cww==
X-Google-Smtp-Source: AGHT+IHuVf7nVy5a5ChOj6ccypM6QfZbxoScLrS6rldKaa9f+29wSvistCwMr0XgfDjMsM2V0DY5mJfNhCQaDUWwooY=
X-Received: by 2002:a05:6402:5216:b0:5a2:8c11:7e05 with SMTP id
 4fb4d7f45d1cf-5ac2a2da089mr4264917a12.6.1721986001519; Fri, 26 Jul 2024
 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
 <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
 <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
 <h7zb4.aog50x8tfxkp@linaro.org>
 <CABgObfbJjcwXcJ-=c7yfXQX=xLnqqVsvDqibrFgiLPm4C_uC6Q@mail.gmail.com>
In-Reply-To: <CABgObfbJjcwXcJ-=c7yfXQX=xLnqqVsvDqibrFgiLPm4C_uC6Q@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 26 Jul 2024 12:26:25 +0300
Message-ID: <CAAjaMXatq0jGrght=Fc-7TpZvuGzirhWyKsAsCRq1BW_U_CW=g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 26 Jul 2024 at 11:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> As I said, I don't see the point in discussing this more, and I'm not
> going to unless you provide a clear pointer to documentation that
> states the opposite.

Same here.

