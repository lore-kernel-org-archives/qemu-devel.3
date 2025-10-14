Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7790CCD183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 00:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Svu-0004Kp-VS; Mon, 13 Oct 2025 20:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mZntaAcKCtA9wH4z082AA270.yA8C08G-z0H079A929G.AD2@flex--navidem.bounces.google.com>)
 id 1v8Svn-0004KV-VC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 20:30:25 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mZntaAcKCtA9wH4z082AA270.yA8C08G-z0H079A929G.AD2@flex--navidem.bounces.google.com>)
 id 1v8Svl-0005lW-D3
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 20:30:23 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-32ee157b9c9so8314898a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760401817; x=1761006617; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=+BwZrciRbs9GywEhykmK6YJUut1oy/kwLrAZt2xVLUo=;
 b=YKAJDT5/EWBCfUTS1WN1a0eAQ+p5FaCM9zI+sskyAV+7xU3xilVBGNf43bXIUDR1UA
 SP884KuA6Wjxliijl5Kv9H7hf9tK1dAUA/nvTkior7KOg0xIaE/YBFTY4i8IoX/CVJYO
 nfy5OxWswyBpt3OBb+FqzLTKX4G8P6UPl6oEnI8LZC/tz+aqgm9S2UEdT3ZM7LPLcU/5
 ZD+WdC1ynBAv9F8NyVldyPDgeujuR4iybIGtJtcwqtl2OQnbdwsaQJFJRSZbRQhHphS4
 90JcmXyPxse5HmhMZt7Y40oETQkOg7kh4xmfKqcCUrQw+YvpySj3Zg2TThBhbiI/avcI
 SAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760401817; x=1761006617;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+BwZrciRbs9GywEhykmK6YJUut1oy/kwLrAZt2xVLUo=;
 b=GdadYtdWCuPRJ5QZQcgwXKYQyvkzd0HUUWog8YcJBHfUV4xrSiHcZv52UBcXuoRlYO
 3HiHfjy/Kp6qP8yJm79vf3iVdKlgwK4j1Btq+IP9KFW2Ph0k9pJXgWhJ0jXLalf+pDXQ
 pjCgcXJ4nQ0+/owTp+Nan4g0uTrwx++Y9e4h+2743bLv0roDyDhTP8C7r+eSV9uM6LPk
 Kx2dN8u9pA5rutwTxWrasa45Ukzw9bmbVVxeICTLkT4z+i8/IZuwTCphKd/giaK+hUUp
 WBrQEmHcjDUyJh1PRIq50MOB3W6z5R4xWpwzV4ehKkOhGsLNrLXOBRs/WCoHOnnE6fPz
 RQOg==
X-Gm-Message-State: AOJu0YxQGFq3tjYp/txYMvtTlPUvxdPY3VXVwhdWeq+DROR50e7P75Wp
 lsgadXPB/PKc8erUoC3s7GUSmusyAS23v4Q/x16Nz3nVTBV03PNMNLDwGSPZqBuF+GEzJksKZGi
 tAWTRrMQgEg3y9M6jYFfdJk2xNuqgkVKK5KkpGY7MwPACjmW7HHlyN2SdymCMWcyNCD3+3VesRi
 wq9OF/ibkHCqgrHgpbIypBHL8LNWcQONnpSndGqX+z
X-Google-Smtp-Source: AGHT+IFxkSpwySCEVaIdYzAD1aWKLy5OTrYYZcz55mzvuD7JcUzYtfbSQjSu7sf23E8vmotWE6gapTMfovQI
X-Received: from pjbin20.prod.google.com ([2002:a17:90b:4394:b0:32d:a0b1:2b14])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3511:b0:32e:5646:d43f
 with SMTP id 98e67ed59e1d1-33b513b4c25mr32099428a91.19.1760401817106; Mon, 13
 Oct 2025 17:30:17 -0700 (PDT)
Date: Tue, 14 Oct 2025 00:30:06 +0000
In-Reply-To: <CAHUE=o-aypvXPxZXssD8nMJm+Qa9Nsp1HRcNVbC27tNkpV75fg@mail.gmail.com>
Mime-Version: 1.0
References: <CAHUE=o-aypvXPxZXssD8nMJm+Qa9Nsp1HRcNVbC27tNkpV75fg@mail.gmail.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251014003008.2520701-1-navidem@google.com>
Subject: [PATCH v2 0/1] tests/qtest/fuzz: Add generic fuzzer for VNC
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org
Cc: alxndr@bu.edu, berrange@redhat.com, Navid Emamdoost <navidem@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3mZntaAcKCtA9wH4z082AA270.yA8C08G-z0H079A929G.AD2@flex--navidem.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Alexander and Daniel,

Thank you for the excellent feedback. I've updated the patch to
incorporate your suggestions.

---

Changes in v2:
- Dynamically generate VNC socket paths to prevent collisions during
parallel fuzzing runs. (Suggested by Alexander Bulekov)
- Add a WebSocket VNC listener to the fuzzer to increase coverage of
that transport protocol. (Suggested by Daniel P. Berrang=C3=A9)

Navid Emamdoost (1):
  tests/qtest/fuzz: Add generic fuzzer for VNC

 tests/qtest/fuzz/fuzz.c                 | 65 +++++++++++++++++++++++++
 tests/qtest/fuzz/generic_fuzz_configs.h |  5 ++
 2 files changed, 70 insertions(+)

--=20
2.51.0.760.g7b8bcc2412-goog


