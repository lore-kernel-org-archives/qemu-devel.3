Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F5FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh73L-0006OO-02; Mon, 04 Mar 2024 07:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rh73J-0006OD-EL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:04:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rh73H-00025z-9g
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709553853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4j1l4si0NLw7Q+lV0QdkQ1jQi9y+QL+lWA3XTu5TW4=;
 b=Q/3tcHKIPnRP18KCu35GxkLRgYxf5us7eKBhBJBciN8XbdPlioYUQm45u89ZuLmFrAq7bp
 KDqWVC7uLxrML7A8cJ0hXIDq0ot2kxzwUjsXmp333fbpOa/+msF8+Gm1oPL18pEkw/9SQF
 gAZ3luKwYUAdpLfsv7pW5vf9FoWdbsQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-aoh8HUY_NB2-nsqEeQcRBg-1; Mon, 04 Mar 2024 07:04:11 -0500
X-MC-Unique: aoh8HUY_NB2-nsqEeQcRBg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d7fcb70c2so2662228f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 04:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709553850; x=1710158650;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n4j1l4si0NLw7Q+lV0QdkQ1jQi9y+QL+lWA3XTu5TW4=;
 b=vQn+adlhBe3UDNtlLgOjEpdXKyJTp/gdW0C8bTgtgxmfkYq4dxP/TJQGXLehOxIuPF
 jYc+6VLL+ryrMWfOZ3k6aWF6IaCv6WOdIJ2osN+P+bikbVAM0AMg+f8TV8NbG/9EZLEQ
 TJc6hALhlkCWG0mk/SWsGqEmcwSGD3pz/5aQMaJdGb0LK8jVkk8igR1hA2cMUMwaiYGF
 5jUelYtLosyXwnlbr3CFWJItPcIzbzcVGBR7vt+NUxZuCuXWUuqdWUcOYKnhFXsH63Pd
 mjs3tecB0+vpyuNW+oscd8UtV8i4VxM7KAUDrJ1BuWG+OM3IqH5mttEfYcllKH+CNziz
 qs4A==
X-Gm-Message-State: AOJu0YwcE3kqI8Og6FYPUXGaosolOm+GbDhFLI7sVs0ihDQc9gU46Fg4
 Rtlhbv9T9j9dDC+S2EcIyJi5uIZgcG4an0bhp0WPULJZU/qpVToqXNLtPpZVZ2J9p5tiTNrfwRX
 CiMewc8iLr//Rl1Y96MDO60LPmYHsLF9P/gWTV0khchvymL2jtKGAWAOKsKca3fe4A7yZMQaKOn
 IU8XG/vU8mQB71wWi9JC6DYLne8JJUPy0zlgXPnDI=
X-Received: by 2002:adf:b303:0:b0:33e:2d7b:c5a8 with SMTP id
 j3-20020adfb303000000b0033e2d7bc5a8mr4910328wrd.17.1709553850537; 
 Mon, 04 Mar 2024 04:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfGQPn5g/4cC+WjhvHMNxzNTika2qVPjer70np/b7vMylkyys8dz7/rqIEBuyua+hRSnVmoA==
X-Received: by 2002:adf:b303:0:b0:33e:2d7b:c5a8 with SMTP id
 j3-20020adfb303000000b0033e2d7bc5a8mr4910301wrd.17.1709553850127; 
 Mon, 04 Mar 2024 04:04:10 -0800 (PST)
Received: from [192.168.178.136] (port-92-192-150-107.dynamic.as20676.net.
 [92.192.150.107]) by smtp.gmail.com with ESMTPSA id
 by1-20020a056000098100b0033e22341942sm8825419wrb.78.2024.03.04.04.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 04:04:09 -0800 (PST)
Message-ID: <ea82934aa34f08da3c30814676878607f976cbdc.camel@redhat.com>
Subject: Re: [PATCH v3 0/5] Generate x86 cpu features
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P ."
 =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Date: Mon, 04 Mar 2024 13:04:08 +0100
In-Reply-To: <20240206134739.15345-1-twiederh@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ping

On Tue, 2024-02-06 at 14:47 +0100, Tim Wiederhake wrote:
> Synchronizing the list of cpu features and models with qemu is a
> recurring
> task in libvirt. For x86, this is done by reading qom-list-properties
> for
> max-x86_64-cpu and manually filtering out everthing that does not
> look like
> a feature name, as well as parsing target/i386/cpu.c for cpu models.
>=20
> This is a flawed, tedious and error-prone procedure. Ideally, qemu
> and libvirt would query a common source for cpu feature and model
> related information. Meanwhile, converting this information into an
> easier
> to parse format would help libvirt a lot.
>=20
> This patch series converts the cpu feature information present in
> target/i386/cpu.c (`feature_word_info`) into a yaml file and adds a
> script to generate the c code from this data.
>=20
> v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02005.html
> v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01773.html
>=20
> Changes since v2:
> * Rebased on top of current master
> * Removed all "drive-by" changes to feature names ("vmx-ept-uc",
> "vmx-ept-wb",
> =C2=A0 "kvmclock", "vmx-invept-single-context", and
> =C2=A0 "vmx-invept-single-context-noglobals") as these needed further
> discussion.
> * Changes to the generator script reduce the changes in formatting to
> the
> =C2=A0 current feature_word_info even further to address the concern abou=
t
> code
> =C2=A0 legibility. See Patch 5, "target/i386: Generate
> feature_word_info.c.inc" for
> =C2=A0 all non-whitespace changes.
>=20
> Tim Wiederhake (5):
> =C2=A0 target/i386: Split out feature_word_info
> =C2=A0 target/i386: Translate feature_word_info to yaml
> =C2=A0 target/i386: Remove comments from feature_word_info.c.inc
> =C2=A0 target/i386: Fix feature_word_info.c.inc formatting
> =C2=A0 target/i386: Generate feature_word_info.c.inc
>=20
> =C2=A0target/i386/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 679 +-------=
------------------
> =C2=A0target/i386/feature_word_info.c.inc | 710
> ++++++++++++++++++++++++++++
> =C2=A0target/i386/feature_word_info.py=C2=A0=C2=A0=C2=A0 |=C2=A0 71 +++
> =C2=A0target/i386/feature_word_info.yaml=C2=A0 | 701
> +++++++++++++++++++++++++++
> =C2=A04 files changed, 1483 insertions(+), 678 deletions(-)
> =C2=A0create mode 100644 target/i386/feature_word_info.c.inc
> =C2=A0create mode 100755 target/i386/feature_word_info.py
> =C2=A0create mode 100644 target/i386/feature_word_info.yaml
>=20


