Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA51D5B85A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVBxU-0008N4-T8; Mon, 15 Dec 2025 12:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vVBvx-00087B-TW
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:00:37 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vVBvs-0004Qu-OA
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765816960; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kJVBGptoFHwiRrOlB5kwtirryOq7AbI2LuPb1cOOOfDUEjjRhxIu+ra0m0Iif52apToUXsdlGc+ILcHAtw7tmhMbGnYl19POr6rP/RKnhCfcc9oeLZ3mDTfr6ecV/WtzPYxfnG0r4FGSjBd90Yh+1+ofw5/Pr0QUhYu0KSTmcbw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765816960;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VbCzz+t8YdxlgPqxrswGhEfoTdtdoqpWAzN1+mJBSz8=; 
 b=bTVKY0Yq0crKXmOe/T36Tsprq05RXuBJGSxGpIgyp3LjT4H5KDgOcmfpKrHZV1JHLjNP0zvTv6/hSHUDfiFD9+xHu0ln8sEHZLE0JoBmDECxKIDf2GlmqTetxnav2/ZwZV7pT98PSszw1JY16u1LZABDkxgc1E6NOVJu1OGj5Do=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765816960; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=VbCzz+t8YdxlgPqxrswGhEfoTdtdoqpWAzN1+mJBSz8=;
 b=dQcEO1lPPlnalSDQTyH5YAtG2/3xFFtcosd0vEn3hc1NBppuYMBT72n2G2Ye/Da2
 OtC+FLzHPnRrTnxTBu+qYNdUW4LQ7fOqbvhSkB4kc8cQH8sBgeT0YI9gCT537r6Rjcx
 lTHAnRJfNW2/zmaMubJk0tAsJwM2XFnBKC3WjeaMC0/ouUE47RK0We2FvkqZJPFQul2
 TvRunMJhp7NkhoxEC/CaS1Gmk2KGKSClpVfw/mnkW+t1g0aXRHAldcD7zGw/4oXYvnF
 1IT7Xm12CEefoJgH+2X8SrcHfzjiOzE/1Nmu5Bajlz+jKqr1shl52ZKAYB64cNdSGPq
 I+EW1XzVTg==
Received: by mx.zohomail.com with SMTPS id 1765816948356745.0852669235609;
 Mon, 15 Dec 2025 08:42:28 -0800 (PST)
Message-ID: <f970cb682c3dc0d66713037c7e27cabb69797b37.camel@icenowy.me>
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
From: Icenowy Zheng <uwu@icenowy.me>
To: Luca Bonissi <qemu@bonslack.org>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Date: Tue, 16 Dec 2025 00:42:23 +0800
In-Reply-To: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
References: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

=E5=9C=A8 2025-10-31=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 14:23 +0100=EF=BC=
=8CLuca Bonissi=E5=86=99=E9=81=93=EF=BC=9A
> > From 6ddab7d3ba1035b5e2a6016bde4776436267c18b Mon Sep 17 00:00:00
> > 2001
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Fri, 31 Oct 2025 13:29:19 +0100
> Subject: [PATCH 1/7] Add termios2 support to linux-user

Sorry but this patch does not build on PowerPC hosts:

