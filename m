Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D18FEFB4F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvy32-0007AQ-Te; Fri, 27 Feb 2026 08:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vvy2j-00078u-GE; Fri, 27 Feb 2026 08:38:10 -0500
Received: from mailcow.dlhnet.de ([84.39.110.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vvy2h-0002yA-Jk; Fri, 27 Feb 2026 08:38:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8438946AD51; Fri, 27 Feb 2026 14:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlhnet.de; s=dkim;
 t=1772199475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tT2lx2tg+KXb6tGDnBEak4UUhZL1SanvxKa6yYCpRlQ=;
 b=sPPr6eWDwLGFj5MZ1I41zTGHRdzfdeH5Z9WVGtou5RDb8+t07SPyM8kaBcMIQVCP8p/fDe
 6MrwCQvH6b28i0VeFSYw29GcgDC3AIhR/npKRNLkMBb56Aj6Q/PyISzuY0KoM393Sgtwl6
 oyGr46TqJb1jIyEU86gh7Y7TC9lsy/ehKkNTwO//ErTqzfs0tKq+AFKG5Agag18H/O5TF/
 I4KaMgYGC1wK3ysOmTc4OIqocazTjforwpc3jTzGNZ9q8yX93RzF8rJmSRiXtJI1ehd6TJ
 BFu6Q8X78vOTW0Ijyw4ygLuGICdguaVBv5gPQDAIgtji7wR/TTu0l27zW0HvNw==
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: block/nfs.c and libnfs vs Fedora 43
From: Peter Lieven <pl@dlhnet.de>
In-Reply-To: <87bjha9yea.fsf@pond.sub.org>
Date: Fri, 27 Feb 2026 14:37:43 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Content-Transfer-Encoding: 7bit
Message-Id: <432BE3EA-839F-489E-A535-6A08427F8B86@dlhnet.de>
References: <20260224181440.832943-1-jsnow@redhat.com>
 <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
 <87bjha9yea.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Last-TLS-Session-Version: TLSv1.2
Received-SPF: pass client-ip=84.39.110.98; envelope-from=pl@dlhnet.de;
 helo=mailcow.dlhnet.de
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> Am 27.02.2026 um 13:14 schrieb Markus Armbruster <armbru@redhat.com>:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> [...]
> 
>> I guess for the moment we should fix the Coverity build
>> by dropping the --enable-libnfs (and accepting that we
>> don't scan block/nfs.c any more). For the longer term:
>> 
>> * does anybody want to update block/nfs.c ?
> 
> Plan A: somebody does that.

I can look into it next week. Does that still fit in the cycle?

Peter


