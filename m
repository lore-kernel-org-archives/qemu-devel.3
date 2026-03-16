Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF80F53D99
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Edx-0005qM-0i; Mon, 16 Mar 2026 16:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prestwoj@gmail.com>)
 id 1w29PO-0003uD-VR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:59:07 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prestwoj@gmail.com>)
 id 1w29PM-0005Qy-Px
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:59:06 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8cd8576a512so596916385a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773673141; x=1774277941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TlEzqxK2YEl3SXEgkPbUbfs0P9bQP+Yj8HFphhFYGSg=;
 b=gji4NHxOX9gzLsu3+YiDmk01xlzWBGcH1RgX+AsmQayRnriFsJ82U69EsVwNeHEjkG
 K7MzLD4RiUVeEYTbBzBjHkwdiHve5Llcj8+Y8xMLLDz6SuIQ1KWqAI5Mp32/nkIG2w4O
 3wMQuG1Hk+cMuix88FFa8wQkmlLlbQltNE0zcAEgqMC+W9ySzuTEHwdTlPojOJAn/PR4
 zbhfta6zHjV4PBFVD1QMs0/qjF+kcxiomvOz3C5PODVasvstq+SMQTdyNnNxhC2fWBvX
 9Yksx3d7aRwpn1YVLA/Sy2QxuK4wPga37QTif92w3LM1M+Ed7WCKZadoJCfY8ehJSILf
 2y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773673141; x=1774277941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TlEzqxK2YEl3SXEgkPbUbfs0P9bQP+Yj8HFphhFYGSg=;
 b=fW1TRNopeQ0eYvfBz2etZPfW7WoUMxyb+Dc1XkqHGVVoZnMeDNrwCRUh+TnTOcK1db
 sU9PQ9wMf7/T6Kk08YwDLOgZtUYWjohB49Y1YtzUri40u6UNxYv285DhWxCVmdHEtdJE
 1eFP33dPrrt0T7KL+sZo1W3vbRG4x1zEgi/k1kbjdaat5711bH9bpwEazSqLs5uGPoX8
 1Rm1p2GQRxbqyGVPca/sINVmqm0o/fFgL2vDasEld5uy8BxjCFdBFyIqXRwaCcyZK5Ky
 vJyDjxk6ZJJblROb8bjfehI7gq3a3/C5Ab0MXNFnw55DwmYbPgtAQN0tlTyUpr48J1FL
 sSqA==
X-Gm-Message-State: AOJu0Yzv3+KabkWTNusv9q71BJaR/xRs8qvCEoW+11es/JPHVtZeV4pM
 pScm97Loi6mmX05qUsvvr0wOFs5gmXATJUJ2VnXMDjbIIrPs7tZrm4Ua
X-Gm-Gg: ATEYQzxRgrucDWNJg2SGGhEPN6T9J7uE092JeKsskj9K7uMiyuF6kxlOJ7qBDkfX7Lm
 F7SrGQ7QX1b5B4YaDtCjjCMA00tUq8QhZbNkAXf8AGBBdYXz+flGI+R0DDO8oenv0qVBkE/TDet
 TS/ta6h11cA3PXV0Tax4rHGcTWjmZCXeW/8drjbL8FuRfPmC/TPCp5NIqc2y4T0bEvtEoYP+6rj
 thRTvL14JPI8qA+pMHnh49bOHWvM6VfqfV02uNLhtV7wB2nbeBeP0BQjADHIrjwcpchS0LjYF0t
 HOYG/b6A44pxyxVDSemLQxg7tE7mv3rYTGo8ggrYRU8QV3CJMr6ZqqOWsNn1vYs7Tdyxc51EduX
 M/TYGu3M71V8o49MrD/cGnlfNRZ4FsjiLPtyEww+5YhtJi08DErCLak9wvZr4PbU6iglWakWD0Z
 O8B4Cavk1HBbIItBSP5yempo7YuA1Fq9wxTldfz6yFIbDdOlGBK61bO4YdpQ==
X-Received: by 2002:a05:620a:2913:b0:8cd:94f9:1bbb with SMTP id
 af79cd13be357-8cdaa870dcamr2022355085a.29.1773673141041; 
 Mon, 16 Mar 2026 07:59:01 -0700 (PDT)
Received: from [10.100.120.215] ([152.193.78.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21100b8sm1232308185a.29.2026.03.16.07.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 07:58:59 -0700 (PDT)
Message-ID: <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Date: Mon, 16 Mar 2026 07:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
 <20240815171935.GO3468552@ziepe.ca>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240815171935.GO3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=prestwoj@gmail.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Mar 2026 16:34:23 -0400
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

On 8/15/24 10:19 AM, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:
>
>>> This is probably the only way to approach this, trap and emulate the
>>> places in the device that program additional interrupt sources and do
>>> a full MSI-like flow to set them up in the kernel.
>> Your last sentence here seems to agree with this approach, but
>> everything else suggests disapproval, so I don't know where you're
>> going here.
> Trapping and emulating is fine.
>
> My concern is really only about skipping SET_IRQ.
>
> That works because of the assumption that the IMS sources are going to
> re-use addr/data pairs setup in the MSI CAP.
>
> That assumption is frail, and won't work at all under the proper IMS
> support Linux now has.
>
> I really don't want to go down the road and have someone tell Thomas
> he can't convert the Linux driver to use irq_domain IMS because it
> will break this stuff here.
>
>> I have no specs for this device, nor any involvement from the device
>> vendor, so the idea of creating a vfio-pci variant driver to setup an
>> irq_domain and augment a device specific SET_IRQs ioctls not only sounds
>> tremendously more complicated (host and VMM), it's simply not possible
>> with the knowledge we have at hand.
> It seems like you have reverse engineered alot of the necessary
> information though??
>
> Maybe there is a more generic approach than a variant driver. If you
> wanted to use IMS from userspace generically you could imagine some
> kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
> needed irq_domains and pass the addr/data pair back to userspace?
>
>> I observe that the device configures MSI vectors and then writes that
>> same vector address/data elsewhere into the device.  Whether the device
>> can trigger those vectors based only on the MSI capability programming
>> and a secondary source piggybacks on those vectors or if this is just a
>> hack by Qualcomm to use an MSI capability to acquire some vectors which
>> are exclusively used by the secondary hardware, I have no idea.
> Well at least that should be testable - but it seems crazy if the
> device has registers for an addr/data pair and then somehow doesn't
> use the values that get put in them??
>
> Copying from the MSI is almost certainly a SW hack because IMS support
> has never really existed in an OS until now. I think your guess for
> why it is like this is pretty good.
>
>> I do not believe that introducing a vfio device feature that disables
>> virtualization of the MSI address/data _only_ at the vfio interface
>> (not to a QEMU VM) provides some implicit support of this device
>> behavior.  These values are already available to a privileged user in
>> the host and the same is available for an MSI-X use case by directly
>> reading the MSI-X vector table.
> To be clear, I'm not really worried about showing the data to
> userspace.
>
> Userspace just shouldn't be using it to implement an IMS technique!
>
> Jason

I see this thread went stale. Wondering if there was ever a final 
conclusion if this could get fixed for ath11k or not. I tried again on a 
recent kernel, 6.17, and see the same behavior.

Thanks,

James


