Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5B8D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 18:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT2tG-0002XH-0D; Tue, 09 Dec 2025 13:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vT2t7-0002Vz-2K
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:56:42 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vT2t5-00041E-1F
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:56:40 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-786635a8ce4so47486197b3.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 10:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765306598; x=1765911398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5QBUuPfJFrgmX1zVAVfW9mn21Tbp+zS/Z6QjCDleBg=;
 b=dcBDEwR53TdfJxYw90/1DYjW3564GwfqFY190VwkjVSGIIHyl+NEcinUYjIeIy6LdD
 mabBj/Z4kOhq3UpaLJ+5Z/BnZuTOq1csvyqUn2sZFjTDxtNdaTIugI2ZDu5fMLXQ4BrI
 VYl1OFyBoHIKzBI+ZkMXmKlaETeQ6YBwLRrCfLt2NjwY9iMqoyViDeGAWkDLbzVnXpfw
 zbDRxTxQ4x1qdnt7zP/3PiZOXDEukaFS/Mt5TagQX52vzxRXCmBUS7PYOCkZ62ylP/UZ
 Mf7CcGUUt+9jJv/gvWprROfiQPABeg1X9Oprvqz9DYnTeAhX4nEnDSHHGM82bYOcM4iw
 gS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765306598; x=1765911398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z5QBUuPfJFrgmX1zVAVfW9mn21Tbp+zS/Z6QjCDleBg=;
 b=ACdselUSlYHeuBdykdEGxwatYxwDeR10cdYNYOerCxTkrqymyk2+mQKyPmC39LPceo
 bBL0/sQxr+pmB/rrGjlh1z9sLi2mCTjVE7FvxCBFN50RiyVxyQMqJsc4a1X9mxGriHyC
 wuhh9ilToL4bxM0JqaRhv/pEZVvD0F4J4PNGcNOGE0kYkoiI6iattGjQjRHNdmwcMlJ7
 tFMy9F+8sIrxYwWl/8VGPcrlZPtAbr3fNb5L+SD7bpjyh0/fgosAGfoz65XXWVJxIjfy
 v4hVPdCchLD7LlfwXV6QYrNn4OhVfZQBs+rl9DmxlYWsGb0/qrBmpbR3XecAPH/CfGow
 HTdA==
X-Gm-Message-State: AOJu0YzA8p+z7FIRz/eF3RUVL8GBww8JLkcT/lOxDvRXXgzVWkE8W156
 0iLV+sYqOVvqAtUKQcNzwHCi3m5XY+iCJ5gDVO66fJ5UsIkTFqgXTum7C1JUIE/WL6HYohF9Wcg
 4Bfh7qjg8XRDuJFX0a1+y7XQSVJ3dOQnov8AxHoW2ww==
X-Gm-Gg: AY/fxX4rU0UzC+mAglI6FzjplSQ1Xwqg0FN3Pl7WT9Zg/SMc2o+xSWabWzvvE+8w2dk
 Odxex0gGRDDsGt+lYCFjBohNhYHAhDtJmaPXR7/tXFLa/VNWHjY3q527Ss3Tp9YxT/vTR1BVvQp
 vXbzXPTetPGfDoYFmlGNjycQWC0Dh/brgNqLA84g/59Ts+5+FpK96UBZoA/faOgVdYS++1f6wUZ
 ApAvNd2zO1CPBA0iuQjxjOQlRGtuCoQewxHaxavUVnDnm4lOQfK03jFrzRIO4MvqdcROjMS
X-Google-Smtp-Source: AGHT+IHGxIv5h+JzYe+YegPwj1LNo1acR7clTWIqITnWn1wbghrZshE7+rEaUJhZuRSu/8EL4HFkmxOz5g/CHferKUE=
X-Received: by 2002:a53:acc7:0:10b0:640:d038:faf9 with SMTP id
 956f58d0204a3-6444e75520cmr7768630d50.25.1765306597618; Tue, 09 Dec 2025
 10:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20251209174328.698774-1-clg@redhat.com>
In-Reply-To: <20251209174328.698774-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Dec 2025 18:56:26 +0000
X-Gm-Features: AQt7F2rSUbmGDxELmauFkVYQDuNoU6mblY3HiMaKIX5QYsRexb5yp79Ae9YVz8w
Message-ID: <CAFEAcA8BXOYPg7r73-uqrhvNsSCnY7ex3y8VJ_zm=qt_eRVK7Q@mail.gmail.com>
Subject: Re: [PATCH v3] Fix const qualifier build errors with recent glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 9 Dec 2025 at 17:43, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'.
>
> This breaks the build in various files with errors such as :
>
>   error: initialization discards 'const' qualifier from pointer target ty=
pe [-Werror=3Ddiscarded-qualifiers]
>     208 |         char *pidstr =3D strstr(filename, "%");
>         |                        ^~~~~~
>
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
>
> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3Dcd748a63ab1a=
7ae846175c532a3daab341c62690
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>
>  Most changes are straight forward apart from vubr_parse_host_port.
>  Please check.

> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -744,7 +744,7 @@ vubr_run(VubrDev *dev)
>  }
>
>  static int
> -vubr_parse_host_port(const char **host, const char **port, const char *b=
uf)
> +vubr_parse_host_port(const char **host, const char **port, char *buf)
>  {
>      char *p =3D strchr(buf, ':');

The other changes are all fine; this one's a little trickier.

The callers of this function pass the getopt() global 'optarg' as the
buf argument. That library interface is not specific about whether
modifying the string is permitted. In practice the strings will
be from the argv[] array, which you apparently are allowed to
modify per C99.

So I think this change is OK, but given that all we're doing
here is splitting the string on ':' we could also rewrite this
function (untested!):

static int
vubr_parse_host_port(const char **host, const char **port, const char *buf)
{
    g_auto(GStrv) tokens =3D g_strsplit(buf, ":", 2);
    if (!tokens[0] || !tokens[1])) {
        return -1;
    }
    *host =3D g_steal_pointer(&tokens[0]);
    *port =3D g_steal_pointer(&tokens[1]);
    return 0;
}

There's also a more minimal tweak we could do instead where instead
of writing a '\0' purely so we can use strdup() to copy the part
before the ':' we instead use strndup(). But I figured that using
the glib string-splitting routine was neater.

thanks
-- PMM

