Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KYr-0001v3-8x; Thu, 02 Oct 2025 10:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v4KYp-0001sk-Gb
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v4KYh-0004DK-L9
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759416318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waYsDNJdj4N06RYlD5HeMqR04U2bV47S2BiSHlE0VYE=;
 b=RoXUs2BPXtb/uyIf2JSwokeayWux0AACjeo7zDqok0LBjZeYj7Zkw81qjEVCDv+RaSSmXN
 eG1l1oT7BPl/7cKHVaBMfKCSaB4Z8icpA94diU75+FjUKL2feumdMpJ+KAUuHdhNIk72dQ
 BKjHMilbYHHbgWlIV7VdJ/UvledOAGk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-KLZX8k9YNHK_60YYqR0zoQ-1; Thu, 02 Oct 2025 10:45:17 -0400
X-MC-Unique: KLZX8k9YNHK_60YYqR0zoQ-1
X-Mimecast-MFC-AGG-ID: KLZX8k9YNHK_60YYqR0zoQ_1759416316
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e407c600eso5933745e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759416316; x=1760021116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waYsDNJdj4N06RYlD5HeMqR04U2bV47S2BiSHlE0VYE=;
 b=lNWstYcAHomp1kmaIS3SboRNR/wCwarYfrWeBG7VD69JRmpdlROh9qAGs0V0e70egR
 rtE906/XlpwSgsQtr0vIKKU+d9brX55aZLT8/LmpSNOMhQwbnxWH/b5SLzCem/4hbGgg
 d/v20REMRCr5jqYis+EhHrMBUXwE+hgeXOOmYI0swiC7Ccfn8zjksTj/8UHgenHC9uXP
 8dl/3vbc+i2DYtUaWAFWj3w5RTk7O3bh9I2fQwJS2r2A9OVMQrQpkmdhU2WI54Art2hZ
 Tv7Wz1/l7eb5xYxzIpLt1IEFm+f3s5zCHLz7HkCy9dPouioPoXJu0RYyz9fmw6ky9R1J
 XgxQ==
X-Gm-Message-State: AOJu0YyCn1oWhQ8/mojuhw4+CY7w6SWnY29A8WrCsjQMu4MTPke0HaZW
 VoGPvB5VfdNHz0iiDojM/mupjm0a0dOs+Tnnq1JS7bhPualaVZqKEeFmfmcR4mKWo7EdowULX9A
 mqp9/glV7pzYBNK0egqorGBw9FO2wVJjIGxZ1yQSbhjikvG1A9NEeptmp
X-Gm-Gg: ASbGncvXbu9d9p5/FFTG/WtgubqkCR193WET3Hq6Zujmd2ZvCySGTisAOYX0Q9xr8V0
 kU/4e2c+TQ8Nn7KNUM82mHE3IV6wlqGR1shKLOQVB5smmogW9CwKIpYSe16eOwKZ/X4Pgq3KWjk
 AqtU7noC9zl88COvTy4+PROqonOp5TspG/wVE0Rh40wrJrYDZHlGnpcmnKUjtWMtAztV8D0Gl5L
 XNqM4IP88VAxgNI9/7Ca6T8katE+KPSLAKMYT0bBJRQJeTD5Nlov/XJR3oAsz6XWk3AGuADg55z
 muWdPNbd8513RCf6hSC7pLxcfNxZbcBZgEw=
X-Received: by 2002:a05:600c:468f:b0:46e:447d:858e with SMTP id
 5b1f17b1804b1-46e612dce3dmr61715885e9.28.1759416315862; 
 Thu, 02 Oct 2025 07:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYfaFOLnvI4ELDIiJA3pZBH7TQ/LAkbfr1KtIXncjvMRkVe5gOJe9LimGHKAVo0JL8077DAw==
X-Received: by 2002:a05:600c:468f:b0:46e:447d:858e with SMTP id
 5b1f17b1804b1-46e612dce3dmr61715635e9.28.1759416315389; 
 Thu, 02 Oct 2025 07:45:15 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4b71sm3770935f8f.57.2025.10.02.07.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 07:45:14 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:45:12 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 ppandit@redhat.com, berrange@redhat.com
