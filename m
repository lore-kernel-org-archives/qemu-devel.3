Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4145C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6ru-0007mh-Fb; Tue, 13 Feb 2024 23:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6rs-0007m6-L3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:32 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6rr-0004Os-Az
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:32 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7c488a5afcaso1430139f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707884848; x=1708489648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fR4Dglf1jFUKRd22MhzxQ9Oec+I2i4IAJu5Bg4Ltrz4=;
 b=ffgQMxny1K1ausLL6QqwZqYpSDHr0FbRehZ2sPaG3r9HhV12PpteisKUlQHMioh/SD
 R/bLrH0QyfidAi5yPjFforFUFdegZJKtWIYUaMw8tEmoxNO4dY/qwDZn9STJ3e3cZB4C
 Nl2PwUl1v6fdrQNhs79yqbAPIYqYlHmpLXwsL7Rlxwd9Hr5goPaM7Xjvw4blv1jm/B1m
 5J6MyMPUL5c9b1cySlI9IFbyttciiUW1+k6rD79Brk7BnKkUfzdPSQARs9xyVttItgwf
 SE8GiTYNIsgVF9dmJpEvNc0Wfx3+Crwm9ZrYCAPeNF3GS8ccm/vBDBObEHyHpNcCxQlU
 x0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707884848; x=1708489648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fR4Dglf1jFUKRd22MhzxQ9Oec+I2i4IAJu5Bg4Ltrz4=;
 b=cRpXBCASHOMn5G6m5Sb2rbel9tsMDSRM93L7/nHDNL+RkXnmaWQIxYLlaLB0Jb2aVk
 SiP8UdEw0AuBzge1AfhQuNc9FF0U1vQdu9JXHG9jf3GzT3IEFNwutw97LzWle5Vc/RoL
 sZFbOMUqE7RfFHbIBlBuF8m6arFg8kkOu6sFssqS50Mjdp8ndZgc3z5YZPiVagvOzRzQ
 Vo9vMTgT+lM3wkEjRDkSFpAquixxOqftpHXFEHE++BQ5YZC+VfEBInhOc6sMDJYwRBrk
 UIvmqbzq1e3Fg3bWwq845AWz0qk1UEczqD5h2XvjQPv4h2Kvh6S65SAFRQANNzC6zrXh
 bncw==
X-Gm-Message-State: AOJu0YzEsdtsJ6xo5FHzw7E2MTJuHl7iKW7mlc6XILdxloO8r8kfYOBg
 fnoQmDvGpr2POKb9T7odU4fnX3aOsd5eqbAa0zSwAPDj+36R3xNexsaKPQk++rY=
X-Google-Smtp-Source: AGHT+IHDA3xG8RfJ+QiKSDhO/3svMxyMTB2O6TRxGqIIF2HKBDywSSPDQo7K4/1tmiBOBOLDfAHklQ==
X-Received: by 2002:a6b:7515:0:b0:7c4:5e08:f265 with SMTP id
 l21-20020a6b7515000000b007c45e08f265mr1787452ioh.13.1707884848655; 
 Tue, 13 Feb 2024 20:27:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXZpuyyx5T+KwNp/OixFb43w8nOA/4xCESr+G7EcuqYCvzzNPnbScZOA0v+OuWaAVUP6yPQUGQUAYl8fVlAB1sJ/Bksr1+SM76rwbx0QVX2JZj+YFewnBtQ0Qn/Sq6JM9TuysmXmQVMwDjByGv5NfUUJlou9MN7lyLB2cLPJgP7lttg+LO8WJf/H2Ak8SqN3fm7UUqhKis5a/nfQfgFsVS200HDFKo870RSdwujaRrSyC6Jw9NTkC6XC9L1G2HLLC2CCmFLTFijoqHjircKLODSnRH5ZojMd7q4pym/
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a02c9c2000000b004713170def2sm2312305jap.93.2024.02.13.20.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 20:27:28 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 0/3] Hexagon (target/hexagon) Only pass env to generated
 helper when needed
Date: Tue, 13 Feb 2024 21:27:23 -0700
Message-Id: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, we pass env to every generated helper.  When the semantics of
the instruction only depend on the arguments, this is unnecessary and
adds extra overhead to the helper call.

**** Changes in v3 ****
Update copyright year to 2024
Mark Reviewed-by/Tested-by: Anton Johansson <anjo@rev.ng>

**** Changes in v2 ****
- Separate patches to pass P0 and SP explicitly to helpers that need it
- Add the TCG_CALL_NO_RWG_SE flag to any non-HVX helpers that
  don't get ptr to env


Taylor Simpson (3):
  Hexagon (target/hexagon) Pass P0 explicitly to helpers that need it
  Hexagon (target/hexagon) Pass SP explicitly to helpers that need it
  Hexagon (target/hexagon) Only pass env to generated helper when needed

 target/hexagon/gen_tcg.h            |  5 +++-
 target/hexagon/macros.h             |  6 ++--
 target/hexagon/attribs_def.h.inc    |  3 +-
 target/hexagon/gen_helper_protos.py | 12 ++++++--
 target/hexagon/hex_common.py        | 46 +++++++++++++++++++++++++----
 5 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.34.1


