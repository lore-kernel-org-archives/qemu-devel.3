Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B500D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3STe-0008Hd-Ec; Tue, 22 Oct 2024 23:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t3STc-0008HS-Mm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t3STa-00024q-2I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729655757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEyrePI2wgzJ3ffsJVfpfOAkUtteh+ZkhsYIVY1UxvY=;
 b=EdmXlQf5pploXkBFU2N3un2sh7HLLMrIqCSTLQyJc49zbGkmt+YxLVTMAFM5dpU7N6hCYO
 k3/GNkp7TNPGi9s66CHsACaUtRoo7f9ha5yGPtmRBDvXkA+OYY57J4ckcDbZqi5bdnpBSd
 wBnl8y4ZXH9uNJM44wBgW/4x7InPL38=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-7BHQshOfMqSFxZAHDOSdvg-1; Tue, 22 Oct 2024 23:55:55 -0400
X-MC-Unique: 7BHQshOfMqSFxZAHDOSdvg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7eb07db7812so405103a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729655754; x=1730260554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEyrePI2wgzJ3ffsJVfpfOAkUtteh+ZkhsYIVY1UxvY=;
 b=cpxlWAWss/i4ftV3fEmJLlUrSdnJCdWO6+Wbq39XWXLVs7gpagi4X34cat5Qmu/SK1
 0S9EmUeClC4Yf1Zr3MRE7rN5fdfLJ1zYyR11PNMIGs4PTaX6XRezN2EfUo5EVBaF94e7
 ZFRTDfIXYZKckPi7Jizajr385Dw1POKMhV/b3FCtSj1VI5vkYaqs/boL7rJsX64ZZNrE
 McXh/uv6aWIBnfnWsgYD5fHD2VnuOpvnT2BzON8316Zul/7avJ+lxrF3Ut9/4lW9+ujS
 Dk66RAn9gg6xzwRR2qNU4epxMw6NlquIiiDQw4JSAJW9ELlyT0oqSXqR04iurvgSo/7Z
 6QMg==
X-Gm-Message-State: AOJu0YycMddXPkMzi7qlsYsvuEvefUYWr7bXgLAU/QKPAbTauesZP8c6
 Pn6lN5cMIWx6c8HeNXOhJfqg1CDDPNfBBk/UsjgcOu0iSEbB+Mh1vGzumO3lM1atv0tplxU6QDm
 NAoHlI0vkTmzD/2Cwy9K1CAZ+UZGVd8bP2zMIpGOMxF6OlGjbinhWhyPtNmc1NluxAVqSSGWB2j
 8opwuYOxJ0S5tfrvpS3qxVycbKcdbqxe8k74RfeUiawdM=
X-Received: by 2002:a05:6a20:12cb:b0:1cc:e71d:ea10 with SMTP id
 adf61e73a8af0-1d96c3cb139mr7486185637.14.1729655754171; 
 Tue, 22 Oct 2024 20:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkBbyoKcrxbWtUS3sBytsnNr/j8QRaabqre+qLePLmG/+9izsg5ZxyWAzfbjBDYiqXNcb5Q8wccpz0YPaT5gM=
X-Received: by 2002:a05:6a20:12cb:b0:1cc:e71d:ea10 with SMTP id
 adf61e73a8af0-1d96c3cb139mr7486161637.14.1729655753685; Tue, 22 Oct 2024
 20:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240905181330.3657590-5-berrange@redhat.com>
In-Reply-To: <20240905181330.3657590-5-berrange@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Oct 2024 11:55:42 +0800
Message-ID: <CACGkMEv5DJ=6eH65UE9qjbUt9KWrMnqg1TJKU-d1SBodhLsbRg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ebpf: add formal error reporting to all APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Sep 6, 2024 at 2:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The eBPF code is currently reporting error messages through trace
> events. Trace events are fine for debugging, but they are not to be
> considered the primary error reporting mechanism, as their output
> is inaccessible to callers.
>
> This adds an "Error **errp" parameter to all methods which have
> important error scenarios to report to the caller.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

This doesn't compile:

