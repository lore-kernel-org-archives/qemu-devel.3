Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B0E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 05:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMKfi-0001bb-0N; Sat, 14 Dec 2024 00:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMKfg-0001bQ-3y
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:26:32 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMKfc-0003bM-MG
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:26:31 -0500
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-aa6aad76beeso353247266b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 21:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734153987; x=1734758787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SV5o9nKbLA9Jo4o+9PHWgPneN96Qa3r7/XZGbde2RE=;
 b=otLO0NhQqD/sU19FBWVV/mgSEBQMWJ/6oygYvAkoea4DVahJZyaE6bXibQv8LRdgGq
 Nrr5to+OBKyHEdzhoSuyiw5r7GjHEvlLjxiLKeAQN5sK7/QD1WzbtguGjqsOeY+vWQPr
 q0+RYaYwWPi7NZjGdCkTVMBFjDJsg4fYvzSoM6U3H2qWft/zbF/Jhgd+yBFzdW5Xi2L8
 MHDDir66ccZzA3wl0lM/Jjrw4UnGxB1u6pDLzlJuOOIa79zTwgj7MyUOKRTp//19UWjo
 Kl6O08E/Z0Eobdl4p2nKRK8DJX8uC9kChV1nJFLsAyfIqY8d07/ohEG26Y0o4H3okTcV
 kw/w==
X-Gm-Message-State: AOJu0YxN9u4gTe1Y6gnwJfj3HCVN2GkFXvnZTlLRUvuRa1iHXvElHUIw
 tAdANGfksppINhO2KdwtTOQdpL9Aw0rd6E7HcesKhEi/gPyWH83Q
X-Gm-Gg: ASbGncuMiNuhiqeRlWUoL5VwYvXiV2RkTyXal7RQ/wPUVyG7ZQFiIGQEM9erqTOM0Gy
 wLBUofGI+T16O2eJ4zc+8lb/VVdzfW0vveQPsWEpdUkneOJL40Rx1qRAdtyBxj7O7CuXNwoyhGr
 kdJd2qq0GdQteJcUZazXugF8sgqkrCprMRtJqDUbqwM1p43h/54hV3evFU27yedow5aq6k3N9BO
 u3Xr1P0Ga6lTSyWmRRNkKS8N0IHLyZunRK318oSO7+Os9K7pQII7H4CxMgYClJjNxb1zYCqZkvL
X-Google-Smtp-Source: AGHT+IFt6JNv0P+BbvUZb9XnIhGFfy/2Xz3ZnkcrFlEKBAXQMN5gT1ErL+1S8DPLh5UJkDP9Xh3YMw==
X-Received: by 2002:a17:906:7944:b0:aa6:6e04:eef6 with SMTP id
 a640c23a62f3a-aab77f07a24mr571023766b.61.1734153986772; 
 Fri, 13 Dec 2024 21:26:26 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9638ec32sm49594766b.151.2024.12.13.21.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 21:26:26 -0800 (PST)
Date: Sat, 14 Dec 2024 06:26:23 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/34] next-cube: create new next.scsi container
 memory region
Message-ID: <20241214062623.3b717db3@tpx1>
In-Reply-To: <20241212114620.549285-4-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.45; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f45.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Thu, 12 Dec 2024 11:45:49 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move the ESP SCSI and SCSI CSR registers to the new next.scsi container memory
> region.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

