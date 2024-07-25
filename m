Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D90C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 09:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWv4A-0007Bu-Ku; Thu, 25 Jul 2024 05:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWv48-0007Aj-PF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:47:16 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWv46-0007Hu-Uu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:47:16 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f01afa11cso852027e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721900832; x=1722505632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2qA/lEZPmDH2u8I7CwkCFaeMjs3z8FEvI3/VCfHrRSY=;
 b=A/6MJeEFziqJ5YatOYwac1kSS3fYO+XF2eEURnzzBaWVF6qA7XyC1roJeJlQ8g/6RN
 GTDLuWSjmsRqrInqyNUez/qClzW5RZYckD38bPAnY28D38qz6zBMqje9p5iVMEtwnB25
 eXH0h71LAo5Y/PMdXiDUIAKmRXRbmZ22+Aq/LPYdMcbeu1+veXKtnceUOOyq438YDLWe
 Q0fxCYxFs6eRl9NkuCrbpmE+/4+F021nRu9cgiHnsBPnJAU97xLGlyOIWf9VmgG4f48w
 oHCUdtFlwwztfVFYLkxXVpukz5hu48E4t6qUbhhpxWniqSnbNsuMegyizzpNEYflNWGN
 nwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721900832; x=1722505632;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qA/lEZPmDH2u8I7CwkCFaeMjs3z8FEvI3/VCfHrRSY=;
 b=hNPGSZH0ekcJLLQMYnefgQ+aC4GHjd3lKyfAbZOXdzHqXby51Y7asd+G79LrS3AAVS
 hdAAN/jF8rL/7S5SgZhJowekmn79jKwUlOQnvIj/nOTLa7x8mUtJu+LC8rM0M7tLpYK0
 pUT+kKXhCiWIXwXbmbfExYSLjI+KVUQHcwRYR1sneBdVuSKn+JrsmOlUZccISYnl6GF6
 tSws7wa6n8VnAd7CqkE6upSApb5jCbNi4OK5vNRVcqK5ls4kOyuGXkv+NvUn2wqqotpj
 NCU6dog8N+1DuFMp6Mavxs0rG64KY+B3MZTRkSszpAK7xYye3WaLl7bqXWGooT7u9J//
 tJqw==
X-Gm-Message-State: AOJu0YzeN1aeoP1YoV1ahzUUZ/GsJvDhSotGev2TLw1Kx2mxVvdJb+QO
 6zLsMcljzc+ihYtpjwdF5qOOLANXXInmCMN2wVxklHULl/Dr3ZXE59B6U+VWQLjrJfacTuI28v6
 A33o=
X-Google-Smtp-Source: AGHT+IFqoWES6R9/Rhl423FWCvM2LpcRoAQ2zBLcrGzhogjDP8cewIY4XBy7ot8H2ojZiR7xgB85Hw==
X-Received: by 2002:a05:6512:3e15:b0:52e:7125:c70a with SMTP id
 2adb3069b0e04-52fd3f7e820mr1647894e87.47.1721900831687; 
 Thu, 25 Jul 2024 02:47:11 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63593a8esm627797a12.30.2024.07.25.02.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 02:47:11 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:42:18 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Subject: Re: [PATCH 0/2] gitlab: expose installed package info in build logs
User-Agent: meli 0.8.6
References: <20240724095505.33544-1-berrange@redhat.com>
In-Reply-To: <20240724095505.33544-1-berrange@redhat.com>
Message-ID: <h6b6l.5yloo5aflex@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x134.google.com
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

Hello Daniel,

On Wed, 24 Jul 2024 12:55, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>Many times we see a build job start failing, we wonder if the installed
>packages have changed since the last passing build. We can rarely
>diagnose this, however, since we only have the new container image, not
>the old one.
>

APT allows you to specify to pin package versions when installing; 
wouldn't that help ensure our tests are deterministic?

Furthermore, a gitlab cron job pipeline can be set up to run every e.g. 
few months and inform of any updates so that we can manually bump them.

Manos


>The lcitool generated containers create a /packages.txt file whose
>content is intended to be output in the build phase, so record the
>packages associated with the build.
>
>This adds packages.txt to the manually written containers, and modifies
>the build jobs to display this content. This will improve our future
>debuggability of CI problems.
>
>Daniel P. Berrangé (2):
>  gitlab: record installed packages in /packages.txt in containers
>  gitlab: display /packages.txt in build jobs
>
> .gitlab-ci.d/buildtest-template.yml                      | 1 +
> .gitlab-ci.d/crossbuild-template.yml                     | 2 ++
> tests/docker/dockerfiles/debian-all-test-cross.docker    | 3 ++-
> tests/docker/dockerfiles/debian-hexagon-cross.docker     | 3 ++-
> tests/docker/dockerfiles/debian-legacy-test-cross.docker | 3 ++-
> tests/docker/dockerfiles/debian-loongarch-cross.docker   | 3 ++-
> tests/docker/dockerfiles/debian-tricore-cross.docker     | 3 ++-
> tests/docker/dockerfiles/debian-xtensa-cross.docker      | 3 ++-
> 8 files changed, 15 insertions(+), 6 deletions(-)
>
>-- 
>2.45.2
>
>

