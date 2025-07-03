Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1C3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHKr-0003eG-F7; Thu, 03 Jul 2025 06:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXHKi-0003cp-42
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:38:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXHKf-00026l-Vs
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:38:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45310223677so38195085e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751539099; x=1752143899; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Eg664RzsW8Nthajch6vXfVX4km0MVRqG3Ldn6noIFpE=;
 b=BZ4pB7hzD2Fdku0fewN896NR7Ejzn58aPaSTJyDASf5iH1sDE9zN47coRTne4s7p1j
 EGX75aQqo6RXeoTAdOC+UHjPHdE2Mu4OYUb0PK5EYg9JkuiG9Eklqu6qhjvAu1HOh0qw
 cT9NPnNFA19fNiav86KUco03UV2OAzqYIMDKfS2FVhiu4pdVGGiXpNTiszwaP4VSp3Mk
 UeSmEqlgWWreq1jOtG04oxaZuBWhbYUbzxwMGOzjCLXkOxZNYI1au334dERBHuJtf5uC
 N08e4So9akpjkHBK/XMkCK/D4Bvd9jKrgiN2y10MqJnMfsilingvsewMlQvQDt1P9w0Z
 X9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751539099; x=1752143899;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eg664RzsW8Nthajch6vXfVX4km0MVRqG3Ldn6noIFpE=;
 b=vnZUly5WZmk34pyMZ9gGFlUKtKvmDieT4XJF8LdCQVtxfMpxAClqs+0GBUmZ0OcbhK
 goISDaBuU96g58LkRFFpv8aJt2Ajkg5GLI4/UIwZRsBa0aYyzYhde0kWKrOdBCw6UhBe
 Ap/bA7coZUwlT055BblKmQ/8CDJsa3RCc6RnRxlfqLP8FFQWRMJReuB8QVed4GMJoBfU
 hO9vTwoc9NQhEWpDGJ+/m/Y65ZK2TokdYAIx2Hu4l0UOZGUdz6EmAKN6r5/dsS9MG4Kq
 jlhCRAntbHeM547TvoWVfU7wtBofqTllBCzPEQD1LAVx2TkqjxMf7rEiHeT3aWMHrE++
 o2rg==
X-Gm-Message-State: AOJu0YzZyUXGaq7tueu+O4zW+7pB2FuUUFLh9rl/Cfr+bTTQ9RDwfa7x
 pecgL+2+TnqgoqowV3XmMJTe03B/glZPhpD4qG2i65D7Ej6vEd7Z+CDs8ZerjxzKFoM=
X-Gm-Gg: ASbGncthMUXUmYlonSozGP2uOT7CA+xS0s2kARWfCU5Pe2GQwXgLMAdVahY8fnT/C1o
 GuvNpV1I0+36dWrf10UcmUQQz8D5/9/Ndqan41NfQB+h20x3NQmTg+kH3WdMT+uvZO4ZQdKaMro
 8kK+GoypSWPjOdHsV1qdsmK/QcSfOGmMTOQyr0kBAL/aQEjJphAd9Zpu2C3Lim4MnlxdmuWFK6V
 1/hMvUEP1Py1GM3UkYdL+IzlkvG0W57dYyvtGH8o9Zm3y1fH3FTKvy1VevOpipEisBR/Ittm/nN
 9gWpTItlM6z/3/PbzNMYYDgQIy3EeWCgnymEYp8YGrOkCT3AjAOnK4otDs4KMLeZRRK1rPASVxH
 6ueewYykM6yOIOtSSh5HGNzphzv19hO4=
X-Google-Smtp-Source: AGHT+IEOGBtEl4au624bm+EC0zgky/1ZQOLteHGbuJR3SSIGutCIb6Hkd1ds27FPxukovrJOfhE/Mg==
X-Received: by 2002:a05:600c:1549:b0:453:6146:1172 with SMTP id
 5b1f17b1804b1-454a36d8d1amr75009435e9.3.1751539098649; 
 Thu, 03 Jul 2025 03:38:18 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa5easm17969411f8f.26.2025.07.03.03.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 03:38:18 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 03 Jul 2025 13:38:01 +0300
Subject: [PATCH] docs: use :kbd: role in sphinx docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-docs_rst_improvements-v1-1-0dbbc5eb5871@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIldZmgC/x3MTQqAIBBA4avErBPM6IeuEiGlU80ijRmJILp70
 vJbvPeAIBMKDMUDjBcJxZBRlQW4fQ4bKvLZYLRpdKdr5aMTy5IsHSfHCw8MSVS1arfUrul630J
 uT8aV7v87Tu/7AVPBSThnAAAA
