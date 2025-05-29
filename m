Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AA1C5B549
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 15:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKfKl-0002Gz-PW; Thu, 29 May 2025 11:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKfKj-0002DO-Vc
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKfKh-0007MA-PH
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748533092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0jIH4b8p4YnvmK9bYlT7Quz1yUT3ho3PCx89bNdAbgI=;
 b=EVu7iC0Mwsh0runXfinS8oiYqpowx+u/qagzccXDKeG75D1/hhEc6ZK5m8gppnimxUARV3
 o5HjjMhFcHfULqr751RRNLwoeUYfWdBUFCvJBtPSWvS9DUlTeTjTVHU2/cuST6lSFGG3tb
 Hb1H3KYgUgy3eS7hsERRuihmwrxnnfY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-rlwsmAvHO1CKnDFsd5F8Ng-1; Thu, 29 May 2025 11:38:09 -0400
X-MC-Unique: rlwsmAvHO1CKnDFsd5F8Ng-1
X-Mimecast-MFC-AGG-ID: rlwsmAvHO1CKnDFsd5F8Ng_1748533089
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7d0981315c8so123176085a.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 08:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533088; x=1749137888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jIH4b8p4YnvmK9bYlT7Quz1yUT3ho3PCx89bNdAbgI=;
 b=lk3WTNaTguTTEqLwITogR6PNHoVqxtK1fvgQ7ui3B2adSmf4lOF/f5OA3jvvOjWMmY
 GDoc+Z1BijsIqwop7rvIXw3Xvpurh0KZd/Rxcbw0skSouUJj0OD0+5rCf5KJyKRaLfhZ
 5ef/CcYYZ2h/eldEodhwFE8f6KdSc6uzCBwliyvnJr3ZqGNDUGSFy2VNdQNRk+Aq3ar0
 fP6GR6U+i0fREuTM0zDFQTJJBMQnQR1rXuhPQ6Jb+ayAaImxvj0RWabF6XZ2h5Kkpi5J
 kyd2dlw64UM5UI2U1nczJSGVqhlkCEqB0o4x3hckLi2pI47Rgrj6tsDQsKPBYaSzdCOp
 CuOQ==
X-Gm-Message-State: AOJu0Yz2uh+81p0UHGU408zhAwkdrtpWk+SPEjzjC9Cutdy+cyQabX4V
 znrtFlBqiLney3JaP8sIjrXMzCWPdWIKKaCNXmAzcWo463fFYzbDiMmEPJ76nQeUQC60nW2iTY0
 vBg/EuPDSDS5i1iljy/A0QdrxObZ9lc9RQ708DdYUF326A3U8wVRQGiHh0AgTZHX8
X-Gm-Gg: ASbGncvU+p/lsea3Er3o5SfthDKJ9+XfepGS0S7gvmv2gIH+fF6le01yQDIBw2w2nBk
 0erhupT5j1swch2C5D6p3aqq95+sFZjdO2O0Gveea+wMYeJbkAaalVOTfV0e7WaSPPY5UfagpaE
 Mgdf20hgtLdpP4THumVEbx8+7aW9oFjwLDCfK3up2LSaI4kGPrZR7OzdrekZh/L+k9JX5pwL5iG
 CgAeeRYh1OZ7l4y3Dhu9wfP1HaJ1R0TrgnOW4Ko9y7ezpIpfeidtKLl1Q5QWOTU3hsXt7JfOzyS
 EDg=
X-Received: by 2002:a05:620a:1917:b0:7d0:a119:23e7 with SMTP id
 af79cd13be357-7d0a1192630mr110279385a.1.1748533088422; 
 Thu, 29 May 2025 08:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6C32VBgmDyFHO8FRlOhrE7IJ9pfkquFfvb7tFRoKBVU9wnYPwXhvfuSuHVe+Mjxovcr9F8A==
X-Received: by 2002:a05:620a:1917:b0:7d0:a119:23e7 with SMTP id
 af79cd13be357-7d0a1192630mr110274485a.1.1748533087925; 
 Thu, 29 May 2025 08:38:07 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a0e3fa9sm106459085a.24.2025.05.29.08.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:38:07 -0700 (PDT)
Date: Thu, 29 May 2025 11:38:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 05/11] migration: Drop save_live_complete_postcopy hook
Message-ID: <aDh_XCVUJnnAuuQy@x1.local>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-6-peterx@redhat.com>
 <tew2ucyvg2z37rn6fvzwg6kj44crycegpc5jt4kd7unnyy3oqw@qaqb6towtfev>
 <hvfstra4oagwc5m6vojy5lpe5ro3qhjp7mr7sbawjwds7dxuyc@w656gwmgvs4i>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hvfstra4oagwc5m6vojy5lpe5ro3qhjp7mr7sbawjwds7dxuyc@w656gwmgvs4i>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

On Thu, May 29, 2025 at 04:48:41PM +0200, Juraj Marcin wrote:
> On 2025-05-29 16:42, Juraj Marcin wrote:
> > Hi Peter

Hey, Juraj!

> > 
> > On 2025-05-27 17:58, Peter Xu wrote:
> > > The hook is only defined in two vmstate users ("ram" and "block dirty
> > > bitmap"), meanwhile both of them define the hook exactly the same as the
> > > precopy version.  Hence, this postcopy version isn't needed.
> > > 
> > > No functional change intended.
> > 
> > Could be some future users, that would benefit from separate hooks for
> > precopy and postcopy?

There's nothing that I'm aware of.  Normally we should only provide
separate hook until that comes, and then review the hook together with the
use case.

> > 
> > In case we are going to drop it, I think the '_precopy' suffix could be
> > dropped too, as the handler would be used for postcopy too.
> 
> Never mind, just noticed it's in the next patch...

Yep.  I can squash that into this one; it's pretty small so maybe it's
fine.  I'll keep it separate as of now, but if anyone thinks it better I
can squash them.

-- 
Peter Xu


