Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4CEC83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEn-0001MX-J3; Fri, 04 Jul 2025 12:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEf-00010v-Ro
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEc-0006Py-Fw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so869355f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646357; x=1752251157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sp9zLfK4Po00JTwCQbQiQP2F5SRX1VpL07OA/MfPQjU=;
 b=M+LNQIhDprhrbdE1z+q5swEantgC58FgyQwYAlYuDqcidwyRcAYzTCSM3MSRlOl0F9
 LWlGPJOdGKIlKfg840BmE0bi27/+7ezg/0Dgf96+FKica6qIgUIOoqqO2ATxoiCoJTvM
 Y78FhGCIHyXYx3KrBQ+xXRG99HZFgofubeZIdI3Oe/6UJBweAXt8Tf/Y6+vSCpoJWNUX
 zg9wT7Qkkltlr8+queHtQLR0zH6skg8Y0gGBpImyJdJKztAs6nCVz8Y6/lXwg9VvgeqM
 gujNvjHRJkOEmaG5eMP1gR/3RhrZxS4MzNZxkilSdSN7SPFETfoRqlkUqcDvja101JIo
 iFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646357; x=1752251157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sp9zLfK4Po00JTwCQbQiQP2F5SRX1VpL07OA/MfPQjU=;
 b=SOTCmCFerBvZc5j28yxmgxSaFKmQ/nR45eI5vESr60r58ax2uBNH9O4i3n1LSd1RFk
 0w6ujLNza+UIP2CJ3mm0jeya/BqbBSqwzJyIbaUd+FLdXBMT4ay0IIU9P5QQXJW1DQN0
 0+7rnLSOk4z8SXuwwAxyZQUCa/+Y20UCHfvfv0niD5QNUW+C3W/U67vnsmih6jxgNMra
 QFsnaRrL3IvLOghhbC+9MPSbpv2pfrlr28nwhiRH58+BD6rsmZdafsLbI7DRqah8Bmya
 EJ/TxGwe9iVIB3o885SBmTwk6cVdS8xi5VEqCr+c8H8lgWjUdfP3JgUadmqempEhTPAl
 DKSQ==
X-Gm-Message-State: AOJu0YyScoYNukS5OYqdd4Pu1a1PvDU1x++Pktc2jTxwxOw1dXyaNLX5
 U7Hmt1EcG5TQ/oEmUH0WFIUVuAO6LybWQanSB7ktaWvDN+ul5/V2Kboc9A8Cpq6Idl7kRvCdTf5
 jWNZc
X-Gm-Gg: ASbGnctGyNbUlPaPYyD/THm9bkTBpFE27Jfj+CXsqaSLy0ncnz5zvnh5Mo/AhacNrtS
 vCagpIKitulZAvrKTvBuT2pseMDGSj671uz0o0R7lKIQ3hrN44JtkqbWQwZEUF8OF2qSkNPWg28
 3+PNavmVANfAKTPTEVvc3Zaz3ELYyrZV4ra7CYTm2z3Jk6o4dCFhWo6E0MhIdIk3dOcLQDK4YI5
 3k+m3ZHyk3EAgQ5BsrstF7PgUaYDXnjSqeCzHEVfPGc1jnNrOYB1CvrhzoX1mstD1db3O4P8r9V
 JgyE2gqmBVyBk8MkfrKMphBONbsM8+rdLtQU7Tta7KfxIt/pUU7J4zfrVoWzeXWbkOPi
X-Google-Smtp-Source: AGHT+IFyQ6nysnt8/hdP1XS0JpFvuyQUq5Yf96J/eirjhtvKLUvUV9wxR8C4s7pP2+WZ+ZWx5aCLvw==
X-Received: by 2002:a5d:5d8a:0:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3b497045fb8mr2540519f8f.58.1751646356991; 
 Fri, 04 Jul 2025 09:25:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 058/119] target/arm: Implement SME2 SMLAL, SMLSL, UMLAL, UMLSL
