Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44CFD5D687
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98b2-0001ao-0x; Thu, 07 Nov 2024 14:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FhstZwYKCkEwlwxvujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--titusr.bounces.google.com>)
 id 1t98ax-0001VI-8j
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:07 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FhstZwYKCkEwlwxvujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--titusr.bounces.google.com>)
 id 1t98at-0003L7-RH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:06 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e02fff66a83so2308645276.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009302; x=1731614102; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Dhx3Bv91IwsNiKrqW6EopdF6ygF7pLBG+NH0I9FnnMU=;
 b=HJOq6v5rhqbMrcftI+/LxDpc/WkswW27a69yG2M7nZz6OT0iG2Fcghlv3gPFVjQr3z
 1HNV4wvzOms03U5fvZ/i6GQlAL/Pn7sUjpEGvhtXfQxErjHXZD7s4/IxUE3VdJNG+8+J
 gttdY/1hSxQlIr4objVtIODodZSwZn6NPCgUoncVn6KcfZiKtNazC1MC/47wjDUWwhW1
 eJCoUwVuPv4ehiBASv2PC3i4AK1hhMCYlKbsc0Q/ixvjFhn2t3j4EWfh8r2Oah9mZIDK
 6dFsO0p7LyBqYwmV+ESDnNGEMdRZAeoiR5JSB94Eta9OaNjqLjz4tOMHr0HS2tjlAZ/z
 fcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009302; x=1731614102;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Dhx3Bv91IwsNiKrqW6EopdF6ygF7pLBG+NH0I9FnnMU=;
 b=uxaC8iDK7cy7y5PUpdOQChqBVxAXJjor2EGRrvCpOh5PKP5oMjcsjzO/fd9zIGp48Q
 GEugi6So/q4sjcbtfaRNSxxpyGHWjCET06lsy+m8Tlu0HuhjLHTGMSZZ1fSdduDRopQf
 fdFTIG9jefhjSvIHcdMrLFLtovQ8tuDpvw3WH/EPadSbdvUCVyM7qawxW12TscwYevxo
 XIGaxSsz5KvB3nwbLOK5JIejlxB8SgEJud3Hz8cikMIONGUwUD+KbxGkWhIj5qlbJt/c
 fYbYmnMicDAxsjqAfgwrSa0Ha/ZPJI8qbhM3qQOlf0GAQxgX+34efAE+9pdVOECDQwmJ
 LjfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmf+exFdEpBwqFP72sHnizfMGPlMWxmgqjLksdpLOHLOMymJ1El/fNDISMe7prmyAGDtcoxvw/djax@nongnu.org
X-Gm-Message-State: AOJu0YwVbuV4ydTXrs/tiC3Kx4cbewTGpcicWuYrH/7A+8z2yY49bLku
 iRfgePd24h2kT7cw2IllybQ2ihgwrEE21TD7clN9cQqvy2pg+cIWydp5JPbnjmJdarxS8qSEbIK
 gTg==
X-Google-Smtp-Source: AGHT+IEmlFuTkhdwv2WvBWxO94zsQ4xYCaZCgfhNKEGamC4qH1sUe3agkHFV+x8p66IVVRphgRWtEAm1cNo=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a25:aac4:0:b0:e2b:da82:f695 with
 SMTP id
 3f1490d57ef6-e337f8c1754mr158276.6.1731009302052; Thu, 07 Nov 2024 11:55:02
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:51 +0000
In-Reply-To: <20241107195453.2684138-1-titusr@google.com>
Mime-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-5-titusr@google.com>
Subject: [PATCH 4/6] hw/i2c: add canonical path to i2c event traces
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3FhstZwYKCkEwlwxvujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--titusr.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/core.c       | 8 +++++---
 hw/i2c/trace-events | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4cf30b2c86..d238311776 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -161,7 +161,8 @@ static int i2c_do_start_transfer(I2CBus *bus, uint8_t a=
ddress,
            start condition.  */
=20
         if (sc->event) {
-            trace_i2c_event(event =3D=3D I2C_START_SEND ? "start" : "start=
_async",
+            trace_i2c_event(DEVICE(s)->canonical_path,
+                            event =3D=3D I2C_START_SEND ? "start" : "start=
_async",
                             s->address);
             rv =3D sc->event(s, event);
             if (rv && !bus->broadcast) {
@@ -244,7 +245,7 @@ void i2c_end_transfer(I2CBus *bus)
         I2CSlave *s =3D node->elt;
         sc =3D I2C_SLAVE_GET_CLASS(s);
         if (sc->event) {
-            trace_i2c_event("finish", s->address);
+            trace_i2c_event(DEVICE(s)->canonical_path, "finish", s->addres=
s);
             sc->event(s, I2C_FINISH);
         }
         QLIST_REMOVE(node, next);
@@ -321,7 +322,8 @@ void i2c_nack(I2CBus *bus)
     QLIST_FOREACH(node, &bus->current_devs, next) {
         sc =3D I2C_SLAVE_GET_CLASS(node->elt);
         if (sc->event) {
-            trace_i2c_event("nack", node->elt->address);
+            trace_i2c_event(DEVICE(node->elt)->canonical_path,
+                            "nack", node->elt->address);
             sc->event(node->elt, I2C_NACK);
         }
     }
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index f708a7ace1..e5f2dc643e 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -9,7 +9,7 @@ bitbang_i2c_data(unsigned clk, unsigned dat, unsigned old_o=
ut, unsigned new_out)
=20
 # core.c
=20
-i2c_event(const char *event, uint8_t address) "%s(addr:0x%02x)"
+i2c_event(const char *id, const char *event, uint8_t address) "%s: %s(addr=
:0x%02x)"
 i2c_send(uint8_t address, uint8_t data) "send(addr:0x%02x) data:0x%02x"
 i2c_send_async(uint8_t address, uint8_t data) "send_async(addr:0x%02x) dat=
a:0x%02x"
 i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
--=20
2.47.0.277.g8800431eea-goog


