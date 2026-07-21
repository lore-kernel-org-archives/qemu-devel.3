Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A4FC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmABh-0006VC-0A; Tue, 21 Jul 2026 09:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmABf-0006V2-F6
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmABd-00039k-3U
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784639223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R932s6TjcSVK7BiTrudQuD5BEr/QfJkBc8GItSWdBk4=;
 b=LYz/nVKmLQqvzvWNevfFfP42JWD0v1cEs6KXOyNgkRvya2QAaj4kXRzw8Kqa1jKsXgslRk
 kmylZyPAOrQ+CHr9X867MD46DNOMOtMctEJTVOpE124H1LEQguq14sCsICuInClrrf0ab+
 Je7aV2oRX3nM5DtgCDRXd7IIw+hRLnM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-a_hzDTsVNviYfSBF0kpKPA-1; Tue,
 21 Jul 2026 09:06:59 -0400
X-MC-Unique: a_hzDTsVNviYfSBF0kpKPA-1
X-Mimecast-MFC-AGG-ID: a_hzDTsVNviYfSBF0kpKPA_1784639218
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 263C018005B1; Tue, 21 Jul 2026 13:06:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8D31955F74; Tue, 21 Jul 2026 13:06:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE8D821E6920; Tue, 21 Jul 2026 15:06:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] qemu-options: document
 keep-alive-count/idle/interval for -netdev stream
In-Reply-To: <20260720053333.2316643-1-Mitsuru.Kariya@oss.nttdata.com>
 (Mitsuru Kariya's message of "Mon, 20 Jul 2026 14:33:33 +0900")
References: <20260524073442.435408-3-Mitsuru.Kariya@oss.nttdata.com>
 <87y0gx8sld.fsf@pond.sub.org>
 <20260720053333.2316643-1-Mitsuru.Kariya@oss.nttdata.com>
Date: Tue, 21 Jul 2026 15:06:54 +0200
Message-ID: <87ldb4o5jl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com> writes:

> Thank you for reviewing, and I'm sorry for the late reply.
>
> Markus Armbruster <armbru@redhat.com> writes:
>> You document these options only for -netdev stream.  They also work
>> for -netdev dgram, possibly more (didn't check).  Shouldn't we
>> document them every where they work?
>
> As you pointed out, options such as keep-alive* are accepted by -netdev
> dgram as well. However, since these options are TCP-specific, they have
> no effect on sockets created by -netdev dgram.
> In fact, while these options are applied to sockets in
> inet_set_sockopts(), it is only called from inet_connect_saddr() and
> inet_listen_saddr(), which are for TCP, and not from inet_dgram_saddr(),
> which is for UDP. (I also confirmed this with strace.)
>
> Since the options are effectively no-ops there, I thought documenting
> them was unnecessary =E2=80=94 but would you prefer that I add some note =
about
> it?

We should not accept options and then silently ignore them.

Can we reject them instead?

> For completeness, I also checked places other than -netdev stream and
> -incoming tcp:.
> For -blockdev driver=3Dnbd and -drive driver=3Dnbd, the keep-alive* optio=
ns
> do take effect.  However, the documentation for -blockdev refers
> readers to the blockdev-add QMP command, and -drive is documented as
> accepting the same options as -blockdev, so I concluded that no
> additional description is needed there.
>
> As for -netdev socket, -drive file=3Dnbd:, -chardev socket, and -vnc,
> they can also be used with TCP connections, but the keep-alive* options
> cannot be specified with them.

Thanks for checking!


