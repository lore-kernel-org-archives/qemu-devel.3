Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84421606A886
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lwRK1ZDV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUyB-0005Sf-UW; Thu, 12 Nov 2026 08:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUwn-0001WY-JT
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:34:43 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUwl-0008Vl-FJ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:34:36 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b309147589so44911887b3.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490465; cv=none;
 d=google.com; s=arc-20260327;
 b=S6o+ZkwqZdLRh2VgEIcE+lGVxZ1Wed19Of2AOvWOziGxZF+JXrz+DdaiKWGSaDaKVa
 2gDtHSaviV5Y5SZANkYMFcFpFNjSHkaRMyvOKGUgush7dW01Et6gXmf4iEBBnpA2a/A6
 aqV05R5HVC9kmHO5X12RXW39Ec1+es53ePOXb8NITLT08JLFdCT5CS+RnAt5ZeoJRj/n
 a44MhPD8pYwRUcJ90lvjh6CT/F4AxHj14/r5ZUHVCH3+VRBx9Q02nld5xO/4W30Y0kDo
 eC3WRwS1Ho6CynhwzuIE3eMVRbyRGkjzeFmQdd1lrtzjx4q2q0Xxhdg8ARMHQ6FDKFlC
 3x3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ns8ylSdCMT2rwVx/1dnjwi+QowFMQXx1nBiuAde6QKw=;
 fh=kcMqnS/hJUwNpfuCppCDf3FNNhF2MmmzGCBFK0eEBhU=;
 b=R9S3sUo0nE0euIEyNF0mcmREhgsxLzRmXjZ4HxrEN/msJhpl+B9gLNXo8ZAyP4ZUme
 2sCD7Ju2R1DiTUtJXFfPRBX+SpoYb/02TPyUPogmH6YDrLqD0z5cGSBQiNKzowxCFI/Y
 vAnnOfcl8urIkhP0Q8RA0famGREJ+0WpeGdHtEgaQhqH1Xl30KchbS/PBDY+ZRqGeiJ7
 zhatDLlsUQ+TcgzjtaXXvb5FEFR8JX9CfndPUUkNTH7CdETdi1ZKU48uxBBUPkjmMt6Y
 JEjLJyFYtawzWAtu/WHB8zs0V146SYIbx8bYmmk4hv0R2w6Cs86ivpyBlYQ+ZsECmDTx
 1vQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794490465; x=1795095265; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ns8ylSdCMT2rwVx/1dnjwi+QowFMQXx1nBiuAde6QKw=;
 b=lwRK1ZDV7Ti74zIPBa1ks2YQwhzYNmmxeuyss1HhSt0Eb4JxeLNm47rfQs/it2KEY8
 3RysZJ9LxNnAgOAy2CSPOCUs9fetPBGdH+5gVxZ7UTjbJjiW5MmM8YnP7L1NK40LAF+i
 px9ynx2pP0MMZFS66dxyiOc8TNXnvrQM3XlCKvBWCZ7YGNcC/VkDubXQseUs+SEWiRO8
 XiAouyJsAnfQxvyF0MjoCIMynLVYpgCguF5HcKIXtxFmATUw+WPt8mlOrraNsQ7+RWx/
 HzaQAHB9mZEp9OtciO9C6z+aTNM5dAT/AOhxdCTnopqD30jOZX554y1hfY/h9WF4WN4S
 myQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490465; x=1795095265;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ns8ylSdCMT2rwVx/1dnjwi+QowFMQXx1nBiuAde6QKw=;
 b=tOOSrqurMM84fhTtNWpbK+F16y4+SMUDrFXq/3EUyhs1muCReKMD6viRamp4rEjQDJ
 eJSV3CRuvy8dEqrfGZ9T7TvvSeiizmDRhxg4GQ3BG/HWBWGU4aFK4zBd/RxCEDS+TmQs
 59DrnXaRbjwodpUlQ1woz9U0mQ8qKtnnSrt4iOOoOGBSgOARh183Zg8WdgGe04Aqd4Us
 tkBgB9gsj19BXULHZhgxTGnbOkJyFFup9IN2DIXMJenzryqCvfZ6x9OX746/ExSI8sPh
 ZOZRuDMqIKpU5f6WuTmI3F8oDQ+o5VXaEd6G0KkjeneSynWyMhLun6Kufbh6xs5WjzVF
 YHbQ==
