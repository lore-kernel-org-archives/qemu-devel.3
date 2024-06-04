Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA1C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU0R-0007NC-Jj; Tue, 04 Jun 2024 09:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEU0Q-0007Mu-G1
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEU0N-0006aa-Lw
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717506910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1QnxpcnqZoff3m+x0fvjD7H3C7n4tPU30jZRp1eW8o=;
 b=Xv9wknKKgUqN0ZDcH5g/6CS3VU3sAoQCKYEapBi+bIeSHzyKtMNvEV9iFgyZuVmq1xdjLR
 0cs/niptxMOlhBGhChB9A6LJqkVHUGs6e+P75b2gwPzdG9YtDFn0vBk/sy10CElH16LtKn
 Wkb2RYlyWSZRcEHmMmjM4rhj9gcC5zA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-LcsIwTcuMkKH6-Q0Xsjq-Q-1; Tue, 04 Jun 2024 09:15:08 -0400
X-MC-Unique: LcsIwTcuMkKH6-Q0Xsjq-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e114d0befso791853f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717506907; x=1718111707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1QnxpcnqZoff3m+x0fvjD7H3C7n4tPU30jZRp1eW8o=;
 b=F3mvs6Cn+JF25cvOKDbLIVU5ouTb7jNSyrwFSJoyv5sinYc2mdWHzLDkxP0qAos7om
 mfE1q4um/C98r/2BOFkNQpsxTDHo82zfzFSsDsmOqXOWIJKgAKGO48y/rlrfBAvq+LAy
 0r4Aa1/DM6E0psvwrrulZ7DFcFNvBlHLFfyqe2W55NupCGWCfX0O7RQJzi2920jaZ8/9
 6W21znbdB5ulv6bPyO+KkQoFkichtHKJwm4Fkunn0zt8pmkTxYkk4oXanmRAPDkptGid
 3CqVljioR+WNupYhyDyiI4wnOFtpMNJF4/gi8PLXIViHoNXcCmSIdjEwbR8pggji+mzR
 Fehw==
X-Gm-Message-State: AOJu0YxPMD+Ei/p77hPs3I3yT/QhKlUfQbODxcKHbWEyqLXLduFttwqv
 +GF5l1rfmG8QyKIML/uMyMhFMlVx10+iu3EzHUmTxOwI/eIxST3DZ2uI635zfjeqlMValxlu0Ng
 W7lEyDNc1DssLz5Df2GqOyPCM7IHVi3vsd40VXxK1ytAsuzF3lw6HM1CZJDd/Wu6iQTgYddSuzP
 vdvQTXfkud3UYYg6K9aV069wbHxS4HnA==
X-Received: by 2002:a05:6000:1b09:b0:357:ca29:f1ca with SMTP id
 ffacd0b85a97d-35e0f2869c8mr9150934f8f.32.1717506907001; 
 Tue, 04 Jun 2024 06:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/zAR84qLgfVZkP/xjqSOodXOIDh00BUI7wX3NYG+FR4F++0m9k4xxI58Ju1KwzaNlZX2Z8g==
X-Received: by 2002:a05:6000:1b09:b0:357:ca29:f1ca with SMTP id
 ffacd0b85a97d-35e0f2869c8mr9150903f8f.32.1717506906413; 
 Tue, 04 Jun 2024 06:15:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d94f1sm11447735f8f.49.2024.06.04.06.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 06:15:05 -0700 (PDT)
Date: Tue, 4 Jun 2024 09:15:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 25/53] hw/cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <20240604091451-mutt-send-email-mst@kernel.org>
References: <cover.1717506831.git.mst@redhat.com>
 <2010f46e48229ec29146c4941768db61fd21fa76.1717506831.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2010f46e48229ec29146c4941768db61fd21fa76.1717506831.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 04, 2024 at 09:13:26AM -0400, Michael S. Tsirkin wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> This enables wrapper devices to customize the base device's CCI
> (for example, with custom commands outside the specification)
> without the need to change the base device.
> 
> The also enabled the base device to dispatch those commands without
> requiring additional driver support.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> --
> Heavily edited by Jonathan Cameron to increase code reuse
> Message-Id: <20240523174651.1089554-3-nifan.cxl@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/cxl/cxl_device.h |  2 ++
>  hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ccc4611875..a5f8e25020 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -301,6 +301,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max);
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> +                          size_t payload_max);
>  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>                              size_t len_in, uint8_t *pl_in,
>                              size_t *len_out, uint8_t *pl_out,
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2c9f50f0f9..4bcd727f4c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1424,9 +1424,9 @@ static void bg_timercb(void *opaque)
>      }
>  }
>  
> -void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> +static void cxl_rebuild_cel(CXLCCI *cci)
>  {
> -    cci->payload_max = payload_max;
> +    cci->cel_size = 0; /* Reset for a fresh build */
>      for (int set = 0; set < 256; set++) {
>          for (int cmd = 0; cmd < 256; cmd++) {
>              if (cci->cxl_cmd_set[set][cmd].handler) {
> @@ -1440,6 +1440,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>              }
>          }
>      }
> +}
> +
> +void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> +{
> +    cci->payload_max = payload_max;
> +    cxl_rebuild_cel(cci);
> +
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
>      cci->bg.runtime = 0;
> @@ -1458,6 +1465,14 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
>      }
>  }
>  
> +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> +                                 size_t payload_max)
> +{
> +    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;

Line too long.


> +    cxl_copy_cci_commands(cci, cxl_cmd_set);
> +    cxl_rebuild_cel(cci);
> +}
> +
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max)
>  {
> -- 
> MST


