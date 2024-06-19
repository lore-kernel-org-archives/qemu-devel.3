Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4F8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 16:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJyYS-00068c-88; Wed, 19 Jun 2024 12:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJyYQ-00068A-Kn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:53:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJyYP-0005cZ-1t
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:53:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-704189f1225so66766b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718815979; x=1719420779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HC0bUPUaHHZfsmDj16vc05hNVjeQ+wxINCOGWIUt8ec=;
 b=I83n+RHadxqFi/bfP4FDQAULoXA9IngSp6crbeJ3jxi9CzckI3F1wwJ/m2znxZobir
 tOjFcer7tt/ZQ8uNJCZTiPcGqTWhXk+ay7Yluzex1PpT2znyISc4hz2JiTwr3r3Krp3c
 TxubRxwuM3igA9csBUQDQKwZ88r6wQLdv6/wvklGyqqsPe44LFb9z1/Yon+OKCrpSUAa
 q9HeAWIdDOV0t76Dyb9PEvK8npNyPhzslLxZBOaAK4/QaxG3Zos6ICWE430Du2ktcQZ0
 qkyCnMOw2QNyyb6qgj5nxYxGXHKbyWixNN/wOlshRs7X7J2gHg72QRbY5k/gZQAlDWKS
 OOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718815979; x=1719420779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HC0bUPUaHHZfsmDj16vc05hNVjeQ+wxINCOGWIUt8ec=;
 b=mAa1rCtL9zOUkYjihKUEbFdWx3zMVkxKWIpWDSHOsJH5QP3wYOxqR/twzDnlBb98ey
 p390KXXi3y5o3wbIRkhcJGXNWaZb0B0sq95s4M2/KbYAAZ9ZMX/lOvEDEl+uag5Mgar/
 uZdoqkBoY3NCmLwPJqBFR79QUM6vuzfCQMkpRKhmx5Gorqzl5OLEnlXMBwpA3hsjMyZW
 6uiLtde/Y9n/KS9MOP/NGSGimTf9tZ1LZRspzJ3uZPT87y6qHEE4X7EvL/LVHMaskjat
 0SfpLzBWrMcCmIdRkjalombXO4IwDMhOD05x6vuEVCeDPvdiIC4BWBm8nnDOf7JT1lbH
 mcYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlNHJeye+N7pf1XxWCFHIZ43kNkK1Osg3aQcw1HqsOI7t0xodIyvtFai7fMwxUDJGRqK0jpkFL5QuRXV2f659HymKCOaQ=
X-Gm-Message-State: AOJu0YwxJta5tFrbayIVI2Ly57RTdZy1sf7hLFqVjiyNM4xi+63JLvVH
 sXWvgUvRn97fK+U0zv8O7UBV8NPQQTgw6yp3Fd3T3Auuu1tt15dCByNmuXJvygokRRpQ9NkYbh5
 C
X-Google-Smtp-Source: AGHT+IHgjX+s1N0UjlduEISC7iYPcPQ8u8SgdbRzarAQ0d9quDWGTATGFFgP/FOJZv5pNuXcowRiSQ==
X-Received: by 2002:a05:6a20:caa:b0:1b2:b16f:3b35 with SMTP id
 adf61e73a8af0-1bcbb451f35mr2644888637.10.1718815979069; 
 Wed, 19 Jun 2024 09:52:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70634b933d9sm1399703b3a.31.2024.06.19.09.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 09:52:58 -0700 (PDT)
Message-ID: <aad23767-c42b-45e0-8b86-c491565971a9@linaro.org>
Date: Wed, 19 Jun 2024 09:52:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <89b7d4ae6c03cf16ce9fcc95d0406c20627fd444.1718101832.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <89b7d4ae6c03cf16ce9fcc95d0406c20627fd444.1718101832.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/11/24 03:33, Manos Pitsidianakis wrote:
> +++ b/scripts/cargo_wrapper.py
> @@ -0,0 +1,211 @@
> +#!/usr/bin/env python3
> +# Copyright (c) 2020 Red Hat, Inc.
> +# Copyright (c) 2023 Linaro Ltd.
> +#
> +# Authors:
> +#  Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> +#  Marc-André Lureau<marcandre.lureau@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import argparse
> +import configparser
> +import distutils.file_util
> +import json
> +import logging
> +import os
> +import os.path
> +import re
> +import subprocess
> +import sys
> +import pathlib
> +import shutil
> +import tomllib

Correct me if I'm wrong, but does this require python 3.11 for tomllib?
AFAIK, we're limited to assuming 3.9 from Debian 11 until Feb 2026, or
3.10 from Ubuntu 22.04 until Apr 2026.

I presume this package can be downloaded from pip, and therefore should be added to the 
python venv that we create in configure?


r~

