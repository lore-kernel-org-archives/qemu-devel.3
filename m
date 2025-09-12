Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ED1CAC58F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5IF-0007kv-C8; Fri, 12 Sep 2025 11:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1ux5I4-0007iQ-2R
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:02:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1ux5Hx-0001Ka-4O
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:02:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd142so958299f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757689329; x=1758294129; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lrdaMqIev9kJSbFKyIn/xSQUkch9M39/xLPNXOp39vA=;
 b=X1o2PFMxwbc5/6VIJ/s9TbBuMx+BYKLWifgFGcojJmHyJL7qefF5Jf/0XYWFFBSJre
 sh91ASPozc8mXlAixRUcdwiY7sgZAyJDfC0EIz0iQPtM9i3x0Q8gAIqzZqDapVyA3iGk
 FpwgmnD/qbfBzbSnR5mXE+OaqDu4KIDe2/YP4M3ODaOQCijaqsviQ0pdOckGFJ5fGT9N
 /LvAlBpRdveYxO+FT/eATobG2RWYauG+/EK8ZkdtVxbO4q3sXsflb0Qwlx1gr3Vv4NLR
 TA5/20fC5noIro+dbJ8QdaQDm0SuZHw6WtApk8zJwbqQi8PFTBiEKWJYDzvuqcHpoNIa
 lAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757689329; x=1758294129;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lrdaMqIev9kJSbFKyIn/xSQUkch9M39/xLPNXOp39vA=;
 b=n2em6mKVv5Q5yqCqWspkPRk8kVeDw4eFIR9HroI4w62yE8wlY5QY90+rGEa76C+eM7
 ajn6jZBT9XWGk6uAl3AZnXyUUZvG+nsJtONTnEniqce6aVlG3pMFWSLEAdkdwhVTEw+T
 Ksflqqd9AlyLjP+nMxbMPFlAcbNiY0YkO6J9QwTifgF0vvvUwa9CZPN1/WpsXhjFQtAi
 Z6OO+b/mnaZTPqWoCRIYaKYxvaaEx0sVMWf3gIVeTPCfhva2ebkKdoC9IL2LB5DBn06q
 5ZB0gioS+NwsVe43j8wSoKduDUMlQuwo8ZssakAoiJGGYcINTBnMmSRxJrNriLb6piy/
 Db4w==
X-Gm-Message-State: AOJu0YytJQaJpj3nLJLWxLMH+WcE8bb4OJTcfcCIjvL2oIyebA07Yp1j
 4C6t7OvBnhmf5PCQvY30EzwZEdQ3ZhpPX+UW4etOhfghoKYKX6Jk38rz
X-Gm-Gg: ASbGnct6iIE55RUQSnjH83jJgjMywKzcvSndYY+wlSIfPsR0DM8ZNjAtBQBPBcJBaxD
 2FaALaJkv000aD4Xt7NGqj2v8whNoczpFTZbeTH2ni6z5SVgYxI0T1VSd/FEQ605TWtpacPIOGz
 yMrh8j7FaKjNba/WxRJ8G+9xJIUj/ygbChsGfCpASvsy7ItIF2yPpkKmm/n/Gikhuw0B4MHZ+ua
 78l33a55BCV1/1+ybrncVr0nLA6u7iVfAPbMl2iS6Tsb3uqk7br6bZnT7MJuZmUOuqSmcE1vkbe
 XeVO/z/GjrNN2wjsU5DiHNRfiguXTE/nXC8RVy97x4DH98OpFz1cCT2yJOKycn5M53onSnxoaGa
 YgnNM6+zoLAeShRzBnX0U8KXgguFGBOzJ6vrDZkmYtlbGRGmpG29kS2KrblUQbVqZCzSk
X-Google-Smtp-Source: AGHT+IHwWjimMiF07mMQlWG3hdFTzEjtWNHX11WwR8a4kFBAZSb6gEHWqiWj0tNsyFoelIbSXAU3Ng==
X-Received: by 2002:adf:f20c:0:b0:3e8:e90:a68 with SMTP id
 ffacd0b85a97d-3e80e900b53mr421947f8f.38.1757689329050; 
 Fri, 12 Sep 2025 08:02:09 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e76078fe3bsm6906453f8f.28.2025.09.12.08.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:02:08 -0700 (PDT)
Message-ID: <92fde0d33de4c07ec03f60c337bc89d266be19e9.camel@gmail.com>
Subject: Re: [PATCH v4 08/10] virtio-serial-bus: add terminal resize messages
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Eric Blake	 <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Szymon Lukasz <noh4hss@gmail.com>
Date: Fri, 12 Sep 2025 17:02:06 +0200
In-Reply-To: <878qij7pbd.fsf@pond.sub.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-8-7925e444afc4@gmail.com>
 <878qij7pbd.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x429.google.com
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

On Fri, 2025-09-12 at 15:50 +0200, Markus Armbruster wrote:
> > As a result, when using a Linux kernel older than 6.15, the number of r=
ows
> > and columns will be swapped.
>=20
> Should this note be added to user documentation?

Agreed, but I want first to reach a decision about how to deal with
compatibility with older kernels (e.g. option to disable the feature,
option to swap the fields, etc), plus the Linux patch may end up being
reverted so I want to wait until that is decided.

