Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17918C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsMF-0002Uk-9t; Fri, 28 Aug 2026 04:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzsMD-0002UQ-PP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzsM9-0001lH-St
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787907273;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ql5hFPZky70gFB8ykPTYnOhlmxhaq6N/RN9Rj5r9lRg=;
 b=ACP1flImORRgIUFmNVQIAkCeN5cvoDZbs7ikPkbNn7Ufn/T7D84WEti/F009ZFy0lhXqFA
 cL1IlXIi/+L22pxvUyxf7ckBEWuRNHhM5thHG+Ni0YVr/IgJswP4XMeU2TKq956RwRpDRC
 /u1BlJSwvps+64q5ljGoAdbw/I3X0dA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-8kwF9t_DPAqYzaLbeTurEA-1; Fri, 28 Aug 2026 04:54:30 -0400
X-MC-Unique: 8kwF9t_DPAqYzaLbeTurEA-1
X-Mimecast-MFC-AGG-ID: 8kwF9t_DPAqYzaLbeTurEA_1787907270
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482e2541c30so385721f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787907269; x=1788512069;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ql5hFPZky70gFB8ykPTYnOhlmxhaq6N/RN9Rj5r9lRg=;
 b=NgrusYsEBMOXOCGamQhq5PpDL3lOoL6NmYoyfJcDuMoy7jMxMITfCs79ZAIJcoviTS
 9IsJmCcBVkInRIu14Xw8+UFHOaBC3MrL6ObTgBl++n6JoBVUNEEYCe91e9WKAtgG6pFp
 pkpHbLWHDaArRUkAq2VnSmRyH+04r7D+CsGvxl4qLoSmE2nX/YUETg2YIIqPqb5TJYph
 J6KKR1ysj5vQ4PqBTEmMqD2vkTDlXpbaUW7WS7YWPmWCO/nllf1UX+fTAcjMRKa359zL
 1LOEiOnona8ualojlz2wyZShD01SEHaW64Yrh79aCANAkpsdVI5Qd/GpH6XvBiDgRqAX
 oZUA==
X-Gm-Message-State: AFuF++m07OfSc5U9jER7uqqp6afwn+27qDMQLRNdAaRxYLG30SK/CfkN
 ucj8jrK4/CH1DN5uGgrkxLQHrzLQH7suEE9nfevpVZS9utGFMaBZapmi2BBJ9sYnR0N5oiZsOBH
 kDXF1Qly1FBIP9CEDO0b1a6fC9O3fkUKGQBgZC/2dKiJenWKQ/KaUv3aH
X-Gm-Gg: AR+sD12AG6+VW9XBG0OY79a03nfQuQHzlGwYHEKAz1DUKmMF6j1tEzQXxjEsw4t7nVL
 NYvezvpJ64JgFrVVypaj4oo/FwZ9ZGf7Az7S8qWW2xL83MfmNUucXrG+ydhFL+jGya5p4hYHdaf
 wb20SD4SsstA3LM0Y9OACu2+IjwN3K8RLgVI7345O4b9e30Mh6JTLBrP41Rv1Q1hFD1qsKMCe00
 uj4GIJQKyOh3EDQQrSpYF7YQ60p7MiD00O7ARMDrtNBKvb3B7MpsVI/qeCQmSObgrArvmBSBR+M
 bMrVF3FB/Y+a+tGyi0uKnbyr/iczqBsH5kz6RZAvu2EuZc7KtAZ99gas5ybwTS7EAuw7JoUJVai
 k/olae0iOUb8z0/GNwJQQAz9II7H9+Ne3EnW5Itfd47bXTD8p
X-Received: by 2002:a05:6000:4a1b:b0:482:e4bc:51a9 with SMTP id
 ffacd0b85a97d-482f75789a7mr7266588f8f.4.1787907269283; 
 Fri, 28 Aug 2026 01:54:29 -0700 (PDT)
X-Received: by 2002:a05:6000:4a1b:b0:482:e4bc:51a9 with SMTP id
 ffacd0b85a97d-482f75789a7mr7266527f8f.4.1787907268715; 
 Fri, 28 Aug 2026 01:54:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20713sm2469303f8f.21.2026.08.28.01.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 01:54:27 -0700 (PDT)
Message-ID: <be147db5-71df-46f5-b245-78af15b945fc@redhat.com>
Date: Fri, 28 Aug 2026 10:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 15/28] hw/arm/smmu: Make CMDQ invalidation security-state
 aware
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
 <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Refactor CMDQ invalidation paths to carry security state and apply cache
