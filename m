Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F4606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GLREJmDJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQnOE-0003B7-6U; Tue, 10 Nov 2026 10:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQnMO-0002fK-Sy
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:02:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQnMK-0008MJ-72
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:02:05 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so24881855e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794322916; x=1794927716; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yZyf8Dj4EQfe6IMPEd9gop5E0hywwwkTCy+4lnIhCu8=;
 b=GLREJmDJR5mHSJmnL+Yd+JevQ4RRfhLctuIQn9UmuZv6Kc/1aaf4PwbZExSInlXtuY
 VxEnHpMxC6hSVFx3r0V9hOXoQeOpWunui/tnEg8R37x10d/oZ6K6ZX/71rrTIoDiVkXA
 tf7wZmm9WFBlfI/2B9M/v0IZE3/L8ytNSTYb3ADL6jW5/SU8BfJ0DNvxdTjPQId83InN
 acifdT6IACca/7yzb2Ngp7XIEFEHzF/TmmYITkclnHMrDqKbAzuVXGd3nMb1FgcUVZhh
 bMKgmfngDQM4usIiM/kmwePnzxjwAD1AE/cYT6E7/YlQWHzcwSHJ+TQQ6b/zHeyzUdc0
 vXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322916; x=1794927716;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yZyf8Dj4EQfe6IMPEd9gop5E0hywwwkTCy+4lnIhCu8=;
 b=zaQw3zZSVRuf63BoqhzKoYD+KWIjqs1wFdJ4PV0hZRkrA85JrZOzTwsTBaehC4nJK4
 Rv7wMX7b7Mh5BQQ2wJ1N+B1ucQ5fxNMRyEIlUrVvfsbYo9Z5CXeSFBZrUyERd8h28tRo
 +yaxn1JtJtbv5mRmIyWsjBeLSHpPu3LxWHsNS+AW8e2ijct/VMpC/36b0rdizIcL10r8
 fEsf+gx6JLfHTMx9/85SMLPW5xhyKE2y+dismG2AcajE7eWnA3ihnSHdU4FMOPpM2KLe
 NBR6TFgIxuFWIEDQeAKYuWwNxrKXwhcd/qPmP/33ifKxID16ywRTYvxrjGBrAvBZI+ck
 hzgA==
X-Forwarded-Encrypted: i=1;
 AL+hErGwGnNW8q0ypZSEXeImAgUROnT7hVuBLD4vZ4L01plzuNYIpgrv5eD/gUuVTc2uOfb64xVej78ts/eE@nongnu.org
X-Gm-Message-State: APuU4Z8j5pWrPx480rGGiSvNZG1tHrP6vXZ/a80kpo6zBIRSkVyOzqOc
 /psoAd7sicZD+GAsPrdlQGZbewT8/r9h0TXvJPiVF5BTebMf4qR2y+sL/R9ZaZrW5c6XS5Mk0Ny
 OEBnDLAE=
X-Gm-Gg: AYBFou2YhoO5a9oAPVZZL9ZSmweHRb3a6yCsHZYw24ckxzxvdhPVu+X358hFhARaCpk
 +EqXu7vO1d0fDCIFsbjnhdrNU47yFsHkoDxdmHVCT7Gg5ooNPm7aACBB9VlvK2hLFWgO9PWbIk3
 A95BrjqSy/uZMY1G642jO5qmvsmBI1xY2qhoGB4c6tmubsJw99iJDMM2z79dUa98ptX1QjgyVbU
 0UY3o67QaCWQLhUhDLOLfSw0uCY6WZJQRxOjwjhExRhInD/B+DC+9NTGeLSxHxU2TjACpo62RUB
 0ftb12y9E076c3H+f8GHii7VwsYZ/j2HFUJusbYwQ5zTuWVurIgFm7W/NWshO6h2ZwKm/cKHs60
 0zfve4SxfUziXWGbKU+yQhpFSu17nPCbq+9SI0GQq9ylcsM4fbDFltje7Q0QbQjKhNJog3YyBZU
 Lu8NXNEAcIeLLVJxM0LrEZjFQEh0q/bbH6lD99X+MdBfsAzW2oHLuJ+skuL9MeV0iG+m36YteyT
 9Y+xSlUwvELx7WhqZAKso5xL18apf7AT5AFt5ZviwJOR2Rd7vQhOqFczLZVOR3b88tqF/1x6jmv
 ZWjxFnFkA4okXTgdJ1Mg6/Jr4O33wWlp8mUbz3mOFvW+RYl2nS09rw==
