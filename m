Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EFBC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRaO-0003oS-CK; Wed, 26 Mar 2025 10:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txRaF-0003jF-Va
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txRaD-0005Uq-8m
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742998696;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhahwpgcLXH65nyIi3P5pcPRCcUPovIfGC7Er/9p7/Y=;
 b=UsobSnSNCPKg6Kv5e0LSWSbD8sCPmWHO510uZX8/KB10JjbMdkkYqTyOFHiAkTeOcCs0Ji
 1VbcJ7+BZogLUsSxv8U13hFXo7NmJwhl7kTUIKMMYCzKwgmTb6zcCyOPtqe58vkTJz5WMv
 mIZofLZnv96yiEl3aqkiuvQACaUd3os=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Dg2ZC42ZOziSeJd7Dx5hDA-1; Wed, 26 Mar 2025 10:18:13 -0400
X-MC-Unique: Dg2ZC42ZOziSeJd7Dx5hDA-1
X-Mimecast-MFC-AGG-ID: Dg2ZC42ZOziSeJd7Dx5hDA_1742998692
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so37444615e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742998692; x=1743603492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhahwpgcLXH65nyIi3P5pcPRCcUPovIfGC7Er/9p7/Y=;
 b=PTnBcMGRZ66lJ6VWPJjLg6OeZYl9O1EzDR4IHTud0TOmbGAJ9Jbols31IuDKcjcsxi
 a1yKhQIMN/obORJgAOD0H9XKXCYcWnEMZKAiu1VexEFyExqqJmrzqM7lkHBnO4A9vBTO
 D5YGbSrse64/DQsew4vIeAXKLxVwcrgyXLvDLF9CbHH5lW8RqiSwf7FCzzjmmSx6ydqz
 jSCCsr5x8ZuRVWnOeMjmY4ywuKC21qKBS8DkxxVfNUWPa20E1iJ8nVaE8Xa0kXKbVCP1
 WHLXBika7GO9un0XnSqz+7D+H2AV4rMCJUpIrghA65Mm+/z6jIxrEJ4mECeS6vEqW9JL
 nmoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhh+b8K5wf7CIOscc8KbkjibWJdtVcyGVXlCvuHQra5L2taWOAXyvuUqicRb02dT5pWq5E6SIogthB@nongnu.org
X-Gm-Message-State: AOJu0Yznc2PVXw0g2uS8700zyqByI2xSr3/OWnLM2r7WGLlqIOYFRVvA
 bXVsZyOQwe17a0LOerw92dNRAKhdg6mw6fpPIewwUBVU+gLEWaKXYDLpW6hZieexrGmWbtX8alZ
 B/jv6w1FF3ny/yQ8f35HvNFTZXJk+Eunr9mvMrVzaIpNkGFkBYKeF
X-Gm-Gg: ASbGncvb9DvWqkNM+sk8GpdSBelrzUu063FO5Dyl7rhB27SiYixlZ+m9Mx639NyQPus
 B/3gtOiHC0vcnrXI7W66DF05Izh+Tb1JLAJ6+cYqtNfhnuyuXPwNM7YGis9eG36XO+IKUDdIl2T
 d/2ZSH7ueCyiA6OEROWFocj/U9B/KjJjfUfW1U/vyAILFGnxL32IaHTuUqxOGm8elLBPH7RjY+D
 3O+Ht1RAYSJaiBbiQF5ZoM+TSuH3whT7V04wbp2JGGJ09hTY+aZYOdVYGG7ztC2KryQHGE+u0Nr
 kajtJMnGoXCQKGb4LVHQaojnDW8p6TeG5TWIhG6FesmbqdWxrkRsdXOVPpueq8w=
X-Received: by 2002:a05:600c:3547:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43d7894c000mr35043245e9.10.1742998689904; 
 Wed, 26 Mar 2025 07:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhaxbqxFBlipgMrSV2s1LXO+4vNmNC+11PmUegdCGGX9NuPxgiSd3xmzcQszmRElvdIiqwNQ==
X-Received: by 2002:a05:600c:3547:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43d7894c000mr35042625e9.10.1742998689417; 
 Wed, 26 Mar 2025 07:18:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3b83sm17192486f8f.33.2025.03.26.07.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 07:18:08 -0700 (PDT)
