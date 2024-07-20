Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA356C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFKV-0007dW-1r; Sat, 20 Jul 2024 15:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFKS-0007cq-Ix
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFKQ-0007KF-Q6
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKxqkdqntprvoQRKUinv0ScKvpHoPns5IYyDlGXiGPA=;
 b=YpZ7uPBeAK7/rhqzyFfLIEWB+wotzml75+JOhrRIK8yvShksmeSyvctXVaxBE+l2RRHQfz
 fHIWIUvXWHmc4VzF7tonqITTFVLI14cuJSEukSXrEcJ03heqhDxT5FKH8gYZeuw/QdqfwU
 RC3pN8iRD79G71CjoHFETIoqY5ExBkk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-krtNObhEP8SSuyeh44CWUg-1; Sat, 20 Jul 2024 15:01:04 -0400
X-MC-Unique: krtNObhEP8SSuyeh44CWUg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ef23b417bcso4352051fa.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502062; x=1722106862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKxqkdqntprvoQRKUinv0ScKvpHoPns5IYyDlGXiGPA=;
 b=I4QdC7YrMGfQ/IXc87+dCsAcQWiPZicQ+qCBo5JsvEOuLvKy9ts65Hzeozz7Ow7T9d
 SkRgwuMktgrPCYQN5L4vQ3QfH6+CfEJwMPxLspik/tx1s+zPeDu/LlTPbZdiAKSKaTLY
 kYw32rBiPxhzcM2YKD9zmVlPFFHH7wrJo8+JuCsg56gcfXDA2EXh0FdRXELBvN3Q1ED1
 p/CpZiTdQx9Jd/lU1KnoTk6Bhr/MLJY2en0cA+XFHeRQecy8rajV4rNy2ELtl2V67cKY
 cOGaIJ6zi+pApVE7yLNDkr+rjSnCvGwVt2HafOuLLmrJOnDHbwBsKIvrAqsa/AkWEUqf
 1gnw==
X-Gm-Message-State: AOJu0YxxNw9HvB4QDmQ3mYRpyROl7Qy63WN4iHP6mgTEm7x2OmwpRHgS
 wynU9SBhAYMrATqgko72J9RJ3OUAi+LaW5XHOmj5oRCEyEEFgUsYP5OX+wgMkzsJA88Lf+1r/Rr
 +QeBAoDQ9Z9/2fK/l9UeSisNeNmCZXOp8kpHhM2Wry0az4VLgGWiNePqrZerOCQ4=
X-Received: by 2002:a2e:7009:0:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2ef1db2c1demr14765121fa.6.1721502062613; 
 Sat, 20 Jul 2024 12:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRc1rZ3jvtIpw2ez4WtiRZfhhVQpo231J8+nvlzMKpn0Ey2umT65guqZocOowodq4l8cxKCA==
X-Received: by 2002:a2e:7009:0:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2ef1db2c1demr14764871fa.6.1721502061769; 
 Sat, 20 Jul 2024 12:01:01 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a52cef1417sm492294a12.47.2024.07.20.12.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:01:01 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:00:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240720145819-mutt-send-email-mst@kernel.org>
References: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

typos in subject do not inspire confidence.

On Thu, Jul 18, 2024 at 04:31:03PM +0800, BillXiang wrote:
> From: BillXiang <xiangwencheng@dayudpu.com>
> 
> We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request
> in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02559.html

Pls put commit here not ML link:
commit ABCDEFGHIKLM ("subject")

> and will send this message only for vq 0.

you mean "should send"?


> 
> Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> ---
> V1[1] -> V2:
>  - Refrain from appending flags to messages that could 
> precipitate validation failures upon execution of the 
> `vhost_user_read_header` function. 
> 
> [1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg01923.html
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..fd12992d15 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>          return ret;
>      }
>  
> -    if (shmfd) {
> +    if (shmfd && (dev->vq_index == 0)) {

extra () not needed here.

>          msg.hdr.size = 0;
>          ret = vhost_user_read(dev, &msg);
>          if (ret < 0) {
> -- 
> 2.30.0