[3/84] Compiling C object libcommon.a.p/ebpf_ebpf_rss-stub.c.o
FAILED: libcommon.a.p/ebpf_ebpf_rss-stub.c.o
cc -m64 -Ilibcommon.a.p -Isubprojects/dtc/libfdt
-I../subprojects/dtc/libfdt -Isubprojects/slirp -I../subprojects/slirp
-I../subprojects/slirp/src -Isubprojects/libvduse
-I../subprojects/libvduse -I/usr/include/pixman-1
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
-I/usr/include/sysprof-4 -I/usr/include/libmount -I/usr/include/blkid
-I/usr/include/gio-unix-2.0 -fdiagnostics-color=3Dauto -Wall
-Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong
-Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security
-Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem /home/devel/git/qemu/linux-headers
-isystem linux-headers -iquote . -iquote /home/devel/git/qemu -iquote
/home/devel/git/qemu/include -iquote
/home/devel/git/qemu/host/include/x86_64 -iquote
/home/devel/git/qemu/host/include/generic -iquote
/home/devel/git/qemu/tcg/i386 -pthread -mcx16 -msse2 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fzero-call-used-regs=3Dused-gpr -fPIE
-D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -MD -MQ
libcommon.a.p/ebpf_ebpf_rss-stub.c.o -MF
libcommon.a.p/ebpf_ebpf_rss-stub.c.o.d -o
libcommon.a.p/ebpf_ebpf_rss-stub.c.o -c ../ebpf/ebpf_rss-stub.c
../ebpf/ebpf_rss-stub.c:26:6: error: conflicting types for
=E2=80=98ebpf_rss_load=E2=80=99; have =E2=80=98_Bool(struct EBPFRSSContext =
*)=E2=80=99
   26 | bool ebpf_rss_load(struct EBPFRSSContext *ctx)
      |      ^~~~~~~~~~~~~
In file included from ../ebpf/ebpf_rss-stub.c:14:
/home/devel/git/qemu/ebpf/ebpf_rss.h:46:6: note: previous declaration
of =E2=80=98ebpf_rss_load=E2=80=99 with type =E2=80=98_Bool(struct EBPFRSSC=
ontext *, Error
**)=E2=80=99
   46 | bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp);
      |      ^~~~~~~~~~~~~
../ebpf/ebpf_rss-stub.c:31:6: error: conflicting types for
=E2=80=98ebpf_rss_load_fds=E2=80=99; have =E2=80=98_Bool(struct EBPFRSSCont=
ext *, int,  int,
int,  int)=E2=80=99
   31 | bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
      |      ^~~~~~~~~~~~~~~~~
In file included from ../ebpf/ebpf_rss-stub.c:14:
/home/devel/git/qemu/ebpf/ebpf_rss.h:48:6: note: previous declaration
of =E2=80=98ebpf_rss_load_fds=E2=80=99 with type =E2=80=98_Bool(struct EBPF=
RSSContext *, int,
int,  int,  int,  Error **)=E2=80=99
   48 | bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
      |      ^~~~~~~~~~~~~~~~~
../ebpf/ebpf_rss-stub.c:37:6: error: conflicting types for
=E2=80=98ebpf_rss_set_all=E2=80=99; have =E2=80=98_Bool(struct EBPFRSSConte=
xt *, struct
EBPFRSSConfig *, uint16_t *, uint8_t *)=E2=80=99 {aka =E2=80=98_Bool(struct
EBPFRSSContext *, struct EBPFRSSConfig *, short unsigned int *,
unsigned char *)=E2=80=99}
   37 | bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct
EBPFRSSConfig *config,
      |      ^~~~~~~~~~~~~~~~
In file included from ../ebpf/ebpf_rss-stub.c:14:
/home/devel/git/qemu/ebpf/ebpf_rss.h:52:6: note: previous declaration
of =E2=80=98ebpf_rss_set_all=E2=80=99 with type =E2=80=98_Bool(struct EBPFR=
SSContext *, struct
EBPFRSSConfig *, uint16_t *, uint8_t *, Error **)=E2=80=99 {aka =E2=80=98_B=
ool(struct
EBPFRSSContext *, struct EBPFRSSConfig *, short unsigned int *,
unsigned char *, Error **)=E2=80=99}
   52 | bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct
EBPFRSSConfig *config,
      |      ^~~~~~~~~~~~~~~~

Thanks


