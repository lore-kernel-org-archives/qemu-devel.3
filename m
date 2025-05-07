Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A02C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoGb-00077x-Rv; Wed, 07 May 2025 19:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoGa-00077o-FC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:33:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoGS-00013m-6I
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:33:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227b828de00so4473175ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746660802; x=1747265602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8BEgKZpu6Du413dw1lPGX2Jydb8TW1k3wYSTu33o6I=;
 b=fc+lDJYyuQTqfD8mmSOUTB/eKO8tjYAcJHg0wa1+la04oKwJ87C03obujKJ4gTCylK
 ZxnCFkpHBW2jbu/ZHYxB+5HY/m0HmdB7iYVYrkztmYB5WfKiYu/BAyyxlziIQphGr/I3
 uQfbHpX97jg6lXFoLqLvoezevrXGebk4zzZ/fZArrVgUvaplXs2d2ITuEsyxmDguIeuB
 mPUHQcyCRoEAKk2xaEk5POHmaJoaKlQVcEjRXJq6yrQ7jWlD5bR9yhqotCQwAG+Sjhpa
 6FQUlJYJKFv+raPPuim7egeK7nyKk/fT7kAjQ/kfgfyJ6HP+Yl6b1+0cJKztbB6BZ8rp
 n6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746660802; x=1747265602;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8BEgKZpu6Du413dw1lPGX2Jydb8TW1k3wYSTu33o6I=;
 b=n2AjO8g6WaXx1n6YzXiNfQrYk1cA/RFdpJun+O9iXM1KfMdghhlV2Vf22WACQYTur2
 BeB119FcBlUQrwvs9CT9XcySugXdO2sIv4kH/z5ASHsdGaDSHKKEUbU1bBtAgovUzh/t
 DtOnCx2/ipHbuWA5hcA1ErFu5kiIaCik2cg0pAknZ5YXC1cAH4Bt4r7OeI/tPmYMU8Ky
 1IEES37vgCtdRKNKdGEDRw05gVEwf5K1MGs8TmWRq56DjaHN+Y5L9XM8u6D7CqJq2ivR
 jksuJu9iC1e6ENAG9KfhV4s9F3ZHmYF52r2Rl6jjT3HtP7WfEjgTpqdZRpV9IJr8lBob
 yvdg==
X-Gm-Message-State: AOJu0YyvfoVx5eW6FBBlD6xd6LfB43FOzH1oygNUzERsUJe0dP+BPTCG
 L7Iojrb33An8FvQf/g8KLuGgWh1ZqsKcnQU0h7NuxD0L94jPBGhTV4crjjgp9In3v50lQ/JJM6b
 7hGTNCg==
X-Gm-Gg: ASbGncvwSarxA08R/mO2mmJ26J7w8tLODskPQe+SkC9TXySThG9k+Qf7o+L3szIqiTU
 2/C0KK6PrEeHWBy1wCfn15N5VPDeSmZPm2fde4Km6ejNw+T8lVShtyuCfmS49Ltou22RmBt6hEl
 ggMfVa29SnzYSkASqPgy8PDjZA/rXPQAGkD/X8O7c+OmOuAbbghblvWioQejiqXeoeOgJERi0s/
 7+JHP8ESTM0A6huXNSrq8dirANpwjSPZgNicCjqJr6nTLmyMgQnTic4rvBBgXHuzjxg94BekdWL
 +LyK36HByiEcJZUv6PLawOei7DtwOqKOqKRmtGhuw6WaGmP9PkbvhA==
X-Google-Smtp-Source: AGHT+IE2M+ZZJs79pvx1w8TWDXQ3fdft6u5fMTgg90hu3kA69pNaS3iQPi/iGHvRKf6my+JEiFLArA==
X-Received: by 2002:a17:903:1744:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-22e5e98057emr80898145ad.0.1746660802600; 
 Wed, 07 May 2025 16:33:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e7e1df40csm9531955ad.256.2025.05.07.16.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 16:33:22 -0700 (PDT)
Message-ID: <8bdaf91f-ce3c-482a-9cf2-5298bb774f5c@linaro.org>
Date: Wed, 7 May 2025 16:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] single-binary: make QAPI generated files common
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

For people who would be interested to try this series, I used attached 
script.

$ ./qmp_schema.sh ./build/qemu-system-x86_64 -M none > x86_64
$ ./qmp_schema.sh ./build/qemu-system-s390x -M none > s390x
$ vimdiff x86_64 s390x

----
diff --git a/qmp_schema.sh b/qmp_schema.sh
new file mode 100755
index 00000000000..576f7d71dfd
--- /dev/null
+++ b/qmp_schema.sh
@@ -0,0 +1,32 @@
+#!/usr/bin/env bash
+
+set -euo pipefail
+
+if [ $# -lt 1 ]; then
+    echo 'usage: qemu_cmd' 1>&2
+    exit 1
+fi
+
+qemu_cmd=$*
+
+$qemu_cmd \
+-display none \
+-qmp unix:qmp-socket,server \
+&
+
+qemu_pid=$!
+
+sleep 1
+
+qmp_session()
+{
+    cat << EOF
+    { "execute": "qmp_capabilities" }
+    { "execute": "query-qmp-schema" }
+    { "execute": "query-cpu-model-expansion",
+      "arguments": { "type": "full", "model": { "name": "max" } } }
+EOF
+}
+
+qmp_session | socat - unix-connect:qmp-socket | jq
+kill $qemu_pid


