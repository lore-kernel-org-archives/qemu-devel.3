Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95928CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 19:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3fdE-0005Kb-QA; Tue, 30 Sep 2025 15:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3fdC-0005KP-2V
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3fd3-0000TS-9r
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759258987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KXR2e8ZOlqZJsX9hKL5XZK0C1fmCsWe6OtO4DMc2+0=;
 b=OF778Y9I9RfYX9lm80Tuuj+zSd5C+nxXQbcEe0GJGHOWAO+MUEMo6xHSYj9yAD+udp+a9q
 6ErXpvHcX1ihdVpUsMjoSO+jHCF+Ptntp5oq4NEyDmuOq3UFD+fK+MELmu6QOUu2zCZoxi
 TEwKCjiL+EuDTZMEdujRr1Hp/FgrBSI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-4xS9hIm1MYW868hUMa2ZyA-1; Tue, 30 Sep 2025 15:03:01 -0400
X-MC-Unique: 4xS9hIm1MYW868hUMa2ZyA-1
X-Mimecast-MFC-AGG-ID: 4xS9hIm1MYW868hUMa2ZyA_1759258981
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-718cb6230afso130162546d6.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 12:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759258981; x=1759863781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KXR2e8ZOlqZJsX9hKL5XZK0C1fmCsWe6OtO4DMc2+0=;
 b=tHl8zQr/HczYVhh1G9kNrlLt5N3ChUTbSK0EajERTl6hw1XZUQ7oS2FEGEc4t87PGV
 bnhfGUqxkapZO/oJj5n0AF/m5udvPmOuJ0221jpq6aWqTe9dkOlElMFaynsmiMz6Oap2
 OJv1xPWXgmDBSraR3dQtwT8zy6crgIsPoZawto8twklpt+3dy/8CyB4NJ/0+4N93yluM
 3VpAurixe6mashC8adfvFru606ImjjUCZ1q34Lq6bpGcqgxAftwtIDREzOrwV5jAd1Vh
 mMI5yBQvQhcmT0Gge2GgkJMsTlOyYJ1jm2u06JWVI+eKNDeA989oPmYj1/gVHaSY6C6B
 RUVw==
X-Gm-Message-State: AOJu0Yzl2S2WxUCL6z1smxsjMgDA9rsVn+tCkyuZGBlqOZU+Bwo9rHYa
 PuETNtK1ACvsn9KD7NAaPodvMkDxgPYrpgAAHcbe03KjinEHZ5EDPyoKg88GzVLsTl6hZh0o5lQ
 2tTHmR85d28tBQu1Z2s17AUgn+A28N2TjRmsEhAPR47omsX2DVkMgm0EW
X-Gm-Gg: ASbGncuHADyP+OFOLO7LejDm79gEusR7Oz3//VKUFqdl1wKr6PW3OPMvXAHH2googXn
 cgx82OLEDZIwnTwple/qCVynZi8LqgBhYJ182lPLjNA29quKue5TMq9ueLcIqiEck0kTs07csus
 8begnH9lND5wpSYQKq3thYdHoqtvkmAmPZ6i2U7jP89GNhCjeS1vXM5jFrAIL9bo8cp0f+QGFqM
 JjEKL+vMVnMp/lv3/yuZODbPTB+ZLXrY3RGtdIF9NGxyqNKkaOA/fkU2fp346mHAEsGZhXYLCce
 A0Zz/ixCmDCFDZrzDTKqDsk8vnpExz0zG+Tuuw==
X-Received: by 2002:a05:6214:1cc5:b0:829:18fe:7cc0 with SMTP id
 6a1803df08f44-873a547f28bmr12906846d6.35.1759258980696; 
 Tue, 30 Sep 2025 12:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Wd8CnfuhNnee/ZRnKYDQUf9kw2yoF4my0b6IbyA3qssJyXphI90EwEHBssHamQuOpOffjQ==
X-Received: by 2002:a05:6214:1cc5:b0:829:18fe:7cc0 with SMTP id
 6a1803df08f44-873a547f28bmr12906066d6.35.1759258980042; 
 Tue, 30 Sep 2025 12:03:00 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8016ce9a3c0sm98245026d6.53.2025.09.30.12.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 12:02:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:02:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V1 11/11] migration-test: test cpr-exec
Message-ID: <aNwpYiUpFwtTKcVi@x1.local>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-12-git-send-email-steven.sistare@oracle.com>
 <aNwOeCkXZpPtmPTF@x1.local>
 <c9a32330-56f7-4940-bdd4-9c87f24a0a2e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9a32330-56f7-4940-bdd4-9c87f24a0a2e@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 30, 2025 at 02:23:49PM -0400, Steven Sistare wrote:
> On 9/30/2025 1:08 PM, Peter Xu wrote:
> > On Fri, Sep 19, 2025 at 07:12:33AM -0700, Steve Sistare wrote:
> > > Add a test for the cpr-exec migration mode.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Looks good, only some nitpicks or pure questions below.
> > 
> > > ---
> > >   tests/qtest/migration/cpr-tests.c | 120 ++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 120 insertions(+)
> > > 
> > > diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> > > index 5e764a6..f33af76 100644
> > > --- a/tests/qtest/migration/cpr-tests.c
> > > +++ b/tests/qtest/migration/cpr-tests.c
> > > @@ -110,6 +110,125 @@ static void test_mode_transfer_defer(void)
> > >       test_mode_transfer_common(true);
> > >   }
> > > +static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
> > > +{
> > > +    g_autofree char *qtest_from_args = NULL;
> > > +    g_autofree char *from_args = NULL;
> > > +    g_autofree char *to_args = NULL;
> > > +    g_autofree char *exec_args = NULL;
> > > +    g_auto(GStrv) argv = NULL;
> > > +    char *from_str, *src, *dst;
> > > +
> > > +    args->start.hide_stderr = false;    /* omit redirection word from args */
> > 
> > It's default off, right?  Could I request for some more explanations?
> 
> Yes, the default is false, so I will omit this line.  I will change it to
> an assertion. (IIRC when I first wrote this code 1-2 years ago, the cpr-exec
> test was a derivative of a precopy common test that set hide_stderr=true).
> 
> hide_stderr must be false when deriving cpr-exec arguments because of
> this code in framework.c:
> 
>     if (!getenv("QTEST_LOG") && args->hide_stderr) {
>         ignore_stderr = "2>/dev/null";
> 
> ignore_stderr is appended to the command line.  For cpr-exec the command line
> may not include redirection, because we pass it to execv(), not to the shell.

Please kindly add this rich comment above the assertion..

> 
> > Could we also set it in test_mode_exec() directly if needed?
> 
> Yes, one can set hide_stderr when launching the source VM.
> 
> > > +    migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
> > > +    qtest_from_args = qtest_qemu_args(from_args);
> > > +
> > > +    /* De-dup spaces so argv does not contain empty strings */
> > > +    from_str = src = dst = g_strstrip(qtest_from_args);
> > > +    do {
> > > +        if (*src != ' ' || src[-1] != ' ') {
> > > +            *dst++ = *src;
> > > +        }
> > > +    } while (*src++);
> > 
> > Pure ask.. when will empty string be present?
> 
> migrate_args() format strings "%s %s %s" produce "   " when the arguments
> are empty strings.  Then g_strsplit("   ") would produce an array of 3
> empty strings.

... and here too.

Thanks,

-- 
Peter Xu


