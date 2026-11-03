Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A7606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kAmRUkyJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIHP-0000Bq-Ip; Tue, 03 Nov 2026 12:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIHD-00008B-Aj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:26:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIHB-0006Qt-02
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:26:27 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so29410995e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793726783; x=1794331583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hqqeZR9hh82Ok/85fIviXaUdYKynKCQ8FaCgEa2tPAY=;
 b=kAmRUkyJNzKKXQQJH2PU4t1TI1Bp82Yl9s58odVjx6+KQUTTkPLSuwXpyBTPEHErye
 /iR+sbBD9+gVDyFwQ7hBB62rO7Te78SCIZvXooaFrgEjsVnkGrrPTmXDGGqq6K/Ot3FU
 9WjRfLUB8IyEirDda4rYmLry+yUnsC4cQGeGr0EBy0TWvDYQm+Tyo+zQ7UszrnrKr3D+
 guSrKpJO1qakKrhTB3kWFYFhJAX/ojMlF60PumFL66DMD/7gqeSIINR98jVwTp4YC+RL
 i4fyAy3ESBHUsQBJ2ezpQ+uojJJqfrVCtMroZzqf41YmC8fn/1h/RXkBNERR6OVp9sLG
 s2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726783; x=1794331583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hqqeZR9hh82Ok/85fIviXaUdYKynKCQ8FaCgEa2tPAY=;
 b=Ur31wYxNLd5FHfjsmyKW30ZB5jtzdpQ2y0LVpff4qW6Gv76NLFfmhkTCm+nI4Wp6KR
 KudGF50hKVVIOn7RlHzHEPeFNp6VrlmMsVfPwhQt88OVcSExu+sRKTHdeh2so48Wia3D
 gvk87TM3JrcObJHqP4d1fl2jSaBlDeiKk0OQk8zjUK4j24YBIW0hEjqnaHSs23cAbO68
 LUn3J05mzJg35UH3dfaHeKEC7dnYF9daBv3/nUi9sYHzayfkHRD25VMVWUxCqQQLx3cb
 x+1yMsy2VjdhC+H19bxXs58qtnAO9ZgK/Sb/55fgmJGNFjiHaYPC1KTffJi1OOwjr4IJ
 mslQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4CsV8TGisTcjGijvuBTYYIt8uR0wJKWJdlxHI6sPfyxoz45hKVwmlWGICJGJr865A3N+NJ+/pgjxz@nongnu.org
X-Gm-Message-State: APuU4Z+iF2QDxpQs86Lec0EIHwzt2tbhqfZRoYCi4Bp/xaMaukfSdaxr
 1xtf7/E8QMcMXw0dtzdWRv4Rce30ti/NweZ9aRysi+VQV15kaFE6edCDehsCXDHgh9Pmep1AuOT
 coox0RI0=
X-Gm-Gg: AYBFou2JjSMTxjcPh5uO2GipAZrIqf8XH8E1a1lkOs8X2+FUS4QdeFDeQLFdiaH+Mal
 x+TJb5SCFnJwQpVC5HPa6cUEEbBtNP+tM1D0Cit6+cqXA7gWNZJB5nupkBIIkbVtfVpKja1oZeh
 PZDNv4NWbtQfynazaQ2hipP8f+JprLuoem2C3ZqBSyIt3wCcAwOPjj560PxBqxgAG+ILbBj9JJ8
 2IJRKVNW7Stc7BFnkDz0wew5zS1Hw2sKmLxXseNuyzt3FnHVyUFXgqYFmant1neF4/K8DmtxWjI
 AVt8/LZVTb7ZRn4hds+/sX7JA/YXo1Mf2iRkoIRTB+IV+aQxbW/aTPQ+USXEKdDjJdAnmwjCv9b
 857zq28hwsRDU2PHg1BDmB1OjzelvQTRDln8wdYy4Mvbuyc2nn9qfBpq9sDNKnCZwfwBblGoEzl
 TzyQx3VazgMrjdwEJmYbs9mg9R3CNdxgJryALCyHfOwRvpKiYUDni17ZrtusCSbRu6HyB5kXhLf
 laN6Yu0jUT08UTPNMkXTk1X7YXtyLuIC2PBlvykmsafIYqOu/N4ozd2R9zsd/uZjmeNlVFzumKr
 kuAkHlRgIRRz5leth2sc7cciWXLnP9BF5wvD7yk39m/pknnZlvn7jPNCeBpFsHWkcN/veorv+AD
 Om9x3BMejsIkoTQkmWfFbg1Rbv6jJflCL6zWtpkE8vJkft23ffOlJeog=
X-Received: by 2002:a05:600c:c48e:b0:4a1:f7f4:7cf1 with SMTP id
 5b1f17b1804b1-4ac16bc47f8mr316953545e9.11.1793726783525; 
 Tue, 03 Nov 2026 09:26:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0950d533sm211082605e9.3.2026.11.03.09.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:26:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.2 4/4] hw/intc/arm_gicv5: Use correct type for value in
 lpi_cache_get_hppi()
Date: Tue,  3 Nov 2026 17:26:16 +0000
Message-ID: <20261103172616.2400758-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103172616.2400758-1-peter.maydell@linaro.org>
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
to iterate over the LPI cache hashtable.  This hash table has keys
which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
value, allocated as "hashvalue = g_new(uint32_t, 1)".

The function is passed the key and value as type 'gpointer' and has
to cast them to the real types itself, but it incorrectly casts the
value pointer to a uint64_t*.  This works on little-endian hosts
(since we only read specific fields of the L2 ISTE using bitmasking),
but won't work on big-endian, and trips the clang sanitizer.

Fix the pointer type.

Cc: qemu-stable@nongnu.org
Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index fd6456cd8aa..a362349e5ed 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
 static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
 {
     uint64_t id = GPOINTER_TO_INT(key);
-    uint64_t l2_iste = *(uint64_t *)value;
+    uint64_t l2_iste = *(uint32_t *)value;
     uint32_t prio, iaffid;
     GetHPPIUserData *ud = user_data;
 
-- 
2.43.0


