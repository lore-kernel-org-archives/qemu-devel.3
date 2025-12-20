Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE6FE668AF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 07:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWqym-0006Po-8y; Sat, 20 Dec 2025 02:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWqyh-0006Oi-7O
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 02:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWqyf-0003ZU-Qn
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 02:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766214129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r8GmXXJVGSvqH/mXF5iW9X3tMCYUct1UQNzlmPRa6Gk=;
 b=LEZx7onmwcP/lggDqz502DJNct5xPEZOzv7eKrNx8AqKfledhJoiwUMrSTR+NmyjZ7ixYA
 OTfbg97aVS9yX5xfXpdUyvIqIrCa9Zs1+xx+1Ow37TFe6e5exYOgzwmZIRgiQozCfr7LFI
 19Oig9e0K9CAgJy4ffsA5fd6amfBJ20=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-pTCC3cQKNRWGPYkQ6AlN0Q-1; Sat,
 20 Dec 2025 02:02:04 -0500
X-MC-Unique: pTCC3cQKNRWGPYkQ6AlN0Q-1
X-Mimecast-MFC-AGG-ID: pTCC3cQKNRWGPYkQ6AlN0Q_1766214124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80733195DE48; Sat, 20 Dec 2025 07:02:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8CEC1800669; Sat, 20 Dec 2025 07:02:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91BD821E6A27; Sat, 20 Dec 2025 08:02:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: MAX78000 machine needs a maintainer
In-Reply-To: <CAMyd1rQ6CLN2FPic=4pNpZtcw46io2xftkBDSLfd8V9S+Jyu0A@mail.gmail.com>
 (Jackson Donaldson's message of "Fri, 19 Dec 2025 15:59:49 -0500")
References: <87ike27ucd.fsf@pond.sub.org>
 <CAMyd1rQ6CLN2FPic=4pNpZtcw46io2xftkBDSLfd8V9S+Jyu0A@mail.gmail.com>
Date: Sat, 20 Dec 2025 08:02:00 +0100
Message-ID: <878qex3ac7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jackson Donaldson <jackson88044@gmail.com> writes:

> Hello,
>
>> You added the MAX78000FTHR machine in the v10.1 development cycle.
>> Would you be willing to serve as its maintainer?
>
> I don't think I'm a good choice for a maintainer. I no longer have access
> to a physical MAX78000FTHR to verify against, since submitting those
> patches I have joined a company with a restrictive IP agreement, and I'm
> fairly low on time in which I could contribute.
>
> - Jackson Donaldson

Thanks for your quick reply!  Would've been nice to have you onboard.

Out of curiosity, what was your motivation to add the machine?


