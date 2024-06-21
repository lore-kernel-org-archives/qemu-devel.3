Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0836CC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKf4G-0002x7-0X; Fri, 21 Jun 2024 10:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKf4E-0002rn-5Z
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKf47-0002jX-GJ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718979389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DD71SJ/2joTKGKYAAy6cWEabd3Hf61Nhx9rpWNOgxS4=;
 b=TA8WjVqw6vzdypwgZjAcuxFMw9ZtFtJMoUbE+pcHsGZrzHO6l+v6chisCIY81EYcxNposA
 i6fQqm5O8/q+N2eq/RSsXf2+7dg0eAWp89zbEYin077SQjFucsC0w+S76ARCINYYNUY6HH
 7F1DAyR4uyMNMshqiSkYyCxRDZ5Ai/w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Flc8ifJSNmq2cpWKhxPH6A-1; Fri, 21 Jun 2024 10:16:25 -0400
X-MC-Unique: Flc8ifJSNmq2cpWKhxPH6A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79560b25fc4so14802085a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718979384; x=1719584184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DD71SJ/2joTKGKYAAy6cWEabd3Hf61Nhx9rpWNOgxS4=;
 b=GVxL2sg/fZ3P7ocJu2r9WeQmHaT6B38CI/fL2ZkEzpdhALvEqD1ieDxRiC0drVqwLJ
 cz590j/qq7LegPV3PMS5rvUHRTlKxRR/EeCBNpLu36kheKqxSgJ0Fww7QmecOb5m4sJO
 uZcCKpaksrE8hHIowG2VpkhkXfuaxt5CsreCfeGViRuw6SywaHAHoY/eaa2ul53+u7TA
 q7oDEWUPM+nqTr4x5FcKItF6nywZeDfrxF7clz4vglo+LY5BwlH+iCdPr32tMXP1E8cU
 0Olad0p5mT+I8CUAuEHBUOJde/z7cQMkGKxdPXyW1nd00Na7JQA0/+6R75Uwjp6fhpBn
 kXyg==
X-Gm-Message-State: AOJu0YwzkpnPWkekmJgt2WUgo5H4UFRtnEDYQpm8w7JbFYbD3p8eUJHw
 LC5q6JeAolFOaYez4pMo2uOguVKs2yU1yV2uvdDLjPXjpJabMqOH5PzMjy4zkcqHc5hxQnaM1ey
 b6WrQwHZed/qkNSS5I01xorTXW4WO84zYNsIxaHeAHBIaWtbjeiL2
X-Received: by 2002:a05:620a:4709:b0:795:5ce3:a6d6 with SMTP id
 af79cd13be357-79bb3ee09d3mr902509385a.6.1718979384151; 
 Fri, 21 Jun 2024 07:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErEjGqsUMKh+VtuMnM+a7/E37wDUKb0p5hcHSaM/gVwmIt3jKpGI5r/s7BgEhPdAGwaaxU3g==
X-Received: by 2002:a05:620a:4709:b0:795:5ce3:a6d6 with SMTP id
 af79cd13be357-79bb3ee09d3mr902505185a.6.1718979383563; 
 Fri, 21 Jun 2024 07:16:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce9310cesm89331685a.106.2024.06.21.07.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 07:16:23 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:16:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 16/16] tests/qtest/migration: Add a test for
 mapped-ram with passing of fds
Message-ID: <ZnWLNFwBBMrFtaKk@x1n>
References: <20240617185731.9725-1-farosas@suse.de>
 <20240617185731.9725-17-farosas@suse.de> <ZnCOLGWajlKxtzfo@x1n>
 <87y16yiifn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y16yiifn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Jun 21, 2024 at 09:33:48AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 17, 2024 at 03:57:31PM -0300, Fabiano Rosas wrote:
> >> Add a multifd test for mapped-ram with passing of fds into QEMU. This
> >> is how libvirt will consume the feature.
> >> 
> >> There are a couple of details to the fdset mechanism:
> >> 
> >> - multifd needs two distinct file descriptors (not duplicated with
> >>   dup()) so it can enable O_DIRECT only on the channels that do
> >>   aligned IO. The dup() system call creates file descriptors that
> >>   share status flags, of which O_DIRECT is one.
> >> 
> >> - the open() access mode flags used for the fds passed into QEMU need
> >>   to match the flags QEMU uses to open the file. Currently O_WRONLY
> >>   for src and O_RDONLY for dst.
> >> 
> >> Note that fdset code goes under _WIN32 because fd passing is not
> >> supported on Windows.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> - dropped Peter's r-b
> >> 
> >> - stopped removing the fdset at the end of the tests. The migration
> >> code should always cleanup after itself.
> >
> > Ah, that looks also ok.
> 
> I made a mistake here. We still need to require that the management
> layer explicitly removes the fds they added by calling qmp_remove_fd().
> 
> The reason I thought it was ok to not remove the fds was that after your
> suggestion to use monitor_fdset_free_if_empty() in patch 7, I mistakenly
> put monitor_fdset_free() instead. So the qmp_remove_fd() was not finding
> any fdsets and I thought that was QEMU removing everything. Which is
> silly, because the whole purpose of the patch is to not do that.
> 
> I think I'll just fix this in the migration tree. It's just a revert to
> v2 of this patch and the correction to patch 7.

Ah OK.  I thought you were talking about when QEMU exit()s, which should
cleanup everything too.

Personally I guess I kind of ignored that remove-fd api anyway being there
or not, as it seems nobody understand why it needs to exist in the first
place..

-- 
Peter Xu


