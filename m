Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD914C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIm9-00025n-MA; Mon, 01 Jul 2024 11:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOIm8-00025R-91
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOIm6-0000Lr-EY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719847020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFArhhIJq9OnIB43l55ezWPv+/nTDX4X46rLW/MQDwQ=;
 b=U+Z3NVVupPUmDzkZu0ODNbYNIr6Yr8tlM2pr6+Bf0pp+Yt+rm5PWPaKyRpJFApR2UaOQ74
 v8yv1oSwLc/chKpExE/0Bqe41QMEMP2oajC7f6zvWa2M9OKoMkBym4QeeUrLoy75RWI5wL
 VnU/3P4HeQjYYpuOGofNwnyZAv76R1Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-JjYae0ViMQGYnjgzABFkGA-1; Mon, 01 Jul 2024 11:16:58 -0400
X-MC-Unique: JjYae0ViMQGYnjgzABFkGA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec61a87db0so31918961fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719847017; x=1720451817;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KFArhhIJq9OnIB43l55ezWPv+/nTDX4X46rLW/MQDwQ=;
 b=Ac77lcu1jcJfLRnnyLJ/wBh3EUA3FTP5yzvehQ/loqoDGJgZAz7gnwjwd4DSKdqvyZ
 UpCkM/MkppT45sh206DLsT5Uvszww/uJH+8m/MFotU4l3HagO2CUdiHZBeGUqGwY5+TO
 ZkN5ABHCSEbqqVTued1DmG8ii3jzt0GqIKW4cdNXhQEBMTSGY7v07S0dioA13GENKm9b
 LgfPsQFZot/vE6zh//DKfFdSskxFo8MH9KpZ6zJ3QK0EDsCMh1CP9cq03CiXHnyFRD9P
 OH+TfAIZiHnrHGsbnElBdq4JD39LwxkCffY+iwjvz6VWfx82S0gF8dpxBr8uIGvH4Tmn
 2fWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMqPB6Zmyp4kt3BiPPeL5tSXoWvsOx3Bnn2E7tFXsVQ3MRgQPNXCsEm+Ir2KqTXse6Bwa0gj04YcIoYrgeiJqmm+pAW2I=
X-Gm-Message-State: AOJu0Yxk2MMsOcpwQrSssoIOga/gKmA06uv5fEyyb/gPWUMz8oVHkoIY
 fE8FQTJ/FfI6b0MjvYRPvkLvGiF+Rp38H0lq743LbzDUjRaTXK6dYno5h2U27dpCaCTA1dfa7oA
 5mQkfnOshN1fgwP0Yyese6qBZ1VsEigY4qQr9VdVxC2FWshd2OGA4
X-Received: by 2002:a2e:a179:0:b0:2ec:4ef4:199a with SMTP id
 38308e7fff4ca-2ee5e6f7721mr37189141fa.43.1719847016932; 
 Mon, 01 Jul 2024 08:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqFDZH7PS5p2ltwzzDSmF0qA7wuB8SkrHZDQNsJoH9QjO/mqXrzVbEzZ18eUu7IAYX8/H5eA==
X-Received: by 2002:a2e:a179:0:b0:2ec:4ef4:199a with SMTP id
 38308e7fff4ca-2ee5e6f7721mr37188911fa.43.1719847016211; 
 Mon, 01 Jul 2024 08:16:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8d9fsm10215754f8f.26.2024.07.01.08.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 08:16:55 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:16:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: BillXiang <xiangwencheng@dayudpu.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
Message-ID: <20240701111531-mutt-send-email-mst@kernel.org>
References: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
 <87zfr1qyyi.fsf@draig.linaro.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.8eed26c3.aba1.4d51.9976.281bbad0a8e6@feishu.cn>
 <87msn1qh44.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msn1qh44.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 01, 2024 at 04:14:35PM +0100, Alex Bennée wrote:
> "BillXiang" <xiangwencheng@dayudpu.com> writes:
> 
> >> From: "Alex Bennée"<alex.bennee@linaro.org>
> >> Date:  Mon, Jul 1, 2024, 16:49
> >> Subject:  Re: [PATCH] vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests
> >> To: "项文成"<xiangwencheng@dayudpu.com>
> >> Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>
> >> 项文成 <xiangwencheng@dayudpu.com> writes:
> >> 
> >> > From: BillXiang <xiangwencheng@dayudpu.com>
> >> >
> >> > The VHOST_USER_SET_LOG_BASE requests should be categorized into
> >> > non-vring specific messages, and should be sent only once.
> >> > If send more than once, dpdk will munmap old log_addr which may has
> >> > been used and cause segmentation fault.
> >> 
> >> This looks fine to me but looking at the vhost-user.rst we don't seem to
> >> make any explicit statements about how many times given messages should
> >> be sent.
> >> 
> > There is indeed no explicit statements about how many times given messages
> >  should be sent in vhost-user.rst but already have some discussions such as 
> > https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst@kernel.org/.
> 
> Right, but I think we should then update the specification if this is
> the way we want things to work. Otherwise we are putting a backend
> specific hack that another backend might be able to tolerate.

I think it's a dpdk bug, we *allow* resending same message many times.
However, less messages is better, I don't see a reason to
repeat the same message many times.

> >> >
> >> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> >> > ---
> >> >  hw/virtio/vhost-user.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> > index cdf9af4a4b..41e34edd49 100644
> >> > --- a/hw/virtio/vhost-user.c
> >> > +++ b/hw/virtio/vhost-user.c
> >> > @@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUserRequest request)
> >> >      case VHOST_USER_RESET_DEVICE:
> >> >      case VHOST_USER_ADD_MEM_REG:
> >> >      case VHOST_USER_REM_MEM_REG:
> >> > +    case VHOST_USER_SET_LOG_BASE:
> >> >          return true;
> >> >      default:
> >> >          return false;
> >> 
> >> -- 
> >> Alex Bennée
> >> Virtualisation Tech Lead @ Linaro
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


