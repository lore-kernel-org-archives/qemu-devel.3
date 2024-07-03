Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706FFC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOx9N-00021V-8c; Wed, 03 Jul 2024 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOx9L-00020I-L4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:23:43 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOx9J-00013D-LF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:23:43 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec5779b423so47507911fa.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720002219; x=1720607019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fxyt99NhpqSZijq/0y3id4ljx98fv4+n+XLIHqT3rY8=;
 b=eVa96Ex5A5CaPfmVCOZQw5quQrITWol5aIlswO6dUR5YIDt+sX1gKTOnGKMz62L1V5
 2ZrMWngMNMRViajS58MRT40amtIImFMHVUgKZSLKZiUOnJWCU3LsJupxuqxO4YGrOmm1
 O419LoVWaq7IS7lSND6lsng4yWLieECWkBgJMqFSJlpoHdaQkbNrwOhih3e/KJZx9qHY
 BCc0dTBmrVUuXAv9VFQQGll8otnOqz8d5IeGTJLxFg4zdCvsfHQPGezPiC5Pk5nsl85X
 VVsl/O2/MVrBL1MZKCM4qZvDw5M3K+XImA8vwQYO9wVPNu8MFRApDjB8cOH8Wgc8VM+B
 8bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720002219; x=1720607019;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fxyt99NhpqSZijq/0y3id4ljx98fv4+n+XLIHqT3rY8=;
 b=rcjXs1thyeQTw4c/7Q2gVcfnUY9og4vV4c31ax9Ymq0XlBhl5j8zYWwzMU+mpLaRvm
 K8998lqnPmq4RkmYRtok+F0HTwF3xCz/dLL4IdgXYHAl/YVO3fg8vO5r/RMHIhsAUlma
 i50XMqzZGJvXx++Ua7/u2KM1TP8l5IXRD9EDwZpCqZIoggL9KvWhicltRbNpbSToHYE9
 +j7I+vmKtEVAdfGzKxJTefAd4vWHgux3bQl1l5zhm7AR4Uf5cGBJFY1UT8TkVD7u9/lG
 zcV2hbabtovRcUoST7/Px/3zoe9xdPMLVa5iE6QTqO2q1DjpDh1xLoEJ2zS500z27hS1
 qjsw==
X-Gm-Message-State: AOJu0YwP+ydQPdKfKz4kfR12uGxpb0qlKyoaYclnNdpUaH03QFRNqrIz
 4oM2Eo6evppo21GKnutd4LARZJFChpci5Z1ju3RwA4vst++aQmic8xUpvvuD3J+Pp49tjGQ6fgQ
 2+yw=
X-Google-Smtp-Source: AGHT+IHUfIRMsHItMQE/onGd/rfWExc8F3COEbxAd5PZ9UGVYVoABKxK0YuoGGMM5TWjMRL6Jdh9Vg==
X-Received: by 2002:a2e:9e15:0:b0:2ec:4aac:8fd4 with SMTP id
 38308e7fff4ca-2ee5e390cd2mr75461741fa.1.1720002218828; 
 Wed, 03 Jul 2024 03:23:38 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cdc5csm15476481f8f.18.2024.07.03.03.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 03:23:38 -0700 (PDT)
Date: Wed, 03 Jul 2024 13:21:29 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/22] qga: don't disable fsfreeze commands if vss_init
 fails
User-Agent: meli 0.8.6
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-13-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-13-berrange@redhat.com>
Message-ID: <g1m7d.30xyxwwcb8l4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22f.google.com
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

On Thu, 13 Jun 2024 18:44, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>The fsfreeze commands are already written to report an error if
>vss_init() fails. Reporting a more specific error message is more
>helpful than a generic "command is disabled" message, which cannot
>beteween an admin config decision and lack of platform support.

s/beteween/between

>
>Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>---
> qga/commands-win32.c | 18 +++---------------
> qga/main.c           |  4 ++++
> 2 files changed, 7 insertions(+), 15 deletions(-)
>
>diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>index 2533e4c748..5866cc2e3c 100644
>--- a/qga/commands-win32.c
>+++ b/qga/commands-win32.c
>@@ -1203,7 +1203,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
> {
>     if (!vss_initialized()) {
>-        error_setg(errp, QERR_UNSUPPORTED);
>+        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
>         return 0;

Should this be return -1 by the way?


>     }
> 
>@@ -1231,7 +1231,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>     Error *local_err = NULL;
> 
>     if (!vss_initialized()) {
>-        error_setg(errp, QERR_UNSUPPORTED);
>+        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
>         return 0;
>     }
> 
>@@ -1266,7 +1266,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>     int i;
> 
>     if (!vss_initialized()) {
>-        error_setg(errp, QERR_UNSUPPORTED);
>+        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
>         return 0;
>     }
> 
>@@ -1961,18 +1961,6 @@ done:
> /* add unsupported commands to the list of blocked RPCs */
> GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> {
>-    if (!vss_init(true)) {
>-        g_debug("vss_init failed, vss commands are going to be disabled");
>-        const char *list[] = {
>-            "guest-get-fsinfo", "guest-fsfreeze-status",
>-            "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
>-        char **p = (char **)list;
>-
>-        while (*p) {
>-            blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
>-        }
>-    }
>-
>     return blockedrpcs;
> }
> 
>diff --git a/qga/main.c b/qga/main.c
>index f4d5f15bb3..17b6ce18ac 100644
>--- a/qga/main.c
>+++ b/qga/main.c
>@@ -1395,6 +1395,10 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
>                    " '%s': %s", config->state_dir, strerror(errno));
>         return NULL;
>     }
>+
>+    if (!vss_init(true)) {
>+        g_debug("vss_init failed, vss commands will not function");
>+    }
> #endif
> 
>     if (ga_is_frozen(s)) {
>-- 
>2.45.1
>
>


Otherwise LGTM:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