Date: Fri,  4 Jul 2025 17:23:58 +0100
Message-ID: <20250704162501.249138-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-47-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  21 +++++
 target/arm/tcg/sme.decode      | 168 +++++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c    |  59 ++++++++++++
 target/arm/tcg/translate-sme.c |  84 +++++++++++++++++
 4 files changed, 332 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 464877516b6..0bb8af194b3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -191,3 +191,24 @@ DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sme2_svdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme2_uvdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_smlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_smlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4146744a466..934e4a802ea 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -311,6 +311,65 @@ UDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
 UDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
 UDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
 
+SMLAL_n1        11000001 011 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+SMLAL_n1        11000001 011 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
+SMLAL_n1        11000001 011 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
+
+SMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
+SMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
+SMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
+
+UMLAL_n1        11000001 011 0 .... 0 .. 011 ..... 10 ...   @azz_nx1_o3x2 n=1
+UMLAL_n1        11000001 011 0 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=2
+UMLAL_n1        11000001 011 1 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=4
+
+UMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
+UMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
+UMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
+
+%off2_x4        0:2 !function=times_4
+%off1_x4        0:1 !function=times_4
+
+@azz_nx1_o2x4   ........ ... . zm:4 . .. ... zn:5 ... ..    \
+                &azz_n off=%off2_x4 rv=%mova_rv
+@azz_nx1_o1x4   ........ ... . zm:4 . .. ... zn:5 .... .    \
+                &azz_n off=%off1_x4 rv=%mova_rv
+
+SMLALL_n1_s     11000001 001 0 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+SMLALL_n1_d     11000001 011 0 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+SMLALL_n1_s     11000001 001 0 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=2
+SMLALL_n1_d     11000001 011 0 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=2
+SMLALL_n1_s     11000001 001 1 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=4
+SMLALL_n1_d     11000001 011 1 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=4
+
+SMLSLL_n1_s     11000001 001 0 .... 0 .. 001 ..... 010 ..   @azz_nx1_o2x4 n=1
+SMLSLL_n1_d     11000001 011 0 .... 0 .. 001 ..... 010 ..   @azz_nx1_o2x4 n=1
+SMLSLL_n1_s     11000001 001 0 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=2
+SMLSLL_n1_d     11000001 011 0 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=2
+SMLSLL_n1_s     11000001 001 1 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=4
+SMLSLL_n1_d     11000001 011 1 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=4
+
+UMLALL_n1_s     11000001 001 0 .... 0 .. 001 ..... 100 ..   @azz_nx1_o2x4 n=1
+UMLALL_n1_d     11000001 011 0 .... 0 .. 001 ..... 100 ..   @azz_nx1_o2x4 n=1
+UMLALL_n1_s     11000001 001 0 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=2
+UMLALL_n1_d     11000001 011 0 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=2
+UMLALL_n1_s     11000001 001 1 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=4
+UMLALL_n1_d     11000001 011 1 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=4
+
+UMLSLL_n1_s     11000001 001 0 .... 0 .. 001 ..... 110 ..   @azz_nx1_o2x4 n=1
+UMLSLL_n1_d     11000001 011 0 .... 0 .. 001 ..... 110 ..   @azz_nx1_o2x4 n=1
+UMLSLL_n1_s     11000001 001 0 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=2
+UMLSLL_n1_d     11000001 011 0 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=2
+UMLSLL_n1_s     11000001 001 1 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=4
+UMLSLL_n1_d     11000001 011 1 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=4
+
+USMLALL_n1_s    11000001 001 0 .... 0 .. 001 ..... 001 ..   @azz_nx1_o2x4 n=1
+USMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=2
+USMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
+
+SUMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
+SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -371,6 +430,46 @@ UDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
 UDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 11 ...    @azz_2x2_o3
 UDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 11 ...    @azz_4x4_o3
 