> invalidation per sec_sid instead of globally. Add separate helpers for
> invalidating all entries and for invalidating entries belonging to one
> valid sec_sid.
>
> In smmuv3, propagate the command queue sec_sid and command SSec through
> CFGI and TLBI handling, and gate VMID use on the stage-2 capability of
> the selected command queue, including SMMU_S_IDR1.SEL2 for a Secure
> Command queue.
>
> Keep acceleration and IOMMU notifier propagation Non-secure-only.
> Commands targeting a programming interface other than Non-secure do not
> reach the accelerated backend or Non-secure notifiers, while Non-secure
> stage-1 CMD_TLBI_NH_ALL remains forwarded to the host.
>
> Include the command queue SEC_SID and target SEC_SID in the relevant
> invalidation tracepoints.
Could you split this patch so that the review becomes easier? The code
diff is huge and to me there are several functional aspects that can be
dealt with separately. For instance I see it handles invalidation for
both iotlb and cache hash tables. I have the feeling this could be
easily split, no?

Also we have changes to accel install_ste* smmuv3_accel_issue_inv_cmd
that look quite unrelated? Also shouldn't they enforce NS is used in
accel mode? I would put that in a separate patch anyway.

smmuv3_inv_notifiers_all() intro could be also handled in a separate patch.

Thanks

Eric


