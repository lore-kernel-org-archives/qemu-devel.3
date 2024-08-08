Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 18:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7sH-00085s-2Y; Thu, 08 Aug 2024 14:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sc7sF-0007pN-Uv
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:28:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sc7sD-0001OD-LK
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:28:31 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso1067971b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723141707; x=1723746507; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x/eKB9adD5vtAdH+AHSGnKrabRcrcGFa4QNQ7bMcvU8=;
 b=XfK1FiXJzWCZ0/9FVSiCCKnkLbS2bTlguIbCZJ3dGDXv1yqZFZI/qjhMZwKKYIg4/r
 VifmvIrt1UeheRqCM+WPLx4S12rdxygJMk84/1Y9exqPtaJ6fVukMi9//S1yGN0LMFQi
 16dE7wgpLxvkZEFbTGuionsgtmccuE79hNJt+3QWKSGAT/NzUycQHVIVnfbeD4BWhpOx
 0El0nDhqBhTWseesnF6XQC4O0TIv2qxJvIogbt1NSBxH+lz9VGnY2IlzJ3b43DsbrluB
 QhnYsVjxunuzL3tJvGTs5CsmRzG4qpTXdWZJvYW+QsyBVl0I4ZrkEsp/lyOt4uMKOqS7
 RbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723141707; x=1723746507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/eKB9adD5vtAdH+AHSGnKrabRcrcGFa4QNQ7bMcvU8=;
 b=XC+qeqV6rI0K1bDZZruEnZ+EACvBGfUKqJ53xQhst1PGscmuAz0G83sEt3ZeRnOpre
 3TzxBc8bFvcXzl+YO/kvMmf2znBHF0K41j40oROhamevibLH4DlPo/580lqBm1m5Fi57
 i++VthBqkHGsZhPPfgOIs9oiGU4fzBOZfVQGdh6qXjX5qcscBX8eA+Kq9c//qCSPsafG
 Idv03qbaMk/o/fjrPGVOBYdiMFAeIv0gi9QTJnB3einq6Drje7wPVRMff2QBstmKa0zs
 QfyYFGuw5hUU3mn8jW/CzcJyHUYIIwtEImaxJsB8Vk57wEUgS7tLDFR9eRggBy5MMPGr
 kqBQ==
X-Gm-Message-State: AOJu0YxYyZ5JgNTS0fHkzSVxrBBjVmB3vunw1GGKTVLA6l/CI55rjmjq
 pbqFhC9INK36gmWyqXbALwzm/3Lq4MqFFOge5dFenlt0UyY/8WIl
X-Google-Smtp-Source: AGHT+IHhCjRuTNDogtGzrIlZwTbvqVxHATIyO9zKjrlxrDbVkksTgDVka1CaxP0T7jfYts3GQuVkZQ==
X-Received: by 2002:a05:6a20:4313:b0:1c3:3436:a244 with SMTP id
 adf61e73a8af0-1c6fceb871emr3559685637.1.1723141706780; 
 Thu, 08 Aug 2024 11:28:26 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:ba5b:a13:cdb6:fb15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb2d0355sm1408586b3a.118.2024.08.08.11.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 11:28:26 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 8 Aug 2024 11:28:05 -0700
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-mm@kvack.org,
 dan.j.williams@intel.com, vishal.l.verma@intel.com,
 Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
 bp@alien8.de, dave.jiang@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, james.morse@arm.com, linmiaohe@huawei.com,
 mchehab@kernel.org, nao.horiguchi@gmail.com, rric@kernel.org,
 tony.luck@intel.com
Subject: Re: [PATCH v4 1/2] cxl/core: introduce device reporting poison
 hanlding
Message-ID: <ZrUONRvQf4M6CNCh@fan>
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
 <20240808151328.707869-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808151328.707869-2-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42a.google.com
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

