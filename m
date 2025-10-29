Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2CFCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE43-0005Lk-7V; Wed, 29 Oct 2025 17:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE41-0005L3-FN
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:50:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE3q-0007aC-07
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:50:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-421851bca51so276468f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774621; x=1762379421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2D7klcxJy6rKu923rI/ea6BUOY5sf8X73yhLfvIEfxw=;
 b=E22axF8KkWsVZRIBFzU7xIbqr3FLzXiI1HujAikWqCS8vopX/iXoWlphePE1xkEZ4U
 DPz08TJsJs6oZYSwtD4k8BynxBIdBH0ynjyOht96iVnJYUV1RfEfKOTW3ZC1u7dW4w2S
 vyRIE9zKZMTWeVazdCmqF1jNz2bjn7cilgZi2ucLAny454QOmzv1HyY+KM01SLbd0yBY
 KKTggoDkG6BcwhVvMv7vCT3K/Vi71ShNfXfzTXA2uQSEK4dkTuova/AuqmKglzCWzB/t
 z0qxr/wCcEkitgLty81X7hRjT+i/N/1hxs8pjnizuQIwdKYb7WKJ+Mb+IA7AL1MvteF7
 aOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774621; x=1762379421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2D7klcxJy6rKu923rI/ea6BUOY5sf8X73yhLfvIEfxw=;
 b=G02G2qLlqgNjpyGO8fr84tJD87In+GHfJ9GuMASQp/f/rupHwl/pIwslqu8N0mhnJa
 5VPwvXXgRla1RfByTdfzlCvjEeYFnmFv1zrg4vqUu85+Qi/dIhgv+4pm7zkj6kqspo4l
 qN1hY0rlqBfIBAE83dGOkakr/yYv4GpUSZXPYgPfj8J8A7mrRsd6MRcWDfFoOjV1ubm3
 qOBsEAMdZNqvjCn5km1s1xcFmq4twR0p0lr2G0b6IU8vFCKLm7Rxmhd5RozVaGa3IPPH
 Tga0Nifdh6NrKpPRpjGFb87Hi3YoLwaLjlEvac7LQfbMLdMNGPe4WZUr77Ap7uPqQDQH
 pq3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD+q7iB19XAgRlAMRpgw3b5g/YE9xg05x5O6VHk5k77K0ESlDSNQ1bWQ63u28UCrl3cGEDGbxO8ecZ@nongnu.org
X-Gm-Message-State: AOJu0YzHB60Aj2G2/K+F0xBF0kiBbx+MbxEvBzdNJ3P5K0iTBu/pLRzQ
 1ZkM0EFeivFyW7OFNWO0MWX2RihnJAPV/zbEUMZLp1053gcO6h9FIKnZoUrJOlLNR1Q=
X-Gm-Gg: ASbGncteRyeEVRSpJsXITq0t4wh7Y4kS1ch+tKL1HEVAqT91I97waitR9zpR3Qao8DT
 JxPMS0ws7TH0gk624lSx8yyd7ARGmdKvessJ9qwf6v9VyHBqcbY4knLvRYvSvlUEpyYLa7Li4WF
 wNvtiEqv1IndjplaUydCzWaiy6L1REtmqqWwVuXJvMvhcbs6922t63R6UvgLrGHwF/StlcFH/D0
 pDRUpKAg0Duc2VsAlcMCOlAaVUpn3Hi7vU4PqsSYTemXHyBGXmwbbkNgy+GvHZ1eiAZfyzzR0PN
 DGWaoEWdLMB3Lax2MYILZkBlGh73TM7gTnpEM6zVX/u3T5GV7Ur7OTlxyeY9N7HZssx+4fttool
 NZ4rhad50iKLkAzFP/kZOPGTOuc329brJErzQob+PWIxl5PzHZ0Ij2z6dbpmNUVLEj8TlcCrQ7f
 4m66bob3jmq/aWqBFkXSVHzodwk0DgU4DcQA1PEv0aNZY=
X-Google-Smtp-Source: AGHT+IHgkeaADTG3/YA/cckALLFnM9ByojJGFR/5rni+ROgTvPHOk4XhFr8VDCrBVLc+0iAwp00AvA==
X-Received: by 2002:a05:6000:2c09:b0:3ec:db0a:464c with SMTP id
 ffacd0b85a97d-429aefef289mr3728250f8f.44.1761774621549; 
 Wed, 29 Oct 2025 14:50:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da645sm27064400f8f.30.2025.10.29.14.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:50:21 -0700 (PDT)
Message-ID: <f21770ea-59b5-4715-90b5-110bd5a74eee@linaro.org>
Date: Wed, 29 Oct 2025 22:50:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/35] audio: simplify audio_driver_init()
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
 <20251027151045.2863176-16-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Catch and return from error early to avoid indentations and ease the
> flow & return a bool for success value. All driver init() calls have
> been checked to set errp on error.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 48 ++++++++++++++++++++----------------------------
>   1 file changed, 20 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


