Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC80C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDhF-00045O-4p; Mon, 31 Mar 2025 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tzDhA-000454-RK
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:52:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tzDh9-0000i6-5L
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:52:48 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso7228681a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743421965; x=1744026765; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/G950E4iUD7P22iYcY1O+KKVXQiUvh2OUJBF7gOlhc=;
 b=bDncC6L8ldW+kSl33kEpx599OHcmxxd6oaGU2t2Q6sRH4RLP+WjkLL699AA2DPOgvz
 ONVHDH2jO0dAC/sUXYP9sTT04yMd1KcI2HESynwhkXljB9GDHMf0ofUcdboewswymSTE
 1jiwFC26oJY4r5W9pmcwAgS9qytcp6iqAJHoOM/8vNIReTng6lE/GFDIH+3pIRoIyip5
 gdZjLkiGU5Lmud6LeaKjajiwTGxC+O2eIrqBcxgftrsE/fo0DlUdaAgI9FIXL2huAH+d
 wbwXJZA2KxsSZwOq3jTYIkVKQ7i6Vj8Jg/tYKMqClXwoLWl62OyXrdRGsJ7Ac0eSUYRf
 7b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743421965; x=1744026765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/G950E4iUD7P22iYcY1O+KKVXQiUvh2OUJBF7gOlhc=;
 b=gHdCmi8Ep+ywuabPcJ4R8m2EWzZ5zsZlCmiAoFT8vkK//WnTgZN/xeSLE+3CnpbGcr
 LXwyEdU3B3BFRZBNT/hqjmIlWYYQym1OGvwvVy1g1YKzflK1NAUcA6ovMlzLrso8pc0s
 hM/lRIvg039JC7eQlkPFwyVHCjiU6ToBsSQLQdx2wXvVMMQ/5HluwDxad2d7GffbaxbI
 YLka/iqBRXeSDdEmyO/jHJFzYlK49xbtkh/6z6GZpo8Y29RjJgAJ3FUBvHRyTWttc2gw
 IVfHxioQ7JlTM0/50J5DKmt14fBdytAoF/zqIQQe77jupKzjC+0UDuc9xBZ0Qt2Xw9ML
 LyQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEwTFIjyvlI2MqYG3DBBlyhIversCUgkvhNkQE6mrFLEH0YpLYTE7iKbm+aGb7GjtsxHPOrrPYN8fS@nongnu.org
X-Gm-Message-State: AOJu0YxwADojd9rU5H7csqLS8rMKqc5jkqEL9eltItRj+1gdnfHOSoiY
 zvcbSh9q+H9dJ91dGwkN8yWpXns24ZE1i7aPXdwoLmpJlZmSg5NkSt4rvRKx4im58g1Nzr/z3aW
 clG2zBxa9rpex6Ux5uYJDyDm1GTo=
X-Gm-Gg: ASbGncvNG5ZMwlNzbHveEjg1f//W//h3mW9Ek6aV5VNsojyRqKilWUKTGr56MutUpaQ
 /yXzKeH4bQ7FJjc6NBBt9EZxHdZpg3aS+YNIX78kY0xosGausty87XUXzTsNvmPCem5xbbQCjDR
 pjBKTFaTIWGKAKW3cHCTQ0sK6Z
X-Google-Smtp-Source: AGHT+IHOrbPkbxgomn6Y+2zZLrB8tIiuu6p3PN58MiFeCvs+JPDdFCqU+2M7cjlk2IA/yHfECxpphkuq7EWXpx4ezvM=
X-Received: by 2002:a05:6402:4408:b0:5de:cbed:c955 with SMTP id
 4fb4d7f45d1cf-5edfd13cf32mr6865080a12.17.1743421965108; Mon, 31 Mar 2025
 04:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <87semtpjrt.fsf@draig.linaro.org>
In-Reply-To: <87semtpjrt.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 31 Mar 2025 07:52:33 -0400
X-Gm-Features: AQ5f1JoNUr2f9qRRayGY4AUInfDfArDciuLHO5VI_yHaTZ_LFyrfTuqkkH5rixQ
Message-ID: <CAJSP0QXX-hpOJ_E1oaR6NcyvBnC2mVAwfd8NYUWTDqPrtctAuQ@mail.gmail.com>
Subject: Re: Central repo for VirtIO conformance tests?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Rust VMM <rust-vmm@lists.opendev.org>, QEMU Devel <qemu-devel@nongnu.org>, 
 virtio-comment@lists.linux.dev,
 VirtIO Dev List <virtio-dev@lists.linux.dev>, 
 Bill Mills <bill.mills@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matias Vara Larsen <mvaralar@redhat.com>, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Mar 31, 2025 at 6:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> So what do people think? Where would be a good place for common test
> repository to live?

Maintaining the tests alongside the VIRTIO spec seems like a good fit
to me. Here is information on how to create a GitHub repo under the
OASIS VIRTIO Technical Committee:
https://www.oasis-open.org/open-repositories/

I don't see a reason to maintain the tests under QEMU or rust-vmm
unless they provide some unique project infrastructure that an
independent project would lack or need to reinvent.

If it is not possible to host the tests under OASIS then they could be
hosted independently (as a separate organization on Codeberg, GitLab,
GitHub, etc) and not on any contributor company's infrastructure to
make them more sustainable and neutral for the long term.

Stefan

