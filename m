Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B2CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE0v-0001mt-U3; Wed, 29 Oct 2025 17:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE0s-0001j0-Nm
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:47:27 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE0h-0006bG-VE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:47:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso248709f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774424; x=1762379224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3wYJxEa4MZ/TU7q75zs/qLp2AT9/5lQ2YQ+0wpWl6Jk=;
 b=HR8a2QCPZME2Fix2OnsagVO/vmEJKL4DxyZf4cIE9cjucKipKdwiu9sBPCmC8mJhlp
 NyIS4ACZ8KE2FHs/a6/EYC8B+KQ7iDY+i4/k200bGuZHTHvsRFK841/btWTziB2Upaj6
 B25eaWNDBM0nDaWolX/476MlW+nkEN4Twy/6WG2gFksNVqkhVjrVjdwC178euzl8gNQW
 uPRN7492ZmqH7lhzWUANb8pXfUPa3tq3tFnyb8Z8Mba1Xet3WgWjoNQfnBmoc6W0Y9L5
 2sD7P9fITcn35u3TmUIt2QLYrOvQKbQY1hPPnQIGiY/rLJjAUX9xjocRvWohvHP/sDJD
 ZGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774424; x=1762379224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3wYJxEa4MZ/TU7q75zs/qLp2AT9/5lQ2YQ+0wpWl6Jk=;
 b=nme5bvKb+nZbA34YIon6scYC5YWp7x6blD859Iruyc6B4mZXxciyC12mCmwXSDllNv
 VWVS83QXJumJVqLcMObgmnuuTPOF18RMQCcaoZzQFpAjil5qxjJQjohc2APtmjcdX4ci
 BSd20eXicHpekeUlVkzUJskc3npys8lHeJvlAl7bglq4yTMvqIHMvc0MRRUllreSGIZO
 bhXUM/eaLhb1sM/gMXw0PvgkQ5wghzc5o2ynIh3SREnH3G0U53wQSeGf1Z9nYwc/USIC
 MZVYYecMs0zW0VcM9uAvHWEVDnoQdd/SfRV2xiv1HgPp0kfI+IsDvFpI1l+5gnX1aFqs
 7keg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDlcY7RT+XdFHq7lG4uuRLLZ+EPywyiRGm2czT3s7G/9ZOM44qzpXQF8ft4Qcixz79230u/tqBBuL@nongnu.org
X-Gm-Message-State: AOJu0YzFdrBZwDdViQjH4vH4TGkvwSaWCsF9iqMkXafQYgbt5hLxP5dW
 rIDvz/VDlkhe04RuC31iP1M9hFQVcj/7YC5aljTlNr+HkOxNyDkc/YVE16PhBaCG/bo=
X-Gm-Gg: ASbGncvi0rqMsRgImucj+YaYwsBWwciq1e4l8JjcCCuP32LwcvpcGAVakw5v5UWj/nE
 MbnvSy4fSskhDfl58zZ75QVkRhgkbwMFKMoXfs0kNmL45zUYz9svO7/lv8F0SMEflNwKpoXz0id
 KrpDCoU4nY3K2LYuU6mDntgdC6L3KBTsthkSkoj0XKzqVEongU2djJKl5prnN68nH0HbblGdyke
 PSJ+IyhqgRVSY/1PcwBRfQcvoLPQ5W6BjqWYdingqwXpddkSaunhjPdmZI4/I67b5RinpwaODqC
 rYrd6nppnetvvhmuuO9EsHaoNM8+zD1qzMrHiRhFZeJmd28Y4SdbGW9IjVYYHSZpVvCN4MatxFz
 Ps7I+c6XDU8ozeJDFlsIG/Z/H2LN4DCIjixCL61DDVUW6KYAX8uGYge5nBACqVHl8HmtgyBFcT5
 bb3XOhadHhUgfIchAwwCEiDOEZGLH158Phr7BJANi1Sqo=
X-Google-Smtp-Source: AGHT+IFTxecFV5eDlq1jL1LfjAaOyexzMsGWCxBfAmZ1x6ky0uIs8E+Z6Kbb0IqYUe/12zPr0cOzZg==
X-Received: by 2002:a5d:5c89:0:b0:407:7a7:1cb6 with SMTP id
 ffacd0b85a97d-429b4ca3e2emr848288f8f.55.1761774424210; 
 Wed, 29 Oct 2025 14:47:04 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm27970334f8f.39.2025.10.29.14.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:47:03 -0700 (PDT)
Message-ID: <175d5cf2-372b-44e0-b3aa-f395485925bf@linaro.org>
Date: Wed, 29 Oct 2025 22:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/35] hw/audio: generalize audio_model.init()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-8-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It is no longer PCI bus only.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/audio/model.h |  2 +-
>   hw/audio/intel-hda.c     |  4 +---
>   hw/audio/model.c         | 12 ++++--------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


