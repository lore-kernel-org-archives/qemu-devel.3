Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C0C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXN45-0001SD-NU; Tue, 06 Feb 2024 10:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN42-0001Qz-5J
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN40-0003gc-N6
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/b/FDMJZ3jJrf/ShQUnL+j7wLrs+1R9slp3vM/k2xcs=;
 b=QqLH+0Vg5ow3n0ggMBNvc6Tg/IxhUNk6KXqlYXY+0UBKrMztgY7yQMv2lQqQjuH7uq9v43
 Q8X9c7ybFFhTuTs0/BBisIqUWboh4pzQqlQwSK9ILv93HctnGcxVIPcyPsxhs86icz92sn
 ZGhil0DEvq53LOzEKd5/xzAckVCPZKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518--FJRsqWJMai7v4osraDN4Q-1; Tue, 06 Feb 2024 10:08:42 -0500
X-MC-Unique: -FJRsqWJMai7v4osraDN4Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33b16845d12so2397741f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232120; x=1707836920;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/b/FDMJZ3jJrf/ShQUnL+j7wLrs+1R9slp3vM/k2xcs=;
 b=KBBnEaP0d6sC7e4sEx8Ar+9YWGCxrqCQdOuOelCr4AYbTO//fgxh73Ef9YmEjr+BsF
 P5yiUpLtPgrKZVpjA4nRuTcPsV4nn7X12zXfz7phbBpNws/mQH+f9bySfJH6d/1LhKeP
 dtOHn1Z3lFWtn67adWHvRflQ+aGi9pwXHHRBMl0x2BO2X0KevyZjHILLpS8g3fJyX0Et
 UjtCFz8segc4ohp9FELJjWi7PA76Sc9dWwKmv7WtiwSeHylN0f28Vk2w4sd5WhJp5aV9
 fQ0jaCSKwafHafLvEqrW7iCrDxph038ljZ3yeujkFkkA8H2ra95cvf8LJLk6gZvlvz9R
 HfVg==
X-Gm-Message-State: AOJu0YycmftdGnZ0HL7UE72Q+6qI/JTN8BMyy7aTvqKYILQAdq3yUdMd
 mkIIolctnlmY5ZL9dRXa3wyEwJTV8BoAAJSlf2OxJghU194nSZgbwc7Bg3Oo5vMX8Yf+sEvsY3E
 yFV0yYmG4NPWRnEjvAldLomi7Ye4IC8nhueU4IyL9W/5OH48fo1PUyrbVuZPE
X-Received: by 2002:a5d:4d90:0:b0:33b:13e9:35c5 with SMTP id
 b16-20020a5d4d90000000b0033b13e935c5mr1551999wru.67.1707232120602; 
 Tue, 06 Feb 2024 07:08:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQmUcuN0hqfwLlTa+D3SJbC78PjvOQ9TatOC33D3p9QLUgGu7uvGvt6kQciDSRpMBU9Ls3DA==
X-Received: by 2002:a5d:4d90:0:b0:33b:13e9:35c5 with SMTP id
 b16-20020a5d4d90000000b0033b13e935c5mr1551990wru.67.1707232120408; 
 Tue, 06 Feb 2024 07:08:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUNhvAkyEJhBNbLKqcn5NvSDCFWt5MF13Gv99WdtXcfehdq/4rWk0dt5ycJYpf0OWtQ0uq3FMLqS04g8womkdTuKNOIDlEuPN5Ej4RdWQDeK+zC6L/BCBrI5W75BJ1ZVisJdS4RYX9pz1x2oMeYWZDYO5Zwdgpul2Ti4GBRBH3odaJmjAIoNZ0UUGb0O6BUdpfPCWoBgQ==
Received: from ?IPV6:2003:cf:d740:65ef:7c9f:a118:b826:ff5f?
 (p200300cfd74065ef7c9fa118b826ff5f.dip0.t-ipconnect.de.
 [2003:cf:d740:65ef:7c9f:a118:b826:ff5f])
 by smtp.gmail.com with ESMTPSA id
 cp10-20020a056000400a00b0033b4a2f13e6sm969398wrb.72.2024.02.06.07.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:08:39 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------5sVzM0pjZlve0XfL7lgOMQIx"
Message-ID: <fdbc6102-1b9c-4566-9839-092bf48ba6f9@redhat.com>
Date: Tue, 6 Feb 2024 16:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] virtio-blk: clarify that there is at least 1 virtqueue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-3-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240205172659.476970-3-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------5sVzM0pjZlve0XfL7lgOMQIx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.02.24 18:26, Stefan Hajnoczi wrote:
> It is not possible to instantiate a virtio-blk device with 0 virtqueues.
> The following check is located in ->realize():
>
>    if (!conf->num_queues) {
>        error_setg(errp, "num-queues property must be larger than 0");
>        return;
>    }
>
> Later on we access s->vq_aio_context[0] under the assumption that there
> is as least one virtqueue. Hanna Czenczek<hreitz@redhat.com>  noted that
> it would help to show that the array index is already valid.
>
> Add an assertion to document that s->vq_aio_context[0] is always
> safe...and catch future code changes that break this assumption.
>
> Suggested-by: Hanna Czenczek<hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> ---
>   hw/block/virtio-blk.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
--------------5sVzM0pjZlve0XfL7lgOMQIx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 05.02.24 18:26, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240205172659.476970-3-stefanha@redhat.com">
      <pre class="moz-quote-pre" wrap="">It is not possible to instantiate a virtio-blk device with 0 virtqueues.
The following check is located in -&gt;realize():

  if (!conf-&gt;num_queues) {
      error_setg(errp, "num-queues property must be larger than 0");
      return;
  }

Later on we access s-&gt;vq_aio_context[0] under the assumption that there
is as least one virtqueue. Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a> noted that
it would help to show that the array index is already valid.

Add an assertion to document that s-&gt;vq_aio_context[0] is always
safe...and catch future code changes that break this assumption.

Suggested-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a>
Signed-off-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)
</pre>
    </blockquote>
    <br>
    Reviewed-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a><br>
  </body>
</html>

--------------5sVzM0pjZlve0XfL7lgOMQIx--


