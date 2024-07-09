Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575F8C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCyH-0006PU-BX; Tue, 09 Jul 2024 11:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRCyF-0006Kq-O9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:41:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRCyE-0001OR-6P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:41:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70af4868d3dso3330576b3a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720539692; x=1721144492; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFhe30zhKXYHYZd2mZim5bAhZcocmmJveReIi3uOxg8=;
 b=TfZX3tHkRdnqhnDfWQqs40uK5tyK9tr6ISOWm3nnT1VUdjxKqWQi7UaJu3cjczf9jv
 v/qRrSFXu7SYIeFYv7MbvaHZyttG5y46H8nUdYG0637syUL1kBO3WUeeomrJ8svkoLXN
 FE+5E+N6DWhW8i/F8HVT/aHPkKq+qWfzFsSSfiRyFIWxjM4+mPLWH9rvDdOisIAfMLn7
 tR5pzPrbdw8tf30e+xLXt62SY1eRGA9bpnQ0ZjBgNBHmQtIFEpAoZ7nDl6z/RWxF+3by
 kgg5dlhZzaHmLG5yhtBjzU2kfDAPVbILUlV/Z8oppa79+XIKMGK/5+rvYUBYfiO7WSoZ
 TGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720539692; x=1721144492;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HFhe30zhKXYHYZd2mZim5bAhZcocmmJveReIi3uOxg8=;
 b=OthNWUEzS8oCwzZHlJnBRDUVq0fv9KKwQNcJOFUDaW1l6aARfwnl1zUo5RWunbnQWT
 OvK3dFQdh3IbiWrxUGmpQ9drxozFq+TqA/MD+4dD3ichdwf+6dxBg9HjivB2UgpSvWwG
 ZvYifRCfK0IHMuJBEBeXxcO5d0eMr499MmNNoxNbJNGQ42grfUGthtyOR4AqFPxiCnd4
 MZojN6IUbuC8guy8OCM78Em2FnI9h5qpRuSfP5iF4PpozoDCLKStJ4HGmYH/gOrl8A6h
 zN3R+5wmt8mEbN5TbuKmYGNMDs8FEkOnfFm3lU3tsi2+3XzjEMkBVIQxEBbPOl4qnijt
 51ew==
X-Gm-Message-State: AOJu0Yy/sQJAphW7I7oSTN11apYAlsZmWkRR5w13vQ89IJPRZ7AxG2Uj
 ZhEEK5xrk2IORBh0fRIaIqdTZz7uv8Wwb/GI9g32YQmdh8IT7nRGMxh3e1KGG7/WnDdwDJgPNys
 csSU=
X-Google-Smtp-Source: AGHT+IGdzZNuXeA7BLPRkzWc/gV2F7UFBfLbpE7eOqDEWNqEHZP1VSM+Zt3eRvsxlRTo/2pCSe8sBA==
X-Received: by 2002:a05:6a00:198a:b0:70a:f007:468c with SMTP id
 d2e1a72fcca58-70b435106b4mr3346574b3a.2.1720539692091; 
 Tue, 09 Jul 2024 08:41:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b43898c46sm1979399b3a.40.2024.07.09.08.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 08:41:31 -0700 (PDT)
Message-ID: <6d22c5c5-cab0-49d3-88a8-3dd34c8c4938@linaro.org>
Date: Tue, 9 Jul 2024 08:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Avocado 88.1 vs Python 3.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Hi guys,

I have reinstalled my development box to ubuntu 24 (because the Rust support is better 
than my previous install; ho hum).  I thought I had tested everything in a VM before 
committing, but I missed out on Avocado:

>   AVOCADO Downloading avocado tests VM image for aarch64
> Failed to load plugin from module "avocado.plugins.list": ModuleNotFoundError("No module named 'imp'") :
>   File "/home/rth/qemu/bld/pyvenv/lib/python3.12/site-packages/avocado/core/extension_manager.py", line 63, in __init__
>     plugin = ep.load()
>              ^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2518, in load
>     return self.resolve()
>            ^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2524, in resolve
>     module = __import__(self.module_name, fromlist=['__name__'], level=0)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/rth/qemu/bld/pyvenv/lib/python3.12/site-packages/avocado/plugins/list.py", line 19, in <module>
>     from avocado.core import exit_codes, loader, parser_common_args
>   File "/home/rth/qemu/bld/pyvenv/lib/python3.12/site-packages/avocado/core/loader.py", line 20, in <module>
>     import imp

If I understand things correctly, the python "imp" package was deprecated, and has been 
removed before v3.12.  This is fixed in upstream avocado as of v93.  But we have a hard 
stop in pythondeps.toml at v92.

Remind me what the blocker is to upgrading?


r~

