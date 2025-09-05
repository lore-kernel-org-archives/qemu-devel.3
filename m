Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1980CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVpB-0000T7-GL; Fri, 05 Sep 2025 08:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuVp7-0000SQ-Fz
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuVp2-0002EQ-Oq
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757076339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpcpljMfUMh20mBtGWOGNHZROKSL8KX1CovFcEkH7OA=;
 b=ODGqLmJBd55VT7BZoqKnqc8Kk4BiTzn4v3vWyi06e8thwSA/XwJgWimGn9XT/lKKl4Pjre
 Pmh6/SmgTONygMj2IC+QiKW9wRyjbyxbq3bBNCipEoOthyHkl7TDhWaAb+SyZFUUPQWrHk
 wIT77wtyV5bYmegcNaYi7fltD5PCxCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-5xEXIx5zMRmgs_yTHQ3GrQ-1; Fri, 05 Sep 2025 08:45:38 -0400
X-MC-Unique: 5xEXIx5zMRmgs_yTHQ3GrQ-1
X-Mimecast-MFC-AGG-ID: 5xEXIx5zMRmgs_yTHQ3GrQ_1757076337
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b99c18484so8695655e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 05:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757076337; x=1757681137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpcpljMfUMh20mBtGWOGNHZROKSL8KX1CovFcEkH7OA=;
 b=KWsDIS+Jp20EPyCDHOriZPlJ9jZ9mEfNnoWYOg1H73NyD76v87OUyvOeWAO5EsDz4s
 qFTFJpwjYqAOT3/8J1ZpCPkmPCShjvkRRRc6BZr8lRydBGZzsXXYAjk0qqyMcdHCjzfp
 lWLbs87gN8VTLuDI3czloAXclu2FystPvMPw645L9bWP2aefjvkZN1XrLz7+ArrYqdxG
 tNOGDj+e5l6Xq0vjWKw9sQDnO5NqXjqYGTcK1MS0jj7L7oOban8suCtxZoRw285Ls1mo
 XdJSFAPhi9prny5n98fL7gg2Uvny2hjYE8LHrBYCuBZRxHGVmISuX7RB76xQFpVDOkT2
 aXfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf971qChZh2in6wTL07uOf7eeohZQ3b3AU8Pch79CssybScSoNEU/fty/bS/6cSf+jys9tCsaWJkAk@nongnu.org
X-Gm-Message-State: AOJu0Yz2yJPyxIr9fvd67vxB8IqCKOJJwpwe5F4R3fBwl3jHAOa0407G
 3h8Mgxum23p9uQfZDPfHaEQTksei/bkw31WoN74Xtu2LKB9fcj81WosnYXuiKD8E/7XxB9a+Aj8
 3NCRnRqvzGnKARK0179QCryXQ2Ef9G7e2kwDAoBuZX+lmGP2gV4flaUOd
X-Gm-Gg: ASbGncuvBtGtTVTllWW8ClfEalp5WmDArHpJVI5Rhld9wf+FrevQfUlI5qqREfdIXgF
 Klw1M6QXYOsf7tqeE1M8xkocTif8JzfgfudAcDLyAEoMH3JMSfid72LjFz9QXcbhm4pmC8dMuxA
 9rxC6YGtrvjif3XO8aJGbBD8XAE85oKMsLXlt0GTDoJ5woXyDsn/jKv4U0O4t8w61d+LejfZSi2
 4dB6cdTMani9shipN4xO63lCiRQHJ0O+UTxdTe1b0ZP/GjqcYgDeQ/SZQdVMoTyIOtZklG/XjBI
 zsR4ANMSG1Qk7r8TCDMIz2pPPNMpQzHxkAeRPhO0LKbP1vr/dCEXzyOEu8z2kHog33B946FE3iL
 bdmw/q1fHbxY=
X-Received: by 2002:a05:600c:1d06:b0:45b:6275:42cc with SMTP id
 5b1f17b1804b1-45b8557a3f7mr178186745e9.28.1757076336923; 
 Fri, 05 Sep 2025 05:45:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPol9Apl4omw6SWkoYNvJJs9ckstWhFG2gxiVrGGSMNeipnZU64NdnnvW6yD+Gwgb9cvBZWg==
