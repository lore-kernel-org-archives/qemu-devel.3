Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C921BF3C991
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuL5-0003DU-9z; Tue, 24 Feb 2026 10:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuuL1-0003Cy-KR
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:28:39 -0500
Received: from mail-yw1-f169.google.com ([209.85.128.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuuKz-0002op-Kj
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:28:39 -0500
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7984d31b895so19174307b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946914; x=1772551714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7K0kt0XWx+sJaS9Z1XIo6FK6vRNtzVvgbSbs3yHlf/E=;
 b=AC4Pe1d+zX+vyKKjw8YKN+Q3yLNk7UydmhlAmwEZG3412mH3V7ZvschYNFYgOADi3f
 wrmOBt9CfT0EgOV5kLx9cCJEG0S5Q33xGTo3H5lAvApePJZ4WlP3E8Pjs3H1zTF0vIVC
 8d62OdUs+8bHzWaT0adnzXOinOHHT1ajtzYFgMItbuGhFO7wYTDqf5IfYsIy3qyMicXB
 kHXnMefLuHdTDTxhkKzOdb7Y0CzPQWJvL78K2lVf6hvG4ZsReLILYZYiwmdln15b9cjw
 c5Z8kIMjYxtTzpGDDfwVab5MMEleVS6M8t0/Fg686WJyChWCJHYOCsxwMnx1Uu/x65Lm
 ejKw==
X-Gm-Message-State: AOJu0Yy4D9CxWTGgv8iDpeabj6Kni3Tapu989kxpR3to+OaAj88pzzqv
 H4Rc4oIIEYm8gUBrfjmD1ZrnggvuQQigrZ4zLuS0HOQISNQbfW3Gk1bbj0ojHIkzCKs=
X-Gm-Gg: ATEYQzyU/iEgJBvEagFQjh8v6Jqd7i9xPWjLiF3iV20KeUFVILel3bTTVhkNj4CWFfE
 h/JKtudgSSVUyZU17xTVdpo1/e0GPV0lp1NtS/aCe89UY4a9JZ0rIuizwezpIr8QUmiz6U5ez0S
 T4ScxoP5kfGHYUbD4QpmPpF7j+/s1BVqSizgD78cOae/lVP0lQcxWW0J1xkefYPYylNz7D8lSaq
 dnM/CPo9Q5SyKrsnqha4nefaXIOW2QqsoyCZX8COpMTJrT+Zw7kXDwjzaWahbwRNrBvqHAiGkVv
 stGAifFBO8zq6yx6VYO+oPHn7xLBTFiEgtK+FH3IuY1wAxotIiMH8nmTPB4J9fCopgdPgTdWg8Q
 SwuewizvLETuZXQTjr1xE/8XjmVUd3e9+tmfoOS73CYRSxeaaSsK++rJdmgG6z3OJ2DCwf2EGQj
 IKy6SVkduo/g5++X8BIPvXK59JkPKZA5NoIvQSdDf4r6zz2x8viF9cJpKqx7Qk3EUGRqrM9mDey
 3KYwcwGIwceMwBnTJCfMFBOdwIKkT6yCQbbJ1fcq7K5DpVYJJE3/W6aC4BBvHY2gsRu9PvQrIHT
 bAMCHrI=
X-Received: by 2002:a05:690c:4b85:b0:794:fb7:d572 with SMTP id
 00721157ae682-798291813c4mr98802147b3.66.1771946913733; 
 Tue, 24 Feb 2026 07:28:33 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com.
 [209.85.128.175]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79862083774sm2130547b3.14.2026.02.24.07.28.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 07:28:33 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-79853c0f5b9so14049637b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:28:33 -0800 (PST)
X-Received: by 2002:a05:690c:f09:b0:797:afb7:b1eb with SMTP id
 00721157ae682-7982902d993mr109445777b3.49.1771946913256; Tue, 24 Feb 2026
 07:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-1-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-1-8ee5ae17056f@bsdimp.com>
From: Gleb Popov <arrowd@freebsd.org>
Date: Tue, 24 Feb 2026 18:28:05 +0300
X-Gmail-Original-Message-ID: <CALH631=aE1pKxXMNxTP6iWsar=_UDT3pKaPKiYWLH1VDwSwVuw@mail.gmail.com>
X-Gm-Features: AaiRm522jxSmsWhB3tt_xACoyHth4lncGwyFWMJDS74PmiJmvy0OXZ0HfD1iFWY
Message-ID: <CALH631=aE1pKxXMNxTP6iWsar=_UDT3pKaPKiYWLH1VDwSwVuw@mail.gmail.com>
Subject: Re: [PATCH v4 01/24] freebsd: FreeBSD 15 has native inotify
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.169; envelope-from=6yearold@gmail.com;
 helo=mail-yw1-f169.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
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

On Tue, Feb 24, 2026 at 5:41=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
>
> Check to make sure that we have inotify in libc, before looking for it
> in libinotify.

This is how I solved the same problem in KDE lands (which uses CMake) [1].
In short, the algorithm is following:
1. Call into pkg-config to see if there is a .pc module for inotify
2. Check if /usr/include/sys/inotify.h exists
3. If there is no pkg-config module and no header -> no inotify
4. If there is no pkg-config module, but the header exists -> we have
"native" inotify,
    no CFLAGS/LDFLAGS manipulation needed
5. If there is pkg-config module, but no header -> use CFLAGS/LDFLAGS from
    pkg-config (IIRC, this is handled by the "dependency" function in
Meson). This
    case happens on FreeBSD where system and 3rd party headers are separate=
d
    (/usr/include vs. /usr/local/include)
6. If we have both pkg-config module and /usr/include/sys/inotify.h,
then we need
    to figure if this header corresponds to libinotify-kqueue, or it
is a native one.
    This is done by comparing the installation prefix of the library and "/=
usr".

Hope that helps.

[1] https://invent.kde.org/frameworks/extra-cmake-modules/-/merge_requests/=
566

