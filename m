Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159AFFD3773
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIAH-0005fF-8G; Wed, 25 Feb 2026 11:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vvIAF-0005eY-JY
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:55:07 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vvIAD-0004Z3-W8
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:55:07 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-506a747448dso57849711cf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 08:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772038504; x=1772643304; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uICZUx9FRs67zj6Fwdi31378fhveR48w7JtSzkOE5cE=;
 b=Fjkris1ZbgB8E7xq63boJn9Y+T77+N2v4dByOOu0oH6afhEUlz75OCySyuQUXBre5j
 z3IiQG+WQeklBSYM+B+eG3YiNiykjTht6XuCg4LLXC8NfP6DEUQ0QAcovq0kHKR4B4GU
 /KSB1F6vnTDlE2gpyCbeITm8AQWvp/+kubkC7AZ7YdR7ne/sJI9z/uS7k4YuPanuiHOw
 CYsq/5t+sHrBiREXxGXHQUPxQdJxuIiv70l4qjluaBTwxCMPZSYjWlWqBna+AJmkDdL6
 hBcTL2DV88L03CmfJxJ9Ek55jCLqlp+aFx4b51Tg/R5p0ikfXu9EkEV/j3fL9POds1Se
 Mj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038504; x=1772643304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uICZUx9FRs67zj6Fwdi31378fhveR48w7JtSzkOE5cE=;
 b=pjqjSkG8fVxa4Yj1Nq7XgpqkyIb9q4DjlZgKLYoj6Ogl/OYDGdgb0Ig5Ag8Aw1uFy2
 dSFC5dVY0ecXXPjVsowe3Ucurf970cevTzmS7uqsl2b8KOUivjTKVT1BlAowLxp8zqRO
 K2DVG9GsGocuvyiEXN12WCd8XuN1x6+/qZcuJ8Ga9t9X9mbsnQPkoltTp2ZxkFEnVusD
 NAAr9hNqcr8f7AslEbGEzZtglTp/l3b+D/esCmWC5/Ic0bWI2AJmBf6y+xh+aqcwtyqu
 e9gxSIG1lpLZqyKo1gftECuynvq9kj4mMFgPttrUW86oKFZz4lwX5cJIR/rWQM6w9Sr7
 hHrw==
X-Gm-Message-State: AOJu0Yydrdvl86aUFcidlWtMQrjyJxE28MilsOu3wjg/bLwSoIwxkYgI
 jRqcW5grN3aAk+itR5pL3ABslh5qhUgdY0Vh5yRLgPD1fbmb1zb/162RDHPiAWHA/8c=
X-Gm-Gg: ATEYQzzqFOixqEOiwEX5f7c2UMsxv8lFjiPyfQ4eofzreeC3TSCDgPsomhi8yerEFsL
 VGi6/HpxVyOQFxgO2w2bdRRYeSpxtNKbdSYc03jPDogjXUv3bW43qh+hlV4Vij6Ippt6WDPkcNT
 z7U0nhNmk/RZTXcLkdlWaJpAveFEbWubL3A+G0Ekni+pb3+ALxtx2eQOERHo87Y98MtnWq6pbyv
 /P4v6iwnpEb+3xfqZsiwklA8JSr0kJKsM2pqWXLwTHFI4nMtyDgbrLZ3QG2Jeuy0lnEReTl1K/8
 E9lmggNrnFyKShqACdsEDLTpsl345zL/WWU6XtBfBvghw9cRFGLeEqXYAKA/LnASR+Ky/ChCu2v
 QAinfFWuXuVbMCsv1YbViNOweYKZHTeWf/2eS9tnzsOTo2dFtYIPiZMryS1vVugTHVuOnGhwepW
 fHMFjH2pHk3futYvoIAuV/T940ABrRJsr7+dNANge/UWLUW3vKzWxFlCiseqiHTZfA41ynueJ1x
 FxOjfRptg==
X-Received: by 2002:ac8:5a4c:0:b0:502:9f6b:a3b3 with SMTP id
 d75a77b69052e-50741f9ac2emr13911191cf.37.1772038504223; 
 Wed, 25 Feb 2026 08:55:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d6df762sm126765311cf.29.2026.02.25.08.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:55:03 -0800 (PST)
Date: Wed, 25 Feb 2026 11:55:01 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisa.su887@gmail.com, armbru@redhat.com,
 david@kernel.org, imammedo@redhat.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, lizhijian@fujitsu.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 ppbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v4 0/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <aZ8pZXR5Jv4_uB4q@gourry-fedora-PF4VCD3F>
References: <20260225151916.390-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225151916.390-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x832.google.com
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

On Wed, Feb 25, 2026 at 03:19:12PM +0000, Alireza Sanaee wrote:
> Hey everyone,
> 
> This is v4 of performant CXL type 3 regions set:
> 
> v3 -> v4: 1) Tear down path changed, given that it is done differently than
>           setup.
>           2) Dropped Gregory's tested-by tag due to tear down changes.
> v2 -> v3: Addressing Zhijian Li. Thanks for the feedback.
> v1 -> v2: Mainly rebase.
> 
> Base: 6593154e7d65f61d8f9dbeb98224731b7137c53e
> 

slight oddity - i should be able to pull this in with b4 shazam directly
on top of this base commit, but i had to give it a merge-base manually
with this commit to get it to fixup conflicts.

I would not have expected conflicts if this is the actual merge base,
you might want to double check that.

~Gregory

