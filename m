Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FEED78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7FL-0005S1-Oi; Mon, 02 Dec 2024 09:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7FJ-0005Q6-C7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:17:53 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7FH-0007NR-Rl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:17:53 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so5029073a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733149070; x=1733753870; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ab/ukojHRMpJCWIzAnuqfhVQoD6vuFxrDWMQonQN3q8=;
 b=bL+4C2ZRti8XR5aPvdUwXvlHUkNWpGw4EwzGuSrFugJ+rp4mqQhN9kv1LiIuJL+Sfv
 hdxYVwvI+vlav/W6//ZPsX/hL3ZdFgSiEz0RMgpjR7banFFwNHD1LngfM1ul9dbQeCTG
 gzQVMTXzoDpECXSCliWbqB8G6YQcE8u+gfHekbOMXnfKuBER208AMih8azGoziE5Wypj
 zypjoBcqVud2lCCXk4OJlApgT7L1r1UO1hK+AEWV72T2LccNVxLM1scAX4j49T69LytZ
 vFx/zI8vTh57n+bnSLzgp4xOt9cLyr83hnA5PT1kaSshbP4MiNYpJv8bcEmEQViwLodw
 2UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733149070; x=1733753870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ab/ukojHRMpJCWIzAnuqfhVQoD6vuFxrDWMQonQN3q8=;
 b=otOQv+yPLV8r+Hwp+kuDcJuZdMS2uLJmGj7cKd3VR7+CEiVtxO2dhnZGEPIlLSSUl6
 gV+oMMfiP9WC6Cl7n1gvkQRaI2s5flCjC61jyIC0sZvFUTHjbMp61c7r/BJb/ekIYU2J
 UomZn/o5a0IfEQa+hjc65sJ6GTRE6rOe/0XuwZcbVypz6y49hgulyPDtYHPC8QNZLNrm
 niC5U6iVuPEOqEMSnNEnYwu5pdND80sF8BA/o/bkPwFe3Whetu43aGxrDg6k8g1mtJ5e
 nKDHX2kTI3svwC+A+y9EDf67yu4IdRGpC75htiCs6tcNESjabu2fr4IiJP5Yp0vg/xyE
 3Gcg==
X-Gm-Message-State: AOJu0Yx2vj2qk1xDBxF+cLqCOtgJ5TSVpeCU7FQN8gw2bgWJS1pIsufJ
 bTYoTw62FsPBE2Nylh9zbZHckMWp9kR2w7OQ3zfSdtGrDSgDPrT77LnkRG4rXs8zYbBNbvMEf0j
 seJOVIU5STh3TSsj2TshVcnbmZHjJ15hyyECU/A==
X-Gm-Gg: ASbGnct2/YCdaLNqgUvsV9zqp58uNvdZ1kudhHEWKWbHvbDIuRGKKreScAJ93WQkniO
 f9xIcWreRa4v6+cPA0y4lmLKf4ZmG5KF/
X-Google-Smtp-Source: AGHT+IFkc9W87vaBpKr7rv5tMicoWyUnLMFP52shgQuW0YQropBf46c1BUZ/fk8gyOCJ+1vsSnwGREU5YriBTMGfs1U=
X-Received: by 2002:a05:6402:3481:b0:5cf:cf81:c39d with SMTP id
 4fb4d7f45d1cf-5d080c97f04mr19390729a12.21.1733149070049; Mon, 02 Dec 2024
 06:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
 <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
 <1499e05e-acf6-4e4f-8929-e8bec5b92fac@igel.co.jp>
 <CAFEAcA85NOxbmzpCT-5jv5uvcFH2WU5zm+fRTAK-VVG6LQRLbQ@mail.gmail.com>
 <ce5fc614-a54c-4003-b27f-6f08e56dbf08@igel.co.jp>
In-Reply-To: <ce5fc614-a54c-4003-b27f-6f08e56dbf08@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 14:17:39 +0000
Message-ID: <CAFEAcA_d7CUqJH1aJfOsBhmA4yZQh61Mw74NDJkJciZoeC5WNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk, 
 foss@defmacro.it, qemu-block@nongnu.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, farosas@suse.de, 
 lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 29 Nov 2024 at 03:33, Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
> OK, thanks! I got understand. I thought MemoryRegionOps had to be
> 'static const' .
> I will try to improve code so that it does not require the use of
> memaccess-testdev.h.inc .

Great. The other thing I thought of this weekend is that
we should document the behaviour in docs/devel/memory.rst.
We could have a new section there that describes how the
core memory code synthesizes accesses that are permitted
by the .valid settings but not handled by the .impl
settings. That way device model authors can know what
happens without having to read the source code.

thanks
-- PMM

