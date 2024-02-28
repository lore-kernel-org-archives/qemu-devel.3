Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA181C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMWz-0000Nx-Kj; Wed, 28 Feb 2024 11:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfMWy-0000La-1j
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfMWv-0002C6-0F
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709136695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9KgIzWVKLUPtCKW2lL5jEJLrGFiAk3Z9LoWrAWDwn/8=;
 b=cnVj2UMfK/KzZO65fkpzvuhg4vJxtlFEeE+q1sGZ54OJTN+evdtopreh+6+MjYwjbiEjRE
 tsuTSk7CFjvMB4v1lMz05FMotWW+id4LnTAvKwXOXecZpjwiFAfHSjExEt0NetFM3DqtnB
 oMBFnITsUKWVYJ7rSMDwIxCVJJhTePU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Md9AHCk8PrO-4-dkhfAZPA-1; Wed, 28 Feb 2024 11:11:33 -0500
X-MC-Unique: Md9AHCk8PrO-4-dkhfAZPA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a440b057909so43594266b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 08:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709136692; x=1709741492;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9KgIzWVKLUPtCKW2lL5jEJLrGFiAk3Z9LoWrAWDwn/8=;
 b=ZSZW4ZPHmqJaLwd2M2zYz0xGKZtdbaY2hKWvgQINesMLk/BtziW5Trc5ptcQuvRUs0
 rZaH0N+3dIggufxq3I8NW499lER2Sxn6FsomXgqc6rnCTQiQQuKQ+0XtPHhgH4FMyG5r
 1jjX77cVXvZOJ+lH8mRWlFmiAnHZzLtd5mdAR/8bXe+Zz+ZaXW2BZMCWCYES8jjtkUNR
 W5dE1YLyY8uYn1uWPUmRWBWpkkHuUOrzf9EQ1dgbdjhsUtH+60bmoZcZVP23IYWkIb5L
 fR7mvL5g20MLvgdKVdmRn7Gnz1mNOJg+E7N0Nsqx+20+xatZGxWVvGhTo06+uDiBF385
 IDDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVec0ItHgaR0cHx8XGch2BlpTJtxsA1pe/pK/TyifBZqn0Vax1pqH452zp/DZ3C/EH1bQSIzDmnD+gjWMhvwOC2K3lGf+4=
X-Gm-Message-State: AOJu0Yzec48SE+0pbT4z1PNK8NO/2TFgemziLPEQOySSzz34bMbcs+SB
 7udMATtkp1rSocUzxPah7L5uPlQ05xAA+VBAxUaAP8/00zzouSRrmD/8oXb8fxMYQkmhmSdVDdk
 ayUdPhU+G+OMQIA5mZij3+DQaHCH8wqwcEl8kM5MPp+Gc/INlqBEE
X-Received: by 2002:a17:906:d8b5:b0:a3e:39f7:52b4 with SMTP id
 qc21-20020a170906d8b500b00a3e39f752b4mr104488ejb.49.1709136692323; 
 Wed, 28 Feb 2024 08:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJnzv3yG1Ahegj47K5g4nxLjIIE+ctiw0REAlJl/1KZpNf+2tVjxjCY6fZ+JXCvaWa1cEK8g==
X-Received: by 2002:a17:906:d8b5:b0:a3e:39f7:52b4 with SMTP id
 qc21-20020a170906d8b500b00a3e39f752b4mr104477ejb.49.1709136692011; 
 Wed, 28 Feb 2024 08:11:32 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 cu16-20020a170906ba9000b00a43aa6e3f4bsm1861731ejd.44.2024.02.28.08.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 08:11:31 -0800 (PST)
Message-ID: <52b2ff32-ed28-48a4-b6f3-6c981e84cea1@redhat.com>
Date: Wed, 28 Feb 2024 17:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io/channel-tls: fix handling of bigger read buffers
Content-Language: en-US
To: antoine.damhet@shadow.tech, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Charles Frey <charles.frey@shadow.tech>
Cc: vm@shadow.tech
References: <20221115142329.92524-1-antoine.damhet@shadow.tech>
 <20221115142329.92524-3-antoine.damhet@shadow.tech>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20221115142329.92524-3-antoine.damhet@shadow.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On 15/11/2022 15.23, antoine.damhet@shadow.tech wrote:
> From: Antoine Damhet <antoine.damhet@shadow.tech>
> 
> Since the TLS backend can read more data from the underlying QIOChannel
> we introduce a minimal child GSource to notify if we still have more
> data available to be read.
> 
> Signed-off-by: Antoine Damhet <antoine.damhet@shadow.tech>
> Signed-off-by: Charles Frey <charles.frey@shadow.tech>
> ---
>   io/channel-tls.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 65 insertions(+), 1 deletion(-)

  Hi Antoine, Charles and Daniel!

