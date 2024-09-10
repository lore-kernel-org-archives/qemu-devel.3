Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C582EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2hw-0006HS-8Q; Tue, 10 Sep 2024 11:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2hu-0006Gx-OG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2ht-0006d2-5H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725981783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNqjX8xBWcWoOEwcRvB1zdg0OUgUiLGa2OyogGFFKBQ=;
 b=Eg4syhHWXKoDjibGnRXCltD0JPkugfRuvP0XJyaTqnjJXFbZq6LIIq/GxTUMjilplMDpz9
 R0v2HW8kBWTirIa0bt7hgoM/zRsPnSkMBywq+d+ftlkasU23tyY07S+/rDDgzV78WCSLqr
 TYJYBVIhZGviO1e09oVMPcWBIULF8fs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-3Ji2kb1zPR2MY8OfR8eBfw-1; Tue, 10 Sep 2024 11:22:59 -0400
X-MC-Unique: 3Ji2kb1zPR2MY8OfR8eBfw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso7853155e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725981779; x=1726586579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNqjX8xBWcWoOEwcRvB1zdg0OUgUiLGa2OyogGFFKBQ=;
 b=lDe0cVvgR1/cWa2BRGpQGphM/z2lQybJZTcHvCp4LiHcCb4r/RnfBN6VqRFBTi82is
 0Pb3nZLHc0WFjubo90QnwDQQv2HJLJKoY+lvml1P/QT14xNsDN/4+cPCwYmoHA6jl0AY
 UbuqF3rcRXUBWtcAdAF5iwpZKTevSYzJX6Ak2JzkiH5yK0mbQmo+VCic4Eb2OFKHgbzd
 3uEmSIZdEWFb4Cc838/h9776TX8FmPVSReyvgKsAy/JGXW4bmVCAs7kevOslX9VCF7KB
 8Nd/rY0g/LlPzR54weRhNdwyFLT9YBpAeyHzEyngBIU1fLf/Gi5dX54S9mIfoUKoDWUW
 76ZA==
X-Gm-Message-State: AOJu0YyCnEoNaC5nhh9k7yrC+t7nl7+x7qQPZN+RQhRuroIGYqeYSaIG
 DpfGp2ePxozWQGs6MahMrt7ZW+cwNLt5qHnGpvhGtCvjO7gKBWeS70oO/lqTYOfrTSjVUpxWTqM
 7FIRIwx1ENxBPlXgJyP/lj8dgkVcsE2vLNLDHmQCuvK7XMtFO0nl0
X-Received: by 2002:a05:600c:3843:b0:428:1ce0:4dfd with SMTP id
 5b1f17b1804b1-42ccd361045mr115855e9.34.1725981778508; 
 Tue, 10 Sep 2024 08:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvSY6CmU7g1LueNqcyuHI+rdsvV+06oWXjKC9PjrfT5i8X0ossrA6dIiLGZcJLw63VFU/ixQ==
X-Received: by 2002:a05:600c:3843:b0:428:1ce0:4dfd with SMTP id
 5b1f17b1804b1-42ccd361045mr115625e9.34.1725981777767; 
 Tue, 10 Sep 2024 08:22:57 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb226ef2fsm98633255e9.13.2024.09.10.08.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 08:22:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:22:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-user: rewrite vu_dispatch with if-else
Message-ID: <20240910112234-mutt-send-email-mst@kernel.org>
References: <20240804142353.25342-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804142353.25342-1-luzhixing12345@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Sun, Aug 04, 2024 at 10:23:53PM +0800, luzhixing12345 wrote:
> rewrite with if-else instead of goto
> 
> and I have a question, in two incorrent cases
> 
> - need reply but no reply_requested
> - no need reply but has reply_requested
> 
> should we call vu_panic or print warning message?

this is not how you post a patch to the list.


> ---
>  subprojects/libvhost-user/libvhost-user.c | 39 +++++++++++++----------
>  subprojects/libvhost-user/libvhost-user.h |  6 ++--
>  2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 9c630c2170..187e25f9bb 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -2158,32 +2158,39 @@ vu_dispatch(VuDev *dev)
>  {
>      VhostUserMsg vmsg = { 0, };
>      int reply_requested;
> -    bool need_reply, success = false;
> +    bool need_reply, success = true;
>  
>      if (!dev->read_msg(dev, dev->sock, &vmsg)) {
> -        goto end;
> +        success = false;
> +        free(vmsg.data);
> +        return success;
>      }
>  
>      need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
>  
>      reply_requested = vu_process_message(dev, &vmsg);
> -    if (!reply_requested && need_reply) {
> -        vmsg_set_reply_u64(&vmsg, 0);
> -        reply_requested = 1;
> -    }
> -
> -    if (!reply_requested) {
> -        success = true;
> -        goto end;
> -    }
>  
> -    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> -        goto end;
> +    if (need_reply) {
> +        if (reply_requested) {
> +            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> +                success = false;
> +            }
> +        } else {
> +            // need reply but no reply requested, return 0(u64)
> +            vmsg_set_reply_u64(&vmsg, 0);
> +            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> +                success = false;
> +            }
> +        }
> +    } else {
> +        // no need reply but reply requested, send a reply
> +        if (reply_requested) {
> +            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
> +                success = false;
> +            }
> +        }
>      }
>  
> -    success = true;
> -
> -end:
>      free(vmsg.data);
>      return success;
>  }
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
> index deb40e77b3..2daf8578f6 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -238,6 +238,8 @@ typedef struct VuDev VuDev;
>  
>  typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
>  typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
> +typedef uint64_t (*vu_get_protocol_features_cb) (VuDev *dev);
> +typedef void (*vu_set_protocol_features_cb) (VuDev *dev, uint64_t features);
>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>                                    int *do_reply);
>  typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
> @@ -256,9 +258,9 @@ typedef struct VuDevIface {
>      vu_set_features_cb set_features;
>      /* get the protocol feature bitmask from the underlying vhost
>       * implementation */
> -    vu_get_features_cb get_protocol_features;
> +    vu_get_protocol_features_cb get_protocol_features;
>      /* enable protocol features in the underlying vhost implementation. */
> -    vu_set_features_cb set_protocol_features;
> +    vu_set_protocol_features_cb set_protocol_features;
>      /* process_msg is called for each vhost-user message received */
>      /* skip libvhost-user processing if return value != 0 */
>      vu_process_msg_cb process_msg;
> -- 
> 2.34.1