X-Change-ID: 20250703-docs_rst_improvements-1f0cb3c578d6
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6117;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=o7ayakKm+Q4O4iD+fcAZAm56BuDI7g+NVUEcUR1V6OA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9abDJaM01keVczaVAwNXhZUloyU0VOYUVKeFd0CnVFMWw4TnB4dkt0bWVuUDhy
 dmFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdaZG1RQUt
 DUkIzS2Nkd2YzNEowQW5kRUFDWUJzMGNUaEZwRVlYRXpBTGVvWkcxcGp3Tm56Uk5mOXNDSmJNag
 pVUDVjalFRc3hlcyt3Kzk1dm5TenJwck14WHgxWTg5d0I0bUFqNXRkMTlYWFBsWjFaajg5aUVER
 FV0aGRneUpmClVBcFg5ZEtMOWdvSlNnb2dsZHBZQVFsY0ZIWUJpaUJLT3YrcDdGZitib1JPYUM1
 dmFnNlQvb3BwSjFPQ0dzdmQKY3YrOEFDaVpZNlA4OFZhRWJKanBuQUxoVWFUUCtnYUM0ckV0Qyt
 QdHlJYVlkMTd3M1F4aTVXNXl2dHNKTWJJMgozdktxeHFoUjhsTzA1amxMSTRMbDk5RG9NSytmNl
 Q0ck9pTUk0ck9GUjFOeTk1M1hDR3JQUTAwSEdXTTJGZFNUCjBaZTIrNUJLcUUxVVdSaWVrTkVvS
 VRzVldSdmVwcllpSVh6RUQyak9qWUpBaGh4NDREd3l6clo1Z3pNZVd1STcKbk9SZEc4enNNZTdx
 b2FMUVp5UkcxUzJJbTRlTzMyckdCR05LUGQzazRDWU1LbGc5ekhPd045MURSb1R0eWwxWgppRzB
 TUGFTTkFINjYzYmU4ZUxTTVc3NzRhRkcwaUNZaGZLMUJrbkEvYkVvb1VlTnNXNlg0UFQrd09ZVm
 tpaEs2ClcrVW8vOW85U3dmcGRJTTM1bHJHVXFHQVB6R2VrL0ZLUVNtTkRYRkwxVVpJQUFpK0lVc
 m9YRHVvemY2YlczbjgKc3FLNDhjQkwzZnFqOXJLTW0rdVRzcE9uejlhYlhsUXQwZ2RjTnFmbUtG
 RWdrV0QxblVmbVgxZ0pmSnJkWlBpTApWQzJleE1MeWhkZ3hmbHluNnE2Qmw5ZWlFUWRndUJCYTN
 sZEY0NFhvQm9uWnlCODNheTdlTTV0Vk5obFJQQ0N0CnA3cmMvUT09Cj1TbHNXCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

Sphinx supports the :kbd: role for notating keyboard input. They get
formatted as <kbd> HTML elements in the readthedocs theme we currently
use for Sphinx.

Besides the better visual formatting, it also helps with accessibility
as screen readers can announce the semantics of the <kbd> element to the
user.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/testing/main.rst     |  4 ++--
 docs/system/images.rst          |  2 +-
 docs/system/keys.rst.inc        | 22 +++++++++++-----------
 docs/system/linuxboot.rst       |  2 +-
 docs/system/mux-chardev.rst.inc | 16 ++++++++--------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 6b18ed875cd91e961d07b3afa3179c7fba0e5fe3..2b5cb0c148048e3a81d2db8c4a9500591880997f 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -604,9 +604,9 @@ below steps to debug it:
 2. Add "V=1" to the command line, try again, to see the verbose output.
 3. Further add "DEBUG=1" to the command line. This will pause in a shell prompt
    in the container right before testing starts. You could either manually
-   build QEMU and run tests from there, or press Ctrl-D to let the Docker
+   build QEMU and run tests from there, or press :kbd:`Ctrl+d` to let the Docker
    testing continue.
-4. If you press Ctrl-D, the same building and testing procedure will begin, and
+4. If you press :kbd:`Ctrl+d`, the same building and testing procedure will begin, and
    will hopefully run into the error again. After that, you will be dropped to
    the prompt for debug.
 
diff --git a/docs/system/images.rst b/docs/system/images.rst
index a5551173c9789323ceb150c51fd68c6d4ef80d71..43706969fddae7bcb83de172b1a04b5c6cffe0f1 100644
--- a/docs/system/images.rst
+++ b/docs/system/images.rst
@@ -30,7 +30,7 @@ Snapshot mode
 If you use the option ``-snapshot``, all disk images are considered as
 read only. When sectors in written, they are written in a temporary file
 created in ``/tmp``. You can however force the write back to the raw
