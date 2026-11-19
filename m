Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA0606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LLrmcnMH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fYzvG3i/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU6bQ-0007pC-3X; Thu, 19 Nov 2026 13:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xU6bP-0007p3-48
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xU6bN-0003RJ-B3
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795111876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za4j+jix0yL8ZkGxp9i0lanscJnCTOEiH/ZzCwmqjwc=;
 b=LLrmcnMHM10r5qLs4h3zB3+wKt40nulHPw32Dw9XoUaEcydcLtMVXtmbMQQyUexpJH+IME
 Bb/E7WOrelVMSIKq5i6iVG+gKAP/a//8STNaFbClR7nbI+Ehf7YyiHjiYiNvhXgbnsG98C
 cJz/Tc6kTY420xP2ZzVOQ/AQKmNxnOw=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-p9SKwjRQO9m1hsDCF-HgvA-1; Thu, 19 Nov 2026 13:11:14 -0500
X-MC-Unique: p9SKwjRQO9m1hsDCF-HgvA-1
X-Mimecast-MFC-AGG-ID: p9SKwjRQO9m1hsDCF-HgvA_1795111874
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67a781c1069so241945d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795111874; cv=none;
 d=google.com; s=arc-20260327;
 b=GN/ZKH3zIQb9QnU0eNjuxsMSn8vp8Fg0Niwl0fv8YhpCL8qnLM/bSsF9pFVZMC536M
 f/bGSZcktq77hd0g3auWb88jRHpNZKV66trSjKxZdf706ksmIIteF+Q7rNePveii4Goh
 rbFPctpyB6m07OTv7Bjoj29HfSvXJ3isXuRydBCTqU/rJ6ocPETqXlT4jQFO7qe2QK5w
 1Kf0pYovG7XHLesXA+hlKFC7WTveamVo109qzA9BlPeqOZdHkM2BH+Yw9fUXUlRydSFo
 Smgg5U6BWSKA0wTWAL5CHkM0us43qaQHsR8QZqh3hwm8S6RMwlRyyjZPuGiNeLYSa7fi
 pcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Za4j+jix0yL8ZkGxp9i0lanscJnCTOEiH/ZzCwmqjwc=;
 fh=ou6lVPDDcUbHy5xiBzjgEYzQRtYQ64eNjkdjQHNlhhw=;
 b=ZKTBu7qtvmWeR5UMFYiisumaSxtxPk9XZz/msz9PlbBMo++eV0b7JEp1h37T+DnFN0
 aft/cf5SrGIRfCKKTNX3FZhYw5erspKNr2AmopPdZMtkPgioCxu2KJcfCdEt2OiyN9HC
 tVBZJzbmE40jZ/cD9I9igXedWL09sdriuQZz82i/HcooAGRLxtaZOVmbBrm1F0bwCd1H
 9LQu8et5WmkOzzz8cOkfpMTkyhg32jxqy0Kaf3RX63Xla1/e4XbB4k1Rvnru86ykrXnN
 HTBkr2/by6BYQ1D+JwD7pNdmxWZ1b7uIXXjaKB4i2AYl5QyDoIC0YbpfhlLF4EyKQm8G
 Ngew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795111874; x=1795716674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Za4j+jix0yL8ZkGxp9i0lanscJnCTOEiH/ZzCwmqjwc=;
 b=fYzvG3i/3Zy/X8CmmbV9SCX5RaXyewPFuEunX6fz0V/0NHp7xEhErvT1uOQHwwtuZR
 7eH46sVYiXrHNV2XiHVsxDKunHVIdgrEb6SAPAgLUPzkGX3R2sTJ1clFvIYq2RiRGtE0
 kF+7YI+XRLDtBRTIBNpInbghSd4Dwq0GCMYDCnck9Mh1o4+kG4zoP5E2TLJhLLktFqV3
 e+LPBhgxLt0X63afiLHu2qw0t1p6rjMn8ofEKBtfFhv5xqHb9OTQiUu2oyJYYg8O915U
 EtUZcaW7JDKHtDcI+bj3uCv1B4Pw9AKsyozBj9YHtjpxyrVtTKmcpZhkS02rY/Str4a7
 eNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795111874; x=1795716674;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Za4j+jix0yL8ZkGxp9i0lanscJnCTOEiH/ZzCwmqjwc=;
 b=oMfL+fo6OSaYVVRn96FYdYynLZQQ9Q/thuMRReB874mVIT8nfIdWN0UgWPIGM1iM+I
 jqYfotLPpjX5keIp7eGhW2XR4rffzrxKK9iyGaZ/vFZhf/AlMjTT+eKICO46S4cO1kIT
 ZV27QN0y6/pjFwTmNaAW96IrRJheR2RAFLJINpyDtNlMnWsQMcBaOeCuQKmK6zY6nwNG
 4NOMzGtPtlKpJ/YfGvMWmsFuieRi0Fl8yk3lJoKFn6HlV7ned7rvxSB+3QlajSqycjyQ
 j5DUSN2ET1fTc7z6HlWXpN4f9umWbH0QLBvsntGhD1boIoGj7GDgqWeC3985GPw4AsRk
 1u6w==
