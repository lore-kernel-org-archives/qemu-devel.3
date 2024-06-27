Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F2C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqaT-0005Fl-QT; Thu, 27 Jun 2024 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqaS-0005Fb-7o
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqaQ-0007x4-Oq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJIiXou2WC1h/6NtoN4na0fAAoVg8BIMwhAGqxz6KDw=;
 b=MfnCRsutPqqj+yeof9eooXhCbOJSLsJYPDsgqRlZEJi/MPA3eI/k+tOKcco7l7IKoDoLW8
 l1yopMx+Err2Nc+2JByekNPhg7GO+X3roSKyHMUetScZCdM4R+PnJG4+p4Uk1vNMYJck6e
 AAgbXYbVK4p5+WI8BZa9PSGjnFkLz3E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-sM8S6k7FOpWb9jF81R6m9A-1; Thu, 27 Jun 2024 10:58:56 -0400
X-MC-Unique: sM8S6k7FOpWb9jF81R6m9A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3636413fcc5so4444200f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500335; x=1720105135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJIiXou2WC1h/6NtoN4na0fAAoVg8BIMwhAGqxz6KDw=;
 b=Wt9TL+fjKzI871Dpm3Jw9ASWjSS9+6b00MCauWdZzU/Z3sg4HtBwwUyjuFxc7yhKW2
 fwOfqBriTiR63+LYLB+dSl/M2iRETn9+Jy/zMbw9l/cuQ3MMxAm+bbsqP7/Ou95Ozyzh
 57kDf+dAtEM57Fy6XkFHWney7oHJ2RgZJrx1wDBE4lSVJnzE/DD3EU+FH42ga6CPaA8l
 CB5k8QnNY6x3DEH7YDjulKyGEHECPsXRZStE3nyrspLfq1lZ+SNkcxF1okO29SxtWC/f
 N7NW77u7fpTcs9HIlmpWEWbGfKxORxaLG5mqPtnLcglK9qZP2pZbJoQA87k+i6bjrGlV
 NkVA==
X-Gm-Message-State: AOJu0YzeMSL/wBqNKV3lwpw+WdC6e69phLkna2SgYQRhOZqrfSN4472e
 jdBSbUD8RjtdME6ZlHEa3Ux/rkVp+VRCOiMT7AYN4FQVWxh7tXFSU6N3pdSR0jEKTb+BvsnUzLE
 nqWWV0ozKi5WRLj8+Oq8EuEdeHWc6pq5PgtPliPI2KVqj03elOrujJmAwN2ac2tYHyvprQIzgop
 ZEhnnwIXbRxq8P4pDSiJkUGlTfWs0=
X-Received: by 2002:a05:6000:174e:b0:367:40b9:e9e6 with SMTP id
 ffacd0b85a97d-36740b9eademr1282028f8f.21.1719500335269; 
 Thu, 27 Jun 2024 07:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIUkpr46xArNlQKWQOHNNNALoNwA7G1y0YbZRE/w1YMM6FK3xjjjCNafydyWg5w+1y8hFSfDva6EqNSzJV0ZA=
X-Received: by 2002:a05:6000:174e:b0:367:40b9:e9e6 with SMTP id
 ffacd0b85a97d-36740b9eademr1282015f8f.21.1719500334908; Thu, 27 Jun 2024
 07:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240626194950.1725800-1-richard.henderson@linaro.org>
In-Reply-To: <20240626194950.1725800-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Jun 2024 16:58:42 +0200
Message-ID: <CABgObfZpYUw+5ChkFaqM0X2OX6yeYWhQT50GdeLbnLJh9PTJNw@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/i386/sev: Fix 32-bit host build issues
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, berrange@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 26, 2024 at 9:49=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> I separated the fixes into 3 smaller patches
> that may be easier to review.

Oops, I missed this. I queued patches 2-3, while for the first one I
prefer the version I sent at

https://lore.kernel.org/qemu-devel/20240627145357.1038664-1-pbonzini@redhat=
.com/

(patches 1-4)

Paolo

> r~
>
> Richard Henderson (3):
>   target/i386/sev: Cast id_auth_uaddr through uintptr_t
>   target/i386/sev: Use size_t for object sizes
>   target/i386/sev: Fix printf formats
>
>  target/i386/sev.c        | 41 ++++++++++++++++++++++------------------
>  target/i386/trace-events |  2 +-
>  2 files changed, 24 insertions(+), 19 deletions(-)
>
> --
> 2.34.1
>


