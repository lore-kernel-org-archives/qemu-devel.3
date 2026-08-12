Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED7C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6jp-0001YJ-V7; Wed, 12 Aug 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wu6jn-0001V2-Dw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:03:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wu6jk-0007l0-Hx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:03:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so166916a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786532543; x=1787137343; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mamAANzd/PbSQI1bxpiqo1MVM20pT8xJwz/gg+yIWD0=;
 b=L3/oKMriQoVSw6cavWjDrGdXcFIWk2Y7RbDyN5XPmBold3UeKuHO2fsamI3QmsnDyr
 bDXou7H/dFze8bwqBK38Dg3Hqc2iSuhVqvAaASNeyS4Cm7mk/SYb3nBH61HnFnn6bvSd
 qaaHipeg11RK73m2WAq/HyoSZMUE1nLv9TkxTaVskMz4SsZhvHoCvMcVZteiefjIo0jr
 DlSbEFZXiLNH0rXXiw24iqrmEpj/mlSfG/hFOPoeClFQDMAIDWreQmXE060EqOlSqqtU
 91ivINTB3Q7FX38+c8gGJBhpmzwy5HMKch007/Gyq+a/8bN0Z47LZ6JLp21H0iS925tL
 MjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786532543; x=1787137343;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mamAANzd/PbSQI1bxpiqo1MVM20pT8xJwz/gg+yIWD0=;
 b=Uam9elU7MoJwkLp0qWs3LMmZ4qtRHhH993g056qdpAZXSVRW5vOhBKkp4jN9BKV6QZ
 Ml44U3+Id+OLmFmK83ocMxbDoboexTJGMjXeIMiVBpn3qJmkc/0a4Ca0dGFMp7IF84UT
 tN25m88pk0383F0yuP6R6TcbNVcHuyq4+FauLP1Pzs22ld0klWFXbbXYZfjXjGZrXeSY
 KhJbTKxShbmYuhj2MKL7HsxvtxMHT4XP+p/vRkhAMiRgu0OaJh8DAO4LUt2zUnmhji/q
 X3C10w3aK2cinJWh+fhrs/P4fECJWpeI4WOpz5Zf99oCbXzz2pHm9rWn626RugvzaM+s
 856g==
X-Gm-Message-State: AOJu0Yz4noyLTADz4xFQ3ZnBHJq/UAAve2KqlZWRv/drjQgWEnoabAK3
 FZ6wuOK9PVsdJNnSTqaTIUDnAH/7AE9gcp87ebcT4uMAXh+1AxI6eBAx
X-Gm-Gg: AR+sD13u32xuZ5kJeuM6S6mfemeUjhVPmhfMqi2pNAxioBrC/1Q4OQ+UA4gR6Y5jPio
 7Ph2kHcqQwUxc/APiVS/nFVx9SyUanMLiMQ+e3iaONBkZsQBl+tBqOLaL2t0pH7wzPkZmmxYkuF
 Na4/YwWaSX5qy2qMTsk7RzaXabGf+GOpZNBIfKfVLWwI7b6M4Oe7S4YZMPQll0KsiDRxaHI4uCC
 heCgtMa2WWtAufPHVr86K1ZLHGnZqoBN2RUMrmWt8KnR5yqhgNQg0+MnR4dNoaLub5mQO2fl0fg
 7FM95zkJT3oxiddzOwEaZAzoSc62DqYjbzn5EjEHAVOA/vBR1lNCUqEhE5V4ZBcRbYonXJ9DEY0
 OIrR1jGNzoqT2S9xtur6kf5NWY1Q8omj6CzRtI0XPBFd/1yHmjDmYmRGSbfbRzA9GWQz4dlTYl3
 rZAL5sYpA+83PRPy6lrvWrz5DEc41EJCBRwt+medzxZbQXzDRbCqRldWM59w==
X-Received: by 2002:a17:90b:580f:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3930121d20bmr3140660a91.1.1786532542816; 
 Wed, 12 Aug 2026 04:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([38.34.7.236]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf3c08163sm9105729eec.7.2026.08.12.04.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 04:02:21 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/3] hw/riscv/k230: add IOMUX register block model
From: Junze Cao <caojunze424@gmail.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <cover.1784022244.git.flamboyant.h.01@gmail.com>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
Date: Wed, 12 Aug 2026 19:02:13 +0800
Message-Id: <178653253397.92831.286711624996156567.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=caojunze424@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Jul 2026 18:21:59 +0800, Kangjie Huang <flamboyant.h.01@gmail.com> wrote:
> hw/riscv/k230: add IOMUX register block model
> 
> Add a SysBus model for the 64 K230 Function IO configuration registers
> documented by the K230 Technical Reference Manual. The model retains the
> writable configuration fields needed by the SDK U-Boot and Linux
> read-modify-write paths.
> 
> [...]

Reviewed-by: Junze Cao <caojunze424@gmail.com>

-- 
Junze Cao <caojunze424@gmail.com>

