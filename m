Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D3CC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 07:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQPb-0006wk-Tp; Fri, 23 Feb 2024 02:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQPN-0006uq-Hc
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:55:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQPJ-0007KH-Hj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708674943;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4sW0aiPjJulNrompNL+OtLsCAVloXR4kmWd65dr4zg=;
 b=BSNVVlmgSJ+yvWJHD6/fOhI6g0IqZVxMigFglyUcUtVCv9lzeHFPLowjF7l9hbh5jckfK7
 PJKDRc0f4IrrnqeSyfSe0DsHx1x7Zh4kjz8FNZDixeNCDAAM2e8+3MJFmvcYqVmXnpDOdQ
 iUCXPZFMG0HwqQNsYEfh2mvCIVI+tps=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-9-YImatsP5SoOslEs8FQHw-1; Fri, 23 Feb 2024 02:55:41 -0500
X-MC-Unique: 9-YImatsP5SoOslEs8FQHw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcc4563611cso938462276.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 23:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708674941; x=1709279741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m4sW0aiPjJulNrompNL+OtLsCAVloXR4kmWd65dr4zg=;
 b=lTBOxo+gekxYc1E0ZwzwPynTr089BsRr2C1emTQpymgJK4wavB0iJj6w27mXLLFCWb
 RwxBdM/6WVM5PUHqkw+2Nby5fdsLZweyz4cRe8IQFn20Np+tl4vQtlssPP+XwzCCzadi
 9yySgjqsueeeFj5Lr0l+zYQ95v1igGStaqfI5sjUDhLzEzfFmpEuHZ1JGvniJcghLIxF
 DK8oVUz1CiPTkx0UsXuXqYidNdYIMypJU1aTcRtoJ5fxetziJ9P3Vi1E7b91N+pYcCFM
 phup2Tx9NrbLd4JD/uFwNj4s5WF74B4CE0krEO2QhXQNQuzvttcn7wvMCqSFLm8MZVp+
 xczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy39Rk5fLXrMbjqfCYFeOzMccIv35lIvq12UsXoHC/JER+NjwOKGYds5H7dkOOU44yMB8PAz93yQYUJYPEw04UG0cnCic=
X-Gm-Message-State: AOJu0YwmD0cexEDlgVfS59a5UgsYpFeqklPzkETSWywyAEWTvzWL0FSO
 HYw4KhpHXGzhN25pMTSJ68aaieNtxsnAOls3XXLbpRZZqZEX1Jafq1xwU0WXmhnosn8REDuBVpR
 xiSYSfbS02QwSjQBaA8BpSR1VDp5/PGfJy4c5q7WRAU+WQaOidLJR
X-Received: by 2002:a25:2f0c:0:b0:dca:e4fd:b6d5 with SMTP id
 v12-20020a252f0c000000b00dcae4fdb6d5mr1448884ybv.27.1708674941102; 
 Thu, 22 Feb 2024 23:55:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFArKMI8tDgnWjzrBY1jU2OLY7hI/4WXcKsaxQRPiOvQt3BWs8sG1Iez/ztymfOTiRslwgxhg==
X-Received: by 2002:a25:2f0c:0:b0:dca:e4fd:b6d5 with SMTP id
 v12-20020a252f0c000000b00dcae4fdb6d5mr1448871ybv.27.1708674940794; 
 Thu, 22 Feb 2024 23:55:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 j9-20020ac806c9000000b0042e2eb24b42sm2921772qth.22.2024.02.22.23.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 23:55:40 -0800 (PST)
Message-ID: <25ce0183-3c08-4ead-a5d9-36dcd0879c4e@redhat.com>
Date: Fri, 23 Feb 2024 08:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/smmuv3: Check StreamIDs against
 SMMU_IDR1.SIDSIZE value
Content-Language: en-US
To: Nabih Estefan <nabihestefan@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com
References: <20240221171716.1260192-1-nabihestefan@google.com>
 <20240221171716.1260192-2-nabihestefan@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240221171716.1260192-2-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 2/21/24 18:17, Nabih Estefan wrote:
> From: Roque Arcudia Hernandez <roqueh@google.com>
>
> Current implementation checks the StreamIDs against STRTAB_BASE_CFG.LOG2SIZE
> register field value and a constant SMMU_IDR1_SIDSIZE which is also used as
> initial value for field SMMU_IDR1.SIDSIZE.
>
> This limits the possibility of extending the SMMUv3 by inheritance and
> redefining the value of SMMU_IDR1.SIDSIZE because the check is hardcoded to the
> constant SMMU_IDR1_SIDSIZE rather than the register value.
>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/smmuv3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9eb56a70f3..a01031821a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -580,15 +580,17 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
> +    uint32_t idr1_sidsize;
>      int strtab_size_shift;
>      int ret;
>  
>      trace_smmuv3_find_ste(sid, s->features, s->sid_split);
>      log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
> +    idr1_sidsize = FIELD_EX32(s->idr[1], IDR1, SIDSIZE);
>      /*
>       * Check SID range against both guest-configured and implementation limits
>       */
> -    if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
> +    if (sid >= (1 << MIN(log2size, idr1_sidsize))) {
>          event->type = SMMU_EVT_C_BAD_STREAMID;
>          return -EINVAL;
>      }