+SMLAL_nn        11000001 111 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
+SMLAL_nn        11000001 111 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
+
+SMLSL_nn        11000001 111 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
+SMLSL_nn        11000001 111 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
+
+UMLAL_nn        11000001 111 ....0 0 .. 010 ....0 100 ..    @azz_2x2_o2x2
+UMLAL_nn        11000001 111 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
+
+UMLSL_nn        11000001 111 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
+UMLSL_nn        11000001 111 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
+
+@azz_2x2_o1x4   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2 off=%off1_x4
+@azz_4x4_o1x4   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4 off=%off1_x4
+
+SMLALL_nn_s     11000001 101 ....0 0 .. 000 ....0 0000 .    @azz_2x2_o1x4
+SMLALL_nn_d     11000001 111 ....0 0 .. 000 ....0 0000 .    @azz_2x2_o1x4
+SMLALL_nn_s     11000001 101 ...01 0 .. 000 ...00 0000 .    @azz_4x4_o1x4
+SMLALL_nn_d     11000001 111 ...01 0 .. 000 ...00 0000 .    @azz_4x4_o1x4
+
+SMLSLL_nn_s     11000001 101 ....0 0 .. 000 ....0 0100 .    @azz_2x2_o1x4
+SMLSLL_nn_d     11000001 111 ....0 0 .. 000 ....0 0100 .    @azz_2x2_o1x4
+SMLSLL_nn_s     11000001 101 ...01 0 .. 000 ...00 0100 .    @azz_4x4_o1x4
+SMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 0100 .    @azz_4x4_o1x4
+
+UMLALL_nn_s     11000001 101 ....0 0 .. 000 ....0 1000 .    @azz_2x2_o1x4
+UMLALL_nn_d     11000001 111 ....0 0 .. 000 ....0 1000 .    @azz_2x2_o1x4
+UMLALL_nn_s     11000001 101 ...01 0 .. 000 ...00 1000 .    @azz_4x4_o1x4
+UMLALL_nn_d     11000001 111 ...01 0 .. 000 ...00 1000 .    @azz_4x4_o1x4
+
+UMLSLL_nn_s     11000001 101 ....0 0 .. 000 ....0 1100 .    @azz_2x2_o1x4
+UMLSLL_nn_d     11000001 111 ....0 0 .. 000 ....0 1100 .    @azz_2x2_o1x4
+UMLSLL_nn_s     11000001 101 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
+UMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
+
+USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 0010 .    @azz_2x2_o1x4
+USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 0010 .    @azz_4x4_o1x4
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -449,3 +548,72 @@ UVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 11 ...   @azx_4x1_i1_o3
 
 SUVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 11 ...   @azx_4x1_i2_o3
 USVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 01 ...   @azx_4x1_i2_o3
