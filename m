Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C2EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2o5N-0006vB-6y; Fri, 03 May 2024 04:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2o5L-0006ue-L4
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2o5K-0001oq-1F
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714724160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8tB0gTeBF4T6NHgrx9IThCuxvUNSGJ85rNILS4aWVc=;
 b=HuskPC3cWppnr2c6Dh6WSjchP9QiuARQkbIfbHjeKS8imwBF52JU587Bguajx6AHtzpL4v
 /KyrfB0it01k9Il+cpdC8BqUKtho5O7Ylpa1wL2HoToLEITyt9DnDoT9cDYrvEAynyfXtq
 3cWSt7k8s/Pjty/Ij+DLFeffzvlE+IE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-Ibr9f9MMMdqfx1dVgrzIsA-1; Fri, 03 May 2024 04:15:59 -0400
X-MC-Unique: Ibr9f9MMMdqfx1dVgrzIsA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41aa1bbddadso35579905e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714724157; x=1715328957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8tB0gTeBF4T6NHgrx9IThCuxvUNSGJ85rNILS4aWVc=;
 b=CakyV4ID0vNOG3/dmWBr2iMLMI1HXZ6Xo2aN/3LWUpH+RBshek4tqoxWKjdvPZXCDP
 3WDwVFdtFXk/iTUXIvarxT7R5in8M2IJUQYdu3KRvnwh9x7QdgwfjMcATnoCO/Vuf2aD
 MntHmCwnATrVKHbhDufcZzR6/Mt2oyxQDUmCcjpuVBlQwwX2vkqiOdPGzWyjPFhu67CC
 uCG9WWODgahUAPc6Esz+4eTA1AWR1Na1MDCF28e0Dd8jZLspsKtUkQs8OL+kxk0lRht/
 bUmWtC/IyxA/xfVr1e+jxJ49Cu21LgSmKcLE9N3prccdxO2W+u4JdOiUquDcAUzfKBT+
 qlxQ==
X-Gm-Message-State: AOJu0YzhBSgP68rxH4lrWonZ6OFsUXmsGRJINPDjrdyYXxZPxsWlJN2g
 PC6GEBKcJrwddVOggpsGCQFLVJypoCj07ezA5rZPdBToz5CE/2Fcvul+kILPCESzZDKkNRrbNvX
 eJVkIPRg8X7t7gaREn5azGh9+E3KE9t+dyCVkAnZY7H47i/dgX6NnQNOeeynizvFgAIXnpCl22b
 4EFEVB6B0q/51W8/2Y4kTaJjY0i0iNS1Xni5jlFQ==
X-Received: by 2002:a05:600c:5122:b0:418:d2c5:5c65 with SMTP id
 o34-20020a05600c512200b00418d2c55c65mr1806617wms.37.1714724157500; 
 Fri, 03 May 2024 01:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5iInSFaivrVGU8yyhy6W5FI1KUmufyZy/dEv2HCsF9wP1PlCmBEusLM3KczUAgJV92xejtV4C/SckaLeLpEo=
X-Received: by 2002:a05:600c:5122:b0:418:d2c5:5c65 with SMTP id
 o34-20020a05600c512200b00418d2c55c65mr1806602wms.37.1714724157079; Fri, 03
 May 2024 01:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240423131612.28362-1-pbonzini@redhat.com>
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 3 May 2024 10:15:45 +0200
Message-ID: <CABgObfYqtKjtHOfRFSeKGXk1KdE5u8AnkiTkLAPLMu5-02x87Q@mail.gmail.com>
Subject: Re: [PATCH 00/22] configs: switch boards to "default y"
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

On Tue, Apr 23, 2024 at 3:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Some boards, notably ARM boards that use TCG, are already using
> "default y".  This was done to remove TCG-only boards from
> a KVM-only build in commit 29d9efca16 (2023-04-26).
>
> This series converts all other boards to that, so that the requirements
> of each board are clearer in the Kconfig files.
>
> For now, the only such use is MIPS's 64-bit and endianness requirements.
> In the future, it will be possible to enable/disable boards based
> on the presence of required libraries, for example libfdt, or
> their deprecation status.
>
> There is an important difference in that Kconfig symbols for boards
> have to be enabled in a --without-default-devices build, similar to
> devices.

Running CI shows that some targets now pass build-without-defaults and
some don't.

I'm going to squash in changes to each individual patch, resulting in
the following diff:

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 6394b8f41e4..e9402a68a79 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,6 +648,9 @@ build-tci:
     - make check-tcg

 # Check our reduced build configurations
+# requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblaze=
el,
+#   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
+# does not build without boards: i386, loongarch64, s390x, sh4, sh4eb, x86=
_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -661,8 +664,10 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: avr-softmmu s390x-softmmu sh4-softmmu
-      sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
+    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-soft=
mmu
+      mips-softmmu mips64-softmmu mipsel-softmmu sparc-softmmu
+      sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
+      hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check

 build-libvhost-user:

Let me know if you'd prefer me to post a v2.

Paolo


