Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE7BCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ROl-0001gR-98; Thu, 16 Oct 2025 13:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9ROh-0001XQ-UO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9ROX-0002j2-8o
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760634237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zftZ6tpEz05YHR2jJC8m1JzGswjm4nTiI8c0/9HQT9Q=;
 b=PK2BHGvYIiuK5UzeoiS2AY1rsoqdnHpJYf7AiHMTBMHRiPRBJfAZK1VbldTWWZC6m4/Kfx
 05kB6ONG9YrIiJgzMAkmiOjiReLrsN6u+6wWWOlOrJCnfy+m4fsVbqWEvMwumpLN3nTs2/
 ic1pUBaP9MyjVy8lQs3cgrJhyKw91hY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-CdaOTnmbM1WxGumyIhEumQ-1; Thu, 16 Oct 2025 13:03:55 -0400
X-MC-Unique: CdaOTnmbM1WxGumyIhEumQ-1
X-Mimecast-MFC-AGG-ID: CdaOTnmbM1WxGumyIhEumQ_1760634234
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso10369395e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634234; x=1761239034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zftZ6tpEz05YHR2jJC8m1JzGswjm4nTiI8c0/9HQT9Q=;
 b=oiwlflzA33xgUTnpd2lGYMO1lBkQtFQFco/SPPhVi+ReAj/ZUEehB3D/qf0pr9MFOq
 HOVmOwFnZzNJ1lsgwsk5YmZmIMiTCsiF2BKFW5n9h+Ml4EjcFgV+7+ZDwl5+tPBfpqhv
 x4xiXv+fNiYl2f6Y7Jy3rUsmhnXBoA0O6xlmvxWvaCzIlboik1uPE4cilfSmwM7LKopK
 jChrPNeDg17qMXbLM+N9fbqpk7RUPmvo2stdTAeRZV2vUaNqM6SqkVLSFKuBkqzQWinU
 icu5yLI6pJ8FB6PsN7TqQ0goAjYKT1zU3+DtarKovqJMSeGliS6AVj5GqXCsY/0sizzb
 QMAA==
X-Gm-Message-State: AOJu0YwSoeeo2Z+9ompWy/l1I8OgpodDzZM+fyYdH+1gR5QhYxYm84gd
 hMC58ff2qJbqwZspnZsj2h/GTuAyIOiZioRHikKGC2hTznYC2VJJgdJJnsbRMJMZu0diigqdJbE
 e96xXRBaZF44MEKF7gjAMoELIJeDqPb41mdjwyLPd2XkpHSRbvbTBxwklyopWCbggNR9jSkj+UL
 vcpiTJe1uBZ9ItfAN9qtw4eJ6FWE3mXY7u/J0icLoF
X-Gm-Gg: ASbGncumDNLruKsrvuWUuwJf4VXkVMbBrZAVb6V3fY/hZinYOJ6gv461ZGWyT4qjpLP
 P3rn8D5+PAPj2/26qp9G8GWGsBBbqQrx1+parNABi8C5t10SdHraccefhi/CNMRjaOgzmfpzR0+
 ggdmCzXcAIkEa2j/U4GfBBVFFc9UYZuzYEcC3kMC1p76uveKmaCfoRUtdUT1MGArfK4FaAuklqY
 M2zvPj4mY2T84G5dPtgDjVqAaM3BMSSInX70qnJcinO/ubEswnQBdACNWVCdrw5mDmdXM5RNu3h
 Mn0Yw3+eQdBCdEUJ1+yZXGGRuRscNvXaUJu2wBOKm6zh+woWI6fjTQ9dasPyWhHAO9/q7tU80nM
 wI9SR/gn7J6loRH/IyJnuyCk8xxZCx7y8R8SgKJSHdLHHNRD2Io6PwPyeCwF9m615bdfusKHg4N
 U=
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4711791c66fmr6641645e9.28.1760634233902; 
 Thu, 16 Oct 2025 10:03:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5sUIF9DxcJQJoJVc4HM8BSYFx8QMvd4l8DllGDKBVKWpvmjp/xvwLAPM8CRTTuuklyGbKdQ==
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4711791c66fmr6641235e9.28.1760634233415; 
 Thu, 16 Oct 2025 10:03:53 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f975sm37207035e9.4.2025.10.16.10.03.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 10:03:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts: clean up meson-buildoptions.py
Date: Thu, 16 Oct 2025 19:03:52 +0200
Message-ID: <20251016170352.1362765-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix a few issues reported by flake8 and pylint, mostly parameter names
that shadow globals.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.py | 51 +++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index a3e22471b2f..e636d258e8a 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -111,13 +111,13 @@ def help_line(left, opt, indent, long):
     right = f'{opt["description"]}'
     if long:
         value = get_help(opt)
-        if value != "auto" and value != "":
+        if value not in {"", "auto"}:
             right += f" [{value}]"
     if "choices" in opt and long:
         choices = "/".join(sorted(opt["choices"]))
         right += f" (choices: {choices})"
-    for x in wrap("  " + left, right, indent):
-        sh_print(x)
+    for line in wrap("  " + left, right, indent):
+        sh_print(line)
 
 
 # Return whether the option (a dictionary) can be used with
@@ -144,18 +144,18 @@ def require_arg(opt):
     return not ({"enabled", "disabled"}.intersection(opt["choices"]))
 
 
-def filter_options(json):
-    if ":" in json["name"]:
+def filter_options(opt):
+    if ":" in opt["name"]:
         return False
-    if json["section"] == "user":
-        return json["name"] not in SKIP_OPTIONS
+    if opt["section"] == "user":
+        return opt["name"] not in SKIP_OPTIONS
     else:
-        return json["name"] in BUILTIN_OPTIONS
+        return opt["name"] in BUILTIN_OPTIONS
 
 
-def load_options(json):
-    json = [x for x in json if filter_options(x)]
-    return sorted(json, key=lambda x: x["name"])
+def load_options(opts):
+    opts = [opt for opt in opts if filter_options(opt)]
+    return sorted(opts, key=lambda opt: opt["name"])
 
 
 def cli_option(opt):
@@ -223,7 +223,7 @@ def print_parse(options):
         key = cli_option(opt)
         name = opt["name"]
         if require_arg(opt):
-            if opt["type"] == "array" and not "choices" in opt:
+            if opt["type"] == "array" and "choices" not in opt:
                 print(f'    --{key}=*) quote_sh "-D{name}=$(meson_option_build_array $2)" ;;')
             else:
                 print(f'    --{key}=*) quote_sh "-D{name}=$2" ;;')
@@ -241,14 +241,19 @@ def print_parse(options):
     print("  esac")
     print("}")
 
-json_data = sys.stdin.read()
-try:
-    options = load_options(json.loads(json_data))
-except:
-    print("Failure in scripts/meson-buildoptions.py parsing stdin as json",
-          file=sys.stderr)
-    print(json_data, file=sys.stderr)
-    sys.exit(1)
-print("# This file is generated by meson-buildoptions.py, do not edit!")
-print_help(options)
-print_parse(options)
+
+def main():
+    json_data = sys.stdin.read()
+    try:
+        options = load_options(json.loads(json_data))
+    except:
+        print("Failure in scripts/meson-buildoptions.py parsing stdin as json",
+              file=sys.stderr)
+        print(json_data, file=sys.stderr)
+        sys.exit(1)
+    print("# This file is generated by meson-buildoptions.py, do not edit!")
+    print_help(options)
+    print_parse(options)
+
+
+sys.exit(main())
-- 
2.51.0