+
+SMLAL_nx        11000001 1100 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
+SMLAL_nx        11000001 1101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
+SMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
+
+SMLSL_nx        11000001 1100 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
+SMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
+SMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
+
+UMLAL_nx        11000001 1100 .... . .. 1 .. ..... 10 ...   @azx_1x1_o3x2
+UMLAL_nx        11000001 1101 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_o2x2
+UMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
+
+UMLSL_nx        11000001 1100 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
+UMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
+UMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
+
+%idx4_15_10     15:1 10:3
+%idx4_10_1      10:2 1:2
+%idx3_10_1      10:1 1:2
+
+@azx_1x1_i4_o2  ........ .... zm:4 . .. ... zn:5 ... ..     \
+                &azx_n n=1 rv=%mova_rv off=%off2_x4 idx=%idx4_15_10
+@azx_1x1_i3_o2  ........ .... zm:4 . .. ... zn:5 ... ..     \
+                &azx_n n=1 rv=%mova_rv off=%off2_x4 idx=%idx3_15_10
+@azx_2x1_i4_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=2 rv=%mova_rv off=%off1_x4 zn=%zn_ax2 idx=%idx4_10_1
+@azx_2x1_i3_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=2 rv=%mova_rv off=%off1_x4 zn=%zn_ax2 idx=%idx3_10_1
+@azx_4x1_i4_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=4 rv=%mova_rv off=%off1_x4 zn=%zn_ax4 idx=%idx4_10_1
+@azx_4x1_i3_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=4 rv=%mova_rv off=%off1_x4 zn=%zn_ax4 idx=%idx3_10_1
+
+SMLALL_nx_s     11000001 0000 .... . .. ... ..... 000 ..    @azx_1x1_i4_o2
+SMLALL_nx_d     11000001 1000 .... . .. 0.. ..... 000 ..    @azx_1x1_i3_o2
+SMLALL_nx_s     11000001 0001 .... 0 .. 0.. ....0 00 ...    @azx_2x1_i4_o1
+SMLALL_nx_d     11000001 1001 .... 0 .. 00. ....0 00 ...    @azx_2x1_i3_o1
+SMLALL_nx_s     11000001 0001 .... 1 .. 0.. ...00 00 ...    @azx_4x1_i4_o1
+SMLALL_nx_d     11000001 1001 .... 1 .. 00. ...00 00 ...    @azx_4x1_i3_o1
+
+SMLSLL_nx_s     11000001 0000 .... . .. ... ..... 010 ..    @azx_1x1_i4_o2
+SMLSLL_nx_d     11000001 1000 .... . .. 0.. ..... 010 ..    @azx_1x1_i3_o2
+SMLSLL_nx_s     11000001 0001 .... 0 .. 0.. ....0 01 ...    @azx_2x1_i4_o1
+SMLSLL_nx_d     11000001 1001 .... 0 .. 00. ....0 01 ...    @azx_2x1_i3_o1
+SMLSLL_nx_s     11000001 0001 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i4_o1
+SMLSLL_nx_d     11000001 1001 .... 1 .. 00. ...00 01 ...    @azx_4x1_i3_o1
+
+UMLALL_nx_s     11000001 0000 .... . .. ... ..... 100 ..    @azx_1x1_i4_o2
+UMLALL_nx_d     11000001 1000 .... . .. 0.. ..... 100 ..    @azx_1x1_i3_o2
+UMLALL_nx_s     11000001 0001 .... 0 .. 0.. ....0 10 ...    @azx_2x1_i4_o1
+UMLALL_nx_d     11000001 1001 .... 0 .. 00. ....0 10 ...    @azx_2x1_i3_o1
+UMLALL_nx_s     11000001 0001 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i4_o1
+UMLALL_nx_d     11000001 1001 .... 1 .. 00. ...00 10 ...    @azx_4x1_i3_o1
+
+UMLSLL_nx_s     11000001 0000 .... . .. ... ..... 110 ..    @azx_1x1_i4_o2
+UMLSLL_nx_d     11000001 1000 .... . .. 0.. ..... 110 ..    @azx_1x1_i3_o2
+UMLSLL_nx_s     11000001 0001 .... 0 .. 0.. ....0 11 ...    @azx_2x1_i4_o1
+UMLSLL_nx_d     11000001 1001 .... 0 .. 00. ....0 11 ...    @azx_2x1_i3_o1
+UMLSLL_nx_s     11000001 0001 .... 1 .. 0.. ...00 11 ...    @azx_4x1_i4_o1
+UMLSLL_nx_d     11000001 1001 .... 1 .. 00. ...00 11 ...    @azx_4x1_i3_o1
+
+USMLALL_nx_s    11000001 0000 .... . .. ... ..... 001 ..    @azx_1x1_i4_o2
+USMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 00 ...    @azx_2x1_i4_o1
+USMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 00 ...    @azx_4x1_i4_o1
+
+SUMLALL_nx_s    11000001 0000 .... . .. ... ..... 101 ..    @azx_1x1_i4_o2
+SUMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 10 ...    @azx_2x1_i4_o1
+SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f5242d99bed..0f79d7cb6e3 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1458,3 +1458,62 @@ DO_VDOT_IDX(sme2_svdot_idx_2h, int32_t, int16_t, int16_t, H4, H2)
 DO_VDOT_IDX(sme2_uvdot_idx_2h, uint32_t, uint16_t, uint16_t, H4, H2)
 
 #undef DO_VDOT_IDX
