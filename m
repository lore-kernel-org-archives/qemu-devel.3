Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KsZWHmFi;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ElVBtPo4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWrl0-0008Bz-S3; Fri, 27 Nov 2026 03:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWrkz-0008Aa-F8
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWrkx-0006fI-Ts
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 03:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795769794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
 b=KsZWHmFiUowYGT/dztBPy/QNjF8QA21KoStNopHhdrcxySE1n7xGM6JZPlKqZJCfNdd+0+
 4dcB+PehQ3tCZZ/SeQC4txg2elIuZGjuGNdoM1G4F7KxtX6Ae/6KKFcOcm8u38duw/3aiw
 7/2gTjSjwp41rubwdoShdWQDQKKOU9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-G9JXIj2SMpypuYRMHCAzkQ-1; Fri, 27 Nov 2026 08:56:31 +0000
X-MC-Unique: G9JXIj2SMpypuYRMHCAzkQ-1
X-Mimecast-MFC-AGG-ID: G9JXIj2SMpypuYRMHCAzkQ_1795769791
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4bb680f0ac4so55101655e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 00:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795769790; x=1796374590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
 b=ElVBtPo4LVjhU1dmXSwhU8iRkPReopBZdVklpw6ZSUlOZodp6d/1/T2aLlQ2N/uKR/
 6ko556WmM8tNLrmbr9qnXhNUTt67KS7r86qftMTxvmIbR/9s+0nStdF0Of0UXqoqL4Yw
 Cc7Rbqs48iYYqUkYCXpI50MXkXr5qNNyi5HbetOKp7k8H8VHMlwX3njBSdGp0CK8OsPJ
 Eb7R4a9i7W+x0H2YOFy4vblb3dW65BOa5FmbPIm58bdt0TwL7NmY2N1jxpQJKJFDVStQ
 YwhYaucQAtFLxhx//8EpHdsna4HmZ5zxfCLBZ84m4E1yPM43dH/nlyOce9OS6yYKng4B
 gmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795769790; x=1796374590;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
 b=F/wXikViEUbU5caFnmp/GEdYSOxQP3/VrjLDIc1HxTtcdOGSEXXPfYVOLW9HzSG3Wf
 Yopb5Sk2tGU7Y7r0HtjzP0k+h+BBy+T7LEUDsU+R2/dTHe4iSYARjlXdiUDjDgptWozV
 jCbHpg65YkIilaUHkVW6VqwrBptD85EkNCNYtsFsxRT5rCwgp9kNA6AUC6sxrwqKt0oE
 TmIe4XFHqvcA7eCtJ0HCqIm5oLeAxdTP02HPxK/BQm481Tz/awEUV5GV2M7GlzA892ue
 5SRpN4Bhaxfqbd5nN4GFVtu27rsBlG8yaRb4bzjP+n4s+Oxu9UO6CpDQTmrWlHAtzHIv
 RPvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGSJ9Lh5iTefhC8xKDbyQPQA+d6E+VzPZfOk1AHDwWi23ULzba/nWpf1yMeDcD/7Nerr3L+QlPUKQ4n@nongnu.org
X-Gm-Message-State: APuU4Z+2sdAqBvjJKqqNULeoouFgDMBWYOwrrX+6ru85eEzznPG/5a/r
 m5MsuyVBjaZehKbIFblA88Dw9uS+IqilVD0SVxOKpanY9vCgMW75T7nVzBwe2OazA5FzT+IBEja
 5tf9NVxxVgDDTQEaNaEQnSCc6LXU1vi00ukwYsu2Ahgw/XwD1OZ9J7UK9
X-Gm-Gg: AZFdTZeKYdk3sQf3XxkiHR4IiVS3ekbK1+5Afh+epdySlagkiJXRinQzznbxwLE2ShW
 t8/Ji+MpxPB5RCvmlkugLXVi7rTwBulHlXyWS4gYYA+b0HLmMbM35SRiDCA6Jko75mDOBnPSfZd
 fpCDeAGpi5AzKhzTwQtT2InoYi2ZOdYnLhK6AT5J6RC0LWCH6MLt0ye6gM4EZbpzbBt8OirPEnY
 MsJZRSHJDLoqXNM47SJZMMzNeWX5UcjLSXkpIjES6DhWXDLEfrzRp55o1o7rMyAKnQpWw0n61Gf
 bKWUD1jU6KOCENNFCIVSEGZtSwWNnrGxnb8uICpeZ5ScJsqWHhhOwu+T5MWosdEPlS5592ZP/7D
 e84giCQYrmS6JrfAuAk03AewYeEXCqjnsUFWl1muw/HkCBK1BIkm9F8CpylA2iGnsDQXFhJtZlC
 2QCd4Yxy8aSnoCAp8b
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb8892a21amr442437525e9.34.1795769790691; 
 Fri, 27 Nov 2026 00:56:30 -0800 (PST)
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb8892a21amr442437225e9.34.1795769790357; 
 Fri, 27 Nov 2026 00:56:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm894279635e9.0.2026.11.27.00.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 00:56:29 -0800 (PST)
Message-ID: <bb8b3f0b-0948-4509-be89-d896ec94d7e8@redhat.com>
Date: Fri, 27 Nov 2026 09:56:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
To: Haseeb Ashraf <haseebashraf091@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, Eric Auger
 <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Khushit Shah <khushit.shah@nutanix.com>
References: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
 <20261125175005.805533-1-haseebashraf091@gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261125175005.805533-1-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Haseeb,

On 11/25/26 6:50 PM, Haseeb Ashraf wrote:
> Hi Eric,
> 
> Thanks for the feedback.
> 
> I agree that exposing VH as an exception is appropriate for now. KVM
> does not expose VH through its writable ID-register interface; it is
> selected by KVM_ARM_VCPU_HAS_EL2_E2H0 during vCPU initialization.
> Keeping this explicit avoids prematurely adding a generic framework
> mechanism for which no other field currently has a requirement.
> 
> On the second point, my wording was imprecise. KVM updates the
> guest-visible ID registers automatically after vCPU initialization, and
> the guest sees the derived ID_AA64MMFR4_EL1 value. I referred only to
> QEMU's cached isar.idregs[] copy, where the framework currently deposits
> the explicitly requested VH field but does not re-read fields derived
> by KVM.

Effectively get_host_cpu_idregs() is called on the "max" scratch vcpu, ie. the scratch vcpu initialized with all possible features. Then we update isar.idregs[] only for fields which are explicitly set using SYSREG props. 

Thanks

Eric

> 
> Thanks,
> Haseeb


