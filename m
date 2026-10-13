Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8ECCA9EC5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGQoM-0002Xe-V7; Mon, 12 Oct 2026 20:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGQoJ-0002XS-L1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 20:56:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGQoI-0004Qu-0Q
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 20:56:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso4599555ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 17:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791852964; x=1792457764; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0NOCsbIctm65OS3plBn+ITXOKx+ioxFWMbzikj4ZRDg=;
 b=QbOETQ5RZ+0JLWZFDhoz/eqSxVJlehBxNXBVV4q5Femtze1jGzTyxW/DAouNmDrsIv
 a+YyejkAvC3LbIfqpaDLFeS1mYXNCljBZAPXVbmaqDUFrc9esammeKa9rpv5hgMRMw+X
 vLebnKXjhlum3cAKo4pAFq74e7aoUUxejii/hTYHe7K2G9pteaBq759aDRjnyIAE9iNO
 0fgIau9QgYmMQlazR6PdY/zI6xdft6FAgoWk15f3HQJ38b+pFEDeXhZM/1qqF+LsR3d/
 z5ekAfqzXUuT0tNQs96BsrUwkAgkOdMIKZQWx/zx4UBzcjktFEIsKOqCkSl+dmOrxJwz
 f0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791852964; x=1792457764;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0NOCsbIctm65OS3plBn+ITXOKx+ioxFWMbzikj4ZRDg=;
 b=s/+pVG7ahrahh3zyMQAnfs+fv8TdVAQTs8vPgJ0OddG8yHpjfv6d8h0qVevjp9UajL
 kEQZupTTrfjM7sK+XzntNhxGVTxhB4/5mzxxhPDDhtRcop3ga34DH8fhpKnDzUXoRiQj
 V+tQo4XgvFCeXT+x9jEu58OfkHoY7ykoaG4gCGuPetLuThe+oTHzc47RPbfCVsX8lctI
 ZeZUXpPn6FHxmy4ymThmCEzWZDG43GbGDS3fPhKid5AYM4k8kjMpXEzSAyvjIyJXWBvX
 Ygsp6VIBWXFsHN750GbTXQHbptO9Pr8mCEFP9KVElbr3XwSMCwAUpilG7llHuPrUErj7
 1qBQ==
X-Gm-Message-State: AFq9FYKZ/91lDBk+IErJsuT4/DmXISWgm+3V78JnSllIgZENjvd6gnKU
 l49ppLvGoe0MHPxM+RcIoEGqjSepMK6dtwAyEu1tqs3KiXO1XvRr1WRRUtw6rw==
X-Gm-Gg: AYBFou0lcgQ2PpQQiLFqVGTmRsjJTgn5EvdGKOwI2WnHxJ6Az92B03WvOw3750SkIbP
 +yKjxqQLRuBWu0igDBQ2NdMIJDVJdBN3E3l0lwVGFE2ZufB8if1vIekkKJMNFFYE/ELQF8J/8Yf
 T7IlRXRhIo/LMHeFk0tQxG9abpeYQC6sYSai5DZ1Ok/9Vn5lXJiESVYCZGTtEutKgiiUpJQ+p0I
 2SKUCQeb8q3ty16IuWl9hjhnQnTtJSUBJjTzqbw/DSxWtIDz+wzvqab4OGfLMDp258ooXI1sqb+
 tCp/Wf97MTebrJY0oJ3qSH3rsERI0E8T1joYGC03WZ+RK/dBZbQj8VYsf0V1AOGJwibuz7sCXNy
 xTzqNn3erzqyYCXH/8kTAT0Jo7oc7hoxjKOrDgXkCJA+0TWRJ40/OAEdBKpZ+C42u+7JexbrMmf
 rhoBeXafiZSXAJ559MiRTiBz4GOZTctv771eYg5p58LZT4PviUmgJg8HcorJWdM7sVwXWItdYSA
 Q==
X-Received: by 2002:a17:903:22ce:b0:2e8:2234:72fa with SMTP id
 d9443c01a7336-2e842ab5f95mr94919485ad.21.1791852964306; 
 Mon, 12 Oct 2026 17:56:04 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2570sm50070735ad.79.2026.10.12.17.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 17:56:03 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] hw/ufs: Add support for REPORT_LUNS SCSI command
 for Well Known LUNs
To: qemu-devel@nongnu.org, dridiha98@gmail.com
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com, 
 dridiha <dridiha98@gmail.com>, j-young.choi@samsung.com