+
+#define DO_MLALL(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
+    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
+    for (intptr_t i = 0; i < elements; ++i) {                   \
+        TYPEW nn = n[HN(i * 4 + sel)];                          \
+        TYPEM mm = m[HN(i * 4 + sel)];                          \
+        d[HW(i)] = a[HW(i)] OP (nn * mm);                       \
+    }                                                           \
+}
+
+DO_MLALL(sme2_smlall_s, int32_t, int8_t, int8_t, H4, H1, +)
+DO_MLALL(sme2_smlall_d, int64_t, int16_t, int16_t, H8, H2, +)
+DO_MLALL(sme2_smlsll_s, int32_t, int8_t, int8_t, H4, H1, -)
+DO_MLALL(sme2_smlsll_d, int64_t, int16_t, int16_t, H8, H2, -)
+
+DO_MLALL(sme2_umlall_s, uint32_t, uint8_t, uint8_t, H4, H1, +)
+DO_MLALL(sme2_umlall_d, uint64_t, uint16_t, uint16_t, H8, H2, +)
+DO_MLALL(sme2_umlsll_s, uint32_t, uint8_t, uint8_t, H4, H1, -)
+DO_MLALL(sme2_umlsll_d, uint64_t, uint16_t, uint16_t, H8, H2, -)
+
+DO_MLALL(sme2_usmlall_s, uint32_t, uint8_t, int8_t, H4, H1, +)
+
+#undef DO_MLALL
+
+#define DO_MLALL_IDX(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
+    intptr_t eltspersegment = 16 / sizeof(TYPEW);               \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 4);     \
+    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
+    for (intptr_t i = 0; i < elements; i += eltspersegment) {   \
+        TYPEW mm = m[HN(i * 4 + idx)];                          \
+        for (intptr_t j = 0; j < eltspersegment; ++j) {         \
+            TYPEN nn = n[HN((i + j) * 4 + sel)];                \
+            d[HW(i + j)] = a[HW(i + j)] OP (nn * mm);           \
+        }                                                       \
+    }                                                           \
+}
+
+DO_MLALL_IDX(sme2_smlall_idx_s, int32_t, int8_t, int8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_smlall_idx_d, int64_t, int16_t, int16_t, H8, H2, +)
+DO_MLALL_IDX(sme2_smlsll_idx_s, int32_t, int8_t, int8_t, H4, H1, -)
+DO_MLALL_IDX(sme2_smlsll_idx_d, int64_t, int16_t, int16_t, H8, H2, -)
+
+DO_MLALL_IDX(sme2_umlall_idx_s, uint32_t, uint8_t, uint8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_umlall_idx_d, uint64_t, uint16_t, uint16_t, H8, H2, +)
+DO_MLALL_IDX(sme2_umlsll_idx_s, uint32_t, uint8_t, uint8_t, H4, H1, -)
+DO_MLALL_IDX(sme2_umlsll_idx_d, uint64_t, uint16_t, uint16_t, H8, H2, -)
+
+DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
+
+#undef DO_MLALL_IDX
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b88f439ef9d..070cebc5738 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1070,3 +1070,87 @@ TRANS_FEAT(UVDOT_nx_4h, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4h)
 
 TRANS_FEAT(SUVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_suvdot_idx_4b)
 TRANS_FEAT(USVDOT_nx_4b, aa64_sme2, do_vdot_nx, a, gen_helper_sme2_usvdot_idx_4b)
