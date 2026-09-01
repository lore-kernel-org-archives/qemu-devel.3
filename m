Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6616FC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1MTJ-0001BS-G4; Tue, 01 Sep 2026 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x1MTH-0001Av-Is
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x1MTF-0004bZ-C9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788261364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQKSjJTPQskA7io2JJN0NbQycYKMCQt8QD3vsqH6gbI=;
 b=Oo0Gx63Can7duXJoflHBtPRAW+9jQXsjQ+xMyG2/PDF/AlPehsiFp0Otobope2vyFYHkWQ
 WTe+0HeKYmkANCeB6FBNSpB4iJ9UhYfXxdiGCGMtdts4xwzLXpI52y5rOVRpQ6jgfu8gia
 zHxlfYuu3hCsQkyo1DfnEDUa7a8YnRk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-1FuklBQAPuW6oBTM3luIVg-1; Tue,
 01 Sept 2026 07:16:00 -0400
X-MC-Unique: 1FuklBQAPuW6oBTM3luIVg-1
X-Mimecast-MFC-AGG-ID: 1FuklBQAPuW6oBTM3luIVg_1788261359
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EDDF19560BC; Tue,  1 Sep 2026 11:15:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC5321955F7C; Tue,  1 Sep 2026 11:15:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 01/21] target/i386: Remove const qualifier in
 ptw_setl*()
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
In-Reply-To: <20260901095229.72018-2-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-2-philmd@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 15:15:55 +0400
Message-Id: <178826135506.50872.3543134957639273965.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rHu1/SkGiqm0RzKOkqwoqr24eYr54zzKBb2IEhJTfwg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqlrPrSGOcK3d3W9LPtmHHe7kyrDTiFR3lscotx
 UQnWf8HqtyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapaz6wAKCRDa6OEJdZac
 5XwdD/478VmbsptG+QI85QggIAzJO991qieer5c9D1EqyiMmAbtXKbBNoFzzv69VQzrZvGXPp0l
 a2TdJRWGuENt2vN+s6WlxhOGhPkT143ZStDtNSspB3z1zO0h95EysmI4bGg1x3OIWk+dIr029pO
 4XHx1+QbxbBlkqCj5dY5vS2rK3RidSZcLn7/zMzIoyI4vx5EtX03sR4UNA1OnYVe/jI8q04xgb/
 /wVHkQUb2lhvNjPWcAwahMQdTnoy6OaEWD52FeMangGcAtHYdaoxdAl8vLNkErn+VMRwAsKYa+X
 tq/Mf/ARrsVo/sWuqSIL/JQ+kW3rq6sS65/fCPsFpvmLnYTDN0Cr/gTcehVnxJj7Q73SmE8gDQy
 HninaGayTCMuuAdosK+S3Uq26bEEPXR9qtnL1eP7dug/ZMcFYn/igcXFk1V3lOwDy2UnA/uMERu
 lagtr+pnzUmN4b2rCsVBGfuIk+LwnEm2AGCNo4YsCvNf/Jhop2NAuiKSRp3bW44zuR1GhHUMoyY
 GQ051to+QpAsYr72uE+iDeX1czReqTFzA0p/XWo9auvU7xE03UDEBKqjKnHovH9YJh5/YeAh9yX
 qP9gsQ+IWcNRymHqWIfoStCZICyXng76xCvCPhr1OoSzOIgpC/OQlOPcbd0WfuTnVNWt0z7Vk+a
 OxEbbcRfas1AgZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-09-01 11:52 +0200, Philippe Mathieu-Daudé wrote:
> Both cpu_exec_start() and cpu_exec_end() take a non-const CPUState
> argument, however here we get that argument via PTETranslate::env
> so @in->env can not be const. Remove the const qualifier.
> 
> Fixes: 4a1e9d4d11c ("target/i386: Use atomic ops for pte updates")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

I think this is not really a fix, but more like a style/contract thing
anyway:
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

> ---
>  target/i386/tcg/system/excp_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
> index d7ea77c8558..44be98a3c92 100644
> --- a/target/i386/tcg/system/excp_helper.c
> +++ b/target/i386/tcg/system/excp_helper.c
> @@ -106,7 +106,7 @@ static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
>   * even 64-bit ones, because PG_PRESENT_MASK, PG_ACCESSED_MASK and
>   * PG_DIRTY_MASK are all in the low 32 bits.
>   */
> -static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
> +static bool ptw_setl_slow(PTETranslate *in, uint32_t old, uint32_t new)
>  {
>      uint32_t cmp;
>  
> @@ -125,7 +125,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>      return cmp == old;
>  }
>  
> -static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
> +static inline bool ptw_setl(PTETranslate *in, uint32_t old, uint32_t set)
>  {
>      if (set & ~old) {
>          uint32_t new = old | set;
> -- 
> 2.53.0
> 
> 
> 



