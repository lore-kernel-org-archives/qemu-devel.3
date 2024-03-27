Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494DAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPYZ-0003Wm-2L; Wed, 27 Mar 2024 05:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpPYX-0003W7-7w
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpPYV-00057q-QC
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711531606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VPVDIkp9/3tA4qye46xHYmjVVtKOF6nTCZMtRlJAN1g=;
 b=Lci9u6WMLkr1XsUib69IseHPCd4vlbR+rz5cPfPYO7isP/DB2QkGYaJKWriXrRlOYdI007
 p+yLQTCvqdtb1JQrkVTQO7qQzDEuLWtFGP+k82N/4ZZR/k9vRSJwZCc2T6IX85jSJ/Gl59
 z6Whoels1CZUqwQwc/JWIfq86KSkt/Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-4QgEW2J1MBO_kRi_BciZEg-1; Wed, 27 Mar 2024 05:26:44 -0400
X-MC-Unique: 4QgEW2J1MBO_kRi_BciZEg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4488afb812so336051966b.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531603; x=1712136403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPVDIkp9/3tA4qye46xHYmjVVtKOF6nTCZMtRlJAN1g=;
 b=qikGi2OeOvZcsWWuTWV7nXMrExvFgXHhaTDGXup1IGpEyxnforVOnwIAY1c9FJ1srK
 4ddq7Sxjij5NK2DwwvKxlDiTCU+gIpl3cMYH2Pac11WiJbgqyrABE8vHeKb47Ppd6jHp
 2dBvW//LaP8NroG+Q6NcnCj2bWWh06wJIKyeLEwrqSt2tzOzl2H2B0jpy2oLlxHIf8b3
 fcwcYohXFuCTJEVYnesA225ZDieAFBu9MvM/S3XliubkY8vovr7LcXpDjuwGOnFlIVdV
 c1VZa1jfzKrCnFEHWyICAzB0OqeagxB7Q3vUNpOQ9vq5z9B0028qIcTrtk5j9QBKjv8C
 LOjQ==
X-Gm-Message-State: AOJu0YwE3LayMI5OI6N4rIDznhAsnBgVISgkG3WF9vN4DNaj89j/Qmrr
 YDII8PqSJ5PretOdFq5HoOuv4sAc0MbvZI2KM09aUGTWTjoiJOnvWwld6GHWXoawrMEr7m7d5PJ
 gSmdb2BMXtwJl6hCFYnoiq/VwyvmFUegJrkWELdZNrDNgWmXCxXXz
X-Received: by 2002:a50:875c:0:b0:56a:fbe9:80a4 with SMTP id
 28-20020a50875c000000b0056afbe980a4mr2440758edv.1.1711531603315; 
 Wed, 27 Mar 2024 02:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIxRPCIAAda0LG+rg7IwgXblAXQ4wl/sC3pyHjXxI2CPbQQs5bcFS3PUBYFE3xMiYwsv/dJA==
X-Received: by 2002:a50:875c:0:b0:56a:fbe9:80a4 with SMTP id
 28-20020a50875c000000b0056afbe980a4mr2440737edv.1.1711531602941; 
 Wed, 27 Mar 2024 02:26:42 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 g17-20020a056402091100b0056c0cec810bsm3413222edz.85.2024.03.27.02.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:26:39 -0700 (PDT)
Date: Wed, 27 Mar 2024 10:26:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, 
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 02/11] libvhost-user: fail vu_message_write()
 if sendmsg() is failing
Message-ID: <vmtkxdspr4zsd25knoxw3zxufyyne5cxtl3vcymlfqew7iiska@yvnzplsqnxw5>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-3-sgarzare@redhat.com>
 <ubrm3znnvrpwoiwoekvztbcga2r37folr6cjjcasfaarc2pwek@pz66newnog3a>
 <348b5359-a683-486e-bf69-f1d5f0a95d56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <348b5359-a683-486e-bf69-f1d5f0a95d56@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 03:36:52PM +0100, David Hildenbrand wrote:
>On 26.03.24 15:34, Eric Blake wrote:
>>On Tue, Mar 26, 2024 at 02:39:27PM +0100, Stefano Garzarella wrote:
>>>In vu_message_write() we use sendmsg() to send the message header,
>>>then a write() to send the payload.
>>>
>>>If sendmsg() fails we should avoid sending the payload, since we
>>>were unable to send the header.
>>>
>>>Discovered before fixing the issue with the previous patch, where
>>>sendmsg() failed on macOS due to wrong parameters, but the frontend
>>>still sent the payload which the backend incorrectly interpreted
>>>as a wrong header.
>>>
>>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>---
>>>  subprojects/libvhost-user/libvhost-user.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>>diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>>>index 22bea0c775..a11afd1960 100644
>>>--- a/subprojects/libvhost-user/libvhost-user.c
>>>+++ b/subprojects/libvhost-user/libvhost-user.c
>>>@@ -639,6 +639,11 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>>>          rc = sendmsg(conn_fd, &msg, 0);
>>>      } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>>+    if (rc <= 0) {
>>
>>Is rejecting a 0 return value correct?  Technically, a 0 return means
>>a successful write of 0 bytes - but then again, it is unwise to
>>attempt to send an fd or other auxilliary ddata without at least one
>>regular byte, so we should not be attempting a write of 0 bytes.  So I
>>guess this one is okay, although I might have used < instead of <=.

I blindly copied what they already do at the end of the same function.
However, your observation is correct. That said they have a sendmsg()
to send the header. After this we have a write() loop to send the
payload.

Now if sendmsg() returns 0, but we have not sent all the header, what
should we do? Try sendmsg() again? For how many times?

>
>I was wondering if we could see some partial sendmsg()/write 
>succeeding. Meaning, we transferred some bytes but not all, and we'd 
>actually need to loop ...

Yep, true, but I would fix it in another patch/series if you agree.

Thanks,
Stefano


