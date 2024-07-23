Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765E1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCW6-0001rY-G7; Tue, 23 Jul 2024 06:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCW4-0001ls-Um
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:13:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCW3-00009S-DZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:13:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso3706808f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721729586; x=1722334386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XOOYb6uJD6xuI2PBiQx7StOwg7J+ymIXxQsLdRfFK8c=;
 b=F1rJfObqXxjjEyr5nZ+bgVTJN/e/3gjEmOZkup9J6JDeg1oLG4CmqMPHunejwB2v5M
 s0Mxi2wY5k7uzeCDVnSu/ERYRuL8xVzwVrobUEaUD6BVD8HPLSbkwHS5TdzHzazfGlXd
 ovlyC4ObkhJvBvcJzxEWwM+aLoQ/XWcubtxVq5OLIvk9daIxeNpbwomCwklPR/524Mwc
 KfYrvEIVnJvbUPuf1vtYrTwA1I9WFu1zPtifuVZsC/BvY3bWr92F0pC6Wnq1HaAcuk0+
 9NXRPcERbWDXqR/SrwGrkGqDs67jPGZy2dLeS6GeQowiJvVSObm3zyZAC4Cv9hjetWeF
 vifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729586; x=1722334386;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOOYb6uJD6xuI2PBiQx7StOwg7J+ymIXxQsLdRfFK8c=;
 b=bsPLfT3+I9zU2mttEDN+OnsXH4S2HwNMzySC9DUdl9QNSY1+CMSHeZlCJjjY/zePaD
 b2QR6P3Db+ghNGf5gnKpMWJCn2/8q5mZ0aatgODxqm9h+bMwQggmFiVvgiLRfGQbJXZ8
 0kIb682kQkS6rFZd/XzD+/yVNmcAwB/1XPFDOV9cobNh7m+tkp84FZyU6pORQtelpEWK
 2MPsO1Yk+mDjC3C9OSywoIM5b5lkB/KlMHfcL1U54DfQKMgd5q0WbgrjvQ3A/bZ5aPip
 0v/GVbbXOyiIaMIgVZbzxYUJsemoOzHnrlfTdag85EkeDJVESBgZSHJ45M9gCqVdxP0X
 QvcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1MN2pU1MQw+8gccN0H4dYAMhoXo0qneJXHS/DstnYAfqHoeNIDCR+16XE/LzUJrnx14WjMKprJaGmzJ53ZN7/i/4hsLg=
X-Gm-Message-State: AOJu0YyOY+AMDJE4GwaNJU8+sjjbyI6nBJqiTMJbnb0RPak29QLrKOC5
 +MG6/j2GlI9VWXdl+5Vf63P1xzWVma2IqGSzilSiOeejvX77eIj83KTrU5G0Dk0=
X-Google-Smtp-Source: AGHT+IFVhuwP/f4UkcV+G8Xbfy5tY/Tj9itNsu2zPijgU+fg7ZqMwU2RLMl4u6pUt2IiHGVXojGG1g==
X-Received: by 2002:a5d:6911:0:b0:368:e634:1520 with SMTP id
 ffacd0b85a97d-369bb2d54cfmr6758456f8f.59.1721729585739; 
 Tue, 23 Jul 2024 03:13:05 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed580sm10983707f8f.112.2024.07.23.03.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:13:05 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:11:15 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 
Subject: Re: [RFC PATCH v5 2/8] build deps: update lcitool to include rust bits
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <49e451adf4a3203760fb671e7509b24a7e31976f.1721648163.git.manos.pitsidianakis@linaro.org>
 <3514d341-f41c-4723-8306-691734f7ff6f@linaro.org>
In-Reply-To: <3514d341-f41c-4723-8306-691734f7ff6f@linaro.org>
Message-ID: <h2n1s.s6ji1hlyfity@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Richard,

On Tue, 23 Jul 2024 11:31, Richard Henderson <richard.henderson@linaro.org> wrote:
>On 7/22/24 21:43, Manos Pitsidianakis wrote:
>> From: Alex Bennée<alex.bennee@linaro.org>
>> 
>> For rust development we need cargo, rustc and bindgen in our various
>> development environments. Update the libvirt-ci project to (!495) and
>> regenerate the containers and other dependency lists.
>
>The cover letter for v5 says use of cargo eliminated.
>Therefore no need to add to qemu.yml, correct?
>
>
>r~

Yes that is correct, thank you for pointing it out. If we end up using 
only meson and not cargo, like it is done in this version, cargo can be 
removed from this diff.

Manos