-disk images by using the ``commit`` monitor command (or C-a s in the
+disk images by using the ``commit`` monitor command (or :kbd:`Ctrl+a s` in the
 serial console).
 
 .. _vm_005fsnapshots:
diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index 59966a3fe7cf2cbb6a19dacd48612b768b7a1e96..f33f1acd08607c93d2ef250e3ca183f41f237658 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -1,23 +1,23 @@
 During the graphical emulation, you can use special key combinations from
-the following table to change modes. By default the modifier is Ctrl-Alt
+the following table to change modes. By default the modifier is :kbd:`Ctrl+Alt`
 (used in the table below) which can be changed with ``-display`` suboption
 ``mod=`` where appropriate. For example, ``-display sdl,
-grab-mod=lshift-lctrl-lalt`` changes the modifier key to Ctrl-Alt-Shift,
-while ``-display sdl,grab-mod=rctrl`` changes it to the right Ctrl key.
+grab-mod=lshift-lctrl-lalt`` changes the modifier key to :kbd:`Ctrl+Alt+Shift`,
+while ``-display sdl,grab-mod=rctrl`` changes it to the right :kbd:`Ctrl` key.
 
-Ctrl-Alt-f
+:kbd:`Ctrl+Alt+f`
    Toggle full screen
 
-Ctrl-Alt-+
+:kbd:`Ctrl+Alt++`
    Enlarge the screen
 
-Ctrl-Alt\--
+:kbd:`Ctrl+Alt+-`
    Shrink the screen
 
-Ctrl-Alt-u
+:kbd:`Ctrl+Alt+u`
    Restore the screen's un-scaled dimensions
 
-Ctrl-Alt-n
+:kbd:`Ctrl+Alt+n`
    Switch to virtual console 'n'. Standard console mappings are:
 
    *1*
@@ -29,8 +29,8 @@ Ctrl-Alt-n
    *3*
       Serial port
 
-Ctrl-Alt-g
+:kbd:`Ctrl+Alt+g`
    Toggle mouse and keyboard grab.
 
-In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and
-Ctrl-PageDown to move in the back log.
+In the virtual consoles, you can use :kbd:`Ctrl+Up`, :kbd:`Ctrl+Down`, :kbd:`Ctrl+PageUp` and
+:kbd:`Ctrl+PageDown` to move in the back log.
diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index 2328b4a73d55b47d731497d57ddb1a837ef5d7dd..f7573ab80aa269bac870d7e6e5596a8f02fbd5f3 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -26,5 +26,5 @@ virtual serial port and the QEMU monitor to the console with the
    |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw \
                     -append "root=/dev/sda console=ttyS0" -nographic
 
-Use Ctrl-a c to switch between the serial console and the monitor (see
+Use :kbd:`Ctrl+a c` to switch between the serial console and the monitor (see
 :ref:`GUI_keys`).
diff --git a/docs/system/mux-chardev.rst.inc b/docs/system/mux-chardev.rst.inc
index 84ea12cbf58f9550154411f8951e6f608179a091..45d0b2c1d76c382a29076502b4f1234db5e25bb6 100644
--- a/docs/system/mux-chardev.rst.inc
+++ b/docs/system/mux-chardev.rst.inc
@@ -1,27 +1,27 @@
 During emulation, if you are using a character backend multiplexer
 (which is the default if you are using ``-nographic``) then several
 commands are available via an escape sequence. These key sequences all
-start with an escape character, which is Ctrl-a by default, but can be
+start with an escape character, which is :kbd:`Ctrl+a` by default, but can be
 changed with ``-echr``. The list below assumes you're using the default.
 
-Ctrl-a h
+:kbd:`Ctrl+a h`
    Print this help
 
-Ctrl-a x
+:kbd:`Ctrl+a x`
    Exit emulator
 
-Ctrl-a s
+:kbd:`Ctrl+a s`
    Save disk data back to file (if -snapshot)
 
-Ctrl-a t
+:kbd:`Ctrl+a t`
    Toggle console timestamps
 
-Ctrl-a b
+:kbd:`Ctrl+a b`
    Send break (magic sysrq in Linux)
 
-Ctrl-a c
+:kbd:`Ctrl+a c`
    Rotate between the frontends connected to the multiplexer (usually
    this switches between the monitor and the console)
 
-Ctrl-a Ctrl-a
+:kbd:`Ctrl+a Ctrl+a`
    Send the escape character to the frontend

---
base-commit: 7698afc42b5af9e55f12ab2236618e38e5a1c23f
change-id: 20250703-docs_rst_improvements-1f0cb3c578d6

--
γαῖα πυρί μιχθήτω


