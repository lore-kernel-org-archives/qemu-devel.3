Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB0DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMJv-0006Xk-53; Mon, 27 Jul 2026 10:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woMJt-0006Vi-5K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woMJr-0001xj-84
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785162518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=r7v8nnFKs47hKRCGAXMwpS5BGt9gAXeerW1OwSHnnlw=;
 b=M7F6vqod9qA7NMDVStjzD3rR7aiHENjZKhUmDFdGJ1m3tvR5wpmj+I7w4pxfoVUMCcJVIW
 rHscwD+8Yf+Bkjr95QfjoD6oXNbspIXIn2LUw0PHKGhZVON2KBo+7Y9O+uyGy0ppo9iQ6r
 R84qH6k+o3BKxy6AYeCUTplBk3tFNj0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-RZwdbVG3P5GpOVq6cyvljw-1; Mon,
 27 Jul 2026 10:28:34 -0400
X-MC-Unique: RZwdbVG3P5GpOVq6cyvljw-1
X-Mimecast-MFC-AGG-ID: RZwdbVG3P5GpOVq6cyvljw_1785162512
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 569361802663; Mon, 27 Jul 2026 14:28:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7380130010CC; Mon, 27 Jul 2026 14:28:30 +0000 (UTC)
Date: Mon, 27 Jul 2026 15:28:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: CVEs and the QEMU 11.1 release
Message-ID: <amdrClYAIAdtZ3_U@redhat.com>
References: <CAJSP0QVRaqb6Au+s-64bouKqu7S4yPoQiExUuL45MnAWAp5p8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QVRaqb6Au+s-64bouKqu7S4yPoQiExUuL45MnAWAp5p8w@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Jul 27, 2026 at 09:52:21AM -0400, Stefan Hajnoczi wrote:
> Hi,
> QEMU v11.1.0-rc2 will be tagged tomorrow and -rc3 a week after that.
> The project currently has a backlog of confidential and potentially
> CVE-worthy bugs. Maintainers are triaging these bug reports and fixes
> are being sent to the mailing list.
> 
> Holding up the QEMU 11.1 release for any and all CVE fixes is not
> realistic this time around since there are still a number of upcoming
> fixes expected over the coming weeks. Many CVEs are low severity and
> do not pose enough of a security risk to hold up the 11.1 release.
> 
> I'd like to approach CVEs as follows:
> 1. CVE fix authors and maintainers should indicate the severity in
> cover letters. This will ensure that serious CVE fixes are included in
> v11.1.0 while less serious CVEs do not hold up the release.
> 2. Low severity CVE fixes should go into the -stable branch if they
> cannot make it into v11.1.0.
> 
> I will be looking at CVE fixes on a case-by-case when -rc3 is tagged.
> If you feel a fix is critical, please let me know.

IMHO, we shouldn't do anything special wrt CVEs for the release.
Just follow our normal bug evaluation criteria which get increasingly
strict in later RC's, such that rc3 is largely just regression fixes.

No matter how many CVE fixes we might try to rush into 11.1, all
indications are that we're going to have countless more arrive
on an ongoing basis for a good while yet and just have to accept
that. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


