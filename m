Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE408CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3uU-0003pM-EW; Mon, 28 Sep 2026 01:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3qZ-0007Nt-T8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:24:23 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3qU-0008Dh-M5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:24:13 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-14373bcc010so2202359c88.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573041; x=1791177841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xRhjFf72VMP1IXC5iIuXu+o23aKg88Zy2a17bYh8Llk=;
 b=Li8b3jA6sxwpIlPlczgO+sVYm5Vsi6WsrhNV6RKfgdi3583V17RgRxbVkifPP70VSx
 1azG7M6eHUfnnN+EMn7YiR+OiR/EpPjWvTdiAaHvPpyWd4qpoCqGnQZChDI83lv0ssfn
 +hATd6lpZUt9IY4/XIcuKhVQOQSlBavvU1W089nHwWNOxXnl1ID2I0strYoOfRN1nDtm
 QbPV3Ilprqr9ywnFVLUU1FRZBVPVzksJzU2P9iKAyePsVHq9YIVlJvyHczr84W1HM75S
 IQ3WsL79RlDNLvTn2hekXSikavsq26d/rr6xzX46itBIcyQGXjw6CBXXZuXRLpPGsUcG
 zWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573041; x=1791177841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xRhjFf72VMP1IXC5iIuXu+o23aKg88Zy2a17bYh8Llk=;
 b=Vf2A0oOwir8Mv1NT1OC6UuovO74MnlsR/o68Wj6Vz4rfJJATKK0pCKpmcHfqOTuKMc
 roRGlKSsLj22FzPbTw56lmycfmk8dpztpxHDy5j57HN8jkN6BIEmHdQ9m9BLxfP8xo9J
 YRR3hHG1kZdboO6FR1wRal7xNylGdJlGkyldeTnwHXJIv38aU4TXtyzj/dmLzuGeafZX
 Dy1rNoc48/zeqnmPJucoYQPRfnhKGPC2g2zmd4Ox4tPBhTvdjolq/YLdLZXNog3Q+trg
 e07TkUEqXNvaPEvMFxnAT/xsUip99IMWwIUexbCaWjDvmDEJ1mNuFPb9g0NNh/nBEgcl
 U2YA==
X-Gm-Message-State: AFuF++kECpudnJJ+MSCiED4Op/7u1ShbOmkfs89yGxT24zaxNCX4hioI
 stKPDJQuHeYH17sVRW3/jDwaTLHB8atF3sYIGFQ8s0Gv2plUW8ooXqYMaZeNPEpqvXk=
X-Gm-Gg: AYBFou18k5LjFYNttVF5Q2gtwnJiRyaBPeG5uQ/Os1VylfE8Gpz2tlHJuMrNdI/NeUi
 nR0a0pJehVyvAXWJFkdtgY+v1keGg50Ux7r+cPlqCT5ghr1ykzjue4LkYx58ZCfxrIW2gfnt/M6
 gon9aP04qyDcBq2ONhsARNqSBTBmwZKWM8RSl8qHQbX3PU87yCls3d401lP2H3aZZNANgc5NPSd
 AJPeHQC0oi0RoaFIo3RsD2b2s7HegJEhOaUiJ41JSNEafcQ0zIM4XeuXqvPdIYq/Eso6gc7M/Xl
 GkKSmhn1i8Nial49z+x1QlE4gFF/wCXmVrFPGKNsaRx/JC+vxU3j2xEYwK1vujU4O7D9Ih787ms
 clOLi8icBAYZ6QAN+AyvON+rvL82RaGozf+X6gcILogzB4Cu48/BLXW16WjeqsGQAZjyD3Sp/yq
 9leAiL1AfWdpEkBpxIjBUQZymLz9IC3Ne434V6Ot0IKUk7JGy/FkkaCDQvuLhx+q6sS35Ig7vEb
 IGsHjbMCJlat2s/jbPCJxIxmu5UDdvskPvIl2g9Yg==
X-Received: by 2002:a05:701b:241a:b0:146:6755:ff08 with SMTP id
 a92af1059eb24-146ce1a818emr8357405c88.9.1790573041389; 
 Sun, 27 Sep 2026 22:24:01 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:24:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 23/24] target/ppc: fold gen_exception_nip into
 gen_exception_err_nip
Date: Mon, 28 Sep 2026 13:20:49 +0800
Message-ID: <20260928052051.251-24-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

gen_exception_nip is gen_exception_err_nip with error_code 0. Call
that function instead of raising on its own.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/ppc/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4ec..f1a7039a325 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -330,12 +330,7 @@ static inline void gen_exception_err(DisasContext *ctx, uint32_t excp,
 static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
                               target_ulong nip)
 {
-    TCGv_i32 t0;
-
-    gen_update_nip(ctx, nip);
-    t0 = tcg_constant_i32(excp);
-    gen_helper_raise_exception(tcg_env, t0);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_exception_err_nip(ctx, excp, 0, nip);
 }
 
 static inline void gen_exception(DisasContext *ctx, uint32_t excp)
-- 
2.52.0.windows.1


