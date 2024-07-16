Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278ECC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 22:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTqGG-00013v-7z; Tue, 16 Jul 2024 18:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTqGE-00012t-Na
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 18:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sTqGC-00087a-9q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 18:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721167377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cv/FjYLayRabY0yqUIjYVpm7gsBAJppdBbf796829o8=;
 b=iTlFsFbpLo+DGAsmfzwnfkxa23ZQkZXhqWRhhYhjn/QKVO7GkmV+y68jvIwjaBmciJY+2t
 E2o2P+VHcIHooNiF1nUwCdlblQpwxKynGaPvIAfJdbyM+FX7nLd69b4uiJNdbYu10nOsyq
 raW1cGm/iMsDECrhYRioQ72z0GE0FgI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-AucIkm9nNH6cUPU2zUoHug-1; Tue, 16 Jul 2024 18:02:55 -0400
X-MC-Unique: AucIkm9nNH6cUPU2zUoHug-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b7678caf7dso9085136d6.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 15:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721167374; x=1721772174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cv/FjYLayRabY0yqUIjYVpm7gsBAJppdBbf796829o8=;
 b=wAH+BtfRNYgKtwhRGvJDdqRTDDIxSl6mYRU647oBNa7FP+UX8VKGvkJ8TUfA2rbe0z
 K9Q8HgXVyoxEPoLSrwqiSJly1Ah8z7hu2doi/NL2Pf5OMkfsUDNrUdAg12CQ+3D8WkEO
 tsESS2rxQrg/c1Rh/+clJk7qAYPQYaIzbbTC9wJratJqytN3U/JT66ci5AM8UjyW2izj
 a9WGCR2GCz6xOrmExMILUhsVhNp+oUkL1oy9dZV37ar35R+Ea0IvgGcAFQcpmT8cTnlh
 JPwk4GfHbWG5AoH1zRL5j2HS+eDbbuRZ4rDEjitk4FJgcOtzU1lEkB0iI7cc+0eekwKG
 /R1w==
X-Gm-Message-State: AOJu0Yxyug1Ss40WWjWPaUiJg3QHFct9i6BJhqi4olDW20fUnPe7zoQP
 4QduoLiuwQWu1dL/SZFAzu65H34PiLrLgabAUodWDJ4RssRpabvYxnNgMG/hCrwG5h9jPX7bFIR
 qWV4bxoorWp1J8c/DHtAQRFqxVOQEyrWu108MPj5QGVAek7pjJtUD
X-Received: by 2002:a05:6214:31a0:b0:6b7:586c:6d9 with SMTP id
 6a1803df08f44-6b77df58959mr31330116d6.7.1721167374043; 
 Tue, 16 Jul 2024 15:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJpvf9HiboJVKafLxAlaB9Q9GVttPomJSItLo1BWv7OMhN7GMCwteaSUlfpG4Umk1EZAwpbA==
X-Received: by 2002:a05:6214:31a0:b0:6b7:586c:6d9 with SMTP id
 6a1803df08f44-6b77df58959mr31329936d6.7.1721167373686; 
 Tue, 16 Jul 2024 15:02:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b764654cb7sm33881246d6.55.2024.07.16.15.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 15:02:53 -0700 (PDT)
Date: Tue, 16 Jul 2024 18:02:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <ZpbuChi9QMIogmuS@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Jul 16, 2024 at 03:44:54PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Mon, 15 Jul 2024 at 19:10, Peter Xu <peterx@redhat.com> wrote:
> > IMHO it's better we debug and fix all the issues before merging this one,
> > otherwise we may overlook something.
> 
> * Well we don't know where the issue is, not sure where the fix may go
> in, ex. if the issue turns out to be how virsh(1) invokes
> migrate-postcopy, fix may go in virsh(1). Patches in this series
> anyway don't help to fix the migration convergence issue, so they
> could be reviewed independently I guess.

I still think we should find a complete solution before merging anything,
because I'm not 100% confident the issue to be further investigated is
irrelevant to this patch.

No strong opinions, I'll leave that to Michael to decide.

> 
> > You could pass over the patch to whoever going to debug this, so it will be included in the whole set to be
> > posted when the bug is completely fixed.
> 
> * Yes, this patch series is linked there.
> 
> > The protocol should have no restriction on the thread model of a front-end.
> > It only describes the wire protocol.
> >
> > IIUC the protocol was designed to be serialized by nature (where there's no
> > request ID, so we can't match reply to any of the previous response), then
> > the front-end can manage the threads well to serialize all the requests,
> > like using this rwlock.
> 
> * I see, okay. The simple protocol definition seems to indicate that
> it is meant for one front-end/back-end pair. If we are dividing the
> front-end across multiple threads, maybe we need a document to
> describe those threads and how they work, at least for the QEMU
> (front-end) side. Because the back-end could be a non-QEMU process, we
> can not do much there. (just thinking)

IMHO that's not part of the protocol but impl details, so the current doc
looks all fine to me.

Thanks,

-- 
Peter Xu