```
../linux-user/ioctls.h:4:12: error: =E2=80=98TCGETS2=E2=80=99 undeclared he=
re (not in a
function); did you mean =E2=80=98TCGETS=E2=80=99?
    4 |      IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
      |            ^~~~~~~
../linux-user/syscall.c:5615:23: note: in definition of macro =E2=80=98IOCT=
L=E2=80=99
 5615 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
      |                       ^~~
../linux-user/ioctls.h:5:12: error: =E2=80=98TCSETS2=E2=80=99 undeclared he=
re (not in a
function); did you mean =E2=80=98TCSETS=E2=80=99?
    5 |      IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
      |            ^~~~~~~
../linux-user/syscall.c:5615:23: note: in definition of macro =E2=80=98IOCT=
L=E2=80=99
 5615 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
      |                       ^~~
../linux-user/ioctls.h:6:12: error: =E2=80=98TCSETSW2=E2=80=99 undeclared h=
ere (not in
a function); did you mean =E2=80=98TCSETSW=E2=80=99?
    6 |      IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
      |            ^~~~~~~~
../linux-user/syscall.c:5615:23: note: in definition of macro =E2=80=98IOCT=
L=E2=80=99
 5615 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
      |                       ^~~
../linux-user/ioctls.h:7:12: error: =E2=80=98TCSETSF2=E2=80=99 undeclared h=
ere (not in
a function); did you mean =E2=80=98TCSETSF=E2=80=99?
    7 |      IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
      |            ^~~~~~~~
../linux-user/syscall.c:5615:23: note: in definition of macro =E2=80=98IOCT=
L=E2=80=99
 5615 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
      |                       ^~~
../linux-user/syscall.c: In function =E2=80=98target_to_host_termios2=E2=80=
=99:
../linux-user/syscall.c:5940:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5940 |     host->c_iflag =3D
      |         ^~
../linux-user/syscall.c:5942:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5942 |     host->c_oflag =3D
      |         ^~
../linux-user/syscall.c:5944:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5944 |     host->c_cflag =3D
      |         ^~
../linux-user/syscall.c:5946:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5946 |     host->c_lflag =3D
      |         ^~
../linux-user/syscall.c:5948:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5948 |     host->c_line =3D target->c_line;
      |         ^~
../linux-user/syscall.c:5949:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5949 |     host->c_ispeed =3D tswap32(target->c_ispeed);
      |         ^~
../linux-user/syscall.c:5950:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5950 |     host->c_ospeed =3D tswap32(target->c_ospeed);
      |         ^~
../linux-user/syscall.c:5952:16: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5952 |     memset(host->c_cc, 0, sizeof(host->c_cc));
      |                ^~
../linux-user/syscall.c:5952:38: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5952 |     memset(host->c_cc, 0, sizeof(host->c_cc));
      |                                      ^~
../linux-user/syscall.c:5953:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5953 |     host->c_cc[VINTR] =3D target->c_cc[TARGET_VINTR];
      |         ^~
../linux-user/syscall.c:5954:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5954 |     host->c_cc[VQUIT] =3D target->c_cc[TARGET_VQUIT];
      |         ^~
../linux-user/syscall.c:5955:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5955 |     host->c_cc[VERASE] =3D target->c_cc[TARGET_VERASE];
      |         ^~
../linux-user/syscall.c:5956:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5956 |     host->c_cc[VKILL] =3D target->c_cc[TARGET_VKILL];
      |         ^~
../linux-user/syscall.c:5957:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5957 |     host->c_cc[VEOF] =3D target->c_cc[TARGET_VEOF];
      |         ^~
../linux-user/syscall.c:5958:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5958 |     host->c_cc[VTIME] =3D target->c_cc[TARGET_VTIME];
      |         ^~
../linux-user/syscall.c:5959:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5959 |     host->c_cc[VMIN] =3D target->c_cc[TARGET_VMIN];
      |         ^~
../linux-user/syscall.c:5960:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5960 |     host->c_cc[VSWTC] =3D target->c_cc[TARGET_VSWTC];
      |         ^~
../linux-user/syscall.c:5961:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5961 |     host->c_cc[VSTART] =3D target->c_cc[TARGET_VSTART];
      |         ^~
../linux-user/syscall.c:5962:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5962 |     host->c_cc[VSTOP] =3D target->c_cc[TARGET_VSTOP];
      |         ^~
../linux-user/syscall.c:5963:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5963 |     host->c_cc[VSUSP] =3D target->c_cc[TARGET_VSUSP];
      |         ^~
../linux-user/syscall.c:5964:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5964 |     host->c_cc[VEOL] =3D target->c_cc[TARGET_VEOL];
      |         ^~
../linux-user/syscall.c:5965:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5965 |     host->c_cc[VREPRINT] =3D target->c_cc[TARGET_VREPRINT];
      |         ^~
../linux-user/syscall.c:5966:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5966 |     host->c_cc[VDISCARD] =3D target->c_cc[TARGET_VDISCARD];
      |         ^~
../linux-user/syscall.c:5967:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5967 |     host->c_cc[VWERASE] =3D target->c_cc[TARGET_VWERASE];
      |         ^~
../linux-user/syscall.c:5968:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5968 |     host->c_cc[VLNEXT] =3D target->c_cc[TARGET_VLNEXT];
      |         ^~
../linux-user/syscall.c:5969:9: error: invalid use of undefined type
=E2=80=98struct host_termios2=E2=80=99
 5969 |     host->c_cc[VEOL2] =3D target->c_cc[TARGET_VEOL2];
      |         ^~
In file included from ../linux-user/user-internals.h:21,
                 from ../linux-user/syscall.c:137:
../linux-user/syscall.c: In function =E2=80=98host_to_target_termios2=E2=80=
=99:
../linux-user/syscall.c:5978:44: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5978 |         tswap32(host_to_target_bitmask(host->c_iflag,
iflag_tbl));
      |                                            ^~
/var/cache/acbs/build/acbs.62hveo8z/qemu-
10.1.2/src.user/include/user/thunk.h:209:32: note: in definition of
macro =E2=80=98host_to_target_bitmask=E2=80=99
  209 |     host_to_target_bitmask_len(M, T, ARRAY_SIZE(T))
      |                                ^
../linux-user/syscall.c:5980:44: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5980 |         tswap32(host_to_target_bitmask(host->c_oflag,
oflag_tbl));
      |                                            ^~
/var/cache/acbs/build/acbs.62hveo8z/qemu-
10.1.2/src.user/include/user/thunk.h:209:32: note: in definition of
macro =E2=80=98host_to_target_bitmask=E2=80=99
  209 |     host_to_target_bitmask_len(M, T, ARRAY_SIZE(T))
      |                                ^
../linux-user/syscall.c:5982:44: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5982 |         tswap32(host_to_target_bitmask(host->c_cflag,
cflag_tbl));
      |                                            ^~
/var/cache/acbs/build/acbs.62hveo8z/qemu-
10.1.2/src.user/include/user/thunk.h:209:32: note: in definition of
macro =E2=80=98host_to_target_bitmask=E2=80=99
  209 |     host_to_target_bitmask_len(M, T, ARRAY_SIZE(T))
      |                                ^
../linux-user/syscall.c:5984:44: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5984 |         tswap32(host_to_target_bitmask(host->c_lflag,
lflag_tbl));
      |                                            ^~
/var/cache/acbs/build/acbs.62hveo8z/qemu-
10.1.2/src.user/include/user/thunk.h:209:32: note: in definition of
macro =E2=80=98host_to_target_bitmask=E2=80=99
  209 |     host_to_target_bitmask_len(M, T, ARRAY_SIZE(T))
      |                                ^
../linux-user/syscall.c:5985:26: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5985 |     target->c_line =3D host->c_line;
      |                          ^~
../linux-user/syscall.c:5986:36: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5986 |     target->c_ispeed =3D tswap32(host->c_ispeed);
      |                                    ^~
../linux-user/syscall.c:5987:36: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5987 |     target->c_ospeed =3D tswap32(host->c_ospeed);
      |                                    ^~
../linux-user/syscall.c:5990:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5990 |     target->c_cc[TARGET_VINTR] =3D host->c_cc[VINTR];
      |                                      ^~
../linux-user/syscall.c:5991:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5991 |     target->c_cc[TARGET_VQUIT] =3D host->c_cc[VQUIT];
      |                                      ^~
../linux-user/syscall.c:5992:39: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5992 |     target->c_cc[TARGET_VERASE] =3D host->c_cc[VERASE];
      |                                       ^~
../linux-user/syscall.c:5993:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5993 |     target->c_cc[TARGET_VKILL] =3D host->c_cc[VKILL];
      |                                      ^~
../linux-user/syscall.c:5994:37: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5994 |     target->c_cc[TARGET_VEOF] =3D host->c_cc[VEOF];
      |                                     ^~
../linux-user/syscall.c:5995:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5995 |     target->c_cc[TARGET_VTIME] =3D host->c_cc[VTIME];
      |                                      ^~
../linux-user/syscall.c:5996:37: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5996 |     target->c_cc[TARGET_VMIN] =3D host->c_cc[VMIN];
      |                                     ^~
../linux-user/syscall.c:5997:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5997 |     target->c_cc[TARGET_VSWTC] =3D host->c_cc[VSWTC];
      |                                      ^~
../linux-user/syscall.c:5998:39: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5998 |     target->c_cc[TARGET_VSTART] =3D host->c_cc[VSTART];
      |                                       ^~
../linux-user/syscall.c:5999:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 5999 |     target->c_cc[TARGET_VSTOP] =3D host->c_cc[VSTOP];
      |                                      ^~
../linux-user/syscall.c:6000:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6000 |     target->c_cc[TARGET_VSUSP] =3D host->c_cc[VSUSP];
      |                                      ^~
../linux-user/syscall.c:6001:37: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6001 |     target->c_cc[TARGET_VEOL] =3D host->c_cc[VEOL];
      |                                     ^~
../linux-user/syscall.c:6002:41: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6002 |     target->c_cc[TARGET_VREPRINT] =3D host->c_cc[VREPRINT];
      |                                         ^~
../linux-user/syscall.c:6003:41: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6003 |     target->c_cc[TARGET_VDISCARD] =3D host->c_cc[VDISCARD];
      |                                         ^~
../linux-user/syscall.c:6004:40: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6004 |     target->c_cc[TARGET_VWERASE] =3D host->c_cc[VWERASE];
      |                                        ^~
../linux-user/syscall.c:6005:39: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6005 |     target->c_cc[TARGET_VLNEXT] =3D host->c_cc[VLNEXT];
      |                                       ^~
../linux-user/syscall.c:6006:38: error: invalid use of undefined type
=E2=80=98const struct host_termios2=E2=80=99
 6006 |     target->c_cc[TARGET_VEOL2] =3D host->c_cc[VEOL2];
      |                                      ^~
../linux-user/syscall.c: At top level:
../linux-user/syscall.c:6011:54: error: invalid application of =E2=80=98siz=
eof=E2=80=99
to incomplete type =E2=80=98struct host_termios2=E2=80=99
 6011 |     .size =3D { sizeof(struct target_termios2), sizeof(struct
host_termios2) },
      |                                                      ^~~~~~
../linux-user/syscall.c:6012:65: error: invalid application of
=E2=80=98__alignof__=E2=80=99 to incomplete type =E2=80=98struct host_termi=
os2=E2=80=99
 6012 |     .align =3D { __alignof__(struct target_termios2),
__alignof__(struct host_termios2) },
      |                                                              =20
^~~~~~
```

