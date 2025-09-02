Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97B8CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utO2G-0000AM-Kl; Tue, 02 Sep 2025 06:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utO25-0008O8-7e
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:14:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utO22-0006wP-NU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:14:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b88bff3ebso14435205e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808068; x=1757412868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I+zkM9Ju/EP//gMBk68Sz1tKucIEH4sA7POeVxOpI/0=;
 b=cYrBa+VKY6pyfG1qMUXQyPjatuPD1fnAQH9jmpvbf8ZKef51Poclww1I6bW7Ea0rKV
 Jx7yROAnpb+FOMZe3VQ84vqrXrPhu6Kr0bkXkvr+1bQoIjc+yo2BNgWkmIcSC268lqPA
 0fLrDmulvOaqXzCkUe8pWt7jDjMaKhTYHkWq8pCp1sbT+v75XR05SrOczNrGm+U5/esX
 6o+zEHFSSl2j582JCqUDqI7f2W5s9RhHP0yYiXl7irGOHieWSImPR4/2wqRNsaRRZj9G
 4yBJkjTydaxs2tAtoVFLVjwzclUw8RZzXGOstsN+SGx9TGkeM13Fq7eaPxotbRtPgbJB
 +HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808068; x=1757412868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I+zkM9Ju/EP//gMBk68Sz1tKucIEH4sA7POeVxOpI/0=;
 b=v7N9XEiLtzIigfXi+WClCVgt2tSstRheXhDC+1PyPbLxvW8VumHhUPDlDhfpwdtiuN
 OEdrkxirdZ+QF6ZXuAWdRJE/wiDISU7W0dORPWfGZocmN8gQwC/tQS0TiV39i6jJTCZF
 ixYuYTo2rzu7Ae/nKIOiO38H57cF0nOQH/nrzjc8/xAHo997gXt/M8Tn8FDHIMnjfNc7
 4niCMdoEx6UJQo7Wi9UIV4p6ePNROcla90WjYsRA0pBn5p+7XsK8hJK0ixlqA5xg/pIu
 g6ia0Y5EVKwKMrqdY5zCbkOgDaNIUcdYmdK9GE2SZCxCAVIS0FgWJ5ez11ndvqA2qfW0
 I3iw==
X-Gm-Message-State: AOJu0YwTWHRUeVb45qEnvBCZ8ErqJAp8mykwiBS6xs1il1kRKQXCLkUk
 crgljlJA8L3MfVr+yrfqZQUm7mxO2ad3oPmhq/+H4zhaKgfnGOYc8w10kPvZgfslU6TjmK4BZMy
 MtHK1
X-Gm-Gg: ASbGncvAnmrpjSqs5b8KlQlDnPgCMywXdf6xMlhiOj3IIauH8qrEzp8H1FAWHLfl1Hj
 vk3HcqTnVxL0A8X+velNDUOBLgW7hKTpaSbTVvbmA1xDqgBYVRuhSHJ7vuYgBo2W12JPCyEwQhv
 1YBGwHwc5F/BeWlV5e6ouFGUVwQzjqv8/gG8It+AAJFBoFtC72M7q9tiYHvcmlt0GW3klsYaBxu
 ff+UN5t+BWtXzDIlg4nhrt5ehJOAPeYBseTcRL15KePaG85z5cifg1Hh3Q920AG6Dyo/lUEdnM+
 ZZQTRs7VnQTNxZ5Q+mkdPmMjJEZSXSytLqhvXJpUxmdTdshh0i/V0gdR21/fY1tVLVf8c2/+LWn
 /2+PGrI8bh/TOvPzWKIjlmAmCC12TGxV6gyTBDtKnsPHFZNol5+/fP79OHEd0Hu2fxQ==
X-Google-Smtp-Source: AGHT+IGcEcqMGsF0yu4IJA62wHRvaxuAOywmlaV4pdMP2zIrI5tcI1unKkom5Ei/cBNyeoVzfMfUzQ==
X-Received: by 2002:a05:600c:3145:b0:45b:6b6e:ea37 with SMTP id
 5b1f17b1804b1-45b85570c73mr78121135e9.19.1756808067732; 
 Tue, 02 Sep 2025 03:14:27 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b73cf86f4sm249799525e9.6.2025.09.02.03.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:14:27 -0700 (PDT)
Message-ID: <e52b9ce4-eb2f-4460-9709-fef9689c4761@linaro.org>
Date: Tue, 2 Sep 2025 12:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/sd/sdcard: Deprecate support for spec v1.10
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
References: <20240627071040.36190-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627071040.36190-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 27/6/24 09:10, Philippe Mathieu-Daudé wrote:
> Deprecate SD spec v1.10, use v3.01 as new default.
> 
> Philippe Mathieu-Daudé (3):
>    hw/sd/sdcard: Deprecate support for spec v1.10
>    hw/sd/sdcard: Use spec v3.01 by default

The first 2 patches are already merged,

>    hw/sd/sdcard: Remove support for spec v1.10
queuing the last one.