In-Reply-To: <20261012145320.391400-1-dridiha98@gmail.com>
References: <20261004125305.99878-1-dridiha98@gmail.com>
 <20261012145320.391400-1-dridiha98@gmail.com>
Date: Tue, 13 Oct 2026 09:55:51 +0900
Message-Id: <179185295196.221765.16834462474900342112.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> According to the UFS specification, the REPORT_LUNS SCSI command can query
> Well Known LUNs by setting CDB[2] to 0x01 (select Well Known LUNs) or 0x02
> (select all LUNs).
> 
> Currently, the UFS emulation layer lacks handling for these CDB[2] select
> report values, causing command failures when guests attempt to report Well
> Known LUNs.
> 
> This patch adds support for handling CDB[2] values 0x01 and 0x02 in the
> REPORT_LUNS command, returning the appropriate Well Known LUN descriptors
> in the SCSI response payload.
> 
> Signed-off-by: Hamza Dridi <dridiha98@gmail.com>
> ---
> v1 -> v2:
> - Cleard the UPIU WLUN-ID before writing the Wlun byte.
> 
>  hw/ufs/lu.c         | 44 ++++++++++++++++++++++++++++++++++----------
>  include/block/ufs.h |  3 +++
>  2 files changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index bdb1650851..4f1f4f265f 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -211,33 +211,57 @@ static const struct SCSIBusInfo ufs_scsi_info = {
>      .cancel = ufs_scsi_command_cancelled,
>  };
>  
> +static bool ufs_append_lun(uint8_t *outbuf, uint32_t outbuf_len, int *len,
> +                           uint8_t lun, uint8_t lun_msb)
> +{
> +    if (*len + 8 > outbuf_len) {
> +        return false;
> +    }
> +
> +    memset(outbuf + *len, 0, 8);
> +    outbuf[*len] = lun_msb;
> +    outbuf[*len + 1] = lun;
> +    *len += 8;
> +
> +    return true;
> +}
> +
>  static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
>                                     uint32_t outbuf_len)
>  {
>      UfsHc *u = req->hc;
>      int len = 0;
>  
> -    /* TODO: Support for cases where SELECT REPORT is 1 and 2 */
> -    if (req->req_upiu.sc.cdb[2] != 0) {
> +    uint8_t report_lun_cmd = req->req_upiu.sc.cdb[2];
> +
> +    if (report_lun_cmd > 2) {
>          return SCSI_COMMAND_FAIL;
>      }
>  
>      if (outbuf_len < 8) {
>          return SCSI_COMMAND_FAIL;
>      }
> +
>      memset(outbuf, 0, 8);
>      len += 8;
>  
> -    for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
> -        if (u->lus[lun]) {
> -            if (len + 8 > outbuf_len) {
> +    if (report_lun_cmd == 2 || report_lun_cmd == 1) {
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->report_wlu.lun & 0x7F,
> +                       UFS_WLUN_MSB);
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->dev_wlu.lun & 0x7F,
> +                       UFS_WLUN_MSB);
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->boot_wlu.lun & 0x7F,
> +                       UFS_WLUN_MSB);
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->rpmb_wlu.lun & 0x7F,
> +                       UFS_WLUN_MSB);
> +    }
> +
> +    if (report_lun_cmd == 0 || report_lun_cmd == 2) {
> +        for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
> +            if (u->lus[lun] &&
> +                !ufs_append_lun(outbuf, outbuf_len, &len, lun, 0)) {
>                  break;
>              }
> -
> -            memset(outbuf + len, 0, 8);
> -            outbuf[len] = 0;
> -            outbuf[len + 1] = lun;
> -            len += 8;
>          }
>      }
>  
> diff --git a/include/block/ufs.h b/include/block/ufs.h
> index d19b3c65ef..9d5ec4c77f 100644
> --- a/include/block/ufs.h
> +++ b/include/block/ufs.h
> @@ -818,6 +818,9 @@ typedef struct QEMU_PACKED UtpTaskReqDesc {
>   */
>  #define UFS_EHS_OFFSET_IN_RESPONSE 32
>  
> +/* Most significant byte in the Report Lun response for Well Known LU */
> +#define UFS_WLUN_MSB 0xC1
> +
>  /* Well known logical unit id in LUN field of UPIU */
>  enum {
>      UFS_UPIU_REPORT_LUNS_WLUN = 0x81,

Thank you for your contribution.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

