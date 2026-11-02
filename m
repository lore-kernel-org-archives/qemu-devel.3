Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642B606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEeyUTMJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNohF-0001k5-TB; Mon, 02 Nov 2026 04:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xNogy-0001hs-IA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:51:09 -0500
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xNogx-0003Qk-26
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:51:04 -0500
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-3ac749e0719so710108a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 01:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793613061; x=1794217861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VITr6p42mHS1RDZO9W7u7/zI5AKlnfCY+2zDIn1s7+Y=;
 b=xEeyUTMJfJxoIUaxmp6OcLt6yCpWaAhje2ucVUvh9UjPJX4cL6X0Twi+b5ZTaNubWA
 Rrvn2+3N/cCgJb5c4gPEWNpheJupsgJ8LUVLC93zOga+KY9PCxQzHN6RvqzJsWMtsZbg
 s5DLtxlHejKLjaw3LHssSa5hquWS6478IgXdkehmRl2z7/+RRW2EdcZyEqKsjhpIMV3l
 u7D/ZkCksuPz3O8XenI4+V8B5aJ+vqVTwhV+TS8qLwZjuhK3rw5CvgdN83rwX1z+RB8i
 GXuJGboGzkBcDj8RkMEEPJvWrICNaHuB8JsvUh1J+AK8pPgByxHxLF42T79by8m6zHW+
 eKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613061; x=1794217861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VITr6p42mHS1RDZO9W7u7/zI5AKlnfCY+2zDIn1s7+Y=;
 b=luFrUZd7TMrmYtzn2SStySlk5MmSllsUuReh7PGdMuvQoaJb/auMUuuq6U88pBJ4Qr
 kjcRNQgpuLgvswsBYMKsCbkyFtj4d2Ex5UCsOldVxq9SCeA9qRp4XIidrj4GQ29XZ6zV
 xCyl1IBMZ6v4g6ZIOBAvf8fcCHCiK7VrA/QYAtboo704n/fUBpjbY/nBR7GAruLAuocR
 XQf2/YXzQXDxZ2No21BsXhBWu2iTXQr8RpxzwfnhLCOu+ZvZgSzqNRg6V2e9VtjdQTZc
 eKf6Zs76mSOL1vUCHt5D8HVnZcjSjUmi9ginJlUmG71egD8TKhl1wyYj6FrNhN1LZgH7
 C53g==
X-Gm-Message-State: APuU4Z9d726NGdu9G2sgqSxXYmO4WSVamyJ4WKy/XPbn1YysFBgUTM/U
 8V3o75llXfBaw2/rUFe+hpW2SjsWS926YPBeED5RV/uazTF6YhvZVwDO
X-Gm-Gg: AYBFou2RBT24n+kwlJ8AfN9DhRfd4cCG/pR/JJ8tioS/qPDM6ntvQjjjX8GqwG9+zrR
 ymqIO6p3EL7arcGxaiLA2ywfs2znrxM8FrFicSo9uF0iDsSfl4PLOjimm8dlFFc9+PNyKX0Wq7D
 comzMsFQF3UuwZrXgOTLujRI9LiLWAhcatQV24oMXSTnhv/AOE15uodYkShMpKU5QXWoKOYpOkR
 rpgdPMPy4Qm7Ftgh4aO/FftqlIjezJ8Pp00rJ5xmg91er9Uoqq8S1wMSu1KxCBZsxXOigjm8bdM
 /CDG/rvXcAMlmud13vFol6rAZHRP1spCcAciS1DYqKv+nv84emvF0BEjlI380JxWf19e1zvpqYO
 q9L9WrfYqa11DPiBdm6fxMT19T3wyaKf+jB5qGf51YYQBMBykd0w8V7kLNnLJcbAbcTvtI+IaFX
 v6bRdLPMM/xBYjkO2iru5UzQjRBQJc/WkhgSR48aLbPkN28mWkMJsm82rypjgkN2WJ7QJjxhsm6
 zEclUaj9hAb8htOgWkyCCwdiiXSaaJHI5NocQlhUwLVsJIdVVxkzb01/zxWRdNVA/WSwpKCO/DO
 zZlXv3V1qJkxnwT7QS8UqVQ+WX3nayC15WyqAjGigVu9zrgcKbrLcBe1gRRcFI1JK/v7BeWWmnR
 W55IG
X-Received: by 2002:a17:90b:5111:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3ae89772eaemr7254122a91.34.1793613061151; 
 Mon, 02 Nov 2026 01:51:01 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([185.244.208.247])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8805ebc8sm7862280a91.3.2026.11.02.01.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:51:00 -0800 (PST)
From: fritchleybohrer@gmail.com
To: alistair.francis@wdc.com
Cc: qemu-devel@nongnu.org,
	Zephyr Li <fritchleybohrer@gmail.com>
Subject: Re: [PULL v2 00/50] riscv-to-apply queue
Date: Mon,  2 Nov 2026 17:50:49 +0800
Message-ID: <20261102095049.31551-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::7;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x07.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zephyr Li <fritchleybohrer@gmail.com>

Hi Alistair,

I noticed that my following two patches were included in the
original RISC-V pull request but dropped from v2:

- target/riscv: report WRS.NTO opcode in tval on illegal instruction
- target/riscv: save ELP in MPELP for NMIE=0 exceptions

Were these patches deferred to a later pull request, or is there
anything I need to address?

Thanks,
Zephyr

