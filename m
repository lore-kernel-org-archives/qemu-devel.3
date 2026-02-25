Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D38EFD23D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvCFJ-0006xt-NP; Wed, 25 Feb 2026 05:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vvCFD-0006vN-Oj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:35:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vvCFC-0006vD-4h
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:35:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483a233819aso63827565e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772015748; x=1772620548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inMBkKt77By2B2/2NRVmTl3MIU1MB0hU7n87s7QsHxE=;
 b=TV+dwGXwBfgquR92nxbn9j4jXBQQchF5phQTzwH6QSetC+pCckBslaNHgwBhfr/MZn
 7iCsf/QqEfyCABb6/QXfcdv1ZXTRfGUzYiEw1gsLEyamXkTv7YfuEqiJlWl5oQlv2Cmv
 3/mtO5rd9JlF6HBwJ+9aIcZGs6hfagxgvVcqIDPqr2GDubH03SJ1z+sFgvFELDpSXuIT
 4Z4jrhcTj4XnC1ORHq491tvXm/FtteUXIIDIqk2xTTkoZKuFiJkqUcCKu+xdsln0svsq
 tRW2ksXUGiOuz8AQKwrF0WeBKUspqaPhcN6wpLPB9wXaJn5nwbtatqxvjbDm+B8zZDes
 Lztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772015748; x=1772620548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=inMBkKt77By2B2/2NRVmTl3MIU1MB0hU7n87s7QsHxE=;
 b=IPYSFNfYj34xFGUzkuaziqv6luk0bc834ogyt68W05KoWDnEsj+dmcK0YJUXiFng8d
 VQVB9uvEF1/74O7vq9AUh/L6l4eLWtLUEhsRfzEZH0SlgzVsceVZCSyUG9KMBhhEjW/i
 9Kx5+XMpau7ZoqmGkg+oVUjZUp4Lu5uy6pDigd5Q3X9G5HYHVJFjsznkudp9sjRMoM1S
 sc3wAyv6neZNGDovjfyv+jh8TXxkqXSw/lvFwRqJBFZMMVywjuOrvgNql9f4dKwDbexa
 UbcmLsR5PvmujItTPUVQo+Uef5++p4pvVQgGRwgIwo2l1No3SiuuQlBTQbRRBDWb0hM3
 NuNA==
X-Gm-Message-State: AOJu0YzKzYJzlcDOufQS2Nn+5cP1TxbD+NH7ifS91Vw4lBBX63Rz9Wti
 jcge15abVLr5k5HkEfuS33MgszOieywHyPLl/VFWY2kEZ4a1+4kgx05FOVafbQ==
X-Gm-Gg: ATEYQzx8RpxhaB1ZUE3GucB/m0zIK4zL363gmVT16z3/PB9k7A4/R7kgl16vNWu+2K/
 ifLVENprV8u7nGTThoscgAtJ69dG368ZKtKyJQgnVxV3iVEdtCo2OYlZ8hlS0HzA9l522dzAjn+
 vce9KYbB9S+61qXFz21cNI6Kd8O/PyDZnOd7uyWbwUseuPf31ERShaukV66gn17t1XMaxfKOLWr
 aT+WnxB82fTcgeSqGC23N1EPxAubLLQhqRfBohRNdkDcFqD5tID/4V0ds/oqOyfw6X7ALDgdSE8
 +VKszyf9ZGyp4o6eLUyCGMvbW0hfwuRuXxfI1jY+djPKGqhjpu1Janh5DkIzSmO5B4UX6zKTjWd
 die16JZ3YyVLsBq4KB9QwYjj9mcPFIUAmeIRvgRQA0SRWVuCUIUyhacbr2rT3c0E9jHdewHllHN
 DAp87O4uLbpf6vofUzMpSo+q5A3pVoElB1GGIJqQ==
X-Received: by 2002:a05:600c:8b48:b0:483:c12b:fe4a with SMTP id
 5b1f17b1804b1-483c12c0071mr9084305e9.11.1772015747947; 
 Wed, 25 Feb 2026 02:35:47 -0800 (PST)
Received: from tuf-gaming ([82.78.167.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7507adsm69943505e9.9.2026.02.25.02.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 02:35:47 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: Re: [PATCH v2] linux-user/strace: fix printing of file offsets
Date: Wed, 25 Feb 2026 12:35:45 +0200
Message-ID: <20260225103545.170204-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
References: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Are there any outstanding issues with this patch?

