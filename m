Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16290C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvgJ-0004Rp-Bw; Thu, 25 Jul 2024 06:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWvfp-0004ND-Nz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:26:15 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWvfl-0002Lr-4n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:26:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so42539566b.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721903167; x=1722507967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tkFauiTNmfLRoFHhvJu8WS0Mq9zQK2mIForGX6qfTrQ=;
 b=l2g4od4/h5rlhaua6PYxtiDtZ5ZX8yuvSG+H0I6aU9XWlc2KkDJ0fPFhWYEFC39EiJ
 FlQk5xhaXbcnV3OlB0e1Ubs3fvm4NXmyPgTXeRerSIcHeRo2ps3OI0GXymxquMQyQLlw
 ZPAGGuJCOm4BkMTBGXnMW1HdmBLfV/sMDXb+pkK29vYOdDAi+g5c/BeS8rUtlqm5bxms
 w6+NINCneah5eskgjM0OkDo/tmbvlxpcReqRKuzJPCgGguNNhsk3VDeAd5kubpQ2CVdN
 DqyeF3Vc0OwkNleyo45QSOOI3TjL/1u8U9t63bgr2OghQ+HdhjVlycIbD9KVJw+7DwjJ
 w2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721903167; x=1722507967;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tkFauiTNmfLRoFHhvJu8WS0Mq9zQK2mIForGX6qfTrQ=;
 b=dvHsFZRoqdfW8nteAyVjAg3y3rYr7/KWyeMJv0EB0MimnKKbuh9dV934uJ9REktwbT
 KTV0f8NaywlH+RTkktkX2mccqVBwoFukLclRBNPipnZfjcLDYV4NPjoTingBJ2vo9pe6
 w9tAa1J1o7o9CMfrniPUaQQG5gNwyoX7liDgupiGU5m0jAhG8dq6uYK4O28UfW/92KUk
 DJZcKZYuly5hNUDJ3OM2UyT9VucSz3TKjWlsGmTAedMQE9cOWAujyaf7vA5gMkkGC1s7
 nYoaqKFugSClAXH/XktOf6ncQemunhfDN76gPhpjOhDFFonPlsLr+E/KgPHpPwde9dOR
 g36Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMEGTYmALYG+oLnRF0ew9i/p1kL+ccyxYakwSj6vQScYwaFcVn0BsaAUfg7Fjg0bZNa26bDM0yNtnkOy6s0RvbM2Zdbw4=
X-Gm-Message-State: AOJu0YxncWIKQjNvXhpVQDPDj3ozZUzZx7clAB444O6S9+vkzoTeD1m5
 IFMeRNSbRs3yyQwisZXPzYDZRG8hgsj0W655nYm7bc460yfbDKvoVcUGJ8wsN7A=
X-Google-Smtp-Source: AGHT+IE1bi2pSVP6NhmsssD1Nt2D6oR86o9J0vIfuaTV4dmKpjUD/9FMUlynoBVH4NTj3r1kvnjXDA==
X-Received: by 2002:a17:907:7ea0:b0:a7a:9c1c:1890 with SMTP id
 a640c23a62f3a-a7ac5049d17mr179659166b.55.1721903167053; 
 Thu, 25 Jul 2024 03:26:07 -0700 (PDT)
Received: from meli-email.org (adsl-159.37.6.160.tellas.gr. [37.6.160.159])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4ae4dsm56931866b.136.2024.07.25.03.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 03:26:06 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:20:51 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud =?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 0/2] gitlab: expose installed package info in build logs
User-Agent: meli 0.8.6
References: <20240724095505.33544-1-berrange@redhat.com>
 <h6b6l.5yloo5aflex@linaro.org>
 <e60c7b68-a3b2-4144-aebd-1110f40192e2@redhat.com>
In-Reply-To: <e60c7b68-a3b2-4144-aebd-1110f40192e2@redhat.com>
Message-ID: <h6czh.1irp2u56t07@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Thu, 25 Jul 2024 12:56, Thomas Huth <thuth@redhat.com> wrote:
>On 25/07/2024 11.42, Manos Pitsidianakis wrote:
>> Hello Daniel,
>> 
>> On Wed, 24 Jul 2024 12:55, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>>> Many times we see a build job start failing, we wonder if the installed
>>> packages have changed since the last passing build. We can rarely
>>> diagnose this, however, since we only have the new container image, not
>>> the old one.
>>>
>> 
>> APT allows you to specify to pin package versions when installing; wouldn't 
>> that help ensure our tests are deterministic?
>
>Even if tests would be more deterministic that way, I also don't think 
>that's what we want: We would test with backlevel packages that users are 
>not using (since they'll normally use the latest version of a package from a 
>certain version of a distro). So in our CI, we would not be able to 
>reproduce the issues that the users are seeing on their systems.
>

Definitely, but the current testing makes it harder to discern the lines 
between QEMU regression and QEMU not working with latest updates. If we 
had e.g. a pinned job and a "latest" job disagreeing we'd know the 
cause. Of course that means extra CI minutes, maintainer upkeep etc etc, 
I know, but this was my reasoning, I don't dismiss testing for what 
users experience. :)

Manos

