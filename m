Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34B606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DPf7ihip
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCFx-0003ja-Cf; Wed, 25 Nov 2026 07:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWCFn-0003WT-WE
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 07:37:40 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWCFm-0007JR-Ap
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 07:37:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so5934835e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795610256; x=1796215056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=36pV8xg9A71xE0jDk2Z5SaIPgsRFWtWTv99J/bJ2QdQ=;
 b=DPf7ihip16/5e3ngAbwA/Tq8+k3VFhm8cmNzuVOnTUolwxMZakkSYCEUg4XBXF+TNX
 guheeQUZ4a6bVjxz9Cjf3ErgGzLEaUB6JQV+gkHsyTvtv7GqaW10WhZERu23TKPad8ZJ
 ZHCwXlH8SDG+2rX3ipXSGg6x65msA5ZV/BnpfxdDXUAoJZGeq3ypoOLq8diUsxEo5eAR
 g1qMETV78IJi6JndJ8njSMRovnPU8dbVCKImJxg2BiHNj7PcFtcM84GSKZ2JhsOAlFO4
 xfxRxVQVPISzDANL5YpiuI2oreIkr+po2b4oNXm2bb5Ag9/LyY/UrqCJNR1YmVaYL/y/
 QCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610256; x=1796215056;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=36pV8xg9A71xE0jDk2Z5SaIPgsRFWtWTv99J/bJ2QdQ=;
 b=PxnB0FAtMj+GcyaeWfIZvgw5PDtyPwfMs5ZgdlatH7bQUhhQuvk2shMWNN62dhReyn
 lxzTp2vKaC4ZsT4k7rHKIdqOpG803OuWnpKmsgF7ZrXWLTP4Uuw0m6IGSuWAcH7kBdTW
 LpWAhHqlh6IWzCrUqRKY+r925brC++rz9cP8SA3zPVKwjonVJB1Z6IgeZlDt43wj5HeP
 MxyUmKjj67FnmOJBSbStfnHReTG8zp8xQcCYZ85F8rLl5VCy8QURPAWNQh00bm3zvcql
 YaIyuDC0YjWNxZN3KqWdMDbcPz3kHvlSyqpyP7YBfChYsVYjK9EQaF+kNO16rt/CMrFK
 3Chw==
X-Gm-Message-State: APuU4Z+nOcmMt5UdjMVhL2JjWcCEbicXre4dhGq5RVdYKCxeubRp7HAT
 Fly6h8smPTTU0qq6OLrYDsNhd5JktMVYsbv3lI68JoFSMUjWuz6yTVD1015llsmFDjc=
X-Gm-Gg: AZFdTZdEc29BFASQbo63fb8GQamOcU3sX+4BuCkIBv9diB/NdKpg4fi95+QRV5m46lX
 jdIPJteS/bjVrlFNCPhMBoxOKGvcplkN9pNBgVgRLJ+FW0XUTkNgllRnNmKwQtOtupFfUDS/o2/
 YbkxgleIFM/NdkeQ7W/ZGVYpxvPYcAnoZ0Cd+9+2TK3SV62tFYGkAnL97kr1flzKJI9zmQrhbsv
 zWSBsboiDBubalrfDsVoBe+P4V3Co9wxv9alZ0rW16zU+lxqNvJnOkHYn6+/SOk83ZZZNEzEmpT
 EOXtZQAmfPhYWyLox+IvmDWRBKjFs3ZLEJYFsJLus4xZVEG41BexC/p4PLf5hdNqr2TCqdE9DEP
 heD3GyLg1RUwAIfLJ+6dSfzAjj+DyL4NXO1WOtQHn9IDwWJCKBJC7zKUrAJXlFzu+RjOu6d72OY
 TUbBwoulrlGSfJweQdhfqzd/hmjxqRINo9loWGO2decQYsF2cTMB93l+Puafq8VzuDIjVsBts6W
 tnqRgZ9TbzYk0qenXyhLhqFOrRwoLIao5pFGo4plbNQ7Q0qsQWTkX5pDVbXyqJ3+ANmuXkoCcvj
 gKNUvasKlyqA45u11hNRTSEWw2ahiv31qFW3BZxZPSUFPxKNTg==
X-Received: by 2002:a05:600c:a117:b0:4bb:a5e1:7497 with SMTP id
 5b1f17b1804b1-4bba5e18d83mr28568845e9.32.1795610256383; 
 Wed, 25 Nov 2026 04:37:36 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm709796115e9.13.2026.11.25.04.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 04:37:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91B855F857;
 Wed, 25 Nov 2026 12:37:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [RFC PATCH] docs/virtio: add note about virtio-gpu acceleration
In-Reply-To: <awbOqwltfinFGIQl@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 25 Nov 2026 12:03:55 +0000")
References: <20261125115104.2002188-1-alex.bennee@linaro.org>
 <awbOqwltfinFGIQl@redhat.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Wed, 25 Nov 2026 12:37:34 +0000
Message-ID: <87bj7dulwx.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 25, 2026 at 11:51:04AM +0000, Alex Benn=C3=A9e wrote:
>> 3d acceleration has a bunch of issues and is considered hard to secure
>> in our current setup. As we have dropped it from the virtualisation
>> use case lets call that out in the docs.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  docs/system/devices/virtio/virtio-gpu.rst | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>=20
>> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/dev=
ices/virtio/virtio-gpu.rst
>> index d05f8cb8e3f..06e60ec6782 100644
>> --- a/docs/system/devices/virtio/virtio-gpu.rst
>> +++ b/docs/system/devices/virtio/virtio-gpu.rst
>> @@ -29,6 +29,18 @@ host's GPU and for the best performance be able to re=
liably share GPU
>>  memory with the guest. Details of 3D acceleration requirements are
>>  described in a further sections.
>>=20=20
>> +.. warning::
>> +
>> +   As 3D acceleration by its very nature involves giving the guest
>> +   fairly complete access to a bus master processing unit in the host
>> +   GPU we consider this outside the virtualisation use case with
>> +   respect to security. You should only ever enable 3D acceleration
>> +   with trusted guests. There is still the option of off-loading 3D
>> +   acceleration to a separate process via :ref:`vhost_user_proto`
>> +   depending on what guarantees that process can make and how well
>> +   confined it can be if things go wrong.
>
> Perhaps ought to be referenced in security.rst too, as an unusual
> part of virtio that is NOT within the security boundary.

Hmm where would be a good case? The only virtio we reference is the
s390-ccw-virtio machine type. We talk about the process but don't
mention specific devices.

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

