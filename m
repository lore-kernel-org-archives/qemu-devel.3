Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCCEC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVU73-0006hm-DW; Thu, 01 Feb 2024 05:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVU71-0006gu-KN
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVU6r-00019N-Er
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706782551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xNVfnr2cqQeh28tM8Rux0jDSBSgUgnXSvhL9gYHN0SU=;
 b=Pjr0KJaKz76sZco/oMJIHaLzXihNbCny3+sDJ3Ku6lhIGSjO1z+h4jd1XBpZWX7lBVGfwp
 2Xy08eg6T8HifX8y2+li1j4I6LfAu+Yp29Fykx3MlXIkVvsBfiYbmoDqioh0yvDqSQH9Fw
 hzdYH0j+qvGMv4kX96jaFAboGW2QBd8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-sBaJ0nK8P8aeOeIEm-y54Q-1; Thu, 01 Feb 2024 05:15:50 -0500
X-MC-Unique: sBaJ0nK8P8aeOeIEm-y54Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28c0765415eso163853a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706782549; x=1707387349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNVfnr2cqQeh28tM8Rux0jDSBSgUgnXSvhL9gYHN0SU=;
 b=jtCo3Cq/uzFmbY4976EnmLrDixpgP5WAdvu+mQgNG/xJ0VmYK62KE2E4Tp33HdGX+y
 W/C+No7lBv8frhj9MXJY2MdM5guSK1MSL14AEIeeld+QfcIx1tbJWB6MqZF9wujkz4R4
 BduqVj/FS7nEbHf6MlmLFfgMndlqy+vJ+03QDD11MC9H4vZR9n7H1xQtE6uIJ8lgMCer
 JfMP69I9HCWb70zT2aibJl+UMpGmV7LonbgDnv+hTUmLGHouhlYmDifUO7+w/Y5iOp6S
 eO2IvhWqc1IZXKAQSvL4X9DCSBG9mVldJ3O4o1fYYfo26ExTU5VlOal9h0tkI/helutx
 MjUA==
X-Gm-Message-State: AOJu0YyTFIVJFw1jrxXUpfS46vFgvvM5c7nQtv8/Bq7khn4sIhGiJMxB
 nObi5FsIPs+qQHs/7OMRKB2s1kLfSWeyh161IesDUEsHBfImvVDXf5CsQp3GdJpM1ljj23iLAVu
 l7pQRm8WMYcGitnTj76buZvLgbVPjSJFb0qi2qq7CgsxluywjKlvqIG48WP7sRcw=
X-Received: by 2002:a17:902:b190:b0:1d8:cc33:d7b4 with SMTP id
 s16-20020a170902b19000b001d8cc33d7b4mr4542333plr.5.1706782548846; 
 Thu, 01 Feb 2024 02:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0d1Bj36EOYhFZdMQJCfiO2dAyjX7z2OlECQpA95qoOWNBtID44Dv8UQqVsr0gbyYQ4H9FXw==
X-Received: by 2002:a17:902:b190:b0:1d8:cc33:d7b4 with SMTP id
 s16-20020a170902b19000b001d8cc33d7b4mr4542317plr.5.1706782548475; 
 Thu, 01 Feb 2024 02:15:48 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVTpDERGOBMXHXDdHFq5gaentv0yN9LiPa7xFvjrqW7CXhsLX7xV/ajWLlzB/fsASXXIQKlYuAD1jFwJOYbDOArG3saMtV/Hyb7e0uY9thue22djXsx/G4imNIyDSsJDIsqYTqCM5drW9L9/Q99hsfgZagYVOgua92W5CkmEkloW3byYZcTH2soprbNvujTNDfo2BbdFUuAK/n8FAzpv5I=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 bi9-20020a170902bf0900b001d7907eb711sm10542363plb.182.2024.02.01.02.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 02:15:48 -0800 (PST)
Date: Thu, 1 Feb 2024 18:15:40 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 13/14] migration/multifd: Move header prepare/fill into
 send_prepare()
Message-ID: <ZbtvTH92DTlb_7yv@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-14-peterx@redhat.com>
 <877cjpji1q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cjpji1q.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 31, 2024 at 06:42:57PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > This patch redefines the interfacing of ->send_prepare().  It further
> > simplifies multifd_send_thread() especially on zero copy.
> >
> > Now with the new interface, we require the hook to do all the work for
> > preparing the IOVs to send.  After it's completed, the IOVs should be ready
> > to be dumped into the specific multifd QIOChannel later.
> >
> > So now the API looks like:
> >
> >   p->pages ----------->  send_prepare() -------------> IOVs
> >
> > This also prepares for the case where the input can be extended to even not
> > any p->pages.  But that's for later.
> >
> > This patch will achieve similar goal of what Fabiano used to propose here:
> >
> > https://lore.kernel.org/r/20240126221943.26628-1-farosas@suse.de
> >
> > However the send() interface may not be necessary.  I'm boldly attaching a
> 
> So should I drop send() for fixed-ram as well? Or do you still want a
> separate layer just for send()?

Currently after the whole set applied, the IO side is pretty like before,
and IMHO straightforward enough:

            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                              0, p->write_flags, &local_err);
            if (ret != 0) {
                qemu_mutex_unlock(&p->mutex);
                break;
            }

IIRC with your file interface added, it could logically become something
like:

            if (use_socket()) {
                ret = qio_channel_writev_full_all(IOV, ...);
            } else {
                /*
                 * Assert "file:".  I forgot what we used to discuss here for
                 * the interface as name.. but I remember we need ramblock,
                 * so perhaps passing over "p" would work?  As then it is
                 * p->pages->ramblock, along with IOVs, etc.
                 */
                ret = qio_channel_XXX(p, ...);
            }

            if (ret != 0) {
                qemu_mutex_unlock(&p->mutex);
                break;
            }

So there's only one way or another.  We can add one helper to even wrap
these two.

IMHO a hook will be more helpful if there can be a bunch of "if, else if,
... else" things, so at least three options perhaps?  But if you prefer a
hook, that'll also work for me.  So.. your call. :)

But I hope if the send() will exist, it's a separate OPs, so that the
compiler accelerators should avoid worrying at all with how the data will
be dumped when they prepare their new MultiFDMethods (even though your
"file:" will need to block them all as of now, but only support no
compression, iiuc).

-- 
Peter Xu