This patch can cause a crash with character devices in QEMU that check for a 
valid amount of data that should be written to it, like e.g. the sclpconsole 
of qemu-system-s390x. And I guess other character devices are affected, too, 
in the sense that they are dropping characters silently.

The problem can be reproduced like this:

1) In one terminal, do this:

mkdir qemu-pki
cd qemu-pki
openssl genrsa 2048 > ca-key.pem
openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem
# enter some dummy value for the cert
openssl genrsa 2048 > server-key.pem
openssl req -new -x509 -nodes -days 365000 -key server-key.pem \
  -out server-cert.pem
# enter some other dummy values for the cert

gnutls-serv --echo --x509cafile ca-cert.pem --x509keyfile server-key.pem \
             --x509certfile server-cert.pem -p 8338

2) In another terminal, do this:

wget 
https://download.fedoraproject.org/pub/fedora-secondary/releases/39/Cloud/s390x/images/Fedora-Cloud-Base-39-1.5.s390x.qcow2

qemu-system-s390x -nographic -nodefaults \
   -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2 \
   -object 
tls-creds-x509,id=tls0,endpoint=client,verify-peer=false,dir=$PWD/qemu-pki \
   -chardev socket,id=tls_chardev,host=localhost,port=8338,tls-creds=tls0 \
   -device sclpconsole,chardev=tls_chardev,id=tls_serial

QEMU then aborts after a second or two with:

qemu-system-s390x: ../../devel/qemu/hw/char/sclpconsole.c:73: chr_read: 
Assertion `size <= SIZE_BUFFER_VT220 - scon->iov_data_len' failed.
Aborted (core dumped)

It looks like the second read does not trigger the chr_can_read() function 
to be called before the read, which should normally always be done before 
sending bytes to a character device to see how much it can handle. ... do 
you maybe have any ideas how to fix this?

  Thanks,
   Thomas


> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 4ce890a538..4f2b8828f9 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -388,12 +388,76 @@ static void qio_channel_tls_set_aio_fd_handler(QIOChannel *ioc,
>       qio_channel_set_aio_fd_handler(tioc->master, ctx, io_read, io_write, opaque);
>   }
>   
> +typedef struct QIOChannelTLSSource QIOChannelTLSSource;
> +struct QIOChannelTLSSource {
> +    GSource parent;
> +    QIOChannelTLS *tioc;
> +};
> +
> +static gboolean
> +qio_channel_tls_source_check(GSource *source)
> +{
> +    QIOChannelTLSSource *tsource = (QIOChannelTLSSource *)source;
> +
> +    return qcrypto_tls_session_check_pending(tsource->tioc->session) > 0;
> +}
> +
> +static gboolean
> +qio_channel_tls_source_prepare(GSource *source, gint *timeout)
> +{
> +    *timeout = -1;
> +    return qio_channel_tls_source_check(source);
> +}
> +
> +static gboolean
> +qio_channel_tls_source_dispatch(GSource *source, GSourceFunc callback,
> +                                gpointer user_data)
> +{
> +    return G_SOURCE_CONTINUE;
> +}
> +
> +static void
> +qio_channel_tls_source_finalize(GSource *source)
> +{
> +    QIOChannelTLSSource *tsource = (QIOChannelTLSSource *)source;
> +
> +    object_unref(OBJECT(tsource->tioc));
> +}
> +
> +static GSourceFuncs qio_channel_tls_source_funcs = {
> +    qio_channel_tls_source_prepare,
> +    qio_channel_tls_source_check,
> +    qio_channel_tls_source_dispatch,
> +    qio_channel_tls_source_finalize
> +};
> +
> +static void
> +qio_channel_tls_read_watch(QIOChannelTLS *tioc, GSource *source)
> +{
> +    GSource *child;
> +    QIOChannelTLSSource *tlssource;
> +
> +    child = g_source_new(&qio_channel_tls_source_funcs,
> +                          sizeof(QIOChannelTLSSource));
> +    tlssource = (QIOChannelTLSSource *)child;
> +
> +    tlssource->tioc = tioc;
> +    object_ref(OBJECT(tioc));
> +
> +    g_source_add_child_source(source, child);
> +}
> +
>   static GSource *qio_channel_tls_create_watch(QIOChannel *ioc,
>                                                GIOCondition condition)
>   {
>       QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
> +    GSource *source = qio_channel_create_watch(tioc->master, condition);
> +
> +    if (condition & G_IO_IN) {
> +        qio_channel_tls_read_watch(tioc, source);
> +    }
>   
> -    return qio_channel_create_watch(tioc->master, condition);
> +    return source;
>   }
>   
>   QCryptoTLSSession *


