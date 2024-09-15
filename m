Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B655C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 18:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sptxZ-0004Ow-AG; Sun, 15 Sep 2024 14:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sptxX-0004Mi-Jt
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 14:26:55 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sptxV-0004JG-M5
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 14:26:54 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-49be3d534ffso1168592137.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726424812; x=1727029612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x80fU4RdR5XBAyTsIZ2iQkE7C4bUUYccK+cv3QachVk=;
 b=MN/iTQju4uagVLkVOaQFJJHz2lwxOY5Iwy00Fkjh2K0SaGA9vIzjKTmLYyQctP0KCC
 C9llrmJm6uCeHGMYPIOoX1I3ODdtChNrbu0dFJ/67p/6jrYibc8tFcplvwYfRfV1feQV
 Hk/EP7qQHjFOdvO/pvQqjxT0GBrDkRqXzClAlEOXF8WbPD92QFDWISQEYMeW7eFQGxp1
 wBGDg2R150ZGzN1+UA5cvUBpbbBMG3q/K9p+DgKu+LY1SFD53b5cqRfxsKqv8YY9FWMd
 bW0u0qZd/3bVkzwAfsDGfsoFHzNv/m+W74g8+ZJHTAtIqunqjyuqrHkxNjdvyMDmTZ96
 enpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726424812; x=1727029612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x80fU4RdR5XBAyTsIZ2iQkE7C4bUUYccK+cv3QachVk=;
 b=FiD6PaSZv2w4Lt+kM1/+nc/QDX9KsGjdi8juorHugM17xxbp3XFFBqv58ZK6vpfy4e
 dNDGjnGD0vVevXztwVprZIAhaNyEWmqwdhY/Gr3Gwq89Aak+ajIqBjuWATB21wlwFhBE
 3+CwgOGbwcxOb2s7rcGvF++QAjK0lmjb0lWm9kLPLzZjf1c+g3NnmTDzJpAzrj7ys/gT
 +RnRkiMJljVMLPTh0QnZzCteV1ht9JLh3utrFEH08EG/jxazbSBrb/QIMzmEuIZ6MDZZ
 LpTM/ZLTpvDNBzWeqTD9iAHAC4dOYRiOw++1jEK3zByg1swehwwYJgMiFktXFDNt7vcf
 M6Bg==
X-Gm-Message-State: AOJu0YwNFKRjw9vDba4GjzBSAfASQvnvFecWkB6fd18zvgXVdg+rjuNl
 6Mvj5z01lb3Echy0uJF6oGuXxmGpnBNsfJxZMHrzIYVwg3uQIoln+4CJ+WPqyKsWMEoeICy1z20
 IP/PNgYV73scq7bD5mEuHbfNeocarNBUA
X-Google-Smtp-Source: AGHT+IFRpy6vG48e0Wz2M2+ZVG2OyrwE/9gsUeU34zZApcSgJlHkbVz8A/fD2WJzhTDTkEVT/RfnAYhDYU2W/ZNb9Uo=
X-Received: by 2002:a05:6102:dcc:b0:497:1b98:1f82 with SMTP id
 ada2fe7eead31-49d4145e745mr9671565137.6.1726424812232; Sun, 15 Sep 2024
 11:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
In-Reply-To: <20240905195735.16911-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Sep 2024 00:26:47 +0600
Message-ID: <CAFfO_h76PocPsyZhD-gKPoLQjeOaPc6cwsNU=u=APGbKOZG=aw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] AWS Nitro Enclave emulation support
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

ping

Requesting for review on this patch series. The first 3 patches have
been merged by Daniel but the rest need to be reviewed. Thanks!
patch URL: https://lore.kernel.org/qemu-devel/20240905195735.16911-1-dorjoychy111@gmail.com/T/#t

Regards,
Dorjoy