On Thu, Aug 08, 2024 at 11:13:27PM +0800, Shiyang Ruan wrote:
> CXL device can find&report memory problems, even before MCE is detected
> by CPU.  AFAIK, the current kernel only traces POISON error event
> from FW-First/OS-First path, but it doesn't handle them, neither
> notify processes who are using the POISON page like MCE does.
> 
> Thus, user have to read logs from trace and find out which device
> reported the error and which applications are affected.  That is not
> an easy work and cannot be handled in time.  Thus, it is needed to add
> the feature to make the work done automatically and quickly.  Once CXL
> device reports the POISON error (via FW-First/OS-First), kernel
> handles it immediately, similar to the flow when a MCE is triggered.
> 
> The current call trace of error reporting&handling looks like this:
> ```
> 1.  MCE (interrupt #18, while CPU consuming POISON)
>      -> do_machine_check()
>        -> mce_log()
>          -> notify chain (x86_mce_decoder_chain)
>            -> memory_failure()
> 
> 2.a FW-First (optional, CXL device proactively find&report)
>      -> CXL device -> Firmware
>        -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
>                                                   \-> memory_failure()
>                                                       ^----- ADD
> 2.b OS-First (optional, CXL device proactively find&report)
>      -> CXL device -> MSI
>        -> OS: CXL driver -> trace
>                         \-> memory_failure()
>                             ^------------------------------- ADD
> ```
> This patch adds calling memory_failure() while CXL device reporting
> error is received, marked as "ADD" in figure above.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c   | 75 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxlmem.h      |  8 ++---
>  drivers/cxl/pci.c         |  4 +--
>  include/linux/cxl-event.h | 16 ++++++++-
>  4 files changed, 83 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e5cdeafdf76e..0cb6ef2e6600 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -849,10 +849,55 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +static void cxl_report_poison(struct cxl_memdev *cxlmd, u64 hpa)
> +{
> +	unsigned long pfn = PHYS_PFN(hpa);
> +
> +	memory_failure_queue(pfn, 0);
> +}
> +
> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
> +					   enum cxl_event_log_type type,
> +					   u64 hpa,
> +					   struct cxl_event_gen_media *rec)
> +{
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->media_hdr.transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_report_poison(cxlmd, hpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
> +				  enum cxl_event_log_type type,
> +				  u64 hpa,
> +				  struct cxl_event_dram *rec)
> +{
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->media_hdr.transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_report_poison(cxlmd, hpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt)
>  {
>  	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> @@ -880,18 +925,22 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>  
> -		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						&evt->gen_media);
> -		else if (event_type == CXL_CPER_EVENT_DRAM)
> +			cxl_event_handle_general_media(cxlmd, type, hpa,
> +						&evt->gen_media);
> +		} else if (event_type == CXL_CPER_EVENT_DRAM) {
>  			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			cxl_event_handle_dram(cxlmd, type, hpa, &evt->dram);

Does it make sense to call the trace function in
cxl_event_handle_dram/general_media and replace the trace function with
the handle_* here?

> +		}
>  	}
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>  
> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				     enum cxl_event_log_type type,
> -				     struct cxl_event_record_raw *record)
> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +				      enum cxl_event_log_type type,
> +				      struct cxl_event_record_raw *record)
>  {
>  	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>  	const uuid_t *uuid = &record->id;
> @@ -903,7 +952,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>  
> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -1012,8 +1061,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			__cxl_event_trace_record(cxlmd, type,
> -						 &payload->records[i]);
> +			__cxl_event_handle_record(cxlmd, type,
> +						  &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..5c4810dcbdeb 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -826,10 +826,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt);
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..6e65ca89f666 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1029,8 +1029,8 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
>  	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
>  
> -	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
> -			       &uuid_null, &rec->event);
> +	cxl_event_handle_record(cxlds->cxlmd, log_type, ev_type,
> +				&uuid_null, &rec->event);
>  }
>  
>  static void cxl_cper_work_fn(struct work_struct *work)
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 0bea1afbd747..be4342a2b597 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -7,6 +7,20 @@
>  #include <linux/uuid.h>
>  #include <linux/workqueue_types.h>
>  
> +/*
> + * Event transaction type
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43

Here and below, update the specification reference to reflect cxl 3.1.

Fan
> + */
> +enum cxl_event_transaction_type {
> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
> +	CXL_EVENT_TRANSACTION_READ,
> +	CXL_EVENT_TRANSACTION_WRITE,
> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
> +};
> +
>  /*
>   * Common Event Record Format
>   * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> @@ -26,7 +40,7 @@ struct cxl_event_media_hdr {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	/*
>  	 * The meaning of Validity Flags from bit 2 is
>  	 * different across DRAM and General Media records
> -- 
> 2.34.1
> 

