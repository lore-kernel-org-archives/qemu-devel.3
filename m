Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4709C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuzJH-0000iG-UC; Wed, 19 Mar 2025 15:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tuzJB-0000ha-Na
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:42:34 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tuzJ8-0001nS-Ls
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:42:32 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3fea67e64caso403b6e.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1742413349; x=1743018149;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMLAFjMhZ4JY7cw6US5xBTrT3XyKZJJMx+r+cPzoszg=;
 b=aXvga1aJxkG9dnO9WvKfumjyu41p6/yg9N1UL7/DY6+ks8YSLvC0Qebd/kh0dIravS
 tnTHOba1p4S9kPJp207BRBDgyQOCdCREKes6xdz8/VK9wyzmM7ow/1uZQfUr3xVWjYjQ
 McH6Xt1AP2WxMj+5+B7sYXgAUjz0QSMZZN8BI6h9WFftek6b18+cgNPyAEkUHYKwI9/E
 3rQ4BhOEyivwVxECKI4G+XF9wjYfMFer/Mior9SzSx+y6XS1e6v9olm/xSfgpjYmBpT/
 Ejndnj2YxvYykZmcN5+1cN1ywoZwej674gQFKkvRHTs/X4OHL+uPwVtf6oIwTphJe+jx
 mpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742413349; x=1743018149;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMLAFjMhZ4JY7cw6US5xBTrT3XyKZJJMx+r+cPzoszg=;
 b=WMCw2jqtDl0R9TLxZN1ea+CAPfxPHviksET+wgkHzSvbrq06kqYben5kolwM/uTANO
 sWmuw6Px/iOBxrRsomkyxMiWXoJytvFg8FPa7nR0iIHlYExBGVPcBMZ6W7aF5p3XAOZs
 ESsbxaEe6i0RVIoXhxxVpxp0u0N28wy9VBsxgfrJiGoOYzXlfWSlBDA3l7Ba2UAe9Peu
 H1eWkQtrPrZSyCnE/HaFWBWlPUkPchINVYS/23cXfJLAo3QHAVcmQWKMbZm/XsN5YS/g
 /YmTa28EgE5Y51xrlr/WlJcLFh239UAR/Mm7aTjxFkWF3qtyY7hA6beb3R8Og8NJR2mn
 KEMw==
X-Gm-Message-State: AOJu0Yx7y71c3+klOlD6zZtF/lzZ38GMPHCDWB2EbVf3c0PxrZn2txTZ
 5oJ2gGn/kgsYpG4ZdRbmUm/lwYvYdCDLp7P6Taytv3b3XC03GHzbYNDFdkxRDIs=
X-Gm-Gg: ASbGnctVEc+xy2axnxJJlSjLNY3TjVoMjcxfLsvL6XI6NjS5Y8HhpkG0tLOtSZtAGDe
 TUaKVrLQOqmXtbHx1MTiALlTsDq5JXutbLYLgBtq7Upn/U+jAKkKe7LfKwz7jYZGpdLA72Bc/QK
 M9PfF8hPuHe7JvIxQWD5eoAR1nEK27d4thld5uvV7XtGWyrvitbX7SXGvQZ5CUsrwsRrrE5omaO
 h1fNcBD/jecN4dDYaXgS9utH6+9jJQt+8P1dK8moyuHevsD/J/U0NoThTxoEHtC19M9aZ8fdqaI
 BMd77+aV8UTqUXyEY9jXmqxeHvdUSR2Py36NGwFXAyouY3W1
X-Google-Smtp-Source: AGHT+IEWuDf3QXDqMWM83lzTFGPh9LARhmOrmxdzcjsVvgS6kr5Y+t/n+6YbYuqC50VWZx6mXYmG1w==
X-Received: by 2002:a05:6808:1822:b0:3f7:d16c:e293 with SMTP id
 5614622812f47-3feb4844a81mr471739b6e.2.1742413348952; 
 Wed, 19 Mar 2025 12:42:28 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:1864:2d48:765f:cbbc])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3fcd60e743esm2750339b6e.46.2025.03.19.12.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:42:27 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:42:21 -0500
From: Corey Minyard <corey@minyard.net>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
Message-ID: <Z9seHbw1IepwkppI@mail.minyard.net>
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
 <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
 <87o6xwkerz.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6xwkerz.fsf@pond.sub.org>
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=corey@minyard.net; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 19, 2025 at 08:21:20PM +0100, Markus Armbruster wrote:
> Corey Minyard <corey@minyard.net> writes:
> 
> > Is this official coding style?  I'm not a big fan of having return
> > statements in the middle of functions, I generally only put them at
> > the beginning or the end.
> 
> There's nothing in docs/devel/style.rst.
> 
> I count more than 42,000 return statements with indentation > 4.  These
> are either within some block, or incorrectly indented.  I'd bet my own
> money that it's the former for pretty much all of them.
> 
> I count less than 130 labels right before a return statement at end of a
> function.
> 
> Based on that, I'd say return in the middle of function is
> overwhelmingly common in our code.
> 

Ok.  It's not a huge deal to me.  I think it's more dangerous to
have returns in the middle; they are easy to miss and an "out:" at the
end make it more clear there are returns in the middle.  But that's
just my opinion.  To make wholesale changes like this I would prefer
it be in the style guide.  But, I don't want to start a holy war,
either.  Sigh.

I mean, just a "return;" at the end of a function, yes, that's a
no-brainer, get rid of it.  But that's not what the ones in the IPMI
device are.

Thanks,

-corey

