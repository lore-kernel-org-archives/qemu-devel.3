Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97485C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzDT-0007Hz-5e; Wed, 19 Jun 2024 13:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJzDR-0007Hb-5D
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:35:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJzDP-0004p7-G3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:35:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so23337f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718818521; x=1719423321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZI0nq5PrVKb4Itbz1kc15CUbQ7PGpnULSNw7cNDZDoI=;
 b=iNBRqu0jI6bU8+O8JBgm5xJHjKbd6VhTf0uhwYyouVfGTDdj6QJN8/COzkbaKxDJlz
 phQXdYZveJCa0ZcMqANStoY8/Rkglwx3lzAEENER0GmdX2d1U6wBU6JWHc8z4rfbq+8K
 myXWbDQcQx2ZBqv5Lq7ev5jxDMWbTB9L//w0o2/iUH/9jjmr3xBrbZ7MGkNwpvrQOe1r
 eKFcbWlx9hHiTRe0lXM8bjfbws26U5eUSKjtUIrcxiD3OrgzENriIYgYHMYCzf74oqqP
 v1H1A9zWWoSipCbiI18puFXXr+4Z8yBuGBkibF8XNVcS2/SLR1MhEDR0Bk/p1VjC5eZy
 UPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718818521; x=1719423321;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZI0nq5PrVKb4Itbz1kc15CUbQ7PGpnULSNw7cNDZDoI=;
 b=D7J9B/l+iedjZbRFH1aAcoNhQyWWc7zdEnFed48PmkbuuroK3n9El8yNTjp51PG9YJ
 ZjCcViXuSudgvAhABMDSHwBxGVDJd7etf9wGdv3Eqqfp2+fkin1d3HXOn1toIIxd/xKL
 WAVJd0PHa5nhuPaPv9vWo/x79nqvhAjy6uBg6HtAnwxTlNoSNvDssOUkEttX8S6YyHuy
 Py0hVUG/NyTPOGkZ5gdTA3ldiOATBYDEu+RVX8pRDlRViDBxklBuAMoGRfdGVx4w6Z/W
 K35GArtwcAIzfPzEY+rRaLn68lKlR6v3qtpMqEmvg1p/vBBXPnkbUpbZ6c12tbyskKZD
 Eovg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTbQ6Fc6FVZxRvJ/jDTX9J4AR6n3fU/CrdqJp+zUIrrZKtmAQ4VogZiiCpglgt1Qkv/2r5BUFMX83mTbjuvI5UGiUkK+E=
X-Gm-Message-State: AOJu0YxgCz02pH4ivAsSofk2+gVLR6gTYHuMi7Xz0oCvCWuynwqeJViw
 skDowLcE/IfDHbPf2+X9PsgkFy/vj7Byh2xPB82bk+mpbiPaoFnfomLfYp2/1h8=
X-Google-Smtp-Source: AGHT+IHpKmAgJdc2Hmqi6Wm2IAUciiv9RmohodGasAMuaqYXBVlhBU/OHUUTKsFssxo5o47CV67NFA==
X-Received: by 2002:a5d:64c5:0:b0:363:7bbf:efcc with SMTP id
 ffacd0b85a97d-3637bbff072mr2167586f8f.62.1718818521220; 
 Wed, 19 Jun 2024 10:35:21 -0700 (PDT)
Received: from meli-email.org (adsl-103.37.6.162.tellas.gr. [37.6.162.103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362ba0b9b3esm3990918f8f.74.2024.06.19.10.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 10:35:20 -0700 (PDT)
Date: Wed, 19 Jun 2024 20:32:03 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 1/5] build-sys: Add rust feature option
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <89b7d4ae6c03cf16ce9fcc95d0406c20627fd444.1718101832.git.manos.pitsidianakis@linaro.org>
 <aad23767-c42b-45e0-8b86-c491565971a9@linaro.org>
In-Reply-To: <aad23767-c42b-45e0-8b86-c491565971a9@linaro.org>
Message-ID: <fc8uv.9hmi1kr53jic@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 19 Jun 2024 19:52, Richard Henderson <richard.henderson@linaro.org> wrote:
>On 6/11/24 03:33, Manos Pitsidianakis wrote:
>> +++ b/scripts/cargo_wrapper.py
>> @@ -0,0 +1,211 @@
>> +#!/usr/bin/env python3
>> +# Copyright (c) 2020 Red Hat, Inc.
>> +# Copyright (c) 2023 Linaro Ltd.
>> +#
>> +# Authors:
>> +#  Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
>> +#  Marc-André Lureau<marcandre.lureau@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import argparse
>> +import configparser
>> +import distutils.file_util
>> +import json
>> +import logging
>> +import os
>> +import os.path
>> +import re
>> +import subprocess
>> +import sys
>> +import pathlib
>> +import shutil
>> +import tomllib
>
>Correct me if I'm wrong, but does this require python 3.11 for tomllib?
>AFAIK, we're limited to assuming 3.9 from Debian 11 until Feb 2026, or
>3.10 from Ubuntu 22.04 until Apr 2026.
>
>I presume this package can be downloaded from pip, and therefore should be added to the 
>python venv that we create in configure?
>
>
>r~

That's absolutely correct. I will make it compatible with at least 3.9 
in the next version, thanks!

Manos

