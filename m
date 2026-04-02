Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1760D3941B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Gkv-0001ud-6n; Thu, 02 Apr 2026 08:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w8Gkk-0001lZ-N3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w8Gkj-0000kc-34
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775131343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Pxz/OPi57ry9Bj2XHHaFHEGUPafxSc8b7cpaHG3E1E=;
 b=RjJ6keOxM5twr5jwnGuJ3yyRY+yUWLUp+Ty8OsuMJcezSh6IY3b0+zfuUrHhRsyfoH3uP6
 B4KELVztUdoZmtd3OyGLJizmyDvgs1VNALOm65pVqBP6DyMoeN9zYNHu5AELcZ2soXcj5e
 HWtuT+eBU+CNvY0z35N6Jybp7va3Fwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-aV0zlN8sMGqLVCQWkkOzDg-1; Thu,
 02 Apr 2026 08:02:18 -0400
X-MC-Unique: aV0zlN8sMGqLVCQWkkOzDg-1
X-Mimecast-MFC-AGG-ID: aV0zlN8sMGqLVCQWkkOzDg_1775131337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47E69195609E; Thu,  2 Apr 2026 12:02:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C79DB1800673; Thu,  2 Apr 2026 12:02:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 255B921E6A28; Thu, 02 Apr 2026 14:02:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?5pmP6b6Z6b6Z?= <yanlonglong@kylinos.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  John Snow <jsnow@redhat.com>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06?=
 Re: =?utf-8?B?5Zue5aSNOg==?= Re: [PATCH] hw/ide: resolve core crash
 caused by optical drive pop-up during virtual machine startup
In-Reply-To: <12lad3q1sjhp-12lfbr8gbnam@nsmail8.2--kylin--1>
 (=?utf-8?B?IuaZj+m+mem+mSIncw==?=
 message of "Thu, 02 Apr 2026 14:34:06 +0800")
References: <12lad3q1sjhp-12lfbr8gbnam@nsmail8.2--kylin--1>
Date: Thu, 02 Apr 2026 14:02:14 +0200
Message-ID: <87h5ptvad5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

=E6=99=8F=E9=BE=99=E9=BE=99 <yanlonglong@kylinos.cn> writes:

> Thank you for your reply=EF=BC=9A
>
> The crash occurred during startup of the virtual machine (Windows) and is=
 a recurring issue
> that frequently happens. I apologize for the inconvenience. Due to work c=
ommitments, I
> currently cannot reproduce the issue in a controlled environment. As this=
 incident occurred
> in 2022, the patch has been temporarily disabled. I sincerely admire your=
 dedication to code
> integrity.=20

Thanks for taking the time to send us a patch, and thus make us aware of
the issue.  It's a pity that you can't help us even more.

Take care,

Markus


