Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF019606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTs7RO/8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVN2-0005Bq-R4; Mon, 23 Nov 2026 09:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agarwaljayesh03@gmail.com>)
 id 1xVVMj-00051q-Od
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:49:58 -0500
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agarwaljayesh03@gmail.com>)
 id 1xVVMi-0004lm-4h
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:49:57 -0500
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so5657792c88.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795445392; x=1796050192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O5+8/AixUPXQ4kSG2aFXHVaf5Ok62tVtQCfdSL/IMr0=;
 b=GTs7RO/8Dst61I0mq/gGkalW9itxAqWXakG3bojfaC6iPgX2hcOTNT2aN8Z1BB2zH0
 5SkMggBB57r/6jOrz3iGU53lcp4RZYvCpu1EnGuhGKtAl/aNl/YtLgHQKqLUnylu1Fw6
 PBQWb7cuX1w8LPXAc64P795hEduwwZBS1a3/GRO6ad2rlyptxl9u3JPvFg8JdajAnaga
 +Oea+mAL+EqbsSCqlIwpYD4S/vhKpkkkp9bGtMilmbCGF+yA2ry+6Eyt54+zdzG5pTP6
 doOL4vPT0nFp9pDxn3j1WlF1nmmjQiiV49MIx7TL7B9C0/yu3+Xj+EsKPpffeajluy0z
 Z69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445392; x=1796050192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O5+8/AixUPXQ4kSG2aFXHVaf5Ok62tVtQCfdSL/IMr0=;
 b=U7P9t00np5lJNpC+pvQLflLT9ToTOtsQQMzfW5a2GaCnZ7fnDdNVtliDjW5irylvuu
 q321DHppFLsjNVUzyeyf93HIau2Y3g0j0Z7Ae45PIBkR6wBl1IdJVVsjt55eIO/IKfMI
 q1o9JDPv6vmE+/vL/1+93qE1a1s+WMEieYecKIOmZ4hffR8pw5Omi6do2KQdOS3gxvyt
 xVuskClKYlCSQTYeER1aey+SoyeprBJ7QOk6sEonMYHHp0Qjq9zZxiHVfx7oGI1HnzlZ
 SpSC1HAc7q6+cm4cZLg1oBtFDxOVEmrwr6PCGDclUbBc4W0HN9GOTNt33MNC0M4Alh1a
 mEjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG/lQbMUnwIMzZAC/hk+Va/8VQ/qWfKvTb8a05k6PGgamaUJRliIvCutdevD2deU6Hy2F3nZG+fxVPX@nongnu.org
X-Gm-Message-State: APuU4Z92uB0AyC9dP2diJf7UZrgN+3e/qbfVMCxyVaa0ddzVWK/9emr5
 6OZkpcozGf0H6jXAQiPbug6arKF2Xr1NGO17w/edWTpd6BL2ZLrr5N2G
X-Gm-Gg: AZFdTZdBuV3TttzceP8crSo+r95OHz8+h4Dr9gIQH4LBNQosuHcAhuU+NgM7NpcRYx6
 1gQBeRudLc9HUZXXR1Df0+Sd+eSblFfbCfFFAyipfCx9hSGm18FD5CqnBIIN5H2CHX/O/vMsQFQ
 1+RdWoMuQh0mhTgHBFMeDqnDz7yLLe4XzxjX6tbwJEcqT4WV+GxOOAg1RICxgWY8kJvA2Fng6DO
 yiqesY3H+dEpdH9T0fI1zGi92kROpWNXbetDhWlSPhtKUv4bgFyFMqJ7guvnDNggaJ0Pf1EJ8N8
 2i+xR2HoX4fqxf7prjhscImI126tM1i2y1L1tU4/s44CzJVCvjxXBqtOoFUIw7h6AdsG94vYVOF
 2lVhiigXLmykBcI4xVs2rF6xwNjWXZbIphggyhoK8iWhI1/qPhfYwCDPlJabBlVEIaRLev4Yk1K
 cmiDBhUvRMoTvzp7aWzhoFOB1I/3X8gfDyBT/jSTzQBpmKOD3zssNRnj9MsD6S/TXWQCAizqois
 usJJetpkjIIOXRXvgKab3aEi/93QJHPGPx6aTiZ4e4SoOUOacInrFRLY4r3IJxFr66FDVIlTJtW
 wQNeJ6GuTL+mpIzKDqsDk4NqxthLWLS7SrlDUS3KatK6o4rewzlRiMiw9eGw39oDnBSLEdxOhDv
 64EalCyHc
X-Received: by 2002:a05:701a:c96a:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1b5568c8dffmr9916578c88.28.1795445392336; 
 Mon, 23 Nov 2026 06:49:52 -0800 (PST)
Received: from LinuxMachine.bits-hyderabad.ac.in ([182.75.45.16])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55ff0e4e6sm21657646c88.11.2026.11.23.06.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:49:51 -0800 (PST)
From: Jayesh Agarwal <agarwaljayesh03@gmail.com>
To: peter.maydell@linaro.org
Cc: philmd@oss.qualcomm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 s23adhik@csclub.uwaterloo.ca
Subject: Re: [PATCH] hw/arm/bcm2838: Route system timer interrupts to GIC
Date: Mon, 23 Nov 2026 20:19:43 +0530
Message-ID: <20261123144943.9630-1-agarwaljayesh03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFEAcA_4+PcP8f2DF+mtjkO5iO6eU6C6R6hjfBN7dg0o_TGPiw@mail.gmail.com>
References: <CAFEAcA_4+PcP8f2DF+mtjkO5iO6eU6C6R6hjfBN7dg0o_TGPiw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=agarwaljayesh03@gmail.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 23 Nov 2026 at 11:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> Thanks; applied to target-arm.next.

Thank you. The problem that you raised in the 2025 thread on Sourojeet's
patch also affects the following devices:
uart0, aux, mbox, sdhost, mphi, dwc2, rng200, the eMMC OR gate, DMA 
channels 0-6 and the two DMA OR gates.

bcm_soc_peripherals_common_realize() and bcm2838_peripherals_realize(), 
for the Pi4 only peripherals, wire these devices to the legacy 
controller, and later in bcm2838_realize(), the GIC wiring overwrites 
that.

Should I fix them the same way, one patch per device? I will send them
in December.

Thanks
Jayesh Agarwal

