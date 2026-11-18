Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBD606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fI68/4Pd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZNayhTVK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTieZ-0000Ua-UG; Wed, 18 Nov 2026 11:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xTie6-0000Rp-LB
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:36:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xTie4-0005bz-Nc
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795019786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aY42yXy+Gc3XVnHoDZtUEAdKmQMKVBfhq6L8tGc7xHs=;
 b=fI68/4PdqMS9GdnV75EWTkz6iRN5e899b05wLmAxtvFcXl/i3Z0gBzNEWZnrVM6Yjj0Z9m
 xMZh+2r1sPSJJ2lJETWylH4IJeBew0fOnZCYv72iv9E6AtszDd1Joe1cCjfzOmqSpcnmUU
 od8l3YPMmgTWVCgLWCNcv+vPYEWjmME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-S9_Iv-blM2anpp5sDYOANg-1; Wed, 18 Nov 2026 11:36:24 -0500
X-MC-Unique: S9_Iv-blM2anpp5sDYOANg-1
X-Mimecast-MFC-AGG-ID: S9_Iv-blM2anpp5sDYOANg_1795019784
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4ba078abd78so8939265e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795019783; x=1795624583; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aY42yXy+Gc3XVnHoDZtUEAdKmQMKVBfhq6L8tGc7xHs=;
 b=ZNayhTVKVIaCTkoNTZhcKGcYEdA8lJyVtvoFK4/DicIY6j84gwoIg2BYDUianAPCt8
 fDAppJaOfjlum3+Av51+CllcV8IgTD6AJC31vZ01dNnvfABrDZuJs/P8cwp9Nv4hRSl3
 jWrSO3cXTQrkNJIkWFdhMVXxI7GI1fSVne6r6vXdqzfSPOfpDd6RWew5kz5kzCOnFae/
 9GTnVQe7hNzkWnP2sO8faj4Eqkl7E+g2pm0PKpjkKt/eP8I+haVhfJjGfl2tlQUFY+hq
 VJuDoJLfDvprIz8QfviZpASFUatmiKt/YH6bHa5StO5ZG+UIWm2nWhQIHFx+16R6yAcv
 hTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019783; x=1795624583;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aY42yXy+Gc3XVnHoDZtUEAdKmQMKVBfhq6L8tGc7xHs=;
 b=QjUdLsA1oUb57yhizc2o3Pr1tOvhXQu73WFDslJOapVOexjmGXJ8YJxiQWpEG2zuNi
 zRltNTdm/mDxm2l0RfmHc2mVkRjCwE8CfuutwsgE7sektgsCA52aG+Bm4WOyjVXa8SGD
 z8BOyJuLni/CC96Zht7rznuU2ZY2p9X5rkeg3HAToZ8NwpMqTTVR4zalw12MHN7I5pIw
 D22tp6aMisbOjXKc2Bf+2HEwHwxpN0zi59uVTbhrFFUym+XUJEikRBO/gTkENgOhObsp
 VAaZC28KaAlyYRxbx0Lw6kNTap8VNLfAof9VIQSHKnLQ46Q1/uJcHpl/Bw9ObqzMRWJF
 6k/g==
X-Forwarded-Encrypted: i=1;
 AL+hErHKYiqMx1s2Wh3s0w4rxUYO02XNc1SAxWUWmbcvQKOtKepNyOG1lR+J4JBp2zsKnqNsM53owud3e1hD@nongnu.org
X-Gm-Message-State: APuU4Z+9Uun/GJtC5d5Ah2u0VMFai5zHGDTtIQiFaa78Ej6NY31bGMtd
 rBQSSpzvq6GDFLrcXoelOp+vJ927DP2SffRjOby7Fl5xmD683WmAeElp8IzCGz0gwCtaQUwTyR2
 7haLuqAdyHQk7ZIejQmqLj5jYRk0jY1w2FEQhGHSxIDSmVpjThU5OK1eK
X-Gm-Gg: AYBFou389+iRgrF11T0CnL2ynVjFl2xcqBa4SpuWF7SaPEA8KuH80SKS+lcgXBPn04X
 ZSIkMdO+w+C946ICCKvauV6fwjJs7O5mDfKwf3Ln81zTjmuXn8TlXSXme9KAYgdGSB1r8hUOzLB
 Ct+1d6V8IwG3jbdW3UJPoNEEk5IAwWh51EtIWbyUL5o6gkzoTslJOnuRoVM+kA/XX+OGQ9cs4Oo
 OnhD7imdIAVSPo8wjJzASXoQMO1OxJISIolRSQoUoQMi15oJlLDPw8sixYv7B5M+v8Mhy1daRRS
 wlDCFeztLk7zOZGAULgwRrPKkPhmDStL2mwa51TyfAoHeDh8ZxnaU3xRnaOacBYrKJYSmP7Xszv
 9CCvBpfy8lwAXA8qAVPv1BZ1zEj+a/3i1ZjAtc+N/2VzX
X-Received: by 2002:a05:600c:4f56:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4bb7da12aa6mr65931075e9.10.1795019783484; 
 Wed, 18 Nov 2026 08:36:23 -0800 (PST)
X-Received: by 2002:a05:600c:4f56:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4bb7da12aa6mr65930685e9.10.1795019783055; 
 Wed, 18 Nov 2026 08:36:23 -0800 (PST)
Received: from localhost ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78418853sm218992725e9.8.2026.11.18.08.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:36:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 17:36:21 +0100
Message-Id: <DMYHENSUOATR.2W9NUORQJN8HX@redhat.com>
Cc: "Tommaso Califano" <tcalifano@redhat.com>
Subject: Re: [PULL 00/22] Misc TCG & HW patches for 2026-11-17
From: "Tommaso Califano" <tcalifano@redhat.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
 <66172cab-a9a3-4be6-a4e7-edc77ba9da44@tls.msk.ru>
 <a8399514-7046-4bf5-a26c-1076d83c5b77@oss.qualcomm.com>
In-Reply-To: <a8399514-7046-4bf5-a26c-1076d83c5b77@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed Nov 18, 2026 at 3:45 PM CET, Philippe Mathieu-Daud=C3=A9 wrote:
> On 18/11/26 14:43, Michael Tokarev wrote:
>> On 11/17/26 02:23, Philippe Mathieu-Daud=C3=A9 wrote:
>>=20
>>> Tommaso Califano (3):
>>> =C2=A0=C2=A0 hw/usb/dev-mtp: Fix recursive delete of directories
>>> =C2=A0=C2=A0 hw/usb/dev-mtp: Check length of class control request
>>> =C2=A0=C2=A0 hw/usb/dev-mtp: Stop processing SendObjectInfo after an er=
ror
>>=20
>> Hi!
>>=20
>> Philippe, there were a 7-patch series by Tommaso, grouped into a
>> single patch set because they touch the same file and all together
>> fix a single issue --
>>  =C2=A0 https://gitlab.com/qemu-project/qemu/-/work_items/4529
>
> I missed all are needed for the issue to be fixed :/
>

Since this issue covers multiple independent bugs, feel free to
cherry-pick only the commits you want. I=E2=80=99ll follow up with a new se=
ries
for the rest, and either open a new GitLab issue for the remaining bugs
or reopen the existing one once it auto-closes.

>> Did you omit the other 4 changes because of the review comments?
>
> Yeah, as individual fixes they seems worthwhile in the release,
> unfortunately I couldn't merge all of them because the comments
> were not addressed by the time we had to tag the RC.
>

Unfortunately, I just realized when (and what) the RC date is, and I had
been holding off a bit waiting for reviews :(

Regards,
Tommaso


