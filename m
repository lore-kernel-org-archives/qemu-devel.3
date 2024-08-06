Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D8AC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 17:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbNgE-0003ke-0h; Tue, 06 Aug 2024 13:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbNg5-0003jQ-Ds
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:08:57 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbNg3-0003Rw-IJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:08:52 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso8684921fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722964129; x=1723568929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LQWkaUP48IjEhXZw/xUKBZzgoR5I4snX9Ha93jc7/H0=;
 b=tYfR9KN+StXGK/Pm5shygn39cpivtInnDsCKfTUSOUbncJhJDlgj5y0PFkX0zWgISm
 q9/CxRSu5WVg4tTmlIYemo1vLBGfzv0GZ1thV7c7VnJWyS425ypK1lJA32tuuON9AcmU
 9kcnmQVCM2LaWBf7xxF4MgvoM0qYR53yKn6pWPgVDkcYUZkO/LQu6AkdBdDZxonI71/E
 CsEYPPfbzZsGgug/Yz/IvyGTCkM8qbo7+tmsrAQhuXMg8zjHqnOWf1+O/8tDACO0Av5l
 C+LOrKvjl0hU73GK9vXhbQCurC5C4V/Am4qNYOF88c2UQlxED4Qa1TFBsKSR0Lo3wJ07
 FCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722964129; x=1723568929;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQWkaUP48IjEhXZw/xUKBZzgoR5I4snX9Ha93jc7/H0=;
 b=AKTP4FMJZBKM5one5qZujbvJXxgjANZOesznuqAqxVUYW+jRUCmfrVgbFSVgoaoUm+
 NKLXhtCtkjaKkRAihrnaNqEuU3Awf0QvDG8LtjRhGyp2E2dBxmNYAP9VJ//JYluDIn2K
 dBZ+lqJrZ1YR70jkd3dvGElbkSiacvL9FD5bmFRxAiGRplJ2/FC5xxlOCNanu2V/fwSb
 mq4pcUGKjbpml5yzKXr4yBc3N/1uuJVdNPp8HL4lX5RhX/0ucToXhgazgvVUQL/U/eyO
 czyFeesKrsol2hkYjv3oCqXzbPcDQ7ZWgXvH3UF5jIkpCfV/07AJI8E/SRuZJxViFZHl
 ToAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUwMt3j9bkF+9jF3LJcyGzNilg1x4pqCpLK1E8F7zpL89SlvclIS5XxE/Zy9yebIbkQf/XunLoOam+0ldOBzlos6/3js8=
X-Gm-Message-State: AOJu0YzCiHcRtxvAn7QDKnHfOR9Gx6Ehiu4rOMx+ioARcqmkZ+WVe99y
 3iiYtCCLHRru+8632yoO0RSwQ/symTFcf+aZIRtxUsSedHk4wQuK1uHP1fhMGSM=
X-Google-Smtp-Source: AGHT+IF+7boIsb21S6IZu1aidH1TxyPlFvquNDABkzB/Ph4axTkyHv9BI1hiwmQpITwGJNDo73wkjA==
X-Received: by 2002:a2e:95c1:0:b0:2ef:1edc:3b6a with SMTP id
 38308e7fff4ca-2f15aab0a32mr102532741fa.21.1722964128352; 
 Tue, 06 Aug 2024 10:08:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd26a3d9sm13440298f8f.110.2024.08.06.10.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 10:08:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16A1B5F871;
 Tue,  6 Aug 2024 18:08:47 +0100 (BST)
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
Subject: Re: [PATCH v16 02/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
In-Reply-To: <20240623152343.328436-3-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 23 Jun 2024 18:23:32 +0300")
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-3-dmitry.osipenko@collabora.com>
Date: Tue, 06 Aug 2024 18:08:47 +0100
Message-ID: <87jzgtr334.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

> Move fence_poll timer to VirtIOGPUGL for consistency with cmdq_resume_bh
> that are used only by GL device.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

