Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8058C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRd9-0002mF-4s; Tue, 05 Mar 2024 05:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhRd5-0002lu-4s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhRd2-000722-Sd
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709632951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmDB9Z2wQMBTvmc3KQ/Tyg3UyjiPJNdPK/ZYJ0YfkFg=;
 b=OWraMoT2IxwzUWJXBGwWUZjZMcKKcasQQqVgqX7V0mgj5bh1UgMW8czhhef43GQrO6Eo+P
 6QpL+x2N7ZLXZ+YqBkcaW5Riw7345Wzw2EYziArNS01fHGjKqHzyocySa3aQLD0gltjLgW
 dYvToDrGbPG0WG60DedhY1HQ2DJdlms=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-TQVhbjRcN5m5nSiHzPyWgQ-1; Tue, 05 Mar 2024 05:02:28 -0500
X-MC-Unique: TQVhbjRcN5m5nSiHzPyWgQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d841c7a3dso2271573f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709632947; x=1710237747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmDB9Z2wQMBTvmc3KQ/Tyg3UyjiPJNdPK/ZYJ0YfkFg=;
 b=Otf2t+DapVptoBxGJBN4qKVy9OxlSHUKjHYd4lMU3sYmA3ETHsj72YuqaCmuT4pu79
 4Ckh8aDJd+nBJm5k4yadZ1CVsCf0ipWq0HOejaNHwz87QvQ8rtv643KP9aIGSI+n3rkQ
 LZIng3c4kTJEnv+bR136Oay2GUuDBHN6XCrmm0Ikr+PQ+9Vt4/oEHraa5lmZ0xXuoB0U
 NDC6JrhIc2RGZzC6TndiIGufwAkBRr+FsFkvTAodzl30R+jEFtVLXwFppOs2QovdDH3D
 JT9DO2aM6xnIaycktEHN9vWu3QDp8MEPd5DilMDIjRzG01+6WZMjF56cBdLG1A35yY2c
 vPfw==
X-Gm-Message-State: AOJu0YxPCmkgvf+6mDm7liA1VnTyNAazfuiSsMEe6VyLjdGNZ/M6629W
 jLhI4jO2zGl4Zjp52E2jddnczMmCRp8h6T9WuUWuahY/gqj3iI4DOLisU3Iym5wwhvxukki6t7+
 pJoaQ1pFhhATe5QkiKg8N4EMn+Gndwc+hfbpzcmRDFI3Vg3Y3XuQgpzwkqEELy9EAvBFqTSrxw3
 hKMWA2/x8GUOoWEaQccQFS5OS8iAw=
X-Received: by 2002:adf:ef84:0:b0:33d:b014:9e3a with SMTP id
 d4-20020adfef84000000b0033db0149e3amr9474292wro.56.1709632947723; 
 Tue, 05 Mar 2024 02:02:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAd4LLSUk14qj5YCgMoX7D8stRMqZvRBmCNgLFF1/x2udsz2rF6A/zkA7Ov1tNP1xukB4o+uBjmbAWNMDhn2E=
X-Received: by 2002:adf:ef84:0:b0:33d:b014:9e3a with SMTP id
 d4-20020adfef84000000b0033db0149e3amr9474268wro.56.1709632947295; Tue, 05 Mar
 2024 02:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20240304193702.3195255-1-alex.bennee@linaro.org>
In-Reply-To: <20240304193702.3195255-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Mar 2024 11:02:14 +0100
Message-ID: <CABgObfZEqCzm7MYaTQiY+O7=YoBDUNTwit+X=a4c9ZqR2dEGrQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tests: bump QOS_PATH_MAX_ELEMENT_SIZE again
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Mar 4, 2024 at 10:06=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> We "fixed" a bug with LTO builds with 100c459f194 (tests/qtest: bump
> up QOS_PATH_MAX_ELEMENT_SIZE) but it seems it has triggered again.
> Lets be more assertive raising QOS_PATH_MAX_ELEMENT_SIZE to make it go
> away again.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1186 (again)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The array is sized according to the maximum anticipated length of a
path on the graph. However, the worst case for a depth-first search is
to push all nodes on the graph. So it's not really LTO, it depends on
the ordering of the constructors.

I had a patch to implement the stack as a linked list, but I never
sent it because IIRC it caused failures that I never had time to
debug. This patch is okay as long as this information is included in
the commit message and/or code.

Paolo


