Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7083606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f+R9a8sn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzPV-0005FT-Ge; Thu, 05 Nov 2026 10:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOzPT-0005F9-Rr
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:29:51 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOzPS-00013h-9m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:29:51 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0cf2c0785so17588287b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892589; cv=none;
 d=google.com; s=arc-20260327;
 b=ZP/MTiZJzPlH01FGIB5KMy1SBn1forfRneIkpcqvozO5J0vjxYbDByAg3tbPk8h6xI
 BSLB5tSpYUwglt6MZ+Yj0LRS3KFj2hwbkwoFn7jMjBJoe4hSnvuf+Uw8q/AxY7G4qizy
 lENcH3Kz516Xpn7Y0ssMBnB87QqVy7ugREKye42+/ddxOE3HEFprIx4t/0nBd2aP/A5N
 rZeyXvYxG8xbquct5YTpH2iMA9VZ7ZDnfXR0X0O1sFWqUchyZ7xx1uM1/ZFfqkaKgNlc
 1zHqspKayXGnoNTNqYukmlGpN6M51y80Krm9aWuk0ZyyDt3nDpaQB5qhQvZTAWw9cJR5
 4uYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fvc41J5rrKOURLR4lvPkC9ba8pu/HNCoimZdpA7OITE=;
 fh=H7StoTss7GfgTn3/MHIAQb6OmrYj58EM9z9EYIdKXOo=;
 b=K+roPNfA9Cna+4SZhHk2yeQMmkUN97GGeAMUxYW4RwySYPQrUHw/afUdOCoMJdFhHz
 0B8g3vXkHyJnzsXGdM4CqAqb+smnaDlmrx1ptWnGf3GDn1fNUVIpeWUsmC4NxFSMK1A/
 I+E2yKNr3SKATcDRInUNQdInRipXx6vTbyn6EvDYB4n3fydh6T4hbmqGTbTuKkV05HPQ
 IUJ9DU3X2jRjnTiWCARqvcR3ejhJetfMOc2cPKTydQ+QoLiyRJVOVht2V8O/85i+fwB4
 mcBm2SmEUmwU2Li8jl3uFu0QMLYfT88ZJFXQOGrIU7GZRBL/v9UbvPNigdCT9i9dO5EI
 HBdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793892589; x=1794497389; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fvc41J5rrKOURLR4lvPkC9ba8pu/HNCoimZdpA7OITE=;
 b=f+R9a8sndV9yFtYlX038Y47BubQwkoKYyntHi1vcKMFIl9bzcu8eq1U8hhiR6BOkVj
 OSPhSbAD5q65kQYJdtTm/krAGExqsZ26NNCWW27D1oFwyvfIMFFFlRLOtzbtCIB5CJNx
 jAahMQChn1GiWVIDXmpq4MH+ewgnTR7HbYaDrNRGbC0bV90rq489ZWI7k0NDHFyonTp4
 iwdSDDWGWRDazyY5PQ9M8VLto1MAEVmiB2Opvv8tkKJN+rBohNhYo4cHanCTT9Dum6Gm
 bkQDpcnRviPkPqG/6PXxKUFJnHIkQCtAA/yfBJuAdc1sqPweo6cD5QAINS+67jiSN2vG
 p05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793892589; x=1794497389;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fvc41J5rrKOURLR4lvPkC9ba8pu/HNCoimZdpA7OITE=;
 b=MrHNQCNGypvmnhkz8lWBFKwjKn4KkHpdMCkrTXlZ9pS1QDNpoQ1tTbi6EXo7J02VCP
 uYdstOhoRGWyOm4/gwgtnc+wH91BLvUfk18wrG0V/RRe4jcoGl1hbZUnp3g3uP/+AIOv
 DFUo1uU1X8+BR34WS3hGq3ofkhvGiLiReAVJ7EX1DVm886f0APcPqOVuy7ivx4f9seGX
 POoNfTWU9TKEgwyN30b1OWixTlKwwP/g2mUK4+JrJ8H0yKOQF+s1KamHEVT2/rqmnAI3
 /dH1AxNPAdDjSVIjQ2XybBZbzsz1lO7pWpatCGcKyFW0mMD9vRjm2dtcGfd2ybBa+Z5B
 IJdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx/2oSP/GECgXkC1jDbc5FTPjFa3vxr16u0gN+RvlSyqsYyyaVz6Kyre+NbvyF7+oPJkmaHlHi3yT1@nongnu.org
X-Gm-Message-State: APuU4Z8wAaogoIhMUeBCpWLGungJ6FkvaBkb8KEXkHTy/nh9IQlSYypn
 0wxvLrdzaQnqXBRl8l7fwcgFHpTzhYUFXIsgUkalNjVMhHXXM9+G7xflCR4SrjJcqjhW2GO4evn
 pwY/YYI7UHMVLnqAAHpcrFP9enp6i8QHPU6ZIPRMeGg==
X-Gm-Gg: AYBFou21LfgF3LgwJVrYxRtRbOQghg3B+xS+KgRKQr5xut0J9GbUu7cX6EwekS/mKEr
 nszf/mVDHdCBywcxYjLEAw3NUOaoQR7fenjyUiYJnWL5dIJnudJkoelMwvU4juoYrtQX+L8WW/B
 Xy/GhWgJrsLOr6AXqOy1TFw1eMfFjnrtIJsdyfeFSwNhH46cOwuQqVC8odfhIwMlt3TqpWHqLZf
 OOIXS6yu3BnSwfajEands1YgVZnL/W9ExHJ6OWAlr7RAsMW5jr3gRjyqhDYZDL5KiUTqW75aXxQ
 WOpNP93yInVHV9rWTPjRnNPBbd7Q9PWHWvEvMCkNJGM2LdYjU/392U3fsoI3Cf0W6CO9uklCkxR
 4XrswWQUBCltRGQj0B81ZJZv0us/OzjcF3G68cgvXQ2OWaxYlwlps27g8K3GDuZHZhICnD5NaSZ
 c/psF38mfAZv5es4t4/ol4
X-Received: by 2002:a05:690c:4992:b0:8ac:46ff:d360 with SMTP id
 00721157ae682-8b2b6426d6dmr112591067b3.0.1793892588594; Thu, 05 Nov 2026
 07:29:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260819095855.115823-1-rathc@linux.ibm.com>
In-Reply-To: <20260819095855.115823-1-rathc@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 15:29:37 +0000
X-Gm-Features: AclHuK-oc1OsjYX-cLEvlg-T2uMjhkP3895Wq8ahiBzv5vI2RE2ww30FIukBpfw
Message-ID: <CAFEAcA_BGS73EcunV7=kedi4t6p93bcmNSABRFLsJA5fORqTYw@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com, 
 harshpb@linux.ibm.com, fam@euphon.net, pbonzini@redhat.com, 
 amachhiw@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 19 Aug 2026 at 11:00, Chinmay Rath <rathc@linux.ibm.com> wrote:
>
> cdb_offset and local_desc values are dependent on the guest. If the value
> is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().
>
> Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
> bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.
>
> Make all callers of vscsi_preprocess_desc() check its return value and
> handle failure accordingly.
>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>

Shouldn't this be Cc: qemu-stable@nongnu.org ?

Did we deliberately decide this wasn't CVE-worthy, or did that
step in the process get skipped?

Ideally bug fix commits, especially ones we might want to backport,
should include a "Fixes:" tag giving the commit hash and subject
of the commit that introduced the bug they're fixing.

thanks
-- PMM

