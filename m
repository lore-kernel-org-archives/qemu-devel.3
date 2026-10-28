Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA707606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Okho/uEW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMBQu-0007sf-MZ; Wed, 28 Oct 2026 17:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMBQm-0007s5-Kh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:43:36 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMBQj-0001f1-7w
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:43:36 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso2361540a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793223811; cv=none;
 d=google.com; s=arc-20260327;
 b=cdIeLSXtUIcbq8mPM1eRlVyETf0C5VO4Sa3WJykzK78ybhHvpuHdy59GNLJ+rVTgY5
 Psdwg+ZslAXqPbm2S3r/hn3thKcuTbXA3OMMJ+nwHRoQsBIerwiXfkHoEGHAnZOr3Wbv
 BiehByN8ffQK0R8rG6PxeuaxyMBAJbdTM4ooE/iqUAuqZM0c9fOUliipfIQ6PTclDT+d
 4ceAfEmhFhu7V8uvobPF49FFHp1GBKndkevBE/7MU1kQjmlCK0bDN+/1BCEyG2+RzUua
 MVjysRTTI8kyjqeM09TtGR4if2HX6zIqeN6DPIoeC/ZKwnUG/v4ol5KUDLm4791B/P+d
 Wlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
 :mime-version:dkim-signature;
 bh=2QkRb89H+Ut888aLaIpYViCWlMZuuCKvKRmvorfSwNo=;
 fh=1stUxD1Ij/Sj+Oq9y2U6io3By6cL4m+HLXIctlUzfcQ=;
 b=OzvUhJoncqZij+dmVT63UznxRDiK7EFrdF4600vfi75+YZo9nTke/HJMz2e+r2wwgk
 40N3WWFRCtOdQb2j+/1BBC9r/xQs+3wokKFBf8zYymYehpWJFh6XZgIyI8CDTJsYQHOR
 ATI6UL6/XMzrwgGQAkv01xzo4jDFztkhCMBpXZ/ampnAgtV+zvJEHzvsOZwMlUJ4D3Sk
 yEZcWV3VC2UUmcf797TybypuXSsBSNDyEvmdq60OILbLKxwncDgtllk9slI5P3psycWj
 gGZ3YPVsdnsdu69GO+LUie96Wsin2Wfb7RdJ0DtWoMckXShGFELwS4hMK3TXSp3N/7xZ
 nXYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793223811; x=1793828611; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:reply-to:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2QkRb89H+Ut888aLaIpYViCWlMZuuCKvKRmvorfSwNo=;
 b=Okho/uEWXxdppCUVDJ3jCURmEFz39TVEwRv0havlODuQSFs20ffjuA+uKySWzSYVhT
 4VXF0LiQJb94UYaidFPdgzwdhuSTOjq5ZFwR0xK+GID05b8kcibMP1X1CMUJ81RzA95R
 xPN2VCkiePETtLSpNfpAq0+M1Wp16cBXmoqwVvefb7yPzbKYSx1ki6odnm0nEl2tP4KW
 DTpExqQ8cUG5wEPHJLMxpAYOdY93K1hYn5B09ssPPtXKmldrl+ei3Q9ZLYeRNvlQc+jM
 n6+D6rayGagar+ZyOasdJbcufB61siln1zd3lIj9m5J1bpY+on5ArWeGDtZlzSvbyGPe
 YxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793223811; x=1793828611;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:reply-to:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2QkRb89H+Ut888aLaIpYViCWlMZuuCKvKRmvorfSwNo=;
 b=Q0GXNdxglEFX6LkHHCKWmuWF9lDviPa4U02kRz5l1GvFiMehYpzmVNZAzVoehmW/f7
 i+jqiAKnyhu4Rz044PMx+FWcqAw2DiS+sxPMNytC/APmdKFSiR6algQ86YP9VUykZpoa
 3zKPiq6sFJSRgzE2xJU7g/nRlR5ODakEgrP3u+PTFqN6plC3BNGzp0eAeedDyrRySU6h
 9SuhqcRtod38HII+o57u7UCrLZDxzTGkEXiTtnFUB/35hNdye/eB2teOEhCod7jzdXgs
 4mPRXE5TzGS7Eoly2ZanyajQQLUJ327ukc4mfK5iNhw8nGkJ7/xAwxK2umLUj7GpfOHB
 eOHg==
X-Gm-Message-State: AFq9FYL7NkFwzXBdo7v2x5/Ctvnfo8aWKKnCjQDQB56gr8+lQUDg0bhR
 XhIt7iOfYI9oxBPiA2cqKhEaCr8aH6VdCCaRn+3t2xPFJcMWvvXKK/lXJefL1qe030GltOkdPDa
 r1qZ6+9rX0cKjWZpRaXSoFxfrt9mUAgA=
