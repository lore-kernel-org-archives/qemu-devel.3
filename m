Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05547C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28gt-0007R2-UD; Thu, 03 Sep 2026 10:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x28go-00076E-MO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x28gl-0004XF-Ou
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788446714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
 b=a0s1hvinUmIM6YRZ3a9PltTMvvyPCMMO19rg73rkxv1gtqlCSzwNiQhWjxlnK85RhiOVls
 abd/eL21B3FS72O1b6mqQB+VkRf7CnLhP1rVMoQWHa7+kvk+4N0cw3kj5ULUzpKuII7jKn
 DPZDCk+K8tsAeiz6NOmxyG1BJWJLf8Q=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-wM9dtCfWP3ObrcpYsyVIzQ-1; Thu, 03 Sep 2026 10:45:12 -0400
X-MC-Unique: wM9dtCfWP3ObrcpYsyVIzQ-1
X-Mimecast-MFC-AGG-ID: wM9dtCfWP3ObrcpYsyVIzQ_1788446712
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66f92d36b8bso3080063d50.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446712; cv=none;
 d=google.com; s=arc-20260327;
 b=soI0SBg9ys2IddMwV1V2YW1Oe9xiplv332MBvy9geMKGZK4Kq5RhxLugpRQLqENwd7
 s08SG+P+u5QPnwUeL6wueJWRLWGVTEtw62qIRxktAbud4lWrluS48kVSBR2n6PM3m8zX
 0wD5/Li0o6ZYPvpMz2LnVxOc2kDNBt2pepadAmUFy6fQhkAKZsUlWkSjR5AulRbjkm9B
 Kjry75yLS7Ng0UwDo5trtrPSckfOv1jggppANkQDo59+gYlA6/HEMlKWZl588lEezHeW
 Vork/2mIU4bGK5wo0sAgdckVcUp7OvFkEusHOd6RZLFu/xQ7/+oEdLW5urqVt7dLx7AC
 MCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
 fh=Q/PnE79JAIK3lRyPbotyCvwsSqpcHA63136ZoPD1gTg=;
 b=SlAF94mcLgORcYAwZiTP77LBXYzOL4miGmg0kgKIbDqiu6vvkW4VII7XVHlD1JUjsP
 15kpk6kczQoWqHE1czAhM0h/kiKmI7C8TxH+fYxLJ/pFg/fjw4kqpa7CjxSFRkf5zAZ1
 n3Lxw+QQCMwW4GQGvL717TlvlCCM9JSmnoLszH8FAfIsIuW8Oa4sBIF6CmIiBHPp+ra/
 ru5+a/IfVR/6pacfpCD9vh8nxrFW/zL1bLRBxwEYo7jofCVTM8wGyxuZS99UDJapG63P
 OhKz3oN913gjmJYT2pfWTP/eekCgUIRGiXNKaesn8O2HV5Nk8DgQQwC6BIXHqlpQUShz
 5j5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788446712; x=1789051512; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
 b=b/wgAn3x5cS8K1YapsjVJGLFS33t1xp7aEiBlLZ5HSbaceadTdIk/mtLQ6f4kQUFIR
 +PvKN826ZlNr8HD72L+tCzSokmawBJft0zBBFWz82JWh3SNlTILoyvjT8YsbBx9jALs8
 /3UQFeTESh2zFUubhsv5V4sv7dcYyL0BnRBV6mn/oR9zCjFrWrrLG2It2tektVs7rn6r
 VVFNKe+z5DQHzmnw1tD2zkdms/EM3DIAD0DWkMpON9FVlR3TpMqivCIxsGhdBfWTFUAp
 lQRNXhfNCGvgvXEZbkIBLbf08sk1hFSmGq62WVr8aVRH8xLcwJpKpgdCg/fAjR5VGvxv
 jFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446712; x=1789051512;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
 b=QUtReVXAe7l1qBiBvuqol/7Les9B9hjvusPoR2ry2wGe1HGFS30XD7glmlKQCpYfUz
 LRYHiEJjvlRM/5oDR1C8cwsIOGj9RzQyRsM2V/ymtRNfP3nGCY4s1afJ3/6vFaAKHmj5
 ak18d0RWgpUj8DRNrDt+fDU0s/2YoI6IQNuKnLDLdOvoqN8wAwfBDAuht8ZPd0wvRb0x
 o6lLgSPLaHjRjVt4H+9U6C1fB70PThhc5XYPlM4AB68E11YQ2CKWkQA6R0mQB2LG0oxr
 WUyv7SiK0dQvd+P/jLI0OGm6hcrwoDVaTJsgbdqB1efjxUuCBjp6nhRSWG5Py845RMAH
 KWkA==
X-Gm-Message-State: AFuF++nFpd8jFyDsehD3gGYgde3FhU6JQGf75+W7P6PJgqwAZAXjAgmg
 UhuNYiLCTqJDEuCgnQUNf9OIZXy5tgveYu+PwuTuG4zGFsul4NYycN+5mfPoWppwzw43C5Mbm/g
 UNX3w9HZSs2SuvcTv4i3zhizpr+tR6z6vIl8WklwqtMXwhFcpx+eppfTtFgDZaVDGUf092SFjAO
 hXxm4p3iKWVhev08O/qNco2TrlTv4hEQs=
X-Gm-Gg: AYBFou0l1IThGagVXDsWAbUN/5QBR0DG5AS5w+iVM75Ludl2hcF4+DuLHifnTqlzoMN
 0hgC9JZWyh1i3QNmZeXJK9465fidHmxKvbQXn+GuoBDDn38qLg2PkB5OFr4gM0mxM2pPewRtwW6
 la9myS3RGcx12qCPdISZurqXSEKkNnz+zSDgXKvAIQV7WvmnlbFyItVX5LLWPflCMe1T6cbb6qm
 f0p1P6B7Sq1aiNc
X-Received: by 2002:a05:690e:204e:b0:66f:9995:d0c6 with SMTP id
 956f58d0204a3-66f9bd5cbbbmr3792327d50.25.1788446706970; 
 Thu, 03 Sep 2026 07:45:06 -0700 (PDT)
X-Received: by 2002:a05:690e:204e:b0:66f:9995:d0c6 with SMTP id
 956f58d0204a3-66f9bd5cbbbmr3792296d50.25.1788446706362; Thu, 03 Sep 2026
 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260901194324.458482-1-jsnow@redhat.com>
 <87ik4mr1dy.fsf@pond.sub.org>
In-Reply-To: <87ik4mr1dy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 3 Sep 2026 10:44:55 -0400
X-Gm-Features: AcwNN1VgNaN4xAvcs17DkNeBuR6R7xgxjHZ-filiFeIDSOm24eV2-6Sh2JVOWqg
Message-ID: <CAFn=p-ZkBrj0MNq=P3Myw5b1o-xUotm7qmGmuRzD=X_appS4VA@mail.gmail.com>
Subject: Re: [PATCH 00/12] qapi: convert simple command intro sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 3, 2026 at 8:00=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Nice!


