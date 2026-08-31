Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFD9C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0twj-0001pG-Ie; Mon, 31 Aug 2026 00:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0twh-0001oz-P0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0twg-0005Pv-4M
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788151712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzEg9DokCdN7f7ITOdLl6p8gFE9FnMLxAxxYpDcugkA=;
 b=VVpX1ABt6cwZoS1LutGZlCLxnlQo5XSmg0cLuuOIZNFr5felPQy70hIBY4zOIAWw30felb
 1etu4TgUcLqybKUfxzFZ6zPwsGt33LPpK1rYnXviyHg0OpNhvbx+KzBiugeOIIRlhKTZSQ
 G5bRiUNB1rMEmLwvndGaaOSYs3meE1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Mc0KKcRLNe-SeCTdLA2Xjg-1; Mon, 31 Aug 2026 00:48:30 -0400
X-MC-Unique: Mc0KKcRLNe-SeCTdLA2Xjg-1
X-Mimecast-MFC-AGG-ID: Mc0KKcRLNe-SeCTdLA2Xjg_1788151709
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b7c1dcc82so19420475e9.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151709; x=1788756509;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lzEg9DokCdN7f7ITOdLl6p8gFE9FnMLxAxxYpDcugkA=;
 b=exnlizUhcLMSLhEOEaGc+L5pNFyVWVyt1e6stOkwBrvhShxcDlG9TFl1h9Qj8IP8Lv
 +DlaF884t79ZLc80jnpBMBS/ROCbZg017bqDz3zwrao4v7QK8KBROHyn6QPUAXsmipXz
 JnpyjTsf1UMVS48oODb2XtSCU6TbU4YqmqnpdOzLWOwsX30kE82tTwPAO/pDy03tyXJD
 1gbpnTvYj5hmSIKIJGrjEw6pl9VWyOXM76WlPEbet+dk4OA514P1O3y7FWxAHl3UytVD
 ust/3+Z/vRUB8QnTFb8f+nIKnGXyXrjJbd0wPbFaaR/Xs/VEMKnt6CfWf+GGLplINAJD
 uWWw==
X-Gm-Message-State: AFuF++l82g/F0JOa5HbitcC3q0C83oI2+hrhTliXDoR/70+tD+5x4pu0
 ORrpbpJ3akcVgO4ttmjS+Ro92zlIIZ9f/K0TuDjtKmqpUkrz3tApxAuMeW1Y2QRGduhMU/yQdp+
 x5FbJOv4tMSxZgKpFVk7oVI0WHuMXw8kTYGQkoX3knzYCEVtBqQOt0YT1
X-Gm-Gg: AR+sD10xve52vMpTFlj8PHMjzVFoUz9f/HRauOeoc0Cw63XDtVds+QgyRBzoUwKLZvn
 P4C/8d8qOPWu4lJyswSX6zus55lwY6bq+/hz9SeZdXh6FfSccIqwjXkmAm+B1M6lARy2Gs9Xaqj
 U0GqxG4hKLgs6aDLaMDtrP4NSykv8Is5b/cRtk7yx1qJUPOo6MLnaVBDcRLqviTwcC8yHhyPVy2
 HCxWkehnuBEBhrb177g4z8CJSJkhj6o76+qQj7JUU8snfpdVBTluUtiKcyv8sXnjhMxufwy5SsX
 WDOHwfu8tgEvJ6as3G3WC2ErqxM4Vy5uqaZYO00wHi39w9eMes5k7ebPN0wPIVqrEbiNLP3vnt9
 /NaXSZFfpXqJVex7Y38ZT0VnS/kpYWNej1zS2PSIX6Qnb16X2
X-Received: by 2002:a05:600c:a106:b0:49c:cb6a:1687 with SMTP id
 5b1f17b1804b1-49ccb6a1689mr192652795e9.4.1788151709224; 
 Sun, 30 Aug 2026 21:48:29 -0700 (PDT)
X-Received: by 2002:a05:600c:a106:b0:49c:cb6a:1687 with SMTP id
 5b1f17b1804b1-49ccb6a1689mr192652595e9.4.1788151708752; 
 Sun, 30 Aug 2026 21:48:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c52fdbsm195385565e9.0.2026.08.30.21.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:48:27 -0700 (PDT)
Message-ID: <d35652ed-2d4c-42c9-93e1-b59f05b99139@redhat.com>
Date: Mon, 31 Aug 2026 06:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 20/28] hw/arm/smmuv3: Route IRQ and GERROR handling by
 SEC_SID
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Tao,

On 8/13/26 6:25 PM, Tao Tang wrote:
> Interrupt and global error handling currently always selects the
> Non-secure register bank, even when the event or command originates
> from the Secure programming interface. This splits CMDQ_CONS.ERR from
> GERROR.CMDQ_ERR and prevents Secure software from acknowledging the
> error through S_GERRORN.
>
> Pass SEC_SID through the IRQ and GERROR helpers and all queue call
> sites so interrupt enable checks, global error reporting, and
> acknowledgement use the originating programming-interface bank.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b36bc4a54e0..d69fc0898af 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -49,11 +49,11 @@
>   *
>   * @irq: irq type
>   * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
> + * @sec_sid: security state of the programming interface
>   */
>  static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
> -                               uint32_t gerror_mask)
> +                               uint32_t gerror_mask, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>  
>      bool pulse = false;
> @@ -90,9 +90,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>      }
>  }
>  
> -static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
> +static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
> +                                 SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      uint32_t pending = bank->gerror ^ bank->gerrorn;
>      uint32_t toggled = bank->gerrorn ^ new_gerrorn;
> @@ -173,7 +173,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>      }
>  
>      if (!smmuv3_q_empty(q)) {
> -        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
>      }
>      return MEMTX_OK;
>  }
> @@ -187,7 +187,8 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid)
>      QEMU_LOCK_GUARD(&s->mutex);
>      r = smmuv3_write_eventq(s, sec_sid, evt);
>      if (r != MEMTX_OK) {
> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
> +                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
>      }
>  }
>  
> @@ -1645,7 +1646,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>          switch (type) {
>          case SMMU_CMD_SYNC:
>              if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
> -                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
> +                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
>              }
>              break;
>          case SMMU_CMD_PREFETCH_CONFIG:
> @@ -1879,7 +1880,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>      if (cmd_error) {
>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
>          smmu_write_cmdq_err(s, cmd_error, sec_sid);
> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
> +                           R_GERROR_CMDQ_ERR_MASK, sec_sid);
>      }
>  
>      trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
> @@ -1996,7 +1998,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          bank->irq_ctrl = data;
>          break;
>      case A_GERRORN:
> -        smmuv3_write_gerrorn(s, data);
> +        smmuv3_write_gerrorn(s, data, reg_sec_sid);
>          /*
>           * By acknowledging the CMDQ_ERR, SW may notify cmds can
>           * be processed again


