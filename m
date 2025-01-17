Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFB5C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdv-00028C-Nq; Fri, 17 Jan 2025 08:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcw-0000zn-UZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:11 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcs-0002Dj-CI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:10 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6ad83so4301234a12.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121384; x=1737726184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzeJsOhL7cM2HJmzGNoIr2AKwnH1ajX9mBPNfI6j2oo=;
 b=oL9dZZ0PPE/H9gxOxUyCSd2PLu5/AXAOXEPzv/m3OyD1m9GGziQ5q02LNco2QXs+Ad
 6aaS+fVOmCh3Fmirv7B+VC0SgBMAVqHt+n6m9iEUecyHOZyYbPKQ1cmUV9tFsb9ST5hn
 oZ3o4mCKDq8icXYkhcwfRq5KHjD6JfmwKLZjdJuy/vf2pexNymSMVK5KjA1bTWB/UBoC
 15QPgYeomCOsIfdvVlUnZ9/SeHDPqoTQrSRZ1TBdhqv2YX2Q6KIUJGuxFy2xU04FzBF3
 vPWVUNQLrfUvnx7gus0EHYmrLJuwSVSvPXWrb1opKhA2IS24nrBCkR0lt5hJaOq/oaSx
 SDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121384; x=1737726184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzeJsOhL7cM2HJmzGNoIr2AKwnH1ajX9mBPNfI6j2oo=;
 b=VqjqYnKQIgwbKUjDA0lEkqfONYy+nKcjY9HepmA86LuuwEirwbJEK0z64zujEVJSo8
 6RJCAVOq1+xDCWY3zb9SAPgX6COgFBj+AAhG9frJ7ept3rUjb7svfkZUnWVDrQZnIJQj
 9wARWB8whB3lvqtXW117Uh/rhx8c0Ax8f6r2B9yKr348WDfmEgxVYSz3tWT1hrY3a/Ta
 dCLgSz3xDRNTWGHbYkqXDDU/Vz7L+bEzEn8zKEXXE89n0LazZ3sm5vmFVt1ZA8kVbp5g
 PAkMggAbNgM4MK7mBSBQgARaE9AxVKANo60v42V8aPUqRcvfzVVIwvP68CpdcGT0i0pP
 NlLA==
X-Gm-Message-State: AOJu0Yz2Q94tV85wzRtVeWcM9iNEAZNAoorFm3nIFzaaydSjmomlsBhb
 XZN5GI2LwuruFZhXR8vqoOYJiITt4VTAd9U26IRot05wApHVzW7fwhQKTp0OVWlqwjVyDvGZgKS
 jmHE=
X-Gm-Gg: ASbGncuYnMr4z0II4qsJwo051JcEV4VBphE+b/4oKaAyTtgsQbW9icV4K+82jnJxHTl
 JCITUEFuWQAiNC48jIm3mA7fzFn+C8Z2j4Im2lLKGYvtLH2HAeB0gk4+JuEz9Ryid65L1sa3m/b
 aI7f0K+4trt2O84L7Y+id8hiz+WHuKrc2TJrowNMDzBx+2h2t2ILh4YADqhR1/otojBQamupt4g
 G9HNjgMRZg6IiVV9ABEdHlmSK23XNOo27teomelFNh0rSx+6KGyU8I=
X-Google-Smtp-Source: AGHT+IGFoyALXDqmeGLZFXoiWjV8jyYIedt6XRZkG2tD0k23aIDPLghbCELiZxSi69k6Cj7FnZJZhw==
X-Received: by 2002:a05:6402:34d2:b0:5d2:728f:d5f8 with SMTP id
 4fb4d7f45d1cf-5db7db077a0mr2378036a12.27.1737121383878; 
 Fri, 17 Jan 2025 05:43:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73670fb5sm1557595a12.25.2025.01.17.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6E0660872;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/37] system: squash usb_parse into a single function
Date: Fri, 17 Jan 2025 13:42:28 +0000
Message-Id: <20250117134256.2079356-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

We don't need to wrap usb_device_add as usb_parse is already gated
with an if (machine_usb(current_machine)) check. Instead just assert
and directly fail if usbdevice_create returns NULL.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-10-alex.bennee@linaro.org>

diff --git a/system/vl.c b/system/vl.c
index 22c1444da4..02795c5135 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -811,31 +811,17 @@ static void configure_msg(QemuOpts *opts)
 /***********************************************************/
 /* USB devices */
 
-static int usb_device_add(const char *devname)
+static int usb_parse(const char *cmdline)
 {
-    USBDevice *dev = NULL;
+    g_assert(machine_usb(current_machine));
 
-    if (!machine_usb(current_machine)) {
+    if (!usbdevice_create(cmdline)) {
+        error_report("could not add USB device '%s'", cmdline);
         return -1;
     }
-
-    dev = usbdevice_create(devname);
-    if (!dev)
-        return -1;
-
     return 0;
 }
 
-static int usb_parse(const char *cmdline)
-{
-    int r;
-    r = usb_device_add(cmdline);
-    if (r < 0) {
-        error_report("could not add USB device '%s'", cmdline);
-    }
-    return r;
-}
-
 /***********************************************************/
 /* machine registration */
 
-- 
2.39.5


