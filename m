Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C80C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZUs1-0003Zm-6g; Thu, 01 Aug 2024 08:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZUry-0003Z6-Om
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZUrw-0005ry-RY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722515120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBoMPEUGI22e6uQAT1dWWJJv+EbV69b2kgVXGtqe6Dg=;
 b=EDQkLtyc6loSAAvWU9vkjFqBPzD5dXkdPI/InorH8cToFXSH3wqqjLdhlDqVyiOP9wxnmA
 aR3TGodPI6wraRNoCI/2uxR2LeVsGkHw2fMR+lHxolutod2+uJUQuLubPd0OxZzCSuy6xD
 ytXBYGBnAqz6xb0Xqv/LdEfPpMrMAi4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-czOErOIMNP-7U8JUYM2INA-1; Thu, 01 Aug 2024 08:25:18 -0400
X-MC-Unique: czOErOIMNP-7U8JUYM2INA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a3fa8b9151so6065848a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722515117; x=1723119917;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dBoMPEUGI22e6uQAT1dWWJJv+EbV69b2kgVXGtqe6Dg=;
 b=d8PTM0DvjELXiF4RGJ/VtQY4kPqOvMieP7FqNTiuBhmQ9RChBp8JiNs/9nvydT9XDM
 6alFEp23orKETeAqUseTI6S4jgPOQ/kNIU17tacukx+XdYnkPWUXMs/Gfw9nqAgZy8AH
 mdI8B9uYyIBZ7LhEen7AVdACzNJgbtwAAzUxzAAjzY1Cu4w6WwtmuC1q2qt4XqlqKlVf
 G42jXxYhsi9Djghd7iWHGaHn1qQHetFgVQyd7DARkDYXC14NTYS6JI5ZoYmkblNhK8rE
 TsEvtyeUfNaOl6hYpoMqz08+CgvTfL/iW1/bKmGRxfm8ZmhS4IYX4/th7IGcVj9B1W04
 2kPQ==
X-Gm-Message-State: AOJu0YylrLrNfEBU6A03zi3DnvMKsTOhkM+11JBhrsI0YYD6rc2/3Kel
 N+tcSiJ1A+d8So11rjwcjcX4nUPwEJV8vKBfsJPK3L8btWrraW6kKbYySNkyTtp1zIJFWApn/DU
 FvAJ7smBeL+f8uvVzsnP79c3LG72gmLc23PNjfQFgijBzIX7U+n8//rO1WkbZ
X-Received: by 2002:a05:6402:40c:b0:5a0:c709:aa0b with SMTP id
 4fb4d7f45d1cf-5b7f56fd439mr47576a12.24.1722515117273; 
 Thu, 01 Aug 2024 05:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7PHwhEXG4Dd+I0MT7/dqwITyIUTw+EMC0QVtYDWqC1Rt/0KL8WcXUjGhRkxoZGoyqhgir1w==
X-Received: by 2002:a05:6402:40c:b0:5a0:c709:aa0b with SMTP id
 4fb4d7f45d1cf-5b7f56fd439mr47550a12.24.1722515116484; 
 Thu, 01 Aug 2024 05:25:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3a18sm10151322a12.75.2024.08.01.05.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 05:25:15 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:25:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240801082435-mutt-send-email-mst@kernel.org>
References: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
 <20240720145819-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.0ff73b39.722e.4462.b426.f477adef04f2@feishu.cn>
 <20240801042507-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.cce6af4a.43f3.41da.bd6c.5fdb96e92401@feishu.cn>
 <20240801062459-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.5127ea26.fe5b.410e.beec.731472900902@feishu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.5127ea26.fe5b.410e.beec.731472900902@feishu.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 08:20:35PM +0800, BillXiang wrote:
