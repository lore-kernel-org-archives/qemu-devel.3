Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023ECC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 12:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reZyp-0004cn-RR; Mon, 26 Feb 2024 07:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reZyo-0004cN-0d
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 07:21:10 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reZyk-0005ym-Kb
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 07:21:09 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so4569696a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708950064; x=1709554864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22jYm/iZsYa0w1PGuafvDn+6rG01sZcvlfBKBYqm1ME=;
 b=l625XMch6LQOXQgZfoq0CTUgn1wF7B3LqlJLPwA4R/77WHJo+6gCi+PQZ1YmETE77k
 xCHg5GVgDdXhcyB33OOScPGD3Uy+/N7VLV7hwHi3XEKRy0MAr/IIfkjy7zfFqObVhXqz
 JsF9ek1XJVBtx3cC2VuaMLA0f5OXt5Mt4j8kwwpnu9b7SNsTWvhVy2Nr1w6lICAI6lb+
 P9JQx+48XQgOc/TPZgSbGLr2hasf0wxsa8Ol/kF1Y2mbfglTucbDJtK8yp3DRWXANMZE
 gPhpRemqQNJqYtTaA3BwaZwqWGNvRx7/D+91V/3UYekD6XR9Txr7RDLyVkuEZxvDWAOi
 Y9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708950064; x=1709554864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=22jYm/iZsYa0w1PGuafvDn+6rG01sZcvlfBKBYqm1ME=;
 b=b6qEP8pFp/DxPsGv65d6RYU8tL1RKO5IgiOFL45irPGsvCdRZOyI9WaIZd1euSkG+S
 K6CUfLjDWibRfjsLkmOsSomRMmegHyDpreBKjwNGkFtNxk25ro9VV6nkNZAP2CnCLubn
 KOdWmgAecA153LFFzTFwxKE9Lr03HrqTzk/fdzMLD60LQbXiYYSmP5tGnLgoDglEl2dh
 HJvPcxG51YzkhqMhguSk+JNObMM0VxUmBnd6qCwqRmLhktaKF8lc8xHY9BliJdBTvGTY
 nuWZKHrrN7s1So4K/6OqeojLdot3Cskrigijq0duXbTgPS4yUriZ1aQZlVvq3aInZ9Mq
 cnnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJuyaJMgjGywed91i3Ac4/qCVqW9dZp7JDKbur4OBKdNq47BaH8miZ1zT5g+42BeaJQh3aAxiXUsBvQo1fTIpuiNz4tns=
X-Gm-Message-State: AOJu0YzrsGhOTDOH/FSl9LAGaV4J5BcFP+FtXnlfSnII61SJ7AXTnn4C
 C988AYYptevF01pH96GEQVd1rjj62UqP7qYit1dSgE0egr0t+XjuxsXcnl7T7Bw=
X-Google-Smtp-Source: AGHT+IGHyRv8qb8rgkB6VdOzTg/otTjQc2cPQF6jG/Z1ldMuaKX/2lVsPtt32hqUjls4X6rO/vB4Jw==
X-Received: by 2002:a17:906:556:b0:a43:8d69:dd5b with SMTP id
 k22-20020a170906055600b00a438d69dd5bmr108500eja.2.1708950064626; 
 Mon, 26 Feb 2024 04:21:04 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a170906685a00b00a3f0dbdf106sm2362352ejs.105.2024.02.26.04.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 04:21:03 -0800 (PST)
Message-ID: <ea920e78-7669-4034-b434-921a0e9963b2@linaro.org>
Date: Mon, 26 Feb 2024 13:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] util: str_split
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
 <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 22/2/24 22:47, Steve Sistare wrote:
> Generalize hmp_split_at_comma() to take any delimiter string, rename
> as str_split(), and move it to util/strList.c.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/monitor/hmp.h  |  1 -
>   include/qemu/strList.h | 24 ++++++++++++++++++++++++
>   monitor/hmp-cmds.c     | 19 -------------------
>   net/net-hmp-cmds.c     |  3 ++-
>   stats/stats-hmp-cmds.c |  3 ++-
>   util/meson.build       |  1 +
>   util/strList.c         | 24 ++++++++++++++++++++++++
>   7 files changed, 53 insertions(+), 22 deletions(-)

>   create mode 100644 include/qemu/strList.h
>   create mode 100644 util/strList.c

Markus, is that OK to include these two in your QAPI
section in MAINTAINERS? Squashing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 992799171f..7970d34cdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3196,6 +3196,8 @@ X: qapi/*.json
  F: include/qapi/
  X: include/qapi/qmp/
  F: include/qapi/qmp/dispatch.h
+F: include/qemu/strList.h
+F: util/strList.c
  F: tests/qapi-schema/
  F: tests/unit/test-*-visitor.c
  F: tests/unit/test-qapi-*.c
---