X-Gm-Message-State: APuU4Z98gTb6PZvE7xVyGMdRkkSPC8Uqz7TUZGAfonflgGjojY9KPzG0
 sG+O/nKOSUEbRXwVOCMKyFQFx1OduFEgGWMMdDzRlLEtaV7trH4gzdAK1+A+E3hKeL2kFsx4GfV
 IaKUjWSZazcn2nQeFmWLrsfRzUm8hL2+mDx3SxX/c01tthVgXGdkuzEWvOHPGkuncjPOJXCHCL9
 AueMnTTEJdQ5ZIDWmwJSfWjx34gJAk8bw=
X-Gm-Gg: AZFdTZfhErji45ga9VEO73LwX5rnKNYzz76np2OSjmRLNdn7qUrwal3VcUN7icSBn8x
 sVSrukFbWGHE5udHBAZXzfbG3RY5Nv8l0S9Ot39V073BbTSdLO1RaUNwKlFFQAR5pz3yCtB4S8s
 0PbSZ16u13lgrBRmJZIqFrCTVHPxmXRTrJVHdcBlFuxB5K29yY7nqb66NdUTw/o5uBOJZBAekGT
 PZuxXywbHBAVaIq
X-Received: by 2002:a05:690e:1c1b:b0:67d:b425:fb83 with SMTP id
 956f58d0204a3-67df43ce37dmr142774d50.33.1795111873702; 
 Thu, 19 Nov 2026 10:11:13 -0800 (PST)
X-Received: by 2002:a05:690e:1c1b:b0:67d:b425:fb83 with SMTP id
 956f58d0204a3-67df43ce37dmr142769d50.33.1795111873145; Thu, 19 Nov 2026
 10:11:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118182005.1066151-1-armbru@redhat.com>
In-Reply-To: <20261118182005.1066151-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 19 Nov 2026 13:11:02 -0500
X-Gm-Features: AclHuK-Cbq6qSBJDZ3WU52VG2BMmre85oFB1EBoc1LudIHFIF-LEFysRDtmpmKQ
Message-ID: <CAFn=p-bz6_SW7OR-wxTcLPQfq5D2G5YRXLuH9wc+cORh8E8=1A@mail.gmail.com>
Subject: Re: [PATCH] python/qemu: Don't choke on unknown members in QMP replies
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 1:20=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> The recent addition of @qapi-type to ObjectPropertyInfo and
> ObjectPropertyValue broke the corresponding classes in
> qemu/utils/qom_common.  Reproducer:

Do we need that qapi-type for anything in the client?

>
>     $ bld/run qom-list -s qmp-socket /chardevs
>     Traceback (most recent call last):
>       File "/work/armbru/qemu/bld/pyvenv/bin/qom-list", line 8, in <modul=
e>
>         sys.exit(QOMList.entry_point())
>                  ~~~~~~~~~~~~~~~~~~~^^
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 230,=
 in entry_point
>         return cls.command_runner(args)
>                ~~~~~~~~~~~~~~~~~~^^^^^^
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 215,=
 in command_runner
>         return cmd.run()
>                ~~~~~~~^^
>       File "/work/armbru/qemu/python/qemu/utils/qom.py", line 179, in run
>         rsp =3D self.qom_list(self.path)
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 192,=
 in qom_list
>         return [ObjectPropertyInfo.make(x) for x in rsp]
>                 ~~~~~~~~~~~~~~~~~~~~~~~^^^
>       File "/work/armbru/qemu/python/qemu/utils/qom_common.py", line 52, =
in make
>         assert value.keys() <=3D {'name', 'type', 'description', 'default=
-value'}
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^
>     AssertionError
>
> This asserts "no members we don't know".  There are two more like it.
>
> Adding @qapi-type broke them.
>
> docs/devel/qapi-code-gen.rst section "Compatibility considerations"
> stipulates that "clients are expected to ignore [members] they don't
> know."
>
> Delete / relax these assertions.
>
> Fixes: 0eee31cf1085 ("qapi/qom: add qapi-type to qom-list, qom-list-prope=
rties, qom-list-get")
> Fixes: c750c02891a8 ("python/qmp: Add qom script rewrites")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  python/qemu/utils/qom_common.py | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_comm=
on.py
> index ab21a4d364a..e5bae1c7421 100644
> --- a/python/qemu/utils/qom_common.py
> +++ b/python/qemu/utils/qom_common.py
> @@ -49,7 +49,6 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectProperty=
Info':
>          Build an ObjectPropertyInfo from a Dict with an unknown shape.
>          """
>          assert value.keys() >=3D {'name', 'type'}
> -        assert value.keys() <=3D {'name', 'type', 'description', 'defaul=
t-value'}
>          return cls(value['name'], value['type'],
>                     value.get('description'),
>                     value.get('default-value'))
> @@ -80,7 +79,6 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectProperty=
Value':
>          Build an ObjectPropertyValue from a Dict with an unknown shape.
>          """
>          assert value.keys() >=3D {'name', 'type'}
> -        assert value.keys() <=3D {'name', 'type', 'value'}
>          return cls(value['name'], value['type'], value.get('value'))
>
>      @property
> @@ -103,7 +101,7 @@ def make(cls, value: Dict[str, Any]) -> 'ObjectProper=
tiesValues':
>          """
>          Build an ObjectPropertiesValues from a Dict with an unknown shap=
e.
>          """
> -        assert value.keys() =3D=3D {'properties'}
> +        assert value.keys() <=3D {'properties'}
>          props =3D [ObjectPropertyValue(item['name'],
>                                       item['type'],
>                                       item.get('value'))
> --
> 2.55.0
>


