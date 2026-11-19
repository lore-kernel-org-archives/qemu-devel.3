Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15198606A334
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pd/2JQh/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4D7-0001Wr-0o; Thu, 19 Nov 2026 10:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU4D3-0001WL-0U
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:38:01 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU4D1-0002ey-43
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:38:00 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67dabd38cdfso2744527d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 07:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795102676; cv=none;
 d=google.com; s=arc-20260327;
 b=O1oqscKqjoyW9WH324wqSwIw2pk1/4kxyw8VFREpGOpjFb2WRF4Y2d3DWQLrz//uLV
 fOrMDBzHByLpJ3NVz4xchZlOL0YpOWl8noSYS0N3lX3DWU/lCNy/Ldy0hfQSKx7GGyC5
 /YpJt55cl23RpCZccRwvMaeqLLyH5zKVuUZfW+9CItnSvsCowY8LeWGhKwOVZr2ZyK2+
 J+JYg2j0B6QsmpG/TAqTqNfjHokojeXnDdhLCZLxo0QVT2ysBLh9kgARr/BaktUJFSDC
 qN62EaArqvesVVkhhJOkVkNMAf0+j2A5+/8bF92umz03wBxa/xGM+oNe/de1W1k8Ycmq
 rwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=hB6wcV5xDt+bi5Vmfu25dILq/UcsVJCpdEOU0sdJCm4=;
 fh=GN5AHh3evSuopnEiOJY8U6VCEVhyj/EH2tLFqAgs800=;
 b=rGSVCH/GN0mV19ibhh9mlrUU5mY3fuYQp80eEOASjWpwhYP8c3MRzDlEHKiygUIQpi
 3Wfko4x5lE+6PfKLx+/ZhlbCaIyygBGFjexSYS4xUFK6Fg1Jb/J0pPe8syu9aK/pRHr1
 AYJWthHKyFmG38lCn82lUCVT1hlE77kv2a2P7PLM5x/lxmtVvziTeBDCchFz8omrklMm
 4saCP4R4NW7VxhLj+YFxTs+30PzCmr1nKe2QcGPn8k6UQs+MeCntFATiZVJtehHQiNeQ
 /v3YySGjw/ACws7sY4Y8rLrA1jxW9+fYxay7nUTw9eyZswmPnIhyaDOKWxhyQvMnvLeI
 RkKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795102676; x=1795707476; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hB6wcV5xDt+bi5Vmfu25dILq/UcsVJCpdEOU0sdJCm4=;
 b=pd/2JQh/YFdZygcI7HDP5KY2bvKvVFO0ZW2X864iEE96hQ/iDTJd7q/ZBowJetV8fl
 uQ/QsiKQwkl/7BHpuuYSGBdieZvotSL+qQwMKnR1y7NTCYROXBIYj7GvAWReSRxymC+q
 Sequ+4lL55tm0jW6yjzNBlYRMo2755RSAzg/IklM5gcwNqDuAEpGJZl9PoVFMdlXeCLm
 FEGIa3QqUg3+fLn6X4XagIXZrWtO+b4oOAUZVLpxHkDdE/dI/9u8YecsBu3ui3lV016l
 SSVFz6ClVoy3OfT24VPy5hUAwon0m0ho0ckmgFFADunEPkDbmeiSoedgLfy5mUFKzMSD
 wKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795102676; x=1795707476;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hB6wcV5xDt+bi5Vmfu25dILq/UcsVJCpdEOU0sdJCm4=;
 b=d22+zQkJY9zsrO7yF8xTFrhdVlo/BNrH92wzmtu8Kl5QGzQ/L5YrLhEkwuAeC0xUnD
 M5Pj/zkj7tV2YC5xDaNjYSS13wKYs/S3X8GXhYOylxCPkGdHWREdZ4IJQaA1gxboo5k8
 0xSUlweiTHMhXR8Bcl7AjB0ZldFZc2ivxFQ+LxXwluGTi35QmnPJnVJ/zChT58RONxk4
 ODom3EEXaU11OF7zr0sDJZmGqYYCW6Gq4I811KlBS6SnoAnfNJxvLrk9qkuEkFaFt8HN
 N2vdR0Zkly43EmjVXCrikipOyDcL2PyoSq5humntkknA67GQi1jaiTLbJlaRCiG5c5EU
 jrdg==
