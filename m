Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B76ACEFC27
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCF4-0003Ib-29; Tue, 08 Oct 2024 11:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syCF3-0003IF-6y
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syCF0-0002Bz-0V
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728401710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ASd1KIkybKLAhuXAlAKpNWDB/Sj2ApGxiy9lArfsIFw=;
 b=KmBpA7WI3D9T2RFxpgE4eJWgFaTy77gUW/nzuPo56M/CiWMinrpvb/5SUTqkwHKamqc+k+
 ZAI6qbBrB40RX8IixIIaA4tffJRuayxBhbd0jcvNcEFz2lRojmhzy4TwYS5bQmoWFyONFn
 /HxYWMPNRfnxueYgopWCJEpKmZOPUII=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-cyfNxPtpOOWda1bATGNbUQ-1; Tue, 08 Oct 2024 11:35:09 -0400
X-MC-Unique: cyfNxPtpOOWda1bATGNbUQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7ac9b08cb77so1162154385a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 08:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728401709; x=1729006509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASd1KIkybKLAhuXAlAKpNWDB/Sj2ApGxiy9lArfsIFw=;
 b=kK9n2+lTwr5XwRedGk9MhUOANSZOsWcIEENa5+jFqbwKKkOqf3ZGOjxY0rw7SmcHGf
 HzXyz2a4MNDJlJf+k7IULLnuLczWSKtonXTh0ZMtTkDpm3HlBPCchjAcG1QuXgz4MsVT
 AZQTVoUXQpCuYK4Trmbvk8Q3irAZHWYqWkQr/hkyDFwMqHfSDqFznBA2Ej3eNkTPy79g
 j8I19UqlvIgsSOODJIypsvF6pg/zTJpKyhpumqun1ye0lP8la4NR5GVYZ9SpAHiqbIHz
 sF+/Q1zBubajVOWhtoajpUf7aJfdJ7MbC1pQRemeTtCjLgJsA9vvXwu3dnG0+zyd0N5v
 D7Vw==
X-Gm-Message-State: AOJu0Yykz8TulTLXuyEd9FpGGoanLzlTDNJxClgAll1Y43geBEJfmT+h
 amH6h7jnDRlU5VrqcYDaNUg+YU5IhRqUMPPFTqUev9KWtXNhfJOuyZqmRwlJZ59XmLEi33hvorI
 cdgwHO47zLNMHorwA2igG2SNBN/RhyDF9CjwNKXls/n/C3kClmCrw
X-Received: by 2002:a05:620a:1aa0:b0:7ac:b3bf:c30c with SMTP id
 af79cd13be357-7ae6f48ae1fmr2338432485a.45.1728401708645; 
 Tue, 08 Oct 2024 08:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQHFGWc0UMCOgVSVuTWGoubSyW21qk2jjrmJ9CONQUf3lawaRfiMnWJ+3nnSSCo8Tzy4306Q==
X-Received: by 2002:a05:620a:1aa0:b0:7ac:b3bf:c30c with SMTP id
 af79cd13be357-7ae6f48ae1fmr2338428585a.45.1728401708227; 
 Tue, 08 Oct 2024 08:35:08 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae756613c8sm361601385a.87.2024.10.08.08.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 08:35:07 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:35:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 04/13] migration: stop vm earlier for cpr
Message-ID: <ZwVRKKMYnfB1OqFQ@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-5-git-send-email-steven.sistare@oracle.com>
 <ZwP9ynimqzlmJ3uT@x1n>
 <17296eae-6d66-44c9-8355-39ad6a517a87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17296eae-6d66-44c9-8355-39ad6a517a87@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 07, 2024 at 04:52:43PM -0400, Steven Sistare wrote:
> On 10/7/2024 11:27 AM, Peter Xu wrote:
> > On Mon, Sep 30, 2024 at 12:40:35PM -0700, Steve Sistare wrote:
> > > Stop the vm earlier for cpr, to guarantee consistent device state when
> > > CPR state is saved.
> > 
> > Could you add some more info on why this order matters?
> > 
> > E.g., qmp_migrate should switch migration state machine to SETUP, while
> > this path holds BQL, I think it means there's no way devices got hot added
> > concurrently of the whole process.
> > 
> > Would other things change in the cpr states (name, fd, etc.)?  It'll be
> > great to mention these details in the commit message.
> 
> Because of the new cpr-state save operation needed by this mode,
> I created this patch to be future proof.  Performing a save operation while
> the machine is running is asking for trouble.  But right now, I am not aware
> of any specific issues.
> 
> Later in the "tap and vhost" series there is another reason to stop the vm here and
> save cpr state, because the devices must be stopped in old qemu before they
> are initialized in new qemu.  If you are curious, see the 2 patches I attached
> to the email at
>   https://lore.kernel.org/qemu-devel/fa95c40d-b5e5-41eb-bba7-7842bca2f73e@oracle.com/
> But, that has nothing to do with the contents of cpr state.

Then I suggest we leave this patch to the vhost/tap series, then please
document clearly in the commit mesasge on why this is needed.  Linking to
that discussion thread could work too.

Side note: I saw you have MIG_EVENT_PRECOPY_CPR_SETUP in you own tree, I
wonder whether we could reuse MIG_EVENT_PRECOPY_SETUP by moving it earlier
in qmp_migrate().  After all CPR-* notifiers are already registered
separately with the list of migration_state_notifiers[], so I suppose it'll
service the same purpose.  But we can discuss that later.

-- 
Peter Xu