(The whole patchset rebased onto v10.1.2)

It seems that PowerPC do not have a `termios2` interface in kernel --
the `termios` here is just `termios2` .

>=20
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> ---
> =C2=A0linux-user/ioctls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 6 +++
> =C2=A0linux-user/strace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 69 ++++++++++++++++++++++++++++++
> =C2=A0linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 84
> +++++++++++++++++++++++++++++++++++++
> =C2=A0linux-user/syscall_types.h=C2=A0 |=C2=A0 3 ++
> =C2=A0linux-user/user-internals.h |=C2=A0 3 ++
> =C2=A05 files changed, 165 insertions(+)
>=20
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2f62fd2cb9..6ecfe6306e 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -1,5 +1,11 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* emulated ioctl list */
> =C2=A0
> +#ifdef TARGET_TCGETS2
> +=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_t=
ermios2)))
> +=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_t=
ermios2)))
> +=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_=
termios2)))
> +=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_=
termios2)))
> +#endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCGETS, IOC_R, MK_PTR(MK_STRUCT(STRU=
CT_termios)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCSETS, IOC_W, MK_PTR(MK_STRUCT(STRU=
CT_termios)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IOCTL(TCSETSF, IOC_W, MK_PTR(MK_STRUCT(STR=
UCT_termios)))
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 758c5d32b6..7afb94544f 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1935,6 +1935,75 @@ print_termios(void *arg)
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("}");
> =C2=A0}
> =C2=A0
> +#ifdef TARGET_TCGETS2
> +void
> +print_termios2(void *arg)
> +{
> +=C2=A0=C2=A0=C2=A0 const struct target_termios2 *target =3D arg;
> +
> +=C2=A0=C2=A0=C2=A0 target_tcflag_t iflags =3D tswap32(target->c_iflag);
> +=C2=A0=C2=A0=C2=A0 target_tcflag_t oflags =3D tswap32(target->c_oflag);
> +=C2=A0=C2=A0=C2=A0 target_tcflag_t cflags =3D tswap32(target->c_cflag);
> +=C2=A0=C2=A0=C2=A0 target_tcflag_t lflags =3D tswap32(target->c_lflag);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("{");
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_iflag =3D ");
> +=C2=A0=C2=A0=C2=A0 print_flags(termios_iflags, iflags, 0);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_oflag =3D ");
> +=C2=A0=C2=A0=C2=A0 target_tcflag_t oflags_clean =3D=C2=A0 oflags & ~(TAR=
GET_NLDLY |
> TARGET_CRDLY |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TARGET_TABDLY |
> TARGET_BSDLY |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TARGET_VTDLY |
> TARGET_FFDLY);
> +=C2=A0=C2=A0=C2=A0 print_flags(termios_oflags, oflags_clean, 0);
> +=C2=A0=C2=A0=C2=A0 if (oflags & TARGET_NLDLY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_oflags_NL=
DLY, oflags & TARGET_NLDLY, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (oflags & TARGET_CRDLY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_oflags_CR=
DLY, oflags & TARGET_CRDLY, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (oflags & TARGET_TABDLY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_oflags_TA=
BDLY, oflags & TARGET_TABDLY,
> 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (oflags & TARGET_BSDLY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_oflags_BS=
DLY, oflags & TARGET_BSDLY, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (oflags & TARGET_VTDLY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_oflags_VT=
DLY, oflags & TARGET_VTDLY, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (oflags & TARGET_FFDLY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_oflags_FF=
DLY, oflags & TARGET_FFDLY, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_cflag =3D ");
> +=C2=A0=C2=A0=C2=A0 if (cflags & TARGET_CBAUD) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_cflags_CB=
AUD, cflags & TARGET_CBAUD, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (cflags & TARGET_CSIZE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_enums(termios_cflags_CS=
IZE, cflags & TARGET_CSIZE, 0);
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 target_tcflag_t cflags_clean =3D cflags & ~(TARGET_CB=
AUD |
> TARGET_CSIZE);
> +=C2=A0=C2=A0=C2=A0 print_flags(termios_cflags, cflags_clean, 0);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_lflag =3D ");
> +=C2=A0=C2=A0=C2=A0 print_flags(termios_lflags, lflags, 0);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_ispeed =3D ");
> +=C2=A0=C2=A0=C2=A0 print_raw_param("%u", tswap32(target->c_ispeed), 0);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_ospeed =3D ");
> +=C2=A0=C2=A0=C2=A0 print_raw_param("%u", tswap32(target->c_ospeed), 0);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_cc =3D ");
> +=C2=A0=C2=A0=C2=A0 qemu_log("\"%s\",", target->c_cc);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("c_line =3D ");
> +=C2=A0=C2=A0=C2=A0 print_raw_param("\'%c\'", target->c_line, 1);
> +
> +=C2=A0=C2=A0=C2=A0 qemu_log("}");
> +}
> +#endif
> +
> =C2=A0#undef UNUSED
> =C2=A0
> =C2=A0#ifdef TARGET_NR_accept
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8546f48a05..920bf23406 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -86,6 +86,7 @@
> =C2=A0#endif
> =C2=A0
> =C2=A0#define termios host_termios
> +#define termios2 host_termios2
> =C2=A0#define winsize host_winsize
> =C2=A0#define termio host_termio
> =C2=A0#define sgttyb host_sgttyb /* same as target */
> @@ -5885,6 +5886,89 @@ static const StructEntry struct_termios_def =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 .print =3D print_termios,
> =C2=A0};
> =C2=A0
> +#ifdef TARGET_TCGETS2
> +static void target_to_host_termios2 (void *dst, const void *src)
> +{
> +=C2=A0=C2=A0=C2=A0 struct host_termios2 *host =3D dst;
> +=C2=A0=C2=A0=C2=A0 const struct target_termios2 *target =3D src;
> +
> +=C2=A0=C2=A0=C2=A0 host->c_iflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_to_host_bitmask(tswap3=
2(target->c_iflag), iflag_tbl);
> +=C2=A0=C2=A0=C2=A0 host->c_oflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_to_host_bitmask(tswap3=
2(target->c_oflag), oflag_tbl);
> +=C2=A0=C2=A0=C2=A0 host->c_cflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_to_host_bitmask(tswap3=
2(target->c_cflag), cflag_tbl);
> +=C2=A0=C2=A0=C2=A0 host->c_lflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_to_host_bitmask(tswap3=
2(target->c_lflag), lflag_tbl);
> +=C2=A0=C2=A0=C2=A0 host->c_line =3D target->c_line;
> +=C2=A0=C2=A0=C2=A0 host->c_ispeed =3D tswap32(target->c_ispeed);
> +=C2=A0=C2=A0=C2=A0 host->c_ospeed =3D tswap32(target->c_ospeed);
> +
> +=C2=A0=C2=A0=C2=A0 memset(host->c_cc, 0, sizeof(host->c_cc));
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VINTR] =3D target->c_cc[TARGET_VINTR];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VQUIT] =3D target->c_cc[TARGET_VQUIT];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VERASE] =3D target->c_cc[TARGET_VERASE];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VKILL] =3D target->c_cc[TARGET_VKILL];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VEOF] =3D target->c_cc[TARGET_VEOF];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VTIME] =3D target->c_cc[TARGET_VTIME];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VMIN] =3D target->c_cc[TARGET_VMIN];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VSWTC] =3D target->c_cc[TARGET_VSWTC];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VSTART] =3D target->c_cc[TARGET_VSTART];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VSTOP] =3D target->c_cc[TARGET_VSTOP];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VSUSP] =3D target->c_cc[TARGET_VSUSP];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VEOL] =3D target->c_cc[TARGET_VEOL];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VREPRINT] =3D target->c_cc[TARGET_VREPRINT=
];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VDISCARD] =3D target->c_cc[TARGET_VDISCARD=
];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VWERASE] =3D target->c_cc[TARGET_VWERASE];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VLNEXT] =3D target->c_cc[TARGET_VLNEXT];
> +=C2=A0=C2=A0=C2=A0 host->c_cc[VEOL2] =3D target->c_cc[TARGET_VEOL2];
> +}
> +
> +static void host_to_target_termios2 (void *dst, const void *src)
> +{
> +=C2=A0=C2=A0=C2=A0 struct target_termios2 *target =3D dst;
> +=C2=A0=C2=A0=C2=A0 const struct host_termios2 *host =3D src;
> +
> +=C2=A0=C2=A0=C2=A0 target->c_iflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tswap32(host_to_target_bitmas=
k(host->c_iflag, iflag_tbl));
> +=C2=A0=C2=A0=C2=A0 target->c_oflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tswap32(host_to_target_bitmas=
k(host->c_oflag, oflag_tbl));
> +=C2=A0=C2=A0=C2=A0 target->c_cflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tswap32(host_to_target_bitmas=
k(host->c_cflag, cflag_tbl));
> +=C2=A0=C2=A0=C2=A0 target->c_lflag =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tswap32(host_to_target_bitmas=
k(host->c_lflag, lflag_tbl));
> +=C2=A0=C2=A0=C2=A0 target->c_line =3D host->c_line;
> +=C2=A0=C2=A0=C2=A0 target->c_ispeed =3D tswap32(host->c_ispeed);
> +=C2=A0=C2=A0=C2=A0 target->c_ospeed =3D tswap32(host->c_ospeed);
> +
> +=C2=A0=C2=A0=C2=A0 memset(target->c_cc, 0, sizeof(target->c_cc));
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VINTR] =3D host->c_cc[VINTR];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VQUIT] =3D host->c_cc[VQUIT];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VERASE] =3D host->c_cc[VERASE];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VKILL] =3D host->c_cc[VKILL];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VEOF] =3D host->c_cc[VEOF];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VTIME] =3D host->c_cc[VTIME];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VMIN] =3D host->c_cc[VMIN];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VSWTC] =3D host->c_cc[VSWTC];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VSTART] =3D host->c_cc[VSTART];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VSTOP] =3D host->c_cc[VSTOP];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VSUSP] =3D host->c_cc[VSUSP];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VEOL] =3D host->c_cc[VEOL];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VREPRINT] =3D host->c_cc[VREPRINT=
];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VDISCARD] =3D host->c_cc[VDISCARD=
];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VWERASE] =3D host->c_cc[VWERASE];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VLNEXT] =3D host->c_cc[VLNEXT];
> +=C2=A0=C2=A0=C2=A0 target->c_cc[TARGET_VEOL2] =3D host->c_cc[VEOL2];
> +}
> +
> +static const StructEntry struct_termios2_def =3D {
> +=C2=A0=C2=A0=C2=A0 .convert =3D { host_to_target_termios2, target_to_hos=
t_termios2 },
> +=C2=A0=C2=A0=C2=A0 .size =3D { sizeof(struct target_termios2), sizeof(st=
ruct
> host_termios2) },
> +=C2=A0=C2=A0=C2=A0 .align =3D { __alignof__(struct target_termios2),
> __alignof__(struct host_termios2) },
> +=C2=A0=C2=A0=C2=A0 .print =3D print_termios2,
> +};
> +#endif
> +
> =C2=A0/* If the host does not provide these bits, they may be safely
> discarded. */
> =C2=A0#ifndef MAP_SYNC
> =C2=A0#define MAP_SYNC 0
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 6dd7a80ce5..ac45705acf 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -1,4 +1,7 @@
> =C2=A0STRUCT_SPECIAL(termios)
> +#ifdef TARGET_TCGETS2
> +STRUCT_SPECIAL(termios2)
> +#endif
> =C2=A0
> =C2=A0STRUCT(winsize,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_SHORT, TYPE_SHORT, TYPE_S=
HORT, TYPE_SHORT)
> diff --git a/linux-user/user-internals.h b/linux-user/user-
> internals.h
> index 7099349ec8..067c02bb93 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -129,6 +129,9 @@ static inline uint64_t target_offset64(uint64_t
> word0, uint64_t word1)
> =C2=A0#endif /* TARGET_ABI_BITS !=3D 32 */
> =C2=A0
> =C2=A0void print_termios(void *arg);
> +#ifdef TARGET_TCGETS2
> +void print_termios2(void *arg);
> +#endif
> =C2=A0
> =C2=A0/* ARM EABI and MIPS expect 64bit types aligned even on pairs or
> registers */
> =C2=A0#ifdef TARGET_ARM