X-Gm-Message-State: APuU4Z86kOoYr1IC7PE16AxEC75BvVk9PBXxlVM+chtiq5pQp8Ues2Tj
 YSuvIfF6fXnBXTxozHqwaFW7aBpnrD8+Sv0BoWaaWo9xjMvD0jUOEHXaOeYuzyTOKl4AChuj8qN
 4hlmlNFzdQ28AOFpZxTd9tfDu1aQoJOTflafkwn00hmLBsoTMzQYqbJVGng==
X-Gm-Gg: AZFdTZcNgfDBNKf1EXFIiy4jmEUZpilR8IzQ5hGnpYXrAg/gueaxcE8alVPlkP0gI9O
 fQCjvOHqRB4u7Zl2/oGgw+en+CnKAbYHVlV4H+ttfOPYxfbDtrSre5+lkOyzKtE9t7m5v3o9IoH
 gYF1efmelv+46KQ0SUN2Y7as+Ro6oJDVm4SZ3bdx+neDZSWfwEz+uiygRn6TFiZZcRF6F6uQvX0
 wMaNMNzMBhoCV0kuofzW1Q+d4Oq22flixPhkld49xq+WsrBoPjbtndYvphhR8DwQq9eKS9ZOFWY
 yFM2RwfXbzQ6PJkLbZwhvG2t5USeULEmTZ9xZcWHSvN8Tow1UxGGbk4AzaZjGUT9jRUaSodk0Ea
 6TWHbP4a/vAL4jhlftAKuFAGPLc3RHaGcKC41N83iEOdk/GXuS4e4kqAa2o1JMVNSa1cX4gmW9o
 6pTP8cuJY/kx04l0d6Nywo
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67dd3fdee8amr2800533d50.55.1795102675672; Thu, 19 Nov 2026
 07:37:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 15:37:43 +0000
X-Gm-Features: AclHuK9KNhr3Pa2-8TJmurWjJ3KnF4XXAe92p0vyCrn8UdSRfeDiYI9VfPZiUFA
Message-ID: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
Subject: VMSTATE_VALIDATE failures on outbound migration
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently if a test function used by a VMSTATE_VALIDATE() macro
fails during an attempted outbound migration, QEMU will die with
an assertion failure. As an example of this, as of git commit
08c9bbb825148dec you can provoke one with the microbit machine type:

$  (sleep 1; echo 'migrate "exec:cat >/dev/null"'; sleep 3; echo quit)
| ./build/arm/qemu-system-arm -M microbit -display none -monitor stdio
-S
QEMU 11.1.91 monitor - type 'help' for more information
(qemu) migrate "exec:cat >/dev/null"
qemu-system-arm: Output state validation failed: cpu/pmsav7/rgnr is valid
qemu-system-arm: ../../migration/vmstate.c:817: vmstate_save_vmsd_v:
Assertion `!(field->flags & VMS_MUST_EXIST)' failed.

Aborted (core dumped)


I'm going to fix the bug which is causing this specific failure,
but is it intentional/the right thing that we assert here rather
than simply aborting the attempted migration ?

I can kind of see it either way:
 * we can't do this migration, but the VM itself might be fine
   and we might as well continue to let it run
 * failing a VMSTATE_VALIDATE field check on an outbound migration
   indicates that the device is in some unexpected state (i.e. one
   which we would reject on input), which might also be a problem
   for continued running of the VM; so err on the side of caution
   and treat it like an assertion failure, killing the VM

I note that there is no documentation at all of VMSTATE_VALIDATE
unless you count the one-liner comment
"/* Validate state using a boolean predicate. */"

and we use it in exactly seven places. This is the kind of
amount of usage where I feel like we should either be using it
a lot more, or not at all :-)

thanks
-- PMM

