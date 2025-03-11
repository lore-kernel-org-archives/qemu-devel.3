Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9992C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5jZ-0000Zz-AI; Tue, 11 Mar 2025 15:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts5jX-0000Z7-8j
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts5jV-0008P5-5C
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741723062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0fWyJKANi9tq6qSwieIQlooH0jgt6Lz2x1eq98tNGs=;
 b=UL/KblVW4f3bmR5GgcZ9wXikJsN6FXaEJlHAKaOAWXRSJv+OUzA31YKWBZLxmc/2F720dM
 sZVjiMso5sZS9xD4LMCrT5G0l99TlG9hnfHAu81zNHJJUPZEynkN8fxiIOt6Kk9uEbjr9n
 BAsFcadWd1yGG25tVviDBwHydsmBcro=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Lu3K3MQzOWKFwizZusrqEQ-1; Tue, 11 Mar 2025 15:57:40 -0400
X-MC-Unique: Lu3K3MQzOWKFwizZusrqEQ-1
X-Mimecast-MFC-AGG-ID: Lu3K3MQzOWKFwizZusrqEQ_1741723060
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e91ee078aaso46216256d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723060; x=1742327860;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U0fWyJKANi9tq6qSwieIQlooH0jgt6Lz2x1eq98tNGs=;
 b=I/5fo8sjRMhKdFYtLH3sb9hums5hqF4R1CFXI+V37AVcyxp3UoZQo4+XGTxW8psjUp
 NjXt0EoWzeLtt76Wh7KYzwiXeieDhck1wM5tg+xagZcIrsqU0rQTcOITMOcZhshKmkSq
 w0vOp7HLNjdudCzbAPGi3lAQdFZlT/+Vw/CFNxKrb7XqLtdlHAYrMpN9+gdrTA4M+K8L
 o989s6Gcsg5UTme4FzpsfiQ2MO33iyXzWF/uklLbaJeaJa5ZuIALmsMFELXUuO0rnpPg
 7Cl0dJtnb9xRLROHQHJLTfU6KunQNcxy+kX9iIaT6RM1ow2WbINTgoLOdL2csc5FqPqe
 U94w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNyFWxCC5iLVRUTn/EjgiE7KVzv59deMn997PNUW2fbEHpW4RYkYU7/98dOWiq9ma7QEd8zPnUDJuw@nongnu.org
X-Gm-Message-State: AOJu0Yy+bHfcyba7AcaouQctLtypWD7CHET7y98uBmUnOqjTs+B9jzUP
 CL7vxDpDJRWUoIBf1ReFZ4Euf768LBTxdpy7NHEsChIcFV8nYPCb0F1B+ekEQw606PMJEfb7dLg
 WqJxg7JwOU0fS777E/WFOkL80+ADTym+kGmREPYzTvgU17GTF+f1P
X-Gm-Gg: ASbGncuKSj0fGtAqfS1W1dLcQRhPAU+d8gs+zACc36rYseDX1FWTZZc8VtDVw27F+i7
 XAJPkRrpAJlPbrCdVLrNgxJLKjzp7i8pr3AHyxHbYdi6EYO1CaqZSkJJzs4eDbcwPzhK6H1HvAK
 fjSZq4TqroZFqL1ygyJfcr3JmbuieL7/jKLurwigKgwL8fCmr08kdViTLT3ANXKRz42tUMOvJo+
 8Aa/yAoPEEA9H+NiOg8FZQ3/hFhQocIphrcAsuNsyCnM2pcTZOKkfjhUuClOLhZV/hFDHCkr283
 hSZhpEM=
X-Received: by 2002:ad4:4eed:0:b0:6e6:6bd8:3a86 with SMTP id
 6a1803df08f44-6e9005be42bmr245266006d6.6.1741723059891; 
 Tue, 11 Mar 2025 12:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGktBnzMsP3XzHrzPcVjNMwk97RfA6EuguQryRS5a9gJaxkmiaiLPEYFhMPrWjbCdY17rYuuQ==
