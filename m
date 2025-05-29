Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2117C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgQe-0007Od-Jw; Thu, 29 May 2025 12:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgQZ-0007Lq-1F
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgQW-0007Mx-S3
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748537299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6PXlW96cqfluK5eXdOKFmAmXMsEFrPEnWd/cA06kMQ=;
 b=FwUS68n9Pnl4eTjzCugxkJjFAH9Et3pOpKbfm05eeM+rEz5kSdOGtUfcKPp1lfQTjhcbVV
 VF5LeTgskF6QEA//uQcM1W3MFTRBCcIZs2lkQ/684Bbk+i2h/XP1yrKRnCK6o37lE5ILPR
 Z2naMEELr5wkQ7AGn7gIMYfw1V15xJY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-DqquQBalN_KsNnEcZIWMXQ-1; Thu, 29 May 2025 12:48:18 -0400
X-MC-Unique: DqquQBalN_KsNnEcZIWMXQ-1
X-Mimecast-MFC-AGG-ID: DqquQBalN_KsNnEcZIWMXQ_1748537297
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ea7e46dfso514457f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748537297; x=1749142097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6PXlW96cqfluK5eXdOKFmAmXMsEFrPEnWd/cA06kMQ=;
 b=QP18EZRFmXIMAo5y5FZVHFX0u7uKlX1WI+uXs+rjyCVCQ+5ZDoPCK+eUF9GOSTh8Re
 uRSh+nc2r9Ssh3FYKyNMZ55xeFXs615WXcweWUZxHqGPwmkYEExxXMUE0wdAqiwyEXHS
 EQmzps/CEhP80S7ojrwpPGScW+4wvkBcREkXLG1lRjt2eH2Sr8moUq2Co/YV2SDK9LOB
 iS4Whr3STO+KFuOkZmKtFsIGus4tRo7JQHCIM6iadqna1LJeVjwD+2ziESqc7rUZaBGn
 l3gkxR6DEiDYwDxIch4+q9/mr9z/qZTAOaDDzsMecgiu0Ga0iphNaVbcVmJkKe+w5wj6
 2sOw==
X-Gm-Message-State: AOJu0YyYSQSvsZ7F0rQx8d9dFfieJSGVROMKcd4jUT84LqQPYjjJZ1lh
 e7x6UzDMA/a3NtXnoDk8W2YFydqcSQk6RFwoSjM8ishgyhAPzosbUDpf+oo7eork1wuGSNO23L6
 3rVWEd3pO/0SBPFfTQt+dBhInbzfYZW2epsn/+jGPn4lEAFC6dRMQMfsq
X-Gm-Gg: ASbGncsrtYM3fi9RdZnPKLbdATgg/uv74hcqXuylQoaXhj7QZnv5Q7EYnoDweQH+MH4
 NEKacKrt22+twpQim9oGf0cYMbtAhM7chGTesSTFiuiKcjF3kGyID9H87j7Ew4IU/VARLd3hvbx
 pGTIBBHLG6WN/YWk/vm7WgCk9HkvjHDEwEWELCF7ETo+6zamnjsRwOthQtZbV/x46L5qv/vJhVL
 5SjzT1cu4TDUxBfRDQgE1sT1N48MbCky5VopDCjT7QVaS68TPBj/AIR9T82QuRxYx9SXA9ThDxQ
X-Received: by 2002:a05:6000:430b:b0:3a4:ebf6:49cc with SMTP id
 ffacd0b85a97d-3a4ebf64b1emr6522884f8f.52.1748537296881; 
 Thu, 29 May 2025 09:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5mC6/AWG/sl78XIOKl4xSbsvmbABMTtKhchNqfOgxPFNj8k4MmE6BLo/RpDXl8TwxG80X4g==
X-Received: by 2002:a05:6000:430b:b0:3a4:ebf6:49cc with SMTP id
 ffacd0b85a97d-3a4ebf64b1emr6522871f8f.52.1748537296579; 
 Thu, 29 May 2025 09:48:16 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c866sm2522557f8f.32.2025.05.29.09.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:48:16 -0700 (PDT)
Date: Thu, 29 May 2025 18:48:14 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 09/11] migration/ram: Add tracepoints for
 ram_save_complete()
Message-ID: <mxvyznnlvvtdlhm3d2mdekx7jptlbvrikre2nc76qvodeguyfl@disluob7hl2w>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-10-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025-05-27 17:58, Peter Xu wrote:
> Take notes on start/end state of dirty pages for the whole system.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c        | 5 +++++
>  migration/trace-events | 1 +
>  2 files changed, 6 insertions(+)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


