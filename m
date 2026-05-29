Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AB7CD6E55
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57d-00068h-7p; Fri, 29 May 2026 17:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57c-00067p-7E; Fri, 29 May 2026 17:52:04 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57a-0007Zs-DN; Fri, 29 May 2026 17:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091492; x=1780696292; i=deller@gmx.de;
 bh=dvNnlIAG+q93Qs1mW0KnP2WpXASAz//DaVDOTr81ee8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TmJ2kOJJi2tuwo7R61NJLOthSG9jAlJBMqoNw4yCZwaFoF+JDgCUMkD5xdtVR2FL
 qt5w4bPKt3TkHcBZYJnfQMzbkcDhgn+Y2w5uIRLU8qAjGh3nGt9xC9gZ9jZ3OQPgE
 EtLV0nQO7300HQ6XOJsDTR7l3GXUYLsasqlMn5yuiACn4hEWzUkXOaXUIOprycNGP
 VLP0nk8nnUJoAKwntJ7OI5PQYq5HS5lv8FIHQnuR77lXPwdcmcIblcKCum3eZ9t6Q
 Rb4FaPQIX3v6APf50BDso7GHHWbiWMRz9PEU6IODEL8DvODahsVYcpLzecCZRsDlZ
 u9hCSxqNtET+WqOEIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1wnot90whj-00SG8S; Fri, 29
 May 2026 23:51:32 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL v3 00/10] Linux user next patches
Date: Fri, 29 May 2026 23:51:09 +0200
Message-ID: <20260529215119.73244-1-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ru0AjQRvg5I8cpWJmF2fsJHp1EP7h91nH+Cld7oseqm6SvWQy+c
 a5lcdUPE3rQZSzbXbsHkBaMLiTMjACFYREG+isUpCRJ/mXD1AJaGKxn3pnwDVVcGZKRgCzR
 5oCaY77SzjX5qX0iEiqzM+w5/soWJMx+GAgvfGHbrJHy30rcNxuElv5ms7k+YxkNWtlEVgz
 oUcN7jXE6fHuPFp3MQnBA==
