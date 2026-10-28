Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1314606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Xch21V/9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9qa-0001cx-UT; Wed, 28 Oct 2026 16:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xM9q7-0001YD-T2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:01:45 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xM9q6-0000pc-29
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:01:39 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-15943c9c005so385127c88.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793217696; x=1793822496;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iqnUw9FLhJP2iszbEYV3XU7KkM54lm1JBi81oyVkTv8=;
 b=Xch21V/9L392DTMI4gTOWRYwLJeBpLOFGXOyk7E8xz1bJxcdoZdX0hk91vhaDxRnx0
 JeK6vB1TzhQCep3CrYLvBDaVNWk0cnBAxj4vQpbOBulxrxxL3/P5sWCltwifn040ae28
 wc3IyNP3lmtiubtxpJdMSOY5cflbyj4qa1SdxkP1juUIELU/6Aujj0s3fv/z4xlvuqFN
 4Fe2pDYy/nnCyETzh+5L7HVZ/ZpjbKqlDDsxacHkoDDBZi6vn1Kavq+rOgsn5SKDt1zM
 l0jW09zzeg6odLSbwE7jYO6oEJe/Dbb7BmySgurqYt+nzTr9EBE70eRj8oLs8fEjHR6S
 IPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793217696; x=1793822496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iqnUw9FLhJP2iszbEYV3XU7KkM54lm1JBi81oyVkTv8=;
 b=fr/vfSOVpVyEtYJDeUbHnOM3n4FOhhFZuqFM8DgJdiN2GnNsoB0I7BeiRY6PXq1+zg
 ZTv2hGkJu7oV0I8Ao0jhxKakVDXAMft1KAdxvbYWcgdwrjoJ+NDlPSjaruY4nZzTxx8A
 D2/3a3pCT43O3n8EUFdjz4VffsXjEt2BaTR+4Y2wVdtAg+BSCvBJeLHtauPXOL6XO73K
 LhZDk7S3+k0tzmp/EEghMzbMUKpCHE7n1n3agQTh3B5OO4zrezzXZ75Kj5WZVyk90QE2
 CRG245SccPZ6JUQBweygXEM0ICPJbZPjkJGVoNb2et567+sRFOrA1dTHmdvUgrzqgLDl
 JIoA==
X-Gm-Message-State: AFq9FYLTtPc9v1x/ZJ7m3t4CMVz0cpEBACai5VZqiJJ978geb/eGvsyk
 O9WMGPEelu/02IBrCmEeorK8MUbNOOr++ZjqKTHhqZKiCOmcfyWykr33vX6ZebMmJH/4HoQi6Nf
 Mg6Mn
X-Gm-Gg: AYBFou2HZH53/408uPPmxx3bvhu6gRZ2pHWV/gaqY4ul894XXGtoueaYdu0GQvW6k/8
 ezsRaLqhEe00h5SR4mEWGWjw2tEy9p30Gd37yE9Q7hLRJrqIYuwXKMmNgdCfMIL8e7Wvn2WkXYQ
 I/Fy9DAK15jMnIQ3txMnUWdg2N4AFJqUWHZ44NPWs0VCX7/FvPsNYyngsPws86z5nA4w7Gu8E63
 o8/tD4C8QrwPakkzEP37VBJ1OkCPpiz2I7d1Bwu0U/h+LR3uqiPkm/dodbJjltg57arPvFo1Hhr
 fiQ85FIsAwbwmZpS54L7yZyBR/E40FV6DRtDHqztdg25E8HQ2EbLfHNlm59/DD7UGU57JpspKTm
 KfmaZfokcihZ/gndETlz8/TmGCoV0UlBNS7BlKD6+Ei5FMqQw5nOwLF7oU5L3Je4gYLWjzD0oWD
 l6Dc170RG4XG+4EE+UKWwWhVJ0C+5IXszXuoEZDS+RLchf8f3E0Rt4o7mEU3gCXqjSyI5LIc7/r
 EB7bZdm/DYJFAy3btPhNEnxtMCihpdaKvAeETD5AQUJrFa/8j0hCsDIE6o20k71eLijfBZbgDom
 CiLCEZu0cx2etFz7D4wclT16qaImGpqBrDiBSMubetPEvGiaRIYoCN1xpjTM2A==
X-Received: by 2002:a05:701b:450b:20b0:1a7:216d:157c with SMTP id
 a92af1059eb24-1a7216d1658mr4085256c88.34.1793217695570; 
 Wed, 28 Oct 2026 13:01:35 -0700 (PDT)
Received: from tewaros-mbp.localdomain ([209.249.241.138])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a5594efsm10537589c88.2.2026.10.28.13.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:01:34 -0700 (PDT)
From: tewaro <tewaro@theorem.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 disclosures@theorem.dev, tewaro@tewaro.org, tewaro <tewaro@theorem.dev>
Subject: [PATCH v2 0/2] target/riscv: report the no-PMP-rule fault on the S/U
 fetch rather than on mret
Date: Wed, 28 Oct 2026 13:01:21 -0700
Message-ID: <cover.1793217528.git.tewaro@theorem.dev>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=tewaro@theorem.dev; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

When PMP is implemented but no PMP entry has been configured, QEMU
raises the resulting access fault on the mret itself rather than on the
first S/U-mode fetch after it. The access is correctly denied either
way, but because the trap is taken before the privilege switch, S-mode
can never be entered on such a configuration. Patch 1 has the details
and the history; patch 2 adds a tests/tcg/riscv64 system test that
fails before and passes after it.

This is not reachable from S/U-mode or from a guest, since mret and
mnret are M-mode-only and PMP is configured from M-mode. The affected
software is firmware that executes mret with PMP present and no entry
configured, so I do not consider this a security issue. The same
symptom was reported in GitLab issue #2074; the earlier discussions in
Launchpad #1923197 and GitLab #585 were about whether the access should
fail, which is not in question here.

Tested with make check-tcg for riscv64-softmmu, and by rebuilding
v6.0.0 and v7.2.0 with only the mret check removed to confirm that the
normal PMP path has always handled this case on its own.

Provenance: the bug was found, and the analysis above was debugged, with
the help of Claude (Anthropic), used as a research and debugging aid as
permitted by docs/devel/code-provenance.rst. The code and the text of
the patches were written by me.

Changes in v2:
- Rebased onto current master (73294d096c). The new meson.build entry
  now sits among the tests added since v1; no other change.
- Resent over SMTP. v1 went out through the Gmail API, which rewrapped
  long lines, stripped trailing whitespace and replaced the Message-IDs,
  so it did not apply and the patches were not threaded under the cover
  letter. Thanks to Daniel for catching it.

v1: https://lore.kernel.org/qemu-devel/CAEq2Q90UbCK2=7SFGQErviup1=u0AYVf=n90NaJvo1M9N=_BUA@mail.gmail.com/


tewaro (2):
  target/riscv: do not raise the no-PMP-rule access fault from mret
  tests/tcg/riscv64: add test for mret to S-mode with no PMP entry

 target/riscv/tcg/op_helper.c         |  10 +--
 tests/tcg/riscv64/system/meson.build |   1 +
 tests/tcg/riscv64/test-mret-nopmp.S  | 100 +++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-mret-nopmp.S

-- 
2.54.0 (Apple Git-157)


