Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB3CE77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 02:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSRdz-0006St-QO; Mon, 30 Dec 2024 21:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tSRUo-0004oh-PJ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:56:34 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tSRUn-0003sA-2j
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:56:34 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so10241508a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 17:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735610190; x=1736214990; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WphBi3ILvR5VYoox3Nb4eOgRLKBZ/EPn2VY1nrZU5mM=;
 b=a+zBJEwgBCSNK6/6kGod3NYmnGGnyvox0NXo1oxY4W8HTZ7ZoPFpF1PxwPCdwfFwVs
 7NrZezxGLVEAbVWXH+fQiqZg5wxomEl0NU1ygfjyxuQxT9ca10DMHclwKhcfvCLa8Om8
 de8PCQf4JwtKnorm3gB/b2kBtQei9thDsbCOQVVRvom7aPxasRe41XH5DRimI/zR9zO5
 W2a/izS19QjtDtUzCe8lm6BFIa8q3jpxsZb57p86OFZSINe/KHo0hFVia5tDojLsi3ZZ
 urd3MEm3gMPgJmdPuj+IHD5McggFFkArqeXSK/ajY3juPKqbcGZFyYBoB2LSDnO7Y9yp
 WOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735610190; x=1736214990;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WphBi3ILvR5VYoox3Nb4eOgRLKBZ/EPn2VY1nrZU5mM=;
 b=GzPOBpO5FCqC4tGm1yp8mC/Bomu5EMu+bYfuveX9UC+79gsDelEtBSAF9yM3PDYQPv
 V5AzUVc7nuwW/++TmUjtyBqxRZNXjIcPaUU5JzbmcOUORLRmSfeLP5NIiRqh4l9SZCno
 zpr9Dt+xFjD9wnpm0D6qr/6NubbyVExllR4Wv6/+jgEyHHEqwhKv5D82Mp+7KYT/be9L
 Eq8ZAFzogBPgrNIbs2Zkot5oBo11bEdf84Q7rdcHE9krDMXDYRUxBu2OqXPtxuqTz2Zq
 R4dhD3F1/2WN6mj6aETm/VaDpPkd7xhHdo0MRzJxLXw5IbyP4+Su8dNIL82TOvrCAlh1
 n/Cw==
X-Gm-Message-State: AOJu0YxJozN2wnYy1S5eaJDDaVFdWWKt0enH7rp9tneYYXVlWrOskGvz
 W+1mil17mgQ1kJE/oxVcL6pAEMkR+A/6NiI1Yf4B5hrRnED8RUHdfQffa390WCU=
X-Gm-Gg: ASbGnct9ahXwTc7jfxJPakjZZJLG2mDZ5NSGlPSNGboGFI/5IEhZhD4f0gZ2p8LPd10
 HA/6U43JyJDVqlVQC1iwJ5sjnhoZzyCjUOIAhBItzTD9YJ8O6NDqAVgDp5YMoGBlMkKEFv8+0Qr
 zYovGtNYqWZfQdsw6xEPBxm+oNkB/e4DEboDJbs8d+p2ftVHXpFMEizHlNBbFLLUqchtZn9HtVo
 SACsBd0NCCxJ0pXqrWZAnl+t92ugVBON6QmGj3d5oIWO3BOXsFAlc6oB0ExuhUod3PUvRHGDKqW
 Iw==
X-Google-Smtp-Source: AGHT+IGNbtbvRF5CA40vhRM/fCVC3r6/4B/iLkaFl3BuIuiI1AMf7b60MtmCu6Rp8qk2sdiak2AD8A==
X-Received: by 2002:a17:90b:1b46:b0:2ee:c4f2:a77d with SMTP id
 98e67ed59e1d1-2f452e4ce8amr50058354a91.21.1735610189646; 
 Mon, 30 Dec 2024 17:56:29 -0800 (PST)
Received: from wangfuqiang49-vm.localdomain ([114.67.220.238])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed52dfffsm23445223a91.5.2024.12.30.17.56.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Dec 2024 17:56:29 -0800 (PST)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, huaminxu1@jd.com,
 fuqiang <fuqiang.wng@gmail.com>
Subject: [PATCH 0/2] some optimize in dirtylimit_throttle_pct
Date: Tue, 31 Dec 2024 09:56:12 +0800
Message-Id: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=fuqiang.wng@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Dec 2024 21:06:00 -0500
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

From: fuqiang <fuqiang.wng@gmail.com>

Patch 1 optimizes the trace event dirtylimit_throttle_pct, making it
print the throttle percentage and throttle adjustment more reasonably.

Patch 2 improves the precision of the throttle percentage, allowing it
to decrease more quickly during linear adjustments.

fuqiang wang (2):
  optimize the dirtylimit_throttle_pct trace event
  improve precision of throttle_pct

 system/dirtylimit.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.47.0