UI-OutboundReport: notjunk:1;M01:P0:TDYBKP9Lmsw=;m8c87bWausnXvdyQGGh8op7qXhY
 c/ZxaVIlK9oBESPWapWKIdvKTGmmT5FjEFpv5NICLbJEDmhVt1gDjWjdukYwMynjfS/O1uIql
 Mmot5wgzhWfYpkR5+i2SC87mKwiKVr/dRk+E1itM+xYpdy708m6YnIKDmr44QdFIPyFI7e4Cc
 i8TGWv5Eej9se7Qq8HCuW7B0EtRP/tIxmsgl64X4kc+g+KcmSc2SYipKNj1McMETzIYtkUMT0
 TCuw9QFo6RSEKukUx2ID//lNWIL+YSPMHSMJcRRzzSksaCrbnwWEY2ucbi6jgsmVEHjWsJ673
 wbxuUEyquYKWC3GG2Z/F7B75p8NJZAl4L8sf4sCId/pL6eCLC97en1c5JqnHSit4ahMur5nYr
 k1oQ2QOSkokUN5Rp8WPIusGQD+eSE8Nne8uHz8kaUmQ7n3yIavWqwPaBfo6BfRsMroy0miu1u
 3J3gNlHur2X2riCbZF9LReVOH6XK6vSX0t91u+/EKRC9V8DGc0heHfqElmRF4jyJT37HMnd9i
 EURiAB4ft2tyW5MUTecOxn9JmyrqqEGP/v/OIN8bGuEFoFnwY1TMyIdGX8sqSnd+QXAoql/LM
 4hOsvN9pK4HeF1Tfo8Fb9YvsrIiqFkRMfAR1obZEjW6AfdHF7qTtVXMDEQsxAFpmPqV4XD8HH
 +mL+8QkhE0MfOHa1CT146K0+UE5zbclDxEXJhITSpFshnzeU3iwjQPy85r5HGS/wi2mr9WHK8
 Y91X/FYGfUN4m/LkleVwRyeuYW12W+uW/gc5GIVOimbyNfqogmMgT65ip8sPDH40b7dEeoNQM
 uaWqr7UeKo21diQRlg6xkm2Of8jbR7iUBTDiovx0wJi3S/+XCrDAF2Ek72lmdeWr7N93xKZag
 VGFuN6gtxdNqkKe/+jnvnT7FSHke6cBYsaT5f1GMnkmQLsbykgdg9oFect7Jo9YwaADM7Ud+A
 TfU6HSv4MS1QAPfoJvTM3ELbvqGuDVRkSqbCRoiPqxZN3/vAXJrglOxqW9ki46xQhFnekB3GQ
 aHRqfT4TEZLPFgatdcuDFjlAt4QIE+KguKhVqyD+t0PdkVFgz4OobXe1ZC1DAb3t9xhhpXxcH
 fpVtQy1jhkU7U3to9VQMQVsIAqRll6NtlNOXJbQcLOVaoPck16/5UKK/AXrCCUlwFMpWz9J15
 ar2g38SHOyQp9sY6XPsXOX1e12ltOLaV2gQ0KxNFzH1sPJk2KwuczMYRwGGPR6U7xhAYUWOCf
 /ALM9JWLcVSLTd91vKQuhTLjo8OQnX/cfvVhOlCRgwaHPROuJNnfgRbb51lsdZSwlXYLdK9IR
 xxSbcIsLpa7KmeHj2bsUT54EYAoRjGLjIi/h2NZLGIVVQXcWybrE1K95A38UolKGiDWoR8CX2
 JLt3PBEGs3+Jvg00gRXDfK+60bh7O3nAdvx0jXtylmwykDRj0kX/dkyJphI9Ps9tXXO7ur4j0
 YkSOqyLyxcmDvp0flHIypVZOkS5GHnYaysCY5IE8gmy79zDbUIeqPdg03Q4CvmrZZ1jXLIJtF
 qLX5s69sfPWMvkDbiEHZv9/XzeGEU78rofeq8+TIoY5dtpUjS11pYimehuL2TsO7VYkONpjXT
 X7dR3vHcHCI+2BCtqQXdX12qEnWFTq/GfW+DWc7Fe9mZrzCotnDZzuyfseM8JShRkMNeBN3Oi
 NjrsCKPRDjkAvFGy4J5yZ77/kj/FXB0n9E97DtqGpGN1mmclIty6Fu6k9R+03ViIZN6iOLcuf
 9FEWRI8AVXavPufFfhh+zh3r0pKjcH/mTsFx9X8l+t8gUppI3JdVfQ5R/Z/0K4l6J2Z3VogLI
 vMlInCOHMzn3kS9skswdpVYg6YY+IxN6iByViFLl+FFqmujTZi2xnzewDwsDC040oneCXRqjH
 /+AV97hKYN6wVp/JHixVf2avoeE2/FaWh4hRFRV9C5QAmju09LGxSX2k7VWvK7IkXbjiVMTsy
 2u67lxf+lj0wqTsGx8cBJqsB5FLTMN0oBVpQynZV5SU1ekDovL0biwOxSfdmL48D+odwvgBHu
 YEubkLUWfO7VEEVfwkuCEQ9q2m5Uln/ijuaCaSpxYSmCroXYGvZ3tQhOcG+A33L+qREuWE9Hl
 0z2RzExh3Nhy8gBxV67NwMDzZ3/xyBK7C7inY2Wx/j3kyUhBjD1hekL3d3FU1KyxiTgcS6HXK
 Xaqd115Vc5uAM90euApFtb/qwUT20eymHQumVdscVirT8iJdhNWwRYVJXLRdp/tP5yZTNdTYZ
 G13rDO5wLk3l9U/eCbQj1PbXTzT7ATsz76Lv5EH1kdFYjnuP4OcJUcNORYNoSDxMUDBZvc4pT
 79oc7i0Va+hyifXG2EDHIt764QL3PjW6on7Xd5b1C9AqOPdl7PjlZc8HZ3vfMK7G1uVgRlKjm
 C0E7KiGuwzy5aKUwrzigMf5mqv5e82VxZAUCg8rQ+GUvTd98kF9SexqVAxWY9UDraDRT7xEzN
 QFlzYwfTM048IKWBYHES6mSVbmzF7+VyJvYFvPAiC4jp7YnKcyHbjNQgzQHTw4CtIvD0g2NCI
 jTfw0HV1JYI1pmE06spbG51yAoksXzfbrRw6mXnqPVsi5qH6Ga3w6WPvrs9b/kE7bM4OVDTNr
 EqgyjiR+hnLoZRInTWfpwO2gInVE+XqmgGUeCvgltjDWa5nJQsE3XvHM/98zW7jap1AnyhKZ9
 h4L+i3Yd8Z6zQrCPlyXWqw4PJGuB3dl3Q++aicr1lPL28uKUdkQ/2/TCMTk8n13j+usrDXdoa
 1hMjQVSEYgLUebfJg0mWhdGqzGBmlQB7Ao22soxC2faV0X9WnKzd4ODWBuUIe5jwavNRURA6L
 vOEN1c2o7iSqvR9d/hd5iXPBmcXM+ZitPjmpCzh5KbVsbx/0QAA5BUQh1jGJua5rVmsSoAvTC
 DFZrLUi3i1E8OK8MTq5TyuE3m90IdVikqfrEyVEObZ+dQFav8MS5RZ1r/yah6HORJMVauEcVK
 kQUOwsP1TSjc4pOn4iI86K/gxPS9BGb2LrCP6Vyk+jlqss8JjMA2L/O8zPFyEXc+I5Dgw5AwS
 HxTCuZejCmlXZ3t/9/h+z180KZq47+eUvmLNNoj0wxYb8Yx+TC++E+MooXiC3CUAItlS86RN3
 rCwNnZ1MMxpBZApPrr4i08dtZz8rbqEEHnZwi6IVYfLOdNNbDfixE4aUIBQNiCCzSOB4sUL/s
 4ZhmcBscP/F76BPNXE3AgGeYiw+4xjPZxxgSknPy/viP/3asAPrXCe0/0CJHpyqqjp4Oc5tsV
 otsCMAQdboob603LFhwG4fXQ/9CV2wy+t89N+sCkiVhWi9dcpDVSzVwjMcJL+A39OUA12wJ4d
 5uC/FA5x2Lb1fFw2peMyuOhCABnj0XEY3fMkAo0mvWQmiwP7+UPJLVUE7pp0nca+iHD3Rolsy
 M1HTH/Xn/WbCxz3do+vVLW7qzLZn212T/pLMH7e3aFslK30cngcYO8bxgL9zFc8YfQ9M7kca1
 huK8kpANxka1IRpr9WC6bzUsyCVCSJYWXK4eGvuHr/bNLtZAjBJGK440Q5HxBZQvKiyPkFQ5p
 acBugCWuu1ARgdq8REOw7OFg4uo5/KvTDyluqgNxmsRLhmp8rbV0iqAOBx7Ki8r3PBwhmZERE
 lSu+5/5He0tYRBtFHmlW+jS3gMyBbRGGN0uYemCalkGeuTL7tPwPoF4bT42gXQe8JBH8vDHlZ
 S2NWFiwWg8YX32ZKAl0qtqGLyOyJHweD6yjYHZVXrdkoB3jRz/Xc4zySHgBXR4MrcBXfQi/Mm
 nBTUuXTGO+UTAAeDooY8itr5sN4086olMI4DuiCmK+KRbj1wCEg3TKXMw5BnFzOWnRmNtEPkQ
 uCsH+t9wfRp3oYzYEXwfxWfyMpWK4scBENh5ivfZ2+etvu/bdrpFgYD95DfaVxP77RndfZ2Zl
 oa6WuBbeueLk7QJZRebF83bPzp3R3nxLQlpsRGGzxW29dJZJ+cAMpYzPFjKcT29vQhfyEAQAd
 wcMqqeukJzNn5/tCW0grfOURMHSTW1XJ3OkY0X41J9rVu1TsAugvD6fjiwLczzgGcEOOF+ZXP
 xmP1gCoyOPGWeeoJXJ8gxkDlv95e9Shk3F5ZN8Ox4ZjYwRDydv4WSrBb/9E+oGNBh+4Zz5suU
 L0fdmzWwQF3V8WjeKrcRQE7Kw2VhFAcc1+/N7UJNyWrvPXpgZ8X2Gje/tB8BBAHko12RAq4CD
 Pe0BnFu3O2kJfxf14gYNKliXh4KouVO921ZO47NlcyC9lvulMaL+z3cleNhsrMMSJ4qHAqaHh
 EJuzHKdptf52unKIvr0J9JayMnclKguFdPMoqsO37qY7GaZtiSYnTYpyt1MExZt+6AsrsWByG
 fJdNJam9tdhFvEG320hQCI7/wRwlDJrJFOXqffI7DjTYGb7F8p+eGFWV+pOdm8u/8pcivx/Dl
 hZ/4AKZ8ZgX29fz/F35khV00xuDq0SJViXyPbghRCqebGXxw5Qt6MCwbkaBVURqkIS6VWE0Rh
 C+rDJVTVl6hwu3oLWH5pnnXJNUwsYWiSNBSeKqHJwaKpdmdhCVe6igWqlChf0rjnvAfQOZC3k
 ZVM/dOy2Za/tAUlg+hBq1wmdojvQl+cmRL3k2eDQOYMvwxiDBmr7IbWB70F3jsfqbQAFNmoEh
 IS2XahdyotNPS608cO5bfs6SyjaGIFDTdg5zu0NZEjKFihOrCu8KUMjqEc/fxfw045n9O00Fn
 iqzIAsAQW34OqZdoF1dtf6qSNKQjU/gLTr32RgZbreflVNIpgV238idTotWZPapDEwuub8ldf
 zUoyHKvjwEodDAWqXrEF4cfEj78X1XmR1xtUTPtU4/EuZxvkBjWf8rIOtxKI4uIOx4USnVemT
 dr5C6n8o1eMEx0tncEqALLBHRA93n9ThfeooNZCZLSMH3pnmaZkrTIKck9czxLqr19gPSgp3l
 Bx2oIR20OHG/IQbgl8NcPQombH3SaMgGLGjMAk2Ox6geEcFNmu3oaJj6+jhyJw4uNKTeDWEOs
 ASgjH60vKmWRiMjVwfT0OUgIal0OGx48oZ26owEoBFyVvSVOUnd7ye1Mj7TuBfFHT0rBTIOM/
 Thto74Tgg2fFf8l4tWz6r47GiEbvLzjMK65FlkA0wQVJnI2pBIRPkvRfZVdo/K9krqd+FLOP2
 +7CSATCUPr+4rlSBS1jrY4Rluih2KK1ZIyjHrbisaxs4ad/gtjqh8JeG6J15F/3wbygvjRw1k
 ZbGyKPfY0/h97A8SWHWCD7xjQe/Xe/g0GL+vhNMF7eJ6Lrr0UbdDZGont66fiiyyl1B5sjnCw
 Yx4/kpOOOshoUh/KF+9Lwzzmz9DyoA4FlKkMocykIn9ymKG+s70LhnONPwO7X6LD/kZU3zDh5
 zxrva88NJPdrVFcgavSlsUApvFw8wy4irxCkEWm4j1xkyVct8nXxsOridZA5L2fLK8+3SygvH
 D7qz8rmdIsUXagOLjOaY9TZ4D+8udZ6Al8XTRrzVDSYqkNcWkBV/hmcvVsYpchzQqfMfsFPUa
 ly7aUjybnpYOWTMFUwYerlhafvS13zuDNUeMFec51dIT8EDT6IRtg8JArhfYIBlHdap0exuxw
 dr9h3NymDOEorVXQXaVZhZM3+jT2WmG21nKW2Bpocf8rERBJl43xNXXa68KGcOIlSW7hcA==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2db91528542672cf0db78b3f2cc0e22b36302b3=
