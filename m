Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A2DEC0485
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMno-0004Cu-NU; Tue, 03 Mar 2026 05:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxMnc-00045s-Jc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxMna-0006Ks-FO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772532977;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhfgwhKIlrFIwqZgBTO3bYXe4UGT0duzo5QG+oB9JVE=;
 b=YEhevpasbWmegYXdUYonUiqJzd1oFPCpiffElDXQVoZwEZ14eCSXrxv30q1fA/EWcOCQWA
 7BR/omx2cCvPhjKOQLvsW3jd2IaseZL/TMzKWVRmYCGIZlc31Hun/3JZPwegGG/iur+GLi
 XkthYgjlFf2/cTY9S98exUQKwkHhRtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-x_nLWLo9MZib2JLbj6ugLA-1; Tue, 03 Mar 2026 05:16:16 -0500
X-MC-Unique: x_nLWLo9MZib2JLbj6ugLA-1
X-Mimecast-MFC-AGG-ID: x_nLWLo9MZib2JLbj6ugLA_1772532975
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4398fed3552so4639934f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532975; x=1773137775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhfgwhKIlrFIwqZgBTO3bYXe4UGT0duzo5QG+oB9JVE=;
 b=jFWOf+JU/X8WVoXpiZF6LHXB+JiSOimp6zfOWWUKBYFmkWKt34VLlI7Lmx/B3Pmw0Y
 I9jxZtCPludi1GP18Llbo1rmplf5EjZOC6h3YupA5CeA1cHWQ99mnYUBzm1yLi9l6dTk
 5B3U9V7+IXoVhqapNITa7jsDoiMQPvFKuE2FMzKHlm0CULpDDD7NvxvVUdvHaT8fw3Ov
 MSOxGIi2CubkqIUB6rX0ucGSkk3uCOgB6RByZoq1BK/J9DNTpVOBCI4QtDQRyVx+anwN
 zlnRjYvtxyh27Gl3SbeDd0SP3lxrbUmfHWhZYEWrUY4yfHmqb1N+ZnOyzEQSJrc8BsCY
 9z2g==
X-Gm-Message-State: AOJu0Ywn7qmo8uUGpMNNuQNpF3X7gx63KNUllkh9pg8Rt9LnvU3L/3KR
 uV/9429I5Vrgpql1l+tMK6k0JdGILb1ZDnE1CLkjMAKTy7LwHBOHkwsklPzkMfe03F/OTZx5M6W
 UbtLWKgNmTxRccvyXdhIXVgdfqGvTe02NfSpAFDazD9SyALCl114W48NR
X-Gm-Gg: ATEYQzyLnpAfpDj34lqgrg3LL/OPI/0dpfrYM2bXxVIYxh/u7Zzvl0LOlNQeVY3cFyT
 AItfy7Xpl35Y2sjoPrnSHESODDtglMkgnkZMB05BJnWjrm+mrQYKf0u4xwdm3yFLcDwdnJN2m2E
 M2UCM5hUHauzg9Q5yYruAKKJYkN5fVAYGV+SON+KzEFTeAF8CV8l+8DRv19wvISrP4Ztny9/IJE
 gfC6SY01kEXmnH9T0t+bx08pFnalAIX4uFI/H2GApPACwoQtlKl3FvO25lohRvbTNHCRRspOdTJ
 xP3jSGTdbsuIvCD3wkeDfvodlcv0JqombE6qBwxURsnby4RWaq1rZ8rFyeTW+Nb4cUBlGQfV+Cj
 FVOPzsMJYO3QvXWED+JbNnDCtdZs8lB8eWOjT1bh85A5fqeOSIhXODD/Lyb75m7fdOZl8EA==
X-Received: by 2002:a05:6000:2c0b:b0:439:b1d8:6091 with SMTP id
 ffacd0b85a97d-439b1d86191mr15957016f8f.1.1772532975051; 
 Tue, 03 Mar 2026 02:16:15 -0800 (PST)
X-Received: by 2002:a05:6000:2c0b:b0:439:b1d8:6091 with SMTP id
 ffacd0b85a97d-439b1d86191mr15956964f8f.1.1772532974547; 
 Tue, 03 Mar 2026 02:16:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b130abfasm18575905f8f.34.2026.03.03.02.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 02:16:13 -0800 (PST)
Message-ID: <3c4cf0be-3064-4308-aa5b-e2f49c2728ed@redhat.com>
Date: Tue, 3 Mar 2026 11:16:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 18/31] hw/arm/smmuv3: Make evtq producer use SEC_SID
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101723.2994751-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101723.2994751-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/21/26 11:17 AM, Tao Tang wrote:
> The event queue producer path wrote entries through address_space_memory
> with MEMTXATTRS_UNSPECIFIED, so produced entries did not use the
> sec_sid-selected DMA context.
>
> Pass AddressSpace and MemTxAttrs to queue_write() from sec_sid, and
> assert that the selected AddressSpace exists before producing entries.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b2559e80f24..fa09099a09a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -128,7 +128,8 @@ static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
>      return ret;
>  }
>  
> -static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
> +static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in,
> +                               AddressSpace *as, MemTxAttrs attrs)
>  {
>      dma_addr_t addr = Q_PROD_ENTRY(q);
>      MemTxResult ret;
> @@ -138,8 +139,7 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>      for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
>          cpu_to_le32s(&evt.word[i]);
>      }
> -    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
> -                           MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_write(as, addr, &evt, sizeof(Evt), attrs);
>      if (ret != MEMTX_OK) {
>          return ret;
>      }
> @@ -154,6 +154,11 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUQueue *q = &bank->eventq;
>      MemTxResult r;
> +    SMMUState *bs = ARM_SMMU(s);
> +    MemTxAttrs txattrs = smmu_get_txattrs(sec_sid);
> +    AddressSpace *as = smmu_get_address_space(bs, sec_sid);
> +    /* Secure AddressSpace must be available, assert if not. */
> +    g_assert(as);
same, would get rid of that check and move it at lower level.
>  
>      if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return MEMTX_ERROR;
> @@ -163,7 +168,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>          return MEMTX_ERROR;
>      }
>  
> -    r = queue_write(q, evt);
> +    r = queue_write(q, evt, as, txattrs);
>      if (r != MEMTX_OK) {
>          return r;
>      }

Besides,
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


