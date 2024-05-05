Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCFDC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 19:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3hib-0006zw-TL; Sun, 05 May 2024 15:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shum.sdl@nppct.ru>) id 1s3g91-0001Kp-IS
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:59:27 -0400
Received: from mail.nppct.ru ([195.133.245.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shum.sdl@nppct.ru>) id 1s3g8w-00015b-Dl
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:59:27 -0400
Received: from mail.nppct.ru (localhost [127.0.0.1])
 by mail.nppct.ru (Postfix) with ESMTP id BAB491C21EE
 for <qemu-devel@nongnu.org>; Sun,  5 May 2024 20:59:05 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
 subject:subject:from:from:to:content-language:user-agent
 :mime-version:date:date:message-id:content-type:content-type; s=
 dkim; t=1714931940; x=1715795941; bh=HOnnFmCGWnyDiLRNiOX1E6aIF9V
 xjlASbO8gZu593GY=; b=g59hJPApxbCrKKa0hp0wvWQRcyE6UQs3WP5YpWMGAyP
 pz7svs/xd/FotQiYDFqqghHNN1oGmiILb4vj4nQXi8ufgT0XCZkpr/5aq4GzR19f
 SbKx9wBHPZu4pb92P5pibBlFpR+fNRQoUx3TVAwS8VuzsdYNFI/KVA0FnUV8PQRc
 =
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
 by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UJM-yckjos70 for <qemu-devel@nongnu.org>;
 Sun,  5 May 2024 20:59:00 +0300 (MSK)
Received: from [10.66.66.2] (unknown [176.222.55.70])
 by mail.nppct.ru (Postfix) with ESMTPSA id E0ADF1C21CA;
 Sun,  5 May 2024 20:58:59 +0300 (MSK)
Content-Type: multipart/alternative;
 boundary="------------HgWSsB0QfRhUjR1G53jvsJpC"
Message-ID: <a4cbfe6c-27d6-4df0-ae31-db0d60d88f9e@nppct.ru>
Date: Sun, 5 May 2024 20:58:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
To: qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
From: Andrey Shumilin <shum.sdl@nppct.ru>
Subject: [sdl-qemu] [PATCH v1] /hw/intc/arm_gic WRONG ARGUMENTS
Received-SPF: pass client-ip=195.133.245.4; envelope-from=shum.sdl@nppct.ru;
 helo=mail.nppct.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 05 May 2024 15:40:12 -0400
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

This is a multi-part message in MIME format.
--------------HgWSsB0QfRhUjR1G53jvsJpC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 1. Possibly mismatched call arguments in function 'gic_apr_ns_view':
    'cpu' and 'regno' passed in place of 'int regno' and 'int cpu'.
 2. Possibly mismatched call arguments in function
    'gic_apr_write_ns_view': 'cpu' and 'regno' passed in place of 'int
    regno' and 'int cpu'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

From 23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00 2001

From: Andrey Shumilin <shum.sdl@nppct.ru>
Date: Sun, 5 May 2024 20:13:40 +0300
Subject: [PATCH] Patch hw/intc/arm_gic.c

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
  hw/intc/arm_gic.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 7a34bc0998..47f01e45e3 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int 
cpu, int offset,
              *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
          } else if (gic_cpu_ns_access(s, cpu, attrs)) {
              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            *data = gic_apr_ns_view(s, regno, cpu);
+            *data = gic_apr_ns_view(s, cpu, regno);
          } else {
              *data = s->apr[regno][cpu];
          }
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int 
cpu, int offset,
              s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
          } else if (gic_cpu_ns_access(s, cpu, attrs)) {
              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            gic_apr_write_ns_view(s, regno, cpu, value);
+            gic_apr_write_ns_view(s, cpu, regno, value);
          } else {
              s->apr[regno][cpu] = value;
          }
--------------HgWSsB0QfRhUjR1G53jvsJpC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <ol>
      <li><span
style="color: rgb(246, 247, 249); font-family: Sergoe-UI; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(47, 52, 60); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Possibly
          mismatched call arguments in function 'gic_apr_ns_view': 'cpu'
          and 'regno' passed in place of 'int regno' and 'int cpu'. </span></li>
      <li><span
style="color: rgb(246, 247, 249); font-family: Sergoe-UI; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(47, 52, 60); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Possibly
          mismatched call arguments in function 'gic_apr_write_ns_view':
          'cpu' and 'regno' passed in place of 'int regno' and 'int
          cpu'.</span></li>
    </ol>
    <pre class="moz-quote-pre" wrap="">Found by Linux Verification Center (linuxtesting.org) with SVACE.
</pre>
    <p></p>
    <p><span
style="color: rgb(246, 247, 249); font-family: Sergoe-UI; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(47, 52, 60); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">From
        23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00
        2001</span></p>
    <p><span
style="color: rgb(246, 247, 249); font-family: Sergoe-UI; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(47, 52, 60); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span></p>
    <span
style="color: rgb(246, 247, 249); font-family: Sergoe-UI; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(47, 52, 60); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">From:
      Andrey Shumilin <a class="moz-txt-link-rfc2396E" href="mailto:shum.sdl@nppct.ru">&lt;shum.sdl@nppct.ru&gt;</a><br>
      Date: Sun, 5 May 2024 20:13:40 +0300<br>
      Subject: [PATCH] Patch hw/intc/arm_gic.c<br>
      <br>
      Signed-off-by: Andrey Shumilin <a class="moz-txt-link-rfc2396E" href="mailto:shum.sdl@nppct.ru">&lt;shum.sdl@nppct.ru&gt;</a><br>
      ---<br>
       hw/intc/arm_gic.c | 4 ++--<br>
       1 file changed, 2 insertions(+), 2 deletions(-)<br>
      <br>
      diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c<br>
      index 7a34bc0998..47f01e45e3 100644<br>
      --- a/hw/intc/arm_gic.c<br>
      +++ b/hw/intc/arm_gic.c<br>
      @@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s,
      int cpu, int offset,<br>
                   *data = s-&gt;h_apr[gic_get_vcpu_real_id(cpu)];<br>
               } else if (gic_cpu_ns_access(s, cpu, attrs)) {<br>
                   /* NS view of GICC_APR&lt;n&gt; is the top half of
      GIC_NSAPR&lt;n&gt; */<br>
      -            *data = gic_apr_ns_view(s, regno, cpu);<br>
      +            *data = gic_apr_ns_view(s, cpu, regno);<br>
               } else {<br>
                   *data = s-&gt;apr[regno][cpu];<br>
               }<br>
      @@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState
      *s, int cpu, int offset,<br>
                   s-&gt;h_apr[gic_get_vcpu_real_id(cpu)] = value;<br>
               } else if (gic_cpu_ns_access(s, cpu, attrs)) {<br>
                   /* NS view of GICC_APR&lt;n&gt; is the top half of
      GIC_NSAPR&lt;n&gt; */<br>
      -            gic_apr_write_ns_view(s, regno, cpu, value);<br>
      +            gic_apr_write_ns_view(s, cpu, regno, value);<br>
               } else {<br>
                   s-&gt;apr[regno][cpu] = value;<br>
               }<br>
    </span>
  </body>
</html>

--------------HgWSsB0QfRhUjR1G53jvsJpC--

