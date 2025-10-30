Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE40CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEbTB-0006MN-FB; Thu, 30 Oct 2025 18:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEbT9-0006LJ-3L
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEbT3-0001hO-3b
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761864599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iosfWAL+V1qOfFvF0kS6pSNrQ4kSbGXtECMx00qYmtk=;
 b=UJXBWiJxuxQsqF4m2QY1sKb9S5q5ggjtytvmgsgE2fdbUO4VK84A37j1ALNRqr7060kPta
 P70AJnJl6plRm8+0OWHfK81qZGkAag5o5ItWMHbCBM3sJ6s5UcUywi4yJUv38BJdXaCpGm
 1NtMww8N+LnD3XUWMhlTjlzYSQ4PcXw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-z4SQgkeiNJe77Gl5L02H8g-1; Thu, 30 Oct 2025 18:49:56 -0400
X-MC-Unique: z4SQgkeiNJe77Gl5L02H8g-1
X-Mimecast-MFC-AGG-ID: z4SQgkeiNJe77Gl5L02H8g_1761864596
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-87c1f435bd6so41201976d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761864596; x=1762469396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iosfWAL+V1qOfFvF0kS6pSNrQ4kSbGXtECMx00qYmtk=;
 b=poQqfLq+wlIHDvgHS+dUBJ804EGTEMI/oUc89hUOKFFPSGnV6Lb/HWcew2BjrgkF8D
 mfQdl4LTcKS7FnT5LPlpdPTpz6BhJaWg2Mm9fvWj2qr5sJVWTBAVmOJ5qHOoOmt1+8+C
 FgW4n8L3GVbLXWmQP17rM85NkAGbL7MPzfSpi5tTCV8fpYuSWmJEltFqdlTXPSd0KBPl
 xDwuoIVtv9xSHwRd/NBRM1ZgtELuLinT9rwAm0SVp+vOdPlpCEnbDbePju9LuhUjuvUT
 8fgc+il+m0c6+bPJdbLKz9pa78OAiaUHw4faKy5d5t8KPVDnw4kkoRRBSFStb7rCRBeH
 4aXw==
X-Gm-Message-State: AOJu0Yy0n9LdqPCtHRShWFKHU6qplohSniytTzFLevCqh3an4gi94p1O
 VmtqT2R6+uAED2e55doDCprcVvoXosE2+pHVIOG9oKWM75nkO341VGlTS0Kf9js94fMmg3fx0q6
 wyc0mXGzhF+frHlCEirtLDAr2AmYhXWeBLB9qSIbtpMwikAjSvG9s20pk
X-Gm-Gg: ASbGncvBiIPzqsbSagFsHI40mW7+9MW8GE5nP6qHQgDA3lnRiL+QHQ+vCLXI2l0sWPA
 TNeofbJzNCbaz44pbCGBqbnKvuX0wf2gkw9wbdFZxWFLhG1aENWHnzsHIX4nYRTGpn3NWqAoKLX
 cfcZ0rFk3XinCuOm/2JmTwWVK1Pbi4k651PtbS3k1l7von/DgnFf22NJnO6KtMsWPrXdF/oaJ5E
 CvowxlUSrVqWxCgQ6k7Vh7rnnf95YzD3GhJqYhwiy5SzrYTIee3HAvqnhr7gSx7ZasHSPMGzgfe
 8k1nn9Yc6QvmaGTO/UltSUGnpHohOmUoF2Bz7wMTjNFQLFYk/EFJvNv4+YXfwo4AeqA=
X-Received: by 2002:a05:6214:5193:b0:77a:29ba:1b67 with SMTP id
 6a1803df08f44-8802f27625fmr17284536d6.13.1761864596355; 
 Thu, 30 Oct 2025 15:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlyayt+myz88p2IDkSOeRmUbHx1FcMgAVBc/670+TW4DUcJVnc/zmDoIznsyw/dt9ea6GaVw==
X-Received: by 2002:a05:6214:5193:b0:77a:29ba:1b67 with SMTP id
 6a1803df08f44-8802f27625fmr17284396d6.13.1761864595917; 
 Thu, 30 Oct 2025 15:49:55 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88036319a3dsm236266d6.44.2025.10.30.15.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 15:49:55 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:49:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 6/7] migration: Make postcopy listen thread joinable
Message-ID: <aQPrkrbzE1mJZC4R@x1.local>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
 <20251030214915.1411860-7-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030214915.1411860-7-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:49:10PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> This patch makes the listen thread joinable instead detached, and joins
> it alongside other postcopy threads.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


