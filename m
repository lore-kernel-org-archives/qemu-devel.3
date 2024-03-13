Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EBC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkN5y-0005Am-Lq; Wed, 13 Mar 2024 07:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkN5v-0005AH-KU
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:48:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkN5s-0003Ax-Jm
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:48:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so3052952f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710330503; x=1710935303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+W5Y8RtJa03LAoDXBw+AMMGMfEP05am0MeShuoDySM=;
 b=k7KikW3/Tj+3x/rdUZLwG9kCFNb6hq7qf1l2r0DbYfL1UHDvMOhfNVSy07gBSBg0yn
 oGRXx6cPQF46NjllqD7VeUFSC6qOvLDZO76S3U1s62uY7KjTsDrByoCbf4VUv8HjynR3
 MO2ThUxOZ5BLnvDPOF4xLnpepg8Bnd2xN80ClFHO7xcLs3l3pwX46XbEayaVbniZxQtj
 bpQmKdWKOo4DpYMt6HjCcF8pSKaFUB5TrrciandJpAWli8xp+27P+gSOl5EHMCB2RoAF
 QXd0vpZ5OZdQHeYrRG0DNPZw5aiOXYJTNu6PtctkI62fZmNWaXaFRRdHCpmTbZsILGS8
 JgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710330503; x=1710935303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+W5Y8RtJa03LAoDXBw+AMMGMfEP05am0MeShuoDySM=;
 b=rINsHhPhYWRl8TPo+9KQW9d++7UEgHrL53NtYSH3Yb1QCFTBApodNM0DBAo9lC9ve0
 j0VyxsIYTlRS6/rxdcgr6B7nTEi6yWJxFpvgs/lGutfoq63vBopcwsvCrrwSf8kQUJw1
 ZZajsNT8bi7suDE8lS2QraT4hzmHQGd5NneN3QbEBJ0U04Axzq4C2u3xeBs/kePSYt9Q
 YsowP2LB3LiLHcP3eMo12pSLhqaJAT04bGZieliODBtWaCU1zuce9svf6F9eJgRdLzbG
 WJKYI0qcHk1tg7Vxb3K9/GHHmKB9CsWiSaWxFwZSYpcBCud7wEhMns+e0URqni0Bm3KG
 ZUYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPJfKAaZAWECMVS392LzI66z5Jmx4nwegvs2V2Chke8Tn7OjZpsgiWeHPEL0ZXkNzvadS0JJpHxIhh/DpdS7pqjAU3Rpo=
X-Gm-Message-State: AOJu0YxRzIWtaWmWWK9OfPGne1hR0JWeW1D2WVIgM666/Kv2F++gVEap
 X3vW+tVrDEl743B+gCabBQhz9SFaySRILuyELaoT3+iOuSWSsrspj+I/seTDRWM=
X-Google-Smtp-Source: AGHT+IEyno2MQFRCONdVPXIwZix0JG/J+UiVJ+F0+PEb8PfiftIF4fK4nZ/FwBEvro85IrXER/IYFA==
X-Received: by 2002:adf:e9c8:0:b0:33e:3d71:445f with SMTP id
 l8-20020adfe9c8000000b0033e3d71445fmr1733791wrn.32.1710330503030; 
 Wed, 13 Mar 2024 04:48:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 bo3-20020a056000068300b0033e9d0b3faasm6385589wrb.82.2024.03.13.04.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:48:22 -0700 (PDT)
Message-ID: <9ed09426-d507-4ae4-b04c-4bbf1f083b69@linaro.org>
Date: Wed, 13 Mar 2024 12:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/avocado: update sbsa-ref firmware to latest
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Marcin,

On 13/3/24 11:08, Marcin Juszkiewicz wrote:
> Updating sbsa-ref firmware for QEMU CI was manual task. Now it is
> replaced by CI job run on CodeLinaro Gitlab instance.
> 
> This patchset updates to current state:
> 
> - Trusted Firmware v2.10.2 (latest LTS)
> - Tianocore EDK2 stable202402 (latest release)
> 
> And Tianocore EDK2-platforms commit 085c2fb (edk2-platforms does not
> have releases).
> 
> Firmware images were built using Debian 'bookworm' cross gcc 12.2.0
> compiler.
> 
> And while I am in that file I dropped use of 'virtio-rng-pci' device as
> sbsa-ref is supposed to emulate physical hardware.
> 
> OpenBSD updated to 7.4 version.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
> Marcin Juszkiewicz (3):
>        tests/avocado: update sbsa-ref firmware
>        tests/avocado: drop virtio-rng from sbsa-ref tests
>        tests/avocado: use OpenBSD 7.4 for sbsa-ref

Hmm 'max' is timeouting:

  (1/7) test_sbsaref_edk2_firmware: PASS (9.99 s)
  (2/7) test_sbsaref_alpine_linux_cortex_a57: PASS (54.82 s)
  (3/7) test_sbsaref_alpine_linux_neoverse_n1: PASS (53.09 s)
  (4/7) test_sbsaref_alpine_linux_max: INTERRUPTED: Runner error 
