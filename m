Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A041606A328
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d8lU3gj9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFbr-0001x9-8Z; Tue, 03 Nov 2026 09:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbi-0001uC-Nf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:28 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbe-0005B6-Qo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so39391485e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793716521; x=1794321321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGJAoAgsmnV3yxwEptk+FopChMYfVZzkGUZKHAkUyGs=;
 b=d8lU3gj9rumLKbUbTtZUf1mE3h/FA+nvwjLQMYUX2iVlDc+Cw5UhQ9vsXrrqb44gP+
 opUjmc1f/q/e1xC2RJKDZcRUDZaQRvM20YdPpe+cvadeuZCaE8NLfp8H27xvicvZ/ak7
 iw0nB3kQG8HulO+agiAx5OrHd3Miha79NTtxrqwGkfgoN95Y82JaOyp6JrJd7EBtJnUb
 fFladse8qECwdpUGxeV8hdLqtjfmpvFgHLpkHwSkpmU/tER1YS4d6/pW6PgUlnfjiL48
 ctRU4R5+jPi0ae+9TtdO8fMXg99Ei74tzqx/jsDvuIsG3HpF2fmQRiBh8ROnbqVxILRX
 cX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716521; x=1794321321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PGJAoAgsmnV3yxwEptk+FopChMYfVZzkGUZKHAkUyGs=;
 b=tA5WEWWNsHrlyMQ7PyJvKeI2f9A3K7UOnc1IqGMZd+hIok5uesF/V+TKz2SMP/6OcS
 2Fo+HOYZuQEoYpt6CWzninPKCPMfSU6AIwbB/pbKf4+qBFR/0mkpPbt95Qs/pRS9tv0A
 4YRw+nffbrb+aURcOu6IAGxTP8oOmuzhL+v2aOSf5YkzcwnD+oST7WokbHNuGkWLj/x9
 6dqtBPhApG8/4dmxcP5k4jq4bahEONBxeolOSY5XlVzoiSuOh4eR9y6J8Rg0zcqxM+6V
 c5Rm5gOLUIURNuLeva3dVRraSMCBS3JaQ7opwasIpBpKf22HtgemxdP5PF7He1NO8bFT
 37Cw==
X-Gm-Message-State: APuU4Z/uKVIWbUpKpNmy+pgPUldALNb57/qc1rgHUN9SKRKHJ8ZwbQ/n
 u8ioRjTh9NTjBOZIk4X6msBhrsQG3wF2SUGeOm3FFvOoxU5Y4rlnv+w0pCXK2lzVL2C6Dji3sXd
 RDRogWkk=
X-Gm-Gg: AYBFou1Urz+5a0FR33xTiIjmynuQkiuRbgJheTky1iSk7LfQLDaYEaYNuGW7Ilwu8Pv
 1SnV+QTKp/hP3tReMN7/Pax1un2qn7ATPgJpwipg6vUx1KmE4kd8FGxyjt0NOqSVZRd8Rerwmo1
 CNbBPpNS8nTApchVdUNG6yEygK1A/tmBxYaFT14LW92EUiaqkpSMqPxWMkvTPuPYNZvsYfGU5jn
 VaKyPzGGJpRGzdFhD/FCr7MDVz2DJtqWDtZn1jwT0Pa7pMTHveV9+UbdoH5BSKALsxwntVN9zm7
 N/A91OaZ1p/a++A6wII12sYVq6CN8TX/LE0Dfz0VYm4KJ+zjVFhNLUHaTaPI2YHy5v1MncKAEe9
 SI8P+NVw1/fOWrV1IeY/AcmQsdZXOsTR2j6OjOrPMgsZeUCTGYn1o6700aHX2mkwLDU9BbiQ663
 01qmpTSfjHPAhB7ZwvI1dVGx7pUTxCaa+Egnjg0baBlDivM4R74v1vsnOjtv4UJtQ2f33IWm8RO
 0fUU4CAz84kzROY1Wh/in/nQ7apH+X6we/7pG53FuuekHsXpnoLtva2r0gBXRGM45qc+hONNXLn
 8Kw3DRrjIRSY3nXN0T/Q+Ly44ogdYU3Y067KGhwTInmLURaEBljFD8wkMFvMIY9GMsmUNQeJAbc
 +xG+V7TIjDNjQDY4S41t8tQhIEEbb4c743g==
X-Received: by 2002:a05:600c:34d4:b0:4a2:d7e:5ccb with SMTP id
 5b1f17b1804b1-4ac182dca99mr335360785e9.15.1793716521252; 
 Tue, 03 Nov 2026 06:35:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm61100965e9.9.2026.11.03.06.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:35:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/5] block/vmdk: Avoid reading off the end of descriptor memory
Date: Tue,  3 Nov 2026 14:35:13 +0000
Message-ID: <20261103143516.2182626-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103143516.2182626-1-peter.maydell@linaro.org>
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In vmdk_parent_open() and vmdk_read_cid(), we read DESC_SIZE bytes
from the image file into a malloc'd buffer, and then look through it
for a keyword using strstr().  If found, we skip past the keyword and
attempt to parse a value from the next part of the buffer.  However,
we failed to check whether the end of the keyword is right at the end
of the buffer, and so a malicious image can cause us to read off the
end when parsing the value part.

Check for this condition before attempting to parse the value.

The worst case here is that the image causes us to read some junk
from the heap into the BlockDriverState backing_file and
auto_backing_file fields; the image could control those anyway, and
it's unlikely that this heap data could e.g. be leaked to the guest.

Cc: qemu-stable@nongnu.org
Reported-by: router0mail <https://gitlab.com/router0mail>
Fixes: 5f4da8c0f3736b2 ("New multiple snapshot support for VMDK")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4571
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vmdk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 86059e1fa08..6e4e0423dc9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -337,6 +337,10 @@ vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
         goto out;
     }
     p_name += cid_str_size;
+    if (p_name >= desc + DESC_SIZE) {
+        ret = -EINVAL;
+        goto out;
+    }
     if (sscanf(p_name, "%" SCNx32, &cid) != 1) {
         ret = -EINVAL;
         goto out;
@@ -508,6 +512,10 @@ static int GRAPH_RDLOCK vmdk_parent_open(BlockDriverState *bs)
         char *end_name;
 
         p_name += sizeof("parentFileNameHint") + 1;
+        if (p_name >= desc + DESC_SIZE + 1) {
+            ret = -EINVAL;
+            goto out;
+        }
         end_name = strchr(p_name, '\"');
         if (end_name == NULL) {
             ret = -EINVAL;
-- 
2.43.0


