Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7807BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAm7c-0008P7-87; Fri, 02 May 2025 04:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uAm7Z-0008Oh-P2
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:51:49 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uAm7Y-0003bi-2A
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:51:49 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fead317874so15681147b3.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746175906; x=1746780706; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mjw7WP3VeUktfsJVmUrCzOYdQKThI0gi+em4huRCIz0=;
 b=IxTrhcliVAbDSpg5jvc2Nd9OJxNMr3l5W/qCqPqn4jgorm5C9kb2o27inyKyWEUC7N
 1PSsJ5BnKpSF2BMcHhCiGb16iCSRfvmv2TlZBErL18DJOHvN9KI5LSKRqtP9irymEKuB
 rBVefzX4eqXjwouEZ6yyZd9LeYWREr/NaXFmt2wYX1NhCaE+lmjoRsEyUxHBNUKO+7x/
 vFnxyYahAIEhoAn7SV18+xaeQemtjA7+ctMiA9e4pA7QJEjn3dOy7L741eU4kJ9JMKhG
 M+sEozfll+nNWKC5AzMA4Tb7cY4Cs+EKqRHKhcwcAQ/r6E4vPPGfc7/oZmA7U2NBbkyL
 DR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746175906; x=1746780706;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mjw7WP3VeUktfsJVmUrCzOYdQKThI0gi+em4huRCIz0=;
 b=jSRukXpAM3W+qW3jN+RCdwBh49ODCcp1GCcmT7BT2qWlwY8lTV5bEHqrAkBGSW0iOG
 /EdDCI2Zor0bDFMSlc1essR+jjOx7uXrFkqpr5kaJ54z8q41iYofcwvve1jEe7Z0ZLoh
 7K9RKcFbMLmIf+tTjWFhSE539hsBKylSjk8VyuhZxSR7ynJXCDkD2bMFLmxLFVXyr1Tj
 a6raxqbPht+mI2cey4tBRdCYQeXEoIgJ+Lg3ScVnb1ofqt5pLOmivEkrSlajG2RAj81P
 7dZs5e2v7qg2qJ897o9C5EBBFL9u3es5mKJfk3l8Zn5guGx9H/nSWUddH8BpgpX8Pft7
 37vA==
X-Gm-Message-State: AOJu0YxxU2NBK5BWpOYfh1grbIONTrYX1EO2eBh8UrvR+5HkFLsJmQfe
 5Ex9Yj6crmkQ4OvYPvEfzEV3IMHgrzO2hWYCR6ZoJWWcmDpLPot6IUMJKk4AB2vF4gEFNAy95mX
 QzKL0xwplLUcCmUkhfTDp8uuAuHjOc7/Qz6I=
X-Gm-Gg: ASbGncsNkkzIE3g9TOCTjrgQcNIt4y/u3ZgPux64xSUky3Gk6wiUZtuLmNt22aRcvkk
 82MGDeZhsbUQohzKoMooFxJ+SrbVrMppoqhUYEtYQYVb5m+QHpwbDgDf9TdO1/26CFlOOaDqtCJ
 menpCefYKuk7zMq6vUj2tJjMYlR0wmckymnIAa5fjQeWx1lad2jPChbD8=
X-Google-Smtp-Source: AGHT+IE5rpVq4LPLGwf5ydZaTjMmzLutBZdsJ+46PATCYO7kiuv7wIFIWdE7DO2NDCZ/c+GjiGLJh3UGVEZMqOpR+UI=
X-Received: by 2002:a05:690c:670a:b0:705:750e:851 with SMTP id
 00721157ae682-708cee2356amr31679107b3.37.1746175905990; Fri, 02 May 2025
 01:51:45 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?souleymane_cont=C3=A9?= <conte.souleymane@gmail.com>
Date: Fri, 2 May 2025 10:51:34 +0200
X-Gm-Features: ATxdqUGTNQoEnJYngaGUiSpV3MhybdEDwLO-3LhO4hFWvULrgjAE2qO-69L99As
Message-ID: <CAOw3OrFVZbhMbuuAFpL8uZYRYc-MTrpE2Do7Efa4LG0FYoDdmw@mail.gmail.com>
Subject: new contributor
To: qemu-devel@nongnu.org
Cc: "eblake@redhat.com" <eblake@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000978d760634234206"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=conte.souleymane@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000978d760634234206
Content-Type: text/plain; charset="UTF-8"

Hi,
I am interested in contributing to the QEMU project. I would like to begin
by working on the task described in Issue #527 on GitLab:
https://gitlab.com/qemu-project/qemu/-/issues/527.

The task involves Plain text files in docs/ should be converted to rst:
- docs/igd-assign.txt
- docs/image-fuzzer.txt
I would appreciate it if you could confirm that this task is still
available to work on. Once confirmed, I will proceed with preparing and
submitting patches as per the QEMU patch submission guidelines.

Thank you for your time and for maintaining such an important project. I
look forward to contributing.

Best regards,
Souleymane CONTE
GitLab Username: soconte

--000000000000978d760634234206
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>I am interested in contributing to the QEMU project=
. I would like to begin by working on the task described in Issue #527 on G=
itLab: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/527">https:=
//gitlab.com/qemu-project/qemu/-/issues/527</a>.<br><br>The task involves P=
lain text files in docs/ should be converted to rst:<li class=3D"gmail-task=
-list-item">docs/igd-assign.txt</li>
<li class=3D"gmail-task-list-item">docs/image-fuzzer.txt</li><br>I would ap=
preciate it if you could confirm that this task is still available to work =
on. Once confirmed, I will proceed with preparing and submitting patches as=
 per the QEMU patch submission guidelines.<br><br>Thank you for your time a=
nd for maintaining such an important project. I look forward to contributin=
g.<br><br>Best regards, =C2=A0<br>Souleymane CONTE=C2=A0=C2=A0<br>GitLab Us=
ername: soconte=C2=A0<br></div>

--000000000000978d760634234206--

