Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E32606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RbavlMml;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JlxLlsiC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOzf-00065h-Jj; Thu, 29 Oct 2026 08:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMOza-00065D-7q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMOzY-0008JR-Cq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793275941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldXofnG5HIs9aTX5OBQJ35UmUymT0t9Ke2E8FTM24PM=;
 b=RbavlMmliUBHs2WmLpZehWy2z9GKo87tmBY61VqxESPJETzgL/fKE/9p2ErgDCqJQ7uBTQ
 byZFMjh1aracSNJDIyg1zYjTpyA0oBy+RKTsHzWcJ96hrk5cejKg/SyfeeOz8rBangeOuR
 rVS0Bdw3hd7IhSS3nz+A9IpqhY+IZp8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-HxdTTYnnPMa120RUNScjBg-1; Thu, 29 Oct 2026 08:11:05 -0400
X-MC-Unique: HxdTTYnnPMa120RUNScjBg-1
X-Mimecast-MFC-AGG-ID: HxdTTYnnPMa120RUNScjBg_1793275864
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd633da24f8so2549155a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793275864; cv=none;
 d=google.com; s=arc-20260327;
 b=defopguu4WaQTJp9oKMy/V+y4YmnVXtv+KoBr8GFJIxFKrzy78uS5S0hFwci0q+gCX
 YC1vesI1Y5sBfcFftlQCBEL3OymbISEFabEHzcoxu4Qef2UOA6DdDFDo6817Oz8zJtYP
 JfNgh00AA7CkgPUWzV+CGLc3bJxw9E0Jnbjl02jYVi+KloOlfiFHvLSAOlRGf7tNOQO1
 Lzg11pVHNdbxsyHO9hNjYzc/fl7b1QUGbpP5wBY57TOLD7Wyyt6N1xb//cairqYZwDaj
 hQPAMEWDVY7n6g6mISUHuzvqQnIDxwsJCdByKnGJ+4WJdlChsmPmhpHxTH0KSl737kJh
 7h7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ldXofnG5HIs9aTX5OBQJ35UmUymT0t9Ke2E8FTM24PM=;
 fh=zdtXbIfAQbT/cPZLD3ybTOEmR2+iKnXcM5938Tapchk=;
 b=WEQF7kci2/S/RgZ/TSEcoSgruB99OHCheEdBnYOXAMpjwxXrtlyj748hzlkxd0bVRJ
 CGgDLcT0wpfTc182/wSPenM0FJE34kOnG16d0w9Yhy0lOL7ue8BwrxJDTtsD2BvH1BjS
 rFV9lrT9Q/DNsXeUvzmqkKnyNYtmwaS2hsOn2U7R2t1NGa5OzrOya7h27m1gPWXowUEY
 Sp8mdhjsY0QvBp8DQ76bfg8rFPfFVHKRwJROC6rh52nq65uK4i8QFP1ems2RAhMxgTt7
 Dm7GMCWODqgA1bBRDrKXGOM9cJCxRMO6orwBGZvAZxYe88A4nq7q1XMnlFEoyzX6lmgh
 eJ/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793275864; x=1793880664; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ldXofnG5HIs9aTX5OBQJ35UmUymT0t9Ke2E8FTM24PM=;
 b=JlxLlsiC7P3AI/fRP2SjAbFD8Et7YbNf3gUlX15dizDi45OyXhQF7UAzltlhF+fbBn
 qt2yAySO8bFEHkzee8sbM3792cro8M/HEjYSPRAVxWXAxkKurvh55D5S2KYH38Io396Q
 4WfqxL/XxEU17VvaGGnDBB4h9kWG7rIkwgSvHYsaMYB8/KTDckT7w64VLuRATWlOeQb+
 4lV4bJGD5LnH25FAGuzZdxSQnO8PyY0gTL57fdUR0U2uEIjAwsE1zIARTF2CXLOp+cXX
 bGgdOD5QXItn6pctL2DXfx5vEXdUI4psNoQQw/LNdcuj87gmw4fiaYwW7IKeRmQ0ys9r
 rEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793275864; x=1793880664;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ldXofnG5HIs9aTX5OBQJ35UmUymT0t9Ke2E8FTM24PM=;
 b=FNQKnYXvIbvrB64XI7v+aN0NXQwTprI0j8h6D3y21HTwBmIerFpu6loMp5sGZFkAKu
 NGKxr/UFsSXCSdKuz/GXMSk8rOIm+w2B0lJAq8zGqebxcK8KkPsyMqctDyKeGxfWdTy2
 hPJDpsqOiPd+oN62eQ623VjS5aUTpulOvRft+3S40kOS++wzUGUxUKcOAhwp8HjtF4zA
 nJixzBer9FRUH1YYkHnefYsBzXUfYDQGsWtDf/CXGurCv63FD5yFNR+esMmvafCAY0D5
 MvH3lI6kq3l311VywGL+ppsM4UcZK0TK4wdc9YKW3gFdLgham87Dl9AtQoMjLUVyj8TY
 QCNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDixQ1Otzw4/ZaJ+U6wdrrRjp97Iy1Dxa4wSYzOK47jhoMjiYzvUdG/udb/YHeUGWBX7bItf1jBwNQ@nongnu.org
