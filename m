Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E00D4334A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90ju-0004lx-PZ; Thu, 07 Nov 2024 06:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t90jf-0004lf-Bb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:31:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t90jb-0006OX-0n
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730979088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/S/yeBXuKuI/7xdRezFYAX+vIpRA99D9asvIdnxFp7Y=;
 b=NbbzDWhPCHVnGitID/n+p7nTpIWj91uP1PyDucDeUG1xSu1Dyprh3gzm1yWVqW6ZsU7Lju
 kGjOY6Ebx+8whnfsnJ1XE5Llvcv/DEdylQtzQy9p6vK2OQzP8QokI1nxsCMwB8fG2L7tIw
 HFxy9/uz7v/pLIcGW/wXNEFkE1GCfRo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-iUDJTXi5P_ukGPzdP9e63Q-1; Thu, 07 Nov 2024 06:31:26 -0500
X-MC-Unique: iUDJTXi5P_ukGPzdP9e63Q-1
X-Mimecast-MFC-AGG-ID: iUDJTXi5P_ukGPzdP9e63Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso6068595e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730979085; x=1731583885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/S/yeBXuKuI/7xdRezFYAX+vIpRA99D9asvIdnxFp7Y=;
 b=Un400H9ztjqbfmkZ3vqUSnaO2aXkOQYOd0FVLS22rqTPOOFiCY+s8NRs0bT6Tu0Voc
 OkV2x63OAC3iXMneZAhR72guINqZjJf8mu4UxqVUGO3LxLNrotx92UJ4gXKBXQ28fBsl
 uJ4B//htUABWFMBMUSU+XXpOW6MFZbYma7Y1r8dx4aHRxPVFAjj1Dr4sRe/GGYyE0BdO
 JKcKtML9OpU/h1ya9/KOq4so1vD7qvNhfmgbeiCJMVzElutBjA9lBfoE1wh8WrW5Gfia
 cipq5vuc16IG08oQWJy+Xtog1OzILBzT8KusLOqQGyvSbAxzX+onf/GB85blGPoOVcre
 MZYg==
X-Gm-Message-State: AOJu0YzGTZgcI9/6XfUQE7q5CO4fzwKTNerYPrhQbssG6J/8Jhcps4sg
 ImekxxzlZtTednNhgcRz8QYBs1Bl/bbnb7dVoCdgRqF9hGgAHtjBBSpfotr3h8Pbk59J0TvlDpt
 qwRZtsomEUOGnm0/qQ1RWshmcvr1UQjN17+SoaAHc/nCieQki+VafLzn5K5Bib4GE10hVNHhzdw
 gO/6o1NzAnZpm5+h43JxRNyetogD0=
X-Received: by 2002:a5d:59a8:0:b0:37d:2edd:b731 with SMTP id
 ffacd0b85a97d-381c7a6cc78mr20982772f8f.30.1730979085657; 
 Thu, 07 Nov 2024 03:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ3ykrtmd3yaiRUFlcOKj48FXSZ5chTm2Q5NZvuLtISQ5pd0bZkLV+H9slmI9qm2OUUYNrSJruwTfOiHoynx4=
X-Received: by 2002:a5d:59a8:0:b0:37d:2edd:b731 with SMTP id
 ffacd0b85a97d-381c7a6cc78mr20982748f8f.30.1730979085297; Thu, 07 Nov 2024
 03:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <20241104172721.180255-33-pbonzini@redhat.com>
 <mkvxc.kptyckk1ksc@linaro.org>
In-Reply-To: <mkvxc.kptyckk1ksc@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Nov 2024 12:31:06 +0100
Message-ID: <CABgObfbdGz7gqbej1J0iN2GDgbHf9WhmvnfwfSik60AUJcyXRg@mail.gmail.com>
Subject: Re: [PULL 32/40] rust: introduce alternative implementation of
 offset_of!
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Compilation fails for me, on macos / rustc 1.80.1
>
>   error[E0369]: binary operation `==` cannot be applied to type
>     `&Attribute`
>     --> ../rust/qemu-api-macros/src/lib.rs:25:43
>      |
>   25 |     if input.attrs.iter().any(|attr| attr == &expected) {
>      |                                      ---- ^^ --------- &_
>      |                                      |
>      |                                      &Attribute
>
>   error: aborting due to 1 previous error

You need "meson subprojects update --reset" as mentioned in
the cover letter.

Paolo