occurred: Timeout reached... (180.51 s)
  (5/7) test_sbsaref_openbsd_cortex_a57: PASS (33.45 s)
  (6/7) test_sbsaref_openbsd_neoverse_n1: PASS (22.15 s)
  (7/7) test_sbsaref_openbsd_max: INTERRUPTED: Runner error occurred: 
Timeout reached... (180.42 s)
RESULTS    : PASS 5 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | 
CANCEL 0
JOB TIME   : 537.48 s

Using impdef pauth ...

-- >8 --
diff --git a/tests/avocado/machine_aarch64_sbsaref.py 
b/tests/avocado/machine_aarch64_sbsaref.py
index 94c9f81d72..d349ce73ae 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -156 +156 @@ def test_sbsaref_alpine_linux_max(self):
-        self.boot_alpine_linux("max")
+        self.boot_alpine_linux("max,pauth-impdef=on")
@@ -201 +201 @@ def test_sbsaref_openbsd_max(self):
-        self.boot_openbsd("max")
+        self.boot_openbsd("max,pauth-impdef=on")
---

... I still get:

  (1/7) test_sbsaref_edk2_firmware: PASS (5.56 s)
  (2/7) test_sbsaref_alpine_linux_cortex_a57: PASS (53.09 s)
  (3/7) test_sbsaref_alpine_linux_neoverse_n1: PASS (53.00 s)
  (4/7) test_sbsaref_alpine_linux_max: PASS (70.99 s)
  (5/7) test_sbsaref_openbsd_cortex_a57: PASS (22.63 s)
  (6/7) test_sbsaref_openbsd_neoverse_n1: PASS (22.56 s)
  (7/7) test_sbsaref_openbsd_max: INTERRUPTED: Timeout reached... (180.43 s)
RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1 | 
CANCEL 0
JOB TIME   : 409.29 s

What about disabling path on openbsd and using @skip tags?

-- >8 --
diff --git a/tests/avocado/machine_aarch64_sbsaref.py 
b/tests/avocado/machine_aarch64_sbsaref.py
index 94c9f81d72..c6ee7332a9 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -142,2 +142,3 @@ def test_sbsaref_alpine_linux_cortex_a57(self):
          :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:linux
          """
@@ -148,2 +149,3 @@ def test_sbsaref_alpine_linux_neoverse_n1(self):
          :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=os:linux
          """
@@ -151,2 +153,17 @@ def test_sbsaref_alpine_linux_neoverse_n1(self):

+    def test_sbsaref_alpine_linux_max_pauth_off(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:linux
+        """
+        self.boot_alpine_linux("max,pauth=off")
+
+    def test_sbsaref_alpine_linux_max_pauth_impdef(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:linux
+        """
+        self.boot_alpine_linux("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might 
timeout')
      def test_sbsaref_alpine_linux_max(self):
@@ -154,2 +171,3 @@ def test_sbsaref_alpine_linux_max(self):
          :avocado: tags=cpu:max
+        :avocado: tags=os:linux
          """
@@ -186,3 +204,4 @@ def test_sbsaref_openbsd_cortex_a57(self):
          """
-        :avocado: tags=cpu:cortex-a57,os:openbsd
+        :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:openbsd
          """
@@ -192,3 +211,4 @@ def test_sbsaref_openbsd_neoverse_n1(self):
          """
-        :avocado: tags=cpu:neoverse-n1,os:openbsd
+        :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=os:openbsd
          """
@@ -196,7 +216,24 @@ def test_sbsaref_openbsd_neoverse_n1(self):

+    def test_sbsaref_openbsd_max_pauth_off(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
+        """
+        self.boot_openbsd("max,pauth=off")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might 
timeout')
+    def test_sbsaref_openbsd_max_pauth_impdef(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
+        """
+        self.boot_openbsd("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might 
timeout')
      def test_sbsaref_openbsd_max(self):
          """
-        :avocado: tags=cpu:max,os:openbsd
+        :avocado: tags=cpu:max
+        :avocado: tags=os:openbsd
          """
-        self.boot_openbsd("max")
+        self.boot_openbsd("max,pauth-impdef=on")

---

However OpenBSD still timeouts at 180s:

  (01/11) test_sbsaref_edk2_firmware: PASS (7.25 s)
  (02/11) test_sbsaref_alpine_linux_cortex_a57: PASS (54.30 s)
  (03/11) test_sbsaref_alpine_linux_neoverse_n1: PASS (52.25 s)
  (04/11) test_sbsaref_alpine_linux_max_pauth_off: PASS (53.31 s)
  (05/11) test_sbsaref_alpine_linux_max_pauth_impdef: PASS (72.72 s)
  (06/11) test_sbsaref_alpine_linux_max: SKIP: Test might timeout
  (07/11) test_sbsaref_openbsd_cortex_a57: PASS (22.37 s)
  (08/11) test_sbsaref_openbsd_neoverse_n1: PASS (22.98 s)
  (09/11) test_sbsaref_openbsd_max_pauth_off: INTERRUPTED: Timeout 
reached... (180.54 s)
  (10/11) test_sbsaref_openbsd_max_pauth_impdef: SKIP: Test might timeout
  (11/11) test_sbsaref_openbsd_max: SKIP: Test might timeout

Regards,

Phil.

