Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD3606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dM+BzQy4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaSs-0006i1-DJ; Tue, 27 Oct 2026 02:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSq-0006h1-GY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:16 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaSo-0007I6-KH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:15:15 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36661f953e4so6973292eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793081713; x=1793686513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LRYz+dlQoSONyp0BXwSYq7ZlnjpZB1CplJViHM6aMwQ=;
 b=dM+BzQy4JLnEdHbOT6+tlDzbiImPu2H19aY1IlcclKNhWiM9MhXo2YtFvrYGSHK9aG
 chXGd8eofGYvVUTHGihA2GMoEOg1AZPgRFUV7N+bn/oW+5y+gkhwnmxztjM/eR4nFsGd
 I2fd4VCLYYjWsaVO5pj1M15BDWnMeU1gmruAk5DvBBu/m1zccu1jhabhn1O33YBZUdU6
 HzZDsVdHrOk3kb6sPNZLeMMj4IX4ouCoMUZvrd5Te3tZp66Uo/8RBl1UCnBqtnailW99
 X73j3QoiCW9bXr0bDTVWZO80DMQvkNnVgpys/Zs+nPUuQgtIV5r6NA8y3G70PXQK/VF4
 eqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793081713; x=1793686513;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LRYz+dlQoSONyp0BXwSYq7ZlnjpZB1CplJViHM6aMwQ=;
 b=f6ekamDnPjQMuOYQsJhbOZA/rxQWaZRzdYfRyYghKWbciPy9CEEdDk7zqyzBcb+2CI
 g3/+HyM9cf/vyGCSNzAoJB02gjGxOndUnOobeUiBu0ljZzaiARbfVNvy39EQU+p0KOLc
 oBTXhIboFk6/Vu5KmXY5QnEYwTaso99Up2m1CnwdbEHf0jD1Fp6fusK54IrfuJHPrgVU
 fV+cYU3In7fllXsKfqvBomfdFFkYGCmb20XTZ7zTG2okLmQZzbigjqnKfaynPPaG9HD7
 ZwT8IuzyPhjFnNik8N+6Y5fLg/OXng89+poAY30fyckK9C4trvOShOBQTjCKzvH/mou0
 tj0g==
X-Gm-Message-State: AFq9FYKCEObvt+P03N4lpT4HAZ62WAFJo2vrsjez7z7TNfgadjiHITpH
 e+gOPAOjMyIOrjnXFy8/AvevlQz+Gl3Us/Up4ADQo4CalZASbuv8ZAJK1HQBvaQU
X-Gm-Gg: AYBFou1K72KdBiXbEU5iyz5deE6BVpemPn4WZxxNDP3WVevUySnJ336nDYgovfSEqsf
 F918xSLkyqlO5RgJQuaKa2T2pZyv+B8Uy4QY6HATWBv8uH/5+SD9EYY5nDOESpIFVuUErtSm4pP
 gCu7T0FVsvdUpoUS6+71aErf0xVlBGPSJuIabdqNzQDTi96LSvY5ERAzqYgFLKRsy13RBCyiass
 AVrMyTeIESGjmsBQVa3WtfyXO0Jg0JJUuGMcrMkBMNayj2kTM1Xtn9SHRQ/SQbiwEWWz6jOWL/E
 BlRfK42VSWV1wyCR/jpmGol8KzpeIhZAA7ZvbJGIQWELivYLSiTB2p8Cxgl/VeUgdkg6ZGa2Pvb
 uyuFs5NsbTChmWc2GLKINHQLZN51tcfLvy7TFbweFSvsCCqHniUz+Di+iVnuxRXTBLuNptJqtP9
 KrNzubc4nAT17/2AFyguXRW1+n1a4iY9lXLfxKxTLDHcl/HBtmZa5B+0DDARe+M1OXDU2NYk5cy
 Z00Ny3Q/nDfs4JypuabzYa0PZzehkFtJls0jDhXaSdtDWqdJC6GyX8SnoM0cMpIcQ3nwutFm6s=
X-Received: by 2002:a05:693c:69c3:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-369e85083fbmr12116813eec.32.1793081712258; 
 Mon, 26 Oct 2026 23:15:12 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec864fsm37346980eec.24.2026.10.26.23.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:15:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] Widen QEMU_ARCH_* and arch_bitmask to uint64_t
Date: Tue, 27 Oct 2026 14:15:00 +0800
Message-ID: <20261027061504.2213-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132f.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU_ARCH_* was defined as (1UL << target).  unsigned long is 32 bits
on Windows and 64 bits on LP64 hosts, so the mask width depended on
the host data model.  Define the bits with 1ULL and store every
arch_bitmask as uint64_t.
SYS_EMU_TARGET__MAX is already 29.  With a 32-bit mask, __MAX has to
stay at most 31, so there is almost no room for new targets.  A
uint64_t mask raises that ceiling to 63.  It stays 63, rather than
64, so the all-targets mask still fits in the int64_t range used by
qemu_opt_set_number().

Yonggang Luo (3):
  qemu/base-arch-defs: extract QEMU_ARCH_BIT for QEMU_ARCH_* enums
  qemu: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
  qemu: increase width of QEMU_ARCH_* masks enums to be 64 bits

 include/qemu/base-arch-defs.h  | 67 ++++++++++++++++++----------------
 monitor/monitor-hmp-internal.h |  2 +-
 system/arch_init.c             |  4 +-
 system/qdev-monitor.c          |  2 +-
 system/vl.c                    |  2 +-
 5 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.55.0.windows.3