Message-ID: <6b943f66-6a2d-4db7-9524-c4c1fa2fbaec@redhat.com>
Date: Wed, 26 Mar 2025 15:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/20] hw/arm/smmuv3: Forward invalidation commands
 to hw
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-16-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-16-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Use the provided smmuv3-accel helper functions to issue the
> command to physical SMMUv3.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-internal.h | 11 ++++++++
>  hw/arm/smmuv3.c          | 58 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 4602ae6728..546f8faac0 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -235,6 +235,17 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
>  #define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)->log2size)
>  #define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)->log2size)
>  
> +static inline int smmuv3_q_ncmds(SMMUQueue *q)
> +{
> +        uint32_t prod = Q_PROD(q);
> +        uint32_t cons = Q_CONS(q);
> +
> +        if (Q_PROD_WRAP(q) == Q_CONS_WRAP(q))
> +                return prod - cons;
> +        else
> +                return WRAP_MASK(q) - cons + prod;
> +}
> +
>  static inline bool smmuv3_q_full(SMMUQueue *q)
>  {
>      return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) == WRAP_MASK(q);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 83159db1d4..e0f225d0df 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1297,10 +1297,18 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>      SMMUQueue *q = &s->cmdq;
>      SMMUCommandType type = 0;
> +    SMMUCommandBatch batch = {};
> +    uint32_t ncmds = 0;
> +
>  
>      if (!smmuv3_cmdq_enabled(s)) {
>          return 0;
>      }
> +
> +    ncmds = smmuv3_q_ncmds(q);
> +    batch.cmds = g_new0(Cmd, ncmds);
> +    batch.cons = g_new0(uint32_t, ncmds);
> +
>      /*
>       * some commands depend on register values, typically CR0. In case those
>       * register values change while handling the command, spec says it
> @@ -1395,6 +1403,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>              trace_smmuv3_cmdq_cfgi_cd(sid);
>              smmuv3_flush_config(sdev);
> +
> +            if (smmuv3_accel_batch_cmds(sdev->smmu, sdev, &batch, &cmd,
> +                                        &q->cons, true)) {
> +                cmd_error = SMMU_CERROR_ILL;
OK so now I see you record the error. You can ignore the previous comment.
> +                break;
> +            }
> +
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ASID:
> @@ -1418,6 +1433,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
> +
> +            if (smmuv3_accel_batch_cmds(bs, NULL, &batch, &cmd, &q->cons,
> +                                        false)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ALL:
> @@ -1445,6 +1467,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              trace_smmuv3_cmdq_tlbi_nsnh();
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_all(bs);
> +
> +            if (smmuv3_accel_batch_cmds(bs, NULL, &batch, &cmd, &q->cons,
> +                                        false)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
>          case SMMU_CMD_TLBI_NH_VAA:
>          case SMMU_CMD_TLBI_NH_VA:
> @@ -1453,7 +1481,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  break;
>              }
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +
> +            if (smmuv3_accel_batch_cmds(bs, NULL, &batch, &cmd, &q->cons,
> +                                        false)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +            break;
> +        case SMMU_CMD_ATC_INV:
To me the code below shall be put in a separate patch as it introduces
the suport for a new cmd. Also it shall be properly documented in the
commit msg
> +        {
> +            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
> +
> +            if (smmuv3_accel_batch_cmds(sdev->smmu, sdev, &batch, &cmd,
> +                                        &q->cons, true)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
> +        }
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
>              int vmid = CMD_VMID(&cmd);
> @@ -1485,7 +1530,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          case SMMU_CMD_TLBI_EL2_ASID:
>          case SMMU_CMD_TLBI_EL2_VA:
>          case SMMU_CMD_TLBI_EL2_VAA:
> -        case SMMU_CMD_ATC_INV:
>          case SMMU_CMD_PRI_RESP:
>          case SMMU_CMD_RESUME:
>          case SMMU_CMD_STALL_TERM:
> @@ -1511,12 +1555,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          queue_cons_incr(q);
>      }
>  
> +    qemu_mutex_lock(&s->mutex);
> +    if (!cmd_error && batch.ncmds) {
> +        if (smmuv3_accel_issue_cmd_batch(bs, &batch)) {
> +            q->cons = batch.cons[batch.ncmds];
> +            cmd_error = SMMU_CERROR_ILL;
> +        }
> +    }
> +    qemu_mutex_unlock(&s->mutex);
> +
>      if (cmd_error) {
>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
>          smmu_write_cmdq_err(s, cmd_error);
>          smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
>      }
>  
> +    g_free(batch.cmds);
> +    g_free(batch.cons);
> +
>      trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
>                                    Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>  
Eric