X-Gm-Gg: AYBFou1UcJCcWCfFs188x2zSImmVswuO2gKyQPSsIlzsWo8TcjJDsmI9zMsYTifUbn5
 DQPFDgxaD+HLY8zPJFDceFVIh6fmble0gvYwADM8gwmi0LpQtFeeUR5Tqr5Xrn9pTfgPBpapwOL
 1CzFSDKav9Dq/bWZ4kEXZ8YI6tB5j5821s+V9ir163MG0YpOkWlDulhH4dDxA80xYzxjMT0VjjQ
 oogRG73Niv9woZKoZij84rJ3Srg62bkwoXnUuhR0PowY6+ReDxomiFHvjsPECM6aXh1F9nLJfIT
 aB3U3jUpJyT4Hr1ILI+7xjzoTyyAUYGGgEGeZnxwBR0YUlIInaRTHHuMGfxMrQ3kn++MuyeITaT
 WFMFDDEDImdegqYDKFj7dZroyGLTORTLitbgE
X-Received: by 2002:a05:6402:5194:b0:6b3:c089:5806 with SMTP id
 4fb4d7f45d1cf-6b49cb4f1e5mr2644930a12.4.1793223811356; Wed, 28 Oct 2026
 14:43:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:7208:378b:b0:110:91ae:907c with HTTP; Wed, 28 Oct 2026
 14:43:29 -0700 (PDT)
In-Reply-To: <b59162fe-5f8d-4923-b6ff-133b8fbf1a41@oss.qualcomm.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-10-luoyonggang@gmail.com>
 <b59162fe-5f8d-4923-b6ff-133b8fbf1a41@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 29 Oct 2026 05:43:29 +0800
X-Gm-Features: AclHuK9BagxZRH6MjZ4MmD_wDGyUnLjabxwZ0z6Km__e0lGMGW5kUyVx9kfEvXg
Message-ID: <CAE2XoE8vapLZzawuDMQEnOGZsymec+EVUkoWhxUKxbrqmAHoOg@mail.gmail.com>
Subject: Re: [PATCH 09/12] hw/virtio: register s390x virtio-blk-pci and
 virtio-net-pci variants
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@kernel.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000475d3e065eed7450"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000475d3e065eed7450
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, October 29, 2026, Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> > virtio-blk-pci and virtio-net-pci added the s390x loadparm property
> > from class_init when target_s390x() was true. Register each
> > VirtioPCIDeviceTypeInfo twice. The s390x variant calls
> > pci_qdev_property_add_specifics(), which now always adds loadparm,
> > and the other variant does not. target_s390x() and target_not_s390x()
> select
> > the two.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  hw/pci/pci.c               | 13 +++++--------
> >  hw/virtio/virtio-blk-pci.c | 22 +++++++++++++++++++++-
> >  hw/virtio/virtio-net-pci.c | 22 +++++++++++++++++++++-
> >  3 files changed, 47 insertions(+), 10 deletions(-)
> >
>
> target_not_s390x will be duplicated at many place, is that fine?


Fine for me, let's see what virtio maintainers think about it.
>
> Regards,
> Pierrick
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000475d3e065eed7450
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 29, 2026, Pierrick Bouvier &lt;<a href=3D"mail=
to:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>=
&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">On 10/28/2026 12:15 PM, Yongg=
ang Luo wrote:<br>
&gt; virtio-blk-pci and virtio-net-pci added the s390x loadparm property<br=
>
&gt; from class_init when target_s390x() was true. Register each<br>
&gt; VirtioPCIDeviceTypeInfo twice. The s390x variant calls<br>
&gt; pci_qdev_property_add_<wbr>specifics(), which now always adds loadparm=
,<br>
&gt; and the other variant does not. target_s390x() and target_not_s390x() =
select<br>
&gt; the two.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 13 +++++--------<br>
&gt;=C2=A0 hw/virtio/virtio-blk-pci.c | 22 +++++++++++++++++++++-<br>
&gt;=C2=A0 hw/virtio/virtio-net-pci.c | 22 +++++++++++++++++++++-<br>
&gt;=C2=A0 3 files changed, 47 insertions(+), 10 deletions(-)<br>
&gt;<br>
<br></blockquote><div><span style=3D"color:rgb(0,123,53);font-size:14px">ta=
rget_not_s390x will be duplicated at many place, is that fine?</span></div>=
<div>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Fine for me, let&#39;s see what virtio maintainers think about it.<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote><br><br>-- <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br><br>

--000000000000475d3e065eed7450--

