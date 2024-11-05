Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ACDD3E773
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8RE1-0004Zi-IJ; Tue, 05 Nov 2024 16:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8RE0-0004ZR-4i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:36:32 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8RDy-0001gb-Jm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:36:31 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6e2e3e4f65dso13496347b3.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730842589; x=1731447389; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4wfVOsn32GqzG6pxswvFxXo8voam2CLSZwUERSSj1Ms=;
 b=dCw7GdJDVuhKCjf5D8A5xQbt9c0NDeKflmsRz9O4x9q0lmFFHvt1aCrSgNNQjEkbgf
 08qXV6klKqvbdbAUXCMZ4h4/eOKIDjxfTH9U6gqJRoTLIa3SdKnCNMDQuk5Pq3BrnJSR
 zb39r0jXj/GtBss+hKLDclXdtxg36cWJ5GKsnVwTFGfEG5susNaEBR1yEoWt3FBPqwwp
 O69yMqqtis5fx47+D/JcUzZsQQxcbX0HB4ikFMWXqChgv4mhNybXu6/y31kcVFSP2Z37
 kvN5QoeGUabywPZKj/iFvAzHZwXMeZ5cA/U3N2ufLu5WmqDDpM0aT/MgsBeadcInduJG
 W73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730842589; x=1731447389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wfVOsn32GqzG6pxswvFxXo8voam2CLSZwUERSSj1Ms=;
 b=qAw4diLrYaQrVl0yPv1DtGTB/5yvemdQk6VWzIQE7GJ2e1dB6BpcUqZF+J+67Xf3zD
 c5ZawYHJigffZmlOTHUwmYpO75c1PUOxgXVA0m4GTsiPEbMSeo0fOwodFUEna07azQ+D
 VLDMW6BTaMgWh601BrSOHRtR9NS02SMJHUfNTU9bxk3IH5/RUMN/jkWveCMUJ03l+7Mw
 w6C85HSBqkLpMjGxMO/UWCQ6rPVLDyMtQ31SeuEnnMJ9C1CoQzAKoqod0fDw/j18p73a
 tLz3ScHaAbwo4e7DJnZR7o5Xqv9QCqn5tEwutr7R1b4Brx5RNgpI8BjZfDimdEvWG1qn
 I1Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqbpUfCWKpb9OssBBHVV8U6N5pAMTZ/nfuESxbQ0N8BHtKqy1zUUyf8Jou7f5XEytSCP2oVJ8VYN5p@nongnu.org
X-Gm-Message-State: AOJu0YxzjtKgL78asJVAw12qyZTa2vJFRuzIFwjZnBSNWygtmTMfxvpi
 wjRNebk0vs+lKtzoOgp/y9qbuH7hCViOCYopiGj+nVWq1z1Ga4Vj
X-Google-Smtp-Source: AGHT+IHTcyp+hTCKXTQM8NURjWdb/wybDjQkaoPQbm0ljzs2ehicrb9RiwmQ6/ONHVDLwyN4FwVQIQ==
X-Received: by 2002:a05:690c:7201:b0:652:5838:54ef with SMTP id
 00721157ae682-6e9d8b5144fmr400605567b3.37.1730842589160; 
 Tue, 05 Nov 2024 13:36:29 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ea8d4ba90asm13781577b3.119.2024.11.05.13.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:36:28 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:36:26 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 09/10] hw/cxl: Ensure there is enough data for the
 header in cmd_ccls_set_lsa()
Message-ID: <ZyqP2upw4OqN1k0q@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-10-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-10-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112b.google.com
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

On Fri, Nov 01, 2024 at 01:39:16PM +0000, Jonathan Cameron wrote:
> The properties of the requested set command cannot be established if
> len_in is less than the size of the header.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 078782e8b9..f4a436e172 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1503,8 +1503,8 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>      const size_t hdr_len = offsetof(struct set_lsa_pl, data);
>  
>      *len_out = 0;
> -    if (!len_in) {
> -        return CXL_MBOX_SUCCESS;
> +    if (len_in < hdr_len) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
>  
>      if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
> -- 
> 2.43.0
> 

-- 
Fan Ni