> 
> > From: "Michael S. Tsirkin"<mst@redhat.com>
> > Date:  Thu, Aug 1, 2024, 18:26
> > Subject:  Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE
> > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > Cc: <qemu-devel@nongnu.org>
> > On Thu, Aug 01, 2024 at 05:48:36PM +0800, BillXiang wrote:
> > > 
> > > > From: "Michael S. Tsirkin"<mst@redhat.com>
> > > > Date:  Thu, Aug 1, 2024, 16:26
> > > > Subject:  Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE
> > > > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > > > Cc: <qemu-devel@nongnu.org>
> > > > On Sun, Jul 21, 2024 at 11:20:56AM +0800, BillXiang wrote:
> > > > > 
> > > > > > From: "Michael S. Tsirkin"<mst@redhat.com>
> > > > > > Date:  Sun, Jul 21, 2024, 03:01
> > > > > > Subject:  Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE
> > > > > > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > > > > > Cc: <qemu-devel@nongnu.org>
> > > > > > typos in subject do not inspire confidence.
> > > > > 
> > > > > Sorry
> > > > > 
> > > > > > 
> > > > > > On Thu, Jul 18, 2024 at 04:31:03PM +0800, BillXiang wrote:
> > > > > > > From: BillXiang <xiangwencheng@dayudpu.com>
> > > > > > > 
> > > > > > > We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request
> > > > > > > in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02559.html
> > > > > > 
> > > > > > Pls put commit here not ML link:
> > > > > > commit ABCDEFGHIKLM ("subject")
> > > > > > 
> > > > > > > and will send this message only for vq 0.
> > > > > > 
> > > > > > you mean "should send"?
> > > > > > 
> > > > > 
> > > > > What I mean is the commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
> > > > > will cause VHOST_USER_SET_LOG_BASE to be sent only when 'vq_index == 0' in vhost_user_write, 
> > > > > so that we can not use vhost_user_read to get reply when 'vq_index != 0'
> > > > 
> > > > 
> > > > do we try to do it now? in which configurations?
> > > > 
> > > 
> > > Sorry, I'm not certain about what you're instructing me to do.
> > 
> > 
> > I am asking that commit log is structured like this:
> > 
> > currently, abc happens, as a result, def happens
> > do hij, such that klm instead
> > 
> 
> Should I merge "[PATCH] vhost-user: Remove redundant judgment" with this patch
> or just left them separated.

if the commit log is the same, you can merge.
if it's different, keep them separate.


> > 
> > 
> > > Maybe I should merge this patch whit commit 7c211eb078c4
> > > ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
> > >  and "[PATCH] vhsot-user: Remove redundant judgment" into one patch.
> > > 
> > > All of these three patches are aimed to do the same thing as 
> > > commit c98ac64cfb53 ("vhost-user: send set log base message only once")
> > > which is not a good solution because there is already a function vhost_user_per_device_request
> > > for those messages that should be sent only once per device.
> > > 
> > > In commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
> > > I added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request so that it will be sent only once 
> > > per device when 'vq_index == 0'.
> > > After that we should remove the check add by commit c98ac64cfb53 ("vhost-user: send set log base message only once")
> > > in "[PATCH] vhsot-user: Remove redundant judgment".
> > > And last, in current patch "vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE"
> > > we should only read reply when 'vq_index == 0'.
> > > 
> > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > > > > > > ---
> > > > > > > V1[1] -> V2:
> > > > > > >  - Refrain from appending flags to messages that could 
> > > > > > > precipitate validation failures upon execution of the 
> > > > > > > `vhost_user_read_header` function. 
> > > > > > > 
> > > > > > > [1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg01923.html
> > > > > > > ---
> > > > > > >  hw/virtio/vhost-user.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > > > index 00561daa06..fd12992d15 100644
> > > > > > > --- a/hw/virtio/vhost-user.c
> > > > > > > +++ b/hw/virtio/vhost-user.c
> > > > > > > @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
> > > > > > >          return ret;
> > > > > > >      }
> > > > > > >  
> > > > > > > -    if (shmfd) {
> > > > > > > +    if (shmfd && (dev->vq_index == 0)) {
> > > > > > 
> > > > > > extra () not needed here.
> > > > > > 
> > > > > > >          msg.hdr.size = 0;
> > > > > > >          ret = vhost_user_read(dev, &msg);
> > > > > > >          if (ret < 0) {
> > > > > > > -- 
> > > > > > > 2.30.0


