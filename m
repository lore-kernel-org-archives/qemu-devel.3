Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE5DCAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYuZ-0007t5-Dq; Tue, 16 Sep 2025 12:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyYuX-0007if-Q0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:52:10 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyYuV-00071Z-Mg
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:52:09 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d605c6501so39010157b3.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758041526; x=1758646326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kE3Dp7r6y3co3znzJOR2UuPFk7sf69gvRxsgeXKJ8r4=;
 b=hKNgBeB5SvXg0DtnAySfzZzUhP/9HHHFCPyavKarRmsa+VvIGOG2cECXisOvbTliO0
 g8d5sl46xoXje7GFJsUAjJG8T+h51+1C+jnrI6O4mgHl0031/HfeSli1nKjbxQ+ZYgdP
 d93ha/UrSwKtKACC627C3M16xR1Eha9RenhKJ6xx+5bKVUNV+X15JeKfl/bAdLRnNXk6
 5mrb5DTKnhVurPXeC9c8Pd00trOwQrI28h7rNbsCP4oueKUpKDnEM+EMcYG9w6/yFyHT
 7xz7Fc67hXrmO7OAwddpzrOBZLYSsm4uP3CFmpRnp6nG30UPQ9bZgf4h2nfVE8+vpZML
 cDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758041526; x=1758646326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kE3Dp7r6y3co3znzJOR2UuPFk7sf69gvRxsgeXKJ8r4=;
 b=OSb0LxgDmI3wqTjt1XkiP+3Tu536JTNGgOa6viSqSRan9EeeQdlwR5xMQJd8vrAdbP
 E4IayqXngZtFe+aYCsZa+o6Ox4e+PIjhrqnqrssqXZE9DnPzoBE4xGgeqKr4jCNwS9uc
 DvtUBhoDOeNcmPnzB3TCmMizCVN+xGdCNCN8jk88sH50yvUFLMNvNekmeIRTyYzuECyJ
 Efjla9ew/hgbbu3FLZ4jOUvokpN3dfuY8CuiolNiAsMHY7LovOC5ysw22JOzOpRzDf7c
 HJ9kPtUE3oIO1dqEakXjJW8Doq+DXm6CLNistJhiGWMybegXeKo3k91oRxrEdJb+kxdH
 P32Q==
X-Gm-Message-State: AOJu0Yz2p3dzZKiHSlCjcKa5GT80DlbCgMCfvusMvlQDK2R9WrcZcJKq
 1LcM/K5uBKwD9pg2OIIdUvd5UpfggmpLU/X8C/h2AH/MYc8LkQ94mbZ3/YufQX8RRYsHL4dTSMO
 I4ylGfMgjrKHRaFmTL78lWle+8cMFnxy1exbbjzyr+g==
X-Gm-Gg: ASbGnct61fN7x/6krdNnIV2EZltUmMGDrTaeBmWPQe7sS73d+mGPrSauHBnqkTO4QS8
 lXDIA9Khr69wybZ+eZWlE1f8xpwf+RGs4zZ9Elg4xOqm5aWit80pgooN6br8O8hEX0MS3es8rZj
 OrDnqMywFSIy9PP2OOuXWa9gZSfxV8h9eaOS0tU4pvrS7VMuHnqANWUdfNQ0g2Bn0jYDCIHi6Qi
 YfaId0/
X-Google-Smtp-Source: AGHT+IGd9+HcsgCHe3dYF7i7kTYLl3RuAUZcrggkmDp7qdcxevJeJ8oRx6fbxOGnpjY9ck92vdbtODqAeHO0bF+O5rw=
X-Received: by 2002:a05:690c:2781:b0:722:6791:c5b2 with SMTP id
 00721157ae682-73062d9fa25mr159387407b3.12.1758041525431; Tue, 16 Sep 2025
 09:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250909165726.3814465-1-berrange@redhat.com>
 <aMmTxNB2eq6hSS9o@redhat.com>
In-Reply-To: <aMmTxNB2eq6hSS9o@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 17:51:53 +0100
X-Gm-Features: AS18NWBqmTIVk5t2IYgpdj_zSP01wsBcwkCoWYKbplJm7geJKIomPmRf5Ona6Jo
Message-ID: <CAFEAcA_GYSjg62-9b57QWOgfOxVLLY7q-5XreCZafb=bs8Evow@mail.gmail.com>
Subject: Re: [PATCH <RFC> 00/15] Encode object type security status in code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
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

On Tue, 16 Sept 2025 at 17:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> Ping: anyone have thoughts on this idea of annotating security
> status of our code against QOM classes ?

I don't object to it, but I don't think we should
block making our security policy clearer about
coverage on instituting this kind of framework
and marking-up of code.

thanks
-- PMM

