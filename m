Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE2AC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbL6F-0006dR-Ow; Tue, 06 Aug 2024 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbL6B-0006co-RR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:23:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbL6A-0005HT-6z
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:23:39 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so722921a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722954215; x=1723559015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GGlTVfogk7IPRrICUnStRFnTuIzHGcV9bjp6DbVN+i4=;
 b=Da74ypdxFAO8B7yg+pYPruWpG7egZ14ZtrrEYousH5dKpMGVZg5QQXioKJ5PhoHV2a
 3PCQfCOacy069s5N74xd+ekswQ3UrXF5GJ/cFAvSOsAfAANykWJVu8cYR485qtitK/jn
 Q+WRA7KQzxOnuROsgI7Aei9045WDOd2g2125NPCjC3OwKAw8vSbNPzFX+ulXV4+2wDtT
 igQQOJZMZr3LyP1vmOYGmqSDHeJmjyyot554rUPbb5oVaq29xkjqcjnDaf6NUVCCCFPH
 Izou41R0uCsbNn/IO8ApGV8VPGc24m22288eSYkeLMyS+YIVDKhZZDH7ANM8Tkp1BDSp
 lm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722954215; x=1723559015;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGlTVfogk7IPRrICUnStRFnTuIzHGcV9bjp6DbVN+i4=;
 b=DlhCekPh5TN/qCIfoJFzJbz0P+yrHPxJEVqOzTKGMzkhCmo6kSBA5t6k2JfhdDc6ub
 ewfxFhzOdZs1yhXHu2nbH9EC7cH/siNbTz+t8A0ZjfiVnG/W3ox2uPxiN31CRh4/WEQr
 +MwpE5pyyhc7n8fJ9fwfIgLMpoo2QVT3kjPpTlu3ZKbNvd1E8P5idr/EKFr+eRqC4/eR
 YeuGPcG6wwIU5PjRMEdMNxlKccofFMgrz0Cr3UFqjfGbJ2RwtI+bqozPET4O+f/xZz18
 OmWupw+VugKkSM+cnckDFoGMv8guIZ/LhGVYHNANz18duxwlC0EEvfRq2BCZphDJGjBa
 9Cig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp8lUjQYllMT04+lB/60wv5HSq78kwOEd3pTVz1NI0pmhhB6q174E70mhCEWFukLK8aYEQ/H1kdPLE4wbElkRIKM5/Npc=
X-Gm-Message-State: AOJu0YxjokjT0ZZxjKVu737ZGMh4N+XjyVVK2sDu3uSokc06Bh2Y12uh
 pXZ6ZJD7eFN7SjMWHD8DDHqBfB5aq3E7EvfKuwtJxO2BmTQzi52uLC7nhWgJdFk=
X-Google-Smtp-Source: AGHT+IH0hCMk3C7SlBrsVBouDbwE0edv+4WsojKFrOkT04JwxpEiGW7Bfs6umg2uRJA+r5xzLZ7I3A==
X-Received: by 2002:a50:a68c:0:b0:5b9:462d:c530 with SMTP id
 4fb4d7f45d1cf-5b9462dc82bmr9197996a12.6.1722954215028; 
 Tue, 06 Aug 2024 07:23:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bb9bfead52sm184873a12.86.2024.08.06.07.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 07:23:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B85A5F77B;
 Tue,  6 Aug 2024 15:23:33 +0100 (BST)
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
Subject: Re: [PATCH v16 01/13] virtio-gpu: Use trace events for tracking
 number of in-flight fences
In-Reply-To: <20240623152343.328436-2-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 23 Jun 2024 18:23:31 +0300")
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-2-dmitry.osipenko@collabora.com>
Date: Tue, 06 Aug 2024 15:23:33 +0100
Message-ID: <87o765raqi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

> Replace printf's used for tracking of in-flight fence inc/dec events
> with tracing, for consistency with the rest of virtio-gpu code that
> uses tracing.
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

