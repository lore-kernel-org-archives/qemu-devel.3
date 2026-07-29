Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B57C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp8UT-00005l-5x; Wed, 29 Jul 2026 13:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wp8UR-000054-FF
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:54:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wp8UQ-0007mI-3G
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:54:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84a3e5ca66eso177989b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785347684; x=1785952484; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=St0sbWVUOO25NzxE5LrZ2jH6fvu64X2fWRJfs5ToJAU=;
 b=QmkfEjYYJ2grc5H896z1TB4/pjwRbVCCM8WPzViK1mFwtXpFR/S3tsY61LknxkSVKM
 RsxXbm+m3WRnYKT6ItfE69BNU++wUctLTHw63JpJ2ZCiI5BXTOYN0MI1D4QDACZR9lAT
 NA3rOOh6XGWcLM1saEOci3jvS3T7kHazzfRvu7fvmAo5jGl6RkIHBiW52k9lOSrhPajQ
 OAXl1JqZWffoh2jezx10e/lstN0wPIsJfz/JQ58pF7v6K8Qy0h0IRjsr+QwsYDFcdMtV
 VKUMHyGt97SfPz5YIkZJxc4pU4GCo05KFzFH2wDVcSmSBC5r1PELPdy308qJdiYdd/QF
 NbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347684; x=1785952484;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=St0sbWVUOO25NzxE5LrZ2jH6fvu64X2fWRJfs5ToJAU=;
 b=CytR5oHnUntf46YCH0B0TV1U1QlcGviLtvLUquQQVH5D6YFH4DxluTItCuGShr2elk
 oOFmRpyrDCzb0pSywf+C0pkLqVSNRwlvjQm+zjKGigwIlbSovrdhBjfn8vhSKuWHb79P
 7h1YfFU3hPRGtbHucWcqF0cIwtYdVcnuBvkBTbH1Zj0uirwK7ZMhcDZBhMSz3BsHX+2E
 YZxkW+CoGJHco43JwgLOfKub+pD5Pce60zQmr+34OzHqJgK+F20+egyc1Y9SxNkApYes
 1GYDCwUhZBtVtF9z1ddx0kHwRN+gXNKC1edtYnXB00Wsg3heOsCvu7caL3oqR6gUmzod
 sdaQ==
X-Gm-Message-State: AOJu0YxZ6WNenQRNQ5gv+24GTIVo341CGjAtOdiHMmXkcXsOlh02cpxT
 5JMWbb+4ikAW7YfpnyMBHG2d2BwpcnrDYebi880yJ5dh1FB1F5q/UoyG
X-Gm-Gg: AR+sD12pMxgNjLQTWBAMiu/5UVNhW6n7yZ3Ibz/dGGvxwxBxiJA8sMf7WhHH1ipWx1+
 bVxGKYudecclmxNF8UsIELPjlA8DID4t4y9DlbA/4b13pGLwmTI5slF5EK6cQEMPYtLjxOYiTMx
 QY6axvwZTbfUvVNXMa6GoHMXDtHuewWDQo3xCtWHkNlGqR0HTK1vvMQM7CYKaFhHP7yvoSkvn5p
 +hvgixeX3MmDIZbCVDIiFqZkwCEMBesuQ2Efbs8vMJeivW5ueYd1bj7J5qgwvVllC1pHQ0BpYO4
 alpYZ7zEn10z3bdrklj1KVVYeoztq4tOwoVemQNcanc2t52G1S548RYg2a76oJGTdddgf3z78O7
 jH2+333PBjUAL2WZUfk6RFByV/W+4lCIJN9nnT3+lTZFRbB8qsqFf6EE8jjs1D245QQfU8AadZD
 jZQ7m3y7DRbWVo3NOSZQC3Yy+eucP18vgubJD0k4GrkXHnyUj6Jn7WNEysQG+LdhROpOSP+Gst7
 lKXX8oM21WjbBIiyQ==
X-Received: by 2002:a17:90b:2f8d:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38f6a257aa7mr7756612a91.1.1785347683993; 
 Wed, 29 Jul 2026 10:54:43 -0700 (PDT)
Received: from DESKTOP-7HME356.localdomain ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d2ec2asm14067698eec.21.2026.07.29.10.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:54:43 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] hw/timer: add k230 dwapb timer
From: Junze Cao <caojunze424@gmail.com>
To: raoyi <rao232328@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com, 
 caojunze424@gmail.com
In-Reply-To: <20260726142703.37637-1-rao232328@gmail.com>
References: <20260726142703.37637-1-rao232328@gmail.com>
Date: Thu, 30 Jul 2026 01:54:35 +0800
Message-Id: <178534767556.3353.6907171394775089230.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785347679; l=910;
 i=caojunze424@gmail.com; s=junze-gmail; h=from:subject:message-id;
 bh=yAB3p4cdEs5MBTKXrHrGI7OoYufnBipiRpDH33OzWpk=;
 b=TJv22RC97kA7J9RIyXp1ISxAE9PBRhZ7MXHpjrFc+ikgx3Le8yMycWRA8BvZEs+089rGXnTIM
 fE+8G9AwPPDAhs89TSGeaLCiEAvubg2662Nw9Xme+Sh3ehoM41J5561
X-Developer-Key: i=caojunze424@gmail.com; a=ed25519;
 pk=lnFIWNw+6CoDrHFIKUJKdgrRbvgAbQGcEFiVsIigOJ8=
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=caojunze424@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, 26 Jul 2026 22:26:39 +0800, raoyi <rao232328@gmail.com> wrote:
> Add DesignWare APB timer peripheral for K230 machine.
> The timer uses the Clock framework for frequency input,
> preparing for future CMU integration.
> 
> Signed-off-by: raoyi <rao232328@gmail.com>

Thank you very much for your contribution.

I recommend splitting this patch into three separate patches.The plan consists of three patches:
We want to keep the coding style as consistent as possible with the previous patch.

1. The implementation of the K230 DesignWare APB (DWAPB) timer model (k230_dwapb_timer.c).
2. The integration of peripheral models into the K230 board.
3. Testing and documentation.

Additionally, this patch has a conflict with the current master branch. Please do a rebase when the maintainer asks for the merge.
There's no need to do it right now.

-- 
Junze Cao <caojunze424@gmail.com>


