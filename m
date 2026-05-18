Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9BDCD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmAZ-00077a-E6; Sun, 17 May 2026 20:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wOmAX-00077N-Q9
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:49:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wOmAW-00013B-AV
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:49:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-835386ff122so1767412b3a.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779065354; x=1779670154; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqZ7S5McB36pL8gh6EoZaR7/r+LzULR9lZqNbCoE7LA=;
 b=dhHVCuMGK96XsE7UzMMltLVRvFcrsREIYY8Z6T/TM8l/8FuI6ONVYiC/Bi3A3zDmGs
 WTrGuNftWEk3hjbDi3rMZxCaw6KSFNz0ONYFKaPLQnvyJ6HQG7EVsUO/k3nPG56RR6M/
 7792QdgswFMSK1mz/cOJ03JDKliyNizNxp3p0O/Mrz9puJRuVGE8KxYvW2w5Gh1yo1FU
 GygcK2k9WERerlaRc7l6o8OvcU35Q7VhJAuFqW3VuZiIe/ef9JxhAuIp1pNfR37UyNxe
 8t0BvU81f/Vz/8Y0+mV9CI0T+gC4rqaWuqgpmAFBh3NRCIEcjQ1vpK+TwWImfHJccPMN
 FAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779065354; x=1779670154;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DqZ7S5McB36pL8gh6EoZaR7/r+LzULR9lZqNbCoE7LA=;
 b=MMW6Z/pxahbVE0ducm238A6n4YmMjeerPyscaWDrtQPwjF0PMR4uaOxMFYJrZxsnSs
 KgLzyKmoEm9DjpopY/F1LdyAX07uD/cPAw8tU4RexFJoFPCJgKqMmqtyOmrN4Kzbm3hA
 tczZ0HyqHV8ZSEWFehwFqlINO6Ji4ajgACz62r/2zDd5ySePo4SIG5GkZfAfS0mm984X
 RgEODdF2a6lWLrmxQCWRz0F2bijOjckf3qIVyrSoJ8UJWxFaljQnXfmeISnKMvwVILUZ
 pbdlrHjqXdWeF99J/Hgsg+QtUTs6emQr2Q859nw4lCCCHvGuCD/O2QovyZa6kqEDj2ru
 /d5w==
X-Gm-Message-State: AOJu0YyXwFtp+smiyy1reWYpPgXiAnzF9HzDBHhNO0nb24mpwSgm47kb
 VxyslI3C52F63U+jGs21o0XARPqR1d0QVVdUVpPGB20KQ8WEQ9N1KDTC
X-Gm-Gg: Acq92OEa4yEvYhsfS1IL3tQX1T/DIR1JMUHV5AyirsMqLeNpRFTc4G2L4BjbdrXz+Gk
 vW7ffDZy/75dVpNayg+FbjObYFPPbXJVgyycOfwg9kuxAVo3L2LVErt8U+WpngWORTCVqKNMju5
 ou7lX63arbIGkyZJvK2RaCYAxRZp7y8xvd/ckjfUiKTxljrOKG0j96mmEnd2NYjQsKXhYNH31kl
 //hFmDzRqz0tJkGL3LKcvLfYj6akCraFwL0XrlKQGEGoPjubcbn6i2obBX42VSRrQJd+T6z3lzR
 wx7Rqhw93H+u9Ne393NCVQf1LYLVIWjkh5Gd4ornGPdXiTmHtQOj1SZgmCVYEw2qhAVhcd3ZhM7
 EMjmg37lIGPe03anImryIQOzcMN/r+NMzqRU+RRdl4VqU7JVzsia0qHz4dp7MBvr3qK8ZMkWexT
 uzoZEVmzCXVfbv/0wKqyZWn4wu9AOvBq4d5h8b5g==
X-Received: by 2002:a05:6a00:440e:b0:82f:3ecc:c42f with SMTP id
 d2e1a72fcca58-83f33c9d17amr13158845b3a.40.1779065354022; 
 Sun, 17 May 2026 17:49:14 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660f9sm15457140b3a.10.2026.05.17.17.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 17:49:13 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 0/5] hw/ufs: Add Write Booster Support on UFS
To: Jaemyung Lee <ldc.jml@gmail.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
In-Reply-To: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
References: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
Date: Mon, 18 May 2026 09:48:54 +0900
Message-Id: <177906533439.6054.4720264074089160738.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x431.google.com
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

On Thu, 14 May 2026 17:10:43 +0900, Jaemyung Lee <ldc.jml@gmail.com> wrote:
> hw/ufs: Add Write Booster Support on UFS
> 
> Currently, the QEMU-UFS emulation is implemented based on the JEDEC UFS
> 4.0 Specification and does not support the operation related to UFS Extended
> Features which is defined with latest UFS Specifications.
> 
> This series modifies the UFS core implementation to align with the JEDEC
> UFS 4.1 Specification[1], and adds a Write Booster UFS Extended Feature
> supportability.
> 
> [...]

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

