Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8D2C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpgN-0001JJ-0f; Thu, 27 Mar 2025 12:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txpgF-00018y-Ae
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txpgB-0000py-W9
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743091322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JygwnAMXBsEKS5txt3cQn43ym86BDJ4XSiG/nBJ7ad8=;
 b=L11/fu1MqwQyOOXNrFpqPzX9H6d/JBInYbSmyU3p+VZCwBM95JkuXEZJLXcg0fXj9HAQnQ
 WRNpXWwIBQ9cavoQ1VuU04aFYJ9a1HS/5btT2XEA99uHAemUexqfoHNwk0Y1MeyTuU6nwl
 v2nRI4SUI079lBqFZXb/kfpAEk9TAcY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-2lJiLizeME-TsuDAAo9_jg-1; Thu, 27 Mar 2025 12:01:59 -0400
X-MC-Unique: 2lJiLizeME-TsuDAAo9_jg-1
X-Mimecast-MFC-AGG-ID: 2lJiLizeME-TsuDAAo9_jg_1743091318
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2c2c24379a1so920476fac.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 09:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743091318; x=1743696118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JygwnAMXBsEKS5txt3cQn43ym86BDJ4XSiG/nBJ7ad8=;
 b=OuU2Glsvbso5w68pTq3h6hpmq0L8KPVUXmntve9a5+29WoWAngv25cCbEuvjZ23xDQ
 7nL1rUqrAD+vrKxqY/nxZu3F4iaPzTN8wE6GNOjfmh2NlvoVk/LDozwKUZtsoTyGzS5h
 h/e7vw0ieArWZaaGsphwr4LKLvPB5TkXz6hOTOK9w2qw0VDtr5a3LfCYkAFw6Lmf4L4F
 ElTWQAJJkG9Fj3QrViJoHo75tODj3MlLUGfBg7YyfsEUO/yq8l/eBTYPnT1jIsPcGeSV
 uuLcx2fdAjTpPcVXj+h0M7vn9c3I9yeSk1vX/z8jYSmpRCNPzI1UG5QT9u7iIZxVRrgJ
 kdxA==
X-Gm-Message-State: AOJu0YyM3srfMo2RFsdkhdSL9hWegaz7UGxjoK/1Z/iAP4dA0jRXXqGF
 MXaVef3RcMd3SDzGLKc9YtssWotuVCMxRCzRgt4TjeMO5O3OXy8Qt/1lFAEWsKUGjQa9Plpxo4u
 ROP/T5Tt7ughFNtbNxdbQC7rCx+FuoChxQLF8cJA0LvKwHsYcJt6AiR8GHIVneWE6ok1+EneWed
 wbPdkVoWcbbN4jGSHzpEMK/n9b7GQ=
X-Gm-Gg: ASbGncvkN/ua58D5VJep/gJULoyT5eT35j2ecVAUe6tD7MiCmfn/SMaj9216aEoMaTW
 autVCiv2mGmPWqveCEaGv34Q2GKYHddIEkKHQj9etMFZyyQWGFv6Xh8KkzVPsM8++SCR+hb9ebJ
 I=
X-Received: by 2002:a05:6871:b13:b0:2a3:c59f:4cba with SMTP id
 586e51a60fabf-2c848018e3emr2330080fac.17.1743091318542; 
 Thu, 27 Mar 2025 09:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMwnqUYbo3dGDGbMM4VqUkyrGUpH7o2X+OOsyM5W4ZPCuOt6lhE+U+01GJcI5qyjqHwFOKcxfKafOFA2hAJjk=
X-Received: by 2002:a05:6871:b13:b0:2a3:c59f:4cba with SMTP id
 586e51a60fabf-2c848018e3emr2330060fac.17.1743091318134; Thu, 27 Mar 2025
 09:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <CAE8KmOwiyboWwyjV=gA=GqJSQxQKwm7uG=Jxh3Y1xnJEarYD=g@mail.gmail.com>
 <87friya6e6.fsf@suse.de>
In-Reply-To: <87friya6e6.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 27 Mar 2025 21:31:40 +0530
X-Gm-Features: AQ5f1JpD8Krdii16-35NJox_0k3-BZDHD4Xse7RznxvXXyYJCJv9B5nzNAKQ6ak
Message-ID: <CAE8KmOz_3QYE0MgxROKTGajNA5NVWzKKBmB0fsjOePbS2wrpWA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 27 Mar 2025 at 20:05, Fabiano Rosas <farosas@suse.de> wrote:
> I'll get to it soon. I need to send a PR for the recent SNP breakage and
> also check Li Zhijian's RDMA series first.

* I see, okay. Thank you for an update, I appreciate it.

Thank you.
---
  - Prasad