>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 100 ++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel-stubs.c  |   6 +-
>  hw/arm/smmuv3-accel.c        |  30 +++++++--
>  hw/arm/smmuv3-accel.h        |   6 +-
>  hw/arm/smmuv3.c              | 121 ++++++++++++++++++++++++++---------
>  hw/arm/trace-events          |  12 ++--
>  include/hw/arm/smmu-common.h |   6 ++
>  7 files changed, 231 insertions(+), 50 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3d4b6b3a287..e8a1ed65c19 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -217,12 +217,30 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new,
>      g_hash_table_insert(bs->iotlb, key, new);
>  }
>  
> +static gboolean smmu_hash_remove_by_sec_sid(gpointer key, gpointer value,
> +                                            gpointer user_data)
> +{
> +    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> +    SMMUSecSID *sec_sid = (SMMUSecSID *)user_data;
> +
> +    return SMMU_IOTLB_SEC_SID(*iotlb_key) == *sec_sid;
> +}
> +
>  void smmu_iotlb_inv_all(SMMUState *s)
>  {
>      trace_smmu_iotlb_inv_all();
>      g_hash_table_remove_all(s->iotlb);
>  }
>  
> +void smmu_iotlb_inv_by_sec_sid(SMMUState *s, SMMUSecSID sec_sid)
> +{
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> +
> +    trace_smmu_iotlb_inv_by_sec_sid(sec_sid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_sec_sid,
> +                                &sec_sid);
> +}
> +
>  static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
>                                                gpointer user_data)
>  {
> @@ -298,6 +316,16 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>             ((entry->iova & ~info->mask) == info->iova);
>  }
>  
> +typedef struct SMMUConfigInvRangeInfo {
> +    SMMUSIDRange sid_range;
> +    SMMUSecSID sec_sid;
> +} SMMUConfigInvRangeInfo;
> +
> +typedef struct SMMUConfigInvSdevInfo {
> +    SMMUDevice *sdev;
> +    SMMUSecSID sec_sid;
> +} SMMUConfigInvSdevInfo;
> +
>  static gboolean
>  smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
>  {
> @@ -309,7 +337,26 @@ smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
>      if (sid < sid_range->start || sid > sid_range->end) {
>          return false;
>      }
> -    trace_smmu_config_cache_inv(sid);
> +    trace_smmu_config_cache_inv(config_key->sec_sid, sid);
> +    return true;
> +}
> +
> +static gboolean
> +smmu_hash_remove_by_sid_range_sec(gpointer key, gpointer value,
> +                                  gpointer user_data)
> +{
> +    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
> +    SMMUConfigInvRangeInfo *info = (SMMUConfigInvRangeInfo *)user_data;
> +    SMMUDevice *sdev = config_key->sdev;
> +    uint32_t sid = smmu_get_sid(sdev);
> +
> +    if (config_key->sec_sid != info->sec_sid) {
> +        return false;
> +    }
> +    if (sid < info->sid_range.start || sid > info->sid_range.end) {
> +        return false;
> +    }
> +    trace_smmu_config_cache_inv(config_key->sec_sid, sid);
>      return true;
>  }
>  
> @@ -320,6 +367,23 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
>                                  &sid_range);
>  }
>  
> +void smmu_configs_inv_sid_range_by_sec_sid(SMMUState *s,
> +                                           SMMUSIDRange sid_range,
> +                                           SMMUSecSID sec_sid)
> +{
> +    SMMUConfigInvRangeInfo info = {
> +        .sid_range = sid_range,
> +        .sec_sid = sec_sid,
> +    };
> +
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> +
> +    trace_smmu_configs_inv_sid_range_by_sec_sid(sec_sid, sid_range.start,
> +                                                sid_range.end);
> +    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sid_range_sec,
> +                                &info);
> +}
> +
>  static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> @@ -329,7 +393,25 @@ static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
>      if (config_key->sdev != target) {
>          return false;
>      }
> -    trace_smmu_config_cache_inv(smmu_get_sid(target));
> +    trace_smmu_config_cache_inv(config_key->sec_sid,
> +                                smmu_get_sid(target));
> +    return true;
> +}
> +
> +static gboolean smmu_hash_remove_by_sdev_sec(gpointer key, gpointer value,
> +                                             gpointer user_data)
> +{
> +    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
> +    SMMUConfigInvSdevInfo *info = (SMMUConfigInvSdevInfo *)user_data;
> +
> +    if (config_key->sdev != info->sdev) {
> +        return false;
> +    }
> +    if (config_key->sec_sid != info->sec_sid) {
> +        return false;
> +    }
> +    trace_smmu_config_cache_inv(config_key->sec_sid,
> +                                smmu_get_sid(info->sdev));
>      return true;
>  }
>  
> @@ -338,6 +420,20 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
>      g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
>  }
>  
> +void smmu_configs_inv_sdev_by_sec_sid(SMMUState *s, SMMUDevice *sdev,
> +                                      SMMUSecSID sec_sid)
> +{
> +    SMMUConfigInvSdevInfo info = {
> +        .sdev = sdev,
> +        .sec_sid = sec_sid,
> +    };
> +
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> +
> +    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev_sec,
> +                                &info);
> +}
> +
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl,
>                           SMMUSecSID sec_sid)
> diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
> index b8dd7e7b897..ecc6890a9cc 100644
> --- a/hw/arm/smmuv3-accel-stubs.c
> +++ b/hw/arm/smmuv3-accel-stubs.c
> @@ -16,13 +16,13 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
>  }
>  
>  bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> -                              Error **errp)
> +                              SMMUSecSID sec_sid, Error **errp)
>  {
>      return true;
>  }
>  
>  bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> -                                    Error **errp)
> +                                    SMMUSecSID sec_sid, Error **errp)
>  {
>      return true;
>  }
> @@ -33,7 +33,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>  }
>  
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
> -                                Error **errp)
> +                                SMMUSecSID sec_sid, Error **errp)
>  {
>      return true;
>  }
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9d207acc8e3..a738c4fad67 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -283,7 +283,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
>  }
>  
>  bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> -                              Error **errp)
> +                              SMMUSecSID sec_sid, Error **errp)
>  {
>      SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
>                             .inval_ste_allowed = true};
> @@ -294,7 +294,13 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>      SMMUS1Hwpt *s1_hwpt = NULL;
>      const char *type;
>      STE ste;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> +
> +    /* Acceleration supports only the Non-secure programming interface. */
> +    if (sec_sid != SMMU_SEC_SID_NS) {
> +        return true;
> +    }
>  
>      if (!accel || !accel->viommu) {
>          return true;
> @@ -377,13 +383,20 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>  }
>  
>  bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> -                                    Error **errp)
> +                                    SMMUSecSID sec_sid, Error **errp)
>  {
>      SMMUv3AccelState *accel = s->s_accel;
>      SMMUv3AccelDevice *accel_dev;
>      Error *local_err = NULL;
>      bool all_ok = true;
>  
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> +
> +    /* Acceleration supports only the Non-secure programming interface. */
> +    if (sec_sid != SMMU_SEC_SID_NS) {
> +        return true;
> +    }
> +
>      if (!accel || !accel->viommu) {
>          return true;
>      }
> @@ -393,7 +406,7 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>  
>          if (sid >= range->start && sid <= range->end) {
>              if (!smmuv3_accel_install_ste(s, &accel_dev->sdev,
> -                                          sid, &local_err)) {
> +                                          sid, sec_sid, &local_err)) {
>                  error_append_hint(&local_err, "Device 0x%x: Failed to install "
>                                    "STE\n", sid);
>                  error_report_err(local_err);
> @@ -416,12 +429,19 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>   * non SID invalidations such as SMMU_CMD_TLBI_NH_ASID and SMMU_CMD_TLBI_NH_VA.
>   */
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
> -                                Error **errp)
> +                                SMMUSecSID sec_sid, Error **errp)
>  {
>      SMMUv3State *s = ARM_SMMUV3(bs);
>      SMMUv3AccelState *accel = s->s_accel;
>      uint32_t entry_num = 1;
>  
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> +
> +    /* Acceleration supports only the Non-secure programming interface. */
> +    if (sec_sid != SMMU_SEC_SID_NS) {
> +        return true;
> +    }
> +
>      /*
>       * No accel or viommu means no VFIO/IOMMUFD devices, nothing to
>       * invalidate.
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index ea11d513cc9..761943f137a 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -89,12 +89,12 @@ typedef struct SMMUv3AccelDevice {
>  
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
>  bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> -                              Error **errp);
> +                              SMMUSecSID sec_sid, Error **errp);
>  bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
> -                                    Error **errp);
> +                                    SMMUSecSID sec_sid, Error **errp);
>  bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
> -                                Error **errp);
> +                                SMMUSecSID sec_sid, Error **errp);
>  void smmuv3_accel_idr_override(SMMUv3State *s);
>  bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
>  int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7e08b88689f..47f0d575817 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1005,12 +1005,13 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>      return cfg;
>  }
>  
> -static void smmuv3_flush_config(SMMUDevice *sdev)
> +static void smmuv3_flush_config_by_sec_sid(SMMUDevice *sdev,
> +                                           SMMUSecSID sec_sid)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
>  
> -    smmu_configs_inv_sdev(bc, sdev);
> +    smmu_configs_inv_sdev_by_sec_sid(bc, sdev, sec_sid);
>  }
>  
>  /* Do translation with TLB lookup. */
> @@ -1314,10 +1315,16 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                        dma_addr_t iova, uint8_t tg,
> -                                      uint64_t num_pages, int stage)
> +                                      uint64_t num_pages, int stage,
> +                                      SMMUSecSID sec_sid)
>  {
>      SMMUDevice *sdev;
>  
> +    /* IOMMU notifiers are supported only for Non-secure devices. */
> +    if (sec_sid != SMMU_SEC_SID_NS) {
> +        return;
> +    }
> +
>      QLIST_FOREACH(sdev, &s->devices_with_notifiers, next) {
>          IOMMUMemoryRegion *mr = &sdev->iommu;
>          IOMMUNotifier *n;
> @@ -1331,8 +1338,16 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>      }
>  }
>  
> +static void smmuv3_inv_notifiers_all(SMMUState *s, SMMUSecSID sec_sid)
> +{
> +    /* IOMMU notifiers are supported only for Non-secure devices. */
> +    if (sec_sid == SMMU_SEC_SID_NS) {
> +        smmu_inv_notifiers_all(s);
> +    }
> +}
> +
>  static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
> -                               SMMUSecSID sec_sid)
> +                               SMMUSecSID sec_sid, bool use_vmid)
>  {
>      dma_addr_t end, addr = CMD_ADDR(cmd);
>      uint8_t type = CMD_TYPE(cmd);
> @@ -1345,10 +1360,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>      uint64_t num_pages;
>      uint8_t granule;
>      int asid = -1;
> -    SMMUv3State *smmuv3 = ARM_SMMUV3(s);
>  
> -    /* Only consider VMID if stage-2 is supported. */
> -    if (STAGE2_SUPPORTED(smmuv3)) {
> +    if (use_vmid) {
>          vmid = CMD_VMID(cmd);
>      }
>  
> @@ -1359,7 +1372,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>      if (!tg) {
>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
>                                   tg, 1, ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage,
> +                                  sec_sid);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>          } else {
> @@ -1383,7 +1397,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
>                                   num_pages, ttl, leaf, stage);
>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
> -                                  num_pages, stage);
> +                                  num_pages, stage, sec_sid);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>                                  num_pages, ttl, sec_sid);
> @@ -1394,6 +1408,26 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>      }
>  }
>  
> +static inline bool
> +smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    /* IDR0.S2P: Stage 2 translation supported */
> +    bool s2p = STAGE2_SUPPORTED(s);
> +    if (!s2p) {
> +        return false;
> +    }
> +
> +    /*
> +     * For Secure Command queue, Secure stage 2 is additionally gated by SEL2
> +     * (SEL2 is 0 if S2P is 0).
> +     */
> +    if (sec_sid == SMMU_SEC_SID_S) {
> +        return FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2);
> +    }
> +
> +    return true;
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1403,6 +1437,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>      SMMUCommandType type = 0;
>      MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
>      AddressSpace *as = smmu_get_address_space(bs, sec_sid);
> +    bool queue_stage2_supported = smmu_cmdq_stage2_supported(s, sec_sid);
>  
>      if (!smmuv3_cmdq_enabled(s, sec_sid)) {
>          return 0;
> @@ -1464,12 +1499,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>                  break;
>              }
>  
> -            trace_smmuv3_cmdq_cfgi_ste(sid);
> -            if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
> +            trace_smmuv3_cmdq_cfgi_ste(sec_sid, ssec, sid);
> +            if (!smmuv3_accel_install_ste(s, sdev, sid, ssec, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_flush_config(sdev);
> +            smmuv3_flush_config_by_sec_sid(sdev, ssec);
>  
>              break;
>          }
> @@ -1483,12 +1518,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>              sid_range.start = sid & ~mask;
>              sid_range.end = sid_range.start + mask;
>  
> -            trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
> -            if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
> +            trace_smmuv3_cmdq_cfgi_ste_range(sec_sid, ssec,
> +                                             sid_range.start, sid_range.end);
> +            if (!smmuv3_accel_install_ste_range(s, &sid_range, ssec, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmu_configs_inv_sid_range(bs, sid_range);
> +            smmu_configs_inv_sid_range_by_sec_sid(bs, sid_range, ssec);
>              break;
>          }
>          case SMMU_CMD_CFGI_CD:
> @@ -1510,9 +1546,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>                  break;
>              }
>  
> -            trace_smmuv3_cmdq_cfgi_cd(sid);
> -            smmuv3_flush_config(sdev);
> -            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
> +            trace_smmuv3_cmdq_cfgi_cd(sec_sid, ssec, sid);
> +            smmuv3_flush_config_by_sec_sid(sdev, ssec);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, ssec, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> @@ -1532,14 +1568,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>               * VMID is only matched when stage 2 is supported, otherwise set it
>               * to -1 as the value used for stage-1 only VMIDs.
>               */
> -            if (STAGE2_SUPPORTED(s)) {
> +            if (queue_stage2_supported) {
>                  vmid = CMD_VMID(&cmd);
>              }
>  
>              trace_smmuv3_cmdq_tlbi_nh_asid(sec_sid, asid);
> -            smmu_inv_notifiers_all(&s->smmu_state);
> +            smmuv3_inv_notifiers_all(bs, sec_sid);
>              smmu_iotlb_inv_asid_vmid(bs, asid, vmid, sec_sid);
> -            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, sec_sid, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> @@ -1558,31 +1594,51 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>               * If stage-2 is supported, invalidate for this VMID only, otherwise
>               * invalidate the whole thing.
>               */
> -            if (STAGE2_SUPPORTED(s)) {
> +            if (queue_stage2_supported) {
>                  vmid = CMD_VMID(&cmd);
>                  trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
>                  smmu_iotlb_inv_vmid_s1(bs, vmid, sec_sid);
>                  break;
>              }
> -            QEMU_FALLTHROUGH;
> +            trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
> +            smmuv3_inv_notifiers_all(bs, sec_sid);
> +            smmu_iotlb_inv_by_sec_sid(bs, sec_sid);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, sec_sid, errp)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +            break;
>          }
>          case SMMU_CMD_TLBI_NSNH_ALL:
> -            trace_smmuv3_cmdq_tlbi_nsnh();
> -            smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_all(bs);
> -            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
> +        {
> +            /*
> +             * CMD_TLBI_NSNH_ALL targets Non-secure entries when issued from the
> +             * Non-secure or Secure Command queue, but Realm entries when issued
> +             * from the Realm Command queue.
> +             * (IHI 0070G.b) 4.4.4.1 CMD_TLBI_NSNH_ALL, Page 194
> +             */
> +            SMMUSecSID target_sec_sid = sec_sid > SMMU_SEC_SID_S ?
> +                                        sec_sid : SMMU_SEC_SID_NS;
> +
> +            trace_smmuv3_cmdq_tlbi_nsnh(sec_sid, target_sec_sid);
> +            smmuv3_inv_notifiers_all(bs, target_sec_sid);
> +            smmu_iotlb_inv_by_sec_sid(bs, target_sec_sid);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, target_sec_sid,
> +                                            errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
>              break;
> +        }
>          case SMMU_CMD_TLBI_NH_VAA:
>          case SMMU_CMD_TLBI_NH_VA:
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
> -            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid,
> +                               queue_stage2_supported);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, sec_sid, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> @@ -1597,7 +1653,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>              }
>  
>              trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
> -            smmu_inv_notifiers_all(&s->smmu_state);
> +            smmuv3_inv_notifiers_all(bs, SMMU_SEC_SID_NS);
>              smmu_iotlb_inv_vmid(bs, vmid, SMMU_SEC_SID_NS);
>              break;
>          }
> @@ -1610,7 +1666,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS, true);
>              break;
>          case SMMU_CMD_ATC_INV:
>          {
> @@ -1621,7 +1677,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>                  break;
>              }
>  
> -            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev,
> +                                            SMMU_SEC_SID_NS, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index ccc0ab50164..7cd4eb38578 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -19,12 +19,14 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> +smmu_iotlb_inv_by_sec_sid(int sec_sid) "IOTLB invalidate sec_sid=%d"
>  smmu_iotlb_inv_asid_vmid(int sec_sid, int asid, int vmid) "IOTLB invalidate sec_sid=%d asid=%d vmid=%d"
>  smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
>  smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
>  smmu_iotlb_inv_iova(int sec_sid, int asid, uint64_t addr) "IOTLB invalidate sec_sid=%d asid=%d addr=0x%"PRIx64
>  smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
> -smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> +smmu_configs_inv_sid_range_by_sec_sid(int sec_sid, uint32_t start, uint32_t end) "Config cache INV sec_sid=%d SID range from 0x%x to 0x%x"
> +smmu_config_cache_inv(int sec_sid, uint32_t sid) "Config cache INV sec_sid=%d sid=0x%x"
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>  smmu_iotlb_lookup_hit(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
>  smmu_iotlb_lookup_miss(int sec_sid, int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS sec_sid=%d asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> @@ -52,14 +54,14 @@ smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t tr
>  smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>  smmuv3_decode_cd(uint32_t oas) "oas=%d"
>  smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
> -smmuv3_cmdq_cfgi_ste(int streamid) "streamid= 0x%x"
> -smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
> -smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
> +smmuv3_cmdq_cfgi_ste(int sec_sid, int ssec, int streamid) "cmdq_sec_sid=%d ssec=%d streamid=0x%x"
> +smmuv3_cmdq_cfgi_ste_range(int sec_sid, int ssec, int start, int end) "cmdq_sec_sid=%d ssec=%d start=0x%x - end=0x%x"
> +smmuv3_cmdq_cfgi_cd(int sec_sid, int ssec, uint32_t sid) "cmdq_sec_sid=%d ssec=%d sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
>  smmuv3_cmdq_tlbi_nh(int sec_sid, int vmid) "sec_sid=%d vmid=%d"
> -smmuv3_cmdq_tlbi_nsnh(void) ""
> +smmuv3_cmdq_tlbi_nsnh(int sec_sid, int target_sec_sid) "cmdq_sec_sid=%d target_sec_sid=%d"
>  smmuv3_cmdq_tlbi_nh_asid(int sec_sid, int asid) "sec_sid=%d asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 8e971c28093..a21c6061808 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -269,6 +269,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
>  SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_all(SMMUState *s);
> +void smmu_iotlb_inv_by_sec_sid(SMMUState *s, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
>                                SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid);
> @@ -280,7 +281,12 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                          uint64_t num_pages, uint8_t ttl,
>                          SMMUSecSID sec_sid);
>  void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
> +void smmu_configs_inv_sid_range_by_sec_sid(SMMUState *s,
> +                                           SMMUSIDRange sid_range,
> +                                           SMMUSecSID sec_sid);
>  void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
> +void smmu_configs_inv_sdev_by_sec_sid(SMMUState *s, SMMUDevice *sdev,
> +                                      SMMUSecSID sec_sid);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
>  


