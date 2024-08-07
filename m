Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB62C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbn1l-0004cQ-69; Wed, 07 Aug 2024 16:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbn1j-0004Wa-Hk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:12:55 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbn1h-0005DP-O6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:12:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-530e2548dfdso219943e87.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723061572; x=1723666372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sUphRq2H53HPjz0qM3t4QIDlWYj7A2HgTL1DZr/MkiU=;
 b=qqy7ahaFdO4sXB02xUC9ZVnDluAKzU+kxZOdWXFiFq0DdjArfqdsznxsTs7mV2y4AF
 3KMHpRl0HCp6VUQ0KDcfsCPp2/VVCJ7dFcJ4Kye9lme57LSBsVjO1dDQ5eTRqhkRpCph
 2wBAC/nDjxQPVZCOzoUIGnD1p4ip3skyxT3D8IK1fdQPcf3MzAK9x6+WQNe62rca8g69
 9P39vpdoiEANKyay5SA3UpZ9kKmzbXIqZQpzt2f4Kg1j4IO0wlxBfNnnZ13IVcT0UhQz
 38EW4ohnoGCtt/cFt457KmOWaMX72vPQ1KTrIXzcdVjJJvEBkAuVLQGZca3TqwIkViYE
 jS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723061572; x=1723666372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sUphRq2H53HPjz0qM3t4QIDlWYj7A2HgTL1DZr/MkiU=;
 b=fCmAE5ZKwI8mI/emmZpnj/7e43sLKZTOTbH/uHf/XRviVbwEYpJNyTt2mWI1qUNMEV
 fjGN5S0hF5ATwC4VqUKWrA0GsK1o3+KMUFqWGGVT2EWY7Uex8FMT3S20DsoRX3mcHwZZ
 05wtsTPnGC85c90W2cvtYP+yautGPdL80sKzFfDdDiOcB6D55wKzMjZuqrmvy4SGEFKd
 wlElojJeoCgsCFAgE/PLc2YLOLDghLD1gMpxJKFFAtpTpb80tZmGFyryi6BSXtnTvRWE
 Ip023AmtI9rPtqP83QhkHLzOvnYZygaSNL1Hsp0R8A2neceZFkricv+XGcjNQgP6rmiN
 jO7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9vnBndO0oSamIx3CCNg57gi1e5JzPE2vNTomMXzaNtCoVk1tiLBpiJiWHyNtlSGZ/gFkpnTyIACXHB0eihq2eXWEdOws=
X-Gm-Message-State: AOJu0Yw7/3o1rCYdxa6zuPwpFP0dBxhM8/BGQ8LprqqXjhStDE7+GXES
 yK5ouAqivatWQ8wQU0obn6FsDUTjccMuZ3zpogbh1/6e1Bkl0QnCFbweE3dw2Dw=
X-Google-Smtp-Source: AGHT+IG00HXytbVVBCXXk08lU23VIhKxYGvkOlD8bQT7LNrY0xR18D1iBYfJOe69II+kN30K0oqowA==
X-Received: by 2002:a05:6512:3092:b0:52f:c2ef:a76a with SMTP id
 2adb3069b0e04-530bb391c30mr12340867e87.18.1723061571479; 
 Wed, 07 Aug 2024 13:12:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d1d66589asm325802f8f.11.2024.08.07.13.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 13:12:51 -0700 (PDT)
Message-ID: <e3e60776-3f63-4024-a595-2989a59e15ed@linaro.org>
Date: Wed, 7 Aug 2024 22:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Fixes: Coverity CID 1558831
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, clg@kaod.org,
 chalapathi.v@ibm.com, saif.abrar@linux.ibm.com, dantan@us.ibm.com
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
 <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Back at this patch since Cédric asked me to look at it.

On 6/8/24 15:48, Chalapathi V wrote:
> In this commit the following coverity scan defect has been fixed
> CID 1558831:  Resource leaks  (RESOURCE_LEAK)
>    Variable "rsp_payload" going out of scope leaks the storage it
>    points to.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   hw/ssi/pnv_spi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index a33f682897..dbe06df224 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -237,6 +237,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>       }
>       if (rsp_payload != NULL) {
>           spi_response(s, s->N1_bits, rsp_payload);
> +        pnv_spi_xfer_buffer_free(rsp_payload);
>       }
>   }
>   

Or bigger patch but simpler logic:

-- >8 --
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index c1297ab733..aaedba84af 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -217,6 +217,9 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
      PnvXferBuffer *rsp_payload = NULL;

      rsp_payload = pnv_spi_xfer_buffer_new();
+    if (!rsp_payload) {
+        return;
+    }
      for (int offset = 0; offset < payload->len; offset += 
s->transfer_len) {
          tx = 0;
          for (int i = 0; i < s->transfer_len; i++) {
@@ -235,9 +238,8 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
                      (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
          }
      }
-    if (rsp_payload != NULL) {
-        spi_response(s, s->N1_bits, rsp_payload);
-    }
+    spi_response(s, s->N1_bits, rsp_payload);
+    pnv_spi_xfer_buffer_free(rsp_payload);
  }

---

I note few things is odd here:

1/ pnv_spi_xfer_buffer_new() uses the GLib g_malloc0() call
    while pnv_spi_xfer_buffer_free() uses plan free().

2/ pnv_spi_xfer_buffer_free() frees payload->data so doesn't
    match pnv_spi_xfer_buffer_new().

This is a bit disappointing.


