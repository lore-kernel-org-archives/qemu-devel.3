Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47046C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4e8-0000FK-Ih; Fri, 31 May 2024 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD4e7-0000Er-6T
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sD4e2-0004nw-Pp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717171098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNngYLypgfqgAXiQsm/xIpb6v57X9+xat06nXc2k90M=;
 b=VCv9KohMgiIe7dp+tVvszsWtykn/pgVOA1oJHdrC8c4RAA5GpryUvWxI/ZPk+ZMaFzxZce
 ISHNZMAA3/4JSQp/aYIvWjV+TzwAPTLS8hc7rYJowAEfEstCXdHtcdmmRzTSSr7bC0gNLy
 o89EYXnPXMf6qzI73mDenPhk6K9g8MQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-HXV6GTT0MqOXR_27BXzfxg-1; Fri, 31 May 2024 11:58:16 -0400
X-MC-Unique: HXV6GTT0MqOXR_27BXzfxg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ae0c888b2cso7273626d6.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717171096; x=1717775896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNngYLypgfqgAXiQsm/xIpb6v57X9+xat06nXc2k90M=;
 b=DBCELxMR5v4nIqkTzGC/rqPDs8N56qS/VMlHvJ+we/QyKzClGuwS1UWEXRoOtBfaKN
 gjDDZCXRZifYWxHc2ow3P45xEpglbanGlrhrnSTMrauyhV0RKb3IEpRprqMGUQ95lahl
 dd130vrtdKBbYlPyQWamrEOMBy7JBVf4C7MW+6Xwq5gBE7pVfzGXh3/PWvZKrTVNs0Th
 mBdx8I+6day9j+sm6tdKkAG2GIl2RF/kJ79GW2dayevBylhJkGoVZ+sCU1Q5Fp0ly5Sb
 lqtxE4DHq9zLw3rXAHBhPAiieGH+VN63VgWiguVoZ45E2yahxGH0VU2LpBKYuGl4vrV9
 xGgA==
X-Gm-Message-State: AOJu0YzNYOGuDtdGK+WWDz73T+TvENONFhqpTuq95sODFU5pyKsIdgab
 USq1/qgphhd0FX8v5kLdXAMSvNwAHR2jzSn+fvomViWY6GGAssjsSxb9sMB057DZXEPXpcxPX+s
 ZicF/86kIlhKeLlH+u2QdtmZK+EBwgXY4fgK3dsNHaHAP1AdzwrOF
X-Received: by 2002:a05:622a:1aa3:b0:43a:5595:7410 with SMTP id
 d75a77b69052e-43ff528871bmr23713681cf.2.1717171095710; 
 Fri, 31 May 2024 08:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYF+pUhl1uhlZMpculSHaILoLFVJFigv09BQYmX8IOgmEmvFhc6/6mepFrp6XFYIfOqPfzDw==
X-Received: by 2002:a05:622a:1aa3:b0:43a:5595:7410 with SMTP id
 d75a77b69052e-43ff528871bmr23713331cf.2.1717171095033; 
 Fri, 31 May 2024 08:58:15 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23e774fsm9244681cf.49.2024.05.31.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 08:58:14 -0700 (PDT)
Date: Fri, 31 May 2024 11:58:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 13/18] monitor: fdset: Match against O_DIRECT
Message-ID: <ZlnzlFH2k6qp31oT@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-14-farosas@suse.de> <Zljyf28LG1YCw9Al@x1n>
 <87ikyukmya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikyukmya.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Fri, May 31, 2024 at 12:42:05PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 23, 2024 at 04:05:43PM -0300, Fabiano Rosas wrote:
> >> We're about to enable the use of O_DIRECT in the migration code and
> >> due to the alignment restrictions imposed by filesystems we need to
> >> make sure the flag is only used when doing aligned IO.
> >> 
> >> The migration will do parallel IO to different regions of a file, so
> >> we need to use more than one file descriptor. Those cannot be obtained
> >> by duplicating (dup()) since duplicated file descriptors share the
> >> file status flags, including O_DIRECT. If one migration channel does
> >> unaligned IO while another sets O_DIRECT to do aligned IO, the
> >> filesystem would fail the unaligned operation.
> >> 
> >> The add-fd QMP command along with the fdset code are specifically
> >> designed to allow the user to pass a set of file descriptors with
> >> different access flags into QEMU to be later fetched by code that
> >> needs to alternate between those flags when doing IO.
> >> 
> >> Extend the fdset matching to behave the same with the O_DIRECT flag.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > One thing I am confused but totally irrelevant to this specific change.
> >
> > I wonder why do we need dupfds at all, and why client needs to remove-fd at
> > all.
> 
> This answer was lost to time.
> 
> >
> > It's about what would go wrong if qmp client only add-fd, then if it's
> > consumed by anything, it gets moved from "fds" list to "dupfds" list.  The
> > thing is I don't expect the client should pass over any fd that will not be
> > consumed.  Then if it's always consumed, why bother dup() at all, and why
> > bother an explicit remove-fd.
> 
> With the lack of documentation, I can only imagine the code was
> initially written to be more flexible, but we ended up never needing the
> extra flexibility. Maybe we could change that transparently in the
> future and deprecate qmp_remove_fd(). I'm thinking, even for the
> mapped-ram work, we might not need libvirt to call that function ever.

Good to know I'm not the only one thinking that.

It's okay - after your cleanup it's much better at least to me.  The only
thing to avoid these, AFAIU, is more careful design level reviews in the
future, and more documents state the facts and keep in history (and
obviously why remove-fd was needed was not documented).  Now we carry them.

-- 
Peter Xu


