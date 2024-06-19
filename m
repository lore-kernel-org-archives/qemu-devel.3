Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF764C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJxDU-0005Qd-A2; Wed, 19 Jun 2024 11:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJxDS-0005QD-LF
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:18 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJxDQ-0005qQ-TG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:18 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec002caf3eso111819321fa.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718810834; x=1719415634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=InvmB1p1AreF3b9o4uhSXLFw4nf/fpCUxNwcyukjU8A=;
 b=XvzrNWFmZlHWQW9MELcmkVc9IpGeBeUDvAAD18AeijcMtFal4zA5vJ7qfSHoU2Q4am
 9bAO4W/X4e2JNIHrZBnekx05hx9suqAfGiLJX8MRBqXeYqWdazOvD8ekLFqagbpxBTBH
 mb8VVW5S/PuMV/zRutcTFfFmIch+mA28UN3vmgE57cif2YmX+f6zKHROQ9RGNQFEZ9JO
 U2Owp53wJtL2BJ3XfLbiclMT6xsa3P4nDrWLIioZcHJq2sxqXkIJBoPpi667N7OWTowM
 QStjB5MI+EtSQDkhGkxPe2eV+OpIDgG2FkQKgC8wtzJTleDB8AWdMQ9Xlocc4/yu+Phx
 OYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810834; x=1719415634;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=InvmB1p1AreF3b9o4uhSXLFw4nf/fpCUxNwcyukjU8A=;
 b=fyPJCuFQfno4vm0FyQI9Sz8a+eRvum/F2l2FuDLxEI6N3KhFd5yp89S0OmdsxMr1yL
 yqe0IIzNaFgA1pIn8qqogPqhxj/0Cqs9ds9OGgHxiWRrgooPaWOdmei3zWtmmy1LYOwD
 NLjgsdh2Pu3F6oIJ8bXRvBMOJY+EB01I+vslxfjf7lDRJBC8GD4bP9CVQeUm3MIKzTEF
 V//awVRfGLbObdRBauqHJ4/jVCGPgpJymIDd1atERYqyFVNSbxtms2pSF8AaZn6APhs1
 b09BFGocFuqqbr4NZaaXqvmpQBlQT34X51CJ1PEMWX6ZXvke4E48+aSVznVLsOndoXFr
 mlUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ZPdA6DLMdYIVcZldslfPt99spZtqNZ6tpyvBe7HTPvqHqmDHWI+eNzTLdwLYtxjoavSeT2JQaCd976vp6ymM7gvixCE=
X-Gm-Message-State: AOJu0YzeDOCrG0wkOpZ7jK539e3w811ZhYDk0m/2HAJKDsAZVkkaQSVg
 BShMf7ov0kM4OMoh8NavIQeNdfed+qu7U0oylqY+hyvuH/chblwNrZfYSwXLQsU=
X-Google-Smtp-Source: AGHT+IGzMfaRUc3lto1ZCYUd28rQmDVeGHojxHQKPxcoVeDWMxg62sjr+TSTpNksl4l/9RAoSnDjaw==
X-Received: by 2002:a19:c216:0:b0:52c:76d:dbb4 with SMTP id
 2adb3069b0e04-52ccaa5250amr2122601e87.49.1718810833807; 
 Wed, 19 Jun 2024 08:27:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f6121c727sm585524266b.67.2024.06.19.08.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:27:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBFCF5F919;
 Wed, 19 Jun 2024 16:27:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v14 12/14] virtio-gpu: Handle resource blob commands
In-Reply-To: <20240616010357.2874662-13-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 16 Jun 2024 04:03:55 +0300")
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
 <20240616010357.2874662-13-dmitry.osipenko@collabora.com>
Date: Wed, 19 Jun 2024 16:27:06 +0100
Message-ID: <87frt9c5rp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=3Dtrue
>
<snip>
>=20=20
>  #if VIRGL_VERSION_MAJOR >=3D 1
> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_comman=
d *cmd)
> +{
> +    struct virgl_renderer_resource_create_blob_args virgl_args =3D { 0 };
> +    g_autofree struct virtio_gpu_virgl_resource *res;

Newer compilers rightly complain that g_free may be called on an
uninitialised value (if we early return). Setting to NULL should be
enough here.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