X-Received: by 2002:a05:600c:3e15:b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4ba02307c34mr49262335e9.4.1794322915773; 
 Tue, 10 Nov 2026 07:01:55 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:aa96:7f3b:af27:16e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fdac9csm102930885e9.0.2026.11.10.07.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 07:01:55 -0800 (PST)
Date: Tue, 10 Nov 2026 15:01:52 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "mst@redhat.com" <mst@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "den@openvz.org" <den@openvz.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9
 SATA driver
Message-ID: <avMx4EZtBw4DJqUn@linaro.org>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
 <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
 <8b590f1f1d3e6ff6c650d25078fe1f1bc9dd5211.camel@wdc.com>
 <41ef0bbb-1da2-427c-920f-ffe94d36d864@oss.qualcomm.com>
 <ea766a6f-b8b3-47e8-9c1f-094b2da7b4d3@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea766a6f-b8b3-47e8-9c1f-094b2da7b4d3@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

On Mon, Nov 09, 2026 at 11:47:27AM +0800, Tao Tang wrote:
> > > > IIRC, we found that in the tf-rmm branch supporting device
> > > > assignment.
> > > > 
> > > > While it does not hurt, that's why I never sent patches before
> > > > because
> > > > that's indeed a custom thing, that works for a custom software stack
> > > > that was (is?) not yet finalized.
> > > > 
> > > > That said, it should not hurt to add it, since it's just an extra
> > > > capability.
> > > > 
> > > > @Jim: Feel free to complete my answer with links to the code and a
> > > > spec,
> > > > if there is one to share now. I'm sure Mathieu Poirier has all this
> > > > info
> > > > also.
> > > > 
> > > > > Michael, Tao, what are your view on this?
> I agree with Philippe that we should avoid changing the guest-visible
> behaviour of the existing ICH9 model.
> 
> Regarding the NVMe limitation Pierrick mentioned, I found a related
> discussion in the original Arm CCA Device Assignment RFC, where Arto pointed
> out that skipping an entire BAR containing MSI-X Table/PBA could also skip
> other MMIO regions in the same BAR. [1]
> 
> More recently, Ankit posted a PCI/TSM patch that parses individual MMIO
> ranges from the TDISP Interface Report rather than treating an entire BAR as
> a single region.[2]
> 
> I'm not entirely sure whether the MSI-X/BAR layout issue discussed in the
> first thread is exactly the limitation Pierrick encountered, or whether the
> recent PCI/TSM patchset fully addresses it. The changes look relevant,
> particularly the handling of individual MMIO ranges within the same BAR, but
> I may have missed some related changes in the CCA software stack. I think
> some further testing with NVMe and the current software stack would help
> clarify this.
> 
> Given that QEMU NVMe already supports SPDM over DOE, if NVMe works for the
> complete device assignment flow, reusing it might be simpler than
> introducing another storage device model. Otherwise, I would favour a
> separate PCIe AHCI model as Philippe implemented.
> 
> [1]
> https://lore.kernel.org/all/d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com/
> 
> [2] https://lore.kernel.org/all/20261105152909.53452-2-ankita@nvidia.com/

Yes, it's fairly obvious now that we shouldn't change the existing ICH9 model.
We could potentially subclass the ICH9 model and create a new device, however
that device would not be modelling any real hardware and I don't know what
QEMU's appetite for more test devices would be. I think for the time being
we can keep our testing device as a local change; there are plenty of other
changes to be made for RME-DA which do directly correspond to a real spec.

Thanks again for the reviews and feedback.

Jim

