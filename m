Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A1EF99D0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 19:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqzA1-0004he-TJ; Fri, 13 Feb 2026 14:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.w2ffvokizwpu9t3=f13qv0wpd9vm=qvrufxj56h95ib@em483429.getutm.app>)
 id 1vqz9z-0004h7-Ng
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 14:49:03 -0500
Received: from a4i986.smtp2go.com ([158.120.83.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.w2ffvokizwpu9t3=f13qv0wpd9vm=qvrufxj56h95ib@em483429.getutm.app>)
 id 1vqz9x-0002sj-7e
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 14:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1771012127; h=from : subject :
 to : message-id : date;
 bh=V3RN2oTzHQM6IlXSjJrvzxL/jfSZzqIQaDCSx4OZ+hw=;
 b=YQH1QK2oRXmex4W1LYHFUvWR8vLJeH3iuNrInbTS9hj4xjoxJuR4M0Ff7ak1p6G3RzldK
 jGyW/SJFjYgPGlMp4OIISuHKeI8eqKNfm0xgJRj316o+36niDUmXXfv8/Sj/r3PlTu9z4nY
 TAGob7zl9i23K7HbN1gvHj137OYHEkFxq5cbXsvWk1VaaVcdN77OmquGDJ1HoFeULWOzM/3
 ByVd54+Ir3HBBo7IP8tUy5lEkE4u7riU4sXgzqsG9CY/mqdIS7LEX1SbX9E7uU0N+uAB2a7
 QRN92HTSESSlmq9sKjtSIusY9jn+i5W+QGpExz03+SurB+/isjusd6jVHF/Q==
Received: from [10.159.238.187] (helo=mail-ej1-f45.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.99.1-S2G) (envelope-from <j@getutm.app>)
 id 1vqz9g-AIkwcC8qvHX-H2Fs for qemu-devel@nongnu.org;
 Fri, 13 Feb 2026 19:48:44 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b885a18f620so172311366b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 11:48:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWciJry1qoPkN054zs36ygSqsD6IbPISrrLWgg2HG0S56pymqXLDmD8q6uH2yJ0f4Y7z1Tlq4oNP7Gb@nongnu.org
X-Gm-Message-State: AOJu0YzYxd12tmphz4Gyauo0UaE/pZmHCU/G70bkdOlkErh1gOiQc9r2
 uBe84S88COpKyrM5V0Gyp8JCFWKHQAHTIwG8bK/9Zq2v1wrn5XRCGSec9gLzOSkXg2B4Yf/jJMu
 YB2fZdyK+fvMGqJq0rzBkY4K9YBUX0/M=
X-Received: by 2002:a17:907:9283:b0:b88:775c:bd6b with SMTP id
 a640c23a62f3a-b8face4ddd4mr206559766b.46.1771012123559; Fri, 13 Feb 2026
 11:48:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <CAFEAcA_8jB_KLzUzLS1=uG3y-nRRK_C2ZZp9SwKo1WrGu8dJkQ@mail.gmail.com>
 <87tsvkmxb5.fsf@draig.linaro.org>
In-Reply-To: <87tsvkmxb5.fsf@draig.linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 13 Feb 2026 11:48:32 -0800
X-Gmail-Original-Message-ID: <CA+E+eSDZ+nrxT8=JKGvBJSO3b8cVoD-U1f+E0rhn-ZK7zePHrA@mail.gmail.com>
X-Gm-Features: AZwV_Qh52bFyHiM9lS6dtfSmqUBZP63XVof77hHSZ1eLfElUYC4SNHTvnCXTK2I
Message-ID: <CA+E+eSDZ+nrxT8=JKGvBJSO3b8cVoD-U1f+E0rhn-ZK7zePHrA@mail.gmail.com>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Joelle van Dyne <j@getutm.app>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429scVmEp7XNq
X-smtpcorp-track: QW4-BuZ3yYlp.AfFjMbzkJWvD.bNZ9_A_GUxh
Received-SPF: pass client-ip=158.120.83.218;
 envelope-from=bounce.w2ffvokizwpu9t3=f13qv0wpd9vm=qvrufxj56h95ib@em483429.getutm.app;
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

On Fri, Feb 13, 2026 at 8:18=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Wed, 4 Feb 2026 at 19:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> From: Joelle van Dyne <j@getutm.app>
> >>
> >> When `owner` =3D=3D `mr`, `object_unparent` will crash:
> >>
> >> object_unparent(mr) ->
> >> object_property_del_child(mr, mr) ->
> >> object_finalize_child_property(mr, name, mr) ->
> >> object_unref(mr) ->
> >> object_finalize(mr) ->
> >> object_property_del_all(mr) ->
> >> object_finalize_child_property(mr, name, mr) ->
> >> object_unref(mr) ->
> >> fail on g_assert(obj->ref > 0)
> >>
> >> However, passing a different `owner` to `memory_region_init` does not
> >> work. `memory_region_ref` has an optimization where it takes a ref
> >> only on the owner. That means when flatviews are created, it does not
> >> take a ref on the region and you can get a UAF from `flatview_destroy`
> >> called from RCU.
> >>
> >> The correct fix therefore is to use `NULL` as the name which will set
> >> the `owner` but not the `parent` (which is still NULL). This allows us
> >> to use `memory_region_ref` on itself while not having to rely on unpar=
ent
> >> for cleanup.
> >>
> >> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> Message-Id: <20260103214400.71694-1-j@getutm.app>
> >> ---
> >>  hw/display/virtio-gpu-virgl.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-vir=
gl.c
> >> index 07f6355ad6..6a83fb63c8 100644
> >> --- a/hw/display/virtio-gpu-virgl.c
> >> +++ b/hw/display/virtio-gpu-virgl.c
> >> @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> >>      vmr->g =3D g;
> >>
> >>      mr =3D &vmr->mr;
> >> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> >> +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
> >
> > This looks very odd. The owner of an MR should be the
> > device that that MR belongs to, not the MR itself,
> > and usually not NULL either. The name should be something
> > useful for people looking at the HMP info output about
> > memory layouts.
The owner of the MR was set to itself before the change and this
caused a crash on my ARM64 host (I'm not sure why this wasn't a issue
beforehand on other architectures, I suspect it was a race condition
that was always won before). The original fix (see v2) was to call
memory_region_init_ram_ptr() with "owner" set to VirtIOGPU *g and then
manually setting "mr->owner =3D OBJECT(mr)" after the call, thus
breaking the self <-> parent loop that caused the original crash.
However, this was brittle as we were modifiying MR internals outside
of MR APIs so the suggestion was made to use NULL for "name" and
"object_unref" instead of "object_unparent" in cleanup. This MR was
properly an orphan and does not have a parent. We depended on the
behavior of "memory_region_do_init" to not call
"object_property_add_child" when "name" is NULL. The APIs were not
clear if "name" is allowed to be NULL but the existance of that code
path led to the assumption that NULL was permitted as an argument.
Obivously this assumption was flawed as the crash log that Dmitry
shared showed that cpr_name() in physmem.c will return NULL and this
causes the NULL name to be passed to cpr_delete_fd(). There might be
other places that expect the name to be non-NULL as well.

> >
> > If there's a use-after-free issue then I suspect that the right
> > fix must be somewhere else, not here.
The obivous fix is to revert the change but the original crash
referenced in the patch will still be an issue. Alternatively, it
seems that the v2 version is unclean but can still work because we
just need the MR to not have itself as the parent. This would be the
minimal patch that addresses both issues. (A proper fix should also
remove the code path in memory_region_do_init() for when name is NULL
and instead return an error because that path is invalid.) Another
alternative would be to modify the MR APIs with a clear way to create
an orphan MR. Finally, object_unparent() could recognize when the
object is its own parent and handle that case gracefully. Let me know
what people's preferred solution is and I'll whip up a patch.

>
> The blobs really cause issues for our MemoryRegion code because they are
> transient and aren't easily cleaned up with RCU because of the dance we
> have to do between qemu and virglrenderer for the underlying memory.
> There have been multiple attempts to clean this up and so far I don't
> think we've managed to reach a solid solution.
>
> >
> > thanks
> > -- PMM
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

