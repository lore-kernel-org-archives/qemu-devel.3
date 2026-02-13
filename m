Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC54EDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvsU-0004WS-3O; Fri, 13 Feb 2026 11:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvsS-0004W7-Lm
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:18:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvsQ-0000Zy-FC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:18:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso9164285e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770999521; x=1771604321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/JeZBx19d02AEAkUdrGPgMcQzQiQrlGuOFL6F6Om5s=;
 b=Ny7woRNtSIiCfXgg/bTmZmZIxSkFcGG4ywfC79l5jJxHfPQIvLpUGdO2K+72r2xO7+
 bziBVyfawbCP8EAJYKVjqJ5jxWl9in+jGo2TQC+PHreRTsh2iWBU7ezchh5ykatYBMps
 mrcX+T0FxApEA3r3BOQ9g9FC2eeZq5eaF7lvQMwb5SZ4rZ11jlZ/TMbA1904+O+qDx4j
 Ds5VDpupsyqqMj99gRjunGKrqeEv6C8Zzn/MxZZtnJLIRP5UtupbFiFfErb94qW0PYKI
 k5yHsJ+3IB/Cl9o9yvgXe7hygyel+ZzQvirXWUYMdU4FPRcHveSGKBoAVuaYTmCORRu3
 9wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770999521; x=1771604321;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m/JeZBx19d02AEAkUdrGPgMcQzQiQrlGuOFL6F6Om5s=;
 b=AgBicYj9M9YvOef6EGIL8YROGOOYve2yI6scQgiYy4jHYSb+Xew4WgTYIzK0YMtqHv
 h4IB7Xvq7cTbjhIBsJ803lHfedI5MglGOVUHZ+FXiF0CHumvBe85PBcLVpY9TfZCuLfF
 EbBqJj7agtKoKyz5tEGlgmtjdKNHTPXBOoDwCmh/Wy0yUmk0aJ3C5tSh58enVEnBB9Gl
 KRQt7ZmNPoiwJDplGxV9mrfGECgo0ELB+MHFyDQma61wJdAjuLU+Td6fMBNQyaiw1y3l
 FGxFZT6MqPkurhQonI+Jx70/sq4PeAJ8z8lPjajnir8dRXQ7L4QLUSjdB54YJWxH17Ly
 1uug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWve0s2pv2QBm0lQMnC8Hei9CUKNXJkwvTLsh4XhxZWLXEGjyu2k7RIoqi6OMCbFV61gQbUWysHikYB@nongnu.org
X-Gm-Message-State: AOJu0YxWGPrVwD9T92galM/sOMAOGILEWZ4PvM0i1JUUf3VvTUfyQKEJ
 3ghvFGS3EhwFRaCCESMWfttfgcxXYn/4w4/8InJQzutZnSF42HWYkEccTduSLZGh8zw=
X-Gm-Gg: AZuq6aJppvZr6q3u1ghrC6di+63m5fshuiSOz4P8JdwonMebPXegQGAZoCzg8L8akzP
 wcaRgJ5vecLJB68zMDJdxgvC2lEXgTqFp6KEVrDqLa37KCFNVSjkN7c3z7wqKzcMAJoQjbqkbfu
 ByBWganCE0yo+63D/exRqVSjNGTNs+3wOheYL7QDDyOYhMzWpMGOIL8PkH9bo8Wv0I6EYn2kujK
 BecNLuFIRh2PBzKh/axKtEEIBPMlXxC2R1juiSHxfcxC/93q9DS/7wN6FQY6eLGj7H/yQDJY5yI
 CHp0NMeJJkvQC5FaM01iQNLMgQ8pAiJ1ke0eSCxPfRTr1SdSTC5x3iKiOCFebD3kCS8L7PLiiXc
 xLM447IgjU8D0T3nZ8H+oiAI7b2B1r/y0MxLVB2nqm9+hv4G4j2LoTc02ojKAUBnjA9lnYaicYD
 bwYe3GvDglHUGvskUNKqXtRKo=
X-Received: by 2002:a05:600c:c4a6:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-48373a74604mr32990865e9.29.1770999520532; 
 Fri, 13 Feb 2026 08:18:40 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a4e149sm32101605e9.2.2026.02.13.08.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:18:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EEBAC5F894;
 Fri, 13 Feb 2026 16:18:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  Joelle
 van Dyne <j@getutm.app>,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
In-Reply-To: <CAFEAcA_8jB_KLzUzLS1=uG3y-nRRK_C2ZZp9SwKo1WrGu8dJkQ@mail.gmail.com>
 (Peter Maydell's message of "Fri, 13 Feb 2026 14:29:33 +0000")
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <CAFEAcA_8jB_KLzUzLS1=uG3y-nRRK_C2ZZp9SwKo1WrGu8dJkQ@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 13 Feb 2026 16:18:38 +0000
Message-ID: <87tsvkmxb5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 4 Feb 2026 at 19:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Joelle van Dyne <j@getutm.app>
>>
>> When `owner` =3D=3D `mr`, `object_unparent` will crash:
>>
>> object_unparent(mr) ->
>> object_property_del_child(mr, mr) ->
>> object_finalize_child_property(mr, name, mr) ->
>> object_unref(mr) ->
>> object_finalize(mr) ->
>> object_property_del_all(mr) ->
>> object_finalize_child_property(mr, name, mr) ->
>> object_unref(mr) ->
>> fail on g_assert(obj->ref > 0)
>>
>> However, passing a different `owner` to `memory_region_init` does not
>> work. `memory_region_ref` has an optimization where it takes a ref
>> only on the owner. That means when flatviews are created, it does not
>> take a ref on the region and you can get a UAF from `flatview_destroy`
>> called from RCU.
>>
>> The correct fix therefore is to use `NULL` as the name which will set
>> the `owner` but not the `parent` (which is still NULL). This allows us
>> to use `memory_region_ref` on itself while not having to rely on unparent
>> for cleanup.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Message-Id: <20260103214400.71694-1-j@getutm.app>
>> ---
>>  hw/display/virtio-gpu-virgl.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl=
.c
>> index 07f6355ad6..6a83fb63c8 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>      vmr->g =3D g;
>>
>>      mr =3D &vmr->mr;
>> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>> +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
>
> This looks very odd. The owner of an MR should be the
> device that that MR belongs to, not the MR itself,
> and usually not NULL either. The name should be something
> useful for people looking at the HMP info output about
> memory layouts.
>
> If there's a use-after-free issue then I suspect that the right
> fix must be somewhere else, not here.

The blobs really cause issues for our MemoryRegion code because they are
transient and aren't easily cleaned up with RCU because of the dance we
have to do between qemu and virglrenderer for the underlying memory.
There have been multiple attempts to clean this up and so far I don't
think we've managed to reach a solid solution.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

