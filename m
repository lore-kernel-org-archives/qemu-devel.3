Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB26606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lFV4KZ4E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUnE-0001z5-Mq; Thu, 12 Nov 2026 08:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUn3-0001qG-9T
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:24:35 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUmv-000787-PJ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:24:30 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b349d21fd1so31590127b3.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489863; cv=none;
 d=google.com; s=arc-20260327;
 b=mXsAlpuFUBE1UyMN5B+BtKVVwhRH4odC8U5aeicU1RWaO1WGzv7yEwLqfs1kFZc7sj
 Z1fZzmDHu7drHEgEQvTHdn6eLXzCOQDByxK9YzBZcGYaLV5sy6Vr3cZmIn+7w3lV+LvV
 hPNQmNvc81YrsEjH36jN4ceKEG7pphDfgLudYmWf7CMXEssICwTHjztjCd9FoXp6tRaw
 4ZEIA/AXrjLK/8BjK3ORCKwnZUedPH8Z9ZQKMZ+btkWrkugTgGbH0/iAo8gwAXJm1aSi
 qXfUGbA1ev6w06xdmbiFNCJ1FOs2QC2LzhO9CrX4ntYWWaDGEMP0tor4+pE+ZbL+Nyiy
 wizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lVYR0ZV945CUVw4JsU2jXXLhij15JcXcgyKxc2WLNsE=;
 fh=4C6HmmnetmYuSN/Xd7ywL+bfrnJuCNmL7bU+OpuUfq8=;
 b=BNiQKjqBONxB3RQ3UNCjOVCty2rlmHMrK4D19wTCtIlrv8qx9yt0ityeCiRgNvBkfN
 7UCNZ+ZkGqrs/DaPm68n6g8rOJTQejFoZk1He8iwH2CHuXd2zFdUgL2xrZE2liW6Divs
 agRl128p07o+iovdMpPvWRXEQWltRgqEj3/xTGVKbOcEHhYMNaM2i8A8RGpE6itT1GvF
 StCog3d96GOa5zFYTRa6EkzPP4rH21sawN71lok7R+C/Bg2VamZiIpCIxYlKk70urHyw
 EY1v9SrLykPxOIdbtnOiy1jzxaNtT3KvCIOdRi7U5tgzzYDCkibRuTnx5VhDP+jIEtRL
 RiuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794489863; x=1795094663; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lVYR0ZV945CUVw4JsU2jXXLhij15JcXcgyKxc2WLNsE=;
 b=lFV4KZ4EmJRG/0O0wcpw9tMLJdEvhtLOpml8RnopcwjJfFU6u0KNfZ8/gos4lvExsG
 V9lG3yaWg2x0U+02BuN03weNXlICCXY9yxGcNgwFiX/rLlBPELsBVdxsQ2X6+mDofpJs
 sjV0b9chaIdYueID8bfl/PSskelvXlS041wORWz/A72kHMraY1FKNZcyZBt6fbLlvqcZ
 n4yGNeA8avTjD+kOnduHsRUgH3E4S1JAjrplv+oY+D4OywknMv2slSCskw2pmyuul7pg
 yhk7wwctwuFKnXim1BTtrlIMkNueiw8Tc+Sf6I2ydCmZqtYdciICJVFgjVTexeKkUHmT
 27ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489863; x=1795094663;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lVYR0ZV945CUVw4JsU2jXXLhij15JcXcgyKxc2WLNsE=;
 b=v6+vcoxcU/RhTEz6sbAtZDzGFZglIeH0+cAeyZrgG8FX3hCkVTA05vBjb8QMtRj24V
 9auk+elcd5GZFYLe6A9qayCLJ0m42l/uD8OdJZvQH9Uz1oWfdFRuc8cUbqiNi6Om+y5k
 a0KQpctrh5TnkvQpJ81jJ8PxzCD0pXjVgQX+UiSotKv7LxRKQAaNcCZY6ImVAUMOREgh
 hDDE0AT6eFyhfoje25+WC4iHEXyM50Rr9b/dZUFd3igGXm0ywkIj+paczJqBFdB4zwX6
 O+XODamLgVufUmzzokOg7ofSPDl5gv22mkTR3BI6tJPB0tmbQSk98jnvKFQiPCn7eyFD
 1Zeg==
X-Gm-Message-State: APuU4Z9QWLjXHWjEUrAVRKkRFJ1bDHXLTGh7QjltLIeBROIx8GNE2+iX
 i8/838X2X2wy0pV7gb1NGzFz0QE0lRK7EGqMNFGGUbkjJlvyMKNy7fM8JGzomeMi5xUAVZrLNi5
 qQZdVItCJflZHmetI0AgJylTWuwNnzMX8T4qUM6kcEg==
