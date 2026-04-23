Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4520AFDEE55
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 23:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG3io-0003Rz-Qk; Thu, 23 Apr 2026 19:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG3in-0003RC-9U
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 19:44:37 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG3ik-0007Bk-FY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 19:44:37 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12c565dd3a7so10502244c88.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776987872; x=1777592672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PT/MiBm6K41jh+luxV+cKAOP03DvqX25ef3U/FQC4Fs=;
 b=bmoHcpmQJv0woRVTnUWisXFqbgk6KcFGx8oUMToDXZTQEISc+wqj4zx8PQf57Gi4oF
 li9MSlshu0phjSbZj8AwyV4xg8Es2N5/GpzqwIOpU+bWA9BOcLDNs40aLad03Js8xk75
 20k0vVm1xUBNfNGykcwzqynP3fgL9prqDeOqdRY0Q13zUJKkXNwJHWBjKusqBvBlAgc6
 MZ+RAWyZMcHn6+cu7q63s8g+NMVTu7Z62V7JsGG0ZY757yHXqNJe5fDO64DmiwDF+n/R
 juLrdf+87d6Bg7qQZmKWL9ocPKep5HzuyV2+uawcaEMX8OIfwJt5zplqggn1RahGJ1yk
 kUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776987872; x=1777592672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PT/MiBm6K41jh+luxV+cKAOP03DvqX25ef3U/FQC4Fs=;
 b=oGcvJ6+5der6yQ6xtMCtXCrWQ7qSfWxuFZrKbNPyIyP3JGg597BHuABGhzcltKzrry
 FQ2YrhFRiTdI02t3OssR3obhj7ODtvFnAjyhAO6PEIYgMBrEUCFXUMPe+Rmt/xwtIBov
 n36StwD3yhq9NSusFRUu0RtP3J0zbloPecXrnUAelwOwXRRZtBZfE5WTn8uee62NBhJF
 j6PRVuyx2ksTdA9dc9KyuMZm7NfZ5BTI8qRo1e/uVPbTNzZakLCG07Z+UKCsUC+nW6ce
 xoBvLxfOCxDTUqUrq0o3A6FFRWQX8pSFOQdLo/Yw+6HRYKwtCmKES3ecMUYO14muhz0/
 1AIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NJiYrQLpmvitwReqFeMogAgHXNOoE1MfWsu4/4k8za+nFNzNa2Ef9T6ZGcvcqwd8RnOlQVhhzbiJO@nongnu.org
X-Gm-Message-State: AOJu0Yy5AhJW1wQkOJXHb3Afy4leTWXEq/jZxzTq1N3IokHutgv6eix8
 N4/UGCS25XL1yQExI0mI9q1pcTrI0ZGzncomiveudqTqY3g5CJBoxUj2
X-Gm-Gg: AeBDieuD9vLkUc1I/XgLdednwzdrfPCnU1wZM1xu9VzJHoToYFPvErqXj7aZ1XEaVTj
 NN5bOMpMY3SBFO3fEgqN1PFWNxapUfHKqGNfGvPcSF6pVggp8MbwVI8Sq8vXbHSJ+k0clhCtmG1
 4d7AU5PN090twRpjYuBKj63uHcdx6UZcUnOA6mNQGU/xCc0jJRWk+ltoLgOAZ180CeHA5m7Ggt+
 r37+GPR6Q/EpWsFeYW7/eZ7fEybC/4EfXqvCY/eerNmffGSvJ0XH0yT+P6FCPXSodxL3DQDBsWX
 REUPLIn/CXWzhdLmexBxQTBMBp1XE8PWRNg0V5eAhYfrQ4dm3xgfaDhEcJw1MmHipCGfkaXPnjL
 AoTjweZYvPLQ574KHP2cj6+fOuBuVQMuuPS2kG5JPo4WI6tIv3ozW2G5XNAe0RyA6+OYhdLcqS8
 yUPjlTe4pJewzBfQnw10LFOa8pVG/An/NqsdthkaKaYp1BCYT9Ef+nudVopw89AbGBDhaPMsXK
X-Received: by 2002:a05:7022:eac8:b0:12c:2f8b:4c4d with SMTP id
 a92af1059eb24-12c73f7cbabmr17239478c88.15.1776987872200; 
 Thu, 23 Apr 2026 16:44:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:c4b9:45be:963d:f3a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c7b62fe87sm26531612c88.2.2026.04.23.16.44.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 16:44:31 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, agraf@csgraf.de,
 mohamed@unpredictable.fr
Subject: Re: [PATCH v4 2/3] accel/hvf: introduce map granule abstraction and
 IPA property
Date: Thu, 23 Apr 2026 20:44:26 -0300
Message-ID: <20260423234426.7782-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <87h5p1wnzw.fsf@draig.linaro.org>
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260317175744.32469-3-lucaaamaral@gmail.com>
 <87h5p1wnzw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

> There is a minor preference to use the glib functions here, g_strcmp0().

Will fix in v5, thanks.

Lucas