+
+static bool do_smlal(DisasContext *s, arg_azz_n *a, bool multi,
+                     gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+TRANS_FEAT(SMLAL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_smlal_zzzw_s)
+TRANS_FEAT(SMLSL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_smlsl_zzzw_s)
+TRANS_FEAT(UMLAL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_umlal_zzzw_s)
+TRANS_FEAT(UMLSL_n1, aa64_sme2, do_smlal, a, false, gen_helper_sve2_umlsl_zzzw_s)
+
+TRANS_FEAT(SMLAL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_smlal_zzzw_s)
+TRANS_FEAT(SMLSL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_smlsl_zzzw_s)
+TRANS_FEAT(UMLAL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_umlal_zzzw_s)
+TRANS_FEAT(UMLSL_nn, aa64_sme2, do_smlal, a, true, gen_helper_sve2_umlsl_zzzw_s)
+
+static bool do_smlal_nx(DisasContext *s, arg_azx_n *a,
+                         gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                      a->idx << 1, 0, false, fn);
+}
+
+TRANS_FEAT(SMLAL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_smlal_idx_s)
+TRANS_FEAT(SMLSL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_smlsl_idx_s)
+TRANS_FEAT(UMLAL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_umlal_idx_s)
+TRANS_FEAT(UMLSL_nx, aa64_sme2, do_smlal_nx, a, gen_helper_sve2_umlsl_idx_s)
+
+static bool do_smlall(DisasContext *s, arg_azz_n *a, bool multi,
+                     gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+static void gen_helper_sme2_sumlall_s(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                      TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_sme2_usmlall_s(d, m, n, a, desc);
+}
+
+TRANS_FEAT(SMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_smlall_s)
+TRANS_FEAT(SMLSLL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_smlsll_s)
+TRANS_FEAT(UMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_umlall_s)
+TRANS_FEAT(UMLSLL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_umlsll_s)
+TRANS_FEAT(USMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_usmlall_s)
+TRANS_FEAT(SUMLALL_n1_s, aa64_sme2, do_smlall, a, false, gen_helper_sme2_sumlall_s)
+
+TRANS_FEAT(SMLALL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_smlall_d)
+TRANS_FEAT(SMLSLL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_smlsll_d)
+TRANS_FEAT(UMLALL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_umlall_d)
+TRANS_FEAT(UMLSLL_n1_d, aa64_sme2_i16i64, do_smlall, a, false, gen_helper_sme2_umlsll_d)
+
+TRANS_FEAT(SMLALL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_smlall_s)
+TRANS_FEAT(SMLSLL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_smlsll_s)
+TRANS_FEAT(UMLALL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_umlall_s)
+TRANS_FEAT(UMLSLL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_umlsll_s)
+TRANS_FEAT(USMLALL_nn_s, aa64_sme2, do_smlall, a, true, gen_helper_sme2_usmlall_s)
+
+TRANS_FEAT(SMLALL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_smlall_d)
+TRANS_FEAT(SMLSLL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_smlsll_d)
+TRANS_FEAT(UMLALL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_umlall_d)
+TRANS_FEAT(UMLSLL_nn_d, aa64_sme2_i16i64, do_smlall, a, true, gen_helper_sme2_umlsll_d)
+
+static bool do_smlall_nx(DisasContext *s, arg_azx_n *a,
+                        gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                      a->idx << 2, 0, false, fn);
+}
+
+TRANS_FEAT(SMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_smlall_idx_s)
+TRANS_FEAT(SMLSLL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_s)
+TRANS_FEAT(UMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_umlall_idx_s)
+TRANS_FEAT(UMLSLL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_umlsll_idx_s)
+TRANS_FEAT(USMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_usmlall_idx_s)
+TRANS_FEAT(SUMLALL_nx_s, aa64_sme2, do_smlall_nx, a, gen_helper_sme2_sumlall_idx_s)
+
+TRANS_FEAT(SMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlall_idx_d)
+TRANS_FEAT(SMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
+TRANS_FEAT(UMLALL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall_idx_d)
+TRANS_FEAT(UMLSLL_nx_d, aa64_sme2_i16i64, do_smlall_nx, a, gen_helper_sme2_umlsll_idx_d)
-- 
2.43.0


