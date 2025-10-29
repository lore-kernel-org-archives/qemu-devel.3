Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99190CCF9F2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1Gr-0007Ou-DT; Wed, 29 Oct 2025 04:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Gh-0007OG-Rh
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:10:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1Gc-0004bM-I6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:10:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so3362377f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761725447; x=1762330247; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WMZtSrVCQzr0uAODDe4WO0RNkp8rQj/Tb5xXoORj8fQ=;
 b=HTqGdX1b9cYtzfLe/lXs/E6s9TXDsizysHRc164jLydnkpCjF0HkRKSnbmuAMMbr7R
 yIYVxMIWxAcUyE66zveT8eAs5wLtIZ3AS+g+dLCjiE0nsvKQuhy9EKhqUyXMPvqizmC/
 Eiz4OEsglIIw7vK+DSCDw9310tLx9qupDbLRPLtNPj2q7Cdp1T2KjEFn641xolLkHSJ/
 C4ySjcwOSqQbxeRjnqcJQNkdhLW2Lkh1DKKcx4R5xOyrfsuDyi/k1knPSveKn7NuTJc1
 AIufqP+h+KrkMav0XLJPouYg9PQ5BFdbaBH3I9qWyOfEHFlhaDS2vPXuxFDiGVX0t1qU
 xAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725447; x=1762330247;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMZtSrVCQzr0uAODDe4WO0RNkp8rQj/Tb5xXoORj8fQ=;
 b=nDUi0EEM53qEsfaZOfTpqQ8HdF7sYr5GJhSJyz8da9gfjyYDkrjQLtOLmLIm9AdCSD
 sFjraAzCtpYU0VBElZfc+ymmr66CdBnR4BDwl0GG1+DivBm3uXBzJwrhiM7NTAA0ASmw
 u/fYGkn2Wg1kTJRDgReCKNE4Rwkr+by+DnvoticPEEzBIFJ4Wjrov48O8WFCFXN7UtGL
 04UZLCBu9yA6QJEiWGT8ipWNFHRdYT7cNl4cJsWUMzGZD1y/lo10DodArxnCxttg75Ma
 dpaNqQJDPGFR8udA124tyTZTHmysIgYnZD/x30x48VqvnY/dsKpBmx60gZ+76WaJD/Hp
 9ysA==
X-Gm-Message-State: AOJu0Yw84pQopcNQrbvCzaHRv9ssYfiR0TOTLoP8MA4DSmtEQbnbK5fd
 2RGdOF9xloE5ZTLC7dClJxeZ35ivVhYG5gZYraMg2f6BwWTLX8CKfhOYj44XEwA1qwcqNmi4WBn
 eQ8Hz
X-Gm-Gg: ASbGncvyBCEc/pLGXY7Kdxy4HOXpqzrRd4a7CfCNLGLQ8GiMsqYH3Balw3mQokuPakT
 GkpLM8jWDSF5X90vxiqyxgvtrqnc0hfA/wKy4hJaq+WAif20F4kD7kl5ApecmXRjvkLIMhdxAEW
 sQ5tELJyMvlSV0yDDY0/UyCvxL0izedvoIsw1nbejjrMW7vzjFZff/BdgxsifSl91mhlsPB0+ch
 C5rrzhjkizwMhbKJwCaN6OMRVMqPlFjpmuGejn35+Phjj8zRiofmwcbaCLd+vGO/krjaUuLfxIO
 0lFSbYT5C6r2NC6IJm0MQfN0j+sSU4unZDIK60oBF5IGUntaiiKvyQ3nD36B3Iiyk4puluLq0Q9
 /o1z+0HvIATA7XqdSlJIo/5DI2cZVBHQp81CHvFCA7OOtSE3dqwq3IXu7uwqRw6IPaGIn16KDG/
 WKFRpK81eCGTaOFTXpWpxND4MJJdo/mUpbdLHwrpxmytHAGFI+
X-Google-Smtp-Source: AGHT+IGT7zOS85s9tlg3jilcN9QYaJKuyN0sURC4ERCaHbjy3qjLqWlaD+DPUcv8eJq6jQcxMchs9A==
X-Received: by 2002:a05:6000:1846:b0:429:8d8b:fef7 with SMTP id
 ffacd0b85a97d-429aefca3a0mr1393034f8f.49.1761725447248; 
 Wed, 29 Oct 2025 01:10:47 -0700 (PDT)
Received: from meli-email.org (athedsl-4440624.home.otenet.gr. [79.129.178.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5c9dsm25987917f8f.26.2025.10.29.01.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 01:10:46 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:10:24 +0200
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
Subject: Re: [PATCH 06/35] scripts/ci: modify gitlab runner deb setup
User-Agent: meli/0.8.12
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-7-alex.bennee@linaro.org>
In-Reply-To: <20251027110344.2289945-7-alex.bennee@linaro.org>
Message-ID: <t4vw1x.1ndc8wjayp8ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
>Both Debian and Ubuntu are setup the same way.
>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> scripts/ci/setup/gitlab-runner.yml | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
>index 7025935487a..76aeaf4ee95 100644
>--- a/scripts/ci/setup/gitlab-runner.yml
>+++ b/scripts/ci/setup/gitlab-runner.yml
>@@ -56,12 +56,12 @@
>         url: "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh"
>         mode: 0755
>       when:
>-        - ansible_facts['distribution'] == 'Ubuntu'
>+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
> 
>     - name: Run gitlab-runner repo setup script (DEB)
>       shell: "/root/script.deb.sh"
>       when:
>-        - ansible_facts['distribution'] == 'Ubuntu'
>+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
> 
>     - name: Install gitlab-runner (DEB)
>       ansible.builtin.apt:
>@@ -69,7 +69,7 @@
>           update_cache: yes
>           state: present
>       when:
>-        - ansible_facts['distribution'] == 'Ubuntu'
>+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
> 
>     # RPM setup
>     - name: Get gitlab-runner repo setup script (RPM)
>-- 
>2.47.3
>
>

