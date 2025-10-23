Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3758FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 16:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxrf-0002Th-SN; Thu, 23 Oct 2025 12:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBxre-0002Sz-5y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBxrb-0007iA-Jn
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761235709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emKgf+ixC8r27qJlJld+gAlW7V25z8au4n0pcmPRN10=;
 b=NiWkgQrOJjT1Ky3zY+iXDADvTCafexxdXsfAb9pIDBFCA0eIheS0EtaLRI2S4OxKS9MGn3
 IwweqV3VCkKrYkS2Q0p4cXPT2f1OfgxiShlos851p4opw1bNevPwIDx30G4uyJ3iWXjKsi
 bsgvfsqDUeB+hLMLYHFBLqBWiq8S64M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Mu54Uti_P4OccR6579kA9A-1; Thu, 23 Oct 2025 12:08:28 -0400
X-MC-Unique: Mu54Uti_P4OccR6579kA9A-1
X-Mimecast-MFC-AGG-ID: Mu54Uti_P4OccR6579kA9A_1761235707
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e899262975so31116671cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 09:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761235707; x=1761840507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emKgf+ixC8r27qJlJld+gAlW7V25z8au4n0pcmPRN10=;
 b=MUHZ9GRnOGkL7xAFynR2864IAqq48dJFMwJHZ6seFoQ/vtS9PI0ySAi9uzRwYiYLbX
 QNVcziEWAQMlTwiAvNKWy9RVJKd7JuWDzwvjWQyoKSUdTKx/qXY+3ovcnorMkP+Z99zS
 2cyEqbZi98Xr6O8Sx/yGed70W/8er3VxIiLSN0/UMEEr8tpSS9GPMbMmWuyYt12oN/St
 Tm7vOuRzD8BIenCBXz2PfOOh1VZYnHK8tG7TTHA42LpkhFtCPigPuSDd+FUx/dceO/T2
 NbOiVJGasTJYqeEd40Gdm9xH2wSMxWp7qS2JJpCDMXMiPGG94UiC4b5f757hjTjW0Oz+
 tRBw==
X-Gm-Message-State: AOJu0Yy/88+hWOy2napWuWPbUho8TWYdyCHApho9MiTL7xveTwS15rFe
 qHFDXj8Xm1IzX8rGktHpaUcRhWbfRgpsJJkaGzUEPyon3Dwc2BTqQpsFyzcMMD3RCP+oyWwOp/I
 sT8qC1XUG2qtDSAlf7Nhhnj+hE86gPKiNvD3ROOd4j5nhIZzvDKXqOh8d
X-Gm-Gg: ASbGnctkbsmoAWi3h6M6vHqu9SgYG4oW4LUHOQR1c9/iYDdl4JoMiFAnc7d0h205sFY
 Pt903Eezk/eZVXBm7hXUOuhlss7cEPU8G6gg2/XxQoGUYtV9mffZj9Ix/LxHVuSNvMcm3HbhfT4
 8+O1OAGYBkBdQxqprqw0QAkFZhJJ/pjBTk7Ow/YZlilsEZS5mq25qhcripDuLp0o3eE3P5UtpTu
 g3Ui1cl1Mtfp9mANjAd+zJKnsqj2Aq1iNwU1QWsZOogptx7lgCpmCsE3VRSpLsFm1IQdDx+BoRZ
 hwzMOsRCM34ucJbCoZ1APPgCsZYkKIaucFP7QMovqjFObFByLygSzgUi1nfDvb5OYI4=
X-Received: by 2002:a05:622a:134c:b0:4e6:eb5b:be85 with SMTP id
 d75a77b69052e-4eb8107e2b2mr34778251cf.30.1761235707429; 
 Thu, 23 Oct 2025 09:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMmU5ULBCYNd8yjoBWTUR2k3fTCH+ABwu9ivLY5GsfiPo8J+kDORqUK6c+24kwyXQKxh/v5g==
X-Received: by 2002:a05:622a:134c:b0:4e6:eb5b:be85 with SMTP id
 d75a77b69052e-4eb8107e2b2mr34777781cf.30.1761235707008; 
 Thu, 23 Oct 2025 09:08:27 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80644f90sm16761081cf.13.2025.10.23.09.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:08:26 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:08:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 40/45] migration: cpr-exec-command parameter
Message-ID: <aPpS8mzennKZSAhu@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-41-peterx@redhat.com>
 <CAFEAcA9ecytcq3cUsYZiskv_hSDR4iO+iccbVYyRZgHaHMvUuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ecytcq3cUsYZiskv_hSDR4iO+iccbVYyRZgHaHMvUuw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 23, 2025 at 04:41:35PM +0100, Peter Maydell wrote:
> On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
> >
> > From: Steve Sistare <steven.sistare@oracle.com>
> >
> > Create the cpr-exec-command migration parameter, defined as a list of
> > strings.  It will be used for cpr-exec migration mode in a subsequent
> > patch, and contains forward references to cpr-exec mode in the qapi
> > doc.
> >
> > No functional change, except that cpr-exec-command is shown by the
> > 'info migrate' command.
> 
> Hi; I was doing a 'git grep' for accidental misuses
> of g_autofree on a char** (which will free only the
> top level array, not the strings it points to), and
> the usage in this commit confused me for a bit:
> 
> > +    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> > +        g_autofree char **strv = NULL;
> 
> g_shell_parse_argv() documents that we should free the
> vector with g_strfreev(), but g_autofree will only
> g_free() it. So this looks like a bug, but...
> 
> > +        g_autoptr(GError) gerr = NULL;
> > +        strList **tail = &p->cpr_exec_command;
> > +
> > +        if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
> > +            error_setg(&err, "%s", gerr->message);
> > +            break;
> > +        }
> > +        for (int i = 0; strv[i]; i++) {
> > +            QAPI_LIST_APPEND(tail, strv[i]);
> 
> ...we copy out the pointers to the individual
> strings here, and QAPI_LIST_APPEND() doesn't do a
> string copy, so it's correct that we don't g_strfreev()
> the char**.
> 
> Do you think it's worth a brief comment saying why
> g_autofree is correct here, or is it obvious enough
> without ?

It'll never hurt to have a comment indeed.  I'll send a patch, thanks for
raising this.

-- 
Peter Xu


