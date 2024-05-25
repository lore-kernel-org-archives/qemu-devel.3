Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD085C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApev-0002KG-Kz; Sat, 25 May 2024 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApet-0002JQ-Hk
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApej-0003xh-3u
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FM19mLkY5Da4/5rzgrlyeYl8tkvhtaXzdU7oyrzvNEY=;
 b=Ut+3usvuthbcpKpz0SDdWGIBR9SajZ9rBc6X+ocwx+MuG5kBXJpFYeeQJYLt3rFZrGS0cR
 TUY+nu2w785j+7eeMdIvzp9bhQpvPNLSBa9meDzVdJWnOy51od4HOgao9CYEWCEkLRKjPO
 7KSLLwwhD6Df44Es+pwkv8jjOWFPClc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-aAv6PdqIPfmPj1zekouzEg-1; Sat, 25 May 2024 07:33:42 -0400
X-MC-Unique: aAv6PdqIPfmPj1zekouzEg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5295f0125dbso1143668e87.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636820; x=1717241620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FM19mLkY5Da4/5rzgrlyeYl8tkvhtaXzdU7oyrzvNEY=;
 b=Mbh7TF2xZIx9SNdoeVlM5oGn7XrmSeDBVvBBQcTtTIBqilz1mqW9IyedyFx34PR6Tj
 sVT6J39tJmRFWVErmEiXlN3NaNVxE7YJjDDyo+80AW0GnDcoGTP3cgf2ur67qpOFUR81
 80e/7L5jsdWwAsS26vKHfBA7zmvnEsimQVnRuNicrzFwwrce7Yx3yy8LGGZ8k5kMLaqx
 Q+joHYnaCWHw97TwX6dY8+6AOFabhMbXh6bOomeRPUxCpn5i7QMoWbJwGdsGu9Hc2d/o
 szGimWKIpfQrx5D01lXQrB0mTYYJdvQVZ+rsF76c6eJzMa80y09MpVsJeFxBWVYoQ1Ps
 AMwA==
X-Gm-Message-State: AOJu0YyFBtZs376fIocrQ3H/QWnrBE0If4prdJp9YKrx+opaheLUJYmq
 lFFBH9n3jJsOZhjACJZb9+pdj/geQGgNjqa9CwlFxvF7HjebpvxPQZB8WHaxZVVP+C0YBM5oXGq
 SetrfTM6B/MuYiFFkOMcwXZTajhkk0gcdk+B2Tl8x0nkE4CrgphDB+WeJvvSznjBN+P9+dCXWcF
 nhZGMD2fR94dJ0ERS9tpi688vL18gdzR/wRVwA
X-Received: by 2002:ac2:4244:0:b0:518:b4a3:dee1 with SMTP id
 2adb3069b0e04-52966ca87demr2481507e87.66.1716636820242; 
 Sat, 25 May 2024 04:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlTlIh42wrajgeOh7+zLUcGJI0oVL98sQBl1zvDxO3oQwK1yaqpb9w6+xIXneF3hIJIhT1ug==
X-Received: by 2002:ac2:4244:0:b0:518:b4a3:dee1 with SMTP id
 2adb3069b0e04-52966ca87demr2481491e87.66.1716636819591; 
 Sat, 25 May 2024 04:33:39 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578523c885bsm3059031a12.34.2024.05.25.04.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Subject: [PULL 01/24] configure: move -mcx16 flag out of CPU_CFLAGS
Date: Sat, 25 May 2024 13:33:09 +0200
Message-ID: <20240525113332.1404158-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Artyom Kunakovsky <artyomkunakovsky@gmail.com>

The point of CPU_CFLAGS is really just to select the appropriate multilib,
for example for library linking tests, and -mcx16 is not needed for
that purpose.

Furthermore, if -mcx16 is part of QEMU's choice of a basic x86_64
instruction set, it should be applied to cross-compiled x86_64 code too;
it is plausible that tests/tcg would want to cover cmpxchg16b as well,
for example.  In the end this makes just as much sense as a per sub-build
tweak, so move the flag to meson.build and cross_cc_cflags_x86_64.

This leaves out contrib/plugins, which would fail when attempting to use
__sync_val_compare_and_swap_16 (note it does not do yet); while minor,
this *is* a disadvantage of this change.  But building contrib/plugins
with a Makefile instead of meson.build is something self-inflicted just
for the sake of showing that it can be done, and if this kind of papercut
started becoming a problem we could make the directory part of the meson
build.  Until then, we can live with the limitation.

Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Message-ID: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
[rewrite commit message, remove from configure. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 7 ++-----
 meson.build | 7 +++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 38ee2577013..4d01a42ba65 100755
--- a/configure
+++ b/configure
@@ -512,10 +512,7 @@ case "$cpu" in
     cpu="x86_64"
     host_arch=x86_64
     linux_arch=x86
-    # ??? Only extremely old AMD cpus do not have cmpxchg16b.
-    # If we truly care, we should simply detect this case at
-    # runtime and generate the fallback to serial emulation.
-    CPU_CFLAGS="-m64 -mcx16"
+    CPU_CFLAGS="-m64"
     ;;
 esac
 
@@ -1203,7 +1200,7 @@ fi
 : ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
 : ${cross_cc_sparc="$cross_cc_sparc64"}
 : ${cross_cc_cflags_sparc="-m32 -mcpu=supersparc"}
-: ${cross_cc_cflags_x86_64="-m64"}
+: ${cross_cc_cflags_x86_64="-m64 -mcx16"}
 
 compute_target_variable() {
   eval "$2="
diff --git a/meson.build b/meson.build
index a9de71d4506..7fd82b5f48c 100644
--- a/meson.build
+++ b/meson.build
@@ -336,6 +336,13 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
+# ??? Only extremely old AMD cpus do not have cmpxchg16b.
+# If we truly care, we should simply detect this case at
+# runtime and generate the fallback to serial emulation.
+if host_arch == 'x86_64'
+  qemu_common_flags = ['-mcx16'] + qemu_common_flags
+endif
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
-- 
2.45.1