X-Gm-Message-State: AFq9FYLZzFUe+JnfdTkgrDXCMOn8HQzsCZ+ifksfwdXFZlNDlRi4Bszc
 /uUQQfIZCjmLCkoyEbRCT3pHzX9WdAJI/j5pm6NyPl+lJ2MaFm1G/QYclzENhQlRSHVXwMqP9wX
 s7lvjt4tuc3FqhUuBmIkEKzMXGvFjq4+0SpNau0H6bNtOmVv8hYI+WmimcauSNEhV8/A5ke1Zuw
 C8KI+mG9J2SRFTD5KGNcHMvtJI1oYG/X8=
X-Gm-Gg: AYBFou13gipouQ7C8mYAH97ok+7X1Mvf89YrsSkkPPqYEIvP7VTV+Wp85KyjiDA6hZA
 SC0Wi/5sQdVM/aX4naRP6j3mmAuvQLljrJVbcZPlYKYpr5FfVPvgpHwSiZgmujH7ddN6MGEN3Pb
 ngkVPgrUCRaZ3dbZ30dn+qbjzR2RNf2t1FUSqOO5qP69gzBUBzlJg8FD3W4stqsM0V0g0UZEwty
 zoq91zXs7BzF09B
X-Received: by 2002:a17:90b:3b8c:b0:3ac:d79f:8229 with SMTP id
 98e67ed59e1d1-3ae58145332mr4225175a91.61.1793275863943; 
 Thu, 29 Oct 2026 05:11:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8c:b0:3ac:d79f:8229 with SMTP id
 98e67ed59e1d1-3ae58145332mr4225136a91.61.1793275863505; Thu, 29 Oct 2026
 05:11:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-8-eric.auger@redhat.com>
 <31abc997-8c83-cd34-7fdb-5dfeccaad26d@redhat.com>
In-Reply-To: <31abc997-8c83-cd34-7fdb-5dfeccaad26d@redhat.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Thu, 29 Oct 2026 17:40:47 +0530
X-Gm-Features: AclHuK8Af7qIyNR8NLM41mprqag1lmRF3rdFXQJiFG_-nm4BySvrCNzqm43T36I
Message-ID: <CAJg9KkzDDWs+f5cdsVz2DieE5dofM28JGGYFoeqo0N9-P3YUJg@mail.gmail.com>
Subject: Re: [PATCH for-11.2 7/9] target/kvm: Pass an Error handle to
 kvm_arch_init_vcpu
To: Eric Auger <eric.auger@redhat.com>
Cc: Sebastian Ott <seott@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com, 
 khushit.shah@nutanix.com, richard.henderson@linaro.org, pbonzini@redhat.com, 
 skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 7746591750@163.com, 
 maobibo@loongson.cn, harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8e89a6c665..5d72cbd9fc 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -493,9 +493,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
> /* Synchronize sregs with kvm */
> ret = kvm_arch_sync_sregs(cpu);
> if (ret) {
> + error_setg_errno(errp, -ret, "Register sync failed"),

               ^ typo here and

> @@ -504,6 +505,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
> case POWERPC_MMU_BOOKE206:
> /* This target supports access to KVM's guest TLB */
> ret = kvm_booke206_tlb_init(cpu);
> + if (ret < 0) {
> + error_setg_errno(errp, -ret, "failed kvm_booke206_tlb_init"),

                             ^ here


Thanks,
Faiz