8:

  Merge tag 'pull-vfio-20260527' of https://github.com/legoater/qemu into =
staging (2026-05-27 14:45:58 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-reque=
st

for you to fetch changes up to 07e701716b43da1a86c1045871c1eb613cf5e53a:

  linux-user: Move cpu_copy() to user-internals.h (2026-05-29 23:40:53 +02=
00)

=2D---------------------------------------------------------------
linux user patches

A series of patches for linux-user, specifically many FPU fixes in signal
handling code for sh4, mips, ppc and s390x (from Matt Turner), a madvise()
improvement (from me), and qemu header cleanups (from Peter Maydell).

=2D--
v3: Fix build failure due to unknown MADV_COLLAPSE constant in madivise() =
patch
v2: Dropped the "ARM cortex-m55 program loading fix" and the FPU alpha pat=
ch

=2D---------------------------------------------------------------

Helge Deller (2):
  linux-user: Implement finer grained madivse() syscall
  linux-user: Fix typo in function documentation for pgb_addr_set()

Matt Turner (6):
  linux-user/ppc: restore fp_status from FPSCR on sigreturn
  linux-user/mips: save/restore FCSR across signal delivery
  linux-user/sh4: preserve T/M/Q bits across signal delivery
  linux-user/sh4: restore FP rounding mode on sigreturn
  target/sh4: sync fp_status when gdb writes FPSCR
  linux-user/s390x: restore fpu_status rounding mode from FPC on
    sigreturn

Peter Maydell (2):
  linux-user: Move init_main_thread() prototype to user-internals.h
  linux-user: Move cpu_copy() to user-internals.h

 linux-user/elfload.c          |  2 +-
 linux-user/mips/signal.c      |  7 +++++++
 linux-user/mmap.c             | 34 +++++++++++++++++++++++++++++++++-
 linux-user/ppc/signal.c       |  2 +-
 linux-user/qemu.h             |  5 -----
 linux-user/s390x/signal.c     |  6 +++++-
 linux-user/sh4/signal.c       | 19 ++++++++++++++++---
 linux-user/user-internals.h   | 18 ++++++++++++++++++
 target/mips/cpu.h             |  3 +++
 target/mips/fpu.c             |  5 +++++
 target/s390x/cpu.h            |  1 +
 target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
 target/sh4/cpu.h              |  3 +++
 target/sh4/gdbstub.c          |  2 +-
 target/sh4/op_helper.c        |  7 ++++++-
 tests/tcg/sh4/Makefile.target |  7 -------
 16 files changed, 114 insertions(+), 27 deletions(-)

=2D-=20
2.54.0