X-Gm-Message-State: APuU4Z9csKACqUfs3TMGDd7C/9T5NI6Nd1N2px1OIEIDPyOtyQ0GO9HY
 M6HjbUSKwxh6wobdXYFQpfMqBsdsiBU69fh8rGSsgFjqgvCDpDvoCmWmuLIE3Dju/LbKTTrJHOF
 +QIBOJesuab7rPTpk5Jjl4SXSC5ZofxjDs9uwDuskLg==
X-Gm-Gg: AYBFou3OU3zHRo/EQZeawi9Tqv3P83UCqUAoJTf4shBpDSKXq7ucNwveU9f9S7894g1
 XgDGoUssKwVQN3iws0lktNIWLTkmOAvw+GAJa3PDdW3bonux1XuD680LQq5s64Skf+Tlz/7/8kr
 hGofDemkqc/2oI6soFxs/RjGvg9mDf4jSYJ1ECIb5YLXzvRHbL6sako9N0BBCz8zJCElfUuGx9u
 tH2lXWHLrBGv/FLC3F0KIiJzLGqNdnyRpHkK8NQw6f/xh19ZdOeJnSGiHlcA1vw4tVXXpYb98ZR
 4NG6d/4oo6/cE2HECP/fAaBGNaKyw/SCY0UqbfpVHb6B+m/voK3DsCDRh3ZPP9rfBpxMwWEdCJw
 ozohgG0/bDXMkrcNfELS1voRbs5TprnbnAcWBmOtPR8M8T8rfBmtT6yYBZC72/56RtGoh9TObI3
 gQ5cfbk2Vpg31qrD7tJvlY
X-Received: by 2002:a53:bbca:0:b0:67c:1383:1d68 with SMTP id
 956f58d0204a3-67c6800418fmr3135420d50.76.1794490464645; Thu, 12 Nov 2026
 05:34:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9ue4-0DacSPtEB0BEP6HyG7nHtCy5vnsuxoz32xBreNA@mail.gmail.com>
In-Reply-To: <CAFEAcA9ue4-0DacSPtEB0BEP6HyG7nHtCy5vnsuxoz32xBreNA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:34:13 +0000
X-Gm-Features: AclHuK9SzsdqrtUDs_olWxmhqGMbck9TIxBeRVIBH7D5uZURqvyen8-yfkw_kiw
Message-ID: <CAFEAcA-wbBT3Q0qjqqimcQ4nKKoTkrhRgSzYA+8h+u_eT9k0hg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] net, hw/net: Validate header lengths and harden
 packet handling
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, qemu-stable@nongnu.org, 
 Lazymio <mio@lazym.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 9 Nov 2026 at 05:31, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > Supersedes: <20261102201828.1879576-1-peter.maydell@linaro.org>
> > ("[PATCH 00/11] net, hw/net: Harden common code against bogus offsets")
> >
> > This 14-patch revision combines the IPv6 parser fixes from v1 with ten
> > patches from Peter Maydell's networking hardening series.
>
> > Both this series and the igb patch series [1] have been stalled on the
> > mailing list for a while. Jason used to submit pull requests for
> > network patches like these, but he hasn't been active recently. Could
> > someone please pick these up?
> >
> > [1] https://lore.kernel.org/qemu-devel/20260623-igb-trl-v8-0-c9b1fc6c3304@google.com/
>
> I'm happy to pick these two series up via target-arm.next if nobody
> else objects.

I have applied these to target-arm.next since between us we've given
them all reviewed-by tags, and expect to send a pullreq by Monday.
Shout if you'd rather have more time to look at them or prefer
them to go via a different route, and I'll drop them.

thanks
-- PMM