X-Received: by 2002:ad4:4eed:0:b0:6e6:6bd8:3a86 with SMTP id
 6a1803df08f44-6e9005be42bmr245265676d6.6.1741723059505; 
 Tue, 11 Mar 2025 12:57:39 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7182af0sm75255626d6.119.2025.03.11.12.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:57:38 -0700 (PDT)
Date: Tue, 11 Mar 2025 15:57:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, farosas@suse.de, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z9CVr9jbcq810U2i@x1.local>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local> <Z8_wnLIlfhM7bILZ@redhat.com>
 <Z9BU0gd3BLPhBss2@x1.local> <Z9BXw6iZfi_UKx-t@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9BXw6iZfi_UKx-t@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 11, 2025 at 03:33:23PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 11, 2025 at 11:20:50AM -0400, Peter Xu wrote:
> > On Tue, Mar 11, 2025 at 08:13:16AM +0000, Daniel P. Berrangé wrote:
> > > On Mon, Mar 10, 2025 at 04:03:26PM -0400, Peter Xu wrote:
> > > > On Mon, Mar 10, 2025 at 07:48:16PM +0000, Daniel P. Berrangé wrote:
> > > > > Given this is in public API, the data needs to remain reported accurately
> > > > > for the whole deprecation period. IOW, the patch to qiochannel needs to
> > > > > preserve this data too.
> > > > 
> > > > :-(
> > > > 
> > > > We could potentially mark MigrationStats to be experimental as a whole and
> > > > declare that in deprecate.rst too, then after two releases, we can randomly
> > > > add / remove fields as wish without always need to go through the
> > > > deprecation process, am I right?
> > > 
> > > IMHO that would be an abuse of the process and harmful to applications
> > > and users consuming stats.
> > 
> > Ah I just noticed that's the exact same one we included in
> > query-migrate.. Then yes, the stable ABI is important here.
> > 
> > So for this specific case, maybe we shouldn't have exposed it in QMP from
> > the start.
> > 
> > To me, it's a question on whether we could have something experimental and
> > be exposed to QMP, where we don't need to guarantee a strict stable ABI, or
> > a very loose ABI (e.g. we can guarantee the command exists, and with
> > key-value string-integer pairs, nothing else).
> 
> QMP has the ability to tag commands/fields, etc as experimental.
> 
> libvirt will explicitly avoid consuming or exposing anything with
> an experimental tag on it.
> 
> > Maybe what we need is a new MigrationInfoOptional, to be embeded into
> > MigrationInfo (or not), marked experimental.  Then in the future whenever
> > we want to add some new statistics, we could decide whether it should be
> > part of stable ABI or not.
> 
> That is not required - individual struct fields can be marked
> experimental.

Yes that'll work too.  The important bit here is I think we should start to
seriously evaluate which to expose to QAPI as stable API when we add stats
into it.  We used to not pay too much attention.

With MigrationInfoOptional, we should suggest any new field to be added
there by default, then whatever needs to be put out of experimental needs
explicit justifications.  Or we can also document any new migration field
at least in the stats to be marked as experimental unless justified.

> 
> The key question is what the intended usage of the fields/stats/etc
> is to be. If you want it used by libvirt and mgmt apps it would need
> to be formally supported. If it is just for adhoc QEMU developer
> debugging and doesn't need libvirt / app support, then experimental
> is fine.

To my initial thoughts, I want Libvirt to fetch it.  However I don't want
Libvirt to parse it.

For example, for things like "whether zerocopy send succeeded or not", or
"how much time we spent on sending non-iterable device states", they're
almost not consumable for users, but great for debuggings.  It would be
great if Libvirt could know their existance, fetch it (e.g. once after
migration completes) then dump it to the logfile to help debugging and
triaging QEMU issues.  In that case parsing is not needed, the whole result
can be attached to the log as a JSON blob.  That releases the burden from
the need to maintain compatibility that we don't really need and nobody
cared (I bet it's the case here for zerocopy stats, but we got restricted
by our promises even if it may ultimately benefit nobody..).

Thanks,

-- 
Peter Xu


