Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8520606A334
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gXZTfRzZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu7-0005MN-PR; Mon, 09 Nov 2026 17:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtu-0005Fx-KQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:43 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtr-0003vG-Hw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8b5a6f2f27fso533608b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263498; x=1794868298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7X4i7OkHzRC4cMktPkHHhhvRPMlG5nmERGhXlWKYtTA=;
 b=gXZTfRzZqy3jLMGs8xcQ2PzV5CaxJABOR9h8wBP2jEL96/GBQ0+0T7qODWzLXY1k8q
 IGNnwPrnRIjOtNaU0acCgHjcrEHFaclcnQa+3VHgcq4KOcAXqopK4q55H7SaTGXLOFyA
 rHst/UTA9UIGnyjOC0HXqXh1CUfl+n/FHLMJSibxxpPz8iNv0gXcVwNAIFYfasV4+XVQ
 Da38K/vz30ZdRUMGu6mSyJa/hMVGLSFIkHSZ111Ip+kniTYfWAxgya0xWC9CXGNIyuTX
 R3C60dHlPESLLkACBoWN85kzqTbjf18KJmar/QmkYnML+fheG1W/99dESDS9oA7XVnZi
 B6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263498; x=1794868298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7X4i7OkHzRC4cMktPkHHhhvRPMlG5nmERGhXlWKYtTA=;
 b=cDQ5H3Q/0/OPHLX52XrLLg6X84jQtIhDOhXA4buXM7FL7enfbO/DoXqoGvhnn/vpw4
 mPYctB+I0+UxwQImW1yDLGHuK8CEQFoM4bvEQcl7pH38okYSOZ60GPlMlf07yAN0Lq79
 EUSqgCvHMtRpsizuPS7/KsSFE7T63aPI/Ie179ZWBgIZFeluit5wX39BaXLvcC2gNN1Y
 Dn7+CXvXzXQ4QPA4USG6DuPPn4v64naBl+aP827/o5AMiqp0M0jHDNwEe4Bp7F9LyAvD
 MDrg4HS4FNN0d/KglbAxluyXAZopl4HHHSjzKmGnoi90TntTaMKij7C5jZMnRqKAuLm6
 6iPg==
X-Gm-Message-State: APuU4Z9C9s0wFj8Gdhm0bSAbjMpPPfp7mthJz0LC5wv/4M11xVuXjPyK
 Doh/nbRlmjH9Z5omlAAaUsrHVOlq1dOMysWRY30kXU+G2mcB0f97lgwO2kWUBwl2KC8=
X-Gm-Gg: AYBFou0hhYuHwUsjkvG65qAc65YCZnVKD6MOe1PxtDKaPw0m/tIziwbAleY3GCHrBwW
 ZMjI9f8RuWWx7ILpI74SuxG2L8qo10SrnyKCErYrF+ko3h4Hc8bFRJYEJ1RSi2G5XJc6VvqbGVA
 k/e2b/COvmoSXNoURE7LrpUjp/eEMK2t4P8D/fugBQg9m0OxlAV7RVN3jtGuU6VO99Ad/4LUS2A
 KKdL0AMs21kNxOWJ66FLAmZmqDsrD16ZY/qBnEG3CyLi8VdDcW7oTVm3NUj2DFSWlGnGoB8+NPl
 UhPj8OKdyEa1qyeDfDWjSC4aY2O+7FG2qgscLp6hktDrsFFgazy7acGFdzLuFwKDsjmspz/W/rn
 kS7Xy2d2VrjwDSzSBJDfkG0HxFtrdboqvvqLApuh2ZNzbk/Kjzfj8hsBUq6QfOd6TB3Q88+c0BG
 lzqiUD46xPm5eelfDchv7OVcfgKhUDcmcqw0nL9uEGGpkTtYl7IsOBxiLedKaI3mbJmfebEyTM0
 w/ZF8TUeNw5rvlQCX+PkyKhGKqIy/9AFUJ7bwH+yl+3JhWg9MgJCk3jptD1pcvyTgnjul/8Gu3E
 T1muNNudgzObHS4fqQSyTzTVmbazkzoL31JrqxeFckm/s88yw2aifw==
X-Received: by 2002:a05:6a00:414e:b0:8a0:4032:af85 with SMTP id
 d2e1a72fcca58-8ba81008565mr1028225b3a.0.1794263498163; 
 Mon, 09 Nov 2026 14:31:38 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:37 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 13/23] target/arm/cpu: Don't read Realm registers
Date: Mon,  9 Nov 2026 16:31:00 -0600
Message-ID: <20261109223110.1619504-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 71681447b21d..75a482723ae0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -975,6 +975,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (MACHINE(qdev_get_machine())->cgs) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.53.0


