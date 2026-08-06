Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CB8C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws02T-0000NQ-Sv; Thu, 06 Aug 2026 11:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ws02S-0000N1-Ko
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 11:29:44 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1ws02R-0002sS-A8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 11:29:44 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-51c2a818fc4so15458331cf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 08:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786030182; cv=none;
 d=google.com; s=arc-20260327;
 b=HuZvqT8JCfeeIa+OVpv1sqx1cqEj9rIvrFe9ppLKk3cV+jTKb8+r/R1nFCsoWIR1rX
 hoIFbRPwrBKOn4ppJrHSFRS1u89ayjVVCrU2vWFVEGj65WdnK0zCxcrCCyYQwTJdUZvo
 dDmgCOtSjyFdBOyxrjoyteQw5OaAW4g6KlB9D/j8K60aKq5RMbC8Acbguxz8h7jftqIO
 H2MZ9vGuvRv8IyBbzCAQKpaQJ7zgNAyxoq0s6JwDbeNZ65D9j4D6+cuHaqGCVqu0ZNgF
 gjCqbfvbGvdJfohGFFr/9kyiCdJblT9VT/QXe+ZY9w6uKf4tovZXpj917MpmpHGG1qHm
 KLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fbhM6ni7JY8Y2h7SdY5C0ULZ5EeFXPs3jMUf+pr9MXk=;
 fh=x50nJBzqz+v5M8Pm4mrIW+J9ZsMO4Kfn7wHtfmb2xEg=;
 b=KhzgAlUPN9y/JDq4fjmUx6uG95nDQ4fNWJNQ7nPeF8vCTlfVbc7qQPhMbZSirgZeJV
 ZZKGwAH1Bw0qhmgsJKpdBRTkN/IUUZHhHWhPUruKQNl5EeuofLyff+6OBx/IzpMTagNG
 GKHAw1Yxee2S0tPsZmbqvlWyMIHAZXYe29jpEZkXFHrixUrNRxirWxbPh7I9N+78XWwh
 blZWIkbBTNC4MHmKc0zkVxUElZhhOi3D2jfjXDkImVB+Zvs2I6TSebFJ6UkX6Dcu+jZs
 ld2Ln4Lkyy3ynExht6Ei6LtCjh8bNcEmnPgsqSryKvmCgp1xzI3PeweGYGacIgHRl6B0
 B6CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786030182; x=1786634982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fbhM6ni7JY8Y2h7SdY5C0ULZ5EeFXPs3jMUf+pr9MXk=;
 b=n7G5duJOkqWTmBY9nO5Hl8e/QEWQsMv0YcEoTxXjHvHR85CuzxXLxhd/eBQXIc595o
 w4P2gSHQGR6Jx734w6Fbu++6CJ8Gjv1aRV1NklmNz5ypYTlj13zkneSQgoDI4JnNur3m
 sLcWL/unXlXQS+ALSKXZEzM0vY9NSKhrmMJDxP8azapM0FmuylH1PM1DVJj5Hyrh/Tm0
 wnoWThV6OSMqjraWMgbV0Oh3rBvjxG3U7qBnBdKoZV9FTWw68WNX7eSuFV1z50/iKSs/
 LcQAw07kwtIRYsP2JNiNo5LyZ0H+LUM3afEHt71WfeE83Dv3Pv0amIT2d32oxEsKNeVy
 dkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786030182; x=1786634982;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbhM6ni7JY8Y2h7SdY5C0ULZ5EeFXPs3jMUf+pr9MXk=;
 b=oaOv9QAhEWJg9e8qkm7O3W8/dkLqsSPRouitJuVpv5wOjSoojJjLMDdiVb6c5YqC3S
 amL1g9QYo55VQOgkxLvxnOSKzS9BHWJeIzaLK36jyMuQ2tybfgI19HlncfSnpHansj20
 7Q9/5hqzg2GOwgkRUl4r7SvtOK2Q8CSCc/dio6mtuoiZrZcCqbtT7j2tJmNN42nn4HGt
 JdiFlaPkvZsaDPdeN/qbIGyQ4R5ZnD8WLXI4j91eONRB1CVznPWS7cn6qLSikyhD0g5X
 2vV90SRuwgLc9qcwY+6yQ4JpsCLdGgcyNWzG6+NtCL+yb3CacOnEA3XlLZPRMLfh12PV
 a1XA==
X-Gm-Message-State: AOJu0YwL1JTVJrZ3zbIwpH6WMUNWuzuJ1EhZ/N3gxuMjaI83D86zFpNx
 zrIbbLyRZvqqdpyRvpIl/Jw6TKSggUJYVZaxxPo0t91xL2hu+3I7yOlvBJ3nOtluaudwu8gxWPA
 yLhYiRx5zIPeUHtLY3vP6UMYtZ1j2jbE=
X-Gm-Gg: AR+sD10uxgt+DXklfpHN9/Pjb2e2tq6xFu8Qfhf+ullLbFULQZ/2aAqta0oSV8LWzNW
 cCpWaIM6yXjkZANXFKiP7R0OTA4W+E7+QsPAioAM9LU9vx31BbS74+xKa2yorw//HxQKzP+cSRr
 XjtHd2tNIqwgNi4lXBRmWwsZ5yQJfpUqD+3S1UH3MB2EZCP0x7rIB8hh9oZceM8WgsAv0qSHVMU
 9o/d1fFgFQUVrdoD6HK6JBEWGSJe0LjDGxheBp1y3aevGBXfV15UOzDogqq90wGijuJc/soOhP0
 A7ekYfsWcT7bwKWN8eLLe/Jd4H5ZdJJ4rQrtd2i8AD5Mq9gbkOzR/Zco3tbWtpWwkYycPXKpg1n
 zdqA=
X-Received: by 2002:a05:622a:428c:b0:51f:636c:8eae with SMTP id
 d75a77b69052e-52ce5ff21c5mr174083461cf.14.1786030181907; Thu, 06 Aug 2026
 08:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
 <f9125d0a-3258-46f4-93f6-0761a4acdc66@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f9125d0a-3258-46f4-93f6-0761a4acdc66@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 6 Aug 2026 08:29:30 -0700
X-Gm-Features: AUfX_mw1fmyon2HTcHvHhQjAK7H8kXEhTUaSklvV3gLZ5vUvN2JB54elHNtQ0Co
Message-ID: <CA+spn3pLJvQCyfUvK4WvjvfJnGYBKr-i302HvBeVm9Y3t6sR8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 24, 2026 at 5:19=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
...
>
> Nit: please remove the whitespace between (void *) and svq->base_addr.
>

Removing the whitespace!

> > +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_s=
ize);
> > +        svq->vring.used =3D (void *)((char *)svq->base_addr +
> > +                          vhost_svq_driver_area_size(svq));
> > +    }
>
> Unmapping svq here can lead to use-after-unmapping because the ring is
> not stopped yet. do_vhost_dev_stop() calls do_vhost_virtqueue_stop()
> only after calling hdev->vhost_ops->vhost_dev_start(hdev, false).
>

I am afraid I don't quite understand, as this patch does not introduce
any unmapping.
Was this comment meant for a different patch?

...

> > +
> > +    /* Location assigned to vrings if not in default anon memory map*/
>
> Nit: here please add a whitespace before */
>

The whitespace is now added in.

Thanks!

Connor