X-Received: by 2002:a05:600c:1d06:b0:45b:6275:42cc with SMTP id
 5b1f17b1804b1-45b8557a3f7mr178186485e9.28.1757076336417; 
 Fri, 05 Sep 2025 05:45:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm174502675e9.3.2025.09.05.05.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 05:45:35 -0700 (PDT)
Message-ID: <5ab38eaa-b005-432a-9de7-fae3e6096f89@redhat.com>
Date: Fri, 5 Sep 2025 14:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation commands
 to hw
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Use the provided smmuv3-accel helper functions to issue the
> invalidation commands to host SMMUv3.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-internal.h | 11 +++++++++++
>  hw/arm/smmuv3.c          | 28 ++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 8cb6a9238a..f3aeaf6375 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -233,6 +233,17 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
>  #define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)->log2size)
>  #define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)->log2size)
>  
> +static inline int smmuv3_q_ncmds(SMMUQueue *q)
> +{
> +    uint32_t prod = Q_PROD(q);
> +    uint32_t cons = Q_CONS(q);
> +
> +    if (Q_PROD_WRAP(q) == Q_CONS_WRAP(q))
> +        return prod - cons;
> +    else
> +        return WRAP_MASK(q) - cons + prod;
> +}
> +
>  static inline bool smmuv3_q_full(SMMUQueue *q)
>  {
>      return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) == WRAP_MASK(q);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index c94bfe6564..97ecca0764 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1285,10 +1285,17 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>      SMMUQueue *q = &s->cmdq;
>      SMMUCommandType type = 0;
> +    SMMUCommandBatch batch = {};
> +    uint32_t ncmds;
>  
>      if (!smmuv3_cmdq_enabled(s)) {
>          return 0;
>      }
> +
> +    ncmds = smmuv3_q_ncmds(q);
> +    batch.cmds = g_new0(Cmd, ncmds);
> +    batch.cons = g_new0(uint32_t, ncmds);
so you are provisionning space for n commands found in the queue,
independently on knowing whether they will be batched, ie. only
invalidation commands are. Then commands are added in the batch one by
one and you increment batch->ncmds in smmuv3_accel_batch_cmd. I agree
with Jonathan. This looks weird. AT least I would introduce a kelper
that inits a Back of ncmds and I would make all the batch fields
private. You you end up with the init +
smmuv3_accel_add_cmd_to_batch(batch, cmd). Then independently on the
ncmds you can issue a smmuv3_accel_issue_cmd_batch that would return if
there is nothing in the batch. You also need a batch deallocation
helper. I remember I expressed in the past my concern about having
commands executed out of order. I don't remember out conclusion on that
but this shall be clearly studied and conclusion shall be put in the
commit message.
> +
>      /*
>       * some commands depend on register values, typically CR0. In case those
>       * register values change while handling the command, spec says it
> @@ -1383,6 +1390,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>              trace_smmuv3_cmdq_cfgi_cd(sid);
>              smmuv3_flush_config(sdev);
> +            smmuv3_accel_batch_cmd(sdev->smmu, sdev, &batch, &cmd, &q->cons);
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ASID:
> @@ -1406,6 +1414,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
> +            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ALL:
> @@ -1433,6 +1442,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              trace_smmuv3_cmdq_tlbi_nsnh();
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_all(bs);
> +            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
>              break;
>          case SMMU_CMD_TLBI_NH_VAA:
>          case SMMU_CMD_TLBI_NH_VA:
> @@ -1441,6 +1451,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  break;
>              }
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> @@ -1499,12 +1510,29 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          queue_cons_incr(q);
>      }
>  
> +    qemu_mutex_lock(&s->mutex);
> +    if (!cmd_error && batch.ncmds) {
> +        if (!smmuv3_accel_issue_cmd_batch(bs, &batch)) {
> +            if (batch.ncmds) {
> +                q->cons = batch.cons[batch.ncmds - 1];
> +            } else {
> +                q->cons = batch.cons[0]; /* FIXME: Check */
> +            }
> +            qemu_log_mask(LOG_GUEST_ERROR, "Illegal command type: %d\n",
> +                          CMD_TYPE(&batch.cmds[batch.ncmds]));
Can't you have other error types returned?

Thanks

Eric
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
>      trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
>                                    Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>  


