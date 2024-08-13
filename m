Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B5C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdsOR-0002A5-Gt; Tue, 13 Aug 2024 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdsOI-00027D-C6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdsO8-00046H-Q9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723558836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRYX8b16a4JPih5uUSREPJrhPNRMzaz9YiqhpUbewx8=;
 b=SSayTOuYn/EHE2eoamveK/QqFBhzPzI1NpbYkxCQkCQX2nQ45qfS+NJJr6N1s6yBW21amk
 CcnqFtAie8z6+mNfHXFow7hYp5rTtDqgZXjxm6PByL69imBDqLmMCf0Qr4wdlK8DIIm41w
 K0AWJ5uE3i8Pjdi+fqlHQopOHAh8pk4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-xYk4-gp_O0GelPuffhgv_g-1; Tue, 13 Aug 2024 10:20:34 -0400
X-MC-Unique: xYk4-gp_O0GelPuffhgv_g-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5d5c8a8a3a5so622306eaf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 07:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723558833; x=1724163633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRYX8b16a4JPih5uUSREPJrhPNRMzaz9YiqhpUbewx8=;
 b=hR99emOAUtWNRKaD10lKm8TkZTOrHTP4t6Y5VoTQ12j2VJO9MHrOcbj9GIH+9oWvp3
 7SCR++fV9La6Jw1GHKLZEbGSwWqxOrTASXCZHdtK5oJI9tQ3kbzyRgwJ4xo3r0MG1ZR2
 TYK3PMtH/80QhJfi/uijYIf+kWMoLQRfBJdgoZUTzmYgrwWV/aPkk2MSiaB9dz6rWeps
 5xOs4nUWAy7AJ9CKT+iwVmUEjUdG3V9zNnhZDZP9H4w3+Utm18vutMqGAzuoXZT9yUPv
 W33+sH4QKQJne//5yrMCstFjruyHojSo3KwqiE69HYmLwfxsQO5R1xoa9yNZntEj82lc
 ai1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUZjW4I+GbnHEOMP9+odJxjMKJjfOw7MZ3+CgjiwdCt0iCbbjmpR3dNlBNc7FK04D57LWJzTSbRfDtfAvxIQyeXk3Mse8=
X-Gm-Message-State: AOJu0YzOlAGMhOyqZ1wRXDiUxAdOM6O+DJ7XkuEUzqUuuH/b9BSVR4P9
 d4iR0WL6hzoZKcJJHjT7iqWPTKz5Xc4mnqPCz8jhvYcAxmuDomYDFnijEk8s5ceyz3BN/+a91z8
 D/z88Nyr6LfzCGCW707LeJl10cf8YrREG7gBXQnN6CEliU7iWfrm6
X-Received: by 2002:a4a:db64:0:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5da6e58012cmr1432784eaf.1.1723558832865; 
 Tue, 13 Aug 2024 07:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOZ/C5eqIaA5puLR0Nvh8DgchqVk3ZK9sJB9BCw75E5aNG5Ph++cM1cdF1atOP9RRERydIbQ==
X-Received: by 2002:a4a:db64:0:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5da6e58012cmr1432758eaf.1.1723558832575; 
 Tue, 13 Aug 2024 07:20:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82cac7cfsm34403586d6.74.2024.08.13.07.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 07:20:31 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:20:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH-for-9.1] docs: Fix some typos (found by typos) and
 grammar issues
Message-ID: <ZrtrrUIGNIXPGJOC@x1n>
References: <20240813125638.395461-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813125638.395461-1-sw@weilnetz.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 13, 2024 at 02:56:38PM +0200, Stefan Weil via wrote:
> Fix the misspellings of "overriden" also in code comments.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


