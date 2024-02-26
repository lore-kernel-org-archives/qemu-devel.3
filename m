Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE40BC54E51
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebhL-00037G-SO; Mon, 26 Feb 2024 09:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhK-00036z-IJ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:14 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhI-00023P-VF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:14 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so537890266b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956671; x=1709561471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IhvcWs1xcDSEDBqqBHd4sfNHg5BFoMMt+2CzoTmQ4us=;
 b=N6rx9LbyNxLCC6YMzZImtjlR2zuM0icEAhyNzi5eNWK5uRi3U341psOoZP8x1o2AlE
 0nXWUF6G2bbWUDW9ItJLrPM+cRpFLTJwLP7kRnRqVAAqcKHqPrL7qQJwzqSDCmfyBzxT
 jJBFmhw8V2Dsb/Z2rEDQ3V1kd7y22yzaoRWi48BvFwk0AVqzynaPEKoOv4spCkZ5qJKp
 U+M4scUARhQeVs6Q4ah770wQmFLbr+rGR9AjBDKfIaxD+qcHRmtLeVQxAgWrHqBYc0oO
 jXyrzwtoyyVm6Vrn1ioyK+ELBdjlCQgTNqqyYW7ZjBc2ue45JDNCmY3idasamZAY1opx
 SVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956671; x=1709561471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IhvcWs1xcDSEDBqqBHd4sfNHg5BFoMMt+2CzoTmQ4us=;
 b=SHvHdHklGYsYoQtfx6tXtau4A5f4aCXuTkmV032ZeNXSkhnFq2fss+4KaE7401l+fW
 daRLWNnB26Sb3ge4MyGGVsd5LS7J48O/20XJ5L1IM54QnODjQQbjUDfn8WSZAGN7Yjac
 CTUMcPbo+TuZz609KMtwUkHc32zO3lYiRWwlJkrkb7PD6Vup9vUcXLKG/Lhy55G9WtqB
 Z4Gwgt1efE0xSyHXYZNIHN2ypOwoZeHcb2MQTFIbntTdwZVdMjkc3vsUgxzW65R71jsX
 cvodu2xUiZaKb7c/Zo8ijo+SL3jjRk8N+Y9FsifZkzjZBVYiOEKiZc5P/kjPAIzzbMJA
 j5Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5fO1T9kEKuNvpRC0g78mq+CqyJmIDVfumOBipgNC02qjbjPXzZOLjx6Gn/YdBWJS3u/b+uPNhuQSHmihwtei76SxfHY8=
X-Gm-Message-State: AOJu0Yz6BuIiaeSIlftTA4hqaaBzPA3Zx8AFMv2/hUxxuvKkRYZ0i9Bf
 hUj78gF5XLd7swus/V9KXB3UUdvycV5Uo6duKN2JqF9K9pix3dUU0Nkg5w9s5GU=
X-Google-Smtp-Source: AGHT+IEmTzKBeoABVgf9PChDJTeT4Cc9IPdT44DTIGW/EE68eIfjg/1jSNbQ4l9Xo6NX2Sp/6xqfyg==
X-Received: by 2002:a17:906:3912:b0:a3e:8b9d:dfea with SMTP id
 f18-20020a170906391200b00a3e8b9ddfeamr5025923eje.66.1708956671441; 
 Mon, 26 Feb 2024 06:11:11 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 rv7-20020a17090710c700b00a3efce660c2sm2455332ejb.198.2024.02.26.06.11.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 06:11:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 0/5] string list functions
Date: Mon, 26 Feb 2024 15:11:02 +0100
Message-ID: <20240226141108.73664-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Markus,

Here are the patches I queued until you told me you'd
object to the CamelCase filename strList.[ch].

Steve, please take over ;)

Since v5:
- Cover files in MAINTAINERS
- Complete @docstring mentioning g_auto.

v5: https://lore.kernel.org/qemu-devel/1708638470-114846-3-git-send-email-steven.sistare@oracle.com/

Steve Sistare (5):
  util: str_split
  qapi: QAPI_LIST_LENGTH
  util: strv_from_strList
  util: strList unit tests
  migration: simplify exec migration functions

 MAINTAINERS               |  2 +
 include/monitor/hmp.h     |  1 -
 include/qapi/util.h       | 13 +++++++
 include/qemu/strList.h    | 33 ++++++++++++++++
 migration/exec.c          | 57 ++++------------------------
 monitor/hmp-cmds.c        | 19 ----------
 net/net-hmp-cmds.c        |  3 +-
 stats/stats-hmp-cmds.c    |  3 +-
 tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++
 util/strList.c            | 38 +++++++++++++++++++
 tests/unit/meson.build    |  1 +
 util/meson.build          |  1 +
 12 files changed, 180 insertions(+), 71 deletions(-)
 create mode 100644 include/qemu/strList.h
 create mode 100644 tests/unit/test-strList.c
 create mode 100644 util/strList.c

-- 
2.41.0


