Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D3CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgX-0006Do-R3; Sat, 09 May 2026 22:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgN-0006BZ-Ru
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:17 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgK-0002zy-GK
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:14 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6966d0665baso2117801eaf.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379251; x=1778984051; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ILt6zm+eI5tm7QjaxUQ7ozNBI0ZDxOiM+xusaNp1SHk=;
 b=B5gQYmz5HCqFSS6/vrEsWLEdGkFsNZTZboF4tQZVv1VXVmpoVNFCBINY47pOIfNl6v
 uFQEYyj1aCKUo1flcytZW3360tpIXMeG6yP1qpsw5OxvApct/YAG5nlkppzh+GWMfySv
 M8AklNkbvZlQsjMmCycCTFHzK1qytfjeewcaj/0FXin0Yc+QmdwBeNTiADj1ZJep9MtI
 QHZQKLhMmFCaNxYsFdxZEUAZMYZUstVUc0YxYQoeuGGfsu6a+HdD8iS+35YsTk2Fw0XQ
 UnLM7vooHAc300oLoe3WNH88bQtwtJgbJUail6JF+zX5mmE/P6aeAjYZ1MoQNg0SfQAE
 kHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379251; x=1778984051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ILt6zm+eI5tm7QjaxUQ7ozNBI0ZDxOiM+xusaNp1SHk=;
 b=Viegk+ZoygVmFBgX3rkLch7dVRWjHhmCnwBJO1Dyllpkr4OLzW8c4muBSEjJhmYQ86
 T0qicXn1UTaM02EtVqlXFIQf4YOgON9Utid8s28+iA/dGsVoXuixptL2IFDYLYCGPPvf
 trHqUN5Gewbln6hfQIbfaObRy5Qm7bpVU1B3Wix4dIE1uWWtv11Ex3+UP8dYQs0WqO/9
 1Zcb64bScqrkXp5OXtn/ajA5ogfi1liCyuHMVxqGtFVC+v6zmiDBDYSb9DtY7qqmcMkP
 J8jP7x1KvXDCEtM+edzJMchOZPDspNkSN1qxP07sIJl9MI8mzHvmo8LwF6MA2GHXJdpm
 vNuw==
X-Gm-Message-State: AOJu0YyiNooorzsGHkMzTFuFmL7g1n0vMQL8n0gIDPNtpx0T5mL5V/4/
 LPb5kDsOIqwd6gbx7UDp/N0NY5NgUn340fLkyqOWBNR6RyMbFAbEqOOnfE2i3aMu
X-Gm-Gg: Acq92OHCNTN3fMRnJFbkTDphkOLbob6H1hDJFJGpfFnY7SJVhcxhCz2IbZroJJlsIjZ
 njPQzHLpzu7ze7vklV29lfiMp/BsOhiu2zUMAw1Y3dgLXYHMzMDNaRU/KP2eQTVlIQpmbjPgQ+c
 LsxIzP30hnnhIun6np6dvb2Kopns6FMRkeJKkb5RyvPWaPAhe3Y012J1v8EWLtOOykxLwJQp03j
 LnPs8oF6hwTiNlsoe4KebrWW7Vz/0kqpi7JqMPbTqrbhFESfLhgLRs4YaOzWQic8UELuNHYndRp
 7UHzjpp7VdG4YAboFN4QuIJxAScLOCIGSEnxNd2v9a02/dCLLV7Zk/xEKvN1mlWLUmwF3CwPrr6
 FxNUlt9pIV0dP/3JbNHO5V/oeGhoByma4RHpSc4FHmxfcSR5Ek/9MxXTcuKIXW0/19auClXUFQi
 e3UThR//AaIt5MqzrLQCGdmDde7yW61KrL8aSgHHOQ431vRf/ncS3AJB9xcm0WlwHme2TjG6W2t
 JJ3dzaI2uhipTeTNL9ZKIEBU3y81w7hJnNrAZask+p+V4Hyajo0RmlOy/KAaIv70Cno
X-Received: by 2002:a05:6820:61e:b0:696:7d51:79e3 with SMTP id
 006d021491bc7-69998d321e4mr11861657eaf.42.1778379251180; 
 Sat, 09 May 2026 19:14:11 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:40 -0600
Subject: [PATCH v4 17/32] target/mips: add Octeon MTP1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-17-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

MTP1 loads the middle Octeon3 partial-product pair from rs/rt into P[1]
and P[4].

This completes the second guest-visible partial-product slot used by the
Octeon multiplier helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt P[1]/P[4] pair handled by the shared MTP
    translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 94dbc356ec..d339e6d1b8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -46,6 +46,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
+MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 0af4c34263..b93506eb5a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -286,3 +286,4 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);

-- 
2.54.0