X-Gm-Gg: AYBFou1dXMiSj/QckIEwbU85DegD9mVz/VOONk9rRB+zp1ZgSxYYHWb5ZKAsFj2U7DK
 Q11Qn8ZlB05ocTASs+7EzqM+ZcVH6peabf6TyaNraLxiuaZ6Y9DPOWordvBD2jcdc02YO6fR2IL
 9DK9Z9ukIsotMZNv0/A0wWPf1XZvjuXzRB8QVLR8GuNESKFcSAnM08VSZ34co+7kEa/NzrZ2Oho
 lVTnUzgA5TlWGsdQbbjFFHjmo1MKMydKCL92Olwdibon+g21bPrN7onCdiRe8kV8A6a6t14H5ox
 QIbvOXhFlsQ8ks+HDb+nlnBty8sPkWarDHk9U6c89l4iEp9pwLf5w1DZyqPqcMkLYM9dI4kD3jL
 3JR+nM0Lccx5/vaJU7h7NOJdVWEp2yY21oi8ixED3m00bfF4ACooh/bOEDxL0Wr440npzP525yi
 r5HWT+1T1MABT7VkXwPVGp
X-Received: by 2002:a05:690c:6e86:b0:8b3:3d53:9106 with SMTP id
 00721157ae682-8b3a823e7d4mr35569867b3.110.1794489862781; Thu, 12 Nov 2026
 05:24:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105114635.3286252-1-peter.maydell@linaro.org>
 <ccb97ede-e91a-4990-821f-a3127d1fd4e4@virtuozzo.com>
In-Reply-To: <ccb97ede-e91a-4990-821f-a3127d1fd4e4@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:24:10 +0000
X-Gm-Features: AclHuK-YlvuxyTRSi4sHWEsGzPWXc5CKP1hPfnf7t50L8SEqsULmTl5BYMcbMbs
Message-ID: <CAFEAcA8ADxOLwyPcivTWjYpQuLdathCA-2z1K32FG5X=kJyJ6A@mail.gmail.com>
Subject: Re: [PATCH] hw/core/qdev-properties-system.c: Don't leak str in
 set_drive_helper()
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Denis V . Lunev" <den@openvz.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 11:49, Denis V. Lunev <den@virtuozzo.com> wrote:
>
> On 11/5/26 12:46, Peter Maydell wrote:
> > This email originated from an IP that might not be authorized by the domain it was sent from.
> > Do not click links or open attachments unless it is an email you expected to receive.
> > In set_drive_helper(), we call visit_type_str() to get the value
> > being set as a string.  This is an allocated string, and we're
> > supposed to free it, but not all paths out of this function do so.
> > In particular, the "block backend already exists, change the attached
> > node" code path does not free the string. This shows up as a memory
> > leak under the newly added virtio-scsi-tests/replaced-node-size
> > qtest:
> >
> > $ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
> >   QTEST_QEMU_BINARY=./qemu-system-i386 \
> >   ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
> >   ./tests/qtest/qos-test --tap -k \
> >   -p /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi-pci/virtio-scsi/virtio-scsi-tests/replaced-node-size
> > [...]
> > Direct leak of 4 byte(s) in 1 object(s) allocated from:
> >     #0 0x55f7744155e3 in malloc (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-i386+0x20115e3) (BuildId: 271ffb42d2e322de7813813d8c6cc85351e48a4f)
> >     #1 0x713dbd345b79 in g_malloc /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gmem.c:100:13
> >     #2 0x713dbd35b988 in g_strdup /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gstrfuncs.c:323:17
> >     #3 0x55f777208021 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
> >     #4 0x55f777208021 in qobject_input_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qobject-input-visitor.c:542:12
> >     #5 0x55f777204d1c in visit_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qapi-visit-core.c:349:10
> >     #6 0x55f774df80d1 in set_drive_helper /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:129:10
> >     #7 0x55f774dee9fa in set_drive_iothread /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:224:5
> >     #8 0x55f7767cc5c8 in field_prop_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties.c:89:12
> >     #9 0x55f7767ec12b in object_property_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:1562:5
> >
> > Switch to using g_autofree so that the string is properly freed
> > all all exit paths.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: d1a58c176a11b ("qdev: allow setting drive property for realized device")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


> Reviewed-by: Denis V. Lunev <den@openvz.org>

Thanks for the review; I'll take this via target-arm.next since
I'm doing a pullreq soon.

-- PMM

