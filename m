Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA1EE01ED
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9C6-0005ra-6n; Tue, 10 Sep 2024 18:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Bg-0002Yx-RF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:18:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Be-0007Ae-U4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:18:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so1245240b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006693; x=1726611493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAUNG2Z8iwfixvozuxuZzI5U7SDFeb08Hf/Nr+6pfa0=;
 b=sMGKU92uUL6VoGMdtD1nMNktU7SCizbIPCx2nhX/ToN2xSX7x2+qAfEqeKdNOinRWE
 zFwWnrk6LEegildz92cUU/0CiiYoSoS7H2CunZKcRE0cM76NMUhycnW6OVLH+Am35uPZ
 ZFRovXadWkn6LYG9qozJs9FEWpVTlkCytM+TzjCq3XcjT34BRO0R4LRH1QWNwl1GjkDB
 gCtStwyDH2I1+MkvvYcfMFCEQBgn+eK6tTwY+CZAoSz8zqWcid6LViYx3kMuZz/gFqoy
 ucJJagd550VwcdSBw6t2Sr1mh3th0Bi0QctSmQpJVEn1EfaRx6tZ864LpRg7YJDkSzW8
 +pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006693; x=1726611493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAUNG2Z8iwfixvozuxuZzI5U7SDFeb08Hf/Nr+6pfa0=;
 b=CJxr0swgN4oe/hCBPglBNVZIhrjxZbjQDaNuSlH73QRKwLNw1EpSEWsqZuqbrarroe
 pqE9ionpFvP9y501AiUezy8toSaSAEpT884oO3osLdPiKJu4WL6H4T/44DXxnOMO/iaS
 XLlvuCwyqzSGCLmgN4Fw72YccPC+zQUSAJRpgJgsUwUPIa2Zh8hA8zEKa0fsOkaev3q6
 Fuvohp02n+iKSlM801R2aIygKGObEzSgBtAPNtQi6AoxZDxl18QWqksLYBzeydVzVYPG
 dE2fLF78eo2CokmOWirtndtbww5DHrFPbrZqDBedmLQGHDW+8vGIpF2hmyYsIXUGBR82
 Y9zQ==
X-Gm-Message-State: AOJu0Yz4StwMfQ0pBgSZr/ds/g3t8EG+7bvukjjHOUcjCkwKnvItWO9+
 0eLy3NA+OXEkaUpNF7RveC3ePoFNdgWgN+6ED+s6TZSwehHeVE3aWkOvUkT31QUSXb99ZOnnuHS
 NvQ6ZXv1M
X-Google-Smtp-Source: AGHT+IFGhI3LMnJRi+254dAZqpPbVgzsgGXn7sXIi4XpOoxOVhAxol60+FTs3bT9dBxAMQw1ZiUN2w==
X-Received: by 2002:a05:6a20:e609:b0:1cf:42ab:5776 with SMTP id
 adf61e73a8af0-1cf62d5ca4amr1800943637.32.1726006693348; 
 Tue, 10 Sep 2024 15:18:13 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:18:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 39/39] scripts/checkpatch.pl: emit error when using
 assert(false)
Date: Tue, 10 Sep 2024 15:16:06 -0700
Message-Id: <20240910221606.1817478-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 65b6f46f905..fa9c12230eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3102,6 +3102,9 @@ sub process {
 		if ($line =~ /\b(g_)?assert\(0\)/) {
 			ERROR("use g_assert_not_reached() instead of assert(0)\n" . $herecurr);
 		}
+		if ($line =~ /\b(g_)?assert\(false\)/) {
+			ERROR("use g_assert_not_reached() instead of assert(false)\n" . $herecurr);
+		}
 		if ($line =~ /\bstrerrorname_np\(/) {
 			ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);
 		}
-- 
2.39.2


