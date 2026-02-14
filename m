Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E36EF584D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 23:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrOof-0007DQ-1U; Sat, 14 Feb 2026 18:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.sp3pfh7edfh7tt3=0hpass0429i2=q8ojuz88y4jqyc@em483429.getutm.app>)
 id 1vrOod-0007Cq-5G
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 18:12:43 -0500
Received: from a4i986.smtp2go.com ([158.120.83.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.sp3pfh7edfh7tt3=0hpass0429i2=q8ojuz88y4jqyc@em483429.getutm.app>)
 id 1vrOob-0001gL-C6
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 18:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1771110747; h=from : subject :
 to : message-id : date;
 bh=qYLwnXQ/ZNvwlGPf13gNTKdCQxlPpn0NHCvLfrc6X7I=;
 b=JpjVAx0eSzr+FpK5y0daPSukOmJmuBsLtKI1ctPL2Zi8ugj1KqJdjAPNDA1ZP2LxYSS65
 s/y5t6iO0cZ1HguzG9fkzLGpJ1nRZqvCMHqhjMc6sXVPgNkQQvn3yhJzVrK1ca3CeN4JJHG
 mp1WD9KZWVqGs5AmBfKeOYqS7VsVvsA/V2YvAZY7PXGa/uYbhY+hMfE6wyV51UPpHCJ7kx0
 K0O2ImaqIMqnakOUT8W7QW4FWlvenAaICKkt/9SCZkrHdFqJwKt9/1CIUyJU/Y6QOJjGmHU
 W4tRtLO8rMcWMdgidXxpNwFcY3y37fmVuAqa9EEL/L8EdSK2WppzHeWXrzsw==
Received: from [10.159.238.187] (helo=mail-ed1-f51.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.99.1-S2G) (envelope-from <j@getutm.app>)
 id 1vrOoK-AIkwcC8wdrz-E9kq for qemu-devel@nongnu.org;
 Sat, 14 Feb 2026 23:12:24 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-65bebcbffe8so110533a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 15:12:23 -0800 (PST)
X-Gm-Message-State: AOJu0YwyuUtlVDme5bHMdjSKObxCQioA+JeqYirW8SXXuJzMzhyaxV3j
 UsU+YWFMnl7R77TWPVtJmkj1GA2NUHHyVwC+5LCklMYggCYStE2rbKlg9tsdBzW3SZL8gDYxTDo
 2pFa20rt3GS5W+tZU0U8mMlX7B1zLgtA=
X-Received: by 2002:a17:907:980e:b0:b87:2abc:4a32 with SMTP id
 a640c23a62f3a-b8fb41edd8dmr453332866b.18.1771110742442; Sat, 14 Feb 2026
 15:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 14 Feb 2026 15:12:11 -0800
X-Gmail-Original-Message-ID: <CA+E+eSB6KLyZTLT7e-0ng1x=0F4zNRm4PF0akkAub2cxXdX5sw@mail.gmail.com>
X-Gm-Features: AaiRm53YWvBEYPQtfhidWWrl1YNF-BSjqZ9Shjy3Sd2jZLxuuaY7YKfb_ikicgw
Message-ID: <CA+E+eSB6KLyZTLT7e-0ng1x=0F4zNRm4PF0akkAub2cxXdX5sw@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Joelle van Dyne <j@getutm.app>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429siAqW4ZwIF
X-smtpcorp-track: Qck6M3H066OW.hBmSMqxoOu0g.Xg4nzA0iDZ5
Received-SPF: pass client-ip=158.120.83.218;
 envelope-from=bounce.sp3pfh7edfh7tt3=0hpass0429i2=q8ojuz88y4jqyc@em483429.getutm.app;
 helo=a4i986.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 13, 2026 at 8:34=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Commit e27194e087ae ("virtio-gpu-virgl: correct parent for blob memory
> region") made the name member of MemoryRegion unset, causing a NULL
> pointer dereference[1]:
> > Thread 2 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> > (gdb) bt
> > #0  0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6
> > #1  0x0000555555841bdb in find_fd (head=3D0x5555572337d0 <cpr_state>,
> > name=3D0x0, id=3D0) at ../migration/cpr.c:68
> > #2  cpr_delete_fd (name=3Dname@entry=3D0x0, id=3Did@entry=3D0) at
> > ../migration/cpr.c:77
> > #3  0x000055555582290a in qemu_ram_free (block=3D0x7ff7e93aa7f0) at
> > ../system/physmem.c:2615
> > #4  0x000055555581ae02 in memory_region_finalize (obj=3D<optimized out>=
)
> > at ../system/memory.c:1816
> > #5  0x0000555555a70ab9 in object_deinit (obj=3D<optimized out>,
> > type=3D<optimized out>) at ../qom/object.c:715
> > #6  object_finalize (data=3D0x7ff7e936eff0) at ../qom/object.c:729
> > #7  object_unref (objptr=3D0x7ff7e936eff0) at ../qom/object.c:1232
> > #8  0x0000555555814fae in memory_region_unref (mr=3D<optimized out>) at
> > ../system/memory.c:1848
> > #9  flatview_destroy (view=3D0x555559ed6c40) at ../system/memory.c:301
> > #10 0x0000555555bfc122 in call_rcu_thread (opaque=3D<optimized out>) at
> > ../util/rcu.c:324
> > #11 0x0000555555bf17a7 in qemu_thread_start (args=3D0x555557b99520) at
> > ../util/qemu-thread-posix.c:393
> > #12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6
> > #13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6
>
> The intention of the aforementioned commit is to prevent a MemoryRegion
> from parenting itself while its references is counted indendependently
> of the device. To achieve the same goal, add a type of QOM objects that
> count references and parent MemoryRegions.
>
> [1] https://lore.kernel.org/qemu-devel/4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025=
a0@collabora.com/
>
> Cc: qemu-stable@nongnu.org
> Fixes: e27194e087ae ("virtio-gpu-virgl: correct parent for blob memory re=
gion")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
> change-id: 20260214-region-690a177c0475
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>

Tested-by: Joelle van Dyne <j@getutm.app>

