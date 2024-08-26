Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B0C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 21:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sigq5-00023A-Cd; Mon, 26 Aug 2024 17:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3p-nMZggKCuoRMZVMeaZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--fanjason.bounces.google.com>)
 id 1sigbi-0001XL-HU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:46:34 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3p-nMZggKCuoRMZVMeaZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--fanjason.bounces.google.com>)
 id 1sigbh-0001q4-3E
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:46:34 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6b052c5939cso51632367b3.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724705191; x=1725309991; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NzW5yYGsX4g1anKAwi4rxXT7kcbTpIvjzQhT7ZrBho4=;
 b=EemGI1mtT2WwgwNLb+8Rivr7PyrP4/dmygDl+8HlsGTZ5D81nuIjfBxN0hA4nTwGYh
 NJoFaAHH0PgtHcIVwYb8x53Xtx3URIcm0Y1MLa+z24enTJzx3BdlXQAvgVO1K3dY+pwt
 Q5hEOTwJX37soyyXCd59VB98aE7UMit4+02ofxe56etRmcEZlndhnxCSDCaYo9nsO54g
 XNW2ggAPwlyWEsKczA2fY0F0N+AQFoYMecSuOGQINFhkuLimnxkV8lo7LT7OUlv6zddu
 Awz2vkWER0TeP3d8C57ramt6YpVHn4AhI6HtReBl6KAXhXhuRRcQj2dM8b/DjG4rTVZb
 NdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724705191; x=1725309991;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NzW5yYGsX4g1anKAwi4rxXT7kcbTpIvjzQhT7ZrBho4=;
 b=hVf6TqD79bYtueIAV4r8jpxpR9nVbjKQo6UK6T+YD9tq1RYXDO5siurB78qFR7oG4n
 cfYEtb1Im6brh8c+JRXN+e8wIb7+qif5QVJyHHNmO4uEat1qwkzg+A5EhvZiewIeKBP1
 8AsxPx/7RA+AD5+ATsNLOuHafKuZw1VbfepPaA3sOLRtQfBe8g5gqunpXDb+Jtri5B0c
 QkPeamxgjJE9Dx830yIs1kRc2SKCjg52nHPMY+mKIwYhe13zWwN0ADHU4SQuNyDoluQe
 gArLmwYaZsKc95AO8/uLQQj7WD2cjsG86qfmwbHv5i+Buu2mh4swh4MGXZDPXfYhOoMv
 e2tA==
X-Gm-Message-State: AOJu0YyT2MyuI7sF0ZMfZcI0hdno6Ie/tAH7rtB+FhbhJtORXennl9Mb
 forxJbzkQqqoyg4rQUtJ4Ux1eUtorcDVufhJOA/lA0t1tPCeDJhjch3/tCXNUCZCOSyBZ74Z1jc
 +jW+2Up7PtQ==
X-Google-Smtp-Source: AGHT+IGh4NmiTv54sA7NpELVgkb8TdvABNKdaOE/UAVC+LvvBPxuRtwRl6VyzLNLk52gHZoB2GkL4lB6Tsm2Jw==
X-Received: from fanjason3.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2730])
 (user=fanjason job=sendgmr) by 2002:a81:f802:0:b0:6be:523:af53 with SMTP id
 00721157ae682-6cfb48d2acemr334907b3.3.1724705191624; Mon, 26 Aug 2024
 13:46:31 -0700 (PDT)
Date: Mon, 26 Aug 2024 20:46:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826204628.3541850-1-fanjason@google.com>
Subject: [PATCH 0/1] Subject: Support deposit8 in include/qemu/bitops.h
From: Jason Fan <fanjason@google.com>
To: philmd@redhat.com, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Jason Fan <fanjason@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3p-nMZggKCuoRMZVMeaZSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--fanjason.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Aug 2024 17:01:24 -0400
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


Jason Fan (1):
  include/qemu/bitops.h: Add deposit8 for uint8_t bit operation

 include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.46.0.295.g3b9ea8a38a-goog


