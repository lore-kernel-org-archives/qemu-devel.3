Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF15606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TJ48fmXr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJk1Q-0003nd-5L; Thu, 22 Oct 2026 00:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJk1O-0003my-2G
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:03:18 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJk1M-0006Ar-9g
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:03:17 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5eac319a6c2so1304545e0c.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792641794; x=1793246594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zuw0OJSWmr5QDxsUVBa1EC4RdPVtV7sYJcTlPNQ5FWY=;
 b=TJ48fmXrmLGaol2mTijQZFjV4BZbEnrjqSi2qU/R6CXRXb2rY95zUc+kWo48vSZvly
 yTf35r77ClHWs/rxK1MkdkHUTrNdiAs25n2Vt3DdFbbxAKaITUfij69ZE4czkHyGMaz7
 O9KzwiSzZqk9Lo1rWlvry0fYem3rR2WmfmiG7x+RJChvqdnTUGSaUDv2L3JFWhwc+JWU
 oOSikSG6Kd29VvxUw3PEebNrEZS44vtOg36nyHd4zkCh1TLlwOJxJ6uJ2+uLw1Rfihml
 ycM1QSHko4uA2trQw0044kU/wBeykbKSSYxiONjJpoK9AvUSc+t423u47PrW3hwa1nod
 LfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792641794; x=1793246594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zuw0OJSWmr5QDxsUVBa1EC4RdPVtV7sYJcTlPNQ5FWY=;
 b=l6lkKT+lNpDW9n8HzuAPAH9Z/DVPfTcm10tWq3ybOmJAwPzO7WMtLjYAWqD0U6IceA
 Nasqif4hc8mxoMtPhQw7LTzJ44GkPBD7OT2vG0VKlsmE0v6L8OS9ZtkE1/ywe5hehSbc
 lBn2tpbmzCkz6kJ52q4zVHVpZ9zNWAPOqDil+Fw/UREzHVJ4JpYLCwbp+DrAh0s8Iw3w
 tIYYRtpIxbDiT9QTOdUdYhuJ9wF3E9jcWvkhp4zp4VucTM6n2sy977eajRuLWZROkzTk
 wCJUO5jCPqrKujJmOQYpurDU0JvgpMcGqFJn6a7XTcfzLdWG0n8V8qoExWY61aiAQC4o
 wuXQ==
X-Gm-Message-State: AFq9FYIZDxuGbo3viB1xBTZEtmRflr4Cp+YVyEb+1GnOlzZXSb4oVH9l
 RKsZ6t05ACYACx/nWlbL207YTNoB1Npm6pZAwg/R3eHY8oyX5xcNgA+zuZMh4kb1
X-Gm-Gg: AYBFou2JZM3DEp1+vveShltUJ8AHKewA0RFjKSAjCOTaBAX32QOqRHVvrc305CVYrM9
 LqfCJgUF41IqbqWOCxtIov2I5Ud37oJy2WgKl/YqooG5NaWwLnvUUPfDzXl1MAg5w3Wi9U/E1KC
 lzcTHscWUP96TjQxIrnntVwf//N+cirsB1FKlyHlylsbGSIdJwK7zN6mb+RZar9ir52arY+ifmX
 OJHc3KSHqSlM4cQue2TNcEf2ynaSVKdAMmfMoXE247EiCg20GZ3J4+s6PfITe0TDCACxBcbMv/9
 X+RAP1kbUIBMkCMZ6H/w5Cty36DNKsytRf/2bKduTSiOuZPddjpG1SvqxvRVv3zJYfW2PIIepx5
 UtR59kmp8BgyQeIfxcXd5kl+3GWcvXIa995Xg+ihApv+4tDRfJh2qZdl684ReOO/iUds8gsxjRe
 cYRPJ2jXYFwvAJ1xH/aBvcc7zjnnCT+CqeuG8J2xPRKd/GPRwK311uR9LVngABxgWNwUtpqDAF5
 /QZ+4BVwAHcUF3uaFrV/URm6d9fMsHkalV1sHLCSaWhUoaeKpvGap2Yq5fcdmARUDQepHEGp++s
 /hniL4VMroveVLOq3h9rW9RNuz6xBP7YyEO8xaxo9tCd
X-Received: by 2002:a05:6122:4909:b0:5ea:c3bc:c567 with SMTP id
 71dfb90a1353d-5eaebdb8be1mr1837607e0c.9.1792641794537; 
 Wed, 21 Oct 2026 21:03:14 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eae969803dsm5859810e0c.2.2026.10.21.21.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 21:03:13 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 richard.henderson@linaro.org, Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v3 0/2] target/riscv: pmp: fix stale PMP state across reset
Date: Wed, 21 Oct 2026 22:02:56 -0600
Message-ID: <20261022040258.1509306-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=sebasjosue84@gmail.com; helo=mail-vk1-xa29.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2 cleared the whole pmp_state with a memset. Alistair pointed out that
the priv spec only requires the A and L fields to be reset, so v3 splits
the change: 1/2 stays within what the spec mandates, and 2/2 handles the
derived state QEMU keeps alongside the architectural registers.

1/2 is the v1 fix. It bounds the loop by the number of implemented
regions rather than pmp_get_num_rules(), so entries past the last active
rule are no longer skipped.

2/2 clears pmp_state.addr[] and pmp_state.num_rules. Those are not
architectural, so the spec does not speak to them, but they are
recomputed on the pmpaddr and pmpcfg write paths only and never at
reset.

The second one is observable from a guest. A bare-metal M-mode program
configures PMP entry 0 as NA4 over [0x80100000, 0x80100003], resets
through sifive_test, and on the second boot performs an 8-byte load at
0x80100000, which starts inside the old range and ends outside it:

  tree          pmpcfg0 after reset   8-byte load at 0x80100000
  1/2 only      0x00000001            load access fault
  1/2 + 2/2     0x00000001            succeeds

The architectural state is identical in both runs. The difference is
that with 1/2 alone num_rules is still 1 and addr[0] still holds the old
bounds, so pmp_hart_has_privs() skips the no-rules short cut and reaches
the partially-inside check. That check calls pmp_is_in_range(), which
compares against addr[].sa and addr[].ea only, and returns before the A
field is ever tested.

v2: https://lore.kernel.org/qemu-devel/20261011040617.807504-1-sebasjosue84@gmail.com/
v1: https://lore.kernel.org/qemu-devel/20260916034331.2390427-1-sebasjosue84@gmail.com/

Sebastian Alba Vives (2):
  target/riscv: pmp: clear A and L on every implemented PMP entry at
    reset
  target/riscv: pmp: reset the derived PMP bounds and rule count

 target/riscv/tcg/pmp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0


