Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4952CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBbz-0005gG-Fx; Mon, 04 Mar 2024 11:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBby-0005fP-CB
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:56:22 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBbw-0001GL-3u
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:56:22 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so7064758a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709571378; x=1710176178; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WMU4mMZg2CUCC4QCecP1CE+y0d+ze76R128fW03pBxU=;
 b=V9OAYAy8CNMBh98Lejw10QasMJGxcPwzPENhJ/aLWM9M/T6ovY8WYri/PqeS2/8SNW
 9+n7TNxqKXYDIQ7iKnMQSpBOuXL9tMcMLvC0bTP5LnHxEknrKY2hUd0ZdQkkrD+eC65p
 +h73pyuFFkOw7s5E426mlDeRVFV7C+11CZ7lw0BWU8QMUsv6pf9xzvXSOGJI4nHO8Idq
 4xZlOxXLfIYq6Mfg4QFEqjyH0UR6w5uWG3RPMNSrTRaDcTs7Jjmt+9fE9OIioJDPUWNW
 IIlwfZWwV4jPCU0ICwuRhTIDpaQxlhdchA3enT4ni8WPFMcgZDWPlXjOM23ykKJgPmDY
 9IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709571378; x=1710176178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMU4mMZg2CUCC4QCecP1CE+y0d+ze76R128fW03pBxU=;
 b=spNDe1kLnqmGi4D8a8gbzM1Agl9mMJcA8JdjGNFw0wFg2gLvhBflKeP/6E3GNKcuml
 buz7uG4VSdvtSbv27yH4j9PbA8hfIhYl+4R9pps2GaX01idBJmg7KWXust66tco2bbTg
 /qV3eV6ceEiP33xMXuplVfmAoTuPCAWz954idCs8BwoKzdJYucBB2nRZNFAR7Wld7c4L
 qAymN8iWW6QwOvRwMmk6Ofe7wV+nBmiaCvNUza8HfSvAn10J2+B0b1LFtML8xTJo8FDQ
 kOYPFZhIwfnerECIeD7dincItPs8fK3cxmHM+XPtZHAnDOp4sw6TSEf7tJh7SUBwmkDC
 B0Kw==
X-Gm-Message-State: AOJu0Yw8ks0z/tWgmLLo2u6svbBYhr9R6bxEkNYT+2O/1DAhEDPK6+ee
 WvGvhFAQUXTvjmVusiTAO42SjQetybDg89M0C+yAHj4xTwEDbijLUEC9UOwLMwUCfDzDxSNRSv0
 khyRiv9P/tQxa09sZ9/hHBnniPVSJqBjsL4bUcA==
X-Google-Smtp-Source: AGHT+IG+s2/jvRnZ5F0F8VJvSWQDeftGuhV18+Ju0fAXMtbNwQFb3w/MsSNDzZi995ThiAbfxedw/iSUVSbgfh88cmA=
X-Received: by 2002:a05:6402:5c3:b0:564:3b2e:2a2e with SMTP id
 n3-20020a05640205c300b005643b2e2a2emr6198874edx.9.1709571377739; Mon, 04 Mar
 2024 08:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20240304130403.129543-1-thuth@redhat.com>
In-Reply-To: <20240304130403.129543-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 16:56:06 +0000
Message-ID: <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 4 Mar 2024 at 13:04, Thomas Huth <thuth@redhat.com> wrote:
>
> The macOS jobs in our CI recently started failing, complaining that
> the distutils module is not available anymore. And indeed, according to
> https://peps.python.org/pep-0632/ it's been deprecated since a while
> and now likely got removed in recent Python versions.

This doesn't seem to be sufficient to fix the macos CI:
something in glib seems to still be using it.

https://gitlab.com/qemu-project/qemu/-/jobs/6313212803

[281/6553] Generating ui/dbus-display gdbus-codegen with a custom command
FAILED: ui/dbus-display1.h ui/dbus-display1.c
/opt/homebrew/Cellar/glib/2.78.4/bin/gdbus-codegen
ui/dbus-display1.xml --glib-min-required 2.64 --output-directory
/private/var/folders/xc/tpssff9959345bnqq4c6tlww0000gn/T/cirrus-ci-build/build/ui
--interface-prefix org.qemu. --c-namespace QemuDBus --generate-c-code
dbus-display1
Traceback (most recent call last):
File "/opt/homebrew/Cellar/glib/2.78.4/bin/gdbus-codegen", line 53, in <module>
from codegen import codegen_main
File "/opt/homebrew/Cellar/glib/2.78.4/share/glib-2.0/codegen/codegen_main.py",
line 29, in <module>
from . import dbustypes
File "/opt/homebrew/Cellar/glib/2.78.4/share/glib-2.0/codegen/dbustypes.py",
line 22, in <module>
from . import utils
File "/opt/homebrew/Cellar/glib/2.78.4/share/glib-2.0/codegen/utils.py",
line 22, in <module>
import distutils.version
ModuleNotFoundError: No module named 'distutils'


thanks
-- PMM

