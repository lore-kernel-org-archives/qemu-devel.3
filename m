Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544B6C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmhTy-0000cm-MV; Tue, 19 Mar 2024 17:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmhTv-0000Jl-Me
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmhTu-0007T3-0Z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710885525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIk5J7CpQI0UXNcNqudC5xQrfsvmP3CttfdE+h8eye8=;
 b=IygkX4/oB5AJXcEKvL4EuHo0mr32YuVhw5naDtKU51eoDiUJ92pSekRvLvTUVyrb5ngpqZ
 W0/dP1TfsGKQXvUtG8CD8wPcDoK2v0yzc6q6rqfpfWGIZ7iU9a1R+4zmhdMLZAUHKJ9xY9
 FQIBlTZrtHGJUy4q+Ov8361sFxkJ7pI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-IQUvKr3OMumDKM-VT5Hx9g-1; Tue, 19 Mar 2024 17:58:43 -0400
X-MC-Unique: IQUvKr3OMumDKM-VT5Hx9g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7830635331bso164555685a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710885522; x=1711490322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIk5J7CpQI0UXNcNqudC5xQrfsvmP3CttfdE+h8eye8=;
 b=sNiVN4mOxH9BWvs13phJm8aUvctgjFyjfsya6E9JSLN+6byITJfm4+DtNig9OIXXFT
 Ekk0v6enqwBajbNEprbbm9x6vr1arWJZ7EoUYhnqOFBi+D9kzabm+4XLfre+MyHqt4g+
 LcNnvxgg1tLmitXt5O5Ou4YxYAR18dxW2Q8jEihAJscJKoAr7Jcxt/iuqb0Xk2KBAoTK
 8LY8UgZmqD+PQfJbZA/tGCv52H47rMG3lGio3SUFKp/QmWNU/rT0ZsKHtdrF5g5RBOUd
 pjEIzcxwPCFx/aFdz8iXhs97SJbLNrMMw1DyBZeqbYn/38hE5IDsyE6/L/HSZUnbu1G8
 Lg3w==
X-Gm-Message-State: AOJu0YwgchYcaV2zXQB4SaYC/59LtmkowYMxF2/7v8eju0See9Yo29tD
 +j3sjU4djno6PN2Os5XSq3g85h1/RhjqAqvwY/8GDB50AJJ6IFwQ/e3EyHB/GLE44VzzrCXOR7x
 h8DQr98weMYzWNLZs13nPrR+k5ymamej5syURGfe8JaSHcNbR8Pah
X-Received: by 2002:a05:620a:29d6:b0:789:f544:bfc2 with SMTP id
 s22-20020a05620a29d600b00789f544bfc2mr12835qkp.0.1710885522300; 
 Tue, 19 Mar 2024 14:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjCrPpD7F1gsBokZ+mSbPiATSjr08VtxyR0ZhraKdX36D6tREf4Y1aMyP5994EsWeUY7JcUg==
X-Received: by 2002:a05:620a:29d6:b0:789:f544:bfc2 with SMTP id
 s22-20020a05620a29d600b00789f544bfc2mr12822qkp.0.1710885521834; 
 Tue, 19 Mar 2024 14:58:41 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 m26-20020a05620a221a00b00788481cdf4csm5909373qkh.111.2024.03.19.14.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:58:41 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:58:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Revert mapped-ram multifd support to fd: URI
Message-ID: <ZfoKigb85ul-gju5@x1n>
References: <20240319210941.1907-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319210941.1907-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 06:09:41PM -0300, Fabiano Rosas wrote:
> This reverts commit decdc76772c453ff1444612e910caa0d45cd8eac in full
> and also the relevant migration-tests from
> 7a09f092834641b7a793d50a3a261073bbb404a6.
> 
> After the addition of the new QAPI-based migration address API in 8.2
> we've been converting an "fd:" URI into a SocketAddress, missing the
> fact that the "fd:" syntax could also be used for a plain file instead
> of a socket. This is a problem because the SocketAddress is part of
> the API, so we're effectively asking users to create a "socket"
> channel to pass in a plain file.
> 
> The easiest way to fix this situation is to deprecate the usage of
> both SocketAddress and "fd:" when used with a plain file for
> migration. Since this has been possible since 8.2, we can wait until
> 9.1 to deprecate it.
> 
> For 9.0, however, we should avoid adding further support to migration
> to a plain file using the old "fd:" syntax or the new SocketAddress
> API, and instead require the usage of either the old-style "file:" URI
> or the FileMigrationArgs::filename field of the new API with the
> "/dev/fdset/NN" syntax, both of which are already supported.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

queued for 9.0-rc1.

-- 
Peter Xu


