Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C705606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lOXKYq5Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVsp2-0001kT-9C; Tue, 24 Nov 2026 10:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVsow-0001j4-UV
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:52:40 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVsou-0005Rl-U1
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:52:38 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-675617e81f9so5231293d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535554; cv=none;
 d=google.com; s=arc-20260327;
 b=QRN3sPnqtQtStbau6p8FzBPgguhp2kaKLnM3WsMx99fQLew433eUVo0k6dPPm8BMBs
 riV42nuaJQZP+/n6lj29xKYFpPodhmQcOE2E+f4E9MtoIzSpiNOkCHdEK7PO4tXTagAl
 T3C23AT9K1B/v5+UMH01hLSLHasZb2bDC4zL58ceI8ItmXLWkc9E1j7Uh7k4PGwdYDL0
 BBshpdh7Tm+fjd4wVPez9LijlFKwcycm6vpdrxFGDjsCPN5IG97BcFHo02BKu/3fjjhD
 Qu9l7+Kd9H1TY+kqabv90tEL5CTWW23yhXW3EiOeP8PS+lZ2gpxYIiC7ugWQSzvbUEYc
 MKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=syhgtlpp2cVTGT4gXxtIYM45Zdyqc3zrofNXRDlJquU=;
 fh=fD7D10OYhga5S6sFXOfoU7oKAvi9BDzpECUX6+b8H8M=;
 b=s3GUQc3tDFGL4I4rkGXIxe24RCRtmXIlqu4OJRYaPMtZCGWJikOpRCo8UifcPvArKH
 z1guJ2ObYDmLXlyCCz8rENUhhLJH7SyoLa6dZKhrS9gDoVgx9xM9QSDbZQSLewt2bCNl
 +aRVvYEfwoMyzjYiJ22k3UZ6eEabYs7Ni8frs5+QTy8BjyPjGZ/+5469rK3D6KB114U9
 1EisJ9SkVxFZA3GjgP55m0iDLHqTfrnqjMEvFQqSBPycWfi0Z0jWos/TC/Sd1CEmw8G9
 4YRl/LB3eFet9DAOQlEyzrhRppXF6oHuAXSe/f3TI6T7Jy/HE2CrXa79qw5XgV0YWLfa
 VPAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795535554; x=1796140354; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=syhgtlpp2cVTGT4gXxtIYM45Zdyqc3zrofNXRDlJquU=;
 b=lOXKYq5ZUalemarxuMoiRoSrXGIytpzp0wjicbfDAfddJXxyU1CJpgByretCxNkpkf
 DM03wXS+AIGZ/PKZbp9iQUEBzhFCMSQv99b5RNInSmN/bqH7geQTGDs3wePsGMItWf55
 fS8IpEBVZBNbDN2mxqLlEwyGiYojHYeG6GdoxDyLPaIrQeSFcPPSCOyGA3sQed7hHgcR
 1A5LCeUQVXP05GYdKlg5PyOuvAtzynM9q4ii6E8Sd2cRRqrY1OeoKkdvXo/8y5GJ4zjM
 bipZSFwVQVfQsobTwl5wv8EHc0wrdJSDm/nDqDLNh6liKi8Z9M8bQZdxs/ZAJKap9JuF
 lwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795535554; x=1796140354;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=syhgtlpp2cVTGT4gXxtIYM45Zdyqc3zrofNXRDlJquU=;
 b=YEwBfeSIshAkuFjDp/9hlhCWCLzX/qiL8poMbJe1v6iwwvziWJWyWFb1seMBoLNvBs
 pcYSQrTyb1RDj2KVigMBtLa9jiHbHx1W0/A2wB+0jWaNtWiGtecNTRS3S5bd2mOPgmKH
 T6I+WpdKqHJNLVuY+5/euKesujbL1NQAVVZIe5JpL2wy6I48CD/cuPlhQA8JMzdo+hFi
 0KnRDolWiadFDOw7/m11AHRF5mVNyr095gj6LIuIvaS1mqHUZ9lFR9Y8dQz98+AFzFFh
 GZKJqQeqAdzOdBt3cI23z92YftQvEGop0pjzyXbuhKNtFMmFxTe4wkrE5c/AK+jWLlKE
 7hnQ==
