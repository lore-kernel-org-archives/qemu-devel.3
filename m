Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BCFC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezFE-0007UT-5d; Fri, 16 Aug 2024 11:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezFB-0007L2-OE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezF8-0004c1-02
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723823516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TOZ37lRFqHfpgVhi4prp5yjI5hOKLc8mxtz1oSWIDQk=;
 b=QklFmW/6wcKEVe18XrV6eojVCx752DSn/vsBy3fboaM9q4P3USyvge5I9gNF+2Q5o5Fb41
 rnq7Xvdvp9W7ztzI76pVw/L99fi6zcHbAxtCrlBdGW3zJTia87LZnKgzBMPa5WRQgB0skS
 MP81ybz8wf3fgYByszjH0Dfn6BRGNVY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-PR1fUQSdO1C7lwY3FS32jA-1; Fri, 16 Aug 2024 11:51:55 -0400
X-MC-Unique: PR1fUQSdO1C7lwY3FS32jA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6bf6f1ad75cso4513646d6.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823514; x=1724428314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOZ37lRFqHfpgVhi4prp5yjI5hOKLc8mxtz1oSWIDQk=;
 b=G7IC+Szfhf+iM2JkBKJp3uHBbYSGlrG1M8/EogqBCaug5AH02xDTxzpGy64H78+3Jt
 EJk6SodT5ZyP2g+ch1pE8dQ9N2Q/tARB9aGAHUoSbnNthhOpPTK27aLp3GjUUp/GhTvq
 2U+PWtP4wFmLZIFsUG6UuTNe8nC20KdnuO+/a/jpgMuFnM+Uybwq9fQjvz91icqd2Son
 Qu4vaQtEL/OiIT1xUDYzPsLKsB4jqcedw/eh7qPV0ufmsRAX+YPXPLdDkbykxBzhxPYK
 pmvwfnmzU5lAWbo/oXHfFfLzzZ4Y2scrqw/0OxcnKWyVoI9PD5qV+F4IYMJV3MNQdyXe
 +H2A==
X-Gm-Message-State: AOJu0Yztzuh3wxSLAY9kOyPveJzl5Cc/fUjs7e7FPvwu/37/StaTfkrl
 MP+tsLb/+3RaGGb4ZsQmu5PAICrQ7R3fRdvCNA5OEqUm3NsNAW+3tgRQGdvjsK377G/OenVlyG2
 M8g2HSLx2xVSVLL/JxdqXaq6MIBhAMk8ubzHfOlhQkp5O8YHTdXTl
X-Received: by 2002:ae9:e645:0:b0:7a5:8f7:1b7f with SMTP id
 af79cd13be357-7a508f71dcbmr130485485a.0.1723823514323; 
 Fri, 16 Aug 2024 08:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfAQu2DZsoNu48GE5RM6h0eCJSFjiaxg0ls2BNlgV8WY8YVzm7qL+n7oCIm44Mfb/iVSEP+g==
X-Received: by 2002:ae9:e645:0:b0:7a5:8f7:1b7f with SMTP id
 af79cd13be357-7a508f71dcbmr130484685a.0.1723823513848; 
 Fri, 16 Aug 2024 08:51:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff06a25bsm185402185a.54.2024.08.16.08.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:51:53 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:51:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC V1 1/6] migration: SCM_RIGHTS for QEMUFile
Message-ID: <Zr91mApJzvnDny8D@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
 <Zr5r4_lyKAPVZY3Y@x1n>
 <92e5309e-9b16-4cf4-8ffb-e1383201cbd0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92e5309e-9b16-4cf4-8ffb-e1383201cbd0@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 11:13:20AM -0400, Steven Sistare wrote:
> On 8/15/2024 4:58 PM, Peter Xu wrote:
> > On Sun, Jun 30, 2024 at 12:44:03PM -0700, Steve Sistare wrote:
> > > Define functions to put/get file descriptors to/from a QEMUFile, for qio
> > > channels that support SCM_RIGHTS.  Maintain ordering such that
> > >    put(A), put(fd), put(B)
> > > followed by
> > >    get(A), get(fd), get(B)
> > > always succeeds.  Other get orderings may succeed but are not guaranteed.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > It's a slight pity that we'll extend fd to qemufiles, rather than changing
> > qemufiles back to iochannels.. for the long term we want to remove qemufile.
> 
> Thanks, I did not know that removing QEMUFile is a goal.
> 
> Currently QEMUFile buffers I/O in userland to reduce system calls.  Do you
> plan to eliminate that buffering, or move it to QIOChannel, perhaps in a
> new QIOChannelBuffered class?
> 
> If you eliminate the buffering, then migration might take longer.
> If you keep the buffering, then this patch's logic will still be needed
> in the QIOChannelBuffered code.

+Dan.

Yes probably the buffering is still needed ultimately.  It's just that it
currently involves qemufile which is (hopefully..) destined to be either
removed or updated.

For this cpr states, I'm not sure the buffered iochannel is a must, e.g. I
wonder what happens if we start with using iochannels directly without
buffering, then after replacing that with buffered iochannels, it'll simply
improve on top without changing much of the code - I mean, buffered
iochannel should still be able to be casted into an iochannel anyway.

> 
> > Would you think we can start to introduce iochannel-compatible vmstate
> > loader from cpr-[exec/transfer] here?  The idea is that we'd want
> > vmstate_load_iochannel() then take that from an iochannel and start getting
> > rid of qemufile API.  It'll already bring two benefits:
> > 
> >    - We don't need this patch then I assume, but stick with iochannel API
> > 
> >    - We can have Error** as last parameter of vmstate_load_iochannel(), then
> >      as we discussed in the other thread cpr_state_load() can fail with
> >      explicit errors without error_report()s (and as you pointed out, the
> >      load side of Error** support is yet missing)
> > 
> > There's a 3rd potential benefit, and will come to play when we want to
> > allow multifd threads to load device states / VMSDs at some point, as
> > multifd doesn't maintain qemufiles, but only iochannels.
> > 
> > I'm not sure whether it adds too much to you yet, but I'm curious how you
> > think about it.
> 
> A decent idea, but the task quickly mushrooms.  All of the VMSTATE macros used
> in cpr.c would need to be converted, and that stack is deep. eg:
> 
>   VMSTATE_INT32
>     vmstate_info_int32
>       put_int32
>         qemu_put_sbe32s
>           qemu_put_byte
>             add_buf_to_iovec
>               qemu_fflush
>                qio_channel_writev_all

Right, right after I sent the email I noticed this too..

The chance is the new iochannel API only resolves whatever needed for cpr
early states, currently:

static const VMStateDescription vmstate_cpr_state = {
    .name = CPR_STATE,
    .version_id = 1,
    .minimum_version_id = 1,
    .pre_save = cpr_state_presave,
    .fields = (VMStateField[]) {
        VMSTATE_UINT32(mode, CprState),
        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
        VMSTATE_END_OF_LIST()
    }
};

static const VMStateDescription vmstate_cpr_fd = {
    .name = "cpr fd",
    .version_id = 1,
    .minimum_version_id = 1,
    .fields = (VMStateField[]) {
        VMSTATE_UINT32(namelen, CprFd),
        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
        VMSTATE_INT32(id, CprFd),
        VMSTATE_FD(fd, CprFd),
        VMSTATE_END_OF_LIST()
    }
};

IIUC, a summary of a few things only so far: UINT32/INT32, VBUFFER, FD.
Here FD is the new one, which we'll need to support that anyway, either
with the qemufile API or iochannel API.  Then the rest looks pretty
limited.  IOW, the new iochannel-based vmstate_load() doesn't yet need to
know anything else but these types of fields.  While I don't think I have a
full grasp yet on everything; that just sounds like the right direction to
go for the longer term.

Said that, as you said there can still be plenty of work there.  Steve,
feel free to think about it and take whatever approach you like.

Thanks,

-- 
Peter Xu