Subject: Re: [PATCH 1/3] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <72mloahvtgskcdjulsggewy3euoutslvpcx2dnkxijgwkogdg6@6oq3h5tncfl3>
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
 <20251001161823.2032399-2-Marco.Cavenati@eurecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001161823.2032399-2-Marco.Cavenati@eurecom.fr>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Marco,

On 2025-10-01 18:18, Marco Cavenati wrote:
> Enable the use of the mapped-ram migration feature with savevm/loadvm
> snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
> QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
> positioned I/O capabilities that don't modify the channel's position
> pointer.
> 
> Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> ---
>  migration/channel-block.c | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/migration/channel-block.c b/migration/channel-block.c
> index 97de5a691b..30dcefcd8e 100644
> --- a/migration/channel-block.c
> +++ b/migration/channel-block.c
> @@ -30,6 +30,7 @@ qio_channel_block_new(BlockDriverState *bs)
>      QIOChannelBlock *ioc;
>  
>      ioc = QIO_CHANNEL_BLOCK(object_new(TYPE_QIO_CHANNEL_BLOCK));
> +    qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
>  
>      bdrv_ref(bs);
>      ioc->bs = bs;
> @@ -96,6 +97,49 @@ qio_channel_block_writev(QIOChannel *ioc,
>      return qiov.size;
>  }
>  
> +#ifdef CONFIG_PREADV

I don't think this conditional macro is necessary here. QIOChannelFile
needs it because it directly uses preadv() syscall which might not be
available on all systems (see when CONFIG_PREADV is defined below).

    config_host_data.set('CONFIG_PREADV', cc.has_function('preadv', prefix: '#include <sys/uio.h>'))

However, bdrv_readv_vmstate() (wrapper of bdrv_co_readv_vmstate())
should be always available IUUC (it is not conditionally compiled based
on if preadv() syscall is available).

> +static ssize_t
> +qio_channel_block_preadv(QIOChannel *ioc,
> +                         const struct iovec *iov,
> +                         size_t niov,
> +                         off_t offset,
> +                         Error **errp)
> +{
> +    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
> +    QEMUIOVector qiov;
> +    int ret;
> +
> +    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
> +    ret = bdrv_readv_vmstate(bioc->bs, &qiov, offset);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "bdrv_readv_vmstate failed");
> +        return -1;
> +    }
> +
> +    return qiov.size;
> +}
> +
> +static ssize_t
> +qio_channel_block_pwritev(QIOChannel *ioc,
> +                          const struct iovec *iov,
> +                          size_t niov,
> +                          off_t offset,
> +                          Error **errp)
> +{
> +    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
> +    QEMUIOVector qiov;
> +    int ret;
> +
> +    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
> +    ret = bdrv_writev_vmstate(bioc->bs, &qiov, offset);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "bdrv_writev_vmstate failed");
> +        return -1;
> +    }
> +
> +    return qiov.size;
> +}
> +#endif /* CONFIG_PREADV */
>  
>  static int
>  qio_channel_block_set_blocking(QIOChannel *ioc,
> @@ -177,6 +221,10 @@ qio_channel_block_class_init(ObjectClass *klass,
>      ioc_klass->io_writev = qio_channel_block_writev;
>      ioc_klass->io_readv = qio_channel_block_readv;
>      ioc_klass->io_set_blocking = qio_channel_block_set_blocking;
> +#ifdef CONFIG_PREADV
> +    ioc_klass->io_preadv = qio_channel_block_preadv;
> +    ioc_klass->io_pwritev = qio_channel_block_pwritev;
> +#endif
>      ioc_klass->io_seek = qio_channel_block_seek;
>      ioc_klass->io_close = qio_channel_block_close;
>      ioc_klass->io_set_aio_fd_handler = qio_channel_block_set_aio_fd_handler;
> -- 
> 2.48.1
> 

Best regards,

Juraj Marcin