X-Gm-Message-State: APuU4Z81U9jhpIaFAf6XX/E+2FAz0rnA5chPV52uyziQZ+7UjwL8FQvs
 /Z+7oDaLpehOmjruHvBuWarXyRi0m5AID/L9mIyjhT/TvomzsaVLBXY7BkYZHTHMyU5KJfX/I2G
 SUupSShYdA8Qx9dqU25C78xjQ5EO4hn4UqFggqzi0rmh57K2nwMPe
X-Gm-Gg: AZFdTZf3+4NqxAg8fKXG10eKiqXFGjDmgF4k+A4+qG+XAWRSMenossnjwWkkyz+g4Oo
 fhm/3rrh92L3tVxhrZm5Oq2C490GQ0SDMBfqTZai6PqdAy45uctEdbPxQOPcmY27BQXv/qUHdgy
 HmT3IbEkU5DzXo1+lJGmlMC/gvGjFmX66lAROmufftwSc0pP4BY8kpGuV1lMNZTsFL+nuJqWn/5
 8oNMxo2Wp6Nq5iw5yTLaRC63LRKGrADIWs8Fhj257CurbDdjHVpgcqRI7bekma0KygfbDuVOZOz
 zJeMbtb1cS8fozXCmTHCNgyaBwYrzM6V2p0A9MktbCd2Y8z2Iuac2JDipwE/AAaaHwDfr+1HlMA
 2KdScwljCZylEll2oJmcbURSqpi4fKPHfDzGs0r8/i+1VvG5O8mlphYt3AKzqgJx5nHgZ3A/jcN
 PFR/2RqD1smtCFr4+eLL2L
X-Received: by 2002:a05:690e:128e:b0:67d:beb0:e484 with SMTP id
 956f58d0204a3-67df43ce345mr6359209d50.27.1795535554343; Tue, 24 Nov 2026
 07:52:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
In-Reply-To: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 15:52:22 +0000
X-Gm-Features: Aa3M54q3ahRWmKXOMLUKqi6ipj6Qu-kSaERTHD0rMA1QHmq_KTvuoQcye1GWync
Message-ID: <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less than
 a page
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi -- can I ping people on this memory subsystem question
again, now that hopefully those at KVM Forum have been able
to dig themselves out from any email backlog? I'm really
not sure what the intentions of the MR and RAMBlock APIs
are here w.r.t. alignment...

thanks
-- PMM

On Mon, 16 Nov 2026 at 15:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> memory_region_init_ram_ptr() (and memory_region_init_ram_device_ptr())
> create a MemoryRegion backed by a lump of memory provided by the caller.
> They do this by calling qemu_ram_alloc_from_ptr(), passing the size
> and pointer along. However, qemu_ram_alloc_from_ptr() does this,
> regardless of whether it was given a host pointer or not:
>
>     align = qemu_real_host_page_size();
>     align = MAX(align, TARGET_PAGE_SIZE);
>     size = ROUND_UP(size, align);
>     max_size = ROUND_UP(max_size, align);
>
> The result is that if the caller passed us a lump of memory that's
> not a multiple of both the host and target page sizes then we create
> a RAMBlock whose used_length and max_length fields claim that it's
> larger than the actual backing memory. Any user of RAMBlocks that
> trusts that information (such as the migration code) will then
> happily read or write off the end of the backing memory.
>
> This obviously isn't right, but is the problem:
>  * that qemu_ram_alloc_from_ptr() shouldn't align if it's given
>    a host pointer, and all users of RAMBlock need to be able to
>    cope with unaligned base pointers and sizes?
>  * that qemu_ram_alloc_from_ptr() should complain (assert?) about
>    unaligned base pointers and sizes, and all callers trying to
>    use it for smaller MRs need to be fixed?
>
> This came to my attention via
>  https://gitlab.com/qemu-project/qemu/-/work_items/4877
> which reports that trying to migrate the AVR 'uno' machine runs
> into this because it creates an "sram-as-io" MemoryRegion backed
> by a local allocation which is less than a page.
>
> Related is
>  https://gitlab.com/qemu-project/qemu/-/work_items/4663
> which reports that the tpm-tis-device doesn't work under hvf, because
> that device creates a non-aligned RAM MR with memory_region_init_ram_ptr(),
> and the hvf code fails with an error when it sees a non-aligned
> lump of RAM.
>
> I'm not sure which direction we should be going in trying to fix these.
>
> thanks
> -- PMM

