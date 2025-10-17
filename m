Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA87CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lCt-0004rx-23; Fri, 17 Oct 2025 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCq-0004qW-T3
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCW-0005kJ-2T
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471076f819bso16193715e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710377; x=1761315177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gteGWnMF2R6W+vB6CRlq0+Co1hdivkhTuMvbx2i6MfQ=;
 b=SeyaaAYLKdGyG4AHtrYzrljWxnQUnkuixI1lKpJZgiXVUmHgUpw0oYOk/u8bOQtqMo
 t5xyDSuxmY6SLieSrgNrwwhdFiry68oIQv3clDjnxOpXgOsubyvigGsNVh7bjv0/G619
 1g70lPDy+OltEt6jGh9TPqgP+7QSGYL9RCmteelQ9JujBQMGgYOUL0HI7zlmjIK2PC/m
 ideCrCNwvIJPs4lfHQN7awQS6ZABlhTXedj3pWP8tB4iaUsT+hJks20lCFmdUngWb/Uu
 cDQ/+8mXdt/J+qWLyI4i1frCcuGSATjxmr13srZVWW/PlzXPp97psCXuhaLnJycABQzx
 pgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710377; x=1761315177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gteGWnMF2R6W+vB6CRlq0+Co1hdivkhTuMvbx2i6MfQ=;
 b=Ae+7VdojHkhfEpsEgvPI+sYiKuSFk3ITEYgQO1UYShWpqwb1wcX8Cd8RWqwD5axeAp
 bDA8pbgqlpCGGcYZyWEeaWwC1obm7IhkdUDrZ2nXITBHT/u4jrE8WZxGCnA8OSIFRjPX
 BTXgQS0HwlaWR/Vu99Acyy//i6xqAcPpXjyNsUMopgQUCefNzP3r9K4RkPr0eqr2sKO+
 uOTFr34XEvozyiRg2GEyx8mDwqTkGzqfDdYhafQJrYPq65ygNCZlHB46Ld+A1dHas+A6
 4S1a+CHZ5Qygp2XtnrHXVNT7GI54a7yXywtYjE5JdJjrMenJjkgCgrUYmtqV2zHgeyp6
 wEnw==
X-Gm-Message-State: AOJu0YzwfUsJw5yY1fl2tKvxv4nYn6wDx8x8JreeNnYWo1ceZqrco3iU
 FsJlrAZh4ZPJrk+TG2kQ+moDNs5Nod0v9Jk5CviaYam7TlVkWNKXZrwkgyWGQw==
X-Gm-Gg: ASbGnct0LNx2VUm7W4r0V8n8LFGU3mKmYnGC9XOUlg6z5yIirlL8xIt6NLGj+dT1lc4
 xB9+p2kiLh2FhyDEOMlk7OyKVe30iHV/L7DG9rn64dF6fhjjud5/fmHiHVH85XL7UzAbTmf54dw
 QAF3Qqm0NeaAoUXf9vH4p/onX7qCFQp0tCpVLRQM2WY97/9XrCXC6cHyWH58O3/VKJ+C5Q5YOnm
 NRnyhoVBInon3T8IQwnDmslsxtq1gOF8alw5D8AFT4y+4pFy7tL+sNPY/8dVsrC3WYKgbzFBt9f
 9rTtFE6ort+mvCxZwpmXQKoB9sU/rz60uQwC3LXT8MZRprBaIlY+9Ny6w6krzs7wBTA5jir326b
 8e479dDZOtb62ocfpectjMyYBYjoNvI7a/ekjKJXteEel26hmqDw3f3o7yzBaeB+QnkYIf0Muzf
 qwHvPJ1DuNiNFbt8JU9/mnCetDyfbmCGKYsziRHsf5PJQ=
X-Google-Smtp-Source: AGHT+IF0gmmFJZZWMtm31nH8oxPWJUvDxjlKcg/T2Pi9eXPhQiM4NczNuxSbXUqG5YCCifXib1OY9A==
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4711791934dmr28602455e9.30.1760710376471; 
 Fri, 17 Oct 2025 07:12:56 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 10/11] hw/i386/x86-cpu: Remove now unused
 cpu_get_current_apic()
Date: Fri, 17 Oct 2025 16:11:16 +0200
Message-ID: <20251017141117.105944-11-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017141117.105944-1-shentey@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

No users are left for cpu_get_current_apic(), so remove it.

As a further benefit, it removes one use of the `current_cpu` global.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/apic.h |  3 ---
 hw/i386/x86-cpu.c      | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index 6a0933f401..1b0b26e4c5 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -23,7 +23,4 @@ int apic_msr_read(APICCommonState *s, int index, uint64_t *val);
 int apic_msr_write(APICCommonState *s, int index, uint64_t val);
 bool is_x2apic_mode(APICCommonState *s);
 
-/* pc.c */
-APICCommonState *cpu_get_current_apic(void);
-
 #endif
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 1a86a853d5..86a57c685b 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -85,13 +85,3 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     intno = pic_read_irq(isa_pic);
     return intno;
 }
-
-APICCommonState *cpu_get_current_apic(void)
-{
-    if (current_cpu) {
-        X86CPU *cpu = X86_CPU(current_cpu);
-        return cpu->apic_state;
-    } else {
-        return NULL;
-    }
-}
-- 
2.51.1.dirty


