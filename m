Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F8C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPNs-0005GJ-Eb; Mon, 29 Jan 2024 06:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUPNq-0005G8-Br
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUPNo-00033b-KB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706526055;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ICqpDjlFoeKseO6nJMjb+3PWjTz6YYWwDU4kh1QrYJU=;
 b=O7dvNDf4hSPlVrdQCfCaKOnswZKbYvI9/BNEV7iio8xic2IfBpWQZtS9nQZVcefrZd0R9E
 khgi4tTodaCDtNVbNq7SSOgvmYStDwM55HpLNWyTdzo9hSYjODlGeVO/elb6inod8JfiOO
 GJ78l9TJOFJ/jwa99hPWfuuVyflIzmI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-ctXAcI5cOgeS-IUc4EC7dQ-1; Mon,
 29 Jan 2024 06:00:52 -0500
X-MC-Unique: ctXAcI5cOgeS-IUc4EC7dQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FD6829AA390;
 Mon, 29 Jan 2024 11:00:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93BF840C9444;
 Mon, 29 Jan 2024 11:00:48 +0000 (UTC)
Date: Mon, 29 Jan 2024 11:00:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Tardieu <sam@rfc1149.net>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZbeFXkjw4B5Nb6qd@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <ZbUU6CTgxgCLG0a9@intel.com> <ZbdwhR6h6T97vR8J@redhat.com>
 <8734uglbe5.fsf@rfc1149.net>
 <CAFEAcA-JMCj2wVRv0JmDmmmLZiMDa1PZ2yU1QUpgiJxnaVQJ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-JMCj2wVRv0JmDmmmLZiMDa1PZ2yU1QUpgiJxnaVQJ_w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 29, 2024 at 10:41:38AM +0000, Peter Maydell wrote:
> On Mon, 29 Jan 2024 at 09:47, Samuel Tardieu <sam@rfc1149.net> wrote:
> > However, this is not what QEMU has been using as far as I can see,
> > as S-o-b tend to stay in their original positions. I even opened
> > an issue on b4 a few weeks ago because of this
> > <https://github.com/mricon/b4/issues/16>, and I reverted to using
> > git-publish. But if this is ok to use an arbitrary order for
> > non-S-o-b headers, I can get back to b4.
> 
> I think QEMU doesn't have a specific existing practice here.
> What you see is largely the result of people using whatever
> tooling they have and accepting the ordering it gives them.
> So I don't think you should stop using b4 just because
> the ordering it happens to produce isn't the same as
> somebody else's tooling.
> 
> I think trying to impose some subtle distinction of meaning
> on the ordering of tags is not going to work, because there
> are going to be too many cases where people don't adhere
> to the ordering distinction because they don't know about
> it or don't understand it.
> 
> As Daniel says, as long as the Signed-off-by tags are
> in basically the right order for developer vs maintainer
> that's the only strong ordering constraint we have.

To think of it another way....

Signed-off-by is the only tag which has defined legal meaning
in terms of asserting that the people involved have permission
to contribute.

All the other tags (Reviewed/Tested/etc) are merely a historical
record of the development process, and have no legal implications.

This makes Signed-off-by the important one, and the others all
in the "nice to have" category.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


