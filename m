Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E974CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5xa-0005sx-VC; Fri, 12 Sep 2025 11:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5xQ-0005sC-CJ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5xO-0007Au-Ad
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757691898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tUCufxwZ2AHej4pahnX+D80DLAGkvHKj9tgPDx7yC4=;
 b=QE/4YV+02ny7xh5YEvCtavyHcHtiur5RmNJnZ0EosZEqKoR1WF4H69DgHDGjkp/KxwB0N1
 c0topK1teKXbYxfllmyj82giQM6F0UWdf+5+RWus4x3HMz32FuSY1UJ3JroZbYYXJSbNw+
 AL9MQ2PPGlvZUtZev5XzvqH5uiBLP2I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-HGsxw1xVN8KBsOp8cet3PQ-1; Fri, 12 Sep 2025 11:44:57 -0400
X-MC-Unique: HGsxw1xVN8KBsOp8cet3PQ-1
X-Mimecast-MFC-AGG-ID: HGsxw1xVN8KBsOp8cet3PQ_1757691897
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7671821d5a7so35046626d6.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 08:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757691897; x=1758296697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tUCufxwZ2AHej4pahnX+D80DLAGkvHKj9tgPDx7yC4=;
 b=pf4ZUYmFWVN1+/qeEEbmtzRWGmw1zTmw221ntNo7ZoTrdbu9MA6hYiqRljyladY7EB
 jhoLQ8+yTNvT7dGTAsb1kKAW7nKzWjdEBzQIaX5mxOXrboqs8G1v9hgP5H61KgIL2tX3
 BH7cXcBdYZLvRfzeu85scF6dc0/i6f5ZhkYx2p0yXSofUQWt4j9EqRWPLUFRkMbvih1a
 3UueXqdVbrFhxkdw/8ykePqVM/oXNbMwLH1hiop2RMqMCKPRV3fBa4N+GQDbOIJGDInc
 wS8Rci9hg/jYPg7UvTt9xx3XneFa4wTOPXyASoya6auL8auR48jR3K1Qp9cTNwykTrJU
 W3Pg==
X-Gm-Message-State: AOJu0YyN4P2ROXdRrcCON5/ffunf6oo80gNj1/8sBCC7bzfKzQIsixgI
 iZaE2DE6efJEz86PcRt6BIZ25f0EcvURaokS5ZIVfssNnyvHIRAJEFMGxiHdoei3IiElBkOIwkp
 aCiRUXUUn59a62/gzlEQVVylELSY/p/cxeKladV3lUs8KZbwL7YOdQQcA
X-Gm-Gg: ASbGnctttl+UfpADQwB9EmUA69IaxVX6KcOZEpCzuY760JrkmVh61iFK9AIWMTBITBn
 jZ1M57MjiR322om+LSfEewsFVqfKPU1hKblVSkhQLQ9mvgwjwRYWXpZ4LooMhuZwDWRpoRl7q7r
 Bv9oB4oW7Fg9/sX4czRlmSZUweec757c1ln3t7z7KFuNPhAc2bsPuZqhodU4VnRS3ewJGmihnk6
 F6WOB3wd+/AYvEwvzBy4ka3vG+08N7phi7YSKX7pGvAoNKJ4QMQa33/1KtpLrRnuS68fP9VlcR1
 t/0RraTVWUR9cO80JL7nM/KKNThwpEA7
X-Received: by 2002:a05:6214:1c09:b0:727:e45a:562c with SMTP id
 6a1803df08f44-767c5fc1237mr51504576d6.45.1757691896366; 
 Fri, 12 Sep 2025 08:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLW1odX3aZ/n3lLSGt/Q2HtgKjhuB3aEPNp+77FU6jUSBYcDBMHGuJF5YDscOaqCmA6Bk9vA==
X-Received: by 2002:a05:6214:1c09:b0:727:e45a:562c with SMTP id
 6a1803df08f44-767c5fc1237mr51504266d6.45.1757691896010; 
 Fri, 12 Sep 2025 08:44:56 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763b6800370sm29280926d6.33.2025.09.12.08.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:44:55 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:44:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
Message-ID: <aMQ_65_BybkbtZL4@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local>
 <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local>
 <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
 <aMB0BL5SEGfwjTFm@x1.local>
 <1a3c46b8-985e-4768-a3d1-e797370c0822@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a3c46b8-985e-4768-a3d1-e797370c0822@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 12, 2025 at 10:50:34AM -0400, Steven Sistare wrote:
> > > > How to guarantee src/dst device topology match
> > > > exactly the same with the new cmdline?
> > > 
> > > That is up to the mgmt layer, to know how QEMU was originally started, and
> > > what has been hot plugged afterwards.  The fast qom-list-get command that
> > > I recently added can help here.
> > 
> > I see.  If you think that is the best way to consume cpr-exec, would you
> > add a small section into the doc patch for it as well?
> 
> It is not related to cpr-exec.  It is related to hot plug, for any migration
> type scenario, so it does not fit in the cpr-exec docs.

IMHO it matters.. With cpr-transfer, QMP hot plugs works and will not
contribute to downtime.  cpr-exec also works, but will contribute to
downtime.

We could, in the comparison section between cpr-exec v.s. cpr-transfer,
mention the potential difference on device hot plugs (out of many other
differences), then also mention that there's an option to reduce downtime
for cpr-exec due to hot-plug by converting QMP hot plugs into cmdlines
leveraging qom-list-get and other facilities.  From there we could further
link to a special small section describing the usage of qom-list-get, or
stop there.

Thanks,

-- 
Peter Xu


