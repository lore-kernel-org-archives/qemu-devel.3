Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2B9E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXi0T-0001je-DN; Tue, 14 Jan 2025 09:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tXi0R-0001jM-3h
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:34:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tXi0O-0001hw-Sw
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736865295;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/RyYW2/0oWAA2gt9rtQHFdROrKN27W5WR8O76GrMRs=;
 b=SqZYNwh/WJVw6ItUhi4pAy6CKXFaH2ZXEOfYrvoQe72qL9eZkjO18BmwHlCN4UtX6uqT/U
 BAwzO7fLFJH5xpdljxzugnlX10N889f8D3BkDITOIfkwTt4GGySEmet5sXEdRq1OPdE42H
 QhFJ79M7jjQlriiAjUYv1BqFTaWz7as=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-uOP7SnQNO5C_hGHFsEinRw-1; Tue,
 14 Jan 2025 09:34:53 -0500
X-MC-Unique: uOP7SnQNO5C_hGHFsEinRw-1
X-Mimecast-MFC-AGG-ID: uOP7SnQNO5C_hGHFsEinRw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C94019560B0; Tue, 14 Jan 2025 14:34:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5702119560A3; Tue, 14 Jan 2025 14:34:49 +0000 (UTC)
Date: Tue, 14 Jan 2025 14:34:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Dave Hello <hsu@peterdavehello.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <Z4Z2BsF1QYSvjxqe@redhat.com>
References: <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
 <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
 <ZiCDzzFDRmQGPtDD@intel.com>
 <Fu0jQm-Z4E7D_J11oxIlfRJ9ZYK_QDKMYOs-9NNVX_jH9_aS5_9cyysois3SaVVtuTqR-H77MiwWLaa5RkPTEnCEdy0NvUmOuwqyirCbdhY=@peterdavehello.org>
 <5qJ0Q0ZnUCu-VdtMQOwzj54wLBfeXb9ozncO8PjFiOlXbu4RHQeVCZyn7ZMWq89yqqE7GZX3Bsuk9YqWugHmx-Wu4Oh1GZ5wboTuZ-QUk8k=@peterdavehello.org>
 <CAFEAcA8q5O1i-EDviKf-yN5DAsxsSofA3xa9ChMbn_tC91iNuw@mail.gmail.com>
 <Znmnr3XCiPM89Xag@redhat.com>
 <w0C7I-STdtazH_QTikLVqdGlKEDYBJd-xCkX1BXBPY-rRhhU6E0ARjv0_t9QiJpptsNzSJeGpotLRYaBMa2VGyucNEE9zOaCQ8YKWhGPlYk=@peterdavehello.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w0C7I-STdtazH_QTikLVqdGlKEDYBJd-xCkX1BXBPY-rRhhU6E0ARjv0_t9QiJpptsNzSJeGpotLRYaBMa2VGyucNEE9zOaCQ8YKWhGPlYk=@peterdavehello.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 14, 2025 at 01:45:03PM +0000, Peter Dave Hello wrote:
> On Tuesday, June 25th, 2024 at AM 1:06, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > We can't give legal advice, but the QEMU project doesn't do
> > > copyright assignment. Copyright remains with the original author
> > > (or with their employer).
> > 
> > 
> > While we can't give legal advice, going back to the original question
> > I have an observation that may resolve this.
> > 
> > IIUC, the orignal question was what to put at the top of the .po file
> > where it has:
> > 
> > # Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER
> > 
> > I don't believe the QEMU community has any stated requirement that every
> > file have a "Copyright" line present. Entirely omitting this line is a
> > valid choice from QEMU's POV.
> > 
> > What matters to QEMU primarily is that the file has a declared license
> > statement.
> > 
> > Any Copyright lines present are woefully inaccurate in most places, since
> > they're rarely updated despite 100's of contributors working on a file.
> > The respective contributors still retain copyright over their own work
> > regardless of what a 'copyright' line says or doesn't say.
> > 
> > IOW, the contributor (or their employer) may decide for themselves
> > a policy of whether to include or omit such a "Copyright" line, on
> > contributions submitted.
> 
> Thanks for the solution! So, to confirm, I will send PATCH v2 with the
> other metadata fixes but without the "Copyright" line. Is that correct?

Yes, that is acceptable.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


