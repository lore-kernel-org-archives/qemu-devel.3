Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73238CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1Iz-0008Jf-EI; Wed, 29 Oct 2025 04:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Ix-0008JL-Rv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:13:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Iq-0004qi-L5
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:13:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso86869245e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761725584; x=1762330384; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R/9s/t1bENeKNi0IR6brXQSJO7uR7qYZrg1UP6diQPQ=;
 b=VcbRcKev4ZmA2BYiVCqYiyEjTO3bMIo8HIT/Q+pJJC0Orn1K3C+yWyDLLnDzEhI+ej
 WpUp1QbFVxmfGEPMMRdNajm4MrZ40Y5a6nu92GFwa8cqDp/Q1LG6YsAX6T6ULBqEWsV3
 9vUafx2kSr/pSNm4acIcKNoqLmN1mgVDlV/oe/P0wuAubW4Sg1iLySHx/7HAeTDEuUyA
 cpMUovjWYuzKUAeeqJPWcHOISGPmYezvdspqcLdeuH30a7+Bme5aaqsR+Cm2BiyKro+g
 MqyqR4Ddw2761QYGy16QnTs95YFtGh/mjzcvFcSv24UL2kFlOrL/NBJVu9IADeG4iJKY
 uW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725584; x=1762330384;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/9s/t1bENeKNi0IR6brXQSJO7uR7qYZrg1UP6diQPQ=;
 b=akujn8SmkHTvxHtdHiG2jy+uTT7MWDIOJy8/Wo0j+7P8KX0I+/inIk4C1TwCsnVH5N
 FqMl1RlW9s1YqsbKf8NEO2FNL0vukkyaxwzJelhN3HSvBsiLRhlIPZhphAWekTnAlRnC
 jbO0HC4wcOQWPOJu9dT95YprAgaQ+esOETIv3qttXY912G9GzjGaudRZCCxi8G30ycTZ
 MPCh+16MNrGZjdofRyGniHiEoVte8lQiqQJJoKPqhTRnIkQHoW7JSIzvpS05s0ogZWgM
 Pl9AE5ZBe5JquCC0+l+uRjz0iZdqpamWaOhGWsccxsR/JnrF6EQooi4aXU4QF3xYUOCH
 Enew==
X-Gm-Message-State: AOJu0YyqcVM/BkskK5S95AfWmQiAQlUXfn1kjoniQ7PJ7B3UDzCNEPce
 j+/OFT30/dIVkNdprFaOb6d/ZZMmx2yk7rsBDGGlBIceZ5p4PYXclvVwZqOyE6mZtVjco03xfjV
 dxSU/
X-Gm-Gg: ASbGncu7uiyvaxnOKfYaVBUA1+Gl0R64WvgBdvhS+yNFA3VEdl+q3LFsh5yDjUb3eGI
 XqGMjhET1cPL+MCOSaQwdedciancbN4N/WheHHDfcrsxRH1Q8icnESgFPTVDoHH1fcTfrFzgX/b
 WkVA09MNd0WJUKydc341aw7r8Aa7ecEqStIbnAXDssOuDUtrFZQEO8Wp7DjBq6LLaYpNd30iKTV
 Cl+JbwXlGbb4T8T5YF4ugpUX+/+/SAp4ZBMdxebwRzl/BOM/iL/nQDGOL0yE9ar7F9/Y1/fW3J8
 I7dmUtkd6aGamJ7KB6mVaY89P57b2XY4LabY1yRnq0I2PpZaT1yVwdk/znDjpjyvv+XnmIdj3Gj
 58zFlNiq9hCaXFw8DVXDBJmQSf0byhP/emoG2MyWKn+D8ir5RXqoooKm85JMVWwmOBchXv75zmx
 UyVTcSXttswQMjNYR0bBiC96v71cDwNwnDSW0HYOsZh1ZEjL54
X-Google-Smtp-Source: AGHT+IGVueVntI3GwRFIek3kHcTea1AOzJsr+wA8rD7J0CWGkRhwXu2gQwodz1ctuioGDLPGmVhaQg==
X-Received: by 2002:a05:600c:a55:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-4771e400d8emr14146385e9.26.1761725584206; 
 Wed, 29 Oct 2025 01:13:04 -0700 (PDT)
Received: from meli-email.org (athedsl-4440624.home.otenet.gr. [79.129.178.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7badsm24440045f8f.7.2025.10.29.01.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 01:13:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:11:35 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PATCH 03/35] scripts/ci: move build-environment.yaml up a level
User-Agent: meli/0.8.12
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-4-alex.bennee@linaro.org>
In-Reply-To: <20251027110344.2289945-4-alex.bennee@linaro.org>
Message-ID: <t4vw5r.fh3zebmjdmh3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.737,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 27 Oct 2025 13:03, Alex Bennée <alex.bennee@linaro.org> wrote:
>We can share the setup of the build environment with multiple
>operating systems as we just need to check the YAML for each env is
>present in the directory structure.
>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> .../ci/setup/{ubuntu => }/build-environment.yml  | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
> rename scripts/ci/setup/{ubuntu => }/build-environment.yml (81%)
>
>diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/build-environment.yml
>similarity index 81%
>rename from scripts/ci/setup/ubuntu/build-environment.yml
>rename to scripts/ci/setup/build-environment.yml
>index 1c517c74f74..66bde188755 100644
>--- a/scripts/ci/setup/ubuntu/build-environment.yml
>+++ b/scripts/ci/setup/build-environment.yml
>@@ -27,18 +27,24 @@
>         - ansible_facts['distribution'] == 'Ubuntu'
> 
>     # the package lists are updated by "make lcitool-refresh"
>-    - name: Include package lists based on OS and architecture
>-      include_vars:
>-        file: "ubuntu-2404-{{ ansible_facts['architecture'] }}.yaml"
>+    - name: Define package list file path
>+      set_fact:
>+        package_file: "ubuntu/ubuntu-2404-{{ ansible_facts['architecture'] }}.yaml"
>       when:
>         - ansible_facts['distribution'] == 'Ubuntu'
>         - ansible_facts['distribution_version'] == '24.04'
> 
>+    - name: Include package lists based on OS and architecture
>+      include_vars:
>+        file: "{{ package_file }}"
>+      when:
>+        - package_file is exists
>+
>     - name: Install packages for QEMU on Ubuntu 24.04
>       package:
>         name: "{{ packages }}"
>       when:
>-        - ansible_facts['distribution'] == 'Ubuntu'
>-        - ansible_facts['distribution_version'] == '24.04'
>+        - package_file is exists
>+        - packages is defined
> 
> 
>-- 
>2.47.3
>
>

