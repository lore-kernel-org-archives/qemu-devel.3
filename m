Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01DC27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 16:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFFiJ-0001Ud-Lr; Thu, 06 Jun 2024 12:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFFiG-0001Tz-25
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFFiB-0004Fk-6Q
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717690287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/MKdQ7Kq81MTOYH+B5yFZauESmZiedcsicOVI2sBeA=;
 b=FQw/V5LkwYeQfew2E4rh9Mq8aWCDZ2ISAfX5UeT7JjHnjTvzO9gx3u9DxsSnbXIfkx6th8
 3LKCmrR6TQ+S3L//cYc7eZya4CGakdARKIRpp6bg/c0dK3+vk0T43c6jF50CmgvuumL4FY
 9TnF3Cf24shS6/KntVF5w27/wv5mHvE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-lCLpupfUOHqg-f92DdlAfg-1; Thu, 06 Jun 2024 12:11:01 -0400
X-MC-Unique: lCLpupfUOHqg-f92DdlAfg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dcb574515so807026f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 09:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717690254; x=1718295054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/MKdQ7Kq81MTOYH+B5yFZauESmZiedcsicOVI2sBeA=;
 b=hFDWEqJmzAOYnGjE7q707wZD3ZSHvCe0LPdyAFFl+RxcV/YaycUPp2MycUeibDeTBp
 ZI4TPaiQwBbjPh6tg7TWopgaCyLOor+F8Bco/B2LeesJ2Z2WNOXuPUSAPNHodins3YhK
 t/lvwWs0lw8MLTeQcoo/B3DkumtKQj6hOznJtAGh6qHPz3MHy4cMnbg0HCZqNpKClunJ
 afH0ImWXVdOg3vFpKnrC9IPUFzc3BqKIhW2Jl3IH8faVgI5UZrN4tPAmPHnORV0oEa57
 1t2e7YRYrQgv1274nbjzMa1p1TJYRk1dnQnNfQI2QTe46PxUMYVWlMusOLdBH/PcwTh/
 bvPQ==
X-Gm-Message-State: AOJu0YxhTcI1WctRCUgeBFipZBNAcCRbxPe9slzcWRkfAheF7rpd3KHg
 QMkC8vw+ifJEeGha4Ya00puV+1GKFqbegv2492GRRrqe2rW147QCI/MzowJpPkjjUihF9h+UH7h
 4rkeKNFhMRGvS8ZBQRDbSUaaWLVhiPobs1rlHzwNvPoH34Cm5EAYy/wplTjXvpxuKT/r5/IeCRc
 pawwXrHXVlgN9Vq36fdNPSuGPJu0o=
X-Received: by 2002:a5d:6901:0:b0:35e:4f42:6016 with SMTP id
 ffacd0b85a97d-35efed6573cmr62163f8f.30.1717690254248; 
 Thu, 06 Jun 2024 09:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9CFaX1jycpHioAFWCoJFanse4Z3fgHvIegQh1sc8iyJvKIEx0F1fOySeQZFlUZcO606gLfrrLy7smx3wa9u8=
X-Received: by 2002:a5d:6901:0:b0:35e:4f42:6016 with SMTP id
 ffacd0b85a97d-35efed6573cmr62154f8f.30.1717690253918; Thu, 06 Jun 2024
 09:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240605224409.2103109-1-pbonzini@redhat.com>
 <ae827bce-41d7-450c-8fe8-69df55430bd0@intel.com>
In-Reply-To: <ae827bce-41d7-450c-8fe8-69df55430bd0@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Jun 2024 18:10:40 +0200
Message-ID: <CABgObfYoKTURRorC_33qFC-SFxx9zvgqe0hLeQD2yLn8hApp5w@mail.gmail.com>
Subject: Re: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pankaj.gupta@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 6, 2024 at 6:07=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> wr=
ote:
>
> On 6/6/2024 6:44 AM, Paolo Bonzini wrote:
> > There can be other confidential computing classes that are not derived
> > from sev-common.  Avoid aborting when encountering them.
>
> I hit it today when rebasing TDX patches to latest QEMU master, which
> has the SEV-SNP series merged. (I didn't get time to review it between
> it gets merged.)
>
> my approach is to guard with sev_enabled() when calling
> sev_es_set_reset_vector() in kvm_arch_reset_vcpu(), because calling sev*
> specific function in generic kvm code doesn't look reasonable to me.

On the other hand I would like to avoid too many sev/tdx conditionals
in common code.  Neither choice is great.

Another possibility is to make this a X86ConfidentialGuest method, if
the TDX code has anything similar.

Feel free to keep this patch, or anything that replaces it, in your TDX ser=
ies.

Apart from this issue, I could rebase the previous TDX patches on top
of SEV-SNP without any problems.

Paolo


