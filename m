Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E81C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmu0Q-0004OQ-11; Wed, 20 Mar 2024 07:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmu0N-0004Nv-Qq
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:21:12 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmu0L-0001Ja-74
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:21:10 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43107ccd7b9so2847601cf.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710933667; x=1711538467; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaJSo7yYRcQ2aS9IUfIXzodPoVg/Aejstb6SX5ENnCI=;
 b=Tg4YG5Y8RfVuDMs+HdiIBBQnqxmlsFwedODaBVCqXfXSvsr/wDrT91C8t2ynXmhV4+
 HgiSjTsT2TJUzTMTO7nK205e3UTJWyGff/krPtCXRDAAesboBso069pWsLiRvCvsXjit
 9tZZtzlbMA/IiEtJacDfuGZWOBSWK+vheyG4LXeL5DaAmEvNolXFtHab/QsnCl6VBcDC
 cf5Sp3slu4Avgrm1CJFeAEvGktCPfnKMhwKWGH7KiwLjxlLChjD7zyponauMaO5Ty9Hl
 mSA7o8LQnqFq+kjPbpqkya+O8LXmR5E6nc7kEK2BjhRd5W4By6ovprca6Y0q/3pKuqLO
 dKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710933667; x=1711538467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaJSo7yYRcQ2aS9IUfIXzodPoVg/Aejstb6SX5ENnCI=;
 b=wy3P6WxXReqSlgDra1u3Patw+Xaw197CWOPB/X5MpCvucdXlPB1MHP+UT2zRSjK0kZ
 RmsVQwb3nhEjuZ9tc0vSBOxt9vQGE5/Ky7VRwn7kinPVDmjkDTrAMTNsBKPXW6cmvBfo
 ExS2+P/dbRSLdf1wldwYYlNnPqfVaQnmkMvtEGaWeg0YHFEOrAo9wgjVFHuaRDJn+xq8
 44Cw7HbkL73DqUAVE7eAnuo1HT5GrceSE5ZVwuC3EGL9WFfATPghK1QdyE7nTV/6/sSj
 UCLz6I7mZ38gLQXfCuwO5Zn5Dd0DkmesdPlfXMUABQLbonxVdGeRW51MD5Gv3HtYNo1o
 hnUQ==
X-Gm-Message-State: AOJu0YxllBdizt/el6kiZyNyVIbem1k0mONgudBqUxt16C3yBo2hJPD0
 fuXrHhqr58wxSI4zO2WZKBOwre7IYo7fO5mEp2oZoNIIBXcq32uS6LVDKNr79+3u2IOyECTspNV
 bTEpnuJvjjD3V22cJAKt9t53BpVo=
X-Google-Smtp-Source: AGHT+IFDeu+j7WKWlf1LZ6gCKVUlF6Ux8IsvO6hxY1kozZgBU4eHJbDDTnL+KzxiVxsuCT1/pHuiwKuIWhWoFeblaJs=
X-Received: by 2002:ac8:7f4e:0:b0:431:9d:2050 with SMTP id
 g14-20020ac87f4e000000b00431009d2050mr2047168qtk.60.1710933667606; 
 Wed, 20 Mar 2024 04:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240319181724.212753-1-aidan_leuck@selinc.com>
In-Reply-To: <20240319181724.212753-1-aidan_leuck@selinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Mar 2024 15:20:56 +0400
Message-ID: <CAJ+F1CLWCpHSgzuXVaV6EBWRQKM42UaSiivCHjzJGkbW26UNLA@mail.gmail.com>
Subject: Re: [PATCH] Implement SSH commands in QEMU GA for Windows
To: aidan_leuck@selinc.com
Cc: qemu-devel@nongnu.org, micheal.roth@amd.com, kkostiuk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Wed, Mar 20, 2024 at 12:39=E2=80=AFAM <aidan_leuck@selinc.com> wrote:
> +// Converts from a standard string to a Windows wide string.
> +// it is a 16-bit wide character used to store Unicode encoded as UTF-16=
LE/
> +// some Windows API functions require this format of the string as oppos=
ed to just
> +// the normal c char*. This function attempts to convert a standard stri=
ng to
> +// a wide string if it is possible. Some multibyte characters are not su=
pported
> +// so it could throw an error.
> +// Read more here:
> +// https://learn.microsoft.com/en-us/cpp/cpp/char-wchar-t-char16-t-char3=
2-t?view=3Dmsvc-170
> +// parameters:
> +// string - String to convert to a wchar.
> +// errp - Error pointer that will set errors if they are converted
> +// returns - The converted string or NULL if an error occurs.
> +static wchar_t *string_to_wide(const char *string, Error **errp)
> +{

There is g_utf8_to_utf16() which can be cast to wchar_t, iirc, that's
how glib converts string for w32 api



--=20
Marc-Andr=C3=A9 Lureau

