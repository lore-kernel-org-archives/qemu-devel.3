Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7989606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TB9dW1QF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjx3-0007AG-43; Tue, 24 Nov 2026 01:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xVjx1-000791-IQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:24:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xVjwz-0007CI-Ui
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:24:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso32111715e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795501460; x=1796106260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QCNeZPPC7jI3AoRDxIeBb22KUrbwEP82qIapPPEzsF8=;
 b=TB9dW1QFUlcweEbYpnxmMYOrHdLTQ6lRRaoL4qTD2EdAcupjdbJaGO83uVBTrhWssI
 WyaoFnGs6TJLHgqaKSYGk/hY/sSEjVpRm0rzYWMPWYxr6ubJHy7I48//3DsVw1dhFuEJ
 1h7TY/6V7B2G/5niAwSRN6fEBjTKAaoFsNsPX6BaA2Y5/ECzKBW8C4FaECO2UKwiLQJy
 n6fPNODuQz+oY1UWm1b8rbwq9TGGjlifFsZeTVrPeXsVnCmD2kT/LX4xXd1qS09tl9tT
 3DkekUByRGqd3ZkdqBNIyNc2cuK0PRUxByAmVOz3A+Uuf3RlHP1ndiPrrZB9k9dbzT7r
 N+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795501460; x=1796106260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QCNeZPPC7jI3AoRDxIeBb22KUrbwEP82qIapPPEzsF8=;
 b=m97T9BAxcAIFsMaqbwUfXwr1/3KSGzoLJsXwbCsIgBj3YDOzXGq50q5mbUm43zZpwz
 ZsmHUmv1Nmz3g1THHtmY1LFneBLKXAW/UIEnQaUdL9gvNFs+TE+SqdkUxG4BBoDVtaXx
 ad67OfT56vkRvi027vZBRVRuy6NlebYfiT+Ok21OOBgb/0KP5MKRIuQwBHd4OJkvR0HL
 mUrPDLvIHMj6nRGf+1nCYwhnuGomC4Lhx7xNKi3xy6TTiYCTl0ibGqX4YMr7imntYMeb
 lyFOb5C9egTkHlck3k2EMG2dqVlYmHF6q1DQkJRjIOceVLhynSM27icpRBSalg0CPhtR
 UbJw==
X-Forwarded-Encrypted: i=1;
 AL+hErHt1mgrsU1hkg0Ji+q3yh0nVMD4j3UlzP2BTiZrx7widY1vr7fB8urmJKcRonL0v2MlpHkyc/QhmiQQ@nongnu.org
X-Gm-Message-State: APuU4Z8jP7Cj3dLrf8AHxR5y/OlYuwLYMLUt1gsVygdBoVfluFKS4EMk
 z1vE3ku/EVtAUrrdp96/p41UyNWob2rVN4DS6eyxvkIwMZAUQTV4N6ln
X-Gm-Gg: AZFdTZc6bjA+wG3AprPZozo9ixsFPi9i5n7IbGtM4KeNvx/m8I1ZU1fm3gwpaYRnOQo
 6lrIqiQMPNNgImbF34XV9PHybrTt6/5r8MJu0fSJeP+HFyrLsf1zO1Dk4s/SJKmPt4rtVEds2un
 zWbFxr6rUIopVBmsjWAoCq1jfRpebCQepjoqk3QwrpNjfDrczIqp9zBkTyK6GSlog5Uh7/catin
 C/FskyMUITGHsK08COLGFkB0kuUNvKiJLUB5s+pxQp7YuUyG0eBN8GH7hydfBW3BHhfIVI5KW3V
 eOyWIoHmsfzui3DphfhkZ63espLIvrteqN8hW8iSdWzfbdi+jlI995Pw66Q2fLg/8K/AfLPJTyp
 LTuWf7M6M+GqqmHGFi2NZkIZcwGja8CLEQz+9baGEW5eP3eFsY2EmRH1qjRbwBSJsNllHmDnHT7
 SAcSHJq/fCQu6GTzL9dcrusEe4TLQsl4MMimc7v9YW2h2fxwV27rQGmrYXLUcJWVxh/T3k+uEGD
 pbKR1wwO7ixDPgNKybHQ+Dw00Xp6prB32zLPq6xwGcPFKoS5HKb3SNY2k1d0tyepZOH32H40Csu
 UBS+8YykdGzyNkp2S6+C6hVWAQzmBWXqmTYTNR+O+ZnHFr1o9EYkzjH8sYyYb62GHHzBSMCfkSW
 7OOmKo0rMfEE9bUC/N1plGn0tkHvyS+YAy/UilkUEJsZP1awBL+pxOQ5RtIrWm982DTf6UFAjAc
 v3mA==
X-Received: by 2002:a05:600c:5303:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4bb88786cfamr260623525e9.0.1795501460088; 
 Mon, 23 Nov 2026 22:24:20 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-077-002-108-156.77.2.pool.telefonica.de. [77.2.108.156])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm401547265e9.15.2026.11.23.22.24.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 22:24:19 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Nguyen <xmphyr@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] hw/net: always validate the interrupt index of the first
 RX descriptor
Date: Tue, 24 Nov 2026 07:24:14 +0100
Message-Id: <20261124062414.76096-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
References: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kmehltretter@gmail.com; helo=mail-wm1-x32d.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 at 20:45, Andrew Nguyen <xmphyr@gmail.com> wrote:
> Made it so that vmxnet3_validate_interrupts will always validate
> s->rxq_descr[0].intr_idx.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729

With this patch on master (2bfbe39d0fff) under UBSan, the #4729
mutated migration stream (rxq_num == 0, rxq_descr[0].intr_idx == 25)
is rejected in vmxnet3 post_load.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl

